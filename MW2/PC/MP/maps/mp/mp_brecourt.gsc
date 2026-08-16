/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_brecourt.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_brecourt_precache::main();
	maps\mp\mp_brecourt_fx::main();
	maps\createart\mp_brecourt_art::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_brecourt");
	ambientplay("ambient_mp_rural");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	setdvar("r_specularcolorscale", "1");
	setdvar("compassmaxrange", "4000");
	setdvar("sm_sunShadowScale", 0.5);
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.11);
	setdvar("r_lightGridContrast", 0.29);
}