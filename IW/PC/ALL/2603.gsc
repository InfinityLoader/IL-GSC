/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2603.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 16 ms
 * Timestamp: 10/27/2023 12:23:26 AM
*******************************************************************/

//Function Number: 1
func_11A90(param_00)
{
	func_F724();
	self.var_2303.var_11AC7 = param_00;
	var_01 = lib_0A1E::func_2356("Knobs","aim_2");
	var_02 = lib_0A1E::func_2356("Knobs","aim_4");
	var_03 = lib_0A1E::func_2356("Knobs","aim_6");
	var_04 = lib_0A1E::func_2356("Knobs","aim_8");
	func_11AF2(var_01,var_02,var_03,var_04);
	func_11AF8(param_00);
}

//Function Number: 2
func_11AF2(param_00,param_01,param_02,param_03)
{
	self.var_1491.var_1A4B = 1;
	self.var_1491.var_1A4D = 1;
	self.var_1491.var_1A4C = 1;
	self.var_1491.var_1A4F = 0;
	self.var_1491.var_1A4E = 0;
	var_04 = spawnstruct();
	var_04.var_1A1E = param_00;
	var_04.var_1A20 = param_01;
	var_04.var_1A23 = param_02;
	var_04.var_1A25 = param_03;
	self.var_2303.var_11A90 = var_04;
}

//Function Number: 3
func_103B3()
{
	self endon("stop_sniper");
	self waittill("death");
	if(isdefined(self.var_103A9))
	{
		self.var_103A9 delete();
		self.var_103A9 = undefined;
	}
}

//Function Number: 4
func_103BC()
{
	if(isdefined(self.var_103A9))
	{
		self notify("stop_sniper");
		self.var_103A9 [[ self.var_71BC ]]();
		self.var_103A9 delete();
		self.var_103A9 = undefined;
		self.bhaslasertag = undefined;
		self method_857A("none");
	}
}

//Function Number: 5
shoulduselasertag()
{
	var_00 = getweaponbasename(self.var_394);
	switch(var_00)
	{
		case "iw7_m8":
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 6
getlaserstartpoint()
{
	if(!isdefined(self.bhaslasertag))
	{
		if(shoulduselasertag())
		{
			var_00 = self gettagorigin("tag_laser",1);
			if(isdefined(var_00))
			{
				self.bhaslasertag = 1;
				return var_00;
			}
		}

		self.bhaslasertag = 0;
	}
	else if(scripts\common\utility::istrue(self.bhaslasertag))
	{
		if(!shoulduselasertag())
		{
			self.bhaslasertag = 0;
		}
	}

	if(self.bhaslasertag)
	{
		return self gettagorigin("tag_laser");
	}

	return self method_8142();
}

//Function Number: 7
getlaserdirection()
{
	return self method_853C();
}

//Function Number: 8
getlaserangles()
{
	return self method_8141();
}

//Function Number: 9
func_103BB()
{
	if(isdefined(self.var_103A9))
	{
		return;
	}

	thread func_103B3();
	var_00 = getlaserstartpoint();
	self.var_103A9 = spawn("script_model",var_00);
	self.var_103A9 setmodel("tag_laser");
	self.var_103A9 method_8575(self.var_394);
	self.var_103A9 method_831F(self);
	self.var_103A9.origin = var_00;
	self method_857A("interpolate");
	self.var_103A9 [[ self.var_71BD ]]();
	while(isalive(self) && isdefined(self.var_103A9))
	{
		if(isdefined(self.var_45E2.var_1A2B))
		{
			var_00 = getlaserstartpoint();
			self.var_103A9.origin = var_00;
			var_01 = self.var_45E2.var_1A2B;
			var_02 = vectornormalize(var_01 - var_00);
			var_03 = getlaserdirection();
			var_02 = vectornormalize((var_02[0],var_02[1],0));
			var_03 = vectornormalize((var_03[0],var_03[1],0));
			var_04 = vectordot(var_02,var_03);
			if(var_04 < 0.996)
			{
				self.var_103A9.angles = getlaserangles();
			}
			else
			{
				self.var_103A9.angles = vectortoangles(self.var_45E2.var_1A2B - self.var_103A9.origin);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 10
func_11B0B()
{
	func_103BC();
}

//Function Number: 11
func_11B0C()
{
	if(!isdefined(self.var_103A9))
	{
		thread func_103BB();
	}
}

//Function Number: 12
func_41A1()
{
	self.var_45E2 = undefined;
}

//Function Number: 13
func_E24D(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_45E2))
	{
		self.var_45E2 = spawnstruct();
	}

	self.var_45E2.var_103A6 = undefined;
	self.var_45E2.target = param_00.target;
	self.var_45E2.var_45DC = 96;
	if(param_01)
	{
		self.var_45E2.var_45E1 = 1500;
	}
	else if(scripts\common\utility::istrue(param_03))
	{
		self.var_45E2.var_45E1 = 1500;
	}
	else
	{
		self.var_45E2.var_45E1 = 2000;
	}

	self method_857A("interpolate");
	var_04 = scripts\sp\_gameskill::func_7C6D(level.var_7683);
	var_05 = level.var_54D0["sniper_converge_scale"][var_04];
	if(isdefined(var_05))
	{
		self.var_45E2.var_45E1 = self.var_45E2.var_45E1 * var_05;
	}

	if(isdefined(level.var_103A4))
	{
		self.var_45E2.var_45E1 = self.var_45E2.var_45E1 * level.var_103A4;
	}

	self.var_45E2.var_45DB = 12;
	self.var_45E2.var_AED8 = 750;
	self.var_45E2.var_45DA = undefined;
	if(!isdefined(self.var_103A9))
	{
		self.var_45E2.var_45D8 = -1500;
	}
	else
	{
		self.var_45E2.var_45D8 = 0;
	}

	self.var_45E2.var_45E0 = self.var_45E2.var_45E1 + 1000;
	self.var_45E2.var_45D9 = self.var_45E2.var_45E0 + 500;
	if(isdefined(param_00.var_D699))
	{
		var_06 = undefined;
		var_07 = undefined;
		if(isdefined(param_02))
		{
			var_06 = param_02;
		}
		else
		{
			if(isdefined(param_00.target))
			{
				var_08 = param_00.target.origin;
				if(isplayer(param_00.target))
				{
					var_07 = param_00.target getvelocity();
					if(var_07 == (0,0,0))
					{
						var_07 = undefined;
					}
				}
			}
			else
			{
				var_08 = param_01.var_D699 - (0,0,70);
			}

			var_09 = var_08 - self.origin;
			var_09 = (var_09[0],var_09[1],0);
			var_0A = vectornormalize(var_09);
			if(scripts\common\utility::istrue(param_03))
			{
				var_06 = var_08;
				var_06 = var_06 + (0,0,randomfloatrange(12,36));
			}
			else
			{
				var_06 = var_08 - var_0A * randomfloatrange(120,180);
			}

			var_0B = vectorcross(var_0A,(0,0,1));
			var_0C = randomfloatrange(6,36);
			if(scripts\common\utility::istrue(param_03))
			{
				var_0C = randomfloatrange(12,24);
			}

			if(isdefined(var_07))
			{
				var_0D = vectordot(var_07,var_0B);
				if(var_0D < 0)
				{
					var_06 = var_06 + var_0B * var_0C;
				}
				else
				{
					var_06 = var_06 - var_0B * var_0C;
				}
			}
			else if(randomintrange(0,2))
			{
				var_06 = var_06 + var_0B * var_0C;
			}
			else
			{
				var_06 = var_06 - var_0B * var_0C;
			}
		}

		self.var_45E2.var_45DE = vectornormalize(var_06 - param_00.var_D699);
		self.var_45E2.var_45DC = distance(var_06,param_00.var_D699);
	}
}

//Function Number: 14
func_36DA(param_00)
{
	if(isdefined(self.var_45E2.var_45DA) && gettime() - self.var_45E2.var_45DA >= 100)
	{
		var_01 = gettime() - self.var_45E2.var_45DA;
		if(isdefined(param_00.target) && isplayer(param_00.target))
		{
			self method_857A("lock");
		}
		else
		{
			self method_857A("interpolate");
		}

		return param_00.var_D699 - (0,0,1.3);
	}

	var_02 = vectornormalize(var_01.var_D699 - self.origin);
	var_03 = vectortoangles(var_02);
	if(self.var_45E2.var_45D8 < 0)
	{
		self method_857A("interpolate");
		var_04 = var_01.var_D699 + self.var_45E2.var_45DE * self.var_45E2.var_45DC;
		return var_04;
	}

	var_05 = self.var_45E2.var_45E1 - self.var_45E2.var_45D8 / self.var_45E2.var_45E1;
	if(self.var_45E2.var_45D8 >= self.var_45E2.var_45E1)
	{
		var_05 = 0;
	}

	var_06 = var_05 * self.var_45E2.var_45DC - self.var_45E2.var_45DB + self.var_45E2.var_45DB;
	var_04 = var_02.var_D699 + self.var_45E2.var_45DE * var_06;
	if(isdefined(var_01.target) && isplayer(var_01.target))
	{
		self method_857A("interpolate");
	}

	return var_06;
}

//Function Number: 15
func_C59A()
{
	if(isdefined(self.var_45E2) && isdefined(self.var_103A9))
	{
		self.var_45E2.var_103A6 = 1;
	}
}

//Function Number: 16
func_C599()
{
	if(isdefined(self.var_103A9))
	{
		self.var_103A9 [[ self.var_71BC ]]();
		thread func_129A4(0.5);
	}
}

//Function Number: 17
func_129A4(param_00)
{
	self endon("death");
	wait(param_00);
	if(isdefined(self.var_103A9))
	{
		self.var_103A9 [[ self.var_71BD ]]();
	}
}

//Function Number: 18
func_45E5(param_00)
{
	var_01 = 1;
	var_02 = 0;
	if(isdefined(param_00.target))
	{
		var_01 = self method_805F(param_00.target);
		if(isdefined(self.var_45E2) && isdefined(self.var_45E2.target) && self.var_45E2.target != param_00.target)
		{
			var_02 = 1;
		}

		if(var_01)
		{
			param_00.var_D699 = param_00.target method_815B();
		}
	}

	if(!isdefined(self.var_45E2) || var_02)
	{
		func_E24D(param_00,var_02);
	}
	else if(var_01 && !scripts\common\utility::istrue(self.var_45E2.var_2AB7))
	{
		if(isdefined(self.var_45E2.var_1A2B) && distancesquared(self.var_45E2.var_1A2B,param_00.var_D699) < 3600)
		{
			func_E24D(param_00,var_02,undefined,1);
		}
		else
		{
			func_E24D(param_00,var_02);
		}
	}
	else if(scripts\common\utility::istrue(self.var_45E2.var_103A6))
	{
		self method_857A("interpolate");
		self.var_45E2.var_103A6 = undefined;
		if(isdefined(param_00.target) && isplayer(param_00.target) && self method_805F(param_00.target))
		{
			func_E24D(param_00,var_02,undefined,1);
		}
	}

	self.var_45E2.var_2AB7 = var_01;
	var_03 = 1;
	var_04 = getlaserstartpoint();
	var_05 = func_36DA(param_00);
	var_06 = vectornormalize(var_05 - var_04);
	var_07 = self method_853C();
	if(self.var_45E2.var_45D8 < 0)
	{
		if(!func_9D30())
		{
			return 0;
		}

		self.var_45E2.var_45D8 = self.var_45E2.var_45D8 + 50;
		var_08 = vectordot(var_06,var_07);
		if(var_08 < 0.984)
		{
			return 0;
		}

		var_06 = vectornormalize((var_06[0],var_06[1],0));
		var_07 = vectornormalize((var_07[0],var_07[1],0));
		var_09 = vectordot(var_06,var_07);
		if(var_09 < 0.996)
		{
			return 0;
		}

		self.var_45E2.var_45D8 = 0;
	}
	else
	{
		self.var_45E2.var_45D8 = self.var_45E2.var_45D8 + 50;
		var_08 = vectordot(var_08,var_09);
		if(var_09 < 0.984)
		{
			var_04 = 0;
		}

		var_07 = vectornormalize((var_07[0],var_07[1],0));
		var_08 = vectornormalize((var_08[0],var_08[1],0));
		var_09 = vectordot(var_07,var_08);
		if(var_09 < 0.996)
		{
			var_03 = 0;
		}
	}

	if(self.var_45E2.var_45D8 >= self.var_45E2.var_45E1)
	{
		if(isdefined(param_00.target))
		{
			if(!isdefined(self.var_45E2.var_45DA))
			{
				if(var_01)
				{
					self.var_45E2.var_45DA = gettime();
				}
			}
			else if(gettime() >= self.var_45E2.var_45DA + 200)
			{
				if(!var_01)
				{
					self.var_45E2.var_45DA = undefined;
				}
			}
		}
	}

	return var_03;
}

//Function Number: 19
func_811E(param_00)
{
	var_01 = spawnstruct();
	if(scripts\anim\utility::func_FFDB())
	{
		var_02 = func_11AFB(param_00);
		if(isdefined(var_02))
		{
			var_01.var_FECF = var_02;
			var_01.var_2AA9 = 1;
			return var_01;
		}
	}

	var_03 = undefined;
	if(isdefined(self.var_1198.var_FECD))
	{
		var_03 = self.var_1198.var_FECD;
	}
	else if(isdefined(self.var_2303.var_FECD))
	{
		var_03 = self.var_2303.var_FECD;
	}

	if(!lib_0A1B::func_2985())
	{
		return undefined;
	}
	else if(isdefined(var_03.var_65D3))
	{
		var_01.var_FECF = var_03.var_65D3 method_815B();
	}
	else if(isdefined(var_03.var_D699))
	{
		var_01.var_FECF = var_03.var_D699;
	}

	if(isdefined(var_01.var_FECF))
	{
		return var_01;
	}

	return undefined;
}

//Function Number: 20
func_9F60()
{
	if(!isdefined(self.var_45E2))
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
func_9F61()
{
	if(isdefined(self.var_103A9))
	{
		return 1;
	}

	return 0;
}

//Function Number: 22
func_9D30()
{
	if(!isdefined(self.var_2303.var_1A49))
	{
		return 0;
	}

	var_00 = 100;
	var_00 = var_00 * 2;
	var_01 = gettime();
	if(self.var_2303.var_1A49 + var_00 < var_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
func_11AF8(param_00)
{
	self endon("death");
	self.var_2303.var_D8C7 = 0;
	self.var_2303.var_D8BB = 0;
	var_01 = (0,0,0);
	var_02 = 1;
	var_03 = 0;
	var_04 = 0;
	var_05 = 10;
	for(;;)
	{
		func_93E2();
		var_06 = lib_0A1A::func_231B(self.var_2303.var_11AC7,"aim");
		if(!var_06 && lib_0A1A::func_231B(self.var_2303.var_11AC7,"notetrackAim"))
		{
			var_06 = lib_0A1A::func_232B(lib_0A1A::func_233A(self.var_2303.var_11AC7),"start_aim");
		}

		if(!var_06 || !isdefined(self.var_1198.var_FECD))
		{
			if(!var_06 && isdefined(self.var_45E2))
			{
				func_41A1();
			}

			func_11B0B();
			self.var_2303.var_1A49 = undefined;
		}
		else if(!isdefined(self.var_2303.var_1A49))
		{
			self.var_2303.var_1A49 = gettime();
		}

		var_01 = (0,0,0);
		if(var_06)
		{
			var_07 = scripts\anim\shared::func_811C();
			var_08 = func_811E(var_07);
			var_09 = undefined;
			if(isdefined(var_08))
			{
				var_09 = var_08.var_FECF;
			}

			var_0A = self method_8164();
			var_0B = isdefined(var_0A);
			if(var_0B)
			{
				var_0C = var_0A method_851F();
				var_0D = anglestoforward(self.angles);
				var_0E = rotatevector(var_0D,var_0C);
				var_09 = var_07 + var_0E * 512;
			}
			else if(lib_0A1B::func_2985() && isdefined(self.var_1198.var_FECD.var_D699))
			{
				if(isdefined(self.var_1198.var_FECD.var_29AF))
				{
					var_0F = func_45E5(self.var_1198.var_FECD);
					var_09 = func_36DA(self.var_1198.var_FECD);
					self.var_45E2.var_1A2B = var_09;
					if(var_0F)
					{
						func_11B0C();
					}
					else
					{
						func_11B0B();
					}
				}
				else
				{
					func_11B0B();
				}
			}
			else
			{
				func_11B0B();
			}

			var_10 = isdefined(var_09);
			var_11 = (0,0,0);
			if(var_10)
			{
				var_11 = var_09;
			}

			var_12 = 0;
			var_13 = isdefined(self.var_10F8C);
			if(var_13)
			{
				var_12 = self.var_10F8C;
			}

			var_14 = 0;
			var_15 = 0;
			var_16 = lib_0A1B::func_2920();
			if(isdefined(var_16) && lib_0A1B::func_292B() == "exposed")
			{
				var_17 = lib_0A1B::func_2929();
				if(isdefined(var_17))
				{
					var_14 = scripts\asm\shared_utility::func_7FF2(param_00,var_16,var_17);
					var_15 = scripts\asm\shared_utility::func_7FF1(param_00,var_16,var_17);
				}
			}

			var_18 = (var_15,var_14,0);
			if(scripts\common\utility::func_9DA3() || isdefined(var_08) && isdefined(var_08.var_2AA9) && var_08.var_2AA9)
			{
				var_01 = self method_80FA(var_07,var_11,var_10,var_18,var_12,var_13,0);
			}
			else
			{
				var_01 = (0,0,0);
			}
		}
		else if(self.var_2303.var_D8C7 < 5 && self.var_2303.var_D8BB < 5)
		{
			wait(0.05);
			continue;
		}

		var_19 = var_01[0];
		var_1A = var_01[1];
		var_01 = undefined;
		if(var_04 > 0)
		{
			var_04 = var_04 - 1;
			var_05 = max(10,var_05 - 5);
		}
		else if(self.var_25F && self.var_25F != var_03)
		{
			var_04 = 2;
			var_05 = 30;
		}
		else if(scripts\anim\utility_common::func_9D4D())
		{
			var_05 = 2;
		}
		else
		{
			var_05 = 10;
		}

		var_1B = 4;
		var_03 = self.var_25F;
		var_1C = self.var_1F5 != "stop" || !var_02;
		if(var_1C)
		{
			var_1D = var_1A - self.var_2303.var_D8C7;
			if(squared(var_1D) > var_1B)
			{
				var_1E = var_1D * 0.4;
				var_1A = self.var_2303.var_D8C7 + clamp(var_1E,-1 * var_05,var_05);
				var_1A = clamp(var_1A,self.var_268,self.var_1B7);
			}

			var_1F = var_19 - self.var_2303.var_D8BB;
			if(squared(var_1F) > var_1B)
			{
				var_20 = var_1F * 0.4;
				var_19 = self.var_2303.var_D8BB + clamp(var_20,-1 * var_05,var_05);
				var_19 = clamp(var_19,self.var_368,self.var_100);
			}
		}

		var_02 = 0;
		self.var_2303.var_D8C7 = var_1A;
		self.var_2303.var_D8BB = var_19;
		if(isdefined(self.var_2303.var_58EC) && self.var_2303.var_58EC)
		{
			func_11AFF(var_19,var_1A);
		}
		else
		{
			func_11AFE(var_19,var_1A);
		}

		wait(0.05);
	}
}

//Function Number: 24
func_11AFD()
{
	if(!isdefined(self.var_2303.var_D8C7))
	{
		return;
	}

	var_00 = clamp(self.var_2303.var_D8C7,self.var_268,self.var_1B7);
	var_01 = clamp(self.var_2303.var_D8BB,self.var_368,self.var_100);
	if(isdefined(self.var_2303.var_58EC) && self.var_2303.var_58EC)
	{
		func_11AFF(var_01,var_00);
		return;
	}

	func_11AFE(var_01,var_00);
}

//Function Number: 25
func_11AFB(param_00)
{
	var_01 = undefined;
	var_02 = anglestoforward(self.angles);
	if(isdefined(self.var_4792))
	{
		var_01 = self.var_4792 method_815B();
		if(isdefined(self.var_4796))
		{
			if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.177)
			{
				var_01 = undefined;
			}
		}
		else if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.643)
		{
			var_01 = undefined;
		}
	}

	if(!isdefined(var_01) && isdefined(self.var_478F))
	{
		var_01 = self.var_478F;
		if(isdefined(self.var_4795))
		{
			if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.177)
			{
				var_01 = undefined;
			}
		}
		else if(vectordot(vectornormalize(var_01 - param_00),var_02) < 0.643)
		{
			var_01 = undefined;
		}
	}

	return var_01;
}

//Function Number: 26
func_11AFE(param_00,param_01)
{
	var_02 = undefined;
	if(isdefined(self.var_2303.var_11A90.var_1A1D))
	{
		var_03 = self.var_2303.var_11A90.var_1A1D;
		var_04 = self.var_2303.var_11A90.var_1A1F;
		var_05 = self.var_2303.var_11A90.var_1A22;
		var_06 = self.var_2303.var_11A90.var_1A24;
	}
	else
	{
		var_03 = self.var_2303.var_11A90.var_1A1E;
		var_04 = self.var_2303.var_11A90.var_1A20;
		var_05 = self.var_2303.var_11A90.var_1A23;
		var_06 = self.var_2303.var_11A90.var_1A25;
	}

	if(isdefined(self.var_2303.var_11A90.var_1A21))
	{
		var_02 = self.var_2303.var_11A90.var_1A21;
	}

	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	var_0A = 0;
	var_0B = 0;
	if(param_01 < 0)
	{
		var_0A = param_01 / self.var_268 * self.var_1491.var_1A4B;
		var_09 = 1;
	}
	else if(param_01 > 0)
	{
		var_08 = param_01 / self.var_1B7 * self.var_1491.var_1A4B;
		var_09 = 1;
	}

	if(param_00 < 0)
	{
		var_0B = param_00 / self.var_368 * self.var_1491.var_1A4B;
		var_09 = 1;
	}
	else if(param_00 > 0)
	{
		var_07 = param_00 / self.var_100 * self.var_1491.var_1A4B;
		var_09 = 1;
	}

	self method_82AC(var_03,var_07,0.1,1,1);
	self method_82AC(var_04,var_08,0.1,1,1);
	self method_82AC(var_05,var_0A,0.1,1,1);
	self method_82AC(var_06,var_0B,0.1,1,1);
	if(isdefined(var_02))
	{
		self method_82AC(var_02,var_09,0.1,1,1);
	}
}

//Function Number: 27
func_11AFF(param_00,param_01)
{
	var_02 = self.var_2303.var_11A90.var_AD94;
	var_03 = self.var_2303.var_11A90.var_AD95;
	var_04 = self.var_2303.var_11A90.var_AD96;
	var_05 = self.var_2303.var_11A90.var_AD97;
	var_06 = self.var_2303.var_11A90.var_AD98;
	var_07 = self.var_2303.var_11A90.var_AD99;
	var_08 = self.var_2303.var_11A90.var_AD9A;
	var_09 = self.var_2303.var_11A90.var_AD9B;
	var_0A = [var_06,var_09,var_08,var_07,var_05,var_02,var_03,var_04,var_06];
	var_0B = [-180,-135,-90,-45,0,45,90,135,180];
	var_0C = [(-1,0,0),(-0.707,-0.707,0),(0,-1,0),(0.707,-0.707,0),(1,0,0),(0.707,0.707,0),(0,1,0),(-0.707,0.707,0),(-1,0,0)];
	var_0D = [80,91.787,45,91.787,80,91.787,45,91.787,80];
	var_0E = (param_01,param_00,0);
	var_0F = length2d(var_0E);
	var_10 = vectornormalize(var_0E);
	var_11 = vectortoyaw(var_10);
	var_11 = angleclamp180(var_11);
	for(var_12 = 0;var_11 > var_0B[var_12];var_12++)
	{
	}

	if(var_12 == 0)
	{
		var_12 = 1;
	}

	for(var_13 = 0;var_13 < var_0A.size;var_13++)
	{
		if(var_13 == var_12 || var_13 == var_12 - 1)
		{
			var_14 = clamp(var_0F / var_0D[var_13],0,1);
			var_15 = acos(vectordot(var_0C[var_13],var_10));
			var_16 = clamp(1 - var_15 / var_0D[var_13],0,1);
			var_17 = self method_8102(var_0A[var_13]);
			if(var_17 > 0)
			{
				var_18 = getanimlength(var_0A[var_13]);
				var_19 = var_14 - var_17 * var_18 / 0.05;
				self method_82AC(var_0A[var_13],var_16,0.05,var_19);
			}
			else
			{
				self method_82AC(var_0A[var_13],var_16,0.05,0);
				self method_82B0(var_0A[var_13],var_14);
			}

			continue;
		}

		if(var_0A[var_13] != var_0A[var_12] && var_0A[var_13] != var_0A[var_12 - 1])
		{
			self method_806F(var_0A[var_13],0.05);
		}
	}
}

//Function Number: 28
func_F641(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 <= 0)
	{
		self.var_1491.var_1A4B = param_00;
		self.var_1491.var_1A4D = param_00;
		self.var_1491.var_1A4C = param_00;
		self.var_1491.var_1A4F = 0;
	}
	else
	{
		if(!isdefined(self.var_1491.var_1A4B))
		{
			self.var_1491.var_1A4B = 0;
		}

		self.var_1491.var_1A4D = self.var_1491.var_1A4B;
		self.var_1491.var_1A4C = param_00;
		self.var_1491.var_1A4F = int(param_01 * 20);
	}

	self.var_1491.var_1A4E = 0;
}

//Function Number: 29
func_93E2()
{
	if(self.var_1491.var_1A4E < self.var_1491.var_1A4F)
	{
		self.var_1491.var_1A4E++;
		var_00 = 1 * self.var_1491.var_1A4E / self.var_1491.var_1A4F;
		self.var_1491.var_1A4B = self.var_1491.var_1A4D * 1 - var_00 + self.var_1491.var_1A4C * var_00;
	}
}

//Function Number: 30
func_1A3A()
{
	if(!isdefined(self.var_1198.var_FECD.var_D699) && !isdefined(self.var_1198.var_FECD.var_65D3))
	{
		return 1;
	}

	var_00 = self method_8164();
	if(isdefined(self.var_1198.var_FECD.var_29AF))
	{
		if(!isdefined(self.var_45E2))
		{
			return 0;
		}

		if(isdefined(self.var_45E2.var_45DA))
		{
			var_01 = gettime() - self.var_45E2.var_45DA;
			if(var_01 >= self.var_45E2.var_AED8)
			{
				return 1;
			}
		}
		else if(self.var_45E2.var_45D8 >= self.var_45E2.var_45E0)
		{
			return 1;
		}

		return 0;
	}

	if(lib_0A1B::func_293E())
	{
		return 1;
	}

	var_02 = scripts\anim\shared::func_811C();
	var_03 = func_811E(var_02);
	if(!isdefined(var_03))
	{
		return 0;
	}

	var_04 = var_03.var_FECF;
	if(scripts\common\utility::func_167E())
	{
		var_05 = self method_853C();
		var_06 = rotatevectorinverted(var_05,self.angles);
		var_07 = vectortoangles(var_06);
		var_08 = var_04 - var_02;
		var_09 = rotatevectorinverted(var_08,self.angles);
		var_0A = vectortoangles(var_09);
	}
	else if(isdefined(var_03))
	{
		var_0B = var_03 method_8166(1);
		return isdefined(var_0B);
	}
	else
	{
		var_07 = self method_8141();
		var_0A = vectortoangles(var_0A - var_04);
	}

	var_0C = level.var_1A52;
	var_0D = level.var_1A51;
	var_0E = level.var_1A44;
	var_0F = scripts\common\utility::func_152F(var_0A[1] - var_0B[1]);
	if(var_0F > var_0C)
	{
		if(var_0F > var_0D || distancesquared(self geteye(),var_07) > level.var_1A50)
		{
			return 0;
		}
	}

	var_10 = scripts\common\utility::func_152F(var_0A[0] - var_0B[0]);
	if(var_10 > var_0E)
	{
		return 0;
	}

	return 1;
}

//Function Number: 31
func_F724()
{
	anim.var_4717 = 55;
	anim.var_1A52 = 10;
	anim.var_1A50 = 4096;
	anim.var_1A51 = 45;
	anim.var_1A44 = 20;
	anim.var_C88B = 25;
	anim.var_C889 = level.var_1A50;
	anim.var_C88A = level.var_1A51;
	anim.var_C87D = 30;
	anim.var_B480 = 65;
	anim.var_B47F = 65;
}