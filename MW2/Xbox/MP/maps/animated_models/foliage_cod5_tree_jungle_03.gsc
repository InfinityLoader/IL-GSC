/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\foliage_cod5_tree_jungle_03.gsc
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

	model = "foliage_cod5_tree_jungle_03_animated";
	if(sp)
	{
		level.anim_prop_models[model]["sway"] = %anim_0013;
		return;
	}

	level.anim_prop_models[model]["sway"] = "foliage_cod5_tree_jungle_03_sway";
}