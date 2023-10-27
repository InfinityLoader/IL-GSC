/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\engine\_flags.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 143 ms
 * Timestamp: 10/27/2023 12:10:48 AM
*******************************************************************/

//Function Number: 1
func_95E2()
{
	if(!scripts\common\utility::func_16F3("init_flags",::func_95E2))
	{
		return;
	}

	level.flag = [];
	level.var_6E6E = [];
	level.var_7763 = 0;
	scripts\common\utility::func_95C6("sp_stat_tracking_func");
	level.var_6E46 = spawnstruct();
	level.var_6E46 func_23D9();
}

//Function Number: 2
func_23D9()
{
	self.var_12BA3 = "generic" + level.var_7763;
	level.var_7763++;
}