/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_assault.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 2237 ms
 * Timestamp: 10/27/2023 12:11:49 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	func_2E6D();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["crate_can_use"] = ::func_4830;
	level.var_2D9E["gametype_think"] = ::func_2E6E;
	level.var_2D9E["should_start_cautious_approach"] = ::func_FF9C;
	level.var_2D9E["know_enemies_on_start"] = undefined;
	level.var_2D9E["notify_enemy_bots_bomb_used"] = ::func_C132;
}

//Function Number: 3
func_2E6D()
{
	func_F8DF();
}

//Function Number: 4
func_4830(param_00)
{
	if(isagent(self) && !isdefined(param_00.var_2F33))
	{
		return 0;
	}

	if(isdefined(param_00.var_485F) && !scripts\mp\bots\_bots_killstreaks::func_2DDB(param_00.var_485F))
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9F9D(self))
	{
		return 1;
	}

	if(!isdefined(self.var_E67C))
	{
		return 0;
	}

	switch(self.var_E67C)
	{
		case "investigate_someone_using_bomb":
		case "bomb_defuser":
		case "atk_bomber":
			return 0;
	}

	return 1;
}

//Function Number: 5
func_F8DF()
{
	level.var_2EEE = 1;
	level.var_9826 = 3000;
	scripts\mp\bots\_bots_strategy::func_2E86();
	scripts\mp\bots\_bots_util::func_2ECA(1);
	level.var_2E6C = [];
	level.var_2E6C["axis"] = [];
	level.var_2E6C["allies"] = [];
	level.var_2D4A["atk_bomber"] = ::func_2415;
	level.var_2D4A["clear_target_zone"] = ::func_4185;
	level.var_2D4A["defend_planted_bomb"] = ::func_5072;
	level.var_2D4A["bomb_defuser"] = ::func_2C45;
	level.var_2D4A["investigate_someone_using_bomb"] = ::func_9B2A;
	level.var_2D4A["camp_bomb"] = ::func_37E6;
	level.var_2D4A["defender"] = ::func_5086;
	level.var_2D4A["backstabber"] = ::func_2735;
	level.var_2D4A["random_killer"] = ::func_DC8E;
	var_00 = 0;
	function_002B(level.var_4B19,game["defenders"]);
}

//Function Number: 6
func_2E6E()
{
	self notify("bot_sd_think");
	self endon("bot_sd_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.var_2DA1))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	self botsetflag("grenade_objectives",1);
	self botsetflag("use_obj_path_style",1);
	var_00 = game["attackers"];
	var_01 = 1;
	if(isdefined(level.var_F013) && isdefined(level.var_F013.carrier) && level.var_F013.carrier == self && isdefined(self.var_E67C) && self.var_E67C == "atk_bomber")
	{
		var_01 = 0;
	}

	if(var_01)
	{
		self.var_E67C = undefined;
	}

	self.var_112FD = undefined;
	self.var_8BAF = 0;
	self.var_2414 = 0;
	self.var_EF69 = undefined;
	self.var_5085 = undefined;
	self.var_50A8 = 0;
	if(!isdefined(level.var_981C) && !level.var_BDC1)
	{
		level.var_981C = level.var_F013.var_4B2C;
		level.var_981D = getclosestnodeinsight(level.var_F013.var_4B2C);
	}

	if(self.team == var_00 && !isdefined(level.var_382E))
	{
		var_02 = 0;
		if(!level.var_BDC1)
		{
			var_03 = func_7AA1(var_00);
			foreach(var_05 in var_03)
			{
				if(!isai(var_05))
				{
					var_02 = 1;
				}
			}
		}

		if(var_02)
		{
			var_07 = 6000;
			level.var_382E = gettime() + var_07;
			badplace_cylinder("bomb",var_07 / 1000,level.var_F013.var_4B2C,75,300,var_00);
		}
	}

	for(;;)
	{
		wait(randomintrange(1,3) * 0.05);
		if(self.health <= 0)
		{
			continue;
		}

		self.var_8BAF = 1;
		if(!isdefined(self.var_E67C))
		{
			func_9871();
		}

		if(isdefined(self.var_112FD))
		{
			continue;
		}

		if(self.team == var_00)
		{
			if(!level.var_BDC1 && isdefined(level.var_382E) && gettime() < level.var_382E && !isdefined(level.var_F013.carrier))
			{
				if(!scripts\mp\bots\_bots_util::func_2DD8(level.var_F013.var_4B2C))
				{
					var_08 = getclosestnodeinsight(level.var_F013.var_4B2C);
					if(isdefined(var_08))
					{
						var_09["nearest_node_to_center"] = var_08;
						scripts\mp\bots\_bots_strategy::func_2E57(level.var_F013.var_4B2C,900,var_09);
					}
					else
					{
						level.var_382E = gettime();
					}
				}
			}
			else
			{
				self [[ level.var_2D4A[self.var_E67C] ]]();
			}

			continue;
		}

		if(level.var_2C5C)
		{
			if(distancesquared(self.origin,level.var_F014.origin) > squared(level.var_DAA3 * 2))
			{
				if(!isdefined(self.var_5085))
				{
					self.var_5085 = 1;
					self method_804F("scripted");
				}
			}
			else if(isdefined(self.var_5085) && !isdefined(self.var_EF69))
			{
				self.var_5085 = undefined;
				self method_804F(undefined);
			}
		}

		if(level.var_2C5C && isdefined(level.var_2C44) && self.var_E67C != "bomb_defuser")
		{
			if(!scripts\mp\bots\_bots_util::func_2DD8(level.var_F014.origin))
			{
				self botclearscriptgoal();
				scripts\mp\bots\_bots_strategy::func_2E57(level.var_F014.origin,level.var_DAA3);
			}

			continue;
		}

		self [[ level.var_2D4A[self.var_E67C] ]]();
	}
}

//Function Number: 7
func_2415()
{
	self endon("new_role");
	if(scripts\mp\bots\_bots_util::func_2DD7())
	{
		scripts\mp\bots\_bots_strategy::func_2D4E();
	}

	if(isdefined(level.var_F013) && isdefined(level.var_F013.carrier) && isalive(level.var_F013.carrier) && level.var_F013.carrier != self)
	{
		wait(0.7);
	}

	if(!self.var_9D6C && !level.var_BDC1)
	{
		if(isdefined(level.var_F013))
		{
			if(!isdefined(self.var_A88D))
			{
				self.var_A88D = level.var_F013.var_4B2C;
			}

			if(distancesquared(self.var_A88D,level.var_F013.var_4B2C) > 4)
			{
				self botclearscriptgoal();
				self.var_A88D = level.var_F013.var_4B2C;
			}
		}

		if(self.var_2414 >= 2)
		{
			var_01 = getnodesinradiussorted(level.var_F013.var_4B2C,512,0);
			var_02 = undefined;
			foreach(var_04 in var_01)
			{
				if(!var_04 method_821B())
				{
					var_02 = var_04;
					break;
				}
			}

			if(isdefined(var_02))
			{
				self botsetscriptgoal(var_02.origin,20,"critical");
				scripts\mp\bots\_bots_util::func_2ECB();
				if(isdefined(level.var_F013) && !isdefined(level.var_F013.carrier))
				{
					level.var_F013 scripts\mp\_gameobjects::func_F7E8(self);
				}
			}
			else
			{
			}

			return;
		}

		if(!self bothasscriptgoal())
		{
			var_06 = 15;
			var_07 = 32;
			var_08 = scripts\mp\bots\_bots_util::func_2E58("BotGetClosestNavigablePoint",::scripts\mp\bots\_bots_util::func_74C3,level.var_F013.var_4B2C,var_06 + var_07,self);
			if(isdefined(var_08))
			{
				var_09 = self botsetscriptgoal(level.var_F013.var_4B2C,0,"critical");
				if(var_09)
				{
					childthread func_2C52();
					return;
				}

				return;
			}

			var_01 = getnodesinradiussorted(level.var_F013.var_4B2C,512,0);
			if(var_08.size > 0)
			{
				self botsetscriptgoal(var_08[0].origin,0,"critical");
				scripts\mp\bots\_bots_util::func_2ECB();
			}

			if(isdefined(level.var_F013) && !isdefined(level.var_F013.carrier))
			{
				var_07 = scripts\mp\bots\_bots_util::func_2E58("BotGetClosestNavigablePoint",::scripts\mp\bots\_bots_util::func_74C3,level.var_F013.var_4B2C,var_05 + var_06,self);
				if(!isdefined(var_07))
				{
					level.var_F013 scripts\mp\_gameobjects::func_F7E8(self);
					return;
				}

				return;
			}

			return;
		}

		return;
	}

	if(isdefined(self.var_5949) && gettime() < self.var_5949)
	{
		return;
	}

	if(!isdefined(level.var_2C47))
	{
		level.var_2C47 = level.var_4B19;
	}

	var_0A = level.var_2C47;
	self.var_2C79 = var_0A;
	if(!isdefined(level.var_981E) || gettime() - level.var_981E < level.var_9826)
	{
		level.var_981E = gettime() + level.var_9826;
		self botclearscriptgoal();
		self botsetscriptgoal(self.origin,0,"tactical");
		wait(level.var_9826 / 1000);
	}

	self botclearscriptgoal();
	if(level.var_24B1 == "rush")
	{
		self method_804F("scripted");
		var_0B = self method_8045(var_0A.var_2EFE,"node_exposed");
		var_0C = self botgetdifficultysetting("strategyLevel") * 0.45;
		var_0D = self botgetdifficultysetting("strategyLevel") + 1 * 0.15;
		foreach(var_0E in var_0A.var_2EFE)
		{
			if(!scripts\common\utility::func_2286(var_0A,var_0E))
			{
				var_0A[var_0A.size] = var_0E;
			}
		}

		if(randomfloat(1) < var_0B)
		{
			var_10 = var_0A[0];
		}
		else if(randomfloat(1) < var_0D)
		{
			var_10 = var_0B[1];
		}
		else
		{
			var_10 = scripts\common\utility::random(var_0B);
		}

		self botsetscriptgoal(var_10.origin,0,"critical");
	}

	var_11 = scripts\mp\bots\_bots_util::func_2ECB();
	if(var_11 == "goal")
	{
		var_12 = func_7C21() - gettime();
		var_13 = var_12 - level.var_CC52 * 2 * 1000;
		var_14 = gettime() + var_13;
		if(var_13 > 0)
		{
			scripts\mp\bots\_bots_util::func_2ECC(var_13);
		}

		var_15 = gettime() >= var_14;
		var_16 = func_F008(level.var_CC52 + 2,"bomb_planted",var_15);
		self botclearscriptgoal();
		if(var_16)
		{
			scripts\mp\bots\_bots_strategy::func_2D69();
			func_2E84("defend_planted_bomb");
			return;
		}

		if(var_13 > 5000)
		{
			self.var_5949 = gettime() + 5000;
			return;
		}

		return;
	}
}

//Function Number: 8
func_7C21()
{
	if(level.var_2C5C)
	{
		return level.var_50A7;
	}

	return gettime() + scripts\mp\_gamelogic::func_81CD();
}

//Function Number: 9
func_2C52()
{
	self notify("bomber_monitor_no_path");
	self endon("death");
	self endon("disconnect");
	self endon("goal");
	self endon("bomber_monitor_no_path");
	level.var_F013 endon("pickup_object");
	for(;;)
	{
		self waittill("no_path");
		self.var_2414++;
	}
}

//Function Number: 10
func_4185()
{
	self endon("new_role");
	if(isdefined(level.var_2413))
	{
		if(level.var_24B1 == "rush")
		{
			if(!isdefined(self.var_F41C))
			{
				if(!level.var_BDC1)
				{
					var_00["nearest_node_to_center"] = level.var_981D;
					scripts\mp\bots\_bots_strategy::func_2E57(level.var_981C,900,var_00);
					wait(randomfloatrange(0,4));
					scripts\mp\bots\_bots_strategy::func_2D4E();
				}

				self.var_F41C = 1;
			}

			if(self botgetdifficultysetting("strategyLevel") > 0)
			{
				func_F3B9();
			}

			if(isai(level.var_2413) && isdefined(level.var_2413.var_2C79))
			{
				var_01 = level.var_2413.var_2C79;
			}
			else if(isdefined(level.var_2C47))
			{
				var_01 = level.var_2C47;
			}
			else
			{
				var_01 = func_6C80(level.var_2413);
			}

			if(!scripts\mp\bots\_bots_util::func_2DD8(var_01.var_4B2C))
			{
				var_01["min_goal_time"] = 2;
				var_01["max_goal_time"] = 4;
				var_01["override_origin_node"] = scripts\common\utility::random(var_01.var_2EFE);
				scripts\mp\bots\_bots_strategy::func_2E57(var_01.var_4B2C,level.var_DAA3,var_01);
				return;
			}
		}
	}
}

//Function Number: 11
func_5072()
{
	self endon("new_role");
	if(level.var_2C5C)
	{
		if(level.var_24B1 == "rush")
		{
			func_552D();
		}

		if(!scripts\mp\bots\_bots_util::func_2DD8(level.var_F014.origin))
		{
			scripts\mp\bots\_bots_strategy::func_2E57(level.var_F014.origin,level.var_DAA3);
		}
	}
}

//Function Number: 12
func_2C45()
{
	self endon("new_role");
	if(level.var_2C4A)
	{
		return;
	}

	var_00 = func_6CA5();
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = scripts\common\utility::func_782F(level.var_F014.origin,var_00.var_2EFE);
	var_02 = (level.var_F014.origin[0],level.var_F014.origin[1],var_01[0].origin[2]);
	var_03 = func_3BA0(var_02,undefined);
	if(!var_03)
	{
		return;
	}

	var_04 = scripts\mp\bots\_bots_util::func_2ECB();
	if(var_04 == "bad_path")
	{
		self.var_50A8++;
		if(self.var_50A8 >= 4)
		{
			for(;;)
			{
				var_05 = getnodesinradiussorted(var_02,50,0);
				var_06 = self.var_50A8 - 4;
				if(var_05.size <= var_06)
				{
					break;
				}

				self botsetscriptgoal(var_05[var_06].origin,20,"critical");
				var_04 = scripts\mp\bots\_bots_util::func_2ECB();
				if(var_04 == "bad_path")
				{
					self.var_50A8++;
					continue;
				}

				break;
			}
		}
	}

	if(var_04 == "goal")
	{
		var_07 = func_7C21() - gettime();
		var_08 = var_07 - level.var_50AB * 2 * 1000;
		var_09 = gettime() + var_08;
		if(var_08 > 0)
		{
			scripts\mp\bots\_bots_util::func_2ECC(var_08);
		}

		var_0A = gettime() >= var_09;
		func_F008(level.var_50AB + 2,"bomb_defused",var_0A);
		self botclearscriptgoal();
		scripts\mp\bots\_bots_strategy::func_2D69();
	}
}

//Function Number: 13
func_9B2A()
{
	self endon("new_role");
	if(scripts\mp\bots\_bots_util::func_2DD7())
	{
		scripts\mp\bots\_bots_strategy::func_2D4E();
	}

	var_00 = func_6C80(self);
	self botsetscriptgoalnode(scripts\common\utility::random(var_00.var_2EFE),"guard");
	var_01 = scripts\mp\bots\_bots_util::func_2ECB();
	if(var_01 == "goal")
	{
		wait(4);
		func_2E84(self.var_D88F);
	}
}

//Function Number: 14
func_37E6()
{
	self endon("new_role");
	if(isdefined(level.var_F013.carrier))
	{
		if(self.var_D88F == "defender")
		{
			self.var_5081 = func_6C80(self);
		}

		func_2E84(self.var_D88F);
		return;
	}

	if(!scripts\mp\bots\_bots_util::func_2DD8(level.var_F013.var_4B2C))
	{
		var_00["nearest_node_to_center"] = level.var_F013.var_BE7D;
		scripts\mp\bots\_bots_strategy::func_2E57(level.var_F013.var_4B2C,level.var_DAA3,var_00);
	}
}

//Function Number: 15
func_5086()
{
	self endon("new_role");
	if(!scripts\mp\bots\_bots_util::func_2DD8(self.var_5081.var_4B2C))
	{
		var_00["score_flags"] = "strict_los";
		var_00["override_origin_node"] = scripts\common\utility::random(self.var_5081.var_2EFE);
		scripts\mp\bots\_bots_strategy::func_2E57(self.var_5081.var_4B2C,level.var_DAA3,var_00);
	}
}

//Function Number: 16
func_2735()
{
	self endon("new_role");
	if(scripts\mp\bots\_bots_util::func_2DD7())
	{
		scripts\mp\bots\_bots_strategy::func_2D4E();
	}

	if(!isdefined(self.var_2734))
	{
		self.var_2734 = "1_move_to_midpoint";
	}

	if(self.var_2734 == "1_move_to_midpoint")
	{
		var_00 = level.var_2C7A[0].var_4B2C;
		var_01 = level.var_2C7A[1].var_4B2C;
		var_02 = (var_00[0] + var_01[0] * 0.5,var_00[1] + var_01[1] * 0.5,var_00[2] + var_01[2] * 0.5);
		var_03 = getnodesinradiussorted(var_02,512,0);
		if(var_03.size == 0)
		{
			func_2E84("random_killer");
			return;
		}

		var_04 = undefined;
		var_05 = int(var_03.size * var_03.size + 1 * 0.5);
		var_06 = randomint(var_05);
		for(var_07 = 0;var_07 < var_03.size;var_07++)
		{
			var_08 = var_03.size - var_07;
			if(var_06 < var_08)
			{
				var_04 = var_03[var_07];
				break;
			}

			var_06 = var_06 - var_08;
		}

		self method_804F("scripted");
		var_09 = self botsetscriptgoalnode(var_04,"guard");
		if(var_09)
		{
			var_0A = scripts\mp\bots\_bots_util::func_2ECB();
			if(var_0A == "goal")
			{
				wait(randomfloatrange(1,4));
				self.var_2734 = "2_move_to_enemy_spawn";
			}
		}
	}

	if(self.var_2734 == "2_move_to_enemy_spawn")
	{
		var_0B = scripts\mp\_spawnlogic::func_8140("mp_sd_spawn_attacker");
		var_0C = scripts\common\utility::random(var_0B);
		self method_804F("scripted");
		var_09 = self botsetscriptgoal(var_0C.origin,250,"guard");
		if(var_09)
		{
			var_0A = scripts\mp\bots\_bots_util::func_2ECB();
			if(var_0A == "goal")
			{
				self.var_2734 = "3_move_to_bombzone";
			}
		}
	}

	if(self.var_2734 == "3_move_to_bombzone")
	{
		if(!isdefined(self.var_2C70))
		{
			self.var_2C70 = randomint(level.var_2C7A.size);
		}

		self method_804F(undefined);
		var_09 = self botsetscriptgoal(scripts\common\utility::random(level.var_2C7A[self.var_2C70].var_2EFE).origin,160,"objective");
		if(var_09)
		{
			var_0A = scripts\mp\bots\_bots_util::func_2ECB();
			if(var_0A == "goal")
			{
				self botclearscriptgoal();
				self.var_2734 = "2_move_to_enemy_spawn";
				self.var_2C70 = 1 - self.var_2C70;
				return;
			}
		}
	}
}

//Function Number: 17
func_DC8E()
{
	self endon("new_role");
	if(scripts\mp\bots\_bots_util::func_2DD7())
	{
		scripts\mp\bots\_bots_strategy::func_2D4E();
	}

	self [[ self.var_CA7B ]]();
}

//Function Number: 18
func_F3B9()
{
	if(!isdefined(self.var_1D5C))
	{
		self botsetflag("force_sprint",1);
		self.var_1D5C = 1;
	}
}

//Function Number: 19
func_552D()
{
	if(isdefined(self.var_1D5C))
	{
		self botsetflag("force_sprint",0);
		self.var_1D5C = undefined;
	}
}

//Function Number: 20
func_F593()
{
	if(!isdefined(self.var_EF69))
	{
		self method_804F("scripted");
		self.var_EF69 = 1;
	}
}

//Function Number: 21
func_3BA0(param_00,param_01)
{
	var_02 = level.var_3A38;
	var_03["entrance_points_index"] = param_01;
	scripts\mp\bots\_bots_strategy::func_2D2B(param_00,var_02,var_03);
	wait(0.05);
	while(distancesquared(self.origin,param_00) > var_02 * var_02 && scripts\mp\bots\_bots_util::func_2DD7())
	{
		if(func_7C21() - gettime() < 20000)
		{
			func_F593();
			func_F3B9();
			break;
		}

		wait(0.05);
	}

	if(scripts\mp\bots\_bots_util::func_2DD7())
	{
		scripts\mp\bots\_bots_strategy::func_2D4E();
	}

	return self botsetscriptgoal(param_00,20,"critical");
}

//Function Number: 22
func_F008(param_00,param_01,param_02)
{
	var_03 = 0;
	if(self botgetdifficultysetting("strategyLevel") == 1)
	{
		var_03 = 40;
	}
	else if(self botgetdifficultysetting("strategyLevel") >= 2)
	{
		var_03 = 80;
	}

	if(randomint(100) < var_03)
	{
		self botsetstance("prone");
		wait(0.2);
	}

	if(self botgetdifficultysetting("strategyLevel") > 0 && !param_02)
	{
		thread func_C148();
		thread func_C13F();
	}

	self botpressbutton("use",param_00);
	var_04 = scripts\mp\bots\_bots_util::func_2EBE(param_00,param_01,"use_interrupted");
	self botsetstance("none");
	self method_8026("use");
	var_05 = var_04 == param_01;
	return var_05;
}

//Function Number: 23
func_C132(param_00)
{
	var_01 = func_7AA1(scripts\common\utility::func_7984(self.team),1);
	foreach(var_03 in var_01)
	{
		var_04 = 0;
		if(param_00 == "plant")
		{
			var_04 = 300 + var_03 botgetdifficultysetting("strategyLevel") * 100;
		}
		else if(param_00 == "defuse")
		{
			var_04 = 500 + var_03 botgetdifficultysetting("strategyLevel") * 500;
		}

		if(distancesquared(var_03.origin,self.origin) < squared(var_04))
		{
			var_03 func_2E84("investigate_someone_using_bomb");
		}
	}
}

//Function Number: 24
func_C148()
{
	var_00 = func_6C80(self);
	self waittill("bulletwhizby",var_01);
	if(!isdefined(var_01.team) || var_01.team != self.team)
	{
		var_02 = var_00.var_130EE - var_00.var_4B30;
		if(var_02 > 1000)
		{
			self notify("use_interrupted");
		}
	}
}

//Function Number: 25
func_C13F()
{
	self waittill("damage",var_00,var_01);
	if(!isdefined(var_01.team) || var_01.team != self.team)
	{
		self notify("use_interrupted");
	}
}

//Function Number: 26
func_FF9C(param_00)
{
	var_01 = 2000;
	var_02 = var_01 * var_01;
	if(param_00)
	{
		if(func_7C21() - gettime() < 15000)
		{
			return 0;
		}

		var_03 = 0;
		var_04 = scripts\common\utility::func_7984(self.team);
		foreach(var_06 in level.players)
		{
			if(!isdefined(var_06.team))
			{
				continue;
			}

			if(isalive(var_06) && var_06.team == var_04)
			{
				var_03 = 1;
			}
		}

		return var_03;
	}

	return distancesquared(self.origin,self.var_2D52) <= var_07 && self botpursuingscriptgoal();
}

//Function Number: 27
func_6C80(param_00)
{
	var_01 = undefined;
	var_02 = 999999999;
	foreach(var_04 in level.var_2C7A)
	{
		var_05 = distancesquared(var_04.var_4B2C,param_00.origin);
		if(var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 28
func_7BBF(param_00)
{
	var_01 = [];
	var_02 = func_7AA1(game["defenders"]);
	foreach(var_04 in var_02)
	{
		if(isai(var_04) && isdefined(var_04.var_E67C) && var_04.var_E67C == "defender")
		{
			if(isdefined(var_04.var_5081) && var_04.var_5081 == param_00)
			{
				var_01 = scripts\common\utility::array_add(var_01,var_04);
			}

			continue;
		}

		if(distancesquared(var_04.origin,param_00.var_4B2C) < level.var_DAA3 * level.var_DAA3)
		{
			var_01 = scripts\common\utility::array_add(var_01,var_04);
		}
	}

	return var_01;
}

//Function Number: 29
func_6CA5()
{
	if(isdefined(level.var_118A0))
	{
		foreach(var_01 in level.var_2C7A)
		{
			if(distancesquared(level.var_118A0.origin,var_01.var_4B2C) < 90000)
			{
				return var_01;
			}
		}
	}

	return undefined;
}

//Function Number: 30
func_7C93(param_00)
{
	param_00 = "_" + tolower(param_00);
	for(var_01 = 0;var_01 < level.var_2C7A.size;var_01++)
	{
		if(level.var_2C7A[var_01].label == param_00)
		{
			return level.var_2C7A[var_01];
		}
	}
}

//Function Number: 31
func_2C55()
{
	self endon("stopped_being_bomb_carrier");
	self endon("new_role");
	scripts\common\utility::waittill_any_3("death","disconnect");
	level.var_2413 = undefined;
	level.var_A88A = gettime();
	if(isdefined(self))
	{
		self.var_E67C = undefined;
	}

	var_00 = func_7AA1(game["attackers"],1);
	func_725C(var_00,undefined);
}

//Function Number: 32
func_2C54()
{
	self endon("death");
	self endon("disconnect");
	self endon("stopped_being_bomb_carrier");
	level.var_F013 endon("pickup_object");
	level.var_F013 waittill("reset");
	if(scripts\mp\_utility::func_9D36(self))
	{
		self botclearscriptgoal();
	}

	func_2E84("atk_bomber");
}

//Function Number: 33
func_F495()
{
	level.var_2413 = self;
	func_2E84("atk_bomber");
	thread func_2C55();
	if(!level.var_BDC1)
	{
		thread func_2C54();
	}

	if(isai(self))
	{
		scripts\mp\bots\_bots_strategy::func_2D5C();
		if(level.var_24B1 == "rush" && self botgetdifficultysetting("strategyLevel") > 0)
		{
			func_F3B9();
		}
	}
}

//Function Number: 34
func_9871()
{
	if(self.team == game["attackers"])
	{
		if(level.var_2C5C)
		{
			func_2E84("defend_planted_bomb");
			return;
		}

		if(!isdefined(level.var_2413))
		{
			func_F495();
			return;
		}

		if(level.var_24B1 == "rush")
		{
			func_2E84("clear_target_zone");
			return;
		}

		return;
	}

	var_00 = func_7BBE("backstabber");
	var_01 = func_7BBE("defender");
	var_02 = level.var_2E46[self.var_CA79];
	var_03 = self botgetdifficultysetting("strategyLevel");
	if(var_02 == "active")
	{
		if(!isdefined(self.var_E67C) && level.var_1C3B && var_03 > 0)
		{
			if(var_00.size == 0)
			{
				func_2E84("backstabber");
			}
			else
			{
				var_04 = 1;
				foreach(var_06 in var_00)
				{
					var_07 = level.var_2E46[var_06.var_CA79];
					if(var_07 == "active")
					{
						var_04 = 0;
						break;
					}
				}

				if(var_04)
				{
					func_2E84("backstabber");
					var_00[0] func_2E84(undefined);
				}
			}
		}

		if(!isdefined(self.var_E67C))
		{
			if(var_01.size < 4)
			{
				func_2E84("defender");
			}
		}

		if(!isdefined(self.var_E67C))
		{
			var_09 = randomint(4);
			if(var_09 == 3 && level.var_1C61 && var_03 > 0)
			{
				func_2E84("random_killer");
			}
			else if(var_09 == 2 && level.var_1C3B && var_03 > 0)
			{
				func_2E84("backstabber");
			}
			else
			{
				func_2E84("defender");
			}
		}
	}
	else if(var_02 == "stationary")
	{
		if(!isdefined(self.var_E67C))
		{
			if(var_01.size < 4)
			{
				func_2E84("defender");
			}
			else
			{
				foreach(var_0B in var_01)
				{
					var_0C = level.var_2E46[var_0B.var_CA79];
					if(var_0C == "active")
					{
						func_2E84("defender");
						var_0B func_2E84(undefined);
						break;
					}
				}
			}
		}

		if(!isdefined(self.var_E67C) && level.var_1C3B && var_03 > 0)
		{
			if(var_00.size == 0)
			{
				func_2E84("backstabber");
			}
		}

		if(!isdefined(self.var_E67C))
		{
			func_2E84("defender");
		}
	}

	if(self.var_E67C == "defender")
	{
		var_0E = level.var_2C7A;
		if(func_8B99(self.team))
		{
			var_0E = func_7B60(self.team);
		}

		if(var_0E.size == 1)
		{
			self.var_5081 = var_0E[0];
			return;
		}

		var_0F = func_7BBF(var_0E[0]);
		var_10 = func_7BBF(var_0E[1]);
		if(var_0F.size < var_10.size)
		{
			self.var_5081 = var_0E[0];
			return;
		}

		if(var_10.size < var_0F.size)
		{
			self.var_5081 = var_0E[1];
			return;
		}

		self.var_5081 = scripts\common\utility::random(var_0E);
		return;
	}
}

//Function Number: 35
func_2E84(param_00)
{
	if(isai(self))
	{
		scripts\mp\bots\_bots_strategy::func_2D4E();
		self method_804F(undefined);
	}

	self.var_D88F = self.var_E67C;
	self.var_E67C = param_00;
	self notify("new_role");
}

//Function Number: 36
func_2E85(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("new_role");
	wait(param_01);
	func_2E84(param_00);
}

//Function Number: 37
func_725C(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		if(isdefined(param_02))
		{
			var_04 thread func_2E85(param_01,randomfloatrange(0,param_02));
			continue;
		}

		var_04 thread func_2E84(param_01);
	}
}

//Function Number: 38
func_7B60(param_00)
{
	return level.var_2E6C[param_00];
}

//Function Number: 39
func_8B99(param_00)
{
	var_01 = func_7B60(param_00);
	return var_01.size > 0;
}

//Function Number: 40
func_7BBE(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_C928)
	{
		if(isalive(var_03) && scripts\mp\_utility::func_9F9D(var_03) && isdefined(var_03.var_E67C) && var_03.var_E67C == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 41
func_7AA1(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.var_C928)
	{
		if(!isdefined(var_04.team))
		{
			continue;
		}

		if(scripts\mp\_utility::func_9F19(var_04) && scripts\mp\_utility::func_9F9D(var_04) && var_04.team == param_00)
		{
			if(!isdefined(param_01) || param_01 && isai(var_04) && isdefined(var_04.var_E67C))
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 42
func_2E6B()
{
	level notify("bot_sd_ai_director_update");
	level endon("bot_sd_ai_director_update");
	level endon("game_ended");
	level.var_1C3B = randomint(3) <= 1;
	level.var_1C61 = randomint(3) <= 1;
	level.var_24B1 = "rush";
	level.var_DAA3 = 725;
	level.var_3A38 = 140;
	for(;;)
	{
		if(isdefined(level.var_F013) && isdefined(level.var_F013.carrier) && !isai(level.var_F013.carrier))
		{
			level.var_2C47 = func_6C80(level.var_F013.carrier);
		}

		var_00 = 0;
		if(!level.var_2C5C)
		{
			var_01 = func_7AA1(game["attackers"]);
			foreach(var_03 in var_01)
			{
				if(var_03.var_9D6C)
				{
					level.var_382E = gettime();
					if(!isdefined(level.var_2413) || var_03 != level.var_2413)
					{
						if(isdefined(level.var_2413) && isalive(level.var_2413))
						{
							level.var_2413 func_2E84(undefined);
							level.var_2413 notify("stopped_being_bomb_carrier");
						}

						var_00 = 1;
						var_03 func_F495();
					}
				}
			}

			if(!level.var_BDC1 && !isdefined(level.var_F013.carrier))
			{
				var_05 = getclosestnodeinsight(level.var_F013.var_4B2C);
				if(isdefined(var_05))
				{
					level.var_F013.var_BE7D = var_05;
					var_06 = 0;
					var_07 = func_7AA1(game["defenders"],1);
					foreach(var_09 in var_07)
					{
						var_0A = var_09 getnearestnode();
						var_0B = var_09 botgetdifficultysetting("strategyLevel");
						if(var_0B > 0 && var_09.var_E67C != "camp_bomb" && isdefined(var_0A) && nodesvisible(var_05,var_0A,1))
						{
							var_0C = var_09 botgetfovdot();
							if(scripts\common\utility::func_13D90(var_09.origin,var_09.angles,level.var_F013.var_4B2C,var_0C))
							{
								if(var_0B >= 2 || distancesquared(var_09.origin,level.var_F013.var_4B2C) < squared(700))
								{
									var_06 = 1;
									break;
								}
							}
						}
					}

					if(var_06)
					{
						foreach(var_09 in var_07)
						{
							if(var_09.var_E67C != "camp_bomb" && var_09 botgetdifficultysetting("strategyLevel") > 0)
							{
								var_09 func_2E84("camp_bomb");
							}
						}
					}
				}
			}

			var_10 = level.var_2C7A;
			if(func_8B99(game["defenders"]))
			{
				var_10 = func_7B60(game["defenders"]);
			}

			for(var_11 = 0;var_11 < var_10.size;var_11++)
			{
				for(var_12 = 0;var_12 < var_10.size;var_12++)
				{
					var_13 = func_7BBF(var_10[var_11]);
					var_14 = func_7BBF(var_10[var_12]);
					if(var_13.size > var_14.size + 1)
					{
						var_15 = [];
						foreach(var_03 in var_13)
						{
							if(isai(var_03))
							{
								var_15 = scripts\common\utility::array_add(var_15,var_03);
							}
						}

						if(var_15.size > 0)
						{
							var_18 = scripts\common\utility::random(var_15);
							var_18 scripts\mp\bots\_bots_strategy::func_2D4E();
							var_18.var_5081 = var_10[var_12];
						}
					}
				}
			}
		}
		else
		{
			if(isdefined(level.var_2413))
			{
				level.var_2413 = undefined;
			}

			if(!isdefined(level.var_2C44) || !isalive(level.var_2C44))
			{
				var_19 = [];
				var_1A = func_7BBE("defender");
				var_1B = func_7BBE("backstabber");
				var_1C = func_7BBE("random_killer");
				if(var_1A.size > 0)
				{
					var_19 = var_1A;
				}
				else if(var_1B.size > 0)
				{
					var_19 = var_1B;
				}
				else if(var_1C.size > 0)
				{
					var_19 = var_1C;
				}

				if(var_19.size > 0)
				{
					var_1D = scripts\common\utility::func_782F(level.var_F014.origin,var_19);
					level.var_2C44 = var_1D[0];
					level.var_2C44 func_2E84("bomb_defuser");
					level.var_2C44 scripts\mp\bots\_bots_strategy::func_2D5C();
					level.var_2C44 thread func_50A9();
				}
			}

			if(!isdefined(level.var_EFFA))
			{
				level.var_EFFA = 1;
				var_1E = func_7AA1(game["attackers"]);
				foreach(var_03 in var_1E)
				{
					if(isdefined(var_03.var_E67C))
					{
						if(var_03.var_E67C == "atk_bomber")
						{
							var_03 thread func_2E84(undefined);
							continue;
						}

						if(var_03.var_E67C != "defend_planted_bomb")
						{
							var_03 thread func_2E85("defend_planted_bomb",randomfloatrange(0,3));
						}
					}
				}
			}
		}

		wait(0.5);
	}
}

//Function Number: 43
func_50A9()
{
	scripts\common\utility::waittill_any_3("death","disconnect");
	level.var_2C44 = undefined;
}