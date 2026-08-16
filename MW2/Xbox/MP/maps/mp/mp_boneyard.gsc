/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_boneyard.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	maps\mp\mp_boneyard_precache::main();
	maps\mp\mp_boneyard_fx::main();
	maps\createart\mp_boneyard_art::main();
	maps\mp\mp_boneyard_precache::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_boneyard");
	setdvar("compassmaxrange", "1700");
	ambientplay("ambient_mp_desert");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.19);
	setdvar("r_lightGridContrast", 0.4);
	if(level.ps3)
	{
		setdvar("sm_sunShadowScale", "0.7");
		return;
	}
}