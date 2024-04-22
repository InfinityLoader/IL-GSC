/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\bots\_bots_gametype_ctf.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 224 ms
 * Timestamp: 4/22/2024 2:08:36 AM
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

	if(isdefined(self.carryflag))
	{
		return 0;
	}

	return level.teamflags[self.team] maps\mp\gametypes\_gameobjects::ishome();
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

	self.next_time_hunt_carrier = 0;
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

		var_02 = 0;
		if(self.role == "attacker")
		{
			if(isdefined(self.carryflag))
			{
				var_02 = 1;
			}
			else if(!isdefined(level.flag_carriers[self.team]))
			{
				var_02 = distancesquared(self.origin,level.teamflags[level.otherteam[self.team]].curorigin) < squared(get_flag_protect_radius());
			}
		}
		else if(!level.teamflags[self.team] maps\mp\gametypes\_gameobjects::ishome())
		{
			var_02 = !isdefined(level.flag_carriers[level.otherteam[self.team]]);
		}

		self botsetflag("force_sprint",var_02);
		var_01 = 0;
		if(isdefined(self.carryflag))
		{
			clear_defend();
			if(!isdefined(level.flag_carriers[level.otherteam[self.team]]))
			{
				var_01 = 1;
				if(!var_00)
				{
					var_00 = 1;
					self botsetpathingstyle("scripted");
				}

				self botsetscriptgoal(level.capzones[self.team].curorigin,16,"critical");
			}
			else if(gettime() > self.next_flag_hide_time)
			{
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
			if(isdefined(level.flag_carriers[self.team]))
			{
				if(!maps\mp\bots\_bots_util::bot_is_bodyguarding())
				{
					clear_defend();
					self botclearscriptgoal();
					maps\mp\bots\_bots_strategy::bot_guard_player(level.flag_carriers[self.team],500);
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
		else if(!level.teamflags[self.team] maps\mp\gametypes\_gameobjects::ishome())
		{
			if(!isdefined(level.flag_carriers[level.otherteam[self.team]]))
			{
				clear_defend();
				self botsetscriptgoal(level.teamflags[self.team].curorigin,16,"critical");
			}
			else
			{
				var_06 = level.flag_carriers[level.otherteam[self.team]];
				if(gettime() > self.next_time_hunt_carrier || self botcanseeentity(var_06))
				{
					clear_defend();
					self botsetscriptgoal(var_06.origin,16,"critical");
					self.next_time_hunt_carrier = gettime() + randomintrange(4500,5500);
				}
			}
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
clear_defend()
{
	if(maps\mp\bots\_bots_util::bot_is_defending())
	{
		maps\mp\bots\_bots_strategy::bot_defend_stop();
	}
}

//Function Number: 7
is_protecting_flag()
{
	return maps\mp\bots\_bots_util::bot_is_protecting();
}

//Function Number: 8
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

//Function Number: 9
ctf_bot_attacker_limit_for_team(param_00)
{
	var_01 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team(param_00);
	var_02 = var_01 * 0.67;
	var_03 = floor(var_02);
	var_04 = ceil(var_02);
	var_05 = var_02 - var_03;
	var_06 = var_04 - var_02;
	if(var_05 < var_06)
	{
		var_07 = int(var_03);
	}
	else
	{
		var_07 = int(var_05);
	}

	var_08 = game["teamScores"][param_00];
	var_09 = game["teamScores"][common_scripts\utility::get_enemy_team(param_00)];
	if(var_08 + 1 < var_09)
	{
		var_07 = int(min(var_07 + 1,var_01));
	}

	return var_07;
}

//Function Number: 10
ctf_bot_defender_limit_for_team(param_00)
{
	var_01 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team(param_00);
	return var_01 - ctf_bot_attacker_limit_for_team(param_00);
}

//Function Number: 11
get_allied_attackers_for_team(param_00)
{
	return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_attackers_for_team(param_00,level.capzones[param_00].curorigin,get_flag_protect_radius());
}

//Function Number: 12
get_allied_defenders_for_team(param_00)
{
	return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_defenders_for_team(param_00,level.capzones[param_00].curorigin,get_flag_protect_radius());
}

//Function Number: 13
bot_ctf_ai_director_update()
{
	level notify("bot_ctf_ai_director_update");
	level endon("bot_ctf_ai_director_update");
	level endon("game_ended");
	level.flag_carriers = [];
	thread maps\mp\bots\_bots_gametype_common::bot_gametype_attacker_defender_ai_director_update();
	for(;;)
	{
		level.flag_carriers["allies"] = undefined;
		level.flag_carriers["axis"] = undefined;
		foreach(var_01 in level.participants)
		{
			if(isalive(var_01) && isdefined(var_01.carryflag))
			{
				level.flag_carriers[var_01.team] = var_01;
			}
		}

		wait(0.05);
	}
}

//Function Number: 14
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