/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\oil_pump_jack02.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	model = "oil_pump_jack02";
	level.anim_prop_models[model]["operate"] = "oil_pump_2";
}