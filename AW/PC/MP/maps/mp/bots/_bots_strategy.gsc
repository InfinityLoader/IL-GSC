/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_strategy.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 50
 * Decompile Time: 864 ms
 * Timestamp: 10/27/2023 1:41:19 AM
*******************************************************************/

//Function Number: 1
bot_defend_get_random_entrance_point_for_current_area()
{
	var_00 = bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance);
	if(isdefined(var_00) && var_00.size > 0)
	{
		return common_scripts\utility::random(var_00).origin;
	}

	return undefined;
}

//Function Number: 2
bot_defend_get_precalc_entrances_for_current_area(param_00,param_01)
{
	if(isdefined(self.defend_entrance_index))
	{
		return maps\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index(param_00,self.defend_entrance_index,param_01);
	}

	return [];
}

//Function Number: 3
bot_get_ambush_trap_item(param_00,param_01,param_02)
{
	if(self botgetdifficultysetting("allowGrenades") == 0)
	{
		return;
	}

	var_03 = [];
	var_04 = [];
	var_04[var_04.size] = param_00;
	if(isdefined(param_01))
	{
		var_04[var_04.size] = param_01;
	}

	if(isdefined(param_01))
	{
		var_04[var_04.size] = param_02;
	}

	if(var_04.size == 0)
	{
		return;
	}

	var_05 = self botfirstavailablegrenade("lethal");
	var_06 = self botfirstavailablegrenade("tactical");
	var_07 = isdefined(var_05) && self getweaponammoclip(var_05) > 0 || self setweaponammostock(var_05) > 0;
	var_08 = isdefined(var_06) && self getweaponammoclip(var_06) > 0 || self setweaponammostock(var_06) > 0;
	if(!var_07 && !var_08)
	{
		return;
	}

	foreach(var_0A in var_04)
	{
		if(var_07 && maps\mp\bots\_bots_util::bot_grenade_matches_purpose(var_0A,var_05))
		{
			var_03["purpose"] = var_0A;
			var_03["item_action"] = "lethal";
			return var_03;
		}

		if(var_08 && maps\mp\bots\_bots_util::bot_grenade_matches_purpose(var_0A,var_06))
		{
			var_03["purpose"] = var_0A;
			var_03["item_action"] = "tactical";
			return var_03;
		}
	}
}

//Function Number: 4
bot_set_ambush_trap(param_00,param_01,param_02,param_03,param_04)
{
	self notify("bot_set_ambush_trap");
	self endon("bot_set_ambush_trap");
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_05 = undefined;
	if(!isdefined(param_04) && isdefined(param_01) && param_01.size > 0)
	{
		if(!isdefined(param_02))
		{
			return 0;
		}

		var_06 = [];
		var_07 = undefined;
		if(isdefined(param_03))
		{
			var_07 = anglestoforward((0,param_03,0));
		}

		foreach(var_09 in param_01)
		{
			if(!isdefined(var_07))
			{
				var_06[var_06.size] = var_09;
				continue;
			}

			if(distancesquared(var_09.origin,param_02.origin) > 90000)
			{
				if(vectordot(var_07,vectornormalize(var_09.origin - param_02.origin)) < 0.4)
				{
					var_06[var_06.size] = var_09;
				}
			}
		}

		if(var_06.size > 0)
		{
			var_05 = common_scripts\utility::random(var_06);
			var_0B = getnodesinradius(var_05.origin,300,50);
			var_0C = [];
			foreach(var_0E in var_0B)
			{
				if(!isdefined(var_0E.bot_ambush_end))
				{
					var_0C[var_0C.size] = var_0E;
				}
			}

			var_0B = var_0C;
			param_04 = self botnodepick(var_0B,min(var_0B.size,3),"node_trap",param_02,var_05);
		}
	}

	if(isdefined(param_04))
	{
		var_10 = undefined;
		if(param_00["purpose"] == "trap_directional" && isdefined(var_05))
		{
			var_11 = vectortoangles(var_05.origin - param_04.origin);
			var_10 = var_11[1];
		}

		if(self bothasscriptgoal() && self botgetscriptgoaltype() != "critical" && self botgetscriptgoaltype() != "tactical")
		{
			self botclearscriptgoal();
		}

		var_12 = self botsetscriptgoalnode(param_04,"guard",var_10);
		if(var_12)
		{
			var_13 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail();
			if(var_13 == "goal")
			{
				thread maps\mp\bots\_bots_util::bot_force_stance_for_time("stand",5);
				if(!isdefined(self.enemy) || 0 == self botcanseeentity(self.enemy))
				{
					if(isdefined(var_10))
					{
						self botthrowgrenade(var_05.origin,param_00["item_action"]);
					}
					else
					{
						self botthrowgrenade(self.origin + anglestoforward(self.angles) * 50,param_00["item_action"]);
					}

					self.ambush_trap_ent = undefined;
					thread bot_set_ambush_trap_wait_fire("grenade_fire");
					thread bot_set_ambush_trap_wait_fire("missile_fire");
					var_14 = 3;
					if(param_00["purpose"] == "tacticalinsertion")
					{
						var_14 = 6;
					}

					common_scripts\utility::waittill_any_timeout(var_14,"missile_fire","grenade_fire");
					wait(0.05);
					self notify("ambush_trap_ent");
					if(isdefined(self.ambush_trap_ent) && param_00["purpose"] == "c4")
					{
						thread bot_watch_manual_detonate(self.ambush_trap_ent,param_00["item_action"],300);
					}

					self.ambush_trap_ent = undefined;
					wait(randomfloat(0.25));
					self botsetstance("none");
				}
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 5
bot_set_ambush_trap_wait_fire(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("bot_set_ambush_trap");
	self endon("ambush_trap_ent");
	level endon("game_ended");
	self waittill(param_00,var_01);
	self.ambush_trap_ent = var_01;
}

//Function Number: 6
bot_watch_manual_detonate(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	var_03 = param_02 * param_02;
	for(;;)
	{
		if(distancesquared(self.origin,param_00.origin) > var_03)
		{
			var_04 = self getclosestenemysqdist(param_00.origin,1);
			if(var_04 < var_03)
			{
				self botpressbutton(param_01);
				return;
			}
		}

		wait(randomfloatrange(0.25,1));
	}
}

//Function Number: 7
bot_capture_point(param_00,param_01,param_02)
{
	thread bot_defend_think(param_00,param_01,"capture",param_02);
}

//Function Number: 8
bot_capture_zone(param_00,param_01,param_02,param_03)
{
	param_03["capture_trigger"] = param_02;
	thread bot_defend_think(param_00,param_01,"capture_zone",param_03);
}

//Function Number: 9
bot_protect_point(param_00,param_01,param_02)
{
	if(!isdefined(param_02) || !isdefined(param_02["min_goal_time"]))
	{
		param_02["min_goal_time"] = 12;
	}

	if(!isdefined(param_02) || !isdefined(param_02["max_goal_time"]))
	{
		param_02["max_goal_time"] = 18;
	}

	thread bot_defend_think(param_00,param_01,"protect",param_02);
}

//Function Number: 10
bot_patrol_area(param_00,param_01,param_02)
{
	if(!isdefined(param_02) || !isdefined(param_02["min_goal_time"]))
	{
		param_02["min_goal_time"] = 0;
	}

	if(!isdefined(param_02) || !isdefined(param_02["max_goal_time"]))
	{
		param_02["max_goal_time"] = 0.01;
	}

	thread bot_defend_think(param_00,param_01,"patrol",param_02);
}

//Function Number: 11
bot_guard_player(param_00,param_01,param_02)
{
	if(!isdefined(param_02) || !isdefined(param_02["min_goal_time"]))
	{
		param_02["min_goal_time"] = 15;
	}

	if(!isdefined(param_02) || !isdefined(param_02["max_goal_time"]))
	{
		param_02["max_goal_time"] = 20;
	}

	thread bot_defend_think(param_00,param_01,"bodyguard",param_02);
}

//Function Number: 12
bot_defend_think(param_00,param_01,param_02,param_03)
{
	self notify("started_bot_defend_think");
	self endon("started_bot_defend_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("defend_stop");
	thread defense_death_monitor();
	if(isdefined(self.bot_defending) || self botgetscriptgoaltype() == "camp")
	{
		self botclearscriptgoal();
	}

	self.bot_defending = 1;
	self.bot_defending_type = param_02;
	if(param_02 == "capture_zone")
	{
		self.bot_defending_radius = undefined;
		self.bot_defending_nodes = param_01;
		self.bot_defending_trigger = param_03["capture_trigger"];
	}
	else
	{
		self.bot_defending_radius = param_01;
		self.bot_defending_nodes = undefined;
		self.bot_defending_trigger = undefined;
	}

	if(maps\mp\_utility::isgameparticipant(param_00))
	{
		self.bot_defend_player_guarding = param_00;
		childthread monitor_defend_player();
	}
	else
	{
		self.bot_defend_player_guarding = undefined;
		self.bot_defending_center = param_00;
	}

	self botsetstance("none");
	var_04 = undefined;
	var_05 = 6;
	var_06 = 10;
	self.defense_score_flags = [];
	if(isdefined(param_03))
	{
		self.defend_entrance_index = param_03["entrance_points_index"];
		self.bot_defending_override_origin_node = param_03["override_origin_node"];
		if(isdefined(param_03["score_flags"]))
		{
			if(isarray(param_03["score_flags"]))
			{
				self.defense_score_flags = param_03["score_flags"];
			}
			else
			{
				self.defense_score_flags[0] = param_03["score_flags"];
			}
		}

		if(isdefined(param_03["override_goal_type"]))
		{
			var_04 = param_03["override_goal_type"];
		}

		if(isdefined(param_03["min_goal_time"]))
		{
			var_05 = param_03["min_goal_time"];
		}

		if(isdefined(param_03["max_goal_time"]))
		{
			var_06 = param_03["max_goal_time"];
		}

		if(isdefined(param_03["override_entrances"]) && param_03["override_entrances"].size > 0)
		{
			self.defense_override_entrances = param_03["override_entrances"];
			self.defend_entrance_index = self.name + " " + gettime();
			foreach(var_08 in self.defense_override_entrances)
			{
				var_08.prone_visible_from[self.defend_entrance_index] = maps\mp\bots\_bots_util::entrance_visible_from(var_08.origin,maps\mp\bots\_bots_util::defend_valid_center(),"prone");
				wait(0.05);
				var_08.crouch_visible_from[self.defend_entrance_index] = maps\mp\bots\_bots_util::entrance_visible_from(var_08.origin,maps\mp\bots\_bots_util::defend_valid_center(),"crouch");
				wait(0.05);
			}
		}

		self.defend_objective_radius = param_03["objective_radius"];
	}

	if(!isdefined(self.bot_defend_player_guarding))
	{
		var_0A = undefined;
		if(isdefined(param_03) && isdefined(param_03["nearest_node_to_center"]))
		{
			var_0A = param_03["nearest_node_to_center"];
		}

		if(!isdefined(var_0A) && isdefined(self.bot_defending_override_origin_node))
		{
			var_0A = self.bot_defending_override_origin_node;
		}

		if(!isdefined(var_0A) && isdefined(self.bot_defending_trigger) && isdefined(self.bot_defending_trigger.nearest_node))
		{
			var_0A = self.bot_defending_trigger.nearest_node;
		}

		if(!isdefined(var_0A))
		{
			var_0A = getclosestnodeinsight(maps\mp\bots\_bots_util::defend_valid_center());
		}

		if(!isdefined(var_0A))
		{
			var_0B = maps\mp\bots\_bots_util::defend_valid_center();
			var_0C = getnodesinradiussorted(var_0B,256,0);
			for(var_0D = 0;var_0D < var_0C.size;var_0D++)
			{
				var_0E = vectornormalize(var_0C[var_0D].origin - var_0B);
				var_0F = var_0B + var_0E * 15;
				if(sighttracepassed(var_0F,var_0C[var_0D].origin,0,undefined))
				{
					var_0A = var_0C[var_0D];
					break;
				}

				wait(0.05);
				if(sighttracepassed(var_0F + (0,0,55),var_0C[var_0D].origin + (0,0,55),0,undefined))
				{
					var_0A = var_0C[var_0D];
					break;
				}

				wait(0.05);
			}
		}

		self.node_closest_to_defend_center = var_0A;
	}

	var_10 = level.bot_find_defend_node_func[param_02];
	if(!isdefined(var_04))
	{
		var_04 = "guard";
		if(param_02 == "capture" || param_02 == "capture_zone")
		{
			var_04 = "objective";
		}
	}

	var_11 = maps\mp\bots\_bots_util::bot_is_capturing();
	if(param_02 == "protect")
	{
		childthread protect_watch_allies();
	}

	for(;;)
	{
		self.prev_defend_node = self.cur_defend_node;
		self.cur_defend_node = undefined;
		self.cur_defend_angle_override = undefined;
		self.cur_defend_point_override = undefined;
		var_12 = isdefined(param_03["entrance_points_index"]) && isarray(param_03["entrance_points_index"]);
		self.cur_defend_stance = calculate_defend_stance(var_11,var_12);
		var_13 = self botgetscriptgoaltype();
		var_14 = maps\mp\bots\_bots_util::bot_goal_can_override(var_04,var_13);
		if(!var_14)
		{
			wait(0.25);
			continue;
		}

		var_15 = var_05;
		var_16 = var_06;
		var_17 = 1;
		if(isdefined(self.defense_investigate_specific_point))
		{
			self.cur_defend_point_override = self.defense_investigate_specific_point;
			self.defense_investigate_specific_point = undefined;
			var_17 = 0;
			var_15 = 1;
			var_16 = 2;
		}
		else if(isdefined(self.defense_force_next_node_goal))
		{
			self.cur_defend_node = self.defense_force_next_node_goal;
			self.defense_force_next_node_goal = undefined;
		}
		else
		{
			if(isdefined(level.aerial_danger_exists_for) && level.aerial_danger_exists_for[self.team])
			{
				if(!common_scripts\utility::array_contains(self.defense_score_flags,"avoid_aerial_enemies"))
				{
					self.defense_score_flags[self.defense_score_flags.size] = "avoid_aerial_enemies";
				}
			}

			self [[ var_10 ]]();
		}

		self botclearscriptgoal();
		var_18 = "";
		if(isdefined(self.cur_defend_node) || isdefined(self.cur_defend_point_override))
		{
			if(var_17 && maps\mp\bots\_bots_util::bot_is_protecting() && !isplayer(param_00) && isdefined(self.defend_entrance_index))
			{
				var_19 = bot_get_ambush_trap_item("trap_directional","trap","c4");
				if(isdefined(var_19))
				{
					var_1A = maps\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index(undefined,self.defend_entrance_index);
					bot_set_ambush_trap(var_19,var_1A,self.node_closest_to_defend_center);
				}
			}

			if(isdefined(self.cur_defend_point_override))
			{
				var_1B = undefined;
				if(isdefined(self.cur_defend_angle_override))
				{
					var_1B = self.cur_defend_angle_override[1];
				}

				self botsetscriptgoal(self.cur_defend_point_override,0,var_04,var_1B,self.defend_objective_radius);
			}
			else if(!isdefined(self.cur_defend_angle_override))
			{
				self botsetscriptgoalnode(self.cur_defend_node,var_04,undefined,self.defend_objective_radius);
			}
			else
			{
				self botsetscriptgoalnode(self.cur_defend_node,var_04,self.cur_defend_angle_override[1],self.defend_objective_radius);
			}

			if(var_11)
			{
				if(!isdefined(self.prev_defend_node) || !isdefined(self.cur_defend_node) || self.prev_defend_node != self.cur_defend_node)
				{
					self botsetstance("none");
				}
			}

			var_1C = self botgetscriptgoal();
			self notify("new_defend_goal");
			maps\mp\bots\_bots_util::watch_nodes_stop();
			if(var_04 == "objective")
			{
				defense_cautious_approach();
				self botsetawareness(1);
				self botsetflag("cautious",0);
			}

			if(self bothasscriptgoal())
			{
				var_1D = self botgetscriptgoal();
				if(maps\mp\bots\_bots_util::bot_vectors_are_equal(var_1D,var_1C))
				{
					var_18 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(20,"defend_force_node_recalculation");
				}
			}

			if(var_18 == "goal")
			{
				if(var_11)
				{
					self botsetstance(self.cur_defend_stance);
				}

				childthread defense_watch_entrances_at_goal();
				if(var_17 && maps\mp\bots\_bots_util::bot_is_protecting() && !isplayer(param_00) && isdefined(self.defend_entrance_index))
				{
					maps\mp\bots\_bots_personality::bot_try_trap_follower();
				}
			}
		}

		if(var_18 != "goal")
		{
			wait(0.25);
			continue;
		}

		var_1E = randomfloatrange(var_15,var_16);
		var_18 = common_scripts\utility::waittill_any_timeout(var_1E,"node_relinquished","goal_changed","script_goal_changed","defend_force_node_recalculation","bad_path");
		if((var_18 == "node_relinquished" || var_18 == "bad_path" || var_18 == "goal_changed" || var_18 == "script_goal_changed") && self.cur_defend_stance == "crouch" || self.cur_defend_stance == "prone")
		{
			self botsetstance("none");
		}
	}
}

//Function Number: 13
calculate_defend_stance(param_00,param_01)
{
	var_02 = "stand";
	if(param_00)
	{
		var_03 = 100;
		var_04 = 0;
		var_05 = 0;
		var_06 = self botgetdifficultysetting("strategyLevel");
		if(var_06 == 1)
		{
			var_03 = 20;
			var_04 = 25;
			var_05 = 55;
		}
		else if(var_06 >= 2)
		{
			var_03 = 10;
			var_04 = 20;
			var_05 = 70;
		}

		var_07 = randomint(100);
		if(var_07 < var_04)
		{
			var_02 = "crouch";
		}
		else if(var_07 < var_04 + var_05)
		{
			var_02 = "prone";
		}

		var_08 = !isdefined(param_01) || !param_01;
		if(var_08 && var_02 == "prone")
		{
			var_09 = bot_defend_get_precalc_entrances_for_current_area("prone");
			var_0A = defend_get_ally_bots_at_zone_for_stance("prone");
			if(var_0A.size >= var_09.size)
			{
				var_02 = "crouch";
			}
		}

		if(var_08 && var_02 == "crouch")
		{
			var_0B = bot_defend_get_precalc_entrances_for_current_area("crouch");
			var_0C = defend_get_ally_bots_at_zone_for_stance("crouch");
			if(var_0C.size >= var_0B.size)
			{
				var_02 = "stand";
			}
		}
	}

	return var_02;
}

//Function Number: 14
should_start_cautious_approach_default(param_00)
{
	var_01 = 1250;
	var_02 = var_01 * var_01;
	if(param_00)
	{
		if(self botgetdifficultysetting("strategyLevel") == 0)
		{
			return 0;
		}

		if(self.bot_defending_type == "capture_zone" && self istouching(self.bot_defending_trigger))
		{
			return 0;
		}

		return distancesquared(self.origin,self.bot_defending_center) > var_02 * 0.75 * 0.75;
	}

	if(self botpursuingscriptgoal() && distancesquared(self.origin,self.bot_defending_center) < var_02)
	{
		var_03 = self botgetpathdist();
		return 0 <= var_03 && var_03 <= var_01;
	}

	return 0;
}

//Function Number: 15
setup_investigate_location(param_00,param_01)
{
	var_02 = spawnstruct();
	if(isdefined(param_01))
	{
		var_02.origin = param_01;
	}
	else
	{
		var_02.origin = param_00.origin;
	}

	var_02.node = param_00;
	var_02.frames_visible = 0;
	return var_02;
}

//Function Number: 16
defense_cautious_approach()
{
	self notify("defense_cautious_approach");
	self endon("defense_cautious_approach");
	level endon("game_ended");
	self endon("defend_force_node_recalculation");
	self endon("death");
	self endon("disconnect");
	self endon("defend_stop");
	self endon("started_bot_defend_think");
	if(![[ level.bot_funcs["should_start_cautious_approach"] ]](1))
	{
		return;
	}

	var_00 = self botgetscriptgoal();
	var_01 = self botgetscriptgoalnode();
	var_02 = 1;
	var_03 = 0.2;
	while(var_02)
	{
		wait(0.25);
		if(!self bothasscriptgoal())
		{
			return;
		}

		var_04 = self botgetscriptgoal();
		if(!maps\mp\bots\_bots_util::bot_vectors_are_equal(var_00,var_04))
		{
			return;
		}

		var_03 = var_03 + 0.25;
		if(var_03 >= 0.5)
		{
			var_03 = 0;
			if([[ level.bot_funcs["should_start_cautious_approach"] ]](0))
			{
				var_02 = 0;
			}
		}
	}

	self botsetawareness(1.8);
	self botsetflag("cautious",1);
	var_05 = self botgetnodesonpath();
	if(!isdefined(var_05) || var_05.size <= 2)
	{
		return;
	}

	self.locations_to_investigate = [];
	var_06 = 1000;
	if(isdefined(level.protect_radius))
	{
		var_06 = level.protect_radius;
	}

	var_07 = var_06 * var_06;
	var_08 = getnodesinradius(self.bot_defending_center,var_06,0,500);
	if(var_08.size <= 0)
	{
		return;
	}

	var_09 = 5 + self botgetdifficultysetting("strategyLevel") * 2;
	var_0A = int(min(var_09,var_08.size));
	var_0B = self botnodepickmultiple(var_08,15,var_0A,"node_protect",maps\mp\bots\_bots_util::defend_valid_center(),"ignore_occupancy");
	for(var_0C = 0;var_0C < var_0B.size;var_0C++)
	{
		var_0D = setup_investigate_location(var_0B[var_0C]);
		self.locations_to_investigate = common_scripts\utility::array_add(self.locations_to_investigate,var_0D);
	}

	var_0E = botgetmemoryevents(0,gettime() - 60000,1,"death",0,self);
	foreach(var_10 in var_0E)
	{
		if(distancesquared(var_10,self.bot_defending_center) < var_07)
		{
			var_11 = getclosestnodeinsight(var_10);
			if(isdefined(var_11))
			{
				var_0D = setup_investigate_location(var_11,var_10);
				self.locations_to_investigate = common_scripts\utility::array_add(self.locations_to_investigate,var_0D);
			}
		}
	}

	if(isdefined(self.defend_entrance_index))
	{
		var_13 = maps\mp\bots\_bots_util::bot_get_entrances_for_stance_and_index("stand",self.defend_entrance_index);
		for(var_0C = 0;var_0C < var_13.size;var_0C++)
		{
			var_0D = setup_investigate_location(var_13[var_0C]);
			self.locations_to_investigate = common_scripts\utility::array_add(self.locations_to_investigate,var_0D);
		}
	}

	if(self.locations_to_investigate.size == 0)
	{
		return;
	}

	childthread monitor_cautious_approach_dangerous_locations();
	var_14 = self botgetscriptgoaltype();
	var_15 = self botgetscriptgoalradius();
	var_16 = self botgetscriptgoalyaw();
	wait(0.05);
	for(var_17 = 1;var_17 < var_05.size - 2;var_17++)
	{
		maps\mp\bots\_bots_util::bot_waittill_out_of_combat_or_time();
		var_18 = getlinkednodes(var_05[var_17]);
		if(var_18.size == 0)
		{
			continue;
		}

		var_19 = [];
		for(var_0C = 0;var_0C < var_18.size;var_0C++)
		{
			if(!common_scripts\utility::within_fov(self.origin,self.angles,var_18[var_0C].origin,0))
			{
				continue;
			}

			for(var_1A = 0;var_1A < self.locations_to_investigate.size;var_1A++)
			{
				var_10 = self.locations_to_investigate[var_1A];
				if(nodesvisible(var_10.node,var_18[var_0C],1))
				{
					var_19 = common_scripts\utility::array_add(var_19,var_18[var_0C]);
					var_1A = self.locations_to_investigate.size;
				}
			}
		}

		if(var_19.size == 0)
		{
			continue;
		}

		var_1B = self botnodepick(var_19,1 + var_19.size * 0.15,"node_hide");
		if(isdefined(var_1B))
		{
			var_1C = [];
			for(var_0C = 0;var_0C < self.locations_to_investigate.size;var_0C++)
			{
				if(nodesvisible(self.locations_to_investigate[var_0C].node,var_1B,1))
				{
					if(distance2dsquared(self.locations_to_investigate[var_0C].origin,var_1B.origin) > 3600)
					{
						var_1C = common_scripts\utility::array_add(var_1C,self.locations_to_investigate[var_0C]);
					}
				}
			}

			self botclearscriptgoal();
			self botsetscriptgoalnode(var_1B,"critical");
			childthread monitor_cautious_approach_early_out();
			var_1D = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined,"cautious_approach_early_out");
			self notify("stop_cautious_approach_early_out_monitor");
			if(var_1D == "cautious_approach_early_out")
			{
				break;
			}

			if(var_1D == "goal")
			{
				for(var_0C = 0;var_0C < var_1C.size;var_0C++)
				{
					if(distance2dsquared(self.origin,var_1C[var_0C].origin) < 1600)
					{
						continue;
					}

					var_1E = 0;
					while(var_1C[var_0C].frames_visible < 18 && var_1E < 3.6)
					{
						self botlookatpoint(var_1C[var_0C].origin + (0,0,self getplayerviewheight()),0.25,"script_search");
						wait(0.25);
						var_1E = var_1E + 0.25;
					}
				}
			}
		}

		wait(0.05);
	}

	self notify("stop_location_monitoring");
	self botclearscriptgoal();
	if(isdefined(var_01))
	{
		self botsetscriptgoalnode(var_01,var_14,var_16);
		return;
	}

	self botsetscriptgoal(self.cur_defend_point_override,var_15,var_14,var_16);
}

//Function Number: 17
monitor_cautious_approach_early_out()
{
	self endon("cautious_approach_early_out");
	self endon("stop_cautious_approach_early_out_monitor");
	var_00 = undefined;
	if(isdefined(self.bot_defending_radius))
	{
		var_00 = self.bot_defending_radius * self.bot_defending_radius;
	}
	else if(isdefined(self.bot_defending_nodes))
	{
		var_01 = bot_capture_zone_get_furthest_distance();
		var_00 = var_01 * var_01;
	}

	wait(0.05);
	for(;;)
	{
		if(distancesquared(self.origin,self.bot_defending_center) < var_00)
		{
			self notify("cautious_approach_early_out");
		}

		wait(0.05);
	}
}

//Function Number: 18
monitor_cautious_approach_dangerous_locations()
{
	self endon("stop_location_monitoring");
	var_00 = 10000;
	for(;;)
	{
		var_01 = self getnearestnode();
		if(isdefined(var_01))
		{
			var_02 = self botgetfovdot();
			for(var_03 = 0;var_03 < self.locations_to_investigate.size;var_03++)
			{
				if(nodesvisible(var_01,self.locations_to_investigate[var_03].node,1))
				{
					var_04 = common_scripts\utility::within_fov(self.origin,self.angles,self.locations_to_investigate[var_03].origin,var_02);
					var_05 = !var_04 || self.locations_to_investigate[var_03].frames_visible < 17;
					if(var_05 && distancesquared(self.origin,self.locations_to_investigate[var_03].origin) < var_00)
					{
						var_04 = 1;
						self.locations_to_investigate[var_03].frames_visible = 18;
					}

					if(var_04)
					{
						self.locations_to_investigate[var_03].frames_visible++;
						if(self.locations_to_investigate[var_03].frames_visible >= 18)
						{
							self.locations_to_investigate[var_03] = self.locations_to_investigate[self.locations_to_investigate.size - 1];
							self.locations_to_investigate[self.locations_to_investigate.size - 1] = undefined;
							var_03--;
						}
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 19
protect_watch_allies()
{
	self notify("protect_watch_allies");
	self endon("protect_watch_allies");
	var_00 = [];
	var_01 = 1050;
	var_02 = var_01 * var_01;
	var_03 = 900;
	if(isdefined(level.protect_radius))
	{
		var_03 = level.protect_radius;
	}

	for(;;)
	{
		var_04 = gettime();
		var_05 = bot_get_teammates_in_radius(self.bot_defending_center,var_03);
		foreach(var_07 in var_05)
		{
			var_08 = var_07.entity_number;
			if(!isdefined(var_08))
			{
				var_08 = var_07 getentitynumber();
			}

			if(!isdefined(var_00[var_08]))
			{
				var_00[var_08] = var_04 - 1;
			}

			if(!isdefined(var_07.last_investigation_time))
			{
				var_07.last_investigation_time = var_04 - 10001;
			}

			if(var_07.health == 0 && isdefined(var_07.deathtime) && var_04 - var_07.deathtime < 5000)
			{
				if(var_04 - var_07.last_investigation_time > 10000 && var_04 > var_00[var_08])
				{
					if(isdefined(var_07.lastattacker) && isdefined(var_07.lastattacker.team) && var_07.lastattacker.team == common_scripts\utility::get_enemy_team(self.team))
					{
						if(distancesquared(var_07.origin,self.origin) < var_02)
						{
							self botgetimperfectenemyinfo(var_07.lastattacker,var_07.origin);
							var_09 = getclosestnodeinsight(var_07.origin);
							if(isdefined(var_09))
							{
								self.defense_investigate_specific_point = var_09.origin;
								self notify("defend_force_node_recalculation");
							}

							var_07.last_investigation_time = var_04;
						}

						var_00[var_08] = var_04 + 10000;
					}
				}
			}
		}

		wait(randomint(5) + 1 * 0.05);
	}
}

//Function Number: 20
defense_get_initial_entrances()
{
	if(isdefined(self.defense_override_entrances))
	{
		return self.defense_override_entrances;
	}

	if(maps\mp\bots\_bots_util::bot_is_capturing())
	{
		return bot_defend_get_precalc_entrances_for_current_area(self.cur_defend_stance,1);
	}

	if(maps\mp\bots\_bots_util::bot_is_protecting() || maps\mp\bots\_bots_util::bot_is_bodyguarding())
	{
		var_00 = findentrances(self.origin);
		return var_00;
	}
}

//Function Number: 21
defense_watch_entrances_at_goal()
{
	self notify("defense_watch_entrances_at_goal");
	self endon("defense_watch_entrances_at_goal");
	self endon("new_defend_goal");
	self endon("script_goal_changed");
	var_00 = self getnearestnode();
	var_01 = undefined;
	if(maps\mp\bots\_bots_util::bot_is_capturing())
	{
		var_02 = defense_get_initial_entrances();
		var_01 = [];
		if(isdefined(var_00))
		{
			foreach(var_04 in var_02)
			{
				if(nodesvisible(var_00,var_04,1))
				{
					var_01 = common_scripts\utility::array_add(var_01,var_04);
				}
			}
		}

		if(var_01.size == 0)
		{
			var_01 = findentrances(self.origin);
		}
	}
	else if(maps\mp\bots\_bots_util::bot_is_protecting() || maps\mp\bots\_bots_util::bot_is_bodyguarding())
	{
		var_01 = defense_get_initial_entrances();
		if(isdefined(var_00) && !issubstr(self getcurrentweapon(),"riotshield"))
		{
			if(nodesvisible(var_00,self.node_closest_to_defend_center,1))
			{
				var_01 = common_scripts\utility::array_add(var_01,self.node_closest_to_defend_center);
			}
		}
	}

	if(isdefined(var_01))
	{
		childthread maps\mp\bots\_bots_util::bot_watch_nodes(var_01);
		if(maps\mp\bots\_bots_util::bot_is_bodyguarding())
		{
			childthread bot_monitor_watch_entrances_bodyguard();
			return;
		}

		childthread bot_monitor_watch_entrances_at_goal();
	}
}

//Function Number: 22
bot_monitor_watch_entrances_at_goal()
{
	self notify("bot_monitor_watch_entrances_at_goal");
	self endon("bot_monitor_watch_entrances_at_goal");
	self notify("bot_monitor_watch_entrances");
	self endon("bot_monitor_watch_entrances");
	while(!isdefined(self.watch_nodes))
	{
		wait(0.05);
	}

	var_00 = level.bot_funcs["get_watch_node_chance"];
	for(;;)
	{
		var_01 = 0.8;
		var_02 = 1;
		if(common_scripts\utility::array_contains(self.defense_score_flags,"strict_los"))
		{
			var_01 = 1;
			var_02 = 0.5;
		}

		foreach(var_04 in self.watch_nodes)
		{
			if(var_04 == self.node_closest_to_defend_center)
			{
				var_04.watch_node_chance[self.entity_number] = var_01;
				continue;
			}

			var_04.watch_node_chance[self.entity_number] = var_02;
		}

		var_06 = isdefined(var_00);
		if(!var_06)
		{
			prioritize_watch_nodes_toward_enemies(0.5);
		}

		foreach(var_04 in self.watch_nodes)
		{
			if(var_06)
			{
				var_08 = self [[ var_00 ]](var_04);
				var_04.watch_node_chance[self.entity_number] = var_04.watch_node_chance[self.entity_number] * var_08;
			}

			if(entrance_watched_by_ally(var_04))
			{
				var_04.watch_node_chance[self.entity_number] = var_04.watch_node_chance[self.entity_number] * 0.5;
			}
		}

		wait(randomfloatrange(0.5,0.75));
	}
}

//Function Number: 23
bot_monitor_watch_entrances_bodyguard()
{
	self notify("bot_monitor_watch_entrances_bodyguard");
	self endon("bot_monitor_watch_entrances_bodyguard");
	self notify("bot_monitor_watch_entrances");
	self endon("bot_monitor_watch_entrances");
	while(!isdefined(self.watch_nodes))
	{
		wait(0.05);
	}

	for(;;)
	{
		var_00 = anglestoforward(self.bot_defend_player_guarding.angles) * (1,1,0);
		var_00 = vectornormalize(var_00);
		foreach(var_02 in self.watch_nodes)
		{
			var_02.watch_node_chance[self.entity_number] = 1;
			var_03 = var_02.origin - self.bot_defend_player_guarding.origin;
			var_03 = vectornormalize(var_03);
			var_04 = vectordot(var_00,var_03);
			if(var_04 > 0.6)
			{
				var_02.watch_node_chance[self.entity_number] = var_02.watch_node_chance[self.entity_number] * 0.33;
			}
			else if(var_04 > 0)
			{
				var_02.watch_node_chance[self.entity_number] = var_02.watch_node_chance[self.entity_number] * 0.66;
			}

			if(!entrance_to_enemy_zone(var_02))
			{
				var_02.watch_node_chance[self.entity_number] = var_02.watch_node_chance[self.entity_number] * 0.5;
			}
		}

		wait(randomfloatrange(0.4,0.6));
	}
}

//Function Number: 24
entrance_to_enemy_zone(param_00)
{
	var_01 = getnodezone(param_00);
	var_02 = vectornormalize(param_00.origin - self.origin);
	for(var_03 = 0;var_03 < level.zonecount;var_03++)
	{
		if(botzonegetcount(var_03,self.team,"enemy_predict") > 0)
		{
			if(isdefined(var_01) && var_03 == var_01)
			{
				return 1;
			}
			else
			{
				var_04 = vectornormalize(getzoneorigin(var_03) - self.origin);
				var_05 = vectordot(var_02,var_04);
				if(var_05 > 0.2)
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 25
prioritize_watch_nodes_toward_enemies(param_00)
{
	if(self.watch_nodes.size <= 0)
	{
		return;
	}

	var_01 = self.watch_nodes;
	for(var_02 = 0;var_02 < level.zonecount;var_02++)
	{
		if(botzonegetcount(var_02,self.team,"enemy_predict") <= 0)
		{
			continue;
		}

		if(var_01.size == 0)
		{
			break;
		}

		var_03 = vectornormalize(getzoneorigin(var_02) - self.origin);
		for(var_04 = 0;var_04 < var_01.size;var_04++)
		{
			var_05 = getnodezone(var_01[var_04]);
			var_06 = 0;
			if(isdefined(var_05) && var_02 == var_05)
			{
				var_06 = 1;
			}
			else
			{
				var_07 = vectornormalize(var_01[var_04].origin - self.origin);
				var_08 = vectordot(var_07,var_03);
				if(var_08 > 0.2)
				{
					var_06 = 1;
				}
			}

			if(var_06)
			{
				var_01[var_04].watch_node_chance[self.entity_number] = var_01[var_04].watch_node_chance[self.entity_number] * param_00;
				var_01[var_04] = var_01[var_01.size - 1];
				var_01[var_01.size - 1] = undefined;
				var_04--;
			}
		}
	}
}

//Function Number: 26
entrance_watched_by_ally(param_00)
{
	var_01 = bot_get_teammates_currently_defending_point(self.bot_defending_center);
	foreach(var_03 in var_01)
	{
		if(entrance_watched_by_player(var_03,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 27
entrance_watched_by_player(param_00,param_01)
{
	var_02 = anglestoforward(param_00.angles);
	var_03 = vectornormalize(param_01.origin - param_00.origin);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > 0.6)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
bot_get_teammates_currently_defending_point(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		if(isdefined(level.protect_radius))
		{
			param_01 = level.protect_radius;
		}
		else
		{
			param_01 = 900;
		}
	}

	var_02 = [];
	var_03 = bot_get_teammates_in_radius(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(!isai(var_05) || var_05 maps\mp\bots\_bots_util::bot_is_defending_point(param_00))
		{
			var_02 = common_scripts\utility::array_add(var_02,var_05);
		}
	}

	return var_02;
}

//Function Number: 29
bot_get_teammates_in_radius(param_00,param_01)
{
	var_02 = param_01 * param_01;
	var_03 = [];
	for(var_04 = 0;var_04 < level.participants.size;var_04++)
	{
		var_05 = level.participants[var_04];
		if(var_05 != self && isdefined(var_05.team) && var_05.team == self.team && maps\mp\_utility::isteamparticipant(var_05))
		{
			if(distancesquared(param_00,var_05.origin) < var_02)
			{
				var_03 = common_scripts\utility::array_add(var_03,var_05);
			}
		}
	}

	return var_03;
}

//Function Number: 30
defense_death_monitor()
{
	level endon("game_ended");
	self endon("started_bot_defend_think");
	self endon("defend_stop");
	self endon("disconnect");
	self waittill("death");
	if(isdefined(self))
	{
		thread bot_defend_stop();
	}
}

//Function Number: 31
bot_defend_stop()
{
	self notify("defend_stop");
	self.bot_defending = undefined;
	self.bot_defending_center = undefined;
	self.bot_defending_radius = undefined;
	self.bot_defending_nodes = undefined;
	self.bot_defending_type = undefined;
	self.bot_defending_trigger = undefined;
	self.bot_defending_override_origin_node = undefined;
	self.bot_defend_player_guarding = undefined;
	self.defense_score_flags = undefined;
	self.node_closest_to_defend_center = undefined;
	self.defense_investigate_specific_point = undefined;
	self.defense_force_next_node_goal = undefined;
	self.defend_objective_radius = undefined;
	self.prev_defend_node = undefined;
	self.cur_defend_node = undefined;
	self.cur_defend_angle_override = undefined;
	self.cur_defend_point_override = undefined;
	self.defend_entrance_index = undefined;
	self.defense_override_entrances = undefined;
	self botclearscriptgoal();
	self botsetstance("none");
}

//Function Number: 32
defend_get_ally_bots_at_zone_for_stance(param_00)
{
	var_01 = [];
	foreach(var_03 in level.participants)
	{
		if(!isdefined(var_03.team))
		{
			continue;
		}

		if(var_03.team == self.team && var_03 != self && isai(var_03) && var_03 maps\mp\bots\_bots_util::bot_is_defending() && var_03.cur_defend_stance == param_00)
		{
			if(var_03.bot_defending_type == self.bot_defending_type && maps\mp\bots\_bots_util::bot_is_defending_point(var_03.bot_defending_center))
			{
				var_01 = common_scripts\utility::array_add(var_01,var_03);
			}
		}
	}

	return var_01;
}

//Function Number: 33
monitor_defend_player()
{
	var_00 = 0;
	var_01 = 175;
	var_02 = self.bot_defend_player_guarding.origin;
	var_03 = 0;
	var_04 = 0;
	for(;;)
	{
		if(!isdefined(self.bot_defend_player_guarding))
		{
			thread bot_defend_stop();
		}

		self.bot_defending_center = self.bot_defend_player_guarding.origin;
		self.node_closest_to_defend_center = self.bot_defend_player_guarding getnearestnode();
		if(!isdefined(self.node_closest_to_defend_center))
		{
			self.node_closest_to_defend_center = self getnearestnode();
		}

		if(self botgetscriptgoaltype() != "none")
		{
			var_05 = self botgetscriptgoal();
			var_06 = self.bot_defend_player_guarding getvelocity();
			var_07 = lengthsquared(var_06);
			if(var_07 > 100)
			{
				var_00 = 0;
				if(distancesquared(var_02,self.bot_defend_player_guarding.origin) > var_01 * var_01)
				{
					var_02 = self.bot_defend_player_guarding.origin;
					var_04 = 1;
					var_08 = vectornormalize(var_05 - self.bot_defend_player_guarding.origin);
					var_09 = vectornormalize(var_06);
					if(vectordot(var_08,var_09) < 0.1)
					{
						self notify("defend_force_node_recalculation");
						wait(0.25);
					}
				}
			}
			else
			{
				var_00 = var_00 + 0.05;
				if(var_03 > 100 && var_04)
				{
					var_02 = self.bot_defend_player_guarding.origin;
					var_04 = 0;
				}

				if(var_00 > 0.5)
				{
					var_0A = distancesquared(var_05,self.bot_defending_center);
					if(var_0A > self.bot_defending_radius * self.bot_defending_radius)
					{
						self notify("defend_force_node_recalculation");
						wait(0.25);
					}
				}
			}

			var_03 = var_07;
			if(abs(self.bot_defend_player_guarding.origin[2] - var_05[2]) >= 50)
			{
				self notify("defend_force_node_recalculation");
				wait(0.25);
			}
		}

		wait(0.05);
	}
}

//Function Number: 34
find_defend_node_capture()
{
	var_00 = bot_defend_get_random_entrance_point_for_current_area();
	var_01 = maps\mp\bots\_bots_util::bot_find_node_to_capture_point(maps\mp\bots\_bots_util::defend_valid_center(),self.bot_defending_radius,var_00);
	if(isdefined(var_01))
	{
		if(isdefined(var_00))
		{
			var_02 = vectornormalize(var_00 - var_01.origin);
			self.cur_defend_angle_override = vectortoangles(var_02);
		}
		else
		{
			var_03 = vectornormalize(var_01.origin - maps\mp\bots\_bots_util::defend_valid_center());
			self.cur_defend_angle_override = vectortoangles(var_03);
		}

		self.cur_defend_node = var_01;
		return;
	}

	if(isdefined(var_00))
	{
		bot_handle_no_valid_defense_node(var_00,undefined);
		return;
	}

	bot_handle_no_valid_defense_node(undefined,maps\mp\bots\_bots_util::defend_valid_center());
}

//Function Number: 35
find_defend_node_capture_zone()
{
	var_00 = bot_defend_get_random_entrance_point_for_current_area();
	var_01 = maps\mp\bots\_bots_util::bot_find_node_to_capture_zone(self.bot_defending_nodes,var_00);
	if(isdefined(var_01))
	{
		if(isdefined(var_00))
		{
			var_02 = vectornormalize(var_00 - var_01.origin);
			self.cur_defend_angle_override = vectortoangles(var_02);
		}
		else
		{
			var_03 = vectornormalize(var_01.origin - maps\mp\bots\_bots_util::defend_valid_center());
			self.cur_defend_angle_override = vectortoangles(var_03);
		}

		self.cur_defend_node = var_01;
		return;
	}

	if(isdefined(var_00))
	{
		bot_handle_no_valid_defense_node(var_00,undefined);
		return;
	}

	bot_handle_no_valid_defense_node(undefined,maps\mp\bots\_bots_util::defend_valid_center());
}

//Function Number: 36
find_defend_node_protect()
{
	var_00 = maps\mp\bots\_bots_util::bot_find_node_that_protects_point(maps\mp\bots\_bots_util::defend_valid_center(),self.bot_defending_radius);
	if(isdefined(var_00))
	{
		var_01 = vectornormalize(maps\mp\bots\_bots_util::defend_valid_center() - var_00.origin);
		self.cur_defend_angle_override = vectortoangles(var_01);
		self.cur_defend_node = var_00;
		return;
	}

	bot_handle_no_valid_defense_node(maps\mp\bots\_bots_util::defend_valid_center(),undefined);
}

//Function Number: 37
find_defend_node_bodyguard()
{
	var_00 = maps\mp\bots\_bots_util::bot_find_node_to_guard_player(maps\mp\bots\_bots_util::defend_valid_center(),self.bot_defending_radius);
	if(isdefined(var_00))
	{
		self.cur_defend_node = var_00;
		return;
	}

	var_01 = self getnearestnode();
	if(isdefined(var_01))
	{
		self.cur_defend_node = var_01;
		return;
	}

	self.cur_defend_point_override = self.origin;
}

//Function Number: 38
find_defend_node_patrol()
{
	var_00 = undefined;
	var_01 = getnodesinradius(maps\mp\bots\_bots_util::defend_valid_center(),self.bot_defending_radius,0);
	if(isdefined(var_01) && var_01.size > 0)
	{
		var_00 = self botnodepick(var_01,1 + var_01.size * 0.5,"node_traffic");
	}

	if(isdefined(var_00))
	{
		self.cur_defend_node = var_00;
		return;
	}

	bot_handle_no_valid_defense_node(undefined,maps\mp\bots\_bots_util::defend_valid_center());
}

//Function Number: 39
bot_handle_no_valid_defense_node(param_00,param_01)
{
	if(self.bot_defending_type == "capture_zone")
	{
		self.cur_defend_point_override = maps\mp\bots\_bots_util::bot_pick_random_point_from_set(maps\mp\bots\_bots_util::defend_valid_center(),self.bot_defending_nodes,::bot_can_use_point_in_defend);
	}
	else
	{
		self.cur_defend_point_override = maps\mp\bots\_bots_util::bot_pick_random_point_in_radius(maps\mp\bots\_bots_util::defend_valid_center(),self.bot_defending_radius,::bot_can_use_point_in_defend,0.15,0.9);
	}

	if(isdefined(param_00))
	{
		var_02 = vectornormalize(param_00 - self.cur_defend_point_override);
		self.cur_defend_angle_override = vectortoangles(var_02);
		return;
	}

	if(isdefined(param_01))
	{
		var_02 = vectornormalize(self.cur_defend_point_override - param_01);
		self.cur_defend_angle_override = vectortoangles(var_02);
	}
}

//Function Number: 40
bot_can_use_point_in_defend(param_00)
{
	if(bot_check_team_is_using_position(param_00,1,1,1))
	{
		return 0;
	}

	return 1;
}

//Function Number: 41
bot_check_team_is_using_position(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < level.participants.size;var_04++)
	{
		var_05 = level.participants[var_04];
		if(var_05.team == self.team && var_05 != self)
		{
			if(isai(var_05))
			{
				if(param_02)
				{
					if(distancesquared(param_00,var_05.origin) < 441)
					{
						return 1;
					}
				}

				if(param_03 && var_05 bothasscriptgoal())
				{
					var_06 = var_05 botgetscriptgoal();
					if(distancesquared(param_00,var_06) < 441)
					{
						return 1;
					}
				}

				continue;
			}

			if(param_01)
			{
				if(distancesquared(param_00,var_05.origin) < 441)
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 42
bot_capture_zone_get_furthest_distance()
{
	var_00 = 0;
	if(isdefined(self.bot_defending_nodes))
	{
		foreach(var_02 in self.bot_defending_nodes)
		{
			var_03 = distance(self.bot_defending_center,var_02.origin);
			var_00 = max(var_03,var_00);
		}
	}

	return var_00;
}

//Function Number: 43
bot_think_tactical_goals()
{
	self notify("bot_think_tactical_goals");
	self endon("bot_think_tactical_goals");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.tactical_goals = [];
	for(;;)
	{
		if(self.tactical_goals.size > 0 && !maps\mp\bots\_bots_util::bot_is_remote_or_linked())
		{
			var_00 = self.tactical_goals[0];
			if(!isdefined(var_00.abort))
			{
				self notify("start_tactical_goal");
				if(isdefined(var_00.start_thread))
				{
					self [[ var_00.start_thread ]](var_00);
				}

				childthread watch_goal_aborted(var_00);
				var_01 = "tactical";
				if(isdefined(var_00.goal_type))
				{
					var_01 = var_00.goal_type;
				}

				self botsetscriptgoal(var_00.goal_position,var_00.goal_radius,var_01,var_00.goal_yaw,var_00.objective_radius);
				var_02 = maps\mp\bots\_bots_util::bot_waittill_goal_or_fail(undefined,"stop_tactical_goal");
				self notify("stop_goal_aborted_watch");
				if(var_02 == "goal")
				{
					if(isdefined(var_00.action_thread))
					{
						self [[ var_00.action_thread ]](var_00);
					}
				}

				if(var_02 != "script_goal_changed")
				{
					self botclearscriptgoal();
				}

				if(isdefined(var_00.end_thread))
				{
					self [[ var_00.end_thread ]](var_00);
				}
			}

			self.tactical_goals = common_scripts\utility::array_remove(self.tactical_goals,var_00);
		}

		wait(0.05);
	}
}

//Function Number: 44
watch_goal_aborted(param_00)
{
	self endon("stop_tactical_goal");
	self endon("stop_goal_aborted_watch");
	wait(0.05);
	for(;;)
	{
		if(isdefined(param_00.abort) || isdefined(param_00.should_abort) && self [[ param_00.should_abort ]](param_00))
		{
			self notify("stop_tactical_goal");
		}

		wait(0.05);
	}
}

//Function Number: 45
bot_new_tactical_goal(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.type = param_00;
	var_04.goal_position = param_01;
	if(isdefined(self.only_allowable_tactical_goals))
	{
		if(!common_scripts\utility::array_contains(self.only_allowable_tactical_goals,param_00))
		{
			return;
		}
	}

	var_04.priority = param_02;
	var_04.object = param_03.object;
	var_04.goal_type = param_03.script_goal_type;
	var_04.goal_yaw = param_03.script_goal_yaw;
	var_04.goal_radius = 0;
	if(isdefined(param_03.script_goal_radius))
	{
		var_04.goal_radius = param_03.script_goal_radius;
	}

	var_04.start_thread = param_03.start_thread;
	var_04.end_thread = param_03.end_thread;
	var_04.should_abort = param_03.should_abort;
	var_04.action_thread = param_03.action_thread;
	var_04.objective_radius = param_03.objective_radius;
	for(var_05 = 0;var_05 < self.tactical_goals.size;var_05++)
	{
		if(var_04.priority > self.tactical_goals[var_05].priority)
		{
			break;
		}
	}

	for(var_06 = self.tactical_goals.size - 1;var_06 >= var_05;var_06--)
	{
		self.tactical_goals[var_06 + 1] = self.tactical_goals[var_06];
	}

	self.tactical_goals[var_05] = var_04;
}

//Function Number: 46
bot_has_tactical_goal(param_00,param_01)
{
	if(!isdefined(self.tactical_goals))
	{
		return 0;
	}

	if(isdefined(param_00))
	{
		foreach(var_03 in self.tactical_goals)
		{
			if(var_03.type == param_00)
			{
				if(isdefined(param_01) && isdefined(var_03.object))
				{
					return var_03.object == param_01;
				}
				else
				{
					return 1;
				}
			}
		}

		return 0;
	}

	return self.tactical_goals.size > 0;
}

//Function Number: 47
bot_abort_tactical_goal(param_00,param_01)
{
	if(!isdefined(self.tactical_goals))
	{
		return;
	}

	foreach(var_03 in self.tactical_goals)
	{
		if(var_03.type == param_00)
		{
			if(isdefined(param_01))
			{
				if(isdefined(var_03.object) && var_03.object == param_01)
				{
					var_03.abort = 1;
				}

				continue;
			}

			var_03.abort = 1;
		}
	}
}

//Function Number: 48
bot_disable_tactical_goals()
{
	self.only_allowable_tactical_goals[0] = "map_interactive_object";
	foreach(var_01 in self.tactical_goals)
	{
		if(var_01.type != "map_interactive_object")
		{
			var_01.abort = 1;
		}
	}
}

//Function Number: 49
bot_enable_tactical_goals()
{
	self.only_allowable_tactical_goals = undefined;
}

//Function Number: 50
bot_melee_tactical_insertion_check()
{
	var_00 = gettime();
	if(!isdefined(self.last_melee_ti_check) || var_00 - self.last_melee_ti_check > 1000)
	{
		self.last_melee_ti_check = var_00;
		var_01 = bot_get_ambush_trap_item("tacticalinsertion");
		if(!isdefined(var_01))
		{
			return 0;
		}

		if(isdefined(self.enemy) && self botcanseeentity(self.enemy))
		{
			return 0;
		}

		var_02 = getzonenearest(self.origin);
		if(!isdefined(var_02))
		{
			return 0;
		}

		var_03 = botzonenearestcount(var_02,self.team,1,"enemy_predict",">",0);
		if(!isdefined(var_03))
		{
			return 0;
		}

		var_04 = getnodesinradius(self.origin,500,0);
		if(var_04.size <= 0)
		{
			return 0;
		}

		var_05 = self botnodepick(var_04,var_04.size * 0.15,"node_hide");
		if(!isdefined(var_05))
		{
			return 0;
		}

		return bot_set_ambush_trap(var_01,undefined,undefined,undefined,var_05);
	}

	return 0;
}