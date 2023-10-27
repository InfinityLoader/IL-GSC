/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_hiding_door_anims.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 47 ms
 * Timestamp: 10/27/2023 2:34:22 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.scr_animtree["iding_door"] = #animtree;
	level.var_1B2E["hiding_door"] = "com_door_01_handleleft";
	level.scr_anim["hiding_door"]["close"] = %doorpeek_close_door;
	level.scr_anim["hiding_door"]["death_1"] = %doorpeek_deatha_door;
	level.scr_anim["hiding_door"]["death_2"] = %doorpeek_deathb_door;
	level.scr_anim["hiding_door"]["fire_1"] = %doorpeek_firea_door;
	level.scr_anim["hiding_door"]["fire_2"] = %doorpeek_fireb_door;
	level.scr_anim["hiding_door"]["fire_3"] = %doorpeek_firec_door;
	level.scr_anim["hiding_door"]["peek"] = %doorpeek_idle_door;
	level.scr_anim["hiding_door"]["grenade"] = %doorpeek_grenade_door;
	level.scr_anim["hiding_door"]["idle"][0] = %doorpeek_idle_door;
	level.scr_anim["hiding_door"]["jump"] = %doorpeek_jump_door;
	level.scr_anim["hiding_door"]["kick"] = %doorpeek_kick_door;
	level.scr_anim["hiding_door"]["open"] = %doorpeek_open_door;
	precachemodel(level.var_1B2E["hiding_door"]);
	maps\_anim::addnotetrack_sound("hiding_door","sound door death","any","scn_doorpeek_door_open_death");
	maps\_anim::addnotetrack_sound("hiding_door","sound door open","any","scn_doorpeek_door_open");
	maps\_anim::addnotetrack_sound("hiding_door","sound door slam","any","scn_doorpeek_door_slam");
	func_3BAE();
	thread notetracks();
}

//Function Number: 2
func_3BAE()
{
	level.scr_anim["hiding_door_guy"]["close"] = %doorpeek_close;
	level.scr_anim["hiding_door_guy"]["death_1"] = %doorpeek_deatha;
	level.scr_anim["hiding_door_guy"]["death_2"] = %doorpeek_deathb;
	level.scr_anim["hiding_door_guy"]["fire_1"] = %doorpeek_firea;
	level.scr_anim["hiding_door_guy"]["fire_2"] = %doorpeek_fireb;
	level.scr_anim["hiding_door_guy"]["fire_3"] = %doorpeek_firec;
	level.scr_anim["hiding_door_guy"]["peek"] = %doorpeek_idle;
	level.scr_anim["hiding_door_guy"]["grenade"] = %doorpeek_grenade;
	level.scr_anim["hiding_door_guy"]["idle"][0] = %doorpeek_idle;
	level.scr_anim["hiding_door_guy"]["jump"] = %doorpeek_jump;
	level.scr_anim["hiding_door_guy"]["kick"] = %doorpeek_kick;
	level.scr_anim["hiding_door_guy"]["open"] = %doorpeek_open;
}

//Function Number: 3
notetracks()
{
	wait 0.05;
	maps\_anim::addnotetrack_customfunction("hiding_door_guy","grenade_throw",::maps\_hiding_door::func_E5D);
}