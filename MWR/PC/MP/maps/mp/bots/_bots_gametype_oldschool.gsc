/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_oldschool.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 457 ms
 * Timestamp: 10/27/2023 2:37:19 AM
*******************************************************************/

//Function Number: 1
bot_oldschool_init()
{
	if(!level.oldschool)
	{
		return;
	}

	while(!isdefined(level.allpickupstracked))
	{
		wait(0.05);
	}

	level.bot_oldschool_pickup_struct_array = [];
	var_00 = getentarray("oldschool_pickup","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_parameters) && var_02.script_parameters == "bots_ignore")
		{
			continue;
		}

		var_03 = spawnstruct();
		var_03.origin = var_02.origin;
		var_03.nearest_node = bot_oldschool_pickup_get_nearest_node(var_02);
		var_03.ground_pos = var_02.groundpoint;
		var_03.respawntime = var_02.respawntime;
		if(bot_oldschool_pickup_isweapon(var_02))
		{
			var_03.type = "weapon";
			var_03.weaponname = bot_oldschool_pickup_get_weapon_name(var_02);
		}
		else if(bot_oldschool_pickup_isperk(var_02))
		{
			var_03.type = "perk";
			var_03.perkname = bot_oldschool_pickup_get_perk_name(var_02);
		}

		level.bot_oldschool_pickup_struct_array[level.bot_oldschool_pickup_struct_array.size] = var_03;
	}

	maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
	if(!isdefined(level.bot_oldschool_primary_weapon_priorities))
	{
		level.bot_oldschool_primary_weapon_priorities["camper"] = [];
		level.bot_oldschool_primary_weapon_priorities["camper"]["pistol"] = 0;
		level.bot_oldschool_primary_weapon_priorities["camper"]["spread"] = 2;
		level.bot_oldschool_primary_weapon_priorities["camper"]["smg"] = 4;
		level.bot_oldschool_primary_weapon_priorities["camper"]["rifle"] = 6;
		level.bot_oldschool_primary_weapon_priorities["camper"]["mg"] = 8;
		level.bot_oldschool_primary_weapon_priorities["camper"]["sniper"] = 10;
		level.bot_oldschool_primary_weapon_priorities["cqb"] = [];
		level.bot_oldschool_primary_weapon_priorities["cqb"]["sniper"] = 0;
		level.bot_oldschool_primary_weapon_priorities["cqb"]["pistol"] = 0;
		level.bot_oldschool_primary_weapon_priorities["cqb"]["mg"] = 2;
		level.bot_oldschool_primary_weapon_priorities["cqb"]["rifle"] = 5;
		level.bot_oldschool_primary_weapon_priorities["cqb"]["spread"] = 10;
		level.bot_oldschool_primary_weapon_priorities["cqb"]["smg"] = 10;
		level.bot_oldschool_primary_weapon_priorities["run_and_gun"] = [];
		level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["sniper"] = 0;
		level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["spread"] = 0;
		level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["pistol"] = 0;
		level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["smg"] = 5;
		level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["rifle"] = 10;
		level.bot_oldschool_primary_weapon_priorities["run_and_gun"]["mg"] = 10;
	}

	if(!isdefined(level.bot_oldschool_secondary_weapon_priorities))
	{
		level.bot_oldschool_secondary_weapon_priorities["camper"] = [];
		level.bot_oldschool_secondary_weapon_priorities["camper"]["rifle"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["camper"]["mg"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["camper"]["sniper"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["camper"]["pistol"] = 5;
		level.bot_oldschool_secondary_weapon_priorities["camper"]["spread"] = 10;
		level.bot_oldschool_secondary_weapon_priorities["camper"]["smg"] = 10;
		level.bot_oldschool_secondary_weapon_priorities["cqb"] = [];
		level.bot_oldschool_secondary_weapon_priorities["cqb"]["rifle"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["cqb"]["mg"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["cqb"]["sniper"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["cqb"]["spread"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["cqb"]["smg"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["cqb"]["pistol"] = 10;
		level.bot_oldschool_secondary_weapon_priorities["run_and_gun"] = [];
		level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["rifle"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["mg"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["sniper"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["spread"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["smg"] = 0;
		level.bot_oldschool_secondary_weapon_priorities["run_and_gun"]["pistol"] = 10;
	}

	if(!isdefined(level.bot_oldschool_pickup_memory_time_seen))
	{
		level.bot_oldschool_pickup_memory_time_seen["recruit"] = 10000;
		level.bot_oldschool_pickup_memory_time_seen["regular"] = 20000;
		level.bot_oldschool_pickup_memory_time_seen["hardened"] = 30000;
	}

	if(!isdefined(level.bot_oldschool_pickup_memory_picked_up))
	{
		level.bot_oldschool_pickup_memory_picked_up["recruit"] = 20000;
		level.bot_oldschool_pickup_memory_picked_up["regular"] = 40000;
		level.bot_oldschool_pickup_memory_picked_up["hardened"] = 60000;
	}

	if(!isdefined(level.bot_oldschool_pickup_close_radius_self_sq))
	{
		level.bot_oldschool_pickup_close_radius_self_sq = 490000;
	}

	if(!isdefined(level.bot_oldschool_pickup_close_obj_radius_self_sq))
	{
		level.bot_oldschool_pickup_close_obj_radius_self_sq = 250000;
	}

	if(!isdefined(level.bot_oldschool_pickup_close_crit_radius_self_sq))
	{
		level.bot_oldschool_pickup_close_crit_radius_self_sq = 160000;
	}

	if(!isdefined(level.bot_oldschool_use_radius_sq))
	{
		level.bot_oldschool_use_radius_sq = squared(getdvarfloat("player_useRadius"));
	}

	if(!isdefined(level.bot_oldschool_weapon_switch_time))
	{
		level.bot_oldschool_weapon_switch_time["veteran"]["min"] = 0.75;
		level.bot_oldschool_weapon_switch_time["veteran"]["max"] = 0.85;
		level.bot_oldschool_weapon_switch_time["hardened"]["min"] = 0.85;
		level.bot_oldschool_weapon_switch_time["hardened"]["max"] = 1;
		level.bot_oldschool_weapon_switch_time["regular"]["min"] = 1;
		level.bot_oldschool_weapon_switch_time["regular"]["max"] = 1.25;
		level.bot_oldschool_weapon_switch_time["recruit"]["min"] = 1.25;
		level.bot_oldschool_weapon_switch_time["recruit"]["max"] = 2;
	}

	if(!isdefined(level.bot_oldschool_weapon_pickup_time))
	{
		level.bot_oldschool_weapon_pickup_time["veteran"]["min"] = 0.5;
		level.bot_oldschool_weapon_pickup_time["veteran"]["max"] = 0.6;
		level.bot_oldschool_weapon_pickup_time["hardened"]["min"] = 0.6;
		level.bot_oldschool_weapon_pickup_time["hardened"]["max"] = 0.75;
		level.bot_oldschool_weapon_pickup_time["regular"]["min"] = 0.75;
		level.bot_oldschool_weapon_pickup_time["regular"]["max"] = 1.25;
		level.bot_oldschool_weapon_pickup_time["recruit"]["min"] = 1.25;
		level.bot_oldschool_weapon_pickup_time["recruit"]["max"] = 2.5;
	}

	if(!isdefined(level.bot_oldschool_perk_pickup_time))
	{
		level.bot_oldschool_perk_pickup_time["veteran"]["min"] = 0.05;
		level.bot_oldschool_perk_pickup_time["veteran"]["max"] = 0.1;
		level.bot_oldschool_perk_pickup_time["hardened"]["min"] = 0.1;
		level.bot_oldschool_perk_pickup_time["hardened"]["max"] = 0.25;
		level.bot_oldschool_perk_pickup_time["regular"]["min"] = 0.25;
		level.bot_oldschool_perk_pickup_time["regular"]["max"] = 0.5;
		level.bot_oldschool_perk_pickup_time["recruit"]["min"] = 0.5;
		level.bot_oldschool_perk_pickup_time["recruit"]["max"] = 1;
	}

	level.override_find_camp_node = ::oldschool_attempt_camp_pickup;
}

//Function Number: 2
bot_think_oldschool()
{
	self notify("bot_think_oldschool");
	self endon("bot_think_oldschool");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!level.oldschool)
	{
		return;
	}

	thread bot_oldschool_track_pickups_in_sight();
	childthread bot_oldschool_handle_pickup_goals();
}

//Function Number: 3
bot_oldschool_pickup_get_nearest_node(param_00)
{
	if(!isdefined(param_00.calculated_nearest_node))
	{
		param_00.nearest_node = getclosestnodeinsight(param_00.origin);
		if(!isdefined(param_00.nearest_node))
		{
			param_00.nearest_node = getclosestnodeinsight(param_00.groundpoint);
		}

		param_00.calculated_nearest_node = 1;
	}

	return param_00.nearest_node;
}

//Function Number: 4
bot_oldschool_init_pickups()
{
	while(!isdefined(level.bot_oldschool_pickup_struct_array))
	{
		wait(0.05);
	}

	self.pickup_array = [];
	var_00 = self botgetdifficultysetting("strategyLevel");
	var_01 = var_00 / 3;
	foreach(var_03 in level.bot_oldschool_pickup_struct_array)
	{
		var_04 = spawnstruct();
		var_04.parent = var_03;
		var_04.origin = var_03.origin;
		var_04.nearest_node = var_03.nearest_node;
		var_04.ground_pos = var_03.ground_pos;
		var_04.type = var_03.type;
		var_04.weaponname = var_03.weaponname;
		var_04.perkname = var_03.perkname;
		var_04.respawntime = var_03.respawntime;
		var_04.last_time_seen = 0;
		var_04.sight_time = 0;
		var_04.next_valid_time = 0;
		var_04.last_pickup_time = 0;
		var_04.always_known = randomfloat(1) < var_01;
		self.pickup_array[self.pickup_array.size] = var_04;
	}
}

//Function Number: 5
bot_oldschool_track_pickups_in_sight()
{
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.pickup_array))
	{
		return;
	}

	bot_oldschool_init_pickups();
	var_00 = self botgetdifficultysetting("averageEnemySightTime") / 1000;
	var_01 = var_00 * 0.7;
	for(;;)
	{
		var_02 = common_scripts\utility::random([0.1,0.15,0.2]);
		wait(var_02);
		var_03 = self getnearestnode();
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = gettime();
		var_05 = self botgetfovdot();
		var_06 = self method_8576();
		foreach(var_08 in self.pickup_array)
		{
			if(!isdefined(var_08.pickup))
			{
				var_08.pickup = bot_oldschool_get_pickup_ent_for_struct(var_08);
			}

			var_09 = 0;
			if(distancesquared(self.origin,var_08.origin) < 1600)
			{
				var_09 = 1;
				var_08.sight_time = var_01;
			}
			else if(bot_oldschool_pickup_is_probably_visible(var_08,var_03,var_05,var_06))
			{
				var_09 = bot_oldschool_pickup_trace_passed(var_08);
			}

			if(var_09)
			{
				if(var_08.sight_time < var_01)
				{
					var_0A = vectornormalize(var_08.origin - self.origin);
					var_0B = anglestoforward(self getplayerangles());
					var_0C = vectordot(var_0A,var_0B);
					var_0D = clamp(var_0C - var_05 / 1 - var_05,0,1);
					var_0E = distance(self.origin,var_08.origin);
					var_0F = clamp(var_0E - 3000 / -2500,0,1);
					var_10 = var_02 * var_0D + var_02 * var_0F * 0.5;
					var_08.sight_time = min(var_08.sight_time + var_10,var_01);
				}
			}
			else if(var_08.sight_time > 0)
			{
				var_08.sight_time = max(var_08.sight_time - var_02,0);
			}

			if(var_08.sight_time >= var_01)
			{
				var_08.last_time_seen = var_04;
				if(!isdefined(var_08.pickup))
				{
					bot_oldschool_update_pickup_recharge_time(var_04,var_08);
					continue;
				}

				var_11 = 0;
				if(var_08.last_pickup_time > 0 && gettime() - var_08.last_pickup_time < var_08.respawntime * 1000)
				{
					var_11 = 1;
				}

				if(!var_11)
				{
					bot_oldschool_reset_pickup_recharge_time(var_08);
				}
			}
		}

		wait(0.25);
	}
}

//Function Number: 6
bot_oldschool_handle_pickup_goals()
{
	var_00 = undefined;
	for(;;)
	{
		wait(0.5);
		if(!isalive(self) || maps\mp\_utility::is_true(self.inlaststand) || maps\mp\bots\_bots_util::bot_is_remote_or_linked() || self usebuttonpressed())
		{
			continue;
		}

		var_01 = maps\mp\bots\_bots_strategy::bot_get_active_tactical_goals_of_type("oldschool_pickup");
		var_02 = self botgetscriptgoaltype();
		if(var_02 == "tactical")
		{
			var_03 = 0;
			if(var_01.size > 0)
			{
				var_03 = maps\mp\bots\_bots_util::bot_vectors_are_equal(self botgetscriptgoal(),var_01[0].object.ground_pos);
			}

			if(!var_03)
			{
				if(var_01.size > 0)
				{
					self notify("stop_tactical_goal");
				}

				continue;
			}
		}

		if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("oldschool_pickup") && self.tactical_goal_in_action_thread)
		{
			continue;
		}

		if(maps\mp\bots\_bots_util::bot_in_combat(1000))
		{
			continue;
		}

		if(isdefined(self.role) && self.role == "defuser")
		{
			continue;
		}

		var_04 = gettime();
		var_05 = [];
		foreach(var_07 in self.pickup_array)
		{
			if(bot_oldschool_pickup_is_recharging(var_04,var_07))
			{
				continue;
			}

			if(!bot_oldschool_bot_remembers_pickup(var_04,var_07))
			{
				continue;
			}

			var_05[var_05.size] = var_07;
		}

		var_09 = common_scripts\utility::get_array_of_closest(self.origin,var_05);
		if(isdefined(var_00))
		{
			var_0A = var_00;
		}
		else
		{
			var_0A = "normal";
			if(var_02 == "critical")
			{
				var_0A = "critical";
			}
			else if(maps\mp\bots\_bots_util::bot_is_defending() || var_02 == "objective")
			{
				var_0A = "objective";
			}
		}

		var_0B = undefined;
		foreach(var_07 in var_09)
		{
			if(var_07.type == "weapon")
			{
				var_0D = bot_oldschool_pickup_get_desired_weapon_pickup_action(var_07.weaponname);
				if(bot_oldschool_should_pickup_weapon(var_0D,var_07,var_0A))
				{
					var_0B["pickup_struct"] = var_07;
					var_0B["action"] = var_0D["action"];
					var_0B["weapon_to_replace"] = var_0D["weapon_to_replace"];
					break;
				}

				continue;
			}

			if(var_07.type == "perk")
			{
				if(bot_oldschool_should_pickup_perk(var_07,var_0A))
				{
					var_0B["pickup_struct"] = var_07;
					var_0B["action"] = "pickup_perk";
					break;
				}

				continue;
			}
		}

		if(var_01.size > 0)
		{
			if(isdefined(var_0B) && maps\mp\bots\_bots_strategy::bot_has_tactical_goal("oldschool_pickup",var_0B["pickup_struct"]))
			{
				continue;
			}

			var_0F = distancesquared(self.origin,var_01[0].object.origin);
			if(var_0F <= level.bot_oldschool_use_radius_sq)
			{
				continue;
			}

			maps\mp\bots\_bots_strategy::bot_abort_tactical_goal("oldschool_pickup");
			wait(0.25);
		}

		if(isdefined(var_0B))
		{
			var_10 = spawnstruct();
			var_10.object = var_0B["pickup_struct"];
			var_10.script_goal_radius = 40;
			var_10.should_abort = ::bot_oldschool_pickup_deleted;
			if(var_0A == "normal")
			{
				var_10.script_goal_type = "guard";
			}

			var_10.clear_prev_goal = 1;
			var_10.short_term_goal = 1;
			if(var_0B["action"] == "pickup_weapon")
			{
				var_10.action_thread = ::bot_oldschool_pickup_weapon;
				var_10.optional_params = var_0B["weapon_to_replace"];
			}
			else if(var_0B["action"] == "pickup_perk")
			{
				var_10.action_thread = ::bot_oldschool_pickup_perk;
			}
			else if(var_0B["action"] == "pickup_ammo")
			{
				var_10.action_thread = ::bot_oldschool_pickup_ammo;
			}
			else
			{
			}

			maps\mp\bots\_bots_strategy::bot_new_tactical_goal("oldschool_pickup",var_0B["pickup_struct"].ground_pos,20,var_10);
			var_00 = var_0A;
			continue;
		}

		var_00 = undefined;
	}
}

//Function Number: 7
bot_oldschool_bot_remembers_pickup(param_00,param_01)
{
	if(param_01.always_known)
	{
		return 1;
	}

	if(param_01.last_time_seen > 0)
	{
		var_02 = param_00 - param_01.last_time_seen;
		if(var_02 <= level.bot_oldschool_pickup_memory_time_seen[self.difficulty])
		{
			return 1;
		}
	}

	if(param_01.last_pickup_time > 0)
	{
		var_03 = param_00 - param_01.last_pickup_time;
		if(var_03 <= level.bot_oldschool_pickup_memory_picked_up[self.difficulty])
		{
			return 1;
		}
	}

	if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("oldschool_pickup",param_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
bot_oldschool_can_currently_see_pickup(param_00,param_01)
{
	return param_00 - param_01.last_time_seen <= 500;
}

//Function Number: 9
bot_oldschool_get_pickup_ent_for_struct(param_00)
{
	var_01 = getentarray("oldschool_pickup","targetname");
	foreach(var_03 in var_01)
	{
		if(distance2dsquared(param_00.origin,var_03.origin) < 16)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 10
bot_oldschool_pickup_is_recharging(param_00,param_01)
{
	return param_00 < param_01.next_valid_time;
}

//Function Number: 11
bot_oldschool_update_pickup_recharge_time(param_00,param_01)
{
	if(!bot_oldschool_pickup_is_recharging(param_00,param_01))
	{
		var_02 = 4 - self botgetdifficultysetting("strategyLevel") * 0.15;
		var_03 = randomfloatrange(1 - var_02,1 + var_02);
		var_04 = param_01.respawntime * var_03;
		param_01.next_valid_time = param_00 + var_04 * 1000;
	}
}

//Function Number: 12
bot_oldschool_reset_pickup_recharge_time(param_00)
{
	param_00.next_valid_time = 0;
}

//Function Number: 13
bot_oldschool_update_pickup_time(param_00,param_01)
{
	param_01.last_pickup_time = param_00;
}

//Function Number: 14
bot_oldschool_should_pickup_weapon(param_00,param_01,param_02)
{
	if(param_02 != "normal" && param_00["action"] != "do_not_pickup")
	{
		if(bot_oldschool_nearly_out_of_ammo_for_active_weapon())
		{
			return 1;
		}

		return bot_oldschool_should_pursue_pickup(param_01,param_02);
	}

	if(param_00["action"] == "pickup_weapon")
	{
		var_03 = weaponclass(param_01.weaponname);
		if(var_03 == "rocketlauncher" || var_03 == "grenade")
		{
			return bot_oldschool_should_pursue_pickup(param_01,"normal");
		}

		return 1;
	}
	else if(param_01["action"] == "pickup_ammo")
	{
		if(bot_oldschool_nearly_out_of_ammo_for_active_weapon())
		{
			return 1;
		}

		return bot_oldschool_should_pursue_pickup(param_02,"normal");
	}

	return 0;
}

//Function Number: 15
bot_oldschool_should_pickup_perk(param_00,param_01)
{
	if(maps\mp\_utility::_hasperk(param_00.perkname))
	{
		return 0;
	}

	if(param_01 != "normal")
	{
		return bot_oldschool_should_pursue_pickup(param_00,param_01);
	}

	if(self.personality == "camper")
	{
		return bot_oldschool_should_pursue_pickup(param_00,"normal");
	}

	return 1;
}

//Function Number: 16
bot_oldschool_should_pursue_pickup(param_00,param_01)
{
	var_02 = param_01 == "normal";
	if(var_02 && self bothasscriptgoal())
	{
		var_03 = self botgetscriptgoal();
		var_04 = self botgetscriptgoalradius();
		if(distancesquared(self.origin,var_03) < squared(var_04))
		{
			var_05 = 0;
			var_06 = maps\mp\bots\_bots_strategy::bot_get_active_tactical_goals_of_type("oldschool_pickup");
			if(var_06.size == 1)
			{
				var_05 = maps\mp\bots\_bots_util::bot_vectors_are_equal(var_03,var_06[0].object.ground_pos);
			}

			if(!var_05)
			{
				return 0;
			}
		}
	}

	var_07 = level.bot_oldschool_pickup_close_radius_self_sq;
	if(param_01 == "critical")
	{
		var_07 = level.bot_oldschool_pickup_close_crit_radius_self_sq;
	}
	else if(param_01 == "objective")
	{
		var_07 = level.bot_oldschool_pickup_close_obj_radius_self_sq;
	}

	if(distancesquared(self.origin,param_00.origin) < var_07)
	{
		return 1;
	}

	return 0;
}

//Function Number: 17
bot_oldschool_pickup_weapon(param_00)
{
	if(maps\mp\bots\_bots_util::bot_in_combat(1000))
	{
		while(maps\mp\bots\_bots_util::bot_in_combat(1000))
		{
			wait(0.05);
		}
	}
	else
	{
		var_01 = randomfloatrange(level.bot_oldschool_weapon_pickup_time[self.difficulty]["min"],level.bot_oldschool_weapon_pickup_time[self.difficulty]["max"]) * 0.5;
		wait(var_01);
	}

	if(isdefined(param_00.object) && !bot_oldschool_pickup_is_recharging(gettime(),param_00.object))
	{
		if(isdefined(param_00.optional_params))
		{
			var_02 = self getcurrentweapon() != param_00.optional_params;
			self switchtoweapon(param_00.optional_params);
			if(var_02)
			{
				var_03 = randomfloatrange(level.bot_oldschool_weapon_switch_time[self.difficulty]["min"],level.bot_oldschool_weapon_switch_time[self.difficulty]["max"]);
				wait(var_03);
			}
		}

		self botpressbutton("use",1);
		var_04 = gettime();
		while((!self hasweapon(param_00.object.weaponname) && gettime() - var_04 < 1000) || gettime() - var_04 <= 100)
		{
			wait(0.05);
		}

		var_05 = randomfloatrange(level.bot_oldschool_weapon_pickup_time[self.difficulty]["min"],level.bot_oldschool_weapon_pickup_time[self.difficulty]["max"]);
		var_06 = 0;
		if(self hasweapon(param_00.object.weaponname) && weaponclass(param_00.object.weaponname) != "grenade")
		{
			self switchtoweapon(param_00.object.weaponname);
			if(weaponclass(param_00.object.weaponname) == "rocketlauncher")
			{
				var_06 = 0.75;
			}
		}

		wait(var_05 + var_06);
		self switchtoweapon("none");
		var_07 = gettime();
		bot_oldschool_update_pickup_recharge_time(var_07,param_00.object);
		bot_oldschool_update_pickup_time(var_07,param_00.object);
	}
}

//Function Number: 18
bot_oldschool_pickup_ammo(param_00)
{
	var_01 = gettime();
	bot_oldschool_update_pickup_recharge_time(var_01,param_00.object);
	bot_oldschool_update_pickup_time(var_01,param_00.object);
}

//Function Number: 19
bot_oldschool_pickup_perk(param_00)
{
	if(maps\mp\bots\_bots_util::bot_in_combat(1000))
	{
		while(maps\mp\bots\_bots_util::bot_in_combat(1000))
		{
			wait(0.05);
		}
	}
	else
	{
		var_01 = randomfloatrange(level.bot_oldschool_perk_pickup_time[self.difficulty]["min"],level.bot_oldschool_perk_pickup_time[self.difficulty]["max"]) * 0.5;
		wait(var_01);
	}

	if(isdefined(param_00.object) && !bot_oldschool_pickup_is_recharging(gettime(),param_00.object))
	{
		self botpressbutton("use",1);
		var_02 = gettime();
		while((!maps\mp\_utility::_hasperk(param_00.object.perkname) && gettime() - var_02 < 1000) || gettime() - var_02 <= 100)
		{
			wait(0.05);
		}

		var_03 = randomfloatrange(level.bot_oldschool_perk_pickup_time[self.difficulty]["min"],level.bot_oldschool_perk_pickup_time[self.difficulty]["max"]);
		wait(var_03);
		var_04 = gettime();
		bot_oldschool_update_pickup_recharge_time(var_04,param_00.object);
		bot_oldschool_update_pickup_time(var_04,param_00.object);
	}
}

//Function Number: 20
bot_oldschool_pickup_deleted(param_00)
{
	if(!isdefined(param_00.object) || bot_oldschool_pickup_is_recharging(gettime(),param_00.object))
	{
		return 1;
	}

	return 0;
}

//Function Number: 21
bot_oldschool_pickup_get_desired_weapon_pickup_action(param_00)
{
	var_01["action"] = "do_not_pickup";
	var_02 = weaponclass(param_00);
	if(var_02 == "grenade")
	{
		if(maps\mp\gametypes\_class::isvalidoffhand(param_00))
		{
			var_03 = 0;
			var_04 = self getoffhandsecondaryclass();
			if(var_04 != "none")
			{
				var_03 = self getweaponammoclip(var_04);
			}

			if(var_03 > 0)
			{
				if(param_00 == var_04)
				{
					if(bot_oldschool_is_valid_ammo_pickup(param_00))
					{
						var_01["action"] = "pickup_ammo";
					}
				}
			}
			else if(!self hasweapon(param_00))
			{
				var_01["action"] = "pickup_weapon";
			}
			else if(bot_oldschool_is_valid_ammo_pickup(param_00))
			{
				var_01["action"] = "pickup_ammo";
			}
		}
		else if(bot_oldschool_is_valid_ammo_pickup(param_00))
		{
			var_01["action"] = "pickup_ammo";
		}

		return var_01;
	}
	else if(var_02 == "rocketlauncher")
	{
		if(!self hasweapon(param_00))
		{
			var_01["action"] = "pickup_weapon";
		}
		else if(bot_oldschool_is_valid_ammo_pickup(param_00))
		{
			var_01["action"] = "pickup_ammo";
		}

		return var_01;
	}

	var_05 = self.personality;
	if(var_05 == "default")
	{
		var_05 = "run_and_gun";
	}

	var_06 = maps\mp\bots\_bots_util::bot_get_active_and_stowed_weapons();
	var_07 = weaponclass(var_06["active"]);
	var_08 = weaponclass(var_06["stowed"]);
	var_09 = bot_oldschool_calculate_primary_and_secondary_weapons(var_05,var_06["active"],var_07,var_06["stowed"],var_08);
	var_0A = bot_oldschool_get_weapon_primary_priority(var_05,var_02);
	var_0B = bot_oldschool_get_weapon_primary_priority(var_05,var_09["primary"]["class"]);
	var_0B = var_0B + bot_oldschool_adjust_weapon_priority(var_09["primary"]["weap"],var_07);
	if(var_0A > var_0B)
	{
		var_01["action"] = "pickup_weapon";
		var_01["weapon_to_replace"] = var_09["primary"]["weap"];
		return var_01;
	}

	var_0C = bot_oldschool_get_weapon_secondary_priority(var_05,var_02);
	var_0D = bot_oldschool_get_weapon_secondary_priority(var_05,var_09["secondary"]["class"]);
	var_0D = var_0D + bot_oldschool_adjust_weapon_priority(var_09["secondary"]["weap"],var_08);
	if(var_0C > var_0D)
	{
		var_01["action"] = "pickup_weapon";
		var_01["weapon_to_replace"] = var_09["secondary"]["weap"];
		return var_01;
	}

	if(bot_oldschool_is_valid_ammo_pickup(param_00))
	{
		var_01["action"] = "pickup_ammo";
	}

	return var_01;
}

//Function Number: 22
bot_oldschool_is_valid_ammo_pickup(param_00)
{
	if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		if(!self method_8574(param_00))
		{
			return 0;
		}

		var_01 = self method_8575(param_00);
		if(var_01 <= 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 23
bot_oldschool_adjust_weapon_priority(param_00,param_01)
{
	if(maps\mp\_utility::getbaseweaponname(param_00) == "h1_skorpion")
	{
		return -1;
	}

	if(bot_oldschool_nearly_out_of_ammo_for_weapon(param_00,param_01))
	{
		return -10;
	}

	return 0;
}

//Function Number: 24
bot_oldschool_nearly_out_of_ammo_for_active_weapon()
{
	var_00 = maps\mp\bots\_bots_util::bot_get_active_and_stowed_weapons();
	var_01 = weaponclass(var_00["active"]);
	if(bot_oldschool_nearly_out_of_ammo_for_weapon(var_00["active"],var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 25
bot_oldschool_nearly_out_of_ammo_for_weapon(param_00,param_01)
{
	if(param_01 == "grenade")
	{
		if(self getweaponammoclip(param_00) <= 0)
		{
			return 1;
		}
	}
	else
	{
		var_02 = self getweaponammostock(param_00);
		var_03 = self getweaponammoclip(param_00);
		var_04 = weaponclipsize(param_00,self);
		if(var_02 + var_03 <= var_04)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 26
bot_oldschool_calculate_primary_and_secondary_weapons(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = bot_oldschool_get_weapon_primary_priority(param_00,param_02);
	var_06 = bot_oldschool_get_weapon_secondary_priority(param_00,param_02);
	var_07 = bot_oldschool_get_weapon_primary_priority(param_00,param_04);
	var_08 = bot_oldschool_get_weapon_secondary_priority(param_00,param_04);
	var_09["primary"] = [];
	var_09["secondary"] = [];
	var_0A = var_05 - var_07;
	var_0B = var_06 - var_08;
	if(var_0A >= var_0B)
	{
		var_09["primary"]["weap"] = param_01;
		var_09["primary"]["class"] = param_02;
		var_09["secondary"]["weap"] = param_03;
		var_09["secondary"]["class"] = param_04;
	}
	else
	{
		var_09["primary"]["weap"] = param_03;
		var_09["primary"]["class"] = param_04;
		var_09["secondary"]["weap"] = param_01;
		var_09["secondary"]["class"] = param_02;
	}

	return var_09;
}

//Function Number: 27
bot_oldschool_get_weapon_primary_priority(param_00,param_01)
{
	return level.bot_oldschool_primary_weapon_priorities[param_00][param_01];
}

//Function Number: 28
bot_oldschool_get_weapon_secondary_priority(param_00,param_01)
{
	return level.bot_oldschool_secondary_weapon_priorities[param_00][param_01];
}

//Function Number: 29
bot_oldschool_pickup_isweapon(param_00)
{
	return issubstr(param_00.classname,"weapon_");
}

//Function Number: 30
bot_oldschool_pickup_get_weapon_name(param_00)
{
	return param_00 maps\mp\gametypes\_weapons::getitemweaponname();
}

//Function Number: 31
bot_oldschool_pickup_isperk(param_00)
{
	return param_00.classname == "script_model";
}

//Function Number: 32
bot_oldschool_pickup_get_perk_name(param_00)
{
	return param_00.script_noteworthy;
}

//Function Number: 33
bot_oldschool_pickup_is_probably_visible(param_00,param_01,param_02,param_03)
{
	if(!nodesvisible(param_00.nearest_node,param_01,1))
	{
		return 0;
	}

	var_04 = param_00.origin - self geteye();
	var_05 = lengthsquared(var_04);
	var_06 = anglestoforward(self getplayerangles());
	var_07 = vectordot(var_04,var_06);
	if(var_07 < 0 || var_07 * var_07 < var_05 * param_02 * param_02)
	{
		return 0;
	}

	if(param_03 > param_02)
	{
		var_04 = (var_06[0] * length2d(var_04),var_06[1] * length2d(var_04),var_04[2]);
		var_05 = lengthsquared(var_04);
		var_07 = vectordot(var_04,var_06);
		if(var_07 < 0 || var_07 * var_07 < var_05 * param_03 * param_03)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 34
bot_oldschool_pickup_trace_passed(param_00)
{
	if(sighttracepassed(self geteye(),param_00.origin + (0,0,30),1,self,param_00.pickup,0))
	{
		return 1;
	}

	return sighttracepassed(self geteye(),param_00.origin,1,self,param_00.pickup,0);
}

//Function Number: 35
oldschool_attempt_camp_pickup()
{
	if(randomfloat(1) < 0.5)
	{
		return 0;
	}

	if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal("oldschool_pickup"))
	{
		return 0;
	}

	var_00 = [];
	var_01 = gettime();
	foreach(var_03 in self.pickup_array)
	{
		if(bot_oldschool_pickup_is_recharging(var_01,var_03))
		{
			continue;
		}

		if(!bot_oldschool_bot_remembers_pickup(var_01,var_03))
		{
			continue;
		}

		var_00[var_00.size] = var_03;
	}

	if(var_00.size == 0)
	{
		return 0;
	}

	var_05 = common_scripts\utility::get_array_of_closest(self.origin,var_00);
	var_06 = var_05[0];
	if(maps\mp\bots\_bots_personality::find_ambush_node(var_06.origin,512))
	{
		return 1;
	}

	return 0;
}