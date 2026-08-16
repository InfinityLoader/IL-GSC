/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\foliage_tree_grey_oak_xl_a.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	model = "foliage_tree_grey_oak_xl_a_animated";
	level.anim_prop_models[model]["sway"] = "foliage_tree_grey_oak_xl_a_sway";
}