/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3069.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:26:06 AM
*******************************************************************/

//Function Number: 1
func_488D()
{
	self.meleerangesq = 9216;
	self.meleechargedist = 1000;
	self.meleechargedistvsplayer = 1000;
	self.var_B627 = 36;
	self.meleeactorboundsradius = 32;
	self.var_1548 = 0.98;
	self.var_71AF = ::func_9DA2;
}

//Function Number: 2
func_9DA0(param_00)
{
	if(isdefined(self.var_5966))
	{
		return 0;
	}

	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(isdefined(self.var_10C.var_5966))
	{
		return 0;
	}

	if(isdefined(self.var_1412) && !lib_0A0E::func_38CD())
	{
		return 0;
	}

	if(isdefined(param_00) && param_00)
	{
		return 1;
	}

	if(lib_0A0E::func_9DD1())
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_9D9F(param_00)
{
	if(!lib_0A1B::func_293A())
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 4
func_487C(param_00)
{
	if(randomint(100) < 25)
	{
		lib_0BFE::func_E1B1(randomintrange(3000,8000));
	}
	else
	{
		lib_0BFE::func_E1B2(randomintrange(3000,8000));
	}

	thread lib_0BFE::func_5671();
	func_488D();
	return level.var_111AE;
}

//Function Number: 5
func_487B()
{
	lib_0BFE::func_41DA();
	lib_0BFE::func_41DB();
	lib_0BFE::func_F6C7();
}

//Function Number: 6
func_FFDD(param_00)
{
	if(!func_9DA0(0))
	{
		func_487B();
		return level.var_6AD5;
	}

	if(![[ self.var_71AF ]](self.var_10C,0))
	{
		func_487B();
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 7
func_4881(param_00)
{
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_3E30 = gettime() + 100;
	self.var_3135.var_9928[param_00].var_11901 = gettime() + 4000;
	self.var_3135.var_9928[param_00].var_6572 = self.var_10C.origin;
	self.var_B55B.var_2AC7 = 1;
	self.var_B55B.var_2AC6 = 1;
	self.var_B651 = 1;
	if(lib_0A1B::func_294B() && isdefined(self.var_3135.var_F1F7))
	{
		self.var_3135.var_F1F7 stoploopsound();
		self.var_3135.var_F1F7 playloopsound("c6_mvmt_crawl_loop_vocal");
		return;
	}

	self playloopsound("c6_mvmt_crawl_loop_vocal");
}

//Function Number: 8
func_487A(param_00)
{
	self.var_B55B.var_29B4 = 1;
	return level.var_111AE;
}

//Function Number: 9
func_488C(param_00)
{
	if(lib_0A0B::func_2EE1())
	{
		if(!isdefined(self.var_3135.var_487E))
		{
			self.var_3135.var_487E = 1;
			self.var_6D = 16;
			self method_8481(self.origin);
			thread lib_0BFE::func_F1F8();
		}

		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 10
func_9DA2(param_00,param_01)
{
	if(lib_0A0E::func_9E9A(param_00,param_01) == 0)
	{
		return 0;
	}

	if(param_01)
	{
		if(scripts\anim\utility_common::func_9FCA())
		{
			return 0;
		}
	}

	if(isdefined(self.var_15F) && self.var_14F == 1)
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

		if(param_00.var_12BA4 != "soldier" && param_00.var_12BA4 != "c6" && param_00.var_12BA4 != "c6i")
		{
			return 0;
		}
	}

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