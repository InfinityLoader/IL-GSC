/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\highrise_fencetarp_06.gsc
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

	model = "highrise_fencetarp_06";
	if(sp)
	{
		level.anim_prop_models[model]["wind"] = %anim_000C;
		return;
	}

	level.anim_prop_models[model]["wind"] = "highrise_fencetarp_06_wind";
}