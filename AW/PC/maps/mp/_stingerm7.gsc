/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_stingerm7.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 234 ms
 * Timestamp: 4/22/2024 2:16:15 AM
*******************************************************************/

//Function Number: 1
stingerm7_think()
{
	thread stingerm7_targeting();
	thread stingerm7_monitor_fire();
}

//Function Number: 2
stingerm7_targeting()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	self.stingerm7_info = spawnstruct();
	self.stingerm7_info.locked_targets = [];
	self.stingerm7_info.locking_time = 0;
	var_00 = 0;
	for(;;)
	{
		var_01 = self getcurrentweapon();
		var_02 = 0;
		if(issubstr(var_01,"stingerm7"))
		{
			var_02 = 1;
		}
		else if(issubstr(var_01,"dlcgun11loot2"))
		{
			var_02 = 1;
		}

		if(var_02 && self playerads() > 0.99)
		{
			var_00 = 1;
			if(self.stingerm7_info.locked_targets.size > 0)
			{
				remove_invalid_locks();
			}

			self.stingerm7_info.locked_targets = array_remove_dead(common_scripts\utility::array_removeundefined(self.stingerm7_info.locked_targets));
			if(isdefined(self.stingerm7_info.locking_target))
			{
				if(!locking_target_still_valid(self.stingerm7_info.locking_target))
				{
					self.stingerm7_info.locking_target = undefined;
					self notify("stop_javelin_locking_feedback");
				}
			}

			if(isdefined(self.stingerm7_info.locking_target))
			{
				self.stingerm7_info.locking_time = self.stingerm7_info.locking_time + 0.05;
			}
			else
			{
				self.stingerm7_info.locking_time = 0;
				if(self.stingerm7_info.locked_targets.size < 4)
				{
					self.stingerm7_info.locking_target = get_best_locking_target();
					if(isdefined(self.stingerm7_info.locking_target))
					{
						thread locking_feedback();
					}
				}
			}

			if(self.stingerm7_info.locking_time >= 1 && isdefined(self.stingerm7_info.locking_target) && self.stingerm7_info.locked_targets.size < 4)
			{
				self notify("stop_javelin_locking_feedback");
				self.stingerm7_info.locked_targets[self.stingerm7_info.locked_targets.size] = self.stingerm7_info.locking_target;
				thread locked_feedback();
				self.stingerm7_info.locking_target = undefined;
			}

			if(self.stingerm7_info.locked_targets.size > 0)
			{
				self weaponlockfinalize(self.stingerm7_info.locked_targets[0]);
			}
			else
			{
				self weaponlockfree();
				self notify("stop_javelin_locked_feedback");
			}
		}
		else if(var_00 == 1)
		{
			var_00 = 0;
			self weaponlockfree();
			self notify("stop_javelin_locking_feedback");
			self notify("stop_javelin_locked_feedback");
			self.stingerm7_info.locked_targets = [];
			if(isdefined(self.stingerm7_info.locking_target))
			{
				self.stingerm7_info.locking_target = undefined;
			}

			self.stingerm7_info.locking_time = 0;
		}

		wait(0.05);
	}
}

//Function Number: 3
stingerm7_monitor_fire()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		if(issubstr(var_01,"stingerm7") || issubstr(var_01,"dlcgun11loot2"))
		{
			thread stinger_fire(self,var_00,var_01);
		}
	}
}

//Function Number: 4
stinger_fire(param_00,param_01,param_02)
{
	var_03 = (0,0,0);
	var_04 = (0,0,0);
	if(isdefined(param_01))
	{
		var_03 = param_01.origin;
		var_04 = param_01.angles;
		param_01 delete();
	}
	else
	{
		return;
	}

	param_00.stingerm7_info.locked_targets = array_remove_dead(common_scripts\utility::array_removeundefined(self.stingerm7_info.locked_targets));
	var_05 = [];
	for(var_06 = 0;var_06 < 4;var_06++)
	{
		var_07 = var_04 + random_vector(20,20,20);
		var_08 = anglestoforward(var_07);
		var_09 = magicbullet(param_02,var_03,var_03 + var_08,param_00);
		var_09.owner = param_00;
		if(param_00.stingerm7_info.locked_targets.size > 0)
		{
			var_0A = undefined;
			if(var_06 < param_00.stingerm7_info.locked_targets.size)
			{
				var_0A = param_00.stingerm7_info.locked_targets[var_06];
			}
			else
			{
				var_0A = param_00.stingerm7_info.locked_targets[randomint(param_00.stingerm7_info.locked_targets.size)];
			}

			var_09 missile_settargetent(var_0A,stingerm7_get_target_offset(var_0A));
			var_09.lockedstingertarget = var_0A;
		}

		var_05[var_05.size] = var_09;
	}

	level notify("stinger_fired",param_00,var_05);
	param_00 setweaponammoclip(param_02,0);
}

//Function Number: 5
anystingermissilelockedon(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03.lockedstingertarget) && var_03.lockedstingertarget == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 6
get_best_locking_target()
{
	var_00 = maps\mp\_utility::getotherteam(self.team);
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(level.teambased && var_03.team == self.team)
		{
			continue;
		}

		if(!maps\mp\_utility::isreallyalive(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	var_05 = vehicle_getarray();
	var_06 = [];
	foreach(var_08 in var_05)
	{
		if(!isdefined(var_08.owner))
		{
			continue;
		}

		if(var_08 maps\mp\killstreaks\_aerial_utility::vehicleiscloaked())
		{
			continue;
		}

		if(level.teambased && var_08.owner.team == self.team)
		{
			continue;
		}

		var_06[var_06.size] = var_08;
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		foreach(var_0B in level.agentarray)
		{
			if(level.teambased && var_0B.team == self.team)
			{
				continue;
			}

			if(!maps\mp\_utility::isreallyalive(var_0B))
			{
				continue;
			}

			var_01[var_01.size] = var_0B;
		}

		foreach(var_08 in var_05)
		{
			if(var_08 maps\mp\killstreaks\_aerial_utility::vehicleiscloaked())
			{
				continue;
			}

			if(level.teambased && var_08.team == self.team)
			{
				continue;
			}

			var_06[var_06.size] = var_08;
		}
	}

	var_0F = maps\mp\killstreaks\_killstreaks::getaerialkillstreakarray(var_00);
	var_10 = common_scripts\utility::array_combine(var_01,var_06);
	var_10 = common_scripts\utility::array_combine(var_10,var_0F);
	if(isdefined(level.stingerlockonentsfunc))
	{
		var_10 = common_scripts\utility::array_combine(var_10,[[ level.stingerlockonentsfunc ]](self));
	}

	var_11 = self geteye();
	var_12 = anglestoforward(self getplayerangles());
	var_13 = undefined;
	var_14 = cos(5);
	foreach(var_16 in var_10)
	{
		if(!common_scripts\utility::array_contains(self.stingerm7_info.locked_targets,var_16))
		{
			var_17 = stingerm7_get_target_pos(var_16);
			var_18 = vectordot(vectornormalize(var_17 - var_11),var_12);
			if(var_18 > var_14)
			{
				var_19 = undefined;
				var_1A = !1;
				if(!var_1A)
				{
					var_1B = bullettracepassed(var_11,var_17,0,var_16);
					if(var_1B)
					{
						var_1A = 1;
					}
				}

				if(var_1A)
				{
					var_13 = var_16;
					var_14 = var_18;
				}
			}
		}
	}

	return var_13;
}

//Function Number: 7
locking_target_still_valid(param_00)
{
	var_01 = self geteye();
	var_02 = anglestoforward(self getplayerangles());
	var_03 = stingerm7_get_target_pos(param_00);
	if((isplayer(param_00) || isbot(param_00) || isdefined(level.ishorde) && level.ishorde && isagent(param_00)) && !maps\mp\_utility::isreallyalive(param_00))
	{
		return 0;
	}

	if(vectordot(vectornormalize(var_03 - var_01),var_02) > cos(5))
	{
		if(!1 || bullettracepassed(var_01,var_03,0,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 8
remove_invalid_locks()
{
	for(var_00 = 0;var_00 <= self.stingerm7_info.locked_targets.size;var_00++)
	{
		if(isdefined(self.stingerm7_info.locked_targets[var_00]) && isdefined(self.stingerm7_info.locked_targets[var_00].origin))
		{
			if(!isdefined(self.stingerm7_info.locked_targets[var_00].sight_lost_time))
			{
				self.stingerm7_info.locked_targets[var_00].sight_lost_time = -1;
			}

			var_01 = (0,0,0);
			if(isplayer(self.stingerm7_info.locked_targets[var_00]) || isbot(self.stingerm7_info.locked_targets[var_00]))
			{
				var_01 = (0,0,64);
			}

			if(self worldpointinreticle_rect(self.stingerm7_info.locked_targets[var_00].origin + var_01,50,400,200))
			{
				if(bullettracepassed(self geteye(),self.stingerm7_info.locked_targets[var_00].origin + var_01,0,self.stingerm7_info.locked_targets[var_00]))
				{
					self.stingerm7_info.locked_targets[var_00].sight_lost_time = -1;
					continue;
				}
			}

			if(self.stingerm7_info.locked_targets[var_00].sight_lost_time == -1)
			{
				self.stingerm7_info.locked_targets[var_00].sight_lost_time = gettime();
				continue;
			}

			if(gettime() - self.stingerm7_info.locked_targets[var_00].sight_lost_time >= 500)
			{
				self.stingerm7_info.locked_targets[var_00].sight_lost_time = -1;
				self.stingerm7_info.locked_targets[var_00] = undefined;
			}
		}
	}
}

//Function Number: 9
stingerm7_get_target_pos(param_00)
{
	if(isdefined(param_00.getstingertargetposfunc))
	{
		return param_00 [[ param_00.getstingertargetposfunc ]]();
	}

	return param_00 getpointinbounds(0,0,0);
}

//Function Number: 10
stingerm7_get_target_offset(param_00)
{
	return stingerm7_get_target_pos(param_00) - param_00.origin;
}

//Function Number: 11
locking_feedback()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	self endon("stop_javelin_locking_feedback");
	for(;;)
	{
		if(isdefined(level.spawnedwarbirds))
		{
			foreach(var_01 in level.spawnedwarbirds)
			{
				if(isdefined(var_01.owner) && isdefined(var_01.player) && isdefined(self.stingerm7_info.locking_target) && self.stingerm7_info.locking_target == var_01)
				{
					var_01.owner playlocalsound("wpn_stingerm7_enemy_locked");
				}
			}
		}

		if(isdefined(level.orbitalsupport_player) && isdefined(self.stingerm7_info.locking_target) && self.stingerm7_info.locking_target == level.orbitalsupport_planemodel)
		{
			level.orbitalsupport_player playlocalsound("wpn_stingerm7_enemy_locked");
		}

		self playlocalsound("wpn_stingerm7_locking");
		self playrumbleonentity("heavygun_fire");
		wait(0.6);
	}
}

//Function Number: 12
locked_feedback()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("joined_team");
	self endon("stop_javelin_locked_feedback");
	for(;;)
	{
		if(isdefined(level.spawnedwarbirds))
		{
			foreach(var_01 in level.spawnedwarbirds)
			{
				if(isdefined(var_01.owner) && isdefined(var_01.player) && isdefined(self.stingerm7_info.locked_targets) && isinarray(self.stingerm7_info.locked_targets,var_01))
				{
					var_01.owner playlocalsound("wpn_stingerm7_enemy_locked");
				}
			}
		}

		if(isdefined(level.orbitalsupport_player) && isdefined(self.stingerm7_info.locked_targets) && isinarray(self.stingerm7_info.locked_targets,level.orbitalsupport_planemodel))
		{
			level.orbitalsupport_player playlocalsound("wpn_stingerm7_enemy_locked");
		}

		self playlocalsound("wpn_stingerm7_locked");
		self playrumbleonentity("heavygun_fire");
		wait(0.25);
	}
}

//Function Number: 13
array_remove_dead(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 14
random_vector(param_00,param_01,param_02)
{
	return (randomfloat(param_00) - param_00 * 0.5,randomfloat(param_01) - param_01 * 0.5,randomfloat(param_02) - param_02 * 0.5);
}

//Function Number: 15
isinarray(param_00,param_01)
{
	if(isdefined(param_00))
	{
		foreach(var_03 in param_00)
		{
			if(var_03 == param_01)
			{
				return 1;
			}
		}
	}

	return 0;
}