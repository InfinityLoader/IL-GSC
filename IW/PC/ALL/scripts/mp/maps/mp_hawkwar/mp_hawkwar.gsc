/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_hawkwar\mp_hawkwar.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 179 ms
 * Timestamp: 10/27/2023 12:13:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\mp\maps\mp_hawkwar\mp_hawkwar_precache::main();
	scripts\mp\maps\mp_hawkwar\gen\mp_hawkwar_art::main();
	scripts\mp\maps\mp_hawkwar\mp_hawkwar_fx::main();
	scripts\mp\_load::main();
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	scripts\mp\_compass::func_FACD("compass_map_mp_hawkwar");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraMinObjectContribution",8);
	setdvar("r_tessellationFactor",0);
	setdvar("r_umbraAccurateOcclusionThreshold",512);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	game["allies_outfit"] = "urban";
	game["axis_outfit"] = "woodland";
	thread scripts\mp\_animation_suite::func_1FAA();
	thread fix_collision();
}

//Function Number: 2
fix_collision()
{
	var_00 = getent("player128x128x128","targetname");
	var_01 = spawn("script_model",(1152,2256,-16));
	var_01.angles = (0,0,0);
	var_01 clonebrushmodeltoscriptmodel(var_00);
	var_02 = getent("player64x64x256","targetname");
	var_03 = spawn("script_model",(960,1052,374));
	var_03.angles = (275,90,-90);
	var_03 clonebrushmodeltoscriptmodel(var_02);
	var_04 = getent("player64x64x256","targetname");
	var_05 = spawn("script_model",(1104,1052,374));
	var_05.angles = (275,90,-90);
	var_05 clonebrushmodeltoscriptmodel(var_04);
}