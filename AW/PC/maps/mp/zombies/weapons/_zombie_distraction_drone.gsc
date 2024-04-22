/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\weapons\_zombie_distraction_drone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 280 ms
 * Timestamp: 4/22/2024 2:13:22 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["drone_distraction_scan_fx"] = loadfx("vfx/props/dlc_prop_distract_drone_fx_main");
	level._effect["zdd_explode"] = loadfx("vfx/explosion/explosive_drone_explosion");
	level.zdd_active = [];
	level thread watchagentspawn();
}

//Function Number: 2
watchagentspawn()
{
	for(;;)
	{
		level waittill("spawned_agent",var_00);
		if(isdefined(var_00.agentteam) && isdefined(level.playerteam) && var_00.agentteam == level.playerteam)
		{
			continue;
		}

		var_00 thread zombiedistractiondrone();
	}
}

//Function Number: 3
getdistractiondroneradiussqr()
{
	if(isdefined(self.maxdistsqr))
	{
		return self.maxdistsqr;
	}

	return 2250000;
}

//Function Number: 4
zombiedistractiondrone()
{
	self endon("death");
	for(;;)
	{
		while(level.zdd_active.size > 0)
		{
			var_00 = undefined;
			foreach(var_02 in level.zdd_active)
			{
				if(!checkdronetrapvalid(var_02))
				{
					continue;
				}

				var_03 = distance2dsquared(var_02.origin,self.origin);
				var_04 = var_02 getdistractiondroneradiussqr();
				if(var_03 < var_04)
				{
					var_00 = var_02;
					break;
				}
			}

			if(isdefined(var_00))
			{
				self.distractiondrone = var_00;
				self.distractiondronebadpathcount = 0;
				if(isdefined(var_00.agentcount))
				{
					var_00.agentcount++;
					thread distractiondronetrapmonitor(var_00);
				}

				var_00 common_scripts\utility::waittill_any("death","stop");
				self.distractiondrone = undefined;
				waittillframeend;
				continue;
			}

			self.distractiondrone = undefined;
			wait 0.05;
		}

		level waittill("distraction_drone_activated");
	}
}

//Function Number: 5
checkdronetrapvalid(param_00)
{
	if(!isdefined(param_00.istrap) || !param_00.istrap)
	{
		return 1;
	}

	var_01 = 4;
	if(isdefined(param_00.maxcount))
	{
		var_01 = param_00.maxcount;
	}

	if(param_00.agentcount > var_01)
	{
		return 0;
	}

	if(maps\mp\zombies\_util::istrapresistant())
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
distractiondronetrapmonitor(param_00)
{
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00.agentcount--;
	}
}

//Function Number: 7
onplayerspawn()
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		var_02 = maps\mp\_utility::strip_suffix(var_01,"_lefthand");
		if(var_02 == "distraction_drone_zombie_mp" || var_02 == "distraction_drone_throw_zombie_mp")
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

			var_00 thread watchowner();
			var_00 thread watchforstick();
		}
	}
}

//Function Number: 8
watchowner()
{
	self endon("death");
	self.owner waittill("disconnect");
	self delete();
}

//Function Number: 9
watchdroneowner()
{
	self endon("death");
	self.owner waittill("disconnect");
	destroydrone();
}

//Function Number: 10
watchforstick()
{
	self.owner endon("death");
	self.owner endon("disconnect");
	self waittill("missile_stuck",var_00);
	var_01 = spawndronemodel();
	var_01.groundpos = self.origin;
	var_01 thread droneanimate();
	var_01 thread watchdeath();
	var_01 thread watchdroneowner();
	var_01 thread dronethink();
	level notify("distraction_drone_activated",var_01);
	level.zdd_active[level.zdd_active.size] = var_01;
	var_02 = [];
	foreach(var_01 in level.zdd_active)
	{
		if(isdefined(var_01.istrap) && var_01.istrap)
		{
			continue;
		}

		var_02[var_02.size] = var_01;
	}

	if(var_02.size > 4)
	{
		var_02[0] destroydrone();
	}

	self delete();
}

//Function Number: 11
dronethink()
{
	self endon("death");
	wait(7);
	destroydrone();
}

//Function Number: 12
spawndronemodel()
{
	var_00 = spawn("script_model",self.origin);
	var_00 setmodel("dlc_distraction_drone_01");
	var_00.owner = self.owner;
	maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("drone_distraction_scan_fx"),var_00,"TAG_SIREN_FX");
	var_00.fx = 1;
	var_00 thread droneaudio();
	return var_00;
}

//Function Number: 13
droneanimate()
{
	self endon("death");
	thread dronerotate();
	self moveto(self.origin + (0,0,70),1,0,1);
}

//Function Number: 14
dronerotate()
{
	self endon("death");
	var_00 = 600;
	for(;;)
	{
		self rotatevelocity((0,60,0),var_00);
		wait(var_00);
	}
}

//Function Number: 15
droneaudio()
{
	var_00 = spawn("script_model",self.origin);
	self.soundandeffectsent = var_00;
	var_00 setmodel("tag_origin");
	var_00 vehicle_jetbikesethoverforcescale(self,"tag_weapon",(0,0,0),(0,0,0));
	var_00 playsoundonmovingent("distraction_drone_deploy");
	wait(0.3);
	self playloopsound("distraction_drone_alarm");
	self waittill("death");
	wait(3);
	var_00 delete();
}

//Function Number: 16
watchdeath()
{
	self waittill("death");
	level.zdd_active = common_scripts\utility::array_remove(level.zdd_active,self);
}

//Function Number: 17
destroydrone(param_00)
{
	if(isdefined(self.istrap) && self.istrap)
	{
		level.zdd_active = common_scripts\utility::array_remove(level.zdd_active,self);
		self delete();
		return;
	}

	var_01 = !isdefined(param_00) && param_00;
	if(isdefined(self.fx))
	{
		if(var_01)
		{
			maps\mp\zombies\_util::stopfxontagnetwork(common_scripts\utility::getfx("drone_distraction_scan_fx"),self,"TAG_SIREN_FX");
		}
		else
		{
			maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("drone_distraction_scan_fx"),self,"TAG_SIREN_FX");
			wait(0.05);
		}
	}

	playfxontag(common_scripts\utility::getfx("zdd_explode"),self.soundandeffectsent,"tag_origin");
	self.soundandeffectsent playsoundonmovingent("wpn_explosive_drone_exp");
	var_02 = self.origin;
	var_03 = self.owner;
	if(isremovedentity(var_03))
	{
		var_03 = undefined;
	}

	if(var_01)
	{
		self radiusdamage(var_02,100,5000,450,var_03,"MOD_EXPLOSIVE","distraction_drone_zombie_mp");
	}

	self stoploopsound();
	self delete();
}