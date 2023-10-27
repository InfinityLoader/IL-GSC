/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_dd.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 1282 ms
 * Timestamp: 10/27/2023 12:11:54 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	func_F8DA();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["crate_can_use"] = ::func_4830;
	level.var_2D9E["gametype_think"] = ::func_2D59;
}

//Function Number: 3
func_4830(param_00)
{
	if(isagent(self) && !isdefined(param_00.var_2F33))
	{
		return 0;
	}

	if(isdefined(param_00.var_485F) && !scripts\mp\bots\_bots_killstreaks::func_2DDB(param_00.var_485F))
	{
		return 0;
	}

	return func_9C96();
}

//Function Number: 4
func_B9B0()
{
	self notify("monitor_zone_control");
	self endon("monitor_zone_control");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(1);
		var_00 = getzonenearest(self.var_4B2C);
		if(isdefined(var_00))
		{
			if(self.var_2C5C)
			{
				var_01 = scripts\common\utility::func_7984(self.ownerteam);
			}
			else
			{
				var_01 = self.ownerteam;
			}

			if(var_01 != "neutral")
			{
				function_002B(var_00,var_01);
			}
		}
	}
}

//Function Number: 5
iw7_ship_hack_add_bombzone_node(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.origin = param_01;
	var_02.angles = (0,randomint(360),0);
	level.var_2C7A[param_00].var_2EFE[level.var_2C7A[param_00].var_2EFE.size] = var_02;
}

//Function Number: 6
bot_fixup_bombzone_issues()
{
	if(level.var_B335 == "mp_metropolis")
	{
		if(scripts\mp\_utility::func_9900() && level.var_2C7A[0].var_2EFE.size == 0)
		{
			var_00 = (-505,-361,68);
			iw7_ship_hack_add_bombzone_node(0,var_00);
			var_00 = (-582,-311,68);
			iw7_ship_hack_add_bombzone_node(0,var_00);
			var_00 = (-583,-387,68);
			iw7_ship_hack_add_bombzone_node(0,var_00);
			var_00 = (-583,-387,68);
			iw7_ship_hack_add_bombzone_node(0,var_00);
			var_00 = (-497,-326,68);
			iw7_ship_hack_add_bombzone_node(0,var_00);
		}
	}
}

//Function Number: 7
func_F8DA()
{
	scripts\mp\bots\_bots_util::func_2ECA();
	scripts\mp\bots\_bots_strategy::func_2E86();
	bot_fixup_bombzone_issues();
	foreach(var_01 in level.var_2C7A)
	{
		foreach(var_03 in var_01.var_2EFE)
		{
			var_04 = scripts\common\utility::array_randomize(var_01.var_2EFE);
			var_01.var_2EFD = var_04[0];
			break;
		}
	}

	scripts\mp\bots\_bots_util::func_2D19();
	foreach(var_01 in level.var_2C7A)
	{
		var_01 thread func_B9B0();
	}

	level.var_2DA1 = 1;
}

//Function Number: 8
getovertimebombzone()
{
	return level.var_2C7A[0];
}

//Function Number: 9
isattacker()
{
	if(!scripts\mp\_utility::func_9900())
	{
		if(self.team == game["attackers"])
		{
			return 1;
		}

		return 0;
	}

	var_00 = getovertimebombzone();
	if(var_00.ownerteam == "neutral")
	{
		return 1;
	}

	if(var_00.ownerteam == self.team)
	{
		return 0;
	}

	return 1;
}

//Function Number: 10
isdefender()
{
	if(!scripts\mp\_utility::func_9900())
	{
		if(self.team == game["defenders"])
		{
			return 1;
		}

		return 0;
	}

	var_00 = getovertimebombzone();
	if(var_00.ownerteam == "neutral")
	{
		return 0;
	}

	if(var_00.ownerteam == self.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
func_2D59()
{
	self notify("bot_dem_think");
	self endon("bot_dem_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.var_2DA1))
	{
		wait(0.05);
	}

	func_9558();
	self botsetflag("separation",0);
	self botsetflag("grenade_objectives",1);
	self botsetflag("use_obj_path_style",1);
	self.var_9BB6 = 0;
	self.var_9C6A = 0;
	self.var_4B48 = undefined;
	if(!isdefined(level.var_BF3F))
	{
		level.var_BF3F = gettime() - 100;
	}

	for(;;)
	{
		wait(0.05);
		if(gettime() >= level.var_BF3F)
		{
			func_12DC2();
			level.var_BF3F = gettime() + 100;
		}

		if(self.health <= 0)
		{
			continue;
		}

		if(scripts\mp\_utility::func_9900() && !isdefined(self.var_4B48))
		{
			self.var_4B48 = getovertimebombzone();
		}

		if(isattacker())
		{
			if(self.var_9C6A)
			{
				func_CC49();
			}
			else
			{
				if(!isdefined(self.var_4B48))
				{
					self.var_4B48 = func_6C7A("attackers");
				}

				if(isdefined(self.var_4B48))
				{
					if(func_9B7E(self.var_4B48) && !func_9C96())
					{
						scripts\mp\bots\_bots_strategy::func_2E57(self.var_4B48.var_2EFD.origin,600);
					}
					else if(!func_9B7E(self.var_4B48) && !func_9B84())
					{
						var_00["entrance_points_index"] = "zone" + self.var_4B48.label;
						scripts\mp\bots\_bots_strategy::func_2D2B(self.var_4B48.var_2EFD.origin,350,var_00);
					}
				}
			}

			continue;
		}

		if(self.var_9BB6)
		{
			if(!isdefined(level.var_4DA4[self.var_4B48.label]))
			{
				self.var_9BB6 = 0;
			}
		}

		if(self.var_9BB6)
		{
			func_50A6();
			continue;
		}

		if(!isdefined(self.var_4B48))
		{
			self.var_4B48 = func_6C7A("defenders");
		}

		if(isdefined(self.var_4B48))
		{
			if(func_9B7E(self.var_4B48) && !func_9B84())
			{
				var_00["entrance_points_index"] = "zone" + self.var_4B48.label;
				scripts\mp\bots\_bots_strategy::func_2D2B(self.var_4B48.var_2EFD.origin,350,var_00);
				continue;
			}

			if(!func_9B7E(self.var_4B48) && !func_9C96())
			{
				scripts\mp\bots\_bots_strategy::func_2E57(self.var_4B48.var_2EFD.origin,600);
			}
		}
	}
}

//Function Number: 12
func_CC49()
{
	func_8466(1);
}

//Function Number: 13
func_50A6()
{
	func_8466(0);
}

//Function Number: 14
func_8466(param_00)
{
	scripts\mp\bots\_bots_strategy::func_2D4E();
	if(param_00)
	{
		self botsetscriptgoal(self.var_4B48.var_2EFD.origin,20,"critical",self.var_4B48.var_2EFD.angles[1]);
	}
	else
	{
		var_01 = level.var_4DA4[self.var_4B48.label].origin;
		self botsetscriptgoal(var_01,20,"critical");
	}

	var_02 = scripts\mp\bots\_bots_util::func_2ECB(undefined,"dem_bomb_exploded","no_longer_bomb_defuser");
	if(var_02 == "goal")
	{
		self botpressbutton("use",level.var_50AB + 2);
		func_1381B(level.var_50AB + 2,param_00);
		if(param_00)
		{
			self.var_9C6A = 0;
			return;
		}

		self.var_9BB6 = 0;
	}
}

//Function Number: 15
func_1381B(param_00,param_01)
{
	var_02 = gettime();
	var_03 = var_02 + param_00 * 1000;
	wait(0.05);
	while(self usebuttonpressed() && gettime() < var_03 && isdefined(self.var_4B48) && param_01 != func_9B7E(self.var_4B48))
	{
		wait(0.05);
	}
}

//Function Number: 16
func_9C96()
{
	return scripts\mp\bots\_bots_util::func_2DDD();
}

//Function Number: 17
func_9B84()
{
	return scripts\mp\bots\_bots_util::func_2DD5();
}

//Function Number: 18
func_787A(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.var_C928)
	{
		if(param_01 == "attackers" && !var_04 isattacker())
		{
			continue;
		}

		if(param_01 == "defenders" && !var_04 isdefender())
		{
			continue;
		}

		if(isalive(var_04) && scripts\mp\_utility::func_9F9D(var_04) && isdefined(var_04.var_4B48) && var_04.var_4B48 == param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 19
func_7877(param_00)
{
	var_01 = func_787A(param_00,"defenders");
	foreach(var_03 in var_01)
	{
		if(var_03.var_9BB6)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 20
func_7878(param_00)
{
	var_01 = func_787A(param_00,"attackers");
	foreach(var_03 in var_01)
	{
		if(var_03.var_9C6A)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 21
func_6C7A(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_2C7A)
	{
		if(!scripts\common\utility::istrue(var_03.var_2C58))
		{
			var_04 = 0;
			if(param_00 == "defenders")
			{
				var_04 = var_03.var_2EED > func_787A(var_03,"defenders").size;
			}
			else if(param_00 == "attackers")
			{
				var_04 = var_03.var_2EEC > func_787A(var_03,"attackers").size;
			}

			if(var_04)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	var_06 = undefined;
	if(var_01.size > 0)
	{
		var_07 = 999999999;
		foreach(var_03 in var_01)
		{
			var_09 = distancesquared(var_03.var_2EFD.origin,self.origin);
			if(var_09 < var_07)
			{
				var_06 = var_03;
				var_07 = var_09;
			}
		}
	}

	return var_06;
}

//Function Number: 22
func_12DC2()
{
	var_00 = [];
	foreach(var_02 in level.var_2C7A)
	{
		if(!scripts\common\utility::istrue(var_02.var_2C58))
		{
			var_00[var_00.size] = var_02;
		}
	}

	if(level.var_D88D == 2 && var_00.size == 1)
	{
		foreach(var_05 in level.var_C928)
		{
			if(scripts\mp\_utility::func_9F9D(var_05) && isdefined(var_05.var_4B48) && var_05.var_4B48 != var_00[0])
			{
				var_05.var_4B48 = undefined;
				var_05 scripts\mp\bots\_bots_strategy::func_2D4E();
				var_05 notify("dem_bomb_exploded");
				var_05.var_9BB6 = 0;
				var_05.var_9C6A = 0;
			}
		}

		level.var_D88D = 1;
	}

	func_12DAD(var_00);
	func_12DAE(var_00);
}

//Function Number: 23
func_12DAD(param_00)
{
	if(gettime() > level.var_BF62)
	{
		level.var_4BD6 = 1 - level.var_4BD6;
		level.var_BF62 = gettime() + 90000;
	}

	var_01 = 0;
	foreach(var_03 in level.var_C928)
	{
		if(scripts\mp\_utility::func_9D36(var_03) && isalive(var_03) && var_03 isattacker())
		{
			var_01++;
		}
	}

	if(param_00.size == 2)
	{
		if(var_01 >= 2)
		{
			param_00[1 - level.var_4BD6].var_2EEC = 1;
		}
		else
		{
			param_00[1 - level.var_4BD6].var_2EEC = 0;
		}

		param_00[level.var_4BD6].var_2EEC = var_01 - param_00[1 - level.var_4BD6].var_2EEC;
	}
	else if(param_00.size == 1)
	{
		param_00[0].var_2EEC = var_01;
	}

	foreach(var_06 in param_00)
	{
		var_07 = func_787A(var_06,"attackers");
		if(var_07.size > var_06.var_2EEC)
		{
			var_07 = scripts\common\utility::array_randomize(var_07);
			foreach(var_09 in var_07)
			{
				if(!var_09.var_9C6A)
				{
					var_09.var_4B48 = undefined;
					var_09 scripts\mp\bots\_bots_strategy::func_2D4E();
					break;
				}
			}
		}
	}

	foreach(var_06 in param_00)
	{
		if(!func_9B7E(var_06) && !isdefined(func_7878(var_06)))
		{
			var_07 = func_787A(var_06,"attackers");
			if(var_07.size > 0)
			{
				var_0D = scripts\common\utility::func_782F(var_06.var_2EFD.origin,var_07);
				var_0D[0].var_9C6A = 1;
				var_0D[0] scripts\mp\bots\_bots_strategy::func_2D4E();
			}
		}
	}
}

//Function Number: 24
func_12DAE(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_C928)
	{
		if(scripts\mp\_utility::func_9D36(var_03) && isalive(var_03) && var_03 isdefender())
		{
			var_01++;
		}
	}

	if(param_00.size == 2)
	{
		param_00[0].var_2EED = int(var_01 / 2);
		param_00[1].var_2EED = int(var_01 / 2);
		param_00[level.var_BB52].var_2EED = param_00[level.var_BB52].var_2EED + var_01 % 2;
		for(var_05 = 0;var_05 < param_00.size;var_05++)
		{
			if(func_9B7E(param_00[var_05]))
			{
				param_00[var_05].var_2EED++;
				param_00[1 - var_05].var_2EED--;
			}
		}
	}
	else if(param_00.size == 1)
	{
		param_00[0].var_2EED = var_01;
	}

	foreach(var_07 in param_00)
	{
		var_08 = func_787A(var_07,"defenders");
		if(var_08.size > var_07.var_2EED)
		{
			var_08 = scripts\common\utility::array_randomize(var_08);
			foreach(var_0A in var_08)
			{
				if(!var_0A.var_9BB6)
				{
					var_0A.var_4B48 = undefined;
					var_0A scripts\mp\bots\_bots_strategy::func_2D4E();
					break;
				}
			}
		}
	}

	foreach(var_07 in param_00)
	{
		if(func_9B7E(var_07))
		{
			var_0E = func_7877(var_07);
			if(!isdefined(var_0E) || gettime() > level.var_BF6A)
			{
				var_08 = func_787A(var_07,"defenders");
				if(var_08.size > 0)
				{
					var_0F = scripts\common\utility::func_782F(var_07.var_2EFD.origin,var_08);
					if(!isdefined(var_0E) || var_0F[0] != var_0E)
					{
						var_0F[0].var_9BB6 = 1;
						var_0F[0] scripts\mp\bots\_bots_strategy::func_2D4E();
						if(isdefined(var_0E))
						{
							var_0E.var_9BB6 = 0;
							var_0E notify("no_longer_bomb_defuser");
						}
					}
				}

				level.var_BF6A = gettime() + 2500;
			}
		}
	}
}

//Function Number: 25
func_9B7E(param_00)
{
	return isdefined(param_00.var_2C5C) && param_00.var_2C5C == 1;
}

//Function Number: 26
func_9558()
{
	if(isdefined(level.var_2EF4) && level.var_2EF4)
	{
		return;
	}

	level.var_2EF4 = 1;
	level.var_BB52 = randomint(2);
	level.var_D88D = 2;
	level.var_4BD6 = randomint(2);
	level.var_BF62 = gettime() + 90000;
	level.var_BF6A = 0;
}