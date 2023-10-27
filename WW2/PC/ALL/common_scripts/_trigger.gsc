/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_trigger.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 204 ms
 * Timestamp: 10/27/2023 3:26:38 AM
*******************************************************************/

//Function Number: 1
func_4323()
{
	var_00 = [];
	var_00["trigger_multiple_flag_set"] = ::func_9D79;
	var_00["trigger_multiple_flag_set_touching"] = ::func_9D7A;
	var_00["trigger_multiple_flag_clear"] = ::func_9D75;
	var_00["trigger_multiple_flag_lookat"] = ::func_9D76;
	var_00["trigger_multiple_flag_looking"] = ::func_9D77;
	var_00["trigger_use_flag_set"] = ::func_9D79;
	var_00["trigger_use_flag_clear"] = ::func_9D75;
	return var_00;
}

//Function Number: 2
func_9D6F(param_00)
{
}

//Function Number: 3
func_9DAC(param_00)
{
	var_01 = common_scripts\utility::func_2798(param_00.var_81A1);
	param_00 func_097B(var_01);
	param_00 common_scripts\utility::func_A0D3();
}

//Function Number: 4
func_9DAB(param_00)
{
	var_01 = common_scripts\utility::func_2798(param_00.var_819E);
	param_00 func_097B(var_01);
	param_00 common_scripts\utility::func_A0D3();
}

//Function Number: 5
func_097B(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		var_02 = param_00[var_01];
		if(!isdefined(level.var_9D7B[param_00[var_01]]))
		{
			level.var_9D7B[param_00[var_01]] = [];
		}

		level.var_9D7B[param_00[var_01]] = common_scripts\utility::func_F6F(level.var_9D7B[param_00[var_01]],self);
	}
}

//Function Number: 6
func_9D85()
{
	thread func_9D86();
	level endon("trigger_group_" + self.var_82BE);
	self waittill("trigger");
	level notify("trigger_group_" + self.var_82BE,self);
}

//Function Number: 7
func_9D86()
{
	level waittill("trigger_group_" + self.var_82BE,var_00);
	if(isdefined(self) && self != var_00)
	{
		self delete();
	}
}

//Function Number: 8
func_4397(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(param_00)
	{
	}

	var_01 = [];
	var_02 = getentarray(self.var_1A2,"targetname");
	if(isdefined(var_02))
	{
		var_01 = common_scripts\utility::func_F73(var_01,var_02);
	}

	var_03 = common_scripts\utility::func_46B7(self.var_1A2,"targetname");
	if(isdefined(var_03))
	{
		var_01 = common_scripts\utility::func_F73(var_01,var_03);
	}

	var_04 = getnodearray(self.var_1A2,"targetname");
	if(isdefined(var_04))
	{
		var_01 = common_scripts\utility::func_F73(var_01,var_04);
	}

	var_05 = function_01DC(self.var_1A2,"targetname");
	if(isdefined(var_05))
	{
		var_01 = common_scripts\utility::func_F73(var_01,var_05);
	}

	if(param_00)
	{
	}

	return var_01;
}

//Function Number: 9
func_9D79(param_00)
{
	param_00 endon("death");
	var_01 = param_00 common_scripts\utility::func_4395();
	if(!common_scripts\utility::func_3C83(var_01))
	{
		common_scripts\utility::func_3C87(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 common_scripts\utility::func_161();
		common_scripts\utility::func_3C8F(var_01,var_02);
	}
}

//Function Number: 10
func_9D75(param_00)
{
	param_00 endon("death");
	var_01 = param_00 common_scripts\utility::func_4395();
	if(!common_scripts\utility::func_3C83(var_01))
	{
		common_scripts\utility::func_3C87(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 common_scripts\utility::func_161();
		common_scripts\utility::func_3C7B(var_01,var_02);
	}
}

//Function Number: 11
func_9D7A(param_00)
{
	param_00 endon("death");
	var_01 = param_00 common_scripts\utility::func_4395();
	if(!common_scripts\utility::func_3C83(var_01))
	{
		common_scripts\utility::func_3C87(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 common_scripts\utility::func_161();
		if(isalive(var_02) && var_02 istouching(param_00) && isdefined(param_00))
		{
			common_scripts\utility::func_3C8F(var_01,var_02);
		}

		while(isalive(var_02) && var_02 istouching(param_00) && isdefined(param_00))
		{
			wait(0.25);
		}

		common_scripts\utility::func_3C7B(var_01,var_02);
	}
}

//Function Number: 12
func_9D76(param_00)
{
	func_9D8E(param_00,0);
}

//Function Number: 13
func_9D77(param_00)
{
	func_9D8E(param_00,1);
}

//Function Number: 14
func_9D8E(param_00,param_01)
{
	var_02 = 0.78;
	if(isdefined(param_00.var_8172))
	{
		var_02 = param_00.var_8172;
	}

	var_03 = param_00 func_4397();
	var_04 = var_03[0];
	var_05 = var_04.var_116;
	param_00 endon("death");
	var_04 endon("death");
	var_06 = param_00 common_scripts\utility::func_4395();
	if(!common_scripts\utility::func_3C83(var_06))
	{
		common_scripts\utility::func_3C87(var_06);
	}

	var_07 = 0;
	if(isdefined(param_00.var_8260))
	{
		var_07 = !issubstr("no_sight",param_00.var_8260);
	}

	for(;;)
	{
		if(param_01)
		{
			common_scripts\utility::func_3C7B(var_06,param_00);
		}

		for(;;)
		{
			param_00 waittill("trigger",var_08);
			if(isplayer(var_08))
			{
				break;
			}
		}

		while(var_08 istouching(param_00))
		{
			if(var_07 && !sighttracepassed(var_08 geteye(),var_05,0,undefined))
			{
				if(param_01)
				{
					common_scripts\utility::func_3C7B(var_06,param_00);
				}

				wait(0.5);
				continue;
			}

			var_09 = vectornormalize(var_05 - var_08.var_116);
			var_0A = var_08 getangles();
			var_0B = anglestoforward(var_0A);
			var_0C = vectordot(var_0B,var_09);
			if(var_0C >= var_02)
			{
				common_scripts\utility::func_3C8F(var_06,var_08);
			}
			else if(param_01)
			{
				common_scripts\utility::func_3C7B(var_06,param_00);
			}

			if(var_07)
			{
				wait(0.5);
				continue;
			}

			wait 0.05;
		}
	}
}