/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 129
 * Decompile Time: 1853 ms
 * Timestamp: 4/22/2024 2:29:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	config_system();
	init_snd_flags();
	init_globals();
	launch_threads();
	launch_loops();
	create_level_envelop_arrays();
	precache_presets();
	register_snd_messages();
	init_notetracks();
}

//Function Number: 2
register_snd_messages()
{
	soundscripts\_snd::snd_register_message("snd_zone_handler",::zone_handler);
	soundscripts\_snd::snd_register_message("snd_music_handler",::music_handler);
	soundscripts\_snd::snd_register_message("enter_water_override",::enter_water_override);
	soundscripts\_snd::snd_register_message("exit_water_override",::exit_water_override);
	soundscripts\_snd::snd_register_message("start_intro",::start_intro);
	soundscripts\_snd::snd_register_message("start_intro_skip",::start_intro_skip);
	soundscripts\_snd::snd_register_message("start_canal",::start_canal);
	soundscripts\_snd::snd_register_message("start_silo_approach",::start_silo_approach);
	soundscripts\_snd::snd_register_message("start_silo_floor_03",::start_silo_floor_03);
	soundscripts\_snd::snd_register_message("start_door_kick",::start_door_kick);
	soundscripts\_snd::snd_register_message("start_silo_exhaust_entrance",::start_silo_exhaust_entrance);
	soundscripts\_snd::snd_register_message("start_lobby",::start_lobby);
	soundscripts\_snd::snd_register_message("start_sky_bridge",::start_sky_bridge);
	soundscripts\_snd::snd_register_message("start_will_room",::start_will_room);
	soundscripts\_snd::snd_register_message("start_irons_chase",::start_irons_chase);
	soundscripts\_snd::snd_register_message("start_roof",::start_roof);
	soundscripts\_snd::snd_register_message("fin_flyin_start",::fin_flyin_start);
	soundscripts\_snd::snd_register_message("fin_flyin_drop",::fin_flyin_drop);
	soundscripts\_snd::snd_register_message("fin_flyin_splash",::fin_flyin_splash);
	soundscripts\_snd::snd_register_message("fin_flyin_gideon_splash",::fin_flyin_gideon_splash);
	soundscripts\_snd::snd_register_message("find_npc_dive_boat_handler",::find_npc_dive_boat_handler);
	soundscripts\_snd::snd_register_message("fin_midair_exp_audio",::fin_midair_exp_audio);
	soundscripts\_snd::snd_register_message("fin_bldg_exp_audio",::fin_bldg_exp_audio);
	soundscripts\_snd::snd_register_message("fin_water_exp_audio",::fin_water_exp_audio);
	soundscripts\_snd::snd_register_message("fin_glass_exp_audio",::fin_glass_exp_audio);
	soundscripts\_snd::snd_register_message("vrap_explode",::vrap_explode);
	soundscripts\_snd::snd_register_message("fin_bullet_trails",::fin_bullet_trails);
	soundscripts\_snd::snd_register_message("fin_gid_exit_water",::fin_gid_exit_water);
	soundscripts\_snd::snd_register_message("silo_door_kick",::silo_door_kick);
	soundscripts\_snd::snd_register_message("shaft_descent_start",::shaft_descent_start);
	soundscripts\_snd::snd_register_message("shaft_descent_state_change",::shaft_descent_state_change);
	soundscripts\_snd::snd_register_message("shaft_descent_speed_update",::shaft_descent_speed_update);
	soundscripts\_snd::snd_register_message("shaft_descent_end",::shaft_descent_end);
	soundscripts\_snd::snd_register_message("exhaust_shaft_land",::exhaust_shaft_land);
	soundscripts\_snd::snd_register_message("exhaust_shaft_land_gideon",::exhaust_shaft_land_gideon);
	soundscripts\_snd::snd_register_message("aud_rocket_launch_start",::aud_rocket_launch_start);
	soundscripts\_snd::snd_register_message("aud_fin_rocket_damage_vfx",::aud_fin_rocket_damage_vfx);
	soundscripts\_snd::snd_register_message("fin_silo_success",::fin_silo_success);
	soundscripts\_snd::snd_register_message("missile_small_thrusters_off",::missile_small_thrusters_off);
	soundscripts\_snd::snd_register_message("missile_large_thrusters_off",::missile_large_thrusters_off);
	soundscripts\_snd::snd_register_message("gid_release_plr_mech_suit",::gid_release_plr_mech_suit);
	soundscripts\_snd::snd_register_message("fin_lobby_gun_limp",::fin_lobby_gun_limp);
	soundscripts\_snd::snd_register_message("aud_irons_says_hello",::aud_irons_says_hello);
	soundscripts\_snd::snd_register_message("aud_irons_reveal_star_trek_door",::aud_irons_reveal_star_trek_door);
	soundscripts\_snd::snd_register_message("aud_irons_reveal_bomb_shake",::aud_irons_reveal_bomb_shake);
	soundscripts\_snd::snd_register_message("fin_irons_reveal_mash_start",::fin_irons_reveal_mash_start);
	soundscripts\_snd::snd_register_message("fin_irons_reveal_mash",::fin_irons_reveal_mash);
	soundscripts\_snd::snd_register_message("fin_irons_reveal_mash_finish",::fin_irons_reveal_mash_finish);
	soundscripts\_snd::snd_register_message("aud_irons_reveal_bomb_shake_02",::aud_irons_reveal_bomb_shake_02);
	soundscripts\_snd::snd_register_message("irons_reveal_exit_door_open",::irons_reveal_exit_door_open);
	soundscripts\_snd::snd_register_message("irons_keypad_door_open",::irons_keypad_door_open);
	soundscripts\_snd::snd_register_message("irons_chase_door_close",::irons_chase_door_close);
	soundscripts\_snd::snd_register_message("fin_skybridge_takedown_start",::fin_skybridge_takedown_start);
	soundscripts\_snd::snd_register_message("fin_skybridge_slo_mo_start",::fin_skybridge_slo_mo_start);
	soundscripts\_snd::snd_register_message("fin_skybridge_slo_mo_stop",::fin_skybridge_slo_mo_stop);
	soundscripts\_snd::snd_register_message("fin_skybridge_glass_explo",::fin_skybridge_glass_explo);
	soundscripts\_snd::snd_register_message("fin_irons_takedown_start",::fin_irons_takedown_start);
	soundscripts\_snd::snd_register_message("fin_irons_tackle",::fin_irons_tackle);
	soundscripts\_snd::snd_register_message("fin_ending_slo_mo_override",::fin_ending_slo_mo_override);
	soundscripts\_snd::snd_register_message("bridge_takedown_success",::bridge_takedown_success);
	soundscripts\_snd::snd_register_message("bridge_takedown_fail",::bridge_takedown_fail);
	soundscripts\_snd::snd_register_message("finale_qte_show_knife",::finale_qte_show_knife);
	soundscripts\_snd::snd_register_message("finale_ending_qte1_success",::finale_ending_qte1_success);
	soundscripts\_snd::snd_register_message("finale_ending_qte1_timeout",::finale_ending_qte1_timeout);
	soundscripts\_snd::snd_register_message("finale_ending_buttonmash_start",::finale_ending_buttonmash_start);
	soundscripts\_snd::snd_register_message("finale_ending_buttonmash_fail",::finale_ending_buttonmash_fail);
	soundscripts\_snd::snd_register_message("finale_ending_qte2_success",::finale_ending_qte2_success);
	soundscripts\_snd::snd_register_message("finale_ending_qte2_timeout",::finale_ending_qte2_timeout);
}

//Function Number: 3
init_notetracks()
{
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_fin_gideon_hatch_grab",::slate_fin_gideon_hatch_grab,"exhaust_hatch_enter");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_finale_gideon_hatch_pull_1",::slate_finale_gideon_hatch_pull_1,"exhaust_hatch_idle_noloop");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_finale_gideon_hatch_regrip_1",::slate_finale_gideon_hatch_regrip_1,"exhaust_hatch_idle_noloop");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_finale_gideon_hatch_pull_2",::slate_finale_gideon_hatch_pull_2,"exhaust_hatch_idle_noloop");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_finale_gideon_hatch_regrip_2",::slate_finale_gideon_hatch_regrip_2,"exhaust_hatch_idle_noloop");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_finale_gideon_hatch_pull_3",::slate_finale_gideon_hatch_pull_3,"exhaust_hatch_idle_noloop");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_finale_gideon_hatch_regrip_3",::slate_finale_gideon_hatch_regrip_3,"exhaust_hatch_idle_noloop");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_gideon_wave_hand_raise",::slate_gideon_wave_hand_raise,"exhaust_hatch_idle_wave_noloop");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_gideon_wave_hand_plant",::slate_gideon_wave_hand_plant,"exhaust_hatch_idle_wave_noloop");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_gideon_wave_hand_regrip",::slate_gideon_wave_hand_regrip,"exhaust_hatch_idle_wave_noloop");
	maps\_anim::addnotetrack_customfunction("world_body_mech","slate_fin_vm_hatch_grab",::slate_fin_vm_hatch_grab,"exhaust_hatch_vm_approach");
	maps\_anim::addnotetrack_customfunction("world_body_mech","slate_fin_vm_hatch_pull",::slate_fin_vm_hatch_pull,"exhaust_hatch_vm_noinput_to_input");
	maps\_anim::addnotetrack_customfunction("world_body_mech","slate_fin_vm_hatch_pull_loop",::slate_fin_vm_hatch_pull_loop,"exhaust_hatch_vm_idle_input");
	maps\_anim::addnotetrack_customfunction("world_body_mech","slate_fin_vm_pull_relax",::slate_fin_vm_pull_relax,"exhaust_hatch_vm_input_to_noinput");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_fin_gideon_bar_break",::slate_fin_gideon_bar_break,"exhaust_hatch_open");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_fin_vm_bar_break",::slate_fin_vm_bar_break,"exhaust_hatch_open");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_fin_gideon_hatch_open",::slate_fin_gideon_hatch_open,"exhaust_hatch_open");
	maps\_anim::addnotetrack_customfunction("gideon_mech","slate_fin_gideon_hatch_push",::slate_fin_gideon_hatch_push,"exhaust_hatch_open");
	maps\_anim::addnotetrack_customfunction("piston_r","slate_fin_piston_r_break",::slate_fin_piston_r_break,"exhaust_hatch_open");
	maps\_anim::addnotetrack_customfunction("piston_l","slate_fin_piston_l_break",::slate_fin_piston_l_break,"exhaust_hatch_open");
	maps\_anim::addnotetrack_customfunction("missile_main","fin_silo_fail_launch",::fin_silo_fail_launch,"missile_launch");
	maps\_anim::addnotetrack_customfunction("gideon","fin_post_silo_gid_foley",::fin_post_silo_gid_foley,"mech_exit");
	maps\_anim::addnotetrack_customfunction("gideon","fin_post_silo_switch_to_plr",::fin_post_silo_switch_to_plr,"mech_exit");
	maps\_anim::addnotetrack_customfunction("gideon","fin_gid_carry_pickup_1",::fin_gid_carry_pickup_1,"drag_pickup01");
	maps\_anim::addnotetrack_customfunction("plr","fin_silo_plr_picked_up",::fin_silo_plr_picked_up,"drag_pickup01");
	maps\_anim::addnotetrack_customfunction("gideon","fin_gid_carry_plr_1",::fin_gid_carry_plr_1,"drag_run01");
	maps\_anim::addnotetrack_customfunction("gideon","fin_gid_carry_plr_2",::fin_gid_carry_plr_2,"drag_run02");
	maps\_anim::addnotetrack_customfunction("world_body_damaged","fin_gid_plr_putdown",::fin_gid_plr_putdown,"drag_putdown");
	maps\_anim::addnotetrack_customfunction("gideon","fin_gid_carry_pickup_2",::fin_gid_carry_pickup_2,"drag_pickup02");
	maps\_anim::addnotetrack_customfunction("gideon","fin_gid_carry_plr_3",::fin_gid_carry_plr_3,"drag_run03");
	maps\_anim::addnotetrack_customfunction("gideon","fin_gid_carry_plr_4",::fin_gid_carry_plr_4,"drag_run04");
	maps\_anim::addnotetrack_customfunction("world_body_damaged","fin_irons_reveal_plr_start",::fin_irons_reveal_plr_start,"irons_reveal");
	maps\_anim::addnotetrack_customfunction("world_body_damaged","fin_irons_reveal_plr_stand",::fin_irons_reveal_plr_stand,"irons_reveal");
	maps\_anim::addnotetrack_customfunction("irons","fin_irons_reveal_irons_start",::fin_irons_reveal_irons_start,"irons_reveal");
	maps\_anim::addnotetrack_customfunction("irons","fin_irons_reveal_irons_takes_gun",::fin_irons_reveal_irons_takes_gun,"irons_reveal");
	maps\_anim::addnotetrack_customfunction("irons","fin_irons_reveal_irons_quake",::fin_irons_reveal_irons_quake,"irons_reveal");
	maps\_anim::addnotetrack_customfunction("irons","fin_irons_reveal_irons_points_gun",::fin_irons_reveal_irons_points_gun,"irons_reveal");
	maps\_anim::addnotetrack_customfunction("irons","fin_irons_reveal_gun_away_exit",::fin_irons_reveal_gun_away_exit,"irons_reveal");
	maps\_anim::addnotetrack_customfunction("gideon","fin_reveal_gid_drops_plr",::fin_reveal_gid_drops_plr,"irons_reveal");
	maps\_anim::addnotetrack_customfunction("gideon","fin_irons_reveal_scene_gid_start",::fin_irons_reveal_scene_gid_start,"irons_reveal");
	maps\_anim::addnotetrack_customfunction("gideon","fin_irons_reveal_scene_gid_exo_freeze",::fin_irons_reveal_scene_gid_exo_freeze,"irons_reveal");
	maps\_anim::addnotetrack_customfunction("world_body_damaged_no_exo","fin_ending_qte_stab",::fin_ending_qte_stab,"balcony_finale_pt5");
	maps\_anim::addnotetrack_customfunction("world_body_damaged_no_exo","fin_ending_knife_drop",::fin_ending_knife_drop,"balcony_finale_pt5");
	maps\_anim::addnotetrack_customfunction("world_body_damaged_no_exo","fin_ending_plr_foley_1",::fin_ending_plr_foley_1,"balcony_finale_end");
	maps\_anim::addnotetrack_customfunction("world_body_damaged_no_exo","fin_ending_plr_foley_2",::fin_ending_plr_foley_2,"balcony_finale_end");
	maps\_anim::addnotetrack_customfunction("gideon","fin_ending_gideon_foley_1",::fin_ending_gideon_foley_1,"balcony_finale_end");
	maps\_anim::addnotetrack_customfunction("gideon","fin_ending_gideon_foley_2",::fin_ending_gideon_foley_2,"balcony_finale_end");
}

//Function Number: 4
config_system()
{
	soundscripts\_audio::set_stringtable_mapname("shg");
	soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
	soundscripts\_audio_mix_manager::mm_add_submix("finale_global_mix");
	soundscripts\_audio_mix_manager::mm_add_submix("temp_vo_premix");
}

//Function Number: 5
init_snd_flags()
{
}

//Function Number: 6
init_globals()
{
	level.aud.water = spawnstruct();
	level.aud.water.enter_water_override = "enter_water_override";
	level.aud.water.exit_water_override = "exit_water_override";
	level.aud.underwater = 0;
}

//Function Number: 7
launch_threads()
{
	if(soundscripts\_audio::aud_is_specops())
	{
		return;
	}

	thread aud_rocket_stage_01_start();
}

//Function Number: 8
launch_loops()
{
}

//Function Number: 9
create_level_envelop_arrays()
{
	level.aud.envs = [];
	level.aud.envs["speed_to_volume"] = [[0,0.1],[200,0.2],[400,0.5],[600,0.75],[800,0.8],[1000,0.9],[1100,1]];
}

//Function Number: 10
precache_presets()
{
}

//Function Number: 11
zone_handler(param_00,param_01)
{
	switch(param_00)
	{
	}
}

//Function Number: 12
music(param_00,param_01)
{
	thread music_handler(param_00,param_01);
}

//Function Number: 13
music_handler(param_00,param_01)
{
	switch(param_00)
	{
		case "mitchell_vo_intro":
			soundscripts\_audio::aud_set_music_submix(0.9,0);
			soundscripts\_audio_music::mus_play("mus_mitchell_vo_intro",0);
			break;

		case "game_play_begin":
			soundscripts\_audio::aud_set_music_submix(0.85,0);
			soundscripts\_audio_music::mus_play("mus_game_play_begin",0);
			break;

		case "weapons_free":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_weapons_free",3);
			break;

		case "underwater_begin":
			soundscripts\_audio_music::mus_stop(0.5);
			break;

		case "underwater_end":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_underwater_end",0);
			break;

		case "post_underwater_combat_begin":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_weapons_free",3);
			break;

		case "post_underwater_combat_end":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_post_underwater_combat_end",0,1);
			break;

		case "timer_begin":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_timer_begin",0,6);
			break;

		case "ast_combat_begin":
			soundscripts\_audio::aud_set_music_submix(1,0);
			level.aud.ast_mus_on = 0;
			for(;;)
			{
				var_02 = soundscripts\_snd_common::snd_get_num_enemies_aware();
				if(var_02 && !level.aud.ast_mus_on)
				{
					soundscripts\_audio_music::mus_play("mus_ast_combat_begin",1,2);
					level.aud.ast_mus_on = 1;
				}
				else if(!var_02 && level.aud.ast_mus_on)
				{
					soundscripts\_audio_music::mus_play("mus_ast_combat_end",0,1);
					level.aud.ast_mus_on = 0;
				}
	
				wait(1);
			}
			break;

		case "ast_combat_end":
			if(!isdefined(level.aud.ast_mus_on))
			{
				level.aud.ast_mus_on = 0;
			}
	
			if(level.aud.ast_mus_on)
			{
				soundscripts\_audio_music::mus_play("mus_ast_combat_end",0,1);
			}
			else
			{
				soundscripts\_audio_music::mus_stop(3);
			}
			break;

		case "post_door_kick":
			soundscripts\_audio::aud_set_music_submix(0,0);
			wait(0.1);
			soundscripts\_audio_music::mus_play("mus_post_door_kick",3);
			soundscripts\_audio::aud_set_music_submix(0.25,10);
			break;

		case "hatch_scene_begin":
			soundscripts\_audio::aud_set_music_submix(0.25,0);
			soundscripts\_audio_music::mus_play("mus_hatch_scene_begin",3);
			break;

		case "hatch_jump_begin":
			soundscripts\_audio_music::mus_stop(5);
			break;

		case "hatch_jump_end":
			soundscripts\_audio::aud_set_music_submix(1,0);
			wait(0.5);
			soundscripts\_audio_music::mus_play("mus_hatch_jump_end",0);
			break;

		case "missile_disabled":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_dazed_and_confused2",0);
			break;

		case "mitchellhangon":
			soundscripts\_audio_music::mus_stop(5);
			break;

		case "dazed_and_confused1":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_dazed_and_confused1",0);
			break;

		case "lobby_combat_begin":
			soundscripts\_audio_music::mus_play("mus_hatch_scene_begin",4);
			break;

		case "dazed_and_confused2":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_dazed_and_confused2",3);
			break;

		case "gideon_sets_mitchell_down":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_gideon_sets_mitchell_down",3);
			break;

		case "fin_irs_hellomitchell":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_irons_enters",4);
			wait(35);
			soundscripts\_audio_music::mus_play("mus_gideon_sets_mitchell_down",3);
			level waittill("sounddone_fin_gdn_theresnotime");
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_irons_chase_being",3);
			break;

		case "irons_chase_being_checkpoint":
			soundscripts\_audio::aud_set_music_submix(1,0);
			soundscripts\_audio_music::mus_play("mus_irons_chase_being",3);
			break;

		case "irons_tackle":
			soundscripts\_audio::aud_set_music_submix(0.4,7);
			level waittill("sounddone_fin_irs_aaahhhhmitchell");
			soundscripts\_audio::aud_set_music_submix(1,2);
			soundscripts\_audio_music::mus_play("mus_finale_finale",0,2);
			level waittill("sounddone_fin_gdn_ivegotyamate");
			wait(3);
			soundscripts\_audio_mix_manager::mm_add_submix("finale_finale",45);
			soundscripts\_audio_mix_manager::mm_clear_submix("temp_vo_premix",5);
			break;

		default:
			soundscripts\_audio::aud_print_warning("\tMUSIC MESSAGE NOT HANDLED: " + param_00);
			break;
	}
}

//Function Number: 14
enter_water_override()
{
	level.aud.underwater = 1;
	soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
	soundscripts\_snd_filters::snd_fade_in_filter("underwater",0.05);
	soundscripts\_audio_mix_manager::mm_add_submix("underwater");
	soundscripts\_audio_mix_manager::mm_add_submix("fin_underwater");
	soundscripts\_snd_common::snd_enable_soundcontextoverride("underwater");
	soundscripts\_snd_playsound::snd_play_2d("bet_swim_plr_submerge");
	soundscripts\_snd_playsound::snd_play_loop_2d("underwater_main_lp","kill_underwater_loop");
	soundscripts\_snd_playsound::snd_play_loop_2d("fin_mech_respirator","kill_underwater_loop",undefined,1);
	level.gideon soundscripts\_snd_playsound::snd_play_loop_linked("underwater_bubble_lp_sm_01","kill_underwater_loop",undefined,undefined,0.5);
	music("underwater_begin");
}

//Function Number: 15
exit_water_override()
{
	level.aud.underwater = 0;
	level notify("kill_underwater_loop");
	soundscripts\_snd_filters::snd_fade_out_filter(0.05);
	soundscripts\_audio_mix_manager::mm_clear_submix("underwater");
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_underwater");
	soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
	soundscripts\_snd_common::snd_disable_soundcontextoverride("underwater");
	soundscripts\_audio_mix_manager::mm_add_submix("fin_mech_exit_water");
	soundscripts\_snd_playsound::snd_play_2d("fin_mech_exit_water");
	wait(2);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_mech_exit_water");
	music("underwater_end");
}

//Function Number: 16
start_intro()
{
	soundscripts\_audio_mix_manager::mm_add_submix("fin_intro");
}

//Function Number: 17
start_intro_skip()
{
	music("game_play_begin");
}

//Function Number: 18
start_canal()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_intro");
	music("weapons_free");
}

//Function Number: 19
start_silo_approach()
{
	music("underwater_end");
	soundscripts\_audio_zone_manager::azm_start_zone("int_silo_med");
}

//Function Number: 20
start_silo_floor_03()
{
	music("post_underwater_combat_begin");
	soundscripts\_audio_zone_manager::azm_start_zone("int_silo_med");
}

//Function Number: 21
start_door_kick()
{
	soundscripts\_audio_zone_manager::azm_start_zone("int_silo_large");
}

//Function Number: 22
start_silo_exhaust_entrance()
{
	music("hatch_scene_begin");
	soundscripts\_audio_zone_manager::azm_start_zone("int_silo_tunnel");
}

//Function Number: 23
start_lobby()
{
	music("lobby_combat_begin");
}

//Function Number: 24
start_sky_bridge()
{
}

//Function Number: 25
start_will_room()
{
	music("gideon_sets_mitchell_down");
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_black_out_seq");
	thread irons_reveal_scene();
}

//Function Number: 26
start_irons_chase()
{
	music("irons_chase_being_checkpoint");
}

//Function Number: 27
start_roof()
{
	music("irons_chase_being_checkpoint");
}

//Function Number: 28
fin_midair_exp_audio(param_00)
{
	soundscripts\_snd_playsound::snd_play_at("exp_amb_mid_air",param_00);
}

//Function Number: 29
fin_bldg_exp_audio(param_00)
{
}

//Function Number: 30
fin_water_exp_audio(param_00)
{
}

//Function Number: 31
fin_glass_exp_audio(param_00)
{
}

//Function Number: 32
fin_flyin_start()
{
	soundscripts\_snd::snd_slate("fin_flyin_start");
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_intro_flight_jets_fronts",0.1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_intro_flight_littlebird_path");
	level waittill("aud_intro_flight_arrive_hover");
	soundscripts\_snd_playsound::snd_play_delayed_loop_2d("fin_intro_flight_littlebird_lp",14.5,1,"fin_intro_flight_helicopter_stop",3,3);
}

//Function Number: 33
fin_flyin_drop()
{
	soundscripts\_snd::snd_slate("fin_flyin_drop");
	soundscripts\_snd_playsound::snd_play_2d("fin_mech_release_chain");
	level notify("fin_intro_flight_helicopter_stop");
}

//Function Number: 34
fin_flyin_splash()
{
	soundscripts\_snd::snd_slate("fin_flyin_splash");
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_water_player_pre_splash",0.01,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_water_player_splash_fronts",0.1,1);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_water_player_hit_underwater",0.2,1);
}

//Function Number: 35
fin_flyin_gideon_splash()
{
	soundscripts\_snd_playsound::snd_play_2d("fin_water_gideon_hit_underwater");
}

//Function Number: 36
find_npc_dive_boat_handler()
{
	var_00 = "fin_npc_boats_flyby";
	var_01 = [];
	var_01[0] = 800;
	var_02 = [];
	var_02[0] = 20;
	var_02[1] = 5;
	thread soundscripts\_snd_common::snd_advanced_flyby_system(var_00,undefined,var_01,var_02,1,undefined,undefined,3,2);
}

//Function Number: 37
vrap_explode()
{
	self waittill("explode");
	self playsound("fin_vrap_explo");
	var_00 = spawnstruct();
	var_00.explo_shot_array_ = [["rocket_explode_metal",0],["rocket_explode_paintedmetal",0]];
	var_00.pos = self.origin;
	var_00.explo_delay_chance_ = 100;
	var_00.shake_dist_threshold_ = 1500;
	var_00.ground_zero_dist_threshold_ = 500;
	soundscripts\_snd_common::snd_ambient_explosion(var_00);
}

//Function Number: 38
fin_bullet_trails(param_00)
{
	if(level.aud.underwater == 1)
	{
		var_01 = soundscripts\_audio::aud_find_exploder(param_00);
		if(isdefined(var_01))
		{
			var_02 = var_01.v["origin"];
			soundscripts\_snd_playsound::snd_play_at("fin_canal_bullet_trail",var_02);
		}
	}
}

//Function Number: 39
fin_gid_exit_water()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("fin_gideon_mech_exit_water");
}

//Function Number: 40
slate_fin_gideon_hatch_grab(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("fin_mech_hatch_rips");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_grab",0);
}

//Function Number: 41
slate_finale_gideon_hatch_pull_1(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_pull_01",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_pull_pipe_01",0);
}

//Function Number: 42
slate_finale_gideon_hatch_regrip_1(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_regrip_01",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_regrip_01_lfe",0);
}

//Function Number: 43
slate_finale_gideon_hatch_pull_2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_pull_02",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_pull_pipe_02",0);
}

//Function Number: 44
slate_finale_gideon_hatch_regrip_2(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_regrip_02",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_regrip_02_lfe",0);
}

//Function Number: 45
slate_finale_gideon_hatch_pull_3(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_pull_03",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_pull_pipe_03",0);
}

//Function Number: 46
slate_finale_gideon_hatch_regrip_3(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_nag_hplant",0);
}

//Function Number: 47
slate_gideon_wave_hand_raise(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_nag_hraise",0);
}

//Function Number: 48
slate_gideon_wave_hand_plant(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_hatch_nag_hplant",0);
}

//Function Number: 49
slate_gideon_wave_hand_regrip(param_00)
{
}

//Function Number: 50
slate_fin_vm_hatch_grab(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_hatch_grab_pipe_high",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_hatch_grab_pops",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_hatch_grab_mech",0);
}

//Function Number: 51
slate_fin_vm_hatch_pull(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_hatch_pull_pipe_high",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_hatch_pull_pops",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_hatch_pull_mech",0);
}

//Function Number: 52
slate_fin_vm_hatch_pull_loop(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_loop_2d("fin_plr_hatch_strain_mech_lp",0,undefined,"stop_mech_strain_loop");
}

//Function Number: 53
slate_fin_vm_pull_relax(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_pull_relax_mech",0);
}

//Function Number: 54
slate_fin_gideon_bar_break(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_gideon_pipe_break",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_gideon_pipe_break_sweet",0);
}

//Function Number: 55
slate_fin_piston_r_break(param_00)
{
	level notify("stop_mech_strain_loop");
	wait(5);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_mech_hatch_rips");
}

//Function Number: 56
slate_fin_piston_l_break(param_00)
{
}

//Function Number: 57
slate_fin_vm_bar_break(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_pipe_bar_break",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_bar_break_mech",0);
}

//Function Number: 58
slate_fin_gideon_hatch_open(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_gideon_hatch_open",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_gideon_hatch_open_sweet",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_gideon_hatch_open_mech",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("mech_jump_plr",7.75);
}

//Function Number: 59
slate_fin_gideon_hatch_push(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_gideon_hatch_push",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_gideon_hatch_push_sweet",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_gideon_hatch_push_mech",0);
}

//Function Number: 60
shaft_descent_start()
{
	soundscripts\_audio_mix_manager::mm_add_submix("fin_shaft_descent");
	soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_free_fall","kill_free_fall",0.25);
	level.aud.wind_lp = soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_free_fall_speed_wind","kill_free_fall_wind");
}

//Function Number: 61
shaft_descent_state_change(param_00,param_01)
{
	var_02 = 0.05;
	var_03 = 0.2;
	if(param_00 == "shaft_no_hands" && param_01 == "shaft_right_hand")
	{
		soundscripts\_snd_playsound::snd_play_2d("fin_shaft_impact_right");
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_descent_right","kill_right_loop",var_02,var_03);
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_descent_lfe","kill_lfe_loop",var_02,var_03);
		level notify("kill_free_fall");
		return;
	}

	if(param_00 == "shaft_no_hands" && param_01 == "shaft_left_hand")
	{
		soundscripts\_snd_playsound::snd_play_2d("fin_shaft_impact_left");
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_descent_left","kill_left_loop",var_02,var_03);
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_descent_lfe","kill_lfe_loop",var_02,var_03);
		level notify("kill_free_fall");
		return;
	}

	if(param_00 == "shaft_left_hand" && param_01 == "shaft_no_hands")
	{
		soundscripts\_snd_playsound::snd_play_2d("fin_shaft_release_left");
		level notify("kill_left_loop");
		level notify("kill_lfe_loop");
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_free_fall","kill_free_fall",0.05,var_03);
		return;
	}

	if(param_00 == "shaft_right_hand" && param_01 == "shaft_no_hands")
	{
		soundscripts\_snd_playsound::snd_play_2d("fin_shaft_release_right");
		level notify("kill_right_loop");
		level notify("kill_lfe_loop");
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_free_fall","kill_free_fall",0.05,var_03);
		return;
	}

	if(param_00 == "shaft_right_hand" && param_01 == "shaft_both_hands")
	{
		soundscripts\_snd_playsound::snd_play_2d("fin_shaft_impact_left");
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_descent_left","kill_left_loop",var_02,var_03);
		return;
	}

	if(param_00 == "shaft_left_hand" && param_01 == "shaft_both_hands")
	{
		soundscripts\_snd_playsound::snd_play_2d("fin_shaft_impact_right");
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_descent_right","kill_right_loop",var_02,var_03);
		return;
	}

	if(param_00 == "shaft_no_hands" && param_01 == "shaft_both_hands")
	{
		soundscripts\_snd_playsound::snd_play_2d("fin_shaft_impact_right");
		soundscripts\_snd_playsound::snd_play_2d("fin_shaft_impact_left");
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_descent_left","kill_left_loop",var_02,var_03);
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_descent_right","kill_right_loop",var_02,var_03);
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_descent_lfe","kill_lfe_loop",var_02,var_03);
		level notify("kill_free_fall");
		return;
	}

	if(param_00 == "shaft_both_hands" && param_01 == "shaft_no_hands")
	{
		soundscripts\_snd_playsound::snd_play_2d("fin_shaft_release_right");
		soundscripts\_snd_playsound::snd_play_2d("fin_shaft_release_left");
		soundscripts\_snd_playsound::snd_play_loop_2d("fin_shaft_free_fall","kill_free_fall",0.05,var_03);
		level notify("kill_right_loop");
		level notify("kill_left_loop");
		level notify("kill_lfe_loop");
		return;
	}

	if(param_00 == "shaft_both_hands" && param_01 == "shaft_left_hand")
	{
		level notify("kill_right_loop");
		return;
	}

	if(param_00 == "shaft_both_hands" && param_01 == "shaft_right_hand")
	{
		level notify("kill_left_loop");
	}
}

//Function Number: 62
shaft_descent_speed_update(param_00)
{
	param_00 = abs(param_00);
	var_01 = soundscripts\_snd::snd_map(param_00,level.aud.envs["speed_to_volume"]);
	level.aud.wind_lp scalevolume(var_01,0.05);
}

//Function Number: 63
shaft_descent_end()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_shaft_descent");
	soundscripts\_snd::snd_slate("shaft_descent_end");
	level notify("kill_right_loop");
	level notify("kill_left_loop");
	level notify("kill_lfe_loop");
	wait(2);
	level notify("kill_free_fall");
	level notify("kill_free_fall_wind");
}

//Function Number: 64
silo_door_kick(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("fin_gideon_blast_door_kick");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_silo_door_kick_debris",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_silo_door_kick_mech",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_silo_door_kick_metal",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_silo_door_kick_thud",0);
	wait(6);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_gideon_blast_door_kick");
}

//Function Number: 65
exhaust_shaft_land()
{
	soundscripts\_audio_mix_manager::mm_add_submix("fin_mech_shaft_lands");
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_shaft_land_impact",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_shaft_land_mech",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_plr_shaft_land_sweet",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_shaft_land_vent",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_shaft_land_debris",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_shaft_land_debris_rain",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_shaft_land_wind",0);
	wait(10);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_mech_shaft_lands");
}

//Function Number: 66
exhaust_shaft_land_gideon(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_shaft_land_impact",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_shaft_land_mech",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_shaft_land_sweet",0);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_gideon_mech_shields_up",2.25);
	level.player soundscripts\_snd_playsound::snd_play_delayed_linked("fin_player_mech_shields_up",3);
	level notify("aud_begin_rocket_ignition");
}

//Function Number: 67
aud_rocket_stage_01_start()
{
	level waittill("aud_begin_rocket_ignition");
	soundscripts\_audio_mix_manager::mm_add_submix("fin_rocket_tunnel");
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_silo_rocket_ignition",7.5);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_silo_fire_blast",11.5);
	var_00 = 13.6;
	var_01 = 10;
	soundscripts\_snd_playsound::snd_play_delayed_loop_2d("fin_launch_stage_01_lp",var_00,undefined,"aud_stop_stage_01_loops",undefined,var_01);
	soundscripts\_snd_playsound::snd_play_delayed_loop_2d("fin_launch_stage_01_lp_lfe",var_00,undefined,"aud_stop_stage_01_loops",undefined,var_01);
	soundscripts\_snd_playsound::snd_play_delayed_loop_2d("fin_launch_stage_01_lp_rears",var_00,undefined,"aud_stop_stage_01_loops",undefined,var_01);
}

//Function Number: 68
aud_rocket_launch_start()
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_launch_stage_02_startup_whine",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_launch_stage_02_startup_thruster",3.1);
	var_00 = 0;
	var_01 = 5;
	var_02 = 2.5;
	soundscripts\_snd_playsound::snd_play_delayed_loop_2d("fin_launch_stage_02_lp",var_00,undefined,"aud_stop_stage_02_loops",var_01,var_02);
	soundscripts\_snd_playsound::snd_play_delayed_loop_2d("fin_launch_stage_02_lp_body",var_00,undefined,"aud_stop_stage_02_loops",var_01,var_02);
	soundscripts\_snd_playsound::snd_play_delayed_loop_2d("fin_launch_stage_02_lp_whine",var_00,undefined,"aud_stop_stage_02_loops",var_01,var_02);
	level notify("aud_stop_stage_01_loops");
}

//Function Number: 69
fin_silo_fail_launch(param_00)
{
	var_01 = 0.8;
	wait(var_01);
	level notify("aud_stop_stage_02_loops");
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_silo_launch_fail",0);
}

//Function Number: 70
fin_silo_success()
{
	soundscripts\_snd::snd_slate("fin_silo_success");
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_launch_win_turbine",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_launch_win_mech",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_launch_win_debris",0);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_launch_win_sparks",0);
	wait(0.5);
	level notify("aud_stop_stage_01_loops");
	level notify("aud_stop_stage_02_loops");
}

//Function Number: 71
aud_fin_rocket_damage_vfx()
{
	soundscripts\_audio_mix_manager::mm_add_submix("fin_rocket_win_explosion",0.05);
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_launch_win_thrust_off",0.05);
	wait(1);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_rocket_win_explosion",2);
}

//Function Number: 72
missile_small_thrusters_off()
{
	soundscripts\_snd::snd_slate("missile_small_thrusters_off");
}

//Function Number: 73
missile_large_thrusters_off()
{
	soundscripts\_snd::snd_slate("missile_large_thrusters_off");
}

//Function Number: 74
gid_release_plr_mech_suit()
{
	soundscripts\_snd::snd_slate("gid_release_plr_mech_suit");
	soundscripts\_snd_playsound::snd_play_delayed_2d("gid_release_plr_mech_suit",5.5);
}

//Function Number: 75
fin_post_silo_gid_foley(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("fin_post_launch_foley");
	soundscripts\_snd::snd_slate("post silo_gid foley");
	param_00 soundscripts\_snd_playsound::snd_play_linked("fin_post_launch_gid_foley");
	soundscripts\_snd_playsound::snd_play_2d("fin_post_launch_plr_breaths");
}

//Function Number: 76
fin_post_silo_switch_to_plr(param_00)
{
	soundscripts\_snd::snd_slate("switch_to_plr");
	soundscripts\_snd_playsound::snd_play_2d("fin_post_launch_plr_foley");
	wait(10);
	soundscripts\_audio_mix_manager::mm_add_submix("fin_black_out_seq",3);
	wait(2);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_post_launch_foley");
}

//Function Number: 77
fin_gid_carry_pickup_1(param_00)
{
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_rocket_tunnel");
}

//Function Number: 78
fin_silo_plr_picked_up(param_00)
{
	soundscripts\_snd::snd_slate("pickup");
}

//Function Number: 79
fin_gid_carry_plr_1(param_00)
{
	if(!isdefined(level.aud.carry_first_done))
	{
		level.aud.carry_first_done = 1;
		soundscripts\_snd_playsound::snd_play_2d("fin_blackout_carry_1");
		return;
	}

	if(level.aud.carry_first_done == 1)
	{
		level.aud.carry_first_done = 2;
		soundscripts\_audio_mix_manager::mm_add_submix("fin_black_out_seq");
		soundscripts\_snd_playsound::snd_play_2d("fin_blackout_carry_2");
		return;
	}
}

//Function Number: 80
fin_gid_carry_plr_2(param_00)
{
}

//Function Number: 81
fin_gid_plr_putdown(param_00)
{
	soundscripts\_snd_common::snd_enable_soundcontextoverride("finale_handgun");
	soundscripts\_snd_playsound::snd_play_2d("fin_blackout_gid_drops_plr");
	wait(4);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_black_out_seq");
	soundscripts\_audio_mix_manager::mm_add_submix("fin_lobby_shootout");
}

//Function Number: 82
fin_lobby_gun_limp()
{
	soundscripts\_snd_playsound::snd_play_2d("fin_lobby_plr_arm_goes_limp");
}

//Function Number: 83
fin_gid_carry_pickup_2(param_00)
{
	soundscripts\_snd_common::snd_disable_soundcontextoverride("finale_handgun");
	param_00 soundscripts\_snd_playsound::snd_play_linked("fin_lobby_gid_picksup_plr");
	soundscripts\_snd_playsound::snd_play_2d("fin_lobby_plr_picked_up");
	wait(4);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_lobby_shootout");
}

//Function Number: 84
fin_gid_carry_plr_3(param_00)
{
}

//Function Number: 85
fin_gid_carry_plr_4(param_00)
{
}

//Function Number: 86
irons_reveal_scene()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_black_out_seq");
}

//Function Number: 87
aud_irons_says_hello()
{
	wait(8.8);
	soundscripts\_audio_mix_manager::mm_add_submix("fin_irons_lights");
	soundscripts\_snd_playsound::snd_play_2d("fin_irons_reveal_light_on");
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_irons_lights");
}

//Function Number: 88
aud_irons_reveal_star_trek_door()
{
	var_00 = self;
	var_00 soundscripts\_snd_playsound::snd_play_linked("fin_irons_reveal_door_slide");
}

//Function Number: 89
fin_reveal_gid_drops_plr(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("fin_irons_reveal");
	soundscripts\_snd::snd_slate("drop player");
	param_00 soundscripts\_snd_playsound::snd_play_linked("fin_reveal_gid_drop_plr");
	soundscripts\_snd_playsound::snd_play_2d("fin_reveal_plr_dropped");
}

//Function Number: 90
fin_irons_reveal_plr_start(param_00)
{
}

//Function Number: 91
fin_irons_reveal_plr_stand(param_00)
{
	if(!isdefined(level.aud.reveal_scene))
	{
		level.aud.reveal_scene = 1;
		soundscripts\_snd::snd_slate("plr_stands");
		soundscripts\_snd_playsound::snd_play_2d("fin_reveal_plr_gets_up");
	}
}

//Function Number: 92
fin_irons_reveal_irons_start(param_00)
{
	soundscripts\_snd::snd_slate("irons_start");
	param_00 soundscripts\_snd_playsound::snd_play_linked("fin_reveal_irons_part_1");
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_irons_phone_pullout",6.1);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_irons_reveal_phone_beep_occluded",7.35);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_irons_reveal_phone_beep",11.72);
	param_00 soundscripts\_snd_playsound::snd_play_delayed_linked("fin_irons_phone_putaway",15.4);
}

//Function Number: 93
fin_irons_reveal_irons_takes_gun(param_00)
{
	soundscripts\_snd::snd_slate("irons_takes gun");
	param_00 soundscripts\_snd_playsound::snd_play_linked("fin_reveal_irons_part_2");
}

//Function Number: 94
fin_irons_reveal_irons_quake(param_00)
{
	soundscripts\_snd::snd_slate("irons quake");
	param_00 soundscripts\_snd_playsound::snd_play_linked("fin_reveal_irons_part_3");
}

//Function Number: 95
aud_irons_reveal_bomb_shake(param_00)
{
	var_01 = 3.9;
	var_02 = param_00 + var_01;
	wait(var_02);
	soundscripts\_audio_mix_manager::mm_add_submix("fin_irons_reveal_bomb");
	soundscripts\_snd_playsound::snd_play_2d("fin_irons_reveal_bomb");
	wait(7);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_irons_reveal_bomb");
}

//Function Number: 96
fin_irons_reveal_irons_points_gun(param_00)
{
}

//Function Number: 97
fin_irons_reveal_gun_away_exit(param_00)
{
	soundscripts\_snd::snd_slate("irons exits");
	param_00 soundscripts\_snd_playsound::snd_play_linked("fin_reveal_irons_part_4");
}

//Function Number: 98
fin_irons_reveal_scene_gid_start(param_00)
{
}

//Function Number: 99
fin_irons_reveal_scene_gid_exo_freeze(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("fin_exo_scramble");
}

//Function Number: 100
fin_irons_reveal_mash_start()
{
	level.aud.irons_reveal_mash_state = "stopped";
	level.aud.irons_reveal_mash_loop_stopped = 1;
}

//Function Number: 101
fin_irons_reveal_mash(param_00)
{
	if(level.aud.irons_reveal_mash_state != param_00)
	{
		switch(param_00)
		{
			case "peak":
				break;

			case "speedup":
				if(level.aud.irons_reveal_mash_loop_stopped == 1)
				{
					soundscripts\_snd::snd_slate("start");
					level notify("irons_reveal_mash_loop_start");
					level.aud.irons_reveal_mash_loop_stopped = 0;
					soundscripts\_snd_playsound::snd_play_loop_2d("fin_exo_release_lp","kill_release_lp");
				}
				break;

			case "stopped":
				soundscripts\_snd::snd_slate("stopped");
				thread fin_irons_reveal_mash_try_stop();
				break;

			case "slowdown":
				break;
		}

		level.aud.irons_reveal_mash_state = param_00;
	}
}

//Function Number: 102
fin_irons_reveal_mash_try_stop()
{
	level endon("irons_reveal_mash_loop_start");
	wait(0.25);
	level.aud.irons_reveal_mash_loop_stopped = 1;
	level notify("kill_release_lp");
}

//Function Number: 103
fin_irons_reveal_mash_finish()
{
	soundscripts\_snd::snd_slate("finished");
	level notify("kill_release_lp");
	soundscripts\_snd_playsound::snd_play_2d("fin_exo_release_finished");
	soundscripts\_snd_playsound::snd_play_2d("fin_exo_release_suit_falls_off");
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_exo_release_eject",2);
}

//Function Number: 104
aud_irons_reveal_bomb_shake_02(param_00)
{
	var_01 = 5.2;
	var_02 = param_00 + var_01;
	wait(var_02);
	soundscripts\_audio_mix_manager::mm_add_submix("fin_irons_reveal_bomb");
	soundscripts\_snd_playsound::snd_play_2d("fin_irons_reveal_bomb_02");
	wait(7);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_irons_reveal_bomb");
}

//Function Number: 105
irons_reveal_exit_door_open(param_00)
{
	soundscripts\_snd::snd_slate("irons_reveal_exit_door_open");
	param_00 soundscripts\_snd_playsound::snd_play_linked("fin_chase_irons_first_door");
}

//Function Number: 106
irons_keypad_door_open(param_00)
{
	soundscripts\_snd::snd_slate("irons_keypad_door_open");
	param_00 soundscripts\_snd_playsound::snd_play_linked("fin_chase_irons_door_open");
}

//Function Number: 107
irons_chase_door_close(param_00)
{
	soundscripts\_snd::snd_slate("irons_chase_door_close");
	param_00 soundscripts\_snd_playsound::snd_play_linked("fin_chase_irons_door_close");
	wait(5);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_irons_reveal");
}

//Function Number: 108
fin_skybridge_takedown_start()
{
	soundscripts\_audio_mix_manager::mm_add_submix("skybridge_takedown",1);
	soundscripts\_snd_timescale::snd_set_timescale("slomo_timescale");
	soundscripts\_snd_playsound::snd_play_2d("fin_skybridge_takedown","kill_takedown",undefined,1.1);
}

//Function Number: 109
fin_skybridge_slo_mo_start()
{
	soundscripts\_audio_mix_manager::mm_add_submix("skybridge_takedown_slomo");
}

//Function Number: 110
fin_skybridge_slo_mo_stop()
{
	soundscripts\_audio_mix_manager::mm_clear_submix("skybridge_takedown_slomo",0.25);
	wait(1);
	soundscripts\_audio_mix_manager::mm_clear_submix("skybridge_takedown");
	soundscripts\_snd_timescale::snd_set_timescale("all_on");
}

//Function Number: 111
bridge_takedown_success()
{
	soundscripts\_audio_mix_manager::mm_add_submix("skybridge_knife");
	soundscripts\_snd_playsound::snd_play_2d("fin_skybridge_knife_out");
}

//Function Number: 112
bridge_takedown_fail()
{
	level notify("kill_takedown");
	soundscripts\_snd_playsound::snd_play_2d("fin_skybridge_takedown_fail");
}

//Function Number: 113
fin_skybridge_glass_explo()
{
	soundscripts\_snd_playsound::snd_play_2d("fin_skybridge_explo");
	soundscripts\_snd_playsound::snd_play_2d("exp_generic_explo_shot_22");
	soundscripts\_snd_playsound::snd_play_2d("glass_pane_blowout");
	soundscripts\_snd_playsound::snd_play_2d("exp_debris_glass");
	wait(3);
	soundscripts\_audio_mix_manager::mm_clear_submix("skybridge_knife");
}

//Function Number: 114
fin_irons_takedown_start()
{
	soundscripts\_snd_playsound::snd_play_2d("fin_balcony_irons_tackle_intro");
	soundscripts\_snd_playsound::snd_play_loop_2d("fin_ending_fire_loop_lfe","kill_fire_lp",0.5,0.5);
	soundscripts\_snd_playsound::snd_play_2d("fin_ending_fire_explos");
}

//Function Number: 115
fin_irons_tackle()
{
	soundscripts\_audio_mix_manager::mm_add_submix("fin_irons_tackle");
	var_00 = (16596,-86850,6998);
	soundscripts\_snd_playsound::snd_play_loop_at("fin_ending_fire_loop",var_00,undefined,2);
	soundscripts\_snd_playsound::snd_play_2d("fin_balcony_irons_tackle");
	wait(6);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_irons_tackle",1);
}

//Function Number: 116
fin_ending_slo_mo_override()
{
	soundscripts\_snd_timescale::snd_set_timescale("all_off");
}

//Function Number: 117
finale_qte_show_knife()
{
	soundscripts\_snd_timescale::snd_set_timescale("all_off");
	soundscripts\_audio_mix_manager::mm_add_submix("fin_end_qte");
	soundscripts\_snd_playsound::snd_play_2d("fin_ending_show_knife");
}

//Function Number: 118
finale_ending_qte1_success()
{
	soundscripts\_snd_playsound::snd_play_2d("fin_ending_flex_hand");
}

//Function Number: 119
finale_ending_qte1_timeout()
{
}

//Function Number: 120
finale_ending_buttonmash_start()
{
	soundscripts\_snd_playsound::snd_play_2d("fin_ending_qte_drag");
}

//Function Number: 121
finale_ending_buttonmash_fail()
{
	soundscripts\_snd_playsound::snd_play_2d("fin_ending_qte_fail_fall");
}

//Function Number: 122
finale_ending_qte2_success()
{
	wait(0.5);
	soundscripts\_audio_mix_manager::mm_add_submix("fin_end_kill_irons",0.5);
	wait(2.5);
	soundscripts\_audio_mix_manager::mm_clear_submix("fin_end_kill_irons",1);
}

//Function Number: 123
fin_ending_qte_stab(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("fin_ending_qte_stab");
	soundscripts\_snd::snd_slate("stab");
}

//Function Number: 124
finale_ending_qte2_timeout()
{
	soundscripts\_snd::snd_slate("finale_ending_qte2_timeout");
}

//Function Number: 125
fin_ending_knife_drop(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("fin_ending_knife_drop",0.1);
	soundscripts\_audio_mix_manager::mm_add_submix("fin_end_gid_rescue",20);
}

//Function Number: 126
fin_ending_plr_foley_1(param_00)
{
	soundscripts\_audio_mix_manager::mm_add_submix("fin_end_rescue_foley");
	soundscripts\_snd_playsound::snd_play_2d("fin_ending_gid_rescue_foley_1");
}

//Function Number: 127
fin_ending_plr_foley_2(param_00)
{
	var_01 = soundscripts\_snd_playsound::snd_play_2d("fin_ending_gid_rescue_foley_2");
	wait(7.25);
	var_01 scalevolume(0,13);
}

//Function Number: 128
fin_ending_gideon_foley_1(param_00)
{
}

//Function Number: 129
fin_ending_gideon_foley_2(param_00)
{
}