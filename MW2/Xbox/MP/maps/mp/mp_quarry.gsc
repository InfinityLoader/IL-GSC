/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_quarry.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	maps\mp\mp_quarry_precache::main();
	maps\mp\mp_quarry_fx::main();
	maps\createart\mp_quarry_art::main();
	maps\mp\_load::main();
	maps\mp\_explosive_barrels::main();
	maps\mp\_compass::setupminimap("compass_map_mp_quarry");
	setdvar("compassmaxrange", "2800");
	ambientplay("ambient_mp_desert");
	visionsetnaked("mp_quarry");
	level.airstrikeheightscale = 2;
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.22);
	setdvar("r_lightGridContrast", 0.67);
}