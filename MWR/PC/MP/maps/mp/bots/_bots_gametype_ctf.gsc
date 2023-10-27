/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_ctf.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 284 ms
 * Timestamp: 10/27/2023 2:37:09 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	setup_bot_ctf();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["crate_can_use"] = ::crate_can_use;
	level.bot_funcs["gametype_think"] = ::bot_ctf_think;
	level.bot_funcs["get_watch_node_chance"] = ::bot_ctf_get_node_chance;
}

//Function Number: 3
setup_bot_ctf()
{
	level.bot_gametype_attacker_limit_for_team = ::ctf_bot_attacker_limit_for_team;
	level.bot_gametype_defender_limit_for_team = ::ctf_bot_defender_limit_for_team;
	level.bot_gametype_allied_attackers_for_team = ::get_allied_attackers_for_team;
	level.bot_gametype_allied_defenders_for_team = ::get_allied_defenders_for_team;
	level.bot_gametype_allowed_to_switch_to_defender = ::bot_ctf_can_switch_to_defender;
	level.bot_gametype_human_player_always_attacker = ::bot_ctf_player_always_attacker;
	maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
	while(!isdefined(level.teamflags))
	{
		wait(0.05);
	}

	level.teamflags["allies"].script_label = "allies";
	level.teamflags["axis"].script_label = "axis";
	maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_gametype_array(level.teamflags,"flag_");
	var_00 = getzonenearest(level.teamflags["allies"].origin);
	if(isdefined(var_00))
	{
		botzonesetteam(var_00,"allies");
	}

	var_00 = getzonenearest(level.teamflags["axis"].origin);
	if(isdefined(var_00))
	{
		botzonesetteam(var_00,"axis");
	}

	level.capzones["allies"].nearest_node = level.teamflags["allies"].nearest_node;
	level.capzones["axis"].nearest_node = level.teamflags["axis"].nearest_node;
	thread bot_ctf_ai_director_update();
	level.bot_gametype_precaching_done = 1;
}

//Function Number: 4
crate_can_use(param_00)
{
	if(isagent(self) && !isdefined(param_00.boxtype))
	{
		return 0;
	}

	if(bot_ctf_player_has_flag())
	{
		return 0;
	}

	return bot_ctf_flag_is_home_of_team(self.team);
}

//Function Number: 5
bot_ctf_think()
{
	self notify("bot_ctf_think");
	self endon("bot_ctf_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.bot_gametype_precaching_done))
	{
		wait(0.05);
	}

	self.next_flag_hide_time = 0;
	self botsetflag("separation",0);
	self botsetflag("use_obj_path_style",1);
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		wait(0.05);
		if(self.health <= 0)
		{
			continue;
		}

		if(!isdefined(self.role))
		{
			maps\mp\bots\_bots_gametype_common::bot_gametype_initialize_attacker_defender_role();
		}

		if(bot_ctf_flag_is_home_of_team(self.team))
		{
			if(isdefined(level.bot_known_flag_carrier_loc) && isdefined(level.bot_known_flag_carrier_loc[level.otherteam[self.team]]))
			{
				level.bot_known_flag_carrier_loc[level.otherteam[self.team]] = undefined;
			}
		}

		var_02 = 0;
		if(self.role == "attacker")
		{
			if(bot_ctf_player_has_flag())
			{
				var_02 = 1;
			}
			else if(!bot_ctf_enemy_team_flag_is_picked_up())
			{
				var_02 = distancesquared(self.origin,level.teamflags[level.otherteam[self.team]].curorigin) < squared(get_flag_protect_radius());
			}
		}
		else if(!bot_ctf_flag_is_home_of_team(self.team))
		{
			var_02 = !bot_ctf_my_team_flag_is_picked_up();
		}

		self botsetflag("force_sprint",var_02);
		var_01 = 0;
		if(bot_ctf_player_has_flag())
		{
			if(bot_ctf_flag_is_home_of_team(self.team))
			{
				clear_defend();
				var_01 = 1;
				if(!var_00)
				{
					var_00 = 1;
					self botsetpathingstyle("scripted");
				}

				self botsetscriptgoal(level.capzones[self.team].curorigin,16,"critical");
			}
			else if(maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team(self.team) == 1)
			{
				bot_ctf_recover_flag();
			}
			else if(gettime() > self.next_flag_hide_time)
			{
				clear_defend();
				var_03 = getnodesinradius(level.capzones[self.team].curorigin,900,0,300);
				var_04 = self botnodepick(var_03,var_03.size * 0.15,"node_hide_anywhere");
				if(!isdefined(var_04))
				{
					var_04 = level.capzones[self.team].nearest_node;
				}

				var_05 = self botsetscriptgoalnode(var_04,"critical");
				if(var_05)
				{
					self.next_flag_hide_time = gettime() + 15000;
				}
			}
		}
		else if(self.role == "attacker")
		{
			if(bot_ctf_enemy_team_flag_is_picked_up())
			{
				if(!maps\mp\bots\_bots_util::bot_is_bodyguarding())
				{
					clear_defend();
					self botclearscriptgoal();
					var_06 = level.teamflags[level.otherteam[self.team]].carrier;
					maps\mp\bots\_bots_strategy::bot_guard_player(var_06,500);
				}
			}
			else
			{
				clear_defend();
				if(self botgetscriptgoaltype() == "critical")
				{
					self botclearscriptgoal();
				}

				self botsetscriptgoal(level.teamflags[level.otherteam[self.team]].curorigin,16,"objective",undefined,300);
			}
		}
		else if(!bot_ctf_flag_is_home_of_team(self.team))
		{
			bot_ctf_recover_flag();
		}
		else if(!is_protecting_flag())
		{
			self botclearscriptgoal();
			var_07["score_flags"] = "strict_los";
			var_07["entrance_points_index"] = "flag_" + level.teamflags[self.team].script_label;
			var_07["nearest_node_to_center"] = level.teamflags[self.team].nearest_node;
			maps\mp\bots\_bots_strategy::bot_protect_point(level.teamflags[self.team].curorigin,get_flag_protect_radius(),var_07);
		}

		if(var_00 && !var_01)
		{
			var_00 = 0;
			self botsetpathingstyle(undefined);
		}
	}
}

//Function Number: 6
bot_ctf_recover_flag()
{
	var_00 = undefined;
	var_01 = level.teamflags[self.team];
	var_02 = var_01.carrier;
	if(!isdefined(var_02))
	{
		var_00 = var_01.curorigin;
	}
	else if(self botcanseeentity(var_02))
	{
		var_00 = var_02.origin;
		if(self botgetdifficultysetting("strategyLevel") > 0 && !bot_ctf_flag_is_home_of_team(self.team))
		{
			if(!isdefined(level.bot_known_flag_carrier_loc))
			{
				level.bot_known_flag_carrier_loc = [];
			}

			if(!isdefined(level.bot_known_flag_carrier_loc[var_02.team]))
			{
				level.bot_known_flag_carrier_loc[var_02.team] = [];
			}

			level.bot_known_flag_carrier_loc[var_02.team]["origin"] = var_00;
			level.bot_known_flag_carrier_loc[var_02.team]["time"] = gettime();
		}
	}
	else if(isdefined(var_01.curcarrierorigin))
	{
		if(isdefined(var_01.compassicons["friendly"]))
		{
			if(var_01.objidpingfriendly)
			{
				var_00 = var_01.curcarrierorigin;
			}
			else
			{
				var_00 = var_02.origin;
			}
		}
	}
	else
	{
		var_00 = var_01.curorigin;
	}

	if(isdefined(var_00))
	{
		clear_defend();
		self botsetscriptgoal(var_00,16,"critical");
		return;
	}

	var_03 = undefined;
	var_04 = undefined;
	if(self botgetdifficultysetting("strategyLevel") > 0)
	{
		if(isdefined(level.bot_known_flag_carrier_loc) && isdefined(level.bot_known_flag_carrier_loc[var_02.team]))
		{
			var_04 = gettime() - level.bot_known_flag_carrier_loc[var_02.team]["time"];
			if(var_04 < 10000)
			{
				var_03 = level.bot_known_flag_carrier_loc[var_02.team]["origin"];
			}
		}
	}

	if(isdefined(var_03))
	{
		if(var_04 < 5000)
		{
			clear_defend();
			self botsetscriptgoal(var_03,16,"critical");
			return;
		}

		if(!maps\mp\bots\_bots_util::bot_is_patrolling())
		{
			maps\mp\bots\_bots_strategy::bot_defend_stop();
			maps\mp\bots\_bots_strategy::bot_patrol_area(var_03,400);
			return;
		}

		return;
	}

	clear_defend();
	var_05 = self botgetscriptgoaltype();
	if(var_05 == "objective" || var_05 == "critical")
	{
		self botclearscriptgoal();
	}

	maps\mp\bots\_bots_personality::update_personality_default();
}

//Function Number: 7
clear_defend()
{
	if(maps\mp\bots\_bots_util::bot_is_defending())
	{
		maps\mp\bots\_bots_strategy::bot_defend_stop();
	}
}

//Function Number: 8
is_protecting_flag()
{
	return maps\mp\bots\_bots_util::bot_is_protecting();
}

//Function Number: 9
get_flag_protect_radius()
{
	if(isalive(self) && !isdefined(level.protect_radius))
	{
		var_00 = self botgetworldsize();
		var_01 = var_00[0] + var_00[1] / 2;
		level.protect_radius = min(800,var_01 / 5.5);
	}

	if(!isdefined(level.protect_radius))
	{
		return 900;
	}

	return level.protect_radius;
}

//Function Number: 10
ctf_bot_attacker_limit_for_team(param_00)
{
	var_01 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team(param_00);
	if(var_01 == 1)
	{
		return 1;
	}

	if(bot_ctf_flag_is_home_of_team(param_00))
	{
		var_02 = var_01 * 0.67;
	}
	else if(bot_ctf_flag_is_home_of_team(level.otherteam[var_01]))
	{
		var_02 = var_02 * 0.5;
	}
	else
	{
		var_02 = var_02 * 0.4;
	}

	var_03 = int(exp(var_02));
	var_04 = game["teamScores"][param_00];
	var_05 = game["teamScores"][common_scripts\utility::get_enemy_team(param_00)];
	if(var_04 + 1 < var_05)
	{
		var_03 = int(min(var_03 + 1,var_01));
	}

	return var_03;
}

//Function Number: 11
ctf_bot_defender_limit_for_team(param_00)
{
	var_01 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team(param_00);
	return var_01 - ctf_bot_attacker_limit_for_team(param_00);
}

//Function Number: 12
get_allied_attackers_for_team(param_00)
{
	return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_attackers_for_team(param_00,level.capzones[param_00].curorigin,get_flag_protect_radius());
}

//Function Number: 13
get_allied_defenders_for_team(param_00)
{
	return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_defenders_for_team(param_00,level.capzones[param_00].curorigin,get_flag_protect_radius());
}

//Function Number: 14
bot_ctf_ai_director_update()
{
	level notify("bot_ctf_ai_director_update");
	level endon("bot_ctf_ai_director_update");
	level endon("game_ended");
	thread maps\mp\bots\_bots_gametype_common::bot_gametype_attacker_defender_ai_director_update();
}

//Function Number: 15
bot_ctf_get_node_chance(param_00)
{
	if(param_00 == self.node_closest_to_defend_center)
	{
		return 1;
	}

	if(!is_protecting_flag())
	{
		return 1;
	}

	var_01 = param_00 maps\mp\bots\_bots_util::node_is_on_path_from_labels("flag_allies","flag_axis");
	if(var_01)
	{
		return 1;
	}

	return 0.2;
}

//Function Number: 16
bot_ctf_flag_is_home_of_team(param_00)
{
	return level.teamflags[param_00] maps\mp\gametypes\_gameobjects::ishome();
}

//Function Number: 17
bot_ctf_flag_picked_up_of_team(param_00)
{
	return isdefined(level.teamflags[param_00].carrier);
}

//Function Number: 18
bot_ctf_my_team_flag_is_picked_up()
{
	return bot_ctf_flag_picked_up_of_team(self.team);
}

//Function Number: 19
bot_ctf_enemy_team_flag_is_picked_up()
{
	return bot_ctf_flag_picked_up_of_team(level.otherteam[self.team]);
}

//Function Number: 20
bot_ctf_player_has_flag()
{
	return isdefined(self.carryflag);
}

//Function Number: 21
bot_ctf_can_switch_to_defender()
{
	if(bot_ctf_player_has_flag())
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
bot_ctf_player_always_attacker()
{
	if(bot_ctf_player_has_flag())
	{
		return 1;
	}

	return 0;
}