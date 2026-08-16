/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\ferris_wheel.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	model = "ferris_wheel_animated";
	level.anim_prop_models[model]["rotate"] = "ferris_wheel_anim";
}