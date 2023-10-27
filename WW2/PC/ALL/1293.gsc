/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1293.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 60 ms
 * Timestamp: 10/27/2023 3:24:27 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_90B4 = 1.21;
	setdvarifuninitialized("spawning_revised_domination",1);
	setdvarifuninitialized("spawning_revised_teamdeathmatch",1);
	setdvarifuninitialized("spawning_revised_capturetheflag",1);
	setdvarifuninitialized("spawning_revised_hardpoint",1);
	setdvarifuninitialized("spawning_revised_cornersighttraces",0);
	setdvarifuninitialized("spawning_revised_frontline",0);
	setdvarifuninitialized("spawning_revised_fatique",1);
	if(getdvarint("spawning_revised_cornersighttraces") != 0 || getdvarint("spawning_revised_frontline") != 0 || getdvarint("spawning_revised_domination") == 0)
	{
		level.var_90B4 = 1.22;
	}

	level.var_5A77 = 5000;
	level.var_94F3 = 0;
	level.var_689B = 0;
	level.var_689A = 0;
	level.var_9068 = spawnstruct();
	level.var_744A = [];
	level.var_596C = [];
	level.var_6E97 = [];
	function_02CE();
	level.var_486C = [];
	level.var_6248 = [];
	level.var_1FFD = [];
	level.var_9F96 = [];
	level.var_80D8 = [];
	level.var_9FEA = [];
	level.var_9BB5 = [];
	level.var_395E = [];
	level.var_7AD1["allies"] = [];
	level.var_7AD1["axis"] = [];
	level.var_7AD1["all"] = [];
	level.var_7AD4["allies"] = [];
	level.var_7AD4["axis"] = [];
	level.var_7AD4["all"] = [];
	lib_050C::func_534F();
	lib_050E::func_5350();
	level thread func_9091();
	level thread func_9BCD();
	level.var_9E41 = 1;
}

//Function Number: 2
func_908A(param_00,param_01)
{
	var_02 = self;
	if(!param_01)
	{
		level.var_907A = func_3915(level.var_907A,var_02.var_116);
		level.var_9077 = func_3914(level.var_9077,var_02.var_116);
	}

	var_02.var_3E3E = anglestoforward(var_02.var_1D);
	var_02.var_8C4D = var_02.var_116 + (0,0,50);
	var_02.var_5BE2 = gettime();
	var_02.var_6C97 = 1;
	var_02.var_52B2 = 1;
	var_02.var_5700 = param_00;
	var_02.var_CAD = [];
	var_03 = 1024;
	if(!bullettracepassed(var_02.var_8C4D,var_02.var_8C4D + (0,0,var_03),0,undefined))
	{
		var_04 = var_02.var_8C4D + var_02.var_3E3E * 100;
		if(!bullettracepassed(var_04,var_04 + (0,0,var_03),0,undefined))
		{
			var_02.var_6C97 = 0;
		}
	}

	var_05 = anglestoright(var_02.var_1D);
	if(!maps\mp\_utility::func_579B())
	{
		func_0996(var_02,var_02.var_116 + var_05 * 45);
		func_0996(var_02,var_02.var_116 - var_05 * 45);
	}

	var_02.var_78CC = func_463E(var_02.var_116);
	if(var_02.var_78CC.size <= 0)
	{
		if(!isdefined(level.var_585D) || !level.var_585D)
		{
		}
	}

	func_5351(var_02);
	if(isdefined(var_02.var_165))
	{
		if((isdefined(game["switchedsides"]) && game["switchedsides"] && var_02.var_165 == "axis_override") || (!isdefined(game["switchedsides"]) || !game["switchedsides"]) && var_02.var_165 == "allies_override")
		{
			var_02.var_9849 = "allies";
		}
		else if((isdefined(game["switchedsides"]) && game["switchedsides"] && var_02.var_165 == "allies_override") || (!isdefined(game["switchedsides"]) || !game["switchedsides"]) && var_02.var_165 == "axis_override")
		{
			var_02.var_9849 = "axis";
		}

		if(isdefined(var_02.var_9849) && maps\mp\_utility::func_4571() == "mp_france_village" && level.var_3FDC == "ball")
		{
			var_02.var_9849 = maps\mp\_utility::func_45DE(var_02.var_9849);
		}
	}
}

//Function Number: 3
func_0996(param_00,param_01)
{
	var_02 = playerphysicstrace(param_00.var_116,param_00.var_116 + (0,0,18));
	var_03 = var_02[2] - param_00.var_116[2];
	var_04 = (param_01[0],param_01[1],param_01[2] + var_03);
	var_05 = playerphysicstrace(var_02,var_04);
	if(var_05 != var_04)
	{
		return;
	}

	var_06 = function_0236(var_04);
	if(abs(var_06[2] - param_01[2]) > 128)
	{
		return;
	}

	param_00.var_CAD[param_00.var_CAD.size] = var_06;
}

//Function Number: 4
func_9BCD()
{
	for(;;)
	{
		level.var_486C = getentarray("grenade","classname");
		level.var_6248 = getentarray("rocket","classname");
		level.var_1FFD = getentarray("care_package","targetname");
		wait 0.05;
	}
}

//Function Number: 5
func_10E5(param_00,param_01)
{
	if(isdefined(game["switchedsides"]) && game["switchedsides"])
	{
		param_00 = maps\mp\_utility::func_45DE(param_00);
	}

	if(isdefined(level.var_9307) && isdefined(level.var_9307[param_00]))
	{
	}

	level.var_9307[param_00] = param_01;
	if(!isdefined(level.var_908E))
	{
		level.var_908E = [];
	}

	level.var_908F[param_00] = [];
	var_02 = setstartspawnpoints(param_01,param_00);
	if(!var_02.size)
	{
		return;
	}

	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03] func_908A(0,0);
		level.var_908E[level.var_908E.size] = var_02[var_03];
		level.var_908F[param_00][level.var_908F[param_00].size] = var_02[var_03];
	}

	foreach(var_05 in var_02)
	{
		var_05.var_7702 = 1;
		var_06 = anglestoforward(var_05.var_1D);
		foreach(var_08 in var_02)
		{
			if(var_05 == var_08)
			{
				continue;
			}

			var_09 = vectornormalize(var_08.var_116 - var_05.var_116);
			var_0A = vectordot(var_06,var_09);
			if(var_0A > 0.86)
			{
				var_05.var_7702 = 0;
				break;
			}
		}
	}
}

//Function Number: 6
func_10DF(param_00)
{
	level.var_8FDC = param_00;
	level.var_908C = [];
	var_01 = setgamespawnpoints(level.var_8FDC);
	if(!var_01.size)
	{
	}

	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.var_52B2))
		{
			var_03 func_908A(1,0);
			level.var_908C[level.var_908C.size] = var_03;
		}
	}
}

//Function Number: 7
func_10DC(param_00)
{
	level.var_908C = [];
	var_01 = function_027A("mp/spawnClasses.csv");
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = tablelookupbyrow("mp/spawnClasses.csv",var_02,1);
		var_04 = [];
		var_04 = setgamespawnpoints(var_03);
		if(!var_04.size)
		{
		}

		foreach(var_06 in var_04)
		{
			if(!isdefined(var_06.var_52B2))
			{
				var_06 func_908A(1,0);
				level.var_908C[level.var_908C.size] = var_06;
			}
		}
	}

	level.var_8FDC = param_00;
}

//Function Number: 8
func_10E4()
{
	var_00 = tablelookup("mp/spawnClasses.csv",0,level.var_3FDC,2);
	var_01 = tablelookup("mp/spawnClasses.csv",0,level.var_3FDC,3);
	var_02 = tablelookup("mp/spawnClasses.csv",0,level.var_3FDC,1);
	level.var_907A = (0,0,0);
	level.var_9077 = (0,0,0);
	if(isdefined(var_00) && var_00 != "none")
	{
		func_10E5("allies",var_00);
	}

	if(isdefined(var_01) && var_01 != "none")
	{
		func_10E5("axis",var_01);
	}

	if(getdvarint("5234",0) == 1)
	{
		func_10DC(var_02);
	}
	else if(isdefined(var_02) && var_02 != "none")
	{
		func_10DF(var_02);
	}

	j_//nullsub_350();
	level.var_5FEB = func_3B89(level.var_907A,level.var_9077);
	if(level.var_3FDC == "air" || level.var_3FDC == "aces")
	{
		level.var_5FEB = (0,0,0);
	}

	if(maps\mp\_utility::func_4571() == "mp_shipment_s2")
	{
		level.var_5FEB = (-938.5,7275.5,-476);
	}
	else if(maps\mp\_utility::func_4571() == "mp_sandbox_01")
	{
		level.var_5FEB = (470,30.5,920);
	}

	setmapcenter(level.var_5FEB);
	lib_050E::func_2B5D();
}

//Function Number: 9
func_5661(param_00,param_01)
{
	if(!isdefined(param_01.var_1A5) || param_01.var_1A5 == "")
	{
		return 1;
	}

	if(issubstr(param_01.var_1A5,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
func_28C0(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "free";
	}

	var_02 = [];
	var_03 = getgamespawnpointactivelabel(param_00);
	if(level.var_3FDC == "zombies" && isdefined(level.zombies_active_spawn_event))
	{
		var_03 = level.zombies_active_spawn_event;
	}

	foreach(var_05 in param_01)
	{
		if(func_5661(var_03,var_05))
		{
			var_02 = common_scripts\utility::func_972(var_02,var_05);
		}
	}

	return var_02;
}

//Function Number: 11
func_46A0(param_00)
{
	if(!isdefined(param_00) && isdefined(level.var_908E) && level.var_908E.size > 0)
	{
		return level.var_908E;
	}

	if(isdefined(param_00) && isdefined(level.var_908F) && isdefined(level.var_908F[param_00]) && level.var_908F[param_00].size > 0)
	{
		return level.var_908F[param_00];
	}

	return level.var_908C;
}

//Function Number: 12
func_44F9(param_00)
{
	if(isdefined(level.var_908C) && level.var_908C.size > 0)
	{
		var_01 = level.var_908C;
	}
	else if(!isdefined(var_01))
	{
		var_01 = level.var_908E;
	}
	else
	{
		var_01 = level.var_908F[var_01];
	}

	return func_28C0(param_00,var_01);
}

//Function Number: 13
func_448B(param_00)
{
	if(!isdefined(param_00))
	{
		return level.var_908E;
	}

	return level.var_908F[param_00];
}

//Function Number: 14
func_448A(param_00)
{
	return level.var_908C;
}

//Function Number: 15
func_3F9B()
{
	return isdefined(level.var_908C) && level.var_908C.size > 0 && isdefined(level.var_908F["allies"]) && level.var_908F["allies"].size > 0 && isdefined(level.var_908F["axis"]) && level.var_908F["axis"].size > 0;
}

//Function Number: 16
func_3ACC(param_00)
{
	var_01 = "zombie_checkpoint_" + getdvarint("scr_zombieCheckpoint",0);
	var_02 = "zombie_safe_haven_" + getdvarint("scr_zombieSafeHaven",0);
	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(isdefined(var_05.var_1A5))
		{
			if(function_02C6(var_05.var_1A5,"zombie_event_spawn_"))
			{
				continue;
			}
		}

		if(isdefined(var_05.var_165))
		{
			if(function_02C6(var_05.var_165,"zombie_safe_haven_"))
			{
				if(var_05.var_165 != var_02)
				{
					continue;
				}
			}

			if(function_02C6(var_05.var_165,"zombie_checkpoint_"))
			{
				if(var_05.var_165 != var_01)
				{
					continue;
				}
			}
		}

		var_03[var_03.size] = var_05;
	}

	if(var_03.size == 0)
	{
		var_03 = param_00;
	}

	return var_03;
}

//Function Number: 17
filterspawnpointszombiesactiveevent(param_00)
{
	var_01 = "zombie_event_spawn_";
	if(isdefined(level.zombies_active_spawn_event))
	{
		var_01 = var_01 + level.zombies_active_spawn_event;
	}

	var_02 = [];
	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(isdefined(var_05.var_1A5) && var_05.var_1A5 == var_01)
		{
			var_02[var_02.size] = var_05;
			continue;
		}

		if(!isdefined(var_05.var_1A5) || var_05.var_1A5 == "")
		{
			var_03[var_03.size] = var_05;
		}
	}

	if(var_02.size == 0)
	{
		if(var_03.size > 0)
		{
			var_02 = var_03;
		}
		else
		{
			var_02 = param_00;
		}
	}

	return var_02;
}

//Function Number: 18
func_908D(param_00,param_01)
{
	var_02 = param_00.var_487A;
	var_03 = param_01.var_487A;
	var_04["allies"] = 0;
	var_04["axis"] = 0;
	foreach(var_06 in func_448A())
	{
		var_07 = undefined;
		var_08 = undefined;
		if(func_5770())
		{
			var_07 = getpathdist(var_06.var_116,var_02,999999);
			var_08 = getpathdist(var_06.var_116,var_03,999999);
		}

		if(!isdefined(var_07) || var_07 == -1)
		{
			var_07 = distancesquared(var_02,var_06.var_116);
		}

		if(!isdefined(var_08) || var_08 == -1)
		{
			var_08 = distancesquared(var_03,var_06.var_116);
		}

		if(!isdefined(var_06.var_9849))
		{
			iprintlnbold("Side-Based Spawn Point not assigned to a side at ( " + var_06.var_116[0] + ", " + var_06.var_116[1] + ", " + var_06.var_116[2] + " )");
			continue;
		}

		var_06.var_984B = var_04[var_06.var_9849];
		var_04[var_06.var_9849]++;
		if(var_06.var_9849 == "allies")
		{
			var_06.var_3ED1 = param_00;
			var_06.var_3ED2 = var_07;
			var_06.var_3767 = var_08;
		}
		else
		{
			var_06.var_3ED1 = param_01;
			var_06.var_3ED2 = var_08;
			var_06.var_3767 = var_07;
		}

		var_09 = var_06.var_3ED2 / var_06.var_3767;
		if(!isdefined(var_06.var_3ED1.var_4D3F) || var_06.var_3ED1.var_4D3F < var_09)
		{
			var_06.var_3ED1.var_4D3F = var_09;
		}

		if(!isdefined(var_06.var_3ED1.var_645F) || var_06.var_3ED1.var_645F == -1 || var_06.var_3767 < var_06.var_3ED1.var_645F)
		{
			var_06.var_3ED1.var_645F = var_06.var_3767;
		}
	}

	foreach(var_06 in func_448A())
	{
		var_06.var_984A = var_04[var_06.var_9849];
	}
}

//Function Number: 19
func_5770()
{
	if(!isdefined(level.var_6ED7))
	{
		var_00 = getallnodes();
		level.var_6ED7 = isdefined(var_00) && var_00.size > 150;
	}

	return level.var_6ED7;
}

//Function Number: 20
func_09FA()
{
	level.var_6E97[level.var_6E97.size] = self;
}

//Function Number: 21
func_7CDF()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.var_6E97.size;var_01++)
	{
		if(level.var_6E97[var_01] == self)
		{
			var_00 = 1;
			while(var_01 < level.var_6E97.size - 1)
			{
				level.var_6E97[var_01] = level.var_6E97[var_01 + 1];
				var_01++;
			}

			level.var_6E97[var_01] = undefined;
			break;
		}
	}
}

//Function Number: 22
func_9091()
{
	if(isdefined(level.var_585D) && level.var_585D)
	{
		return;
	}

	if(isdefined(level.var_A259) && level.var_A259)
	{
		return;
	}

	while(!isdefined(level.var_8FDC) && !isdefined(level.var_9307) || !isdefined(level.var_9307["allies"]))
	{
		wait 0.05;
	}

	if(getdvarint("5234",0) == 1)
	{
	}

	var_00 = [];
	if(isdefined(level.var_8FDC))
	{
		if(level.var_908C.size == 0)
		{
			common_scripts\utility::func_3809("Cannot generate visibility data. No Spawnpoints found.");
		}

		for(var_01 = 0;var_01 < level.var_908C.size;var_01++)
		{
			for(var_02 = 0;var_02 < level.var_908C[var_01].var_78CC.size;var_02++)
			{
				var_00[var_00.size] = level.var_908C[var_01].var_78CC[var_02];
			}
		}
	}

	if(var_00.size > 0 || maps\mp\_utility::func_579B())
	{
		function_0305(var_00,level.var_9036["LOSDistance"]);
		return;
	}

	if(isdefined(level.var_8FDC))
	{
		var_03 = "Cannot generate visibility data. There are no \'" + level.var_8FDC + "\' pathnodes near any spawnpoints.";
		foreach(var_05 in var_00)
		{
			var_03 = var_03 + "\nNode at " + var_05.var_116;
		}

		var_03 = var_03 + "\nMake sure you compile with Connect Paths checked";
		common_scripts\utility::func_3809(var_03);
		if(getdvarint("5234",0) != 0)
		{
			function_0308(-1);
			return;
		}
	}
}

//Function Number: 23
func_4402()
{
	var_00 = function_02D6();
	foreach(var_02 in var_00)
	{
		var_02.var_9076 = function_02D5(var_02);
	}

	return var_00;
}

//Function Number: 24
func_A167()
{
	level.var_90B5 = func_4402();
	foreach(var_01 in level.var_90B5)
	{
		var_01.var_90B6 = undefined;
	}

	foreach(var_04 in level.var_9F96)
	{
		var_04.var_9076 = function_02D5(var_04);
		level.var_90B5[level.var_90B5.size] = var_04;
		var_04.var_90B6 = undefined;
	}

	foreach(var_07 in level.var_9FEA)
	{
		var_07.var_9076 = function_02D5(var_07);
		level.var_90B5[level.var_90B5.size] = var_07;
		var_07.var_90B6 = undefined;
	}
}

//Function Number: 25
func_8BA8(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in level.var_6E97)
	{
		if(!function_02ED(var_04))
		{
			var_02++;
		}
	}

	if(param_01 + var_02 > param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
func_5351(param_00)
{
	func_240E(param_00);
}

//Function Number: 27
func_240E(param_00)
{
	if(level.var_984D)
	{
		foreach(var_02 in level.var_985B)
		{
			func_2410(param_00,var_02);
		}

		return;
	}

	func_2410(param_00,"none");
}

//Function Number: 28
func_2410(param_00,param_01)
{
	param_00.var_3EFF[param_01] = 0;
	param_00.var_266E[param_01] = 0;
	param_00.var_5EAD[param_01] = 0;
	param_00.var_6221[param_01] = 1;
}

//Function Number: 29
func_3B4A(param_00)
{
	var_01 = gettime();
	self.var_5BE0 = param_00;
	self.var_5BE2 = var_01;
	param_00.var_5BE2 = var_01;
	param_00.var_5BE1 = self.var_1A7;
	var_02["position"] = param_00.var_116;
	var_02["time"] = var_01;
	if(level.var_984D)
	{
		level.var_7AD4[self.var_1A7][level.var_7AD4[self.var_1A7].size] = var_02;
		return;
	}

	var_02["player"] = self.var_48CA;
	level.var_7AD4["all"][level.var_7AD4["all"].size] = var_02;
}

//Function Number: 30
func_3916(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		level.var_907A = func_3915(level.var_907A,param_00[var_01].var_116);
		level.var_9077 = func_3914(level.var_9077,param_00[var_01].var_116);
	}
}

//Function Number: 31
func_3915(param_00,param_01)
{
	if(param_00[0] > param_01[0])
	{
		param_00 = (param_01[0],param_00[1],param_00[2]);
	}

	if(param_00[1] > param_01[1])
	{
		param_00 = (param_00[0],param_01[1],param_00[2]);
	}

	if(param_00[2] > param_01[2])
	{
		param_00 = (param_00[0],param_00[1],param_01[2]);
	}

	return param_00;
}

//Function Number: 32
func_3914(param_00,param_01)
{
	if(param_00[0] < param_01[0])
	{
		param_00 = (param_01[0],param_00[1],param_00[2]);
	}

	if(param_00[1] < param_01[1])
	{
		param_00 = (param_00[0],param_01[1],param_00[2]);
	}

	if(param_00[2] < param_01[2])
	{
		param_00 = (param_00[0],param_00[1],param_01[2]);
	}

	return param_00;
}

//Function Number: 33
func_3B89(param_00,param_01)
{
	var_02 = (0,0,0);
	var_02 = param_01 - param_00;
	var_02 = (var_02[0] / 2,var_02[1] / 2,var_02[2] / 2) + param_00;
	return var_02;
}

//Function Number: 34
func_86C5()
{
	level.var_907A = (0,0,0);
	level.var_9077 = (0,0,0);
	func_3916(setstartspawnpoints("mp_tdm_spawn_allies_start","allies"));
	func_3916(setstartspawnpoints("mp_tdm_spawn_axis_start","axis"));
	level.var_5FEB = func_3B89(level.var_907A,level.var_9077);
	j_//nullsub_350();
	setmapcenter(level.var_5FEB);
}

//Function Number: 35
func_463E(param_00)
{
	var_01 = [];
	var_02 = function_00BA(param_00);
	if(isdefined(var_02))
	{
		var_01[0] = var_02;
	}

	if(!isdefined(var_02))
	{
		var_01 = getnodesinradius(param_00,func_445F(),0,256,"path");
		if(var_01.size == 0)
		{
			var_01 = getnodesinradius(param_00,250,0,256,"path");
		}
	}

	return var_01;
}

//Function Number: 36
func_3892(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_gameobjects::func_44B9(param_01);
	func_2410(param_00,var_02);
	var_03 = undefined;
	var_04 = func_580F();
	var_05 = getdvarfloat("scr_lowerLimitFullSights");
	var_06 = getdvarfloat("scr_lowerLimitCornerSights");
	foreach(var_08 in level.var_90B5)
	{
		if(isdefined(level.valid_spawn_viewer) && ![[ level.valid_spawn_viewer ]](var_08))
		{
			continue;
		}

		if(level.var_984D && var_08.var_9076 != var_02)
		{
			continue;
		}

		if(param_00.var_3EFF[var_08.var_9076])
		{
			break;
		}

		if(!isdefined(var_08.var_90B6))
		{
			var_08.var_90B6 = var_08 method_859E(func_44D5());
			if(!isdefined(var_08.var_90B6) || var_08.var_90B6.size == 0)
			{
				if(isdefined(level.var_602F) && var_04 && isplayer(var_08))
				{
					if(!isdefined(var_08.var_5BCA) || var_08.var_5BCA != gettime())
					{
						[[ level.var_602F ]]("LOG_GENERIC_MESSAGE",gettime(),"WARNING: Could not use TTLOS data for player " + var_08.var_109);
						var_08.var_5BCA = gettime();
					}
				}
			}
		}

		var_09 = [];
		if(var_04 && isdefined(var_08.var_90B6) && var_08.var_90B6.size > 0)
		{
			var_09 = precomputedlosdatatest(var_08.var_90B6,param_00.var_78CC);
			if(isdefined(var_09))
			{
				var_03 = var_09[0];
			}
		}

		if(!isdefined(var_03))
		{
			var_03 = 0;
		}

		if(!isdefined(param_00.var_6221[var_08.var_9076]) || var_03 < param_00.var_6221[var_08.var_9076])
		{
			param_00.var_6221[var_08.var_9076] = var_03;
		}

		if(var_03 > var_05)
		{
			param_00.var_3EFF[var_08.var_9076]++;
			param_00.var_5EAD[var_08.var_9076]++;
			continue;
		}

		if(var_03 > var_06)
		{
			param_00.var_266E[var_08.var_9076]++;
		}
	}
}

//Function Number: 37
func_445F()
{
	return 130;
}

//Function Number: 38
func_44D5()
{
	return 250;
}

//Function Number: 39
func_4576()
{
	return 2550;
}

//Function Number: 40
func_580F()
{
	return function_0304();
}