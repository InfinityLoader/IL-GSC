/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 693 ms
 * Timestamp: 4/22/2024 2:28:53 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\_utility::template_level("finale");
	maps\_utility::add_start("intro",::debug_start_intro,"Intro",::intro_logic);
	maps\_utility::add_start("intro_skip",::debug_start_intro_skip,"Intro skip",::intro_logic);
	maps\_utility::add_start("canal",::debug_canal_start,"Canal",::canal_logic);
	maps\_utility::add_start("canal_breach",::debug_canal_breach_start,"Canal Breach",::canal_breach_logic);
	maps\_utility::add_start("silo_approach",::debug_silo_approach_start,"Silo Approach",::silo_approach_logic);
	maps\_utility::add_start("silo_floor_03",::debug_silo_floor_03_start,"Silo Floor 3",::silo_floor_03_logic);
	maps\_utility::add_start("silo_door_kick",::debug_door_kick_start,"Silo Door Kick",::silo_door_kick_logic);
	maps\_utility::add_start("silo_exhaust_entrance",::debug_silo_exhaust_entrance_start,"Silo Exhaust Entrance",::silo_exhaust_entrance_logic);
	maps\_utility::add_start("lobby",::debug_lobby_start,"Lobby",::silo_lobby_logic);
	maps\_utility::add_start("sky_bridge",::debug_sky_bridge_start,"Sky Bridge",::silo_sky_bridge_logic);
	maps\_utility::add_start("will_room",::debug_will_room_start,"Will Room",::will_room_logic);
	maps\_utility::add_start("irons_chase",::debug_irons_chase,"Irons Chase",::irons_chase_logic);
	maps\_utility::add_start("roof",::debug_roof_start,"Roof",::roof_logic);
	if(level.currentgen)
	{
		setup_cg_start_points();
		maps\_utility::tff_sync_setup();
	}

	common_scripts\utility::flag_init("flag_exhaust_hatch_open");
	maps\createart\finale_art::main();
	maps\finale_fx::main();
	maps\finale_precache::main();
	maps\_load::main();
	thread maps\_player_exo::main(undefined,undefined,0);
	maps\_credits::initcredits("all");
	maps\finale_lighting::main2();
	maps\finale_aud::main();
	maps\finale_anim::main();
	maps\_water::init();
	maps\_utility::add_control_based_hint_strings("takedown_hint",&"FINALE_ACTION_MELEE",::maps\finale_utility::takedown_hint_off);
	maps\_utility::add_control_based_hint_strings("player_input_shaft_buttons",&"FINALE_SHAFT_BUTTONS",::maps\finale_shaft::player_input_shaft_buttons_off);
	maps\_utility::add_control_based_hint_strings("player_input_shaft_buttons_pc_alt",&"FINALE_SHAFT_BUTTONS_PC_ALT",::maps\finale_shaft::player_input_shaft_buttons_off);
	maps\_utility::add_control_based_hint_strings("player_input_sprint_hint",&"FINALE_SPRINT_BUTTON_HINT",::maps\finale_utility::player_input_sprint);
	maps\_utility::add_control_based_hint_strings("player_input_slide_button",&"FINALE_SLIDE_BUTTON_HINT",::maps\finale_utility::player_input_slide_under_door,&"FINALE_SLIDE_BUTTON_HINT_KB");
	maps\_utility::add_control_based_hint_strings("release_hint",&"FINALE_HELO_RELEASE_HINT",::maps\finale_code::release_hint_off);
	maps\_utility::add_control_based_hint_strings("player_input_tackle_hint",&"FINALE_ACTION_TACKLE",::maps\finale_utility::tackle_handle_hint_display);
	maps\_utility::add_control_based_hint_strings("break_free_buttonmash_hint",&"FINALE_ACTION_TAP_FREE",::maps\finale_utility::process_buttonmash_handle_hint);
	maps\_utility::add_control_based_hint_strings("final_scene_melee_hint",&"FINALE_ACTION_MELEE_FINAL",::maps\finale_utility::final_scene_handle_melee_hint);
	maps\_utility::add_control_based_hint_strings("final_scene_buttonmash_hint",&"FINALE_ACTION_TAP_STRUGGLE",::maps\finale_utility::process_buttonmash_handle_hint);
	precacheturret("heli_spotlight_so_castle");
	precachemodel("com_blackhawk_spotlight_on_mg_setup");
	precachemodel("npc_titan45_base");
	precachemodel("npc_titan45_cutscene");
	precachemodel("npc_titan45_base_nocamo");
	precachemodel("vm_world_body_mech");
	precachemodel("semx_explosive_mech");
	precachemodel("fin_silo_floor_hatch_piston_l");
	precachemodel("fin_silo_floor_hatch_piston_r");
	precachemodel("fin_silo_floor_hatch");
	precacheitem("iw5_titan45finalelobby_sp_xmags");
	precacheitem("iw5_unarmedfinale_nullattach");
	precacheitem("iw5_unarmedfinaleknife");
	precacheitem("iw5_hbra3_sp");
	precachemodel("genericprop");
	precachemodel("npc_exo_armor_bigfin");
	precachemodel("fin_body_scanner_door");
	precachemodel("body_sentinel_exo_ingress");
	precachemodel("viewhands_sentinel_mitchell_prosthetic_smashed");
	precachemodel("viewhands_noexo_mitchell_prosthetic_smashed");
	precachemodel("viewbody_sentinel_pilot_mitchell_nub_fullarm");
	precachemodel("viewbody_sentinel_pilot_mitchell_nub");
	precachemodel("viewbody_sentinel_mitchell_egress_custom");
	precacheitem("playermech_auto_cannon_finale_exhaust");
	precacheitem("playermech_rocket_swarm_finale_exhaust");
	precacheitem("playermech_rocket_finale_exhaust");
	precachemodel("fin_side_missile_02");
	precachemodel("fin_side_missile_white_panel_top_r_01");
	precachemodel("fin_side_missile_white_panel_top_l_01");
	precachemodel("fin_side_missile_white_panel_bottom_r_01");
	precachemodel("fin_side_missile_white_panel_bottom_l_01");
	precachemodel("fin_side_missile_engine_nozzel_piece_01");
	precachemodel("fin_side_missile_engine_nozzel_piece_02");
	precachemodel("fin_side_missile_engine_brace_piece_01");
	precachemodel("fin_side_missile_side_box_piece_r_01");
	precachemodel("fin_side_missile_side_box_piece_l_01");
	precachemodel("vm_exo_armor_minigun_base");
	precachemodel("vm_mitchell_finale_knife");
	precachemodel("fin_railing_roof_03_anim");
	precachemodel("rope1ft_2j");
	precacherumble("damage_light");
	precacherumble("light_1s");
	precacherumble("damage_heavy");
	precacherumble("heavy_1s");
	precacherumble("pistol_fire");
	precacheshader("bls_end_credits_b1");
	if(level.currentgen)
	{
		precacheshader("fullscreen_lit_bloodsplat_01");
	}

	common_scripts\utility::flag_init("flag_chyron_finale_complete");
	common_scripts\utility::flag_init("flag_release_hint_off");
	common_scripts\utility::flag_init("flag_intro_screen_complete");
	common_scripts\utility::flag_init("flag_canal_combat_start");
	common_scripts\utility::flag_init("flag_se_intro_flyin_start");
	common_scripts\utility::flag_init("flag_intro_flyin_start");
	common_scripts\utility::flag_init("flag_boat_single_dead");
	common_scripts\utility::flag_init("flag_boat_canal_dead");
	common_scripts\utility::flag_init("flag_intro_flyin_release");
	common_scripts\utility::flag_init("flag_ai_silo_floor_01_end");
	common_scripts\utility::flag_init("flag_missile_seated");
	common_scripts\utility::flag_init("flag_silo_watwalks_open");
	common_scripts\utility::flag_init("flag_silo_combat_complete");
	common_scripts\utility::flag_init("flag_se_door_kick_complete");
	common_scripts\utility::flag_init("flag_countdown_complete_mission_fail");
	common_scripts\utility::flag_init("flag_obj_exhaust_hatch_open");
	common_scripts\utility::flag_init("flag_obj_exhaust_hatch_position");
	common_scripts\utility::flag_init("flag_exhaust_hatch_complete");
	common_scripts\utility::flag_init("flag_missile_ignition_start");
	common_scripts\utility::flag_init("flag_player_shoot_missile");
	common_scripts\utility::flag_init("flag_exhaust_corridor_timer_fail");
	common_scripts\utility::flag_init("flag_missile_hit");
	common_scripts\utility::flag_init("flag_missile_failed");
	common_scripts\utility::flag_init("flag_missile_damaged");
	common_scripts\utility::flag_init("flag_obj_escape");
	common_scripts\utility::flag_init("flag_obj_stop_missile_launch_complete");
	common_scripts\utility::flag_init("flag_se_mech_exit_init");
	common_scripts\utility::flag_init("flag_se_mech_exit_start");
	common_scripts\utility::flag_init("flag_lobby_combat_start");
	common_scripts\utility::flag_init("flag_lobby_seek_player");
	common_scripts\utility::flag_init("flag_lobby_player_can_shoot");
	common_scripts\utility::flag_init("flag_lobby_clear");
	common_scripts\utility::flag_init("flag_se_will_reveal");
	common_scripts\utility::flag_init("flag_will_reveal_complete");
	common_scripts\utility::flag_init("flag_will_reveal_irons_complete");
	common_scripts\utility::flag_init("flag_obj_escape_complete");
	common_scripts\utility::flag_init("flag_bridge_takedown_jump_complete");
	common_scripts\utility::flag_init("flag_se_bridge_takedown_success");
	common_scripts\utility::flag_init("flag_balcony_tackle_fake_okay");
	common_scripts\utility::flag_init("flag_balcony_tackle_okay");
	common_scripts\utility::flag_init("flag_balcony_tackle_too_late");
	common_scripts\utility::flag_init("flag_balcony_tackle_started");
	common_scripts\utility::flag_init("flag_balcony_tackle_success");
	common_scripts\utility::flag_init("flag_balcony_pt2_start");
	common_scripts\utility::flag_init("flag_button_melee_success");
	common_scripts\utility::flag_init("flag_stop_display_melee_hint");
	common_scripts\utility::flag_init("flag_buttonmash_success");
	common_scripts\utility::flag_init("flag_irons_escaped");
	common_scripts\utility::flag_init("flag_se_irons_end");
	common_scripts\utility::flag_init("flag_player_speed_control_on");
	common_scripts\utility::flag_init("flag_obj_irons_complete");
	common_scripts\utility::flag_init("flag_balcony_finale_success");
	common_scripts\utility::flag_init("underwater_flashlight");
	common_scripts\utility::flag_init("lighting_missile_fail");
	common_scripts\utility::flag_init("flag_lighting_fall_blur");
	common_scripts\utility::flag_init("lighting_flag_obj_stop_missile_complete");
	common_scripts\utility::flag_init("arm_off");
	common_scripts\utility::flag_init("flag_sit_down");
	if(level.currentgen)
	{
		common_scripts\utility::flag_init("load_middle_transient");
		common_scripts\utility::flag_init("middle_loaded_successfully");
		common_scripts\utility::flag_init("load_outro_transient");
		common_scripts\utility::flag_init("outro_loaded_successfully");
		thread load_middle_transient();
		thread load_missile_area_transient();
		thread load_outro_transient();
	}

	maps\finale_utility::load_mech();
	var_00["mech_base_weapon"] = "playermech_auto_cannon_finale";
	var_00["mech_lethal_weapon"] = "playermech_rocket_finale";
	var_00["mech_tactical_weapon"] = "playermech_rocket_swarm_finale";
	var_00["mech_swarm_rocket"] = "playermech_rocket_projectile";
	var_00["mech_swarm_rocket_deploy"] = "playermech_rocket_deploy_projectile";
	var_00["mech_base_no_weapon"] = "playermech_auto_cannon_noweap";
	var_00["mech_dmg1_weapon"] = "playermech_auto_cannon_dmg1";
	var_00["mech_dmg2_weapon"] = "playermech_auto_cannon_dmg2";
	level.player maps\_playermech_code::playermech_init(var_00);
	level.player maps\_playermech_code::playermech_disable_badplace();
	common_scripts\utility::flag_set("flag_mech_vo_active");
	thread maps\finale_utility::mech_setup();
	thread global_spawn_functions();
	thread delete_wills_room_clip();
	thread lightingstate();
	level.friendlyfire_damage_modifier = 0.05;
	maps\finale_vo::main();
	maps\finale_utility::spawn_metrics_init();
	level.player enablealternatemelee();
	animscripts\traverse\boost::precache_boost_fx_npc();
	level.underwater_lightset = "underwater_lightset";
	level.visionset_default = "finale_interior";
	level.visionset_underwater = "finale_underwater";
	level.use_two_stage_swarm = 1;
	level.clut_underwater = "clut_finale_underwater";
	level.clut_previous = "clut_finale_intro";
	if(level.currentgen)
	{
		setsaveddvar("r_gunSightColorEntityScale","7");
		setsaveddvar("r_gunSightColorNoneScale","0.8");
	}

	common_scripts\utility::flag_wait("flag_balcony_finale_success");
	thread maps\_credits::allow_early_back_out();
	maps\_credits::playcredits();
	post_credits_still_image();
	maps\_utility::nextmission();
	changelevel("",0);
}

//Function Number: 2
post_credits_still_image()
{
	var_00 = 2;
	var_01 = 2;
	var_02 = maps\_hud_util::create_client_overlay("black",0,level.player);
	var_02.sort = 100;
	var_02 fadeovertime(1);
	var_02.alpha = 1;
	wait(var_00 + var_01);
	var_03 = maps\_hud_util::create_client_overlay("bls_end_credits_b1",0,level.player);
	var_03.sort = 101;
	var_04 = 3;
	var_01 = 5;
	var_05 = 3;
	var_03 fadeovertime(var_04);
	var_03.alpha = 1;
	wait(var_04 + var_01);
	var_03 fadeovertime(var_05);
	var_03.alpha = 0;
	wait(2);
}

//Function Number: 3
delete_wills_room_clip()
{
	var_00 = getent("clip_wills_room","targetname");
	var_00 delete();
}

//Function Number: 4
setup_cg_start_points()
{
	var_00 = ["finale_intro_tr"];
	maps\_utility::set_start_transients("intro",var_00);
	maps\_utility::set_start_transients("intro_skip",var_00);
	maps\_utility::set_start_transients("canal",var_00);
	maps\_utility::set_start_transients("canal_breach",var_00);
	var_00 = ["finale_middle_tr"];
	maps\_utility::set_start_transients("silo_approach",var_00);
	maps\_utility::set_start_transients("silo_floor_03",var_00);
	maps\_utility::set_start_transients("silo_exhaust_entrance",var_00);
	var_00 = ["finale_outro_tr"];
	maps\_utility::set_start_transients("lobby",var_00);
	maps\_utility::set_start_transients("sky_bridge",var_00);
	maps\_utility::set_start_transients("will_room",var_00);
	maps\_utility::set_start_transients("roof",var_00);
}

//Function Number: 5
load_middle_transient()
{
	maps\_utility::trigger_wait_targetname("load_finale_middle_tr");
	common_scripts\utility::flag_set("load_middle_transient");
	unload_load_transients("finale_intro_tr","finale_middle_tr","middle_loaded_successfully");
}

//Function Number: 6
load_missile_area_transient()
{
	maps\_utility::trigger_wait_targetname("player_is_falling_down_the_exhaust_shaft");
	unload_load_transients("finale_middle_tr","finale_missile_area_tr","missile_area_loaded_successfully");
}

//Function Number: 7
load_outro_transient()
{
	common_scripts\utility::flag_wait("load_outro_transient");
	unload_load_transients("finale_missile_area_tr","finale_outro_tr","outro_loaded_successfully");
}

//Function Number: 8
unload_load_transients(param_00,param_01,param_02)
{
	if(istransientloaded(param_00))
	{
		unloadtransient(param_00);
	}

	loadtransient(param_01);
	for(;;)
	{
		if(istransientloaded(param_01))
		{
			if(common_scripts\utility::flag_exist(param_02))
			{
				common_scripts\utility::flag_set(param_02);
			}

			break;
		}

		wait(0.1);
	}
}

//Function Number: 9
global_spawn_functions()
{
	maps\_utility::add_global_spawn_function("axis",::enable_jump_jet_pathing);
	maps\_utility::add_global_spawn_function("axis",::maps\finale_code::player_mech_melee_modifier);
}

//Function Number: 10
enable_jump_jet_pathing()
{
	if(issubstr(self.classname,"jump"))
	{
		self.canjumppath = 1;
	}
}

//Function Number: 11
set_completed_flags()
{
	if(maps\_utility::is_default_start())
	{
		return;
	}

	var_00 = level.start_point;
	if(var_00 == "intro")
	{
		return;
	}

	if(var_00 == "intro_skip")
	{
		return;
	}

	common_scripts\utility::flag_set("flag_intro_screen_complete");
	common_scripts\utility::flag_set("flag_intro_flyin_release");
	if(var_00 == "canal")
	{
		return;
	}

	common_scripts\utility::flag_set("flag_obj_enter_silo_update");
	if(var_00 == "canal_breach")
	{
		return;
	}

	common_scripts\utility::flag_set("flag_obj_enter_silo_complete");
	if(var_00 == "silo_approach")
	{
		return;
	}

	if(var_00 == "silo_floor_03")
	{
		return;
	}

	common_scripts\utility::flag_set("flag_silo_combat_stop");
	common_scripts\utility::flag_set("flag_silo_combat_complete");
	if(var_00 == "silo_door_kick")
	{
		return;
	}

	common_scripts\utility::flag_set("flag_dialogue_exhaust_hatch");
	common_scripts\utility::flag_set("flag_obj_exhaust_hatch_position");
	common_scripts\utility::flag_set("flag_missile_seated");
	common_scripts\utility::flag_set("flag_se_exhaust_hatch_init");
	if(var_00 == "silo_exhaust_entrance")
	{
		return;
	}

	common_scripts\utility::flag_set("flag_obj_exhaust_hatch_open");
	common_scripts\utility::flag_set("flag_exhaust_hatch_grab");
	common_scripts\utility::flag_set("flag_exhaust_hatch_open");
	common_scripts\utility::flag_set("flag_missile_launch_stop");
	common_scripts\utility::flag_set("flag_obj_escape");
	common_scripts\utility::flag_set("flag_obj_stop_missile_launch_complete");
	if(var_00 == "lobby")
	{
		return;
	}

	if(var_00 == "sky_bridge")
	{
		return;
	}

	common_scripts\utility::flag_set("flag_dialogue_carry_scene_02_complete");
	if(var_00 == "will_room")
	{
		return;
	}

	common_scripts\utility::flag_set("flag_start_irons_chase");
	common_scripts\utility::flag_set("flag_obj_escape_complete");
	if(var_00 == "irons_chase")
	{
		return;
	}

	common_scripts\utility::flag_set("flag_irons_rooftop");
	if(var_00 == "roof")
	{
	}
}

//Function Number: 12
spawn_gideon_mech()
{
	level.gideon = maps\_utility::spawn_targetname("gideon_mech");
	level.gideon thread maps\_utility::deletable_magic_bullet_shield();
	maps\_playermech_code::add_swarm_repulsor_for_ally(level.gideon,level.player);
	level.gideon.animname = "gideon_mech";
	level.gideon maps\finale_utility::setstencilstate();
	thread maps\finale_lighting::gideon_mech_light();
	level.gideon.forcealtmeleedeaths = 1;
	level.gideon thread dont_tread_on_me();
	if(common_scripts\utility::flag("flag_obj_enter_silo_complete"))
	{
		level.gideon maps\_mech::mech_start_rockets(512,undefined,undefined,undefined,83.33334,undefined,undefined);
	}
}

//Function Number: 13
dont_tread_on_me()
{
	var_00 = squared(36);
	self endon("death");
	for(;;)
	{
		foreach(var_02 in getaiarray("axis"))
		{
			if(distancesquared(var_02.origin,self.origin) < var_00)
			{
				var_02 dodamage(999999999,self.origin,self,self,"MOD_MELEE");
			}
		}

		wait 0.05;
	}
}

//Function Number: 14
spawn_gideon()
{
	if(!isdefined(level.gideon))
	{
		level.gideon = maps\_utility::spawn_targetname("gideon");
		level.gideon thread maps\_utility::magic_bullet_shield();
		level.gideon.animname = "gideon";
		level.gideon maps\finale_utility::disable_grenades();
	}
}

//Function Number: 15
obj_init()
{
	obj_enter_atlas_silo();
	obj_stop_missile_launch();
	obj_escape();
	obj_irons();
}

//Function Number: 16
debug_start_intro_skip()
{
	level.debugskip_intro = 1;
	debug_start_intro();
}

//Function Number: 17
debug_start_intro()
{
	soundscripts\_snd::snd_message("start_intro");
	common_scripts\utility::flag_set("first_half_lighting");
	thread maps\finale_lighting::enable_physical_dof();
	thread maps\finale_lighting::dof_intro();
	set_completed_flags();
	spawn_gideon_mech();
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
	level.player lightsetforplayer("finale");
	maps\_utility::vision_set_fog_changes("finale",0);
	level.player setclutforplayer("clut_finale_intro",0);
}

//Function Number: 18
intro_logic()
{
	common_scripts\utility::flag_set("flag_intro_flyin_start");
	common_scripts\utility::flag_set("flyin_mb");
	level.player setclutforplayer("clut_finale_intro",0);
}

//Function Number: 19
debug_canal_start()
{
	soundscripts\_snd::snd_message("start_canal");
	common_scripts\utility::flag_set("first_half_lighting");
	common_scripts\utility::flag_set("underwater_flashlight");
	set_completed_flags();
	spawn_gideon_mech();
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_canal_start");
	level.player maps\finale_utility::mech_enable(undefined,1);
	level.player thread maps\finale_code::threat_bias_silo_think();
	maps\_utility::vision_set_fog_changes("finale_underwater",0);
	level.player setclutforplayer("clut_finale_underwater",0);
	wait(0.05);
	level.player.inwater = 1;
	var_00 = getent("trigger_underwater","targetname");
	level.player thread maps\_water::playerinwater(var_00);
	level.gideon thread maps\_water::aiinwater(var_00);
	thread maps\finale_code::player_speed_control_underwater();
	maps\_utility::activate_trigger_with_targetname("trig_color_canal_land");
}

//Function Number: 20
canal_logic()
{
}

//Function Number: 21
debug_canal_breach_start()
{
	soundscripts\_snd::snd_message("start_canal");
	common_scripts\utility::flag_set("first_half_lighting");
	set_completed_flags();
	spawn_gideon_mech();
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_canal_breach_start");
	level.player maps\finale_utility::mech_enable(undefined,1);
	level.player thread maps\finale_code::threat_bias_canal_think();
	maps\_utility::vision_set_fog_changes("finale_underwater",0);
	level.player setclutforplayer("clut_finale_underwater",0);
	wait(0.05);
	level.player.inwater = 1;
	var_00 = getent("trigger_underwater","targetname");
	level.player thread maps\_water::playerinwater(var_00);
	level.gideon thread maps\_water::aiinwater(var_00);
	thread maps\finale_code::player_speed_control_underwater();
}

//Function Number: 22
canal_breach_logic()
{
}

//Function Number: 23
debug_silo_approach_start()
{
	soundscripts\_snd::snd_message("start_silo_approach");
	common_scripts\utility::flag_set("first_half_lighting");
	thread maps\finale_lighting::debug_silo_approach_clut();
	level.player lightsetforplayer("finale_silo_orange");
	maps\_utility::vision_set_fog_changes("finale_silo_orange",0);
	set_completed_flags();
	spawn_gideon_mech();
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_silo_approach_start");
	level.player maps\finale_utility::mech_enable(undefined,1);
	level.player thread maps\finale_code::threat_bias_silo_think();
	level.player thread maps\finale_utility::mech_glass_damage_think("flag_obj_escape");
	thread maps\finale_lighting::main_missle_lighting_silotop();
}

//Function Number: 24
silo_approach_logic()
{
}

//Function Number: 25
debug_silo_floor_03_start()
{
	soundscripts\_snd::snd_message("start_silo_floor_03");
	common_scripts\utility::flag_set("first_half_lighting");
	thread maps\finale_lighting::debug_silo_floor_03_clut();
	level.player lightsetforplayer("finale_silo_blue");
	maps\_utility::vision_set_fog_changes("finale_silo_blue",1);
	set_completed_flags();
	spawn_gideon_mech();
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_silo_floor_03");
	level.player maps\finale_utility::mech_enable(undefined,1);
	level.player thread maps\finale_code::threat_bias_silo_think();
	level.player thread maps\finale_utility::mech_glass_damage_think("flag_obj_escape");
	thread maps\finale_lighting::main_missle_lighting_floor3();
}

//Function Number: 26
silo_floor_03_logic()
{
	level.player thread maps\finale_utility::player_follow_volume_think();
	thread maps\finale_code::se_missile_load();
}

//Function Number: 27
debug_door_kick_start()
{
	soundscripts\_snd::snd_message("start_silo_floor_03");
	common_scripts\utility::flag_set("first_half_lighting");
	thread maps\finale_lighting::debug_silo_door_kick_clut();
	level.player lightsetforplayer("finale_silo_orange");
	maps\_utility::vision_set_fog_changes("finale_silo_orange",0);
	set_completed_flags();
	spawn_gideon_mech();
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_silo_door_kick");
	level.player maps\finale_utility::mech_enable(undefined,1);
	level.player thread maps\finale_utility::mech_glass_damage_think("flag_obj_escape");
}

//Function Number: 28
silo_door_kick_logic()
{
	soundscripts\_snd::snd_message("start_door_kick");
	maps\finale_code::se_door_kick();
}

//Function Number: 29
debug_silo_exhaust_entrance_start()
{
	soundscripts\_snd::snd_message("start_silo_exhaust_entrance");
	common_scripts\utility::flag_set("first_half_lighting");
	level.player lightsetforplayer("finale_silo_blue");
	maps\_utility::vision_set_fog_changes("finale_silo_blue",0);
	thread maps\finale_lighting::debug_silo_exhaust_entrance_clut();
	set_completed_flags();
	spawn_gideon_mech();
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_silo_exhaust_entrance");
	level.player maps\finale_utility::mech_enable(undefined,1);
}

//Function Number: 30
silo_exhaust_entrance_logic()
{
	thread maps\finale_code::se_exhaust_hatch();
	thread maps\finale_code::se_exhaust_land();
	maps\finale_code::player_exhaust_corridor();
	maps\finale_code::se_mech_exit();
}

//Function Number: 31
debug_lobby_start()
{
	soundscripts\_snd::snd_message("start_lobby");
	common_scripts\utility::flag_set("second_half_lighting");
	level.player lightsetforplayer("finale_lobby_2");
	maps\_utility::vision_set_fog_changes("finale_lobby",0);
	set_completed_flags();
	spawn_gideon();
	setsaveddvar("g_friendlyNameDist",0);
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
}

//Function Number: 32
silo_lobby_logic()
{
	if(level.currentgen)
	{
		common_scripts\utility::flag_set("load_outro_transient");
		common_scripts\utility::flag_wait("outro_loaded_successfully");
	}

	maps\finale_code::lobby_protect();
}

//Function Number: 33
debug_sky_bridge_start()
{
	soundscripts\_snd::snd_message("start_sky_bridge");
	common_scripts\utility::flag_set("second_half_lighting");
	level.player lightsetforplayer("finale_lobby");
	maps\_utility::vision_set_fog_changes("finale_sky_bridge",0);
	set_completed_flags();
	spawn_gideon();
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
	setsaveddvar("g_friendlyNameDist",0);
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_sky_bridge");
}

//Function Number: 34
silo_sky_bridge_logic()
{
	maps\finale_code::player_carried_skybridge();
}

//Function Number: 35
debug_will_room_start()
{
	soundscripts\_snd::snd_message("start_will_room");
	common_scripts\utility::flag_set("second_half_lighting");
	level.player lightsetforplayer("finale_will");
	maps\_utility::vision_set_fog_changes("finale_cinematic_nofog",0);
	level.player setclutforplayer("clut_finale_irons",0);
	set_completed_flags();
	spawn_gideon();
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
	setsaveddvar("g_friendlyNameDist",0);
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_will_room_start");
}

//Function Number: 36
will_room_logic()
{
	maps\finale_code::se_irons_reveal();
}

//Function Number: 37
debug_irons_chase()
{
	soundscripts\_snd::snd_message("start_roof");
	common_scripts\utility::flag_set("second_half_lighting");
	level.player lightsetforplayer("finale_night");
	maps\_utility::vision_set_fog_changes("finale_roof",0);
	level.player setclutforplayer("clut_finale_roof",0);
	thread maps\finale_lighting::light_strip_checkpoint();
	set_completed_flags();
	spawn_gideon();
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
	level.gideon maps\_utility::enable_cqbwalk();
	setsaveddvar("ai_friendlyFireBlockDuration",0);
	setsaveddvar("g_friendlyNameDist",0);
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_chase_start");
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	thread maps\finale_lighting::setup_final_lighting();
	setsaveddvar("player_sprintSpeedScale",1.6);
	level.player setviewmodel("viewhands_noexo_mitchell_prosthetic_smashed");
}

//Function Number: 38
irons_chase_logic()
{
	soundscripts\_snd::snd_message("start_irons_chase");
	maps\finale_code::se_irons_chase();
}

//Function Number: 39
debug_roof_start()
{
	soundscripts\_snd::snd_message("start_roof");
	common_scripts\utility::flag_set("second_half_lighting");
	maps\_utility::vision_set_fog_changes("finale_roof",0);
	level.player setclutforplayer("clut_finale_roof",0);
	level.player lightsetforplayer("finale_will_litend");
	set_completed_flags();
	spawn_gideon();
	thread maps\finale_code::setup_combat();
	thread maps\finale_code::setup_se();
	thread obj_init();
	level.gideon maps\_utility::enable_cqbwalk();
	setsaveddvar("ai_friendlyFireBlockDuration",0);
	setsaveddvar("g_friendlyNameDist",0);
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_roof_start");
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	level.player allowmelee(0);
	thread maps\finale_lighting::setup_final_lighting();
	setsaveddvar("player_sprintSpeedScale",1.6);
	level.player setviewmodel("viewhands_noexo_mitchell_prosthetic_smashed");
	while(!isdefined(level.irons))
	{
		wait 0.05;
	}

	if(!common_scripts\utility::flag("flag_player_speed_control_on"))
	{
		thread maps\finale_utility::player_chase_speed_control();
	}
}

//Function Number: 40
roof_logic()
{
	thread maps\finale_code::se_bridge_takedown();
	maps\finale_code::se_balcony_finale();
}

//Function Number: 41
lightingstate()
{
	var_00 = getent("tube_off","targetname");
	var_00 hide();
}

//Function Number: 42
obj_enter_atlas_silo()
{
	common_scripts\utility::flag_wait("flag_intro_screen_complete");
	objective_add(1,"current",&"FINALE_OBJ_REACH_ATLAS");
	var_00 = getent("obj_canal_breach","targetname");
	common_scripts\utility::flag_wait("flag_intro_flyin_release");
	level.player setclutforplayer("",2);
	objective_position(1,var_00.origin);
	common_scripts\utility::flag_wait("flag_obj_enter_silo_update");
	objective_onentity(1,level.gideon);
	common_scripts\utility::flag_wait("flag_obj_enter_silo_complete");
	common_scripts\utility::flag_set("flag_dialogue_canal_breach_complete");
	maps\_utility::objective_complete(1);
}

//Function Number: 43
obj_stop_missile_launch()
{
	thread maps\finale_lighting::rocket_success_lighting_pre_cine();
	objective_add(2,"current",&"FINALE_OBJ_STOP_LAUNCH");
	objective_onentity(2,level.gideon);
	common_scripts\utility::flag_wait("flag_obj_exhaust_hatch_position");
	var_00 = getent("org_obj_exhaust_hatch","targetname");
	var_01 = getent("trig_exhaust_hatch","targetname");
	objective_position(2,var_00.origin);
	common_scripts\utility::flag_wait("flag_obj_exhaust_hatch_open");
	if(level.player usinggamepad())
	{
		var_01 sethintstring(&"FINALE_PISTON_HINT");
	}
	else
	{
		var_01 sethintstring(&"FINALE_PISTON_HINT_PC");
	}

	var_02 = var_01 maps\_shg_utility::hint_button_trigger("x");
	common_scripts\utility::flag_wait("flag_exhaust_hatch_grab");
	var_01 sethintstring("");
	var_02 maps\_shg_utility::hint_button_clear();
	objective_position(2,(0,0,0));
	common_scripts\utility::flag_wait("flag_exhaust_hatch_open");
	objective_onentity(2,level.gideon);
	common_scripts\utility::flag_wait("flag_missile_launch_stop");
	var_03 = getent("org_missile","targetname");
	objective_position(2,var_03.origin);
	objective_setpointertextoverride(2,&"FINALE_OBJECTIVE_DESTROY");
	common_scripts\utility::flag_wait("flag_obj_stop_missile_launch_complete");
	maps\_utility::objective_complete(2);
}

//Function Number: 44
obj_escape()
{
	common_scripts\utility::flag_wait("flag_obj_escape");
	objective_add(3,"current",&"FINALE_OBJ_ESCAPE");
	objective_position(3,(0,0,0));
	common_scripts\utility::flag_wait("flag_obj_escape_complete");
	maps\_utility::objective_complete(3);
}

//Function Number: 45
obj_irons()
{
	common_scripts\utility::flag_wait("flag_obj_escape_complete");
	objective_add(4,"current",&"FINALE_OBJ_IRONS");
	common_scripts\utility::flag_wait("flag_obj_irons_complete");
	maps\_utility::objective_complete(4);
}

//Function Number: 46
ending_on_off_think()
{
	var_00 = 0;
	var_01 = 5;
	for(;;)
	{
		if(self buttonpressed("BUTTON_Y"))
		{
			var_00 = var_00 + 0.05;
			wait(0.05);
		}
		else
		{
			var_00 = 0;
			wait(0.05);
		}

		if(var_00 >= var_01)
		{
			iprintlnbold("Ending Off");
			self playsound("wpn_exo_launcher_raise_plr_mech");
			break;
		}
	}

	wait(0.05);
}