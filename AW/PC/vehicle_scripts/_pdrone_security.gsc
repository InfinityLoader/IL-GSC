/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _pdrone_security.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 85
 * Decompile Time: 1215 ms
 * Timestamp: 4/22/2024 2:05:22 AM
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
	level._effect["ie_drone_thrusters_side"] = loadfx("vfx/map/irons_estate/ie_drone_thrusters_side");
	level._effect["ie_drone_thrusters"] = loadfx("vfx/map/irons_estate/ie_drone_thrusters");
	level._effect["ie_drone_eye_emissive"] = loadfx("vfx/map/irons_estate/ie_drone_eye_emissive");
	level._effect["ie_drone_eye_emissive_bootup"] = loadfx("vfx/map/irons_estate/ie_drone_eye_emissive_bootup");
	level._effect["drone_search_lt"] = loadfx("vfx/lights/drone_search_lt");
	level._effect["atlas_drone_shell"] = loadfx("vfx/shelleject/atlas_drone_shell");
	level._effect["atlas_drone_turret_flash"] = loadfx("vfx/muzzleflash/atlas_drone_turret_flash");
	level._effect["ie_drone_gun_lights"] = loadfx("vfx/map/irons_estate/ie_drone_gun_lights");
	level._effect["ie_drone_thrusters_side"] = loadfx("vfx/map/irons_estate/ie_drone_thrusters_side");
	level._effect["ie_drone_thrusters"] = loadfx("vfx/map/irons_estate/ie_drone_thrusters");
	level._effect["ie_drone_eye_emissive"] = loadfx("vfx/map/irons_estate/ie_drone_eye_emissive");
	level._effect["ie_drone_eye_emissive_bootup"] = loadfx("vfx/map/irons_estate/ie_drone_eye_emissive_bootup");
	level._effect["ie_drone_wash"] = loadfx("vfx/map/irons_estate/ie_drone_wash");
	level._effect["drone_search_lt"] = loadfx("vfx/lights/drone_search_lt");
	level._effect["drone_scan"] = loadfx("vfx/map/irons_estate/ie_drone_scan");
	level._effect["ie_drone_cam_distort"] = loadfx("vfx/map/irons_estate/ie_drone_cam_distort");
	level.sdrone_weapon_fire_sounds = ["sdrone_weapon_fire","sdrone_weapon_fire_alt1","sdrone_weapon_fire_alt2"];
	level.sdrone_weapon_fire_sound_next = 0;
	var_03 = "pdrone_security";
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	maps\_vehicle::build_template(var_03,param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_drive(undefined,undefined,0);
	maps\_vehicle::build_deathquake(0.4,0.8,1024);
	maps\_vehicle::build_life(level.pdrone_parms[param_02]["health"]);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_mainturret();
	var_04 = randomfloatrange(0,1);
	var_05 = param_02;
	maps\_vehicle::build_is_helicopter();
}

//Function Number: 2
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
	level.pdrone_parms[param_00]["health"] = 800;
	level.pdrone_parms[param_00]["axial_move"] = 1;
	level.pdrone_parms[param_00]["hover_radius"] = 16;
	level.pdrone_parms[param_00]["hover_speed"] = 8;
	level.pdrone_parms[param_00]["hover_accel"] = 8;
	level.pdrone_parms[param_00]["speed"] = 40;
	level.pdrone_parms[param_00]["accel"] = 80;
	level.pdrone_parms[param_00]["decel"] = 80;
	level.pdrone_parms[param_00]["angle_vel_pitch"] = 1000;
	level.pdrone_parms[param_00]["angle_vel_yaw"] = 2000;
	level.pdrone_parms[param_00]["angle_vel_roll"] = 10;
	level.pdrone_parms[param_00]["angle_accel"] = 1000;
	level.pdrone_parms[param_00]["yaw_speed"] = 2000;
	level.pdrone_parms[param_00]["yaw_accel"] = 2000;
	level.pdrone_parms[param_00]["yaw_decel"] = 2000;
	level.pdrone_parms[param_00]["yaw_over"] = 0;
	level.pdrone_parms[param_00]["pitchmax"] = 5;
	level.pdrone_parms[param_00]["rollmax"] = 5;
	level.pdrone_parms[param_00]["weap_fire_tags"] = ["tag_muzzle_flash_lt","tag_muzzle_flash_rt"];
	level.pdrone_parms[param_00]["clear_look"] = 0;
}

//Function Number: 3
drone_parm(param_00)
{
	return level.pdrone_parms[self.classname][param_00];
}

//Function Number: 4
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

//Function Number: 5
init_local()
{
	self endon("death");
	self.originheightoffset = distance(self gettagorigin("tag_origin"),self gettagorigin("tag_ground"));
	self.script_badplace = 0;
	self.dontdisconnectpaths = 1;
	self.vehicle_heli_default_path_speeds = ::init_class_motion;
	init_class_motion();
	self setvehweapon("pdrone_turret_security");
	if(self.script_team == "allies")
	{
		thread maps\_vehicle::vehicle_lights_on("friendly");
		self.contents = self setcontents(0);
	}
	else
	{
		thread maps\_vehicle::vehicle_lights_on("hostile");
		self.ignore_death_fx = 1;
		self.delete_on_death = 1;
		thread pdrone_handle_death();
	}

	maps\_utility::ent_flag_init("sentient_controlled");
	maps\_utility::ent_flag_init("fire_disabled");
	self.playing_hit_reaction = 0;
	self.drone_relocating = 0;
	self.drone_firing = 0;
	vehicle_scripts\_pdrone_threat_sensor::build_threat_data();
	waittillframeend;
	self.emp_death_function = ::pdrone_emp_death;
	maps\_utility::add_damage_function(::pdrone_damage_function);
	thread maps\_damagefeedback::monitordamage();
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

	thread pdrone_ai(0);
	thread pdrone_flying_fx();
	self notify("stop_kicking_up_dust");
	thread handle_pdrone_audio();
}

//Function Number: 6
handle_pdrone_audio()
{
	self endon("death");
	var_00 = spawnstruct();
	var_00.preset_name = "pdrone_security";
	var_01 = ::vehicle_scripts\_pdrone_security_aud::snd_pdrone_security_constructor;
	soundscripts\_snd::snd_message("snd_register_vehicle",var_00.preset_name,var_01);
	soundscripts\_snd::snd_message("snd_start_vehicle",var_00);
}

//Function Number: 7
pdrone_ai(param_00)
{
	self endon("death");
	self makeentitysentient(self.script_team,param_00);
	self setmaxpitchroll(drone_parm("pitchmax"),drone_parm("rollmax"));
	thread vehicle_scripts\_pdrone_threat_sensor::pdrone_update_threat_sensor();
	thread pdrone_player_collision_monitor();
}

//Function Number: 8
pdrone_player_collision_monitor()
{
	self endon("death");
	var_00 = undefined;
	var_01 = 0;
	while(isdefined(self))
	{
		var_02 = distancesquared(level.player.origin,self.origin);
		var_03 = var_02 < 16384 && level.player.origin[2] > self.origin[2];
		if(!var_01 && var_03)
		{
			var_00 = self setcontents(0);
			var_01 = 1;
			continue;
		}

		if(var_01 && !var_03)
		{
			self setcontents(var_00);
			var_01 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 9
pdrone_flying_fx()
{
	self endon("death");
	var_00 = 0.3;
	playfxontag(common_scripts\utility::getfx("ie_drone_eye_emissive"),self,"TAG_MAIN_CAMERA");
	playfxontag(common_scripts\utility::getfx("ie_drone_thrusters"),self,"TAG_EXHAUST_REAR");
	playfxontag(common_scripts\utility::getfx("ie_drone_thrusters_side"),self,"TAG_EXHAUST_LT");
	playfxontag(common_scripts\utility::getfx("ie_drone_thrusters_side"),self,"TAG_EXHAUST_RT");
	thread drone_security_thrust_fx("ie_drone_wash","ie_drone_cam_distort","TAG_ORIGIN",105);
}

//Function Number: 10
drone_security_thrust_fx(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = param_03 * 3 * param_03 * 3;
	var_05 = ["",""];
	var_06 = ["",""];
	var_07 = [];
	for(var_08 = 0;var_08 < var_05.size;var_08++)
	{
		var_07[var_08] = common_scripts\utility::spawn_tag_origin();
		var_07[var_08].angles = (-90,0,0);
		var_07[var_08] thread drone_security_thrust_fx_cleanup(self);
	}

	for(;;)
	{
		var_09 = self gettagorigin(param_02);
		var_0A = var_09 - (0,0,param_03);
		var_0B = bullettrace(var_09,var_0A,0,self,1);
		var_05[0] = "";
		var_05[1] = "";
		if(var_0B["fraction"] < 1)
		{
			var_05[0] = param_00;
			if(self == level.player.closest_drone && distancesquared(var_09,level.player geteye()) < var_04 && isdefined(level.player.inwater) && isdefined(level.player.underwater))
			{
				var_05[1] = param_01;
			}

			for(var_08 = 0;var_08 < var_05.size;var_08++)
			{
				var_07[var_08] unlink();
				var_07[var_08].origin = var_0B["position"];
				var_07[var_08] linkto(self);
			}
		}

		for(var_08 = 0;var_08 < var_05.size;var_08++)
		{
			if(var_05[var_08] != var_06[var_08])
			{
				if(var_06[var_08] != "")
				{
					stopfxontag(common_scripts\utility::getfx(var_06[var_08]),var_07[var_08],"tag_origin");
					var_06[var_08] = "";
				}

				if(var_05[var_08] != "")
				{
					playfxontag(common_scripts\utility::getfx(var_05[var_08]),var_07[var_08],"tag_origin");
					var_06[var_08] = var_05[var_08];
				}
			}
		}

		wait(0.25);
	}
}

//Function Number: 11
drone_security_thrust_fx_cleanup(param_00)
{
	self notify("drone_security_thrust_fx_cleanup");
	self endon("drone_security_thrust_fx_cleanup");
	self endon("death");
	param_00 waittill("death");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 12
pdrone_get_nodes_in_radius(param_00,param_01,param_02,param_03)
{
	return getnodesinradius(param_00,param_01,param_02,param_03,"Path","Exposed");
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
		if(self.reached_node && isdefined(self.drone_threat_data.threat))
		{
			thread pdrone_fire_at_enemy(self.drone_threat_data.threat,param_00);
			self.drone_threat_data.threat common_scripts\utility::waittill_any("death","target_lost");
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

//Function Number: 17
calculate_lateral_move_accuracy(param_00)
{
	var_01 = param_00.origin - self.origin * (1,1,0);
	var_01 = vectornormalize(var_01);
	var_01 = (var_01[1],var_01[0] * -1,0);
	var_02 = abs(vectordot(var_01,param_00 getvelocity()));
	var_02 = clamp(var_02,0,250) / 250;
	var_02 = 1 - var_02;
	var_02 = clamp(var_02,0.3,1);
	return var_02;
}

//Function Number: 18
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

//Function Number: 19
calculate_player_wounded_accuracy(param_00)
{
	if(level.player maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return 0.5;
	}

	return 1;
}

//Function Number: 20
calculate_aim_offset(param_00,param_01)
{
	var_02 = self.origin - param_00.origin;
	var_02 = var_02 * (1,1,0);
	var_02 = vectornormalize(var_02);
	if(isplayer(param_00))
	{
		param_01 = param_01 * calculate_lateral_move_accuracy(param_00);
		param_01 = param_01 * calculate_stance_accuracy(param_00);
		param_01 = param_01 * calculate_player_wounded_accuracy(param_00);
	}

	var_03 = vectorcross((0,0,1),var_02);
	var_04 = var_03 * 10 / param_01 * randomfloatrange(-1,1);
	var_05 = (0,0,5) / param_01 * randomfloatrange(-1,1);
	return var_04 + var_05;
}

//Function Number: 21
pdrone_should_hold_fire()
{
	if(self.drone_firing)
	{
		return 0;
	}

	if(self.drone_relocating)
	{
		return 1;
	}

	return !pdrone_fire_request();
}

//Function Number: 22
pdrone_fire_request()
{
	var_00 = 2;
	if(!isdefined(level.drone_fire_queue))
	{
		level.drone_fire_queue = [];
	}

	level.drone_fire_queue = common_scripts\utility::array_removeundefined(level.drone_fire_queue);
	if(!common_scripts\utility::array_contains(level.drone_fire_queue,self))
	{
		level.drone_fire_queue = common_scripts\utility::array_add(level.drone_fire_queue,self);
	}

	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		if(level.drone_fire_queue[var_01] == self)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 23
pdrone_fire_finished()
{
	self.drone_firing = 0;
	level.drone_fire_queue = common_scripts\utility::array_remove(level.drone_fire_queue,self);
}

//Function Number: 24
pdrone_cycle_fire_sound()
{
	self.weapon_fire_sound = level.sdrone_weapon_fire_sound_next;
	level.sdrone_weapon_fire_sound_next = level.sdrone_weapon_fire_sound_next + 1;
	if(level.sdrone_weapon_fire_sound_next >= level.sdrone_weapon_fire_sounds.size)
	{
		level.sdrone_weapon_fire_sound_next = 0;
	}
}

//Function Number: 25
pdrone_fire_at_enemy(param_00,param_01)
{
	self notify("pdrone_fire_at_enemy");
	self endon("pdrone_fire_at_enemy");
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
	self.drone_firing = 0;
	var_02 = param_00 geteye() - param_00.origin;
	if(isdefined(param_00.inwater) && param_00.inwater)
	{
		var_03 = (0,0,var_02[2]);
	}
	else
	{
		var_03 = (0,0,var_03[2] / 2);
	}

	var_04 = 1;
	if(isdefined(self.attack_accuracy))
	{
		var_04 = self.attack_accuracy;
	}

	if(isplayer(param_00))
	{
		var_05 = 0.15 * var_04;
	}
	else
	{
		var_05 = 0.3 * var_05;
	}

	var_06 = 0.095;
	if(!isdefined(param_01))
	{
		param_01 = 0.25;
	}

	var_07 = param_01 - param_01 * 0.2;
	var_08 = param_01 + param_01 * 0.2;
	if(level.currentgen)
	{
		var_06 = 0.2499;
		var_07 = var_07 * 2.5;
		var_08 = var_08 * 2.5;
	}

	var_09 = var_03 + calculate_aim_offset(param_00,var_05);
	if(!isdefined(self.fire_at_ent))
	{
		self.fire_at_ent = common_scripts\utility::spawn_tag_origin();
		self.fire_at_ent thread drone_fire_at_ent_cleanup(self);
	}

	if(isdefined(self.fire_at_ent))
	{
		self setlookatent(self.fire_at_ent);
	}
	else
	{
		self setlookatent(param_00);
	}

	for(;;)
	{
		self setturrettargetent(param_00,var_09);
		if(isdefined(self.fire_at_ent))
		{
			self.fire_at_ent unlink();
			self.fire_at_ent.origin = param_00.origin + var_09;
			self.fire_at_ent linkto(param_00);
		}

		if(pdrone_should_hold_fire())
		{
			wait(0.05);
			continue;
		}

		var_0A = self.origin;
		var_0B = self.angles;
		var_0C = drone_parm("weap_fire_tags");
		var_0D = var_0C[0];
		if(self gettagindex(var_0D) != -1)
		{
			var_0B = self gettagangles(var_0D);
			var_0A = self gettagorigin(var_0D);
		}

		if(pdrone_could_be_friendly_fire(var_0A,param_00.origin + var_09) || !isdefined(self.drone_threat_data.threat) || self.drone_threat_data.threat != param_00)
		{
			param_00 notify("target_lost");
			return;
		}

		var_0E = randomfloatrange(2,3);
		var_09 = var_03 + calculate_aim_offset(param_00,var_05);
		while(var_0E > 0)
		{
			if(pdrone_should_hold_fire())
			{
				var_0E = randomfloatrange(2,3);
				wait(0.05);
				continue;
			}

			pdrone_cycle_fire_sound();
			var_0F = randomfloatrange(var_07,var_08);
			var_10 = min(var_0F,var_0E);
			while(var_10 > 0)
			{
				if(pdrone_should_hold_fire())
				{
					var_10 = min(var_0F,var_0E);
					var_0E = randomfloatrange(2,3);
					wait(var_06);
					pdrone_fire_finished();
					continue;
				}

				self.drone_firing = 1;
				var_0A = self.origin;
				var_0B = self.angles;
				if(self gettagindex(var_0D) != -1)
				{
					var_0B = self gettagangles(var_0D);
					var_0A = self gettagorigin(var_0D);
				}

				var_11 = var_0A;
				var_12 = compute_fireweapon_direction(var_11,var_0B,param_00.origin + var_09,10);
				if(pdrone_could_be_friendly_fire(var_11,var_11 + var_12 * 10000))
				{
					param_00 notify("target_lost");
					return;
				}

				pdrone_fire_weapon();
				var_0E = var_0E - var_06;
				var_10 = var_10 - var_06;
				wait(var_06);
			}

			pdrone_fire_finished();
			var_13 = randomfloatrange(0.5,1);
			var_13 = min(var_13,var_0E);
			if(var_13 > 0)
			{
				var_0E = var_0E - var_13;
				wait(var_13);
			}
		}
	}
}

//Function Number: 26
drone_fire_at_ent_cleanup(param_00)
{
	param_00 waittill("death");
	self delete();
}

//Function Number: 27
pdrone_fire_weapon()
{
	var_00 = drone_parm("weap_fire_tags");
	soundscripts\_snd_playsound::snd_play_linked(level.sdrone_weapon_fire_sounds[self.weapon_fire_sound]);
	pdrone_gunshot_teammate();
	foreach(var_02 in var_00)
	{
		self fireweapon(var_02);
		self.shot_at_player = 1;
	}
}

//Function Number: 28
pdrone_gunshot_teammate()
{
	if(!isdefined(self.last_team_gunshot_announce) || gettime() - self.last_team_gunshot_announce > 1000)
	{
		self.last_team_gunshot_announce = gettime();
		var_00 = getaiarray(self.team);
		foreach(var_02 in var_00)
		{
			if(distancesquared(var_02.origin,self.origin) < 640000)
			{
				var_02 notify("gunshot_teammate",self.origin);
			}
		}
	}
}

//Function Number: 29
compute_fireweapon_direction(param_00,param_01,param_02,param_03)
{
	var_04 = vectortoangles(param_02 - param_00);
	var_05 = anglessubtract(param_01,var_04);
	var_05 = (clamp(var_05[0],0 - param_03,param_03),clamp(var_05[1],0 - param_03,param_03),0);
	param_01 = anglessubtract(param_01,var_05);
	var_06 = anglestoforward(param_01);
	return var_06;
}

//Function Number: 30
anglessubtract(param_00,param_01)
{
	return (angleclamp180(param_00[0] - param_01[0]),angleclamp180(param_00[1] - param_01[1]),angleclamp180(param_00[2] - param_01[2]));
}

//Function Number: 31
pdrone_could_be_friendly_fire(param_00,param_01)
{
	if(self.script_team == "axis")
	{
		return 0;
	}

	return maps\_utility::shot_endangers_any_player(param_00,param_01);
}

//Function Number: 32
pdrone_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_01) && isdefined(param_01.script_team) && self.script_team == param_01.script_team)
	{
		return;
	}

	if(param_04 == "MOD_ENERGY")
	{
		self dodamage(param_00 * 4,param_01.origin,param_01);
		return;
	}

	if(isalive(self) && isdefined(param_01) && !isplayer(param_01))
	{
		self.health = int(min(self.maxhealth,self.health + param_00 * 0.7));
	}
}

//Function Number: 33
play_death_explosion_fx()
{
	playfx(common_scripts\utility::getfx("pdrone_death_explosion"),self gettagorigin("tag_origin"));
	soundscripts\_snd::snd_message("pdrone_death_explode");
	pdrone_notify_explosion();
}

//Function Number: 34
pdrone_notify_explosion()
{
	var_00 = self gettagorigin("tag_origin");
	var_01 = getaiarray("axis","allies","neutral");
	var_01 = common_scripts\utility::get_array_of_closest(var_00,var_01,undefined,undefined,1500,undefined);
	var_01 = maps\_utility::array_removedead_or_dying(var_01);
	if(isdefined(var_01) && var_01.size > 0)
	{
		foreach(var_03 in var_01)
		{
			var_03 notify("explode",var_00);
		}
	}
}

//Function Number: 35
pdrone_handle_death()
{
	self waittill("death",var_00);
	if(!isdefined(self))
	{
		return;
	}

	setdvarifuninitialized("drone_spin_death_chance",0.85);
	if(self.script_team != "allies" && !isdefined(self.owner) && randomfloat(1) <= getdvarfloat("drone_spin_death_chance"))
	{
		thread death_out_of_control(var_00);
		return;
	}

	play_death_explosion_fx();
}

//Function Number: 36
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

//Function Number: 37
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

//Function Number: 38
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

//Function Number: 39
death_out_of_control(param_00)
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

	var_01 setcontents(0);
	self setcontents(0);
	self hide();
	playfxontag(common_scripts\utility::getfx("emp_drone_damage"),var_01,"TAG_ORIGIN");
	soundscripts\_snd::snd_message("pdrone_emp_death",var_01);
	playfxontag(common_scripts\utility::getfx("ie_drone_thrusters"),var_01,"TAG_EXHAUST_REAR");
	playfxontag(common_scripts\utility::getfx("ie_drone_thrusters_side"),var_01,"TAG_EXHAUST_LT");
	playfxontag(common_scripts\utility::getfx("ie_drone_thrusters_side"),var_01,"TAG_EXHAUST_RT");
	var_02 = (self.origin[0],self.origin[1],self.origin[2] - 500);
	var_03 = physicstrace(self.origin,var_02);
	var_04 = 0;
	var_05 = param_00.origin - var_01.origin;
	var_05 = vectornormalize(var_05);
	var_06 = vectorcross((0,0,1),var_05);
	var_06 = vectornormalize(var_06);
	var_07 = 100;
	var_08 = var_01.origin + var_06 * var_07;
	var_09 = vectortoangles(var_01.origin - var_08);
	var_0A = 1;
	if(common_scripts\utility::cointoss())
	{
		var_0A = -1;
	}

	var_0B = 5;
	var_0C = 25;
	var_0D = 0;
	var_0E = var_0B;
	if(common_scripts\utility::cointoss())
	{
		var_0E = randomfloatrange(0,1);
	}

	var_0F = -2;
	var_10 = var_0E + 1;
	var_11 = 0;
	var_12 = 0;
	while(var_04 < var_0B)
	{
		wait(0.05);
		var_04 = var_04 + 0.05;
		if(!var_12 && var_10 < var_0B && var_04 >= var_10)
		{
			playfxontag(common_scripts\utility::getfx("emp_drone_damage"),var_01,"TAG_ORIGIN");
			soundscripts\_snd::snd_message("pdrone_emp_death",var_01);
			stopfxontag(common_scripts\utility::getfx("ie_drone_eye_emissive"),var_01,"TAG_MAIN_CAMERA");
			var_12 = 1;
		}

		if(var_04 >= var_0E && var_04 < var_10)
		{
			if(!var_11)
			{
				playfxontag(common_scripts\utility::getfx("ie_drone_eye_emissive"),var_01,"TAG_MAIN_CAMERA");
				var_11 = 1;
			}

			var_0F = var_0F + 0.5;
			var_0D = clamp(var_0D - 2.5,var_0C * -1,var_0C);
		}
		else
		{
			var_0F = var_0F - 0.5;
			var_0D = clamp(var_0D + 2.5,var_0C * -1,var_0C);
		}

		var_09 = var_09 + (0,abs(var_0D) * 0.4,0) * var_0A;
		var_08 = var_08 + (0,0,var_0F);
		var_13 = var_08 + anglestoforward(var_09) * var_07;
		var_14 = physicstrace(var_01.origin,var_13,var_01);
		var_01.origin = var_13;
		var_01.angles = var_01.angles + (0,var_0D,0) * var_0A;
		var_01.angles = (var_01.angles[0],var_01.angles[1],cos(var_04) * 10);
		var_15 = length(var_03 - var_01.origin);
		if(var_15 < 60 || var_01.origin[2] < var_03[2] + 15 || var_14 != var_13)
		{
			break;
		}
	}

	playfx(common_scripts\utility::getfx("pdrone_death_explosion"),var_01.origin);
	soundscripts\_snd::snd_message("pdrone_crash_land",var_01.origin);
	var_01 pdrone_notify_explosion();
	var_01 delete();
}

//Function Number: 40
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

//Function Number: 41
flying_attack_drone_logic(param_00)
{
	self notify("pdrone_flying_attack_drone_logic");
	self endon("pdrone_flying_attack_drone_logic");
	self endon("death");
	param_00 = self;
	param_00 childthread flying_attack_drone_damage_monitor();
	param_00 thread flying_attack_drone_death_monitor();
	setdvarifuninitialized("drone_attack_delay",1);
	setdvarifuninitialized("drone_attack_accuracy",10);
	setdvarifuninitialized("drone_attack_sight_required",0);
	param_00.attack_delay = getdvarfloat("drone_attack_delay");
	param_00.attack_accuracy = getdvarfloat("drone_attack_accuracy");
	param_00.attack_sight_required = getdvarint("drone_attack_sight_required");
	init_class_motion();
	if(isdefined(param_00.target))
	{
		param_00 waittill("reached_dynamic_path_end");
	}

	if(!isdefined(level.player.drone_attack_nodes))
	{
		level.player thread player_attack_nodes_update();
	}

	param_00 childthread flying_attack_drone_goal_update();
}

//Function Number: 42
player_attack_nodes_update()
{
	self notify("player_attack_nodes_update");
	self endon("player_attack_nodes_update");
	self endon("death");
	self.drone_attack_nodes = [];
	for(;;)
	{
		var_00 = 0;
		if(isdefined(level.active_drones))
		{
			foreach(var_02 in level.active_drones)
			{
				if(isdefined(var_02) && var_02.mode == "attack")
				{
					var_00 = 1;
					break;
				}
			}
		}

		if(!var_00)
		{
			self.drone_attack_nodes = undefined;
			self notify("player_attack_nodes_update");
			return;
		}

		var_04 = [];
		var_05 = level.player.origin;
		var_06 = level.player getnearestnode();
		if(!isdefined(var_06))
		{
			wait(0.05);
			continue;
		}

		var_07 = pdrone_get_nodes_in_radius(var_05,800,300,512);
		var_08 = 0;
		foreach(var_0A in var_07)
		{
			if(!nodesvisible(var_06,var_0A))
			{
				continue;
			}

			if(var_08 >= 3)
			{
				wait(0.05);
				var_08 = 0;
			}

			var_08++;
			if(!drone_validate_node(var_0A))
			{
				continue;
			}

			var_04[var_04.size] = var_0A;
		}

		self.drone_attack_nodes = var_04;
		wait(1);
	}
}

//Function Number: 43
drone_waittill_goal()
{
	self.drone_relocating = 1;
	self waittill("goal");
	self.drone_relocating = 0;
}

//Function Number: 44
drone_monitor_player_aim()
{
	var_00 = cos(3);
	for(;;)
	{
		if(isalive(level.player))
		{
			var_01 = vectornormalize(self gettagorigin("tag_origin") - level.player geteye());
			var_02 = anglestoforward(level.player getplayerangles());
			if(vectordot(var_01,var_02) > var_00)
			{
				self notify("aimed_at");
			}
		}

		wait(0.25);
	}
}

//Function Number: 45
flying_attack_drone_goal_update()
{
	self notify("flying_attack_drone_goal_update");
	self endon("flying_attack_drone_goal_update");
	self endon("death");
	childthread drone_monitor_player_aim();
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_timeout(randomfloatrange(1,2),"aimed_at");
		var_01 = self gettagorigin("tag_origin");
		var_02 = self gettagangles("tag_origin");
		var_03 = var_01;
		if(common_scripts\utility::cointoss())
		{
			var_03 = var_03 + anglestoright(var_02) * 200;
		}
		else
		{
			var_03 = var_03 + anglestoright(var_02) * -200;
		}

		if(isdefined(level.player.drone_attack_nodes) && level.player.drone_attack_nodes.size > 0)
		{
			if(!isdefined(self.claimed_node))
			{
				var_04 = sortbydistance(level.player.drone_attack_nodes,var_03);
				foreach(var_06 in var_04)
				{
					if(drone_node_claimed_by_other(var_06))
					{
						continue;
					}

					drone_claim_node(var_06);
					break;
				}

				if(isdefined(self.claimed_node))
				{
					var_08 = self.claimed_node.origin;
					var_09 = var_08[2] + 100;
					init_class_motion(100,200,200);
					if(isdefined(self.prev_attachedpath))
					{
						self setgoalyaw(vectortoyaw(var_08 - var_01));
						self setvehgoalpos((self.origin[0],self.origin[1],max(var_09 + 500,var_01[2])),1);
						drone_waittill_goal();
						self setgoalyaw(vectortoyaw(var_08 - var_01));
						self setvehgoalpos((var_08[0],var_08[1],max(var_09 + 500,var_01[2])),1);
						drone_waittill_goal();
					}

					self setgoalyaw(vectortoyaw(var_08 - var_01));
					self setvehgoalpos((var_08[0],var_08[1],max(var_09,var_01[2])),1);
					drone_waittill_goal();
					init_class_motion();
					self setvehgoalpos((var_08[0],var_08[1],var_09),1);
					drone_waittill_goal();
					self.reached_node = 1;
				}
			}

			var_0A = sortbydistance(level.player.drone_attack_nodes,var_03);
			var_0B = self.claimed_node;
			var_0C = var_01[2];
			var_0D = 0;
			foreach(var_06 in var_0A)
			{
				if(isdefined(self.claimed_node) && var_06 == self.claimed_node)
				{
					continue;
				}

				if(drone_node_claimed_by_other(var_06))
				{
					continue;
				}

				if(!isdefined(self.claimed_node))
				{
					var_0B = var_06;
					break;
				}

				wait(0.05);
				var_0F = level.player.origin[2] + 100;
				var_10 = drone_validate_path_to(self.claimed_node,var_01[2],var_06,var_0F);
				if(var_10)
				{
					var_0D = var_0D + 1;
				}
				else
				{
					wait(0.05);
					var_10 = drone_validate_path_to(self.claimed_node,var_01[2],var_06,undefined);
					if(var_10)
					{
						var_0D = var_0D + 1;
						var_0F = var_06.origin[2] + 100;
					}
				}

				if(var_10 && randomfloat(1) <= 1 / var_0D)
				{
					var_0B = var_06;
					var_0C = var_0F;
					if(var_0D >= 5 || var_00 == "aimed_at")
					{
						break;
					}
				}
			}

			if(isdefined(var_0B) && !isdefined(self.claimed_node) || var_0B != self.claimed_node)
			{
				while(self.drone_firing)
				{
					wait(0.05);
				}

				if(drone_node_claimed_by_other(var_0B))
				{
					continue;
				}

				drone_claim_node(var_0B);
				init_class_motion();
				self setmaxpitchroll(80,drone_parm("rollmax"));
				self setvehgoalpos((var_0B.origin[0],var_0B.origin[1],var_0C),1);
				drone_waittill_goal();
				self.reached_node = 1;
				self vehicle_setspeedimmediate(0.05,0.05,0.05);
			}
		}
	}
}

//Function Number: 46
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

//Function Number: 47
flying_attack_drone_damage_update()
{
	self notify("taking damage");
	self endon("taking damage");
	self endon("death");
	self.istakingdamage = 1;
	wait(1);
	self.istakingdamage = 0;
}

//Function Number: 48
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

//Function Number: 49
drone_investigate_try_location(param_00,param_01,param_02)
{
	if((!isdefined(param_02) && !isdefined(level.dronespawners)) || level.dronespawners.size == 0)
	{
		return 0;
	}

	var_03 = pdrone_get_nodes_in_radius(param_00 + (0,0,-512),1000,0,1024);
	if(var_03.size == 0)
	{
		return 0;
	}

	var_03 = sortbydistance(var_03,param_00);
	var_04 = param_00;
	param_00 = var_03[0].origin;
	var_05 = 0;
	if(!isdefined(param_01))
	{
		foreach(var_07 in level.drone_investigates)
		{
			if(distancesquared(var_03[0].origin,var_07) < 1000000)
			{
				var_05 = 1;
			}
		}
	}

	if(var_05)
	{
		return 0;
	}

	var_09 = param_02;
	if(!isdefined(var_09))
	{
		level.dronespawners = sortbydistance(level.dronespawners,param_00);
		var_0A = anglestoforward(level.player getplayerangles());
		var_0B = cos(60);
		var_09 = level.dronespawners[0];
		foreach(param_02 in level.dronespawners)
		{
			var_0D = vectornormalize(param_02.origin - level.player.origin);
			if(vectordot(var_0D,var_0A) > var_0B)
			{
				continue;
			}

			var_09 = param_02;
			break;
		}
	}

	var_0F = drone_spawner_get_height(var_09);
	var_10 = 0;
	var_11 = 0;
	for(var_12 = 0;var_12 < var_03.size;var_12++)
	{
		if(var_11 >= 100)
		{
			return 0;
		}

		if(!nodesvisible(var_03[var_12],var_03[0]))
		{
			continue;
		}

		var_10 = drone_validate_node(var_03[var_12]);
		if(!sighttracepassed(var_04 + (0,0,50),var_03[var_12].origin + (0,0,100),0,undefined,undefined,0))
		{
			var_10 = 0;
		}

		if(var_10)
		{
			break;
		}
		else
		{
		}

		var_11++;
		wait(0.05);
	}

	if(var_10)
	{
		var_13 = var_09;
		if(level.dronespawnerexits.size > 0)
		{
			level.dronespawnerexits = sortbydistance(level.dronespawnerexits,param_00);
			var_13 = level.dronespawnerexits[0];
		}

		level thread drone_investigate(var_09,var_13,var_03[var_12],var_0F,var_04,param_01);
	}

	return var_10;
}

//Function Number: 50
drone_spawner_get_height(param_00)
{
	if(isdefined(param_00.script_parameters))
	{
		var_01 = int(param_00.script_parameters);
		if(var_01 != 0)
		{
			return var_01;
		}
	}

	return max(param_00.origin[2],1500);
}

//Function Number: 51
drone_validate_node(param_00)
{
	var_01 = param_00.origin;
	var_02 = var_01 + (0,0,10);
	var_03 = (var_01[0],var_01[1],param_00.origin[2] + 10000);
	var_04 = playerphysicstrace(var_02,var_03,level.player);
	var_05 = distancesquared(var_04,var_03) < 0.01;
	return var_05;
}

//Function Number: 52
drone_validate_path_to(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_02))
	{
		return 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00.origin[2] + 100;
	}

	if(!isdefined(param_03))
	{
		param_03 = param_02.origin[2] + 100;
	}

	if(param_03 < param_02.origin[2] + 50)
	{
		return 0;
	}

	var_04 = (param_00.origin[0],param_00.origin[1],param_01);
	var_05 = (param_00.origin[0],param_00.origin[1],param_03);
	var_06 = playerphysicstrace(var_04,var_05,self);
	if(distancesquared(var_05,var_06) < 0.01)
	{
		var_04 = (param_00.origin[0],param_00.origin[1],param_03);
		var_05 = (param_02.origin[0],param_02.origin[1],param_03);
		var_06 = playerphysicstrace(var_04,var_05,self);
		return distancesquared(var_05,var_06) < 0.01;
	}

	return 0;
}

//Function Number: 53
drone_investigate(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = drone_spawn(param_00,"patrol");
	var_06 childthread drone_investigate_thread(param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 54
drone_investigate_thread(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self;
	var_06 = param_01.origin;
	level.drone_investigates[level.drone_investigates.size] = var_06;
	var_05 endon("death");
	var_05 notify("drone_investigate");
	var_05 endon("drone_investigate");
	var_05 drone_abort_path();
	level notify("drone_investigate_start",var_05);
	level.aud_drone_investigating = 1;
	var_07 = var_05.origin;
	var_08 = (0,0,100);
	var_09 = var_06 + var_08;
	var_05 thread drone_investigate_cleanup(var_06);
	var_05 thread drone_investigate_scan();
	var_05 childthread drone_investigate_find_spots(param_01,var_07,param_02,param_03);
	var_05 init_class_motion();
	var_05 setgoalyaw(vectortoyaw(var_06 - var_07));
	var_05 setvehgoalpos((var_07[0],var_07[1],param_02),1);
	var_05 drone_waittill_goal();
	var_05 init_class_motion(100,200,200);
	var_05 setgoalyaw(vectortoyaw(var_06 - var_07));
	var_05 setvehgoalpos((var_09[0],var_09[1],param_02),1);
	var_05 drone_waittill_goal();
	var_05 init_class_motion();
	if(isdefined(param_04))
	{
		var_05 thread drone_investigate_spot(param_01,param_04[2],param_04,1);
	}
	else
	{
		var_05 thread drone_investigate_spot(param_01,param_03[2] + 100);
	}

	var_05 waittill("drone_investigate_spot_finished");
	for(var_0A = 0;var_0A < min(var_05.investigatenodes.size,2);var_0A++)
	{
		if(isdefined(param_04))
		{
			var_05 thread drone_investigate_spot(var_05.investigatenodes[var_0A],param_04[2],param_04,1);
		}
		else
		{
			var_05 thread drone_investigate_spot(var_05.investigatenodes[var_0A]);
		}

		var_05 waittill("drone_investigate_spot_finished");
	}

	var_05 drone_return_home(param_00,self.prev_attachedpath);
}

//Function Number: 55
drone_return_home(param_00,param_01)
{
	var_02 = self;
	var_02 notify("drone_return_home");
	var_02 endon("drone_return_home");
	var_02 endon("death");
	var_02 drone_set_mode("patrol",0);
	if(!isdefined(param_00))
	{
		if(level.dronespawnerexits.size > 0)
		{
			level.dronespawnerexits = sortbydistance(level.dronespawnerexits,var_02.origin);
			param_00 = level.dronespawnerexits[0];
		}
	}

	if(!isdefined(param_00) && !isdefined(param_01))
	{
		return;
	}

	var_03 = param_00.origin;
	if(isdefined(param_01))
	{
		var_03 = param_01.origin;
	}

	var_02 notify("drone_investigate_cleanup");
	var_04 = drone_spawner_get_height(param_00);
	var_02 setgoalyaw(vectortoyaw(param_00.origin - var_02.origin));
	var_02 setvehgoalpos((var_02.origin[0],var_02.origin[1],var_04),1);
	var_02 drone_waittill_goal();
	level.aud_drone_investigating = 0;
	var_02 init_class_motion(100,200,200);
	var_02 setgoalyaw(vectortoyaw(var_03 - var_02.origin));
	var_02 setvehgoalpos((var_03[0],var_03[1],var_04),1);
	var_02 drone_waittill_goal();
	if(isdefined(param_01))
	{
		var_02 thread maps\_vehicle_code::vehicle_paths_helicopter(param_01);
		return;
	}

	if(isdefined(self.tagged))
	{
		var_02 maps\_tagging::tag_outline_enemy(0);
	}

	var_02 setvehgoalpos(param_00.origin,1);
	var_02 drone_waittill_goal();
	var_02 delete();
}

//Function Number: 56
drone_investigate_find_spots(param_00,param_01,param_02,param_03)
{
	var_04 = 400;
	var_05 = 40000;
	var_06 = pdrone_get_nodes_in_radius(param_00.origin,var_04,0,512);
	var_07 = [];
	foreach(var_09 in var_06)
	{
		if(drone_node_claimed_by_other(var_09))
		{
			continue;
		}

		if(!nodesvisible(var_09,param_00))
		{
			continue;
		}

		if(distancesquared(var_09.origin,param_00.origin) < var_05)
		{
			continue;
		}

		var_0A = 0;
		foreach(var_0C in var_07)
		{
			if(distancesquared(var_09.origin,var_0C.origin) < var_05)
			{
				var_0A = 1;
				break;
			}
		}

		if(var_0A)
		{
			continue;
		}

		wait(0.05);
		if(drone_validate_node(var_09))
		{
			var_07[var_07.size] = var_09;
		}
	}

	var_0F = common_scripts\utility::array_randomize(var_07);
	var_10 = [];
	foreach(var_09 in var_0F)
	{
		if(var_10.size == 0 && drone_validate_path_to(param_00,param_03[2] + 100,var_09,undefined))
		{
			var_10[var_10.size] = var_09;
		}
		else if(var_10.size > 0 && drone_validate_path_to(var_10[var_10.size - 1],undefined,var_09,undefined))
		{
			var_10[var_10.size] = var_09;
		}

		wait(0.05);
	}

	self.investigatenodes = var_10;
}

//Function Number: 57
drone_node_claimed_by_other(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.claimed_drone))
	{
		return 0;
	}

	if(param_00.claimed_drone == self)
	{
		return 0;
	}

	return 1;
}

//Function Number: 58
drone_claim_node(param_00)
{
	if(isdefined(self.claimed_node))
	{
		self.claimed_node.claimed_drone = undefined;
		self.claimed_node = undefined;
	}

	if(isdefined(param_00))
	{
		if(isdefined(param_00.claimed_drone) && param_00.claimed_drone != self)
		{
			param_00.claimed_drone notify("node_kicked");
			param_00.claimed_drone drone_claim_node(undefined);
		}

		self.claimed_node = param_00;
		param_00.claimed_drone = self;
	}
}

//Function Number: 59
drone_investigate_spot(param_00,param_01,param_02,param_03)
{
	self notify("drone_investigate_spot");
	self endon("drone_investigate_spot");
	self endon("drone_investigate");
	self endon("death");
	drone_claim_node(param_00);
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00.origin[2] + 100;
	}

	var_04 = (param_00.origin[0],param_00.origin[1],param_01);
	self.visiting_player_from_node = undefined;
	init_class_motion();
	self cleargoalyaw();
	if(isdefined(param_02))
	{
		drone_security_bays_open(1);
		self settargetyaw(vectortoyaw(param_02 - self.origin));
	}
	else
	{
		drone_security_bays_open(0);
		self settargetyaw(vectortoyaw(var_04 - self.origin));
	}

	self setvehgoalpos(var_04,1);
	var_05 = "timeout";
	while(var_05 == "timeout")
	{
		if(isdefined(param_02))
		{
			self settargetyaw(vectortoyaw(param_02 - self.origin));
		}

		var_05 = common_scripts\utility::waittill_any_timeout(0.05,"goal");
	}

	self.reached_node = 1;
	self vehicle_setspeedimmediate(0.05,0.05,0.05);
	var_06 = self.angles[1];
	var_07 = 1;
	while(var_07)
	{
		var_07 = 0;
		for(var_08 = 0;var_08 < 4;var_08++)
		{
			var_09 = 2;
			self.scantime = 0;
			var_0A = 0;
			while(var_09 > 0)
			{
				var_0B = var_06 + var_08 * 90;
				if(isdefined(param_02))
				{
					var_0B = vectortoyaw(param_02 - self.origin);
				}

				var_0C = drone_investigate_yaw(var_0B);
				if(var_0C > 0)
				{
					var_0A = var_0A + 0.05;
					var_09 = 2;
				}

				if(var_0A > 0.5)
				{
					var_07 = 1;
					if(var_0C > 250)
					{
						childthread drone_investigate_visit_player_from(param_00);
					}
				}

				var_09 = var_09 - 0.05;
				self.scantime = self.scantime + 0.05;
				wait(0.05);
			}

			if(!param_03)
			{
				param_02 = undefined;
			}
		}
	}

	init_class_motion();
	self.scantime = 0;
	if(isdefined(self.investigate_spot_return_to) && self.investigate_spot_return_to.size > 0)
	{
		var_0D = self.investigate_spot_return_to[self.investigate_spot_return_to.size - 1];
		self.investigate_spot_return_to[self.investigate_spot_return_to.size - 1] = undefined;
		thread drone_investigate_spot(var_0D);
		return;
	}

	self cleartargetyaw();
	self notify("drone_investigate_spot_finished");
}

//Function Number: 60
drone_investigate_visit_player_from(param_00)
{
	if(isdefined(self.visiting_player_from_node))
	{
		return;
	}

	self.visiting_player_from_node = param_00;
	var_01 = pdrone_get_nodes_in_radius(level.player.origin - (0,0,256),512,128,512);
	var_01 = sortbydistance(var_01,level.player.origin);
	foreach(var_03 in var_01)
	{
		if(distancesquared(var_03.origin,param_00.origin) < 22500)
		{
			self.visiting_player_from_node = undefined;
			return;
		}

		wait(0.05);
		if(drone_validate_path_to(param_00,undefined,var_03,level.player.origin[2] + 100))
		{
			wait(0.05);
			if(drone_validate_path_to(var_03,level.player.origin[2],param_00,undefined))
			{
				if(!isdefined(self.investigate_spot_return_to))
				{
					self.investigate_spot_return_to = [];
				}

				self.investigate_spot_return_to[self.investigate_spot_return_to.size] = param_00;
				thread drone_investigate_spot(var_03,level.player.origin[2] + 100,level.player.origin);
				return;
			}
		}
	}

	self.visiting_player_from_node = undefined;
}

//Function Number: 61
drone_investigate_scan()
{
	self endon("death");
	self endon("drone_investigate");
	self.scanning = 0;
	self.scantime = 0;
	self.scantag childthread drone_investigate_scan_tag_think(self);
	for(;;)
	{
		if(self.scantag.seeing)
		{
			wait(0.05);
			continue;
		}

		if((self.scantime <= 0.3 || self.mode == "attack") && self.scanning)
		{
			level notify("aud_stop_drone_scanning");
			stopfxontag(level._effect["drone_scan"],self.scantag,"tag_origin");
			self.scanning = 0;
			self.scantag.active = 0;
		}
		else if(self.scantime > 0.3 && !self.scanning)
		{
			self.scantag linkto(self,"tag_top_camera",(0,0,0),(0,-45,0));
			wait(0.05);
			self.scantag rotatebylinked((0,90,0),1.7,0,0);
			self.scantag.active = 1;
			self.scantagaudio soundscripts\_snd_playsound::snd_play_loop_linked("sdrn_scan_lp","aud_stop_drone_scanning",0.1,0.1);
			playfxontag(level._effect["drone_scan"],self.scantag,"tag_origin");
			self.scanning = 1;
		}

		wait(0.05);
	}
}

//Function Number: 62
drone_investigate_scan_tag_think(param_00)
{
	self.seeing = 0;
	for(;;)
	{
		self waittill("sight");
		self linkto(param_00,"tag_top_camera",(0,0,0),(0,0,0));
		self.seeing = 1;
		wait(3);
		self.seeing = 0;
	}
}

//Function Number: 63
drone_security_scan_tag_cleanup(param_00)
{
	self notify("drone_security_scan_tag_cleanup");
	self endon("drone_security_scan_tag_cleanup");
	param_00 waittill("death");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 64
drone_security_scan_tag_audio(param_00,param_01)
{
	self notify("drone_security_scan_tag_audio");
	self endon("drone_security_scan_tag_audio");
	param_00 endon("death");
	self endon("death");
	var_02 = 0;
	while(isdefined(self) && isdefined(param_00) && isdefined(param_00.scantag))
	{
		var_03 = param_01;
		var_04 = distancesquared(level.player.origin,param_00.scantag.origin);
		if(var_04 < param_01 * param_01)
		{
			var_03 = sqrt(var_04);
		}

		if(var_02 != var_03)
		{
			self unlink();
			var_02 = var_03;
			self.origin = param_00.scantag.origin;
			self.origin = self.origin + anglestoforward(param_00.scantag.angles) * var_02;
			self linkto(param_00.scantag);
		}

		wait(0.05);
	}
}

//Function Number: 65
drone_investigate_yaw(param_00)
{
	if(isdefined(self.last_saw_player) && gettime() - self.last_saw_player_time < 1000)
	{
		self settargetyaw(vectortoyaw(self.last_saw_player - self.origin));
		return gettime() - self.last_saw_player_time;
	}

	self settargetyaw(param_00);
	return -1;
}

//Function Number: 66
drone_investigate_cleanup(param_00)
{
	self.investigating = 1;
	common_scripts\utility::flag_set("drones_investigating");
	common_scripts\utility::waittill_any("death","drone_investigate","drone_investigate_cleanup");
	level.drone_investigates = common_scripts\utility::array_remove(level.drone_investigates,param_00);
	if(isdefined(self))
	{
		self.investigating = undefined;
		level notify("drone_investigate_finished",self);
	}

	wait(0.1);
	if(level.drone_investigates.size == 0)
	{
		common_scripts\utility::flag_clear("drones_investigating");
	}
}

//Function Number: 67
drone_spawn(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "patrol";
	}

	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_02 = drone_spawn_single_struct(param_00);
	if(!isdefined(var_02))
	{
		return undefined;
	}

	var_02 thread drone_active_thread();
	var_02 drone_set_mode(param_01);
	return var_02;
}

//Function Number: 68
drone_spawn_and_drive(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "patrol";
	}

	if(!isdefined(param_00))
	{
		return [];
	}

	var_02 = common_scripts\utility::getstructarray(param_00,"targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		var_06 = drone_spawn_single_struct(var_05);
		var_06 thread drone_active_thread();
		var_06 drone_set_mode(param_01);
		var_03[var_03.size] = var_06;
	}

	return var_03;
}

//Function Number: 69
drone_spawn_single_struct(param_00)
{
	if(!isdefined(level.dronespawnertemplate))
	{
		return undefined;
	}

	while(isdefined(level.dronespawnertemplate.vehicle_spawned_thisframe))
	{
		wait(0.05);
	}

	level.dronespawnertemplate.origin = param_00.origin;
	level.dronespawnertemplate.angles = param_00.angles;
	level.dronespawnertemplate.target = param_00.target;
	level.dronespawnertemplate.script_noteworthy = param_00.script_noteworthy;
	var_01 = level.dronespawnertemplate maps\_vehicle::spawn_vehicle_and_gopath();
	return var_01;
}

//Function Number: 70
drone_active_thread()
{
	if(!isdefined(level.last_drone_attacking_sound))
	{
		level.last_drone_attacking_sound = 0;
	}

	if(!isdefined(level.last_drone_investigating_sound))
	{
		level.last_drone_investigating_sound = 0;
	}

	if(!isdefined(level.last_drone_passive_sound))
	{
		level.last_drone_passive_sound = 0;
	}

	if(!isdefined(level.last_drone_lens_sound))
	{
		level.last_drone_lens_sound = 0;
	}

	if(!isdefined(level.active_drones))
	{
		level.active_drones = [];
	}

	level.active_drones = common_scripts\utility::array_add(level.active_drones,self);
	level.player thread drone_closest();
	childthread drone_random_vocalizations();
	childthread drone_spin_monitor();
	self waittill("death");
	level.active_drones = common_scripts\utility::array_remove(level.active_drones,self);
}

//Function Number: 71
drone_closest()
{
	self notify("drone_closest");
	self endon("drone_closest");
	while(isdefined(level.active_drones) && isdefined(self))
	{
		var_00 = sortbydistance(level.active_drones,self.origin);
		if(var_00.size > 0)
		{
			self.closest_drone = var_00[0];
			continue;
		}

		self.closest_drone = undefined;
		wait(0.5);
	}
}

//Function Number: 72
drone_spin_monitor()
{
	self endon("death");
	var_00 = 0;
	var_01 = angleclamp180(self gettagangles("tag_origin")[1]);
	while(isdefined(self))
	{
		var_02 = angleclamp180(self gettagangles("tag_origin")[1]);
		if(abs(var_02 - var_01) > 1)
		{
			if(!var_00)
			{
				soundscripts\_snd_playsound::snd_play_linked("sdrone_pivot");
			}

			var_00 = 1;
		}
		else
		{
			var_00 = 0;
		}

		var_01 = var_02;
		wait(0.05);
	}
}

//Function Number: 73
drone_random_vocalizations()
{
	self endon("death");
	while(isdefined(self))
	{
		if(!common_scripts\utility::flag("_stealth_spotted") && common_scripts\utility::flag("drones_investigating"))
		{
			if(gettime() - level.last_drone_investigating_sound > 3000)
			{
				var_00 = level.player.closest_drone;
				if(isdefined(var_00))
				{
					level.last_drone_investigating_sound = gettime();
					if(randomint(5) > 1)
					{
						var_00 soundscripts\_snd_playsound::snd_play_linked("sdrone_voc_suspicious");
					}
					else
					{
						var_00 soundscripts\_snd_playsound::snd_play_linked("sdrone_voc_aggressive");
					}
				}
			}

			if(randomint(5) > 3 && gettime() - level.last_drone_lens_sound > 3000)
			{
				var_00 = level.player.closest_drone;
				if(isdefined(var_00))
				{
					level.last_drone_lens_sound = gettime();
					var_00 soundscripts\_snd_playsound::snd_play_linked("sdrone_lens_movement");
				}
			}

			wait(randomfloatrange(0.2,6));
			continue;
		}

		if(gettime() - level.last_drone_passive_sound > 5000)
		{
			var_00 = level.player.closest_drone;
			if(isdefined(var_00))
			{
				level.last_drone_passive_sound = gettime();
				var_00 soundscripts\_snd_playsound::snd_play_linked("sdrone_voc_curious");
			}
		}

		wait(randomfloatrange(5,10));
		wait(0.05);
	}
}

//Function Number: 74
drone_alert_sight(param_00,param_01,param_02,param_03,param_04)
{
	self notify("drone_alert_sight");
	self endon("death");
	self endon("drone_alert_sight");
	self.threatsightdelayenabled = 1;
	self.threatsightdelayfalloff = 1;
	self.threatsightdelay = 0;
	self.corpse_array_time = 0;
	if(!isdefined(self.fovcosinez) || self.fovcosinez == 0)
	{
		self.fovcosinez = cos(10);
	}

	if(!isdefined(self.fovcosine) || self.fovcosine == 0)
	{
		self.fovcosine = cos(45);
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_05 = 0.05;
	for(;;)
	{
		if(!isdefined(level._stealth) || !common_scripts\utility::flag_exist("_stealth_enabled") || !common_scripts\utility::flag("_stealth_enabled"))
		{
			wait(0.05);
			continue;
		}

		var_06 = getdvarfloat("ai_threatSightDelayDistMin");
		var_07 = getdvarfloat("ai_threatSightDelayDistMax");
		var_08 = getdvarfloat("ai_threatSightDelayRateMin");
		var_09 = getdvarfloat("ai_threatSightDelayRateMax");
		var_0A = level.player.maxvisibledist;
		if(isai(self))
		{
			var_0B = self geteye();
			var_0C = anglestoforward(self.angles);
		}
		else
		{
			var_0B = self gettagorigin("tag_origin");
			var_0C = anglestoforward(self gettagangles("tag_origin"));
		}

		var_0D = var_0A;
		if(isdefined(level._stealth) && isdefined(level._stealth.logic) && isdefined(level._stealth.logic.detect_range))
		{
			var_0E = level._stealth.logic.detect_range["hidden"][level.player getstance()];
			if(isdefined(var_0E))
			{
				var_0D = min(var_0E,var_0D);
			}
		}

		var_0F = drone_alert_sight_check(level.player,var_0B,param_01,param_02,var_0D * param_03);
		self.canseeplayer = var_0F != 0;
		if(self.canseeplayer)
		{
			if(var_0F <= var_06 * var_06)
			{
				self.threatsightdelay = self.threatsightdelay + var_05;
			}
			else
			{
				var_10 = sqrt(var_0F);
				if(param_04 != 1)
				{
					var_11 = var_10 / param_04;
					var_12 = vectornormalize(level.player.origin - var_0B);
					var_13 = vectordot(var_12,var_0C);
					var_14 = var_13 - self.fovcosine / 1 - self.fovcosine;
					var_10 = var_10 + var_11 - var_10 * var_14;
				}

				var_15 = clamp(var_10 - var_06 / var_07 - var_06,0,1);
				var_16 = var_08 + var_09 - var_08 * var_15;
				self.threatsightdelay = self.threatsightdelay + var_05 * var_16;
			}

			self.last_saw_player = level.player.origin;
			self.last_saw_player_time = gettime();
			level.player.stealth_can_be_seen = 1;
		}
		else
		{
			var_17 = getdvarfloat("ai_threatSightDelayFalloff");
			self.threatsightdelay = self.threatsightdelay - var_05 * var_17;
		}

		if(!self.canseeplayer)
		{
			if(gettime() > self.corpse_array_time)
			{
				self.corpse_array = sortbydistance(getcorpsearray(),self.origin,1000,1);
				self.corpse_array_time = gettime() + randomintrange(500,1000);
			}

			if(isdefined(self.corpse_array))
			{
				foreach(var_19 in self.corpse_array)
				{
					if(!isdefined(var_19))
					{
						continue;
					}

					if(isdefined(var_19.corpse_seen_by) && isdefined(var_19.corpse_seen_by[self getentitynumber()]))
					{
						continue;
					}

					if(drone_alert_sight_check(var_19,var_0B,param_01,param_02,1000) != 0)
					{
						var_19.corpse_seen_by[self getentitynumber()] = 1;
						self notify("see_corpse",var_19);
						wait(0.05);
					}
				}
			}
		}

		self.threatsightdelay = clamp(self.threatsightdelay,0,1);
		if(self.threatsightdelay >= 1)
		{
			self notify(param_00);
			return;
		}

		wait(var_05);
	}
}

//Function Number: 75
drone_alert_sight_check(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_00.ignoreme) && param_00.ignoreme)
	{
		return 0;
	}

	var_05 = param_00.origin + (0,0,20);
	if(isplayer(param_00))
	{
		var_05 = param_00 geteye();
	}

	var_06 = var_05 - param_01;
	var_07 = lengthsquared(var_06);
	var_08 = 0;
	var_09 = 4900;
	if(var_07 < var_09)
	{
		var_08 = var_07;
	}
	else
	{
		if(drone_alert_sight_can_see(var_05,param_04,1,isplayer(param_00)))
		{
			var_08 = var_07;
		}

		if(var_08 == 0 && isplayer(param_00) && isdefined(param_02) && param_02.active)
		{
			if(param_02 drone_alert_sight_can_see(var_05,param_03,0,isplayer(param_00)))
			{
				var_08 = var_07;
			}

			if(var_08 != 0)
			{
				param_02 notify("sight",var_05);
			}
		}
	}

	return var_08;
}

//Function Number: 76
drone_alert_sight_can_see(param_00,param_01,param_02,param_03)
{
	var_04 = self gettagorigin("tag_origin");
	if(isai(self))
	{
		var_04 = self geteye();
	}

	var_05 = param_00 - var_04;
	var_06 = lengthsquared(var_05);
	var_07 = param_01 * param_01;
	var_08 = var_06 <= var_07;
	var_09 = getdvarfloat("ai_threatSightDelayDistMin");
	if(var_08)
	{
		if(isai(self) && param_03 && !isdefined(self.sight_ignore))
		{
			var_08 = self cansee(level.player);
		}
		else
		{
			var_0A = anglestoforward(self gettagangles("tag_origin"));
			var_05 = param_00 - var_04;
			var_0B = vectornormalize(var_05);
			var_0C = vectordot(var_0A,var_0B);
			var_08 = var_0C >= self.fovcosine;
			if(var_08)
			{
				if(self.fovcosinez > self.fovcosine && isdefined(self.sight_ignore) || lengthsquared(var_05) > var_09 * var_09)
				{
					var_0D = (var_0A[0],var_0A[1],0) * length((var_05[0],var_05[1],0));
					var_0E = var_04 + (var_0D[0],var_0D[1],var_05[2]);
					var_0F = vectornormalize(var_0E - var_04);
					var_10 = vectordot(var_0F,var_0A);
					var_08 = var_10 >= self.fovcosinez;
				}

				if(var_08)
				{
					var_08 = sighttracepassed(var_04,param_00,0,self.sight_ignore,self,param_02);
				}
			}
		}
	}

	return var_08;
}

//Function Number: 77
drone_set_mode(param_00,param_01)
{
	self endon("death");
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = self;
	var_03 = 0;
	if(isdefined(var_02.mode) && var_02.mode == param_00)
	{
		return;
	}

	if(!isdefined(var_02.mode))
	{
		var_03 = 1;
		var_02.reached_node = 0;
		var_02 useanimtree(#animtree);
		if(param_00 == "attack")
		{
			var_02 setanim(%ie_drone_deploy,1,0,1);
			var_02 setanimtime(%ie_drone_deploy,1);
			var_02.bays_open = 1;
		}
		else
		{
			var_02 setanim(%ie_drone_retract,1,0,1);
			var_02 setanimtime(%ie_drone_retract,1);
			var_02.bays_open = 0;
		}
	}

	self notify("drone_set_mode");
	self endon("drone_set_mode");
	var_04 = var_02.mode;
	var_02.mode = param_00;
	if(!isdefined(var_02.scantag))
	{
		var_02.scantag = common_scripts\utility::spawn_tag_origin();
		var_02.scantag thread drone_security_scan_tag_cleanup(var_02);
		var_02.scantag.fovcosinez = 0;
		var_02.scantag.fovcosine = cos(30);
		var_02.scantag.active = 0;
		var_02.scantag.sight_ignore = var_02;
		var_02.scantagaudio = common_scripts\utility::spawn_tag_origin();
		var_02.scantagaudio thread drone_security_scan_tag_cleanup(var_02);
		var_02.scantagaudio thread drone_security_scan_tag_audio(var_02,300);
	}

	if(isdefined(level.stealth_spotted_drones))
	{
		level.stealth_spotted_drones = common_scripts\utility::array_remove(level.stealth_spotted_drones,self);
	}

	wait(0.1);
	switch(param_00)
	{
		case "patrol":
			var_02.fovcosinez = cos(15);
			var_02.fovcosine = cos(55);
			var_02 notify("stealth_spotted_drone_death_monitor");
			var_02 clearlookatent();
			var_02 cleargoalyaw();
			var_02 notify("pdrone_targeting");
			var_02 notify("pdrone_flying_attack_drone_logic");
			if(param_01)
			{
				var_02 thread drone_alert_sight("attack",var_02.scantag,300,1,2);
				var_02 thread drone_wait_for_attack();
				var_02 thread drone_corpse_monitor();
			}
	
			if(isdefined(var_04))
			{
				var_02 thread drone_security_prepare_patrol(var_03);
			}
			break;

		case "attack":
			var_02.fovcosinez = cos(60);
			var_02.fovcosine = cos(60);
			var_02 notify("drone_investigate");
			var_02 notify("drone_corpse_monitor");
			var_02 notify("drone_alert_sight");
			var_02 notify("drone_wait_for_attack");
			var_02 thread drone_security_prepare_attack(var_03);
			break;
	}
}

//Function Number: 78
drone_corpse_monitor()
{
	self notify("drone_corpse_monitor");
	self endon("drone_corpse_monitor");
	self endon("death");
	for(;;)
	{
		self waittill("see_corpse",var_00);
		var_01 = pdrone_get_nodes_in_radius(var_00.origin,500,0,500);
		var_01 = sortbydistance(var_01,var_00.origin,500,1);
		if(isdefined(var_01) && var_01.size > 0)
		{
			drone_investigate_thread(undefined,var_01[0],var_01[0].origin[2] + 500,var_00.origin);
		}
	}
}

//Function Number: 79
drone_security_bays_open(param_00)
{
	if(!isdefined(self.bays_open))
	{
		self.bays_open = 0;
	}

	if(self.bays_open != param_00)
	{
		self.bays_open = param_00;
		if(param_00)
		{
			soundscripts\_snd_playsound::snd_play_linked("sdrone_wpn_bays_open");
			playfxontag(level._effect["ie_drone_gun_lights"],self,"tag_origin");
			self setanimrestart(%ie_drone_deploy,1,0,1);
			self setanim(%ie_drone_retract,0,0,1);
			wait(getanimlength(%ie_drone_deploy));
			return;
		}

		soundscripts\_snd_playsound::snd_play_linked("sdrone_wpn_bays_close");
		stopfxontag(level._effect["ie_drone_gun_lights"],self,"tag_origin");
		self setanimrestart(%ie_drone_retract,1,0,1);
		self setanim(%ie_drone_deploy,0,0,1);
		wait(getanimlength(%ie_drone_retract));
	}
}

//Function Number: 80
drone_security_prepare_patrol(param_00)
{
	self notify("drone_security_prepare_attack");
	self notify("drone_security_prepare_patrol");
	self endon("drone_security_prepare_attack");
	self endon("drone_security_prepare_patrol");
	self vehicle_setspeedimmediate(0.05,0.05,0.05);
	if(gettime() - level.last_drone_passive_sound > 2000)
	{
		var_01 = level.player.closest_drone;
		if(isdefined(var_01))
		{
			level.last_drone_passive_sound = gettime();
			var_01 soundscripts\_snd_playsound::snd_play_linked("sdrone_voc_curious");
		}

		if(!param_00)
		{
			wait(0.75);
		}
	}

	if(!param_00)
	{
		drone_security_bays_open(0);
		wait(0.5);
	}

	init_class_motion();
}

//Function Number: 81
drone_abort_path()
{
	if(isdefined(self.attachedpath))
	{
		self.prev_attachedpath = self.attachedpath;
		var_00 = self gettagorigin("tag_origin");
		self.reached_node = 1;
		self notify("newpath");
		self vehicle_helisetai(var_00,0,0,0,1,0,self gettagangles("tag_origin")[1],0,0,1,0,0,1,1);
	}
}

//Function Number: 82
drone_security_prepare_attack(param_00)
{
	self notify("drone_security_prepare_attack");
	self notify("drone_security_prepare_patrol");
	self endon("drone_security_prepare_attack");
	self endon("drone_security_prepare_patrol");
	self endon("death");
	thread drone_security_prepare_attack_relay(randomfloatrange(0.3,0.6));
	drone_abort_path();
	self vehicle_setspeedimmediate(0.05,0.05,0.05);
	self setlookatent(level.player);
	if(gettime() - level.last_drone_attacking_sound > 6000)
	{
		var_01 = level.player.closest_drone;
		if(isdefined(var_01))
		{
			level.last_drone_attacking_sound = gettime();
			var_01 soundscripts\_snd_playsound::snd_play_linked("sdrone_alert");
		}

		if(!param_00)
		{
			wait(0.75);
		}
	}

	if(!param_00)
	{
		drone_security_bays_open(1);
		wait(0.5);
	}

	thread flying_attack_drone_logic();
	thread pdrone_targeting(1);
	self notify("reached_dynamic_path_end");
	wait(0.05);
	self setlookatent(level.player);
	self setmaxpitchroll(80,drone_parm("rollmax"));
}

//Function Number: 83
drone_mode_population(param_00)
{
	if(!isdefined(level.active_drones))
	{
		return 0;
	}

	var_01 = 0;
	foreach(var_03 in level.active_drones)
	{
		if(isdefined(var_03) && var_03.mode == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 84
drone_security_prepare_attack_relay(param_00)
{
	self notify("drone_security_prepare_attack_relay");
	self endon("drone_security_prepare_attack_relay");
	self endon("drone_security_prepare_attack");
	self endon("drone_security_prepare_patrol");
	self endon("drone_set_mode");
	self endon("death");
	wait(param_00);
	while(isdefined(self) && drone_mode_population("attack") >= 4)
	{
		wait(1);
	}

	if(!isdefined(self))
	{
		return;
	}

	var_01 = sortbydistance(level.active_drones,self.origin);
	foreach(var_03 in var_01)
	{
		if(var_03 != self && distancesquared(var_03.origin,self.origin) < 1000000 && !isdefined(var_03.mode) || var_03.mode != "attack")
		{
			var_03 drone_set_mode("attack");
			break;
		}
	}
}

//Function Number: 85
drone_wait_for_attack()
{
	self notify("drone_wait_for_attack");
	self endon("death");
	self endon("drone_wait_for_attack");
	var_00 = common_scripts\utility::waittill_any_return("attack","damage");
	if(!common_scripts\utility::flag("_stealth_spotted"))
	{
		level.player soundscripts\_snd_playsound::snd_play_2d("irons_spotted_alert");
	}

	common_scripts\utility::flag_set("_stealth_spotted");
	if(isdefined(self))
	{
		thread drone_set_mode("attack");
	}
}