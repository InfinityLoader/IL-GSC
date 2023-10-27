/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 157
 * Decompile Time: 2669 ms
 * Timestamp: 10/27/2023 3:26:29 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_2E2A = 50;
	level.var_2E29 = [];
	level.var_2928 = 0;
	level.var_254D = gettime();
	if(!isdefined(level.var_3A53))
	{
		level.var_3A53 = 0;
	}

	if(!isdefined(level.var_3F02))
	{
		level.var_3F02 = [];
	}

	var_00 = 1;
	if(var_00)
	{
		func_3B74();
	}

	var_01 = getentarray("delete_on_load","targetname");
	foreach(var_03 in var_01)
	{
		var_03 delete();
	}

	func_51B4();
	func_51B5();
}

//Function Number: 2
func_2AB9()
{
}

//Function Number: 3
func_3B74()
{
	if(!isdefined(level.var_2DFA))
	{
		level.var_2DFA = [];
	}

	var_00 = [];
	foreach(var_02 in level.var_9478)
	{
		if(isdefined(var_02.var_165) && var_02.var_165 == "destructible_dot")
		{
			var_00[var_00.size] = var_02;
		}
	}

	var_04 = getentarray("destructible_vehicle","targetname");
	foreach(var_06 in var_04)
	{
		var_06 thread func_87D3(var_00);
	}

	var_08 = getentarray("destructible_toy","targetname");
	foreach(var_0A in var_08)
	{
		var_0A thread func_87D3(var_00);
	}

	func_2AB9();
}

//Function Number: 4
func_87D3(param_00)
{
	func_87D2();
	func_87D0(param_00);
}

//Function Number: 5
func_87D0(param_00)
{
	var_01 = self.var_2E25;
	foreach(var_03 in param_00)
	{
		if(isdefined(level.var_75[var_01].var_2DF3))
		{
			return;
		}

		if(isdefined(var_03.var_8260) && issubstr(var_03.var_8260,"destructible_type") && issubstr(var_03.var_8260,self.var_75))
		{
			if(distancesquared(self.var_116,var_03.var_116) < 1)
			{
				var_04 = getentarray(var_03.var_1A2,"targetname");
				level.var_75[var_01].var_2DF3 = [];
				foreach(var_06 in var_04)
				{
					var_07 = var_06.var_81E1;
					if(!isdefined(level.var_75[var_01].var_2DF3[var_07]))
					{
						level.var_75[var_01].var_2DF3[var_07] = [];
					}

					var_08 = level.var_75[var_01].var_2DF3[var_07].size;
					level.var_75[var_01].var_2DF3[var_07][var_08]["classname"] = var_06.var_3A;
					level.var_75[var_01].var_2DF3[var_07][var_08]["origin"] = var_06.var_116;
					var_09 = common_scripts\utility::func_98E7(isdefined(var_06.var_187),var_06.var_187,0);
					level.var_75[var_01].var_2DF3[var_07][var_08]["spawnflags"] = var_09;
					switch(var_06.var_3A)
					{
						case "trigger_radius":
							level.var_75[var_01].var_2DF3[var_07][var_08]["radius"] = var_06.var_BD;
							level.var_75[var_01].var_2DF3[var_07][var_08]["height"] = var_06.var_BD;
							break;

						default:
							break;
					}

					var_06 delete();
				}

				break;
			}
		}
	}
}

//Function Number: 6
func_2E02(param_00)
{
	if(!isdefined(level.var_75))
	{
		return -1;
	}

	if(level.var_75.size == 0)
	{
		return -1;
	}

	for(var_01 = 0;var_01 < level.var_75.size;var_01++)
	{
		if(param_00 == level.var_75[var_01].var_A265["type"])
		{
			return var_01;
		}
	}

	return -1;
}

//Function Number: 7
func_2DA4(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = "test/concrete_cover_dest_test";
	}

	if(!isdefined(param_03))
	{
		param_03 = 150;
	}

	func_2DED(param_00,"tag_origin",1,undefined,32,"no_melee");
	if(isdefined(param_04))
	{
		func_2E1C(undefined,param_04,undefined,undefined,32,"no_melee");
	}

	for(var_06 = 0;var_06 < param_01;var_06++)
	{
		var_07 = "fx_joint_" + var_06;
		func_2E0F(var_07,undefined,param_03,undefined,undefined,"no_melee",1);
		func_2DFB(var_07,param_02);
		if(isdefined(param_05))
		{
			func_2E15(param_05);
		}

		func_2E1C(undefined);
	}
}

//Function Number: 8
func_2E03(param_00)
{
	var_01 = func_2E02(param_00);
	if(var_01 >= 0)
	{
		return var_01;
	}

	if(issubstr(param_00,"dest_cover"))
	{
		func_2DA4(self.var_75,self.var_8160,self.var_815B,self.var_815C,self.var_815F,self.var_815D);
		var_01 = func_2E02(param_00);
		return var_01;
	}

	if(!isdefined(level.var_2DFA[param_00]))
	{
		return -1;
	}

	[[ level.var_2DFA[param_00] ]]();
	var_01 = func_2E02(param_00);
	return var_01;
}

//Function Number: 9
func_87D2()
{
	var_00 = undefined;
	self.var_6297 = 0;
	func_0914();
	self.var_2E25 = func_2E03(self.var_75);
	if(self.var_2E25 < 0)
	{
		return;
	}

	func_7643();
	func_091C();
	if(isdefined(level.var_2E1E) && isdefined(level.var_2E1E[self.var_75]))
	{
		common_scripts\utility::func_3C9F(level.var_2E1E[self.var_75] + "_loaded");
	}

	if(isdefined(level.var_75[self.var_2E25].var_1145))
	{
		foreach(var_03 in level.var_75[self.var_2E25].var_1145)
		{
			if(isdefined(var_03.var_95A6))
			{
				self attach(var_03.var_106,var_03.var_95A6);
			}
			else
			{
				self attach(var_03.var_106);
			}

			if(self.var_6297)
			{
				if(isdefined(var_03.var_95A6))
				{
					self.var_6296 attach(var_03.var_106,var_03.var_95A6);
					continue;
				}

				self.var_6296 attach(var_03.var_106);
			}
		}
	}

	if(isdefined(level.var_75[self.var_2E25].var_6E9F))
	{
		self.var_2E10 = [];
		for(var_05 = 0;var_05 < level.var_75[self.var_2E25].var_6E9F.size;var_05++)
		{
			self.var_2E10[var_05] = spawnstruct();
			self.var_2E10[var_05].var_A265["currentState"] = 0;
			if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_05][0].var_A265["health"]))
			{
				self.var_2E10[var_05].var_A265["health"] = level.var_75[self.var_2E25].var_6E9F[var_05][0].var_A265["health"];
			}

			if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_05][0].var_A265["random_dynamic_attachment_1"]))
			{
				var_06 = randomint(level.var_75[self.var_2E25].var_6E9F[var_05][0].var_A265["random_dynamic_attachment_1"].size);
				var_07 = level.var_75[self.var_2E25].var_6E9F[var_05][0].var_A265["random_dynamic_attachment_tag"][var_06];
				var_08 = level.var_75[self.var_2E25].var_6E9F[var_05][0].var_A265["random_dynamic_attachment_1"][var_06];
				var_09 = level.var_75[self.var_2E25].var_6E9F[var_05][0].var_A265["random_dynamic_attachment_2"][var_06];
				var_0A = level.var_75[self.var_2E25].var_6E9F[var_05][0].var_A265["clipToRemove"][var_06];
				thread func_30DF(var_07,var_08,var_09,var_0A);
			}

			if(var_05 == 0)
			{
				continue;
			}

			var_0B = level.var_75[self.var_2E25].var_6E9F[var_05][0].var_A265["modelName"];
			var_0C = level.var_75[self.var_2E25].var_6E9F[var_05][0].var_A265["tagName"];
			for(var_0D = 1;isdefined(level.var_75[self.var_2E25].var_6E9F[var_05][var_0D]);var_0D++)
			{
				var_0E = level.var_75[self.var_2E25].var_6E9F[var_05][var_0D].var_A265["tagName"];
				var_0F = level.var_75[self.var_2E25].var_6E9F[var_05][var_0D].var_A265["modelName"];
				if(isdefined(var_0E) && var_0E != var_0C)
				{
					func_4D03(var_0E);
					if(self.var_6297)
					{
						self.var_6296 func_4D03(var_0E);
					}
				}
			}
		}
	}

	if(isdefined(self.var_1A2))
	{
		thread func_2E05();
	}

	if(self.var_3B != "script_vehicle")
	{
		self setcandamage(1);
	}

	if(common_scripts\utility::func_57D7())
	{
		thread func_258B();
	}

	thread func_2E1D();
	if(issubstr(self.var_75,"dest_cover"))
	{
		thread func_2E23();
	}

	thread func_2DFF();
}

//Function Number: 10
func_2DED(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.var_75))
	{
		level.var_75 = [];
	}

	var_06 = level.var_75.size;
	level.var_75[var_06] = spawnstruct();
	level.var_75[var_06].var_A265["type"] = param_00;
	level.var_75[var_06].var_6E9F = [];
	level.var_75[var_06].var_6E9F[0][0] = spawnstruct();
	level.var_75[var_06].var_6E9F[0][0].var_A265["modelName"] = self.var_106;
	level.var_75[var_06].var_6E9F[0][0].var_A265["tagName"] = param_01;
	level.var_75[var_06].var_6E9F[0][0].var_A265["health"] = param_02;
	level.var_75[var_06].var_6E9F[0][0].var_A265["validAttackers"] = param_03;
	level.var_75[var_06].var_6E9F[0][0].var_A265["validDamageZone"] = param_04;
	level.var_75[var_06].var_6E9F[0][0].var_A265["validDamageCause"] = param_05;
	level.var_75[var_06].var_6E9F[0][0].var_A265["godModeAllowed"] = 1;
	level.var_75[var_06].var_6E9F[0][0].var_A265["rotateTo"] = self.var_1D;
	level.var_75[var_06].var_6E9F[0][0].var_A265["vehicle_exclude_anim"] = 0;
}

//Function Number: 11
func_2E0F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = level.var_75.size - 1;
	var_0B = level.var_75[var_0A].var_6E9F.size;
	var_0C = 0;
	func_2E08(var_0B,var_0C,param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,undefined,param_09);
}

//Function Number: 12
func_2E1C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = level.var_75.size - 1;
	var_09 = level.var_75[var_08].var_6E9F.size - 1;
	var_0A = level.var_75[var_08].var_6E9F[var_09].size;
	if(!isdefined(param_00) && var_09 == 0)
	{
		param_00 = level.var_75[var_08].var_6E9F[var_09][0].var_A265["tagName"];
	}

	func_2E08(var_09,var_0A,param_00,param_01,param_02,param_03,param_04,param_05,undefined,undefined,param_06,param_07);
}

//Function Number: 13
func_2DFD(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	func_2DFB(param_00,param_01,param_02,param_03,param_04,param_05,1,param_06);
}

//Function Number: 14
func_2DFB(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	if(!isdefined(param_07))
	{
		param_07 = 0;
	}

	var_08 = level.var_75.size - 1;
	var_09 = level.var_75[var_08].var_6E9F.size - 1;
	var_0A = level.var_75[var_08].var_6E9F[var_09].size - 1;
	var_0B = 0;
	if(isdefined(level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["fx_filename"]))
	{
		if(isdefined(level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["fx_filename"][param_04]))
		{
			var_0B = level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["fx_filename"][param_04].size;
		}
	}

	if(isdefined(param_03))
	{
		level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["fx_valid_damagetype"][param_04][var_0B] = param_03;
	}

	level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["fx_filename"][param_04][var_0B] = param_01;
	level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["fx_tag"][param_04][var_0B] = param_00;
	level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["fx_useTagAngles"][param_04][var_0B] = param_02;
	level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["fx_cost"][param_04][var_0B] = param_05;
	level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["spawn_immediate"][param_04][var_0B] = param_06;
	level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["state_change_kill"][param_04][var_0B] = param_07;
}

//Function Number: 15
func_2DEE(param_00)
{
	var_01 = level.var_75.size - 1;
	var_02 = level.var_75[var_01].var_6E9F.size - 1;
	var_03 = level.var_75[var_01].var_6E9F[var_02].size - 1;
	if(!isdefined(level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["dot"]))
	{
		level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["dot"] = [];
	}

	var_04 = level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["dot"].size;
	var_05 = func_27E2();
	var_05.var_1B9 = "predefined";
	var_05.var_D4 = param_00;
	level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["dot"][var_04] = var_05;
}

//Function Number: 16
func_2DEF(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_75.size - 1;
	var_05 = level.var_75[var_04].var_6E9F.size - 1;
	var_06 = level.var_75[var_04].var_6E9F[var_05].size - 1;
	if(!isdefined(level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["dot"]))
	{
		level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["dot"] = [];
	}

	var_07 = level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["dot"].size;
	var_08 = func_27E3((0,0,0),param_01,param_02,param_03);
	var_08.var_95A6 = param_00;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["dot"][var_07] = var_08;
}

//Function Number: 17
func_2E13(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = level.var_75.size - 1;
	var_09 = level.var_75[var_08].var_6E9F.size - 1;
	var_0A = level.var_75[var_08].var_6E9F[var_09].size - 1;
	var_0B = level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["dot"].size - 1;
	var_0C = level.var_75[var_08].var_6E9F[var_09][var_0A].var_A265["dot"][var_0B];
	var_0C func_866A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
	func_52AF(param_06);
}

//Function Number: 18
func_2E14(param_00,param_01,param_02)
{
	var_03 = level.var_75.size - 1;
	var_04 = level.var_75[var_03].var_6E9F.size - 1;
	var_05 = level.var_75[var_03].var_6E9F[var_04].size - 1;
	var_06 = level.var_75[var_03].var_6E9F[var_04][var_05].var_A265["dot"].size - 1;
	var_07 = level.var_75[var_03].var_6E9F[var_04][var_05].var_A265["dot"][var_06];
	var_08 = var_07.var_99C1.size;
	var_07.var_99C1[var_08].var_6B05 = param_00;
	var_07.var_99C1[var_08].var_6B33 = param_01;
	var_07.var_99C1[var_08].var_6AE6 = param_02;
}

//Function Number: 19
func_2DE8(param_00,param_01)
{
	var_02 = level.var_75.size - 1;
	var_03 = level.var_75[var_02].var_6E9F.size - 1;
	var_04 = level.var_75[var_02].var_6E9F[var_03].size - 1;
	var_05 = level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["dot"].size - 1;
	var_06 = level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["dot"][var_05];
	var_06 func_1D45(param_00,param_01);
}

//Function Number: 20
func_2DE9(param_00)
{
	var_01 = level.var_75.size - 1;
	var_02 = level.var_75[var_01].var_6E9F.size - 1;
	var_03 = level.var_75[var_01].var_6E9F[var_02].size - 1;
	var_04 = level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["dot"].size - 1;
	var_05 = level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["dot"][var_04];
	var_05 func_1D46(param_00);
}

//Function Number: 21
func_2DE7(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = level.var_75.size - 1;
	var_07 = level.var_75[var_06].var_6E9F.size - 1;
	var_08 = level.var_75[var_06].var_6E9F[var_07].size - 1;
	var_09 = level.var_75[var_06].var_6E9F[var_07][var_08].var_A265["dot"].size - 1;
	var_0A = level.var_75[var_06].var_6E9F[var_07][var_08].var_A265["dot"][var_09];
	var_0A func_1D44(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 22
func_2DEA(param_00)
{
	var_01 = level.var_75.size - 1;
	var_02 = level.var_75[var_01].var_6E9F.size - 1;
	var_03 = level.var_75[var_01].var_6E9F[var_02].size - 1;
	var_04 = level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["dot"].size - 1;
	var_05 = level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["dot"][var_04];
	var_05 func_1D47(param_00);
}

//Function Number: 23
func_2E0A(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = level.var_75.size - 1;
	var_05 = level.var_75[var_04].var_6E9F.size - 1;
	var_06 = level.var_75[var_04].var_6E9F[var_05].size - 1;
	var_07 = 0;
	if(isdefined(level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_filename"]))
	{
		var_07 = level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_filename"].size;
	}

	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_filename"][var_07] = param_01;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_tag"][var_07] = param_00;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_rate"][var_07] = param_02;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["loopfx_cost"][var_07] = param_03;
}

//Function Number: 24
func_2E07(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_75.size - 1;
	var_05 = level.var_75[var_04].var_6E9F.size - 1;
	var_06 = level.var_75[var_04].var_6E9F[var_05].size - 1;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["healthdrain_amount"] = param_00;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["healthdrain_interval"] = param_01;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["badplace_radius"] = param_02;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["badplace_team"] = param_03;
}

//Function Number: 25
func_2E15(param_00,param_01,param_02)
{
	var_03 = level.var_75.size - 1;
	var_04 = level.var_75[var_03].var_6E9F.size - 1;
	var_05 = level.var_75[var_03].var_6E9F[var_04].size - 1;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(level.var_75[var_03].var_6E9F[var_04][var_05].var_A265["sound"]))
	{
		level.var_75[var_03].var_6E9F[var_04][var_05].var_A265["sound"] = [];
		level.var_75[var_03].var_6E9F[var_04][var_05].var_A265["soundCause"] = [];
	}

	if(!isdefined(level.var_75[var_03].var_6E9F[var_04][var_05].var_A265["sound"][param_02]))
	{
		level.var_75[var_03].var_6E9F[var_04][var_05].var_A265["sound"][param_02] = [];
		level.var_75[var_03].var_6E9F[var_04][var_05].var_A265["soundCause"][param_02] = [];
	}

	var_06 = level.var_75[var_03].var_6E9F[var_04][var_05].var_A265["sound"][param_02].size;
	level.var_75[var_03].var_6E9F[var_04][var_05].var_A265["sound"][param_02][var_06] = param_00;
	level.var_75[var_03].var_6E9F[var_04][var_05].var_A265["soundCause"][param_02][var_06] = param_01;
}

//Function Number: 26
func_2E0B(param_00,param_01)
{
	var_02 = level.var_75.size - 1;
	var_03 = level.var_75[var_02].var_6E9F.size - 1;
	var_04 = level.var_75[var_02].var_6E9F[var_03].size - 1;
	if(!isdefined(level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["loopsound"]))
	{
		level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["loopsound"] = [];
		level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["loopsoundCause"] = [];
	}

	var_05 = level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["loopsound"].size;
	level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["loopsound"][var_05] = param_00;
	level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["loopsoundCause"][var_05] = param_01;
}

//Function Number: 27
func_2DE3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_09 = [];
	var_09["anim"] = param_00;
	var_09["animTree"] = param_01;
	var_09["animType"] = param_02;
	var_09["vehicle_exclude_anim"] = param_03;
	var_09["groupNum"] = param_04;
	var_09["mpAnim"] = param_05;
	var_09["maxStartDelay"] = param_06;
	var_09["animRateMin"] = param_07;
	var_09["animRateMax"] = param_08;
	func_0901("animation",var_09);
}

//Function Number: 28
func_2E1A(param_00)
{
	var_01 = [];
	var_01["spotlight_tag"] = param_00;
	var_01["spotlight_fx"] = "spotlight_fx";
	var_01["spotlight_brightness"] = 0.85;
	var_01["randomly_flip"] = 1;
	func_093B(var_01);
}

//Function Number: 29
func_093A(param_00,param_01)
{
	var_02 = [];
	var_02[param_00] = param_01;
	func_093B(var_02);
}

//Function Number: 30
func_093B(param_00)
{
	var_01 = level.var_75.size - 1;
	var_02 = level.var_75[var_01].var_6E9F.size - 1;
	var_03 = level.var_75[var_01].var_6E9F[var_02].size - 1;
	foreach(var_06, var_05 in param_00)
	{
		level.var_75[var_01].var_6E9F[var_02][var_03].var_A265[var_06] = var_05;
	}
}

//Function Number: 31
func_0901(param_00,param_01)
{
	var_02 = level.var_75.size - 1;
	var_03 = level.var_75[var_02].var_6E9F.size - 1;
	var_04 = level.var_75[var_02].var_6E9F[var_03].size - 1;
	var_05 = level.var_75[var_02].var_6E9F[var_03][var_04].var_A265;
	if(!isdefined(var_05[param_00]))
	{
		var_05[param_00] = [];
	}

	var_05[param_00][var_05[param_00].size] = param_01;
	level.var_75[var_02].var_6E9F[var_03][var_04].var_A265 = var_05;
}

//Function Number: 32
func_2DEB()
{
	var_00 = level.var_75.size - 1;
	var_01 = level.var_75[var_00].var_6E9F.size - 1;
	var_02 = level.var_75[var_00].var_6E9F[var_01].size - 1;
	level.var_75[var_00].var_6E9F[var_01][var_02].var_A265["triggerCarAlarm"] = 1;
}

//Function Number: 33
func_2E09(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 256;
	}

	var_01 = level.var_75.size - 1;
	var_02 = level.var_75[var_01].var_6E9F.size - 1;
	var_03 = level.var_75[var_01].var_6E9F[var_02].size - 1;
	level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["break_nearby_lights"] = param_00;
}

//Function Number: 34
func_7A38(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = "";
	}

	var_04 = level.var_75.size - 1;
	var_05 = level.var_75[var_04].var_6E9F.size - 1;
	var_06 = 0;
	if(!isdefined(level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_1"]))
	{
		level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_1"] = [];
		level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_2"] = [];
		level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_tag"] = [];
	}

	var_07 = level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_1"].size;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_1"][var_07] = param_01;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_2"][var_07] = param_02;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["random_dynamic_attachment_tag"][var_07] = param_00;
	level.var_75[var_04].var_6E9F[var_05][var_06].var_A265["clipToRemove"][var_07] = param_03;
}

//Function Number: 35
func_2E11(param_00,param_01)
{
	var_02 = level.var_75.size - 1;
	var_03 = level.var_75[var_02].var_6E9F.size - 1;
	var_04 = level.var_75[var_02].var_6E9F[var_03].size - 1;
	if(!isdefined(level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["physics"]))
	{
		level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["physics"] = [];
		level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["physics_tagName"] = [];
		level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["physics_velocity"] = [];
	}

	var_05 = level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["physics"].size;
	level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["physics"][var_05] = 1;
	level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["physics_tagName"][var_05] = param_00;
	level.var_75[var_02].var_6E9F[var_03][var_04].var_A265["physics_velocity"][var_05] = param_01;
}

//Function Number: 36
func_2E18(param_00)
{
	var_01 = level.var_75.size - 1;
	var_02 = level.var_75[var_01].var_6E9F.size - 1;
	var_03 = level.var_75[var_01].var_6E9F[var_02].size - 1;
	level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["splash_damage_scaler"] = param_00;
}

//Function Number: 37
func_2DF4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	var_0E = level.var_75.size - 1;
	var_0F = level.var_75[var_0E].var_6E9F.size - 1;
	var_10 = level.var_75[var_0E].var_6E9F[var_0F].size - 1;
	if(common_scripts\utility::func_57D7())
	{
		level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_range"] = param_02;
	}
	else
	{
		level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_range"] = param_03;
	}

	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["explode"] = 1;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_force_min"] = param_00;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_force_max"] = param_01;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_mindamage"] = param_04;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_maxdamage"] = param_05;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["continueDamage"] = param_06;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["originOffset"] = param_07;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["earthQuakeScale"] = param_08;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["earthQuakeRadius"] = param_09;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["originOffset3d"] = param_0A;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["delaytime"] = param_0B;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_angularImpulse_min"] = param_0C;
	level.var_75[var_0E].var_6E9F[var_0F][var_10].var_A265["explode_angularImpulse_max"] = param_0D;
}

//Function Number: 38
func_2DF9(param_00)
{
	var_01 = level.var_75.size - 1;
	var_02 = level.var_75[var_01].var_6E9F.size - 1;
	var_03 = level.var_75[var_01].var_6E9F[var_02].size - 1;
	level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["function"] = param_00;
}

//Function Number: 39
func_2E0E(param_00)
{
	var_01 = level.var_75.size - 1;
	var_02 = level.var_75[var_01].var_6E9F.size - 1;
	var_03 = level.var_75[var_01].var_6E9F[var_02].size - 1;
	level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["functionNotify"] = param_00;
}

//Function Number: 40
func_2DF0(param_00)
{
	var_01 = level.var_75.size - 1;
	var_02 = level.var_75[var_01].var_6E9F.size - 1;
	var_03 = level.var_75[var_01].var_6E9F[var_02].size - 1;
	level.var_75[var_01].var_6E9F[var_02][var_03].var_A265["damage_threshold"] = param_00;
}

//Function Number: 41
func_2DE5(param_00,param_01)
{
	param_01 = tolower(param_01);
	var_02 = level.var_75.size - 1;
	if(!isdefined(level.var_75[var_02].var_1145))
	{
		level.var_75[var_02].var_1145 = [];
	}

	var_03 = spawnstruct();
	var_03.var_106 = param_01;
	var_03.var_95A6 = param_00;
	level.var_75[var_02].var_1145[level.var_75[var_02].var_1145.size] = var_03;
}

//Function Number: 42
func_2E08(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	if(isdefined(param_03))
	{
		param_03 = tolower(param_03);
	}

	var_0D = level.var_75.size - 1;
	level.var_75[var_0D].var_6E9F[param_00][param_01] = spawnstruct();
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["modelName"] = param_03;
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["tagName"] = param_02;
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["health"] = param_04;
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["validAttackers"] = param_05;
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["validDamageZone"] = param_06;
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["validDamageCause"] = param_07;
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["alsoDamageParent"] = param_08;
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["physicsOnExplosion"] = param_09;
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["grenadeImpactDeath"] = param_0A;
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["godModeAllowed"] = 0;
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["splashRotation"] = param_0B;
	level.var_75[var_0D].var_6E9F[param_00][param_01].var_A265["receiveDamageFromParent"] = param_0C;
}

//Function Number: 43
func_7643()
{
	if(!isdefined(level.var_75[self.var_2E25].var_6E9F))
	{
		return;
	}

	if(isdefined(level.var_75[self.var_2E25].var_1145))
	{
		foreach(var_01 in level.var_75[self.var_2E25].var_1145)
		{
			precachemodel(var_01.var_106);
		}
	}

	for(var_03 = 0;var_03 < level.var_75[self.var_2E25].var_6E9F.size;var_03++)
	{
		for(var_04 = 0;var_04 < level.var_75[self.var_2E25].var_6E9F[var_03].size;var_04++)
		{
			if(level.var_75[self.var_2E25].var_6E9F[var_03].size <= var_04)
			{
				continue;
			}

			if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_03][var_04].var_A265["modelName"]))
			{
				precachemodel(level.var_75[self.var_2E25].var_6E9F[var_03][var_04].var_A265["modelName"]);
			}

			if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_03][var_04].var_A265["animation"]))
			{
				var_05 = level.var_75[self.var_2E25].var_6E9F[var_03][var_04].var_A265["animation"];
				foreach(var_07 in var_05)
				{
					if(isdefined(var_07["mpAnim"]))
					{
						common_scripts\utility::func_6756("precacheMpAnim",var_07["mpAnim"]);
					}
				}
			}

			if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_03][var_04].var_A265["random_dynamic_attachment_1"]))
			{
				foreach(var_0A in level.var_75[self.var_2E25].var_6E9F[var_03][var_04].var_A265["random_dynamic_attachment_1"])
				{
					if(isdefined(var_0A) && var_0A != "")
					{
						precachemodel(var_0A);
						precachemodel(var_0A + "_destroy");
					}
				}

				foreach(var_0A in level.var_75[self.var_2E25].var_6E9F[var_03][var_04].var_A265["random_dynamic_attachment_2"])
				{
					if(isdefined(var_0A) && var_0A != "")
					{
						precachemodel(var_0A);
						precachemodel(var_0A + "_destroy");
					}
				}
			}
		}
	}
}

//Function Number: 44
func_091C()
{
	if(!isdefined(level.var_75[self.var_2E25].var_6E9F))
	{
		return;
	}

	for(var_00 = 0;var_00 < level.var_75[self.var_2E25].var_6E9F.size;var_00++)
	{
		for(var_01 = 0;var_01 < level.var_75[self.var_2E25].var_6E9F[var_00].size;var_01++)
		{
			if(level.var_75[self.var_2E25].var_6E9F[var_00].size <= var_01)
			{
				continue;
			}

			var_02 = level.var_75[self.var_2E25].var_6E9F[var_00][var_01];
			if(isdefined(var_02.var_A265["fx_filename"]))
			{
				for(var_03 = 0;var_03 < var_02.var_A265["fx_filename"].size;var_03++)
				{
					var_04 = var_02.var_A265["fx_filename"][var_03];
					var_05 = var_02.var_A265["fx_tag"][var_03];
					if(isdefined(var_04))
					{
						if(isdefined(var_02.var_A265["fx"]) && isdefined(var_02.var_A265["fx"][var_03]) && var_02.var_A265["fx"][var_03].size == var_04.size)
						{
							continue;
						}

						for(var_06 = 0;var_06 < var_04.size;var_06++)
						{
							var_07 = var_04[var_06];
							var_08 = var_05[var_06];
							level.var_75[self.var_2E25].var_6E9F[var_00][var_01].var_A265["fx"][var_03][var_06] = loadfx(var_07,var_08);
						}
					}
				}
			}

			var_09 = level.var_75[self.var_2E25].var_6E9F[var_00][var_01].var_A265["loopfx_filename"];
			var_0A = level.var_75[self.var_2E25].var_6E9F[var_00][var_01].var_A265["loopfx_tag"];
			if(isdefined(var_09))
			{
				if(isdefined(var_02.var_A265["loopfx"]) && var_02.var_A265["loopfx"].size == var_09.size)
				{
					continue;
				}

				for(var_06 = 0;var_06 < var_09.size;var_06++)
				{
					var_0B = var_09[var_06];
					var_0C = var_0A[var_06];
					level.var_75[self.var_2E25].var_6E9F[var_00][var_01].var_A265["loopfx"][var_06] = loadfx(var_0B,var_0C);
				}
			}
		}
	}
}

//Function Number: 45
func_1F4B(param_00)
{
	foreach(var_02 in self.var_2E27)
	{
		if(var_02 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 46
func_2E1D()
{
	var_00 = 0;
	var_01 = self.var_106;
	var_02 = undefined;
	var_03 = self.var_116;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = self.var_106;
	func_2E1F(var_00,var_01,var_02,var_03,var_04,var_05,var_06);
	self endon("stop_taking_damage");
	for(;;)
	{
		var_00 = undefined;
		var_05 = undefined;
		var_04 = undefined;
		var_03 = undefined;
		var_08 = undefined;
		var_01 = undefined;
		var_02 = undefined;
		var_09 = undefined;
		var_0A = undefined;
		self waittill("damage",var_00,var_05,var_04,var_03,var_08,var_01,var_02,var_09,var_0A);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(isdefined(var_05) && isdefined(var_05.var_1B9) && var_05.var_1B9 == "soft_landing" && !var_05 func_1F4B(self))
		{
			continue;
		}

		if(common_scripts\utility::func_57D7())
		{
			var_00 = var_00 * 0.5;
		}
		else
		{
			var_00 = var_00 * 1;
		}

		if(var_00 <= 0)
		{
			continue;
		}

		if(common_scripts\utility::func_57D7())
		{
			if(isdefined(var_05) && isplayer(var_05))
			{
				self.var_29D4 = var_05;
			}
		}
		else if(isdefined(var_05) && isplayer(var_05))
		{
			self.var_29D4 = var_05;
		}
		else if(isdefined(var_05) && isdefined(var_05.var_48EA) && isplayer(var_05.var_48EA))
		{
			self.var_29D4 = var_05.var_48EA;
		}

		var_08 = func_4487(var_08);
		if(func_5609(var_05,var_08))
		{
			if(common_scripts\utility::func_57D7())
			{
				var_00 = var_00 * 8;
			}
			else
			{
				var_00 = var_00 * 4;
			}
		}

		if(!isdefined(var_01) || var_01 == "")
		{
			var_01 = self.var_106;
		}

		if(isdefined(var_02) && var_02 == "")
		{
			if(isdefined(var_09) && var_09 != "" && var_09 != "tag_body" && var_09 != "body_animate_jnt")
			{
				var_02 = var_09;
			}
			else
			{
				var_02 = undefined;
			}

			var_0B = level.var_75[self.var_2E25].var_6E9F[0][0].var_A265["tagName"];
			if(isdefined(var_0B) && isdefined(var_09) && var_0B == var_09)
			{
				var_02 = undefined;
			}
		}

		if(var_08 == "splash" || var_08 == "energy")
		{
			if(isdefined(level.var_75[self.var_2E25].var_6E9F[0][0].var_A265["splash_damage_scaler"]))
			{
				var_00 = var_00 * level.var_75[self.var_2E25].var_6E9F[0][0].var_A265["splash_damage_scaler"];
			}
			else if(common_scripts\utility::func_57D7())
			{
				var_00 = var_00 * 9;
			}
			else
			{
				var_00 = var_00 * 13;
			}

			if(var_07 == self.var_106 && isdefined(self.var_815F))
			{
				self setmodel(self.var_815F);
			}

			func_2E17(int(var_00),var_03,var_04,var_05,var_08);
			continue;
		}

		thread func_2E1F(int(var_00),var_01,var_02,var_03,var_04,var_05,var_08);
	}
}

//Function Number: 47
func_5609(param_00,param_01)
{
	if(param_01 != "bullet")
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	var_02 = undefined;
	if(isplayer(param_00))
	{
		var_02 = param_00 getcurrentweapon();
	}
	else if(isdefined(level.var_3603) && level.var_3603)
	{
		if(isdefined(param_00.var_1D0))
		{
			var_02 = param_00.var_1D0;
		}
	}

	if(!isdefined(var_02))
	{
		return 0;
	}

	var_03 = function_01AA(var_02);
	if(isdefined(var_03) && var_03 == "spread")
	{
		return 1;
	}

	return 0;
}

//Function Number: 48
func_45FD(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_A265 = [];
	var_03 = -1;
	var_04 = -1;
	if(tolower(param_00) == tolower(self.var_106) && !isdefined(param_01))
	{
		param_00 = self.var_106;
		param_01 = undefined;
		var_03 = 0;
		var_04 = 0;
	}

	for(var_05 = 0;var_05 < level.var_75[self.var_2E25].var_6E9F.size;var_05++)
	{
		var_04 = self.var_2E10[var_05].var_A265["currentState"];
		if(level.var_75[self.var_2E25].var_6E9F[var_05].size <= var_04)
		{
			continue;
		}

		if(!isdefined(param_01))
		{
			continue;
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_05][var_04].var_A265["tagName"]))
		{
			var_06 = level.var_75[self.var_2E25].var_6E9F[var_05][var_04].var_A265["tagName"];
			if(tolower(var_06) == tolower(param_01))
			{
				var_03 = var_05;
				break;
			}
		}
	}

	var_02.var_A265["stateIndex"] = var_04;
	var_02.var_A265["partIndex"] = var_03;
	return var_02;
}

//Function Number: 49
func_2E1F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(self.var_2E10))
	{
		return;
	}

	if(self.var_2E10.size == 0)
	{
		return;
	}

	if(level.var_3A53)
	{
		self endon("destroyed");
	}

	var_08 = func_45FD(param_01,param_02);
	var_09 = var_08.var_A265["stateIndex"];
	var_0A = var_08.var_A265["partIndex"];
	if(var_0A < 0)
	{
		return;
	}

	var_0B = var_09;
	var_0C = 0;
	var_0D = 0;
	for(;;)
	{
		var_09 = self.var_2E10[var_0A].var_A265["currentState"];
		if(!isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_09]))
		{
			break;
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][0].var_A265["alsoDamageParent"]))
		{
			if(func_4487(param_06) != "splash")
			{
				var_0E = level.var_75[self.var_2E25].var_6E9F[var_0A][0].var_A265["alsoDamageParent"];
				var_0F = int(param_00 * var_0E);
				thread func_6807(var_0F,param_05,param_04,param_03,param_06,"","");
			}
		}

		if(var_0A == 0 && func_4487(param_06) != "splash")
		{
			for(var_10 = 0;var_10 < level.var_75[self.var_2E25].var_6E9F.size;var_10++)
			{
				var_11 = level.var_75[self.var_2E25].var_6E9F[var_10];
				if(!isdefined(var_11[0].var_A265["receiveDamageFromParent"]))
				{
					continue;
				}

				var_12 = 0;
				if(isdefined(self.var_2E10[var_10].var_A265["currentState"]))
				{
					var_12 = self.var_2E10[var_10].var_A265["currentState"];
				}

				if(!isdefined(var_11[var_12]))
				{
					continue;
				}

				if(!isdefined(var_11[var_12].var_A265["tagName"]))
				{
					continue;
				}

				var_13 = var_11[var_12].var_A265["tagName"];
				var_0E = var_11[0].var_A265["receiveDamageFromParent"];
				var_14 = int(param_00 * var_0E);
				thread func_6807(var_14,param_05,param_04,param_03,param_06,"",var_13);
			}
		}

		if(!isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_09].var_A265["health"]))
		{
			break;
		}

		if(!isdefined(self.var_2E10[var_0A].var_A265["health"]))
		{
			break;
		}

		if(var_0C)
		{
			self.var_2E10[var_0A].var_A265["health"] = level.var_75[self.var_2E25].var_6E9F[var_0A][var_09].var_A265["health"];
		}

		var_0C = 0;
		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_09].var_A265["grenadeImpactDeath"]) && param_06 == "impact")
		{
			param_00 = 100000000;
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_09].var_A265["damage_threshold"]) && level.var_75[self.var_2E25].var_6E9F[var_0A][var_09].var_A265["damage_threshold"] > param_00)
		{
			param_00 = 0;
		}

		var_15 = self.var_2E10[var_0A].var_A265["health"];
		var_16 = func_567E(var_0A,var_09,param_05);
		if(var_16)
		{
			var_17 = func_5825(var_0A,var_09,param_06);
			if(var_17)
			{
				if(isdefined(param_05))
				{
					if(isplayer(param_05))
					{
						self.var_724D = self.var_724D + param_00;
					}
					else if(param_05 != self)
					{
						self.var_6727 = self.var_6727 + param_00;
					}
				}

				if(isdefined(param_06))
				{
					if(param_06 == "melee" || param_06 == "impact")
					{
						param_00 = 100000;
					}
				}

				self.var_2E10[var_0A].var_A265["health"] = self.var_2E10[var_0A].var_A265["health"] - param_00;
			}
		}

		if(self.var_2E10[var_0A].var_A265["health"] > 0)
		{
			return;
		}

		if(isdefined(param_07))
		{
			param_07.var_A265["fxcost"] = func_4283(var_0A,self.var_2E10[var_0A].var_A265["currentState"]);
			func_091D(self,param_07,param_00);
			if(!isdefined(self.var_A6E7))
			{
				self.var_A6E7 = 1;
			}
			else
			{
				self.var_A6E7++;
			}

			self waittill("queue_processed",var_18);
			self.var_A6E7--;
			if(self.var_A6E7 == 0)
			{
				self.var_A6E7 = undefined;
			}

			if(!var_18)
			{
				self.var_2E10[var_0A].var_A265["health"] = var_15;
				return;
			}
		}

		param_00 = int(abs(self.var_2E10[var_0A].var_A265["health"]));
		if(param_00 < 0)
		{
			return;
		}

		self.var_2E10[var_0A].var_A265["currentState"]++;
		var_09 = self.var_2E10[var_0A].var_A265["currentState"];
		var_19 = var_09 - 1;
		var_1A = undefined;
		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19]))
		{
			var_1A = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265;
		}

		var_1B = undefined;
		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_09]))
		{
			var_1B = level.var_75[self.var_2E25].var_6E9F[var_0A][var_09].var_A265;
		}

		if(!isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19]))
		{
			return;
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["explode"]))
		{
			self.var_3949 = 1;
		}

		if(isdefined(self.var_5EFB) && isdefined(self.var_5EFB[common_scripts\utility::func_9AAD(var_0A)]))
		{
			for(var_10 = 0;var_10 < self.var_5EFB[common_scripts\utility::func_9AAD(var_0A)].size;var_10++)
			{
				self notify(self.var_5EFB[common_scripts\utility::func_9AAD(var_0A)][var_10]);
				if(common_scripts\utility::func_57D7() && self.var_6297)
				{
					self.var_6296 notify(self.var_5EFB[common_scripts\utility::func_9AAD(var_0A)][var_10]);
				}
			}

			self.var_5EFB[common_scripts\utility::func_9AAD(var_0A)] = undefined;
		}

		if(isdefined(var_1A["break_nearby_lights"]))
		{
			func_2E01(var_1A["break_nearby_lights"]);
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_09]))
		{
			if(var_0A == 0)
			{
				var_1C = var_1B["modelName"];
				if(isdefined(var_1C) && var_1C != self.var_106)
				{
					self setmodel(var_1C);
					if(common_scripts\utility::func_57D7() && self.var_6297)
					{
						self.var_6296 setmodel(var_1C);
					}

					func_2E19(var_1B);
				}
			}
			else
			{
				func_4D03(param_02);
				if(common_scripts\utility::func_57D7() && self.var_6297)
				{
					self.var_6296 func_4D03(param_02);
				}

				param_02 = var_1B["tagName"];
				if(isdefined(param_02))
				{
					func_8BED(param_02);
					if(common_scripts\utility::func_57D7() && self.var_6297)
					{
						self.var_6296 func_8BED(param_02);
					}
				}
			}
		}

		var_1D = func_4168();
		if(isdefined(self.var_3949))
		{
			func_23A2(var_1D);
		}

		var_1E = func_2DE4(var_1A,var_1D,param_06,var_0A);
		var_1E = func_2E00(var_1A,var_1D,param_06,var_0A,var_1E);
		self notify("FX_State_Change_Kill" + var_0A);
		var_1E = func_2E16(var_1A,var_1D,param_06,var_1E);
		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["loopfx"]))
		{
			var_1F = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["loopfx_filename"].size;
			if(var_1F > 0)
			{
				self notify("FX_State_Change" + var_0A);
			}

			for(var_20 = 0;var_20 < var_1F;var_20++)
			{
				var_21 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["loopfx"][var_20];
				var_22 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["loopfx_tag"][var_20];
				var_23 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["loopfx_rate"][var_20];
				thread func_5EEF(var_21,var_22,var_23,var_0A);
			}
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["loopsound"]))
		{
			for(var_10 = 0;var_10 < level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["loopsound"].size;var_10++)
			{
				var_24 = func_583B("loopsoundCause",var_1A,var_10,param_06);
				if(var_24)
				{
					var_25 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["loopsound"][var_10];
					var_26 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["tagName"];
					thread func_7152(var_25,var_26);
					if(!isdefined(self.var_5EFB))
					{
						self.var_5EFB = [];
					}

					if(!isdefined(self.var_5EFB[common_scripts\utility::func_9AAD(var_0A)]))
					{
						self.var_5EFB[common_scripts\utility::func_9AAD(var_0A)] = [];
					}

					var_27 = self.var_5EFB[common_scripts\utility::func_9AAD(var_0A)].size;
					self.var_5EFB[common_scripts\utility::func_9AAD(var_0A)][var_27] = "stop sound" + var_25;
				}
			}
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["triggerCarAlarm"]))
		{
			thread func_3097();
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["break_nearby_lights"]))
		{
			thread func_1BA6();
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["healthdrain_amount"]))
		{
			self notify("Health_Drain_State_Change" + var_0A);
			var_28 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["healthdrain_amount"];
			var_29 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["healthdrain_interval"];
			var_2A = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["modelName"];
			var_2B = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["tagName"];
			var_2C = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["badplace_radius"];
			var_2D = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["badplace_team"];
			if(var_28 > 0)
			{
				thread func_4C08(var_28,var_29,var_0A,var_2A,var_2B,var_2C,var_2D);
			}
		}

		var_2E = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["dot"];
		if(isdefined(var_2E))
		{
			foreach(var_30 in var_2E)
			{
				var_31 = var_30.var_D4;
				if(var_30.var_1B9 == "predefined" && isdefined(var_31))
				{
					var_32 = [];
					foreach(var_34 in level.var_75[self.var_2E25].var_2DF3[var_31])
					{
						var_35 = var_34["classname"];
						var_36 = undefined;
						switch(var_35)
						{
							case "trigger_radius":
								var_37 = var_34["origin"];
								var_38 = var_34["spawnflags"];
								var_39 = var_34["radius"];
								var_3A = var_34["height"];
								var_36 = func_27E3(self.var_116 + var_37,var_38,var_39,var_3A);
								var_36.var_99C1 = var_30.var_99C1;
								var_32[var_32.size] = var_36;
								break;
	
							default:
								break;
						}
					}

					level thread func_92C7(var_32);
					continue;
				}

				if(isdefined(var_30))
				{
					if(isdefined(var_30.var_95A6))
					{
						var_30 func_866B(self gettagorigin(var_30.var_95A6));
					}

					level thread func_92C7([var_30]);
				}
			}

			var_2E = undefined;
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["explode"]))
		{
			var_0D = 1;
			var_3D = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["explode_force_min"];
			var_3E = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["explode_force_max"];
			var_3F = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["explode_angularImpulse_min"];
			var_40 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["explode_angularImpulse_max"];
			var_41 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["explode_range"];
			var_42 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["explode_mindamage"];
			var_43 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["explode_maxdamage"];
			var_44 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["continueDamage"];
			var_45 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["originOffset"];
			var_46 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["earthQuakeScale"];
			var_47 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["earthQuakeRadius"];
			var_48 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["originOffset3d"];
			var_49 = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["delaytime"];
			if(isdefined(param_05) && param_05 != self)
			{
				self.var_1180 = param_05;
				if(self.var_3B == "script_vehicle")
				{
					self.var_29B2 = param_06;
				}
			}

			thread func_3923(var_0A,var_3D,var_3E,var_41,var_42,var_43,var_44,var_45,var_46,var_47,param_05,var_48,var_49,var_3F,var_40);
		}

		var_4A = undefined;
		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["physics"]))
		{
			for(var_10 = 0;var_10 < level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["physics"].size;var_10++)
			{
				var_4A = undefined;
				var_4B = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["physics_tagName"][var_10];
				var_4C = level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["physics_velocity"][var_10];
				var_4D = undefined;
				if(isdefined(var_4C))
				{
					var_4E = undefined;
					if(isdefined(var_4B))
					{
						var_4E = self gettagangles(var_4B);
					}
					else if(isdefined(param_02))
					{
						var_4E = self gettagangles(param_02);
					}

					var_4A = undefined;
					if(isdefined(var_4B))
					{
						var_4A = self gettagorigin(var_4B);
					}
					else if(isdefined(param_02))
					{
						var_4A = self gettagorigin(param_02);
					}

					var_4F = var_4C[0] - 5 + randomfloat(10);
					var_50 = var_4C[1] - 5 + randomfloat(10);
					var_51 = var_4C[2] - 5 + randomfloat(10);
					var_52 = anglestoforward(var_4E) * var_4F * randomfloatrange(80,110);
					var_53 = anglestoright(var_4E) * var_50 * randomfloatrange(80,110);
					var_54 = anglestoup(var_4E) * var_51 * randomfloatrange(80,110);
					var_4D = var_52 + var_53 + var_54;
				}
				else
				{
					var_4D = param_03;
					var_55 = (0,0,0);
					if(isdefined(param_05))
					{
						var_55 = param_05.var_116;
						var_4D = vectornormalize(param_03 - var_55);
						var_4D = var_4D * 200;
					}
				}

				if(isdefined(var_4B))
				{
					var_56 = undefined;
					for(var_57 = 0;var_57 < level.var_75[self.var_2E25].var_6E9F.size;var_57++)
					{
						if(!isdefined(level.var_75[self.var_2E25].var_6E9F[var_57][0].var_A265["tagName"]))
						{
							continue;
						}

						if(level.var_75[self.var_2E25].var_6E9F[var_57][0].var_A265["tagName"] != var_4B)
						{
							continue;
						}

						var_56 = var_57;
						break;
					}

					if(isdefined(var_4A))
					{
						thread func_6FA3(var_56,0,var_4A,var_4D);
					}
					else
					{
						thread func_6FA3(var_56,0,param_03,var_4D);
					}

					continue;
				}

				if(isdefined(var_4A))
				{
					thread func_6FA3(var_0A,var_19,var_4A,var_4D);
				}
				else
				{
					thread func_6FA3(var_0A,var_19,param_03,var_4D);
				}

				return;
			}
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265) && isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["functionNotify"]))
		{
			self notify(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["functionNotify"]);
		}

		if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["function"]))
		{
			self thread [[ level.var_75[self.var_2E25].var_6E9F[var_0A][var_19].var_A265["function"] ]]();
		}

		var_0C = 1;
	}
}

//Function Number: 50
func_2E19(param_00)
{
	var_01 = param_00["splashRotation"];
	var_02 = param_00["rotateTo"];
	if(!isdefined(var_02))
	{
		return;
	}

	if(!isdefined(var_01))
	{
		return;
	}

	if(!var_01)
	{
		return;
	}

	self.var_1D = (self.var_1D[0],var_02[1],self.var_1D[2]);
}

//Function Number: 51
func_29A7(param_00)
{
	var_01 = strtok(param_00," ");
	var_02 = strtok("splash melee bullet splash impact unknown"," ");
	var_03 = "";
	foreach(var_05 in var_01)
	{
		var_02 = common_scripts\utility::func_F93(var_02,var_05);
	}

	foreach(var_08 in var_02)
	{
		var_03 = var_03 + var_08 + " ";
	}

	return var_03;
}

//Function Number: 52
func_2E17(param_00,param_01,param_02,param_03,param_04)
{
	if(param_00 <= 0)
	{
		return;
	}

	if(isdefined(self.var_3928))
	{
		return;
	}

	if(!isdefined(level.var_75[self.var_2E25].var_6E9F))
	{
		return;
	}

	var_05 = func_440C(param_02);
	if(var_05.size <= 0)
	{
		return;
	}

	var_05 = func_8666(var_05,param_01);
	var_06 = func_456B(var_05);
	foreach(var_08 in var_05)
	{
		var_09 = var_08.var_A265["distance"] * 1.4;
		var_0A = param_00 - var_09 - var_06;
		if(var_0A <= 0)
		{
			continue;
		}

		if(isdefined(self.var_3928))
		{
			continue;
		}

		thread func_2E1F(var_0A,var_08.var_A265["modelName"],var_08.var_A265["tagName"],param_01,param_02,param_03,param_04,var_08);
	}
}

//Function Number: 53
func_440C(param_00)
{
	var_01 = [];
	if(!isdefined(level.var_75[self.var_2E25].var_6E9F))
	{
		return var_01;
	}

	for(var_02 = 0;var_02 < level.var_75[self.var_2E25].var_6E9F.size;var_02++)
	{
		var_03 = var_02;
		var_04 = self.var_2E10[var_03].var_A265["currentState"];
		for(var_05 = 0;var_05 < level.var_75[self.var_2E25].var_6E9F[var_03].size;var_05++)
		{
			var_06 = level.var_75[self.var_2E25].var_6E9F[var_03][var_05].var_A265["splashRotation"];
			if(isdefined(var_06) && var_06)
			{
				var_07 = vectortoangles(param_00);
				var_08 = var_07[1] - 90;
				level.var_75[self.var_2E25].var_6E9F[var_03][var_05].var_A265["rotateTo"] = (0,var_08,0);
			}
		}

		if(!isdefined(level.var_75[self.var_2E25].var_6E9F[var_03][var_04]))
		{
			continue;
		}

		var_09 = level.var_75[self.var_2E25].var_6E9F[var_03][var_04].var_A265["tagName"];
		if(!isdefined(var_09))
		{
			var_09 = "";
		}

		if(var_09 == "")
		{
			continue;
		}

		var_0A = level.var_75[self.var_2E25].var_6E9F[var_03][var_04].var_A265["modelName"];
		if(!isdefined(var_0A))
		{
			var_0A = "";
		}

		var_0B = var_01.size;
		var_01[var_0B] = spawnstruct();
		var_01[var_0B].var_A265["modelName"] = var_0A;
		var_01[var_0B].var_A265["tagName"] = var_09;
	}

	return var_01;
}

//Function Number: 54
func_8666(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = distance(param_01,self gettagorigin(param_00[var_02].var_A265["tagName"]));
		param_00[var_02].var_A265["distance"] = var_03;
	}

	return param_00;
}

//Function Number: 55
func_456B(param_00)
{
	var_01 = undefined;
	foreach(var_03 in param_00)
	{
		var_04 = var_03.var_A265["distance"];
		if(!isdefined(var_01))
		{
			var_01 = var_04;
		}

		if(var_04 < var_01)
		{
			var_01 = var_04;
		}
	}

	return var_01;
}

//Function Number: 56
func_583B(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		var_05 = param_01[param_00][param_04][param_02];
	}
	else
	{
		var_05 = param_02[param_01][param_03];
	}

	if(!isdefined(var_05))
	{
		return 1;
	}

	if(var_05 == param_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 57
func_567E(param_00,param_01,param_02)
{
	if(isdefined(self.var_3E1B))
	{
		return 1;
	}

	if(isdefined(level.var_75[self.var_2E25].var_6E9F[param_00][param_01].var_A265["explode"]))
	{
		if(isdefined(self.var_323D))
		{
			return 0;
		}
	}

	if(!isdefined(param_02))
	{
		return 1;
	}

	if(param_02 == self)
	{
		return 1;
	}

	var_03 = level.var_75[self.var_2E25].var_6E9F[param_00][param_01].var_A265["validAttackers"];
	if(!isdefined(var_03))
	{
		return 1;
	}

	if(var_03 == "no_player")
	{
		if(!isplayer(param_02))
		{
			return 1;
		}

		if(!isdefined(param_02.var_29CF))
		{
			return 1;
		}

		if(param_02.var_29CF == 0)
		{
			return 1;
		}
	}
	else if(var_03 == "player_only")
	{
		if(isplayer(param_02))
		{
			return 1;
		}

		if(isdefined(param_02.var_29CF) && param_02.var_29CF)
		{
			return 1;
		}
	}
	else if(var_03 == "no_ai" && isdefined(level.var_5665))
	{
		if(![[ level.var_5665 ]](param_02))
		{
			return 1;
		}
	}
	else if(var_03 == "ai_only" && isdefined(level.var_5665))
	{
		if([[ level.var_5665 ]](param_02))
		{
			return 1;
		}
	}
	else
	{
	}

	return 0;
}

//Function Number: 58
func_5825(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return 1;
	}

	var_03 = level.var_75[self.var_2E25].var_6E9F[param_00][param_01].var_A265["godModeAllowed"];
	if(var_03 && (isdefined(self.var_480F) && self.var_480F) || isdefined(self.var_812F) && self.var_812F && param_02 == "bullet")
	{
		return 0;
	}

	var_04 = level.var_75[self.var_2E25].var_6E9F[param_00][param_01].var_A265["validDamageCause"];
	if(!isdefined(var_04))
	{
		return 1;
	}

	if(var_04 == "splash" && param_02 != "splash")
	{
		return 0;
	}

	if(var_04 == "no_splash" && param_02 == "splash")
	{
		return 0;
	}

	if((var_04 == "no_melee" && param_02 == "melee") || param_02 == "impact")
	{
		return 0;
	}

	if(var_04 == "bullet" && param_02 != "bullet")
	{
		return 0;
	}

	return 1;
}

//Function Number: 59
func_4487(param_00)
{
	if(!isdefined(param_00))
	{
		return "unknown";
	}

	param_00 = tolower(param_00);
	switch(param_00)
	{
		case "mod_crush":
		case "mod_melee":
		case "melee":
			return "melee";

		case "mod_rifle_bullet":
		case "mod_pistol_bullet":
		case "bullet":
			return "bullet";

		case "mod_explosive":
		case "mod_projectile_splash":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_grenade":
		case "splash":
			return "splash";

		case "mod_impact":
			return "impact";

		case "mod_energy":
			return "energy";

		case "unknown":
			return "unknown";

		default:
			return "unknown";
	}
}

//Function Number: 60
func_29A6(param_00,param_01,param_02)
{
	self notify("stop_damage_mirror");
	self endon("stop_damage_mirror");
	param_00 endon("stop_taking_damage");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_03,var_04,var_05,var_06,var_07);
		param_00 notify("damage",var_03,var_04,var_05,var_06,var_07,param_01,param_02);
		var_03 = undefined;
		var_04 = undefined;
		var_05 = undefined;
		var_06 = undefined;
		var_07 = undefined;
	}
}

//Function Number: 61
func_0914()
{
	self.var_724D = 0;
	self.var_6727 = 0;
	self.var_1FCF = 1;
}

//Function Number: 62
func_5EEF(param_00,param_01,param_02,param_03)
{
	self endon("FX_State_Change" + param_03);
	self endon("delete_destructible");
	level endon("putout_fires");
	while(isdefined(self))
	{
		var_04 = func_4168();
		playfxontag(param_00,var_04,param_01);
		wait(param_02);
	}
}

//Function Number: 63
func_4C08(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("Health_Drain_State_Change" + param_02);
	level endon("putout_fires");
	self endon("destroyed");
	if(isdefined(param_05) && isdefined(level.var_2DE6))
	{
		param_05 = param_05 * level.var_2DE6;
	}

	if(isdefined(param_00) && isdefined(level.var_2E06))
	{
		param_00 = param_00 * level.var_2E06;
	}

	wait(param_01);
	self.var_4C18 = 1;
	var_07 = undefined;
	if(isdefined(level.var_2F30) && level.var_2F30)
	{
		param_05 = undefined;
	}

	if(isdefined(param_05) && isdefined(level.var_14F6))
	{
		var_07 = "" + gettime();
		if(!isdefined(self.var_2F71))
		{
			if(isdefined(self.var_8276))
			{
				param_05 = self.var_8276;
			}

			if(common_scripts\utility::func_57D7() && isdefined(param_06))
			{
				if(param_06 == "both")
				{
					[[ level.var_14F6 ]](var_07,0,self.var_116,param_05,128,"allies","bad_guys");
				}
				else
				{
					[[ level.var_14F6 ]](var_07,0,self.var_116,param_05,128,param_06);
				}

				thread func_14F8(var_07);
			}
			else
			{
				[[ level.var_14F6 ]](var_07,0,self.var_116,param_05,128);
				thread func_14F8(var_07);
			}
		}
	}

	while(isdefined(self) && self.var_2E10[param_02].var_A265["health"] > 0)
	{
		self notify("damage",param_00,self,(0,0,0),(0,0,0),"MOD_UNKNOWN",param_03,param_04);
		wait(param_01);
	}

	self notify("remove_badplace");
}

//Function Number: 64
func_14F8(param_00)
{
	common_scripts\utility::knock_off_battery("destroyed","remove_badplace");
	[[ level.var_14F7 ]](param_00);
}

//Function Number: 65
func_6FA3(param_00,param_01,param_02,param_03)
{
	var_04 = func_6FA6(param_00,param_01);
	var_04 method_82C5(param_02,param_03);
}

//Function Number: 66
func_6FA4(param_00,param_01,param_02,param_03)
{
	var_04 = func_6FA6(param_00,param_01);
	var_04 method_83C9(param_02,param_03);
}

//Function Number: 67
func_6FA6(param_00,param_01)
{
	var_02 = level.var_75[self.var_2E25].var_6E9F[param_00][param_01].var_A265["modelName"];
	var_03 = level.var_75[self.var_2E25].var_6E9F[param_00][param_01].var_A265["tagName"];
	func_4D03(var_03);
	if(level.var_2E29.size >= level.var_2E2A)
	{
		func_6FA7(level.var_2E29[0]);
	}

	var_04 = spawn("script_model",self gettagorigin(var_03));
	var_04.var_1D = self gettagangles(var_03);
	var_04 setmodel(var_02);
	level.var_2E29[level.var_2E29.size] = var_04;
	return var_04;
}

//Function Number: 68
func_6FA7(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.var_2E29.size;var_02++)
	{
		if(level.var_2E29[var_02] == param_00)
		{
			continue;
		}

		var_01[var_01.size] = level.var_2E29[var_02];
	}

	level.var_2E29 = var_01;
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 69
func_3923(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E)
{
	if(isdefined(param_03) && isdefined(level.var_2DF5))
	{
		param_03 = param_03 * level.var_2DF5;
	}

	if(!isdefined(param_07))
	{
		param_07 = 80;
	}

	if(!isdefined(param_0B))
	{
		param_0B = (0,0,0);
	}

	if(!isdefined(param_06) || isdefined(param_06) && !param_06)
	{
		if(isdefined(self.var_3928))
		{
			return;
		}

		self.var_3928 = 1;
	}

	if(!isdefined(param_0C))
	{
		param_0C = 0;
	}

	self notify("exploded",param_0A);
	level notify("destructible_exploded",self,param_0A);
	if(self.var_3B == "script_vehicle")
	{
		self notify("death",param_0A,self.var_29B2);
	}

	if(common_scripts\utility::func_57D7())
	{
		thread func_2FC6();
	}

	if(!level.var_3A53)
	{
		wait 0.05;
	}

	if(!isdefined(self))
	{
		return;
	}

	var_0F = self.var_2E10[param_00].var_A265["currentState"];
	var_10 = undefined;
	if(isdefined(level.var_75[self.var_2E25].var_6E9F[param_00][var_0F]))
	{
		var_10 = level.var_75[self.var_2E25].var_6E9F[param_00][var_0F].var_A265["tagName"];
	}

	if(isdefined(var_10))
	{
		var_11 = self gettagorigin(var_10);
	}
	else
	{
		var_11 = self.var_116;
	}

	self notify("damage",param_05,self,(0,0,0),var_11,"MOD_EXPLOSIVE","","");
	self notify("stop_car_alarm");
	waittillframeend;
	if(isdefined(level.var_75[self.var_2E25].var_6E9F))
	{
		for(var_12 = level.var_75[self.var_2E25].var_6E9F.size - 1;var_12 >= 0;var_12--)
		{
			if(var_12 == param_00)
			{
				continue;
			}

			var_13 = self.var_2E10[var_12].var_A265["currentState"];
			if(var_13 >= level.var_75[self.var_2E25].var_6E9F[var_12].size)
			{
				var_13 = level.var_75[self.var_2E25].var_6E9F[var_12].size - 1;
			}

			var_14 = level.var_75[self.var_2E25].var_6E9F[var_12][var_13].var_A265["modelName"];
			var_10 = level.var_75[self.var_2E25].var_6E9F[var_12][var_13].var_A265["tagName"];
			if(!isdefined(var_14))
			{
				continue;
			}

			if(!isdefined(var_10))
			{
				continue;
			}

			var_15 = 0;
			if(isdefined(self.var_2E10[var_12].var_A265["health"]))
			{
				var_15 = self.var_2E10[var_12].var_A265["health"];
			}

			var_16 = 0;
			if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_12][var_13].var_A265["health"]))
			{
				var_16 = level.var_75[self.var_2E25].var_6E9F[var_12][var_13].var_A265["health"];
			}

			if(var_16 > 0 && var_15 <= 0)
			{
				continue;
			}

			if(isdefined(level.var_75[self.var_2E25].var_6E9F[var_12][0].var_A265["physicsOnExplosion"]))
			{
				if(level.var_75[self.var_2E25].var_6E9F[var_12][0].var_A265["physicsOnExplosion"] > 0)
				{
					var_17 = level.var_75[self.var_2E25].var_6E9F[var_12][0].var_A265["physicsOnExplosion"];
					var_18 = self gettagorigin(var_10);
					var_19 = vectornormalize(var_18 - var_11);
					var_19 = var_19 * randomfloatrange(param_01,param_02) * var_17;
					if(isdefined(param_0D) && isdefined(param_0E))
					{
						var_1A = common_scripts\utility::func_7A61(param_0D,param_0E);
						thread func_6FA4(var_12,var_13,var_19,var_1A);
					}
					else
					{
						thread func_6FA3(var_12,var_13,var_18,var_19);
					}

					continue;
				}
			}
		}
	}

	var_1B = !isdefined(param_06) || isdefined(param_06) && !param_06;
	if(var_1B)
	{
		self notify("stop_taking_damage");
	}

	if(!level.var_3A53)
	{
		wait 0.05;
	}

	if(!isdefined(self))
	{
		return;
	}

	var_1C = var_11 + (0,0,param_07) + param_0B;
	var_1D = getsubstr(level.var_75[self.var_2E25].var_A265["type"],0,7) == "vehicle";
	if(var_1D)
	{
		anim.var_5B7D = gettime();
		anim.var_5B7A = var_1C;
		anim.var_5B7B = var_11;
		anim.var_5B7C = param_03;
	}

	level thread func_846F(1);
	if(param_0C > 0)
	{
		wait(param_0C);
	}

	if(isdefined(level.var_2E12))
	{
		thread [[ level.var_2E12 ]]();
	}

	if(common_scripts\utility::func_57D7())
	{
		if(level.var_3FD4 == 0 && !func_7381())
		{
			self entityradiusdamage(var_1C,param_03,param_05,param_04,self,"MOD_RIFLE_BULLET");
		}
		else
		{
			self entityradiusdamage(var_1C,param_03,param_05,param_04,self);
		}

		if(isdefined(self.var_29D4) && var_1D)
		{
			self.var_29D4 notify("destroyed_car");
			level notify("player_destroyed_car",self.var_29D4,var_1C);
		}
	}
	else
	{
		var_1E = "destructible_toy";
		if(var_1D)
		{
			var_1E = "destructible_car";
		}

		if(!isdefined(self.var_29D4))
		{
			self entityradiusdamage(var_1C,param_03,param_05,param_04,self,"MOD_EXPLOSIVE",var_1E);
		}
		else
		{
			self entityradiusdamage(var_1C,param_03,param_05,param_04,self.var_29D4,"MOD_EXPLOSIVE",var_1E);
			if(var_1D)
			{
				self.var_29D4 notify("destroyed_car");
				level notify("player_destroyed_car",self.var_29D4,var_1C);
			}
		}
	}

	if(isdefined(param_08) && isdefined(param_09))
	{
		earthquake(param_08,2,var_1C,param_09);
	}

	level thread func_846F(0,0.05);
	var_1F = 0.01;
	var_20 = param_03 * var_1F;
	param_03 = param_03 * 0.99;
	physicsexplosionsphere(var_11,param_03,0,var_20);
	if(var_1B)
	{
		self setcandamage(0);
		thread func_2398();
	}

	self notify("destroyed");
}

//Function Number: 70
func_2398()
{
	wait 0.05;
	while(isdefined(self) && isdefined(self.var_A6E7))
	{
		self waittill("queue_processed");
		wait 0.05;
	}

	if(!isdefined(self))
	{
		return;
	}

	self.var_ED4 = undefined;
	self.var_1180 = undefined;
	self.var_1FCF = undefined;
	self.var_1FD9 = undefined;
	self.var_29D4 = undefined;
	self.var_2E10 = undefined;
	self.var_75 = undefined;
	self.var_2E25 = undefined;
	self.var_4C18 = undefined;
	self.var_6727 = undefined;
	self.var_724D = undefined;
	if(!isdefined(level.var_2DEC))
	{
		return;
	}

	self.var_8249 = undefined;
	self.var_3949 = undefined;
	self.var_5EFB = undefined;
	self.var_1FC7 = undefined;
}

//Function Number: 71
func_846F(param_00,param_01)
{
	level notify("set_disable_friendlyfire_value_delayed");
	level endon("set_disable_friendlyfire_value_delayed");
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	level.var_3ECF = param_00;
}

//Function Number: 72
func_258B()
{
	var_00 = func_4391();
	if(!isdefined(var_00))
	{
		return;
	}

	var_00 [[ level.var_2587 ]]();
	var_00.var_116 = var_00.var_116 - (0,0,10000);
}

//Function Number: 73
func_2FC6()
{
	var_00 = func_4391();
	if(!isdefined(var_00))
	{
		return;
	}

	var_00.var_116 = var_00.var_116 + (0,0,10000);
	var_00 [[ level.var_2FC3 ]]();
	var_00.var_116 = var_00.var_116 - (0,0,10000);
}

//Function Number: 74
func_4391()
{
	if(!isdefined(self.var_1A2))
	{
		return undefined;
	}

	var_00 = getentarray(self.var_1A2,"targetname");
	foreach(var_02 in var_00)
	{
		if(isspawner(var_02))
		{
			continue;
		}

		if(isdefined(var_02.var_8161))
		{
			continue;
		}

		if(var_02.var_3B == "light")
		{
			continue;
		}

		if(!var_02.var_187 & 1)
		{
			continue;
		}

		return var_02;
	}
}

//Function Number: 75
func_4D03(param_00)
{
	self hidepart(param_00);
}

//Function Number: 76
func_8BED(param_00)
{
	self showpart(param_00);
}

//Function Number: 77
func_2F37()
{
	self.var_323D = 1;
}

//Function Number: 78
func_3DED()
{
	self.var_323D = undefined;
	self.var_3E1B = 1;
	self notify("damage",100000,self,self.var_116,self.var_116,"MOD_EXPLOSIVE","","");
}

//Function Number: 79
func_4168()
{
	if(!common_scripts\utility::func_57D7())
	{
		return self;
	}

	if(self.var_6297)
	{
		var_00 = self.var_6296;
	}
	else
	{
		var_00 = self;
	}

	return var_00;
}

//Function Number: 80
func_7152(param_00,param_01)
{
	var_02 = func_4168();
	var_03 = spawn("script_origin",(0,0,0));
	if(isdefined(param_01))
	{
		var_03.var_116 = var_02 gettagorigin(param_01);
	}
	else
	{
		var_03.var_116 = var_02.var_116;
	}

	var_03 method_861D(param_00);
	var_02 thread func_3E01(param_00);
	var_02 waittill("stop sound" + param_00);
	if(!isdefined(var_03))
	{
		return;
	}

	var_03 stoploopsound(param_00);
	var_03 delete();
}

//Function Number: 81
func_3E01(param_00)
{
	self endon("stop sound" + param_00);
	level waittill("putout_fires");
	self notify("stop sound" + param_00);
}

//Function Number: 82
func_6807(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	waittillframeend;
	if(isdefined(self.var_3928))
	{
		return;
	}

	if(common_scripts\utility::func_57D7())
	{
		param_00 = param_00 / 0.5;
	}
	else
	{
		param_00 = param_00 / 1;
	}

	self notify("damage",param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 83
func_71A7(param_00,param_01)
{
	if(isdefined(param_01))
	{
		var_02 = spawn("script_origin",self gettagorigin(param_01));
		var_02 method_805C();
		var_02 linkto(self,param_01,(0,0,0),(0,0,0));
	}
	else
	{
		var_02 = spawn("script_origin",(0,0,0));
		var_02 method_805C();
		var_02.var_116 = self.var_116;
		var_02.var_1D = self.var_1D;
		var_02 linkto(self);
	}

	var_02 method_8617(param_00);
	wait(5);
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 84
func_3097()
{
	if(isdefined(self.var_1FD9))
	{
		return;
	}

	self.var_1FD9 = 1;
	if(!func_8B54())
	{
		return;
	}

	self.var_1FC7 = spawn("script_model",self.var_116);
	self.var_1FC7 method_805C();
	self.var_1FC7 method_861D("car_alarm");
	level.var_2928++;
	thread func_1FC8();
	self waittill("stop_car_alarm");
	level.var_5B79 = gettime();
	level.var_2928--;
	self.var_1FC7 stoploopsound("car_alarm");
	self.var_1FC7 delete();
}

//Function Number: 85
func_1FC8()
{
	self endon("stop_car_alarm");
	wait(25);
	if(!isdefined(self))
	{
		return;
	}

	thread func_71A7("car_alarm_off");
	self notify("stop_car_alarm");
}

//Function Number: 86
func_8B54()
{
	if(level.var_2928 >= 2)
	{
		return 0;
	}

	var_00 = undefined;
	if(!isdefined(level.var_5B79))
	{
		if(common_scripts\utility::func_24A6())
		{
			return 1;
		}

		var_00 = gettime() - level.var_254D;
	}
	else
	{
		var_00 = gettime() - level.var_5B79;
	}

	if(level.var_2928 == 0 && var_00 >= 120)
	{
		return 1;
	}

	if(randomint(100) <= 33)
	{
		return 1;
	}

	return 0;
}

//Function Number: 87
func_30DF(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(common_scripts\utility::func_57D7())
	{
		self attach(param_01,param_00,0);
		if(isdefined(param_02) && param_02 != "")
		{
			self attach(param_02,param_00,0);
		}
	}
	else
	{
		var_04[0] = spawn("script_model",self gettagorigin(param_00));
		var_04[0].var_1D = self gettagangles(param_00);
		var_04[0] setmodel(param_01);
		var_04[0] linkto(self,param_00);
		if(isdefined(param_02) && param_02 != "")
		{
			var_04[1] = spawn("script_model",self gettagorigin(param_00));
			var_04[1].var_1D = self gettagangles(param_00);
			var_04[1] setmodel(param_02);
			var_04[1] linkto(self,param_00);
		}
	}

	if(isdefined(param_03))
	{
		var_05 = self gettagorigin(param_00);
		var_06 = func_410A(var_05,param_03);
		if(isdefined(var_06))
		{
			var_06 delete();
		}
	}

	self waittill("exploded");
	if(common_scripts\utility::func_57D7())
	{
		self method_802E(param_01,param_00);
		self attach(param_01 + "_destroy",param_00,0);
		if(isdefined(param_02) && param_02 != "")
		{
			self method_802E(param_02,param_00);
			self attach(param_02 + "_destroy",param_00,0);
			return;
		}

		return;
	}

	var_04[0] setmodel(param_01 + "_destroy");
	if(isdefined(param_02) && param_02 != "")
	{
		var_04[1] setmodel(param_02 + "_destroy");
	}
}

//Function Number: 88
func_410A(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = getentarray(param_01,"targetname");
	foreach(var_06 in var_04)
	{
		var_07 = distancesquared(param_00,var_06.var_116);
		if(!isdefined(var_02) || var_07 < var_02)
		{
			var_02 = var_07;
			var_03 = var_06;
		}
	}

	return var_03;
}

//Function Number: 89
func_7381()
{
	var_00 = undefined;
	if(!isdefined(self.var_1A2))
	{
		return 0;
	}

	var_01 = getentarray(self.var_1A2,"targetname");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.var_8161) && var_03.var_8161 == "post")
		{
			var_00 = var_03;
			break;
		}
	}

	if(!isdefined(var_00))
	{
		return 0;
	}

	var_05 = func_42AD(var_00);
	if(isdefined(var_05))
	{
		return 1;
	}

	return 0;
}

//Function Number: 90
func_42AD(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		if(!isalive(var_02))
		{
			continue;
		}

		if(param_00 istouching(var_02))
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 91
func_560F()
{
	return getdvar("1996") == "1";
}

//Function Number: 92
func_2E05()
{
	var_00 = getentarray(self.var_1A2,"targetname");
	var_01 = [];
	var_01["pre"] = ::func_24E0;
	var_01["post"] = ::func_24DF;
	foreach(var_03 in var_00)
	{
		if(!isdefined(var_03.var_8161))
		{
			continue;
		}

		self thread [[ var_01[var_03.var_8161] ]](var_03);
	}
}

//Function Number: 93
func_24E0(param_00)
{
	waittillframeend;
	if(common_scripts\utility::func_57D7() && param_00.var_187 & 1)
	{
		param_00 [[ level.var_2FC3 ]]();
	}

	self waittill("exploded");
	if(common_scripts\utility::func_57D7() && param_00.var_187 & 1)
	{
		param_00 [[ level.var_2587 ]]();
	}

	param_00 delete();
}

//Function Number: 94
func_24DF(param_00)
{
	param_00 notsolid();
	if(common_scripts\utility::func_57D7() && param_00.var_187 & 1)
	{
		param_00 [[ level.var_2587 ]]();
	}

	self waittill("exploded");
	waittillframeend;
	if(common_scripts\utility::func_57D7())
	{
		if(param_00.var_187 & 1)
		{
			param_00 [[ level.var_2FC3 ]]();
		}

		if(func_560F())
		{
			var_01 = func_42AD(param_00);
			if(isdefined(var_01))
			{
				self thread [[ level.var_3F05 ]](var_01);
			}
		}
		else
		{
		}
	}

	param_00 solid();
}

//Function Number: 95
func_2AFD(param_00)
{
}

//Function Number: 96
func_2E01(param_00)
{
	var_01 = getentarray("light_destructible","targetname");
	if(common_scripts\utility::func_57D7())
	{
		var_02 = getentarray("light_destructible","script_noteworthy");
		var_01 = common_scripts\utility::func_F73(var_01,var_02);
	}

	if(!var_01.size)
	{
		return;
	}

	var_03 = param_00 * param_00;
	var_04 = undefined;
	foreach(var_06 in var_01)
	{
		var_07 = distancesquared(self.var_116,var_06.var_116);
		if(var_07 < var_03)
		{
			var_04 = var_06;
			var_03 = var_07;
		}
	}

	if(!isdefined(var_04))
	{
		return;
	}

	self.var_1BAF = var_04;
}

//Function Number: 97
func_1BA6(param_00)
{
	if(!isdefined(self.var_1BAF))
	{
		return;
	}

	self.var_1BAF method_81DF(0);
}

//Function Number: 98
func_2B01(param_00,param_01,param_02,param_03)
{
	var_04 = 16;
	var_05 = 360 / var_04;
	var_06 = [];
	for(var_07 = 0;var_07 < var_04;var_07++)
	{
		var_08 = var_05 * var_07;
		var_09 = cos(var_08) * param_01;
		var_0A = sin(var_08) * param_01;
		var_0B = param_00[0] + var_09;
		var_0C = param_00[1] + var_0A;
		var_0D = param_00[2];
		var_06[var_06.size] = (var_0B,var_0C,var_0D);
	}

	thread func_2AC5(var_06,5,(1,0,0),param_00);
	var_06 = [];
	for(var_07 = 0;var_07 < var_04;var_07++)
	{
		var_08 = var_05 * var_07;
		var_09 = cos(var_08) * param_01;
		var_0A = sin(var_08) * param_01;
		var_0B = param_00[0];
		var_0C = param_00[1] + var_09;
		var_0D = param_00[2] + var_0A;
		var_06[var_06.size] = (var_0B,var_0C,var_0D);
	}

	thread func_2AC5(var_06,5,(1,0,0),param_00);
	var_06 = [];
	for(var_07 = 0;var_07 < var_04;var_07++)
	{
		var_08 = var_05 * var_07;
		var_09 = cos(var_08) * param_01;
		var_0A = sin(var_08) * param_01;
		var_0B = param_00[0] + var_0A;
		var_0C = param_00[1];
		var_0D = param_00[2] + var_09;
		var_06[var_06.size] = (var_0B,var_0C,var_0D);
	}

	thread func_2AC5(var_06,5,(1,0,0),param_00);
}

//Function Number: 99
func_2AC5(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_05 = param_00[var_04];
		if(var_04 + 1 >= param_00.size)
		{
			var_06 = param_00[0];
		}
		else
		{
			var_06 = param_00[var_04 + 1];
		}

		thread func_2AF0(var_05,var_06,param_01,param_02);
		thread func_2AF0(param_03,var_05,param_01,param_02);
	}
}

//Function Number: 100
func_2AF0(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = (1,1,1);
	}

	for(var_04 = 0;var_04 < param_02 * 20;var_04++)
	{
		wait 0.05;
	}
}

//Function Number: 101
func_911E(param_00)
{
	param_00 endon("death");
	level waittill("new_destructible_spotlight");
	param_00 delete();
}

//Function Number: 102
func_9117(param_00,param_01,param_02,param_03,param_04)
{
	level endon("new_destructible_spotlight");
	thread func_911E(param_04);
	var_05 = param_00["spotlight_brightness"];
	wait(randomfloatrange(2,5));
	func_2E00(param_00,param_01,param_02,param_03);
	level.var_2E1A delete();
	param_04 delete();
}

//Function Number: 103
func_2E1B(param_00,param_01,param_02,param_03)
{
	if(!common_scripts\utility::func_57D7())
	{
		return;
	}

	if(!isdefined(self.var_1BAF))
	{
		return;
	}

	param_01 common_scripts\utility::func_83BE("startignoringspotLight");
	if(!isdefined(level.var_2E1A))
	{
		level.var_2E1A = common_scripts\utility::func_8FFC();
		var_04 = common_scripts\utility::func_44F5(param_00["spotlight_fx"]);
		playfxontag(var_04,level.var_2E1A,"tag_origin");
	}

	level notify("new_destructible_spotlight");
	level.var_2E1A unlink();
	var_05 = common_scripts\utility::func_8FFC();
	var_05 linkto(self,param_00["spotlight_tag"],(0,0,0),(0,0,0));
	level.var_2E1A.var_116 = self.var_1BAF.var_116;
	level.var_2E1A.var_1D = self.var_1BAF.var_1D;
	level.var_2E1A thread func_9117(param_00,param_01,param_02,param_03,var_05);
	wait 0.05;
	if(isdefined(var_05))
	{
		level.var_2E1A linkto(var_05);
	}
}

//Function Number: 104
func_5641(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(isdefined(param_01["fx_valid_damagetype"]))
	{
		var_04 = param_01["fx_valid_damagetype"][param_03][param_02];
	}

	if(!isdefined(var_04))
	{
		return 1;
	}

	return issubstr(var_04,param_00);
}

//Function Number: 105
func_2E16(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_3928))
	{
		return undefined;
	}

	if(!isdefined(param_00["sound"]))
	{
		return undefined;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_00["sound"][param_03]))
	{
		return undefined;
	}

	for(var_04 = 0;var_04 < param_00["sound"][param_03].size;var_04++)
	{
		var_05 = func_583B("soundCause",param_00,var_04,param_02,param_03);
		if(!var_05)
		{
			continue;
		}

		var_06 = param_00["sound"][param_03][var_04];
		var_07 = param_00["tagName"];
		param_01 thread func_71A7(var_06,var_07);
	}

	return param_03;
}

//Function Number: 106
func_2DFC(param_00)
{
	var_01 = level.var_75[self.var_2E25].var_6E9F[0].size - 1;
	self endon("FX_State_Change_Kill" + param_00);
	for(;;)
	{
		var_02 = -1;
		if(isdefined(self.var_2E10[0].var_A265["currentState"]))
		{
			var_02 = self.var_2E10[0].var_A265["currentState"];
		}

		if(var_02 == var_01)
		{
			return 0;
		}

		wait 0.05;
	}
}

//Function Number: 107
func_2DFE(param_00,param_01,param_02,param_03,param_04,param_05)
{
	waittillframeend;
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = undefined;
	var_07 = undefined;
	if(isdefined(param_02))
	{
		if(param_04)
		{
			playfxontag(param_01,param_00,param_02);
			wait 0.05;
			if(param_05 == 1 || param_05 == 2)
			{
				func_2DFC(param_03);
				if(param_05 == 1)
				{
					stopfxontag(param_01,param_00,param_02);
					return;
				}

				killfxontag(param_01,param_00,param_02);
				return;
			}

			return;
		}

		var_08 = param_00 gettagorigin(param_02);
		var_09 = (0,0,100);
		if(param_05 == 1 || param_05 == 2)
		{
			var_07 = spawnfx(param_01,var_08,var_09);
			var_06 = triggerfx(var_07,0.01);
		}
		else
		{
			var_06 = playfx(param_01,var_08,var_09);
		}

		wait 0.05;
		if(param_05 == 1 || param_05 == 2)
		{
			func_2DFC(param_03);
			if(param_05 == 1)
			{
				var_07 delete();
				return;
			}

			if(param_05 == 2)
			{
				function_014E(var_07,1);
				wait 0.05;
				var_07 delete();
				return;
			}

			return;
		}

		return;
	}

	var_08 = param_02.var_116;
	var_09 = (0,0,100);
	if(param_05 == 1 || param_05 == 2)
	{
		var_07 = spawnfx(param_01,var_08,var_09);
		var_06 = triggerfx(var_07,0.01);
	}
	else
	{
		var_06 = playfx(param_01,var_08,var_09);
	}

	wait 0.05;
	if(param_05 == 1 || param_05 == 2)
	{
		func_2DFC(param_03);
		if(param_05 == 1)
		{
			var_07 delete();
			return;
		}

		if(param_05 == 2)
		{
			function_014E(var_07,1);
			wait 0.05;
			var_07 delete();
			return;
		}

		return;
	}
}

//Function Number: 108
func_2DFF()
{
	if(!isdefined(level.var_75[self.var_2E25].var_6E9F))
	{
		return;
	}

	var_00 = func_4168();
	for(var_01 = 0;var_01 < level.var_75[self.var_2E25].var_6E9F.size;var_01++)
	{
		for(var_02 = 0;var_02 < level.var_75[self.var_2E25].var_6E9F[var_01].size;var_02++)
		{
			var_03 = level.var_75[self.var_2E25].var_6E9F[var_01][var_02];
			if(isdefined(var_03.var_A265["fx_filename"]))
			{
				for(var_04 = 0;var_04 < var_03.var_A265["fx_filename"].size;var_04++)
				{
					var_05 = var_03.var_A265["fx_filename"][var_04];
					var_06 = var_03.var_A265["fx_tag"][var_04];
					var_07 = var_03.var_A265["spawn_immediate"][var_04];
					if(isdefined(var_05) && isdefined(var_07))
					{
						for(var_08 = 0;var_08 < var_05.size;var_08++)
						{
							if(var_07[var_08] == 1)
							{
								var_09 = var_03.var_A265["state_change_kill"][var_04][var_08];
								var_0A = level.var_75[self.var_2E25].var_6E9F[var_01][var_02].var_A265["fx"][var_04][var_08];
								var_0B = var_06[var_08];
								var_0C = var_05[var_08];
								var_0D = level.var_75[self.var_2E25].var_6E9F[var_01][var_02].var_A265["fx_useTagAngles"][var_04][var_08];
								thread func_2DFE(var_00,var_0A,var_0B,var_01,var_0D,var_09);
							}
						}
					}
				}
			}
		}
	}
}

//Function Number: 109
func_2E00(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_00["fx"]))
	{
		return undefined;
	}

	if(!isdefined(param_04))
	{
		param_04 = randomint(param_00["fx_filename"].size);
	}

	if(!isdefined(param_00["fx"][param_04]))
	{
		param_04 = randomint(param_00["fx_filename"].size);
	}

	var_05 = param_00["fx_filename"][param_04].size;
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		if(!func_5641(param_02,param_00,var_06,param_04))
		{
			continue;
		}

		if(param_00["spawn_immediate"][param_04][var_06] == 1)
		{
			continue;
		}

		var_07 = param_00["fx"][param_04][var_06];
		var_08 = param_00["state_change_kill"][param_04][var_06];
		if(isdefined(param_00["fx_tag"][param_04][var_06]))
		{
			var_09 = param_00["fx_tag"][param_04][var_06];
			self notify("FX_State_Change" + param_03);
			if(param_00["fx_useTagAngles"][param_04][var_06])
			{
				thread func_2DFE(param_01,var_07,var_09,param_03,1,var_08);
			}
			else
			{
				thread func_2DFE(param_01,var_07,var_09,param_03,0,var_08);
			}

			continue;
		}

		thread func_2DFE(param_01,var_07,undefined,param_03,0,var_08);
	}

	return param_04;
}

//Function Number: 110
func_2DE4(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_3928))
	{
		return undefined;
	}

	if(!isdefined(param_00["animation"]))
	{
		return undefined;
	}

	if(isdefined(self.var_66E6))
	{
		return undefined;
	}

	if(isdefined(param_00["randomly_flip"]) && !isdefined(self.var_8249))
	{
		if(common_scripts\utility::func_24A6())
		{
			self.var_1D = self.var_1D + (0,180,0);
		}
	}

	if(isdefined(param_00["spotlight_tag"]))
	{
		thread func_2E1B(param_00,param_01,param_02,param_03);
		wait 0.05;
	}

	var_04 = common_scripts\utility::func_7A33(param_00["animation"]);
	var_05 = var_04["anim"];
	var_06 = var_04["animTree"];
	var_07 = var_04["groupNum"];
	var_08 = var_04["mpAnim"];
	var_09 = var_04["maxStartDelay"];
	var_0A = var_04["animRateMin"];
	var_0B = var_04["animRateMax"];
	if(!isdefined(var_0A))
	{
		var_0A = 1;
	}

	if(!isdefined(var_0B))
	{
		var_0B = 1;
	}

	if(var_0A == var_0B)
	{
		var_0C = var_0A;
	}
	else
	{
		var_0C = randomfloatrange(var_0B,var_0C);
	}

	var_0D = var_04["vehicle_exclude_anim"];
	if(self.var_3B == "script_vehicle" && var_0D)
	{
		return undefined;
	}

	param_01 common_scripts\utility::func_83BE("useanimtree",var_06);
	var_0E = var_04["animType"];
	if(!isdefined(self.var_ED4))
	{
		self.var_ED4 = [];
	}

	self.var_ED4[self.var_ED4.size] = var_05;
	if(isdefined(self.var_3949))
	{
		func_23A2(param_01);
	}

	if(isdefined(var_09) && var_09 > 0)
	{
		wait(randomfloat(var_09));
	}

	if(!common_scripts\utility::func_57D7())
	{
		if(isdefined(var_08))
		{
			common_scripts\utility::func_83BE("scriptModelPlayAnim",var_08);
		}

		return var_07;
	}

	if(var_0E == "setanim")
	{
		param_01 common_scripts\utility::func_83BE("setanim",var_05,1,1,var_0C);
		return var_07;
	}

	if(var_0E == "setanimknob")
	{
		param_01 common_scripts\utility::func_83BE("setanimknob",var_05,1,0,var_0C);
		return var_07;
	}

	return undefined;
}

//Function Number: 111
func_23A2(param_00)
{
	if(isdefined(self.var_ED4))
	{
		foreach(var_02 in self.var_ED4)
		{
			if(common_scripts\utility::func_57D7())
			{
				param_00 common_scripts\utility::func_83BE("clearanim",var_02,0);
				continue;
			}

			param_00 common_scripts\utility::func_83BE("scriptModelClearAnim");
		}
	}
}

//Function Number: 112
func_51B4()
{
	level.var_2DC8 = 0;
	level.var_2DC9 = 0.5;
	if(common_scripts\utility::func_57D7())
	{
		level.var_607E = 20;
		return;
	}

	level.var_607E = 2;
}

//Function Number: 113
func_0976()
{
	level.var_2DC8++;
	wait(level.var_2DC9);
	level.var_2DC8--;
}

//Function Number: 114
func_414B()
{
	return level.var_2DC8;
}

//Function Number: 115
func_420B()
{
	return level.var_607E;
}

//Function Number: 116
func_51B5()
{
	level.var_2E24 = [];
}

//Function Number: 117
func_091D(param_00,param_01,param_02)
{
	var_03 = self getentitynumber();
	if(!isdefined(level.var_2E24[var_03]))
	{
		level.var_2E24[var_03] = spawnstruct();
		level.var_2E24[var_03].var_37D8 = var_03;
		level.var_2E24[var_03].var_2DE2 = param_00;
		level.var_2E24[var_03].var_9AB1 = 0;
		level.var_2E24[var_03].var_6635 = 9999999;
		level.var_2E24[var_03].var_3F6B = 0;
	}

	level.var_2E24[var_03].var_3F6B = level.var_2E24[var_03].var_3F6B + param_01.var_A265["fxcost"];
	level.var_2E24[var_03].var_9AB1 = level.var_2E24[var_03].var_9AB1 + param_02;
	if(param_01.var_A265["distance"] < level.var_2E24[var_03].var_6635)
	{
		level.var_2E24[var_03].var_6635 = param_01.var_A265["distance"];
	}

	thread func_49CE();
}

//Function Number: 118
func_49CE()
{
	level notify("handle_destructible_frame_queue");
	level endon("handle_destructible_frame_queue");
	wait 0.05;
	var_00 = level.var_2E24;
	level.var_2E24 = [];
	var_01 = func_8F1F(var_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(func_414B() < func_420B())
		{
			if(var_01[var_02].var_3F6B)
			{
				thread func_0976();
			}

			var_01[var_02].var_2DE2 notify("queue_processed",1);
			continue;
		}

		var_01[var_02].var_2DE2 notify("queue_processed",0);
	}
}

//Function Number: 119
func_8F1F(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_01.size] = var_03;
	}

	for(var_05 = 1;var_05 < var_01.size;var_05++)
	{
		var_06 = var_01[var_05];
		for(var_07 = var_05 - 1;var_07 >= 0 && func_40D5(var_06,var_01[var_07]) == var_06;var_07--)
		{
			var_01[var_07 + 1] = var_01[var_07];
		}

		var_01[var_07 + 1] = var_06;
	}

	return var_01;
}

//Function Number: 120
func_40D5(param_00,param_01)
{
	if(param_00.var_9AB1 > param_01.var_9AB1)
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 121
func_4283(param_00,param_01)
{
	var_02 = 0;
	if(!isdefined(level.var_75[self.var_2E25].var_6E9F[param_00][param_01]))
	{
		return var_02;
	}

	var_03 = level.var_75[self.var_2E25].var_6E9F[param_00][param_01].var_A265;
	if(isdefined(var_03["fx"]))
	{
		foreach(var_05 in var_03["fx_cost"])
		{
			foreach(var_07 in var_05)
			{
				var_02 = var_02 + var_07;
			}
		}
	}

	return var_02;
}

//Function Number: 122
func_52AF(param_00)
{
	if(!common_scripts\utility::func_3C83("FLAG_DOT_init"))
	{
		common_scripts\utility::func_3C87("FLAG_DOT_init");
		common_scripts\utility::func_3C8F("FLAG_DOT_init");
	}

	param_00 = tolower(param_00);
	switch(param_00)
	{
		case "poison":
			if(!common_scripts\utility::func_3C83("FLAG_DOT_poison_init"))
			{
				common_scripts\utility::func_3C87("FLAG_DOT_poison_init");
				common_scripts\utility::func_3C8F("FLAG_DOT_poison_init");
			}
			break;

		default:
			break;
	}
}

//Function Number: 123
func_27E2()
{
	var_00 = spawnstruct();
	var_00.var_99C1 = [];
	return var_00;
}

//Function Number: 124
func_27E3(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.var_1B9 = "trigger_radius";
	var_04.var_116 = param_00;
	var_04.var_187 = param_01;
	var_04.var_14F = param_02;
	var_04.var_6220 = param_02;
	var_04.var_6098 = param_02;
	var_04.var_BD = param_03;
	var_04.var_99C1 = [];
	return var_04;
}

//Function Number: 125
func_866B(param_00)
{
	self.var_116 = param_00;
}

//Function Number: 126
func_866C(param_00,param_01)
{
	if(isdefined(self.var_3A) && self.var_3A != "trigger_radius")
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	self.var_6220 = param_00;
	self.var_6098 = param_01;
}

//Function Number: 127
func_8669(param_00,param_01)
{
	if(isdefined(self.var_3A) && issubstr(self.var_3A,"trigger"))
	{
	}
}

//Function Number: 128
func_866A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(param_00))
	{
	}
	else
	{
		param_00 = 0;
	}

	param_06 = tolower(param_06);
	param_07 = tolower(param_07);
	var_08 = self.var_99C1.size;
	self.var_99C1[var_08] = spawnstruct();
	self.var_99C1[var_08].var_35FE = 0;
	self.var_99C1[var_08].var_2CAC = param_00;
	self.var_99C1[var_08].var_D9 = param_01;
	self.var_99C1[var_08].var_3511 = param_02;
	self.var_99C1[var_08].var_61BD = param_03;
	self.var_99C1[var_08].var_607B = param_04;
	switch(param_05)
	{
		case 1:
		case 0:
			break;

		default:
			break;
	}

	self.var_99C1[var_08].var_93 = param_05;
	self.var_99C1[var_08].var_9309 = 0;
	switch(param_06)
	{
		case "normal":
			break;

		case "poison":
			switch(param_07)
			{
				case "player":
					self.var_99C1[var_08].var_1B9 = param_06;
					self.var_99C1[var_08].var_A32 = param_07;
					self.var_99C1[var_08].var_6B05 = ::func_6B04;
					self.var_99C1[var_08].var_6B33 = ::func_6B32;
					self.var_99C1[var_08].var_6AE6 = ::func_6AE5;
					break;
	
				default:
					break;
			}
			break;

		default:
			break;
	}
}

//Function Number: 129
func_1D45(param_00,param_01)
{
	param_01 = tolower(param_01);
	var_02 = self.var_99C1.size;
	self.var_99C1[var_02] = spawnstruct();
	self.var_99C1[var_02].var_3511 = param_00;
	self.var_99C1[var_02].var_2CAC = 0;
	self.var_99C1[var_02].var_6B05 = ::func_6B00;
	self.var_99C1[var_02].var_6B33 = ::func_6B30;
	self.var_99C1[var_02].var_6AE6 = ::func_6AE4;
	switch(param_01)
	{
		case "player":
			self.var_99C1[var_02].var_A32 = param_01;
			break;

		default:
			break;
	}
}

//Function Number: 130
func_1D46(param_00)
{
	var_01 = self.var_99C1.size - 1;
	if(!isdefined(self.var_99C1[var_01].var_932C))
	{
		self.var_99C1[var_01].var_932C = [];
	}

	var_02 = self.var_99C1[var_01].var_932C.size;
	self.var_99C1[var_01].var_932C = [];
	self.var_99C1[var_01].var_932C["vars"] = [];
	self.var_99C1[var_01].var_932C["vars"]["count"] = param_00;
}

//Function Number: 131
func_1D44(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self.var_99C1.size - 1;
	if(!isdefined(self.var_99C1[var_06].var_932C["actions"]))
	{
		self.var_99C1[var_06].var_932C["actions"] = [];
	}

	var_07 = self.var_99C1[var_06].var_932C["actions"].size;
	self.var_99C1[var_06].var_932C["actions"][var_07] = [];
	self.var_99C1[var_06].var_932C["actions"][var_07]["vars"] = [param_00,param_01,param_02,param_03,param_04,param_05];
	self.var_99C1[var_06].var_932C["actions"][var_07]["func"] = ::func_310C;
}

//Function Number: 132
func_1D47(param_00)
{
	var_01 = self.var_99C1.size - 1;
	if(!isdefined(self.var_99C1[var_01].var_932C["actions"]))
	{
		self.var_99C1[var_01].var_932C["actions"] = [];
	}

	var_02 = self.var_99C1[var_01].var_932C["actions"].size;
	self.var_99C1[var_01].var_932C["actions"][var_02] = [];
	self.var_99C1[var_01].var_932C["actions"][var_02]["vars"] = [param_00];
	self.var_99C1[var_01].var_932C["actions"][var_02]["func"] = ::func_310D;
}

//Function Number: 133
func_6B00(param_00,param_01)
{
	var_02 = param_01 getentitynumber();
	param_01 endon("death");
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02);
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("LISTEN_exit_dot_" + var_02);
	var_02 = undefined;
	var_03 = param_01.var_99C1[param_00].var_932C;
	if(!isdefined(var_03) || !isdefined(var_03["vars"]) || !isdefined(var_03["vars"]["count"]) || !isdefined(var_03["actions"]))
	{
		return;
	}

	var_04 = var_03["vars"]["count"];
	var_05 = var_03["actions"];
	var_03 = undefined;
	for(var_06 = 1;var_06 <= var_04 || var_04 == 0;var_06--)
	{
		foreach(var_08 in var_05)
		{
			var_09 = var_08["vars"];
			var_0A = var_08["func"];
			self [[ var_0A ]](param_00,param_01,var_09);
		}
	}
}

//Function Number: 134
func_6B30(param_00,param_01)
{
	var_02 = param_01 getentitynumber();
	var_03 = self getentitynumber();
	param_01 notify("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
}

//Function Number: 135
func_6AE4(param_00,param_01)
{
}

//Function Number: 136
func_310C(param_00,param_01,param_02)
{
	var_03 = param_02[0];
	var_04 = param_02[1];
	var_05 = param_02[2];
	var_06 = param_02[3];
	var_07 = param_02[4];
	var_08 = param_02[5];
	self thread [[ level.var_1E78 ]](param_01,param_01,var_04,var_06,var_07,var_08,param_01.var_116,(0,0,0) - param_01.var_116,"none",0);
}

//Function Number: 137
func_310D(param_00,param_01,param_02)
{
	var_03 = param_01 getentitynumber();
	var_04 = self getentitynumber();
	param_01 endon("death");
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_03);
	param_01 notify("LISTEN_kill_tick_" + param_00 + "_" + var_03 + "_" + var_04);
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("LISTEN_exit_dot_" + var_03);
	var_03 = undefined;
	var_04 = undefined;
	wait(param_02[0]);
}

//Function Number: 138
func_92C7(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_04 = undefined;
		switch(var_03.var_1B9)
		{
			case "trigger_radius":
				var_04 = spawn("trigger_radius",var_03.var_116,var_03.var_187,var_03.var_14F,var_03.var_BD);
				var_04.var_6220 = var_03.var_6220;
				var_04.var_6098 = var_03.var_6098;
				var_04.var_99C1 = var_03.var_99C1;
				var_01[var_01.size] = var_04;
				break;

			default:
				break;
		}

		if(isdefined(var_03.var_6E74))
		{
			var_04 linkto(var_03.var_6E74);
			var_03.var_6E74.var_32B1 = var_04;
		}

		var_05 = var_04.var_99C1;
		foreach(var_07 in var_05)
		{
			var_07.var_9309 = gettime();
		}

		foreach(var_07 in var_05)
		{
			if(!var_07.var_2CAC)
			{
				var_07.var_35FE = 1;
			}
		}

		foreach(var_07 in var_05)
		{
			if(issubstr(var_07.var_A32,"player"))
			{
				var_04.var_6B6B = 1;
				break;
			}
		}
	}

	foreach(var_04 in var_01)
	{
		var_04.var_32B2 = [];
		foreach(var_10 in var_01)
		{
			if(var_04 == var_10)
			{
				continue;
			}

			var_04.var_32B2[var_04.var_32B2.size] = var_10;
		}
	}

	foreach(var_04 in var_01)
	{
		if(var_04.var_6B6B)
		{
			var_04 thread func_92C8();
		}
	}

	foreach(var_04 in var_01)
	{
		var_04 thread func_6381();
	}
}

//Function Number: 139
func_92C8()
{
	thread func_9DC3(::func_6B01,::func_6B31);
}

//Function Number: 140
func_6381()
{
	var_00 = gettime();
	while(isdefined(self))
	{
		foreach(var_04, var_02 in self.var_99C1)
		{
			if(isdefined(var_02) && gettime() - var_00 >= var_02.var_3511 * 1000)
			{
				var_03 = self getentitynumber();
				self notify("LISTEN_kill_tick_" + var_04 + "_" + var_03);
				self.var_99C1[var_04] = undefined;
			}
		}

		if(!self.var_99C1.size)
		{
			break;
		}

		wait 0.05;
	}

	if(isdefined(self))
	{
		foreach(var_02 in self.var_99C1)
		{
			self [[ var_02.var_6AE6 ]]();
		}

		self notify("death");
		self delete();
	}
}

//Function Number: 141
func_6B01(param_00)
{
	var_01 = param_00 getentitynumber();
	self notify("LISTEN_enter_dot_" + var_01);
	foreach(var_04, var_03 in param_00.var_99C1)
	{
		if(!var_03.var_35FE)
		{
			thread func_3144(var_04,param_00,var_03.var_2CAC,var_03.var_6B05);
		}
	}

	foreach(var_04, var_03 in param_00.var_99C1)
	{
		if(var_03.var_35FE && var_03.var_A32 == "player")
		{
			self thread [[ var_03.var_6B05 ]](var_04,param_00);
		}
	}
}

//Function Number: 142
func_6B31(param_00)
{
	var_01 = param_00 getentitynumber();
	self notify("LISTEN_exit_dot_" + var_01);
	foreach(var_04, var_03 in param_00.var_99C1)
	{
		if(var_03.var_35FE && var_03.var_A32 == "player")
		{
			self thread [[ var_03.var_6B33 ]](var_04,param_00);
		}
	}
}

//Function Number: 143
func_3144(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 getentitynumber();
	var_05 = self getentitynumber();
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_04 + "_" + var_05);
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self notify("LISTEN_exit_dot_" + var_04);
	var_04 = undefined;
	var_05 = undefined;
	wait(param_02);
	self thread [[ param_03 ]](param_00,param_01);
}

//Function Number: 144
func_6B04(param_00,param_01)
{
	var_02 = param_01 getentitynumber();
	var_03 = self getentitynumber();
	param_01 endon("death");
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02);
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("LISTEN_exit_dot_" + var_02);
	if(!isdefined(self.var_6B02))
	{
		self.var_6B02 = [];
	}

	if(!isdefined(self.var_6B02[param_00]))
	{
		self.var_6B02[param_00] = [];
	}

	self.var_6B02[param_00][var_02] = 0;
	var_04 = common_scripts\utility::func_98E7(common_scripts\utility::func_57D7(),1.5,1);
	while(isdefined(param_01) && isdefined(param_01.var_99C1[param_00]))
	{
		self.var_6B02[param_00][var_02]++;
		switch(self.var_6B02[param_00][var_02])
		{
			case 1:
				self viewkick(1,self.var_116);
				break;

			case 3:
				self shellshock("mp_radiation_low",4);
				func_3149(param_01,var_04 * 2);
				break;

			case 4:
				self shellshock("mp_radiation_med",5);
				thread func_3148(param_00,param_01);
				func_3149(param_01,var_04 * 2);
				break;

			case 6:
				self shellshock("mp_radiation_high",5);
				func_3149(param_01,var_04 * 2);
				break;

			case 8:
				self shellshock("mp_radiation_high",5);
				func_3149(param_01,var_04 * 500);
				break;
		}

		wait(param_01.var_99C1[param_00].var_D9);
	}
}

//Function Number: 145
func_6B32(param_00,param_01)
{
	var_02 = param_01 getentitynumber();
	var_03 = self getentitynumber();
	var_04 = self.var_6B03;
	if(isdefined(var_04))
	{
		foreach(var_07, var_06 in var_04)
		{
			if(isdefined(var_04[var_07]) && isdefined(var_04[var_07][var_02]))
			{
				var_04[var_07][var_02] thread func_3146(0.1,0);
			}
		}
	}

	param_01 notify("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
}

//Function Number: 146
func_6AE5()
{
	var_00 = self getentitynumber();
	foreach(var_02 in level.var_744A)
	{
		var_03 = var_02.var_6B03;
		if(isdefined(var_03))
		{
			foreach(var_06, var_05 in var_03)
			{
				if(isdefined(var_03[var_06]) && isdefined(var_03[var_06][var_00]))
				{
					var_03[var_06][var_00] thread func_3147();
				}
			}
		}
	}
}

//Function Number: 147
func_3149(param_00,param_01)
{
	if(common_scripts\utility::func_57D7())
	{
		return;
	}

	self thread [[ level.var_1E78 ]](param_00,param_00,param_01,0,"MOD_SUICIDE","claymore_mp",param_00.var_116,(0,0,0) - param_00.var_116,"none",0);
}

//Function Number: 148
func_3148(param_00,param_01)
{
	var_02 = param_01 getentitynumber();
	var_03 = self getentitynumber();
	param_01 endon("death");
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02);
	param_01 endon("LISTEN_kill_tick_" + param_00 + "_" + var_02 + "_" + var_03);
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("LISTEN_exit_dot_" + var_02);
	if(!isdefined(self.var_6B03))
	{
		self.var_6B03 = [];
	}

	if(!isdefined(self.var_6B03[param_00]))
	{
		self.var_6B03[param_00] = [];
	}

	if(!isdefined(self.var_6B03[param_00][var_02]))
	{
		var_04 = newclienthudelem(self);
		var_04.maxsightdistsqrd = 0;
		var_04.var_1D7 = 0;
		var_04.accuracy = "left";
		var_04.var_11 = "top";
		var_04.var_C6 = "fullscreen";
		var_04.var_1CA = "fullscreen";
		var_04.var_18 = 0;
		var_04 setshader("black",640,480);
		self.var_6B03[param_00][var_02] = var_04;
	}

	var_04 = self.var_6B03[param_00][var_02];
	var_05 = 1;
	var_06 = 2;
	var_07 = 0.25;
	var_08 = 1;
	var_09 = 5;
	var_0A = 100;
	var_0B = 0;
	for(;;)
	{
		while(self.var_6B02[param_00][var_02] > 1)
		{
			var_0C = var_0A - var_09;
			var_0B = self.var_6B02[param_00][var_02] - var_09 / var_0C;
			if(var_0B < 0)
			{
				var_0B = 0;
			}
			else if(var_0B > 1)
			{
				var_0B = 1;
			}

			var_0D = var_06 - var_05;
			var_0E = var_05 + var_0D * 1 - var_0B;
			var_0F = var_08 - var_07;
			var_10 = var_07 + var_0F * var_0B;
			var_11 = var_0B * 0.5;
			if(var_0B == 1)
			{
				break;
			}

			var_12 = var_0E / 2;
			var_04 func_3145(var_12,var_10);
			var_04 func_3146(var_12,var_11);
			wait(var_0B * 0.5);
		}

		if(var_0B == 1)
		{
			break;
		}

		if(var_04.var_18 != 0)
		{
			var_04 func_3146(1,0);
		}

		wait 0.05;
	}

	var_04 func_3145(2,0);
}

//Function Number: 149
func_3145(param_00,param_01)
{
	self fadeovertime(param_00);
	self.var_18 = param_01;
	param_01 = undefined;
	wait(param_00);
}

//Function Number: 150
func_3146(param_00,param_01)
{
	self fadeovertime(param_00);
	self.var_18 = param_01;
	param_01 = undefined;
	wait(param_00);
}

//Function Number: 151
func_3147(param_00,param_01)
{
	self fadeovertime(param_00);
	self.var_18 = param_01;
	param_01 = undefined;
	wait(param_00);
	self destroy();
}

//Function Number: 152
func_9DC3(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self.var_37D8 = self getentitynumber();
	for(;;)
	{
		self waittill("trigger",var_02);
		if(!isplayer(var_02) && !isdefined(var_02.var_3BAA))
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		if(!isdefined(var_02.var_9AC5[self.var_37D8]))
		{
			var_02 thread func_7477(self,param_00,param_01);
		}
	}
}

//Function Number: 153
func_7477(param_00,param_01,param_02)
{
	param_00 endon("death");
	if(!isplayer(self))
	{
		self endon("death");
	}

	if(!common_scripts\utility::func_57D7())
	{
		var_03 = self.var_48CA;
	}
	else
	{
		var_03 = "player" + gettime();
	}

	param_00.var_9AC3[var_03] = self;
	if(isdefined(param_00.var_64DD))
	{
		self.var_64DE++;
	}

	param_00 notify("trigger_enter",self);
	self notify("trigger_enter",param_00);
	var_04 = 1;
	foreach(var_06 in param_00.var_32B2)
	{
		foreach(var_08 in self.var_9AC5)
		{
			if(var_06 == var_08)
			{
				var_04 = 0;
			}
		}
	}

	if(var_04 && isdefined(param_01))
	{
		self thread [[ param_01 ]](param_00);
	}

	self.var_9AC5[param_00.var_37D8] = param_00;
	while(isalive(self) && common_scripts\utility::func_57D7() || !level.var_3F9D)
	{
		var_0B = 1;
		if(self istouching(param_00))
		{
			wait 0.05;
			continue;
		}

		if(!param_00.var_32B2.size)
		{
			var_0B = 0;
		}

		foreach(var_06 in param_00.var_32B2)
		{
			if(self istouching(var_06))
			{
				wait 0.05;
				break;
			}
			else
			{
				var_0B = 0;
			}
		}

		if(!var_0B)
		{
			break;
		}
	}

	if(isdefined(self))
	{
		self.var_9AC5[param_00.var_37D8] = undefined;
		if(isdefined(param_00.var_64DD))
		{
			self.var_64DE--;
		}

		self notify("trigger_leave",param_00);
		if(var_04 && isdefined(param_02))
		{
			self thread [[ param_02 ]](param_00);
		}
	}

	if(!common_scripts\utility::func_57D7() && level.var_3F9D)
	{
		return;
	}

	param_00.var_9AC3[var_03] = undefined;
	param_00 notify("trigger_leave",self);
	if(!func_0F13(param_00))
	{
		param_00 notify("trigger_empty");
	}
}

//Function Number: 154
func_0F13(param_00)
{
	return param_00.var_9AC3.size;
}

//Function Number: 155
func_42C9(param_00)
{
	return level.var_5FD[param_00];
}

//Function Number: 156
func_42CA(param_00)
{
	return level.var_5FE[param_00];
}

//Function Number: 157
func_2E23()
{
	if(!isdefined(level.var_721C))
	{
		return;
	}

	if(!isdefined(self.var_815E))
	{
		self.var_815E = 20000;
	}

	while(isdefined(self))
	{
		if(isdefined(self.var_2E10))
		{
			var_00 = 0;
			for(var_01 = 1;var_01 < self.var_2E10.size;var_01++)
			{
				if(self.var_2E10[var_01].var_A265["currentState"] == 1)
				{
					var_00++;
				}
			}

			if(var_00 == self.var_2E10.size - 1)
			{
				break;
			}
		}

		var_02 = distancesquared(level.var_721C.var_116,self.var_116);
		if(var_02 > self.var_815E * self.var_815E)
		{
			self setcandamage(0);
			continue;
		}

		self setcandamage(1);
		wait 0.05;
	}
}