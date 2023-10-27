/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_koth.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 1305 ms
 * Timestamp: 10/27/2023 12:12:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	func_F998();
}

//Function Number: 2
func_F998()
{
	scripts\mp\bots\_bots_util::func_2ECA(1);
	thread func_2DC3();
	level.var_DAA3 = 128;
	level.var_C992 = 800;
	level.var_2DA1 = 1;
}

//Function Number: 3
func_F8F4()
{
	level.var_2D9E["gametype_think"] = ::func_2DC4;
}

//Function Number: 4
func_986A()
{
	var_00 = func_7809(self.team);
	var_01 = func_780A(self.team);
	var_02 = func_2D0F(self.team);
	var_03 = func_2D50(self.team);
	var_04 = level.var_2E46[self.var_CA79];
	if(var_04 == "active")
	{
		if(var_00.size >= var_02)
		{
			var_05 = 0;
			foreach(var_07 in var_00)
			{
				if(isai(var_07) && level.var_2E46[var_07.var_CA79] == "stationary")
				{
					var_07.var_E67C = undefined;
					var_05 = 1;
					break;
				}
			}

			if(var_05)
			{
				func_2E84("attacker");
				return;
			}

			func_2E84("defender");
			return;
		}

		func_2E84("attacker");
		return;
	}

	if(var_04 == "stationary")
	{
		if(var_01.size >= var_03)
		{
			var_05 = 0;
			foreach(var_0A in var_01)
			{
				if(isai(var_0A) && level.var_2E46[var_0A.var_CA79] == "active")
				{
					var_0A.var_E67C = undefined;
					var_05 = 1;
					break;
				}
			}

			if(var_05)
			{
				func_2E84("defender");
				return;
			}

			func_2E84("attacker");
			return;
		}

		func_2E84("defender");
		return;
	}
}

//Function Number: 5
func_2DC4()
{
	self notify("bot_grnd_think");
	self endon("bot_grnd_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self botclearscriptgoal();
	while(!isdefined(level.var_2DA1))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	var_00 = undefined;
	var_01 = undefined;
	for(;;)
	{
		wait(0.05);
		if(scripts\mp\bots\_bots_strategy::func_2DC5())
		{
			continue;
		}

		if(!isdefined(self.var_E67C))
		{
			func_986A();
		}

		if(!scripts\common\utility::istrue(self.var_2D51))
		{
			var_00 = undefined;
			var_01 = undefined;
		}

		if(self.var_E67C == "attacker")
		{
			var_02 = 0;
			var_01 = undefined;
			if(!isdefined(var_00))
			{
				var_02 = 1;
			}
			else if(isdefined(level.var_13FB0.var_767B.trigger))
			{
				if(var_00 != level.var_13FB0.var_767B.trigger)
				{
					var_02 = 1;
				}
			}

			if(var_02)
			{
				var_03 = getclosestpointonnavmesh(level.var_13FB0.var_767B.trigger.origin,self);
				var_04["min_goal_time"] = 1;
				var_04["max_goal_time"] = 4;
				scripts\mp\bots\_bots_strategy::func_2E3D(var_03,level.var_C992,var_04);
				var_00 = level.var_13FB0.var_767B.trigger;
			}

			continue;
		}

		if(self.var_E67C == "defender")
		{
			var_00 = undefined;
			var_05 = 0;
			if(!isdefined(var_01))
			{
				var_05 = 1;
			}
			else if(isdefined(level.var_13FB0.var_767B.trigger))
			{
				if(var_01 != level.var_13FB0.var_767B.trigger)
				{
					var_05 = 1;
				}
			}

			if(var_05)
			{
				var_06 = function_00B7(level.var_13FB0.var_767B.trigger);
				if(var_06.size > 0)
				{
					var_04["min_goal_time"] = 3;
					var_04["max_goal_time"] = 6;
					scripts\mp\bots\_bots_strategy::func_2D2C(level.var_13FB0.var_767B.trigger.origin,var_06,level.var_13FB0.var_767B.trigger,var_04);
					var_01 = level.var_13FB0.var_767B.trigger;
				}
			}
		}
	}
}

//Function Number: 6
func_2D0F(param_00)
{
	var_01 = func_7B3C(param_00);
	return int(int(var_01) / 2) + 1 + int(var_01) % 2;
}

//Function Number: 7
func_2D50(param_00)
{
	var_01 = func_7B3C(param_00);
	return max(int(int(var_01) / 2) - 1,0);
}

//Function Number: 8
func_7B3C(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_C928)
	{
		if(scripts\mp\_utility::func_9F9D(var_03) && isdefined(var_03.team) && var_03.team == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 9
func_7809(param_00)
{
	var_01 = func_7BBE("attacker",param_00);
	if(isdefined(level.var_13FB0.var_767B.trigger))
	{
		foreach(var_03 in level.players)
		{
			if(!isai(var_03) && isdefined(var_03.team) && var_03.team == param_00)
			{
				if(!var_03 istouching(level.var_13FB0.var_767B.trigger))
				{
					var_01 = scripts\common\utility::array_add(var_01,var_03);
				}
			}
		}
	}

	return var_01;
}

//Function Number: 10
func_780A(param_00)
{
	var_01 = func_7BBE("defender",param_00);
	if(isdefined(level.var_13FB0.var_767B.trigger))
	{
		foreach(var_03 in level.players)
		{
			if(!isai(var_03) && isdefined(var_03.team) && var_03.team == param_00)
			{
				if(var_03 istouching(level.var_13FB0.var_767B.trigger))
				{
					var_01 = scripts\common\utility::array_add(var_01,var_03);
				}
			}
		}
	}

	return var_01;
}

//Function Number: 11
func_7BBE(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.var_C928)
	{
		if(!isdefined(var_04.team))
		{
			continue;
		}

		if(isalive(var_04) && scripts\mp\_utility::func_9F9D(var_04) && var_04.team == param_01 && isdefined(var_04.var_E67C) && var_04.var_E67C == param_00)
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 12
func_2E84(param_00)
{
	self.var_E67C = param_00;
	self botclearscriptgoal();
	scripts\mp\bots\_bots_strategy::func_2D4E();
}

//Function Number: 13
func_9B74(param_00,param_01)
{
	var_02 = param_00 istouching(level.var_13FB0.var_767B.trigger);
	var_03 = param_01 istouching(level.var_13FB0.var_767B.trigger);
	if(var_02 != var_03)
	{
		if(var_02)
		{
			return 0;
		}

		return 1;
	}

	if(var_02)
	{
		if(param_00.var_E67C != param_01.var_E67C)
		{
			if(param_01.var_E67C == "defender")
			{
				return 1;
			}

			return 0;
		}
	}

	var_04 = distance2dsquared(param_00.origin,level.var_13FB0.var_767B.trigger.origin);
	var_05 = distance2dsquared(param_01.origin,level.var_13FB0.var_767B.trigger.origin);
	if(var_04 < var_05)
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
func_2DC3()
{
	level notify("bot_hardpoint_ai_director_update");
	level endon("bot_hardpoint_ai_director_update");
	level endon("game_ended");
	var_00[0] = "allies";
	var_00[1] = "axis";
	var_01["allies"] = 0;
	var_01["axis"] = 0;
	for(;;)
	{
		var_02 = "neutral";
		if(isdefined(level.var_13FB0.var_767B.trigger))
		{
			var_02 = level.var_13FB0.var_767B scripts\mp\_gameobjects::func_803E();
		}

		foreach(var_04 in var_00)
		{
			var_05 = [];
			var_06 = [];
			if(var_04 != var_02)
			{
				var_01[var_04] = 0;
				foreach(var_08 in level.var_C928)
				{
					if(scripts\mp\_utility::func_9F9D(var_08) && isdefined(var_08.team) && var_08.team == var_04)
					{
						if(isbot(var_08) && !isdefined(var_08.var_E67C) || var_08.var_E67C != "defender")
						{
							var_08 func_2E84("defender");
						}
					}
				}

				continue;
			}

			var_0A = func_2D0F(var_04);
			var_0B = func_2D50(var_04);
			if(!var_01[var_04])
			{
				var_01[var_04] = 1;
				var_0C = [];
				foreach(var_08 in level.var_C928)
				{
					if(scripts\mp\_utility::func_9F9D(var_08) && isdefined(var_08.team) && var_08.team == var_04)
					{
						if(isbot(var_08))
						{
							var_0C[var_0C.size] = var_08;
						}
					}
				}

				var_0F = scripts\common\utility::func_22C3(var_0C,::func_9B74);
				if(var_0C.size < var_0B)
				{
					var_0B = var_0C.size;
				}

				var_0B = int(var_0B);
				for(var_10 = 0;var_10 < var_0B;var_10++)
				{
					var_0C[var_10] func_2E84("defender");
				}

				for(var_10 = var_0B;var_10 < var_0C.size;var_10++)
				{
					var_0C[var_10] func_2E84("attacker");
				}

				wait(1);
				continue;
			}

			var_11 = func_7809(var_04);
			var_12 = func_780A(var_04);
			if(var_11.size > var_0A)
			{
				var_13 = 0;
				foreach(var_15 in var_11)
				{
					if(isai(var_15))
					{
						if(level.var_2E46[var_15.var_CA79] == "stationary")
						{
							var_15 func_2E84("defender");
							var_13 = 1;
							break;
						}
						else
						{
							var_05 = scripts\common\utility::array_add(var_05,var_15);
						}
					}
				}

				if(!var_13 && var_05.size > 0)
				{
					scripts\common\utility::random(var_05) func_2E84("defender");
				}
			}

			if(var_12.size > var_0B)
			{
				var_17 = 0;
				foreach(var_19 in var_12)
				{
					if(isai(var_19))
					{
						if(level.var_2E46[var_19.var_CA79] == "active")
						{
							var_19 func_2E84("attacker");
							var_17 = 1;
							break;
						}
						else
						{
							var_06 = scripts\common\utility::array_add(var_06,var_19);
						}
					}
				}

				if(!var_17 && var_06.size > 0)
				{
					scripts\common\utility::random(var_06) func_2E84("attacker");
				}
			}

			if(var_12.size == 0)
			{
				var_1B = func_7BBE("attacker",var_04);
				if(var_1B.size > 0)
				{
					scripts\common\utility::random(var_1B) func_2E84("defender");
				}
			}
		}

		wait(1);
	}
}

//Function Number: 15
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

	return !scripts\mp\bots\_bots_util::func_2DD7() || scripts\mp\bots\_bots_util::func_2DDD();
}

//Function Number: 16
func_B9B0()
{
	self notify("monitor_zone_control");
	self endon("monitor_zone_control");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(1);
		var_00 = 0;
		if(isdefined(level.var_DBFD) && self.var_1270F == level.var_DBFD.trigger)
		{
			var_01 = level.var_DBFD scripts\mp\_gameobjects::func_803E();
			if(var_01 != "neutral")
			{
				var_02 = getzonenearest(self.origin);
				if(isdefined(var_02))
				{
					function_002B(var_02,var_01);
					var_00 = 1;
				}
			}
		}

		if(!var_00)
		{
			var_02 = getzonenearest(self.origin);
			if(isdefined(var_02))
			{
				function_002B(var_02,"free");
			}
		}
	}
}

//Function Number: 17
func_F8DE()
{
	scripts\mp\bots\_bots_util::func_2ECA();
	while(!isdefined(level.var_DBFE))
	{
		wait(0.05);
	}

	scripts\mp\bots\_bots_strategy::func_2E8A();
	for(var_00 = 0;var_00 < level.var_DBFE.size;var_00++)
	{
		level.var_DBFE[var_00].script_label = "_" + var_00;
		level.var_DBFE[var_00] thread func_B9B0();
	}

	scripts\mp\bots\_bots_util::func_2D1A(level.var_DBFE,"radio");
	level.var_2DA1 = 1;
}

//Function Number: 18
func_2DC6()
{
	self notify("bot_hq_think");
	self endon("bot_hq_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.var_2DA1))
	{
		wait(0.05);
	}

	self botsetflag("grenade_objectives",1);
	func_9559();
	for(;;)
	{
		var_00 = randomintrange(1,11) * 0.05;
		wait(var_00);
		if(self.health <= 0)
		{
			continue;
		}

		if(!isdefined(level.var_DBFD))
		{
			if(scripts\mp\bots\_bots_util::func_2DD7())
			{
				scripts\mp\bots\_bots_strategy::func_2D4E();
			}

			var_01 = 1;
			if(self botgetscriptgoaltype() != "none")
			{
				var_02 = distancesquared(self botgetscriptgoal(),self.origin);
				var_03 = self botgetscriptgoalradius();
				if(var_02 > var_03 * var_03)
				{
					var_01 = 0;
				}
			}

			if(var_01)
			{
				var_04 = self method_8029();
				if(isdefined(var_04))
				{
					self botsetscriptgoal(var_04.origin,128,"hunt");
				}
			}

			continue;
		}

		var_05 = level.var_DBFD scripts\mp\_gameobjects::func_803E();
		if(self.team != var_05)
		{
			if(!func_9B83())
			{
				var_06 = func_7B2C();
				var_07 = func_6C85().var_2E28.size;
				if(var_06 < var_07)
				{
					func_3A36();
				}
				else if(!func_9C94())
				{
					func_DAA1();
				}
			}
		}
		else if(!func_9C94())
		{
			wait(randomfloat(2));
			if(isdefined(level.var_DBFD))
			{
				func_DAA1();
			}
		}
	}
}

//Function Number: 19
func_6C85()
{
	foreach(var_01 in level.var_DBFE)
	{
		if(var_01.var_1270F == level.var_DBFD.trigger)
		{
			return var_01;
		}
	}
}

//Function Number: 20
func_9B83()
{
	return scripts\mp\bots\_bots_util::func_2DD5();
}

//Function Number: 21
func_7B2C()
{
	var_00 = 0;
	foreach(var_02 in level.var_C928)
	{
		if(isai(var_02) && var_02.health > 0 && var_02.team == self.team && var_02 func_9B83())
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 22
func_3A36()
{
	var_00 = func_6C85();
	var_01["entrance_points_index"] = "radio" + var_00.script_label;
	scripts\mp\bots\_bots_strategy::func_2D2C(var_00.origin,var_00.var_2E28,undefined,var_01);
}

//Function Number: 23
func_9C94()
{
	return scripts\mp\bots\_bots_util::func_2DDD();
}

//Function Number: 24
func_DAA1()
{
	var_00 = self method_803C();
	var_01 = var_00[0] + var_00[1] / 2;
	var_02 = min(1000,var_01 / 4);
	scripts\mp\bots\_bots_strategy::func_2E57(func_6C85().origin,var_02);
}

//Function Number: 25
func_9559()
{
	if(isdefined(level.var_2EF4) && level.var_2EF4)
	{
		return;
	}

	level.var_2EF4 = 1;
	foreach(var_01 in level.var_DBFE)
	{
		var_01.var_2E28 = function_00B7(var_01.var_1270F);
	}
}