/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\maps\mp_nova\mp_nova.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 145 ms
 * Timestamp: 10/27/2023 12:13:55 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\mp\maps\mp_nova\mp_nova_precache::main();
	scripts\mp\maps\mp_nova\gen\mp_nova_art::main();
	scripts\mp\maps\mp_nova\mp_nova_fx::main();
	scripts\mp\_load::main();
	level.var_C7B3 = getentarray("OutOfBounds","targetname");
	scripts\mp\_compass::func_FACD("compass_map_mp_nova");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_umbraMinObjectContribution",4);
	setdvar("r_umbraaccurateocclusionthreshold",450);
	setdvar("r_tessellation",0);
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
	var_00 = getent("player32x32x128","targetname");
	var_01 = spawn("script_model",(996,-1276,430.5));
	var_01.angles = (0,0,0);
	var_01 clonebrushmodeltoscriptmodel(var_00);
	var_02 = getent("player32x32x128","targetname");
	var_03 = spawn("script_model",(996,-1276,302.5));
	var_03.angles = (0,0,0);
	var_03 clonebrushmodeltoscriptmodel(var_02);
	var_04 = getent("player32x32x128","targetname");
	var_05 = spawn("script_model",(1193,-1908,550));
	var_05.angles = (49,90,-90);
	var_05 clonebrushmodeltoscriptmodel(var_04);
}