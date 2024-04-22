/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _hovertank_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 409 ms
 * Timestamp: 4/22/2024 2:04:58 AM
*******************************************************************/

//Function Number: 1
hovertank_constructor()
{
	var_00 = "ht_engine_idle";
	var_01 = "ht_engine_noise";
	var_02 = "ht_engine_drive";
	var_03 = "ht_engine_synth";
	var_04 = "ht_turret_rotate";
	var_05 = "ht_turret_grind";
	var_06 = "ht_turret_tilt";
	var_07 = "ht_thruster";
	var_08 = "ht_repulsor_front_left";
	var_09 = "ht_repulsor_front_right";
	var_0A = "ht_repulsor_back_left";
	var_0B = "ht_repulsor_back_right";
	var_0C = "ht_uprighting";
	var_0D = "ht_engine_autoyaw";
	var_0E = "ht_turret_start";
	var_0F = "ht_turret_stop";
	soundscripts\_audio_vehicle_manager::avm_begin_preset_def("hovertank",::hovertank_init);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_drive_throt2vol",[[0,0.05],[0.5,0.2],[0.75,0.5],[0.85,0.6],[1,0.35]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_drive_throt2pch",[[0,0.75],[0.55,1],[1,1.5]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_rumble_throt2vol",[[0,0.3],[0.3,0.6],[1,0.35]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_rumble_throt2pch",[[0,1],[1,1.2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_noise_throt2vol",[[0,0],[0.5,0.1],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_synth_throt2vol",[[0,0],[0.3,0.02],[0.4,0.1],[0.7,0.4],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_synth_throt2pch",[[0,0.75],[0.75,1],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_repulsor2vol",[[0,0],[0.23,1],[0.25,0.1],[1,0]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_repulsor2pch",[[0,1],[1,1.2]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_uprighting2vol",[[0,0],[0.01,0.01],[0.02,0.04],[0.025,0.09],[0.04,0.18],[0.06,0.5],[0.1,0.9],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_uprighting2pch",[[0,0.6],[0.025,1],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_autoyaw2vol",[[0,0],[0.15,0.1],[0.25,0.75],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_autoyaw2pch",[[0,0.75],[0.4,1],[1,1.25]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_turret_rotate_yaw2vol",[[0,0],[0.0523,0.6545],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_turret_rotate_yaw2pch",[[0,0.85],[0.1,0.95],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_turret_grind_yaw2vol",[[0,0],[0.1,0.35],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_turret_grind_yaw2pch",[[0,0.95],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_turret_pitch_pch2vol",[[0,0],[0.1,0.3],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_add_envelope("ht_turret_pitch_pch2pch",[[0,0.95],[1,1]]);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_data(3);
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_00);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_throttle_magnitude",0.2,0.06);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_rumble_throt2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","ht_rumble_throt2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_02);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_throttle_magnitude",0.15,0.03);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_drive_throt2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","ht_drive_throt2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_01);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_throttle_magnitude",0.02,0.2);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_noise_throt2vol");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_03);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_throttle_magnitude",0.05,0.15);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_synth_throt2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","ht_synth_throt2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_08);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_repulsor_front_left",0.75,0.75);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_repulsor2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","ht_repulsor2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_09);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_repulsor_front_right",0.75,0.75);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_repulsor2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","ht_repulsor2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_0A);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_repulsor_back_left",0.75,0.75);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_repulsor2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","ht_repulsor2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_0B);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_repulsor_back_right",0.75,0.75);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_repulsor2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","ht_repulsor2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_0C);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_uprighting",0.6,0.09);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_uprighting2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","ht_uprighting2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_0D);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_auto_yaw_magnitude",0.3,0.1);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_autoyaw2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","ht_autoyaw2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_04);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_turret_yaw",0.6,0.7);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_turret_rotate_yaw2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","ht_turret_rotate_yaw2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_begin_loop_def(var_05);
	soundscripts\_audio_vehicle_manager::avm_begin_param_map("hovertank_turret_yaw",0.4,0.4);
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("volume","ht_turret_grind_yaw2vol");
	soundscripts\_audio_vehicle_manager::avm_add_param_map_env("pitch","ht_turret_grind_yaw2pch");
	soundscripts\_audio_vehicle_manager::avm_end_param_map();
	soundscripts\_audio_vehicle_manager::avm_end_loop_def();
	soundscripts\_audio_vehicle_manager::avm_end_loop_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def(var_07);
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def(var_0E);
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_begin_oneshot_def("ht_turret_stop","ht_turret_stop_duck_envelope",0.25);
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_def();
	soundscripts\_audio_vehicle_manager::avm_end_oneshot_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_off",::ht_condition_callback_to_state_off,["hovertank_throttle_magnitude"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_idle",::ht_condition_callback_to_state_idle,["hovertank_throttle_magnitude"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_moving",::ht_condition_callback_to_state_moving,["hovertank_throttle_magnitude"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_add_oneshots(var_07);
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_destruct",::ht_condition_callback_to_state_destruct);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_turret_state_off",::ht_turret_condition_callback_to_state_off,["hovertank_turret_yaw"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_stationary",::ht_turret_condition_callback_to_state_stationary,["hovertank_turret_yaw"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_state_rotating",::ht_turret_condition_callback_to_state_rotating,["hovertank_turret_yaw"]);
	soundscripts\_audio_vehicle_manager::avm_add_loops("ALL");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_begin_behavior_def("to_turret_state_destruct",::ht_turret_condition_callback_to_state_destruct);
	soundscripts\_audio_vehicle_manager::avm_add_loops("NONE");
	soundscripts\_audio_vehicle_manager::avm_end_behavior_def();
	soundscripts\_audio_vehicle_manager::avm_end_behavior_data();
	soundscripts\_audio_vehicle_manager::avm_begin_state_data(0.05,50);
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("test_state_group","state_off","to_state_off",50,1);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_idle","to_state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_moving","to_state_moving");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_moving");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_idle","to_state_idle");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_destruct","to_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_destruct");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_off","to_state_off");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_begin_state_group("ht_turret","turret_state_off","to_turret_state_off",50,0.25);
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("turret_state_off");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_stationary","to_state_stationary");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("turret_state_destruct","to_turret_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_stationary");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_rotating","to_state_rotating");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("turret_state_destruct","to_turret_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("state_rotating");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("state_stationary","to_state_stationary");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("turret_state_destruct","to_turret_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_begin_state_def("turret_state_destruct");
	soundscripts\_audio_vehicle_manager::avm_add_state_transition("turret_state_off","to_turret_state_off");
	soundscripts\_audio_vehicle_manager::avm_end_state_def();
	soundscripts\_audio_vehicle_manager::avm_end_state_group();
	soundscripts\_audio_vehicle_manager::avm_end_state_data();
	soundscripts\_audio_vehicle_manager::avm_end_preset_def();
}

//Function Number: 2
hovertank_init(param_00)
{
	soundscripts\_snd::snd_register_message("hovertank_missile_small_start",::hovertank_missile_small_start);
	soundscripts\_snd::snd_register_message("hovertank_missile_small_stop",::hovertank_missile_small_stop);
	soundscripts\_snd::snd_register_message("hovertank_missile_small_slow",::hovertank_missile_small_slow);
	soundscripts\_snd::snd_register_message("hovertank_cannon_fire",::hovertank_cannon_fire);
	soundscripts\_snd::snd_register_message("hovertank_antiair_fire",::hovertank_antiair_fire);
	soundscripts\_snd::snd_register_message("hovertank_switch_to_emp",::hovertank_switch_to_emp);
	soundscripts\_snd::snd_register_message("hovertank_switch_to_cannon",::hovertank_switch_to_cannon);
	soundscripts\_snd::snd_register_message("hovertank_switch_to_missile",::hovertank_switch_to_missile);
	soundscripts\_snd::snd_register_message("hovertank_antiair_recoil",::hovertank_antiair_recoil);
	soundscripts\_snd::snd_register_message("hovertank_barrel_turn",::hovertank_barrel_turn);
	soundscripts\_snd::snd_register_message("ht_cannon_reload",::ht_cannon_reload);
	soundscripts\_snd::snd_register_message("hovertank_trophy_system",::hovertank_trophy_system);
	soundscripts\_snd::snd_register_message("defenseless_tank_impact",::defenseless_tank_impact);
	var_01 = self;
	var_02 = var_01 soundscripts\_audio_vehicle_manager::avmx_get_vehicle_entity();
	var_02 thread monitor_tank_health();
}

//Function Number: 3
hovertank_missile_small_start()
{
	level endon("hovertank_end");
	wait(0.1);
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_missile_one_shot");
	soundscripts\_audio::deprecated_aud_play_linked_sound("ht_missile_start",level.player,"loop","notify_hovertank_missile_small_stop_loop",undefined,undefined,undefined,0.1);
	var_00 = "ht_missile_tail";
	var_01 = "level_notify_kill_missile_tail_fast";
	while(level.gun_state == "full_loop")
	{
		thread play_missile_whoosh_thread(var_00,var_01);
		wait(randomfloatrange(0.08,0.4));
	}

	level notify(var_01);
}

//Function Number: 4
hovertank_missile_small_slow()
{
	level endon("hovertank_end");
	wait(0.1);
	level notify("notify_hovertank_missile_small_stop_loop");
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_missile_reload");
	soundscripts\_audio::deprecated_aud_play_linked_sound("ht_missile_slow",level.player,"loop","notify_hovertank_missile_small_stop_loop",undefined,undefined,undefined,0.1);
	var_00 = "ht_missile_tail";
	var_01 = "level_notify_kill_missile_tail_slow";
	while(level.gun_state == "slow_loop")
	{
		thread play_missile_whoosh_thread(var_00,var_01);
		wait(randomfloatrange(0.1,0.7));
	}

	level notify(var_01);
}

//Function Number: 5
hovertank_missile_small_stop()
{
	level notify("notify_hovertank_missile_small_stop_loop");
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_missile_recoil");
}

//Function Number: 6
play_missile_whoosh_thread(param_00,param_01)
{
	level endon("hovertank_end");
	var_02 = spawn("script_origin",level.player.origin);
	var_02 soundscripts\_snd_playsound::snd_play(param_00,"sounddone");
	var_02 thread monitor_missile_snd_ent("sounddone");
	var_02 thread monitor_missile_fire_done(param_01);
	var_02 waittill("notify_kill_missile_tail_snd_ent");
	if(isdefined(var_02))
	{
		var_03 = 0.5;
		var_02 scalevolume(0,var_03);
		wait(var_03);
		if(isdefined(var_02))
		{
			var_02 soundscripts\_snd_playsound::snd_stop_sound();
			var_02 delete();
		}
	}
}

//Function Number: 7
monitor_missile_snd_ent(param_00)
{
	var_01 = self;
	var_01 endon("notify_kill_missile_tail_snd_ent");
	var_01 waittill(param_00);
	var_01 notify("notify_kill_missile_tail_snd_ent");
}

//Function Number: 8
monitor_missile_fire_done(param_00)
{
	var_01 = self;
	var_01 endon("notify_kill_missile_tail_snd_ent");
	level waittill(param_00);
	var_01 notify("notify_kill_missile_tail_snd_ent");
}

//Function Number: 9
hovertank_cannon_fire()
{
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_cannon_fire");
}

//Function Number: 10
hovertank_antiair_fire()
{
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_antiair_fire");
}

//Function Number: 11
hovertank_barrel_turn()
{
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_barrel_turn");
}

//Function Number: 12
hovertank_antiair_recoil()
{
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_antiair_recoil");
}

//Function Number: 13
hovertank_switch_to_emp()
{
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_barrel_swch2emp");
}

//Function Number: 14
hovertank_switch_to_cannon()
{
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_barrel_swch2cannon");
}

//Function Number: 15
hovertank_switch_to_missile()
{
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_missile_equip");
}

//Function Number: 16
ht_cannon_reload()
{
	var_00 = soundscripts\_audio::deprecated_aud_play_2d_sound("ht_cannon_reload");
	level waittill("kill_reload_sound");
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_cannon_reload_stop");
	if(isdefined(var_00))
	{
		var_00 scalevolume(0,0.1);
	}
}

//Function Number: 17
monitor_tank_health()
{
	var_00 = self;
	var_01 = var_00.health;
	var_02 = undefined;
	while(isdefined(var_00))
	{
		var_03 = var_00.health;
		if(!isdefined(var_02) && var_03 <= 23000)
		{
			var_02 = spawn("script_origin",level.player.origin);
			soundscripts\_snd_playsound::snd_play_loop("ht_damage_alarm");
			level waittill("hovertank_end");
			soundscripts\_audio::aud_fade_out_and_delete(var_02,0.25);
			break;
		}

		var_01 = var_03;
		wait(0.5);
	}
}

//Function Number: 18
hovertank_trophy_system(param_00)
{
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_trophy_shot");
	soundscripts\_audio::deprecated_aud_play_sound_at("ht_trophy_intercept",param_00.origin);
}

//Function Number: 19
defenseless_tank_impact()
{
	soundscripts\_audio::deprecated_aud_play_2d_sound("ht_trophy_empty_hit");
}

//Function Number: 20
ht_condition_callback_to_state_off(param_00,param_01)
{
	return 0;
}

//Function Number: 21
ht_condition_callback_to_state_idle(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["hovertank_throttle_magnitude"];
	if(!isdefined(param_01.prev_throttle))
	{
		param_01.prev_throttle = var_03;
		var_02 = 1;
	}
	else if(param_01.prev_throttle > 0.001 && var_03 <= 0.001)
	{
		param_01.prev_throttle = var_03;
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 22
ht_condition_callback_to_state_moving(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["hovertank_throttle_magnitude"];
	if(isdefined(param_01.prev_throttle) && param_01.prev_throttle <= 0.001 && var_03 > 0.001)
	{
		var_02 = 1;
	}

	param_01.prev_throttle = var_03;
	return var_02;
}

//Function Number: 23
ht_condition_callback_to_state_destruct(param_00,param_01)
{
	return 0;
}

//Function Number: 24
ht_turret_condition_callback_to_state_off(param_00,param_01)
{
	return 0;
}

//Function Number: 25
ht_turret_condition_callback_to_state_stationary(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["hovertank_turret_yaw"];
	if(!isdefined(param_01.prev_turret_state))
	{
		param_01.prev_turret_state = var_03;
		var_02 = 1;
	}
	else if(param_01.prev_turret_state > 0.001 && var_03 <= 0.001)
	{
		param_01.prev_turret_state = var_03;
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 26
ht_turret_condition_callback_to_state_rotating(param_00,param_01)
{
	var_02 = 0;
	var_03 = param_00["hovertank_turret_yaw"];
	if(!isdefined(param_01.prev_turret_state))
	{
		param_01.prev_turret_state = var_03;
	}
	else if(param_01.prev_turret_state <= 0.001 && var_03 > 0.001)
	{
		param_01.prev_turret_state = var_03;
		var_02 = 1;
	}

	return var_02;
}

//Function Number: 27
ht_turret_condition_callback_to_state_destruct(param_00,param_01)
{
	return 0;
}