/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\_agents_gametype_hp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 4/22/2024 2:08:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
}

//Function Number: 2
setup_callbacks()
{
	level.agent_funcs["player"]["think"] = ::maps\mp\bots\_bots_gametype_hp::bot_hp_think;
}