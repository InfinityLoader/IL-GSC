/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_checkpoint.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_checkpoint_precache::main();
	maps\createart\mp_checkpoint_art::main();
	maps\mp\mp_checkpoint_fx::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_checkpoint");
	level.airstrikeheightscale = 1.5;
	ambientplay("ambient_mp_urban");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.27);
	setdvar("r_lightGridContrast", 1);
	setdvar("r_specularcolorscale", "2");
	setdvar("compassmaxrange", "1600");
}