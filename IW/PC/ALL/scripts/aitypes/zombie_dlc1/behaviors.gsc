/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\zombie_dlc1\behaviors.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 144 ms
 * Timestamp: 10/26/2023 11:59:05 PM
*******************************************************************/

//Function Number: 1
checkscripteddlc1(param_00)
{
	return lib_0C2B::func_3E48(param_00);
}

//Function Number: 2
chaseenemydlc1(param_00)
{
	lib_0A1B::func_297E(1);
	if(self.var_180)
	{
		self.var_4B26 = undefined;
		return level.var_6AD5;
	}

	if(isdefined(self.var_8C35) && self.var_8C35)
	{
		self.var_C189 = 0;
	}

	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_10C.var_9BE1) || isdefined(self.var_10C.var_9C54))
	{
		self.var_4B26 = undefined;
		return level.var_6AD5;
	}

	if(isdefined(self.var_10C.killing_time))
	{
		self.var_4B26 = undefined;
		return level.var_6AD5;
	}

	var_01 = undefined;
	if(isdefined(self.var_571B) && lib_0F74::func_100AB())
	{
		var_01 = self.var_571B;
	}
	else if(isdefined(self.attackent))
	{
		var_01 = self.attackent;
	}
	else if(isdefined(self.var_10C) && !lib_0F74::func_1002C(self.var_10C))
	{
		var_01 = self.var_10C;
	}

	if(!isdefined(var_01))
	{
		if(isdefined(self.var_4B26))
		{
			self.var_2AB8 = 1;
		}

		self.var_4B26 = undefined;
		return level.var_6AD5;
	}

	var_03 = self.var_252B + self.var_257 * 2;
	var_04 = var_03 * var_03;
	var_05 = self.var_252B;
	var_06 = var_05 * var_05;
	self.var_4B26 = var_01;
	var_07 = lib_0F74::func_7FAA(var_01);
	var_08 = var_07.var_656D;
	var_09 = distancesquared(var_07.origin,self.origin);
	var_0A = distancesquared(var_08,self.origin);
	var_0B = self.var_2AB8;
	if(var_0A < squared(self.var_257) && distancesquared(var_08,var_07.origin) > squared(self.var_257))
	{
		var_0B = 1;
		self notify("attack_anim","end");
	}

	if(!var_0B && var_0A > var_04 && var_09 > var_06)
	{
		var_0B = 1;
	}

	if(var_07.var_1312B)
	{
		if(!var_0B && var_0A <= var_04 && var_09 > squared(self.var_503C))
		{
			var_0B = 1;
		}

		self method_8287(self.var_503C);
	}
	else if(!lib_0F74::func_8C39(var_01,self.var_B640))
	{
		self method_8287(self.var_503C);
		var_0B = 1;
	}
	else
	{
		self method_8287(var_03);
		if(var_0A <= var_04)
		{
			var_07.origin = self.origin;
			var_0B = 1;
		}
	}

	if(var_0B)
	{
		var_02 = getclosestpointonnavmesh(var_07.origin);
		if(distancesquared(var_02,var_07.origin) > 10000)
		{
			return level.var_6AD5;
		}

		self method_8286(var_02);
	}

	return level.var_111AE;
}

//Function Number: 3
seekenemydlc1(param_00)
{
	if(isdefined(self.var_5969))
	{
		return level.var_6AD5;
	}

	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(var_03.ignoreme || isdefined(var_03.var_222) && var_03.var_222.ignoreme)
		{
			continue;
		}

		if(lib_0F74::func_1002C(var_03))
		{
			continue;
		}

		if(!isalive(var_03))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	var_05 = undefined;
	if(var_01.size > 0)
	{
		var_05 = sortbydistance(var_01,self.origin);
	}

	if(isdefined(var_05) && var_05.size > 0)
	{
		var_06 = 300;
		var_07 = distancesquared(var_05[0].origin,self.origin);
		if(var_07 < var_06 * var_06)
		{
			var_06 = 16;
		}

		var_08 = var_06 * var_06;
		if(self.var_2AB8 || distancesquared(self method_827E(),var_05[0].origin) > var_08)
		{
			var_09 = isdefined(var_05[0].zipline);
			var_0A = var_05[0].origin;
			if(var_09)
			{
				var_0A = var_05[0].zipline.traversal_end;
			}

			var_0B = getclosestpointonnavmesh(var_0A,self);
			if(!var_09 && distancesquared(var_0B,var_05[0].origin) > var_08)
			{
				return level.var_6AD5;
			}

			self method_8286(var_0B);
			self.var_2AB8 = 0;
		}

		lib_0A1B::func_297E(1);
		return level.var_111AE;
	}

	return level.var_6AD5;
}