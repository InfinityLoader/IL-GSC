/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _patrol_anims_active.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 63 ms
 * Timestamp: 4/22/2024 2:22:04 AM
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
	level.scr_anim["generic"]["patrol_walk_gundown"] = %active_patrolwalk_gundown;
	level.scr_anim["generic"]["patrol_walk_gundown_twitch"] = %active_patrolwalk_pause;
	level.scr_anim["generic"]["patrol_stop_gundown"] = %patrol_bored_walk_2_bored;
	level.scr_anim["generic"]["patrol_start_gundown"] = %patrol_bored_2_walk;
	level.scr_anim["generic"]["patrol_turn180_gundown"] = %active_patrolwalk_turn_180;
	level.scr_anim["generic"]["patrol_radio_in_clear_gundown"] = %patrolwalk_cold_gunup_transition;
	level.scr_anim["generic"]["patrol_idle_gundown"] = %patrolstand_idle;
	level.scr_anim["generic"]["patrol_idle_gundown_1"] = %patrolstand_look;
	level.scr_anim["generic"]["patrol_idle_gundown_smoke"] = %patrolstand_twitch;
	level.scr_anim["generic"]["patrol_walk_active"] = [%active_patrolwalk_v1,%active_patrolwalk_v2,%active_patrolwalk_v3,%active_patrolwalk_v4,%active_patrolwalk_v5];
	level.scr_anim["generic"]["patrol_walk_active_1"] = %active_patrolwalk_v2;
	level.scr_anim["generic"]["patrol_walk_active_2"] = %active_patrolwalk_v3;
	level.scr_anim["generic"]["patrol_walk_active_3"] = %active_patrolwalk_v4;
	level.scr_anim["generic"]["patrol_walk_active_4"] = %active_patrolwalk_v5;
	level.scr_anim["generic"]["patrol_walk_active_twitch"] = %active_patrolwalk_v3;
	level.scr_anim["generic"]["patrol_stop_active"] = %active_patrol_walk_2_bored;
	level.scr_anim["generic"]["patrol_start_active"] = %active_patrol_bored_2_walk;
	level.scr_anim["generic"]["patrol_turn180_active"] = %active_patrol_bored_2_walk_180turn;
	level.scr_anim["generic"]["patrol_radio_in_clear_active"] = %patrolwalk_cold_gunup_transition;
	level.scr_anim["generic"]["patrol_idle_active"] = %patrolstand_idle;
	level.scr_anim["generic"]["patrol_idle_active_1"] = %patrolstand_look;
	level.scr_anim["generic"]["patrol_idle_active_smoke"] = %patrolstand_twitch;
	level.scr_anim["generic"]["patrol_idle_active_search"] = %so_hijack_search_flashlight_high_loop;
	level.scr_anim["generic"]["patrol_idle_active_search_loop"][0] = %so_hijack_search_flashlight_high_loop;
	level.scr_anim["generic"]["patrol_walk_active_forward"] = %active_patrolwalk_v1;
	level.scr_anim["generic"]["patrol_walk_active_forward_twitch"] = %active_patrolwalk_v3;
	level.scr_anim["generic"]["patrol_stop_active_forward"] = %patrol_bored_walk_2_bored;
	level.scr_anim["generic"]["patrol_start_active_forward"] = %patrol_bored_2_walk;
	level.scr_anim["generic"]["patrol_turn180_active_forward"] = %active_patrolwalk_turn_180;
	level.scr_anim["generic"]["patrol_radio_in_clear_active_forward"] = %patrolwalk_cold_gunup_transition;
	level.scr_anim["generic"]["patrol_idle_active_forward"] = %patrolstand_idle;
	level.scr_anim["generic"]["patrol_idle_active_forward_1"] = %patrolstand_look;
	level.scr_anim["generic"]["patrol_idle_active_forward_smoke"] = %patrolstand_twitch;
	level.scr_anim["generic"]["patrol_idle_active_forward_search"][0] = %so_hijack_search_flashlight_high_loop;
	level.scr_anim["generic"]["patrol_walk_active_right"] = %active_patrolwalk_v5;
	level.scr_anim["generic"]["patrol_walk_active_right_twitch"] = %active_patrolwalk_v3;
	level.scr_anim["generic"]["patrol_stop_active_right"] = %patrol_bored_walk_2_bored;
	level.scr_anim["generic"]["patrol_start_active_right"] = %patrol_bored_2_walk;
	level.scr_anim["generic"]["patrol_turn180_active_right"] = %active_patrolwalk_turn_180;
	level.scr_anim["generic"]["patrol_radio_in_clear_active_right"] = %patrolwalk_cold_gunup_transition;
	level.scr_anim["generic"]["patrol_idle_active_right"] = %patrolstand_idle;
	level.scr_anim["generic"]["patrol_idle_active_right_1"] = %patrolstand_look;
	level.scr_anim["generic"]["patrol_idle_active_right_smoke"] = %patrolstand_twitch;
	level.scr_anim["generic"]["patrol_idle_active_right_search"][0] = %so_hijack_search_flashlight_high_loop;
	level.scr_anim["generic"]["patrol_walk_active_left"] = [%active_patrolwalk_v2,%active_patrolwalk_v3,%active_patrolwalk_v4];
	level.scr_anim["generic"]["patrol_walk_active_left_twitch"] = %active_patrolwalk_v3;
	level.scr_anim["generic"]["patrol_stop_active_left"] = %patrol_bored_walk_2_bored;
	level.scr_anim["generic"]["patrol_start_active_left"] = %patrol_bored_2_walk;
	level.scr_anim["generic"]["patrol_turn180_active_left"] = %active_patrolwalk_turn_180;
	level.scr_anim["generic"]["patrol_radio_in_clear_active_left"] = %patrolwalk_cold_gunup_transition;
	level.scr_anim["generic"]["patrol_idle_active_left"] = %patrolstand_idle;
	level.scr_anim["generic"]["patrol_idle_active_rleft_1"] = %patrolstand_look;
	level.scr_anim["generic"]["patrol_idle_active_left_smoke"] = %patrolstand_twitch;
	level.scr_anim["generic"]["patrol_idle_active_left_search"][0] = %so_hijack_search_flashlight_high_loop;
}

//Function Number: 3
dogs()
{
}