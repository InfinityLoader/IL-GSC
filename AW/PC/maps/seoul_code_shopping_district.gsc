/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: seoul_code_shopping_district.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 233
 * Decompile Time: 3402 ms
 * Timestamp: 4/22/2024 2:36:53 AM
*******************************************************************/

//Function Number: 1
shopping_district_main()
{
	init_flags_shopping_district();
	precacheitem("smoke_grenade_cheap");
	precacheitem("iw5_microdronelaunchersmartgrenade_sp");
	precacheturret("apache_turret");
	precacheshader("ugv_vignette_overlay");
	precachemodel("prop_cigarette");
	precachemodel("electronics_pda");
	precachemodel("lab_tablet_flat_on");
	precachemodel("com_cellphone_on");
	thread sinkhole_section();
	thread subway_section();
	thread sd_street_combat();
	thread sd_smoke_laser_ambush();
	thread sd_flee_drone_swarm();
	thread canal_setup_pt1();
	thread canal_cormack_objective_convo();
	thread canal_fight_to_explosives_sequence();
	thread canal_handle_bomb_pickup();
	thread canal_fight_to_weapon_platform();
	thread canal_handle_bomb_plant_start();
	thread canal_finale_will_prep();
	thread canal_finale_sequence();
	vehicle_scripts\_attack_drone_controllable::controllable_drone_swarm_init();
	maps\_microdronelauncher::init();
	thread panel_on();
	maps\_utility::add_hint_string("throw_threat_hint",&"SEOUL_THROW_THREAT_HINT",::should_break_threat_hint);
	maps\_utility::add_control_based_hint_strings("binoc_controls",&"SEOUL_BINOC_CONTROLS_HINT",::binoc_hint_breakout,&"SEOUL_BINOC_CONTROLS_HINT_PC",&"SEOUL_BINOC_CONTROLS_HINT_SP");
	rumble_notetracks();
	var_00 = getentarray("seo_canal_waterfall_model","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setcontents(0);
	}
}

//Function Number: 2
rumble_notetracks()
{
	var_00 = [0.2,0.1,"wp_hatch_close"];
	maps\_anim::addnotetrack_customfunction("weapon_platform","seo_finale_wp_hatch_close",::seo_finale_rumble_heavy,"finale_plantbomb",var_00);
	var_00 = [2.25,1.5,"first_attempt_to_free"];
	maps\_anim::addnotetrack_customfunction("will_irons","seo_finale_will_first_attempt_to_free",::seo_finale_rumble_light,"finale_pt02",var_00);
	var_00 = [2.25,1.75,"second_attempt_to_free"];
	maps\_anim::addnotetrack_customfunction("will_irons","seo_finale_will_second_attempt",::seo_finale_rumble_light,"finale_pt02",var_00);
	var_00 = [0.1,0.5,"grabs player"];
	maps\_anim::addnotetrack_customfunction("will_irons","seo_finale_will_grabs_player",::seo_finale_rumble_light,"finale_pt02");
	var_00 = [0.1,0.5,"will_pushes_player"];
	maps\_anim::addnotetrack_customfunction("will_irons","seo_finale_will_pushes_player",::seo_finale_rumble_heavy,"finale_pt02",var_00);
	maps\_anim::addnotetrack_customfunction("player_rig","seo_finale_player_jump_onto_platform",::seo_finale_rumble_light,"finale_plantbomb");
	var_00 = [0.1,0.5,"player_grab_hatch"];
	maps\_anim::addnotetrack_customfunction("player_rig","seo_finale_player_grab_hatch",::seo_finale_rumble_light,"finale_pt02",var_00);
	maps\_anim::addnotetrack_customfunction("player_rig","seo_finale_player_lands",::seo_finale_rumble_heavy,"finale_pt02",0.5);
	maps\_anim::addnotetrack_customfunction("player_rig","seo_finale_player_bounces",::seo_finale_rumble_heavy,"finale_pt03",1);
	var_00 = [0.3,1,"player_arm_slice"];
	maps\_anim::addnotetrack_customfunction("player_rig","seo_finale_player_arm_slice",::seo_finale_rumble_heavy,"finale_pt03",var_00);
	var_00 = [5,2,"_dragged_away"];
	maps\_anim::addnotetrack_customfunction("player_rig","seo_finale_player_dragged_away",::seo_finale_rumble_light,"finale_pt03",var_00);
	var_00 = [1,1.5,"_dragged_away"];
	maps\_anim::addnotetrack_customfunction("cormack","seo_finale_cormack_grab_metal",::seo_finale_rumble_heavy,"finale_pt03");
	var_00 = [4,22,"wp_lift_off"];
	maps\_anim::addnotetrack_customfunction("weapon_platform","seo_finale_wp_lift_off",::seo_finale_rumble_heavy,"finale_pt02",var_00);
}

//Function Number: 3
init_flags_shopping_district()
{
	common_scripts\utility::flag_init("start_sinkhole_objectives");
	common_scripts\utility::flag_init("objective_sd_followed_cormack_through_sinkhole");
	common_scripts\utility::flag_init("objective_sd_smoke_ambush_defeated");
	common_scripts\utility::flag_init("objective_sd_followed_cormack_through_subway");
	common_scripts\utility::flag_init("objective_sd_gate_opened");
	common_scripts\utility::flag_init("objective_start_shopping_district");
	common_scripts\utility::flag_init("objective_sd_street_combat_complete");
	common_scripts\utility::flag_init("objective_canal_stairs_bottom_reached");
	common_scripts\utility::flag_init("objective_canal_stairs_top_reached");
	common_scripts\utility::flag_init("objective_sd_cormack_convo_complete");
	common_scripts\utility::flag_init("objective_sd_reached_bombsquad");
	common_scripts\utility::flag_init("objective_sd_pick_up_bombs");
	common_scripts\utility::flag_init("objective_sd_bomb_planted");
	common_scripts\utility::flag_init("end_rumble_listener");
	common_scripts\utility::flag_init("first_building_jump_complete");
	common_scripts\utility::flag_init("wakeup_drones");
	common_scripts\utility::flag_init("wakeup_ambush");
	common_scripts\utility::flag_init("swarm_flyby1_ready");
	common_scripts\utility::flag_init("subway_gate_triggered");
	common_scripts\utility::flag_init("swarm_flyby1_go");
	common_scripts\utility::flag_init("canal_strategy_scene_complete");
	common_scripts\utility::flag_init("sd_street_combat_complete");
	common_scripts\utility::flag_init("shut_down_panel");
	common_scripts\utility::flag_init("canal_jump_complete");
	common_scripts\utility::flag_init("bombs_reached");
	common_scripts\utility::flag_init("bombs_picked_up");
	common_scripts\utility::flag_init("drone_control_done");
	common_scripts\utility::flag_init("bomb_plant_start");
	common_scripts\utility::flag_init("threat_grenade_thrown");
	common_scripts\utility::flag_init("wakeup_patrol");
	common_scripts\utility::flag_init("sd_combat_start");
	common_scripts\utility::flag_init("canal_reached_window");
	common_scripts\utility::flag_init("wakeup_drone_guards");
	common_scripts\utility::flag_init("wakeup_canal_patrols");
	common_scripts\utility::flag_init("begin_fight_to_weapon_platform");
	common_scripts\utility::flag_init("start_truck_fall");
	common_scripts\utility::flag_init("demo_team_seen");
	common_scripts\utility::flag_init("drone_swarm_launched");
	common_scripts\utility::flag_init("canal_start_drone_travel");
	common_scripts\utility::flag_init("spawn_canal_razorback");
	common_scripts\utility::flag_init("canal_razorback_attacked");
	common_scripts\utility::flag_init("start_weapon_platform_firing");
	common_scripts\utility::flag_init("prep_will_for_finale");
	common_scripts\utility::flag_init("weapon_platform_firing");
	common_scripts\utility::flag_init("show_canal_weapon_platform");
	common_scripts\utility::flag_init("canal_razorback_fire_at_swarm");
	common_scripts\utility::flag_init("cleanup_finale_explosive");
	common_scripts\utility::flag_init("canal_swarm_attacking_player");
	common_scripts\utility::flag_init("middle_weapon_guards_dead");
	common_scripts\utility::flag_init("_stealth_spotted");
	common_scripts\utility::flag_init("drones_investigating");
	common_scripts\utility::flag_init("player_starting_sinkhole");
}

//Function Number: 4
debug_seoul_sinkhole_start()
{
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	soundscripts\_snd::snd_message("start_seoul_sinkhole_start");
	debug_check_allies_spawned();
	var_00 = common_scripts\utility::getstruct("struct_start_point_sinkhole_start","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_start_point_sinkhole_start_1","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player maps\_player_high_jump::enable_high_jump();
	level.player lightsetforplayer("seoul_building_jump");
	level.player setclutforplayer("seoul",0);
	maps\_utility::vision_set_fog_changes("seoul_building_jump",0);
	common_scripts\utility::flag_set("set_seoul_jump_lighting");
	level.will_irons forceteleport(var_01[0].origin,var_01[0].angles);
	level.cormack forceteleport(var_01[1].origin,var_01[1].angles);
	level.jackson forceteleport(var_01[2].origin,var_01[2].angles);
	var_02 = getnode("cover_sinkhole_window","targetname");
	var_03 = getnode("cover_sinkhole_jumpdown1","targetname");
	var_04 = getnode("cover_sinkhole_jumpdown2","targetname");
	level.will_irons maps\_utility::set_goal_radius(15);
	level.will_irons maps\_utility::set_goal_node(var_02);
	level.cormack maps\_utility::set_goal_radius(15);
	level.cormack maps\_utility::set_goal_node(var_03);
	level.jackson maps\_utility::set_goal_radius(15);
	level.jackson maps\_utility::set_goal_node(var_04);
	var_05 = getent("trig_start_sinkhole_section","targetname");
	common_scripts\utility::flag_set("first_building_jump_complete");
	common_scripts\utility::flag_set("objective_start");
	common_scripts\utility::flag_set("start_sinkhole_objectives");
	common_scripts\utility::flag_set("objective_sd_street_combat_complete");
	var_05 notify("trigger");
}

//Function Number: 5
debug_seoul_subway_start()
{
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	soundscripts\_snd::snd_message("start_seoul_subway_start");
	thread maps\seoul_lighting::lighting_fx_lens_subway_interior();
	var_00 = getent("so_player_start_subway1","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player maps\_player_high_jump::enable_high_jump();
	debug_check_allies_spawned();
	var_01 = common_scripts\utility::getstruct("struct_will_start_subway1","targetname");
	level.will_irons forceteleport(var_01.origin,var_01.angles);
	var_02 = common_scripts\utility::getstruct("node_cormack_start_subway1","targetname");
	level.cormack forceteleport(var_02.origin,var_02.angles);
	var_03 = common_scripts\utility::getstruct("struct_other_guy_start_subway1","targetname");
	level.jackson forceteleport(var_03.origin,var_03.angles);
	common_scripts\utility::flag_set("objective_start");
	common_scripts\utility::flag_set("start_sinkhole_objectives");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_sinkhole");
	common_scripts\utility::flag_set("objective_sd_smoke_ambush_defeated");
	common_scripts\utility::flag_set("set_seoul_subway_start_lighting");
	var_04 = getent("trig_start_subway_section","targetname");
	var_04 notify("trigger");
}

//Function Number: 6
debug_seoul_shopping_district_start()
{
	if(level.currentgen)
	{
		level waittill("transients_subway_to_shopping_dist");
	}

	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	soundscripts\_snd::snd_message("start_seoul_shopping_district_start");
	level.player lightsetforplayer("seoul_subway");
	level.player setclutforplayer("clut_seoul_shopping",0);
	maps\_utility::vision_set_fog_changes("seoul_shopping",0);
	common_scripts\utility::flag_set("set_seoul_shopping_district_start_lighting");
	var_00 = getent("so_player_start_shopping_district1","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player maps\_player_high_jump::enable_high_jump();
	debug_check_allies_spawned();
	var_01 = common_scripts\utility::getstruct("struct_will_start_shopping_district1","targetname");
	level.will_irons forceteleport(var_01.origin,var_01.angles);
	var_02 = common_scripts\utility::getstruct("struct_cormack_start_shopping_district1","targetname");
	level.cormack forceteleport(var_02.origin,var_02.angles);
	var_03 = common_scripts\utility::getstruct("struct_other_guy_start_shopping_district1","targetname");
	level.jackson forceteleport(var_03.origin,var_03.angles);
	wait(1);
	common_scripts\utility::flag_set("objective_start");
	common_scripts\utility::flag_set("start_sinkhole_objectives");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_sinkhole");
	common_scripts\utility::flag_set("objective_sd_smoke_ambush_defeated");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_subway");
	common_scripts\utility::flag_set("objective_sd_gate_opened");
	common_scripts\utility::flag_set("objective_start_shopping_district");
}

//Function Number: 7
debug_seoul_shopping_district_flee_swarm()
{
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	soundscripts\_snd::snd_message("start_seoul_shopping_district_flee_swarm");
	common_scripts\utility::flag_set("set_seoul_shopping_district_start_lighting");
	thread maps\_utility::flag_set_delayed("sd_start_shopping_district",5);
	var_00 = getent("so_player_start_flee_swarm1","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player maps\_player_high_jump::enable_high_jump();
	debug_check_allies_spawned();
	var_01 = common_scripts\utility::getstruct("struct_will_start_flee_swarm1","targetname");
	level.will_irons forceteleport(var_01.origin,var_01.angles);
	var_02 = common_scripts\utility::getstruct("struct_cormack_start_flee_swarm1","targetname");
	level.cormack forceteleport(var_02.origin,var_02.angles);
	var_03 = common_scripts\utility::getstruct("struct_other_guy_start_flee_swarm1","targetname");
	level.jackson forceteleport(var_03.origin,var_03.angles);
	wait(1);
	common_scripts\utility::flag_set("objective_start");
	common_scripts\utility::flag_set("start_sinkhole_objectives");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_sinkhole");
	common_scripts\utility::flag_set("objective_sd_smoke_ambush_defeated");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_subway");
	common_scripts\utility::flag_set("objective_sd_gate_opened");
	common_scripts\utility::flag_set("objective_start_shopping_district");
	common_scripts\utility::flag_set("objective_sd_mid");
	common_scripts\utility::flag_set("objective_sd_intersection2");
	common_scripts\utility::flag_set("objective_sd_stairs");
	common_scripts\utility::flag_set("objective_sd_street_combat_complete");
	thread canal_weapon_platform_firing_loop();
	common_scripts\utility::flag_set("start_weapon_platform_firing");
}

//Function Number: 8
debug_seoul_canal_start()
{
	soundscripts\_snd::snd_message("start_seoul_canal_intro");
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	level.player maps\_player_high_jump::enable_high_jump();
	level.player lightsetforplayer("seoul_canal");
	level.player setclutforplayer("clut_seoul_canal",0);
	maps\_utility::vision_set_fog_changes("seoul_canal_entrance",0);
	common_scripts\utility::flag_set("set_seoul_canal_start_lighting");
	var_00 = getent("node_player_start_shopping_district2","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player maps\_player_high_jump::enable_high_jump();
	debug_check_allies_spawned();
	var_01 = common_scripts\utility::getstruct("struct_will_start_shopping_district2","targetname");
	level.will_irons forceteleport(var_01.origin,var_01.angles);
	var_02 = getnode("canal_cover_left_door1","targetname");
	level.will_irons maps\_utility::set_goal_node(var_02);
	var_03 = common_scripts\utility::getstruct("struct_cormack_start_shopping_district2","targetname");
	level.cormack forceteleport(var_03.origin,var_03.angles);
	var_04 = getnode("canal_cover_right_door1","targetname");
	level.cormack maps\_utility::set_goal_node(var_04);
	var_05 = common_scripts\utility::getstruct("struct_other_guy_start_shopping_district2","targetname");
	level.jackson forceteleport(var_05.origin,var_05.angles);
	var_06 = getnode("canal_cover_crouch_door1","targetname");
	level.jackson maps\_utility::set_goal_node(var_06);
	common_scripts\utility::flag_set("sd_street_combat_complete");
	common_scripts\utility::flag_set("sd_escaped_swarm");
	common_scripts\utility::flag_set("show_canal_weapon_platform");
	common_scripts\utility::flag_set("objective_start");
	common_scripts\utility::flag_set("start_sinkhole_objectives");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_sinkhole");
	common_scripts\utility::flag_set("objective_sd_smoke_ambush_defeated");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_subway");
	common_scripts\utility::flag_set("objective_sd_gate_opened");
	common_scripts\utility::flag_set("objective_start_shopping_district");
	common_scripts\utility::flag_set("objective_sd_mid");
	common_scripts\utility::flag_set("objective_sd_intersection2");
	common_scripts\utility::flag_set("objective_sd_stairs");
	common_scripts\utility::flag_set("objective_sd_street_combat_complete");
	common_scripts\utility::flag_set("objective_canal_stairs_bottom_reached");
	common_scripts\utility::flag_set("objective_canal_stairs_top_reached");
	common_scripts\utility::flag_set("objective_sd_cormack_convo_complete");
	var_07 = getent("canal_trig_allies_cover1","targetname");
	var_07 notify("trigger");
	if(level.nextgen)
	{
		level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("sd_drone_queen1",undefined);
	}
	else
	{
		level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("sd_drone_queen1",undefined,8,5,undefined);
	}

	level.snake_cloud thread canal_drone_swarm_think();
	thread canal_weapon_platform_firing_loop();
	common_scripts\utility::flag_set("start_weapon_platform_firing");
}

//Function Number: 9
debug_seoul_canal_begin_combat()
{
	soundscripts\_snd::snd_message("start_seoul_canal_combat_start");
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	level.player lightsetforplayer("seoul_canal");
	level.player setclutforplayer("clut_seoul_canal",0);
	maps\_utility::vision_set_fog_changes("seoul_canal_entrance",0);
	common_scripts\utility::flag_set("set_seoul_canal_start_lighting");
	var_00 = getent("node_player_start_shopping_district2","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player maps\_player_high_jump::enable_high_jump();
	debug_check_allies_spawned();
	var_01 = common_scripts\utility::getstruct("struct_will_start_shopping_district2","targetname");
	level.will_irons forceteleport(var_01.origin,var_01.angles);
	var_02 = common_scripts\utility::getstruct("struct_cormack_start_shopping_district2","targetname");
	level.cormack forceteleport(var_02.origin,var_02.angles);
	var_03 = common_scripts\utility::getstruct("struct_other_guy_start_shopping_district2","targetname");
	level.jackson forceteleport(var_03.origin,var_03.angles);
	common_scripts\utility::flag_set("sd_street_combat_complete");
	common_scripts\utility::flag_set("canal_strategy_scene_complete");
	common_scripts\utility::flag_set("enable_drone_control_pickup");
	common_scripts\utility::flag_set("shut_down_panel");
	common_scripts\utility::flag_set("show_canal_weapon_platform");
	common_scripts\utility::flag_set("objective_start");
	common_scripts\utility::flag_set("start_sinkhole_objectives");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_sinkhole");
	common_scripts\utility::flag_set("objective_sd_smoke_ambush_defeated");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_subway");
	common_scripts\utility::flag_set("objective_sd_gate_opened");
	common_scripts\utility::flag_set("objective_start_shopping_district");
	common_scripts\utility::flag_set("objective_sd_mid");
	common_scripts\utility::flag_set("objective_sd_intersection2");
	common_scripts\utility::flag_set("objective_sd_stairs");
	common_scripts\utility::flag_set("objective_sd_street_combat_complete");
	common_scripts\utility::flag_set("objective_canal_stairs_bottom_reached");
	common_scripts\utility::flag_set("objective_canal_stairs_top_reached");
	common_scripts\utility::flag_set("objective_sd_cormack_convo_complete");
	common_scripts\utility::flag_set("demo_team_seen");
	level.player maps\_shg_utility::setup_player_for_scene();
	maps\_player_exo::player_exo_deactivate();
	if(level.nextgen)
	{
		level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("sd_drone_queen1",undefined);
	}
	else
	{
		level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("sd_drone_queen1",undefined,8,6,undefined);
	}

	level.snake_cloud thread canal_drone_swarm_think();
	thread canal_weapon_platform_firing_loop();
	common_scripts\utility::flag_set("start_weapon_platform_firing");
	level.will_irons.ignoreall = 0;
	level.cormack.ignoreall = 0;
	level.jackson.ignoreall = 0;
}

//Function Number: 10
debug_seoul_canal_fight_to_weapon_platform()
{
	soundscripts\_snd::snd_message("start_seoul_canal_combat_start");
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	level.player lightsetforplayer("seoul_canal");
	level.player setclutforplayer("clut_seoul_canal",0);
	maps\_utility::vision_set_fog_changes("seoul_canal_entrance",0);
	common_scripts\utility::flag_set("set_seoul_canal_start_lighting");
	var_00 = getent("node_player_start_canal_part2","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player maps\_player_high_jump::enable_high_jump();
	debug_check_allies_spawned();
	var_01 = common_scripts\utility::getstruct("struct_will_start_canal_part2","targetname");
	level.will_irons forceteleport(var_01.origin,var_01.angles);
	var_02 = common_scripts\utility::getstruct("struct_cormack_start_shopping_district2","targetname");
	level.cormack forceteleport(var_02.origin,var_02.angles);
	var_03 = common_scripts\utility::getstruct("struct_other_guy_start_shopping_district2","targetname");
	level.jackson forceteleport(var_03.origin,var_03.angles);
	thread canal_weapon_guards_spawn_and_think();
	thread canal_weapon_platform_firing_loop();
	common_scripts\utility::flag_set("canal_strategy_scene_complete");
	common_scripts\utility::flag_set("enable_drone_control_pickup");
	common_scripts\utility::flag_set("bombs_picked_up");
	common_scripts\utility::flag_set("show_canal_weapon_platform");
	common_scripts\utility::flag_set("objective_start");
	common_scripts\utility::flag_set("start_sinkhole_objectives");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_sinkhole");
	common_scripts\utility::flag_set("objective_sd_smoke_ambush_defeated");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_subway");
	common_scripts\utility::flag_set("objective_sd_gate_opened");
	common_scripts\utility::flag_set("objective_start_shopping_district");
	common_scripts\utility::flag_set("objective_sd_mid");
	common_scripts\utility::flag_set("objective_sd_intersection2");
	common_scripts\utility::flag_set("objective_sd_stairs");
	common_scripts\utility::flag_set("objective_sd_street_combat_complete");
	common_scripts\utility::flag_set("objective_canal_stairs_bottom_reached");
	common_scripts\utility::flag_set("objective_canal_stairs_top_reached");
	common_scripts\utility::flag_set("objective_sd_cormack_convo_complete");
	common_scripts\utility::flag_set("demo_team_seen");
	common_scripts\utility::flag_set("objective_sd_pick_up_bombs");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	maps\_player_exo::player_exo_deactivate();
	if(level.nextgen)
	{
		level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("sd_drone_queen1",undefined);
	}
	else
	{
		level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("sd_drone_queen1",undefined,8,6,undefined);
	}

	level.snake_cloud thread canal_drone_swarm_think();
	common_scripts\utility::flag_set("start_weapon_platform_firing");
}

//Function Number: 11
debug_seoul_finale_scene_start()
{
	soundscripts\_snd::snd_message("start_seoul_finale_scene_start");
	thread maps\seoul_lighting::outerspacelighting_checkpoint();
	thread maps\seoul_lighting::canal_wmp_key_tweaks();
	level.player lightsetforplayer("seoul_canal");
	level.player setclutforplayer("clut_seoul_canal",0);
	maps\_utility::vision_set_fog_changes("seoul_canal_entrance",0);
	common_scripts\utility::flag_set("set_seoul_canal_start_lighting");
	var_00 = common_scripts\utility::getstruct("struct_start_finale_player","targetname");
	level.player maps\_utility::teleport_player(var_00);
	level.player maps\_player_high_jump::enable_high_jump();
	debug_check_allies_spawned();
	var_01 = common_scripts\utility::getstruct("struct_start_finale_will","targetname");
	level.will_irons forceteleport(var_01.origin,var_01.angles);
	var_02 = common_scripts\utility::getstruct("struct_start_canal2_cormack","targetname");
	level.cormack forceteleport(var_02.origin,var_02.angles);
	var_03 = common_scripts\utility::getstruct("struct_start_canal2_jackson","targetname");
	level.jackson forceteleport(var_03.origin,var_03.angles);
	common_scripts\utility::flag_set("objective_sd_bomb_planted");
	common_scripts\utility::flag_set("prep_will_for_finale");
	common_scripts\utility::flag_set("show_canal_weapon_platform");
	var_04 = getent("trig_canal_near_platform","targetname");
	var_04 notify("trigger");
	level.weapon_platform_rigged = getent("canal_weapon_platform","targetname");
	level.weapon_platform_rigged.animname = "weapon_platform";
	level.weapon_platform_rigged maps\_anim::setanimtree();
}

//Function Number: 12
debug_check_allies_spawned()
{
	if(!isdefined(level.will_irons))
	{
		var_00 = getent("hero_will_irons_spawner","targetname");
		level.will_irons = var_00 maps\_shg_design_tools::actual_spawn();
	}

	level.will_irons notify("stop_going_to_node");
	level.will_irons.target = undefined;
	level.will_irons.a.disablepain = 1;
	level.will_irons.canjumppath = 1;
	if(!isdefined(level.will_irons.magic_bullet_shield) || !level.will_irons.magic_bullet_shield)
	{
		level.will_irons thread maps\_utility::deletable_magic_bullet_shield();
	}

	level.will_irons maps\_utility::set_force_color("o");
	level.will_irons.animname = "will_irons";
	if(!isdefined(level.cormack))
	{
		var_01 = getent("hero_cormack_spawner","targetname");
		wait(0.05);
		level.cormack = var_01 maps\_shg_design_tools::actual_spawn();
	}

	level.cormack notify("stop_going_to_node");
	level.cormack.target = undefined;
	level.cormack.a.disablepain = 1;
	if(!isdefined(level.cormack.magic_bullet_shield) || !level.cormack.magic_bullet_shield)
	{
		level.cormack thread maps\_utility::deletable_magic_bullet_shield();
	}

	level.cormack maps\_utility::set_force_color("r");
	level.cormack.animname = "cormack";
	level.cormack.canjumppath = 1;
	if(!isdefined(level.jackson))
	{
		var_00 = getent("hero_guy_spawner","targetname");
		level.jackson = var_00 maps\_shg_design_tools::actual_spawn();
	}

	level.jackson notify("stop_going_to_node");
	level.jackson.target = undefined;
	level.jackson.a.disablepain = 1;
	if(!isdefined(level.jackson.magic_bullet_shield) || !level.jackson.magic_bullet_shield)
	{
		level.jackson thread maps\_utility::deletable_magic_bullet_shield();
	}

	level.jackson maps\_utility::set_force_color("y");
	level.jackson setthreatbiasgroup("allies");
	level.jackson.animname = "jackson";
	level.jackson.canjumppath = 1;
}

//Function Number: 13
shopping_district_objectives()
{
	common_scripts\utility::flag_wait("start_sinkhole_objectives");
	objective_add(maps\_utility::obj("objective_demo_team"),"current",&"SEOUL_OBJECTIVE_DEMO_TEAM");
	objective_onentity(maps\_utility::obj("objective_demo_team"),level.cormack);
	common_scripts\utility::flag_wait("objective_sd_followed_cormack_through_sinkhole");
	var_00 = getent("objective_sd_origin_cormack","targetname");
	var_01 = getent("objective_sinkhole_ambush","targetname");
	objective_position(maps\_utility::obj("objective_demo_team"),var_01.origin);
	common_scripts\utility::flag_wait("objective_sd_smoke_ambush_defeated");
	objective_onentity(maps\_utility::obj("objective_demo_team"),level.cormack);
	common_scripts\utility::flag_wait("objective_sd_followed_cormack_through_subway");
	var_02 = getent("subway_open_gate","targetname");
	objective_setpointertextoverride(maps\_utility::obj("objective_demo_team"),&"SEOUL_OBJECTIVE_GATE_INT");
	objective_position(maps\_utility::obj("objective_demo_team"),var_02.origin);
	common_scripts\utility::flag_wait("objective_sd_gate_opened");
	objective_position(maps\_utility::obj("objective_demo_team"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("objective_demo_team"),"");
	common_scripts\utility::flag_wait("objective_start_shopping_district");
	var_03 = getent("objective_sd_origin_intersection1","targetname");
	var_04 = getent("objective_sd_origin_mid","targetname");
	var_05 = getent("objective_sd_origin_intersection2","targetname");
	var_06 = getent("objective_sd_origin_stairs","targetname");
	var_00 = getent("objective_sd_origin_cormack","targetname");
	objective_position(maps\_utility::obj("objective_demo_team"),var_03.origin);
	common_scripts\utility::flag_wait("objective_sd_mid");
	objective_position(maps\_utility::obj("objective_demo_team"),var_04.origin);
	common_scripts\utility::flag_wait("objective_sd_intersection2");
	objective_position(maps\_utility::obj("objective_demo_team"),var_05.origin);
	common_scripts\utility::flag_wait("objective_sd_stairs");
	objective_position(maps\_utility::obj("objective_demo_team"),var_06.origin);
	common_scripts\utility::flag_wait("objective_sd_street_combat_complete");
	var_07 = getent("objective_sd_origin_cormack","targetname");
	var_08 = getent("objective_sd_origin_stairs_bottom","targetname");
	var_09 = getent("objective_sd_origin_stairs_top","targetname");
	objective_position(maps\_utility::obj("objective_demo_team"),var_08.origin);
	common_scripts\utility::flag_wait("objective_canal_stairs_bottom_reached");
	objective_position(maps\_utility::obj("objective_demo_team"),var_09.origin);
	common_scripts\utility::flag_wait("objective_canal_stairs_top_reached");
	objective_position(maps\_utility::obj("objective_demo_team"),var_07.origin);
	common_scripts\utility::flag_wait("objective_sd_cormack_convo_complete");
	maps\_utility::objective_complete(maps\_utility::obj("objective_demo_team"));
	common_scripts\utility::flag_wait("demo_team_seen");
	var_0A = getent("objective_sd_origin_bombs","targetname");
	objective_add(maps\_utility::obj("objective_bombs"),"current",&"SEOUL_OBJECTIVE_EXPLOSIVES");
	objective_position(maps\_utility::obj("objective_bombs"),var_0A.origin);
	objective_setpointertextoverride(maps\_utility::obj("objective_bombs")," ");
	common_scripts\utility::flag_wait("bombs_reached");
	objective_setpointertextoverride(maps\_utility::obj("objective_bombs"),&"SEOUL_OBJECTIVE_EXPLOSIVES_INT");
	common_scripts\utility::flag_wait("objective_sd_pick_up_bombs");
	maps\_utility::objective_complete(maps\_utility::obj("objective_bombs"));
	var_0B = getent("objective_sd_origin_bomb","targetname");
	var_0C = getent("objective_sd_origin_bomb_a","targetname");
	setsaveddvar("objectiveAlphaEnabled",1);
	objective_add(maps\_utility::obj("objective_follow_will"),"current",&"SEOUL_OBJECTIVE_HELP_WILL");
	objective_onentity(maps\_utility::obj("objective_follow_will"),level.will_irons);
	common_scripts\utility::flag_wait("canal_bomb_plant_trigger_on");
	common_scripts\utility::flag_wait("weapon_platform_reached");
	maps\_utility::objective_complete(maps\_utility::obj("objective_follow_will"));
	setsaveddvar("objectiveAlphaEnabled",0);
	objective_add(maps\_utility::obj("objective_plant_explosives"),"current",&"SEOUL_OBJECTIVE_USE_EXPLOSIVES");
	objective_position(maps\_utility::obj("objective_plant_explosives"),var_0B.origin);
	common_scripts\utility::flag_wait("objective_sd_bomb_planted");
	maps\_utility::objective_complete(maps\_utility::obj("objective_plant_explosives"));
}

//Function Number: 14
sinkhole_section()
{
	thread maps\seoul_code_gangnam::handle_wep_drone_dropoff();
	thread sinkhole_drone_intro();
	thread maps\seoul_code_gangnam::handle_sinkhole_enemy_setup();
	thread handle_sinkhole_video_log();
	thread sinkhole_subway_vo_think();
	thread sinkhole_weapons_platform_scene();
	thread sinkhole_smoke_ambush_event();
	thread sinkhole_weapon_platform();
	thread sinkhole_jets();
	thread sign_explosion_flash_damage();
	common_scripts\utility::flag_wait("first_building_jump_complete");
	common_scripts\utility::flag_set("start_sinkhole_objectives");
	if(!isdefined(level.cormack.script_forcecolor))
	{
		level.cormack maps\_utility::set_force_color("r");
	}

	if(!isdefined(level.will_irons.script_forcecolor))
	{
		level.will_irons maps\_utility::set_force_color("o");
	}

	if(!isdefined(level.jackson.script_forcecolor))
	{
		level.jackson maps\_utility::set_force_color("y");
	}

	level.will_irons.canjumppath = 1;
	level.cormack.canjumppath = 1;
	level.jackson.canjumppath = 1;
	maps\_shg_design_tools::waittill_trigger_with_name("trig_sinkhole_ai_move_to_jump1");
	var_00 = common_scripts\utility::getstructarray("struct_start_point_sinkhole_start_1","targetname");
	warp_allies_forward_sinkhole();
	level.will_irons.ignoreall = 1;
	level.jackson.ignoreall = 1;
	level.cormack.ignoreall = 1;
	var_01 = getnode("cover_sinkhole_window","targetname");
	var_02 = getnode("cover_sinkhole_jumpdown1","targetname");
	var_03 = getnode("cover_sinkhole_jumpdown2","targetname");
	level.will_irons maps\_utility::set_goal_radius(15);
	level.will_irons maps\_utility::set_goal_node(var_01);
	level.cormack maps\_utility::set_goal_radius(15);
	level.cormack maps\_utility::set_goal_node(var_02);
	level.jackson maps\_utility::set_goal_radius(15);
	level.jackson maps\_utility::set_goal_node(var_03);
	maps\_shg_design_tools::waittill_trigger_with_name("sinkhole_trig_allies_jump1");
	common_scripts\utility::flag_set("vo_sinkhole_view");
	maps\_utility::autosave_by_name();
}

//Function Number: 15
sinkhole_weapons_platform_scene()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_sinkhole_launcher_vo");
	common_scripts\utility::flag_set("vo_will_wep_nineoclock");
	level.cormack pushplayer(1);
	level.player.show_land_assist_help = 0;
	common_scripts\utility::flag_wait("vo_havoc_launcher_done");
	wait(1);
	maps\_utility::activate_trigger_with_targetname("sinkhole_trig_allies_jump1");
	level.player.show_land_assist_help = 1;
	wait(10);
	level.cormack pushplayer(0);
}

//Function Number: 16
handle_sinkhole_video_log()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_sinkhole_1st_drop");
	common_scripts\utility::flag_set("video_log_playing");
	common_scripts\utility::flag_wait("vo_havoc_launcher_done");
	wait(1);
	common_scripts\utility::flag_set("dialogue_performing_arts_entrance_2");
	maps\seoul_code_gangnam::prep_cinematic("seoul_videolog");
	maps\seoul_code_gangnam::play_seoul_videolog();
	wait(1);
	maps\seoul::ingame_movies();
	maps\_utility::activate_trigger_with_targetname("trig_videolog_over_sinkhole");
}

//Function Number: 17
sinkhole_subway_vo_think()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_sinkhole_subway_car_vo");
	common_scripts\utility::flag_set("vo_subway_car_start");
}

//Function Number: 18
warp_allies_forward_sinkhole()
{
	if(!isdefined(level.cormack.building_jump_initiate))
	{
		level.cormack prepare_to_teleport();
		level.cormack teleport_to_struct("jump_cormack_moveto");
	}
	else
	{
		level.cormack thread speed_up_building_jump_anim();
	}

	if(!isdefined(level.will_irons.building_jump_initiate))
	{
		level.will_irons prepare_to_teleport();
		level.will_irons teleport_to_struct("jump_will_irons_moveto");
	}
	else
	{
		level.will_irons thread speed_up_building_jump_anim();
	}

	common_scripts\utility::flag_set("player_starting_sinkhole");
}

//Function Number: 19
speed_up_building_jump_anim()
{
	maps\_utility::set_moveplaybackrate(1.75);
	while(!isdefined(self.building_jump_done))
	{
		wait 0.05;
	}

	maps\_utility::set_moveplaybackrate(1);
}

//Function Number: 20
teleport_to_struct(param_00)
{
	var_01 = common_scripts\utility::getstruct(param_00,"targetname");
	self forceteleport(var_01.origin,var_01.angles);
}

//Function Number: 21
prepare_to_teleport()
{
	self notify("goal");
	self notify("new_anim_reach");
	self notify("warping");
	maps\_shg_design_tools::anim_stop();
}

//Function Number: 22
sinkhole_drone_intro()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_sinkhole_enemy_setup");
	wait(randomfloat(1.5));
	var_00 = getentarray("sinkhole_drones_intro","script_noteworthy");
	maps\_utility::array_spawn_function(var_00,::sd_drone_patrol_think);
	level.sinkhole_drones = maps\_utility::array_spawn(var_00);
	soundscripts\_snd::snd_message("sinkhole_drones_start",level.sinkhole_drones);
	common_scripts\utility::flag_set("vo_sinkhole_first_drones");
}

//Function Number: 23
sinkhole_drones_group2()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_sinkhole_drones_01");
	var_00 = getentarray("sinkhole_drones_01","script_noteworthy");
	var_01 = maps\_utility::array_spawn_noteworthy("sinkhole_drones_01");
	maps\_utility::array_removedead(level.sinkhole_drones);
	level.sinkhole_drones = maps\_utility::array_merge(level.sinkhole_drones,var_01);
	foreach(var_03 in var_01)
	{
		var_03.health = 50;
		var_03.target = undefined;
		var_03 setcandamage(1);
		var_03 makeentitysentient(var_03.script_team);
		var_03 thread maps\seoul_fx::drone_spot_light(var_03);
	}

	wait(1);
	foreach(var_03 in var_01)
	{
		var_03 maps\_utility::vehicle_detachfrompath();
		var_03 thread vehicle_scripts\_pdrone::flying_attack_drone_logic();
	}
}

//Function Number: 24
sinkhole_jets()
{
	common_scripts\utility::flag_wait("sinkhole_jet_flyby");
	var_00 = getentarray("shrike_flyby_spawner","targetname");
	foreach(var_02 in var_00)
	{
		var_02 maps\_vehicle::spawn_vehicle_and_gopath();
	}

	wait(2.1);
	common_scripts\utility::flag_set("start_truck_fall");
}

//Function Number: 25
sinkhole_drones_attack_civilians()
{
	createthreatbiasgroup("civ_victims");
	createthreatbiasgroup("drones_attacking_civs");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_sinkhole_drones_attack_civs");
	level.civ_victims = [];
	var_00 = maps\_utility::spawn_targetname("civ_sinkhole_victim1");
	var_01 = maps\_utility::spawn_targetname("civ_sinkhole_victim2");
	var_00.team = "allies";
	var_01.team = "allies";
	level.civ_victims[level.civ_victims.size] = var_00;
	level.civ_victims[level.civ_victims.size] = var_01;
	wait(0.5);
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname("civ_sinkhole_attack_drone1");
	var_03 = maps\_vehicle::spawn_vehicle_from_targetname("civ_sinkhole_attack_drone2");
	var_02.health = 50;
	var_03.health = 50;
	var_02 thread maps\seoul_fx::drone_spot_light(var_02);
	var_03 thread maps\seoul_fx::drone_spot_light(var_03);
	var_02 thread vehicle_scripts\_pdrone::flying_attack_drone_logic();
	var_03 thread vehicle_scripts\_pdrone::flying_attack_drone_logic();
	var_02.favoriteenemy = var_00;
	var_03.favoriteenemy = var_01;
	while(level.civ_victims.size > 0)
	{
		level.civ_victims = maps\_utility::array_removedead_or_dying(level.civ_victims);
		wait(0.05);
	}

	if(isalive(var_02))
	{
		var_02 thread sd_drone_patrol_think();
	}

	if(isalive(var_03))
	{
		var_03 thread sd_drone_patrol_think();
	}
}

//Function Number: 26
sinkhole_civ_vicitim_group()
{
	self setthreatbiasgroup("civ_victims");
	self.team = "allies";
}

//Function Number: 27
sinkhole_spawn_attack_drones()
{
}

//Function Number: 28
sinkhole_drones_group4_spawn()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_sinkhole_drones_group4");
	var_00 = getent("sinkhole_drones_group4","script_noteworthy");
	maps\_utility::array_spawn_function(var_00,::sd_drone_patrol_think);
	maps\_utility::array_removedead(level.sinkhole_drones);
	level.sinkhole_drones = maps\_utility::array_merge(level.sinkhole_drones,var_00);
}

//Function Number: 29
sinkhole_make_piece_fall(param_00,param_01,param_02,param_03)
{
	param_00 = param_00 * randomfloatrange(0.1,0.135);
	var_04 = undefined;
	if(isdefined(param_02) && isdefined(self.targetname) & !issubstr(self.targetname,param_03))
	{
		param_02 = sortbydistance(param_02,self.origin);
		var_04 = param_02[0];
	}

	wait(param_00);
	var_05 = 6;
	var_06 = 100;
	var_07 = 100;
	var_08 = 1200;
	var_09 = self.origin - (0,0,var_08);
	var_0A = self.origin[2];
	var_0B = vectortoangles((param_01.origin[0],param_01.origin[1],var_0A) - self.origin);
	var_0C = self.origin + anglestoforward(var_0B) * 200;
	while(isdefined(level.player.player_tank) && distance(level.player.player_tank.origin,self.origin) < 200)
	{
		wait(0.05);
	}

	var_0D = gettime() * 0.001;
	if(isdefined(var_04))
	{
		var_04 thread maps\_utility::delaythread(0.1,::maps\_shg_design_tools::delete_auto);
	}

	while(gettime() * 0.001 <= var_0D + var_05)
	{
		var_0E = self.origin + maps\_shg_design_tools::gravity_point(var_0D,var_09,var_07);
		var_0F = (0,vectortoangles(param_01.origin - var_0E)[1],0);
		var_10 = 3;
		var_11 = (var_10,var_0F[1],0);
		var_12 = transformmove(var_0E,var_11,var_0E,var_0F,var_0E,self.angles);
		self.origin = var_12["origin"];
		self.angles = var_12["angles"];
		wait(0.05);
	}
}

//Function Number: 30
sinkhole_fracture(param_00,param_01)
{
	param_00 = sortbydistance(param_00,param_01.origin);
	foreach(var_04, var_03 in param_00)
	{
		var_03 thread sinkhole_make_piece_break(var_04,param_01);
	}
}

//Function Number: 31
sinkhole_make_piece_break_and_sink(param_00,param_01)
{
	wait(param_00 * 0.005);
	var_02 = randomintrange(3,5);
	var_03 = param_00 + 1;
	if(common_scripts\utility::cointoss())
	{
		for(var_04 = 0;var_04 < var_02;var_04++)
		{
			if(distance(level.player.player_tank.origin,self.origin) < 300)
			{
				return;
			}

			var_05 = (0,vectortoangles(param_01.origin - self.origin)[1],0);
			var_06 = 1;
			var_07 = (var_06,var_05[1],0);
			var_08 = transformmove(self.origin,var_07,self.origin,var_05,self.origin,self.angles);
			var_09 = max(64 - var_03 / 3,randomint(10)) * -1;
			var_0A = (var_08["origin"][0],var_08["origin"][1],var_08["origin"][2] + var_09);
			var_0B = randomfloatrange(-2,2);
			var_0C = randomfloatrange(-2,2);
			var_0D = randomfloatrange(-2,2);
			if(common_scripts\utility::cointoss())
			{
				var_0D = randomfloatrange(-8,8);
			}

			thread maps\_shg_design_tools::lerp_to_position(var_0A,140);
			self.angles = var_08["angles"] + (var_0B,var_0C,var_0D);
			wait(0.05);
		}
	}
}

//Function Number: 32
sinkhole_make_piece_break(param_00,param_01)
{
	wait(param_00 * 0.01);
	var_02 = randomintrange(3,5);
	var_03 = param_00 + 1;
	if(common_scripts\utility::cointoss())
	{
		for(var_04 = 0;var_04 < var_02;var_04++)
		{
			if(distance(level.player.origin,self.origin) < 20)
			{
				return;
			}

			var_05 = (0,vectortoangles(param_01.origin - self.origin)[1],0);
			var_06 = 0.5;
			var_07 = (var_06,var_05[1],0);
			var_08 = transformmove(self.origin,var_07,self.origin,var_05,self.origin,self.angles);
			var_09 = (var_08["origin"][0],var_08["origin"][1],var_08["origin"][2]);
			var_0A = randomfloatrange(-0.75,0.75);
			var_0B = randomfloatrange(-0.75,0.75);
			var_0C = randomfloatrange(-0.75,0.75);
			if(common_scripts\utility::cointoss())
			{
				var_0C = randomfloatrange(-3,3);
			}

			thread maps\_shg_design_tools::lerp_to_position(var_09,80);
			self.angles = var_08["angles"] + (var_0A,var_0B,var_0C);
			wait(0.05);
		}
	}
}

//Function Number: 33
sinkhole_truck_fall_badly()
{
	var_00 = common_scripts\utility::getstruct(self.target,"targetname");
	var_01 = common_scripts\utility::getstruct(var_00.target,"targetname");
	var_02 = common_scripts\utility::getstruct("struct_sinkhole_center_2","targetname");
	var_03 = 600;
	maps\_shg_design_tools::lerp_to_position(var_00.origin,var_03);
	earthquake(0.2,1,level.player.origin,500);
	var_04 = 2;
	thread maps\_shg_design_tools::gravity_arc(self.origin,var_01.origin,var_04,900,900);
	thread sinkhole_crashed_truck_rotation();
	self waittill("item_landed");
	wait(0.05);
	self delete();
}

//Function Number: 34
sinkhole_crashed_truck_rotation()
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

//Function Number: 35
sinkhole_weapon_platform()
{
}

//Function Number: 36
sinkhole_smoke_ambush_event()
{
	maps\_utility::trigger_wait_targetname("trig_sinkhole_spawn_smoke_grenades");
	level.will_irons.ignoreall = 1;
	level.cormack.ignoreall = 1;
	level.jackson.ignoreall = 1;
	maps\_utility::autosave_by_name();
	thread sinkhole_smoke_grenade_loop();
	level.smoke_ambush_enemies = [];
	maps\_utility::array_spawn_function_noteworthy("sinkhole_smoke_ambush",::sinkhole_smoke_ambush_enemy_think);
	maps\_utility::array_spawn_noteworthy("sinkhole_smoke_ambush");
	wait(2);
	common_scripts\utility::flag_set("vo_subway_threat_moment");
	thread sinkhole_threat_hint();
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_sinkhole");
	common_scripts\utility::flag_wait("wakeup_ambush");
	level.will_irons.ignoreall = 0;
	level.cormack.ignoreall = 0;
	level.jackson.ignoreall = 0;
	while(level.smoke_ambush_enemies.size > 0)
	{
		level.smoke_ambush_enemies = maps\_utility::array_removedead_or_dying(level.smoke_ambush_enemies);
		wait 0.05;
	}

	common_scripts\utility::flag_set("vo_subway_threat_moment_clear");
	common_scripts\utility::flag_set("objective_sd_smoke_ambush_defeated");
	var_00 = getnode("subway_node_corner1","targetname");
	var_01 = getnode("subway_node_corner2","targetname");
	var_02 = getnode("subway_node_corner3","targetname");
	level.cormack maps\_utility::set_goal_node(var_00);
	level.will_irons maps\_utility::set_goal_node(var_01);
	level.jackson maps\_utility::set_goal_node(var_02);
}

//Function Number: 37
sinkhole_smoke_ambush_enemy_think()
{
	self endon("death");
	var_00 = getent("sinkhole_goal_smoke_ambush","targetname");
	self.ignoreall = 1;
	self setgoalvolumeauto(var_00);
	level.smoke_ambush_enemies[level.smoke_ambush_enemies.size] = self;
	self.grenadeammo = 0;
	thread sd_patrol1_player_close_check();
	self addaieventlistener("gunshot");
	self addaieventlistener("bulletwhizby");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"damage");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"ai_event");
	maps\_utility::add_func(::common_scripts\utility::flag_set,"wakeup_ambush");
	thread maps\_utility::do_wait_any();
	thread maps\_utility::flag_set_delayed("wakeup_ambush",4);
	common_scripts\utility::flag_wait("wakeup_ambush");
	self.ignoreall = 0;
	self notify("stop_going_to_node");
}

//Function Number: 38
sinkhole_smoke_grenade_loop()
{
	var_00 = getent("sinkhole_origin_grenade_throw","targetname");
	var_01 = getentarray("sinkhole_origin_grenade_targets","script_noteworthy");
	for(var_02 = 0;var_02 < 2;var_02++)
	{
		if(!common_scripts\utility::flag("wakeup_ambush"))
		{
			foreach(var_04 in var_01)
			{
				magicgrenade("smoke_grenade_cheap",var_04.origin,var_04.origin + (0,2,0),1);
				soundscripts\_snd::snd_message("seo_smoke_grenade_ambush",var_04.origin + (0,2,0),1);
			}

			wait(11);
		}
	}
}

//Function Number: 39
sinkhole_threat_hint()
{
	var_00 = level.player gettacticalweapon();
	var_01 = level.player getammocount(var_00);
	if(var_01 == 0)
	{
		return;
	}

	thread maps\_utility::display_hint_timeout("throw_threat_hint",6);
	while(!level.player buttonpressed("BUTTON_LSHLDR"))
	{
		wait 0.05;
	}

	common_scripts\utility::flag_set("threat_grenade_thrown");
}

//Function Number: 40
should_break_threat_hint()
{
	if(common_scripts\utility::flag("threat_grenade_thrown"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 41
subway_section()
{
	var_00 = getentarray("subway_ceiling_destroyed","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	var_04 = getentarray("subway_ceiling_stage1","targetname");
	foreach(var_02 in var_04)
	{
		var_02 hide();
	}

	var_07 = getent("seo_roof_chunk","targetname");
	var_07 hide();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_start_subway_section");
	var_08 = getentarray("gate01","script_noteworthy");
	var_09 = getentarray("gate02","script_noteworthy");
	var_0A = getentarray("gate01_clip","targetname");
	var_0B = getentarray("gate02_clip","targetname");
	foreach(var_0D in var_0A)
	{
		var_0E = common_scripts\utility::getclosest(var_0D.origin,var_08,20);
		var_0D linkto(var_0E);
		var_0D connectpaths();
	}

	foreach(var_0D in var_0B)
	{
		var_0E = common_scripts\utility::getclosest(var_0D.origin,var_09,20);
		var_0D linkto(var_0E);
		var_0D connectpaths();
	}

	level.door_volume_array = getentarray("rotating_auto_doors","targetname");
	common_scripts\utility::array_thread(getentarray("rotating_auto_doors","targetname"),::subway_rotating_automatic_doors);
	if(level.nextgen)
	{
		thread subway_setup_civilians();
	}
	else
	{
		thread maps\seoul_transients_cg::subway_setup_dead_civilians_cg();
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trig_subway_round_corner");
	level notify("killSinkHolePerf");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("vo_subway_see_civilians");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_subway_gate_arrival");
	common_scripts\utility::flag_set("objective_sd_followed_cormack_through_subway");
	if(!common_scripts\utility::flag("objective_sd_smoke_ambush_defeated"))
	{
		common_scripts\utility::flag_set("objective_sd_smoke_ambush_defeated");
	}

	thread subway_handle_open_gate();
	common_scripts\utility::flag_wait("subway_gate_triggered");
	thread subway_atlas_ceiling_breach();
}

//Function Number: 42
subway_atlas_ceiling_breach()
{
	level.player freezecontrols(1);
	thread maps\seoul_lighting::dof_subway_cinematic_optimized();
	thread maps\seoul_lighting::lighting_subway_breach();
	thread maps\seoul_lighting::cine_holelight();
	thread maps\seoul_lighting::cine_sub_will_all_mulitlight();
	level thread maps\seoul_fx::roof_breach_anticipation_fx();
	var_00 = getent("hero_burke","targetname");
	var_01 = getent("atlas_squadmate1","targetname");
	var_02 = getent("atlas_squadmate2","targetname");
	var_03 = getent("atlas_squadmate3","targetname");
	var_04 = getent("civ_vip1","targetname");
	var_05 = getent("subway_origin_atlus_breach","targetname");
	var_06 = getent("subway_gate_atlas_meetup","targetname");
	var_07 = getent("subway_gate_atlas_meetup_clip","targetname");
	setsaveddvar("g_friendlynamedist",0);
	level.gideon = var_00 maps\_shg_design_tools::actual_spawn();
	level.atlas1 = var_01 maps\_shg_design_tools::actual_spawn();
	level.atlas2 = var_02 maps\_shg_design_tools::actual_spawn();
	level.gideon.ignoreall = 1;
	level.atlas1.ignoreall = 1;
	level.atlas2.ignoreall = 1;
	level.vip1 = undefined;
	if(level.nextgen)
	{
		level.vip1 = var_04 maps\_shg_design_tools::actual_spawn();
	}
	else
	{
		level.vip1 = maps\seoul_transients_cg::seo_meet_atlas_civ_scriptmodel_cg();
	}

	if(level.nextgen)
	{
		level.vip1.ignoreall = 1;
	}

	level.cormack.ignoreall = 1;
	level.jackson.ignoreall = 1;
	level.will_irons.ignoreall = 1;
	level.atlas1.animname = "atlas_guy1";
	level.atlas2.animname = "atlas_guy2";
	level.gideon.animname = "gideon";
	level.cormack.animname = "cormack";
	level.jackson.animname = "jackson";
	level.will_irons.animname = "will_irons";
	level.atlas1 maps\_utility::gun_remove();
	level.atlas2 maps\_utility::gun_remove();
	level.gideon maps\_utility::gun_remove();
	level.atlas1 attach(getweaponmodel("iw5_hbra3_sp"),"TAG_WEAPON_RIGHT");
	level.atlas2 attach(getweaponmodel("iw5_hbra3_sp"),"TAG_WEAPON_RIGHT");
	level.gideon attach(getweaponmodel("iw5_hbra3_sp"),"TAG_WEAPON_RIGHT");
	var_08 = maps\_utility::spawn_anim_model("subway_gate");
	var_05 maps\_anim::anim_first_frame_solo(var_08,"seo_meet_atlas");
	var_06 linkto(var_08,"tag_origin_animated");
	var_09 = getent("seo_roof_chunk","targetname");
	var_09.animname = "roof_chunks";
	var_09 maps\_utility::assign_animtree();
	var_09 maps\_utility::assign_model();
	level.player maps\_shg_utility::setup_player_for_scene(1);
	level notify("atlas_scene_start");
	maps\_player_exo::player_exo_deactivate();
	var_0A = maps\_utility::spawn_anim_model("player_rig",level.player.origin);
	maps\_utility::attach_player_current_weapon_to_rig(var_0A);
	level.vip1.animname = "vip";
	var_0B = [level.cormack,level.will_irons,level.gideon,level.jackson,level.atlas1,level.atlas2,level.vip1,var_0A,var_08,var_09];
	var_09 common_scripts\utility::delaycall(0.5,::show);
	var_0A hide();
	var_0C = 0.5;
	level.player playerlinktoblend(var_0A,"tag_player",var_0C,var_0C * 0.5);
	var_05 maps\_anim::anim_first_frame([level.gideon,level.atlas1,level.atlas2,level.vip1,var_0A,var_08,var_09],"seo_meet_atlas");
	var_0A common_scripts\utility::delaycall(var_0C,::show);
	level.player common_scripts\utility::delaycall(var_0C,::playerlinktodelta,var_0A,"tag_player",1,7,7,5,5,1);
	common_scripts\utility::flag_set("vo_begin_seo_meet_atlas");
	var_05 maps\_anim::anim_single(var_0B,"seo_meet_atlas");
	var_07 connectpaths();
	level.player unlink();
	var_0A delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player freezecontrols(0);
	maps\_player_exo::player_exo_activate();
	level.player lerpfov(65,0.1);
	setsaveddvar("g_friendlynamedist",1024);
	var_06 unlink();
	var_0D = getent("subway_gate_atlas_meetup_closed","targetname");
	var_06 soundscripts\_snd::snd_message("subway_gate_atlas_meetup_close");
	var_06 moveto(var_0D.origin,2,0.5);
	var_0E = getent("subway_origin_jackson_post_scene","targetname");
	level.jackson maps\_utility::anim_stopanimscripted();
	level.jackson forceteleport(var_0E.origin,var_0E.angles);
	thread subway_atlas_post_scene();
	common_scripts\utility::flag_set("objective_start_shopping_district");
	setsaveddvar("g_friendlynamedist",1024);
	common_scripts\utility::flag_waitopen("vo_begin_seo_meet_atlas");
}

//Function Number: 43
subway_meet_atlas_fov_shift_on(param_00)
{
	var_01 = 50;
	level.player lerpfov(var_01,0.5);
}

//Function Number: 44
subway_meet_atlas_fov_shift_off(param_00)
{
	if(!isdefined(level.origfov))
	{
		level.origfov = 65;
	}

	level.player lerpfov(level.origfov,0.5);
}

//Function Number: 45
subway_roof_breach_start_slowmo(param_00)
{
	soundscripts\_snd::snd_message("seo_meet_atlas_slowmo_start");
	maps\_utility::slowmo_start();
	maps\_utility::slowmo_setspeed_slow(0.5);
	maps\_utility::slowmo_setlerptime_in(0.25);
	maps\_utility::slowmo_lerp_in();
	level notify("stop_subway_pa");
}

//Function Number: 46
subway_roof_breach_end_slomo()
{
	maps\_utility::slowmo_setlerptime_out(0.75);
	maps\_utility::slowmo_lerp_out();
	maps\_utility::slowmo_end();
	soundscripts\_snd::snd_message("seo_meet_atlas_slowmo_end");
}

//Function Number: 47
subway_meet_atlas_show_hole_geo(param_00)
{
	var_01 = getentarray("subway_ceiling_intact","targetname");
	foreach(var_03 in var_01)
	{
		var_03 hide();
	}

	var_05 = getentarray("subway_ceiling_stage1","targetname");
	foreach(var_03 in var_05)
	{
		var_03 show();
	}

	if(level.nextgen)
	{
		wait(0.3);
	}

	var_08 = getentarray("subway_ceiling_destroyed","targetname");
	foreach(var_03 in var_08)
	{
		var_03 show();
	}

	foreach(var_03 in var_05)
	{
		var_03 hide();
	}

	wait(0.3);
	thread subway_roof_breach_start_slowmo();
	wait(1);
	thread subway_roof_breach_end_slomo();
}

//Function Number: 48
subway_atlas_post_scene()
{
	var_00 = getent("subway_origin_atlas1","targetname");
	var_01 = getent("subway_origin_atlas2","targetname");
	var_02 = getent("subway_origin_atlas3","targetname");
	var_03 = getent("subway_origin_atlas4","targetname");
	var_04 = getnode("atlas_cover_1","targetname");
	var_05 = getnode("atlas_cover_2","targetname");
	var_06 = getnode("atlas_cover_3","targetname");
	var_07 = getent("atlas_cover_4","targetname");
	level.gideon maps\_utility::anim_stopanimscripted();
	level.atlas1 maps\_utility::anim_stopanimscripted();
	level.atlas2 maps\_utility::anim_stopanimscripted();
	level.vip1 maps\_utility::anim_stopanimscripted();
	level.gideon forceteleport(var_00.origin,var_00.angles);
	level.atlas1 forceteleport(var_01.origin,var_01.angles);
	level.atlas2 forceteleport(var_02.origin,var_02.angles);
	if(level.nextgen)
	{
		level.vip1 forceteleport(var_03.origin,var_03.angles);
		level.vip1 maps\_utility::set_goal_radius(15);
		level.vip1 setgoalentity(var_07);
	}
	else
	{
		thread maps\seoul_transients_cg::seo_get_vip_away_cg(var_03);
	}

	level.gideon maps\_utility::set_goal_radius(15);
	level.gideon maps\_utility::set_goal_node(var_04);
	level.atlas1 maps\_utility::set_goal_radius(15);
	level.atlas1 maps\_utility::set_goal_node(var_05);
	level.atlas2 maps\_utility::set_goal_radius(15);
	level.atlas2 maps\_utility::set_goal_node(var_06);
	wait(15);
	subway_atlas_cleanup();
}

//Function Number: 49
subway_atlas_cleanup()
{
	level.gideon delete();
	level.atlas1 delete();
	level.atlas2 delete();
	level.vip1 delete();
}

//Function Number: 50
subway_setup_civilians()
{
	var_00 = getent("trigger_enter_subway_station_01","targetname");
	var_01 = getent("trigger_enter_subway_station_02","targetname");
	var_02 = getent("trigger_enter_subway_station_03","targetname");
	var_03 = getent("trigger_enter_subway_station_04","targetname");
	level.subway_civilians = [];
	thread subway_enter_spawn_civilians(var_00,var_01);
	thread subway_enter_spawn_civilians(var_03,var_02);
	thread subway_exit_delete_civilians(var_01,var_00);
	thread subway_exit_delete_civilians(var_02,var_03);
}

//Function Number: 51
handle_ally_threat_during_execution_scene()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_subway_get_allies_to_execution_scene");
	thread maps\_shg_design_tools::trigger_to_notify("trig_subway_round_corner","allies_aware_of_execution");
	level.cormack.ignoreall = 1;
	level.will_irons.ignoreall = 1;
	level.jackson.ignoreall = 1;
	level common_scripts\utility::waittill_either("execution_scene_halted","allies_aware_of_execution");
	level.cormack.ignoreall = 0;
	level.will_irons.ignoreall = 0;
	level.jackson.ignoreall = 0;
}

//Function Number: 52
subway_execution_scene(param_00,param_01)
{
	thread handle_ally_threat_during_execution_scene();
	param_00 waittill("trigger");
	param_01 waittill("trigger");
	var_02 = getent("spawner_execution_scene","targetname");
	var_03 = common_scripts\utility::getstructarray("struct_subway_execution_scene_soldier1","targetname");
	var_04 = var_03[0] common_scripts\utility::spawn_tag_origin();
	var_05 = [];
	foreach(var_07 in var_03)
	{
		var_08 = var_02 maps\_shg_design_tools::actual_spawn(1);
		var_08 maps\_patrol_extended::force_patrol_anim_set("gundown");
		var_08 setgoalpos(level.player.origin);
		var_05[var_05.size] = var_08;
		var_08 thread monitor_alert();
		wait(2);
	}

	common_scripts\utility::array_thread(var_05,::monitor_alert,var_05);
	level waittill("execution_scene_halted");
	maps\_utility::activate_trigger_with_targetname("trig_subway_round_corner");
}

//Function Number: 53
monitor_alert(param_00)
{
	thread maps\_utility::notify_delay("alert",8);
	var_01 = common_scripts\utility::waittill_any_return("death","damage","alert");
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03))
		{
			var_03 notify("alert");
		}
	}

	maps\_utility::clear_generic_idle_anim();
	maps\_utility::clear_run_anim();
	self allowedstances("stand","crouch","prone");
	self.disablearrivals = 0;
	self.disableexits = 0;
	self stopanimscripted();
	self notify("stop_animmode");
	self.script_nobark = undefined;
	self.goalradius = level.default_goalradius;
}

//Function Number: 54
fail_on_kill_civilian()
{
	self waittill("death",var_00,var_01,var_02);
	if(isdefined(var_00) && var_00 == level.player)
	{
		setdvar("ui_deadquote",&"SEOUL_FAIL_CIVILIAN_KILLED");
		maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 55
kill_on_damage()
{
	self waittill("damage");
	maps\_utility::anim_stopanimscripted();
	self startragdoll();
	wait 0.05;
	self kill();
}

//Function Number: 56
return_notify_on_event(param_00,param_01)
{
	self addaieventlistener(param_00);
}

//Function Number: 57
monitor_execution_scene_civs(param_00)
{
	self waittill("ai_alert");
	maps\_utility::anim_stopanimscripted();
}

//Function Number: 58
monitor_execution_scene_soldiers(param_00)
{
	thread return_notify_on_event("grenade danger","ai_alert");
	thread return_notify_on_event("bulletwhizby","ai_alert");
	common_scripts\utility::waittill_any("death","damage","ai_event","ai_alert");
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02))
		{
			var_02 notify("ai_alert");
		}
	}

	if(isdefined(self))
	{
		maps\_utility::anim_stopanimscripted();
	}
}

//Function Number: 59
handle_sonic_when_in_subway(param_00,param_01,param_02)
{
	for(;;)
	{
		param_00 waittill("trigger");
		param_01 waittill("trigger");
		if(param_02 == "off")
		{
			thread maps\_sonicaoe::disablesonicaoe();
		}
		else
		{
			thread maps\_sonicaoe::enablesonicaoe();
		}

		param_01 waittill("trigger");
		param_00 waittill("trigger");
		if(param_02 == "off")
		{
			thread maps\_sonicaoe::enablesonicaoe();
			continue;
		}

		thread maps\_sonicaoe::disablesonicaoe();
	}
}

//Function Number: 60
subway_enter_spawn_civilians(param_00,param_01)
{
	if(!isdefined(level.subway_civilians))
	{
		level.subway_civilians = [];
	}

	var_02 = getentarray("spawner_subway_civilian","targetname");
	var_03 = common_scripts\utility::getstructarray("struct_subway_civilian","targetname");
	for(;;)
	{
		param_00 waittill("trigger");
		param_01 waittill("trigger");
		level notify("player_entered_subway");
		foreach(var_05 in var_03)
		{
			var_06 = maps\_utility::dronespawn_bodyonly(common_scripts\utility::random(var_02));
			var_06 notsolid();
			if(!isdefined(var_06))
			{
				continue;
			}

			var_06.animname = "generic";
			var_05 thread maps\_anim::anim_generic_loop(var_06,var_05.animation);
			level.subway_civilians[level.subway_civilians.size] = var_06;
		}

		wait(0.1);
	}
}

//Function Number: 61
break_if_flashed_sonic()
{
	self endon("death");
	while(!iscivflashed())
	{
		wait 0.05;
	}

	if(isdefined(self.tag))
	{
		thread maps\_shg_design_tools::anim_stop(self.tag);
	}

	thread maps\_utility::anim_stopanimscripted();
	thread maps\_shg_design_tools::anim_stop();
}

//Function Number: 62
iscivflashed()
{
	if(!isdefined(self.iscivilianflashed))
	{
		return 0;
	}

	if(!self.iscivilianflashed)
	{
		return 0;
	}

	return 1;
}

//Function Number: 63
subway_exit_delete_civilians(param_00,param_01)
{
	for(;;)
	{
		param_00 waittill("trigger");
		param_01 waittill("trigger");
		level notify("player_leaving_subway");
		if(level.subway_civilians.size > 0)
		{
			foreach(var_03 in level.subway_civilians)
			{
				if(isdefined(var_03.tag))
				{
					var_03.tag delete();
				}

				if(isdefined(var_03))
				{
					var_03 delete();
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 64
spawn_civ_loop(param_00)
{
	param_00.count = 1;
	var_01 = param_00 maps\_shg_design_tools::actual_spawn(1);
	var_01.animname = "generic";
	param_00 thread maps\_anim::anim_generic_loop(var_01,param_00.animation);
	var_01 subway_civilian_attach_props(param_00.animation);
	var_01 thread break_if_flashed_sonic();
	return var_01;
}

//Function Number: 65
subway_civ_speaking_groups_setup()
{
	var_00 = getentarray("spawner_subway_civilian","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_subway_civilian","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = maps\_utility::dronespawn(common_scripts\utility::random(var_00));
		if(!isdefined(var_04))
		{
			continue;
		}

		var_04.animname = "generic";
		var_04.origin = var_03.origin;
		var_04.angles = var_03.angles;
		var_03 thread maps\_anim::anim_generic_loop(var_04,var_03.animation);
		level.subway_civilians[level.subway_civilians.size] = var_04;
	}
}

//Function Number: 66
subway_civilian_init_props()
{
	anim.civilianprops = [];
	level.civilianprops["civilian_smoking_b"] = "prop_cigarette";
	level.civilianprops["parabolic_leaning_guy_smoking_idle"] = "prop_cigarette";
	level.civilianprops["civilian_texting_sitting"] = "electronics_pda";
	level.civilianprops["civilian_reader_1"] = "lab_tablet_flat_on";
	level.civilianprops["civilian_reader_2"] = "lab_tablet_flat_on";
	level.civilianprops["civilian_texting_standing"] = "electronics_pda";
	level.civilianprops["civilian_sitting_business_lunch_A_1"] = "com_cellphone_on";
}

//Function Number: 67
subway_civilian_attach_props(param_00)
{
	if(isdefined(self.hasattachedprops))
	{
		return;
	}

	subway_civilian_init_props();
	var_01 = level.civilianprops[param_00];
	if(isdefined(var_01))
	{
		self.attachedpropmodel = var_01;
		self.attachedproptag = "tag_inhand";
		var_02 = self attach(self.attachedpropmodel,self.attachedproptag,1);
		self.hasattachedprops = 1;
		if(self.attachedpropmodel == "prop_cigarette")
		{
			playfxontag(common_scripts\utility::getfx("cigarette_smk"),self,"tag_inhand");
		}

		return var_01;
	}
}

//Function Number: 68
subway_civilian_detach_props()
{
	if(isdefined(self.hasattachedprops) && isdefined(self.attachedpropmodel))
	{
		if(self.attachedpropmodel == "prop_cigarette")
		{
			stopfxontag(common_scripts\utility::getfx("cigarette_smk"),self,"tag_inhand");
		}

		self detach(self.attachedpropmodel,self.attachedproptag);
		self.hasattachedprops = undefined;
		self.attachedpropmodel = undefined;
		self.attachedproptag = undefined;
	}
}

//Function Number: 69
subway_handle_open_gate()
{
	var_00 = getent("subway_open_gate","targetname");
	var_00 usetriggerrequirelookat();
	var_00 sethintstring(&"SEOUL_OPEN_GATE_HINT");
	var_01 = var_00 maps\_shg_utility::hint_button_trigger("x",300);
	common_scripts\utility::flag_set("vo_near_gate");
	var_02 = ["seo_crk_mitchellgetthatgate","seo_crk_getthegatemitchell"];
	thread maps\_shg_utility::dialogue_reminder(level.cormack,"subway_gate_triggered",var_02);
	maps\_utility::trigger_wait_targetname("subway_open_gate");
	common_scripts\utility::flag_set("subway_gate_triggered");
	soundscripts\_snd::snd_message("subway_gate_triggered");
	var_01 maps\_shg_utility::hint_button_clear();
	var_00 sethintstring("");
	common_scripts\utility::flag_set("objective_sd_gate_opened");
	var_00 common_scripts\utility::trigger_off();
}

//Function Number: 70
subway_handle_player_weapon_in_scene()
{
	for(;;)
	{
		if(isdefined(level.player getcurrentweapon()) && level.player getcurrentweapon() != "none")
		{
			var_00 = level.player getcurrentweapon();
			var_01 = strtok(var_00,"_");
			var_02 = "none";
			if(var_01[1] == "himar")
			{
				var_03 = "npc_himar_base";
			}
			else
			{
				var_03 = "npc_" + var_02[1] + "_nocamo";
			}

			if(isdefined(var_01[3]))
			{
				var_02 = var_01[3];
			}

			wait 0.05;
		}

		wait(1);
	}
}

//Function Number: 71
subway_rotating_automatic_doors()
{
	if(!isdefined(self.open_time))
	{
		self.open_time = 1;
	}

	var_00 = getentarray(self.target,"targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03.classname == "script_origin")
		{
			var_01[var_01.size] = var_03;
			continue;
		}

		var_03 subway_auto_doors_init(self.open_time);
	}

	var_00 = common_scripts\utility::array_remove_array(var_00,var_01);
	for(;;)
	{
		if(!isdefined(level.player_and_squad))
		{
			level.player_and_squad = [];
			level.player_and_squad[level.player_and_squad.size] = level.player;
			level.player_and_squad[level.player_and_squad.size] = level.cormack;
			level.player_and_squad[level.player_and_squad.size] = level.will_irons;
			level.player_and_squad[level.player_and_squad.size] = level.jackson;
		}

		var_05 = 0;
		foreach(var_07 in level.player_and_squad)
		{
			if(var_07 istouching(self) && isdefined(var_07))
			{
				var_05++;
				break;
			}
		}

		if(var_05 > 0)
		{
			subway_open_all_doors(var_00);
		}
		else
		{
			var_09 = 0.3;
			thread subway_close_all_doors(var_00,var_09);
		}

		wait(0.05);
	}
}

//Function Number: 72
subway_auto_doors_init(param_00)
{
	self.start_position = self.angles;
	self.sliding_door_state = "closed";
	var_01 = getent(self.target,"targetname");
	self.open_position = var_01.angles;
	self.open_velocity = distance(self.open_position,self.angles) / param_00;
}

//Function Number: 73
subway_open_all_doors(param_00)
{
	foreach(var_02 in param_00)
	{
		if(var_02.sliding_door_state == "open" || var_02.sliding_door_state == "opening")
		{
			continue;
		}

		var_02 thread subway_open_door();
	}
}

//Function Number: 74
subway_open_door()
{
	self.sliding_door_state = "opening";
	var_00 = 0.3;
	self rotateto(self.open_position,var_00);
	soundscripts\_snd::snd_message("subway_doors_opening");
	wait(var_00);
	self.sliding_door_state = "open";
}

//Function Number: 75
subway_close_all_doors(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(var_03.sliding_door_state == "closed" || var_03.sliding_door_state == "opening")
		{
			continue;
		}

		var_03 rotateto(var_03.start_position,param_01);
		var_03 soundscripts\_snd::snd_message("subway_doors_closing");
		var_03.sliding_door_state = "closed";
	}
}

//Function Number: 76
sd_intersection3_smoke_laser_spawn()
{
}

//Function Number: 77
sd_street_combat()
{
	common_scripts\utility::flag_wait("sd_start_shopping_district");
	maps\_utility::normal_friendly_fire_penalty();
	level.will_irons.ignoreall = 1;
	level.cormack.ignoreall = 1;
	level.jackson.ignoreall = 1;
	level.player_repulsor = missile_createrepulsorent(level.player,10000,500);
	maps\_utility::battlechatter_off("allies");
	maps\_utility::autosave_by_name();
	thread sd_autosave_check();
	common_scripts\utility::flag_set("start_weapon_platform_firing");
	thread enable_pain_will_irons_during_shopping_fight();
	thread sd_intersection_chopper();
	thread sd_patrol1_command();
	thread sd_switch_axis_colors();
	thread sd_path_check1();
	thread sd_spawn_turret_truck();
	thread sd_upstairs_enemies_spawn();
	thread sd_spawn_zipline_group1();
	thread sd_spawn_zipline_group2();
	thread sd_spawn_and_retreat_goals("trig_restaurant_spawn","enemy_sd_restaraunt1",undefined,undefined);
	thread sd_spawn_and_retreat_goals("trig_restaurant_spawn","enemy_sd_upstairs1_reinforce",3,undefined);
	thread sd_spawn_and_retreat_goals("trig_sd_reinforce1","enemy_sd_reinforce1",undefined,undefined);
	thread sd_spawn_crossfire_2nd_floor_enemies();
	thread sd_spawn_and_retreat_goals("trig_sd_reinforce1","enemy_sd_intersection2",undefined);
	thread sd_intersection2_smoke_and_spawn();
	thread sd_intersection3_smoke_laser_spawn();
	thread handle_movement_speed_in_final_building();
	thread sd_shop_logo_control();
	thread sd_glass_projection_setup();
	thread canal_weapon_platform_firing_loop();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_patrol1_spawn");
	common_scripts\utility::flag_set("vo_sd_attack_patrol");
	level.will_irons maps\_utility::enable_cqbwalk();
	level.cormack maps\_utility::enable_cqbwalk();
	level.jackson maps\_utility::enable_cqbwalk();
	maps\_shg_design_tools::waittill_trigger_with_name("sd_trig_engage_patrol");
	thread sd_vo_inside_restaurant();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_upstairs2_spawn");
	maps\_utility::autosave_by_name();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_sd_intersection2_reinforce");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_wait("sd_cleanup_upstairs");
	var_00 = getent("sd_goal_upstairs2","targetname");
	var_01 = maps\_utility::get_force_color_guys("axis","p");
	var_02 = var_00 maps\_utility::get_ai_touching_volume("axis");
	var_01 = common_scripts\utility::array_combine(var_01,var_02);
	foreach(var_04 in var_01)
	{
		if(isalive(var_04))
		{
			var_04 bloody_death(0.3);
		}
	}

	common_scripts\utility::flag_wait("sd_trigger_final_combat");
	var_06 = maps\_utility::get_force_color_guys("axis","g");
	foreach(var_04 in var_06)
	{
		if(isalive(var_04))
		{
			var_04.health = 1;
		}
	}

	common_scripts\utility::flag_wait("sd_street_combat_complete");
	common_scripts\utility::flag_set("objective_sd_street_combat_complete");
}

//Function Number: 78
enable_pain_will_irons_during_shopping_fight()
{
	common_scripts\utility::flag_wait("wakeup_patrol");
	level.will_irons maps\_utility::enable_pain();
	common_scripts\utility::flag_wait("sd_street_combat_complete");
	level.will_irons maps\_utility::disable_pain();
}

//Function Number: 79
handle_movement_speed_in_final_building()
{
	common_scripts\utility::flag_wait("sd_street_combat_complete");
	maps\seoul::enable_cqb_squad();
	common_scripts\utility::flag_wait("canal_reached_window");
	maps\seoul::disable_cqb_squad();
}

//Function Number: 80
sd_autosave_check()
{
	common_scripts\utility::flag_wait("vo_begin_seo_meet_atlas");
	common_scripts\utility::flag_waitopen("vo_begin_seo_meet_atlas");
	if(!common_scripts\utility::flag("sd_combat_start"))
	{
		maps\_utility::autosave_by_name();
	}
}

//Function Number: 81
sd_spawn_crossfire_2nd_floor_enemies()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_upstairs2_spawn");
	var_00 = maps\_utility::get_force_color_guys("axis","p");
	var_00 = maps\_utility::array_removedead_or_dying(var_00);
	while(var_00.size > 0)
	{
		var_00 = maps\_utility::array_removedead_or_dying(var_00);
		wait 0.05;
	}

	if(!common_scripts\utility::flag("sd_cleanup_upstairs"))
	{
		thread sd_spawn_and_retreat_goals(undefined,"enemy_sd_upstairs2",undefined,"sd_goal_upstairs2",undefined,undefined,undefined,"trig_sd_cleanup_upstairs2");
	}
}

//Function Number: 82
sd_vo_inside_restaurant()
{
	maps\_shg_design_tools::waittill_trigger_with_name("sd_trig_move_inside_restaurant");
	common_scripts\utility::flag_set("vo_inside_restaurant");
}

//Function Number: 83
sd_switch_axis_colors()
{
	maps\_shg_design_tools::waittill_trigger_with_name("sd_trig_move_inside_restaurant");
	var_00 = maps\_utility::get_force_color_guys("axis","b");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 maps\_utility::set_force_color("p");
		}
	}
}

//Function Number: 84
sd_spawn_zipline_group1()
{
	level endon("player_hit_street_zipline_trigger");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_sd_upstairs1_zipreinforce");
	level notify("player_hit_upperfloor_zipline_trigger");
	var_00 = getent("sd_int2_smoke_nade_source1","targetname");
	var_01 = getentarray("sd_upstairs_smoke_nade_source1","targetname");
	foreach(var_03 in var_01)
	{
		magicgrenade("smoke_grenade_cheap",var_03.origin,var_03.origin + (0,2,0),0.5);
		soundscripts\_snd::snd_message("seo_smoke_grenade_ambush",var_03.origin + (0,2,0),0.5);
	}

	wait(2);
	var_05 = getglassarray("sd_glass_bar_windows");
	foreach(var_07 in var_05)
	{
		destroyglass(var_07);
	}

	var_09 = getent("sd_org_smoke_start","targetname");
	var_0A = getent("sd_org_smoke_target1","targetname");
	var_0B = getent("sd_org_smoke_target2","targetname");
	magicgrenade("smoke_grenade_cheap",var_09.origin + (0,200,-60),var_0A.origin + (0,20,20),1);
	soundscripts\_snd::snd_message("seo_smoke_grenade_ambush",var_0A.origin + (0,20,20),1);
	wait(0.5);
	magicgrenade("smoke_grenade_cheap",var_09.origin + (0,200,-60),var_0B.origin + (0,20,20),1);
	soundscripts\_snd::snd_message("seo_smoke_grenade_ambush",var_0B.origin + (0,20,20),1);
	var_0C = [];
	var_0C[var_0C.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("enemy_sd_upstairs1_zipreinforce","sd_zipline_upstairs_across_start2");
	wait(0.5);
	var_0C[var_0C.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("enemy_sd_upstairs1_zipreinforce","sd_zipline_upstairs_across_start1");
	wait(0.5);
	var_0C[var_0C.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("enemy_sd_upstairs1_zipreinforce","sd_zipline_upstairs_across_start3");
	wait(0.5);
	var_0C[var_0C.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("enemy_sd_upstairs1_zipreinforce","sd_zipline_upstairs_across_start4");
	sd_zipline_enemy_think(var_0C);
}

//Function Number: 85
sd_spawn_zipline_group2()
{
	level endon("player_hit_upperfloor_zipline_trigger");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_sd_upstairs1_zipreinforce_02");
	level notify("player_hit_street_zipline_trigger");
	var_00 = getent("sd_int2_smoke_nade_source1","targetname");
	var_01 = getentarray("sd_upstairs_smoke_nade_source1","targetname");
	foreach(var_03 in var_01)
	{
		if(common_scripts\utility::cointoss())
		{
			magicgrenade("smoke_grenade_cheap",var_03.origin,var_03.origin + (0,2,0),0.5);
		}
	}

	wait(2);
	var_05 = getglassarray("sd_glass_bar_windows");
	foreach(var_07 in var_05)
	{
		destroyglass(var_07);
	}

	var_09 = getent("sd_org_smoke_start","targetname");
	var_0A = getent("sd_org_smoke_target1","targetname");
	var_0B = getent("sd_org_smoke_target2","targetname");
	magicgrenade("smoke_grenade_cheap",var_09.origin + (0,200,-60),var_0A.origin + (0,20,20),1);
	wait(0.5);
	magicgrenade("smoke_grenade_cheap",var_09.origin + (0,200,-60),var_0B.origin + (0,20,20),1);
	var_0C = [];
	var_0C[var_0C.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("enemy_sd_upstairs1_zipreinforce","sd_zipline_upstairs_across_start2");
	wait(0.5);
	var_0C[var_0C.size] = thread animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("enemy_sd_upstairs1_zipreinforce","sd_zipline_upstairs_across_start1");
	sd_zipline_enemy_think(var_0C);
}

//Function Number: 86
handle_player_skipped_turret()
{
	self endon("death");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_sd_cleanup_upstairs2");
	bloody_death();
}

//Function Number: 87
handle_turret_gunner_sonic_blast(param_00)
{
	self endon("death");
	self waittill("flashed");
	if(isdefined(param_00))
	{
		param_00 turretfiredisable();
		wait(6);
		param_00 turretfireenable();
	}
}

//Function Number: 88
sd_spawn_turret_truck()
{
	maps\_utility::trigger_wait_targetname("trig_sd_turret_vehicle_spawn");
	wait(3);
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("sd_turret_vehicle1");
	if(level.currentgen)
	{
		thread maps\seoul_transients_cg::cg_kill_entity_on_transition(var_00,"pre_transients_canal_overlook_to_riverwalk");
	}

	var_00 soundscripts\_snd::snd_message("shopping_district_turret_truck");
	var_00.script_godmode = 1;
	var_01 = var_00.mgturret[0];
	var_02 = getent("gaz_lighting_origin","targetname");
	var_00 overridelightingorigin(var_02.origin);
	foreach(var_04 in var_00.riders)
	{
		if(level.currentgen)
		{
			var_04.neverdelete = 1;
		}

		if(var_04.vehicle_position == 3)
		{
			var_05 = var_04;
			var_05 thread handle_turret_gunner_sonic_blast(var_01);
			var_05 thread handle_player_skipped_turret();
		}
	}

	var_00 waittill("reached_end_node");
	var_00 maps\_vehicle::vehicle_unload("all_but_gunner");
	common_scripts\utility::flag_wait("canal_jump_complete");
	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 89
sd_upstairs_enemies_spawn()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_patrol1_spawn");
	maps\_shg_design_tools::waittill_trigger_with_name("sd_trig_engage_patrol");
	common_scripts\utility::flag_wait("wakeup_patrol");
	common_scripts\utility::flag_set("vo_sd_first_reinforcements");
	if(level.currentgen && !issubstr(level.transient_zone,"_shopping"))
	{
		level waittill("transients_subway_to_shopping_dist");
	}

	maps\_utility::array_spawn_function_noteworthy("enemy_sd_upstairs1",::sd_1st_int_window_goal);
	var_00 = maps\_utility::array_spawn_noteworthy("enemy_sd_upstairs1",1);
	maps\_shg_design_tools::waittill_trigger_with_name("trig_sd_reinforce1");
	var_00 = maps\_utility::array_removedead_or_dying(var_00);
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::set_force_color("p");
	}
}

//Function Number: 90
sd_1st_int_window_goal()
{
	self.grenadeammo = 0;
	thread change_color_node_quick();
	maps\_utility::set_goal_radius(15);
	maps\_utility::set_goal_node(getnode(self.target,"targetname"));
}

//Function Number: 91
sd_path_check1()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_disable_restaraunt_events");
	maps\_utility::disable_trigger_with_targetname("trig_disable_restaraunt_events");
	var_00 = getent("trig_restaurant_spawn","targetname");
	if(isdefined(var_00))
	{
		maps\_utility::disable_trigger_with_targetname("trig_restaurant_spawn");
	}

	var_01 = getent("trig_sd_will_command_restaraunt1","targetname");
	if(isdefined(var_01))
	{
		maps\_utility::disable_trigger_with_targetname("trig_sd_will_command_restaraunt1");
	}

	var_02 = getent("trig_sd_upstairs1_reinforce","targetname");
	if(isdefined(var_02))
	{
		maps\_utility::disable_trigger_with_targetname("trig_sd_upstairs1_reinforce");
	}
}

//Function Number: 92
sd_patrol1_command()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_patrol1_spawn");
	while(level.currentgen && !istransientloaded("seoul_shopping_dist_tr"))
	{
		wait(0.05);
	}

	if(level.currentgen)
	{
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("sd_street_combat_complete",undefined,15,0);
	}

	common_scripts\utility::flag_clear("wakeup_patrol");
	thread maps\_utility::array_spawn_function_noteworthy("enemy_sd_patrol1",::sd_force_patrol1_anim_set,"casualkiller",1);
	thread maps\_utility::array_spawn_noteworthy("enemy_sd_patrol1",1);
	common_scripts\utility::flag_wait("wakeup_patrol");
	common_scripts\utility::flag_set("sd_combat_start");
}

//Function Number: 93
sd_force_patrol1_anim_set(param_00,param_01,param_02)
{
	self endon("death");
	self.ignoreall = 1;
	self.patrol_walk_twitch = undefined;
	self.patrol_walk_anim = undefined;
	self.grenadeammo = 0;
	self.script_careful = 1;
	thread maps\_patrol::patrol();
	maps\_utility::clear_force_color();
	thread sd_patrol1_player_close_check();
	self addaieventlistener("grenade danger");
	self addaieventlistener("gunshot");
	self addaieventlistener("bulletwhizby");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"damage");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"ai_event");
	maps\_utility::add_func(::common_scripts\utility::flag_set,"wakeup_patrol");
	thread maps\_utility::do_wait_any();
	common_scripts\utility::flag_wait("wakeup_patrol");
	self.ignoreall = 0;
	maps\_utility::set_force_color("b");
	self.fixednode = 0;
	remove_patrol_anim_set();
	self notify("stop_going_to_node");
	level.will_irons.ignoreall = 0;
	level.cormack.ignoreall = 0;
	level.jackson.ignoreall = 0;
	level.will_irons maps\_utility::disable_cqbwalk();
	level.cormack maps\_utility::disable_cqbwalk();
	level.jackson maps\_utility::disable_cqbwalk();
	maps\_utility::battlechatter_on("allies");
	thread change_color_node_quick();
}

//Function Number: 94
sd_patrol1_player_close_check()
{
	self endon("death");
	level endon("wakeup_patrol");
	level.player endon("death");
	while(distancesquared(level.player.origin,self.origin) > squared(450))
	{
		wait(0.25);
	}

	common_scripts\utility::flag_set("wakeup_patrol");
}

//Function Number: 95
sd_intersection_chopper()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("sd_intersection_chopper");
	var_00.ignoreall = 1;
	var_00 maps\_vehicle::godon();
	var_00 soundscripts\_snd::snd_message("sd_intersection_chopper");
	var_00.light = common_scripts\utility::spawn_tag_origin();
	var_00.light.origin = var_00 gettagorigin("tag_flash");
	var_00.light.angles = var_00 gettagorigin("tag_flash");
	var_00.light linkto(var_00,"tag_flash",(3,0,0),(90,0,0));
	playfxontag(common_scripts\utility::getfx("spotlight_chopper"),var_00.light,"tag_origin");
	var_00 thread maps\_shg_design_tools::stopfxonnotify(common_scripts\utility::getfx("spotlight_chopper"),var_00.light,"tag_origin","death");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_patrol1_spawn");
	common_scripts\utility::flag_set("sd_intersection_chopper_wait");
}

//Function Number: 96
sd_intersection2_smoke_and_spawn()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_sd_intersection2_reinforce");
	var_00 = getent("sd_int2_smoke_nade_source1","targetname");
	var_01 = getentarray("sd_int2_smoke_nade_targets","script_noteworthy");
	wait(1.5);
	thread sd_spawn_and_retreat_goals(undefined,"enemy_sd_intersection2_upstairs",undefined,"sd_goal_intersection2_upstairs",undefined,undefined,undefined);
	var_02 = [];
	wait(0.5);
	wait(0.5);
	maps\_utility::autosave_by_name();
	wait(1);
	var_00 = getent("sd_int2_smoke_nade_source2","targetname");
	var_03 = getentarray("sd_int2_smoke_nade_targets2","script_noteworthy");
	soundscripts\_snd::snd_music_message("mus_sd_firefight_ending");
}

//Function Number: 97
sd_shop_logo_control()
{
	var_00 = getglass("sd_glass_sign1");
	var_01 = getent("sd_glass_sign1_1","targetname");
	while(isglassdestroyed(var_00) == 0 && isdefined(var_00))
	{
		wait 0.05;
	}

	var_01 delete();
}

//Function Number: 98
sd_glass_projection_setup()
{
	var_00 = getglassarray("glass_with_petals");
	var_01 = getentarray("petals_brush","script_noteworthy");
	foreach(var_03 in var_00)
	{
		var_04 = common_scripts\utility::getclosest(getglassorigin(var_03),var_01,400);
		thread sd_glass_projection_think(var_04,var_03);
	}
}

//Function Number: 99
sd_glass_projection_think(param_00,param_01)
{
	while(!isglassdestroyed(param_01))
	{
		wait 0.05;
	}

	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 100
sd_smoke_laser_ambush()
{
	common_scripts\utility::flag_wait("sd_spawn_drone_swarm_for_evade");
	common_scripts\utility::flag_set("vo_sd_demo_team_call");
	common_scripts\utility::flag_wait("sd_trigger_final_combat");
	thread handle_drone_smoke();
	level waittill("smoke_thrown_sd");
	thread handle_enemy_ambush_smoke_laser_sd();
	level.will_irons maps\_utility::enable_careful();
	level.cormack maps\_utility::enable_careful();
	level.jackson maps\_utility::enable_careful();
	maps\_utility::autosave_by_name();
}

//Function Number: 101
sd_flee_drone_swarm()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_drone_evade");
	common_scripts\utility::flag_set("vo_sd_demo_team_call");
	wait(0.5);
	var_00 = common_scripts\utility::getstructarray("sd_snake_swarm_enter","script_noteworthy");
	var_01 = common_scripts\utility::getstructarray("sd_snake_swarm_window_path1","script_noteworthy");
	var_02 = common_scripts\utility::getstructarray("sd_snake_swarm_attack_path2","script_noteworthy");
	var_03 = common_scripts\utility::getstructarray("sd_snake_swarm_attack_path3","script_noteworthy");
	foreach(var_05 in var_00)
	{
		var_05.speed = 18;
	}

	foreach(var_05 in var_02)
	{
		var_05.speed = 18;
	}

	foreach(var_05 in var_03)
	{
		var_05.speed = 20;
	}

	foreach(var_05 in var_01)
	{
		var_05.speed = 25;
	}

	var_0D = getent("sd_drone_queen1","targetname");
	var_0E = getent("sd_drone_queen2","targetname");
	var_0F = [var_0D,var_0E];
	if(level.nextgen)
	{
		var_10 = 24;
		var_11 = 10;
	}
	else
	{
		var_10 = 8;
		var_11 = 6;
	}

	level.snake_cloud = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("sd_drone_queen1",undefined,var_10,var_11);
	common_scripts\utility::flag_wait("sd_trigger_drone_evade");
	maps\_utility::autosave_by_name();
	level.will_irons.ignoreall = 1;
	level.cormack.ignoreall = 1;
	level.jackson.ignoreall = 1;
	maps\_utility::battlechatter_off("allies");
	foreach(var_13 in level.snake_cloud.snakes)
	{
		var_14 = var_13.flock.boid_settings;
		var_14.max_accel = 6400;
		var_14.magnet_factor = 20;
	}

	var_16 = getent("queen_drone_cloud_evade","targetname");
	wait(2);
	common_scripts\utility::flag_wait("sd_snake_swarm_entered");
	thread maps\_shg_design_tools::trigger_to_notify("trig_updstairs_window_retreat");
	level.snake_cloud thread vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("sd_snake_swarm_window_path1",undefined,3);
	foreach(var_13 in level.snake_cloud.snakes)
	{
		var_14 = var_13.flock.boid_settings;
		var_14.max_accel = 6400;
		var_14.magnet_factor = 30;
	}

	level.snake_cloud canal_drone_swarm_think();
}

//Function Number: 102
handle_enemy_ambush_smoke_laser_sd()
{
	var_00 = getnodearray("node_smoke_laser_ambush_sd","targetname");
	var_01 = getentarray("enemy_laser_smoke_ambush_sd","targetname");
	var_02 = [];
	foreach(var_06, var_04 in var_01)
	{
		var_05 = var_04 maps\_shg_design_tools::actual_spawn(1);
		var_05 set_laser_ambush_stats(var_00[var_06]);
		var_02[var_02.size] = var_05;
	}

	while(var_02.size > 2)
	{
		var_02 = maps\_utility::array_removedead_or_dying(var_02);
		wait 0.05;
	}

	maps\_utility::activate_trigger_with_targetname("trigger_allies_to_swarm_evade_stairs");
	wait(3);
	foreach(var_05 in var_02)
	{
		if(isdefined(var_05))
		{
			var_05 kill();
		}

		wait(randomfloat(3));
	}
}

//Function Number: 103
set_laser_ambush_stats(param_00)
{
	maps\_utility::enable_cqbwalk();
	self.goalradius = 196;
	self.grenadeammo = 0;
	thread maps\_utility::disable_long_death();
	if(common_scripts\utility::cointoss())
	{
		thread maps\seoul_code_gangnam::forcelaser();
	}

	if(isdefined(param_00))
	{
		self setgoalnode(param_00);
	}
}

//Function Number: 104
handle_drone_smoke()
{
	var_00 = get_smoke_pair(1);
	var_01 = get_smoke_pair(2);
	var_02 = get_smoke_pair(3);
	var_03 = get_smoke_pair(4);
	var_04 = get_smoke_pair(5);
	magicgrenade("smoke_grenade_cheap",var_02[1].origin,var_02[1].origin + (0,0,300),1,0);
	soundscripts\_snd::snd_message("seo_smoke_grenade_ambush",var_02[1].origin + (0,0,300),1);
	wait(0.5);
	level notify("smoke_thrown_sd");
	magicgrenade("smoke_grenade_cheap",var_01[1].origin,var_01[1].origin + (0,0,300),1,0);
	soundscripts\_snd::snd_message("seo_smoke_grenade_ambush",var_01[1].origin + (0,0,300),1);
	wait(1);
}

//Function Number: 105
get_smoke_pair(param_00)
{
	var_01 = "struct_drone_smoke_0" + param_00 + "a";
	var_02 = "struct_drone_smoke_0" + param_00 + "b";
	var_03 = [];
	var_03[0] = common_scripts\utility::getstruct(var_01,"targetname");
	var_03[1] = common_scripts\utility::getstruct(var_02,"targetname");
	return var_03;
}

//Function Number: 106
sd_handle_glass_smash()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_shopping"))
	{
		level waittill("transients_subway_to_shopping_dist");
	}

	var_00 = getentarray("brush_glass_smash_drone","targetname");
	var_01 = getentarray("brush_panel","targetname");
	common_scripts\utility::array_call(var_00,::hide);
	foreach(var_03 in var_01)
	{
		var_03.panel_state = "still";
		var_03.panel_smashed = getent(var_03.target,"targetname");
		var_03.panel_smashed linkto(var_03);
		var_03.panel_smashed hide();
		var_03.panel_smashed.state = "notsmashed";
	}

	for(;;)
	{
		level waittill("drone_kamikaze_crash",var_05);
		var_06 = randomint(3);
		var_00 = common_scripts\utility::array_removeundefined(var_00);
		var_00 = maps\_shg_design_tools::sortbydistanceauto(var_00,var_05);
		var_01 = maps\_shg_design_tools::sortbydistanceauto(var_01,var_05);
		var_07 = maps\_shg_design_tools::sortbydistanceauto(var_01,var_05);
		for(var_08 = 0;var_08 < var_06;var_08++)
		{
			if(isdefined(var_00[var_08]) && distance(var_00[var_08].origin,var_05) < 100)
			{
				if(!isdefined(var_00[var_08].smashed) || var_00[var_08].smashed != 1)
				{
					var_00[var_08] show();
					soundscripts\_snd::snd_message("shopping_district_glass_smashed",var_00[var_08].origin);
					var_00[var_08].smashed = 1;
				}
				else
				{
					soundscripts\_snd::snd_message("shopping_district_glass_hit_after_smashed",var_00[var_08].origin);
				}
			}

			if(distance(var_01[var_08].origin,var_05) < 100)
			{
				var_01[var_08] thread sd_panel_impact();
			}
		}
	}
}

//Function Number: 107
sd_panel_impact()
{
	if(self.panel_state == "still")
	{
		self.panel_state = "moving";
		var_00 = 0.2;
		if(self.panel_smashed.state == "notsmashed")
		{
			soundscripts\_snd::snd_message("shopping_district_panel_smashed",self.origin);
			self.panel_smashed.state = "smashed";
		}

		self.panel_smashed show();
		soundscripts\_snd::snd_message("shopping_district_panel_swing",self.origin);
		self.original_angles = self.angles;
		self rotateby((0,randomfloatrange(5,10),0),var_00,0,0.1);
		wait(var_00);
		self rotateby((0,-1 * randomfloatrange(5,10),0),var_00,0,0.1);
		wait(var_00);
		self rotateto(self.original_angles,var_00,0,0.1);
		wait(var_00);
		self.panel_state = "still";
	}
}

//Function Number: 108
sd_drone_kamikaze(param_00,param_01)
{
	level endon("end_kamikaze_newstyle");
	for(;;)
	{
		var_02 = maps\_shg_design_tools::sortbydistanceauto(level.flock_drones,level.player.origin);
		var_03 = randomint(2);
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			if(!isdefined(var_02[var_04]) || isdefined(var_02[var_04].attacking_player))
			{
				continue;
			}

			var_02[var_04] thread vehicle_scripts\_attack_drone::drone_kamikaze_player(param_01,param_00);
			var_02[var_04].attacking_player = 1;
			if(level.player istouching(param_00))
			{
				wait(randomfloatrange(0.1,0.2));
				continue;
			}

			wait(randomfloatrange(0.25,0.5));
		}

		wait(0.5);
	}
}

//Function Number: 109
sd_snake_crash_into_player(param_00)
{
	level endon("end_crash_into_player");
	for(;;)
	{
		foreach(var_02 in level.snakes)
		{
			if(isdefined(var_02))
			{
				while(distance(var_02.origin,level.player geteye()) < 300)
				{
					vehicle_scripts\_attack_drone::force_kamikaze(common_scripts\utility::random(param_00));
					wait(randomfloatrange(0.3,0.75));
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 110
canal_setup_pt1()
{
	thread canal_handle_car_door_shields_vis();
	thread canal_weapon_platform_vis_control();
	common_scripts\utility::flag_wait("sd_street_combat_complete");
	if(level.currentgen)
	{
		var_00 = ["enemy_canal_bridge1"];
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("dialogue_performing_arts_exit",var_00,15,0);
	}

	if(level.currentgen && !issubstr(level.transient_zone,"_overlookbar"))
	{
		level waittill("transients_canal_overlook_to_riverwalk");
	}

	thread canal_bridge_patrols_spawn();
	thread canal_weapon_guards_spawn_and_think();
	level.will_irons.ignoreall = 1;
	level.cormack.ignoreall = 1;
	level.jackson.ignoreall = 1;
	maps\_utility::battlechatter_off("allies");
	thread canal_balcony_smoke_and_spawn();
	thread sd_spawn_and_retreat_goals("trig_canal_bridge_reinforcements1","canal_bridge_reinforcements1",1);
	thread sd_spawn_and_retreat_goals("trig_canal_bridge_reinforcements2","canal_bridge_reinforcements2",1);
	thread canal_setup_dead_demo_team();
	var_01 = getent("enemy_sd_vehicle1","targetname");
	var_02 = getent("enemy_sd_vehicle3","targetname");
	var_03 = getentarray("zipline_cables","script_noteworthy");
	if(isdefined(var_03))
	{
		foreach(var_05 in var_03)
		{
			var_05 hide();
		}
	}

	var_07 = getentarray("color_ents_pt2","script_noteworthy");
	common_scripts\utility::array_thread(var_07,::common_scripts\utility::trigger_off);
}

//Function Number: 111
snd_final_music_think()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_reach_waterfall");
	soundscripts\_snd::snd_music_message("mus_canal_combat_done");
}

//Function Number: 112
canal_handle_car_door_shields_vis()
{
	var_00 = getentarray("canal_door_shields","script_noteworthy");
	common_scripts\utility::array_thread(var_00,::maps\_utility::hide_entity);
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_dead_demo_team1");
	common_scripts\utility::array_thread(var_00,::maps\_utility::show_entity);
	var_01 = getentarray("trig_door_shield","targetname");
	foreach(var_03 in var_01)
	{
		var_03 thread canal_door_button_hint_display();
	}
}

//Function Number: 113
canal_door_button_hint_display()
{
	var_00 = maps\_shg_utility::hint_button_trigger("x");
	self waittill("trigger");
	if(isdefined(var_00))
	{
		var_00 maps\_shg_utility::hint_button_clear();
	}
}

//Function Number: 114
canal_turret_vehicle()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_riverwalk"))
	{
		level waittill("transients_canal_overlook_to_riverwalk");
	}

	var_00 = getentarray("canal_vehicle2_passengers","script_noteworthy");
	maps\_utility::array_spawn_function_noteworthy("canal_vehicle2_passengers",::canal_turret_vehicle_passenger_think);
	var_01 = getent("enemy_sd_vehicle2","targetname");
	level.controllable_drone_swarm_target[1] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("enemy_sd_vehicle2");
	foreach(var_03 in level.controllable_drone_swarm_target[1].riders)
	{
		if(var_03.vehicle_position == 3)
		{
			var_04 = var_03;
		}
	}

	level.controllable_drone_swarm_target[1] waittill("reached_end_node");
	level.controllable_drone_swarm_target[1] maps\_vehicle::vehicle_unload("all_but_gunner");
}

//Function Number: 115
canal_turret_vehicle_passenger_think()
{
	self.ignoreall = 1;
	self.grenadeammo = 0;
	if(!isdefined(level.bridge_enemies))
	{
		level.bridge_enemies = [];
	}

	level.bridge_enemies[level.bridge_enemies.size] = self;
}

//Function Number: 116
canal_cormack_objective_convo()
{
	common_scripts\utility::flag_wait("sd_escaped_swarm");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("objective_canal_stairs_bottom_reached");
	level.player.show_land_assist_help = 0;
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_reach_upstairs");
	common_scripts\utility::flag_set("show_canal_weapon_platform");
	common_scripts\utility::flag_set("objective_canal_stairs_top_reached");
	level.will_irons maps\_utility::enable_cqbwalk();
	level.cormack maps\_utility::enable_cqbwalk();
	level.jackson maps\_utility::enable_cqbwalk();
	common_scripts\utility::flag_set("vo_canal_call_to_window");
	common_scripts\utility::flag_set("canal_window_check_on");
	var_00 = common_scripts\utility::getstruct("canal_objective_convo","targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	var_02 = common_scripts\utility::getstruct("struct_canal_upstairs_convo_will","targetname");
	var_03 = common_scripts\utility::getstruct("struct_canal_upstairs_convo_jackson","targetname");
	var_01 thread canal_cormack_move_to_window();
	thread disable_weapons_in_canal_view_room();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_updstairs_window_approach");
	common_scripts\utility::flag_set("canal_start_drone_travel");
	common_scripts\utility::flag_wait("canal_reached_window");
	common_scripts\utility::flag_set("objective_sd_cormack_convo_complete");
	common_scripts\utility::flag_set("no_land_assist_hint");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	maps\_player_exo::player_exo_deactivate();
	var_04 = maps\_utility::spawn_anim_model("player_arms",level.player.origin,level.player.angle);
	var_05 = maps\_utility::spawn_anim_model("binocs");
	var_06 = [var_04,var_05];
	var_01 maps\_anim::anim_first_frame(var_06,"seo_canal_debrief_scanning_intro_vm");
	var_04 hide();
	soundscripts\_snd::snd_message("seo_binocs_equip");
	var_05 hide();
	var_07 = 0.3;
	level.player playerlinktoblend(var_04,"tag_player",var_07);
	var_04 common_scripts\utility::delaycall(var_07,::show);
	var_05 common_scripts\utility::delaycall(var_07,::show);
	level.player common_scripts\utility::delaycall(var_07,::playerlinktoabsolute,var_04,"tag_player");
	var_01 thread maps\_anim::anim_single(var_06,"seo_canal_debrief_scanning_intro_vm");
	var_08 = maps\_utility::getanim_from_animname("seo_canal_debrief_scanning_intro_vm",var_04.animname);
	var_09 = getanimlength(var_08);
	var_01 canal_handle_player_binoc_controls(var_04,var_09);
	var_0A = common_scripts\utility::getstruct("struct_start_canal2_jackson","targetname");
	level.will_irons forceteleport(var_0A.origin,var_0A.angles);
	level.will_irons.ignoreall = 0;
	level.will_irons.canjumppath = 1;
	var_0B = getnode("canal_will_cover1","targetname");
	level.will_irons maps\_utility::set_goal_radius(15);
	level.will_irons maps\_utility::set_goal_node(var_0B);
	level.player unlink();
	level.player lerpfov(65,0);
	var_01 notify("stop_loop");
	var_01 maps\_utility::anim_stopanimscripted();
	level.player playerlinktoblend(var_04,"tag_player",0.3);
	var_01 maps\_anim::anim_single(var_06,"seo_canal_debrief_scanning_outro_vm");
	common_scripts\utility::flag_wait("demo_team_seen");
	common_scripts\utility::flag_set("canal_strategy_scene_complete");
	common_scripts\utility::flag_clear("no_land_assist_hint");
	level.player notify("canal_intro_scene_done");
	var_02 notify("convo_complete");
	var_03 notify("convo_complete");
	var_01 notify("stop_loop");
	level.cormack maps\_utility::anim_stopanimscripted();
	level.cormack.loopanims = [];
	level.cormack.loops = 0;
	level.cormack setgoalpos(level.cormack.origin);
	level.cormack.goalradius = 512;
	level.player unlink();
	var_04 delete();
	var_05 delete();
	level.player lerpfov(65,0.5);
	maps\_utility::autosave_now();
}

//Function Number: 117
disable_weapons_in_canal_view_room()
{
	level.player endon("canal_intro_scene_done");
	for(;;)
	{
		maps\_shg_design_tools::waittill_trigger_with_name("trig_updstairs_window_approach");
		level.player allowmelee(0);
		level.player disableweapons();
		level.player disableoffhandweapons();
		maps\_shg_design_tools::waittill_trigger_with_name("trig_updstairs_window_retreat");
		level.player allowmelee(1);
		level.player enableweapons();
		level.player enableoffhandweapons();
	}
}

//Function Number: 118
canal_cormack_move_to_window()
{
	thread maps\_anim::anim_reach_solo(level.cormack,"seo_canal_debrief_intro_cormack",undefined,1);
	var_00 = level.cormack common_scripts\utility::waittill_any_return("anim_reach_complete","override_anim_reach_play_binoc_scene");
	var_01 = ["seo_crk_overheremitchell","seo_crk_mitchellmoveit"];
	thread maps\_shg_utility::dialogue_reminder(level.cormack,"canal_reached_window",var_01);
	if(var_00 == "override_anim_reach_play_binoc_scene")
	{
		maps\_anim::anim_first_frame_solo(level.cormack,"seo_canal_debrief_intro_cormack");
	}

	maps\_anim::anim_single_solo(level.cormack,"seo_canal_debrief_intro_cormack");
	maps\_anim::anim_loop_solo(level.cormack,"seo_canal_debrief_kneeling_idle_cormack");
}

//Function Number: 119
canal_handle_player_binoc_controls(param_00,param_01)
{
	wait(param_01 - 0.8);
	thread canal_binoc_transition_in();
	thread maps\seoul_lighting::binocular_mwp_rim_flicker();
	thread maps\seoul_lighting::binocular_dof();
	thread maps\seoul_lighting::binocular_vision();
	wait(0.6);
	thread maps\_anim::anim_loop_solo(param_00,"seo_canal_debrief_scanning_start_loop_vm");
	level.cormack notify("override_anim_reach_play_binoc_scene");
	wait(1);
	common_scripts\utility::flag_set("vo_canal_strategy_scene");
	wait(0.5);
	self notify("stop_loop");
	param_00 maps\_utility::anim_stopanimscripted();
	self stopanimscripted();
	thread maps\_anim::anim_loop_solo(param_00,"seo_canal_debrief_scanning_platform_loop_vm");
	thread canal_convo_fov_shift_to_wp();
	common_scripts\utility::flag_wait("vo_havoc_launcher_line_done");
	self notify("stop_loop");
	param_00 maps\_utility::anim_stopanimscripted();
	self stopanimscripted();
	thread canal_convo_fov_shift_to_dead();
	maps\_anim::anim_single_solo(param_00,"seo_canal_debrief_scanning_platform_to_demoteam_vm");
	thread canal_highlight_dead_team();
	wait(0.5);
	self notify("stop_loop");
	param_00 maps\_utility::anim_stopanimscripted();
	self stopanimscripted();
	thread maps\_anim::anim_loop_solo(param_00,"seo_canal_debrief_scanning_demoteam_loop_vm");
	common_scripts\utility::flag_wait("vo_demo_team_lines_done");
	level.player lerpfov(45,0.5);
	var_02 = level.player common_scripts\utility::spawn_tag_origin();
	level.player unlink();
	level.player playerlinktodelta(param_00,"tag_player",1,25,60,30,25);
	thread canal_adssetfovzoomin();
	thread canal_binoc_hint();
	wait(1);
	common_scripts\utility::flag_wait("demo_team_seen");
	level notify("end_fovzoom");
	thread canal_binoc_transition_out();
	wait(0.5);
}

//Function Number: 120
canal_binoc_transition_in()
{
	var_00 = 0.5;
	var_01 = newhudelem();
	var_01.x = 0;
	var_01.y = 0;
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01 setshader("black",640,480);
	var_02 = newhudelem();
	var_02.x = 0;
	var_02.y = 0;
	var_02.horzalign = "fullscreen";
	var_02.vertalign = "fullscreen";
	var_02 setshader("white",640,480);
	level.binoc_overlay[1] = newhudelem();
	level.binoc_overlay[1].x = 0;
	level.binoc_overlay[1].y = 0;
	level.binoc_overlay[1].horzalign = "fullscreen";
	level.binoc_overlay[1].vertalign = "fullscreen";
	level.binoc_overlay[1] setshader("ugv_vignette_overlay",640,480);
	if(isdefined(var_00) && var_00 > 0)
	{
		level.binoc_overlay[1].alpha = 0;
		var_02.alpha = 0;
		var_01.alpha = 0;
		var_01 fadeovertime(var_00);
		var_01.alpha = 1;
		wait(var_00);
		thread canal_convo_fov_shift_on_start();
		var_02.alpha = 0;
		var_02 fadeovertime(0.5);
		var_02.alpha = 1;
		wait(var_00);
		var_01.alpha = 0;
		level.binoc_overlay[1].alpha = 1;
		var_02.alpha = 1;
		var_02 fadeovertime(var_00 + 0.5);
		var_02.alpha = 0;
		wait(var_00 + 0.5);
	}

	var_02 destroy();
	var_01 destroy();
}

//Function Number: 121
canal_binoc_transition_out()
{
	var_00 = 0.5;
	var_01 = newhudelem();
	var_01.x = 0;
	var_01.y = 0;
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01 setshader("black",640,480);
	if(isdefined(var_00) && var_00 > 0)
	{
		var_01.alpha = 0;
		var_01 fadeovertime(var_00);
		var_01.alpha = 1;
		soundscripts\_snd::snd_message("binocs_put_away");
		wait(var_00);
		level.binoc_overlay[1] destroy();
		var_01.alpha = 1;
		var_01 fadeovertime(var_00);
		var_01.alpha = 0;
		wait(var_00);
	}

	var_01 destroy();
}

//Function Number: 122
handle_enemy_highlighting_in_binocs()
{
	level endon("end_fovzoom");
	var_00 = getentarray("ammo_cache","targetname");
	var_01 = getentarray("smart_grenade_launcher","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	for(;;)
	{
		var_02 = getaiarray("axis");
		foreach(var_04 in var_02)
		{
			if(!isdefined(var_04.running_handle_hud_outline_binocs))
			{
				var_04.running_handle_hud_outline_binocs = 1;
				var_04 thread handle_hud_outline_binocs();
				var_04 thread remove_hud_outline_binocs();
			}
		}

		foreach(var_07 in var_00)
		{
			if(!isdefined(var_07.running_handle_hud_outline_binocs))
			{
				var_07.running_handle_hud_outline_binocs = 1;
				var_07 thread handle_hud_outline_binocs(6);
				var_07 thread remove_hud_outline_binocs();
			}
		}

		wait(0.1);
	}
}

//Function Number: 123
remove_hud_outline_binocs()
{
	level waittill("end_fovzoom");
	if(isdefined(self))
	{
		self hudoutlinedisable();
		self.running_handle_hud_outline_binocs = undefined;
	}
}

//Function Number: 124
handle_hud_outline_binocs(param_00)
{
	level endon("end_fovzoom");
	level.player.current_fov = 65;
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	for(;;)
	{
		if(maps\_shg_utility::entity_is_in_circle(self,level.player,level.player.current_fov,115))
		{
			self hudoutlineenable(param_00,1);
		}
		else
		{
			self hudoutlinedisable();
		}

		wait(0.1);
	}
}

//Function Number: 125
canal_adssetfovzoomin()
{
	level endon("end_fovzoom");
	thread handle_enemy_highlighting_in_binocs();
	var_00 = 65;
	var_01 = 5;
	var_02 = 10;
	var_03 = 3;
	var_04 = 0.05;
	var_05 = 0;
	while(!common_scripts\utility::flag("canal_strategy_scene_complete"))
	{
		wait 0.05;
		var_06 = level.player getnormalizedmovement();
		if(var_06[0] > 0.2 && var_02 - var_03 > var_01)
		{
			var_02 = var_02 - var_03;
			var_04 = 0.05;
			if(var_05 != 1)
			{
				soundscripts\_snd::snd_message("canal_binocs_stop_zoom_out");
				soundscripts\_snd::snd_message("canal_binocs_zoom_in");
				var_05 = 1;
			}
		}
		else if(var_06[0] < -0.2 && var_02 + var_03 < var_00)
		{
			var_02 = var_02 + var_03;
			var_04 = 0.05;
			if(var_05 != -1)
			{
				soundscripts\_snd::snd_message("canal_binocs_stop_zoom_in");
				soundscripts\_snd::snd_message("canal_binocs_zoom_out");
				var_05 = -1;
			}
		}
		else if(var_06[0] == 0 && var_02 + var_03 < var_00)
		{
			wait 0.05;
		}
		else if(var_05 != 0)
		{
			soundscripts\_snd::snd_message("canal_binocs_stop_zoom_in");
			soundscripts\_snd::snd_message("canal_binocs_stop_zoom_out");
			var_05 = 0;
		}

		level.player.current_fov = var_02;
		level.player thread maps\_utility::lerp_fov_overtime(var_04,var_02);
	}
}

//Function Number: 126
binoc_hint_breakout()
{
	if(length(level.player getnormalizedcameramovements()) > 0.1)
	{
		level.player.binocdidpan = 1;
	}

	if(length(level.player getnormalizedmovement()) > 0.1)
	{
		level.player.binocdidzoom = 1;
	}

	if(isdefined(level.player.binocdidzoom) && isdefined(level.player.binocdidpan))
	{
		return 1;
	}

	return 0;
}

//Function Number: 127
canal_binoc_hint()
{
	level endon("end_fovzoom");
	maps\_utility::hintdisplayhandler("binoc_controls",4);
}

//Function Number: 128
canal_highlight_dead_team()
{
	foreach(var_01 in level.dead_demo_team)
	{
		if(isdefined(var_01))
		{
			var_01 hudoutlineenable(4,1);
		}

		wait(0.1);
	}

	common_scripts\utility::flag_wait("demo_team_seen");
	foreach(var_01 in level.dead_demo_team)
	{
		if(isdefined(var_01))
		{
			var_01 hudoutlinedisable();
		}
	}
}

//Function Number: 129
canal_convo_fov_shift_on_start(param_00)
{
	var_01 = 45;
	level.player lerpfov(45,0.5);
}

//Function Number: 130
canal_convo_fov_shift_to_wp(param_00)
{
	var_01 = 35;
	level.player lerpfov(45,0.5);
	wait(0.5);
	soundscripts\_snd::snd_message("canal_binocs_zoom_in");
	level.player lerpfov(20,0.5);
	wait(0.5);
	soundscripts\_snd::snd_message("canal_binocs_stop_zoom_in");
	level.player lerpfov(25,0.5);
	soundscripts\_snd::snd_message("canal_binocs_zoom_out");
	wait(0.5);
	soundscripts\_snd::snd_message("canal_binocs_stop_zoom_out");
}

//Function Number: 131
canal_convo_fov_shift_to_dead(param_00)
{
	var_01 = 25;
	soundscripts\_snd::snd_message("canal_binocs_zoom_out");
	level.player lerpfov(45,0.5);
	wait(0.5);
	soundscripts\_snd::snd_message("canal_binocs_stop_zoom_out");
	wait(0.5);
	soundscripts\_snd::snd_message("canal_binocs_zoom_in");
	level.player lerpfov(15,1);
	wait(1);
	soundscripts\_snd::snd_message("canal_binocs_stop_zoom_in");
	soundscripts\_snd::snd_message("canal_binocs_zoom_out");
	level.player lerpfov(20,0.5);
	wait(0.5);
	soundscripts\_snd::snd_message("canal_binocs_stop_zoom_out");
	wait(0.5);
	soundscripts\_snd::snd_message("canal_binocs_zoom_in");
	level.player lerpfov(10,1);
	wait(1);
	soundscripts\_snd::snd_message("canal_binocs_stop_zoom_in");
}

//Function Number: 132
canal_convo_fov_shift_off(param_00)
{
	if(!isdefined(level.origfov))
	{
		level.origfov = 65;
	}

	level.player lerpfov(level.origfov,0.5);
}

//Function Number: 133
canal_video_board_cycle()
{
	for(var_00 = 0;!common_scripts\utility::flag("shut_down_panel");var_00 = 0)
	{
		panel_on();
		wait(randomfloatrange(1,3));
		while(var_00 < randomintrange(3,6))
		{
			panel_off();
			wait(randomfloatrange(0.05,0.1));
			panel_on();
			wait(randomfloatrange(0.5,1.5));
			var_00++;
		}
	}

	panel_off();
	wait(randomfloatrange(0.1,0.3));
	panel_on();
	wait(0.5);
	panel_off();
	wait(randomfloatrange(0.1,0.3));
	panel_on();
	wait(0.5);
	panel_off();
}

//Function Number: 134
panel_off()
{
	if(level.currentgen)
	{
		level waittill("transients_subway_to_shopping_dist");
	}

	var_00 = getent("canal_vista_panel_on","targetname");
	var_01 = getent("canal_vista_panel_off","targetname");
	var_01 show();
	var_00 hide();
}

//Function Number: 135
panel_on()
{
	if(level.currentgen)
	{
		level waittill("transients_subway_to_shopping_dist");
	}

	var_00 = getent("canal_vista_panel_on","targetname");
	var_01 = getent("canal_vista_panel_off","targetname");
	var_01 hide();
	var_00 show();
}

//Function Number: 136
canal_bridge_patrols_spawn()
{
	while(level.currentgen && !istransientloaded("seoul_canal_overlook_bar_tr"))
	{
		wait(0.05);
	}

	level.bridge_enemies = [];
	var_00 = 5;
	var_01 = getent("sd_goal_bridge1","targetname");
	var_02 = getent("sd_goal_bridge1_retreat","targetname");
	maps\_utility::array_spawn_function_noteworthy("enemy_canal_bridge1",::canal_bridge_patrol_think);
	var_03 = maps\_utility::array_spawn_noteworthy("enemy_canal_bridge1",1);
	common_scripts\utility::flag_wait("wakeup_canal_patrols");
	level.bridge_enemies = maps\_utility::array_removedead_or_dying(level.bridge_enemies);
	foreach(var_05 in level.bridge_enemies)
	{
		var_05.ignoreall = 0;
		var_05 notify("end_patrol");
		var_05 notify("stop_going_to_node");
		if(isdefined(var_01))
		{
			var_05 setgoalvolumeauto(var_01);
		}

		var_05.target = undefined;
		var_05 thread change_color_node_quick();
		var_05 maps\_utility::add_damage_function(::canal_enemy_damage_function);
	}

	while(level.bridge_enemies.size > var_00)
	{
		level.bridge_enemies = maps\_utility::array_removedead_or_dying(level.bridge_enemies);
		wait(0.05);
	}

	if(isdefined(var_02))
	{
		level.bridge_enemies = maps\_utility::array_removedead_or_dying(level.bridge_enemies);
		foreach(var_05 in level.bridge_enemies)
		{
			var_05 setgoalvolumeauto(var_02);
		}
	}
}

//Function Number: 137
canal_enemy_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_01 == level.player)
	{
		self notify("notice_player");
	}

	if(!common_scripts\utility::flag("bombs_picked_up"))
	{
		if(param_01 == level.cormack || param_01 == level.jackson)
		{
			if(self.health > 0)
			{
				self.health = self.health + int(param_00 * 0.5);
				return;
			}
		}
	}
}

//Function Number: 138
canal_bridge_patrol_think()
{
	self.ignoreall = 1;
	self.patrol_walk_twitch = undefined;
	self.patrol_walk_anim = undefined;
	self.grenadeammo = 0;
	level.bridge_enemies[level.bridge_enemies.size] = self;
	self.script_stealth = 1;
	thread maps\_patrol::patrol();
}

//Function Number: 139
canal_weapon_guards_spawn_and_think()
{
	createthreatbiasgroup("cormack_group");
	createthreatbiasgroup("weapon_platform_guards");
	createthreatbiasgroup("player_and_will");
	level.player setthreatbiasgroup("player_and_will");
	level.will_irons setthreatbiasgroup("player_and_will");
	var_00 = maps\_utility::array_spawn_noteworthy("enemy_canal_wall1L",1);
	var_01 = maps\_utility::array_spawn_noteworthy("enemy_canal_wall1R",1);
	var_02 = common_scripts\utility::array_combine(var_00,var_01);
	var_03 = getent("sd_goal_wallL","targetname");
	var_04 = getent("sd_goal_wallR","targetname");
	foreach(var_06 in var_02)
	{
		var_06.ignoreall = 1;
		var_06.patrol_walk_twitch = undefined;
		var_06.patrol_walk_anim = undefined;
		var_06.grenadeammo = 0;
		var_06.script_stealth = 1;
		var_06 thread maps\_patrol::patrol();
		var_06 thread change_color_node_quick();
		var_06 maps\_utility::add_damage_function(::canal_enemy_damage_function);
		wait(0.05);
	}

	common_scripts\utility::flag_wait("wakeup_canal_patrols");
	foreach(var_06 in var_02)
	{
		var_06.ignoreall = 0;
		var_06 notify("end_patrol");
		var_06 notify("stop_going_to_node");
		var_06.target = undefined;
		var_06.grenadeammo = 0;
		var_06 setthreatbiasgroup("weapon_platform_guards");
	}

	level.cormack setthreatbiasgroup("cormack_group");
	level.jackson setthreatbiasgroup("cormack_group");
	setthreatbias("cormack_group","weapon_platform_guards",10000);
	setthreatbias("weapon_platform_guards","cormack_group",10000);
	foreach(var_06 in var_00)
	{
		var_06 setgoalvolumeauto(var_03);
		var_06 thread canal_wall_enemy_think();
	}

	foreach(var_06 in var_01)
	{
		var_06 setgoalvolumeauto(var_04);
		var_06 thread canal_wall_enemy_think();
	}

	common_scripts\utility::flag_wait("bombs_picked_up");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_reach_waterfall");
	var_0E = maps\_utility::array_removedead_or_dying(var_02);
	foreach(var_06 in var_02)
	{
		if(isalive(var_06))
		{
			var_06 bloody_death();
			wait(randomfloatrange(0.3,0.5));
		}

		var_02 = maps\_utility::array_removedead_or_dying(var_02);
	}
}

//Function Number: 140
canal_wall_enemy_think()
{
	self endon("death");
	thread canal_wall_enemy_close_check();
	self waittill("notice_player");
	self setthreatbiasgroup("axis");
	self getenemyinfo(level.player);
	self.favoriteenemy = level.player;
}

//Function Number: 141
canal_wall_enemy_close_check()
{
	self endon("death");
	level endon("notice_player");
	level.player endon("death");
	while(distancesquared(level.player.origin,self.origin) > squared(450))
	{
		wait(0.25);
	}

	self notify("notice_player");
}

//Function Number: 142
canal_drone_guard_sequence()
{
	level.enemy_canal_drone_guards = [];
	var_00 = getent("enemy_canal_drone_controller","targetname");
	var_01 = getent("enemy_canal_guard1","targetname");
	var_00 = var_00 maps\_utility::spawn_ai(1);
	var_01 = var_01 maps\_utility::spawn_ai(1);
	level.enemy_canal_drone_guards[level.enemy_canal_drone_guards.size] = var_00;
	level.enemy_canal_drone_guards[level.enemy_canal_drone_guards.size] = var_01;
	var_02 = getnode("cover_prone_other_guy","targetname");
	var_03 = getnode("cover_prone_cormack","targetname");
	var_02 disconnectnode();
	var_03 disconnectnode();
	foreach(var_05 in level.enemy_canal_drone_guards)
	{
		var_05 thread canal_drone_guard_think();
	}

	while(level.enemy_canal_drone_guards.size > 1)
	{
		level.enemy_canal_drone_guards = maps\_utility::array_removedead_or_dying(level.enemy_canal_drone_guards);
		wait(0.05);
	}

	wait(1);
	foreach(var_05 in level.enemy_canal_drone_guards)
	{
		var_05.ignoreall = 0;
		var_05 notify("wakeup");
		magicbullet(level.will_irons.weapon,level.will_irons gettagorigin("tag_flash"),var_05 geteye());
	}

	var_09 = common_scripts\utility::getstruct("sd_fake_shot_glass","targetname");
	magicbullet(level.jackson.weapon,level.jackson gettagorigin("tag_flash"),var_09.origin);
	while(level.enemy_canal_drone_guards.size > 0)
	{
		level.enemy_canal_drone_guards = maps\_utility::array_removedead_or_dying(level.enemy_canal_drone_guards);
		wait(0.05);
	}

	var_02 connectnode();
	var_03 connectnode();
}

//Function Number: 143
canal_drone_guard_think()
{
	self.ignoreall = 1;
	self.grenadeammo = 0;
	self.allowdeath = 1;
	if(level.gameskill <= 1)
	{
		self.health = 1;
	}

	thread canal_drone_guards_move_to_struct_and_loop_animation();
	thread canal_guard_player_close_check();
	self addaieventlistener("grenade danger");
	self addaieventlistener("gunshot");
	self addaieventlistener("bulletwhizby");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"damage");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"ai_event");
	maps\_utility::add_func(::common_scripts\utility::flag_set,"wakeup_drone_guards");
	thread maps\_utility::do_wait_any();
	common_scripts\utility::flag_wait("wakeup_drone_guards");
	self.ignoreall = 0;
	self stopanimscripted();
	remove_patrol_anim_set();
	self getenemyinfo(level.player);
	self notify("stop_going_to_node");
	var_00 = common_scripts\utility::getstruct(self.target,"targetname");
	var_00 notify("wakeup_drone_guards");
}

//Function Number: 144
canal_guard_player_close_check()
{
	self endon("death");
	level endon("wakeup_drone_guards");
	level.player endon("death");
	while(distancesquared(level.player.origin,self.origin) > squared(350))
	{
		wait(0.25);
	}

	common_scripts\utility::flag_set("wakeup_drone_guards");
}

//Function Number: 145
canal_drone_guards_move_to_struct_and_loop_animation()
{
	self endon("death");
	self endon("wakeup_drone_guards");
	var_00 = common_scripts\utility::getstruct(self.target,"targetname");
	var_00 maps\_anim::anim_generic_loop(self,var_00.animation,"wakeup_drone_guards");
}

//Function Number: 146
nag_lines_if_player_skips_charges()
{
	var_00 = getent("trig_pick_up_charges","targetname");
	var_00 waittill("trigger");
	if(common_scripts\utility::flag("bombs_reached"))
	{
		return;
	}

	var_01 = ["seo_wil_getthecharges","seo_wil_grabthosecharges"];
	thread maps\_shg_utility::dialogue_reminder(level,"bombs_reached",var_01);
}

//Function Number: 147
canal_fight_to_explosives_sequence()
{
	common_scripts\utility::flag_wait("canal_strategy_scene_complete");
	common_scripts\utility::flag_clear("flag_autofocus_binoc_on");
	thread remove_dropped_guns_near_explosives();
	thread nag_lines_if_player_skips_charges();
	level.will_irons.ignoreall = 0;
	level.will_irons.canjumppath = 1;
	level.cormack.ignoreall = 0;
	level.jackson.ignoreall = 0;
	level.cormack.ignoresuppression = 1;
	level.jackson.ignoresuppression = 1;
	level.will_irons maps\_utility::disable_cqbwalk();
	level.cormack maps\_utility::disable_cqbwalk();
	level.jackson maps\_utility::disable_cqbwalk();
	maps\_utility::battlechatter_on("allies");
	var_00 = common_scripts\utility::getstruct("struct_canal_upstairs_convo_will","targetname");
	var_01 = common_scripts\utility::getstruct("struct_canal_upstairs_convo_cormack","targetname");
	var_02 = common_scripts\utility::getstruct("struct_canal_upstairs_convo_jackson","targetname");
	var_00 notify("convo_complete");
	var_01 notify("convo_complete");
	var_02 notify("convo_complete");
	var_03 = getent("canal_window_blocker","targetname");
	var_03 connectpaths();
	var_03 delete();
	level.player.show_land_assist_help = 1;
	if(!isdefined(level.player_repulsor))
	{
		level.player_repulsor = missile_createrepulsorent(level.player,10000,500);
	}

	var_04 = getnode("canal_will_cover1","targetname");
	level.will_irons maps\_utility::set_goal_radius(15);
	level.will_irons maps\_utility::set_goal_node(var_04);
	var_05 = getnode("cover_prone_cormack","targetname");
	var_06 = getnode("cover_prone_other_guy","targetname");
	level.cormack maps\_utility::set_goal_radius(15);
	level.jackson maps\_utility::set_goal_radius(15);
	level.cormack maps\_utility::set_goal_node(var_05);
	level.jackson maps\_utility::set_goal_node(var_06);
	wait(0.5);
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_player_exo::player_exo_activate();
	wait(3);
	common_scripts\utility::flag_set("wakeup_canal_patrols");
	common_scripts\utility::flag_wait("canal_jump_complete");
	wait(2.5);
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_wait("bombs_reached");
	common_scripts\utility::flag_set("vo_canal_grab_explosives");
	var_07 = ["seo_wil_getthecharges","seo_wil_grabthosecharges"];
	thread maps\_shg_utility::dialogue_reminder(level.will_irons,"bombs_picked_up",var_07);
	common_scripts\utility::flag_wait("bombs_picked_up");
	common_scripts\utility::flag_set("objective_sd_pick_up_bombs");
	common_scripts\utility::flag_set("spawn_canal_razorback");
}

//Function Number: 148
remove_dropped_guns_near_explosives()
{
	var_00 = getentarray("vol_dropped_gun_check_volume","targetname");
	for(;;)
	{
		foreach(var_02 in var_00)
		{
			var_03 = getweaponarray();
			foreach(var_05 in var_03)
			{
				if(var_05 istouching(var_02))
				{
					var_05 delete();
				}
			}
		}

		wait(0.25);
	}
}

//Function Number: 149
canal_turn_player()
{
	var_00 = spawnstruct();
	var_00.origin = level.player.origin;
}

//Function Number: 150
canal_laser()
{
	self laseron("lag_snipper_laser");
}

//Function Number: 151
canal_balcony_smoke_and_spawn()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_bridge_reinforcements1");
	var_00 = getent("canal_balcony_smoke_start","targetname");
	var_01 = getent("canal_balcony_smoke_target1","targetname");
	var_02 = getent("canal_balcony_smoke_target2","targetname");
	magicgrenade("smoke_grenade_cheap",var_00.origin,var_00.origin,0.5,0);
	magicgrenade("smoke_grenade_cheap",var_01.origin,var_01.origin,1,0);
	magicgrenade("smoke_grenade_cheap",var_02.origin,var_02.origin,1,0);
	wait(1.5);
	var_03 = getent("canal_zip_smoke_start2","targetname");
	var_04 = getent("canal_zip_smoke_target1","targetname");
	var_05 = getent("canal_zip_smoke_target2","targetname");
	wait(0.3);
	wait(1.5);
	var_06 = [];
	var_06[var_06.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("canal_enemy_bridge_balcony_zipline1","canal_zipline_bridge2_start1");
	wait(0.5);
	var_06[var_06.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("canal_enemy_bridge_balcony_zipline1","canal_zipline_bridge2_start2");
	wait(0.5);
	var_06[var_06.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("canal_enemy_bridge_balcony_zipline1","canal_zipline_bridge2_start3");
	wait(0.5);
	thread sd_zipline_enemy_think(var_06);
	var_07 = getent("canal_bridge_balcony_rpg","script_noteworthy");
	for(var_08 = 0;var_08 < 1;var_08++)
	{
		var_09 = var_07 maps\_shg_design_tools::actual_spawn(1);
		var_09.grenadeammo = 0;
		var_09 maps\_utility::add_damage_function(::canal_enemy_damage_function);
	}
}

//Function Number: 152
canal_setup_dead_demo_team()
{
	var_00 = getent("trig_canal_dead_demo_team1","targetname");
	var_01 = getent("trig_canal_dead_demo_team2","targetname");
	var_02 = getent("trig_canal_dead_demo_team3","targetname");
	var_03 = getent("trig_canal_dead_demo_team4","targetname");
	level.dead_demo_team = [];
	thread canal_spawn_dead_demo_team(var_00,var_01);
	thread canal_spawn_dead_demo_team(var_03,var_02);
	thread canal_delete_dead_demo_team(var_01,var_00);
	thread canal_delete_dead_demo_team(var_02,var_03);
}

//Function Number: 153
canal_handle_dead_demo_team()
{
	var_00 = getent("canal_dead_demo_team1","targetname");
	var_01 = getent("canal_dead_demo_team2","targetname");
	var_02 = getent("canal_dead_demo_team3","targetname");
	var_03 = getent("canal_dead_demo_team4","targetname");
	var_04 = getent("canal_dead_demo_team5","targetname");
	var_05 = getent("canal_origin_dead_demo_team","targetname");
	if(level.nextgen)
	{
		var_06 = maps\_utility::dronespawn_bodyonly(var_00);
		var_07 = maps\_utility::dronespawn_bodyonly(var_01);
		var_08 = maps\_utility::dronespawn_bodyonly(var_02);
		var_09 = maps\_utility::dronespawn_bodyonly(var_03);
		var_0A = maps\_utility::dronespawn_bodyonly(var_04);
	}
	else
	{
		var_06 = maps\_utility::dronespawn_bodyonly(var_05);
		wait(0.05);
		var_07 = maps\_utility::dronespawn_bodyonly(var_05);
		wait(0.05);
		var_08 = maps\_utility::dronespawn_bodyonly(var_05);
		wait(0.05);
		var_09 = maps\_utility::dronespawn_bodyonly(var_05);
		wait(0.05);
		var_0A = maps\_utility::dronespawn_bodyonly(var_05);
	}

	var_06 setcontents(0);
	var_07 setcontents(0);
	var_08 setcontents(0);
	var_09 setcontents(0);
	var_0A setcontents(0);
	var_06 maps\_utility::gun_remove();
	var_07 maps\_utility::gun_remove();
	var_08 maps\_utility::gun_remove();
	var_09 maps\_utility::gun_remove();
	var_0A maps\_utility::gun_remove();
	level.dead_demo_team = [var_06,var_07,var_08,var_09,var_0A];
	foreach(var_0C in level.dead_demo_team)
	{
		var_0C.animname = "generic";
	}

	var_00 thread maps\_anim::anim_first_frame_solo(var_06,"dead_body_pose1");
	var_01 thread maps\_anim::anim_first_frame_solo(var_07,"dead_body_pose2");
	var_02 thread maps\_anim::anim_first_frame_solo(var_08,"dead_body_pose3");
	var_03 thread maps\_anim::anim_first_frame_solo(var_09,"dead_body_pose4");
	var_04 thread maps\_anim::anim_first_frame_solo(var_0A,"dead_body_pose5");
}

//Function Number: 154
canal_spawn_dead_demo_team(param_00,param_01)
{
	for(;;)
	{
		param_00 waittill("trigger");
		param_01 waittill("trigger");
		if(level.dead_demo_team.size > 0)
		{
			foreach(var_03 in level.dead_demo_team)
			{
				if(isdefined(var_03.tag))
				{
					var_03.tag delete();
				}

				if(isdefined(var_03))
				{
					var_03 delete();
				}
			}
		}

		canal_handle_dead_demo_team();
		wait(0.05);
	}
}

//Function Number: 155
canal_delete_dead_demo_team(param_00,param_01)
{
	for(;;)
	{
		param_00 waittill("trigger");
		param_01 waittill("trigger");
		if(level.dead_demo_team.size > 0)
		{
			foreach(var_03 in level.dead_demo_team)
			{
				if(isdefined(var_03.tag))
				{
					var_03.tag delete();
				}

				if(isdefined(var_03))
				{
					var_03 delete();
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 156
handle_outline_on_grenade_launcher()
{
	var_00 = getent("smart_grenade_launcher","targetname");
	while(isdefined(var_00))
	{
		var_00 hudoutlinedisable(6,1);
		level notify("end_highlight_custom");
		while(isdefined(var_00) && distance(var_00.origin,level.player.origin) > 300)
		{
			wait 0.05;
		}

		if(!isdefined(var_00))
		{
			break;
		}

		var_00 thread highlight_custom();
		while(isdefined(var_00) && distance(var_00.origin,level.player.origin) <= 300)
		{
			wait 0.05;
		}

		wait 0.05;
	}

	level notify("end_highlight_custom");
	setsaveddvar("r_hudoutlinewidth",2);
}

//Function Number: 157
highlight_custom()
{
	level endon("end_highlight_custom");
	setsaveddvar("r_hudoutlinepostmode",2);
	self hudoutlineenable(6,1,0);
	while(isdefined(self) && level.gameskill <= 1)
	{
		for(var_00 = 1;var_00 < 4;var_00++)
		{
			setsaveddvar("r_hudoutlinewidth",var_00);
			setsaveddvar("r_hudoutlinepostmode",0);
			if(!isdefined(self))
			{
				return;
			}

			self hudoutlineenable(6,1,0);
			wait(0.1);
		}

		for(var_00 = 4;var_00 > 0;var_00--)
		{
			setsaveddvar("r_hudoutlinewidth",var_00);
			setsaveddvar("r_hudoutlinepostmode",0);
			if(!isdefined(self))
			{
				return;
			}

			self hudoutlineenable(6,1,0);
			wait(0.1);
		}
	}
}

//Function Number: 158
handle_dropped_gun_angles()
{
	var_00 = getent("smart_grenade_launcher","targetname");
	var_01 = common_scripts\utility::getstruct("struct_grenade_launcher_gun_swap","targetname");
	for(;;)
	{
		level.player waittill("pickup",var_02,var_03);
		if(isdefined(var_03) && var_02 == var_00)
		{
			level.player givemaxammo("iw5_microdronelaunchersmartgrenade_sp");
			wait(1);
			var_03.origin = var_01.origin;
			var_03.angles = var_01.angles;
			break;
		}
	}
}

//Function Number: 159
canal_handle_bomb_pickup()
{
	thread handle_outline_on_grenade_launcher();
	thread handle_dropped_gun_angles();
	if(level.currentgen && !issubstr(level.transient_zone,"_overlookbar"))
	{
		level waittill("transients_canal_overlook_to_riverwalk");
	}

	var_00 = getent("trig_sd_pickup_bombs","targetname");
	var_00 sethintstring(&"SEOUL_PICKUP_EXPLOSIVES_HINT");
	var_01 = getent("objective_sd_origin_bombs","targetname");
	var_02 = var_00 maps\_shg_utility::hint_button_position("x",var_01.origin,undefined,500,undefined,var_00);
	maps\_utility::trigger_wait_targetname("trig_sd_pickup_bombs");
	common_scripts\utility::flag_set("bombs_picked_up");
	var_02 maps\_shg_utility::hint_button_clear();
	var_00 sethintstring("");
	var_00 common_scripts\utility::trigger_off();
	var_03 = getent("bomb_pickup","targetname");
	var_03 hide();
}

//Function Number: 160
give_player_smart_grenade_launcher()
{
	var_00 = level.player getcurrentweapon();
	level.player takeweapon(var_00);
	level.player giveweapon("iw5_microdronelaunchersmartgrenade_sp");
	level.player switchtoweapon("iw5_microdronelaunchersmartgrenade_sp");
}

//Function Number: 161
canal_irons_open_door()
{
	var_00 = common_scripts\utility::getstruct("canal_struct_door_kick","targetname");
	level.will_irons.animname = "will_irons";
	common_scripts\utility::flag_wait("bombs_picked_up");
	maps\_utility::clear_all_color_orders("allies");
	var_00 maps\_anim::anim_reach_solo(level.will_irons,"foyer_door_kick_a");
	var_01 = getnode("canal_cover_stairs","targetname");
	level.will_irons maps\_utility::set_goal_radius(30);
	level.will_irons maps\_utility::set_goal_node(var_01);
	var_00 maps\_anim::anim_single_solo(level.will_irons,"foyer_door_kick_a");
	level.will_irons maps\_utility::enable_ai_color_dontmove();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_will_cover1");
}

//Function Number: 162
canal_fight_to_weapon_platform()
{
	common_scripts\utility::flag_wait("bombs_picked_up");
	thread canal_spawn_razorback();
	thread canal_enemy_setup_post_explosive_pickup();
	thread canal_middle_weapon_guards();
	thread canal_wall_reinforcements();
	thread canal_waterfall_last_fight();
	var_00 = getentarray("color_ents_pt1","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(var_02.classname == "trigger_multiple")
		{
			var_02 common_scripts\utility::trigger_off();
		}
	}

	var_04 = getentarray("color_ents_pt2","script_noteworthy");
	common_scripts\utility::array_thread(var_04,::common_scripts\utility::trigger_on);
	var_05 = getent("canal_goal_balcony","targetname");
	var_06 = getaiarray("axis");
	foreach(var_08 in var_06)
	{
		if(var_08 istouching(var_05) && isalive(var_08))
		{
			var_08 delete();
		}
	}

	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("vo_bomb_planting_instructions");
	common_scripts\utility::flag_waitopen("vo_bomb_planting_instructions");
	common_scripts\utility::flag_set("spawn_canal_razorback");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_reach_waterfall");
	var_0A = getaiarray("axis");
	var_0A = maps\_utility::array_removedead_or_dying(var_0A);
	foreach(var_08 in var_0A)
	{
		var_08.health = 10;
	}

	common_scripts\utility::flag_wait("middle_weapon_guards_dead");
	common_scripts\utility::flag_set("prep_will_for_finale");
	soundscripts\_snd::snd_music_message("mus_canal_combat_done");
	common_scripts\utility::flag_wait("bomb_plant_start");
}

//Function Number: 163
handle_will_irons_movement()
{
	while(level.security_drones.size > 1)
	{
		level.security_drones = common_scripts\utility::array_removeundefined(level.security_drones);
		wait 0.05;
	}

	level notify("will_push_forward_01");
	while(level.security_drones.size > 0)
	{
		level.security_drones = common_scripts\utility::array_removeundefined(level.security_drones);
		wait 0.05;
	}

	if(!common_scripts\utility::flag("prep_will_for_finale"))
	{
		level.will_irons.goalradius = 256;
	}

	var_00 = getent("trig_move_will_to_canal_pos2","targetname");
	var_00 notify("trigger",level.player);
	var_00 = getent("trig_will_move_security_drones","targetname");
	var_00 notify("trigger",level.player);
	level notify("will_push_forward_02");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_move_to_final_color");
	maps\_utility::activate_trigger_with_targetname("trig_move_will_to_canal_pos3");
	level notify("will_push_forward_03");
}

//Function Number: 164
canal_waterfall_last_fight()
{
	thread spawn_security_drones();
	thread handle_will_irons_movement();
	waittill_spawn_waterfall_fight();
	var_00 = getentarray("spawner_last_fight_01","targetname");
	var_01 = getnodearray("node_last_fight_cover","targetname");
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		var_05 = common_scripts\utility::random(var_00) maps\_utility::spawn_ai();
		if(!isdefined(var_05))
		{
			continue;
		}

		var_05 setgoalnode(var_04);
		var_05.goalradius = 256;
		var_02[var_02.size] = var_05;
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_dead_demo_team3");
	foreach(var_05 in var_02)
	{
		if(isdefined(var_05))
		{
			if(common_scripts\utility::cointoss())
			{
				var_05.health = 1;
				continue;
			}

			var_05 bloody_death(randomfloat(1));
		}
	}
}

//Function Number: 165
monitor_change_security_drone_gotos()
{
	var_00 = common_scripts\utility::getstructarray("struct_security_attack_node","targetname");
	var_01 = common_scripts\utility::getstructarray("struct_security_attack_node_pos1","targetname");
	var_02 = common_scripts\utility::getstructarray("struct_security_attack_node_pos2","targetname");
	var_03 = common_scripts\utility::getstructarray("struct_security_attack_node_pos3","targetname");
	var_04 = common_scripts\utility::getstructarray("struct_security_attack_node_posf1","targetname");
	var_05 = common_scripts\utility::getstructarray("struct_security_attack_node_posf2","targetname");
	var_06 = maps\_shg_design_tools::array_combine_multiple(var_00,var_01,var_02,var_03,var_04,var_05);
	var_07 = getent("vol_canals_security_drone_fight_pos1","targetname");
	var_08 = getent("vol_canals_security_drone_fight_pos2","targetname");
	var_09 = getent("vol_canals_security_drone_fight_pos3","targetname");
	var_0A = getent("vol_canals_security_drone_fight_posf1","targetname");
	var_0B = getent("vol_canals_security_drone_fight_posf2","targetname");
	for(;;)
	{
		if(level.player istouching(var_07))
		{
			level.player.drone_attack_nodes = var_01;
			while(level.player istouching(var_07))
			{
				wait 0.05;
			}
		}
		else if(level.player istouching(var_08))
		{
			level.player.drone_attack_nodes = var_02;
			while(level.player istouching(var_08))
			{
				wait 0.05;
			}
		}
		else if(level.player istouching(var_09))
		{
			level.player.drone_attack_nodes = var_03;
			while(level.player istouching(var_09))
			{
				wait 0.05;
			}
		}
		else if(level.player istouching(var_0A))
		{
			level.player.drone_attack_nodes = var_04;
			while(level.player istouching(var_0A))
			{
				wait 0.05;
			}
		}
		else if(level.player istouching(var_0B))
		{
			level.player.drone_attack_nodes = var_05;
			while(level.player istouching(var_0B))
			{
				wait 0.05;
			}
		}
		else
		{
			level.player.drone_attack_nodes = var_06;
		}

		wait 0.05;
	}
}

//Function Number: 166
handle_security_drone_hit()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		security_drone_hit_react(var_00,var_01,var_02,var_03,var_04);
	}
}

//Function Number: 167
security_drone_hit_react(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	if(issubstr(param_04,"BULLET"))
	{
		playfx(common_scripts\utility::getfx("sparks_burst_a_nolight"),param_03);
		self dodamage(param_00 * 3,param_01.origin);
		wait(1);
		return;
	}

	self notify("flying_attack_drone_goal_update");
	self notify("drone_security_prepare_attack");
	self notify("drone_security_prepare_attack_relay");
	toss_security_drone(param_02,param_03,param_04);
	thread vehicle_scripts\_pdrone_security::flying_attack_drone_goal_update();
	thread vehicle_scripts\_pdrone_security::drone_security_prepare_attack(0);
}

//Function Number: 168
toss_security_drone(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = vectornormalize(self.origin - param_01);
	var_04 = vectortoangles(var_03);
	var_05 = self.origin + var_04 * randomintrange(20,50);
	playfx(common_scripts\utility::getfx("sparks_burst_a_nolight"),self.origin);
	var_06 = randomintrange(9,18);
	var_07 = self.origin;
	var_08 = 0;
	self clearlookatent();
	for(var_09 = 0;var_09 < var_06;var_09++)
	{
		self setgoalyaw(var_09 * 60);
		self setvehgoalpos(var_07 + maps\_shg_design_tools::getperlinovertime(5,3,2,0.5) * 20);
		self vehicle_setspeed(randomintrange(24,32),50,80);
		wait(0.2);
	}

	self vehicle_setspeed(randomintrange(24,32),12,20);
	if(!isdefined(self.sparks))
	{
		self.sparks = 1;
		thread security_drone_sparks();
		self sethoverparams(30,30,20);
	}
}

//Function Number: 169
security_drone_sparks()
{
	self endon("death");
	for(;;)
	{
		wait(randomfloatrange(0.75,1.5));
		if(common_scripts\utility::cointoss())
		{
			playfx(common_scripts\utility::getfx("sparks_burst_a_nolight"),self.origin);
		}
		else
		{
			playfxontag(common_scripts\utility::getfx("sparks_burst_a_nolight"),self,"tag_main_camera");
		}

		playfxontag(common_scripts\utility::getfx("drone_smoke"),self,"tag_origin");
	}
}

//Function Number: 170
spawn_security_drones()
{
	if(!isdefined(level.player.closest_drone))
	{
		level.player.closest_drone = level.player;
	}

	if(!isdefined(level.active_drones))
	{
		level.active_drones = [];
	}

	thread monitor_change_security_drone_gotos();
	level.drone_investigates = [level.player.origin,level.will_irons.origin];
	var_00 = [];
	var_01 = getentarray("spawner_big_security_drone_01","targetname");
	var_02 = getent("spawner_big_security_drone_00","targetname");
	var_01 = common_scripts\utility::array_add(var_01,var_02);
	foreach(var_06, var_04 in var_01)
	{
		if(var_06 == 2)
		{
			continue;
		}

		var_05 = var_04 maps\_utility::spawn_vehicle();
		var_00[var_00.size] = var_05;
		var_05 thread make_invulnerable_while_idle();
		var_05.spawner_name = var_04.targetname;
	}

	level.security_drones = var_00;
	level waittill("start_security_drone_fight");
	common_scripts\utility::flag_set("_stealth_spotted");
	common_scripts\utility::flag_set("drones_investigating");
	foreach(var_06, var_05 in var_00)
	{
		var_05 thread activate_security_drone(var_06,0);
	}

	for(;;)
	{
		foreach(var_05 in var_00)
		{
			level.player.closest_drone = var_05;
			while(isdefined(level.player.closest_drone))
			{
				wait 0.05;
			}
		}

		wait 0.05;
	}
}

//Function Number: 171
make_invulnerable_while_idle()
{
	level endon("start_security_drone_fight");
	for(;;)
	{
		self.maxhealth = 21100;
		self.health = self.maxhealth;
		wait 0.05;
	}
}

//Function Number: 172
activate_security_drone(param_00,param_01)
{
	self endon("death");
	if(param_01)
	{
		level waittill("security_drone_death");
		level waittill("security_drone_death");
	}

	var_02 = self;
	var_02 maps\_vehicle::gopath();
	var_02 vehicle_setspeed(randomintrange(24,32),12,20);
	var_02.ignoreme = 1;
	var_02 thread fake_scanning_fx_thread();
	var_02 thread monitor_security_drone_death(param_00);
	common_scripts\utility::flag_wait("security_drones_arrived");
	var_02 thread vehicle_scripts\_pdrone_security::drone_active_thread();
	var_02 vehicle_scripts\_pdrone_security::drone_set_mode("attack");
	var_02 thread handle_security_drone_hit();
	var_02 thread set_target_player_or_will(param_00);
	level.active_drones[level.active_drones.size] = var_02;
	var_02.ignoreme = 0;
	var_02.maxhealth = 21200;
	var_02.health = var_02.maxhealth;
}

//Function Number: 173
fake_scanning_fx_thread()
{
	self endon("death");
	if(issubstr(self.spawner_name,"00"))
	{
		thread drone_scan("drone_scan_seoul",1);
		return;
	}

	thread drone_scan("drone_scan_seoul",0);
}

//Function Number: 174
drone_scan(param_00,param_01)
{
	if(!param_01)
	{
		playfxontag(level._effect[param_00],self,"tag_main_camera");
	}

	while(!common_scripts\utility::flag("security_drones_arrived"))
	{
		if(!isdefined(self) || issubstr(self.classname,"corpse"))
		{
			break;
		}

		self setlookatent(common_scripts\utility::random([level.player,level.will_irons]));
		if(param_01)
		{
			playfxontag(level._effect[param_00],self,"tag_main_camera");
		}

		wait(randomfloatrange(0.5,1));
	}
}

//Function Number: 175
monitor_security_drone_death(param_00)
{
	for(;;)
	{
		common_scripts\utility::flag_wait("security_drones_ok_to_damage");
		var_01 = common_scripts\utility::waittill_any_return("death","damage");
		if(var_01 == "death")
		{
			level notify("security_drone_death",param_00);
			common_scripts\utility::flag_set("security_drones_arrived");
			break;
		}
		else
		{
			common_scripts\utility::flag_set("security_drones_arrived");
		}
	}
}

//Function Number: 176
set_target_player_or_will(param_00)
{
	self endon("death");
	while(!isdefined(self.drone_threat_data))
	{
		wait 0.05;
	}

	var_01 = undefined;
	thread kill_player_if_move_ahead();
	for(;;)
	{
		if(param_00 == 0 || param_00 == 2)
		{
			var_01 = level.player;
		}
		else if(param_00 == 1)
		{
			var_01 = level.will_irons;
		}
		else
		{
			thread target_drone_damager();
			break;
		}

		self.drone_threat_data.threat = var_01;
		while(isdefined(self.drone_threat_data.threat) && self.drone_threat_data.threat == var_01)
		{
			wait 0.05;
		}
	}
}

//Function Number: 177
kill_player_if_move_ahead()
{
	self endon("death");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_dead_demo_team3");
	self.drone_threat_data.threat = level.player;
}

//Function Number: 178
target_drone_damager()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		self.drone_threat_data.threat = var_01;
		wait(3);
	}
}

//Function Number: 179
security_drone_attack()
{
	var_00 = self;
	var_00.fovcosinez = cos(60);
	var_00.fovcosine = cos(60);
	var_00 notify("drone_investigate");
	var_00 notify("drone_corpse_monitor");
	var_00 notify("drone_alert_sight");
	var_00 notify("drone_wait_for_attack");
	var_00 thread vehicle_scripts\_pdrone_security::drone_security_prepare_attack(1);
}

//Function Number: 180
waittill_spawn_waterfall_fight()
{
	var_00 = getent("vol_canal_enemy_ai_check_01","targetname");
	while(!common_scripts\utility::flag("canal_reached_walls"))
	{
		var_01 = getaiarray("axis");
		var_01 = maps\_utility::array_removedead_or_dying(var_01);
		var_02 = 0;
		foreach(var_04 in var_01)
		{
			if(isdefined(var_04) && var_04 istouching(var_00))
			{
				var_02++;
			}

			if(common_scripts\utility::cointoss())
			{
				wait 0.05;
			}
		}

		if(var_02 > 1)
		{
			break;
		}

		wait 0.05;
	}

	while(!common_scripts\utility::flag("canal_reached_walls"))
	{
		var_01 = getaiarray("axis");
		var_02 = 0;
		foreach(var_04 in var_01)
		{
			if(isdefined(var_04) && var_04 istouching(var_00))
			{
				var_02++;
			}

			if(common_scripts\utility::cointoss())
			{
				wait 0.05;
			}
		}

		if(var_02 == 0)
		{
			break;
		}

		wait 0.05;
	}

	level notify("start_security_drone_fight");
}

//Function Number: 181
canal_enemy_setup_post_explosive_pickup()
{
	var_00 = getent("enemy_sd_canal_grp1","script_noteworthy");
	var_01 = 6;
	var_02 = [];
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		var_04 = var_00 maps\_shg_design_tools::actual_spawn(1);
		var_04.grenadeammo = 0;
		var_04 thread change_color_node_quick();
		var_04 maps\_utility::add_damage_function(::canal_enemy_damage_function);
		var_02[var_02.size] = var_04;
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_reach_waterfall");
	var_05 = maps\_utility::array_removedead_or_dying(var_02);
	foreach(var_04 in var_02)
	{
		if(isalive(var_04))
		{
			var_04 bloody_death();
		}

		wait(randomfloatrange(0.3,0.5));
		var_05 = maps\_utility::array_removedead_or_dying(var_05);
	}
}

//Function Number: 182
canal_middle_weapon_guards()
{
	common_scripts\utility::flag_clear("canal_reached_walls");
	common_scripts\utility::flag_wait("canal_reached_walls");
	var_00 = getent("enemy_sd_guards2_1","targetname");
	var_01 = 3;
	var_02 = getent("sd_goal_weapon_guard1","targetname");
	var_03 = [];
	for(var_04 = 0;var_04 < var_01;var_04++)
	{
		var_05 = var_00 maps\_shg_design_tools::actual_spawn(1);
		var_05.grenadeammo = 0;
		var_05 thread change_color_node_quick();
		var_05 setgoalvolumeauto(var_02);
		var_05 maps\_utility::add_damage_function(::canal_enemy_damage_function);
		var_03[var_03.size] = var_05;
	}

	var_06 = getent("enemy_sd_guards2_2","targetname");
	var_07 = 4;
	var_02 = getent("sd_goal_weapon_guard1","targetname");
	for(var_04 = 0;var_04 < var_01;var_04++)
	{
		var_05 = var_00 maps\_shg_design_tools::actual_spawn(1);
		var_05.grenadeammo = 0;
		var_05 thread change_color_node_quick();
		var_05 setgoalvolumeauto(var_02);
		var_05 maps\_utility::add_damage_function(::canal_enemy_damage_function);
		var_03[var_03.size] = var_05;
	}

	while(var_03.size > 1)
	{
		var_03 = maps\_utility::array_removedead_or_dying(var_03);
		wait 0.05;
	}

	foreach(var_05 in var_03)
	{
		if(isalive(var_05))
		{
			var_05 bloody_death();
		}

		var_03 = maps\_utility::array_removedead_or_dying(var_03);
	}

	common_scripts\utility::flag_set("middle_weapon_guards_dead");
}

//Function Number: 183
canal_wall_reinforcements()
{
	var_00 = getent("enemy_canal_wall_reinforcementsR","script_noteworthy");
	var_01 = 3;
	var_02 = getent("sd_goal_wallR","targetname");
	var_03 = [];
	for(var_04 = 0;var_04 < var_01;var_04++)
	{
		var_05 = var_00 maps\_shg_design_tools::actual_spawn(1);
		var_05.grenadeammo = 0;
		var_05 thread change_color_node_quick();
		var_05 setgoalvolumeauto(var_02);
		var_05 setthreatbiasgroup("weapon_platform_guards");
		var_05 maps\_utility::add_damage_function(::canal_enemy_damage_function);
		var_03[var_03.size] = var_05;
		var_05 thread canal_wall_enemy_think();
	}

	var_06 = getent("enemy_canal_wall_reinforcementsL","script_noteworthy");
	var_07 = 2;
	var_02 = getent("sd_goal_wallL","targetname");
	for(var_04 = 0;var_04 < var_01;var_04++)
	{
		var_05 = var_06 maps\_shg_design_tools::actual_spawn(1);
		var_05.grenadeammo = 0;
		var_05 thread change_color_node_quick();
		var_05 setgoalvolumeauto(var_02);
		var_05 setthreatbiasgroup("weapon_platform_guards");
		var_05 maps\_utility::add_damage_function(::canal_enemy_damage_function);
		var_03[var_03.size] = var_05;
		var_05 thread canal_wall_enemy_think();
	}

	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_reach_waterfall");
	var_03 = maps\_utility::array_removedead_or_dying(var_03);
	foreach(var_05 in var_03)
	{
		if(isalive(var_05))
		{
			var_05 bloody_death();
		}

		wait(randomfloatrange(0.3,0.5));
		var_03 = maps\_utility::array_removedead_or_dying(var_03);
	}
}

//Function Number: 184
canal_jet_flyover2()
{
	var_00 = getentarray("special_jet_flyby_spawner_canal1","targetname");
	foreach(var_02 in var_00)
	{
		var_02 maps\_vehicle::spawn_vehicle_and_gopath();
	}
}

//Function Number: 185
canal_handle_bomb_plant_start()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_overlookbar"))
	{
		level waittill("transients_canal_overlook_to_riverwalk");
	}

	common_scripts\utility::flag_wait("canal_bomb_plant_trigger_on");
	var_00 = getent("trig_interact_with_will_finale","targetname");
	var_00 sethintstring(&"SEOUL_GIVE_EXPLOSIVES_HINT");
	var_00 thread canal_handle_bomb_plant_button_display();
	common_scripts\utility::flag_wait("interacted_with_will_finale");
	var_00 sethintstring("");
	common_scripts\utility::flag_set("bomb_plant_start");
	var_00 common_scripts\utility::trigger_off();
}

//Function Number: 186
canal_handle_bomb_plant_button_display()
{
	var_00 = maps\_shg_utility::hint_button_trigger("x",250);
	common_scripts\utility::flag_wait("interacted_with_will_finale");
	var_00 maps\_shg_utility::hint_button_clear();
}

//Function Number: 187
canal_spawn_razorback()
{
	common_scripts\utility::flag_wait("spawn_canal_razorback");
	level.canal_razorback = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("vehicle_canal_razorback01");
	level.canal_razorback soundscripts\_snd::snd_message("seo_canal_razorback");
	level.canal_razorback maps\_vehicle::godon();
	var_00 = getentarray("ally_canal_razorback_grp1","script_noteworthy");
	var_01 = getent("canal_razorback_clip","targetname");
	var_01 linkto(level.canal_razorback);
	thread canal_razorback_turret_think();
	wait(2);
	common_scripts\utility::flag_set("vo_canal_razorback_arrival");
	common_scripts\utility::flag_wait("canal_razorback_dropoff01");
	common_scripts\utility::flag_set("canal_razoback_move_again");
	wait(8);
	common_scripts\utility::flag_set("canal_razorback_attacked");
	var_02 = common_scripts\utility::getstruct("razorback_escape","targetname");
	level.canal_razorback.attachedpath = var_02;
	level.canal_razorback thread maps\_vehicle::vehicle_paths();
	level.canal_razorback soundscripts\_snd::snd_message("seo_canal_heli_attacked");
	while(!isdefined(level.canal_razorback.crashing))
	{
		wait 0.05;
	}

	var_03 = level.canal_razorback.origin;
	level.canal_razorback.crash_node = common_scripts\utility::getclosest(level.canal_razorback.origin,getentarray("helicopter_crash_location","targetname"),5000);
	while(distance(level.canal_razorback.origin,level.canal_razorback.crash_node.origin) > 200)
	{
		var_03 = level.canal_razorback.origin;
		wait 0.05;
	}

	playfx(common_scripts\utility::getfx("razorback_death_explosion"),var_03);
	var_01 unlink();
	var_01 delete();
	level.canal_razorback delete();
}

//Function Number: 188
canal_razorback_turret_think()
{
	level.canal_razorback vehicle_scripts\_razorback::disable_firing();
	level.canal_razorback thread vehicle_scripts\_razorback::disable_tracking();
	level.canal_razorback.fire_rate = 0.2;
	level.canal_razorback.gun_vector = level.canal_razorback gettagorigin("TAG_TURRET");
	wait(4);
	level.canal_razorback thread vehicle_scripts\_razorback::enable_tracking();
	while(!common_scripts\utility::flag("canal_razorback_dropoff01"))
	{
		var_00 = randomfloatrange(10,30);
		var_01 = 0;
		level.canal_razorback soundscripts\_snd::snd_message("razorback_fire_start",level.canal_razorback.gun_vector);
		while(!common_scripts\utility::flag("canal_razorback_dropoff01") && var_01 < var_00)
		{
			var_02 = common_scripts\utility::getclosest(level.canal_razorback.origin,getentarray("canal_wall_targetpoints","script_noteworthy"),5000);
			var_02 = var_02.origin + common_scripts\utility::randomvectorrange(10,100);
			level.canal_razorback vehicle_scripts\_razorback::set_forced_target(var_02);
			level.canal_razorback.gun_vector = level.canal_razorback gettagorigin("TAG_TURRET");
			canal_razorback_turret_fire();
			var_01++;
			wait(level.canal_razorback.fire_rate);
		}

		level.canal_razorback soundscripts\_snd::snd_message("razorback_fire_stop",level.canal_razorback.gun_vector);
		wait(randomfloatrange(0.3,0.5));
	}

	level.canal_razorback thread vehicle_scripts\_razorback::disable_tracking();
	common_scripts\utility::flag_wait("canal_razorback_dropoff01");
	wait(1);
	wait(3);
	common_scripts\utility::flag_set("canal_razorback_fire_at_swarm");
	level.canal_razorback thread vehicle_scripts\_razorback::enable_tracking();
	while(!common_scripts\utility::flag("canal_razorback_attacked"))
	{
		var_00 = randomfloatrange(4,8);
		var_01 = 0;
		level.canal_razorback soundscripts\_snd::snd_message("razorback_fire_start",level.canal_razorback.gun_vector);
		while(!common_scripts\utility::flag("canal_razorback_attacked") && var_01 < var_00)
		{
			var_02 = get_player_point_target();
			if(!isdefined(var_02))
			{
				var_02 = common_scripts\utility::getclosest(level.canal_razorback.origin,getentarray("canal_swarm_targetpoints","script_noteworthy"),5000);
			}

			var_02 = var_02.origin + common_scripts\utility::randomvectorrange(10,50);
			level.canal_razorback vehicle_scripts\_razorback::set_forced_target(var_02);
			level.canal_razorback.gun_vector = level.canal_razorback gettagorigin("TAG_TURRET");
			canal_razorback_turret_fire();
			var_01++;
			wait(level.canal_razorback.fire_rate);
		}

		level.canal_razorback soundscripts\_snd::snd_message("razorback_fire_stop",level.canal_razorback.gun_vector);
		wait(randomfloatrange(0.5,1.75));
	}

	level.canal_razorback thread vehicle_scripts\_razorback::disable_tracking();
}

//Function Number: 189
get_player_point_target()
{
	var_00 = level.player geteye();
	var_01 = level.player getgunangles();
	var_02 = var_00 + anglestoforward(var_01) * 20;
	var_03 = var_00 + anglestoforward(var_01) * 200;
	var_04 = bullettrace(var_02,var_03,1,level.will_irons,0,0,1);
	if(distance(level.player.origin,var_04["position"]) < 300)
	{
		return;
	}

	var_05 = getaiarray("axis");
	var_05 = maps\_shg_design_tools::sortbydistanceauto(var_05,var_04["position"]);
	if(isdefined(var_05[1]))
	{
		var_06 = var_05[1];
	}
	else
	{
		var_06 = var_06[0];
	}

	return var_06.origin;
}

//Function Number: 190
canal_razorback_turret_fire(param_00,param_01)
{
	level.canal_razorback fireweapon();
}

//Function Number: 191
canal_drone_swarm_think()
{
	common_scripts\utility::flag_wait("canal_start_drone_travel");
	level notify("end_kamikaze_newstyle");
	var_00 = common_scripts\utility::getstructarray("canal_snake_swarm_travel1","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.speed = 40;
	}

	foreach(var_05 in self.snakes)
	{
		var_06 = var_05.flock.boid_settings;
		var_06.max_accel = 4000;
		var_06.magnet_factor = 20;
	}

	thread vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("canal_snake_swarm_travel1",undefined,3);
	common_scripts\utility::flag_wait("canal_snake_reached_platform");
	var_08 = common_scripts\utility::getstructarray("sd_snake_swarm_wp_loop","script_noteworthy");
	var_09 = common_scripts\utility::getstructarray("canal_snake_swarm_initial_attack1","script_noteworthy");
	thread canal_kamikaze_player_check();
	foreach(var_02 in var_08)
	{
		var_02.speed = 40;
	}

	foreach(var_02 in var_09)
	{
		var_02.speed = 35;
	}

	foreach(var_05 in self.snakes)
	{
		var_06 = var_05.flock.boid_settings;
		var_06.max_accel = 6400;
		var_06.magnet_factor = 30;
	}

	level notify("canal_swarm_spawned");
	thread vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("sd_snake_swarm_wp_loop",undefined,4.5);
	foreach(var_05 in self.snakes)
	{
		var_06 = var_05.flock.boid_settings;
		var_06.max_accel = 6400;
		var_06.magnet_factor = 30;
	}

	common_scripts\utility::flag_wait("canal_razorback_fire_at_swarm");
	thread canal_drone_swarm_death_think();
	common_scripts\utility::flag_wait("canal_razorback_attacked");
	common_scripts\utility::flag_set("vo_canal_razorback_attacked");
	soundscripts\_snd::snd_music_message("mus_canal_swarm_chasing_off_razorback");
	wait(2);
	foreach(var_05 in self.snakes)
	{
		var_06 = var_05.flock.boid_settings;
		var_06.max_accel = 3200;
		var_06.magnet_factor = 10;
	}

	thread vehicle_scripts\_attack_drone_common::snake_cloud_goto_points("canal_snake_swarm_initial_attack1",undefined,4);
	common_scripts\utility::flag_wait("canal_snake_attack1_path_end");
	wait(8);
	thread vehicle_scripts\_attack_drone_common::cleanup_snake_cloud();
	soundscripts\_snd::snd_music_message("mus_canal_helo_attacked");
}

//Function Number: 192
canal_drone_swarm_death_think()
{
	var_00 = common_scripts\utility::getstructarray("canal_dead_drone_spawn2","script_noteworthy");
	while(!common_scripts\utility::flag("canal_razorback_attacked") && !common_scripts\utility::flag("canal_razoback_move_again"))
	{
		if(common_scripts\utility::flag("canal_razoback_move_again"))
		{
			var_00 = common_scripts\utility::getstructarray("canal_dead_drone_spawn3","script_noteworthy");
		}

		var_01 = var_00[randomintrange(0,var_00.size)];
		playfx(common_scripts\utility::getfx("drone_death_explode1"),var_01.origin);
		wait(randomfloatrange(0.5,1));
	}

	wait(2);
	var_00 = common_scripts\utility::getstructarray("canal_dead_drone_spawn3","script_noteworthy");
	while(!common_scripts\utility::flag("canal_razorback_attacked"))
	{
		var_01 = var_00[randomintrange(0,var_00.size)];
		playfx(common_scripts\utility::getfx("drone_death_explode1"),var_01.origin);
		wait(randomfloatrange(0.5,1));
	}
}

//Function Number: 193
canal_kamikaze_player_check()
{
	var_00 = getent("vol_canal_kamikaze_player_check","targetname");
	var_01 = getent("canal_drone_queen1","targetname");
	var_02 = common_scripts\utility::getstructarray("sd_snake_swarm_wp_loop","script_noteworthy");
	level endon("end_kamikaze_newstyle");
	while(!common_scripts\utility::flag("bombs_picked_up"))
	{
		while(level.player istouching(var_00))
		{
			if(!common_scripts\utility::flag("canal_swarm_attacking_player"))
			{
				common_scripts\utility::flag_set("canal_swarm_attacking_player");
			}

			var_03 = maps\_shg_design_tools::sortbydistanceauto(level.flock_drones,level.player.origin);
			var_04 = randomint(2);
			for(var_05 = 0;var_05 < var_04;var_05++)
			{
				if(!isdefined(var_03[var_05]) || isdefined(var_03[var_05].attacking_player))
				{
					continue;
				}

				var_03[var_05] thread vehicle_scripts\_attack_drone::drone_kamikaze_player(var_01);
				var_03[var_05].attacking_player = 1;
				wait(randomfloatrange(0.1,0.2));
			}

			foreach(var_07 in var_02)
			{
				var_07.speed = 40;
			}

			wait(0.5);
		}

		if(common_scripts\utility::flag("canal_swarm_attacking_player"))
		{
			common_scripts\utility::flag_clear("canal_swarm_attacking_player");
		}

		wait 0.05;
	}
}

//Function Number: 194
canal_pop_smoke()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_reinforcements2");
	var_00 = common_scripts\utility::getstruct("struct_smoke_start_left","targetname");
	var_01 = common_scripts\utility::getstruct("struct_smoke_end_left","targetname");
	var_02 = common_scripts\utility::getstruct("struct_smoke_start_right","targetname");
	var_03 = common_scripts\utility::getstruct("struct_smoke_end_right","targetname");
	magicgrenade("smoke_grenade_cheap",var_00.origin,var_01.origin + (0,2,0),1);
	magicgrenade("smoke_grenade_cheap",var_02.origin,var_03.origin + (0,2,0),1);
	wait(1);
	thread sd_spawn_and_retreat_goals(undefined,"enemy_sd_canal1",undefined,"sd_goal_canal1_fallback",2,undefined,"sd_goal_weapon_guard1");
	thread sd_spawn_and_retreat_goals(undefined,"enemy_canal_waterfall",undefined,"sd_goal_canal1_fallback",1,undefined,"sd_goal_weapon_guard1");
}

//Function Number: 195
canal_spawn_zipline_group1()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_start_combat");
	var_00 = [];
	var_00[var_00.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("canal_enemy_canal_zipline1","canal_zipline_canal1_start1");
	wait(0.5);
	var_00[var_00.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("canal_enemy_canal_zipline1","canal_zipline_canal1_start2");
	wait(0.5);
	var_00[var_00.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("canal_enemy_canal_zipline1","canal_zipline_canal1_start3");
	wait(0.5);
	var_00[var_00.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("canal_enemy_canal_zipline1","canal_zipline_canal1_start4");
	sd_zipline_enemy_think(var_00,"sd_goal_canal1",2,undefined,"sd_goal_canal1_fallback");
}

//Function Number: 196
canal_spawn_zipline_group2()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_start_combat");
	wait(0.5);
	var_00 = [];
	var_00[var_00.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("canal_enemy_canal_zipline2","canal_zipline_canal2_start1");
	wait(0.5);
	var_00[var_00.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("canal_enemy_canal_zipline2","canal_zipline_canal2_start2");
	wait(0.5);
	var_00[var_00.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("canal_enemy_canal_zipline2","canal_zipline_canal2_start3");
	wait(0.5);
	var_00[var_00.size] = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline("canal_enemy_canal_zipline2","canal_zipline_canal2_start4");
	sd_zipline_enemy_think(var_00,"sd_goal_canal1",2,undefined,"sd_goal_canal1_fallback");
}

//Function Number: 197
canal_turret_vehicle2()
{
	var_00 = getentarray("canal_vehicle_weap_defense_passengers","script_noteworthy");
	maps\_utility::array_spawn_function_noteworthy("canal_vehicle2_passengers",::canal_turret_vehicle_passenger_think);
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("canal_vehicle_weap_defense");
	level.controllable_drone_swarm_target[level.controllable_drone_swarm_target.size] = var_01;
	foreach(var_03 in var_01.riders)
	{
		if(var_03.vehicle_position == 3)
		{
			var_04 = var_03;
		}
	}

	common_scripts\utility::flag_wait("bombs_picked_up");
	var_01 waittill("reached_end_node");
	var_01 maps\_vehicle::vehicle_unload("all_but_gunner");
}

//Function Number: 198
canal_emp_wave()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_canal_emp");
	level notify("end_drone_swarm");
	var_00 = getent("canal_weapon_platform","targetname");
	var_01 = var_00.origin;
	var_02 = 10000;
	var_03 = common_scripts\utility::array_add(level.controllable_drones,level.controllable_cloud_queen);
	var_03 = maps\_shg_design_tools::sortbydistanceauto(var_03,var_01);
	var_04 = var_01;
	var_05 = 25;
	var_06 = 0;
	foreach(var_08 in var_03)
	{
		if(!isdefined(var_08))
		{
			continue;
		}

		if(var_08 maps\_vehicle::isvehicle())
		{
			var_08 dodamage(var_08.health * 2,var_01);
			continue;
		}

		var_09 = distance(var_04,var_08.origin);
		var_0A = var_09 / var_02 * 0.05;
		if(maps\_shg_design_tools::percentchance(25))
		{
			wait(var_0A);
		}

		if(var_06 > var_05)
		{
			wait(0.05);
			var_06 = 0;
		}

		if(!isdefined(var_08))
		{
			continue;
		}

		var_04 = var_08.origin;
		var_0B = vectornormalize(var_08.origin - var_01);
		var_0B = vectornormalize(var_0B + (0,0,0.2));
		var_0C = spawn("script_model",var_08.origin);
		var_0C setmodel("vehicle_mil_attack_drone_static");
		var_0C.angles = var_08.angles;
		var_08 maps\_shg_design_tools::delete_auto();
		var_0D = var_0C.origin + (randomintrange(-10,10),randomintrange(-10,10),randomintrange(-10,10)) - var_01;
		var_0E = randomintrange(10,80);
		var_0C physicslaunchserver(var_0C.origin + (randomintrange(-15,15),randomintrange(-15,15),randomintrange(-15,15)),var_0D * var_0E);
		var_0C common_scripts\utility::delaycall(randomfloatrange(10,30),::delete);
		var_06++;
	}
}

//Function Number: 199
canal_weapon_platform_firing_loop()
{
	if(!isdefined(level.weapon_platform_rigged))
	{
		level.weapon_platform_rigged = getent("canal_weapon_platform","targetname");
	}

	if(level.currentgen && !issubstr(level.transient_zone,"_overlookbar"))
	{
		level waittill("transients_canal_overlook_to_riverwalk");
	}

	thread maps\seoul_lighting::finale_mwp_lighting_offset();
	level.weapon_platform_rigged.animname = "weapon_platform";
	level.weapon_platform_rigged maps\_anim::setanimtree();
	var_00 = getent("canal_org_finale","targetname");
	var_00 maps\_anim::anim_first_frame_solo(level.weapon_platform_rigged,"firing_loop");
	var_01 = getentarray("vehicle_canal_wp_missiles1","targetname");
	var_02 = getentarray("vehicle_canal_wp_missiles2","targetname");
	var_03 = getentarray("vehicle_canal_wp_missiles3","targetname");
	common_scripts\utility::flag_wait("start_weapon_platform_firing");
	while(common_scripts\utility::flag("start_weapon_platform_firing"))
	{
		var_00 thread canal_weapon_platform_anim();
		earthquake(0.2,1,level.weapon_platform_rigged.origin,1500);
		var_04 = var_01[randomintrange(0,var_01.size)];
		var_05 = var_04 maps\_vehicle::spawn_vehicle_and_gopath();
		playfxontag(common_scripts\utility::getfx("weaponplf_trail_missile_runner"),var_05,"tag_origin");
		var_05 hide();
		var_05 notify("stop_engineeffects");
		stopfxontag(common_scripts\utility::getfx("contrail"),var_05,"tag_origin");
		var_05 soundscripts\_snd::snd_message("havoc_missile_launch");
		wait(randomfloatrange(0.2,0.4));
		var_06 = var_02[randomintrange(0,var_02.size)];
		var_07 = var_06 maps\_vehicle::spawn_vehicle_and_gopath();
		playfxontag(common_scripts\utility::getfx("weaponplf_trail_missile_runner"),var_07,"tag_origin");
		var_07 hide();
		var_07 notify("stop_engineeffects");
		stopfxontag(common_scripts\utility::getfx("contrail"),var_07,"tag_origin");
		var_07 soundscripts\_snd::snd_message("havoc_missile_launch");
		wait(randomfloatrange(0.2,0.4));
		var_08 = var_03[randomintrange(0,var_03.size)];
		var_09 = var_08 maps\_vehicle::spawn_vehicle_and_gopath();
		playfxontag(common_scripts\utility::getfx("weaponplf_trail_missile_runner"),var_09,"tag_origin");
		var_09 hide();
		var_09 notify("stop_engineeffects");
		stopfxontag(common_scripts\utility::getfx("contrail"),var_09,"tag_origin");
		var_09 soundscripts\_snd::snd_message("havoc_missile_launch");
		wait(randomfloatrange(5,8));
	}

	common_scripts\utility::flag_waitopen("weapon_platform_firing");
}

//Function Number: 200
canal_weapon_platform_vis_control()
{
	level.weapon_platform_rigged = getent("canal_weapon_platform","targetname");
	level.weapon_platform_rigged hide();
	common_scripts\utility::flag_wait("show_canal_weapon_platform");
	level.weapon_platform_rigged show();
}

//Function Number: 201
canal_weapon_platform_anim()
{
	common_scripts\utility::flag_set("weapon_platform_firing");
	maps\_anim::anim_single_solo(level.weapon_platform_rigged,"firing_loop");
	common_scripts\utility::flag_clear("weapon_platform_firing");
}

//Function Number: 202
canal_finale_will_prep()
{
	common_scripts\utility::flag_wait("prep_will_for_finale");
	common_scripts\utility::flag_waitopen("weapon_platform_firing");
	common_scripts\utility::flag_clear("start_weapon_platform_firing");
	level.will_irons.animname = "will_irons";
	level.weapon_platform_rigged maps\_utility::anim_stopanimscripted();
	var_00 = getent("canal_org_finale","targetname");
	var_00 maps\_anim::anim_first_frame_solo(level.weapon_platform_rigged,"finale_pt01");
	level.will_irons.ignoreall = 1;
	level.will_irons.ignoreme = 1;
	thread maps\seoul_lighting::finale_mwp_lighting_offset();
	thread maps\seoul_lighting::pre_bomb_plant_lighting();
	var_00 = getent("canal_org_finale","targetname");
	var_01 = [level.will_irons,level.weapon_platform_rigged];
	var_00 maps\_anim::anim_reach_solo(level.will_irons,"finale_pt01");
	var_00 maps\_anim::anim_single(var_01,"finale_pt01");
	common_scripts\utility::flag_set("canal_bomb_plant_trigger_on");
	common_scripts\utility::flag_set("vo_bomb_plant_reminder");
	var_02 = ["seo_wil_mitchellineedthe","seo_wil_comeonmitchell"];
	thread maps\_shg_utility::dialogue_reminder(level.will_irons,"bomb_plant_start",var_02,3,5);
	if(!common_scripts\utility::flag("bomb_plant_start"))
	{
		var_00 maps\_anim::anim_loop_solo(level.will_irons,"finale_idle_will","bomb_plant_start");
	}
}

//Function Number: 203
canal_finale_sequence()
{
	if(level.currentgen && !issubstr(level.transient_zone,"_overlookbar"))
	{
		level waittill("transients_canal_overlook_to_riverwalk");
	}

	level notify("aud_stop_canal_bombs");
	var_00 = getent("canal_org_finale","targetname");
	var_01 = maps\_utility::spawn_anim_model("seo_finale_part2_lamp01");
	var_02 = maps\_utility::spawn_anim_model("seo_finale_part2_lamp02");
	var_03 = maps\_utility::spawn_anim_model("seo_finale_part2_lamp03");
	var_04 = maps\_utility::spawn_anim_model("seo_finale_part2_lamp04");
	var_05 = maps\_utility::spawn_anim_model("seo_finale_part2_lamp05");
	var_06 = maps\_utility::spawn_anim_model("seo_finale_part2_lamp06");
	var_07 = maps\_utility::spawn_anim_model("seo_finale_part2_lamp07");
	var_08 = maps\_utility::spawn_anim_model("seo_finale_part2_lamp08");
	var_09 = [var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08];
	var_00 maps\_anim::anim_first_frame(var_09,"finale_pt02");
	common_scripts\utility::flag_wait("bomb_plant_start");
	common_scripts\utility::flag_set("end_rumble_listener");
	level.player maps\_vehicle::godon();
	soundscripts\_snd::snd_message("seo_finale_start");
	thread maps\seoul_lighting::timing_offset_finale_cine_lighting();
	common_scripts\utility::flag_set("objective_sd_bomb_planted");
	level notify("panel_close_wait");
	thread cleanup_enemy_ai_seoul();
	level.player maps\_shg_utility::setup_player_for_scene(1);
	maps\_player_exo::player_exo_deactivate();
	var_0A = getaiarray("axis");
	maps\_utility::array_delete(var_0A);
	var_0B = getcorpsearray();
	maps\_utility::array_delete(var_0B);
	setsaveddvar("g_friendlynamedist",0);
	level.weapon_platform_rigged = getent("canal_weapon_platform","targetname");
	level.weapon_platform_rigged.animname = "weapon_platform";
	level.weapon_platform_rigged maps\_anim::setanimtree();
	level.will_irons.animname = "will_irons";
	level.cormack.animname = "cormack";
	var_0C = maps\_utility::spawn_anim_model("player_rig",level.player.origin);
	var_0D = maps\_utility::spawn_anim_model("seo_finale_plantbomb_bomb");
	thread maps\seoul_lighting::bomb_light(var_0D);
	var_0E = [level.will_irons,var_0C,level.weapon_platform_rigged,var_0D];
	var_00 maps\_anim::anim_first_frame(var_0E,"finale_plantbomb");
	var_0C hide();
	var_0F = 0.5;
	level.player playerlinktoblend(var_0C,"tag_player",var_0F);
	var_0C common_scripts\utility::delaycall(var_0F + 0.1,::show);
	level.player common_scripts\utility::delaycall(var_0F,::playerlinktoabsolute,var_0C,"tag_player");
	common_scripts\utility::flag_set("vo_canal_finale_scene");
	common_scripts\utility::flag_set("vfx_msg_finale_sequence_start");
	var_00 maps\_anim::anim_single(var_0E,"finale_plantbomb");
	common_scripts\utility::flag_set("cleanup_finale_explosive");
	var_0D hide();
	var_10 = [level.will_irons,var_0C,level.weapon_platform_rigged,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08];
	var_00 maps\_anim::anim_single(var_10,"finale_pt02");
	level.will_irons hide();
	var_11 = maps\_utility::spawn_anim_model("seo_finale_phase2_rock_chunk01");
	var_12 = maps\_utility::spawn_anim_model("seo_finale_phase2_rock_chunk02");
	var_13 = maps\_utility::spawn_anim_model("seo_finale_phase2_sever_debris");
	var_14 = maps\_utility::spawn_anim_model("seo_finale_phase2_sever_debris_02");
	var_15 = maps\_utility::spawn_anim_model("seo_finale_phase2_silo_burke_debris");
	var_16 = maps\_utility::spawn_anim_model("player_dismembered_arm");
	thread maps\seoul_lighting::finale_cineviewmodel_lighting(var_0C);
	var_17 = getent("canal_finale_warbird1","targetname") maps\_utility::spawn_vehicle();
	var_17.animname = "warbird_finale";
	var_17.ignoreall = 1;
	var_18 = getent("hero_cormack_spawner_outro","targetname");
	level.cormack_outro = var_18 maps\_shg_design_tools::actual_spawn();
	level.cormack_outro.animname = "cormack";
	level.cormack_outro.ignoreall = 1;
	var_19 = [level.cormack_outro,var_0C,var_16,var_11,var_13,var_14,var_15,var_17];
	soundscripts\_snd::snd_music_message("mus_mitchels_arm");
	thread maps\seoul_fx::outro_vm_arm_blood_init(var_19);
	var_00 thread maps\_anim::anim_single(var_19,"finale_pt03");
	var_1A = maps\_utility::getanim_from_animname("finale_pt03",var_0C.animname);
	maps\seoul_code_gangnam::prep_cinematic("fusion_endlogo");
	var_1B = getanimlength(var_1A);
	wait(var_1B - 2);
	var_1C = 2;
	thread ending_fade_out(var_1C);
	wait(var_1C);
	maps\_utility::nextmission();
}

//Function Number: 204
cleanup_enemy_ai_seoul()
{
	var_00 = getaiarray("axis");
	common_scripts\utility::array_call(var_00,::delete);
	if(isdefined(level.security_drones))
	{
		foreach(var_02 in level.security_drones)
		{
			if(isdefined(var_02))
			{
				var_02 kill();
			}
		}
	}
}

//Function Number: 205
ending_fade_out(param_00)
{
	var_01 = newhudelem();
	var_01.x = 0;
	var_01.y = 0;
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01 setshader("black",640,480);
	if(isdefined(param_00) && param_00 > 0)
	{
		var_01.alpha = 0;
		var_01 fadeovertime(param_00);
		var_01.alpha = 1;
		wait(param_00);
	}
}

//Function Number: 206
introscreen_generic_fade_out(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1.5;
	}

	var_04 = newhudelem();
	var_04.x = 0;
	var_04.y = 0;
	var_04.horzalign = "fullscreen";
	var_04.vertalign = "fullscreen";
	var_04.foreground = 1;
	var_04 setshader(param_00,640,480);
	if(isdefined(param_03) && param_03 > 0)
	{
		var_04.alpha = 0;
		var_04 fadeovertime(param_03);
		var_04.alpha = 1;
		wait(param_03);
	}

	wait(param_01);
	if(isdefined(param_02) && param_02 > 0)
	{
		var_04.alpha = 1;
		var_04 fadeovertime(param_02);
		var_04.alpha = 0;
	}

	var_04 destroy();
}

//Function Number: 207
canal_finale_fov_shift_on(param_00)
{
	var_01 = 55;
	level.player lerpfov(var_01,0.5);
}

//Function Number: 208
canal_finale_fov_shift_off(param_00)
{
	if(!isdefined(level.origfov))
	{
		level.origfov = 65;
	}

	level.player lerpfov(level.origfov,0.5);
}

//Function Number: 209
canal_finale_shock(param_00)
{
	var_01 = 4;
	level.player shellshock("seo_canal_finale_blowback",var_01);
}

//Function Number: 210
canal_finale_rumble(param_00)
{
	wait(10);
	level thread maps\_utility::notify_delay("manual_light_rumble_end",8);
	maps\seoul_code_gangnam::do_continuous_rumble("manual_light_rumble_end","damage_light");
	wait(3);
	level.player playrumbleonentity("damage_heavy");
}

//Function Number: 211
canal_finale_rumble_sm(param_00)
{
	level.player playrumbleonentity("damage_light");
}

//Function Number: 212
play_fullscreen_blood_splatter(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = newclienthudelem(self);
	var_05.x = 0;
	var_05.y = 0;
	var_05 setshader(param_00,640,480);
	var_05.splatter = 1;
	var_05.alignx = "left";
	var_05.aligny = "top";
	var_05.sort = 1;
	var_05.foreground = 0;
	var_05.horzalign = "fullscreen";
	var_05.vertalign = "fullscreen";
	var_05.alpha = 0;
	var_05.enablehudlighting = 1;
	var_06 = 0;
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_07 = 0.05;
	if(param_02 > 0)
	{
		var_08 = 0;
		var_09 = param_04 / param_02 / var_07;
		while(var_08 < param_04)
		{
			var_05.alpha = var_08;
			var_08 = var_08 + var_09;
			wait(var_07);
		}
	}

	var_05.alpha = param_04;
	wait(param_01 - param_02 + param_03);
	if(param_03 > 0)
	{
		var_08 = param_04;
		var_0A = param_04 / param_03 / var_07;
		while(var_08 > 0)
		{
			var_05.alpha = var_08;
			var_08 = var_08 - var_0A;
			wait(var_07);
		}
	}

	var_05.alpha = 0;
	var_05 destroy();
}

//Function Number: 213
canal_finale_button_mashing()
{
	var_00 = use_pressed();
	var_01 = spawnstruct();
	var_01 thread occumulate_player_use_presses(self);
	level.occumulator = var_01;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	for(;;)
	{
		var_07 = use_pressed();
		var_08 = 0;
		var_05 = 0;
		if(var_07 && !var_00)
		{
			if(!var_06)
			{
				var_06 = 1;
				level.player playrumblelooponentity(self.rumble_loop);
			}

			if(randomint(100) > self.min_heavy)
			{
				level.player playrumbleonentity("damage_heavy");
			}
			else if(randomint(100) > self.min_light)
			{
				level.player playrumbleonentity("damage_light");
			}

			var_01.presses[var_01.presses.size] = gettime();
			var_04 = gettime();
			var_05 = sin(gettime() * 0.2) + 1 * 0.5;
			var_05 = var_05 * self.range;
			var_05 = var_05 + self.rate;
			var_08 = 1;
		}

		if(var_06 && gettime() > var_04 + 300)
		{
			var_06 = 0;
			level.player stoprumble(self.rumble_loop);
		}

		var_00 = var_07;
		var_09 = 0;
		var_03 = undefined;
		if(isdefined(self.set_pull_weight))
		{
			level.additive_pull_weight = var_03;
		}

		if(isdefined(self.auto_occumulator_base))
		{
			var_01.occumulator_base = 1 - var_03;
			var_01.occumulator_base = var_01.occumulator_base * 7;
			var_01.occumulator_base = clamp(var_01.occumulator_base,7,1);
		}

		var_0A = abs(var_02 - var_03);
		if(var_0A > 0.05)
		{
			new_pull_earthquake(var_03);
			var_02 = var_03;
		}

		if(var_09)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 214
use_pressed()
{
	return level.player usebuttonpressed();
}

//Function Number: 215
occumulate_player_use_presses(param_00)
{
	self endon("stop");
	var_01 = 1500;
	self.presses = [];
	var_02 = 7;
	for(;;)
	{
		waittillframeend;
		for(var_03 = 0;var_03 < self.presses.size;var_03++)
		{
			var_04 = self.presses[var_03];
			if(var_04 < gettime() - var_01)
			{
				continue;
			}

			break;
		}

		var_05 = [];
		while(var_03 < self.presses.size)
		{
			var_05[var_05.size] = self.presses[var_03];
			var_03++;
		}

		self.presses = var_05;
		var_06 = self.presses.size - param_00.occumulator_base * 0.03;
		var_06 = var_06 * 10;
		var_06 = clamp(var_06,0,1);
		self.occumulator_scale = var_06;
		wait(0.05);
	}
}

//Function Number: 216
new_pull_earthquake(param_00)
{
	if(isdefined(self.override_anim_time))
	{
		param_00 = self.override_anim_time;
	}

	var_01 = param_00 + 0.37;
	var_01 = var_01 * 0.22;
	earthquake(var_01,5,level.player.origin,5000);
}

//Function Number: 217
goto_node(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 16;
	}

	maps\_utility::set_goal_radius(param_02);
	if(isstring(param_00))
	{
		var_03 = getnode(param_00,"script_noteworthy");
	}
	else
	{
		var_03 = param_01;
	}

	if(isdefined(var_03))
	{
		maps\_utility::set_goal_node(var_03);
	}
	else
	{
		var_03 = common_scripts\utility::getstruct(param_00,"script_noteworthy");
		maps\_utility::set_goal_pos(var_03.origin);
	}

	if(param_01)
	{
		self waittill("goal");
	}
}

//Function Number: 218
cleanup_ai_with_script_noteworthy(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 512;
	}

	var_02 = [];
	foreach(var_04 in getentarray(param_00,"script_noteworthy"))
	{
		if(isspawner(var_04))
		{
			var_04 delete();
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	thread maps\_utility::ai_delete_when_out_of_sight(var_02,param_01);
}

//Function Number: 219
sd_spawn_and_retreat_goals(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(param_00))
	{
		maps\_utility::trigger_wait_targetname(param_00);
	}

	var_08 = [];
	if(isdefined(param_02))
	{
		var_09 = getent(param_01,"script_noteworthy");
		for(var_0A = 0;var_0A < param_02;var_0A++)
		{
			var_08[var_08.size] = var_09 maps\_shg_design_tools::actual_spawn(1);
		}
	}
	else
	{
		var_08 = maps\_utility::array_spawn_noteworthy(param_01,1);
	}

	foreach(var_0C in var_08)
	{
		if(isdefined(param_03))
		{
			var_0D = getent(param_03,"targetname");
			var_0C setgoalvolumeauto(var_0D);
		}

		var_0C.grenadeammo = 0;
		var_0C.script_careful = 1;
		thread change_color_node_quick();
		wait(0.05);
	}

	if(isdefined(param_04) || isdefined(param_05))
	{
		if(!isdefined(param_04))
		{
			common_scripts\utility::flag_wait(param_05);
		}
		else
		{
			var_08 = maps\_utility::array_removedead_or_dying(var_08);
			while(var_08.size > param_04)
			{
				var_08 = maps\_utility::array_removedead_or_dying(var_08);
				wait(0.05);
				if(isdefined(param_05) && common_scripts\utility::flag(param_05))
				{
					return;
				}
			}
		}
	}

	if(isdefined(param_06))
	{
		var_0F = getent(param_06,"targetname");
		var_08 = maps\_utility::array_removedead(var_08);
		foreach(var_0C in var_08)
		{
			var_0C setgoalvolumeauto(var_0F);
		}
	}

	if(isdefined(param_07))
	{
		maps\_utility::wait_for_targetname_trigger(param_07);
		maps\_utility::ai_delete_when_out_of_sight(var_08,40);
	}
}

//Function Number: 220
attach_flashlight_on_gun()
{
	if(!isdefined(self.gun_flashlight) || !self.gun_flashlight)
	{
		playfxontag(level._effect["flashlight"],self,"tag_flash");
		self.gun_flashlight = 1;
		self notify("flashlight_on_gun");
	}
}

//Function Number: 221
remove_patrol_anim_set()
{
	self.patrol_walk_twitch = undefined;
	self.patrol_walk_anim = undefined;
	self.script_animation = undefined;
	maps\_utility::clear_generic_run_anim();
	self.goalradius = 512;
	self allowedstances("stand","crouch","prone");
	self.disablearrivals = 0;
	self.disableexits = 0;
	self.allowdeath = 1;
	if(isdefined(self.oldcombatmode))
	{
		self.combatmode = self.oldcombatmode;
	}

	maps\_utility::enable_cqbwalk();
}

//Function Number: 222
sd_drone_patrol_think()
{
	self endon("death");
	level.cormack.ignoreall = 1;
	level.will_irons.ignoreall = 1;
	level.jackson.ignoreall = 1;
	maps\_vehicle::gopath(self);
	self.ignoreall = 1;
	self.alertlevel = "noncombat";
	self.health = 50;
	self setcandamage(1);
	self makeentitysentient(self.script_team);
	thread maps\seoul_fx::drone_search_light_fx();
	self addaieventlistener("grenade danger");
	self addaieventlistener("gunshot");
	self addaieventlistener("bulletwhizby");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"damage");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"ai_event");
	maps\_utility::add_func(::common_scripts\utility::flag_set,"wakeup_drones");
	thread maps\_utility::do_wait_any();
	common_scripts\utility::flag_wait("wakeup_drones");
	self.ignoreall = 0;
	self.target = undefined;
	maps\_utility::vehicle_detachfrompath();
	thread vehicle_scripts\_pdrone::flying_attack_drone_logic();
	wait(0.05);
	thread maps\seoul_fx::drone_spot_light(self);
	level.cormack.ignoreall = 0;
	level.will_irons.ignoreall = 0;
	level.jackson.ignoreall = 0;
}

//Function Number: 223
change_color_node_quick()
{
	self notify("started_color_node_quick");
	self endon("started_color_node_quick");
	self endon("death");
	for(;;)
	{
		self waittill("color_code_move_update",var_00);
		thread change_color_node_quick_player_close_check();
		var_01 = 0;
		if(var_01 == 0)
		{
			self.ignoreall = 1;
			self.goalradius = 20;
			common_scripts\utility::waittill_any("goal","damage","player_close");
			self.ignoreall = 0;
			self.goalradius = 500;
		}

		self waittill("goal");
		self.fixednode = 0;
		wait 0.05;
	}
}

//Function Number: 224
change_color_node_quick_player_close_check()
{
	self notify("started_color_node_quick_close_check");
	self endon("started_color_node_quick_close_check");
	self endon("death");
	self endon("damage");
	self endon("goal");
	while(distancesquared(level.player.origin,self.origin) > squared(100))
	{
		wait(0.25);
	}

	self notify("player_close");
}

//Function Number: 225
sd_anim_reach_and_play_loop(param_00,param_01,param_02)
{
	maps\_anim::anim_reach_solo(param_00,"seo_canal_overlook_anim");
	thread maps\_anim::anim_loop_solo(param_00,"seo_canal_overlook_anim",param_02);
}

//Function Number: 226
sd_anim_generic_reach_and_play(param_00,param_01,param_02)
{
	param_00 endon("death");
	if(isdefined(param_02) && param_02)
	{
		maps\_anim::anim_generic_reach(param_00,param_01);
	}
	else
	{
		param_00 setgoalpos(self.origin);
		while(distance(param_00.origin,self.origin) > 32)
		{
			wait(0.05);
		}
	}

	param_00 notify("new_anim_reach");
	self notify("reach_notify");
	maps\_anim::anim_generic(param_00,param_01);
	param_00 notify("anim_reached_and_played");
}

//Function Number: 227
sign_explosion_flash_damage()
{
	var_00 = getscriptablearray("destp_seo_shopping_district_sign_02","targetname");
	var_01 = getscriptablearray("destp_seo_shopping_district_sign_02","targetname");
	var_02 = getentarray("scriptable_destp_advertisement_inside_03","classname");
	var_03 = getentarray("scriptable_destp_advertisement_inside_04","classname");
	var_04 = getscriptablearray("destp_seo_shopping_district_sign_06","targetname");
	var_05 = getscriptablearray("destp_seo_shopping_district_sign_07","targetname");
	var_06 = getscriptablearray("destp_seo_electrical_box_02","targetname");
	level.flash_signs = var_00;
	level.flash_signs = common_scripts\utility::array_combine(level.flash_signs,var_01);
	level.flash_signs = common_scripts\utility::array_combine(level.flash_signs,var_02);
	level.flash_signs = common_scripts\utility::array_combine(level.flash_signs,var_03);
	level.flash_signs = common_scripts\utility::array_combine(level.flash_signs,var_04);
	level.flash_signs = common_scripts\utility::array_combine(level.flash_signs,var_05);
	level.flash_signs = common_scripts\utility::array_combine(level.flash_signs,var_06);
	level.flash_signs = common_scripts\utility::array_removeundefined(level.flash_signs);
	foreach(var_08 in level.flash_signs)
	{
		var_08 thread sign_flash_damage();
	}
}

//Function Number: 228
sign_flash_damage()
{
	self waittill("state_changed",var_00,var_01,var_02,var_03,var_04,var_05);
	var_06 = getaiarray();
	var_06 = maps\_utility::array_removedead_or_dying(var_06);
	foreach(var_08 in var_06)
	{
		if(distance(var_08.origin,self.origin) < 200)
		{
			var_08 maps\_utility::flashbangstart(randomfloatrange(1,1.5));
		}
	}

	level.flash_signs = common_scripts\utility::array_remove(level.flash_signs,self);
}

//Function Number: 229
sd_zipline_enemy_think(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00;
	foreach(var_08 in var_06)
	{
		if(isdefined(param_01))
		{
			var_09 = getent(param_01,"targetname");
			var_08 setgoalvolumeauto(var_09);
		}

		var_08.grenadeammo = 0;
		var_08 thread change_color_node_quick();
		wait(0.05);
	}

	if(isdefined(param_02) || isdefined(param_03))
	{
		if(!isdefined(param_02))
		{
			common_scripts\utility::flag_wait(param_03);
		}
		else
		{
			var_06 = maps\_utility::array_removedead_or_dying(var_06);
			while(var_06.size > param_02)
			{
				var_06 = maps\_utility::array_removedead_or_dying(var_06);
				wait(0.05);
				if(isdefined(param_03) && common_scripts\utility::flag(param_03))
				{
					return;
				}
			}
		}
	}

	if(isdefined(param_04))
	{
		var_0B = getent(param_04,"targetname");
		var_06 = maps\_utility::array_removedead(var_06);
		foreach(var_08 in var_06)
		{
			var_08 setgoalvolumeauto(var_0B);
		}
	}

	if(isdefined(param_05))
	{
		maps\_utility::wait_for_targetname_trigger(param_05);
		maps\_utility::ai_delete_when_out_of_sight(var_06,40);
	}
}

//Function Number: 230
bloody_death(param_00)
{
	self endon("death");
	if(!issentient(self) || !isalive(self))
	{
		return;
	}

	if(isdefined(self.bloody_death) && self.bloody_death)
	{
		return;
	}

	self.bloody_death = 1;
	if(isdefined(param_00))
	{
		wait(randomfloat(param_00));
	}

	var_01 = [];
	var_01[0] = "j_hip_le";
	var_01[1] = "j_hip_ri";
	var_01[2] = "j_head";
	var_01[3] = "j_spine4";
	var_01[4] = "j_elbow_le";
	var_01[5] = "j_elbow_ri";
	var_01[6] = "j_clavicle_le";
	var_01[7] = "j_clavicle_ri";
	for(var_02 = 0;var_02 < 3 + randomint(5);var_02++)
	{
		var_03 = randomintrange(0,var_01.size);
		thread bloody_death_fx(var_01[var_03],undefined);
		wait(randomfloat(0.1));
	}

	self dodamage(self.health + 50,self.origin);
}

//Function Number: 231
bloody_death_fx(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = level._effect["flesh_hit"];
	}

	playfxontag(param_01,self,param_00);
}

//Function Number: 232
seo_finale_rumble_light(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		level.player playrumbleonentity("damage_light");
		return;
	}

	if(isarray(param_01))
	{
		var_02 = param_01[0];
		var_03 = param_01[1];
		var_04 = param_01[2];
		wait(var_03);
	}
	else
	{
		var_02 = var_02;
	}

	var_05 = randomfloat(1000);
	var_06 = "rumble_heavy" + var_05;
	level thread maps\_utility::notify_delay(var_06,var_02);
	level endon(var_06);
	for(;;)
	{
		level.player playrumbleonentity("damage_light");
		wait(0.1);
	}
}

//Function Number: 233
seo_finale_rumble_heavy(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		level.player playrumbleonentity("damage_heavy");
		return;
	}

	if(isarray(param_01))
	{
		var_02 = param_01[0];
		var_03 = param_01[1];
		var_04 = param_01[2];
		wait(var_03);
	}
	else
	{
		var_02 = var_02;
	}

	var_05 = randomfloat(1000);
	var_06 = "rumble_heavy" + var_05;
	level thread maps\_utility::notify_delay(var_06,var_02);
	level endon(var_06);
	for(;;)
	{
		level.player playrumbleonentity("damage_light");
		wait(0.1);
	}
}