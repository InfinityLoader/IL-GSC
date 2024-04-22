/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _audio_presets_vehicles.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 33 ms
 * Timestamp: 4/22/2024 2:03:43 AM
*******************************************************************/

//Function Number: 1
audio_presets_vehicles(param_00,param_01)
{
	switch(param_00)
	{
		case "so_paris_jeep":
			param_01["speed"] = [["so_jeep_slow",["pitch","so_jeep_slow_pitch"],["volume","so_jeep_slow_volume"]],["so_jeep_fast",["pitch","so_jeep_medium_pitch"],["volume","so_jeep_medium_volume"]],["so_jeep_idle",["pitch","so_jeep_idle_pitch"],["volume","so_jeep_idle_volume"]],["updaterate",0.1],["smooth_up",0.3],["smooth_down",0.1],["range",0,25]];
			break;
	}

	return param_01;
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
	}

	return param_01;
}