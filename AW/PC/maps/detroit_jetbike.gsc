/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: detroit_jetbike.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 299 ms
 * Timestamp: 4/22/2024 2:27:58 AM
*******************************************************************/

//Function Number: 1
spawn_exit_jetbike()
{
	level.jetbike = getent("player_jetbike_exit","targetname");
}

//Function Number: 2
handle_glass_collisions()
{
	self endon("death");
	level endon("missionfailed");
	for(;;)
	{
		var_00 = self.origin + anglestoforward(self.angles) * 125;
		glassradiusdamage(var_00,100,1000,600);
		wait 0.05;
	}
}

//Function Number: 3
handle_contact_collisions()
{
	self endon("death");
	level endon("missionfailed");
	vehicle_scripts\_jetbike::non_player_contact_watcher();
}

//Function Number: 4
vehicle_rubberband(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = param_01 * 0.5;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(!isdefined(self.rubberband_settings))
	{
		self.rubberband_settings = spawnstruct();
		var_07 = 1;
	}
	else
	{
		var_07 = 0;
	}

	self.rubberband_settings.target = param_00;
	self.rubberband_settings.desired_range = param_01;
	self.rubberband_settings.min_speed_ips = param_03 * 17.6;
	self.rubberband_settings.range_slop = param_02;
	self.rubberband_settings.time_constant = param_04;
	self.rubberband_settings.fail_range = param_05;
	self.rubberband_settings.fail_time = param_06;
	if(var_07)
	{
		thread vehicle_rubberband_think();
	}
}

//Function Number: 5
vehicle_rubberband_stop()
{
	self.rubberband_settings = undefined;
	self notify("vehicle_rubberband_stop");
}

//Function Number: 6
vehicle_rubberband_set_min_speed(param_00)
{
	self.rubberband_settings.min_speed_ips = param_00 * 17.6;
}

//Function Number: 7
vehicle_rubberband_set_desired_range(param_00)
{
	self.rubberband_settings.desired_range = param_00;
}

//Function Number: 8
vehicle_rubberband_set_fail_range(param_00,param_01)
{
	self.rubberband_settings.fail_range = param_00;
	self.rubberband_settings.fail_time = param_01;
}

//Function Number: 9
vehicle_rubberband_think()
{
	self endon("death");
	self endon("vehicle_rubberband_stop");
	var_00 = self.rubberband_settings.desired_range;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = self.rubberband_settings.target maps\_shg_utility::get_differentiated_speed();
	while(isdefined(self.rubberband_settings.target))
	{
		var_06 = self.origin - self.rubberband_settings.target.origin;
		var_07 = vectornormalize(anglestoforward(self.angles) + anglestoforward(self.rubberband_settings.target.angles) + vectornormalize(var_06));
		var_08 = vectordot(var_06,var_07);
		if(abs(var_08 - self.rubberband_settings.desired_range) < self.rubberband_settings.range_slop)
		{
			var_00 = var_08;
		}
		else
		{
			var_00 = self.rubberband_settings.desired_range;
		}

		var_09 = var_08 - var_00;
		var_0A = self.rubberband_settings.time_constant;
		var_0B = self.rubberband_settings.target maps\_shg_utility::get_differentiated_speed();
		var_05 = maps\_utility::linear_interpolate(0.9,var_0B,var_05);
		var_0C = var_05;
		var_0C = var_0C - var_09 / var_0A;
		var_0C = max(var_0C,self.rubberband_settings.min_speed_ips);
		var_0D = var_0C / 17.6;
		self vehicle_setspeed(var_0D,60,60);
		if(isdefined(self.rubberband_settings.fail_range))
		{
			maps\_utility::add_extra_autosave_check("jetbike_check_trailing",::autosave_jetbike_check_trailing,"trailing too far behind the friendly jetbike.");
			maps\_utility::add_extra_autosave_check("jetbike_check_too_slow",::autosave_jetbike_check_too_slow,"player\'s jetbike is moving too slowly");
			level.jetbike_too_slow = var_0B < self.rubberband_settings.min_speed_ips;
			if(var_08 > self.rubberband_settings.fail_range)
			{
				level.jetbike_is_trailing = 1;
				var_01 = var_01 + 0.05;
				if(!var_02)
				{
					if(!var_02 && !var_03)
					{
						thread show_fail_range_hint_1();
						var_03 = 1;
						var_02 = 1;
					}

					if(!var_02 && !var_04)
					{
						thread show_fail_range_hint_2();
						var_04 = 1;
						var_02 = 1;
					}
				}
			}
			else
			{
				level.jetbike_is_trailing = 0;
				var_01 = 0;
				var_02 = 0;
			}

			if(var_01 > self.rubberband_settings.fail_time)
			{
				fail_out_of_range();
			}

			continue;
		}

		maps\_utility::remove_extra_autosave_check("jetbike_check_trailing");
		wait 0.05;
	}

	vehicle_rubberband_stop();
}

//Function Number: 10
autosave_jetbike_check_trailing()
{
	return !level.jetbike_is_trailing;
}

//Function Number: 11
autosave_jetbike_check_too_slow()
{
	return !level.jetbike_too_slow;
}

//Function Number: 12
show_fail_range_hint_1()
{
	level.burke maps\_utility::dialogue_queue("det_brk_mitchellkeepup");
}

//Function Number: 13
show_fail_range_hint_2()
{
	level.burke maps\_utility::dialogue_queue("det_brk_keepgoing");
}

//Function Number: 14
fail_out_of_range()
{
	level notify("exit_drive_failed");
	setdvar("ui_deadquote",&"DETROIT_OBJECTIVE_FAIL_JETBIKE");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 15
intro_drive_jetbike_lights_friendlies()
{
	thread intro_drive_jetbike_lights("jetbike_lights","jetbike_lights_dim");
}

//Function Number: 16
intro_drive_jetbike_lights_player()
{
	common_scripts\utility::flag_set("jetbike_dynfx_on");
	intro_drive_jetbike_lights("det_dyn_spotlight_jetbike","det_dyn_spotlight_jetbike_dim");
}

//Function Number: 17
intro_drive_jetbike_lights(param_00,param_01)
{
	if(common_scripts\utility::flag("exit_drive_started") == 1)
	{
		var_02 = maps\_shg_utility::play_fx_with_handle(param_00,self,"tag_headlight");
	}

	common_scripts\utility::flag_wait("open_massive_door");
	var_02 = maps\_shg_utility::play_fx_with_handle(param_00,self,"tag_headlight");
	maps\_shg_design_tools::waittill_trigger_with_name("jetbike_lights_off1");
	maps\_shg_utility::kill_fx_with_handle(var_02);
	common_scripts\utility::flag_clear("jetbike_dynfx_on");
	thread maps\detroit_lighting::turn_off_light_bright();
}

//Function Number: 18
intro_drive_jetbike_lights_red(param_00)
{
	var_01 = maps\_shg_utility::play_fx_with_handle(param_00,self,"TAG_LIGHT_BACK_MID");
	maps\_shg_design_tools::waittill_trigger_with_name("move_burke_ahead");
	maps\_shg_utility::kill_fx_with_handle(var_01);
}