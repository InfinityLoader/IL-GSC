/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_narrative.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 475 ms
 * Timestamp: 10/27/2023 12:24:49 AM
*******************************************************************/

//Function Number: 1
func_BE57(param_00,param_01,param_02)
{
	setdvarifuninitialized("narrative_debug",0);
	if(getdvarint("narrative_debug") == 1)
	{
		if(!isdefined(self))
		{
		}

		if(!isdefined(param_02))
		{
			param_02 = (0,0,0);
		}

		self endon("death");
		self endon("narrative_debug_stop");
		for(var_03 = 0;var_03 < param_01;var_03++)
		{
			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 2
func_BE56(param_00,param_01,param_02)
{
	setdvarifuninitialized("narrative_debug",0);
	if(getdvarint("narrative_debug") == 1)
	{
		if(!isdefined(self.origin))
		{
			return;
		}
		else
		{
			var_03 = self.origin;
		}

		if(!isdefined(param_00))
		{
			param_00 = 6;
		}

		if(!isdefined(param_01))
		{
			param_01 = (1,1,1);
		}

		if(!isdefined(param_02))
		{
			param_02 = 400;
		}
	}
}

//Function Number: 3
func_BE55(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	setdvarifuninitialized("narrative_debug",0);
	if(getdvarint("narrative_debug") == 1)
	{
		if(!isdefined(param_02))
		{
			param_02 = (1,1,1);
		}

		if(!isdefined(param_03))
		{
			param_03 = 1;
		}

		if(!isdefined(param_04))
		{
			param_04 = 0;
		}

		if(!isdefined(param_05))
		{
			param_05 = 200;
		}

		if(isdefined(param_06))
		{
			if(isdefined(param_07))
			{
				var_08 = 40;
				param_01 = self.origin + anglestoforward(self.angles) * var_08;
			}
			else
			{
				var_08 = distance2d(param_01,param_02);
			}

			var_09 = var_08 * 0.2;
			var_0A = var_08 * 0.5;
			var_0B = var_08 * 0.175;
			var_0C = param_00 - param_01;
			var_0D = param_01 + anglestoforward(vectortoangles(var_0C)) * var_09;
			var_0E = param_01 + anglestoforward(vectortoangles(var_0C)) * var_0A;
			return;
		}
	}
}

//Function Number: 4
func_48A9()
{
	if(isdefined(self.target) && isdefined(getent(self.target,"targetname")))
	{
		var_00 = getent(self.target,"targetname");
		if(isdefined(var_00.var_EE79) && var_00.var_EE79 == "big_collision")
		{
			var_00.origin = self.origin;
			var_00.angles = self.angles;
			var_00 linkto(self);
			self.var_2AC1 = var_00;
		}
	}
}

//Function Number: 5
func_DFCC()
{
	if(isdefined(self.var_2AC1))
	{
		self.var_2AC1 delete();
	}
}

//Function Number: 6
func_196B(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_02 = squared(param_02);
	param_01 = lib_0EFB::func_7D7A(param_01);
	param_03 = lib_0EFB::func_7D7A(param_03).origin;
	var_04 = distance2dsquared(self.origin,param_03);
	while(var_04 > param_02)
	{
		var_04 = distance2dsquared(self.origin,param_03);
		scripts\common\utility::func_136F7();
	}

	self thread [[ param_00 ]](param_01);
}

//Function Number: 7
func_194A(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	if(isdefined(param_06) && scripts\common\utility::flag(param_06))
	{
		return;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0.7;
	}

	thread func_1949(param_00);
	if(isdefined(param_01))
	{
		wait(param_03);
		param_02 = lib_0EFB::func_7D7A(param_02);
		if(isdefined(param_05))
		{
			self thread [[ param_01 ]](param_02,param_05);
			scripts\common\utility::func_5127(param_05,::scripts\sp\_utility::func_77B9,0.7);
		}
		else
		{
			self thread [[ param_01 ]](param_02);
		}
	}

	self waittill("gesture_dialog_finished");
	scripts\sp\_utility::func_77B9(param_04);
}

//Function Number: 8
func_1961(param_00,param_01,param_02,param_03)
{
	self endon("death");
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	thread func_1949(param_00);
	lib_0C4C::func_1960(param_01);
	self waittill("gesture_dialog_finished");
}

//Function Number: 9
func_1949(param_00)
{
	self endon("death");
	scripts\sp\_utility::func_10347(param_00);
	self notify("gesture_dialog_finished");
}

//Function Number: 10
func_195C(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 4;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0.25;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0.35;
	}

	param_00 = lib_0EFB::func_7D7A(param_00);
	thread lib_0C4C::func_1955(param_00,param_01,param_02);
	wait(param_04);
	lib_0C4C::func_1964(param_03);
}

//Function Number: 11
func_10348(param_00,param_01)
{
	if(!scripts\common\utility::flag(param_01))
	{
		scripts\sp\_utility::func_10347(param_00);
	}
}