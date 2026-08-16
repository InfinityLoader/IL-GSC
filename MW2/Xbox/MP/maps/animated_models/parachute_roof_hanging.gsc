/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\parachute_roof_hanging.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	model = "parachute_roof_hanging_animated";
	level.anim_prop_models[model]["operate"] = "parachute_roof_hanging_anim";
}