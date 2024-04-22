/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _pdrone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 68
 * Decompile Time: 995 ms
 * Timestamp: 4/22/2024 2:05:12 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	precachemodel(param_00);
	maps\_utility::set_console_status();
	setup_pdrone_type(param_02);
	level._effect["pdrone_death_explosion"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
	level._effect["pdrone_large_death_explosion"] = loadfx("vfx/explosion/vehicle_pdrone_large_explosion");
	level._effect["pdrone_emp_death"] = loadfx("vfx/explosion/vehicle_pdrone_explosion");
	level._effect["emp_drone_damage"] = loadfx("vfx/sparks/emp_drone_damage");
	level._effect["pdrone_smoke_trail"] = loadfx("vfx/trail/trail_drone_fire_smk_sm_runner_1");
	level._effect["drone_muzzle_flash"] = loadfx("vfx/muzzleflash/pdrone_flash_wv");
	level._effect["drone_fan_distortion"] = loadfx("vfx/distortion/drone_fan_distortion");
	level._effect["drone_fan_distortion_large"] = loadfx("vfx/distortion/drone_fan_distortion_large");
	level._effect["drone_thruster_distortion"] = loadfx("vfx/distortion/drone_thruster_distortion");
	level._effect["drone_beacon_red"] = loadfx("vfx/lights/light_drone_beacon_red");
	level._effect["drone_beacon_red_fast"] = loadfx("vfx/lights/light_drone_beacon_red_fast");
	level._effect["drone_beacon_blue_fast"] = loadfx("vfx/lights/light_drone_beacon_blue_fast");
	level._effect["drone_beacon_red_slow_nolight"] = loadfx("vfx/lights/light_drone_beacon_red_slow_nolight");
	level._effect["drone_beacon_blue_slow_nolight"] = loadfx("vfx/lights/light_drone_beacon_blue_slow_nolight");
	level._effect["drone_beacon_red_sm_nolight"] = loadfx("vfx/lights/light_drone_beacon_red_sm_nolight");
	level.scr_animtree["personal_drone"] = #animtree;
	level.scr_model["personal_drone"] = param_00;
	level.scr_anim["personal_drone"]["drone_deploy_crouch_to_crouch"] = %drone_deploy_crouch_to_crouch;
	level.scr_anim["personal_drone"]["drone_deploy_crouch_to_run"] = %drone_deploy_crouch_to_run;
	level.scr_anim["personal_drone"]["drone_deploy_run_to_run"] = %drone_deploy_run_to_run;
	level.scr_anim["personal_drone"]["drone_deploy_run_to_stand"] = %drone_deploy_run_to_stand;
	level.scr_anim["personal_drone"]["personal_drone_folded_idle"][0] = %personal_drone_folded_idle;
	setup_buddy_drone_deploy_anims();
	var_03 = "pdrone";
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	maps\_vehicle::build_template(var_03,param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_drive(%atlas_assault_drone_lage_rotors,undefined,0);
	maps\_vehicle::build_deathquake(0.4,0.8,1024);
	maps\_vehicle::build_life(level.pdrone_parms[param_02]["health"]);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_mainturret();
	var_04 = randomfloatrange(0,1);
	var_05 = param_02;
	maps\_vehicle::build_is_helicopter();
}

//Function Number: 2
setup_buddy_drone_deploy_anims()
{
	level.scr_anim["generic"]["drone_deploy_crouch_to_crouch"] = %drone_deploy_crouch_to_crouch_guy;
	level.scr_anim["generic"]["drone_deploy_crouch_to_run"] = %drone_deploy_crouch_to_run_guy;
	level.scr_anim["generic"]["drone_deploy_run_to_run"] = %drone_deploy_run_to_run_guy;
	level.scr_anim["generic"]["drone_deploy_run_to_stand"] = %drone_deploy_run_to_stand_guy;
}

//Function Number: 3
setup_pdrone_type(param_00)
{
	if(!isdefined(level.pdrone_parms))
	{
		level.pdrone_parms = [];
	}

	if(isdefined(level.pdrone_parms[param_00]))
	{
		return;
	}

	level.pdrone_parms[param_00] = [];
	level.pdrone_parms[param_00]["health"] = 110;
	level.pdrone_parms[param_00]["speed"] = 45;
	level.pdrone_parms[param_00]["accel"] = 50;
	level.pdrone_parms[param_00]["decel"] = 50;
	level.pdrone_parms[param_00]["hover_radius"] = 0;
	level.pdrone_parms[param_00]["hover_speed"] = 0;
	level.pdrone_parms[param_00]["hover_accel"] = 0;
	level.pdrone_parms[param_00]["pitchmax"] = 60;
	level.pdrone_parms[param_00]["rollmax"] = 60;
	level.pdrone_parms[param_00]["angle_vel_pitch"] = 90;
	level.pdrone_parms[param_00]["angle_vel_yaw"] = 120;
	level.pdrone_parms[param_00]["angle_vel_roll"] = 90;
	level.pdrone_parms[param_00]["angle_accel"] = 400;
	level.pdrone_parms[param_00]["yaw_speed"] = 180;
	level.pdrone_parms[param_00]["yaw_accel"] = 250;
	level.pdrone_parms[param_00]["yaw_decel"] = 100;
	level.pdrone_parms[param_00]["yaw_over"] = 0.1;
	level.pdrone_parms[param_00]["axial_move"] = 0;
	level.pdrone_parms[param_00]["weap_fire_tags"] = ["tag_flash"];
	level.pdrone_parms[param_00]["clear_look"] = 1;
}

//Function Number: 4
drone_parm(param_00)
{
	return level.pdrone_parms[self.classname][param_00];
}

//Function Number: 5
init_class_motion(param_00,param_01,param_02)
{
	self sethoverparams(drone_parm("hover_radius"),drone_parm("hover_speed"),drone_parm("hover_accel"));
	self setmaxpitchroll(drone_parm("pitchmax"),drone_parm("rollmax"));
	var_03 = drone_parm("speed");
	var_04 = drone_parm("accel");
	var_05 = drone_parm("decel");
	if(isdefined(param_00))
	{
		var_03 = param_00;
	}

	if(isdefined(param_01))
	{
		var_04 = param_01;
	}

	if(isdefined(param_02))
	{
		var_05 = param_02;
	}

	self vehicle_setspeed(var_03,var_04,var_05);
	self vehicle_helicoptersetmaxangularvelocity(drone_parm("angle_vel_pitch"),drone_parm("angle_vel_yaw"),drone_parm("angle_vel_roll"));
	self vehicle_helicoptersetmaxangularacceleration(drone_parm("angle_accel"));
	self setneargoalnotifydist(5);
	self setyawspeed(drone_parm("yaw_speed"),drone_parm("yaw_accel"),drone_parm("yaw_decel"),drone_parm("yaw_over"));
	self setaxialmove(drone_parm("axial_move"));
}

//Function Number: 6
init_local()
{
	self endon("death");
	self.originheightoffset = distance(self gettagorigin("tag_origin"),self gettagorigin("tag_ground"));
	self.script_badplace = 0;
	self.dontdisconnectpaths = 1;
	self.vehicle_heli_default_path_speeds = ::init_class_motion;
	if(tactical_picker_enabled())
	{
		init_class_motion();
	}

	if(self.script_team == "allies")
	{
		thread maps\_vehicle::vehicle_lights_on("friendly");
		self.contents = self setcontents(0);
	}
	else
	{
		thread maps\_vehicle::vehicle_lights_on("hostile");
		self.ignore_death_fx = 1;
		self.script_crashtypeoverride = "pdrone";
	}

	maps\_utility::ent_flag_init("sentient_controlled");
	maps\_utility::ent_flag_init("fire_disabled");
	if(tactical_picker_enabled())
	{
		self.time_before_move = 0;
		self.time_before_attack = 0;
		self.attack_available = 0;
		self.flock_goal_position = (0,0,0);
		self.flock_goal_offset = (0,0,0);
	}

	self.stun_duration = 0;
	self.playing_hit_reaction = 0;
	if(should_play_animations())
	{
		setup_pdrone_animations();
	}

	vehicle_scripts\_pdrone_threat_sensor::build_threat_data();
	waittillframeend;
	self.emp_death_function = ::pdrone_emp_death;
	maps\_utility::add_damage_function(::pdrone_damage_function);
	thread maps\_damagefeedback::monitordamage();
	self.custom_death_script = ::handle_death;
	var_00 = 0;
	if(isdefined(self.script_parameters) && self.script_parameters == "expendable")
	{
		var_00 = 1;
	}

	if(self.script_team != "allies")
	{
		self enableaimassist();
		thread maps\_shg_utility::make_emp_vulnerable();
	}

	if(isdefined(self.script_parameters) && self.script_parameters == "diveboat_weapon_target")
	{
		target_set(self,(0,0,0));
		target_hidefromplayer(self,level.player);
	}
	else if(self.classname != "script_vehicle_pdrone_kva")
	{
		target_set(self,(0,0,0));
		target_setjavelinonly(self,1);
	}

	thread pdrone_ai(var_00);
	thread pdrone_flying_fx();
	self notify("stop_kicking_up_dust");
	thread handle_pdrone_audio();
}

//Function Number: 7
handle_pdrone_audio()
{
	self endon("death");
	var_00 = spawnstruct();
	var_00.preset_name = "pdrone_atlas";
	var_01 = ::vehicle_scripts\_pdrone_aud::snd_pdrone_atlas_constructor;
	if(issubstr(self.classname,"pdrone_atlas_large"))
	{
		var_00.preset_name = "pdrone_atlas";
		var_01 = ::vehicle_scripts\_pdrone_aud::snd_pdrone_atlas_constructor;
	}
	else if(issubstr(self.classname,"pdrone_atlas"))
	{
		var_00.preset_name = "pdrone_atlas";
		var_01 = ::vehicle_scripts\_pdrone_aud::snd_pdrone_atlas_constructor;
	}
	else if(isdefined(level.script) && level.script == "greece")
	{
		var_00.preset_name = "pdrone_swarm";
		var_01 = ::vehicle_scripts\_pdrone_aud::snd_pdrone_swarm_constructor;
	}

	soundscripts\_snd::snd_message("snd_register_vehicle",var_00.preset_name,var_01);
	soundscripts\_snd::snd_message("snd_start_vehicle",var_00);
}

//Function Number: 8
pdrone_ai(param_00)
{
	self endon("death");
	self makeentitysentient(self.script_team,param_00);
	self setmaxpitchroll(drone_parm("pitchmax"),drone_parm("rollmax"));
	if(isdefined(self.owner))
	{
		thread pdrone_movement_follow_buddy();
		thread attack_if_buddy_killed();
	}

	thread vehicle_scripts\_pdrone_threat_sensor::pdrone_update_threat_sensor();
	thread pdrone_targeting();
}

//Function Number: 9
pdrone_flying_fx()
{
	self endon("death");
	var_00 = 0.3;
	if(self.classname == "script_vehicle_pdrone_atlas" || self.classname == "script_vehicle_pdrone_atlas_lab")
	{
		playfxontag(common_scripts\utility::getfx("drone_fan_distortion"),self,"TAG_FX_FAN_L");
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("drone_fan_distortion"),self,"TAG_FX_FAN_R");
	}

	if(self.classname == "script_vehicle_pdrone_atlas_large")
	{
		playfxontag(common_scripts\utility::getfx("drone_fan_distortion_large"),self,"TAG_FX_FAN_L");
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("drone_fan_distortion_large"),self,"TAG_FX_FAN_R");
	}

	if(self.classname != "script_vehicle_pdrone_atlas" && self.classname != "script_vehicle_pdrone_atlas_lab")
	{
		playfxontag(common_scripts\utility::getfx("drone_thruster_distortion"),self,"TAG_FX_THRUSTER_L");
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("drone_thruster_distortion"),self,"TAG_FX_THRUSTER_R");
	}

	if(self.script_team == "axis")
	{
		if(self.classname == "script_vehicle_pdrone_atlas_lab")
		{
			playfxontag(common_scripts\utility::getfx("drone_beacon_red_sm_nolight"),self,"TAG_FX_BEACON_0");
			playfxontag(common_scripts\utility::getfx("drone_beacon_red_sm_nolight"),self,"TAG_FX_BEACON_1");
			return;
		}

		playfxontag(common_scripts\utility::getfx("drone_beacon_red"),self,"TAG_FX_BEACON_0");
		wait(var_00);
		playfxontag(common_scripts\utility::getfx("drone_beacon_red"),self,"TAG_FX_BEACON_1");
		wait(var_00);
		playfxontag(common_scripts\utility::getfx("drone_beacon_red"),self,"TAG_FX_BEACON_2");
	}
}

//Function Number: 10
attack_if_buddy_killed()
{
	self endon("death");
	self.owner waittill("death",var_00);
	if(!isdefined(var_00))
	{
		self delete();
		return;
	}

	thread flying_attack_drone_logic();
}

//Function Number: 11
pdrone_movement_follow_buddy()
{
	self.owner endon("pdrone_returning");
	self.owner endon("death");
	self endon("death");
	if(self.script_team == "allies")
	{
		self sethoverparams(20,20,20);
		self.goalradius = 64;
	}
	else
	{
		self sethoverparams(0,0,0.05);
		self.goalradius = 8;
	}

	self vehicle_setspeed(20,20,20);
	self setyawspeedbyname("faster");
	thread pdrone_movement_follow();
	for(;;)
	{
		self.owner waittill("pdrone_defend_point",var_00);
		thread pdrone_movement_go_to_point(var_00);
	}
}

//Function Number: 12
pdrone_movement_follow()
{
	self notify("change_movement_type");
	self endon("change_movement_type");
	self.owner endon("pdrone_returning");
	self.owner endon("death");
	self endon("death");
	var_00 = 0.2;
	if(isplayer(self.owner))
	{
		var_01 = (1,5,3);
		var_02 = (-50,130,90);
	}
	else
	{
		var_01 = (1,64,10);
		var_02 = (-60,0,95);
	}

	wait(randomfloat(var_00));
	var_03 = 0;
	var_04 = self.origin;
	var_05 = self.origin;
	var_06 = self.origin;
	var_07 = 0;
	var_08 = (0,0,0);
	var_09 = 0;
	var_0A = 0;
	var_0B = self.origin;
	var_0C = 0.05;
	if(level.currentgen)
	{
		var_0C = 0.25;
	}

	for(;;)
	{
		var_09 = var_09 + var_0C;
		var_07 = var_07 + var_0C;
		if(var_07 > 2)
		{
			var_07 = 0;
			var_08 = (randomfloatrange(-0.5,0.5) * var_01[0],randomfloatrange(-0.5,0.5) * var_01[1],randomfloatrange(-0.5,0.5) * var_01[2]);
		}

		var_06 = transformmove(self.owner.origin,self.owner.angles,(0,0,0),(0,var_03,0),var_02 + var_08,(0,0,0))["origin"];
		if(distance(var_06,var_05) > 16)
		{
			if(var_09 > var_00)
			{
				if(var_0A > 0.5 && common_scripts\utility::cointoss())
				{
					var_0D = 1;
					var_0E = vectornormalize(self.owner.origin - self.origin);
					var_0F = vectorcross(var_0E,(0,0,1));
					var_10 = self.origin + var_0F * randomfloatrange(-1,1) * 256;
				}
				else
				{
					var_0D = 0;
					var_10 = var_07;
				}

				if(pdrone_can_move_to_point(self.origin,var_10) && pdrone_can_see_owner_from_point(var_10))
				{
					var_0A = 0;
					var_05 = var_10;
					var_04 = var_10;
				}
				else
				{
					var_0A = var_0A + var_09;
					var_11 = randomfloat(1) + randomfloat(1) - 1;
					var_03 = angleclamp(angleclamp180(var_03) * 0.5 + var_11 * 250);
				}

				var_09 = 0;
			}
		}
		else
		{
			var_04 = var_06;
			var_0A = 0;
		}

		if(var_0A > 3)
		{
			if(!level.player maps\_utility::point_in_fov(var_06) && !level.player maps\_utility::point_in_fov(self.origin) && pdrone_can_see_owner_from_point(var_06) && pdrone_can_teleport_to_point(var_06))
			{
				self vehicle_teleport(var_06,self.angles);
				var_04 = var_06;
				var_05 = var_06;
			}
		}

		self setvehgoalpos(var_04,1);
		wait(var_0C);
	}
}

//Function Number: 13
pdrone_can_move_to_point(param_00,param_01)
{
	param_01 = param_01 + vectornormalize(param_01 - param_00) * 32;
	param_00 = param_00 + (0,0,-24);
	param_01 = param_01 + (0,0,-24);
	var_02 = playerphysicstrace(param_00,param_01);
	var_03 = distancesquared(var_02,param_01) < 0.01;
	return var_03;
}

//Function Number: 14
pdrone_can_teleport_to_point(param_00)
{
	var_01 = param_00 + (0,0,12);
	var_02 = playerphysicstrace(var_01,param_00);
	var_03 = distancesquared(var_02,param_00) < 0.01;
	return var_03;
}

//Function Number: 15
pdrone_can_see_owner_from_point(param_00)
{
	var_01 = self.owner geteye();
	var_02 = sighttracepassed(param_00,var_01,0,self);
	return var_02;
}

//Function Number: 16
pdrone_movement_go_to_point(param_00)
{
	self notify("change_movement_type");
	self endon("change_movement_type");
	self.owner endon("pdrone_returning");
	self.owner endon("death");
	self endon("death");
	var_01 = 110;
	var_02 = param_00["position"] + var_01 * param_00["normal"];
	self setvehgoalpos(var_02,1);
	self.owner common_scripts\utility::waittill_any_timeout(10,"stop_pdrone_pov");
	thread pdrone_movement_follow();
}

//Function Number: 17
pdrone_targeting(param_00)
{
	self notify("pdrone_targeting");
	self endon("pdrone_targeting");
	if(isdefined(self.owner))
	{
		self.owner endon("pdrone_returning");
	}

	self endon("death");
	self endon("emp_death");
	var_01 = "axis";
	if(self.script_team == "axis")
	{
		var_01 = "allies";
		if(isdefined(self.mgturret))
		{
			foreach(var_03 in self.mgturret)
			{
				var_03.script_team = "axis";
			}
		}
	}

	for(;;)
	{
		wait(0.05);
		if(isdefined(self.drone_threat_data.threat))
		{
			self setlookatent(self.drone_threat_data.threat);
			thread pdrone_fire_at_enemy(self.drone_threat_data.threat,param_00);
			self.drone_threat_data.threat common_scripts\utility::waittill_any_timeout(5,"death","target_lost");
			continue;
		}

		if(drone_parm("clear_look"))
		{
			self clearlookatent();
		}

		if(isdefined(self.owner))
		{
			self settargetyaw(self.owner.angles[1]);
		}
	}
}

//Function Number: 18
calculate_lateral_move_accuracy(param_00)
{
	var_01 = param_00.origin - self.origin * (1,1,0);
	var_01 = vectornormalize(var_01);
	var_01 = (var_01[1],var_01[0] * -1,0);
	var_02 = abs(vectordot(var_01,param_00 getvelocity()));
	var_02 = clamp(var_02,0,250) / 250;
	var_02 = 1 - var_02;
	var_02 = clamp(var_02,0.5,1);
	return var_02;
}

//Function Number: 19
calculate_stance_accuracy(param_00)
{
	if(param_00 getstance() == "crouch")
	{
		return 0.75;
	}
	else if(param_00 getstance() == "prone")
	{
		return 0.5;
	}

	return 1;
}

//Function Number: 20
calculate_player_wounded_accuracy(param_00)
{
	if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return 0.5;
	}

	return 1;
}

//Function Number: 21
calculate_aim_offset(param_00,param_01,param_02)
{
	var_03 = self.origin - param_00.origin;
	var_03 = var_03 * (1,1,0);
	var_03 = vectornormalize(var_03);
	if(isplayer(param_00))
	{
		param_01 = param_01 * calculate_lateral_move_accuracy(param_00);
		param_01 = param_01 * calculate_stance_accuracy(param_00);
		param_01 = param_01 * calculate_player_wounded_accuracy(param_00);
	}

	var_04 = vectorcross(var_03,(0,0,1));
	var_04 = vectornormalize(var_04);
	var_05 = var_04 * 8 / param_01 * randomfloatrange(-1,1);
	var_06 = (0,0,8) / param_01 * randomfloatrange(-1,1);
	if(isdefined(param_02) && param_02)
	{
	}

	return var_05 + var_06;
}

//Function Number: 22
fire_burst(param_00,param_01,param_02,param_03,param_04)
{
	param_01 endon("death");
	self endon("death");
	self endon("emp_death");
	self endon("pdrone_targeting");
	while(param_00 > 0)
	{
		var_05 = 1;
		if(isplayer(param_01))
		{
			var_06 = min(self.drone_threat_data.threat_visible_time,15) / 15;
			var_05 = maps\_utility::linear_interpolate(var_06,0.15,0.8);
		}

		if(isdefined(self.attack_accuracy))
		{
			var_05 = var_05 * self.attack_accuracy;
		}

		var_07 = calculate_aim_offset(param_01,var_05,0);
		self.current_aim_offset = var_07;
		var_08 = param_02 + var_07;
		var_09 = self.origin;
		if(self gettagindex(param_03) != -1)
		{
			var_09 = self gettagorigin(param_03);
		}

		var_0A = param_01.origin + var_08 - var_09;
		var_0A = vectornormalize(var_0A);
		if(pdrone_could_be_friendly_fire(var_09,var_09 + var_0A * 10000))
		{
			param_01 notify("target_lost");
			return;
		}

		pdrone_fire_weapon(var_09,param_01.origin + var_08);
		param_00 = param_00 - param_04;
		wait(param_04);
	}
}

//Function Number: 23
pdrone_fire_at_enemy(param_00,param_01)
{
	param_00 endon("death");
	self endon("death");
	self endon("emp_death");
	self endon("pdrone_targeting");
	if(isdefined(self.owner))
	{
		self.owner endon("pdrone_returning");
	}

	self notify("new_target");
	self endon("new_target");
	var_02 = param_00 geteye() - param_00.origin;
	var_03 = (0,0,var_02[2]);
	var_04 = 0.095;
	if(!isdefined(param_01))
	{
		param_01 = 0.25;
	}

	var_05 = param_01 * 0.8;
	var_06 = param_01 * 1.2;
	if(level.currentgen)
	{
		var_04 = 0.2499;
		var_05 = var_05 * 2.5;
		var_06 = var_06 * 2.5;
	}

	var_07 = calculate_aim_offset(param_00,1,0);
	var_08 = var_03 + var_07;
	for(;;)
	{
		self setturrettargetent(param_00,var_08);
		var_09 = self.origin;
		var_0A = drone_parm("weap_fire_tags");
		var_0B = var_0A[0];
		if(self gettagindex(var_0B) != -1)
		{
			var_09 = self gettagorigin(var_0B);
		}

		if(self.playing_hit_reaction || self.stun_duration > 0 || pdrone_could_be_friendly_fire(var_09,param_00.origin + var_08) || !isdefined(self.drone_threat_data.threat) || self.drone_threat_data.threat != param_00)
		{
			param_00 notify("target_lost");
			return;
		}

		if(tactical_picker_enabled())
		{
			if(isdefined(self.attack_available) && !self.attack_available)
			{
				wait(0.05);
				continue;
			}

			if(length(self vehicle_getvelocity()) > 1)
			{
				wait(0.05);
				continue;
			}

			if(isdefined(self.attack_sight_required) && self.attack_sight_required && !sighttracepassed(var_09,param_00 geteye(),0,self,param_00))
			{
				self.attack_available = 0;
				wait(0.05);
				continue;
			}
		}

		var_0C = randomfloatrange(2,3);
		while(var_0C > 0)
		{
			if(self.playing_hit_reaction || self.stun_duration > 0)
			{
				break;
			}

			var_0D = randomfloatrange(var_05,var_06);
			var_0D = min(var_0D,var_0C);
			fire_burst(var_0D,param_00,var_03,var_0B,var_04);
			var_0C = var_0C - var_0D;
			if(tactical_picker_enabled())
			{
				self.attack_available = 0;
				wait(0.05);
				break;
			}

			var_0E = randomfloatrange(0.5,1);
			var_0E = min(var_0E,var_0C);
			if(var_0E > 0)
			{
				var_0C = var_0C - var_0E;
				wait(var_0E);
			}
		}
	}
}

//Function Number: 24
pdrone_fire_weapon(param_00,param_01)
{
	self notify("weapon_fired");
	playfxontag(level._effect["drone_muzzle_flash"],self,"tag_flash");
	magicbullet("pdrone_turret",param_00,param_01);
}

//Function Number: 25
anglessubtract(param_00,param_01)
{
	return (angleclamp180(param_00[0] - param_01[0]),angleclamp180(param_00[1] - param_01[1]),angleclamp180(param_00[2] - param_01[2]));
}

//Function Number: 26
pdrone_could_be_friendly_fire(param_00,param_01)
{
	if(self.script_team == "axis")
	{
		return 0;
	}

	return maps\_utility::shot_endangers_any_player(param_00,param_01);
}

//Function Number: 27
pdrone_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_01) && isdefined(param_01.script_team) && self.script_team == param_01.script_team)
	{
		return;
	}

	if(isdefined(param_01) && isdefined(param_01.classname) && param_01.classname == "worldspawn")
	{
		self.health = int(min(self.maxhealth,self.health + param_00));
		return;
	}

	self.last_damage_attacker = param_01;
	self.last_damage_direction_vec = param_02;
	self.last_damage_point = param_03;
	if(param_04 == "MOD_ENERGY")
	{
		self dodamage(param_00 * 4,param_01.origin,param_01);
	}
	else if(isalive(self) && isdefined(param_01) && !isplayer(param_01))
	{
		self.health = int(min(self.maxhealth,self.health + param_00 * 0.7));
	}

	if(should_play_animations())
	{
		play_hit_reaction();
	}
}

//Function Number: 28
play_death_explosion_fx()
{
	if(self.classname == "script_vehicle_pdrone_atlas_large")
	{
		playfx(common_scripts\utility::getfx("pdrone_large_death_explosion"),self gettagorigin("tag_origin"));
		soundscripts\_snd::snd_message("pdrone_death_explode");
		return;
	}

	playfx(common_scripts\utility::getfx("pdrone_death_explosion"),self gettagorigin("tag_origin"));
	soundscripts\_snd::snd_message("pdrone_death_explode");
}

//Function Number: 29
handle_death()
{
	if(!isdefined(self))
	{
		return;
	}

	self.crashing = 1;
	if(self.script_team != "allies" && !isdefined(self.owner) && isdefined(self.last_damage_attacker) && randomfloat(1) < 0.4)
	{
		var_00 = randomintrange(0,3);
		switch(var_00)
		{
			case 0:
				death_crash_nearby_player(self.last_damage_attacker);
				break;

			case 1:
				thread death_spiral(self.last_damage_attacker);
				break;

			case 2:
				thread death_rocket_out_of_control(self.last_damage_attacker);
				break;
		}
	}
	else
	{
		play_death_explosion_fx();
	}

	if(isdefined(self))
	{
		self notify("crash_done");
		self delete();
	}
}

//Function Number: 30
pdrone_emp_death()
{
	self endon("death");
	self endon("in_air_explosion");
	self notify("emp_death");
	self.vehicle_stays_alive = 1;
	var_00 = self vehicle_getvelocity();
	var_01 = 60;
	if(isdefined(level.get_pdrone_crash_location_override))
	{
		var_02 = [[ level.get_pdrone_crash_location_override ]]();
	}
	else
	{
		var_03 = (self.origin[0] + var_01[0] * 10,self.origin[1] + var_01[1] * 10,self.origin[2] - 2000);
		var_02 = physicstrace(self.origin,var_03);
	}

	self notify("newpath");
	self notify("deathspin");
	thread drone_deathspin();
	var_04 = 60;
	self vehicle_setspeed(var_04,60,1000);
	self setneargoalnotifydist(var_01);
	self setvehgoalpos(var_02,0);
	thread drone_emp_crash_movement(var_02,var_01,var_04);
	common_scripts\utility::waittill_any("goal","near_goal");
	self notify("stop_crash_loop_sound");
	self notify("crash_done");
	play_death_explosion_fx();
	self delete();
}

//Function Number: 31
drone_deathspin()
{
	level.scr_animtree["pdrone_dummy"] = #animtree;
	level.scr_anim["pdrone_dummy"]["roll_left"][0] = %rotate_x_l;
	level.scr_anim["pdrone_dummy"]["roll_right"][0] = %rotate_x_r;
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 linkto(self);
	if(isdefined(self.death_model_override))
	{
		var_00 setmodel(self.death_model_override);
	}
	else
	{
		var_00 setmodel(self.model);
	}

	self hide();
	stopfxontag(common_scripts\utility::getfx("drone_beacon_red"),self,"tag_origin");
	playfxontag(common_scripts\utility::getfx("emp_drone_damage"),var_00,"TAG_ORIGIN");
	var_00.animname = "pdrone_dummy";
	var_00 maps\_utility::assign_animtree();
	if(common_scripts\utility::cointoss())
	{
		var_01 = "roll_left";
	}
	else
	{
		var_01 = "roll_right";
	}

	var_00 thread maps\_anim::anim_loop_solo(var_00,var_01);
	self waittill("death");
	var_00 delete();
}

//Function Number: 32
drone_emp_crash_movement(param_00,param_01,param_02)
{
	self endon("crash_done");
	self clearlookatent();
	self setmaxpitchroll(180,180);
	self setyawspeed(400,100,100);
	self setturningability(1);
	var_03 = 1400;
	var_04 = 800;
	var_05 = undefined;
	var_06 = 90 * randomintrange(-2,3);
	for(;;)
	{
		if(!isdefined(self))
		{
			break;
		}

		if(self.origin[2] < param_00[2] + param_01)
		{
			self notify("near_goal");
		}

		if(common_scripts\utility::cointoss())
		{
			var_05 = self.angles[1] - 300;
			self setyawspeed(var_03,var_04);
			self settargetyaw(var_05);
			self settargetyaw(var_05);
		}

		wait(0.05);
	}
}

//Function Number: 33
death_spiral(param_00)
{
	var_01 = spawn("script_model",self.origin);
	var_01.angles = self.angles;
	if(isdefined(self.death_model_override))
	{
		var_01 setmodel(self.death_model_override);
	}
	else
	{
		var_01 setmodel(self.model);
	}

	self hide();
	stopfxontag(common_scripts\utility::getfx("drone_beacon_red"),self,"tag_origin");
	playfxontag(common_scripts\utility::getfx("emp_drone_damage"),var_01,"TAG_ORIGIN");
	soundscripts\_snd::snd_message("pdrone_emp_death",var_01);
	var_02 = (self.origin[0],self.origin[1],self.origin[2] - 500);
	var_03 = physicstrace(self.origin,var_02);
	var_04 = 0;
	var_05 = 5;
	var_06 = param_00.origin - var_01.origin;
	var_06 = vectornormalize(var_06);
	var_07 = vectorcross((0,0,1),var_06);
	var_07 = vectornormalize(var_07);
	var_08 = 100;
	var_09 = var_01.origin + var_07 * var_08;
	var_0A = vectortoangles(var_01.origin - var_09);
	var_0B = 1;
	if(common_scripts\utility::cointoss())
	{
		var_0B = -1;
	}

	while(var_04 < 5)
	{
		wait(0.05);
		var_04 = var_04 + 0.05;
		var_0A = var_0A + (0,10,0) * var_0B;
		var_0C = maps\_utility::linear_interpolate(clamp(var_04 / 3,0,1),2,30);
		var_09 = var_09 - (0,0,var_0C);
		var_0D = var_09 + anglestoforward(var_0A) * var_08;
		var_0E = physicstrace(var_01.origin,var_0D,var_01);
		var_01.origin = var_0D;
		var_01.angles = var_01.angles + (0,50,0) * var_0B;
		var_0F = length(var_03 - var_01.origin);
		if(var_0F < 60 || var_01.origin[2] < var_03[2] + 15 || var_0E != var_0D)
		{
			break;
		}
	}

	playfx(common_scripts\utility::getfx("pdrone_death_explosion"),var_01.origin);
	soundscripts\_snd::snd_message("pdrone_crash_land",var_01.origin);
	var_01 delete();
}

//Function Number: 34
death_crash_nearby_player(param_00)
{
	self.vehicle_stays_alive = 1;
	var_01 = param_00.origin - self.origin;
	var_01 = vectornormalize(var_01);
	var_02 = vectorcross((0,0,1),var_01);
	var_02 = vectornormalize(var_02);
	if(common_scripts\utility::cointoss())
	{
		var_02 = var_02 * -1;
	}

	var_03 = param_00.origin - var_01 * (1,1,0) * 250 + var_02 * 250;
	var_03 = (var_03[0],var_03[1],self.origin[2]);
	var_04 = common_scripts\utility::randomvectorincone(vectornormalize(var_03 - self.origin),15);
	var_05 = self.origin + var_04 * 250;
	var_03 = physicstrace(self.origin,var_05);
	self notify("newpath");
	self notify("deathspin");
	self setneargoalnotifydist(60);
	self vehicle_helisetai(var_03,drone_parm("speed") * 0.75,drone_parm("accel"),drone_parm("decel"),undefined,undefined,0,0,0,0,0,0,0);
	common_scripts\utility::waittill_any("goal","near_goal");
	death_plummet();
	self notify("stop_crash_loop_sound");
	self notify("crash_done");
}

//Function Number: 35
death_plummet()
{
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 setmodel(self.model);
	self hide();
	if(!issubstr(self.classname,"_security"))
	{
		stopfxontag(common_scripts\utility::getfx("drone_beacon_red"),self,"tag_origin");
	}

	var_01 = 0;
	var_02 = self vehicle_getvelocity();
	var_03 = squared(0.05);
	var_04 = (0,0,-980);
	while(var_01 < 5)
	{
		wait(0.05);
		var_02 = var_04 * 0.05 + var_02;
		var_02 = vectorclamp(var_02,1000);
		var_05 = var_02 * 0.05 + var_04 * var_03 / 2;
		var_06 = var_00.origin + var_05;
		var_07 = physicstrace(var_00.origin,var_06,var_00);
		if(var_07 != var_06)
		{
			break;
		}

		var_00.origin = var_06;
		var_00.angles = var_00.angles + (0,5,0);
		var_01 = var_01 + 0.05;
	}

	playfx(common_scripts\utility::getfx("pdrone_death_explosion"),var_00.origin);
	soundscripts\_snd::snd_message("pdrone_crash_land",var_00.origin);
	var_00 delete();
}

//Function Number: 36
death_rocket_out_of_control(param_00)
{
	var_01 = self.origin;
	self hide();
	var_02 = 0;
	var_03 = 1;
	var_04 = 0;
	var_05 = 0;
	var_06 = level.player geteye() - var_01;
	var_07 = self.origin;
	var_08 = level.player.origin - self.origin;
	var_08 = vectornormalize(var_08);
	var_09 = var_08 * (1,1,0);
	var_0A = vectorcross((0,0,1),var_08);
	var_0A = vectornormalize(var_0A);
	var_0B = -5;
	if(common_scripts\utility::cointoss())
	{
		var_0A = var_0A * -1;
		var_0B = 5;
	}

	var_0C = var_0A;
	var_0D = var_07 + var_0C * 600 + (0,0,250);
	var_0E = var_07 + var_0C * 300 + (0,0,500);
	var_0F = common_scripts\utility::spawn_tag_origin();
	var_0F.origin = var_07;
	var_0F.parentorigin = var_07;
	var_0F.droneviewmodel = spawn("script_model",var_07);
	var_0F.droneviewmodel.angles = self.angles;
	var_0F.droneviewmodel setmodel(self.model);
	var_0F.velocity = (0,0,0);
	playfxontag(common_scripts\utility::getfx("pdrone_smoke_trail"),var_0F.droneviewmodel,"TAG_ORIGIN");
	thread rocketpositionupdate(var_01,level.player,var_0F,var_02,var_04,var_05);
	var_10 = 0;
	var_11 = 1 / var_03 * 20;
	var_12 = 0;
	var_13 = 0;
	var_14 = 0;
	while(var_12 <= 1)
	{
		wait(0.05);
		var_15 = squared(1 - var_10) * var_07 + 2 * var_10 * 1 - var_10 * var_0E + squared(var_10) * var_0D;
		var_16 = var_0F.parentorigin;
		var_0F.parentorigin = var_15;
		var_0F.velocity = var_0F.parentorigin - var_16;
		var_17 = physicstrace(var_16,var_0F.parentorigin,var_0F.droneviewmodel);
		if(var_17 != var_0F.parentorigin)
		{
			var_14 = 1;
			break;
		}

		var_18 = anglestoaxis(var_0F.droneviewmodel.angles);
		var_19 = var_18["forward"];
		var_1A = var_18["up"];
		var_1B = var_18["right"];
		var_19 = rotatepointaroundvector(var_09,var_19,var_0B);
		var_1A = rotatepointaroundvector(var_09,var_1A,var_0B);
		var_1B = rotatepointaroundvector(var_09,var_1B,var_0B);
		var_0F.droneviewmodel.angles = axistoangles(var_19,var_1B,var_1A);
		var_12 = var_12 + var_11;
		var_10 = squared(var_12);
		if(var_13)
		{
			break;
		}

		if(var_12 > 1)
		{
			var_12 = 1;
			var_13 = 1;
		}
	}

	var_0F notify("RocketPositionUpdate");
	var_1C = 0;
	var_1D = var_0F.velocity * 20;
	var_1E = squared(0.05);
	var_1F = (0,0,-980);
	while(var_1C < 5 && !var_14)
	{
		wait(0.05);
		var_1D = var_1F * 0.05 + var_1D;
		var_1D = vectorclamp(var_1D,1000);
		var_20 = var_1D * 0.05 + var_1F * var_1E / 2;
		var_21 = var_0F.droneviewmodel.origin + var_20;
		var_17 = physicstrace(var_0F.droneviewmodel.origin,var_21,var_0F.droneviewmodel);
		if(var_17 != var_21)
		{
			break;
		}

		var_0F.droneviewmodel.origin = var_21;
		var_1C = var_1C + 0.05;
	}

	playfx(common_scripts\utility::getfx("pdrone_death_explosion"),var_0F.droneviewmodel.origin);
	soundscripts\_snd::snd_message("pdrone_crash_land",var_0F.droneviewmodel.origin);
	var_0F.droneviewmodel delete();
	var_0F delete();
}

//Function Number: 37
rocketpositionupdate(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_02 endon("RocketPositionUpdate");
	var_06 = vectortoangles(param_01.origin - param_00);
	var_07 = param_03;
	var_08 = (0,0,0);
	if(common_scripts\utility::cointoss())
	{
		param_04 = param_04 * -1;
	}

	var_09 = param_05 / 5;
	var_0A = 0;
	for(;;)
	{
		wait(0.05);
		var_07 = var_07 + param_04;
		if(isdefined(param_02.tangent))
		{
			var_06 = vectortoangles(param_02.tangent);
		}

		var_08 = (0,0,1) * var_0A;
		var_0B = transformmove(param_02.parentorigin,var_06,(0,0,0),(0,0,var_07),var_08,(0,0,0));
		var_08 = var_0B["origin"];
		param_02.origin = vectorlerp(param_02.origin,var_08,0.5);
		param_02.droneviewmodel.origin = param_02.origin;
		var_0A = var_0A + var_09;
		var_0A = clamp(var_0A,0,param_05);
	}
}

//Function Number: 38
pdrone_ai_deploy(param_00)
{
	var_01 = param_00 maps\_utility::spawn_ai(1);
	var_01.animname = "generic";
	var_02 = common_scripts\utility::getstruct(param_00.target,"targetname");
	var_03 = spawn("script_origin",var_02.origin);
	var_03.angles = var_02.angles;
	var_04 = getent(var_02.target,"targetname");
	var_05 = 0;
	var_06 = undefined;
	switch(var_02.animation)
	{
		case "drone_deploy_crouch_to_crouch_guy":
			var_06 = "Cover Crouch";
			break;

		case "drone_deploy_crouch_to_run_guy":
			var_05 = 1;
			var_06 = "Cover Crouch";
			break;

		case "drone_deploy_run_to_run_guy":
			var_05 = 1;
			break;

		case "drone_deploy_run_to_stand_guy":
			break;

		default:
			break;
	}

	var_07 = getsubstr(var_02.animation,0,var_02.animation.size - 4);
	var_08 = spawn("script_model",var_01 gettagorigin("J_Spine4"));
	var_08 setmodel(var_04.model);
	var_09 = var_01 gettagangles("J_Spine4");
	var_08.angles = var_09;
	var_08 linkto(var_01,"J_Spine4",(-3.746,-9.852,-0.08),(0,0,90));
	var_08.animname = "personal_drone";
	var_08 useanimtree(level.scr_animtree["personal_drone"]);
	var_08 setanim(level.scr_anim["personal_drone"]["personal_drone_folded_idle"][0],1,0);
	var_01.ignoreall = 1;
	if(isdefined(var_06))
	{
		var_03 maps\_anim::anim_reach_and_approach_solo(var_01,var_07,undefined,var_06);
	}
	else
	{
		var_03 maps\_anim::anim_generic_reach(var_01,var_07);
	}

	var_03 maps\_anim::anim_generic_reach(var_01,var_07);
	if(isdefined(var_05) && var_05)
	{
		var_03 thread maps\_anim::anim_generic_run(var_01,var_07);
	}
	else
	{
		var_03 thread maps\_anim::anim_generic(var_01,var_07);
	}

	var_04.origin = var_08.origin;
	var_04.angles = var_08.angles;
	var_0A = var_04 maps\_utility::spawn_vehicle();
	if(isdefined(var_0A.target))
	{
		var_0B = 0;
	}
	else
	{
		var_0B = 1;
		var_0A.owner = var_01;
	}

	var_0A.pacifist = 1;
	var_08 delete();
	var_0A.animname = "personal_drone";
	var_03 maps\_anim::anim_single_solo(var_0A,var_07);
	var_0A.pacifist = undefined;
	var_01.ignoreall = 0;
	if(!var_0B)
	{
		var_0A maps\_vehicle::gopath();
	}

	return var_01;
}

//Function Number: 39
destroy_drones_when_nuked()
{
	self endon("death");
	for(;;)
	{
		if(getdvar("debug_nuke") == "on")
		{
			self dodamage(self.health + 99999,(0,0,-500),level.player);
		}

		wait(0.05);
	}
}

//Function Number: 40
flying_attack_drone_system_init()
{
	level.player_test_points = common_scripts\utility::getstructarray("player_test_point","targetname");
	level.drone_air_spaces = getentarray("drone_air_space","script_noteworthy");
	if(!isdefined(level.flying_attack_drones))
	{
		level.flying_attack_drones = [];
	}
}

//Function Number: 41
start_flying_attack_drones(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "flying_attack_drone";
	}

	var_01 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive(param_00);
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03))
		{
			var_03.my_debug_name = param_00;
			var_03 thread flying_attack_drone_logic();
		}
	}

	return var_01;
}

//Function Number: 42
start_flying_attack_drone(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "flying_attack_drone";
	}

	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_00);
	if(isdefined(var_01))
	{
		var_01.my_debug_name = param_00;
		var_01 thread flying_attack_drone_logic();
	}

	return var_01;
}

//Function Number: 43
init_drone_motion_old()
{
	if(tactical_picker_enabled())
	{
		return;
	}

	var_00 = undefined;
	if(!isdefined(self.script_airspeed))
	{
		var_00 = 40;
	}
	else
	{
		var_00 = self.script_airspeed;
	}

	self setneargoalnotifydist(30);
	self vehicle_setspeed(var_00,var_00 / 4,var_00 / 4);
}

//Function Number: 44
flying_attack_drone_logic(param_00)
{
	self notify("pdrone_flying_attack_drone_logic");
	self endon("pdrone_flying_attack_drone_logic");
	self endon("death");
	param_00 = self;
	param_00 childthread flying_attack_drone_damage_monitor();
	param_00 childthread flying_attack_drone_stun_monitor();
	param_00 thread flying_attack_drone_death_monitor();
	param_00 init_drone_motion_old();
	if(isdefined(param_00.target))
	{
		param_00 waittill("reached_dynamic_path_end");
	}

	if(tactical_picker_enabled())
	{
		param_00 childthread update_drone_tactical_movement();
	}
	else
	{
		param_00 childthread flying_attack_drone_move_think_old();
	}

	if(should_play_animations())
	{
		param_00 childthread idle_anim_update();
	}
}

//Function Number: 45
stop_scripted_move_and_attack()
{
	self.target = undefined;
	maps\_utility::vehicle_detachfrompath();
	thread flying_attack_drone_logic();
}

//Function Number: 46
tactical_picker_enabled()
{
	return isdefined(level.drone_tactical_picker_data) && isdefined(level.drone_tactical_picker_data.enabled);
}

//Function Number: 47
get_target_air_space(param_00)
{
	if(tactical_picker_enabled())
	{
		return level.drone_tactical_picker_data.target_air_space;
	}

	var_01 = common_scripts\utility::getclosest(param_00.origin,level.player_test_points);
	return getent(var_01.target,"targetname");
}

//Function Number: 48
flying_attack_drone_move_think_old()
{
	self endon("death");
	self endon("pdrone_flying_attack_drone_logic");
	if(!isdefined(level.drone_air_spaces))
	{
		return;
	}

	self.current_air_space = common_scripts\utility::getclosest(self.origin,level.drone_air_spaces);
	update_flying_attack_drone_goal_pos();
	self waittill("near_goal");
	wait(0.05);
	for(;;)
	{
		var_00 = maps\_utility::get_closest_player_healthy(self.origin);
		self setlookatent(var_00);
		var_01 = get_target_air_space(var_00);
		if(var_01 != self.current_air_space)
		{
			var_02 = get_next_air_space(self.current_air_space,var_01,level.drone_air_spaces);
			if(isdefined(var_02))
			{
				self.current_air_space = var_02;
			}
		}

		update_flying_attack_drone_goal_pos();
		self waittill("near_goal");
		if(var_01 == self.current_air_space)
		{
			wait_in_current_air_space();
			wait_for_hit_reaction();
		}
	}
}

//Function Number: 49
update_drone_tactical_movement()
{
	self endon("death");
	if(!isdefined(level.drone_air_spaces))
	{
		return;
	}

	self.current_air_space = common_scripts\utility::getclosest(self.origin,level.drone_air_spaces);
	update_flying_attack_drone_goal_pos();
	self waittill("near_goal");
	wait(0.05);
	for(;;)
	{
		var_00 = maps\_utility::get_closest_player_healthy(self.origin);
		self setlookatent(var_00);
		var_01 = level.drone_tactical_picker_data.target_air_space;
		if(var_01 != self.current_air_space)
		{
			if(randomfloat(1) > 0.5)
			{
				wait(randomfloat(1));
			}

			var_02 = get_next_air_space(self.current_air_space,var_01,level.drone_air_spaces);
			if(isdefined(var_02))
			{
				self.current_air_space = var_02;
			}
		}

		if(tactical_move_to_goal_pos())
		{
			self waittill("near_goal");
		}

		if(var_01 == self.current_air_space)
		{
			wait(0.05);
			wait_for_hit_reaction();
		}
	}
}

//Function Number: 50
wait_in_current_air_space()
{
	level endon("pdrone_wait_in_current_air_space");
	if(!tactical_picker_enabled())
	{
		wait(randomfloatrange(0.5,1.5));
		return;
	}

	var_00 = 0;
	if(tactical_picker_enabled())
	{
		if(randomfloat(1) < 0.25)
		{
			var_00 = randomfloatrange(1,2.5);
		}
		else
		{
			var_00 = randomfloatrange(0,1);
		}
	}

	var_01 = 0;
	while(var_01 < var_00)
	{
		wait(0.05);
		var_01 = var_01 + 0.05;
		if(self.current_air_space != level.drone_tactical_picker_data.target_air_space)
		{
			break;
		}
	}
}

//Function Number: 51
wait_for_hit_reaction()
{
	self endon("death");
	while(self.playing_hit_reaction || self.stun_duration > 0)
	{
		wait(0.05);
		self.stun_duration = self.stun_duration - 0.05;
	}
}

//Function Number: 52
calc_flock_goal_pos()
{
	var_00 = self.origin;
	if(!ispointinvolume(var_00,self.current_air_space))
	{
		var_00 = get_random_point_in_air_space(self.current_air_space);
	}
	else
	{
		var_01 = 0;
		var_02 = 0;
		var_03 = (0,0,0);
		var_04 = 0;
		var_05 = (0,0,0);
		foreach(var_07 in level.flying_attack_drones)
		{
			if(self != var_07 && isdefined(self.current_air_space) && isdefined(var_07.current_air_space))
			{
				if(self.current_air_space == var_07.current_air_space)
				{
					var_01++;
					var_08 = var_07.origin - self.origin;
					var_09 = length(var_08);
					if(var_09 < 90)
					{
						var_02++;
						var_03 = var_03 - 0.5 * 90 - var_09 * var_08 / var_09;
					}
					else if(var_09 > 150)
					{
						var_04++;
						var_05 = var_05 + 0.5 * var_09 - 150 * var_08 / var_09;
					}
				}
			}
		}

		if(var_01 > 0)
		{
			if(randomint(5) == 0)
			{
				var_00 = get_random_point_in_air_space(self.current_air_space);
			}
			else
			{
				if(var_02 > 0)
				{
					var_00 = var_00 + var_03 / var_02;
				}

				if(var_04 > 0)
				{
					var_00 = var_00 + var_05 / var_04;
				}
			}
		}
		else
		{
			var_00 = get_random_point_in_air_space(self.current_air_space);
		}
	}

	return var_00;
}

//Function Number: 53
get_tactical_goal_pos()
{
	if(self.current_air_space != level.drone_tactical_picker_data.target_air_space || !isdefined(self.current_goal_position) || !isdefined(self.current_goal_offset))
	{
		return get_random_point_in_air_space(self.current_air_space);
	}

	if(isdefined(self.dodge_position))
	{
		return self.dodge_position;
	}

	var_00 = self.current_goal_position + self.current_goal_offset;
	if(length(var_00 - self.origin) < 10)
	{
		return undefined;
	}

	return var_00;
}

//Function Number: 54
calculate_move_to_goal_yaw(param_00)
{
	if(isdefined(self.drone_look_at_entity))
	{
		return vectortoyaw(self.drone_look_at_entity.origin - param_00);
	}

	if(!isdefined(self.drone_threat_data) || !isdefined(self.drone_threat_data.threat))
	{
		var_01 = param_00 - self.origin;
		if(var_01 != (0,0,0))
		{
			return vectortoyaw(var_01);
		}

		return self.angles[1];
	}

	return undefined;
}

//Function Number: 55
tactical_move_to_goal_pos()
{
	var_00 = get_tactical_goal_pos();
	if(!isdefined(var_00))
	{
		return 0;
	}

	var_01 = calculate_move_to_goal_yaw(var_00);
	var_02 = undefined;
	if(isdefined(var_01))
	{
		var_02 = 1;
	}
	else
	{
		var_01 = self.angles[1];
	}

	self vehicle_helisetai(var_00,drone_parm("speed"),drone_parm("accel"),drone_parm("decel"),undefined,var_02,var_01,0,0,0,0,0,1);
	return 1;
}

//Function Number: 56
update_flying_attack_drone_goal_pos()
{
	if(tactical_picker_enabled())
	{
		tactical_move_to_goal_pos();
		return;
	}

	self setvehgoalpos(calc_flock_goal_pos(),1);
}

//Function Number: 57
get_random_point_in_air_space(param_00)
{
	for(var_01 = param_00 getpointinbounds(randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(-1,1));!ispointinvolume(var_01,param_00);var_01 = param_00 getpointinbounds(randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(-1,1)))
	{
	}

	return var_01;
}

//Function Number: 58
flying_attack_drone_damage_monitor()
{
	self endon("death");
	self.damagetaken = 0;
	self.istakingdamage = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(!isdefined(var_01) || !isplayer(var_01))
		{
			continue;
		}

		self notify("flying_attack_drone_damaged_by_player");
		thread flying_attack_drone_damage_update();
	}
}

//Function Number: 59
flying_attack_drone_damage_update()
{
	self notify("taking damage");
	self endon("taking damage");
	self endon("death");
	self.istakingdamage = 1;
	wait(1);
	self.istakingdamage = 0;
}

//Function Number: 60
flying_attack_drone_death_monitor()
{
	if(!isdefined(level.flying_attack_drones))
	{
		level.flying_attack_drones = [];
	}

	level.flying_attack_drones = common_scripts\utility::array_add(level.flying_attack_drones,self);
	common_scripts\utility::waittill_any("death","pdrone_flying_attack_drone_logic");
	level.flying_attack_drones = common_scripts\utility::array_remove(level.flying_attack_drones,self);
	level notify("flying_attack_drone_destroyed");
}

//Function Number: 61
get_linked_air_spaces(param_00,param_01)
{
	var_02 = [];
	var_03 = [];
	if(isdefined(param_00.script_linkto))
	{
		var_03 = strtok(param_00.script_linkto," ");
	}

	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_05 = 0;
		if(isdefined(param_01[var_04].script_linkname))
		{
			for(var_06 = 0;var_06 < var_03.size;var_06++)
			{
				if(param_01[var_04].script_linkname == var_03[var_06])
				{
					var_02[var_02.size] = param_01[var_04];
					var_05 = 1;
					break;
				}
			}
		}

		if(!var_05 && isdefined(param_01[var_04].script_linkto) && isdefined(param_00.script_linkname))
		{
			var_07 = strtok(param_01[var_04].script_linkto," ");
			for(var_06 = 0;var_06 < var_07.size;var_06++)
			{
				if(param_00.script_linkname == var_07[var_06])
				{
					var_02[var_02.size] = param_01[var_04];
					break;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 62
get_next_air_space(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = param_00;
	var_04 = [];
	foreach(var_06 in param_02)
	{
		var_06.g_score = 0;
	}

	param_00.f_score = param_00.g_score + distance(param_00.origin,param_01.origin);
	while(var_03.size > 0)
	{
		var_08 = undefined;
		var_09 = 500000;
		foreach(var_0B in var_03)
		{
			if(var_0B.f_score < var_09)
			{
				var_08 = var_0B;
				var_09 = var_0B.f_score;
			}
		}

		if(var_08 == param_01)
		{
			var_0D = param_01;
			while(var_0D.came_from != param_00)
			{
				var_0D = var_0D.came_from;
			}

			return var_0D;
		}

		var_04 = common_scripts\utility::array_remove(var_04,var_09);
		var_05[var_05.size] = var_09;
		var_0F = get_linked_air_spaces(var_09,var_03);
		foreach(var_0C in var_0F)
		{
			var_11 = var_09.g_score + distance(var_09.origin,var_0C.origin);
			if(common_scripts\utility::array_contains(var_05,var_0C) && var_11 >= var_0C.g_score)
			{
				continue;
			}

			var_12 = common_scripts\utility::array_contains(var_04,var_0C);
			if(!var_12 || var_11 < var_0C.g_score)
			{
				var_0C.came_from = var_09;
				var_0C.g_score = var_11;
				var_0C.f_score = var_0C.g_score + distance(var_0C.origin,param_02.origin);
				if(!var_12)
				{
					var_04[var_04.size] = var_0C;
				}
			}
		}
	}

	return undefined;
}

//Function Number: 63
should_play_animations()
{
	return self.classname == "script_vehicle_pdrone_kva" || self.classname == "script_vehicle_pdrone_atlas_large";
}

//Function Number: 64
setup_pdrone_animations()
{
	switch(self.classname)
	{
		case "script_vehicle_pdrone_kva":
			level.scr_anim["personal_drone"]["idle"][0] = %hms_greece_pdrone_idle_01;
			level.scr_anim["personal_drone"]["idle"][1] = %hms_greece_pdrone_idle_02;
			level.scr_anim["personal_drone"]["hit_reaction"][0] = %hms_greece_pdrone_hitreaction_01;
			level.scr_anim["personal_drone"]["hit_reaction"][1] = %hms_greece_pdrone_hitreaction_02;
			level.scr_anim["personal_drone"]["hit_reaction"][2] = %hms_greece_pdrone_hitreaction_03;
			level.scr_anim["personal_drone"]["reload"][1] = %hms_greece_pdrone_reload_01;
			break;

		case "script_vehicle_pdrone_atlas_large":
			level.scr_anim["personal_drone"]["idle"][0] = %atlas_assault_drone_idle_01;
			level.scr_anim["personal_drone"]["idle"][1] = %atlas_assault_drone_idle_02;
			level.scr_anim["personal_drone"]["hit_reaction"][0] = %atlas_assault_drone_hitreaction_01;
			level.scr_anim["personal_drone"]["hit_reaction"][1] = %atlas_assault_drone_hitreaction_02;
			level.scr_anim["personal_drone"]["hit_reaction"][2] = %atlas_assault_drone_hitreaction_03;
			break;

		default:
			break;
	}
}

//Function Number: 65
play_hit_reaction()
{
	if(!isdefined(level.scr_anim["personal_drone"]["hit_reaction"]))
	{
		return;
	}

	self useanimtree(level.scr_animtree["personal_drone"]);
	var_00 = randomint(level.scr_anim["personal_drone"]["hit_reaction"].size);
	var_01 = getanimlength(level.scr_anim["personal_drone"]["hit_reaction"][var_00]);
	self setanimknobrestart(level.scr_anim["personal_drone"]["hit_reaction"][var_00]);
	self.playing_hit_reaction = 1;
	wait(var_01);
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}

	self.playing_hit_reaction = 0;
}

//Function Number: 66
idle_anim_update()
{
	self endon("death");
	self useanimtree(level.scr_animtree["personal_drone"]);
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		wait(0.05);
		if(!var_00 && !self.playing_hit_reaction)
		{
			var_02 = randomint(level.scr_anim["personal_drone"]["idle"].size);
			var_01 = getanimlength(level.scr_anim["personal_drone"]["idle"][var_02]);
			self setanimknob(level.scr_anim["personal_drone"]["idle"][var_02]);
			var_00 = 1;
		}
		else if(self.playing_hit_reaction || var_01 <= 0)
		{
			var_00 = 0;
		}

		var_01 = var_01 - 0.05;
	}
}

//Function Number: 67
flying_attack_drone_stun_monitor()
{
	self endon("death");
	for(;;)
	{
		self waittill("stun_drone");
		stun_drone();
	}
}

//Function Number: 68
stun_drone()
{
	self.stun_duration = 2;
	if(self.playing_hit_reaction)
	{
		return;
	}

	thread play_hit_reaction();
}