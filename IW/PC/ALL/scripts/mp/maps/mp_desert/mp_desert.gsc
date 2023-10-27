/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_desert\mp_desert.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 287 ms
 * Timestamp: 10/27/2023 12:13:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	lib_0F92::main();
	scripts\mp\maps\mp_desert\gen\mp_desert_art::main();
	lib_0F91::main();
	scripts\mp\_load::main();
	scripts\mp\_compass::func_FACD("compass_map_mp_desert");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraAccurateOcclusionThreshold",1200);
	setdvar("r_umbraMinObjectContribution",8);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	thread func_FAE6("roomba",32,1);
	thread func_FAE6("roomba2",16,0.15);
	thread fix_collision();
	runmodespecifictriggers();
}

//Function Number: 2
fix_collision()
{
	var_00 = getent("clip64x64x128","targetname");
	var_01 = spawn("script_model",(2342,-92,354));
	var_01.angles = (2,50,2);
	var_01 clonebrushmodeltoscriptmodel(var_00);
	var_02 = getent("clip64x64x256","targetname");
	var_03 = spawn("script_model",(2292,-212,362));
	var_03.angles = (6,51,18);
	var_03 clonebrushmodeltoscriptmodel(var_02);
	var_04 = getent("clip256x256x8","targetname");
	var_05 = spawn("script_model",(996,796,524));
	var_05.angles = (0,335,90);
	var_05 clonebrushmodeltoscriptmodel(var_04);
	var_06 = spawn("script_model",(313.1,-516,470));
	var_06.angles = (356.01,210.28,-4.00982);
	var_06 setmodel("mp_desert_uplink_col_01");
	var_07 = getent("clip512x512x8","targetname");
	var_08 = spawn("script_model",(896,656,584));
	var_08.angles = (0,0,0);
	var_08 clonebrushmodeltoscriptmodel(var_07);
	var_09 = spawn("script_model",(1064,616,584));
	var_09.angles = (0,45,0);
	var_09 clonebrushmodeltoscriptmodel(var_07);
	var_0A = spawn("script_model",(-2841.4,-24.5,757.2));
	var_0A.angles = (303,309,145);
	var_0A setmodel("rock_large_titan_02_mp_desert_patch");
	var_0B = getent("player32x32x8","targetname");
	var_0C = spawn("script_model",(-2044,116,572));
	var_0C.angles = (285,225,0);
	var_0C clonebrushmodeltoscriptmodel(var_0B);
	var_0D = spawn("script_model",(-1932,4,572));
	var_0D.angles = (285,225,0);
	var_0D clonebrushmodeltoscriptmodel(var_0B);
	var_0E = getent("clip128x128x256","targetname");
	var_0F = spawn("script_model",(-764,-1376,712));
	var_0F.angles = (0,0,0);
	var_0F clonebrushmodeltoscriptmodel(var_0E);
	var_10 = getent("clip128x128x256","targetname");
	var_11 = spawn("script_model",(1216,-1576,704));
	var_11.angles = (0,0,30);
	var_11 clonebrushmodeltoscriptmodel(var_10);
	var_12 = getent("clip128x128x128","targetname");
	var_13 = spawn("script_model",(1256,-1592,816));
	var_13.angles = (15,0,0);
	var_13 clonebrushmodeltoscriptmodel(var_12);
	var_14 = getent("player256x256x256","targetname");
	var_15 = spawn("script_model",(1232,-1640,896));
	var_15.angles = (0,0,0);
	var_15 clonebrushmodeltoscriptmodel(var_14);
	var_16 = getent("clip256x256x256","targetname");
	var_17 = spawn("script_model",(72,-8,832));
	var_17.angles = (15,300,15);
	var_17 clonebrushmodeltoscriptmodel(var_16);
	var_18 = getent("player256x256x256","targetname");
	var_19 = spawn("script_model",(-1840,-1296,720));
	var_19.angles = (0,330,-30);
	var_19 clonebrushmodeltoscriptmodel(var_18);
	var_1A = getent("player256x256x256","targetname");
	var_1B = spawn("script_model",(-1776,-1136,552));
	var_1B.angles = (340,290,-22);
	var_1B clonebrushmodeltoscriptmodel(var_1A);
	var_1C = spawn("script_model",(832,-464,712));
	var_1C.angles = (10,30,33);
	var_1C setmodel("mp_quarry_uplink_02");
	var_1D = spawn("script_model",(1572,-324,696));
	var_1D.angles = (270,15,-120);
	var_1D setmodel("mp_quarry_uplink_02");
	var_1E = spawn("script_model",(-2292,256,368));
	var_1E.angles = (270,90,0);
	var_1E setmodel("mp_desert_uplink_col_01");
	var_1F = spawn("script_model",(-2108,256,308));
	var_1F.angles = (300,0,90);
	var_1F setmodel("mp_desert_uplink_col_01");
	var_20 = spawn("script_model",(-2748,704,448));
	var_20.angles = (0,195,-180);
	var_20 setmodel("mp_desert_uplink_col_01");
	var_21 = getent("player64x64x128","targetname");
	var_22 = spawn("script_model",(-1376,1056,560));
	var_22.angles = (0,0,0);
	var_22 clonebrushmodeltoscriptmodel(var_21);
	var_23 = getent("player64x64x128","targetname");
	var_24 = spawn("script_model",(-2068,-872,404));
	var_24.angles = (90,4,69);
	var_24 clonebrushmodeltoscriptmodel(var_23);
	var_25 = getent("player64x64x128","targetname");
	var_26 = spawn("script_model",(-910,-75,392));
	var_26.angles = (1.7,294,90);
	var_26 clonebrushmodeltoscriptmodel(var_25);
	var_27 = getent("player128x128x128","targetname");
	var_28 = spawn("script_model",(-1512,864,518));
	var_28.angles = (352,0,0);
	var_28 clonebrushmodeltoscriptmodel(var_27);
	var_29 = getent("player64x64x64","targetname");
	var_2A = spawn("script_model",(232,-246,-58));
	var_2A.angles = (0,34,0);
	var_2A clonebrushmodeltoscriptmodel(var_29);
	var_2B = getent("player64x64x64","targetname");
	var_2C = spawn("script_model",(200,-192,-58));
	var_2C.angles = (0,30,0);
	var_2C clonebrushmodeltoscriptmodel(var_2B);
	var_2D = getent("player64x64x128","targetname");
	var_2E = spawn("script_model",(1109,-1007,629));
	var_2E.angles = (10,180,125);
	var_2E clonebrushmodeltoscriptmodel(var_2D);
	var_2F = getent("player64x64x128","targetname");
	var_30 = spawn("script_model",(1133,-1147,637));
	var_30.angles = (90,88.8,-16);
	var_30 clonebrushmodeltoscriptmodel(var_2F);
	var_31 = getent("player64x64x128","targetname");
	var_32 = spawn("script_model",(-920,-58,454));
	var_32.angles = (1.7,302,90);
	var_32 clonebrushmodeltoscriptmodel(var_31);
}

//Function Number: 3
func_FAE6(param_00,param_01,param_02)
{
	var_03 = getent(param_00,"targetname");
	var_03.var_5293 = scripts\common\utility::getstruct(var_03.target,"targetname");
	var_03.var_BCEF = 1 / param_01;
	var_03.var_5293 = func_E6E1(var_03,param_02);
}

//Function Number: 4
func_E6E1(param_00,param_01)
{
	param_00 endon("death");
	var_02 = scripts\common\utility::getstruct(param_00.var_5293.target,"targetname");
	var_03 = abs(distance(param_00.origin,var_02.origin) * param_00.var_BCEF);
	param_00 playloopsound("rolling_bot_move_lp");
	param_00 moveto(var_02.origin,var_03,var_03 * 0.25,var_03 * 0.25);
	wait(var_03);
	param_00 stoploopsound("rolling_bot_move_lp");
	param_00 rotateto(var_02.angles,param_01,0,0);
	param_00 playloopsound("rolling_bot_turn_lp");
	wait(param_01);
	param_00 stoploopsound("rolling_bot_turn_lp");
	return var_02;
}

//Function Number: 5
runmodespecifictriggers()
{
	if(level.gametype == "ball" || level.gametype == "tdef")
	{
		var_00 = spawn("trigger_radius",(-596,-972,336),0,64,128);
		var_00.var_336 = "uplink_nozone";
		var_00.angles = (0,0,0);
		var_00 hide();
		var_00 = spawn("trigger_radius",(-240,-608,496),0,160,150);
		var_00.var_336 = "OutOfBounds";
		var_00 hide();
		level.var_C7B3 = scripts\common\utility::array_add(level.var_C7B3,var_00);
		var_00 = spawn("trigger_radius",(-1088,-1584,416),0,230,80);
		var_00.var_336 = "OutOfBounds";
		var_00 hide();
		level.var_C7B3 = scripts\common\utility::array_add(level.var_C7B3,var_00);
		var_00 = spawn("trigger_radius",(-1952,-96,272),0,100,100);
		var_00.var_336 = "OutOfBounds";
		var_00 hide();
		level.var_C7B3 = scripts\common\utility::array_add(level.var_C7B3,var_00);
		var_00 = spawn("trigger_radius",(580,-580,730),0,100,90);
		var_00.var_336 = "OutOfBounds";
		var_00 hide();
		level.var_C7B3 = scripts\common\utility::array_add(level.var_C7B3,var_00);
	}
}