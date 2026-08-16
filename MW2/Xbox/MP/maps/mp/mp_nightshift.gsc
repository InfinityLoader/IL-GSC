/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_nightshift.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	maps\mp\mp_nightshift_precache::main();
	maps\mp\mp_nightshift_fx::main();
	maps\createart\mp_nightshift_art::main();
	maps\mp\_load::main();
	maps\mp\_compass::setupminimap("compass_map_mp_nightshift");
	setdvar("compassmaxrange", "2400");
	ambientplay("ambient_mp_urban");
	visionsetnaked("mp_nightshift");
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	setdvar("r_lightGridEnableTweaks", 1);
	setdvar("r_lightGridIntensity", 1.2);
	setdvar("r_lightGridContrast", 1);
	level.airstrikeheightscale = 1.5;
	level._effect["explosive_fx"] = loadfx("explosions/tanker_explosion");
	level._effect["train_dust"] = loadfx("dust/train_dust");
	level._effect["train_dust_linger"] = loadfx("dust/train_dust_linger");
	thread hallwayplunger();
}

hallwayplunger()
{
	plunger = getent("plunger", "targetname");
	if(!isdefined(plunger))
	{
		return;
	}

	plunger waittill("trigger");
	explosives = getentarray(plunger.target, "targetname");
	foreach(explosive in explosives)
	{
		wait 0.25;
		rot = randomfloat(360);
		explosioneffect = spawnfx(level._effect["explosive_fx"], explosive.origin + (0,0,0), (0,0,1), (cos(rot),sin(rot),0));
		triggerfx(explosioneffect);
		radiusdamage(explosive.origin, 384, 200, 30);
		thread maps\mp\_utility::playsoundinspace("exp_suitcase_bomb_main", explosive.origin);
		explosive delete();
	}

	plunger delete();
}