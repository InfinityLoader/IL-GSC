/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2584.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:23:24 AM
*******************************************************************/

//Function Number: 1
func_1180F(param_00)
{
	lib_0A1B::func_296C(1,self.var_10C);
	self.var_3135.var_9928[param_00] = gettime() + 4000;
}

//Function Number: 2
func_11811(param_00)
{
	lib_0A1B::func_296C(0);
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 3
func_11812(param_00)
{
	var_01 = lib_0A1B::func_2930();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	if(self.var_1491.var_D6A5 != self.var_1491.var_85E2)
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("throwgrenade","start",0))
	{
		self.var_3135.var_9928[param_00] = self.var_3135.var_9928[param_00] + 10000;
	}

	if(lib_0A1A::func_232A("throwgrenade","end"))
	{
		return level.var_111AE;
	}

	if(gettime() > self.var_3135.var_9928[param_00])
	{
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 4
func_8BF7(param_00)
{
	if(func_BE18() && gettime() >= 10000 || isdefined(level.var_932B) && level.var_932B)
	{
		self.var_1491.var_BF84 = gettime() + 500;
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 5
func_3928(param_00)
{
	if(isdefined(self.var_233) || isdefined(self.script) && self.script == "cover_arrival")
	{
		return level.var_6AD5;
	}

	if(self.var_166 == "none")
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_10C) && isdefined(self.var_10C.var_5963) && self.var_10C.var_5963)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_595D) && self.var_595D)
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::func_167E())
	{
		return level.var_6AD5;
	}

	if(scripts\anim\utility_common::func_13112())
	{
		return level.var_6AD5;
	}

	if(isdefined(level.var_11813) && isalive(level.player))
	{
		if(func_85E3(level.player,200))
		{
			return level.var_111AE;
		}
	}

	if(isdefined(self.var_10C) && func_85E3(self.var_10C,self.var_B781))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 6
func_85E3(param_00,param_01)
{
	var_02 = param_00.origin;
	if(!self method_805F(param_00))
	{
		if(isdefined(self.var_10C) && param_00 == self.var_10C && isdefined(self.var_FECF))
		{
			var_02 = self.var_FECF;
		}

		param_01 = 100;
	}
	else if(!isdefined(param_01))
	{
		param_01 = 100;
	}

	if(distancesquared(self.origin,var_02) < param_01 * param_01)
	{
		return 0;
	}

	if(self.var_1491.var_D6A5 != self.var_1491.var_85E2)
	{
		return 0;
	}

	func_F62B(param_00);
	if(!func_85B5(param_00))
	{
		return 0;
	}

	var_03 = scripts\common\utility::func_824D(var_02);
	if(abs(var_03) > 60)
	{
		return 0;
	}

	if(self.var_394 == "mg42" || self.var_162 <= 0)
	{
		return 0;
	}

	if(isdefined(self.var_10C) && param_00 == self.var_10C)
	{
		if(!func_3E1C())
		{
			return 0;
		}

		if(scripts\anim\utility_common::func_3908())
		{
			if(!self method_81A2(param_00,param_00.origin))
			{
				return 0;
			}

			return 1;
		}

		if(scripts\anim\utility_common::func_3918())
		{
			return 1;
		}

		if(!self method_81A2(param_00,param_00.origin))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 7
func_BE18()
{
	return gettime() >= self.var_1491.var_BF84;
}

//Function Number: 8
func_3E1C()
{
	var_00 = self.var_10C.origin - self.origin;
	var_01 = lengthsquared((var_00[0],var_00[1],0));
	if(self.var_166 == "flash_grenade")
	{
		return var_01 < 589824;
	}

	return var_01 >= -25536 && var_01 <= 1562500;
}

//Function Number: 9
func_D022()
{
	if(isdefined(self.var_71C7))
	{
		return [[ self.var_71C7 ]]();
	}

	return 0;
}

//Function Number: 10
func_85B5(param_00)
{
	if(func_D022())
	{
		return 0;
	}

	if(isdefined(self.var_EDB1) && self.var_EDB1 == 1)
	{
		return 1;
	}

	if(gettime() >= func_7EE9(self.var_1652))
	{
		return 1;
	}

	if(self.var_1652.var_9EFB && self.var_1652.var_1191A == "fraggrenade")
	{
		return func_B4EF(param_00);
	}

	return 0;
}

//Function Number: 11
func_F62B(param_00)
{
	self.var_1652 = spawnstruct();
	if(isplayer(param_00) && isdefined(param_00.var_85E4))
	{
		self.var_1652.var_9EFB = 1;
		self.var_1652.player = param_00;
		self.var_1652.var_1191A = self.var_166;
		return;
	}

	self.var_1652.var_9EFB = 0;
	self.var_1652.var_1191A = "AI_" + self.var_166;
}

//Function Number: 12
func_B4EF(param_00)
{
	if(func_D022())
	{
		return 0;
	}

	if(!param_00.var_86A9.var_5ACF)
	{
		return 0;
	}

	var_01 = gettime();
	if(var_01 < param_00.var_85E4["double_grenade"])
	{
		return 0;
	}

	if(var_01 > param_00.var_A98C + 3000)
	{
		return 0;
	}

	if(var_01 < param_00.var_A98C + 500)
	{
		return 0;
	}

	return param_00.var_C231 < 2;
}

//Function Number: 13
func_7EE9(param_00)
{
	if(param_00.var_9EFB)
	{
		return param_00.player.var_85E4[param_00.var_1191A];
	}

	return level.var_85E4[param_00.var_1191A];
}

//Function Number: 14
func_1182C(param_00)
{
	lib_0A1B::func_296D(1,self.var_10C);
	self.var_3135.var_9928[param_00] = gettime() + 4000;
}

//Function Number: 15
func_1182D(param_00)
{
	lib_0A1B::func_296D(0);
	self.var_3135.var_9928[param_00] = undefined;
}

//Function Number: 16
func_1182E(param_00)
{
	var_01 = lib_0A1B::func_2931();
	if(!isdefined(var_01))
	{
		return level.var_6AD5;
	}

	if(lib_0A1A::func_232A("throwSeeker","start",0))
	{
		self.var_3135.var_9928[param_00] = self.var_3135.var_9928[param_00] + 10000;
	}

	if(lib_0A1A::func_232A("throwSeeker","end"))
	{
		return level.var_111AE;
	}

	if(gettime() > self.var_3135.var_9928[param_00])
	{
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 17
func_3929(param_00)
{
	if(isdefined(self.var_233))
	{
		return level.var_6AD5;
	}

	if(self.var_166 == "none")
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_10C) && isdefined(self.var_10C.var_5963) && self.var_10C.var_5963)
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_595D) && self.var_595D)
	{
		return level.var_6AD5;
	}

	if(scripts\common\utility::func_167E())
	{
		return level.var_6AD5;
	}

	func_F62B(self.var_10C);
	if(!func_85B5(self.var_10C))
	{
		return 0;
	}

	return level.var_111AE;
}