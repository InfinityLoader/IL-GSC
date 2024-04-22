/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _vehicle_turret_ai.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 278 ms
 * Timestamp: 4/22/2024 2:05:38 AM
*******************************************************************/

//Function Number: 1
vehicle_turret_default_ai()
{
	self endon("death");
	self endon("vehicle_dismount");
	self endon("stop_vehicle_turret_ai");
	thread aim_at_my_attacker();
	thread vehicle_targeting();
	thread update_aiming();
	thread vehicle_firing();
}

//Function Number: 2
vehicle_set_firing_disabled(param_00)
{
	self.disable_firing = param_00;
}

//Function Number: 3
vehicle_set_target_tracking_disabled(param_00)
{
	self.disable_target_tracking = param_00;
	if(param_00)
	{
		self.ai_target = undefined;
		if(0)
		{
			self.ai_target_force = undefined;
			self.ai_target_force_scripted = undefined;
			self.ai_target_force_damaged = undefined;
		}

		self clearturrettarget();
	}
}

//Function Number: 4
vehicle_set_threat_grenade_response(param_00)
{
	self endon("end_grenade_respose_function");
	self.respond_to_threat_grenade = param_00;
	if(!param_00)
	{
		self notify("end_grenade_respose_function");
		return;
	}

	while(param_00)
	{
		level.player waittill("threat_grenade_marking_started",var_01);
		self.ai_target = undefined;
		self.ai_target_force_damaged = undefined;
		foreach(var_03 in self.mgturret)
		{
			self notify("mgturret_acquire_new_target");
		}

		wait 0.05;
	}
}

//Function Number: 5
vehicle_turret_settings_shoot(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(self.vehicle_ai_settings))
	{
		self.vehicle_ai_settings = spawnstruct();
	}

	self.vehicle_ai_settings.min_fire_time = param_00;
	self.vehicle_ai_settings.max_fire_time = param_01;
	self.vehicle_ai_settings.shot_delay = param_02;
	self.vehicle_ai_settings.fire_delay = param_03;
	self.vehicle_ai_settings.avoid_players = isdefined(param_04) && param_04;
}

//Function Number: 6
vehicle_turret_settings_target(param_00)
{
	if(!isdefined(self.vehicle_ai_settings))
	{
		self.vehicle_ai_settings = spawnstruct();
	}

	self.vehicle_ai_settings.update_target_time = param_00;
}

//Function Number: 7
vehicle_set_forced_target(param_00)
{
	if(is_valid_target(param_00) && isvector(param_00) || !isvector(param_00) && !param_00 maps\_vehicle_code::is_corpse())
	{
		self.ai_target_force_scripted = param_00;
		if(!isdefined(self.disable_target_tracking) || !self.disable_target_tracking)
		{
			if(is_vector(param_00))
			{
				self setturrettargetvec(param_00);
				return;
			}

			self setturrettargetent(param_00);
			return;
		}
	}
}

//Function Number: 8
aim_at_my_attacker()
{
	self endon("death");
	self endon("vehicle_dismount");
	self endon("stop_vehicle_turret_ai");
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(isdefined(var_00) && var_00 > 0 && isdefined(var_01) && isai(var_01) && isalive(var_01) && !maps\_vehicle_code::attacker_isonmyteam(var_01) && !maps\_vehicle_code::attacker_troop_isonmyteam(var_01))
		{
			self.ai_target_force_damaged = var_01;
			waittillframeend;
			self notify("update_target");
			self.ai_target_force_damaged maps\_utility::wait_for_notify_or_timeout("death",7);
		}
	}
}

//Function Number: 9
has_forced_target_changed(param_00,param_01)
{
	if(is_vector(param_00) && is_vector(param_01))
	{
		return param_00 != param_01;
	}

	if(is_vector(param_00) != is_vector(param_01))
	{
		return 1;
	}

	return self.ai_target != self.ai_target_force;
}

//Function Number: 10
vehicle_targeting()
{
	self endon("death");
	self endon("vehicle_dismount");
	self endon("stop_vehicle_turret_ai");
	for(;;)
	{
		if(isdefined(self.ai_target_force_scripted))
		{
			self.ai_target_force = self.ai_target_force_scripted;
		}
		else if(isdefined(self.ai_target_force_damaged))
		{
			self.ai_target_force = self.ai_target_force_damaged;
		}

		if(isdefined(self.disable_target_tracking) && self.disable_target_tracking)
		{
			wait 0.05;
			continue;
		}

		if(isdefined(self.ai_target_force))
		{
			if(!is_valid_target(self.ai_target_force))
			{
				self.ai_target_force = undefined;
			}
			else if(!isdefined(self.ai_target) || has_forced_target_changed(self.ai_target_force,self.ai_target))
			{
				if((isdefined(self.ai_target_force_scripted) && self.ai_target_force == self.ai_target_force_scripted) || isdefined(self.ai_target_force_damaged) && self.ai_target_force == self.ai_target_force_damaged && !isdefined(self.ai_target))
				{
					if(isdefined(self.ai_target) && !is_vector(self.ai_target))
					{
						self.ai_target.target_score = 0;
					}

					self.ai_target = self.ai_target_force;
					if(!is_vector(self.ai_target))
					{
						self.ai_target.target_score = -50;
					}

					self notify("main_barrel_acquire_new_target");
				}
			}
		}
		else
		{
			self.ai_target = undefined;
		}

		if(isdefined(self.ai_target) && isdefined(self.reset_forced_target_if_no_line_of_sight) && self.reset_forced_target_if_no_line_of_sight && !turret_can_see_target(self.ai_target))
		{
			if(isdefined(self.ai_target_force_scripted) && self.ai_target == self.ai_target_force_scripted)
			{
				self.ai_target_force_scripted = undefined;
			}

			if(isdefined(self.ai_target_force_damaged) && self.ai_target == self.ai_target_force_damaged)
			{
				self.ai_target_force_damaged = undefined;
			}

			self.ai_target = undefined;
		}

		if(!is_valid_target(self.ai_target))
		{
			self.ai_target = acquire_target();
			if(isdefined(self.ai_target))
			{
				self.ai_target.target_score = -50;
				self notify("main_barrel_acquire_new_target");
			}
		}

		var_00 = 1.5;
		if(isdefined(self.vehicle_ai_settings) && isdefined(self.vehicle_ai_settings.update_target_time))
		{
			var_00 = self.vehicle_ai_settings.update_target_time;
		}

		maps\_utility::wait_for_notify_or_timeout("update_target",var_00);
	}
}

//Function Number: 11
is_vector(param_00)
{
	return isvector(param_00);
}

//Function Number: 12
is_valid_target(param_00)
{
	if(is_vector(param_00))
	{
		return 1;
	}

	return isdefined(param_00) && !isremovedentity(param_00) && !isdefined(param_00.health) || isdefined(param_00.health) && param_00.health >= 0;
}

//Function Number: 13
is_on_target(param_00)
{
	var_01 = undefined;
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(is_vector(param_00))
	{
		var_01 = param_00;
	}
	else
	{
		var_01 = param_00.origin + (0,0,50);
	}

	var_02 = var_01 - self gettagorigin("tag_flash");
	var_02 = vectornormalize(var_02);
	var_03 = self gettagangles("tag_flash");
	var_04 = anglestoforward(var_03);
	var_05 = vectordot(var_02,var_04);
	if(var_05 > 0.95)
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
acquire_target()
{
	var_00 = undefined;
	if(self.script_team == "allies")
	{
		var_00 = "axis";
	}
	else if(self.script_team == "axis")
	{
		var_00 = "allies";
	}

	if(isdefined(var_00))
	{
		var_01 = getaiarray(var_00);
		if(isdefined(var_01) && var_01.size > 0)
		{
			var_02 = randomint(var_01.size);
			var_03 = undefined;
			var_04 = undefined;
			for(var_05 = 0;var_05 < var_01.size;var_05++)
			{
				var_06 = var_05 + var_02 % var_01.size;
				var_07 = var_01[var_06];
				if(isdefined(var_07) && isalive(var_07))
				{
					var_08 = get_target_score(var_07);
					if(!isdefined(var_03) || var_08 > var_03)
					{
						var_03 = var_08;
						var_04 = var_07;
					}
				}
			}

			if(isdefined(var_03) && var_03 > 0)
			{
				return var_04;
			}
		}
	}

	return undefined;
}

//Function Number: 15
get_target_score(param_00)
{
	var_01 = 0;
	var_02 = 16384;
	var_03 = 2250000;
	var_04 = self gettagorigin("tag_flash");
	var_05 = distancesquared(var_04,param_00.origin);
	if(var_05 < var_02)
	{
		return 0;
	}

	if(var_05 > var_03)
	{
		return 0;
	}

	var_01 = 100 * 1 - var_05 - var_02 / var_03 - var_02;
	if(!turret_can_see_target(param_00))
	{
		return 0;
	}

	if(is_on_target(param_00))
	{
		var_01 = var_01 + 50;
	}

	if(isdefined(param_00.target_score))
	{
		var_01 = var_01 + param_00.target_score;
	}

	if(isdefined(self.respond_to_threat_grenade) && self.respond_to_threat_grenade && isdefined(param_00.detected) && isdefined(param_00.detected["grenade"]))
	{
		var_01 = var_01 + 500;
	}

	return var_01;
}

//Function Number: 16
turret_can_see_target(param_00)
{
	if(is_vector(param_00))
	{
		return 1;
	}

	var_01 = self gettagorigin("tag_flash");
	if(sighttracepassed(var_01,param_00.origin + (0,0,40),0,self,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
update_aiming()
{
	self endon("death");
	self endon("vehicle_dismount");
	self endon("stop_vehicle_turret_ai");
	for(;;)
	{
		var_00 = (randomintrange(-128,128),randomintrange(-128,128),randomintrange(-12,36));
		if(!is_vector(self.ai_target))
		{
			var_00 = var_00 + (0,0,50);
		}

		thread update_aim_offset(var_00);
		maps\_utility::wait_for_notify_or_timeout("main_barrel_acquire_new_target",1.5);
	}
}

//Function Number: 18
update_aim_offset(param_00)
{
	self notify("kill_update_aim_offset");
	self endon("kill_update_aim_offset");
	self endon("death");
	self endon("vehicle_dismount");
	self endon("stop_vehicle_turret_ai");
	self endon("main_barrel_acquire_new_target");
	var_01 = undefined;
	while(isdefined(self.ai_target) && is_valid_target(self.ai_target))
	{
		var_02 = param_00;
		if(is_vector(self.ai_target))
		{
			self setturrettargetvec(self.ai_target + var_02);
			var_01 = (0,0,0);
		}
		else
		{
			if(isdefined(self.ai_target.a) && isdefined(self.ai_target.a.pose) && self.ai_target.a.pose == "crouch")
			{
				var_02 = param_00 - (0,0,15);
			}

			self setturrettargetent(self.ai_target,var_02);
			var_01 = (0,0,50);
		}

		param_00 = param_00 - var_01;
		param_00 = param_00 * 0.2;
		param_00 = param_00 + var_01;
		wait(0.5);
	}
}

//Function Number: 19
vehicle_firing()
{
	self endon("death");
	self endon("vehicle_dismount");
	self endon("stop_vehicle_turret_ai");
	var_00 = 1.5;
	if(isdefined(self.vehicle_ai_settings) && isdefined(self.vehicle_ai_settings.fire_delay))
	{
		var_00 = self.vehicle_ai_settings.fire_delay;
	}

	for(;;)
	{
		if(isdefined(self.disable_firing) && self.disable_firing)
		{
			wait 0.05;
			continue;
		}

		if(isdefined(self.last_fire_time))
		{
			var_01 = gettime() - self.last_fire_time + var_00 * 1000 / 1000;
			if(var_01 > 0)
			{
				wait(var_01);
			}

			self.last_fire_time = undefined;
		}

		if(is_valid_target(self.ai_target) && turret_can_see_target(self.ai_target))
		{
			fire_at_target();
		}

		maps\_utility::wait_for_notify_or_timeout("main_barrel_acquire_new_target",var_00);
	}
}

//Function Number: 20
fire_at_target()
{
	var_00 = 0;
	if(isdefined(self.vehicle_ai_settings) && isdefined(self.vehicle_ai_settings.min_fire_time))
	{
		var_01 = self.vehicle_ai_settings.min_fire_time;
		var_02 = self.vehicle_ai_settings.max_fire_time;
		var_03 = self.vehicle_ai_settings.shot_delay;
	}
	else
	{
		var_01 = 1;
		var_02 = 3;
		var_03 = 1.5;
	}

	var_04 = randomintrange(var_01,var_02);
	while(is_valid_target(self.ai_target) && !is_on_target(self.ai_target))
	{
		wait(0.5);
	}

	while(var_00 < var_04 && is_valid_target(self.ai_target))
	{
		if(isdefined(self.vehicle_ai_settings) && isdefined(self.vehicle_ai_settings.avoid_players) && self.vehicle_ai_settings.avoid_players)
		{
			var_05 = self gettagorigin("tag_flash");
			var_06 = var_05 + anglestoforward(self gettagangles("tag_flash")) * 10000;
			if(maps\_utility::shot_endangers_any_player(var_05,var_06))
			{
				break;
			}
		}

		self fireweapon();
		soundscripts\_snd::snd_message("titan_walker_weapon_fire");
		self.last_fire_time = gettime();
		var_00 = var_00 + var_03;
		wait(var_03);
	}
}