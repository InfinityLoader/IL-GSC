/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\foliage_pacific_palms06.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	model = "foliage_pacific_palms06_animated";
	level.anim_prop_models[model]["sway"] = "foliage_pacific_palms06_sway";
}