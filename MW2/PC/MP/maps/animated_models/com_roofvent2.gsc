/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\com_roofvent2.gsc
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

	model = "com_roofvent2_animated";
	if(sp)
	{
		level.anim_prop_models[model]["rotate"] = %anim_0001;
		return;
	}

	level.anim_prop_models[model]["rotate"] = "roofvent_rotate";
}