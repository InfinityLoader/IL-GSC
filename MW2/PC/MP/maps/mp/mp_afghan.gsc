/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_afghan.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_afghan_precache::main();
	maps\createart\mp_afghan_art::main();
	maps\mp\mp_afghan_fx::main();
	maps\mp\_explosive_barrels::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_afghan");
	setdvar("compassmaxrange", "3000");
	ambientplay("ambient_mp_desert");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.2);
	setdvar("r_lightGridContrast", 0);
	thread maps\mp\_utility::killtrigger((206,2414,137), 55, 100);
}