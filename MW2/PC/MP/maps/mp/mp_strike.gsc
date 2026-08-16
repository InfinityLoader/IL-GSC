/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_strike.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\mp_strike_precache::main();
	maps\mp\mp_strike_fx::main();
	maps\createart\mp_strike_art::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_strike");
	ambientplay("ambient_mp_strike");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	setdvar("compassmaxrange", "1900");
	setdvar("r_specularcolorscale", "1.86");
	thread breakglass();
}

breakglass()
{
	glass = getglassarray("brokenglass01");
	foreach(piece in glass)
	{
		destroyglass(piece);
	}
}