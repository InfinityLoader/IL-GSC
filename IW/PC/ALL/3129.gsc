/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3129.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 5 ms
 * Timestamp: 10/27/2023 12:26:13 AM
*******************************************************************/

//Function Number: 1
func_3EA8(param_00,param_01,param_02)
{
	return 0;
}

//Function Number: 2
func_CEC6(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1D::func_2337(param_00,param_01);
	var_05 = func_7EE8(var_04);
	var_06 = lib_0A1B::func_2930();
	if(var_06 == self.var_10C)
	{
		var_07 = func_128A2(param_00,param_01,var_06,undefined,var_04,param_02,var_05);
	}
	else
	{
		var_07 = 0;
	}

	if(!var_07)
	{
		self endon(param_01 + "_finished");
		wait(0.2);
		lib_0A1A::func_2330(param_01,"end");
	}
}

//Function Number: 3
func_128A2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_08))
	{
		param_08 = 1;
	}

	var_0A = self.var_1491.var_870D;
	if(!isdefined(param_04))
	{
		return 0;
	}

	if(isdefined(param_03))
	{
		if(!isdefined(param_07))
		{
			var_0B = self method_806C(param_06,param_03,param_08,"min energy","min time","max time");
		}
		else
		{
			var_0B = self method_806C(param_07,param_04,param_09,"min time","min energy");
		}
	}
	else
	{
		var_0C = self.var_DCAF;
		var_0D = distance(param_02.origin,self.origin);
		if(var_0D < 800)
		{
			if(var_0D < 256)
			{
				var_0C = 0;
			}
			else
			{
				var_0C = var_0C * var_0D - 256 / 544;
			}
		}

		if(!isdefined(param_07))
		{
			var_0B = self method_806B(param_06,var_0C,"min energy","min time","max time");
		}
		else
		{
			var_0B = self method_806B(param_06,var_0C,"min time","min energy");
		}
	}

	self.var_1491.var_BF84 = gettime() + randomintrange(1000,2000);
	if(isdefined(var_0B))
	{
		if(!isdefined(self.var_C3F3))
		{
			self.var_C3F3 = self.var_163;
		}

		self.var_163 = 0;
		var_0E = func_7E6D();
		func_F72C(self.var_1652,min(gettime() + 3000,var_0E));
		var_0F = 0;
		if(func_13116())
		{
			param_02.var_C231++;
			thread func_DE37(param_01,param_02);
			if(param_02.var_C231 > 1)
			{
				var_0F = 1;
			}

			if(self.var_1652.var_1191A == "fraggrenade")
			{
				if(param_02.var_C231 <= 1)
				{
					param_02.var_A98C = gettime();
				}
			}
		}

		if(isdefined(param_09))
		{
			thread func_58BA(param_00,param_01,param_04,var_0B,param_05,var_0E,var_0F);
		}
		else
		{
			func_58BA(param_00,param_01,param_04,var_0B,param_05,var_0E,var_0F);
		}

		return 1;
	}
	else
	{
	}

	return 0;
}

//Function Number: 4
func_7EE8(param_00)
{
	var_01 = (0,0,64);
	if(isdefined(param_00))
	{
		foreach(var_04, var_03 in level.var_85DF)
		{
			if(param_00 == var_03)
			{
				var_01 = level.var_85E1[var_04];
				break;
			}
		}
	}

	if(var_01[2] == 64)
	{
		if(!isdefined(param_00))
		{
		}
		else
		{
		}
	}

	return var_01;
}

//Function Number: 5
func_7E6D()
{
	var_00 = undefined;
	var_01 = gettime();
	if(func_13116() && isdefined(self.var_1652.player.var_86A9))
	{
		var_02 = self.var_1652.player;
		var_00 = var_01 + var_02.var_86A9.var_D396 + randomint(var_02.var_86A9.var_D397);
	}
	else
	{
		var_00 = var_01 + 30000 + randomint(30000);
	}

	return var_00;
}

//Function Number: 6
func_13116()
{
	return self.var_1652.var_9EFB;
}

//Function Number: 7
func_DE37(param_00,param_01)
{
	self endon("dont_reduce_giptp_on_killanimscript");
	self waittill(param_00 + "_finished");
	param_01.var_C231--;
}

//Function Number: 8
func_89AD(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon(param_01 + "_finished");
	var_05 = scripts\anim\utility_common::func_7EE7();
	var_06 = self method_8101(param_01,param_02);
	var_07 = "none";
	var_08 = 0;
	while(!var_08)
	{
		self waittill(param_01,var_09);
		if(!isarray(var_09))
		{
			var_09 = [var_09];
		}

		foreach(var_0B in var_09)
		{
			if(var_0B == "grenade_left" || var_0B == "grenade_right")
			{
				var_07 = func_2481(param_01,var_05,"tag_accessory_right");
				self.var_9E33 = 1;
			}

			if(var_0B == "grenade_throw" || var_0B == "grenade throw")
			{
				var_08 = 1;
				continue;
			}

			if(var_0B == "end")
			{
				self.var_1652.player.var_C231--;
				self notify("dont_reduce_giptp_on_killanimscript");
				return 0;
			}
		}
	}

	self notify("dont_reduce_giptp_on_killanimscript");
	if(func_13116())
	{
		thread func_13A98(param_01,self.var_1652.player,param_03);
	}

	self method_83C2();
	if(!func_13116())
	{
		func_F72C(self.var_1652,param_03);
	}

	if(param_04)
	{
		var_13 = self.var_1652.player;
		if(var_13.var_C231 > 1 || gettime() - var_13.var_A990 < 2000)
		{
			var_13.var_85E4["double_grenade"] = gettime() + min(5000,var_13.var_86A9.var_D382);
		}
	}

	self notify("stop grenade check");
	if(var_07 != "none")
	{
		self detach(var_05,var_07);
	}
	else
	{
	}

	self.var_9E33 = undefined;
	self.var_163 = self.var_C3F3;
	self.var_C3F3 = undefined;
}

//Function Number: 9
func_58BA(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("killanimscript");
	self endon(param_01 + "_finished");
	thread func_89AD(param_00,param_01,param_02,param_05,param_06);
	lib_0A1D::func_2365(param_00,param_01,param_04,param_02);
	self waittillmatch("end",param_01);
	self notify("done_grenade_throw");
	self notify("weapon_switch_done");
	if(!lib_0A1A::func_232B(param_01,"end"))
	{
		lib_0A1A::func_2330(param_01,"end");
	}
}

//Function Number: 10
func_6B9A()
{
	return 1.5;
}

//Function Number: 11
func_2481(param_00,param_01,param_02)
{
	self attach(param_01,param_02);
	thread func_5392(param_00,param_01,param_02);
	return param_02;
}

//Function Number: 12
func_5392(param_00,param_01,param_02)
{
	self endon("stop grenade check");
	self waittill(param_00 + "_finished");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.var_C3F3))
	{
		self.var_163 = self.var_C3F3;
		self.var_C3F3 = undefined;
	}

	self detach(param_01,param_02);
}

//Function Number: 13
func_13A98(param_00,param_01,param_02)
{
	param_01 endon("death");
	func_13A99(param_00,param_02);
	param_01.var_C231--;
}

//Function Number: 14
func_13A99(param_00,param_01)
{
	var_02 = self.var_1652;
	var_03 = spawnstruct();
	var_03 thread func_13A9A(5);
	var_03 endon("watchGrenadeTowardsPlayerTimeout");
	var_04 = self.var_166;
	var_05 = func_7EE6(param_00);
	if(!isdefined(var_05))
	{
		return;
	}

	func_F72C(var_02,min(gettime() + 5000,param_01));
	var_06 = -3036;
	var_07 = 160000;
	if(var_04 == "flash_grenade")
	{
		var_06 = 810000;
		var_07 = 1690000;
	}

	var_08 = level.players;
	var_09 = var_05.origin;
	for(;;)
	{
		wait(0.1);
		if(!isdefined(var_05))
		{
			break;
		}

		if(distancesquared(var_05.origin,var_09) < 400)
		{
			var_0A = [];
			for(var_0B = 0;var_0B < var_08.size;var_0B++)
			{
				var_0C = var_08[var_0B];
				var_0D = distancesquared(var_05.origin,var_0C.origin);
				if(var_0D < var_06)
				{
					var_0C func_85C8(var_02,param_01);
					continue;
				}

				if(var_0D < var_07)
				{
					var_0A[var_0A.size] = var_0C;
				}
			}

			var_08 = var_0A;
			if(var_08.size == 0)
			{
				break;
			}

			var_09 = var_05.origin;
		}
	}
}

//Function Number: 15
func_85C8(param_00,param_01)
{
	var_02 = self;
	anim.var_11813 = undefined;
	if(gettime() - var_02.var_A990 < 3000)
	{
		var_02.var_85E4["double_grenade"] = gettime() + var_02.var_86A9.var_D382;
	}

	var_02.var_A990 = gettime();
	var_03 = var_02.var_85E4[param_00.var_1191A];
	var_02.var_85E4[param_00.var_1191A] = max(param_01,var_03);
}

//Function Number: 16
func_F72C(param_00,param_01)
{
	if(param_00.var_9EFB)
	{
		var_02 = param_00.player;
		var_03 = var_02.var_85E4[param_00.var_1191A];
		var_02.var_85E4[param_00.var_1191A] = max(param_01,var_03);
		return;
	}

	var_03 = level.var_85E4[param_01.var_1191A];
	level.var_85E4[param_00.var_1191A] = max(param_01,var_03);
}

//Function Number: 17
func_7EE6(param_00)
{
	self endon("killanimscript");
	self endon(param_00 + "_finished");
	self waittill("grenade_fire",var_01);
	return var_01;
}

//Function Number: 18
func_13A9A(param_00)
{
	wait(param_00);
	self notify("watchGrenadeTowardsPlayerTimeout");
}

//Function Number: 19
func_7EE9(param_00)
{
	if(param_00.var_9EFB)
	{
		return param_00.player.var_85E4[param_00.var_1191A];
	}

	return level.var_85E4[param_00.var_1191A];
}

//Function Number: 20
func_C371(param_00)
{
	var_01 = anglestoforward(self.angles);
	var_02 = anglestoright(self.angles);
	var_03 = anglestoup(self.angles);
	var_01 = var_01 * param_00[0];
	var_02 = var_02 * param_00[1];
	var_03 = var_03 * param_00[2];
	return var_01 + var_02 + var_03;
}