/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_emp_common.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 1012 ms
 * Timestamp: 10/27/2023 12:28:29 AM
*******************************************************************/

//Function Number: 1
func_20C3()
{
	self notify("apply_player_emp");
	self.var_619B = scripts\common\utility::func_116D7(isdefined(self.var_619B),self.var_619B,0);
	var_00 = self.var_619B;
	self.var_619B++;
	self playloopsound("emp_nade_lp");
	thread func_5AA9();
	if(var_00 == 0)
	{
		thread func_1181();
	}
}

//Function Number: 2
func_E0F3()
{
	self.var_619B--;
	if(self.var_619B == 0)
	{
		thread func_13B5();
	}
}

//Function Number: 3
func_1181()
{
	if(scripts\mp\_utility::_hasperk("specialty_localjammer"))
	{
		self method_807C();
	}

	self method_82DA(1);
	scripts\common\utility::func_1C6E(0);
	thread func_10D95();
}

//Function Number: 4
func_13B5()
{
	if(scripts\mp\_utility::_hasperk("specialty_localjammer"))
	{
		self method_81F4();
	}

	self method_82DA(0);
	scripts\common\utility::func_1C6E(1);
	if(scripts\mp\_utility::func_9F19(self))
	{
		thread func_1106A();
	}
	else
	{
		thread func_1106B();
	}

	self notify("emp_stop_vfx");
	self playsound("emp_nade_lp_end");
	self stoploopsound("emp_nade_lp");
}

//Function Number: 5
isemped()
{
	return isdefined(self.var_619B) && self.var_619B > 0;
}

//Function Number: 6
func_FFC5()
{
	if(scripts\mp\_utility::_hasperk("specialty_empimmune") || !scripts\mp\_utility::func_9F19(self))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9EF0(self))
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
func_20CD()
{
	function_0237("coup_sunblind",0.05);
	wait(0.05);
	function_0237("coup_sunblind",0);
	function_0237("",0.5);
}

//Function Number: 8
func_10D95()
{
	level endon("game_ended");
	self endon("emp_stop_effect");
	self endon("disconnect");
	self.var_2B12 = 1;
	thread func_5823();
	wait(1);
	self setclientomnvar("ui_hud_static",2);
	wait(0.5);
	self notify("emp_stop_artifact");
	self setclientomnvar("ui_hud_emp_artifact",0);
	for(;;)
	{
		self setclientomnvar("ui_hud_static",3);
		var_00 = randomfloatrange(0.25,1.25);
		wait(var_00);
		self setclientomnvar("ui_hud_static",2);
		wait(0.5);
	}
}

//Function Number: 9
func_1106A()
{
	level endon("game_ended");
	self notify("emp_stop_effect");
	self endon("disconnect");
	if(isdefined(self.var_2B12))
	{
		self.var_2B12 = undefined;
		self setclientomnvar("ui_hud_static",0);
		for(var_00 = 0;var_00 < 3;var_00++)
		{
			self setclientomnvar("ui_hud_emp_artifact",1);
			wait(0.5);
		}

		self setclientomnvar("ui_hud_emp_artifact",0);
		self.var_D2DB = 0;
	}
}

//Function Number: 10
func_1106B()
{
	self notify("emp_stop_effect");
	if(isdefined(self.var_2B12) || isdefined(self.var_D2DB))
	{
		self.var_2B12 = undefined;
		self.var_D2DB = 0;
		self setclientomnvar("ui_hud_static",0);
		self setclientomnvar("ui_hud_emp_artifact",0);
	}
}

//Function Number: 11
func_5823()
{
	self notify("emp_stop_artifact");
	level endon("game_ended");
	self endon("emp_stop_effect");
	self endon("emp_stop_artifact");
	self endon("disconnect");
	self endon("joined_spectators");
	for(;;)
	{
		self setclientomnvar("ui_hud_emp_artifact",1);
		var_00 = randomfloatrange(0.375,0.5);
		wait(var_00);
	}
}

//Function Number: 12
func_5826(param_00)
{
	self notify("emp_stop_static");
	level endon("game_ended");
	self endon("emp_stop_effect");
	self endon("emp_stop_static");
	self endon("disconnect");
	self endon("joined_spectators");
	var_01 = 1;
	var_02 = 2;
	if(param_00 == 2)
	{
		var_01 = 0.5;
		var_02 = 0.75;
	}

	for(;;)
	{
		self setclientomnvar("ui_hud_static",2);
		var_03 = randomfloatrange(var_01,var_02);
		wait(var_03);
	}
}

//Function Number: 13
func_10E4A()
{
	self.var_D2DB = 0;
}

//Function Number: 14
func_10E4B(param_00)
{
	if(self.var_D2DB != param_00 && isalive(self) && !isemped())
	{
		self.var_D2DB = param_00;
		switch(param_00)
		{
			case 0:
				func_1106A();
				break;

			case 1:
				self.var_2B12 = 1;
				self notify("emp_stop_static");
				thread func_5823();
				thread func_5826(1);
				break;

			case 2:
				self.var_2B12 = 1;
				self notify("emp_stop_static");
				self notify("emp_stop_artifact");
				thread func_5826(2);
				break;
		}
	}
}

//Function Number: 15
func_10E49()
{
	return self.var_D2DB;
}

//Function Number: 16
func_5AA9()
{
	self endon("disconnect");
	self notify("doShockEffects");
	self endon("doShockEffects");
	self setscriptablepartstate("emped","active",0);
	scripts\common\utility::waittill_any_3("death","emp_stop_vfx","game_ended");
	self setscriptablepartstate("emped","neutral",0);
}

//Function Number: 17
func_20C7(param_00)
{
	thread func_20C8(param_00);
}

//Function Number: 18
func_20C8(param_00)
{
	self endon("death");
	self endon("disconnect");
	func_20C3();
	wait(param_00);
	func_E0F3();
}

//Function Number: 19
func_E24E()
{
	self.var_619B = undefined;
	func_1106B();
	self notify("emp_stop_vfx");
	self stoploopsound("emp_nade_lp");
	self method_82DA(0);
}

//Function Number: 20
func_61A2()
{
	if(!isdefined(level.var_61A1))
	{
		func_61C1();
	}

	return level.var_61A1;
}

//Function Number: 21
func_61C1(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_B779)
	{
		if(isdefined(var_03))
		{
			var_01[var_01.size] = var_03;
		}
	}

	var_05 = getentarray("misc_turret","classname");
	foreach(var_07 in var_05)
	{
		if(isdefined(var_07))
		{
			var_01[var_01.size] = var_07;
		}
	}

	foreach(var_0A in level.var_12F81)
	{
		if(isdefined(var_0A))
		{
			var_01[var_01.size] = var_0A;
		}
	}

	foreach(var_0D in level.var_DF74)
	{
		if(isdefined(var_0D))
		{
			var_01[var_01.size] = var_0D;
		}
	}

	foreach(var_10 in level.var_27EF)
	{
		if(isdefined(var_10))
		{
			var_01[var_01.size] = var_10;
		}
	}

	foreach(var_13 in level.var_CC11)
	{
		if(isdefined(var_13))
		{
			var_01[var_01.size] = var_13;
		}
	}

	foreach(param_00 in level.players)
	{
		if(isdefined(param_00) && scripts\mp\_utility::func_9EF0(param_00))
		{
			var_01[var_01.size] = param_00;
		}
	}

	level.var_61A1 = var_01;
	thread func_61B1();
}

//Function Number: 22
func_61B1()
{
	waittillframeend;
	level.var_61A1 = undefined;
}