/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_chill_common.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 468 ms
 * Timestamp: 10/27/2023 12:28:18 AM
*******************************************************************/

//Function Number: 1
func_3E6E()
{
	var_00 = spawnstruct();
	var_00.var_2B9C = [];
	var_00.var_2B9D = [];
	var_00.var_2B97 = [];
	var_00.var_2B9C[0] = "chilledInit";
	var_00.var_2B9D[0] = "activeWeak";
	var_00.var_2B97[0] = 2;
	var_00.var_2B9C[1] = "chilledInit";
	var_00.var_2B9D[1] = "active";
	var_00.var_2B97[1] = 2;
	level.var_3E6B = var_00;
}

//Function Number: 2
func_3E69(param_00,param_01)
{
	if(!isdefined(self.var_3E6B))
	{
		self.var_3E6B = spawnstruct();
	}

	var_02 = self.var_3E6B;
	thread func_3E6A();
	if(!isdefined(var_02.var_19))
	{
		self notify("chill");
		var_02.var_19 = 1;
		var_02.var_109AE = 0;
		var_02.var_11921 = [];
		param_01 = param_01 * 1000;
		var_03 = gettime();
		var_04 = var_03 + param_01;
		var_02.var_11921[param_00] = (var_03,var_04,param_01);
		func_3E6C();
		self setscriptablepartstate("chilled","active",0);
		thread func_3E75();
		return;
	}

	if(!isdefined(var_04.var_11921[var_02]))
	{
		var_04.var_19++;
	}

	var_03 = var_03 * 1000;
	var_03 = gettime();
	var_04 = var_04 + var_02;
	var_02.var_11921[param_00] = (var_03,var_04,param_01);
}

//Function Number: 3
func_3E76(param_00)
{
	var_01 = self.var_3E6B;
	var_01.var_19--;
	var_01.var_11921[param_00] = undefined;
	if(var_01.var_19 == 0)
	{
		self notify("chillEnd");
		func_3E6D();
		self setscriptablepartstate("chilled","neutral",0);
		self.var_3E6B = undefined;
		scripts\mp\_weapons::func_12ED5();
	}
}

//Function Number: 4
func_9D8A()
{
	var_00 = self.var_3E6B;
	return isdefined(var_00) && isdefined(var_00.var_19);
}

//Function Number: 5
func_3E70()
{
	self notify("chillReset");
	self.var_3E6B = undefined;
}

//Function Number: 6
func_3E71()
{
	self setscriptablepartstate("chilled","neutral",0);
	foreach(var_01 in level.var_3E6B.var_2B9C)
	{
		self setscriptablepartstate(var_01,"neutral",0);
	}
}

//Function Number: 7
func_3E6C()
{
	scripts\common\utility::func_1C67(0);
	scripts\common\utility::func_1C64(0);
	scripts\common\utility::func_1C70(0);
	if(!level.tactical)
	{
		scripts\common\utility::func_1C42(0);
	}

	scripts\common\utility::func_1C52(0);
}

//Function Number: 8
func_3E6D()
{
	scripts\common\utility::func_1C67(1);
	scripts\common\utility::func_1C64(1);
	scripts\common\utility::func_1C70(1);
	if(!level.tactical)
	{
		scripts\common\utility::func_1C42(1);
	}

	scripts\common\utility::func_1C52(1);
}

//Function Number: 9
func_3E6A()
{
	self endon("death");
	self endon("disconnect");
	var_00 = self.var_3E6B;
	var_01 = level.var_3E6B;
	var_02 = var_00.var_2B9B;
	var_03 = scripts\common\utility::func_116D7(scripts\mp\_utility::_hasperk("specialty_stun_resistance"),0,1);
	var_04 = var_01.var_2B9C[var_03];
	var_05 = var_01.var_2B9D[var_03];
	var_06 = var_01.var_2B97[var_03];
	if(!isdefined(var_02))
	{
		self setscriptablepartstate(var_04,var_05,0);
		var_00.var_2B9B = var_03;
	}
	else
	{
		if(var_02 > var_03)
		{
			return;
		}

		var_07 = var_01.var_2B9C[var_02];
		if(var_07 != var_04)
		{
			self setscriptablepartstate(var_07,"neutral",0);
		}

		self setscriptablepartstate(var_04,var_05,0);
		var_00.var_2B9B = var_03;
	}

	self notify("chillBlind");
	self endon("chillBlind");
	scripts\common\utility::waittill_any_timeout_1(var_06,"chillEnd");
	self setscriptablepartstate(var_04,"neutral",0);
	var_00.var_2B9B = undefined;
}

//Function Number: 10
func_3E75()
{
	self endon("disconnect");
	self endon("chillReset");
	self endon("chillEnd");
	var_00 = self.var_3E6B;
	for(;;)
	{
		var_01 = gettime();
		var_02 = 0;
		foreach(var_0A, var_04 in var_00.var_11921)
		{
			var_05 = var_04[0];
			var_06 = var_04[1];
			var_07 = var_04[2];
			if(var_01 < var_06)
			{
				var_08 = var_01 - var_05;
				var_09 = 1 - var_08 / var_07;
				if(var_09 > var_02)
				{
					var_02 = var_09;
				}

				continue;
			}

			thread func_3E76(var_0A);
		}

		var_00.var_109AE = var_02 * -0.55;
		scripts\mp\_weapons::func_12ED5();
		wait(0.1);
	}
}