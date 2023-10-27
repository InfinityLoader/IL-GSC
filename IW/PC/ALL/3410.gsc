/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3410.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:27:07 AM
*******************************************************************/

//Function Number: 1
func_9700()
{
	level.var_13F4D = [];
	level.var_13F1B = [];
	level.var_13F4C = [];
	level.num_of_quest_pieces_completed = 0;
}

//Function Number: 2
func_10CEF()
{
	if(scripts\cp\_utility::is_codxp())
	{
		return;
	}

	foreach(var_02, var_01 in level.var_13F4D)
	{
		level thread func_10CEE(var_02);
	}
}

//Function Number: 3
func_10CEE(param_00)
{
	var_01 = level.var_13F4D[param_00];
	level.var_13F4C[param_00] = -1;
	foreach(var_04, var_03 in var_01)
	{
		level.var_13F1B[param_00] = var_04;
		[[ var_03.var_95F2 ]]();
		if(func_FF37(param_00,var_04))
		{
			[[ var_03.var_DB5D ]]();
		}

		[[ var_03.var_446D ]]();
	}
}

//Function Number: 4
func_DED3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(level.var_13F4D[param_00]))
	{
		level.var_13F4D[param_00] = [];
	}

	if(!isdefined(level.var_13F4C[param_00]))
	{
		level.var_13F4C[param_00] = -1;
	}

	var_08 = spawnstruct();
	var_08.var_95F2 = param_02;
	var_08.var_DB5D = param_03;
	var_08.var_446D = param_04;
	var_08.var_4EB1 = param_05;
	level.var_13F4D[param_00][param_01] = var_08;
	level thread add_devgui_entries(param_00,param_01,param_06,param_07);
}

//Function Number: 5
add_devgui_entries(param_00,param_01,param_02,param_03)
{
	wait(3);
	if(!isdefined(param_02))
	{
		param_02 = "";
	}

	if(!isdefined(param_03))
	{
		param_03 = "";
	}

	if(level.script == "cp_town")
	{
		if(param_01 == 0)
		{
			var_04 = "devgui_cmd \"Town:5/Quests/" + param_02 + "-" + param_00 + "/Step" + param_01 + 1 + "-" + param_03 + "/ 0 - Complete This Step\" \"set scr_complete_quest_step " + param_00 + "_" + param_01 + "\" \n";
			addentrytodevgui(var_04);
			return;
		}

		var_04 = "devgui_cmd \"Town:5/Quests/" + param_03 + "-" + param_01 + "/Step" + param_02 + 1 + "-" + var_04 + "/ 0 - Jump To This Step\" \"set scr_complete_quest_step " + param_01 + "_" + param_02 - 1 + "\" \n";
		addentrytodevgui(var_04);
		var_04 = "devgui_cmd \"Town:5/Quests/" + param_02 + "-" + param_00 + "/Step" + param_01 + 1 + "-" + param_03 + "/ 1 - Complete This Step\" \"set scr_complete_quest_step " + param_00 + "_" + param_01 + "\" \n";
		addentrytodevgui(var_04);
	}
}

//Function Number: 6
func_FF37(param_00,param_01)
{
	return param_01 > level.var_13F4C[param_00];
}

//Function Number: 7
quest_line_exist(param_00)
{
	return isdefined(level.var_13F4D[param_00]);
}

//Function Number: 8
addentrytodevgui(param_00)
{
}