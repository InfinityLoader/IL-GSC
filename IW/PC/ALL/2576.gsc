/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2576.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:23:23 AM
*******************************************************************/

//Function Number: 1
func_9898(param_00)
{
	self.meleerangesq = 12100;
	self.meleechargedist = 160;
	self.meleechargedistvsplayer = 200;
	self.meleechargedistreloadmultiplier = 1;
	self.var_B627 = 36;
	self.meleeactorboundsradius = 32;
	self.var_1548 = 0.98;
	self.var_71AF = ::func_9E99;
	self.var_7199 = ::func_38CF;
	return level.var_111AE;
}

//Function Number: 2
func_3376(param_00)
{
	self.meleerangesq = 5184;
	self.meleechargedist = 160;
	self.meleechargedistvsplayer = 200;
	self.meleechargedistreloadmultiplier = 1;
	self.var_B627 = 36;
	self.meleeactorboundsradius = 40;
	self.var_1548 = 0.98;
	self.var_71AF = ::func_3381;
	self.var_7199 = ::func_38CF;
	return level.var_111AE;
}

//Function Number: 3
func_F13B(param_00)
{
	self.meleerangesq = 5184;
	self.meleechargedist = 256;
	self.meleechargedistvsplayer = 512;
	self.meleechargedistreloadmultiplier = 1;
	self.var_B627 = 36;
	self.meleeactorboundsradius = 40;
	self.var_1548 = 0.98;
	self.var_71AF = ::func_9E99;
	self.var_7199 = ::func_38CF;
	return level.var_111AE;
}

//Function Number: 4
func_38CF(param_00,param_01)
{
	return self method_81FF(param_00,param_01,0,1);
}

//Function Number: 5
func_3381(param_00,param_01)
{
	if(isai(param_00))
	{
		if(param_00.var_12BA4 != "soldier")
		{
			return 0;
		}
	}

	return func_9E99(param_00,param_01);
}

//Function Number: 6
func_9E99(param_00,param_01)
{
	if(!lib_0A0E::func_9E9A(param_00,param_01))
	{
		return 0;
	}

	if(param_01)
	{
		if(isdefined(self.var_1491.var_C4C8) || self.var_1491.var_D6A5 == "prone")
		{
			return 0;
		}

		if(isdefined(self.var_12BA4) && self.var_12BA4 == "seeker")
		{
			if(!isplayer(self.var_222) && !lib_0F3D::func_B575(self.var_12BA4))
			{
				return 0;
			}
		}
		else
		{
			if(scripts\anim\utility_common::func_9FCA() && !isplayer(param_00))
			{
				return 0;
			}

			if(!lib_0F3D::func_B575(self.var_12BA4,1))
			{
				return 0;
			}
		}
	}

	if(isdefined(self.var_15F) && self.var_14F == 1)
	{
		return 0;
	}

	if(isdefined(self.var_A985) && self.var_10C == self.var_A985 && gettime() <= self.var_BF90)
	{
		return 0;
	}

	if(isdefined(param_00.var_5951) || isdefined(param_00.ignoreme) && param_00.ignoreme)
	{
		return 0;
	}

	if(!isai(param_00) && !isplayer(param_00))
	{
		return 0;
	}

	if(isdefined(self.var_B5DD) && isdefined(param_00.var_B5DD))
	{
		return 0;
	}

	if((isdefined(self.var_B5DD) && isdefined(param_00.var_B14F)) || isdefined(param_00.var_B5DD) && isdefined(self.var_B14F))
	{
		return 0;
	}

	if(isai(param_00))
	{
		if(param_00 method_81A6())
		{
			return 0;
		}

		if(param_00 scripts\sp\_utility::func_58DA() || param_00.var_EB)
		{
			return 0;
		}

		if(self.var_2C0 != "none" || param_00.var_2C0 != "none")
		{
			return 0;
		}

		if(self.var_12BA4 == "soldier" && param_00.var_12BA4 == "c6")
		{
			return 0;
		}

		if(self.var_12BA4 == "c6" && param_00.var_12BA4 == "c6i")
		{
			return 0;
		}

		if(param_00.var_12BA4 != "soldier" && param_00.var_12BA4 != "c6" && param_00.var_12BA4 != "c6i" && param_00.var_12BA4 != "civilian")
		{
			return 0;
		}
	}

	if(!isdefined(self.var_B622) || !self.var_B622 || !isplayer(param_00))
	{
		if(isplayer(param_00))
		{
			var_02 = param_00 getstance();
		}
		else
		{
			var_02 = param_01.var_1491.var_D6A5;
		}

		if(var_02 != "stand" && var_02 != "crouch")
		{
			return 0;
		}
	}

	if(isdefined(self.var_B14F) && isdefined(param_00.var_B14F))
	{
		return 0;
	}

	if(isdefined(param_00.var_15F))
	{
		return 0;
	}

	return 1;
}