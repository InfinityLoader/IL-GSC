/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3070.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 66
 * Decompile Time: 22 ms
 * Timestamp: 10/27/2023 12:26:06 AM
*******************************************************************/

//Function Number: 1
func_97F9(param_00)
{
	self.var_719D = ::func_EF29;
	self.var_71A1 = ::func_EF2B;
	lib_0A15::func_FAA4();
	if(!isdefined(level.var_5667["c6"]))
	{
		level.var_5667["c6"] = [];
	}

	self.var_10264 = 1;
	return level.var_111AE;
}

//Function Number: 2
func_EF29(param_00)
{
	var_01 = 1;
	switch(param_00.var_22A)
	{
		case "head":
			break;

		case "right_leg":
		case "left_leg":
			var_01 = 1;
			break;
	}

	lib_0A0B::func_98C9(param_00.var_22A);
	if(self.var_1198.var_EF3B[param_00.var_22A].var_10E19 == "dismember")
	{
		return;
	}

	if(var_01)
	{
		var_02 = "dmg_" + param_00.var_2CD;
		lib_0A0B::func_F592(param_00.var_22A,var_02);
	}

	switch(param_00.var_22A)
	{
		case "torso":
			func_11A13();
			break;
	}
}

//Function Number: 3
func_EF2B(param_00)
{
	if(lib_0A1B::func_2938())
	{
		return;
	}

	var_01 = 1;
	switch(param_00.var_22A)
	{
		case "head":
			func_5666();
			lib_0A0B::func_98C9(param_00.var_22A);
			lib_0A0B::func_F592(param_00.var_22A,"dismember");
			break;

		case "right_arm":
			if(lib_0A0B::func_2040())
			{
				var_01 = 0;
			}
			else if(isdefined(self method_8148()))
			{
				var_01 = 0;
			}
	
			func_5675();
			break;

		case "left_arm":
			if(lib_0A0B::func_2040())
			{
				var_01 = 0;
			}
			else if(isdefined(self method_8148()))
			{
				var_01 = 0;
			}
	
			func_5668();
			break;

		case "right_leg":
		case "left_leg":
			if(isdefined(self.var_55B9))
			{
				return;
			}
			else if(isdefined(self method_8148()))
			{
				var_01 = 0;
			}
	
			if(lib_0A0B::func_2040())
			{
				var_01 = 0;
			}
	
			func_566B();
			break;

		case "torso":
			break;

		default:
			break;
	}

	func_EF2C(param_00.var_22A,var_01);
}

//Function Number: 4
func_EF2C(param_00,param_01)
{
	lib_0A0B::func_98C9(param_00);
	if(lib_0A0B::func_7C35(param_00) == "dismember")
	{
		return;
	}

	if(isdefined(self.var_3135.var_55CF))
	{
		return;
	}

	lib_0A0B::func_F6C9(param_00);
	thread lib_0A0B::func_F592(param_00,"dismember",0.05);
	if(isdefined(self.var_2023) && self.var_2023 != "get_up" && self.var_2023 != "fall")
	{
		return;
	}

	if(isdefined(self.var_3135.var_55CE))
	{
		return;
	}

	if(param_01)
	{
		lib_0A1A::func_237C("dismember");
	}
}

//Function Number: 5
func_566D()
{
	self.var_87F6 = 0;
	self method_8504(0);
	self.var_BC = "no_cover";
	self.var_163 = 0;
}

//Function Number: 6
func_5666()
{
	if(isdefined(self.var_3135.var_55CE))
	{
		return;
	}

	func_566D();
	self.var_3135.var_38E1 = 1;
	lib_0A1B::func_297C(1);
	func_3EDD();
}

//Function Number: 7
func_5668()
{
	if(!isdefined(self.var_B5DB) || lib_0A0B::func_E52D())
	{
		self.var_3135.var_38E1 = 1;
	}

	self.var_C08B = 1;
	if(lib_0A0B::func_E52D() && !isdefined(self.var_3135.var_5661))
	{
		self.var_3135.var_5661 = 2;
	}

	func_11A13();
}

//Function Number: 8
func_5675()
{
	if(isdefined(self.var_3135.var_55CE))
	{
		return;
	}

	func_566D();
	if(!isdefined(self.var_B5DB) || lib_0A0B::func_AB53())
	{
		self.var_3135.var_38E1 = 1;
	}

	var_00 = self.var_394 != "none";
	if(isdefined(self.var_C05C))
	{
		self.var_102 = 0;
		self.var_C05C = undefined;
	}

	scripts\anim\shared::func_5D19();
	if(isdefined(self.var_E282))
	{
		self.var_C05C = 1;
		self.var_E282 = undefined;
	}

	if(lib_0A0B::func_2040())
	{
		self.var_3135.var_5661 = 0;
		return;
	}

	if(func_D3E4())
	{
		self setscriptablepartstate("torso_overload_fx","overload");
		func_E1B1(3000);
		self.var_3135.var_5661 = 0;
		return;
	}

	if(var_00 || lib_0A0B::func_AB53())
	{
		lib_0A1B::func_2982(1);
		self.var_3135.var_5661 = 2;
		return;
	}
}

//Function Number: 9
func_566B()
{
	if(isdefined(self.var_3135.var_55CE))
	{
		return;
	}

	func_566D();
	if(lib_0A0B::func_2040())
	{
		return;
	}

	if(isdefined(self.var_3135.var_5661))
	{
		switch(self.var_3135.var_5661)
		{
			case 2:
			case 1:
			case 0:
				break;
		}
	}

	if(isdefined(self.var_2A8F))
	{
		self.var_3135.var_5661 = 2;
		self method_8321();
		return;
	}

	var_00 = 0;
	var_01 = 1;
	var_02 = [];
	if(lib_0BFD::func_9DA0(0))
	{
		var_02[var_02.size] = var_00;
	}

	var_03 = lib_0A1B::func_2920();
	if(isdefined(var_03) && distancesquared(var_03.origin,self.origin) < 144 && isdefined(self.var_10C))
	{
		var_04 = self.var_10C.origin - self.origin;
		var_05 = anglestoforward(var_03.angles);
		if(vectordot(var_05,var_04) < 0.5)
		{
			var_02[var_02.size] = var_01;
		}
	}
	else
	{
		var_02[var_02.size] = var_01;
	}

	if(var_02.size == 0)
	{
		var_02[0] = var_01;
	}

	var_06 = var_02[randomint(var_02.size)] == var_00;
	if(var_06)
	{
		self method_8321();
		scripts\anim\shared::func_5D19();
		lib_0A1B::func_2977(1);
		self.var_3135.var_5661 = 6;
		return;
	}

	self.var_3135.var_FEDB = "full";
	self.var_3135.var_FED8 = 1;
	self.var_3135.var_5661 = 5;
}

//Function Number: 10
func_11A13()
{
	if(isdefined(self.var_3135.var_11A14))
	{
		return;
	}

	if(isdefined(self.var_3135.var_5615))
	{
		return;
	}

	if(!isdefined(self.var_1198.var_EF3B))
	{
		return;
	}

	if(randomint(100) > level.var_33BB)
	{
		return;
	}

	if(distancesquared(self.origin,level.player.origin) < 65536)
	{
		return;
	}

	var_00 = ["right_arm","left_arm","right_leg","left_leg","head"];
	foreach(var_02 in var_00)
	{
		if(!isdefined(self.var_1198.var_EF3B[var_02]))
		{
			continue;
		}

		if(self.var_1198.var_EF3B[var_02].var_10E19 == "dismember")
		{
			return;
		}
	}

	self.var_3135.var_11A14 = 1;
	var_04 = ["right_arm","right_leg","left_leg"];
	var_05 = [3,1,1];
	var_06 = func_7D77(var_05);
	var_02 = var_04[var_06];
	self method_847D(var_02);
}

//Function Number: 11
func_8BE3(param_00)
{
	if(!isdefined(self.var_3135.var_5661))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 12
func_D3E4()
{
	var_00 = squared(196);
	if(distancesquared(self.origin,level.player.origin) <= var_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
func_E1B1(param_00)
{
	if(isdefined(self.var_3135.var_3126))
	{
		return;
	}

	self.var_3135.var_3126 = 1;
	self.var_3135.var_F1FE = param_00;
}

//Function Number: 14
func_41DA()
{
	if(isdefined(self.var_3135.var_3126))
	{
		self.var_3135.var_3127 = 1;
	}

	self.var_3135.var_3126 = undefined;
	self.var_3135.var_F1FE = undefined;
}

//Function Number: 15
func_10072(param_00)
{
	if(isdefined(self.var_3135.var_3126))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 16
func_F1FC(param_00)
{
	var_01 = gettime();
	if(self.var_3135.var_F1FE > 0)
	{
		thread func_F1F5(self.var_3135.var_F1FE * 0.001);
	}
	else
	{
		if(isdefined(self.var_3135.var_F1F7))
		{
			self.var_3135.var_F1F7 stoploopsound();
		}

		if(self.var_12BA4 == "c8")
		{
			self playsound("c8_destruct_preexplode");
		}
		else
		{
			self playsound("c6_destruct_preexplode");
		}

		self.var_3135.var_F1FE = 500;
	}

	self.var_3135.var_9928[param_00] = var_01 + self.var_3135.var_F1FE;
}

//Function Number: 17
func_F1FB(param_00)
{
	var_01 = gettime();
	if(isdefined(self.var_3135.var_3127))
	{
		self.var_3135.var_3127 = undefined;
		return level.var_6AD5;
	}

	if(isdefined(self.var_B55B) && isdefined(self.var_B55B.var_29B4))
	{
		return level.var_E87A;
	}

	if(var_01 < self.var_3135.var_9928[param_00])
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 18
func_5AA5(param_00)
{
	self method_8481(self.origin);
	self.var_6D = 64;
	self.var_3135.var_3125 = 1;
	anim thread [[ self.var_3135.var_71CC ]](self);
}

//Function Number: 19
func_5AA4(param_00)
{
	return level.var_E87A;
}

//Function Number: 20
func_9F3F(param_00)
{
	if(isdefined(self.var_3135.var_3125))
	{
		return level.var_E87A;
	}

	return level.var_6AD5;
}

//Function Number: 21
func_9F42(param_00)
{
	if(self.var_3135.var_5661 == 0)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 22
func_F20C(param_00)
{
	func_E1B1(0);
}

//Function Number: 23
func_F20B(param_00)
{
	return level.var_E87A;
}

//Function Number: 24
func_E1B2(param_00)
{
	if(isdefined(self.var_3135.var_3128))
	{
		return;
	}

	self.var_3135.var_3128 = 1;
	self.var_3135.var_F210 = param_00;
}

//Function Number: 25
func_41DB()
{
	self.var_3135.var_3128 = undefined;
	self.var_3135.var_F210 = undefined;
}

//Function Number: 26
func_10074(param_00)
{
	if(isdefined(self.var_3135.var_3128))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 27
func_F20F(param_00)
{
	var_01 = gettime();
	self.var_3135.var_9928[param_00] = var_01 + self.var_3135.var_F210;
}

//Function Number: 28
func_F20E(param_00)
{
	var_01 = gettime();
	if(isdefined(self.var_B55B) && isdefined(self.var_B55B.var_29B4))
	{
		self.var_3135.var_3128 = undefined;
		return level.var_6AD5;
	}

	if(var_01 < self.var_3135.var_9928[param_00])
	{
		return level.var_E87A;
	}

	return level.var_111AE;
}

//Function Number: 29
func_5AA6(param_00)
{
	self method_81D0();
	return level.var_E87A;
}

//Function Number: 30
func_9F40(param_00)
{
	if(self.var_3135.var_5661 == 1)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 31
func_F201(param_00)
{
	var_01 = gettime();
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_BFB5 = var_01;
	self.var_3135.var_9928[param_00].var_BFA1 = var_01 + 1000;
	self.var_C189 = 1;
	self.var_180 = 1;
	func_E1B1(randomintrange(4000,7000));
}

//Function Number: 32
func_9FF2(param_00,param_01)
{
	if(self == param_00)
	{
		return 0;
	}

	if(!isalive(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.var_1491) && isdefined(param_00.var_1491.var_58DA))
	{
		return 0;
	}

	if(distancesquared(param_00.origin,self.origin) > param_01)
	{
		return 0;
	}

	if(param_00.ignoreme)
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
func_F202(param_00)
{
	var_01 = gettime();
	if(var_01 >= self.var_3135.var_9928[param_00].var_BFB5)
	{
		var_02 = 1000000;
		var_03 = 100;
		self.var_3135.var_9928[param_00].var_BFA1 = var_01 + 500;
		self.var_3135.var_9928[param_00].var_BFB5 = var_01 + randomintrange(1000,4000);
		var_04 = undefined;
		var_05 = function_0072(self.team);
		if(var_05.size > 0)
		{
			var_05 = sortbydistance(var_05,self.origin);
			var_06 = [];
			foreach(var_08 in var_05)
			{
				if(func_9FF2(var_08,var_02))
				{
					var_06[var_06.size] = var_08;
				}
			}

			if(var_06.size > 0)
			{
				var_0A = var_06[randomint(var_06.size)];
				var_0B = vectornormalize(self.origin - var_0A.origin);
				var_04 = var_0A.origin + var_0B * var_03;
				var_04 = getclosestpointonnavmesh(var_04,self);
			}
		}

		if(!isdefined(var_04))
		{
			var_04 = getrandomnavpoint(self.origin,1000);
		}

		self method_8071();
		self.var_6D = var_03;
		self method_8481(var_04);
	}
	else if(var_01 >= self.var_3135.var_9928[param_00].var_BFA1)
	{
		if(self.var_2748 || !isdefined(self.var_233))
		{
			func_E1B1(1000);
		}
	}

	return level.var_E87A;
}

//Function Number: 34
func_F6C7()
{
	self.var_3135.var_5661 = 2;
}

//Function Number: 35
func_9F41(param_00)
{
	if(self.var_3135.var_5661 == 2)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 36
func_F207(param_00)
{
	var_01 = gettime();
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_BFB5 = var_01;
	self.var_3135.var_9928[param_00].var_BFA1 = var_01 + 1000;
	self.var_C189 = 1;
	self.var_180 = 1;
	self setscriptablepartstate("torso_overload_fx","overload");
}

//Function Number: 37
func_F209(param_00)
{
	var_01 = gettime();
	if(var_01 >= self.var_3135.var_9928[param_00].var_BFB5)
	{
		var_02 = undefined;
		if(isalive(self.var_10C))
		{
			var_02 = self.var_10C;
		}
		else
		{
			if(self.team == "axis")
			{
				var_03 = "allies";
			}
			else
			{
				var_03 = "axis";
			}

			var_04 = function_0072(var_03);
			if(var_03 == "allies")
			{
				var_04[var_04.size] = level.player;
			}

			var_05 = [];
			foreach(var_07 in var_04)
			{
				if(func_9FF2(var_07,4194304))
				{
					var_05[var_05.size] = var_07;
				}
			}

			if(var_05.size > 0)
			{
				var_05 = sortbydistance(var_05,self.origin);
				var_02 = var_05[0];
			}
		}

		if(isdefined(var_02))
		{
			self.var_3135.var_9928[param_00].var_BFA1 = var_01 + 1000;
			self.var_3135.var_9928[param_00].var_BFB5 = var_01 + 3000;
			self.var_15C = 80;
			self.var_3135.var_F1EE = var_02;
			self method_8482(var_02);
		}
	}
	else if(var_01 >= self.var_3135.var_9928[param_00].var_BFA1)
	{
		if(self.var_2748 || !isdefined(self.var_233))
		{
			func_E1B1(1000);
		}
	}

	return level.var_E87A;
}

//Function Number: 38
func_F206(param_00)
{
	if(isdefined(self.var_3135.var_F1EE))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 39
func_F205(param_00)
{
	var_01 = 1;
	var_02 = 180;
	if(lib_0A0B::func_2040())
	{
		var_02 = 145;
	}

	var_03 = distance(self.origin,self.var_3135.var_F1EE.origin);
	var_04 = var_03 / var_02 + var_01;
	thread func_F1F5(var_04);
	var_05 = gettime();
	self.var_3135.var_9928[param_00] = spawnstruct();
	self.var_3135.var_9928[param_00].var_10D7A = var_05 + 500;
	self.var_3135.var_9928[param_00].var_11064 = var_05 + 500 + var_04 * 1000;
}

//Function Number: 40
func_F203(param_00)
{
	var_01 = gettime();
	if(var_01 < self.var_3135.var_9928[param_00].var_10D7A)
	{
		return level.var_E87A;
	}

	if(var_01 >= self.var_3135.var_9928[param_00].var_11064)
	{
		return level.var_111AE;
	}

	if(!isalive(self.var_3135.var_F1EE))
	{
		return level.var_111AE;
	}

	var_02 = 9216;
	if(isdefined(self.seekselfdestructradiussq))
	{
		var_02 = self.seekselfdestructradiussq;
	}

	if(distancesquared(self.origin,self.var_3135.var_F1EE.origin) <= var_02)
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 41
func_F204(param_00)
{
	self.var_3135.var_9928[param_00] = undefined;
	if(isdefined(self.var_3135.var_F1F7))
	{
		self.var_3135.var_F1F7 stoploopsound();
	}
}

//Function Number: 42
func_F208(param_00)
{
	self method_8481(self.origin);
	self.var_6D = 24;
	self.var_3135.var_5661 = 0;
	return level.var_111AE;
}

//Function Number: 43
func_9E21(param_00)
{
	if(self.var_3135.var_5661 == 3 || self.var_3135.var_5661 == 4)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 44
func_8C53(param_00)
{
	func_E1B1(randomintrange(5000,10000));
	self.var_3135.var_9928[param_00] = gettime();
	self method_82B1(lib_0A1E::func_2342(),1.5);
	self.var_15C = 1000;
	self.team = "team3";
	self.var_180 = 0;
	self method_8481(self.origin);
	self.var_6D = 500;
	self.ignoreme = 1;
	self.var_2894 = 2;
	thread func_8C93();
}

//Function Number: 45
func_8C54(param_00)
{
	var_01 = gettime();
	if(var_01 >= self.var_3135.var_9928[param_00])
	{
		self method_80EC();
		self.var_3135.var_9928[param_00] = var_01 + randomintrange(2000,3000);
	}

	return level.var_E87A;
}

//Function Number: 46
func_9FB8(param_00)
{
	if(self.var_3135.var_5661 == 5)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 47
func_9D9F(param_00)
{
	if(self.var_3135.var_5661 == 6)
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 48
isnondismemberedmeleevsplayer(param_00)
{
	if(!isdefined(self.var_B55B))
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_B55B.target))
	{
		return level.var_6AD5;
	}

	if(!isplayer(self.var_B55B.target))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_3135.var_5661) && self.var_3135.var_5661 == 6)
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 49
func_12F13(param_00)
{
	var_01 = gettime();
	if(isdefined(self.var_3135.var_F1F9) && var_01 < self.var_3135.var_F1F9)
	{
		return level.var_E87A;
	}

	if(isdefined(self.var_3135.var_F1F8) && self.var_3135.var_F1F8 == 2)
	{
		return level.var_E87A;
	}

	if(isalive(self.var_10C))
	{
		var_02 = self.var_10C;
	}
	else
	{
		if(self.team == "axis")
		{
			var_03 = "allies";
		}
		else
		{
			var_03 = "axis";
		}

		var_04 = function_0072(var_03);
		if(var_03 == "allies")
		{
			var_04[var_04.size] = level.player;
		}

		var_05 = [];
		foreach(var_07 in var_04)
		{
			if(!isalive(var_07))
			{
				continue;
			}

			if(isdefined(var_07.var_1491) && isdefined(var_07.var_1491.var_58DA))
			{
				continue;
			}

			if(var_07.ignoreme)
			{
				continue;
			}

			var_05[var_05.size] = var_07;
		}

		var_05 = sortbydistance(var_05,self.origin);
		var_02 = var_05[0];
	}

	if(isdefined(var_02))
	{
		self.var_3135.var_F1F9 = var_01 + 3000;
		self.var_15C = 80;
		self.var_3135.var_F1EE = var_02;
		self method_8482(var_02);
		thread func_F1F8();
	}

	return level.var_E87A;
}

//Function Number: 50
func_F1F8()
{
	self endon("death");
	if(isdefined(self.var_3135.var_F1F8))
	{
		return;
	}

	self setscriptablepartstate("torso_overload_fx","overload");
	self.var_3135.var_F1F8 = 1;
	if(isdefined(self.var_3135.var_F1EE))
	{
		var_00 = 1;
		var_01 = 180;
		var_02 = distance(self.origin,self.var_3135.var_F1EE.origin);
		var_03 = var_02 / var_01 + var_00;
		thread func_F1F5(var_03);
		wait(0.5);
		var_04 = squared(96);
		var_05 = gettime() + var_03 * 1000;
		for(;;)
		{
			wait(0.05);
			if(!isalive(self.var_3135.var_F1EE))
			{
				break;
			}

			if(distancesquared(self.origin,self.var_3135.var_F1EE.origin) <= var_04)
			{
				break;
			}

			if(gettime() >= var_05)
			{
				break;
			}
		}
	}

	if(isdefined(self.var_3135.var_F1F7))
	{
		self.var_3135.var_F1F7 stoploopsound();
	}

	if(self.var_12BA4 == "c8")
	{
		self playsound("c8_destruct_preexplode","pre_explode_sound");
	}
	else
	{
		self playsound("c6_destruct_preexplode","pre_explode_sound");
	}

	self.var_6D = 16;
	self method_8481(self.origin);
	lib_0A1B::func_2972();
	wait(0.5);
	anim thread [[ self.var_3135.var_71CC ]](self);
}

//Function Number: 51
func_F1F5(param_00)
{
	if(isdefined(self.var_3135.var_F1F7))
	{
		return;
	}

	if(isdefined(self.var_3135.var_4889))
	{
		self stoploopsound();
	}

	self.var_3135.var_F1F7 = spawn("script_origin",self.origin + (0,0,30));
	self.var_3135.var_F1F7 linkto(self);
	self.var_3135.var_F1F7 thread func_F1F6(self,param_00);
}

//Function Number: 52
func_F1F6(param_00,param_01)
{
	self endon("death");
	self endon("entitydeleted");
	var_02 = "c6";
	if(param_00.var_12BA4 == "c8")
	{
		var_02 = "c8";
	}

	self playsound(var_02 + "_destruct_initiate");
	var_03 = gettime() + 1000;
	while(gettime() < var_03)
	{
		if(!isalive(param_00))
		{
			self delete();
			return;
		}

		wait(0.05);
	}

	if(param_00 lib_0A1B::func_293A())
	{
		self playloopsound(var_02 + "_destruct_crawl_loop");
	}
	else if(param_00.var_12BA4 == "c6" && param_00 lib_0A1B::func_293E() || isdefined(param_00.var_3135.var_12A74))
	{
		self playloopsound(var_02 + "_destruct_crawl_loop");
	}
	else
	{
		self playloopsound(var_02 + "_destruct_run_loop");
	}

	param_01 = max(param_01,5);
	self method_8277(2,param_01 - 1);
	if(isalive(param_00))
	{
		param_00 waittill("death");
	}

	self delete();
}

//Function Number: 53
func_F1F1(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00.var_3135.var_F1F4))
	{
		return;
	}

	var_04 = param_00.origin;
	param_00.var_3135.var_F1F4 = 1;
	param_00 scripts\anim\shared::func_5D1A();
	if(!isdefined(self.var_C05C))
	{
		wait(0.1);
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 250;
	}

	if(!isdefined(param_02))
	{
		param_02 = 170;
	}

	if(!isdefined(param_03))
	{
		param_03 = 20;
	}

	if(isdefined(param_00.var_3135.var_F200))
	{
		param_02 = param_02 * param_00.var_3135.var_F200;
		param_03 = param_03 * param_00.var_3135.var_F200;
	}

	if(!isdefined(param_00.var_2303.var_2F3B))
	{
		foreach(var_09, var_06 in param_00.var_4D5D)
		{
			if(var_09 == "head")
			{
				var_07 = "destruct";
			}
			else
			{
				var_08 = param_00 lib_0A0B::func_7C35(var_09);
				if(var_08 == "dismember")
				{
					continue;
				}

				if(issubstr(var_08,"_both"))
				{
					var_08 = "dmg_both";
				}

				var_07 = "destruct_" + var_08;
			}

			param_00 setscriptablepartstate(var_09,var_07);
		}
	}

	radiusdamage(var_04 + (0,0,32),param_01,param_02,param_03,param_00);
	physicsexplosionsphere(var_04,400,50,1);
	earthquake(2,0.3,var_04,400);
	if(isdefined(param_00.var_4E46))
	{
		param_00 [[ param_00.var_4E46 ]]();
	}

	param_00 thread func_F1ED();
	var_0A = spawn("script_origin",var_04);
	var_0A playsound("c6_destruct","sounddone");
	var_0A playsound("generic_explodeath_c6_1");
	var_0A waittill("sounddone");
	var_0A delete();
}

//Function Number: 54
func_F1ED()
{
	if(!isdefined(self))
	{
		return;
	}

	wait(0.05);
	self delete();
}

//Function Number: 55
func_12A76(param_00)
{
	if(isdefined(self.var_3135.var_F1F4))
	{
		return level.var_111AE;
	}

	thread func_5671();
	if(!isdefined(self.var_3135.var_12A74))
	{
		self.var_3135.var_12A74 = 1;
	}

	if(isdefined(self.var_3135.var_3126))
	{
		var_01 = 1;
	}
	else if(isdefined(self.var_3135.var_3128))
	{
		var_01 = 0;
	}
	else
	{
		var_01 = randomint(100) > 75;
	}

	if(var_01)
	{
		func_E1B1(randomintrange(3000,7000));
	}
	else
	{
		func_E1B2(randomintrange(10000,15000));
	}

	return level.var_111AE;
}

//Function Number: 56
func_12A75(param_00)
{
	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	var_01 = distance2dsquared(self.origin,self.var_10C.origin);
	if(var_01 > 1296)
	{
		return level.var_6AD5;
	}

	func_41DA();
	func_E1B1(randomintrange(2000,3000));
	self.var_3135.var_5661 = 0;
	return level.var_111AE;
}

//Function Number: 57
func_F20D(param_00,param_01)
{
	var_02 = gettime();
	if(!isdefined(self.var_3135.var_F20D))
	{
		var_03 = randomintrange(param_00,param_01);
		self.var_3135.var_F20D = var_02 + var_03;
	}
	else if(var_02 >= self.var_3135.var_F20D)
	{
		self method_81D0();
		return 1;
	}

	return 0;
}

//Function Number: 58
func_5671()
{
	self endon("death");
	if(isdefined(self.var_3135.var_5672))
	{
		return;
	}

	self.var_3135.var_5672 = 1;
	wait(randomfloatrange(1,3));
	var_00 = "right_leg";
	if(lib_0A0B::func_7C35(var_00) == "dismember")
	{
		var_00 = "left_leg";
		if(lib_0A0B::func_7C35(var_00) == "dismember")
		{
			return;
		}
	}

	self method_847D(var_00);
}

//Function Number: 59
func_9E7B(param_00)
{
	if(lib_0A0B::func_2040())
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 60
func_9EA3(param_00)
{
	if(lib_0A0B::func_2EE1())
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 61
func_3EDD()
{
	if(isdefined(self.var_3135.var_5661))
	{
		switch(self.var_3135.var_5661)
		{
			case 2:
			case 1:
			case 0:
				break;
		}
	}

	if(!isdefined(self.var_3135.var_8C94))
	{
		if(isdefined(self.var_DE) && self.var_DE == "MOD_MELEE")
		{
			self.var_3135.var_8C94 = "selfdestruct";
			self.var_3135.var_5661 = 0;
		}
		else
		{
			var_00[0] = "selfdestruct";
			var_01[0] = 1;
			var_00[1] = "selfdestruct_running";
			var_01[1] = 3;
			if(!lib_0A0B::func_E52D())
			{
				var_00[2] = "shootrandomly";
				var_01[2] = 3;
			}

			if(isdefined(level.var_A998))
			{
				foreach(var_04, var_03 in var_00)
				{
					if(var_03 == level.var_A998)
					{
						var_01[var_04] = var_01[var_04] - randomfloatrange(1,5);
						var_01[var_04] = max(var_01[var_04],0.2);
						break;
					}
				}
			}

			var_05 = func_7D77(var_01);
			self.var_3135.var_8C94 = var_00[var_05];
			switch(var_05)
			{
				case 0:
					self.var_3135.var_5661 = 0;
					break;

				case 1:
					self.var_3135.var_5661 = 1;
					break;

				case 2:
					self.var_3135.var_5661 = 4;
					break;
			}
		}

		anim.var_A998 = self.var_3135.var_8C94;
		lib_0A1B::func_297B("haywire");
		if(self.var_3135.var_8C94 == "selfdestruct_running")
		{
			lib_0A1B::func_297B("haywire_walk");
		}
	}
}

//Function Number: 62
func_7D77(param_00)
{
	var_01 = param_00.size;
	if(var_01 == 1)
	{
		return param_00[0];
	}

	var_02 = randomint(var_01);
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	for(var_06 = 0;var_06 < var_01;var_06++)
	{
		var_04 = var_04 + param_00[var_06];
	}

	var_07 = randomfloat(var_04);
	for(var_06 = 0;var_06 < var_01;var_06++)
	{
		var_05 = var_05 + param_00[var_06];
		if(var_07 >= var_05)
		{
			continue;
		}

		var_02 = var_06;
		break;
	}

	return var_02;
}

//Function Number: 63
func_F1F9(param_00,param_01)
{
	if(isdefined(self.var_3135.var_F1F4))
	{
		return 1;
	}

	var_02 = gettime();
	if(!isdefined(self.var_3135.var_F1F9))
	{
		var_03 = randomintrange(param_00,param_01);
		self.var_3135.var_F1F9 = var_02 + var_03;
		thread func_F1F5(var_03 * 0.001);
	}
	else if(var_02 >= self.var_3135.var_F1F9)
	{
		self.var_6D = 64;
		self method_8481(self.origin);
		anim thread [[ self.var_3135.var_71CC ]](self);
		return 1;
	}

	return 0;
}

//Function Number: 64
func_8C93()
{
	self.var_33F = 500;
	self method_834E("team3");
	self.var_15C = 500;
	function_01D1("allies","team3",-2000);
	function_01D1("axis","team3",1000);
	self endon("death");
	wait(2);
	self.ignoreme = 0;
}

//Function Number: 65
func_DCAA(param_00,param_01)
{
	if(!isdefined(self.var_3135.var_DCAB))
	{
		self.var_3135.var_DCAB = gettime() + randomintrange(param_00,param_01);
		return;
	}

	if(gettime() < self.var_3135.var_DCAB)
	{
		return;
	}

	self.var_3135.var_DCAB = gettime() + randomintrange(param_00,param_01);
	var_02 = ["left_arm","right_arm","left_leg","right_leg","torso"];
	var_03 = var_02[randomint(var_02.size)];
	var_04 = ["upper","lower"];
	var_05 = var_04[randomint(var_04.size)];
	self method_850B(30,var_03,var_05);
}

//Function Number: 66
func_4D64(param_00,param_01)
{
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = 0.2;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0.5;
	}

	var_02 = ["left_arm","right_arm","left_leg","right_leg","torso"];
	var_02 = scripts\common\utility::array_randomize(var_02);
	var_03 = randomintrange(3,5);
	var_04 = 0;
	while(var_04 < var_02.size - 1)
	{
		var_05 = lib_0A0B::func_7C35(var_02[var_04]);
		var_04++;
		if(var_05 == "dismember")
		{
			continue;
		}

		var_06 = undefined;
		if(var_05 == "normal")
		{
			if(scripts\common\utility::func_4347())
			{
				var_06 = "upper";
			}
			else
			{
				var_06 = "lower";
			}
		}
		else if(var_05 == "dmg_lower")
		{
			var_06 = "upper";
		}
		else if(var_05 == "dmg_upper")
		{
			var_06 = "upper";
		}

		wait(randomfloatrange(param_00,param_01));
		if(isdefined(var_06))
		{
			self method_850B(50,var_02[var_04],var_06);
		}
	}
}