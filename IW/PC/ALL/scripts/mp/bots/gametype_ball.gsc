/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_ball.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 1143 ms
 * Timestamp: 10/27/2023 12:11:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
	func_F8D6();
	thread monitor_ball_carrier();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["gametype_think"] = ::func_2D12;
}

//Function Number: 3
func_F8D6()
{
	scripts\mp\bots\_bots_util::func_2ECA(1);
	level.var_DAA3 = 600;
	level.var_2C12 = 400;
	thread func_2D11();
	level.var_2DA1 = 1;
}

//Function Number: 4
func_2DA4()
{
	foreach(var_01 in level.var_2800)
	{
		if(isdefined(var_01.carrier))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_01.var_9398))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_01.var_9F24))
		{
			continue;
		}

		return var_01;
	}

	return undefined;
}

//Function Number: 5
func_2DA5()
{
	foreach(var_01 in level.var_2800)
	{
		if(isdefined(var_01.carrier))
		{
			return var_01.carrier;
		}
	}

	return undefined;
}

//Function Number: 6
func_2D5D()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self botsetstance("stand");
	for(var_00 = 0;var_00 < 5;var_00++)
	{
		self botpressbutton("jump");
		scripts\common\utility::func_136F7();
	}

	scripts\common\utility::func_136F7();
	scripts\common\utility::func_136F7();
	for(var_00 = 0;var_00 < 60;var_00++)
	{
		self botpressbutton("jump");
		scripts\common\utility::func_136F7();
		if(!isdefined(self.var_3AF7))
		{
			break;
		}
	}
}

//Function Number: 7
bot_throw_ball()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(var_00 = 0;var_00 < 5;var_00++)
	{
		self botpressbutton("attack");
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 8
func_2DA7()
{
	if(self.team == "allies")
	{
		return "axis";
	}

	return "allies";
}

//Function Number: 9
func_2D12()
{
	self notify("bot_ball_think");
	self endon("bot_ball_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
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
		if(!isdefined(self.var_E67C))
		{
			func_9841();
			var_00 = undefined;
		}

		if(scripts\mp\bots\_bots_strategy::func_2DC5())
		{
			var_00 = undefined;
			continue;
		}

		if(self.var_E67C != "carrier" && isdefined(self.var_3AF7))
		{
			var_00 = undefined;
			func_27C2("carrier");
		}

		if(self.var_E67C == "carrier")
		{
			if(isdefined(self.var_3AF7))
			{
				self botsetflag("disable_attack",1);
				var_02 = 0;
				if(isdefined(self.var_10C))
				{
					var_02 = distancesquared(self.var_10C.origin,self.origin);
				}

				if(isdefined(self.var_10C) && var_02 < 9216)
				{
					self botsetflag("disable_attack",0);
					self botsetflag("prefer_melee",1);
				}
				else
				{
					self botsetflag("prefer_melee",0);
					self botsetflag("disable_attack",1);
				}

				if(isdefined(level.var_2798))
				{
					var_03 = level.var_2798[func_2DA7()].origin;
					if(!isdefined(var_00))
					{
						var_00 = getclosestpointonnavmesh(var_03,self);
						if(distance2dsquared(var_00,var_03) > 256)
						{
							var_04 = (var_03[0],var_03[1],var_03[2] - 90);
							var_00 = getclosestpointonnavmesh(var_04,self);
						}
					}

					self botsetscriptgoal(var_00,16,"critical");
					var_05 = distance2dsquared(self.origin,var_03);
					if(var_05 < 30625)
					{
						var_06 = self geteye();
						var_07 = var_03;
						if(scripts\common\trace::func_DCF1(var_06,var_07,self))
						{
							if(var_05 < 256)
							{
								self botsetscriptgoal(self.origin,16,"critical");
								wait(0.25);
							}

							func_2D5D();
							wait(0.2);
							if(!isdefined(self.var_3AF7))
							{
								self botclearscriptgoal();
							}
						}
					}
				}
				else
				{
					self botclearscriptgoal();
					if(!isdefined(var_01))
					{
						var_01 = gettime() + randomintrange(500,1000);
					}

					if(gettime() > var_01)
					{
						var_01 = gettime() + randomintrange(500,1000);
						if(isdefined(self.var_10C))
						{
							if(self botcanseeentity(self.var_10C))
							{
								var_08 = anglestoforward(self.angles);
								var_09 = self.var_10C.origin - self.origin;
								var_0A = vectornormalize((var_09[0],var_09[1],0));
								var_0B = vectordot(var_08,var_0A);
								if(var_0B > 0.707)
								{
									if(var_02 < -7936 && var_02 > 9216)
									{
										bot_throw_ball();
									}
								}
							}
						}
					}
				}
			}
			else
			{
				self botsetflag("disable_attack",0);
				self botsetflag("prefer_melee",0);
				var_0C = func_2DA4();
				if(!isdefined(var_0C))
				{
					var_0D = func_2DA5();
					if(isdefined(var_0D) && var_0D != self)
					{
						func_9841();
					}
				}
				else
				{
					self botsetscriptgoal(var_0D.var_4B2C,16,"objective");
					continue;
				}
			}
		}
		else
		{
			var_00 = undefined;
		}

		if(self.var_E67C == "attacker")
		{
			self botsetflag("disable_attack",0);
			self botsetflag("prefer_melee",0);
			var_0C = func_2DA4();
			if(!isdefined(var_0C))
			{
				var_0D = func_2DA5();
				if(isdefined(var_0D))
				{
					if(!scripts\mp\bots\_bots_util::func_2DDA(var_0D))
					{
						scripts\mp\bots\_bots_strategy::func_2DC1(var_0D,level.var_2C12);
					}
				}
			}
			else if(!scripts\common\utility::istrue(var_0C.var_9F24) && !scripts\common\utility::istrue(var_0C.var_9398))
			{
				var_0E = getclosestpointonnavmesh(var_0C.var_4B2C);
				if(!scripts\mp\bots\_bots_util::func_2DD8(var_0E))
				{
					scripts\mp\bots\_bots_strategy::func_2E57(var_0E,level.var_DAA3);
				}
			}

			continue;
		}

		if(self.var_E67C == "defender")
		{
			self botsetflag("disable_attack",0);
			self botsetflag("prefer_melee",0);
			var_0F = level.var_2798[self.team];
			var_03 = var_0F.origin;
			if(!scripts\mp\bots\_bots_util::func_2DD8(var_03))
			{
				scripts\mp\bots\_bots_strategy::func_2E57(var_03,level.var_DAA3);
			}
		}
	}
}

//Function Number: 10
func_9841()
{
	var_00 = func_7809(self.team);
	var_01 = func_780A(self.team);
	var_02 = func_2774(self.team);
	var_03 = func_2775(self.team);
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
				func_27C2("attacker");
				return;
			}

			func_27C2("defender");
			return;
		}

		func_27C2("attacker");
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
				func_27C2("defender");
				return;
			}

			func_27C2("attacker");
			return;
		}

		func_27C2("defender");
		return;
	}
}

//Function Number: 11
func_2D11()
{
	level notify("bot_ball_ai_director_update");
	level endon("bot_ball_ai_director_update");
	level endon("game_ended");
	var_00[0] = "allies";
	var_00[1] = "axis";
	var_01 = [];
	for(;;)
	{
		foreach(var_03 in var_00)
		{
			var_04 = func_2774(var_03);
			var_05 = func_2775(var_03);
			var_06 = func_7809(var_03);
			var_07 = func_780A(var_03);
			if(var_06.size > var_04)
			{
				var_08 = [];
				var_09 = 0;
				foreach(var_0B in var_06)
				{
					if(isai(var_0B))
					{
						if(level.var_2E46[var_0B.var_CA79] == "stationary")
						{
							var_0B func_27C2("defender");
							var_09 = 1;
							break;
						}
						else
						{
							var_08 = scripts\common\utility::array_add(var_08,var_0B);
						}
					}
				}

				if(!var_09 && var_08.size > 0)
				{
					scripts\common\utility::random(var_08) func_27C2("defender");
				}
			}

			if(var_07.size > var_05)
			{
				var_0D = [];
				var_0E = 0;
				foreach(var_10 in var_07)
				{
					if(isai(var_10))
					{
						if(level.var_2E46[var_10.var_CA79] == "active")
						{
							var_10 func_27C2("attacker");
							var_0E = 1;
							break;
						}
						else
						{
							var_0D = scripts\common\utility::array_add(var_0D,var_10);
						}
					}
				}

				if(!var_0E && var_0D.size > 0)
				{
					scripts\common\utility::random(var_0D) func_27C2("attacker");
				}
			}

			var_12 = func_2DA4();
			if(isdefined(var_12))
			{
				var_13 = func_CB1C(var_03,var_12);
				if(isdefined(var_13) && isdefined(var_13.var_E67C) && var_13.var_E67C != "carrier")
				{
					if(!isdefined(var_13.var_3AF7))
					{
						var_14 = var_01[var_03];
						if(isdefined(var_14))
						{
							var_14 func_27C2(undefined);
						}

						var_13 func_27C2("carrier");
						var_01[var_13.team] = var_13;
					}
				}
			}
		}

		wait(1);
	}
}

//Function Number: 12
func_2774(param_00)
{
	var_01 = func_2790(param_00);
	if(!isdefined(level.var_2798))
	{
		return var_01;
	}

	return int(int(var_01) / 2) + 1 + int(var_01) % 2;
}

//Function Number: 13
func_2775(param_00)
{
	if(!isdefined(level.var_2798))
	{
		return 0;
	}

	var_01 = func_2790(param_00);
	return max(int(int(var_01) / 2) - 1,0);
}

//Function Number: 14
func_2790(param_00)
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

//Function Number: 15
func_CB1C(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in level.var_C928)
	{
		if(!isdefined(var_05.team))
		{
			continue;
		}

		if(var_05.team != param_00)
		{
			continue;
		}

		if(!isalive(var_05))
		{
			continue;
		}

		if(!isai(var_05))
		{
			continue;
		}

		if(isdefined(var_05.var_E67C) && var_05.var_E67C == "defender")
		{
			continue;
		}

		var_06 = distancesquared(var_05.origin,param_01.var_4B2C);
		if(!isdefined(var_03) || var_06 < var_03)
		{
			var_03 = var_06;
			var_02 = var_05;
		}
	}

	if(isdefined(var_02))
	{
		return var_02;
	}

	return undefined;
}

//Function Number: 16
func_7809(param_00)
{
	var_01 = func_7BBE("attacker",param_00);
	if(isdefined(level.var_2798))
	{
		foreach(var_03 in level.players)
		{
			if(!isai(var_03) && isdefined(var_03.team) && var_03.team == param_00)
			{
				if(distancesquared(level.var_2798[param_00].origin,var_03.origin) > level.var_DAA3 * level.var_DAA3)
				{
					var_01 = scripts\common\utility::array_add(var_01,var_03);
				}
			}
		}
	}

	return var_01;
}

//Function Number: 17
func_780A(param_00)
{
	var_01 = func_7BBE("defender",param_00);
	if(isdefined(level.var_2798))
	{
		foreach(var_03 in level.players)
		{
			if(!isai(var_03) && isdefined(var_03.team) && var_03.team == param_00)
			{
				if(distancesquared(level.var_2798[param_00].origin,var_03.origin) <= level.var_DAA3 * level.var_DAA3)
				{
					var_01 = scripts\common\utility::array_add(var_01,var_03);
				}
			}
		}
	}

	return var_01;
}

//Function Number: 18
func_27C2(param_00)
{
	self.var_E67C = param_00;
	self botclearscriptgoal();
	scripts\mp\bots\_bots_strategy::func_2D4E();
}

//Function Number: 19
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

//Function Number: 20
monitor_ball_carrier()
{
	level endon("game_ended");
	var_00 = undefined;
	for(;;)
	{
		var_01 = func_2DA5();
		if(!isdefined(var_00) || !isdefined(var_01) || var_01 != var_00)
		{
			if(isdefined(var_00) && var_00.var_33F == 505)
			{
				var_00.var_33F = 0;
			}

			var_00 = var_01;
		}

		if(isdefined(var_01) && var_01.var_33F == 0)
		{
			var_01.var_33F = 505;
		}

		wait(0.05);
	}
}