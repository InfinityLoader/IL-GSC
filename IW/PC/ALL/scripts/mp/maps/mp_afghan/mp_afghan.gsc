/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_afghan\mp_afghan.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 286 ms
 * Timestamp: 10/27/2023 12:13:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	lib_0F7C::main();
	scripts\mp\maps\mp_afghan\gen\mp_afghan_art::main();
	lib_0F7B::main();
	scripts\mp\_load::main();
	scripts\mp\_compass::func_FACD("compass_map_mp_afghan");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("sm_sunSampleSizeNear",1.2);
	setdvar("r_drawsun",0);
	setdvar("r_umbraMinObjectContribution",8);
	setdvar("r_tessellationFactor",40);
	setdvar("r_tessellationCutoffFalloff",256);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	thread func_CDA4("mp_afghan_screen");
	level.var_C7B3 = getentarray("outofbounds","targetname");
	thread scripts\mp\_animation_suite::func_1FAA();
	level.modifiedspawnpoints["4194 2331 35"]["mp_tdm_spawn_axis_start"]["origin"] = (4207,2328,7);
	level.modifiedspawnpoints["4194 2327 36"]["mp_koth_spawn_axis_start"]["origin"] = (4207,2328,7);
	level.modifiedspawnpoints["4369 308 100"]["mp_front_spawn_allies"]["origin"] = (4496,317,117);
	level.modifiedspawnpoints["51 3077 4"]["mp_dom_spawn"]["origin"] = (51.3,3077.3,10);
	level.modifiedspawnpoints["51 3077 4"]["mp_dom_spawn"]["no_alternates"] = 1;
	thread spawn_oob_trigger();
	thread fix_collision();
	thread fix_broshot();
}

//Function Number: 2
func_CDA4(param_00)
{
	wait(30);
	function_030E(param_00);
}

//Function Number: 3
spawn_oob_trigger()
{
	wait(0.05);
	var_00 = spawn("trigger_radius",(-674,2090,-102),0,150,140);
	var_00.var_336 = "outofbounds";
	var_00 hide();
	var_01 = spawn("trigger_radius",(1704,4299,180),0,200,50);
	var_01.var_336 = "outofbounds";
	var_01 hide();
	level.var_C7B3[level.var_C7B3.size] = var_00;
	level.var_C7B3[level.var_C7B3.size] = var_01;
}

//Function Number: 4
fix_collision()
{
	var_00 = getent("player32x32x8","targetname");
	var_01 = spawn("script_model",(1772,188.5,415));
	var_01.angles = (0,0,-70);
	var_01 clonebrushmodeltoscriptmodel(var_00);
	var_02 = getent("player64x64x256","targetname");
	var_03 = spawn("script_model",(500,1852,136));
	var_03.angles = (0,0,0);
	var_03 clonebrushmodeltoscriptmodel(var_02);
	var_04 = getent("player64x64x256","targetname");
	var_05 = spawn("script_model",(500,1852,392));
	var_05.angles = (0,0,0);
	var_05 clonebrushmodeltoscriptmodel(var_04);
	var_06 = getent("player64x64x256","targetname");
	var_07 = spawn("script_model",(700,1852,136));
	var_07.angles = (0,0,0);
	var_07 clonebrushmodeltoscriptmodel(var_06);
	var_08 = getent("player64x64x256","targetname");
	var_09 = spawn("script_model",(700,1852,392));
	var_09.angles = (0,0,0);
	var_09 clonebrushmodeltoscriptmodel(var_08);
	var_0A = getent("player128x128x128","targetname");
	var_0B = spawn("script_model",(1040,3952,78));
	var_0B.angles = (0,30,0);
	var_0B clonebrushmodeltoscriptmodel(var_0A);
	var_0C = getent("player256x256x256","targetname");
	var_0D = spawn("script_model",(5056,2912,80));
	var_0D.angles = (0,0,0);
	var_0D clonebrushmodeltoscriptmodel(var_0C);
	var_0E = getent("clip128x128x256","targetname");
	var_0F = spawn("script_model",(2960,2172,144));
	var_0F.angles = (0,0,0);
	var_0F clonebrushmodeltoscriptmodel(var_0E);
	var_10 = getent("player64x64x64","targetname");
	var_11 = spawn("script_model",(-234,1664,186));
	var_11.angles = (322,0,0);
	var_11 clonebrushmodeltoscriptmodel(var_10);
	var_12 = getent("clip128x128x256","targetname");
	var_13 = spawn("script_model",(3790,1760,192));
	var_13.angles = (26,0,0);
	var_13 clonebrushmodeltoscriptmodel(var_12);
	var_14 = getent("clip64x64x128","targetname");
	var_15 = spawn("script_model",(124,3032,-124));
	var_15.angles = (0,30,0);
	var_15 clonebrushmodeltoscriptmodel(var_14);
}

//Function Number: 5
fix_broshot()
{
	var_00 = getent("character_loc_broshot_e","targetname");
	var_01 = var_00.origin;
	var_00.origin = (var_01[0],var_01[1],242);
}