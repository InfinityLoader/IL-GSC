/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_ambient.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 44 ms
 * Timestamp: 10/27/2023 1:39:06 AM
*******************************************************************/

//Function Number: 1
func_8790(param_00,param_01)
{
	if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return;
	}

	maps\_audio::func_6EB5(param_00,param_01);
}

//Function Number: 2
func_2330(param_00)
{
	level.eq_track[param_00] = "";
	level.player method_8284(param_00);
}

//Function Number: 3
func_14D8(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	var_03 = 0.05;
	var_04 = var_02 / var_03;
	var_05 = 1 / var_04;
	for(var_06 = 0;var_06 <= 1;var_06 = var_06 + var_05)
	{
		level.player method_8285(var_06,param_00);
		wait(var_03);
	}

	level.player method_8285(1,param_00);
}