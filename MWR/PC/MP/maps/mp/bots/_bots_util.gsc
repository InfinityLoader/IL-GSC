/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_util.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 77
 * Decompile Time: 2690 ms
 * Timestamp: 10/27/2023 2:37:42 AM
*******************************************************************/

//Function Number: 1
bot_get_nodes_in_cone(param_00,param_01,param_02,param_03)
{
	var_04 = getnodesinradius(self.origin,param_01,param_00);
	var_05 = [];
	var_06 = self getnearestnode();
	var_07 = anglestoforward(self getplayerangles());
	var_08 = vectornormalize(var_07 * (1,1,0));
	foreach(var_0A in var_04)
	{
		var_0B = vectornormalize(var_0A.origin - self.origin * (1,1,0));
		var_0C = vectordot(var_0B,var_08);
		if(var_0C > param_02)
		{
			if(!param_03 || isdefined(var_06) && nodesvisible(var_0A,var_06,1))
			{
				var_05[var_05.size] = var_0A;
			}
		}
	}

	return var_05;
}

//Function Number: 2
bot_goal_can_override(param_00,param_01)
{
	if(param_00 == "none")
	{
		return param_01 == "none";
	}
	else if(param_00 == "hunt")
	{
		return param_01 == "hunt" || param_01 == "none";
	}
	else if(param_00 == "guard")
	{
		return param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
	}
	else if(param_00 == "objective")
	{
		return param_01 == "objective" || param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
	}
	else if(param_00 == "critical")
	{
		return param_01 == "critical" || param_01 == "objective" || param_01 == "guard" || param_01 == "hunt" || param_01 == "none";
	}
	else if(param_00 == "tactical")
	{
		return 1;
	}
}

//Function Number: 3
bot_set_personality(param_00)
{
	self botsetpersonality(param_00);
	maps\mp\bots\_bots_personality::bot_assign_personality_functions();
	self botclearscriptgoal();
}

//Function Number: 4
bot_set_difficulty(param_00,param_01)
{
	if(param_00 == "default")
	{
		param_00 = bot_choose_difficulty_for_default();
	}

	var_03 = self botgetdifficulty();
	self botsetdifficulty(param_00);
	if(isplayer(self) && var_03 != param_00)
	{
		maps\mp\_utility::set_rank_xp_and_prestige_for_bot();
		var_04 = function_02EC(maps\mp\gametypes\_rank::gettotalxp(),0);
		self.pers["rank"] = var_04;
		var_05 = self.pers["prestige"];
		self setrank(var_04,var_05);
	}
}

//Function Number: 5
bot_choose_difficulty_for_default()
{
	if(!isdefined(level.bot_difficulty_defaults))
	{
		level.bot_difficulty_defaults = [];
		level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "easy";
		level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "normal";
		level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "hard";
	}

	if(!isdefined(level.bot_next_difficulty_type_index))
	{
		level.bot_next_difficulty_type_index = [];
	}

	if(!isdefined(level.bot_next_difficulty_type_index["allies"]))
	{
		level.bot_next_difficulty_type_index["allies"] = 0;
	}

	if(!isdefined(level.bot_next_difficulty_type_index["axis"]))
	{
		level.bot_next_difficulty_type_index["axis"] = 0;
	}

	if(!isdefined(level.bot_next_difficulty_type_index["all"]))
	{
		level.bot_next_difficulty_type_index["all"] = 0;
	}

	if(!isdefined(self.pers["bot_chosen_difficulty"]))
	{
		var_00 = undefined;
		if(level.teambased)
		{
			var_01 = self.team;
			if(!isdefined(var_01))
			{
				var_01 = self.bot_team;
			}

			if(!isdefined(var_01))
			{
				var_01 = self.pers["team"];
			}
		}
		else
		{
			var_01 = "all";
		}

		var_00 = level.bot_next_difficulty_type_index[var_01];
		var_02 = level.bot_difficulty_defaults[var_00];
		self.pers["bot_chosen_difficulty"] = get_difficulty_for_difficulty_type(var_02);
		level.bot_next_difficulty_type_index[var_01] = level.bot_next_difficulty_type_index[var_01] + 1 % level.bot_difficulty_defaults.size;
	}

	return self.pers["bot_chosen_difficulty"];
}

//Function Number: 6
get_difficulty_for_difficulty_type(param_00)
{
	if(param_00 == "easy")
	{
		return "recruit";
	}

	if(param_00 == "normal")
	{
		return "regular";
	}

	if(param_00 == "hard")
	{
		return common_scripts\utility::random(["hardened","veteran"]);
	}
}

//Function Number: 7
bot_is_capturing()
{
	if(bot_is_defending())
	{
		if(self.bot_defending_type == "capture" || self.bot_defending_type == "capture_zone")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 8
bot_is_patrolling()
{
	if(bot_is_defending())
	{
		if(self.bot_defending_type == "patrol")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
bot_is_protecting()
{
	if(bot_is_defending())
	{
		if(self.bot_defending_type == "protect")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 10
bot_is_bodyguarding()
{
	if(bot_is_defending())
	{
		if(self.bot_defending_type == "bodyguard")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
bot_is_defending()
{
	return isdefined(self.bot_defending);
}

//Function Number: 12
bot_is_defending_point(param_00)
{
	if(bot_is_defending())
	{
		if(bot_vectors_are_equal(self.bot_defending_center,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 13
bot_is_guarding_player(param_00)
{
	if(bot_is_bodyguarding() && self.bot_defend_player_guarding == param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
entrance_visible_from(param_00,param_01,param_02)
{
	var_03 = (0,0,11);
	var_04 = (0,0,40);
	var_05 = undefined;
	if(param_02 == "stand")
	{
		return 1;
	}
	else if(param_02 == "crouch")
	{
		var_05 = var_04;
	}
	else if(param_02 == "prone")
	{
		var_05 = var_03;
	}

	return sighttracepassed(param_01 + var_05,param_00 + var_05,0,undefined);
}

//Function Number: 15
get_extended_path(param_00,param_01)
{
	var_02 = func_get_nodes_on_path(param_00,param_01);
	if(isdefined(var_02))
	{
		var_02 = remove_ends_from_path(var_02);
		var_02 = get_all_connected_nodes(var_02);
	}

	return var_02;
}

//Function Number: 16
func_get_path_dist(param_00,param_01)
{
	return getpathdist(param_00,param_01);
}

//Function Number: 17
func_get_nodes_on_path(param_00,param_01)
{
	return getnodesonpath(param_00,param_01);
}

//Function Number: 18
func_bot_get_closest_navigable_point(param_00,param_01,param_02)
{
	return botgetclosestnavigablepoint(param_00,param_01,param_02);
}

//Function Number: 19
node_is_on_path_from_labels(param_00,param_01)
{
	if(!isdefined(self.on_path_from))
	{
		return 0;
	}

	if(isdefined(self.on_path_from[param_00]) && isdefined(self.on_path_from[param_00][param_01]) && self.on_path_from[param_00][param_01])
	{
		return 1;
	}

	if(isdefined(self.on_path_from[param_01]) && isdefined(self.on_path_from[param_01][param_00]) && self.on_path_from[param_01][param_00])
	{
		return 1;
	}

	return 0;
}

//Function Number: 20
get_all_connected_nodes(param_00)
{
	var_01 = param_00;
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = getlinkednodes(param_00[var_02]);
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			if(!common_scripts\utility::array_contains(var_01,var_03[var_04]))
			{
				var_01 = common_scripts\utility::array_add(var_01,var_03[var_04]);
			}
		}
	}

	return var_01;
}

//Function Number: 21
get_visible_nodes_array(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(nodesvisible(var_04,param_01,1))
		{
			var_02 = common_scripts\utility::array_add(var_02,var_04);
		}
	}

	return var_02;
}

//Function Number: 22
remove_ends_from_path(param_00)
{
	param_00[param_00.size - 1] = undefined;
	param_00[0] = undefined;
	return common_scripts\utility::array_removeundefined(param_00);
}

//Function Number: 23
bot_waittill_bots_enabled(param_00)
{
	while(!bot_bots_enabled_or_added(param_00))
	{
		wait(0.5);
	}
}

//Function Number: 24
bot_bots_enabled_or_added(param_00)
{
	if(botautoconnectenabled() != "off")
	{
		return 1;
	}

	if(isdefined(level.ai_game_mode) && level.ai_game_mode)
	{
		return 1;
	}

	if(bots_exist(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 25
bot_waittill_out_of_combat_or_time(param_00)
{
	var_01 = gettime();
	for(;;)
	{
		if(isdefined(param_00))
		{
			if(gettime() > var_01 + param_00)
			{
				return;
			}
		}

		if(!isdefined(self.enemy))
		{
			return;
		}
		else if(!bot_in_combat())
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 26
bot_in_combat(param_00)
{
	if(self.last_enemy_sight_time == 0)
	{
		return 0;
	}

	var_01 = gettime() - self.last_enemy_sight_time;
	var_02 = level.bot_out_of_combat_time;
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}

	return var_01 < var_02;
}

//Function Number: 27
bot_waittill_goal_or_fail(param_00,param_01,param_02)
{
	if(!isdefined(param_01) && isdefined(param_02))
	{
	}

	var_03 = ["goal","bad_path","no_path","node_relinquished","script_goal_changed"];
	if(isdefined(param_01))
	{
		var_03[var_03.size] = param_01;
	}

	if(isdefined(param_02))
	{
		var_03[var_03.size] = param_02;
	}

	if(isdefined(param_00))
	{
		var_04 = common_scripts\utility::waittill_any_in_array_or_timeout(var_03,param_00);
	}
	else
	{
		var_04 = common_scripts\utility::waittill_any_in_array_return(var_04);
	}

	return var_04;
}

//Function Number: 28
bot_usebutton_wait(param_00,param_01,param_02)
{
	level endon("game_ended");
	childthread use_button_stopped_notify();
	var_03 = common_scripts\utility::waittill_any_timeout(param_00,param_01,param_02,"use_button_no_longer_pressed","finished_use");
	self notify("stop_usebutton_watcher");
	return var_03;
}

//Function Number: 29
use_button_stopped_notify(param_00,param_01)
{
	self endon("stop_usebutton_watcher");
	wait(0.05);
	while(self usebuttonpressed())
	{
		wait(0.05);
	}

	self notify("use_button_no_longer_pressed");
}

//Function Number: 30
bots_exist(param_00)
{
	foreach(var_02 in level.participants)
	{
		if(isai(var_02))
		{
			if(isdefined(param_00) && param_00)
			{
				if(!maps\mp\_utility::isteamparticipant(var_02))
				{
					continue;
				}
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 31
bot_get_entrances_for_stance_and_index(param_00,param_01,param_02)
{
	if(!isdefined(level.entrance_points_finished_caching) && !isdefined(self.defense_override_entrances))
	{
		return undefined;
	}

	if(isarray(param_01))
	{
		if(isdefined(param_02) && param_02)
		{
			var_03 = undefined;
			var_04 = 999999999;
			foreach(var_06 in param_01)
			{
				var_07 = common_scripts\utility::array_find(level.entrance_indices,var_06);
				var_08 = level.entrance_origin_points[var_07];
				var_09 = distancesquared(self.origin,var_08);
				if(var_09 < var_04)
				{
					var_03 = var_06;
					var_04 = var_09;
				}
			}

			param_01 = var_03;
		}
		else
		{
			param_01 = common_scripts\utility::random(param_01);
		}
	}

	var_0B = [];
	if(isdefined(self.defense_override_entrances))
	{
		var_0B = self.defense_override_entrances;
	}
	else
	{
		var_0B = level.entrance_points[param_01];
	}

	if(!isdefined(param_00) || param_00 == "stand")
	{
		return var_0B;
	}
	else if(param_00 == "crouch")
	{
		var_0C = [];
		foreach(var_0E in var_0B)
		{
			if(var_0E.crouch_visible_from[param_01])
			{
				var_0C = common_scripts\utility::array_add(var_0C,var_0E);
			}
		}

		return var_0C;
	}
	else if(var_0C == "prone")
	{
		var_0C = [];
		foreach(var_10 in var_0E)
		{
			if(var_10.prone_visible_from[var_0B])
			{
				var_0E = common_scripts\utility::array_add(var_0E,var_10);
			}
		}

		return var_0E;
	}

	return undefined;
}

//Function Number: 32
bot_find_node_to_guard_player(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = self.bot_defend_player_guarding getvelocity();
	if(lengthsquared(var_04) > 100)
	{
		var_05 = getnodesinradius(param_00,param_01 * 1.75,param_01 * 0.5,500);
		var_06 = [];
		var_07 = vectornormalize(var_04);
		for(var_08 = 0;var_08 < var_05.size;var_08++)
		{
			var_09 = vectornormalize(var_05[var_08].origin - self.bot_defend_player_guarding.origin);
			if(vectordot(var_09,var_07) > 0.1)
			{
				var_06[var_06.size] = var_05[var_08];
			}
		}
	}
	else
	{
		var_06 = getnodesinradius(param_01,param_02,0,500);
	}

	if(isdefined(param_02) && param_02)
	{
		var_0A = vectornormalize(self.bot_defend_player_guarding.origin - self.origin);
		var_0B = var_06;
		var_06 = [];
		foreach(var_0D in var_0B)
		{
			var_09 = vectornormalize(var_0D.origin - self.bot_defend_player_guarding.origin);
			if(vectordot(var_0A,var_09) > 0.2)
			{
				var_06[var_06.size] = var_0D;
			}
		}
	}

	var_0F = [];
	var_10 = [];
	var_11 = [];
	for(var_08 = 0;var_08 < var_06.size;var_08++)
	{
		var_12 = distancesquared(var_06[var_08].origin,param_00) > 10000;
		var_13 = abs(var_06[var_08].origin[2] - self.bot_defend_player_guarding.origin[2]) < 50;
		if(var_12)
		{
			var_0F[var_0F.size] = var_06[var_08];
		}

		if(var_13)
		{
			var_10[var_10.size] = var_06[var_08];
		}

		if(var_12 && var_13)
		{
			var_11[var_11.size] = var_06[var_08];
		}

		if(var_08 % 100 == 99)
		{
			wait(0.05);
		}
	}

	if(var_11.size > 0)
	{
		var_03 = self botnodepick(var_11,var_11.size * 0.15,"node_capture",param_00,undefined,self.defense_score_flags);
	}

	if(!isdefined(var_03))
	{
		wait(0.05);
		if(var_10.size > 0)
		{
			var_03 = self botnodepick(var_10,var_10.size * 0.15,"node_capture",param_00,undefined,self.defense_score_flags);
		}

		if(!isdefined(var_03) && var_0F.size > 0)
		{
			wait(0.05);
			var_03 = self botnodepick(var_0F,var_0F.size * 0.15,"node_capture",param_00,undefined,self.defense_score_flags);
		}
	}

	return var_03;
}

//Function Number: 33
bot_find_node_to_capture_point(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = getnodesinradius(param_00,param_01,0,500);
	if(var_04.size > 0)
	{
		var_03 = self botnodepick(var_04,var_04.size * 0.15,"node_capture",param_00,param_02,self.defense_score_flags);
	}

	return var_03;
}

//Function Number: 34
bot_find_node_to_capture_zone(param_00,param_01)
{
	var_02 = undefined;
	if(param_00.size > 0)
	{
		var_02 = self botnodepick(param_00,param_00.size * 0.15,"node_capture",undefined,param_01,self.defense_score_flags);
	}

	return var_02;
}

//Function Number: 35
bot_find_node_that_protects_point(param_00,param_01)
{
	var_02 = undefined;
	var_03 = getnodesinradius(param_00,param_01,0,500);
	if(var_03.size > 0)
	{
		var_02 = self botnodepick(var_03,var_03.size * 0.15,"node_protect",param_00,self.defense_score_flags);
	}

	return var_02;
}

//Function Number: 36
bot_pick_random_point_in_radius(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = undefined;
	var_06 = getnodesinradius(param_00,param_01,0,500);
	if(isdefined(var_06) && var_06.size >= 2)
	{
		var_05 = bot_find_random_midpoint(var_06,param_02);
	}

	if(!isdefined(var_05))
	{
		if(!isdefined(param_03))
		{
			param_03 = 0;
		}

		if(!isdefined(param_04))
		{
			param_04 = 1;
		}

		var_07 = randomfloatrange(self.bot_defending_radius * param_03,self.bot_defending_radius * param_04);
		var_08 = anglestoforward((0,randomint(360),0));
		var_05 = param_00 + var_08 * var_07;
	}

	return var_05;
}

//Function Number: 37
bot_pick_random_point_from_set(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(param_01.size >= 2)
	{
		var_03 = bot_find_random_midpoint(param_01,param_02);
	}

	if(!isdefined(var_03))
	{
		var_04 = common_scripts\utility::random(param_01);
		var_05 = var_04.origin - param_00;
		var_03 = param_00 + vectornormalize(var_05) * length(var_05) * randomfloat(1);
	}

	return var_03;
}

//Function Number: 38
bot_find_random_midpoint(param_00,param_01)
{
	var_02 = undefined;
	var_03 = common_scripts\utility::array_randomize(param_00);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		for(var_05 = var_04 + 1;var_05 < var_03.size;var_05++)
		{
			var_06 = var_03[var_04];
			var_07 = var_03[var_05];
			if(nodesvisible(var_06,var_07,1))
			{
				var_02 = (var_06.origin[0] + var_07.origin[0] * 0.5,var_06.origin[1] + var_07.origin[1] * 0.5,var_06.origin[2] + var_07.origin[2] * 0.5);
				if(isdefined(param_01) && self [[ param_01 ]](var_02) == 1)
				{
					return var_02;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 39
defend_valid_center()
{
	if(isdefined(self.bot_defending_override_origin_node))
	{
		return self.bot_defending_override_origin_node.origin;
	}
	else if(isdefined(self.bot_defending_center))
	{
		return self.bot_defending_center;
	}

	return undefined;
}

//Function Number: 40
bot_allowed_to_use_killstreaks()
{
	if(maps\mp\_utility::iskillstreakdenied())
	{
		return 0;
	}

	if(bot_is_remote_or_linked())
	{
		return 0;
	}

	if(self isusingturret())
	{
		return 0;
	}

	if(isdefined(level.nukeincoming))
	{
		return 0;
	}

	if(isdefined(self.underwater) && self.underwater)
	{
		return 0;
	}

	if(isdefined(self.controlsfrozen) && self.controlsfrozen)
	{
		return 0;
	}

	if(self isoffhandweaponreadytothrow())
	{
		return 0;
	}

	if(maps\mp\_utility::getgametypenumlives() > 0)
	{
		var_00 = 1;
		foreach(var_02 in level.participants)
		{
			if(isalive(var_02) && !isalliedsentient(self,var_02))
			{
				var_00 = 0;
			}
		}

		if(var_00)
		{
			return 0;
		}
	}

	if(!bot_in_combat(500))
	{
		return 1;
	}

	if(!isalive(self.enemy))
	{
		return 1;
	}

	return 0;
}

//Function Number: 41
bot_recent_point_of_interest()
{
	var_00 = undefined;
	var_01 = botmemoryflags("investigated","killer_died");
	var_02 = botmemoryflags("investigated");
	var_03 = common_scripts\utility::random(botgetmemoryevents(0,gettime() - 10000,1,"death",var_01,self));
	if(isdefined(var_03))
	{
		var_00 = var_03;
		self.bot_memory_goal_time = 10000;
	}
	else
	{
		var_04 = undefined;
		if(self botgetscriptgoaltype() != "none")
		{
			var_04 = self botgetscriptgoal();
		}

		var_05 = botgetmemoryevents(0,gettime() - 45000,1,"kill",var_02,self);
		var_06 = botgetmemoryevents(0,gettime() - 45000,1,"death",var_01,self);
		var_03 = common_scripts\utility::random(common_scripts\utility::array_combine(var_05,var_06));
		if(isdefined(var_03) > 0 && !isdefined(var_04) || distancesquared(var_04,var_03) > 1000000)
		{
			var_00 = var_03;
			self.bot_memory_goal_time = 45000;
		}
	}

	if(isdefined(var_00))
	{
		var_07 = getzonenearest(var_00);
		var_08 = getzonenearest(self.origin);
		if(isdefined(var_07) && isdefined(var_08) && var_08 != var_07)
		{
			var_09 = botzonegetcount(var_07,self.team,"ally") + botzonegetcount(var_07,self.team,"path_ally");
			if(var_09 > 1)
			{
				var_00 = undefined;
			}
		}
	}

	if(isdefined(var_00))
	{
		self.bot_memory_goal = var_00;
	}

	return var_00;
}

//Function Number: 42
bot_draw_cylinder(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
}

//Function Number: 43
bot_draw_cylinder_think(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
}

//Function Number: 44
bot_draw_circle(param_00,param_01,param_02,param_03,param_04)
{
}

//Function Number: 45
bot_get_total_gun_ammo()
{
	var_00 = 0;
	var_01 = undefined;
	if(isdefined(self.weaponlist) && self.weaponlist.size > 0)
	{
		var_01 = self.weaponlist;
	}
	else
	{
		var_01 = self getweaponslistprimaries();
	}

	foreach(var_03 in var_01)
	{
		var_00 = var_00 + self getweaponammoclip(var_03);
		var_00 = var_00 + self getweaponammostock(var_03);
	}

	return var_00;
}

//Function Number: 46
bot_out_of_ammo()
{
	var_00 = undefined;
	if(isdefined(self.weaponlist) && self.weaponlist.size > 0)
	{
		var_00 = self.weaponlist;
	}
	else
	{
		var_00 = self getweaponslistprimaries();
	}

	foreach(var_02 in var_00)
	{
		if(self getweaponammoclip(var_02) > 0)
		{
			return 0;
		}

		if(self getweaponammostock(var_02) > 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 47
bot_get_grenade_ammo()
{
	var_00 = 0;
	var_01 = self getweaponslistoffhands();
	foreach(var_03 in var_01)
	{
		var_00 = var_00 + self getweaponammostock(var_03);
	}

	return var_00;
}

//Function Number: 48
bot_item_matches_purpose(param_00,param_01)
{
	switch(param_00)
	{
		case "trap_directional":
			break;

		case "c4":
			break;
	}
}

//Function Number: 49
bot_watch_nodes(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self notify("bot_watch_nodes");
	self endon("bot_watch_nodes");
	self endon("bot_watch_nodes_stop");
	self endon("using_remote");
	self endon("disconnect");
	self endon("death");
	if(isdefined(param_04))
	{
		self endon(param_04);
	}

	if(isdefined(param_05))
	{
		self endon(param_05);
	}

	if(isdefined(param_06))
	{
		self endon(param_06);
	}

	if(isdefined(param_07))
	{
		self endon(param_07);
	}

	wait(1);
	var_08 = 1;
	var_09 = squared(self botgetscriptgoalradius());
	while(var_08)
	{
		if(self bothasscriptgoal() && self botpursuingscriptgoal())
		{
			if(distancesquared(self botgetscriptgoal(),self.origin) < var_09)
			{
				if(length(self getvelocity()) <= 1)
				{
					var_08 = 0;
				}
			}
		}

		if(var_08)
		{
			wait(0.05);
		}
	}

	var_0A = self.origin;
	var_0B = (0,0,self getplayerviewheight());
	if(isdefined(param_00))
	{
		self.watch_nodes = [];
		foreach(var_0D in param_00)
		{
			var_0E = 0;
			if(distance2dsquared(self.origin,var_0D.origin) <= 40)
			{
				var_0E = 1;
			}

			var_0F = self geteye();
			var_10 = vectordot((0,0,1),vectornormalize(var_0D.origin + var_0B - var_0F));
			if(abs(var_10) > 0.92)
			{
				var_0E = 1;
			}

			if(!var_0E)
			{
				self.watch_nodes[self.watch_nodes.size] = var_0D;
			}
		}
	}

	if(!isdefined(self.watch_nodes))
	{
		return;
	}

	thread watch_nodes_aborted();
	self.watch_nodes = common_scripts\utility::array_randomize(self.watch_nodes);
	foreach(var_0D in self.watch_nodes)
	{
		var_0D.watch_node_chance[self.entity_number] = 1;
	}

	var_14 = gettime();
	var_15 = var_14;
	var_16 = [];
	var_17 = undefined;
	if(isdefined(param_01))
	{
		var_17 = (0,param_01,0);
	}

	var_18 = isdefined(var_17) && isdefined(param_02);
	var_19 = undefined;
	for(;;)
	{
		var_1A = gettime();
		self notify("still_watching_nodes");
		var_1B = self botgetfovdot();
		if(isdefined(param_03) && var_1A >= param_03)
		{
			return;
		}

		if(maps\mp\bots\_bots_strategy::bot_has_tactical_goal())
		{
			self botlookatpoint(undefined);
			wait(0.2);
			continue;
		}

		if(!self bothasscriptgoal() || !self botpursuingscriptgoal())
		{
			wait(0.2);
			continue;
		}

		if(isdefined(var_19) && var_19.watch_node_chance[self.entity_number] == 0)
		{
			var_15 = var_1A;
		}

		if(self.watch_nodes.size > 0)
		{
			var_1C = 0;
			if(isdefined(self.enemy))
			{
				var_1D = self lastknownpos(self.enemy);
				var_1E = self lastknowntime(self.enemy);
				if(var_1E && var_1A - var_1E < 5000)
				{
					var_1F = vectornormalize(var_1D - self.origin);
					var_20 = 0;
					for(var_21 = 0;var_21 < self.watch_nodes.size;var_21++)
					{
						var_22 = vectornormalize(self.watch_nodes[var_21].origin - self.origin);
						var_23 = vectordot(var_1F,var_22);
						if(var_23 > var_20)
						{
							var_20 = var_23;
							var_19 = self.watch_nodes[var_21];
							var_1C = 1;
						}
					}
				}
			}

			if(!var_1C && var_1A >= var_15)
			{
				var_24 = [];
				for(var_21 = 0;var_21 < self.watch_nodes.size;var_21++)
				{
					var_0D = self.watch_nodes[var_21];
					var_25 = var_0D getnodenumber();
					if(var_18 && !common_scripts\utility::within_fov(self.origin,var_17,var_0D.origin,param_02))
					{
						continue;
					}

					if(distance2dsquared(self.origin,var_0D.origin) <= 10)
					{
						continue;
					}

					if(!isdefined(var_16[var_25]))
					{
						var_16[var_25] = 0;
					}

					if(common_scripts\utility::within_fov(self.origin,self getplayerangles(),var_0D.origin,var_1B))
					{
						var_16[var_25] = var_1A;
					}

					for(var_26 = 0;var_26 < var_24.size;var_26++)
					{
						if(var_16[var_24[var_26] getnodenumber()] > var_16[var_25])
						{
							break;
						}
					}

					var_24 = common_scripts\utility::array_insert(var_24,var_0D,var_26);
				}

				var_19 = undefined;
				for(var_21 = 0;var_21 < var_24.size;var_21++)
				{
					if(randomfloat(1) > var_24[var_21].watch_node_chance[self.entity_number])
					{
						continue;
					}

					var_19 = var_24[var_21];
					var_15 = var_1A + randomintrange(3000,5000);
					break;
				}
			}

			if(isdefined(var_19))
			{
				var_27 = var_19.origin + var_0B;
				if(distance2dsquared(self.origin,var_27) <= 10)
				{
					self botlookatpoint(undefined);
					var_19 = undefined;
					var_15 = 0;
				}
				else
				{
					self botlookatpoint(var_27,0.4,"script_search");
				}
			}
		}

		wait(0.2);
	}
}

//Function Number: 50
watch_nodes_stop()
{
	self notify("bot_watch_nodes_stop");
	if(isdefined(self.watch_nodes))
	{
		foreach(var_01 in self.watch_nodes)
		{
			var_01.watch_node_chance[self.entity_number] = undefined;
		}
	}

	self.watch_nodes = undefined;
}

//Function Number: 51
watch_nodes_aborted()
{
	self notify("watch_nodes_aborted");
	self endon("watch_nodes_aborted");
	self endon("disconnect");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_timeout(0.5,"still_watching_nodes");
		if(!isdefined(var_00) || var_00 != "still_watching_nodes")
		{
			watch_nodes_stop();
			return;
		}
	}
}

//Function Number: 52
bot_leader_dialog(param_00,param_01)
{
	if(isdefined(param_01) && param_01 != (0,0,0))
	{
		if(!common_scripts\utility::within_fov(self.origin,self getplayerangles(),param_01,self botgetfovdot()))
		{
			var_02 = self botpredictseepoint(param_01);
			if(isdefined(var_02))
			{
				self botlookatpoint(var_02 + (0,0,40),1,"script_seek");
			}
		}

		self botmemoryevent("known_enemy",undefined,param_01);
	}
}

//Function Number: 53
bot_get_known_attacker(param_00,param_01)
{
	if(isdefined(param_01) && isdefined(param_01.classname))
	{
		if(param_01.classname == "grenade")
		{
			if(isdefined(param_00) && param_00.classname == "worldspawn")
			{
				return undefined;
			}

			if(!bot_ent_is_anonymous_mine(param_01))
			{
				return param_00;
			}
		}
		else if(param_01.classname == "rocket")
		{
			if(isdefined(param_01.vehicle_fired_from))
			{
				return param_01.vehicle_fired_from;
			}

			if(isdefined(param_01.type) && param_01.type == "remote" || param_01.type == "odin")
			{
				return param_01;
			}

			if(isdefined(param_01.owner))
			{
				return param_01.owner;
			}
		}
		else if(param_01.classname == "worldspawn" || param_01.classname == "trigger_hurt")
		{
			return undefined;
		}

		return param_01;
	}

	return param_00;
}

//Function Number: 54
bot_ent_is_anonymous_mine(param_00)
{
	var_01 = param_00.weapon_name;
	if(!isdefined(var_01))
	{
		var_01 = param_00.weaponname;
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	if(issubstr(var_01,"c4_mp"))
	{
		return 1;
	}

	if(issubstr(var_01,"claymore_mp"))
	{
		return 1;
	}

	if(issubstr(var_01,"proximity_explosive_mp"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 55
bot_vectors_are_equal(param_00,param_01)
{
	return param_00[0] == param_01[0] && param_00[1] == param_01[1] && param_00[2] == param_01[2];
}

//Function Number: 56
bot_add_to_bot_level_targets(param_00)
{
	param_00.high_priority_for = [];
	if(param_00.bot_interaction_type == "use")
	{
		bot_add_to_bot_use_targets(param_00);
		return;
	}

	if(param_00.bot_interaction_type == "damage")
	{
		bot_add_to_bot_damage_targets(param_00);
		return;
	}
}

//Function Number: 57
bot_remove_from_bot_level_targets(param_00)
{
	param_00.already_used = 1;
	level.level_specific_bot_targets = common_scripts\utility::array_remove(level.level_specific_bot_targets,param_00);
}

//Function Number: 58
bot_add_to_bot_use_targets(param_00)
{
	if(!issubstr(param_00.code_classname,"trigger_use"))
	{
		return;
	}

	if(!isdefined(param_00.target))
	{
		return;
	}

	if(isdefined(param_00.bot_target))
	{
		return;
	}

	if(!isdefined(param_00.use_time))
	{
		return;
	}

	var_01 = getnodearray(param_00.target,"targetname");
	if(var_01.size != 1)
	{
		return;
	}

	param_00.bot_target = var_01[0];
	if(!isdefined(level.level_specific_bot_targets))
	{
		level.level_specific_bot_targets = [];
	}

	level.level_specific_bot_targets = common_scripts\utility::array_add(level.level_specific_bot_targets,param_00);
}

//Function Number: 59
bot_add_to_bot_damage_targets(param_00)
{
	if(!issubstr(param_00.code_classname,"trigger_damage"))
	{
		return;
	}

	var_01 = getnodearray(param_00.target,"targetname");
	if(var_01.size != 2)
	{
		return;
	}

	param_00.bot_targets = var_01;
	if(!isdefined(level.level_specific_bot_targets))
	{
		level.level_specific_bot_targets = [];
	}

	level.level_specific_bot_targets = common_scripts\utility::array_add(level.level_specific_bot_targets,param_00);
}

//Function Number: 60
bot_get_string_index_for_integer(param_00,param_01)
{
	var_02 = 0;
	foreach(var_05, var_04 in param_00)
	{
		if(var_02 == param_01)
		{
			return var_05;
		}

		var_02++;
	}

	return undefined;
}

//Function Number: 61
bot_get_zones_within_dist(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.zonecount;var_02++)
	{
		var_03 = getzonenodeforindex(var_02);
		var_03.visited = 0;
	}

	var_04 = getzonenodeforindex(param_00);
	return bot_get_zones_within_dist_recurs(var_04,param_01);
}

//Function Number: 62
bot_get_zones_within_dist_recurs(param_00,param_01)
{
	var_02 = [];
	var_02[0] = getnodezone(param_00);
	param_00.visited = 1;
	var_03 = getlinkednodes(param_00);
	foreach(var_05 in var_03)
	{
		if(!var_05.visited)
		{
			var_06 = distance(param_00.origin,var_05.origin);
			if(var_06 < param_01)
			{
				var_07 = bot_get_zones_within_dist_recurs(var_05,param_01 - var_06);
				var_02 = common_scripts\utility::array_combine(var_07,var_02);
			}
		}
	}

	return var_02;
}

//Function Number: 63
bot_crate_is_command_goal(param_00)
{
	return isdefined(param_00) && isdefined(param_00.command_goal) && param_00.command_goal;
}

//Function Number: 64
bot_get_max_players_on_team(param_00)
{
	return level.bot_max_players_on_team[param_00];
}

//Function Number: 65
bot_get_team_limit()
{
	return int(bot_get_client_limit() / 2);
}

//Function Number: 66
bot_get_client_limit()
{
	var_00 = getdvarint("party_maxplayers",0);
	var_00 = max(var_00,getdvarint("party_maxPrivatePartyPlayers",0));
	if(var_00 > level.maxclients)
	{
		return level.maxclients;
	}

	return var_00;
}

//Function Number: 67
bot_queued_process_level_thread()
{
	self notify("bot_queued_process_level_thread");
	self endon("bot_queued_process_level_thread");
	wait(0.05);
	for(;;)
	{
		if(isdefined(level.bot_queued_process_queue) && level.bot_queued_process_queue.size > 0)
		{
			var_00 = level.bot_queued_process_queue[0];
			if(isdefined(var_00) && isdefined(var_00.owner))
			{
				var_01 = undefined;
				if(isdefined(var_00.parm4))
				{
					var_01 = var_00.owner [[ var_00.func ]](var_00.parm1,var_00.parm2,var_00.parm3,var_00.parm4);
				}
				else if(isdefined(var_00.parm3))
				{
					var_01 = var_00.owner [[ var_00.func ]](var_00.parm1,var_00.parm2,var_00.parm3);
				}
				else if(isdefined(var_00.parm2))
				{
					var_01 = var_00.owner [[ var_00.func ]](var_00.parm1,var_00.parm2);
				}
				else if(isdefined(var_00.parm1))
				{
					var_01 = var_00.owner [[ var_00.func ]](var_00.parm1);
				}
				else
				{
					var_01 = var_00.owner [[ var_00.func ]]();
				}

				var_00.owner notify(var_00.name_complete,var_01);
			}

			var_02 = [];
			for(var_03 = 1;var_03 < level.bot_queued_process_queue.size;var_03++)
			{
				var_02[var_03 - 1] = level.bot_queued_process_queue[var_03];
			}

			level.bot_queued_process_queue = var_02;
		}

		wait(0.05);
	}
}

//Function Number: 68
bot_queued_process(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.bot_queued_process_queue))
	{
		level.bot_queued_process_queue = [];
	}

	foreach(var_08, var_07 in level.bot_queued_process_queue)
	{
		if(var_07.owner == self && var_07.name == param_00)
		{
			self notify(var_07.name);
			level.bot_queued_process_queue[var_08] = undefined;
		}
	}

	var_07 = spawnstruct();
	var_07.owner = self;
	var_07.name = param_00;
	var_07.name_complete = var_07.name + "_done";
	var_07.func = param_01;
	var_07.parm1 = param_02;
	var_07.parm2 = param_03;
	var_07.parm3 = param_04;
	var_07.parm4 = param_05;
	level.bot_queued_process_queue[level.bot_queued_process_queue.size] = var_07;
	if(!isdefined(level.bot_queued_process_level_thread_active))
	{
		level.bot_queued_process_level_thread_active = 1;
		level thread bot_queued_process_level_thread();
	}

	self waittill(var_07.name_complete,var_09);
	return var_09;
}

//Function Number: 69
bot_is_remote_or_linked()
{
	return maps\mp\_utility::isusingremote() || self islinked();
}

//Function Number: 70
bot_get_low_on_ammo(param_00)
{
	var_01 = undefined;
	if(isdefined(self.weaponlist) && self.weaponlist.size > 0)
	{
		var_01 = self.weaponlist;
	}
	else
	{
		var_01 = self getweaponslistprimaries();
	}

	foreach(var_03 in var_01)
	{
		var_04 = weaponclipsize(var_03);
		var_05 = self getweaponammostock(var_03);
		if(var_05 <= var_04)
		{
			return 1;
		}

		if(self getfractionmaxammo(var_03) <= param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 71
bot_point_is_on_pathgrid(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 256;
	}

	if(!isdefined(param_02))
	{
		param_02 = 50;
	}

	var_03 = getnodesinradiussorted(param_00,param_01,0,param_02,"Path");
	foreach(var_05 in var_03)
	{
		var_06 = param_00 + (0,0,30);
		var_07 = var_05.origin + (0,0,30);
		var_08 = physicstrace(var_06,var_07);
		if(bot_vectors_are_equal(var_08,var_07))
		{
			return 1;
		}

		wait(0.05);
	}

	return 0;
}

//Function Number: 72
bot_monitor_enemy_camp_spots(param_00)
{
	level endon("game_ended");
	self notify("bot_monitor_enemy_camp_spots");
	self endon("bot_monitor_enemy_camp_spots");
	level.enemy_camp_spots = [];
	level.enemy_camp_assassin_goal = [];
	level.enemy_camp_assassin = [];
	for(;;)
	{
		wait(1);
		var_01 = [];
		if(!isdefined(param_00))
		{
			continue;
		}

		foreach(var_03 in level.participants)
		{
			if(!isdefined(var_03.team))
			{
				continue;
			}

			if(var_03 [[ param_00 ]]() && !isdefined(var_01[var_03.team]))
			{
				level.enemy_camp_assassin[var_03.team] = undefined;
				level.enemy_camp_spots[var_03.team] = var_03 method_8432(1);
				if(isdefined(level.enemy_camp_spots[var_03.team]))
				{
					if(!isdefined(level.enemy_camp_assassin_goal[var_03.team]) || !common_scripts\utility::array_contains(level.enemy_camp_spots[var_03.team],level.enemy_camp_assassin_goal[var_03.team]))
					{
						level.enemy_camp_assassin_goal[var_03.team] = common_scripts\utility::random(level.enemy_camp_spots[var_03.team]);
					}

					if(isdefined(level.enemy_camp_assassin_goal[var_03.team]))
					{
						var_04 = [];
						foreach(var_06 in level.participants)
						{
							if(!isdefined(var_06.team))
							{
								continue;
							}

							if(var_06 [[ param_00 ]]() && var_06.team == var_03.team)
							{
								var_04[var_04.size] = var_06;
							}
						}

						var_04 = sortbydistance(var_04,level.enemy_camp_assassin_goal[var_03.team]);
						if(var_04.size > 0)
						{
							level.enemy_camp_assassin[var_03.team] = var_04[0];
						}
					}
				}

				var_01[var_03.team] = 1;
			}
		}
	}
}

//Function Number: 73
bot_valid_camp_assassin()
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(!isai(self))
	{
		return 0;
	}

	if(!isdefined(self.team))
	{
		return 0;
	}

	if(self.team == "spectator")
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(!maps\mp\_utility::isaiteamparticipant(self))
	{
		return 0;
	}

	if(!isdefined(self.personality) || self.personality == "camper")
	{
		return 0;
	}

	return 1;
}

//Function Number: 74
bot_update_camp_assassin()
{
	if(!isdefined(level.enemy_camp_assassin))
	{
		return;
	}

	if(!isdefined(level.enemy_camp_assassin[self.team]))
	{
		return;
	}

	if(level.enemy_camp_assassin[self.team] == self)
	{
		maps\mp\bots\_bots_strategy::bot_defend_stop();
		self botsetscriptgoal(level.enemy_camp_assassin_goal[self.team],128,"objective",undefined,256);
		bot_waittill_goal_or_fail();
	}
}

//Function Number: 75
bot_force_stance_for_time(param_00,param_01)
{
	self notify("bot_force_stance_for_time");
	self endon("bot_force_stance_for_time");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self botsetstance(param_00);
	wait(param_01);
	self botsetstance("none");
}

//Function Number: 76
bot_disable_movement_for_time(param_00)
{
	self notify("bot_disable_movement_for_time");
	self endon("bot_disable_movement_for_time");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self botsetflag("disable_movement",1);
	wait(param_00);
	self botsetflag("disable_movement",0);
}

//Function Number: 77
bot_get_active_and_stowed_weapons()
{
	var_00["active"] = self getcurrentweapon();
	if(weaponclass(var_00["active"]) == "rocketlauncher" || !maps\mp\gametypes\_weapons::isprimaryweapon(var_00["active"]))
	{
		var_00["active"] = common_scripts\utility::getlastweapon();
	}

	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(var_03 != var_00["active"])
		{
			var_00["stowed"] = var_03;
		}
	}

	return var_00;
}