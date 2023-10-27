/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3874.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 8 ms
 * Timestamp: 10/27/2023 12:31:05 AM
*******************************************************************/

//Function Number: 1
func_9B1E(param_00,param_01)
{
	self endon("death");
	if(isdefined(param_00))
	{
		param_00 endon("death");
	}

	self notify("investigate_forget");
	self endon("investigate_forget");
	if(!isdefined(param_01))
	{
		param_01 = randomfloatrange(30,45);
	}

	wait(param_01);
	for(var_02 = 0;var_02 < 10;var_02 = var_02 + var_03)
	{
		if(lib_0A1A::func_2354("patrol_move"))
		{
			if(isdefined(self.var_1491.var_C98E) && gettime() - self.var_1491.var_C98E >= 1500)
			{
				self method_84F7("reset",self,self.origin);
				return;
			}
		}

		var_03 = 0.2;
		wait(var_03);
	}

	self method_84F7("reset",self,self.origin);
}

//Function Number: 2
func_9B28(param_00)
{
	self.var_10E6D.var_9B1F = param_00;
	if(scripts\common\utility::istrue(param_00))
	{
		self.var_10E6D.var_C985 = undefined;
		return;
	}

	self.var_10E6D.var_C985 = gettime() + randomfloatrange(20,55);
}

//Function Number: 3
func_9B26(param_00)
{
	if(isdefined(self.var_10E6D.var_2A7D) && self.var_10E6D.var_2A7D == "investigate")
	{
		var_01 = getclosestpointonnavmesh(param_00.var_9B22,self);
		var_02 = 300;
		var_03 = 1000;
		var_04 = 1;
		thread func_9B1E();
		if(isdefined(self.var_10E6D.var_9B20))
		{
			var_05 = vectornormalize(self.var_15B - self.origin);
			var_06 = anglestoforward(self.angles);
			var_07 = vectornormalize(var_01 - self.origin);
			if(isplayer(param_00.var_114) && !isplayer(self.var_10E6D.var_9B1D))
			{
				var_04 = 1;
			}
			else if(vectordot(var_05,var_07) < 0 && vectordot(var_06,var_07) < 0)
			{
				var_04 = 1;
			}
			else if(param_00.var_12AE9 == "saw_corpse")
			{
				var_04 = 1;
			}
			else if(var_04 && distancesquared(self.var_15B,var_01) < squared(var_02))
			{
				var_04 = 0;
			}
		}

		if(var_04)
		{
			func_F076();
			var_08 = func_F079(var_01,1,0,200);
			if(isdefined(var_08) && var_08.size)
			{
				if(param_00.var_12AE9 == "saw_corpse")
				{
					var_08[0].origin = param_00.var_9B22;
				}

				self.var_10E6D.var_9B20 = var_08[0];
				func_F075(var_08);
				self.var_10E6D.var_DD1D = 0;
				func_9B28(1);
			}

			self.var_10E6D.var_9B21 = func_7C3B(var_01,var_02,var_03);
			self notify("stop_runto_and_lookaround");
		}
	}

	return self.var_10E6D.var_9B20;
}

//Function Number: 4
func_9B25()
{
	self.var_10E6D.var_9B20 = undefined;
	self.var_10E6D.var_9B21 = undefined;
	self.var_10E6D.var_9B29 = undefined;
	self.var_10E6D.var_9B1D = undefined;
	func_9B28(undefined);
	self notify("investigate_behavior");
}

//Function Number: 5
func_9B2C()
{
	if(!isdefined(self.var_10E6D))
	{
		return 0;
	}

	return scripts\common\utility::istrue(self.var_10E6D.var_9B1F);
}

//Function Number: 6
func_9B2B(param_00)
{
	if(isplayer(self.var_10E6D.var_9B1D) && !isplayer(param_00.var_114))
	{
		return 1;
	}

	if(isdefined(self.var_10E6D.var_9B29))
	{
		var_01 = lib_0F1C::func_6894(self.var_10E6D.var_9B29,param_00.type);
		if(var_01 >= 0)
		{
			func_9B26(param_00);
			lib_0F27::func_F4C6("seek","seek",param_00.var_9B22);
			self.var_10E6D.var_9B29 = param_00.type;
			self.var_10E6D.var_9B1D = param_00.var_114;
			return 1;
		}
	}

	return 0;
}

//Function Number: 7
func_9B24(param_00)
{
	func_9B25();
	func_9B23(param_00);
}

//Function Number: 8
func_9B23(param_00)
{
	self endon("death");
	self endon("stealth_spotted");
	if(func_9B2B(param_00))
	{
		return;
	}

	self notify("investigate_behavior");
	self endon("investigate_behavior");
	self.var_10E6D.var_9B29 = param_00.type;
	self.var_10E6D.var_9B1D = param_00.var_114;
	lib_0F27::func_EB62();
	self.var_EDB0 = 0;
	thread lib_0F19::func_467C();
	self.var_10E6D.var_2A7D = "investigate";
	self.var_10E6D.var_9B27 = undefined;
	lib_0F26::func_117D4("investigate");
	var_01 = func_9B26(param_00);
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = var_01.origin;
	lib_0F27::func_10EE4(1);
	if(self.var_10E6D.var_10E19 > 1)
	{
		lib_0F27::func_F4C8("seek",1,var_02);
	}

	wait(randomfloatrange(0.2,0.4));
	if(!scripts\sp\_utility::func_65DB("stealth_enabled"))
	{
		return;
	}

	func_9B28(1);
	self.var_15C = 2048;
	var_03 = 300;
	for(;;)
	{
		while(self.var_10E6D.var_9B1F || self.var_10E6D.var_9B21.size <= 0)
		{
			var_04 = !self.var_10E6D.var_DD1D && distancesquared(self.var_10E6D.var_9B20.origin,self.origin) > squared(512);
			var_05 = func_E8A7(self.var_10E6D.var_9B20.origin,var_04);
			if(!self.var_10E6D.var_DD1D)
			{
				self.var_10E6D.var_DD1D = isdefined(var_05) && var_05 != "bad_path";
			}

			if(isdefined(var_05) && var_05 == "bad_path")
			{
				func_9B28(0);
			}
			else
			{
				func_9B28(!self.var_10E6D.var_DD1D);
			}

			if(scripts\common\utility::istrue(self.var_10E6D.var_F077))
			{
				self waittill("got_search_points");
			}

			if(self.var_10E6D.var_9B21.size <= 0)
			{
				func_9B25();
				return;
			}
		}

		var_06 = func_7B1A();
		if(!isdefined(var_06))
		{
			var_06 = func_7A7E(self.var_10E6D.var_9B21,var_03);
		}

		if(!isdefined(var_06))
		{
			self.var_10E6D.var_9B21 = func_7C3B(var_02,300,1000);
			var_06 = func_7A7E(self.var_10E6D.var_9B21,var_03);
		}

		if(!isdefined(var_06))
		{
			self method_84F7("reset",self,self.origin);
			return;
		}

		if(function_02A7(var_06))
		{
		}
		else
		{
			var_06.origin = scripts\common\utility::func_5D14(var_06.origin,8);
		}

		var_04 = !self.var_10E6D.var_DD1D && distancesquared(var_06.origin,self.origin) > squared(512);
		var_05 = func_E8A7(var_06.origin,var_04);
		if(!self.var_10E6D.var_DD1D)
		{
			self.var_10E6D.var_DD1D = isdefined(var_05) && var_05 != "bad_path";
		}
	}
}

//Function Number: 9
func_7B1A()
{
	if(isdefined(self.var_10E6D.var_9B27) && isdefined(self.var_10E6D.var_9B27.target))
	{
		var_00 = function_00B3(self.var_10E6D.var_9B27.target,"targetname");
		if(isdefined(var_00) && distancesquared(var_00.origin,self.origin) > squared(100))
		{
			var_00.var_13070 = gettime();
			return var_00;
		}

		var_00 = scripts\common\utility::getstruct(self.var_10E6D.var_9B27.target,"targetname");
		if(isdefined(var_00) && distancesquared(var_00.origin,self.origin) > squared(100))
		{
			var_00.var_13070 = gettime();
			return var_00;
		}
	}

	return undefined;
}

//Function Number: 10
func_7A7E(param_00,param_01)
{
	self.var_10E6D.var_9B27 = undefined;
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.var_13070))
		{
			var_03.var_13070 = 0;
		}
	}

	param_00 = scripts\common\utility::array_randomize(param_00);
	var_05 = undefined;
	foreach(var_03 in param_00)
	{
		if(distancesquared(var_03.origin,self.origin) < squared(100))
		{
			continue;
		}

		if(!isdefined(var_05))
		{
			var_05 = var_03;
			continue;
		}

		if(isdefined(var_05) && var_03.var_13070 < var_05.var_13070)
		{
			var_05 = var_03;
		}
	}

	if(isdefined(var_05))
	{
		var_05.var_13070 = gettime();
		if(isdefined(var_05.var_336) && var_05.var_336 == "seek_patrol")
		{
			self.var_10E6D.var_9B27 = var_05;
		}
	}

	return var_05;
}

//Function Number: 11
func_F07B(param_00)
{
	var_01 = squared(100);
	if(!isdefined(level.var_10E6D.var_F074))
	{
		level.var_10E6D.var_F074 = [];
	}

	foreach(var_03 in level.var_10E6D.var_F074)
	{
		if(isalive(var_03.var_10EF6) && var_03.var_10EF6 != self)
		{
			var_04 = distancesquared(var_03.origin,param_00);
			if(var_04 < var_01)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 12
func_F076()
{
	if(!isdefined(level.var_10E6D.var_F074))
	{
		return;
	}

	var_00 = [];
	foreach(var_02 in level.var_10E6D.var_F074)
	{
		if(isalive(var_02.var_10EF6))
		{
			if(var_02.var_10EF6 != self)
			{
				var_00[var_00.size] = var_02;
				continue;
			}

			var_02.var_10EF6 = undefined;
		}
	}

	level.var_10E6D.var_F074 = var_00;
}

//Function Number: 13
func_F075(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(level.var_10E6D))
	{
		return;
	}

	if(!isarray(param_00))
	{
		var_01 = [param_00];
		param_00 = var_01;
	}

	if(!isdefined(level.var_10E6D.var_F074))
	{
		level.var_10E6D.var_F074 = [];
	}

	level.var_10E6D.var_F074 = scripts\common\utility::array_combine(level.var_10E6D.var_F074,param_00);
}

//Function Number: 14
func_F079(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	thread func_F07A(param_00,param_01,param_02,param_03);
	self waittill("search_points_random_near_complete");
	if(isdefined(self.var_10E6D.var_F078))
	{
		var_04 = self.var_10E6D.var_F078;
	}

	self.var_10E6D.var_F078 = undefined;
	return var_04;
}

//Function Number: 15
func_F07A(param_00,param_01,param_02,param_03)
{
	self notify("search_points_random_near_thread");
	self endon("search_points_random_near_thread");
	self endon("death");
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1000;
	}

	var_04 = squared(param_03);
	var_05 = squared(param_02);
	var_06 = [];
	if(!isdefined(level.var_10E6D.var_F07C))
	{
		level.var_10E6D.var_F07C = [];
	}

	level.var_10E6D.var_F07C = scripts\sp\_utility::func_DFEB(level.var_10E6D.var_F07C);
	if(!scripts\common\utility::func_2286(level.var_10E6D.var_F07C,self))
	{
		level.var_10E6D.var_F07C[level.var_10E6D.var_F07C.size] = self;
	}

	wait(0.05);
	while(level.var_10E6D.var_F07C.size > 0 && level.var_10E6D.var_F07C[0] != self)
	{
		wait(0.05);
	}

	var_07 = getrandomnavpoints(param_00,param_03,64,self);
	if(isdefined(var_07))
	{
		foreach(var_09 in var_07)
		{
			var_0A = distancesquared(var_09,param_00);
			if(var_0A < var_05)
			{
				continue;
			}

			if(func_F07B(var_09))
			{
				continue;
			}

			var_0B = spawnstruct();
			var_0B.origin = var_09;
			var_0B.var_10EF6 = self;
			var_06[var_06.size] = var_0B;
			if(var_06.size >= param_01)
			{
				break;
			}
		}
	}

	level.var_10E6D.var_F07C = scripts\common\utility::func_22A9(level.var_10E6D.var_F07C,self);
	self.var_10E6D.var_F078 = var_06;
	self notify("search_points_random_near_complete");
}

//Function Number: 16
func_7C3B(param_00,param_01,param_02)
{
	var_03 = 3;
	self.var_10E6D.var_F077 = 1;
	param_00 = getclosestpointonnavmesh(param_00,self);
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1000;
	}

	var_04 = squared(param_02);
	var_05 = squared(param_01);
	var_06 = [];
	var_07 = [];
	var_08 = function_00B4("seek_patrol","targetname");
	var_06 = scripts\common\utility::array_combine(var_08,var_06);
	var_08 = scripts\common\utility::getstructarray("seek_patrol","targetname");
	var_06 = scripts\common\utility::array_combine(var_08,var_06);
	var_06 = sortbydistance(var_06,param_00);
	foreach(var_0A in var_06)
	{
		if(isalive(var_0A.var_10EF6) && var_0A.var_10EF6 != self)
		{
			continue;
		}

		var_0B = distancesquared(var_0A.origin,param_00);
		if(var_0B < var_05)
		{
			continue;
		}

		if(var_0B > var_04)
		{
			break;
		}

		var_07[var_07.size] = var_0A;
		var_0A.var_10EF6 = self;
	}

	if(var_07.size < var_03)
	{
		var_0D = func_F079(param_00,var_03 - var_07.size,param_01,param_02);
		if(isdefined(var_0D) && var_0D.size)
		{
			var_07 = scripts\common\utility::array_combine(var_07,var_0D);
		}
	}

	func_F075(var_07);
	self.var_10E6D.var_F077 = undefined;
	self notify("got_search_points");
	return var_07;
}

//Function Number: 17
func_E8A7(param_00,param_01)
{
	self notify("stop_runto_and_lookaround");
	self endon("stop_runto_and_lookaround");
	self endon("death");
	var_02 = lib_0F27::func_79F6("stealth_spotted");
	level endon(var_02);
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	self.var_10E6D.var_4684 = undefined;
	lib_0F27::func_10EE4(1);
	lib_0F27::func_F4C8("seek",1,param_00);
	if(!isdefined(param_00))
	{
		param_00 = self.origin;
	}

	if(param_01)
	{
		lib_0F27::func_F4C8("run");
		self.var_15C = 256;
	}
	else
	{
		lib_0F27::func_F4C8("seek");
		self.var_15C = 100;
	}

	scripts\sp\_utility::func_F3DC(param_00);
	var_03 = scripts\common\utility::func_13734("goal","bad_path");
	self.var_10E6D.var_9B1D = undefined;
	lib_0F27::func_F4C8("seek");
	self.var_15C = 100;
	if(var_03 == "goal")
	{
		func_B001(randomfloatrange(5,8));
	}

	return var_03;
}

//Function Number: 18
func_B001(param_00)
{
	wait(param_00);
	scripts\sp\_utility::func_4154();
}