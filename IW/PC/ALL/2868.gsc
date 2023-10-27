/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2868.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:24:22 AM
*******************************************************************/

//Function Number: 1
func_95F7()
{
	if(level.script == level.var_B8D2.var_ABFA[0].name && !level.player method_8139("hasEverPlayed_SP"))
	{
		scripts\common\utility::func_5127(0.1,::func_12DC3);
	}
}

//Function Number: 2
func_12DC3()
{
	level.player method_8302("hasEverPlayed_SP",1);
	function_0229();
}