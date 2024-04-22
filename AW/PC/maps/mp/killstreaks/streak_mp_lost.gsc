/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_lost.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 68
 * Decompile Time: 1010 ms
 * Timestamp: 4/22/2024 2:12:39 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.mp_lost_killstreak_duration = 40;
	precacheitem("iw5_dlcgun12loot6_mp");
	precacheshader("dpad_killstreak_lost_static");
	level.killstreakfuncs["mp_lost"] = ::tryusecleaningdrone;
	level.mapkillstreak = "mp_lost";
	level.mapkillstreakpickupstring = &"MP_LOST_MAP_KILLSTREAK_PICKUP";
	level.mp_lost_inuse = 0;
	level.cleaningdronemaxperplayer = 3;
	level.cleaningdronesettings = spawnstruct();
	level.cleaningdronesettings.health = 999999;
	level.cleaningdronesettings.maxhealth = 60;
	level.cleaningdronesettings.vehicleinfo = "vehicle_lost_drone_mp";
	level.cleaningdronesettings.modelbase = "Lost_attack_drone";
	level.cleaningdronesettings.fxid_sparks = loadfx("vfx/sparks/direct_hack_stun");
	level.cleaningdronesettings.fxid_laser_glow = loadfx("vfx/lights/tracking_drone_laser_blue");
	level.cleaningdronesettings.fxid_explode = loadfx("vfx/explosion/tracking_drone_explosion");
	level.cleaningdronesettings.fxid_spawn = loadfx("vfx/map/mp_lost/lost_attack_drone_spawn");
	level.cleaningdronesettings.fxid_hit = loadfx("vfx/map/mp_lost/lost_attack_drone_hit");
	level.cleaningdronesettings.fxid_lethalexplode = loadfx("vfx/explosion/frag_grenade_default");
	level.cleaningdronesettings.fxid_warning = loadfx("vfx/map/mp_lost/lost_attack_drone_lights_danger");
	level.cleaningdronesettings.fxid_enemy_light = loadfx("vfx/map/mp_lost/lost_attack_drone_lights_enemy");
	level.cleaningdronesettings.fxid_friendly_light = loadfx("vfx/map/mp_lost/lost_attack_drone_lights_friendly");
	level.cleaningdronesettings.fxid_thruster_forward = loadfx("vfx/distortion/drone_thruster_lost");
	level.cleaningdronesettings.fxid_thruster_attack = loadfx("vfx/distortion/lost_drone_attack");
	level.cleaningdronesettings.fxid_thruster_down = loadfx("vfx/distortion/lost_drone_distortion_hemi");
	level.cleaningdronesettings.sound_explode = "veh_tracking_drone_explode";
	level.cleaningdronesettings.sound_lock = "veh_tracking_drone_lock_lp";
	level.cleaningdrones = [];
	level.startpointlocations = common_scripts\utility::getstructarray("lost_drone_spawn_point","script_noteworthy");
	level.spawncratelocations = getentarray("lost_drone_spawn_crate","targetname");
	level.cleaningdronedone = 0;
	foreach(var_01 in level.players)
	{
		var_01.is_being_tracked = 0;
	}

	level thread ontrackingplayerconnect();
	level.cleaningdronedebugposition = 0;
	level.cleaningdronedebugpositionforward = 65;
	level.cleaningdronedebugpositionheight = 0;
}

//Function Number: 2
tryusecleaningdrone(param_00,param_01)
{
	var_02 = level.cleaningdronemaxperplayer;
	if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(level.mp_lost_inuse)
	{
		self iprintlnbold(&"MP_LOST_IN_USE");
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(maps\mp\_utility::isairdenied())
	{
		return 0;
	}

	if(maps\mp\_utility::isemped())
	{
		return 0;
	}

	var_03 = setlostdroneactive();
	if(isdefined(var_03) && var_03)
	{
		maps\mp\_matchdata::logkillstreakevent("mp_lost",self.origin);
	}

	level.cleaningdronedone = 0;
	foreach(var_05 in level.players)
	{
		var_05.is_being_tracked = 0;
	}

	if(!isdefined(level.cleaningdronecount))
	{
		level.cleaningdronecount = 0;
	}

	if(!isdefined(level.startpointlocations))
	{
		level.startpointlocations = common_scripts\utility::getstructarray("lost_drone_spawn_point","script_noteworthy");
	}

	for(var_07 = 0;var_07 < level.cleaningdronemaxperplayer;var_07 = var_07 + 1)
	{
		maps\mp\_utility::incrementfauxvehiclecount();
		var_08 = createcleaningdrone();
		if(!isdefined(var_08))
		{
			maps\mp\_utility::decrementfauxvehiclecount();
			return 0;
		}

		level.cleaningdrones common_scripts\utility::add_to_array(level.cleaningdrones,var_08);
		level.cleaningdrones = common_scripts\utility::array_removeundefined(level.cleaningdrones);
		thread startcleaningdrone(var_08);
		var_08 thread cleaningdronemonitordeath();
		level.cleaningdronecount = level.cleaningdronecount + 1;
		wait(0.25);
	}

	thread cleaningdronespawnwaves();
	thread cleaningdronemonitortime();
	return 1;
}

//Function Number: 3
cleaningdronemonitortime()
{
	self endon("disconnect");
	level endon("game_ended");
	var_00 = level.mp_lost_killstreak_duration;
	wait(var_00);
	level.cleaningdronedone = 1;
	level.mp_lost_inuse = 0;
}

//Function Number: 4
cleaningdronespawnwaves()
{
	self endon("disconnect");
	level endon("game_ended");
	while(level.cleaningdronedone == 0)
	{
		if(level.cleaningdronecount < level.cleaningdronemaxperplayer)
		{
			var_00 = createcleaningdrone();
			if(!isdefined(var_00))
			{
				maps\mp\_utility::decrementfauxvehiclecount();
				return 0;
			}

			level.cleaningdrones common_scripts\utility::add_to_array(level.cleaningdrones,var_00);
			level.cleaningdrones = common_scripts\utility::array_removeundefined(level.cleaningdrones);
			level.cleaningdronecount = level.cleaningdronecount + 1;
			var_00 thread cleaningdronemonitordeath();
			thread startcleaningdrone(var_00);
			wait(2);
		}

		wait 0.05;
	}
}

//Function Number: 5
cleaningdronemonitordeath()
{
	common_scripts\utility::waittill_either("death","destroyed");
	level.cleaningdronecount = level.cleaningdronecount - 1;
}

//Function Number: 6
setlostdroneactive()
{
	if(level.mp_lost_inuse)
	{
		return 0;
	}

	level.mp_lost_inuse = 1;
	return 1;
}

//Function Number: 7
createcleaningdrone(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_05 = "nil";
	var_06 = "nil";
	var_07 = "nil";
	if(!param_01)
	{
		var_07 = common_scripts\utility::getclosest(self.origin,level.startpointlocations);
		level.startpointlocations = common_scripts\utility::array_remove(level.startpointlocations,var_07);
		thread clearspawnlocation(var_07);
		var_05 = var_07.origin;
		var_06 = var_07.angles;
	}

	var_08 = self;
	if(isdefined(level.ishorde) && level.ishorde)
	{
		var_08 = level.player;
	}

	var_09 = spawnhelicopter(var_08,var_05,var_06,level.cleaningdronesettings.vehicleinfo,level.cleaningdronesettings.modelbase);
	var_09 setmodel("tag_origin");
	var_09 hide();
	var_09.modelbase = spawn("script_model",var_05);
	var_09.modelbase.angles = (0,0,0);
	var_09.modelbase setmodel(level.cleaningdronesettings.modelbase);
	var_09 thread cleaningdrone_spawnanim(var_07);
	var_09.owner = self;
	var_0A = spawn("script_model",var_09.modelbase gettagorigin("tag_origin"));
	var_0A setmodel("tag_origin");
	var_0A vehicle_jetbikesethoverforcescale(var_09.modelbase,"tag_origin",(-40,0,10),(0,0,0));
	var_09.killcament = var_0A;
	var_09.killcament setscriptmoverkillcam("rocket");
	if(!isdefined(var_09))
	{
		return;
	}

	if(isdefined(param_04))
	{
		var_09.type = "cleaning_drone";
	}
	else
	{
		var_09.type = "cleaning_drone";
	}

	var_09 common_scripts\utility::make_entity_sentient_mp(self.team);
	var_09 makeunusable();
	var_09 makevehiclesolidcapsule(23,23,23);
	var_09 addtocleaningdronelist();
	var_09 thread removefromcleaningdronelistondeath();
	var_09.modelbase setcandamage(1);
	var_09.modelbase setcanradiusdamage(1);
	var_09.modelbase.health = level.cleaningdronesettings.health;
	var_09.modelbase.maxhealth = level.cleaningdronesettings.maxhealth;
	var_09.modelbase.damagetaken = 0;
	var_09.speed = 20;
	var_09.followspeed = 20;
	var_09.owner = self;
	var_09.team = self.team;
	var_09 vehicle_setspeed(var_09.speed,10,10);
	var_09 setyawspeed(120,90);
	var_09 setneargoalnotifydist(30);
	var_09 sethoverparams(4,5,5);
	var_09.fx_tag0 = undefined;
	if(isdefined(var_09.type))
	{
		if(var_09.type == "cleaning_drone")
		{
			var_09.fx_tag0 = "TAG_EYE";
		}
		else if(var_09.type == "explosive_drone")
		{
			var_09.fx_tag0 = "TAG_EYE";
		}
	}

	if(level.teambased)
	{
		var_09.modelbase maps\mp\_entityheadicons::setteamheadicon(self.team,(0,0,40),"TAG_ORIGIN");
	}
	else
	{
		var_09.modelbase maps\mp\_entityheadicons::setplayerheadicon(self.owner,(0,0,40),"TAG_ORIGIN");
	}

	var_09.maxtrackingrange = 80000;
	var_09.startattackrange = 450;
	var_09.maxattackrange = 300;
	var_09.minattackrange = 100;
	var_09.trackedplayer = undefined;
	var_0B = 45;
	var_0C = 45;
	var_09 setmaxpitchroll(var_0B,var_0C);
	var_09.targetpos = var_05;
	var_09.attract_strength = 10000;
	var_09.attract_range = 500;
	var_09.hasdodged = 0;
	var_09.stunned = 0;
	var_09.inactive = 0;
	var_09.modelbase thread maps\mp\gametypes\_damage::setentitydamagecallback(var_09.modelbase.maxhealth,undefined,::oncleaningdronedeath,undefined,0);
	var_09.modelbase thread cleaningdrone_watchdamage();
	var_09 thread cleaningdrone_watchdisable();
	var_09.modelbase thread cleaningdrone_watchdeath(var_09);
	var_09 thread cleaningdrone_watchownerloss();
	var_09 thread cleaningdrone_watchownerdeath();
	var_09 thread cleaningdrone_watchroundend();
	var_09 thread cleaningdrone_watchhostmigration();
	var_09 thread cleaningdrone_watchtimeout();
	var_09 thread cleaningdrone_enemy_lightfx();
	var_09 thread cleaningdrone_friendly_lightfx();
	var_09.modelbase thread drone_thrusterfx(1.5);
	return var_09;
}

//Function Number: 8
cleaningdrone_watchdamage()
{
	self endon("death");
	self waittill("damage");
}

//Function Number: 9
clearspawnlocation(param_00)
{
	wait(6);
	level.startpointlocations = common_scripts\utility::array_add(level.startpointlocations,param_00);
}

//Function Number: 10
idletargetmover(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	var_01 = anglestoforward(self.angles);
	for(;;)
	{
		if(maps\mp\_utility::isreallyalive(self) && !maps\mp\_utility::isusingremote() && anglestoforward(self.angles) != var_01)
		{
			var_01 = anglestoforward(self.angles);
			var_02 = self.origin + var_01 * -100 + (0,0,40);
			param_00 moveto(var_02,0.5);
		}

		wait(0.5);
	}
}

//Function Number: 11
playfxontagforclients_alivecheck(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_03 endon("disconnect");
	while(!isalive(param_03))
	{
		wait 0.05;
	}

	playfxontagforclients(param_00,param_01,param_02,param_03);
}

//Function Number: 12
cleaningdrone_lightfx(param_00,param_01)
{
	self endon("death");
	param_01 endon("disconnect");
	while(!isalive(param_01))
	{
		wait 0.05;
	}

	playfxontagforclients(param_00,self.modelbase,"tag_origin",param_01);
}

//Function Number: 13
cleaningdrone_removelightfx()
{
	self endon("death");
	foreach(var_01 in level.players)
	{
		killfxontagforclient(level.cleaningdronesettings.fxid_enemy_light,self.modelbase,"tag_origin",var_01);
		killfxontagforclient(level.cleaningdronesettings.fxid_friendly_light,self.modelbase,"tag_origin",var_01);
	}
}

//Function Number: 14
cleaningdrone_enemy_lightfx()
{
	self endon("death");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01) && issentient(var_01) && issentient(self) && var_01.team != self.team)
		{
			childthread cleaningdrone_lightfx(level.cleaningdronesettings.fxid_enemy_light,var_01);
			wait 0.05;
		}
	}
}

//Function Number: 15
cleaningdrone_friendly_lightfx()
{
	self endon("death");
	self notify("killwatchplayfx");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01) && issentient(var_01) && issentient(self) && var_01.team == self.team)
		{
			childthread cleaningdrone_lightfx(level.cleaningdronesettings.fxid_friendly_light,var_01);
			wait 0.05;
		}
	}

	thread watchconnectedplayfx();
	thread watchjoinedteamplayfx();
}

//Function Number: 16
drone_thrusterfx(param_00)
{
	self endon("death");
	self notify("drone_thrusterFX");
	self endon("drone_thrusterFX");
	wait(param_00);
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02) && isdefined(self) && isdefined(level.cleaningdronesettings.fxid_thruster_forward))
		{
			playfxontagforclients_alivecheck(level.cleaningdronesettings.fxid_thruster_forward,self,"TAG_THRUSTER",var_02);
		}

		wait 0.05;
		if(isdefined(var_02) && isdefined(self) && isdefined(level.cleaningdronesettings.fxid_thruster_down))
		{
			playfxontagforclients_alivecheck(level.cleaningdronesettings.fxid_thruster_down,self,"TAG_THRUSTER_DOWN",var_02);
		}
	}

	for(;;)
	{
		level waittill("connected",var_02);
		var_02 waittill("spawned_player");
		if(isdefined(var_02) && isdefined(self) && isdefined(level.cleaningdronesettings.fxid_thruster_forward))
		{
			playfxontagforclients(level.cleaningdronesettings.fxid_thruster_forward,self,"TAG_THRUSTER",var_02);
		}

		wait 0.05;
		if(isdefined(var_02) && isdefined(self) && isdefined(level.cleaningdronesettings.fxid_thruster_down))
		{
			playfxontagforclients(level.cleaningdronesettings.fxid_thruster_down,self,"TAG_THRUSTER_DOWN",var_02);
		}
	}
}

//Function Number: 17
drone_thrusterattackfx()
{
	playfxontag(level.cleaningdronesettings.fxid_thruster_attack,self,"TAG_THRUSTER");
	thread aud_drone_thrusterattack();
}

//Function Number: 18
watchconnectedplayfx()
{
	self endon("death");
	self endon("killwatchplayfx");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 waittill("spawned_player");
		if(isdefined(var_00) && var_00.team == self.team)
		{
			childthread cleaningdrone_lightfx(level.cleaningdronesettings.fxid_friendly_light,var_00);
			wait(0.2);
		}
	}
}

//Function Number: 19
watchjoinedteamplayfx()
{
	self endon("death");
	self endon("killwatchplayfx");
	for(;;)
	{
		level waittill("joined_team",var_00);
		var_00 waittill("spawned_player");
		if(isdefined(var_00) && var_00.team == self.team)
		{
			childthread cleaningdrone_lightfx(level.cleaningdronesettings.fxid_friendly_light,var_00);
			wait(0.2);
		}
	}
}

//Function Number: 20
startcleaningdrone(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	wait(1.6);
	param_00 thread cleaningdrone_followtarget();
	param_00 thread aud_drone_start_jets();
	if(isdefined(param_00.type))
	{
		if(param_00.type == "explosive_drone")
		{
			param_00 thread checkforexplosivegoal();
			return;
		}

		if(param_00.type == "cleaning_drone" && !isdefined(level.ishorde))
		{
			param_00 thread cleaningdroneattacktarget();
			return;
		}
	}
}

//Function Number: 21
cleaningdrone_spawnanim(param_00)
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self endon("leaving");
	thread aud_drone_launch();
	var_01 = common_scripts\utility::getclosest(param_00.origin,level.spawncratelocations);
	var_01 scriptmodelplayanim("lost_attack_drone_spawn_crate");
	playfx(level.cleaningdronesettings.fxid_spawn,var_01.origin,anglestoforward(var_01.angles + (270,0,0)));
	self.modelbase scriptmodelplayanimdeltamotionfrompos("lost_attack_drone_spawn",param_00.origin,param_00.angles);
	wait(1.6);
	self.modelbase scriptmodelclearanim();
	self.modelbase scriptmodelplayanim("lost_attack_drone_spin_idle");
	self vehicle_teleport(self.modelbase.origin,self.modelbase.angles);
	self.modelbase vehicle_jetbikesethoverforcescale(self,"tag_origin",(0,0,0),(0,0,0));
}

//Function Number: 22
checkforexplosivegoal()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self endon("leaving");
	for(;;)
	{
		common_scripts\utility::waittill_any("goal","near_goal","hit_goal");
		if(self.trackedplayer != self.owner && maps\mp\_utility::isreallyalive(self.trackedplayer))
		{
			var_00 = distancesquared(self.trackedplayer.origin,self.origin);
			if(var_00 <= 16384)
			{
				self notify("exploding");
				thread blowupdronesequence();
				break;
			}
		}
	}
}

//Function Number: 23
blowupdronesequence()
{
	var_00 = 2;
	var_01 = undefined;
	if(isdefined(self.owner))
	{
		var_01 = self.owner;
	}

	if(isdefined(self))
	{
		thread turnondangerlights();
		self playsound("drone_warning_beap");
	}

	wait(var_00);
	if(isdefined(self))
	{
		self playsound("drone_bomb_explosion");
		var_02 = anglestoup(self.angles);
		var_03 = anglestoforward(self.angles);
		playfx(level.cleaningdronesettings.fxid_lethalexplode,self.origin,var_03,var_02);
		if(isdefined(var_01))
		{
			self radiusdamage(self.origin,256,1000,25,var_01,"MOD_EXPLOSIVE","killstreak_missile_strike_mp");
		}
		else
		{
			self radiusdamage(self.origin,256,1000,25,undefined,"MOD_EXPLOSIVE","killstreak_missile_strike_mp");
		}

		self notify("death");
	}
}

//Function Number: 24
turnondangerlights()
{
	if(isdefined(self))
	{
		cleaningdrone_removelightfx();
	}

	wait(0.05);
	if(isdefined(self))
	{
		playfxontag(level.cleaningdronesettings.fxid_warning,self.modelbase,"tag_origin");
	}
}

//Function Number: 25
cleaningdrone_followtarget()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self endon("leaving");
	self endon("exploding");
	if(!isdefined(self.owner))
	{
		thread cleaningdrone_leave();
		return;
	}

	self.owner endon("disconnect");
	self endon("owner_gone");
	self vehicle_setspeed(self.followspeed,10,10);
	self.previoustrackedplayer = self.owner;
	self.trackedplayer = undefined;
	var_00 = [];
	if(isdefined(level.ishorde) && level.ishorde)
	{
		self.trackedplayer = self.owner;
	}

	for(;;)
	{
		if(isdefined(self.stunned) && self.stunned)
		{
			wait(0.5);
			continue;
		}

		if(isdefined(self.owner) && isalive(self.owner))
		{
			var_01 = self.maxtrackingrange * self.maxtrackingrange;
			var_02 = var_01;
			if(!isdefined(level.ishorde))
			{
				if(!isdefined(self.trackedplayer) || self.trackedplayer == self.owner || !isalive(self.trackedplayer))
				{
					foreach(var_04 in level.players)
					{
						if(isdefined(var_04) && isalive(var_04) && var_04.team != self.team && !var_04 maps\mp\_utility::_hasperk("specialty_blindeye") && checkplayertracked(var_04) == 0)
						{
							var_00 = common_scripts\utility::array_add(var_00,var_04);
						}
					}

					var_06 = common_scripts\utility::getclosest(self.origin,var_00);
					self.trackedplayer = var_06;
					var_00 = "nil";
					var_00 = [];
				}
			}

			if(isdefined(self.trackedplayer) && checkplayertracked(self.trackedplayer) == 0)
			{
				thread cleaningdrone_movetoplayer(self.trackedplayer);
				thread setplayertracked(self.trackedplayer);
				thread watchplayerdeathdisconnect(self.trackedplayer);
			}
			else if(!isdefined(self.goalnode))
			{
				thread cleaningdrone_followowner();
				thread cleaningdrone_watchforgoal();
			}
		}

		wait 0.05;
	}
}

//Function Number: 26
checkplayertracked(param_00)
{
	if(!isdefined(param_00.istracked))
	{
		param_00.istracked = 0;
		return 0;
	}

	if(param_00.istracked == 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 27
clearplayertracked(param_00)
{
	param_00.istracked = 0;
}

//Function Number: 28
setplayertracked(param_00)
{
	param_00.istracked = 1;
	thread clearplayertrackedondronedeath(param_00);
	param_00 common_scripts\utility::waittill_either("death","leaving");
	param_00.istracked = 0;
}

//Function Number: 29
clearplayertrackedondronedeath(param_00)
{
	common_scripts\utility::waittill_either("death","destroyed");
	if(isalive(param_00))
	{
		if(isdefined(param_00.istracked))
		{
			param_00.istracked = 0;
		}
	}
}

//Function Number: 30
watchplayerdeathdisconnect(param_00)
{
	self endon("death");
	self endon("leaving");
	self endon("exploding");
	param_00 common_scripts\utility::waittill_any("death","disconnect","faux_spawn","joined_team");
	if(isdefined(param_00))
	{
		if(param_00.is_being_tracked == 1)
		{
			if(!isalive(param_00))
			{
				param_00.died_being_tracked = 1;
				thread cleaningdrone_leave();
				return;
			}

			return;
		}

		self.trackedplayer = undefined;
	}
}

//Function Number: 31
cleaningdrone_movetoplayer(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("cleaningDrone_moveToPlayer");
	self endon("cleaningDrone_moveToPlayer");
	self notify("clear_goal");
	self.goalnode = "nil";
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	if(isdefined(level.ishorde) && level.ishorde)
	{
		var_01 = 0;
		var_02 = 30;
		switch(param_00 getstance())
		{
			case "stand":
				var_03 = 105;
				break;

			case "crouch":
				var_03 = 75;
				break;

			case "prone":
				var_03 = 45;
				break;
		}
	}
	else
	{
		var_01 = -65;
		var_02 = 0;
		switch(param_00 getstance())
		{
			case "stand":
				var_03 = 65;
				break;

			case "crouch":
				var_03 = 50;
				break;

			case "prone":
				var_03 = 22;
				break;
		}
	}

	var_04 = (var_02,var_01,var_03);
	self setdronegoalpos(param_00,var_04);
	self.intransit = 1;
	thread cleaningdrone_watchforgoal();
	thread cleaningdrone_watchtargetdisconnect();
}

//Function Number: 32
cleaningdrone_followowner()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("cleaningDrone_moveToOwner");
	self endon("cleaningDrone_moveToOwner");
	var_00 = (randomintrange(100,300),randomintrange(100,300),105);
	self setdronegoalpos(self.owner,var_00);
	self.intransit = 1;
	thread cleaningdrone_watchforgoal();
}

//Function Number: 33
cleaningdrone_stopmovement()
{
	self setvehgoalpos(self.origin,1);
	self.intransit = 0;
	self.inactive = 1;
}

//Function Number: 34
cleaningdrone_changeowner(param_00)
{
	maps\mp\_utility::incrementfauxvehiclecount();
	var_01 = param_00 createcleaningdrone(undefined,1,self.origin,self.angles);
	if(!isdefined(var_01))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	if(!isdefined(param_00.cleaningdronearray))
	{
		param_00.cleaningdronearray = [];
	}

	param_00.cleaningdronearray[param_00.cleaningdronearray.size] = var_01;
	level.cleaningdrones = common_scripts\utility::array_removeundefined(level.cleaningdrones);
	level.cleaningdrones[level.trackingdrones.size] = var_01;
	param_00 thread startcleaningdrone(var_01);
	if(isdefined(level.drone_settings.fxid_sparks))
	{
		stopfxontag(level.cleaningdronesettings.fxid_sparks,self,self.fx_tag0);
	}

	removecleaningdrone();
	return 1;
}

//Function Number: 35
attack_anim_check(param_00,param_01)
{
	var_02 = 24;
	var_03 = var_02 * 2;
	var_04 = self.origin;
	var_05 = var_04 + param_01 * param_00;
	var_06 = self aiphysicstrace(var_04,var_05,var_02,var_03,1,1);
	return var_06["fraction"] >= 1;
}

//Function Number: 36
do_stationary_attack()
{
	thread cleaningdrone_removelightfx();
	wait 0.05;
	self.modelbase unlink();
	var_00 = self.trackedplayer.origin + (0,0,40) - self.modelbase.origin;
	var_00 = vectornormalize(var_00);
	var_01 = vectortoangles(var_00);
	self.modelbase scriptmodelplayanimdeltamotionfrompos("lost_attack_drone_stationary_attack",self.modelbase.origin,var_01);
	self.drone_anim_state = "lost_attack_drone_stationary_attack";
	childthread cleaningdrone_attack();
	childthread cleaningdrone_collide(self.trackedplayer);
	childthread cleaningdrone_targetdead(self.trackedplayer,var_01);
	self.modelbase childthread drone_thrusterattackfx();
	common_scripts\utility::waittill_any_timeout(0.4,"damage_stop","hit");
	if(isalive(self.trackedplayer))
	{
		self.modelbase scriptmodelclearanim();
		self.modelbase scriptmodelplayanim("lost_attack_drone_spin_down");
		self.drone_anim_state = "lost_attack_drone_spin_down";
		self vehicle_teleport(self.modelbase.origin,self.modelbase.angles);
		self.modelbase vehicle_jetbikesethoverforcescale(self,"tag_origin",(0,0,0),(0,0,0));
		wait(0.66);
		self notify("damage_stop");
		self.modelbase scriptmodelplayanim("lost_attack_drone_spin_idle");
		self.drone_anim_state = "lost_attack_drone_spin_idle";
		self.modelbase thread drone_thrusterfx(0);
		thread cleaningdrone_enemy_lightfx();
		thread cleaningdrone_friendly_lightfx();
		return;
	}

	self.modelbase scriptmodelclearanim();
	self.modelbase scriptmodelplayanimdeltamotion("lost_attack_drone_react");
	self.drone_anim_state = "lost_attack_drone_spin_react";
	wait(2);
	self.modelbase scriptmodelclearanim();
	self vehicle_teleport(self.modelbase.origin,self.modelbase.angles);
	self.modelbase vehicle_jetbikesethoverforcescale(self,"tag_origin",(0,0,0),(0,0,0));
	self.modelbase scriptmodelplayanim("lost_attack_drone_spin_idle");
	self.drone_anim_state = "lost_attack_drone_spin_idle";
	self.modelbase thread drone_thrusterfx(0);
	thread cleaningdrone_enemy_lightfx();
	thread cleaningdrone_friendly_lightfx();
}

//Function Number: 37
cleaningdroneattacktarget()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	if(!isdefined(self.owner))
	{
		thread cleaningdrone_leave();
		return;
	}

	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	self.drone_anim_state = "lost_attack_drone_spin_idle";
	for(;;)
	{
		if(isdefined(self.trackedplayer) && self.trackedplayer != self.owner && distancesquared(self.origin,self.trackedplayer.origin) < self.startattackrange * self.startattackrange && 0.8 < self sightconetrace(self.trackedplayer.origin + (0,0,40),self.trackedplayer))
		{
			self.modelbase scriptmodelclearanim();
			self.modelbase scriptmodelplayanim("lost_attack_drone_spin_up");
			self.drone_anim_state = "lost_attack_drone_spin_up";
			wait(1);
			if(isdefined(self.trackedplayer) && self.trackedplayer != self.owner && isalive(self.trackedplayer))
			{
				var_00 = 0.8 < self sightconetrace(self.trackedplayer.origin + (0,0,40),self.trackedplayer);
				if(var_00)
				{
					var_01 = distancesquared(self.origin,self.trackedplayer.origin);
					if(var_01 < self.maxattackrange * self.maxattackrange && var_01 > self.minattackrange * self.minattackrange)
					{
						var_02 = self.trackedplayer.origin + (0,0,40) - self.origin;
						var_02 = vectornormalize(var_02);
						var_03 = attack_anim_check(var_02,self.maxattackrange);
						if(var_03)
						{
							thread cleaningdrone_removelightfx();
							wait 0.05;
							self.modelbase unlink();
							var_04 = vectortoangles(var_02);
							self.modelbase scriptmodelplayanimdeltamotionfrompos("lost_attack_drone_attack",self.modelbase.origin,var_04);
							self.drone_anim_state = "lost_attack_drone_attack";
							childthread cleaningdrone_attack();
							childthread cleaningdrone_collide(self.trackedplayer);
							childthread cleaningdrone_targetdead(self.trackedplayer,var_04);
							self.modelbase childthread drone_thrusterattackfx();
							common_scripts\utility::waittill_any_timeout(0.8,"damage_stop","hit");
							if(isalive(self.trackedplayer))
							{
								self.modelbase scriptmodelclearanim();
								self.modelbase scriptmodelplayanim("lost_attack_drone_spin_down");
								self.drone_anim_state = "lost_attack_drone_spin_down";
								self vehicle_teleport(self.modelbase.origin,self.modelbase.angles);
								self.modelbase vehicle_jetbikesethoverforcescale(self,"tag_origin",(0,0,0),(0,0,0));
								wait(0.66);
								self notify("damage_stop");
								self.modelbase scriptmodelplayanim("lost_attack_drone_spin_idle");
								self.drone_anim_state = "lost_attack_drone_spin_idle";
								self.modelbase thread drone_thrusterfx(0);
								thread cleaningdrone_enemy_lightfx();
								thread cleaningdrone_friendly_lightfx();
							}
							else
							{
								self.modelbase scriptmodelclearanim();
								self.modelbase scriptmodelplayanimdeltamotion("lost_attack_drone_react");
								self.drone_anim_state = "lost_attack_drone_react";
								wait(2);
								self.modelbase scriptmodelclearanim();
								self vehicle_teleport(self.modelbase.origin,self.modelbase.angles);
								self.modelbase vehicle_jetbikesethoverforcescale(self,"tag_origin",(0,0,0),(0,0,0));
								self.modelbase scriptmodelplayanim("lost_attack_drone_spin_idle");
								self.drone_anim_state = "lost_attack_drone_spin_idle";
								self.modelbase thread drone_thrusterfx(0);
								thread cleaningdrone_enemy_lightfx();
								thread cleaningdrone_friendly_lightfx();
							}
						}
						else
						{
							thread cleaningdrone_movetoplayer(self.trackedplayer);
						}
					}
					else if(var_01 <= self.minattackrange * self.minattackrange && var_01 > self.minattackrange - 25 * self.minattackrange - 25)
					{
						var_02 = self.trackedplayer.origin + (0,0,40) - self.origin;
						var_02 = vectornormalize(var_02);
						var_03 = attack_anim_check(var_02,80);
						if(var_03)
						{
							thread cleaningdrone_removelightfx();
							wait 0.05;
							self.modelbase unlink();
							var_04 = vectortoangles(var_02);
							self.modelbase scriptmodelplayanimdeltamotionfrompos("lost_attack_drone_100_attack",self.modelbase.origin,var_04);
							self.drone_anim_state = "lost_attack_drone_100_attack";
							childthread cleaningdrone_attack();
							childthread cleaningdrone_collide(self.trackedplayer);
							childthread cleaningdrone_targetdead(self.trackedplayer,var_04);
							self.modelbase childthread drone_thrusterattackfx();
							common_scripts\utility::waittill_any_timeout(0.4,"damage_stop","hit");
							if(isalive(self.trackedplayer))
							{
								self.modelbase scriptmodelclearanim();
								self.modelbase scriptmodelplayanim("lost_attack_drone_spin_down");
								self.drone_anim_state = "lost_attack_drone_spin_down";
								self vehicle_teleport(self.modelbase.origin,self.modelbase.angles);
								self.modelbase vehicle_jetbikesethoverforcescale(self,"tag_origin",(0,0,0),(0,0,0));
								wait(0.66);
								self notify("damage_stop");
								self.modelbase scriptmodelplayanim("lost_attack_drone_spin_idle");
								self.drone_anim_state = "lost_attack_drone_spin_idle";
								self.modelbase thread drone_thrusterfx(0);
								thread cleaningdrone_enemy_lightfx();
								thread cleaningdrone_friendly_lightfx();
							}
							else
							{
								self.modelbase scriptmodelclearanim();
								self.modelbase scriptmodelplayanimdeltamotion("lost_attack_drone_react");
								self.drone_anim_state = "lost_attack_drone_spin_react";
								wait(2);
								self.modelbase scriptmodelclearanim();
								self vehicle_teleport(self.modelbase.origin,self.modelbase.angles);
								self.modelbase vehicle_jetbikesethoverforcescale(self,"tag_origin",(0,0,0),(0,0,0));
								self.modelbase scriptmodelplayanim("lost_attack_drone_spin_idle");
								self.drone_anim_state = "lost_attack_drone_spin_idle";
								self.modelbase thread drone_thrusterfx(0);
								thread cleaningdrone_enemy_lightfx();
								thread cleaningdrone_friendly_lightfx();
							}
						}
						else
						{
							thread cleaningdrone_movetoplayer(self.trackedplayer);
						}
					}
					else if(var_01 <= self.minattackrange - 25 * self.minattackrange - 25)
					{
						do_stationary_attack();
					}
				}
			}
			else
			{
				self.modelbase scriptmodelplayanim("lost_attack_drone_spin_idle");
				self.drone_anim_state = "lost_attack_drone_spin_idle";
			}
		}
		else if(self.drone_anim_state != "lost_attack_drone_spin_idle")
		{
			self.modelbase scriptmodelplayanim("lost_attack_drone_spin_idle");
			self.drone_anim_state = "lost_attack_drone_spin_idle";
		}

		wait 0.05;
	}
}

//Function Number: 38
cleaningdrone_attack()
{
	self endon("damage_stop");
	self.owner endon("disconnect");
	while(isdefined(self.modelbase))
	{
		var_00 = 50;
		self radiusdamage(self.modelbase.origin,var_00,500,100,self,"MOD_EXPLOSIVE","iw5_dlcgun12loot6_mp");
		wait 0.05;
	}
}

//Function Number: 39
cleaningdrone_targetdead(param_00,param_01)
{
	self endon("damage_stop");
	param_00 waittill("death");
	var_02 = param_00.body gettagorigin("j_neck");
	playfx(level.cleaningdronesettings.fxid_hit,var_02);
	playimpactheadfatalfx(var_02,var_02 - self.origin);
	self notify("target_dead");
	self notify("damage_stop");
}

//Function Number: 40
cleaningdrone_collide(param_00)
{
	self endon("damage_stop");
	self waittill("touch",var_01);
	if(var_01 != param_00 && var_01 != self.modelbase)
	{
		self notify("hit");
	}
}

//Function Number: 41
stophighlightingplayer(param_00)
{
	if(isdefined(self.lasertag))
	{
		self.lasertag laseroff();
		stopfxontag(level.cleaningdronesettings.fxid_laser_glow,self.lasertag,"tag_laser");
	}

	if(isdefined(param_00))
	{
		if(isdefined(level.cleaningdronesettings.sound_lock))
		{
			self stoploopsound();
		}

		if(param_00 hasperk("specialty_radararrow",1))
		{
			param_00 unsetperk("specialty_radararrow",1);
		}

		param_00 notify("player_not_tracked");
		param_00.is_being_tracked = 0;
		param_00.trackedbyplayer = undefined;
	}
}

//Function Number: 42
ontrackingplayerconnect()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.is_being_tracked = 0;
		foreach(var_00 in level.players)
		{
			if(!isdefined(var_00.is_being_tracked))
			{
				var_00.is_being_tracked = 0;
			}
		}
	}
}

//Function Number: 43
cleaningdrone_watchforgoal()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self endon("cleaningDrone_watchForGoal");
	self endon("cleaningDrone_moveToOwner");
	var_00 = common_scripts\utility::waittill_any_return("goal","near_goal","hit_goal","clear_goal");
	self notify("cleaningDrone_watchForGoal");
	self notify("cleaningDrone_moveToOwner");
	self.intransit = 0;
	self.inactive = 0;
	self notify("hit_goal");
	self.goalnode = "nil";
}

//Function Number: 44
cleaningdrone_watchdeath(param_00)
{
	level endon("game_ended");
	param_00 endon("gone");
	self waittill("death");
	param_00 notify("death");
	param_00 thread cleaningdronedestroyed();
}

//Function Number: 45
cleaningdrone_watchtimeout()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	while(level.cleaningdronedone == 0)
	{
		wait 0.05;
	}

	thread cleaningdrone_leave();
}

//Function Number: 46
cleaningdrone_watchownerloss()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("owner_gone");
	thread cleaningdrone_leave();
}

//Function Number: 47
cleaningdrone_watchownerdeath()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	for(;;)
	{
		self.owner waittill("death");
		thread cleaningdrone_leave();
	}
}

//Function Number: 48
cleaningdrone_watchtargetdisconnect()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("cleaningDrone_watchTargetDisconnect");
	self endon("cleaningDrone_watchTargetDisconnect");
	self.trackedplayer waittill("disconnect");
	stophighlightingplayer(self.trackedplayer);
	cleaningdrone_movetoplayer(self.owner);
}

//Function Number: 49
cleaningdrone_watchroundend()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self endon("owner_gone");
	level common_scripts\utility::waittill_any("round_end_finished","game_ended");
	thread cleaningdrone_leave();
}

//Function Number: 50
cleaningdrone_watchhostmigration()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	level waittill("host_migration_begin");
	stophighlightingplayer(self.trackedplayer);
	cleaningdrone_stopmovement();
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	thread cleaningdrone_changeowner(self.owner);
}

//Function Number: 51
cleaningdrone_leave()
{
	self endon("death");
	self notify("leaving");
	stophighlightingplayer(self.trackedplayer);
	cleaningdroneexplode();
}

//Function Number: 52
oncleaningdronedeath(param_00,param_01,param_02,param_03)
{
	self notify("death");
}

//Function Number: 53
cleaningdrone_watchdisable()
{
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		thread cleaningdrone_stunned();
	}
}

//Function Number: 54
cleaningdrone_stunned()
{
	self notify("cleaningDrone_stunned");
	self endon("cleaningDrone_stunned");
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	cleaningdrone_stunbegin();
	wait(10);
	cleaningdrone_stunend();
}

//Function Number: 55
cleaningdrone_stunbegin()
{
	if(self.stunned)
	{
		return;
	}

	self.stunned = 1;
	if(isdefined(level.cleaningdronesettings.fxid_sparks))
	{
	}

	thread stophighlightingplayer(self.trackedplayer);
	self.trackedplayer = undefined;
	self.previoustrackedplayer = self.owner;
	thread cleaningdrone_stopmovement();
}

//Function Number: 56
cleaningdrone_stunend()
{
	if(isdefined(level.cleaningdronesettings.fxid_sparks))
	{
	}

	self.stunned = 0;
	self.inactive = 0;
}

//Function Number: 57
cleaningdronedestroyed()
{
	if(!isdefined(self))
	{
		return;
	}

	stophighlightingplayer(self.trackedplayer);
	cleaningdrone_stunend();
	cleaningdrone_removelightfx();
	cleaningdroneexplode();
}

//Function Number: 58
cleaningdroneexplode()
{
	if(isdefined(level.cleaningdronesettings.fxid_explode))
	{
		playfx(level.cleaningdronesettings.fxid_explode,self.origin);
	}

	if(isdefined(level.cleaningdronesettings.sound_explode))
	{
		self playsound(level.cleaningdronesettings.sound_explode);
	}

	self notify("explode");
	self.modelbase scriptmodelclearanim();
	thread cleaningdrone_removelightfx();
	wait 0.05;
	self.modelbase unlink();
	self vehicle_teleport(self.modelbase.origin,self.modelbase.angles);
	self.modelbase delete();
	removecleaningdrone();
}

//Function Number: 59
deletecleaningdrone()
{
	if(!isremovedentity(self) && isdefined(self))
	{
		if(isdefined(self.attractor))
		{
			missile_deleteattractor(self.attractor);
		}

		self delete();
	}
}

//Function Number: 60
removecleaningdrone()
{
	maps\mp\_utility::decrementfauxvehiclecount();
	if(isdefined(self.owner) && isdefined(self.owner.trackingdrone))
	{
		self.owner.trackingdrone = undefined;
	}

	if(isdefined(self.lasertag))
	{
		self.lasertag delete();
	}

	deletecleaningdrone();
}

//Function Number: 61
addtocleaningdronelist()
{
	level.cleaningdrones[self getentitynumber()] = self;
}

//Function Number: 62
removefromcleaningdronelistondeath()
{
	var_00 = self getentitynumber();
	self waittill("death");
	level.cleaningdrones[var_00] = undefined;
	level.cleaningdrones = common_scripts\utility::array_removeundefined(level.cleaningdrones);
}

//Function Number: 63
exceededmaxcleaningdrones()
{
	if(level.cleaningdrones.size >= maps\mp\_utility::maxvehiclesallowed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 64
destroy_cleaning_drone_in_water()
{
	self endon("death");
	if(!isdefined(level.water_triggers))
	{
		return;
	}

	for(;;)
	{
		foreach(var_01 in level.water_triggers)
		{
			if(self istouching(var_01))
			{
				if(isdefined(level.cleaningdronesettings.fxid_explode))
				{
					playfx(level.cleaningdronesettings.fxid_explode,self.origin);
				}

				if(isdefined(level.cleaningdronesettings.sound_explode))
				{
					self playsound(level.cleaningdronesettings.sound_explode);
				}

				deletecleaningdrone();
			}
		}

		wait(0.05);
	}
}

//Function Number: 65
prevent_cleaning_drone_in_water(param_00)
{
	if(!isdefined(level.water_triggers))
	{
		return 0;
	}

	foreach(var_02 in level.water_triggers)
	{
		if(ispointinvolume(param_00,var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 66
aud_drone_launch()
{
	thread maps\mp\_audio::snd_play_in_space("veh_lost_tracking_drone_launch",self.origin);
	thread maps\mp\_audio::snd_play_in_space("veh_lost_tracking_drone_launch_lyr2",self.origin);
	thread maps\mp\_audio::snd_play_in_space("veh_lost_tracking_drone_launch_lyr3",self.origin);
	thread maps\mp\_audio::snd_play_in_space("veh_lost_tracking_drone_launch_lyr4",self.origin);
}

//Function Number: 67
aud_drone_start_jets()
{
	self playloopsound("veh_lost_tracking_drone_eng_low_lp");
}

//Function Number: 68
aud_drone_thrusterattack()
{
	var_00 = maps\mp\_audio::snd_play_linked("veh_lost_tracking_drone_attack",self);
}