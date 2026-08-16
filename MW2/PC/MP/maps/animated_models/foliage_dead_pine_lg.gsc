/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\foliage_dead_pine_lg.gsc
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

	model = "foliage_dead_pine_lg_animated";
	if(sp)
	{
		level.anim_prop_models[model]["sway"] = %anim_0019;
		return;
	}

	level.anim_prop_models[model]["sway"] = "foliage_dead_pine_lg_sway";
}