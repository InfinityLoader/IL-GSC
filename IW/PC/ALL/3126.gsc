/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3126.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:26:12 AM
*******************************************************************/

//Function Number: 1
func_98C6(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_E873))
	{
		self notify("stop_move_anim_update");
		self.var_12DEF = undefined;
		self.var_E879 = 0;
		self.var_E873 = 1;
	}
}

//Function Number: 2
func_11088(param_00,param_01,param_02)
{
	return 0;
}

//Function Number: 3
func_D50D(param_00,param_01,param_02,param_03)
{
	func_98C6(param_00,param_01,param_02,param_03);
	func_E877(param_00,param_01,param_02,param_03);
}

//Function Number: 4
func_E875()
{
	if(isalive(self.var_10C))
	{
		return self.var_10C;
	}
}

//Function Number: 5
func_1006E()
{
	if(!self.var_12A)
	{
		return 0;
	}

	if(!lib_0C33::func_298D())
	{
		return 0;
	}

	if(!func_B4EC())
	{
		return 0;
	}

	if(!lib_0A1B::func_2956("combat"))
	{
		return 0;
	}

	if(self method_841E() < 200)
	{
		return 0;
	}

	var_00 = func_E875();
	if(!isdefined(var_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
func_10070(param_00,param_01,param_02,param_03)
{
	return func_1006E() && func_390F();
}

//Function Number: 7
func_1006F(param_00,param_01,param_02,param_03)
{
	return 0;
}

//Function Number: 8
func_1009F(param_00,param_01,param_02,param_03)
{
	return !func_10070(param_00,param_01,param_03);
}

//Function Number: 9
func_1009E(param_00,param_01,param_02,param_03)
{
	return !func_1006F(param_00,param_01,param_03);
}

//Function Number: 10
func_390F()
{
	return 1;
}

//Function Number: 11
func_390E()
{
	return 1;
}

//Function Number: 12
func_B4EC()
{
	if(!isdefined(self.var_394))
	{
		return 0;
	}

	if(self.var_394 == "none")
	{
		return 0;
	}

	var_00 = weaponclass(self.var_394);
	if(!scripts\anim\utility_common::func_1311A())
	{
		return 0;
	}

	if(isdefined(self.var_596C))
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
func_390D()
{
	if(isdefined(self.var_10C) && func_390F() || func_390E())
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
func_8096(param_00)
{
	var_01 = self.origin;
	var_02 = self.angles[1] + self method_813E();
	var_01 = var_01 + (cos(var_02),sin(var_02),0) * length(self getvelocity()) * param_00;
	var_03 = self.angles[1] - vectortoyaw(self.var_10C.origin - var_01);
	var_03 = angleclamp180(var_03);
	return var_03;
}

//Function Number: 15
func_E877(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0F3C::func_136B4(param_00,param_01,param_03);
	thread lib_0F3C::func_136E7(param_00,param_01,param_03);
	thread lib_0F3C::func_136CC(param_00,param_01,param_03);
	var_04 = self.var_B4C3;
	var_05 = self.var_E878;
	var_06 = self.var_E876;
	var_07 = 0;
	var_08 = 1;
	var_09 = 2;
	var_0A = 3;
	var_0B = 4;
	var_04 = self.var_B4C3;
	var_05 = self.var_E878;
	var_06 = self.var_E876;
	self method_8289("face motion");
	for(;;)
	{
		var_0C = func_E875();
		if(isdefined(var_0C))
		{
			var_0D = func_8096(0.2);
			var_0E = var_0D < 0;
		}
		else
		{
			var_0D = 0;
			var_0E = self.var_E879 < 0;
		}

		var_0F = var_07;
		var_10 = "f_anim;";
		var_11 = abs(var_0D);
		if(var_11 < 130)
		{
			if(var_11 > 100)
			{
				if(var_0E == 1)
				{
					var_0F = var_0A;
					var_10 = "lb_anim;";
				}
				else
				{
					var_0F = var_0B;
					var_10 = "rb_anim;";
				}
			}
			else if(var_11 > 45)
			{
				if(var_0E == 1)
				{
					var_0F = var_08;
					var_10 = "l_anim;";
				}
				else
				{
					var_0F = var_09;
					var_10 = "r_anim;";
				}
			}
		}

		self method_82AF(param_01,var_0F);
		if(isdefined(var_0C) && isplayer(var_0C))
		{
			self method_83CE();
		}

		wait(0.2);
	}
}

//Function Number: 16
func_D50E(param_00,param_01,param_02,param_03)
{
	func_98C6(param_00,param_01,param_02,param_03);
	func_E874(param_00,param_01,param_02,param_03);
}

//Function Number: 17
func_E874(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	for(;;)
	{
		if(isplayer(self.var_10C))
		{
			self method_83CE();
		}

		var_04 = lib_0A1D::func_2337(param_00,param_01);
		self method_82AF(param_01,var_04);
		wait(0.2);
	}
}

//Function Number: 18
func_3EFF(param_00,param_01,param_02)
{
	return 0;
}

//Function Number: 19
func_FFF5(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_55B5))
	{
		return 0;
	}

	var_04 = lib_0A1B::func_292F();
	if(!isdefined(var_04))
	{
		return 0;
	}

	if(!isdefined(self.var_233) || distancesquared(self.var_233,self.origin) < 160000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
func_D477(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	self method_82AF(param_01,var_04,self.fastcrawlanimscale);
	scripts\mp\agents\_scriptedagents::func_1384C(param_01,"end",param_01,var_04);
}