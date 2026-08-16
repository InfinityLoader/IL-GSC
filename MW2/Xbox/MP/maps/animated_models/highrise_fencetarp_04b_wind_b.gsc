/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\highrise_fencetarp_04b_wind_b.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	model = "highrise_fencetarp_04b_wind_b";
	level.anim_prop_models[model]["wind_b"] = "mp_storm_fencetarp_04_windB";
}