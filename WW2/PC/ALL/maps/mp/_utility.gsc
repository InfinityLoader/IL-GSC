/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_utility.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 471
 * Decompile Time: 7551 ms
 * Timestamp: 10/27/2023 3:22:14 AM
*******************************************************************/

//Function Number: 1
func_3941()
{
	if(isdefined(self.var_161))
	{
		wait(self.var_161);
	}

	self method_8617(level.var_80D2[self.var_828A]);
}

//Function Number: 2
func_05D4(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("location_selection_complete");
	self endon("stop_location_selection");
	if(isdefined(level.var_6465))
	{
		self setscriptmotionblurparams(0,level.var_6465["cameraRotationInfluence"],level.var_6465["cameraTranslationInfluence"]);
	}

	thread func_36E6("cancel_location");
	thread func_36E6("death");
	thread func_36E6("disconnect");
	thread func_36E6("used");
	thread func_36E6("weapon_change");
	thread func_36E8();
	thread func_36E7();
	thread func_36E5();
	thread func_A6AA();
	var_06 = 1;
	if(isdefined(param_05) && param_05)
	{
		var_06 = 2;
	}

	var_07 = int(tablelookup("mp/killstreakTable.csv",1,param_00,0));
	self setclientomnvar("ui_map_location_selector_streak_index",var_07);
	self setclientomnvar("ui_map_location_selector",var_06);
	if(param_02)
	{
		var_08 = 1;
	}
	else
	{
		var_08 = 0;
	}

	switch(param_00)
	{
		case "firebomb":
			var_08 = 2;
			break;
	}

	self setclientomnvar("ui_map_location_selector_directional_type",var_08);
	if(isdefined(param_04))
	{
		wait(param_04);
	}

	self method_8320(param_01,param_02,param_03);
	self.var_83AF = 1;
	self luinotifyevent(&"streak_targeting_started",0);
	self setblurforplayer(10.3,0.3);
}

//Function Number: 3
func_0618(param_00)
{
	if(!param_00)
	{
		self setclientomnvar("ui_map_location_selector",0);
		self setclientomnvar("ui_map_location_selector_directional_type",0);
		self setclientomnvar("ui_map_location_selector_streak_index",0);
		self setclientomnvar("ui_map_location_num_planes",0);
		self setclientomnvar("ui_map_location_fighter_strike",0);
		self setblurforplayer(0,0.3);
		self method_8321();
		self.var_83AF = undefined;
		if(isdefined(level.var_6465))
		{
			self setscriptmotionblurparams(level.var_6465["velocityscaler"],level.var_6465["cameraRotationInfluence"],level.var_6465["cameraTranslationInfluence"]);
		}
	}
}

//Function Number: 4
func_A6AA()
{
	self endon("stop_location_selection");
	self waittill("location_selection_complete");
	func_0618(0);
}

//Function Number: 5
func_940B(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "generic";
	}

	func_0618(param_00);
	self notify("stop_location_selection",param_01);
}

//Function Number: 6
func_36E7()
{
	self endon("location_selection_complete");
	self endon("stop_location_selection");
	for(;;)
	{
		level waittill("emp_update");
		if(!func_56D7())
		{
			continue;
		}

		func_940B(0,"emp");
	}
}

//Function Number: 7
func_36E6(param_00,param_01)
{
	self endon("location_selection_complete");
	self endon("stop_location_selection");
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	while(param_01 > 0)
	{
		self waittill(param_00);
		param_01--;
	}

	func_940B(param_00 == "disconnect",param_00);
}

//Function Number: 8
func_36E8()
{
	self endon("location_selection_complete");
	self endon("stop_location_selection");
	level waittill("game_ended");
	func_940B(0,"end_game");
}

//Function Number: 9
func_36E5()
{
	self endon("location_selection_complete");
	self endon("stop_location_selection");
	level waittill("host_migration_begin");
	func_940B(0,"hostmigrate");
}

//Function Number: 10
func_5679(param_00)
{
	var_01 = tablelookup("mp/attachmenttable.csv",3,param_00,0);
	if(isdefined(var_01) && var_01 != "")
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
func_4429(param_00)
{
	var_01 = tablelookup("mp/attachmenttable.csv",3,param_00,1);
	return var_01;
}

//Function Number: 12
isproductionlevelactive(param_00)
{
	var_01 = getdvarint("6024",23);
	return var_01 >= param_00;
}

//Function Number: 13
productionlevelindextostring(param_00)
{
	switch(param_00)
	{
		case 0:
			return "NOTSET";

		case 1:
			return "GOLD";

		case 2:
			return "TU1";

		case 3:
			return "TU2";

		case 4:
			return "TU3";

		case 5:
			return "CP";

		case 6:
			return "MTX1";

		case 7:
			return "MTX2";

		case 8:
			return "DLC1";

		case 9:
			return "MTX3";

		case 10:
			return "MTX3_5";

		case 11:
			return "MTX4";

		case 12:
			return "DLC2";

		case 13:
			return "MTX5";

		case 14:
			return "MTX6";

		case 15:
			return "DLC3";

		case 16:
			return "MTX7";

		case 17:
			return "MTX8";

		case 18:
			return "DLC4";

		case 19:
			return "MTX9";

		case 20:
			return "MTX10";

		case 21:
			return "MTX11";

		case 22:
			return "MTX12";

		case 23:
			return "ALL";

		case 24:
			return "NEVER";
	}
}

//Function Number: 14
productionlevelstringtoindex(param_00)
{
	switch(tolower(param_00))
	{
		case "notset":
		case "":
			return 0;

		case "gold":
			return 1;

		case "tu1":
			return 2;

		case "tu2":
			return 3;

		case "tu3":
			return 4;

		case "cp":
			return 5;

		case "mtx1":
			return 6;

		case "mtx2":
			return 7;

		case "dlc1":
			return 8;

		case "mtx3":
			return 9;

		case "mtx3_5":
			return 10;

		case "mtx4":
			return 11;

		case "dlc2":
			return 12;

		case "mtx5":
			return 13;

		case "mtx6":
			return 14;

		case "dlc3":
			return 15;

		case "mtx7":
			return 16;

		case "mtx8":
			return 17;

		case "dlc4":
			return 18;

		case "mtx9":
			return 19;

		case "mtx10":
			return 20;

		case "mtx11":
			return 21;

		case "mtx12":
			return 22;

		case "all":
			return 23;

		case "never":
			return 24;
	}
}

//Function Number: 15
productionlevelstringtouidvarbool(param_00)
{
	switch(tolower(param_00))
	{
		case "notset":
		case "":
			return 1;

		case "gold":
			return 1;

		case "tu1":
			return 1;

		case "tu2":
			return 1;

		case "tu3":
			return 1;

		case "cp":
			return 1;

		case "mtx1":
			return getdvarint("5955") == 1;

		case "mtx2":
			return getdvarint("5954") == 0;

		case "dlc1":
			return getdvarint("5953") == 0;

		case "mtx3":
			return getdvarint("mtx3_killswitch") == 0;

		case "mtx3_5":
			return getdvarint("mtx3_5_killswitch") == 0;

		case "mtx4":
			return getdvarint("mtx4_killswitch") == 0;

		case "dlc2":
			return getdvarint("dlc2_killswitch") == 0;

		case "mtx5":
			return getdvarint("mtx5_killswitch") == 0;

		case "mtx6":
			return getdvarint("mtx6_killswitch") == 0;

		case "dlc3":
			return getdvarint("dlc3_killswitch") == 0;

		case "mtx7":
			return getdvarint("mtx7_killswitch") == 0;

		case "mtx8":
			return getdvarint("mtx8_killswitch") == 0;

		case "dlc4":
			return getdvarint("dlc4_killswitch") == 0;

		case "mtx9":
			return getdvarint("mtx9_killswitch") == 0;

		case "mtx10":
			return getdvarint("mtx10_killswitch") == 0;

		case "mtx11":
			return getdvarint("mtx11_killswitch") == 0;

		case "mtx12":
			return getdvarint("mtx12_killswitch") == 0;

		case "all":
			return 0;

		case "never":
			return 0;
	}
}

//Function Number: 16
func_2CED(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	thread func_2CEF(param_01,param_00,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 17
func_2CEF(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	wait(param_01);
	if(!isdefined(param_02))
	{
		thread [[ param_00 ]]();
		return;
	}

	if(!isdefined(param_03))
	{
		thread [[ param_00 ]](param_02);
		return;
	}

	if(!isdefined(param_04))
	{
		thread [[ param_00 ]](param_02,param_03);
		return;
	}

	if(!isdefined(param_05))
	{
		thread [[ param_00 ]](param_02,param_03,param_04);
		return;
	}

	if(!isdefined(param_06))
	{
		thread [[ param_00 ]](param_02,param_03,param_04,param_05);
		return;
	}

	thread [[ param_00 ]](param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 18
func_4617()
{
	var_00 = self.var_116 + (0,0,10);
	var_01 = 11;
	var_02 = anglestoforward(self.var_1D);
	var_02 = var_02 * var_01;
	var_03[0] = var_00 + var_02;
	var_03[1] = var_00;
	var_04 = bullettrace(var_03[0],var_03[0] + (0,0,-18),0,undefined);
	if(var_04["fraction"] < 1)
	{
		var_05 = spawnstruct();
		var_05.var_116 = var_04["position"];
		var_05.var_1D = func_6C3A(var_04["normal"]);
		return var_05;
	}

	var_05 = bullettrace(var_04[1],var_04[1] + (0,0,-18),0,undefined);
	if(var_05["fraction"] < 1)
	{
		var_05 = spawnstruct();
		var_05.var_116 = var_04["position"];
		var_05.var_1D = func_6C3A(var_04["normal"]);
		return var_05;
	}

	var_04[2] = var_01 + (16,16,0);
	var_04[3] = var_01 + (16,-16,0);
	var_04[4] = var_01 + (-16,-16,0);
	var_04[5] = var_01 + (-16,16,0);
	var_06 = undefined;
	var_07 = undefined;
	for(var_08 = 0;var_08 < var_04.size;var_08++)
	{
		var_05 = bullettrace(var_04[var_08],var_04[var_08] + (0,0,-1000),0,undefined);
		if(!isdefined(var_06) || var_05["fraction"] < var_06)
		{
			var_06 = var_05["fraction"];
			var_07 = var_05["position"];
		}
	}

	if(var_06 == 1)
	{
		var_07 = self.var_116;
	}

	var_05 = spawnstruct();
	var_08.var_116 = var_06;
	var_08.var_1D = func_6C3A(var_04["normal"]);
	return var_08;
}

//Function Number: 19
func_6C3A(param_00)
{
	var_01 = (param_00[0],param_00[1],0);
	var_02 = length(var_01);
	if(!var_02)
	{
		return (0,0,0);
	}

	var_03 = vectornormalize(var_01);
	var_04 = param_00[2] * -1;
	var_05 = (var_03[0] * var_04,var_03[1] * var_04,var_02);
	var_06 = vectortoangles(var_05);
	return var_06;
}

//Function Number: 20
func_2D46(param_00)
{
	var_01 = getentarray(param_00,"classname");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] delete();
	}
}

//Function Number: 21
func_74D9(param_00,param_01,param_02)
{
	if(level.var_910F)
	{
		if(isdefined(level.var_744A[0]))
		{
			level.var_744A[0] method_8615(param_00);
			return;
		}

		return;
	}

	if(isdefined(param_01))
	{
		if(isdefined(param_02))
		{
			for(var_03 = 0;var_03 < level.var_744A.size;var_03++)
			{
				var_04 = level.var_744A[var_03];
				if(var_04 issplitscreenplayer() && !var_04 method_82ED())
				{
					continue;
				}

				if(isdefined(var_04.var_12C["team"]) && var_04.var_12C["team"] == param_01 && !func_56E0(var_04,param_02))
				{
					var_04 method_8615(param_00);
				}
			}

			return;
		}

		for(var_03 = 0;var_03 < level.var_744A.size;var_03++)
		{
			var_04 = level.var_744A[var_03];
			if(var_04 issplitscreenplayer() && !var_04 method_82ED())
			{
				continue;
			}

			if(isdefined(var_04.var_12C["team"]) && var_04.var_12C["team"] == param_01)
			{
				var_04 method_8615(param_00);
			}
		}

		return;
	}

	if(isdefined(var_04))
	{
		for(var_03 = 0;var_03 < level.var_744A.size;var_03++)
		{
			var_04 = level.var_744A[var_03];
			if(var_04 issplitscreenplayer() && !var_04 method_82ED())
			{
				continue;
			}

			if(!func_56E0(var_04,param_02))
			{
				var_04 method_8615(param_00);
			}
		}

		return;
	}

	for(var_03 = 0;var_03 < level.var_744A.size;var_03++)
	{
		var_04 = level.var_744A[var_03];
		if(var_04 issplitscreenplayer() && !var_04 method_82ED())
		{
			continue;
		}

		var_04 method_8615(param_00);
	}
}

//Function Number: 22
func_74C3(param_00,param_01,param_02)
{
	if(!function_0344(param_00))
	{
		return;
	}

	var_03 = spawn("script_origin",(0,0,0));
	var_03 endon("death");
	thread common_scripts\utility::func_2D18(var_03);
	if(isdefined(param_02))
	{
		var_03 method_805C();
		foreach(var_05 in param_02)
		{
			var_03 showtoclient(var_05);
		}
	}

	if(isdefined(param_01))
	{
		var_03.var_116 = self.var_116 + param_01;
		var_03.var_1D = self.var_1D;
		var_03 method_8449(self);
	}
	else
	{
		var_03.var_116 = self.var_116;
		var_03.var_1D = self.var_1D;
		var_03 method_8449(self);
	}

	var_03 method_861D(param_00);
	self waittill("stop sound" + param_00);
	var_03 stoploopsound(param_00);
	var_03 delete();
}

//Function Number: 23
func_8F25()
{
	for(var_00 = 1;var_00 < self.var_5F2B.size;var_00++)
	{
		var_01 = self.var_5F2B[var_00];
		var_02 = var_01.var_7734;
		for(var_03 = var_00 - 1;var_03 >= 0 && var_02 > self.var_5F2B[var_03].var_7734;var_03--)
		{
			self.var_5F2B[var_03 + 1] = self.var_5F2B[var_03];
		}

		self.var_5F2B[var_03 + 1] = var_01;
	}
}

//Function Number: 24
func_09C7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = undefined;
	foreach(var_0B in self.var_5F2B)
	{
		if(var_0B.var_109 == param_00)
		{
			if(var_0B.var_991F == param_01 && var_0B.var_7734 == param_03)
			{
				return;
			}

			var_09 = var_0B;
			break;
		}
	}

	if(!isdefined(var_09))
	{
		var_09 = spawnstruct();
		self.var_5F2B[self.var_5F2B.size] = var_09;
	}

	var_09.var_109 = param_00;
	var_09.var_991F = param_01;
	var_09.var_99DA = param_02;
	var_09.var_9F6 = gettime();
	var_09.var_7734 = param_03;
	var_09.var_8C1E = param_04;
	var_09.var_8B91 = param_05;
	var_09.var_39CE = param_06;
	var_09.var_39CF = param_07;
	var_09.var_C1 = param_08;
	func_8F25();
}

//Function Number: 25
func_7CE9(param_00)
{
	if(isdefined(self.var_5F2B))
	{
		for(var_01 = self.var_5F2B.size;var_01 > 0;var_01--)
		{
			if(self.var_5F2B[var_01 - 1].var_109 != param_00)
			{
				continue;
			}

			var_02 = self.var_5F2B[var_01 - 1];
			for(var_03 = var_01;var_03 < self.var_5F2B.size;var_03++)
			{
				if(isdefined(self.var_5F2B[var_03]))
				{
					self.var_5F2B[var_03 - 1] = self.var_5F2B[var_03];
				}
			}

			self.var_5F2B[self.var_5F2B.size - 1] = undefined;
		}

		func_8F25();
	}
}

//Function Number: 26
func_4569()
{
	return self.var_5F2B[0];
}

//Function Number: 27
func_86C3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
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
		param_06 = 0.85;
	}

	if(!isdefined(param_07))
	{
		param_07 = 3;
	}

	if(!isdefined(param_08))
	{
		param_08 = 0;
	}

	func_09C7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	func_A131();
}

//Function Number: 28
func_A131()
{
	if(!isdefined(self.var_5F29))
	{
		return;
	}

	var_00 = func_4569();
	if(!isdefined(var_00))
	{
		if(isdefined(self.var_5F29) && isdefined(self.var_5F30))
		{
			self.var_5F29.var_18 = 0;
			self.var_5F30.var_18 = 0;
		}

		return;
	}

	self.var_5F29 settext(var_00.var_991F);
	self.var_5F29.var_18 = 0.85;
	self.var_5F30.var_18 = 1;
	self.var_5F29.var_C1 = var_00.var_C1;
	if(var_00.var_8B91)
	{
		self.var_5F29 fadeovertime(min(var_00.var_39CF,60));
		self.var_5F29.var_18 = var_00.var_39CE;
	}

	if(var_00.var_99DA > 0 && var_00.var_8C1E)
	{
		self.var_5F30 settimer(max(var_00.var_99DA - gettime() - var_00.var_9F6 / 1000,0.1));
		return;
	}

	if(var_00.var_99DA > 0 && !var_00.var_8C1E)
	{
		self.var_5F30 settext("");
		self.var_5F29 fadeovertime(min(var_00.var_99DA,60));
		self.var_5F29.var_18 = 0;
		thread func_2403(var_00);
		thread func_23D6(var_00);
		return;
	}

	self.var_5F30 settext("");
}

//Function Number: 29
func_2403(param_00)
{
	self notify("message_cleared");
	self endon("message_cleared");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	func_2401(param_00.var_109);
}

//Function Number: 30
func_23D6(param_00)
{
	wait(param_00.var_99DA);
	func_2401(param_00.var_109);
	self notify("message_cleared");
}

//Function Number: 31
func_2401(param_00)
{
	func_7CE9(param_00);
	func_A131();
}

//Function Number: 32
func_2402()
{
	for(var_00 = 0;var_00 < self.var_5F2B.size;var_00++)
	{
		self.var_5F2B[var_00] = undefined;
	}

	if(!isdefined(self.var_5F29))
	{
		return;
	}

	func_A131();
}

//Function Number: 33
func_7728(param_00,param_01)
{
	foreach(var_03 in level.var_744A)
	{
		if(var_03.var_1A7 != param_01)
		{
			continue;
		}

		var_03 iclientprintln(param_00);
	}
}

//Function Number: 34
func_772A(param_00,param_01,param_02)
{
	foreach(var_04 in level.var_744A)
	{
		if(var_04.var_1A7 != param_01)
		{
			continue;
		}

		var_04 iclientprintln(param_00,param_02);
	}
}

//Function Number: 35
func_771E(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.var_744A.size;var_02++)
	{
		var_03 = level.var_744A[var_02];
		if(isdefined(var_03.var_12C["team"]) && var_03.var_12C["team"] == param_01)
		{
			var_03 iclientprintlnbold(param_00);
		}
	}
}

//Function Number: 36
gator_tooth_placement_init(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < level.var_744A.size;var_03++)
	{
		var_04 = level.var_744A[var_03];
		if(isdefined(var_04.var_12C["team"]) && var_04.var_12C["team"] == param_01)
		{
			var_04 iclientprintlnbold(param_00,param_02);
		}
	}
}

//Function Number: 37
func_7729(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < level.var_744A.size;var_03++)
	{
		var_04 = level.var_744A[var_03];
		if(isdefined(var_04.var_12C["team"]) && var_04.var_12C["team"] == param_01)
		{
			var_04 iclientprintln(param_00,param_02);
		}
	}
}

//Function Number: 38
func_7727(param_00,param_01)
{
	var_02 = level.var_744A;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(isdefined(param_01))
		{
			if(isdefined(var_02[var_03].var_12C["team"]) && var_02[var_03].var_12C["team"] == param_01)
			{
				var_02[var_03] iclientprintln(param_00);
			}

			continue;
		}

		var_02[var_03] iclientprintln(param_00);
	}
}

//Function Number: 39
func_771A(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = isdefined(param_04);
	var_08 = 0;
	if(isdefined(param_05))
	{
		var_08 = 1;
	}

	if(level.var_910F || !var_07)
	{
		for(var_09 = 0;var_09 < level.var_744A.size;var_09++)
		{
			var_0A = level.var_744A[var_09];
			var_0B = var_0A.var_1A7;
			if(isdefined(var_0B))
			{
				if(var_0B == param_00 && isdefined(param_02))
				{
					var_0A iclientprintln(param_02,param_06);
					continue;
				}

				if(var_0B == param_01 && isdefined(param_03))
				{
					var_0A iclientprintln(param_03,param_06);
				}
			}
		}

		if(var_07)
		{
			level.var_744A[0] method_8615(param_04);
			return;
		}

		return;
	}

	if(var_0B)
	{
		for(var_09 = 0;var_09 < level.var_744A.size;var_09++)
		{
			var_0A = level.var_744A[var_09];
			var_0B = var_0A.var_1A7;
			if(isdefined(var_0B))
			{
				if(var_0B == param_00)
				{
					if(isdefined(param_02))
					{
						var_0A iclientprintln(param_02,param_06);
					}

					var_0A method_8615(param_04);
					continue;
				}

				if(var_0B == param_01)
				{
					if(isdefined(param_03))
					{
						var_0A iclientprintln(param_03,param_06);
					}

					var_0A method_8615(param_05);
				}
			}
		}

		return;
	}

	for(var_09 = 0;var_09 < level.var_744A.size;var_09++)
	{
		var_0A = level.var_744A[var_09];
		var_0B = var_0A.var_1A7;
		if(isdefined(var_0B))
		{
			if(var_0B == param_00)
			{
				if(isdefined(param_02))
				{
					var_0A iclientprintln(param_02,param_06);
				}

				var_0A method_8615(param_04);
				continue;
			}

			if(var_0B == param_01)
			{
				if(isdefined(param_03))
				{
					var_0A iclientprintln(param_03,param_06);
				}
			}
		}
	}
}

//Function Number: 40
gator_tooth_broken(param_00,param_01,param_02)
{
	foreach(var_04 in level.var_744A)
	{
		if(var_04.var_1A7 != param_00)
		{
			continue;
		}

		var_04 gator_teeth_placed(param_01,param_02);
	}
}

//Function Number: 41
gator_teeth_placed(param_00,param_01)
{
	self iclientprintln(param_00);
	self method_8615(param_01);
}

//Function Number: 42
func_069F(param_00)
{
	if(level.var_910F && self getentitynumber() != 0)
	{
		return;
	}

	self method_8615(param_00);
}

//Function Number: 43
func_3517(param_00,param_01,param_02,param_03)
{
	param_00 = "scr_" + level.var_3FDC + "_" + param_00;
	if(getdvar(param_00) == "")
	{
		setdvar(param_00,param_01);
		return param_01;
	}

	var_04 = getdvarint(param_00);
	if(var_04 > param_03)
	{
		var_04 = param_03;
	}
	else if(var_04 < param_02)
	{
		var_04 = param_02;
	}
	else
	{
		return var_04;
	}

	setdvar(param_00,var_04);
	return var_04;
}

//Function Number: 44
func_3516(param_00,param_01,param_02,param_03)
{
	param_00 = "scr_" + level.var_3FDC + "_" + param_00;
	if(getdvar(param_00) == "")
	{
		setdvar(param_00,param_01);
		return param_01;
	}

	var_04 = getdvarfloat(param_00);
	if(var_04 > param_03)
	{
		var_04 = param_03;
	}
	else if(var_04 < param_02)
	{
		var_04 = param_02;
	}
	else
	{
		return var_04;
	}

	setdvar(param_00,var_04);
	return var_04;
}

//Function Number: 45
func_71AC(param_00,param_01)
{
	if(isdefined(param_01))
	{
		playsoundatpos(self gettagorigin(param_01),param_00);
		return;
	}

	playsoundatpos(self.var_116,param_00);
}

//Function Number: 46
func_45DE(param_00)
{
	if(level.var_6520)
	{
	}

	if(param_00 == "allies")
	{
		return "axis";
	}
	else if(param_00 == "axis")
	{
		return "allies";
	}
	else
	{
		return "none";
	}
}

//Function Number: 47
func_532D(param_00)
{
	if(!isdefined(self.var_12C[param_00]))
	{
		self.var_12C[param_00] = 0;
	}
}

//Function Number: 48
func_4607(param_00)
{
	return self.var_12C[param_00];
}

//Function Number: 49
func_50E9(param_00,param_01)
{
	if(isdefined(self) && isdefined(self.var_12C) && isdefined(self.var_12C[param_00]))
	{
		self.var_12C[param_00] = self.var_12C[param_00] + param_01;
		if((!isdefined(level.disableallplayerstats) || !level.disableallplayerstats) && (param_00 != "suicides" && param_00 != "kills" && param_00 != "deaths") || !func_579B() || function_03AF() || isdefined(level.var_2F8B) && level.var_2F8B)
		{
			maps\mp\gametypes\_persistence::func_9314(param_00,param_01);
		}
	}
}

//Function Number: 50
func_86F5(param_00,param_01)
{
	self.var_12C[param_00] = param_01;
}

//Function Number: 51
func_5335(param_00,param_01)
{
	if(!isdefined(self.var_9337["stats_" + param_00]))
	{
		if(!isdefined(param_01))
		{
			param_01 = 0;
		}

		self.var_9337["stats_" + param_00] = spawnstruct();
		self.var_9337["stats_" + param_00].var_A281 = param_01;
		if(!function_0367() && func_7A69())
		{
			self setrankedplayerdata(common_scripts\utility::func_46A7(),"round","awards",param_00,0);
		}
	}
}

//Function Number: 52
func_50EA(param_00,param_01)
{
	if(function_01EF(self))
	{
		return;
	}

	var_02 = self.var_9337["stats_" + param_00];
	var_02.var_A281 = var_02.var_A281 + param_01;
}

//Function Number: 53
func_8702(param_00,param_01)
{
	var_02 = self.var_9337["stats_" + param_00];
	var_02.var_A281 = param_01;
	var_02.var_99DA = gettime();
}

//Function Number: 54
func_4628(param_00)
{
	return self.var_9337["stats_" + param_00].var_A281;
}

//Function Number: 55
coop_mode_enable(param_00)
{
	return self.var_9337["stats_" + param_00].var_99DA;
}

//Function Number: 56
func_8703(param_00,param_01)
{
	var_02 = func_4628(param_00);
	if(param_01 > var_02)
	{
		func_8702(param_00,param_01);
	}
}

//Function Number: 57
func_8704(param_00,param_01)
{
	var_02 = func_4628(param_00);
	if(param_01 < var_02)
	{
		func_8702(param_00,param_01);
	}
}

//Function Number: 58
func_A14B(param_00,param_01,param_02)
{
	if(!func_7A69())
	{
		return;
	}

	var_03 = maps\mp\gametypes\_persistence::func_932F(param_01);
	var_04 = maps\mp\gametypes\_persistence::func_932F(param_02);
	if(var_04 == 0)
	{
		var_04 = 1;
	}

	maps\mp\gametypes\_persistence::func_9338(param_00,int(var_03 * 1000 / var_04));
}

//Function Number: 59
func_A14C(param_00,param_01,param_02)
{
	if(!func_7A69())
	{
		return;
	}

	var_03 = maps\mp\gametypes\_persistence::func_9330(param_01);
	var_04 = maps\mp\gametypes\_persistence::func_9330(param_02);
	if(var_04 == 0)
	{
		var_04 = 1;
	}

	maps\mp\gametypes\_persistence::func_9339(param_00,int(var_03 * 1000 / var_04));
}

//Function Number: 60
func_A790(param_00)
{
	if(level.var_5BDF == gettime())
	{
		if(isdefined(param_00) && param_00)
		{
			while(level.var_5BDF == gettime())
			{
				wait 0.05;
			}
		}
		else
		{
			wait 0.05;
			if(level.var_5BDF == gettime())
			{
				wait 0.05;
				if(level.var_5BDF == gettime())
				{
					wait 0.05;
					if(level.var_5BDF == gettime())
					{
						wait 0.05;
					}
				}
			}
		}
	}

	level.var_5BDF = gettime();
}

//Function Number: 61
func_A6D1(param_00,param_01)
{
	self endon(param_01);
	wait(param_00);
}

//Function Number: 62
func_A6D0(param_00,param_01)
{
	if(isdefined(param_01))
	{
		foreach(var_03 in param_01)
		{
			self endon(var_03);
		}
	}

	if(isdefined(param_00) && param_00 > 0)
	{
		wait(param_00);
	}
}

//Function Number: 63
func_56E0(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(param_00 == param_01[var_02])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 64
func_5C39(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(level.var_585D) && level.var_585D)
	{
		return;
	}

	if(param_00 == "null")
	{
		return;
	}

	if(!isdefined(param_01))
	{
		func_5C3E(param_00,"allies",param_00,"axis",param_02,param_03,param_04);
		return;
	}

	if(isdefined(param_03))
	{
		for(var_05 = 0;var_05 < level.var_744A.size;var_05++)
		{
			var_06 = level.var_744A[var_05];
			if(isdefined(var_06.var_12C["team"]) && var_06.var_12C["team"] == param_01 && !func_56E0(var_06,param_03))
			{
				if(var_06 issplitscreenplayer() && !var_06 method_82ED())
				{
					continue;
				}

				var_06 func_5C43(param_00,param_02,undefined,param_04);
			}
		}

		return;
	}

	for(var_05 = 0;var_05 < level.var_744A.size;var_05++)
	{
		var_06 = level.var_744A[var_05];
		if(isdefined(var_06.var_12C["team"]) && var_06.var_12C["team"] == param_01)
		{
			if(var_06 issplitscreenplayer() && !var_06 method_82ED())
			{
				continue;
			}

			var_06 func_5C43(param_00,param_02,undefined,param_04);
		}
	}
}

//Function Number: 65
func_5C3E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(level.var_585D) && level.var_585D)
	{
		return;
	}

	if(level.var_910F)
	{
		return;
	}

	if(level.var_910F)
	{
		if(level.var_744A.size)
		{
			level.var_744A[0] func_5C43(param_00,param_04,undefined,param_06);
		}

		return;
	}

	if(isdefined(param_05))
	{
		for(var_07 = 0;var_07 < level.var_744A.size;var_07++)
		{
			var_08 = level.var_744A[var_07];
			var_09 = var_08.var_12C["team"];
			if(!isdefined(var_09))
			{
				continue;
			}

			if(func_56E0(var_08,param_05))
			{
				continue;
			}

			if(var_08 issplitscreenplayer() && !var_08 method_82ED())
			{
				continue;
			}

			if(var_09 == param_01)
			{
				var_08 func_5C43(param_00,param_04,undefined,param_06);
				continue;
			}

			if(var_09 == param_03)
			{
				var_08 func_5C43(param_02,param_04,undefined,param_06);
			}
		}

		return;
	}

	for(var_07 = 0;var_07 < level.var_744A.size;var_07++)
	{
		var_08 = level.var_744A[var_07];
		var_09 = var_08.var_12C["team"];
		if(!isdefined(var_09))
		{
			continue;
		}

		if(var_08 issplitscreenplayer() && !var_08 method_82ED())
		{
			continue;
		}

		if(var_09 == param_01)
		{
			var_08 func_5C43(param_00,param_04,undefined,param_06);
			continue;
		}

		if(var_09 == param_03)
		{
			var_08 func_5C43(param_02,param_04,undefined,param_06);
		}
	}
}

//Function Number: 66
func_5C46(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.var_585D) && level.var_585D)
	{
		return;
	}

	foreach(var_05 in param_01)
	{
		var_05 func_5C43(param_00,param_02,undefined,param_03);
	}
}

//Function Number: 67
func_5C43(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.var_585D) && level.var_585D)
	{
		return;
	}

	if(function_01EF(self))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_04 = self.var_12C["team"];
	if(isdefined(level.var_F05) && level.var_F05)
	{
		return;
	}

	if(!isdefined(var_04))
	{
		return;
	}

	if(var_04 != "allies" && var_04 != "axis")
	{
		return;
	}

	if(self issplitscreenplayer() && !self method_82ED())
	{
		return;
	}

	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	if(isdefined(param_01))
	{
		if(self.var_5C3F == param_01)
		{
			if(param_02)
			{
				if(isdefined(self.var_5C3D))
				{
					lib_0380::func_2893(self.var_5C3D,0.1);
					self.var_5C3D = undefined;
				}

				thread func_5C45(param_00,var_04,param_03);
			}

			return;
		}

		var_05 = isdefined(self.var_5C40[param_01]);
		self.var_5C40[param_01] = param_00;
		param_00 = param_01;
		if(var_05)
		{
			return;
		}
	}

	if(!isdefined(self.var_5C3D))
	{
		thread func_5C45(param_00,var_04,param_03);
		return;
	}

	self.var_5C47[self.var_5C47.size] = param_00;
	self.var_5C42[self.var_5C42.size] = param_03;
}

//Function Number: 68
func_5C3C(param_00,param_01)
{
	var_02 = 2;
	if(isdefined(game["dialog"]["lockouts"][param_00]))
	{
		var_02 = game["dialog"]["lockouts"][param_00];
		if(var_02 == 0)
		{
			return;
		}
	}

	if(!isdefined(param_01.var_8C9))
	{
		param_01.var_8C9 = [];
	}

	param_01.var_8C9[param_00] = 1;
	thread func_5C3B(param_00,param_01,var_02);
}

//Function Number: 69
func_5C3B(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	wait(param_02);
	param_01.var_8C9[param_00] = undefined;
}

//Function Number: 70
func_5C3A(param_00,param_01)
{
	if(isdefined(param_01.var_8C9))
	{
		if(isdefined(param_01.var_8C9[param_00]))
		{
			if(isdefined(param_01.var_8C9[param_00] == 1))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 71
func_5C45(param_00,param_01,param_02)
{
	self endon("disconnect");
	self notify("playLeaderDialogOnPlayer");
	self endon("playLeaderDialogOnPlayer");
	if(isdefined(self.var_5C40[param_00]))
	{
		var_03 = param_00;
		param_00 = self.var_5C40[var_03];
		self.var_5C40[var_03] = undefined;
		self.var_5C3F = var_03;
	}

	if(!isdefined(game["dialog"][param_00]))
	{
		return;
	}

	if(isai(self) && isdefined(level.var_19D5) && isdefined(level.var_19D5["leader_dialog"]))
	{
		self [[ level.var_19D5["leader_dialog"] ]](param_00,param_02);
	}

	if(issubstr(game["dialog"][param_00],"null"))
	{
		return;
	}

	var_04 = game["voice"][param_01] + game["dialog"][param_00];
	if(function_0344(var_04))
	{
		if(func_5C3A(game["dialog"][param_00],self))
		{
			return;
		}

		if(func_5727())
		{
			return;
		}

		if(isdefined(self.var_5C3D))
		{
			lib_0380::func_2893(self.var_5C3D,0.1);
			self.var_5C3D = undefined;
		}

		self.var_5C3D = lib_0380::func_2888(var_04,self);
		func_5C3C(game["dialog"][param_00],self);
	}
	else
	{
	}

	if(isdefined(level.var_2EBB))
	{
		[[ level.var_2EBB ]](param_00,var_04);
	}
	else
	{
		wait(2);
	}

	self.var_5C41 = "";
	self.var_5C3D = undefined;
	self.var_5C3F = "";
	if(self.var_5C47.size > 0)
	{
		var_05 = self.var_5C47[0];
		var_06 = self.var_5C42[0];
		for(var_07 = 1;var_07 < self.var_5C47.size;var_07++)
		{
			self.var_5C47[var_07 - 1] = self.var_5C47[var_07];
		}

		for(var_07 = 1;var_07 < self.var_5C42.size;var_07++)
		{
			self.var_5C42[var_07 - 1] = self.var_5C42[var_07];
		}

		self.var_5C47[var_07 - 1] = undefined;
		self.var_5C42[var_07 - 1] = undefined;
		thread func_5C45(var_05,param_01,var_06);
	}
}

//Function Number: 72
func_45AA()
{
	for(var_00 = 0;var_00 < self.var_5C47.size;var_00++)
	{
		if(issubstr(self.var_5C47[var_00],"losing"))
		{
			if(self.var_1A7 == "allies")
			{
				if(issubstr(level.var_147A,self.var_5C47[var_00]))
				{
					return self.var_5C47[var_00];
				}
				else
				{
					common_scripts\utility::func_F93(self.var_5C47,self.var_5C47[var_00]);
				}
			}
			else if(issubstr(level.var_BF4,self.var_5C47[var_00]))
			{
				return self.var_5C47[var_00];
			}
			else
			{
				common_scripts\utility::func_F93(self.var_5C47,self.var_5C47[var_00]);
			}

			continue;
		}

		return level.var_BF4[self.var_5C47];
	}
}

//Function Number: 73
func_6C2A()
{
	self endon("disconnect");
	var_00 = [];
	var_00 = self.var_5C47;
	for(var_01 = 0;var_01 < self.var_5C47.size;var_01++)
	{
		if(issubstr(self.var_5C47[var_01],"losing"))
		{
			for(var_02 = var_01;var_02 >= 0;var_02--)
			{
				if(!issubstr(self.var_5C47[var_02],"losing") && var_02 != 0)
				{
					continue;
				}

				if(var_02 != var_01)
				{
					func_0FBD(var_00,self.var_5C47[var_01],var_02);
					common_scripts\utility::func_F93(var_00,self.var_5C47[var_01]);
					break;
				}
			}
		}
	}

	self.var_5C47 = var_00;
}

//Function Number: 74
func_3D8B()
{
	self.var_5C40 = [];
	self.var_5C47 = [];
	self.var_5C3D = undefined;
	self.var_293C = "";
	self notify("flush_dialog");
}

//Function Number: 75
func_3D8C(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		var_02 func_3D8D(param_00);
	}
}

//Function Number: 76
func_0FC0(param_00,param_01)
{
	var_02 = 0;
	for(var_03 = 0;var_02 < param_00.size;var_03++)
	{
		if(param_00[var_02] == param_01)
		{
			var_02++;
			continue;
		}

		if(var_02 != var_03)
		{
			param_00[var_03] = param_00[var_02];
		}

		var_02++;
	}

	while(var_03 < param_00.size)
	{
		param_00[var_03] = undefined;
		var_03++;
	}
}

//Function Number: 77
func_3D8D(param_00)
{
	self.var_5C40[param_00] = undefined;
	func_0FC0(self.var_5C47,param_00);
	if(self.var_5C47.size == 0)
	{
		func_3D8B();
	}
}

//Function Number: 78
func_A132()
{
	if(self.var_12C["team"] == "spectator")
	{
		self setclientdvar("g_scriptMainMenu",game["menu_team"]);
		return;
	}

	self setclientdvar("g_scriptMainMenu",game["menu_class_" + self.var_12C["team"]]);
}

//Function Number: 79
func_A143()
{
	if(self.var_12C["team"] == "spectator")
	{
		self setclientdvar("cg_objectiveText","");
		return;
	}

	if(func_471A("scorelimit") > 0 && !func_5760())
	{
		if(level.var_910F)
		{
			self setclientdvar("cg_objectiveText",func_45D2(self.var_12C["team"]));
			return;
		}

		self setclientdvar("cg_objectiveText",func_45D2(self.var_12C["team"]),func_471A("scorelimit"));
		return;
	}

	self setclientdvar("cg_objectiveText",func_45D3(self.var_12C["team"]));
}

//Function Number: 80
func_86DC(param_00,param_01)
{
	game["strings"]["objective_" + param_00] = param_01;
}

//Function Number: 81
func_86DB(param_00,param_01)
{
	game["strings"]["objective_score_" + param_00] = param_01;
}

//Function Number: 82
func_86D8(param_00,param_01)
{
	game["strings"]["objective_hint_" + param_00] = param_01;
}

//Function Number: 83
func_45D3(param_00)
{
	return game["strings"]["objective_" + param_00];
}

//Function Number: 84
func_45D2(param_00)
{
	return game["strings"]["objective_score_" + param_00];
}

//Function Number: 85
func_45CD(param_00)
{
	return game["strings"]["objective_hint_" + param_00];
}

//Function Number: 86
func_46E3()
{
	if(!isdefined(level.var_9309) || !isdefined(level.var_2FB1))
	{
		return 0;
	}

	if(level.interaction_hintstrings)
	{
		return level.var_9A11 - level.var_9309 - level.var_2FB1;
	}

	return gettime() - level.var_9309 - level.var_2FB1;
}

//Function Number: 87
func_4705()
{
	if(!isdefined(level.var_6027))
	{
		return 0;
	}

	return gettime() - level.var_6027;
}

//Function Number: 88
func_44FA()
{
	var_00 = getmatchdata("match_common","game_length_seconds") * 1000;
	var_00 = var_00 + func_4705();
	return var_00;
}

//Function Number: 89
func_44FB()
{
	var_00 = func_44FA();
	var_01 = int(var_00 / 1000);
	return var_01;
}

//Function Number: 90
func_46E4()
{
	return func_46E3() / func_46E2() * 60 * 1000 * 100;
}

//Function Number: 91
func_467B()
{
	return func_46E3() / 1000;
}

//Function Number: 92
func_4589()
{
	return func_467B() / 60;
}

//Function Number: 93
func_2315(param_00)
{
	param_00 = int(param_00);
	if(param_00 > 32767)
	{
		param_00 = 32767;
	}

	if(param_00 < --32768)
	{
		param_00 = --32768;
	}

	return param_00;
}

//Function Number: 94
func_2314(param_00)
{
	param_00 = int(param_00);
	if(param_00 > 255)
	{
		param_00 = 255;
	}

	if(param_00 < 0)
	{
		param_00 = 0;
	}

	return param_00;
}

//Function Number: 95
func_23FF()
{
	self.var_9F = -1;
	self.var_E1 = -1;
	self.var_20 = 0;
	self.var_14A = 0;
	self.var_188 = 0;
	self.var_189 = 0;
}

//Function Number: 96
func_5727()
{
	var_00 = "Player";
	if(function_026D(self))
	{
		var_00 = "TestClient";
	}

	if(function_01EF(self))
	{
		var_00 = "Agent";
	}

	var_01 = "ERROR: self.spectateKillcam is " + self.var_188 + ", but self.forcespectatorclient = " + self.var_9F + " and self.killcamentity = " + self.var_E1 + " (self is " + var_00 + ")";
	return self.var_188;
}

//Function Number: 97
func_5822(param_00)
{
	return isdefined(param_00) && param_00 != "";
}

//Function Number: 98
func_470E(param_00,param_01,param_02)
{
	if(param_00 > param_02)
	{
		return param_02;
	}

	if(param_00 < param_01)
	{
		return param_01;
	}

	return param_00;
}

//Function Number: 99
func_5EB0()
{
	if(!isdefined(self.var_12C["summary"]))
	{
		return;
	}

	if(isai(self))
	{
		return;
	}

	var_00 = 0;
	if(isdefined(self.var_9A06["total"]))
	{
		var_00 = self.var_9A06["total"];
	}

	function_00F5("script_EarnedXP: totalXP %d, timeplayed %d, score %d, challenge %d, match %d, misc %d, gamemode %s",self.var_12C["summary"]["xp"],var_00,self.var_12C["summary"]["score"],self.var_12C["summary"]["challenge"],self.var_12C["summary"]["match"],self.var_12C["summary"]["misc"],level.var_3FDC);
}

//Function Number: 100
func_7BF8(param_00,param_01,param_02,param_03)
{
	func_7C01("roundswitch",param_01);
	param_00 = "scr_" + param_00 + "_roundswitch";
	level.var_7F27 = param_00;
	level.var_7F29 = param_02;
	level.var_7F28 = param_03;
	level.var_7F26 = getdvarint(param_00,param_01);
	if(level.var_7F26 < param_02)
	{
		level.var_7F26 = param_02;
		return;
	}

	if(level.var_7F26 > param_03)
	{
		level.var_7F26 = param_03;
	}
}

//Function Number: 101
func_7BF7(param_00,param_01)
{
	func_7C01("roundlimit",param_01);
}

//Function Number: 102
func_7BF2(param_00,param_01)
{
	func_7C01("numTeams",param_01);
}

//Function Number: 103
func_7C04(param_00,param_01)
{
	func_7C01("winlimit",param_01);
}

//Function Number: 104
func_7BF9(param_00,param_01)
{
	func_7C01("scorelimit",param_01);
}

//Function Number: 105
func_7BFA(param_00,param_01)
{
	func_7C00("timelimit",param_01);
	setdvar("ui_timelimit",func_46E2());
}

//Function Number: 106
func_7BE5(param_00,param_01)
{
	func_7C01("halftime",param_01);
	setdvar("ui_halftime",func_4502());
}

//Function Number: 107
func_7BF1(param_00,param_01)
{
	func_7C01("numlives",param_01);
}

//Function Number: 108
func_86EB(param_00)
{
	setdvar("overtimeTimeLimit",param_00);
}

//Function Number: 109
func_413A(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_5779 = 1;
	var_02.var_5662 = 0;
	var_02.var_8E = param_00;
	var_02.var_29B6 = param_01;
	return var_02;
}

//Function Number: 110
func_413C(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_5779 = 0;
	var_02.var_5662 = 0;
	var_02.var_57C4 = 1;
	var_02.var_8E = param_00;
	var_02.var_29B6 = param_01;
	return var_02;
}

//Function Number: 111
func_4137(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_5779 = 0;
	var_02.var_5662 = 0;
	var_02.var_8E = param_00;
	var_02.var_29B6 = param_01;
	return var_02;
}

//Function Number: 112
func_4139(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_5779 = 0;
	var_02.var_5662 = 0;
	var_02.var_8E = param_00;
	var_02.var_29B6 = param_01;
	return var_02;
}

//Function Number: 113
func_413B(param_00)
{
	return param_00.var_116 + (0,0,32);
}

//Function Number: 114
func_469E()
{
	if(self getstance() == "crouch")
	{
		var_00 = self.var_116 + (0,0,24);
	}
	else if(self getstance() == "prone")
	{
		var_00 = self.var_116 + (0,0,10);
	}
	else
	{
		var_00 = self.var_116 + (0,0,32);
	}

	return var_00;
}

//Function Number: 115
func_4138(param_00)
{
	return param_00.var_116;
}

//Function Number: 116
func_44AB(param_00)
{
	var_01 = getdvar(param_00);
	if(var_01 == "")
	{
		return (0,0,0);
	}

	var_02 = strtok(var_01," ");
	if(var_02.size < 3)
	{
		return (0,0,0);
	}

	setdvar("tempR",var_02[0]);
	setdvar("tempG",var_02[1]);
	setdvar("tempB",var_02[2]);
	return (getdvarfloat("tempR"),getdvarfloat("tempG"),getdvarfloat("tempB"));
}

//Function Number: 117
func_9472(param_00,param_01)
{
	if(param_00.size <= param_01.size)
	{
		return param_00;
	}

	if(getsubstr(param_00,param_00.size - param_01.size,param_00.size) == param_01)
	{
		return getsubstr(param_00,0,param_00.size - param_01.size);
	}

	return param_00;
}

//Function Number: 118
func_072B(param_00)
{
	var_01 = self getweaponslistall();
	foreach(var_03 in var_01)
	{
		if(var_03 == param_00)
		{
			continue;
		}
		else
		{
			self takeweapon(var_03);
		}
	}
}

//Function Number: 119
func_8064()
{
	var_00 = spawnstruct();
	var_00.var_69A9 = self method_831F();
	var_00.var_888 = self.var_805F;
	var_00.var_2953 = self getcurrentweapon();
	var_01 = self getweaponslistall();
	var_00.var_A9E7 = [];
	foreach(var_03 in var_01)
	{
		if(function_01D4(var_03) == "exclusive")
		{
			continue;
		}

		if(function_01D4(var_03) == "altmode")
		{
			continue;
		}

		var_04 = spawnstruct();
		var_04.var_109 = var_03;
		var_04.var_242A = self getweaponammoclip(var_03,"right");
		var_04.var_2429 = self getweaponammoclip(var_03,"left");
		var_04.var_93B1 = self getweaponammostock(var_03);
		if(isdefined(self.var_99AC) && self.var_99AC == var_03)
		{
			var_04.var_93B1--;
		}

		var_00.var_A9E7[var_00.var_A9E7.size] = var_04;
	}

	self.var_827E = var_00;
}

//Function Number: 120
func_7DEF()
{
	var_00 = self.var_827E;
	self method_831E(var_00.var_69A9);
	foreach(var_02 in var_00.var_A9E7)
	{
		self method_82FA(var_02.var_109,var_02.var_242A,"right");
		if(issubstr(var_02.var_109,"akimbo"))
		{
			self method_82FA(var_02.var_109,var_02.var_2429,"left");
		}

		self setweaponammostock(var_02.var_109,var_02.var_93B1);
	}

	foreach(var_06, var_05 in var_00.var_888)
	{
		func_06D0(var_06,var_05.var_1B9,var_05.var_586B);
	}

	if(self getcurrentweapon() == "none")
	{
		var_02 = var_00.var_2953;
		if(var_02 == "none")
		{
			var_02 = common_scripts\utility::func_4550();
		}

		self setspawnweapon(var_02);
		self switchtoweapon(var_02);
	}
}

//Function Number: 121
func_867B(param_00)
{
	self.var_8F = param_00;
	func_86F5("extrascore0",param_00);
}

//Function Number: 122
func_867C(param_00)
{
	self.var_90 = param_00;
	func_86F5("extrascore1",param_00);
}

//Function Number: 123
func_06D0(param_00,param_01,param_02)
{
	self.var_805F[param_00].var_1B9 = param_01;
	self.var_805F[param_00].var_586B = param_02;
	self setactionslot(param_00,param_01,param_02);
}

//Function Number: 124
func_861B()
{
	func_06D0(1,"");
	func_06D0(2,"");
	func_06D0(3,"altMode");
	func_06D0(4,"");
	if(!level.var_258F)
	{
		func_06D0(5,"");
		func_06D0(6,"");
		func_06D0(7,"");
		func_06D0(8,"");
	}
}

//Function Number: 125
func_56F6(param_00)
{
	if(int(param_00) != param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 126
func_7C01(param_00,param_01)
{
	var_02 = "scr_" + level.var_3FDC + "_" + param_00;
	level.var_A901[var_02] = spawnstruct();
	level.var_A901[var_02].var_A281 = getdvarint(var_02,param_01);
	level.var_A901[var_02].var_1B9 = "int";
	level.var_A901[var_02].var_6810 = "update_" + param_00;
}

//Function Number: 127
func_7C00(param_00,param_01)
{
	var_02 = "scr_" + level.var_3FDC + "_" + param_00;
	level.var_A901[var_02] = spawnstruct();
	level.var_A901[var_02].var_A281 = getdvarfloat(var_02,param_01);
	level.var_A901[var_02].var_1B9 = "float";
	level.var_A901[var_02].var_6810 = "update_" + param_00;
}

//Function Number: 128
func_7BFF(param_00,param_01)
{
	var_02 = "scr_" + level.var_3FDC + "_" + param_00;
	level.var_A901[var_02] = spawnstruct();
	level.var_A901[var_02].var_A281 = getdvar(var_02,param_01);
	level.var_A901[var_02].var_1B9 = "string";
	level.var_A901[var_02].var_6810 = "update_" + param_00;
}

//Function Number: 129
func_86EA(param_00,param_01)
{
	param_00 = "scr_" + level.var_3FDC + "_" + param_00;
	level.var_6CC8[param_00] = param_01;
}

//Function Number: 130
func_471A(param_00)
{
	param_00 = "scr_" + level.var_3FDC + "_" + param_00;
	if(isdefined(level.var_6CC8) && isdefined(level.var_6CC8[param_00]))
	{
		return level.var_6CC8[param_00];
	}

	return level.var_A901[param_00].var_A281;
}

//Function Number: 131
func_A194()
{
	while(game["state"] == "playing")
	{
		foreach(var_02, var_01 in level.var_A901)
		{
			func_A193(var_02);
		}

		wait(1);
	}
}

//Function Number: 132
func_A193(param_00)
{
	var_01 = level.var_A901[param_00];
	if(var_01.var_1B9 == "string")
	{
		var_02 = func_463A(param_00,var_01.var_A281);
	}
	else if(var_02.var_1B9 == "float")
	{
		var_02 = func_44E8(var_01,var_02.var_A281);
	}
	else
	{
		var_02 = func_4529(var_01,var_02.var_A281);
	}

	if(var_02 != var_01.var_A281)
	{
		var_01.var_A281 = var_02;
		level notify(var_01.var_6810,var_02);
	}
}

//Function Number: 133
func_57B2()
{
	if(!level.var_984D && !common_scripts\utility::func_562E(level.roundbasedffa))
	{
		return 0;
	}

	if(func_471A("winlimit") != 1 && func_471A("roundlimit") != 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 134
func_56F0()
{
	if(!level.var_984D)
	{
		return 1;
	}

	if(func_471A("roundlimit") > 1 && game["roundsPlayed"] == 0)
	{
		return 1;
	}

	if(func_471A("winlimit") > 1 && game["roundsWon"]["allies"] == 0 && game["roundsWon"]["axis"] == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 135
func_5743()
{
	if(!level.var_984D)
	{
		return 1;
	}

	if(func_471A("roundlimit") > 1 && game["roundsPlayed"] >= func_471A("roundlimit") - 1)
	{
		return 1;
	}

	if(func_471A("winlimit") > 1 && isdefined(game["roundsWon"]) && game["roundsWon"]["allies"] >= func_471A("winlimit") - 1 && game["roundsWon"]["axis"] >= func_471A("winlimit") - 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 136
func_A875()
{
	if(!level.var_984D && !common_scripts\utility::func_562E(level.roundbasedffa))
	{
		return 1;
	}

	if(isdefined(level.var_6B54))
	{
		return 0;
	}

	if(func_471A("winlimit") == 1 && func_4DE7())
	{
		return 1;
	}

	if(func_471A("roundlimit") == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 137
func_A872()
{
	if(level.var_3E16)
	{
		return 1;
	}

	if(!level.var_984D && !common_scripts\utility::func_562E(level.roundbasedffa))
	{
		return 1;
	}

	if(func_4DDD() || func_4DE7())
	{
		return 1;
	}

	return 0;
}

//Function Number: 138
func_4DDD()
{
	if(func_471A("roundlimit") <= 0)
	{
		return 0;
	}

	return game["roundsPlayed"] >= func_471A("roundlimit");
}

//Function Number: 139
func_4DE2()
{
	if(func_5760())
	{
		return 0;
	}

	if(func_471A("scorelimit") <= 0)
	{
		return 0;
	}

	if(level.var_984D)
	{
		if(game["teamScores"]["allies"] >= func_471A("scorelimit") || game["teamScores"]["axis"] >= func_471A("scorelimit"))
		{
			return 1;
		}
	}
	else
	{
		for(var_00 = 0;var_00 < level.var_744A.size;var_00++)
		{
			var_01 = level.var_744A[var_00];
			if(isdefined(var_01.var_15C) && var_01.var_15C >= func_471A("scorelimit"))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 140
func_4DE7()
{
	if(func_471A("winlimit") <= 0)
	{
		return 0;
	}

	if(common_scripts\utility::func_562E(level.roundbasedffa))
	{
		return 0;
	}

	if(!level.var_984D)
	{
		return 1;
	}

	if(func_4669("allies") >= func_471A("winlimit") || func_4669("axis") >= func_471A("winlimit"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 141
func_4672()
{
	if(func_57B2())
	{
		if(func_471A("roundlimit"))
		{
			return func_471A("roundlimit");
		}

		return func_471A("winlimit");
	}

	return func_471A("scorelimit");
}

//Function Number: 142
func_4669(param_00)
{
	return game["roundsWon"][param_00];
}

//Function Number: 143
func_5760()
{
	return level.var_6933;
}

//Function Number: 144
func_579B()
{
	return isdefined(level.var_579A) && level.var_579A && isdefined(level.var_79C2);
}

//Function Number: 145
func_585F()
{
	return isdefined(level.var_585D) && level.var_585D;
}

//Function Number: 146
iszombiegameshattermode()
{
	if(func_585F() == 0)
	{
		return 0;
	}

	var_00 = func_4571();
	return isdefined(level.iszombiesshotgun) && level.iszombiesshotgun;
}

//Function Number: 147
getcurzombiegameshatterindex()
{
	if(iszombiegameshattermode() == 0)
	{
		return -1;
	}

	var_00 = func_4571();
	if(var_00 == "mp_zombie_windmill")
	{
		return 1;
	}
	else if(var_00 == "mp_zombie_dnk")
	{
		return 2;
	}
	else if(var_00 == "mp_zombie_dig_02")
	{
		return 3;
	}

	return -1;
}

//Function Number: 148
isprophuntgametype()
{
	return common_scripts\utility::func_562E(level.isprophunt);
}

//Function Number: 149
isdogfightgametype()
{
	return common_scripts\utility::func_562E(level.isdogfight);
}

//Function Number: 150
func_46E2()
{
	if(func_5380())
	{
		var_00 = float(getdvar("overtimeTimeLimit"));
		if(!isdefined(var_00))
		{
			var_00 = 1;
		}

		return var_00;
	}
	else if(isdefined(level.var_2D64) && level.var_2D64 == 1 && isdefined(level.agent_definition) && level.agent_definition == 1 && isdefined(level.var_3992))
	{
		return func_471A("timelimit") + 2 * level.var_3992;
	}
	else if(level.var_3FDC == "onevone" && isdefined(level.var_9B7))
	{
		return func_471A("timelimit") + level.var_9B7;
	}
	else if(level.var_3FDC == "ctf" && isdefined(level.basefontscale) && level.basefontscale && isdefined(level.var_3992))
	{
		return func_471A("timelimit") + 2 * level.var_3992;
	}

	return func_471A("timelimit");
}

//Function Number: 151
func_4502()
{
	if(func_5380())
	{
		return 0;
	}

	return func_471A("halftime");
}

//Function Number: 152
func_5380()
{
	return isdefined(game["status"]) && func_576C(game["status"]);
}

//Function Number: 153
func_576C(param_00)
{
	return param_00 == "overtime" || param_00 == "overtime_halftime";
}

//Function Number: 154
func_3FA6()
{
	if(isdefined(level.var_3FA6))
	{
		return level.var_3FA6;
	}

	if(level.var_984D)
	{
		return level.var_4B96["axis"] && level.var_4B96["allies"];
	}

	return level.var_6094 > 1;
}

//Function Number: 155
func_442E(param_00)
{
	var_01 = (0,0,0);
	if(!param_00.size)
	{
		return undefined;
	}

	foreach(var_03 in param_00)
	{
		var_01 = var_01 + var_03.var_116;
	}

	var_05 = int(var_01[0] / param_00.size);
	var_06 = int(var_01[1] / param_00.size);
	var_07 = int(var_01[2] / param_00.size);
	var_01 = (var_05,var_06,var_07);
	return var_01;
}

//Function Number: 156
func_455E(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_744A)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(level.var_984D && isdefined(param_00))
		{
			if(param_00 == var_03.var_12C["team"])
			{
				var_01[var_01.size] = var_03;
			}

			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 157
func_8A5B(param_00)
{
	if(isdefined(self.var_2015))
	{
		self.var_2015.var_18 = 0;
	}

	self.var_A25C = param_00;
	common_scripts\utility::func_600();
	self notify("using_remote");
}

//Function Number: 158
func_4664()
{
	return self.var_A25C;
}

//Function Number: 159
func_3E8E(param_00)
{
	if(isdefined(level.var_4E09))
	{
		self freezecontrols(1);
		return;
	}

	self freezecontrols(param_00);
	self.var_260C = param_00;
}

//Function Number: 160
func_3E8F(param_00)
{
	if(!param_00)
	{
		self method_84CB();
		self method_8324();
	}
	else
	{
		self method_84CC();
		self method_8325();
	}

	self allowmovement(param_00);
	self allowjump(param_00);
	self method_812B(param_00);
	self method_86CD(1,param_00,param_00);
	self method_8114(1);
	self method_8113(1);
	self method_812A(param_00);
	self method_8307(param_00);
	if(!_hasexperimentalbtperk("specialty_class_snowblind"))
	{
		self allowads(1);
	}

	self.var_260C = !param_00;
}

//Function Number: 161
func_3E90(param_00,param_01)
{
	wait(param_01);
	if(isdefined(self))
	{
		func_3E8E(param_00);
	}
}

//Function Number: 162
func_2414()
{
	if(isdefined(self.var_2015))
	{
		self.var_2015.var_18 = 1;
	}

	self.var_A25C = undefined;
	common_scripts\utility::func_614();
	var_00 = self getcurrentweapon();
	if(var_00 == "none" || func_5740(var_00))
	{
		self switchtoweapon(common_scripts\utility::func_4550());
	}

	func_3E8E(0);
	func_7441();
	self notify("stopped_using_remote");
}

//Function Number: 163
func_7440()
{
	self setclientomnvar("ui_killstreak_remote",1);
}

//Function Number: 164
func_7441()
{
	self setclientomnvar("ui_killstreak_remote",0);
}

//Function Number: 165
func_43D1()
{
	if(isdefined(self.var_A01A))
	{
		if(self.var_A01A == "shallow" && isdefined(level.var_8ACF))
		{
			return level.var_8ACF;
		}

		if(self.var_A01A == "deep" && isdefined(level.var_2B7C))
		{
			return level.var_2B7C;
		}

		if(self.var_A01A != "none" && isdefined(level.var_8ACF))
		{
			return level.var_8ACF;
		}
	}

	return "none";
}

//Function Number: 166
func_4739(param_00,param_01)
{
	if(!func_7A69() || func_761E())
	{
		return 0;
	}

	if(isdefined(param_00) && isdefined(param_01) && isplayer(param_00) && func_5699(param_01) || func_569A(param_01))
	{
		var_02 = param_00 getrankedplayerdata(common_scripts\utility::func_46AE(),"weaponStats",func_45B5(param_01),"prestigeLevel");
		var_03 = param_00 getrankedplayerdata(common_scripts\utility::func_46AE(),"weaponStats",func_45B5(param_01),"kills");
		return getweaponreputation(var_03,var_02);
	}

	return 0;
}

//Function Number: 167
func_581D()
{
	return isdefined(self.var_A25C);
}

//Function Number: 168
func_572D()
{
	return isdefined(self.var_7C67);
}

//Function Number: 169
func_57B0()
{
	return isdefined(self.var_57B0) && self.var_57B0;
}

//Function Number: 170
func_6F74(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		level endon(param_02);
	}

	if(isdefined(level.var_744A))
	{
		common_scripts\utility::func_FB2(level.var_744A,param_00,param_01);
	}

	if(isdefined(level.var_596C))
	{
		common_scripts\utility::func_FB2(level.var_596C,param_00,param_01);
	}

	for(;;)
	{
		level waittill("connected",var_03);
		common_scripts\utility::func_FB2([var_03],param_00,param_01);
	}
}

//Function Number: 171
safe_str(param_00)
{
	if(isdefined(param_00))
	{
		return "" + param_00;
	}

	return "<undefined>";
}

//Function Number: 172
print3d_lines(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_02))
	{
		param_02 = (1,1,1);
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = "";
	foreach(var_08 in param_01)
	{
		var_06 = var_06 + "\n";
	}
}

//Function Number: 173
func_9466(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = " ";
	}

	var_02 = "";
	var_03 = "";
	foreach(var_05 in param_00)
	{
		var_02 = var_02 + var_03 + var_05;
		var_03 = param_01;
	}

	return var_02;
}

//Function Number: 174
func_5DC8()
{
	var_00 = spawnstruct();
	var_00.var_5C = 0;
	return var_00;
}

//Function Number: 175
func_5DC6(param_00)
{
	var_01 = spawnstruct();
	var_01.var_A281 = param_00;
	if(!isdefined(self.var_95BE))
	{
		self.color = var_01;
		self.var_95BE = var_01;
	}
	else
	{
		self.var_95BE.var_66A1 = var_01;
		self.var_95BE = var_01;
	}

	self.var_5C++;
}

//Function Number: 176
func_5DCA()
{
	if(!isdefined(self.color))
	{
		return undefined;
	}

	if(self.color == self.var_95BE)
	{
		var_00 = self.color.var_A281;
		self.color = undefined;
		self.var_95BE = undefined;
		self.var_5C = 0;
		return var_00;
	}

	var_00 = self.color.var_A281;
	self.color = self.color.var_66A1;
	self.var_5C--;
	return var_00;
}

//Function Number: 177
func_5DC9()
{
	if(!isdefined(self.color))
	{
		return undefined;
	}

	return self.color.var_A281;
}

//Function Number: 178
func_5DCB()
{
	return self.var_5C;
}

//Function Number: 179
func_5DC7()
{
	var_00 = self.var_5C;
	for(var_01 = self.color;var_00;var_01 = var_02)
	{
		var_02 = var_01.var_66A1;
		var_01.var_66A1 = undefined;
		var_01.var_A281 = undefined;
		var_01 = undefined;
		var_00 = var_00 - 1;
	}

	self.var_5C = 0;
	self.color = undefined;
	self.var_95BE = undefined;
}

//Function Number: 180
func_5DCC()
{
	var_00 = [];
	var_01 = 0;
	var_02 = self.color;
	while(isdefined(var_02))
	{
		var_00[var_01] = var_02.var_A281;
		var_01++;
		var_02 = var_02.var_66A1;
	}

	return var_00;
}

//Function Number: 181
func_06D4(param_00,param_01)
{
	if(isplayer(self))
	{
		maps\mp\gametypes\_divisions::updatedivisionusagestats();
		self.divisionusageindex = param_01;
		self setloadoutdivision(param_01);
		self.var_305A = gettime();
	}

	self.var_79 = param_01;
}

//Function Number: 182
func_0642(param_00,param_01,param_02,param_03)
{
	if(issubstr(param_00,"alt") == 0)
	{
		param_00 = func_922B(param_00);
	}

	if(issubstr(param_00,"+akimbo") || isdefined(param_01) && param_01 == 1)
	{
		if(function_01EF(self))
		{
			self giveweapon(param_00,1,0);
			return;
		}

		self giveweapon(param_00,1,0,self,param_02,param_03);
		return;
	}

	if(function_01EF(self))
	{
		self giveweapon(param_00,0,0);
		return;
	}

	self giveweapon(param_00,0,0,self,param_02,param_03);
}

//Function Number: 183
func_4604()
{
	if(func_585F())
	{
		return "mp/zombiePerkTable.csv";
	}

	return "mp/perktable.csv";
}

//Function Number: 184
isdivisionsglobaloverhaulenabled()
{
	return getdvarint("divisionsGlobalOverhaul",1) == 1;
}

//Function Number: 185
areexperimentalbasictrainingsenabled()
{
	return getdvarint("6015",0) == 1;
}

//Function Number: 186
func_0649(param_00)
{
	if(!func_585F() && maps\mp\perks\_perkfunctions::isspecialistperk(param_00) && !maps\mp\perks\_perkfunctions::hasspecialistperkunlocked(param_00))
	{
		return 0;
	}

	if(!func_585F() && maps\mp\perks\_perkfunctions::isclassifiedsecondbt(param_00) && !maps\mp\perks\_perkfunctions::hasclassifiedsecondbt())
	{
		return 0;
	}

	if(isdefined(self.var_6F65) && isdefined(self.var_6F65[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 187
_hasexperimentalbtperk(param_00)
{
	if(areexperimentalbasictrainingsenabled())
	{
		return func_0649(param_00);
	}

	return 0;
}

//Function Number: 188
func_47A3(param_00,param_01)
{
	if(issubstr(param_00,"_mp"))
	{
		func_0642(param_00);
		self givestartammo(param_00);
		func_06D7(param_00,1);
		return;
	}

	if(issubstr(param_00,"specialty_weapon_"))
	{
		func_06D7(param_00,1);
		return;
	}

	if(function_030D(param_00))
	{
		param_00 = func_452B(param_00);
	}

	func_06D7(param_00,1,param_01);
}

//Function Number: 189
func_47A2(param_00)
{
	if(issubstr(param_00,"_mp"))
	{
		func_0642(param_00);
		self givestartammo(param_00);
		func_06D7(param_00,0);
		return;
	}

	if(issubstr(param_00,"specialty_weapon_"))
	{
		func_06D7(param_00,0);
		return;
	}

	if(function_030D(param_00))
	{
		param_00 = func_452B(param_00);
	}

	func_06D7(param_00,0);
}

//Function Number: 190
func_06D7(param_00,param_01,param_02)
{
	self.var_6F65[param_00] = 1;
	self.var_6F6A[param_00] = param_01;
	if(isdefined(level.var_6F68[param_00]))
	{
		self thread [[ level.var_6F68[param_00] ]]();
	}

	if(isdefined(param_02))
	{
		self setperk(param_00,!isdefined(level.var_8324[param_00]),param_01,param_02);
		return;
	}

	self setperk(param_00,!isdefined(level.var_8324[param_00]),param_01);
}

//Function Number: 191
func_0735(param_00)
{
	self.var_6F65[param_00] = undefined;
	self.var_6F6A[param_00] = undefined;
	if(isdefined(level.var_6F6C[param_00]))
	{
		self thread [[ level.var_6F6C[param_00] ]]();
	}

	self unsetperk(param_00,!isdefined(level.var_8324[param_00]));
}

//Function Number: 192
func_05E4()
{
	foreach(var_02, var_01 in self.var_6F65)
	{
		if(isdefined(level.var_6F6C[var_02]))
		{
			self [[ level.var_6F6C[var_02] ]]();
		}
	}

	self.var_6F65 = [];
	self.var_6F6A = [];
	self method_82AB();
}

//Function Number: 193
func_1F50(param_00)
{
	return func_05DE(param_00);
}

//Function Number: 194
func_05DE(param_00)
{
	if(!isdefined(level.var_83D) || !isdefined(level.var_83D[param_00]))
	{
		return 1;
	}

	return self [[ level.var_83D[param_00] ]]();
}

//Function Number: 195
func_476E(param_00,param_01)
{
	func_06CF(param_00,param_01);
}

//Function Number: 196
func_06CF(param_00,param_01)
{
	self.var_83B[param_00] = 1;
	if(isplayer(self))
	{
		if(isdefined(level.var_841[param_00]))
		{
			self thread [[ level.var_841[param_00] ]]();
		}
	}

	self setperk(param_00,!isdefined(level.var_82EE[param_00]),param_01);
}

//Function Number: 197
func_0734(param_00)
{
	self.var_83B[param_00] = undefined;
	if(isplayer(self))
	{
		if(isdefined(level.var_842[param_00]))
		{
			self thread [[ level.var_842[param_00] ]]();
		}
	}

	self unsetperk(param_00,!isdefined(level.var_82EE[param_00]));
}

//Function Number: 198
func_05E1()
{
	if(isplayer(self))
	{
		if(isdefined(level.var_842[self.var_12C["ability"]]))
		{
			self [[ level.var_842[self.var_12C["ability"]] ]]();
		}
	}

	self.var_83B = [];
	self method_82AB();
}

//Function Number: 199
func_0648(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		if(isdefined(self.var_83B[param_00]) && self.var_83B[param_00])
		{
			return 1;
		}
	}
	else if(isdefined(self.var_12C["ability"]) && self.var_12C["ability"] == param_00 && isdefined(self.var_12C["abilityOn"]) && self.var_12C["abilityOn"])
	{
		return 1;
	}

	return 0;
}

//Function Number: 200
func_0728()
{
	if(func_581D() && !function_02D2(self))
	{
		thread maps\mp\gametypes\_damage::func_7418(self,self,self,10000,"MOD_SUICIDE","frag_grenade_mp",(0,0,0),"none",0,1116,1);
		return;
	}

	if(!func_581D() && !function_02D2(self))
	{
		self suicide();
	}
}

//Function Number: 201
func_57A0(param_00)
{
	if(isalive(param_00) && !function_02D2(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 202
func_A71C(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	if(isdefined(param_01))
	{
		thread common_scripts\utility::func_A75E(param_01,var_06);
	}

	if(isdefined(param_02))
	{
		thread common_scripts\utility::func_A75E(param_02,var_06);
	}

	if(isdefined(param_03))
	{
		thread common_scripts\utility::func_A75E(param_03,var_06);
	}

	if(isdefined(param_04))
	{
		thread common_scripts\utility::func_A75E(param_04,var_06);
	}

	if(isdefined(param_05))
	{
		thread common_scripts\utility::func_A75E(param_05,var_06);
	}

	var_06 thread func_0731(param_00,self);
	var_06 waittill("returned",var_07);
	var_06 notify("die");
	return var_07;
}

//Function Number: 203
func_0731(param_00,param_01)
{
	self endon("die");
	var_02 = 0.05;
	while(param_00 > 0)
	{
		if(isplayer(param_01) && !func_57A0(param_01))
		{
			param_01 waittill("spawned_player");
		}

		if(getdvarint("ui_inprematch"))
		{
			level waittill("prematch_over");
		}

		wait(var_02);
		param_00 = param_00 - var_02;
	}

	self notify("returned","timeout");
}

//Function Number: 204
func_7210(param_00,param_01)
{
	if(isdefined(level.var_2980))
	{
		self thread [[ level.var_2980 ]]();
		return;
	}

	if(isdefined(self.var_18A8))
	{
		if(self.var_1A7 == "axis")
		{
			if(self method_843D())
			{
				var_02 = randomintrange(1,4);
				if(isdefined(param_00) && param_00 == "MOD_BURNED" || param_00 == "MOD_BURNED_OVER_TIME")
				{
					var_03 = lib_0380::func_6842("flame_death_enemy_fm_" + var_02,undefined,self.var_18A8.var_116);
					return;
				}

				if(isdefined(param_01) && param_01 == "MOD_MELEE" && issubstr(var_02,"bayonet"))
				{
					var_03 = lib_0380::func_2889("bayo_death_enemy_fm_" + var_03,undefined,self.var_18A8.var_116);
					return;
				}

				if(isdefined(self.var_5D9F) && self.var_5D9F == 1)
				{
					var_03 = lib_0380::func_6842("lingering_death_enemy_fm_" + var_03,undefined,self.var_18A8.var_116);
					return;
				}

				var_03 = lib_0380::func_6842("generic_death_enemy_fm_" + var_03,undefined,self.var_18A8.var_116);
				return;
			}

			var_02 = randomintrange(1,7);
			if(isdefined(param_01) && param_01 == "MOD_BURNED" || param_01 == "MOD_BURNED_OVER_TIME")
			{
				var_03 = lib_0380::func_6842("flame_death_enemy_" + var_03,undefined,self.var_18A8.var_116);
				return;
			}

			if(isdefined(param_01) && param_01 == "MOD_MELEE" && issubstr(var_02,"bayonet"))
			{
				var_03 = lib_0380::func_2889("bayo_death_enemy_" + var_03,undefined,self.var_18A8.var_116);
				return;
			}

			if(isdefined(self.var_5D9F) && self.var_5D9F == 1)
			{
				var_03 = lib_0380::func_6842("lingering_death_enemy_" + var_03,undefined,self.var_18A8.var_116);
				return;
			}

			var_03 = lib_0380::func_6842("generic_death_enemy_" + var_03,undefined,self.var_18A8.var_116);
			return;
		}

		if(self method_843D())
		{
			var_02 = randomintrange(1,4);
			if(isdefined(param_01) && param_01 == "MOD_BURNED" || param_01 == "MOD_BURNED_OVER_TIME")
			{
				var_03 = lib_0380::func_6842("flame_death_friendly_fm_" + var_03,undefined,self.var_18A8.var_116);
				return;
			}

			if(isdefined(param_01) && param_01 == "MOD_MELEE" && issubstr(var_02,"bayonet"))
			{
				var_03 = lib_0380::func_2889("bayo_death_friendly_fm_" + var_03,undefined,self.var_18A8.var_116);
				return;
			}

			if(isdefined(self.var_5D9F) && self.var_5D9F == 1)
			{
				var_03 = lib_0380::func_6842("lingering_death_friendly_fm_" + var_03,undefined,self.var_18A8.var_116);
				return;
			}

			var_03 = lib_0380::func_6842("generic_death_friendly_fm_" + var_03,undefined,self.var_18A8.var_116);
			return;
		}

		var_02 = randomintrange(1,7);
		if(isdefined(param_01) && param_01 == "MOD_BURNED" || param_01 == "MOD_BURNED_OVER_TIME")
		{
			var_03 = lib_0380::func_6842("flame_death_friendly_" + var_03,undefined,self.var_18A8.var_116);
			return;
		}

		if(isdefined(param_01) && param_01 == "MOD_MELEE" && issubstr(var_02,"bayonet"))
		{
			var_03 = lib_0380::func_2889("bayo_death_friendly_" + var_03,undefined,self.var_18A8.var_116);
			return;
		}

		if(isdefined(self.var_5D9F) && self.var_5D9F == 1)
		{
			var_03 = lib_0380::func_6842("lingering_death_friendly_" + var_03,undefined,self.var_18A8.var_116);
			return;
		}

		var_03 = lib_0380::func_6842("generic_death_friendly_" + var_03,undefined,self.var_18A8.var_116);
		return;
	}
}

//Function Number: 205
func_7A69()
{
	if(!isplayer(self))
	{
		return 0;
	}

	return (level.var_7A67 && !self.var_A25B) || function_0367() && !function_0371() && !issplitscreen() && !function_02A4();
}

//Function Number: 206
func_773F()
{
	return !level.var_6B4D || function_0371();
}

//Function Number: 207
func_602B()
{
	return level.var_6B4D && !function_0371();
}

//Function Number: 208
func_761E()
{
	return level.var_7616;
}

//Function Number: 209
func_8626(param_00,param_01,param_02,param_03)
{
}

//Function Number: 210
func_36E4(param_00)
{
	self endon("altscene");
	param_00 waittill("death");
	self notify("end_altScene");
}

//Function Number: 211
func_4571()
{
	return getdvar("1673");
}

//Function Number: 212
func_44FC()
{
	return func_471A("numlives");
}

//Function Number: 213
func_0FBD(param_00,param_01,param_02)
{
	if(param_00.size != 0)
	{
		for(var_03 = param_00.size;var_03 >= param_02;var_03--)
		{
			param_00[var_03 + 1] = param_00[var_03];
		}
	}

	param_00[param_02] = param_01;
}

//Function Number: 214
func_463A(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvar(param_00,param_01);
	return var_02;
}

//Function Number: 215
func_4529(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvarint(param_00,param_01);
	return var_02;
}

//Function Number: 216
func_44E8(param_00,param_01)
{
	var_02 = param_01;
	var_02 = getdvarfloat(param_00,param_01);
	return var_02;
}

//Function Number: 217
func_56A8()
{
	return isdefined(self.var_20CC);
}

//Function Number: 218
func_5A54(param_00)
{
	return 1;
}

//Function Number: 219
func_5740(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "none")
	{
		return 0;
	}

	if(func_56C4(param_00))
	{
		return 0;
	}

	if(func_568F(param_00) || isuseweapon(param_00))
	{
		return 0;
	}

	if(issubstr(param_00,"killstreak"))
	{
		return 1;
	}

	if(param_00 == "p51_cannon")
	{
		return 0;
	}

	param_00 = func_4431(param_00);
	if(param_00 == "airdrop_sentry_marker_mp")
	{
		return 1;
	}

	if(param_00 == "teslagun_war_moon_mp" || param_00 == "war_super_soldier_syrum_purple_mp" || param_00 == "war_super_soldier_syrum_green_mp" || param_00 == "war_super_soldier_syrum_mp" || param_00 == "war_super_soldier_syrum_orange_mp" || param_00 == "war_sword_mp")
	{
		return 1;
	}

	if(isdefined(level.var_5A7D) && isdefined(level.var_5A7D[param_00]))
	{
		return 1;
	}

	var_01 = function_01D4(param_00);
	if(isdefined(var_01) && var_01 == "exclusive")
	{
		return 1;
	}

	return 0;
}

//Function Number: 220
func_56C4(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "barrel_mp":
		case "destructible":
		case "destructible_car":
		case "destructible_toy":
			return 1;
	}

	return 0;
}

//Function Number: 221
func_5705()
{
	if(func_551F())
	{
		return 0;
	}

	return getdvarint("scr_game_grappling_hook",0);
}

//Function Number: 222
func_571D()
{
	return getdvarint("scr_game_increased_clients",0);
}

//Function Number: 223
func_568F(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "bomb_site_mp":
		case "search_dstry_bomb_defuse_mp":
		case "search_dstry_bomb_mp":
			return 1;
	}

	return 0;
}

//Function Number: 224
isuseweapon(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "wrench_disassemble_dig_zm":
		case "explosives_dig_zm":
		case "war_generic_open_mp":
		case "war_rope_untie_mp":
		case "war_dynamite_disarm_mp":
		case "war_wrench_assemble_mp":
		case "war_generic_assemble_mp":
		case "war_bangalore_mp":
		case "war_hammer_assemble_mp":
		case "war_dynamite_mp":
		case "search_dstry_bomb_defuse_mp":
		case "search_dstry_bomb_mp":
			return 1;
	}

	return 0;
}

//Function Number: 225
func_56DF(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "turret_minigun_mp")
	{
		return 1;
	}

	if(issubstr(param_00,"_bipod_"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 226
func_5856(param_00)
{
	if(issubstr(param_00,"loot"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 227
func_5857(param_00)
{
	if(param_00 == 0)
	{
		return 0;
	}

	var_01 = getitemreffromguid(param_00);
	return func_5856(var_01);
}

//Function Number: 228
func_4738(param_00)
{
	return strtok(param_00,"+");
}

//Function Number: 229
func_4730(param_00,param_01)
{
	var_02 = func_4738(param_00);
	for(var_03 = 1;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(!func_5679(var_04) && issubstr(var_04,param_01))
		{
			return var_04;
		}
	}

	return "";
}

//Function Number: 230
func_4728(param_00)
{
	return func_4730(param_00,"camo");
}

//Function Number: 231
func_472B(param_00)
{
	return func_4730(param_00,"cond");
}

//Function Number: 232
func_473A(param_00)
{
	return func_4730(param_00,"scope");
}

//Function Number: 233
func_472F(param_00)
{
	return func_4730(param_00,"cust");
}

//Function Number: 234
func_472A(param_00,param_01)
{
	if(param_00 == "p51_cannon")
	{
		return "none";
	}

	var_02 = func_4431(param_00);
	var_03 = tablelookup("mp/statstable.csv",2,var_02,0);
	if(var_03 == "")
	{
		var_03 = tablelookup("mp/statstable.csv",2,param_00,0);
	}

	if(func_56DF(param_00))
	{
		var_03 = "weapon_mg";
	}
	else if(!common_scripts\utility::func_562E(param_01) && func_5740(param_00))
	{
		var_03 = "killstreak";
	}
	else if(param_00 == "none")
	{
		var_03 = "other";
	}
	else if(var_03 == "")
	{
		var_03 = "other";
	}

	return var_03;
}

//Function Number: 235
func_4723(param_00)
{
	return function_0060(param_00);
}

//Function Number: 236
func_4431(param_00,param_01)
{
	var_02 = strtok(param_00,"+");
	var_03 = "";
	if(var_02[0] == "alt")
	{
		var_03 = var_02[1];
	}
	else
	{
		var_03 = var_02[0];
	}

	if(isdefined(param_01) && param_01 == 1)
	{
		var_04 = tablelookup("mp/statstable.csv",2,var_03,28);
		if(var_04 != "")
		{
			return var_04;
		}
	}

	return var_03;
}

//Function Number: 237
func_45B5(param_00)
{
	var_01 = func_4431(param_00);
	if(func_5856(var_01))
	{
		var_01 = maps\mp\gametypes\_class::func_4432(var_01);
	}

	return var_01;
}

//Function Number: 238
func_74D8(param_00,param_01)
{
	playsoundatpos(param_01,param_00);
}

//Function Number: 239
func_5D7F(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 2;
	}

	var_02 = 1;
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		var_02 = var_02 * 10;
	}

	var_04 = param_00 * var_02;
	var_04 = int(var_04);
	var_04 = var_04 / var_02;
	return var_04;
}

//Function Number: 240
func_73E2(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		if(var_02.var_2418 == param_00)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 241
func_871E(param_00)
{
	self makeusable();
	foreach(var_02 in level.var_744A)
	{
		if(var_02 != param_00)
		{
			self disableplayeruse(var_02);
			continue;
		}

		self enableplayeruse(var_02);
	}
}

//Function Number: 242
func_A18D(param_00)
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("connected",var_01);
		self disableplayeruse(var_01);
	}
}

//Function Number: 243
func_871D()
{
	self makeunusable();
	foreach(var_01 in level.var_744A)
	{
		self disableplayeruse(var_01);
	}
}

//Function Number: 244
func_5FBD(param_00)
{
	self makeusable();
	thread func_073A(param_00);
}

//Function Number: 245
func_073A(param_00)
{
	self endon("death");
	self notify("stop_usable_update");
	self endon("stop_usable_update");
	for(;;)
	{
		foreach(var_02 in level.var_744A)
		{
			if(var_02.var_1A7 == param_00)
			{
				self enableplayeruse(var_02);
				continue;
			}

			self disableplayeruse(var_02);
		}

		level waittill("joined_team");
	}
}

//Function Number: 246
earlyendon(param_00)
{
	self makeusable();
	thread func_0737(param_00);
}

//Function Number: 247
func_0737(param_00)
{
	self endon("death");
	var_01 = param_00.var_1A7;
	for(;;)
	{
		if(level.var_984D)
		{
			foreach(var_03 in level.var_744A)
			{
				if(var_03.var_1A7 != var_01)
				{
					self enableplayeruse(var_03);
					continue;
				}

				self disableplayeruse(var_03);
			}
		}
		else
		{
			foreach(var_03 in level.var_744A)
			{
				if(var_03 != param_00)
				{
					self enableplayeruse(var_03);
					continue;
				}

				self disableplayeruse(var_03);
			}
		}

		level waittill("joined_team");
	}
}

//Function Number: 248
func_45AD(param_00)
{
	var_01 = getmatchdata("match_common","life_count");
	if(var_01 < level.var_608B)
	{
		setmatchdata("match_common","life_count",var_01 + 1);
		level.var_5CC7[var_01] = gettime();
		return var_01;
	}

	return level.var_608B - 1;
}

//Function Number: 249
func_52BE()
{
	if(!isdefined(game["flags"]))
	{
		game["flags"] = [];
	}
}

//Function Number: 250
func_3FA3(param_00,param_01)
{
	game["flags"][param_00] = param_01;
}

//Function Number: 251
func_3FA2(param_00)
{
	return isdefined(game["flags"]) && isdefined(game["flags"][param_00]);
}

//Function Number: 252
func_3FA0(param_00)
{
	return game["flags"][param_00];
}

//Function Number: 253
func_3FA4(param_00)
{
	game["flags"][param_00] = 1;
	level notify(param_00);
}

//Function Number: 254
func_3FA1(param_00)
{
	game["flags"][param_00] = 0;
}

//Function Number: 255
func_3FA5(param_00)
{
	while(!func_3FA0(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 256
func_5694(param_00)
{
	var_01 = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";
	if(issubstr(var_01,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 257
func_56F8(param_00,param_01,param_02)
{
	return isdefined(param_02) && isplayer(param_02) && (param_02 func_0649("specialty_bulletpenetration") || param_02 func_0649("specialty_superbulletpenetration")) && isdefined(param_01) && func_5694(param_01);
}

//Function Number: 258
func_5315()
{
	if(!isdefined(level.var_5CBD))
	{
		level.var_5CBD = [];
	}
}

//Function Number: 259
func_5CBC(param_00,param_01)
{
	level.var_5CBD[param_00] = param_01;
}

//Function Number: 260
func_5CBA(param_00)
{
	return level.var_5CBD[param_00];
}

//Function Number: 261
func_5CBE(param_00)
{
	level.var_5CBD[param_00] = 1;
	level notify(param_00);
}

//Function Number: 262
func_5CBB(param_00)
{
	level.var_5CBD[param_00] = 0;
	level notify(param_00);
}

//Function Number: 263
func_5CBF(param_00)
{
	while(!func_5CBA(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 264
func_5CC0(param_00)
{
	while(func_5CBA(param_00))
	{
		level waittill(param_00);
	}
}

//Function Number: 265
func_551F()
{
	if(!isdefined(level.var_A559) || level.var_A559 == 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 266
func_5716(param_00)
{
	if(param_00 == "emote_weapon_mp" || param_00 == "boxing_gloves_hub_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 267
func_573D()
{
	if(func_551F())
	{
		return 0;
	}

	return func_56D7() || func_5668();
}

//Function Number: 268
func_56D7()
{
	if(self.var_1A7 == "spectator")
	{
		return 0;
	}

	if(func_551F())
	{
		return 0;
	}

	if(level.var_984D)
	{
		return (isdefined(level.var_9852) && level.var_9852[self.var_1A7]) || isdefined(self.var_35F1) && self.var_35F1;
	}

	return (isdefined(level.var_35F6) && level.var_35F6 != self) || isdefined(self.var_35F1) && self.var_35F1;
}

//Function Number: 269
func_56D8()
{
	if(self.var_1A7 == "spectator")
	{
		return 0;
	}

	if(func_551F())
	{
		return 0;
	}

	if(level.var_984D)
	{
		return level.var_9852[self.var_1A7];
	}

	return isdefined(level.var_35F6) && level.var_35F6 != self;
}

//Function Number: 270
func_5668(param_00,param_01)
{
	var_02 = self.var_1A7;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	if((level.var_984D && isdefined(level.var_9854) && isdefined(var_02) && isdefined(level.var_9854[var_02]) && level.var_9854[var_02]) || !level.var_984D && isdefined(level.var_3CE0) && level.var_3CE0 != self)
	{
		if(!isdefined(param_00) || param_00)
		{
			self iclientprintlnbold(&"KILLSTREAKS_FLAK_GUN_ACTIVE");
		}

		return 1;
	}

	return 0;
}

//Function Number: 271
func_5814(param_00,param_01)
{
	var_02 = self.var_1A7;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	if((level.var_984D && isdefined(level.var_9850) && level.var_9850[var_02]) || !level.var_984D && isdefined(level.var_2694) && level.var_2694 != self)
	{
		if(!isdefined(param_00) || param_00)
		{
			self iclientprintlnbold(&"KILLSTREAKS_COUNTER_RECON_ACTIVE");
		}

		return 1;
	}

	return 0;
}

//Function Number: 272
func_575F()
{
	if(self.var_1A7 == "spectator")
	{
		return 0;
	}

	return isdefined(self.var_6857);
}

//Function Number: 273
func_4621(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		if(var_02.var_48CA == param_00)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 274
func_9863(param_00,param_01,param_02,param_03)
{
	if(level.var_4B17)
	{
		return;
	}

	foreach(var_05 in level.var_744A)
	{
		if(!isdefined(var_05))
		{
			continue;
		}

		if(isdefined(param_02) && !isdefined(var_05.var_1A7) || var_05.var_1A7 != param_02)
		{
			continue;
		}

		if(!isplayer(var_05))
		{
			continue;
		}

		var_05 thread maps\mp\gametypes\_hud_message::func_73C2(param_00,param_01,param_03);
	}
}

//Function Number: 275
func_5699(param_00)
{
	switch(func_472A(param_00))
	{
		case "weapon_special":
		case "weapon_heavy":
		case "weapon_shotgun":
		case "weapon_lmg":
		case "weapon_sniper":
		case "weapon_riot":
		case "weapon_assault":
		case "weapon_smg":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 276
func_569A(param_00)
{
	switch(func_472A(param_00))
	{
		case "weapon_other":
		case "weapon_sec_special":
		case "weapon_machine_pistol":
		case "weapon_pistol":
		case "weapon_knife":
		case "weapon_projectile":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 277
func_454F(param_00)
{
	var_01 = undefined;
	foreach(var_03 in level.var_744A)
	{
		if(isdefined(param_00) && var_03.var_1A7 != param_00)
		{
			continue;
		}

		if(!func_57A0(var_03) && !var_03 maps\mp\gametypes\_playerlogic::func_60B2())
		{
			continue;
		}

		var_01 = var_03;
	}

	return var_01;
}

//Function Number: 278
func_4630()
{
	var_00 = [];
	foreach(var_02 in level.var_744A)
	{
		if(!func_57A0(var_02) && !var_02 maps\mp\gametypes\_playerlogic::func_60B2())
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 279
func_A78E(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	var_02 = 0;
	if(!isdefined(param_01))
	{
		param_01 = 0.05;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	for(;;)
	{
		if(self.var_BC != self.var_FB)
		{
			var_02 = 0;
		}
		else
		{
			var_02 = var_02 + param_01;
		}

		wait(param_01);
		if(self.var_BC == self.var_FB && var_02 >= param_00)
		{
			break;
		}
	}
}

//Function Number: 280
func_1151(param_00,param_01)
{
	var_02 = param_00;
	if(isdefined(param_00))
	{
		param_01 = func_4431(param_01,1);
		if(func_5856(param_01))
		{
			param_01 = maps\mp\gametypes\_class::func_4432(param_01);
		}

		if(isdefined(level.var_114F[param_01]) && isdefined(level.var_114F[param_01][param_00]))
		{
			var_02 = level.var_114F[param_01][param_00];
		}
		else
		{
			var_03 = tablelookup("mp/statstable.csv",2,param_01,0);
			if(isdefined(level.var_114F[var_03]) && isdefined(level.var_114F[var_03][param_00]))
			{
				var_02 = level.var_114F[var_03][param_00];
			}
		}
	}

	return var_02;
}

//Function Number: 281
func_1153(param_00)
{
	var_01 = undefined;
	if(isdefined(level.var_114E[param_00]))
	{
		var_01 = level.var_114E[param_00];
	}

	return var_01;
}

//Function Number: 282
func_567A(param_00,param_01)
{
	var_02 = strtok(param_00,"_");
	return func_567B(var_02,param_01);
}

//Function Number: 283
func_567B(param_00,param_01)
{
	var_02 = 0;
	if(param_00.size && isdefined(param_01))
	{
		var_03 = 0;
		if(param_00[0] == "alt")
		{
			var_03 = 1;
		}

		if(param_00.size >= 3 + var_03 && param_00[var_03] == "iw5" || param_00[var_03] == "iw6")
		{
			if(function_01AA(param_00[var_03] + "_" + param_00[var_03 + 1] + "_" + param_00[var_03 + 2]) == "sniper")
			{
				var_02 = param_00[var_03 + 1] + "scope" == param_01;
			}
		}
	}

	return var_02;
}

//Function Number: 284
func_4725(param_00)
{
	var_01 = function_0061(param_00);
	foreach(var_04, var_03 in var_01)
	{
		var_01[var_04] = func_1150(var_03);
	}

	return var_01;
}

//Function Number: 285
func_4427()
{
	var_00 = [];
	var_01 = 0;
	var_02 = tablelookup("mp/attachmenttable.csv",0,var_01,4);
	while(var_02 != "")
	{
		if(!common_scripts\utility::func_F79(var_00,var_02))
		{
			var_00[var_00.size] = var_02;
		}

		var_01++;
		var_02 = tablelookup("mp/attachmenttable.csv",0,var_01,4);
	}

	return var_00;
}

//Function Number: 286
func_4428()
{
	var_00 = [];
	var_01 = 0;
	var_02 = tablelookup("mp/attachmenttable.csv",0,var_01,3);
	while(var_02 != "")
	{
		var_00[var_00.size] = var_02;
		var_01++;
		var_02 = tablelookup("mp/attachmenttable.csv",0,var_01,3);
	}

	return var_00;
}

//Function Number: 287
func_1D3E()
{
	var_00 = func_4428();
	level.var_1152 = [];
	foreach(var_02 in var_00)
	{
		var_03 = tablelookup("mp/attachmenttable.csv",3,var_02,4);
		if(var_02 == var_03)
		{
			continue;
		}

		level.var_1152[var_02] = var_03;
	}

	var_05 = [];
	var_06 = 1;
	var_07 = tablelookupbyrow("mp/attachmentmap.csv",var_06,0);
	while(var_07 != "")
	{
		var_05[var_05.size] = var_07;
		var_06++;
		var_07 = tablelookupbyrow("mp/attachmentmap.csv",var_06,0);
	}

	var_08 = [];
	var_09 = 1;
	var_0A = tablelookupbyrow("mp/attachmentmap.csv",0,var_09);
	while(var_0A != "")
	{
		var_08[var_0A] = var_09;
		var_09++;
		var_0A = tablelookupbyrow("mp/attachmentmap.csv",0,var_09);
	}

	level.var_114F = [];
	foreach(var_07 in var_05)
	{
		foreach(var_0F, var_0D in var_08)
		{
			var_0E = tablelookup("mp/attachmentmap.csv",0,var_07,var_0D);
			if(var_0E == "")
			{
				continue;
			}

			if(!isdefined(level.var_114F[var_07]))
			{
				level.var_114F[var_07] = [];
			}

			level.var_114F[var_07][var_0F] = var_0E;
		}
	}

	level.var_114E = [];
	foreach(var_12 in var_00)
	{
		var_13 = tablelookup("mp/attachmenttable.csv",3,var_12,8);
		if(var_13 == "")
		{
			continue;
		}

		level.var_114E[var_12] = var_13;
	}
}

//Function Number: 288
func_1150(param_00)
{
	if(isdefined(level.var_1152[param_00]))
	{
		param_00 = level.var_1152[param_00];
	}

	return param_00;
}

//Function Number: 289
func_068B(param_00)
{
	objective_delete(param_00);
	if(!isdefined(level.var_7AD6))
	{
		level.var_7AD6 = [];
		level.var_7AD6[0] = param_00;
		return;
	}

	level.var_7AD6[level.var_7AD6.size] = param_00;
}

//Function Number: 290
func_9AC1()
{
	var_00 = getentarray("trigger_hurt","classname");
	foreach(var_02 in var_00)
	{
		if(self istouching(var_02))
		{
			return 1;
		}
	}

	var_04 = getentarray("radiation","targetname");
	foreach(var_02 in var_04)
	{
		if(self istouching(var_02))
		{
			return 1;
		}
	}

	if(getdvar("1924") == "hp" && isdefined(level.var_AC7C) && isdefined(level.var_AC7C.var_9D5E) && self istouching(level.var_AC7C.var_9D5E))
	{
		return 1;
	}

	if(getdvar("1924") == "undead" && isdefined(level.var_AC7C) && isdefined(level.var_AC7C.var_9D5E) && self istouching(level.var_AC7C.var_9D5E))
	{
		return 1;
	}

	return 0;
}

//Function Number: 291
func_8742(param_00)
{
	if(param_00)
	{
		self setdepthoffield(0,110,512,4096,6,1.8);
		return;
	}

	self setdepthoffield(0,0,512,512,4,0);
}

//Function Number: 292
func_5A81(param_00,param_01,param_02)
{
	var_03 = spawn("trigger_radius",param_00,0,param_01,param_02);
	for(;;)
	{
		var_03 waittill("trigger",var_04);
		if(!isplayer(var_04))
		{
			continue;
		}

		var_04 suicide();
	}
}

//Function Number: 293
func_3B8E(param_00,param_01,param_02)
{
	return findisfacingvectors(param_00.var_116,anglestoforward(param_00.var_1D),param_01.var_116,param_02);
}

//Function Number: 294
findplayerisfacing(param_00,param_01,param_02)
{
	var_03 = distance(param_00 geteye(),param_01.var_116);
	var_04 = param_00 geteye() + var_03 * vectornormalize(anglestoforward(param_00 geteyeangles()));
	return distance(param_01.var_116,var_04) < param_02;
}

//Function Number: 295
findisfacingvectors(param_00,param_01,param_02,param_03)
{
	var_04 = cos(param_03);
	var_05 = param_02 - param_00;
	var_05 = var_05 * (1,1,0);
	var_05 = vectornormalize(var_05);
	param_01 = param_01 * (1,1,0);
	param_01 = vectornormalize(param_01);
	var_06 = vectordot(var_05,param_01);
	return var_06 >= var_04;
}

//Function Number: 296
func_33D8(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_02 * 20);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait 0.05;
	}
}

//Function Number: 297
func_33DF(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_02 * 20);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait 0.05;
	}
}

//Function Number: 298
func_870F(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(self.var_7AD7))
	{
		self.var_7AD7 = param_00;
	}
	else
	{
		self.var_7AD7 = self.var_7AD7 + param_00;
	}

	if(isdefined(param_01))
	{
		if(isdefined(self.var_7AD7) && param_01 < self.var_7AD7)
		{
			param_01 = self.var_7AD7;
		}

		var_02 = 100 - param_01;
	}
	else
	{
		var_02 = 100 - self.var_7AD7;
	}

	if(func_0649("specialty_sessionProgressionC") && isdefined(self.var_12C["sessionProgressionC_Modifier"]))
	{
		var_02 = var_02 * maps\mp\perks\_perkfunctions::getgrenadiermodvalue_c();
	}

	if(isdefined(self.classifiedboostafterreloadactive) && self.classifiedboostafterreloadactive)
	{
		var_02 = var_02 * 50;
	}

	if(isdefined(self.raidbasictrainingbuff) && self.raidbasictrainingbuff)
	{
		var_02 = var_02 * 70;
	}

	if(var_02 < 0)
	{
		var_02 = 0;
	}

	if(var_02 > 100)
	{
		var_02 = 100;
	}

	if(var_02 == 100)
	{
		self method_82E8();
		return;
	}

	self method_82E7(int(var_02));
}

//Function Number: 299
func_2341(param_00)
{
	var_01 = [];
	foreach(var_04, var_03 in param_00)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_01[var_01.size] = param_00[var_04];
	}

	return var_01;
}

//Function Number: 300
func_6819(param_00)
{
	self notify("notusablejoiningplayers");
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	self endon("notusablejoiningplayers");
	for(;;)
	{
		level waittill("player_spawned",var_01);
		if(isdefined(var_01) && var_01 != param_00)
		{
			self disableplayeruse(var_01);
		}
	}
}

//Function Number: 301
func_57E5(param_00,param_01)
{
	return getsubstr(param_00,0,param_01.size) == param_01;
}

//Function Number: 302
func_2F6D()
{
	level.var_5A74 = 1;
}

//Function Number: 303
func_3653()
{
	level.var_5A74 = undefined;
}

//Function Number: 304
func_0F5C()
{
	return !isdefined(level.var_5A74) || !level.var_5A74;
}

//Function Number: 305
func_A27A(param_00,param_01)
{
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}
	else
	{
		var_03 = self.var_12C["killstreaks"];
		var_02 = var_03[self.var_5A69].var_944C;
	}

	if(isdefined(level.var_5A74) && level.var_5A74)
	{
		return 0;
	}

	if(isdefined(self.var_5A74) && self.var_5A74)
	{
		return 0;
	}

	if(getdvarint("scorestreak_enabled_" + var_02) == 0)
	{
		return 0;
	}

	if(!self isonground() && func_57AD(var_02))
	{
		return 0;
	}

	if(func_581D() || func_572D())
	{
		return 0;
	}

	if(isdefined(self.var_83AF))
	{
		return 0;
	}

	if(!func_3FA0("prematch_done"))
	{
		return 0;
	}

	if(func_8BA1(var_02) && level.var_5A70)
	{
		var_04 = 0;
		if(isdefined(level.var_7690))
		{
			var_04 = gettime() - level.var_7690 / 1000;
		}

		if(var_04 < level.var_5A70)
		{
			var_05 = int(level.var_5A70 - var_04 + 0.5);
			if(!var_05)
			{
				var_05 = 1;
			}

			if(!isdefined(param_01) && param_01)
			{
				self iclientprintlnbold(&"MP_UNAVAILABLE_FOR_N",var_05);
			}

			return 0;
		}
	}

	if(func_56D7() && !isdefined(level.var_585D) || !level.var_585D)
	{
		if(!isdefined(var_02) && var_02)
		{
			if(isdefined(level.var_35F7) && level.var_35F7 > 0)
			{
				self iclientprintlnbold(&"MP_UNAVAILABLE_FOR_N_WHEN_EMP",level.var_35F7);
			}
			else if(isdefined(self.var_35EF) && int(self.var_35EF - gettime() / 1000) > 0)
			{
				self iclientprintlnbold(&"MP_UNAVAILABLE_FOR_N",int(self.var_35EF - gettime() / 1000));
			}
		}

		return 0;
	}

	if(self isusingturret() && func_57AD(var_04) || func_56A6(var_04))
	{
		if(!isdefined(var_02) && var_02)
		{
			self iclientprintlnbold(&"MP_UNAVAILABLE_USING_TURRET");
		}

		return 0;
	}

	if(isdefined(self.var_E8) && !func_0649("specialty_finalstand"))
	{
		if(!isdefined(var_02) && var_02)
		{
			self iclientprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
		}

		return 0;
	}

	if(!common_scripts\utility::func_5851())
	{
		return 0;
	}

	return 1;
}

//Function Number: 306
func_57AD(param_00)
{
	return 0;
}

//Function Number: 307
func_56A6(param_00)
{
	switch(param_00)
	{
		case "remote_mg_sentry_turret":
		case "deployable_exp_ammo":
		case "deployable_grenades":
		case "deployable_ammo":
		case "sentry":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 308
func_8BA1(param_00)
{
	switch(param_00)
	{
		case "plane_gunner":
		case "v2_rocket":
		case "fighter_strike":
		case "firebomb":
		case "airstrike":
		case "missile_strike":
		case "mortar_strike":
		case "fritzx":
			return 1;
	}

	return 0;
}

//Function Number: 309
func_3153(param_00)
{
	switch(param_00)
	{
		case "plane_gunner":
		case "v2_rocket":
		case "fighter_strike":
		case "firebomb":
		case "missile_strike":
		case "mortar_strike":
			return 1;
	}

	return 0;
}

//Function Number: 310
func_573A(param_00)
{
	switch(param_00)
	{
		case "refill_grenades":
		case "speed_boost":
		case "eyes_on":
		case "high_value_target":
		case "recon_agent":
		case "agent":
		case "placeable_barrier":
		case "deployable_juicebox":
		case "deployable_grenades":
		case "deployable_ammo":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 311
func_573B(param_00)
{
	return func_573A(param_00) && !func_56F7(param_00);
}

//Function Number: 312
func_56F7(param_00)
{
	switch(param_00)
	{
		case "orbital_strike_drone":
		case "orbital_strike_cluster":
		case "orbital_strike_laser_chem":
		case "orbital_strike_chem":
		case "orbital_strike_laser":
		case "orbital_strike":
		case "orbital_carepackag":
		case "orbitalsupport":
		case "airdrop_support":
		case "airdrop_assault":
		case "airdrop_sentry_minigun":
		case "missile_strike":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 313
func_4545(param_00)
{
	return tablelookuprownum("mp/killstreakTable.csv",1,param_00);
}

//Function Number: 314
func_453F(param_00)
{
	var_01 = tablelookup("mp/killstreakTable.csv",1,param_00,0);
	if(var_01 == "")
	{
		var_02 = -1;
	}
	else
	{
		var_02 = int(var_02);
	}

	return var_02;
}

//Function Number: 315
func_4543(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,1);
}

//Function Number: 316
func_4541(param_00)
{
	return function_01AF("mp/killstreakTable.csv",1,param_00,2);
}

//Function Number: 317
func_4544(param_00)
{
	return tablelookup("mp/killstreakTable.csv",0,param_00,1);
}

//Function Number: 318
func_4534(param_00)
{
	return function_01AF("mp/killstreakTable.csv",1,param_00,3);
}

//Function Number: 319
func_4531(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,4);
}

//Function Number: 320
func_453C(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,5);
}

//Function Number: 321
func_4548(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,6);
}

//Function Number: 322
getkillstreakesportscost(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,33);
}

//Function Number: 323
getkillstreakkills(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,7);
}

//Function Number: 324
getkillstreakhardlinekills(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,8);
}

//Function Number: 325
getkillstreaksupportkills(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,9);
}

//Function Number: 326
func_4538(param_00)
{
	return function_01AF("mp/killstreakTable.csv",1,param_00,10);
}

//Function Number: 327
func_4547(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,11);
}

//Function Number: 328
func_4537(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,12);
}

//Function Number: 329
func_4530(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,13);
}

//Function Number: 330
func_4539(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,14);
}

//Function Number: 331
func_453A(param_00)
{
	return int("mp/killstreakTable.csv",1,param_00,15);
}

//Function Number: 332
func_454A(param_00,param_01,param_02)
{
	var_03 = tablelookup("mp/killstreakTable.csv",1,param_00,16);
	if(func_579B() && common_scripts\utility::func_562E(level.var_79C1))
	{
		param_01 = func_45DE(param_01);
	}

	if(isdefined(param_01) && param_01 == "axis")
	{
		var_04 = tablelookup("mp/killstreakTable.csv",1,param_00,29);
		if(isdefined(var_04) && var_04 != "")
		{
			var_03 = var_04;
		}
	}

	if(isdefined(param_02) && param_02)
	{
		var_05 = tablelookup("mp/killstreakTable.csv",1,param_00,31);
		if(isdefined(var_05) && var_05 != "")
		{
			var_03 = var_05;
		}

		if(isdefined(param_01) && param_01 == "axis")
		{
			var_06 = tablelookup("mp/killstreakTable.csv",1,param_00,32);
			if(isdefined(var_06) && var_06 != "")
			{
				var_03 = var_06;
			}
		}
	}

	return var_03;
}

//Function Number: 333
func_4546(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,17);
}

//Function Number: 334
func_453E(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,18);
}

//Function Number: 335
console(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,19);
}

//Function Number: 336
func_4536(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,23);
}

//Function Number: 337
func_4549(param_00)
{
	return tablelookup("mp/killstreakTable.csv",1,param_00,24);
}

//Function Number: 338
func_2924(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = param_00;
	if(isdefined(level.var_4C9C))
	{
		var_01 = var_01 + level.var_4C9C.size;
	}

	if(isdefined(level.var_7043))
	{
		var_01 = var_01 + level.var_7043.size;
	}

	if(isdefined(level.var_9FEA))
	{
		var_01 = var_01 + level.var_9FEA.size;
	}

	return var_01;
}

//Function Number: 339
func_60A6()
{
	return 8;
}

//Function Number: 340
func_50FD()
{
	level.var_3A62++;
}

//Function Number: 341
func_2B78()
{
	level.var_3A62--;
	if(level.var_3A62 < 0)
	{
		level.var_3A62 = 0;
	}
}

//Function Number: 342
func_0C2D()
{
	if(!function_02BD() && getdvarint("scr_skipclasschoice",0) > 0)
	{
		return 0;
	}

	var_00 = int(tablelookup("mp/gametypesTable.csv",0,level.var_3FDC,4));
	return var_00;
}

//Function Number: 343
func_0C1E()
{
	if(!function_02BD() && getdvarint("scr_skipclasschoice",0) > 0)
	{
		return 0;
	}

	if(isprophuntgametype() && !level.phsettings.allowloadouts || !isdefined(self.var_1A7) || self.var_1A7 == game["defenders"])
	{
		return 0;
	}

	var_00 = int(tablelookup("mp/gametypesTable.csv",0,level.var_3FDC,5));
	return var_00;
}

//Function Number: 344
func_8BFD()
{
	if(func_0C2D() || func_0C1E())
	{
		return 0;
	}

	var_00 = int(tablelookup("mp/gametypesTable.csv",0,level.var_3FDC,7));
	return var_00;
}

//Function Number: 345
func_5693(param_00,param_01)
{
	return 0;
}

//Function Number: 346
func_8653(param_00)
{
	var_01 = getmatchrulesdata("commonOption","timeLimit");
	setdynamicdvar("scr_" + level.var_3FDC + "_timeLimit",var_01);
	func_7BFA(level.var_3FDC,var_01);
	var_02 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_" + level.var_3FDC + "_scoreLimit",var_02);
	func_7BF9(level.var_3FDC,var_02);
	setdynamicdvar("scr_game_matchstarttime",getmatchrulesdata("commonOption","preMatchTimer"));
	setdynamicdvar("scr_game_roundstarttime",getmatchrulesdata("commonOption","preRoundTimer"));
	setdynamicdvar("scr_game_suicidespawndelay",getmatchrulesdata("commonOption","suicidePenalty"));
	setdynamicdvar("scr_team_teamkillspawndelay",getmatchrulesdata("commonOption","teamKillPenalty"));
	setdynamicdvar("scr_team_teamkillkicklimit",getmatchrulesdata("commonOption","teamKillKickLimit"));
	var_03 = getmatchrulesdata("commonOption","numLives");
	setdynamicdvar("scr_" + level.var_3FDC + "_numLives",var_03);
	func_7BF1(level.var_3FDC,var_03);
	setdynamicdvar("scr_player_maxhealth",getmatchrulesdata("commonOption","maxHealth"));
	setdynamicdvar("scr_player_healthregentime",getmatchrulesdata("commonOption","healthRegen"));
	level.var_6031 = 0;
	level.var_6035 = 0;
	setdynamicdvar("scr_game_spectatetype",getmatchrulesdata("commonOption","spectateModeAllowed"));
	setdynamicdvar("scr_game_lockspectatorpov",getmatchrulesdata("commonOption","spectateModePOV"));
	setdynamicdvar("scr_game_allowkillcam",getmatchrulesdata("commonOption","showKillcam"));
	setdynamicdvar("scr_game_forceuav",getmatchrulesdata("commonOption","radarMode") == 2);
	setdynamicdvar("scr_game_radarMode",getmatchrulesdata("commonOption","radarMode"));
	setdynamicdvar("scr_" + level.var_3FDC + "_playerrespawndelay",getmatchrulesdata("commonOption","respawnDelay"));
	setdynamicdvar("scr_" + level.var_3FDC + "_waverespawndelay",getmatchrulesdata("commonOption","waveRespawnDelay"));
	setdynamicdvar("scr_player_forcerespawn",getmatchrulesdata("commonOption","forceRespawn"));
	level.var_6030 = getmatchrulesdata("commonOption","allowCustomClasses");
	level.var_297A = getmatchrulesdata("commonOption","classPickCount");
	setdynamicdvar("scr_game_hardpoints",1);
	setdynamicdvar("scr_game_perks",1);
	setdynamicdvar("2043",getmatchrulesdata("commonOption","hardcoreModeOn"));
	setdynamicdvar("scr_thirdPerson",getmatchrulesdata("commonOption","forceThirdPersonView"));
	setdynamicdvar("311",getmatchrulesdata("commonOption","forceThirdPersonView"));
	setdynamicdvar("scr_game_onlyheadshots",getmatchrulesdata("commonOption","headshotsOnly"));
	if(!isdefined(param_00))
	{
		setdynamicdvar("scr_team_fftype",getmatchrulesdata("commonOption","ffType"));
	}

	setdynamicdvar("scr_game_killstreakdelay",getmatchrulesdata("commonOption","streakGracePeriod"));
	level.var_352F = 1;
	level.var_5FF1 = 1;
	level.mgnestsdisabled = getmatchrulesdata("commonOption","disableMGNests");
	level.var_212F = getmatchrulesdata("commonOption","chatterDisabled");
	level.var_F05 = getmatchrulesdata("commonOption","announcerDisabled");
	level.var_6034 = getmatchrulesdata("commonOption","switchTeamDisabled");
	level.var_4867 = getmatchrulesdata("commonOption","grenadeGracePeriod");
	setdynamicdvar("scr_oneShot",getmatchrulesdata("commonOption","oneShotMode"));
	if(getdvarint("scr_oneShot",0) == 1 || getdvarint("scr_wanderlustOnly",0) == 1)
	{
		level.var_2FAB = 1;
		level.disabledivisionstats = 1;
		level.var_2F8B = 1;
		level.disableallplayerstats = 1;
		level.disableweaponchallenges = 1;
		level.disabledivisionchallenges = 1;
		level.disablewinlossstats = 1;
		level.mgnestsdisabled = 1;
	}

	if(getmatchrulesdata("commonOption","hardcoreModeOn"))
	{
		setdynamicdvar("scr_team_fftype",1);
		setdynamicdvar("scr_player_maxhealth",30);
		setdynamicdvar("scr_player_healthregentime",0);
		setdynamicdvar("scr_player_respawndelay",10);
		setdynamicdvar("scr_game_allowkillcam",0);
		setdynamicdvar("scr_game_forceuav",0);
		setdynamicdvar("scr_game_radarMode",0);
	}

	if(function_0371() || function_02A4())
	{
		setdvar("1689",getmatchrulesdata("commonOption","broadcasterEnabled"));
	}

	setdvar("isMLGMatch",getmatchrulesdata("commonOption","isMLGMatch"));
	setdvar("isEsportsMatch",getmatchrulesdata("commonOption","isEsportsMatch"));
	setdvar("spawning_use_classic",getmatchrulesdata("commonOption","useClassicSpawning"));
	setdvar("4899",getdvar("scr_game_forceuav"));
	setdvar("4648",getdvar("scr_game_compassRadarUpdateTime"));
}

//Function Number: 347
func_7C13()
{
	for(;;)
	{
		level waittill("host_migration_begin");
		[[ level.var_5300 ]]();
	}
}

//Function Number: 348
func_7C15(param_00)
{
	self endon("disconnect");
	if(isdefined(param_00))
	{
		param_00 endon("death");
	}

	for(;;)
	{
		level waittill("host_migration_begin");
		if(isdefined(self.var_5C0E))
		{
			self visionsetthermalforplayer(self.var_5C0E,0);
		}
	}
}

//Function Number: 349
func_4573(param_00,param_01)
{
	var_02 = [];
	var_02["loadoutDivision"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","division");
	var_02["loadoutPrimaryWeaponStruct"] = func_473C(getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",0,"weapon"),0);
	for(var_03 = 0;var_03 < 6;var_03++)
	{
		var_02["loadoutPrimaryAttachmentsGUID"][var_03] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",0,"attachment",var_03);
	}

	var_02["loadoutPrimaryCamoGUID"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",0,"camo");
	var_02["loadoutPrimaryCamo2GUID"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",0,"camo2");
	var_02["loadoutPrimaryReticleGUID"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",0,"reticle");
	var_02["loadoutPrimaryPaintjobId"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",0,"paintjob");
	var_02["loadoutPrimaryCharmGUID"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",0,"charm");
	var_02["loadoutSecondaryWeaponStruct"] = func_473C(getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",1,"weapon"),0);
	for(var_03 = 0;var_03 < 6;var_03++)
	{
		var_02["loadoutSecondaryAttachmentsGUID"][var_03] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",1,"attachment",var_03);
	}

	var_02["loadoutSecondaryCamoGUID"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",1,"camo");
	var_02["loadoutSecondaryCamo2GUID"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",1,"camo2");
	var_02["loadoutSecondaryReticleGUID"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",1,"reticle");
	var_02["loadoutSecondaryPaintjobId"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",1,"paintjob");
	var_02["loadoutSecondaryCharmGUID"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","weaponSetups",1,"charm");
	var_02["loadoutEquipmentStruct"] = func_44CE(getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","equipmentSetups",0,"equipment"),0);
	var_02["loadoutEquipmentNumExtra"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","equipmentSetups",0,"numExtra");
	var_02["loadoutOffhandStruct"] = func_44CE(getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","equipmentSetups",1,"equipment"),0);
	var_02["loadoutOffhandNumExtra"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","equipmentSetups",1,"numExtra");
	for(var_03 = 0;var_03 < 9;var_03++)
	{
		var_02["loadoutPerksGUID"][var_03] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","perkSlots",var_03);
	}

	for(var_03 = 0;var_03 < 4;var_03++)
	{
		var_02["loadoutKillstreaksGUID"][var_03] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"class","assaultStreaks",var_03,"streak");
	}

	var_02["loadoutJuggernaut"] = getmatchrulesdata("defaultClasses",param_00,"defaultClass",param_01,"juggernaut");
	return var_02;
}

//Function Number: 350
removemgnestsfromlevel()
{
	var_00 = getentarray("misc_turret","classname");
	if(isdefined(var_00))
	{
		foreach(var_02 in var_00)
		{
			var_02 delete();
		}
	}
}

//Function Number: 351
func_A165(param_00)
{
	self.var_178 = param_00;
	self setclientomnvar("ui_session_state",param_00);
}

//Function Number: 352
func_1E01()
{
	if(isdefined(level.var_3E0E))
	{
		return level.var_3E0E;
	}

	if(function_02A4() || !function_03AC() || func_5385())
	{
		return "privateMatchCustomClasses";
	}

	if(function_03AF() || common_scripts\utility::func_562E(self.inrankedlobby))
	{
		return "competitiveCustomClasses";
	}

	return "customClasses";
}

//Function Number: 353
func_5385()
{
	if(isdefined(self.var_537B))
	{
		return self.var_537B == 2;
	}

	return 0;
}

//Function Number: 354
func_5387()
{
	if(isdefined(self.var_537B))
	{
		return self.var_537B == 1;
	}

	return 0;
}

//Function Number: 355
func_537D()
{
	var_00 = func_5385();
	var_01 = func_5387();
	return var_00 || var_01;
}

//Function Number: 356
func_445D(param_00)
{
	if(isdefined(level.var_2321[param_00]))
	{
		return level.var_2321[param_00];
	}

	return 0;
}

//Function Number: 357
func_57FF()
{
	var_00 = func_455E(self.var_1A7);
	foreach(var_02 in var_00)
	{
		if(var_02 != self && !isdefined(var_02.var_E8) || !var_02.var_E8)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 358
func_5A7F(param_00)
{
	var_01 = func_455E(param_00);
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.var_E8) && var_03.var_E8)
		{
			var_03 thread maps\mp\gametypes\_damage::func_2EEF(randomintrange(1,3));
		}
	}
}

//Function Number: 359
func_955C(param_00)
{
	if(!isai(self))
	{
		self switchtoweapon(param_00);
		return;
	}

	self switchtoweapon("none");
}

//Function Number: 360
func_955D(param_00)
{
	if(!isai(self))
	{
		self method_86A5(param_00);
		return;
	}

	self method_86A5("none");
}

//Function Number: 361
func_566A(param_00)
{
	if(function_01EF(param_00) && param_00.var_A4A == 1)
	{
		return 1;
	}

	if(isbot(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 362
func_5800(param_00)
{
	if(func_566A(param_00))
	{
		return 1;
	}

	if(isplayer(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 363
func_5666(param_00)
{
	if(function_01EF(param_00) && param_00.var_A42 == 1)
	{
		return 1;
	}

	if(isbot(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 364
func_56FF(param_00)
{
	if(func_5666(param_00))
	{
		return 1;
	}

	if(isplayer(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 365
func_46D4(param_00)
{
	var_01 = 0;
	if(level.var_984D)
	{
		switch(param_00)
		{
			case "axis":
				var_01 = 1;
				break;

			case "allies":
				var_01 = 2;
				break;
		}
	}

	return var_01;
}

//Function Number: 366
func_5755(param_00)
{
	return param_00 == "MOD_MELEE";
}

//Function Number: 367
func_5695(param_00)
{
	return param_00 == "MOD_RIFLE_BULLET" || param_00 == "MOD_PISTOL_BULLET" || param_00 == "MOD_HEAD_SHOT";
}

//Function Number: 368
func_56E5(param_00)
{
	return param_00 == "MOD_GRENADE" || param_00 == "MOD_GRENADE_SPLASH" || param_00 == "MOD_PROJECTILE" || param_00 == "MOD_PROJECTILE_SPLASH" || param_00 == "MOD_EXPLOSIVE";
}

//Function Number: 369
func_5697(param_00,param_01)
{
	return param_00 == "MOD_BURNED" || param_00 == "MOD_BURNED_OVER_TIME";
}

//Function Number: 370
func_570A(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		if(isdefined(param_03.var_117))
		{
			if(function_02BD() && !isdefined(param_03.var_3B))
			{
				return 0;
			}

			if(param_03.var_3B == "script_vehicle")
			{
				return 0;
			}

			if(param_03.var_3B == "misc_turret")
			{
				return 0;
			}

			if(param_03.var_3B == "script_model")
			{
				return 0;
			}
		}

		if(isdefined(param_03.var_A4B))
		{
			if(param_03.var_A4B == "dog")
			{
				return 0;
			}
		}
	}

	return (param_01 == "head" || param_01 == "helmet") && !func_5755(param_02) && (func_45B5(param_00) == "dp28_mp" || param_02 != "MOD_IMPACT") && !func_56DF(param_00);
}

//Function Number: 371
func_5670(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return function_01D4(param_00) == "altmode";
}

//Function Number: 372
func_118D(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01) && function_01EF(param_00) && isdefined(param_00.var_A4B) && param_00.var_A4B == "leprechauns")
	{
		return 0;
	}

	if(isdefined(param_00) && isdefined(param_01) && function_01EF(param_00) && isdefined(param_00.var_A4B) && param_00.var_A4B == "mp_zombie_generic")
	{
		return 0;
	}

	if(isdefined(param_00) && isdefined(param_01) && function_01EF(param_01) && isdefined(param_01.var_A4B) && param_01.var_A4B == "paratroopers" && isdefined(param_01.var_117) && param_01.var_117 == param_00)
	{
		return 1;
	}

	if(!level.var_984D)
	{
		return 0;
	}

	if(function_0367() && isdefined(param_01) && isdefined(param_00) && isdefined(param_01.var_572A) && isdefined(param_00.var_572A) && param_01.var_572A && param_00.var_572A)
	{
		return 0;
	}

	if(!isdefined(param_01) || !isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.var_1A7) || !isdefined(param_01.var_1A7))
	{
		return 0;
	}

	if(param_00 == param_01)
	{
		return 0;
	}

	if(isdefined(param_01.var_984E) && param_00.var_12C["team"] == param_01.var_1A7)
	{
		return 0;
	}

	if(isdefined(param_01.var_80D7) && param_01.var_80D7)
	{
		return 0;
	}

	if(param_00.var_1A7 == param_01.var_1A7)
	{
		return 1;
	}

	return 0;
}

//Function Number: 373
playerhaskillstreak(param_00,param_01)
{
	foreach(var_03 in param_00.var_12C["killstreaks"])
	{
		if(isdefined(var_03.var_944C) && var_03.var_944C == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 374
func_84D3(param_00)
{
	if(!isdefined(self.var_4D3C) && common_scripts\utility::func_F79(self.var_4D3C,param_00))
	{
		self.var_4D3C = common_scripts\utility::func_F6F(self.var_4D3C,param_00);
		param_00 notify("calculate_new_level_targets");
	}
}

//Function Number: 375
func_0974(param_00,param_01)
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["bots_add_to_level_targets"]))
	{
		param_00.var_A1F5 = param_01;
		param_00.var_1A23 = "use";
		[[ level.var_19D5["bots_add_to_level_targets"] ]](param_00);
	}
}

//Function Number: 376
func_7C8D(param_00)
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["bots_remove_from_level_targets"]))
	{
		[[ level.var_19D5["bots_remove_from_level_targets"] ]](param_00);
	}
}

//Function Number: 377
func_0973(param_00)
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["bots_add_to_level_targets"]))
	{
		param_00.var_1A23 = "damage";
		[[ level.var_19D5["bots_add_to_level_targets"] ]](param_00);
	}
}

//Function Number: 378
func_7C8C(param_00)
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["bots_remove_from_level_targets"]))
	{
		[[ level.var_19D5["bots_remove_from_level_targets"] ]](param_00);
	}
}

//Function Number: 379
func_67F4(param_00)
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["notify_enemy_bots_bomb_used"]))
	{
		self [[ level.var_19D5["notify_enemy_bots_bomb_used"] ]](param_00);
	}
}

//Function Number: 380
func_42EC()
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["bot_get_rank_xp_and_prestige"]))
	{
		return self [[ level.var_19D5["bot_get_rank_xp_and_prestige"] ]]();
	}
}

//Function Number: 381
func_8568()
{
	var_00 = func_42EC();
	if(isdefined(var_00))
	{
		self.var_12C["rankxp"] = var_00.var_7A6D;
		self.var_12C["prestige"] = var_00.var_76B0;
		self.var_12C["prestige_fake"] = var_00.var_76B0;
	}
}

//Function Number: 382
func_8567()
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["bot_set_rank_options"]))
	{
		self [[ level.var_19D5["bot_set_rank_options"] ]]();
	}
}

//Function Number: 383
func_843E()
{
	if(!isdefined(level.var_258F))
	{
		level.var_258F = getdvar("5554") == "true";
	}
	else
	{
	}

	if(!isdefined(level.var_1D4))
	{
		level.var_1D4 = getdvar("3475") == "true";
	}
	else
	{
	}

	if(!isdefined(level.var_1D5))
	{
		level.var_1D5 = getdvar("2695") == "true";
	}
	else
	{
	}

	if(!isdefined(level.var_148))
	{
		level.var_148 = getdvar("3864") == "true";
	}
	else
	{
	}

	if(!isdefined(level.var_149))
	{
		level.var_149 = getdvar("3957") == "true";
	}
}

//Function Number: 384
func_5583()
{
	if(level.var_1D4 || level.var_148 || !level.var_258F)
	{
		return 1;
	}

	return 0;
}

//Function Number: 385
func_8670(param_00,param_01,param_02)
{
	if(!isdefined(level.var_258F) || !isdefined(level.var_1D4) || !isdefined(level.var_148))
	{
		func_843E();
	}

	if(func_5583())
	{
		setdvar(param_00,param_02);
		return;
	}

	setdvar(param_00,param_01);
}

//Function Number: 386
func_583E(param_00,param_01)
{
	return isdefined(param_01.var_1A7) && param_01.var_1A7 != param_00.var_1A7;
}

//Function Number: 387
func_5828(param_00,param_01)
{
	return isdefined(param_01.var_117) && param_01.var_117 != param_00;
}

//Function Number: 388
func_4507()
{
	return (0,0,5000);
}

//Function Number: 389
func_4508()
{
	return (0,0,2500);
}

//Function Number: 390
func_7E50(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(isdefined(level.var_6859) && isdefined(level.var_6869))
	{
		self method_8483(level.var_6869,param_00);
		self visionsetnakedforplayer(level.var_6869,param_00);
		func_85F0(level.var_6869,param_00);
		return;
	}

	if(isdefined(self.var_A25C) && isdefined(self.var_7E7B))
	{
		self method_8483(self.var_7E7B,param_00);
		self visionsetnakedforplayer(self.var_7E7B,param_00);
		func_85F0(self.var_7E7B,param_00);
		return;
	}

	self method_8483("",param_00);
	self visionsetnakedforplayer("",param_00);
	func_85F0("",param_00);
}

//Function Number: 391
func_8513(param_00)
{
	if(!isplayer(self))
	{
		return;
	}

	if(isdefined(level.var_5D79))
	{
		level.var_5D7A = level.var_5D79;
	}

	level.var_5D79 = param_00;
	self lightsetforplayer(param_00);
}

//Function Number: 392
func_23C0()
{
	if(!isplayer(self))
	{
		return;
	}

	var_00 = getmapcustom("map");
	if(isdefined(level.var_5D7A))
	{
		var_00 = level.var_5D7A;
		level.var_5D7A = undefined;
	}

	level.var_5D79 = var_00;
	self lightsetforplayer(var_00);
}

//Function Number: 393
func_5D22(param_00,param_01,param_02,param_03)
{
	if(!isplayer(self))
	{
		return;
	}

	self lightsetoverrideenableforplayer(param_00,param_01);
	func_A6D0(param_02,["death","disconnect"]);
	if(isdefined(self))
	{
		self method_83C8(param_03);
	}
}

//Function Number: 394
func_4704()
{
	if(isdefined(self.var_12C["guid"]))
	{
		return self.var_12C["guid"];
	}

	var_00 = self getguid();
	if(var_00 == "0000000000000000")
	{
		if(isdefined(level.var_48CB))
		{
			level.var_48CB++;
		}
		else
		{
			level.var_48CB = 1;
		}

		var_00 = "script" + level.var_48CB;
	}

	self.var_12C["guid"] = var_00;
	return self.var_12C["guid"];
}

//Function Number: 395
func_42B8(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = self getentitynumber();
	var_03 = [];
	foreach(var_05 in level.var_744A)
	{
		if(!isdefined(var_05) || var_05 == self)
		{
			continue;
		}

		var_06 = 0;
		if(!param_01)
		{
			if((isdefined(var_05.var_1A7) && var_05.var_1A7 == "spectator") || var_05.var_178 == "spectator")
			{
				var_07 = var_05 getspectatingplayer();
				if(isdefined(var_07) && var_07 == self)
				{
					var_06 = 1;
				}
			}

			if(var_05.var_9F == var_02)
			{
				var_06 = 1;
			}
		}

		if(!param_00)
		{
			if(var_05.var_E1 == var_02)
			{
				var_06 = 1;
			}
		}

		if(var_06)
		{
			var_03[var_03.size] = var_05;
		}
	}

	return var_03;
}

//Function Number: 396
func_85F0(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = func_42B8(param_04,param_05);
	foreach(var_09 in var_07)
	{
		var_09 notify("changing_watching_visionset");
		if(isdefined(param_03) && param_03)
		{
			var_09 visionsetmissilecamforplayer(param_00,param_01);
		}
		else if(isdefined(param_06) && param_06)
		{
			var_09 visionsetpostapplyforplayer(param_00,param_01);
		}
		else
		{
			var_09 visionsetnakedforplayer(param_00,param_01);
		}

		if(param_00 != "" && isdefined(param_02))
		{
			var_09 thread func_7D4B(self,param_01 + param_02,param_06);
			var_09 thread func_7D49(self,param_06);
			if(var_09 func_5727())
			{
				var_09 thread func_7D4A();
			}
		}
	}
}

//Function Number: 397
func_7D4A()
{
	self endon("disconnect");
	self waittill("spawned");
	self visionsetnakedforplayer("",0);
	self visionsetpostapplyforplayer("",0);
}

//Function Number: 398
func_7D4B(param_00,param_01,param_02)
{
	self endon("changing_watching_visionset");
	param_00 endon("disconnect");
	var_03 = gettime();
	var_04 = self.var_1A7;
	while(gettime() - var_03 < param_01 * 1000)
	{
		if(self.var_1A7 != var_04 || !common_scripts\utility::func_F79(param_00 func_42B8(),self))
		{
			if(isdefined(param_02) && param_02)
			{
				self visionsetpostapplyforplayer("",0);
			}
			else
			{
				self visionsetnakedforplayer("",0);
			}

			self notify("changing_visionset");
			break;
		}

		wait 0.05;
	}
}

//Function Number: 399
func_7D49(param_00,param_01)
{
	self endon("changing_watching_visionset");
	param_00 waittill("disconnect");
	if(isdefined(param_01) && param_01)
	{
		self visionsetpostapplyforplayer("",0);
		return;
	}

	self visionsetnakedforplayer("",0);
}

//Function Number: 400
func_073C(param_00)
{
	if(function_01EF(param_00) && !isdefined(param_00.var_565F) || !param_00.var_565F)
	{
		return undefined;
	}

	return param_00;
}

//Function Number: 401
func_06D6(param_00,param_01)
{
	if(!isdefined(self.var_6609))
	{
		self.var_6609 = [];
		self.var_76E2 = [];
	}
	else
	{
		self.var_76E2[0] = self.var_6609[0];
		self.var_76E2[1] = self.var_6609[1];
	}

	self.var_6609[0] = param_00;
	self.var_6609[1] = param_01;
	self method_83F4(param_00,param_01);
}

//Function Number: 402
func_06AF()
{
	if(isdefined(self.var_76E2))
	{
		self method_83F4(self.var_76E2[0],self.var_76E2[1]);
	}
	else
	{
		self method_83F4("","");
	}

	self.var_6609 = undefined;
	self.var_76E2 = undefined;
}

//Function Number: 403
func_3B88(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	if(var_02.size > 0)
	{
		foreach(var_04 in var_02)
		{
			var_05 = 0;
			if(isdefined(var_04.var_8109))
			{
				if(isdefined(var_04.var_8260) && var_04.var_8260 == "delta_anim")
				{
					var_05 = 1;
				}

				var_04 thread func_71F5(param_01,var_05);
			}
		}
	}
}

//Function Number: 404
func_71F5(param_00,param_01)
{
	if(param_00 == 1)
	{
		wait(randomfloatrange(0,1));
	}

	if(param_01 == 0)
	{
		self scriptmodelplayanim(self.var_8109);
		return;
	}

	self method_8278(self.var_8109);
}

//Function Number: 405
func_73AF(param_00,param_01)
{
	func_0693("dodge",param_00,param_01,::method_8497);
}

//Function Number: 406
func_0693(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(self.var_73D4))
	{
		self.var_73D4 = [];
	}

	if(!isdefined(self.var_73D4[param_00]))
	{
		self.var_73D4[param_00] = [];
	}

	if(!isdefined(param_02))
	{
		param_02 = "default";
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(param_01)
	{
		self.var_73D4[param_00] = common_scripts\utility::func_F93(self.var_73D4[param_00],param_02);
		if(!self.var_73D4[param_00].size)
		{
			if(param_04)
			{
				self [[ param_03 ]](1);
				return;
			}

			self [[ param_03 ]](1);
			return;
		}

		return;
	}

	if(!isdefined(common_scripts\utility::func_F7E(self.var_73D4[param_00],param_02)))
	{
		self.var_73D4[param_00] = common_scripts\utility::func_F6F(self.var_73D4[param_00],param_02);
	}

	if(param_04)
	{
		self [[ param_03 ]](0);
		return;
	}

	self [[ param_03 ]](0);
}

//Function Number: 407
func_5FBA(param_00,param_01,param_02,param_03)
{
	var_04 = 500;
	switch(param_00)
	{
		case "killstreakRemote":
			var_04 = 300;
			break;

		case "coopStreakPrompt":
			var_04 = 301;
			break;

		default:
			break;
	}

	func_065E(var_04,param_00,param_02,param_03);
	self registerusable(var_04,param_02,param_03);
	self sethintstring(param_01);
	self setcursorhint("HINT_NOICON");
}

//Function Number: 408
func_065E(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.var_47E6))
	{
		level.var_47E6 = [];
	}

	var_04 = -1;
	for(var_05 = 0;var_05 < level.var_47E6.size;var_05++)
	{
		var_06 = level.var_47E6[var_05];
		if(var_06.var_7734 > param_00)
		{
			if(var_04 == -1)
			{
				var_04 = var_05;
			}

			break;
		}

		if(var_06.var_7734 == param_00)
		{
			var_06.var_7734 = var_06.var_7734 + 0.01;
			if(var_06.var_3655)
			{
				var_06.var_378F registerusable(var_06.var_7734,var_06.var_721C,var_06.var_1A7);
			}

			if(var_04 == -1)
			{
				var_04 = var_05;
			}
		}
	}

	if(var_04 == -1)
	{
		var_04 = 0;
	}

	var_07 = spawnstruct();
	var_07.var_378F = self;
	var_07.var_7734 = param_00;
	var_07.var_1B9 = param_01;
	var_07.var_721C = param_02;
	var_07.var_1A7 = param_03;
	var_07.var_3655 = 1;
	level.var_47E6 = common_scripts\utility::func_F86(level.var_47E6,var_07,var_04);
}

//Function Number: 409
func_5FB9()
{
	var_00 = undefined;
	foreach(var_02 in level.var_47E6)
	{
		if(var_02.var_378F == self)
		{
			var_00 = var_02;
			break;
		}
	}

	if(isdefined(var_00))
	{
		var_04 = var_00.var_7734;
		level.var_47E6 = common_scripts\utility::func_F93(level.var_47E6,var_00);
		self method_80B5();
		foreach(var_02 in level.var_47E6)
		{
			if(var_04 > var_02.var_7734 && int(var_04) == int(var_02.var_7734))
			{
				var_02.var_7734 = var_02.var_7734 - 0.01;
				if(var_02.var_3655)
				{
					var_02.var_378F registerusable(var_02.var_7734,var_02.var_721C,var_02.var_1A7);
				}
			}
		}
	}
}

//Function Number: 410
func_2F89()
{
	foreach(var_01 in level.var_47E6)
	{
		if(var_01.var_378F == self)
		{
			if(var_01.var_3655)
			{
				var_01.var_378F method_80B5();
				var_01.var_3655 = 0;
			}

			break;
		}
	}
}

//Function Number: 411
func_3659()
{
	foreach(var_01 in level.var_47E6)
	{
		if(var_01.var_378F == self)
		{
			if(!var_01.var_3655)
			{
				var_01.var_378F registerusable(var_01.var_7734,var_01.var_721C,var_01.var_1A7);
				var_01.var_3655 = 1;
			}

			break;
		}
	}
}

//Function Number: 412
func_8668(param_00)
{
	self setdepthoffield(param_00["nearStart"],param_00["nearEnd"],param_00["farStart"],param_00["farEnd"],param_00["nearBlur"],param_00["farBlur"]);
}

//Function Number: 413
func_86F8()
{
	if(!isdefined(level.var_6F9D))
	{
		return;
	}

	if(isdefined(level.var_6F9D["dofScripting"]))
	{
		self method_84B4(level.var_6F9D["dofScripting"]);
	}

	self method_84B7(level.var_6F9D["fstop"],level.var_6F9D["focus"],level.var_6F9D["focusSpeed"],level.var_6F9D["apertureSpeed"]);
	self method_84C9(level.var_6F9D["viewModelFstop"],level.var_6F9D["viewModelFocus"]);
}

//Function Number: 414
func_86F7(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(self method_8436())
	{
		return;
	}

	if(!isdefined(level.var_6F9D))
	{
		level.var_6F9D = [];
	}

	level.var_6F9D["fstop"] = param_00;
	level.var_6F9D["focus"] = param_01;
	level.var_6F9D["viewModelFstop"] = param_02;
	level.var_6F9D["viewModelFocus"] = param_03;
	level.var_6F9D["focusSpeed"] = param_04;
	level.var_6F9D["apertureSpeed"] = param_05;
	level.var_6F9D["dofScripting"] = param_06;
	func_86F8();
}

//Function Number: 415
func_56D9(param_00)
{
	if(level.var_984D)
	{
		return func_5781(param_00);
	}

	return func_577B(param_00);
}

//Function Number: 416
func_5781(param_00)
{
	return param_00.var_1A7 != self.var_1A7;
}

//Function Number: 417
func_577B(param_00)
{
	if(isdefined(param_00.var_117))
	{
		return param_00.var_117 != self;
	}

	return param_00 != self;
}

//Function Number: 418
func_56B4()
{
	if(function_02A4() && getdvarint("4974"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 419
func_56B3()
{
	if(issplitscreen() && getdvarint("4974"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 420
func_56B2()
{
	if(func_773F() && getdvarint("4974"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 421
func_56B1()
{
	if(getdvarint("isMLGMatch"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 422
func_9067(param_00,param_01,param_02,param_03)
{
	var_04 = spawnfx(param_00,param_02,param_03);
	var_04 func_3F7B(param_01);
	return var_04;
}

//Function Number: 423
func_3F7B(param_00)
{
	thread func_8BFC(param_00);
	function_014E(self,1);
	triggerfx(self);
}

//Function Number: 424
func_8BFC(param_00)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self method_805C();
		foreach(var_02 in level.var_744A)
		{
			var_03 = var_02.var_1A7;
			if(var_02 method_8436())
			{
				var_03 = "broadcaster";
			}
			else if(var_03 != "axis")
			{
				var_03 = "allies";
			}

			if(param_00 == var_03 || param_00 == "neutral")
			{
				self showtoclient(var_02);
			}
		}

		level waittill("joined_team");
	}
}

//Function Number: 425
func_74A3(param_00,param_01,param_02,param_03)
{
	var_04 = spawnlinkedfx(param_00,param_01,param_02);
	triggerfx(var_04,param_03);
	return var_04;
}

//Function Number: 426
func_9028(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnlinkedfx(param_00,param_04,param_05);
	var_06 func_3F7A(param_01,param_02,param_03);
	return var_06;
}

//Function Number: 427
func_3F7A(param_00,param_01,param_02)
{
	thread func_8C1B(param_00,param_01,param_02);
	function_014E(self,1);
	triggerfx(self);
}

//Function Number: 428
func_8C1B(param_00,param_01,param_02)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self method_805C();
		foreach(var_04 in level.var_744A)
		{
			var_05 = var_04.var_1A7;
			if(var_04 method_8436())
			{
				var_05 = "broadcaster";
			}
			else if(var_05 != "axis")
			{
				var_05 = "allies";
			}

			var_06 = var_04 func_0649("specialty_stun_resistance");
			if((!param_02 && var_06) || param_01 == var_05 && var_04 == param_00 && !var_06)
			{
				continue;
			}

			if(param_01 == var_05 || param_01 == "neutral" || var_06 || param_01 != var_05 && var_04 == param_00)
			{
				self showtoclient(var_04);
			}
		}

		level waittill("joined_team");
	}
}

//Function Number: 429
func_922B(param_00)
{
	var_01 = issubstr(param_00,"zk383");
	if(isdefined(self.var_12C["altModeActive"]) && isdefined(self.var_79) && self.var_12C["altModeActive"] && self.var_79 != 5 && func_472A(param_00) == "weapon_smg" && issubstr(param_00,"suppressor") && !var_01)
	{
		var_02 = maps\mp\gametypes\_divisions::func_461C(1);
		if(var_02 == "suppressor_level1" || var_02 == "suppressor_level2" || var_02 == "suppressor_level3")
		{
			param_00 = "alt+" + param_00;
		}
	}
	else if(var_01 && common_scripts\utility::func_562E(self.var_12C["altModeActive"]))
	{
		param_00 = "alt+" + param_00;
	}
	else if(isdefined(self.var_79) && self.var_79 != 5 && func_472A(param_00) == "weapon_shotgun" && issubstr(param_00,"dragon_breath"))
	{
	}

	return param_00;
}

//Function Number: 430
func_4340(param_00)
{
	var_01 = "m1garand_mp";
	if(isdefined(param_00.var_76F8) && param_00.var_76F8 != "none")
	{
		var_01 = param_00.var_76F8;
		var_01 = func_922B(var_01);
	}
	else if(isdefined(param_00.var_8358) && param_00.var_8358 != "none")
	{
		var_01 = param_00.var_8358;
	}
	else if(isdefined(param_00.var_60EE) && param_00.var_60EE != "none")
	{
		var_01 = param_00.var_60EE;
	}

	return var_01;
}

//Function Number: 431
func_744E()
{
	self.var_7DEE = self getangles();
}

//Function Number: 432
func_7447()
{
	if(isdefined(self.var_7DEE))
	{
		if(self.var_1A7 != "spectator")
		{
			self setangles(self.var_7DEE);
		}

		self.var_7DEE = undefined;
	}
}

//Function Number: 433
func_863F(param_00,param_01,param_02,param_03)
{
	param_00 maps\mp\gametypes\_gameobjects::func_860A("broadcaster",param_01,undefined,param_02);
	param_00 maps\mp\gametypes\_gameobjects::func_860E("broadcaster",param_01,param_02,param_03);
}

//Function Number: 434
func_907D(param_00,param_01,param_02)
{
	var_03 = getent(param_00,"targetname");
	if(!isdefined(var_03))
	{
		return undefined;
	}

	var_04 = spawn("script_model",param_01);
	var_04 clonebrushmodeltoscriptmodel(var_03);
	var_04.var_1D = param_02;
	return var_04;
}

//Function Number: 435
func_56B9()
{
	if(isdefined(level.var_585D) && level.var_585D)
	{
		return 1;
	}

	return 0;
}

//Function Number: 436
func_86BF(param_00)
{
	var_01 = getentarray();
	setomnvar("lighting_state",param_00);
	if(!getdvarint("233"))
	{
		foreach(var_03 in var_01)
		{
			if(isdefined(var_03.var_5D56) && isdefined(var_03.var_3A) && var_03.var_3A == "script_brushmodel" || var_03.var_3A == "script_model")
			{
				if(var_03.var_5D56 == 0)
				{
					continue;
				}

				if(var_03.var_5D56 == param_00)
				{
					var_03 common_scripts\utility::func_8BE0();
					var_03 allowriotshieldplant();
					continue;
				}

				var_03 notify("hidingLightingState");
				var_03 common_scripts\utility::func_4CEB();
			}
		}
	}
}

//Function Number: 437
func_46E7()
{
	return function_003E();
}

//Function Number: 438
func_08F7()
{
	if(isdefined(self.var_5C) && self.var_5C <= 0)
	{
		return undefined;
	}

	if(self.var_3A == "agent_enemy_dog_raid")
	{
		var_00 = [[ level.var_A4C ]](undefined,undefined,self.var_116,self.var_1D,undefined,0,undefined,self.var_3A);
	}
	else
	{
		var_00 = [[ level.var_A4D ]]("player","axis",undefined,self.var_116,self.var_1D,undefined,0,0,undefined,self.var_3A);
	}

	if(isdefined(var_00) && function_01EF(var_00))
	{
		if(isdefined(level.var_A41[var_00.var_A4B]["set_initial_behavior"]))
		{
			self [[ level.var_A41[var_00.var_A4B]["set_initial_behavior"] ]](var_00);
		}

		if(isdefined(self.var_5C))
		{
			self.var_5C--;
		}
	}

	return var_00;
}

//Function Number: 439
func_0FA7(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04.var_5C) && var_04.var_5C <= 0)
		{
			continue;
		}

		var_05 = var_04 func_08F7();
		if(!param_01)
		{
		}

		var_02[var_02.size] = var_05;
	}

	if(!param_01)
	{
	}

	return var_02;
}

//Function Number: 440
func_8FE4(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03) && param_03)
	{
		var_04 = getvehiclenode(param_00,"script_noteworthy");
	}
	else
	{
		var_04 = getvehiclenode(param_01,"targetname");
	}

	var_05 = spawnhelicopter(var_04.var_116,var_04.var_1D,param_02,param_01);
	var_05 notify("forward");
	var_05.var_1C7 = "forward";
	var_05.var_1C1 = "forward";
	var_05.var_17DC = 0;
	var_05.var_931A = "forward";
	var_05 startpath(var_04);
	return var_05;
}

//Function Number: 441
func_0FA8(param_00,param_01)
{
	var_02 = getentarray(param_00,"targetname");
	return func_0FA7(var_02,param_01);
}

//Function Number: 442
func_853A(param_00)
{
	if(!isdefined(level.var_738E))
	{
		thread func_5243();
	}

	if(param_00)
	{
		self.var_738F = 1;
		return;
	}

	self.var_738F = undefined;
}

//Function Number: 443
func_5243()
{
	level.var_738E = 1;
	foreach(var_01 in level.var_744A)
	{
		var_01 thread func_A1CE();
	}

	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread func_A1CE();
	}
}

//Function Number: 444
func_A1CE()
{
	self endon("disconnect");
	var_00 = undefined;
	for(;;)
	{
		var_01 = self getusableentity();
		if(isdefined(var_01) && distance2dsquared(var_01.var_116,self.var_116) > pow(getdvarfloat("2098"),2))
		{
			var_01 = undefined;
		}

		if(isdefined(var_01) && !isdefined(var_00) || var_01 != var_00)
		{
			if(isdefined(var_01.var_738F))
			{
				var_01 notify("player_usable_focus",self);
			}
		}

		if(isdefined(var_00) && !isdefined(var_01) || var_01 != var_00)
		{
			if(isdefined(var_00.var_738F))
			{
				var_00 notify("player_usable_focus_end",self);
			}
		}

		wait 0.05;
		var_00 = var_01;
	}
}

//Function Number: 445
func_461F()
{
	if(isdefined(level.var_585D) && level.var_585D)
	{
		return common_scripts\utility::func_46A8();
	}

	if(function_03AC())
	{
		return common_scripts\utility::func_46AE();
	}

	return common_scripts\utility::func_46A7();
}

//Function Number: 446
func_461E()
{
	if(function_03AC())
	{
		return "rankedloadouts";
	}

	return "privateloadouts";
}

//Function Number: 447
func_86FB()
{
	level.var_933C = func_461F();
	level.var_5E09 = func_461E();
}

//Function Number: 448
func_452A(param_00)
{
	if(!isdefined(param_00) || param_00 == "" || param_00 == "none" || param_00 == "specialty_null")
	{
		return 0;
	}

	return getitemguidfromref(param_00);
}

//Function Number: 449
func_452B(param_00)
{
	if(isdefined(param_00) && param_00 != 0)
	{
		var_01 = getitemreffromguid(param_00);
		return var_01;
	}

	return "none";
}

//Function Number: 450
func_473D(param_00)
{
	var_01 = spawnstruct();
	var_02 = param_00;
	if(issubstr(param_00,"_raid"))
	{
		var_01.var_3FC3 = 2;
		var_02 = function_0337(param_00,"_raid");
	}
	else if(issubstr(param_00,"_zm"))
	{
		var_01.var_3FC3 = 1;
		var_02 = function_0337(param_00,"_zm");
	}
	else
	{
		var_01.var_3FC3 = 0;
	}

	var_01.var_48CA = func_452A(var_02);
	return var_01;
}

//Function Number: 451
func_473C(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_48CA = param_00;
	var_02.var_3FC3 = param_01;
	return var_02;
}

//Function Number: 452
func_4737(param_00)
{
	var_01 = "none";
	if(!isdefined(param_00) || !isdefined(param_00.var_48CA) || param_00.var_48CA == 0 || !isdefined(param_00.var_3FC3))
	{
		return var_01;
	}

	var_02 = func_452B(param_00.var_48CA);
	if(param_00.var_3FC3 == 2)
	{
		var_01 = function_02FF(var_02,"_mp") + "_raid" + "_mp";
	}
	else if(param_00.var_3FC3 == 1)
	{
		var_01 = function_02FF(var_02,"_mp") + "_zm";
	}
	else
	{
		var_01 = var_02;
	}

	return var_01;
}

//Function Number: 453
func_472C(param_00)
{
	var_01 = 0;
	if(isdefined(param_00) && param_00 != 0)
	{
		var_01 = getweaponconditionid(param_00);
	}

	return var_01;
}

//Function Number: 454
func_472D(param_00)
{
	var_01 = 0;
	if(!isdefined(param_00) || !isdefined(param_00.var_48CA) || param_00.var_48CA == 0 || !isdefined(param_00.var_3FC3))
	{
		return var_01;
	}

	var_01 = getweaponconditionid(param_00.var_48CA);
	return var_01;
}

//Function Number: 455
func_44CF(param_00)
{
	var_01 = spawnstruct();
	var_02 = param_00;
	if(issubstr(param_00,"_raid"))
	{
		var_01.var_3FC3 = 2;
		var_02 = function_0337(param_00,"_raid");
	}
	else if(issubstr(param_00,"_zm"))
	{
		var_01.var_3FC3 = 1;
		var_02 = function_0337(param_00,"_zm");
	}
	else
	{
		var_01.var_3FC3 = 0;
	}

	var_01.var_48CA = func_452A(var_02);
	return var_01;
}

//Function Number: 456
func_44CE(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_48CA = param_00;
	var_02.var_3FC3 = param_01;
	return var_02;
}

//Function Number: 457
func_44CD(param_00)
{
	var_01 = "none";
	if(!isdefined(param_00) || !isdefined(param_00.var_48CA) || param_00.var_48CA == 0 || !isdefined(param_00.var_3FC3))
	{
		return var_01;
	}

	var_02 = func_452B(param_00.var_48CA);
	if(param_00.var_3FC3 == 2)
	{
		var_01 = function_02FF(var_02,"_mp") + "_raid" + "_mp";
	}
	else if(param_00.var_3FC3 == 1)
	{
		var_01 = function_02FF(var_02,"_mp") + "_zm";
	}
	else if(func_579B() && common_scripts\utility::func_562E(level.var_79C1))
	{
		if(var_02 == "smoke_grenade_mp")
		{
			var_01 = "smoke_grenade_axis_mp";
		}
		else if(var_02 == "smoke_grenade_axis_mp")
		{
			var_01 = "smoke_grenade_mp";
		}
		else
		{
			var_01 = var_02;
		}
	}
	else
	{
		var_01 = var_02;
	}

	return var_01;
}

//Function Number: 458
func_5746(param_00,param_01,param_02)
{
	var_03 = (param_00[0],param_00[1],0);
	var_04 = (param_02[0],param_02[1],0);
	var_05 = var_04 - var_03;
	var_06 = (param_01[0],param_01[1],0);
	return var_05[0] * var_06[1] - var_05[1] * var_06[0] < 0;
}

//Function Number: 459
func_873B(param_00)
{
	level.var_984D = param_00;
	setdvar("4491",param_00);
}

//Function Number: 460
func_44DD()
{
	var_00 = self getweaponslistprimaries();
	return var_00[0];
}

//Function Number: 461
func_5C98(param_00,param_01,param_02)
{
	var_03 = getent(param_00,"targetname");
	if(!isdefined(var_03))
	{
		return;
	}

	var_04 = var_03 method_81DE();
	var_03.var_36D5 = param_02;
	var_05 = 0;
	while(var_05 < param_01)
	{
		var_06 = var_04 + param_02 - var_04 * var_05 / param_01;
		var_05 = var_05 + 0.05;
		var_03 method_81DF(var_06);
		wait 0.05;
	}

	var_03 method_81DF(param_02);
}

//Function Number: 462
func_5C99(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,"targetname");
	foreach(var_05 in var_03)
	{
		var_06 = var_05 method_81DE();
		var_05.var_36D5 = param_02;
		var_07 = 0;
		while(var_07 < param_01)
		{
			var_08 = var_06 + param_02 - var_06 * var_07 / param_01;
			var_07 = var_07 + 0.05;
			var_05 method_81DF(var_08);
			wait 0.05;
		}

		var_05 method_81DF(param_02);
	}
}

//Function Number: 463
func_33C0(param_00,param_01,param_02,param_03)
{
	level endon(param_03);
	wait 0.05;
}

//Function Number: 464
func_33A8(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		var_05 = param_04;
	}
	else
	{
		var_05 = 16;
	}

	var_06 = 360 / var_05;
	var_07 = [];
	for(var_08 = 0;var_08 < var_05;var_08++)
	{
		var_09 = var_06 * var_08;
		var_0A = cos(var_09) * param_01;
		var_0B = sin(var_09) * param_01;
		var_0C = param_00[0] + var_0A;
		var_0D = param_00[1] + var_0B;
		var_0E = param_00[2];
		var_07[var_07.size] = (var_0C,var_0D,var_0E);
	}

	for(var_08 = 0;var_08 < var_07.size;var_08++)
	{
		var_0F = var_07[var_08];
		if(var_08 + 1 >= var_07.size)
		{
			var_10 = var_07[0];
		}
		else
		{
			var_10 = var_07[var_08 + 1];
		}

		thread func_33C0(var_0F,var_10,param_02,param_03);
	}
}

//Function Number: 465
func_2D4F(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = param_00.var_164;
	if(isdefined(var_01) && isdefined(level.var_947C["script_linkname"]) && isdefined(level.var_947C["script_linkname"][var_01]))
	{
		foreach(var_04, var_03 in level.var_947C["script_linkname"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.var_947C["script_linkname"][var_01][var_04] = undefined;
			}
		}

		if(level.var_947C["script_linkname"][var_01].size == 0)
		{
			level.var_947C["script_linkname"][var_01] = undefined;
		}
	}

	var_01 = param_00.var_165;
	if(isdefined(var_01) && isdefined(level.var_947C["script_noteworthy"]) && isdefined(level.var_947C["script_noteworthy"][var_01]))
	{
		foreach(var_04, var_03 in level.var_947C["script_noteworthy"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.var_947C["script_noteworthy"][var_01][var_04] = undefined;
			}
		}

		if(level.var_947C["script_noteworthy"][var_01].size == 0)
		{
			level.var_947C["script_noteworthy"][var_01] = undefined;
		}
	}

	var_01 = param_00.var_1A2;
	if(isdefined(var_01) && isdefined(level.var_947C["target"]) && isdefined(level.var_947C["target"][var_01]))
	{
		foreach(var_04, var_03 in level.var_947C["target"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.var_947C["target"][var_01][var_04] = undefined;
			}
		}

		if(level.var_947C["target"][var_01].size == 0)
		{
			level.var_947C["target"][var_01] = undefined;
		}
	}

	var_01 = param_00.var_1A5;
	if(isdefined(var_01) && isdefined(level.var_947C["targetname"]) && isdefined(level.var_947C["targetname"][var_01]))
	{
		foreach(var_04, var_03 in level.var_947C["targetname"][var_01])
		{
			if(isdefined(var_03) && param_00 == var_03)
			{
				level.var_947C["targetname"][var_01][var_04] = undefined;
			}
		}

		if(level.var_947C["targetname"][var_01].size == 0)
		{
			level.var_947C["targetname"][var_01] = undefined;
		}
	}

	if(isdefined(level.var_9478))
	{
		foreach(var_04, var_03 in level.var_9478)
		{
			if(param_00 == var_03)
			{
				level.var_9478[var_04] = undefined;
			}
		}
	}
}

//Function Number: 466
func_863E(param_00,param_01,param_02,param_03)
{
	if(param_01 == "axis")
	{
		param_00 = param_00 + 2000;
	}
	else if(param_01 == "allies")
	{
		param_00 = param_00 + 1000;
	}

	if(isdefined(param_02))
	{
		param_00 = param_00 + param_02 + 1 * 10000;
	}

	if(isdefined(param_03))
	{
		if(function_02A2(param_03))
		{
			param_00 = param_00 + param_03 + 1 * 1000000;
		}
		else
		{
			common_scripts\utility::func_3809("broadcaster announcement extra data supports numbers only. Invalid extra data: " + param_03);
		}
	}

	setomnvar("ui_broadcaster_announcement",param_00);
}

//Function Number: 467
func_5246()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_0F24();
	}
}

//Function Number: 468
func_0F24()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("applyLoadout");
		var_00 = getentarray("scorestreakclosed","targetname");
		if(var_00.size > 0)
		{
			foreach(var_02 in var_00)
			{
				var_02 enableportalgroup(1,self);
			}
		}

		var_00 = getentarray("scorestreakopen","targetname");
		if(var_00.size > 0)
		{
			foreach(var_02 in var_00)
			{
				var_02 enableportalgroup(0,self);
			}
		}
	}
}

//Function Number: 469
array_combine_no_dupes(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04) && !isdefined(common_scripts\utility::func_F7E(var_02,var_04)))
		{
			var_02[var_02.size] = var_04;
		}
	}

	foreach(var_04 in param_01)
	{
		if(isdefined(var_04) && !isdefined(common_scripts\utility::func_F7E(var_02,var_04)))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 470
unsignedint_to_hexstring_fixed(param_00)
{
	var_01 = "0123456789ABCDEF";
	if(param_00 == 0)
	{
		return var_01[0];
	}

	var_02 = param_00;
	var_03 = "";
	while(param_00 > 0)
	{
		var_03 = var_01[int(param_00 % 16)] + var_03;
		param_00 = param_00 >> 4;
	}

	var_03 = "0x" + var_03;
	return var_03;
}

//Function Number: 471
no_obfuscate(param_00)
{
	return param_00;
}