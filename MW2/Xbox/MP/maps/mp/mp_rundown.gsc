/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_rundown.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	maps\mp\mp_rundown_precache::main();
	maps\mp\mp_rundown_fx::main();
	maps\createart\mp_rundown_art::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_rundown");
	ambientplay("ambient_mp_rural");
	visionsetnaked("mp_rundown");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_specularcolorscale", "1.67");
	setdvar("compassmaxrange", "3000");
	setdvar("sm_sunShadowScale", "0.5");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.16);
	setdvar("r_lightGridContrast", 1);
}