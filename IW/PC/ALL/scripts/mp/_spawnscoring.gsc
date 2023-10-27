/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_spawnscoring.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 763 ms
 * Timestamp: 10/27/2023 12:21:37 AM
*******************************************************************/

//Function Number: 1
func_3E05(param_00)
{
	if(isdefined(level.var_5F93))
	{
		param_00 = [[ level.var_5F93 ]](param_00);
	}

	return param_00;
}

//Function Number: 2
func_F1AB(param_00,param_01)
{
	var_02 = param_00;
	return var_02;
}

//Function Number: 3
func_6CB1()
{
	if(!level.teambased || isdefined(level.var_112BF) && !level.var_112BF)
	{
		return undefined;
	}

	var_00 = func_81B4(self.team);
	var_01 = [];
	foreach(var_03 in var_00)
	{
		var_04 = func_6CC5(var_03);
		if(!isdefined(var_04))
		{
			continue;
		}

		var_05 = spawnstruct();
		var_05.origin = var_04;
		var_05.angles = func_7E0F(var_03,var_05.origin);
		var_05.index = -1;
		var_05.var_3165 = 1;
		var_05.var_9DCF = 1;
		var_05 scripts\mp\_spawnlogic::func_108FA();
		if(isdefined(var_03.var_1E61) && isdefined(var_03.var_1E61.var_D3AB))
		{
			var_05.var_3164 = var_03.var_1E61.var_D3AB;
		}

		var_01[var_01.size] = var_05;
	}

	var_07 = [];
	func_12F1E(var_01);
	foreach(var_05 in var_01)
	{
		if(!func_11746(var_05))
		{
			continue;
		}

		func_EC24(var_05);
		var_07[var_07.size] = var_05;
	}

	var_0A = undefined;
	foreach(var_05 in var_07)
	{
		if(!isdefined(var_0A) || var_05.var_11A3B > var_0A.var_11A3B)
		{
			var_0A = var_05;
		}
	}

	return var_0A;
}

//Function Number: 4
func_EC24(param_00)
{
	scripts\mp\_spawnfactor::func_3710(param_00,"avoidShortTimeToEnemySight",1);
	scripts\mp\_spawnfactor::func_3710(param_00,"avoidClosestEnemy",1);
}

//Function Number: 5
func_7E0F(param_00,param_01)
{
	var_02 = (0,param_00.angles[1],0);
	var_03 = findentrances(param_01);
	if(isdefined(var_03) && var_03.size > 0)
	{
		var_02 = vectortoangles(var_03[0].origin - param_01);
	}

	return var_02;
}

//Function Number: 6
func_81B4(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(var_03.team != param_00)
		{
			continue;
		}

		if(var_03 == self)
		{
			continue;
		}

		if(!func_38F0(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return scripts\common\utility::array_randomize(var_01);
}

//Function Number: 7
func_38F0(param_00)
{
	if(param_00.sessionstate != "playing")
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9F19(param_00))
	{
		return 0;
	}

	if(!param_00 isonground())
	{
		return 0;
	}

	if(param_00 method_81B5())
	{
		return 0;
	}

	if(param_00 scripts\common\utility::func_9DFB())
	{
		return 0;
	}

	if(param_00.health < param_00.maxhealth && !isdefined(param_00.var_A965) || gettime() < param_00.var_A965 + 3000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
func_6CC5(param_00)
{
	var_01 = scripts\mp\_spawnlogic::func_8083(param_00,1);
	var_02 = func_6CB0(param_00,var_01,0.5);
	if(isdefined(var_02))
	{
		return var_02.origin;
	}

	return undefined;
}

//Function Number: 9
func_6CB0(param_00,param_01,param_02)
{
	var_03 = getnodesinradiussorted(param_00.origin,192,64,param_01,"Path");
	var_04 = undefined;
	if(isdefined(var_03) && var_03.size > 0)
	{
		var_05 = anglestoforward(param_00.angles);
		foreach(var_07 in var_03)
		{
			var_08 = vectornormalize(var_07.origin - param_00.origin);
			var_09 = vectordot(var_05,var_08);
			if(var_09 <= param_02 && !positionwouldtelefrag(var_07.origin))
			{
				var_04 = var_07;
				if(var_09 <= 0)
				{
					break;
				}
			}
		}
	}

	return var_04;
}

//Function Number: 10
func_6CB5(param_00,param_01,param_02,param_03)
{
	var_04 = getnodesinradiussorted(param_00.origin,param_03,32,param_01,"Path");
	var_05 = undefined;
	if(isdefined(var_04) && var_04.size > 0)
	{
		var_06 = anglestoforward(param_00.angles);
		foreach(var_08 in var_04)
		{
			var_09 = var_08.origin + (0,0,param_01);
			if(capsuletracepassed(var_09,param_02,param_02 * 2 + 0.01,undefined,1,1))
			{
				if(bullettracepassed(param_00 geteye(),var_09,0,param_00))
				{
					var_05 = var_09;
					break;
				}
			}
		}
	}

	return var_05;
}

//Function Number: 11
func_98C8(param_00)
{
	param_00.var_11A3B = 0;
	param_00.var_11A3A = 0;
	param_00.var_9D60 = 0;
	param_00.var_A9E9 = [];
	param_00.var_A9E9["allies"] = 0;
	param_00.var_A9E9["axis"] = 0;
	param_00.var_A9F5 = "";
	param_00.var_A9F6 = 0;
	param_00.var_1E5B = spawnstruct();
	param_00.var_1E5B.var_1D30 = 0;
	param_00.var_1E5B.var_654A = 0;
	param_00.var_1E5B.var_1192A = 0;
	param_00.var_1E5B.var_B498 = 0;
	param_00.var_1E5B.var_DCC5 = 0;
	param_00.var_1E5B.var_B4A5 = 0;
	param_00.var_1E5B.var_1091B = 0;
	param_00.var_1E5B.var_10919 = 0;
}

//Function Number: 12
func_12F1E(param_00)
{
	var_01 = scripts\mp\_spawnlogic::func_8143(self);
	scripts\mp\_spawnlogic::func_12F1F();
	var_02 = scripts\mp\_spawnlogic::func_7D9A();
	foreach(var_04 in param_00)
	{
		func_98C8(var_04);
		scripts\mp\_spawnlogic::func_108F9(var_04,var_02);
		scripts\mp\_spawnlogic::func_67D3(var_04,var_01);
	}

	scripts\mp\_spawnfactor::func_12E98(var_01);
}

//Function Number: 13
func_11748(param_00)
{
	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26B7,param_00))
	{
		param_00.var_275D = 0;
		return "bad";
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26B8,param_00))
	{
		param_00.var_275D = 1;
		return "bad";
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26BC,param_00))
	{
		param_00.var_275D = 2;
		return "bad";
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26AB,param_00))
	{
		param_00.var_275D = 3;
		return "bad";
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26AD,param_00))
	{
		param_00.var_275D = 4;
		return "bad";
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26C4,param_00))
	{
		param_00.var_275D = 5;
		return "bad";
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26B6,param_00))
	{
		param_00.var_275D = 6;
		return "bad";
	}

	if(isdefined(param_00.var_7450) && level.var_744D.var_9D25[self.team] && param_00.var_7450 != self.team)
	{
		param_00.var_275D = 7;
		return "bad";
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26B3,param_00))
	{
		return "secondary";
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26AE,param_00))
	{
		return "secondary";
	}

	return "primary";
}

//Function Number: 14
func_11746(param_00)
{
	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26B7,param_00))
	{
		return 0;
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26B8,param_00))
	{
		return 0;
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26BC,param_00))
	{
		return 0;
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26AB,param_00))
	{
		return 0;
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26AD,param_00))
	{
		return 0;
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26C4,param_00))
	{
		return 0;
	}

	if(!scripts\mp\_spawnfactor::func_4A71(::scripts\mp\_spawnfactor::func_26AE,param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
func_8167(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = undefined;
	var_02 = scripts\mp\_spawnlogic::func_7D9A();
	param_00 = func_3E05(param_00);
	if(!isdefined(var_02) || var_02.size == 0)
	{
		return scripts\mp\_spawnlogic::func_813C(param_00);
	}

	var_03 = 0;
	foreach(var_05 in param_00)
	{
		if(canspawn(var_05.origin) && !positionwouldtelefrag(var_05.origin))
		{
			var_06 = undefined;
			foreach(var_08 in var_02)
			{
				var_09 = distancesquared(var_05.origin,var_08.origin);
				if(!isdefined(var_06) || var_09 < var_06)
				{
					var_06 = var_09;
				}
			}

			if(!isdefined(var_01) || var_06 > var_03)
			{
				var_01 = var_05;
				var_03 = var_06;
			}
		}
	}

	if(!isdefined(var_01))
	{
		return scripts\mp\_spawnlogic::func_813C(param_00);
	}

	return var_01;
}

//Function Number: 16
func_AF98(param_00,param_01)
{
	if(isdefined(param_01) && isdefined(param_01.var_5612) && param_01.var_5612)
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = "";
	}
	else
	{
		param_00 = param_00;
	}

	if(isdefined(level.var_B3FC))
	{
		[[ level.var_B3FC ]]("LOG_BAD_SPAWN",gettime(),param_00);
	}
}

//Function Number: 17
func_8136(param_00,param_01,param_02,param_03)
{
	level.var_108D1.var_108FD = param_00;
	if(level.var_72A2)
	{
		var_04 = func_6CB1();
		if(isdefined(var_04))
		{
			return var_04;
		}
	}

	var_05 = undefined;
	level.var_108D1.var_107FE = 0;
	var_06 = func_8142(param_00,param_02,0);
	if(isdefined(var_06))
	{
		if(!scripts\mp\_utility::func_9FB3(var_06.var_9D60))
		{
			return var_06;
		}
		else
		{
			var_05 = var_06;
		}
	}

	if(isdefined(param_01))
	{
		var_07 = func_8142(param_01,param_02,3);
		if(isdefined(var_07))
		{
			if(scripts\mp\_utility::func_9FB3(var_07.var_9D60))
			{
				if(!isdefined(var_05) || var_07.var_11A3B > var_05.var_11A3B)
				{
					var_05 = var_07;
				}
			}
			else
			{
				func_AF98("Using a fallback spawn.",self);
				return var_07;
			}
		}
	}

	if(scripts\mp\_utility::func_9FB3(param_03))
	{
		return undefined;
	}

	func_AF98("Using a LastResort spawn point.",self);
	var_08 = func_6CB1();
	if(isdefined(var_08))
	{
		var_08.var_10919 = 7;
		level.var_108D1.var_3166 = 0;
		if(isdefined(var_08.var_3164))
		{
			level.var_108D1.var_3164 = var_08.var_3164;
		}

		return var_08;
	}

	func_AF98("UNABLE TO BUDDY SPAWN. EXTREMELY BAD",self);
	if(level.teambased && !scripts\mp\_utility::func_9D46())
	{
		var_09 = level.var_108D1.lastbadspawntime[self.team];
		if(isdefined(var_09) && gettime() - var_09 < 5000)
		{
			var_05 = param_00[randomint(param_00.size)];
		}
		else
		{
			level.var_108D1.lastbadspawntime[self.team] = gettime();
		}
	}

	return var_05;
}

//Function Number: 18
func_8142(param_00,param_01,param_02)
{
	param_00 = func_3E05(param_00);
	var_03["primary"] = [];
	var_03["secondary"] = [];
	var_03["bad"] = [];
	if(scripts\mp\_spawnlogic::func_100B9() && !scripts\mp\_spawnlogic::func_9FB6())
	{
		if(isdefined(level.var_B3FC))
		{
			[[ level.var_B3FC ]]("LOG_GENERIC_MESSAGE",gettime(),"ERROR: TTLOS System disabled! Could not access visDistData");
		}

		if(!isdefined(level.var_8C28))
		{
			level.var_8C28 = 1;
		}

		level.var_560C = 1;
		scripts\mp\_spawnlogic::func_E2B6();
	}

	func_12F1E(param_00);
	foreach(var_05 in param_00)
	{
		var_06 = func_11748(var_05);
		var_03[var_06][var_03[var_06].size] = var_05;
		var_05.var_A94A[scripts\common\utility::func_116D7(isdefined(self.var_108DF),self.var_108DF,self.team)] = var_06;
		if(isdefined(var_05.var_1E5B) && isdefined(var_05.var_1E5B.var_10919))
		{
			if(var_06 == "primary")
			{
				var_05.var_1E5B.var_10919 = param_02 + 1;
				continue;
			}

			if(var_06 == "secondary")
			{
				var_05.var_1E5B.var_10919 = param_02 + 2;
				continue;
			}

			var_05.var_1E5B.var_10919 = param_02 + 3;
		}
	}

	if(var_03["primary"].size)
	{
		var_06 = func_7F01(var_03["primary"],param_01);
		var_06.var_107FE = 1;
		return var_06;
	}

	if(var_03["secondary"].size)
	{
		var_06 = func_7F01(var_03["secondary"],param_01);
		var_06.var_107FE = 2;
		return var_06;
	}

	if(var_03["bad"].size)
	{
		func_AF98("Using Bad Spawn",self);
		var_06 = func_7F01(var_03["bad"],param_01);
		if(isdefined(var_06))
		{
			var_06.var_9D60 = 1;
		}

		return var_06;
	}

	return undefined;
}

//Function Number: 19
func_7F01(param_00,param_01)
{
	var_02 = param_00[0];
	foreach(var_04 in param_00)
	{
		scripts\mp\_spawnlogic::func_EC46(var_04,param_01);
		if(var_04.var_11A3B > var_02.var_11A3B)
		{
			var_02 = var_04;
		}
	}

	var_02 = func_F1AB(var_02,param_00);
	return var_02;
}