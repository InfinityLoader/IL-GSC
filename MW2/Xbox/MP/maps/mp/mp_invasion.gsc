/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_invasion.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	maps\mp\mp_invasion_precache::main();
	maps\createart\mp_invasion_art::main();
	maps\mp\mp_invasion_fx::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_invasion");
	level.airstrikeheightscale = 1.5;
	ambientplay("ambient_mp_urban");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_specularcolorscale", "2.5");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.25);
	setdvar("r_lightGridContrast", 0.5);
	setdvar("compassmaxrange", "2500");
}