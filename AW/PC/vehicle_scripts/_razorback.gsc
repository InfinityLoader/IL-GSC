/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _razorback.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 544 ms
 * Timestamp: 4/22/2024 2:05:29 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("razorback",param_00,param_01,param_02);
	if(issubstr(param_02,"simple"))
	{
		maps\_vehicle::build_localinit(::init_local_simple);
	}
	else
	{
		maps\_vehicle::build_localinit(::init_local);
	}

	maps\_vehicle::build_deathfx("vfx/explosion/rocket_explosion_default",undefined,"explo_metal_rand");
	maps\_vehicle::build_rocket_deathfx("vfx/explosion/rocket_explosion_default","tag_deathfx","apache_helicopter_crash",undefined,undefined,undefined,undefined,1,undefined,0,5);
	maps\_vehicle::build_treadfx_override_tags(param_02,["thrusterCenter_TL_FX","thrusterCenter_TR_FX","thrusterCenter_BL_FX","thrusterCenter_BR_FX"]);
	maps\_vehicle::build_treadfx_override_get_surface_function(param_02,::razor_surface_override_function);
	maps\_vehicle::build_treadfx(param_02,"default","vfx/treadfx/razorback_tread_smk_idle_runner");
	maps\_vehicle::build_treadfx(param_02,"default_regular","vfx/treadfx/razorback_tread_smk_regular_runner");
	maps\_vehicle::build_treadfx(param_02,"default_strong","vfx/treadfx/razorback_tread_smk_strong_runner");
	maps\_vehicle::build_treadfx(param_02,"default_idle","vfx/treadfx/razorback_tread_smk_idle_runner");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	maps\_vehicle::build_is_helicopter();
	build_misc_anims(param_02);
	vehicle_scripts\_razorback_fx::main();
	setdvar("razorback_debug",0);
	maps\_vehicle::build_missile_launcher("razor_missile_launcher","launcherhatch","projectile_rpg7","rpg_guided",::missile_door_open,::missile_door_close);
}

//Function Number: 2
set_attached_models()
{
}

//Function Number: 3
build_misc_anims(param_00)
{
	if(!isdefined(level.vehicle_anim_array))
	{
		level.vehicle_anim_array = [];
	}

	if(!isdefined(level.vehicle_anim_array[param_00]))
	{
		level.vehicle_anim_array[param_00] = [];
	}

	level.vehicle_anim_array[param_00][0] = [];
	level.vehicle_anim_array[param_00][0]["rotate_root"] = %razorback_root_wl;
	level.vehicle_anim_array[param_00][0]["rotate_anim"] = %razorback_wing_left_rot;
	level.vehicle_anim_array[param_00][0]["nozzle_root"] = %razorback_root_wl_nozzle;
	level.vehicle_anim_array[param_00][0]["nozzle_anim"] = %razorback_wing_left_nozzle;
	level.vehicle_anim_array[param_00][0]["socket_root"] = %razorback_root_wl_socket;
	level.vehicle_anim_array[param_00][0]["socket_anim"] = %razorback_wing_left_socket;
	level.vehicle_anim_array[param_00][0]["thruster_fx_tag"] = "thrusterCenter_TL_FX";
	level.vehicle_anim_array[param_00][1] = [];
	level.vehicle_anim_array[param_00][1]["rotate_root"] = %razorback_root_wr;
	level.vehicle_anim_array[param_00][1]["rotate_anim"] = %razorback_wing_right_rot;
	level.vehicle_anim_array[param_00][1]["nozzle_root"] = %razorback_root_wr_nozzle;
	level.vehicle_anim_array[param_00][1]["nozzle_anim"] = %razorback_wing_right_nozzle;
	level.vehicle_anim_array[param_00][1]["socket_root"] = %razorback_root_wr_socket;
	level.vehicle_anim_array[param_00][1]["socket_anim"] = %razorback_wing_right_socket;
	level.vehicle_anim_array[param_00][1]["thruster_fx_tag"] = "thrusterCenter_TR_FX";
	level.vehicle_anim_array[param_00][2] = [];
	level.vehicle_anim_array[param_00][2]["rotate_root"] = %razorback_root_bl;
	level.vehicle_anim_array[param_00][2]["rotate_anim"] = %razorback_base_left_rot;
	level.vehicle_anim_array[param_00][2]["nozzle_root"] = %razorback_root_bl_nozzle;
	level.vehicle_anim_array[param_00][2]["nozzle_anim"] = %razorback_base_left_nozzle;
	level.vehicle_anim_array[param_00][2]["thruster_fx_tag"] = "thrusterCenter_BL_FX";
	level.vehicle_anim_array[param_00][3] = [];
	level.vehicle_anim_array[param_00][3]["rotate_root"] = %razorback_root_br;
	level.vehicle_anim_array[param_00][3]["rotate_anim"] = %razorback_base_right_rot;
	level.vehicle_anim_array[param_00][3]["nozzle_root"] = %razorback_root_br_nozzle;
	level.vehicle_anim_array[param_00][3]["nozzle_anim"] = %razorback_base_right_nozzle;
	level.vehicle_anim_array[param_00][3]["thruster_fx_tag"] = "thrusterCenter_BR_FX";
	level.vehicle_anim_array[param_00][4] = [];
	level.vehicle_anim_array[param_00][4]["rotate_root"] = %razorback_root_tl;
	level.vehicle_anim_array[param_00][4]["rotate_anim"] = %razorback_tail_left_rot;
	level.vehicle_anim_array[param_00][5] = [];
	level.vehicle_anim_array[param_00][5]["rotate_root"] = %razorback_root_tr;
	level.vehicle_anim_array[param_00][5]["rotate_anim"] = %razorback_tail_right_rot;
}

//Function Number: 4
set_vehicle_anims(param_00)
{
	return param_00;
}

//Function Number: 5
setanims()
{
	var_00 = [];
	for(var_01 = 0;var_01 < 9;var_01++)
	{
		var_00[var_01] = spawnstruct();
	}

	var_00[0].sittag = "tag_driver";
	var_00[0].idle = %razor_copilot_idle;
	var_00[0].death_no_ragdoll = 1;
	var_00[0].bhasgunwhileriding = 0;
	var_00[1].sittag = "tag_passenger";
	var_00[1].idle = %razor_copilot_idle;
	var_00[1].death_no_ragdoll = 1;
	var_00[1].bhasgunwhileriding = 0;
	var_00[2].sittag = "tag_guy0";
	var_00[2].idle = %lab_chopper_evac_hover_idle_npc;
	var_00[2].death_no_ragdoll = 1;
	var_00[3].sittag = "tag_guy1";
	var_00[3].idle = %lab_chopper_evac_hover_idle_npc;
	var_00[3].death_no_ragdoll = 1;
	var_00[4].sittag = "tag_guy2";
	var_00[4].idle = %lab_chopper_evac_hover_idle_npc;
	var_00[4].death_no_ragdoll = 1;
	var_00[5].sittag = "tag_guy3";
	var_00[5].idle = %lab_chopper_evac_hover_idle_npc;
	var_00[5].death_no_ragdoll = 1;
	var_00[6].sittag = "tag_guy4";
	var_00[6].idle = %lab_chopper_evac_hover_idle_npc;
	var_00[6].death_no_ragdoll = 1;
	var_00[7].sittag = "tag_guy5";
	var_00[7].idle = %lab_chopper_evac_hover_idle_npc;
	var_00[7].death_no_ragdoll = 1;
	var_00[8].sittag = "tag_guy6";
	var_00[8].idle = %lab_chopper_evac_hover_idle_npc;
	var_00[8].death_no_ragdoll = 1;
	return var_00;
}

//Function Number: 6
init_local()
{
	handle_vehicle_ai();
	self.missile_target_onscreen_guys_first = 1;
	self.dontdisconnectpaths = 1;
	self.script_badplace = 0;
	self.enablerocketdeath = 1;
	wait(0.05);
	maps\_vehicle::vehicle_lights_on("running");
	while(is_playing_scripted_anim())
	{
		wait 0.05;
	}

	thread update_calculations();
	self.thrusters_angle_goal = [];
	self.thrusters_angle_current = [];
	self.thrusters_fx_amount = [];
	self setanim(%razorback_idle,1,0,1);
	thread vehicle_scripts\_razorback_fx::vfx_rb_thruster_front_light_on(self);
	thread vehicle_scripts\_razorback_fx::play_regular_tail_thruster_rz(self);
	thread vehicle_scripts\_razorback_fx::vfx_red_lights_on();
	thread init_thruster("thruster_TL");
	thread init_thruster("thruster_TR");
	thread init_thruster("thruster_BL");
	thread init_thruster("thruster_BR");
	thread init_thruster("thruster_KL");
	thread init_thruster("thruster_KR");
	thread update_thrusters();
}

//Function Number: 7
init_local_simple()
{
	self.dontdisconnectpaths = 1;
	self.script_badplace = 0;
	self.enablerocketdeath = 1;
	wait(0.05);
	maps\_vehicle::vehicle_lights_on("running");
}

//Function Number: 8
razor_surface_override_function(param_00,param_01)
{
	var_02 = 0;
	if(param_01 == "thrusterCenter_TL_FX")
	{
		var_02 = 0;
	}
	else if(param_01 == "thrusterCenter_TR_FX")
	{
		var_02 = 1;
	}
	else if(param_01 == "thrusterCenter_BL_FX")
	{
		var_02 = 2;
	}
	else if(param_01 == "thrusterCenter_BR_FX")
	{
		var_02 = 3;
	}

	if(!isdefined(self.thrusters_fx_amount) || !isdefined(self.thrusters_fx_amount[var_02]))
	{
		return param_00;
	}

	return "default_" + self.thrusters_fx_amount[var_02];
}

//Function Number: 9
set_forced_target(param_00,param_01)
{
	vehicle_scripts\_vehicle_multiweapon_util::set_forced_target(param_00,param_01);
}

//Function Number: 10
disable_firing(param_00)
{
	vehicle_scripts\_vehicle_multiweapon_util::disable_firing(param_00);
}

//Function Number: 11
enable_firing(param_00)
{
	vehicle_scripts\_vehicle_multiweapon_util::enable_firing(param_00);
}

//Function Number: 12
disable_tracking(param_00)
{
	vehicle_scripts\_vehicle_multiweapon_util::disable_tracking(param_00);
}

//Function Number: 13
enable_tracking(param_00)
{
	vehicle_scripts\_vehicle_multiweapon_util::enable_tracking(param_00);
}

//Function Number: 14
launchers_enable_threat_grenade_response()
{
	vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response(1,-2);
}

//Function Number: 15
launchers_disable_threat_grenade_response()
{
	vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response(0,-2);
}

//Function Number: 16
enable_threat_grenade_response()
{
	vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response(1,-1);
}

//Function Number: 17
disable_threat_grenade_response()
{
	vehicle_scripts\_vehicle_multiweapon_util::set_threat_grenade_response(0,-1);
}

//Function Number: 18
fire_missles_at_target_array(param_00)
{
	vehicle_scripts\_vehicle_missile_launcher_ai::fire_missles_at_target_array(param_00);
}

//Function Number: 19
handle_vehicle_ai()
{
	disable_tracking();
	thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_target(1.5);
	thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_shoot(3,5,0.15,5);
	thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_default_ai();
	setup_missile_launchers();
}

//Function Number: 20
setup_missile_launchers()
{
	self.missiletags = [];
	self.missiletagsready = [];
	self.missiletags[0] = "TAG_MISSILE_1";
	self.missiletags[1] = "TAG_MISSILE_2";
	self.missiletags[2] = "TAG_MISSILE_3";
	self.missiletags[3] = "TAG_MISSILE_4";
	self.missiletags[4] = "TAG_MISSILE_5";
	self.missiletags[5] = "TAG_MISSILE_6";
	thread vehicle_scripts\_vehicle_missile_launcher_ai::reload_launchers();
}

//Function Number: 21
missile_door_open()
{
	self setanimknobrestart(%razorback_launcher_hatch_open,0.9,0);
	self setanimlimited(%razorback_root_launcher_hatch,1,0);
	wait(getanimlength(%razorback_launcher_hatch_open));
}

//Function Number: 22
missile_door_close()
{
	self setanimlimited(%razorback_root_launcher_hatch,0.01,0.5);
	wait(getanimlength(%razorback_launcher_hatch_open));
}

//Function Number: 23
is_playing_scripted_anim()
{
	return isdefined(self._animactive) && self._animactive > 0;
}

//Function Number: 24
get_field_from_array(param_00,param_01)
{
	return level.vehicle_anim_array[self.classname][param_00][param_01];
}

//Function Number: 25
init_thruster(param_00)
{
	self endon("death");
	var_01 = get_tag_index_from_tag_name(param_00);
	self.thrusters_angle_current[var_01] = 0;
	self.thrusters_angle_goal[var_01] = 0;
}

//Function Number: 26
update_thrusters()
{
	self endon("death");
	for(;;)
	{
		if(!is_playing_scripted_anim())
		{
			for(var_00 = 0;var_00 < self.thrusters_angle_goal.size;var_00++)
			{
				if(isdefined(self.debug_controls))
				{
				}
				else
				{
					var_01 = get_angle_from_speed(var_00,0);
					var_02 = get_angle_mod_from_horiz_speed(var_00);
					var_03 = get_angle_mod_from_yaw_diff(var_00);
					var_04 = var_01 + -90 - var_01 * var_02;
					var_04 = var_04 + -90 - var_04 * var_03;
					self.thrusters_angle_goal[var_00] = var_04;
					var_05 = get_nozzle_opening_from_speed(var_00,self.thrusters_angle_goal[var_00]);
					update_nozzle_opening(var_00,var_05);
				}

				self.thrusters_angle_goal[var_00] = clamp(self.thrusters_angle_goal[var_00],-90,0);
				update_thruster_angle(var_00);
			}
		}

		wait(0.05);
	}
}

//Function Number: 27
get_tag_index_from_tag_name(param_00)
{
	if(param_00 == "thruster_TL")
	{
		return 0;
	}

	if(param_00 == "thruster_TR")
	{
		return 1;
	}

	if(param_00 == "thruster_BL")
	{
		return 2;
	}

	if(param_00 == "thruster_BR")
	{
		return 3;
	}

	if(param_00 == "thruster_KL")
	{
		return 4;
	}

	if(param_00 == "thruster_KR")
	{
		return 5;
	}
}

//Function Number: 28
play_thruster_rotation(param_00,param_01)
{
	var_02 = get_field_from_array(param_00,"rotate_root");
	param_01 = clamp(param_01,0,1);
	var_03 = get_field_from_array(param_00,"rotate_anim");
	var_04 = 0.05;
	if(param_00 == 4)
	{
		var_04 = 0.2;
	}

	self setanimknoblimited(var_03,1,0,1);
	self setanimtime(var_03,1);
	if(param_01 == 0)
	{
		self setanimlimited(var_02,0.01,var_04,1);
		return;
	}

	self setanimlimited(var_02,param_01,var_04,1);
}

//Function Number: 29
update_thruster_angle(param_00)
{
	var_01 = self.thrusters_angle_goal[param_00];
	var_02 = self.thrusters_angle_current[param_00];
	if(!is_float_equal(var_02,var_01))
	{
		if(abs(var_01 - var_02) < 6)
		{
			self.thrusters_angle_current[param_00] = var_01;
		}
		else if(var_02 > var_01)
		{
			self.thrusters_angle_current[param_00] = self.thrusters_angle_current[param_00] - 6;
		}
		else
		{
			self.thrusters_angle_current[param_00] = self.thrusters_angle_current[param_00] + 6;
		}

		play_thruster_rotation(param_00,self.thrusters_angle_current[param_00] / -90);
	}
}

//Function Number: 30
update_nozzle_opening(param_00,param_01)
{
	var_02 = get_field_from_array(param_00,"nozzle_root");
	var_03 = get_field_from_array(param_00,"nozzle_anim");
	var_04 = get_field_from_array(param_00,"thruster_fx_tag");
	var_05 = undefined;
	var_06 = undefined;
	if(isdefined(var_02))
	{
		self setanimknoblimited(var_03,1,0,1);
		self setanimtime(var_03,1);
		if(param_01 == 0)
		{
			self setanimlimited(var_02,0.01,0.05,1);
		}
		else
		{
			self setanimlimited(var_02,param_01,0.05,1);
		}

		var_05 = self.thrusters_fx_amount[param_00];
		if(param_01 < 0.01)
		{
			var_06 = "idle";
		}
		else if(param_01 > 0.5)
		{
			var_06 = "strong";
		}
		else
		{
			var_06 = "regular";
		}

		if(!isdefined(var_05) || var_05 != var_06)
		{
			self.thrusters_fx_amount[param_00] = var_06;
			self notify("killfx_" + var_04);
			vehicle_scripts\_razorback_fx::play_thruster_amount_given_tag(param_00,var_06,var_04);
		}
	}
}

//Function Number: 31
is_float_equal(param_00,param_01)
{
	var_02 = 0.1;
	return abs(param_00 - param_01) < var_02;
}

//Function Number: 32
get_angle_mod_from_yaw_diff(param_00)
{
	var_01 = 0;
	var_02 = self.yaw_per_sec_calc;
	if(var_02 < -1)
	{
		if(param_00 == 5)
		{
			var_01 = interp_with_clamp(var_02,-2,-1,1,0);
		}
	}

	if(var_02 < -1.5)
	{
		if(param_00 == 4)
		{
			var_01 = interp_with_clamp(var_02,-2,-1.5,-1,0);
		}
	}

	if(var_02 > 1)
	{
		if(param_00 == 4)
		{
			var_01 = interp_with_clamp(var_02,0.75,1.75,0,1);
		}
	}

	if(var_02 > 1.5)
	{
		if(param_00 == 5)
		{
			var_01 = interp_with_clamp(var_02,1.5,2,0,-1);
		}
	}

	return var_01;
}

//Function Number: 33
get_angle_mod_from_horiz_speed(param_00)
{
	var_01 = 0;
	var_02 = self.horiz_speed_calc;
	if(var_02 < -10)
	{
		if(param_00 == 0)
		{
			var_01 = interp_with_clamp(var_02,-100,-10,1,0);
		}
		else if(param_00 == 2)
		{
			var_01 = interp_with_clamp(var_02,-100,-10,1,0);
		}
	}

	if(var_02 > 10)
	{
		if(param_00 == 1)
		{
			var_01 = interp_with_clamp(var_02,10,100,0,1);
		}
		else if(param_00 == 3)
		{
			var_01 = interp_with_clamp(var_02,10,100,0,1);
		}
	}

	return var_01;
}

//Function Number: 34
get_angle_from_speed(param_00,param_01)
{
	if(param_00 == 4)
	{
		return 0;
	}

	if(param_00 == 5)
	{
		return 0;
	}

	return interp_with_clamp(self.speed_calc,13,20 + param_01,-90,0);
}

//Function Number: 35
get_nozzle_opening_from_speed(param_00,param_01)
{
	if(param_00 == 4)
	{
		return 0;
	}
	else if(param_00 == 5)
	{
		return 0;
	}

	if(param_01 < -70)
	{
		return 1;
	}

	if(param_00 == 0)
	{
		return interp_with_clamp(self.speed_calc,10,15,1,0.25);
	}

	if(param_00 == 1)
	{
		return interp_with_clamp(self.speed_calc,10,15,1,0.25);
	}

	if(param_00 == 2)
	{
		return interp_with_clamp(self.speed_calc,10,15,1,0.75);
	}

	if(param_00 == 3)
	{
		return interp_with_clamp(self.speed_calc,10,15,1,0.75);
	}
}

//Function Number: 36
interp_with_clamp(param_00,param_01,param_02,param_03,param_04)
{
	if(param_00 <= param_01)
	{
		return param_03;
	}

	if(param_00 > param_02)
	{
		return param_04;
	}

	var_05 = param_04 - param_03 / param_02 - param_01;
	var_06 = var_05 * param_00 - param_01 + param_03;
	return var_06;
}

//Function Number: 37
model_speed_to_mph(param_00)
{
	return param_00 / 63360 * 60 * 60;
}

//Function Number: 38
update_calculations()
{
	self endon("death");
	var_00 = self.origin;
	var_01 = self.angles;
	for(;;)
	{
		var_02 = self.origin - var_00;
		var_03 = self.angles - var_01;
		self.yaw_per_sec_calc = var_03[1];
		self.velocity_calc = var_02 / 0.05;
		self.speed_calc = model_speed_to_mph(length(self.velocity_calc));
		var_04 = anglestoright(self.angles);
		var_05 = (var_04[0],var_04[1],0);
		var_06 = (self.velocity_calc[0],self.velocity_calc[1],0);
		var_07 = vectordot(var_06,var_05);
		self.horiz_speed_calc = var_07;
		var_00 = self.origin;
		var_01 = self.angles;
		wait 0.05;
	}
}