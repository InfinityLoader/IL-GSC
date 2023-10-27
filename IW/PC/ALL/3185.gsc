/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3185.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:26:28 AM
*******************************************************************/

//Function Number: 1
func_3F00(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_E3))
	{
		self.var_E3 = 0;
	}

	if(isdefined(self.var_102CD))
	{
		return lib_0A1A::func_2358(param_01,"slappy");
	}

	if(!scripts\common\utility::istrue(self.entered_playspace) || isdefined(self.var_DE) && self.var_DE == "MOD_MELEE")
	{
		return lib_0A1A::func_2358(param_01,"forward");
	}

	if(self.var_E3 > 135 || self.var_E3 <= -135)
	{
		if(scripts\common\utility::istrue(param_03) && !isdefined(self.var_102CD))
		{
			if(randomint(100) > 50)
			{
				var_04 = lib_0A1A::func_2358(param_01,"forward");
			}
			else
			{
				var_04 = lib_0A1A::func_2358(param_02,"backward");
			}
		}
		else
		{
			var_04 = lib_0A1A::func_2358(param_02,"forward");
		}
	}
	else if(self.var_E3 > 45 && self.var_E3 <= 135)
	{
		var_04 = lib_0A1A::func_2358(param_02,"right");
	}
	else if(self.var_E3 > -45 && self.var_E3 <= 45)
	{
		if(scripts\common\utility::istrue(var_04) && !isdefined(self.var_102CD))
		{
			if(randomint(100) > 50)
			{
				var_04 = lib_0A1A::func_2358(param_02,"forward");
			}
			else
			{
				var_04 = lib_0A1A::func_2358(param_02,"backward");
			}
		}
		else
		{
			var_04 = lib_0A1A::func_2358(param_02,"backward");
		}
	}
	else
	{
		var_04 = lib_0A1A::func_2358(param_02,"left");
	}

	return var_04;
}

//Function Number: 2
func_CF0E(param_00,param_01,param_02,param_03)
{
	self method_828A("gravity");
	self method_8281("anim deltas");
	lib_0F3C::func_CEA8(param_00,param_01,param_02);
}

//Function Number: 3
func_3EE2(param_00,param_01,param_02)
{
	return func_3F00(param_00,param_01,param_02,1);
}