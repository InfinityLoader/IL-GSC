/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\so_aud.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 285 ms
 * Timestamp: 10/27/2023 2:31:04 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	maps\_audio::func_1314(::so_msg_handler);
	thread func_3F03(param_00);
}

//Function Number: 2
func_3F03(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	switch(param_00)
	{
		case "so_nyse_ny_manhattan":
			func_3F05();
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
			var_03 thread func_3F09();
			break;

		case "so_ied_wave4_littlebird":
			var_04 = param_01;
			var_04 thread common_scripts\utility::play_loop_sound_on_entity("so_littlebird_move_distant");
			var_04 thread func_3F09();
			break;

		case "so_ied_wave3_tank":
			var_05 = param_01;
			var_05 thread aud_run_tank_system();
			break;

		case "so_paris_start_jeep":
			var_06 = param_01;
			thread maps\_audio_vehicles::vm_start_preset("so_paris_jeep_01","so_paris_jeep",var_06,2);
			break;

		case "so_nyse_littlebird_spawn":
			var_03 = param_01;
			var_03 common_scripts\utility::play_loop_sound_on_entity("so_nymn_littlebird_move");
			break;

		case "so_start_harbor_player_hind":
			var_07 = param_01;
			var_07 common_scripts\utility::play_loop_sound_on_entity("so_hind_player");
			break;

		case "so_harbor_ally_helis":
			var_08 = param_01;
			foreach(var_03 in var_08)
			{
				var_03 thread common_scripts\utility::play_loop_sound_on_entity("so_hind_allies");
			}
			break;

		case "so_harbor_kill_helis":
			var_08 = param_01;
			foreach(var_03 in var_08)
			{
				var_03 common_scripts\utility::stop_loop_sound_on_entity("so_hind_allies");
			}
			break;

		case "so_start_harbor_exit_hind":
			var_0D = param_01;
			var_0D common_scripts\utility::play_loop_sound_on_entity("so_exit_hind_player");
			break;

		case "so_harbor_enemy_chopper_flyover":
			var_0E = param_01;
			var_0E maps\_utility::play_sound_on_entity("so_sub_hind_flyover");
			break;

		case "so_sub_missile_launch":
			var_0F = param_01;
			func_3F06(var_0F);
			break;

		default:
			var_02 = 0;
			break;
	}

	return var_02;
}

//Function Number: 4
func_3F05()
{
	maps\_audio_dynamic_ambi::func_1067("fire_wood_med",(-945,-2847,262),"steff_01",1000,1);
	maps\_audio_dynamic_ambi::func_1067("fire_wood_med",(-1181,-2926,55),"steff_02",1000,1);
	maps\_audio_dynamic_ambi::func_1067("fire_wood_med_tight",(-1004,-2927,42),"steff_03",1000,1);
	maps\_audio_dynamic_ambi::func_1067("fire_crackle_med_tight",(-902,-2716,66),"steff_04",1000,1);
	maps\_audio_dynamic_ambi::func_1067("fire_wood_med_tight",(-909,-2636,36),"steff_05",1000,1);
	maps\_audio_dynamic_ambi::func_1067("fire_wood_med",(-686,-2120,91),"steff_car",1000,1);
	common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight",(-141,271,2));
	common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight",(-259,579,2));
	common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight",(-475,980,10));
	common_scripts\utility::play_loopsound_in_space("road_flare_lp_tight",(-704,311,-7));
	maps\_audio_dynamic_ambi::func_1067("fire_crackle_med_tight",(-471,1856,-22),"pre_stock_01",1000,1);
}

//Function Number: 5
func_3F06(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(level.aud.var_3F07))
	{
		level.aud.var_3F07 = 0;
	}

	var_01 = maps\_audio_zone_manager::azm_get_current_zone();
	if((var_01 == "nyhb_sub_interior_controlroom" || var_01 == "nyhb_sub_interior_missileroom2") && !level.aud.var_3F07)
	{
		level.aud.var_3F07 = 1;
		maps\_audio::func_12F4();
		level.player seteq("grondo3d",0,0,"lowpass",0,400,2);
		level.player seteq("norestrict2d",0,0,"lowpass",0,400,2);
		level.player seteqlerp(1,0);
		thread func_3F08();
	}

	wait 0.05;
	param_00 playsound("russian_sub_missile_launch");
	wait 1.25;
	param_00 playsound("russian_sub_missile_launch_boom");
}

//Function Number: 6
func_3F08()
{
	for(;;)
	{
		var_00 = maps\_audio_zone_manager::azm_get_current_zone();
		if(var_00 != "nyhb_sub_interior_controlroom" && var_00 != "nyhb_sub_interior_missileroom2")
		{
			maps\_audio::func_12F6();
			level.player deactivateeq(0,"grondo3d",0);
			level.player deactivateeq(0,"norestrict2d",0);
			level.aud.var_3F07 = 0;
			return;
		}

		level.player seteqlerp(1,0);
		wait 0.1;
	}
}

//Function Number: 7
func_3F09()
{
	level.aud.var_3F0A = (0,0,0);
	self waittill("deathspin");
	thread func_3F0B();
	thread common_scripts\utility::play_loop_sound_on_entity("so_littlebird_helicopter_dying_loop");
	common_scripts\utility::waittill_either("death","crash_done");
	thread common_scripts\utility::play_sound_in_space("so_littlebird_helicopter_crash",level.aud.var_3F0A);
}

//Function Number: 8
func_3F0B()
{
	self endon("death");
	for(;;)
	{
		if(isdefined(self))
		{
			self.origin = level.aud.var_3F0A;
			wait 0.05;
		}
	}
}

//Function Number: 9
aud_run_tank_system()
{
	func_3F0D("ied_tank_01","us_tank_treads_lp_02","us_tank_move_low_lp","us_tank_idle_lp");
	func_3F12();
}

//Function Number: 10
func_3F0D(param_00,param_01,param_02,param_03)
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
		wait 0.3;
		func_3F0E(var_07,var_04,var_05,var_06,1,5,var_08);
	}
}

//Function Number: 11
func_3F0E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
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
			var_08 = maps\_audio::aud_smooth(var_07,var_08,0.1);
			var_09 = maps\_audio::aud_map_range(var_08,param_04,param_05,level.aud.envs["veh_drive_vol"]);
			var_0A = maps\_audio::aud_map_range(var_08,param_04,param_05,level.aud.envs["veh_idle_vol"]);
			param_02 scalevolume(var_09,0.1);
			param_01 scalevolume(var_09,0.1);
			param_03 scalevolume(var_0A,0.1);
			var_07 = var_08;
			wait 0.1;
		}
	}
}

//Function Number: 12
aud_create_drive_envs()
{
	level.aud.envs["veh_drive_vol"] = [[0,0],[0.05,0.1],[0.1,0.1],[0.2,0.2],[0.3,0.3],[0.4,0.4],[0.5,0.5],[0.6,0.6],[0.8,0.8],[1,1]];
	level.aud.envs["veh_idle_vol"] = [[0,1],[0.05,0.85],[0.1,0.6],[0.2,0.5],[0.3,0.4],[0.4,0.1],[0.5,0],[0.6,0],[0.8,0],[1,0]];
}

//Function Number: 13
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

//Function Number: 14
func_3F12()
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
			wait 0.2;
			thread common_scripts\utility::play_sound_in_space("us_tank_dist_verb",self.origin);
			wait var_00;
		}
	}
}

//Function Number: 15
aud_fade_loop_out_and_delete_temp(param_00,param_01)
{
	param_00 scalevolume(0,param_01);
	wait param_01 + 0.05;
	param_00 stoploopsound();
	wait 0.05;
	param_00 delete();
}