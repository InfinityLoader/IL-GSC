/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2863.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:24:20 AM
*******************************************************************/

//Function Number: 1
func_9752()
{
	if(!isdefined(level.flag))
	{
		scripts\common\flags::func_95E2();
	}
	else
	{
		var_00 = getarraykeys(level.flag);
		scripts\common\utility::func_22A1(var_00,::func_3D74);
	}

	scripts\common\utility::flag_init("auto_adjust_initialized");
	if(!scripts\common\utility::func_6E34("load_finished"))
	{
		scripts\common\utility::flag_init("load_finished");
	}

	if(!scripts\common\utility::func_6E34("scriptables_ready"))
	{
		scripts\common\utility::flag_init("scriptables_ready");
	}
}

//Function Number: 2
func_3D74(param_00)
{
	if(getsubstr(param_00,0,3) != "aa_")
	{
		return;
	}

	[[ level.var_74C2["sp_stat_tracking_func"] ]](param_00);
}