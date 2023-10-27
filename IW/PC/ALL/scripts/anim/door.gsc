/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\door.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 636 ms
 * Timestamp: 10/27/2023 12:00:33 AM
*******************************************************************/

//Function Number: 1
func_5A09()
{
	self endon("killanimscript");
	if(isdefined(self.var_55DA))
	{
		return;
	}

	for(;;)
	{
		var_00 = self method_811E();
		if(isdefined(var_00))
		{
			break;
		}

		wait(0.2);
	}

	var_01 = var_00.type == "Door Interior" || self method_808A(var_00);
	if(var_01)
	{
		func_5A06(var_00);
	}
	else
	{
		func_5A0A(var_00);
	}

	for(;;)
	{
		var_02 = self method_811E();
		if(!isdefined(var_02) || var_02 != var_00)
		{
			break;
		}

		wait(0.2);
	}

	thread func_5A09();
}

//Function Number: 2
func_115CD()
{
	self endon("killanimscript");
	self.var_115CE = 1;
	wait(5);
	self.var_115CE = undefined;
}

//Function Number: 3
func_5817(param_00)
{
	thread func_115CD();
	if(self.var_166 == "flash_grenade")
	{
		self notify("flashbang_thrown");
	}

	self method_8221("face current");
	param_00.var_BF7D = gettime() + 5000;
	self.var_B7B5 = gettime() + 100000;
	self notify("move_interrupt");
	self.var_12DEF = undefined;
	self method_806F(%combatrun,0.2);
	self.var_1491.var_BCC8 = "stop";
	self waittill("done_grenade_throw");
	self method_8221("face default");
	self.var_B7B5 = gettime() + 5000;
	self.var_166 = self.var_C3F2;
	self.var_C3F2 = undefined;
	scripts\anim\run::func_6318();
	thread scripts\anim\move::func_C968();
	thread scripts\anim\move::func_E2B4(1);
}

//Function Number: 4
func_5A08(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	var_06 = 3;
	var_07 = undefined;
	var_08 = anglestoforward(param_00.angles);
	if(param_00.type == "Door Interior" && !self method_808A(param_00))
	{
		var_08 = -1 * var_08;
	}

	var_09 = (param_00.origin[0],param_00.origin[1],param_00.origin[2] + 64);
	var_0A = var_09;
	if(param_02)
	{
		var_0B = anglestoright(param_00.angles);
		var_0C = param_00.origin - self.origin;
		var_0D = vectordot(var_0B,var_0C);
		if(var_0D > 20)
		{
			var_0D = 20;
		}
		else if(var_0D < -20)
		{
			var_0D = -20;
		}

		var_0A = var_09 + var_0D * var_0B;
	}

	while(var_06 > 0)
	{
		if(isdefined(self.var_15F) || !isdefined(self.var_10C))
		{
			return;
		}

		if(func_C586(param_00,var_08))
		{
			return;
		}

		if(!self method_8296(self.var_10C,0.2) && self.var_1491.var_D6A5 == "stand" && func_56F2(self.var_10C.origin - param_00.origin,360000,16384))
		{
			if(isdefined(param_00.var_BF7D) && param_00.var_BF7D > gettime())
			{
				return;
			}

			if(self method_8061())
			{
				return;
			}

			var_0C = param_00.origin - self.origin;
			if(lengthsquared(var_0C) < param_03)
			{
				return;
			}

			if(vectordot(var_0C,var_08) < 0)
			{
				return;
			}

			self.var_C3F2 = self.var_166;
			self.var_166 = param_01;
			scripts\anim\combat_utility::func_F62B(self.var_10C);
			if(!var_05)
			{
				var_0E = var_09 + var_08 * 100;
				if(!self method_81A2(self.var_10C,var_0E,128))
				{
					return;
				}
			}

			var_05 = 1;
			if(scripts\anim\combat_utility::func_128A2(self.var_10C,var_0A,var_07,scripts\anim\combat_utility::func_7EE8(var_07),1,0,1))
			{
				func_5817(param_00);
				return;
			}
		}

		var_06--;
		wait(param_04);
		var_0F = self method_811E();
		if(!isdefined(var_0F) || var_0F != param_00)
		{
			return;
		}
	}
}

//Function Number: 5
func_940A()
{
	self endon("killanimscript");
	if(isdefined(self.var_55DA))
	{
		return;
	}

	self.var_9E45 = 0;
	for(;;)
	{
		if(self method_81A4() && !self.var_FC)
		{
			func_5A07();
		}
		else if(!isdefined(self.var_B7B5) || self.var_B7B5 < gettime())
		{
			self.var_B7B5 = undefined;
			func_5A0B();
		}

		wait(0.2);
	}
}

//Function Number: 6
func_5A07()
{
	if(!isdefined(self.var_BEF7) && !self.var_FC)
	{
		self.var_9E45 = 1;
		if(!scripts\anim\utility::func_9D9B())
		{
			scripts\sp\_utility::func_61E7(1);
		}
	}
}

//Function Number: 7
func_5A0B()
{
	if(!isdefined(self.var_4797))
	{
		self.var_9E45 = 0;
		if(scripts\anim\utility::func_9D9B())
		{
			scripts\sp\_utility::func_5514();
		}
	}
}

//Function Number: 8
func_56F2(param_00,param_01,param_02)
{
	return param_00[0] * param_00[0] + param_00[1] * param_00[1] < param_01 && param_00[2] * param_00[2] < param_02;
}

//Function Number: 9
func_C586(param_00,param_01)
{
	var_02 = param_00.origin - self.origin;
	var_03 = param_00.origin - self.var_10C.origin;
	return vectordot(var_02,param_01) * vectordot(var_03,param_01) > 0;
}

//Function Number: 10
func_5A06(param_00)
{
	for(;;)
	{
		if(isdefined(self.var_5A0F) && self.var_5A0F == 0 || self.var_5A0F < randomfloat(1))
		{
			break;
		}

		if(func_56F2(self.origin - param_00.origin,562500,25600))
		{
			func_5A08(param_00,"fraggrenade",0,302500,0.3);
			param_00 = self method_811E();
			if(!isdefined(param_00))
			{
				return;
			}

			break;
		}

		wait(0.1);
	}

	for(;;)
	{
		if(func_56F2(self.origin - param_00.origin,-28672,6400))
		{
			func_5A07();
			self.var_B7B5 = gettime() + 6000;
			if(isdefined(self.var_5A0E) && self.var_5A0E == 0 || self.var_5A0E < randomfloat(1))
			{
				return;
			}

			func_5A08(param_00,"flash_grenade",1,4096,0.2);
			return;
		}

		wait(0.1);
	}
}

//Function Number: 11
func_5A0A(param_00)
{
	for(;;)
	{
		if(!self.var_9E45 || distancesquared(self.origin,param_00.origin) < 1024)
		{
			return;
		}

		wait(0.1);
	}
}