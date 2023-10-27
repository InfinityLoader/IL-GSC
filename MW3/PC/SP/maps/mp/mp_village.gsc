/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_village.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 2:18:59 AM
*******************************************************************/

//Function Number: 1
main()
{
	lib_0390::main();
	lib_48E7::main();
	lib_0391::main();
	maps\mp\_load::main();
	ambientplay("ambient_mp_village");
	maps\mp\_compass::setupminimap("compass_map_mp_village");
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	func_3AA0();
}

//Function Number: 2
func_3AA0()
{
	maps\mp\_audio::add_reverb("default","mountains",0.25,0.9,2);
}