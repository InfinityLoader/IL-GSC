/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lab_anim.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 411 ms
 * Timestamp: 4/22/2024 2:32:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = "none";
	if(level.currentgen)
	{
		if(istransientloaded("lab_intro_tr"))
		{
			var_00 = "intro";
		}
		else if(istransientloaded("lab_middle_tr"))
		{
			var_00 = "middle";
		}
		else if(istransientloaded("lab_outro_tr"))
		{
			var_00 = "outro";
		}
	}

	if(level.nextgen)
	{
		anim.forced_s1_motionset = 1;
	}

	player_anims(var_00);
	npc_anims(var_00);
	breach_anims(var_00);
	vehicles_anims(var_00);
	prop_anims(var_00);
	animal_anims(var_00);
	if(level.currentgen)
	{
		if(var_00 == "intro")
		{
			thread notetrack_setup_middle();
		}

		if(var_00 == "intro" || var_00 == "middle")
		{
			thread notetrack_setup_outro();
		}
	}
}

//Function Number: 2
player_anims(param_00)
{
	level.scr_animtree["player_rig"] = #animtree;
	level.scr_model["player_rig"] = "viewbody_sentinel_covert";
	level.scr_animtree["player_rig_intro"] = #animtree;
	level.scr_model["player_rig_intro"] = "worldhands_player_sentinel";
	level.scr_anim["player_rig_intro"]["intro_recover"] = %lab_intro_vm;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_notify("player_rig_intro","allow_player_control","allow_player_control","intro_recover");
	}

	level.scr_anim["player_rig"]["player_hill_slide"] = %lab_unarmed_hillslide_vm;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_notify("player_rig","allow_player_control","allow_player_control","player_hill_slide");
		maps\_anim::addnotetrack_customfunction("player_rig","vfx_foot_dust",::maps\lab_fx::hillslide_dust_fx,"player_hill_slide");
	}

	level.scr_anim["player_rig"]["player_wall_climb_1"] = %lab_wallclimb_player_1_vm;
	level.scr_anim["player_rig"]["player_wall_climb_2"] = %lab_wallclimb_player_2_vm;
	level.scr_anim["player_rig"]["player_wall_climb_3"] = %lab_wallclimb_player_3_vm;
	level.scr_anim["player_rig"]["player_wall_climb_4"] = %lab_wallclimb_player_4_vm;
	level.scr_anim["player_rig"]["player_wall_climb_5"] = %lab_wallclimb_player_5_vm;
	level.scr_anim["player_rig"]["player_wall_climb_loop"][0] = %lab_wallclimb_player_loop_vm;
	level.scr_anim["player_rig"]["player_wall_climb_lastjump"] = %lab_wallclimb_player_lastjump_vm;
	level.scr_anim["player_rig"]["player_wall_climb_end"] = %lab_wallclimb_player_end_vm;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_flag("player_rig","start_burke","flag_burke_says_exo_is_on","player_wall_climb_5");
		maps\_anim::addnotetrack_flag("player_rig","look_at_spotlight","flag_player_wall_look_right","player_wall_climb_5");
		maps\_anim::addnotetrack_flag_clear("player_rig","reset_spotlight","flag_player_wall_look_right","player_wall_climb_5");
		maps\_anim::addnotetrack_customfunction("player_rig","fov_54.75",::player_fov_54,"player_wall_climb_5");
		maps\_anim::addnotetrack_customfunction("player_rig","exo_power_on",::player_exo_power_on,"player_wall_climb_5");
		maps\_anim::addnotetrack_customfunction("player_rig","fov_65",::player_fov_65,"player_wall_climb_end");
		maps\_anim::addnotetrack_customfunction("player_rig","exo_cloak_on",::player_exo_cloak_on_wallclimb,"player_wall_climb_lastjump");
	}

	level.scr_anim["player_rig"]["forest_disarm"] = %lab_forest_disarm_vm;
	level.scr_anim["player_rig"]["vrap_mute"] = %lab_takedown_2_plantmute_vm;
	level.scr_anim["player_rig"]["vrap_takedown"] = %lab_takedown_2_vm;
	level.scr_anim["player_rig"]["cliff_jump"] = %lab_cliff_rappel_jump_vm;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_customfunction("player_rig","player_input_start",::set_flag_rappel_player_input_start,"cliff_jump");
		maps\_anim::addnotetrack_customfunction("player_rig","player_input_stop",::set_flag_rappel_player_input_stop,"cliff_jump");
	}

	level.scr_anim["player_rig"]["server_room_exit"] = %lab_serverroom_vm;
	level.scr_anim["player_rig"]["server_room_exit_promo"] = %lab_serverroom_promo_vm;
	if(level.nextgen || param_00 == "middle")
	{
		maps\_anim::addnotetrack_customfunction("player_rig","fov_start",::cormack_fov_start,"server_room_exit_promo");
		maps\_anim::addnotetrack_customfunction("player_rig","fov_end",::cormack_fov_end,"server_room_exit_promo");
	}

	level.scr_anim["player_rig_intro"]["foam_room"] = %lab_plant_foambomb_vm;
	level.scr_anim["player_rig_intro"]["jammerplant_1"] = %lab_courtyard_jammerplant_vm;
	level.scr_anim["player_rig"]["hovertank_enter"] = %lab_htank_vm_enter_vm;
	if(level.nextgen || param_00 == "outro")
	{
		maps\_anim::addnotetrack_notify("player_rig","start_npcs","hovertank_enter_start_npcs","hovertank_enter");
		maps\_anim::addnotetrack_customfunction("player_rig","FOV_to_75",::transition_to_hovertank_fov,"hovertank_enter");
	}

	level.scr_anim["player_rig"]["hovertank_exit"] = %lab_htank_exit_vm;
	if(level.nextgen || param_00 == "outro")
	{
		maps\_anim::addnotetrack_customfunction("player_rig","start_razorback",::maps\lab_code::se_exfil_razorback,"hovertank_exit");
	}

	level.scr_anim["player_rig_intro"]["exfil_enter"] = %lab_chopper_evac_enter_vm;
}

//Function Number: 3
npc_anims(param_00)
{
	level.scr_anim["generic"]["DRS_sprint"] = %sprint1_loop;
	level.scr_anim["burke"]["intro_recover"] = %lab_intro_guy1;
	level.scr_anim["burke"]["burke_intro_react"] = %unarmed_run_pain_right_a;
	level.scr_anim["burke"]["lab_shack_enter"] = %lab_shack_react_in;
	level.scr_anim["burke"]["lab_shack_idle"][0] = %lab_shack_react_idle;
	level.scr_anim["burke"]["lab_shack_exit"] = %lab_shack_react_out;
	level.scr_anim["burke"]["burke_stumble_run"] = %unarmed_run_pain_fall;
	level.scr_anim["burke"]["burke_dive_over_log"] = %lab_log_leap_into_run;
	level.scr_anim["burke"]["burke_tree_cover_01"] = %lab_unarmed_covercrouch_tree_arrive_a;
	level.scr_anim["burke"]["burke_tree_cover_01_idle"][0] = %lab_unarmed_covercrouch_tree_idle_a;
	level.scr_anim["burke"]["burke_tree_cover_01_exit"] = %lab_unarmed_covercrouch_tree_exit_a;
	level.scr_anim["burke"]["burke_hill_slide"] = %lab_log_leap_into_slide;
	level.scr_anim["burke"]["burke_hill_slide_alt"] = %lab_log_leap_into_slide_alt;
	level.scr_anim["burke"]["burke_hill_slide_stump"] = %lab_unarmed_covercrouch_tree_arrive_b;
	level.scr_anim["burke"]["burke_hill_slide_stump_idle"][0] = %lab_unarmed_covercrouch_tree_idle_b;
	level.scr_anim["burke"]["burke_hill_slide_stump_exit"] = %lab_unarmed_covercrouch_tree_exit_b;
	level.scr_anim["burke"]["burke_river_over_log"] = %lab_log_leap_into_cover;
	level.scr_anim["burke"]["burke_river_cross"] = %lab_river_cross_burke;
	level.scr_anim["burke"]["burke_river_to_tree"] = %lab_river_cross_to_tree_burke;
	level.scr_anim["burke"]["burke_tree_to_wall"] = %lab_tree_to_wall_burke;
	level.scr_anim["burke"]["burke_river_to_wall"] = %lab_river_cross_to_wall_burke;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_customfunction("burke","vfx_entry_splash",::maps\lab_fx::burke_river_entry_splash_fx,"burke_river_cross");
		maps\_anim::addnotetrack_customfunction("burke","vfx_looping_splashes",::maps\lab_fx::burke_river_looping_splash_fx,"burke_river_cross");
	}

	level.scr_anim["burke"]["burke_forest_cover_tree_wave"][0] = %lab_unarmed_covercrouch_tree_idle_c;
	level.scr_anim["burke"]["burke_wall_climb"] = %lab_wallclimb_burke_hero_01;
	level.scr_anim["burke"]["burke_wall_climb_loop"][0] = %lab_wallclimb_burke_loop;
	level.scr_anim["burke"]["burke_says_exo_is_on"] = %lab_wallclimb_player_hero_01;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_customfunction("burke","burke_teleport",::maps\lab_code::burke_wall_climb_teleport,"burke_says_exo_is_on");
		maps\_anim::addnotetrack_customfunction("burke","exo_cloak_on",::burke_exo_cloak_on,"burke_says_exo_is_on");
	}

	level.scr_anim["burke"]["burke_search_drone_idle"][0] = %lab_unarmed_walltop_crouch_idle_hero_01;
	level.scr_anim["burke"]["burke_search_drone"] = %lab_unarmed_dive_hero_01;
	level.scr_anim["burke"]["forest_disarm_arrive"] = %lab_unarmed_covercrouch_tree_arrive_d;
	level.scr_anim["burke"]["forest_disarm_idle"][0] = %lab_unarmed_covercrouch_tree_idle_d;
	level.scr_anim["burke"]["forest_disarm"] = %lab_forest_disarm_hero_01;
	level.scr_anim["disarm_guy_1"]["forest_disarm"] = %lab_forest_disarm_guy_01;
	level.scr_anim["disarm_guy_2"]["forest_disarm"] = %lab_forest_disarm_guy_02;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_customfunction("disarm_guy_1","head_hits_tree",::swap_tree,"forest_disarm");
		maps\_anim::addnotetrack_customfunction("disarm_guy_1","start_ragdoll",::ai_kill,"forest_disarm");
	}

	level.scr_anim["burke"]["forest_takedown_02"] = %lab_knife_takedown_hero_01;
	level.scr_anim["guy"]["forest_takedown_02_loser_enter"] = %lab_knife_takedown_guy_01_enter;
	level.scr_anim["guy"]["forest_takedown_02_loser_idle"][0] = %lab_knife_takedown_guy_01_idle;
	level.scr_anim["guy"]["forest_takedown_02_loser"] = %lab_knife_takedown_guy_01;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_notify("burke","stab","forest_takedown_02_guy_stabbed","forest_takedown_02");
		maps\_anim::addnotetrack_customfunction("guy","flashlight_hide",::maps\_flashlight_cheap::cheap_flashlight_hide,"forest_takedown_02_loser");
	}

	level.scr_anim["burke"]["cornercrouch_left_cloak_toggle"] = %cornercrouch_left_cloak_toggle;
	level.scr_anim["burke"]["cornercrouch_right_cloak_toggle"] = %cornercrouch_right_cloak_toggle;
	level.scr_anim["burke"]["crouch_exposed_cloak_toggle"] = %crouch_exposed_cloak_toggle;
	maps\_anim::addnotetrack_customfunction("burke","cloak_toggle",::maps\lab_utility::ai_toggle_cloak,"cornercrouch_left_cloak_toggle");
	maps\_anim::addnotetrack_customfunction("burke","cloak_toggle",::maps\lab_utility::ai_toggle_cloak,"cornercrouch_right_cloak_toggle");
	maps\_anim::addnotetrack_customfunction("burke","cloak_toggle",::maps\lab_utility::ai_toggle_cloak,"crouch_exposed_cloak_toggle");
	level.scr_anim["burke"]["vrap_takedown"] = %lab_takedown_2_hero_01;
	level.scr_anim["vrap_guy_1"]["vrap_takedown_idle"][0] = %lab_takedown_2_guy_01_idle;
	level.scr_anim["vrap_guy_2"]["vrap_takedown_idle"] = %lab_takedown_2_guy_02_idle;
	level.scr_anim["vrap_guy_1"]["vrap_takedown"] = %lab_takedown_2_guy_01;
	level.scr_anim["vrap_guy_2"]["vrap_takedown"] = %lab_takedown_2_guy_02;
	level.scr_anim["vrap_guy_1"]["vrap_takedown_fail"] = %lab_takedown_2_guy_01_fail;
	level.scr_anim["vrap_guy_2"]["vrap_takedown_fail"] = %mil_humvee_vrap_driver_out;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_customfunction("burke","vehicle_lights_off",::maps\lab_lighting::vrap_takedown_lights_off,"vrap_takedown");
		maps\_anim::addnotetrack_customfunction("vrap_guy_1","start_ragdoll",::ai_kill,"vrap_takedown");
	}

	level.scr_anim["cormack"]["cliff_meetup_idle"][0] = %lab_cliff_rappel_meetup_idle_cormack;
	level.scr_anim["knox"]["cliff_meetup_idle"][0] = %lab_cliff_rappel_meetup_idle_knox;
	level.scr_anim["burke"]["cliff_meetup"] = %lab_cliff_rappel_meetup_burke;
	level.scr_anim["cormack"]["cliff_meetup"] = %lab_cliff_rappel_meetup_cormack;
	level.scr_anim["knox"]["cliff_meetup"] = %lab_cliff_rappel_meetup_knox;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_customfunction("cormack","cloak_off",::cloak_off,"cliff_meetup");
		maps\_anim::addnotetrack_customfunction("knox","cloak_off",::cloak_off,"cliff_meetup");
		maps\_anim::addnotetrack_customfunction("knox","rappel_pip",::maps\lab_code::play_rappel_pip,"cliff_meetup");
	}

	level.scr_anim["burke"]["cliff_meetup_rappel_idle"][0] = %lab_cliff_rappel_idle_burke;
	level.scr_anim["burke"]["cliff_jump"] = %lab_cliff_rappel_jump_burke;
	level.scr_anim["knox"]["knox_meet_idle"][0] = %casual_crouch_v2_idle;
	level.scr_anim["guy_1"]["se_breach_patrol_guy_01"] = %lab_breachroom_hazmat_walk_guy1;
	level.scr_anim["guy_2"]["se_breach_patrol_guy_02"] = %lab_breachroom_hazmat_walk_guy2;
	level.scr_anim["guy_1"]["breach_duards_idle"][0] = %lab_breachroom_talking_patrol_guy1;
	level.scr_anim["guy_2"]["breach_duards_idle"][0] = %lab_breachroom_talking_patrol_guy2;
	level.scr_anim["burke"]["server_room_entry_intro"] = %lab_serverroom_entry_intro_guy1;
	level.scr_anim["cormack"]["server_room_entry_intro"] = %lab_serverroom_entry_intro_guy2;
	level.scr_anim["knox"]["server_room_entry_intro"] = %lab_serverroom_entry_intro_guy3;
	level.scr_anim["burke"]["server_room_door_idle"][0] = %lab_serverroom_entry_loop_guy1;
	level.scr_anim["cormack"]["server_room_door_idle"][0] = %lab_serverroom_entry_loop_guy2;
	level.scr_anim["knox"]["server_room_door_idle"][0] = %lab_serverroom_entry_loop_guy3;
	level.scr_anim["guy_01_server_room"]["server_room_door_idle"][0] = %lab_serverroom_entry_loop_guy4;
	level.scr_anim["burke"]["server_room_peek"] = %lab_serverroom_entry_doorpeek_guy1;
	level.scr_anim["cormack"]["server_room_peek"] = %lab_serverroom_entry_doorpeek_guy2;
	level.scr_anim["knox"]["server_room_peek"] = %lab_serverroom_entry_doorpeek_guy3;
	level.scr_anim["burke"]["server_room_enter"] = %lab_serverroom_entry_doorpush_guy1;
	level.scr_anim["cormack"]["server_room_enter"] = %lab_serverroom_entry_doorpush_guy2;
	level.scr_anim["knox"]["server_room_enter"] = %lab_serverroom_entry_doorpush_guy3;
	level.scr_anim["guy_01_server_room"]["server_room_enter"] = %lab_serverroom_entry_death_guy4;
	if(level.nextgen || param_00 == "middle")
	{
		maps\_anim::addnotetrack_customfunction("guy_01_server_room","start_ragdoll",::ai_kill,"server_room_enter");
	}

	level.scr_anim["knox"]["server_room_enter_fail"] = %lab_serverroom_entry_fail_guy3;
	level.scr_anim["guy_01_server_room"]["server_room_enter_fail"] = %lab_serverroom_entry_fail_guy4;
	maps\_anim::addnotetrack_customfunction("knox","fire_gun",::maps\lab_code::server_room_fire_knox_gun,"server_room_enter_fail");
	if(level.nextgen || param_00 == "middle")
	{
		maps\_anim::addnotetrack_customfunction("guy_01_server_room","start_ragdoll",::ai_kill,"server_room_enter_fail");
	}

	level.scr_anim["burke"]["server_room_enter_idle"][0] = %lab_serverroom_loop_guy1;
	level.scr_anim["cormack"]["server_room_enter_idle"][0] = %lab_serverroom_loop_guy2;
	level.scr_anim["knox"]["server_room_enter_idle"][0] = %lab_serverroom_loop_guy3;
	level.scr_anim["burke"]["server_room_exit"] = %lab_serverroom_guy1;
	level.scr_anim["cormack"]["server_room_exit"] = %lab_serverroom_guy2;
	level.scr_anim["knox"]["server_room_exit"] = %lab_serverroom_guy3;
	level.scr_anim["burke"]["server_room_exit_promo"] = %lab_serverroom_promo_guy1;
	level.scr_anim["cormack"]["server_room_exit_promo"] = %lab_serverroom_promo_guy2;
	level.scr_anim["knox"]["server_room_exit_promo"] = %lab_serverroom_promo_guy3;
	if(level.nextgen || param_00 == "middle")
	{
		maps\_anim::addnotetrack_customfunction("cormack","dilate_pupils",::cormack_dilate_pupils,"server_room_exit_promo");
	}

	level.scr_anim["mech"]["courtyard_mech_intro"] = %mech_intro;
	if(level.nextgen || param_00 == "middle")
	{
		maps\_anim::addnotetrack_customfunction("mech","vfx_stomp_land",::maps\lab_fx::mech_intro_land_dust,"courtyard_mech_intro");
	}

	level.scr_anim["knox"]["courtyard_hangar_door_hack_enter"] = %lab_courtyard_hackdoor_guy1_in;
	level.scr_anim["knox"]["courtyard_hangar_door_hack_idle"][0] = %lab_courtyard_hackdoor_guy1_loop;
	level.scr_anim["knox"]["courtyard_hangar_door_hack_exit"] = %lab_courtyard_hackdoor_guy1_out;
	level.scr_anim["knox"]["courtyard_hangar_door_close"] = %crouch_exposed_cloak_toggle;
	level.scr_anim["cormack"]["foam_corridor_in"] = %lab_fb_foamdeploy_guy1_in;
	level.scr_anim["burke"]["foam_corridor_in"] = %lab_fb_foamdeploy_guy2_in;
	level.scr_anim["knox"]["foam_corridor_in"] = %lab_fb_foamdeploy_guy3_in;
	level.scr_anim["cormack"]["foam_corridor_idle"][0] = %lab_fb_foamdeploy_guy1_loop;
	level.scr_anim["burke"]["foam_corridor_idle"][0] = %lab_fb_foamdeploy_guy2_loop;
	level.scr_anim["knox"]["foam_corridor_idle"][0] = %lab_fb_foamdeploy_guy3_loop;
	level.scr_anim["cormack"]["foam_corridor_grenade_throw"] = %lab_fb_foamdeploy_guy1;
	level.scr_anim["burke"]["foam_corridor_grenade_throw"] = %lab_fb_foamdeploy_guy2;
	level.scr_anim["knox"]["foam_corridor_grenade_throw"] = %lab_fb_foamdeploy_guy3;
	level.scr_anim["guy_4"]["foam_corridor_grenade_throw"] = %lab_fb_foamdeploy_guy4;
	level.scr_anim["cormack"]["foam_corridor_idle_2"][0] = %lab_fb_foamdeploy_guy1_loop2;
	level.scr_anim["burke"]["foam_corridor_idle_2"][0] = %lab_fb_foamdeploy_guy2_loop2;
	level.scr_anim["knox"]["foam_corridor_idle_2"][0] = %lab_fb_foamdeploy_guy3_loop2;
	level.scr_anim["cormack"]["foam_corridor_exit"] = %lab_fb_foamdeploy_guy1_out;
	level.scr_anim["burke"]["foam_corridor_exit"] = %lab_fb_foamdeploy_guy2_out;
	level.scr_anim["knox"]["foam_corridor_exit"] = %lab_fb_foamdeploy_guy3_out;
	level.scr_anim["burke"]["hovertank_reveal_approach"] = %lab_htank_reveal_hero_01;
	level.scr_anim["cormack"]["hovertank_reveal_approach"] = %lab_htank_reveal_hero_02;
	level.scr_anim["burke"]["hovertank_reveal_loop"][0] = %lab_htank_reveal_loop_hero_01;
	level.scr_anim["cormack"]["hovertank_reveal_loop"][0] = %lab_htank_reveal_loop_hero_02;
	level.scr_anim["burke"]["hovertank_reveal"] = %lab_htank_enter_hero_01;
	level.scr_anim["cormack"]["hovertank_reveal"] = %lab_htank_enter_hero_02;
	level.scr_anim["knox"]["hovertank_reveal_approach"] = %lab_htank_reveal_hero_03;
	level.scr_anim["knox"]["hovertank_reveal_loop"][0] = %lab_htank_reveal_loop_hero_03;
	level.scr_anim["burke"]["hovertank_enter"] = %lab_htank_vm_enter_hero_01;
	level.scr_anim["cormack"]["hovertank_enter"] = %lab_htank_vm_enter_hero_02;
	level.scr_anim["knox"]["hovertank_enter"] = %lab_htank_vm_enter_hero_03;
	level.scr_anim["burke"]["hovertank_idle"][0] = %lab_htank_idle_hero_01;
	level.scr_anim["cormack"]["hovertank_idle"][0] = %lab_htank_idle_hero_02;
	level.scr_anim["knox"]["hovertank_idle"][0] = %lab_htank_idle_hero_03;
	level.scr_anim["generic"]["prone_dive"] = %hunted_dive_2_pronehide_v1;
	level.scr_anim["generic"]["prone_idle"][0] = %hunted_pronehide_idle_relative;
	level.scr_anim["generic"]["react_stand_2_run_180"] = %react_stand_2_run_180;
	level.scr_anim["generic"]["paris_delta_ceiling_collapse_react_guy1"] = %paris_delta_ceiling_collapse_react_guy1;
	level.scr_anim["generic"]["run_reaction_180"] = %run_reaction_180;
	level.scr_anim["generic"]["payback_escape_rpg_react_price"] = %payback_escape_rpg_react_price;
	level.scr_anim["generic"]["intro_ugv_react"] = %intro_ugv_react;
	level.scr_anim["burke"]["hovertank_exit"] = %lab_htank_exit_hero_01;
	level.scr_anim["cormack"]["hovertank_exit"] = %lab_htank_exit_hero_02;
	level.scr_anim["knox"]["hovertank_exit"] = %lab_htank_exit_hero_03;
	level.scr_anim["guy_exfil_pilot"]["exfil_pilot_idle"][0] = %lab_chopper_evac_idle_pilot;
	level.scr_anim["guy_exfil"]["exfil_fly_in"] = %lab_chopper_evac_intro_npc;
	level.scr_anim["guy_exfil"]["exfil_fly_in_idle"][0] = %lab_chopper_evac_intro_idle_npc;
	level.scr_anim["guy_exfil"]["exfil_burke_enter"] = %lab_chopper_evac_burke_get_on_npc;
	level.scr_anim["guy_exfil"]["exfil_hover_idle"][0] = %lab_chopper_evac_hover_idle_npc;
	level.scr_anim["cormack"]["exfil_cormack_approach"] = %lab_exfil_end_run2idle_cormack;
	level.scr_anim["cormack"]["exfil_cormack_approach_idle"][0] = %lab_exfil_end_idle_cormack;
	level.scr_anim["burke"]["exfil_burke_enter"] = %lab_chopper_evac_burke_get_on_burke;
	level.scr_anim["burke"]["exfil_hover_idle"][0] = %lab_chopper_evac_hover_idle_burke;
	level.scr_anim["burke"]["exfil_enter"] = %lab_chopper_evac_enter_burke;
	level.scr_anim["cormack"]["exfil_enter"] = %lab_chopper_evac_enter_cormack;
	level.scr_anim["guy_exfil"]["exfil_enter"] = %lab_chopper_evac_enter_npc;
	level.scr_anim["knox"]["exfil_enter"] = %lab_exfil_enter_npc2;
	if(level.nextgen || param_00 == "outro")
	{
		maps\_anim::addnotetrack_notify("burke","fade_start","level_fade_out","exfil_enter");
	}

	level.scr_anim["generic"]["patrol_stand_idle"][0] = %patrolstand_idle;
	level.scr_anim["generic"]["patrol_sit_idle"][0] = %sitting_guard_loadak_idle;
	level.scr_anim["generic"]["flashlight_search_high_idle"][0] = %so_hijack_search_flashlight_high_loop;
	level.scr_anim["generic"]["flashlight_search_low_idle"][0] = %so_hijack_search_flashlight_low_loop;
	level.scr_anim["generic"]["phone_idle"][0] = %patrol_bored_idle_cellphone;
	level.scr_anim["generic"]["phone_react"] = %patrol_bored_react_look_retreat;
}

//Function Number: 4
breach_anims(param_00)
{
	level.breach_death_anims = [];
	level.scr_anim["generic"]["breach_chair_hide_reaction_v1_death"] = %covercrouch_death_1;
	level.scr_anim["generic"]["breach_chair_hide_reaction_v1_death2"] = %covercrouch_death_2;
}

//Function Number: 5
vehicles_anims(param_00)
{
	level.scr_anim["spotlight_helo"]["player_wall_climb"] = %lab_wallclimb_player_littlebird;
	level.scr_anim["spotlight_helo"]["player_wall_climb_loop"][0] = %lab_wallclimb_player_loop_littlebird;
	level.scr_anim["spotlight_helo"]["player_wall_climb_end"] = %lab_wallclimb_player_end_littlebird;
	level.scr_anim["search_drone"]["search_drone"] = %lab_unarmed_dive_drone;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_customfunction("search_drone","droneturn",::maps\lab_fx::drone_deer_spot_light,"search_drone");
	}

	level.scr_animtree["razorback"] = #animtree;
	level.scr_anim["razorback"]["exfil_fly_in"] = %lab_chopper_evac_intro_razorback;
	if(level.nextgen || param_00 == "outro")
	{
		maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_front_on",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_on,"exfil_fly_in");
		maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_back_on",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_back_on,"exfil_fly_in");
		maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_front_off",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_off,"exfil_fly_in");
		maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_back_off",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_back_off,"exfil_fly_in");
	}

	level.scr_anim["razorback"]["exfil_fly_in_idle"][0] = %lab_chopper_evac_intro_idle_razorback;
	level.scr_anim["razorback"]["exfil_burke_enter"] = %lab_chopper_evac_burke_get_on_razorback;
	level.scr_anim["razorback"]["exfil_hover_idle"][0] = %lab_chopper_evac_hover_idle_razorback;
	level.scr_anim["razorback"]["exfil_enter"] = %lab_chopper_evac_enter_razorback;
	if(level.nextgen || param_00 == "outro")
	{
		maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_front_on",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_on,"exfil_enter");
		maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_back_on",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_back_on,"exfil_enter");
		maps\_anim::addnotetrack_customfunction("razorback","vfx_htank_explode",::maps\lab_fx::vfx_htank_explosion,"exfil_enter");
	}

	level.scr_anim["vrap"]["vrap_takedown_idle"][0] = %lab_takedown_2_humvee_idle;
	level.scr_anim["vrap"]["vrap_takedown"] = %lab_takedown_2_humvee;
	level.scr_anim["vrap"]["vrap_takedown_fail"] = %mil_humvee_vrap_driver_out_door;
	level.scr_animtree["hovertank"] = #animtree;
	level.scr_model["hovertank"] = "vehicle_mil_hovertank_ai";
	level.scr_anim["hovertank"]["hovertank_reveal_static"][0] = %lab_htank_static_loop_htank;
	level.scr_anim["hovertank"]["hovertank_reveal"] = %lab_htank_reveal_htank;
	level.scr_anim["hovertank"]["hovertank_reveal_loop"][0] = %lab_htank_reveal_loop_htank;
	level.scr_anim["hovertank"]["hovertank_enter"] = %lab_htank_vm_enter_htank;
	if(level.nextgen || param_00 == "outro")
	{
		maps\_anim::addnotetrack_customfunction("hovertank","vfx_htank_reveal_start",::maps\lab_fx::vfx_htank_reveal,"hovertank_reveal");
	}

	level.scr_animtree["hovertank"] = #animtree;
	level.scr_model["hovertank"] = "vehicle_mil_hovertank_ai";
	level.scr_anim["hovertank"]["hovertank_enter"] = %lab_htank_vm_enter_htank;
	level.scr_animtree["hovertank_interior"] = #animtree;
	level.scr_model["hovertank_interior"] = "vehicle_mil_hovertank_vm";
	level.scr_anim["hovertank_interior"]["hovertank_enter"] = %lab_htank_vm_enter_vmhtank;
	if(level.nextgen || param_00 == "outro")
	{
		maps\_anim::addnotetrack_notify("hovertank_interior","htank_vm_show","hovertank_show_interior","hovertank_enter");
		maps\_anim::addnotetrack_notify("hovertank","htank_ai_hide","hovertank_hide_exterior","hovertank_enter");
	}

	level.scr_anim["hovertank_interior"]["hovertank_react_small"] = %lab_htank_react_small_vmhtank;
	level.scr_anim["hovertank_interior"]["hovertank_react_large"] = %lab_htank_react_large_vmhtank;
	level.scr_anim["hovertank"]["hovertank_exit"] = %lab_htank_exit_htank;
	level.scr_anim["hovertank_interior"]["hovertank_exit"] = %lab_htank_exit_vmhtank;
	if(level.nextgen || param_00 == "outro")
	{
		maps\_anim::addnotetrack_notify("hovertank","htank_ai_show","hovertank_show_exterior","hovertank_exit");
		maps\_anim::addnotetrack_notify("hovertank_interior","htank_vm_hide","hovertank_hide_interior","hovertank_exit");
	}
}

//Function Number: 6
prop_anims(param_00)
{
	level.scr_animtree["vrap_mute"] = #animtree;
	level.scr_model["vrap_mute"] = "muteCharge";
	level.scr_anim["vrap_mute"]["vrap_mute"] = %lab_takedown_2_plantmute_mute;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_customfunction("vrap_mute","vfx_mute_device_plant",::maps\lab_fx::mute_device_plant_fx,"vrap_mute");
	}

	level.scr_animtree["security_door_right"] = #animtree;
	level.scr_model["security_door_right"] = "genericProp";
	level.scr_anim["security_door_right"]["server_room_peek"] = %lab_serverroom_entry_doorpeek_prop;
	level.scr_anim["security_door_right"]["server_room_enter"] = %lab_serverroom_entry_doorpush_prop;
	level.scr_animtree["carabiner_burke"] = #animtree;
	level.scr_animtree["carabiner_cormack"] = #animtree;
	level.scr_animtree["carabiner_knox"] = #animtree;
	level.scr_animtree["carabiner_vm"] = #animtree;
	level.scr_animtree["anchor_system"] = #animtree;
	level.scr_animtree["anchor_system_burke"] = #animtree;
	level.scr_animtree["anchor_system_cormack"] = #animtree;
	level.scr_animtree["anchor_system_knox"] = #animtree;
	level.scr_animtree["rope_30_burke"] = #animtree;
	level.scr_animtree["rope_30_cormack"] = #animtree;
	level.scr_animtree["rope_30_knox"] = #animtree;
	level.scr_animtree["rope_vm"] = #animtree;
	level.scr_animtree["rope_vm_long"] = #animtree;
	level.scr_animtree["rope_30_jump_burke"] = #animtree;
	level.scr_animtree["rope_150_burke"] = #animtree;
	level.scr_animtree["rope_150_burke_end"] = #animtree;
	level.scr_animtree["rope_150_cormack_end"] = #animtree;
	level.scr_animtree["rope_150_knox_end"] = #animtree;
	level.scr_animtree["rope_150_player_end"] = #animtree;
	level.scr_anim["carabiner_burke"]["cliff_meetup"] = %lab_cliff_rappel_meetup_burke_carabiner;
	level.scr_anim["carabiner_cormack"]["cliff_meetup"] = %lab_cliff_rappel_meetup_cormack_carabiner;
	level.scr_anim["carabiner_knox"]["cliff_meetup"] = %lab_cliff_rappel_meetup_knox_carabiner;
	level.scr_anim["anchor_system"]["cliff_jump"] = %lab_cliff_rappel_jump_vm_anchor;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_customfunction("anchor_system","vfx_pnematic_anchor",::maps\lab_fx::fx_pnematic_anchor,"cliff_jump");
	}

	level.scr_anim["carabiner_vm"]["cliff_jump"] = %lab_cliff_rappel_jump_vm_carabiner;
	level.scr_anim["anchor_system_burke"]["cliff_meetup"] = %lab_cliff_rappel_meetup_burke_anchor;
	level.scr_anim["anchor_system_cormack"]["cliff_meetup"] = %lab_cliff_rappel_meetup_cormack_anchor;
	level.scr_anim["anchor_system_knox"]["cliff_meetup"] = %lab_cliff_rappel_meetup_knox_anchor;
	level.scr_anim["rope_30_burke"]["cliff_meetup"] = %lab_cliff_rappel_meetup_burke_rope_30f;
	level.scr_anim["rope_30_cormack"]["cliff_meetup"] = %lab_cliff_rappel_meetup_cormack_rope_30f;
	level.scr_anim["rope_30_knox"]["cliff_meetup"] = %lab_cliff_rappel_meetup_knox_rope_30f;
	level.scr_anim["rope_vm"]["cliff_jump"] = %lab_cliff_rappel_jump_vm_rope_30f;
	level.scr_anim["rope_vm_long"]["cliff_jump"] = %lab_cliff_rappel_jump_vm_rope;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_customfunction("rope_vm","rope_swap",::maps\lab_code::player_rappel_rope_swap,"cliff_jump");
	}

	level.scr_anim["rope_30_burke"]["cliff_jump"] = %lab_cliff_rappel_jump_burke_rope_30f;
	level.scr_anim["rope_30_burke"]["cliff_meetup_rappel_idle"][0] = %lab_cliff_rappel_idle_burke_rope_30f;
	level.scr_anim["rope_150_burke"]["cliff_jump"] = %lab_cliff_rappel_jump_burke_rope_150f;
	if(level.nextgen || param_00 == "intro")
	{
		maps\_anim::addnotetrack_customfunction("rope_30_burke","rope_swap",::maps\lab_code::burke_rappel_rope_swap,"cliff_jump");
	}

	level.scr_anim["rope_150_burke_end"]["cliff_jump_end"][0] = %lab_cliff_rappel_jump_burke_rope_150f_loop;
	level.scr_anim["rope_150_cormack_end"]["cliff_jump_end"][0] = %lab_cliff_rappel_meetup_cormack_rope_150f_loop;
	level.scr_anim["rope_150_knox_end"]["cliff_jump_end"][0] = %lab_cliff_rappel_meetup_knox_rope_150f_loop;
	level.scr_anim["rope_150_player_end"]["cliff_jump_end"][0] = %lab_cliff_rappel_jump_vm_rope_150f_loop;
	level.scr_animtree["server_monitor"] = #animtree;
	level.scr_anim["server_monitor"]["server_room_exit"] = %lab_serverroom_monitor;
	level.scr_anim["server_monitor"]["server_room_exit_promo"] = %lab_serverroom_promo_monitor;
	level.scr_anim["server_monitor"]["server_room_enter"] = %lab_serverroom_entry_death_monitor;
	level.scr_anim["server_monitor"]["server_room_enter_fail"] = %lab_serverroom_entry_fail_monitor;
	level.scr_anim["server_monitor"]["server_room_door_idle"][0] = %lab_serverroom_entry_loop_monitor;
	level.scr_animtree["grenade1"] = #animtree;
	level.scr_animtree["grenade2"] = #animtree;
	level.scr_animtree["grenade3"] = #animtree;
	level.scr_anim["grenade1"]["server_room_exit"] = %lab_serverroom_grenade1;
	level.scr_anim["grenade2"]["server_room_exit"] = %lab_serverroom_grenade2;
	level.scr_anim["grenade3"]["server_room_exit"] = %lab_serverroom_grenade3;
	level.scr_anim["grenade1"]["server_room_exit_promo"] = %lab_serverroom_promo_grenade1;
	level.scr_anim["grenade2"]["server_room_exit_promo"] = %lab_serverroom_promo_grenade2;
	level.scr_anim["grenade3"]["server_room_exit_promo"] = %lab_serverroom_promo_grenade3;
	if(level.nextgen || param_00 == "middle")
	{
		maps\_anim::addnotetrack_customfunction("grenade1","vfx_thermite_grenade_1",::maps\lab_fx::thermite_grenade_1_fx,"server_room_exit");
		maps\_anim::addnotetrack_customfunction("grenade2","vfx_thermite_grenade_2",::maps\lab_fx::thermite_grenade_2_fx,"server_room_exit");
		maps\_anim::addnotetrack_customfunction("grenade3","vfx_thermite_grenade_3",::maps\lab_fx::thermite_grenade_3_fx,"server_room_exit");
		maps\_anim::addnotetrack_customfunction("grenade1","vfx_thermite_grenade_1",::maps\lab_fx::thermite_grenade_1_fx,"server_room_exit_promo");
		maps\_anim::addnotetrack_customfunction("grenade2","vfx_thermite_grenade_2",::maps\lab_fx::thermite_grenade_2_fx,"server_room_exit_promo");
		maps\_anim::addnotetrack_customfunction("grenade3","vfx_thermite_grenade_3",::maps\lab_fx::thermite_grenade_3_fx,"server_room_exit_promo");
	}

	level.scr_animtree["wallclimb_roots"] = #animtree;
	level.scr_anim["wallclimb_roots"]["burke_wall_climb"] = %lab_wallclimb_burke_roots;
	level.scr_anim["wallclimb_roots"]["player_wall_climb_1"] = %lab_wallclimb_player_1_roots;
	level.scr_anim["wallclimb_roots"]["player_wall_climb_2"] = %lab_wallclimb_player_2_roots;
	level.scr_anim["wallclimb_roots"]["player_wall_climb_3"] = %lab_wallclimb_player_3_roots;
	level.scr_anim["wallclimb_roots"]["player_wall_climb_4"] = %lab_wallclimb_player_4_roots;
	level.scr_anim["wallclimb_roots"]["player_wall_climb_5"] = %lab_wallclimb_player_5_roots;
	level.scr_anim["wallclimb_roots"]["player_wall_climb_loop"][0] = %lab_wallclimb_player_loop_roots;
	level.scr_anim["wallclimb_roots"]["player_wall_climb_lastjump"] = %lab_wallclimb_player_lastjump_roots;
	level.scr_anim["wallclimb_roots"]["player_wall_climb_end"] = %lab_wallclimb_player_end_roots;
	level.scr_animtree["jammer"] = #animtree;
	level.scr_model["jammer"] = "vm_jamming_device";
	level.scr_anim["jammer"]["jammerplant_1"] = %lab_courtyard_jammerplant_jammer;
	level.scr_anim["foam_bomb"]["foam_room"] = %lab_plant_foambomb_bomb;
	level.scr_animtree["foam_bomb"] = #animtree;
	level.scr_model["foam_bomb"] = "npc_foam_grenade";
	level.scr_anim["foam_bomb"]["foam_corridor_exit"] = %lab_fb_foamdeploy_foambomb;
	if(level.nextgen || param_00 == "middle")
	{
		maps\_anim::addnotetrack_notify("foam_bomb","detonate","foam_grenade_detonate","foam_corridor_exit");
	}

	level.scr_animtree["htank_reveal_lift_01"] = #animtree;
	level.scr_anim["htank_reveal_lift_01"]["hovertank_reveal"] = %lab_htank_reveal_lift_01;
	level.scr_animtree["htank_reveal_lift_02"] = #animtree;
	level.scr_anim["htank_reveal_lift_02"]["hovertank_reveal"] = %lab_htank_reveal_lift_02;
	level.scr_animtree["htank_reveal_lift_03"] = #animtree;
	level.scr_anim["htank_reveal_lift_03"]["hovertank_reveal"] = %lab_htank_reveal_lift_03;
	level.scr_animtree["htank_reveal_lift_04"] = #animtree;
	level.scr_anim["htank_reveal_lift_04"]["hovertank_reveal"] = %lab_htank_reveal_lift_04;
	level.scr_animtree["tank_hangar_garage_door"] = #animtree;
	level.scr_anim["tank_hangar_garage_door"]["lab_tank_hanger_door_open"] = %lab_tank_hanger_door_open;
	level.scr_animtree["perimeter_gate"] = #animtree;
	level.scr_anim["perimeter_gate"]["opened"] = %lab_perimeter_gate_open_idle;
	level.scr_anim["perimeter_gate"]["close"] = %lab_perimeter_gate_close;
	level.scr_anim["perimeter_gate"]["closed"] = %lab_perimeter_gate_close_idle;
	level.scr_anim["perimeter_gate"]["shoot_open1"] = %lab_perimeter_gate_open;
}

//Function Number: 7
animal_anims(param_00)
{
	level.scr_animtree["deer"] = #animtree;
	level.scr_anim["deer"]["search_drone"] = %lab_unarmed_walltop_deer;
}

//Function Number: 8
notetrack_setup_middle()
{
	level waittill("tff_post_intro_to_middle");
	maps\_anim::addnotetrack_customfunction("guy_01_server_room","start_ragdoll",::ai_kill,"server_room_enter");
	maps\_anim::addnotetrack_customfunction("guy_01_server_room","start_ragdoll",::ai_kill,"server_room_enter_fail");
	maps\_anim::addnotetrack_customfunction("player_rig","fov_start",::cormack_fov_start,"server_room_exit_promo");
	maps\_anim::addnotetrack_customfunction("player_rig","fov_end",::cormack_fov_end,"server_room_exit_promo");
	maps\_anim::addnotetrack_customfunction("mech","vfx_stomp_land",::maps\lab_fx::mech_intro_land_dust,"courtyard_mech_intro");
	maps\_anim::addnotetrack_customfunction("grenade1","vfx_thermite_grenade_1",::maps\lab_fx::thermite_grenade_1_fx,"server_room_exit");
	maps\_anim::addnotetrack_customfunction("grenade2","vfx_thermite_grenade_2",::maps\lab_fx::thermite_grenade_2_fx,"server_room_exit");
	maps\_anim::addnotetrack_customfunction("grenade3","vfx_thermite_grenade_3",::maps\lab_fx::thermite_grenade_3_fx,"server_room_exit");
	maps\_anim::addnotetrack_customfunction("grenade1","vfx_thermite_grenade_1",::maps\lab_fx::thermite_grenade_1_fx,"server_room_exit_promo");
	maps\_anim::addnotetrack_customfunction("grenade2","vfx_thermite_grenade_2",::maps\lab_fx::thermite_grenade_2_fx,"server_room_exit_promo");
	maps\_anim::addnotetrack_customfunction("grenade3","vfx_thermite_grenade_3",::maps\lab_fx::thermite_grenade_3_fx,"server_room_exit_promo");
	maps\_anim::addnotetrack_notify("foam_bomb","detonate","foam_grenade_detonate","foam_corridor_exit");
	maps\_anim::addnotetrack_customfunction("cormack","dilate_pupils",::cormack_dilate_pupils,"server_room_exit_promo");
}

//Function Number: 9
notetrack_setup_outro()
{
	level waittill("tff_post_middle_to_outro");
	maps\_anim::addnotetrack_notify("player_rig","start_npcs","hovertank_enter_start_npcs","hovertank_enter");
	maps\_anim::addnotetrack_customfunction("player_rig","FOV_to_75",::transition_to_hovertank_fov,"hovertank_enter");
	maps\_anim::addnotetrack_customfunction("player_rig","start_razorback",::maps\lab_code::se_exfil_razorback,"hovertank_exit");
	maps\_anim::addnotetrack_notify("burke","fade_start","level_fade_out","exfil_enter");
	maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_front_on",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_on,"exfil_fly_in");
	maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_back_on",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_back_on,"exfil_fly_in");
	maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_front_off",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_off,"exfil_fly_in");
	maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_back_off",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_back_off,"exfil_fly_in");
	maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_front_on",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_on,"exfil_enter");
	maps\_anim::addnotetrack_customfunction("razorback","vfx_razorback_thrust_back_on",::vehicle_scripts\_razorback_fx::vfx_rb_thruster_back_on,"exfil_enter");
	maps\_anim::addnotetrack_customfunction("razorback","vfx_htank_explode",::maps\lab_fx::vfx_htank_explosion,"exfil_enter");
	maps\_anim::addnotetrack_customfunction("hovertank","vfx_htank_reveal_start",::maps\lab_fx::vfx_htank_reveal,"hovertank_reveal");
	maps\_anim::addnotetrack_notify("hovertank_interior","htank_vm_show","hovertank_show_interior","hovertank_enter");
	maps\_anim::addnotetrack_notify("hovertank","htank_ai_hide","hovertank_hide_exterior","hovertank_enter");
	maps\_anim::addnotetrack_notify("hovertank","htank_ai_show","hovertank_show_exterior","hovertank_exit");
	maps\_anim::addnotetrack_notify("hovertank_interior","htank_vm_hide","hovertank_hide_interior","hovertank_exit");
}

//Function Number: 10
burke_intro_dialogue(param_00)
{
	common_scripts\utility::flag_set("flag_intro_run_dialogue_start");
}

//Function Number: 11
burke_exo_cloak_on(param_00)
{
	param_00 maps\lab_utility::cloak_on(0,0.25);
}

//Function Number: 12
player_exo_power_on(param_00)
{
	wait(4);
	common_scripts\utility::flag_set("flag_player_cloak_on");
	soundscripts\_snd::snd_message("player_cloak_on");
	if(common_scripts\utility::flag("flag_demo_itiot_start"))
	{
		thread maps\_shg_utility::show_player_hud("0",undefined,0);
		return;
	}

	thread maps\_shg_utility::show_player_hud(undefined,undefined,0);
}

//Function Number: 13
player_fov_54(param_00)
{
	param_00 maps\_utility::lerp_fov_overtime(0.5,54.75);
	common_scripts\utility::flag_set("flag_hold_on_dialogue");
}

//Function Number: 14
player_fov_65(param_00)
{
	param_00 maps\_utility::lerp_fov_overtime(0.33,65);
}

//Function Number: 15
player_exo_cloak_on(param_00)
{
	maps\_cloak::turn_on_the_cloak_effect();
}

//Function Number: 16
player_exo_cloak_on_wallclimb(param_00)
{
	maps\lab_utility::turn_on_the_cloak_effect_wallclimb();
}

//Function Number: 17
swap_tree(param_00)
{
	var_01 = getent("takedown_stump","targetname");
	var_02 = getent("takedown_stump_damaged","targetname");
	maps\lab_fx::tree_head_impact();
	var_01 hide();
	var_02 show();
}

//Function Number: 18
ai_kill(param_00)
{
	if(!isalive(param_00))
	{
		return;
	}

	param_00.allowdeath = 1;
	param_00.a.nodeath = 1;
	param_00 maps\_utility::set_battlechatter(0);
	wait(0.05);
	param_00 kill();
}

//Function Number: 19
transition_to_hovertank_fov(param_00)
{
	level.player maps\_utility::lerpfov_saved(75,2);
}

//Function Number: 20
cloak_off(param_00)
{
	param_00 maps\lab_utility::cloak_off();
}

//Function Number: 21
cormack_fov_start(param_00)
{
	param_00 maps\_utility::lerp_fov_overtime(10,50);
}

//Function Number: 22
cormack_fov_end(param_00)
{
	param_00 maps\_utility::lerp_fov_overtime(2.1,65);
}

//Function Number: 23
cormack_dilate_pupils(param_00)
{
	if(level.currentgen)
	{
		return;
	}

	var_01 = getdvarfloat("r_eyePupil");
	lerp_pupil_over_time(0.95,0.75);
	wait(4);
	lerp_pupil_over_time(0.05,0.55);
	wait(0.5);
	lerp_pupil_over_time(var_01,1.5);
}

//Function Number: 24
lerp_pupil_over_time(param_00,param_01)
{
	if(level.currentgen)
	{
		return;
	}

	var_02 = getdvarfloat("r_eyePupil");
	var_03 = 0.05;
	var_04 = 0;
	var_05 = param_00 - var_02 / param_01 * var_03;
	var_06 = var_02;
	while(var_04 < param_01)
	{
		var_06 = var_06 + var_05;
		setsaveddvar("r_eyePupil",var_06);
		var_04 = var_04 + var_03;
		wait(var_03);
	}
}

//Function Number: 25
set_flag_rappel_player_input_start(param_00)
{
	common_scripts\utility::flag_set("flag_rappel_player_input_start");
}

//Function Number: 26
set_flag_rappel_player_input_stop(param_00)
{
	common_scripts\utility::flag_set("flag_rappel_player_input_stop");
}