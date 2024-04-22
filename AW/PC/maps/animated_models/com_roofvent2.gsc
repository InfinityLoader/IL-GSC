/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animated_models\com_roofvent2.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 22 ms
 * Timestamp: 4/22/2024 2:06:28 AM
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

	var_02 = "com_roofvent2_animated";
	if(var_01)
	{
		level.anim_prop_models[var_02]["rotate"] = %roofvent_rotate;
		return;
	}

	level.anim_prop_models[var_02]["rotate"] = "roofvent_rotate";
}