/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\gametype_sd.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 185 ms
 * Timestamp: 10/27/2023 12:11:38 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
}

//Function Number: 2
func_F8F4()
{
	level.agent_funcs["player"]["think"] = ::func_18F8;
}

//Function Number: 3
func_18F8()
{
	scripts\common\utility::func_1C6E(1);
	thread scripts\mp\bots\gametype_sd::func_2E6E();
}