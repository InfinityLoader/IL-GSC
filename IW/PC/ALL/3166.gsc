/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3166.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 9 ms
 * Timestamp: 10/27/2023 12:26:22 AM
*******************************************************************/

//Function Number: 1
func_FFD9()
{
	return lib_0A1B::func_292B() == "exposed" && isdefined(self.var_10C) && isdefined(self.var_205);
}

//Function Number: 2
func_FFDA(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_3135.var_C2) && isdefined(self.var_280A))
	{
		return lib_0A1B::func_2959();
	}

	return 0;
}

//Function Number: 3
func_CF00(param_00,param_01,param_02,param_03)
{
	if(param_03 == "alignToNode")
	{
		if(isdefined(param_01))
		{
			if(scripts\common\utility::func_167E())
			{
				var_04 = getangledelta3d(param_02);
				var_05 = scripts\asm\shared_utility::func_7FF6(param_01,0);
				var_06 = combineangles(var_05,-1 * var_04);
				self method_8221("face angle 3d",var_06);
				return;
			}

			var_04 = getangledelta3d(var_05);
			var_05 = (0,scripts\asm\shared_utility::func_7FF7(param_03),0);
			var_06 = var_06 - var_05;
			self method_8221("face angle",var_06[1]);
			return;
		}

		return;
	}

	if(var_06 == "stickToNode")
	{
		var_07 = getmovedelta(var_05);
		if(distancesquared(var_04.origin,self.origin) < 16)
		{
			self method_8272(var_04.origin);
			return;
		}

		thread func_ABB7(var_04,4,param_03 + "_finished");
		return;
	}
}

//Function Number: 4
func_3F06(param_00,param_01,param_02)
{
	var_03 = lib_0A1A::func_2358(param_01,"2");
	var_04 = getangledelta(var_03,0,1);
	var_05 = angleclamp180(180 - var_04);
	if(isdefined(self.var_233) && self.var_12A)
	{
		var_06 = vectortoangles(self.var_1BE);
		var_07 = var_06[1] - self.angles[1];
		var_08 = angleclamp180(var_07 + var_05);
	}
	else
	{
		var_09 = self.var_10C;
		var_07 = scripts\common\utility::func_8094(0.25,var_09,undefined);
		var_08 = angleclamp180(var_07 + var_05);
	}

	var_0A = spawnstruct();
	if(abs(var_08) > 135)
	{
		var_0A.var_1299D = lib_0A1A::func_2358(param_01,"2");
	}
	else if(var_08 < 0)
	{
		var_0A.var_1299D = lib_0A1A::func_2358(param_01,"6");
	}
	else
	{
		var_0A.var_1299D = lib_0A1A::func_2358(param_01,"4");
	}

	var_0A.var_D81F = var_07;
	return var_0A;
}

//Function Number: 5
func_D559(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	var_05 = 1;
	if((lib_0A1B::func_2950(param_00,param_01,param_02,param_03) || lib_0A1B::func_2953(param_00,param_01,param_02,param_03)) && isdefined(self.var_B55B.target) && isplayer(self.var_B55B.target))
	{
		var_05 = 2;
	}

	self method_82E7(param_01,var_04.var_1299D,1,param_02,var_05);
	lib_0A1E::func_2369(param_00,param_01,var_04.var_1299D);
	thread func_D55A(param_01,var_04.var_1299D,var_04.var_D81F,param_02);
	var_06 = lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
	if(var_06 == "end")
	{
		thread lib_0A1A::func_2310(param_00,param_01,0);
	}
}

//Function Number: 6
func_D55A(param_00,param_01,param_02,param_03)
{
	self endon(param_00 + "_finished");
	self endon("death");
	self endon("entitydeleted");
	var_04 = getangledelta(param_01,0,1);
	var_05 = angleclamp180(self.angles[1] + var_04);
	var_06 = angleclamp180(self.angles[1] + param_02);
	var_07 = angleclamp180(var_06 - var_05);
	var_08 = getanimlength(param_01);
	var_09 = int(var_08 - param_03 * 20);
	var_0A = var_07 / var_09;
	var_0B = 0;
	while(var_0B < var_09)
	{
		self method_80F1(self.origin,self.angles + (0,var_0A,0));
		var_0B++;
		wait(0.05);
	}
}

//Function Number: 7
func_D558(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_2303[param_00].var_10E2F[param_01].var_71A5;
	var_05 = self [[ var_04 ]](param_00,param_01,param_03);
	var_06 = lib_0A1B::func_2920();
	if(!isdefined(var_06))
	{
		if(isdefined(self.var_205) && distancesquared(self.origin,self.var_205.origin) < 4096)
		{
			var_06 = self.var_205;
		}
	}

	var_07 = undefined;
	if(isdefined(var_06))
	{
		var_07 = func_8178(param_00,param_01,var_05,var_06);
	}

	if(isdefined(var_07))
	{
		self endon(param_01 + "_finished");
		self.var_4C7E = ::lib_0F3D::func_22EA;
		self.var_1491.var_22E5 = param_01;
		var_08 = var_07.var_130;
		var_09 = var_07.var_2C5;
		var_0A = angleclamp180(var_08 - var_07.var_3E);
		self.var_1A4 = 1;
		self method_8016("zonly_physics",0);
		self method_8221("face current");
		if(self.script == "init")
		{
			wait(0.05);
		}

		lib_0A1E::func_2369(param_00,param_01,var_07.var_2C9);
		self method_806F(lib_0A1E::func_2339(),param_02);
		self method_82E7(param_01,var_07.var_2C9,1,param_02,self.var_1FC6);
		lib_0F3D::func_444B(param_01);
		self method_8396(var_09,var_0A);
		lib_0A1E::func_231F(param_00,param_01);
		self.var_1491.var_BCC8 = "stop";
		return;
	}

	self.var_1A4 = 1;
	childthread scripts\asm\shared_utility::func_FB04(var_04,var_05);
	self method_8221("face current");
	self method_806F(lib_0A1E::func_2339(),var_05);
	self method_82E7(var_04,var_08,1,var_05,1);
	lib_0A1E::func_2369(param_03,var_04,var_0A);
	lib_0A1E::func_231F(param_03,var_04,lib_0A1A::func_2341(param_03,var_04));
}

//Function Number: 8
func_36D9(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 - param_03;
	var_05 = (0,var_04,0);
	var_06 = rotatevector(param_02,var_05);
	return param_00 - var_06;
}

//Function Number: 9
func_8178(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_04 = param_03.origin;
	var_05 = lib_0F3D::func_C057(param_03);
	var_06 = undefined;
	var_07 = undefined;
	if(var_05)
	{
		var_08 = undefined;
		if((scripts\common\utility::func_9EB4(param_03) && lib_0F3D::func_9D4C(param_00,param_01,undefined,"Cover Left Crouch")) || scripts\common\utility::func_9EB7(param_03) && lib_0F3D::func_9D4C(param_00,param_01,undefined,"Cover Right Crouch"))
		{
			var_08 = "crouch";
		}

		var_06 = scripts\asm\shared_utility::func_7FF7(param_03,var_08);
		var_07 = param_03.angles;
	}

	var_09 = spawnstruct();
	var_09.var_2C9 = param_02;
	var_09.var_3F = 3;
	var_09.var_1F3 = getmovedelta(var_09.var_2C9,0,1);
	var_09.var_3E = getangledelta(var_09.var_2C9,0,1);
	var_09.var_2C5 = func_36D9(var_04,var_06,var_09.var_1F3,var_09.var_3E);
	var_09.angles = var_07;
	var_09.var_130 = var_06;
	return var_09;
}

//Function Number: 10
func_9E30(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = param_00 method_8169();
	foreach(var_03 in var_01)
	{
		if(var_03 == "over")
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 11
func_3EC7(param_00,param_01,param_02)
{
	var_03 = param_02;
	if(func_9E30(self.var_205))
	{
		var_03 = var_03 + "_high";
	}

	var_04 = lib_0A1E::func_2356(param_01,var_03);
	if(isarray(var_04))
	{
		return var_04[randomint(var_04.size)];
	}

	return var_04;
}

//Function Number: 12
func_CEFC(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_1A4 = 1;
	childthread scripts\asm\shared_utility::func_FB04(param_01,param_02);
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self method_8221("face current");
	var_05 = lib_0A1B::func_2920();
	if(isdefined(param_03))
	{
		if(isarray(param_03))
		{
			foreach(var_07 in param_03)
			{
				func_CF00(param_01,var_05,var_04,var_07);
			}
		}
		else
		{
			func_CF00(param_01,var_05,var_04,param_03);
		}
	}

	if(lib_0A1A::func_2384(param_00,param_01,"notetrackAim"))
	{
		var_09 = getangledelta(var_04,0,1);
		self.var_10F8C = self.angles[1] + var_09;
	}

	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82E7(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
	self method_8221("face current");
}

//Function Number: 13
func_D46B(param_00,param_01,param_02,param_03)
{
	func_CF02(param_00,param_01,param_02,param_03);
}

//Function Number: 14
func_12675(param_00)
{
	var_01 = self.var_164D[param_00];
	if(isdefined(var_01.var_10E23))
	{
		if(var_01.var_10E23 == "stand_run_loop")
		{
			return 1;
		}
		else if(scripts\common\utility::func_167E() && var_01.var_10E23 == "stand_run_strafe_loop")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 15
func_CF01(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_2303.var_A961))
	{
		var_04 = [lib_0A1B::func_2920(),self.var_205];
		for(var_05 = 0;!isdefined(self.var_2303.var_A961) && var_05 < var_04.size;var_05++)
		{
			if(isdefined(var_04[var_05]) && distancesquared(self.origin,var_04[var_05].origin) < 256)
			{
				self.var_2303.var_A961 = var_04[var_05];
			}
		}
	}

	func_CF02(param_00,param_01,param_02,param_03);
}

//Function Number: 16
func_CF02(param_00,param_01,param_02,param_03)
{
	self.var_1A4 = 1;
	if(isdefined(param_03))
	{
		if(param_03 == "stickToNode")
		{
			var_04 = lib_0A1B::func_2920();
			if(isdefined(var_04))
			{
				if(distancesquared(var_04.origin,self.origin) < 16)
				{
					self method_8272(var_04.origin);
				}
				else
				{
					thread func_ABB7(var_04,4,param_01 + "_finished");
				}
			}

			self.var_1A4 = 0;
			if(func_12675(param_00))
			{
				childthread scripts\asm\shared_utility::func_FB04(param_01,param_02);
			}
		}
	}

	var_05 = archetypegetalias(self.var_2303.var_2123,param_01,"conceal_add",0);
	var_04 = lib_0A1B::func_2920();
	if(isdefined(var_05) && isdefined(var_04) && var_04.type == "Conceal Crouch" || var_04.type == "Conceal Stand")
	{
		self method_82A2(var_05.var_47,1,0.2,1,1);
		thread func_4497(param_01);
	}

	lib_0F3D::func_B050(param_00,param_01,param_02,param_03);
}

//Function Number: 17
func_4497(param_00)
{
	self endon("death");
	self endon("entitydeleted");
	self waittill(param_00 + "_finished");
	var_01 = archetypegetalias(self.var_2303.var_2123,"Knobs","conceal_add",0);
	self method_806F(var_01.var_47,0.2);
}

//Function Number: 18
func_ABB7(param_00,param_01,param_02)
{
	self endon(param_02);
	for(;;)
	{
		var_03 = param_00.origin - self.origin;
		var_04 = length(var_03);
		if(var_04 < param_01)
		{
			self method_8272(param_00.origin);
			break;
		}

		var_03 = var_03 / var_04;
		var_05 = self.origin + var_03 * param_01;
		self method_8272(var_05);
		wait(0.05);
	}
}

//Function Number: 19
func_CEC2(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	var_05 = getanimlength(var_04);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82E7(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	childthread scripts\asm\shared_utility::func_FB04(param_01,param_02);
	var_06 = lib_0A1E::func_2323(param_00,param_01,var_05,lib_0A1A::func_2341(param_00,param_01));
	if(isdefined(var_06) && var_06 == "end")
	{
		thread lib_0A1A::func_2310(param_00,param_01,0);
	}

	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 20
func_41A2(param_00,param_01,param_02)
{
	self.var_1A4 = 0;
	self.var_10F8C = undefined;
	if(isdefined(param_02))
	{
		if(isarray(param_02))
		{
			foreach(var_04 in param_02)
			{
				lib_0A1A::func_232F(var_04,"end");
			}

			return;
		}

		lib_0A1A::func_232F(param_02,"end");
	}
}

//Function Number: 21
func_116F2(param_00,param_01,param_02)
{
	lib_0A1A::func_232F("reload","end");
	lib_0C68::func_DF4F(param_00,param_01,param_02);
}

//Function Number: 22
func_CEFD(param_00,param_01,param_02,param_03)
{
	self.var_1A4 = 1;
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self method_8221("face current");
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82E7(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
}

//Function Number: 23
func_D51A(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_04["crouch_shuffle_right"] = -90;
	var_04["crouch_shuffle_left"] = 90;
	var_04["stand_shuffle_right"] = -90;
	var_04["stand_shuffle_left"] = 90;
	self endon(param_01 + "_finished");
	var_05 = lib_0A1E::func_2336(param_00,param_01);
	var_06 = lib_0A1E::func_2339();
	self method_806F(var_06,param_02);
	self method_82EA(param_01,var_05,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_05);
	if(isdefined(self.var_1198.var_10171))
	{
		var_07 = self.var_1198.var_10171.angles[1];
	}
	else if(isdefined(self.var_205))
	{
		var_07 = self.var_205.angles[1];
	}
	else
	{
		var_07 = self.angles[1];
	}

	if(self.var_12BA4 != "c6" && isdefined(var_04[param_01]))
	{
		var_07 = var_07 + var_04[param_01];
	}

	self method_8221("face angle",var_07);
	lib_0A1E::func_231F(param_00,param_01);
}

//Function Number: 24
func_10054(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1E::func_235D(param_02);
	var_05 = lib_0A1A::func_2358(param_02,var_04);
	var_06 = getmovedelta(var_05);
	var_07 = lengthsquared(var_06);
	var_08 = distancesquared(self.origin,self.var_1198.var_10171.origin);
	return var_07 <= var_08 + 1;
}

//Function Number: 25
func_FFB5(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_1198.var_10171))
	{
		return 1;
	}

	if(!isdefined(self.var_205))
	{
		return 1;
	}

	if(self.var_1198.var_10171 != self.var_205)
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
func_FFCA(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03) && self.var_1198.var_10171.type != param_03)
	{
		return 0;
	}

	var_04 = lib_0A1E::func_235D(param_02);
	var_05 = lib_0A1A::func_2358(param_02,var_04);
	var_06 = self.var_1198.var_10171.origin - self.origin;
	var_07 = vectornormalize(var_06);
	var_08 = getmovedelta(var_05,0,1);
	var_09 = length(var_08);
	var_0A = self.var_1198.var_10171.origin - var_07 * var_09;
	var_06 = var_0A - self.origin;
	var_0B = self.var_1198.var_10171.origin - self.var_1198.var_1016B.origin;
	var_0B = (var_0B[0],var_0B[1],0);
	if(vectordot(var_0B,var_06) < 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
func_D518(param_00,param_01,param_02,param_03)
{
	self.var_4C7E = ::lib_0F3D::func_22EA;
	self.var_1491.var_22E5 = param_01;
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	var_05 = getmovedelta(var_04);
	var_06 = getangledelta3d(var_04);
	if(isdefined(self.var_1198.var_10171))
	{
		var_07 = self.var_1198.var_10171;
	}
	else
	{
		var_07 = self.var_205;
	}

	if(isdefined(var_07))
	{
		var_08 = (0,scripts\asm\shared_utility::func_7FF7(var_07),0);
		var_09 = combineangles(var_08,invertangles(var_06));
		var_0A = var_07.origin - rotatevector(var_05,var_09);
	}
	else
	{
		var_0A = self.origin;
		var_09 = self.angles;
	}

	self method_8396(var_0A,var_09[1]);
	lib_0A1E::func_231F(param_00,param_01);
}

//Function Number: 28
func_D519(param_00,param_01,param_02)
{
	self.var_1198.var_10171 = undefined;
	self.var_1198.var_1016B = undefined;
}

//Function Number: 29
func_4742(param_00,param_01,param_02,param_03)
{
	func_CEFC(param_00,param_01,param_02,param_03);
}

//Function Number: 30
func_4700(param_00,param_01,param_02,param_03)
{
	self.var_3135.var_C2.var_46FF = undefined;
	var_04 = self.var_10C.origin + scripts\anim\utility_common::func_7E8D() / 2;
	var_05 = level.var_2303[param_00].var_10E2F[param_02];
	var_06 = scripts\common\utility::array_randomize(var_05.var_1267B);
	var_07 = undefined;
	foreach(var_09 in var_06)
	{
		var_07 = var_09.var_100B1;
		if(var_07 == "up")
		{
			break;
		}

		var_0A = scripts\anim\utility_common::func_7E3F(self.var_205,var_07);
		var_0B = self.var_205.origin + var_0A;
		if(sighttracepassed(var_0B,var_04,0,undefined))
		{
			break;
		}
	}

	self.var_3135.var_C2.var_46FF = param_00 + "_" + param_02 + "_" + var_07;
	return 1;
}

//Function Number: 31
func_46FE(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 + "_" + param_01 + "_" + param_03;
	return var_04 == self.var_3135.var_C2.var_46FF;
}