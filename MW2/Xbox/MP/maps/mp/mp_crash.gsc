/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_crash.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	maps\mp\mp_crash_precache::main();
	maps\mp\mp_crash_fx::main();
	maps\createart\mp_crash_art::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_crash_dlc");
	ambientplay("ambient_mp_crash");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_specularcolorscale", "1");
	setdvar("compassmaxrange", "1600");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.1);
	setdvar("r_lightGridContrast", 1);
}