/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agents_gametype_ctf.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 3:08:52 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_87A7();
}

//Function Number: 2
func_87A7()
{
	level.var_A41["player"]["think"] = ::maps/mp/bots/_bots_gametype_ctf::func_1993;
}