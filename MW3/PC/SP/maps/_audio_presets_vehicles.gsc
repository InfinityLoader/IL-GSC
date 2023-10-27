/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_audio_presets_vehicles.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 27 ms
 * Timestamp: 10/27/2023 2:20:08 AM
*******************************************************************/

//Function Number: 1
audio_presets_vehicles(param_00,param_01)
{
	switch(param_00)
	{
		case "nymn_player_hind":
			break;
	var_7B["speed"]
	[["hind_move",["pitch","player_hind_move_pitch"],["volume","player_hind_move_volume"]],["hind_hover",["pitch","player_hind_hover_pitch"],["volume","player_hind_hover_volume"]],["updaterate",0.2],["smooth_up",0.3],["smooth_down",0.03],["range",1,40]]
			break;

		case "nymn_broad_hind":
			break;
	var_7B["speed"]
	[["broad_hind_move",["pitch","player_hind_move_pitch"],["volume","enemy_hind_move_volume"]],["updaterate",0.2],["smooth_up",0.3],["smooth_down",0.03],["range",1,30]]
			break;

		case "paris_a_mi17":
			break;
	var_7B["speed"]
	[["mi17_engine_high",["pitch","mi17_move_pitch"],["volume","mi17_move_volume"]],["mi17_idle_high",["pitch","mi17_hover_pitch"],["volume","mi17_hover_volume"]],["updaterate",0.2],["smooth_up",0.3],["smooth_down",0.01],["range",1,30]]
			break;

		case "dubai_littlebird":
			break;
	var_7B["speed"]
	[["dubai_littlebird_engine_high",["pitch","dubai_littlebird_move_pitch"],["volume","dubai_littlebird_move_volume"]],["dubai_littlebird_idle_high",["pitch","dubai_littlebird_hover_pitch"],["volume","dubai_littlebird_hover_volume"]],["updaterate",0.2],["smooth_up",0.3],["smooth_down",0.01],["range",1,30]]
			break;

		case "paris_chase_hind":
			break;
	var_7B["speed"]
	[["chase_hind_move",["pitch","player_hind_move_pitch"],["volume","enemy_hind_move_volume"]],["updaterate",0.2],["smooth_up",0.3],["smooth_down",0.01],["range",1,30]]
			break;

		case "escape_zodiac":
			break;
	var_7B["start_stop"]
	[["start","shg_zodiac_plr_rampup",["pitch","zodiac_player_rampup_pitch"],["volume","zodiac_player_rampup_volume"],1],["stop","shg_zodiac_plr_rampdown",["pitch","zodiac_player_rampdown_pitch"],["volume","zodiac_player_rampdown_volume"]],["updaterate",0.1],["offset",-50],["throttle_input","throttle"],["on_threshold",0.3],["off_threshold",-0.3],["smooth_up",0.5],["smooth_down",0.5]]
	var_7B["speed"]
	[["shg_zodiac_plr_motor_slow",["pitch","zodiac_player_slow_pitch"],["volume","zodiac_player_slow_volume"]],["shg_zodiac_plr_motor_med",["pitch","zodiac_player_medium_pitch"],["volume","zodiac_player_medium_volume"]],["shg_zodiac_plr_motor_fast",["pitch","zodiac_player_fast_pitch"],["volume","zodiac_player_fast_volume"]],["offset",-50],["updaterate",0.2],["multiply_by_throttle",1],["smooth_up",0.15],["smooth_down",0.25],["oneshot_duck",0.5],["oneshot_duck_time",1.5],["range",0,45]]
			break;

		case "escape_zodiac_water":
			break;
	var_7B["speed"]
	[["shg_zodiac_plr_water_idle",["pitch","zodiac_plr_water_idle_pitch"],["volume","zodiac_plr_water_idle_volume"]],["shg_zodiac_plr_water_slow",["pitch","zodiac_plr_water_slow_pitch"],["volume","zodiac_plr_water_slow_volume"]],["shg_zodiac_plr_water_med",["pitch","zodiac_plr_water_med_pitch"],["volume","zodiac_plr_water_med_volume"]],["shg_zodiac_plr_water_fast",["pitch","zodiac_plr_water_fast_pitch"],["volume","zodiac_plr_water_fast_volume"]],["updaterate",0.2],["smooth_up",0.3],["smooth_down",0.3],["range",1,30],["heightmax",25]]
			break;

		case "sdv_motor_player":
			break;
	var_7B["start_stop"]
	[["start","shg_sdv_plr_startup",["pitch","sdv_plr_rampup_pitch"],["volume","sdv_plr_rampup_volume"]],["stop","shg_sdv_plr_shutdown",["pitch","sdv_plr_rampdown_pitch"],["volume","sdv_plr_rampdown_volume"]],["updaterate",0.1],["throttle_input","throttle"],["on_threshold",0.3],["off_threshold",-0.3],["smooth_up",0.5],["smooth_down",0.5]]
	var_7B["speed"]
	[["shg_sdv_plr_motor_slow",["pitch","sdv_plr_motor_slow_pitch"],["volume","sdv_plr_motor_slow_volume"]],["shg_sdv_plr_motor_med",["pitch","sdv_plr_motor_med_pitch"],["volume","sdv_plr_motor_med_volume"]],["shg_sdv_plr_motor_fast",["pitch","sdv_plr_motor_fast_pitch"],["volume","sdv_plr_motor_fast_volume"]],["updaterate",0.2],["multiply_by_throttle",1],["throttle_input","throttle"],["smooth_up",0.1],["smooth_down",0.3],["range",1,12]]
			break;

		case "ugv_motor_player":
			break;
	var_7B["start_stop"]
	[["start","null",["pitch","sdv_plr_rampup_pitch"],["volume","sdv_plr_rampup_volume"]],["stop","null",["pitch","sdv_plr_rampdown_pitch"],["volume","sdv_plr_rampdown_volume"]],["updaterate",0.3],["throttle_input","leftstick_abs"],["on_threshold",0.3],["off_threshold",-0.3],["smooth_up",0.2],["smooth_down",0.2]]
	var_7B["speed"]
	[["ugv_plr_motor_slow",["pitch","sdv_plr_motor_slow_pitch"],["volume","sdv_plr_motor_slow_volume"]],["ugv_plr_motor_slow",["pitch","sdv_plr_motor_med_pitch"],["volume","sdv_plr_motor_med_volume"]],["ugv_plr_motor_fast",["pitch","sdv_plr_motor_fast_pitch"],["volume","sdv_plr_motor_fast_volume"]],["updaterate",0.1],["multiply_by_throttle",1],["throttle_input","leftstick_abs"],["smooth_up",0.2],["smooth_down",0.2],["range",1,8]]
			break;

		case "ugv_treads_player":
			break;
	var_7B["speed"]
	[["ugv_plr_treads_slow",["pitch","sdv_plr_motor_slow_pitch"],["volume","sdv_plr_motor_slow_volume"]],["ugv_plr_treads_slow",["pitch","sdv_plr_motor_med_pitch"],["volume","sdv_plr_motor_med_volume"]],["ugv_plr_treads_fast",["pitch","sdv_plr_motor_fast_pitch"],["volume","sdv_plr_motor_fast_volume"]],["updaterate",0.1],["multiply_by_throttle",1],["throttle_input","leftstick_abs"],["smooth_up",0.1],["smooth_down",0.1],["range",0.5,8]]
			break;

		case "ugv_idle_player":
			break;
	var_7B["speed"]
	[["ugv_plr_idle",["pitch","so_jeep_idle_pitch"],["volume","so_jeep_idle_volume"]],["updaterate",0.1],["smooth_up",0.2],["smooth_down",0.2],["range",0,25]]
			break;

		case "sdv_water_player":
			break;
	var_7B["speed"]
	[["shg_sdv_plr_water_slow",["pitch","sdv_plr_water_slow_pitch"],["volume","sdv_plr_water_slow_volume"]],["shg_sdv_plr_water_med",["pitch","sdv_plr_water_med_pitch"],["volume","sdv_plr_water_med_volume"]],["updaterate",0.2],["smooth_up",0.3],["smooth_down",0.1],["range",1,8]]
			break;

		case "so_paris_jeep":
			break;
	var_7B["speed"]
	[["so_jeep_slow",["pitch","so_jeep_slow_pitch"],["volume","so_jeep_slow_volume"]],["so_jeep_fast",["pitch","so_jeep_medium_pitch"],["volume","so_jeep_medium_volume"]],["so_jeep_idle",["pitch","so_jeep_idle_pitch"],["volume","so_jeep_idle_volume"]],["updaterate",0.1],["smooth_up",0.3],["smooth_down",0.1],["range",0,25]]
			break;
	}

	return var_7B;
}

//Function Number: 2
audio_presets_vehicle_maps(param_00,param_01)
{
	switch(param_00)
	{
		case "so_jeep_idle_pitch":
			param_01 = [[0,0.5],[0.02,0.65],[0.1,0.75],[0.2,0.85],[1,1]];
			break;

		case "so_jeep_idle_volume":
			param_01 = [[0,1],[0.05,0.9],[0.1,0.85],[0.25,0.45],[0.3,0.15],[0.35,0],[1,0]];
			break;

		case "so_jeep_slow_pitch":
			param_01 = [[0,0.38],[0.1,0.4],[0.4,0.45],[0.45,0.5],[0.55,0.55],[0.7,0.6],[1,0.8]];
			break;

		case "so_jeep_slow_volume":
			param_01 = [[0,0.01],[0.1,0.5],[0.35,0.75],[0.55,1],[0.7,0.6],[0.8,0.45],[1,0.01]];
			break;

		case "so_jeep_medium_pitch":
			param_01 = [[0,0.25],[0.5,0.3],[0.65,0.35],[0.75,0.4],[0.85,0.45],[1,0.5]];
			break;

		case "so_jeep_medium_volume":
			param_01 = [[0,0],[0.4,0.2],[0.6,0.6],[0.75,0.9],[1,1]];
			break;

		case "player_hind_move_volume":
			param_01 = [[0,0],[0.3,0],[0.6,0.35],[0.7,0.9],[1,1]];
			break;

		case "player_hind_move_pitch":
			param_01 = [[0,0.4],[0.5,0.4],[0.75,0.5],[1,0.7]];
			break;

		case "player_hind_hover_volume":
			param_01 = [[0,1],[1,1]];
			break;

		case "player_hind_hover_pitch":
			param_01 = [[0,0.4],[0.5,0.5],[1,0.7]];
			break;

		case "enemy_hind_move_volume":
			param_01 = [[0,1],[1,1]];
			break;

		case "mi17_move_volume":
			param_01 = [[0,0.75],[0.3,0.85],[0.6,0.95],[0.7,0.99],[1,1]];
			break;

		case "mi17_move_pitch":
			param_01 = [[0,0.4],[0.5,0.6],[1,0.7]];
			break;

		case "mi17_hover_volume":
			param_01 = [[0,1],[1,0.75]];
			break;

		case "mi17_hover_pitch":
			param_01 = [[0,0.4],[0.5,0.6],[1,0.7]];
			break;

		case "dubai_littlebird_move_volume":
			param_01 = [[0,0.75],[0.3,0.85],[0.6,0.95],[0.7,0.99],[1,1]];
			break;

		case "dubai_littlebird_move_pitch":
			param_01 = [[0,0.4],[0.5,0.6],[1,0.7]];
			break;

		case "dubai_littlebird_hover_volume":
			param_01 = [[0,1],[1,0.75]];
			break;

		case "dubai_littlebird_hover_pitch":
			param_01 = [[0,0.4],[0.5,0.6],[1,0.7]];
			break;

		case "zodiac_player_rampup_pitch":
			param_01 = [[0,0.45],[0.5,0.5],[1,1]];
			break;

		case "zodiac_player_rampup_volume":
			param_01 = [[0,0],[0.25,0.5],[0.85,1],[1,1]];
			break;

		case "zodiac_player_rampdown_pitch":
			param_01 = [[0,0.5],[0.25,0.55],[1,0.6]];
			break;

		case "zodiac_player_rampdown_volume":
			param_01 = [[0,1],[0.25,0.85],[0.5,0.5],[1,0.25]];
			break;

		case "zodiac_player_idle_pitch":
			param_01 = [[0,0.5],[0.02,0.65],[0.1,0.75],[0.2,0.85],[1,1]];
			break;

		case "zodiac_player_idle_volume":
			param_01 = [[0,0.75],[0.05,1],[0.1,0.85],[0.25,0.45],[0.3,0.15],[0.35,0],[1,0]];
			break;

		case "zodiac_player_bottom_pitch":
			param_01 = [[0,0.35],[0.1,0.4],[0.3,0.5],[0.35,0.6],[0.45,0.65],[0.6,0.7],[1,0.75]];
			break;

		case "zodiac_player_bottom_volume":
			param_01 = [[0,0.75],[0.15,0.75],[0.35,1],[0.45,0.35],[0.55,0.25],[0.6,0.2],[0.7,0.15],[1,0]];
			break;

		case "zodiac_player_slow_pitch":
			param_01 = [[0,0.2],[0.4,0.35],[0.45,0.45],[0.55,0.5],[0.7,0.6],[1,0.8]];
			break;

		case "zodiac_player_slow_volume":
			param_01 = [[0,0.25],[0.1,0.5],[0.35,0.75],[0.55,1],[0.7,0.5],[0.8,0.35],[1,0.2]];
			break;

		case "zodiac_player_medium_pitch":
			param_01 = [[0,0.35],[0.5,0.45],[0.65,0.5],[0.75,0.6],[0.85,0.7],[1,0.7]];
			break;

		case "zodiac_player_medium_volume":
			param_01 = [[0,0],[0.4,0.2],[0.6,0.5],[0.75,1],[0.8,0.5],[0.9,0.25],[1,0.1]];
			break;

		case "zodiac_player_fast_pitch":
			param_01 = [[0,0.45],[0.7,0.45],[0.85,0.5],[0.95,0.55],[1,0.7]];
			break;

		case "zodiac_player_fast_volume":
			param_01 = [[0,0],[0.6,0],[0.7,0.25],[0.85,0.5],[0.95,0.5],[1,1]];
			break;

		case "zodiac_plr_water_idle_pitch":
			param_01 = [[0,0.5],[1,0.5]];
			break;

		case "zodiac_plr_water_idle_volume":
			param_01 = [[0,1],[0.1,0.5],[0.15,0.25],[0.2,0.15],[0.35,0],[1,0]];
			break;

		case "zodiac_plr_water_botm_pitch":
			param_01 = [[0,0.45],[0.1,0.5],[0.3,0.5],[1,0.5]];
			break;

		case "zodiac_plr_water_botm_volume":
			param_01 = [[0,0],[0.15,0.25],[0.35,1],[0.45,0.35],[0.55,0.25],[0.6,0.2],[0.7,0.15],[1,0]];
			break;

		case "zodiac_plr_water_slow_pitch":
			param_01 = [[0,0.45],[0.1,0.5],[0.3,0.5],[1,0.5]];
			break;

		case "zodiac_plr_water_slow_volume":
			param_01 = [[0,0],[0.1,0.25],[0.35,0.75],[0.55,1],[0.7,0.5],[0.8,0.35],[1,0.2]];
			break;

		case "zodiac_plr_water_med_pitch":
			param_01 = [[0,0.45],[0.1,0.5],[0.3,0.5],[1,0.5]];
			break;

		case "zodiac_plr_water_med_volume":
			param_01 = [[0,0],[0.4,0.2],[0.6,0.5],[0.75,1],[0.8,0.5],[0.9,0.25],[1,0.1]];
			break;

		case "zodiac_plr_water_fast_pitch":
			param_01 = [[0,0.45],[0.1,0.5],[0.3,0.5],[1,0.5]];
			break;

		case "zodiac_plr_water_fast_volume":
			param_01 = [[0,0],[0.6,0],[0.7,0.5],[0.85,1],[1,1]];
			break;

		case "sdv_plr_rampup_pitch":
			param_01 = [[0,0.5],[0.5,0.5],[1,0.5]];
			break;

		case "sdv_plr_rampup_volume":
			param_01 = [[0,1],[1,1]];
			break;

		case "sdv_plr_rampdown_pitch":
			param_01 = [[0,0.5],[0.5,0.5],[1,0.5]];
			break;

		case "sdv_plr_rampdown_volume":
			param_01 = [[0,1],[1,1]];
			break;

		case "sdv_plr_motor_slow_pitch":
			param_01 = [[0,0.25],[0.15,0.4],[0.3,0.5],[0.6,0.55],[0.75,0.65],[1,0.75]];
			break;

		case "sdv_plr_motor_slow_volume":
			param_01 = [[0,0],[0.05,0.5],[0.15,0.75],[0.25,1],[0.35,0.5],[0.45,0.25],[0.55,0.2],[1,0]];
			break;

		case "sdv_plr_motor_med_pitch":
			param_01 = [[0,0.5],[0.6,0.5],[0.75,0.65],[1,0.75]];
			break;

		case "sdv_plr_motor_med_volume":
			param_01 = [[0,0],[0.25,0.1],[0.35,0.5],[0.45,1],[0.65,1],[0.75,0.75],[0.95,0.25],[1,0.1]];
			break;

		case "sdv_plr_motor_fast_pitch":
			param_01 = [[0,0.4],[0.6,0.4],[0.7,0.45],[0.85,0.5],[1,0.5]];
			break;

		case "sdv_plr_motor_fast_volume":
			param_01 = [[0,0],[0.6,0.35],[0.7,0.55],[0.85,0.85],[1,1]];
			break;

		case "sdv_plr_water_slow_pitch":
			param_01 = [[0,0.45],[0.1,0.5],[0.3,0.5],[1,0.5]];
			break;

		case "sdv_plr_water_slow_volume":
			param_01 = [[0,0],[0.1,0.25],[0.45,0.75],[0.65,1],[0.7,0.5],[0.8,0.35],[1,0.2]];
			break;

		case "sdv_plr_water_med_pitch":
			param_01 = [[0,0.45],[0.1,0.5],[0.3,0.5],[0.8,0.5],[1,0.55]];
			break;

		case "sdv_plr_water_med_volume":
			param_01 = [[0,0],[0.5,0],[0.75,0],[0.85,0.25],[0.95,0.5],[1,1]];
			break;
	}

	return param_01;
}