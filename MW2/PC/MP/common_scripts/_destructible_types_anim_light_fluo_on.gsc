/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible_types_anim_light_fluo_on.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	level._destructible_preanims["light_fluorescent_swing"] = %anim_001E;
	level._destructible_preanims["light_fluorescent_null"] = %anim_001D;
	level._destructible_preanims["light_fluorescent_swing_02"] = %anim_001C;
	level._effect["spotlight_fx"] = loadfx("misc/fluorescent_spotlight");
}