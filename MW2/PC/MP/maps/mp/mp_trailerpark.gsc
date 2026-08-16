/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_trailerpark.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_trailerpark_precache::main();
	maps\createart\mp_trailerpark_art::main();
	maps\mp\mp_trailerpark_fx::main();
	maps\mp\_destructible_dlc2::main();
	maps\mp\_destructible_dlc::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_trailerpark");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.33);
	setdvar("compassmaxrange", "1700");
	ambientplay("ambient_mp_trailerpark");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
}