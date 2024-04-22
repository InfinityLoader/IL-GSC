/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _patrol_cold_anims.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 51 ms
 * Timestamp: 4/22/2024 2:22:06 AM
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
	level.scr_anim["generic"]["patrol_walk"] = %patrolwalk_cold_huddle_idle;
	level.scr_anim["generic"]["patrol_walk_twitch"] = %patrolwalk_cold_huddle_twitch;
	level.scr_anim["generic"]["patrol_stop"] = %patrolwalk_cold_huddle_walk2stand;
	level.scr_anim["generic"]["patrol_start"] = %patrolwalk_cold_huddle_stand2walk;
	level.scr_anim["generic"]["patrol_turn180"] = %patrol_bored_2_walk_180turn;
	level.scr_anim["generic"]["patrol_radio_in_clear"] = %patrolwalk_cold_gunup_transition;
	level.scr_anim["generic"]["patrol_idle_1"] = %patrol_bored_idle;
	level.scr_anim["generic"]["patrol_idle_2"] = %patrol_bored_idle_smoke;
	level.scr_anim["generic"]["patrol_idle_3"] = %patrol_bored_idle_cellphone;
	level.scr_anim["generic"]["patrol_idle_4"] = %patrol_bored_twitch_bug;
	level.scr_anim["generic"]["patrol_idle_5"] = %patrol_bored_twitch_checkphone;
	level.scr_anim["generic"]["patrol_idle_6"] = %patrol_bored_twitch_stretch;
	level.scr_anim["generic"]["patrol_idle_smoke"] = %patrol_bored_idle_smoke;
	level.scr_anim["generic"]["patrol_idle_checkphone"] = %patrol_bored_twitch_checkphone;
	level.scr_anim["generic"]["patrol_idle_stretch"] = %patrol_bored_twitch_stretch;
	level.scr_anim["generic"]["patrol_idle_phone"] = %patrol_bored_idle_cellphone;
}

//Function Number: 3
dogs()
{
	level.scr_anim["generic"]["patrol_dog_stop"] = %iw6_dog_attackidle_runin_8;
	level.scr_anim["generic"]["patrol_dog_start"] = %iw6_dog_attackidle_runout_8;
}