/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_vacant.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_vacant_precache::main();
	maps\mp\mp_vacant_fx::main();
	maps\createart\mp_vacant_art::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_vacant_dlc");
	ambientplay("ambient_mp_vacant");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_specularcolorscale", "1");
	setdvar("compassmaxrange", "1500");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1);
	setdvar("r_lightGridContrast", 1);
}