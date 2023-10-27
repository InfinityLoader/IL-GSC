/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\track.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 481 ms
 * Timestamp: 10/27/2023 12:01:06 AM
*******************************************************************/

//Function Number: 1
func_11B07()
{
	self endon("killanimscript");
	self endon("stop tracking");
	self endon("melee");
	func_11AF8(%aim_2,%aim_4,%aim_6,%aim_8);
}

//Function Number: 2
func_11AF8(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	var_06 = 0;
	var_07 = (0,0,0);
	var_08 = 1;
	var_09 = 0;
	var_0A = 0;
	var_0B = 10;
	var_0C = (0,0,0);
	if(self.type == "dog")
	{
		var_0D = 0;
		self.var_FE9E = self.var_10C;
	}
	else
	{
		var_0D = 1;
		var_0E = 0;
		var_0F = 0;
		if(isdefined(self.var_4716))
		{
			var_0E = level.var_4717;
		}

		var_10 = self.script;
		if((var_10 == "cover_left" || var_10 == "cover_right") && isdefined(self.var_1491.var_4667) && self.var_1491.var_4667 == "lean")
		{
			var_0F = self.var_473C.angles[1] - self.angles[1];
		}

		var_0C = (var_0E,var_0F,0);
	}

	for(;;)
	{
		func_93E2();
		var_11 = scripts\anim\shared::func_811C();
		var_12 = self.var_FECF;
		if(isdefined(self.var_FE9E))
		{
			var_12 = self.var_FE9E method_815B();
		}

		if(!isdefined(var_12) && scripts\anim\utility::func_FFDB())
		{
			var_12 = func_11AFB(var_11);
		}

		var_13 = isdefined(self.var_C59B) || isdefined(self.var_C4C7);
		var_14 = isdefined(var_12);
		var_15 = (0,0,0);
		if(var_14)
		{
			var_15 = var_12;
		}

		var_16 = 0;
		var_17 = isdefined(self.var_10F8C);
		if(var_17)
		{
			var_16 = self.var_10F8C;
		}

		var_07 = self method_80FA(var_11,var_15,var_14,var_0C,var_16,var_17,var_13);
		var_18 = var_07[0];
		var_19 = var_07[1];
		var_07 = undefined;
		if(scripts\common\utility::func_167E())
		{
			var_1A = self.angles[2] * -1;
			var_1B = var_18 * cos(var_1A) - var_19 * sin(var_1A);
			var_1C = var_18 * sin(var_1A) + var_19 * cos(var_1A);
			var_18 = var_1B;
			var_19 = var_1C;
			var_18 = clamp(var_18,self.var_368,self.var_100);
			var_19 = clamp(var_19,self.var_268,self.var_1B7);
		}

		if(var_0A > 0)
		{
			var_0A = var_0A - 1;
			var_0B = max(10,var_0B - 5);
		}
		else if(self.var_25F && self.var_25F != var_09)
		{
			var_0A = 2;
			var_0B = 30;
		}
		else
		{
			var_0B = 10;
		}

		var_1D = squared(var_0B);
		var_09 = self.var_25F;
		var_1E = self.var_1F5 != "stop" || !var_08;
		if(var_1E)
		{
			var_1F = var_19 - var_05;
			if(squared(var_1F) > var_1D)
			{
				var_19 = var_05 + clamp(var_1F,-1 * var_0B,var_0B);
				var_19 = clamp(var_19,self.var_268,self.var_1B7);
			}

			var_20 = var_18 - var_06;
			if(squared(var_20) > var_1D)
			{
				var_18 = var_06 + clamp(var_20,-1 * var_0B,var_0B);
				var_18 = clamp(var_18,self.var_368,self.var_100);
			}
		}

		var_08 = 0;
		var_05 = var_19;
		var_06 = var_18;
		func_11AFE(param_00,param_01,param_02,param_03,param_04,var_18,var_19);
		wait(0.05);
	}
}

//Function Number: 3
func_11AFB(param_00)
{
	var_01 = undefined;
	var_02 = anglestoforward(self.angles);
	if(isdefined(self.var_4792))
	{
		var_01 = self.var_4792 method_815B();
		if(isdefined(self.var_4796))
		{
			if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.177)
			{
				var_01 = undefined;
			}
		}
		else if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.643)
		{
			var_01 = undefined;
		}
	}

	if(!isdefined(var_01) && isdefined(self.var_478F))
	{
		var_01 = self.var_478F;
		if(isdefined(self.var_4795))
		{
			if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.177)
			{
				var_01 = undefined;
			}
		}
		else if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.643)
		{
			var_01 = undefined;
		}
	}

	return var_01;
}

//Function Number: 4
func_11AF9(param_00,param_01)
{
	if(scripts\anim\utility_common::func_DDC9())
	{
		var_02 = self.var_10C method_815B() - self.var_10C.origin;
		var_03 = self lastknownpos(self.var_10C) + var_02;
		return func_11AFC(var_03 - param_00,param_01);
	}

	var_04 = 0;
	var_05 = 0;
	if(isdefined(self.var_205) && isdefined(level.var_9D8E[self.var_205.type]) && distancesquared(self.origin,self.var_205.origin) < 16)
	{
		var_05 = angleclamp180(self.var_205.angles[1] - self.angles[1]);
	}
	else
	{
		var_06 = self method_80FC();
		if(isdefined(var_06))
		{
			var_05 = angleclamp180(var_06[1] - self.angles[1]);
			var_04 = angleclamp180(var_06[0]);
		}
	}

	return (var_04,var_05,0);
}

//Function Number: 5
func_11AFC(param_00,param_01)
{
	var_02 = vectortoangles(param_00);
	var_03 = 0;
	var_04 = 0;
	if(self.var_2C0 == "up")
	{
		var_03 = 40;
	}
	else if(self.var_2C0 == "down")
	{
		var_03 = -40;
		var_04 = -12;
	}

	var_05 = var_02[0];
	var_05 = angleclamp180(var_05 + param_01[0] + var_03);
	if(isdefined(self.var_10F8C))
	{
		var_06 = var_02[1] - self.var_10F8C;
	}
	else
	{
		var_07 = angleclamp180(self.var_EC - self.angles[1]) * 0.5;
		var_06 = var_02[1] - var_07 + self.angles[1];
	}

	var_06 = angleclamp180(var_06 + param_01[1] + var_04);
	return (var_05,var_06,0);
}

//Function Number: 6
func_11AFA(param_00,param_01,param_02)
{
	if(isdefined(self.var_C59B) || isdefined(self.var_C4C7))
	{
		if(param_01 > self.var_1B7 || param_01 < self.var_268)
		{
			param_01 = 0;
		}

		if(param_00 > self.var_100 || param_00 < self.var_368)
		{
			param_00 = 0;
		}
	}
	else if(param_02 && abs(param_01) > level.var_B480 || abs(param_00) > level.var_B47F)
	{
		param_01 = 0;
		param_00 = 0;
	}
	else
	{
		if(self.var_16B)
		{
			param_01 = clamp(param_01,-10,10);
		}
		else
		{
			param_01 = clamp(param_01,self.var_268,self.var_1B7);
		}

		param_00 = clamp(param_00,self.var_368,self.var_100);
	}

	return (param_00,param_01,0);
}

//Function Number: 7
func_11AFE(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	var_0A = 0;
	var_0B = 0;
	if(param_06 < 0)
	{
		var_0A = param_06 / self.var_268 * self.var_1491.var_1A4B;
		var_09 = 1;
	}
	else if(param_06 > 0)
	{
		var_08 = param_06 / self.var_1B7 * self.var_1491.var_1A4B;
		var_09 = 1;
	}

	if(param_05 < 0)
	{
		var_0B = param_05 / self.var_368 * self.var_1491.var_1A4B;
		var_09 = 1;
	}
	else if(param_05 > 0)
	{
		var_07 = param_05 / self.var_100 * self.var_1491.var_1A4B;
		var_09 = 1;
	}

	self method_82AC(param_00,var_07,0.1,1,1);
	self method_82AC(param_01,var_08,0.1,1,1);
	self method_82AC(param_02,var_0A,0.1,1,1);
	self method_82AC(param_03,var_0B,0.1,1,1);
	if(isdefined(param_04))
	{
		self method_82AC(param_04,var_09,0.1,1,1);
	}
}

//Function Number: 8
func_F641(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 <= 0)
	{
		self.var_1491.var_1A4B = param_00;
		self.var_1491.var_1A4D = param_00;
		self.var_1491.var_1A4C = param_00;
		self.var_1491.var_1A4F = 0;
	}
	else
	{
		if(!isdefined(self.var_1491.var_1A4B))
		{
			self.var_1491.var_1A4B = 0;
		}

		self.var_1491.var_1A4D = self.var_1491.var_1A4B;
		self.var_1491.var_1A4C = param_00;
		self.var_1491.var_1A4F = int(param_01 * 20);
	}

	self.var_1491.var_1A4E = 0;
}

//Function Number: 9
func_93E2()
{
	if(self.var_1491.var_1A4E < self.var_1491.var_1A4F)
	{
		self.var_1491.var_1A4E++;
		var_00 = 1 * self.var_1491.var_1A4E / self.var_1491.var_1A4F;
		self.var_1491.var_1A4B = self.var_1491.var_1A4D * 1 - var_00 + self.var_1491.var_1A4C * var_00;
	}
}