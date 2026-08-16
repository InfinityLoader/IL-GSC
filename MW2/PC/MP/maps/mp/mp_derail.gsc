/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_derail.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_derail_precache::main();
	maps\mp\mp_derail_fx::main();
	maps\createart\mp_derail_art::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_derail");
	ambientplay("ambient_mp_snow");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_specularcolorscale", "2.3");
	setdvar("compassmaxrange", "4000");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1);
	setdvar("r_lightGridContrast", 0.4);
	thread maps\mp\_utility::killtrigger((2077,-91,0), 75, 20);
}