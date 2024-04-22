/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _cover_drone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 44
 * Decompile Time: 678 ms
 * Timestamp: 4/22/2024 2:04:44 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	maps\_vehicle::build_template("cover_drone",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_mobile_cover_drone);
	maps\_vehicle::build_life(2000);
	build_cover_death(param_02);
	maps\_vehicle::build_team("allies");
	precachestring(&"COVER_DRONE_LINK");
	precachestring(&"COVER_DRONE_LINK_KB");
	precachestring(&"COVER_DRONE_UNLINK");
	precachestring(&"COVER_DRONE_UNLINK_KB");
	precachestring(&"COVER_DRONE_LOWER_SHIELD");
	precachestring(&"COVER_DRONE_LOWER_SHIELD_KB");
	precachemodel("vehicle_mobile_cover_tactics_friendly");
	precachemodel("vehicle_mobile_cover_active");
	level._effect["link_light"] = loadfx("vfx/lights/light_drone_beacon_green_sm_nolight");
	level._effect["unlink_light"] = loadfx("vfx/lights/light_drone_beacon_red_sm_nolight");
	level.player thread record_grenade_throw_times();
	level.player thread record_grenade_rising_edges();
}

//Function Number: 2
cover_drone_disable()
{
	if(isdefined(self.linked_player))
	{
		player_unlink_from_cover();
	}

	self.cover_drone_disabled = 1;
}

//Function Number: 3
cover_drone_enable()
{
	self.cover_drone_disabled = undefined;
}

//Function Number: 4
build_cover_death(param_00)
{
	maps\_vehicle::build_deathmodel("moving_cover_standing_01","moving_cover_standing_destroyed_01",0.05,param_00);
}

//Function Number: 5
init_mobile_cover_drone()
{
	level.player endon("death");
	self.is_mobile_cover = 1;
	waittillframeend;
	self.original_model = self.model;
	self.tactics_model = "vehicle_mobile_cover_tactics_friendly";
	self.tactics_type = "tool";
	self.no_line = 1;
	self.description = "Mobile Cover";
	maps\_warzone_tactics::add_object_to_tactics_system(self);
	self.window_position = "up";
	self.extra_slow_player = 0;
	self.yaw_scale = 1;
	self.position_error = (0,0,0);
	self.accumulated_restore = 0;
	self.godmode = 1;
	thread mobile_cover_impulse();
	self.link_trigger = common_scripts\utility::spawn_tag_origin();
	self.link_trigger maps\_utility::addhinttrigger(&"COVER_DRONE_LINK",&"COVER_DRONE_LINK_KB");
	self.unlink_trigger = common_scripts\utility::spawn_tag_origin();
	self.unlink_trigger maps\_utility::addhinttrigger(&"COVER_DRONE_UNLINK",&"COVER_DRONE_UNLINK_KB");
	thread mobile_cover_drone_trigger_think();
	thread mobile_cover_drone_hint_think();
}

//Function Number: 6
mobile_cover_drone_trigger_think()
{
	while(isdefined(self))
	{
		self.link_trigger waittill("trigger");
		if(should_show_prompt(level.player))
		{
			thread player_link_to_cover(level.player);
			player_wait_and_unlink();
		}
	}
}

//Function Number: 7
mobile_cover_drone_hint_think()
{
	var_00 = 0.5;
	var_01 = 0.5;
	playfxontag(common_scripts\utility::getfx("unlink_light"),self,"tag_fx");
	var_02 = 0;
	var_03 = 0;
	while(isdefined(self))
	{
		if(isdefined(self.linked_player))
		{
			self.link_trigger makeglobalunusable();
			var_02 = 0;
			var_03 = var_03 + 0.05;
			if(var_03 > var_00)
			{
				self.unlink_trigger makeglobalusable(-999);
			}

			continue;
		}

		self.unlink_trigger makeglobalunusable();
		var_02 = var_02 + 0.05;
		var_03 = 0;
		if(var_02 > var_01 && should_show_prompt(level.player))
		{
			self.link_trigger makeglobalusable(-999);
			continue;
		}

		self.link_trigger makeglobalunusable();
		wait 0.05;
	}
}

//Function Number: 8
should_show_prompt(param_00)
{
	if(isdefined(self.cover_drone_disabled))
	{
		return 0;
	}

	if(isdefined(self.linked_player))
	{
		return 0;
	}

	if(isdefined(param_00.linked_to_cover))
	{
		return 0;
	}

	if(isdefined(param_00.disable_cover_drone))
	{
		return 0;
	}

	var_01 = anglestoright(self.angles);
	var_02 = pointonsegmentnearesttopoint(self.origin + 18 * var_01,self.origin - 18 * var_01,param_00.origin) - param_00.origin;
	if(length(var_02) > 64)
	{
		return 0;
	}

	var_03 = vectornormalize(var_02);
	if(vectordot(anglestoforward(param_00.angles),common_scripts\utility::flat_origin(var_03)) < cos(45))
	{
		return 0;
	}

	if(vectordot(var_03,anglestoforward(self.angles)) < 0)
	{
		return 0;
	}

	if(abs(angleclamp180(param_00.angles[1] - self.angles[1])) > 45)
	{
		return 0;
	}

	if(distance(param_00.origin + anglestoforward(param_00.angles) * 35,self.origin) > 45)
	{
		return 0;
	}

	if(anglestoup(self.angles)[2] < 0.7660444)
	{
		return 0;
	}

	if(abs(self.origin[2] - param_00.origin[2]) > 30)
	{
		return 0;
	}

	return 1;
}

//Function Number: 9
player_link_to_cover(param_00)
{
	self.linked_player = param_00;
	vehicle_scripts\_cover_drone_aud::snd_init_cover_drone();
	self.linked_player.linked_to_cover = self;
	maps\_warzone_tactics::remove_object_from_tactics_system(self);
	self.linked_player endon("death");
	self.linked_player player_update_slow_aim(1,self);
	self.linked_player allowjump(0);
	level.old_viewbobamplitudestanding = getdvar("bg_viewBobAmplitudeStanding");
	level.old_viewbobamplitudeducked = getdvar("bg_viewBobAmplitudeDucked");
	level.old_viewbobamplitudesprinting = getdvar("bg_viewBobAmplitudeSprinting");
	setsaveddvar("bg_viewBobAmplitudeStanding","0 0");
	setsaveddvar("bg_viewBobAmplitudeDucked","0 0");
	setsaveddvar("bg_viewBobAmplitudeSprinting","0 0");
	self.window_position = "up";
	self.blend = 0;
	self.linked_player notify("player_linked_to_cover");
	if(!isdefined(self.dummy_player))
	{
		self.dummy_player = common_scripts\utility::spawn_tag_origin();
	}

	self.dummy_player.origin = self.linked_player.origin;
	self.dummy_player.angles = (0,self.linked_player getgunangles()[1],0);
	self.dummy_player.vel = (0,0,0);
	self.tag_origin = common_scripts\utility::spawn_tag_origin();
	self.tag_origin.origin = self.dummy_player.origin;
	self.tag_origin.angles = self.dummy_player.angles;
	self.linked_player playerlinktodelta(self.tag_origin,"tag_origin",1,0,0,80,80,0,0);
	self.ads = self.linked_player adsbuttonpressed();
	self.linked_player enablemousesteer(1);
	maps\_variable_grenade::change_threat_detection_style("detectable");
	stopfxontag(common_scripts\utility::getfx("unlink_light"),self,"tag_fx");
	playfxontag(common_scripts\utility::getfx("link_light"),self,"tag_fx");
	self overridematerial("mtl_mobile_cover_glass_vm","mtl_mobile_cover_glass_vm_active");
	self makevehiclenotcollidewithplayers(1);
	thread player_ads_think();
	thread mobile_cover_link_think();
	thread mobile_cover_sound_think();
	thread player_unlink_on_sprint();
	thread player_unlink_on_death();
	thread player_enable_highlight();
	thread pass_mech_melee_damage_to_player();
}

//Function Number: 10
pass_mech_melee_damage_to_player()
{
	if(!isdefined(self.linked_player))
	{
		return;
	}

	self.linked_player endon("death");
	self.linked_player endon("player_unlinked_from_cover");
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(var_01))
		{
			if(isdefined(var_01.team) && var_01.team == self.linked_player.team)
			{
				continue;
			}

			if(!isdefined(var_01.mech))
			{
				continue;
			}

			if(var_04 != "MOD_MELEE")
			{
				continue;
			}

			var_0A = distance(self.origin,var_01.origin);
			var_0B = var_03 + var_02 * var_0A * -1;
			self.linked_player dodamage(var_00,var_0B,var_01);
		}
	}
}

//Function Number: 11
mimic_player_move(param_00,param_01,param_02,param_03)
{
	var_04 = 0.05;
	var_05 = 100;
	var_06 = 5.5;
	var_07 = length(param_01.vel);
	if(var_07 < 1)
	{
		param_01.vel = (0,0,0);
	}
	else
	{
		if(var_07 < var_05)
		{
			var_08 = var_05;
		}
		else
		{
			var_08 = var_08;
		}

		var_09 = var_08 * var_06 * var_04;
		var_0A = var_07 - var_09;
		if(var_0A < 0)
		{
			var_0A = 0;
		}

		param_01.vel = var_0A / var_07 * param_01.vel;
	}

	var_0B = sqrt(param_02 * param_02 + param_03 * param_03);
	if(param_02 < 0)
	{
		var_0C = abs(param_02 * 0.7);
	}
	else
	{
		var_0C = abs(param_03);
	}

	var_0D = abs(param_03 * 0.8);
	var_0E = max(var_0C,var_0D);
	if(var_0E <= 0)
	{
		var_0F = 0;
	}
	else
	{
		var_0F = getdvarint("g_speed",190) * var_0F / 127 * var_0C;
	}

	if(level.player maps\_utility::isads())
	{
		var_0F = var_0F * 0.4;
	}

	var_10 = param_00 getstance();
	var_11 = 9;
	if(var_10 == "prone")
	{
		var_0F = var_0F * 0.15;
		var_11 = 19;
	}
	else if(var_10 == "crouch")
	{
		var_0F = var_0F * 0.65;
		var_11 = 12;
	}

	var_12 = param_00 playerads();
	if(var_12 > 0.5)
	{
		var_0F = var_0F * 0.5;
	}

	var_0F = var_0F * param_00.move_scale;
	var_13 = anglestoforward(param_01.angles);
	var_14 = anglestoright(param_01.angles);
	var_15 = param_02 * var_13 + param_03 * var_14;
	var_16 = length(var_15);
	var_17 = vectornormalize(var_15);
	var_16 = var_16 * var_0F;
	var_18 = playerphysicstraceinfo(param_01.origin + (0,0,100),param_01.origin + (0,0,-100),self);
	var_19 = var_18["normal"];
	var_15 = maps\_pmove::pm_projectvelocity(var_15,var_19);
	var_1A = vectordot(param_01.vel,var_17);
	var_1B = var_16 - var_1A;
	if(var_1B <= 0)
	{
	}
	else
	{
		if(var_16 < var_05)
		{
			var_08 = var_05;
		}
		else
		{
			var_08 = var_17;
		}

		var_1C = var_11 * var_04 * var_08;
		if(var_1C > var_1B)
		{
			var_1C = var_1B;
		}

		param_01.vel = param_01.vel + var_1C * var_17;
	}

	param_01.vel = maps\_pmove::pm_projectvelocity(param_01.vel,var_19);
	if(param_01.vel[0] != 0 || param_01.vel[1] != 0)
	{
		maps\_pmove::pm_stepslidemove(param_01,var_19,0);
	}

	var_1D = playerphysicstrace(param_01.origin,param_01.origin + (0,0,-5),self);
	param_01.origin = var_1D;
}

//Function Number: 12
mobile_cover_dummy_player_think()
{
	var_00 = self.linked_player getnormalizedmovement();
	var_01 = self.linked_player getnormalizedcameramovements();
	var_01 = (var_01[0],-1 * var_01[1],0);
	var_02 = self.linked_player getaimassistdeltas();
	var_03 = 0.05;
	var_04 = self.dummy_player.origin;
	mimic_player_move(self.linked_player,self.dummy_player,127 * var_00[0],127 * var_00[1]);
	var_05 = common_scripts\utility::flat_origin(self.position_error);
	var_06 = length(var_05);
	var_07 = 32;
	var_08 = 10;
	var_09 = vectordot(var_05,self.dummy_player.vel * var_03);
	if(var_06 > var_07 && var_09 > 0)
	{
		if(self.accumulated_restore < var_08)
		{
			self.accumulated_restore = self.accumulated_restore + abs(var_09);
			self.dummy_player.vel = (0,0,0);
			self.dummy_player.origin = var_04;
		}
	}
	else
	{
		self.accumulated_restore = self.accumulated_restore - 2;
		if(self.accumulated_restore < 0)
		{
			self.accumulated_restore = 0;
		}
	}

	if(var_02[1])
	{
		var_0A = var_03 * var_02[1] * self.yaw_scale;
	}
	else
	{
		var_0A = 2 * var_02[1] * self.yaw_scale;
	}

	var_0B = self.dummy_player.angles[1] + var_0A;
	if(self.linked_player adsbuttonpressed() && !self.ads)
	{
		self.ads = 1;
		var_0C = self.linked_player getaimassisttargetangles();
		if(var_0C[1] != 0 || var_0C[0] != 0)
		{
			var_0B = var_0C[1];
		}
	}
	else
	{
		self.ads = self.linked_player adsbuttonpressed();
	}

	self.dummy_player.angles = (self.dummy_player.angles[0],angleclamp180(var_0B),self.dummy_player.angles[2]);
	var_0D = anglestoforward(self.angles);
	var_0E = vectordot(var_0D,self.origin - self.dummy_player.origin);
	if(var_0E < 30)
	{
		var_0F = 30 - var_0E;
		var_10 = self.dummy_player.origin - var_0D * var_0F;
		var_11 = playerphysicstraceinfo(var_10 + (0,0,8),var_10 - (0,0,8),self);
		if(var_11["fraction"] > 0)
		{
			self.dummy_player.origin = var_11["position"];
		}
		else
		{
			self.dummy_player.origin = var_04;
		}
	}

	return self.dummy_player.vel;
}

//Function Number: 13
mobile_cover_link_think()
{
	self endon("stop_mobile_cover_link_think");
	self endon("death");
	self.linked_player endon("death");
	mobile_cover_link_think_angle_controller();
}

//Function Number: 14
mobile_cover_link_think_angle_controller()
{
	var_00 = 33;
	var_01 = 39;
	var_02 = 12;
	var_03 = 4;
	var_04 = 25;
	var_05 = 0.3;
	var_06 = 0.6;
	var_07 = 0.1;
	var_08 = 0.8;
	var_09 = 0.8;
	var_0A = 0.1;
	var_0B = filter_lead_controller_init(self.dummy_player.origin,var_05,var_06,var_07);
	var_0C = filter_lead_controller_init(self.dummy_player.angles[1],var_08,var_09,var_0A,1);
	var_0D = self.origin;
	var_0E = self.angles;
	for(;;)
	{
		var_0F = mobile_cover_dummy_player_think();
		var_10 = var_0B [[ var_0B.update_func ]](self.dummy_player.origin);
		var_10 = (var_10[0],var_10[1],var_0D[2]);
		var_11 = var_0C [[ var_0C.update_func ]](self.dummy_player.angles[1]);
		var_12 = var_0D - var_10;
		var_13 = vectortoangles(var_12);
		var_14 = var_13[1];
		var_15 = length(var_12);
		var_16 = 1;
		var_17 = clamp(var_15,var_00 * var_16,var_01 * var_16);
		var_18 = var_17 - var_15;
		var_19 = maps\_utility::linear_interpolate(self.blend,var_02,var_03);
		var_1A = atan(var_19 / var_15);
		var_1A = var_1A * maps\_shg_utility::linear_map_clamp(length(var_0F),10,50,1,0);
		var_1B = angleclamp180(var_11 - var_14);
		self.extra_slow_player = 0;
		if(abs(var_1B) < var_1A)
		{
			var_1C = 0;
		}
		else
		{
			var_1C = var_1B - var_1A * common_scripts\utility::sign(var_1B);
			self.extra_slow_player = 1;
		}

		var_1D = angleclamp(var_14 + var_1C);
		var_1E = var_10 + anglestoforward((0,var_1D,0)) * var_17;
		var_1F = (0,var_11,0);
		self.tag_origin unlink();
		self.tag_origin.origin = self.dummy_player.origin;
		self.tag_origin.angles = self.dummy_player.angles;
		drive_cover(var_1E,var_1F);
		wait 0.05;
		var_0D = self.origin;
		var_0E = self.angles;
	}
}

//Function Number: 15
mobile_cover_vehicle_controller()
{
	for(;;)
	{
		var_00 = self.dummy_player.origin + anglestoforward(self.dummy_player.angles) * 35;
		var_01 = self.dummy_player.angles;
		drive_cover(var_00,var_01);
		wait 0.05;
	}
}

//Function Number: 16
drive_cover(param_00,param_01)
{
	var_02 = 0.7386363;
	foreach(var_04 in getaiarray("all"))
	{
		if(isalive(var_04) && var_04 istouching(self))
		{
			var_05 = param_00 - self.origin;
			var_06 = vectornormalize(self.origin - var_04.origin);
			var_07 = vectordot(var_05,var_06);
			if(var_07 < 0)
			{
				param_00 = param_00 - var_06 * var_07;
				param_01 = self.angles;
			}
		}
	}

	var_09 = param_00 - self.origin;
	var_0A = common_scripts\utility::flat_origin(var_09);
	var_0B = length(var_0A);
	self.position_error = var_09;
	if(var_0B > 45)
	{
		soundscripts\_snd::snd_message("cdrn_auto_unlink");
		thread player_unlink_from_cover();
	}

	if(abs(angleclamp180(param_01[1] - self.angles[1])) > 45)
	{
		soundscripts\_snd::snd_message("cdrn_auto_unlink");
		thread player_unlink_from_cover();
	}

	if(anglestoup(self.angles)[2] < 0.7660444)
	{
		soundscripts\_snd::snd_message("cdrn_auto_unlink");
		thread player_unlink_from_cover();
	}

	if(abs(self.origin[2] - self.linked_player.origin[2]) > 30)
	{
		soundscripts\_snd::snd_message("cdrn_auto_unlink");
		thread player_unlink_from_cover();
	}

	var_0C = distance2d(self.origin,param_00) * var_02;
	var_0D = self.dummy_player maps\_shg_utility::get_differentiated_speed() / 17.6;
	var_0C = clamp(var_0C,0.01,var_0D + 5);
	self vehicle_rotateyaw(param_01[1]);
	self vehicledriveto(param_00,var_0C);
}

//Function Number: 17
filter_lead_controller_init(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.is_filter_lead_controller = 1;
	var_05.update_func = ::filter_lead_controller_update;
	var_05.position_smoothing = param_01;
	var_05.velocity_smoothing = param_02;
	var_05.lead_time = param_03;
	var_05.is_angles = isdefined(param_04) && param_04;
	if(var_05.is_angles)
	{
		param_00 = angleclamp180(param_00);
	}

	var_05.target_position = param_00;
	var_05.smooth_target_position = param_00;
	var_05.smooth_target_velocity = param_00 * 0;
	return var_05;
}

//Function Number: 18
filter_lead_controller_update(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.05;
	}

	if(self.is_angles)
	{
		param_00 = angleclamp180(param_00);
	}

	var_02 = param_00 - self.target_position;
	if(self.is_angles)
	{
		var_02 = angleclamp180(var_02);
	}

	var_03 = var_02 / param_01;
	self.target_position = param_00;
	if(self.is_angles)
	{
		self.smooth_target_position = angle_interpolate(self.position_smoothing,param_00,self.smooth_target_position);
	}
	else
	{
		self.smooth_target_position = maps\_utility::linear_interpolate(self.position_smoothing,param_00,self.smooth_target_position);
	}

	self.smooth_target_velocity = maps\_utility::linear_interpolate(self.velocity_smoothing,var_03,self.smooth_target_velocity);
	var_04 = self.smooth_target_position + self.smooth_target_velocity * self.lead_time;
	if(self.is_angles)
	{
		var_04 = angleclamp(var_04);
	}

	return var_04;
}

//Function Number: 19
angle_interpolate(param_00,param_01,param_02)
{
	return angleclamp180(param_01 + angleclamp180(param_02 - param_01) * param_00);
}

//Function Number: 20
sigmoid(param_00)
{
	var_01 = [[0,0],[0.3,0.05],[0.4,0.2],[0.5,0.5],[0.6,0.8],[0.7,0.95],[1,1]];
	foreach(var_08, var_03 in var_01)
	{
		if(var_03[0] >= param_00)
		{
			if(var_08 > 0)
			{
				var_04 = var_01[var_08 - 1];
				var_05 = param_00 - var_04[0];
				var_06 = var_03[0] - var_04[0];
				var_07 = var_05 / var_06;
				param_00 = var_07 * var_03[1] - var_04[1] + var_04[1];
				return param_00;
			}
			else
			{
				return var_06[1];
			}
		}
	}

	return var_08;
}

//Function Number: 21
player_ads_think()
{
	self.linked_player endon("death");
	self.linked_player endon("player_unlinked_from_cover");
	self endon("death");
	self notify("new_ads_think");
	thread close_ads_window_on_unlink();
	self.window_position = "up";
	var_00 = 0.5;
	var_01 = -0.2;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	thread ads_hint_display();
	for(;;)
	{
		waittillframeend;
		var_05 = self.linked_player adsbuttonpressed() || self.linked_player is_really_throwing_grenade();
		if(var_05 || var_03 || var_04 > 0)
		{
			self.blend = self.blend + var_00;
			if(var_05)
			{
				var_03 = 1;
			}
		}
		else
		{
			self.blend = self.blend + var_01;
		}

		if(var_04 > 0)
		{
			var_04--;
		}

		self.blend = clamp(self.blend,0,1);
		if(self.blend == 1)
		{
			var_03 = 0;
			if(var_05)
			{
				var_04 = 3;
			}
		}

		if(var_02 == 1 && self.blend != 1)
		{
			thread ads_hint_display();
		}
		else if(var_02 != 1 && self.blend == 1)
		{
			thread ads_hint_clear();
		}

		play_window_sound(var_02,self.blend);
		var_06 = sigmoid(self.blend);
		self setanim(%mobile_cover_window_down_pose,var_06,0.05,1);
		self setanim(%mobile_cover_window_up_pose,1 - var_06,0.05,1);
		self.linked_player player_update_slow_aim(1,self);
		if(self.blend > 0.5)
		{
			self.window_position = "down";
			maps\_variable_grenade::change_threat_detection_style("enhanceable");
		}
		else
		{
			self.window_position = "up";
			maps\_variable_grenade::change_threat_detection_style("detectable");
		}

		var_02 = self.blend;
		wait 0.05;
	}
}

//Function Number: 22
play_window_sound(param_00,param_01)
{
	if(param_00 == 0 && param_01 != 0)
	{
		self playsound("cdrn_window_open");
		return;
	}

	if(param_00 == 1 && param_01 != 1)
	{
		self playsound("cdrn_window_close");
		return;
	}

	if(param_00 != 0 && param_01 == 0)
	{
		self playsound("cdrn_window_open_latch");
		return;
	}

	if(param_00 != 1 && param_01 == 1)
	{
		self playsound("cdrn_window_close_latch");
		return;
	}
}

//Function Number: 23
ads_hint_display()
{
	self notify("ads_hint_state_change");
	self endon("ads_hint_state_change");
	var_00 = create_ads_hint_string();
	common_scripts\utility::waittill_any_ents(self,"ads_hint_clear",self.linked_player,"player_unlinked_from_cover");
	var_00 destroy();
}

//Function Number: 24
ads_hint_clear()
{
	self notify("ads_hint_clear");
}

//Function Number: 25
close_ads_window_on_unlink()
{
	self endon("new_ads_think");
	self.linked_player endon("death");
	self endon("death");
	self.linked_player waittill("player_unlinked_from_cover");
	var_00 = -0.2;
	var_01 = self.blend;
	while(self.blend > 0)
	{
		self.blend = self.blend + var_00;
		self.blend = clamp(self.blend,0,1);
		if(self.blend > 0.5)
		{
			self.window_position = "down";
		}
		else
		{
			self.window_position = "up";
		}

		play_window_sound(var_01,self.blend);
		var_02 = sigmoid(self.blend);
		self setanim(%mobile_cover_window_down_pose,var_02,0.05,1);
		self setanim(%mobile_cover_window_up_pose,1 - var_02,0.05,1);
		var_01 = self.blend;
		wait(0.05);
	}
}

//Function Number: 26
player_update_slow_aim(param_00,param_01)
{
	if(param_00)
	{
		var_02 = self getlocalplayerprofiledata("viewSensitivity");
		var_03 = pow(self playerads(),3);
		var_04 = maps\_utility::linear_interpolate(var_03,0.4807692,1.902587) / var_02;
		if(param_01.extra_slow_player)
		{
			var_04 = var_04 * 0.75;
		}

		var_04 = clamp(var_04,0.01,0.99);
		var_05 = clamp(var_04 * 6,0.01,0.99);
		self enableslowaim(var_05,var_04);
		self setmovespeedscale(0.6);
		self.yaw_scale = maps\_utility::linear_interpolate(var_03,0.4807692,0.1201923);
		self.move_scale = 0.6;
		return;
	}

	self.yaw_scale = 1;
	self.move_scale = 1;
	self disableslowaim();
	self setmovespeedscale(1);
}

//Function Number: 27
player_wait_and_unlink()
{
	self.linked_player endon("player_unlinked_from_cover");
	self.unlink_trigger waittill("trigger");
	thread player_unlink_from_cover();
}

//Function Number: 28
player_unlink_on_sprint()
{
	if(!isdefined(self.linked_player))
	{
		return;
	}

	self.linked_player endon("death");
	self.linked_player endon("player_unlinked_from_cover");
	self endon("death");
	for(;;)
	{
		if(self.linked_player sprintbuttonpressed() && !self.ads)
		{
			player_unlink_from_cover();
			break;
		}

		wait 0.05;
	}
}

//Function Number: 29
player_unlink_on_death()
{
	if(!isdefined(self.linked_player))
	{
		return;
	}

	self.linked_player endon("player_unlinked_from_cover");
	self.linked_player waittill("death");
	player_unlink_from_cover();
}

//Function Number: 30
player_unlink_from_cover()
{
	self notify("stop_mobile_cover_link_think");
	self.linked_player.linked_to_cover = undefined;
	vehicle_scripts\_cover_drone_aud::snd_stop_cover_drone(1,1.5);
	maps\_warzone_tactics::add_object_to_tactics_system(self);
	self unlink();
	self.linked_player unlink();
	self.tag_origin delete();
	self.tag_origin = undefined;
	self.dummy_player delete();
	self.dummy_player = undefined;
	self.linked_player enablemousesteer(0);
	thread unlink_failsafe();
	setsaveddvar("bg_viewBobAmplitudeStanding",level.old_viewbobamplitudestanding);
	setsaveddvar("bg_viewBobAmplitudeDucked",level.old_viewbobamplitudeducked);
	setsaveddvar("bg_viewBobAmplitudeSprinting",level.old_viewbobamplitudesprinting);
	self.linked_player allowjump(1);
	self.linked_player enable_weapon_pickup_wrapper();
	self.linked_player player_update_slow_aim(0);
	self.linked_player pushplayervector((0,0,0),1);
	maps\_variable_grenade::change_threat_detection_style("enhanceable");
	self vehicledriveto(self.origin,0);
	stopfxontag(common_scripts\utility::getfx("link_light"),self,"tag_fx");
	playfxontag(common_scripts\utility::getfx("unlink_light"),self,"tag_fx");
	self overridematerialreset();
	var_00 = self.linked_player;
	self.linked_player = undefined;
	var_00 notify("player_unlinked_from_cover");
}

//Function Number: 31
unlink_failsafe()
{
	if(isdefined(self.unlink_failsafe_running))
	{
		return;
	}

	self.unlink_failsafe_running = 1;
	self endon("death");
	level.player endon("death");
	while(level.player istouching(self))
	{
		self vehicle_removebrushmodelcollision();
		wait 0.05;
		self vehicle_assignbrushmodelcollision();
	}

	self.unlink_failsafe_running = undefined;
}

//Function Number: 32
get_mobile_cover_base_from_ent(param_00)
{
	if(isdefined(param_00.is_mobile_cover))
	{
		return param_00;
	}

	return undefined;
}

//Function Number: 33
player_enable_highlight()
{
	if(!isdefined(self.linked_player))
	{
		return;
	}

	self.linked_player endon("death");
	var_00 = newclienthudelem(self.linked_player);
	var_00.color = (1,0.05,0.025);
	var_00.alpha = 0.01;
	var_00 setradarhighlight(-1);
	self.linked_player waittill("player_unlinked_from_cover");
	var_00 destroy();
}

//Function Number: 34
create_trigger_hint_string(param_00)
{
	var_01 = level.player maps\_hud_util::createclientfontstring("default",1.5);
	var_01.alpha = 0.7;
	var_01.alignx = "center";
	var_01.aligny = "middle";
	var_01.y = 130;
	var_01.horzalign = "center";
	var_01.vertalign = "middle";
	var_01.foreground = 0;
	var_01.hidewhendead = 1;
	var_01.hidewheninmenu = 1;
	if(param_00 == "link")
	{
		var_01 settext(&"COVER_DRONE_LINK");
	}
	else
	{
		var_01 settext(&"COVER_DRONE_UNLINK");
	}

	return var_01;
}

//Function Number: 35
create_ads_hint_string()
{
	var_00 = level.player maps\_hud_util::createclientfontstring("default",1.5);
	var_00.alpha = 0.7;
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.y = 115;
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.foreground = 0;
	var_00.hidewhendead = 1;
	var_00.hidewheninmenu = 1;
	if(level.player usinggamepad())
	{
		var_00 settext(&"COVER_DRONE_LOWER_SHIELD");
	}
	else if(getkeybinding("+toggleads_throw")["count"] > 0)
	{
		var_00 settext(&"COVER_DRONE_LOWER_SHIELD_KB");
	}
	else
	{
		var_00 settext(&"COVER_DRONE_LOWER_SHIELD");
	}

	return var_00;
}

//Function Number: 36
mobile_cover_sound_think()
{
	if(!isalive(self.linked_player))
	{
		return;
	}

	var_00 = common_scripts\utility::spawn_tag_origin();
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_00 linkto(self,"",(0,18,0),(0,0,0));
	var_01 linkto(self,"",(0,-18,0),(0,0,0));
	thread mobile_cover_sound_loop(var_00);
	thread mobile_cover_sound_loop(var_01);
	self.linked_player common_scripts\utility::waittill_either("death","player_unlinked_from_cover");
	var_00 delete();
	var_01 delete();
}

//Function Number: 37
mobile_cover_sound_loop(param_00)
{
	param_00 endon("death");
	var_01 = 0.6;
	var_02 = 17.6;
	var_03 = 264;
	var_04 = 0.4;
	var_05 = 0.5;
	var_06 = param_00.origin;
	var_07 = 0;
	for(;;)
	{
		waittillframeend;
		var_08 = length(param_00.origin - var_06) * 20;
		var_07 = maps\_utility::linear_interpolate(var_01,var_08,var_07);
		var_06 = param_00.origin;
		var_09 = maps\_shg_utility::linear_map_clamp(var_07,0,var_03,0,1);
		var_09 = clamp(var_09,0.002,3.99);
		param_00 setpitch(var_09,0.05);
		if(var_07 > var_02)
		{
			param_00 setvolume(maps\_shg_utility::linear_map_clamp(var_07,0,var_03,var_04,var_05),0.05);
		}
		else
		{
			param_00 setvolume(0,0.05);
		}

		wait 0.05;
	}
}

//Function Number: 38
mobile_cover_impulse()
{
	self endon("death");
	var_00 = self.origin;
	for(;;)
	{
		if(isdefined(self.linked_player))
		{
			if(distance(self.origin,var_00) > 6)
			{
				var_00 = self.origin;
				physicsexplosioncylinder(self.origin,26,24,0.25);
			}

			wait(0.1);
			continue;
		}

		wait(0.5);
	}
}

//Function Number: 39
enable_weapon_pickup_wrapper()
{
	thread enable_weapon_pickup_wrapper_internal();
}

//Function Number: 40
enable_weapon_pickup_wrapper_internal()
{
	self endon("death");
	self endon("stop_enable_weapon_pickup_wrapper");
	wait(2);
	maps\_utility::playerallowweaponpickup(1);
}

//Function Number: 41
disable_weapon_pickup_wrapper()
{
	self notify("stop_enable_weapon_pickup_wrapper");
	maps\_utility::playerallowweaponpickup(0);
}

//Function Number: 42
record_grenade_throw_times()
{
	self.last_grenade_throw_time = 0;
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		self.last_grenade_throw_time = gettime();
	}
}

//Function Number: 43
record_grenade_rising_edges()
{
	self.is_really_throwing_grenade_rising_edge_time = 0;
	var_00 = 0;
	for(;;)
	{
		if(self isthrowinggrenade(1) && !var_00)
		{
			self.is_really_throwing_grenade_rising_edge_time = gettime();
		}

		var_00 = self isthrowinggrenade(1);
		wait 0.05;
	}
}

//Function Number: 44
is_really_throwing_grenade()
{
	var_00 = 300;
	if(!self isthrowinggrenade(1))
	{
		return 0;
	}

	if(self.last_grenade_throw_time > self.is_really_throwing_grenade_rising_edge_time && gettime() - self.last_grenade_throw_time > var_00)
	{
		return 0;
	}

	return 1;
}