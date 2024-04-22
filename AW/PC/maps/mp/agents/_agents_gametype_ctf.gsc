/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\agents\_agents_gametype_ctf.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 4/22/2024 2:08:18 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
}

//Function Number: 2
setup_callbacks()
{
	level.agent_funcs["player"]["think"] = ::maps\mp\bots\_bots_gametype_ctf::bot_ctf_think;
}