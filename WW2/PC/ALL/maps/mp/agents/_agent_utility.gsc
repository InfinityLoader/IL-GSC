/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agent_utility.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 429 ms
 * Timestamp: 10/27/2023 3:08:47 AM
*******************************************************************/

//Function Number: 1
func_0A5A(param_00)
{
	return isdefined(level.var_A41[self.var_A4B][param_00]);
}

//Function Number: 2
func_0A59(param_00)
{
	return level.var_A41[self.var_A4B][param_00];
}

//Function Number: 3
func_83FE(param_00,param_01)
{
	self.var_1A7 = param_00;
	self.var_A = param_00;
	self.var_12C["team"] = param_00;
	self.var_117 = param_01;
	self setotherent(param_01);
	self setentityowner(param_01);
}

//Function Number: 4
func_5291()
{
	self.var_A4B = "player";
	self.var_12C = [];
	self.var_4B60 = 0;
	self.var_565F = 0;
	self.var_5664 = 1;
	self.var_A87A = 0;
	self.var_57D6 = 0;
	self.var_37CD = self getentitynumber();
	self.var_A4A = 0;
	self.var_A42 = 0;
	self.var_9 = undefined;
	self.var_CA = 0;
	self.var_CE = 0;
	self detachall();
	func_5334(0);
}

//Function Number: 5
func_5334(param_00)
{
	if(!param_00)
	{
		self.var_2319 = undefined;
		self.var_5B84 = undefined;
		self.var_1444 = undefined;
		self.var_48CA = undefined;
		self.var_109 = undefined;
		self.var_805F = undefined;
		self.var_6F65 = undefined;
		self.var_696D = undefined;
		self.var_9AC5 = undefined;
		self.var_2016 = undefined;
		self.var_2310 = undefined;
		self.var_1F63 = undefined;
		self.var_5A3E = undefined;
		self.var_179 = undefined;
		self.var_178 = undefined;
		self.var_5BE2 = undefined;
		self.var_5BE0 = undefined;
		self.var_2F81 = undefined;
		self.var_2F82 = undefined;
		self.var_2F7E = undefined;
		self.var_2F80 = undefined;
		self.var_8AFE = undefined;
		self.var_8AFD = undefined;
	}
	else
	{
		self.var_1444 = 5;
		self.var_48CA = maps\mp\_utility::func_4704();
		self.var_109 = self.var_48CA;
		self.var_179 = self.var_1A7;
		self.var_178 = "playing";
		self.var_8AFE = 0;
		self.var_8AFD = 0;
		self.var_A42 = 1;
		maps\mp\gametypes\_playerlogic::func_8A40();
		maps\mp\perks\_perks::func_73C7();
		if(maps\mp\_utility::func_56FF(self))
		{
			self.var_696D = 1;
			maps\mp\gametypes\_gameobjects::func_5240();
			self.var_2F81 = 0;
			self.var_2F82 = 0;
			self.var_2F7E = 0;
		}
	}

	self.var_2F80 = 1;
}

//Function Number: 6
func_7D2A()
{
	var_00 = undefined;
	if(isdefined(level.var_A4E))
	{
		foreach(var_02 in level.var_A4E)
		{
			if(isdefined(var_02.var_565F) && var_02.var_565F)
			{
				continue;
			}

			if(isdefined(var_02.var_57A5) && var_02.var_57A5)
			{
				continue;
			}

			if(isdefined(var_02.var_A6ED) && var_02.var_A6ED)
			{
				continue;
			}

			if(isdefined(level.var_2DA2) && common_scripts\utility::func_F79(level.var_2DA2,var_02))
			{
				continue;
			}

			var_00 = var_02;
			var_00.var_57A5 = 1;
			break;
		}
	}

	return var_00;
}

//Function Number: 7
func_34A8()
{
	self.var_57A5 = 0;
}

//Function Number: 8
func_5344(param_00,param_01)
{
	param_00 func_34A8();
	param_00 func_5291();
	if(isdefined(param_01))
	{
		param_00.var_A4B = param_01;
	}
}

//Function Number: 9
func_3B8C(param_00)
{
	if(isdefined(level.var_A4E))
	{
		foreach(var_02 in level.var_A4E)
		{
			if((!isdefined(var_02.var_565F) || !var_02.var_565F) && !isdefined(var_02.var_57A5) || !var_02.var_57A5)
			{
				if(isdefined(var_02.var_A6ED) && var_02.var_A6ED)
				{
					continue;
				}

				if(isdefined(level.var_2DA2) && common_scripts\utility::func_F79(level.var_2DA2,var_02))
				{
					continue;
				}

				return var_02;
			}
		}
	}

	return undefined;
}

//Function Number: 10
func_44EE(param_00)
{
	var_01 = func_3B8C(param_00);
	if(isdefined(var_01))
	{
		var_01 func_5291();
		if(isdefined(param_00))
		{
			var_01.var_A4B = param_00;
		}

		return var_01;
	}

	return undefined;
}

//Function Number: 11
func_08A7()
{
	self.var_565F = 1;
}

//Function Number: 12
func_2A73()
{
	thread func_2A74();
}

//Function Number: 13
func_2A74()
{
	self notify("deactivateAgentDelayed");
	self endon("deactivateAgentDelayed");
	if(!isdefined(level.var_2DA2))
	{
		level.var_2DA2 = [];
	}

	if(!common_scripts\utility::func_F79(level.var_2DA2,self))
	{
		level.var_2DA2 = common_scripts\utility::func_F6F(level.var_2DA2,self);
	}

	if(maps\mp\_utility::func_56FF(self))
	{
		lib_050D::func_7CDF();
	}

	removefromcharactersarray(self);
	wait 0.05;
	self.var_565F = 0;
	self.var_4B60 = 0;
	self.var_117 = undefined;
	self.var_2589 = undefined;
	self.var_A6ED = undefined;
	foreach(var_01 in function_02D1())
	{
		if(isdefined(var_01.var_1193))
		{
			foreach(var_04, var_03 in var_01.var_1193)
			{
				if(var_03 == self)
				{
					var_01.var_1193[var_04] = undefined;
				}
			}
		}
	}

	self.var_4BF2 = undefined;
	self detachall();
	self notify("disconnect");
	self method_8494();
	level.var_2DA2 = common_scripts\utility::func_F93(level.var_2DA2,self);
}

//Function Number: 14
func_45BB(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	var_01 = func_43FD(param_00);
	return var_01.size;
}

//Function Number: 15
func_43FD(param_00)
{
	var_01 = [];
	if(!isdefined(level.var_A4E))
	{
		return var_01;
	}

	foreach(var_03 in level.var_A4E)
	{
		if(isdefined(var_03.var_565F) && var_03.var_565F)
		{
			if(param_00 == "all" || var_03.var_A4B == param_00)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 16
func_45C7(param_00)
{
	return func_45C8(param_00,"all");
}

//Function Number: 17
func_45C8(param_00,param_01)
{
	var_02 = 0;
	if(!isdefined(level.var_A4E))
	{
		return var_02;
	}

	foreach(var_04 in level.var_A4E)
	{
		if(isdefined(var_04.var_565F) && var_04.var_565F)
		{
			if(isdefined(var_04.var_117) && var_04.var_117 == param_00)
			{
				if(param_01 == "all" || var_04.var_A4B == param_01)
				{
					var_02++;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 18
func_45AE(param_00)
{
	if(!isdefined(level.var_60A5))
	{
		level.var_60A5 = level.var_608B;
	}
	else
	{
		level.var_60A5++;
	}

	if(maps\mp\_utility::func_585F())
	{
		if(level.var_60A5 > 10000)
		{
			level.var_60A5 = level.var_608B;
		}
	}

	level.var_5CC7[level.var_60A5] = gettime();
	return level.var_60A5;
}

//Function Number: 19
func_470C(param_00,param_01)
{
	var_02 = getnodesinradius(self.var_116,350,64,128,"Path");
	if(!isdefined(var_02) || var_02.size == 0)
	{
		return undefined;
	}

	if(isdefined(level.var_A966) && isdefined(level.var_9DC7))
	{
		var_03 = var_02;
		var_02 = [];
		foreach(var_05 in var_03)
		{
			if(var_05.var_116[2] > level.var_A966 || !ispointinvolume(var_05.var_116,level.var_9DC7))
			{
				var_02[var_02.size] = var_05;
			}
		}
	}

	var_07 = anglestoforward(self.var_1D);
	var_08 = -10;
	var_09 = function_02D4(self);
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
		if(!var_0E doesnodeallowstance("stand"))
		{
			continue;
		}

		var_0F = vectornormalize(var_0E.var_116 - self.var_116);
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
		var_14 = self.var_116 + var_0A;
		var_15 = var_0E.var_116 + var_0A;
		if(var_11 > 0)
		{
			wait 0.05;
		}

		if(!sighttracepassed(var_14,var_15,0,self))
		{
			continue;
		}

		if(param_01)
		{
			if(var_11 > 0)
			{
				wait 0.05;
			}

			var_16 = playerphysicstrace(var_0E.var_116 + var_0A,var_0E.var_116);
			if(distancesquared(var_16,var_0E.var_116) > 1)
			{
				continue;
			}
		}

		if(param_00)
		{
			if(var_11 > 0)
			{
				wait 0.05;
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

//Function Number: 20
func_5A28(param_00)
{
	param_00 dodamage(param_00.var_BC + 500000,param_00.var_116);
}

//Function Number: 21
func_5A39()
{
	self [[ func_0A59("on_damaged") ]](level,undefined,self.var_BC + 1,0,"MOD_CRUSH","none",(0,0,0),(0,0,0),"none",0,"");
}

//Function Number: 22
deleteentonagentdeath(param_00)
{
	if(!isdefined(self.agentondeathcleanup))
	{
		self.agentondeathcleanup = [];
	}

	self.agentondeathcleanup[self.agentondeathcleanup.size] = param_00;
	thread watchentdeleteforagentdeath(param_00);
}

//Function Number: 23
watchentdeleteforagentdeath(param_00)
{
	self endon("death");
	param_00 common_scripts\utility::knock_off_battery("death","entitydeleted");
	self.agentondeathcleanup = common_scripts\utility::func_F93(self.agentondeathcleanup,param_00);
}

//Function Number: 24
cleanupentsonagentdeath()
{
	if(isdefined(self.agentondeathcleanup))
	{
		foreach(var_01 in self.agentondeathcleanup)
		{
			if(isdefined(var_01))
			{
				var_01 delete();
			}
		}
	}
}

//Function Number: 25
get_max_agents()
{
	var_00 = function_01F0();
	if(isdefined(level.overridemaxagents))
	{
		var_00 = level.overridemaxagents;
	}

	return var_00;
}