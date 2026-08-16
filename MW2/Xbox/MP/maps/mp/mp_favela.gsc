/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_favela.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	maps\mp\mp_favela_precache::main();
	maps\createart\mp_favela_art::main();
	maps\mp\mp_favela_fx::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_favela");
	level.airstrikeheightscale = 1.5;
	ambientplay("ambient_mp_favela");
	switch(level.gametype)
	{
		case "oneflag":
			game["attackers"] = "allies";
			game["defenders"] = "axis";
			break;

		default:
			game["attackers"] = "axis";
			game["defenders"] = "allies";
			break;
	}

	setdvar("r_specularcolorscale", "2.8");
	setdvar("compassmaxrange", "1500");
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.25);
	setdvar("r_lightGridContrast", 0.45);
}