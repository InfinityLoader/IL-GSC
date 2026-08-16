/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_complex.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_complex_precache::main();
	maps\mp\mp_complex_fx::main();
	maps\createart\mp_complex_art::main();
	maps\mp\_destructible_dlc::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_complex");
	ambientplay("ambient_mp_complex");
	level.airstrikeheightscale = 2;
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	setdvar("compassmaxrange", "1500");
}