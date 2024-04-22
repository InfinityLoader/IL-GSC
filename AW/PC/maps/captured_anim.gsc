/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_anim.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 206 ms
 * Timestamp: 4/22/2024 2:25:57 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(level.nextgen)
	{
		anim.forced_s1_motionset = 1;
	}

	player_anims();
	generic_human_anims();
	script_model_anims();
	vehicle_anims();
}

//Function Number: 2
player_anims()
{
	level.scr_animtree["player_rig_noexo"] = #animtree;
	level.scr_model["player_rig_noexo"] = "viewbody_sentinel_pilot_mitchell_noexo";
	level.scr_animtree["player_rig"] = #animtree;
	level.scr_model["player_rig"] = "viewbody_sentinel_pilot_mitchell_smashed";
	level.scr_animtree["player_rig_smashed_noexo"] = #animtree;
	level.scr_model["player_rig_smashed_noexo"] = "viewbody_sentinel_pilot_mitchell_smashed_noexo";
	level.scr_animtree["player_arms"] = #animtree;
	level.scr_model["player_arms"] = "worldhands_sentinel_pilot_mitchell_noexo";
	level.scr_anim["player_rig_noexo"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_player;
	maps\_anim::addnotetrack_customfunction("player_rig_noexo","start_guards_anim",::maps\captured_introdrive::nt_s1_truck_dismount_guards,"truck_to_s1elevator_unload");
	maps\_anim::addnotetrack_customfunction("player_rig_noexo","fx_intro_ambient",::maps\captured_fx::fx_intro_ambient,"truck_to_s1elevator_unload");
	maps\_anim::addnotetrack_customfunction("player_rig_noexo","fx_intro_truck_dust",::maps\captured_fx::fx_intro_truck_dust,"truck_to_s1elevator_unload");
	maps\_anim::addnotetrack_customfunction("player_rig_noexo","fx_intro_body_dust",::maps\captured_fx::fx_intro_body_dust,"truck_to_s1elevator_unload");
	level.scr_anim["player_rig_noexo"]["truck_to_s1elevator_push"] = %cap_s1_elevator_player_enter;
	maps\_anim::addnotetrack_customfunction("player_rig_noexo","start_allies_anim",::maps\captured_introdrive::nt_s1_elevator_push_fall,"truck_to_s1elevator_push");
	level.scr_anim["player_rig_noexo"]["s2walk_elevator_scene"] = %cap_s1_elevator_player;
	level.scr_anim["player_rig_noexo"]["s2walk_intro_grab"] = %cap_s2_walk_start_player;
	maps\_anim::addnotetrack_customfunction("player_rig_noexo","start_allies_walk",::maps\captured_s2walk::nt_s2walk_anims_start,"s2walk_intro_grab");
	level.scr_anim["player_arms"]["s2walk_idle"][0] = %cap_s2_walk_player_walking_idle;
	level.scr_anim["player_arms"]["s2walk_punish_left"] = %cap_s2_walk_player_walking_hit_l;
	level.scr_anim["player_arms"]["s2walk_punish_right"] = %cap_s2_walk_player_walking_hit_r;
	level.scr_anim["player_rig_noexo"]["s2walk_intro_trolley"] = %cap_s2_zip_into_trolley_player;
	level.scr_anim["player_rig_noexo"]["s3_interrogation"] = %cap_s3_interrogation_player;
	level.scr_anim["player_rig_smashed_noexo"]["s3_interrogation"] = %cap_s3_interrogation_player;
	maps\_anim::addnotetrack_customfunction("player_rig_smashed_noexo","unhide_rig",::maps\captured_s3::s3_toggle_rig,"s3_interrogation");
	maps\_anim::addnotetrack_customfunction("player_rig_noexo","fx_interrogation_arm_smash",::maps\captured_fx::fx_interrogation_arm_smash,"s3_interrogation");
	level.scr_anim["player_rig_noexo"]["s3_breakout"] = %cap_s3_rescue_player;
	level.scr_anim["player_rig_smashed_noexo"]["s3_breakout"] = %cap_s3_rescue_player;
	maps\_anim::addnotetrack_customfunction("player_rig_noexo","unhide_rig",::maps\captured_s3::s3_toggle_rig,"s3_breakout");
	level.scr_anim["player_rig"]["s3escape_takedown"] = %cap_s3_escape_controlroom_player;
	maps\_anim::addnotetrack_customfunction("player_rig","start_gideon_help",::maps\captured_s3::s3_escape_player_gun,"s3escape_takedown");
	level.scr_anim["player_rig_noexo"]["s3escape_takedown_start"] = %cap_s3_escape_takedown_player;
	level.scr_anim["player_rig"]["s3escape_console_start"] = %cap_s3_escape_console_player_start;
	level.scr_anim["player_rig"]["s3escape_console_loop"][0] = %cap_s3_escape_console_player_loop;
	maps\_anim::addnotetrack_customfunction("player_rig","start_guard_anim",::maps\captured_s3::s3_escape_guards_enter,"s3escape_console_loop");
	maps\_anim::addnotetrack_customfunction("player_rig","start_elevator_anim",::maps\captured_s3::s3_escape_elevator_start,"s3escape_console_loop");
	level.scr_anim["player_rig"]["s3escape_console_end"] = %cap_s3_escape_console_player_end;
	level.scr_anim["player_rig"]["autopsy_doctor_door_open"] = %cap_s3_autopsydoc_opendoor_player;
	level.scr_anim["player_rig"]["autopsy_doctor_player_jump"] = %cap_s3_autopsydoc_hatch_player;
	level.scr_anim["player_rig"]["incinerator_intro"] = %cap_incinerator_start_player;
	level.scr_anim["player_rig"]["incinerator_push_start"] = %cap_incinerator_push_start_player;
	level.scr_anim["player_rig"]["incinerator_push"] = %cap_incinerator_push_player;
	maps\_anim::addnotetrack_customfunction("player_rig","near_miss",::maps\captured_fx::fx_inc_near_miss,"incinerator_push");
	level.scr_anim["player_rig"]["incinerator_push_stop"] = %cap_incinerator_push_stop_player;
	level.scr_anim["player_rig"]["incinerator_crawl"] = %cap_incinerator_crawl_player;
	maps\_anim::addnotetrack_customfunction("player_rig","player_saved",::maps\captured_facility::nt_incinerator_player_saved,"incinerator_crawl");
	maps\_anim::addnotetrack_customfunction("player_rig","sfx_grab_pipe",::maps\captured_facility::nt_incinerator_player_pipe_grab,"incinerator_crawl");
	maps\_anim::addnotetrack_customfunction("player_rig","pipe_explode",::maps\captured_fx::fx_inc_pipe_explode,"incinerator_crawl");
	level.scr_anim["player_rig"]["warbird_scene_begin"] = %cap_vtol_battle_crash_player_begin;
	level.scr_anim["player_rig"]["warbird_scene"] = %cap_vtol_battle_crash_player;
	maps\_anim::addnotetrack_customfunction("player_rig","gideon_in",::maps\captured_facility::nt_warbird_anims_start,"warbird_scene");
	maps\_anim::addnotetrack_customfunction("player_rig","slowmo_start",::maps\captured_facility::nt_helicrash_slowstart,"warbird_scene");
	maps\_anim::addnotetrack_customfunction("player_rig","slowmo_end",::maps\captured_facility::nt_helicrash_slowend,"warbird_scene");
	level.scr_animtree["player_rig_temp"] = #animtree;
	level.scr_model["player_rig_temp"] = "viewbody_sentinel_pilot_mitchell_smashed";
	level.scr_anim["player_rig_temp"]["mech_enter"] = %cap_playermech_getinto_mech_vm;
	maps\_anim::addnotetrack_notify("player_rig_temp","enable_mech","notify_mech_enable","mech_enter");
	level.scr_anim["player_rig"]["anim_mech_wakeup"] = %cap_s1_escape_mech_crash_wakeup_vm;
	level.scr_anim["player_rig"]["end_escape"] = %cap_s1_escape_mech_door_lift_exit_end_player;
	maps\_anim::addnotetrack_customfunction("player_rig","fade_to_black",::maps\captured_end_escape::end_fade_to_black,"end_escape");
	maps\_anim::addnotetrack_customfunction("player_rig","change_fov",::maps\captured_end_escape::end_change_fov,"end_escape");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_mech_exit_land_dust",::maps\captured_fx::fx_mech_exit_land_dust,"end_escape");
}

//Function Number: 3
generic_human_anims()
{
	level.scr_animtree["exterior_ambient_mech"] = #animtree;
	level.scr_anim["exterior_ambient_mech"]["mech_stand_idle"][0] = %mech_stand_idle;
	level.scr_anim["exterior_ambient_mech"]["mech_unaware_idle"][0] = %mech_unaware_idle;
	level.scr_anim["exterior_ambient_mech"]["cap_casual_mech_idle"][0] = %cap_casual_mech_idle;
	level.scr_anim["ally_0"]["truck_drive"] = %cap_s1_drive_gideon_01;
	level.scr_anim["ally_1"]["truck_drive"] = %cap_s1_drive_ilana_01;
	level.scr_anim["guard_2"]["truck_drive"] = %cap_s1_drive_guard_02;
	level.scr_anim["driver"]["truck_drive"] = %cap_s1_drive_driver_01;
	level.scr_anim["prisoner_6"]["truck_drive_player_shadow"] = %cap_s1_drive_player_body;
	level.scr_anim["ally_2"]["s1_truck_start_loop"][0] = %cap_s1_pretruck_cormack_01_loop;
	level.scr_anim["guard_1"]["s1_truck_start_loop"][0] = %cap_s1_pretruck_guard_01_loop;
	level.scr_anim["guard_2"]["s1_truck_start_loop"][0] = %cap_s1_pretruck_guard_02_loop;
	level.scr_anim["guard_3"]["s1_truck_start_loop"][0] = %cap_s1_pretruck_guard_03_loop;
	level.scr_anim["guard_5"]["s1_truck_start_loop"][0] = %cap_s1_pretruck_guard_05_loop;
	level.scr_anim["general_1"]["s1_truck_start_loop"][0] = %cap_s1_pretruck_general_01_loop;
	level.scr_anim["prisoner_6"]["s1_truck_start_loop"][0] = %cap_s1_pretruck_prisoner_06_loop;
	level.scr_anim["prisoner_5"]["s1_truck_start_loop"][0] = %cap_s1_truck_dismount_prisoner_05_loop;
	level.scr_anim["prisoner_7"]["s1_truck_start_loop"][0] = %cap_s1_truck_dismount_prisoner_07_loop;
	level.scr_anim["ally_0"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_gideon_01;
	level.scr_anim["ally_1"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_ilana_01;
	level.scr_anim["ally_2"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_cormack_01;
	level.scr_anim["guard_1"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_guard_01;
	level.scr_anim["guard_2"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_guard_02;
	level.scr_anim["guard_3"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_guard_03;
	level.scr_anim["guard_5"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_guard_05;
	level.scr_anim["general_1"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_general_01;
	level.scr_anim["prisoner_1"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_prisoner_01;
	level.scr_anim["prisoner_2"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_prisoner_02;
	level.scr_anim["prisoner_3"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_prisoner_03;
	level.scr_anim["prisoner_4"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_prisoner_04;
	level.scr_anim["prisoner_6"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_prisoner_06;
	level.scr_anim["prisoner_8"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_prisoner_08;
	level.scr_anim["prisoner_10"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_prisoner_10;
	level.scr_anim["prisoner_11"]["truck_to_s1elevator_unload"] = %cap_s1_truck_dismount_prisoner_11;
	level.scr_anim["guard_1"]["truck_to_s1elevator_loop"][0] = %cap_s1_truck_dismount_guard_01_loop;
	level.scr_anim["guard_3"]["truck_to_s1elevator_loop"][0] = %cap_s1_truck_dismount_guard_03_loop;
	level.scr_anim["guard_5"]["truck_to_s1elevator_loop"][0] = %cap_s1_truck_dismount_guard_05_loop;
	level.scr_anim["general_1"]["truck_to_s1elevator_loop"][0] = %cap_s1_truck_dismount_general_01_loop;
	level.scr_anim["prisoner_6"]["truck_to_s1elevator_loop"][0] = %cap_s1_truck_dismount_prisoner_06_loop;
	level.scr_anim["ally_0"]["truck_to_s1elevator_loop"][0] = %cap_s1_elevator_gideon_01_loop;
	level.scr_anim["ally_1"]["truck_to_s1elevator_loop"][0] = %cap_s1_elevator_ilana_01_loop;
	level.scr_anim["ally_2"]["truck_to_s1elevator_loop"][0] = %cap_s1_elevator_cormack_01_loop;
	level.scr_anim["guard_2"]["truck_to_s1elevator_loop"][0] = %cap_s1_elevator_guard_02_loop;
	level.scr_anim["prisoner_8"]["truck_to_s1elevator_loop"][0] = %cap_s1_elevator_prisoner_08_loop;
	level.scr_anim["ally_0"]["truck_to_s1elevator_push"] = %cap_s1_elevator_gideon_01_enter;
	maps\_anim::addnotetrack_customfunction("ally_0","start_guard_anims",::maps\captured_introdrive::nt_s1_elevator_end,"truck_to_s1elevator_push");
	maps\_anim::addnotetrack_customfunction("ally_0","fx_gideon_hits_ground",::maps\captured_fx::fx_gideon_body_dust,"truck_to_s1elevator_push");
	level.scr_anim["ally_1"]["truck_to_s1elevator_push"] = %cap_s1_elevator_ilana_01_enter;
	level.scr_anim["ally_2"]["truck_to_s1elevator_push"] = %cap_s1_elevator_cormack_01_enter;
	level.scr_anim["guard_2"]["truck_to_s1elevator_push"] = %cap_s1_elevator_guard_02_enter;
	level.scr_anim["prisoner_8"]["truck_to_s1elevator_push"] = %cap_s1_elevator_prisoner_08_enter;
	level.scr_anim["ally_2"]["s2walk_elevator_scene"] = %cap_s1_elevator_cormack_01;
	level.scr_anim["ally_0"]["s2walk_elevator_scene"] = %cap_s1_elevator_gideon_01;
	level.scr_anim["ally_1"]["s2walk_elevator_scene"] = %cap_s1_elevator_ilana_01;
	level.scr_anim["guard_1"]["s2walk_guard_intro_loop"][0] = %cap_s2_walk_start_guard_01_intro_loop;
	level.scr_anim["guard_2"]["s2walk_guard_intro_loop"][0] = %cap_s2_walk_start_guard_02_intro_loop;
	level.scr_anim["guard_3"]["s2walk_guard_intro_loop"][0] = %cap_s2_walk_start_guard_03_intro_loop;
	level.scr_anim["guard_4"]["s2walk_guard_intro_loop"][0] = %cap_s2_walk_start_guard_04_intro_loop;
	level.scr_anim["guard_5"]["s2walk_guard_intro_loop"][0] = %cap_s2_walk_start_guard_05_intro_loop;
	level.scr_anim["ally_2"]["s2walk_intro_start_allies"] = %cap_s2_walk_start_cormack_01;
	level.scr_anim["ally_0"]["s2walk_intro_start_allies"] = %cap_s2_walk_start_gideon_01;
	level.scr_anim["ally_1"]["s2walk_intro_start_allies"] = %cap_s2_walk_start_ilana_01;
	level.scr_anim["guard_1"]["s2walk_intro_start_front"] = %cap_s2_walk_start_guard_01;
	level.scr_anim["guard_2"]["s2walk_intro_start_front"] = %cap_s2_walk_start_guard_02;
	level.scr_anim["guard_3"]["s2walk_intro_start_third"] = %cap_s2_walk_start_guard_03_walk_up;
	level.scr_anim["guard_4"]["s2walk_intro_start_back"] = %cap_s2_walk_start_guard_04;
	level.scr_anim["guard_5"]["s2walk_intro_start_back"] = %cap_s2_walk_start_guard_05;
	level.scr_anim["ally_2"]["s2walk_wait_intro_loop_allies"][0] = %cap_s2_walk_start_cormack_01_loop;
	level.scr_anim["ally_0"]["s2walk_wait_intro_loop_allies"][0] = %cap_s2_walk_start_gideon_01_loop;
	level.scr_anim["ally_1"]["s2walk_wait_intro_loop_allies"][0] = %cap_s2_walk_start_ilana_01_loop;
	level.scr_anim["guard_1"]["s2walk_wait_intro_loop_front"][0] = %cap_s2_walk_start_guard_01_wait_loop;
	level.scr_anim["guard_2"]["s2walk_wait_intro_loop_front"][0] = %cap_s2_walk_start_guard_02_wait_loop;
	level.scr_anim["guard_3"]["s2walk_wait_intro_loop_thrid"][0] = %cap_s2_walk_start_guard_03_wait_loop;
	level.scr_anim["guard_4"]["s2walk_wait_intro_loop_back"][0] = %cap_s2_walk_start_guard_04_end_loop;
	level.scr_anim["guard_5"]["s2walk_wait_intro_loop_back"][0] = %cap_s2_walk_start_guard_05_end_loop;
	level.scr_anim["guard_1"]["s2walk_intro_grab"] = %cap_s2_walk_start_guard_01_player_pass;
	level.scr_anim["guard_2"]["s2walk_intro_grab"] = %cap_s2_walk_start_guard_02_player_pass;
	level.scr_anim["guard_3"]["s2walk_intro_grab"] = %cap_s2_walk_start_guard_03;
	level.scr_anim["guard_0"]["s2walk_loop"][0] = %cap_s2_walk_guard_01_loop;
	level.scr_anim["guard_1"]["s2walk_loop"][0] = %cap_s2_walk_guard_02_loop;
	level.scr_anim["ally_0"]["s2walk"] = %cap_s2_walk_ally_02;
	maps\_anim::addnotetrack_customfunction("ally_0","start_guard_03_anim",::maps\captured_s2walk::nt_trolley_guard_start,"s2walk");
	maps\_anim::addnotetrack_customfunction("ally_0","start_player_trolley_anim",::maps\captured_s2walk::nt_trolley_player_start,"s2walk");
	maps\_anim::addnotetrack_customfunction("ally_0","start_zipline_anim",::maps\captured_s2walk::nt_trolley_zip_start,"s2walk");
	maps\_anim::addnotetrack_customfunction("ally_0","start_doc_drug_anim",::maps\captured_s2walk::nt_trolley_doctor_start,"s2walk");
	maps\_anim::addnotetrack_customfunction("ally_0","fx_body_dust_drag_02",::maps\captured_fx::fx_body_dust_drag,"s2walk");
	maps\_anim::addnotetrack_customfunction("ally_0","fx_footstep_water_small_le",::maps\captured_fx::fx_footstep_water_small_le,"s2walk");
	maps\_anim::addnotetrack_customfunction("ally_0","fx_footstep_water_small_ri",::maps\captured_fx::fx_footstep_water_small_ri,"s2walk");
	level.scr_anim["ally_1"]["s2walk"] = %cap_s2_walk_ally_03;
	maps\_anim::addnotetrack_customfunction("ally_1","fx_footstep_water_small_le",::maps\captured_fx::fx_footstep_water_small_le,"s2walk");
	maps\_anim::addnotetrack_customfunction("ally_1","fx_footstep_water_small_ri",::maps\captured_fx::fx_footstep_water_small_ri,"s2walk");
	level.scr_anim["ally_2"]["s2walk"] = %cap_s2_walk_ally_01;
	maps\_anim::addnotetrack_customfunction("ally_2","fx_footstep_water_small_ri",::maps\captured_fx::fx_footstep_water_small_ri,"s2walk");
	level.scr_anim["guard_0"]["s2walk"] = %cap_s2_walk_guard_01;
	maps\_anim::addnotetrack_customfunction("guard_0","fx_footstep_water_small_ri",::maps\captured_fx::fx_footstep_water_small_le,"s2walk");
	maps\_anim::addnotetrack_customfunction("guard_0","cap_020_250_gr5",::maps\captured_vo::s2walk_guard_gate_vo_notetrack,"s2walk");
	maps\_anim::addnotetrack_customfunction("guard_0","cap_020_405_gr11",::maps\captured_vo::s2walk_guard_cages_vo_notetrack,"s2walk");
	level.scr_anim["guard_1"]["s2walk"] = %cap_s2_walk_guard_02;
	maps\_anim::addnotetrack_customfunction("guard_1","fx_footstep_water_small_le",::maps\captured_fx::fx_footstep_water_small_le,"s2walk");
	maps\_anim::addnotetrack_customfunction("guard_1","fx_footstep_water_small_ri",::maps\captured_fx::fx_footstep_water_small_ri,"s2walk");
	level.scr_anim["guard_end"]["s2walk"] = %cap_s2_walk_guard_03;
	level.scr_anim["guard_3"]["s2walk_intro_trolley"] = %cap_s2_zip_into_trolley_guard_03;
	maps\_anim::addnotetrack_customfunction("guard_3","start_door_01_anim",::maps\captured_s2walk::nt_trolley_door_01,"s2walk_intro_trolley");
	maps\_anim::addnotetrack_customfunction("guard_3","start_door_02_anim",::maps\captured_s2walk::nt_trolley_door_02,"s2walk_intro_trolley");
	maps\_anim::addnotetrack_customfunction("guard_3","start_gate_01_anim",::maps\captured_s2walk::nt_trolley_gate,"s2walk_intro_trolley");
	level.scr_anim["guard_3"]["s2walk_intro_trolley_loop"][0] = %cap_s2_zip_into_trolley_guard_03_loop;
	level.scr_anim["drug_doctor"]["s2walk_intro_trolley"] = %cap_s2_trolley_drug_doc;
	level.scr_anim["ally_0"]["s3_interrogation"] = %cap_s3_interrogation_gideon_01;
	level.scr_anim["ally_1"]["s3_interrogation"] = %cap_s3_interrogation_ilana_01;
	level.scr_anim["ally_2"]["s3_interrogation"] = %cap_s3_interrogation_cormack_01;
	level.scr_anim["irons"]["s3_interrogation"] = %cap_s3_interrogation_irons_01;
	maps\_anim::addnotetrack_customfunction("irons","fx_irons_fire",::maps\captured_fx::fx_interrogation_irons_fire,"s3_interrogation");
	level.scr_anim["guard_0"]["s3_interrogation"] = %cap_s3_interrogation_guard_01;
	level.scr_anim["guard_1"]["s3_interrogation"] = %cap_s3_interrogation_guard_02;
	level.scr_anim["guard_2"]["s3_interrogation"] = %cap_s3_interrogation_guard_03;
	level.scr_anim["ally_0"]["s3_breakout"] = %cap_s3_rescue_gideon_01;
	level.scr_anim["ally_0"]["s3_breakout_loop"][0] = %cap_s3_rescue_gideon_01_loop;
	level.scr_anim["ally_1"]["s3_breakout"] = %cap_s3_rescue_ilana_01;
	level.scr_anim["ally_1"]["s3_breakout_loop"][0] = %cap_s3_rescue_ilana_01_loop;
	level.scr_anim["ally_2"]["s3_breakout"] = %cap_s3_rescue_cormack_01;
	level.scr_anim["ally_2"]["s3_breakout_loop"][0] = %cap_s3_rescue_cormack_01_loop;
	level.scr_anim["guard_1"]["s3_breakout"] = %cap_s3_rescue_guard_02;
	maps\_anim::addnotetrack_customfunction("guard_1","fire",::maps\captured_fx::fx_rescue_guard_fire,"s3_breakout");
	maps\_anim::addnotetrack_customfunction("guard_1","fx_body_slam",::maps\captured_fx::fx_rescue_body_slam_1,"s3_breakout");
	maps\_anim::addnotetrack_customfunction("guard_1","fx_head_slam_1",::maps\captured_fx::fx_rescue_head_slam_1,"s3_breakout");
	maps\_anim::addnotetrack_customfunction("guard_1","fx_head_slam_2",::maps\captured_fx::fx_rescue_head_slam_2,"s3_breakout");
	maps\_anim::addnotetrack_customfunction("guard_1","start_glass_shatter",::maps\captured_s3::s3_break_glass,"s3_breakout");
	level.scr_anim["guard_2"]["s3_breakout"] = %cap_s3_rescue_guard_03;
	maps\_anim::addnotetrack_customfunction("guard_2","fx_init",::maps\captured_fx::fx_rescue_guard_2_init,"s3_breakout");
	maps\_anim::addnotetrack_customfunction("guard_2","fx_body_slam",::maps\captured_fx::fx_rescue_body_slam_2,"s3_breakout");
	level.scr_anim["ally_2"]["s3escape_hallway"] = %cap_s3_escape_hallway_cormack_01;
	level.scr_anim["ally_1"]["s3escape_hallway"] = %cap_s3_escape_hallway_ilana_01;
	level.scr_anim["ally_0"]["s3escape_hallway"] = %cap_s3_escape_hallway_gideon_01;
	level.scr_anim["ally_2"]["s3escape_hallway_loop"][0] = %cap_s3_escape_hallway_cormack_01_loop;
	level.scr_anim["ally_1"]["s3escape_hallway_loop"][0] = %cap_s3_escape_hallway_ilana_01_loop;
	level.scr_anim["ally_0"]["s3escape_hallway_loop"][0] = %cap_s3_escape_hallway_gideon_01_loop;
	level.scr_anim["doctor"]["s3escape_doctor_scene"] = %cap_s3_escape_doc_push_doctor;
	maps\_anim::addnotetrack_customfunction("doctor","cap_050_030_rw4_r",::maps\captured_aud::aud_s3escape_doctor_radio,"s3escape_doctor_scene");
	level.scr_anim["ally_2"]["s3escape_hallway_end"] = %cap_s3_escape_hallway_cormack_01_end;
	level.scr_anim["ally_1"]["s3escape_hallway_end"] = %cap_s3_escape_hallway_ilana_01_end;
	level.scr_anim["ally_0"]["s3escape_hallway_end"] = %cap_s3_escape_hallway_gideon_01_end;
	level.scr_anim["ally_2"]["s3escape_hallway_end_loop"][0] = %cap_s3_escape_takedown_cormack_01_doorloop;
	level.scr_anim["ally_1"]["s3escape_hallway_end_loop"][0] = %cap_s3_escape_takedown_ilana_01_doorloop;
	level.scr_anim["ally_0"]["s3escape_hallway_end_loop"][0] = %cap_s3_escape_takedown_gideon_01_doorloop;
	level.scr_anim["guard_1"]["s3escape_hallway_end_loop"][0] = %cap_s3_escape_takedown_guard_01_doorloop;
	level.scr_anim["guard_1"]["s3escape_takedown"] = %cap_s3_escape_takedown_guard_01;
	level.scr_anim["ally_2"]["s3escape_takedown"] = %cap_s3_escape_takedown_cormack_01;
	level.scr_anim["ally_1"]["s3escape_takedown"] = %cap_s3_escape_takedown_ilana_01;
	level.scr_anim["ally_0"]["s3escape_takedown"] = %cap_s3_escape_takedown_gideon_01;
	maps\_anim::addnotetrack_customfunction("ally_0","cap_060_001_gdn",::maps\captured_vo::s3_guard_takedown_vo_notetrack,"s3escape_takedown");
	maps\_anim::addnotetrack_customfunction("ally_0","start_door01_anim",::maps\captured_s3::s3_escape_door_notetrack,"s3escape_takedown");
	maps\_anim::addnotetrack_customfunction("ally_0","fx_escape_takedown_wastebasket",::maps\captured_fx::fx_escape_takedown_wastebasket,"s3escape_takedown");
	maps\_anim::addnotetrack_customfunction("ally_0","fx_escape_takedown_foot_stomp",::maps\captured_fx::fx_escape_takedown_foot_stomp,"s3escape_takedown");
	level.scr_anim["ally_2"]["s3escape_takedown_loop"][0] = %cap_s3_escape_takedown_cormack_01_loop;
	level.scr_anim["ally_1"]["s3escape_takedown_loop"][0] = %cap_s3_escape_takedown_ilana_01_loop;
	level.scr_anim["ally_0"]["s3escape_takedown_loop"][0] = %cap_s3_escape_takedown_gideon_01_loop;
	level.scr_anim["guard_1"]["s3escape_takedown_start"] = %cap_s3_escape_takedown_death_guard_01;
	level.scr_anim["ally_0"]["s3escape_takedown_gun_help"] = %cap_s3_escape_takedown_gideon_01_help;
	level.scr_anim["ally_2"]["s3escape_controlroom"] = %cap_s3_escape_controlroom_cormack_01;
	level.scr_anim["ally_1"]["s3escape_controlroom"] = %cap_s3_escape_controlroom_ilana_01;
	level.scr_anim["ally_0"]["s3escape_controlroom"] = %cap_s3_escape_controlroom_gideon_01;
	maps\_anim::addnotetrack_customfunction("ally_0","start_door02_anim",::maps\captured_s3::s3_escape_controlroom_door_notetrack,"s3escape_controlroom");
	maps\_anim::addnotetrack_customfunction("ally_0","cap_060_061_gdn",::maps\captured_vo::s3_controlroom_vo_notetrack1,"s3escape_controlroom");
	maps\_anim::addnotetrack_customfunction("ally_0","cap_060_062_gdn",::maps\captured_vo::s3_controlroom_vo_notetrack2,"s3escape_controlroom");
	maps\_anim::addnotetrack_customfunction("ally_0","cap_060_071_gdn",::maps\captured_vo::s3_controlroom_vo_notetrack3,"s3escape_controlroom");
	maps\_anim::addnotetrack_customfunction("ally_0","cap_060_090_gdn",::maps\captured_vo::s3_controlroom_vo_notetrack4,"s3escape_controlroom");
	maps\_anim::addnotetrack_customfunction("ally_1","cap_060_111_iln",::maps\captured_vo::s3_controlroom_vo_notetrack5,"s3escape_controlroom");
	maps\_anim::addnotetrack_customfunction("ally_2","cap_060_112_crk",::maps\captured_vo::s3_controlroom_vo_notetrack6,"s3escape_controlroom");
	level.scr_anim["ally_2"]["s3escape_controlroom_loop"][0] = %cap_s3_escape_controlroom_cormack_01_loop;
	level.scr_anim["ally_1"]["s3escape_controlroom_loop"][0] = %cap_s3_escape_controlroom_ilana_01_loop;
	level.scr_anim["ally_0"]["s3escape_controlroom_loop"][0] = %cap_s3_escape_controlroom_gideon_01_loop;
	level.scr_anim["guard_2"]["s3escape_controlroom_attack"] = %cap_s3_escape_controlroom_guard_02_attack;
	level.scr_anim["guard_3"]["s3escape_controlroom_attack"] = %cap_s3_escape_controlroom_guard_03_attack;
	level.scr_anim["ally_2"]["s3escape_controlroom_attack"] = %cap_s3_escape_controlroom_cormack_01_attack;
	level.scr_anim["ally_1"]["s3escape_controlroom_attack"] = %cap_s3_escape_controlroom_ilana_01_attack;
	level.scr_anim["ally_0"]["s3escape_controlroom_attack"] = %cap_s3_escape_controlroom_gideon_01_attack;
	maps\_anim::addnotetrack_customfunction("ally_0","cap_060_113_gdn",::maps\captured_vo::s3_controlroom_attack_vo_notetrack,"s3escape_controlroom_attack");
	level.scr_anim["ally_2"]["s3escape_controlroom_attack_loop"][0] = %cap_s3_escape_controlroom_cormack_01_attackloop;
	level.scr_anim["ally_1"]["s3escape_controlroom_attack_loop"][0] = %cap_s3_escape_controlroom_ilana_01_attackloop;
	level.scr_anim["ally_2"]["s3escape_controlroom_exit"] = %cap_s3_escape_controlroom_cormack_01_exit;
	level.scr_anim["ally_1"]["s3escape_controlroom_exit"] = %cap_s3_escape_controlroom_ilana_01_exit;
	level.scr_anim["ally_0"]["s3escape_controlroom_exit"] = %cap_s3_escape_to_stairs_gideon_01;
	maps\_anim::addnotetrack_customfunction("ally_0","start_door03_anim",::maps\captured_s3::s3_escape_controlroom_exit_door_notetrack,"s3escape_controlroom_exit");
	maps\_anim::addnotetrack_customfunction("ally_0","start_door03_swipe_sfx_anim",::maps\captured_s3::s3_escape_controlroom_exit_door_swipe_sfx_notetrack,"s3escape_controlroom_exit");
	maps\_anim::addnotetrack_customfunction("ally_0","cap_060_132_gdn",::maps\captured_vo::s3_controlroom_exit_vo_notetrack3,"s3escape_controlroom_exit");
	maps\_anim::addnotetrack_customfunction("ally_0","cap_060_133_gdn",::maps\captured_vo::s3_controlroom_exit_vo_notetrack4,"s3escape_controlroom_exit");
	maps\_anim::addnotetrack_customfunction("ally_0","cap_060_121_gdn",::maps\captured_vo::s3_controlroom_exit_vo_notetrack1,"s3escape_controlroom_exit");
	maps\_anim::addnotetrack_customfunction("ally_0","cap_060_140_gdn",::maps\captured_vo::s3_controlroom_exit_vo_notetrack5,"s3escape_controlroom_exit");
	maps\_anim::addnotetrack_customfunction("ally_0","cap_060_161_gdn",::maps\captured_vo::s3_controlroom_exit_vo_notetrack7,"s3escape_controlroom_exit");
	level.scr_anim["ally_0"]["s3escape_controlroom_exit_loop"][0] = %cap_s3_escape_to_stairs_gideon_01_loop;
	level.scr_anim["ally_0"]["tc_stairs"] = %cap_s3_stairclimb_gideon_01;
	maps\_anim::addnotetrack_customfunction("ally_0","start_door_anim",::maps\captured_medical::test_chamber_stairs_up_door_notetrack,"tc_stairs");
	maps\_anim::addnotetrack_customfunction("ally_0","start_door_anim_swipe_sfx",::maps\captured_medical::test_chamber_stairs_up_door_swipe_sfx_notetrack,"tc_stairs");
	level.scr_anim["ally_0"]["tc_landing_loop"][0] = %cap_s3_observation_app_gideon_01_loop;
	level.scr_anim["ally_0"]["tc_hall"] = %cap_s3_observation_app_gideon_02;
	level.scr_anim["ally_0"]["tc_hall_loop"][0] = %cap_s3_observation_app_gideon_02_loop;
	level.scr_anim["ally_0"]["tc_approach"] = %cap_s3_observation_app_gideon_03;
	level.scr_anim["ally_0"]["tc_approach_loop"][0] = %cap_s3_observation_app_gideon_03_loop;
	level.scr_anim["scientist_3"]["tc_manticore_start"] = %cap_s3_observation_mant_start_opfor1;
	level.scr_anim["scientist_4"]["tc_manticore_start"] = %cap_s3_observation_mant_start_opfor2;
	level.scr_anim["scientist_3"]["tc_manticore_loop"][0] = %cap_s3_observation_mant_loop_opfor1;
	level.scr_anim["scientist_4"]["tc_manticore_loop"][0] = %cap_s3_observation_mant_loop_opfor2;
	level.scr_anim["scientist_3"]["tc_manticore_end"] = %cap_s3_observation_mant_runout_opfor1;
	level.scr_anim["scientist_4"]["tc_manticore_end"] = %cap_s3_observation_mant_runout_opfor2;
	level.scr_anim["ally_0"]["tc_melee"] = %cap_s3_observation_gideon_01;
	level.scr_anim["scientist_0"]["tc_melee"] = %cap_s3_observation_tech_01;
	level.scr_anim["scientist_1"]["tc_melee"] = %cap_s3_observation_tech_02_intro;
	level.scr_anim["scientist_2"]["tc_melee"] = %cap_s3_observation_tech_03_intro;
	level.scr_anim["scientist_1"]["tc_scientist_1_loop"][0] = %cap_s3_observation_tech_02_loop;
	level.scr_anim["scientist_2"]["tc_scientist_2_loop"][0] = %cap_s3_observation_tech_03_loop;
	level.scr_anim["scientist_1"]["tc_scientist_1_death"] = %cap_s3_observation_tech_02_death;
	level.scr_anim["scientist_2"]["tc_scientist_2_death"] = %cap_s3_observation_tech_03_death;
	level.scr_anim["ally_0"]["tc_observation"] = %cap_s3_test_chamber_app_gideon_01;
	level.scr_anim["ally_0"]["tc_observation_loop"][0] = %cap_s3_test_chamber_app_gideon_01_loop;
	level.scr_anim["ally_0"]["tc_exit_stairs"] = %cap_s3_test_chamber_app_gideon_02;
	level.scr_anim["ally_0"]["tc_exit_door_loop"][0] = %cap_s3_test_chamber_app_gideon_02_loop;
	level.scr_anim["ally_0"]["tc_enter_test"] = %cap_s3_test_chamber_app_gideon_03;
	level.scr_anim["ally_0"]["tc_enter_test_loop"][0] = %cap_s3_test_chamber_app_gideon_03_loop;
	level.scr_anim["ally_0"]["tc_enter_test_exit_door"] = %cap_s3_test_chamber_app_gideon_04;
	level.scr_anim["ah_tech_1"]["tc_enter_test_exit_door"] = %cap_s3_test_chamber_app_tech1_04;
	level.scr_anim["ah_tech_2"]["tc_enter_test_exit_door"] = %cap_s3_test_chamber_app_tech2_04;
	level.scr_anim["ally_0"]["morgue_exit_door_start"] = %cap_s3_intoautopsy_gideon_01;
	level.scr_anim["ally_0"]["morgue_exit_door_loop"][0] = %cap_s3_intoautopsy_gideon_loop;
	level.scr_anim["ally_0"]["autopsy_entrance_door_loop"][0] = %cap_s3_intoautopsy_gideon_loop_02;
	level.scr_anim["ally_0"]["morgue_exit_door_end"] = %cap_s3_intoautopsy_gideon_02;
	maps\_anim::addnotetrack_notify("ally_0","open_doors","ally_opens_autopsy_outer_door","morgue_exit_door_end");
	maps\_anim::addnotetrack_customfunction("ally_0","computer_door_entry_sfx",::maps\captured_medical::computer_door_entry_sfx_notetrack,"morgue_exit_door_end");
	level.scr_anim["ally_0"]["autopsy_door"] = %cap_s3_autopsy_gideon_01;
	level.scr_anim["autopsy_tech"]["autopsy_door"] = %cap_s3_autopsy_tech_01;
	level.scr_anim["autopsy_tech"]["autopsy_door_tech_loop"][0] = %cap_s3_autopsy_tech_01_loop;
	maps\_anim::addnotetrack_customfunction("ally_0","rifle_butt",::maps\captured_medical::rifle_butt);
	level.scr_anim["tech"]["cap_s3_autopsy_tech_02"] = %cap_s3_autopsy_tech_02;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_02_loop"][0] = %cap_s3_autopsy_tech_02_loop;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_03"] = %cap_s3_autopsy_tech_03;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_03_loop"][0] = %cap_s3_autopsy_tech_03_loop;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_04"] = %cap_s3_autopsy_tech_04;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_04_loop"][0] = %cap_s3_autopsy_tech_04_loop;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_05"] = %cap_s3_autopsy_tech_05;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_05_loop"][0] = %cap_s3_autopsy_tech_05_loop;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_06"] = %cap_s3_autopsy_tech_06;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_06_loop"][0] = %cap_s3_autopsy_tech_06_loop;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_07"] = %cap_s3_autopsy_tech_07;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_07_loop"][0] = %cap_s3_autopsy_tech_07_loop;
	level.scr_anim["tech"]["cap_s3_autopsy_tech_death"] = %civilian_crawl_2_death_b;
	level.scr_anim["doctor"]["autopsy_doctor_loop_start"][0] = %cap_s3_autopsydoc_loopstart_doc;
	level.scr_anim["ally_0"]["autopsy_doctor_gideon_walk"] = %cap_s3_autopsydoc_walkup_gideon;
	level.scr_anim["doctor"]["autopsy_doctor_grabgun"] = %cap_s3_autopsydoc_grabgun_doc;
	level.scr_anim["doctor"]["autopsy_doctor_grabgun_loop"][0] = %cap_s3_autopsydoc_loop2_doc;
	level.scr_anim["ally_0"]["autopsy_doctor_gideon_door_loop"][0] = %cap_s3_autopsydoc_loop_gideon;
	level.scr_anim["doctor"]["autopsy_doctor_door_open"] = %cap_s3_autopsydoc_opendoor_doc;
	level.scr_anim["ally_0"]["autopsy_doctor_door_open"] = %cap_s3_autopsydoc_opendoor_gideon;
	level.scr_anim["ally_0"]["autopsy_doctor_hatch_open_jump"] = %cap_s3_autopsydoc_hatch_gideon;
	level.scr_anim["ally_0"]["autopsy_doctor_hatch_open_loop"][0] = %cap_s3_autopsydoc_loop2_gideon;
	maps\_anim::addnotetrack_customfunction("doctor","fire",::maps\captured_medical::doc_fire,"autopsy_doctor_door_open");
	maps\_anim::addnotetrack_customfunction("doctor","punched",::maps\captured_medical::doc_punched,"autopsy_doctor_door_open");
	level.scr_anim["ally_0"]["incinerator_intro"] = %cap_incinerator_start_gideon;
	level.scr_anim["ally_0"]["incinerator_intro_wait_loop"][0] = %cap_incinerator_start_loop_gideon;
	level.scr_anim["ally_0"]["incinerator_push"] = %cap_incinerator_push_gideon;
	level.scr_anim["ally_0"]["incinerator_push_stop_1"][0] = %cap_incinerator_cart_push_stop_01_gideon;
	level.scr_anim["ally_0"]["incinerator_push_stop_2"][0] = %cap_incinerator_cart_push_stop_02_gideon;
	level.scr_anim["ally_0"]["incinerator_crawl_wait_loop"][0] = %cap_incinerator_crawl_loop_gideon;
	level.scr_anim["ally_0"]["incinerator_crawl_pull"] = %cap_incinerator_end_gideon;
	maps\_anim::addnotetrack_customfunction("ally_0","fx_gideon_hits_ground_inc",::maps\captured_fx::fx_gideon_body_dust_inc,"incinerator_crawl_pull");
	level.scr_anim["op_alarm"]["alarm_start_loop"][0] = %cap_s3_exterior_worker_push_button_start_loop;
	level.scr_anim["op_alarm"]["alarm_push"] = %cap_s3_exterior_worker_push_button;
	level.scr_anim["op_alarm"]["alarm_end_loop"][0] = %cap_s3_exterior_worker_push_button_end_loop;
	level.scr_anim["worker_1"]["runtoheli_worker_window_loop_1"][0] = %cap_s3_observation_tech_01_intro_loop;
	level.scr_anim["worker_2"]["runtoheli_worker_window_loop_2"][0] = %cap_s3_autopsydoc_loopstart_doc;
	level.scr_anim["ally_0"]["runtoheli_window_start"] = %cap_s3_manticore_window_gideon_01;
	level.scr_anim["ally_0"]["runtoheli_window"] = %cap_gdn_theresgottabeenough_anim;
	level.scr_anim["ally_0"]["runtoheli_window_loop"][0] = %cap_s3_manticore_window_gideon_loop_01;
	level.scr_anim["ally_0"]["runtoheli_door_start"] = %cap_s3_manticore_window_gideon_02;
	level.scr_anim["ally_0"]["runtoheli_door_loop"][0] = %cap_s3_manticore_window_gideon_loop_02;
	level.scr_anim["ally_0"]["runtoheli_door_kick"] = %cap_s3_manticore_window_gideon_03;
	level.scr_anim["ally_0"]["warbird_scene"] = %cap_vtol_battle_crash_gideon;
	maps\_anim::addnotetrack_flag("ally_0","manticore_done","flag_bh_run_manticore_done","runtoheli_window_start");
	maps\_anim::addnotetrack_customfunction("ally_0","fire",::maps\captured_fx::fx_heli_gideon_fire,"warbird_scene");
	level.scr_anim["heli_mech_pilot"]["warbird_scene"] = %cap_vtol_battle_crash_mech_head;
	level.scr_anim["heli_pilot"]["warbird_scene"] = %cap_vtol_battle_crash_pilot;
	maps\_anim::addnotetrack_customfunction("heli_mech","fx_heli_mech_punch",::maps\captured_fx::fx_heli_mech_punch,"warbird_scene");
	level.scr_anim["generic"]["melee_pain"] = %exposed_pain_face;
	level.scr_animtree["mech_suit_top"] = #animtree;
	level.scr_animtree["mech_suit_bottom"] = #animtree;
	level.scr_anim["mech_suit_top"]["anim_mech_wakeup"] = %cap_s1_escape_mech_crash_wakeup_mech;
	maps\_anim::addnotetrack_customfunction("mech_suit_top","fx_debris_dust",::maps\captured_fx::fx_heli_crash_debris_dust,"anim_mech_wakeup");
	maps\_anim::addnotetrack_customfunction("mech_suit_top","fx_body_dust",::maps\captured_fx::fx_body_dust_mech,"anim_mech_wakeup");
	maps\_anim::addnotetrack_customfunction("mech_suit_top","mech_intro_amb",::maps\captured_aud::aud_wakeup_amb,"anim_mech_wakeup");
	level.scr_anim["mech_suit_bottom"]["anim_mech_wakeup"] = %cap_s1_escape_mech_crash_wakeup_mech;
	maps\_anim::addnotetrack_customfunction("mech_suit_bottom","fx_footstep_dust_le",::maps\captured_fx::fx_footstep_dust_mech_le,"anim_mech_wakeup");
	maps\_anim::addnotetrack_customfunction("mech_suit_bottom","fx_footstep_dust_ri",::maps\captured_fx::fx_footstep_dust_mech_ri,"anim_mech_wakeup");
	maps\_anim::addnotetrack_customfunction("mech_suit_bottom","fx_knee_dust_le",::maps\captured_fx::fx_knee_dust_mech_le,"anim_mech_wakeup");
	maps\_anim::addnotetrack_customfunction("mech_suit_bottom","fx_knee_dust_ri",::maps\captured_fx::fx_knee_dust_mech_ri,"anim_mech_wakeup");
	level.scr_anim["mech_suit_top"]["anim_exit_mechsuit"] = %cap_s1_escape_mech_door_lift_exit_anim_mech;
	level.scr_anim["mech_suit_bottom"]["anim_exit_mechsuit"] = %cap_s1_escape_mech_door_lift_exit_anim_mech;
	level.scr_anim["ally_0"]["anim_mech_wakeup"] = %cap_s1_escape_mech_crash_wakeup_gideon;
	maps\_anim::addnotetrack_customfunction("ally_0","fx_footstep_dust_le",::maps\captured_fx::fx_footstep_dust_le,"anim_mech_wakeup");
	maps\_anim::addnotetrack_customfunction("ally_0","fx_footstep_dust_ri",::maps\captured_fx::fx_footstep_dust_ri,"anim_mech_wakeup");
	maps\_anim::addnotetrack_customfunction("ally_0","fx_footstep_dust_rocks_le",::maps\captured_fx::fx_footstep_dust_rocks_le,"anim_mech_wakeup");
	maps\_anim::addnotetrack_customfunction("ally_0","fx_footstep_dust_rocks_ri",::maps\captured_fx::fx_footstep_dust_rocks_ri,"anim_mech_wakeup");
	level.scr_anim["ally_0"]["anim_mech_wakeup_exit_loop"][0] = %cap_s1_escape_mech_crash_wakeup_gideon_loop;
	level.scr_model["mech_suit_top"] = "playermech_animated_model_top";
	level.scr_model["mech_suit_bottom"] = "playermech_animated_model_btm";
	level.scr_anim["mech_suit_top"]["mech_enter"] = %cap_playermech_getinto_mech_mech;
	maps\_anim::addnotetrack_customfunction("mech_suit_top","fx_sparks",::maps\captured_fx::fx_heli_crash_enter_mech_sparks,"mech_enter");
	maps\_anim::addnotetrack_customfunction("mech_suit_top","fx_fist_dust",::maps\captured_fx::fx_heli_crash_fist_dust_mech,"mech_enter");
	maps\_anim::addnotetrack_customfunction("mech_suit_top","mech_into_mech_missle",::maps\captured_aud::aud_into_mech_missle,"mech_enter");
	level.scr_anim["mech_suit_bottom"]["mech_enter"] = %cap_playermech_getinto_mech_mech;
	level.scr_anim["ally_0"]["mech_enter"] = %cap_playermech_getinto_mech_gideon;
	level.scr_anim["ally_0"]["mech_enter_loop"][0] = %cap_playermech_getinto_mech_gideon_loop;
	level.scr_anim["generic"]["tower_explode"] = %death_explosion_run_f_v2;
	level.scr_anim["civ_gate0"]["anim_exit_civ_gate_loop"][0] = %cap_s1_escape_mech_gate_lift_prisoner05_loop;
	level.scr_anim["civ_gate0"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner05;
	level.scr_anim["civ_gate1"]["anim_exit_civ_gate_loop"][0] = %cap_s1_escape_mech_gate_lift_prisoner06_loop;
	level.scr_anim["civ_gate1"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner06;
	level.scr_anim["civ_gate2"]["anim_exit_civ_gate_loop"][0] = %cap_s1_escape_mech_gate_lift_prisoner07_loop;
	level.scr_anim["civ_gate2"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner07;
	level.scr_anim["civ_gate3"]["anim_exit_civ_gate_loop"][0] = %cap_s1_escape_mech_gate_lift_prisoner08_loop;
	level.scr_anim["civ_gate3"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner08;
	level.scr_anim["civ_gate4"]["anim_exit_civ_gate_loop"][0] = %cap_s1_escape_mech_gate_lift_prisoner09_loop;
	level.scr_anim["civ_gate4"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner09;
	level.scr_anim["civ_gate5"]["anim_exit_civ_gate_loop"][0] = %cap_s1_escape_mech_gate_lift_prisoner10_loop;
	level.scr_anim["civ_gate5"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner10;
	level.scr_anim["civ_gate6"]["anim_exit_civ_gate_loop"][0] = %cap_s1_escape_mech_gate_lift_prisoner11_loop;
	level.scr_anim["civ_gate6"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner11;
	level.scr_anim["civ_gate7"]["anim_exit_civ_gate_loop"][0] = %cap_s1_escape_mech_gate_lift_prisoner12_loop;
	level.scr_anim["civ_gate7"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner12;
	level.scr_anim["civ_gate8"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner01;
	level.scr_anim["civ_gate9"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner02;
	level.scr_anim["civ_gate10"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner03;
	level.scr_anim["civ_gate11"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_prisoner04;
	level.scr_anim["ally_0"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_gideon;
	level.scr_anim["ally_1"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_ilona;
	level.scr_anim["ally_0"]["anim_exit_loop"][0] = %cap_s1_escape_mech_door_lift_exit_end_gideon_loop;
	level.scr_anim["ally_0"]["end_escape"] = %cap_s1_escape_mech_door_lift_exit_end_gideon;
	level.scr_anim["ally_1"]["end_escape"] = %cap_s1_escape_mech_door_lift_exit_end_ilona;
	var_00 = [%unarmed_covercrouch_pain_front,%unarmed_covercrouch_pain_left_3,%unarmed_covercrouch_left_twitches_react,%unarmed_covercrouch_pain_right,%unarmed_covercrouch_pain_right_2,%unarmed_covercrouch_pain_right_3];
	var_01 = [%unarmed_covercrouch_pain_left_3,%unarmed_covercrouch_left_twitches_react];
	var_02 = [%unarmed_covercrouch_pain_right,%unarmed_covercrouch_pain_right_2,%unarmed_covercrouch_pain_right_3];
	var_03 = [];
	var_03["pain"]["torso_upper"] = var_00;
	var_03["pain"]["torso_upper_extended"] = var_00;
	var_03["pain"]["torso_lower"] = var_00;
	var_03["pain"]["torso_lower_extended"] = var_00;
	var_03["pain"]["head"] = var_00;
	var_03["pain"]["head_extended"] = var_00;
	var_03["pain"]["left_arm"] = var_01;
	var_03["pain"]["left_arm_extended"] = var_01;
	var_03["pain"]["right_arm"] = var_02;
	var_03["pain"]["right_arm_extended"] = var_02;
	var_03["pain"]["leg"] = var_00;
	var_03["pain"]["leg_extended"] = var_00;
	var_03["pain"]["foot"] = var_00;
	var_03["pain"]["foot_extended"] = var_00;
	var_03["pain"]["default_long"] = var_00;
	var_03["pain"]["default_short"] = var_00;
	var_03["pain"]["default_extended"] = var_00;
	var_03["pain"]["crouch_default"] = var_00;
	var_03["pain"]["crouch_left_arm"] = var_01;
	var_03["pain"]["crouch_right_arm"] = var_02;
	maps\_utility::register_archetype("cap_civilian",var_03);
}

//Function Number: 4
script_model_anims()
{
	level.scr_animtree["exterior_ambient_prisoner"] = #animtree;
	level.scr_model["exterior_ambient_prisoner"] = "civ_prisoner_atlas_body";
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_01"] = %cap_s1_prisoner_01;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_02"] = %cap_s1_prisoner_02;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_03"] = %cap_s1_prisoner_03;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_04"] = %cap_s1_prisoner_04;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_05"] = %cap_s1_prisoner_05;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_06"] = %cap_s1_prisoner_06;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_07"] = %cap_s1_prisoner_07;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_08"] = %cap_s1_prisoner_08;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_09"] = %cap_s1_prisoner_09;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_club_01"] = %cap_s1_guard_club_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_club_02"] = %cap_s1_guard_club_02;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_club_03"] = %cap_s1_guard_club_03;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_club_04"] = %cap_s1_guard_club_04;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_beating_guard_01"] = %cap_s1_beating_guard_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_beating_guard_02"] = %cap_s1_beating_guard_02;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_beating_guard_03"] = %cap_s1_beating_guard_03;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_beating_prisoner_01"] = %cap_s1_beating_prisoner_01;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_beating_prisoner_02"] = %cap_s1_beating_prisoner_02;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_beating_prisoner_03"] = %cap_s1_beating_prisoner_03;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_fence_01"] = %cap_s1_guard_fence_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_fence_02"] = %cap_s1_guard_fence_02;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_fence_01"] = %cap_s1_prisoner_fence_01;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_fence_02"] = %cap_s1_prisoner_fence_02;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_fence_03"] = %cap_s1_prisoner_fence_03;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_fence_04"] = %cap_s1_prisoner_fence_04;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_fence_05"] = %cap_s1_prisoner_fence_05;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_prisoner_fence_06"] = %cap_s1_prisoner_fence_06;
	level.scr_anim["exterior_ambient_guard"]["s2_tower_guard_01"] = %s2_tower_guard_01;
	level.scr_anim["exterior_ambient_guard"]["s2_tower_guard_02"] = %s2_tower_guard_02;
	level.scr_anim["exterior_ambient_guard"]["s2_tower_guard_03"] = %s2_tower_guard_03;
	level.scr_anim["exterior_ambient_guard"]["s2_tower_guard_04"] = %s2_tower_guard_04;
	level.scr_anim["exterior_ambient_guard"]["s2_tower_guard_05"] = %s2_tower_guard_05;
	level.scr_anim["exterior_ambient_guard"]["s2_tower_guard_06"] = %s2_tower_guard_06;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_elevator_prisoner_01"][0] = %cap_s1_elevator_prisoner_01;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_elevator_prisoner_02"][0] = %cap_s1_elevator_prisoner_02;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_elevator_prisoner_03"][0] = %cap_s1_elevator_prisoner_03;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_elevator_prisoner_04"][0] = %cap_s1_elevator_prisoner_04;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_elevator_prisoner_05"][0] = %cap_s1_elevator_prisoner_05;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_elevator_prisoner_06"][0] = %cap_s1_elevator_prisoner_06;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_elevator_prisoner_07"][0] = %cap_s1_elevator_prisoner_07;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_elevator_prisoner_08"][0] = %cap_s1_elevator_prisoner_08;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s1_elevator_prisoner_09"][0] = %cap_s1_elevator_prisoner_09;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_beating_prisoner1"] = %cap_s2_walk_beating_prisoner1;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_beating_prisoner2"] = %cap_s2_walk_beating_prisoner2;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_stake_inmate_01"] = %cap_s2_walk_stake_inmate_01;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_stake_inmate_02"] = %cap_s2_walk_stake_inmate_02;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_stake_inmate_03"] = %cap_s2_walk_stake_inmate_03;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_stake_inmate_04"] = %cap_s2_walk_stake_inmate_04;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_kneeling_prisoner_01"] = %cap_s2_walk_kneeling_prisoner_01;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_kneeling_prisoner_02"] = %cap_s2_walk_kneeling_prisoner_02;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_kneeling_prisoner_03"] = %cap_s2_walk_kneeling_prisoner_03;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_kneeling_prisoner_04"] = %cap_s2_walk_kneeling_prisoner_04;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_kneeling_prisoner_05"] = %cap_s2_walk_kneeling_prisoner_05;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_pitexecutions_01"] = %cap_s2_walk_pitexecutions_01;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_pitexecutions_02"] = %cap_s2_walk_pitexecutions_02;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_pitexecutions_03"] = %cap_s2_walk_pitexecutions_03;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_pitexecutions_04"] = %cap_s2_walk_pitexecutions_04;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_pitexecutions_05"] = %cap_s2_walk_pitexecutions_05;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_pitexecutions_06"] = %cap_s2_walk_pitexecutions_06;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_walk_pitexecutions_07"] = %cap_s2_walk_pitexecutions_07;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_guard_immate_fight_pulling_prisoner"] = %cap_s2_guard_immate_fight_pulling_prisoner;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_prisoners_cages_idle_01"] = %cap_s2_prisoners_cages_idle_01;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_prisoners_cages_idle_02"] = %cap_s2_prisoners_cages_idle_02;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_prisoners_cages_idle_03"] = %cap_s2_prisoners_cages_idle_03;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_prisoners_cages_idle_04"] = %cap_s2_prisoners_cages_idle_04;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_prisoners_cages_idle_05"] = %cap_s2_prisoners_cages_idle_05;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_prisoners_cages_idle_06"] = %cap_s2_prisoners_cages_idle_06;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_prisoners_cages_idle_07"] = %cap_s2_prisoners_cages_idle_07;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_prisoners_cages_idle_08"] = %cap_s2_prisoners_cages_idle_08;
	level.scr_anim["exterior_ambient_prisoner"]["cap_s2_prisoners_cages_idle_09"] = %cap_s2_prisoners_cages_idle_09;
	level.scr_animtree["exterior_ambient_guard"] = #animtree;
	level.scr_model["exterior_ambient_guard"] = "atlas_body";
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_club_01"] = %cap_s1_guard_club_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_club_02"] = %cap_s1_guard_club_02;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_club_03"] = %cap_s1_guard_club_03;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_club_04"] = %cap_s1_guard_club_04;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_beating_guard_01"] = %cap_s1_beating_guard_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_beating_guard_02"] = %cap_s1_beating_guard_02;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_beating_guard_03"] = %cap_s1_beating_guard_03;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_fence_01"] = %cap_s1_guard_fence_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s1_guard_fence_02"] = %cap_s1_guard_fence_02;
	level.scr_anim["exterior_ambient_guard"]["s2_gate_guard_gun_up_loop_02"][0] = %s2_gate_guard_gun_up_loop_02;
	level.scr_anim["exterior_ambient_guard"]["s2_gatehouse_guard_gun_down_loop_02"][0] = %s2_gatehouse_guard_gun_down_loop_02;
	level.scr_anim["exterior_ambient_guard"]["s2_tower_guard_walking_loop_01"][0] = %s2_tower_guard_walking_loop_01;
	level.scr_anim["exterior_ambient_guard"]["s2_tower_guard_walking_loop_02"][0] = %s2_tower_guard_walking_loop_02;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_beating_guard1"] = %cap_s2_walk_beating_guard1;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_beating_guard2"] = %cap_s2_walk_beating_guard2;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_guard_catwalks_1"] = %cap_s2_walk_guard_catwalks_1;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_kneeling_guard_01"] = %cap_s2_walk_kneeling_guard_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_kneeling_guard_02"] = %cap_s2_walk_kneeling_guard_02;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_guard_catwalkcells_01"] = %cap_s2_walk_guard_catwalkcells_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_guard_alertwatch_01"] = %cap_s2_walk_guard_alertwatch_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_guard_watchtheline_01"] = %cap_s2_walk_guard_watchtheline_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_guard_keepitmoving_01"] = %cap_s2_walk_guard_keepitmoving_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_guard_walklook_01"] = %cap_s2_walk_guard_walklook_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_guard_watchtheline_02"] = %cap_s2_walk_guard_watchtheline_02;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_s1_guard_start_01"] = %cap_s2_walk_s1_guard_start_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_s1_guard_start_02"] = %cap_s2_walk_s1_guard_start_02;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_walk_guard_door_01"] = %cap_s2_walk_guard_door_01;
	level.scr_anim["exterior_ambient_guard"]["cap_s2_guard_immate_fight_pulling_guard"] = %cap_s2_guard_immate_fight_pulling_guard;
	level.scr_anim["exterior_ambient_guard"]["s2_execution_guard_01"] = %s2_execution_guard_01;
	level.scr_anim["exterior_ambient_guard"]["s2_execution_guard_02"] = %s2_execution_guard_02;
	level.scr_anim["exterior_ambient_guard"]["s2_execution_guard_03"] = %s2_execution_guard_03;
	level.scr_anim["exterior_ambient_guard"]["s2_execution_guard_04"] = %s2_execution_guard_04;
	level.scr_anim["exterior_ambient_guard"]["s2_gate_guard_01"] = %s2_gate_guard_01;
	level.scr_anim["exterior_ambient_guard"]["s2_gate_guard_02"] = %s2_gate_guard_02;
	level.scr_animtree["intro_truck"] = #animtree;
	level.scr_anim["intro_truck"]["introdrive_truckopen"] = %cap_s1_drive_truck;
	level.scr_animtree["s2_walking_node"] = #animtree;
	level.scr_model["s2_walking_node"] = "empty_model";
	level.scr_anim["s2_walking_node"]["s2walk"] = %cap_s2_walk_player_walking_node;
	level.scr_animtree["trolley_guard_door_1"] = #animtree;
	level.scr_model["trolley_guard_door_1"] = "cpt_hinge_door_rght_01";
	level.scr_anim["trolley_guard_door_1"]["s2walk_intro_trolley"] = %cap_s2_zip_into_trolley_door_01;
	level.scr_animtree["trolley_guard_door_2"] = #animtree;
	level.scr_model["trolley_guard_door_2"] = "cpt_hinge_door_rght_01";
	level.scr_anim["trolley_guard_door_2"]["s2walk_intro_trolley"] = %cap_s2_zip_into_trolley_door_02;
	level.scr_animtree["trolley_gate"] = #animtree;
	level.scr_model["trolley_gate"] = "cpt_sliding_elevator_door_01";
	level.scr_anim["trolley_gate"]["s2walk_intro_trolley"] = %cap_s2_zip_into_trolley_gate_01;
	level.scr_animtree["trolley_zip_1"] = #animtree;
	level.scr_model["trolley_zip_1"] = "weapon_carabiner_thin_rope2";
	level.scr_anim["trolley_zip_1"]["s2walk_intro_trolley"] = %cap_s2_trolley_zipline_01;
	level.scr_animtree["trolley_zip_2"] = #animtree;
	level.scr_model["trolley_zip_2"] = "weapon_carabiner_thin_rope2";
	level.scr_anim["trolley_zip_2"]["s2walk_intro_trolley"] = %cap_s2_trolley_zipline_02;
	level.scr_animtree["trolley_zip_3"] = #animtree;
	level.scr_model["trolley_zip_3"] = "weapon_carabiner_thin_rope2";
	level.scr_anim["trolley_zip_3"]["s2walk_intro_trolley"] = %cap_s2_trolley_zipline_03;
	level.scr_animtree["trolley_zip_4"] = #animtree;
	level.scr_model["trolley_zip_4"] = "weapon_carabiner_thin_rope2";
	level.scr_anim["trolley_zip_4"]["s2walk_intro_trolley"] = %cap_s2_trolley_zipline_04;
	level.scr_animtree["trolley_syringe"] = #animtree;
	level.scr_model["trolley_syringe"] = "weapon_syringe";
	level.scr_anim["trolley_syringe"]["s2walk_intro_trolley"] = %cap_s2_trolley_syringe_01;
	level.scr_animtree["stockade_01"] = #animtree;
	level.scr_model["stockade_01"] = "cpt_stockade_post_01";
	level.scr_anim["stockade_01"]["s3_interrogation"] = %cap_s3_interrogation_stockade_01;
	level.scr_animtree["stockade_02"] = #animtree;
	level.scr_model["stockade_02"] = "cpt_stockade_post_01";
	level.scr_anim["stockade_02"]["s3_interrogation"] = %cap_s3_interrogation_stockade_02;
	level.scr_animtree["torque_wrench"] = #animtree;
	level.scr_model["torque_wrench"] = "cpt_medical_torque_wrench_01";
	level.scr_anim["torque_wrench"]["s3_interrogation"] = %cap_s3_interrogation_wrench_01;
	level.scr_animtree["breakout_window_1"] = #animtree;
	level.scr_model["breakout_window_1"] = "cpt_interrogation_window_shatter_anim_01";
	level.scr_anim["breakout_window_1"]["s3_breakout_break"] = %cap_interrogation_window_01;
	level.scr_animtree["breakout_window_2"] = #animtree;
	level.scr_model["breakout_window_2"] = "cpt_interrogation_window_shatter_anim_02";
	level.scr_anim["breakout_window_2"]["s3_breakout_break"] = %cap_interrogation_window_02;
	level.scr_anim["stockade_01"]["s3_breakout"] = %cap_s3_rescue_stockade_01;
	level.scr_anim["stockade_02"]["s3_breakout"] = %cap_s3_rescue_stockade_02;
	level.scr_animtree["escape_bodybag"] = #animtree;
	level.scr_model["escape_bodybag"] = "cap_hanging_bodybag";
	level.scr_anim["escape_bodybag"]["s3escape_doctor_scene"] = %cap_s3_escape_doc_push_body;
	level.scr_animtree["escape_clipboard"] = #animtree;
	level.scr_model["escape_clipboard"] = "det_patient_chart_01";
	level.scr_anim["escape_clipboard"]["s3escape_doctor_scene"] = %cap_s3_escape_doc_push_clip;
	level.scr_animtree["takedown_chair"] = #animtree;
	level.scr_model["takedown_chair"] = "cap_lab_chair";
	level.scr_anim["takedown_chair"]["s3escape_takedown"] = %cap_s3_escape_takedown_chair_01;
	level.scr_anim["takedown_chair"]["s3escape_hallway_end_loop"][0] = %cap_s3_escape_takedown_chair_01_doorloop;
	level.scr_animtree["takedown_door"] = #animtree;
	level.scr_model["takedown_door"] = "cpt_hinge_door_rght_01";
	level.scr_anim["takedown_door"]["s3escape_takedown"] = %cap_s3_escape_takedown_door_01;
	level.scr_animtree["takedown_monitor"] = #animtree;
	level.scr_model["takedown_monitor"] = "fus_control_monitor_01";
	level.scr_anim["takedown_monitor"]["s3escape_takedown"] = %cap_s3_escape_takedown_monitor_01;
	level.scr_animtree["takedown_gun"] = #animtree;
	level.scr_model["takedown_gun"] = "vm_titan45_nocamo";
	level.scr_anim["takedown_gun"]["s3escape_takedown"] = %cap_s3_escape_takedown_gun_01;
	level.scr_animtree["takedown_gun_gideon"] = #animtree;
	level.scr_model["takedown_gun_gideon"] = "npc_hmr9_nocamo";
	level.scr_anim["takedown_gun_gideon"]["s3escape_takedown"] = %cap_s3_escape_takedown_hmr9_01;
	level.scr_anim["takedown_gun_gideon"]["s3escape_takedown_gun_help"] = %cap_s3_escape_takedown_hmr9_01_help;
	level.scr_animtree["controlroom_entrance_door"] = #animtree;
	level.scr_model["controlroom_entrance_door"] = "cpt_security_door_01";
	level.scr_anim["controlroom_entrance_door"]["s3escape_takedown"] = %cap_s3_escape_takedown_door_02;
	level.scr_animtree["controlroom_guard_door"] = #animtree;
	level.scr_anim["controlroom_guard_door"]["s3escape_controlroom_attack"] = %cap_s3_escape_controlroom_door_02;
	level.scr_animtree["controlroom_exit_door"] = #animtree;
	level.scr_anim["controlroom_exit_door"]["s3escape_controlroom_exit"] = %cap_s3_escape_controlroom_door_01;
	level.scr_animtree["controlroom_console"] = #animtree;
	level.scr_anim["controlroom_console"]["s3escape_controlroom_console"] = %cap_s3_escape_controlroom_console_01;
	level.scr_animtree["tc_stairs_door_1"] = #animtree;
	level.scr_model["tc_stairs_door_1"] = "cpt_hinge_door_lft_01";
	level.scr_anim["tc_stairs_door_1"]["tc_stairs"] = %cap_s3_stairclimb_door_01;
	level.scr_animtree["tc_stairs_door_2"] = #animtree;
	level.scr_model["tc_stairs_door_2"] = "cpt_hinge_door_rght_01";
	level.scr_anim["tc_stairs_door_2"]["tc_stairs"] = %cap_s3_stairclimb_door_02;
	level.scr_animtree["observation_chair_1"] = #animtree;
	level.scr_model["observation_chair_1"] = "cap_lab_chair";
	level.scr_anim["observation_chair_1"]["tc_melee"] = %cap_s3_observation_tech_02_intro_chair;
	level.scr_anim["observation_chair_1"]["tc_scientist_1_loop"][0] = %cap_s3_observation_tech_02_loop_chair;
	level.scr_anim["observation_chair_1"]["tc_scientist_1_death"] = %cap_s3_observation_tech_02_death_chair;
	level.scr_animtree["observation_chair_2"] = #animtree;
	level.scr_model["observation_chair_2"] = "cap_lab_chair";
	level.scr_anim["observation_chair_2"]["tc_melee"] = %cap_s3_observation_tech_03_intro_chair;
	level.scr_anim["observation_chair_2"]["tc_scientist_2_loop"][0] = %cap_s3_observation_tech_03_loop_chair;
	level.scr_anim["observation_chair_2"]["tc_scientist_2_death"] = %cap_s3_observation_tech_03_death_chair;
	level.scr_animtree["tc_bodybag_1"] = #animtree;
	level.scr_model["tc_bodybag_1"] = "cap_hanging_bodybag";
	level.scr_anim["tc_bodybag_1"]["tc_enter_test"] = %cap_s3_test_chamber_app_body1_03;
	level.scr_animtree["tc_bodybag_2"] = #animtree;
	level.scr_model["tc_bodybag_2"] = "cap_hanging_bodybag";
	level.scr_anim["tc_bodybag_2"]["tc_enter_test"] = %cap_s3_test_chamber_app_body2_03;
	level.scr_animtree["tcah_door_r"] = #animtree;
	level.scr_animtree["tcah_door_l"] = #animtree;
	level.scr_model["tcah_door_r"] = "cpt_hinge_door_rght_01";
	level.scr_model["tcah_door_l"] = "cpt_hinge_door_lft_01";
	level.scr_anim["tcah_door_r"]["tc_enter_test_exit_door"] = %cap_s3_test_chamber_app_door_rt_04;
	level.scr_anim["tcah_door_l"]["tc_enter_test_exit_door"] = %cap_s3_test_chamber_app_door_lft_04;
	level.scr_animtree["autopsy_door"] = #animtree;
	level.scr_anim["autopsy_door"]["autopsy_door"] = %cap_s3_autopsy_door_lt;
	level.scr_animtree["autopsy_door_rt"] = #animtree;
	level.scr_anim["autopsy_door_rt"]["autopsy_door"] = %cap_s3_autopsy_door_rt;
	level.scr_animtree["autopsy_gun"] = #animtree;
	level.scr_model["autopsy_gun"] = "npc_titan45_base";
	level.scr_anim["autopsy_gun"]["autopsy_doctor_grabgun"] = %cap_s3_autopsydoc_grabgun_gun;
	level.scr_anim["autopsy_gun"]["autopsy_doctor_grabgun_loop"][0] = %cap_s3_autopsydoc_loop2_gun;
	level.scr_anim["autopsy_gun"]["autopsy_doctor_door_open"] = %cap_s3_autopsydoc_opendoor_gun;
	level.scr_animtree["autopsy_doc_doors"] = #animtree;
	level.scr_model["autopsy_doc_doors"] = "cpt_autopsy_sliding_doors";
	level.scr_anim["autopsy_doc_doors"]["autopsy_doctor_door_open"] = %cap_s3_autopsydoc_opendoor_slidingdoors;
	level.scr_animtree["autopsy_hatch"] = #animtree;
	level.scr_model["autopsy_hatch"] = "incinerator_hatch_animated";
	level.scr_anim["autopsy_hatch"]["autopsy_doctor_door_open"] = %cap_s3_autopsydoc_opendoor_hatch;
	level.scr_anim["autopsy_hatch"]["autopsy_doctor_hatch_open_jump"] = %cap_s3_autopsydoc_hatch_end;
	level.scr_anim["autopsy_hatch"]["autopsy_doctor_player_jump"] = %cap_s3_autopsydoc_hatch;
	level.scr_animtree["cart_1"] = #animtree;
	level.scr_model["cart_1"] = "ash_cart";
	level.scr_animtree["cart_2"] = #animtree;
	level.scr_model["cart_2"] = "ash_cart";
	level.scr_animtree["grate"] = #animtree;
	level.scr_model["grate"] = "cap_incinerator_gate";
	level.scr_anim["cart_1"]["incinerator_push"] = %cap_incinerator_push_cart_01;
	level.scr_anim["cart_2"]["incinerator_push"] = %cap_incinerator_push_cart_02;
	level.scr_anim["grate"]["incinerator_push"] = %cap_incinerator_push_gate;
	level.scr_animtree["incinerator_pipe"] = #animtree;
	level.scr_model["incinerator_pipe"] = "cap_incinerator_pipe";
	level.scr_anim["incinerator_pipe"]["incinerator_crawl"] = %cap_incinerator_crawl_pipe;
	level.scr_animtree["runtoheli_door"] = #animtree;
	level.scr_anim["runtoheli_door"]["runtoheli_door_kick"] = %cap_s3_manticore_window_door_03;
	level.scr_animtree["heli_mech"] = #animtree;
	level.scr_model["heli_mech"] = "playermech_animated_model_top";
	level.scr_anim["heli_mech"]["warbird_scene"] = %cap_vtol_battle_crash_mech;
	maps\_anim::addnotetrack_customfunction("heli_mech","link",::maps\captured_facility::nt_warbird_mech_link,"warbird_scene");
	level.scr_animtree["mech_opfor"] = #animtree;
	level.scr_anim["mech_opfor"]["anim_mech_wakeup"] = %cap_s1_escape_mech_crash_wakeup_opfor;
	level.scr_anim["mech_opfor"]["mech_enter"] = %cap_playermech_getinto_mech_opfor;
	level.scr_animtree["debris"] = #animtree;
	level.scr_model["debris"] = "roadpanels_smartdebris_b";
	level.scr_anim["debris"]["anim_mech_wakeup"] = %cap_s1_escape_mech_crash_wakeup_debris;
	level.scr_animtree["rocks"] = #animtree;
	level.scr_model["rocks"] = "cpt_s1_crash_debris";
	level.scr_anim["rocks"]["anim_mech_wakeup"] = %cap_s1_escape_mech_crash_wakeup_sml_debris;
	level.scr_animtree["warbird_rotor"] = #animtree;
	level.scr_anim["warbird_rotor"]["anim_mech_wakeup"] = %cap_s1_escape_mech_crash_wakeup_rotor;
	level.scr_animtree["mech_handle"] = #animtree;
	level.scr_model["mech_handle"] = "cpt_mechsuit_handle_01";
	level.scr_anim["mech_handle"]["anim_mech_wakeup"] = %cap_s1_escape_mech_crash_wakeup_handle;
	level.scr_anim["mech_handle"]["mech_enter"] = %cap_playermech_getinto_mech_handle;
}

//Function Number: 5
vehicle_anims()
{
	level.scr_animtree["warbird"] = #animtree;
	level.scr_anim["warbird"]["warbird_scene"] = %cap_vtol_battle_crash_vtol;
	maps\_anim::addnotetrack_customfunction("warbird","exp",::maps\captured_fx::fx_heli_aa_explosion,"warbird_scene");
	level.scr_animtree["exit_truck"] = #animtree;
	if(!level.currentgen)
	{
		level.scr_model["exit_truck"] = "vehicle_mil_cargo_truck_captured_ai";
	}
	else
	{
		level.scr_model["exit_truck"] = "vehicle_mil_cargo_truck_captured_cghi_ai";
	}

	level.scr_anim["exit_truck"]["anim_exit"] = %cap_s1_escape_mech_gate_lift_exit_truck;
	level.scr_animtree["exit_helo_0"] = #animtree;
	level.scr_animtree["exit_helo_1"] = #animtree;
	level.scr_animtree["exit_helo_2"] = #animtree;
	level.scr_animtree["exit_helo_3"] = #animtree;
	level.scr_animtree["exit_helo_4"] = #animtree;
	level.scr_animtree["exit_helo_5"] = #animtree;
	level.scr_animtree["exit_helo_6"] = #animtree;
	level.scr_model["exit_helo_0"] = "vehicle_mil_v32_razorback";
	level.scr_model["exit_helo_1"] = "vehicle_mil_v32_razorback";
	level.scr_model["exit_helo_2"] = "vehicle_mil_v32_razorback";
	level.scr_model["exit_helo_3"] = "vehicle_mil_v32_razorback";
	level.scr_model["exit_helo_4"] = "vehicle_mil_v32_razorback";
	level.scr_model["exit_helo_5"] = "vehicle_mil_v32_razorback";
	level.scr_model["exit_helo_6"] = "vehicle_mil_v32_razorback";
	level.scr_anim["exit_helo_0"]["end_escape"] = %cap_s1_escape_mech_door_lift_exit_end_razorback_01;
	level.scr_anim["exit_helo_1"]["end_escape"] = %cap_s1_escape_mech_door_lift_exit_end_razorback_02;
	level.scr_anim["exit_helo_2"]["end_escape"] = %cap_s1_escape_mech_door_lift_exit_end_razorback_03;
	level.scr_anim["exit_helo_3"]["end_escape"] = %cap_s1_escape_mech_door_lift_exit_end_razorback_04;
	level.scr_anim["exit_helo_4"]["end_escape"] = %cap_s1_escape_mech_door_lift_exit_end_razorback_05;
	level.scr_anim["exit_helo_5"]["end_escape"] = %cap_s1_escape_mech_door_lift_exit_end_razorback_06;
	level.scr_anim["exit_helo_6"]["end_escape"] = %cap_s1_escape_mech_door_lift_exit_end_razorback_07;
	level.scr_anim["exit_truck"]["end_escape"] = %cap_s1_escape_mech_door_lift_exit_end_truck;
}

//Function Number: 6
captured_ambient_animation_setup(param_00)
{
	var_01 = common_scripts\utility::getstructarray(param_00,"script_noteworthy");
	if(isdefined(var_01))
	{
		foreach(var_03 in var_01)
		{
			if(isdefined(var_03.script_stance))
			{
				var_04 = getentarray(var_03.script_stance,"targetname");
				if(!isdefined(var_04[0]))
				{
					iprintln("Mover used in captured_anim::captured_anbient_animation_setup() is compiled out?");
					return;
				}

				var_05 = spawn("script_origin",var_03.origin);
				var_05 linkto(var_04[0]);
				var_05 thread captured_ambient_animation_function(param_00,var_03);
				continue;
			}

			var_03 thread captured_ambient_animation_function(param_00);
		}
	}
}

//Function Number: 7
captured_ambient_animation_function(param_00,param_01)
{
	var_02 = "non_prisoner";
	var_03 = undefined;
	var_04 = 3;
	var_05 = 6;
	var_06 = 9;
	if(param_00 == "exterior_ambient_prisoner")
	{
		if(level.prisoner_randomizer.size == 0)
		{
			if(level.currentgen)
			{
				level.prisoner_randomizer = [1,2,3,4,5,6];
			}
			else
			{
				level.prisoner_randomizer = [1,2,3,4,5,6,7,8,9];
			}
		}

		if(level.currentgen)
		{
			var_04 = 2;
			var_05 = 4;
			var_06 = 6;
		}

		var_07 = common_scripts\utility::random(level.prisoner_randomizer);
		if(var_07 <= var_04)
		{
			var_02 = "cau";
			var_03 = var_04 - var_07;
		}
		else if(var_07 <= var_05)
		{
			var_02 = "dark";
			var_03 = var_05 - var_07;
		}
		else if(var_07 > var_05)
		{
			var_02 = "mde";
			var_03 = var_06 - var_07;
		}

		level.prisoner_randomizer = common_scripts\utility::array_remove(level.prisoner_randomizer,var_07);
	}

	var_08 = [];
	var_09 = [];
	if(level.currentgen)
	{
		precachemodel("head_m_gen_afr_craig_cpt");
		precachemodel("head_m_act_cau_manasi_base_cpt");
		precachemodel("head_m_gen_afr_davis_cpt");
		precachemodel("head_m_gen_mde_hanks_cpt");
	}

	switch(var_02)
	{
		case "cau":
			var_08 = ["civ_prisoner_atlas_body","civ_prisoner_atlas_body_b"];
			if(level.currentgen)
			{
				var_09 = ["head_m_act_cau_kanik_base","head_m_act_cau_manasi_base_cpt"];
			}
			else
			{
				var_09 = ["head_m_act_cau_kanik_base","head_m_act_cau_manasi_base","head_m_gen_cau_anderson"];
			}
			break;

		case "dark":
			var_08 = ["civ_prisoner_atlas_body_afr_dark","civ_prisoner_atlas_body_b_afr_dark"];
			if(level.currentgen)
			{
				var_09 = ["head_m_gen_afr_davis_cpt","head_m_gen_afr_craig_cpt"];
			}
			else
			{
				var_09 = ["head_m_gen_afr_davis","head_m_gen_afr_craig","head_m_act_afr_adams_base"];
			}
			break;

		case "mde":
			var_08 = ["civ_prisoner_atlas_body_b_mde","civ_prisoner_atlas_body_mde"];
			if(level.currentgen)
			{
				var_09 = ["head_m_gen_mde_hanks_cpt","head_m_gen_mde_urena"];
			}
			else
			{
				var_09 = ["head_m_gen_mde_hanks","head_m_gen_mde_urena","head_m_gen_mde_smith"];
			}
			break;

		case "non_prisoner":
			break;
	}

	var_0A = ["atlas_body"];
	var_0B = ["atlas_head_b","atlas_head_c","atlas_head_d","atlas_head_e"];
	var_0C = "npc_exo_armor_base";
	var_0D = "npc_exo_armor_atlas_head";
	var_0E = undefined;
	var_0F = undefined;
	var_10 = undefined;
	var_11 = undefined;
	var_12 = undefined;
	var_13 = undefined;
	if(isdefined(param_01))
	{
		var_12 = param_01;
		var_13 = self;
	}
	else
	{
		var_12 = self;
	}

	switch(param_00)
	{
		case "exterior_ambient_prisoner":
			var_0E = common_scripts\utility::random(var_08);
			var_0F = var_09[var_03];
			var_10 = "exterior_ambient_prisoner";
			break;

		case "exterior_ambient_guard":
			var_0E = common_scripts\utility::random(var_0A);
			var_0F = common_scripts\utility::random(var_0B);
			var_10 = "exterior_ambient_guard";
			var_11 = "npc_hmr9_nocamo";
			break;

		case "exterior_ambient_mech":
			var_0E = var_0C;
			var_0F = var_0D;
			var_10 = "exterior_ambient_mech";
			break;
	}

	var_14 = getent(var_12.targetname,"target");
	var_14 waittill("trigger");
	var_15 = spawn("script_model",var_12.origin);
	var_15 setmodel(var_0E);
	var_15 attach(var_0F);
	var_15.angles = var_12.angles;
	var_15.animname = var_10;
	var_15 maps\_utility::assign_animtree();
	var_16 = 0;
	var_17 = 0;
	if(isdefined(var_12.script_side))
	{
		var_18 = getanimlength(level.scr_anim[var_10][var_12.animation][0]);
	}
	else
	{
		var_18 = getanimlength(var_16 maps\_utility::getanim(var_13.animation));
	}

	if(isdefined(var_12.script_index))
	{
		var_17 = 0.01 * var_12.script_index;
	}

	if(isdefined(var_12.script_count))
	{
		var_16 = var_12.script_count;
	}

	if(isdefined(var_12.script_parameters))
	{
		var_18 = var_12.script_parameters;
	}

	if(isdefined(var_11))
	{
		if(isdefined(var_12.script_nodestate))
		{
			var_15 attach(var_11,"tag_stowed_back");
		}
		else
		{
			var_15 attach(var_11,"tag_weapon_right");
		}
	}

	if(isdefined(var_12.script_group))
	{
		var_15 attach("s1_captured_handcuffs","tag_weapon_left");
	}

	if(!isdefined(var_12.script_side))
	{
		if(isdefined(var_12.script_stance))
		{
			var_13 maps\_anim::anim_first_frame_solo(var_15,var_12.animation);
		}
		else
		{
			var_12 maps\_anim::anim_first_frame_solo(var_15,var_12.animation);
		}
	}

	wait(var_16);
	soundscripts\_snd::snd_message("aud_ambient_animations",var_12.animation);
	if(isdefined(var_12.script_side))
	{
		var_15 common_scripts\utility::delaycall(0.05,::setanimtime,level.scr_anim[var_10][var_12.animation][0],var_17);
	}
	else
	{
		var_15 common_scripts\utility::delaycall(0.05,::setanimtime,level.scr_anim[var_10][var_12.animation],var_17);
	}

	var_19 = undefined;
	if(isdefined(var_12.script_side))
	{
		if(isdefined(var_12.script_stance))
		{
			var_15 linkto(var_13);
			var_13 thread maps\_anim::anim_loop_solo(var_15,var_12.animation,var_12.script_side);
			level waittill(var_12.script_side);
			var_13 notify(var_12.script_side);
		}
		else
		{
			var_12 thread maps\_anim::anim_loop_solo(var_15,var_12.animation,var_12.script_side);
			level waittill(var_12.script_side);
			var_12 notify(var_12.script_side);
		}
	}
	else
	{
		if(isdefined(var_12.script_stance))
		{
			var_15 linkto(var_13);
			var_13 thread maps\_anim::anim_single_solo(var_15,var_12.animation);
			var_1A = getanimlength(var_15 maps\_utility::getanim(var_12.animation));
			if(isdefined(var_12.script_animation))
			{
				var_19 = var_12.script_animation;
			}
			else
			{
				var_19 = "default";
			}

			level maps\_utility::wait_for_notify_or_timeout(var_19,var_1A);
		}
		else
		{
			var_12 thread maps\_anim::anim_single_solo(var_15,var_12.animation);
		}

		var_1A = getanimlength(var_15 maps\_utility::getanim(var_12.animation));
		if(isdefined(var_12.script_animation))
		{
			var_19 = var_12.script_animation;
		}
		else
		{
			var_19 = "default";
		}

		level maps\_utility::wait_for_notify_or_timeout(var_19,var_1A);
	}

	if(isdefined(var_12.script_stance))
	{
		var_13 delete();
	}

	var_15 delete();
}

//Function Number: 8
anim_single_to_loop(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self;
	if(isdefined(param_04))
	{
		param_04 endon(param_03);
	}
	else
	{
		var_05 endon(param_03);
	}

	if(isarray(param_00))
	{
		foreach(var_07 in param_00)
		{
			if(isai(var_07))
			{
				if(isalive(var_07))
				{
					var_05 thread anim_single_to_loop_solo(var_07,param_01,param_02,param_03,param_04);
				}

				continue;
			}

			var_05 thread anim_single_to_loop_solo(var_07,param_01,param_02,param_03,param_04);
		}

		return;
	}

	var_07 = param_01;
	if(isai(var_07))
	{
		if(isalive(var_07))
		{
			var_05 thread anim_single_to_loop_solo(var_07,param_01,param_02,param_03,param_04);
			return;
		}

		return;
	}

	var_05 thread anim_single_to_loop_solo(var_07,param_01,param_02,param_03,param_04);
}

//Function Number: 9
anim_single_to_loop_solo(param_00,param_01,param_02,param_03,param_04)
{
	if(isai(param_00))
	{
		param_00 endon("death");
	}

	var_05 = self;
	if(isdefined(param_04))
	{
		param_04 endon(param_03);
	}
	else if(isdefined(param_03))
	{
		var_05 endon(param_03);
	}

	if(isdefined(param_00))
	{
		if(!isremovedentity(param_00))
		{
			var_05 maps\_anim::anim_single_solo(param_00,param_01);
			if(isdefined(param_04))
			{
				var_05 = param_04;
			}

			var_05 thread maps\_anim::anim_loop_solo(param_00,param_02,param_03);
		}
	}
}

//Function Number: 10
anim_single_to_delete(param_00,param_01)
{
	var_02 = self;
	foreach(var_04 in param_00)
	{
		var_02 thread anim_single_to_delete_solo(var_04,param_01);
	}
}

//Function Number: 11
anim_single_to_delete_solo(param_00,param_01,param_02)
{
	var_03 = self;
	var_03 maps\_anim::anim_single_solo(param_00,param_01);
	param_00 delete();
}