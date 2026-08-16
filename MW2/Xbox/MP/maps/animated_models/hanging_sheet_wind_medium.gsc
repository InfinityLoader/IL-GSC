/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\hanging_sheet_wind_medium.gsc
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

	model = "hanging_sheet";
	if(sp)
	{
		level.anim_prop_models[model]["wind_medium"] = %anim_0021;
		return;
	}

	level.anim_prop_models[model]["wind_medium"] = "hanging_clothes_sheet_wind_medium";
}