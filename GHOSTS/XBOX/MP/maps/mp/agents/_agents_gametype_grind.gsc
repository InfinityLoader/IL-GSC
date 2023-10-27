/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agents_gametype_grind.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 57 ms
 * Timestamp: 10/27/2023 1:28:04 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
}

//Function Number: 2
func_710C()
{
	level.agent_funcs["squadmate"]["gametype_update"] = ::maps/mp/agents/_agents_gametype_conf::func_8F41;
	level.agent_funcs["player"]["think"] = ::maps/mp/agents/_agents_gametype_conf::func_8F3D;
}