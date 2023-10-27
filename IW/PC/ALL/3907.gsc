/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3907.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:31:12 AM
*******************************************************************/

//Function Number: 1
func_1000F()
{
	return isdefined(self.var_10C) && isplayer(self.var_10C) && self method_805F(self.var_10C);
}

//Function Number: 2
func_6A70(param_00)
{
	self endon(param_00 + "_finished");
	var_01 = self.var_1D0 * self.var_1D0;
	for(;;)
	{
		scripts\common\utility::func_136F7();
		if(func_1000F())
		{
			var_02 = distancesquared(self.origin,self.var_10C.origin);
			if(var_02 < var_01)
			{
				self method_8221("face enemy");
			}
			else
			{
				self method_8221("face current");
			}

			continue;
		}

		self method_8221("face current");
	}
}

//Function Number: 3
func_116F5(param_00,param_01,param_02)
{
}

//Function Number: 4
func_D46C(param_00,param_01,param_02,param_03)
{
	func_D46D(param_00,param_01,param_02,param_03);
}

//Function Number: 5
func_D46D(param_00,param_01,param_02,param_03)
{
	scripts\anim\combat::func_F296();
	var_04 = self.var_164D[param_00];
	if(isdefined(var_04.var_10E23) && var_04.var_10E23 == "stand_run_loop" || var_04.var_10E23 == "move_walk_loop")
	{
		childthread scripts\asm\shared_utility::func_FB04(param_01,param_02);
	}

	if(isdefined(self.var_205))
	{
		self.var_1198.var_AA3D = self.var_205;
	}

	if(self.team != "allies")
	{
		thread func_6A70(param_01);
	}

	lib_0A1E::func_235F(param_00,param_01,param_02,1);
}

//Function Number: 6
func_0260(param_00,param_01,param_02,param_03)
{
	self endon("reload_terminate");
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	if(weaponclass(self.var_394) == "pistol")
	{
		self method_8221("face enemy");
	}

	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	lib_0A1E::func_231F(param_00,param_01);
	scripts\anim\weaponlist::func_DE4D();
}

//Function Number: 7
func_CECB(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1B::func_292E();
	var_05 = lib_0A1E::func_2336(param_00,param_01);
	self method_82E4(param_01,var_05,lib_0A1E::func_2339(),1,param_02,scripts\anim\combat_utility::func_6B9A());
	lib_0A1E::func_2369(param_00,param_01,var_05);
	lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
	self notify("switched_to_sidearm");
	scripts\sp\_gameskill::func_54C4();
}

//Function Number: 8
func_D56A(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	scripts\sp\_gameskill::func_54C4();
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	if(scripts\common\utility::func_167E() && isdefined(self.var_10C))
	{
		self method_8221("face enemy");
	}
	else
	{
		self method_8221("face angle 3d",self.angles);
	}

	if(isdefined(self.var_205))
	{
		self method_8016("angle deltas");
	}
	else
	{
		self method_8016("zonly_physics");
	}

	lib_0A1E::func_2369(param_00,param_01,var_04);
	self.var_10F8C = angleclamp180(getangledelta(var_04,0,1) + self.angles[1]);
	self.var_36A = 1;
	self method_82E7(param_01,var_04,1,param_02,1);
	if(func_1000F())
	{
		thread func_D56D(var_04,param_01);
	}

	var_05 = lib_0A1E::func_231F(param_00,param_01);
	if(var_05 == "end")
	{
		thread lib_0A1A::func_2310(param_00,param_01,0);
	}
}

//Function Number: 9
func_D56D(param_00,param_01)
{
	self endon("death");
	self endon(param_01 + "_finished");
	var_02 = self.var_10C;
	var_02 endon("death");
	var_03 = getanimlength(param_00);
	var_04 = int(var_03 * 20);
	var_05 = var_04;
	while(var_05 > 0)
	{
		var_06 = 1 / var_05;
		var_07 = scripts\common\utility::func_824D(var_02.origin);
		self.var_10F8C = angleclamp180(self.angles[1] + var_07);
		var_08 = self method_8102(param_00);
		var_09 = getangledelta(param_00,var_08,1);
		var_0A = angleclamp180(var_07 - var_09);
		self method_8221("face angle",angleclamp(self.angles[1] + var_0A * var_06));
		var_05--;
		wait(0.05);
	}
}

//Function Number: 10
func_D56B(param_00,param_01,param_02)
{
	self.var_36A = 0;
	self.var_10F8C = undefined;
}

//Function Number: 11
func_9EB9(param_00,param_01,param_02,param_03)
{
	return !scripts\asm\shared_utility::func_9D50();
}

//Function Number: 12
func_1007E(param_00,param_01,param_02,param_03)
{
	if(lib_0A1B::func_2955())
	{
		return 0;
	}

	if(!scripts\asm\shared_utility::func_9D50())
	{
		return 0;
	}

	if(!isdefined(self.var_205))
	{
		return 0;
	}

	if(isdefined(self.var_D8E1) && scripts\anim\utility_common::func_9FCA() && weaponclass(self.var_D8E1) != "mg")
	{
		return 0;
	}

	if(!isdefined(param_03))
	{
		return 1;
	}

	return lib_0F3D::func_9D4C(param_00,param_01,param_02,param_03);
}

//Function Number: 13
func_1007F(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_205;
	var_05 = angleclamp180(scripts\asm\shared_utility::func_812D(var_04) - self.angles[1]);
	return abs(angleclamp180(var_05)) > self.var_129AF;
}

//Function Number: 14
func_4C03(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	if(!isdefined(self.var_205))
	{
		return var_04 == "Exposed Crouch";
	}

	if(distance2dsquared(self.origin,self.var_205.origin) > 225)
	{
		if(lib_0A1B::func_292C() == "stand")
		{
			return var_04 == "Exposed";
		}
		else
		{
			return var_04 == "Exposed Crouch";
		}
	}

	return lib_0F3D::func_9D4C(param_00,param_01,param_02,param_03);
}