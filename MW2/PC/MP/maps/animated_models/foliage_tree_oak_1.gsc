/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\foliage_tree_oak_1.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
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

	model = "foliage_tree_oak_1_animated2";
	if(sp)
	{
		level.anim_prop_models[model]["sway"] = %anim_001B;
		return;
	}

	level.anim_prop_models[model]["sway"] = "foliage_tree_oak_1_sway";
}