/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\highrise_fencetarp_01.gsc
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

	model = "highrise_fencetarp_01";
	if(sp)
	{
		level.anim_prop_models[model]["wind"] = %anim_0011;
		return;
	}

	level.anim_prop_models[model]["wind"] = "highrise_fencetarp_01_wind";
}