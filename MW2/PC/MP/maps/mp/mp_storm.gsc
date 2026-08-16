/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_storm.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_storm_precache::main();
	maps\mp\mp_storm_fx::main();
	maps\createart\mp_storm_art::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_storm");
	ambientplay("ambient_mp_storm");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_specularcolorscale", "1.5");
	setdvar("compassmaxrange", "2300");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.3);
}