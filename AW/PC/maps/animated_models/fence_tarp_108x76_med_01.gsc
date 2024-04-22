/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animated_models\fence_tarp_108x76_med_01.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 29 ms
 * Timestamp: 4/22/2024 2:06:28 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	var_00 = "fence_tarp_108x76";
	if(common_scripts\utility::issp())
	{
		level.anim_prop_models[var_00]["wind"] = %fence_tarp_108x76_med_01;
		return;
	}

	level.anim_prop_models[var_00]["wind"] = "fence_tarp_108x76_med_01";
}