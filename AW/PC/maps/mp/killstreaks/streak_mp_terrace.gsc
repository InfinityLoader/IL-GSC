/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_terrace.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 41 ms
 * Timestamp: 4/22/2024 2:12:49 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killstreakwieldweapons["killstreak_terrace_mp"] = "mp_terrace";
	level.killstreakfuncs["mp_terrace"] = ::tryusekillstreak;
	level.mapkillstreak = "mp_terrace";
	level.mapkillstreakpickupstring = &"MP_TERRACE_MAP_KILLSTREAK_PICKUP";
}

//Function Number: 2
tryusekillstreak(param_00,param_01)
{
	param_01 = ["mp_terrace"];
	return maps\mp\killstreaks\_drone_assault::tryuseassaultdrone(param_00,param_01);
}