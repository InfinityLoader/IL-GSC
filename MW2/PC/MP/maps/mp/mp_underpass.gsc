/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_underpass.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_underpass_precache::main();
	maps\createart\mp_underpass_art::main();
	maps\mp\mp_underpass_fx::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_underpass");
	setdvar("compassmaxrange", "2800");
	ambientplay("ambient_mp_rain");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_specularcolorscale", "3.1");
	setdvar("r_diffusecolorscale", ".78");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.3);
	setdvar("r_lightGridContrast", 0.5);
	if(level.ps3)
	{
		setdvar("sm_sunShadowScale", "0.5");
		return;
	}
}