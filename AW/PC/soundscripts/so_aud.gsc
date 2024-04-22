/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: so_aud.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 229 ms
 * Timestamp: 4/22/2024 2:04:08 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	soundscripts\_audio::deprecated_aud_register_msg_handler(::so_msg_handler);
	thread aud_handle_map_setups(param_00);
	soundscripts\_audio::set_stringtable_mapname("mw3");
}

//Function Number: 2
aud_handle_map_setups(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	switch(param_00)
	{
		case "so_nyse_ny_manhattan":
			aud_start_nyse_fire();
			break;
	}
}

//Function Number: 3
so_msg_handler(param_00,param_01)
{
	var_02 = 1;
	switch(param_00)
	{
		case "so_berlin_intro_littlebird_spawn":
			var_03 = param_01;
			var_03 thread common_scripts\utility::play_loop_sound_on_entity("so_littlebird_move");
			break;

		case "so_ied_littlebird":
			var_03 = param_01;
			var_03 thread common_scripts\utility::play_loop_sound_on_entity("so_littlebird_move");
			var_03 thread aud_helicopter_deathwatch();
			break;

		case "so_ied_wave4_littlebird":
			var_04 = param_01;
			var_04 thread common_scripts\utility::play_loop_sound_on_entity("so_littlebird_move_distant");
			var_04 thread aud_helicopter_deathwatch();
			break;

		case "so_ied_wave3_tank":
			var_05 = param_01;
			var_05 thread aud_run_tank_system();
			break;

		case "so_nyse_littlebird_spawn":
			var_03 = param_01;
			var_03 common_scripts\utility::play_loop_sound_on_entity("so_nymn_littlebird_move");
			break;

		case "so_start_harbor_player_hind":
			var_06 = param_01;
			var_06 common_scripts\utility::play_loop_sound_on_entity("so_hind_player");
			break;

		case "so_harbor_ally_helis":
			var_07 = param_01;
			foreach(var_03 in var_07)
			{
				var_03 thread common_scripts\utility::play_loop_sound_on_entity("so_hind_allies");
			}
			break;

		case "so_harbor_kill_helis":
			var_07 = param_01;
			foreach(var_03 in var_07)
			{
				var_03 common_scripts\utility::stop_loop_sound_on_entity("so_hind_allies");
			}
			break;

		case "so_start_harbor_exit_hind":
			var_0C = param_01;
			var_0C common_scripts\utility::play_loop_sound_on_entity("so_exit_hind_player");
			break;

		case "so_harbor_enemy_chopper_flyover":
			var_0D = param_01;
			var_0D maps\_utility::play_sound_on_entity("so_sub_hind_flyover");
			break;

		case "so_sub_missile_launch":
			var_0E = param_01;
			aud_handle_so_missile(var_0E);
			break;

		default:
			var_02 = 0;
			break;
	}

	return var_02;
}

//Function Number: 4
aud_start_nyse_fire()
{
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("fire_wood_med",(-945,-2847,262),"steff_01",1000,1);
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("fire_wood_med",(-1181,-2926,55),"steff_02",1000,1);
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("fire_wood_med_tight",(-1004,-2927,42),"steff_03",1000,1);
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("fire_crackle_med_tight",(-902,-2716,66),"steff_04",1000,1);
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("fire_wood_med_tight",(-909,-2636,36),"steff_05",1000,1);
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("fire_wood_med",(-686,-2120,91),"steff_car",1000,1);
	common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight",(-141,271,2));
	common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight",(-259,579,2));
	common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight",(-475,980,10));
	common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight",(-704,311,-7));
	soundscripts\_audio_dynamic_ambi::damb_start_preset_at_point("fire_crackle_med_tight",(-471,1856,-22),"pre_stock_01",1000,1);
}

//Function Number: 5
aud_handle_so_missile(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	wait(0.05);
	param_00 playsound("russian_sub_missile_launch");
	wait(1.25);
	param_00 playsound("russian_sub_missile_launch_boom");
}

//Function Number: 6
aud_helicopter_deathwatch()
{
	level.aud.crashpos = (0,0,0);
	self waittill("deathspin");
	thread aud_heli_crash_pos();
	thread common_scripts\utility::play_loop_sound_on_entity("so_littlebird_helicopter_dying_loop");
	common_scripts\utility::waittill_either("death","crash_done");
	thread common_scripts\utility::play_sound_in_space("so_littlebird_helicopter_crash",level.aud.crashpos);
}

//Function Number: 7
aud_heli_crash_pos()
{
	self endon("death");
	for(;;)
	{
		if(isdefined(self))
		{
			self.origin = level.aud.crashpos;
			wait(0.05);
		}
	}
}

//Function Number: 8
aud_run_tank_system()
{
	aud_ground_veh_loops("ied_tank_01","us_tank_treads_lp_02","us_tank_move_low_lp","us_tank_idle_lp");
	aud_tank_fire_watch();
}

//Function Number: 9
aud_ground_veh_loops(param_00,param_01,param_02,param_03)
{
	if(isdefined(self))
	{
		level.aud.instance_name = spawn("script_origin",self.origin);
		var_04 = spawn("script_origin",self.origin);
		var_05 = spawn("script_origin",self.origin);
		var_06 = spawn("script_origin",self.origin);
		level.aud.instance_name.fade_in = 1;
		var_07 = level.aud.instance_name;
		var_08 = level.aud.instance_name.fade_in;
		var_04 linkto(self);
		var_06 linkto(self);
		var_05 linkto(self);
		if(isdefined(var_04) || isdefined(param_01))
		{
			var_04 playloopsound(param_01);
		}

		if(isdefined(var_05) || isdefined(param_02))
		{
			var_05 playloopsound(param_02);
		}

		if(isdefined(var_06) || isdefined(param_03))
		{
			var_06 playloopsound(param_03);
		}

		var_04 scalevolume(0);
		var_05 scalevolume(0);
		var_06 scalevolume(0);
		wait(0.3);
		aud_ground_veh_speed_mapping(var_07,var_04,var_05,var_06,1,5,var_08);
	}
}

//Function Number: 10
aud_ground_veh_speed_mapping(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_04 = 1;
	param_05 = 5;
	thread aud_ground_veh_deathwatch(param_00,param_01,param_02,param_03);
	thread aud_create_drive_envs();
	param_00 endon("instance_killed");
	var_07 = 0;
	for(;;)
	{
		if(isdefined(self))
		{
			var_08 = self vehicle_getspeed();
			var_08 = min(var_08,param_05);
			var_08 = soundscripts\_audio::aud_smooth(var_07,var_08,0.1);
			var_09 = soundscripts\_audio::deprecated_aud_map_range(var_08,param_04,param_05,level.aud.envs["veh_drive_vol"]);
			var_0A = soundscripts\_audio::deprecated_aud_map_range(var_08,param_04,param_05,level.aud.envs["veh_idle_vol"]);
			param_02 scalevolume(var_09,0.1);
			param_01 scalevolume(var_09,0.1);
			param_03 scalevolume(var_0A,0.1);
			var_07 = var_08;
			wait(0.1);
		}
	}
}

//Function Number: 11
aud_create_drive_envs()
{
	level.aud.envs["veh_drive_vol"] = [[0,0],[0.05,0.1],[0.1,0.1],[0.2,0.2],[0.3,0.3],[0.4,0.4],[0.5,0.5],[0.6,0.6],[0.8,0.8],[1,1]];
	level.aud.envs["veh_idle_vol"] = [[0,1],[0.05,0.85],[0.1,0.6],[0.2,0.5],[0.3,0.4],[0.4,0.1],[0.5,0],[0.6,0],[0.8,0],[1,0]];
}

//Function Number: 12
aud_ground_veh_deathwatch(param_00,param_01,param_02,param_03)
{
	if(isdefined(self))
	{
		self waittill("death");
		param_00 notify("instance_killed");
		thread aud_fade_loop_out_and_delete_temp(param_01,5);
		thread aud_fade_loop_out_and_delete_temp(param_02,5);
		thread aud_fade_loop_out_and_delete_temp(param_03,5);
	}
}

//Function Number: 13
aud_tank_fire_watch()
{
	self endon("death");
	if(isdefined(self))
	{
		for(;;)
		{
			self waittill("weapon_fired");
			var_00 = randomfloatrange(0.2,0.4);
			thread common_scripts\utility::play_sound_in_space("us_tank_big_boom",self.origin);
			thread common_scripts\utility::play_sound_in_space("us_tank_fire_dist",self.origin);
			thread common_scripts\utility::play_sound_in_space("us_tank_fire_close",self.origin);
			thread common_scripts\utility::play_sound_in_space("us_tank_fire_hi_ring",self.origin);
			thread common_scripts\utility::play_sound_in_space("us_tank_fire_lfe",self.origin);
			wait(0.2);
			thread common_scripts\utility::play_sound_in_space("us_tank_dist_verb",self.origin);
			wait(var_00);
		}
	}
}

//Function Number: 14
aud_fade_loop_out_and_delete_temp(param_00,param_01)
{
	param_00 scalevolume(0,param_01);
	wait(param_01 + 0.05);
	param_00 stoploopsound();
	wait(0.05);
	param_00 delete();
}