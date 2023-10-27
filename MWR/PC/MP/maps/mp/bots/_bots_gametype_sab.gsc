/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_sab.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 233 ms
 * Timestamp: 10/27/2023 2:37:20 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	bot_sab_start();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_sab_think;
	level.bot_funcs["notify_enemy_bots_bomb_used"] = ::notify_enemy_team_bomb_used;
}

//Function Number: 3
bot_sab_start()
{
	if(maps\mp\_utility::is_true(game["tiebreaker"]))
	{
		maps\mp\bots\_bots_gametype_war::main();
		return;
	}

	setup_bot_sab();
}

//Function Number: 4
setup_bot_sab()
{
	maps\mp\bots\_bots_gametype_common::bot_setup_bombzone_bottargets();
	maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
	var_00 = maps\mp\bots\_bots_gametype_common::bot_verify_and_cache_bombzones(["_allies","_axis"]);
	if(var_00)
	{
		foreach(var_02 in level.bombzones)
		{
			var_02 thread maps\mp\bots\_bots_gametype_common::monitor_bombzone_control();
		}

		level.protect_radius = 600;
		level.bot_gametype_precaching_done = 1;
	}
}

//Function Number: 5
bot_sab_think()
{
	self notify("bot_sab_think");
	self endon("bot_sab_think");
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
	var_00 = undefined;
	var_01 = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
	var_02 = (0,0,0);
	self.defuser_bad_path_counter = 0;
	for(;;)
	{
		wait(0.05);
		if(!level.bombplanted)
		{
			var_03 = bot_sab_get_bomb_carrier();
			if(!isdefined(var_03) || var_03.team == self.team)
			{
				var_00 = undefined;
			}

			if(!isdefined(var_03))
			{
				if(maps\mp\bots\_bots_util::bot_is_defending())
				{
					maps\mp\bots\_bots_strategy::bot_defend_stop();
				}

				self botsetscriptgoal(level.sabbomb.curorigin,16,"critical");
			}
			else if(var_03 == self)
			{
				var_04 = level.bombzones[common_scripts\utility::get_enemy_team(self.team)];
				clear_non_tactical_goal();
				plant_bomb(var_04);
			}
			else if(var_03.team == self.team)
			{
				if(!maps\mp\bots\_bots_util::bot_is_guarding_player(var_03))
				{
					clear_non_tactical_goal();
					maps\mp\bots\_bots_strategy::bot_guard_player(var_03,400);
				}
			}
			else if(gettime() > level.sabbomb.lastclaimtime)
			{
				var_05 = level.bombzones[self.team];
				if(!isdefined(var_00))
				{
					var_06 = distance(self.origin,level.sabbomb.curorigin);
					var_07 = distance(self.origin,var_05.curorigin);
					if(randomfloat(1) < 0.75 || var_06 < var_07)
					{
						var_00 = "hunt_carrier";
					}
					else
					{
						var_00 = "defend_zone";
					}

					if(maps\mp\bots\_bots_util::bot_is_defending())
					{
						maps\mp\bots\_bots_strategy::bot_defend_stop();
					}

					clear_non_tactical_goal();
				}

				if(var_00 == "hunt_carrier")
				{
					if(!maps\mp\bots\_bots_util::bot_vectors_are_equal(var_02,level.sabbomb.curorigin))
					{
						var_02 = level.sabbomb.curorigin;
						var_08 = var_02 - (0,0,75);
						var_09 = var_01 && distance(var_08,var_05.curorigin) > level.protect_radius;
						if(var_09)
						{
							var_0A = undefined;
							var_0B = getnodesonpath(var_08,common_scripts\utility::random(var_05.bottargets).origin);
							if(isdefined(var_0B) && var_0B.size > 0)
							{
								var_0A = var_0B[int(var_0B.size * randomfloatrange(0.25,0.75))].origin;
							}

							if(isdefined(var_0A) && maps\mp\bots\_bots_personality::find_ambush_node(var_0A,512))
							{
								self botsetscriptgoalnode(self.node_ambushing_from,"guard",self.ambush_yaw);
							}
							else
							{
								var_09 = 0;
							}
						}

						if(!var_09)
						{
							self botsetscriptgoal(var_08,32,"guard");
						}
					}
				}
				else if(var_00 == "defend_zone")
				{
					if(!bot_is_protecting_point(var_05.curorigin))
					{
						var_0C["score_flags"] = "strict_los";
						var_0C["override_origin_node"] = common_scripts\utility::random(var_05.bottargets);
						maps\mp\bots\_bots_strategy::bot_protect_point(var_05.curorigin,level.protect_radius,var_0C);
					}
				}
			}

			continue;
		}

		var_0D = bot_sab_get_zone_planted_on();
		if(var_0D.ownerteam != self.team)
		{
			if(!bot_is_protecting_point(level.sabbomb.curorigin))
			{
				var_0C["score_flags"] = "strongly_avoid_center";
				maps\mp\bots\_bots_strategy::bot_protect_point(level.sabbomb.curorigin,level.protect_radius,var_0C);
			}
		}
		else
		{
			var_0E = bot_sab_get_bomb_defuser();
			if(!isdefined(var_0E))
			{
				self.role = "defuser";
			}
			else if(isai(var_0E))
			{
				var_0F = distance(self.origin,var_0D.curorigin);
				var_10 = distance(var_0E.origin,var_0D.curorigin);
				if(var_0F < var_10 * 0.9)
				{
					self.role = "defuser";
					var_0E bot_sab_clear_role();
				}
			}

			if(isdefined(self.role) && self.role == "defuser")
			{
				defuse_bomb(var_0D);
			}
			else if(!bot_is_protecting_point(var_0D.curorigin))
			{
				var_0C["min_goal_time"] = 2;
				var_0C["max_goal_time"] = 4;
				var_0C["override_origin_node"] = common_scripts\utility::random(var_0D.bottargets);
				maps\mp\bots\_bots_strategy::bot_protect_point(var_0D.curorigin,level.protect_radius,var_0C);
			}
		}
	}
}

//Function Number: 6
get_round_end_time()
{
	if(level.bombplanted)
	{
		return level.defuseendtime;
	}

	return gettime() + maps\mp\gametypes\_gamelogic::gettimeremaining();
}

//Function Number: 7
clear_non_tactical_goal()
{
	if(self botgetscriptgoaltype() != "tactical")
	{
		self botclearscriptgoal();
	}
}

//Function Number: 8
plant_bomb(param_00)
{
	self endon("change_role");
	var_01 = maps\mp\bots\_bots_gametype_common::get_bombzone_node_to_plant_on(param_00,0);
	self botsetscriptgoal(var_01.origin,0,"critical");
	var_02 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined,"change_role");
	if(var_02 == "goal")
	{
		var_03 = get_round_end_time() - gettime();
		var_04 = var_03 - level.planttime * 2 * 1000;
		var_05 = gettime() + var_04;
		if(var_04 > 0)
		{
			maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time(var_04);
		}

		var_06 = var_05 > 0 && gettime() >= var_05;
		var_07 = maps\mp\bots\_bots_gametype_common::bombzone_press_use(level.planttime + 2,"bomb_planted",var_06);
		clear_non_tactical_goal();
	}
}

//Function Number: 9
defuse_bomb(param_00)
{
	self endon("change_role");
	self botsetpathingstyle("scripted");
	var_01 = maps\mp\bots\_bots_gametype_common::get_bombzone_node_to_defuse_on(param_00).origin;
	self botsetscriptgoal(var_01,20,"critical");
	var_02 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined,"change_role");
	if(var_02 == "bad_path")
	{
		self.defuser_bad_path_counter++;
		if(self.defuser_bad_path_counter >= 4)
		{
			for(;;)
			{
				var_03 = getnodesinradiussorted(var_01,50,0);
				var_04 = self.defuser_bad_path_counter - 4;
				if(var_03.size <= var_04)
				{
					var_05 = botgetclosestnavigablepoint(var_01,50,self);
					if(isdefined(var_05))
					{
						self botsetscriptgoal(var_05,20,"critical");
					}
					else
					{
						break;
					}
				}
				else
				{
					self botsetscriptgoal(var_03[var_04].origin,20,"critical");
				}

				var_02 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined,"change_role");
				if(var_02 == "bad_path")
				{
					self.defuser_bad_path_counter++;
					continue;
				}

				break;
			}
		}
	}

	if(var_02 == "goal")
	{
		var_06 = get_round_end_time() - gettime();
		var_07 = var_06 - level.defusetime * 2 * 1000;
		var_08 = gettime() + var_07;
		if(var_07 > 0)
		{
			maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time(var_07);
		}

		var_09 = var_08 > 0 && gettime() >= var_08;
		var_0A = maps\mp\bots\_bots_gametype_common::bombzone_press_use(level.defusetime + 2,"bomb_defused",var_09);
		if(!var_0A && self.defuser_bad_path_counter >= 4)
		{
			self.defuser_bad_path_counter++;
		}

		clear_non_tactical_goal();
		if(var_0A)
		{
			bot_sab_clear_role();
		}
	}
}

//Function Number: 10
bot_sab_clear_role()
{
	self.role = undefined;
	clear_non_tactical_goal();
	self botsetpathingstyle(undefined);
	maps\mp\bots\_bots_strategy::bot_defend_stop();
	self notify("change_role");
	self.defuser_bad_path_counter = 0;
}

//Function Number: 11
bot_is_protecting_point(param_00)
{
	return maps\mp\bots\_bots_util::bot_is_protecting() && maps\mp\bots\_bots_util::bot_is_defending_point(param_00);
}

//Function Number: 12
bot_sab_get_bomb_carrier()
{
	foreach(var_01 in level.players)
	{
		if(maps\mp\_utility::isreallyalive(var_01) && maps\mp\_utility::is_true(var_01.isbombcarrier))
		{
			return var_01;
		}
	}
}

//Function Number: 13
bot_sab_get_bomb_defuser()
{
	foreach(var_01 in level.players)
	{
		if(maps\mp\_utility::isreallyalive(var_01) && !isai(var_01))
		{
			if(var_01.isdefusing)
			{
				return var_01;
			}
		}
	}

	foreach(var_01 in level.players)
	{
		if(maps\mp\_utility::isreallyalive(var_01) && isai(var_01))
		{
			if(isdefined(var_01.role) && var_01.role == "defuser")
			{
				return var_01;
			}
		}
	}

	return undefined;
}

//Function Number: 14
bot_sab_get_zone_planted_on()
{
	foreach(var_01 in level.bombzones)
	{
		if(var_01.bombplantedon)
		{
			return var_01;
		}
	}
}

//Function Number: 15
notify_enemy_team_bomb_used(param_00)
{
	var_01 = maps\mp\bots\_bots_gametype_common::get_ai_hearing_bomb_plant_sound(param_00);
	var_02 = maps\mp\bots\_bots_gametype_common::find_closest_bombzone_to_player(self);
	foreach(var_04 in var_01)
	{
		var_04 thread investigate_someone_using_bomb(var_02);
	}
}

//Function Number: 16
investigate_someone_using_bomb(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(maps\mp\bots\_bots_util::bot_is_defending())
	{
		maps\mp\bots\_bots_strategy::bot_defend_stop();
	}

	self botsetscriptgoalnode(common_scripts\utility::random(param_00.bottargets),"critical");
	var_01 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();
	if(var_01 == "goal")
	{
		wait(2);
		clear_non_tactical_goal();
	}
}