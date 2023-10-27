/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_util.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 77
 * Decompile Time: 1383 ms
 * Timestamp: 10/27/2023 1:28:58 AM
*******************************************************************/

//Function Number: 1
bot_get_nodes_in_cone(param_00,param_01,param_02)
{
	var_03 = getnodesinradius(self.origin,param_00,0);
	var_04 = [];
	var_05 = self getnearestnode();
	var_06 = anglestoforward(self getangles());
	var_07 = vectornormalize(var_06 * (1,1,0));
	foreach(var_09 in var_03)
	{
		var_0A = vectornormalize(var_09.origin - self.origin * (1,1,0));
		var_0B = vectordot(var_0A,var_07);
		if(var_0B > param_01)
		{
			if(!param_02 || isdefined(var_05) && getnodesintrigger(var_09,var_05,1))
			{
				var_04 = common_scripts\utility::array_add(var_04,var_09);
			}
		}
	}

	return var_04;
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
	maps/mp/bots/_bots_personality::func_157C();
	self botclearscriptgoal();
}

//Function Number: 4
bot_set_difficulty(param_00)
{
	if(param_00 == "default")
	{
		param_00 = bot_choose_difficulty_for_default();
	}

	self botsetdifficulty(param_00);
	if(isplayer(self))
	{
		self.pers["rankxp"] = maps\mp\_utility::func_397A();
		maps\mp\gametypes\_rank::playerupdaterank();
	}
}

//Function Number: 5
bot_choose_difficulty_for_default()
{
	if(!isdefined(level.bot_difficulty_defaults))
	{
		level.bot_difficulty_defaults = [];
		level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "recruit";
		level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "regular";
		level.bot_difficulty_defaults[level.bot_difficulty_defaults.size] = "hardened";
	}

	var_00 = self.bot_chosen_difficulty;
	if(!isdefined(var_00))
	{
		var_01 = [];
		var_02 = self.team;
		if(!isdefined(var_02))
		{
			var_02 = self.bot_team;
		}

		if(!isdefined(var_02))
		{
			var_02 = self.pers["team"];
		}

		if(!isdefined(var_02))
		{
			var_02 = "allies";
		}

		foreach(var_04 in level.players)
		{
			if(var_04 == self)
			{
				continue;
			}

			if(!isai(var_04))
			{
				continue;
			}

			var_05 = var_04 botgetdifficulty();
			if(var_05 == "default")
			{
				continue;
			}

			var_06 = var_04.team;
			if(!isdefined(var_06))
			{
				var_06 = var_04.bot_team;
			}

			if(!isdefined(var_06))
			{
				var_06 = var_04.pers["team"];
			}

			if(!isdefined(var_06))
			{
				continue;
			}

			if(!isdefined(var_01[var_06]))
			{
				var_01[var_06] = [];
			}

			if(!isdefined(var_01[var_06][var_05]))
			{
				var_01[var_06][var_05] = 1;
				continue;
			}

			var_01[var_06][var_05]++;
		}

		var_08 = -1;
		foreach(var_0A in level.bot_difficulty_defaults)
		{
			if(!isdefined(var_01[var_02]) || !isdefined(var_01[var_02][var_0A]))
			{
				var_00 = var_0A;
				break;
			}
			else if(var_08 == -1 || var_01[var_02][var_0A] < var_08)
			{
				var_08 = var_01[var_02][var_0A];
				var_00 = var_0A;
			}
		}
	}

	if(isdefined(var_00))
	{
		self.bot_chosen_difficulty = var_00;
	}

	return var_00;
}

//Function Number: 6
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

//Function Number: 7
func_1603()
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

//Function Number: 8
func_1604()
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

//Function Number: 9
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

//Function Number: 10
bot_is_defending()
{
	return isdefined(self.bot_defending);
}

//Function Number: 11
bot_is_defending_point(param_00)
{
	if(bot_is_defending())
	{
		if(func_16C0(self.bot_defending_center,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 12
bot_is_guarding_player(param_00)
{
	if(bot_is_bodyguarding() && self.bot_defend_player_guarding == param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
bot_cache_entrances_to_bombzones()
{
	var_00 = [];
	var_01 = [];
	var_02 = 0;
	foreach(var_04 in level.bombzones)
	{
		var_00[var_02] = common_scripts\utility::func_6306(var_04.bottargets).origin;
		var_01[var_02] = "zone" + var_04.label;
		var_02++;
	}

	bot_cache_entrances(var_00,var_01);
}

//Function Number: 14
bot_cache_entrances_to_flags_or_radios(param_00,param_01)
{
	wait(1);
	var_02 = [];
	var_03 = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(isdefined(param_00[var_04].bottarget))
		{
			var_02[var_04] = param_00[var_04].bottarget.origin;
		}
		else
		{
			param_00[var_04].nearest_node = getclosestnodeinsight(param_00[var_04].origin);
			var_02[var_04] = param_00[var_04].nearest_node.origin;
		}

		var_03[var_04] = param_01 + param_00[var_04].script_label;
	}

	bot_cache_entrances(var_02,var_03);
}

//Function Number: 15
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

//Function Number: 16
bot_cache_entrances(param_00,param_01)
{
	wait(0.1);
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_01[var_03];
		var_02[var_04] = nodeexposedtosky(param_00[var_03]);
		wait(0.05);
		for(var_05 = 0;var_05 < var_02[var_04].size;var_05++)
		{
			var_06 = var_02[var_04][var_05];
			var_06.is_precalculated_entrance = 1;
			var_06.prone_visible_from[var_04] = entrance_visible_from(var_06.origin,param_00[var_03],"prone");
			wait(0.05);
			var_06.crouch_visible_from[var_04] = entrance_visible_from(var_06.origin,param_00[var_03],"crouch");
			wait(0.05);
			for(var_07 = 0;var_07 < param_01.size;var_07++)
			{
				for(var_08 = var_07 + 1;var_08 < param_01.size;var_08++)
				{
					var_06.on_path_from[param_01[var_07]][param_01[var_08]] = 0;
					var_06.on_path_from[param_01[var_08]][param_01[var_07]] = 0;
				}
			}
		}
	}

	var_09 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		for(var_05 = var_03 + 1;var_05 < param_00.size;var_05++)
		{
			var_0A = func_3878(param_00[var_03],param_00[var_05]);
			var_09[param_01[var_03]][param_01[var_05]] = var_0A;
			var_09[param_01[var_05]][param_01[var_03]] = var_0A;
			foreach(var_0C in var_0A)
			{
				var_0C.on_path_from[param_01[var_03]][param_01[var_05]] = 1;
				var_0C.on_path_from[param_01[var_05]][param_01[var_03]] = 1;
			}
		}
	}

	if(!isdefined(level.precalculated_paths))
	{
		level.precalculated_paths = [];
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

	level.precalculated_paths = common_scripts\utility::array_combine_non_integer_indices(level.precalculated_paths,var_09);
	level.entrance_origin_points = common_scripts\utility::array_combine(level.entrance_origin_points,param_00);
	level.entrance_indices = common_scripts\utility::array_combine(level.entrance_indices,param_01);
	level.entrance_points = common_scripts\utility::array_combine_non_integer_indices(level.entrance_points,var_02);
	level.entrance_points_finished_caching = 1;
}

//Function Number: 17
func_3878(param_00,param_01)
{
	var_02 = func_get_nodes_on_path(param_00,param_01);
	if(isdefined(var_02))
	{
		var_02 = func_651F(var_02);
		var_02 = func_37BC(var_02);
	}

	return var_02;
}

//Function Number: 18
func_35AC(param_00,param_01)
{
	return badplace_global(param_00,param_01);
}

//Function Number: 19
func_get_nodes_on_path(param_00,param_01)
{
	return nodesvisible(param_00,param_01);
}

//Function Number: 20
func_35A6(param_00,param_01,param_02)
{
	return botdebugdrawtrigger(param_00,param_01,param_02);
}

//Function Number: 21
func_5645(param_00,param_01)
{
	if(!isdefined(self.on_path_from) || !isdefined(self.on_path_from[param_00]) || !isdefined(self.on_path_from[param_00][param_01]))
	{
		return 0;
	}

	return self.on_path_from[param_00][param_01];
}

//Function Number: 22
func_37BC(param_00)
{
	var_01 = param_00;
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = getpathdist(param_00[var_02]);
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

//Function Number: 23
func_39F1(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(getnodesintrigger(var_04,param_01,1))
		{
			var_02 = common_scripts\utility::array_add(var_02,var_04);
		}
	}

	return var_02;
}

//Function Number: 24
func_651F(param_00)
{
	param_00[param_00.size - 1] = undefined;
	param_00[0] = undefined;
	return common_scripts\utility::array_removeundefined(param_00);
}

//Function Number: 25
func_16C4(param_00)
{
	var_01 = 1;
	while(!bot_bots_enabled_or_added(param_00))
	{
		wait(0.5);
	}
}

//Function Number: 26
bot_bots_enabled_or_added(param_00)
{
	if(botgetmemoryevents())
	{
		return 1;
	}

	if(bots_exist(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
bot_waittill_out_of_combat_or_time(param_00)
{
	var_01 = gettime();
	for(;;)
	{
		if(isdefined(param_00))
		{
			if(gettime() > var_01 + param_00)
			{
			}
		}

		if(!isdefined(self.enemy))
		{
		}
		else if(!bot_in_combat())
		{
		}

		wait(0.05);
	}
}

//Function Number: 28
bot_in_combat(param_00)
{
	var_01 = gettime() - self.last_enemy_sight_time;
	var_02 = level.bot_out_of_combat_time;
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}

	return var_01 < var_02;
}

//Function Number: 29
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
		var_04 = common_scripts\utility::func_8B2C(var_03,param_00);
	}
	else
	{
		var_04 = common_scripts\utility::func_8B2E(var_04);
	}

	return var_04;
}

//Function Number: 30
bot_usebutton_wait(param_00,param_01,param_02)
{
	level endon("game_ended");
	childthread func_877B();
	var_03 = common_scripts\utility::func_8B35(param_00,param_01,param_02,"use_button_no_longer_pressed","finished_use");
	self notify("stop_usebutton_watcher");
	return var_03;
}

//Function Number: 31
func_877B(param_00,param_01)
{
	self endon("stop_usebutton_watcher");
	wait(0.05);
	while(self usebuttonpressed())
	{
		wait(0.05);
	}

	self notify("use_button_no_longer_pressed");
}

//Function Number: 32
bots_exist(param_00)
{
	foreach(var_02 in level.participants)
	{
		if(isai(var_02))
		{
			if(isdefined(param_00) && param_00)
			{
				if(!maps\mp\_utility::func_4984(var_02))
				{
					continue;
				}
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 33
bot_get_entrances_for_stance_and_index(param_00,param_01)
{
	if(!isdefined(level.entrance_points_finished_caching) && !isdefined(self.defense_override_entrances))
	{
		return undefined;
	}

	var_02 = [];
	if(isdefined(self.defense_override_entrances))
	{
		var_02 = self.defense_override_entrances;
	}
	else
	{
		var_02 = level.entrance_points[param_01];
	}

	if(!isdefined(param_00) || param_00 == "stand")
	{
		return var_02;
	}
	else if(param_00 == "crouch")
	{
		var_03 = [];
		foreach(var_05 in var_02)
		{
			if(var_05.crouch_visible_from[param_01])
			{
				var_03 = common_scripts\utility::array_add(var_03,var_05);
			}
		}

		return var_03;
	}
	else if(var_04 == "prone")
	{
		var_03 = [];
		foreach(var_07 in var_05)
		{
			if(var_07.prone_visible_from[var_03])
			{
				var_05 = common_scripts\utility::array_add(var_05,var_07);
			}
		}

		return var_05;
	}

	return undefined;
}

//Function Number: 34
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

//Function Number: 35
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

//Function Number: 36
func_15C0(param_00,param_01)
{
	var_02 = undefined;
	if(param_00.size > 0)
	{
		var_02 = self botnodepick(param_00,param_00.size * 0.15,"node_capture",undefined,param_01,self.defense_score_flags);
	}

	return var_02;
}

//Function Number: 37
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

//Function Number: 38
func_165F(param_00,param_01,param_02,param_03,param_04)
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

//Function Number: 39
bot_pick_random_point_from_set(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(param_01.size >= 2)
	{
		var_03 = bot_find_random_midpoint(param_01,param_02);
	}

	if(!isdefined(var_03))
	{
		var_04 = common_scripts\utility::func_6306(param_01);
		var_05 = var_04.origin - param_00;
		var_03 = param_00 + vectornormalize(var_05) * length(var_05) * randomfloat(1);
	}

	return var_03;
}

//Function Number: 40
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
			if(getnodesintrigger(var_06,var_07,1))
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

//Function Number: 41
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

//Function Number: 42
bot_allowed_to_use_killstreaks()
{
	if(maps\mp\_utility::bot_is_fireteam_mode())
	{
		if(isdefined(self.sidelinedbycommander) && self.sidelinedbycommander == 1)
		{
			return 0;
		}
	}

	if(maps\mp\_utility::func_48F6())
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

	if(self setmissileminimapvisible())
	{
		return 0;
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

//Function Number: 43
func_1672()
{
	var_00 = undefined;
	var_01 = botzonenearestcount("investigated","killer_died");
	var_02 = botzonenearestcount("investigated");
	var_03 = common_scripts\utility::func_6306(islocaldoublescreen(0,gettime() - 10000,1,"death",var_01,self));
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

		var_05 = islocaldoublescreen(0,gettime() - -20536,1,"kill",var_02,self);
		var_06 = islocaldoublescreen(0,gettime() - -20536,1,"death",var_01,self);
		var_03 = common_scripts\utility::func_6306(common_scripts\utility::array_combine(var_05,var_06));
		if(isdefined(var_03) > 0 && !isdefined(var_04) || distancesquared(var_04,var_03) > 1000000)
		{
			var_00 = var_03;
			self.bot_memory_goal_time = -20536;
		}
	}

	if(isdefined(var_00))
	{
		var_07 = getzonecount(var_00);
		var_08 = getzonecount(self.origin);
		if(isdefined(var_07) && isdefined(var_08) && var_08 != var_07)
		{
			var_09 = botautoconnectenabled(var_07,self.team,"ally") + botautoconnectenabled(var_07,self.team,"path_ally");
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

//Function Number: 44
bot_draw_cylinder(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
}

//Function Number: 45
bot_draw_cylinder_think(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
}

//Function Number: 46
bot_draw_circle(param_00,param_01,param_02,param_03,param_04)
{
}

//Function Number: 47
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

//Function Number: 48
bot_out_of_ammo()
{
	if(maps\mp\_utility::isjuggernaut())
	{
		if(isdefined(self.isjuggernautmaniac) || isdefined(self.isjuggernautlevelcustom))
		{
			if(self.personality != "run_and_gun")
			{
				self.prev_personality = self.personality;
				bot_set_personality("run_and_gun");
			}

			return 1;
		}
	}

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

//Function Number: 49
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

//Function Number: 50
bot_grenade_matches_purpose(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return 0;
	}

	switch(param_00)
	{
		case "trap_directional":
			switch(param_01)
			{
				case "claymore_mp":
					return 1;
			}
			break;

		case "trap":
			switch(param_01)
			{
				case "proximity_explosive_mp":
				case "motion_sensor_mp":
				case "trophy_mp":
					return 1;
			}
			break;

		case "c4":
			switch(param_01)
			{
				case "c4_mp":
					return 1;
			}
			break;

		case "tacticalinsertion":
			switch(param_01)
			{
				case "flare_mp":
					return 1;
			}
			break;
	}

	return 0;
}

//Function Number: 51
bot_get_grenade_for_purpose(param_00)
{
	if(self botgetdifficultysetting("allowGrenades") != 0)
	{
		var_01 = self botfirstavailablegrenade("lethal");
		if(bot_grenade_matches_purpose(param_00,var_01))
		{
			return "lethal";
		}

		var_01 = self botfirstavailablegrenade("tactical");
		if(bot_grenade_matches_purpose(param_00,var_01))
		{
			return "tactical";
		}
	}
}

//Function Number: 52
bot_watch_nodes(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self notify("bot_watch_nodes");
	self endon("bot_watch_nodes");
	self endon("bot_watch_nodes_stop");
	self endon("disconnect");
	self endon("death");
	wait(1);
	var_08 = 1;
	while(var_08)
	{
		if(self bothasscriptgoal() && self botpursuingscriptgoal())
		{
			if(distancesquared(self botgetscriptgoal(),self.origin) < 16)
			{
				var_08 = 0;
			}
		}

		if(var_08)
		{
			wait(0.05);
		}
	}

	var_09 = self.origin;
	if(isdefined(param_00))
	{
		self.watch_nodes = [];
		foreach(var_0B in param_00)
		{
			var_0C = 0;
			if(function_0210(self.origin,var_0B.origin) <= 10)
			{
				var_0C = 1;
			}

			var_0D = self geteye();
			var_0E = vectordot((0,0,1),vectornormalize(var_0B.origin - var_0D));
			if(abs(var_0E) > 0.92)
			{
				var_0C = 1;
			}

			if(!var_0C)
			{
				self.watch_nodes[self.watch_nodes.size] = var_0B;
			}
		}
	}

	if(!isdefined(self.watch_nodes))
	{
	}

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

	thread func_8C98();
	self.watch_nodes = common_scripts\utility::array_randomize(self.watch_nodes);
	foreach(var_0B in self.watch_nodes)
	{
		var_0B.watch_node_chance[self.entity_number] = 1;
	}

	var_12 = gettime();
	var_13 = var_12;
	var_14 = [];
	var_15 = undefined;
	if(isdefined(param_01))
	{
		var_15 = (0,param_01,0);
	}

	var_16 = isdefined(var_15) && isdefined(param_02);
	var_17 = undefined;
	for(;;)
	{
		var_18 = gettime();
		self notify("still_watching_nodes");
		var_19 = self botgetfovdot();
		if(isdefined(param_03) && var_18 >= param_03)
		{
		}

		if(maps/mp/bots/_bots_strategy::bot_has_tactical_goal())
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

		if(isdefined(var_17) && var_17.watch_node_chance[self.entity_number] == 0)
		{
			var_13 = var_18;
		}

		if(self.watch_nodes.size > 0)
		{
			var_1A = 0;
			if(isdefined(self.enemy))
			{
				var_1B = self lastknownpos(self.enemy);
				var_1C = self lastknowntime(self.enemy);
				if(var_1C && var_18 - var_1C < 5000)
				{
					var_1D = vectornormalize(var_1B - self.origin);
					var_1E = 0;
					for(var_1F = 0;var_1F < self.watch_nodes.size;var_1F++)
					{
						var_20 = vectornormalize(self.watch_nodes[var_1F].origin - self.origin);
						var_21 = vectordot(var_1D,var_20);
						if(var_21 > var_1E)
						{
							var_1E = var_21;
							var_17 = self.watch_nodes[var_1F];
							var_1A = 1;
						}
					}
				}
			}

			if(!var_1A && var_18 >= var_13)
			{
				var_22 = [];
				for(var_1F = 0;var_1F < self.watch_nodes.size;var_1F++)
				{
					var_0B = self.watch_nodes[var_1F];
					var_23 = var_0B getnodenumber();
					if(var_16 && !common_scripts\utility::func_8E18(self.origin,var_15,var_0B.origin,param_02))
					{
						continue;
					}

					if(!isdefined(var_14[var_23]))
					{
						var_14[var_23] = 0;
					}

					if(common_scripts\utility::func_8E18(self.origin,self.angles,var_0B.origin,var_19))
					{
						var_14[var_23] = var_18;
					}

					for(var_24 = 0;var_24 < var_22.size;var_24++)
					{
						if(var_14[var_22[var_24] getnodenumber()] > var_14[var_23])
						{
							break;
						}
					}

					var_22 = common_scripts\utility::array_insert(var_22,var_0B,var_24);
				}

				var_17 = undefined;
				for(var_1F = 0;var_1F < var_22.size;var_1F++)
				{
					if(randomfloat(1) > var_22[var_1F].watch_node_chance[self.entity_number])
					{
						continue;
					}

					var_17 = var_22[var_1F];
					var_13 = var_18 + randomintrange(3000,5000);
					break;
				}
			}

			if(isdefined(var_17))
			{
				var_25 = (0,0,self getviewheight());
				var_26 = var_17.origin + var_25;
				var_27 = self.origin + (0,0,55);
				var_28 = vectornormalize(var_26 - var_27);
				var_29 = (0,0,1);
				if(vectordot(var_29,var_28) > 0.92)
				{
					self botlookatpoint(var_26,0.4,"script_search");
				}
			}
		}

		wait(0.2);
	}
}

//Function Number: 53
watch_nodes_stop()
{
	self notify("bot_watch_nodes_stop");
	self.watch_nodes = undefined;
}

//Function Number: 54
func_8C98()
{
	self notify("watch_nodes_aborted");
	self endon("watch_nodes_aborted");
	for(;;)
	{
		var_00 = common_scripts\utility::func_8B35(0.5,"still_watching_nodes");
		if(!isdefined(var_00) || var_00 != "still_watching_nodes")
		{
			watch_nodes_stop();
		}
	}
}

//Function Number: 55
func_161D(param_00,param_01)
{
	if(isdefined(param_01) && param_01 != (0,0,0))
	{
		if(!common_scripts\utility::func_8E18(self.origin,self.angles,param_01,self botgetfovdot()))
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

//Function Number: 56
bot_get_known_attacker(param_00,param_01)
{
	if(isdefined(param_01) && isdefined(param_01.classname))
	{
		if(param_01.classname == "grenade")
		{
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

//Function Number: 57
bot_ent_is_anonymous_mine(param_00)
{
	if(!isdefined(param_00.weapon_name))
	{
		return 0;
	}

	if(param_00.weapon_name == "c4_mp")
	{
		return 1;
	}

	if(param_00.weapon_name == "proximity_explosive_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 58
func_16C0(param_00,param_01)
{
	return param_00[0] == param_01[0] && param_00[1] == param_01[1] && param_00[2] == param_01[2];
}

//Function Number: 59
bot_add_to_bot_level_targets(param_00)
{
	param_00.high_priority_for = [];
	if(param_00.bot_interaction_type == "use")
	{
		bot_add_to_bot_use_targets(param_00);
	}

	if(param_00.bot_interaction_type == "damage")
	{
		bot_add_to_bot_damage_targets(param_00);
	}
}

//Function Number: 60
bot_remove_from_bot_level_targets(param_00)
{
	param_00.already_used = 1;
	level.level_specific_bot_targets = common_scripts\utility::array_remove(level.level_specific_bot_targets,param_00);
}

//Function Number: 61
bot_add_to_bot_use_targets(param_00)
{
	if(!issubstr(param_00.code_classname,"trigger_use"))
	{
	}

	if(!isdefined(param_00.target))
	{
	}

	if(isdefined(param_00.bot_target))
	{
	}

	if(!isdefined(param_00.use_time))
	{
	}

	var_01 = getnodearray(param_00.target,"targetname");
	if(var_01.size != 1)
	{
	}

	param_00.bot_target = var_01[0];
	if(!isdefined(level.level_specific_bot_targets))
	{
		level.level_specific_bot_targets = [];
	}

	level.level_specific_bot_targets = common_scripts\utility::array_add(level.level_specific_bot_targets,param_00);
}

//Function Number: 62
bot_add_to_bot_damage_targets(param_00)
{
	if(!issubstr(param_00.code_classname,"trigger_damage"))
	{
	}

	var_01 = getnodearray(param_00.target,"targetname");
	if(var_01.size != 2)
	{
	}

	param_00.bot_targets = var_01;
	if(!isdefined(level.level_specific_bot_targets))
	{
		level.level_specific_bot_targets = [];
	}

	level.level_specific_bot_targets = common_scripts\utility::array_add(level.level_specific_bot_targets,param_00);
}

//Function Number: 63
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

//Function Number: 64
bot_get_zones_within_dist(param_00,param_01)
{
	for(var_02 = 0;var_02 < level.zonecount;var_02++)
	{
		var_03 = getzonenodesbydist(var_02);
		var_03.visited = 0;
	}

	var_04 = getzonenodesbydist(param_00);
	return bot_get_zones_within_dist_recurs(var_04,param_01);
}

//Function Number: 65
bot_get_zones_within_dist_recurs(param_00,param_01)
{
	var_02 = [];
	var_02[0] = getzoneorigin(param_00);
	param_00.visited = 1;
	var_03 = getpathdist(param_00);
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

//Function Number: 66
bot_crate_is_command_goal(param_00)
{
	return isdefined(param_00) && isdefined(param_00.command_goal) && param_00.command_goal;
}

//Function Number: 67
bot_get_team_limit()
{
	return castint(bot_get_client_limit() / 2);
}

//Function Number: 68
bot_get_client_limit()
{
	var_00 = getdvarint("party_maxplayers",0);
	var_00 = max(var_00,getdvarint("party_maxPrivatePartyPlayers",0));
	if(getdvar("squad_vs_squad") == "1" || getdvar("squad_use_hosts_squad") == "1" || getdvar("squad_match") == "1")
	{
		var_00 = 12;
	}

	if(var_00 > level.maxclients)
	{
		return level.maxclients;
	}

	return var_00;
}

//Function Number: 69
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

//Function Number: 70
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

	var_07 = addstruct();
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

//Function Number: 71
bot_is_remote_or_linked()
{
	return maps\mp\_utility::func_4995() || self islinked();
}

//Function Number: 72
func_15E6(param_00)
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

//Function Number: 73
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
		if(func_16C0(var_08,var_07))
		{
			return 1;
		}

		wait(0.05);
	}

	return 0;
}

//Function Number: 74
func_163B(param_00)
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
				level.enemy_camp_spots[var_03.team] = var_03 getlinkedchildren(1);
				if(isdefined(level.enemy_camp_spots[var_03.team]))
				{
					if(!isdefined(level.enemy_camp_assassin_goal[var_03.team]) || !common_scripts\utility::array_contains(level.enemy_camp_spots[var_03.team],level.enemy_camp_assassin_goal[var_03.team]))
					{
						level.enemy_camp_assassin_goal[var_03.team] = common_scripts\utility::func_6306(level.enemy_camp_spots[var_03.team]);
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

//Function Number: 75
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

	if(!maps\mp\_utility::func_486C(self))
	{
		return 0;
	}

	if(self.personality == "camper")
	{
		return 0;
	}

	return 1;
}

//Function Number: 76
func_16B7()
{
	if(!isdefined(level.enemy_camp_assassin))
	{
	}

	if(!isdefined(level.enemy_camp_assassin[self.team]))
	{
	}

	if(level.enemy_camp_assassin[self.team] == self)
	{
		maps/mp/bots/_bots_strategy::bot_defend_stop();
		self botsetscriptgoal(level.enemy_camp_assassin_goal[self.team],128,"objective",undefined,256);
		bot_waittill_goal_or_fail();
	}
}

//Function Number: 77
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