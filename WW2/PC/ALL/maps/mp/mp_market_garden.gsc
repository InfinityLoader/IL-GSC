/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_market_garden.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 57 ms
 * Timestamp: 10/27/2023 3:15:45 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	maps/mp/mp_market_garden_precache::func_F9();
	maps/createart/mp_market_garden_art::func_F9();
	maps/mp/mp_market_garden_fx::func_F9();
	maps\mp\_load::func_F9();
	maps/mp/mp_market_garden_lighting::func_F9();
	maps/mp/mp_market_garden_aud::func_F9();
	maps\mp\_compass::func_8A2F("compass_map_mp_market_garden");
	game["attackers"] = "allies";
	game["defenders"] = "axis";
	level.var_6C5F = "mp_market_garden_osp";
	level.var_6C5E = "mp_market_garden_osp";
	level.var_3445 = "mp_market_garden_drone";
	level.var_343A = "mp_market_garden_drone";
	level.var_A853 = "mp_market_garden_warbird";
	level.var_A852 = "mp_market_garden_warbird";
	level.var_5A7C = "mp_market_garden_killstreak";
	level.var_5A6B = "mp_market_garden_killstreak";
	level.var_47CD = "mp_market_garden_glide1";
	level.var_47CE = "mp_market_garden_glide2";
	level.crafting_table = "glidebomb_hatchdoors_light_low";
	level.var_A4B5["intensity"] = 0.2;
	level.var_A4B5["falloff"] = 1.2;
	level.var_A4B5["scaleX"] = 1;
	level.var_A4B5["scaleY"] = 1;
	level.var_A4B5["squareAspectRatio"] = 0;
	level.var_A4B5["lerpDuration"] = 0.1;
	level.var_A4BE["intensity"] = 0.5;
	level.var_A4BE["falloff"] = 1.2;
	level.var_A4BE["scaleX"] = 1;
	level.var_A4BE["scaleY"] = 1;
	level.var_A4BE["squareAspectRatio"] = 0;
	level.var_A4BE["lerpDuration"] = 0.4;
	level.var_6465["velocityscaler"] = 0.35;
	level.var_6465["cameraRotationInfluence"] = 0;
	level.var_6465["cameraTranslationInfluence"] = 0;
	if(isdefined(level.var_122))
	{
		setdvar("r_ssrMaxQuality",1);
	}

	thread performance_stuff();
}

//Function Number: 2
performance_stuff()
{
	setdvar("634",0);
}