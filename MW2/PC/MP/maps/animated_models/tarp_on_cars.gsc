/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\tarp_on_cars.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	model = "tarp_on_cars_animated";
	level.anim_prop_models[model]["wind"] = "tarp_cars_anim";
}