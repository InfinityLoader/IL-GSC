/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots_strategy.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 2371 ms
 * Timestamp: 10/27/2023 12:27:46 AM
*******************************************************************/

//Function Number: 1
func_2D4C()
{
	var_00 = func_2D4B(self.var_4B0F);
	if(isdefined(var_00) && var_00.size > 0)
	{
		return scripts\common\utility::random(var_00).origin;
	}

	return undefined;
}

//Function Number: 2
func_2D4B(param_00)
{
	if(isdefined(self.var_5060))
	{
		return scripts\mp\bots\_bots_util::func_2DA8(param_00,self.var_5060);
	}

	return [];
}

//Function Number: 3
func_2E86()
{
	wait(1);
	func_2E87(level.var_2C7A);
	level.var_2E80 = 1;
}

//Function Number: 4
func_2E8A()
{
	func_2E87(level.var_DBFE);
}

//Function Number: 5
func_2E87(param_00)
{
	foreach(var_02 in param_00)
	{
		if(!isdefined(var_02.var_2EFE))
		{
			var_02.var_2EFE = [];
			var_03 = function_00B7(var_02.trigger);
			foreach(var_05 in var_03)
			{
				if(!var_05 method_821B())
				{
					var_02.var_2EFE = scripts\common\utility::array_add(var_02.var_2EFE,var_05);
				}
			}
		}
	}
}

//Function Number: 6
func_2DA3(param_00,param_01,param_02)
{
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

	foreach(var_06 in var_04)
	{
		var_03["purpose"] = var_06;
		var_03["item_action"] = scripts\mp\bots\_bots_util::func_2DAA(var_06);
		if(isdefined(var_03["item_action"]))
		{
			return var_03;
		}
	}
}

//Function Number: 7
func_2E7E(param_00,param_01,param_02,param_03,param_04)
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
			var_05 = scripts\common\utility::random(var_06);
			var_0B = getnodesinradius(var_05.origin,300,50);
			var_0C = [];
			foreach(var_0E in var_0B)
			{
				if(!isdefined(var_0E.var_2D0B))
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
			var_13 = scripts\mp\bots\_bots_util::func_2ECB();
			if(var_13 == "goal")
			{
				thread scripts\mp\bots\_bots_util::func_2D9C("stand",5);
				if(!isdefined(self.var_10C) || 0 == self botcanseeentity(self.var_10C))
				{
					if(isdefined(var_10))
					{
						self method_8056(var_05.origin,param_00["item_action"]);
					}
					else
					{
						self method_8056(self.origin + anglestoforward(self.angles) * 50,param_00["item_action"]);
					}

					self.var_1E27 = undefined;
					thread func_2E7F("grenade_fire");
					thread func_2E7F("missile_fire");
					var_14 = 3;
					if(param_00["purpose"] == "tacticalinsertion")
					{
						var_14 = 6;
					}

					scripts\common\utility::waittill_any_timeout_1(var_14,"missile_fire","grenade_fire");
					wait(0.05);
					self notify("ambush_trap_ent");
					if(isdefined(self.var_1E27) && param_00["purpose"] == "c4")
					{
						thread func_2ED2(self.var_1E27,param_00["item_action"],300);
					}

					self.var_1E27 = undefined;
					wait(randomfloat(0.25));
					self botsetstance("none");
				}
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 8
func_2E7F(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("bot_set_ambush_trap");
	self endon("ambush_trap_ent");
	level endon("game_ended");
	self waittill(param_00,var_01);
	self.var_1E27 = var_01;
}

//Function Number: 9
func_2ED2(param_00,param_01,param_02)
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
			var_04 = self method_8111(param_00.origin,1);
			if(var_04 < var_03)
			{
				self botpressbutton(param_01);
				return;
			}
		}

		wait(randomfloatrange(0.25,1));
	}
}

//Function Number: 10
func_2D2B(param_00,param_01,param_02)
{
	thread func_2D4F(param_00,param_01,"capture",param_02);
}

//Function Number: 11
func_2D2C(param_00,param_01,param_02,param_03)
{
	param_03["capture_trigger"] = param_02;
	thread func_2D4F(param_00,param_01,"capture_zone",param_03);
}

//Function Number: 12
func_2E57(param_00,param_01,param_02)
{
	if(!isdefined(param_02) || !isdefined(param_02["min_goal_time"]))
	{
		param_02["min_goal_time"] = 12;
	}

	if(!isdefined(param_02) || !isdefined(param_02["max_goal_time"]))
	{
		param_02["max_goal_time"] = 18;
	}

	thread func_2D4F(param_00,param_01,"protect",param_02);
}

//Function Number: 13
func_2E3D(param_00,param_01,param_02)
{
	if(!isdefined(param_02) || !isdefined(param_02["min_goal_time"]))
	{
		param_02["min_goal_time"] = 0;
	}

	if(!isdefined(param_02) || !isdefined(param_02["max_goal_time"]))
	{
		param_02["max_goal_time"] = 0.01;
	}

	thread func_2D4F(param_00,param_01,"patrol",param_02);
}

//Function Number: 14
func_2DC1(param_00,param_01,param_02)
{
	if(!isdefined(param_02) || !isdefined(param_02["min_goal_time"]))
	{
		param_02["min_goal_time"] = 15;
	}

	if(!isdefined(param_02) || !isdefined(param_02["max_goal_time"]))
	{
		param_02["max_goal_time"] = 20;
	}

	thread func_2D4F(param_00,param_01,"bodyguard",param_02);
}

//Function Number: 15
func_2D4F(param_00,param_01,param_02,param_03)
{
	self notify("started_bot_defend_think");
	self endon("started_bot_defend_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("defend_stop");
	thread func_508D();
	if(isdefined(self.var_2D51) || self botgetscriptgoaltype() == "camp")
	{
		self botclearscriptgoal();
	}

	self.var_2D51 = 1;
	self.var_2D57 = param_02;
	if(param_02 == "capture_zone")
	{
		self.var_2D55 = undefined;
		self.var_2D53 = param_01;
		self.var_2D56 = param_03["capture_trigger"];
	}
	else
	{
		self.var_2D55 = param_01;
		self.var_2D53 = undefined;
		self.var_2D56 = undefined;
	}

	if(scripts\mp\_utility::func_9E0E(param_00))
	{
		self.var_2D4D = param_00;
		childthread func_B962();
	}
	else
	{
		self.var_2D4D = undefined;
		self.var_2D52 = param_00;
	}

	self botsetstance("none");
	var_04 = undefined;
	var_05 = 6;
	var_06 = 10;
	if(isdefined(param_03))
	{
		self.var_5060 = param_03["entrance_points_index"];
		self.var_5092 = param_03["score_flags"];
		self.var_2D54 = param_03["override_origin_node"];
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
			self.var_5091 = param_03["override_entrances"];
			self.var_5060 = self.name + " " + gettime();
			foreach(var_08 in self.var_5091)
			{
				var_08.var_DA7C[self.var_5060] = scripts\mp\bots\_bots_util::func_6655(var_08.origin,scripts\mp\bots\_bots_util::func_507A(),"prone");
				wait(0.05);
				var_08.var_4A9C[self.var_5060] = scripts\mp\bots\_bots_util::func_6655(var_08.origin,scripts\mp\bots\_bots_util::func_507A(),"crouch");
				wait(0.05);
			}
		}
	}

	if(!isdefined(self.var_2D4D))
	{
		var_0A = undefined;
		if(isdefined(param_03) && isdefined(param_03["nearest_node_to_center"]))
		{
			var_0A = param_03["nearest_node_to_center"];
		}

		if(!isdefined(var_0A) && isdefined(self.var_2D54))
		{
			var_0A = self.var_2D54;
		}

		if(!isdefined(var_0A) && isdefined(self.var_2D56) && isdefined(self.var_2D56.nearest_node))
		{
			var_0A = self.var_2D56.nearest_node;
		}

		if(!isdefined(var_0A))
		{
			var_0A = getclosestnodeinsight(scripts\mp\bots\_bots_util::func_507A());
		}

		if(!isdefined(var_0A))
		{
			var_0B = self method_8533();
			var_0C = scripts\mp\bots\_bots_util::func_507A();
			var_0D = getnodesinradiussorted(var_0C,256,0,500,"path",var_0B);
			for(var_0E = 0;var_0E < var_0D.size;var_0E++)
			{
				var_0F = vectornormalize(var_0D[var_0E].origin - var_0C);
				var_10 = var_0C + var_0F * 15;
				if(sighttracepassed(var_10,var_0D[var_0E].origin,0,undefined))
				{
					var_0A = var_0D[var_0E];
					break;
				}

				wait(0.05);
				if(sighttracepassed(var_10 + (0,0,55),var_0D[var_0E].origin + (0,0,55),0,undefined))
				{
					var_0A = var_0D[var_0E];
					break;
				}

				wait(0.05);
			}
		}

		self.var_C031 = var_0A;
	}

	var_11 = level.var_2D76[param_02];
	if(!isdefined(var_04))
	{
		var_04 = "guard";
		if(param_02 == "capture" || param_02 == "capture_zone")
		{
			var_04 = "objective";
		}
	}

	var_12 = scripts\mp\bots\_bots_util::func_2DD5();
	if(param_02 == "protect")
	{
		childthread func_DAA4();
	}

	for(;;)
	{
		self.var_D888 = self.var_4B0D;
		self.var_4B0D = undefined;
		self.var_4B0C = undefined;
		self.var_4B0E = undefined;
		self.var_4B0F = func_36E6(var_12);
		var_13 = self botgetscriptgoaltype();
		var_14 = scripts\mp\bots\_bots_util::func_2DBB(var_04,var_13);
		if(!var_14)
		{
			wait(0.25);
			continue;
		}

		var_15 = var_05;
		var_16 = var_06;
		var_17 = 1;
		if(isdefined(self.var_5090))
		{
			self.var_4B0E = self.var_5090;
			self.var_5090 = undefined;
			var_17 = 0;
			var_15 = 1;
			var_16 = 2;
		}
		else if(isdefined(self.var_508E))
		{
			self.var_4B0D = self.var_508E;
			self.var_508E = undefined;
		}
		else
		{
			self [[ var_11 ]]();
		}

		self botclearscriptgoal();
		var_18 = "";
		if(isdefined(self.var_4B0D) || isdefined(self.var_4B0E))
		{
			if(var_17 && scripts\mp\bots\_bots_util::func_2DDD() && !isplayer(param_00) && isdefined(self.var_5060))
			{
				var_19 = func_2DA3("trap_directional","trap","c4");
				if(isdefined(var_19))
				{
					var_1A = scripts\mp\bots\_bots_util::func_2DA8(undefined,self.var_5060);
					func_2E7E(var_19,var_1A,self.var_C031);
				}
			}

			if(isdefined(self.var_4B0E))
			{
				var_1B = undefined;
				if(isdefined(self.var_4B0C))
				{
					var_1B = self.var_4B0C[1];
				}

				self botsetscriptgoal(self.var_4B0E,0,var_04,var_1B);
			}
			else if(!isdefined(self.var_4B0C))
			{
				self botsetscriptgoalnode(self.var_4B0D,var_04);
			}
			else
			{
				self botsetscriptgoalnode(self.var_4B0D,var_04,self.var_4B0C[1]);
			}

			if(var_12)
			{
				if(!isdefined(self.var_D888) || !isdefined(self.var_4B0D) || self.var_D888 != self.var_4B0D)
				{
					self botsetstance("none");
				}
			}

			var_1C = self botgetscriptgoal();
			self notify("new_defend_goal");
			scripts\mp\bots\_bots_util::func_13960();
			if(var_04 == "objective")
			{
				func_508C();
				self botgetpathdist(1);
				self botsetflag("cautious",0);
			}

			if(self bothasscriptgoal())
			{
				var_1D = self botgetscriptgoal();
				if(scripts\mp\bots\_bots_util::func_2EC6(var_1D,var_1C))
				{
					var_18 = scripts\mp\bots\_bots_util::func_2ECB(20,"defend_force_node_recalculation");
				}
			}

			if(var_18 == "goal")
			{
				if(var_12)
				{
					self botsetstance(self.var_4B0F);
				}

				childthread func_5097();
			}
		}

		if(var_18 != "goal")
		{
			wait(0.25);
			continue;
		}

		var_1E = randomfloatrange(var_15,var_16);
		var_18 = scripts\common\utility::waittill_any_timeout_1(var_1E,"node_relinquished","goal_changed","script_goal_changed","defend_force_node_recalculation","bad_path");
		if((var_18 == "node_relinquished" || var_18 == "bad_path" || var_18 == "goal_changed" || var_18 == "script_goal_changed") && self.var_4B0F == "crouch" || self.var_4B0F == "prone")
		{
			self botsetstance("none");
		}
	}
}

//Function Number: 16
func_36E6(param_00)
{
	var_01 = "stand";
	if(param_00)
	{
		var_02 = 100;
		var_03 = 0;
		var_04 = 0;
		var_05 = self botgetdifficultysetting("strategyLevel");
		if(var_05 == 1)
		{
			var_02 = 20;
			var_03 = 25;
			var_04 = 55;
		}
		else if(var_05 >= 2)
		{
			var_02 = 10;
			var_03 = 20;
			var_04 = 70;
		}

		var_06 = self.var_AE62;
		if(isdefined(var_06) && var_06 == "archetype_heavy")
		{
			var_04 = 0;
		}

		var_07 = randomint(100);
		if(var_07 < var_03)
		{
			var_01 = "crouch";
		}
		else if(var_07 < var_03 + var_04)
		{
			var_01 = "prone";
		}

		if(var_01 == "prone")
		{
			var_08 = func_2D4B("prone");
			var_09 = func_5064("prone");
			if(var_09.size >= var_08.size)
			{
				var_01 = "crouch";
			}
		}

		if(var_01 == "crouch")
		{
			var_0A = func_2D4B("crouch");
			var_0B = func_5064("crouch");
			if(var_0B.size >= var_0A.size)
			{
				var_01 = "stand";
			}
		}
	}

	return var_01;
}

//Function Number: 17
func_FF9A(param_00)
{
	var_01 = 1250;
	var_02 = var_01 * var_01;
	if(param_00)
	{
		if(self botgetdifficultysetting("strategyLevel") == 0)
		{
			return 0;
		}

		if(self.var_2D57 == "capture_zone" && self istouching(self.var_2D56))
		{
			return 0;
		}

		return distancesquared(self.origin,self.var_2D52) > var_02 * 0.75 * 0.75;
	}

	if(self botpursuingscriptgoal() && distancesquared(self.origin,self.var_2D52) < var_02)
	{
		var_03 = self method_8034();
		return 0 <= var_03 && var_03 <= var_01;
	}

	return 0;
}

//Function Number: 18
func_F9AE(param_00,param_01)
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

	var_02.var_205 = param_00;
	var_02.var_735E = 0;
	return var_02;
}

//Function Number: 19
func_508C()
{
	self notify("defense_cautious_approach");
	self endon("defense_cautious_approach");
	level endon("game_ended");
	self endon("defend_force_node_recalculation");
	self endon("death");
	self endon("disconnect");
	self endon("defend_stop");
	self endon("started_bot_defend_think");
	if(![[ level.var_2D9E["should_start_cautious_approach"] ]](1))
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
		if(!scripts\mp\bots\_bots_util::func_2EC6(var_00,var_04))
		{
			return;
		}

		var_03 = var_03 + 0.25;
		if(var_03 >= 0.5)
		{
			var_03 = 0;
			if([[ level.var_2D9E["should_start_cautious_approach"] ]](0))
			{
				var_02 = 0;
			}
		}
	}

	self botgetpathdist(1.8);
	self botsetflag("cautious",1);
	var_05 = self method_8033();
	if(!isdefined(var_05) || var_05.size <= 2)
	{
		return;
	}

	self.var_AECF = [];
	var_06 = 1000;
	if(isdefined(level.var_DAA3))
	{
		var_06 = level.var_DAA3;
	}

	var_07 = var_06 * var_06;
	var_08 = self method_8533();
	var_09 = getnodesinradius(self.var_2D52,var_06,0,500,"path",var_08);
	if(var_09.size <= 0)
	{
		return;
	}

	var_0A = 5 + self botgetdifficultysetting("strategyLevel") * 2;
	var_0B = int(min(var_0A,var_09.size));
	var_0C = self botnodepickmultiple(var_09,15,var_0B,"node_protect",scripts\mp\bots\_bots_util::func_507A(),"ignore_occupancy");
	for(var_0D = 0;var_0D < var_0C.size;var_0D++)
	{
		var_0E = func_F9AE(var_0C[var_0D]);
		self.var_AECF = scripts\common\utility::array_add(self.var_AECF,var_0E);
	}

	var_0F = botgetmemoryevents(0,gettime() - -5536,1,"death",0,self);
	foreach(var_11 in var_0F)
	{
		if(distancesquared(var_11,self.var_2D52) < var_07)
		{
			var_12 = getclosestnodeinsight(var_11);
			if(isdefined(var_12))
			{
				var_0E = func_F9AE(var_12,var_11);
				self.var_AECF = scripts\common\utility::array_add(self.var_AECF,var_0E);
			}
		}
	}

	if(isdefined(self.var_5060))
	{
		var_14 = scripts\mp\bots\_bots_util::func_2DA8("stand",self.var_5060);
		for(var_0D = 0;var_0D < var_14.size;var_0D++)
		{
			var_0E = func_F9AE(var_14[var_0D]);
			self.var_AECF = scripts\common\utility::array_add(self.var_AECF,var_0E);
		}
	}

	if(self.var_AECF.size == 0)
	{
		return;
	}

	childthread func_B959();
	var_15 = self botgetscriptgoaltype();
	var_16 = self botgetscriptgoalradius();
	var_17 = self botgetscriptgoalyaw();
	wait(0.05);
	for(var_18 = 1;var_18 < var_05.size - 2;var_18++)
	{
		scripts\mp\bots\_bots_util::func_2ECC();
		var_19 = getlinkednodes(var_05[var_18]);
		if(var_19.size == 0)
		{
			continue;
		}

		var_1A = [];
		for(var_0D = 0;var_0D < var_19.size;var_0D++)
		{
			if(!scripts\common\utility::func_13D90(self.origin,self.angles,var_19[var_0D].origin,0))
			{
				continue;
			}

			for(var_1B = 0;var_1B < self.var_AECF.size;var_1B++)
			{
				var_11 = self.var_AECF[var_1B];
				if(nodesvisible(var_11.var_205,var_19[var_0D],1))
				{
					var_1A = scripts\common\utility::array_add(var_1A,var_19[var_0D]);
					var_1B = self.var_AECF.size;
				}
			}
		}

		if(var_1A.size == 0)
		{
			continue;
		}

		var_1C = self botnodepick(var_1A,1 + var_1A.size * 0.15,"node_hide");
		if(isdefined(var_1C))
		{
			var_1D = [];
			for(var_0D = 0;var_0D < self.var_AECF.size;var_0D++)
			{
				if(nodesvisible(self.var_AECF[var_0D].var_205,var_1C,1))
				{
					var_1D = scripts\common\utility::array_add(var_1D,self.var_AECF[var_0D]);
				}
			}

			self botclearscriptgoal();
			self botsetscriptgoalnode(var_1C,"critical");
			childthread func_B95A();
			var_1E = scripts\mp\bots\_bots_util::func_2ECB(undefined,"cautious_approach_early_out");
			self notify("stop_cautious_approach_early_out_monitor");
			if(var_1E == "cautious_approach_early_out")
			{
				break;
			}

			if(var_1E == "goal")
			{
				for(var_0D = 0;var_0D < var_1D.size;var_0D++)
				{
					var_1F = 0;
					while(var_1D[var_0D].var_735E < 18 && var_1F < 3.6)
					{
						self botlookatpoint(var_1D[var_0D].origin + (0,0,self getplayerviewheight()),0.25,"script_search");
						wait(0.25);
						var_1F = var_1F + 0.25;
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
		self botsetscriptgoalnode(var_01,var_15,var_17);
		return;
	}

	self botsetscriptgoal(self.var_4B0E,var_16,var_15,var_17);
}

//Function Number: 20
func_B95A()
{
	self endon("cautious_approach_early_out");
	self endon("stop_cautious_approach_early_out_monitor");
	var_00 = undefined;
	if(isdefined(self.var_2D55))
	{
		var_00 = self.var_2D55 * self.var_2D55;
	}
	else if(isdefined(self.var_2D53))
	{
		var_01 = func_2D2D();
		var_00 = var_01 * var_01;
	}

	wait(0.05);
	for(;;)
	{
		if(distancesquared(self.origin,self.var_2D52) < var_00)
		{
			self notify("cautious_approach_early_out");
		}

		wait(0.05);
	}
}

//Function Number: 21
func_B959()
{
	self endon("stop_location_monitoring");
	var_00 = 10000;
	for(;;)
	{
		var_01 = self getnearestnode();
		if(isdefined(var_01))
		{
			var_02 = self botgetfovdot();
			for(var_03 = 0;var_03 < self.var_AECF.size;var_03++)
			{
				if(nodesvisible(var_01,self.var_AECF[var_03].var_205,1))
				{
					var_04 = scripts\common\utility::func_13D90(self.origin,self.angles,self.var_AECF[var_03].origin,var_02);
					var_05 = !var_04 || self.var_AECF[var_03].var_735E < 17;
					if(var_05 && distancesquared(self.origin,self.var_AECF[var_03].origin) < var_00)
					{
						var_04 = 1;
						self.var_AECF[var_03].var_735E = 18;
					}

					if(var_04)
					{
						self.var_AECF[var_03].var_735E++;
						if(self.var_AECF[var_03].var_735E >= 18)
						{
							self.var_AECF[var_03] = self.var_AECF[self.var_AECF.size - 1];
							self.var_AECF[self.var_AECF.size - 1] = undefined;
							var_03--;
						}
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 22
func_DAA4()
{
	self notify("protect_watch_allies");
	self endon("protect_watch_allies");
	var_00 = [];
	var_01 = 1050;
	var_02 = var_01 * var_01;
	var_03 = 900;
	if(isdefined(level.var_DAA3))
	{
		var_03 = level.var_DAA3;
	}

	for(;;)
	{
		var_04 = gettime();
		var_05 = func_2DB7(self.var_2D52,var_03);
		foreach(var_07 in var_05)
		{
			var_08 = var_07.var_6640;
			if(!isdefined(var_08))
			{
				var_08 = var_07 getentitynumber();
			}

			if(!isdefined(var_00[var_08]))
			{
				var_00[var_08] = var_04 - 1;
			}

			if(!isdefined(var_07.var_A8D4))
			{
				var_07.var_A8D4 = var_04 - 10001;
			}

			if(var_07.health == 0 && isdefined(var_07.var_4E72) && var_04 - var_07.var_4E72 < 5000)
			{
				if(var_04 - var_07.var_A8D4 > 10000 && var_04 > var_00[var_08])
				{
					if(isdefined(var_07.var_1B1) && isdefined(var_07.var_1B1.team) && var_07.var_1B1.team == scripts\common\utility::func_7984(self.team))
					{
						if(distancesquared(var_07.origin,self.origin) < var_02)
						{
							self botgetimperfectenemyinfo(var_07.var_1B1,var_07.origin);
							var_09 = getclosestnodeinsight(var_07.origin);
							if(isdefined(var_09))
							{
								self.var_5090 = var_09.origin;
								self notify("defend_force_node_recalculation");
							}

							var_07.var_A8D4 = var_04;
						}

						var_00[var_08] = var_04 + 10000;
					}
				}
			}
		}

		wait(randomint(5) + 1 * 0.05);
	}
}

//Function Number: 23
func_508F()
{
	if(isdefined(self.var_5091))
	{
		return self.var_5091;
	}

	if(scripts\mp\bots\_bots_util::func_2DD5())
	{
		var_00 = func_2D4B(self.var_4B0F);
		if(var_00.size == 0 && !isdefined(self.var_5060))
		{
			var_00 = findentrances(self.origin);
		}

		return var_00;
	}

	if(scripts\mp\bots\_bots_util::func_2DDD() || scripts\mp\bots\_bots_util::func_2DD4())
	{
		var_00 = findentrances(self.origin);
		return var_00;
	}
}

//Function Number: 24
func_5097()
{
	self notify("defense_watch_entrances_at_goal");
	self endon("defense_watch_entrances_at_goal");
	self endon("new_defend_goal");
	self endon("script_goal_changed");
	var_00 = self getnearestnode();
	var_01 = undefined;
	if(scripts\mp\bots\_bots_util::func_2DD5())
	{
		var_02 = func_508F();
		var_01 = [];
		if(isdefined(var_00))
		{
			foreach(var_04 in var_02)
			{
				if(nodesvisible(var_00,var_04,1))
				{
					var_01 = scripts\common\utility::array_add(var_01,var_04);
				}
			}
		}
	}
	else if(scripts\mp\bots\_bots_util::func_2DDD() || scripts\mp\bots\_bots_util::func_2DD4())
	{
		var_01 = func_508F();
		if(isdefined(var_00) && !issubstr(self getcurrentweapon(),"riotshield"))
		{
			if(!scripts\mp\_utility::func_9FB3(var_00.ishacknode) && !scripts\mp\_utility::func_9FB3(self.var_C031.ishacknode))
			{
				if(nodesvisible(var_00,self.var_C031,1))
				{
					var_01 = scripts\common\utility::array_add(var_01,self.var_C031);
				}
			}
		}
	}

	if(isdefined(var_01))
	{
		childthread scripts\mp\bots\_bots_util::func_2ED4(var_01);
		if(scripts\mp\bots\_bots_util::func_2DD4())
		{
			childthread func_2E23();
			return;
		}

		childthread func_2E22();
	}
}

//Function Number: 25
func_2E22()
{
	self notify("bot_monitor_watch_entrances_at_goal");
	self endon("bot_monitor_watch_entrances_at_goal");
	self notify("bot_monitor_watch_entrances");
	self endon("bot_monitor_watch_entrances");
	while(!isdefined(self.var_1395E))
	{
		wait(0.05);
	}

	var_00 = level.var_2D9E["get_watch_node_chance"];
	for(;;)
	{
		foreach(var_02 in self.var_1395E)
		{
			if(var_02 == self.var_C031)
			{
				var_02.var_1395D[self.var_6640] = 0.8;
				continue;
			}

			var_02.var_1395D[self.var_6640] = 1;
		}

		var_04 = isdefined(var_00);
		if(!var_04)
		{
			func_D924(0.5);
		}

		foreach(var_02 in self.var_1395E)
		{
			if(var_04)
			{
				var_06 = self [[ var_00 ]](var_02);
				var_02.var_1395D[self.var_6640] = var_02.var_1395D[self.var_6640] * var_06;
			}

			if(func_6656(var_02))
			{
				var_02.var_1395D[self.var_6640] = var_02.var_1395D[self.var_6640] * 0.5;
			}
		}

		wait(randomfloatrange(0.5,0.75));
	}
}

//Function Number: 26
func_2E23()
{
	self notify("bot_monitor_watch_entrances_bodyguard");
	self endon("bot_monitor_watch_entrances_bodyguard");
	self notify("bot_monitor_watch_entrances");
	self endon("bot_monitor_watch_entrances");
	while(!isdefined(self.var_1395E))
	{
		wait(0.05);
	}

	for(;;)
	{
		var_00 = anglestoforward(self.var_2D4D.angles) * (1,1,0);
		var_00 = vectornormalize(var_00);
		foreach(var_02 in self.var_1395E)
		{
			var_02.var_1395D[self.var_6640] = 1;
			var_03 = var_02.origin - self.var_2D4D.origin;
			var_03 = vectornormalize(var_03);
			var_04 = vectordot(var_00,var_03);
			if(var_04 > 0.6)
			{
				var_02.var_1395D[self.var_6640] = var_02.var_1395D[self.var_6640] * 0.33;
			}
			else if(var_04 > 0)
			{
				var_02.var_1395D[self.var_6640] = var_02.var_1395D[self.var_6640] * 0.66;
			}

			if(!func_6654(var_02))
			{
				var_02.var_1395D[self.var_6640] = var_02.var_1395D[self.var_6640] * 0.5;
			}
		}

		wait(randomfloatrange(0.4,0.6));
	}
}

//Function Number: 27
func_6654(param_00)
{
	var_01 = getnodezone(param_00);
	var_02 = vectornormalize(param_00.origin - self.origin);
	for(var_03 = 0;var_03 < level.var_13FBD;var_03++)
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

//Function Number: 28
func_D924(param_00)
{
	if(self.var_1395E.size <= 0)
	{
		return;
	}

	var_01 = self.var_1395E;
	for(var_02 = 0;var_02 < level.var_13FBD;var_02++)
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
				var_01[var_04].var_1395D[self.var_6640] = var_01[var_04].var_1395D[self.var_6640] * param_00;
				var_01[var_04] = var_01[var_01.size - 1];
				var_01[var_01.size - 1] = undefined;
				var_04--;
			}
		}
	}
}

//Function Number: 29
func_6656(param_00)
{
	var_01 = func_2DB6(self.var_2D52);
	foreach(var_03 in var_01)
	{
		if(func_6657(var_03,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 30
func_6657(param_00,param_01)
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

//Function Number: 31
func_2DB6(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		if(isdefined(level.var_DAA3))
		{
			param_01 = level.var_DAA3;
		}
		else
		{
			param_01 = 900;
		}
	}

	var_02 = [];
	var_03 = func_2DB7(param_00,param_01);
	foreach(var_05 in var_03)
	{
		if(!isai(var_05) || var_05 scripts\mp\bots\_bots_util::func_2DD8(param_00))
		{
			var_02 = scripts\common\utility::array_add(var_02,var_05);
		}
	}

	return var_02;
}

//Function Number: 32
func_2DB7(param_00,param_01)
{
	var_02 = param_01 * param_01;
	var_03 = [];
	for(var_04 = 0;var_04 < level.var_C928.size;var_04++)
	{
		var_05 = level.var_C928[var_04];
		if(var_05 != self && isdefined(var_05.team) && var_05.team == self.team && scripts\mp\_utility::func_9F9D(var_05))
		{
			if(distancesquared(param_00,var_05.origin) < var_02)
			{
				var_03 = scripts\common\utility::array_add(var_03,var_05);
			}
		}
	}

	return var_03;
}

//Function Number: 33
func_508D()
{
	level endon("game_ended");
	self endon("started_bot_defend_think");
	self endon("defend_stop");
	self endon("disconnect");
	self waittill("death");
	if(isdefined(self))
	{
		thread func_2D4E();
	}
}

//Function Number: 34
func_2D4E()
{
	self notify("defend_stop");
	self.var_2D51 = undefined;
	self.var_2D52 = undefined;
	self.var_2D55 = undefined;
	self.var_2D53 = undefined;
	self.var_2D57 = undefined;
	self.var_2D56 = undefined;
	self.var_2D54 = undefined;
	self.var_2D4D = undefined;
	self.var_5092 = undefined;
	self.var_C031 = undefined;
	self.var_5090 = undefined;
	self.var_508E = undefined;
	self.var_D888 = undefined;
	self.var_4B0D = undefined;
	self.var_4B0C = undefined;
	self.var_4B0E = undefined;
	self.var_5060 = undefined;
	self.var_5091 = undefined;
	self botclearscriptgoal();
	self botsetstance("none");
}

//Function Number: 35
func_5064(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_C928)
	{
		if(!isdefined(var_03.team))
		{
			continue;
		}

		if(var_03.team == self.team && var_03 != self && isai(var_03) && var_03 scripts\mp\bots\_bots_util::func_2DD7() && var_03.var_4B0F == param_00)
		{
			if(var_03.var_2D57 == self.var_2D57 && scripts\mp\bots\_bots_util::func_2DD8(var_03.var_2D52))
			{
				var_01 = scripts\common\utility::array_add(var_01,var_03);
			}
		}
	}

	return var_01;
}

//Function Number: 36
func_B962()
{
	var_00 = 0;
	var_01 = 175;
	var_02 = self.var_2D4D.origin;
	var_03 = 0;
	var_04 = 0;
	for(;;)
	{
		if(!isdefined(self.var_2D4D))
		{
			thread func_2D4E();
		}

		self.var_2D52 = self.var_2D4D.origin;
		self.var_C031 = self.var_2D4D getnearestnode();
		if(!isdefined(self.var_C031))
		{
			self.var_C031 = self getnearestnode();
		}

		if(self botgetscriptgoaltype() != "none")
		{
			var_05 = self botgetscriptgoal();
			var_06 = self.var_2D4D getvelocity();
			var_07 = lengthsquared(var_06);
			if(var_07 > 100)
			{
				var_00 = 0;
				if(distancesquared(var_02,self.var_2D4D.origin) > var_01 * var_01)
				{
					var_02 = self.var_2D4D.origin;
					var_04 = 1;
					var_08 = vectornormalize(var_05 - self.var_2D4D.origin);
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
					var_02 = self.var_2D4D.origin;
					var_04 = 0;
				}

				if(var_00 > 0.5)
				{
					var_0A = distancesquared(var_05,self.var_2D52);
					if(var_0A > self.var_2D55 * self.var_2D55)
					{
						self notify("defend_force_node_recalculation");
						wait(0.25);
					}
				}
			}

			var_03 = var_07;
			if(abs(self.var_2D4D.origin[2] - var_05[2]) >= 50)
			{
				self notify("defend_force_node_recalculation");
				wait(0.25);
			}
		}

		wait(0.05);
	}
}

//Function Number: 37
func_6C87()
{
	var_00 = func_2D4C();
	var_01 = scripts\mp\bots\_bots_util::func_2D78(scripts\mp\bots\_bots_util::func_507A(),self.var_2D55,var_00);
	if(isdefined(var_01))
	{
		if(isdefined(var_00))
		{
			var_02 = vectornormalize(var_00 - var_01.origin);
			self.var_4B0C = vectortoangles(var_02);
		}
		else
		{
			var_03 = vectornormalize(var_01.origin - scripts\mp\bots\_bots_util::func_507A());
			self.var_4B0C = vectortoangles(var_03);
		}

		self.var_4B0D = var_01;
		return;
	}

	if(isdefined(var_00))
	{
		func_2DC2(var_00,undefined);
		return;
	}

	func_2DC2(undefined,scripts\mp\bots\_bots_util::func_507A());
}

//Function Number: 38
func_6C88()
{
	var_00 = func_2D4C();
	var_01 = scripts\mp\bots\_bots_util::func_2D79(self.var_2D53,var_00);
	if(isdefined(var_01))
	{
		if(isdefined(var_00))
		{
			var_02 = vectornormalize(var_00 - var_01.origin);
			self.var_4B0C = vectortoangles(var_02);
		}
		else
		{
			var_03 = vectornormalize(var_01.origin - scripts\mp\bots\_bots_util::func_507A());
			self.var_4B0C = vectortoangles(var_03);
		}

		self.var_4B0D = var_01;
		return;
	}

	if(isdefined(var_00))
	{
		func_2DC2(var_00,undefined);
		return;
	}

	func_2DC2(undefined,scripts\mp\bots\_bots_util::func_507A());
}

//Function Number: 39
func_6C8A()
{
	var_00 = scripts\mp\bots\_bots_util::func_2D77(scripts\mp\bots\_bots_util::func_507A(),self.var_2D55);
	if(isdefined(var_00))
	{
		var_01 = vectornormalize(scripts\mp\bots\_bots_util::func_507A() - var_00.origin);
		self.var_4B0C = vectortoangles(var_01);
		self.var_4B0D = var_00;
		return;
	}

	func_2DC2(scripts\mp\bots\_bots_util::func_507A(),undefined);
}

//Function Number: 40
func_6C86()
{
	var_00 = scripts\mp\bots\_bots_util::func_2D7A(scripts\mp\bots\_bots_util::func_507A(),self.var_2D55);
	if(isdefined(var_00))
	{
		self.var_4B0D = var_00;
		return;
	}

	var_01 = self getnearestnode();
	if(isdefined(var_01))
	{
		self.var_4B0D = var_01;
		return;
	}

	self.var_4B0E = self.origin;
}

//Function Number: 41
func_6C89()
{
	var_00 = undefined;
	var_01 = self method_8533();
	var_02 = getnodesinradius(scripts\mp\bots\_bots_util::func_507A(),self.var_2D55,0,520,"path",var_01);
	if(isdefined(var_02) && var_02.size > 0)
	{
		var_00 = self botnodepick(var_02,1 + var_02.size * 0.5,"node_traffic");
	}

	if(isdefined(var_00))
	{
		self.var_4B0D = var_00;
		return;
	}

	func_2DC2(undefined,scripts\mp\bots\_bots_util::func_507A());
}

//Function Number: 42
func_2DC2(param_00,param_01)
{
	if(self.var_2D57 == "capture_zone")
	{
		self.var_4B0E = scripts\mp\bots\_bots_util::func_2E49(scripts\mp\bots\_bots_util::func_507A(),self.var_2D53,::func_2D2A);
	}
	else
	{
		self.var_4B0E = scripts\mp\bots\_bots_util::func_2E4A(scripts\mp\bots\_bots_util::func_507A(),self.var_2D55,::func_2D2A,0.15,0.9);
	}

	if(isdefined(param_00))
	{
		var_02 = vectornormalize(param_00 - self.var_4B0E);
		self.var_4B0C = vectortoangles(var_02);
		return;
	}

	if(isdefined(param_01))
	{
		var_02 = vectornormalize(self.var_4B0E - param_01);
		self.var_4B0C = vectortoangles(var_02);
	}
}

//Function Number: 43
func_2D2A(param_00)
{
	if(func_2D2F(param_00,1,1,1))
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
func_2D2F(param_00,param_01,param_02,param_03)
{
	for(var_04 = 0;var_04 < level.var_C928.size;var_04++)
	{
		var_05 = level.var_C928[var_04];
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

//Function Number: 45
func_2D2D()
{
	var_00 = 0;
	if(isdefined(self.var_2D53))
	{
		foreach(var_02 in self.var_2D53)
		{
			var_03 = distance(self.var_2D52,var_02.origin);
			var_00 = max(var_03,var_00);
		}
	}

	return var_00;
}

//Function Number: 46
func_2EB8()
{
	self notify("bot_think_tactical_goals");
	self endon("bot_think_tactical_goals");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self.var_113D0 = [];
	for(;;)
	{
		if(self.var_113D0.size > 0 && !scripts\mp\bots\_bots_util::func_2DE0())
		{
			var_00 = self.var_113D0[0];
			if(!isdefined(var_00.var_151D))
			{
				self notify("start_tactical_goal");
				if(isdefined(var_00.var_10D46))
				{
					self [[ var_00.var_10D46 ]](var_00);
				}

				childthread func_13956(var_00);
				var_01 = "tactical";
				if(isdefined(var_00.var_8430))
				{
					var_01 = var_00.var_8430;
				}

				self botsetscriptgoal(var_00.var_842B,var_00.var_842C,var_01,var_00.var_159,var_00.var_C293);
				var_02 = scripts\mp\bots\_bots_util::func_2ECB(undefined,"stop_tactical_goal");
				self notify("stop_goal_aborted_watch");
				if(var_02 == "goal")
				{
					if(isdefined(var_00.var_157C))
					{
						self [[ var_00.var_157C ]](var_00);
					}
				}

				if(var_02 != "script_goal_changed")
				{
					self botclearscriptgoal();
				}

				if(isdefined(var_00.var_6302))
				{
					self [[ var_00.var_6302 ]](var_00);
				}
			}

			self.var_113D0 = scripts\common\utility::func_22A9(self.var_113D0,var_00);
		}

		wait(0.05);
	}
}

//Function Number: 47
func_13956(param_00)
{
	self endon("stop_tactical_goal");
	self endon("stop_goal_aborted_watch");
	wait(0.05);
	for(;;)
	{
		if(isdefined(param_00.var_151D) || isdefined(param_00.var_FF0D) && self [[ param_00.var_FF0D ]](param_00))
		{
			self notify("stop_tactical_goal");
		}

		wait(0.05);
	}
}

//Function Number: 48
func_2E27(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.type = param_00;
	var_04.var_842B = param_01;
	if(isdefined(self.var_C550))
	{
		if(!scripts\common\utility::func_2286(self.var_C550,param_00))
		{
			return;
		}
	}

	var_04.priority = param_02;
	var_04.var_C270 = param_03.var_C270;
	var_04.var_8430 = param_03.var_EDCA;
	var_04.var_159 = param_03.var_EDCC;
	var_04.var_842C = 0;
	if(isdefined(param_03.var_EDC9))
	{
		var_04.var_842C = param_03.var_EDC9;
	}

	var_04.var_10D46 = param_03.var_10D46;
	var_04.var_6302 = param_03.var_6302;
	var_04.var_FF0D = param_03.var_FF0D;
	var_04.var_157C = param_03.var_157C;
	var_04.var_C293 = param_03.var_C293;
	for(var_05 = 0;var_05 < self.var_113D0.size;var_05++)
	{
		if(var_04.priority > self.var_113D0[var_05].priority)
		{
			break;
		}
	}

	for(var_06 = self.var_113D0.size - 1;var_06 >= var_05;var_06--)
	{
		self.var_113D0[var_06 + 1] = self.var_113D0[var_06];
	}

	self.var_113D0[var_05] = var_04;
}

//Function Number: 49
func_2DC5(param_00,param_01)
{
	if(!isdefined(self.var_113D0))
	{
		return 0;
	}

	if(isdefined(param_00))
	{
		foreach(var_03 in self.var_113D0)
		{
			if(var_03.type == param_00)
			{
				if(isdefined(param_01) && isdefined(var_03.var_C270))
				{
					return var_03.var_C270 == param_01;
				}
				else
				{
					return 1;
				}
			}
		}

		return 0;
	}

	return self.var_113D0.size > 0;
}

//Function Number: 50
func_2D02(param_00,param_01)
{
	if(!isdefined(self.var_113D0))
	{
		return;
	}

	foreach(var_03 in self.var_113D0)
	{
		if(var_03.type == param_00)
		{
			if(isdefined(param_01))
			{
				if(isdefined(var_03.var_C270) && var_03.var_C270 == param_01)
				{
					var_03.var_151D = 1;
				}

				continue;
			}

			var_03.var_151D = 1;
		}
	}
}

//Function Number: 51
func_2D5C()
{
	self.var_C550[0] = "map_interactive_object";
	foreach(var_01 in self.var_113D0)
	{
		if(var_01.type != "map_interactive_object")
		{
			var_01.var_151D = 1;
		}
	}
}

//Function Number: 52
func_2D69()
{
	self.var_C550 = undefined;
}

//Function Number: 53
func_2E1E()
{
	var_00 = gettime();
	if(!isdefined(self.var_A8E5) || var_00 - self.var_A8E5 > 1000)
	{
		self.var_A8E5 = var_00;
		var_01 = func_2DA3("tacticalinsertion");
		if(!isdefined(var_01))
		{
			return 0;
		}

		if(isdefined(self.var_10C) && self botcanseeentity(self.var_10C))
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

		var_04 = self method_8533();
		var_05 = getnodesinradius(self.origin,500,0,999,"path",var_04);
		if(var_05.size <= 0)
		{
			return 0;
		}

		var_06 = self botnodepick(var_05,var_05.size * 0.15,"node_hide");
		if(!isdefined(var_06))
		{
			return 0;
		}

		return func_2E7E(var_01,undefined,undefined,undefined,var_06);
	}

	return 0;
}