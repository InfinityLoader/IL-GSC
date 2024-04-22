/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: seoul_code_gangnam.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 471
 * Decompile Time: 6734 ms
 * Timestamp: 4/22/2024 2:36:43 AM
*******************************************************************/

//Function Number: 1
gangnam_main()
{
	setsaveddvar("high_jump_double_tap","1");
	common_scripts\utility::flag_init("hault_column");
	common_scripts\utility::flag_init("opening_view_off");
	common_scripts\utility::flag_init("cloud_queen_retreat_path");
	common_scripts\utility::flag_init("shoot_guide_now");
	common_scripts\utility::flag_init("orders_given_lets_move_out");
	common_scripts\utility::flag_init("incoming_rocket_fire");
	common_scripts\utility::flag_init("kill_rocket_scene_guy");
	common_scripts\utility::flag_init("encounter_01_done");
	common_scripts\utility::flag_init("truck_push_initiate");
	common_scripts\utility::flag_init("second_land_assist_go");
	common_scripts\utility::flag_init("fob_animation_complete");
	common_scripts\utility::flag_init("destroy_fob_blocking");
	common_scripts\utility::flag_init("player_initiated_door_ripoff");
	common_scripts\utility::flag_init("guy_dragged_success");
	common_scripts\utility::flag_init("send_will_2secs_early");
	common_scripts\utility::flag_init("player_passed_fob");
	common_scripts\utility::flag_init("land_assist_activated");
	common_scripts\utility::flag_init("e3_presentation_cleanup");
	common_scripts\utility::flag_init("snake_swarm_first_flyby_begin");
	common_scripts\utility::flag_init("npc_pods_landed");
	common_scripts\utility::flag_init("player_just_grabbed_door");
	common_scripts\utility::flag_init("snake_swarm_cardoor_charge_end");
	common_scripts\utility::flag_init("dropoff_drones_exit");
	common_scripts\utility::flag_init("end_lobby_loopers");
	common_scripts\utility::flag_init("all_targeted_drones_dead");
	common_scripts\utility::flag_init("ignore_land_assist_hint");
	common_scripts\utility::flag_init("end_smart_grenade_hint");
	common_scripts\utility::flag_init("drone_swarm_complete");
	common_scripts\utility::flag_init("all_drones_dead");
	common_scripts\utility::flag_init("jump_training_ended");
	common_scripts\utility::flag_init("objective_start");
	common_scripts\utility::flag_init("objective_cardoor");
	common_scripts\utility::flag_init("objective_mobile_turret");
	common_scripts\utility::flag_init("vista_bomber_trigger_01");
	common_scripts\utility::flag_init("vista_bomber_trigger_02");
	common_scripts\utility::flag_init("vista_bomber_trigger_03");
	common_scripts\utility::flag_init("dialogue_performing_arts_interior");
	common_scripts\utility::flag_init("dialogue_performing_arts_exit");
	common_scripts\utility::flag_init("spawn_regular_heroes");
	common_scripts\utility::flag_init("spawn_guys_for_intro");
	common_scripts\utility::flag_init("video_log_playing");
	common_scripts\utility::flag_init("will_cardoor_watcher_flag");
	common_scripts\utility::flag_init("flag_drone_ok_to_follow");
	common_scripts\utility::flag_init("enable_door_clip");
	common_scripts\utility::flag_init("begin_mech_reload");
	common_scripts\utility::flag_init("flag_drone_buzz_will");
	common_scripts\utility::flag_init("flag_drone_street_strafe");
	common_scripts\utility::flag_init("start_drone_turret_charge");
	common_scripts\utility::flag_init("end_drone_turret_charge");
	common_scripts\utility::flag_init("ok_to_land_assist");
	common_scripts\utility::flag_init("spawn_looping_planes");
	common_scripts\utility::flag_init("guy4_reached_goal");
	common_scripts\utility::flag_init("guy5_reached_goal");
	common_scripts\utility::flag_init("guy6_reached_goal");
	common_scripts\utility::flag_init("guy7_reached_goal");
	common_scripts\utility::flag_init("guy8_reached_goal");
	common_scripts\utility::flag_init("guy9_reached_goal");
	common_scripts\utility::flag_init("tank_is_clear");
	common_scripts\utility::flag_init("follow_tank_is_dead");
	common_scripts\utility::flag_init("wep_drone_dropoff_start");
	common_scripts\utility::flag_init("drones_cleared_building");
	common_scripts\utility::flag_init("flag_cormack_has_arrived_at_hill");
	common_scripts\utility::flag_init("flag_will_irons_has_arrived_at_hill");
	common_scripts\utility::flag_init("seoul_player_can_exit_x4walker");
	common_scripts\utility::flag_init("walker_tank_is_dead");
	common_scripts\utility::flag_init("boost_dodge_hint_off");
	common_scripts\utility::flag_init("pause_credits");
	common_scripts\utility::flag_init("kill_credits");
	maps\_player_high_jump::main();
	if(level.nextgen)
	{
		maps\_drone_civilian::init();
	}

	maps\_player_land_assist::land_assist_init();
	maps\_car_door_shield::init_door_shield();
	vehicle_scripts\_attack_drone_common::attack_drone_formation_init();
	vehicle_scripts\_attack_drone::drone_swarm_init();
	maps\_drone_ai::init();
	if(level.currentgen)
	{
		thread maps\seoul_transients_cg::cg_tff_transition_eastview_to_fob();
		thread maps\seoul_transients_cg::cg_tff_transition_fob_to_droneswarmone();
		thread maps\seoul_transients_cg::cg_tff_transition_fob_to_truckpush();
		thread maps\seoul_transients_cg::cg_tff_transition_droneswarmone_to_mall();
		thread maps\seoul_transients_cg::cg_tff_transition_mall_to_shinkhole();
		thread maps\seoul_transients_cg::cg_tff_transition_shinkhole_to_subway();
		thread maps\seoul_transients_cg::cg_tff_transition_subway_to_shoppingdistrict();
		thread maps\seoul_transients_cg::cg_tff_transition_shopping_to_canaloverlook();
		thread maps\seoul_transients_cg::cg_tff_transition_canaloverlook_to_riverwalk();
		thread maps\seoul_transients_cg::cg_tff_set_up_transient_meshes();
		thread maps\seoul_transients_cg::cg_swap_tank_treads_mat();
	}

	level.fxtags_bigwar = [];
	level.fxtags_space = [];
	level.fxtags_streets = [];
	level.enemy_bullet = [];
	level.enemy_bullet[0] = "iw5_hbra3_sp";
	level.enemy_bullet[1] = "dshk_turret_so_osprey";
	level.enemy_bullet[2] = "ac130_25mm";
	level.drone_bullet = "iw5_attackdronegunseoul";
	level.cherry_picker_hud = "bls_ui_turret_overlay_sm_alt";
	level.cherry_picker_hud_emp = "bls_ui_turret_overlay_sm_alt_emp";
	level.cherry_picker_hud_drone = "bls_ui_turret_overlay_sm_alt_drone";
	level.cherry_picker_hud_drone2 = "bls_ui_turret_overlay_sm_alt_drone2";
	level.cherry_picker_hud_bar = "hud_white_box";
	level.vista_ents = [];
	level.walker_for_swarm = undefined;
	level.monitor_setup_group = [];
	level.walker_tank_reload_ok = 0;
	if(level.nextgen)
	{
		level.min_drone_swarm_size = randomintrange(180,210);
	}
	else
	{
		level.min_drone_swarm_size = randomintrange(70,80);
	}

	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinewidth",2);
	precacheitem(level.enemy_bullet[1]);
	precacheitem(level.enemy_bullet[2]);
	precacheitem(level.drone_bullet);
	precacheitem("iw5_em1_sp_opticstargetenhancer");
	precacheitem("rpg_straight");
	precacheitem("ac130_25mm");
	precacheitem("dshk_turret_so_osprey");
	precacheitem("rpg_guided");
	precacheitem("hovertank_missile_small_straight");
	precachemodel("npc_zipline101ft");
	precachemodel("projectile_rpg7");
	precachemodel("vehicle_sentinel_survey_drone");
	precachemodel("vehicle_walker_tank");
	precachemodel("npc_atlas_suv_door_fr");
	precachemodel("npc_atlas_suv_door_fl");
	precachemodel("vm_atlas_suv_door_fl");
	precachemodel("vehicle_mil_cargo_truck_ai");
	precachemodel("vehicle_mil_drop_pod");
	precachemodel("vehicle_mil_drop_pod_seats");
	if(level.nextgen)
	{
		precachemodel("vehicle_mil_drop_pod_static_landed");
	}

	precachemodel("mil_drop_pod_seat");
	precachemodel("vehicle_mil_drop_pod_intro");
	if(level.currentgen)
	{
		precacheshader("mtl_mil_drop_pod_int");
		precacheshader("mtl_marines_assault_combine");
		precacheshader("mtl_marines_assault_loadouts");
		precacheshader("mtl_marines_smg_loadouts");
		precacheshader("mtl_marines_exo");
		precacheshader("mtl_cormack_marines_body_cg");
		precacheshader("mtl_cormack_marines_loadouts_cg");
		precacheshader("mtl_will_marines_lowerbody_body_cg");
		precacheshader("mtl_will_marines_upperbody_cg");
	}

	precachemodel("vehicle_mil_drop_pod_screens");
	precachemodel("mil_drop_pod_seat_rack");
	precachemodel("mil_drop_pod_seat_cpt");
	precachemodel("mil_drop_pod_seat_simple");
	precachemodel("projectile_javelin_missile");
	precachemodel("vehicle_civ_pickup_truck_01_wrecked");
	precachemodel("vehicle_mil_attack_drone_static_orange");
	precachemodel("vehicle_mil_attack_drone_static");
	precachemodel("vehicle_mil_mwp_static");
	precachemodel("vehicle_mil_drop_pod_static_gsq");
	precachemodel("crate_supply_01_long_full");
	precacheshader(level.cherry_picker_hud);
	precacheshader(level.cherry_picker_hud_emp);
	precacheshader(level.cherry_picker_hud_bar);
	precacheshader(level.cherry_picker_hud_drone);
	precacheshader(level.cherry_picker_hud_drone2);
	precachelaser("lag_snipper_laser");
	precacheshader("drone_turret_hud_target");
	precacheshader("drone_turret_hud_locking");
	precacheshader("hud_white_box");
	precacheshader("dpad_icon_land_assist");
	precachemodel("vm_himar_base_loot_sp");
	precacherumble("heavy_3s");
	maps\_utility::add_hint_string("jump_training",&"SEOUL_DOUBLE_TAP_A_FOR_BOOST_JUMP",::boost_hint_breakout);
	maps\_utility::add_hint_string("press_a_for_emp",&"SEOUL_PRESS_A_FOR_EMP",::emp_prompt_breakout);
	maps\_utility::add_hint_string("smart_grenade_training",&"SEOUL_USE_SMART_GRENADE",::smart_hint_breakout);
	maps\_utility::add_hint_string("car_door_throw",&"SEOUL_CARDOOR_THROW",::cardoor_hint_breakout);
	maps\_utility::add_hint_string("boost_slam_train",&"SEOUL_TRAIN_BOOST_SLAM",::slam_hint_breakout);
	maps\_utility::add_control_based_hint_strings("x_for_hover",&"SEOUL_PRESS_X_FOR_COUNTER_THRUSTERS",::land_assist_hint_breakout,&"SEOUL_PRESS_X_FOR_COUNTER_THRUSTERS_PC");
	maps\_utility::add_control_based_hint_strings("x_for_hover_alt",&"SEOUL_PRESS_X_FOR_COUNTER_THRUSTERS",::land_assist_hint_safe_descent_breakout,&"SEOUL_PRESS_X_FOR_COUNTER_THRUSTERS_PC");
	maps\_utility::add_control_based_hint_strings("x_for_hover_across",&"SEOUL_LAND_ASSIST_HOVER",::hover_hint_breakout,&"SEOUL_LAND_ASSIST_HOVER_PC");
	maps\_utility::add_control_based_hint_strings("ads_train",&"SEOUL_ADS_TRAINING",::ads_hint_breakout,&"SEOUL_ADS_TRAINING_PC");
	maps\_utility::add_control_based_hint_strings("lt_rt_harness",&"SEOUL_LT_OR_RT_TO_RELEASE_HARNESS",::lt_rt_harness_breakout,&"SEOUL_LT_OR_RT_TO_RELEASE_HARNESS_PC");
	maps\_utility::add_control_based_hint_strings("rt_right_harness",&"SEOUL_RT_TO_RELEASE_RIGHT_HARNESS",::rt_harness_breakout,&"SEOUL_RT_TO_RELEASE_RIGHT_HARNESS_PC");
	maps\_utility::add_control_based_hint_strings("lt_left_harness",&"SEOUL_LT_TO_RELEASE_LEFT_HARNESS",::lt_harness_breakout,&"SEOUL_LT_TO_RELEASE_LEFT_HARNESS_PC");
	maps\_utility::add_control_based_hint_strings("a_to_open_hatch",&"SEOUL_PRESS_A_TO_OPEN_HATCH",::open_hatch_breakout,&"SEOUL_PRESS_A_TO_OPEN_HATCH_PC",&"SEOUL_PRESS_A_TO_OPEN_HATCH_SP");
	maps\_utility::add_control_based_hint_strings("boost_dodge_train",&"SEOUL_TRAIN_BOOST_DODGE",::dodge_hint_breakout,&"SEOUL_TRAIN_BOOST_DODGE_PC",&"SEOUL_TRAIN_BOOST_DODGE_SP");
	common_scripts\utility::flag_set("ok_to_land_assist");
	thread gangnam_autosave();
	thread jump_type_select();
	thread handle_canal_intro_retreating();
	thread handle_shopping_district_retreating();
	thread handle_boost_dodge_training();
	thread smart_grenade_training();
	level.e3_presentation = 0;
	createthreatbiasgroup("enemies_ignored_by_allies");
	createthreatbiasgroup("allies_ignored_by_enemies");
	createthreatbiasgroup("enemies_attack_player");
	createthreatbiasgroup("major_allies");
	createthreatbiasgroup("enemies_ignored_by_major_allies");
	createthreatbiasgroup("enemies_ignore_player");
	createthreatbiasgroup("player");
	setignoremegroup("enemies_ignored_by_allies","allies");
	setignoremegroup("enemies_ignored_by_major_allies","major_allies");
	setignoremegroup("major_allies","enemies_ignored_by_major_allies");
	setignoremegroup("player","enemies_ignore_player");
	setignoremegroup("major_allies","enemies_attack_player");
	level.player setthreatbiasgroup("player");
	animscripts\traverse\boost::precache_boost_fx_npc();
	thread debug_will_exo_breach();
}

//Function Number: 2
debug_will_exo_breach()
{
	level waittill("exo_breach_impact");
	wait 0.05;
}

//Function Number: 3
debug_hero_pathing()
{
	for(;;)
	{
		self waittill("bad_path",var_00);
		common_scripts\utility::draw_line_for_time(self geteye(),var_00,randomfloat(1),randomfloat(1),randomfloat(1),0.1);
	}
}

//Function Number: 4
debug_player_fall()
{
	for(;;)
	{
		level.player waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(var_04 == "MOD_FALLING" || var_04 == "mod_falling")
		{
			level.player.health = 1;
		}
	}
}

//Function Number: 5
prep_cinematic(param_00)
{
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingame(param_00,1);
	level.current_cinematic = param_00;
}

//Function Number: 6
play_cinematic(param_00,param_01,param_02)
{
	if(isdefined(level.current_cinematic))
	{
		pausecinematicingame(0);
		setsaveddvar("cg_cinematicFullScreen","1");
		level.current_cinematic = undefined;
	}
	else
	{
		cinematicingame(param_00);
	}

	if(!isdefined(param_02) || !param_02)
	{
		setsaveddvar("cg_cinematicCanPause","1");
	}

	wait(1);
	while(iscinematicplaying())
	{
		wait(0.05);
	}

	if(!isdefined(param_02) || !param_02)
	{
		setsaveddvar("cg_cinematicCanPause","0");
	}
}

//Function Number: 7
play_seoul_videolog()
{
	setsaveddvar("cg_cinematicfullscreen","0");
	thread slow_allies_while_videolog_plays();
	thread maps\_shg_utility::disable_features_entering_cinema(1);
	thread emergency_break_videolog();
	thread reduce_player_movement_videolog();
	soundscripts\_snd::snd_message("seo_video_log_start");
	common_scripts\utility::flag_set("video_log_playing");
	maps\_shg_utility::play_videolog("seoul_videolog","screen_add");
	thread maps\_shg_utility::enable_features_exiting_cinema(1);
	thread return_allies_after_videolog_plays();
	thread return_player_movement_videolog();
}

//Function Number: 8
reduce_player_movement_videolog()
{
	level.player maps\_utility::player_speed_percent(70);
}

//Function Number: 9
return_player_movement_videolog()
{
	thread maps\seoul::gradually_return_player_speed(70,100,10);
}

//Function Number: 10
emergency_break_videolog()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_sinkhole_enemy_setup");
	if(iscinematicplaying())
	{
		maps\_shg_utility::stop_videolog();
		wait(1);
		maps\seoul::ingame_movies();
	}
}

//Function Number: 11
handle_player_skipping_setups()
{
	thread player_skipping_setup("trig_convention_center_combat_05","vol_tester_skipping_guys_pac",2);
	thread player_skipping_setup("vol_tester_skipping_guys_sinkhole","volume_sinkhole_enemy_defend",2);
	thread player_skipping_setup("trig_move_to_final_color","vol_canal_enemy_ai_check_01",3);
}

//Function Number: 12
player_skipping_setup(param_00,param_01,param_02)
{
	maps\_shg_design_tools::waittill_trigger_with_name(param_00);
	var_03 = getent(param_01,"targetname");
	var_04 = getaiarray("axis");
	var_05 = [];
	foreach(var_07 in var_04)
	{
		if(var_07 istouching(var_03))
		{
			var_05[var_05.size] = var_07;
		}
	}

	if(var_05.size > param_02)
	{
		thread attack_player_for_time(10,var_05);
	}
}

//Function Number: 13
attack_player_for_time(param_00,param_01)
{
	if(!isdefined(level.player_is_skipping_setups))
	{
		level.player_is_skipping_setups = 1;
	}
	else
	{
		level.player_is_skipping_setups++;
	}

	thread return_threat_bias_from_agro(param_00);
	var_02 = getaiarray("axis");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04) & !isdefined(var_04.old_threatbias))
		{
			var_04.old_threatbias = var_04 getthreatbiasgroup();
			var_04 setthreatbiasgroup("enemies_attack_player");
			var_04.accuracy = 1;
		}
	}

	foreach(var_07 in param_01)
	{
		if(isdefined(var_07))
		{
			var_07 thread maps\_utility::player_seek(param_00);
		}
	}
}

//Function Number: 14
return_threat_bias_from_agro(param_00)
{
	wait(param_00);
	var_01 = getaiarray("axis");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(isdefined(var_03.old_threatbias))
		{
			var_03 setthreatbiasgroup(var_03.old_threatbias);
			continue;
		}

		var_03 setthreatbiasgroup("");
	}
}

//Function Number: 15
slow_allies_while_videolog_plays()
{
	level.cormack maps\_utility::enable_cqbwalk();
	level.will_irons maps\_utility::enable_cqbwalk();
	level.jackson maps\_utility::enable_cqbwalk();
	level.cormack maps\_utility::set_moveplaybackrate(0.8);
	level.will_irons maps\_utility::set_moveplaybackrate(0.8);
	level.jackson maps\_utility::set_moveplaybackrate(0.8);
}

//Function Number: 16
return_allies_after_videolog_plays()
{
	level.cormack maps\_utility::set_moveplaybackrate(1);
	level.will_irons maps\_utility::set_moveplaybackrate(1);
	level.jackson maps\_utility::set_moveplaybackrate(1);
}

//Function Number: 17
jump_type_select()
{
	wait(1);
	self endon("death");
	common_scripts\utility::flag_wait("ok_to_land_assist");
	level.player setweaponhudiconoverride("actionslot4","dpad_icon_land_assist");
	for(;;)
	{
		for(;;)
		{
			level.player waittill("dpad_right");
			if(maps\_player_exo::player_exo_is_active())
			{
				break;
			}
		}

		level.player thread maps\_player_land_assist::monitor_land_assist_think();
		common_scripts\utility::flag_set("land_assist_activated");
		wait(0.5);
		level.player waittill("dpad_right");
		level.player notify("clear_land_assist_process");
		common_scripts\utility::flag_clear("land_assist_activated");
		wait(0.5);
	}
}

//Function Number: 18
waittill_player_uses_land_assist(param_00)
{
	level.player endon("dpad_right");
	level.player endon("dpad_left");
	level.player endon("dpad_up");
	level.player endon("landassist_button");
	while(common_scripts\utility::flag("land_assist_activated"))
	{
		if(common_scripts\utility::flag("ignore_land_assist_hint"))
		{
			return;
		}

		var_01 = bullettrace(level.player.origin,level.player.origin - (0,0,1000),1,level.player,1,0);
		if(isdefined(var_01["position"]))
		{
			if(distance(var_01["position"],level.player.origin) > 128)
			{
				break;
			}
		}

		wait 0.05;
	}

	level.player waittill("end_jump_hud");
}

//Function Number: 19
gangnam_autosave()
{
	level endon("missionfailed");
	thread save_game_drone_swarm_street_begin();
	thread save_game_start_building_fob();
	for(;;)
	{
		level waittill("autosave_request");
		wait 0.05;
		maps\_utility::autosave_tactical();
	}
}

//Function Number: 20
save_game_drone_swarm_street_begin()
{
	maps\_shg_design_tools::waittill_trigger_with_name("seoul_streets_02");
	level notify("autosave_request");
}

//Function Number: 21
save_game_start_building_fob()
{
	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
	level notify("autosave_request");
}

//Function Number: 22
objective_01_on_cormack()
{
	wait(1);
	if(!common_scripts\utility::flag("begin_looping_fob_functions"))
	{
		level waittill("droppod_empty");
	}

	objective_onentity(maps\_utility::obj("objective_demo_team"),level.cormack,(0,0,0));
	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
	setsaveddvar("objectiveAlphaEnabled",1);
	common_scripts\utility::flag_wait("flag_start_fob_meet_scene");
	wait(2);
	setsaveddvar("objectiveAlphaEnabled",0);
}

//Function Number: 23
objective_01_on_cardoor()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_drone_swarm_flank");
	var_00 = getentarray("trig_door_shield","targetname");
	foreach(var_02 in var_00)
	{
		var_02.door_clip = getent(var_02.target,"targetname");
		var_02.door_model = getent(var_02.door_clip.target,"targetname");
	}

	thread x_on_closest_cardoor();
	foreach(var_02 in var_00)
	{
		var_02.door_model notify("end_hud_outline");
		var_02.door_model thread stencil_when_cardoor_in_range();
	}

	thread monitor_clear_cardoor_buttons();
}

//Function Number: 24
x_on_closest_cardoor()
{
	level.player endon("player_has_cardoor");
	level.player endon("turret_objective_active");
	level.cardoor_buttons = [];
	var_00 = common_scripts\utility::getstructarray("struct_door_ripoff_scene_prompt","targetname");
	var_01 = undefined;
	for(;;)
	{
		var_02 = get_best_cardoor_struct(level.player.origin,var_00,1000);
		if(isdefined(var_02) && !isdefined(var_01) || var_01 != var_02)
		{
			foreach(var_04 in level.cardoor_buttons)
			{
				if(isdefined(var_04))
				{
					var_04 maps\_shg_utility::hint_button_clear();
				}
			}

			level.cardoor_buttons[level.cardoor_buttons.size] = maps\_shg_utility::hint_button_position("x",var_02.origin,32,1500);
			var_01 = var_02;
		}

		wait 0.05;
	}
}

//Function Number: 25
get_best_cardoor_struct(param_00,param_01,param_02)
{
	var_03 = getent("vol_cardoor_objective_vol_a","targetname");
	var_04 = getent("vol_cardoor_objective_vol_b","targetname");
	var_05 = getent("vol_cardoor_objective_vol_c","targetname");
	if(level.player istouching(var_04))
	{
		foreach(var_07 in param_01)
		{
			if(isdefined(var_07.script_noteworthy) && issubstr(var_07.script_noteworthy,"vol_b"))
			{
				return var_07;
			}
		}

		return;
	}

	return common_scripts\utility::getclosest(var_03,var_04,var_05);
}

//Function Number: 26
stencil_when_cardoor_in_range()
{
	self endon("death");
	self endon("door_weapon_removed");
	level.player endon("player_has_cardoor");
	level.player endon("turret_objective_active");
	target_set(self);
	target_hidefromplayer(self,level.player);
	setsaveddvar("r_hudoutlinewidth",4);
	self.normal_stencil = 0;
	thread handle_cardoor_outline_on();
	thread handle_cardoor_outline_off();
}

//Function Number: 27
handle_cardoor_outline_off()
{
	level.player common_scripts\utility::waittill_either("player_has_cardoor","turret_objective_active");
	self hudoutlinedisable();
}

//Function Number: 28
handle_cardoor_outline_on()
{
	self endon("death");
	self endon("door_weapon_removed");
	level.player endon("player_has_cardoor");
	level.player endon("turret_objective_active");
	while(isdefined(self))
	{
		var_00 = distance(level.player.origin,self.origin);
		if(var_00 < 1500 && target_isincircle(self,level.player,65,150))
		{
			self hudoutlineenable(6,1);
			continue;
		}

		self hudoutlinedisable();
		wait(0.05);
	}
}

//Function Number: 29
monitor_clear_cardoor_buttons()
{
	level.player common_scripts\utility::waittill_any("player_has_cardoor","turret_objective_active");
	if(isdefined(level.cardoor_buttons))
	{
		foreach(var_01 in level.cardoor_buttons)
		{
			if(isdefined(var_01))
			{
				var_01 maps\_shg_utility::hint_button_clear();
			}
		}
	}
}

//Function Number: 30
objective_01_on_turret()
{
	thread maps\_shg_design_tools::trigger_to_notify("trigger_cardoor_strafe");
	level common_scripts\utility::waittill_either("turret_objective_given","trigger_cardoor_strafe");
	if(common_scripts\utility::flag("objective_cardoor"))
	{
		common_scripts\utility::flag_waitopen("objective_cardoor");
		maps\_utility::objective_clearadditionalpositions(1);
	}

	common_scripts\utility::flag_set("objective_mobile_turret");
	level.player notify("turret_objective_active");
	wait(2);
	setsaveddvar("r_hudoutlinewidth",1);
	level.mobile_turret hudoutlineenable(6,1);
	level.mobile_turret.mgturret[0] hudoutlineenable(6,1);
	var_00 = getent("mobile_turret_drone_street","targetname");
	objective_onentity(maps\_utility::obj("objective_demo_team"),var_00.hint_button_locations[1]);
	objective_setpointertextoverride(maps\_utility::obj("objective_demo_team"),&"SEOUL_ENTER_MOBILE_TURRET");
	while(distance(level.player.origin,level.mobile_turret.origin) > 450)
	{
		wait 0.05;
	}

	level.mobile_turret hudoutlinedisable();
	level.mobile_turret.mgturret[0] hudoutlinedisable();
	level.mobile_turret maps\_utility::ent_flag_wait("player_in_transition");
	objective_position(maps\_utility::obj("objective_demo_team"),(0,0,0));
	level.player waittill("player_in_x4walker");
}

//Function Number: 31
objective_01_on_will()
{
	level waittill("end_cherry_picker");
	objective_onentity(maps\_utility::obj("objective_demo_team"),level.cormack,(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("objective_demo_team"),"");
}

//Function Number: 32
gangnam_objectives()
{
	objective_add(maps\_utility::obj("objective_demo_team"),"active","Regroup with D Company");
	objective_current(maps\_utility::obj("objective_demo_team"));
	while(!isdefined(level.cormack))
	{
		wait(0.05);
	}

	thread objective_01_on_cormack();
	thread objective_01_on_cardoor();
	thread objective_01_on_turret();
	thread objective_01_on_will();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_teleport_ally_squad_shopping");
	objective_onentity(maps\_utility::obj("objective_demo_team"),level.will_irons,(0,0,0));
}

//Function Number: 33
seoul_start()
{
	soundscripts\_snd::snd_message("start_seoul_intro");
	level.player lightsetforplayer("space_entry");
	level.player setclutforplayer("clut_seoul_pod_v3",0);
	common_scripts\utility::flag_set("spawn_guys_for_intro");
	thread setup_building_traverse_and_vista();
	setup_gangnam_station_intersection();
	level.player notify("disable_player_boost_jump");
}

//Function Number: 34
seoul_land_assist()
{
	soundscripts\_snd::snd_message("start_seoul_first_land_assist");
	maps\_utility::array_delete(getentarray("start_building_ext_hide","targetname"));
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	var_00 = common_scripts\utility::getstruct("struct_start_first_land_assist","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_start_first_land_assist_npc","targetname");
	level.player maps\_utility::teleport_player(var_00);
	common_scripts\utility::flag_set("set_seoul_hotel_lighting");
	common_scripts\utility::flag_set("objective_start");
	setup_gangnam_station_intersection();
	level.will_irons forceteleport(var_01[0].origin,var_01[0].angles);
	level.cormack forceteleport(var_01[1].origin,var_01[1].angles);
	level.jackson forceteleport(var_01[2].origin,var_01[2].angles);
	allies_to_first_land_assist_debug();
	level.player notify("disable_player_boost_jump");
}

//Function Number: 35
seoul_encounter_01()
{
	soundscripts\_snd::snd_message("start_seoul_enemy_encounter_01");
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	var_00 = common_scripts\utility::getstruct("struct_player_start_encounter_01","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_npc_start_encounter_01","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player lightsetforplayer("seoul_hotel_top");
	level.player setclutforplayer("clut_seoul_hotel_atrium",0);
	maps\_utility::vision_set_fog_changes("seoul_hotel_interior",0);
	common_scripts\utility::flag_set("set_seoul_hotel_lighting");
	common_scripts\utility::flag_set("objective_start");
	setup_gangnam_station_intersection();
	level.will_irons forceteleport(var_01[0].origin,var_01[0].angles);
	level.cormack forceteleport(var_01[1].origin,var_01[1].angles);
	level.jackson forceteleport(var_01[2].origin,var_01[2].angles);
	level.player notify("glass_gag_done");
	level.player notify("disable_player_boost_jump");
}

//Function Number: 36
seoul_missile_evade()
{
	soundscripts\_snd::snd_message("start_seoul_missle_evade_sequence");
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	var_00 = common_scripts\utility::getstruct("struct_missile_evade_start","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_missile_evade_start_01","targetname");
	level.player maps\_utility::teleport_player(var_00);
	common_scripts\utility::flag_set("set_seoul_hotel_lighting");
	common_scripts\utility::flag_set("objective_start");
	setup_gangnam_station_intersection();
	level.will_irons forceteleport(var_01[0].origin,var_01[0].angles);
	level.cormack forceteleport(var_01[1].origin,var_01[1].angles);
	level.jackson forceteleport(var_01[2].origin,var_01[2].angles);
}

//Function Number: 37
seoul_fob()
{
	soundscripts\_snd::snd_message("start_seoul_forward_operating_base");
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	var_00 = common_scripts\utility::getstruct("struct_start_point_fob","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_start_point_fob_1","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player lightsetforplayer("seoul_streets");
	level.player setclutforplayer("clut_seoul_fob",0);
	maps\_utility::vision_set_fog_changes("seoul_streets",0);
	common_scripts\utility::flag_set("set_seoul_fob_lighting");
	common_scripts\utility::flag_set("end_lobby_loopers");
	common_scripts\utility::flag_set("objective_start");
	common_scripts\utility::flag_set("begin_looping_fob_functions");
	common_scripts\utility::flag_set("stop_flooding_grunts");
	setup_gangnam_station_intersection();
	level.jackson forceteleport(var_01[2].origin,var_01[2].angles);
	var_02 = common_scripts\utility::getstruct("struct_building_exit_cormack_idle","targetname");
	var_03 = common_scripts\utility::getstruct("struct_building_exit_will_idle","targetname");
	var_02 thread maps\_anim::anim_loop_solo(level.cormack,var_02.animation);
	var_03 thread maps\_anim::anim_loop_solo(level.will_irons,"casual_stand_idle");
	level.will_irons maps\_utility::disable_cqbwalk();
	level.cormack maps\_utility::disable_cqbwalk();
	level.jackson maps\_utility::disable_cqbwalk();
	level.will_irons maps\_utility::set_run_anim("seo_react_to_war_run_npc2");
	level.cormack maps\_utility::set_run_anim("seo_react_to_war_run_npc1");
	level.jackson maps\_utility::set_run_anim("seo_react_to_war_run_npc2");
	wait(0.3);
	common_scripts\utility::flag_set("begin_fob_combat_vignette");
	var_02 notify("stop_loop");
	level.cormack stopanimscripted();
	var_03 notify("stop_loop");
	level.will_irons stopanimscripted();
	level.player notify("trigger_allies_to_fob");
	wait(0.3);
	level.player notify("disable_player_boost_jump");
}

//Function Number: 38
seoul_drone_swarm_intro()
{
	soundscripts\_snd::snd_message("start_seoul_drone_swarm_intro");
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	var_00 = common_scripts\utility::getstruct("struct_start_point_drone_swarm_intro","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_start_point_drone_swarm_intro_1","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player lightsetforplayer("seoul_streets");
	maps\_utility::vision_set_fog_changes("seoul_streets",0);
	common_scripts\utility::flag_set("set_seoul_drone_swarm_intro_lighting");
	common_scripts\utility::flag_set("objective_start");
	var_02 = getent("fob_player_clipblock","targetname");
	var_02 delete();
	thread fob_blocking();
	setup_gangnam_station_intersection();
	level.will_irons forceteleport(var_01[0].origin,var_01[0].angles);
	level.cormack forceteleport(var_01[1].origin,var_01[1].angles);
	level.jackson forceteleport(var_01[2].origin,var_01[2].angles);
	var_03 = getnode("node_hill_pause_will","targetname");
	level.will_irons setgoalnode(var_03);
	var_03 = getnode("node_hill_pause_guy","targetname");
	level.jackson setgoalnode(var_03);
	var_03 = getnode("node_hill_pause_cormack","targetname");
	level.cormack setgoalnode(var_03);
	level.player notify("disable_player_boost_jump");
	thread get_will_to_walker_scene();
	thread get_cormack_to_walker_scene();
}

//Function Number: 39
seoul_truck_push()
{
	soundscripts\_snd::snd_message("start_seoul_truck_push");
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	var_00 = common_scripts\utility::getstruct("struct_start_truck_push_player","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_start_truck_push_01","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player lightsetforplayer("seoul_streets");
	maps\_utility::vision_set_fog_changes("seoul_streets",0);
	common_scripts\utility::flag_set("set_seoul_drone_swarm_intro_lighting");
	setup_gangnam_station_intersection();
	common_scripts\utility::flag_set("objective_start");
	level.will_irons forceteleport(var_01[0].origin,var_01[0].angles);
	level.cormack forceteleport(var_01[1].origin,var_01[1].angles);
	level.jackson forceteleport(var_01[2].origin,var_01[2].angles);
	for(var_02 = 0;var_02 < 30;var_02++)
	{
		level notify("end_cherry_picker");
		wait 0.05;
	}
}

//Function Number: 40
seoul_hotel_entrance()
{
	soundscripts\_snd::snd_message("start_seoul_hotel_entrance");
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	var_00 = common_scripts\utility::getstruct("struct_start_point_hotel_entrance","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_start_point_hotel_entrance_1","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player lightsetforplayer("seoul_street");
	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("seoul_streets_dimfog",0);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("seoul_convention_center",0);
	}

	common_scripts\utility::flag_set("set_seoul_hotel_entrance_lighting");
	setup_gangnam_station_intersection();
	common_scripts\utility::flag_set("objective_start");
	level.will_irons forceteleport(var_01[0].origin,var_01[0].angles);
	level.cormack forceteleport(var_01[1].origin,var_01[1].angles);
	level.jackson forceteleport(var_01[2].origin,var_01[2].angles);
	for(var_02 = 0;var_02 < 30;var_02++)
	{
		level notify("end_cherry_picker");
		wait 0.05;
	}
}

//Function Number: 41
seoul_building_jump_sequence()
{
	soundscripts\_snd::snd_message("start_seoul_building_jump_sequence");
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	var_00 = common_scripts\utility::getstruct("struct_start_point_building_jumps","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_start_point_building_jumps_1","targetname");
	level.player maps\_utility::teleport_player(var_00);
	common_scripts\utility::flag_set("set_seoul_building_jump_sequence_lighting");
	common_scripts\utility::flag_set("objective_start");
	setup_gangnam_station_intersection();
	level.will_irons forceteleport(var_01[0].origin,var_01[0].angles);
	level.cormack forceteleport(var_01[1].origin,var_01[1].angles);
	level.jackson forceteleport(var_01[2].origin,var_01[2].angles);
	thread anim_scene_building_jump();
	var_02 = getent("trig_convention_center_combat_06","targetname");
	var_02 notify("trigger");
}

//Function Number: 42
seoul_start_from_pod()
{
	level waittill("dropped_from_pod");
	setup_gangnam_station_intersection();
}

//Function Number: 43
setup_building_traverse_and_vista()
{
	thread setup_openning_vista();
	thread setup_player_pod_exit();
}

//Function Number: 44
reminder_boost_jump_drone_street()
{
	maps\_shg_design_tools::waittill_trigger_with_name("start_pod_landings_group_3");
}

//Function Number: 45
handle_boost_jump_training()
{
	thread reminder_boost_jump_drone_street();
	self endon("death");
	level endon("missionfailed");
	thread monitor_ever_used_boost();
	for(;;)
	{
		level waittill("boost_jump_reminder");
		if(has_used_boost_recently(60))
		{
			continue;
		}

		maps\_utility::display_hint("jump_training");
		level.player waittill_till_timeout_or_boost(3,60);
		var_00 = 1;
		wait 0.05;
	}
}

//Function Number: 46
monitor_ever_used_boost()
{
	self endon("death");
	level endon("missionfailed");
	for(;;)
	{
		while(!level.player ishighjumping())
		{
			wait 0.05;
		}

		level.player.has_used_boost = gettime() * 0.001;
		wait 0.05;
	}
}

//Function Number: 47
waittill_till_timeout_or_boost(param_00,param_01)
{
	self endon("remove_boost_hint");
	self endon("death");
	level endon("missionfailed");
	while(!has_used_boost_recently(60))
	{
		wait 0.05;
	}
}

//Function Number: 48
boost_hint_breakout()
{
	if(!has_used_boost_recently(60))
	{
		return 0;
	}

	return 1;
}

//Function Number: 49
has_used_boost_recently(param_00)
{
	if(!isdefined(level.player.has_used_boost))
	{
		return 0;
	}

	if(level.player.has_used_boost > gettime() * 0.001 - param_00)
	{
		return 1;
	}

	if(level.player.has_used_boost < gettime() * 0.001 - param_00)
	{
		return 0;
	}
}

//Function Number: 50
handle_boost_slam_training()
{
	level.player thread monitor_boost_slamming();
	common_scripts\utility::flag_wait("canal_jump_complete");
	wait(1.25);
	thread maps\_utility::display_hint("boost_slam_train");
	level.player thread maps\_utility::notify_delay("end_boost_slam_hint",6);
}

//Function Number: 51
monitor_boost_slamming()
{
	self.has_used_boost_slam = gettime() * 0.001;
	for(;;)
	{
		level.player common_scripts\utility::waittill_either("ground_slam","end_boost_slam_hint");
		self.has_used_boost_slam = gettime() * 0.001;
	}
}

//Function Number: 52
slam_hint_breakout()
{
	if(self.has_used_boost_slam < gettime() * 0.001 - 30)
	{
		return 0;
	}

	return 1;
}

//Function Number: 53
handle_boost_dodge_training()
{
	level.player thread monitor_boost_dodging();
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_allies_enter_hotel");
	thread maps\_utility::hintdisplayhandler("boost_dodge_train");
	thread maps\_utility::flag_set_delayed("boost_dodge_hint_off",6);
}

//Function Number: 54
dodge_hint_breakout()
{
	var_00 = gettime() * 0.001 - 20;
	if(common_scripts\utility::flag("boost_dodge_hint_off"))
	{
		return 1;
	}

	if(!isdefined(self.has_used_boost_dodge))
	{
		return 0;
	}

	if(self.has_used_boost_dodge > var_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 55
monitor_boost_dodging()
{
	self.has_used_boost_dodge = undefined;
	level.player waittill("exo_dodge");
	level.player waittill("exo_dodge");
	self.has_used_boost_dodge = 1;
	wait 0.05;
}

//Function Number: 56
handle_land_assist_safe_descent_training()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_look_down_trigger");
	thread get_player_velocity();
	common_scripts\utility::flag_set("ignore_land_assist_hint");
	while(!common_scripts\utility::flag("begin_looping_fob_functions"))
	{
		thread maps\_utility::hintdisplayhandler("x_for_hover_alt");
		while(level.player buttonpressed("BUTTON_X"))
		{
			wait 0.05;
		}

		while(level.player.current_velocity > -400)
		{
			wait 0.05;
		}

		wait 0.05;
	}

	common_scripts\utility::flag_clear("ignore_land_assist_hint");
}

//Function Number: 57
land_assist_hint_safe_descent_breakout()
{
	if(common_scripts\utility::flag("begin_looping_fob_functions"))
	{
		return 1;
	}

	if(level.player buttonpressed("BUTTON_X") && level.player.current_velocity > -200)
	{
		return 1;
	}

	return 0;
}

//Function Number: 58
release_x_breakout()
{
	if(!level.player buttonpressed("BUTTON_X") && level.player.current_velocity < -200)
	{
		return 1;
	}

	return 0;
}

//Function Number: 59
get_player_velocity()
{
	for(;;)
	{
		var_00 = level.player getvelocity();
		level.player.current_velocity = var_00[2];
		wait(0.01);
	}
}

//Function Number: 60
handle_land_assist_training_hover()
{
	var_00 = getent("vol_land_assist_reminder_full","targetname");
	level.player.is_in_force_vol = 0;
	for(;;)
	{
		while(!level.player istouching(var_00))
		{
			level.player.is_in_force_vol = 0;
			wait 0.05;
		}

		level.player.is_in_force_vol = 1;
		maps\_player_land_assist::force_play_land_assist_hint();
		while(!self.land_assist_activated && level.player istouching(var_00))
		{
			wait 0.05;
		}

		thread maps\_utility::hintdisplayhandler("x_for_hover_across");
		while(level.player istouching(var_00) && self.land_assist_activated)
		{
			wait 0.05;
		}
	}
}

//Function Number: 61
hover_hint_breakout()
{
	if(!level.player.is_in_force_vol)
	{
		return 1;
	}

	if(!level.player.land_assist_activated)
	{
		return 1;
	}

	return 0;
}

//Function Number: 62
handle_land_assist_training()
{
	thread handle_force_land_assist();
	self endon("death");
	level endon("missionfailed");
	for(;;)
	{
		while(isdefined(level.player.show_land_assist_help) && level.player.show_land_assist_help == 0)
		{
			wait 0.05;
		}

		level waittill("land_assist_reminder",var_00);
		level.player.has_used_land_assist = undefined;
		level.land_assist_vol = var_00;
		if(!common_scripts\utility::flag("ignore_land_assist_hint"))
		{
			maps\_utility::hintdisplayhandler("x_for_hover");
		}

		waittill_player_uses_land_assist(var_00);
		level.player.has_used_land_assist = 1;
		wait 0.05;
	}
}

//Function Number: 63
handle_force_land_assist()
{
}

//Function Number: 64
land_assist_hint_breakout()
{
	if(!isdefined(level.player.has_used_land_assist))
	{
		return 0;
	}

	if(level.player.land_assist_activated)
	{
		return 1;
	}

	if(level.player.has_used_land_assist)
	{
		return 1;
	}
}

//Function Number: 65
setup_gangnam_station_intersection()
{
	setup_allies();
	level.player thread handle_boost_jump_training();
	level.player thread handle_land_assist_training();
	level.player thread handle_land_assist_training_hover();
	level.player thread handle_land_assist_safe_descent_training();
	thread handle_npcs_paths();
	thread handle_npc_crowds();
	thread gangam_cinematic_warfare_manager();
	thread setup_npc_pod_landings();
	thread handle_fob();
	thread handle_swarm_scene();
	thread handle_alley_traversal();
	thread handle_hotel_entrance();
	thread handle_pac_interior();
	thread handle_wep_drone_dropoff();
	thread initial_ally_wave();
	thread setup_end_scene();
	thread setup_drone_street_fight();
	thread e3_jump_down();
	thread e3_first_fight_in_building();
	thread reset_friendly_fire_when_player_lands();
	maps\_utility::battlechatter_on("allies");
}

//Function Number: 66
handle_sinkhole_enemy_setup()
{
	var_00 = getent("volume_sinkhole_enemy_defend","targetname");
	var_01 = getent("spawner_sinkhole_enemy_defend_g1","targetname");
	var_02 = 3;
	var_03 = getent("spawner_sinkhole_enemy_defend_g2","targetname");
	var_04 = 3;
	var_05 = getnodearray("node_sinkhole_enemy_g1","targetname");
	var_06 = [];
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_sinkhole_drones_attack_civs");
	level notify("autosave_request");
	thread maps\_shg_design_tools::trigger_to_flag("trig_move_allies_up_sinkhole_01","spawn_sinkhole_reinforce");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_sinkhole_enemy_setup");
	if(level.currentgen)
	{
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("killSinkHolePerf",undefined,15,0);
	}

	for(var_07 = 0;var_07 < var_02;var_07++)
	{
		var_08 = var_01 maps\_shg_design_tools::actual_spawn(1);
		var_08 setgoalvolumeauto(var_00);
		var_06[var_06.size] = var_08;
		wait(randomfloat(1.5));
	}

	while(var_06.size > var_05.size - 2 && !common_scripts\utility::flag("spawn_sinkhole_reinforce"))
	{
		var_06 = common_scripts\utility::array_removeundefined(var_06);
		wait 0.05;
	}

	for(var_07 = 0;var_07 < var_04;var_07++)
	{
		var_08 = var_03 maps\_shg_design_tools::actual_spawn(1);
		var_08 setgoalvolumeauto(var_00);
		var_06[var_06.size] = var_08;
		wait(randomfloatrange(1,2));
	}

	while(var_06.size > 1)
	{
		var_06 = common_scripts\utility::array_removeundefined(var_06);
		wait 0.05;
	}

	maps\_utility::activate_trigger_with_targetname("trig_move_allies_up_sinkhole_01");
	while(var_06.size > 0)
	{
		var_06 = common_scripts\utility::array_removeundefined(var_06);
		wait 0.05;
	}

	level notify("vo_area_clear");
}

//Function Number: 67
handle_wep_drone_dropoff()
{
	level notify("kill_wep_drone_dropoff_process");
	level endon("kill_wep_drone_dropoff_process");
	var_00 = getentarray("trig_sinkhole_ai_move_to_jump1","targetname");
	var_00[0] waittill("trigger");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("vehicle_weapons_platform_flyover");
	var_01 thread make_vehicl_invicible();
	var_02 = getent("drone_reflection_05","targetname");
	var_03 = spawn("script_model",var_01.origin);
	var_03 setmodel("vehicle_mil_mwp_static");
	var_03.angles = var_01.angles;
	thread maps\seoul_fx::weaponplf_flyby_dustfx_sinkhole(var_01);
	var_03.origin = var_01.origin;
	var_03.angles = var_01.angles;
	var_03 linkto(var_01,"tag_origin");
	var_01 vehicle_setspeed(0,10,10);
	maps\_shg_design_tools::waittill_trigger_with_name("seoul_weapons_platform_trigger");
	var_01 soundscripts\_snd::snd_message("seo_sinkhole_wp_flyby");
	var_01 vehicle_setspeed(10,10,10);
	var_03 overridereflectionprobe(var_02.origin);
	var_01 hide();
	common_scripts\utility::flag_wait("wep_drone_dropoff_start");
	common_scripts\utility::flag_wait("wp_at_end_of_path");
	var_03 delete();
}

//Function Number: 68
make_vehicl_invicible()
{
	while(isdefined(self))
	{
		self.health = 100000;
		wait 0.05;
	}
}

//Function Number: 69
handle_npc_crowds()
{
	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
}

//Function Number: 70
smart_grenade_training()
{
	thread smart_hint();
	thread maps\_shg_design_tools::trigger_to_notify("trig_convention_center_combat_02","smart_grenade_training");
	thread maps\_shg_design_tools::trigger_to_notify("trig_restaurant_spawn","smart_grenade_training");
}

//Function Number: 71
smart_hint()
{
	thread smart_hint_think();
	for(;;)
	{
		level waittill("smart_grenade_training");
		thread maps\_utility::flag_set_delayed("end_smart_grenade_hint",6);
		thread maps\_utility::flag_clear_delayed("end_smart_grenade_hint",7);
		thread maps\_utility::display_hint("smart_grenade_training");
	}
}

//Function Number: 72
player_used_grenade_recently()
{
	if(!isdefined(level.player.has_used_smart_or_timeout))
	{
		return 0;
	}

	if(level.player.has_used_smart_or_timeout > gettime() * 0.001 - 45)
	{
		return 1;
	}

	return 0;
}

//Function Number: 73
has_grenades_to_throw()
{
	var_00 = level.player getlethalweapon();
	var_01 = weaponmaxammo(var_00);
	var_02 = level.player getammocount(var_00);
	if(var_02 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 74
smart_hint_think()
{
	level.player.has_used_smart_or_timeout = undefined;
	for(;;)
	{
		level.player waittill("rb_pressed");
		level.player.has_used_smart_or_timeout = gettime() * 0.001;
	}
}

//Function Number: 75
smart_hint_breakout()
{
	if(common_scripts\utility::flag("end_smart_grenade_hint"))
	{
		return 1;
	}

	if(player_used_grenade_recently())
	{
		return 1;
	}

	if(!has_grenades_to_throw())
	{
		return 1;
	}

	return 0;
}

//Function Number: 76
ads_hint()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_starte_first_fight");
	thread ads_hint_breakout_think();
	thread maps\_utility::hintdisplayhandler("ads_train");
}

//Function Number: 77
ads_hint_breakout_think()
{
	thread maps\_utility::notify_delay("3sectimeout",3);
	level common_scripts\utility::waittill_either("first_fight_guy_dead","3sectimeout");
	level.player.has_used_ads_or_timeout = 1;
}

//Function Number: 78
ads_hint_breakout()
{
	if(!isdefined(level.player.has_used_ads_or_timeout))
	{
		return 0;
	}

	if(level.player.has_used_ads_or_timeout)
	{
		return 1;
	}
}

//Function Number: 79
e3_first_fight_in_building()
{
	level waittill("droppod_empty");
	level endon("cormack_to_first_land_assist");
	var_00 = getent("spawner_enemy_building_traverse_crush_gag","targetname");
	thread ads_hint();
	thread maps\_shg_design_tools::trigger_to_flag("trig_break_first_fight_anims","wake_up_ambush_guys");
	thread setup_first_fight_left_guy(var_00,"struct_e3_building_first_fight_left_1");
	thread setup_first_fight_right_guy1(var_00,"struct_e3_building_first_fight_right_2");
	thread setup_first_fight_right_guy2(var_00,"struct_e3_building_first_fight_right_1");
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		level waittill("first_fight_guy_dead");
	}

	level notify("first_fight_done");
	maps\_utility::activate_trigger_with_targetname("trig_guys_move_up_after_first_fight");
	level notify("autosave_request");
}

//Function Number: 80
setup_first_fight_right_guy1(param_00,param_01)
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_starte_first_fight");
	common_scripts\utility::flag_set("vo_nk_first_contact_start");
	var_02 = param_00 maps\_shg_design_tools::actual_spawn(1);
	var_03 = param_00 maps\_shg_design_tools::actual_spawn(1);
	var_02 endon("end_ambush_behavior");
	var_03 endon("end_ambush_behavior");
	var_04 = common_scripts\utility::getstruct("struct_first_fight_teaser_01a","targetname");
	var_05 = common_scripts\utility::getstruct("struct_first_fight_teaser_01b","targetname");
	var_06 = common_scripts\utility::getstruct("struct_first_fight_teaser_02a","targetname");
	var_07 = common_scripts\utility::getstruct("struct_first_fight_teaser_02b","targetname");
	var_02 forceteleport(var_04.origin,var_04.angles);
	var_03 forceteleport(var_04.origin,var_04.angles);
	level thread maps\_utility::notify_delay("enter_e3_first_fight_enemies",4.2);
	var_02 maps\_utility::enable_cqbwalk();
	var_02 thread maps\_shg_design_tools::notify_on_death(var_02,"first_fight_guy_dead");
	var_02.goalradius = 32;
	var_02.ignoreall = 1;
	var_02 maps\_utility::disable_long_death();
	var_02 setgoalpos(var_05.origin);
	var_02 thread end_first_fight_behavior_think();
	var_03 maps\_utility::enable_cqbwalk();
	var_03 thread maps\_shg_design_tools::notify_on_death(var_02,"first_fight_guy_dead");
	var_03.goalradius = 32;
	var_03 maps\_utility::disable_long_death();
	var_03 setgoalpos(var_07.origin);
	var_03.ignoreall = 1;
	var_03 thread end_first_fight_behavior_think();
	wait(1.5);
	level notify("nk_soldier_spotted");
	wait(3.5);
	if(isdefined(var_02))
	{
		var_02.ignoreall = 0;
	}

	if(isdefined(var_03))
	{
		var_03.ignoreall = 0;
	}

	wait(2.5);
	if(isdefined(var_02))
	{
		var_02 setgoalentity(level.player);
	}

	if(isdefined(var_03))
	{
		var_03 setgoalentity(level.player);
	}
}

//Function Number: 81
setup_first_fight_left_guy(param_00,param_01)
{
	var_02 = common_scripts\utility::getstruct(param_01,"targetname");
	var_03 = param_00 maps\_shg_design_tools::actual_spawn(1);
	thread maps\_shg_design_tools::notify_on_death(var_03,"first_fight_guy_dead");
	var_03 thread fake_anim_shoot("first_fight_guy_dead");
	var_03 thread end_first_fight_behavior_think(var_02,"det_corner_check_left_enter");
	var_03 endon("death");
	var_03 endon("end_ambush_behavior");
	var_02 thread maps\_anim::anim_generic_first_frame(var_03,"det_corner_check_left_enter");
	var_03.allowdeath = 1;
	var_03 maps\_utility::disable_long_death();
	var_03.anim_1 = "det_corner_check_left_enter";
	var_03.anim_2 = "det_corner_check_left_loop";
	var_03.anim_3 = "det_corner_check_left_exit";
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_starte_first_fight");
	common_scripts\utility::flag_wait_or_timeout("wake_up_ambush_guys",3);
	if(common_scripts\utility::flag("wake_up_ambush_guys"))
	{
		var_03 maps\_utility::anim_stopanimscripted();
	}
	else
	{
		var_03 thread monitor_player_sprinting_past_ambush("wake_up_ambush_guys");
		var_03 thread common_scripts\utility::delaycall(1,::laseron,"lag_snipper_laser");
		var_03 maps\_utility::anim_stopanimscripted();
		var_03 thread allow_death_delay();
		var_02 maps\_anim::anim_generic(var_03,var_03.anim_1);
		var_03.allowdeath = 1;
		if(!isdefined(var_03.ambush_breakout))
		{
			var_03 thread maps\_anim::anim_generic(var_03,var_03.anim_3);
			var_03.allowdeath = 1;
		}

		var_03 notify("ambush_anims_done");
	}

	var_03 common_scripts\utility::waittill_any("damage","death");
	level notify("e3_first_fight_is_on");
}

//Function Number: 82
monitor_player_sprinting_past_ambush(param_00)
{
	self endon("death");
	self endon("ambush_anims_done");
	common_scripts\utility::flag_wait(param_00);
	maps\_utility::anim_stopanimscripted();
	self.ambush_breakout = 1;
}

//Function Number: 83
setup_first_fight_right_guy2(param_00,param_01)
{
	var_02 = common_scripts\utility::getstruct(param_01,"targetname");
	var_03 = param_00 maps\_shg_design_tools::actual_spawn(1);
	var_03 maps\_utility::disable_long_death();
	var_03 thread end_first_fight_behavior_think(var_02,"det_corner_check_right_into");
	thread maps\_shg_design_tools::notify_on_death(var_03,"first_fight_guy_dead");
	var_03 thread fake_anim_shoot("first_fight_guy_dead");
	var_03 endon("death");
	var_03 endon("end_ambush_behavior");
	var_02 thread maps\_anim::anim_generic_first_frame(var_03,"det_corner_check_right_into");
	var_03.anim_struct = var_02;
	var_03.anim_1 = "det_corner_check_right_into";
	var_03.anim_2 = "det_corner_check_right_loop";
	var_03.anim_3 = "det_corner_check_right_exit";
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_starte_first_fight");
	common_scripts\utility::flag_wait_or_timeout("wake_up_ambush_guys",3.5);
	var_03 maps\_utility::anim_stopanimscripted();
	if(!common_scripts\utility::flag("wake_up_ambush_guys"))
	{
		var_03 thread monitor_player_sprinting_past_ambush("wake_up_ambush_guys");
		var_03 thread allow_death_delay();
		var_02 maps\_anim::anim_generic(var_03,var_03.anim_1);
		var_03.allowdeath = 1;
		var_03 thread maps\_anim::anim_generic_loop(var_03,var_03.anim_2);
		common_scripts\utility::flag_wait_or_timeout("wake_up_ambush_guys",2);
		var_03 maps\_utility::anim_stopanimscripted();
		var_03 notify("stop_loop");
		if(!common_scripts\utility::flag("wake_up_ambush_guys"))
		{
			var_03 thread maps\_anim::anim_generic(var_03,var_03.anim_3);
			var_03.allowdeath = 1;
		}

		var_03 notify("ambush_anims_done");
	}

	if(common_scripts\utility::flag("wake_up_ambush_guys"))
	{
		var_03 maps\_utility::anim_stopanimscripted();
		return;
	}

	var_03 thread common_scripts\utility::delaycall(1,::laseron,"lag_snipper_laser");
	var_03 maps\_utility::anim_stopanimscripted();
	var_03 thread allow_death_delay();
	var_02 maps\_anim::anim_generic(var_03,var_03.anim_1);
	var_03.allowdeath = 1;
	var_03 thread maps\_anim::anim_generic(var_03,var_03.anim_3);
	var_03.allowdeath = 1;
}

//Function Number: 84
end_first_fight_behavior_think(param_00,param_01)
{
	self endon("death");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_break_first_fight_anims");
	self notify("end_ambush_behavior");
	maps\_utility::anim_stopanimscripted();
	self notify("stop_loop");
	if(isdefined(param_00) && isdefined(param_01))
	{
		param_00 thread maps\_anim::anim_generic(self,param_01);
		wait 0.05;
		maps\_utility::anim_stopanimscripted();
		self notify("stop_loop");
	}

	self.ignoreall = 0;
	self setgoalentity(level.player);
}

//Function Number: 85
fake_anim_shoot(param_00)
{
	var_01 = self;
	var_01 endon("death");
	level waittill(param_00);
	while(isdefined(var_01))
	{
		for(var_02 = 0;var_02 < 5;var_02++)
		{
			var_01 shoot();
			wait(0.1);
		}

		wait(0.5);
	}
}

//Function Number: 86
handle_alley_traversal()
{
	var_00 = getent("model_exo_push_car_gag","targetname");
	var_01 = common_scripts\utility::getstruct("struct_exo_car_push_gag_1","targetname");
	var_02 = common_scripts\utility::getstruct("struct_exo_car_push_gag_2","targetname");
}

//Function Number: 87
jump_anim_with_gravity(param_00,param_01,param_02,param_03)
{
	maps\_anim::anim_generic(param_00,param_01);
	param_00 maps\_anim::anim_generic_gravity(param_00,"boost_jump_256_across_256_down");
	param_00.anim_tag = param_02 common_scripts\utility::spawn_tag_origin();
	param_00.anim_tag thread maps\_shg_design_tools::anim_simple(param_00,param_03);
}

//Function Number: 88
handle_npcs_paths()
{
	thread setup_npc_paths();
	thread allies_to_first_land_assist();
	thread allies_to_building_exit();
	thread allies_to_fob();
	thread allies_to_hill();
	thread allies_to_drone_swarm();
	thread allies_to_truck_jump();
	thread allies_to_weapons_platform_video_log();
}

//Function Number: 89
e3_handle_bus_top_enemies(param_00)
{
	var_01 = getent("e3_vol_enemy_bus_vol","targetname");
	var_02 = getnode("e3_node_enemy_cover_group_04","targetname");
	var_03 = undefined;
	for(;;)
	{
		while(!isdefined(var_03))
		{
			var_03 = common_scripts\utility::random(param_00);
			wait(0.05);
		}

		var_03 setthreatbiasgroup("enemies_ignored_by_allies");
		var_03 thread threat_bias_remove_delay(18);
		var_03 setgoalnode(var_02);
		var_03 thread ragdolldeath();
		var_03 waittill("death");
	}
}

//Function Number: 90
threat_bias_remove_delay(param_00)
{
	self endon("death");
	wait(param_00);
	self setthreatbiasgroup();
}

//Function Number: 91
handle_ally_movement()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_drone_street_move_position2");
	var_00 = getnode("e3_node_will_position_2","targetname");
	var_01 = getnode("e3_node_cormack_position_2","targetname");
	var_02 = getnode("e3_node_jackson_position_2","targetname");
	level.will_irons setgoalnode(var_00);
	level.cormack setgoalnode(var_01);
	level.jackson setgoalnode(var_02);
	common_scripts\utility::flag_wait("snake_swarm_first_flyby_begin");
	var_03 = getnodearray("e3_node_ally_cover_group_02","targetname");
	level notify("end_drone_street_reinforce");
	foreach(var_06, var_05 in level.drone_street_allies)
	{
		if(!isdefined(var_05))
		{
			continue;
		}

		if(!isdefined(var_03[var_06]))
		{
			var_05 kill();
			continue;
		}

		var_05 setgoalnode(var_03[var_06]);
	}
}

//Function Number: 92
save_game_big_jump()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_land_assist_jump_01");
	level notify("autosave_request");
}

//Function Number: 93
e3_jump_down()
{
	var_00 = common_scripts\utility::getstructarray("struct_e3_drop_hack_01","targetname");
	thread save_game_big_jump();
	thread get_cormack_to_building_doorway();
	thread get_will_to_building_doorway();
	var_01 = common_scripts\utility::getstruct("struct_ally_big_drop_jack","targetname");
	var_02 = common_scripts\utility::getstruct("struct_ally_big_drop_cormack","targetname");
	level waittill("e3_jump_end_scene_end");
	var_03 = maps\_shg_design_tools::getthing("struct_land_assist_cormack_01b","targetname");
	level.jackson guy_jump_to_breach_stackup_jackson(var_03);
	common_scripts\utility::flag_wait("player_landed_in_hotel");
}

//Function Number: 94
reset_friendly_fire_when_player_lands()
{
	common_scripts\utility::flag_wait("player_landed_in_hotel");
	level.player.participation = 0;
}

//Function Number: 95
get_cormack_to_building_doorway()
{
	var_00 = common_scripts\utility::getstruct("struct_ally_big_drop_cormack","targetname");
	var_01 = common_scripts\utility::getstruct("struct_bottom_of_building_cormack","targetname");
	level.cormack waittill("i_have_landed");
	level.cormack maps\_shg_design_tools::anim_stop(level.cormack.anim_org);
	level.cormack maps\_shg_design_tools::anim_stop(level.cormack.anim_tag);
	waittillframeend;
	level notify("e3_jump_end_scene_end");
	level.cormack maps\_utility::disable_cqbwalk();
	level.cormack.ignoreall = 1;
	level.cormack maps\_utility::set_run_anim("seo_react_to_war_run_npc1");
	level.cormack thread anim_scene_building_exit_cormack("struct_building_exit_cormack");
}

//Function Number: 96
get_will_to_building_doorway()
{
	level.will_irons waittill("i_have_landed");
	level.will_irons maps\_shg_design_tools::anim_stop(level.will_irons.anim_org);
	level.will_irons maps\_shg_design_tools::anim_stop(level.will_irons.anim_tag);
	waittillframeend;
	level notify("e3_jump_end_scene_end");
	level.will_irons maps\_utility::disable_cqbwalk();
	level.will_irons.ignoreall = 1;
	level.will_irons maps\_utility::set_run_anim("seo_react_to_war_run_npc2");
	level.will_irons thread anim_scene_building_exit_will("struct_building_exit_will");
}

//Function Number: 97
handle_drone_teasers()
{
	maps\_shg_design_tools::waittill_trigger_with_name("start_pod_landings_group_3");
	wait(5);
	var_00 = getentarray("spawner_drone_street_teasers","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_vehicle::spawn_vehicle_and_gopath();
		var_03 soundscripts\_snd::snd_message("seo_single_drones_flyby");
		wait(randomfloatrange(0.05,0.35));
	}
}

//Function Number: 98
handle_player_on_left_street()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_player_on left_street");
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		if(common_scripts\utility::cointoss())
		{
			var_02 setthreatbiasgroup("enemies_attack_player");
		}
	}
}

//Function Number: 99
setup_drone_street_fight()
{
	level waittill("begin_e3_fight");
	maps\_utility::battlechatter_on("allies");
	maps\_utility::battlechatter_on("axis");
	level.e3_enemies = [];
	thread handle_ally_movement();
	thread handle_player_on_left_street();
	level.player notify("enable_player_boost_jump");
	var_00 = getentarray("clip_only_when_boost_off","targetname");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin + (0,0,30000);
	}

	var_04 = getentarray("e3_spawner_enemy_drone_street","targetname");
	var_05 = getentarray("e3_spawner_trench_allies_group_01","targetname");
	var_06 = getnodearray("e3_node_enemy_cover_group_01","targetname");
	var_07 = getnodearray("e3_node_enemy_cover_group_02","targetname");
	var_08 = getentarray("e3_node_enemy_cover_group_03","targetname");
	var_09 = getnodearray("e3_node_ally_cover_group_01","targetname");
	var_0A = getent("e3_vol_enemey_retreat","targetname");
	var_0B = getent("e3_vol_enemey_retreat2","targetname");
	if(level.currentgen)
	{
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("snake_charge_initiated",undefined,10,0);
		var_0C = getent("cg_street_spawn_trigger","targetname");
		var_0C waittill("trigger");
		common_scripts\utility::flag_set("player_passed_fob");
	}

	if(level.currentgen && !istransientloaded("seoul_drone_swarm_one_tr"))
	{
		while(!istransientloaded("seoul_drone_swarm_one_tr"))
		{
			wait(0.05);
		}
	}

	var_0D = [];
	foreach(var_0F in var_06)
	{
		var_10 = common_scripts\utility::random(var_04);
		var_11 = drone_street_fight_enemy_func(var_10,var_0F);
		var_0D[var_0D.size] = var_11;
		if(level.currentgen)
		{
			wait(0.1);
		}
	}

	var_13 = [];
	foreach(var_0F in var_07)
	{
		var_10 = common_scripts\utility::random(var_04);
		var_11 = drone_street_fight_enemy_func(var_10,var_0F);
		var_13[var_13.size] = var_11;
		if(level.currentgen)
		{
			wait(0.1);
		}
	}

	level.drone_street_allies = [];
	wait(3);
	if(level.nextgen)
	{
		thread spawn_drone_street_allies_and_reinforce(var_09,var_05);
	}

	thread e3_drone_swarm_strafe(level.drone_street_allies);
	var_0D = common_scripts\utility::array_combine(var_0D,var_13);
	thread e3_handle_bus_top_enemies(var_0D);
	thread monitor_drone_street_enemy_count(var_0D);
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_drone_street_move_position2");
	var_0D = getaiarray("axis");
	foreach(var_11 in var_0D)
	{
		if(isdefined(var_11))
		{
			var_11 setgoalvolumeauto(var_0B);
			var_11 thread common_scripts\utility::delaycall(randomfloat(4),::kill);
			wait(randomfloat(1));
		}
	}

	var_18 = getaiarray("allies");
	foreach(var_11 in var_18)
	{
		if(isdefined(var_11))
		{
			var_11.accuracy = 0;
		}
	}

	level.player waittill("player_in_x4walker");
	foreach(var_11 in var_0D)
	{
		if(isdefined(var_11))
		{
			var_11 kill();
		}
	}
}

//Function Number: 100
monitor_drone_street_enemy_count(param_00)
{
	while(param_00.size > 2)
	{
		param_00 = maps\_utility::array_removedead_or_dying(param_00);
		wait 0.05;
	}

	maps\_utility::activate_trigger_with_targetname("trigger_drone_street_move_position2");
}

//Function Number: 101
drone_street_fight_enemy_func(param_00,param_01)
{
	var_02 = param_00 maps\_shg_design_tools::actual_spawn(1);
	var_02 thread maps\_shg_design_tools::killonbadpath();
	var_02 thread e3_handle_threat_detection();
	var_02 thread ragdolldeath();
	var_02 thread handle_drone_street_health_hack();
	var_02 setgoalnode(param_01);
	var_02.grenadeammo = 0;
	var_02.accuracy = 0.2;
	var_02.goalradius = 196;
	var_02.dropweapon = 1;
	if(!isdefined(var_02))
	{
		return;
	}

	if(isalive(var_02))
	{
		var_02 maps\_utility::disable_long_death();
	}

	return var_02;
}

//Function Number: 102
handle_drone_street_health_hack()
{
	self endon("death");
	level endon("player_on_scene");
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(var_01 != level.player && isdefined(self))
		{
			self.health = self.health + int(var_00 * 0.75);
			continue;
		}

		if(isdefined(self))
		{
			level thread maps\_utility::notify_delay("player_on_scene",3);
		}
	}
}

//Function Number: 103
ragdolldeath()
{
	self waittill("death");
	if(isdefined(self))
	{
		self startragdoll();
	}
}

//Function Number: 104
spawn_drone_street_allies_and_reinforce(param_00,param_01)
{
	level endon("end_drone_street_reinforce");
	foreach(var_03 in param_00)
	{
		thread spawn_drone_street_ally(var_03,param_01);
	}
}

//Function Number: 105
spawn_drone_street_ally(param_00,param_01)
{
	level endon("end_drone_street_reinforce");
	var_02 = undefined;
	while(!isdefined(var_02))
	{
		var_02 = common_scripts\utility::random(param_01) maps\_utility::spawn_ai();
		wait 0.05;
	}

	if(!isdefined(var_02))
	{
		return;
	}

	level.drone_street_allies[level.drone_street_allies.size] = var_02;
	var_02 setgoalnode(param_00);
	var_02.canjumppath = 1;
	var_02 maps\_utility::disable_pain();
	var_02.accuracy = 0;
	var_02 thread reinforce_on_death(param_00,param_01);
	return var_02;
}

//Function Number: 106
reinforce_on_death(param_00,param_01,param_02)
{
	level endon("end_drone_street_reinforce");
	if(isdefined(param_02))
	{
		level endon(param_02);
	}

	var_03 = self;
	for(;;)
	{
		var_03 waittill("death");
		wait(1);
		var_03 = spawn_drone_street_ally(param_00,param_01);
	}
}

//Function Number: 107
e3_handle_threat_detection()
{
	self endon("death");
	for(;;)
	{
		self waittill("detected");
		level notify("threat_detected");
		level.walker_tank.targetlist[level.walker_tank.targetlist.size] = self;
		if(common_scripts\utility::cointoss())
		{
			badplace_cylinder("temp_detected_badplace",5,self.origin,32,96,"axis");
		}
	}
}

//Function Number: 108
e3_drone_swarm_strafe(param_00)
{
	common_scripts\utility::flag_wait("flag_drone_street_strafe");
	level notify("end_drone_strret_fight");
	var_01 = common_scripts\utility::getclosest(level.player.origin,level.flock_drones,3000);
	param_00 = maps\_shg_design_tools::sortbydistanceauto(level.drone_street_allies,var_01.origin);
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = common_scripts\utility::getclosest(var_03.origin,level.flock_drones,3000);
		var_05 = var_04.origin;
		var_04 delete();
		var_06 = magicbullet("remote_missile_drone_light",var_05,var_03.origin);
		if(common_scripts\utility::cointoss())
		{
			wait(0.2);
			var_06 = magicbullet("remote_missile_drone_light",var_05,var_03.origin);
		}

		wait(randomfloatrange(1,2));
	}
}

//Function Number: 109
e3_handle_threat_shooting()
{
	self.targetlist = [];
	while(maps\_shg_design_tools::isvehiclealive(self))
	{
		level waittill("threat_detected");
		var_00 = [];
		var_00[0] = "launcher_right";
		var_00[1] = "launcher_left";
		wait(2.5);
		if(!maps\_shg_design_tools::isvehiclealive(self))
		{
			continue;
		}

		var_01 = randomintrange(2,4);
		vehicle_scripts\_walker_tank::fire_missles_at_target_array(self.targetlist,var_01);
	}
}

//Function Number: 110
handle_walker_tank_firing()
{
	wait 0.05;
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_01 = common_scripts\utility::getstructarray("enemy_fire","targetname");
	vehicle_scripts\_walker_tank::enable_firing(-1);
	vehicle_scripts\_walker_tank::disable_firing(0);
	vehicle_scripts\_walker_tank::disable_firing(1);
	vehicle_scripts\_walker_tank::disable_firing(2);
	vehicle_scripts\_walker_tank::enable_tracking(-1);
	vehicle_scripts\_walker_tank::disable_tracking(0);
	vehicle_scripts\_walker_tank::disable_tracking(1);
	vehicle_scripts\_walker_tank::disable_tracking(2);
	while(!common_scripts\utility::flag("player_in_x4walker"))
	{
		wait(randomintrange(3,8));
		var_02 = common_scripts\utility::random(var_01);
		var_00.origin = var_02.origin;
		if(maps\_shg_design_tools::isvehiclealive(self))
		{
			vehicle_scripts\_walker_tank::set_forced_target(var_00,-1);
			continue;
		}

		return;
		wait 0.05;
	}

	vehicle_scripts\_walker_tank::disable_firing(-1);
	vehicle_scripts\_walker_tank::disable_tracking(-1);
	vehicle_scripts\_walker_tank::enable_tracking(1);
	vehicle_scripts\_walker_tank::enable_tracking(2);
	vehicle_scripts\_walker_tank::enable_firing(1);
	vehicle_scripts\_walker_tank::enable_firing(2);
	thread fire_missiles_at_drone_swarm();
	while(maps\_shg_design_tools::isvehiclealive(self))
	{
		var_03 = common_scripts\utility::getclosest(self.origin,level.flock_drones);
		vehicle_scripts\_walker_tank::set_forced_target(var_03,1);
		wait(0.1);
		if(!maps\_shg_design_tools::isvehiclealive(self))
		{
			continue;
		}

		var_04 = common_scripts\utility::getclosest(self.origin,level.flock_drones);
		vehicle_scripts\_walker_tank::set_forced_target(var_04,2);
		while(isdefined(var_03))
		{
			wait 0.05;
		}

		wait 0.05;
	}
}

//Function Number: 111
fire_missiles_at_drone_swarm()
{
	level endon("end_cherry_picker");
	self endon("death");
	for(;;)
	{
		wait(randomfloatrange(4,5));
		var_00 = 4;
		var_01 = [];
		for(var_02 = 0;var_02 < var_00;var_02++)
		{
			var_01[var_02] = common_scripts\utility::random(level.flock_drones);
		}

		self.missiles_loaded_count = var_01.size;
		vehicle_scripts\_walker_tank::fire_missles_at_target_array(var_01,1);
		self notify("tank_shot");
	}
}

//Function Number: 112
make_walker()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_fob"))
	{
		level waittill("transients_intro_to_fob");
	}

	var_00 = getent("walker_tank_for_stepover","targetname");
	var_00.script_disconnectpaths = 0;
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("walker_tank_for_stepover");
	var_01 notify("stop_vehicle_shoot_shock");
	var_01.script_disconnectpaths = 0;
	var_01.animname = "walker_tank";
	var_01 maps\_anim::setanimtree();
	if(level.currentgen)
	{
	}

	return var_01;
}

//Function Number: 113
handle_stepover_scene_clip()
{
	var_00 = getent("temp_clip_for_walker_anim_scene","targetname");
	level waittill("stepover_anim_scene_done_character");
	var_00.origin = var_00.origin + (0,0,100000);
}

//Function Number: 114
anim_scene_walker_stepover()
{
	if(level.nextgen)
	{
		thread handle_stepover_scene_clip();
	}

	var_00 = common_scripts\utility::getstruct("struct_walker_walkover_scene","targetname");
	var_01 = make_walker();
	wait(1);
	var_02 = var_00 common_scripts\utility::spawn_tag_origin();
	var_02 thread maps\_anim::anim_loop_solo(var_01,"walker_step_idle_1");
	var_01 thread handle_walker_tank_firing();
	level.walker_tank = var_01;
	thread make_walker_invulnerable();
	var_01 thread e3_handle_threat_shooting();
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_hill_event_00");
	common_scripts\utility::flag_set("dialogue_trench_demo_team");
	level notify("remove_path_blockers_fob");
	level.cormack maps\_utility::disable_cqbwalk();
	level.will_irons maps\_utility::disable_cqbwalk();
	waittill_has_reached_hill_idle();
	level notify("begin_e3_fight");
	common_scripts\utility::flag_wait("dialogue_trench_demo_team");
	level.cormack.anim_struct notify("stop_loop");
	level.cormack maps\_utility::anim_stopanimscripted();
	level.will_irons.anim_struct notify("stop_loop");
	level.will_irons maps\_utility::anim_stopanimscripted();
	level.will_irons.anim_struct thread maps\_anim::anim_single_solo(level.will_irons,"fob_meet_post_exit_2");
	level.cormack.anim_struct maps\_anim::anim_single_solo(level.cormack,"fob_meet_post_exit_1");
	level.cormack maps\_utility::set_moveplaybackrate(1);
	level.will_irons maps\_utility::set_moveplaybackrate(1);
	var_03 = [level.cormack,level.will_irons];
	var_04 = getnode("node_hill_pause_guy2","targetname");
	level.jackson setgoalnode(var_04);
	var_01 thread maps\_shg_design_tools::anim_stop(var_02);
	thread actor_playscene_walker_stepover_cormack();
	thread actor_playscene_walker_stepover_will();
	thread actor_playscene_walker_stepover_jackson();
	level notify("autosave_request");
	level thread maps\seoul_fx::titan_camera_shake(var_01);
	var_01 soundscripts\_snd::snd_message("walker_step_over");
	var_01 thread handle_allow_death_for_walker_tank();
	var_00 maps\_anim::anim_single_solo(var_01,"walker_step_over");
	if(isdefined(var_01))
	{
		var_00 thread maps\_anim::anim_loop_solo(var_01,"walker_step_idle_2");
	}

	level notify("anim_walker_stepoaver_scene_done");
}

//Function Number: 115
handle_allow_death_for_walker_tank()
{
	for(var_00 = 0;var_00 < 20;var_00++)
	{
		self.allowdeath = 1;
		wait 0.05;
	}
}

//Function Number: 116
waittill_has_reached_hill_idle()
{
	common_scripts\utility::flag_wait_all("flag_will_irons_has_arrived_at_hill","flag_cormack_has_arrived_at_hill");
}

//Function Number: 117
actor_playscene_walker_stepover_will()
{
	var_00 = common_scripts\utility::getstruct("struct_walker_walkover_scene","targetname");
	var_00 maps\_anim::anim_single_solo_run(level.will_irons,"walker_step_over");
	level.will_irons maps\_utility::clear_run_anim();
	level.will_irons maps\_utility::set_moveplaybackrate(1);
	level notify("heroes_done_with_walker_anim_scene");
	var_01 = getnode("node_drone_section_will_01","targetname");
	level.will_irons setgoalnode(var_01);
	level.will_irons.fixednode = 1;
	level.will_irons maps\_utility::set_force_color("o");
}

//Function Number: 118
actor_playscene_walker_stepover_jackson()
{
	level waittill("heroes_done_with_walker_anim_scene");
	var_00 = getnode("node_drone_section_jackson_01","targetname");
	level.jackson setgoalnode(var_00);
	level.jackson.fixednode = 1;
}

//Function Number: 119
actor_playscene_walker_stepover_cormack()
{
	var_00 = common_scripts\utility::getstruct("struct_walker_walkover_scene","targetname");
	var_00 maps\_anim::anim_single_solo_run(level.cormack,"walker_step_over");
	level.cormack maps\_utility::clear_run_anim();
	level.cormack maps\_utility::set_moveplaybackrate(1);
	var_01 = getnode("node_drone_section_cormack_01","targetname");
	level.cormack setgoalnode(var_01);
	level.cormack.fixednode = 1;
	level notify("stepover_anim_scene_done_character");
}

//Function Number: 120
disable_exo_during_land_assist()
{
	level waittill("begin_land_assist_training");
	level.player thread maps\_player_exo::unsetexoslam();
	level.player allowdodge(0);
	common_scripts\utility::flag_wait("player_landed_in_hotel");
	wait(2);
	level.player thread maps\_player_exo::setexoslam();
	level.player allowdodge(1);
}

//Function Number: 121
allies_to_first_land_assist()
{
	level endon("e3_jump_end_scene");
	thread change_fall_tollerance(600,800,"player_landed_in_hotel");
	var_00 = maps\_shg_design_tools::getthing("struct_land_assist_first_jump","targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	level waittill("begin_building_traversal");
	maps\_utility::activate_trigger("trigger_start_script_color_will","targetname");
	maps\_utility::activate_trigger("trigger_start_script_color","targetname");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_guys_to_first_land_assist");
	maps\_utility::player_speed_percent(100);
	thread disable_exo_during_land_assist();
	thread get_cormack_into_first_landassist();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_cormack_trigger_will_first_landassist");
	thread get_will_into_first_landassist();
	wait(2);
	common_scripts\utility::flag_set("dialogue_hotel_top_floor_landassist");
	level notify("begin_land_assist_training");
	common_scripts\utility::flag_wait("player_landed_in_hotel");
	wait(2);
	return_fall_tollerance();
}

//Function Number: 122
move_player_view_at_ledge()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_look_down_trigger");
	var_00 = common_scripts\utility::spawn_tag_origin();
	level.player playersetgroundreferenceent(var_00);
	for(var_01 = 0;var_01 < 45;var_01++)
	{
		if(!level.player maps\_player_land_assist::is_land_assist_activated())
		{
			var_02 = var_01;
			var_03 = level.player getgunangles()[1];
			var_00 rotateto((var_02,var_03,0),0.05);
			maps\_utility::lerp_player_view_to_position(var_00.origin,var_00.angles,0.05);
			wait 0.05;
		}
	}
}

//Function Number: 123
rotate_ent_towards_center(param_00)
{
	var_01 = (0,vectortoangles(param_00.origin - self.origin)[1],0);
	var_02 = 0.5;
	var_03 = (var_02,var_01[1],0);
	var_04 = transformmove(self.origin,var_03,self.origin,var_01,self.origin,self.angles);
	return var_04["angles"];
}

//Function Number: 124
allies_to_first_land_assist_debug()
{
	var_00 = maps\_shg_design_tools::getthing("struct_land_assist_first_jump","targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	thread get_cormack_into_first_landassist();
	thread get_will_into_first_landassist();
	thread disable_exo_during_land_assist();
	wait(2);
	thread change_fall_tollerance(600,800,"player_landed_in_hotel");
	common_scripts\utility::flag_set("dialogue_hotel_top_floor_landassist");
	level notify("begin_land_assist_training");
	common_scripts\utility::flag_wait("player_landed_in_hotel");
	wait(3);
	return_fall_tollerance();
}

//Function Number: 125
change_fall_tollerance(param_00,param_01,param_02)
{
	while(!common_scripts\utility::flag(param_02))
	{
		setsaveddvar("bg_fallDamageMinHeight",param_00);
		setsaveddvar("bg_fallDamageMaxHeight",param_01);
		wait 0.05;
	}
}

//Function Number: 126
return_fall_tollerance()
{
	for(var_00 = 0;var_00 < 30;var_00++)
	{
		setsaveddvar("bg_fallDamageMinHeight",490);
		setsaveddvar("bg_fallDamageMaxHeight",640);
		wait 0.05;
	}
}

//Function Number: 127
get_cormack_into_first_landassist()
{
	level endon("e3_jump_end_scene");
	level notify("cormack_to_first_land_assist");
	level.cormack notify("goal");
	level.cormack maps\_utility::disable_ai_color();
	var_00 = maps\_shg_design_tools::getthing("struct_land_assist_cormack_01b","targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	var_01 maps\_anim::anim_reach_solo(level.cormack,"first_landassist_enter");
	var_01 maps\_anim::anim_single_solo(level.cormack,"first_landassist_enter");
	level.cormack.anim_org = var_01;
	if(!common_scripts\utility::flag("flag_first_land_assist") || !common_scripts\utility::flag("land_assist_activated") || !common_scripts\utility::flag("begin_looping_fob_functions"))
	{
		var_01 thread maps\_anim::anim_loop_solo(level.cormack,"first_landassist_idle");
		waittill_player_uses_land_assist_or_is_a_jerk();
	}

	level notify("e3_trigger_big_jump_hack");
	level.cormack thread guy_jump_to_breach_stackup_cormack(var_01);
	level.cormack maps\_utility::enable_ai_color();
}

//Function Number: 128
waittill_player_uses_land_assist_or_is_a_jerk()
{
	for(;;)
	{
		if(common_scripts\utility::flag("flag_first_land_assist") && common_scripts\utility::flag("land_assist_activated"))
		{
			break;
		}

		if(common_scripts\utility::flag("begin_looping_fob_functions"))
		{
			break;
		}

		if(common_scripts\utility::flag("dialogue_hotel_top_floor_landassist_end"))
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 129
get_will_into_first_landassist()
{
	level endon("e3_jump_end_scene");
	var_00 = maps\_shg_design_tools::getthing("struct_land_assist_cormack_01b","targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	var_01 maps\_anim::anim_reach_solo(level.will_irons,"first_landassist_enter");
	var_01 maps\_anim::anim_single_solo(level.will_irons,"first_landassist_enter");
	level.will_irons.anim_org = var_01;
	if(!common_scripts\utility::flag("flag_first_land_assist") || !common_scripts\utility::flag("land_assist_activated") || !common_scripts\utility::flag("begin_looping_fob_functions"))
	{
		var_01 thread maps\_anim::anim_loop_solo(level.will_irons,"first_landassist_idle");
		waittill_player_uses_land_assist_or_is_a_jerk();
		level.will_irons maps\_utility::anim_stopanimscripted();
		level.will_irons maps\_shg_design_tools::anim_stop(var_01);
	}

	level.will_irons guy_jump_to_breach_stackup_will(var_01);
}

//Function Number: 130
guy_jump_to_breach_stackup_cormack(param_00)
{
	level endon("exo_breach_impact");
	level endon("exo_breach_begin");
	level endon("e3_jump_end_scene");
	param_00 maps\_anim::anim_single_solo(self,"first_landassist_jump_e3");
	self notify("i_have_landed");
	level.cormack maps\_utility::anim_stopanimscripted();
	level.cormack maps\_shg_design_tools::anim_stop(param_00);
}

//Function Number: 131
guy_jump_to_breach_stackup_will(param_00)
{
	level endon("exo_breach_impact");
	level endon("exo_breach_begin");
	level endon("e3_jump_end_scene");
	param_00 maps\_anim::anim_single_solo(self,"first_landassist_jump_e3");
	self notify("i_have_landed");
}

//Function Number: 132
guy_jump_to_breach_stackup_jackson(param_00)
{
	param_00 maps\_anim::anim_reach_solo(self,"first_landassist_jump_e3");
	param_00 maps\_anim::anim_single_solo(self,"first_landassist_jump_e3");
	self notify("i_have_landed");
	var_01 = getnode("node_jackson_take_position_building","targetname");
	self setgoalnode(var_01);
}

//Function Number: 133
jump_down_when_in_view(param_00)
{
	while(!common_scripts\utility::flag("flag_second_land_assist_go") && !jump_down_now())
	{
		wait 0.05;
	}

	if(isdefined(self.anim_tag))
	{
		maps\_shg_design_tools::anim_stop(self.anim_tag);
	}

	self setgoalnode(param_00);
}

//Function Number: 134
jump_down_when_in_view_cormack(param_00,param_01)
{
	while(!common_scripts\utility::flag("flag_second_land_assist_go") && !jump_down_now())
	{
		wait 0.05;
	}

	param_01 maps\_anim::anim_generic(self,param_01.animation);
	self setgoalnode(param_00);
}

//Function Number: 135
jump_down_now()
{
	if(!isdefined(level.test_tag))
	{
		level.test_tag = common_scripts\utility::spawn_tag_origin();
		target_set(level.test_tag);
		target_hidefromplayer(level.test_tag,level.player);
	}

	level.test_tag.origin = self.origin + (0,0,34);
	if(target_isincircle(level.test_tag,level.player,65,200))
	{
		return 1;
	}

	return 0;
}

//Function Number: 136
to_second_land_assist_idles_cormack(param_00)
{
	param_00 maps\_anim::anim_generic_reach(self,param_00.animation);
	self.anim_tag = param_00 common_scripts\utility::spawn_tag_origin();
	self notify("second_land_assist_arrive");
	self.anim_tag thread maps\_anim::anim_generic_first_frame(self,param_00.animation);
	self.anim_tag.animation = param_00.animation;
}

//Function Number: 137
to_second_land_assist_idles(param_00)
{
	var_01 = param_00.animation + "_single";
	self.anim_tag = param_00 common_scripts\utility::spawn_tag_origin();
	self.anim_tag maps\_anim::anim_generic_reach(self,var_01);
	self notify("second_land_assist_arrive");
	if(!common_scripts\utility::flag("flag_second_land_assist_go"))
	{
		self.anim_tag thread maps\_anim::anim_generic_loop(self,param_00.animation);
	}
}

//Function Number: 138
guy_exit_missile_explode_room()
{
	var_00 = level.jackson;
	var_00.anim_struct = common_scripts\utility::getstruct("struct_guy_explosion_dodge_jump","targetname");
	var_00.anim_struct2 = maps\_shg_design_tools::getthing("struct_bottom_of_building_guy","targetname");
	var_00.anim_struct maps\_anim::anim_generic_reach(var_00,var_00.anim_struct.animation);
	var_00.anim_struct jump_anim_with_gravity(var_00,var_00.anim_struct.animation,var_00.anim_struct2,var_00.anim_struct2.animation);
}

//Function Number: 139
allies_to_building_exit()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_building_traverse_exit_start_anim");
	thread maps\_utility::flag_set_delayed("dialogue_hotel_exit",4);
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_building_exit_allies");
	if(!isdefined(level.cormack.building_exit_arrived))
	{
		level.cormack.building_exit_arrived = 0;
	}

	if(!isdefined(level.will_irons.building_exit_arrived))
	{
		level.will_irons.building_exit_arrived = 0;
	}

	while(!level.cormack.building_exit_arrived || !level.will_irons.building_exit_arrived)
	{
		wait(0.05);
	}
}

//Function Number: 140
anim_scene_building_exit_cormack(param_00)
{
	self.building_exit_arrived = 0;
	level.cormack maps\_utility::set_moveplaybackrate(1);
	var_01 = common_scripts\utility::getstruct("struct_building_exit_cormack_wait","targetname");
	var_01 maps\_anim::anim_reach_solo(self,"seo_react_to_war_run_2_idle");
	if(!common_scripts\utility::flag("begin_fob_combat_vignette"))
	{
		var_01 maps\_anim::anim_single_solo(self,"seo_react_to_war_run_2_idle");
		if(!common_scripts\utility::flag("begin_fob_combat_vignette"))
		{
			thread maps\_anim::anim_loop_solo(self,"seo_react_to_war_idle");
		}

		common_scripts\utility::flag_wait("begin_fob_combat_vignette");
		self notify("stop_loop");
		maps\_utility::anim_stopanimscripted();
		maps\_anim::anim_single_solo_run(self,"seo_react_to_war_idle_2_run");
	}

	level.player notify("trigger_allies_to_fob");
}

//Function Number: 141
anim_scene_building_exit_will(param_00)
{
	self.building_exit_arrived = 0;
	var_01 = common_scripts\utility::getstruct("struct_building_exit_will_wait","targetname");
	var_01 maps\_anim::anim_reach_solo(self,"seo_react_to_war_run_2_idle");
	if(!common_scripts\utility::flag("begin_fob_combat_vignette"))
	{
		var_01 maps\_anim::anim_single_solo(self,"seo_react_to_war_run_2_idle");
		if(!common_scripts\utility::flag("begin_fob_combat_vignette"))
		{
			thread maps\_anim::anim_loop_solo(self,"seo_react_to_war_idle");
			common_scripts\utility::flag_wait("begin_fob_combat_vignette");
			wait(0.35);
		}

		common_scripts\utility::flag_wait("begin_fob_combat_vignette");
		self notify("stop_loop");
		maps\_utility::anim_stopanimscripted();
		maps\_anim::anim_single_solo_run(self,"seo_react_to_war_idle_2_run");
	}
}

//Function Number: 142
get_will_to_fob_anim_scene()
{
	var_00 = common_scripts\utility::getstruct("struct_fob_wait_will_exit","targetname");
	var_00 maps\_anim::anim_reach_solo(level.will_irons,"seo_react_to_war_poseA_in");
	level.will_irons maps\_utility::set_moveplaybackrate(0.85);
	if(!common_scripts\utility::flag("flag_start_fob_meet_scene"))
	{
		var_00 maps\_anim::anim_single_solo(level.will_irons,"seo_react_to_war_poseA_in");
		level.will_irons thread maps\_anim::anim_loop_solo(level.will_irons,"seo_react_to_war_poseA_idle");
		common_scripts\utility::flag_wait("flag_start_fob_meet_scene");
		wait(0.5);
		level.will_irons notify("end_loop");
		level.will_irons maps\_utility::anim_stopanimscripted();
		level.will_irons maps\_anim::anim_single_solo_run(level.will_irons,"seo_react_to_war_poseA_out");
	}

	var_01 = common_scripts\utility::getstruct("will_irons_fobmeetup_idle_org","targetname");
	var_01 maps\_anim::anim_reach_solo(level.will_irons,"fob_meet_will_into");
	var_01 maps\_anim::anim_single_solo_run(level.will_irons,"fob_meet_will_into");
	level.will_irons thread maps\_anim::anim_loop_solo(level.will_irons,"seo_react_to_war_idle");
	level waittill("fob_cormack_wave");
}

//Function Number: 143
allies_to_fob()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_vista_scene_end");
	var_00 = common_scripts\utility::getstructarray("struct_fob_talk_scene_cormack","targetname");
	var_01 = var_00[0];
	var_02 = var_01 common_scripts\utility::spawn_tag_origin();
	var_03 = var_01 common_scripts\utility::spawn_tag_origin();
	var_04 = getent("temp_anim_scene_spawner","targetname");
	var_05 = getent("fob_sergeant","targetname");
	level.guide = var_05 maps\_shg_design_tools::actual_spawn(1);
	level.guide.animname = "daniels";
	level.guide.anim_tag = var_02;
	level.guide maps\_utility::deletable_magic_bullet_shield();
	wait(0.1);
	level.marine_3 = var_04 maps\_shg_design_tools::actual_spawn(1);
	level.marine_3 maps\_utility::gun_remove();
	level.marine_3.animname = "generic";
	var_03 thread maps\_anim::anim_loop_solo(level.marine_3,"fob_meet_guy1_idle");
	level.guide.anim_tag thread maps\_anim::anim_loop_solo(level.guide,"fob_meet_guy2_idle");
	level.player waittill("trigger_allies_to_fob");
	allies_to_fob_think();
}

//Function Number: 144
allies_to_fob_think()
{
	var_00 = common_scripts\utility::getstruct("struct_fob_wait_comack_exit","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_fob_talk_scene_cormack","targetname");
	var_02 = var_01[0];
	var_03 = var_02 common_scripts\utility::spawn_tag_origin();
	var_04 = var_02 common_scripts\utility::spawn_tag_origin();
	var_05 = getnode("node_fob_allies_02a","targetname");
	var_06 = getnode("node_fob_allies_02","targetname");
	level.jackson.goalradius = 256;
	level.jackson setgoalnode(var_05);
	if(level.currentgen)
	{
		var_05 = getnode("node_fob_section_jackson_01","targetname");
		level.jackson setgoalnode(var_05);
	}

	thread get_will_to_fob_anim_scene();
	var_00 maps\_anim::anim_reach_solo(level.cormack,"seo_react_to_war_run_2_idle");
	level.cormack thread maps\_utility::set_run_anim("seo_react_to_war_run_npc1",0);
	if(!common_scripts\utility::flag("flag_start_fob_meet_scene"))
	{
		var_00 maps\_anim::anim_single_solo(level.cormack,"seo_react_to_war_run_2_idle");
		level.cormack thread maps\_anim::anim_loop_solo(level.cormack,"seo_react_to_war_idle");
		common_scripts\utility::flag_wait("flag_start_fob_meet_scene");
		level.cormack notify("end_loop");
		level.cormack maps\_utility::anim_stopanimscripted();
		level.cormack maps\_anim::anim_single_solo_run(level.cormack,"seo_react_to_war_idle_2_run");
	}

	common_scripts\utility::flag_wait("flag_start_fob_meet_scene");
	level notify("fob_talk_scene_start");
	level notify("the_fob_scene_is_live");
	level.jackson setgoalnode(var_06);
	var_03 maps\_anim::anim_reach_solo(level.cormack,"fob_meet_cormack");
	thread guide_anim_scene_fob_meet(var_03);
	thread cormack_anim_scene_fob_meet(var_03);
}

//Function Number: 145
guide_anim_scene_fob_meet(param_00)
{
	level.guide maps\_utility::anim_stopanimscripted();
	level.guide maps\_shg_design_tools::anim_stop(level.guide.anim_tag);
	param_00 maps\_anim::anim_single_solo(level.guide,"fob_meet_guy2");
	param_00 thread maps\_anim::anim_loop_solo(level.guide,"fob_meet_guy2_idle");
	level notify("fob_talk_scene_end");
}

//Function Number: 146
send_will_wait()
{
	wait(15.75);
	level notify("send_will_2secs_early");
}

//Function Number: 147
cormack_anim_scene_fob_meet(param_00)
{
	thread cormack_wait(12);
	thread send_will_wait();
	common_scripts\utility::flag_set("dialogue_start_fob_meetup");
	param_00 maps\_anim::anim_single_solo_run(level.cormack,"fob_meet_cormack");
	level notify("walker_step_over_anim_scene");
	level.cormack maps\_utility::clear_run_anim();
	common_scripts\utility::flag_set("destroy_fob_blocking");
	get_cormack_to_walker_scene();
}

//Function Number: 148
get_cormack_to_walker_scene()
{
	level.cormack.anim_struct = common_scripts\utility::getstruct("struct_walker_walkover_scene","targetname");
	level.cormack maps\_utility::set_moveplaybackrate(1.1);
	level.cormack.anim_struct maps\_anim::anim_reach_solo(level.cormack,"fob_meet_post_enter_1");
	level.cormack maps\_utility::set_moveplaybackrate(1.4);
	level.cormack.anim_struct maps\_anim::anim_single_solo_run(level.cormack,"fob_meet_post_enter_1");
	common_scripts\utility::flag_set("flag_cormack_has_arrived_at_hill");
	level.cormack.anim_struct thread maps\_anim::anim_loop_solo(level.cormack,"fob_meet_post_idle_1");
	level notify("begin_walker_stepover_anim");
}

//Function Number: 149
get_will_to_walker_scene()
{
	level.will_irons maps\_utility::clear_run_anim();
	level.will_irons notify("stop_loop");
	level.will_irons stopanimscripted();
	level.will_irons maps\_anim::anim_single_solo_run(level.will_irons,"seo_react_to_war_idle_2_run");
	level.will_irons.anim_struct = common_scripts\utility::getstruct("struct_walker_walkover_scene","targetname");
	level.will_irons maps\_utility::set_moveplaybackrate(1.1);
	level.will_irons.anim_struct maps\_anim::anim_reach_solo(level.will_irons,"fob_meet_post_enter_2");
	level.will_irons maps\_utility::set_moveplaybackrate(1.4);
	level.will_irons.anim_struct maps\_anim::anim_single_solo(level.will_irons,"fob_meet_post_enter_2");
	common_scripts\utility::flag_set("flag_will_irons_has_arrived_at_hill");
	level.will_irons.anim_struct thread maps\_anim::anim_loop_solo(level.will_irons,"fob_meet_post_idle_2");
}

//Function Number: 150
cormack_wait(param_00)
{
	wait(param_00);
	common_scripts\utility::flag_set("fob_animation_complete");
}

//Function Number: 151
allies_to_hill()
{
	level waittill("fob_cormack_wave");
	thread get_will_to_walker_scene();
	wait(1.5);
	var_00 = getnode("node_hill_pause_guy","targetname");
	level.jackson setgoalnode(var_00);
	level.jackson maps\_utility::clear_run_anim();
	level waittill("fob_talk_scene_end");
}

//Function Number: 152
allies_to_drone_swarm()
{
	level waittill("anim_walker_stepoaver_scene_done");
	var_00 = getnode("node_drone_section_guy_01","targetname");
	level.jackson setgoalnode(var_00);
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_drone_swarm_flank");
}

//Function Number: 153
allies_to_truck_jump()
{
	level waittill("end_cherry_picker");
	if(isdefined(level.mobile_turret))
	{
		level.mobile_turret maps\_utility::ent_flag_wait("player_in_transition");
	}

	wait(1);
	thread jump_training_hint();
	thread jump_training_vo_think();
	var_00 = common_scripts\utility::getstructarray("struct_start_truck_push_01","targetname");
	level.cormack maps\_shg_design_tools::anim_stop();
	level.jackson maps\_shg_design_tools::anim_stop();
	level.will_irons maps\_shg_design_tools::anim_stop();
	level.will_irons forceteleport(var_00[0].origin,var_00[0].angles);
	level.cormack forceteleport(var_00[1].origin,var_00[1].angles);
	level.jackson forceteleport(var_00[2].origin,var_00[2].angles);
	wait(0.1);
	var_01 = getnode("node_jump_train_cormack","targetname");
	level.cormack.goalradius = 32;
	level.cormack setgoalnode(var_01);
	var_02 = getnode("node_jump_train_will","targetname");
	level.will_irons.goalradius = 32;
	level.will_irons setgoalnode(var_02);
	level.will_irons remove_cardoor_from_npc(1);
	var_03 = getnode("node_jump_train_jackson","targetname");
	level.jackson.goalradius = 32;
	level.jackson setgoalnode(var_03);
	var_04 = getentarray("trigger_jump_training_done","targetname");
	var_04[0] waittill("trigger");
	level notify("jump_training_done");
}

//Function Number: 154
jump_training_vo_think()
{
	var_00 = getent("vol_jump_training_vo_01","targetname");
	thread monitor_jump_training_end();
	while(!level.cormack istouching(var_00))
	{
		wait 0.05;
	}

	common_scripts\utility::flag_set("vo_jump_training_start");
}

//Function Number: 155
monitor_jump_training_end()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_jump_training_done");
	common_scripts\utility::flag_set("jump_training_ended");
	level notify("jump_training_end");
}

//Function Number: 156
jump_training_hint()
{
	var_00 = getent("vol_jump_training_drone_street","targetname");
	thread maps\_shg_design_tools::trigger_to_flag("trigger_jump_training_done","trigger_jump_training_done_flag");
	while(!common_scripts\utility::flag("trigger_jump_training_done_flag"))
	{
		if(level.player istouching(var_00))
		{
			maps\_utility::display_hint("jump_training");
			while(level.player istouching(var_00))
			{
				wait 0.05;
			}
		}

		wait 0.05;
	}
}

//Function Number: 157
generic_get_player_to_rig(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = spawn_player_rig("player_rig",param_00.origin);
	var_08 hide();
	maps\_shg_utility::setup_player_for_scene(1);
	var_09 = 0.4;
	if(isdefined(param_02))
	{
		var_09 = 0;
	}

	param_00 thread maps\_anim::anim_first_frame_solo(var_08,param_01);
	if(!isdefined(param_03) || !param_03)
	{
		self playerlinktoblend(var_08,"tag_player",var_09);
	}
	else
	{
		self playerlinktodelta(var_08,"tag_player",0.5,param_04,param_05,param_06,param_07,1,1);
	}

	wait(var_09);
	var_08 show();
	return var_08;
}

//Function Number: 158
restrict_player_view_to_rig_anim()
{
	var_00 = self;
	level.player unlink();
	var_01 = 0.4;
	level.player playerlinktoblend(self,"tag_player",var_01);
}

//Function Number: 159
release_player_view_to_rig_anim(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	level.player unlink();
	level.player playerlinktodelta(self,"tag_player",0.5,param_00,param_01,param_02,param_03,1,1);
}

//Function Number: 160
generic_get_rig_to_player(param_00,param_01)
{
	var_02 = spawn_player_rig("player_rig",level.player.origin + (0,0,-42));
	var_02.angles = (0,0,0);
	var_02 hide();
	self freezecontrols(1);
	maps\_shg_utility::setup_player_for_scene(1);
	var_03 = 0.4;
	param_00 thread maps\_anim::anim_first_frame_solo(var_02,param_01);
	self playerlinktoblend(var_02,"tag_player",var_03);
	wait(var_03);
	var_02 show();
	return var_02;
}

//Function Number: 161
generic_get_player_to_arms(param_00,param_01)
{
	var_02 = spawn_player_rig("player_arms",param_00.origin);
	var_02 hide();
	self freezecontrols(1);
	maps\_shg_utility::setup_player_for_scene(1);
	var_03 = 0.4;
	param_00 thread maps\_anim::anim_first_frame_solo(var_02,param_01);
	self playerlinktoblend(var_02,"tag_player",var_03);
	wait(var_03);
	var_02 show();
	return var_02;
}

//Function Number: 162
generic_remove_player_rig(param_00)
{
	level.player unlink();
	param_00 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player freezecontrols(0);
}

//Function Number: 163
allies_to_weapons_platform_video_log()
{
	level.will_irons waittill("ready_to_rally",var_00);
	maps\_utility::flag_set_delayed("dialogue_performing_arts_entrance_2",3);
	var_00 maps\_anim::anim_single_solo(level.will_irons,"rally_up_enter");
	var_01 = ["rally_up_idle_a","rally_up_idle_b","rally_up_idle_c"];
	while(!common_scripts\utility::flag("corner_rally_begin"))
	{
		var_02 = common_scripts\utility::random(var_01);
		var_00 maps\_anim::anim_single_solo(level.will_irons,var_02);
	}

	level.will_irons maps\_shg_design_tools::anim_stop(var_00);
	var_00 maps\_anim::anim_single_solo(level.will_irons,"rally_up_exit");
}

//Function Number: 164
handle_hotel_entrance()
{
	thread handle_performing_art_center_video_log();
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_setup_guide_kill");
	level notify("vo_keep_moving");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_convention_center_combat_03");
	level notify("vo_keep_moving");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_convention_center_combat_06");
	level notify("vo_keep_moving");
}

//Function Number: 165
handle_performing_art_center_video_log()
{
	level waittill("never");
	level waittill("end_cherry_picker");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_seoul_video_log");
	common_scripts\utility::flag_set("dialogue_performing_arts_entrance_2");
	prep_cinematic("seoul_videolog");
	play_seoul_videolog();
	wait(0.15);
	maps\seoul::ingame_movies();
}

//Function Number: 166
spawn_player_rig(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = "player_rig";
	}

	if(!isdefined(param_01))
	{
		param_01 = level.player.origin;
	}

	var_02 = maps\_utility::spawn_anim_model(param_00);
	return var_02;
}

//Function Number: 167
setup_npc_paths()
{
	level waittill("droppod_empty");
	thread spawn_warbird_spotlight_gag();
	level notify("vista_warbird_spot_allies");
	common_scripts\utility::flag_wait("vista_warbird_gag_done");
}

//Function Number: 168
spawn_warbird_spotlight_gag()
{
	level waittill("vista_warbird_spot_allies");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("vehicle_vista_ally_warbird_spotlight");
	if(level.currentgen)
	{
		var_00 thread maps\seoul::tff_cleanup_vehicle("east_view");
	}

	thread maps\seoul_fx::vista_warbird_fx(var_00);
	var_00 soundscripts\_snd::snd_message("hotel_razorback_fly_by");
	var_00 vehicle_setspeed(15,5,15);
	wait(8.5);
	level notify("spotlight_switch");
}

//Function Number: 169
setup_openning_vista()
{
	thread cleanup_vista();
	thread handle_vista_tanks();
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_start_vista_vehicle_flyby");
	if(level.currentgen)
	{
		if(!istransientloaded("seoul_fob_tr"))
		{
			level waittill("transients_intro_to_fob");
		}
	}

	thread handle_vista_pods();
	thread handle_vista_vehicles();
	thread handle_vista_jets();
	thread handle_vista_missile_outrun();
}

//Function Number: 170
handle_vista_missile_outrun()
{
	var_00 = getentarray("vehicle_outrun_missiles_missile","targetname");
	var_01 = getent("vehicle_outrun_missiles_jet","targetname");
	wait(8);
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("vehicle_outrun_missiles_jet");
	foreach(var_04 in var_00)
	{
		var_05 = var_04 maps\_vehicle::spawn_vehicle_and_gopath();
		var_05 thread match_speed_to_jet(var_02);
		wait(0.25);
	}
}

//Function Number: 171
match_speed_to_jet(param_00)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		var_01 = param_00.speed * randomfloatrange(0.85,1.1);
		if(var_01 <= 0)
		{
			var_01 = 1;
		}

		self vehicle_setspeed(var_01,50,90);
		wait(1);
	}
}

//Function Number: 172
handle_vista_tanks()
{
	level waittill("pod_deform");
	if(level.currentgen && !issubstr(level.transient_zone,"fob"))
	{
		level waittill("transients_intro_to_fob");
	}

	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("vehicle_vista_warbird_flyby_00");
	var_01 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("vehcile_vista_tank_01");
	foreach(var_03 in var_01)
	{
		thread delete_on_path_end();
		if(level.currentgen)
		{
			thread maps\seoul_transients_cg::cg_kill_entity_on_transition(var_03,"pre_transients_drone_seq_one_to_trusk_push");
		}
	}

	if(level.currentgen)
	{
		foreach(var_06 in var_00)
		{
			thread maps\seoul_transients_cg::cg_kill_entity_on_transition(var_06,"pre_transients_drone_seq_one_to_trusk_push");
		}
	}
}

//Function Number: 173
delete_on_path_end()
{
	self waittill("reached_end_node");
	self delete();
}

//Function Number: 174
handle_vista_jets()
{
	thread vista_jets_reflection_override();
	wait(10);
	var_00 = getentarray("vehicle_vista_jet_02","targetname");
	level.vista_jet_array = [];
	thread handle_bombing_runs();
	if(var_00.size > 0)
	{
		while(!common_scripts\utility::flag("flag_first_land_assist"))
		{
			foreach(var_02 in var_00)
			{
				var_03 = undefined;
				if(level.nextgen)
				{
					var_03 = 12;
				}
				else
				{
					var_03 = 6;
				}

				if(safe_to_spawn_vehciles() && level.vista_jet_array.size < var_03 && maps\_shg_design_tools::percentchance(75))
				{
					var_04 = var_02 maps\_vehicle::spawn_vehicle_and_gopath();
					var_04 soundscripts\_snd::snd_message("aud_handle_vista_jets");
					if(isdefined(var_04))
					{
						level.vista_jet_array[level.vista_jet_array.size] = var_04;
					}
					else
					{
						continue;
					}

					var_04 vehicle_setspeed(randomintrange(400,650),200,900);
					wait(randomfloatrange(0.5,3));
					continue;
				}

				wait(randomfloatrange(3,6));
				level.vista_jet_array = common_scripts\utility::array_removeundefined(level.vista_jet_array);
			}
		}
	}
}

//Function Number: 175
safe_to_spawn_vehciles()
{
	var_00 = maps\_utility::getvehiclearray();
	if(var_00.size < 18)
	{
		return 1;
	}

	return 0;
}

//Function Number: 176
vista_jets_reflection_override()
{
	wait(30);
	var_00 = getentarray("vehicle_vista_jet_02","targetname");
	wait(3);
	var_01 = getent("main_street_reflection","targetname");
	var_00 = getentarray("vehicle_vista_jet_01","targetname");
	foreach(var_03 in var_00)
	{
		wait(randomfloatrange(0.5,2));
	}
}

//Function Number: 177
handle_bombing_runs()
{
	var_00 = common_scripts\utility::getstructarray("struct_vista1_bomb_01","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_vista1_bomb_02","targetname");
	var_02 = common_scripts\utility::getstructarray("struct_vista1_bomb_03","targetname");
	var_03 = common_scripts\utility::getstructarray("struct_vista1_bomb_04","targetname");
	var_04 = common_scripts\utility::getstructarray("struct_vista1_bomb_05","targetname");
	var_05[0] = sortbydistance(var_00,level.player.origin);
	var_05[1] = sortbydistance(var_01,level.player.origin);
	var_05[2] = sortbydistance(var_02,level.player.origin);
	var_05[3] = sortbydistance(var_03,level.player.origin);
	var_05[4] = sortbydistance(var_04,level.player.origin);
	for(;;)
	{
		var_06 = common_scripts\utility::flag_wait_any_return("vista_bomber_trigger_01","vista_bomber_trigger_02","vista_bomber_trigger_03");
		common_scripts\utility::flag_clear(var_06);
		var_07 = common_scripts\utility::random(var_05);
		foreach(var_09 in var_07)
		{
			if(common_scripts\utility::cointoss())
			{
				playfx(common_scripts\utility::getfx("ambient_explosion_fireball"),var_09.origin);
				soundscripts\_snd::snd_message("seo_vista_bombing_run",var_09.origin);
			}

			wait 0.05;
		}

		wait 0.05;
	}
}

//Function Number: 178
handle_vista_vehicles()
{
	if(level.nextgen)
	{
		var_00 = getent("vista_reflection_02","targetname");
	}
	else
	{
		var_00 = getent("main_street_reflection","targetname");
	}

	var_01 = getentarray("vehicle_vista_ally_warbird_01","targetname");
	var_02 = getentarray("vehicle_vista_warbird_flyby","targetname");
	var_01 = common_scripts\utility::array_combine(var_01,var_02);
	common_scripts\utility::array_thread(var_01,::spawn_vista_vehicle);
}

//Function Number: 179
spawn_vista_vehicle()
{
	if(level.currentgen)
	{
		level endon(maps\seoul::tff_get_zone_unload_notify("east_view"));
	}

	wait(randomfloat(3.5));
	var_00 = thread maps\_vehicle::spawn_vehicle_and_gopath();
	level.vista_ents[level.vista_ents.size] = var_00;
	if(level.currentgen)
	{
		var_00 thread maps\seoul::tff_cleanup_vehicle("east_view");
	}

	if(level.nextgen)
	{
		var_01 = getent("vista_reflection_02","targetname");
	}
	else
	{
		var_01 = getent("main_street_reflection","targetname");
	}

	foreach(level.vista_ent in level.vista_ents)
	{
		level.vista_ent overridereflectionprobe(var_01.origin);
	}
}

//Function Number: 180
handle_vista_pods()
{
	var_00 = getentarray("droppod_exterior_vista_01","targetname");
	foreach(var_02 in var_00)
	{
		wait(randomfloatrange(1,2));
		var_03 = maps\_utility::spawn_anim_model("npc_droppod");
		var_02 thread maps\_anim::anim_single_solo(var_03,"pod_landing");
	}

	level waittill("never");
	var_05 = getentarray("model_droppod_exterior_vista_crashers","targetname");
	thread handle_vista_landing_pods(var_00);
	thread handle_vista_crashing_pods(var_05);
	level.vista_ents = common_scripts\utility::array_combine(level.vista_ents,var_00);
	level.vista_ents = common_scripts\utility::array_combine(level.vista_ents,var_05);
}

//Function Number: 181
handle_vista_landing_pods(param_00)
{
	foreach(var_02 in param_00)
	{
		wait(randomfloat(2));
		var_02 thread land_pod_cleanly(1);
	}
}

//Function Number: 182
handle_vista_crashing_pods(param_00)
{
	foreach(var_02 in param_00)
	{
		wait(randomfloat(2));
		var_02 thread land_pod_badly();
	}
}

//Function Number: 183
cleanup_vista()
{
	maps\_shg_design_tools::waittill_trigger_with_name("start_pod_landings");
	level notify("end_vista_view");
	common_scripts\utility::array_thread(level.vista_ents,::maps\_shg_design_tools::delete_auto);
}

//Function Number: 184
temp_handle_fob_anim_scene()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_fob_scene");
	if(!common_scripts\utility::flag("hault_column"))
	{
		common_scripts\utility::flag_set("hault_column");
	}
}

//Function Number: 185
kill_on_trigger(param_00)
{
	maps\_shg_design_tools::waittill_trigger_with_name(param_00);
	maps\_shg_design_tools::delete_auto();
}

//Function Number: 186
setup_ambient_walker_tank()
{
	common_scripts\utility::flag_wait("player_passed_fob");
}

//Function Number: 187
handle_path_blocking_fob()
{
	var_00 = getent("brush_fob_path_blocker_trench","targetname");
	var_01 = getent("brush_blocker_fob_droppod_landing_guys","targetname");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_fob_scene");
	var_01.origin = var_01.origin + (0,0,10000);
	var_01 connectpaths();
	level waittill("remove_path_blockers_fob");
	var_00.origin = var_00.origin + (0,0,1000);
	var_00 connectpaths();
}

//Function Number: 188
handle_fob_runners()
{
	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
	var_00 = getentarray("spawner_ambient_fob_group_01","targetname");
	var_01 = getnodearray("delete_me_node_array","targetname");
	if(level.nextgen)
	{
		var_02 = 4;
	}
	else
	{
		var_02 = 3;
	}

	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = common_scripts\utility::random(var_00) maps\_shg_design_tools::actual_spawn();
		if(!isdefined(var_04))
		{
			continue;
		}

		var_05 = common_scripts\utility::random(var_01);
		var_04.goalradius = 32;
		var_04.ignoreall = 1;
		var_04 setgoalpos(var_05.origin);
		var_04 thread delete_me_on_goal();
		wait(1);
	}
}

//Function Number: 189
handle_fob_runners_second_wave()
{
	maps\_shg_design_tools::waittill_trigger_with_name("hault_column");
	var_00 = getentarray("spawner_ambient_fob_group_01","targetname");
	var_01 = getnodearray("delete_me_node_array","targetname");
	var_02 = 6;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = common_scripts\utility::random(var_00) maps\_shg_design_tools::actual_spawn();
		if(!isdefined(var_04))
		{
			continue;
		}

		var_05 = common_scripts\utility::random(var_01);
		var_04.goalradius = 32;
		var_04.ignoreall = 1;
		var_04 setgoalpos(var_05.origin);
		var_04 thread delete_me_on_goal();
		wait(randomfloatrange(0.5,1.75));
	}
}

//Function Number: 190
handle_lobby_ambient_troops()
{
	thread maps\_shg_design_tools::trigger_to_flag("trigger_end_looping_anims","end_lobby_loopers");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_vista_scene_end");
	thread spawn_guy_loopers();
	thread spwan_vehicle_loopers();
}

//Function Number: 191
spawn_guy_loopers()
{
	var_00 = getent("spawner_lobby_loopers","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_lobby_looper_01","targetname");
	var_02 = getnode("node_spawner_lobby_loopers","targetname");
	if(level.currentgen)
	{
		if(!istransientloaded("seoul_fob_tr"))
		{
			level waittill("transients_intro_to_fob");
		}
	}

	while(!common_scripts\utility::flag("end_lobby_loopers"))
	{
		if(level.nextgen)
		{
			var_03 = randomint(3);
		}
		else
		{
			var_03 = 1;
		}

		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			if(common_scripts\utility::flag("end_lobby_loopers"))
			{
				return;
			}

			var_05 = var_00 maps\_shg_design_tools::actual_spawn(1);
			if(level.currentgen)
			{
				wait(0.05);
				var_06 = getnode("lobby_looper_tele","targetname");
				var_05 teleport(var_06.origin,var_06.angles);
			}

			var_07 = common_scripts\utility::random(var_01);
			var_05 thread play_anim_and_delete(var_07,var_07.animation,var_02);
			var_05.allowdeath = 1;
			wait(randomfloat(2));
		}

		if(level.nextgen)
		{
			wait(2);
			continue;
		}

		wait(randomfloatrange(6,10));
	}
}

//Function Number: 192
spwan_vehicle_loopers()
{
	var_00 = getentarray("vehicle_spawner_lobby_loopers","targetname");
	while(!common_scripts\utility::flag("end_lobby_loopers"))
	{
		var_01 = common_scripts\utility::random(var_00);
		var_02 = var_01 maps\_vehicle::spawn_vehicle_and_gopath();
		var_02 thread delete_on_path_end();
		if(level.nextgen)
		{
			wait(randomfloatrange(3,8));
			continue;
		}

		wait(randomfloatrange(10,15));
	}
}

//Function Number: 193
play_anim_and_delete(param_00,param_01,param_02)
{
	self endon("death");
	param_00 maps\_anim::anim_generic_reach(self,param_01);
	if(isremovedentity(self))
	{
		return;
	}

	if(!isdefined(self))
	{
		return;
	}

	param_00 maps\_anim::anim_generic(self,param_01);
	if(!isdefined(self))
	{
		return;
	}

	self setgoalpos(param_02.origin);
	self.goalradius = 32;
	self waittill("goal");
	self delete();
}

//Function Number: 194
handle_fob()
{
	thread handle_lobby_ambient_troops();
	thread temp_handle_fob_anim_scene();
	thread setup_tank_battle();
	thread setup_injured_soldiers();
	thread handle_friendly_fob_razorback();
	thread setup_ambient_walker_tank();
	thread handle_path_blocking_fob();
	thread anim_scene_walker_stepover();
	thread handle_fob_runners();
	if(level.nextgen)
	{
		thread handle_fob_runners_second_wave();
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trigger_opening_view_off_01");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_opening_view_off_02");
	maps\_shg_design_tools::remove_monitored_tags("building_01");
	var_00 = getentarray("vehicle_ally_openning_ambient","targetname");
	common_scripts\utility::array_call(var_00,::maps\_shg_design_tools::delete_auto);
	common_scripts\utility::flag_set("opening_view_off");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_opening_view_off_02");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_opening_view_off_01");
	common_scripts\utility::flag_clear("opening_view_off");
}

//Function Number: 195
handle_friendly_fob_razorback()
{
	maps\_shg_design_tools::waittill_trigger_with_name("start_pod_landings");
}

//Function Number: 196
setup_injured_soldiers()
{
	level.fob_injured_guys = [];
	thread injured_by_base();
}

//Function Number: 197
injured_by_main_exit_door()
{
	var_00 = getent("ally_spawner_fob_injured","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_fob_injured_soldier_maindoor","targetname");
	foreach(var_03 in var_01)
	{
		var_00.idleanim = level.scr_anim["generic"][var_03.animation][0];
		var_04 = var_00 maps\_utility::dronespawn();
		var_04 maps\_utility::anim_stopanimscripted();
		var_03 thread maps\_anim::anim_generic_loop(var_04,var_03.animation);
		var_04 maps\_utility::gun_remove();
		wait(0.05);
	}
}

//Function Number: 198
injured_by_base()
{
	var_00 = getent("ally_spawner_fob_injured_by_base","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_fob_injured_soldier_base","targetname");
	foreach(var_03 in var_01)
	{
		var_00.idleanim = level.scr_anim["generic"][var_03.animation][0];
		var_04 = var_00 maps\_utility::dronespawn();
		var_04 maps\_utility::anim_stopanimscripted();
		var_04 maps\_utility::gun_remove();
		var_03 thread maps\_anim::anim_generic_loop(var_04,var_03.animation);
		wait(0.05);
	}
}

//Function Number: 199
injured_guy_dialogue()
{
	level endon("the_fob_scene_is_live");
	for(;;)
	{
		is_1_near_2(level.player,self,400);
		common_scripts\utility::flag_set("soldier_injured_dialogue");
	}
}

//Function Number: 200
is_1_near_2(param_00,param_01,param_02)
{
	for(;;)
	{
		if(distance2d(param_00.origin,param_01.origin) < param_02)
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 201
setup_tank_battle()
{
	var_00 = getentarray("enemy_tanks_group_01","targetname");
	var_01 = common_scripts\utility::getstruct("struct_missile_fire_point_test","targetname");
	var_02 = getentarray("missile_test","targetname");
	var_03 = getentarray("missile_test_02","targetname");
	for(;;)
	{
		while(common_scripts\utility::flag("opening_view_off"))
		{
			wait(0.05);
		}

		wait(randomfloatrange(6,12));
		var_04 = common_scripts\utility::array_randomize(var_02);
		var_05 = randomint(var_04.size);
		for(var_06 = 0;var_06 < var_05;var_06++)
		{
			if(!safe_to_spawn_vehciles())
			{
				wait 0.05;
				continue;
			}

			var_07 = var_04[var_06] maps\_vehicle::spawn_vehicle_and_gopath();
			var_07 soundscripts\_snd::snd_message("sidewinder_missile");
			var_07 vehicle_setspeed(100,50,100);
			var_07 thread sidewinder_explode_impact();
			wait(0.175);
		}
	}
}

//Function Number: 202
sidewinder_explode_impact()
{
	self waittill("reached_end_node");
	wait(3);
	playfxontag(common_scripts\utility::getfx("aa_explosion_runner_single"),self,"tag_origin");
	self hide();
	common_scripts\utility::flag_set("kill_rocket_scene_guy");
	wait(1);
	self delete();
}

//Function Number: 203
missile_delete()
{
	self waittill("reached_end_node");
	self delete();
}

//Function Number: 204
handle_pac_laser_on_vols()
{
	level endon("end_PAC_combat");
	var_00 = getentarray("vol_pac_laser_on_vol","targetname");
	for(;;)
	{
		foreach(var_02 in var_00)
		{
			var_03 = getaiarray("axis");
			foreach(var_05 in var_03)
			{
				if(isdefined(var_05.force_laser_on))
				{
					continue;
				}

				if(var_05 istouching(var_02))
				{
					var_05 thread monitor_lazer_on_vol(var_02);
				}
			}
		}

		wait(0.5);
	}
}

//Function Number: 205
monitor_lazer_on_vol(param_00)
{
	self endon("death");
	level endon("missionfailed");
	level endon("end_PAC_combat");
	for(;;)
	{
		self laseron("lag_snipper_laser");
		while(self istouching(param_00))
		{
			wait 0.05;
		}

		self laseroff();
		while(!self istouching(param_00))
		{
			wait 0.05;
		}
	}
}

//Function Number: 206
handle_testers_skipping_pac_combat()
{
	var_00 = getent("glass_gate_pac_01","targetname");
	var_00 delete();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_player_in_air_building_jump");
	var_01 = getnodearray("node_fucker_node_in_pac","targetname");
	if(!isdefined(level.pac_enemy_group) || level.pac_enemy_group.size == 0)
	{
		return;
	}

	level.pac_enemy_group = maps\_utility::array_removedead_or_dying(level.pac_enemy_group);
	foreach(var_04, var_03 in level.pac_enemy_group)
	{
		if(isdefined(var_03))
		{
			if(isdefined(var_01[var_04]))
			{
				var_03 setgoalnode(var_01[var_04]);
				var_03.accuracy = 0.9;
				continue;
			}

			var_03 delete();
		}
	}
}

//Function Number: 207
handle_pac_retreating2()
{
	thread maps\_shg_design_tools::trigger_to_flag("trig_player_in_air_building_jump","player_jumped_building_traverse");
	var_00 = getentarray("pac_retraversal_fail","targetname");
	foreach(var_02 in var_00)
	{
		var_02.set_org = var_02.origin;
		var_02.origin = var_02.origin + (0,0,100000);
	}

	common_scripts\utility::flag_wait("player_jumped_building_traverse");
	common_scripts\utility::flag_wait("player_starting_sinkhole");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.set_org;
	}
}

//Function Number: 208
handle_pac_ally_movement()
{
	thread move_forward_if_safe("trig_convention_center_combat_05");
	thread move_forward_if_safe("trig_convention_center_combat_04");
}

//Function Number: 209
move_forward_if_safe(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_02 = param_00 + "_c";
	var_03 = getent(var_02,"targetname");
	var_04 = getent(var_01.target,"targetname");
	var_01 waittill("trigger");
	for(;;)
	{
		var_05 = var_04 maps\_utility::get_ai_touching_volume("axis");
		if(var_05.size <= 1 || level.player istouching(var_04))
		{
			var_03 notify("trigger");
			break;
		}

		wait 0.05;
	}
}

//Function Number: 210
handle_pac_interior()
{
	thread handle_testers_skipping_pac_combat();
	thread handle_pac_retreating();
	thread handle_pac_retreating2();
	thread handle_pac_combat();
	thread handle_pac_zipline_intos();
	thread handle_pac_snipers();
	thread handle_pac_ally_movement();
	thread anim_scene_building_jump();
	thread handle_pac_laser_on_vols();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_convention_center_setup");
	level notify("stop_group_spawning");
	maps\_utility::autosave_by_name();
}

//Function Number: 211
handle_pac_entrance_fight()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_weapons_platform_takeoff_hotel");
	if(level.currentgen)
	{
		var_00 = ["cg_pac_into_spawner"];
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("dialogue_performing_arts_exit",var_00,15,0);
	}

	var_01 = getent("spawner_hotel_enemies_patrollers","targetname");
	var_02 = common_scripts\utility::getstructarray("struct_hotel_patrollers_01","targetname");
	var_03 = common_scripts\utility::getstructarray("struct_hotel_patrollers_02","targetname");
	var_04 = [];
	foreach(var_06 in var_03)
	{
		var_07 = var_01 maps\_shg_design_tools::actual_spawn(1);
		var_07.anim_struct = var_06;
		var_06 thread maps\_anim::anim_generic_loop(var_07,var_06.animation);
		var_07 thread hotel_wake_think();
		var_07 thread group_patrol_wakeup("wake_PAC_patrollers");
		var_07.grenadeammo = 0;
		var_04[var_04.size] = var_07;
	}

	foreach(var_06 in var_02)
	{
		var_07 = var_01 maps\_shg_design_tools::actual_spawn(1);
		var_07 forceteleport(var_06.origin,var_06.angles);
		var_07.target = var_06.target;
		var_07 thread maps\_patrol_extended::force_patrol_anim_set(undefined,0,1);
		var_07 thread hotel_wake_think();
		var_07 thread group_patrol_wakeup("wake_PAC_patrollers");
		var_07.grenadeammo = 0;
		var_04[var_04.size] = var_07;
	}

	var_0B = getent("vol_hotel_zipline_defend_02","script_noteworthy");
	for(var_0C = 0;var_0C < 6;var_0C++)
	{
		var_07 = var_01 maps\_shg_design_tools::actual_spawn(1);
		var_07 setgoalvolumeauto(var_0B);
		var_07 thread pac_attack_when_alert();
		var_07.grenadeammo = 0;
	}

	level waittill("wake_PAC_patrollers");
	var_0D = getent("clip_pac_entrance_01","targetname");
	var_0D.origin = var_0D.origin + (0,0,10000);
	foreach(var_07 in var_04)
	{
		if(!isdefined(var_07))
		{
			return;
		}

		var_07 notify("end_patrol");
		var_07 notify("enemy");
		if(isdefined(var_07.anim_struct))
		{
			var_07.anim_struct notify("stop_loop");
			var_07 maps\_shg_design_tools::anim_stop();
		}

		var_07 maps\_shg_design_tools::end_anim_loop();
	}
}

//Function Number: 212
pac_attack_when_alert()
{
	self endon("death");
	level waittill("wake_PAC_patrollers");
	self notify("enemy");
	self notify("end_patrol");
}

//Function Number: 213
group_patrol_wakeup(param_00)
{
	common_scripts\utility::waittill_any("enemy","end_patrol","damage");
	level notify(param_00);
	var_01 = getent("vol_pac_entrance_fallback","targetname");
	if(common_scripts\utility::cointoss())
	{
		self setgoalvolumeauto(var_01);
	}
}

//Function Number: 214
hotel_wake_think()
{
}

//Function Number: 215
glass_break_think()
{
	var_00 = getglass("glass_building_jump");
	while(!isglassdestroyed(var_00))
	{
		level waittill("cormack_shot_glass");
		if(!isglassdestroyed(var_00))
		{
			level.cormack shoot();
			destroyglass(var_00);
		}
	}
}

//Function Number: 216
handle_off_mission_pac()
{
	var_00 = getentarray("pac_jerk_skip","targetname");
	common_scripts\utility::flag_wait("dialogue_building_jump");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin + (0,0,90000);
	}
}

//Function Number: 217
anim_scene_building_jump()
{
	level notify("end_anim_scene_building_jump");
	level endon("end_anim_scene_building_jump");
	thread glass_break_think();
	thread maps\_shg_design_tools::trigger_to_flag("trig_player_in_air_building_jump","player_building_jump");
	thread handle_off_mission_pac();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_convention_center_combat_06");
	var_00 = getnode("node_building_jump_prep_will","targetname");
	var_01 = getnode("node_building_jump_prep_cormack","targetname");
	level.will_irons setgoalnode(var_00);
	level.cormack setgoalnode(var_01);
	level notify("autosave_request");
	level notify("end_PAC_combat");
	wait(0.2);
	var_00 = getnode("node_building_jump_prep_will","targetname");
	var_01 = getnode("node_building_jump_prep_cormack","targetname");
	level.will_irons setgoalnode(var_00);
	level.cormack setgoalnode(var_01);
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_building_jump1");
	level notify("autosave_request");
	jump_scene_think();
}

//Function Number: 218
monitor_player_leaving_squad_hotel()
{
	common_scripts\utility::flag_wait("player_leaving_squad");
	if(common_scripts\utility::flag("player_leaving_squad") & !isdefined(level.cormack.building_jump_initiate))
	{
		jump_scene_think(1);
	}
}

//Function Number: 219
jump_scene_think(param_00)
{
	var_01 = common_scripts\utility::getstruct("struct_building_jump1_cormack","targetname");
	var_02 = common_scripts\utility::getstruct("struct_building_jump1_will","targetname");
	common_scripts\utility::flag_set("dialogue_performing_arts_exit");
	level.cormack maps\_utility::enable_ai_color();
	var_03 = getent("vol_test_for_will_and_cormack","targetname");
	if(isdefined(param_00) && param_00)
	{
		level.cormack thread play_building_jump_1_scene(var_01,"node_building_jump_land_cormack",1,1,1);
		level.will_irons thread play_building_jump_1_scene(var_02,"node_building_jump_land_will",undefined,undefined,1);
		return;
	}

	if(level.cormack istouching(var_03) && level.will_irons istouching(var_03))
	{
		level.cormack thread play_building_jump_1_scene(var_01,"node_building_jump_land_cormack",1,1);
		level.will_irons thread play_building_jump_1_scene(var_02,"node_building_jump_land_will");
		return;
	}

	level.cormack thread play_building_jump_1_scene(var_01,"node_building_jump_land_cormack",0);
	level waittill("cormack_jumping_buildings");
	level.will_irons thread play_building_jump_1_scene(var_02,"node_building_jump_land_will",0);
}

//Function Number: 220
play_building_jump_1_scene(param_00,param_01,param_02,param_03,param_04)
{
	self endon("warping");
	self.in_position_building_jump = 0;
	if(isdefined(param_04) && param_04)
	{
		teleport_building_jump(param_00,param_03);
	}
	else if(isdefined(param_03) && param_03)
	{
		loop_wait_building_jump(param_00,param_02,param_03);
	}
	else if(!isdefined(param_02) || param_02)
	{
		frame_wait_building_jump(param_00,param_02,param_03);
	}
	else
	{
		no_wait_building_jump(param_00,param_03);
	}

	level notify("building_jump_anim_done");
	self.building_jump_done = 1;
	if(!common_scripts\utility::flag("first_building_jump_complete"))
	{
		var_05 = getnode(param_01,"targetname");
		self setgoalnode(var_05);
	}
}

//Function Number: 221
no_wait_building_jump(param_00,param_01)
{
	self endon("warping");
	var_02 = param_00 common_scripts\utility::spawn_tag_origin();
	var_02 thread maps\_anim::anim_reach_solo(self,param_00.animation,undefined,1);
	var_03 = common_scripts\utility::waittill_any_return("anim_reach_complete","override_anim_reach_play_binoc_scene");
	common_scripts\utility::flag_set("dialogue_building_jump");
	level thread maps\_utility::notify_delay("cormack_jumping_buildings",4);
	self.building_jump_initiate = 1;
	param_00 maps\_anim::anim_single_solo(self,param_00.animation);
	self.jump_complete = 1;
	var_02 delete();
}

//Function Number: 222
teleport_building_jump(param_00,param_01)
{
	self endon("warping");
	var_02 = param_00 common_scripts\utility::spawn_tag_origin();
	common_scripts\utility::flag_set("dialogue_building_jump");
	level thread maps\_utility::notify_delay("cormack_jumping_buildings",4);
	self.building_jump_initiate = 1;
	param_00 maps\_anim::anim_single_solo(self,param_00.animation);
	self.jump_complete = 1;
	var_02 delete();
}

//Function Number: 223
loop_wait_building_jump(param_00,param_01,param_02)
{
	self endon("warping");
	var_03 = param_00 common_scripts\utility::spawn_tag_origin();
	var_03 maps\_anim::anim_reach_solo(self,param_00.animation);
	self.building_jump_initiate = 1;
	var_03 thread maps\_anim::anim_loop_solo(self,"seo_mall_sizeup_jump_cormack_idle");
	self.in_position_building_jump = 1;
	if(!isdefined(param_01) || param_01)
	{
		while(!common_scripts\utility::flag("player_leaving_squad") && !isdefined(level.cormack.in_position_building_jump))
		{
			wait 0.05;
		}

		while(!common_scripts\utility::flag("player_leaving_squad") && !isdefined(level.will_irons.in_position_building_jump))
		{
			wait 0.05;
		}

		while(!common_scripts\utility::flag("player_leaving_squad") && !level.cormack.in_position_building_jump || !level.will_irons.in_position_building_jump)
		{
			wait(0.05);
		}
	}

	common_scripts\utility::flag_set("dialogue_building_jump");
	level thread maps\_utility::notify_delay("cormack_jumping_buildings",4);
	if(isdefined(param_02) && param_02)
	{
		maps\_shg_design_tools::anim_stop(var_03);
	}

	if(common_scripts\utility::flag("player_leaving_squad"))
	{
		self.building_jump_initiate = 1;
		self.jump_complete = 1;
		var_03 delete();
		return;
	}

	self.building_jump_initiate = 1;
	param_00 maps\_anim::anim_single_solo(self,param_00.animation);
	self.jump_complete = 1;
	var_03 delete();
}

//Function Number: 224
frame_wait_building_jump(param_00,param_01,param_02)
{
	self endon("warping");
	var_03 = param_00 common_scripts\utility::spawn_tag_origin();
	var_03 maps\_anim::anim_reach_solo(self,param_00.animation);
	self.building_jump_initiate = 1;
	param_00 thread maps\_anim::anim_first_frame_solo(self,param_00.animation);
	self.in_position_building_jump = 1;
	if(!isdefined(param_01) || param_01)
	{
		while(!isdefined(level.cormack.in_position_building_jump))
		{
			wait 0.05;
		}

		while(!isdefined(level.will_irons.in_position_building_jump))
		{
			wait 0.05;
		}

		while(!level.cormack.in_position_building_jump || !level.will_irons.in_position_building_jump)
		{
			wait(0.05);
		}
	}

	common_scripts\utility::flag_set("dialogue_building_jump");
	level thread maps\_utility::notify_delay("cormack_jumping_buildings",4);
	self.building_jump_initiate = 1;
	param_00 maps\_anim::anim_single_solo(self,param_00.animation);
	self.jump_complete = 1;
	var_03 delete();
}

//Function Number: 225
handle_pac_snipers()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_enemy_waterfall");
	var_00 = getnodearray("cover_hotel_laser_snipers","targetname");
	var_01 = getentarray("spawner_hotel_enemies_laser_guys","targetname");
	foreach(var_03 in var_00)
	{
		var_04 = common_scripts\utility::random(var_01) maps\_shg_design_tools::actual_spawn();
		if(!isdefined(var_04))
		{
			continue;
		}

		var_04 setgoalnode(var_03);
		var_04.fixednode = 1;
		var_04 pac_enemy_stats();
		var_04 thread forcelaser();
		wait(0.1);
	}

	var_06 = common_scripts\utility::getstructarray("struct_sniper_line_gag","targetname");
	foreach(var_08 in var_06)
	{
		var_04 = common_scripts\utility::random(var_01) maps\_shg_design_tools::actual_spawn();
		if(!isdefined(var_04))
		{
			continue;
		}

		var_04 pac_enemy_stats();
		var_04 thread forcelaser();
		var_08 thread maps\_anim::anim_generic_loop(var_04,var_08.animation);
		wait(randomfloatrange(0.1,0.5));
	}

	level waittill("never");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_convention_center_combat_05");
	var_0A = common_scripts\utility::getstructarray("struct_laser_sniper_group1","targetname");
	var_0B = common_scripts\utility::getstructarray("struct_laser_sniper_group2","targetname");
	var_0C = common_scripts\utility::getstructarray("struct_laser_sniper_group1_targets","targetname");
	var_0D = common_scripts\utility::getstructarray("struct_laser_sniper_group2_targets","targetname");
	thread turn_on_laser_group_and_scan(var_0A,var_0C);
	thread turn_on_laser_group_and_scan(var_0B,var_0D);
}

//Function Number: 226
turn_on_laser_group_and_scan(param_00,param_01)
{
	param_01 = common_scripts\utility::array_randomize(param_01);
	foreach(var_05, var_03 in param_00)
	{
		var_04 = spawn("script_model",var_03.origin);
		var_04 setmodel("tag_laser");
		var_04 thread scan_space_with_noise(param_01[var_05]);
	}
}

//Function Number: 227
scan_space_with_noise(param_00)
{
	wait(randomfloat(2));
	self laseron();
	var_01 = randomintrange(4,6);
	var_02 = randomintrange(3,5);
	var_03 = randomintrange(2,3);
	var_04 = randomfloatrange(0.25,0.5);
	var_05 = randomint(100);
	for(;;)
	{
		var_06 = maps\_shg_design_tools::getperlinovertime(var_01,var_02,var_03,var_04,var_05);
		self.angles = vectortoangles(param_00.origin - self.origin + var_06);
		wait(0.05);
	}
}

//Function Number: 228
forcelaser()
{
	self endon("death");
	for(;;)
	{
		self laseron("lag_snipper_laser");
		wait(0.25);
	}
}

//Function Number: 229
handle_hotel_enemy_fallback()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_convention_center_combat_02");
	var_00 = getent("vol_hotel_zipline_defend_01","script_noteworthy");
	var_01 = getent("vol_hotel_zipline_defend_02","script_noteworthy");
	level notify("hotel_fallback");
	foreach(var_03 in level.monitor_setup_group)
	{
		if(isdefined(var_03) && var_03 istouching(var_00))
		{
			var_03 setgoalvolumeauto(var_01);
		}
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trig_convention_center_combat_03");
	var_00 = getent("vol_hotel_zipline_defend_02","script_noteworthy");
	var_01 = getentarray("vol_hotel_zipline_defend_03","script_noteworthy");
	level notify("hotel_fallback");
	foreach(var_03 in level.monitor_setup_group)
	{
		if(isdefined(var_03) && var_03 istouching(var_00))
		{
			var_03 setgoalvolumeauto(common_scripts\utility::random(var_01));
		}
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trig_convention_center_combat_04");
	var_00 = getentarray("vol_hotel_zipline_defend_03","script_noteworthy");
	var_01 = getentarray("vol_hotel_zipline_defend_04","script_noteworthy");
	level notify("hotel_fallback");
	foreach(var_03 in level.monitor_setup_group)
	{
		foreach(var_09 in var_00)
		{
			if(isdefined(var_03) && var_03 istouching(var_09))
			{
				var_03 setgoalvolumeauto(common_scripts\utility::random(var_01));
			}
		}
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trig_convention_center_combat_06");
	var_00 = getentarray("vol_hotel_zipline_defend_04","script_noteworthy");
	var_01 = getentarray("vol_hotel_zipline_defend_04b","script_noteworthy");
	level notify("hotel_fallback");
	foreach(var_03 in level.monitor_setup_group)
	{
		foreach(var_09 in var_00)
		{
			if(isdefined(var_03) && var_03 istouching(var_09))
			{
				var_03 setgoalvolumeauto(common_scripts\utility::random(var_01));
			}
		}
	}
}

//Function Number: 230
handle_hotel_zipline_break_glass()
{
	var_00 = getglass("big_screen_glass_01");
	var_01 = getglass("big_screen_glass_02");
	var_02 = getent("big_screen_video_01","targetname");
	var_03 = getent("big_screen_video_02","targetname");
	var_04 = getentarray("big_screen_static_01","targetname");
	var_05 = getentarray("big_screen_static_02","targetname");
	var_06 = common_scripts\utility::getstructarray("big_screen_struct_01","targetname");
	var_07 = common_scripts\utility::getstructarray("big_screen_struct_02","targetname");
	common_scripts\utility::array_call(var_04,::hide);
	common_scripts\utility::array_call(var_05,::hide);
	var_08 = getglass("big_screen_glass_03");
	var_09 = getglass("big_screen_glass_04");
	var_0A = getent("big_screen_video_03","targetname");
	var_0B = getent("big_screen_video_04","targetname");
	var_0C = getentarray("big_screen_static_03","targetname");
	var_0D = getentarray("big_screen_static_04","targetname");
	var_0E = common_scripts\utility::getstructarray("big_screen_struct_03","targetname");
	var_0F = common_scripts\utility::getstructarray("big_screen_struct_04","targetname");
	common_scripts\utility::array_call(var_0C,::hide);
	common_scripts\utility::array_call(var_0D,::hide);
	var_10 = ["sparks_burst_a_nolight"];
	for(var_11 = 0;var_11 < 4;var_11++)
	{
		destroy_screen_pac(var_01,var_03,var_05,var_07,var_10);
	}

	destroy_screen_pac(var_00,var_02,var_04,var_06,var_10);
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_enemy_waterfall");
	destroy_screen_pac(var_08,var_0A,var_0C,var_0E,var_10);
	destroy_screen_pac(var_09,var_0B,var_0D,var_0F,var_10);
}

//Function Number: 231
destroy_screen_pac(param_00,param_01,param_02,param_03,param_04)
{
	level waittill("zipline_triggered",var_05,var_06);
	if(!isglassdestroyed(param_00))
	{
		destroyglass(param_00,var_06 - var_05);
		param_01 hide();
		common_scripts\utility::array_call(param_02,::show);
		foreach(var_08 in param_03)
		{
			playfx(common_scripts\utility::getfx("glass_shatter_xlarge"),var_08.origin);
			playfx(common_scripts\utility::getfx(common_scripts\utility::random(param_04)),var_08.origin);
			if(common_scripts\utility::cointoss())
			{
				var_08 thread play_persistent_fx_on_screen(param_04);
			}
		}
	}
}

//Function Number: 232
play_persistent_fx_on_screen(param_00)
{
	self endon("end_persistent_fx");
	thread maps\_utility::notify_delay("end_persistent_fx",randomfloatrange(4,10));
	for(;;)
	{
		if(common_scripts\utility::cointoss())
		{
			playfx(common_scripts\utility::getfx(common_scripts\utility::random(param_00)),self.origin);
		}

		wait(randomfloat(2));
	}
}

//Function Number: 233
handle_pac_zipline_intos()
{
	level.monitor_setup_group = [];
	thread handle_hotel_enemy_fallback();
	thread handle_hotel_zipline_break_glass();
	var_00 = getent("vol_hotel_zipline_defend_01","script_noteworthy");
	var_01 = getentarray("struct_reverse_zipline_start_group2","targetname");
	var_02 = getentarray("struct_reverse_zipline_start_group3","targetname");
	var_03 = getent("spawner_hotel_zipline_guys","targetname");
	var_04 = getentarray("vol_hotel_zipline_defend","targetname");
	var_05 = getentarray("vol_hotel_waterfall_defend_2","targetname");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_hotel_zipline_gag");
	if(level.currentgen)
	{
		if(!istransientloaded("seoul_mall_offices_tr"))
		{
			level waittill("transients_truck_push_to_mall_office");
		}
	}

	common_scripts\utility::flag_set("dialogue_performing_arts_interior");
	if(level.currentgen)
	{
		var_06 = getentarray("hotel_zipline_panel","targetname");
		for(var_07 = 0;var_07 < var_06.size;var_07++)
		{
			var_06[var_07] hide();
			var_06[var_07] connectpaths();
			var_06[var_07] setcontents(0);
		}
	}

	var_08 = 70;
	var_09 = level.player.origin;
	var_0A = getnodearray("node_zipline1_covers","targetname");
	var_01 = sortbydistance(var_01,level.player.origin);
	var_0B = [];
	thread zipline_guy_laser_think();
	thread zipline_guy_shoot_think();
	foreach(var_0D in var_01)
	{
		if(!isdefined(var_0D.script_noteworthy))
		{
			continue;
		}

		var_0E = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline(var_03,var_0D);
		var_0E pac_enemy_stats();
		level.monitor_setup_group[level.monitor_setup_group.size] = var_0E;
		var_0F = distance(var_09,var_0D.origin);
		var_10 = var_0F / var_08 * 0.05;
		wait(var_10);
		var_09 = var_0D.origin;
		if(!isdefined(var_0E))
		{
			return;
		}

		var_0B[var_0B.size] = var_0E;
	}

	assign_nodes_to_zipline_guys(var_0B,var_0A,var_04);
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_enemy_waterfall");
	foreach(var_0D in var_02)
	{
		if(!isdefined(var_0D.script_noteworthy))
		{
			continue;
		}

		level.monitor_setup_group[level.monitor_setup_group.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline(var_03,var_0D);
		var_0F = distance(var_09,var_0D.origin);
		var_10 = var_0F / var_08 * 0.05;
		wait(var_10);
		var_09 = var_0D.origin;
	}
}

//Function Number: 234
zipline_guy_laser_think()
{
	level waittill("zipline_guys_spawned",var_00);
	if(isdefined(var_00))
	{
		var_00.force_laser_on = 1;
		var_00 thread forcelaser();
	}

	for(;;)
	{
		level waittill("zipline_guys_spawned",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		var_00.force_laser_on = 1;
		if(maps\_shg_design_tools::percentchance(25))
		{
			var_00 thread forcelaser();
		}
	}
}

//Function Number: 235
zipline_guy_shoot_think()
{
	level waittill("zipline_guys_spawned",var_00);
	if(isdefined(var_00))
	{
		var_00 thread shoot_while_ziplining();
	}

	for(;;)
	{
		level waittill("zipline_guys_spawned",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(maps\_shg_design_tools::percentchance(35))
		{
			var_00 thread shoot_while_ziplining();
		}
	}
}

//Function Number: 236
shoot_while_ziplining()
{
	self endon("end_allow_death_during_zipline");
	self endon("death");
	for(;;)
	{
		var_00 = randomintrange(5,18);
		for(var_01 = 0;var_01 < var_00;var_01++)
		{
			self shoot();
			wait 0.05;
		}

		wait(0.5);
	}
}

//Function Number: 237
assign_nodes_to_zipline_guys(param_00,param_01,param_02)
{
	var_03 = [];
	foreach(var_05 in param_00)
	{
		var_06 = maps\_shg_design_tools::sortbydistanceauto(param_01,var_05.zipline_end_org);
		var_07 = 0;
		foreach(var_09 in var_06)
		{
			if(var_07)
			{
				continue;
			}

			if(!maps\_utility::is_in_array(var_03,var_09))
			{
				var_05 setgoalnode(var_09);
				var_03[var_03.size] = var_09;
				var_07 = 1;
			}
		}

		if(!var_07)
		{
			var_0B = common_scripts\utility::random(param_02);
			var_05 setgoalvolumeauto(var_0B);
			iprintln("node find fail");
		}
	}
}

//Function Number: 238
interior_fallback_think(param_00)
{
	self endon("death");
	var_01[0] = getentarray("vol_hotel_zipline_defend_02","script_noteworthy");
	var_01[1] = getentarray("vol_hotel_zipline_defend_03","script_noteworthy");
	var_01[2] = getentarray("vol_hotel_zipline_defend_04","script_noteworthy");
	var_02 = param_00;
	for(;;)
	{
		if(!isdefined(var_01[var_02]))
		{
			break;
		}

		if(isdefined(self))
		{
			self setgoalvolumeauto(common_scripts\utility::random(var_01[var_02]));
		}

		var_02++;
		level waittill("hotel_fallback");
	}
}

//Function Number: 239
handle_pac_combat()
{
	var_00 = getentarray("spawner_convention_center_ar_01","targetname");
	var_01 = getentarray("spawner_convention_center_ar_01b","targetname");
	var_02 = getentarray("spawner_convention_center_ar_02","targetname");
	var_03 = getentarray("spawner_convention_center_ar_03","targetname");
	var_04 = getentarray("spawner_convention_center_ar_04","targetname");
	var_05 = getentarray("spawner_convention_center_ar_04b","targetname");
	var_06 = getentarray("spawner_convention_center_smg_01","targetname");
	var_07 = getentarray("spawner_convention_center_smg_02","targetname");
	var_08 = getentarray("spawner_convention_center_smg_03","targetname");
	var_09 = getentarray("spawner_convention_center_smg_04","targetname");
	var_0A = getentarray("spawner_hotel_enemies_laser_guys","targetname");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_hotel_zipline_gag");
	var_0B = 3;
	if(level.gameskill > 1)
	{
		var_0B = 5;
	}

	for(var_0C = 0;var_0C < var_0B;var_0C++)
	{
		var_0D = common_scripts\utility::random(var_00) maps\_shg_design_tools::actual_spawn(1);
		var_0D thread interior_fallback_think(0);
		var_0D pac_enemy_stats();
		wait(1.5);
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trig_convention_center_combat_03");
	for(var_0C = 0;var_0C < var_0B;var_0C++)
	{
		var_0D = common_scripts\utility::random(var_0A) maps\_shg_design_tools::actual_spawn(1);
		var_0D thread interior_fallback_think(1);
		var_0D pac_enemy_stats();
		wait(1.5);
	}
}

//Function Number: 240
pac_enemy_stats(param_00)
{
	self.grenadeammo = 0;
	self.goalradius = 128;
	if(!isdefined(level.pac_enemy_group))
	{
		level.pac_enemy_group = [];
	}

	level.pac_enemy_group[level.pac_enemy_group.size] = self;
}

//Function Number: 241
make_exploder_truck(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_00.origin);
	var_03 setmodel(param_02);
	var_03.animname = param_01;
	var_03 maps\_anim::setanimtree();
	return var_03;
}

//Function Number: 242
vehicle_explosions_for_drone_swarm()
{
	wait 0.05;
	wait(2);
	if(level.currentgen && !issubstr(level.transient_zone,"_droneswarm1"))
	{
		level waittill("transients_fob_to_drone_seq_one");
	}

	var_00 = common_scripts\utility::getstruct("struct_truck_explode_01","targetname");
	var_01 = make_exploder_truck(var_00,"truck_explode_01","vehicle_civ_pickup_truck_01_wrecked");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"truck_explode");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_e3_fallback_01");
	common_scripts\utility::flag_set("dialogue_drone_swarm_intro");
	var_00 thread maps\_anim::anim_single_solo(var_01,"truck_explode");
	var_01 thread destroy_truck_01(var_00);
	var_01 thread fire_at_truck_01();
	thread drone_car_exploders();
}

//Function Number: 243
drone_car_exploders()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_01 = getent("model_phys_car_01","targetname");
	var_01.explode = common_scripts\utility::getstruct("struct_phys_launch_01","targetname");
	var_00 maps\_shg_design_tools::angles_and_origin(var_01.explode);
	var_02 = var_00 maps\_shg_design_tools::offset_position_from_tag("forward","tag_origin",30);
	var_01.vec = var_02 - var_01.explode.origin;
	var_03 = undefined;
	if(level.nextgen)
	{
		var_03 = getent("model_phys_car_02","targetname");
		var_03.explode = common_scripts\utility::getstruct("struct_phys_launch_02","targetname");
		var_00 maps\_shg_design_tools::angles_and_origin(var_03.explode);
		var_02 = var_00 maps\_shg_design_tools::offset_position_from_tag("forward","tag_origin",30);
		var_03.vec = var_02 - var_03.explode.origin;
	}

	var_04 = getent("model_phys_car_04","targetname");
	var_04.explode = common_scripts\utility::getstruct("struct_phys_launch_04","targetname");
	var_00 maps\_shg_design_tools::angles_and_origin(var_04.explode);
	var_02 = var_00 maps\_shg_design_tools::offset_position_from_tag("forward","tag_origin",30);
	var_04.vec = var_02 - var_04.explode.origin;
	var_01 thread launch_car_with_missiles(115);
	soundscripts\_snd::snd_message("start_drone_barrage_submix");
	playfxontag(common_scripts\utility::getfx("seo_car_explo_fire_trail"),var_01,"tag_origin");
	wait(0.5);
	if(level.nextgen)
	{
		var_03 thread launch_car_with_missiles(50);
		thread fire_drone_swarm_at_walker();
		playfxontag(common_scripts\utility::getfx("seo_car_explo_fire_trail"),var_03,"tag_origin");
	}

	wait(9);
	var_04 thread launch_car_with_missiles(50);
	playfxontag(common_scripts\utility::getfx("seo_car_explo_fire_trail"),var_04,"tag_origin");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_brush_guide_group1");
	var_00 delete();
}

//Function Number: 244
fire_drone_swarm_at_walker()
{
	var_00 = randomintrange(2,4);
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		if(!isdefined(level.walker_tank))
		{
			return;
		}

		var_02 = common_scripts\utility::getclosest(level.walker_tank.origin,level.flock_drones,3000);
		if(!isdefined(var_02))
		{
			if(var_01 == 0)
			{
				return;
			}
			else
			{
				break;
			}
		}

		var_03 = var_02.origin;
		var_02 delete();
		var_04 = magicbullet("remote_missile_drone_light",var_03,level.walker_tank.origin + (randomintrange(-100,100),randomintrange(-100,100),randomintrange(-100,100)));
		wait(0.25);
	}
}

//Function Number: 245
launch_car_with_missiles(param_00)
{
	var_01 = 1;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = common_scripts\utility::getclosest(self.origin,level.flock_drones,3000);
		if(!isdefined(var_03))
		{
			if(var_02 == 0)
			{
				return;
			}
			else
			{
				break;
			}
		}

		var_04 = var_03.origin;
		var_03 delete();
		var_05 = magicbullet("remote_missile_drone_light",var_04,self.origin + (randomintrange(-100,100),randomintrange(-100,100),randomintrange(-100,100)));
		wait(0.1);
	}

	playfx(common_scripts\utility::getfx("seo_drones_car_explo"),self.origin);
	self physicslaunchserver(self.explode.origin,self.vec * param_00);
	soundscripts\_snd::snd_message("seo_big_car_explo");
	self waittill("physics_finished");
	playfx(common_scripts\utility::getfx("seo_drones_car_explo"),self.origin);
	soundscripts\_snd::snd_message("seo_big_car_explo");
	self delete();
}

//Function Number: 246
destroy_truck_01(param_00)
{
	level waittill("truck_01_explode");
	playfx(common_scripts\utility::getfx("seo_drones_car_explo"),self.origin);
	soundscripts\_snd::snd_message("seo_truck_explo");
}

//Function Number: 247
fire_at_truck_01()
{
	level endon("truck_01_explode");
	for(;;)
	{
		var_00 = common_scripts\utility::getclosest(self.origin,level.flock_drones,2000);
		var_00 hide();
		var_01 = magicbullet("remote_missile_drone_light",var_00.origin,self.origin);
		soundscripts\_snd::snd_message("seo_drone_missile",var_01);
		wait(randomfloatrange(0.5,1));
	}
}

//Function Number: 248
snake_shoot_allies()
{
	while(!isdefined(level.drone_street_allies))
	{
		wait 0.05;
	}

	while(level.drone_street_allies.size > 0)
	{
		foreach(var_01 in level.drone_street_allies)
		{
			if(!isdefined(var_01))
			{
				continue;
			}

			if(common_scripts\utility::cointoss())
			{
				var_01 shoot_drone_at_ally(1);
			}
		}

		wait 0.05;
	}
}

//Function Number: 249
shoot_drone_at_ally(param_00)
{
	self endon("death");
	var_01 = common_scripts\utility::getclosest(self.origin,level.flock_drones,1000);
	var_02 = distance(level.player.origin,self.origin);
	if(!isdefined(var_01))
	{
		wait(1);
		return;
	}

	if(isdefined(param_00) && param_00)
	{
		if(var_02 < 356)
		{
			return;
		}
	}

	var_03 = var_01.origin;
	var_01 delete();
	var_04 = magicbullet("remote_missile_drone_light",var_03,self.origin);
	soundscripts\_snd::snd_message("seo_drone_missile_impact",self.origin);
	wait(1.5);
}

//Function Number: 250
disable_turret_missiles()
{
	level.mobile_turret endon("death");
	for(;;)
	{
		level.mobile_turret notify("end_rocket_think");
		level.mobile_turret notify("disable_missile_input");
		wait 0.05;
	}
}

//Function Number: 251
monitor_x4_vm_swap()
{
	level waittill("swapped_x4walker",var_00);
	var_01 = var_00 setcontents(0);
	common_scripts\utility::flag_waitopen("player_in_x4walker");
	var_00 setcontents(var_01);
}

//Function Number: 252
setup_mobile_turret()
{
	thread monitor_x4_vm_swap();
	wait(5);
	level.x4walker_wheels_seoul_turret = 1;
	level.x4walker_player_invulnerability = 0;
	level.killable_kamikazes = 1;
	var_00 = getent("mobile_turret_drone_street","targetname");
	var_00 thread make_modile_turret_invincible();
	var_00 thread fake_drone_shooting();
	foreach(var_02 in level.mt_use_tags)
	{
		if(level.player common_scripts\utility::is_player_gamepad_enabled())
		{
			var_02 sethintstring(&"SEOUL_ENTER_MOBILE_TURRET_SEOUL");
			continue;
		}

		var_02 sethintstring(&"SEOUL_ENTER_MOBILE_TURRET_SEOUL_PC");
	}

	level.mobile_turret = var_00;
	thread disable_turret_missiles();
	level.player waittill("player_in_x4walker");
	var_00 hide();
	var_00.origin = var_00.origin - (0,0,100);
	common_scripts\utility::flag_set("will_cardoor_watcher_flag");
	var_04 = common_scripts\utility::getstructarray("struct_start_point_hotel_entrance_1","targetname");
	foreach(var_07, var_06 in level.squad)
	{
		var_06 forceteleport(var_04[var_07].origin,var_04[var_07].angles);
	}

	common_scripts\utility::flag_waitopen("player_in_x4walker");
	var_00 show();
	var_00.origin = var_00.origin + (0,0,100);
}

//Function Number: 253
mobile_turret_health_1()
{
	self endon("death");
	self endon("stop_mobile_turret_health_1");
	level.player endon("player_exited_mobile_turret");
	var_00 = "seo_spark_droppod_door";
	var_01 = "TAG_turret";
	var_02 = "TAG_turret";
	playfxontag(common_scripts\utility::getfx(var_00),self,var_01);
	wait(randomfloat(3.75));
	playfxontag(common_scripts\utility::getfx(var_00),self,var_02);
	wait(randomfloat(1.75));
	playfxontag(common_scripts\utility::getfx(var_00),self,var_01);
}

//Function Number: 254
mobile_turret_health_2()
{
	self endon("death");
	self endon("stop_mobile_turret_health_2");
	level.player endon("player_exited_mobile_turret");
	level endon("end_cherry_picker");
	level endon("missionfailed");
	if(isdefined(self.mgturret) && isdefined(self.mgturret[0]))
	{
		playfxontag(common_scripts\utility::getfx("mobile_turret_fire_small"),self.mgturret[0],"TAG_FIRE_1");
	}

	wait(randomfloat(2));
	if(isdefined(self.mgturret) && isdefined(self.mgturret[0]))
	{
		playfxontag(common_scripts\utility::getfx("mobile_turret_fire_small"),self.mgturret[0],"TAG_FIRE_2");
	}
}

//Function Number: 255
mobile_turret_health_3()
{
	self endon("death");
	self endon("stop_mobile_turret_health_3");
	level.player endon("player_exited_mobile_turret");
	var_00 = "mobile_turret_fire_large";
	var_01 = "TAG_FIRE_2";
	if(isdefined(self.mgturret) && isdefined(self.mgturret[0]))
	{
		playfxontag(common_scripts\utility::getfx(var_00),self.mgturret[0],var_01);
	}
}

//Function Number: 256
fake_drone_shooting()
{
	level.player waittill("player_in_x4walker");
	thread fake_drone_shooting_internal();
}

//Function Number: 257
fake_drone_shooting_internal()
{
	level.player endon("player_exited_mobile_turret");
	level.player.num_drones_killed = 0;
	var_00 = 0.5;
	for(;;)
	{
		if(level.player attackbuttonpressed())
		{
			var_01 = getarrayelementsincone(level.flock_drones,level.player geteye(),anglestoforward(level.player getplayerangles()),var_00,12);
			var_02 = 0;
			foreach(var_04 in var_01)
			{
				if(!isdefined(var_04))
				{
					continue;
				}

				if(isdefined(var_04.kamikaze))
				{
					var_04 vehicle_scripts\_attack_drone_common::totally_fake_drone_death(0,1,undefined,1);
					continue;
				}

				if(maps\_shg_design_tools::percentchance(25))
				{
					if(!var_02)
					{
						var_04 vehicle_scripts\_attack_drone_common::totally_fake_drone_death(0,1);
					}
					else
					{
						var_04 vehicle_scripts\_attack_drone_common::totally_fake_drone_death(0,1,undefined,undefined,1);
					}

					level.player.num_drones_killed++;
					var_02 = 1;
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 258
play_explosion_sound_drone_success(param_00)
{
	var_01 = param_00.origin;
	for(var_02 = 0;var_02 < 3;var_02++)
	{
		soundscripts\_snd_playsound::snd_play_at("exp_amb_mid_air",level.player.origin);
		soundscripts\_snd::snd_message("seo_ambient_ground_explosions",level.player.origin);
		wait(0.1);
	}
}

//Function Number: 259
zap_local_drones(param_00)
{
	var_01 = maps\_shg_design_tools::sortbydistanceauto(level.flock_drones,param_00.origin);
	var_02 = 400;
	for(var_03 = 0;var_03 < 20;var_03++)
	{
		if(distance(var_01[var_03].origin,param_00.origin) < var_02)
		{
			var_01[var_03] vehicle_scripts\_attack_drone_common::totally_fake_drone_death(0);
		}
	}
}

//Function Number: 260
getarrayelementsincone(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = cos(param_03);
	if(isdefined(param_04))
	{
		var_06 = param_01 - param_02 * param_04 / tan(param_03);
	}
	else
	{
		var_06 = param_02;
	}

	var_07 = [];
	foreach(var_09 in param_00)
	{
		if(isdefined(var_09) && vectordot(vectornormalize(var_09.origin - var_06),param_02) > var_05 && !isdefined(param_04) || vectordot(var_09.origin - param_01,param_02) > 0)
		{
			var_07[var_07.size] = var_09;
		}
	}

	return var_07;
}

//Function Number: 261
monitor_mobile_turret_missiles()
{
	self.drone_targets = [];
	for(;;)
	{
		level.player waittill("attack_pressed");
		if(self.drone_targets.size > 0)
		{
			foreach(var_01 in self.drone_targets)
			{
				wait(randomfloat(0.25));
				if(isdefined(var_01))
				{
					var_02 = magicbullet("hovertank_missile_small_straight",self.origin + (0,0,96),var_01.origin);
					var_02 missile_settargetent(var_01);
				}
			}
		}
	}
}

//Function Number: 262
make_modile_turret_invincible()
{
	var_00 = self.maxhealth;
	self.makeinvul = 1;
	for(;;)
	{
		if(self.makeinvul)
		{
			self.maxhealth = var_00 * 2;
			self.health = self.maxhealth;
		}

		wait 0.05;
	}
}

//Function Number: 263
setup_mobile_turret_gameplay()
{
	thread setup_mobile_turret();
	wait(1);
	thread snake_gameplay_for_turret();
	level.player waittill("player_in_x4walker");
	common_scripts\utility::flag_set("dialogue_drone_turret_sequence");
	level notify("end_drone_kamikaze_player");
	level notify("cherry_picker_turret_in_use");
	level.mobile_turret cherry_picker_turret_gameplay();
}

//Function Number: 264
mobile_turret_hint_button()
{
	level.player endon("player_in_x4walker");
	level.player waittill("player_has_cardoor");
	var_00 = level.mobile_turret gettagorigin("tag_body");
	var_01 = maps\_shg_utility::hint_button_position("x",var_00,48,1000);
	thread mobile_turret_hint_button_clear(var_01);
}

//Function Number: 265
mobile_turret_hint_button_clear(param_00)
{
	level.player waittill("player_in_x4walker");
	param_00 maps\_shg_utility::hint_button_clear();
}

//Function Number: 266
snake_cloud_get_target_boids(param_00,param_01)
{
	level endon("end_cherry_picker");
	level endon("snake_charge_ended");
	if(!isdefined(level.player.drone_target_center))
	{
		level.player.drone_target_center = common_scripts\utility::spawn_tag_origin();
	}

	level.player.drone_target_center unlink();
	level.player.drone_target_center.boids = [];
	var_02 = [];
	var_03 = (0,0,0);
	foreach(var_05 in self.snakes)
	{
		var_03 = var_03 + var_05 vehicle_getvelocity();
	}

	var_03 = vectornormalize(var_03);
	level.player.drone_target_center thread follow_drone_turret_target(param_01);
	var_07 = 70;
	for(var_08 = 0;var_08 < param_00;var_08++)
	{
		var_09 = spawn("script_model",level.player.drone_target_center.origin);
		var_09 setmodel("vehicle_mil_attack_drone_ai");
		var_09.tag_ent = common_scripts\utility::spawn_tag_origin();
		var_0A = (randomintrange(var_07 * -1,var_07),randomintrange(var_07 * -1,var_07),randomintrange(var_07 * -1,var_07));
		var_09.tag_ent.origin = level.player.drone_target_center.origin + var_0A;
		var_09.tag_ent linkto(level.player.drone_target_center,"tag_origin");
		var_09 thread cleanup_drone_tags();
		var_02[var_02.size] = var_09;
		level.player.drone_target_center.boids[level.player.drone_target_center.boids.size] = var_09;
	}

	return var_02;
}

//Function Number: 267
cleanup_drone_tags()
{
	var_00 = self.tag_ent;
	while(isdefined(self))
	{
		wait 0.05;
	}

	var_00 maps\_shg_design_tools::delete_auto();
}

//Function Number: 268
make_drone_turret_target()
{
	level.flock_drones = common_scripts\utility::array_add(level.flock_drones,self);
	self.is_drone_turret_target = 1;
	self.drone_really_hit = 0;
	soundscripts\_snd::snd_message("cherry_picker_target_add");
	thread make_drone_turret_target_2();
	return self;
}

//Function Number: 269
cherry_picker_damage_alarm()
{
	level endon("EMP_triggered");
	for(;;)
	{
		level.player waittill("play_damage_alarm");
		soundscripts\_snd_playsound::snd_play_2d("droppod_missile_hit_alarms","EMP_triggered");
		wait(4);
	}
}

//Function Number: 270
make_drone_turret_target_2()
{
	self.is_drone_turret_target = 1;
	self.drone_really_hit = 0;
	level notify("new_drone_target");
	var_00 = 0;
	var_01 = "drone_turret_hud_target";
	var_02 = 256;
	var_03 = 256;
	var_04 = 156;
	if(!isdefined(level.player.drone_hud_targets))
	{
		level.player.drone_hud_targets = [];
	}

	var_05 = newclienthudelem(level.player);
	var_05 setshader(var_01,var_02,var_03);
	var_05.positioninworld = 1;
	var_05.alignx = "center";
	var_05.aligny = "middle";
	var_05.alpha = 1;
	var_05.foreground = 1;
	var_05.hidewheninmenu = 1;
	var_06 = common_scripts\utility::spawn_tag_origin();
	var_06.origin = self.origin;
	var_05 settargetent(var_06);
	level.player playsound("sensor_fusion_new_target");
	var_07 = 0;
	while(isdefined(self) && !self.drone_really_hit)
	{
		var_08 = level.player geteye();
		var_09 = self.origin + (0,0,var_00);
		var_0A = distance(var_09,var_08);
		var_07 = var_07 + 0.05;
		if(var_0A > 200)
		{
			var_0B = var_04 / var_0A;
		}
		else
		{
			var_0B = 100;
		}

		var_0C = piecewiselinearlookup(var_07,[[0,0],[0.8,2.6],[1,1]]);
		var_0D = var_0B * var_0C;
		var_0E = self.origin;
		var_05 setshader(var_01,int(var_02 * var_0D),int(var_03 * var_0D));
		var_06.origin = var_0E + (0,0,var_00);
		wait(0.05);
	}

	var_05 destroy();
	var_06 delete();
}

//Function Number: 271
handle_drone_turret_targeting()
{
	level endon("end_cherry_picker");
	level endon("snake_charge_ended");
	level.player endon("cherrypicker_exit");
	var_00 = randomintrange(1,3);
	var_01 = [];
	var_02 = 0;
	foreach(var_04 in self.boids)
	{
		var_05 = var_04 make_drone_turret_target();
		while(isdefined(var_05) && !var_05.drone_really_hit)
		{
			if(isdefined(var_05.drone_was_hit) && var_05.drone_was_hit && !isdefined(var_05.is_drone_turret_target))
			{
				var_05.drone_was_hit = undefined;
			}

			if(isdefined(var_05.drone_was_hit) && var_05.drone_was_hit)
			{
				var_05.drone_dead = 1;
				var_06 = 1;
				var_01 = common_scripts\utility::array_remove(var_01,var_05);
				var_05.drone_really_hit = 1;
			}

			wait 0.05;
		}
	}

	level notify("all_targeted_drones_killed");
	common_scripts\utility::flag_set("all_targeted_drones_dead");
}

//Function Number: 272
follow_drone_turret_target(param_00)
{
	level endon("end_cherry_picker");
	level endon("snake_charge_ended");
	level.player endon("cherrypicker_exit");
	while(self.boids.size <= 0)
	{
		wait 0.05;
	}

	thread end_follow_drone_on_emp();
	thread handle_drone_turret_targeting();
	thread handle_drone_turret_target_movement(param_00);
	thread remove_drone_turret_drones();
}

//Function Number: 273
remove_drone_turret_drones()
{
	level waittill("snake_charge_ended");
	foreach(var_01 in self.boids)
	{
		var_01 maps\_shg_design_tools::delete_auto();
	}
}

//Function Number: 274
handle_drone_turret_target_movement(param_00)
{
	level endon("end_cherry_picker");
	level endon("snake_charge_ended");
	level.player endon("cherrypicker_exit");
	var_01 = (randomfloatrange(-5,5),randomfloatrange(-5,5),randomfloatrange(-5,5));
	while(self.boids.size > 0)
	{
		level.snake_cloud.snakes = common_scripts\utility::array_removeundefined(level.snake_cloud.snakes);
		if(level.snake_cloud.snakes.size == 0)
		{
			break;
		}

		var_02 = maps\_utility::get_average_origin(level.snake_cloud.snakes) * 0.8;
		var_03 = param_00.origin * 0.2;
		self.origin = var_02 + var_03;
		self.angles = self.angles + var_01;
		foreach(var_05 in self.boids)
		{
			if(isdefined(var_05))
			{
				var_06 = maps\_shg_design_tools::getperlinovertime(5,3,2,0.5,10);
				var_07 = vectortoangles(self.origin - var_05.origin);
				var_08 = var_07 * 5;
				var_05.origin = var_05.tag_ent.origin;
				var_05.angles = vectortoangles(level.player.origin - var_05.origin);
			}
		}

		self.boids = common_scripts\utility::array_removeundefined(self.boids);
		wait 0.05;
	}
}

//Function Number: 275
end_follow_drone_on_emp()
{
	level common_scripts\utility::waittill_any("snake_charge_ended","end_cherry_picker");
	foreach(var_01 in self.boids)
	{
		var_01 maps\_shg_design_tools::delete_auto();
	}

	maps\_shg_design_tools::delete_auto();
}

//Function Number: 276
handle_snake_firing()
{
	level endon("end_cherry_picker");
	var_00 = undefined;
	for(;;)
	{
		level waittill("snake_charge_initiated");
		var_01 = [];
		foreach(var_03 in level.snake_cloud.snakes)
		{
			if(isdefined(var_03.lead_snake))
			{
				var_00 = var_03;
			}
		}

		if(isdefined(var_00))
		{
			var_05 = maps\_shg_design_tools::sortbydistanceauto(level.flock_drones,var_00.origin);
			for(var_06 = 0;var_06 < 6;var_06++)
			{
				var_01[var_01.size] = var_05[var_06];
			}
		}
		else
		{
			for(var_06 = 0;var_06 < 6;var_06++)
			{
				var_01[var_01.size] = level.flock_drones[var_06];
			}
		}

		foreach(var_08 in var_01)
		{
			var_08 thread drone_fire_at_turret();
		}
	}
}

//Function Number: 277
drone_fire_at_turret()
{
	level endon("snake_charge_ended");
	level endon("end_cherry_picker");
	while(isdefined(self))
	{
		var_00 = (randomintrange(-80,80),randomintrange(-80,80),48);
		drone_bullet(level.mobile_turret.origin + var_00,50);
		if(level.nextgen)
		{
			wait(randomfloat(0.15));
			continue;
		}

		wait(randomfloat(0.25));
	}
}

//Function Number: 278
drone_bullet(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 95;
	}

	if(!isdefined(param_02))
	{
		var_03 = (0,0,0);
	}
	else
	{
		var_03 = (randomfloatrange(var_03 * -1,var_03),randomfloatrange(var_03 * -1,var_03),randomfloatrange(var_03 * -1,var_03));
	}

	if(maps\_shg_design_tools::percentchance(param_01) && distance(level.player.origin,param_00) > 96)
	{
		var_04 = maps\seoul::cheapmagicbullet(level.drone_bullet,self.origin,param_00 + var_03);
		return;
	}

	var_04 = magicbullet(level.drone_bullet,self.origin,param_01 + var_04);
}

//Function Number: 279
handle_attack_drone_flyby_magnets()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("player_in_x4walker");
		level.player.magnet_radius = 192;
		common_scripts\utility::flag_waitopen("player_in_x4walker");
		level.player.magnet_radius = 288;
		wait 0.05;
	}
}

//Function Number: 280
handle_drones_attacking_walker()
{
	level endon("end_cherry_picker");
	level endon("snake_charge_initiated");
	level.walker_tank endon("death");
	while(isdefined(level.walker_tank) && level.walker_tank.classname != "script_vehicle_corpse")
	{
		var_00 = [];
		for(var_01 = 0;var_01 < 10;var_01++)
		{
			var_02 = common_scripts\utility::random(level.flock_drones);
			if(isdefined(var_02))
			{
				var_00[var_00.size] = var_02;
			}
		}

		if(var_00.size < 10)
		{
			return;
		}

		var_03 = maps\_utility::get_average_origin(var_00);
		var_04 = distance(var_03,level.walker_tank.origin);
		var_05 = distance(var_03,level.player.origin);
		while(var_05 < var_04)
		{
			var_04 = distance(var_03,level.walker_tank.origin);
			var_05 = distance(var_03,level.player.origin);
			wait 0.05;
		}

		while(var_05 > var_04)
		{
			drones_attack_walker_turret();
			wait(2);
		}
	}
}

//Function Number: 281
handle_kamikaze_drone_visibility()
{
	level endon("end_cherry_picker");
	while(!isdefined(level.spawned_kamikaze_drones))
	{
		wait 0.05;
	}

	for(;;)
	{
		foreach(var_01 in level.spawned_kamikaze_drones)
		{
			if(isdefined(var_01) && !isdefined(var_01.outlined))
			{
				var_01.outlined = 1;
				var_01 hudoutlineenable(1,1);
			}

			if(isdefined(var_01))
			{
				maps\seoul::cheapmagicbullet(level.drone_bullet,var_01.origin,level.player geteye() + (randomintrange(-50,50),randomintrange(-50,50),randomintrange(-50,50)));
			}
		}

		wait 0.05;
	}
}

//Function Number: 282
drones_attack_walker_turret()
{
	level.walker_tank thread fire_bullets_at_ent(15,"drone_swarm_hit");
	if(level.nextgen)
	{
		level.walker_tank thread fire_drones_at_ent(3,"drone_swarm_hit");
	}

	level waittill("drone_swarm_hit");
}

//Function Number: 283
snake_gameplay_for_turret()
{
	level.player waittill("player_in_x4walker");
	level notify("autosave_request");
	level waittill("drone_swarm_hit");
	level.big_kamikaze_death = 1;
	common_scripts\utility::flag_init("drone_turret_pass_won");
	thread monitor_snake_gameplay_failure();
	thread handle_snake_firing();
	thread handle_attack_drone_flyby_magnets();
	thread handle_kamikaze_drone_visibility();
	var_00 = 1;
	var_01 = "2";
	for(;;)
	{
		if(var_00)
		{
			var_00 = 0;
			var_02 = 0;
		}
		else
		{
			var_03 = var_01;
			while(var_03 == var_01)
			{
				var_01 = common_scripts\utility::random(["1","2","3"]);
				wait 0.05;
			}

			var_02 = 0;
		}

		level.drone_turret_fake_death_awesome = 0;
		var_04 = "snake_gameplay_wait_" + var_01;
		level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points(var_04,undefined,0,undefined,1);
		level notify("snake_moving_to_new_attack_path");
		thread handle_drones_attacking_walker();
		common_scripts\utility::flag_clear("snake_gameplay_attack_succeeded");
		level.snakes_attacking_turret = 1;
		var_05 = var_04 + "_end";
		common_scripts\utility::flag_clear(var_05);
		level waittill(var_05,var_06);
		common_scripts\utility::flag_wait(var_05);
		wait(var_02);
		level.player notify("play_damage_alarm");
		var_04 = "snake_gameplay_attack_" + var_01;
		level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points(var_04,undefined,0,undefined,1);
		var_07 = randomintrange(4,7);
		var_08 = [];
		level notify("snake_charge_initiated",var_08[0]);
		foreach(var_0A in var_08)
		{
			var_0A.drone_was_hit = undefined;
			var_0A.drone_is_target = 1;
		}

		var_05 = var_04 + "_end";
		common_scripts\utility::flag_clear(var_05);
		var_0C = 0;
		while(!common_scripts\utility::flag("all_targeted_drones_dead") && !common_scripts\utility::flag(var_05))
		{
			var_0C = 1;
			foreach(var_0A in var_08)
			{
				if(!isdefined(var_0A.drone_really_hit))
				{
					var_0C = 0;
					break;
				}
			}

			wait 0.05;
		}

		if(common_scripts\utility::flag("all_targeted_drones_dead") & !common_scripts\utility::flag("snake_gameplay_attack_succeeded"))
		{
			common_scripts\utility::flag_clear("all_targeted_drones_dead");
			level.snakes_attacking_turret = undefined;
			level.player.magnet_radius = 320;
			level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_stop_dynamic_control();
			level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_set_boid_settings(level.boid_settings_presets["frozen_snake"]);
			level notify("snake_charge_ended");
			wait(1.5);
			level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_resume_dynamic_control();
		}

		level.snakes_attacking_turret = undefined;
		var_04 = "snake_gameplay_retreat_" + var_01;
		level notify("snake_charge_ended",var_04);
		level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points(var_04,undefined,0.75,undefined,1,level.boid_settings_presets["default_snake"]);
		foreach(var_0A in var_08)
		{
			if(isdefined(var_0A.drone_is_target))
			{
				var_0A.drone_was_hit = undefined;
				var_0A.drone_is_target = undefined;
			}
		}

		var_05 = var_04 + "_end";
		common_scripts\utility::flag_clear(var_05);
		common_scripts\utility::flag_wait(var_05);
	}
}

//Function Number: 284
wait_till_snakes_nearby()
{
	var_00 = 3;
	var_01 = squared(128);
	var_02 = 0;
	while(var_02 < var_00)
	{
		if(isdefined(level.snake_cloud))
		{
			foreach(var_04 in level.snake_cloud.snakes)
			{
				if(distancesquared(var_04.origin,level.player.origin) < var_01)
				{
					return;
				}
			}
		}

		var_02 = var_02 + 0.05;
		wait(0.05);
	}
}

//Function Number: 285
monitor_player_health_in_turret()
{
	level.player enableinvulnerability();
	level waittill("end_cherry_picker");
	level.player disableinvulnerability();
}

//Function Number: 286
monitor_snake_gameplay_failure()
{
	level endon("EMP_triggered");
	var_00 = 3;
	var_01 = 0;
	thread monitor_player_health_in_turret();
	thread cherry_picker_damage_alarm();
	for(;;)
	{
		for(var_02 = 0;var_02 < 11;var_02++)
		{
			level.player waittill("kamikaze_hit_player");
			level.player notify("play_damage_alarm");
			if(var_02 == 0)
			{
				level.mobile_turret mobile_turret_health_2();
			}

			if(var_02 == 1)
			{
				level.mobile_turret mobile_turret_health_2();
			}

			if(var_02 == 3)
			{
				level.mobile_turret mobile_turret_health_3();
			}
		}

		level.player.magnet_radius = 256;
		wait_till_snakes_nearby();
		var_01++;
		level.mobile_turret.makeinvul = 0;
		level.player dodamage(level.player.health * 2,level.player.origin);
		level.mobile_turret dodamage(level.mobile_turret.maxhealth * 5,level.mobile_turret.origin);
		level notify("stop_hud_overlay_update");
		setdvar("ui_deadquote",&"SEOUL_FAILED_DRONE_SWARM");
		thread maps\_utility::missionfailedwrapper();
		level notify("end_crash_into_player");
	}
}

//Function Number: 287
random_damage()
{
	level endon("stop_random_damage");
	for(;;)
	{
		level.player dodamage(10,level.player.origin);
		wait(randomfloat(1));
	}
}

//Function Number: 288
handle_drone_swarm_skipping()
{
	var_00 = getentarray("drone_swarm_skip","targetname");
	level waittill("end_cherry_picker");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin + (0,0,10000);
	}
}

//Function Number: 289
handle_drone_swarm_retreating()
{
	var_00 = getentarray("drone_swarm_retreat","targetname");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin + (0,0,10000);
	}

	maps\_shg_design_tools::waittill_trigger_with_name("start_pod_landings_group_3");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin - (0,0,10000);
	}
}

//Function Number: 290
handle_pac_retreating()
{
	var_00 = getentarray("hotel_retreat_left_map","targetname");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin + (0,0,10000);
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trig_convention_center_setup");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin - (0,0,10000);
	}
}

//Function Number: 291
handle_shopping_district_retreating()
{
	var_00 = getentarray("shopping_district_retreat_left_map","targetname");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin + (0,0,10000);
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trig_restaurant_spawn");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin - (0,0,10000);
	}
}

//Function Number: 292
handle_canal_intro_retreating()
{
	var_00 = getentarray("canal_intro_retreat_left_map","targetname");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin + (0,0,10000);
	}

	common_scripts\utility::flag_wait("sd_escaped_swarm");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin - (0,0,10000);
	}
}

//Function Number: 293
handle_swarm_scene()
{
	level endon("e3_presentation_cleanup");
	level.drones_vs_car_shield = 1;
	var_00 = getentarray("attack_drone_kamikaze_spawner","targetname");
	thread handle_drone_swarm_skipping();
	thread handle_drone_swarm_retreating();
	thread setup_cherry_picker_turret();
	thread setup_mobile_turret_gameplay();
	thread spawn_ally_ground_vehicles();
	thread anim_scene_will_grabs_car_door();
	thread maps\_shg_design_tools::trigger_to_flag("trigger_drone_swarm_flank","flag_trigger_drones");
	thread vehicle_explosions_for_drone_swarm();
	thread check_seoul_achievements();
	maps\_shg_design_tools::waittill_trigger_with_name("start_pod_landings_group_3");
	if(level.nextgen)
	{
		var_01 = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("queen_drone_cloud_2","snake_swarm_initial_area");
		var_01 thread cleanup_snake_cloud_on_flag("dialogue_performing_arts_interior");
		level.snake_cloud = var_01;
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trigger_e3_fallback_01");
	if(level.currentgen)
	{
		var_01 = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("queen_drone_cloud_2","snake_swarm_initial_area",8,12,undefined,65);
		var_01 thread cleanup_snake_cloud_on_flag("dialogue_performing_arts_interior");
		level.snake_cloud = var_01;
	}

	level notify("drone_swarm_spawning");
	var_02 = getent("vol_cardoor_objective_vol_a","targetname");
	var_03 = getent("vol_cardoor_objective_vol_b","targetname");
	var_04 = getent("vol_cardoor_objective_vol_c","targetname");
	var_05 = "snake_swarm_first_flyby";
	if(level.player istouching(var_03))
	{
		var_05 = "snake_swarm_first_flyby_2";
	}

	if(level.player istouching(var_04))
	{
		var_05 = "snake_swarm_first_flyby_path3";
	}

	level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points(var_05,undefined,3.25);
	thread snake_pick_intro_path();
	thread snake_follow_player(level.snake_cloud);
	thread snake_strafe_player_gets_cardoor();
	thread snake_shoot_allies();
	thread snake_crash_into_player_after_timeout(var_00);
	thread snake_shoot_ambient();
	thread snake_fight_walker_tank();
	thread snake_fight_before_turret();
	level notify("swarm_attack_column");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","3");
		setsaveddvar("r_mbVelocityScalar","1");
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trigger_drone_swarm_flank");
	level notify("new_drone_swarm");
	thread delay_drone_kamikaze_player(var_00[0]);
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_brush_guide_group1");
	wait(15);
	level notify("end_crash_into_player");
}

//Function Number: 294
snake_fight_walker_tank()
{
	level endon("drone_swarm_hit");
	level waittill("player_in_x4walker");
	level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("struct_swarm_circle_walker_tank_01",undefined,3.25);
	level notify("stop_kamikaze_player");
}

//Function Number: 295
make_walker_tank_invulnerable_for_time(param_00)
{
}

//Function Number: 296
make_walker_invulnerable()
{
	level.player endon("player_in_x4walker");
	level endon("walker_is_now_vulnerable");
	level.walker_tank endon("death");
	for(;;)
	{
		level.walker_tank.health = 22000;
		level.walker_tank.currenthealth = 22000;
		wait 0.05;
	}
}

//Function Number: 297
debug_show_walker_tank_health()
{
	level.walker_tank endon("death");
	for(;;)
	{
		iprintln(level.walker_tank.health);
		wait(0.5);
	}
}

//Function Number: 298
snake_fight_before_turret()
{
	level endon("drone_swarm_hit");
	thread handle_walker_tank_shooting_himself();
	thread handle_walker_tank_death();
	thread make_walker_invulnerable();
	thread handle_drone_swarm_shoot_at_player();
	common_scripts\utility::flag_wait_any("snake_swarm_first_flyby_end","player_in_x4walker","snake_swarm_cardoor_charge_end");
	if(level.nextgen)
	{
		thread spawn_allies_for_swarm_turret_segment();
	}

	level thread maps\_utility::notify_delay("walker_is_now_vulnerable",20);
	level.walker_tank thread fire_bullets_at_ent(15,"drone_swarm_hit");
	if(level.nextgen)
	{
		level.walker_tank thread fire_drones_at_ent(0.25,"drone_swarm_hit",1);
	}

	level.walker_tank waittill("death");
	common_scripts\utility::flag_set("walker_tank_is_dead");
	wait 0.05;
	level notify("drone_swarm_hit");
}

//Function Number: 299
handle_drone_swarm_shoot_at_player()
{
	level.player endon("player_in_x4walker");
	common_scripts\utility::flag_wait_any("snake_swarm_first_flyby_end","snake_swarm_cardoor_charge_end");
	wait(8);
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.origin = level.player geteye();
	var_01 = var_00 maps\_shg_design_tools::offset_position_from_tag("forward","tag_origin",800);
	var_00.origin = var_01;
	var_00 linktoplayerview(level.player,"tag_origin",(0,0,0),(0,0,0),0);
	for(;;)
	{
		var_02 = [];
		for(var_03 = 0;var_03 < 5;var_03++)
		{
			var_04 = common_scripts\utility::random(level.flock_drones);
			var_02[var_02.size] = var_04;
		}

		foreach(var_04 in var_02)
		{
			while(isdefined(var_04) && distance(var_00.origin,var_04.origin) < 600)
			{
				var_04 drone_bullet(level.player geteye(),undefined,64);
				wait(randomfloat(0.25));
			}
		}

		wait 0.05;
	}
}

//Function Number: 300
fire_drones_at_ent(param_00,param_01,param_02)
{
	level endon(param_01);
	self endon(param_01);
	self endon("death");
	level endon("end_cherry_picker");
	while(isdefined(self))
	{
		swarm_shoot_random_drone_at_ent(self);
		if(isdefined(param_02))
		{
			wait(randomfloatrange(param_00,param_02));
			continue;
		}

		wait(randomfloat(param_00));
	}
}

//Function Number: 301
fire_bullets_at_ent(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00;var_02++)
	{
		var_03 = common_scripts\utility::random(level.flock_drones);
		if(isdefined(var_03))
		{
			var_03 thread drone_shoot_at_ent(self,param_01);
			continue;
		}

		var_02 = var_02 - 1;
	}
}

//Function Number: 302
handle_walker_tank_death()
{
	if(level.nextgen)
	{
		while(level.walker_tank.classname != "script_vehicle_corpse" && level.walker_tank.health > 21000)
		{
			wait 0.05;
		}

		playfx(common_scripts\utility::getfx("razorback_death_explosion"),level.walker_tank.origin);
		level.walker_tank notify("death");
		level.walker_tank delete();
		return;
	}

	var_00 = undefined;
	while(isdefined(level.walker_tank))
	{
		var_00 = level.walker_tank.origin;
		wait 0.05;
	}

	playfx(common_scripts\utility::getfx("razorback_death_explosion"),var_00);
}

//Function Number: 303
handle_walker_tank_shooting_himself()
{
	level endon("end_walker_tank_health_process");
	while(isdefined(level.walker_tank))
	{
		level.walker_tank waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(var_01 == level.walker_tank)
		{
			level.walkertank.health = level.walkertank.health + var_00;
		}

		wait 0.05;
	}
}

//Function Number: 304
spawn_allies_for_swarm_turret_segment()
{
	var_00 = getentarray("node_ally_cover_group_swarm_battle","targetname");
	var_01 = getentarray("e3_spawner_trench_allies_group_01","targetname");
	foreach(var_03 in var_00)
	{
		var_04 = spawn_drone_street_ally(var_03,var_01);
		var_04 thread get_shot_by_drone_swarm();
		var_04 thread reinforce_on_death(var_03,var_01,"end_cherry_picker");
	}
}

//Function Number: 305
drone_shoot_at_ent(param_00,param_01)
{
	level endon(param_01);
	param_00 endon("death");
	while(isdefined(self))
	{
		if(!isdefined(param_00))
		{
			return;
		}

		var_02 = (randomintrange(-120,120),randomintrange(-120,120),0);
		drone_bullet(param_00.origin + var_02);
		if(level.nextgen)
		{
			wait(randomfloat(0.1));
			continue;
		}

		wait(randomfloat(0.25));
	}
}

//Function Number: 306
get_shot_by_drone_swarm()
{
	self endon("death");
	for(;;)
	{
		wait(randomfloatrange(10));
		swarm_shoot_random_drone_at_ent(self);
	}
}

//Function Number: 307
swarm_shoot_random_drone_at_ent(param_00)
{
	var_01 = undefined;
	while(!isdefined(var_01))
	{
		var_01 = common_scripts\utility::random(level.flock_drones);
		if(!isdefined(var_01))
		{
			continue;
		}
	}

	var_02 = var_01.origin;
	var_01 delete();
	var_03 = magicbullet("remote_missile_drone_light",var_02,param_00.origin);
	soundscripts\_snd::snd_message("seo_drone_missile_impact",param_00.origin);
}

//Function Number: 308
snake_pick_intro_path()
{
	common_scripts\utility::flag_wait("flag_drone_intro_pick_path");
	var_00 = getent("vol_cardoor_objective_vol_a","targetname");
	var_01 = getent("vol_cardoor_objective_vol_b","targetname");
	var_02 = getent("vol_cardoor_objective_vol_c","targetname");
	var_03 = undefined;
	if(level.player istouching(var_00))
	{
		var_03 = "snake_swarm_first_flyby_path1";
	}
	else if(level.player istouching(var_01))
	{
		var_03 = "snake_swarm_first_flyby_path2";
	}
	else
	{
		var_03 = "snake_swarm_first_flyby_path3";
	}

	level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points(var_03,undefined,3.25);
}

//Function Number: 309
pick_player_location_vol()
{
	var_00 = getent("vol_cardoor_objective_vol_a","targetname");
	var_01 = getent("vol_cardoor_objective_vol_b","targetname");
	var_02 = getent("vol_cardoor_objective_vol_c","targetname");
	if(level.player istouching(var_00))
	{
		return var_00;
	}

	if(level.player istouching(var_01))
	{
		return var_01;
	}

	return var_02;
}

//Function Number: 310
setup_safe_vols_near_cardoors()
{
	level.player endon("player_has_cardoor");
	var_00 = getentarray("vol_safe_drone_strafe_vol","targetname");
	for(;;)
	{
		level.player waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07);
		if(var_05 == "MOD_RIFLE_BULLET" || var_05 == "MOD_PROJECTILE_SPLASH")
		{
			foreach(var_09 in var_00)
			{
				if(level.player istouching(var_09))
				{
					level.player.maxhealth = 100;
					if(level.player.health + int(var_01 * 0.9) < level.player.maxhealth)
					{
						level.player.health = level.player.health + int(var_01 * 0.9);
						continue;
					}

					level.player.health = int(level.player.maxhealth * 0.9);
				}
			}
		}
	}
}

//Function Number: 311
soften_player_damage()
{
}

//Function Number: 312
snake_strafe_player_gets_cardoor()
{
	thread setup_safe_vols_near_cardoors();
	level.player waittill("player_has_cardoor");
	common_scripts\utility::flag_wait("flag_drone_intro_pick_path");
	var_00 = getent("vol_cardoor_objective_vol_a","targetname");
	var_01 = getent("vol_cardoor_objective_vol_b","targetname");
	var_02 = getent("vol_cardoor_objective_vol_c","targetname");
	if(level.player istouching(var_00))
	{
		var_03 = "snake_swarm_cardoor_charge";
	}
	else if(level.player istouching(var_02))
	{
		var_03 = "snake_swarm_cardoor_charge_altpath";
	}
	else
	{
		return;
	}

	common_scripts\utility::flag_set("player_just_grabbed_door");
	level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_goto_points(var_03,undefined,3.25,undefined,1);
	common_scripts\utility::flag_wait("snake_swarm_cardoor_charge_end");
	common_scripts\utility::flag_clear("player_just_grabbed_door");
}

//Function Number: 313
snake_shoot_ambient()
{
	common_scripts\utility::flag_wait("drones_cleared_building");
	thread bullet_rain_drone_swarm();
	var_00 = common_scripts\utility::getstructarray("initial_drone_targets","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread shoot_drone_at_ally(1);
		if(common_scripts\utility::cointoss())
		{
			wait(0.5);
			var_02 thread shoot_drone_at_ally(1);
		}

		if(level.nextgen)
		{
			wait(randomfloat(1));
			continue;
		}

		wait(randomfloatrange(1,2));
	}
}

//Function Number: 314
bullet_rain_drone_swarm()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 thread move_drone_target_along_path();
	for(var_01 = 0;var_01 < 10;var_01++)
	{
		var_02 = common_scripts\utility::random(level.flock_drones);
		if(isdefined(var_02))
		{
			var_02 thread drone_shoot_down(var_00);
			continue;
		}

		var_01 = var_01 - 1;
	}
}

//Function Number: 315
move_drone_target_along_path()
{
	var_00 = common_scripts\utility::getstructarray("struct_drone_swarm_shoot_loc","targetname");
	var_00 = maps\_shg_design_tools::sortbydistanceauto(var_00,level.player.origin);
	var_00 = common_scripts\utility::array_reverse(var_00);
	self.origin = var_00[0].origin;
	foreach(var_02 in var_00)
	{
		var_03 = (var_02.origin[0],level.player.origin[1],var_02.origin[2]);
		self moveto(var_03,1.25);
		wait(1.25);
	}

	wait(1);
	level notify("end_drone_shoot_run");
}

//Function Number: 316
drone_shoot_down(param_00)
{
	level endon("end_drone_shoot_run");
	while(isdefined(self))
	{
		var_01 = (randomintrange(-150,150),randomintrange(-150,150),0);
		drone_bullet(param_00.origin + var_01);
		wait(randomfloat(0.25));
	}
}

//Function Number: 317
snake_crash_into_player_after_timeout(param_00)
{
	level.player thread maps\_utility::notify_delay("drone_crash_into_player_now",20);
	level.player common_scripts\utility::waittill_any("player_has_cardoor","drone_crash_into_player_now");
	snake_crash_into_player(param_00);
}

//Function Number: 318
snake_crash_into_player(param_00)
{
	level endon("end_crash_into_player");
	level endon("end_drone_snake_processes");
	for(;;)
	{
		foreach(var_02 in level.snakes)
		{
			while(isdefined(var_02) && snakeisinfrontofplayer(var_02))
			{
				vehicle_scripts\_attack_drone::force_kamikaze(common_scripts\utility::random(param_00));
				wait(0.5);
			}
		}

		wait 0.05;
	}
}

//Function Number: 319
snakeisinfrontofplayer(param_00)
{
	var_01 = level.player geteye();
	var_02 = anglestoforward(level.player getgunangles());
	var_03 = var_01 + var_02 * 148;
	if(distance(param_00.origin,var_03) < 96)
	{
		return 1;
	}

	return 0;
}

//Function Number: 320
cleanup_snake_cloud_on_flag(param_00)
{
	common_scripts\utility::flag_wait(param_00);
	vehicle_scripts\_attack_drone_common::cleanup_snake_cloud();
}

//Function Number: 321
snake_follow_player(param_00)
{
	level endon("player_in_x4walker");
	var_01 = getent("vol_cardoor_objective_vol_a","targetname");
	var_02 = getent("vol_cardoor_objective_vol_b","targetname");
	var_03 = getent("vol_cardoor_objective_vol_c","targetname");
	var_04 = getent("vol_cardoor_objective_vol_a2","targetname");
	var_05 = getent("vol_cardoor_objective_vol_b2","targetname");
	var_06 = getent("vol_cardoor_objective_vol_c2","targetname");
	common_scripts\utility::flag_wait_any("snake_swarm_first_flyby_end","snake_swarm_cardoor_charge_end");
	for(;;)
	{
		if(common_scripts\utility::flag("player_just_grabbed_door"))
		{
			wait 0.05;
		}

		if(maps\_utility::any_players_istouching(var_01))
		{
			param_00 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("snake_swarm_first_flyby",undefined,2.25);
			while(maps\_utility::any_players_istouching(var_01))
			{
				wait 0.05;
			}
		}

		if(maps\_utility::any_players_istouching(var_02))
		{
			param_00 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("snake_swarm_first_flyby_path2",undefined,2.25);
			while(maps\_utility::any_players_istouching(var_02))
			{
				wait 0.05;
			}
		}

		if(maps\_utility::any_players_istouching(var_03))
		{
			param_00 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("snake_swarm_first_flyby_path3",undefined,2.25);
			while(maps\_utility::any_players_istouching(var_03))
			{
				wait 0.05;
			}
		}

		if(maps\_utility::any_players_istouching(var_04))
		{
			param_00 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("snake_swarm_follow_player_forward_1",undefined,2.25);
			while(maps\_utility::any_players_istouching(var_04))
			{
				wait 0.05;
			}
		}

		if(maps\_utility::any_players_istouching(var_05))
		{
			param_00 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("snake_swarm_follow_player_forward_2",undefined,2.25);
			while(maps\_utility::any_players_istouching(var_05))
			{
				wait 0.05;
			}
		}

		if(maps\_utility::any_players_istouching(var_06))
		{
			param_00 vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("snake_swarm_follow_player_forward_3",undefined,2.25);
			while(maps\_utility::any_players_istouching(var_06))
			{
				wait 0.05;
			}
		}

		wait 0.05;
	}
}

//Function Number: 322
delay_drone_kamikaze_player(param_00)
{
	level.player waittill("player_has_cardoor");
	thread vehicle_scripts\_attack_drone::handle_drones_vs_car_shield(param_00);
	level.player waittill("player_in_x4walker");
	level notify("end_drone_kamikaze_player");
}

//Function Number: 323
button_prompt_on_cardoor()
{
	var_00 = getent("vol_cardoor_objective_vol_a","targetname");
	var_01 = getent("vol_cardoor_objective_vol_b","targetname");
	var_02 = getent("vol_cardoor_objective_vol_c","targetname");
	if(level.player istouching(var_00))
	{
		var_03 = common_scripts\utility::getstruct("struct_door_ripoff_scene_prompt","targetname");
	}
	else if(level.player istouching(var_02))
	{
		var_03 = common_scripts\utility::getstruct("struct_door_ripoff_scene_prompt_altpath","targetname");
	}
	else
	{
		return;
	}

	var_04 = maps\_shg_utility::hint_button_position("x",var_03.origin,32);
	common_scripts\utility::flag_set("player_initiated_door_ripoff");
	var_04 maps\_shg_utility::hint_button_clear();
}

//Function Number: 324
show_throw_hint_close_to_turret()
{
	while(distance(level.player.origin,level.mobile_turret.origin) > 400)
	{
		wait 0.05;
	}

	maps\_utility::display_hint_timeout("hint_door_throw",5);
}

//Function Number: 325
handle_player_cardoor_health()
{
	level endon("end_cherry_picker");
	level waittill("player_owns_cardoor_shield");
	level.player notify("donot_show_throw_hint");
	thread show_throw_hint_close_to_turret();
	level.player enableinvulnerability();
	thread handle_player_cardoor_health_switch_weapon();
	var_00 = level.player common_scripts\utility::waittill_any_return("car_door_thrown","car_door_broken","death");
	level.player disableinvulnerability();
	thread reduce_damage_while_holding_cardoor(0.75);
	if(var_00 == "car_door_broken")
	{
		level.player thread handle_car_door_throw_hint();
	}
}

//Function Number: 326
reduce_damage_while_holding_cardoor(param_00)
{
	level notify("kill_damage_reduction");
	level endon("kill_damage_reduction");
	level endon("end_cherry_picker");
	for(;;)
	{
		level.player waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06);
		var_07 = level.player getcurrentweapon();
		if(issubstr(var_07,"door"))
		{
			level.player.maxhealth = 100;
			if(level.player.health + int(var_01 * param_00) < level.player.maxhealth)
			{
				level.player.health = level.player.health + int(var_01 * param_00);
				continue;
			}

			level.player.health = int(level.player.maxhealth * param_00);
		}
	}
}

//Function Number: 327
handle_car_door_throw_hint()
{
	var_00 = level.player getcurrentweapon();
	if(!issubstr(var_00,"_door_"))
	{
		return;
	}

	thread cardoor_hint_breakout();
	thread maps\_utility::notify_delay("car_door_hint_timeout",3);
	maps\_utility::display_hint("car_door_throw");
	common_scripts\utility::waittill_either("car_door_hint_timeout","car_door_thrown");
	self.has_thrown_door_timeout = 1;
}

//Function Number: 328
cardoor_hint_breakout()
{
	if(!isdefined(level.player.has_thrown_door_timeout))
	{
		return 0;
	}

	if(level.player.has_thrown_door_timeout)
	{
		return 1;
	}
}

//Function Number: 329
handle_player_cardoor_health_switch_weapon()
{
	level.player endon("car_door_thrown");
	level endon("end_cherry_picker");
	for(;;)
	{
		while(maps\_car_door_shield::is_current_weapon_shield(level.player getcurrentweapon()) || level.player getcurrentweapon() == "none")
		{
			wait 0.05;
		}

		level.player disableinvulnerability();
		while(!maps\_car_door_shield::is_current_weapon_shield(level.player getcurrentweapon()))
		{
			wait 0.05;
		}

		level.player enableinvulnerability();
	}
}

//Function Number: 330
anim_scene_will_grabs_car_door()
{
	level.will_irons endon("force_end_will_grabs_door");
	thread handle_player_cardoor_health();
	var_00 = getent("model_door_grab_suv","targetname");
	var_00.animname = "door_grab_suv";
	var_00 maps\_anim::setanimtree();
	var_00 thread maps\_anim::anim_first_frame_solo(var_00,"seo_door_slide_in_suv");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_drone_swarm_flank");
	var_01 = level.will_irons;
	var_01.fixednode = 0;
	level.cormack thread cormack_dodge_drones();
	level.jackson thread jackson_dodge_drones();
	common_scripts\utility::flag_wait("snake_swarm_first_flyby_begin");
	var_02 = common_scripts\utility::getstruct("struct_will_grabs_car_door","targetname");
	var_03 = var_02 maps\_anim::anim_reach_solo(var_01,"will_door_shield_intro",undefined,1);
	if(common_scripts\utility::flag("will_cardoor_watcher_flag"))
	{
		level.will_irons maps\_utility::set_force_color("o");
		return;
	}

	var_00 thread maps\_anim::anim_single_solo(var_00,"seo_door_slide_in_suv");
	var_02 maps\_anim::anim_single_solo(var_01,"will_door_shield_intro");
	level notify("explosion_for_will_grab_scene");
	thread make_react_explosion();
	var_00 thread maps\_anim::anim_single_solo(var_00,"seo_door_grab_suv");
	var_01 thread put_cardoor_on_will();
	thread maps\_utility::flag_set_delayed("dialogue_drone_swarm_intro_pt2",3);
	var_01 maps\_anim::anim_single_solo(var_01,"will_door_shield_grab");
	if(!common_scripts\utility::flag("player_inplace_for_will_door_grab_2") && !common_scripts\utility::flag("player_has_cardoor"))
	{
		var_01 maps\_anim::anim_single_solo(var_01,"will_door_shield_twitch");
	}

	if(!common_scripts\utility::flag("player_inplace_for_will_door_grab_2") && !common_scripts\utility::flag("player_has_cardoor"))
	{
		var_01 thread maps\_anim::anim_loop_solo(var_01,"will_door_shield_hold_idle");
	}

	var_01 maps\_utility::anim_stopanimscripted();
	level notify("ready_drone_kamikaze");
	var_04 = getent("brush_car_door_blocker_01","targetname");
	var_04.origin = var_04.origin + (0,0,10000);
	var_04 connectpaths();
	var_01 maps\_utility::set_run_anim("seo_door_grab_walk_forward",1);
	var_01.ignoreall = 1;
	var_01 thread get_to_cherry_picker();
	level waittill("all_drones_in_swarm_dead");
	anim_scene_will_grabs_car_door_post_cherrypicker();
}

//Function Number: 331
anim_scene_will_grabs_car_door_post_cherrypicker()
{
	level.will_irons.ignoreall = 0;
	if(level.nextgen)
	{
		maps\_utility::delaythread(6,::maps\seoul_lighting::disable_motion_blur);
	}
}

//Function Number: 332
make_react_explosion()
{
	var_00 = common_scripts\utility::getstruct("struct_will_drone_dodge_explosion","script_noteworthy");
	playfx(common_scripts\utility::getfx("drone_explode"),var_00.origin);
	soundscripts\_snd::snd_message("seo_will_car_door_explo",var_00.origin);
}

//Function Number: 333
cormack_dodge_drones()
{
	common_scripts\utility::flag_wait("snake_swarm_first_flyby_begin");
	var_00 = common_scripts\utility::getstruct("struct_cormack_position_3_drone_dodge","targetname");
	var_01 = var_00 maps\_anim::anim_reach_solo(self,"swarm_cover_cormack_into",undefined,1);
	if(var_01)
	{
		var_00 maps\_anim::anim_single_solo(self,"swarm_cover_cormack_into");
		thread maps\_anim::anim_loop_solo(self,"swarm_cover_cormack");
	}
}

//Function Number: 334
jackson_dodge_drones()
{
	common_scripts\utility::flag_wait("snake_swarm_first_flyby_begin");
	var_00 = common_scripts\utility::getstruct("struct_jackson_position_3_drone_dodge","targetname");
	var_01 = var_00 maps\_anim::anim_reach_solo(self,"swarm_cover_jackson_into",undefined,1);
	if(var_01)
	{
		var_00 maps\_anim::anim_single_solo(self,"swarm_cover_jackson_into");
		maps\_anim::anim_loop_solo(self,"swarm_cover_jackson");
	}
}

//Function Number: 335
get_to_cherry_picker()
{
	level.player endon("player_in_x4walker");
	var_00 = common_scripts\utility::getstruct("struct_will_drop_door_goto_vehicle","targetname");
	var_01 = var_00.animation;
	var_00 maps\_anim::anim_reach_solo(self,var_01,undefined,1);
	var_00 maps\_anim::anim_single_solo(self,var_01);
	remove_cardoor_from_npc();
	self setgoalpos(self.origin);
	self.goalradius = 512;
}

//Function Number: 336
remove_cardoor_from_npc(param_00)
{
	if(isdefined(self.door))
	{
		self.door unlink();
	}

	maps\_utility::clear_run_anim();
	self.door_thrown = 1;
	if(isdefined(param_00) && param_00 && isdefined(self.door))
	{
		self.door delete();
	}
}

//Function Number: 337
put_cardoor_on_will()
{
	level.will_irons endon("force_end_will_grabs_door");
	level waittill("will_swap_door");
	var_00 = getent("model_door_grab_suv","targetname");
	var_01 = self gettagorigin("tag_weapon_left");
	self.door = spawn("script_model",var_01);
	self.door.angles = self gettagangles("tag_weapon_left");
	self.door setmodel("npc_atlas_suv_door_fr");
	var_00 hidepart("front_door_right_jnt");
	self.door linkto(self,"tag_weapon_left");
}

//Function Number: 338
setup_cherry_picker_turret()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_hill_event_01");
}

//Function Number: 339
handle_drone_targetting_overlays()
{
	level endon("emp_ready_for_use");
	level endon("stop_hud_overlay_update");
	for(;;)
	{
		var_00 = level common_scripts\utility::waittill_any_return("new_drone_target","drone_target_tracking");
		if(!isdefined(self.cherry_turret_hud["overlay1"]))
		{
			break;
		}

		if(var_00 == "new_drone_target")
		{
			self.cherry_turret_hud["overlay1"] setshader(level.cherry_picker_hud_drone,640,480);
		}
		else
		{
			self.cherry_turret_hud["overlay1"] setshader(level.cherry_picker_hud_drone2,640,480);
		}

		if(isdefined(self.cherry_turret_hud["overlay1"]))
		{
			self.cherry_turret_hud["overlay1"].alpha = 0.85;
		}
		else
		{
			break;
		}

		var_00 = level common_scripts\utility::waittill_any_return("drone_target_dead","drone_target_tracking_off");
		if(isdefined(self.cherry_turret_hud["overlay1"]))
		{
			self.cherry_turret_hud["overlay1"] setshader(level.cherry_picker_hud,640,480);
			continue;
		}

		break;
	}
}

//Function Number: 340
turret_hud_init()
{
	self endon("death");
	var_00 = 50000;
	var_01 = 60;
	self.cherry_turret_hud["overlay1"] = newclienthudelem(self);
	self.cherry_turret_hud["overlay1"] setshader(level.cherry_picker_hud,640,480);
	self.cherry_turret_hud["overlay1"].alignx = "left";
	self.cherry_turret_hud["overlay1"].aligny = "top";
	self.cherry_turret_hud["overlay1"].x = 0;
	self.cherry_turret_hud["overlay1"].y = 0;
	self.cherry_turret_hud["overlay1"].horzalign = "fullscreen";
	self.cherry_turret_hud["overlay1"].vertalign = "fullscreen";
	self.cherry_turret_hud["overlay1"].alpha = 0.5;
	thread handle_drone_targetting_overlays();
	thread handle_display_of_drones_number();
	thread handle_remove_overlay();
	level waittill("emp_ready_for_use");
	common_scripts\utility::flag_set("dialogue_drone_turret_sequence_emp_2");
	wait 0.05;
	self.cherry_turret_hud["overlay1"] setshader(level.cherry_picker_hud_emp,640,480);
	self.cherry_turret_hud["drone_nums"].label = "EMP ready";
	self.cherry_turret_hud["drone_nums"].fontscale = 1.65;
}

//Function Number: 341
handle_display_of_drones_number()
{
	level endon("emp_ready_for_use");
	var_00[0] = maps\_shg_design_tools::convert_8bit_color(11);
	var_00[1] = maps\_shg_design_tools::convert_8bit_color(96);
	var_00[2] = maps\_shg_design_tools::convert_8bit_color(236);
	var_01[0] = maps\_shg_design_tools::convert_8bit_color(226);
	var_01[1] = maps\_shg_design_tools::convert_8bit_color(208);
	var_01[2] = maps\_shg_design_tools::convert_8bit_color(146);
	var_02[0] = maps\_shg_design_tools::convert_8bit_color(233);
	var_02[1] = maps\_shg_design_tools::convert_8bit_color(21);
	var_02[2] = maps\_shg_design_tools::convert_8bit_color(21);
	var_03 = (var_01[0],var_01[1],var_01[2]);
	var_04 = (var_02[0],var_02[1],var_02[2]);
	self.cherry_turret_hud["drone_nums"] = maps\_shg_design_tools::create_pulsing_text(-2,0,level.flock_drones.size,self,var_04,var_03,0);
	while(isdefined(self.cherry_turret_hud["drone_nums"]))
	{
		self.cherry_turret_hud["drone_nums"].label = level.flock_drones.size;
		self.cherry_turret_hud["drone_nums"].fontscale = 2;
		wait 0.05;
	}
}

//Function Number: 342
handle_remove_overlay()
{
	level.player common_scripts\utility::waittill_any("cherrypicker_exit","missionfailed","death");
	if(isdefined(self.cherry_turret_hud["overlay1"]))
	{
		self.cherry_turret_hud["overlay1"] destroy();
	}
}

//Function Number: 343
handle_turret_hud_target_text()
{
	level endon("end_cherry_picker");
	var_00[0] = maps\_shg_design_tools::convert_8bit_color(11);
	var_00[1] = maps\_shg_design_tools::convert_8bit_color(96);
	var_00[2] = maps\_shg_design_tools::convert_8bit_color(236);
	var_01[0] = maps\_shg_design_tools::convert_8bit_color(226);
	var_01[1] = maps\_shg_design_tools::convert_8bit_color(208);
	var_01[2] = maps\_shg_design_tools::convert_8bit_color(146);
	var_02[0] = maps\_shg_design_tools::convert_8bit_color(233);
	var_02[1] = maps\_shg_design_tools::convert_8bit_color(21);
	var_02[2] = maps\_shg_design_tools::convert_8bit_color(21);
	var_03 = (var_01[0],var_01[1],var_01[2]);
	var_04 = (var_02[0],var_02[1],var_02[2]);
	var_05 = "Aquiring Nexus Drones";
	var_06 = "Attack Drones Aquired";
	for(;;)
	{
		level waittill("snake_charge_ended",var_07);
		wait(5);
		if(isdefined(self.cherry_turret_hud["target_text"]))
		{
			self.cherry_turret_hud["target_text"] destroy();
		}

		wait 0.05;
		self.cherry_turret_hud["target_text"] = maps\_shg_design_tools::create_pulsing_text(0,0,var_05,self,var_03,var_03,0);
		level waittill("snake_charge_initiated");
		self.cherry_turret_hud["target_text"] destroy();
		wait 0.05;
		self.cherry_turret_hud["target_text"] = maps\_shg_design_tools::create_pulsing_text(0,0,var_06,self,var_04,var_03,0);
		self.cherry_turret_hud["target_text"].fontscale = 1.65;
		self.cherry_turret_hud["target_text"].alpha = 0.75;
	}
}

//Function Number: 344
aquiring_targets_think()
{
	level endon("snake_charge_initiated");
	level endon("end_cherry_picker");
	for(;;)
	{
		var_00 = randomint(8);
		for(var_01 = 0;var_01 < var_00;var_01++)
		{
			var_02 = common_scripts\utility::random(level.flock_drones);
			if(isdefined(var_02) && !target_istarget(var_02))
			{
				target_set(var_02);
				target_setshader(var_02,"drone_turret_hud_locking");
				var_02 thread remove_target_on_timeout(randomfloat(0.5));
				level notify("drone_target_tracking");
				wait(0.15);
			}
		}

		wait(randomfloat(0.5));
	}
}

//Function Number: 345
remove_target_on_timeout(param_00)
{
	self endon("death");
	wait(param_00);
	if(isdefined(self) && target_istarget(self))
	{
		target_remove(self);
	}

	level notify("drone_target_tracking_off");
}

//Function Number: 346
cycle_charging_hud(param_00)
{
	while(!common_scripts\utility::flag("dialogue_drone_turret_sequence_emp_2"))
	{
		foreach(var_02 in param_00)
		{
			if(common_scripts\utility::flag("dialogue_drone_turret_sequence_emp_2"))
			{
				break;
			}

			if(isdefined(var_02))
			{
				var_02.alpha = 0.55;
			}
			else
			{
				return;
			}

			wait(0.01);
			if(isdefined(var_02))
			{
				var_02 fadeovertime(0.75);
				var_02.alpha = 0;
			}
		}
	}

	foreach(var_02 in param_00)
	{
		if(isdefined(var_02))
		{
			var_02.alpha = 0;
		}
	}
}

//Function Number: 347
monitor_drone_hit_or_timeout()
{
	level notify("kill_monitor_drone_hit_process");
	level endon("kill_monitor_drone_hit_process");
	var_00 = level.flock_drones.size;
	for(;;)
	{
		level thread notify_delay_endon("emp_countdown_timeout",1,"drone_swarm_hit");
		level common_scripts\utility::waittill_either("drone_swarm_hit","emp_countdown_timeout");
		level notify("ok_to_decrement_emp_bar",var_00 - level.flock_drones.size);
		var_00 = level.flock_drones.size;
	}
}

//Function Number: 348
notify_delay_endon(param_00,param_01,param_02)
{
	self endon(param_02);
	wait(param_01);
	self notify(param_00);
}

//Function Number: 349
handle_emp_countdown(param_00)
{
	thread monitor_drone_hit_or_timeout();
	self endon("death");
	var_01 = param_00.size;
	var_02 = param_00[0];
	var_03 = param_00[1];
	thread cycle_charging_hud(var_03);
	var_04[0] = maps\_shg_design_tools::convert_8bit_color(7);
	var_04[1] = maps\_shg_design_tools::convert_8bit_color(7);
	var_04[2] = maps\_shg_design_tools::convert_8bit_color(245);
	var_05[0] = maps\_shg_design_tools::convert_8bit_color(226);
	var_05[1] = maps\_shg_design_tools::convert_8bit_color(208);
	var_05[2] = maps\_shg_design_tools::convert_8bit_color(146);
	var_06[0] = maps\_shg_design_tools::convert_8bit_color(233);
	var_06[1] = maps\_shg_design_tools::convert_8bit_color(21);
	var_06[2] = maps\_shg_design_tools::convert_8bit_color(21);
	var_07 = int(level.flock_drones.size - level.min_drone_swarm_size / var_02.size / 2);
	if(var_07 <= 0)
	{
		var_07 = 1;
	}

	var_08 = 0;
	foreach(var_0D, var_0A in var_02)
	{
		if(!isdefined(var_0A))
		{
			continue;
		}

		for(var_0B = 0;var_0B < var_07;var_0B++)
		{
			level waittill("ok_to_decrement_emp_bar",var_08);
		}

		var_0A.color = (var_06[0],var_06[1],var_06[2]);
		var_0A.alpha = 0.75;
		var_0C = var_02[var_0D - 1];
		if(isdefined(var_0C))
		{
			var_0C.color = (var_05[0],var_05[1],var_05[2]);
		}

		if(!common_scripts\utility::flag("dialogue_drone_turret_sequence_emp_1") && var_0D > var_02.size / 2)
		{
			common_scripts\utility::flag_set("dialogue_drone_turret_sequence_emp_1");
		}
	}

	level notify("emp_ready_for_use");
	foreach(var_0A in var_02)
	{
		wait(0.01);
		if(!isdefined(var_0A))
		{
			continue;
		}

		var_0A.color = (var_04[0],var_04[1],var_04[2]);
		var_0A.alpha = 0.55;
	}

	common_scripts\utility::flag_set("dialogue_drone_turret_sequence_emp_2");
}

//Function Number: 350
charge_blink(param_00,param_01)
{
	param_00.alpha = 0;
}

//Function Number: 351
createempclientbar(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08[0] = maps\_shg_design_tools::convert_8bit_color(226);
	var_08[1] = maps\_shg_design_tools::convert_8bit_color(208);
	var_08[2] = maps\_shg_design_tools::convert_8bit_color(146);
	var_09[0] = maps\_shg_design_tools::convert_8bit_color(233);
	var_09[1] = maps\_shg_design_tools::convert_8bit_color(21);
	var_09[2] = maps\_shg_design_tools::convert_8bit_color(21);
	var_0A = [];
	var_0B = [];
	var_0C = param_01 * param_07;
	var_0A[0] = newclienthudelem(self);
	var_0A[0].x = var_0C - 17;
	var_0A[0].y = param_02 + param_06;
	var_0A[0].sort = 10;
	var_0A[0].horzalign = "center";
	var_0A[0].vertalign = "top";
	var_0A[0].alpha = 0.55;
	var_0A[0] settext("EMP");
	var_0A[0].fontscale = 1.5;
	for(var_0D = 0;var_0D < param_00;var_0D++)
	{
		var_0E = newclienthudelem(self);
		var_0E.x = var_0C;
		var_0E.y = param_02 - param_05 + param_06 * var_0D;
		var_0E.sort = 10;
		var_0E.horzalign = "center";
		var_0E.vertalign = "top";
		var_0E.alpha = 0.25;
		var_0E setshader(param_03,param_04,param_05);
		var_0A[var_0A.size] = var_0E;
		var_0F = newclienthudelem(self);
		var_0F.x = var_0C + param_04 * param_07 + 3 * param_07;
		var_0F.y = param_02 - param_05 + param_06 * var_0D;
		var_0F.sort = 10;
		var_0F.horzalign = "center";
		var_0F.vertalign = "top";
		var_0F.alpha = 0;
		var_0F.color = (var_08[0],var_08[1],var_08[2]);
		var_0F setshader(param_03,4,2);
		var_0B[var_0B.size] = var_0F;
	}

	var_10 = [var_0A,var_0B];
	thread clear_hud_on_notify(var_0A,"end_cherry_picker");
	thread clear_hud_on_notify(var_0B,"end_cherry_picker");
	return var_10;
}

//Function Number: 352
clear_hud_on_notify(param_00,param_01)
{
	level waittill(param_01);
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03))
		{
			var_03 destroy();
		}
	}
}

//Function Number: 353
check_seoul_achievements()
{
	level waittill("end_cherry_picker");
	if(isalive(level.walker_tank))
	{
		maps\_utility::giveachievement_wrapper("LEVEL_1A");
	}
}

//Function Number: 354
turret_hud_clear()
{
	level waittill("end_cherry_picker");
	foreach(var_01 in self.cherry_turret_hud)
	{
		if(!isarray(var_01))
		{
			var_01 destroy();
			continue;
		}

		foreach(var_03 in var_01)
		{
			if(!isarray(var_03))
			{
				var_03 destroy();
				continue;
			}

			foreach(var_05 in var_03)
			{
				if(!isarray(var_05))
				{
					if(isdefined(var_05))
					{
						var_05 destroy();
					}
				}
			}
		}
	}
}

//Function Number: 355
monitor_num_drones_in_swarm()
{
	level endon("end_cherry_picker");
	for(;;)
	{
		if(level.flock_drones.size > level.min_drone_swarm_size)
		{
			level notify("drone_swarm_weak_ready_emp");
		}

		level.flock_drones = common_scripts\utility::array_removeundefined(level.flock_drones);
		wait 0.05;
	}
}

//Function Number: 356
cherry_picker_turret_gameplay()
{
	if(level.e3_presentation)
	{
		return;
	}

	level.player thread turret_hud_init();
	level.player thread turret_hud_clear();
	level.player thread turret_player_init();
	level.player thread turret_emp_ready();
	level.player thread monitor_num_drones_in_swarm();
	level.player thread walker_drone_fight();
	level.player thread reset_player_stats_on_exit();
	level.player thread monitor_cherry_picker_stick_movement();
	level.player thread monitor_cherry_picker_height();
	level.player thread monitor_cherry_picker_cancel(self);
	level.mobile_turret thread drone_vs_turret_monitor_damage();
}

//Function Number: 357
reset_player_stats_on_exit()
{
	level waittill("end_cherry_picker");
	level.player.health = 100;
	level.player.maxhealth = 100;
}

//Function Number: 358
walker_drone_fight()
{
}

//Function Number: 359
monitor_drone_number()
{
	while(level.flock_drones.size > 0)
	{
		wait 0.05;
	}

	common_scripts\utility::flag_set("all_drones_dead");
	level.player notify("all_drones_dead");
}

//Function Number: 360
play_emp_nag_lines()
{
	level endon("EMP_triggered");
}

//Function Number: 361
turret_emp_ready()
{
	var_00 = 320;
	var_01 = 340;
	var_02 = 10;
	var_03 = 2;
	var_04 = 1;
	thread play_emp_reboot_bik();
	thread monitor_drone_number();
	level waittill("emp_ready_for_use");
	common_scripts\utility::flag_wait("dialogue_drone_turret_sequence_emp_2");
	thread play_emp_audio();
	thread play_emp_nag_lines();
	level.player waittill_player_hits_a();
	self notify("cherrypicker_exit");
	level notify("EMP_triggered");
	level notify("stop_kamikaze_player");
	common_scripts\utility::flag_set("dialogue_drone_turret_sequence_emp_3");
	thread emp_wave();
	soundscripts\_snd::snd_message("seo_swarm_emp_wave");
	level waittill("emp_complete");
	common_scripts\utility::flag_set("seoul_player_can_exit_x4walker");
	common_scripts\utility::flag_set("drone_swarm_complete");
	level.player thread maps\_utility::notify_delay("dismount_vehicle_and_turret",3);
	level.mobile_turret thread maps\_utility::notify_delay("dismount_vehicle_and_turret",3);
	common_scripts\utility::flag_waitopen("player_in_x4walker");
	level.mobile_turret notify("disable_mobile_turret");
	level.mobile_turret thread vehicle_scripts\_x4walker_wheels_turret::make_mobile_turret_unusable();
	level.mobile_turret thread vehicle_scripts\_x4walker_wheels_turret::clean_up_vehicle_seoul();
	level.mt_use_tags = common_scripts\utility::array_removeundefined(level.mt_use_tags);
	common_scripts\utility::array_call(level.mt_use_tags,::delete);
}

//Function Number: 362
play_emp_reboot_bik()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	level waittill("drone_swarm_hit");
	for(var_04 = 0;var_04 < 3;var_04++)
	{
		maps\_shg_utility::play_videolog("seoul_turret_loading_loop","screen_add",var_00,var_01,var_02,var_03,0);
	}

	thread maps\_utility::flag_set_delayed("dialogue_drone_turret_sequence_emp_1",8);
	maps\_shg_utility::play_videolog("seoul_turret_reboot","screen_add",var_00,var_01,var_02,var_03,0);
	thread maps\_shg_utility::play_videolog("seoul_turret_emp_ready","screen_add",var_00,var_01,var_02,var_03,0);
	level notify("emp_ready_for_use");
	level waittill("EMP_triggered");
	maps\_shg_utility::stop_videolog();
}

//Function Number: 363
waittill_player_hits_a()
{
	self endon("all_drones_dead");
	thread maps\_utility::display_hint("press_a_for_emp",undefined,undefined,undefined,30);
	common_scripts\utility::waittill_any("a_pressed","all_drones_dead");
	self.has_used_emp = 1;
}

//Function Number: 364
emp_prompt_breakout()
{
	if(level.missionfailed)
	{
		return 1;
	}

	if(common_scripts\utility::flag("all_drones_dead"))
	{
		return 1;
	}

	if(!isdefined(level.player.has_used_emp))
	{
		return 0;
	}

	if(level.player.has_used_emp)
	{
		return 1;
	}
}

//Function Number: 365
play_emp_audio()
{
}

//Function Number: 366
emp_wave()
{
	playfx(common_scripts\utility::getfx("seo_mobile_turret_emp"),level.mobile_turret.origin);
	soundscripts\_snd::snd_message("emp_grenade_detonate");
	thread destroy_drones_in_wave();
	thread handle_emp_kamikaze_drones();
	thread monitor_drones_hit_ground();
	foreach(var_01 in level.snake_cloud.snakes)
	{
		var_01 thread emp_snake();
	}

	level notify("all_drones_in_swarm_dead");
	level notify("end_cherry_picker");
}

//Function Number: 367
handle_emp_kamikaze_drones()
{
	while(common_scripts\utility::flag("player_in_x4walker"))
	{
		if(!isdefined(level.spawned_kamikaze_drones) || level.spawned_kamikaze_drones.size <= 0)
		{
			return;
		}

		foreach(var_01 in level.spawned_kamikaze_drones)
		{
			if(isdefined(var_01))
			{
				var_01 vehicle_setspeedimmediate(0,5,5);
				var_01 vehicle_scripts\_attack_drone_common::totally_fake_drone_death(0,1,0,1);
			}
		}

		wait(0.25);
	}
}

//Function Number: 368
kill_kamikaze_drones()
{
	if(!isdefined(level.spawned_kamikaze_drones))
	{
		return;
	}

	foreach(var_01 in level.spawned_kamikaze_drones)
	{
		if(isdefined(var_01))
		{
			var_01 vehicle_scripts\_attack_drone_common::totally_fake_drone_death(0,1,0,1);
		}
	}
}

//Function Number: 369
emp_snake()
{
	level notify("stop_kamikaze_player");
	var_00 = 1760;
	wait(distance(self.flock.queen.origin,level.player.origin) / var_00);
	level.snake_cloud vehicle_scripts\_attack_drone_common::snake_cloud_stop_dynamic_control();
	vehicle_scripts\_attack_drone_common::snake_set_boid_settings(level.boid_settings_presets["frozen_snake"]);
	wait(1.5);
	vehicle_scripts\_attack_drone_common::snake_set_boid_settings(level.boid_settings_presets["emp_snake"]);
	soundscripts\_snd::snd_message("seo_swarm_die",self.origin);
	level notify("emp_complete");
	wait(5);
	vehicle_scripts\_attack_drone_common::cleanup_snake();
}

//Function Number: 370
monitor_drones_hit_ground()
{
	var_00 = level.mobile_turret.origin[2];
	foreach(var_02 in level.flock_drones)
	{
		var_02 thread explode_on_ground_impact(var_00);
	}
}

//Function Number: 371
explode_on_ground_impact(param_00)
{
	while(isdefined(self))
	{
		if(self.origin[2] < param_00)
		{
			vehicle_scripts\_attack_drone_common::totally_fake_drone_death(0,1,0);
			break;
		}

		wait 0.05;
	}
}

//Function Number: 372
destroy_drones_in_wave(param_00,param_01,param_02,param_03)
{
	level.drone_turret_fake_death_awesome = 1;
	var_04 = [];
	for(var_05 = 0;var_05 < 75;var_05++)
	{
		var_04[var_04.size] = common_scripts\utility::random(level.flock_drones);
		if(maps\_shg_design_tools::percentchance(10))
		{
			wait 0.05;
		}
	}

	param_03 = 1760;
	param_02 = level.player.origin;
	var_04 = maps\_shg_design_tools::sortbydistanceauto(var_04,param_02);
	var_06 = param_02;
	foreach(var_08 in var_04)
	{
		if(!isdefined(var_08))
		{
			continue;
		}

		if(var_08 maps\_vehicle::isvehicle())
		{
			continue;
		}

		var_09 = distance(var_06,var_08.origin);
		var_0A = var_09 / param_03 * 0.05;
		wait(var_0A);
		if(!isdefined(var_08))
		{
			continue;
		}

		var_06 = var_08.origin;
		var_0B = vectornormalize(var_08.origin - param_02);
		var_0B = vectornormalize(var_0B + (0,0,0.2));
		if(maps\_shg_design_tools::percentchance(50))
		{
			var_08 vehicle_scripts\_attack_drone_common::totally_fake_drone_death(0,1,0);
			continue;
		}

		playfx(common_scripts\utility::getfx("drone_death_cheap"),var_08.origin);
	}
}

//Function Number: 373
turret_player_init()
{
}

//Function Number: 374
drone_vs_turret_monitor_damage()
{
	var_00 = self;
	foreach(var_02 in level.flock_drones)
	{
		var_02 thread vehicle_scripts\_attack_drone_common::monitor_drone_cloud_health(1);
		wait(0.05);
	}
}

//Function Number: 375
monitor_cherry_picker_cancel(param_00)
{
	level waittill("end_cherry_picker");
}

//Function Number: 376
monitor_cherry_picker_height()
{
	self endon("cherry_picker_deactivate");
	var_00 = 0;
	for(;;)
	{
		if(level.player fragbuttonpressed())
		{
			var_00 = 1;
		}
		else if(level.player secondaryoffhandbuttonpressed())
		{
			var_00 = -1;
		}
		else
		{
			var_00 = 0;
		}

		level.player.cherry_picker["z_change"] = (0,0,var_00);
		wait(0.05);
	}
}

//Function Number: 377
monitor_cherry_picker_stick_movement()
{
	self endon("cherry_picker_deactivate");
	for(;;)
	{
		var_00 = self getnormalizedmovement();
		var_00 = (var_00[0],var_00[1] * -1,0);
		var_01 = self.angles;
		var_02 = vectortoangles(var_00);
		var_03 = common_scripts\utility::flat_angle(combineangles(var_01,var_02));
		var_04 = anglestoforward(var_03) * length(var_00);
		self.cherry_picker["stick_input_move"] = var_04;
		wait(0.05);
	}
}

//Function Number: 378
spawn_ally_ground_vehicles()
{
	maps\_shg_design_tools::waittill_trigger_with_name("start_pod_landings");
}

//Function Number: 379
setup_npc_pod_landings()
{
	maps\_shg_design_tools::waittill_trigger_with_name("start_pod_landings");
	var_00 = getentarray("model_droppod_exterior_group1","targetname");
	common_scripts\utility::array_thread(var_00,::land_pod_cleanly);
	thread spawn_crashing_pods();
	maps\_shg_design_tools::waittill_trigger_with_name("start_pod_landings_group_2");
	var_00 = getentarray("model_droppod_exterior_group2","targetname");
	common_scripts\utility::array_thread(var_00,::land_pod_cleanly);
}

//Function Number: 380
spawn_crashing_pods()
{
	wait(4);
	var_00 = getentarray("model_droppod_exterior_bad_group","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread land_pod_badly();
		wait(1.4);
	}
}

//Function Number: 381
land_pod_badly()
{
	if(!isdefined(self.target))
	{
		thread land_pod_cleanly();
	}

	var_00 = common_scripts\utility::getstruct(self.target,"targetname");
	var_01 = common_scripts\utility::getstruct(var_00.target,"targetname");
	var_02 = randomintrange(1000,1500);
	maps\_shg_design_tools::lerp_to_position(var_00.origin,var_02);
	var_03 = randomfloatrange(2,4.5);
	thread maps\_shg_design_tools::gravity_arc(self.origin,var_01.origin,var_03,800,800);
	thread crashed_pod_rotation();
	self waittill("item_landed");
	kill_local_units(700);
	wait(0.05);
	self delete();
}

//Function Number: 382
kill_local_units(param_00)
{
	var_01 = getaiarray();
	var_02 = maps\_utility::getvehiclearray();
	thread maps\_shg_design_tools::impulse_wave(var_01,param_00,self.origin - (0,0,100));
	foreach(var_04 in var_02)
	{
		if(distance(self.origin,var_04.origin) < param_00)
		{
			var_04 dodamage(self.health * 5,self.origin);
			var_04 notify("im_killed");
		}
	}

	if(distance(self.origin,level.player.origin) < param_00)
	{
		level.player dodamage(self.health / 2,self.origin);
	}
}

//Function Number: 383
crashed_pod_rotation()
{
	self endon("item_landed");
	var_00 = common_scripts\utility::getstruct(self.target,"targetname");
	var_01 = common_scripts\utility::getstruct(var_00.target,"targetname");
	self.angles = var_00.angles;
	var_02 = (0,3,0);
	for(;;)
	{
		self addpitch(-5);
		wait(0.05);
	}
}

//Function Number: 384
land_pod_cleanly(param_00)
{
	self endon("death");
	thread pod_fx_create();
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	self.old_position = self.origin;
	self.old_angles = self.angles;
	self.origin = self.origin + (0,1000,5000);
	var_01 = randomintrange(1000,1500);
	var_02 = (0,0,0);
	var_03 = 6;
	if(!param_00)
	{
		wait(randomfloat(5));
	}

	self notify("begin_entry_trajectory");
	maps\_shg_design_tools::lerp_to_position(self.old_position + (0,0,randomfloatrange(400,600)),var_01);
	self notify("begin_landing");
	var_04 = randomint(1000);
	for(;;)
	{
		var_05 = (perlinnoise2d(gettime() * 0.001 * 0.05,var_04,5,2,3) / 2,perlinnoise2d(gettime() * 0.001 * 0.05,var_04,5,2,3) / 2,perlinnoise2d(gettime() * 0.001 * 0.05,var_04,5,2,3) / 2);
		var_06 = (perlinnoise2d(gettime() * 0.001 * 0.05,var_04,2,2,2),perlinnoise2d(gettime() * 0.001 * 0.05,var_04,2,2,2),perlinnoise2d(gettime() * 0.001 * 0.05,var_04,2,2,2));
		if(self.origin[2] > self.old_position[2] + 50)
		{
			self.origin = self.origin + var_05;
			self.origin = self.origin - (0,0,int(self.origin[2] - self.old_position[2] / 20));
			var_07 = 0;
			if(self.angles[0] + var_05[0] < self.old_angles[0] + var_03 && self.angles[0] + var_05[0] > self.old_angles[0] - var_03)
			{
				var_07 = var_06[0];
			}

			var_08 = 0;
			if(self.angles[1] + var_05[1] < self.old_angles[1] + var_03 && self.angles[1] + var_05[0] > self.old_angles[1] - var_03)
			{
				var_08 = var_06[1];
			}

			var_09 = 0;
			if(self.angles[2] + var_05[2] < self.old_angles[2] + var_03 && self.angles[2] + var_05[2] > self.old_angles[2] - var_03)
			{
				var_09 = var_06[2];
			}

			self.angles = self.angles + (var_07,var_08,var_09);
		}
		else if(self.origin[2] > self.old_position[2])
		{
			self.angles = self.old_angles;
			self.origin = self.origin - (0,0,1);
		}
		else
		{
			self notify("pod_landed");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 385
pod_fx_create()
{
	self endon("pod_landed");
	self endon("death");
	self waittill("begin_landing");
	thread maps\_shg_design_tools::set_entflag_on_notify("pod_landed");
}

//Function Number: 386
make_seat_cormack(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02 setmodel("mil_drop_pod_seat_cpt");
	var_02.animname = param_01;
	var_02 maps\_anim::setanimtree();
	return var_02;
}

//Function Number: 387
make_seat_npc(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02 setmodel("mil_drop_pod_seat");
	var_02.animname = param_01;
	var_02 maps\_anim::setanimtree();
	return var_02;
}

//Function Number: 388
make_seat_rack(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02 setmodel("mil_drop_pod_seat_rack");
	var_02.animname = param_01;
	var_02 maps\_anim::setanimtree();
	return var_02;
}

//Function Number: 389
make_droppods(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02 setmodel("vehicle_mil_drop_pod");
	var_02.animname = param_01;
	var_02 maps\_anim::setanimtree();
	return var_02;
}

//Function Number: 390
make_drop_missile(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02 setmodel("projectile_javelin_missile");
	var_02.animname = param_01;
	var_02 maps\_anim::setanimtree();
	return var_02;
}

//Function Number: 391
handle_pod_swap(param_00)
{
	level waittill("pod_swap_pod");
	param_00 setmodel("vehicle_mil_drop_pod");
}

//Function Number: 392
handle_player_fov_indroppod()
{
	for(;;)
	{
		level waittill("droppod_fov_change_start");
		maps\_utility::lerp_fov_overtime(1,90);
		level waittill("droppod_fov_change_end");
		maps\_utility::lerp_fov_overtime(1,65);
	}
}

//Function Number: 393
handle_pod_door_deform(param_00)
{
	param_00 hidepart("emergencyShield_dam_F");
	level waittill("pod_deform");
	param_00 hidepart("emergencyShield_F");
	param_00 showpart("emergencyShield_dam_F");
}

//Function Number: 394
handle_hide_droppod_building()
{
	var_00 = getentarray("start_building_ext_hide","targetname");
	level waittill("building_2_crash");
	maps\_utility::array_delete(var_00);
}

//Function Number: 395
play_soul_intro_movie()
{
	setsaveddvar("cg_cinematicfullscreen","1");
	level.player disableweapons();
	level.player freezecontrols(1);
	thread maps\_shg_utility::play_chyron_video("chyron_text_seoul",1,2);
	common_scripts\utility::flag_wait("chyron_video_done");
	level notify("intro_movie_done");
}

//Function Number: 396
show_city_vista(param_00,param_01)
{
	wait(14);
	param_00.origin = param_00.oldorigin;
	param_01.origin = param_01.oldorigin;
}

//Function Number: 397
handle_button_prompts_on_pod(param_00,param_01)
{
	level.player waittill("start_droppod_qte");
	thread maps\_shg_utility::hint_button_create_flashing("emergencyhandle","x","end_process_buttonmash",(5,5,5));
}

//Function Number: 398
pod_rumble()
{
	level endon("end_rumble_listener");
	while(!common_scripts\utility::flag("end_rumble_listener"))
	{
		var_00 = level common_scripts\utility::waittill_any_return("droppod_rumble","droppod_rumble_start","droppod_rumble_end","heavy_rumble","manual_heavy_rumble_start","manual_heavy_rumble_end");
		if(var_00 == "droppod_rumble")
		{
			level.player playrumbleonentity("damage_light");
			continue;
		}

		if(var_00 == "droppod_rumble_start")
		{
			thread do_continuous_rumble("droppod_rumble_end","damage_light");
			continue;
		}

		if(var_00 == "heavy_rumble")
		{
			level.player playrumbleonentity("damage_heavy");
			continue;
		}

		if(var_00 == "manual_heavy_rumble_start")
		{
			thread do_continuous_rumble("manual_heavy_rumble_end","damage_heavy");
		}
	}
}

//Function Number: 399
do_continuous_rumble(param_00,param_01)
{
	level endon(param_00);
	level endon("end_rumble_listener");
	while(!common_scripts\utility::flag("end_rumble_listener"))
	{
		level.player playrumbleonentity(param_01);
		wait(0.1);
	}
}

//Function Number: 400
setup_player_pod_exit()
{
	if(common_scripts\utility::flag("ok_to_land_assist"))
	{
		common_scripts\utility::flag_clear("ok_to_land_assist");
	}

	maps\_player_exo::player_exo_deactivate();
	thread play_soul_intro_movie();
	level waittill("intro_movie_done");
	thread maps\seoul_drop_pod_credits::credits_start();
	common_scripts\utility::flag_set("set_pre_seoul_intro_lighting");
	maps\_utility::vision_set_fog_changes("seoul_pre_space_entry_nofog",0);
	level.player lightsetforplayer("seoul_intro");
	level.player setclutforplayer("clut_seoul_pod",0);
	thread maps\seoul_lighting::intro_spotlight_setup();
	thread maps\seoul_lighting::dof_intro();
	thread maps\seoul_lighting::dof_intro_pre();
	thread pod_rumble();
	common_scripts\utility::flag_set("vfx_seoul_intro_start");
	setsaveddvar("g_friendlynamedist",0);
	thread handle_hide_droppod_building();
	thread maps\seoul_code_drop_pod::handle_portal_scripting_vista("portal_group_vista_on");
	maps\_utility::player_speed_percent(75);
	var_00 = getent("pod_reflection","targetname");
	var_01 = getent("brush_seoul_city_view","targetname");
	var_02 = getent("brush_seoul_city_view_ems","targetname");
	if(level.currentgen)
	{
		var_02 hide();
	}

	var_01.oldorigin = var_01.origin;
	var_02.oldorigin = var_02.origin;
	if(level.nextgen)
	{
		var_01.origin = var_01.origin + (900000,0,0);
		var_02.origin = var_02.origin + (900000,0,0);
	}

	common_scripts\utility::flag_set("dialogue_droppod_prelaunch");
	var_03 = common_scripts\utility::getstructarray("struct_pod_exit","targetname");
	var_04 = common_scripts\utility::getstruct("struct_anim_node_space_skybox","targetname");
	var_05 = var_03[0] common_scripts\utility::spawn_tag_origin();
	var_06 = var_04 common_scripts\utility::spawn_tag_origin();
	var_07 = spawn("script_model",var_05.origin);
	var_07 setmodel("vehicle_mil_drop_pod_intro");
	level.pod_screen = spawn("script_model",var_07 gettagorigin("body_T"));
	level.pod_screen setmodel("vehicle_mil_drop_pod_screens");
	level.pod_screen.targetname = "drop_pod_glass_idle";
	level.pod_screen linkto(var_07,"body_T",(0,0,0),(0,0,0));
	level.pod_screen.tag_screen_off = "TAG_SCREEN_JOINT_OFF";
	level.pod_screen.tag_screen_on = "TAG_SCREEN_JOINT_ON";
	level.pod_screen.tag_screen_load = "TAG_SCREEN_JOINT_LOAD";
	level.pod_screen.video_idle = 1;
	level.pod_screen.video_chrome_ab = 1;
	level.pod_screen.video_cab_count = 0;
	level.pod_screen.video_warn_count = 0;
	level.pod_screen.fov_screen_count = 0;
	level.pod_screen.fov_face_count = 0;
	level.entrance_room = getent("drop_pod_entrance_room","targetname");
	level.entrance_room linkto(var_07,"body_T",(0,0,-50),(0,115,0));
	var_07.animname = "droppod";
	var_07 maps\_anim::setanimtree();
	thread maps\seoul_code_drop_pod::handle_drop_pod_screen_start();
	thread maps\seoul_code_drop_pod::handle_pod_screen_show(var_07);
	thread maps\seoul_code_drop_pod::handle_pod_screen_off(var_07);
	thread maps\seoul_code_drop_pod::handle_pod_screen_bootup(var_07);
	thread maps\seoul_code_drop_pod::handle_pod_crash_building1();
	thread handle_pod_swap(var_07);
	thread handle_player_fov_indroppod();
	thread handle_pod_door_deform(var_07);
	var_08[0] = make_seat_cormack(var_05,"pod_seat_c");
	var_08[1] = make_seat_npc(var_05,"pod_seat_w");
	var_08[2] = make_seat_npc(var_05,"pod_seat_j");
	var_08[3] = make_seat_npc(var_05,"pod_seat_p");
	var_08[4] = make_seat_rack(var_05,"pod_seat_1");
	var_08[5] = make_seat_rack(var_05,"pod_seat_2");
	var_08[6] = make_seat_rack(var_05,"pod_seat_3");
	var_08[0] thread handle_button_prompts_on_pod();
	var_09[0] = make_drop_missile(var_05,"pod_missile_1");
	var_09[1] = make_drop_missile(var_05,"pod_missile_2");
	var_09[2] = make_drop_missile(var_05,"pod_missile_3");
	var_09[3] = make_drop_missile(var_05,"pod_missile_4");
	var_09[4] = make_drop_missile(var_05,"pod_missile_5");
	var_09[5] = make_drop_missile(var_05,"pod_missile_6");
	var_09[6] = make_drop_missile(var_05,"pod_missile_final");
	var_0A = level.player generic_get_player_to_rig(var_05,"pod_phase2b",1);
	var_0B = var_08[0];
	var_0C = [level.cormack_intro,level.will_irons_intro,level.jackson_intro,var_07,var_0A];
	var_0C = common_scripts\utility::array_combine(var_0C,var_08);
	var_0D = [level.cormack,level.will_irons,level.jackson,var_07,var_0A];
	var_0E = level.will_irons.origin;
	var_0F = getent("pod_origin","targetname");
	var_07 overridelightingorigin(var_0F.origin);
	thread maps\seoul_lighting::pod_light_intro(var_07);
	thread maps\seoul_lighting::pod_light_intro_pre(var_07);
	waittillframeend;
	level.cormack_intro maps\_utility::gun_remove();
	level.will_irons_intro maps\_utility::gun_remove();
	level.jackson_intro maps\_utility::gun_remove();
	level.will_irons maps\_utility::gun_remove();
	var_10 = [level.cormack_intro,level.will_irons,level.jackson_intro,var_07,var_0A];
	var_10 = common_scripts\utility::array_combine(var_10,var_08);
	thread maps\seoul_lighting::reflection_pod_guys(var_10,var_00,var_07,var_0A);
	thread maps\_introscreen::introscreen_generic_black_fade_in(0.05,1);
	wait(0.25);
	level.pod_screen overridereflectionprobe(var_00.origin);
	var_06 maps\_anim::anim_first_frame(var_10,"pod_phase1a");
	foreach(var_12 in var_10)
	{
		var_12 dontinterpolate();
	}

	level.player setorigin(level.player.origin,1);
	level.pod_screen dontinterpolate();
	soundscripts\_snd::snd_message("pod_phase1a_start");
	var_06 maps\_anim::anim_single(var_10,"pod_phase1a");
	if(level.nextgen)
	{
		thread show_city_vista(var_02,var_01);
	}

	level notify("swap_wills");
	var_10 = common_scripts\utility::array_remove(var_10,level.will_irons);
	var_10 = common_scripts\utility::array_add(var_10,level.will_irons_intro);
	thread maps\seoul_lighting::reflection_pod_guys(var_10,var_00,var_07,var_0A);
	var_14[0] = make_droppods(var_05,"droppod1");
	var_14[1] = make_droppods(var_05,"droppod2");
	var_14[2] = make_droppods(var_05,"droppod3");
	var_14[3] = make_droppods(var_05,"droppod4");
	var_14[4] = make_droppods(var_05,"droppod5");
	var_14[5] = make_droppods(var_05,"droppod6");
	var_15[0] = maps\_utility::spawn_anim_model("blimp");
	var_15[1] = maps\_utility::spawn_anim_model("blimp_main_01");
	var_15[2] = maps\_utility::spawn_anim_model("blimp_main_02");
	var_15[3] = maps\_utility::spawn_anim_model("blimp_main_03");
	var_15[4] = maps\_utility::spawn_anim_model("blimp_main_04");
	var_16 = maps\_utility::spawn_anim_model("pod_missile_blimp");
	var_17[0] = make_droppods(var_05,"droppod8");
	var_17[1] = make_droppods(var_05,"droppod9");
	var_17[2] = make_droppods(var_05,"droppod10");
	var_18 = common_scripts\utility::array_combine(var_10,var_14);
	var_18 = common_scripts\utility::array_combine(var_18,var_15);
	var_18 = common_scripts\utility::array_combine(var_18,var_17);
	var_18 = common_scripts\utility::array_combine(var_18,[var_16]);
	foreach(var_12 in var_18)
	{
		var_12 dontinterpolate();
	}

	level.player setorigin(level.player.origin,1);
	level.pod_screen dontinterpolate();
	level.will_irons hide();
	level.will_irons forceteleport(var_0E,level.will_irons.angles);
	thread maps\_utility::flag_set_delayed("dialogue_droppod_intro_phase_2b_2",8);
	var_06 maps\_anim::anim_single(var_18,"pod_phase1b");
	level.will_irons maps\_utility::gun_recall();
	level.will_irons show();
	common_scripts\utility::array_call(var_17,::delete);
	common_scripts\utility::array_call(var_15,::delete);
	var_16 delete();
	common_scripts\utility::flag_set("dialogue_droppod_intro_phase_2b");
	common_scripts\utility::flag_set("vfx_start_drop_pod_intro_phase_2b");
	level.pod_screen overridereflectionprobe(var_00.origin);
	common_scripts\utility::flag_clear("set_pre_seoul_intro_lighting");
	common_scripts\utility::flag_set("set_seoul_intro_lighting");
	level thread maps\seoul_fx::intro_droppod_thrusters(var_14);
	var_0C = common_scripts\utility::array_combine(var_0C,var_14);
	var_0C = common_scripts\utility::array_combine(var_0C,var_09);
	soundscripts\_snd::snd_message("droppod_phase_2b_begin");
	var_06 maps\_anim::anim_first_frame(var_0C,"pod_phase2b");
	foreach(var_12 in var_0C)
	{
		var_12 dontinterpolate();
	}

	level.player setorigin(level.player.origin,1);
	level.pod_screen dontinterpolate();
	var_06 maps\_anim::anim_single(var_0C,"pod_phase2b");
	level notify("autosave_request");
	common_scripts\utility::flag_set("dialogue_droppod_intro_phase_3");
	var_06 maps\_anim::anim_first_frame(var_10,"pod_phase3");
	var_1D = var_06 maps\seoul_drop_pod_qte::anim_single_droppod_custom(var_10,var_0A,"pod_phase3");
	if(var_1D == 0)
	{
		var_1E = [var_08[1],var_08[2],level.will_irons_intro];
		var_1F = common_scripts\utility::array_remove_array(var_10,var_1E);
		maps\_anim::anim_set_rate(var_10,"pod_phase3",0);
		var_06 maps\_anim::anim_first_frame(var_1F,"pod_phase3_fail");
		foreach(var_12 in var_1F)
		{
			var_12 dontinterpolate();
		}

		level.player setorigin(level.player.origin,1);
		level.pod_screen dontinterpolate();
		var_06 thread maps\_anim::anim_single(var_1F,"pod_phase3_fail");
		level.player playersetgroundreferenceent(var_0A);
		level.player playersetgroundreferenceent(undefined);
		setdvar("ui_deadquote",&"SEOUL_FAILED_TO_SAVE_JACKSON");
		maps\_utility::missionfailedwrapper();
		var_22 = getanimlength(level.jackson_intro maps\_utility::getanim("pod_phase3_fail"));
		wait(var_22 - 0.05);
		maps\_anim::anim_set_rate_single(var_1F,"pod_phase3_fail",0);
		level.player freezecontrols(1);
		wait(1000);
	}

	var_05 maps\_anim::anim_first_frame(var_10,"pod_phase4a_intro");
	foreach(var_12 in var_10)
	{
		var_12 dontinterpolate();
	}

	level.player setorigin(level.player.origin,1);
	level.pod_screen dontinterpolate();
	var_05 maps\_anim::anim_single(var_10,"pod_phase4a_intro");
	common_scripts\utility::flag_set("dialogue_droppod_intro_phase_4a");
	level notify("manual_heavy_rumble_start");
	var_05 maps\_anim::anim_first_frame(var_10,"pod_phase4a");
	foreach(var_12 in var_10)
	{
		var_12 dontinterpolate();
	}

	level.player setorigin(level.player.origin,1);
	level.pod_screen dontinterpolate();
	soundscripts\_snd::snd_message("droppod_first_building_impact");
	var_05 maps\_anim::anim_single(var_10,"pod_phase4a");
	level notify("manual_heavy_rumble_end");
	var_05 maps\_anim::anim_first_frame(var_10,"pod_phase4b");
	foreach(var_12 in var_10)
	{
		var_12 dontinterpolate();
	}

	level.player setorigin(level.player.origin,1);
	level.pod_screen dontinterpolate();
	level thread maps\_utility::notify_delay("manual_heavy_rumble_start",3);
	level thread maps\_utility::notify_delay("manual_heavy_rumble_end",4);
	var_05 maps\_anim::anim_single(var_10,"pod_phase4b");
	var_10 = [level.cormack_intro,level.will_irons_intro,level.jackson_intro,var_07,var_0A];
	var_10 = common_scripts\utility::array_combine(var_10,var_08);
	foreach(var_12 in var_10)
	{
		var_12 dontinterpolate();
	}

	level.player setorigin(level.player.origin,1);
	level.pod_screen dontinterpolate();
	soundscripts\_snd::snd_message("droppod_final_impact");
	common_scripts\utility::flag_set("spawn_regular_heroes");
	thread maps\seoul_lighting::reflection_pod_guys_landing(var_10);
	thread maps\_utility::flag_clear_delayed("pause_credits",3);
	var_2B = common_scripts\utility::array_remove(var_10,var_0A);
	var_2B = common_scripts\utility::array_remove(var_2B,var_08[3]);
	var_05 play_entire_interactive_pod_exit(var_0A,var_08[3],var_2B);
	level notify("dialogue_hotel_pod_exit_begin");
	level thread maps\_utility::notify_delay("heavy_rumble",1);
	level thread maps\_utility::notify_delay("heavy_rumble",2.25);
	level thread maps\_utility::notify_delay("heavy_rumble",20.75);
	var_2C = [level.cormack_intro,level.will_irons_intro,level.jackson_intro];
	var_10 = common_scripts\utility::array_remove_array(var_10,var_2C);
	common_scripts\utility::array_call(var_2C,::delete);
	var_10 = [level.cormack,level.will_irons,level.jackson,var_07,var_0A];
	var_10 = common_scripts\utility::array_combine(var_10,var_08);
	thread maps\seoul_lighting::reflection_pod_guys2(var_10);
	var_05 maps\_anim::anim_single(var_10,"pod_exit");
	level notify("droppod_begin_fall");
	maps\_player_exo::player_exo_activate();
	level.player generic_remove_player_rig(var_0A);
	level notify("droppod_empty");
	level notify("autosave_request");
	level notify("vfx_player_control_after_pod_landed");
	level.player notify("disable_player_boost_jump");
	common_scripts\utility::flag_set("ok_to_land_assist");
	common_scripts\utility::flag_set("objective_start");
	thread maps\_utility::autosave_now();
	if(level.currentgen)
	{
		thread maps\seoul_transients_cg::cg_kill_entity_on_transition(var_07,"pre_transients_intro_to_fob");
	}

	var_10 = common_scripts\utility::array_remove(var_10,var_07);
	var_10 = common_scripts\utility::array_remove(var_10,var_0A);
	foreach(var_2E in var_08)
	{
		var_10 = common_scripts\utility::array_remove(var_10,var_2E);
	}

	foreach(var_12 in var_10)
	{
		var_12.temp_tag = var_05 common_scripts\utility::spawn_tag_origin();
		var_12.temp_tag thread maps\_anim::anim_loop_solo(var_12,"pod_exit_idle");
	}

	level notify("autosave_request");
	level waittill("begin_building_traversal");
	level.cormack maps\_shg_design_tools::anim_stop(level.cormack.temp_tag);
	var_05 thread maps\_anim::anim_single_solo_run(level.cormack,"pod_exit_outro");
	level.cormack.temp_tag delete();
	level.will_irons maps\_shg_design_tools::anim_stop(level.will_irons.temp_tag);
	var_05 thread maps\_anim::anim_single_solo_run(level.will_irons,"pod_exit_outro");
	level.will_irons.temp_tag delete();
	wait(0.5);
	level.jackson maps\_shg_design_tools::anim_stop(level.jackson.temp_tag);
	var_05 thread maps\_anim::anim_single_solo_run(level.jackson,"pod_exit_outro");
	level.jackson.temp_tag delete();
	setsaveddvar("g_friendlynamedist",1024);
}

//Function Number: 401
animate_the_other_guys(param_00)
{
	var_01 = undefined;
	var_02 = "pod_seat_c";
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04.animname) && var_04.animname == var_02)
		{
			var_01 = var_04;
		}
	}

	var_06 = common_scripts\utility::getstruct("struct_anim_node_space_skybox","targetname");
	var_07 = var_06 common_scripts\utility::spawn_tag_origin();
	param_00 = common_scripts\utility::array_remove_array(param_00,[level.will_irons_intro,level.cormack_intro]);
	param_00 = common_scripts\utility::array_remove(param_00,var_01);
	var_07 maps\_anim::anim_first_frame(param_00,"pod_wakeup");
	foreach(var_09 in param_00)
	{
		var_09 dontinterpolate();
	}

	level.pod_screen dontinterpolate();
	thread maps\_anim::anim_single(param_00,"pod_wakeup");
	maps\_anim::anim_single([level.will_irons_intro,level.cormack_intro,var_01],"pod_wakeup");
	param_00 = common_scripts\utility::array_add(param_00,level.cormack_intro);
	param_00 = common_scripts\utility::array_add(param_00,level.will_irons_intro);
	param_00 = common_scripts\utility::array_add(param_00,var_01);
	level.player setorigin(level.player.origin,1);
	maps\_anim::anim_loop(param_00,"pod_wakeup_idle");
}

//Function Number: 402
repeat_hint_until_comply(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	if(isdefined(param_03))
	{
		self endon(param_03);
	}

	if(isdefined(param_04))
	{
		self endon(param_04);
	}

	for(;;)
	{
		thread maps\_utility::hintdisplayhandler(param_00,5);
		wait(15);
	}
}

//Function Number: 403
repeat_hint_until_comply_oldstyle(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	if(isdefined(param_03))
	{
		self endon(param_03);
	}

	if(isdefined(param_04))
	{
		self endon(param_04);
	}

	for(;;)
	{
		thread maps\_utility::display_hint(param_00);
		wait(15);
	}
}

//Function Number: 404
waittill_player_presses_triggers(param_00)
{
	var_01 = "end_trigger_watcher" + randomfloat(1000);
	level.player notifyonplayercommandremove("BUTTON_LTRIG","+speed_throw");
	level.player notifyonplayercommandremove("BUTTON_LTRIG","+toggleads_throw");
	level.player notifyonplayercommandremove("BUTTON_LTRIG","+ads_akimbo_accessible");
	level.player notifyonplayercommandremove("BUTTON_RTRIG","+attack");
	level.player notifyonplayercommandremove("BUTTON_RTRIG","+attack_akimbo_accessible");
	if(isdefined(param_00) && param_00 == "BUTTON_LTRIG")
	{
		level.player notifyonplayercommand("BUTTON_LTRIG","+speed_throw");
		level.player notifyonplayercommand("BUTTON_LTRIG","+toggleads_throw");
		level.player notifyonplayercommand("BUTTON_LTRIG","+ads_akimbo_accessible");
	}
	else if(isdefined(param_00) && param_00 == "BUTTON_RTRIG")
	{
		level.player notifyonplayercommand("BUTTON_RTRIG","+attack");
		level.player notifyonplayercommand("BUTTON_RTRIG","+attack_akimbo_accessible");
	}
	else
	{
		level.player notifyonplayercommand("BUTTON_LTRIG","+speed_throw");
		level.player notifyonplayercommand("BUTTON_LTRIG","+toggleads_throw");
		level.player notifyonplayercommand("BUTTON_LTRIG","+ads_akimbo_accessible");
		level.player notifyonplayercommand("BUTTON_RTRIG","+attack");
		level.player notifyonplayercommand("BUTTON_RTRIG","+attack_akimbo_accessible");
	}

	for(;;)
	{
		var_02 = level.player common_scripts\utility::waittill_any_return("BUTTON_RTRIG","BUTTON_LTRIG","death");
		if(isdefined(param_00) && param_00 != var_02)
		{
			continue;
		}

		return var_02;
	}
}

//Function Number: 405
monitor_right_trigger_interaction_r(param_00,param_01)
{
	level endon(param_01);
	for(;;)
	{
		while(!level.player buttonpressed(param_00) && !level.player attackbuttonpressed())
		{
			wait 0.05;
		}

		level.player notify("triggers_pressed",param_00);
		wait 0.05;
	}
}

//Function Number: 406
monitor_right_trigger_interaction_l(param_00,param_01)
{
	level endon(param_01);
	for(;;)
	{
		while(!level.player buttonpressed(param_00) && !level.player adsbuttonpressed())
		{
			wait 0.05;
		}

		level.player notify("triggers_pressed",param_00);
		wait 0.05;
	}
}

//Function Number: 407
monitor_right_trigger_interaction_l_ps3(param_00,param_01)
{
	if(level.ps3)
	{
		level.player notifyonplayercommand(param_00,"+speed_throw");
		level.player waittill(param_00);
		level.player notify("triggers_pressed",param_00);
	}
}

//Function Number: 408
play_entire_interactive_pod_exit(param_00,param_01,param_02)
{
	thread animate_the_other_guys(param_02);
	thread pod_door_button_prompt();
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_04 = [param_00,param_01];
	var_03 maps\_anim::anim_first_frame(var_04,"pod_wakeup");
	foreach(var_06 in var_04)
	{
		var_06 dontinterpolate();
	}

	level.player setorigin(level.player.origin,1);
	var_03 maps\_anim::anim_single(var_04,"pod_wakeup");
	var_03 thread maps\_anim::anim_loop(var_04,"pod_wakeup_idle");
	level.player thread repeat_hint_until_comply("lt_rt_harness","ads_pressed","attack_pressed");
	var_08 = level.player waittill_player_presses_triggers();
	level.player.has_used_lt_rt = 1;
	var_03 maps\_utility::anim_stopanimscripted();
	if(var_08 == "BUTTON_LTRIG")
	{
		soundscripts\_snd::snd_message("droppod_harness_left_1");
		level thread maps\_utility::notify_delay("heavy_rumble",2.25);
		var_03 maps\_anim::anim_single(var_04,"pod_wakeup_left_1");
		level.player thread repeat_hint_until_comply("rt_right_harness","attack_pressed");
		var_03 thread maps\_anim::anim_loop(var_04,"pod_wakeup_left_1_idle");
		thread player_climb_wall_head_sway();
		level.player waittill_player_presses_triggers("BUTTON_RTRIG");
		level.player notify("stop_head_sway");
		level.player.has_used_rt = 1;
		var_03 maps\_utility::anim_stopanimscripted();
		soundscripts\_snd::snd_message("droppod_harness_right_2");
		level thread maps\_utility::notify_delay("heavy_rumble",1.35);
		var_03 maps\_anim::anim_single(var_04,"pod_wakeup_right_2");
		level.player notify("walking_towards_hatch");
	}
	else
	{
		soundscripts\_snd::snd_message("droppod_harness_right_1");
		level thread maps\_utility::notify_delay("heavy_rumble",2.25);
		var_03 maps\_anim::anim_single(var_04,"pod_wakeup_right_1");
		level.player thread repeat_hint_until_comply("lt_left_harness","ads_pressed");
		var_03 thread maps\_anim::anim_loop(var_04,"pod_wakeup_right_1_idle");
		thread player_climb_wall_head_sway();
		level.player waittill_player_presses_triggers("BUTTON_LTRIG");
		level.player notify("stop_head_sway");
		level.player.has_used_lt = 1;
		var_03 maps\_utility::anim_stopanimscripted();
		soundscripts\_snd::snd_message("droppod_harness_left_2");
		level thread maps\_utility::notify_delay("heavy_rumble",2.15);
		var_03 maps\_anim::anim_single(var_04,"pod_wakeup_left_2");
		level.player notify("walking_towards_hatch");
	}

	var_03 thread maps\_anim::anim_loop(var_04,"pod_wakeup_kick_idle");
	thread player_climb_wall_head_sway();
	level.player thread repeat_hint_until_comply("a_to_open_hatch","r3_pressed");
	while(!level.player meleebuttonpressed())
	{
		wait 0.05;
	}

	common_scripts\utility::flag_set("kill_credits");
	level.player notify("stop_head_sway");
	level notify("vo_start_spaceman_warn");
	level.player.has_kicked_door = 1;
	level notify("player_drop_pod_door_kick");
	maps\_utility::anim_stopanimscripted();
	var_03 maps\_utility::anim_stopanimscripted();
	var_03 delete();
}

//Function Number: 409
player_climb_wall_head_sway()
{
	level.player endon("stop_head_sway");
	for(;;)
	{
		screenshake(level.player.origin,3,3,2,3,0.2,0.2,0,0.3,0.275,0.125);
		wait(1);
	}
}

//Function Number: 410
pod_door_button_prompt()
{
	level.player waittill("walking_towards_hatch");
	var_00 = common_scripts\utility::getstruct("struct_pod_exit_door_button","targetname");
	var_01 = maps\_shg_utility::hint_button_position("rs",var_00.origin,80,120);
	level waittill("player_drop_pod_door_kick");
	var_01 maps\_shg_utility::hint_button_clear();
}

//Function Number: 411
open_hatch_breakout()
{
	if(!isdefined(level.player.has_kicked_door))
	{
		return 0;
	}

	if(level.player.has_kicked_door)
	{
		return 1;
	}
}

//Function Number: 412
lt_harness_breakout()
{
	if(!isdefined(level.player.has_used_lt))
	{
		return 0;
	}

	if(level.player.has_used_lt)
	{
		return 1;
	}
}

//Function Number: 413
rt_harness_breakout()
{
	if(!isdefined(level.player.has_used_rt))
	{
		return 0;
	}

	if(level.player.has_used_rt)
	{
		return 1;
	}
}

//Function Number: 414
lt_rt_harness_breakout()
{
	if(!isdefined(level.player.has_used_lt_rt))
	{
		return 0;
	}

	if(level.player.has_used_lt_rt)
	{
		return 1;
	}
}

//Function Number: 415
setup_allies()
{
	var_00 = getent("hero_will_irons_spawner","targetname");
	level.will_irons = var_00 maps\_shg_design_tools::actual_spawn();
	level.will_irons hero_stats("will_irons","o");
	var_00 = getent("hero_cormack_spawner","targetname");
	level.cormack = var_00 maps\_shg_design_tools::actual_spawn();
	level.cormack hero_stats("cormack","r");
	var_00 = getent("hero_guy_spawner","targetname");
	level.jackson = var_00 maps\_shg_design_tools::actual_spawn();
	level.jackson hero_stats("jackson","y");
	if(common_scripts\utility::flag("spawn_guys_for_intro"))
	{
		var_01 = getent("hero_cormack_spawner_intro","targetname");
		level.cormack_intro = var_01 maps\_shg_design_tools::actual_spawn();
		level.cormack_intro.animname = "cormack";
		var_01 = getent("hero_will_irons_spawner_intro","targetname");
		level.will_irons_intro = var_01 maps\_shg_design_tools::actual_spawn();
		level.will_irons_intro.animname = "will_irons";
		var_01 = getent("hero_guy_spawner_intro","targetname");
		if(!isdefined(var_01))
		{
			var_01 = getent("hero_guy_spawner","targetname");
		}

		level.jackson_intro = var_01 maps\_shg_design_tools::actual_spawn();
		level.jackson_intro.animname = "jackson";
		common_scripts\utility::flag_wait("spawn_regular_heroes");
	}

	level.squad = [level.will_irons,level.cormack,level.jackson];
	thread seoul_color_think();
}

//Function Number: 416
hero_stats(param_00,param_01)
{
	self.a.disablepain = 1;
	thread maps\_utility::deletable_magic_bullet_shield();
	self setthreatbiasgroup("allies");
	self setthreatbiasgroup("major_allies");
	maps\_utility::set_force_color(param_01);
	self.animname = param_00;
	maps\_utility::enable_cqbwalk();
	maps\_utility::disable_surprise();
	self.canjumppath = 1;
}

//Function Number: 417
seoul_color_think()
{
	level.player waittill("end_drone_swarm");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}

	maps\_utility::activate_trigger_with_targetname("trig_color_ro5");
}

//Function Number: 418
setup_end_scene()
{
	maps\_shg_design_tools::waittill_trigger_with_name("end_army_view_trigger");
	level waittill("never_true");
	maps\_utility::nextmission();
}

//Function Number: 419
initial_ally_wave()
{
	thread spawn_initial_forces_tanks();
	thread spawn_initial_forces_warbirds();
	maps\_shg_design_tools::waittill_trigger_with_name("player_exit_pod_trigger");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tank_group_00");
}

//Function Number: 420
spawn_initial_forces_warbirds()
{
	maps\_shg_design_tools::waittill_trigger_with_name("start_pod_landings");
	var_00 = getentarray("warbird_ambient_01","targetname");
	wait(1.5);
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_vehicle::spawn_vehicle_and_gopath();
		var_03 soundscripts\_snd::snd_message("seo_fob_razorback_02");
		var_04 = getent("main_street_reflection","targetname");
		var_03 overridereflectionprobe(var_04.origin);
		thread vehicle_scripts\_attack_drone::boid_add_vehicle_to_targets(var_03);
		wait(0.2);
	}
}

//Function Number: 421
spawn_initial_forces_tanks()
{
	var_00 = getentarray("tank_group_01","targetname");
	var_01 = getentarray("tank_group_02","targetname");
	common_scripts\utility::array_thread(var_00,::maps\_utility::spawn_vehicle);
	common_scripts\utility::array_thread(var_01,::spawn_tank_column);
}

//Function Number: 422
spawn_tank_column()
{
	var_00 = maps\_utility::spawn_vehicle();
	maps\_shg_design_tools::waittill_trigger_with_name("leaving_cpk");
	var_00 maps\_vehicle::gopath();
	var_00 waittill("reached_end_node");
	var_00 delete();
}

//Function Number: 423
gangam_cinematic_warfare_manager()
{
	common_scripts\utility::flag_wait("begin_looping_fob_functions");
	thread fob_blocking();
	thread injured_soldier_loop();
	thread fob_ignore_management();
	thread fob_drop_pod_1();
	thread fob_drop_pod_fake();
	if(level.nextgen)
	{
		thread radio_run_guy();
		thread very_first_tank();
	}

	thread very_first_tank_close();
	thread disable_pod_door_clip();
	thread mechs_upclose();
	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
	common_scripts\utility::flag_init("begin_drag_animation");
	if(level.nextgen)
	{
		thread signal_turn_guy();
	}

	if(level.currentgen)
	{
		wait(0.2);
	}

	thread soldiers_go_through_tunnel();
	if(level.currentgen)
	{
		wait(0.05);
	}

	thread cinematic_rocket_guys();
	if(level.currentgen)
	{
		wait(0.05);
	}

	thread return_fire_rocket();
	thread fake_rocket_explode_moment();
	thread looping_tank_spawner();
	thread looping_airplanes();
	thread fob_block_player_in();
	thread cleanup_fob_guys();
	if(level.nextgen)
	{
		thread walker_jet_flyby();
		thread special_flyby_jet();
	}

	thread player_clip_pod_door();
}

//Function Number: 424
injured_soldier_loop()
{
	var_00 = getent("ally_spawner_fob_injured_by_base_unique","targetname");
	var_01 = getent("cinematic_injured_soldier_spawner","targetname");
	var_02 = var_00 maps\_utility::spawn_ai(1);
	if(level.currentgen)
	{
		wait(0.05);
	}

	var_03 = var_01 maps\_utility::spawn_ai(1);
	var_02.animname = "generic";
	var_03.animname = "generic";
	level.healer = var_02;
	level.healer thread injured_guy_dialogue();
	var_04 = getent("injured_soldier_revive_loop_animorg","targetname");
	var_04 thread maps\_anim::anim_loop_solo(var_02,"seo_injured_soldier_idle02_guy01","stop_loop");
	var_04 thread maps\_anim::anim_loop_solo(var_03,"seo_injured_soldier_idle02_guy02","stop_loop");
}

//Function Number: 425
signal_turn_guy()
{
	var_00 = getent("ally_spawner_fob_turn_signal","targetname");
	var_01 = common_scripts\utility::getstruct("struct_fob_injured_soldier_turn_order","targetname");
	var_02 = getnode("sarge_movehere_after_orders","targetname");
	var_03 = getnode("mech_carry_high_goalnode","targetname");
	var_04 = var_00 maps\_utility::spawn_ai(1);
	var_04.animname = "generic";
	var_01 thread maps\_anim::anim_generic(var_04,"seo_turn_gesturetomove_guy01");
	var_04 setgoalnode(var_02);
	var_04 waittill("goal");
	var_04 setgoalnode(var_03);
	var_04 thread delete_me_on_goal();
	var_04.goalradius = 15;
	wait(1.5);
	common_scripts\utility::flag_set("begin_mech_reload");
	wait(3.67);
	common_scripts\utility::flag_set("orders_given_lets_move_out");
}

//Function Number: 426
cinematic_rocket_guys()
{
	var_00 = getent("cinematic_rocket_guys_loop","targetname");
	var_01 = getent("cinematic_rocket_guys_spawner","targetname");
	var_02 = getent("cinematic_rocket_guys_spawner2","targetname");
	var_03 = var_01 maps\_utility::spawn_ai(1);
	if(level.currentgen)
	{
		wait(0.05);
	}

	var_04 = var_02 maps\_utility::spawn_ai(1);
	var_03.animname = "generic";
	var_04.animname = "generic";
	wait(0.05);
	var_03 maps\_utility::gun_remove();
	var_04 maps\_utility::gun_remove();
	var_04 thread fire_fake_rocket_function();
	var_03 attach("npc_stingerm7_base_black","tag_weapon_right");
	var_04 attach("weapon_binocular","tag_weapon_left");
	var_00 thread maps\_anim::anim_loop_solo(var_03,"seo_cover_launcher_idle_guy01");
	var_00 thread maps\_anim::anim_loop_solo(var_04,"seo_cover_launcher_idle_guy02");
}

//Function Number: 427
fire_fake_rocket_function()
{
	self endon("death");
	var_00 = getent("rocket_shoot_here_loop_org","targetname");
	var_01 = getent("rocket_spawn_here_org","targetname");
	for(;;)
	{
		level waittill("fire_fake_rocket_now");
		magicbullet("rpg_straight",var_01.origin,var_00.origin);
	}
}

//Function Number: 428
soldiers_go_through_tunnel()
{
	maps\_utility::trigger_wait_targetname("trigger_fob_scene");
	var_00 = getent("go_through_tunnel_guy1_spawner","targetname");
	var_01 = getnode("go_through_tunnel_guy1_goalnode","targetname");
	var_02 = var_00 maps\_utility::spawn_ai(1);
	var_02.animname = "generic";
	var_02 maps\_utility::set_run_anim("seo_run_gununderarm_guy01");
	var_02 setgoalnode(var_01);
	wait(5);
	var_02 maps\_utility::enable_cqbwalk();
}

//Function Number: 429
traffic_manager(param_00,param_01,param_02,param_03)
{
	var_04 = getent(param_00,"targetname");
	while(!common_scripts\utility::flag(param_02))
	{
		if(anythingistouching(param_01,var_04))
		{
			maps\_utility::set_moveplaybackrate(param_03);
			continue;
		}

		maps\_utility::set_moveplaybackrate(1);
		wait 0.05;
	}
}

//Function Number: 430
anythingistouching(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(var_03 istouching(param_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 431
mechs_upclose()
{
	var_00 = getent("mech_taking_orders_spawner","targetname");
	var_01 = getent("mech_taking_orders_spawner2","targetname");
	var_02 = var_00 maps\_utility::spawn_ai(1);
	var_03 = [level.cormack,level.will_irons];
	var_02 thread traffic_manager("vol_mech_slow_vol_01",var_03,"npc_pods_landed",0.5);
	var_02.ignoreall = 1;
	var_02.goalradius = 15;
	var_04 = getent("mech_orders1","targetname");
	var_05 = getent("mech_orders_2","targetname");
	var_02.animname = "generic";
	var_02 maps\_utility::set_run_anim("mech_unaware_walk");
	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
	wait(4);
	var_02 setgoalpos(var_04.origin);
	var_02 thread maps\_shg_design_tools::delete_at_goal();
}

//Function Number: 432
return_fire_rocket()
{
	common_scripts\utility::flag_wait("start_cinematic_rocket_scene");
	var_00 = getent("return_fire_rocket","targetname");
	var_01 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
	var_01 thread sidewinder_explode_impact();
	common_scripts\utility::flag_set("incoming_rocket_fire");
}

//Function Number: 433
tank_shoot_time(param_00)
{
	self endon("death");
	var_01 = getent("rocket_shoot_here_loop_org","targetname");
	wait(param_00 / 2);
	self setturrettargetent(var_01);
	wait(param_00 / 2);
	self fireweapon();
}

//Function Number: 434
tank_shoot_generic(param_00)
{
	self endon("death");
	var_01 = maps\_shg_design_tools::offset_position_from_tag("forward","tag_flash",1000);
	var_02 = var_01 + (randomintrange(-200,200),randomintrange(-200,200),0);
	wait(param_00 / 2);
	self setturrettargetvec(var_02);
	wait(param_00 / 2);
	self fireweapon();
}

//Function Number: 435
fake_rocket_explode_moment()
{
	var_00 = getnode("after_explode_safenode","targetname");
	var_01 = getent("cinematic_combat_vignette_explosion_animorg","targetname");
	var_02 = getnode("cinematic_combat_vignette_explode_safenode","targetname");
	var_03 = getnode("vig_space2","targetname");
	var_04 = getent("cinematic_combat_vignette_explosion_spawner","targetname");
	var_05 = getent("cinematic_combat_vignette_explosion_spawner2","targetname");
	var_06 = var_04 maps\_utility::spawn_ai(1);
	if(level.currentgen)
	{
		wait(0.05);
	}

	var_06.goalradius = 15;
	var_07 = var_05 maps\_utility::spawn_ai(1);
	var_07.goalradius = 15;
	var_07.animname = "generic";
	common_scripts\utility::flag_wait("incoming_rocket_fire");
	var_01 maps\_anim::anim_reach_solo(var_07,var_01.animation);
	var_07 setgoalnode(var_03);
	var_01 thread maps\_anim::anim_single_solo(var_07,var_01.animation);
	wait(1.5);
	var_06 setgoalnode(var_00);
	common_scripts\utility::flag_wait("kill_rocket_scene_guy");
	wait(2.3);
	var_06 kill();
}

//Function Number: 436
fob_ignore_management()
{
	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
	wait(1);
	level.player.ignoreme = 1;
	level.cormack.ignoreme = 1;
	level.cormack.ignoreall = 1;
	level.will_irons.ignoreme = 1;
	level.will_irons.ignoreall = 1;
	level.jackson.ignoreme = 1;
	level.jackson.ignoreall = 1;
	maps\_utility::trigger_wait_targetname("trigger_hill_event_01");
	level.player.ignoreme = 0;
	level.cormack.ignoreme = 0;
	level.cormack.ignoreall = 0;
	level.will_irons.ignoreme = 0;
	level.will_irons.ignoreall = 0;
	level.jackson.ignoreme = 0;
	level.jackson.ignoreall = 0;
}

//Function Number: 437
looping_tank_spawner()
{
	level endon("stop_looping_death_soldiers");
	if(level.currentgen)
	{
		level endon("pre_transients_drone_seq_one_to_trusk_push");
	}

	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
	wait(5);
	if(level.currentgen)
	{
		if(!istransientloaded("seoul_fob_tr"))
		{
			level waittill("transients_intro_to_fob");
		}
	}

	var_00 = getent("looping_tank_spawner","targetname");
	for(;;)
	{
		var_01 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
		if(level.currentgen)
		{
			thread maps\seoul_transients_cg::cg_kill_entity_on_transition(var_01,"pre_transients_drone_seq_one_to_trusk_push");
		}

		var_01 soundscripts\_snd::snd_message("seo_fob_tank_procedural");
		var_01.ignoreme = 1;
		var_01 maps\_utility::deletable_magic_bullet_shield();
		var_01 thread delete_me_on_goal();
		thread tank_wait_flag_time(14);
		if(!common_scripts\utility::flag("follow_tank_is_dead"))
		{
			var_02 = getent("run_behind_tank_followorg","targetname");
			var_02 linkto(var_01);
			var_02 thread tank_trail();
		}

		var_03 = randomintrange(20,30);
		var_04 = randomint(2);
		if(var_04 == 1)
		{
			var_01 thread tank_shoot_time(var_03);
		}

		wait(randomintrange(26,30));
	}
}

//Function Number: 438
tank_trail()
{
	level.tanktrail = self.origin;
	common_scripts\utility::flag_set("follow_tank_is_dead");
	for(;;)
	{
		if(isdefined(self))
		{
			level.tanktrail = self.origin;
		}
		else
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 439
tank_wait_flag_time(param_00)
{
	wait(param_00);
	common_scripts\utility::flag_set("tank_is_clear");
}

//Function Number: 440
delete_me_on_goal(param_00)
{
	self endon("death");
	self waittill("goal");
	self delete();
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02))
		{
			var_02 delete();
		}
	}
}

//Function Number: 441
looping_airplanes()
{
	level endon("stop_looping_death_soldiers");
	common_scripts\utility::flag_wait("spawn_looping_planes");
	var_00 = getent("looping_jetplane_1","targetname");
	var_01 = getent("looping_jetplane_2","targetname");
	var_02 = getent("looping_jetplane_3","targetname");
	var_03 = 0;
	wait(4);
	for(;;)
	{
		var_03 = randomint(4);
		if(var_03 == 0)
		{
			if(isdefined(var_00))
			{
				var_04 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
				var_04 soundscripts\_snd::snd_message("aud_handle_gangam_jets");
			}
		}
		else if(var_03 == 1)
		{
			if(isdefined(var_01))
			{
				var_04 = var_01 maps\_vehicle::spawn_vehicle_and_gopath();
				var_04 soundscripts\_snd::snd_message("aud_handle_gangam_jets");
			}
		}
		else if(var_03 == 2)
		{
			if(isdefined(var_01) && isdefined(var_00))
			{
				var_04 = var_01 maps\_vehicle::spawn_vehicle_and_gopath();
				var_05 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
				var_04 soundscripts\_snd::snd_message("aud_handle_gangam_jets");
			}
		}
		else if(var_03 == 3)
		{
			if(isdefined(var_02))
			{
				var_04 = var_02 maps\_vehicle::spawn_vehicle_and_gopath();
				var_04 soundscripts\_snd::snd_message("aud_handle_gangam_jets");
			}
		}

		wait(randomintrange(18,22));
	}
}

//Function Number: 442
fob_block_player_in()
{
	thread fob_player_blocking();
}

//Function Number: 443
fob_player_blocking()
{
	thread setup_fob_blocker_guy_loop("struct_fob_blocker_guy_01");
	thread setup_fob_blocker_guy_loop("struct_fob_blocker_guy_04");
	thread setup_fob_blocker_guy_loop("struct_fob_blocker_guy_03","patrol_bored_idle","dialogue_start_fob_meetup","crouch_wait2");
	var_00 = getent("fob_player_clipblock","targetname");
	common_scripts\utility::flag_wait("destroy_fob_blocking");
	var_00 delete();
}

//Function Number: 444
setup_fob_blocker_guy_loop(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	if(issubstr(param_00,"04"))
	{
		var_04 = 1;
	}

	var_05 = common_scripts\utility::getstruct(param_00,"targetname");
	var_06 = var_05 common_scripts\utility::spawn_tag_origin();
	var_07 = undefined;
	if(isdefined(param_03))
	{
		var_07 = getnode(param_03,"targetname");
	}

	if(!isdefined(param_01))
	{
		param_01 = var_05.animation;
	}

	var_08 = getent("gate_guard_spawner_lowlod","targetname");
	var_09 = var_08 maps\_shg_design_tools::actual_spawn(1);
	if(var_04)
	{
		var_09 maps\_utility::gun_remove();
	}

	var_06 thread maps\_anim::anim_generic_loop(var_09,param_01);
	if(isdefined(param_02))
	{
		common_scripts\utility::flag_wait(param_02);
		wait(16);
		var_09 maps\_shg_design_tools::anim_stop(var_06);
		var_06 notify("stop_loop");
		var_09 setgoalnode(var_07);
	}

	common_scripts\utility::flag_wait("cleanup_injury_team_now");
	var_09 maps\_shg_design_tools::delete_auto();
	var_06 maps\_shg_design_tools::delete_auto();
}

//Function Number: 445
cleanup_fob_guys()
{
	common_scripts\utility::flag_wait("cleanup_injury_team_now");
	var_00 = getentarray("cleanup_injury_team","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(!isspawner(var_02))
		{
			var_02 delete();
		}
	}
}

//Function Number: 446
walker_jet_flyby()
{
	var_00 = getent("walker_jet_flyby","targetname");
	var_01 = getent("walker_jet_flyby2","targetname");
	var_02 = getent("missle_walker_1","targetname");
	var_03 = getent("missle_walker_2","targetname");
	var_04 = getent("missle_walker_3","targetname");
	maps\_utility::trigger_wait_targetname("trigger_hill_event_00");
	common_scripts\utility::flag_wait("walker_walkby_jets_rockets");
	var_05 = var_00 thread maps\_vehicle::spawn_vehicle_and_gopath();
	wait(2);
	var_06 = var_02 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_06 thread missile_delete();
	wait(0.3);
	var_07 = var_03 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_07 thread missile_delete();
	wait(0.3);
	var_08 = var_04 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_08 thread missile_delete();
}

//Function Number: 447
fob_blocking()
{
	var_00 = getent("fob_passed_blocking","targetname");
	var_00 connectpaths();
	var_00 notsolid();
	var_01 = getent("fob_passed_blocking_art","targetname");
	var_01 hide();
	common_scripts\utility::flag_wait("player_passed_fob");
	level notify("stop_looping_death_soldiers");
	common_scripts\utility::flag_set("cleanup_injury_team_now");
}

//Function Number: 448
fob_drop_pod_1()
{
	var_00 = getentarray("animorg_pod_falling","targetname");
	var_01 = var_00[0];
	var_02 = getent("drop_pod_1_spawner","targetname");
	var_03 = getent("animorg_pod_falling_guy_exit_org","targetname");
	var_04 = getnode("delete_me_here_right_org","targetname");
	if(level.currentgen)
	{
		if(!istransientloaded("seoul_fob_tr"))
		{
			level waittill("transients_intro_to_fob");
		}
	}

	thread fob_placed_unload(var_01,var_02,var_04);
	thread monitor_droppod_destruction();
}

//Function Number: 449
monitor_droppod_destruction()
{
	thread handle_debris_visibility("pod_land_debris_01");
	thread handle_debris_visibility("pod_land_debris_02");
}

//Function Number: 450
handle_debris_visibility(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 hide();
	}

	for(;;)
	{
		level waittill("npc_droppod_landed",var_05,var_06);
		if(distance(var_06,var_01[0].origin) < 100)
		{
			break;
		}
	}

	foreach(var_03 in var_01)
	{
		var_03 show();
	}
}

//Function Number: 451
pod_shake_play(param_00,param_01,param_02)
{
	wait(param_02);
	var_03 = distance(self.origin,level.player.origin);
	if(var_03 < param_00)
	{
		earthquake(0.3,param_01,self.origin,param_00);
		level.player playrumbleonentity("heavy_3s");
		wait(param_01);
	}

	wait 0.05;
}

//Function Number: 452
fob_placed_unload(param_00,param_01,param_02)
{
	var_03 = maps\_utility::spawn_anim_model("npc_droppod");
	param_00 maps\_anim::anim_first_frame_solo(var_03,"pod_landing");
	var_04 = getent("player_pod_door_clip","targetname");
	var_05 = getnodearray("delete_me_node_array","targetname");
	var_06 = param_00 setup_guy_for_droppod(param_01,"seo_fob_drop_guy_01");
	var_07 = param_00 setup_guy_for_droppod(param_01,"seo_fob_drop_guy_02");
	var_08 = param_00 setup_guy_for_droppod(param_01,"seo_fob_drop_guy_03");
	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
	var_06 show();
	var_07 show();
	var_08 show();
	thread animated_pod_function(var_03,param_00,var_04);
	param_00 thread maps\_anim::anim_single_solo_run(var_06,"seo_fob_drop_guy_01");
	param_00 thread maps\_anim::anim_single_solo_run(var_07,"seo_fob_drop_guy_02");
	param_00 thread maps\_anim::anim_single_solo_run(var_08,"seo_fob_drop_guy_03");
	level notify("spawn_fake_drop_pods");
	var_06 thread goto_node_and_delete(var_05);
	var_07 thread goto_node_and_delete(var_05);
	var_08 thread goto_node_and_delete(var_05);
}

//Function Number: 453
setup_guy_for_droppod(param_00,param_01)
{
	var_02 = param_00 maps\_shg_design_tools::actual_spawn(1);
	if(!isdefined(var_02))
	{
		return;
	}

	var_02 hide();
	var_02.animname = "generic";
	var_02.ignoreall = 1;
	var_02.canjumppath = 1;
	var_02 maps\_utility::disable_surprise();
	thread maps\_anim::anim_first_frame_solo(var_02,param_01);
	var_02 maps\_utility::set_run_anim("run_lowready_f");
	return var_02;
}

//Function Number: 454
goto_node_and_delete(param_00)
{
	self.goalradius = 20;
	var_01 = common_scripts\utility::random(param_00);
	self setgoalpos(var_01.origin);
	thread delete_me_on_goal();
}

//Function Number: 455
backup_drop_pod_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = param_02 maps\_utility::spawn_ai(1);
	if(isalive(var_0A))
	{
		var_0A hide();
		var_0A.animname = "generic";
		var_0A.ignoreall = 1;
		var_0A.canjumppath = 1;
		param_02.count = 1;
		wait(0.05);
	}

	var_0B = param_02 maps\_utility::spawn_ai(1);
	if(isalive(var_0B))
	{
		var_0B hide();
		var_0B.animname = "generic";
		var_0B.ignoreall = 1;
		var_0B.canjumppath = 1;
		param_02.count = 1;
		wait(0.05);
	}

	var_0C = param_02 maps\_utility::spawn_ai(1);
	if(isalive(var_0C))
	{
		var_0C hide();
		var_0C.animname = "generic";
		var_0C.ignoreall = 1;
		var_0C.canjumppath = 1;
	}

	var_0D = "casual_stand_idle";
	var_0E = "patrol_bored_idle";
	var_0F = "casual_stand_idle";
	thread animated_pod_function(param_00,param_01,param_09);
	if(isalive(var_0A))
	{
		var_0A show();
		param_01 thread maps\_anim::anim_single_solo_run(var_0A,"seo_fob_drop_guy_01");
		var_0A.goalradius = 20;
		var_0A setgoalpos(param_03.origin);
		var_0A thread animate_on_goal(var_0D,param_03,param_06);
		var_0A thread move_again_noflag(param_03,param_06);
		var_0A thread kill_on_trigger("trigger_fob_scene");
	}

	if(isalive(var_0B))
	{
		var_0B show();
		param_01 thread maps\_anim::anim_single_solo_run(var_0B,"seo_fob_drop_guy_02");
		var_0B.goalradius = 20;
		var_0B setgoalpos(param_04.origin);
		var_0B thread animate_on_goal(var_0E,param_04,param_07);
		var_0B thread move_again_noflag(param_04,param_07);
		var_0B thread kill_on_trigger("trigger_fob_scene");
	}

	if(isalive(var_0C))
	{
		var_0C show();
		param_01 thread maps\_anim::anim_single_solo_run(var_0C,"seo_fob_drop_guy_03");
		var_0C.goalradius = 20;
		var_0C setgoalpos(param_05.origin);
		var_0C thread animate_on_goal(var_0F,param_05,param_08);
		var_0C thread move_again_noflag(param_05,param_08);
		var_0C thread kill_on_trigger("trigger_fob_scene");
	}
}

//Function Number: 456
monitor_pod_landing_for_debris(param_00)
{
	wait(0.25);
	level notify("npc_droppod_landed",param_00,param_00.origin);
}

//Function Number: 457
animated_pod_function(param_00,param_01,param_02)
{
	param_00 thread pod_shake_play(1250,3,4.3);
	level notify("aud_npc_droppod_landing",param_00,param_00.origin);
	param_01 maps\_anim::anim_single_solo(param_00,"pod_landing");
	thread enable_pod_door_clip(param_02);
	var_03 = spawn("script_model",param_00.origin);
	var_03.angles = param_00.angles;
	var_03 setmodel("vehicle_mil_drop_pod_static_gsq");
	param_00 delete();
	wait(2);
	common_scripts\utility::flag_set("npc_pods_landed");
}

//Function Number: 458
move_again_noflag(param_00,param_01)
{
	self endon("death");
	wait(9);
	if(!common_scripts\utility::flag(param_01))
	{
		self setgoalpos(param_00.origin);
	}
}

//Function Number: 459
animate_on_goal(param_00,param_01,param_02)
{
	self endon("death");
	self waittill("goal");
	common_scripts\utility::flag_set(param_02);
	param_01 maps\_anim::anim_loop_solo(self,param_00);
}

//Function Number: 460
radio_run_guy()
{
	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
	wait(2);
	var_00 = getent("ally_spawner_fob_injured","targetname");
	level.resdhirt1 = var_00 maps\_utility::spawn_ai(1);
	level.resdhirt1 endon("death");
	if(!isdefined(level.resdhirt1))
	{
		return;
	}

	level.resdhirt1.ignoreall = 1;
	level.resdhirt1.goalradius = 64;
	level.resdhirt1.canjumppath = 1;
	level.resdhirt1.animname = "generic";
	var_01 = common_scripts\utility::getstructarray("radio_run_guy_org","targetname");
	var_02 = var_01[0];
	var_02 maps\_anim::anim_reach_solo(level.resdhirt1,"seo_move_stoponradio_loop_guy1");
	var_03 = getnode("delete_me_node_2","targetname");
	common_scripts\utility::flag_set("play_radio_walkby_guy_vo");
	level.resdhirt1 thread allow_death_delay();
	var_02 maps\_anim::anim_single_solo_run(level.resdhirt1,"seo_move_stoponradio_loop_guy1");
	var_04 = getent("group3_orders_wait3","targetname");
	level.resdhirt1 setgoalpos(var_04.origin);
	level.resdhirt1 thread kill_on_trigger("trigger_hill_event_01");
}

//Function Number: 461
allow_death_delay()
{
	self endon("death");
	wait(0.1);
	self.allowdeath = 1;
}

//Function Number: 462
very_first_tank()
{
	var_00 = getent("very_first_tank","targetname");
	var_01 = var_00 maps\_utility::spawn_vehicle();
	var_01 soundscripts\_snd::snd_message("seo_fob_tank_01");
	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
	var_01 maps\_utility::deletable_magic_bullet_shield();
	var_01 maps\_vehicle::gopath();
	wait(1.5);
	var_01 fireweapon();
}

//Function Number: 463
very_first_tank_close()
{
	if(level.currentgen)
	{
		if(!istransientloaded("seoul_fob_tr"))
		{
			level waittill("transients_intro_to_fob");
		}
	}

	var_00 = getent("very_first_tank_close","targetname");
	var_01 = getent("very_first_tank_close_extra","targetname");
	var_02 = var_00 maps\_utility::spawn_vehicle();
	var_02 soundscripts\_snd::snd_message("seo_fob_tank_02");
	common_scripts\utility::flag_wait("begin_fob_combat_vignette");
	var_02 maps\_utility::deletable_magic_bullet_shield();
	var_02 maps\_vehicle::gopath();
	var_02 thread delete_me_on_goal();
	var_03 = var_01 maps\_utility::spawn_vehicle();
	var_03 soundscripts\_snd::snd_message("seo_fob_tank_03");
	var_03 maps\_utility::deletable_magic_bullet_shield();
	var_03 maps\_vehicle::gopath();
	var_03 thread delete_me_on_goal();
	if(level.currentgen)
	{
		thread maps\seoul_transients_cg::cg_kill_entity_on_transition(var_02,"pre_transients_drone_seq_one_to_trusk_push");
		thread maps\seoul_transients_cg::cg_kill_entity_on_transition(var_03,"pre_transients_drone_seq_one_to_trusk_push");
	}

	wait(8);
	var_02 fireweapon();
	wait(4);
	var_02 fireweapon();
}

//Function Number: 464
waiting_mechs()
{
	var_00 = getent("waiting_mech_1","targetname");
	var_01 = getnode("waiting_mech_one_node","targetname");
	var_02 = getent("waiting_mech_one_origin","targetname");
	var_03 = getent("waiting_mech_two_origin","targetname");
	var_04 = "mech_stand_idle_wbtest";
	var_05 = "mech_unaware_idle";
	var_06 = "mech_stand_reload";
	var_07 = var_00 maps\_utility::spawn_ai(1);
	var_07.animname = "generic";
	var_03 thread maps\_anim::anim_loop_solo(var_07,var_04);
}

//Function Number: 465
fob_drop_pod_fake()
{
	var_00 = getent("animorg_pod_falling_fake1","targetname");
	var_01 = getent("animorg_pod_falling_fake2","targetname");
	var_02 = maps\_utility::spawn_anim_model("npc_droppod");
	var_03 = maps\_utility::spawn_anim_model("npc_droppod");
	var_04 = getent("drop_pod_1_spawner2","targetname");
	var_05 = getent("drop_pod_1_spawner3","targetname");
	level waittill("spawn_fake_drop_pods");
	if(level.currentgen)
	{
		if(!istransientloaded("seoul_fob_tr"))
		{
			level waittill("transients_intro_to_fob");
		}
	}

	var_06 = getent("group2_orders_wait1","targetname");
	var_07 = getent("group2_orders_wait2","targetname");
	var_08 = getent("group2_orders_wait3","targetname");
	var_09 = "guy4_reached_goal";
	var_0A = "guy5_reached_goal";
	var_0B = "guy6_reached_goal";
	var_0C = getent("group3_orders_wait1","targetname");
	var_0D = getent("group3_orders_wait2","targetname");
	var_0E = getent("group3_orders_wait3","targetname");
	var_0F = "guy7_reached_goal";
	var_10 = "guy8_reached_goal";
	var_11 = "guy9_reached_goal";
	var_12 = getent("player_pod_door_clip2","targetname");
	var_13 = getent("player_pod_door_clip3","targetname");
	wait(1.15);
	wait(1.2);
	if(level.nextgen)
	{
		thread backup_drop_pod_function(var_03,var_01,var_05,var_0C,var_0D,var_0E,var_0F,var_10,var_11,var_13);
		return;
	}

	thread animated_pod_function(var_03,var_01,var_13);
}

//Function Number: 466
fob_out_of_bounds_fail()
{
	level endon("stop_looping_death_soldiers");
	level.player endon("death");
	var_00 = getentarray("player_out_of_bounds","targetname");
	for(;;)
	{
		foreach(var_02 in var_00)
		{
			if(level.player istouching(var_02))
			{
				maps\_player_death::set_deadquote(&"SEOUL_ON_MISSION");
				level.player freezecontrols(1);
				maps\_utility::missionfailedwrapper();
			}
		}

		wait(0.05);
	}
}

//Function Number: 467
play_out_of_bounds_vo(param_00)
{
	var_01 = 2;
	if(!isdefined(level.last_warning_line))
	{
		level.last_warning_line = -1;
		level.warning_lines = ["seo_crk_overheremitchell","seo_crk_mitchellmoveit"];
	}

	for(var_02 = randomint(var_01);var_02 == level.last_warning_line;var_02 = randomint(var_01))
	{
	}

	level.last_warning_line = var_02;
	var_03 = level.warning_lines[var_02];
	param_00 maps\_utility::dialogue_queue(var_03);
}

//Function Number: 468
special_flyby_jet()
{
	var_00 = getent("special_jet_flyby_spawner1","targetname");
	var_01 = getent("special_jet_flyby_spawner2","targetname");
	var_02 = getent("special_jet_flyby_spawner3","targetname");
	var_03 = [var_00,var_01,var_02];
	common_scripts\utility::flag_wait("special_jets_flyby");
	foreach(var_05 in var_03)
	{
		var_06 = var_05 maps\_vehicle::spawn_vehicle_and_gopath();
		var_06 soundscripts\_snd::snd_message("aud_handle_gangam_jets");
		wait(randomintrange(1,3));
	}

	wait(6);
	common_scripts\utility::flag_set("spawn_looping_planes");
}

//Function Number: 469
disable_pod_door_clip()
{
	var_00 = getent("player_pod_door_clip","targetname");
	var_01 = getent("player_pod_door_clip2","targetname");
	var_02 = getent("player_pod_door_clip3","targetname");
	var_03 = [var_00,var_01,var_02];
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05))
		{
			var_05 notsolid();
		}
	}
}

//Function Number: 470
enable_pod_door_clip(param_00)
{
	if(isdefined(param_00))
	{
		param_00 solid();
	}
}

//Function Number: 471
player_clip_pod_door(param_00)
{
	common_scripts\utility::flag_wait("enable_door_clip");
	thread enable_pod_door_clip(param_00);
}