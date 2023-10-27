/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_divide\mp_divide.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 1077 ms
 * Timestamp: 10/27/2023 12:13:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	lib_0F94::main();
	scripts\mp\maps\mp_divide\gen\mp_divide_art::main();
	lib_0F93::main();
	scripts\mp\_load::main();
	scripts\mp\_compass::func_FACD("compass_map_mp_divide");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraMinObjectContribution",8);
	setdvar("r_umbraAccurateOcclusionThreshold",400);
	setdvar("r_tessellationFactor",40);
	setdvar("r_tessellationCutoffFalloff",256);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	thread scripts\mp\_animation_suite::func_1FAA();
	thread func_E838();
	thread func_CDA4("mp_divide_screens");
	thread fix_collision();
	thread kill_triggers();
	thread fix_umbra();
	thread fix_broshot();
	thread spawn_oob_trigger();
}

//Function Number: 2
fix_collision()
{
	var_00 = getent("clip256x256x128","targetname");
	var_01 = spawn("script_model",(-1696,416,1204));
	var_01.angles = (90,270,0);
	var_01 clonebrushmodeltoscriptmodel(var_00);
	var_02 = spawn("script_model",(-1696,416,1460));
	var_02.angles = (90,270,0);
	var_02 clonebrushmodeltoscriptmodel(var_00);
	var_03 = spawn("script_model",(-1696,416,1716));
	var_03.angles = (90,270,0);
	var_03 clonebrushmodeltoscriptmodel(var_00);
	var_04 = getent("clip256x256x128","targetname");
	var_05 = spawn("script_model",(-1520,-464,752));
	var_05.angles = (0,0,0);
	var_05 clonebrushmodeltoscriptmodel(var_04);
	var_06 = getent("clip256x256x128","targetname");
	var_07 = spawn("script_model",(-1312,-464,752));
	var_07.angles = (0,0,0);
	var_07 clonebrushmodeltoscriptmodel(var_06);
	var_08 = getent("clip64x64x256","targetname");
	var_09 = spawn("script_model",(1346,822,872));
	var_09.angles = (0,15,0);
	var_09 clonebrushmodeltoscriptmodel(var_08);
	var_0A = getent("clip64x64x256","targetname");
	var_0B = spawn("script_model",(1346,822,1120));
	var_0B.angles = (0,15,0);
	var_0B clonebrushmodeltoscriptmodel(var_0A);
	var_0C = spawn("script_model",(-384,-576,704));
	var_0C.angles = (0,0,0);
	var_0C setmodel("mp_divide_nosight_drill_02");
	var_0D = getent("player32x32x128","targetname");
	var_0E = spawn("script_model",(-2672,704,800));
	var_0E.angles = (0,0,0);
	var_0E clonebrushmodeltoscriptmodel(var_0D);
	var_0F = getent("player32x32x128","targetname");
	var_10 = spawn("script_model",(-2344,904,968));
	var_10.angles = (4,0,0);
	var_10 clonebrushmodeltoscriptmodel(var_0F);
	var_11 = getent("player128x128x8","targetname");
	var_12 = spawn("script_model",(-1324,-10,600));
	var_12.angles = (0,0,0);
	var_12 clonebrushmodeltoscriptmodel(var_11);
	var_13 = getent("player32x32x128","targetname");
	var_14 = spawn("script_model",(-1252,-74,592));
	var_14.angles = (270,358,-88);
	var_14 clonebrushmodeltoscriptmodel(var_13);
	var_15 = getent("player32x32x128","targetname");
	var_16 = spawn("script_model",(-864,-884,588));
	var_16.angles = (270,330,-60);
	var_16 clonebrushmodeltoscriptmodel(var_15);
}

//Function Number: 3
kill_triggers()
{
	var_00 = spawn("trigger_radius",(2588,732,438),0,256,128);
	var_00.var_257 = 256;
	var_00.height = 128;
	var_00 thread kill_trigger_loop("script_vehicle");
	var_01 = spawn("trigger_radius",(-268,884,388),0,550,128);
	var_01.var_257 = 550;
	var_01.height = 128;
	var_01 thread kill_trigger_loop("script_vehicle");
}

//Function Number: 4
kill_trigger_loop(param_00)
{
	for(;;)
	{
		self waittill("trigger",var_01);
		if(isdefined(var_01) && isdefined(var_01.classname) && var_01.classname == param_00)
		{
			if(isdefined(var_01.var_110EA))
			{
				if(var_01.var_110EA == "minijackal")
				{
					var_01 notify("minijackal_end");
					continue;
				}

				if(var_01.var_110EA == "venom")
				{
					var_01 notify("venom_end",var_01.origin);
				}
			}
		}
	}
}

//Function Number: 5
fix_umbra()
{
	var_00 = spawn("script_model",(-1880.5,575.5,762));
	var_00 setmodel("building_stilt_support_leg_arm_cylinder_01_mp_divide_patch");
	var_00.angles = (180,-45,90);
}

//Function Number: 6
fix_broshot()
{
	var_00 = getent("character_loc_broshot_a","targetname");
	var_01 = getent("character_loc_broshot_b","targetname");
	var_02 = getent("character_loc_broshot_c","targetname");
	var_03 = getent("character_loc_broshot_d","targetname");
	var_04 = var_00.origin;
	var_00.origin = (var_04[0],var_04[1],505);
	var_04 = var_01.origin;
	var_01.origin = (var_04[0],var_04[1],507);
	var_04 = var_02.origin;
	var_02.origin = (var_04[0],var_04[1],498);
	var_04 = var_03.origin;
	var_03.origin = (var_04[0],var_04[1],510);
}

//Function Number: 7
func_E838()
{
}

//Function Number: 8
mpdividecollisionfunc(param_00)
{
	if(param_00.origin[2] - self.origin[2] > 30)
	{
		param_00 method_84DC((0,-40,10),200);
		return;
	}

	param_00 scripts\mp\_movers::func_BCDE();
}

//Function Number: 9
func_1F87()
{
	level endon("game_ended");
	var_00 = getentarray("animObj_container","targetname");
	var_01 = getentarray("animObj_barrier_entry","targetname");
	var_02 = getentarray("animObj_barrier_exit","targetname");
	var_03 = getentarray("door_interior_sliding","targetname");
	var_04 = getentarray("door_exterior_raising","targetname");
	foreach(var_06 in var_00)
	{
		if(var_06.classname == "script_brushmodel")
		{
			var_06.var_12BEC = 10;
			var_06.var_12BE8 = 1;
			var_06.var_12BE7 = ::mpdividecollisionfunc;
		}

		var_06 method_8318(1);
		var_06 method_8317(1);
	}

	var_00 func_110C1();
	var_01 func_110C1();
	var_02 func_110C1();
	var_08 = 10;
	var_09 = 27;
	for(;;)
	{
		func_E268(var_00);
		wait(0.1);
		thread func_1F6C(var_00,var_08);
		thread func_1F76(var_03,var_08);
		wait(var_08 - 7);
		thread func_1F71(var_01);
		wait(7);
		thread func_1F6D(var_00,var_09);
		wait(var_09 - 24);
		thread func_1F72(var_02);
		thread func_1F73(var_04,var_09);
		wait(24);
		func_1F6B(var_04);
		wait(3.5);
	}
}

//Function Number: 10
func_110C1()
{
	foreach(var_01 in self)
	{
		var_01.var_10B89 = var_01.origin;
	}
}

//Function Number: 11
func_E268(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 movez(-200,0.01);
	}

	wait(0.1);
	foreach(var_02 in param_00)
	{
		var_02 moveto((var_02.var_10B89[0],var_02.var_10B89[1],var_02.var_10B89[2]),0.01);
	}
}

//Function Number: 12
func_1F6C(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		var_03 movex(363,param_01);
	}
}

//Function Number: 13
func_1F76(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		var_03 movey(144,1.5,0,0.5);
	}

	wait(param_01);
	foreach(var_03 in param_00)
	{
		var_03 movey(-144,2,0,0.5);
	}
}

//Function Number: 14
func_1F71(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "barrier_top")
		{
			var_02 movez(36,2,0.5,0.5);
			continue;
		}

		var_02 movez(56,2,0.5,0.5);
	}

	wait(5);
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "barrier_top")
		{
			var_02 movez(-36,2,0.5,0.5);
			continue;
		}

		var_02 movez(-56,2,0.5,0.5);
	}
}

//Function Number: 15
func_1F6D(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		var_03 movey(1050,param_01);
	}
}

//Function Number: 16
func_1F72(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 movez(43,2,0.2,0.2);
	}

	wait(8);
	foreach(var_02 in param_00)
	{
		var_02 movez(-43,2,0.2,0.2);
	}
}

//Function Number: 17
func_1F73(param_00,param_01)
{
	wait(5);
	foreach(var_03 in param_00)
	{
		var_03 movez(84,2.5,0,0.5);
	}
}

//Function Number: 18
func_1F6B(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 movez(-84,3,0,0.5);
	}
}

//Function Number: 19
func_CDA4(param_00)
{
	wait(30);
	function_030E(param_00);
}

//Function Number: 20
spawn_oob_trigger()
{
	if(level.gametype == "sd" || level.gametype == "sr")
	{
		var_00 = spawn("trigger_radius",(340,1120,280),0,250,300);
		var_00 hide();
		level.var_C7B3[level.var_C7B3.size] = var_00;
	}

	var_01 = spawn("trigger_radius",(-757,825,1040),0,100,50);
	var_01 hide();
	level.var_C7B3[level.var_C7B3.size] = var_01;
}