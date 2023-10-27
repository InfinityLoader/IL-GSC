/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3869.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:31:04 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_9732();
	thread func_10A9E();
	thread func_13437();
}

//Function Number: 2
func_9732()
{
	self.var_10E6D = spawnstruct();
	self.var_10E6D.var_10A9D = [];
	self.var_10E6D.var_74D5 = [];
	scripts\sp\_utility::func_65E0("stealth_enabled");
	scripts\sp\_utility::func_65E0("stealth_override_goal");
	scripts\sp\_utility::func_65E1("stealth_enabled");
	scripts\sp\_utility::func_65E0("stealth_in_shadow");
	lib_0F27::func_868B("stealth_spotted");
	lib_0F27::func_8682();
}

//Function Number: 3
func_10A9E()
{
	self endon("death");
	self notify("spotted_thread");
	self endon("spotted_thread");
	for(;;)
	{
		scripts\sp\_utility::func_65E3("stealth_enabled");
		lib_0F27::func_868E("stealth_spotted");
		if(!scripts\sp\_utility::func_65DB("stealth_enabled"))
		{
			scripts\sp\_utility::func_65E3("stealth_enabled");
		}

		thread func_10E1B();
		scripts\sp\_utility::func_65E3("stealth_enabled");
		lib_0F27::func_868D("stealth_spotted");
		if(!scripts\sp\_utility::func_65DB("stealth_enabled"))
		{
			scripts\sp\_utility::func_65E3("stealth_enabled");
		}

		thread func_10E20();
	}
}

//Function Number: 4
func_10E1B()
{
	thread scripts\sp\_utility::func_F2DA(0);
	self.var_10E6D.var_C3EF = self.var_162;
	self.var_162 = 0;
	self.var_72DE = undefined;
	self.ignoreme = 1;
	if(isdefined(self.var_10E6D.var_74D5["hidden"]))
	{
		lib_0F18::func_10E8B("hidden");
	}
}

//Function Number: 5
func_10E20()
{
	thread scripts\sp\_utility::func_F2DA(1);
	if(isdefined(self.var_10E6D.var_C3EF))
	{
		self.var_162 = self.var_10E6D.var_C3EF;
	}
	else
	{
		self.var_162 = 3;
	}

	self.ignoreme = 0;
	self method_8250(0);
	scripts\sp\_utility::func_5514();
	if(isdefined(self.var_10E6D.var_74D5["spotted"]))
	{
		lib_0F18::func_10E8B("spotted");
	}
}

//Function Number: 6
func_81F0()
{
	self endon("death");
}

//Function Number: 7
func_13437()
{
	self endon("death");
	self endon("pain_death");
	for(;;)
	{
		scripts\sp\_utility::func_65E3("stealth_enabled");
		if(!isdefined(self.var_10E6D.var_931F))
		{
			self.var_1D4 = func_7938();
		}

		wait(0.05);
	}
}

//Function Number: 8
func_7938()
{
	var_00 = self.var_1491.var_D6A5;
	if(var_00 == "back")
	{
		var_00 = "prone";
	}

	if(lib_0F27::func_869D())
	{
		var_01 = "spotted";
	}
	else
	{
		var_01 = "hidden";
	}

	var_02 = level.var_10E6D.var_53A0.var_DCCA[var_01][var_00];
	if(scripts\sp\_utility::func_65DB("stealth_in_shadow"))
	{
		var_02 = max(level.var_10E6D.var_53A0.var_DCCA["hidden"]["prone"],var_02 * 0.5);
	}

	return var_02;
}