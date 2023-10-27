/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_common.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 447 ms
 * Timestamp: 10/27/2023 2:37:07 AM
*******************************************************************/

//Function Number: 1
bot_cache_entrances_to_bombzones()
{
	var_00 = [];
	var_01 = [];
	var_02 = 0;
	foreach(var_04 in level.bombzones)
	{
		var_00[var_02] = common_scripts\utility::random(var_04.bottargets).origin;
		var_01[var_02] = "zone" + var_04.label;
		var_02++;
	}

	bot_cache_entrances(var_00,var_01);
}

//Function Number: 2
bot_cache_entrances_to_gametype_array(param_00,param_01,param_02,param_03)
{
	wait(1);
	var_04 = [];
	var_05 = [];
	var_06 = 0;
	foreach(var_0A, var_08 in param_00)
	{
		if(isdefined(param_00[var_0A].bottarget))
		{
			var_04[var_06] = param_00[var_0A].bottarget.origin;
		}
		else
		{
			param_00[var_0A].nearest_node = getclosestnodeinsight(param_00[var_0A].origin);
			if(!isdefined(param_00[var_0A].nearest_node))
			{
				var_09 = getnodesinradiussorted(param_00[var_0A].origin,256,0);
				if(var_09.size > 0)
				{
					param_00[var_0A].nearest_node = var_09[0];
				}
			}

			if(!isdefined(param_00[var_0A].nearest_node))
			{
				continue;
			}

			if(distance(param_00[var_0A].nearest_node.origin,param_00[var_0A].origin) > 128)
			{
				param_00[var_0A].nearest_node = undefined;
				continue;
			}

			var_04[var_06] = param_00[var_0A].nearest_node.origin;
		}

		var_05[var_06] = param_01 + param_00[var_0A].script_label;
		var_06++;
	}

	bot_cache_entrances(var_04,var_05,param_02,param_03);
}

//Function Number: 3
bot_cache_entrances(param_00,param_01,param_02,param_03)
{
	var_04 = !isdefined(param_02) || !param_02;
	var_05 = isdefined(param_03) && param_03;
	wait(0.1);
	if(var_05 && var_04)
	{
		var_06 = getallnodes();
		foreach(var_08 in var_06)
		{
			var_08.on_path_from = undefined;
		}
	}

	var_0A = [];
	for(var_0B = 0;var_0B < param_00.size;var_0B++)
	{
		var_0C = param_01[var_0B];
		var_0A[var_0C] = findentrances(param_00[var_0B]);
		wait(0.05);
		for(var_0D = 0;var_0D < var_0A[var_0C].size;var_0D++)
		{
			var_0E = var_0A[var_0C][var_0D];
			var_0E.is_precalculated_entrance = 1;
			var_0E.prone_visible_from[var_0C] = maps\mp\bots\_bots_util::entrance_visible_from(var_0E.origin,param_00[var_0B],"prone");
			wait(0.05);
			var_0E.crouch_visible_from[var_0C] = maps\mp\bots\_bots_util::entrance_visible_from(var_0E.origin,param_00[var_0B],"crouch");
			wait(0.05);
		}
	}

	var_0F = [];
	if(var_04)
	{
		for(var_0B = 0;var_0B < param_00.size;var_0B++)
		{
			for(var_0D = var_0B + 1;var_0D < param_00.size;var_0D++)
			{
				var_10 = maps\mp\bots\_bots_util::get_extended_path(param_00[var_0B],param_00[var_0D]);
				foreach(var_08 in var_10)
				{
					var_08.on_path_from[param_01[var_0B]][param_01[var_0D]] = 1;
				}
			}
		}
	}

	if(!isdefined(level.entrance_origin_points))
	{
		level.entrance_origin_points = [];
	}

	if(!isdefined(level.entrance_indices))
	{
		level.entrance_indices = [];
	}

	if(!isdefined(level.entrance_points))
	{
		level.entrance_points = [];
	}

	if(var_05)
	{
		level.entrance_origin_points = param_00;
		level.entrance_indices = param_01;
		level.entrance_points = var_0A;
	}
	else
	{
		level.entrance_origin_points = common_scripts\utility::array_combine(level.entrance_origin_points,param_00);
		level.entrance_indices = common_scripts\utility::array_combine(level.entrance_indices,param_01);
		level.entrance_points = common_scripts\utility::array_combine_non_integer_indices(level.entrance_points,var_0A);
	}

	level.entrance_points_finished_caching = 1;
}

//Function Number: 4
bot_add_missing_nodes(param_00,param_01)
{
	if(param_01.classname == "trigger_radius")
	{
		var_02 = getnodesinradius(param_01.origin,param_01.radius,0,100);
		var_03 = common_scripts\utility::array_remove_array(var_02,param_00);
		if(var_03.size > 0)
		{
			param_00 = common_scripts\utility::array_combine(param_00,var_03);
		}
	}
	else if(param_01.classname == "trigger_multiple" || param_01.classname == "trigger_use_touch")
	{
		var_04[0] = param_01 getpointinbounds(1,1,1);
		var_04[1] = param_01 getpointinbounds(1,1,-1);
		var_04[2] = param_01 getpointinbounds(1,-1,1);
		var_04[3] = param_01 getpointinbounds(1,-1,-1);
		var_04[4] = param_01 getpointinbounds(-1,1,1);
		var_04[5] = param_01 getpointinbounds(-1,1,-1);
		var_04[6] = param_01 getpointinbounds(-1,-1,1);
		var_04[7] = param_01 getpointinbounds(-1,-1,-1);
		var_05 = 0;
		foreach(var_07 in var_04)
		{
			var_08 = distance(var_07,param_01.origin);
			if(var_08 > var_05)
			{
				var_05 = var_08;
			}
		}

		var_02 = getnodesinradius(param_01.origin,var_05,0,200);
		foreach(var_0B in var_02)
		{
			if(!ispointinvolume(var_0B.origin,param_01))
			{
				if(ispointinvolume(var_0B.origin + (0,0,40),param_01) || ispointinvolume(var_0B.origin + (0,0,80),param_01) || ispointinvolume(var_0B.origin + (0,0,120),param_01))
				{
					if(var_0B.type != "Begin" && var_0B.type != "End")
					{
						param_00 = common_scripts\utility::array_add(param_00,var_0B);
					}
				}
			}
		}
	}

	return param_00;
}

//Function Number: 5
bot_setup_bombzone_bottargets()
{
	wait(1);
	bot_setup_bot_targets(level.bombzones);
	level.bot_set_bombzone_bottargets = 1;
}

//Function Number: 6
bot_setup_bot_targets(param_00)
{
	foreach(var_02 in param_00)
	{
		if(!isdefined(var_02.bottargets))
		{
			var_02.bottargets = bot_get_valid_nodes_in_trigger(var_02.trigger);
		}
	}
}

//Function Number: 7
bot_gametype_get_num_players_on_team(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.participants)
	{
		if(maps\mp\_utility::isteamparticipant(var_03) && isdefined(var_03.team) && var_03.team == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 8
bot_gametype_get_allied_attackers_for_team(param_00,param_01,param_02)
{
	var_03 = bot_gametype_get_players_by_role("attacker",param_00);
	foreach(var_05 in level.players)
	{
		if(!isai(var_05) && isdefined(var_05.team) && var_05.team == param_00)
		{
			if(var_05 bot_gametype_human_player_always_considered_attacker() || distancesquared(param_01,var_05.origin) > squared(param_02))
			{
				var_03 = common_scripts\utility::array_add(var_03,var_05);
			}
		}
	}

	return var_03;
}

//Function Number: 9
bot_gametype_get_allied_defenders_for_team(param_00,param_01,param_02)
{
	var_03 = bot_gametype_get_players_by_role("defender",param_00);
	foreach(var_05 in level.players)
	{
		if(!isai(var_05) && isdefined(var_05.team) && var_05.team == param_00)
		{
			if(var_05 bot_gametype_human_player_always_considered_defender() || distancesquared(param_01,var_05.origin) <= squared(param_02))
			{
				var_03 = common_scripts\utility::array_add(var_03,var_05);
			}
		}
	}

	return var_03;
}

//Function Number: 10
bot_gametype_human_player_always_considered_attacker()
{
	if(isdefined(level.bot_gametype_human_player_always_attacker))
	{
		return self [[ level.bot_gametype_human_player_always_attacker ]]();
	}

	return 0;
}

//Function Number: 11
bot_gametype_human_player_always_considered_defender()
{
	if(isdefined(level.bot_gametype_human_player_always_defender))
	{
		return self [[ level.bot_gametype_human_player_always_defender ]]();
	}

	return 0;
}

//Function Number: 12
bot_gametype_set_role(param_00)
{
	self.role = param_00;
	self botclearscriptgoal();
	maps\mp\bots\_bots_strategy::bot_defend_stop();
}

//Function Number: 13
bot_gametype_get_players_by_role(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.participants)
	{
		if(isdefined(var_04.team) && isalive(var_04) && maps\mp\_utility::isteamparticipant(var_04) && var_04.team == param_01 && isdefined(var_04.role) && var_04.role == param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 14
bot_gametype_initialize_attacker_defender_role()
{
	var_00 = [[ level.bot_gametype_allied_attackers_for_team ]](self.team);
	var_01 = [[ level.bot_gametype_allied_defenders_for_team ]](self.team);
	var_02 = [[ level.bot_gametype_attacker_limit_for_team ]](self.team);
	var_03 = [[ level.bot_gametype_defender_limit_for_team ]](self.team);
	var_04 = level.bot_personality_type[self.personality];
	if(var_04 == "active")
	{
		if(var_00.size >= var_02)
		{
			var_05 = 0;
			foreach(var_07 in var_00)
			{
				if(isai(var_07) && level.bot_personality_type[var_07.personality] == "stationary" && var_07 bot_can_switch_to_defender())
				{
					var_07.role = undefined;
					var_05 = 1;
					break;
				}
			}

			if(var_05)
			{
				bot_gametype_set_role("attacker");
				return;
			}

			bot_gametype_set_role("defender");
			return;
		}

		bot_gametype_set_role("attacker");
		return;
	}

	if(var_04 == "stationary")
	{
		if(var_01.size >= var_03)
		{
			var_05 = 0;
			foreach(var_0A in var_01)
			{
				if(isai(var_0A) && level.bot_personality_type[var_0A.personality] == "active" && var_0A bot_can_switch_to_attacker())
				{
					var_0A.role = undefined;
					var_05 = 1;
					break;
				}
			}

			if(var_05)
			{
				bot_gametype_set_role("defender");
				return;
			}

			bot_gametype_set_role("attacker");
			return;
		}

		bot_gametype_set_role("defender");
		return;
	}
}

//Function Number: 15
bot_gametype_attacker_defender_ai_director_update()
{
	level notify("bot_gametype_attacker_defender_ai_director_update");
	level endon("bot_gametype_attacker_defender_ai_director_update");
	level endon("game_ended");
	var_00 = ["allies","axis"];
	var_01 = gettime() + 2000;
	for(;;)
	{
		if(gettime() > var_01)
		{
			var_01 = gettime() + 1000;
			foreach(var_03 in var_00)
			{
				var_04 = [[ level.bot_gametype_allied_attackers_for_team ]](var_03);
				var_05 = [[ level.bot_gametype_allied_defenders_for_team ]](var_03);
				var_06 = [[ level.bot_gametype_attacker_limit_for_team ]](var_03);
				var_07 = [[ level.bot_gametype_defender_limit_for_team ]](var_03);
				if(var_04.size > var_06)
				{
					var_08 = [];
					var_09 = 0;
					foreach(var_0B in var_04)
					{
						if(isai(var_0B) && var_0B bot_can_switch_to_defender())
						{
							if(level.bot_personality_type[var_0B.personality] == "stationary")
							{
								var_0B bot_gametype_set_role("defender");
								var_09 = 1;
								break;
							}
							else
							{
								var_08 = common_scripts\utility::array_add(var_08,var_0B);
							}
						}
					}

					if(!var_09 && var_08.size > 0)
					{
						common_scripts\utility::random(var_08) bot_gametype_set_role("defender");
					}
				}

				if(var_05.size > var_07)
				{
					var_0D = [];
					var_0E = 0;
					foreach(var_10 in var_05)
					{
						if(isai(var_10) && var_10 bot_can_switch_to_attacker())
						{
							if(level.bot_personality_type[var_10.personality] == "active")
							{
								var_10 bot_gametype_set_role("attacker");
								var_0E = 1;
								break;
							}
							else
							{
								var_0D = common_scripts\utility::array_add(var_0D,var_10);
							}
						}
					}

					if(!var_0E && var_0D.size > 0)
					{
						common_scripts\utility::random(var_0D) bot_gametype_set_role("attacker");
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 16
bot_can_switch_to_attacker()
{
	if(isdefined(level.bot_gametype_allowed_to_switch_to_attacker))
	{
		return self [[ level.bot_gametype_allowed_to_switch_to_attacker ]]();
	}

	return 1;
}

//Function Number: 17
bot_can_switch_to_defender()
{
	if(isdefined(level.bot_gametype_allowed_to_switch_to_defender))
	{
		return self [[ level.bot_gametype_allowed_to_switch_to_defender ]]();
	}

	return 1;
}

//Function Number: 18
bot_verify_and_cache_bombzones(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.bombzones)
	{
	}

	if(!var_01)
	{
		bot_cache_entrances_to_bombzones();
	}

	return !var_01;
}

//Function Number: 19
bot_get_valid_nodes_in_trigger(param_00)
{
	var_01 = getnodesintrigger(param_00);
	var_01 = bot_add_missing_nodes(var_01,param_00);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(!var_04 nodeisdisconnected() && var_04.type != "Begin" && var_04.type != "End")
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 20
bot_cache_entrances_to_zones(param_00)
{
	var_01 = [];
	var_02 = [];
	var_03 = 0;
	foreach(var_05 in param_00)
	{
		var_06 = 0;
		var_05.entrance_indices = [];
		var_05.zone_bounds = calculate_zone_node_extents(var_05);
		var_05.center_node = zone_get_node_nearest_2d_bounds(var_05,0,0);
		var_07 = [(0,0,0),(1,1,0),(1,-1,0),(-1,1,0),(-1,-1,0)];
		foreach(var_09 in var_07)
		{
			var_0A = zone_get_node_nearest_2d_bounds(var_05,var_09[0],var_09[1]);
			var_01[var_03] = var_0A.origin;
			var_0B = var_05.script_label + "_" + var_06;
			var_02[var_03] = var_0B;
			var_05.entrance_indices[var_05.entrance_indices.size] = var_0B;
			var_03++;
			var_06++;
		}
	}

	bot_cache_entrances(var_01,var_02,1);
}

//Function Number: 21
calculate_zone_node_extents(param_00)
{
	var_01 = spawnstruct();
	var_01.min_pt = (999999,999999,999999);
	var_01.max_pt = (-999999,-999999,-999999);
	foreach(var_03 in param_00.nodes)
	{
		var_01.min_pt = (min(var_03.origin[0],var_01.min_pt[0]),min(var_03.origin[1],var_01.min_pt[1]),min(var_03.origin[2],var_01.min_pt[2]));
		var_01.max_pt = (max(var_03.origin[0],var_01.max_pt[0]),max(var_03.origin[1],var_01.max_pt[1]),max(var_03.origin[2],var_01.max_pt[2]));
	}

	var_01.center = (var_01.min_pt[0] + var_01.max_pt[0] / 2,var_01.min_pt[1] + var_01.max_pt[1] / 2,var_01.min_pt[2] + var_01.max_pt[2] / 2);
	var_01.half_size = (var_01.max_pt[0] - var_01.center[0],var_01.max_pt[1] - var_01.center[1],var_01.max_pt[2] - var_01.center[2]);
	var_01.radius = max(var_01.half_size[0],var_01.half_size[1]);
	return var_01;
}

//Function Number: 22
zone_get_node_nearest_2d_bounds(param_00,param_01,param_02)
{
	var_03 = (param_00.zone_bounds.center[0] + param_01 * param_00.zone_bounds.half_size[0],param_00.zone_bounds.center[1] + param_02 * param_00.zone_bounds.half_size[1],0);
	var_04 = undefined;
	var_05 = 9999999;
	foreach(var_07 in param_00.nodes)
	{
		var_08 = distance2dsquared(var_07.origin,var_03);
		if(var_08 < var_05)
		{
			var_05 = var_08;
			var_04 = var_07;
		}
	}

	return var_04;
}

//Function Number: 23
monitor_zone_control()
{
	self notify("monitor_zone_control");
	self endon("monitor_zone_control");
	self endon("death");
	level endon("game_ended");
	var_00 = getzonenearest(self.origin);
	for(;;)
	{
		var_01 = "none";
		if(isdefined(self.gameobject))
		{
			var_01 = self.gameobject maps\mp\gametypes\_gameobjects::getownerteam();
		}

		if(var_01 == "neutral" || var_01 == "none")
		{
			botzonesetteam(var_00,"free");
		}
		else
		{
			botzonesetteam(var_00,var_01);
		}

		wait(1);
	}
}

//Function Number: 24
monitor_bombzone_control()
{
	self notify("monitor_bombzone_control");
	self endon("monitor_bombzone_control");
	self endon("death");
	level endon("game_ended");
	var_00 = getzonenearest(self.curorigin);
	for(;;)
	{
		if(self.bombplantedon)
		{
			var_01 = common_scripts\utility::get_enemy_team(self.ownerteam);
		}
		else
		{
			var_01 = self.ownerteam;
		}

		if(var_01 == "neutral")
		{
			var_01 = "free";
		}

		botzonesetteam(var_00,var_01);
		wait(1);
	}
}

//Function Number: 25
find_closest_bombzone_to_player(param_00)
{
	var_01 = undefined;
	var_02 = 999999999;
	foreach(var_04 in level.bombzones)
	{
		var_05 = distancesquared(var_04.curorigin,param_00.origin);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 26
get_living_players_on_team(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.participants)
	{
		if(!isdefined(var_04.team))
		{
			continue;
		}

		if(maps\mp\_utility::isreallyalive(var_04) && maps\mp\_utility::isteamparticipant(var_04) && var_04.team == param_00)
		{
			if(!isdefined(param_01) || param_01 && isai(var_04) && isdefined(var_04.role))
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 27
get_bombzone_node_to_plant_on(param_00,param_01)
{
	if(param_00.bottargets.size >= 2)
	{
		if(param_01)
		{
			var_02 = self botnodescoremultiple(param_00.bottargets,"node_exposed");
		}
		else
		{
			var_02 = self botnodescoremultiple(param_01.bottargets,"node_hide_anywhere","ignore_occupancy");
		}

		var_03 = self botgetdifficultysetting("strategyLevel") * 0.3;
		var_04 = self botgetdifficultysetting("strategyLevel") + 1 * 0.15;
		var_05 = common_scripts\utility::array_randomize(param_00.bottargets);
		foreach(var_07 in var_05)
		{
			if(!common_scripts\utility::array_contains(var_02,var_07))
			{
				var_02[var_02.size] = var_07;
			}
		}

		if(randomfloat(1) < var_03)
		{
			return var_02[0];
		}

		if(randomfloat(1) < var_04)
		{
			return var_02[1];
		}

		return common_scripts\utility::random(var_02);
	}

	return param_00.bottargets[0];
}

//Function Number: 28
get_bombzone_node_to_defuse_on(param_00)
{
	var_01 = self botnodescoremultiple(param_00.bottargets,"node_hide_anywhere","ignore_occupancy");
	var_02 = self botgetdifficultysetting("strategyLevel") * 0.3;
	var_03 = self botgetdifficultysetting("strategyLevel") + 1 * 0.15;
	var_04 = common_scripts\utility::array_randomize(param_00.bottargets);
	foreach(var_06 in var_04)
	{
		if(!common_scripts\utility::array_contains(var_01,var_06))
		{
			var_01[var_01.size] = var_06;
		}
	}

	if(randomfloat(1) < var_02)
	{
		return var_01[0];
	}

	if(randomfloat(1) < var_03)
	{
		return var_01[1];
	}

	return common_scripts\utility::random(var_01);
}

//Function Number: 29
bombzone_press_use(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	if(self botgetdifficultysetting("strategyLevel") == 1)
	{
		var_04 = 40;
	}
	else if(self botgetdifficultysetting("strategyLevel") >= 2)
	{
		var_04 = 80;
	}

	if(randomint(100) < var_04 && !isdefined(param_03) && param_03)
	{
		self botsetstance("prone");
		wait(0.2);
	}

	if(self botgetdifficultysetting("strategyLevel") > 0 && !param_02)
	{
		childthread notify_on_whizby();
		childthread notify_on_damage();
	}

	self botpressbutton("use",param_00);
	var_05 = maps\mp\bots\_bots_util::bot_usebutton_wait(param_00,param_01,"use_interrupted");
	self botsetstance("none");
	self botclearbutton("use");
	var_06 = var_05 == param_01;
	return var_06;
}

//Function Number: 30
notify_on_whizby()
{
	var_00 = find_closest_bombzone_to_player(self);
	self waittill("bulletwhizby",var_01);
	if(!isdefined(var_01.team) || var_01.team != self.team)
	{
		var_02 = var_00.usetime - var_00.curprogress;
		if(var_02 > 1000)
		{
			self notify("use_interrupted");
		}
	}
}

//Function Number: 31
notify_on_damage()
{
	self waittill("damage",var_00,var_01);
	if(!isdefined(var_01.team) || var_01.team != self.team)
	{
		self notify("use_interrupted");
	}
}

//Function Number: 32
get_ai_hearing_bomb_plant_sound(param_00)
{
	var_01 = [];
	var_02 = get_living_players_on_team(common_scripts\utility::get_enemy_team(self.team));
	foreach(var_04 in var_02)
	{
		if(!isai(var_04))
		{
			continue;
		}

		var_05 = 0;
		if(param_00 == "plant")
		{
			var_05 = 300 + var_04 botgetdifficultysetting("strategyLevel") * 100;
		}
		else if(param_00 == "defuse")
		{
			var_05 = 500 + var_04 botgetdifficultysetting("strategyLevel") * 500;
		}

		if(distancesquared(var_04.origin,self.origin) < squared(var_05))
		{
			var_01[var_01.size] = var_04;
		}
	}

	return var_01;
}