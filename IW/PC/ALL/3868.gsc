/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3868.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 9 ms
 * Timestamp: 10/27/2023 12:31:04 AM
*******************************************************************/

//Function Number: 1
func_6854()
{
	thread func_6860();
	func_6837(1);
}

//Function Number: 2
func_6837(param_00)
{
	if(!isdefined(level.var_10E6D.var_4652))
	{
		level.var_10E6D.var_4652 = [];
		level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "bulletwhizby";
		level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "explode";
		level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "footstep";
		level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "footstep_sprint";
		level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "footstep_walk";
		level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "grenade danger";
		level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "gunshot";
		level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "gunshot_teammate";
		level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "projectile_impact";
		level.var_10E6D.var_4652[level.var_10E6D.var_4652.size] = "silenced_shot";
	}

	if(param_00)
	{
		foreach(var_02 in level.var_10E6D.var_4652)
		{
			self method_8000(var_02);
		}

		return;
	}

	foreach(var_02 in level.var_10E6D.var_4652)
	{
		self method_8260(var_02);
	}
}

//Function Number: 3
func_6855()
{
	if(!isdefined(level.var_10E6D.var_6879))
	{
		level.var_10E6D.var_6879 = [];
	}

	level.var_10E6D.var_6879["investigate"] = 0;
	level.var_10E6D.var_6879["cover_blown"] = 1;
	level.var_10E6D.var_6879["combat"] = 2;
	level lib_0F27::func_F5B4("broadcast",::func_6800);
	func_6897("investigate","footstep",20);
	func_6897("investigate","footstep_sprint",20);
	func_6897("investigate","footstep_walk",20);
	func_6897("cover_blown","sight",3);
	func_6897("cover_blown","saw_corpse");
	func_6897("cover_blown","found_corpse");
	func_6897("cover_blown","gunshot_teammate",10);
	func_6897("cover_blown","silenced_shot",10);
	func_6897("cover_blown","gunshot",10);
	func_6897("cover_blown","explode",2);
	func_6897("cover_blown","seek_backup");
	func_6897("combat","grenade danger");
	func_6897("combat","projectile_impact");
	func_6897("combat","bulletwhizby");
	func_6897("combat","attack");
	func_6897("combat","damage");
	func_6897("combat","proximity");
}

//Function Number: 4
func_6894(param_00,param_01)
{
	var_02 = level.var_10E6D.var_6879[param_00] - level.var_10E6D.var_6879[param_01];
	return var_02;
}

//Function Number: 5
func_6898(param_00,param_01)
{
	var_02 = level.var_10E6D.var_6879[param_00] + param_01;
	foreach(var_05, var_04 in level.var_10E6D.var_6879)
	{
		if(var_04 == var_02)
		{
			return var_05;
		}
	}

	return param_00;
}

//Function Number: 6
func_6897(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(level.var_10E6D.var_6893))
	{
		level.var_10E6D.var_6893 = [];
	}

	if(!isdefined(level.var_10E6D.var_6838))
	{
		level.var_10E6D.var_6838 = [];
	}

	level.var_10E6D.var_6893[param_01] = param_00;
	level.var_10E6D.var_6838[param_01] = param_02;
}

//Function Number: 7
func_6895(param_00)
{
	return level.var_10E6D.var_6893[param_00];
}

//Function Number: 8
func_683B(param_00)
{
	return level.var_10E6D.var_6838[param_00];
}

//Function Number: 9
func_6839()
{
	self.var_10E6D.var_683A = undefined;
}

//Function Number: 10
func_6860()
{
	self notify("event_listener_thread");
	self endon("event_listener_thread");
	self endon("death");
	for(;;)
	{
		scripts\sp\_utility::func_65E3("stealth_enabled");
		self waittill("ai_events",var_00);
		if(!scripts\sp\_utility::func_65DB("stealth_enabled"))
		{
			continue;
		}

		if(self.var_180 || self method_81B7())
		{
			continue;
		}

		foreach(var_02 in var_00)
		{
			if(!isdefined(var_02.var_114))
			{
				continue;
			}

			if(issentient(var_02.var_114) && var_02.var_114.ignoreme || var_02.var_114.var_204)
			{
				continue;
			}

			if(function_00FD(var_02.var_114))
			{
				continue;
			}

			if(isdefined(var_02.var_114.var_C841))
			{
				if(function_00FD(var_02.var_114.var_C841) || var_02.var_114.var_C841.var_380 == "capital_ship")
				{
					continue;
				}
			}

			var_02.var_12AE9 = var_02.type;
			var_03 = func_6895(var_02.type);
			if(isdefined(var_03))
			{
				var_04 = func_683B(var_02.type);
				var_05 = 0;
				if(var_04 > 0)
				{
					if(!isdefined(self.var_10E6D.var_683A))
					{
						self.var_10E6D.var_683A = [];
					}

					if(!isdefined(self.var_10E6D.var_683A[var_02.type]))
					{
						self.var_10E6D.var_683A[var_02.type] = 1;
					}
					else
					{
						self.var_10E6D.var_683A[var_02.type] = self.var_10E6D.var_683A[var_02.type] + 1;
					}

					if(self.var_10E6D.var_683A[var_02.type] >= var_04)
					{
						var_03 = func_6898(var_03,1);
					}
				}

				var_02.type = var_03;
			}

			lib_0F18::func_10E8B(var_02.type,var_02);
		}
	}
}

//Function Number: 11
func_67FF(param_00,param_01,param_02,param_03)
{
	var_04 = function_0075("bad_guys","all");
	var_05 = squared(param_02);
	var_06 = squared(param_03);
	foreach(var_08 in var_04)
	{
		if(!isalive(var_08))
		{
			continue;
		}

		if(var_08 == self)
		{
			continue;
		}

		if(var_08.team != self.team)
		{
			continue;
		}

		if(!isdefined(var_08.var_10E6D))
		{
			continue;
		}

		var_09 = distancesquared(var_08.origin,self.origin);
		var_0A = var_09 <= var_05;
		if(!var_0A && var_09 <= var_06)
		{
			if(var_08 lib_0F27::func_9D11(self) || var_08 lib_0F27::func_9D11(level.player))
			{
				var_0A = 1;
			}
		}

		if(var_0A)
		{
			var_08 method_84F7(param_00,param_01,param_01.origin);
		}
	}
}

//Function Number: 12
func_6800(param_00,param_01,param_02)
{
	var_03 = function_0075("bad_guys");
	var_04 = squared(param_02);
	foreach(var_06 in var_03)
	{
		if(!isalive(var_06))
		{
			continue;
		}

		if(!isdefined(var_06.var_10E6D))
		{
			continue;
		}

		if(distancesquared(var_06.origin,param_01) <= var_04)
		{
			var_06 method_84F7(param_00,level.player,param_01);
		}
	}
}