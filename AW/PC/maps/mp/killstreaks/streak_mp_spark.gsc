/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_spark.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 71 ms
 * Timestamp: 4/22/2024 2:12:48 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakfuncs["mp_spark"] = ::tryuseremotesentrydisruptor;
	level.killstreakwieldweapons["iw5_dlcgun12loot3_mp"] = "mp_spark";
	level.mapkillstreak = "mp_spark";
	level.mapkillstreakpickupstring = &"MP_SPARK_MAP_KILLSTREAK_PICKUP";
	level.mapcustombotkillstreakfunc = ::setupbotsformapkillstreak;
	level._effect["turret_distortion"] = loadfx("vfx/muzzleflash/dlc_sentry_disruptor_wave");
}

//Function Number: 2
tryuseremotesentrydisruptor(param_00,param_01)
{
	var_02 = getnumdisruptorturrets();
	if(var_02 >= 12)
	{
		self iprintlnbold(&"MP_SPARK_MAP_KILLSTREAK_MAX");
		return 0;
	}

	return maps\mp\killstreaks\_remoteturret::tryuseremotemgsentryturret(param_00,["sentry_disruptor"]);
}

//Function Number: 3
getnumdisruptorturrets()
{
	var_00 = 0;
	foreach(var_02 in level.turrets)
	{
		if(isdefined(var_02.model) && issubstr(var_02.model,"disruptor"))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 4
setupbotsformapkillstreak()
{
	level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func("mp_spark",::maps\mp\bots\_bots_sentry::bot_killstreak_sentry,undefined,"turret");
}