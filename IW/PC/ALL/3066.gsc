/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3066.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:26:05 AM
*******************************************************************/

//Function Number: 1
func_8987(param_00)
{
	if(!isdefined(param_00) || param_00 == 0)
	{
		lib_0C33::func_295A();
		return;
	}

	if(param_00 == 1 || param_00 == 2)
	{
		if(self.var_3250 <= 0)
		{
			param_00 = 0;
		}
	}

	switch(param_00)
	{
		case 2:
			lib_0C33::func_295B();
			break;

		case 1:
			lib_0C33::func_295C();
			break;

		default:
			lib_0C33::func_295A();
			break;
	}
}

//Function Number: 2
func_3E49(param_00)
{
	if(!isdefined(self.var_EF7D) && !isdefined(self.var_EF7A) && !isdefined(self.var_EF7C))
	{
		return level.var_6AD5;
	}

	func_8987(self.var_EF73);
	if(isdefined(self.var_10C))
	{
		if(isdefined(self.var_3123))
		{
			return level.var_6AD5;
		}

		if(isdefined(self.var_EF79) && self.var_EF79 > 0)
		{
			var_01 = self.var_EF79 * self.var_EF79;
			var_02 = distancesquared(self.origin,self.var_10C.origin);
			if(var_02 < var_01)
			{
				self.var_3123 = 1;
				return level.var_6AD5;
			}
		}
	}
	else
	{
		self.var_3123 = undefined;
	}

	if(isdefined(self.var_EF7E))
	{
		self method_8287(self.var_EF7E);
		var_03 = self.var_EF7E;
	}
	else
	{
		var_03 = 4;
	}

	if(isdefined(self.var_EF7D))
	{
		self method_8484();
		self method_8286(self.var_EF7D);
	}
	else if(isdefined(self.var_EF7A))
	{
		var_04 = distancesquared(self.origin,self.var_EF7A.origin);
		if(var_04 > var_03 * var_03)
		{
			self method_8484();
			self method_8284(self.var_EF7A);
		}
		else
		{
			return level.var_6AD5;
		}
	}
	else if(isdefined(self.var_EF7C))
	{
		self method_8484();
		self method_8285(self.var_EF7C);
	}

	return level.var_111AE;
}

//Function Number: 3
func_930A(param_00)
{
	if(lib_0A1B::func_2942())
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 4
func_930D(param_00)
{
	if(!lib_0A1B::func_2942() || !isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	var_01 = 0;
	if(lib_0A1B::func_2955())
	{
		var_01 = self method_841E();
	}

	if(var_01 == 0)
	{
		var_01 = distance2d(self.origin,self.var_10C.origin);
	}

	if(!lib_0A06::func_8BC8() || var_01 < self.forcefastcrawldist)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 5
func_97FA(param_00)
{
	if(self.health > self.fastcrawlmaxhealth)
	{
		self.health = self.fastcrawlmaxhealth;
	}

	lib_0C33::func_2979(1);
	return level.var_111AE;
}

//Function Number: 6
func_5814()
{
	playfx(level._effect["sentry_explode_mp"],self.origin);
	earthquake(0.5,1,self.origin,512);
	radiusdamage(self.origin,self.explosionradius,self.explosiondamagemax,self.explosiondamagemax,self,"MOD_EXPLOSIVE");
	self suicide();
}

//Function Number: 7
func_5813(param_00)
{
	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	var_01 = distancesquared(self.origin,self.var_10C.origin);
	if(var_01 < self.dismemberchargeexplodedistsq)
	{
		func_5814();
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 8
func_116F3(param_00)
{
	lib_0C33::func_2979(0);
}

//Function Number: 9
func_4F62(param_00,param_01)
{
	if(isdefined(self.var_4F63))
	{
		[[ self.var_4F63 ]](param_00,param_01);
		return;
	}

	var_02 = gettime();
	if(self.last_enemy_sight_time < 0 || var_02 - self.last_enemy_sight_time < self.maxtimetostrafewithoutlos)
	{
		lib_0C33::func_295C();
		return;
	}

	self.strafeifwithindist = self.desiredenemydistmax + 100;
	if(param_01 < self.strafeifwithindist)
	{
		lib_0C33::func_295C();
		return;
	}

	lib_0C33::func_295B();
}

//Function Number: 10
func_9ED8()
{
	return 0;
}

//Function Number: 11
func_3DE6(param_00)
{
	if(!isdefined(self.var_10C))
	{
		if(isdefined(self.var_6571))
		{
			return level.var_6AD5;
		}

		if(!func_9ED8())
		{
			lib_0A1B::func_2983(undefined);
			self method_841F();
		}

		return level.var_6AD5;
	}

	var_01 = gettime();
	if(isdefined(self.var_A938))
	{
		if(var_01 < self.var_A938 + 250)
		{
			return level.var_111AE;
		}
	}

	self.var_A938 = var_01;
	if(isdefined(self.var_A8B7) && isdefined(self.var_10C))
	{
		if(self.var_A8B7 != self.var_10C)
		{
			self.last_enemy_sight_time = -99;
		}
	}
	else
	{
		self.last_enemy_sight_time = -99;
	}

	var_02 = 1;
	var_03 = self method_805F(self.var_10C);
	var_04 = distance2d(self.origin,self.var_10C.origin);
	if(var_03)
	{
		var_02 = self method_8060(func_7E66());
	}
	else
	{
		var_02 = 0;
	}

	if(!var_02)
	{
		if(!scripts\common\utility::istrue(self.var_3320))
		{
			func_4F62(0,var_04);
			self method_8484();
			self method_8286(self.var_10C.origin);
		}

		return level.var_111AE;
	}

	self.var_3320 = undefined;
	self.last_enemy_sight_time = gettime();
	self.var_A8B7 = self.var_10C;
	if(var_04 > self.desiredenemydistmax)
	{
		func_4F62(1,var_04);
		self method_8484();
		self method_8286(self.var_10C.origin);
		return level.var_111AE;
	}

	if(var_04 < self.var_272A)
	{
		var_01 = gettime();
		if(isdefined(self.var_A88C) && var_01 - self.var_A88C < 500 && isdefined(self.var_233))
		{
			return level.var_111AE;
		}

		var_05 = vectornormalize(self.origin - self.var_10C.origin);
		var_06 = 100;
		var_07 = self.origin + var_05 * var_06;
		var_07 = getclosestpointonnavmesh(var_07,self);
		var_08 = var_07 - self.origin;
		var_08 = (var_08[0],var_08[1],0);
		var_09 = vectornormalize(var_08);
		var_0A = vectordot(var_09,var_05);
		if(var_0A > 0)
		{
			lib_0C33::func_295C();
			self method_8484();
			self method_8286(var_07);
			return level.var_111AE;
		}
	}

	if(var_04 < self.desiredenemydistmin)
	{
		if(!func_9ED8())
		{
			self method_841F();
		}

		return level.var_111AE;
	}

	return level.var_111AE;
}

//Function Number: 12
func_CB30()
{
	if(isdefined(self.var_10C) && isdefined(self.var_10C.var_565C) && self.var_10C.var_565C)
	{
		if(isdefined(self.var_3402))
		{
			return self.var_3402;
		}
	}

	var_00 = 0;
	var_01 = randomint(100);
	for(var_02 = 0;var_02 < self.var_3403.size;var_02++)
	{
		var_03 = self.var_3403[var_02];
		if(var_01 < var_03 + var_00)
		{
			return self.var_3404[var_02];
		}

		var_00 = var_00 + var_03;
	}

	return undefined;
}

//Function Number: 13
func_7E8E()
{
	var_00 = self.var_10C gettagorigin("j_head");
	return var_00;
}

//Function Number: 14
func_7E66()
{
	if(scripts\common\utility::istrue(self.var_565C))
	{
		return func_7E8E();
	}

	var_00 = 70;
	var_01 = 15;
	if(isdefined(self.var_10C.var_18F4))
	{
		var_00 = self.var_10C.var_18F4;
		var_01 = self.var_10C.var_18F9;
	}

	var_02 = var_00 * 0.75;
	var_03 = (0,0,var_02);
	var_04 = self.var_10C.origin + var_03;
	return var_04;
}

//Function Number: 15
func_12F35(param_00)
{
	if(!isdefined(self.var_3404))
	{
		return lib_0A06::func_12EC2(param_00);
	}

	if(isdefined(self.var_10C))
	{
		self.var_1C4 = undefined;
		if(!isdefined(self.var_719B) || !isdefined(self.var_BFB1) || gettime() > self.var_BFB1)
		{
			self.var_719B = func_CB30();
			self.var_BFB1 = gettime() + randomintrange(1500,2500);
		}

		if(isdefined(self.var_719B))
		{
			var_01 = self [[ self.var_719B ]]();
			if(!self method_8060(var_01))
			{
				var_01 = func_7E66();
			}
		}
		else
		{
			var_01 = func_7E66();
		}

		self.var_1C2 = var_01;
	}
	else
	{
		lib_0A1B::func_2983(undefined);
		self.var_1C2 = undefined;
		self.var_BFB1 = undefined;
	}

	return level.var_111AE;
}

//Function Number: 16
func_3401(param_00)
{
	if(!isdefined(self.var_1C2))
	{
		return lib_0A06::func_FE88(param_00);
	}

	if(lib_0A1A::func_232A("shoot","shoot_finished"))
	{
		return level.var_111AE;
	}

	var_01 = self.var_3135.var_FECD;
	if(self method_805F(self.var_10C))
	{
		self.var_1C4 = undefined;
		var_01.var_D699 = self.var_1C2;
		var_01.var_65D3 = undefined;
	}
	else if(isdefined(self.var_8451))
	{
		var_01.var_D699 = self.var_8451;
		var_01.var_65D3 = undefined;
	}
	else
	{
		return level.var_111AE;
	}

	if(!isdefined(var_01.var_C274))
	{
		var_01.var_C274 = "normal";
	}

	lib_0A1B::func_2983(var_01,self.var_10C);
	if(lib_0A06::func_9D2E())
	{
		if(!self.var_3135.var_B117)
		{
			lib_0A06::func_E259();
			lib_0A06::func_3EF9(var_01);
			lib_0A06::func_3EE3(var_01);
		}

		lib_0A06::func_3EF8(var_01);
		self.var_3135.var_B117 = 1;
	}
	else
	{
		self.var_3135.var_B117 = 0;
	}

	if(!isdefined(var_01.var_D699) && !isdefined(var_01.var_65D3))
	{
		return level.var_111AE;
	}

	lib_0A1B::func_2962(self.var_3135.var_B117);
	return level.var_E87A;
}