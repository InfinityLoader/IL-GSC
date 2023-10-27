/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1370.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 73
 * Decompile Time: 114 ms
 * Timestamp: 10/27/2023 3:25:50 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_AC80 = spawnstruct();
	level.var_AC80.var_9054 = ["zombie_spawner","zombie_sky_spawner"];
	level.var_AC80.var_ACB3 = [];
	level.var_AC80.var_2914 = [];
	level.var_AC80.var_290A = [];
	level.var_AC80.var_9065 = ::func_1E4E;
	level.var_AC80.var_8FE7 = 0;
	level.var_1F1D = ::func_1F66;
	level.var_4200 = ::func_4562;
	level.var_43F2 = ::func_474A;
	level.var_8C96 = undefined;
	level.var_43F4 = ::func_474B;
	level.var_38D1 = undefined;
	level.var_7D20 = undefined;
	level.var_38D2 = [];
	level.var_7D21 = [];
}

//Function Number: 2
func_6B3F()
{
	if(!isdefined(level.var_AC80))
	{
		return;
	}

	foreach(var_01 in level.var_AC80.var_ACB3)
	{
		var_02 = [];
		var_01.var_37C3 = [];
		var_01.var_744A = [];
		var_01.zombies = [];
		var_01 func_ACA1();
		for(var_03 = 0;var_03 < var_01.var_ABFE.size;var_03++)
		{
			var_04 = var_01.var_ABFE[var_03];
			if(lib_0547::func_AC0F(var_04,var_01.var_AC8A + " spawner",undefined,var_01.var_AC8A))
			{
				var_02[var_02.size] = var_04;
			}
		}

		var_01.var_ABFE = var_02;
	}
}

//Function Number: 3
func_3155(param_00)
{
	var_01 = isdefined(level.var_AC80.var_ACB3[param_00]);
	return var_01;
}

//Function Number: 4
func_0F4F(param_00)
{
	foreach(var_02 in level.var_AC80.var_ACB3)
	{
		if(common_scripts\utility::func_562E(param_00))
		{
			if(isdefined(level.zmb_registered_quest_zones) && common_scripts\utility::func_F79(level.zmb_registered_quest_zones,var_02.var_AC8A))
			{
				continue;
			}
		}

		if(!var_02.var_556E)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 5
func_586A(param_00)
{
	return level.var_AC80.var_ACB3[param_00].var_556E;
}

//Function Number: 6
func_1F66(param_00)
{
	return level.var_AC80.var_ACB3[param_00].var_5614;
}

//Function Number: 7
func_5780(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_01 && !func_586A(param_00))
	{
		return 0;
	}

	foreach(var_03 in level.var_744A)
	{
		if(func_7413(var_03,param_00,param_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 8
func_A100()
{
	level endon("game_ended");
	level notify("updating_connection_distances");
	level endon("updating_connection_distances");
	level.var_AC80.var_2585 = [];
	foreach(var_01 in level.var_AC80.var_ACB3)
	{
		foreach(var_03 in level.var_AC80.var_ACB3)
		{
			if(var_01.var_AC8A == var_03.var_AC8A)
			{
				continue;
			}

			if(isdefined(level.var_AC80.var_2585[var_01.var_AC8A]) && isdefined(level.var_AC80.var_2585[var_01.var_AC8A][var_03.var_AC8A]))
			{
				continue;
			}

			func_474A(var_01.var_AC8A,var_03.var_AC8A);
			wait 0.05;
		}
	}

	if(isdefined(level.var_AC88))
	{
		level.var_AC80.var_511B = [];
		foreach(var_01 in level.var_AC80.var_ACB3)
		{
			foreach(var_03 in level.var_AC80.var_ACB3)
			{
				if(var_01.var_AC8A == var_03.var_AC8A)
				{
					continue;
				}

				if(isdefined(level.var_AC80.var_511B[var_01.var_AC8A]) && isdefined(level.var_AC80.var_511B[var_01.var_AC8A][var_03.var_AC8A]))
				{
					continue;
				}

				func_474B(var_01.var_AC8A,var_03.var_AC8A);
				wait 0.05;
			}
		}
	}
}

//Function Number: 9
func_7BDC(param_00,param_01,param_02)
{
	level.var_AC80.var_2585[param_00][param_01] = param_02;
	level.var_AC80.var_2585[param_01][param_00] = param_02;
}

//Function Number: 10
func_474A(param_00,param_01)
{
	if(param_00 == param_01)
	{
		return 0;
	}

	if(!isdefined(level.var_AC80.var_2585))
	{
		return -1;
	}

	if(isdefined(level.var_AC80.var_2585[param_00]) && isdefined(level.var_AC80.var_2585[param_00][param_01]))
	{
		return level.var_AC80.var_2585[param_00][param_01];
	}

	var_02[0]["zone"] = param_00;
	var_02[0]["distance"] = 0;
	while(var_02.size > 0)
	{
		var_03 = level.var_AC80.var_ACB3[var_02[0]["zone"]];
		var_04 = var_02[0]["distance"];
		var_02 = common_scripts\utility::func_F9A(var_02,0);
		var_05[var_03.var_AC8A] = 1;
		foreach(var_0E, var_07 in var_03.var_A01)
		{
			if(isdefined(var_05[var_07.var_AC8A]))
			{
				continue;
			}

			if(var_07.var_554C)
			{
				var_08 = var_04 + 1;
				if(var_07.var_AC8A == param_01)
				{
					func_7BDC(param_00,param_01,var_08);
					return var_08;
				}

				var_09 = -1;
				var_0A = -1;
				if(var_02.size == 0)
				{
					var_09 = 0;
				}

				for(var_0B = 0;var_0B < var_02.size;var_0B++)
				{
					var_0C = var_02[var_0B]["distance"] >= var_08;
					if(var_0C && var_09 < 0)
					{
						var_09 = var_0B;
					}

					if(var_02[var_0B]["zone"] == var_07.var_AC8A)
					{
						if(var_0C)
						{
							var_0A = var_0B;
						}

						break;
					}
				}

				if(var_0A >= 0)
				{
					var_02 = common_scripts\utility::func_F9A(var_02,var_0A);
				}

				if(var_0B == var_02.size && var_09 < 0)
				{
					var_09 = var_02.size;
				}

				if(var_09 >= 0)
				{
					param_00["zone"] = var_07.var_AC8A;
					var_0C["distance"] = var_0E;
					param_01 = common_scripts\utility::func_F86(param_01,var_0C,var_08);
				}
			}
		}
	}

	return -1;
}

//Function Number: 11
func_7BE7(param_00,param_01,param_02)
{
	level.var_AC80.var_511B[param_00][param_01] = param_02;
	level.var_AC80.var_511B[param_01][param_00] = param_02;
}

//Function Number: 12
func_474B(param_00,param_01)
{
	if(param_00 == param_01)
	{
		return 0;
	}

	if(!isdefined(level.var_AC80.var_2585))
	{
		return -1;
	}

	if(isdefined(level.var_AC80.var_511B[param_00]) && isdefined(level.var_AC80.var_511B[param_00][param_01]))
	{
		return level.var_AC80.var_511B[param_00][param_01];
	}

	var_02[0]["zone"] = param_00;
	var_02[0]["distance"] = 0;
	while(var_02.size > 0)
	{
		var_03 = level.var_AC80.var_ACB3[var_02[0]["zone"]];
		var_04 = var_02[0]["distance"];
		var_02 = common_scripts\utility::func_F9A(var_02,0);
		var_05[var_03.var_AC8A] = 1;
		foreach(var_0E, var_07 in var_03.var_A01)
		{
			if(isdefined(var_05[var_07.var_AC8A]))
			{
				continue;
			}

			if([[ level.var_AC88 ]](var_07.var_AC8A))
			{
				continue;
			}

			if(var_07.var_554C)
			{
				var_08 = var_04 + 1;
				if(var_07.var_AC8A == param_01)
				{
					func_7BE7(param_00,param_01,var_08);
					return var_08;
				}

				var_09 = -1;
				var_0A = -1;
				if(var_02.size == 0)
				{
					var_09 = 0;
				}

				for(var_0B = 0;var_0B < var_02.size;var_0B++)
				{
					var_0C = var_02[var_0B]["distance"] >= var_08;
					if(var_0C && var_09 < 0)
					{
						var_09 = var_0B;
					}

					if(var_02[var_0B]["zone"] == var_07.var_AC8A)
					{
						if(var_0C)
						{
							var_0A = var_0B;
						}

						break;
					}
				}

				if(var_0A >= 0)
				{
					var_02 = common_scripts\utility::func_F9A(var_02,var_0A);
				}

				if(var_0B == var_02.size && var_09 < 0)
				{
					var_09 = var_02.size;
				}

				if(var_09 >= 0)
				{
					param_00["zone"] = var_07.var_AC8A;
					var_0C["distance"] = var_0E;
					param_01 = common_scripts\utility::func_F86(param_01,var_0C,var_08);
				}
			}
		}
	}

	return -1;
}

//Function Number: 13
func_462D()
{
	if(self.var_178 == "spectator" || self.var_178 == "intermission")
	{
		return undefined;
	}

	updatecurrentzones();
	var_00 = getarraykeys(self.currentzones);
	if(var_00.size > 0)
	{
		return var_00[0];
	}

	return undefined;
}

//Function Number: 14
getagentzone()
{
	updatecurrentzones();
	var_00 = getarraykeys(self.currentzones);
	if(var_00.size > 0)
	{
		return var_00[0];
	}

	return undefined;
}

//Function Number: 15
func_4482(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = func_4483(param_00);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		var_02[var_02.size] = var_04.var_AC8A;
	}

	return var_02;
}

//Function Number: 16
func_4483(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = [];
	var_02 = [];
	foreach(var_04 in level.var_744A)
	{
		var_04 updatecurrentzones();
		foreach(var_07, var_06 in var_04.currentzones)
		{
			if(!isdefined(var_01[var_07]))
			{
				if(!param_00 || func_586A(var_07))
				{
					var_01[var_07] = 1;
					var_02[var_02.size] = level.var_AC80.var_ACB3[var_07];
					continue;
				}

				var_01[var_07] = 0;
			}
		}
	}

	return var_02;
}

//Function Number: 17
func_5860(param_00)
{
	param_00 updatecurrentzones();
	if(!isdefined(param_00.currentzones))
	{
		return 0;
	}

	return param_00.currentzones.size > 0;
}

//Function Number: 18
func_5861(param_00)
{
	param_00 updatecurrentzones();
	if(!isdefined(param_00.currentzones))
	{
		return 0;
	}

	foreach(var_02 in param_00.currentzones)
	{
		if(func_586A(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 19
getzoneclosesttopoint(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = undefined;
	foreach(var_04 in level.var_AC80.var_ACB3)
	{
		if(param_01 && !func_586A(var_04.var_AC8A))
		{
			continue;
		}

		foreach(var_06 in var_04.var_A615)
		{
			if(ispointinvolume(param_00,var_06))
			{
				return var_04.var_AC8A;
			}
		}

		if(!isdefined(var_02))
		{
			var_02 = var_04;
			continue;
		}

		if(distance(param_00,var_04.var_74DC) < distance(param_00,var_02.var_74DC))
		{
			var_02 = var_04;
		}
	}

	return var_02.var_AC8A;
}

//Function Number: 20
func_5771(param_00)
{
	foreach(var_02 in level.var_AC80.var_ACB3)
	{
		foreach(var_04 in var_02.var_A615)
		{
			if(ispointinvolume(param_00.var_116,var_04))
			{
				return 1;
			}

			if(ispointinvolume(param_00.var_116 + (0,0,20),var_04))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 21
func_5772(param_00)
{
	foreach(var_02 in level.var_AC80.var_ACB3)
	{
		if(!func_586A(var_02.var_AC8A))
		{
			continue;
		}

		foreach(var_04 in var_02.var_A615)
		{
			if(ispointinvolume(param_00.var_116,var_04))
			{
				return 1;
			}

			if(ispointinvolume(param_00.var_116 + (0,0,20),var_04))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 22
func_578A(param_00,param_01)
{
	var_02 = func_578B(param_00,param_01);
	return isdefined(var_02);
}

//Function Number: 23
func_578B(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	foreach(var_03 in level.var_AC80.var_ACB3)
	{
		if(param_01 && !func_586A(var_03.var_AC8A))
		{
			continue;
		}

		foreach(var_05 in var_03.var_A615)
		{
			if(ispointinvolume(param_00,var_05))
			{
				return var_03.var_AC8A;
			}
		}
	}
}

//Function Number: 24
func_4562(param_00)
{
	if(isdefined(level.var_AC80))
	{
		foreach(var_02 in level.var_AC80.var_ACB3)
		{
			foreach(var_04 in var_02.var_A615)
			{
				if(ispointinvolume(param_00,var_04))
				{
					return var_02.var_AC8A;
				}

				if(ispointinvolume(param_00 + (0,0,20),var_04))
				{
					return var_02.var_AC8A;
				}
			}
		}
	}

	return undefined;
}

//Function Number: 25
func_0F14(param_00)
{
	var_01 = maps/mp/agents/_agent_utility::func_43FD("all");
	if(var_01.size == 0)
	{
		return 0;
	}

	var_02 = level.var_AC80.var_ACB3[param_00];
	foreach(var_04 in var_01)
	{
		var_04 updatecurrentzones();
	}

	var_06 = var_02 zombies_in_zone_internal();
	return var_06.size > 0;
}

//Function Number: 26
zombies_in_zone_internal()
{
	var_00 = self;
	var_01 = [];
	foreach(var_03 in var_00.zombies)
	{
		if(isdefined(var_03) && isalive(var_03))
		{
			var_01[var_01.size] = var_03;
		}
	}

	var_00.zombies = var_01;
	return var_01;
}

//Function Number: 27
players_in_zone_internal()
{
	var_00 = self;
	var_01 = [];
	foreach(var_03 in var_00.var_744A)
	{
		if(isdefined(var_03) && isplayer(var_03) && var_03.var_178 != "spectator")
		{
			var_01[var_01.size] = var_03;
		}
	}

	var_00.var_744A = var_01;
	return var_01;
}

//Function Number: 28
updatecurrentzones()
{
	var_00 = self;
	if(isdefined(var_00.lastzoneupdateorigin))
	{
		if(var_00.var_116 == var_00.lastzoneupdateorigin)
		{
			return;
		}
	}

	var_00.lastzoneupdateorigin = var_00.var_116;
	var_01 = var_00.currentzones;
	var_00.currentzones = [];
	var_02 = isplayer(var_00) && var_00.var_178 == "spectator";
	var_03 = function_01EF(var_00) && !isalive(var_00);
	if(!var_02 && !var_03)
	{
		foreach(var_09, var_05 in level.var_AC80.var_ACB3)
		{
			foreach(var_07 in var_05.var_A615)
			{
				if(var_00 istouching(var_07))
				{
					var_00.currentzones[var_09] = 1;
					break;
				}
			}
		}
	}

	if(isdefined(var_01))
	{
		var_0A = getarraykeys(var_01);
		foreach(var_09 in var_0A)
		{
			if(!isdefined(var_00.currentzones[var_09]))
			{
				var_00 thread onentityleftzone(var_09);
			}
		}
	}
	else
	{
		var_01 = [];
	}

	var_0D = getarraykeys(var_00.currentzones);
	foreach(var_09 in var_0D)
	{
		if(!isdefined(var_01) || !isdefined(var_01[var_09]))
		{
			var_00 thread onentityfoundinzone(var_09);
		}
	}
}

//Function Number: 29
onentityfoundinzone(param_00)
{
	var_01 = self;
	var_02 = level.var_AC80.var_ACB3[param_00];
	var_03 = var_01 getentitynumber();
	var_02.var_37C3[var_03] = var_01;
	if(isplayer(var_01))
	{
		var_02.var_744A[var_03] = var_01;
	}

	if(isdefined(var_01.var_A) && var_01.var_A != level.var_746E)
	{
		var_02.zombies[var_03] = var_01;
	}
}

//Function Number: 30
onentityleftzone(param_00)
{
	var_01 = self;
	var_02 = level.var_AC80.var_ACB3[param_00];
	var_03 = var_01 getentitynumber();
	var_02.var_37C3[var_03] = undefined;
	if(isplayer(var_01))
	{
		var_02.var_744A[var_03] = undefined;
	}

	if(isdefined(var_01.var_A) && var_01.var_A != level.var_746E)
	{
		var_02.zombies[var_03] = undefined;
	}
}

//Function Number: 31
func_45BF(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(param_01 && !func_586A(param_00))
	{
		return 0;
	}

	var_02 = level.var_AC80.var_ACB3[param_00];
	var_03 = 0;
	foreach(var_05 in level.var_744A)
	{
		if(func_7413(var_05,param_00,param_01))
		{
			var_03++;
		}
	}

	return var_03;
}

//Function Number: 32
func_4626(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = [];
	if(param_02 && !func_586A(param_00))
	{
		return var_03;
	}

	var_04 = level.var_AC80.var_ACB3[param_00];
	var_05 = [param_00];
	if(param_01)
	{
		foreach(var_07 in var_04.var_A01)
		{
			if(!param_02 || func_586A(var_07.var_AC8A))
			{
				var_05[param_00.size] = var_07.var_AC8A;
			}
		}
	}

	foreach(var_0A in level.var_744A)
	{
		foreach(param_00 in var_05)
		{
			if(func_7413(var_0A,param_00,param_02))
			{
				var_03[var_03.size] = var_0A;
			}
		}
	}

	return var_03;
}

//Function Number: 33
func_7413(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_00.var_178 == "spectator")
	{
		return 0;
	}

	param_00 updatecurrentzones();
	if(param_02 && !func_586A(param_01))
	{
		return 0;
	}

	return common_scripts\utility::func_562E(param_00.currentzones[param_01]);
}

//Function Number: 34
func_AC29(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(param_02 && !func_586A(param_01))
	{
		return 0;
	}

	param_00 updatecurrentzones();
	return common_scripts\utility::func_562E(param_00.currentzones[param_01]);
}

//Function Number: 35
func_45C3(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01 && !func_586A(param_00))
	{
		return 0;
	}

	var_02 = lib_0547::func_408F();
	if(var_02.size == 0)
	{
		return 0;
	}

	var_03 = level.var_AC80.var_ACB3[param_00];
	foreach(var_05 in var_02)
	{
		var_05 updatecurrentzones();
	}

	return var_03.zombies.size;
}

//Function Number: 36
func_530A(param_00,param_01,param_02)
{
	if(isdefined(level.var_AC80.var_ACB3[param_00]))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_03 = spawnstruct();
	var_03.var_A01 = [];
	var_03.var_55CA = 0;
	var_03.var_556E = param_01;
	var_03.var_5614 = param_01;
	var_03.var_552B = 0;
	var_03.var_AC8A = param_00;
	if(isdefined(param_02))
	{
		var_03.var_5614 = param_02;
	}

	var_03.var_A615 = [];
	var_04 = getentarray(param_00,"targetname");
	foreach(var_06 in var_04)
	{
		if(var_06.var_3A == "info_volume")
		{
			var_03.var_A615[var_03.var_A615.size] = var_06;
		}
	}

	common_scripts\utility::func_3C87(var_03.var_AC8A);
	if(param_01)
	{
		common_scripts\utility::func_3C8F(var_03.var_AC8A);
	}

	level.var_AC80.var_ACB3[param_00] = var_03;
	var_03.var_75FF = func_4634(param_00);
	var_08 = func_4694(param_00);
	var_03.var_ABFE = func_3ACB(var_08,"zombie_spawner");
	if(!isdefined(level.var_AC4F))
	{
		level.var_AC4F = [];
	}

	var_09 = func_3ACB(var_08,"zombie_sky_spawner");
	var_03.var_ABFE = common_scripts\utility::func_F73(var_03.var_ABFE,var_09);
	var_03.var_9050 = [];
	foreach(var_0B in var_03.var_ABFE)
	{
		func_5374(var_0B);
		if(isdefined(var_0B.var_819A))
		{
			var_03.var_9050[var_0B.var_819A] = 1;
		}
	}

	level.var_AC4F = common_scripts\utility::func_F73(level.var_AC4F,var_03.var_ABFE);
	if(lib_0547::func_2306())
	{
		var_03.var_2300 = func_3ACB(var_08,"civilian_extract");
		var_03.var_2302 = func_3ACB(var_08,"civilian_spawner");
		if(!isdefined(level.var_AC4E))
		{
			level.var_AC4E = [];
		}

		level.var_AC4E = common_scripts\utility::func_F73(level.var_AC4E,var_03.var_2302);
	}
}

//Function Number: 37
func_5374(param_00)
{
	switch(param_00.var_165)
	{
		case "zombie_sky_spawner":
			param_00.var_8C95 = 1;
			break;

		case "zombie_spawner":
			if(isdefined(param_00.var_819A) && !common_scripts\utility::func_3C83(param_00.var_819A))
			{
				common_scripts\utility::func_3C87(param_00.var_819A);
			}
			break;
	}
}

//Function Number: 38
func_4634(param_00)
{
	var_01 = common_scripts\utility::func_46B7("power_switch","targetname");
	foreach(var_03 in var_01)
	{
		if(func_57F4(var_03,level.var_AC80.var_ACB3[param_00].var_A615))
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 39
func_57F4(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(ispointinvolume(param_00.var_116,var_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
func_4694(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_AC80.var_9054)
	{
		foreach(var_05 in getentarray(var_03,"script_noteworthy"))
		{
			var_01[var_01.size] = var_05;
		}
	}

	var_08 = [];
	foreach(var_11, var_0A in level.var_AC80.var_ACB3[param_00].var_A615)
	{
		if(isdefined(var_0A.var_1A2))
		{
			var_0B = common_scripts\utility::func_46B7(var_0A.var_1A2,"targetname");
			foreach(var_0D in var_0B)
			{
				if(!common_scripts\utility::func_F79(var_08,var_0D))
				{
					var_0D.var_AC8A = param_00;
					var_08[var_08.size] = var_0D;
				}
			}
		}

		foreach(var_05 in var_01)
		{
			if(ispointinvolume(var_05.var_116,var_0A) && !common_scripts\utility::func_F79(var_08,var_05))
			{
				var_05.var_AC8A = param_00;
				var_08[var_08.size] = var_05;
			}
		}
	}

	return var_08;
}

//Function Number: 41
func_3ACB(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(var_04.var_165))
		{
			continue;
		}

		if(var_04.var_165 != param_01)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 42
func_0993(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(level.var_3C77[param_02]))
	{
		common_scripts\utility::func_3C87(param_02);
	}

	func_5FBF(param_00,param_01,param_02,0);
	func_5FBF(param_01,param_00,param_02,param_03);
}

//Function Number: 43
func_5FBF(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_AC80.var_ACB3[param_00];
	if(!isdefined(var_04.var_A01[param_01]))
	{
		var_05 = spawnstruct();
		var_05.var_AC8A = param_01;
		var_05.var_3CC5[0] = param_02;
		var_05.var_554C = 0;
		var_05.var_6B2C = param_03;
		var_04.var_A01[param_01] = var_05;
		return;
	}

	var_06 = var_04.var_A01[param_01];
	var_06.var_3CC5[var_06.var_3CC5.size] = param_02;
}

//Function Number: 44
getadjacentzones(param_00)
{
	var_01 = [];
	var_02 = level.var_AC80.var_ACB3[param_00];
	foreach(var_04 in var_02.var_A01)
	{
		var_01[var_01.size] = var_04;
	}

	return var_01;
}

//Function Number: 45
func_088A(param_00)
{
	if(isdefined(param_00))
	{
		level.var_AC80.var_9065 = param_00;
	}

	foreach(var_02 in level.var_AC80.var_ACB3)
	{
		foreach(var_05, var_04 in var_02.var_A01)
		{
			level thread func_ACC1(var_02,var_05);
		}
	}

	level thread func_63E4();
	level thread func_ACAC();
	level.var_AC80.var_8A9 = 1;
}

//Function Number: 46
func_63E4()
{
	level endon("game_ended");
	var_00 = 1;
	for(;;)
	{
		level.var_AC80.var_8FE7 = 1;
		while(level.var_AC80.var_8FE7)
		{
			wait 0.05;
		}

		wait(var_00);
	}
}

//Function Number: 47
func_ACC1(param_00,param_01)
{
	level endon("game_ended");
	foreach(var_03 in param_00.var_A01[param_01].var_3CC5)
	{
		level thread func_ACC2(param_00,var_03,param_01);
	}
}

//Function Number: 48
func_ACC2(param_00,param_01,param_02)
{
	level endon("game_ended");
	common_scripts\utility::func_3C9F(param_01);
	var_03 = level.var_AC80.var_ACB3[param_02];
	var_03.var_556E = 1;
	common_scripts\utility::func_3C8F(param_00.var_AC8A);
	param_00.var_A01[param_02].var_554C = 1;
	level thread func_A100();
}

//Function Number: 49
func_445A(param_00,param_01)
{
	var_02 = [];
	var_03 = 0;
	var_04 = func_4482();
	for(var_05 = var_04.size;var_05 > 0;var_05--)
	{
		var_06 = var_04[var_03];
		var_07 = level.var_AC80.var_ACB3[var_06];
		if(param_00)
		{
			var_02 = common_scripts\utility::func_F73(var_02,var_07.var_2302);
		}
		else
		{
			var_02 = common_scripts\utility::func_F73(var_02,var_07.var_2300);
			foreach(var_09 in var_02)
			{
				if(!isdefined(var_09.var_8260))
				{
					var_02 = common_scripts\utility::func_F93(var_02,var_09);
				}
			}
		}

		if(func_586A(var_07.var_AC8A))
		{
			foreach(var_0C in var_07.var_A01)
			{
				if(!func_586A(var_0C.var_AC8A))
				{
					if(!param_00)
					{
						continue;
					}

					if(var_0C.var_6B2C)
					{
						continue;
					}
				}

				if(!common_scripts\utility::func_F79(var_04,var_0C.var_AC8A))
				{
					var_04[var_04.size] = var_0C.var_AC8A;
					var_05++;
				}
			}
		}

		var_03++;
	}

	var_02 = function_01AC(var_02,param_01);
	for(var_0E = var_02.size - 1;var_0E >= 0;var_0E--)
	{
		if(!isdefined(var_02[var_0E].var_4B57))
		{
			var_02[var_0E].var_4B57 = 1;
			return var_02[var_0E];
		}
	}

	var_02[var_02.size - 1].var_4B57 = 1;
	return var_02[var_02.size - 1];
}

//Function Number: 50
func_4696(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.var_AC80))
	{
		return undefined;
	}

	if(level.var_AC80.var_8FE7)
	{
		level.var_AC80.var_8FE7 = 0;
		func_A166();
	}

	return [[ level.var_AC80.var_9065 ]](param_00,param_01,param_02,param_03);
}

//Function Number: 51
func_A166()
{
	foreach(var_01 in level.var_AC80.var_ACB3)
	{
		var_01.var_552B = func_5780(var_01.var_AC8A);
		var_01.var_552C = 0;
	}

	foreach(var_01 in level.var_AC80.var_ACB3)
	{
		if(var_01.var_552B)
		{
			foreach(var_05 in var_01.var_A01)
			{
				var_06 = level.var_AC80.var_ACB3[var_05.var_AC8A];
				if(!var_06.var_552B)
				{
					var_06.var_552C = 1;
				}
			}
		}
	}

	var_09 = [];
	var_0A = [];
	foreach(var_01 in level.var_AC80.var_ACB3)
	{
		if(var_01.var_552B || var_01.var_552C && var_01.var_556E)
		{
			var_09[var_09.size] = var_01.var_AC8A;
		}

		if(var_01.var_552C)
		{
			var_0A[var_0A.size] = var_01.var_AC8A;
		}
	}

	level.var_AC80.var_2914 = var_09;
	level.var_AC80.var_290A = var_0A;
}

//Function Number: 52
func_583C(param_00)
{
	var_01 = 0;
	if(isdefined(level.var_744A))
	{
		foreach(var_03 in level.var_744A)
		{
			var_04 = function_038E(param_00,var_03.var_116);
			if(var_04 < 2000)
			{
				var_01 = 1;
				break;
			}
		}
	}

	return var_01;
}

//Function Number: 53
func_4692()
{
	var_00 = [];
	foreach(var_02 in level.var_AC80.var_2914)
	{
		var_03 = level.var_AC80.var_ACB3[var_02];
		foreach(var_05 in var_03.var_ABFE)
		{
			var_00[var_00.size] = var_05;
		}
	}

	return var_00;
}

//Function Number: 54
func_4693(param_00)
{
	var_01 = [];
	var_02 = level.var_AC80.var_ACB3[param_00];
	foreach(var_04 in var_02.var_ABFE)
	{
		var_01[var_01.size] = var_04;
	}

	return var_01;
}

//Function Number: 55
func_4691()
{
	var_00 = [];
	foreach(var_02 in level.var_AC80.var_290A)
	{
		var_03 = level.var_AC80.var_ACB3[var_02];
		foreach(var_05 in var_03.var_ABFE)
		{
			var_00[var_00.size] = var_05;
		}
	}

	return var_00;
}

//Function Number: 56
func_582C()
{
	if(isdefined(self.var_8C95) && self.var_8C95)
	{
		if(isdefined(level.var_8C96))
		{
			return [[ level.var_8C96 ]]();
		}

		return 1;
	}

	return 1;
}

//Function Number: 57
func_1E55(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.var_7A5D) && isdefined(level.var_7A5D[param_00]))
	{
		return [[ level.var_7A5D[param_00] ]]();
	}

	if(level.var_AC80.var_2914.size == 0)
	{
		return undefined;
	}

	var_04 = undefined;
	if(param_02)
	{
		var_05 = common_scripts\utility::func_F92(func_4691());
	}
	else if(isdefined(var_04))
	{
		var_05 = common_scripts\utility::func_F92(func_4693(var_04));
	}
	else
	{
		var_05 = common_scripts\utility::func_F92(func_4692());
	}

	var_06 = [];
	foreach(var_08 in var_05)
	{
		if((var_08 func_905D() || isdefined(param_03)) && var_08 func_905C(param_00,param_01) && isdefined(param_03) || (param_02 || func_583C(var_08.var_116)) && var_08 func_582C())
		{
			var_04 = var_08;
			break;
		}
	}

	if(!isdefined(var_04) && common_scripts\utility::func_562E(level.var_7D20))
	{
		var_0A = common_scripts\utility::func_F92(level.var_AC4F);
		foreach(var_08 in var_0A)
		{
			if(var_08 func_905D() && var_08 func_905C(param_00,param_01))
			{
				var_04 = var_08;
				break;
			}
		}
	}

	if(!isdefined(var_04))
	{
		var_11 = randomint(level.var_AC80.var_2914.size);
		var_12 = level.var_AC80.var_2914[var_11];
		var_13 = level.var_AC80.var_ACB3[var_12];
		foreach(var_08 in var_13.var_ABFE)
		{
			if(var_08 func_905C(param_00,param_01))
			{
				var_04 = var_08;
				break;
			}
		}
	}

	return var_04;
}

//Function Number: 58
func_1E58(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		var_04 = [param_03];
	}
	else
	{
		var_04 = level.var_AC80.var_2914;
	}

	var_05 = [];
	foreach(var_07 in var_04)
	{
		var_08 = level.var_AC80.var_ACB3[var_07];
		var_05 = common_scripts\utility::func_F73(var_05,var_08.var_ABFE);
	}

	var_0A = lib_0558::func_4746(var_05,param_00,param_01);
	var_0A.var_5BE2 = gettime();
	return var_0A;
}

//Function Number: 59
func_1E4E(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		var_04 = [param_03];
	}
	else
	{
		var_04 = level.var_AC80.var_2914;
	}

	var_09 = [];
	foreach(var_07 in var_04)
	{
		var_0B = level.var_AC80.var_ACB3[var_07];
		foreach(var_0D in var_0B.var_ABFE)
		{
			if(!var_0D func_905D())
			{
				continue;
			}

			if(!var_0D func_905C(param_00,param_01))
			{
				continue;
			}

			if(!var_0D func_582C())
			{
				continue;
			}

			if(isdefined(var_0D.var_8109) && common_scripts\utility::func_562E(var_0D.var_50D5))
			{
				continue;
			}

			var_09[var_09.size] = var_0D;
		}
	}

	var_10 = 2;
	var_11 = undefined;
	var_12 = undefined;
	var_13 = maps/mp/agents/_agent_utility::func_43FD("all");
	foreach(var_15 in level.var_744A)
	{
		if(!isalive(var_15) || common_scripts\utility::func_562E(var_15.var_5378))
		{
			continue;
		}

		var_16 = 0;
		foreach(var_18 in var_13)
		{
			if(isdefined(var_18.var_88) && var_18.var_88 == var_15)
			{
				var_16++;
			}
		}

		if(common_scripts\utility::func_562E(var_15.var_AC5B))
		{
			var_16 = var_13.size;
		}

		var_16 = var_16 + randomfloat(var_10);
		if(!isdefined(var_12) || var_16 < var_12)
		{
			var_12 = var_16;
			var_11 = var_15;
		}
	}

	if(!isdefined(var_11))
	{
		return common_scripts\utility::func_7A33(var_09);
	}

	var_1B = 20;
	var_1C = 0.3;
	var_1D = 0.2;
	var_1E = common_scripts\utility::func_5D93(level.var_A980,1,10,40,80);
	var_1F = 10;
	var_20 = 3;
	var_21 = 2;
	var_22 = undefined;
	var_23 = undefined;
	foreach(var_25 in var_09)
	{
		var_05 = "";
		var_26 = 0;
		if(common_scripts\utility::func_562E(var_25.var_8C95))
		{
			var_26 = var_26 + var_20;
			var_27 = var_25.var_487C;
		}
		else
		{
			var_27 = var_25.var_116;
			var_25 lib_054D::func_A0DA();
			var_26 = var_26 + var_1F * var_25.var_AC3D.size;
			if(isdefined(var_25.var_3C5B) && lib_0547::func_562C(var_25.var_3C5B))
			{
				var_26 = var_26 + var_21 * var_25.var_3C5B.var_15CB.var_17EC;
			}
		}

		var_28 = function_038E(var_27,var_11.var_116);
		var_26 = var_26 + var_28 / var_1E;
		var_26 = var_26 / common_scripts\utility::func_5D93(vectordot(vectornormalize(var_11 getvelocity()),vectornormalize(var_27 - var_11.var_116)),0,1,1,1 + var_1D);
		var_26 = var_26 + randomfloat(var_26 * var_1C + var_1B);
		if(!isdefined(var_22) || var_26 < var_22)
		{
			var_22 = var_26;
			var_23 = var_25;
		}
	}

	return var_23;
}

//Function Number: 60
func_905C(param_00,param_01)
{
	if(isdefined(self.var_8260))
	{
		var_02 = strtok(self.var_8260," ,");
		var_03 = 0;
		var_04 = 0;
		foreach(var_06 in var_02)
		{
			if(var_06 == param_00)
			{
				var_03 = 1;
			}

			if(var_06 == "exclusive")
			{
				var_04 = 1;
			}
		}

		if(!var_03 && var_04 || param_01)
		{
			return 0;
		}
	}
	else if(param_01)
	{
		return 0;
	}

	return 1;
}

//Function Number: 61
func_905D()
{
	if(common_scripts\utility::func_562E(self.var_3A1B))
	{
		return 0;
	}

	if(common_scripts\utility::func_562E(self.is_zombies_spawner_script_disabled))
	{
		return 0;
	}

	if(common_scripts\utility::func_562E(level.var_7D20) && !isdefined(self.var_819A))
	{
		return 0;
	}
	else if(common_scripts\utility::func_562E(level.var_38D1) && !isdefined(self.var_819A))
	{
		var_00 = level.var_AC80.var_ACB3[self.var_AC8A];
		foreach(var_03, var_02 in var_00.var_9050)
		{
			if(common_scripts\utility::func_3C77(var_03))
			{
				return 0;
			}
		}
	}

	if(isdefined(self.var_819A))
	{
		if(!common_scripts\utility::func_3C77(self.var_819A))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 62
func_8729(param_00,param_01)
{
	if(common_scripts\utility::func_562E(param_00))
	{
		level.var_38D2[param_01] = 1;
	}
	else
	{
		level.var_38D2[param_01] = undefined;
	}

	if(level.var_38D2.size > 0)
	{
		level.var_38D1 = 1;
		return;
	}

	level.var_38D1 = undefined;
}

//Function Number: 63
func_8712(param_00,param_01)
{
	if(common_scripts\utility::func_562E(param_00))
	{
		level.var_7D21[param_01] = 1;
	}
	else
	{
		level.var_7D21[param_01] = undefined;
	}

	if(level.var_7D21.size > 0)
	{
		level.var_7D20 = 1;
		return;
	}

	level.var_7D20 = undefined;
}

//Function Number: 64
func_ACA1()
{
	var_00 = common_scripts\utility::func_46B5(self.var_AC8A,"targetname");
	if(isdefined(var_00))
	{
		var_01 = getclosestpointonnavmesh(var_00.var_116);
		self.var_74DC = var_01;
		return;
	}

	foreach(var_04, var_03 in lib_050D::func_44F9("allies"))
	{
		if(lib_0547::func_5565(var_03.var_165,self.var_AC8A))
		{
			var_01 = getclosestpointonnavmesh(var_03.var_116);
			self.var_74DC = var_04;
			return;
		}
	}

	foreach(var_06 in self.var_A615)
	{
		var_07 = var_06 method_8216(0,0,0);
		var_08 = getclosestpointonnavmesh(var_07);
		if(ispointinvolume(var_08,var_06))
		{
			self.var_74DC = var_08;
			return;
		}
	}
}

//Function Number: 65
func_ACB0(param_00)
{
	var_01 = "mp/zombieZoneTable.csv";
	var_02 = function_027B(var_01);
	return tablelookup(var_01,0,param_00,1);
}

//Function Number: 66
func_ACAC()
{
	if(common_scripts\utility::func_562E(level.var_ACA3))
	{
		return;
	}

	foreach(var_07, var_01 in level.var_AC80.var_ACB3)
	{
		var_02 = func_ACB0(var_07);
		var_01.var_ACAD = var_02 != "";
	}

	maps\mp\_utility::func_6F74(::zonehudupdateplayerthread);
}

//Function Number: 67
zonehudupdateplayerthread()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_00.var_ACA6 = [];
	var_00 thread func_ACAB();
	foreach(var_03, var_02 in level.var_AC80.var_ACB3)
	{
		var_00 common_scripts\utility::func_3799(var_03);
	}

	for(;;)
	{
		var_03 = var_00 func_462D();
		if(!isdefined(var_03))
		{
		}
		else
		{
			var_02 = level.var_AC80.var_ACB3[var_03];
			if(lib_0547::func_5565(var_00.var_5BB6,var_03))
			{
			}
			else
			{
				var_05 = "unknown";
				if(isdefined(var_00.var_5BB6))
				{
					var_05 = var_00.var_5BB6;
				}

				var_00 func_ACA7("ui_zm_previous_zone_name",var_05);
				var_00 func_ACA7("ui_zm_current_zone_name",var_03);
				var_06 = "ui_zm_player_" + var_00 getentitynumber() + "_zone_name";
				setomnvar(var_06,var_03);
				var_00.var_5BB6 = var_03;
				if(!var_00 common_scripts\utility::func_3794(var_03))
				{
					var_00 common_scripts\utility::func_379A(var_03);
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 68
func_ACAB()
{
	var_00 = self;
	var_00 endon("disconnect");
	for(;;)
	{
		if(var_00.var_ACA6.size == 0)
		{
			var_00 waittill("ZoneHud");
		}

		var_01 = var_00.var_ACA6[0];
		var_00.var_ACA6 = common_scripts\utility::func_F9A(var_00.var_ACA6,0);
		var_00 [[ var_01.var_1E61 ]](var_01.var_2A35);
	}
}

//Function Number: 69
func_ACA8(param_00)
{
	var_01 = self;
	var_01 func_ACA2(param_00,::func_ACAA);
}

//Function Number: 70
func_ACA7(param_00,param_01)
{
	var_02 = self;
	var_03 = spawnstruct();
	var_03.var_6A70 = param_00;
	var_03.var_6A71 = param_01;
	var_02 func_ACA2(var_03,::func_ACA9);
}

//Function Number: 71
func_ACA2(param_00,param_01)
{
	var_02 = self;
	var_03 = spawnstruct();
	var_03.var_2A35 = param_00;
	var_03.var_1E61 = param_01;
	var_02.var_ACA6 = common_scripts\utility::func_F6F(var_02.var_ACA6,var_03);
	var_02 notify("ZoneHud");
}

//Function Number: 72
func_ACAA(param_00)
{
	wait(param_00);
}

//Function Number: 73
func_ACA9(param_00)
{
	var_01 = self;
	var_02 = param_00.var_6A70;
	var_03 = param_00.var_6A71;
	var_01 setclientomnvar(var_02,var_03);
}