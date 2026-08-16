/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\highrise_fencetarp_07b_wind_a.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	model = "highrise_fencetarp_07b_wind_a";
	level.anim_prop_models[model]["wind_a"] = "mp_storm_fencetarp_07_windA";
}