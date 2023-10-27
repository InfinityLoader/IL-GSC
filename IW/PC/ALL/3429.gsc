/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3429.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:27:26 AM
*******************************************************************/

//Function Number: 1
func_1908(param_00)
{
	return level.agent_funcs[self.agent_type][param_00];
}

//Function Number: 2
func_F290(param_00,param_01)
{
	self.team = param_00;
	self.var_20 = param_00;
	self.pers["team"] = param_00;
	self.var_222 = param_01;
	self method_831F(param_01);
	self method_82DD(param_01);
}

//Function Number: 3
func_97C2()
{
	self.agent_type = "player";
	self.pers = [];
	self.var_8BE2 = 0;
	self.var_9D25 = 0;
	self.var_9D2B = 1;
	self.var_1391E = 0;
	self.var_10916 = 0;
	self.var_6640 = self getentitynumber();
	self.var_18FE = 0;
	self.var_18F2 = 0;
	self.var_1F = undefined;
	self detachall();
	func_98BB(0);
}

//Function Number: 4
func_98BB(param_00)
{
	if(!param_00)
	{
		self.var_4004 = undefined;
		self.var_A95C = undefined;
		self.var_BCF6 = undefined;
		self.var_26B9 = undefined;
		self.var_86BD = undefined;
		self.name = undefined;
		self.var_EB6A = undefined;
		self.var_CA5B = undefined;
		self.var_13CA0 = undefined;
		self.var_C47E = undefined;
		self.var_C2AD = undefined;
		self.var_11A46 = undefined;
		self.var_3AF7 = undefined;
		self.var_3FFA = undefined;
		self.var_38ED = undefined;
		self.var_A64F = undefined;
		self.sessionteam = undefined;
		self.sessionstate = undefined;
		self.var_A9F6 = undefined;
		self.var_A9F4 = undefined;
		self.var_55E6 = undefined;
		self.disabledweaponswitch = undefined;
		self.var_55D9 = undefined;
		self.var_55E4 = undefined;
		self.var_FC96 = undefined;
		self.var_FC95 = undefined;
		self.var_DDCC = undefined;
	}
	else
	{
		self.var_BCF6 = 1;
		self.var_26B9 = 4;
		self.var_86BD = scripts\mp\_utility::func_81EC();
		self.name = self.var_86BD;
		self.sessionteam = self.team;
		self.sessionstate = "playing";
		self.var_FC96 = 0;
		self.var_FC95 = 0;
		self.var_DDCC = 0;
		self.var_18F2 = 1;
		scripts\mp\_playerlogic::func_FAE7();
		thread scripts\mp\perks\_perks::func_C57B();
		if(scripts\mp\_utility::func_9E0E(self))
		{
			self.var_C2AD = 1;
			scripts\mp\_gameobjects::func_96DF();
			self.var_55E6 = 0;
			self.disabledweaponswitch = 0;
			self.var_55D9 = 0;
		}
	}

	self.var_55E4 = 1;
}

//Function Number: 5
func_7EC5(param_00)
{
	var_01 = undefined;
	if(isdefined(level.var_1900))
	{
		foreach(var_03 in level.var_1900)
		{
			if(!isdefined(var_03.var_9D25) || !var_03.var_9D25)
			{
				if(isdefined(var_03.var_136FD) && var_03.var_136FD)
				{
					continue;
				}

				var_01 = var_03;
				var_01 func_97C2();
				if(isdefined(param_00))
				{
					var_01.agent_type = param_00;
				}

				break;
			}
		}
	}

	return var_01;
}

//Function Number: 6
func_1601()
{
	self.var_9D25 = 1;
}

//Function Number: 7
func_4DDB()
{
	thread func_4DDC();
}

//Function Number: 8
func_4DDC()
{
	self notify("deactivateAgentDelayed");
	self endon("deactivateAgentDelayed");
	if(scripts\mp\_utility::func_9E0E(self))
	{
		scripts\mp\_spawnlogic::func_E113();
	}

	scripts\mp\_spawnlogic::func_E106();
	wait(0.05);
	self.var_9D25 = 0;
	self.var_8BE2 = 0;
	self.var_222 = undefined;
	self.var_4539 = undefined;
	self.var_136FD = undefined;
	foreach(var_01 in level.var_3CB5)
	{
		if(isdefined(var_01.var_2507))
		{
			foreach(var_04, var_03 in var_01.var_2507)
			{
				if(var_03 == self)
				{
					var_01.var_2507[var_04] = undefined;
				}
			}
		}
	}

	if(isdefined(self.var_8C98))
	{
		self detach(self.var_8C98);
		self.var_8C98 = undefined;
	}

	self notify("disconnect");
}

//Function Number: 9
func_8008(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	var_01 = func_7D95(param_00);
	return var_01.size;
}

//Function Number: 10
func_7D95(param_00)
{
	var_01 = [];
	if(!isdefined(level.var_1900))
	{
		return var_01;
	}

	foreach(var_03 in level.var_1900)
	{
		if(isdefined(var_03.var_9D25) && var_03.var_9D25)
		{
			if(param_00 == "all" || var_03.agent_type == param_00)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 11
func_8010(param_00)
{
	return func_8011(param_00,"all");
}

//Function Number: 12
func_8011(param_00,param_01)
{
	var_02 = 0;
	if(!isdefined(level.var_1900))
	{
		return var_02;
	}

	foreach(var_04 in level.var_1900)
	{
		if(isdefined(var_04.var_9D25) && var_04.var_9D25)
		{
			if(isdefined(var_04.var_222) && var_04.var_222 == param_00)
			{
				if((param_01 == "all" && var_04.agent_type != "alien") || var_04.agent_type == param_01)
				{
					var_02++;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 13
func_8012(param_00,param_01)
{
	var_02 = 0;
	if(!isdefined(level.var_1900))
	{
		return var_02;
	}

	foreach(var_04 in level.var_1900)
	{
		if(isdefined(var_04.var_9D25) && var_04.var_9D25)
		{
			if(isdefined(var_04.team) && var_04.team == param_00)
			{
				if((param_01 == "all" && var_04.agent_type != "alien") || var_04.agent_type == param_01)
				{
					var_02++;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 14
func_81FB(param_00,param_01)
{
	var_02 = getnodesinradius(self.origin,350,64,128,"Path");
	if(!isdefined(var_02) || var_02.size == 0)
	{
		return undefined;
	}

	if(isdefined(level.var_13BBA) && isdefined(level.var_127CE))
	{
		var_03 = var_02;
		var_02 = [];
		foreach(var_05 in var_03)
		{
			if(var_05.origin[2] > level.var_13BBA || !function_010F(var_05.origin,level.var_127CE))
			{
				var_02[var_02.size] = var_05;
			}
		}
	}

	var_07 = anglestoforward(self.angles);
	var_08 = -10;
	var_09 = scripts\mp\_spawnlogic::func_8083(self);
	var_0A = (0,0,var_09);
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_0B = [];
	var_0C = [];
	foreach(var_0E in var_02)
	{
		if(!var_0E method_80B1("stand") || isdefined(var_0E.var_BFDB))
		{
			continue;
		}

		var_0F = vectornormalize(var_0E.origin - self.origin);
		var_10 = vectordot(var_07,var_0F);
		for(var_11 = 0;var_11 < var_0C.size;var_11++)
		{
			if(var_10 > var_0C[var_11])
			{
				for(var_12 = var_0C.size;var_12 > var_11;var_12--)
				{
					var_0C[var_12] = var_0C[var_12 - 1];
					var_0B[var_12] = var_0B[var_12 - 1];
				}

				break;
			}
		}

		var_0B[var_11] = var_0E;
		var_0C[var_11] = var_10;
	}

	for(var_11 = 0;var_11 < var_0B.size;var_11++)
	{
		var_0E = var_0B[var_11];
		var_14 = self.origin + var_0A;
		var_15 = var_0E.origin + var_0A;
		if(var_11 > 0)
		{
			wait(0.05);
		}

		if(!sighttracepassed(var_14,var_15,0,self))
		{
			continue;
		}

		if(param_01)
		{
			if(var_11 > 0)
			{
				wait(0.05);
			}

			var_16 = playerphysicstrace(var_0E.origin + var_0A,var_0E.origin);
			if(distancesquared(var_16,var_0E.origin) > 1)
			{
				continue;
			}
		}

		if(param_00)
		{
			if(var_11 > 0)
			{
				wait(0.05);
			}

			var_16 = physicstrace(var_14,var_15);
			if(distancesquared(var_16,var_15) > 1)
			{
				continue;
			}
		}

		return var_0E;
	}
}

//Function Number: 15
func_A632(param_00)
{
	param_00 dodamage(param_00.health + 500000,param_00.origin);
}

//Function Number: 16
func_A649()
{
	self [[ func_1908("on_damaged") ]](level,undefined,self.health + 1,0,"MOD_CRUSH","none",(0,0,0),(0,0,0),"none",0);
}