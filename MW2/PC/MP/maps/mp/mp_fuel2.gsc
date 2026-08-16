/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_fuel2.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_fuel2_precache::main();
	maps\mp\mp_fuel2_fx::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_fuel2");
	setexpfog(500, 8000, 0.501961, 0.501961, 0.45098, 0.5, 0);
	ambientplay("ambient_mp_fuel");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
}