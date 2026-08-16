/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\foliage_tree_palm_med_2.gsc
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

	model = "foliage_tree_palm_med_2";
	if(sp)
	{
		level.anim_prop_models[model]["still"] = %anim_002A;
		level.anim_prop_models[model]["strong"] = %anim_002B;
		return;
	}

	level.anim_prop_models[model]["strong"] = "palmtree_mp_med2_sway";
}