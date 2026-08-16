/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\foliage_tree_palm_bushy_1.gsc
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

	model = "foliage_tree_palm_bushy_1";
	if(sp)
	{
		level.anim_prop_models[model]["still"] = %anim_0028;
		level.anim_prop_models[model]["strong"] = %anim_0029;
		return;
	}

	level.anim_prop_models[model]["strong"] = "palmtree_mp_bushy1_sway";
}