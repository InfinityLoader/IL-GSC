/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agents_gametype_sd.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 73 ms
 * Timestamp: 10/27/2023 1:28:07 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
}

//Function Number: 2
func_710C()
{
	level.agent_funcs["player"]["think"] = ::func_8F40;
}

//Function Number: 3
func_8F40()
{
	common_scripts\utility::_enableusability();
	thread maps/mp/bots/_bots_gametype_sd::func_900C();
}