/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_tracking_drone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 830 ms
 * Timestamp: 10/27/2023 2:08:40 AM
*******************************************************************/

//Function Number: 1
watchtrackingdroneusage()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	if(!isdefined(level.trackingdronesettings))
	{
		trackingdroneinit();
	}

	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = maps\mp\_utility::strip_suffix(var_01,"_lefthand");
		if(var_02 == "tracking_drone_mp")
		{
			var_00 thread destroy_tracking_drone_in_water();
			wait(0.5);
			if(!isremovedentity(var_00) && isdefined(var_00))
			{
				self.trackingdronestartposition = var_00.origin;
				self.trackingdronestartangles = var_00.angles;
				var_00 deletetrackingdrone();
				if(!prevent_tracking_drone_in_water(self.trackingdronestartposition))
				{
					tryusetrackingdrone(var_01);
				}
			}
		}
	}
}

//Function Number: 2
trackingdroneinit()
{
	level.trackingdronemaxperplayer = 1;
	level.trackingdronesettings = spawnstruct();
	level.trackingdronesettings.timeout = 20;
	level.trackingdronesettings.explosivetimeout = 30;
	level.trackingdronesettings.health = 999999;
	level.trackingdronesettings.maxhealth = 60;
	level.trackingdronesettings.vehicleinfo = "vehicle_tracking_drone_mp";
	level.trackingdronesettings.modelbase = "npc_drone_tracking";
	level.trackingdronesettings.fxid_sparks = loadfx("vfx/sparks/direct_hack_stun");
	level.trackingdronesettings.fxid_laser_glow = loadfx("vfx/lights/tracking_drone_laser_blue");
	level.trackingdronesettings.fxid_explode = loadfx("vfx/explosion/tracking_drone_explosion");
	level.trackingdronesettings.fxid_lethalexplode = loadfx("vfx/explosion/frag_grenade_default");
	level.trackingdronesettings.fxid_warning = loadfx("vfx/lights/light_tracking_drone_blink_warning");
	level.trackingdronesettings.fxid_enemy_light = loadfx("vfx/lights/light_tracking_drone_blink_enemy");
	level.trackingdronesettings.fxid_friendly_light = loadfx("vfx/lights/light_tracking_drone_blink_friendly");
	level.trackingdronesettings.fxid_thruster_down = loadfx("vfx/distortion/tracking_drone_distortion_down");
	level.trackingdronesettings.fxid_thruster_up = loadfx("vfx/distortion/tracking_drone_distortion_up");
	level.trackingdronesettings.fxid_engine_distort = loadfx("vfx/distortion/tracking_drone_distortion_hemi");
	level.trackingdronesettings.sound_explode = "veh_tracking_drone_explode";
	level.trackingdronesettings.sound_lock = "veh_tracking_drone_lock_lp";
	level.trackingdrones = [];
	foreach(var_01 in level.players)
	{
		var_01.is_being_tracked = 0;
	}

	level thread ontrackingplayerconnect();
	level.trackingdronetimeout = level.trackingdronesettings.timeout;
	level.explosivedronetimeout = level.trackingdronesettings.explosivetimeout;
	level.trackingdronedebugposition = 0;
	level.trackingdronedebugpositionforward = 65;
	level.trackingdronedebugpositionheight = 0;
}

//Function Number: 3
tryusetrackingdrone(param_00)
{
	var_01 = 1;
	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}
	else if(exceededmaxtrackingdrones())
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_01 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(!isdefined(self.trackingdronearray))
	{
		self.trackingdronearray = [];
	}

	if(self.trackingdronearray.size)
	{
		self.trackingdronearray = common_scripts\utility::array_removeundefined(self.trackingdronearray);
		if(self.trackingdronearray.size >= level.trackingdronemaxperplayer)
		{
			if(isdefined(self.trackingdronearray[0]))
			{
				self.trackingdronearray[0] thread trackingdrone_leave();
			}
		}
	}

	maps\mp\_utility::incrementfauxvehiclecount();
	var_02 = createtrackingdrone(param_00);
	if(!isdefined(var_02))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	var_02.weaponname = param_00;
	self.trackingdronearray[self.trackingdronearray.size] = var_02;
	level.trackingdrones = common_scripts\utility::array_removeundefined(level.trackingdrones);
	level.trackingdrones[level.trackingdrones.size] = var_02;
	thread starttrackingdrone(var_02);
	return 1;
}

//Function Number: 4
createtrackingdrone(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!param_01)
	{
		var_05 = self geteye();
		var_06 = anglestoforward(self getplayerangles());
		var_07 = self getplayerangles();
		var_06 = anglestoforward(var_07);
		var_08 = anglestoright(var_07);
		var_09 = var_06 * 50;
		var_0A = var_08 * 0;
		var_0B = 80;
		switch(self getstance())
		{
			case "stand":
				break;

			case "crouch":
				break;

			case "prone":
				break;
		}
	}
}

//Function Number: 5
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

//Function Number: 6
trackingdrone_lightfx(param_00,param_01)
{
	param_01 endon("disconnect");
	playfxontagforclients(param_00,self,"fx_light_1",param_01);
	wait(0.05);
	playfxontagforclients(param_00,self,"fx_light_2",param_01);
	wait(0.05);
	playfxontagforclients(param_00,self,"fx_light_3",param_01);
	wait(0.05);
	playfxontagforclients(param_00,self,"fx_light_4",param_01);
}

//Function Number: 7
trackingdrone_enemy_lightfx()
{
	self endon("death");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01) && issentient(var_01) && issentient(self) && var_01.team != self.team)
		{
			childthread trackingdrone_lightfx(level.trackingdronesettings.fxid_enemy_light,var_01);
			wait(0.2);
		}
	}
}

//Function Number: 8
trackingdrone_friendly_lightfx()
{
	self endon("death");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01) && issentient(var_01) && issentient(self) && var_01.team == self.team)
		{
			childthread trackingdrone_lightfx(level.trackingdronesettings.fxid_friendly_light,var_01);
			wait(0.2);
		}
	}

	thread watchconnectedplayfx();
	thread watchjoinedteamplayfx();
}

//Function Number: 9
drone_thrusterfx()
{
	self endon("death");
	foreach(var_01 in level.players)
	{
		wait(0.1);
		if(isdefined(var_01) && isdefined(self) && isdefined(level.trackingdronesettings.fxid_thruster_down))
		{
			playfxontagforclients(level.trackingdronesettings.fxid_thruster_down,self,"fx_thruster_down_F",var_01);
		}

		wait(0.1);
		if(isdefined(var_01) && isdefined(self) && isdefined(level.trackingdronesettings.fxid_thruster_down))
		{
			playfxontagforclients(level.trackingdronesettings.fxid_thruster_down,self,"fx_thruster_down_K",var_01);
		}

		wait(0.1);
		if(isdefined(var_01) && isdefined(self) && isdefined(level.trackingdronesettings.fxid_thruster_down))
		{
			playfxontagforclients(level.trackingdronesettings.fxid_thruster_down,self,"fx_thruster_down_L",var_01);
		}

		wait(0.1);
		if(isdefined(var_01) && isdefined(self) && isdefined(level.trackingdronesettings.fxid_thruster_down))
		{
			playfxontagforclients(level.trackingdronesettings.fxid_thruster_down,self,"fx_thruster_down_R",var_01);
		}

		wait(0.1);
		if(isdefined(var_01) && isdefined(self) && isdefined(level.trackingdronesettings.fxid_engine_distort))
		{
			playfxontagforclients(level.trackingdronesettings.fxid_engine_distort,self,"TAG_WEAPON",var_01);
		}

		wait(0.25);
	}

	for(;;)
	{
		level waittill("connected",var_01);
		var_01 waittill("spawned_player");
		wait(0.1);
		if(isdefined(var_01) && isdefined(self) && isdefined(level.trackingdronesettings.fxid_thruster_down))
		{
			playfxontagforclients(level.trackingdronesettings.fxid_thruster_down,self,"fx_thruster_down_F",var_01);
		}

		wait(0.1);
		if(isdefined(var_01) && isdefined(self) && isdefined(level.trackingdronesettings.fxid_thruster_down))
		{
			playfxontagforclients(level.trackingdronesettings.fxid_thruster_down,self,"fx_thruster_down_K",var_01);
		}

		wait(0.1);
		if(isdefined(var_01) && isdefined(self) && isdefined(level.trackingdronesettings.fxid_thruster_down))
		{
			playfxontagforclients(level.trackingdronesettings.fxid_thruster_down,self,"fx_thruster_down_L",var_01);
		}

		wait(0.1);
		if(isdefined(var_01) && isdefined(self) && isdefined(level.trackingdronesettings.fxid_thruster_down))
		{
			playfxontagforclients(level.trackingdronesettings.fxid_thruster_down,self,"fx_thruster_down_R",var_01);
		}

		wait(0.1);
		playfxontagforclients(level.trackingdronesettings.fxid_engine_distort,self,"TAG_WEAPON",var_01);
		wait(0.25);
	}
}

//Function Number: 10
watchconnectedplayfx()
{
	self endon("death");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 waittill("spawned_player");
		if(isdefined(var_00) && var_00.team == self.team)
		{
			childthread trackingdrone_lightfx(level.trackingdronesettings.fxid_friendly_light,var_00);
			wait(0.2);
		}
	}
}

//Function Number: 11
watchjoinedteamplayfx()
{
	self endon("death");
	for(;;)
	{
		level waittill("joined_team",var_00);
		var_00 waittill("spawned_player");
		if(isdefined(var_00) && var_00.team == self.team)
		{
			childthread trackingdrone_lightfx(level.trackingdronesettings.fxid_friendly_light,var_00);
			wait(0.2);
		}
	}
}

//Function Number: 12
starttrackingdrone(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 thread trackingdrone_followtarget();
	param_00 thread aud_drone_start_jets();
	if(isdefined(param_00.type))
	{
		if(param_00.type == "explosive_drone")
		{
			param_00 thread checkforexplosivegoal();
			return;
		}

		if(param_00.type == "tracking_drone" && !isdefined(level.ishorde))
		{
			param_00 thread trackingdrone_highlighttarget();
			return;
		}
	}
}

//Function Number: 13
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

//Function Number: 14
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
		playfx(level.trackingdronesettings.fxid_lethalexplode,self.origin,var_03,var_02);
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

//Function Number: 15
turnondangerlights()
{
	if(isdefined(self))
	{
		stopfxontag(level.trackingdronesettings.fxid_enemy_light,self,"tag_fx_beacon_0");
		stopfxontag(level.trackingdronesettings.fxid_enemy_light,self,"tag_fx_beacon_1");
		stopfxontag(level.trackingdronesettings.fxid_enemy_light,self,"tag_fx_beacon_2");
		stopfxontag(level.trackingdronesettings.fxid_friendly_light,self,"tag_fx_beacon_0");
		stopfxontag(level.trackingdronesettings.fxid_friendly_light,self,"tag_fx_beacon_1");
		stopfxontag(level.trackingdronesettings.fxid_friendly_light,self,"tag_fx_beacon_2");
	}

	wait(0.05);
	if(isdefined(self))
	{
		playfxontag(level.trackingdronesettings.fxid_warning,self,"tag_fx_beacon_0");
		playfxontag(level.trackingdronesettings.fxid_warning,self,"tag_fx_beacon_1");
	}

	wait(0.15);
	if(isdefined(self))
	{
		playfxontag(level.trackingdronesettings.fxid_warning,self,"tag_fx_beacon_2");
	}
}

//Function Number: 16
trackingdrone_followtarget()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self endon("leaving");
	self endon("exploding");
	if(!isdefined(self.owner))
	{
		thread trackingdrone_leave();
		return;
	}

	self.owner endon("disconnect");
	self endon("owner_gone");
	self vehicle_setspeed(self.followspeed,10,10);
	self.previoustrackedplayer = self.owner;
	self.trackedplayer = undefined;
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
			var_00 = self.maxtrackingrange * self.maxtrackingrange;
			var_01 = var_00;
			if(!isdefined(level.ishorde))
			{
				if(!isdefined(self.trackedplayer) || self.trackedplayer == self.owner)
				{
					foreach(var_03 in level.players)
					{
						if(isdefined(var_03) && isalive(var_03) && var_03.team != self.team && !var_03 maps\mp\_utility::_hasperk("specialty_blindeye"))
						{
							var_04 = distancesquared(self.origin,var_03.origin);
							if(var_04 < var_01)
							{
								var_01 = var_04;
								self.trackedplayer = var_03;
								thread watchplayerdeathdisconnect(var_03);
							}
						}
					}
				}
			}

			if(!isdefined(self.trackedplayer))
			{
				self.trackedplayer = self.owner;
			}

			if(isdefined(self.trackedplayer))
			{
				trackingdrone_movetoplayer(self.trackedplayer);
			}

			if(self.trackedplayer != self.previoustrackedplayer)
			{
				stophighlightingplayer(self.previoustrackedplayer);
				self.previoustrackedplayer = self.trackedplayer;
			}
		}

		wait(1);
	}
}

//Function Number: 17
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
			}

			thread trackingdrone_leave();
			return;
		}

		self.trackedplayer = undefined;
	}
}

//Function Number: 18
trackingdrone_movetoplayer(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("trackingDrone_moveToPlayer");
	self endon("trackingDrone_moveToPlayer");
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
				break;

			case "crouch":
				break;

			case "prone":
				break;
		}
	}
}

//Function Number: 19
trackingdrone_stopmovement()
{
	self setvehgoalpos(self.origin,1);
	self.intransit = 0;
	self.inactive = 1;
}

//Function Number: 20
trackingdrone_changeowner(param_00)
{
	maps\mp\_utility::incrementfauxvehiclecount();
	var_01 = param_00 createtrackingdrone(self.weaponname,1,self.origin,self.angles);
	if(!isdefined(var_01))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	if(!isdefined(param_00.trackingdronearray))
	{
		param_00.trackingdronearray = [];
	}

	param_00.trackingdronearray[param_00.trackingdronearray.size] = var_01;
	level.trackingdrones = common_scripts\utility::array_removeundefined(level.trackingdrones);
	level.trackingdrones[level.trackingdrones.size] = var_01;
	param_00 thread starttrackingdrone(var_01);
	if(isdefined(level.trackingdronesettings.fxid_sparks))
	{
		stopfxontag(level.trackingdronesettings.fxid_sparks,self,self.fx_tag0);
	}

	removetrackingdrone();
	return 1;
}

//Function Number: 21
trackingdrone_highlighttarget()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	if(!isdefined(self.owner))
	{
		thread trackingdrone_leave();
		return;
	}

	self.owner endon("disconnect");
	self.owner endon("joined_team");
	self.owner endon("joined_spectators");
	self.lasertag = spawn("script_model",self.origin);
	self.lasertag setmodel("tag_laser");
	if(isdefined(self.trackedplayer))
	{
		self.lasertag.origin = self gettagorigin("tag_weapon");
		var_00 = 20;
		var_01 = (randomfloat(var_00),randomfloat(var_00),randomfloat(var_00)) - (10,10,10);
		var_02 = 65;
		switch(self.trackedplayer getstance())
		{
			case "stand":
				break;

			case "crouch":
				break;

			case "prone":
				break;
		}
	}
}

//Function Number: 22
starthighlightingplayer(param_00)
{
	self.lasertag laseron("tracking_drone_laser");
	playfxontag(level.trackingdronesettings.fxid_laser_glow,self.lasertag,"tag_laser");
	if(isdefined(level.trackingdronesettings.sound_lock))
	{
		self playloopsound(level.trackingdronesettings.sound_lock);
	}

	param_00 setperk("specialty_radararrow",1,0);
	if(param_00.is_being_tracked == 0)
	{
		param_00.is_being_tracked = 1;
		param_00.trackedbyplayer = self.owner;
	}
}

//Function Number: 23
stophighlightingplayer(param_00)
{
	if(isdefined(self.lasertag))
	{
		self.lasertag laseroff();
		stopfxontag(level.trackingdronesettings.fxid_laser_glow,self.lasertag,"tag_laser");
	}

	if(isdefined(param_00))
	{
		if(isdefined(level.trackingdronesettings.sound_lock))
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

//Function Number: 24
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

//Function Number: 25
trackingdrone_watchforgoal()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("trackingDrone_watchForGoal");
	self endon("trackingDrone_watchForGoal");
	var_00 = common_scripts\utility::waittill_any_return("goal","near_goal","hit_goal");
	self.intransit = 0;
	self.inactive = 0;
	self notify("hit_goal");
}

//Function Number: 26
trackingdrone_watchdeath()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	thread trackingdronedestroyed();
}

//Function Number: 27
trackingdrone_watchtimeout()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	var_00 = level.trackingdronetimeout;
	if(self.type == "explosive_drone")
	{
		var_00 = level.explosivedronetimeout;
	}

	wait(var_00);
	thread trackingdrone_leave();
}

//Function Number: 28
trackingdrone_watchownerloss()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("owner_gone");
	thread trackingdrone_leave();
}

//Function Number: 29
trackingdrone_watchownerdeath()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	for(;;)
	{
		self.owner waittill("death");
		thread trackingdrone_leave();
	}
}

//Function Number: 30
trackingdrone_watchtargetdisconnect()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("trackingDrone_watchTargetDisconnect");
	self endon("trackingDrone_watchTargetDisconnect");
	self.trackedplayer waittill("disconnect");
	stophighlightingplayer(self.trackedplayer);
	trackingdrone_movetoplayer(self.owner);
}

//Function Number: 31
trackingdrone_watchroundend()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self endon("owner_gone");
	level common_scripts\utility::waittill_any("round_end_finished","game_ended");
	thread trackingdrone_leave();
}

//Function Number: 32
trackingdrone_watchhostmigration()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	level waittill("host_migration_begin");
	stophighlightingplayer(self.trackedplayer);
	trackingdrone_stopmovement();
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	thread trackingdrone_changeowner(self.owner);
}

//Function Number: 33
trackingdrone_leave()
{
	self endon("death");
	self notify("leaving");
	stophighlightingplayer(self.trackedplayer);
	trackingdroneexplode();
}

//Function Number: 34
ontrackingdronedeath(param_00,param_01,param_02,param_03)
{
	self notify("death");
}

//Function Number: 35
trackingdrone_watchdisable()
{
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		thread trackingdrone_stunned();
	}
}

//Function Number: 36
trackingdrone_stunned()
{
	self notify("trackingDrone_stunned");
	self endon("trackingDrone_stunned");
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	trackingdrone_stunbegin();
	wait(10);
	trackingdrone_stunend();
}

//Function Number: 37
trackingdrone_stunbegin()
{
	if(self.stunned)
	{
		return;
	}

	self.stunned = 1;
	if(isdefined(level.trackingdronesettings.fxid_sparks))
	{
		playfxontag(level.trackingdronesettings.fxid_sparks,self,self.fx_tag0);
	}

	thread stophighlightingplayer(self.trackedplayer);
	self.trackedplayer = undefined;
	self.previoustrackedplayer = self.owner;
	thread trackingdrone_stopmovement();
}

//Function Number: 38
trackingdrone_stunend()
{
	if(isdefined(level.trackingdronesettings.fxid_sparks))
	{
		killfxontag(level.trackingdronesettings.fxid_sparks,self,self.fx_tag0);
	}

	self.stunned = 0;
	self.inactive = 0;
}

//Function Number: 39
trackingdronedestroyed()
{
	if(!isdefined(self))
	{
		return;
	}

	stophighlightingplayer(self.trackedplayer);
	trackingdrone_stunend();
	trackingdroneexplode();
}

//Function Number: 40
trackingdroneexplode()
{
	if(isdefined(level.trackingdronesettings.fxid_explode))
	{
		playfx(level.trackingdronesettings.fxid_explode,self.origin);
	}

	if(isdefined(level.trackingdronesettings.sound_explode))
	{
		self playsound(level.trackingdronesettings.sound_explode);
	}

	self notify("explode");
	removetrackingdrone();
}

//Function Number: 41
deletetrackingdrone()
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

//Function Number: 42
removetrackingdrone()
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

	deletetrackingdrone();
}

//Function Number: 43
addtotrackingdronelist()
{
	level.trackingdrones[self getentitynumber()] = self;
}

//Function Number: 44
removefromtrackingdronelistondeath()
{
	var_00 = self getentitynumber();
	self waittill("death");
	level.trackingdrones[var_00] = undefined;
	level.trackingdrones = common_scripts\utility::array_removeundefined(level.trackingdrones);
}

//Function Number: 45
exceededmaxtrackingdrones()
{
	if(level.trackingdrones.size >= maps\mp\_utility::maxvehiclesallowed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 46
aud_drone_start_jets()
{
	self playloopsound("veh_tracking_drone_jets_lp");
}

//Function Number: 47
destroy_tracking_drone_in_water()
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
				if(isdefined(level.trackingdronesettings.fxid_explode))
				{
					playfx(level.trackingdronesettings.fxid_explode,self.origin);
				}

				if(isdefined(level.trackingdronesettings.sound_explode))
				{
					self playsound(level.trackingdronesettings.sound_explode);
				}

				deletetrackingdrone();
			}
		}

		wait(0.05);
	}
}

//Function Number: 48
prevent_tracking_drone_in_water(param_00)
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