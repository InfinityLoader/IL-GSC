/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\_agents_gametype_sd.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 72 ms
 * Timestamp: 4/22/2024 2:08:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
}

//Function Number: 2
setup_callbacks()
{
	level.agent_funcs["player"]["think"] = ::agent_player_sd_think;
}

//Function Number: 3
agent_player_sd_think()
{
	common_scripts\utility::_enableusability();
	foreach(var_01 in level.bombzones)
	{
		var_01.trigger enableplayeruse(self);
	}

	thread maps\mp\bots\_bots_gametype_sd::bot_sd_think();
}