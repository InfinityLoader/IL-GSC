/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\foliage_tree_river_birch_xl_a.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	mapname = tolower(getdvar("mapname"));
	sp = 1;
	if(common_scripts\utility::string_starts_with(mapname, "mp_"))
	{
		sp = 0;
	}

	model = "foliage_tree_river_birch_xl_a_animated";
	if(sp)
	{
		level.anim_prop_models[model]["sway"] = %anim_0005;
		return;
	}

	level.anim_prop_models[model]["sway"] = "foliage_tree_river_birch_xl_a_sway";
}