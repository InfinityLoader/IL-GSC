/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 486 ms
 * Timestamp: 4/22/2024 2:35:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_utility::template_level("sanfran");
	maps\_utility::set_console_status();
	intro_lines();
	createthreatbiasgroup("police");
	createthreatbiasgroup("atlas");
	createthreatbiasgroup("atlas_attack");
	createthreatbiasgroup("sentinel");
	precache_main();
	if(level.currentgen)
	{
		setsaveddvar("r_gunSightColorEntityScale","0.95");
		setsaveddvar("r_gunSightColorNoneScale","0.95");
		maps\_utility::tff_sync_setup();
	}

	setsaveddvar("high_jump_double_tap","1");
	init_level_flags();
	init_lighting_flags();
	setup_start_points();
	forcesharedammo();
	maps\createart\sanfran_art::main();
	maps\sanfran_fx::main();
	maps\sanfran_precache::main();
	maps\_load::main();
	thread maps\_player_exo::main("assault",1);
	thread maps\sanfran_lighting::main();
	maps\sanfran_anim::main();
	maps\sanfran_aud::main();
	maps\sanfran_pitbull::player_pitbull_init("player_rig");
	vehicle_scripts\_sentinel_survey_drone_hud::hud_precache();
	maps\_drone_civilian::init();
	maps\_microdronelauncher::init();
	maps\_variable_grenade::main();
	maps\_car_door_shield::init_door_shield();
	maps\sanfran_vo::prepare_dialog();
	thread maps\sanfran_vo::play_dialog();
	thread global_spawn_functions();
	level.default_goalradius = 1024;
	setsaveddvar("bg_fallDamageMinHeight",490);
	setsaveddvar("bg_fallDamageMaxHeight",640);
	setup_portal_scripting();
	common_scripts\utility::array_thread(getentarray("trigger_boost_down_color","targetname"),::common_scripts\utility::trigger_off);
	thread maps\sanfran_util::setup_dont_leave_failure();
	thread maps\sanfran_util::setup_dont_leave_hint();
	var_00 = getdvarint("demo_itiot",0);
	if(var_00)
	{
		soundscripts\_snd::snd_message("e3_demo_fade_in");
		level.player.auxillary_hud = newclienthudelem(level.player);
		level.player.auxillary_hud setshader("black",1280,720);
		level.player.auxillary_hud.horzalign = "fullscreen";
		level.player.auxillary_hud.vertalign = "fullscreen";
		level.player.auxillary_hud.alpha = 1;
		level.player.auxillary_hud fadeovertime(0.5);
		level.player.auxillary_hud.alpha = 0;
		level.player.auxillary_hud.foreground = 1;
		setsaveddvar("objectiveHide","0");
	}

	if(level.currentgen)
	{
		tff_transitions();
	}
}

//Function Number: 2
intro_lines()
{
	maps\_utility::intro_screen_create("","","");
	maps\_utility::intro_screen_custom_func(::sanfran_intro_screen);
}

//Function Number: 3
sanfran_intro_screen()
{
	thread maps\_introscreen::introscreen_generic_black_fade_in(1,1);
}

//Function Number: 4
precache_main()
{
	precachemodel("viewhands_player_sentinel");
	precachemodel("viewbody_sentinel");
	precachemodel("vehicle_ind_semi_truck_fuel_tanker");
	precachemodel("vehicle_atlas_assault_drone");
	precachemodel("vehicle_atlas_assault_drone_large");
	precachemodel("vm_lasercutter");
	precachemodel("deployable_cover");
	precachemodel("ggb_collapse_03_chunka");
	precachemodel("ggb_collapse_03_chunkb");
	precachemodel("ggb_collapse_03_chunkc");
	precachemodel("ggb_collapse_03_chunkd");
	precachemodel("ggb_collapse_03_chunke");
	precachemodel("ggb_collapse_03_chunkf");
	precachemodel("ggb_collapse_03_chunkg");
	precachemodel("vehicle_sentinel_littlebird_benchright");
	precachemodel("vehicle_sentinel_littlebird_benchleft");
	precachemodel("vehicle_sentinel_littlebird_dstrypv");
	precachemodel("vehicle_civ_domestic_sedan_police_static_dstry02");
	precachemodel("vm_bal27_base_black");
	precachemodel("npc_sn6_base_black");
	precachemodel("tag_laser");
	precachemodel("ggb_cable_hero_01");
	precachemodel("vehicle_civ_domestic_economy_destroy_static");
	precachemodel("vehicle_civ_smartcar_static_dstry");
	precachemodel("ind_semi_truck_fuel_tank_destroy");
	precachemodel("ind_semi_truck_03_destroy");
	precacheitem("rpg_nodamage");
	precacheitem("pitbull_magicbullet");
	precacheitem("iw5_mors_sp");
	precacheitem("iw5_hbra3_sp");
	precacheitem("iw5_uts19_sp");
	precacheitem("iw5_pbw_sp");
	precacheitem("iw5_rhino_sp");
	precacheshellshock("default");
	precachestring(&"SANFRAN_DRIVE_HINT");
	precachestring(&"SANFRAN_SHOOT_HINT");
	precachestring(&"SANFRAN_BOOST_HINT");
	precachestring(&"SANFRAN_NO_TARGET_HINT");
	precachestring(&"SANFRAN_REVERSE_HINT");
	precachestring(&"SANFRAN_OBJ_INTERCEPT");
	precachestring(&"SANFRAN_OBJ_INTERCEPT_POINTER");
	precachestring(&"SANFRAN_OBJ_MEETUP");
	precachestring(&"SANFRAN_OBJ_VAN");
	precachestring(&"SANFRAN_OPEN_VAN");
	precachestring(&"SANFRAN_OBJ_BOAT");
	precachestring(&"SANFRAN_FAIL_CHASE");
	precachestring(&"SANFRAN_FAIL_LEAVING_ROAD");
	precachestring(&"SANFRAN_FAIL_LEAVING_SQUAD");
	precacherumble("steady_rumble");
	precacherumble("light_1s");
	precacherumble("light_2s");
	precacherumble("riotshield_impact");
	precacherumble("heavy_1s");
	precacherumble("heavy_2s");
	precacherumble("heavy_3s");
	precacheshader("hud_icon_nvg");
	maps\_utility::add_control_based_hint_strings("drive_hint",&"SANFRAN_DRIVE_HINT",::maps\sanfran_util::player_is_driving,&"SANFRAN_DRIVE_HINT_PC");
	maps\_utility::add_control_based_hint_strings("shoot_hint",&"SANFRAN_SHOOT_HINT",::maps\sanfran_util::player_is_shooting,&"SANFRAN_SHOOT_HINT_PC");
	maps\_utility::add_hint_string("boost_hint",&"SANFRAN_BOOST_HINT",::maps\sanfran_util::player_has_jumped);
	maps\_utility::add_hint_string("hint_dont_leave_mission",&"SANFRAN_WARNING_SKIP_OBJECTIVE",::maps\sanfran_util::should_break_dont_leave);
	maps\_utility::add_hint_string("no_target_hint",&"SANFRAN_NO_TARGET_HINT");
	maps\_utility::add_control_based_hint_strings("reverse_hint",&"SANFRAN_REVERSE_HINT",::maps\sanfran_code::show_reverse_tutorial_check,&"SANFRAN_REVERSE_HINT_PC");
	maps\_utility::add_control_based_hint_strings("too_far_hint",&"SANFRAN_WARNING_CHASE",::maps\sanfran_util::player_has_caught_up);
	maps\_utility::add_control_based_hint_strings("left_road_hint",&"SANFRAN_WARNING_LEAVING_ROAD",::maps\sanfran_util::player_has_returned_to_road);
	maps\_utility::add_hint_string("left_squad_hint",&"SANFRAN_WARNING_LEAVING_SQUAD",::maps\sanfran_util::player_has_returned_to_squad);
	animscripts\traverse\boost::precache_boost_fx_npc();
}

//Function Number: 5
init_level_flags()
{
	common_scripts\utility::flag_init("flag_obj_van_intercept");
	common_scripts\utility::flag_init("flag_obj_van_meetup");
	common_scripts\utility::flag_init("flag_obj_player_at_van");
	common_scripts\utility::flag_init("flag_obj_player_use_van");
	common_scripts\utility::flag_init("flag_obj_player_used_van");
	common_scripts\utility::flag_init("flag_obj_boost_to_MOB");
	common_scripts\utility::flag_init("flag_obj_player_on_MOB");
	common_scripts\utility::flag_init("flag_intro_transition_to_driving");
	common_scripts\utility::flag_init("flag_intro_van_anim_finished");
	common_scripts\utility::flag_init("flag_intro_give_player_driving");
	common_scripts\utility::flag_init("flag_pitbull_allow_shooting");
	common_scripts\utility::flag_init("flag_player_has_shot_pitbull");
	common_scripts\utility::flag_init("flag_bus_crashed");
	common_scripts\utility::flag_init("flag_player_crashed");
	common_scripts\utility::flag_init("flag_player_crash_complete");
	common_scripts\utility::flag_init("flag_reverse_hint_displayed");
	common_scripts\utility::flag_init("flag_player_can_fire");
	common_scripts\utility::flag_init("flag_fight_start_boost_encounter");
	common_scripts\utility::flag_init("flag_fight_start_police_encounter");
	common_scripts\utility::flag_init("flag_fight_start_tanker_encounter");
	common_scripts\utility::flag_init("flag_fight_start_ambient_encounter");
	common_scripts\utility::flag_init("flag_fight_start_pitbull_encounter");
	common_scripts\utility::flag_init("flag_fight_start_escape_encounter");
	common_scripts\utility::flag_init("flag_fight_start_standoff_encounter");
	common_scripts\utility::flag_init("flag_crash_scene_get_out");
	common_scripts\utility::flag_init("flag_crash_retreat_01");
	common_scripts\utility::flag_init("flag_oncoming_scene_playing");
	common_scripts\utility::flag_init("flag_final_crash_scene_playing");
	common_scripts\utility::flag_init("flag_boost_retreat_01");
	common_scripts\utility::flag_init("flag_player_at_police_battle");
	common_scripts\utility::flag_init("flag_police_retreat_01");
	common_scripts\utility::flag_init("flag_police_retreat_02");
	common_scripts\utility::flag_init("flag_player_at_tanker_battle");
	common_scripts\utility::flag_init("kill_oil_puddle_flames");
	common_scripts\utility::flag_init("flag_tanker_exploded");
	common_scripts\utility::flag_init("flag_tanker_retreat_01");
	common_scripts\utility::flag_init("flag_player_at_ambient_battle");
	common_scripts\utility::flag_init("flag_start_jerk_driver");
	common_scripts\utility::flag_init("flag_player_at_pitbull_battle");
	common_scripts\utility::flag_init("flag_player_at_escape_battle");
	common_scripts\utility::flag_init("flag_player_at_standoff_battle");
	common_scripts\utility::flag_init("flag_player_at_van_standoff");
	common_scripts\utility::flag_init("flag_van_explosion_deploy");
	common_scripts\utility::flag_init("flag_van_explosion_start");
	common_scripts\utility::flag_init("flag_player_at_boost_jump");
	common_scripts\utility::flag_init("flag_at_van_enemy_cleanup");
	common_scripts\utility::flag_init("van_cleanup_complete");
	common_scripts\utility::flag_init("flag_stop_mob_rocking");
	common_scripts\utility::flag_init("flag_enable_battle_chatter");
	common_scripts\utility::flag_init("flag_enable_boost_jump");
	common_scripts\utility::flag_init("flag_hint_player_too_far");
	common_scripts\utility::flag_init("flag_hint_player_left_road");
	common_scripts\utility::flag_init("flag_hint_player_left_squad");
	common_scripts\utility::flag_init("flag_dialog_start_intro");
	common_scripts\utility::flag_init("flag_dialog_intro_fleet");
	common_scripts\utility::flag_init("flag_dialog_intro_cargo");
	common_scripts\utility::flag_init("flag_dialog_start_tunnel");
	common_scripts\utility::flag_init("flag_dialog_tunnel_chase");
	common_scripts\utility::flag_init("flag_dialog_tunnel_update");
	common_scripts\utility::flag_init("flag_dialog_tunnel_bus");
	common_scripts\utility::flag_init("flag_dialog_tunnel_construction");
	common_scripts\utility::flag_init("flag_dialog_tunnel_tanker");
	common_scripts\utility::flag_init("flag_dialog_start_oncoming");
	common_scripts\utility::flag_init("flag_dialog_oncoming_knocked");
	common_scripts\utility::flag_init("flag_dialog_pre_oncoming_knocked");
	common_scripts\utility::flag_init("flag_dialog_oncoming_converging");
	common_scripts\utility::flag_init("flag_dialog_oncoming_battle");
	common_scripts\utility::flag_init("flag_dialog_start_bridge");
	common_scripts\utility::flag_init("flag_dialog_bridge_crash");
	common_scripts\utility::flag_init("flag_dialog_bridge_crawl");
	common_scripts\utility::flag_init("flag_dialog_start_street");
	common_scripts\utility::flag_init("flag_dialog_street_foot");
	common_scripts\utility::flag_init("flag_dialog_street_boost_incoming");
	common_scripts\utility::flag_init("flag_dialog_street_boosters");
	common_scripts\utility::flag_init("flag_dialog_street_sitrep");
	common_scripts\utility::flag_init("flag_dialog_street_helo_intro");
	common_scripts\utility::flag_init("flag_dialog_street_helo_onsite");
	common_scripts\utility::flag_init("flag_dialog_street_helo_change");
	common_scripts\utility::flag_init("flag_dialog_street_helo_warn");
	common_scripts\utility::flag_init("flag_dialog_street_helo_die");
	common_scripts\utility::flag_init("flag_dialog_street_van_stop");
	common_scripts\utility::flag_init("flag_dialog_street_pitbull");
	common_scripts\utility::flag_init("flag_dialog_street_cover");
	common_scripts\utility::flag_init("flag_dialog_street_hurry");
	common_scripts\utility::flag_init("flag_dialog_street_friendlies");
	common_scripts\utility::flag_init("flag_dialog_street_assist");
	common_scripts\utility::flag_init("flag_dialog_start_van");
	common_scripts\utility::flag_init("flag_dialog_van_arrest");
	common_scripts\utility::flag_init("flag_dialog_van_check");
	common_scripts\utility::flag_init("flag_dialog_van_deploy");
	common_scripts\utility::flag_init("flag_dialog_van_collapse");
	common_scripts\utility::flag_init("flag_dialog_start_boost");
	common_scripts\utility::flag_init("flag_dialog_boost_nag");
	common_scripts\utility::flag_init("flag_dialog_boost_chatter");
	common_scripts\utility::flag_init("flag_dialog_boost_mission");
	common_scripts\utility::flag_init("flag_play_van_videolog_pip");
	common_scripts\utility::flag_init("global_accuracy_mod_event");
	common_scripts\utility::flag_init("flag_approach_scene_begin");
	common_scripts\utility::flag_init("player_falling_kill_in_progress");
	common_scripts\utility::flag_init("flag_demo_itiot");
}

//Function Number: 6
init_lighting_flags()
{
	common_scripts\utility::flag_init("start_intro_lighting");
	common_scripts\utility::flag_init("start_tunnel_lighting");
	common_scripts\utility::flag_init("start_oncoming_lighting");
	common_scripts\utility::flag_init("start_bridge_lighting");
	common_scripts\utility::flag_init("start_street_lighting");
	common_scripts\utility::flag_init("start_van_lighting");
	common_scripts\utility::flag_init("start_boost_lighting");
	common_scripts\utility::flag_init("flag_zoom_in_fleet");
	common_scripts\utility::flag_init("flag_zoom_out_fleet");
	common_scripts\utility::flag_init("flag_zoom_in_cargo");
	common_scripts\utility::flag_init("flag_zoom_out_cargo");
	common_scripts\utility::flag_init("flag_cargo_ship");
}

//Function Number: 7
setup_start_points()
{
	maps\_utility::add_start("intro",::start_intro,"",undefined);
	maps\_utility::add_start("tunnel",::start_tunnel,"",undefined);
	maps\_utility::add_start("oncoming",::start_oncoming,"",undefined);
	maps\_utility::add_start("bridge",::start_bridge,"",undefined);
	maps\_utility::add_start("street",::start_street,"",undefined);
	maps\_utility::add_start("police",::start_police,"",undefined);
	maps\_utility::add_start("pitbull",::start_pitbull,"",undefined);
	maps\_utility::add_start("van",::start_van,"",undefined);
	maps\_utility::add_start("boost",::start_boost,"",undefined);
	maps\_utility::add_start("movie capture",::start_movie_capture,"",undefined);
	maps\_utility::add_start("bridge_capture",::start_bridge_capture,"",undefined);
	maps\_utility::add_start("demo_with_itiot",::start_demo_with_itiot,"",undefined);
	if(level.currentgen)
	{
		var_00 = [];
		var_00[0] = "sanfran_intro_tr";
		maps\_utility::set_start_transients("intro",var_00);
		maps\_utility::set_start_transients("tunnel",var_00);
		maps\_utility::set_start_transients("oncoming",var_00);
		maps\_utility::set_start_transients("bridge",var_00);
		var_00[0] = "sanfran_outro_tr";
		maps\_utility::set_start_transients("street",var_00);
		maps\_utility::set_start_transients("police",var_00);
		maps\_utility::set_start_transients("pitbull",var_00);
		var_00[1] = "sanfran_bigm_tr";
		maps\_utility::set_start_transients("van",var_00);
		maps\_utility::set_start_transients("boost",var_00);
		maps\_utility::set_start_transients("movie capture",var_00);
		var_00 = ["sanfran_outro_tr"];
		maps\_utility::set_start_transients("demo_with_itiot",var_00);
	}
}

//Function Number: 8
tff_transitions()
{
	if(!istransientloaded("sanfran_bigm_tr"))
	{
		thread tff_trans_load_bigm();
	}
}

//Function Number: 9
tff_trans_load_bigm()
{
	common_scripts\utility::flag_wait("flag_tff_load_bigm");
	loadtransient("sanfran_bigm_tr");
	while(!istransientloaded("sanfran_bigm_tr"))
	{
		wait(0.05);
	}

	level notify("tff_transition_outro_to_bigm");
}

//Function Number: 10
intro_title_text()
{
	var_00 = newclienthudelem(level.player);
	intro_title_text_start(var_00);
	thread intro_title_text_end(var_00);
}

//Function Number: 11
intro_title_text_start(param_00)
{
	level.player disableweapons();
	level.player freezecontrols(1);
	thread maps\_shg_utility::play_chyron_video("chyron_text_sanfran",1,1);
	common_scripts\utility::flag_wait("chyron_video_done");
	soundscripts\_snd::snd_message("start_intro");
}

//Function Number: 12
intro_title_text_end(param_00)
{
	wait(1);
	var_01 = 1;
	param_00 fadeovertime(var_01);
	param_00.alpha = 0;
	wait(var_01);
	param_00 destroy();
}

//Function Number: 13
start_intro()
{
	soundscripts\_snd::snd_message("start_intro");
	level.player lightsetforplayer("set_tunnel_lighting_0");
	common_scripts\utility::flag_set("start_intro_lighting");
	intro_title_text();
	level thread maps\sanfran_code::handle_drone_opening();
	level thread objectives();
}

//Function Number: 14
start_movie_capture()
{
	common_scripts\utility::flag_set("start_intro_lighting");
	level thread maps\sanfran_code::handle_drone_opening("movie");
}

//Function Number: 15
start_tunnel()
{
	soundscripts\_snd::snd_message("start_tunnel");
	maps\sanfran_util::setup_intro();
	maps\sanfran_util::delete_roadsurface_bridge();
	maps\sanfran_util::toggle_off_real_mob();
	common_scripts\utility::flag_set("start_tunnel_lighting");
	common_scripts\utility::flag_set("msg_vfx_zone2_driving_chase");
	level thread maps\sanfran_code::handle_driving_section();
	level thread objectives();
}

//Function Number: 16
start_oncoming()
{
	soundscripts\_snd::snd_message("start_oncoming");
	maps\sanfran_util::setup_intro();
	maps\sanfran_util::setup_move_player_pitbull("start_oncoming");
	maps\sanfran_util::setup_move_friendly_pitbull("start_oncoming_friendly_pitbull");
	level.friendly_pitbull.shadow_pos = "van";
	maps\sanfran_util::setup_move_chase_van("start_oncoming_chase_van");
	maps\sanfran_util::delete_roadsurface_bridge();
	maps\sanfran_util::toggle_off_real_mob();
	maps\sanfran_util::show_water_final();
	common_scripts\utility::flag_set("flag_obj_van_intercept");
	common_scripts\utility::flag_set("flag_intro_give_player_driving");
	common_scripts\utility::flag_set("start_oncoming_lighting");
	common_scripts\utility::flag_set("msg_vfx_zone2_driving_chase");
	level thread maps\sanfran_code::handle_driving_section("oncoming");
	level thread objectives();
	wait(1);
	maps\sanfran_util::enable_pitbull_shooting();
	common_scripts\utility::flag_set("portal_on_ggb_01");
	wait(0.05);
	common_scripts\utility::flag_clear("portal_on_ggb_01");
}

//Function Number: 17
start_bridge()
{
	soundscripts\_snd::snd_message("start_bridge");
	maps\sanfran_util::setup_intro();
	maps\sanfran_util::setup_move_player_pitbull("start_bridge");
	maps\sanfran_util::setup_move_friendly_pitbull("start_bridge_friendly_pitbull");
	maps\sanfran_util::setup_move_chase_van("start_bridge_chase_van");
	maps\sanfran_util::delete_roadsurface_bridge();
	maps\sanfran_util::toggle_off_real_mob();
	maps\sanfran_util::show_water_final();
	common_scripts\utility::flag_set("flag_intro_give_player_driving");
	common_scripts\utility::flag_set("flag_obj_van_intercept");
	common_scripts\utility::flag_set("start_bridge_lighting");
	common_scripts\utility::flag_set("msg_vfx_zone2_driving_chase");
	level thread maps\sanfran_code::handle_driving_section("bridge");
	level thread objectives();
	wait(1);
	maps\sanfran_util::enable_pitbull_shooting();
	common_scripts\utility::flag_set("portal_on_ggb_01");
	wait(0.05);
	common_scripts\utility::flag_clear("portal_on_ggb_01");
	common_scripts\utility::flag_set("portal_on_ggb_02");
}

//Function Number: 18
start_street()
{
	soundscripts\_snd::snd_message("start_street");
	maps\sanfran_util::hide_fallen_bridge();
	maps\sanfran_util::hide_chase_scene();
	maps\sanfran_util::show_ents_by_targetname("pitbull_crash_collision");
	maps\sanfran_util::solid_ents_by_targetname("pitbull_crash_collision");
	maps\sanfran_util::put_bridge_in_proper_place();
	maps\sanfran_util::make_bridge_normal();
	maps\sanfran_util::set_player_start("start_street");
	maps\sanfran_util::spawn_squad();
	maps\sanfran_util::delete_roadsurface_bridge();
	maps\sanfran_util::toggle_off_real_mob();
	maps\sanfran_util::show_water_final();
	common_scripts\utility::flag_set("flag_obj_van_intercept");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	common_scripts\utility::flag_set("flag_player_crash_complete");
	common_scripts\utility::flag_set("start_street_lighting");
	common_scripts\utility::flag_set("msg_vfx_zone2_driving_chase");
	maps\sanfran_code::start_after_crash_traffic(0);
	level thread maps\sanfran_code::handle_fight_section();
	level thread objectives();
	common_scripts\utility::flag_set("portal_on_ggb_02");
}

//Function Number: 19
start_police()
{
	soundscripts\_snd::snd_message("start_police");
	maps\sanfran_util::hide_fallen_bridge();
	maps\sanfran_util::hide_chase_scene();
	maps\sanfran_util::show_ents_by_targetname("pitbull_crash_collision");
	maps\sanfran_util::solid_ents_by_targetname("pitbull_crash_collision");
	maps\sanfran_util::put_bridge_in_proper_place();
	maps\sanfran_util::make_bridge_normal();
	maps\sanfran_util::set_player_start("start_police");
	maps\sanfran_util::spawn_squad("start_police");
	level thread maps\sanfran_util::give_boost_jump();
	maps\sanfran_util::delete_roadsurface_bridge();
	maps\sanfran_util::toggle_off_real_mob();
	maps\sanfran_util::show_water_final();
	common_scripts\utility::flag_set("flag_obj_van_intercept");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	common_scripts\utility::flag_set("start_street_lighting");
	common_scripts\utility::flag_set("msg_vfx_zone2_driving_chase");
	maps\sanfran_code::start_after_crash_traffic(0);
	level thread maps\sanfran_code::handle_fight_section("police");
	level thread objectives();
	common_scripts\utility::flag_set("portal_on_ggb_02");
}

//Function Number: 20
start_pitbull()
{
	soundscripts\_snd::snd_message("start_pitbull");
	maps\sanfran_util::hide_fallen_bridge();
	maps\sanfran_util::hide_chase_scene();
	maps\sanfran_util::put_bridge_in_proper_place();
	maps\sanfran_util::make_bridge_normal();
	maps\sanfran_util::delete_ents_by_targetname("trigger_tanker_fire_damage");
	maps\sanfran_util::set_player_start("start_pitbull");
	maps\sanfran_util::spawn_squad("start_pitbull");
	level thread maps\sanfran_util::give_boost_jump();
	maps\sanfran_util::delete_roadsurface_bridge();
	maps\sanfran_util::toggle_off_real_mob();
	maps\sanfran_util::show_water_final();
	common_scripts\utility::flag_set("flag_obj_van_intercept");
	common_scripts\utility::flag_set("flag_obj_van_meetup");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	common_scripts\utility::flag_set("flag_fight_start_ambient_encounter");
	common_scripts\utility::flag_set("start_street_lighting");
	common_scripts\utility::flag_set("msg_vfx_zone2_driving_chase");
	level thread maps\sanfran_code::handle_fight_section("pitbull");
	level thread objectives();
}

//Function Number: 21
start_van()
{
	soundscripts\_snd::snd_message("start_van");
	maps\sanfran_util::hide_fallen_bridge();
	maps\sanfran_util::hide_chase_scene();
	maps\sanfran_util::put_bridge_in_proper_place();
	maps\sanfran_util::make_bridge_normal();
	maps\sanfran_util::set_player_start("start_van_boost");
	maps\sanfran_util::spawn_squad("start_van_boost");
	thread maps\sanfran_code::setup_bridge_explosion_anim_sequence();
	maps\sanfran_util::delete_roadsurface_bridge();
	maps\sanfran_util::toggle_off_real_mob();
	maps\sanfran_util::toggle_on_real_mob();
	maps\sanfran_util::show_water_final();
	common_scripts\utility::run_thread_on_targetname("trigger_fall_fail",::maps\sanfran_util::fall_fail);
	common_scripts\utility::run_thread_on_targetname("trigger_fall_fail_remove",::maps\sanfran_util::fall_fail);
	common_scripts\utility::flag_set("flag_obj_van_intercept");
	common_scripts\utility::flag_set("flag_obj_van_meetup");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	common_scripts\utility::flag_set("start_van_lighting");
	common_scripts\utility::flag_set("msg_vfx_zone2_driving_chase");
	level thread objectives();
	common_scripts\utility::run_thread_on_targetname("trigger_player_at_van",::maps\sanfran_code::handle_bridge_collapse);
	if(level.currentgen)
	{
		common_scripts\utility::run_thread_on_targetname("trigger_player_at_van",::maps\sanfran_code::handle_player_exo_punch);
	}
}

//Function Number: 22
start_boost()
{
	soundscripts\_snd::snd_message("start_boost");
	maps\sanfran_util::put_bridge_in_proper_place();
	maps\sanfran_util::make_bridge_normal();
	maps\sanfran_util::hide_intact_bridge();
	maps\sanfran_util::remove_intact_bridge();
	maps\sanfran_util::connectpaths_ents_by_targetname("collapse_clip");
	maps\sanfran_util::delete_ents_by_targetname("collapse_clip");
	maps\sanfran_util::set_player_start("start_van_boost");
	maps\sanfran_util::spawn_squad("start_van_boost");
	maps\sanfran_util::delete_roadsurface_bridge();
	maps\sanfran_util::toggle_on_real_mob();
	maps\sanfran_util::show_water_final();
	common_scripts\utility::run_thread_on_targetname("trigger_fall_fail",::maps\sanfran_util::fall_fail);
	common_scripts\utility::flag_set("flag_obj_van_intercept");
	common_scripts\utility::flag_set("flag_obj_van_meetup");
	common_scripts\utility::flag_set("flag_obj_player_at_van");
	common_scripts\utility::flag_set("flag_obj_player_use_van");
	common_scripts\utility::flag_set("flag_obj_player_used_van");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	common_scripts\utility::flag_set("start_boost_lighting");
	common_scripts\utility::flag_set("msg_vfx_zone2_driving_chase");
	level thread objectives();
	level thread maps\sanfran_code::rock_mob();
	level thread maps\sanfran_code::handle_boost_jump();
	common_scripts\utility::flag_set("portal_on_collapse");
	wait(0.05);
	common_scripts\utility::flag_clear("portal_on_collapse");
}

//Function Number: 23
start_bridge_capture()
{
	level.idle_scene_ents = [];
	level.barrier_scene_ents = [];
	level.approach_scene_ents = [];
	level.approach_idle_ents = [];
	level.deploy_scene_ents = [];
	level.collapse_scene_ents = [];
	level.collapse_scene_ents_long = [];
	level.after_collpase_ents = [];
	level.explosion_scene_org = getent("bridge_explosion_origin","targetname");
	maps\sanfran_code::setup_bridge_explosion_anim_sequence_bridge();
	level thread maps\sanfran_code::start_bridge_after_loop(level.explosion_scene_org);
	maps\sanfran_util::put_bridge_in_proper_place();
	maps\sanfran_util::make_bridge_normal();
	maps\sanfran_util::hide_intact_bridge();
	maps\sanfran_util::remove_intact_bridge();
	maps\sanfran_util::connectpaths_ents_by_targetname("collapse_clip");
	maps\sanfran_util::delete_ents_by_targetname("collapse_clip");
	maps\sanfran_util::set_player_start("start_van_boost");
	maps\sanfran_util::spawn_squad("start_van_boost");
	maps\sanfran_util::delete_roadsurface_bridge();
	maps\sanfran_util::toggle_on_real_mob();
	maps\sanfran_util::show_water_final();
	common_scripts\utility::run_thread_on_targetname("trigger_fall_fail",::maps\sanfran_util::fall_fail);
	common_scripts\utility::flag_set("flag_obj_van_intercept");
	common_scripts\utility::flag_set("flag_obj_van_meetup");
	common_scripts\utility::flag_set("flag_obj_player_at_van");
	common_scripts\utility::flag_set("flag_obj_player_use_van");
	common_scripts\utility::flag_set("flag_obj_player_used_van");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	common_scripts\utility::flag_set("start_boost_lighting");
	common_scripts\utility::flag_set("msg_vfx_zone2_driving_chase");
	thread maps\sanfran_fx::stop_falling_debris_by_player();
	thread maps\sanfran_fx::bridge_collapse_mob_explosion();
	level thread objectives();
	level thread maps\sanfran_code::rock_mob();
	level thread maps\sanfran_code::handle_boost_jump();
	setsaveddvar("objectiveHide","1");
	common_scripts\utility::flag_set("portal_on_collapse");
	common_scripts\utility::flag_clear("portal_on_collapse");
	foreach(var_01 in level.collapse_scene_ents)
	{
		var_01 show();
	}

	maps\_utility::delaythread(1,::maps\_utility::pauseexploder,100);
	maps\_utility::delaythread(1,::maps\_utility::pauseexploder,200);
	level.player takeallweapons();
	var_03 = common_scripts\utility::spawn_tag_origin();
	level.player maps\_utility::teleport_player(var_03);
	level.player playerlinktoabsolute(var_03,"tag_origin");
	for(;;)
	{
		var_03.origin = (3244,78603,4885);
		var_03.angles = (17.6333,-139.389,0);
		wait(30);
		var_03.origin = (-7204,70913,2547);
		var_03.angles = (18.7136,137.806,0);
		wait(30);
		var_03.origin = (-6068,70229,423);
		var_03.angles = (9.6663,131.838,0);
		wait(30);
		var_03.origin = (5885,63227,2920);
		var_03.angles = (25.2254,143.381,0);
		wait(30);
	}
}

//Function Number: 24
start_demo_with_itiot()
{
	thread itiot_logic("flag_demo_itiot","van");
	if(isdefined(level.introscreen.customfunc))
	{
		thread [[ level.introscreen.customfunc ]]();
	}

	start_intro();
}

//Function Number: 25
objectives()
{
	if(common_scripts\utility::flag("flag_obj_van_meetup"))
	{
		objective_add(maps\_utility::obj("obj_intercept"),"done",&"SANFRAN_OBJ_INTERCEPT");
	}
	else
	{
		common_scripts\utility::flag_wait("flag_obj_van_intercept");
		objective_add(maps\_utility::obj("obj_intercept"),"current",&"SANFRAN_OBJ_INTERCEPT");
		if(isdefined(level.chase_van))
		{
			objective_onentity(maps\_utility::obj("obj_intercept"),level.chase_van,(0,0,60));
		}

		objective_setpointertextoverride(maps\_utility::obj("obj_intercept"),&"SANFRAN_OBJ_INTERCEPT_POINTER");
		common_scripts\utility::flag_wait("flag_player_crashed");
		maps\_utility::objective_complete(maps\_utility::obj("obj_intercept"));
		common_scripts\utility::flag_wait("flag_obj_van_meetup");
	}

	objective_add(maps\_utility::obj("obj_meet"),"current",&"SANFRAN_OBJ_MEETUP");
	objective_position(maps\_utility::obj("obj_meet"),getent("objective_meet_up","targetname").origin);
	common_scripts\utility::flag_wait("flag_obj_player_at_van");
	maps\_utility::objective_complete(maps\_utility::obj("obj_meet"));
	common_scripts\utility::flag_wait("flag_obj_player_use_van");
	if(!common_scripts\utility::flag("flag_obj_player_used_van"))
	{
		objective_add(maps\_utility::obj("obj_use_van"),"current",&"SANFRAN_OBJ_VAN");
		var_00 = getent("trigger_player_used_van","targetname");
		var_01 = var_00.origin;
		objective_position(maps\_utility::obj("obj_use_van"),var_01);
		objective_setpointertextoverride(maps\_utility::obj("obj_use_van"),&"SANFRAN_OBJ_POINTER_OPEN");
		common_scripts\utility::flag_wait("flag_obj_player_used_van");
		maps\_utility::objective_complete(maps\_utility::obj("obj_use_van"));
	}
	else
	{
		objective_add(maps\_utility::obj("obj_use_van"),"done",&"SANFRAN_OBJ_VAN");
	}

	common_scripts\utility::flag_wait("flag_obj_boost_to_MOB");
	objective_add(maps\_utility::obj("obj_boat"),"current",&"SANFRAN_OBJ_BOAT");
	objective_position(maps\_utility::obj("obj_boat"),getent("objective_boat","targetname").origin);
	common_scripts\utility::flag_wait("flag_obj_player_on_MOB");
	maps\_utility::objective_complete(maps\_utility::obj("obj_boat"));
}

//Function Number: 26
global_spawn_functions()
{
	maps\_utility::add_global_spawn_function("axis",::enable_jump_jet_pathing);
	maps\_utility::add_global_spawn_function("allies",::enable_jump_jet_pathing);
	maps\_utility::add_global_spawn_function("axis",::toggle_battle_chatter);
	maps\_utility::add_global_spawn_function("allies",::toggle_battle_chatter);
	maps\_utility::add_global_spawn_function("axis",::increase_actor_base_accuracy_by_player_distance);
}

//Function Number: 27
increase_actor_base_accuracy_by_player_distance()
{
	self endon("death");
	var_00 = undefined;
	if(isdefined(self.baseaccuracy))
	{
		var_00 = self.baseaccuracy;
	}

	for(;;)
	{
		level waittill("global_accuracy_mod_event");
		self.baseaccuracy = var_00 + level.axis_global_accuracy_mod;
		wait(0.5);
	}
}

//Function Number: 28
enable_jump_jet_pathing()
{
	self.canjumppath = 1;
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "friendly_police")
	{
		self.canjumppath = 0;
	}
}

//Function Number: 29
toggle_battle_chatter()
{
	self endon("death");
	for(;;)
	{
		maps\_utility::set_battlechatter(0);
		common_scripts\utility::flag_wait("flag_enable_battle_chatter");
		maps\_utility::set_battlechatter(1);
		common_scripts\utility::flag_waitopen("flag_enable_battle_chatter");
	}
}

//Function Number: 30
setup_portal_scripting()
{
	common_scripts\utility::flag_init("portal_on_ggb_01");
	thread handle_sanfran_portal_groups_on("portal_grp_ggbridge_01","portal_on_ggb_01","endPortalGGB_01");
	common_scripts\utility::flag_init("portal_on_ggb_02");
	thread handle_sanfran_portal_groups_on("portal_grp_ggbridge_02","portal_on_ggb_02");
	common_scripts\utility::flag_init("portal_on_collapse");
	thread handle_sanfran_portal_groups_on("portal_grp_collapsed_bridge","portal_on_collapse","endPortalCollapse");
}

//Function Number: 31
handle_sanfran_portal_groups_on(param_00,param_01,param_02)
{
	level.player endon("death");
	level endon("missionfailed");
	if(isdefined(param_02) && isstring(param_02))
	{
		level endon(param_02);
	}

	var_03 = getentarray(param_00,"targetname");
	var_03[0] enableportalgroup(0);
	for(;;)
	{
		common_scripts\utility::flag_wait(param_01);
		var_03[0] enableportalgroup(1);
		if(isdefined(param_02))
		{
			level notify(param_02);
		}

		common_scripts\utility::flag_waitopen(param_01);
		var_03[0] enableportalgroup(0);
	}
}

//Function Number: 32
itiot_logic(param_00,param_01)
{
	common_scripts\utility::flag_wait(param_00);
	setdvar("demo_itiot","1");
	soundscripts\_snd::snd_message("e3_demo_fade_out");
	level.player.auxillary_hud = newclienthudelem(level.player);
	level.player.auxillary_hud setshader("black",1280,720);
	level.player.auxillary_hud.horzalign = "fullscreen";
	level.player.auxillary_hud.vertalign = "fullscreen";
	level.player.auxillary_hud.alpha = 0;
	level.player.auxillary_hud fadeovertime(0.5);
	level.player.auxillary_hud.alpha = 1;
	level.player.auxillary_hud.foreground = 1;
	setsaveddvar("objectiveHide","1");
	wait(0.5);
	level.player.auxillary_hud.foreground = 0;
	wait(7);
	soundscripts\_snd::snd_message("e3_demo_fade_in");
	level.player setorigin((-3665,72067,547));
	level.player setplayerangles((0,172,0));
	thread maps\sanfran_code::setup_bridge_explosion_anim_sequence();
	common_scripts\utility::run_thread_on_targetname("trigger_player_at_van",::maps\sanfran_code::handle_bridge_collapse);
	level.player.auxillary_hud.alpha = 1;
	level.player.auxillary_hud fadeovertime(1);
	level.player.auxillary_hud.alpha = 0;
}

//Function Number: 33
prep_cinematic(param_00)
{
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingame(param_00,1);
	level.current_cinematic = param_00;
}

//Function Number: 34
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