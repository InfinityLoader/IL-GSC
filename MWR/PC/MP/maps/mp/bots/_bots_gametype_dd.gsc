/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_dd.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 373 ms
 * Timestamp: 10/27/2023 2:37:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	bot_dd_start();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_dd_think;
	level.bot_funcs["notify_enemy_bots_bomb_used"] = ::notify_enemy_team_bomb_used;
}

//Function Number: 3
bot_dd_start()
{
	setup_bot_dd();
}

//Function Number: 4
setup_bot_dd()
{
	maps\mp\bots\_bots_gametype_common::bot_setup_bombzone_bottargets();
	maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
	var_00 = maps\mp\bots\_bots_gametype_common::bot_verify_and_cache_bombzones(["_a","_b"]);
	if(var_00)
	{
		foreach(var_02 in level.bombzones)
		{
			var_02 thread maps\mp\bots\_bots_gametype_common::monitor_bombzone_control();
		}

		thread bot_dd_ai_director_update();
		level.bot_gametype_precaching_done = 1;
	}
}

//Function Number: 5
bot_dd_think()
{
	self notify("bot_dd_think");
	self endon("bot_dd_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	while(!isdefined(level.bot_gametype_precaching_done))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	self botsetflag("grenade_objectives",1);
	self.current_bombzone = undefined;
	self.defuser_bad_path_counter = 0;
	for(;;)
	{
		wait(0.05);
		if(isdefined(self.current_bombzone) && !bombzone_is_active(self.current_bombzone))
		{
			self.current_bombzone = undefined;
			bot_dd_clear_role();
		}

		if(maps\mp\_utility::inovertime())
		{
			var_00 = level.bombzones[0].ownerteam != self.team;
		}
		else
		{
			var_00 = self.team == game["attackers"];
		}

		if(var_00)
		{
			bot_pick_new_zone("attack");
			if(!isdefined(self.current_bombzone))
			{
				continue;
			}

			bot_try_switch_attack_zone();
			bot_choose_attack_role();
			if(self.role == "sweep_zone")
			{
				if(!maps\mp\bots\_bots_util::bot_is_defending_point(self.current_bombzone.curorigin))
				{
					var_01["min_goal_time"] = 2;
					var_01["max_goal_time"] = 4;
					var_01["override_origin_node"] = common_scripts\utility::random(self.current_bombzone.bottargets);
					maps\mp\bots\_bots_strategy::bot_protect_point(self.current_bombzone.curorigin,level.protect_radius,var_01);
				}
			}
			else if(self.role == "defend_zone")
			{
				if(!maps\mp\bots\_bots_util::bot_is_defending_point(level.ddbombmodel[self.current_bombzone.label].origin))
				{
					var_01["score_flags"] = "strongly_avoid_center";
					maps\mp\bots\_bots_strategy::bot_protect_point(level.ddbombmodel[self.current_bombzone.label].origin,level.protect_radius,var_01);
				}
			}
			else if(self.role == "investigate_someone_using_bomb")
			{
				investigate_someone_using_bomb();
			}
			else if(self.role == "atk_bomber")
			{
				plant_bomb();
			}

			continue;
		}

		bot_pick_new_zone("defend");
		if(!isdefined(self.current_bombzone))
		{
			continue;
		}

		bot_choose_defend_role();
		if(self.role == "defend_zone")
		{
			if(!maps\mp\bots\_bots_util::bot_is_defending_point(self.current_bombzone.curorigin))
			{
				var_01["score_flags"] = "strict_los";
				var_01["override_origin_node"] = common_scripts\utility::random(self.current_bombzone.bottargets);
				maps\mp\bots\_bots_strategy::bot_protect_point(self.current_bombzone.curorigin,level.protect_radius,var_01);
			}

			continue;
		}

		if(self.role == "investigate_someone_using_bomb")
		{
			investigate_someone_using_bomb();
			continue;
		}

		if(self.role == "defuser")
		{
			defuse_bomb();
		}
	}
}

//Function Number: 6
notify_enemy_team_bomb_used(param_00)
{
	var_01 = maps\mp\bots\_bots_gametype_common::find_closest_bombzone_to_player(self);
	var_02 = maps\mp\bots\_bots_gametype_common::get_ai_hearing_bomb_plant_sound(param_00);
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.current_bombzone) && var_01 == var_04.current_bombzone)
		{
			var_04 bot_dd_set_role("investigate_someone_using_bomb");
		}
	}
}

//Function Number: 7
plant_bomb()
{
	self endon("change_role");
	var_00 = maps\mp\bots\_bots_gametype_common::get_bombzone_node_to_plant_on(self.current_bombzone,0);
	self botsetscriptgoal(var_00.origin,0,"critical");
	var_01 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined,"change_role");
	if(var_01 == "goal")
	{
		var_02 = maps\mp\gametypes\_gamelogic::gettimeremaining();
		var_03 = var_02 - level.planttime * 2 * 1000;
		var_04 = gettime() + var_03;
		if(var_03 > 0)
		{
			maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time(var_03);
		}

		var_05 = var_04 > 0 && gettime() >= var_04;
		var_06 = maps\mp\bots\_bots_gametype_common::bombzone_press_use(level.planttime + 2,"bomb_planted",var_05);
		self botclearscriptgoal();
		if(var_06)
		{
			bot_dd_clear_role();
		}
	}
}

//Function Number: 8
defuse_bomb()
{
	self endon("change_role");
	self botsetpathingstyle("scripted");
	var_00 = maps\mp\bots\_bots_gametype_common::get_bombzone_node_to_defuse_on(self.current_bombzone).origin;
	self botsetscriptgoal(var_00,20,"critical");
	var_01 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined,"change_role");
	if(var_01 == "bad_path")
	{
		self.defuser_bad_path_counter++;
		if(self.defuser_bad_path_counter >= 4)
		{
			for(;;)
			{
				var_02 = getnodesinradiussorted(var_00,50,0);
				var_03 = self.defuser_bad_path_counter - 4;
				if(var_02.size <= var_03)
				{
					var_04 = botgetclosestnavigablepoint(var_00,50,self);
					if(isdefined(var_04))
					{
						self botsetscriptgoal(var_04,20,"critical");
					}
					else
					{
						break;
					}
				}
				else
				{
					self botsetscriptgoal(var_02[var_03].origin,20,"critical");
				}

				var_01 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined,"change_role");
				if(var_01 == "bad_path")
				{
					self.defuser_bad_path_counter++;
					continue;
				}

				break;
			}
		}
	}

	if(var_01 == "goal")
	{
		var_05 = self.current_bombzone.waittime * 1000;
		var_06 = var_05 - level.defusetime * 2 * 1000;
		var_07 = gettime() + var_06;
		if(var_06 > 0)
		{
			maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time(var_06);
		}

		var_08 = var_07 > 0 && gettime() >= var_07;
		var_09 = maps\mp\bots\_bots_gametype_common::bombzone_press_use(level.defusetime + 2,"bomb_defused",var_08);
		if(!var_09 && self.defuser_bad_path_counter >= 4)
		{
			self.defuser_bad_path_counter++;
		}

		self botclearscriptgoal();
		if(var_09)
		{
			bot_dd_clear_role();
		}
	}
}

//Function Number: 9
investigate_someone_using_bomb()
{
	self endon("change_role");
	if(maps\mp\bots\_bots_util::bot_is_defending())
	{
		maps\mp\bots\_bots_strategy::bot_defend_stop();
	}

	self botsetscriptgoalnode(common_scripts\utility::random(self.current_bombzone.bottargets),"critical");
	var_00 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();
	if(var_00 == "goal")
	{
		wait(2);
		bot_dd_clear_role();
	}
}

//Function Number: 10
get_player_defusing_zone(param_00)
{
	var_01 = get_players_at_zone(param_00,self.team);
	foreach(var_03 in var_01)
	{
		if(!isai(var_03))
		{
			if(var_03.isdefusing)
			{
				return var_03;
			}
		}
	}

	foreach(var_03 in var_01)
	{
		if(isai(var_03))
		{
			if(isdefined(var_03.role) && var_03.role == "defuser")
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 11
get_player_planting_zone(param_00)
{
	var_01 = get_players_at_zone(param_00,self.team);
	foreach(var_03 in var_01)
	{
		if(!isai(var_03))
		{
			if(var_03.isplanting)
			{
				return var_03;
			}
		}
	}

	foreach(var_03 in var_01)
	{
		if(isai(var_03))
		{
			if(isdefined(var_03.role) && var_03.role == "atk_bomber")
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 12
bombzone_is_active(param_00)
{
	if(param_00.visibleteam == "any")
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
get_active_bombzones()
{
	var_00 = [];
	foreach(var_02 in level.bombzones)
	{
		if(bombzone_is_active(var_02))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 14
get_players_at_zone(param_00,param_01)
{
	var_02 = [];
	var_03 = maps\mp\bots\_bots_gametype_common::get_living_players_on_team(param_01);
	foreach(var_05 in var_03)
	{
		if(isai(var_05))
		{
			if(isdefined(var_05.current_bombzone) && var_05.current_bombzone == param_00)
			{
				var_02 = common_scripts\utility::array_add(var_02,var_05);
			}

			continue;
		}

		if(distancesquared(var_05.origin,param_00.curorigin) < level.protect_radius * level.protect_radius)
		{
			var_02 = common_scripts\utility::array_add(var_02,var_05);
		}
	}

	return var_02;
}

//Function Number: 15
bot_pick_dd_zone_with_fewer_defenders(param_00,param_01)
{
	var_02[0] = get_players_at_zone(param_00[0],game["defenders"]).size;
	var_02[1] = get_players_at_zone(param_00[1],game["defenders"]).size;
	if(var_02[0] > var_02[1] + param_01)
	{
		return param_00[1];
	}

	if(var_02[0] + param_01 < var_02[1])
	{
		return param_00[0];
	}
}

//Function Number: 16
bot_pick_new_zone(param_00)
{
	var_01 = undefined;
	if(param_00 == "attack")
	{
		var_01 = bot_choose_attack_zone();
	}
	else if(param_00 == "defend")
	{
		var_01 = bot_choose_defend_zone();
	}

	if(isdefined(var_01) && !isdefined(self.current_bombzone) || self.current_bombzone != var_01)
	{
		self.current_bombzone = var_01;
		bot_dd_clear_role();
	}
}

//Function Number: 17
bot_choose_defend_zone()
{
	var_00 = get_active_bombzones();
	var_01 = undefined;
	if(var_00.size == 1)
	{
		var_01 = var_00[0];
	}
	else if(var_00.size == 2)
	{
		var_02[0] = get_players_at_zone(var_00[0],game["defenders"]).size;
		var_02[1] = get_players_at_zone(var_00[1],game["defenders"]).size;
		var_03[0] = is_bomb_planted_on(var_00[0]);
		var_03[1] = is_bomb_planted_on(var_00[1]);
		if((var_03[0] && var_03[1]) || !var_03[0] && !var_03[1])
		{
			var_04 = 0;
			if(isdefined(self.current_bombzone))
			{
				var_04 = 1;
			}

			var_01 = bot_pick_dd_zone_with_fewer_defenders(var_00,var_04);
			if(!isdefined(var_01) && !isdefined(self.current_bombzone))
			{
				var_01 = common_scripts\utility::random(var_00);
			}
		}
		else if(var_03[0] || var_03[1])
		{
			var_05 = common_scripts\utility::ter_op(var_03[0],0,1);
			var_06 = common_scripts\utility::ter_op(!var_03[0],0,1);
			if(var_02[var_05] > var_02[var_06] + 2)
			{
				var_01 = var_00[var_06];
			}
			else if(var_02[var_05] <= var_02[var_06])
			{
				var_01 = var_00[var_05];
			}
			else if(!isdefined(self.current_bombzone))
			{
				if(var_02[var_05] >= var_02[var_06] + 2)
				{
					var_01 = var_00[var_06];
				}
				else if(var_02[var_05] < var_02[var_06] + 2)
				{
					var_01 = var_00[var_05];
				}
			}
		}
	}

	return var_01;
}

//Function Number: 18
get_other_active_zone(param_00)
{
	var_01 = get_active_bombzones();
	foreach(var_03 in var_01)
	{
		if(var_03 != param_00)
		{
			return var_03;
		}
	}
}

//Function Number: 19
bot_choose_attack_zone()
{
	if(isdefined(self.current_bombzone))
	{
		return;
	}

	if(!isdefined(level.current_zone_target) || !bombzone_is_active(level.current_zone_target) || gettime() > level.next_target_switch_time)
	{
		level.next_target_switch_time = gettime() + 1000 * randomintrange(30,45);
		level.current_zone_target = common_scripts\utility::random(get_active_bombzones());
	}

	if(!isdefined(level.current_zone_target))
	{
		return;
	}

	var_00 = level.current_zone_target;
	var_01 = get_other_active_zone(var_00);
	self.current_bombzone = undefined;
	if(isdefined(var_01))
	{
		if(randomfloat(1) < 0.25)
		{
			return var_01;
		}
	}

	return var_00;
}

//Function Number: 20
bot_try_switch_attack_zone()
{
	var_00 = get_other_active_zone(self.current_bombzone);
	if(isdefined(var_00))
	{
		var_01 = distance(self.origin,self.current_bombzone.curorigin);
		var_02 = distance(self.origin,var_00.curorigin);
		if(var_02 < var_01 * 0.6)
		{
			self.current_bombzone = var_00;
		}
	}
}

//Function Number: 21
bot_choose_attack_role()
{
	if(isdefined(self.role))
	{
		if(self.role == "investigate_someone_using_bomb")
		{
			return;
		}
	}

	var_00 = undefined;
	if(is_bomb_planted_on(self.current_bombzone))
	{
		var_00 = "defend_zone";
	}
	else
	{
		var_01 = get_player_planting_zone(self.current_bombzone);
		if(!isdefined(var_01) || var_01 == self)
		{
			var_00 = "atk_bomber";
		}
		else if(isai(var_01))
		{
			var_02 = distance(self.origin,self.current_bombzone.curorigin);
			var_03 = distance(var_01.origin,self.current_bombzone.curorigin);
			if(var_02 < var_03 * 0.9)
			{
				var_00 = "atk_bomber";
				var_01 bot_dd_clear_role();
			}
		}
	}

	if(!isdefined(var_00))
	{
		var_00 = "sweep_zone";
	}

	bot_dd_set_role(var_00);
}

//Function Number: 22
bot_choose_defend_role()
{
	if(isdefined(self.role))
	{
		if(self.role == "investigate_someone_using_bomb")
		{
			return;
		}
	}

	var_00 = undefined;
	if(is_bomb_planted_on(self.current_bombzone))
	{
		var_01 = get_player_defusing_zone(self.current_bombzone);
		if(!isdefined(var_01) || var_01 == self)
		{
			var_00 = "defuser";
		}
		else if(isai(var_01))
		{
			var_02 = distance(self.origin,self.current_bombzone.curorigin);
			var_03 = distance(var_01.origin,self.current_bombzone.curorigin);
			if(var_02 < var_03 * 0.9)
			{
				var_00 = "defuser";
				var_01 bot_dd_clear_role();
			}
		}
	}

	if(!isdefined(var_00))
	{
		var_00 = "defend_zone";
	}

	bot_dd_set_role(var_00);
}

//Function Number: 23
bot_dd_set_role(param_00)
{
	if(!isdefined(self.role) || self.role != param_00)
	{
		bot_dd_clear_role();
		self.role = param_00;
	}
}

//Function Number: 24
bot_dd_clear_role()
{
	self.role = undefined;
	self botclearscriptgoal();
	self botsetpathingstyle(undefined);
	maps\mp\bots\_bots_strategy::bot_defend_stop();
	self notify("change_role");
	self.defuser_bad_path_counter = 0;
}

//Function Number: 25
bot_dd_ai_director_update()
{
	level notify("bot_dd_ai_director_update");
	level endon("bot_dd_ai_director_update");
	level endon("game_ended");
	level.protect_radius = 725;
	for(;;)
	{
		foreach(var_01 in level.bombzones)
		{
			foreach(var_03 in level.players)
			{
				if(isdefined(var_03.role) && isdefined(var_03.current_bombzone) && var_03.current_bombzone == var_01)
				{
					if(!bombzone_is_active(var_01))
					{
						if(var_03.role == "atk_bomber" || var_03.role == "defuser")
						{
							var_03 bot_dd_clear_role();
						}

						continue;
					}

					if(is_bomb_planted_on(var_01))
					{
						if(var_03.role == "atk_bomber")
						{
							var_03 bot_dd_clear_role();
						}
					}
				}
			}
		}

		wait(0.5);
	}
}

//Function Number: 26
is_bomb_planted_on(param_00)
{
	return maps\mp\_utility::is_true(param_00.bombplantedon);
}