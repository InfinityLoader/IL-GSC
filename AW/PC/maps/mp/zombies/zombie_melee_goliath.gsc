/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\zombie_melee_goliath.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 76
 * Decompile Time: 1297 ms
 * Timestamp: 4/22/2024 2:15:13 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.agent_funcs["zombie_melee_goliath"] = level.agent_funcs["zombie"];
	level.agent_funcs["zombie_melee_goliath"]["think"] = ::zombie_melee_goliath_think;
	level.agent_funcs["zombie_melee_goliath"]["on_killed"] = ::onmeleegoliathkilled;
	level.agent_funcs["zombie_melee_goliath"]["spawn"] = ::onzombiemeleegoliathspawn;
	var_00[0] = ["goliath_melee"];
	var_01 = spawnstruct();
	var_01.agent_type = "zombie_melee_goliath";
	var_01.animclass = "zombie_melee_goliath_animclass";
	var_01.model_bodies = var_00;
	var_01.health_scale = 20;
	var_01.meleedamage = 90;
	var_01.damagescalevssquadmates = 1.5;
	var_01.spawnparameter = "zombie_melee_goliath";
	maps\mp\zombies\_util::agentclassregister(var_01,"zombie_melee_goliath");
	level.getspawntypefunc["zombie_melee_goliath"] = ::getmeleegoliathroundspawntype;
	level.roundspawndelayfunc["zombie_melee_goliath"] = ::calculatemeleegoliathspawndelay;
	level.mutatorfunc["zombie_melee_goliath"] = ::meleegoliathmutator;
	level.movemodefunc["zombie_melee_goliath"] = ::meleegoliathcalculatemovemode;
	level.moveratescalefunc["zombie_melee_goliath"] = ::meleegoliathcalculatemoveratescale;
	level.nonmoveratescalefunc["zombie_melee_goliath"] = ::meleegoliathcalculatenonmoveratescale;
	level.traverseratescalefunc["zombie_melee_goliath"] = ::meleegoliathcalculatetraverseratescale;
	level.numenemiesthisroundfunc["zombie_melee_goliath"] = ::meleegoliathroundnumenemies;
	level.roundstartfunc["zombie_melee_goliath"] = ::meleegoliathroundstart;
	level.candroppickupsfunc["zombie_melee_goliath"] = ::meleegoliathroundcandroppickups;
	level.trycalculatesectororigin["zombie_melee_goliath"] = ::trycalculatesectororigingoliath;
	level.modifyequipmentdamagebyagenttype["zombie_melee_goliath"] = ::meleegoliathmodifyplayerequipmentdamage;
	level.modifyweapondamagebyagenttype["zombie_melee_goliath"]["iw5_fusionzm_mp"] = ::meleegoliathmodifycauterizerdamage;
	level.modifyweapondamagebyagenttype["zombie_melee_goliath"]["iw5_rhinozm_mp"] = ::meleegoliathmodifys12damage;
	level.modifyweapondamagebyagenttype["zombie_melee_goliath"]["iw5_linegunzm_mp"] = ::meleegoliathmodifylinegundamage;
	level._effect["zombie_melee_goliath_electric"] = loadfx("vfx/trail/dlc_goliath_melee_electric");
	level._effect["goliath_shield_light"] = loadfx("vfx/trail/dlc_goliath_shield_light");
	level._effect["zombie_melee_goliath_death"] = loadfx("vfx/blood/dlc_goliath_death");
	level._effect["zombie_melee_goliath_emp"] = loadfx("vfx/explosion/emp_grenade_lrg_mp");
	level.numgoliathrounds = 0;
	level.meleegoliathspawned = 0;
	level.meleegoliathweaponindex = randomint(3);
}

//Function Number: 2
spawnenhancedgoliath()
{
	level.zombiesnextspawntype = "zombie_melee_goliath";
	level.enhancenextgoliath = 1;
}

//Function Number: 3
meleegoliathroundstart()
{
	level.numgoliathrounds++;
	level.meleegoliathspawned = 0;
	var_00 = spawn("script_origin",(0,0,0));
	var_00 playsound("zmb_gol_round_start_front");
	wait(1);
	var_00 delete();
}

//Function Number: 4
meleegoliathroundcandroppickups(param_00)
{
	return 0;
}

//Function Number: 5
onzombiemeleegoliathspawn(param_00,param_01,param_02)
{
	maps\mp\zombies\_util::onspawnscriptagenthumanoid(param_00,param_01,param_02);
	self scragentsetspecies("mech");
	self scragentallowboost(1);
	level.meleegoliathspawned++;
	if(maps\mp\zombies\_util::is_true(self.enhanced))
	{
		self.hastraversed = 1;
		playfx(common_scripts\utility::getfx("npc_teleport_enemy"),param_00,(1,0,0),(0,0,1));
		playsoundatpos(self.origin,"teleport_goliath_zombie_spawn");
	}

	level notify("onZombieMeleeGoliathSpawn",self);
}

//Function Number: 6
calculatemeleegoliathspawndelay(param_00,param_01)
{
	if(level.players.size > 1)
	{
		if(param_00 == 0 && level.numgoliathrounds <= 1)
		{
			return 20;
		}
		else if(param_00 == 0 && level.numgoliathrounds > 1)
		{
			return 10;
		}
	}
	else if(param_00 == 0 && level.numgoliathrounds <= 1)
	{
		return 30;
	}
	else if(param_00 == 0 && level.numgoliathrounds > 1)
	{
		return 15;
	}

	return maps\mp\zombies\zombies_spawn_manager::calculatespawndelay();
}

//Function Number: 7
meleegoliathroundnumenemies(param_00)
{
	return int(0.75 * param_00);
}

//Function Number: 8
getmeleegoliathroundspawntype(param_00,param_01)
{
	if(param_00 == 0)
	{
		return "zombie_melee_goliath";
	}

	return "zombie_generic";
}

//Function Number: 9
meleegoliathmutator(param_00)
{
	param_00 attachgoliathweapons();
	param_00 scragentsetclipmode("agent");
}

//Function Number: 10
attachgoliathweapons()
{
	var_00[0] = "dlc_melee_parking_meter";
	var_00[1] = "dlc_melee_stop_sign";
	var_00[2] = "dlc_melee_axle";
	var_01 = spawn("script_model",self gettagorigin("TAG_WEAPON_RIGHT"));
	var_01.angles = self gettagangles("TAG_WEAPON_RIGHT");
	if(maps\mp\zombies\_util::is_true(self.enhanced))
	{
		var_01 setmodel("goliath_melee_anchor");
	}
	else
	{
		var_02 = level.meleegoliathweaponindex;
		level.meleegoliathweaponindex = common_scripts\utility::mod(level.meleegoliathweaponindex + 1,3);
		var_01 setmodel(var_00[var_02]);
	}

	var_01 linkto(self,"TAG_WEAPON_RIGHT",(0,0,0),(0,0,0));
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("zombie_melee_goliath_electric"),var_01,"tag_fx");
	self.goliathweapon = var_01;
	var_03 = spawn("script_model",self gettagorigin("TAG_WEAPON_LEFT"));
	var_03.angles = self gettagangles("TAG_WEAPON_LEFT");
	if(maps\mp\zombies\_util::is_true(self.enhanced))
	{
		var_03 setmodel("dlc_ark_riot_shield");
	}
	else
	{
		var_03 setmodel("dlc_bruiser_riot_shield");
	}

	var_03 linkto(self,"TAG_WEAPON_LEFT",(0,0,0),(0,0,0));
	self.goliathshield = var_03;
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("goliath_shield_light"),var_03,"TAG_SHIELD_SPARKS");
}

//Function Number: 11
setupmeleegoliathstate()
{
	self.attackoffset = 70 + self.radius;
	self.meleesectortype = "large";
	self.meleesectorupdatetime = 200;
	self.attackzheight = 54;
	self.attackzheightdown = -64;
	self.damagedradiussq = 2250000;
	self.ignoreclosefoliage = 1;
	self.moveratescale = 1.3;
	self.nonmoveratescale = 1.25;
	self.traverseratescale = 1.25;
	self.generalspeedratescale = 1.25;
	self.bhasbadpath = 0;
	self.bhasnopath = 1;
	self.timeoflastdamage = 0;
	self.allowcrouch = 1;
	self.meleecheckheight = 40;
	self.meleeradiusbase = 60;
	self.meleeradiusbasesq = squared(self.meleeradiusbase);
	maps\mp\zombies\_util::setmeleeradius(self.meleeradiusbase);
	self.defaultgoalradius = self.radius + 1;
	self scragentsetgoalradius(self.defaultgoalradius);
	self.meleedot = 0.5;
	self.ignoreexpiretime = 1;
	self.ignorezombierecycling = 1;
	maps\mp\agents\humanoid\_humanoid_util::lungemeleeupdate(1,self.meleeradiusbase * 2,self.meleeradiusbase * 1.5,"attack_lunge_boost",level._effect["boost_lunge"]);
	maps\mp\agents\humanoid\_humanoid_util::lungemeleeenable();
	self.animcbs.onenter["melee"] = ::goliath_melee;
	self.boostfxtag = "no_boost_fx";
	self.traversecost = 1;
	self.spinattackready = 0;
	self.aggroattackready = 0;
	self.aggrodamage = 0;
	self.lungeattackready = 1;
	self.lungelast = 0;
	self.shouldplaystophitreactionfunc = ::meleegoliathshouldplaystophitreaction;
	self.ondamagepainsensorfunc = ::ondamagepainsensor;
}

//Function Number: 12
zombie_melee_goliath_enhance()
{
	var_00 = level.agentclasses[self.agent_type].model_bodies[0];
	level.agentclasses[self.agent_type].model_bodies[0] = ["goliath_melee_ark"];
	self.enhanced = 1;
	wait(0.05);
	var_01 = int(self.health * 1.5 * maps\mp\zombies\_util::getnumplayers() / 4);
	if(level.wavecounter <= 10)
	{
		var_01 = int(var_01 * 0.5);
	}
	else if(level.wavecounter <= 15)
	{
		var_01 = int(var_01 * 0.75);
	}

	maps\mp\agents\_agent_common::set_agent_health(var_01);
	self.nomutatormodelswap = 1;
	self.nomutatorspawnsound = 1;
	if(level.wavecounter > 15)
	{
		thread maps\mp\zombies\_mutators::mutator_apply("emz");
	}

	if(level.wavecounter > 10)
	{
		thread maps\mp\zombies\_mutators::mutator_apply("teleport");
	}

	thread stay_in_playspace();
	level.agentclasses[self.agent_type].model_bodies[0] = var_00;
}

//Function Number: 13
stay_in_playspace()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	for(;;)
	{
		if(isdefined(level.zone_data) && !maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(self))
		{
			var_00 = maps\mp\zombies\_zombies::getspawnpoint("zombie_melee_goliath",1);
			playfx(common_scripts\utility::getfx("npc_teleport_enemy"),self.origin,(1,0,0),(0,0,1));
			self setorigin(var_00.origin,1);
			self setplayerangles(var_00.angles);
			playfx(common_scripts\utility::getfx("npc_teleport_enemy"),var_00.origin,(1,0,0),(0,0,1));
		}

		wait(0.05);
	}
}

//Function Number: 14
zombie_melee_goliath_think()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	if(isdefined(level.enhancenextgoliath))
	{
		thread zombie_melee_goliath_enhance();
		level.enhancenextgoliath = undefined;
	}

	maps\mp\agents\humanoid\_humanoid::setuphumanoidstate();
	setupmeleegoliathstate();
	thread maps\mp\zombies\_zombies::zombieaimonitorthreads();
	thread maps\mp\zombies\_util::waitforbadpath();
	thread maps\mp\zombies\zombie_generic::zombie_generic_moan();
	thread maps\mp\zombies\zombie_generic::zombie_audio_monitor();
	thread maps\mp\zombies\_zombies::updatebuffs();
	thread maps\mp\zombies\_zombies::updatepainsensor();
	thread collidewithnearbyzombies();
	thread updatemeleegoliathlungecooldown();
	thread updatemeleegoliathspinattackcooldown();
	thread updatemeleegoliathempattackcooldown();
	thread updatemissiletargets();
	thread updateweaponstate();
	for(;;)
	{
		if(isdefined(self.isscripted))
		{
			wait(0.05);
			continue;
		}

		if(goliath_begin_special_attack())
		{
			wait(0.05);
			continue;
		}

		if(goliath_begin_melee())
		{
			wait(0.05);
			continue;
		}

		if(goliath_destroy_distraction_drone())
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

//Function Number: 15
goliath_begin_special_attack()
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

	if(!self.aggroattackready)
	{
		return 0;
	}

	var_00 = lengthsquared(self.curmeleetarget.origin - self.origin);
	if(var_00 > squared(500))
	{
		return 0;
	}

	self scragentbeginmelee(self.curmeleetarget);
	return 1;
}

//Function Number: 16
goliath_begin_melee()
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
	if(!self.lungeattackready || maps\mp\agents\humanoid\_humanoid::didpastlungemeleefail() || var_00)
	{
		if(!goliathreadytomeleetarget("base"))
		{
			return 0;
		}
	}
	else if(!goliathreadytomeleetarget("normal"))
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

	if(!isdefined(self.lastmeleepos) || distancesquared(self.lastmeleepos,self.origin) > 256)
	{
		self.meleemovemode = self.movemode;
	}

	self scragentbeginmelee(self.curmeleetarget);
	return 1;
}

//Function Number: 17
goliath_destroy_distraction_drone()
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

//Function Number: 18
goliathreadytomeleetarget(param_00)
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

		if(param_00 == "normal" && !withinmeleeradiusgoliath())
		{
			return 0;
		}
		else if(param_00 == "base" && !withinmeleeradiusbasegoliath())
		{
			return 0;
		}
	}

	if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked())
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
withinmeleeradiusgoliath()
{
	return distancesquared(self.origin,self.curmeleetarget.origin) <= squared(250);
}

//Function Number: 20
withinmeleeradiusbasegoliath()
{
	return distancesquared(self.origin,self.curmeleetarget.origin) <= squared(120);
}

//Function Number: 21
goliath_melee()
{
	self endon("death");
	self endon("killanimscript");
	self.curmeleetarget endon("disconnect");
	if(isdefined(self.distractiondrone) && self.distractiondrone == self.curmeleetarget)
	{
		childthread meleegoliathattackstandard(self.curmeleetarget,self.curmeleetarget.origin);
		self waittill("cancel_updatelerppos");
		self.distractiondrone maps\mp\zombies\weapons\_zombie_distraction_drone::destroydrone(1);
		return;
	}

	if(self.aggroattackready)
	{
		meleegoliathattackempstomp(self.curmeleetarget,self.origin);
		return;
	}

	var_00 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);
	if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked())
	{
		return maps\mp\agents\humanoid\_humanoid_melee::meleefailed();
	}

	if(self.spinattackready && isdefined(self.lastlungelocation))
	{
		var_01 = length(var_00.origin - self.lastlungelocation);
		if(var_01 < 150)
		{
			meleegoliathattackspin(self.curmeleetarget,self.origin);
			return;
		}
	}

	if(maps\mp\zombies\_util::is_true(self.lungemeleeenabled) && var_00.valid)
	{
		if(isdefined(self.meleemovemode) && self.lungeattackready)
		{
			var_02 = maps\mp\agents\humanoid\_humanoid_util::canhumanoidmovepointtopoint(self.origin,var_00.origin);
			if(var_02)
			{
				self.lungelast = gettime();
				meleegoliathattacklunge(self.curmeleetarget,var_00.origin);
				return;
			}
		}

		if(!withinmeleeradiusbasegoliath())
		{
			maps\mp\agents\humanoid\_humanoid_melee::lungemeleefailed();
			return;
		}
	}

	meleegoliathattackstandard(self.curmeleetarget,var_00.origin);
}

//Function Number: 22
meleegoliathattackstandard(param_00,param_01)
{
	var_02 = "attack_stand";
	var_03 = 0;
	if(isdefined(self.meleemovemode))
	{
		var_02 = "attack_" + self.meleemovemode;
		var_03 = 1;
		self.meleemovemode = undefined;
	}

	meleegoliathdoattack(param_00,param_01,var_02,1,var_03,1.25);
}

//Function Number: 23
meleegoliathattacklunge(param_00,param_01)
{
	meleegoliathdoattack(param_00,param_01,self.lungeanimstate,1,1,1.25);
}

//Function Number: 24
meleegoliathattackspin(param_00,param_01)
{
	meleegoliathdoattack(param_00,param_01,"attack_spin",0,0,1.25);
}

//Function Number: 25
meleegoliathattackempstomp(param_00,param_01)
{
	meleegoliathdoattack(param_00,param_01,"stand_attack_stomp",0,0,1.25);
}

//Function Number: 26
meleegoliathdoattack(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.lastmeleefailedmypos = undefined;
	self.lastmeleefailedpos = undefined;
	var_06 = randomint(self getanimentrycount(param_02));
	var_07 = self getanimentry(param_02,var_06);
	var_08 = getanimlength(var_07);
	var_09 = getnotetracktimes(var_07,"hit_left");
	var_0A = getnotetracktimes(var_07,"hit_right");
	var_0B = getnotetracktimes(var_07,"hit_aoe");
	var_0C = gethittime(var_08,param_05,var_09,undefined);
	var_0C = gethittime(var_08,param_05,var_0A,var_0C);
	var_0C = gethittime(var_08,param_05,var_0B,var_0C);
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
	thread goliathmeleecomplete(param_02,var_08);
	var_0D = undefined;
	if(param_03 && param_02 != "attack_lunge_boost")
	{
		var_0D = 100;
	}

	if(param_03)
	{
		self scragentsetanimscale(0,1);
		self scragentdoanimlerp(self.origin,param_01,var_0C);
		childthread updatemeleegoliathlerppos(param_00,var_0C,1,var_0D);
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
		childthread updatemeleesweeper(param_00,var_07,var_08,param_05,var_09,self.goliathshield);
		childthread updatemeleesweeper(param_00,var_07,var_08,param_05,var_0A,self.goliathweapon);
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

//Function Number: 27
goliathmeleecomplete(param_00,param_01)
{
	maps\mp\_utility::waitfortimeornotify(param_01,"killanimscript");
	switch(param_00)
	{
		case "attack_lunge_boost":
			self.lastlungelocation = self.origin;
			self.lungeattackready = 0;
			break;

		case "attack_spin":
			self.spinattackready = 0;
			break;

		case "stand_attack_stomp":
			self.aggroattackready = 0;
			self.aggrodamage = 0;
			break;

		default:
			break;
	}

	self.lastmeleefinishtime = gettime();
	maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0,"DoAttack");
}

//Function Number: 28
gethittime(param_00,param_01,param_02,param_03)
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

//Function Number: 29
updatemeleegoliathlerppos(param_00,param_01,param_02,param_03)
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

//Function Number: 30
updatemeleesweeper(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	level endon("game_ended");
	if(param_04.size == 0)
	{
		return;
	}

	if(common_scripts\utility::mod(param_04.size,2) != 0)
	{
	}

	var_06 = param_02 / param_03 * param_04[0];
	var_07 = param_02 / param_03 * param_04[1];
	var_08 = 0;
	var_09 = 0.05;
	self.hittargets = [];
	wait(var_06);
	var_0A = var_07 - var_06;
	while(var_08 <= var_0A)
	{
		wait(var_09);
		var_08 = var_08 + var_09;
		checkmeleesweeperhit(param_00,param_05);
	}
}

//Function Number: 31
checkmeleesweeperhit(param_00,param_01)
{
	var_02 = param_01 gettagorigin("tag_impact");
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

		checkmeleesweeperhittarget(var_06,var_02,var_03,var_04,self.meleedamage);
	}

	if(isdefined(param_00) && isdefined(param_00.issentry) && param_00.issentry)
	{
		checkmeleesweeperhittarget(param_00,var_02,var_03,var_04,param_00.maxhealth / 2);
	}
}

//Function Number: 32
checkmeleesweeperhittarget(param_00,param_01,param_02,param_03,param_04)
{
	if(common_scripts\utility::array_contains(self.hittargets,param_00))
	{
		return;
	}

	if(!checkmeleeheight(param_00,param_01[2]))
	{
		return;
	}

	var_05 = param_00.origin - self.origin * (1,1,0);
	var_06 = length(var_05);
	if(var_06 > param_03 + 40)
	{
		return;
	}

	if(vectordot(var_05,param_02) < 0.707)
	{
		return;
	}

	self notify("attack_hit",param_00,self.origin);
	maps\mp\agents\humanoid\_humanoid_melee::domeleedamage(param_00,param_04,"MOD_IMPACT");
	self.hittargets[self.hittargets.size] = param_00;
}

//Function Number: 33
checkmeleeheight(param_00,param_01)
{
	var_02 = self.origin[2] + 80;
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

//Function Number: 34
meleegoliathcalculatemovemode()
{
	return "run";
}

//Function Number: 35
meleegoliathcalculatemoveratescale()
{
	return 1.3 * meleegoliathgetbuffspeedmultiplier();
}

//Function Number: 36
meleegoliathcalculatenonmoveratescale()
{
	return 1.25 * meleegoliathgetbuffspeedmultiplier();
}

//Function Number: 37
meleegoliathcalculatetraverseratescale()
{
	return 1.25 * meleegoliathgetbuffspeedmultiplier();
}

//Function Number: 38
meleegoliathgetbuffspeedmultiplier()
{
	var_00 = maps\mp\zombies\_zombies::getbuffspeedmultiplier();
	if(var_00 < 1)
	{
		return clamp(var_00 * 1.25,0,1);
	}

	return var_00;
}

//Function Number: 39
updatemeleegoliathlungecooldown()
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
		if(var_02 < 100)
		{
			continue;
		}

		self.lungeattackready = 1;
	}
}

//Function Number: 40
getmeleegoliathspinattackcooldown()
{
	if(level.players.size > 1)
	{
		return 15;
	}

	return 5;
}

//Function Number: 41
updatemeleegoliathspinattackcooldown()
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

		if(var_01 < getmeleegoliathspinattackcooldown())
		{
			continue;
		}

		self.spinattackready = 1;
		var_01 = 0;
	}
}

//Function Number: 42
updatemeleegoliathempattackcooldown()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0.05;
	var_01 = var_00 * 5;
	var_02 = 0;
	for(;;)
	{
		wait(var_00);
		if(!self.aggroattackready)
		{
			var_02 = var_02 + var_00;
		}

		if(var_02 < 15)
		{
			continue;
		}

		self.aggrodamage = max(self.aggrodamage,0);
		if(self.aggrodamage < 2000)
		{
			continue;
		}

		self.aggroattackready = 1;
		var_02 = 0;
	}
}

//Function Number: 43
meleegoliathshouldplaystophitreaction()
{
	if(self.aistate == "melee" && !self.aggroattackready)
	{
		return 1;
	}

	return 0;
}

//Function Number: 44
ondamagepainsensor(param_00,param_01,param_02)
{
	self.aggrodamage = self.aggrodamage + param_00;
}

//Function Number: 45
meleegoliathmodifyplayerequipmentdamage(param_00,param_01,param_02)
{
	if(!isdefined(self.goliathshield))
	{
		return param_01;
	}

	var_03 = self.goliathshield gettagorigin("tag_origin") - self.origin * (1,1,0);
	var_04 = param_02 - self.origin * (1,1,0);
	if(vectordot(var_03,var_04) > 0)
	{
		return int(param_01 * 0.2);
	}

	return param_01;
}

//Function Number: 46
meleegoliathmodifycauterizerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return int(param_02 * 0.7);
}

//Function Number: 47
meleegoliathmodifys12damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return int(param_02 * 0.7);
}

//Function Number: 48
meleegoliathmodifylinegundamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	return int(param_02 * 0.7);
}

//Function Number: 49
onmeleegoliathkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = self.body;
	maps\mp\zombies\_zombies::onzombiekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	if(isdefined(param_01) && isplayer(param_01) && param_03 == "MOD_MELEE")
	{
		param_01 maps\mp\gametypes\zombies::givezombieachievement("DLC2_ZOMBIE_LOVETAP");
	}

	thread meleegoliathdeath(var_09,self.goliathweapon,self.goliathshield);
	var_0A = ["nuke","ammo"];
	var_0B = var_0A[common_scripts\utility::mod(level.meleegoliathspawned,var_0A.size)];
	if(level.roundtype == "zombie_melee_goliath")
	{
		maps\mp\gametypes\zombies::createpickup(var_0B,self.origin);
	}
}

//Function Number: 50
meleegoliathdeath(param_00,param_01,param_02)
{
	var_03 = self getanimentry();
	var_04 = getanimlength(var_03);
	var_05 = 1;
	var_06 = getnotetracktimes(var_03,"explode");
	var_07 = var_04 / var_05 * var_06[0];
	param_00 = self.body;
	wait(var_07);
	param_01 delete();
	param_02 delete();
	if(!isdefined(param_00))
	{
		return;
	}

	if(level.nextgen)
	{
		param_00 spawngibparts();
	}

	param_00 playmeleezombiekilledfx();
}

//Function Number: 51
drawdebuglimb(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	while(var_04 <= param_02)
	{
		var_04 = var_04 + 0.05;
		wait 0.05;
	}
}

//Function Number: 52
playmeleezombiekilledfx()
{
	var_00 = common_scripts\utility::getfx("zombie_melee_goliath_death");
	var_01 = level.dismemberment["full"]["fxTagName"];
	var_02 = self gettagorigin(var_01);
	playfx(var_00,var_02);
	earthquake(randomfloatrange(0.75,1.25),0.35,var_02,256);
	self playsound("zmb_goliath_death_destruct");
	self hide();
	self hideallparts();
}

//Function Number: 53
spawngibparts()
{
	var_00 = [];
	var_01 = [];
	var_00[var_00.size] = "goliath_head_phys";
	var_00[var_00.size] = "goliath_l_arm_phys";
	var_01[var_01.size] = "J_Head";
	var_01[var_01.size] = "J_Shoulder_LE";
	if(randomfloat(1) < 0.5)
	{
		var_00[var_00.size] = "goliath_r_arm_phys";
		var_01[var_01.size] = "J_Shoulder_RI";
	}
	else
	{
		var_00[var_00.size] = "goliath_l_leg_phys";
		var_01[var_01.size] = "J_Hip_LE";
	}

	var_02 = 0;
	var_03 = 3;
	var_04 = 360 / var_03;
	var_05 = randomint(360);
	for(var_02 = 0;var_02 < var_03;var_02++)
	{
		var_06 = anglestoforward((0,common_scripts\utility::mod(var_05 + var_04 * var_02,360),0));
		var_07 = self gettagorigin("tag_origin") + (0,0,10);
		spawngib(var_00[var_02],var_07 + var_06 * 25,self gettagangles(var_01[var_02]),var_06);
	}
}

//Function Number: 54
spawngib(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",param_01);
	var_04 setmodel(param_00);
	var_04.angles = param_02;
	var_05 = (randomfloatrange(-2000,2000),randomfloatrange(-2000,2000),randomfloatrange(-2000,2000));
	var_06 = vectornormalize(common_scripts\utility::randomvectorincone((0,0,1.75) + param_03,15));
	var_04 physicslaunchclientwithimpulse(var_06 * 4000,var_05);
	var_04 deleteonhostmigration();
	if(level.nextdismemberedbodypartindex < level.dismemberedbodyparts.size)
	{
		level.dismemberedbodyparts[level.nextdismemberedbodypartindex] delete();
	}

	level.dismemberedbodyparts[level.nextdismemberedbodypartindex] = var_04;
	level.nextdismemberedbodypartindex = level.nextdismemberedbodypartindex + 1 % 20;
}

//Function Number: 55
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

//Function Number: 56
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

			if(isdefined(var_04.agent_type) && var_04.agent_type == "zombie_melee_goliath")
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

//Function Number: 57
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

//Function Number: 58
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

//Function Number: 59
ragdollagent(param_00,param_01,param_02,param_03,param_04)
{
	param_00.ragdollimmediately = 1;
	param_00 dodamage(param_00.health + 1000,param_00 geteye(),self,undefined,param_02,"meleeGoliathFriendlyFire","none");
	var_05 = self.origin - param_01 + (0,0,8);
	wait(0.1);
	var_06 = randomfloatrange(3,5);
	physicsexplosionsphere(var_05,128,0,var_06,0);
}

//Function Number: 60
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

//Function Number: 61
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

		break;
	}

	self.weaponstate = 1;
}

//Function Number: 62
missilestartlocation()
{
	return self geteye() + (0,0,45);
}

//Function Number: 63
firemissile(param_00)
{
	var_01 = 32;
	self weaponlockstart(param_00);
	var_02 = missilestartlocation();
	var_03 = (randomintrange(-1 * var_01,var_01),randomintrange(-1 * var_01,var_01),randomintrange(-1 * var_01,var_01));
	var_04 = param_00 geteye() + var_03;
	var_05 = magicbullet("goliath_rocket_mp",var_02,var_04,self);
	var_05 missile_settargetent(param_00,(0,0,32));
	var_05.owner = self;
	var_05 thread empmissile();
}

//Function Number: 64
empmissile()
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	var_00 = squared(150);
	var_01 = self.origin;
	playfx(level._effect["zombie_melee_goliath_emp"],var_01);
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

//Function Number: 65
updateweaponfiring()
{
	if(isdefined(self.threats) && self.aistate != "traverse")
	{
		foreach(var_01 in self.threats)
		{
			if(evaluate_threat_valid_threat(var_01) == -1 || evaluate_threat_behavior(var_01) == -1)
			{
				continue;
			}

			firemissile(var_01);
			wait(0.01);
		}
	}

	self.weaponstate = 2;
}

//Function Number: 66
updateweaponreloading()
{
	if(level.players.size > 1)
	{
		if(level.numgoliathrounds <= 1 && !maps\mp\zombies\_util::is_true(self.enhanced))
		{
			wait(randomfloatrange(10,15));
		}
		else
		{
			wait(randomfloatrange(6,8));
		}
	}
	else if(level.numgoliathrounds <= 1 && !maps\mp\zombies\_util::is_true(self.enhanced))
	{
		wait(randomfloatrange(15,20));
	}
	else
	{
		wait(randomfloatrange(10,15));
	}

	self.weaponstate = 0;
}

//Function Number: 67
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

//Function Number: 68
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

//Function Number: 69
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

//Function Number: 70
evaluate_threat_behavior(param_00)
{
	if(isdefined(param_00.empgrenaded) && param_00.empgrenaded == 1)
	{
		return -1;
	}

	if(!param_00 isjumping() && distance2dsquared(self.origin,param_00.origin) < 250000)
	{
		return -1;
	}

	return 1;
}

//Function Number: 71
evaluate_threat_range(param_00)
{
	var_01 = length(param_00.origin - self.origin);
	var_02 = max(1 - var_01 / 1500,0);
	return var_02;
}

//Function Number: 72
evaluate_threat_los(param_00)
{
	if(trace_to_enemy(missilestartlocation(),param_00,undefined))
	{
		return 1;
	}

	return -1;
}

//Function Number: 73
trace_to_enemy(param_00,param_01,param_02)
{
	var_03 = bullettrace(param_00,param_01 geteye(),0,self.goliathshield,0,0,0,0,0);
	return var_03["fraction"] == 1;
}

//Function Number: 74
evaluate_threat_melee_target(param_00)
{
	if(!isdefined(self.curmeleetarget))
	{
		return 1;
	}

	if(self.curmeleetarget == param_00 && lengthsquared(param_00.origin - self.origin) < squared(350))
	{
		return -1;
	}

	return 1;
}

//Function Number: 75
empblast(param_00)
{
	wait(param_00);
	var_01 = self gettagorigin("J_Ankle_RI");
	var_02 = squared(500);
	playfx(level._effect["zombie_melee_goliath_emp"],var_01);
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

//Function Number: 76
trycalculatesectororigingoliath(param_00,param_01,param_02,param_03)
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