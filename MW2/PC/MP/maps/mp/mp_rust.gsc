/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_rust.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_rust_precache::main();
	maps\createart\mp_rust_art::main();
	maps\mp\mp_rust_fx::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_rust");
	setdvar("compassmaxrange", "1400");
	ambientplay("ambient_mp_duststorm");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	thread maps\mp\_utility::killtrigger((1080,1645,-186), 40, 30);
}