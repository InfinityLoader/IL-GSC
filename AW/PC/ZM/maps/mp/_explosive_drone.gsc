/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_explosive_drone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 68
 * Decompile Time: 1065 ms
 * Timestamp: 10/27/2023 2:08:23 AM
*******************************************************************/

//Function Number: 1
watchexplosivedroneusage()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	if(!isdefined(level.explosivedronesettings))
	{
		explosivedroneinit();
	}

	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = maps\mp\_utility::strip_suffix(var_01,"_lefthand");
		if(var_02 == "explosive_drone_mp")
		{
			var_00.team = self.team;
			if(!isdefined(var_00.owner))
			{
				var_00.owner = self;
			}

			if(!isdefined(var_00.weaponname))
			{
				var_00.weaponname = var_01;
			}

			var_00 thread explosivedronelink();
		}
	}
}

//Function Number: 2
explosivedronelink()
{
	thread watchforstick();
	wait(0.1);
	if(isdefined(self))
	{
		self.explosivedrone = spawn("script_model",self.origin);
		self.explosivedrone.targetname = "explosive_drone_head_model";
		self.explosivedrone setmodel(level.explosivedronesettings.modelbase);
		self.explosivedrone.oldcontents = self.explosivedrone setcontents(0);
		self.explosivedrone linkto(self,"tag_spike",(0,0,0),(0,0,0));
		self.explosivedrone.owner = self.owner;
		var_00 = self.explosivedrone;
		var_00 thread cleanup_on_grenade_death(self);
		thread monitorspikedestroy();
		thread monitorheaddestroy();
	}
}

//Function Number: 3
cleanup_on_grenade_death(param_00)
{
	param_00 waittill("death");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 4
explosivegrenadedeath(param_00,param_01,param_02,param_03)
{
	if(isdefined(self))
	{
		self notify("death");
		if(isdefined(self.explosivedrone))
		{
			self.explosivedrone deleteexplosivedrone();
		}

		self delete();
	}
}

//Function Number: 5
explosiveheaddeath(param_00,param_01,param_02,param_03)
{
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 6
explosivedroneinit()
{
	level.explosivedronemaxperplayer = 1;
	level.explosivedronesettings = spawnstruct();
	level.explosivedronesettings.timeout = 20;
	level.explosivedronesettings.explosivetimeout = 30;
	level.explosivedronesettings.health = 60;
	level.explosivedronesettings.maxhealth = 60;
	level.explosivedronesettings.vehicleinfo = "vehicle_tracking_drone_mp";
	level.explosivedronesettings.modelbase = "npc_drone_explosive_main";
	level.explosivedronesettings.fxid_sparks = loadfx("vfx/sparks/direct_hack_stun");
	level.explosivedronesettings.fxid_laser_glow = loadfx("vfx/lights/tracking_drone_laser_blue");
	level.explosivedronesettings.fxid_explode = loadfx("vfx/explosion/explosive_drone_explosion");
	level.explosivedronesettings.fxid_lethalexplode = loadfx("vfx/explosion/explosive_drone_explosion");
	level.explosivedronesettings.fxid_enemy_light = loadfx("vfx/lights/light_explosive_drone_beacon_enemy");
	level.explosivedronesettings.fxid_friendly_light = loadfx("vfx/lights/light_explosive_drone_beacon_friendly");
	level.explosivedronesettings.fxid_engine_distort = loadfx("vfx/distortion/tracking_drone_distortion_hemi");
	level.explosivedronesettings.fxid_launch_thruster = loadfx("vfx/trail/explosive_drone_thruster_large");
	level.explosivedronesettings.fxid_position_thruster = loadfx("vfx/trail/explosive_drone_thruster_small");
	level.explosivedronesettings.sound_explode = "wpn_explosive_drone_exp";
	level.explosivedronesettings.sound_lock = "wpn_explosive_drone_lock";
	level.explosivedronesettings.sound_launch = "wpn_explosive_drone_open";
	foreach(var_01 in level.players)
	{
		var_01.is_being_tracked = 0;
	}

	level thread onexplosiveplayerconnect();
	level.explosivedronetimeout = level.explosivedronesettings.timeout;
	level.explosivedronetimeout = level.explosivedronesettings.explosivetimeout;
	level.explosivedronedebugposition = 0;
	level.explosivedronedebugpositionforward = 0;
	level.explosivedronedebugpositionheight = 0;
}

//Function Number: 7
tryuseexplosivedrone(param_00)
{
	var_01 = 1;
	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}
	else if(exceededmaxexplosivedrones())
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(maps\mp\_utility::currentactivevehiclecount() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_01 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(!isdefined(self.explosivedronearray))
	{
		self.explosivedronearray = [];
	}

	if(self.explosivedronearray.size)
	{
		self.explosivedronearray = common_scripts\utility::array_removeundefined(self.explosivedronearray);
		if(self.explosivedronearray.size >= level.explosivedronemaxperplayer)
		{
			if(isdefined(self.explosivedronearray[0]))
			{
				self.explosivedronearray[0] thread explosivedrone_leave();
			}
		}
	}

	maps\mp\_utility::incrementfauxvehiclecount();
	var_02 = param_00 createexplosivedrone();
	if(!isdefined(var_02))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	self playsound(level.explosivedronesettings.sound_launch);
	self playsound(level.explosivedronesettings.sound_lock);
	self.explosivedronearray[self.explosivedronearray.size] = var_02;
	thread startexplosivedrone(var_02);
	playfxontag(level.explosivedronesettings.fxid_launch_thruster,var_02,"TAG_THRUSTER_BTM");
	param_00 notify("mine_selfdestruct");
	return var_02;
}

//Function Number: 8
createexplosivedrone(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!param_00)
	{
		var_04 = self.angles;
		var_05 = anglestoforward(var_04);
		var_06 = anglestoright(var_04);
		var_07 = var_05 * 50;
		var_08 = var_06 * 0;
		var_09 = 80;
		if(isdefined(self.explosivedrone))
		{
			var_0B = self.explosivedrone.origin;
			var_04 = self.explosivedrone.angles;
			self.explosivedrone deleteexplosivedrone();
			addtodeletespike();
		}
		else
		{
			var_0B = self.origin;
		}
	}
	else
	{
		var_0B = param_03;
		var_0C = param_01;
		var_04 = param_02;
	}

	var_0D = anglestoup(self.angles);
	var_0B = var_0B + var_0D * 10;
	var_0E = spawnhelicopter(self.owner,var_0B,var_04,level.explosivedronesettings.vehicleinfo,level.explosivedronesettings.modelbase);
	if(!isdefined(var_0E))
	{
		return;
	}

	var_0E.type = "explosive_drone";
	var_0E common_scripts\utility::make_entity_sentient_mp(self.owner.team);
	var_0E makevehiclenotcollidewithplayers(1);
	var_0E addtoexplosivedronelist();
	var_0E thread removefromexplosivedronelistondeath();
	var_0E.health = level.explosivedronesettings.health;
	var_0E.maxhealth = level.explosivedronesettings.maxhealth;
	var_0E.damagetaken = 0;
	var_0E.speed = 20;
	var_0E.followspeed = 20;
	var_0E.owner = self.owner;
	var_0E.team = self.owner.team;
	var_0E vehicle_setspeed(var_0E.speed,10,10);
	var_0E setyawspeed(120,90);
	var_0E setneargoalnotifydist(64);
	var_0E sethoverparams(20,5,5);
	var_0E.fx_tag0 = undefined;
	if(isdefined(var_0E.type))
	{
		if(var_0E.type == "explosive_drone")
		{
		}
	}

	var_0E.maxtrackingrange = 2000;
	var_0E.maxlaserrange = 300;
	var_0E.trackedplayer = undefined;
	var_0F = 45;
	var_10 = 45;
	var_0E setmaxpitchroll(var_0F,var_10);
	var_0E.targetpos = var_0B;
	var_0E.attract_strength = 10000;
	var_0E.attract_range = 150;
	var_0E.attractor = missile_createattractorent(var_0E,var_0E.attract_strength,var_0E.attract_range);
	var_0E.hasdodged = 0;
	var_0E.stunned = 0;
	var_0E.inactive = 0;
	var_0E thread maps\mp\gametypes\_damage::setentitydamagecallback(var_0E.maxhealth,undefined,::onexplosivedronedeath,undefined,0);
	var_0E thread explosivedrone_watchdisable();
	var_0E thread explosivedrone_watchdeath();
	var_0E thread explosivedrone_watchtimeout();
	var_0E thread explosivedrone_watchownerloss();
	var_0E thread explosivedrone_watchownerdeath();
	var_0E thread explosivedrone_watchroundend();
	var_0E thread explosivedrone_watchhostmigration();
	var_0E thread explosivedrone_enemy_lightfx();
	var_0E thread explosivedrone_friendly_lightfx();
	var_0E thread drone_thrusterfxexplosive();
	return var_0E;
}

//Function Number: 9
addtodeletespike()
{
	var_00 = 5;
	if(!isdefined(level.spikelist))
	{
		level.spikelist = [];
		level.spikelistindex = 0;
	}

	if(level.spikelist.size >= var_00)
	{
		if(isdefined(level.spikelist[level.spikelistindex]))
		{
			level.spikelist[level.spikelistindex] delete();
		}
	}

	level.spikelist[level.spikelistindex] = self;
	level.spikelistindex = level.spikelistindex + 1 % var_00;
}

//Function Number: 10
idletargetmoverexplosive(param_00)
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
explosivedrone_enemy_lightfx()
{
	self endon("death");
	self.owner endon("faux_spawn");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01) && issentient(var_01) && issentient(self) && var_01.team != self.team)
		{
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
		}
	}
}

//Function Number: 12
explosivedrone_friendly_lightfx()
{
	self endon("death");
	self.owner endon("faux_spawn");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01) && issentient(var_01) && issentient(self) && var_01.team == self.team)
		{
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_01);
		}
	}

	thread watchconnectedplayfxexplosive();
	thread watchjoinedteamplayfxexplosive();
}

//Function Number: 13
drone_thrusterfxexplosive()
{
	self endon("death");
	self endon("disconnect");
	self.owner endon("faux_spawn");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			thread drone_thrusterfx_bottom_threaded(var_01);
			thread drone_thrusterfx_side_threaded(var_01);
		}

		wait(1.1);
	}
}

//Function Number: 14
drone_thrusterfx_side_threaded(param_00)
{
	self endon("death");
	self endon("disconnect");
	self.owner endon("faux_spawn");
	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUST_SIDE_X_nY_Z",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUST_SIDE_X_nY_nZ",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUST_SIDE_nX_nY_Z",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUST_SIDE_nX_nY_nZ",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUST_SIDE_nX_Y_nZ",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUST_SIDE_nX_Y_Z",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUST_SIDE_X_Y_Z",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUST_SIDE_X_Y_nZ",param_00);
	}
}

//Function Number: 15
drone_thrusterfx_bottom_threaded(param_00)
{
	self endon("death");
	self endon("disconnect");
	self.owner endon("faux_spawn");
	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_engine_distort))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_engine_distort,self,"TAG_THRUSTER_BTM",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUSTER_BTM",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_engine_distort))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_engine_distort,self,"TAG_THRUSTER_BTM",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUSTER_BTM",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_engine_distort))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_engine_distort,self,"TAG_THRUSTER_BTM",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUSTER_BTM",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_engine_distort))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_engine_distort,self,"TAG_THRUSTER_BTM",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUSTER_BTM",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_engine_distort))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_engine_distort,self,"TAG_THRUSTER_BTM",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_position_thruster))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_position_thruster,self,"TAG_THRUSTER_BTM",param_00);
	}

	wait(0.1);
	if(isdefined(param_00) && isdefined(self) && isdefined(level.explosivedronesettings.fxid_engine_distort))
	{
		playfxontagforclients(level.explosivedronesettings.fxid_engine_distort,self,"TAG_THRUSTER_BTM",param_00);
	}
}

//Function Number: 16
watchconnectedplayfxexplosive()
{
	self endon("death");
	self.owner endon("faux_spawn");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 waittill("spawned_player");
		if(isdefined(var_00) && var_00.team == self.team)
		{
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_00);
		}
	}
}

//Function Number: 17
watchjoinedteamplayfxexplosive()
{
	self endon("death");
	self.owner endon("faux_spawn");
	for(;;)
	{
		level waittill("joined_team",var_00);
		var_00 waittill("spawned_player");
		if(isdefined(var_00) && var_00.team == self.team)
		{
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_friendly_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_00);
			wait(0.15);
			playfxontagforclients(level.explosivedronesettings.fxid_enemy_light,self,"TAG_BEACON",var_00);
		}
	}
}

//Function Number: 18
startexplosivedrone(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 thread explosivedrone_followtarget();
	param_00 thread createkillcamentity();
	if(isdefined(param_00.type))
	{
		if(param_00.type == "explosive_drone")
		{
			param_00 thread checkforexplosivegoalexplosive();
		}
	}
}

//Function Number: 19
checkforexplosivegoalexplosive()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self endon("leaving");
	var_00 = gettime();
	thread blowupatendoftrackingtime(var_00);
}

//Function Number: 20
blowupatendoftrackingtime(param_00)
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self endon("leaving");
	while(gettime() - param_00 < 3000)
	{
		wait 0.05;
	}

	if(isdefined(self))
	{
		self notify("exploding");
		thread blowupdronesequenceexplosive();
	}
}

//Function Number: 21
blowupdronesequenceexplosive()
{
	var_00 = undefined;
	if(isdefined(self))
	{
		if(isdefined(self.owner))
		{
			var_00 = self.owner;
		}

		self playsound(level.explosivedronesettings.sound_lock);
		wait(0.5);
	}

	if(isdefined(self))
	{
		self playsound("wpn_explosive_drone_exp");
		var_01 = anglestoup(self.angles);
		var_02 = anglestoforward(self.angles);
		playfx(level.explosivedronesettings.fxid_lethalexplode,self.origin,var_02,var_01);
		if(isdefined(var_00))
		{
			self radiusdamage(self.origin,256,130,55,var_00,"MOD_EXPLOSIVE","explosive_drone_mp");
		}
		else
		{
			self radiusdamage(self.origin,256,130,55,undefined,"MOD_EXPLOSIVE","explosive_drone_mp");
		}

		self notify("death");
	}
}

//Function Number: 22
turnondangerlightsexplosive()
{
	if(isdefined(self))
	{
	}

	wait(0.05);
	if(isdefined(self))
	{
	}

	wait(0.15);
	if(isdefined(self))
	{
	}
}

//Function Number: 23
explosivedrone_followtarget()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self endon("leaving");
	self endon("exploding");
	if(!isdefined(self.owner))
	{
		thread explosivedrone_leave();
		return;
	}

	self.owner endon("disconnect");
	self endon("owner_gone");
	self vehicle_setspeed(self.followspeed,10,10);
	self.previoustrackedplayer = self.owner;
	self.trackedplayer = undefined;
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
			if(!isdefined(self.trackedplayer) || self.trackedplayer == self.owner)
			{
				foreach(var_03 in level.players)
				{
					if(isdefined(var_03) && isalive(var_03) && var_03 != self.owner && !level.teambased || var_03.team != self.team && !var_03 maps\mp\_utility::_hasperk("specialty_blindeye"))
					{
						var_04 = distancesquared(self.origin,var_03.origin);
						if(var_04 < var_01)
						{
							var_01 = var_04;
							self.trackedplayer = var_03;
							thread watchplayerdeathdisconnectexplosive(var_03);
						}
					}
				}
			}

			if(!isdefined(self.trackedplayer))
			{
				thread explosivedroneexplode();
			}

			if(isdefined(self.trackedplayer))
			{
				explosivedrone_movetoplayer(self.trackedplayer);
			}

			if(self.trackedplayer != self.previoustrackedplayer)
			{
				stophighlightingplayerexplosive(self.previoustrackedplayer);
				self.previoustrackedplayer = self.trackedplayer;
			}
		}

		wait(1);
	}
}

//Function Number: 24
watchplayerdeathdisconnectexplosive(param_00)
{
	param_00 common_scripts\utility::waittill_any("death","disconnect","faux_spawn","joined_team");
	if(param_00.is_being_tracked == 1)
	{
		thread explosivedrone_leave();
		return;
	}

	self.trackedplayer = undefined;
}

//Function Number: 25
explosivedrone_movetoplayer(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("explosiveDrone_moveToPlayer");
	self endon("explosiveDrone_moveToPlayer");
	var_01 = 0;
	var_02 = 0;
	var_03 = 65;
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

//Function Number: 26
explosivedrone_stopmovement()
{
	self setvehgoalpos(self.origin,1);
	self.intransit = 0;
	self.inactive = 1;
}

//Function Number: 27
explosivedrone_changeowner(param_00)
{
	maps\mp\_utility::incrementfauxvehiclecount();
	var_01 = param_00 createexplosivedrone(1,self.origin,self.angles);
	if(!isdefined(var_01))
	{
		maps\mp\_utility::decrementfauxvehiclecount();
		return 0;
	}

	if(!isdefined(param_00.explosivedronearray))
	{
		param_00.explosivedronearray = [];
	}

	param_00.explosivedronearray[param_00.explosivedronearray.size] = var_01;
	param_00 thread startexplosivedrone(var_01);
	if(isdefined(level.explosivedronesettings.fxid_sparks))
	{
	}

	removeexplosivedrone();
	return 1;
}

//Function Number: 28
explosivedrone_highlighttarget()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	if(!isdefined(self.owner))
	{
		thread explosivedrone_leave();
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

//Function Number: 29
starthighlightingplayerexplosive(param_00)
{
	self.lasertag laseron("explosive_drone_laser");
	playfxontag(level.explosivedronesettings.fxid_laser_glow,self.lasertag,"tag_laser");
	if(isdefined(level.explosivedronesettings.sound_lock))
	{
		self playsound(level.explosivedronesettings.sound_lock);
	}

	param_00 setperk("specialty_radararrow",1,0);
	if(param_00.is_being_tracked == 0)
	{
		param_00.is_being_tracked = 1;
		param_00.trackedbyplayer = self.owner;
	}
}

//Function Number: 30
stophighlightingplayerexplosive(param_00)
{
	if(isdefined(self.lasertag))
	{
		self.lasertag laseroff();
		stopfxontag(level.explosivedronesettings.fxid_laser_glow,self.lasertag,"tag_laser");
	}

	if(isdefined(param_00))
	{
		if(isdefined(level.explosivedronesettings.sound_lock))
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

//Function Number: 31
onexplosiveplayerconnect()
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

//Function Number: 32
explosivedrone_watchforgoal()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("explosiveDrone_watchForGoal");
	self endon("explosiveDrone_watchForGoal");
	var_00 = common_scripts\utility::waittill_any_return("goal","near_goal","hit_goal");
	self.intransit = 0;
	self.inactive = 0;
	self notify("hit_goal");
}

//Function Number: 33
explosivedrone_watchdeath()
{
	level endon("game_ended");
	self endon("gone");
	self waittill("death");
	thread explosivedronedestroyed();
}

//Function Number: 34
explosivedrone_watchtimeout()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	var_00 = level.explosivedronetimeout;
	if(self.type == "explosive_drone")
	{
		var_00 = level.explosivedronetimeout;
	}

	wait(var_00);
	thread explosivedrone_leave();
}

//Function Number: 35
explosivedrone_watchownerloss()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	self notify("owner_gone");
	thread explosivedrone_leave();
}

//Function Number: 36
explosivedrone_watchownerdeath()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	for(;;)
	{
		self.owner waittill("death");
		thread explosivedrone_leave();
	}
}

//Function Number: 37
explosivedrone_watchtargetdisconnect()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	self notify("explosiveDrone_watchTargetDisconnect");
	self endon("explosiveDrone_watchTargetDisconnect");
	self.trackedplayer waittill("disconnect");
	stophighlightingplayerexplosive(self.trackedplayer);
	explosivedrone_movetoplayer(self.owner);
}

//Function Number: 38
explosivedrone_watchroundend()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("disconnect");
	self endon("owner_gone");
	level common_scripts\utility::waittill_any("round_end_finished","game_ended");
	thread explosivedrone_leave();
}

//Function Number: 39
explosivedrone_watchhostmigration()
{
	level endon("game_ended");
	self endon("death");
	self endon("leaving");
	self.owner endon("death");
	self.owner endon("disconnect");
	self endon("owner_gone");
	level waittill("host_migration_begin");
	stophighlightingplayerexplosive(self.trackedplayer);
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	thread explosivedrone_changeowner(self.owner);
}

//Function Number: 40
explosivedrone_leave()
{
	self endon("death");
	self notify("leaving");
	stophighlightingplayerexplosive(self.trackedplayer);
	explosivedroneexplode();
}

//Function Number: 41
onexplosivedronedeath(param_00,param_01,param_02,param_03)
{
	self notify("death");
}

//Function Number: 42
explosivedrone_grenade_watchdisable()
{
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	self.stunned = 0;
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		thread explosivedrone_grenade_stunned();
	}
}

//Function Number: 43
explosivedrone_watchdisable()
{
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		thread explosivedrone_stunned();
	}
}

//Function Number: 44
explosivedrone_grenade_stunned()
{
	self notify("explosiveDrone_stunned");
	self endon("explosiveDrone_stunned");
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	explosivedrone_grenade_stunbegin();
	wait(10);
	explosivedrone_grenade_stunend();
}

//Function Number: 45
explosivedrone_stunned()
{
	self notify("explosiveDrone_stunned");
	self endon("explosiveDrone_stunned");
	self endon("death");
	self.owner endon("disconnect");
	level endon("game_ended");
	explosivedrone_stunbegin();
	wait(10);
	explosivedrone_stunend();
}

//Function Number: 46
explosivedrone_grenade_stunbegin()
{
	if(self.stunned)
	{
		return;
	}

	self.stunned = 1;
	if(isdefined(level.explosivedronesettings.fxid_sparks))
	{
		playfxontag(level.explosivedronesettings.fxid_sparks,self,"TAG_BEACON");
	}
}

//Function Number: 47
explosivedrone_stunbegin()
{
	if(self.stunned)
	{
		return;
	}

	self.stunned = 1;
	if(isdefined(level.explosivedronesettings.fxid_sparks))
	{
		playfxontag(level.explosivedronesettings.fxid_sparks,self,"TAG_BEACON");
	}

	thread stophighlightingplayerexplosive(self.trackedplayer);
	self.trackedplayer = undefined;
	self.previoustrackedplayer = self.owner;
	thread explosivedrone_stopmovement();
}

//Function Number: 48
explosivedrone_grenade_stunend()
{
	if(isdefined(level.explosivedronesettings.fxid_sparks))
	{
		killfxontag(level.explosivedronesettings.fxid_sparks,self,"TAG_BEACON");
	}

	self.stunned = 0;
	self.inactive = 0;
}

//Function Number: 49
explosivedrone_stunend()
{
	if(isdefined(level.explosivedronesettings.fxid_sparks))
	{
		killfxontag(level.explosivedronesettings.fxid_sparks,self,"TAG_BEACON");
	}

	self.stunned = 0;
	self.inactive = 0;
}

//Function Number: 50
explosivedronedestroyed()
{
	if(!isdefined(self))
	{
		return;
	}

	stophighlightingplayerexplosive(self.trackedplayer);
	explosivedrone_stunend();
	explosivedroneexplode();
}

//Function Number: 51
explosivedroneexplode()
{
	if(isdefined(level.explosivedronesettings.fxid_explode))
	{
		playfx(level.explosivedronesettings.fxid_explode,self.origin);
	}

	if(isdefined(level.explosivedronesettings.sound_explode))
	{
		self playsound(level.explosivedronesettings.sound_explode);
	}

	self notify("exploding");
	removeexplosivedrone();
}

//Function Number: 52
deleteexplosivedrone()
{
	if(isdefined(self.attractor))
	{
		missile_deleteattractor(self.attractor);
	}

	removekillcamentity();
	self delete();
}

//Function Number: 53
removeexplosivedrone()
{
	maps\mp\_utility::decrementfauxvehiclecount();
	if(isdefined(self.owner) && isdefined(self.owner.explosivedrone))
	{
		self.owner.explosivedrone = undefined;
	}

	deleteexplosivedrone();
}

//Function Number: 54
addtoexplosivedronelist()
{
	level.explosivedrones[self getentitynumber()] = self;
}

//Function Number: 55
removefromexplosivedronelistondeath()
{
	var_00 = self getentitynumber();
	self waittill("death");
	level.explosivedrones[var_00] = undefined;
	level.explosivedrones = common_scripts\utility::array_removeundefined(level.explosivedrones);
}

//Function Number: 56
exceededmaxexplosivedrones()
{
	if(isdefined(level.explosivedrones) && level.explosivedrones.size >= maps\mp\_utility::maxvehiclesallowed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 57
explosivedroneproximitytrigger()
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self.owner endon("disconnect");
	self.owner endon("faux_spawn");
	wait(3);
	if(isdefined(self) && isdefined(self.explosivedrone))
	{
		var_00 = self.explosivedrone gettagorigin("TAG_BEACON") - self gettagorigin("TAG_BEACON") + (0,0,10);
		if(level.teambased)
		{
			maps\mp\_entityheadicons::setteamheadicon(self.owner.team,var_00,"TAG_BEACON");
		}
		else
		{
			maps\mp\_entityheadicons::setplayerheadicon(self.owner,var_00,"TAG_BEACON");
		}

		var_01 = spawn("trigger_radius",self.origin + (0,0,-96),0,192,192);
		var_01.owner = self;
		thread explosivedronedeletetrigger(var_01);
		thread watchforpickup(var_01);
		var_02 = undefined;
		while(isdefined(self) && isdefined(self.explosivedrone))
		{
			var_01 waittill("trigger",var_02);
			if(!isdefined(var_02))
			{
				wait(0.1);
				continue;
			}

			if(var_02 maps\mp\_utility::_hasperk("specialty_blindeye"))
			{
				wait(0.1);
				continue;
			}

			if(isdefined(self.explosivedrone) && !var_02 sightconetrace(self.explosivedrone gettagorigin("TAG_BEACON"),self.explosivedrone))
			{
				wait(0.1);
				continue;
			}

			if(isdefined(self.explosivedrone))
			{
				var_03 = self.explosivedrone gettagorigin("TAG_BEACON");
				var_04 = var_02 geteye();
				if(!bullettracepassed(var_03,var_04,0,self.explosivedrone))
				{
					wait(0.1);
					continue;
				}
			}

			if(maps\mp\_utility::isreallyalive(var_02) && var_02 != self.owner && !level.teambased || var_02.team != self.owner.team && !self.stunned)
			{
				var_02 tryuseexplosivedrone(self);
			}
		}
	}
}

//Function Number: 58
explosivedronedeletetrigger(param_00)
{
	common_scripts\utility::waittill_any("mine_triggered","mine_destroyed","mine_selfdestruct","death");
	if(isdefined(self.entityheadicon))
	{
		self notify("kill_entity_headicon_thread");
		self.entityheadicon destroy();
	}

	param_00 delete();
}

//Function Number: 59
showdebugradius(param_00)
{
	var_01 = spawnfx(level.explosivedronesettings.dome,param_00.origin);
	triggerfx(var_01);
	self waittill("death");
	var_01 delete();
}

//Function Number: 60
endonplayerspawn()
{
	self.owner common_scripts\utility::waittill_any("spawned_player","faux_spawn","delete_explosive_drones");
	explosivegrenadedeath();
}

//Function Number: 61
monitorspikedestroy()
{
	self.owner endon("death");
	self.owner endon("disconnect");
	self.owner endon("faux_spawn");
	common_scripts\utility::waittill_any("mine_selfdestruct");
	explosivegrenadedeath();
}

//Function Number: 62
monitorheaddestroy()
{
	self.owner endon("death");
	self.owner endon("disconnect");
	self.owner endon("faux_spawn");
	while(isdefined(self.explosivedrone))
	{
		wait(0.15);
	}

	if(isdefined(self))
	{
		self playsound("wpn_explosive_drone_exp");
		var_00 = anglestoup(self.angles);
		var_01 = anglestoforward(self.angles);
		playfx(level.explosivedronesettings.fxid_lethalexplode,self.origin,var_01,var_00);
		self radiusdamage(self.origin,256,130,55,self.owner,"MOD_EXPLOSIVE","explosive_drone_mp");
		self notify("death");
	}

	explosivegrenadedeath();
}

//Function Number: 63
startgrenadelightfx()
{
	self endon("death");
	self.owner endon("death");
	self.owner endon("disconnect");
	var_00 = 0.6;
	while(isdefined(self.explosivedrone))
	{
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02) && issentient(var_02) && var_02.team == self.team && isdefined(self.explosivedrone))
			{
				thread fxblink(level.explosivedronesettings.fxid_friendly_light,self.explosivedrone,"TAG_BEACON",var_02);
			}

			if(isdefined(var_02) && issentient(var_02) && var_02.team != self.team && isdefined(self.explosivedrone))
			{
				thread fxblink(level.explosivedronesettings.fxid_enemy_light,self.explosivedrone,"TAG_BEACON",var_02);
			}
		}

		wait(var_00);
	}
}

//Function Number: 64
fxblink(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 <= 4 && isdefined(param_01);var_04++)
	{
		if(isdefined(param_03) && isdefined(param_01) && isdefined(self.stunned) && !self.stunned)
		{
			playfxontagforclients(param_00,param_01,param_02,param_03);
			wait(0.15);
		}
	}
}

//Function Number: 65
watchforstick()
{
	self endon("death");
	self.owner endon("death");
	self.owner endon("disconnect");
	var_00 = undefined;
	var_00 = common_scripts\utility::waittill_any_return_parms("missile_stuck","mp_exo_repulsor_repel");
	while(!isdefined(self.explosivedrone))
	{
		wait 0.05;
	}

	if(isdefined(var_00[1]))
	{
		var_01 = var_00[1].script_stay_drone;
		if(var_00[1].classname == "script_model" && !isdefined(var_01) && var_01 == 1)
		{
			self playsound("wpn_explosive_drone_exp");
			var_02 = anglestoup(self.angles);
			var_03 = anglestoforward(self.angles);
			playfx(level.explosivedronesettings.fxid_lethalexplode,self.origin,var_03,var_02);
			self radiusdamage(self.origin,256,130,55,self.owner,"MOD_EXPLOSIVE","explosive_drone_mp");
			thread explosivegrenadedeath();
		}
	}

	if(isdefined(self))
	{
		self.explosivedrone setcontents(self.explosivedrone.oldcontents);
		thread explosivedroneproximitytrigger();
		thread endonplayerspawn();
		thread explosivedrone_grenade_watchdisable();
		thread startgrenadelightfx();
		thread maps\mp\gametypes\_damage::setentitydamagecallback(100,undefined,::explosivegrenadedeath,undefined,0);
		self.explosivedrone thread maps\mp\gametypes\_damage::setentitydamagecallback(100,undefined,::explosiveheaddeath,undefined,0);
		thread maps\mp\gametypes\_weapons::stickyhandlemovers("mine_selfdestruct");
	}
}

//Function Number: 66
createkillcamentity()
{
	var_00 = (0,0,0);
	self.killcament = spawn("script_model",self.origin);
	self.killcament setscriptmoverkillcam("explosive");
	self.killcament linkto(self,"TAG_THRUSTER_BTM",var_00,(0,0,0));
	self.killcament setcontents(0);
	self.killcament.starttime = gettime();
}

//Function Number: 67
removekillcamentity()
{
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}
}

//Function Number: 68
watchforpickup(param_00)
{
	self.owner endon("disconnect");
	self.owner endon("faux_spawn");
	level endon("game_ended");
	self endon("death");
	self.owner endon("death");
	self.explosivedrone makeusable();
	self.explosivedrone sethintstring(&"MP_PICKUP_EXPLOSIVE_DRONE");
	self.explosivedrone sethintstringvisibleonlytoowner(1);
	var_01 = getdvarfloat("player_useRadius",128);
	var_01 = var_01 * var_01;
	for(;;)
	{
		if(!isdefined(self) || !isdefined(param_00))
		{
			break;
		}

		var_02 = isdefined(self.explosivedrone) && distancesquared(self.owner geteye(),self.explosivedrone.origin) <= var_01;
		if(self.owner istouching(param_00) && var_02)
		{
			var_03 = 0;
			while(self.owner usebuttonpressed())
			{
				if(!maps\mp\_utility::isreallyalive(self.owner))
				{
					break;
				}

				if(!self.owner istouching(param_00))
				{
					break;
				}

				if(self.owner fragbuttonpressed() || self.owner secondaryoffhandbuttonpressed() || isdefined(self.owner.throwinggrenade))
				{
					break;
				}

				if(self.owner isusingturret() || self.owner maps\mp\_utility::isusingremote())
				{
					break;
				}

				if(isdefined(self.owner.iscapturingcrate) && self.owner.iscapturingcrate)
				{
					break;
				}

				if(isdefined(self.owner.empgrenaded) && self.owner.empgrenaded)
				{
					break;
				}

				if(isdefined(self.owner.using_remote_turret) && self.owner.using_remote_turret)
				{
					break;
				}

				var_03 = var_03 + 0.05;
				if(var_03 > 0.75)
				{
					self.owner setweaponammostock(self.weaponname,self.owner setweaponammostock(self.weaponname) + 1);
					self.explosivedrone deleteexplosivedrone();
					self delete();
					break;
				}

				wait 0.05;
			}
		}

		wait 0.05;
	}
}