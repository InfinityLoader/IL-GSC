/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\gametype_grind.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 134 ms
 * Timestamp: 10/27/2023 12:11:34 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
}

//Function Number: 2
func_F8F4()
{
	level.agent_funcs["squadmate"]["gametype_update"] = ::scripts\mp\agents\gametype_conf::func_18FB;
	level.agent_funcs["player"]["think"] = ::scripts\mp\agents\gametype_conf::func_18F5;
}