/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lagos_anim.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 272 ms
 * Timestamp: 4/22/2024 2:33:15 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.transient_zone = "";
	if(level.currentgen)
	{
		if(istransientloaded("lagos_intro_tr"))
		{
			level.transient_zone = "intro";
		}
		else if(istransientloaded("lagos_middle_tr"))
		{
			level.transient_zone = "middle";
		}
		else if(istransientloaded("lagos_outro_tr"))
		{
			level.transient_zone = "outro";
		}
	}

	if(level.nextgen)
	{
		anim.forced_s1_motionset = 1;
	}

	thread player_anims();
	thread actor_anims();
	thread vehicle_anims();
	thread model_anims();
}

//Function Number: 2
transient_notetracks_outro()
{
	if(level.transient_zone != "outro")
	{
		level waittill("tff_post_alley_to_outro");
	}

	notetracks_traffic_start_vm();
	notetracks_truck_middle_takedown_pt4();
	notetracks_bus_jump();
	notetracks_hostage_truck_takedown();
	notetracks_playerrig_truck_middle_takedown();
	notetracks_truck_middle_takedown_kva_truck();
}

//Function Number: 3
player_anims()
{
	level.scr_animtree["player_rig"] = #animtree;
	level.scr_model["player_rig"] = "viewbody_atlas_pmc_smp_custom";
	level.scr_animtree["player_arms"] = #animtree;
	level.scr_model["player_arms"] = "worldhands_atlas_pmc_smp_custom";
	level.scr_animtree["player_arms_alt"] = #animtree;
	level.scr_model["player_arms_alt"] = "worldhands_atlas_pmc_smp";
	level.scr_anim["player_arms"]["drone_opening_idle"][0] = %lag_gov_hostage_room_flythrough_vm_start_idle;
	level.scr_anim["player_arms"]["drone_opening_player_control"] = %lag_gov_hostage_room_flythrough_vm_stop_for_orbit;
	level.scr_goaltime["player_arms"]["drone_opening_player_control"] = 1;
	level.scr_anim["player_rig"]["squad_opening"] = %lag_intro_briefing_vm;
	level.scr_anim["player_rig"]["exo_door"] = %lag_exo_door_takedown_vm;
	maps\_anim::addnotetrack_customfunction("player_arms","fov_start",::maps\lagos_code::drone_intro_fov_shift_on,"drone_opening_player_control");
	maps\_anim::addnotetrack_customfunction("player_rig","fov_start",::maps\lagos_code::squad_intro_fov_shift_on,"squad_opening");
	maps\_anim::addnotetrack_customfunction("player_rig","fov_end",::maps\lagos_code::squad_intro_fov_shift_off,"squad_opening");
	maps\_anim::addnotetrack_customfunction("player_rig","vm_gun_up",::exo_door_enable_weapons,"exo_door");
	level.scr_anim["player_rig"]["exo_climb_pullup_start"] = %lag_gov_wallpullup_start_vm;
	level.scr_anim["player_rig"]["exo_climb_pullup_lt1"] = %lag_gov_wallpullup_lt1_vm;
	level.scr_anim["player_rig"]["exo_climb_pullup_rt1"] = %lag_gov_wallpullup_rt1_vm;
	level.scr_anim["player_rig"]["exo_climb_pullup_lt2"] = %lag_gov_wallpullup_lt2_vm;
	level.scr_anim["player_rig"]["exo_climb_pullup_rt2"] = %lag_gov_wallpullup_rt2_vm;
	level.scr_anim["player_rig"]["exo_climb_pullup_lt3"] = %lag_gov_wallpullup_lt3_vm;
	level.scr_anim["player_rig"]["exo_climb_pullup_rt3"] = %lag_gov_wallpullup_rt3_vm;
	level.scr_anim["player_rig"]["exo_climb_pullup_exit"] = %lag_gov_wallpullup_exit_vm;
	maps\_anim::addnotetrack_customfunction("player_climb_rig","right_hand_plant",::maps\lagos_fx::player_hand_plant_rt_wallclimb,"mount_override");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"mount_override");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"mount_override");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_gloves_off",::maps\_exo_climb::fx_exo_climb_gloves_off,"mount_override");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_off",::maps\_exo_climb::fx_exo_climb_gloves_off,"exo_climb_pullup_exit");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_right_index",::maps\lagos_vo::notetrack_vo_exo_climb,"mount_override");
	maps\_anim::addnotetrack_customfunction("player_rig","right_hand_plant",::maps\lagos_fx::player_hand_plant_rt_wallclimb,"exo_climb_pullup_rt1");
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"exo_climb_pullup_lt2");
	maps\_anim::addnotetrack_customfunction("player_rig","right_hand_plant",::maps\lagos_fx::player_hand_plant_rt_wallclimb,"exo_climb_pullup_rt2");
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"exo_climb_pullup_lt3");
	maps\_anim::addnotetrack_customfunction("player_rig","right_hand_plant",::maps\lagos_fx::player_hand_plant_rt_wallclimb,"exo_climb_pullup_rt3");
	maps\_anim::addnotetrack_customfunction("player_rig","burke_anim_start",::maps\lagos_code::wall_pullup_burke_anim_start,"exo_climb_pullup_exit");
	maps\_anim::addnotetrack_customfunction("player_rig","pigeon_flyaway",::maps\lagos_fx::bird_flyaway,"exo_climb_pullup_exit");
	level.scr_anim["player_rig"]["roof_mute_breach_plant"] = %lag_roof_breach_vm;
	level.scr_anim["player_rig"]["roof_mute_breach_jumpdown"] = %lag_roof_breach_jumpdown_vm;
	maps\_anim::addnotetrack_customfunction("player_rig","slowmotion_start",::maps\lagos_code::gov_roof_breach_start_slowmo,"roof_mute_breach_jumpdown");
	maps\_anim::addnotetrack_customfunction("player_rig","lag_magic_bullet",::maps\lagos_code::gov_roof_breach_multi_kill,"roof_mute_breach_jumpdown");
	level.scr_anim["player_rig"]["flank_wall_climb"] = %lag_flank_wallpullup_exit_vm;
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_off",::maps\_exo_climb::fx_exo_climb_gloves_off,"flank_wall_climb");
	level.scr_anim["player_rig"]["traffic_start_VM"] = %lag_pullbackfence_jump_vm_pt1;
	level.scr_anim["player_rig"]["traffic_start_VM_fail"] = %lag_pullbackfence_jump_vm_fail;
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_l_glove_disengage",::maps\lagos_fx::player_mag_glove_lglove_disengage,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"traffic_start_VM_fail");
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"traffic_start_VM_fail");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_l_glove_disengage",::maps\lagos_fx::player_mag_glove_lglove_disengage,"traffic_start_VM_fail");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"traffic_start_VM_fail");
	notetracks_traffic_start_vm();
	level.scr_anim["player_rig"]["hostage_truck_takedown_fail_pt2"] = %lag_truck_takedown_fail_pt2_vm;
	level.scr_anim["player_rig"]["hostage_truck_takedown_pt0"] = %lag_truck_takedown_pt0_vm;
	level.scr_anim["player_rig"]["hostage_truck_takedown_pt1"] = %lag_truck_takedown_pt1_vm;
	level.scr_anim["player_rig"]["hostage_truck_takedown_pt2"] = %lag_truck_takedown_pt2_vm;
	level.scr_anim["player_rig"]["hostage_truck_takedown_pt3"] = %lag_truck_takedown_pt3_vm;
	level.scr_anim["player_rig"]["hostage_truck_takedown_pt4_into"] = %lag_truck_takedown_pt4_into_vm;
	level.scr_anim["player_rig"]["hostage_truck_takedown_pt4"] = %lag_truck_takedown_pt4_vm;
	level.scr_anim["player_rig"]["hostage_truck_takedown_pt5"] = %lag_truck_takedown_pt5_vm;
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"hostage_truck_takedown_pt0");
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"hostage_truck_takedown_pt0");
	maps\_anim::addnotetrack_customfunction("player_rig","right_hand_plant",::maps\lagos_fx::player_hand_plant_rt_wallclimb,"hostage_truck_takedown_pt0");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_l_glove_disengage",::maps\lagos_fx::player_mag_glove_lglove_disengage,"hostage_truck_takedown_pt0");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_r_glove_disengage",::maps\lagos_fx::player_mag_glove_rglove_disengage,"hostage_truck_takedown_pt0");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"hostage_truck_takedown_pt0");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"hostage_truck_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"hostage_truck_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"hostage_truck_takedown_pt2");
	notetracks_hostage_truck_takedown();
	level.scr_anim["player_rig"]["truck_middle_takedown_pt1"] = %lag_truck_middle_takedown_pt1_vm;
	level.scr_anim["player_rig"]["truck_middle_takedown_pt2"] = %lag_truck_middle_takedown_pt2_vm;
	level.scr_anim["player_rig"]["truck_middle_takedown_pt3"] = %lag_truck_middle_takedown_pt3_vm;
	level.scr_anim["player_rig"]["truck_middle_takedown_pt4"] = %lag_truck_middle_takedown_pt4_vm;
	level.scr_anim["player_rig"]["truck_middle_takedown_pt5"] = %lag_truck_middle_takedown_pt5_vm;
	level.scr_anim["player_rig"]["truck_middle_takedown_fail_pt1"] = %lag_truck_middle_takedown_fail_pt1_vm;
	level.scr_anim["player_rig"]["truck_middle_takedown_fail_pt2"] = %lag_truck_middle_takedown_fail_pt2_vm;
	level.scr_anim["player_rig"]["truck_middle_takedown_fail_pt3"] = %lag_truck_middle_takedown_fail_pt3_vm;
	level.scr_anim["player_rig"]["truck_middle_takedown_fail_pt4"] = %lag_truck_middle_takedown_fail_pt4_vm;
	level.scr_anim["player_rig"]["truck_middle_takedown_fail_pt5"] = %lag_truck_middle_takedown_fail_pt5_vm;
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_code::notetrack_middle_takedown_grab_side,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","qte_prompt",::maps\lagos_code::notetrack_middle_takedown_truck_swipe,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","qte_prompt",::maps\lagos_code::notetrack_middle_takedown_jump_to_truck,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","qte_prompt",::maps\lagos_code::notetrack_middle_takedown_land_on_truck,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","qte_prompt",::maps\lagos_code::notetrack_middle_takedown_punch_window,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","qte_prompt",::maps\lagos_code::notetrack_middle_takedown_jump_to_bus,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","qte_prompt",::maps\lagos_code::notetrack_middle_takedown_land_on_bus,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","right_hand_plant",::maps\lagos_fx::player_hand_plant_rt_wallclimb,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_l_glove_disengage",::maps\lagos_fx::player_mag_glove_lglove_disengage,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_r_glove_disengage",::maps\lagos_fx::player_mag_glove_rglove_disengage,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","right_hand_plant",::maps\lagos_fx::player_hand_plant_rt_wallclimb,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","right_hand_plant",::maps\lagos_fx::player_hand_plant_rt_wallclimb,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_l_glove_disengage",::maps\lagos_fx::player_mag_glove_lglove_disengage,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_r_glove_disengage",::maps\lagos_fx::player_mag_glove_rglove_disengage,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","right_hand_plant",::maps\lagos_fx::player_hand_plant_rt_wallclimb,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_l_glove_disengage",::maps\lagos_fx::player_mag_glove_lglove_disengage,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_r_glove_disengage",::maps\lagos_fx::player_mag_glove_rglove_disengage,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"truck_middle_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"truck_middle_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("player_rig","right_hand_plant",::maps\lagos_fx::player_hand_plant_rt_wallclimb,"truck_middle_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("player_rig","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"truck_middle_takedown_pt5");
	notetracks_playerrig_truck_middle_takedown();
	level.scr_anim["player_arms"]["h_breach"] = %lag_infiltration_plant_walldevice_vm;
	level.scr_anim["player_rig"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_vm;
	level.scr_anim["player_rig"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_vm;
	level.scr_anim["player_arms"]["bus_jump_vm_a"] = %lag_bus_jump_vm_a;
	level.scr_anim["player_arms"]["bus_jump_vm_b"] = %lag_bus_jump_vm_b;
	level.scr_anim["player_arms"]["bus_jump_vm_c"] = %lag_bus_jump_vm_c;
	level.scr_anim["player_arms"]["bus_jump_vm_handplant"] = %lag_bus_jump_vm_handplant;
	maps\_anim::addnotetrack_customfunction("player_arms","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"bus_jump_vm_a");
	maps\_anim::addnotetrack_customfunction("player_arms","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"bus_jump_vm_a");
	maps\_anim::addnotetrack_customfunction("player_arms","fx_l_glove_disengage",::maps\lagos_fx::player_mag_glove_lglove_disengage,"bus_jump_vm_a");
	maps\_anim::addnotetrack_customfunction("player_arms","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"bus_jump_vm_a");
	maps\_anim::addnotetrack_customfunction("player_arms","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"bus_jump_vm_b");
	maps\_anim::addnotetrack_customfunction("player_arms","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"bus_jump_vm_b");
	maps\_anim::addnotetrack_customfunction("player_arms","fx_l_glove_disengage",::maps\lagos_fx::player_mag_glove_lglove_disengage,"bus_jump_vm_b");
	maps\_anim::addnotetrack_customfunction("player_arms","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"bus_jump_vm_b");
	maps\_anim::addnotetrack_customfunction("player_arms","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"bus_jump_vm_c");
	maps\_anim::addnotetrack_customfunction("player_arms","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"bus_jump_vm_c");
	maps\_anim::addnotetrack_customfunction("player_arms","fx_l_glove_disengage",::maps\lagos_fx::player_mag_glove_lglove_disengage,"bus_jump_vm_c");
	maps\_anim::addnotetrack_customfunction("player_arms","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"bus_jump_vm_c");
	maps\_anim::addnotetrack_customfunction("player_arms","fx_gloves_on",::maps\lagos_fx::player_mag_glove_activate_wallclimb,"bus_jump_vm_handplant");
	maps\_anim::addnotetrack_customfunction("player_arms","left_hand_plant",::maps\lagos_fx::player_hand_plant_lf_wallclimb,"bus_jump_vm_handplant");
	maps\_anim::addnotetrack_customfunction("player_arms","fx_l_glove_disengage",::maps\lagos_fx::player_mag_glove_lglove_disengage,"bus_jump_vm_handplant");
	maps\_anim::addnotetrack_customfunction("player_arms","fx_gloves_off",::maps\lagos_fx::player_mag_glove_off,"bus_jump_vm_handplant");
	notetracks_bus_jump();
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_right_index",::maps\lagos_code::notetrack_gov_wall_climb_intro_right_start,"mount_override");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_left_index",::maps\lagos_code::notetrack_gov_wall_climb_intro_left_start,"mount_override");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","right_hand_plant",::maps\lagos_code::notetrack_gov_wall_climb_intro_right_plant,"mount_override");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","left_hand_plant",::maps\lagos_code::notetrack_gov_wall_climb_intro_left_plant,"mount_override");
	maps\_anim::addnotetrack_customfunction("player_rig","rumble_medium",::maps\lagos_code::notetrack_roof_breach_medium,"roof_mute_breach_plant");
	maps\_anim::addnotetrack_customfunction("player_rig","rumble_small",::maps\lagos_code::notetrack_roof_breach_small,"roof_mute_breach_plant");
	maps\_anim::addnotetrack_customfunction("player_rig","rumble_large",::maps\lagos_code::notetrack_roof_breach_large,"roof_mute_breach_plant");
	maps\_anim::addnotetrack_customfunction("player_rig","breach_player_land",::maps\lagos_code::notetrack_roof_breach_land,"roof_mute_breach_jumpdown");
	maps\_anim::addnotetrack_customfunction("player_arms","rumble_small",::maps\lagos_code::notetrack_h_breach_small,"h_breach");
	maps\_anim::addnotetrack_customfunction("player_rig","handcuff_break",::maps\lagos_code::notetrack_gov_rescue_handcuffs,"h_breach_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","left_hand_plant",::maps\lagos_code::notetrack_highway_bus_land_from_ledge,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_arms","left_hand_plant",::maps\lagos_code::notetrack_highway_jump_land,"bus_jump_vm_a");
	maps\_anim::addnotetrack_customfunction("player_arms","left_hand_plant",::maps\lagos_code::notetrack_highway_jump_land,"bus_jump_vm_b");
	maps\_anim::addnotetrack_customfunction("player_arms","left_hand_plant",::maps\lagos_code::notetrack_highway_jump_land,"bus_jump_vm_c");
}

//Function Number: 4
notetracks_traffic_start_vm()
{
	maps\_anim::addnotetrack_customfunction("player_rig","foot_land_vfx",::maps\lagos_fx::guy_jump_landing_puff,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","start_slo_mo",::maps\lagos_qte::traverse_start_jump_start_slowmo,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","start_player_prompt",::maps\lagos_qte::traverse_start_jump_start_prompt,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","end_player_prompt",::maps\lagos_qte::traverse_start_jump_end_prompt,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","end_slo_mo",::maps\lagos_qte::traverse_start_jump_end_slowmo,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","player_looking_forward",::maps\lagos_qte::traverse_start_jump_player_looking,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_start_you_should_have_eyes",::maps\lagos_vo::traverse_start_you_should_have_eyes,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_start_i_see_it",::maps\lagos_vo::traverse_start_i_see_it,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_start_damn_no_clear_shot",::maps\lagos_vo::traverse_start_damn_no_clear_shot,"traffic_start_VM");
	maps\_anim::addnotetrack_customfunction("player_rig","aud_start_fuck_it",::maps\lagos_vo::traverse_start_fuck_it,"traffic_start_VM");
}

//Function Number: 5
notetracks_bus_jump()
{
	maps\_anim::addnotetrack_notify("player_arms","final_takedown_pt1_start","bus_jump_player_landed","bus_jump_vm_a");
	maps\_anim::addnotetrack_notify("player_arms","final_takedown_pt1_start","bus_jump_player_landed","bus_jump_vm_b");
	maps\_anim::addnotetrack_notify("player_arms","final_takedown_pt1_start","bus_jump_player_landed","bus_jump_vm_c");
	maps\_anim::addnotetrack_customfunction("player_arms","vm_exo_magnet_start",::maps\lagos_jump::notetrack_vm_exo_magnet_start,"bus_jump_vm_a");
	maps\_anim::addnotetrack_customfunction("player_arms","vm_exo_magnet_start",::maps\lagos_jump::notetrack_vm_exo_magnet_start,"bus_jump_vm_b");
	maps\_anim::addnotetrack_customfunction("player_arms","vm_exo_magnet_start",::maps\lagos_jump::notetrack_vm_exo_magnet_start,"bus_jump_vm_c");
	maps\_anim::addnotetrack_customfunction("player_arms","vm_exo_magnet_start",::maps\lagos_jump::notetrack_vm_exo_magnet_start,"bus_jump_vm_handplant");
	maps\_anim::addnotetrack_customfunction("player_arms","vm_exo_magnet_end",::maps\lagos_jump::notetrack_vm_exo_magnet_end,"bus_jump_vm_a");
	maps\_anim::addnotetrack_customfunction("player_arms","vm_exo_magnet_end",::maps\lagos_jump::notetrack_vm_exo_magnet_end,"bus_jump_vm_b");
	maps\_anim::addnotetrack_customfunction("player_arms","vm_exo_magnet_end",::maps\lagos_jump::notetrack_vm_exo_magnet_end,"bus_jump_vm_c");
	maps\_anim::addnotetrack_customfunction("player_arms","vm_exo_magnet_end",::maps\lagos_jump::notetrack_vm_exo_magnet_end,"bus_jump_vm_handplant");
}

//Function Number: 6
notetracks_hostage_truck_takedown()
{
	maps\_anim::addnotetrack_customfunction("player_rig","vfx_vm_hand_sparks",::maps\lagos_fx::vm_hand_sparks,"hostage_truck_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","slomo_start",::maps\lagos_qte::hostage_truck_slomo_start_pt1,"hostage_truck_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","slomo_start",::maps\lagos_qte::hostage_truck_slomo_start_pt2,"hostage_truck_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","slomo_end",::maps\lagos_qte::hostage_truck_slomo_end_pt2,"hostage_truck_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","viewmodel_swap",::maps\lagos_qte::hostage_truck_viewmodel_swap,"hostage_truck_takedown_pt2");
}

//Function Number: 7
notetracks_playerrig_truck_middle_takedown()
{
	maps\_anim::addnotetrack_customfunction("player_rig","vehicle_unlink",::maps\lagos_qte_middle::notetrack_unlink,"truck_middle_takedown_fail_pt1");
	maps\_anim::addnotetrack_customfunction("player_rig","vehicle_unlink",::maps\lagos_qte_middle::notetrack_unlink,"truck_middle_takedown_fail_pt2");
	maps\_anim::addnotetrack_customfunction("player_rig","vehicle_unlink",::maps\lagos_qte_middle::notetrack_unlink,"truck_middle_takedown_fail_pt3");
	maps\_anim::addnotetrack_customfunction("player_rig","vehicle_unlink",::maps\lagos_qte_middle::notetrack_unlink,"truck_middle_takedown_fail_pt4");
	maps\_anim::addnotetrack_customfunction("player_rig","vehicle_unlink",::maps\lagos_qte_middle::notetrack_unlink,"truck_middle_takedown_fail_pt5");
}

//Function Number: 8
actor_anims()
{
	level.scr_anim["burke"]["flank_wall_climb"] = %lag_flank_wallpullup_exit_gideon;
	level.scr_anim["generic"]["DRS_sprint"] = %sprint1_loop;
	level.scr_anim["drone_intro"]["drop_bag"] = %lag_intro_drone_drop_weapon_bag_guy1;
	level.scr_anim["drone_intro"]["run_into_room"] = %lag_intro_drone_run_into_room_guy2;
	level.scr_anim["drone_intro"]["aim_turret"] = %lag_intro_drone_turret_aim_guy3;
	level.scr_anim["drone_intro"]["aim_forward"] = %lag_intro_drone_aim_moveforward_guy4;
	level.scr_anim["drone_intro"]["guy_5"] = %lag_intro_drone_guy5;
	level.scr_anim["drone_intro"]["guy_6"] = %lag_intro_drone_guy6;
	level.scr_anim["kva_hostage_leader"]["drone_opening"] = %lag_gov_hostage_room_flythrough_guy1;
	level.scr_anim["kva_hostage_minister"]["drone_opening"] = %lag_gov_hostage_room_flythrough_guy2;
	level.scr_anim["kva_hostage_victim"]["drone_opening"] = %lag_gov_hostage_room_flythrough_guy3;
	level.scr_anim["kva_hostage_execution_1"]["drone_opening"] = %lag_gov_hostage_room_flythrough_hostage_01;
	level.scr_anim["kva_hostage_execution_2"]["drone_opening"] = %lag_gov_hostage_room_flythrough_hostage_02;
	level.scr_anim["kva_hostage_execution_3"]["drone_opening"] = %lag_gov_hostage_room_flythrough_hostage_03;
	level.scr_anim["kva_hostage_beatup"]["drone_opening"] = %lag_gov_hostage_room_flythrough_hostage_05;
	level.scr_anim["kva_pm_guard"]["drone_opening"] = %lag_gov_hostage_room_flythrough_kva_01;
	level.scr_anim["kva_guard_beatup"]["drone_opening"] = %lag_gov_hostage_room_flythrough_kva_03;
	level.scr_anim["kva_guard_corner"]["drone_opening"] = %lag_gov_hostage_room_flythrough_kva_04;
	maps\_anim::addnotetrack_customfunction("kva_hostage_leader","muzzleflash_vfx",::maps\lagos_fx::drone_intro_execution_gun_flash);
	level.scr_anim["ajani"]["squad_opening"] = %lag_intro_briefing_ajani;
	level.scr_anim["burke"]["squad_opening"] = %lag_intro_briefing_burke;
	level.scr_anim["joker"]["squad_opening"] = %lag_intro_briefing_joker;
	level.scr_anim["burke"]["exo_climb_burke"] = %lag_gov_wallpullup_burke;
	maps\_anim::addnotetrack_customfunction("burke","hand_plant_right",::maps\lagos_fx::burke_hand_plant_rt_wallclimb,"exo_climb_burke");
	maps\_anim::addnotetrack_customfunction("burke","hand_plant_left",::maps\lagos_fx::burke_hand_plant_lf_wallclimb,"exo_climb_burke");
	level.scr_anim["burke"]["exo_climb_approach"] = %lag_gov_wallapproach_guy_01;
	level.scr_anim["burke"]["exo_climb_approach_idle"][0] = %lag_gov_wallapproach_idle_guy_01;
	level.scr_anim["burke"]["exo_climb_approach_idle"][1] = %lag_gov_wallapproach_twitch_guy_01;
	level.scr_anim["joker"]["exo_climb_joker"] = %lag_gov_wallpullup_joker;
	level.scr_anim["ajani"]["exo_climb_ajani"] = %lag_gov_wallpullup_ajani;
	level.scr_anim["road_block"]["patrol_walk"] = %patrol_bored_patrolwalk;
	level.scr_anim["road_block"]["patrol_idle"] = %patrol_bored_idle;
	level.scr_anim["generic"]["patrol_bored_idle"][0] = %patrol_bored_idle;
	level.scr_anim["generic"]["casual_stand_idle"][0] = %casual_stand_idle;
	level.scr_anim["generic"]["casual_killer_stand_idle"][0] = %casual_killer_stand_idle;
	level.scr_anim["wounded_carrier"]["help_loop"][0] = %ny_manhattan_wounded_help_carrier;
	level.scr_anim["prague_walk"]["prague_woundwalk"] = %prague_woundwalk_wounded;
	level.scr_anim["prague_help"]["prague_woundwalk"] = %prague_woundwalk_helper;
	level.scr_anim["prague_walk"]["prague_woundwalk_help"][0] = %prague_woundidle_wounded;
	level.scr_anim["prague_help"]["prague_woundwalk_help"][0] = %prague_woundidle_helper;
	level.scr_anim["gov_breach"]["gov_kva_reload"] = %coverstand_reloada;
	level.scr_anim["generic"]["civilian_sitting_talking_A_2"][0] = %civilian_sitting_talking_a_2;
	level.scr_anim["KvaLeader"]["sit_in_chair"][0] = %civilian_sitting_talking_a_2;
	level.scr_anim["KvaLeader"]["check_watch"] = %london_civ_idle_checkwatch;
	level.scr_anim["KvaLeader"]["stretch"] = %london_guard_twitch_stretch;
	level.scr_anim["KvaLeader"]["civilian_smoking_A"][0] = %civilian_smoking_a;
	level.scr_anim["KvaLeader"]["civilian_smoking_B"][0] = %civilian_smoking_b;
	level.scr_anim["KvaLeader"]["civilian_hurried_walk"][0] = %civilian_walk_hurried_1;
	level.scr_anim["KvaLeader"]["civilian_hurried_walk"][1] = %civilian_walk_hurried_2;
	level.scr_anim["burke"]["roof_mute_breach_goto"] = %lag_roof_breach_guy1;
	level.scr_anim["joker"]["roof_mute_breach_goto"] = %lag_roof_breach_guy2;
	level.scr_anim["ajani"]["roof_mute_breach_goto"] = %lag_roof_breach_guy3;
	level.scr_anim["burke"]["roof_mute_breach_idle"][0] = %lag_roof_breach_idle_guy1;
	level.scr_anim["joker"]["roof_mute_breach_idle"][0] = %lag_roof_breach_idle_guy2;
	level.scr_anim["ajani"]["roof_mute_breach_idle"][0] = %lag_roof_breach_idle_guy3;
	level.scr_anim["burke"]["roof_mute_breach_plant"] = %lag_roof_breach_plant_guy1;
	level.scr_anim["joker"]["roof_mute_breach_plant"] = %lag_roof_breach_plant_guy2;
	level.scr_anim["ajani"]["roof_mute_breach_plant"] = %lag_roof_breach_plant_guy3;
	level.scr_anim["burke"]["roof_mute_breach_jumpdown"] = %lag_roof_breach_jumpdown_guy1;
	level.scr_anim["joker"]["roof_mute_breach_jumpdown"] = %lag_roof_breach_jumpdown_guy2;
	level.scr_anim["ajani"]["roof_mute_breach_jumpdown"] = %lag_roof_breach_jumpdown_guy3;
	level.scr_anim["front_kva_1"]["roof_breach_enemy_react"] = %lag_roof_breach_react_guy1;
	level.scr_anim["front_kva_2"]["roof_breach_enemy_react"] = %lag_roof_breach_react_guy2;
	level.scr_anim["front_kva_3"]["roof_breach_enemy_react"] = %lag_roof_breach_react_guy3;
	level.scr_anim["front_kva_4"]["roof_breach_enemy_react"] = %lag_roof_breach_react_guy4;
	level.scr_anim["front_kva_1"]["roof_breach_enemy_death"] = %lag_roof_breach_react_death_guy1;
	level.scr_anim["front_kva_2"]["roof_breach_enemy_death"] = %lag_roof_breach_react_death_guy2;
	level.scr_anim["front_kva_3"]["roof_breach_enemy_death"] = %lag_roof_breach_react_death_guy3;
	level.scr_anim["front_kva_4"]["roof_breach_enemy_death"] = %lag_roof_breach_react_death_guy4;
	level.scr_anim["burke"]["cqb_idle"][0] = %fusion_elevator_door_open_guy1_open_idle;
	level.scr_anim["joker"]["cqb_idle"][0] = %cqb_stand_idle;
	level.scr_anim["ajani"]["cqb_idle"][0] = %readystand_idle;
	level.scr_anim["joker"]["h_breach"] = %lag_infiltration_plant_walldevice_guy1;
	level.scr_anim["burke"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_burke;
	level.scr_anim["hostage_1"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy1;
	level.scr_anim["hostage_2"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy2;
	level.scr_anim["ajani"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy3;
	level.scr_anim["kva_1"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy4;
	level.scr_anim["kva_2"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy5;
	level.scr_anim["kva_3"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy6;
	level.scr_anim["hostage_3"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy7;
	level.scr_anim["hostage_4"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy8;
	level.scr_anim["hostage_5"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy9;
	level.scr_anim["hostage_6"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy10;
	level.scr_anim["kva_4"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy11;
	level.scr_anim["ajani"]["h_breach_pre_idle"][0] = %lag_gov_hostage_room_breach_trans_idle_guy3;
	level.scr_anim["burke"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_idle_burke;
	level.scr_anim["hostage_1"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_pt2_guy1;
	level.scr_anim["hostage_2"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_idle_guy2;
	level.scr_anim["ajani"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_idle_guy3;
	level.scr_anim["kva_1"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_pt2_guy4;
	level.scr_anim["kva_2"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_pt2_guy5;
	level.scr_anim["kva_3"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_pt2_guy6;
	level.scr_anim["hostage_3"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_pt2_guy7;
	level.scr_anim["hostage_4"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_pt2_guy8;
	level.scr_anim["hostage_5"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_pt2_guy9;
	level.scr_anim["hostage_6"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_pt2_guy10;
	level.scr_anim["kva_4"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_pt2_guy11;
	level.scr_anim["burke"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_burke;
	level.scr_anim["hostage_1"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy1;
	level.scr_anim["hostage_2"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy2;
	level.scr_anim["ajani"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy3;
	level.scr_anim["kva_1"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy4;
	level.scr_anim["kva_2"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy5;
	level.scr_anim["kva_3"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy6;
	level.scr_anim["hostage_3"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy7;
	level.scr_anim["hostage_4"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy8;
	level.scr_anim["hostage_5"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy9;
	level.scr_anim["hostage_6"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy10;
	level.scr_anim["kva_4"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy11;
	level.scr_anim["hostage_1"]["h_breach_post"][0] = %lag_gov_hostage_room_breach_pt2_guy1;
	level.scr_anim["hostage_2"]["h_breach_post"][0] = %lag_gov_hostage_room_breach_pt2_idle_guy2;
	level.scr_anim["kva_1"]["h_breach_post"][0] = %lag_gov_hostage_room_breach_pt2_guy4;
	level.scr_anim["kva_2"]["h_breach_post"][0] = %lag_gov_hostage_room_breach_pt2_guy5;
	level.scr_anim["kva_3"]["h_breach_post"][0] = %lag_gov_hostage_room_breach_pt2_guy6;
	level.scr_anim["hostage_3"]["h_breach_post"][0] = %lag_gov_hostage_room_breach_pt2_idle_guy7;
	level.scr_anim["hostage_4"]["h_breach_post"][0] = %lag_gov_hostage_room_breach_pt2_idle_guy8;
	level.scr_anim["hostage_5"]["h_breach_post"][0] = %lag_gov_hostage_room_breach_pt2_idle_guy9;
	level.scr_anim["hostage_6"]["h_breach_post"][0] = %lag_gov_hostage_room_breach_pt2_idle_guy10;
	level.scr_anim["kva_4"]["h_breach_post"][0] = %lag_gov_hostage_room_breach_pt2_guy11;
	level.scr_anim["joker"]["h_breach_exit_door_start"] = %lag_gov_hostage_room_breach_pt1_joker;
	level.scr_anim["joker"]["h_breach_exit_door_idle"][0] = %lag_gov_hostage_room_breach_idle_joker;
	level.scr_anim["joker"]["h_breach_exit_door_open"] = %lag_gov_hostage_room_breach_pt2_joker;
	level.scr_anim["generic"]["bike_rider"] = %favela_bicycle_rider;
	level.scr_anim["KVA_rappel_right"]["rb_rappel_right"] = %lag_bridge_rappel_ls;
	level.scr_anim["KVA_rappel_left"]["rb_rappel_left"] = %lag_bridge_rappel_rs;
	level.scr_anim["burke"]["oncoming_gate_idle"][0] = %breach_kick_stackl1_idle;
	level.scr_anim["burke"]["oncoming_gate_open"] = %lag_gate_smashcontrol_open_gate_guy1;
	level.scr_anim["joker"]["oncoming_gate_open"] = %lag_gate_smashcontrol_open_gate_guy1;
	level.scr_anim["burke"]["oncoming_alley_seq_enter"] = %lag_burke_skidforward_turnright;
	level.scr_anim["guy1"]["oncoming_alley_seq_enter"] = %lag_oncoming_alley_turret_guy1;
	level.scr_anim["guy1"]["oncoming_alley_seq_straight"] = %lag_oncoming_alley_turret_guy1_straight;
	maps\_anim::addnotetrack_customfunction("burke","vfx_gideon_slide",::maps\lagos_fx::gideon_slide_dust);
	level.scr_anim["burke"]["burke_flank_kick_start"] = %lag_flank_kick_door_burke;
	level.scr_anim["burke"]["burke_flank_kick_loop"][0] = %lag_flank_kick_door_loop_burke;
	level.scr_anim["burke"]["burke_flank_kick_exit"] = %lag_flank_kick_door_out_burke;
	level.scr_anim["civ_flank"]["burke_flank_kick_civ_react"] = %lag_flank_kick_door_take_cover_burke;
	level.scr_anim["civ_flank"]["burke_flank_kick_civ_idle"][0] = %lag_flank_kick_door_take_cover_burke_cover_idle;
	level.scr_anim["burke"]["burke_traffic_start_idle"][0] = %lag_pullbackfence_jump_burke_idle;
	level.scr_anim["burke"]["burke_traffic_start_pt1"] = %lag_pullbackfence_jump_burke_pt1;
	level.scr_anim["burke"]["burke_traffic_start_pt2"] = %lag_pullbackfence_jump_burke_pt2;
	level.scr_anim["burke"]["burke_traffic_start_idle"][1] = %lag_pullbackfence_jump_burke_twitch;
	level.scr_anim["burke"]["lag_truck_takedown_pt1_into"] = %lag_truck_takedown_pt1_into_burke;
	level.scr_anim["burke"]["lag_truck_takedown_pt1_burke_loop"][0] = %lag_truck_takedown_pt1_burke_loop;
	level.scr_anim["burke"]["hostage_truck_takedown_pt1"] = %lag_truck_takedown_pt1_burke;
	level.scr_anim["KVA_1"]["hostage_truck_takedown_pt1"] = %lag_truck_takedown_pt1_guy1;
	level.scr_anim["KVA_2"]["hostage_truck_takedown_pt1"] = %lag_truck_takedown_pt1_guy2;
	level.scr_anim["burke"]["hostage_truck_takedown_pt2"] = %lag_truck_takedown_pt2_burke;
	level.scr_anim["KVA_1"]["hostage_truck_takedown_pt2"] = %lag_truck_takedown_pt2_guy1;
	level.scr_anim["KVA_2"]["hostage_truck_takedown_pt2"] = %lag_truck_takedown_pt2_guy2;
	level.scr_anim["burke"]["hostage_truck_takedown_pt3"] = %lag_truck_takedown_pt3_burke;
	level.scr_anim["KVA_1"]["hostage_truck_takedown_pt3"] = %lag_truck_takedown_pt3_guy1;
	level.scr_anim["KVA_2"]["hostage_truck_takedown_pt3"] = %lag_truck_takedown_pt3_guy2;
	level.scr_anim["burke"]["hostage_truck_takedown_pt4_into"] = %lag_truck_takedown_pt4_into_burke;
	level.scr_anim["hostage_1"]["hostage_truck_takedown_pt4_into"] = %lag_truck_takedown_pt4_into_guy4;
	level.scr_anim["hostage_2"]["hostage_truck_takedown_pt4_into"] = %lag_truck_takedown_pt4_into_guy5;
	level.scr_anim["hostage_3"]["hostage_truck_takedown_pt4_into"] = %lag_truck_takedown_pt4_into_guy6;
	level.scr_anim["burke"]["hostage_truck_takedown_pt4"] = %lag_truck_takedown_pt4_burke;
	level.scr_anim["hostage_1"]["hostage_truck_takedown_pt4"] = %lag_truck_takedown_pt4_guy4;
	level.scr_anim["hostage_2"]["hostage_truck_takedown_pt4"] = %lag_truck_takedown_pt4_guy5;
	level.scr_anim["hostage_3"]["hostage_truck_takedown_pt4"] = %lag_truck_takedown_pt4_guy6;
	maps\_anim::addnotetrack_customfunction("hostage_3","vfx_ai_dead_bubble_trails",::maps\lagos_fx::hostage_drowned_bubble_trails,"hostage_truck_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("burke","vfx_gideon_bubble_trails",::maps\lagos_fx::gideon_bubble_trails,"hostage_truck_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("hostage_1","vfx_ai_rescued_bubble_trails",::maps\lagos_fx::hostage_rescued_bubble_trails,"hostage_truck_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("burke","vfx_guideon_swim_stroke_up",::maps\lagos_fx::gideon_swim_stroke_up,"hostage_truck_takedown_pt4");
	level.scr_anim["KVA_1"]["hostage_truck_takedown_fail_pt2"] = %lag_truck_takedown_fail_pt2_guy1;
	level.scr_anim["KVA_2"]["hostage_truck_takedown_fail_pt2"] = %lag_truck_takedown_fail_pt2_guy2;
	level.scr_anim["KVA_1"]["hostage_truck_takedown_death"] = %lag_truck_takedown_death_guy1;
	level.scr_anim["KVA_2"]["hostage_truck_takedown_death"] = %lag_truck_takedown_death_guy2;
	level.scr_goaltime["KVA_1"]["hostage_truck_takedown_death"] = 0.05;
	level.scr_goaltime["KVA_2"]["hostage_truck_takedown_death"] = 0.05;
	level.scr_anim["burke"]["hostage_truck_takedown_pt5"] = %lag_truck_takedown_pt5_burke;
	level.scr_anim["hostage_1"]["hostage_truck_takedown_pt5"] = %lag_truck_takedown_pt5_guy1;
	level.scr_anim["joker"]["hostage_truck_takedown_pt5"] = %lag_truck_takedown_pt5_guy3;
	level.scr_anim["ajani"]["hostage_truck_takedown_pt5"] = %lag_truck_takedown_pt5_ajani;
	level.scr_anim["KVA_0"]["truck_middle_takedown_pt1"] = %lag_truck_middle_takedown_pt1_guy;
	level.scr_anim["KVA_1"]["truck_middle_takedown_pt1"] = %lag_truck_middle_takedown_pt1_guy1;
	level.scr_anim["KVA_3"]["truck_middle_takedown_pt1"] = %lag_truck_middle_takedown_pt1_guy3;
	level.scr_anim["KVA_0"]["truck_middle_takedown_pt2"] = %lag_truck_middle_takedown_pt2_guy;
	level.scr_anim["KVA_1"]["truck_middle_takedown_pt2"] = %lag_truck_middle_takedown_pt2_guy1;
	level.scr_anim["KVA_3"]["truck_middle_takedown_pt2"] = %lag_truck_middle_takedown_pt2_guy3;
	level.scr_anim["KVA_0"]["truck_middle_takedown_pt3"] = %lag_truck_middle_takedown_pt3_guy;
	level.scr_anim["KVA_1"]["truck_middle_takedown_pt3"] = %lag_truck_middle_takedown_pt3_guy1;
	level.scr_anim["KVA_3"]["truck_middle_takedown_pt3"] = %lag_truck_middle_takedown_pt3_guy3;
	level.scr_anim["KVA_0"]["truck_middle_takedown_pt4"] = %lag_truck_middle_takedown_pt4_guy;
	level.scr_anim["KVA_1"]["truck_middle_takedown_pt4"] = %lag_truck_middle_takedown_pt4_guy1;
	level.scr_anim["KVA_3"]["truck_middle_takedown_pt4"] = %lag_truck_middle_takedown_pt4_guy3;
	level.scr_anim["KVA_0"]["truck_middle_takedown_pt5"] = %lag_truck_middle_takedown_pt5_guy;
	level.scr_anim["KVA_1"]["truck_middle_takedown_pt5"] = %lag_truck_middle_takedown_pt5_guy1;
	level.scr_anim["KVA_3"]["truck_middle_takedown_pt5"] = %lag_truck_middle_takedown_pt5_guy3;
	level.scr_anim["KVA_1"]["truck_middle_takedown_death_guy1"] = %lag_truck_middle_takedown_death_guy1;
	level.scr_anim["KVA_3"]["truck_middle_takedown_death_guy3"] = %lag_truck_middle_takedown_death_guy3;
	notetracks_truck_middle_takedown_pt4();
}

//Function Number: 9
notetracks_truck_middle_takedown_pt4()
{
	maps\_anim::addnotetrack_customfunction("KVA_0","vfx_kva_driver_pole_impact",::maps\lagos_fx::kva_death_impact_post,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("KVA_3","start_ragdoll",::maps\lagos_qte_middle::notetrack_unlink_and_start_ragdoll,"truck_middle_takedown_death_guy3");
}

//Function Number: 10
vehicle_anims()
{
	level.scr_animtree["squad_opening_warbird"] = #animtree;
	level.scr_animtree["hostage_truck"] = #animtree;
	level.scr_animtree["oncoming_truck"] = #animtree;
	level.scr_animtree["oncoming_truck_prop"] = #animtree;
	level.scr_model["oncoming_truck_prop"] = "vehicle_civ_full_size_technical";
	level.scr_animtree["final_bus"] = "animtree";
	level.scr_anim["squad_opening_warbird"]["squad_opening"] = %lag_intro_briefing_warbird;
	level.scr_anim["oncoming_truck"]["oncoming_alley_seq_enter"] = %lag_oncoming_alley_truck_enter;
	level.scr_anim["oncoming_truck"]["oncoming_alley_seq_turn"] = %lag_oncoming_alley_truck_turn;
	level.scr_anim["oncoming_truck"]["oncoming_alley_seq_straight"] = %lag_oncoming_alley_truck_straight;
	level.scr_anim["oncoming_truck_prop"]["oncoming_alley_seq_enter"] = %lag_oncoming_alley_truck_enter;
	level.scr_anim["oncoming_truck_prop"]["oncoming_alley_seq_turn"] = %lag_oncoming_alley_truck_turn;
	level.scr_anim["oncoming_truck_prop"]["oncoming_alley_seq_straight"] = %lag_oncoming_alley_truck_straight;
	level.scr_animtree["oncoming_truck_turret"] = #animtree;
	level.scr_model["oncoming_truck_turret"] = "vehicle_civ_full_size_technical_turret";
	level.scr_anim["oncoming_truck_turret"]["oncoming_alley_seq_enter"] = %lag_oncoming_alley_technical_turret;
	level.scr_anim["oncoming_truck_turret"]["oncoming_alley_seq_straight"] = %lag_oncoming_alley_technical_turret_straight;
	maps\_anim::addnotetrack_customfunction("oncoming_truck","vfx_truck_dust_trail",::maps\lagos_fx::truck_dust_trail);
	maps\_anim::addnotetrack_customfunction("oncoming_truck","vfx_truck_treadfx_wheels",::maps\lagos_fx::truck_treadfx_wheels);
	maps\_anim::addnotetrack_customfunction("oncoming_truck","vfx_truck_treadfx_skid",::maps\lagos_fx::truck_treadfx_skid);
	maps\_anim::addnotetrack_customfunction("oncoming_truck","vfx_truck_treadfx_reverse",::maps\lagos_fx::truck_treadfx_turn,"oncoming_alley_seq_turn");
	level.scr_model["hostage_truck"] = "vehicle_civ_boxtruck_highres_ai";
	level.scr_anim["final_bus"]["hostage_truck_takedown_pt1"] = %lag_truck_takedown_pt1_bus;
	level.scr_anim["hostage_truck"]["lag_truck_takedown_pt1_into"] = %lag_truck_takedown_pt1_into_truck;
	level.scr_anim["oncoming_truck"]["hostage_truck_takedown_pt3"] = %lag_truck_takedown_pt3_truck2;
	level.scr_anim["hostage_truck"]["hostage_truck_takedown_pt1"] = %lag_truck_takedown_pt1_truck;
	level.scr_anim["hostage_truck"]["hostage_truck_takedown_pt2"] = %lag_truck_takedown_pt2_truck;
	level.scr_anim["hostage_truck"]["hostage_truck_takedown_pt3"] = %lag_truck_takedown_pt3_truck;
	maps\_anim::addnotetrack_notify("hostage_truck","pt1_fail","hostage_truck_takedown_pt1_fail","hostage_truck_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("hostage_truck","vfx_truck_mirror_snap",::maps\lagos_fx::truck_rearview_mirror_snap,"hostage_truck_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("hostage_truck","vfx_truck_suv_collision",::maps\lagos_fx::truck_headon_collision,"hostage_truck_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("hostage_truck","vfx_truck_rail_impact",::maps\lagos_fx::truck_rail_impact,"hostage_truck_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("hostage_truck","vfx_truck_water_impact",::maps\lagos_fx::truck_water_impact,"hostage_truck_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("hostage_truck","vfx_truck_mirror_snap",::maps\lagos_code::notetrack_highway_final_td_mirror_snap_and_drag,"hostage_truck_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("hostage_truck","vfx_truck_suv_collision",::maps\lagos_code::notetrack_highway_final_td_suv_collision,"hostage_truck_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("hostage_truck","vfx_truck_rail_impact",::maps\lagos_code::notetrack_highway_final_td_truck_rail_impact,"hostage_truck_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("hostage_truck","vfx_truck_water_impact",::maps\lagos_code::notetrack_highway_final_td_truck_water_impact,"hostage_truck_takedown_pt3");
	level.scr_anim["hostage_truck"]["hostage_truck_takedown_pt4_into"] = %lag_truck_takedown_pt4_into_truck;
	level.scr_anim["hostage_truck"]["hostage_truck_takedown_pt4"] = %lag_truck_takedown_pt4_truck;
	level.scr_anim["hostage_truck"]["hostage_truck_takedown_fail_pt2"] = %lag_truck_takedown_fail_pt2_truck;
	maps\_anim::addnotetrack_customfunction("hostage_truck","vfx_truck_latch_open",::maps\lagos_fx::truck_latch_open_trail,"hostage_truck_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("hostage_truck","vfx_truck_open_cargo_door",::maps\lagos_fx::truck_cargo_door_open,"hostage_truck_takedown_pt4");
	level.scr_anim["player_bus"]["truck_middle_takedown_pt1"] = %lag_truck_middle_takedown_pt1_bus;
	level.scr_anim["player_bus"]["truck_middle_takedown_pt2"] = %lag_truck_middle_takedown_pt2_bus;
	level.scr_anim["player_bus"]["truck_middle_takedown_pt3"] = %lag_truck_middle_takedown_pt3_bus;
	level.scr_anim["player_bus"]["truck_middle_takedown_pt4"] = %lag_truck_middle_takedown_pt4_bus;
	level.scr_anim["player_bus"]["truck_middle_takedown_pt5"] = %lag_truck_middle_takedown_pt5_bus;
	level.scr_anim["hit_kva_bus"]["truck_middle_takedown_pt5"] = %lag_truck_middle_takedown_pt5_bus2;
	maps\_anim::addnotetrack_customfunction("player_bus","viewmodel_swap",::maps\lagos_qte::hostage_truck_viewmodel_swap,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_bus","viewmodel_swap",::maps\lagos_qte::hostage_truck_viewmodel_swap,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_bus","qte_prompt",::maps\lagos_qte_middle::notify_qte_prompt_and_slowmo,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("player_bus","qte_prompt",::maps\lagos_qte_middle::notify_qte_prompt_and_slowmo,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("player_bus","qte_prompt",::maps\lagos_qte_middle::notify_qte_prompt_and_slowmo,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("player_bus","qte_prompt",::maps\lagos_qte_middle::notify_qte_prompt_and_slowmo,"truck_middle_takedown_pt4");
	level.scr_anim["kva_truck"]["truck_middle_takedown_pt1"] = %lag_truck_middle_takedown_pt1_truck;
	level.scr_anim["kva_truck"]["truck_middle_takedown_pt2"] = %lag_truck_middle_takedown_pt2_truck;
	level.scr_anim["kva_truck"]["truck_middle_takedown_pt3"] = %lag_truck_middle_takedown_pt3_truck;
	level.scr_anim["kva_truck"]["truck_middle_takedown_pt4"] = %lag_truck_middle_takedown_pt4_truck;
	level.scr_anim["kva_truck"]["truck_middle_takedown_pt5"] = %lag_truck_middle_takedown_pt5_truck;
	notetracks_truck_middle_takedown_kva_truck();
	level.scr_anim["car_hood"]["car_drive_hood_stop"] = %lag_roundabout_out_of_car_vehicle;
	level.scr_anim["compact"]["open_door_right"] = %civ_domestic_compact_open_door_right;
	level.scr_anim["truck"]["open_door_both"] = %civ_domestic_truck_open_door_both;
	level.scr_anim["truck"]["open_door_left"] = %civ_domestic_truck_open_door_left;
	level.scr_anim["truck"]["open_door_right"] = %civ_domestic_truck_open_door_right;
	level.scr_anim["sedan"]["open_door_both"] = %civ_domestic_sedan_doors_open_fl_fr;
	level.scr_anim["sedan"]["open_door_left"] = %civ_domestic_sedan_doors_open_fl;
	level.scr_anim["sedan"]["open_door_right"] = %civ_domestic_sedan_doors_open_fr;
	level.scr_anim["sedan"]["get_out_01"] = %sf_a_civillian_civ_sedan_veh_03;
	level.scr_anim["sedan"]["get_out_02"] = %sf_a_civillian_civ_sedan_veh_04;
	level.scr_anim["sedan"]["get_out_03"] = %sf_a_civillian_civ_sedan_veh_06;
	level.scr_anim["compact"]["get_out_01"] = %sf_a_civillian_compactcar_veh_03;
	level.scr_anim["compact"]["get_out_02"] = %sf_a_civillian_compactcar_veh_04;
	level.scr_anim["compact"]["get_out_03"] = %sf_a_civillian_compactcar_veh_06;
	level.scr_anim["truck"]["get_out_01"] = %sf_a_civillian_civ_truck_veh_03;
	level.scr_anim["truck"]["get_out_02"] = %sf_a_civillian_civ_truck_veh_04;
	level.scr_anim["truck"]["get_out_03"] = %sf_a_civillian_civ_truck_veh_06;
	level.scr_anim["hostage_truck_fence"]["hostage_truck_pass_fence"] = %lag_pullbackfence_jump_boxtruck_pt1;
	level.scr_anim["highway_bus_1"]["highway_bus_1_pass_fence"] = %lag_pullbackfence_jump_bus_pt1;
}

//Function Number: 11
notetracks_truck_middle_takedown_kva_truck()
{
	maps\_anim::addnotetrack_customfunction("kva_truck","vfx_kva_skid_ram",::maps\lagos_fx::kva_pickup_wheel_skid_ram,"truck_middle_takedown_pt1");
	maps\_anim::addnotetrack_customfunction("kva_truck","vfx_kva_pickup_hit_bus",::maps\lagos_fx::kva_pickup_hit_bus,"truck_middle_takedown_pt2");
	maps\_anim::addnotetrack_customfunction("kva_truck","vfx_player_land_on_hood",::maps\lagos_fx::player_land_on_hood,"truck_middle_takedown_pt3");
	maps\_anim::addnotetrack_customfunction("kva_truck","vfx_kva_pickup_windshield_hit",::maps\lagos_fx::kva_pickup_hit_windshield,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("kva_truck","vfx_kva_pickup_divider_hit",::maps\lagos_fx::kva_pickup_hit_divider_01,"truck_middle_takedown_pt4");
	maps\_anim::addnotetrack_customfunction("kva_truck","vfx_kva_pickup_hit_roll",::maps\lagos_fx::kva_pickup_hit_divider_03,"truck_middle_takedown_pt5");
	maps\_anim::addnotetrack_customfunction("kva_truck","vfx_kva_pickup_barrier_flip",::maps\lagos_fx::kva_pickup_flip_and_skid,"truck_middle_takedown_pt5");
}

//Function Number: 12
model_anims()
{
	level.scr_animtree["drone_photo"] = #animtree;
	level.scr_model["drone_photo"] = "genericProp";
	level.scr_anim["drone_photo"]["drone_opening"] = %lag_gov_hostage_room_flythrough_photo;
	level.scr_animtree["intro_duffle"] = #animtree;
	level.scr_model["intro_duffle"] = "bag_rifle_01_rig";
	level.scr_anim["intro_duffle"]["drop_bag"] = %lag_intro_drone_drop_weapon_bag;
	level.scr_animtree["pm_cuffs"] = #animtree;
	level.scr_model["pm_cuffs"] = "s1_handcuffs";
	level.scr_anim["pm_cuffs"]["drone_opening"] = %lag_gov_hostage_room_flythrough_handcuffs;
	level.scr_anim["pm_cuffs"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_handcuffs_pt1;
	level.scr_anim["pm_cuffs"]["h_breach_idle"][0] = %lag_gov_hostage_room_breach_handcuffs_idle_pt1;
	level.scr_anim["pm_cuffs"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_handcuffs_pt2;
	maps\_anim::addnotetrack_customfunction("pm_cuffs","handcuff_break",::maps\lagos_fx::handcuff_break_fx,"h_breach_pt2");
	level.scr_animtree["vic_cuffs"] = #animtree;
	level.scr_model["vic_cuffs"] = "s1_handcuffs";
	level.scr_anim["vic_cuffs"]["drone_opening"] = %lag_gov_hostage_room_flythrough_handcuffs_02;
	level.scr_anim["vic_cuffs"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_pt1_guy1_handcuffs;
	level.scr_anim["vic_cuffs"]["h_breach_pt2"] = %lag_gov_hostage_room_breach_pt2_guy1_handcuffs;
	level.scr_animtree["gov_exit_door"] = #animtree;
	level.scr_model["gov_exit_door"] = "det_hospital_door_02";
	level.scr_anim["gov_exit_door"]["h_breach_exit_door_open"] = %lag_gov_hostage_room_breach_pt2_door;
	level.scr_animtree["rooftop_breach_device"] = #animtree;
	level.scr_model["rooftop_breach_device"] = "lag_roof_breach_device";
	level.scr_anim["rooftop_breach_device"]["squad_opening"] = %lag_intro_briefing_breach_device;
	level.scr_animtree["lag_intro_prop1"] = #animtree;
	level.scr_model["lag_intro_prop1"] = "npc_frag_grenade";
	level.scr_anim["lag_intro_prop1"]["squad_opening"] = %lag_intro_briefing_prop_01;
	level.scr_animtree["lag_intro_prop2"] = #animtree;
	level.scr_model["lag_intro_prop2"] = "npc_frag_grenade";
	level.scr_anim["lag_intro_prop2"]["squad_opening"] = %lag_intro_briefing_prop_02;
	level.scr_animtree["intro_tram1"] = #animtree;
	level.scr_model["intro_tram1"] = "vehicle_civ_monorail_hanging_clr01_ai";
	level.scr_anim["intro_tram1"]["tram1_flythrough"] = %lag_gov_hostage_room_flythrough_monorail;
	level.scr_anim["intro_tram1"]["tram1_movement"] = %lag_monorail_a;
	level.scr_anim["intro_tram1"]["tram2_movement"] = %lag_monorail_b;
	level.scr_anim["intro_tram1"]["tram3_movement"] = %lag_monorail_c_stop;
	level.scr_animtree["exo_door_model"] = #animtree;
	level.scr_anim["exo_door_model"]["exo_door"] = %lag_exo_door_takedown_door;
	maps\_anim::addnotetrack_customfunction("exo_door_model","vfx_exo_door_kick",::maps\lagos_fx::exo_door_kick,"exo_door");
	maps\_anim::addnotetrack_customfunction("exo_door_model","vfx_exo_door_break",::maps\lagos_fx::exo_door_break,"exo_door");
	level.scr_animtree["lobby_elevator_right"] = #animtree;
	level.scr_model["lobby_elevator_right"] = "genericProp";
	level.scr_animtree["lobby_elevator_left"] = #animtree;
	level.scr_model["lobby_elevator_left"] = "genericProp";
	level.scr_animtree["lobby_tablet"] = #animtree;
	level.scr_model["lobby_tablet"] = "npc_exo_launch_pad";
	level.scr_anim["lobby_tablet"]["lobby_tablet_loop"][0] = %lag_lobby_sitting_loop_pad;
	level.scr_anim["lobby_tablet"]["lobby_tablet_react_short"] = %lag_lobby_sitting_react_pad_short;
	level.scr_anim["lobby_tablet"]["lobby_tablet_react"] = %lag_lobby_sitting_react_pad;
	level.scr_animtree["bike"] = #animtree;
	level.scr_anim["bike"]["pedal"] = %favela_bicycle;
	level.scr_anim["bike"]["drop_bike_loop"][0] = %lag_roundabout_bicycle_loop;
	level.scr_anim["bike"]["drop_bike_react"] = %lag_roundabout_bicycle;
	level.scr_animtree["oncoming_gate"] = #animtree;
	level.scr_model["oncoming_gate"] = "lag_sliding_gate_rig";
	level.scr_anim["oncoming_gate"]["oncoming_gate_open"] = %lag_gate_smashcontrol_open_gate;
	maps\_anim::addnotetrack_customfunction("oncoming_gate","vfx_kick_gate_controlbox",::maps\lagos_fx::gate_controlbox_broken_fx);
	level.scr_animtree["mute_breach_device"] = #animtree;
	level.scr_model["mute_breach_device"] = "muteCharge";
	level.scr_anim["mute_breach_device"]["roof_mute_breach_plant"] = %lag_roof_breach_mutecharge;
	maps\_anim::addnotetrack_customfunction("mute_breach_device","vfx_mute_device_plant",::maps\lagos_fx::mute_device_plant_fx);
	level.scr_animtree["roof_breach_device"] = #animtree;
	level.scr_model["roof_breach_device"] = "lag_roof_breach_device";
	level.scr_anim["roof_breach_device"]["roof_mute_breach_plant"] = %lag_roof_breach_plant_device;
	maps\_anim::addnotetrack_customfunction("roof_breach_device","vfx_breach_device_place",::maps\lagos_fx::roof_breach_device_plant_dust);
	maps\_anim::addnotetrack_customfunction("roof_breach_device","vfx_breach_device_mark",::maps\lagos_fx::roof_breach_device_area_mark);
	maps\_anim::addnotetrack_customfunction("roof_breach_device","vfx_breach_device_charges_plant",::maps\lagos_fx::roof_breach_device_plant_mini_charges);
	maps\_anim::addnotetrack_customfunction("roof_breach_device","vfx_breach_device_radial_blast",::maps\lagos_fx::roof_breach_device_radial_sml_explosions);
	maps\_anim::addnotetrack_customfunction("roof_breach_device","vfx_breach_device_explosion",::maps\lagos_fx::roof_breach_device_explosion);
	maps\_anim::addnotetrack_customfunction("roof_breach_device","roof_breach_device_start",::maps\lagos_code::notetrack_swap_roof_brush);
	level.scr_animtree["rooftop_chunks"] = #animtree;
	level.scr_model["rooftop_chunks"] = "lag_govt_roof_chunk";
	level.scr_anim["rooftop_chunks"]["roof_mute_breach_plant"] = %lag_roof_breach_jumpdown_rooftop_chunks;
	maps\_anim::addnotetrack_customfunction("rooftop_chunks","vfx_roof_chunks_bursts",::maps\lagos_fx::roof_breach_chunks_bursts);
	level.scr_animtree["h_breach_device"] = #animtree;
	level.scr_model["h_breach_device"] = "lag_harmonic_breach_device";
	level.scr_anim["h_breach_device"]["h_breach"] = %lag_infiltration_plant_walldevice;
	level.scr_animtree["h_breach_doors"] = #animtree;
	level.scr_model["h_breach_doors"] = "door_double_govt_01_rigged";
	level.scr_anim["h_breach_doors"]["h_breach_pt1"] = %lag_gov_hostage_room_breach_door;
	level.scr_animtree["rappel_roundabout"] = #animtree;
	level.scr_anim["rappel_roundabout"]["start_rope_right"] = %lag_bridge_rappel_start_rope_rs;
	level.scr_anim["rappel_roundabout"]["start_rope_left"] = %lag_bridge_rappel_start_rope_ls;
	level.scr_anim["rappel_roundabout"]["rope_right"] = %lag_bridge_rappel_rope_ls;
	level.scr_anim["rappel_roundabout"]["rope_left"] = %lag_bridge_rappel_rope_rs;
	level.scr_animtree["highway_fence"] = #animtree;
	level.scr_anim["highway_fence"]["highway_fence_pull_back"] = %lag_pullbackfence_jump_fence_pt1;
	maps\_anim::addnotetrack_customfunction("highway_fence","fence_dust",::maps\lagos_fx::pull_fence_dust,"highway_fence_pull_back");
	level.scr_animtree["flank_alley_door"] = #animtree;
	level.scr_model["flank_alley_door"] = "door_double_govt_01_rigged";
	level.scr_anim["flank_alley_door"]["flank_alley_door_kick_open"] = %lag_flank_kick_door_doubledoors;
}

//Function Number: 13
precachecivilian()
{
	precachepropmodels();
	precacheciviliananims();
}

//Function Number: 14
precachepropmodels()
{
	precachemodel("electronics_pda");
	precachemodel("com_cellphone_on");
	precachemodel("prop_cigarette");
	precachemodel("lab_tablet_flat_on");
	precachemodel("ma_cup_single_closed");
	precachemodel("cs_coffeemug02");
	precachemodel("com_metal_briefcase");
	precachemodel("paper_memo");
	precachemodel("open_book");
	precachemodel("genericprop");
	precachemodel("hjk_metal_briefcase");
	precachemodel("electronics_pda_big");
	precachemodel("hjk_tablet_01");
}

//Function Number: 15
precacheciviliananims()
{
	level.scr_animtree["generic"] = #animtree;
	level.scr_anim["generic"]["civilian_texting_standing"][0] = %civilian_texting_standing;
	level.scr_anim["generic"]["civilian_stand_idle"][0] = %civilian_stand_idle;
	level.scr_anim["generic"]["civilian_smoking_A"][0] = %civilian_smoking_a;
	level.scr_anim["generic"]["civilian_smoking_B"][0] = %civilian_smoking_b;
	level.scr_anim["generic"]["london_station_civ1_idle"][0] = %london_station_civ1_idle;
	level.scr_anim["generic"]["london_station_civ2_idle"][0] = %london_station_civ2_idle;
	level.scr_anim["generic"]["london_station_civ4_idle"][0] = %london_station_civ4_idle;
	level.scr_anim["generic"]["london_station_civ5_idle"][0] = %london_station_civ5_idle;
	level.scr_anim["generic"]["london_station_civ6_idle"][0] = %london_station_civ6_idle;
	level.scr_anim["generic"]["london_station_civ7_idle"][0] = %london_station_civ7_idle;
	level.scr_anim["generic"]["london_station_civ11_idle"][0] = %london_station_civ11_idle;
	level.scr_anim["generic"]["parabolic_leaning_guy_smoking_idle"][0] = %parabolic_leaning_guy_smoking_idle;
	level.scr_anim["generic"]["parabolic_leaning_guy_idle"][0] = %parabolic_leaning_guy_idle;
	level.scr_anim["generic"]["oilrig_balcony_smoke_idle"][0] = %oilrig_balcony_smoke_idle;
	level.scr_anim["generic"]["civilian_directions_1_A"][0] = %civilian_directions_1_a;
	level.scr_anim["generic"]["civilian_directions_1_B"][0] = %civilian_directions_1_b;
	level.scr_anim["generic"]["civilian_texting_sitting"][0] = %civilian_texting_sitting;
	level.scr_anim["generic"]["civilian_sitting_business_lunch_A_1"][0] = %civilian_sitting_business_lunch_a_1;
	level.scr_anim["generic"]["civilian_sitting_business_lunch_B_1"][0] = %civilian_sitting_business_lunch_b_1;
	level.scr_anim["generic"]["civilian_sitting_talking_A_1"][0] = %civilian_sitting_talking_a_1;
	level.scr_anim["generic"]["civilian_sitting_talking_A_2"][0] = %civilian_sitting_talking_a_2;
	level.scr_anim["generic"]["civilian_sitting_talking_B_1"][0] = %civilian_sitting_talking_b_1;
	level.scr_anim["generic"]["civilian_sitting_talking_B_2"][0] = %civilian_sitting_talking_b_2;
	level.scr_anim["generic"]["civilian_reader_1"][0] = %civilian_reader_1;
	level.scr_anim["generic"]["civilian_reader_2"][0] = %civilian_reader_2;
	level.scr_anim["generic"]["guardB_sit_drinker_idle"][0] = %guardb_sit_drinker_idle;
	level.scr_anim["generic"]["london_civ_idle_lookover"] = %london_civ_idle_lookover;
	level.scr_anim["generic"]["london_civ_idle_checkwatch"] = %london_civ_idle_checkwatch;
	level.scr_anim["generic"]["london_civ_idle_lookbehind"] = %london_civ_idle_lookbehind;
	level.scr_anim["generic"]["london_civ_idle_sneeze"] = %london_civ_idle_sneeze;
	level.scr_anim["generic"]["london_civ_idle_scratchnose"] = %london_civ_idle_scratchnose;
	level.scr_anim["generic"]["london_civ_idle_foldarms_scratchass"] = %london_civ_idle_foldarms_scratchass;
	level.scr_anim["generic"]["london_civ_idle_foldarms2"] = %london_civ_idle_foldarms2;
	level.randomidleanims = [];
	level.randomidleanims[0] = "london_civ_idle_lookover";
	level.randomidleanims[1] = "london_civ_idle_checkwatch";
	level.randomidleanims[2] = "london_civ_idle_lookbehind";
	level.randomidleanims[3] = "london_civ_idle_sneeze";
	level.randomidleanims[4] = "london_civ_idle_foldarms_scratchass";
	level.randomidleanims[5] = "london_civ_idle_foldarms2";
	level.randomidleanims[6] = "london_civ_idle_scratchnose";
	var_00 = [];
	var_00[0] = 2;
	var_00[1] = 1;
	var_00[2] = 1;
	var_00[3] = 1;
	level.scr_anim["civilian_crazy_walk"]["run_noncombat"][0] = %civilian_crazywalker_loop;
	level.scr_anim["civilian_crazy_walk"]["run_noncombat"][1] = %civilian_crazywalker_twitcha;
	level.scr_anim["civilian_crazy_walk"]["run_noncombat"][2] = %civilian_crazywalker_twitchb;
	level.scr_anim["civilian_crazy_walk"]["run_noncombat"][3] = %civilian_crazywalker_twitchc;
	level.scr_anim["civilian_crazy_walk"]["run_weights"] = var_00;
	var_01 = [];
	var_01[0] = 7;
	var_01[1] = 3;
	var_02 = common_scripts\utility::get_cumulative_weights(var_01);
	level.scr_anim["civilian_cellphone_walk"]["run_noncombat"][0] = %civilian_cellphonewalk;
	level.scr_anim["civilian_cellphone_walk"]["dodge_left"] = %civilian_cellphonewalk_dodge_l;
	level.scr_anim["civilian_cellphone_walk"]["dodge_right"] = %civilian_cellphonewalk_dodge_r;
	level.scr_anim["civilian_cellphone_walk"]["turn_left_90"] = %civilian_cellphonewalk_turn_l;
	level.scr_anim["civilian_cellphone_walk"]["turn_right_90"] = %civilian_cellphonewalk_turn_r;
	level.scr_anim["civilian_soda_walk"]["run_noncombat"][0] = %civilian_sodawalk;
	level.scr_anim["civilian_soda_walk"]["run_noncombat"][1] = %civilian_sodawalk_twitch;
	level.scr_anim["civilian_soda_walk"]["run_weights"] = var_02;
	level.scr_anim["civilian_hurried_walk"]["run_noncombat"][0] = %civilian_walk_hurried_1;
	level.scr_anim["civilian_hurried_walk"]["run_noncombat"][1] = %civilian_walk_hurried_2;
	level.scr_anim["civilian_nervous_walk"]["run_noncombat"][0] = %civilian_walk_nervous;
	level.scr_anim["civilian_cool_walk"]["run_noncombat"][0] = %civilian_walk_cool;
	level.scr_anim["civilian_paper_walk"]["run_noncombat"][0] = %civilian_walk_paper;
	level.scr_anim["civilian_coffee_walk"]["run_noncombat"][0] = %civilian_walk_coffee;
	level.scr_anim["civilian_backpack_walk"]["run_noncombat"][0] = %civilian_walk_backpack;
	level.scr_anim["civilian_backpack_walk"]["run_noncombat"][1] = %civilian_walk_backpack_twitch;
	level.scr_anim["civilian_backpack_walk"]["run_weights"] = var_02;
	level.scr_anim["civilian_pda_walk"]["run_noncombat"][0] = %civilian_walk_pda;
	level.scr_anim["civilian_briefcase_walk"]["run_noncombat"][0] = %civilian_briefcase_walk;
	level.scr_anim["civilian_briefcase_walk"]["dodge_left"] = %civilian_briefcase_walk_dodge_l;
	level.scr_anim["civilian_briefcase_walk"]["dodge_right"] = %civilian_briefcase_walk_dodge_r;
	level.scr_anim["civilian_briefcase_walk"]["turn_left_90"] = %civilian_briefcase_walk_turn_l;
	level.scr_anim["civilian_briefcase_walk"]["turn_right_90"] = %civilian_briefcase_walk_turn_r;
	level.scr_anim["generic"]["civ_idle_panic_1"][0] = %hijack_president_idle_panic_fidget_1;
	level.scr_anim["generic"]["civ_idle_panic_2"][0] = %casual_crouch_v2_idle;
	level.scr_anim["generic"]["civ_idle_panic_3"][0] = %unarmed_cowercrouch_idle_duck;
	level.scr_anim["generic"]["civ_idle_panic_4"][0] = %unarmed_crouch_idle1;
	level.scr_anim["generic"]["civ_idle_panic_5"][0] = %unarmed_crouch_twitch1;
	level.scr_anim["civilian_react"]["civ_idle_panic_1"][0] = %hijack_president_idle_panic_fidget_1;
	level.scr_anim["civilian_react"]["civ_idle_panic_2"][0] = %casual_crouch_v2_idle;
	level.scr_anim["civilian_react"]["civ_idle_panic_3"][0] = %unarmed_cowercrouch_idle_duck;
	level.scr_anim["civilian_react"]["civ_idle_panic_4"][0] = %unarmed_crouch_idle1;
	level.scr_anim["civilian_react"]["civ_idle_panic_5"][0] = %unarmed_crouch_twitch1;
	level.scr_anim["civilian_react_move_back"]["civ_move_back_panic_1"] = %unarmed_cowerstand_react;
	level.scr_anim["civilian_react_move_back"]["civ_move_back_panic_2"] = %unarmed_cowercrouch_react_a;
	level.scr_anim["civilian_react_move_back"]["civ_move_back_panic_3"] = %unarmed_cowercrouch_react_b;
	level.scr_anim["civilian_react_move_back"]["civ_move_back_panic_5"] = %unarmed_cowerstand_react_2_crouch;
	level.scr_anim["civilian_react_then_run"]["civ_react_run_1"] = %london_station_civ1_reaction;
	level.scr_anim["civilian_react_then_run"]["civ_react_run_2"] = %london_station_civ2_reaction;
	level.scr_anim["civilian_react_then_run"]["civ_react_run_3"] = %london_station_civ4_reaction;
	level.scr_anim["civilian_react_then_run"]["civ_react_run_4"] = %london_station_civ6_reaction;
	level.scr_anim["civilian_react_then_run"]["civ_react_run_5"] = %london_station_civ7_reaction;
	level.scr_anim["civilian_run"]["civ_run_panic_1"][0] = %unarmed_panickedrun_stumble;
	level.scr_anim["civilian_run"]["civ_run_panic_2"][0] = %unarmed_panickedrun_loop_v2;
	level.scr_anim["civilian_run"]["civ_run_panic_3"][0] = %civilian_run_hunched_a;
	level.scr_anim["civilian_run"]["civ_run_panic_4"][0] = %civilian_run_hunched_c;
	level.scr_anim["civilian_run"]["civ_run_panic_5"][0] = %civilian_run_hunched_flinch;
	level.scr_anim["civilian_run"]["civ_run_panic_6"][0] = %unarmed_scared_run;
	level.scr_anim["civilian_run"]["civ_run_panic_7"][0] = %lag_roundabout_frantic_run;
	level.scr_anim["civilian_run"]["civ_run_panic_8"][0] = %lag_roundabout_run2cover_run;
	level.scr_anim["sedan_driver"]["run_01"][0] = %sf_a_civillian_pedestrian_run_exit_01;
	level.scr_anim["sedan_driver"]["run_02"][0] = %sf_a_civillian_pedestrian_run_exit_02;
	level.scr_anim["sedan_driver"]["run_03"][0] = %sf_a_civillian_pedestrian_run_exit_03;
	level.scr_anim["sedan_driver"]["run_04"][0] = %sf_a_civillian_pedestrian_run_exit_04;
	level.scr_anim["sedan_driver"]["run_05"][0] = %sf_a_civillian_pedestrian_run_exit_05;
	level.scr_anim["sedan_driver"]["run_06"][0] = %sf_a_civillian_pedestrian_run_exit_06;
	level.scr_anim["sedan_driver"]["run_07"][0] = %sf_a_civillian_pedestrian_run_exit_07;
	level.scr_anim["compact_driver"]["run_01"][0] = %sf_a_civillian_pedestrian_run_exit_01;
	level.scr_anim["compact_driver"]["run_02"][0] = %sf_a_civillian_pedestrian_run_exit_02;
	level.scr_anim["compact_driver"]["run_03"][0] = %sf_a_civillian_pedestrian_run_exit_03;
	level.scr_anim["compact_driver"]["run_04"][0] = %sf_a_civillian_pedestrian_run_exit_04;
	level.scr_anim["compact_driver"]["run_05"][0] = %sf_a_civillian_pedestrian_run_exit_05;
	level.scr_anim["compact_driver"]["run_06"][0] = %sf_a_civillian_pedestrian_run_exit_06;
	level.scr_anim["compact_driver"]["run_07"][0] = %sf_a_civillian_pedestrian_run_exit_07;
	level.scr_anim["truck_driver"]["run_01"][0] = %sf_a_civillian_pedestrian_run_exit_01;
	level.scr_anim["truck_driver"]["run_02"][0] = %sf_a_civillian_pedestrian_run_exit_02;
	level.scr_anim["truck_driver"]["run_03"][0] = %sf_a_civillian_pedestrian_run_exit_03;
	level.scr_anim["truck_driver"]["run_04"][0] = %sf_a_civillian_pedestrian_run_exit_04;
	level.scr_anim["truck_driver"]["run_05"][0] = %sf_a_civillian_pedestrian_run_exit_05;
	level.scr_anim["truck_driver"]["run_06"][0] = %sf_a_civillian_pedestrian_run_exit_06;
	level.scr_anim["truck_driver"]["run_07"][0] = %sf_a_civillian_pedestrian_run_exit_07;
	level.scr_anim["drone"]["run_01"][0] = %sf_a_civillian_pedestrian_run_exit_01_relative;
	level.scr_anim["drone"]["run_02"][0] = %sf_a_civillian_pedestrian_run_exit_02_relative;
	level.scr_anim["drone"]["run_03"][0] = %sf_a_civillian_pedestrian_run_exit_03_relative;
	level.scr_anim["drone"]["run_04"][0] = %sf_a_civillian_pedestrian_run_exit_04_relative;
	level.scr_anim["drone"]["run_05"][0] = %sf_a_civillian_pedestrian_run_exit_05_relative;
	level.scr_anim["drone"]["run_06"][0] = %sf_a_civillian_pedestrian_run_exit_06_relative;
	level.scr_anim["drone"]["run_07"][0] = %sf_a_civillian_pedestrian_run_exit_07_relative;
	level.scr_anim["sedan_driver"]["loop_01"][0] = %sf_a_civillian_civ_sedan_loop_01;
	level.scr_anim["sedan_driver"]["loop_02"][0] = %sf_a_civillian_civ_sedan_loop_02;
	level.scr_anim["sedan_driver"]["loop_03"][0] = %sf_a_civillian_civ_sedan_loop_03;
	level.scr_anim["sedan_driver"]["loop_04"][0] = %sf_a_civillian_civ_sedan_loop_04;
	level.scr_anim["sedan_driver"]["loop_05"][0] = %sf_a_civillian_civ_sedan_loop_05;
	level.scr_anim["sedan_driver"]["loop_06"][0] = %sf_a_civillian_civ_sedan_loop_06;
	level.scr_anim["sedan_driver"]["loop_07"][0] = %sf_a_civillian_civ_sedan_loop_07;
	level.scr_anim["sedan_driver"]["get_out_01"] = %sf_a_civillian_civ_sedan_exit_03;
	level.scr_anim["sedan_driver"]["get_out_02"] = %sf_a_civillian_civ_sedan_exit_04;
	level.scr_anim["sedan_driver"]["get_out_03"] = %sf_a_civillian_civ_sedan_exit_06;
	level.scr_anim["compact_driver"]["loop_01"][0] = %sf_a_civillian_compactcar_loop_01;
	level.scr_anim["compact_driver"]["loop_02"][0] = %sf_a_civillian_compactcar_loop_02;
	level.scr_anim["compact_driver"]["loop_03"][0] = %sf_a_civillian_compactcar_loop_03;
	level.scr_anim["compact_driver"]["loop_04"][0] = %sf_a_civillian_compactcar_loop_04;
	level.scr_anim["compact_driver"]["loop_05"][0] = %sf_a_civillian_compactcar_loop_05;
	level.scr_anim["compact_driver"]["loop_06"][0] = %sf_a_civillian_compactcar_loop_06;
	level.scr_anim["compact_driver"]["loop_07"][0] = %sf_a_civillian_compactcar_loop_07;
	level.scr_anim["compact_driver"]["get_out_01"] = %sf_a_civillian_compactcar_exit_03;
	level.scr_anim["compact_driver"]["get_out_02"] = %sf_a_civillian_compactcar_exit_04;
	level.scr_anim["compact_driver"]["get_out_03"] = %sf_a_civillian_compactcar_exit_06;
	level.scr_anim["truck_driver"]["loop_01"][0] = %sf_a_civillian_civ_truck_loop_01;
	level.scr_anim["truck_driver"]["loop_02"][0] = %sf_a_civillian_civ_truck_loop_02;
	level.scr_anim["truck_driver"]["loop_03"][0] = %sf_a_civillian_civ_truck_loop_03;
	level.scr_anim["truck_driver"]["loop_04"][0] = %sf_a_civillian_civ_truck_loop_04;
	level.scr_anim["truck_driver"]["loop_05"][0] = %sf_a_civillian_civ_truck_loop_05;
	level.scr_anim["truck_driver"]["loop_06"][0] = %sf_a_civillian_civ_truck_loop_06;
	level.scr_anim["truck_driver"]["loop_07"][0] = %sf_a_civillian_civ_truck_loop_07;
	level.scr_anim["truck_driver"]["get_out_01"] = %sf_a_civillian_civ_truck_exit_03;
	level.scr_anim["truck_driver"]["get_out_02"] = %sf_a_civillian_civ_truck_exit_04;
	level.scr_anim["truck_driver"]["get_out_03"] = %sf_a_civillian_civ_truck_exit_06;
	level.scr_anim["civilian"]["laying_1"][0] = %sf_a_civ_injured_laying_agony_a;
	level.scr_anim["civilian"]["laying_2"][0] = %sf_a_civ_injured_laying_agony_b;
	level.scr_anim["civilian"]["seated_1"][0] = %sf_a_civ_injured_seated_crying;
	level.scr_anim["civilian"]["seated_2"][0] = %sf_a_civ_injured_seated_face;
	level.scr_anim["civilian"]["seated_3"][0] = %sf_a_civ_injured_seated_neck;
	level.scr_anim["civilian"]["paired_1"][0] = %sf_a_civ_injured_seated_mourned;
	level.scr_anim["civilian_b"]["paired_1"][0] = %sf_a_civ_injured_seated_mourner;
	level.scr_anim["civilian"]["paired_2"][0] = %sf_a_civ_injured_seated_helped;
	level.scr_anim["civilian_b"]["paired_2"][0] = %sf_a_civ_injured_seated_helper;
	level.scr_anim["lobby_elevator"]["waiting_react_1_pre"][0] = %lag_lobby_waiting_elevator_loop_guy1;
	level.scr_anim["lobby_elevator"]["waiting_react_2_pre"][0] = %lag_lobby_waiting_elevator_loop_guy2;
	level.scr_anim["lobby_elevator"]["waiting_react_1"] = %lag_lobby_waiting_elevator_react_guy1;
	level.scr_anim["lobby_elevator"]["waiting_react_2"] = %lag_lobby_waiting_elevator_react_guy2;
	level.scr_anim["lobby_elevator"]["waiting_react_loop_1"][0] = %lag_lobby_waiting_elevator_react_loop_guy1;
	level.scr_anim["lobby_elevator"]["waiting_react_loop_2"][0] = %lag_lobby_waiting_elevator_react_loop_guy2;
	level.scr_anim["lobby_elevator"]["exiting_react_1"] = %lag_lobby_exit_elevator_react_guy1;
	level.scr_anim["lobby_elevator"]["exiting_react_2"] = %lag_lobby_exit_elevator_react_guy2;
	level.scr_anim["lobby_elevator"]["exiting_react_loop_1"][0] = %lag_lobby_exit_elevator_react_loop_guy1;
	level.scr_anim["lobby_elevator"]["exiting_react_loop_2"][0] = %lag_lobby_exit_elevator_react_loop_guy2;
	level.scr_anim["lobby_couch"]["couch_loop_1"][0] = %lag_lobby_sitting_loop_guy1;
	level.scr_anim["lobby_couch"]["couch_loop_2"][0] = %lag_lobby_sitting_loop_guy2;
	level.scr_anim["lobby_couch"]["couch_react_1"] = %lag_lobby_sitting_react_guy1;
	level.scr_anim["lobby_couch"]["couch_react_2"] = %lag_lobby_sitting_react_guy2;
	level.scr_anim["lobby_couch"]["couch_react_1_short"] = %lag_lobby_sitting_react_guy1_short;
	level.scr_anim["lobby_couch"]["couch_react_2_short"] = %lag_lobby_sitting_react_guy2_short;
	level.scr_anim["lobby_security"]["security_loop_1"][0] = %lag_lobby_securityguard_loop_guy1;
	level.scr_anim["lobby_security"]["security_loop_2"][0] = %lag_lobby_securityguard_loop_guy2;
	level.scr_anim["lobby_security"]["security_react_1"] = %lag_lobby_securityguard_react_guy1;
	level.scr_anim["lobby_security"]["security_react_2"] = %lag_lobby_securityguard_react_guy2;
	level.scr_anim["lobby_security"]["security_react_loop_1"][0] = %lag_lobby_securityguard_react_loop_guy1;
	level.scr_anim["lobby_security"]["security_react_loop_2"] = %lag_lobby_securityguard_react_loop_guy2;
	level.scr_anim["lobby_phone"]["phone_loop_1"][0] = %lag_lobby_phone_loop_guy1;
	level.scr_anim["lobby_phone"]["phone_react_1"] = %lag_lobby_phone_react_guy1;
	level.scr_anim["lobby_phone"]["phone_react_2"] = %lag_lobby_phone_react_guy2;
	level.scr_anim["lobby_phone"]["phone_react_loop_1"][0] = %lag_lobby_phone_react_loop_guy1;
	level.scr_anim["lobby_walktalk"]["walktalk_react_1"] = %lag_lobby_walkingtalk_react_guy1;
	level.scr_anim["lobby_walktalk"]["walktalk_react_2"] = %lag_lobby_walkingtalk_react_guy2;
	level.scr_anim["street_drop_bike"]["drop_bike_loop_1"][0] = %lag_roundabout_civ_dropbike_loop_guy1;
	level.scr_anim["street_drop_bike"]["drop_bike_loop_2"][0] = %lag_roundabout_civ_dropbike_loop_guy2;
	level.scr_anim["street_drop_bike"]["drop_bike_react_1"] = %lag_roundabout_civ_dropbike_react_guy1;
	level.scr_anim["street_drop_bike"]["drop_bike_react_2"] = %lag_roundabout_civ_dropbike_react_guy2;
	level.scr_anim["burke"]["burke_car_hood"] = %lag_roundabout_out_of_car_guy1;
	level.scr_anim["car_hood"]["guy_exit_car"] = %lag_roundabout_out_of_car_guy2;
	level.scr_anim["car_hood"]["guy_help_injured"] = %lag_roundabout_out_of_car_guy3;
}

//Function Number: 16
exo_door_enable_weapons(param_00)
{
	level.player enableweapons();
}

//Function Number: 17
vehicle_impact_rumble(param_00)
{
	level.player playrumbleonentity("artillery_rumble");
}