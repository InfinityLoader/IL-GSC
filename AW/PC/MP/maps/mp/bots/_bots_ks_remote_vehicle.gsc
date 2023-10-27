/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_ks_remote_vehicle.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 428 ms
 * Timestamp: 10/27/2023 1:41:11 AM
*******************************************************************/

//Function Number: 1
remote_vehicle_setup()
{
	while(!isdefined(level.bot_variables_initialized))
	{
		wait(0.05);
	}

	if(isdefined(level.bot_initialized_remote_vehicles))
	{
		return;
	}

	level.outside_zones = [];
	if(isdefined(level.teleportgetactivepathnodezonesfunc))
	{
		var_00 = [[ level.teleportgetactivepathnodezonesfunc ]]();
	}
	else
	{
		var_00 = [];
		for(var_01 = 0;var_01 < level.zonecount;var_01++)
		{
			var_00[var_00.size] = var_01;
		}
	}

	foreach(var_03 in var_00)
	{
		if(botzonegetindoorpercent(var_03) < 0.25)
		{
			level.outside_zones = common_scripts\utility::array_add(level.outside_zones,var_03);
		}
	}

	level.bot_initialized_remote_vehicles = 1;
}

//Function Number: 2
bot_killstreak_remote_control(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		return 0;
	}

	var_05 = 1;
	var_06 = 1;
	var_07 = undefined;
	if(isdefined(self.node_ambushing_from))
	{
		var_08 = self botgetscriptgoalradius();
		var_09 = distancesquared(self.origin,self.node_ambushing_from.origin);
		if(var_09 < squared(var_08))
		{
			var_05 = 0;
			var_06 = 0;
		}
		else if(var_09 < squared(200))
		{
			var_05 = 0;
		}
	}

	var_0A = param_00.streakname == "vanguard" && is_indoor_map();
	if(var_0A || var_05)
	{
		var_0B = getnodesinradius(self.origin,500,0,512);
		if(isdefined(var_0B) && var_0B.size > 0)
		{
			if(isdefined(param_04) && param_04)
			{
				var_0C = var_0B;
				var_0B = [];
				foreach(var_0E in var_0C)
				{
					if(nodeexposedtosky(var_0E))
					{
						var_0F = getlinkednodes(var_0E);
						var_10 = 0;
						foreach(var_12 in var_0F)
						{
							if(nodeexposedtosky(var_12))
							{
								var_10++;
							}
						}

						if(var_10 / var_0F.size > 0.5)
						{
							var_0B = common_scripts\utility::array_add(var_0B,var_0E);
						}
					}
				}
			}

			if(var_0A)
			{
				var_15 = self botnodescoremultiple(var_0B,"node_exposed");
				foreach(var_0E in var_15)
				{
					if(bullettracepassed(var_0E.origin + (0,0,30),var_0E.origin + (0,0,400),0,self))
					{
						var_07 = var_0E;
						break;
					}

					wait(0.05);
				}
			}
			else if(var_0B.size > 0)
			{
				var_07 = self botnodepick(var_0B,min(3,var_0B.size),"node_hide");
			}

			if(!isdefined(var_07))
			{
				return 0;
			}

			self botsetscriptgoalnode(var_07,"tactical");
		}
	}

	if(var_06)
	{
		var_18 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();
		if(var_18 != "goal")
		{
			try_clear_hide_goal(var_07);
			return 1;
		}
	}

	if(isdefined(param_02) && !self [[ param_02 ]]())
	{
		try_clear_hide_goal(var_07);
		return 0;
	}

	if(!maps\mp\bots\_bots_util::bot_allowed_to_use_killstreaks())
	{
		try_clear_hide_goal(var_07);
		return 1;
	}

	if(!isdefined(var_07))
	{
		if(self getstance() == "prone")
		{
			self botsetstance("prone");
		}
		else if(self getstance() == "crouch")
		{
			self botsetstance("crouch");
		}
	}
	else if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		if(randomint(100) > 50)
		{
			self botsetstance("prone");
		}
		else
		{
			self botsetstance("crouch");
		}
	}

	maps\mp\bots\_bots_ks::bot_switch_to_killstreak_weapon(param_00,param_01,param_00.weapon);
	self.vehicle_controlling = undefined;
	self thread [[ param_03 ]]();
	thread bot_end_control_on_respawn();
	thread bot_end_control_watcher(var_07);
	self waittill("control_func_done");
	return 1;
}

//Function Number: 3
bot_end_control_on_respawn()
{
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	self waittill("spawned_player");
	self notify("control_func_done");
}

//Function Number: 4
bot_end_control_watcher(param_00)
{
	self endon("disconnect");
	self waittill("control_func_done");
	try_clear_hide_goal(param_00);
	self botsetstance("none");
	self botsetscriptmove(0,0);
	self botsetflag("disable_movement",0);
	self botsetflag("disable_rotation",0);
	self.vehicle_controlling = undefined;
}

//Function Number: 5
try_clear_hide_goal(param_00)
{
	if(isdefined(param_00) && self bothasscriptgoal() && isdefined(self botgetscriptgoalnode()) && self botgetscriptgoalnode() == param_00)
	{
		self botclearscriptgoal();
	}
}

//Function Number: 6
bot_end_control_on_vehicle_death(param_00)
{
	param_00 waittill("death");
	self notify("control_func_done");
}

//Function Number: 7
bot_waittill_using_vehicle(param_00)
{
	var_01 = gettime();
	while(!self [[ level.bot_ks_funcs["isUsing"][param_00] ]]())
	{
		wait(0.05);
		if(gettime() - var_01 > 5000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 8
is_indoor_map()
{
	return level.script == "mp_sovereign";
}

//Function Number: 9
bot_body_is_dead()
{
	return isdefined(self.fauxdead) && self.fauxdead;
}

//Function Number: 10
heli_pick_node_furthest_from_center(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 0;
	foreach(var_05 in param_00)
	{
		var_06 = distancesquared(level.bot_map_center,[[ level.bot_ks_funcs["heli_node_get_origin"][param_01] ]](var_05));
		if(var_06 > var_03)
		{
			var_03 = var_06;
			var_02 = var_05;
		}
	}

	if(isdefined(var_02))
	{
		return var_02;
	}

	return common_scripts\utility::random(param_00);
}

//Function Number: 11
heli_get_node_origin(param_00)
{
	return param_00.origin;
}

//Function Number: 12
find_closest_heli_node_2d(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 99999999;
	foreach(var_05 in level.bot_heli_nodes)
	{
		var_06 = distance2dsquared(param_00,[[ level.bot_ks_funcs["heli_node_get_origin"][param_01] ]](var_05));
		if(var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02;
}

//Function Number: 13
bot_killstreak_get_zone_allies_outside(param_00)
{
	var_01 = bot_killstreak_get_all_outside_allies(param_00);
	var_02 = [];
	for(var_03 = 0;var_03 < level.zonecount;var_03++)
	{
		var_02[var_03] = [];
	}

	foreach(var_05 in var_01)
	{
		var_06 = var_05 getnearestnode();
		var_07 = getnodezone(var_06);
		if(isdefined(var_07))
		{
			var_02[var_07] = common_scripts\utility::array_add(var_02[var_07],var_05);
		}
	}

	return var_02;
}

//Function Number: 14
bot_killstreak_get_zone_enemies_outside(param_00)
{
	var_01 = bot_killstreak_get_all_outside_enemies(param_00);
	var_02 = [];
	for(var_03 = 0;var_03 < level.zonecount;var_03++)
	{
		var_02[var_03] = [];
	}

	foreach(var_05 in var_01)
	{
		var_06 = var_05 getnearestnode();
		var_07 = getnodezone(var_06);
		var_02[var_07] = common_scripts\utility::array_add(var_02[var_07],var_05);
	}

	return var_02;
}

//Function Number: 15
bot_killstreak_get_all_outside_enemies(param_00)
{
	return bot_killstreak_get_outside_players(self.team,"enemy",param_00);
}

//Function Number: 16
bot_killstreak_get_all_outside_allies(param_00)
{
	return bot_killstreak_get_outside_players(self.team,"ally",param_00);
}

//Function Number: 17
bot_killstreak_get_outside_players(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = level.participants;
	if(isdefined(param_02) && param_02)
	{
		var_04 = level.players;
	}

	foreach(var_06 in var_04)
	{
		if(var_06 == self || !isalive(var_06))
		{
			continue;
		}

		var_07 = 0;
		if(param_01 == "ally")
		{
			var_07 = level.teambased && param_00 == var_06.team;
		}
		else if(param_01 == "enemy")
		{
			var_07 = !level.teambased || param_00 != var_06.team;
		}

		if(var_07)
		{
			var_08 = var_06 getnearestnode();
			if(isdefined(var_08) && nodeexposedtosky(var_08))
			{
				var_03 = common_scripts\utility::array_add(var_03,var_06);
			}
		}
	}

	var_03 = common_scripts\utility::array_remove(var_03,self);
	return var_03;
}

//Function Number: 18
bot_heli_find_unvisited_nodes(param_00)
{
	var_01 = 99;
	var_02 = [];
	foreach(var_04 in param_00.neighbors)
	{
		if(isdefined(var_04.script_linkname))
		{
			var_05 = var_04.bot_visited_times[self.entity_number];
			if(var_05 < var_01)
			{
				var_02 = [];
				var_02[0] = var_04;
				var_01 = var_05;
			}
			else if(var_05 == var_01)
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 19
bot_control_heli(param_00)
{
	self endon("spawned_player");
	self endon("disconnect");
	self endon("control_func_done");
	level endon("game_ended");
	var_01 = bot_waittill_using_vehicle(param_00);
	if(!var_01)
	{
		self notify("control_func_done");
	}

	foreach(var_03 in level.littlebirds)
	{
		if(var_03.owner == self)
		{
			self.vehicle_controlling = var_03;
		}
	}

	childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);
	self.vehicle_controlling endon("death");
	if(isdefined(level.bot_ks_funcs["control_other"][param_00]))
	{
		self childthread [[ level.bot_ks_funcs["control_other"][param_00] ]]();
	}

	self [[ level.bot_ks_funcs["waittill_initial_goal"][param_00] ]]();
	self childthread [[ level.bot_ks_funcs["control_aiming"][param_00] ]]();
	bot_control_heli_main_move_loop(param_00,1);
	self notify("control_func_done");
}

//Function Number: 20
bot_get_heli_goal_dist_sq(param_00)
{
	if(param_00)
	{
		return squared(100);
	}

	return squared(30);
}

//Function Number: 21
bot_get_heli_slowdown_dist_sq(param_00)
{
	if(param_00)
	{
		return squared(300);
	}

	return squared(90);
}

//Function Number: 22
bot_control_heli_main_move_loop(param_00,param_01)
{
	foreach(var_03 in level.bot_heli_nodes)
	{
		var_03.bot_visited_times[self.entity_number] = 0;
	}

	var_05 = find_closest_heli_node_2d(self.vehicle_controlling.origin,param_00);
	var_06 = undefined;
	self.next_goal_time = 0;
	var_07 = "needs_new_goal";
	var_08 = undefined;
	var_09 = self.vehicle_controlling.origin;
	var_0A = 3;
	var_0B = 0.05;
	while(self [[ level.bot_ks_funcs["isUsing"][param_00] ]]())
	{
		if(gettime() > self.next_goal_time && var_07 == "needs_new_goal")
		{
			var_0C = var_05;
			var_05 = [[ level.bot_ks_funcs["heli_pick_node"][param_00] ]](var_05);
			var_06 = undefined;
			if(isdefined(var_05))
			{
				var_0D = [[ level.bot_ks_funcs["heli_node_get_origin"][param_00] ]](var_05);
				if(param_01)
				{
					var_0E = var_05.origin + maps\mp\_utility::gethelipilotmeshoffset() + level.bot_heli_pilot_traceoffset;
					var_0F = var_05.origin + maps\mp\_utility::gethelipilotmeshoffset() - level.bot_heli_pilot_traceoffset;
					var_10 = bullettrace(var_0E,var_0F,0,undefined,0,0,1);
					var_06 = var_10["position"] - maps\mp\_utility::gethelipilotmeshoffset() + level.bot_ks_heli_offset[param_00];
				}
				else
				{
					var_06 = var_0D;
				}
			}

			if(isdefined(var_06))
			{
				self botsetflag("disable_movement",0);
				var_07 = "waiting_till_goal";
				var_0A = 3;
				var_09 = self.vehicle_controlling.origin;
			}
			else
			{
				var_05 = var_0C;
				self.next_goal_time = gettime() + 2000;
			}

			continue;
		}

		if(var_07 == "waiting_till_goal")
		{
			if(!param_01)
			{
				var_11 = var_06[2] - self.vehicle_controlling.origin[2];
				if(var_11 > 10)
				{
					self botpressbutton("lethal");
				}
				else if(var_11 < -10)
				{
					self botpressbutton("tactical");
				}
			}

			var_12 = var_06 - self.vehicle_controlling.origin;
			if(param_01)
			{
				var_08 = length2dsquared(var_12);
			}
			else
			{
				var_08 = lengthsquared(var_12);
			}

			if(var_08 < bot_get_heli_goal_dist_sq(param_01))
			{
				self botsetscriptmove(0,0);
				self botsetflag("disable_movement",1);
				if(self botgetdifficulty() == "recruit")
				{
					self.next_goal_time = gettime() + randomintrange(5000,7000);
				}
				else
				{
					self.next_goal_time = gettime() + randomintrange(3000,5000);
				}

				var_07 = "needs_new_goal";
			}
			else
			{
				var_12 = var_06 - self.vehicle_controlling.origin;
				var_13 = vectortoangles(var_12);
				var_14 = common_scripts\utility::ter_op(var_08 < bot_get_heli_slowdown_dist_sq(param_01),0.5,1);
				self botsetscriptmove(var_13[1],var_0B,var_14);
				var_0A = var_0A - var_0B;
				if(var_0A <= 0)
				{
					if(distancesquared(self.vehicle_controlling.origin,var_09) < 225)
					{
						var_05.bot_visited_times[self.entity_number]++;
						var_07 = "needs_new_goal";
					}

					var_09 = self.vehicle_controlling.origin;
					var_0A = 3;
				}
			}
		}

		wait(var_0B);
	}
}

//Function Number: 23
get_random_outside_target()
{
	var_00 = [];
	foreach(var_02 in level.outside_zones)
	{
		var_03 = botzonegetcount(var_02,self.team,"enemy_predict");
		if(var_03 > 0)
		{
			var_00 = common_scripts\utility::array_add(var_00,var_02);
		}
	}

	var_05 = undefined;
	if(var_00.size > 0)
	{
		var_06 = common_scripts\utility::random(var_00);
		var_07 = common_scripts\utility::random(getzonenodes(var_06));
		var_05 = var_07.origin;
	}
	else
	{
		if(isdefined(level.teleportgetactivenodesfunc))
		{
			var_08 = [[ level.teleportgetactivenodesfunc ]]();
		}
		else
		{
			var_08 = getallnodes();
		}

		var_09 = 0;
		while(var_09 < 10)
		{
			var_09++;
			var_0A = var_08[randomint(var_08.size)];
			var_05 = var_0A.origin;
			if(nodeexposedtosky(var_0A) && distance2dsquared(var_0A.origin,self.vehicle_controlling.origin) > 62500)
			{
				break;
			}
		}
	}

	return var_05;
}