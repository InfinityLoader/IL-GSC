/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3115.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:26:08 AM
*******************************************************************/

//Function Number: 1
func_98E5(param_00)
{
	if(isdefined(self.spawner) && self.spawner func_10863())
	{
		self.entered_playspace = 1;
	}

	if(isdefined(level.var_93A2))
	{
		if(self [[ level.var_93A2 ]]())
		{
			self.entered_playspace = 1;
		}
	}

	return level.var_111AE;
}

//Function Number: 2
func_10863()
{
	if(isdefined(self.var_EE79) && self.var_EE79 == "no_boards" || self.var_EE79 == "ground_spawn_no_boards")
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
func_102D4(param_00)
{
	var_01 = gettime();
	if(isdefined(self.var_102D5))
	{
		if(var_01 >= self.var_102D5)
		{
			self.var_102D5 = undefined;
			return level.var_6AD5;
		}

		return level.var_E87A;
	}

	if(!isdefined(self.var_4B26))
	{
		self.var_102D5 = var_01 + 800;
		return level.var_E87A;
	}

	var_02 = distance2d(self.origin,self.var_4B26.origin);
	if(var_02 < 250)
	{
		return level.var_6AD5;
	}

	if(var_02 > 800)
	{
		self.var_102D5 = var_01 + 500;
		return level.var_E87A;
	}

	var_02 = var_02 - 250;
	var_03 = var_02 / 550;
	self.var_102D5 = var_01 + 200 + int(var_03 * 300);
	return level.var_E87A;
}

//Function Number: 4
func_10004(param_00)
{
	if(isdefined(level.var_71D7))
	{
		if(!self [[ level.var_71D7 ]]())
		{
			return level.var_6AD5;
		}
		else if(self.var_8C35)
		{
			return level.var_6AD5;
		}
	}

	return level.var_111AE;
}

//Function Number: 5
func_5827()
{
	self endon("AbortEnterPlayspace");
	self.var_2A90 = 1;
	self [[ level.var_71D6 ]]();
	self.var_2A90 = 0;
}

//Function Number: 6
func_6628(param_00)
{
	self.var_2BE7 = 1;
}

//Function Number: 7
func_6629(param_00)
{
	self notify("AbortEnterPlayspace");
}

//Function Number: 8
func_6627(param_00)
{
	if(scripts\common\utility::istrue(self.entered_playspace))
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 9
func_3E48(param_00)
{
	if(!scripts\common\utility::istrue(self.var_EF64))
	{
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 10
func_3E29(param_00)
{
	if(self.var_180)
	{
		lib_0A1B::func_2914();
		return level.var_6AD5;
	}

	lib_0A1B::func_2914();
	if(!isdefined(self.var_4B26))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_4B26.ignoreme) && self.var_4B26.ignoreme == 1)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_4B26.killing_time))
	{
		return level.var_6AD5;
	}

	if(self.var_1B03 == "melee" || scripts\mp\agents\_scriptedagents::func_9F77())
	{
		return level.var_6AD5;
	}

	if(!lib_0F74::func_8B76())
	{
		return level.var_6AD5;
	}

	if(lib_0F74::func_138E7())
	{
		return level.var_6AD5;
	}

	if(lib_0F74::func_54BF())
	{
		return level.var_6AD5;
	}

	var_01 = scripts\common\utility::istrue(self.var_B104) && isdefined(self.var_B100) && gettime() - self.var_B100 <= self.var_B0FE;
	if(!ispointonnavmesh(self.var_4B26.origin,self) && !lib_0A1B::func_2955())
	{
		if(!lib_0F74::func_DD7C("offmesh"))
		{
			return level.var_6AD5;
		}
	}
	else if(lib_0F74::func_54BE() || var_01)
	{
		if(!lib_0F74::func_DD7C("base"))
		{
			return level.var_6AD5;
		}
	}
	else if(!lib_0F74::func_DD7C("normal"))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_B603))
	{
		var_02 = gettime() - self.var_A9B8;
		if(var_02 < self.var_B603 * 1000)
		{
			return level.var_6AD5;
		}
	}

	if(!isdefined(self.var_A9B9) || distancesquared(self.var_A9B9,self.origin) > 256)
	{
		if(!isdefined(self.var_2303.var_4B12))
		{
			var_03 = self.var_1F5;
		}
		else
		{
			var_03 = self.var_2303.var_4B12;
		}

		self.var_B629 = var_03;
	}

	lib_0A1B::func_2965(self.var_4B26);
	return level.var_6AD5;
}

//Function Number: 11
func_3E4F(param_00)
{
	if(!scripts\common\utility::istrue(self.var_9CDD))
	{
		return level.var_6AD5;
	}

	lib_0A1B::func_2914();
	if(self.var_180)
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_4B26))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_4B26.ignoreme) && self.var_4B26.ignoreme == 1)
	{
		return level.var_6AD5;
	}

	if(self.var_1B03 == "melee" || scripts\mp\agents\_scriptedagents::func_9F77())
	{
		return level.var_6AD5;
	}

	if(!lib_0F74::func_8B76())
	{
		return level.var_6AD5;
	}

	if(!func_13D9D(self.var_4B26))
	{
		return level.var_6AD5;
	}

	func_296B(self.var_4B26);
	return level.var_6AD5;
}

//Function Number: 12
func_296B(param_00)
{
	self.var_1198.var_3134 = 1;
}

//Function Number: 13
func_13D9D(param_00)
{
	return distancesquared(self.origin,param_00.origin) <= 5625;
}

//Function Number: 14
func_3D46(param_00)
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

//Function Number: 15
func_F108(param_00)
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
			var_09 = var_05[0].origin;
			var_0A = getclosestpointonnavmesh(var_09,self);
			if(distancesquared(var_0A,var_05[0].origin) > var_08)
			{
				return level.var_6AD5;
			}

			self method_8286(var_0A);
			self.var_2AB8 = 0;
		}

		lib_0A1B::func_297E(1);
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 16
func_C0B6(param_00)
{
	lib_0A1B::func_297E(0);
	if(isdefined(level.var_71A7))
	{
		var_01 = 200;
		if(!isdefined(self.var_233) || distancesquared(self.var_233,self.origin) < var_01 * var_01)
		{
			var_02 = self [[ level.var_71A7 ]]();
			if(isdefined(var_02))
			{
				self method_8286(var_02);
			}
			else
			{
				self method_841F();
			}
		}
	}
	else
	{
		self method_841F();
	}

	return level.var_111AE;
}