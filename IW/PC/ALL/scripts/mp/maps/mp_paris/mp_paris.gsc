/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_paris\mp_paris.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 265 ms
 * Timestamp: 10/27/2023 12:14:00 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\mp\maps\mp_paris\mp_paris_precache::main();
	scripts\mp\maps\mp_paris\gen\mp_paris_art::main();
	scripts\mp\maps\mp_paris\mp_paris_fx::main();
	scripts\mp\_load::main();
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	scripts\mp\_compass::func_FACD("compass_map_mp_paris");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraMinObjectContribution",3);
	setdvar("r_umbraAccurateOcclusionThreshold",512);
	setdvar("r_tessellationFactor",0);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	thread scripts\mp\_animation_suite::func_1FAA();
	thread droptonavmeshtriggers();
	fix_broshot();
	patchable_collision();
}

//Function Number: 2
droptonavmeshtriggers()
{
	wait(1);
	var_00 = spawn("trigger_radius",(-469,-769,40),0,70,70);
	var_00 hide();
	level.droptonavmeshtriggers[level.droptonavmeshtriggers.size] = var_00;
}

//Function Number: 3
fix_broshot()
{
	var_00 = getent("character_loc_broshot_d","targetname");
	var_00.origin = (450,1820,var_00.origin[2]);
}

//Function Number: 4
patchable_collision()
{
	var_00 = getent("player128x128x8","targetname");
	var_01 = spawn("script_model",(-120,224,160));
	var_01.angles = (270,0,0);
	var_01 clonebrushmodeltoscriptmodel(var_00);
	var_02 = getent("player128x128x8","targetname");
	var_03 = spawn("script_model",(-1332,1274,592));
	var_03.angles = (280,225,-180);
	var_03 clonebrushmodeltoscriptmodel(var_02);
	var_04 = getent("player128x128x8","targetname");
	var_05 = spawn("script_model",(-140,720,164));
	var_05.angles = (0,0,-90);
	var_05 clonebrushmodeltoscriptmodel(var_04);
	var_06 = getent("player256x256x8","targetname");
	var_07 = spawn("script_model",(-136,1052,237));
	var_07.angles = (360,180,-180);
	var_07 clonebrushmodeltoscriptmodel(var_06);
	var_08 = getent("player256x256x8","targetname");
	var_09 = spawn("script_model",(52,720,220));
	var_09.angles = (0,90,0);
	var_09 clonebrushmodeltoscriptmodel(var_08);
	var_0A = getent("player256x256x8","targetname");
	var_0B = spawn("script_model",(-203,1044,240));
	var_0B.angles = (0,90,0);
	var_0B clonebrushmodeltoscriptmodel(var_0A);
	var_0C = getent("player256x256x8","targetname");
	var_0D = spawn("script_model",(-196,1149,256));
	var_0D.angles = (0,90,0);
	var_0D clonebrushmodeltoscriptmodel(var_0C);
	var_0E = getent("player256x256x8","targetname");
	var_0F = spawn("script_model",(60,1149,256));
	var_0F.angles = (0,90,0);
	var_0F clonebrushmodeltoscriptmodel(var_0E);
	var_10 = getent("player256x256x8","targetname");
	var_11 = spawn("script_model",(32,1008,232));
	var_11.angles = (0,90,0);
	var_11 clonebrushmodeltoscriptmodel(var_10);
	var_12 = getent("player32x32x128","targetname");
	var_13 = spawn("script_model",(-80,724,236));
	var_13.angles = (90,0,0);
	var_13 clonebrushmodeltoscriptmodel(var_12);
	var_14 = getent("player256x256x256","targetname");
	var_15 = spawn("script_model",(-968,368,664));
	var_15.angles = (0,0,0);
	var_15 clonebrushmodeltoscriptmodel(var_14);
	var_16 = getent("player256x256x256","targetname");
	var_17 = spawn("script_model",(-968,368,432));
	var_17.angles = (0,0,0);
	var_17 clonebrushmodeltoscriptmodel(var_16);
	var_18 = getent("player32x32x256","targetname");
	var_19 = spawn("script_model",(58,598,224));
	var_19.angles = (270,180,180);
	var_19 clonebrushmodeltoscriptmodel(var_18);
	var_1A = getent("player32x32x256","targetname");
	var_1B = spawn("script_model",(-594,-42,89));
	var_1B.angles = (0,342,0);
	var_1B clonebrushmodeltoscriptmodel(var_1A);
	var_1C = getent("player64x64x256","targetname");
	var_1D = spawn("script_model",(-2384,1648,222));
	var_1D.angles = (90,0,0);
	var_1D clonebrushmodeltoscriptmodel(var_1C);
	var_1E = getent("player64x64x256","targetname");
	var_1F = spawn("script_model",(-2128,1648,220));
	var_1F.angles = (90,0,0);
	var_1F clonebrushmodeltoscriptmodel(var_1E);
	var_20 = getent("player64x64x256","targetname");
	var_21 = spawn("script_model",(-1872,1652,220));
	var_21.angles = (87.7,180,-180);
	var_21 clonebrushmodeltoscriptmodel(var_20);
	var_22 = getent("player64x64x256","targetname");
	var_23 = spawn("script_model",(-1616,1676,208));
	var_23.angles = (90,0,0);
	var_23 clonebrushmodeltoscriptmodel(var_22);
	var_24 = getent("player64x64x256","targetname");
	var_25 = spawn("script_model",(-1360,1676,208));
	var_25.angles = (85,180,-180);
	var_25 clonebrushmodeltoscriptmodel(var_24);
	var_26 = getent("player64x64x256","targetname");
	var_27 = spawn("script_model",(-1116,1664,192));
	var_27.angles = (85,135,180);
	var_27 clonebrushmodeltoscriptmodel(var_26);
	var_28 = getent("player64x64x256","targetname");
	var_29 = spawn("script_model",(-948,1476,172));
	var_29.angles = (80,110,180);
	var_29 clonebrushmodeltoscriptmodel(var_28);
	var_2A = getent("player64x64x256","targetname");
	var_2B = spawn("script_model",(-868,1232,136));
	var_2B.angles = (83,90,180);
	var_2B clonebrushmodeltoscriptmodel(var_2A);
	var_2C = getent("player128x128x8","targetname");
	var_2D = spawn("script_model",(-864,912,104));
	var_2D.angles = (0,0,10);
	var_2D clonebrushmodeltoscriptmodel(var_2C);
	var_2E = getent("player256x256x256","targetname");
	var_2F = spawn("script_model",(52,720,228));
	var_2F.angles = (0,0,10);
	var_2F clonebrushmodeltoscriptmodel(var_2E);
	var_30 = getent("player256x256x8","targetname");
	var_31 = spawn("script_model",(592,1280,-38));
	var_31.angles = (0,0,0);
	var_31 clonebrushmodeltoscriptmodel(var_30);
}