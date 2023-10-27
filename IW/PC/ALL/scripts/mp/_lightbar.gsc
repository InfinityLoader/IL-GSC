/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_lightbar.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 774 ms
 * Timestamp: 10/27/2023 12:20:47 AM
*******************************************************************/

//Function Number: 1
init()
{
}

//Function Number: 2
func_1768(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(param_04 == 0)
	{
		param_04 = undefined;
	}

	if(!isdefined(self.var_ACB1) || self.var_ACB1.size == 0)
	{
		var_06 = [];
		var_06[0] = spawnstruct();
		self.var_ACB1 = var_06;
	}
	else
	{
		var_07 = scripts\mp\_utility::cleanarray(self.var_ACB1);
		self.var_ACB1 = var_07;
		self.var_ACB1[self.var_ACB1.size] = spawnstruct();
	}

	self.var_ACB1[self.var_ACB1.size - 1].var_AAC5 = param_00;
	self.var_ACB1[self.var_ACB1.size - 1].var_DAF8 = param_01;
	self.var_ACB1[self.var_ACB1.size - 1].priority = param_02;
	self.var_ACB1[self.var_ACB1.size - 1].var_636E = param_03;
	self.var_ACB1[self.var_ACB1.size - 1].var_1190D = gettime();
	self.var_ACB1[self.var_ACB1.size - 1].var_68D9 = 0;
	self.var_ACB1[self.var_ACB1.size - 1].var_636F = param_05;
	if(isdefined(param_04))
	{
		self.var_ACB1[self.var_ACB1.size - 1].time = param_04 * 1000;
	}
	else
	{
		self.var_ACB1[self.var_ACB1.size - 1].time = undefined;
	}

	if(isdefined(param_03) && param_03)
	{
		thread func_6336(self.var_ACB1[self.var_ACB1.size - 1]);
	}

	if(isdefined(param_05))
	{
		thread func_635B(param_05,self.var_ACB1[self.var_ACB1.size - 1]);
	}

	thread func_B2EE();
}

//Function Number: 3
func_B2EE()
{
	self notify("manageLightBarStack");
	self endon("manageLightBarStack");
	self endon("disconnect");
	for(;;)
	{
		wait(0.05);
		if(self.var_ACB1.size > 1)
		{
			var_00 = func_E17F(self.var_ACB1);
			var_01 = scripts\common\utility::func_22C3(var_00,::func_9BFF);
		}
		else
		{
			var_01 = self.var_ACB1;
		}

		if(var_01.size == 0)
		{
			return;
		}

		self.var_ACB1 = var_01;
		var_02 = var_01[0];
		if(var_02.var_68D9)
		{
			continue;
		}

		var_03 = !isdefined(self.var_ACB1[self.var_ACB1.size - 1].time);
		var_04 = 0;
		if(!var_03)
		{
			var_05 = gettime() - var_02.var_1190D;
			var_04 = var_02.time - var_05;
			var_04 = var_04 / 1000;
			if(var_04 <= 0)
			{
				self.var_ACB1[0] notify("removed");
				self.var_ACB1[0] = undefined;
				func_4041();
				func_B2EE();
			}
		}

		if(var_03)
		{
			if(var_02.var_636E)
			{
				var_02 notify("executing");
				var_02.var_68D9 = 1;
				thread func_F464(var_02.var_AAC5,var_02.var_DAF8);
			}
			else
			{
				thread func_F463(var_02.var_AAC5,var_02.var_DAF8);
			}

			continue;
		}

		if(var_02.var_636E)
		{
			var_02 notify("executing");
			var_02.var_68D9 = 1;
			thread func_F460(var_02.var_AAC5,var_02.var_DAF8,var_04);
			continue;
		}

		thread func_F45F(var_02.var_AAC5,var_02.var_DAF8,var_04);
	}
}

//Function Number: 4
func_4041()
{
	var_00 = scripts\mp\_utility::cleanarray(self.var_ACB1);
	self.var_ACB1 = var_00;
}

//Function Number: 5
func_E17F(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(!isdefined(var_03.time))
		{
			var_01[var_01.size] = var_03;
			continue;
		}

		var_04 = gettime() - var_03.var_1190D;
		var_05 = var_03.time - var_04;
		var_05 = var_05 / 1000;
		if(var_05 > 0)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 6
func_9BFF(param_00,param_01)
{
	return param_00.priority > param_01.priority;
}

//Function Number: 7
func_F45C(param_00,param_01)
{
	func_F465(param_01);
	func_F45D(param_00);
	func_F462();
}

//Function Number: 8
func_F45F(param_00,param_01,param_02)
{
	self notify("set_lightbar_for_time");
	self endon("set_lightbar_for_time");
	func_F465(param_01);
	func_F45D(param_00);
	func_F462();
	wait(param_02);
	if(!isdefined(self))
	{
		return;
	}

	func_F461();
	self.var_ACB1 = undefined;
	func_4041();
}

//Function Number: 9
func_F463(param_00,param_01)
{
	self notify("set_lightbar");
	self endon("set_lightbar");
	func_F465(param_01);
	func_F45D(param_00);
	func_F462();
}

//Function Number: 10
func_F45E(param_00,param_01)
{
	func_F465(param_01);
	func_F45D(param_00);
	func_F462();
	thread func_1295F();
}

//Function Number: 11
func_F460(param_00,param_01,param_02)
{
	self notify("set_lightbar_for_time_endon_death");
	self endon("set_lightbar_for_time_endon_death");
	func_F465(param_01);
	func_F45D(param_00);
	func_F462();
	thread func_1295F();
	wait(param_02);
	if(!isdefined(self))
	{
		return;
	}

	func_F461();
	self.var_ACB1[0] notify("removed");
	self.var_ACB1[0] = undefined;
	func_4041();
}

//Function Number: 12
func_F464(param_00,param_01)
{
	self notify("set_lightbar_endon_death");
	self endon("set_lightbar_endon_death");
	func_F465(param_01);
	func_F45D(param_00);
	func_F462();
	thread func_1295F();
}

//Function Number: 13
func_6336(param_00)
{
	self notify("endInactiveInstructionOnDeath");
	self endon("endInactiveInstructionOnDeath");
	param_00 endon("executing");
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	if(self.var_ACB1.size == 0)
	{
		return;
	}

	self.var_ACB1[0] notify("removed");
	self.var_ACB1[0] = undefined;
	func_4041();
}

//Function Number: 14
func_635B(param_00,param_01)
{
	param_01 endon("removed");
	if(isarray(param_00))
	{
		var_02 = scripts\common\utility::func_13730(param_00);
	}
	else
	{
		self waittill(param_00);
	}

	if(!isdefined(self))
	{
		return;
	}

	for(var_03 = 0;var_03 < self.var_ACB1.size;var_03++)
	{
		if(param_01 == self.var_ACB1[var_03])
		{
			if(param_01.var_68D9)
			{
				func_F461();
			}

			self.var_ACB1[var_03] = undefined;
			func_4041();
			return;
		}
	}
}

//Function Number: 15
func_1295F()
{
	self notify("turn_Off_Light_Bar_On_Death");
	self endon("turn_Off_Light_Bar_On_Death");
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	if(self.var_ACB1.size == 0)
	{
		return;
	}

	func_F461();
	self.var_ACB1[0] notify("removed");
	self.var_ACB1[0] = undefined;
	func_4041();
}

//Function Number: 16
func_F45D(param_00)
{
	self setclientomnvar("lb_color",param_00);
}

//Function Number: 17
func_F462()
{
	self setclientomnvar("lb_gsc_controlled",1);
}

//Function Number: 18
func_F461()
{
	self setclientomnvar("lb_gsc_controlled",0);
}

//Function Number: 19
func_F465(param_00)
{
	self setclientomnvar("lb_pulse_time",param_00);
}