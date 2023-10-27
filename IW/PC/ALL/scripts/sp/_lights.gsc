/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_lights.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 1818 ms
 * Timestamp: 10/27/2023 12:24:40 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = getentarray("script_light","targetname");
	var_01 = getentarray("script_light_toggle","targetname");
	var_02 = getentarray("script_light_flicker","targetname");
	var_03 = getentarray("script_light_pulse","targetname");
	var_04 = getentarray("generic_double_strobe","targetname");
	var_05 = getentarray("burning_trash_fire","targetname");
	var_06 = getentarray("generic_pulsing","targetname");
	scripts\common\utility::array_thread(var_00,::func_9662);
	scripts\common\utility::array_thread(var_01,::func_9662);
	scripts\common\utility::array_thread(var_02,::func_9661);
	scripts\common\utility::array_thread(var_03,::func_9663);
	scripts\common\utility::array_thread(var_04,::func_774A);
	scripts\common\utility::array_thread(var_05,::func_3299);
	scripts\common\utility::array_thread(var_06,::func_7765);
}

//Function Number: 2
func_9662(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	wait(0.05);
	self.var_99E6 = func_95A8([self.var_EDED,param_00,self method_8134()]);
	self.var_438F = func_95A8([self.var_ED31,param_01,self method_8131()]);
	self.var_99E7 = func_95A8([self.var_EDEE,param_02,0]);
	self.var_4390 = func_95A8([self.var_ED32,param_03,(0,0,0)]);
	self.var_C14B = func_95A8([self.var_EDFF,param_04]);
	self.var_C14C = func_95A8([self.var_EE00,param_05]);
	self.var_10D0C = func_95A8([self.var_EECC,param_06]);
	self.var_ACA5 = func_95A8([self.var_EEFA,"generic"]);
	self.var_50D3 = issubstr(self.var_ACA5,"delaystart");
	if(!scripts\sp\_utility::func_65DF("light_on"))
	{
		scripts\sp\_utility::func_65E0("light_on");
	}

	self.var_AD83 = [];
	self.var_12BB6 = [];
	self.var_AD22 = [];
	self.var_127C9 = [];
	var_08 = scripts\sp\_utility::func_7A8F();
	foreach(var_0A in var_08)
	{
		if(func_9C37(var_0A))
		{
			self.var_AD22[self.var_AD22.size] = var_0A;
			continue;
		}

		if(isdefined(var_0A.script_noteworthy) && var_0A.script_noteworthy == "on")
		{
			self.var_AD83[self.var_AD83.size] = var_0A;
			continue;
		}

		if(isdefined(var_0A.script_noteworthy) && var_0A.script_noteworthy == "off")
		{
			self.var_12BB6[self.var_12BB6.size] = var_0A;
			continue;
		}

		if(issubstr(var_0A.classname,"trigger"))
		{
			self.var_127C9[self.var_127C9.size] = var_0A;
		}
	}

	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		func_F466(0,(0,0,0));
		return;
	}

	scripts\common\utility::flag_wait("scriptables_ready");
	if(isdefined(self.target))
	{
		self.var_EF3C = getscriptablearray(self.target,"targetname");
	}

	if(self.var_AD83.size != 0 || self.var_12BB6.size != 0)
	{
	}

	scripts\common\utility::array_thread(self.var_127C9,::func_9664,self);
	foreach(var_0D in self.var_AD83)
	{
		if(isdefined(var_0D.script_fxid))
		{
			var_0D.var_5FDF = scripts\common\utility::func_49FA(var_0D.script_fxid);
			var_0E = (0,0,0);
			var_0F = (0,0,0);
			if(isdefined(var_0D.var_EE79))
			{
				var_10 = strtok(var_0D.var_EE79,", ");
				var_0E = (float(var_10[0]),float(var_10[1]),float(var_10[2]));
				if(var_10.size >= 6)
				{
					var_0F = (float(var_10[3]),float(var_10[4]),float(var_10[5]));
				}
			}

			var_0D.var_5FDF scripts\common\createfx::func_F4AD(var_0D.origin + var_0E,var_0D.angles + var_0F);
		}
	}

	self.var_9586 = 1;
	self notify("script_light_init_complete");
	if(isdefined(param_07) && param_07)
	{
		return;
	}

	if(isdefined(self.var_C14B) || isdefined(self.var_C14C) || self.var_127C9.size > 0)
	{
		thread func_ACA2();
	}
}

//Function Number: 3
func_ACA2()
{
	self endon("death");
	self notify("stop_script_light_loop");
	self endon("stop_script_light_loop");
	if(isdefined(self.var_10D0C) && self.var_10D0C)
	{
		func_ACA4();
	}
	else if(isdefined(self.var_C14B) || isdefined(self.var_12711))
	{
		func_ACA3();
	}

	for(;;)
	{
		if(!scripts\sp\_utility::func_65DB("light_on"))
		{
			level scripts\common\utility::waittill_any_3("bemani_573",self.var_12711,self.var_C14B);
			scripts\sp\_utility::script_delay();
			if(isdefined(self.var_50D3))
			{
				if(isdefined(self.script_delay))
				{
					self.var_C3D6 = self.script_delay;
				}

				if(isdefined(self.var_ED4F))
				{
					self.var_C3D7 = self.var_ED4F;
				}

				if(isdefined(self.var_ED50))
				{
					self.var_C3D8 = self.var_ED50;
				}

				self.script_delay = undefined;
				self.var_ED4F = undefined;
				self.var_ED50 = undefined;
			}

			func_ACA4();
		}

		level scripts\common\utility::waittill_any_3("bemani_573",self.var_12712,self.var_C14C);
		scripts\sp\_utility::script_delay();
		if(isdefined(self.var_50D3))
		{
			if(isdefined(self.script_delay))
			{
				self.var_C3D6 = self.script_delay;
			}

			if(isdefined(self.var_ED4F))
			{
				self.var_C3D7 = self.var_ED4F;
			}

			if(isdefined(self.var_ED50))
			{
				self.var_C3D8 = self.var_ED50;
			}

			self.script_delay = undefined;
			self.var_ED4F = undefined;
			self.var_ED50 = undefined;
		}

		func_ACA3();
		if(isdefined(self.var_C3D6))
		{
			self.script_delay = self.var_C3D6;
		}

		if(isdefined(self.var_C3D7))
		{
			self.var_ED4F = self.var_C3D7;
		}

		if(isdefined(self.var_C3D8))
		{
			self.var_ED50 = self.var_C3D8;
		}

		wait(0.05);
	}
}

//Function Number: 4
func_9661(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E)
{
	func_9662(param_00,param_01,param_04,param_05,param_09,param_0A,param_0B,1);
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		return;
	}

	func_B27A(param_02,param_03,param_06,param_07,param_08,param_0C,param_0D);
	if(isdefined(param_0E) && param_0E)
	{
		return;
	}

	thread func_10C9A();
}

//Function Number: 5
func_B27A(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	func_9665(param_05);
	self.var_1098E = func_95A8([self.var_EEBF,param_04,1]);
	self.var_C4B5 = max(func_95A8([self.var_ED75,param_06,3]) / self.var_1098E,0.25);
	if((isdefined(self.var_EF17) && !isdefined(self.var_EF16)) || !isdefined(self.var_EF17) && isdefined(self.var_EF16))
	{
		self.var_8E57 = max(func_95A8([self.var_EF17,self.var_EF16]) / self.var_1098E,0.05);
	}
	else
	{
		self.var_13585 = max(func_95A8([self.var_EF17,param_00,0.05]) / self.var_1098E,0.05);
		self.var_13584 = max(func_95A8([self.var_EF16,param_01,0.1]) / self.var_1098E,0.1);
		if(self.var_13585 > self.var_13584)
		{
			var_07 = self.var_13584;
			self.var_13584 = self.var_13585;
			self.var_13585 = var_07;
		}
	}

	if((isdefined(self.var_EF19) && !isdefined(self.var_EF18)) || !isdefined(self.var_EF19) && isdefined(self.var_EF18))
	{
		self.var_ADA3 = max(func_95A8([self.var_EF19,self.var_EF18]) / self.var_1098E,0.05);
		return;
	}

	self.var_13587 = max(func_95A8([self.var_EF19,param_02,0.05]) / self.var_1098E,0.05);
	self.var_13586 = max(func_95A8([self.var_EF18,param_03,0.75]) / self.var_1098E,0.1);
	if(self.var_13587 > self.var_13586)
	{
		var_07 = self.var_13586;
		self.var_13586 = self.var_13587;
		self.var_13587 = var_07;
	}
}

//Function Number: 6
func_10C9A()
{
	if(self.var_12AE2 || self.var_12AE1)
	{
		thread func_AC89();
		return;
	}

	thread func_AC88();
}

//Function Number: 7
func_AC88()
{
	self endon("death");
	self notify("stop_script_light_loop");
	self endon("stop_script_light_loop");
	if(isdefined(self.var_10D0C) && self.var_10D0C)
	{
		func_ACA4();
	}
	else if(isdefined(self.var_C14B) || isdefined(self.var_12711))
	{
		func_ACA3(undefined,self.var_12ACF);
	}

	if(isdefined(self.var_C14B) && isdefined(self.var_C14C))
	{
		for(;;)
		{
			scripts\sp\_utility::script_delay();
			if(isdefined(self.var_50D3))
			{
				if(isdefined(self.script_delay))
				{
					self.var_C3D6 = self.script_delay;
				}

				if(isdefined(self.var_ED4F))
				{
					self.var_C3D7 = self.var_ED4F;
				}

				if(isdefined(self.var_ED50))
				{
					self.var_C3D8 = self.var_ED50;
				}

				self.script_delay = undefined;
				self.var_ED4F = undefined;
				self.var_ED50 = undefined;
			}

			func_AC8A();
			if(isdefined(self.var_10D0C) && self.var_10D0C)
			{
				func_ACA4();
			}
			else
			{
				func_ACA3(undefined,self.var_12ACF);
			}

			if(isdefined(self.var_C3D6))
			{
				self.script_delay = self.var_C3D6;
			}

			if(isdefined(self.var_C3D7))
			{
				self.var_ED4F = self.var_C3D7;
			}

			if(isdefined(self.var_C3D8))
			{
				self.var_ED50 = self.var_C3D8;
			}

			wait(0.05);
		}

		return;
	}

	func_AC8A();
	if(isdefined(self.var_10D0C) && self.var_10D0C)
	{
		func_ACA4();
		return;
	}

	func_ACA3(undefined,self.var_12ACF);
}

//Function Number: 8
func_AC89()
{
	self endon("death");
	self notify("stop_script_light_loop");
	self endon("stop_script_light_loop");
	if(isdefined(self.var_10D0C) && self.var_10D0C)
	{
		func_ACA4();
	}
	else if(isdefined(self.var_C14B) || isdefined(self.var_12711))
	{
		func_ACA3(undefined,self.var_12ACF);
	}

	for(;;)
	{
		if(!scripts\sp\_utility::func_65DB("light_on") && isdefined(self.var_12711) || isdefined(self.var_C14B))
		{
			level scripts\common\utility::waittill_any_3("bemani_573",self.var_12711,self.var_C14B);
		}

		scripts\sp\_utility::script_delay();
		if(isdefined(self.var_50D3))
		{
			if(isdefined(self.script_delay))
			{
				self.var_C3D6 = self.script_delay;
			}

			if(isdefined(self.var_ED4F))
			{
				self.var_C3D7 = self.var_ED4F;
			}

			if(isdefined(self.var_ED50))
			{
				self.var_C3D8 = self.var_ED50;
			}

			self.script_delay = undefined;
			self.var_ED4F = undefined;
			self.var_ED50 = undefined;
		}

		if(self.var_12AE2 && !scripts\sp\_utility::func_65DB("light_on"))
		{
			childthread func_AC8A(1,self.var_DC8B);
			if(self.var_10E46)
			{
				wait(self.var_C4B5);
			}
			else
			{
				wait(randomfloat(self.var_C4B5));
			}

			self notify("stop_flicker");
		}

		func_ACA4();
		if(!isdefined(self.var_C14B) && !isdefined(self.var_12711))
		{
			return;
		}

		if(!self.var_12AE3)
		{
			level scripts\common\utility::waittill_any_3("bemani_573",self.var_12712,self.var_C14C);
		}
		else
		{
			func_AC8A(1);
		}

		if(self.var_12AE1)
		{
			childthread func_AC8A(1,self.var_DC8A);
			if(self.var_10E46)
			{
				wait(self.var_C4B5);
			}
			else
			{
				wait(randomfloat(self.var_C4B5));
			}

			self notify("stop_flicker");
		}

		func_ACA3(undefined,self.var_12ACF);
		if(isdefined(self.var_C3D6))
		{
			self.script_delay = self.var_C3D6;
		}

		if(isdefined(self.var_C3D7))
		{
			self.var_ED4F = self.var_C3D7;
		}

		if(isdefined(self.var_C3D8))
		{
			self.var_ED50 = self.var_C3D8;
		}

		wait(0.05);
		if(!isdefined(self.var_C14B) && !isdefined(self.var_C14C))
		{
			return;
		}
	}
}

//Function Number: 9
func_AC8A(param_00,param_01)
{
	self notify("stop_flicker");
	self endon("stop_flicker");
	if(isdefined(self.var_12712))
	{
		level endon(self.var_12712);
	}

	if(isdefined(self.var_C14C))
	{
		level endon(self.var_C14C);
	}

	if(!isdefined(param_00) && isdefined(self.var_12711) || isdefined(self.var_C14B))
	{
		level scripts\common\utility::waittill_any_3("bemani_573",self.var_12711,self.var_C14B);
	}

	for(;;)
	{
		func_ACA4(param_01);
		if(isdefined(self.var_8E57))
		{
			wait(self.var_8E57);
		}
		else
		{
			wait(randomfloatrange(self.var_13585,self.var_13584));
		}

		func_ACA3(param_01);
		if(isdefined(self.var_ADA3))
		{
			wait(self.var_ADA3);
			continue;
		}

		wait(randomfloatrange(self.var_13587,self.var_13586));
	}
}

//Function Number: 10
func_9663(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E)
{
	func_9662(param_00,param_01,param_04,param_05,param_09,param_0A,undefined,1);
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		return;
	}

	func_B27B(param_02,param_03,param_06,param_07,param_08,param_0C,param_0D,param_0B);
	if(isdefined(param_0E) && param_0E)
	{
		return;
	}

	thread func_10C9B();
}

//Function Number: 11
func_B27B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self.var_10D0C = func_95A8([self.var_EECC,param_07,1]);
	func_9665(param_05);
	self.var_1098E = func_95A8([self.var_EEBF,param_04,1]);
	self.var_C4B5 = max(func_95A8([self.var_ED75,param_06,3]) / self.var_1098E,3);
	if((isdefined(self.var_EF17) && !isdefined(self.var_EF16)) || !isdefined(self.var_EF17) && isdefined(self.var_EF16))
	{
		self.var_8E57 = max(func_95A8([self.var_EF17,self.var_EF16]) / self.var_1098E,0.05);
	}
	else
	{
		self.var_13585 = max(func_95A8([self.var_EF17,param_00,0.05]) / self.var_1098E,0.05);
		self.var_13584 = max(func_95A8([self.var_EF16,param_01,0.5]) / self.var_1098E,0.1);
		if(self.var_13585 > self.var_13584)
		{
			var_08 = self.var_13584;
			self.var_13584 = self.var_13585;
			self.var_13585 = var_08;
		}
	}

	if((isdefined(self.var_EF19) && !isdefined(self.var_EF18)) || !isdefined(self.var_EF19) && isdefined(self.var_EF18))
	{
		self.var_ADA3 = max(func_95A8([self.var_EF19,self.var_EF18]) / self.var_1098E,0.05);
		var_09 = int(self.var_ADA3 * 20);
		self.var_10F88 = 2 / var_09;
		self.var_99EA = 2 * self.var_99E6 - self.var_99E7 / var_09;
		return;
	}

	self.var_13587 = max(func_95A8([self.var_EF19,param_03,0.25]) / self.var_1098E,0.05);
	self.var_13586 = max(func_95A8([self.var_EF18,param_04,0.75]) / self.var_1098E,0.1);
	if(self.var_13587 > self.var_13586)
	{
		var_08 = self.var_13586;
		self.var_13586 = self.var_13587;
		self.var_13587 = var_08;
	}

	var_09 = int(self.var_13586 * 20);
	self.var_10F88 = 2 / var_09;
	self.var_99EA = 2 * self.var_99E6 - self.var_99E7 / var_09;
}

//Function Number: 12
func_10C9B()
{
	if(self.var_12AE2 || self.var_12AE1)
	{
		thread func_AC9D();
		return;
	}

	thread func_AC9C();
}

//Function Number: 13
func_AC9C()
{
	self endon("death");
	self notify("stop_script_light_loop");
	self endon("stop_script_light_loop");
	if(isdefined(self.var_10D0C) && self.var_10D0C)
	{
		func_ACA4();
	}
	else if(isdefined(self.var_C14B) || isdefined(self.var_12711))
	{
		func_ACA3(undefined,self.var_12ACF);
	}

	if(isdefined(self.var_C14B) && isdefined(self.var_C14C))
	{
		for(;;)
		{
			func_AC9E();
			if(isdefined(self.var_10D0C) && self.var_10D0C)
			{
				func_ACA4();
				continue;
			}

			func_ACA3(undefined,self.var_12ACF);
			wait(0.05);
		}

		return;
	}

	func_AC9E();
	if(isdefined(self.var_10D0C) && self.var_10D0C)
	{
		func_ACA4();
		return;
	}

	func_ACA3(undefined,self.var_12ACF);
}

//Function Number: 14
func_AC9D()
{
	self endon("death");
	self notify("stop_script_light_loop");
	self endon("stop_script_light_loop");
	if(isdefined(self.var_10D0C) && self.var_10D0C)
	{
		func_ACA4();
	}
	else if(isdefined(self.var_C14B) || isdefined(self.var_12711))
	{
		func_ACA3(undefined,self.var_12ACF);
	}

	for(;;)
	{
		if(!scripts\sp\_utility::func_65DB("light_on") && isdefined(self.var_12711) || isdefined(self.var_C14B))
		{
			level scripts\common\utility::waittill_any_3("bemani_573",self.var_12711,self.var_C14B);
		}

		scripts\sp\_utility::script_delay();
		if(isdefined(self.var_50D3))
		{
			if(isdefined(self.script_delay))
			{
				self.var_C3D6 = self.script_delay;
			}

			if(isdefined(self.var_ED4F))
			{
				self.var_C3D7 = self.var_ED4F;
			}

			if(isdefined(self.var_ED50))
			{
				self.var_C3D8 = self.var_ED50;
			}

			self.script_delay = undefined;
			self.var_ED4F = undefined;
			self.var_ED50 = undefined;
		}

		if(self.var_12AE2 && !scripts\sp\_utility::func_65DB("light_on"))
		{
			childthread func_AC9E(1);
			if(self.var_10E46)
			{
				wait(self.var_C4B5);
			}
			else
			{
				wait(randomfloat(self.var_C4B5));
			}

			self notify("stop_pulse");
		}

		func_ACA4();
		if(!isdefined(self.var_C14B) && !isdefined(self.var_12711))
		{
			return;
		}

		if(!self.var_12AE3)
		{
			level scripts\common\utility::waittill_any_3("bemani_573",self.var_12712,self.var_C14C);
		}
		else
		{
			func_AC9E(1);
		}

		if(self.var_12AE1)
		{
			childthread func_AC9E(1);
			if(self.var_10E46)
			{
				wait(self.var_C4B5);
			}
			else
			{
				wait(randomfloat(self.var_C4B5));
			}

			self notify("stop_flicker");
		}

		func_ACA3(undefined,self.var_12ACF);
		if(isdefined(self.var_C3D6))
		{
			self.script_delay = self.var_C3D6;
		}

		if(isdefined(self.var_C3D7))
		{
			self.var_ED4F = self.var_C3D7;
		}

		if(isdefined(self.var_C3D8))
		{
			self.var_ED50 = self.var_C3D8;
		}

		wait(0.05);
		if(!isdefined(self.var_C14B) && !isdefined(self.var_C14C))
		{
			return;
		}
	}
}

//Function Number: 15
func_AC9E(param_00)
{
	self notify("stop_pulse");
	self endon("stop_pulse");
	if(isdefined(self.var_12712))
	{
		level endon(self.var_12712);
	}

	if(isdefined(self.var_C14C))
	{
		level endon(self.var_C14C);
	}

	if(!isdefined(param_00) && isdefined(self.var_12711) || isdefined(self.var_C14B))
	{
		level scripts\common\utility::waittill_any_3("bemani_573",self.var_12711,self.var_C14B);
	}

	for(;;)
	{
		func_ACA4();
		if(isdefined(self.var_8E57))
		{
			wait(self.var_8E57);
		}
		else
		{
			wait(randomfloatrange(self.var_13585,self.var_13584));
		}

		if(isdefined(self.var_ADA3))
		{
			func_AC9B(self.var_ADA3);
			continue;
		}

		func_AC9B(randomfloatrange(self.var_13587,self.var_13586));
	}
}

//Function Number: 16
func_9664(param_00)
{
	self endon("death");
	var_01 = undefined;
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "stop")
	{
		var_01 = "trig_light_stop_" + scripts\sp\_utility::func_11145(param_00 getentitynumber());
		param_00.var_12712 = var_01;
	}
	else
	{
		var_01 = "trig_light_start_" + scripts\sp\_utility::func_11145(param_00 getentitynumber());
		param_00.var_12711 = var_01;
	}

	self waittill("trigger");
	level notify(var_01);
}

//Function Number: 17
func_ACA4(param_00)
{
	scripts\sp\_utility::func_65E1("light_on");
	if(isdefined(param_00) && param_00 && self.var_99E6 > 0)
	{
		func_F466(randomfloatrange(self.var_99E6 * 0.25,self.var_99E6),self.var_438F);
	}
	else
	{
		func_F466(self.var_99E6,self.var_438F);
	}

	if(isdefined(self.var_EE89))
	{
		scripts\common\utility::exploder(self.var_EE89);
	}

	foreach(var_02 in self.var_EF3C)
	{
		var_02 setscriptablepartstate("onoff","on");
	}

	scripts\common\utility::func_227D(self.var_12BB6,::hide);
	foreach(var_05 in self.var_AD83)
	{
		var_05 show();
		if(isdefined(var_05.var_5FDF))
		{
			var_05.var_5FDF scripts\sp\_utility::func_E2B0();
		}
	}
}

//Function Number: 18
func_ACA3(param_00,param_01)
{
	scripts\sp\_utility::func_65DD("light_on");
	if(isdefined(param_01) && param_01)
	{
		func_F466(0,(0,0,0));
	}
	else if(isdefined(param_00) && param_00 && self.var_99E7 > 0)
	{
		func_F466(randomfloatrange(self.var_99E7 * 0.25,self.var_99E7),self.var_4390);
	}
	else
	{
		func_F466(self.var_99E7,self.var_4390);
	}

	if(isdefined(self.var_EE89))
	{
		scripts\sp\_utility::func_10FEC(self.var_EE89);
	}

	foreach(var_03 in self.var_EF3C)
	{
		var_03 setscriptablepartstate("onoff","off");
	}

	foreach(var_06 in self.var_AD83)
	{
		var_06 hide();
		if(isdefined(var_06.var_5FDF))
		{
			var_06.var_5FDF scripts\common\utility::func_C9CF();
		}
	}

	scripts\common\utility::func_227D(self.var_12BB6,::show);
}

//Function Number: 19
func_AC9B(param_00)
{
	scripts\sp\_utility::func_65DD("light_on");
	var_01 = int(param_00 / 0.1);
	for(var_02 = 1;var_02 <= var_01;var_02++)
	{
		var_03 = max(0,self.var_99E6 - self.var_99EA * var_02);
		var_04 = vectorlerp(self.var_438F,self.var_4390,self.var_10F88 * var_02);
		func_F466(var_03,var_04);
		wait(0.05);
	}

	for(var_02 = var_01;var_02 > 0;var_02--)
	{
		var_03 = max(0,self.var_99E6 - self.var_99EA * var_02);
		var_04 = vectorlerp(self.var_438F,self.var_4390,self.var_10F88 * var_02);
		func_F466(var_03,var_04);
		wait(0.05);
	}
}

//Function Number: 20
func_ACD1(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray(param_00,param_01);
	scripts\common\utility::array_thread(var_05,::func_1298C,param_02,param_03,param_04);
}

//Function Number: 21
func_1298C(param_00,param_01,param_02)
{
	if(!isdefined(self.var_9586))
	{
		self waittill("script_light_init_complete");
	}

	if(isdefined(param_02) && param_02)
	{
		self notify("stop_script_light_loop");
	}

	var_03 = self.var_99E6;
	var_04 = self.var_438F;
	if(isdefined(param_00))
	{
		var_03 = param_00;
	}

	if(isdefined(param_01))
	{
		var_04 = param_01;
	}

	scripts\sp\_utility::func_65E1("light_on");
	func_F466(var_03,var_04);
	foreach(var_06 in self.var_EF3C)
	{
		var_06 setscriptablepartstate("onoff","on");
	}

	scripts\common\utility::func_227D(self.var_12BB6,::hide);
	foreach(var_09 in self.var_AD83)
	{
		var_09 show();
		if(isdefined(var_09.var_5FDF))
		{
			var_09.var_5FDF scripts\sp\_utility::func_E2B0();
		}
	}
}

//Function Number: 22
func_ACD0(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray(param_00,param_01);
	scripts\common\utility::array_thread(var_05,::func_12968,param_02,param_03,param_04);
}

//Function Number: 23
func_12968(param_00,param_01,param_02)
{
	if(!isdefined(self.var_9586))
	{
		self waittill("script_light_init_complete");
	}

	if(isdefined(param_02) && param_02)
	{
		self notify("stop_script_light_loop");
	}

	var_03 = self.var_99E7;
	var_04 = self.var_4390;
	if(isdefined(param_00))
	{
		var_03 = param_00;
	}

	if(isdefined(param_01))
	{
		var_04 = param_01;
	}

	scripts\sp\_utility::func_65DD("light_on");
	func_F466(var_03,var_04);
	foreach(var_06 in self.var_EF3C)
	{
		var_06 setscriptablepartstate("onoff","off");
	}

	foreach(var_09 in self.var_AD83)
	{
		var_09 hide();
		if(isdefined(var_09.var_5FDF))
		{
			var_09.var_5FDF scripts\common\utility::func_C9CF();
		}
	}

	scripts\common\utility::func_227D(self.var_12BB6,::show);
}

//Function Number: 24
func_F466(param_00,param_01)
{
	if(isdefined(param_00))
	{
		param_00 = max(0,param_00);
	}

	if(isdefined(param_01))
	{
		param_01 = (max(0,param_01[0]),max(0,param_01[1]),max(0,param_01[2]));
	}

	if(isdefined(param_00))
	{
		self setlightintensity(param_00);
		if(isdefined(self.var_AD22))
		{
			scripts\common\utility::func_227D(self.var_AD22,::setlightintensity,param_00);
		}
	}

	if(isdefined(param_01))
	{
		self method_82FC(param_01);
		if(isdefined(self.var_AD22))
		{
			scripts\common\utility::func_227D(self.var_AD22,::method_82FC,param_01);
		}
	}
}

//Function Number: 25
func_9C37(param_00)
{
	return param_00.classname == "light_spot" || param_00.classname == "light_omni" || param_00.classname == "light";
}

//Function Number: 26
func_95A8(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02))
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 27
func_9665(param_00)
{
	self.var_ACA5 = func_95A8([self.var_EEFA,param_00,"generic"]);
	self.var_12ACF = issubstr(self.var_ACA5,"two_color");
	self.var_12AE2 = issubstr(self.var_ACA5,"on");
	self.var_12AE1 = issubstr(self.var_ACA5,"off");
	self.var_12AE3 = issubstr(self.var_ACA5,"running");
	self.var_10E46 = issubstr(self.var_ACA5,"timed");
	self.var_50D3 = issubstr(self.var_ACA5,"delaystart");
	self.var_DC8B = issubstr(self.var_ACA5,"on_random_intensity");
	self.var_DC8A = issubstr(self.var_ACA5,"off_random_intensity");
}

//Function Number: 28
func_7765()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
		return;
	}

	var_00 = self method_8134();
	var_01 = 0.05;
	var_02 = var_00;
	var_03 = 0.3;
	var_04 = 0.6;
	var_05 = var_00 - var_01 / var_03 / 0.05;
	var_06 = var_00 - var_01 / var_04 / 0.05;
	for(;;)
	{
		var_07 = 0;
		while(var_07 < var_04)
		{
			var_02 = var_02 - var_06;
			var_02 = clamp(var_02,0,100);
			self setlightintensity(var_02);
			var_07 = var_07 + 0.05;
			wait(0.05);
		}

		wait(1);
		var_07 = 0;
		while(var_07 < var_03)
		{
			var_02 = var_02 + var_05;
			var_02 = clamp(var_02,0,100);
			self setlightintensity(var_02);
			var_07 = var_07 + 0.05;
			wait(0.05);
		}

		wait(0.5);
	}
}

//Function Number: 29
func_774A()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
		return;
	}

	var_00 = self method_8134();
	var_01 = 0.05;
	var_02 = 0;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 0;
	var_06 = [];
	if(isdefined(self.script_noteworthy))
	{
		var_07 = getentarray(self.script_noteworthy,"targetname");
		for(var_08 = 0;var_08 < var_07.size;var_08++)
		{
			if(func_9C37(var_07[var_08]))
			{
				var_05 = 1;
				var_06[var_06.size] = var_07[var_08];
			}

			if(var_07[var_08].classname == "script_model")
			{
				var_03 = var_07[var_08];
				var_04 = getent(var_03.target,"targetname");
				var_02 = 1;
			}
		}
	}

	for(;;)
	{
		self setlightintensity(var_01);
		if(var_02)
		{
			var_03 hide();
			var_04 show();
		}

		wait(0.8);
		self setlightintensity(var_00);
		if(var_02)
		{
			var_03 show();
			var_04 hide();
		}

		wait(0.1);
		self setlightintensity(var_01);
		if(var_02)
		{
			var_03 hide();
			var_04 show();
		}

		wait(0.12);
		self setlightintensity(var_00);
		if(var_02)
		{
			var_03 show();
			var_04 hide();
		}

		wait(0.1);
	}
}

//Function Number: 30
func_776F()
{
	level scripts\common\utility::func_136F7();
}

//Function Number: 31
func_3299()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
		return;
	}

	var_00 = self method_8134();
	var_01 = var_00;
	for(;;)
	{
		var_02 = randomfloatrange(var_00 * 0.7,var_00 * 1.2);
		var_03 = randomfloatrange(0.3,0.6);
		var_03 = var_03 * 20;
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			var_05 = var_02 * var_04 / var_03 + var_01 * var_03 - var_04 / var_03;
			self setlightintensity(var_05);
			wait(0.05);
		}

		var_01 = var_02;
	}
}

//Function Number: 32
func_11155(param_00,param_01,param_02,param_03)
{
	var_04 = 360 / param_02;
	var_05 = 0;
	for(;;)
	{
		var_06 = sin(var_05 * var_04) * 0.5 + 0.5;
		self setlightintensity(param_00 + param_01 - param_00 * var_06);
		wait(0.05);
		var_05 = var_05 + 0.05;
		if(var_05 > param_02)
		{
			var_05 = var_05 - param_02;
		}

		if(isdefined(param_03))
		{
			if(scripts\common\utility::flag(param_03))
			{
				return;
			}
		}
	}
}

//Function Number: 33
func_3C57(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	thread func_3C58(param_00,param_01,param_02,param_03);
}

//Function Number: 34
func_3C58(param_00,param_01,param_02,param_03)
{
	var_04 = self method_8131();
	var_05 = 1 / param_01 * 2 - param_02 + param_03;
	var_06 = 0;
	if(var_06 < param_02)
	{
		var_07 = var_05 / param_02;
		while(var_06 < param_02)
		{
			var_08 = var_07 * var_06 * var_06;
			self method_82FC(vectorlerp(var_04,param_00,var_08));
			wait(0.05);
			var_06 = var_06 + 0.05;
		}
	}

	while(var_06 < param_01 - param_03)
	{
		var_08 = var_05 * 2 * var_06 - param_02;
		self method_82FC(vectorlerp(var_04,param_00,var_08));
		wait(0.05);
		var_06 = var_06 + 0.05;
	}

	var_06 = param_01 - var_06;
	if(var_06 > 0)
	{
		var_07 = var_05 / param_03;
		while(var_06 > 0)
		{
			var_08 = 1 - var_07 * var_06 * var_06;
			self method_82FC(vectorlerp(var_04,param_00,var_08));
			wait(0.05);
			var_06 = var_06 - 0.05;
		}
	}

	self method_82FC(param_00);
}

//Function Number: 35
func_6F19(param_00,param_01)
{
	var_02 = self method_8134();
	var_03 = 0;
	var_04 = var_02;
	var_05 = 0;
	for(;;)
	{
		for(var_05 = randomintrange(1,10);var_05;var_05--)
		{
			wait(randomfloatrange(0.05,0.1));
			if(var_04 > 0.2)
			{
				var_04 = randomfloatrange(0,0.3);
			}
			else
			{
				var_04 = var_02;
			}

			self setlightintensity(var_04);
		}

		self setlightintensity(var_02);
		wait(randomfloatrange(param_00,param_01));
	}
}

//Function Number: 36
func_11203(param_00)
{
	var_01 = 1;
	if(isdefined(param_00.var_ED75))
	{
		var_01 = param_00.var_ED75;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 func_F5B8(var_01);
	}
}

//Function Number: 37
func_F5B8(param_00)
{
	var_01 = getdvarint("sm_sunenable",1);
	var_02 = getdvarfloat("sm_sunshadowscale",1);
	var_03 = getdvarfloat("sm_sunsamplesizenear",0.25);
	var_04 = getdvarfloat("sm_qualityspotshadow",1);
	if(isdefined(self.var_EED5))
	{
		var_01 = self.var_EED5;
	}

	if(isdefined(self.var_EED7))
	{
		var_02 = self.var_EED7;
	}

	if(isdefined(self.var_EED6))
	{
		var_03 = self.var_EED6;
	}

	var_03 = min(max(0.016,var_03),32);
	if(isdefined(self.var_EE8E))
	{
		var_04 = self.var_EE8E;
	}

	var_05 = getdvarint("sm_sunenable",1);
	var_06 = getdvarfloat("sm_sunshadowscale",1);
	var_07 = getdvarint("sm_qualityspotshadow",1);
	function_01C5("sm_sunenable",var_01);
	function_01C5("sm_sunshadowscale",var_02);
	function_01C5("sm_qualityspotshadow",var_04);
	func_ABA0(var_03,param_00);
}

//Function Number: 38
func_ABA0(param_00,param_01)
{
	level notify("changing_sunsamplesizenear");
	level endon("changing_sunsamplesizenear");
	var_02 = getdvarfloat("sm_sunSampleSizeNear",0.25);
	if(param_00 == var_02)
	{
		return;
	}

	var_03 = param_00 - var_02;
	var_04 = param_01 / 0.05;
	if(var_04 > 0)
	{
		var_05 = var_03 / var_04;
		var_06 = var_02;
		for(var_07 = 0;var_07 < var_04;var_07++)
		{
			var_06 = var_06 + var_05;
			function_01C5("sm_sunSampleSizeNear",var_06);
			wait(0.05);
		}
	}

	function_01C5("sm_sunSampleSizeNear",param_00);
}

//Function Number: 39
func_AB83(param_00,param_01)
{
	var_02 = int(param_01 * 20);
	var_03 = self method_8134();
	var_04 = param_00 - var_03 / var_02;
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		thread func_8924(param_00);
		self setlightintensity(var_03 + var_05 * var_04);
		wait(0.05);
	}

	var_06[0] = self;
	if(isdefined(self.var_AD22))
	{
		var_06 = scripts\common\utility::array_combine(var_06,self.var_AD22);
	}

	foreach(var_08 in var_06)
	{
		var_08 thread func_8924(param_00);
		var_08 setlightintensity(param_00);
	}
}

//Function Number: 40
func_8924(param_00)
{
	if(isdefined(self.var_EEE3))
	{
		var_01 = param_00 > self.var_EEE3;
		foreach(var_03 in self.var_AD83)
		{
			if(var_01 && !var_03.var_13438)
			{
				var_03.var_13438 = var_01;
				var_03 show();
				if(isdefined(var_03.var_5FDF))
				{
					var_03.var_5FDF thread scripts\sp\_utility::func_E2B0();
				}

				continue;
			}

			if(!var_01 && var_03.var_13438)
			{
				var_03.var_13438 = var_01;
				var_03 hide();
				if(isdefined(var_03.var_5FDF))
				{
					var_03.var_5FDF thread scripts\common\utility::func_C9CF();
				}
			}
		}

		foreach(var_03 in self.var_12BB6)
		{
			if(!var_01 && !var_03.var_13438)
			{
				var_03.var_13438 = 1;
				var_03 show();
				continue;
			}

			if(var_01 && var_03.var_13438)
			{
				var_03.var_13438 = 0;
				var_03 hide();
			}
		}
	}
}