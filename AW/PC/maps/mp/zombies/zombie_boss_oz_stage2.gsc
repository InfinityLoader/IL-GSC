/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\zombie_boss_oz_stage2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 87
 * Decompile Time: 1492 ms
 * Timestamp: 4/22/2024 2:15:06 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.agent_funcs["zombie_boss_oz_stage2"] = level.agent_funcs["zombie"];
	level.agent_funcs["zombie_boss_oz_stage2"]["think"] = ::zombie_boss_oz_stage2_think;
	level.agent_funcs["zombie_boss_oz_stage2"]["on_killed"] = ::onbossozstage2killed;
	level.agent_funcs["zombie_boss_oz_stage2"]["spawn"] = ::onzombiebossozstage2spawn;
	var_00[0] = ["zom_oz_boss_stage2"];
	var_01 = spawnstruct();
	var_01.agent_type = "zombie_boss_oz_stage2";
	var_01.animclass = "zombie_boss_oz_stage2_animclass";
	var_01.model_bodies = var_00;
	var_01.health_scale = 45;
	var_01.meleedamage = 250;
	var_01.damagescalevssquadmates = 1.5;
	var_01.spawnparameter = "zombie_boss_oz_stage2";
	maps\mp\zombies\_util::agentclassregister(var_01,"zombie_boss_oz_stage2");
	level.runwavefunc["zombie_boss_oz_stage2"] = ::bossozstage2runwave;
	level.mutatorfunc["zombie_boss_oz_stage2"] = ::bossozstage2postspawn;
	level.movemodefunc["zombie_boss_oz_stage2"] = ::bossozstage2calculatemovemode;
	level.moveratescalefunc["zombie_boss_oz_stage2"] = ::bossozstage2calculatemoveratescale;
	level.nonmoveratescalefunc["zombie_boss_oz_stage2"] = ::bossozstage2calculatenonmoveratescale;
	level.traverseratescalefunc["zombie_boss_oz_stage2"] = ::bossozstage2calculatetraverseratescale;
	level.candroppickupsfunc["zombie_boss_oz_stage2"] = ::bossozstage2roundcandroppickups;
	level.trycalculatesectororigin["zombie_boss_oz_stage2"] = ::bossozstage2trycalculatesectororigin;
	level.getradiusandheight["zombie_boss_oz_stage2"] = ::bossozstage2getradiusandheight;
	level.roundspawndelayfunc["zombie_boss_oz_stage2"] = ::bossozstage2getzombiespawndelay;
	level.hostcurefuncoverride["zombie_boss_oz_stage2"] = ::bossozstage2curestationactivated;
	level.modifydamagebyagenttype["zombie_boss_oz_stage2"] = ::bossozstage2modifydamage;
	level.modifyequipmentdamagebyagenttype["zombie_boss_oz_stage2"] = ::bossozstage2modifyplayerequipmentdamage;
	level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_fusionzm_mp"] = ::bossozstage2modifycauterizerdamage;
	level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_rhinozm_mp"] = ::bossozstage2modifys12damage;
	level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_linegunzm_mp"] = ::bossozstage2modifylinegundamage;
	level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_mahemzm_mp"] = ::bossozstage2modifymahemdamage;
	level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_gm6zm_mp"] = ::bossozstage2modifylynxdamage;
	level.modifyweapondamagebyagenttype["zombie_boss_oz_stage2"]["iw5_tridentzm_mp"] = ::bossozstage2modifytridentdamage;
	level._effect["oz_stage2_teleport"] = loadfx("vfx/unique/dlc_teleport_soldier_bad");
	level._effect["zombie_boss_oz_stage2_emp"] = loadfx("vfx/explosion/emp_grenade_lrg_mp");
	level._effect["oz_stage2_destroy_pillar"] = loadfx("vfx/map/lagos/lag_roundabout_tanker_explosion");
	level._effect["zombie_eye_boss_oz"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_boss_oz");
	level._effect["zombie_eye_boss_oz_fade"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_boss_oz_fade");
	level._effect["oz_stage2_blood_spit_death"] = loadfx("vfx/map/mp_zombie_h2o/h2o_boss_blood_spit");
	level._effect["oz_stage2_blood_spit_loop"] = loadfx("vfx/map/mp_zombie_h2o/h2o_boss_blood_spit_lp");
	createthreatbiasgroup("zombie_boss_oz_stage2");
	createthreatbiasgroup("non_infected_players");
	createthreatbiasgroup("infected_players");
	setignoremegroup("zombie_boss_oz_stage2","infected_players");
	setignoremegroup("infected_players","zombie_boss_oz_stage2");
}

//Function Number: 2
bossozstage2getzombiespawndelay(param_00,param_01)
{
	var_02 = 12;
	var_03 = [1,0.75,0.66,0.5];
	var_04 = int(clamp(maps\mp\zombies\_util::getnumplayers() - 1,0,3));
	var_05 = var_03[var_04];
	var_06 = maps\mp\zombies\_util::lerp(level.bossozstage2.health / level.bossozstage2.maxhealth,0.5,1);
	var_07 = var_02 * var_05 * var_06;
	return var_07;
}

//Function Number: 3
bossozstage2runwave(param_00)
{
	level endon("game_ended");
	level endon("zombie_wave_interrupt");
	maps\mp\zombies\zombie_boss_oz::initpillars();
	thread maps\mp\mp_zombie_h2o_aud::sndbossozstartstage2();
	level.zombie_spawning_active = 1;
	level.zombie_wave_running = 1;
	wait(2);
	level.totalaispawned = 0;
	level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount();
	level.bossozstage2 = maps\mp\zombies\zombies_spawn_manager::spawnzombietype("zombie_boss_oz_stage2",undefined,undefined,"zombie_eye_boss_oz");
	level.bossozstage2 playsound("zmb_gol_round_start_front");
	wait(2);
	level thread maps\mp\zombies\zombie_boss_oz::zmbaudioplayervo("oz2",0);
	level.bossozstage2 waittill("death");
	level notify("boss_oz_killed");
	level notify("stop_all_boss_traps");
	wait(5);
	level notify("zombie_stop_spawning");
	level notify("zombie_boss_wave_ended");
	level notify("zombie_boss_stage2_ended");
	level waittill("zombie_wave_ended");
	level.zombie_wave_running = 0;
}

//Function Number: 4
bossozstage2disableai()
{
	self.disablemissile = 1;
	self.ignoreall = 1;
	self.ignoreme = 1;
}

//Function Number: 5
bossozstage2enableai()
{
	self.disablemissile = 0;
	self.ignoreall = 0;
	self.ignoreme = 0;
}

//Function Number: 6
bossozstage2teleportout()
{
	self.inpain = 0;
	self.incurestationstun = 0;
	playfx(common_scripts\utility::getfx("oz_stage2_teleport"),self.origin,(1,0,0),(0,0,1));
	bossozstage2disableai();
	self hide();
	self scragentsetphysicsmode("noclip");
	var_00 = common_scripts\utility::getstructarray("boss_oz_spot","targetname");
	self setorigin(var_00[0].origin,1);
	self scragentsetgoalpos(self.origin);
}

//Function Number: 7
bossozstage2teleportbackin(param_00)
{
	maps\mp\zombies\_util::waittillzombiegameunpaused();
	var_01 = maps\mp\zombies\zombie_boss_oz::getrandomactivepillar();
	var_02 = var_01;
	playfx(common_scripts\utility::getfx("oz_stage2_destroy_pillar"),var_01.origin);
	var_01 maps\mp\zombies\zombie_boss_oz::destroypillar();
	playsoundatpos(var_01.origin,"oz_s1_location_destroyed");
	earthquake(0.6,1,var_01.origin,10000);
	wait(0.5);
	self setorigin(var_02.origin,1);
	var_03 = common_scripts\utility::random(level.players);
	var_04 = vectortoangles(var_03.origin - var_02.origin);
	self setplayerangles(var_04);
	self.angles = var_04;
	self scragentsetorientmode("face angle abs",(0,var_04[1],0));
	playfx(common_scripts\utility::getfx("oz_stage2_teleport"),var_02.origin,(1,0,0),(0,0,1));
	self scragentsetgoalpos(var_02.origin);
	self playsound("zmb_gol_round_start_front");
	self show();
	self scragentsetphysicsmode("gravity");
	wait(0.05);
	bossozstage2startfx();
	var_05 = "teleport_in";
	if(isdefined(param_00))
	{
		var_05 = param_00;
	}

	bossozstage2playscriptedanim(var_05,var_04);
	bossozstage2enableai();
	self.godmode = 0;
}

//Function Number: 8
bossozstage2playscriptedanim(param_00,param_01)
{
	self scragentsetscripted(1);
	self scragentsetanimmode("anim deltas");
	if(isdefined(param_01))
	{
		self scragentsetorientmode("face angle abs",(0,param_01[1],0));
	}
	else
	{
		self scragentsetorientmode("face angle abs",(0,self.angles[1],0));
	}

	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"OzS2Scripted");
	maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe(param_00,0,1,"scripted_anim");
	self scragentsetscripted(0);
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"OzS2Scripted");
}

//Function Number: 9
bossozstage2startfx()
{
	maps\mp\zombies\_util::zombie_set_eyes("zombie_eye_boss_oz");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("oz_stage2_blood_spit_loop"),self,"J_Head");
}

//Function Number: 10
bossozstage2_100percentsequence()
{
	bossozstage2_enableinvulnerability();
	var_00 = vectortoangles(level.bossozstage2roomcenter - self.origin);
	wait(0.5);
	self.threats = level.players;
	updateweaponfiring();
	bossozstage2playscriptedanim("spawn",var_00);
	bossozstage2_enableinvulnerability();
	bossozstage2teleportout();
	wait(7.5);
	bossozstage2teleportbackin();
	self.playedsequence[100] = 1;
}

//Function Number: 11
bossozstage2_75percentsequence()
{
	bossozstage2_enableinvulnerability();
	self notify("cancel_stun");
	bossozstage2waituntiloutofcurestationstun();
	bossozstage2disableai();
	self playsound("zmb_gol_round_start_front");
	bossozstage2playscriptedanim("teleport_out");
	bossozstage2teleportout();
	bossozspawnintermissionzombies();
	bossozstage2_waitforintermissionzombiesortimeout(35);
	bossozstage2teleportbackin();
	self.playedsequence[75] = 1;
	foreach(var_01 in level.players)
	{
		var_01 thread maps\mp\_matchdata::loggameevent("zm_boss_phase1",var_01.origin);
	}

	wait(1);
}

//Function Number: 12
bossozstage2_50percentsequence()
{
	bossozstage2_enableinvulnerability();
	self notify("cancel_stun");
	bossozstage2waituntiloutofcurestationstun();
	bossozstage2disableai();
	self playsound("zmb_gol_round_start_front");
	bossozstage2playscriptedanim("teleport_out");
	bossozstage2teleportout();
	bossozstage2startinvalidationtrap("gas",5,9999);
	bossozspawnintermissionzombies();
	bossozstage2_waitforintermissionzombiesortimeout(35);
	bossozstage2teleportbackin("taunt");
	self.playedsequence[50] = 1;
	foreach(var_01 in level.players)
	{
		var_01 thread maps\mp\_matchdata::loggameevent("zm_boss_phase2",var_01.origin);
	}

	wait(1);
	maps\mp\zombies\zombie_boss_oz::startinfinitezombiespawning();
}

//Function Number: 13
bossozstage2_25percentsequence()
{
	bossozstage2_enableinvulnerability();
	self notify("cancel_stun");
	bossozstage2waituntiloutofcurestationstun();
	bossozstage2disableai();
	self playsound("zmb_gol_round_start_front");
	bossozstage2playscriptedanim("teleport_out");
	bossozstage2teleportout();
	bossozstage2startinvalidationtrap("aerial_lasers",5,9999);
	bossozspawnintermissionzombies();
	bossozstage2_waitforintermissionzombiesortimeout(35);
	bossozstage2teleportbackin();
	self.playedsequence[25] = 1;
	foreach(var_01 in level.players)
	{
		var_01 thread maps\mp\_matchdata::loggameevent("zm_boss_phase3",var_01.origin);
	}

	wait(1);
}

//Function Number: 14
bossozstage2_enableinvulnerability()
{
	self.godmode = 1;
	setomnvar("ui_zm_fight_shield",1);
}

//Function Number: 15
bossozspawnintermissionzombies()
{
	var_00 = 1;
	if(var_00)
	{
		var_01["limitedSpawns"] = 1;
		var_01["forceSpawnDelay"] = 1;
		var_01["notifyWhenFinished"] = "finished_intermission_zombies";
		level childthread maps\mp\zombies\zombies_spawn_manager::spawnzombies(6 * maps\mp\zombies\_util::getnumplayers(),4 / maps\mp\zombies\_util::getnumplayers(),var_01);
	}
}

//Function Number: 16
bossozstage2_waitforintermissionzombies()
{
	level endon("cancel_intermission_zombies");
	level waittill("finished_intermission_zombies");
	while(maps\mp\zombies\zombies_spawn_manager::zombiesarealive("zombie_generic"))
	{
		wait 0.05;
	}

	level notify("cancel_intermission_zombies");
}

//Function Number: 17
bossozstage2_waitforintermissionzombiesortimeout(param_00)
{
	level endon("cancel_intermission_zombies");
	level thread bossozstage2_waitforintermissionzombies();
	wait(param_00);
	level notify("cancel_intermission_zombies");
}

//Function Number: 18
bossozstage2roundcandroppickups(param_00)
{
	return 0;
}

//Function Number: 19
onzombiebossozstage2spawn(param_00,param_01,param_02)
{
	maps\mp\zombies\_util::onspawnscriptagenthumanoid(param_00,param_01,param_02);
	playfx(common_scripts\utility::getfx("oz_stage2_teleport"),param_00,(1,0,0),(0,0,1));
	self scragentsetspecies("mech");
	self scragentallowboost(1);
	thread bossozhealthbar();
	level notify("onZombiebossOzStage2Spawn",self);
}

//Function Number: 20
bossozstage2postspawn(param_00)
{
	param_00 scragentsetclipmode("agent");
	var_01 = int(param_00.health * maps\mp\zombies\_util::getnumplayers());
	param_00 maps\mp\agents\_agent_common::set_agent_health(var_01);
	setomnvar("ui_zm_fight_health_max",var_01);
	setomnvar("ui_zm_fight_health_current",var_01);
	param_00 setthreatbiasgroup("zombie_boss_oz_stage2");
	level thread bossozstage2playerthreats();
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("oz_stage2_blood_spit_loop"),param_00,"J_Head");
	param_00.postspawnfinished = 1;
}

//Function Number: 21
bossozstage2playerthreats()
{
	level endon("game_ended");
	level endon("zombie_wave_ended");
	for(;;)
	{
		var_00 = [];
		var_01 = [];
		var_02 = [];
		foreach(var_04 in level.players)
		{
			if(maps\mp\zombies\_util::isplayerinfected(var_04))
			{
				var_01[var_01.size] = var_04;
				continue;
			}

			if(var_04 maps\mp\_utility::isjuggernaut())
			{
				var_00[var_00.size] = var_04;
				continue;
			}

			var_02[var_02.size] = var_04;
		}

		var_06 = [];
		var_07 = [];
		if(var_02.size > 0)
		{
			var_06 = var_02;
			var_07 = common_scripts\utility::array_combine(var_01,var_00);
		}
		else if(var_00.size > 0)
		{
			var_06 = var_00;
			var_07 = var_01;
		}
		else
		{
			var_06 = var_01;
		}

		foreach(var_04 in var_06)
		{
			var_04 setthreatbiasgroup("non_infected_players");
		}

		foreach(var_04 in var_07)
		{
			var_04 setthreatbiasgroup("infected_players");
		}

		var_0C = level common_scripts\utility::waittill_any_return("connected","player_disconnected","player_infected","player_cured","player_left_goliath_suit");
		if(isdefined(var_0C) && var_0C == "connected")
		{
			wait 0.05;
		}
	}
}

//Function Number: 22
setupbossozstage2state()
{
	self.attackoffset = 70 + self.radius;
	self.meleesectortype = "large";
	self.meleesectorupdatetime = 200;
	self.attackzheight = 54;
	self.attackzheightdown = -64;
	self.damagedradiussq = 2250000;
	self.ignoreclosefoliage = 1;
	self.moveratescale = 1.15;
	self.nonmoveratescale = 1;
	self.traverseratescale = 1.15;
	self.generalspeedratescale = 1.15;
	self.bhasbadpath = 0;
	self.bhasnopath = 1;
	self.timeoflastdamage = 0;
	self.allowcrouch = 1;
	self.meleecheckheight = 80;
	self.meleeradiusbase = 120;
	self.meleeradiusbasesq = squared(self.meleeradiusbase);
	maps\mp\zombies\_util::setmeleeradius(self.meleeradiusbase);
	self.defaultgoalradius = self.radius + 1;
	self scragentsetgoalradius(self.defaultgoalradius);
	self.meleedot = 0.5;
	self.ignoreexpiretime = 1;
	self.ignorezombierecycling = 1;
	self.hastraversed = 1;
	self.nopickups = 1;
	self.ignorescamouflage = 1;
	self.noheadshotpainreaction = 1;
	self.lastcurestationstun = 0;
	self.resistanttosquadmatedamage = 1;
	self.neverimmediatelyragdoll = 1;
	self.nodamageself = 1;
	maps\mp\agents\humanoid\_humanoid_util::lungemeleeupdate(7.5,self.meleeradiusbase * 2.5,self.meleeradiusbase * 1.5,"attack_lunge_boost",level._effect["boost_lunge"]);
	maps\mp\agents\humanoid\_humanoid_util::lungemeleeenable();
	maps\mp\agents\humanoid\_humanoid_util::leapupdate(5,2,0.6,800,self.meleeradiusbase * 2.5,"leap_boost",level._effect["boost_jump"]);
	maps\mp\agents\humanoid\_humanoid_util::leapenable();
	self.animcbs.onenter["melee"] = ::bossozstage2_melee;
	self.boostfxtag = "no_boost_fx";
	self.spinattackready = 0;
	self.lastbigattacktime = 0;
	self.shouldplaystophitreactionfunc = ::bossozstage2shouldplaystophitreaction;
	self.gethitreactiondamagethresholdfunc = ::getpainthreshold;
	self.getleaptargetpointfunc = ::bossozstage2getleaptarget;
}

//Function Number: 23
bossozcheckspecialsequence()
{
	if(self.health / self.maxhealth <= 1 && !isdefined(self.playedsequence[100]))
	{
		bossozstage2_100percentsequence();
		return 1;
	}

	if(self.health / self.maxhealth <= 0.75 && !isdefined(self.playedsequence[75]))
	{
		bossozstage2_75percentsequence();
		return 1;
	}

	if(self.health / self.maxhealth <= 0.5 && !isdefined(self.playedsequence[50]))
	{
		bossozstage2_50percentsequence();
		return 1;
	}

	if(self.health / self.maxhealth <= 0.25 && !isdefined(self.playedsequence[25]))
	{
		bossozstage2_25percentsequence();
		return 1;
	}

	return 0;
}

//Function Number: 24
zombie_boss_oz_stage2_think()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
	setupbossozstage2state();
	thread maps\mp\zombies\_zombies::zombie_speed_monitor();
	thread maps\mp\zombies\_util::waitforbadpath();
	thread maps\mp\zombies\zombie_generic::zombie_generic_moan();
	thread maps\mp\zombies\zombie_generic::zombie_audio_monitor();
	thread maps\mp\zombies\_zombies::updatebuffs();
	thread maps\mp\zombies\_zombies::updatepainsensor();
	thread collidewithnearbyzombies();
	thread updatebossozstage2spinattackcooldown();
	thread updatemissiletargets();
	thread updateweaponstate();
	self.playedsequence = [];
	while(!maps\mp\zombies\_util::is_true(self.postspawnfinished))
	{
		wait(0.05);
	}

	for(;;)
	{
		if(bossozcheckspecialsequence())
		{
			continue;
		}

		if(isdefined(self.isscripted))
		{
			wait(0.05);
			continue;
		}

		if(bossozstage2_begin_melee())
		{
			wait(0.05);
			continue;
		}

		if(bossozstage2_destroy_distraction_drone())
		{
			wait(0.05);
			continue;
		}

		if(maps\mp\zombies\_behavior::humanoid_seek_enemy_melee(1))
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

//Function Number: 25
bossozstage2_begin_melee()
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

	var_00 = maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && isdefined(self.lungelast) && gettime() - self.lungelast <= self.lungedebouncems;
	if(maps\mp\agents\humanoid\_humanoid::didpastlungemeleefail() || var_00)
	{
		if(!maps\mp\agents\humanoid\_humanoid::readytomeleetarget("base"))
		{
			return 0;
		}
	}
	else if(!maps\mp\agents\humanoid\_humanoid::readytomeleetarget("normal"))
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

	if(!isdefined(self.lastmeleepos) || distancesquared(self.lastmeleepos,self.origin) > self.meleeradiusbasesq * 1.5 * 1.5)
	{
		self.meleemovemode = self.movemode;
	}

	self scragentbeginmelee(self.curmeleetarget);
	return 1;
}

//Function Number: 26
bossozstage2_destroy_distraction_drone()
{
	if(!isdefined(self.distractiondrone))
	{
		return 0;
	}

	if(self.ignoreall)
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

	var_00 = lengthsquared(self.distractiondrone.origin - self.origin);
	if(var_00 > squared(120))
	{
		return 0;
	}

	if(length(self getvelocity()) > 0)
	{
		return 0;
	}

	self.curmeleetarget = self.distractiondrone;
	self scragentbeginmelee(self.distractiondrone);
	return 1;
}

//Function Number: 27
bossozstage2_melee()
{
	self endon("death");
	self endon("killanimscript");
	self.curmeleetarget endon("disconnect");
	if(isdefined(self.distractiondrone) && self.distractiondrone == self.curmeleetarget)
	{
		childthread bossozstage2attackstandard(self.curmeleetarget,self.curmeleetarget.origin);
		self waittill("cancel_updatelerppos");
		self.distractiondrone maps\mp\zombies\weapons\_zombie_distraction_drone::destroydrone(1);
		return;
	}

	var_00 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);
	if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked())
	{
		return maps\mp\agents\humanoid\_humanoid_melee::meleefailed();
	}

	if(self.spinattackready && !isdefined(self.meleemovemode))
	{
		if(maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase())
		{
			bossozstage2attackspin(self.curmeleetarget,self.origin);
			return;
		}
	}

	if(maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && var_00.valid)
	{
		if(!isdefined(self.lungelast))
		{
			self.lungelast = 0;
		}

		if(isdefined(self.meleemovemode))
		{
			var_01 = gettime() - self.lungelast > self.lungedebouncems;
			var_02 = maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint(self.origin,var_00.origin);
			var_03 = distancesquared(self.curmeleetarget.origin,self.origin) > self.lungeminrangesq;
			if(var_01 && var_02 && var_03)
			{
				self.lungelast = gettime();
				bossozstage2attacklunge(self.curmeleetarget,var_00.origin);
				return;
			}
		}

		if(!maps\mp\agents\humanoid\_humanoid_util::withinmeleeradiusbase())
		{
			if(gettime() - self.lungelast > self.lungedebouncems)
			{
				self.lungelast = gettime() - self.lungedebouncems - 1000;
			}

			maps\mp\agents\humanoid\_humanoid_melee::lungemeleefailed();
			return;
		}
	}

	bossozstage2attackstandard(self.curmeleetarget,var_00.origin);
}

//Function Number: 28
bossozstage2attackstandard(param_00,param_01)
{
	var_02 = "attack_stand";
	var_03 = "angle abs enemy";
	var_04 = 1;
	if(isdefined(self.meleemovemode))
	{
		var_02 = "attack_" + self.meleemovemode;
		var_03 = "enemy";
		self.meleemovemode = undefined;
	}
	else
	{
		var_05 = vectortoyaw(vectornormalize(self.curmeleetarget.origin - self.origin));
		var_06 = angleclamp180(var_05 - self.angles[1]);
		if(abs(var_06 - 180) < 45)
		{
			var_02 = "attack_stand_turn_180";
			var_03 = "angle abs self";
			var_04 = 0;
		}
	}

	bossozstage2doattack(param_00,param_01,var_02,var_04,var_03,1);
}

//Function Number: 29
bossozstage2attacklunge(param_00,param_01)
{
	bossozstage2doattack(param_00,param_01,self.lungeanimstate,1,"enemy",1);
}

//Function Number: 30
bossozstage2attackspin(param_00,param_01)
{
	bossozstage2doattack(param_00,param_01,"attack_spin",0,"angle abs enemy",1);
}

//Function Number: 31
bossozstage2doattack(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.lastmeleefailedmypos = undefined;
	self.lastmeleefailedpos = undefined;
	var_06 = randomint(self getanimentrycount(param_02));
	var_07 = self getanimentry(param_02,var_06);
	var_08 = getanimlength(var_07);
	var_09 = getnotetracktimes(var_07,"hit_left");
	var_0A = getnotetracktimes(var_07,"hit_right");
	var_0B = getnotetracktimes(var_07,"hit_aoe");
	var_0C = getfirsthittime(var_08,param_05,var_09,undefined);
	var_0C = getfirsthittime(var_08,param_05,var_0A,var_0C);
	var_0C = getfirsthittime(var_08,param_05,var_0B,var_0C);
	self scragentsetphysicsmode("gravity");
	if(param_04 == "enemy")
	{
		self scragentsetorientmode("face enemy");
	}
	else if(param_04 == "angle abs enemy")
	{
		self scragentsetorientmode("face angle abs",(0,vectortoyaw(param_00.origin - self.origin),0));
	}
	else if(param_04 == "angle abs self")
	{
		self scragentsetorientmode("face angle abs",(0,self.angles[1],0));
	}

	self scragentsetanimmode("anim deltas");
	maps\mp\agents\_scripted_agent_anim_util::set_anim_state(param_02,var_06,param_05);
	thread bossozstage2meleecomplete(param_02,var_08);
	var_0D = undefined;
	if(param_03 && param_02 != "attack_lunge_boost")
	{
		var_0D = 150;
	}

	if(param_03)
	{
		self scragentsetanimscale(0,1);
		self scragentdoanimlerp(self.origin,param_01,var_0C);
		childthread maps\mp\agents\humanoid\_humanoid_melee::updatelerppos(param_00,var_0C,1,var_0D);
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"DoAttack");
	}
	else
	{
		self scragentsetanimscale(1,1);
	}

	if(var_0B.size > 0)
	{
		childthread empblast(var_0C);
	}
	else
	{
		childthread updatemeleesweeper(param_00,var_08,param_05,var_0A,"J_Mid_RI_3");
		childthread updatemeleesweeper(param_00,var_08,param_05,var_09,"J_Mid_LE_3");
	}

	wait(var_0C);
	self notify("cancel_updatelerppos");
	self scragentsetanimmode("anim deltas");
	self scragentsetanimscale(1,1);
	if(param_03)
	{
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoAttack");
	}

	self.lastmeleepos = self.origin;
	var_0E = var_08 / param_05 - var_0C;
	if(var_0E > 0)
	{
		maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("attack_anim","end",var_0E);
	}

	self notify("cancel_updatelerppos");
	self scragentsetanimmode("anim deltas");
	self scragentsetanimscale(1,1);
	if(param_03)
	{
		maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoAttack");
	}
}

//Function Number: 32
bossozstage2meleecomplete(param_00,param_01)
{
	maps\mp\_utility::waitfortimeornotify(param_01,"killanimscript");
	switch(param_00)
	{
		case "attack_spin":
			self.spinattackready = 0;
			break;

		default:
			break;
	}

	self.lastmeleefinishtime = gettime();
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoAttack");
}

//Function Number: 33
getfirsthittime(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02) || param_02.size == 0)
	{
		return param_03;
	}

	var_04 = param_00 / param_01 * param_02[0];
	if(isdefined(param_03) && param_03 < var_04)
	{
		return param_03;
	}

	return var_04;
}

//Function Number: 34
updatemeleesweeper(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	level endon("game_ended");
	if(param_03.size == 0)
	{
		return;
	}

	var_05 = [];
	for(var_06 = 0;var_06 < param_03.size;var_06 = var_06 + 2)
	{
		var_05[var_06] = param_01 / param_02 * param_03[var_06];
		var_05[var_06 + 1] = param_01 / param_02 * param_03[var_06 + 1];
	}

	var_07 = 0;
	var_08 = 0.05;
	self.hittargets[param_04] = [];
	while(var_07 <= var_05[var_05.size - 1])
	{
		wait(var_08);
		var_07 = var_07 + var_08;
		for(var_06 = 0;var_06 < var_05.size;var_06 = var_06 + 2)
		{
			if(var_07 >= var_05[var_06] && var_07 <= var_05[var_06 + 1])
			{
				checkmeleesweeperhit(param_00,param_04);
			}
		}
	}
}

//Function Number: 35
checkmeleesweeperhit(param_00,param_01)
{
	var_02 = self gettagorigin(param_01);
	var_03 = var_02 - self.origin * (1,1,0);
	var_04 = length(var_03);
	foreach(var_06 in level.participants)
	{
		if(!isdefined(var_06))
		{
			continue;
		}

		if(maps\mp\zombies\_util::isplayerinlaststand(var_06))
		{
			continue;
		}

		if(isalliedsentient(var_06,self))
		{
			continue;
		}

		checkmeleesweeperhittarget(var_06,var_02,var_03,var_04,self.meleedamage,param_01);
	}

	if(isdefined(param_00) && isdefined(param_00.issentry) && param_00.issentry && issentient(param_00))
	{
		checkmeleesweeperhittarget(param_00,var_02,var_03,var_04,param_00.maxhealth / 2,param_01);
	}
}

//Function Number: 36
checkmeleesweeperhittarget(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(common_scripts\utility::array_contains(self.hittargets[param_05],param_00))
	{
		return;
	}

	if(!checkmeleeheight(param_00,param_01[2]))
	{
		return;
	}

	var_06 = param_00.origin - self.origin * (1,1,0);
	var_07 = length(var_06);
	if(var_07 > param_03 + 40)
	{
		return;
	}

	if(vectordot(var_06,param_02) < 0.707)
	{
		return;
	}

	self notify("attack_hit",param_00,self.origin);
	maps\mp\agents\humanoid\_humanoid_melee::domeleedamage(param_00,param_04,"MOD_IMPACT");
	self.hittargets[param_05][self.hittargets[param_05].size] = param_00;
}

//Function Number: 37
checkmeleeheight(param_00,param_01)
{
	var_02 = self.origin[2] + 105;
	var_03 = max(var_02,param_01);
	var_04 = self.origin[2];
	var_05 = param_00 geteye()[2];
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

//Function Number: 38
bossozstage2calculatemovemode()
{
	return "run";
}

//Function Number: 39
bossozstage2calculatemoveratescale()
{
	return 1.15 * bossozstage2getbuffspeedmultiplier();
}

//Function Number: 40
bossozstage2calculatenonmoveratescale()
{
	return 1 * bossozstage2getbuffspeedmultiplier();
}

//Function Number: 41
bossozstage2calculatetraverseratescale()
{
	return 1.15 * bossozstage2getbuffspeedmultiplier();
}

//Function Number: 42
bossozstage2getbuffspeedmultiplier()
{
	var_00 = maps\mp\zombies\_zombies::getbuffspeedmultiplier();
	if(var_00 < 1)
	{
		var_01 = 1 - var_00;
		var_02 = var_01 * 0.5;
		var_00 = 1 - var_02;
	}

	return var_00;
}

//Function Number: 43
getbossozstage2spinattackcooldown()
{
	if(level.players.size > 1)
	{
		return 15;
	}

	return 5;
}

//Function Number: 44
updatebossozstage2spinattackcooldown()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0.05;
	var_01 = 0;
	for(;;)
	{
		wait(var_00);
		if(!self.spinattackready)
		{
			var_01 = var_01 + var_00;
		}

		if(var_01 < getbossozstage2spinattackcooldown())
		{
			continue;
		}

		self.spinattackready = 1;
		var_01 = 0;
	}
}

//Function Number: 45
bossozstage2shouldplaystophitreaction()
{
	return 0;
}

//Function Number: 46
getpainthreshold()
{
	return 1 * self.maxhealth;
}

//Function Number: 47
bossozstage2modifyplayerequipmentdamage(param_00,param_01,param_02)
{
	return param_01;
}

//Function Number: 48
bossozstage2modifycauterizerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return int(param_02 * 0.7);
}

//Function Number: 49
bossozstage2modifys12damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return int(param_02 * 0.7);
}

//Function Number: 50
bossozstage2modifylinegundamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return int(param_02 * 0.7);
}

//Function Number: 51
bossozstage2modifymahemdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return int(param_02 * 0.7);
}

//Function Number: 52
bossozstage2modifylynxdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return int(param_02 * 0.7);
}

//Function Number: 53
bossozstage2modifytridentdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return int(param_02 * 0.7);
}

//Function Number: 54
onbossozstage2killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(self.aistate == "scripted")
	{
		self.isscripted = undefined;
		self.aistate = "idle";
	}

	setomnvar("ui_zm_fight_health_current",0);
	setomnvar("ui_zm_fight_health_max",0);
	maps\mp\zombies\_zombies::onzombiekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	maps\mp\gametypes\zombies::createpickup("ammo",self.origin,"Boss Oz Wave 2 Complete - Ammo");
	var_09 = param_01.origin;
	if(param_03 == "MOD_SUICIDE" && param_04 == "none")
	{
		var_09 = common_scripts\utility::random(level.players).origin;
	}

	maps\mp\gametypes\zombies::createpickup("nuke",var_09,"Boss Oz Wave 2 Complete - Nuke");
	givebossozkillwithblunderbussachievement(param_01,param_04,param_03);
	givebossozstage2achievement();
	thread bossozstage2dodeath();
	foreach(var_0B in level.players)
	{
		var_0B playersetcinematicunlockedcoopdatah2o();
		var_0B thread maps\mp\_matchdata::loggameevent("zm_boss_phase4",var_0B.origin);
	}
}

//Function Number: 55
playersetcinematicunlockedcoopdatah2o()
{
	var_00 = self getcoopplayerdatareservedint("eggData");
	var_00 = var_00 | 256;
	self setcoopplayerdatareservedint("eggData",var_00);
}

//Function Number: 56
bossozstage2dodeath()
{
	level endon("game_ended");
	var_00 = self.body;
	earthquake(randomfloatrange(0.75,1.25),0.35,var_00.origin,256);
	var_00 playsound("zmb_goliath_death_destruct");
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zombie_eye_boss_oz_fade"),var_00,"tag_eye");
	var_01 = self getanimentry();
	var_02 = getanimlength(var_01);
	var_03 = 1;
	var_04 = getnotetracktimes(var_01,"puke_start");
	var_05 = var_02 / var_03 * var_04[0];
	wait(var_05);
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("oz_stage2_blood_spit_death"),var_00,"J_Head");
}

//Function Number: 57
givebossozkillwithblunderbussachievement(param_00,param_01,param_02)
{
	if(isdefined(param_00) && isplayer(param_00) && isdefined(param_01))
	{
		var_03 = getweaponbasename(param_01);
		if(!isdefined(param_02) || param_02 != "MOD_MELEE")
		{
			if(maps\mp\zombies\_util::is_true(level.xenon) || maps\mp\zombies\_util::is_true(level.ps3))
			{
				if(var_03 == "iw5_gm6zm_mp")
				{
					param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_BIGGAME");
					return;
				}

				return;
			}

			if(var_03 == "iw5_dlcgun4zm_mp")
			{
				param_00 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_BIGGAME");
				return;
			}

			return;
		}
	}
}

//Function Number: 58
givebossozstage2achievement()
{
	foreach(var_01 in level.players)
	{
		var_01 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_DEFEATBOSS2");
	}

	if(maps\mp\zombies\_util::iszombieshardmode())
	{
		foreach(var_01 in level.players)
		{
			var_01 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_DEFEATBOSS3");
		}
	}
}

//Function Number: 59
collidewithnearbyzombies()
{
	self endon("death");
	level endon("game_ended");
	var_00 = squared(50);
	for(;;)
	{
		wait(0.05);
		var_01 = anglestoforward(self.angles * (0,1,0));
		var_02 = length(self getvelocity());
		if(var_02 < 50)
		{
			continue;
		}

		foreach(var_04 in level.agentarray)
		{
			if(!isdefined(var_04) || !isalive(var_04) || var_04 == self || isdefined(var_04.team) && isenemyteam(self.team,var_04.team))
			{
				continue;
			}

			if(isdefined(var_04.agent_type) && var_04.agent_type == "zombie_boss_oz_stage2")
			{
				continue;
			}

			if(distancesquared(self.origin,var_04.origin) > var_00)
			{
				continue;
			}

			var_05 = var_04.origin - self.origin * (1,1,0);
			if(vectordot(var_05,var_01) < 0)
			{
				continue;
			}

			var_05 = vectornormalize(var_05);
			collidewithagent(var_04,var_05);
		}
	}
}

//Function Number: 60
collidewithagent(param_00,param_01)
{
	recycleagent(param_00);
	if(randomfloat(1) < 0.5)
	{
		ragdollagent(param_00,param_01,"MOD_EXPLOSIVE",2,3);
		return;
	}

	ragdollagent(param_00,param_01,"MOD_MELEE",3,5);
}

//Function Number: 61
recycleagent(param_00)
{
	if(!isdefined(param_00.agent_type))
	{
		return;
	}

	if(maps\mp\zombies\_zombies::shouldrecycle())
	{
		thread maps\mp\zombies\_zombies::recyclezombie(param_00.agent_type);
	}
}

//Function Number: 62
ragdollagent(param_00,param_01,param_02,param_03,param_04)
{
	param_00.ragdollimmediately = 1;
	param_00 dodamage(param_00.health + 1000,param_00 geteye(),self,undefined,param_02,"bossOzStage2FriendlyFire","none");
	var_05 = self.origin - param_01 + (0,0,8);
	wait(0.1);
	var_06 = randomfloatrange(3,5);
	physicsexplosionsphere(var_05,128,0,var_06,0);
}

//Function Number: 63
updateweaponstate()
{
	self endon("death");
	level endon("game_ended");
	self.weaponstate = 0;
	for(;;)
	{
		wait(0.05);
		switch(self.weaponstate)
		{
			case 0:
				updateweaponready();
				break;
	
			case 1:
				updateweaponfiring();
				break;
	
			case 2:
				updateweaponreloading();
				break;
		}
	}
}

//Function Number: 64
updateweaponready()
{
	var_00 = squared(180);
	for(;;)
	{
		wait 0.05;
		if(self.aistate == "traverse" || self.aistate == "melee")
		{
			continue;
		}

		if(!isdefined(self.threats) || self.threats.size == 0)
		{
			continue;
		}

		if(!isdefined(self.curmeleetarget))
		{
			continue;
		}

		if(lengthsquared(self.curmeleetarget.origin - self.origin) < var_00)
		{
			continue;
		}

		if(gettime() - self.lastbigattacktime < 2000)
		{
			continue;
		}

		break;
	}

	self.weaponstate = 1;
}

//Function Number: 65
missilestartlocation()
{
	return self geteye() + (0,0,45);
}

//Function Number: 66
firemissile(param_00)
{
	var_01 = 32;
	var_02 = missilestartlocation();
	var_03 = (randomintrange(-1 * var_01,var_01),randomintrange(-1 * var_01,var_01),randomintrange(-1 * var_01,var_01));
	var_04 = param_00 geteye() + var_03;
	var_05 = magicbullet("boss_oz_rocket_mp",var_02,var_04,self);
	var_05 missile_settargetent(param_00,(0,0,32));
	var_05.owner = self;
	var_05 thread empmissile();
}

//Function Number: 67
empmissile()
{
	self.owner endon("death");
	self waittill("death");
	if(!isdefined(self) || !isdefined(self.owner))
	{
		return;
	}

	var_00 = squared(150);
	var_01 = self.origin;
	playfx(level._effect["zombie_boss_oz_stage2_emp"],var_01);
	foreach(var_03 in level.participants)
	{
		if(distancesquared(var_01,var_03.origin) > var_00)
		{
			continue;
		}

		if(maps\mp\zombies\_util::isplayerinlaststand(var_03))
		{
			continue;
		}

		if(isalliedsentient(var_03,self.owner))
		{
			continue;
		}

		if(isdefined(var_03.exosuitonline) && var_03.exosuitonline)
		{
			var_03 thread maps\mp\zombies\_mutators::mutatoremz_applyemp();
		}

		var_03 playlocalsound("zmb_emz_impact");
	}
}

//Function Number: 68
updateweaponfiring()
{
	if(maps\mp\zombies\_util::is_true(self.disablemissile) || maps\mp\zombies\_util::is_true(self.godmode))
	{
		return;
	}

	if(isdefined(self.threats) && self.aistate != "traverse")
	{
		foreach(var_01 in self.threats)
		{
			if(evaluate_threat_valid_threat(var_01) == -1 || evaluate_threat_behavior(var_01) == -1)
			{
				continue;
			}

			firemissile(var_01);
			wait(0.05);
		}
	}

	self.weaponstate = 2;
	self.lastbigattacktime = gettime();
}

//Function Number: 69
updateweaponreloading()
{
	var_00 = undefined;
	var_01 = undefined;
	var_02 = self.health / self.maxhealth;
	if(level.players.size == 1)
	{
		var_00 = maps\mp\zombies\_util::lerp(var_02,6,12);
		var_01 = maps\mp\zombies\_util::lerp(var_02,12,18);
	}
	else
	{
		var_00 = maps\mp\zombies\_util::lerp(var_02,3,6);
		var_01 = maps\mp\zombies\_util::lerp(var_02,6,12);
	}

	wait(randomfloatrange(var_00,var_01));
	self.weaponstate = 0;
}

//Function Number: 70
updatemissiletargets()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0.05;
	for(;;)
	{
		wait(var_00);
		var_01 = undefined;
		var_02 = -1;
		var_03 = [];
		foreach(var_05 in level.participants)
		{
			wait(0.05);
			var_06 = calculate_threat_level(var_05);
			if(var_06 < 0)
			{
				continue;
			}

			var_03[var_03.size] = var_05;
		}

		self.threats = var_03;
	}
}

//Function Number: 71
calculate_threat_level(param_00)
{
	var_01 = 0;
	var_02[0] = ::evaluate_threat_valid_threat;
	var_02[1] = ::evaluate_threat_melee_target;
	var_02[2] = ::evaluate_threat_behavior;
	var_02[3] = ::evaluate_threat_los;
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

//Function Number: 72
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

	if(param_00 isnotarget())
	{
		return -1;
	}

	if(isalliedsentient(param_00,self))
	{
		return -1;
	}

	if(maps\mp\zombies\_util::shouldignoreent(param_00))
	{
		return -1;
	}

	if(maps\mp\zombies\_util::isplayerinfected(param_00))
	{
		return -1;
	}

	return 1;
}

//Function Number: 73
evaluate_threat_behavior(param_00)
{
	return 1;
}

//Function Number: 74
evaluate_threat_los(param_00)
{
	if(trace_to_enemy(missilestartlocation(),param_00,undefined))
	{
		return 1;
	}

	return -1;
}

//Function Number: 75
trace_to_enemy(param_00,param_01,param_02)
{
	var_03 = bullettrace(param_00,param_01 geteye(),0,undefined,0,0,0,0,0);
	return var_03["fraction"] == 1;
}

//Function Number: 76
evaluate_threat_melee_target(param_00)
{
	if(!isdefined(self.curmeleetarget))
	{
		return 1;
	}

	if(self.curmeleetarget == param_00 && distancesquared(param_00.origin,self.origin) < 122500)
	{
		return -1;
	}

	return 1;
}

//Function Number: 77
empblast(param_00)
{
	wait(param_00);
	var_01 = self gettagorigin("J_Ankle_RI");
	var_02 = squared(1000);
	playfx(level._effect["zombie_boss_oz_stage2_emp"],var_01);
	foreach(var_04 in level.participants)
	{
		if(evaluate_threat_valid_threat(var_04) == -1)
		{
			continue;
		}

		if(distancesquared(var_04.origin,var_01) > var_02)
		{
			continue;
		}

		if(isdefined(var_04.exosuitonline) && var_04.exosuitonline)
		{
			var_04 thread maps\mp\zombies\_mutators::mutatoremz_applyemp();
		}

		var_04 playlocalsound("zmb_emz_impact");
	}
}

//Function Number: 78
bossozstage2trycalculatesectororigin(param_00,param_01,param_02,param_03)
{
	if(gettime() - param_00.timestamp >= 50)
	{
		param_00.origin = maps\mp\agents\humanoid\_humanoid_util::meleesectortargetposition(param_01,param_00.num,param_02);
		param_00.origin = maps\mp\agents\humanoid\_humanoid_util::dropsectorpostoground(param_00.origin,15,55);
		param_00.timestamp = gettime();
		if(isdefined(param_00.origin))
		{
			var_04 = self.meleecheckheight;
			if(!isdefined(var_04))
			{
				var_04 = 40;
			}

			var_05 = param_00.origin + (0,0,var_04);
			var_06 = param_01 + (0,0,var_04);
			var_07 = physicstrace(var_05,var_06);
			if(distancesquared(var_07,var_06) > 1)
			{
				param_00.origin = undefined;
				return;
			}
		}
	}
}

//Function Number: 79
bossozstage2getradiusandheight()
{
	var_00 = 30;
	var_01 = 105;
	return [var_00,var_01];
}

//Function Number: 80
bossozstage2curestationactivated(param_00,param_01)
{
	self endon("death");
	if(gettime() - self.lastcurestationstun < 10000)
	{
		return;
	}

	if(maps\mp\zombies\_util::is_true(self.inairforleap) || maps\mp\zombies\_util::is_true(self.godmode))
	{
		return;
	}

	self.lastcurestationstun = gettime();
	self scragentsetscripted(1);
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1,"DoStopHitReaction");
	self.inpain = 1;
	self.incurestationstun = 1;
	setomnvar("ui_zm_fight_shield",0);
	self playsound("zmb_gol_round_start_front");
	self.disablemissile = 1;
	self.ignoreall = 1;
	self scragentsetanimmode("anim deltas");
	self scragentsetorientmode("face angle abs",self.angles);
	maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe("stun_enter",0,1,"scripted_anim");
	if(!maps\mp\zombies\_util::is_true(self.godmode))
	{
		maps\mp\agents\_scripted_agent_anim_util::set_anim_state("stun_loop",0,1);
		common_scripts\utility::waittill_notify_or_timeout("cancel_stun",3);
	}

	maps\mp\agents\_scripted_agent_anim_util::playanimnatrateuntilnotetrack_safe("stun_exit",0,1,"script_anim");
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoStopHitReaction");
	self.inpain = undefined;
	self.incurestationstun = undefined;
	setomnvar("ui_zm_fight_shield",1);
	bossozstage2enableai();
	self scragentsetscripted(0);
}

//Function Number: 81
bossozstage2waituntiloutofcurestationstun()
{
	self endon("death");
	while(isdefined(self.incurestationstun) && self.incurestationstun)
	{
		wait 0.05;
	}
}

//Function Number: 82
bossozstage2getleaptarget()
{
	var_00 = spawnstruct();
	var_00.origin = self.curmeleetarget.origin;
	var_00.valid = 1;
	if(isdefined(self.distractiondrone) && self.curmeleetarget == self.distractiondrone)
	{
		if(isdefined(self.curmeleetarget.groundpos))
		{
			var_00.origin = self.curmeleetarget.groundpos;
		}
	}

	if(isplayer(self.curmeleetarget))
	{
		if(!self.curmeleetarget isonground() || self.curmeleetarget isnoclip())
		{
			var_00.valid = 0;
		}
	}

	return var_00;
}

//Function Number: 83
bossozstage2modifydamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(param_00 bossozstage2hasarmor())
	{
		param_02 = 0;
		param_01 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("hitspecialarmor");
	}

	var_08 = 0;
	if(!isdefined(param_00.playedsequence[75]))
	{
		var_08 = int(0.75 * param_00.maxhealth) - 1;
	}
	else if(!isdefined(param_00.playedsequence[50]))
	{
		var_08 = int(0.5 * param_00.maxhealth) - 1;
	}
	else if(!isdefined(param_00.playedsequence[25]))
	{
		var_08 = int(0.25 * param_00.maxhealth) - 1;
	}

	param_02 = int(min(param_02,param_00.health - var_08));
	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_03) && param_03 == "MOD_MELEE_ALT" && isdefined(param_04) && param_04 == "iw5_exominigunzm_mp")
	{
		param_01 maps\mp\gametypes\zombies::givezombieachievement("DLC4_ZOMBIE_GOTOSLEEP");
	}

	return param_02;
}

//Function Number: 84
bossozstage2hasarmor()
{
	return !maps\mp\zombies\_util::is_true(self.incurestationstun);
}

//Function Number: 85
bossozhealthbar()
{
	setomnvar("ui_zm_fight_health_current",self.health);
	setomnvar("ui_zm_fight_health_max",0);
	thread bossozhealthbarupdate();
}

//Function Number: 86
bossozhealthbarupdate()
{
	self endon("death");
	for(;;)
	{
		setomnvar("ui_zm_fight_health_current",self.health);
		wait 0.05;
	}
}

//Function Number: 87
bossozstage2startinvalidationtrap(param_00,param_01,param_02)
{
	var_03 = level.stage1traps[param_00];
	if(!isdefined(var_03))
	{
		return;
	}

	level thread [[ var_03.runtrapfunc ]](var_03,param_01,param_02,1);
	var_04 = [[ var_03.gettraptriggersfunc ]](var_03);
	foreach(var_06 in var_04)
	{
		if(!isdefined(level.noammodroptriggers))
		{
			level.noammodroptriggers = [];
		}

		if(!common_scripts\utility::array_contains(level.noammodroptriggers,var_06))
		{
			level.noammodroptriggers[level.noammodroptriggers.size] = var_06;
		}

		if(isdefined(level.ammocrate))
		{
			if(ispointinvolume(level.ammocrate.origin + (0,0,35),var_06))
			{
				level.ammocrate delete();
			}
		}
	}
}