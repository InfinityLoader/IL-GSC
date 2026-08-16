/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\hanging_shortsleeve_wind_medium.gsc
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

	model = "hanging_short_sleeve";
	if(sp)
	{
		level.anim_prop_models[model]["wind_medium"] = %anim_0020;
		return;
	}

	level.anim_prop_models[model]["wind_medium"] = "hanging_clothes_short_sleeve_wind_medium";
}