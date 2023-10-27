/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2928.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:24:56 AM
*******************************************************************/

//Function Number: 1
func_1032A()
{
	if(!scripts\common\utility::func_16F3("slowmo",::func_1032A))
	{
		return;
	}

	level.var_1031B = spawnstruct();
	func_10329();
	function_014C("_cheat_player_press_slowmo","+melee");
	function_014C("_cheat_player_press_slowmo","+melee_breath");
	function_014C("_cheat_player_press_slowmo","+melee_zoom");
}

//Function Number: 2
func_10329()
{
	level.var_1031B.var_ABA1 = 0;
	level.var_1031B.var_ABA2 = 0.25;
	level.var_1031B.var_1098F = 0.4;
	level.var_1031B.var_1098C = 1;
}