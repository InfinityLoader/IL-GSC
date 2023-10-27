/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2958.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:24:59 AM
*******************************************************************/

//Function Number: 1
func_977D()
{
	if(!scripts\common\utility::func_16F3("player_thermal",::func_977D))
	{
		return;
	}

	lib_0B5F::func_965A();
	scripts\common\utility::array_thread(level.players,::func_13BA5);
}

//Function Number: 2
func_13BA5()
{
	if(!isdefined(level.var_73F8))
	{
		level.var_73F8 = loadfx("vfx/core/equipment/thermal_tapereflect_inverted.vfx");
	}

	self endon("death");
	var_00 = self getcurrentweapon();
	if(func_13BF6(var_00))
	{
		thread func_11776();
	}

	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(func_13BF6(var_01))
		{
			thread func_11776();
			continue;
		}

		self notify("acogThermalTracker");
	}
}

//Function Number: 3
func_11776()
{
	self endon("death");
	self notify("acogThermalTracker");
	self endon("acogThermalTracker");
	var_00 = 0;
	for(;;)
	{
		var_01 = var_00;
		var_00 = self method_822E();
		if(func_12998(var_00,var_01))
		{
			func_11775();
		}
		else if(func_12997(var_00,var_01))
		{
			func_11774();
		}

		wait(0.05);
	}
}

//Function Number: 4
func_12998(param_00,param_01)
{
	if(param_00 <= param_01)
	{
		return 0;
	}

	if(param_00 <= 0.65)
	{
		return 0;
	}

	return !isdefined(self.var_9C1F);
}

//Function Number: 5
func_12997(param_00,param_01)
{
	if(param_00 >= param_01)
	{
		return 0;
	}

	if(param_00 >= 0.8)
	{
		return 0;
	}

	return isdefined(self.var_9C1F);
}

//Function Number: 6
func_11775()
{
	self.var_9C1F = 1;
	var_00 = function_0072("allies");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_8BB5))
		{
			continue;
		}

		var_02.var_8BB5 = 1;
		var_02 thread func_B03E(self.var_12BA3);
	}
}

//Function Number: 7
func_11774()
{
	self.var_9C1F = undefined;
	level notify("thermal_fx_off" + self.var_12BA3);
	var_00 = function_0072("allies");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01].var_8BB5 = undefined;
	}
}

//Function Number: 8
func_13BF6(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "none")
	{
		return 0;
	}

	if(function_0241(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 9
func_B03E(param_00,param_01)
{
	if(isdefined(self.var_8B95))
	{
		return;
	}

	level endon("thermal_fx_off" + param_00);
	self endon("death");
	for(;;)
	{
		if(isdefined(param_01))
		{
			playfxontagforclients(level.var_73F8,self,"J_Spine4",param_01);
		}
		else
		{
			playfxontag(level.var_73F8,self,"J_Spine4");
		}

		wait(0.2);
	}
}