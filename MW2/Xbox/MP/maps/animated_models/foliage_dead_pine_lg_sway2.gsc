/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\animated_models\foliage_dead_pine_lg_sway2.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	model = "foliage_dead_pine_lg_animated_sway2";
	level.anim_prop_models[model]["sway2"] = "foliage_dead_pine_lg_mp_sway2";
}