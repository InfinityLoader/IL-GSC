/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_overgrown.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_overgrown_precache::main();
	maps\mp\mp_overgrown_fx::main();
	maps\createart\mp_overgrown_art::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_overgrown_dlc");
	ambientplay("ambient_mp_overgrown");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_specularcolorscale", "1");
	setdvar("compassmaxrange", "2200");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1);
	setdvar("r_lightGridContrast", 1);
}