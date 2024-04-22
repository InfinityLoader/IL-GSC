/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _weapon_pdrone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 229 ms
 * Timestamp: 4/22/2024 2:24:59 AM
*******************************************************************/

//Function Number: 1
initialize()
{
	setsaveddvar("vehHelicopterControlsAltitude",1);
	precachemodel("tag_laser");
	precacheitem("pdrone_weapon");
	precacheitem("pdrone_weapon_bullet");
	precacheshader("dpad_killstreak_remote_uav");
	precacheshader("dpad_laser_designator");
}

//Function Number: 2
give_player_pdrone(param_00)
{
	self.pdroneactive = 0;
	self.pdronereturning = 0;
	self setweaponhudiconoverride("actionslot4","dpad_killstreak_remote_uav");
	self notifyonplayercommand("use_pdrone","+actionslot 4");
	for(;;)
	{
		self waittill("use_pdrone");
		if(self isthrowinggrenade())
		{
			continue;
		}

		if(!self.pdroneactive)
		{
			self allowfire(0);
			var_01 = self getcurrentprimaryweapon();
			self takeweapon(var_01);
			self giveweapon("pdrone_weapon_bullet");
			self switchtoweaponimmediate("pdrone_weapon_bullet");
			self givemaxammo("pdrone_weapon_bullet");
			wait_til_pdrone_launched();
			self allowfire(1);
			if(isdefined(self.pdrone_launched) && self.pdrone_launched)
			{
				self disableweaponswitch();
				self disableoffhandweapons();
				wait(1.75);
				pdrone_launch(param_00);
				self.pdrone_launched = undefined;
				wait(0.25);
				self enableoffhandweapons();
				self enableweaponswitch();
			}

			self takeweapon("pdrone_weapon_bullet");
			self giveweapon(var_01);
			self switchtoweaponimmediate(var_01);
			continue;
		}

		pdrone_return();
	}
}

//Function Number: 3
pdrone_return()
{
	var_00 = self;
	var_01 = var_00.pdrone;
	var_01 maps\_utility::ent_flag_clear("sentient_controlled");
	var_00 notify("pdrone_returning");
	var_01 thread pdrone_return_pathing();
	var_01 waittill("goal");
	var_01 delete();
	var_00 notify("pdrone_returned");
}

//Function Number: 4
pdrone_return_pathing()
{
	self endon("goal");
	self.goalradius = 40;
	self vehicle_setspeed(20,20,20);
	self setlookatent(self.owner);
	for(;;)
	{
		self setvehgoalpos(self.owner.origin + (0,0,84),0);
		wait(0.05);
	}
}

//Function Number: 5
wait_til_pdrone_launched()
{
	self endon("death");
	self endon("use_pdrone");
	self endon("weapon_switch_started");
	self notifyonplayercommand("launch_pdrone","+attack");
	self waittill("launch_pdrone");
	self.pdrone_launched = 1;
}

//Function Number: 6
pdrone_launch(param_00)
{
	self.pdroneactive = 1;
	var_01 = spawn_pdrone(param_00);
	if(isdefined(var_01))
	{
		var_01 makeentitysentient(self.team);
		var_01.team = self.team;
		var_01.pov_mode = 0;
		var_01.owner = self;
		if(self.team == "allies")
		{
			var_01 maps\_vehicle::godon();
		}

		self.pdrone = var_01;
		self notify("pdrone_launched");
		self.pdrone = var_01;
		var_01 thread pdrone_monitor_death();
	}
}

//Function Number: 7
spawn_pdrone(param_00)
{
	while(isdefined(param_00.available) && !param_00.available)
	{
		wait(0.05);
	}

	if(!isdefined(self))
	{
		return undefined;
	}

	param_00.available = 0;
	param_00.script_team = self.team;
	if(isplayer(self))
	{
		var_01 = self getplayerangles();
	}
	else
	{
		var_01 = self.angles;
	}

	var_02 = anglestoforward(var_01);
	var_03 = anglestoup(var_01);
	var_04 = var_02 * 24 + var_03 * 100;
	if(var_04[2] < 80)
	{
		var_04 = var_04 + (0,0,80 - var_04[2]);
	}

	param_00.origin = self.origin + var_04;
	param_00.angles = self.angles;
	waittillframeend;
	param_00.available = 1;
	if(isdefined(self) && isalive(self))
	{
		return param_00 maps\_utility::spawn_vehicle();
	}

	return undefined;
}

//Function Number: 8
pdrone_monitor_death()
{
	self waittill("death");
	if(isdefined(self))
	{
		if(isdefined(self.owner))
		{
			self.owner.pdroneactive = 0;
		}
	}
}

//Function Number: 9
pd_laser_targeting_device(param_00)
{
	param_00 endon("remove_laser_targeting_device");
	param_00.lastusedweapon = undefined;
	param_00.laserforceon = 0;
	param_00 setweaponhudiconoverride("actionslot4","dpad_laser_designator");
	param_00 notifyonplayercommand("use_laser","+actionslot 4");
	param_00 notifyonplayercommand("fired_laser","+attack");
	param_00 childthread pd_monitorlaseroff();
	for(;;)
	{
		param_00 waittill("use_laser");
		if(param_00.laserforceon || param_00 pd_shouldforcedisablelaser())
		{
			param_00 notify("cancel_laser");
			param_00 laseroff();
			param_00.laserforceon = 0;
			wait(0.2);
			param_00 allowfire(1);
		}
		else
		{
			param_00 laseron();
			param_00 allowfire(0);
			param_00.laserforceon = 1;
			param_00 thread pd_laser_designate_target();
		}

		wait(0.05);
	}
}

//Function Number: 10
pd_shouldforcedisablelaser()
{
	var_00 = self getcurrentweapon();
	if(var_00 == "rpg")
	{
		return 1;
	}

	if(var_00 == "c4")
	{
		return 1;
	}

	if(common_scripts\utility::string_starts_with(var_00,"gl"))
	{
		return 1;
	}

	if(var_00 == "pdrone_weapon_bullet")
	{
		return 1;
	}

	if(isdefined(level.laser_designator_disable_list) && isarray(level.laser_designator_disable_list))
	{
		foreach(var_02 in level.laser_designator_disable_list)
		{
			if(var_00 == var_02)
			{
				return 1;
			}
		}
	}

	if(self isreloading())
	{
		return 1;
	}

	if(self isthrowinggrenade())
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
pd_monitorlaseroff()
{
	for(;;)
	{
		if(pd_shouldforcedisablelaser() && isdefined(self.laserforceon) && self.laserforceon)
		{
			self notify("use_laser");
			wait(2);
		}

		wait(0.05);
	}
}

//Function Number: 12
pd_laser_designate_target()
{
	self endon("cancel_laser");
	self waittill("fired_laser");
	var_00 = pd_get_laser_designated_trace();
	var_01 = var_00["position"];
	var_02 = var_00["entity"];
	if(distance(self.origin,var_01) < 100000)
	{
		self notify("pdrone_defend_point",var_00);
	}
	else
	{
		iprintln("too far");
	}

	wait(0.05);
	self notify("use_laser");
}

//Function Number: 13
pd_get_laser_designated_trace()
{
	var_00 = self geteye();
	var_01 = self getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = var_00 + var_02 * 7000;
	var_04 = bullettrace(var_00,var_03,0,self);
	var_05 = var_04["entity"];
	if(isdefined(var_05))
	{
		var_04["position"] = var_05.origin;
	}

	return var_04;
}