/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\zombie_murderbot.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 642 ms
 * Timestamp: 4/22/2024 2:15:16 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.agent_funcs["zombie_murderbot"] = level.agent_funcs["zombie"];
	level.agent_funcs["zombie_murderbot"]["think"] = ::zombie_murderbot_think;
	level.agent_funcs["zombie_murderbot"]["on_killed"] = ::onmurderbotkilled;
	level.agent_funcs["zombie_murderbot"]["on_damaged"] = ::onmurderbotdamaged;
	var_00[0] = ["murderbot_dlc"];
	var_01 = spawnstruct();
	var_01.agent_type = "zombie_murderbot";
	var_01.animclass = "zombie_murderbot_animclass";
	var_01.model_bodies = var_00;
	var_01.health_scale = 3;
	var_01.meleedamage = 1000;
	maps\mp\zombies\_util::agentclassregister(var_01,"zombie_murderbot");
	level.movemodefunc["zombie_murderbot"] = ::murderbotcalculatemovemode;
	level.moveratescalefunc["zombie_murderbot"] = ::murderbotcalculatemoveratescale;
	level.nonmoveratescalefunc["zombie_murderbot"] = ::murderbotcalculatenonmoveratescale;
	level.traverseratescalefunc["zombie_murderbot"] = ::murderbotcalculatetraverseratescale;
	level._effect["murderbot_eyes"] = loadfx("vfx/gameplay/mp/zombie/murderbot_eyes");
	level._effect["murderbot_melee_sparks"] = loadfx("vfx/trail/dlc_murderbot_melee_sparks");
	level._effect["murderbot_deactivation"] = loadfx("vfx/map/mp_zombie_brg/dlc_murderbot_deactivation");
}

//Function Number: 2
kill_random_zombies(param_00)
{
	wait 0.05;
	var_01 = sortbydistance(level.agentarray,param_00);
	var_02 = var_01.size - 1;
	var_03 = 0;
	for(var_02 = var_01.size - 1;var_02 >= 0;var_02--)
	{
		var_04 = var_01[var_02];
		if(!isdefined(var_04) || !isdefined(var_04.agent_type) || var_04.agent_type == "zombie_melee_goliath" || var_04.agent_type == "zombie_murderbot")
		{
			continue;
		}

		if(isplayer(var_04))
		{
			continue;
		}

		var_04 suicide();
		var_03++;
		if(var_03 >= 2)
		{
			break;
		}
	}
}

//Function Number: 3
spawnmurderbot(param_00,param_01,param_02)
{
	level endon("zombie_wave_interrupt");
	var_03 = maps\mp\zombies\_util::agentclassget("zombie_murderbot");
	param_00.script_animation = "activation";
	param_00.script_ghettotag = "ignoreRealign";
	thread kill_random_zombies(param_00.origin);
	var_04 = maps\mp\zombies\_util::spawnscriptagent(param_00,var_03,level.playerteam);
	if(!isdefined(var_04))
	{
		return;
	}

	param_01 hide();
	param_02 hide();
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("murderbot_eyes"),var_04,"tag_eye");
	var_04 maps\mp\agents\_agent_common::set_agent_health(var_03.roundhealth);
	var_04.meleedamage = var_03.meleedamage;
	var_04 maps\mp\zombies\_util::zombies_make_objective("compass_objpoint_ammo_friendly");
	var_04.hastraversed = 1;
	var_04 attachmurderbotweapons();
	var_04 thread lifetimemonitor();
	var_04 thread killenemymonitor();
	var_04 scragentsetspecies("civilian");
	return var_04;
}

//Function Number: 4
lifetimemonitor()
{
	level endon("game_ended");
	self endon("death");
	while(isdefined(self.inspawnanim) && self.inspawnanim)
	{
		wait 0.05;
	}

	var_00 = gettime() + 120000;
	while(gettime() < var_00)
	{
		wait 0.05;
	}

	while(self.aistate == "traverse" || self.aistate == "melee")
	{
		wait 0.05;
	}

	self scragentsetscripted(1);
	wait 0.05;
	maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe("deactivation",0,"scripted_anim");
	self playsound("zmb_murderbot_death_destruct");
	self suicide();
}

//Function Number: 5
killenemymonitor()
{
	level endon("game_ended");
	self endon("death");
	self.killarray = [];
	for(;;)
	{
		if(self.killarray.size > 0)
		{
			foreach(var_01 in self.killarray)
			{
				collidewithagent(var_01["enemy"],var_01["direction"]);
				if(!isalive(var_01["enemy"]))
				{
					foreach(var_03 in level.players)
					{
						var_03 maps\mp\gametypes\zombies::givepointsforevent(var_01["event"]);
					}
				}
			}

			self.killarray = [];
		}

		wait 0.05;
	}
}

//Function Number: 6
attachmurderbotweapons()
{
	var_00[0] = "dlc_melee_speaker";
	var_01 = spawn("script_model",self gettagorigin("TAG_WEAPON_RIGHT"));
	var_01.angles = self gettagangles("TAG_WEAPON_RIGHT");
	var_02 = randomint(var_00.size);
	var_01 setmodel(var_00[var_02]);
	var_01 linkto(self,"TAG_WEAPON_RIGHT",(0,0,0),(0,0,0));
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("murderbot_melee_sparks"),var_01,"tag_sparks");
	self.murderbotweapon = var_01;
}

//Function Number: 7
setupmurderbotstate()
{
	self.attackzheight = 54;
	self.attackzheightdown = -64;
	self.damagedradiussq = 2250000;
	self.ignoreclosefoliage = 1;
	self.moveratescale = 1;
	self.nonmoveratescale = 1;
	self.traverseratescale = 1;
	self.bhasbadpath = 0;
	self.bhasnopath = 1;
	self.timeoflastdamage = 0;
	self.allowcrouch = 1;
	self.meleecheckheight = 40;
	self.meleeradiusbase = 60;
	self.meleeradiusbasesq = squared(self.meleeradiusbase);
	self.defaultgoalradius = self.radius + 1;
	self scragentsetgoalradius(self.defaultgoalradius);
	self.meleedot = 0.5;
	maps\mp\agents\humanoid\_humanoid_util::lungemeleeupdate(1,self.meleeradiusbase * 2,self.meleeradiusbase * 1.5,"attack_lunge_boost",level._effect["boost_lunge"]);
	maps\mp\agents\humanoid\_humanoid_util::lungemeleeenable();
	self.animcbs.onenter["melee"] = ::murderbot_melee;
	self.boostfxtag = "no_boost_fx";
	self.traversecost = 50;
	self.lungeattackready = 1;
	self.lungelast = 0;
}

//Function Number: 8
zombie_murderbot_think()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
	setupmurderbotstate();
	thread maps\mp\zombies\_zombies::zombieaimonitorthreads();
	thread maps\mp\zombies\_util::waitforbadpath();
	thread maps\mp\zombies\zombie_generic::zombie_generic_moan();
	thread maps\mp\zombies\zombie_generic::zombie_audio_monitor();
	thread maps\mp\zombies\_zombies::updatebuffs();
	thread maps\mp\zombies\_zombies::updatepainsensor();
	thread updatemurderbotlungecooldown();
	for(;;)
	{
		if(isdefined(self.isscripted))
		{
			wait(0.05);
			continue;
		}

		if(self.aistate == "traverse")
		{
			wait(0.05);
			continue;
		}

		if(murderbot_do_sync_attack())
		{
			wait(0.05);
			continue;
		}

		if(murderbot_begin_melee())
		{
			wait(0.05);
			continue;
		}

		if(maps\mp\zombies\_behavior::humanoid_seek_enemy_melee())
		{
			wait(0.05);
			continue;
		}

		if(maps\mp\zombies\_behavior::humanoid_seek_enemies_all_known())
		{
			wait(0.05);
			continue;
		}

		maps\mp\zombies\_behavior::humanoid_seek_random_loc();
		wait(0.05);
	}
}

//Function Number: 9
murderbot_do_sync_attack()
{
	if(!canbeginmelee())
	{
		return 0;
	}

	if(isdefined(self.curmeleetarget.agent_type) && self.curmeleetarget.agent_type == "zombie_melee_goliath")
	{
		if(self.curmeleetarget.aistate == "traverse")
		{
			return 0;
		}

		if(distancesquared(self.origin,self.curmeleetarget.origin) < 40000)
		{
			murderbotmeleegoliathattack(self.curmeleetarget);
			return 1;
		}
	}

	return 0;
}

//Function Number: 10
canbeginmelee()
{
	if(self.ignoreall)
	{
		return 0;
	}

	if(!isdefined(self.curmeleetarget))
	{
		return 0;
	}

	if(self.aistate == "melee" || maps\mp\agents\_scripted_agent_anim_util::isstatelocked())
	{
		return 0;
	}

	if(!maps\mp\zombies\_util::has_entered_game())
	{
		return 0;
	}

	if(maps\mp\agents\humanoid\_humanoid::wanttoattacktargetbutcant())
	{
		return 0;
	}

	if(maps\mp\agents\humanoid\_humanoid::didpastmeleefail())
	{
		return 0;
	}

	return 1;
}

//Function Number: 11
murderbot_begin_melee()
{
	if(!canbeginmelee())
	{
		return 0;
	}

	var_00 = maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && isdefined(self.lungelast) && gettime() - self.lungelast <= self.lungedebouncems;
	if(maps\mp\agents\humanoid\_humanoid::didpastlungemeleefail() || var_00)
	{
		if(!murderbotreadytomeleetarget("base"))
		{
			return 0;
		}
	}
	else if(!murderbotreadytomeleetarget("normal"))
	{
		return 0;
	}

	if(isdefined(self.meleedebouncetime))
	{
		var_01 = gettime() - self.lastmeleefinishtime;
		if(var_01 < self.meleedebouncetime * 1000)
		{
			return 0;
		}
	}

	if(isdefined(self.lastmeleepos))
	{
		var_02 = distancesquared(self.lastmeleepos,self.origin);
	}

	if(!isdefined(self.lastmeleepos) || distancesquared(self.lastmeleepos,self.origin) > 256)
	{
		self.meleemovemode = self.movemode;
	}

	self scragentbeginmelee(self.curmeleetarget);
	return 1;
}

//Function Number: 12
murderbotreadytomeleetarget(param_00)
{
	if(!isdefined(self.curmeleetarget))
	{
		return 0;
	}

	if(!maps\mp\_utility::isreallyalive(self.curmeleetarget))
	{
		return 0;
	}

	if(self.aistate == "traverse")
	{
		return 0;
	}

	if(!maps\mp\agents\humanoid\_humanoid_util::isentstandingonme(self.curmeleetarget))
	{
		if(!maps\mp\agents\humanoid\_humanoid::iswithinattackheight(self.curmeleetarget.origin))
		{
			return 0;
		}
	}

	if(distancesquared(self.origin,self.curmeleetarget.origin) > squared(250))
	{
		return 0;
	}

	if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked())
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
murderbot_melee()
{
	self endon("death");
	self endon("killanimscript");
	self.curmeleetarget endon("disconnect");
	var_00 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);
	if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked())
	{
		return maps\mp\agents\humanoid\_humanoid_melee::meleefailed();
	}

	if(maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && var_00.valid)
	{
		if(isdefined(self.meleemovemode) && self.lungeattackready)
		{
			var_01 = maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint(self.origin,var_00.origin);
			if(var_01)
			{
				self.lungelast = gettime();
				murderbotattacklunge(self.curmeleetarget,var_00.origin);
				return;
			}
		}
	}

	murderbotattackstandard(self.curmeleetarget,var_00.origin);
}

//Function Number: 14
murderbotmeleegoliathattack(param_00)
{
	param_00 scragentsetscripted(1);
	param_00 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"SynchronizedAnim");
	param_00 scragentsetphysicsmode("noclip");
	self scragentsetscripted(1);
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"SynchronizedAnim");
	self scragentsetphysicsmode("noclip");
	param_00 scragentsynchronizeanims(0.5,0.1,self,"tag_sync","tag_sync");
	param_00.deathanimstateoverride = "death_by_murderbot";
	thread playmurderbotimpactfx(param_00);
	thread maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe("murderbot_kills_goliath",0,"scripted_anim");
	param_00 maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe("murderbot_kills_goliath",0,"scripted_anim","death_gib");
	killgoliath(param_00,10000000,"MOD_MELEE","kill_head");
	maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("scripted_anim","end");
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"SynchronizedAnim");
	self scragentsetscripted(0);
}

//Function Number: 15
playmurderbotimpactfx(param_00)
{
	for(;;)
	{
		param_00 waittill("scripted_anim",var_01);
		if(var_01 == "end")
		{
			break;
		}

		switch(var_01)
		{
			case "fx_hit":
				maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("gib_full_body"),param_00,"J_Spine4");
				break;
		}
	}
}

//Function Number: 16
killgoliath(param_00,param_01,param_02,param_03)
{
	maps\mp\agents\humanoid\_humanoid_melee::domeleedamage(param_00,param_01,param_02);
	if(!isalive(param_00))
	{
		foreach(var_05 in level.players)
		{
			var_05 maps\mp\gametypes\zombies::givepointsforevent(param_03);
		}
	}
}

//Function Number: 17
killenemy(param_00,param_01)
{
	var_02 = vectornormalize(self.origin - param_00.origin * (1,1,0));
	var_03["enemy"] = param_00;
	var_03["direction"] = var_02;
	var_03["event"] = param_01;
	self.killarray[self.killarray.size] = var_03;
}

//Function Number: 18
murderbotattackstandard(param_00,param_01)
{
	if(isdefined(self.meleemovemode))
	{
		var_02 = "attack_" + self.meleemovemode;
		self.meleemovemode = undefined;
		murderbotdoattack(param_00,param_01,var_02,1,1,1.5);
		return;
	}

	murderbotdoattack(param_00,param_01,"attack_stand",0,0,1.5);
}

//Function Number: 19
murderbotattacklunge(param_00,param_01)
{
	murderbotdoattack(param_00,param_01,self.lungeanimstate,1,1,1.25);
}

//Function Number: 20
murderbotdoattack(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.lastmeleefailedmypos = undefined;
	self.lastmeleefailedpos = undefined;
	var_06 = randomint(self getanimentrycount(param_02));
	var_07 = self getanimentry(param_02,var_06);
	var_08 = getanimlength(var_07);
	var_09 = getnotetracktimes(var_07,"hit");
	var_0A = getnotetracktimes(var_07,"hit_right");
	var_0B = gethittime(var_08,param_05,var_09,var_0A);
	self scragentsetphysicsmode("gravity");
	if(param_04)
	{
		self scragentsetorientmode("face enemy");
	}
	else
	{
		self scragentsetorientmode("face angle abs",(0,vectortoyaw(param_00.origin - self.origin),0));
	}

	self scragentsetanimmode("anim deltas");
	maps\mp\agents\_scripted_agent_anim_util::set_anim_state(param_02,var_06,param_05);
	var_0C = undefined;
	if(param_03 && param_02 != "attack_lunge_boost")
	{
		var_0C = 100;
	}

	if(param_03)
	{
		self scragentsetanimscale(0,1);
		self scragentdoanimlerp(self.origin,param_01,var_0B);
		childthread updatemurderbotlerppos(param_00,var_0B,1,var_0C);
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"DoAttack");
	}
	else
	{
		self scragentsetanimscale(1,1);
	}

	updatemeleesweeper(var_07,var_08,param_05,var_09);
	updatemeleesweeper(var_07,var_08,param_05,var_0A,self.murderbotweapon);
	wait(var_0B);
	self notify("cancel_updatelerppos");
	self scragentsetanimmode("anim deltas");
	self scragentsetanimscale(1,1);
	if(param_03)
	{
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoAttack");
	}

	self.lastmeleepos = self.origin;
	var_0D = var_08 / param_05 - var_0B;
	if(var_0D > 0)
	{
		maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("attack_anim","end",var_0D);
	}

	self notify("cancel_updatelerppos");
	self scragentsetanimmode("anim deltas");
	self scragentsetanimscale(1,1);
	if(param_03)
	{
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoAttack");
	}

	if(param_02 == "attack_lunge_boost")
	{
		self.lastlungelocation = self.origin;
		self.lungeattackready = 0;
	}

	self.lastmeleefinishtime = gettime();
}

//Function Number: 21
gethittime(param_00,param_01,param_02,param_03)
{
	if(param_02.size <= 0 && param_03.size <= 0)
	{
		return param_00 / param_01 * 0.33;
	}

	var_04 = 1;
	if(isdefined(param_02) && param_02.size > 0)
	{
		var_04 = param_00 / param_01 * param_02[0];
	}

	var_05 = 1;
	if(isdefined(param_03) && param_03.size > 0)
	{
		var_05 = param_00 / param_01 * param_03[0];
	}

	return min(var_04,var_05);
}

//Function Number: 22
updatemurderbotlerppos(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self endon("death");
	self endon("cancel_updatelerppos");
	param_00 endon("disconnect");
	param_00 endon("death");
	var_04 = self.origin;
	var_05 = param_01;
	var_06 = 0.05;
	for(;;)
	{
		wait(var_06);
		var_05 = var_05 - var_06;
		if(var_05 <= 0)
		{
			break;
		}

		var_07 = maps\mp\agents\humanoid\_humanoid_melee::getupdatedattackpos(param_00,param_02);
		if(!isdefined(var_07))
		{
			break;
		}

		if(isdefined(param_03))
		{
			var_08 = param_03;
			var_09 = var_07 - var_04;
			if(lengthsquared(var_09) > var_08 * var_08)
			{
				var_07 = var_04 + vectornormalize(var_09) * var_08;
			}
		}

		self scragentsetorientmode("face enemy");
		self scragentdoanimlerp(self.origin,var_07,var_05);
	}
}

//Function Number: 23
updatemeleesweeper(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	level endon("game_ended");
	if(param_03.size == 0)
	{
		return;
	}

	if(common_scripts\utility::mod(param_03.size,2) != 0)
	{
	}

	var_05 = param_01 / param_02 * param_03[0];
	var_06 = param_01 / param_02 * param_03[1];
	var_07 = 0;
	var_08 = 0.05;
	self.hitzombies = [];
	wait(var_05);
	var_09 = var_06 - var_05;
	while(var_07 <= var_09)
	{
		wait(var_08);
		var_07 = var_07 + var_08;
		checkmeleesweeperhit(param_04);
	}
}

//Function Number: 24
getzombiesinrange(param_00)
{
	var_01 = [];
	var_02 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	var_03 = param_00 * param_00;
	foreach(var_05 in var_02)
	{
		if(isdefined(var_05.agentteam) && var_05.agentteam == level.playerteam)
		{
			continue;
		}

		if(distancesquared(var_05.origin,self.origin) > var_03)
		{
			continue;
		}

		var_01[var_01.size] = var_05;
	}

	return var_01;
}

//Function Number: 25
checkmeleesweeperhit(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00))
	{
		var_01 = param_00 gettagorigin("tag_fx");
	}
	else
	{
		var_01 = self gettagorigin("TAG_WEAPON_LEFT");
	}

	var_02 = var_01 - self.origin * (1,1,0);
	var_03 = squared(length(var_02) + 40);
	var_04 = self.murderbotweapon gettagangles("tag_fx");
	var_05 = getzombiesinrange(256);
	foreach(var_07 in var_05)
	{
		if(!isdefined(var_07) || !isalive(var_07) || var_07 == self)
		{
			continue;
		}

		if(isdefined(var_07.agent_type) && var_07.agent_type == "zombie_melee_goliath")
		{
			continue;
		}

		if(common_scripts\utility::array_contains(self.hitzombies,var_07))
		{
			continue;
		}

		if(!checkmeleeheight(var_07,var_01[2]))
		{
			continue;
		}

		var_08 = var_07.origin - self.origin * (1,1,0);
		var_09 = lengthsquared(var_08);
		if(var_09 > var_03)
		{
			continue;
		}

		if(vectordot(var_08,var_02) < 0.707)
		{
			continue;
		}

		killenemy(var_07,"kill_trap");
		self.hitzombies[self.hitzombies.size] = var_07;
	}
}

//Function Number: 26
checkmeleeheight(param_00,param_01)
{
	var_02 = self.origin[2] + 80;
	var_03 = max(var_02,param_01);
	var_04 = self.origin[2] - 30;
	var_05 = param_00 geteye()[2] + 30;
	var_06 = param_00.origin[2];
	if(var_05 >= var_04 && var_05 <= var_03)
	{
		return 1;
	}

	if(var_06 >= var_04 && var_06 <= var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
murderbotcalculatemovemode()
{
	return "run";
}

//Function Number: 28
murderbotcalculatemoveratescale()
{
	return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

//Function Number: 29
murderbotcalculatenonmoveratescale()
{
	return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

//Function Number: 30
murderbotcalculatetraverseratescale()
{
	return 1 * maps\mp\zombies\_zombies::getbuffspeedmultiplier();
}

//Function Number: 31
updatemurderbotlungecooldown()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0.05;
	for(;;)
	{
		wait(var_00);
		if(!isdefined(self.lastlungelocation) || !isdefined(self.curmeleetarget))
		{
			continue;
		}

		var_01 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);
		if(!isdefined(var_01.origin))
		{
			continue;
		}

		var_02 = length(var_01.origin - self.lastlungelocation);
		if(var_02 < 250)
		{
			continue;
		}

		self.lungeattackready = 1;
	}
}

//Function Number: 32
onmurderbotkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self.bypasscorpse = 1;
	maps\mp\zombies\_zombies::onzombiekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	self.murderbotweapon delete();
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("murderbot_deactivation"),self,"J_Spine4");
	earthquake(0.35,0.95,self.origin,128);
	playfx(common_scripts\utility::getfx("nuke_blast"),self.origin,anglestoforward(self.angles),(0,0,1));
	level thread maps\mp\gametypes\zombies::activatenukepickup(self.origin);
	spawnpickups(self.origin);
}

//Function Number: 33
spawnpickups(param_00)
{
	var_01 = getnodesinradiussorted(param_00,300,100,128);
	var_02 = ["ammo","insta_kill","double_points","fire_sale"];
	for(var_03 = 0;var_03 < var_02.size && var_03 < var_01.size;var_03++)
	{
		maps\mp\gametypes\zombies::createpickup(var_02[var_03],var_01[var_03].origin);
	}
}

//Function Number: 34
onmurderbotdamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
}

//Function Number: 35
drawdebug()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(0.05);
		if(isdefined(self.curmeleetarget))
		{
		}

		if(isdefined(self.curmeleetarget))
		{
			var_00 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);
			if(isdefined(var_00) && isdefined(var_00.origin))
			{
			}
		}
	}
}

//Function Number: 36
collidewithagent(param_00,param_01)
{
	if(randomfloat(1) < 0.5)
	{
		ragdollagent(param_00,param_01,"MOD_EXPLOSIVE",2,3);
		return;
	}

	ragdollagent(param_00,param_01,"MOD_MELEE",3,5);
}

//Function Number: 37
ragdollagent(param_00,param_01,param_02,param_03,param_04)
{
	param_00.ragdollimmediately = 1;
	param_00 dodamage(param_00.health + 1000,param_00 geteye(),self,undefined,param_02,"murderbotFriendlyFire","none");
	var_05 = self.origin - param_01 + (0,0,8);
	wait(0.1);
	var_06 = randomfloatrange(3,5);
	physicsexplosionsphere(var_05,128,0,var_06,0);
}

//Function Number: 38
updateenemyvisibility()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(0.5);
		if(!isdefined(self.enemy))
		{
			continue;
		}

		self.haslostoenemy = sighttracepassed(self geteye(),self.enemy geteye(),0,self);
	}
}

//Function Number: 39
calculate_threat_level(param_00)
{
	var_01 = 0;
	var_02[0] = ::evaluate_threat_valid_threat;
	var_02[1] = ::evaluate_threat_range;
	var_02[2] = ::evaluate_threat_los;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = self [[ var_02[var_03] ]](param_00);
		if(var_04 < 0)
		{
			return -1;
		}

		var_01 = var_01 + var_04;
	}

	return var_01 / var_02.size;
}

//Function Number: 40
evaluate_threat_valid_threat(param_00)
{
	if(!isdefined(param_00) || !isalive(param_00))
	{
		return -1;
	}

	if(isdefined(param_00.ignoreme) && param_00.ignoreme == 1)
	{
		return -1;
	}

	return 1;
}

//Function Number: 41
evaluate_threat_range(param_00)
{
	var_01 = length(param_00.origin - self.origin);
	var_02 = max(1 - var_01 / 1500,0);
	return var_02;
}

//Function Number: 42
evaluate_threat_los(param_00)
{
	return -1;
}

//Function Number: 43
trace_to_enemy(param_00,param_01,param_02)
{
	var_03 = bullettrace(param_00,param_01 geteye(),0,self.murderbotshield,0,0,0,0,0);
	return var_03["fraction"] == 1;
}