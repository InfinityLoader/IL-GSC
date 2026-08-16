/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_abandon.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_abandon_precache::main();
	maps\createart\mp_abandon_art::main();
	maps\mp\mp_abandon_fx::main();
	maps\mp\_destructible_dlc2::main();
	maps\mp\_destructible_dlc::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_abandon");
	ambientplay("ambient_mp_abandon");
	setdvar("r_specularcolorscale", "2.5");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.452);
	setdvar("r_lightGridContrast", 0);
	setdvar("compassmaxrange", "1800");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
}