/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: df_fly_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 382 ms
 * Timestamp: 4/22/2024 2:28:41 AM
*******************************************************************/

//Function Number: 1
main()
{
	config_system();
	init_snd_flags();
	init_globals();
	create_conversation_arrays();
	launch_threads();
	launch_loops();
	create_level_envelop_arrays();
	precache_presets();
	register_snd_messages();
}

//Function Number: 2
config_system()
{
	soundscripts\_audio::set_stringtable_mapname("shg");
	soundscripts\_snd_filters::snd_set_occlusion("med_occlusion");
}

//Function Number: 3
init_snd_flags()
{
}

//Function Number: 4
init_globals()
{
	level.aud.convoactive = 0;
	level.aud.convogate = 1;
}

//Function Number: 5
launch_threads()
{
	if(soundscripts\_audio::aud_is_specops())
	{
		return;
	}

	thread setup_pod_eject_anims();
	thread soundscripts\_audio_mix_manager::mm_add_submix("master_mix");
}

//Function Number: 6
setup_pod_eject_anims()
{
	maps\_anim::addnotetrack_customfunction("player_rig","start",::start_pod_sequence,"deploy");
}

//Function Number: 7
launch_loops()
{
	thread aud_background_chatter();
}

//Function Number: 8
create_level_envelop_arrays()
{
	level.aud.envs = [];
	level.aud.envs["example_envelop"] = [[0,0],[0.082,0.426],[0.238,0.736],[0.408,0.844],[0.756,0.953],[1,1]];
}

//Function Number: 9
create_conversation_arrays()
{
	level.aud.convos = [];
	level.aud.convos[0] = ["df_ss2_artsupport1","df_ss1_position1","df_ss1_landmark1","df_ss2_finbuilding1","df_ss1_payloadinbound"];
	level.aud.convos[1] = ["df_ss3_multcontacts","df_so_clearengage2","df_ss3_solidcopy3","df_so_unable2","df_ss3_harddcopy3"];
	level.aud.convos[2] = ["df_ss3_positionaldata3","df_ss4_goahead3","df_ss3_gridsupp3","df_ss4_proceed3"];
	level.aud.convos[3] = ["df_ss1_maintainpos4","df_ss2_copyall4","df_ss3_hardcopy4"];
	level.aud.convos[4] = ["df_ss1_movement6","df_ss4_confirmation6","df_ss4_thisapollo6","df_ss1_goforathena6","df_ss4_clearengage6","df_ss1_engaging6"];
	level.aud.convos[5] = ["df_ss3_immstrike7","df_jp1_proceed7","df_ss3_mapgrid7","df_jp1_ordinance7","df_jp1_inair7"];
	level.aud.convos[6] = ["df_jp1_commencing8","df_ss3_ceasedrops8","df_jp1_canceldrop8","df_ss3_cancelrun8","df_jp1_cancelingrun8","df_ss3_posdata8"];
	level.aud.convos[7] = ["df_ss4_notinbound11","df_ss1_flankposition11","df_ss4_out11"];
	level.aud.convos[8] = ["df_ss1_thisis12","df_ss3_gofor12","df_ss1_fortified12","df_ss3_sitrep12","df_ss1_wounded12"];
	level.aud.convos[9] = ["df_ss3_hold13","df_ss1_copy13"];
	level.aud.convos[10] = ["df_ss4_approach14","df_ss3_ceasefire14","df_ss3_advance14","df_ss4_moving14"];
	level.aud.convos[11] = ["df_ss4_sitrepd23","df_ss1_send23","df_ss4_howcopy23","df_ss1_solidcopy23","df_ss4_end23"];
	level.aud.convos[12] = ["df_ss4_thisis24","df_so_send24","df_ss4_support24"];
}

//Function Number: 10
precache_presets()
{
}

//Function Number: 11
register_snd_messages()
{
	soundscripts\_snd::snd_register_message("snd_zone_handler",::zone_handler);
	soundscripts\_snd::snd_register_message("snd_music_handler",::music_handler);
	soundscripts\_snd::snd_register_message("snd_start_canyon_intro",::snd_start_canyon_intro);
	soundscripts\_snd::snd_register_message("snd_start_canyon",::snd_start_canyon);
	soundscripts\_snd::snd_register_message("snd_start_canyon2",::snd_start_canyon2);
	soundscripts\_snd::snd_register_message("snd_start_canyon_dam",::snd_start_canyon_dam);
	soundscripts\_snd::snd_register_message("snd_start_canyon3",::snd_start_canyon3);
	soundscripts\_snd::snd_register_message("snd_start_canyon_exit",::snd_start_canyon_exit);
	soundscripts\_snd::snd_register_message("fly_fade_in_intro",::fly_fade_in_intro);
	soundscripts\_snd::snd_register_message("destructable_destroyed",::destructable_destroyed);
	soundscripts\_snd::snd_register_message("dam_explode",::dam_explode);
	soundscripts\_snd::snd_register_message("bridge_fall",::bridge_fall);
	soundscripts\_snd::snd_register_message("fly_ending_mix",::fly_ending_mix);
}

//Function Number: 12
zone_handler(param_00,param_01)
{
	switch(param_00)
	{
	}
}

//Function Number: 13
music_handler(param_00,param_01)
{
	switch(param_00)
	{
		case "df_fly_jet_combat":
			break;

		case "df_fly_intro":
			soundscripts\_audio_music::mus_play("mus_df_fly_intro");
			soundscripts\_audio::aud_set_music_submix(0.7);
			break;

		case "df_fly_ending":
			soundscripts\_audio_music::mus_play("mus_df_fly_ending");
			soundscripts\_audio::aud_set_music_submix(0.9);
			break;

		default:
			soundscripts\_audio::aud_print_warning("\tMUSIC MESSAGE NOT HANDLED: " + param_00);
			break;
	}
}

//Function Number: 14
snd_start_canyon_intro()
{
}

//Function Number: 15
snd_start_canyon()
{
	soundscripts\_audio_zone_manager::azm_start_zone("sky_combat",1);
}

//Function Number: 16
snd_start_canyon2()
{
	soundscripts\_audio_zone_manager::azm_start_zone("sky_combat",1);
}

//Function Number: 17
snd_start_canyon_dam()
{
	soundscripts\_audio_zone_manager::azm_start_zone("sky_combat",1);
}

//Function Number: 18
snd_start_canyon3()
{
	soundscripts\_audio_zone_manager::azm_start_zone("sky_combat",1);
}

//Function Number: 19
snd_start_canyon_exit()
{
	soundscripts\_audio_zone_manager::azm_start_zone("sky_combat",1);
}

//Function Number: 20
fly_fade_in_intro()
{
	soundscripts\_audio_zone_manager::azm_start_zone("sky_combat",16);
	soundscripts\_audio_mix_manager::mm_add_submix("intro");
	wait(2);
	soundscripts\_audio_mix_manager::mm_clear_submix("intro",14);
	wait(15.5);
	soundscripts\_snd_playsound::snd_play_2d("canyon_intro_jet");
}

//Function Number: 21
destructable_destroyed(param_00)
{
	param_00 soundscripts\_snd_playsound::snd_play_linked(param_00.animname);
	soundscripts\_audio_mix_manager::mm_add_submix("destruct_event",0.1);
	wait(1);
	soundscripts\_audio_mix_manager::mm_clear_submix("destruct_event",3);
}

//Function Number: 22
dam_explode()
{
	soundscripts\_snd_playsound::snd_play_at("dogfight_canyon_dam_explosion",(-34891,-99910,-24830));
	soundscripts\_audio_mix_manager::mm_add_submix("dam_destruct_event",0.1);
	wait(1);
	soundscripts\_audio_mix_manager::mm_clear_submix("dam_destruct_event",3);
}

//Function Number: 23
bridge_fall()
{
	soundscripts\_snd_playsound::snd_play_at("dogfight_canyon_metal_bridge",(91267,-23114,-33707));
	soundscripts\_audio_mix_manager::mm_add_submix("destruct_event",0.1);
	wait(1);
	soundscripts\_audio_mix_manager::mm_clear_submix("destruct_event",3);
}

//Function Number: 24
start_pod_sequence(param_00)
{
	soundscripts\_snd_playsound::snd_play_delayed_2d("drop_pod_eject_fly_1",4.7);
	soundscripts\_snd_playsound::snd_play_delayed_2d("drop_pod_eject_begin_front",6);
	soundscripts\_snd_playsound::snd_play_delayed_2d("drop_pod_graphics_front",13);
	soundscripts\_snd_playsound::snd_play_delayed_2d("drop_pod_eject_fly_2",15.65);
	soundscripts\_snd_playsound::snd_play_delayed_2d("pod_release",9.85);
}

//Function Number: 25
fly_ending_mix()
{
	soundscripts\_snd_playsound::snd_play_2d("canyon_end_jet");
	soundscripts\_audio_mix_manager::mm_add_submix("exit",2);
	wait(13.3);
	soundscripts\_audio_zone_manager::azm_start_zone("pod_eject",0.5);
}

//Function Number: 26
aud_background_chatter()
{
	common_scripts\utility::flag_wait("intro_finished");
	wait(5);
	for(;;)
	{
		var_00 = randomint(12);
		var_01 = level.aud.convos[var_00];
		foreach(var_03 in var_01)
		{
			var_04 = soundscripts\_snd_playsound::snd_play_2d(var_03);
			if(!isdefined(var_04))
			{
				continue;
			}

			var_04 waittill("sounddone");
			wait(randomfloatrange(1,3.5));
		}
	}
}