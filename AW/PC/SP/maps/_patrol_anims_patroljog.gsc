/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_patrol_anims_patroljog.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 2:00:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	humans();
	dogs();
}

//Function Number: 2
humans()
{
	level.scr_anim["generic"]["_stealth_patrol_walk_patroljog"] = %patrol_jog;
	level.scr_anim["generic"]["patrol_walk_patroljog"][0] = %patrol_jog;
	level.scr_anim["generic"]["patrol_lookup"] = %patrol_jog_look_up_once;
	level.scr_anim["generic"]["patrol_orders"] = %patrol_jog_orders_once;
	level.scr_anim["generic"]["patrol_360"] = %patrol_jog_360_once;
	level.patrol_scriptedanims["patrol_lookup"] = "patrol_lookup";
	level.patrol_scriptedanims["patrol_orders"] = "patrol_orders";
	level.patrol_scriptedanims["patrol_360"] = "patrol_360";
}

//Function Number: 3
dogs()
{
}