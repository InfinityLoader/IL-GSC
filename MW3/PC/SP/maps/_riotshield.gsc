/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_riotshield.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 303 ms
 * Timestamp: 10/27/2023 2:20:38 AM
*******************************************************************/

//Function Number: 1
init_riotshield()
{
	if(isdefined(level.riotshield_initialized))
	{
		return;
	}

	level.riotshield_initialized = 1;
	level._effect["riot_shield_dmg"] = loadfx("misc/riot_shield_dmg");
	if(maps\_utility::is_specialop())
	{
		var_00 = [];
		if(!maps\_utility::is_survival())
		{
		}

		maps\_specialops::so_include_deadquote_array(var_7B);
	}

	if(!isdefined(level.subclass_spawn_functions))
	{
		level.subclass_spawn_functions = [];
	}

	level.subclass_spawn_functions["riotshield"] = ::subclass_riotshield;
	animscripts/riotshield/riotshield::func_3AB4();
}

//Function Number: 2
subclass_riotshield()
{
	animscripts/riotshield/riotshield::func_3AB8();
}

//Function Number: 3
riotshield_sprint_on()
{
	animscripts/riotshield/riotshield::riotshield_sprint_on();
}

//Function Number: 4
riotshield_fastwalk_on()
{
	animscripts/riotshield/riotshield::riotshield_fastwalk_on();
}

//Function Number: 5
riotshield_sprint_off()
{
	animscripts/riotshield/riotshield::riotshield_sprint_off();
}

//Function Number: 6
riotshield_fastwalk_off()
{
	animscripts/riotshield/riotshield::riotshield_fastwalk_off();
}

//Function Number: 7
riotshield_flee()
{
	if(self.subclass != "riotshield")
	{
		return;
	}

	self.combatmode = "cover";
	self.goalradius = 2048;
	animscripts/riotshield/riotshield::func_3AD1();
	var_00 = self findbestcovernode();
	if(isdefined(var_00))
	{
		self usecovernode(var_00);
	}
}

//Function Number: 8
group_create(param_00,param_01,param_02)
{
	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(var_05.combatmode != "no_cover")
		{
			continue;
		}

		var_03[var_03.size] = var_05;
	}

	var_07 = spawnstruct();
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.group) && isdefined(var_05.group.ai_array))
		{
			var_05.group.ai_array = common_scripts\utility::array_remove(var_05.group.ai_array,var_05);
		}

		var_05.group = var_07;
	}

	var_07.ai_array = var_03;
	var_07.fleethreshold = 1;
	var_07.spacing = 50;
	var_07 thread group_check_deaths();
	return var_07;
}

//Function Number: 9
group_initialize_formation(param_00,param_01)
{
	self.ai_array = maps\_utility::array_removedead(self.ai_array);
	self.forward = param_00;
	if(isdefined(param_01))
	{
		self.spacing = param_01;
	}

	foreach(var_03 in self.ai_array)
	{
		var_03.goalradius = 25;
		var_03.pathenemyfightdist = 128;
		var_03.pathenemylookahead = 128;
	}

	group_sort_by_closest_match();
	thread check_group_facing_forward();
}

//Function Number: 10
group_resort_on_deaths()
{
	self endon("break_group");
	if(self.ai_array.size == 0)
	{
		return;
	}

	while(self.ai_array.size)
	{
		maps\_utility::waittill_dead(self.ai_array,1);
		if(self.group_move_mode != "stopped")
		{
			self waittill("goal");
		}

		self.ai_array = maps\_utility::array_removedead(self.ai_array);
		group_sort_by_closest_match();
	}
}

//Function Number: 11
group_sort_by_closest_match(param_00)
{
	if(self.ai_array.size == 0)
	{
		return;
	}

	if(isdefined(param_00))
	{
		self.forward = param_00;
	}
	else
	{
		param_00 = self.forward;
	}

	var_01 = group_center();
	var_02 = (self.forward[1],-1 * self.forward[0],0);
	var_03 = var_02 * self.spacing;
	var_04 = group_left_corner(var_01,var_03);
	var_05 = [];
	for(var_06 = 0;var_06 < self.ai_array.size;var_06++)
	{
		if(isdefined(self.ai_array[var_06]))
		{
			var_05[var_06] = vectordot(var_04 - self.ai_array[var_06].origin,var_02);
			continue;
		}

		var_05[var_06] = 0;
	}

	for(var_06 = 1;var_06 < var_05.size;var_06++)
	{
		var_07 = var_05[var_06];
		var_08 = self.ai_array[var_06];
		for(var_09 = var_06 - 1;var_09 >= 0;var_09--)
		{
			if(var_07 < var_05[var_09])
			{
				break;
			}

			var_05[var_09 + 1] = var_05[var_09];
			self.ai_array[var_09 + 1] = self.ai_array[var_09];
		}

		var_05[var_09 + 1] = var_07;
		self.ai_array[var_09 + 1] = var_08;
	}
}

//Function Number: 12
group_check_deaths()
{
	for(;;)
	{
		if(self.fleethreshold > 0)
		{
			self.ai_array = maps\_utility::array_removedead(self.ai_array);
			if(self.ai_array.size <= self.fleethreshold)
			{
				foreach(var_01 in self.ai_array)
				{
					var_01 riotshield_flee();
				}

				self notify("break_group");
				break;
			}
		}

		wait 1;
	}
}

//Function Number: 13
group_left_corner(param_00,param_01)
{
	return param_00 - self.ai_array.size - 1 / 2 * param_01;
}

//Function Number: 14
group_move(param_00,param_01)
{
	self notify("new_goal_set");
	self.group_move_mode = "moving";
	if(isdefined(param_01))
	{
		self.forward = param_01;
	}
	else
	{
		param_01 = self.forward;
	}

	var_02 = (param_01[1],-1 * param_01[0],0);
	var_03 = var_02 * self.spacing;
	var_04 = group_left_corner(param_00,var_03);
	for(var_05 = 0;var_05 < self.ai_array.size;var_05++)
	{
		var_06 = self.ai_array[var_05];
		if(isdefined(var_06))
		{
			var_06 setgoalpos(var_04);
		}

		var_04 = var_04 + var_03;
	}

	thread check_group_at_goal();
}

//Function Number: 15
check_group_at_goal()
{
	self endon("new_goal_set");
	for(;;)
	{
		wait 0.5;
		var_00 = 0;
		foreach(var_02 in self.ai_array)
		{
			if(isdefined(var_02) && isalive(var_02))
			{
				var_00++;
			}
		}

		var_04 = 0;
		for(var_05 = 0;var_05 < self.ai_array.size;var_05++)
		{
			var_02 = self.ai_array[var_05];
			if(isdefined(var_02))
			{
				var_06 = max(45,var_02.goalradius);
				if(distancesquared(var_02.origin,var_02.goalpos) < squared(var_06))
				{
					var_04++;
				}
			}
		}

		if(var_04 == var_00)
		{
			self notify("goal");
			self.group_move_mode = "stopped";
		}
	}
}

//Function Number: 16
check_group_facing_forward()
{
	self endon("break_group");
	for(;;)
	{
		wait 0.5;
		var_00 = 0;
		foreach(var_02 in self.ai_array)
		{
			if(isdefined(var_02) && isalive(var_02))
			{
				var_00++;
			}
		}

		var_04 = 0;
		var_05 = vectortoyaw(self.forward);
		for(var_06 = 0;var_06 < self.ai_array.size;var_06++)
		{
			var_02 = self.ai_array[var_06];
			if(isdefined(var_02))
			{
				if(abs(var_02.angles[1] - var_05) < 45)
				{
					var_04++;
				}
			}
		}

		if(var_04 == var_00)
		{
			self notify("goal_yaw");
		}
	}
}

//Function Number: 17
group_sprint_on()
{
	foreach(var_01 in self.ai_array)
	{
		if(isalive(var_01))
		{
			var_01 riotshield_sprint_on();
		}
	}
}

//Function Number: 18
group_fastwalk_on()
{
	foreach(var_01 in self.ai_array)
	{
		if(isalive(var_01))
		{
			var_01 riotshield_fastwalk_on();
		}
	}
}

//Function Number: 19
group_sprint_off()
{
	foreach(var_01 in self.ai_array)
	{
		if(isalive(var_01))
		{
			var_01 riotshield_sprint_off();
		}
	}
}

//Function Number: 20
group_fastwalk_off()
{
	foreach(var_01 in self.ai_array)
	{
		if(isalive(var_01))
		{
			var_01 riotshield_fastwalk_off();
		}
	}
}

//Function Number: 21
group_lock_angles(param_00)
{
	self.forward = param_00;
	var_01 = vectortoyaw(param_00);
	foreach(var_03 in self.ai_array)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(isdefined(var_03.enemy) && distancesquared(var_03.origin,var_03.enemy.origin) < squared(var_03.pathenemyfightdist))
		{
			continue;
		}

		var_03 orientmode("face angle",var_01);
		var_03.lockorientation = 1;
	}

	wait 0.1;
}

//Function Number: 22
group_unlock_angles()
{
	foreach(var_01 in self.ai_array)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01 orientmode("face default");
		var_01.lockorientation = 0;
	}
}

//Function Number: 23
group_free_combat()
{
	group_unlock_angles();
	foreach(var_01 in self.ai_array)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01.goalradius = 2048;
		var_01.pathenemyfightdist = 400;
		var_01.pathenemylookahead = 400;
	}
}

//Function Number: 24
group_center()
{
	var_00 = (0,0,0);
	var_01 = 0;
	foreach(var_03 in self.ai_array)
	{
		if(isdefined(var_03))
		{
			var_00 = var_00 + var_03.origin;
			var_01++;
		}
	}

	if(var_01)
	{
		var_00 = 1 / var_01 * var_00;
	}

	return var_00;
}