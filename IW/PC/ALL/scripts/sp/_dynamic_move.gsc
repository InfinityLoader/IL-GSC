/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_dynamic_move.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 130 ms
 * Timestamp: 10/27/2023 12:24:15 AM
*******************************************************************/

//Function Number: 1
func_5F84(param_00)
{
	self notify("disable_dynamic_move");
	self endon("disable_dynamic_move");
	if(isdefined(self.var_5F76))
	{
		var_01 = squared(self.var_5F76);
	}
	else if(isdefined(var_01))
	{
		var_01 = squared(var_01);
	}
	else
	{
		var_01 = squared(300);
	}

	self.var_51E4 = undefined;
	scripts\sp\_utility::func_4145();
	func_F491("sprint_loop","sprint_super");
	for(;;)
	{
		var_02 = vectornormalize(level.player.origin - self.origin);
		var_03 = anglestoforward(self.angles);
		var_04 = vectordot(var_03,var_02);
		var_05 = distance2dsquared(level.player.origin,self.origin);
		if(var_04 < 0)
		{
			if(var_05 > var_01)
			{
				if(!isdefined(self.var_51E3) || isdefined(self.var_51E3) && self.var_51E3 == "sprint")
				{
					scripts\sp\_utility::func_4145();
					if(isdefined(self.var_51E4))
					{
						scripts\sp\_utility::func_51E1(self.var_51E4);
					}
				}
			}
			else if(!isdefined(self.var_51E3) || isdefined(self.var_51E3) && self.var_51E3 != "sprint")
			{
				self.var_51E4 = self.var_51E3;
				scripts\sp\_utility::func_51E1("sprint");
			}
		}
		else if(!isdefined(self.var_51E3) || isdefined(self.var_51E3) && self.var_51E3 != "sprint")
		{
			self.var_51E4 = self.var_51E3;
			scripts\sp\_utility::func_51E1("sprint");
		}

		wait(0.05);
	}
}

//Function Number: 2
func_5557()
{
	self notify("disable_dynamic_move");
	if(isdefined(self.var_51E4))
	{
		scripts\sp\_utility::func_51E1(self.var_51E4);
	}
	else
	{
		scripts\sp\_utility::func_4145();
	}

	self.var_51E4 = undefined;
	scripts\sp\_utility::func_4169("sprint");
}

//Function Number: 3
func_F491(param_00,param_01)
{
	if(!lib_0A1A::func_2346(param_00,param_01))
	{
		return;
	}

	var_02 = lib_0A1A::func_2358(param_00,param_01);
	lib_0A1A::func_237A("sprint","move",var_02);
}