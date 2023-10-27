/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 18662.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 2:22:01 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	var_00 = tolower(getdvar("mapname"));
	var_01 = 1;
	if(common_scripts\utility::string_starts_with(var_00,"mp_"))
	{
		var_01 = 0;
	}

	var_02 = "hanging_sheet";
	if(var_01)
	{
		level.anim_prop_models[var_02]["wind_medium"] = %hanging_clothes_sheet_wind_medium;
		return;
	}

	level.anim_prop_models[var_02]["wind_medium"] = "hanging_clothes_sheet_wind_medium";
}