/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\foliage_tree_green_pine_lg_b.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	model = "foliage_tree_green_pine_lg_b_animated";
	level.anim_prop_models[model]["sway"] = "foliage_tree_green_pine_lg_b_sway";
}