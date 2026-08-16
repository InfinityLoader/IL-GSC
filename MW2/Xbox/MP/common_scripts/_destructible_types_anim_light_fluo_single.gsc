/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible_types_anim_light_fluo_single.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	level._destructible_preanims["light_fluorescent_single_swing"] = %anim_001A;
	level._destructible_preanims["light_fluorescent_single_null"] = %anim_001B;
	level._destructible_preanims["light_fluorescent_single_swing_02"] = %anim_0019;
	level._destructible_preanims["light_fluorescent_single_swing_03"] = %anim_0018;
	level._effect["spotlight_fx"] = loadfx("misc/fluorescent_spotlight");
}