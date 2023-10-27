/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_ball.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 317 ms
 * Timestamp: 10/27/2023 2:37:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	setup_bot_ball();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_ball_think;
	level.bot_funcs["crate_can_use"] = ::crate_can_use;
}

//Function Number: 3
setup_bot_ball()
{
	level.bot_gametype_attacker_limit_for_team = ::bot_ball_attacker_limit_for_team;
	level.bot_gametype_defender_limit_for_team = ::bot_ball_defender_limit_for_team;
	level.bot_gametype_allied_attackers_for_team = ::get_allied_attackers_for_team;
	level.bot_gametype_allied_defenders_for_team = ::get_allied_defenders_for_team;
	maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
	while(!isdefined(level.ball_goals))
	{
		wait(0.05);
	}

	level.ball_goals["allies"].script_label = "allies";
	level.ball_goals["axis"].script_label = "axis";
	bot_setup_ball_jump_nodes();
	var_00 = getzonenearest(level.ball_goals["allies"].origin);
	if(isdefined(var_00))
	{
		botzonesetteam(var_00,"allies");
	}

	var_00 = getzonenearest(level.ball_goals["axis"].origin);
	if(isdefined(var_00))
	{
		botzonesetteam(var_00,"axis");
	}

	foreach(var_02 in level.balls)
	{
		var_02 thread monitor_ball();
	}

	var_04 = 0;
	thread maps\mp\bots\_bots_gametype_common::bot_gametype_attacker_defender_ai_director_update();
	level.bot_gametype_precaching_done = 1;
}

//Function Number: 4
monitor_ball()
{
	var_00 = self.visuals[0].origin;
	self.nearest_node = getclosestnodeinsight(var_00);
	for(;;)
	{
		var_01 = self.visuals[0].origin;
		self.ball_at_rest = maps\mp\bots\_bots_util::bot_vectors_are_equal(var_00,var_01);
		if(!self.ball_at_rest)
		{
			var_02 = getclosestnodeinsight(var_01);
			if(!isdefined(var_02))
			{
				var_03 = getnodesinradiussorted(var_01,512,0,6000);
				if(var_03.size > 0)
				{
					var_02 = var_03[0];
				}
			}

			if(isdefined(var_02))
			{
				self.nearest_node = var_02;
			}
		}

		var_00 = var_01;
		wait(0.2);
	}
}

//Function Number: 5
bot_setup_ball_jump_nodes()
{
	wait(1);
	var_00 = 0;
	var_01 = 10;
	foreach(var_03 in level.ball_goals)
	{
		var_03.ball_jump_nodes = [];
		var_04 = getnodesinradius(var_03.origin,375,0);
		foreach(var_06 in var_04)
		{
			if(var_06.type == "End")
			{
				continue;
			}

			var_00++;
			if(bot_ball_origin_can_see_goal(var_06.origin,var_03,1))
			{
				var_03.ball_jump_nodes[var_03.ball_jump_nodes.size] = var_06;
			}

			if(var_00 % var_01 == 0)
			{
				wait(0.05);
			}
		}

		var_08 = 999999999;
		foreach(var_06 in var_03.ball_jump_nodes)
		{
			var_0A = distance2dsquared(var_06.origin,var_03.origin);
			if(var_0A < var_08)
			{
				var_03.nearest_node = var_06;
				var_08 = var_0A;
			}
		}

		wait(0.05);
	}
}

//Function Number: 6
bot_ball_origin_can_see_goal(param_00,param_01,param_02)
{
	var_03 = bot_ball_trace_to_origin(param_00,param_01.origin);
	if(isdefined(param_02) && param_02)
	{
		if(!var_03)
		{
			var_04 = param_01.origin - (0,0,param_01.radius * 0.5);
			var_03 = bot_ball_trace_to_origin(param_00,var_04);
		}

		if(!var_03)
		{
			var_04 = param_01.origin + (0,0,param_01.radius * 0.5);
			var_03 = bot_ball_trace_to_origin(param_00,var_04);
		}
	}

	return var_03;
}

//Function Number: 7
bot_ball_trace_to_origin(param_00,param_01)
{
	if(isdefined(self) && isplayer(self) || isagent(self))
	{
		var_02 = playerphysicstrace(param_00,param_01,self);
	}
	else
	{
		var_02 = playerphysicstrace(param_01,var_02);
	}

	return distancesquared(var_02,param_01) < 1;
}

//Function Number: 8
crate_can_use(param_00)
{
	if(isagent(self) && !isdefined(param_00.boxtype))
	{
		return 0;
	}

	if(has_ball())
	{
		return 0;
	}

	return 1;
}

//Function Number: 9
bot_ball_think()
{
	self notify("bot_ball_think");
	self endon("bot_ball_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	while(!isdefined(level.bot_gametype_precaching_done))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	var_00 = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
	var_01 = 0;
	self.last_pass_throw_check = 0;
	self.ball_can_pass_ally = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
	self.ball_can_pass_enemy = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
	self.ball_can_throw = randomint(100) < self botgetdifficultysetting("strategyLevel") * 25;
	var_02 = level.ball_goals[self.team];
	var_03 = level.ball_goals[common_scripts\utility::get_enemy_team(self.team)];
	childthread watch_ball_pickup_and_loss();
	for(;;)
	{
		var_04 = !isdefined(self.role);
		if(var_04)
		{
			maps\mp\bots\_bots_gametype_common::bot_gametype_initialize_attacker_defender_role();
		}

		self botsetflag("force_sprint",0);
		var_05 = bot_ball_get_balls_carried_by_team(self.team);
		var_06 = bot_ball_get_balls_carried_by_team(common_scripts\utility::get_enemy_team(self.team));
		foreach(var_08 in var_06)
		{
			var_09 = var_08 bot_ball_get_origin() - (0,0,75);
			self botgetimperfectenemyinfo(var_08.carrier,var_09);
		}

		if(has_ball())
		{
			self botsetflag("force_sprint",1);
			var_0B = distancesquared(self.origin,var_03.nearest_node.origin);
			if(var_0B > 360000)
			{
				var_0C = var_03.nearest_node;
				var_0D = 600;
			}
			else
			{
				var_0C = common_scripts\utility::get_array_of_closest(self.origin,var_05.ball_jump_nodes)[0];
				var_0D = 16;
			}

			clear_defend_or_goal_if_necessary();
			self botsetscriptgoal(var_0C.origin,var_0D,"critical");
			var_0E = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined,"bot_no_longer_has_ball");
			if(var_0E == "goal" && distancesquared(self.origin,var_0C.origin) <= 256)
			{
				self botclearscriptgoal();
				var_0F = vectornormalize(var_03.origin - self geteye());
				if(vectordot(var_0F,(0,0,1)) < 0.93)
				{
					self botlookatpoint(var_03.origin,5,"script_forced");
				}

				var_10 = 0;
				var_11 = 0;
				var_12 = self.origin[2];
				while(var_10 < 4 && has_ball())
				{
					self botsetscriptmove(vectortoyaw(var_03.origin - self.origin),0.05);
					if(var_10 == 0.3 || var_10 == 0.75)
					{
						self botpressbutton("jump");
					}

					var_13 = var_10 > 1.25 && self.origin[2] < var_12;
					var_12 = self.origin[2];
					if(!var_11)
					{
						var_14 = abs(self.origin[2] - var_03.origin[2]);
						var_15 = distance2d(self.origin,var_03.origin);
						if(var_14 < 10 || var_13 && var_15 > 200)
						{
							self botpressbutton("sprint");
							var_11 = 1;
						}
					}

					wait(0.05);
					var_10 = var_10 + 0.05;
					if(!has_ball() || var_10 > 0.75 && self isonground())
					{
						var_10 = 5;
					}
				}

				self botlookatpoint(undefined);
			}

			self botclearscriptgoal();
		}
		else if(self.role == "attacker")
		{
			var_16 = bot_ball_get_free_balls();
			if(var_16.size <= 0)
			{
				if(var_06.size > 0)
				{
					var_17 = bot_ball_get_closest_ball(var_06);
					var_18 = var_17 bot_ball_get_origin() - (0,0,75);
					if(var_00)
					{
						if(gettime() > var_01)
						{
							var_01 = gettime() + 5000;
							var_19 = undefined;
							var_1A = getnodesonpath(var_18,var_02.nearest_node.origin);
							if(isdefined(var_1A) && var_1A.size > 0)
							{
								var_19 = var_1A[int(var_1A.size * randomfloatrange(0.25,0.75))].origin;
							}

							clear_defend_or_goal_if_necessary();
							if(isdefined(var_19) && maps\mp\bots\_bots_personality::find_ambush_node(var_19,512))
							{
								self botsetscriptgoalnode(self.node_ambushing_from,"guard",self.ambush_yaw);
							}
							else
							{
								self botsetscriptgoal(var_18,16,"guard");
							}
						}
					}
					else
					{
						clear_defend_or_goal_if_necessary();
						self botsetscriptgoal(var_18,16,"guard");
					}
				}
				else if(var_05.size > 0)
				{
					if(!maps\mp\bots\_bots_util::bot_is_bodyguarding())
					{
						var_1B = bot_ball_get_closest_ball(var_05);
						clear_defend_or_goal_if_necessary();
						maps\mp\bots\_bots_strategy::bot_guard_player(var_1B.carrier,500);
					}
				}
				else if(maps\mp\_utility::isjuggernaut())
				{
					maps\mp\bots\_bots_personality::update_personality_default();
				}
				else
				{
					var_1C = common_scripts\utility::get_array_of_closest(self.origin,level.ball_starts);
					clear_defend_or_goal_if_necessary();
					self botsetscriptgoal(var_1C[0].origin,16,"guard");
				}
			}
			else if(maps\mp\_utility::isjuggernaut())
			{
				maps\mp\bots\_bots_personality::update_personality_default();
			}
			else
			{
				var_1D = bot_ball_get_closest_ball(var_16);
				clear_defend_or_goal_if_necessary("objective");
				if(var_1D.ball_at_rest)
				{
					var_1E = var_1D bot_ball_get_origin();
					if(!self bothasscriptgoal() || !maps\mp\bots\_bots_util::bot_vectors_are_equal(var_1E,self botgetscriptgoal()))
					{
						self botsetscriptgoal(var_1E,16,"objective",undefined,180);
					}
				}
				else
				{
					self botsetscriptgoal(var_1D.nearest_node.origin,16,"objective",undefined,180);
				}
			}
		}
		else
		{
			var_1F = undefined;
			var_16 = bot_ball_get_free_balls();
			foreach(var_08 in var_16)
			{
				var_21 = distance2dsquared(var_08 bot_ball_get_origin(),var_02.origin);
				if(var_21 < squared(get_ball_goal_protect_radius()))
				{
					var_1F = var_08;
					break;
				}
			}

			if(isdefined(var_1F) && !maps\mp\_utility::isjuggernaut())
			{
				clear_defend_or_goal_if_necessary();
				if(var_1F.ball_at_rest)
				{
					self botsetscriptgoal(var_1F bot_ball_get_origin(),16,"guard");
				}
				else
				{
					self botsetscriptgoal(var_1F.nearest_node.origin,16,"guard");
				}

				maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(1);
			}
			else if(!maps\mp\bots\_bots_util::bot_is_protecting())
			{
				self botclearscriptgoal();
				var_23["score_flags"] = "strict_los";
				var_23["override_origin_node"] = var_02.nearest_node;
				maps\mp\bots\_bots_strategy::bot_protect_point(var_02.nearest_node.origin,get_ball_goal_protect_radius(),var_23);
			}
		}

		wait(0.05);
	}
}

//Function Number: 10
watch_ball_pickup_and_loss()
{
	var_00 = 0;
	for(;;)
	{
		if(has_ball() && !var_00)
		{
			childthread monitor_pass_throw();
			var_00 = 1;
			self botsetflag("melee_critical_path",1);
		}
		else if(!has_ball() && var_00)
		{
			self notify("bot_no_longer_has_ball");
			var_00 = 0;
			self botsetflag("melee_critical_path",0);
		}

		wait(0.05);
	}
}

//Function Number: 11
monitor_pass_throw()
{
	self endon("bot_no_longer_has_ball");
	var_00 = level.ball_goals[self.team];
	var_01 = level.ball_goals[common_scripts\utility::get_enemy_team(self.team)];
	for(;;)
	{
		if(self.ball_can_pass_ally)
		{
			if(isdefined(self.pass_target))
			{
				var_02 = 1;
				if(var_02)
				{
					var_03 = distancesquared(self.origin,var_01.origin);
					var_04 = distancesquared(self.pass_target.origin,var_01.origin);
					if(var_04 <= var_03)
					{
						var_05 = anglestoforward(self getplayerangles());
						var_06 = vectornormalize(self.pass_target.origin - self.origin);
						var_07 = vectordot(var_05,var_06);
						if(var_07 > 0.7)
						{
							self botlookatpoint(self.pass_target.origin + (0,0,40),1.25,"script_forced");
							wait(0.25);
							self botpressbutton("throw");
							wait(1);
						}
					}
				}
			}
		}

		if(self.ball_can_pass_enemy)
		{
			if(isdefined(self.enemy) && isalive(self.enemy) && self botcanseeentity(self.enemy))
			{
				var_08 = 1;
				if(var_08)
				{
					var_09 = distancesquared(self.origin,var_00.origin);
					var_0A = var_09 < squared(get_ball_goal_protect_radius());
					if(!var_0A && distancesquared(self.origin,self.enemy.origin) < squared(350))
					{
						var_0B = anglestoforward(self.enemy getplayerangles());
						var_0C = vectornormalize(self.origin - self.enemy.origin);
						var_07 = vectordot(var_0B,var_0C);
						if(var_07 > 0.5)
						{
							var_05 = anglestoforward(self getplayerangles());
							var_0D = -1 * var_0C;
							var_07 = vectordot(var_05,var_0D);
							if(var_07 > 0.77)
							{
								self botlookatpoint(self.enemy.origin + (0,0,40),1.25,"script_forced");
								wait(0.25);
								self botpressbutton("attack");
								wait(1);
							}
						}
					}
				}
			}
		}

		if(self.ball_can_throw)
		{
			if(self.health < 100 && bot_ball_origin_can_see_goal(self.origin,var_01))
			{
				self botlookatpoint(var_01.origin,1.25,"script_forced");
				wait(0.25);
				self botpressbutton("attack");
				wait(1);
			}
			else if(self.role == "defender")
			{
				var_09 = distancesquared(self.origin,var_00.origin);
				if(var_09 < squared(get_ball_goal_protect_radius()))
				{
					var_0E = anglestoforward(self getplayerangles() * (0,1,1) + (-30,0,0));
					self botlookatpoint(self geteye() + var_0E * 200,1.25,"script_forced");
					wait(0.25);
					self botpressbutton("attack");
					wait(1);
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 12
ball_carrier_is_almost_visible(param_00)
{
	var_01 = self getnearestnode();
	var_02 = param_00 getnearestnode();
	if(isdefined(var_01) && isdefined(var_02))
	{
		if(nodesvisible(var_01,var_02,1))
		{
			return var_02;
		}

		var_03 = getlinkednodes(var_02);
		foreach(var_05 in var_03)
		{
			if(nodesvisible(var_01,var_05,1))
			{
				return var_05;
			}
		}
	}

	return undefined;
}

//Function Number: 13
bot_ball_is_resetting()
{
	return self.compassicons["friendly"] == "waypoint_ball_download" || self.compassicons["friendly"] == "waypoint_ball_upload";
}

//Function Number: 14
bot_ball_get_closest_ball(param_00)
{
	if(param_00.size == 1)
	{
		return param_00[0];
	}

	var_01 = 99999999;
	var_02 = undefined;
	foreach(var_04 in param_00)
	{
		var_05 = distancesquared(self.origin,var_04 bot_ball_get_origin());
		if(var_05 < var_01)
		{
			var_01 = var_05;
			var_02 = var_04;
		}
	}

	return var_02;
}

//Function Number: 15
bot_ball_get_origin()
{
	if(isdefined(self.carrier))
	{
		return self.curorigin;
	}

	return self.visuals[0].origin;
}

//Function Number: 16
clear_defend_or_goal_if_necessary(param_00)
{
	if(maps\mp\bots\_bots_util::bot_is_defending())
	{
		maps\mp\bots\_bots_strategy::bot_defend_stop();
	}

	if(self botgetscriptgoaltype() == "objective")
	{
		var_01 = isdefined(param_00) && param_00 == "objective";
		if(!var_01)
		{
			self botclearscriptgoal();
		}
	}
}

//Function Number: 17
has_ball()
{
	return isdefined(self.ball_carried);
}

//Function Number: 18
bot_ball_get_free_balls()
{
	var_00 = [];
	foreach(var_02 in level.balls)
	{
		if(var_02 bot_ball_is_resetting())
		{
			continue;
		}

		if(!isdefined(var_02.carrier))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 19
bot_ball_get_balls_carried_by_team(param_00)
{
	var_01 = [];
	foreach(var_03 in level.balls)
	{
		if(var_03 bot_ball_is_resetting())
		{
			continue;
		}

		if(isdefined(var_03.carrier) && var_03.carrier.team == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 20
bot_ball_attacker_limit_for_team(param_00)
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

	return var_07;
}

//Function Number: 21
bot_ball_defender_limit_for_team(param_00)
{
	var_01 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team(param_00);
	return var_01 - bot_ball_attacker_limit_for_team(param_00);
}

//Function Number: 22
get_ball_goal_protect_radius()
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

//Function Number: 23
get_allied_attackers_for_team(param_00)
{
	return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_attackers_for_team(param_00,level.ball_goals[param_00].origin,get_ball_goal_protect_radius());
}

//Function Number: 24
get_allied_defenders_for_team(param_00)
{
	return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_defenders_for_team(param_00,level.ball_goals[param_00].origin,get_ball_goal_protect_radius());
}