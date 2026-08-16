/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\foliage_red_pine_med.gsc
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

	model = "foliage_red_pine_med_animated";
	if(sp)
	{
		level.anim_prop_models[model]["sway"] = %anim_0002;
		return;
	}

	level.anim_prop_models[model]["sway"] = "foliage_red_pine_med_sway";
}