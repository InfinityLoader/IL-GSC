/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3141.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 12:26:15 AM
*******************************************************************/

//Function Number: 1
func_BEA0(param_00,param_01,param_02,param_03)
{
	self.var_1198.var_5279 = undefined;
	var_04 = anglestoforward(self.angles);
	var_05 = 0;
	if(var_05)
	{
		if(isdefined(self.var_233))
		{
			if(distancesquared(self.var_233,self.origin) > 144)
			{
				var_06 = self.var_1BE;
				if(vectordot(var_06,var_04) <= 0.857)
				{
					self.var_1198.var_5279 = var_06;
					return 1;
				}
			}

			return 0;
		}
	}
	else if(isdefined(self.var_233))
	{
		return 0;
	}

	var_07 = func_7EAE();
	if(isdefined(var_07) && !isdefined(self.var_595F))
	{
		var_08 = vectornormalize(var_07 - self.origin);
		if(vectordot(var_04,var_08) <= 0.5)
		{
			self.var_1198.var_5279 = var_08;
			return 1;
		}
	}

	if(isdefined(self.var_28B))
	{
		var_09 = anglestoforward(self.var_28B.angles);
		if(vectordot(var_09,var_04) <= 0.857)
		{
			self.var_1198.var_5279 = var_09;
			return 1;
		}

		return 0;
	}

	if(isdefined(self.var_205))
	{
		var_09 = anglestoforward(self.var_205.angles);
		if(vectordot(var_09,var_04) <= 0.857)
		{
			self.var_1198.var_5279 = var_09;
			return 1;
		}

		return 0;
	}

	return 0;
}

//Function Number: 2
func_BEA1(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_233))
	{
		if(distancesquared(self.var_233,self.origin) > 144)
		{
			var_04 = self.var_1BE;
			var_04 = vectornormalize((var_04[0],var_04[1],0));
			var_05 = anglestoforward(self.angles);
			if(vectordot(var_04,var_05) <= 0.857)
			{
				self.var_1198.var_5279 = var_04;
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 3
func_35DE(param_00,param_01,param_02,param_03)
{
	self.var_1198.var_11936 = gettime();
	var_04 = self.var_164D[param_00];
	if(isdefined(var_04.var_10E23))
	{
		if(var_04.var_10E23 == "run" || var_04.var_10E23 == "walk" || var_04.var_10E23 == "walk_backward")
		{
			childthread scripts\asm\shared_utility::func_FB04(param_01,param_02);
		}
	}

	lib_0A1E::func_235F(param_00,param_01,param_02,1);
}

//Function Number: 4
func_35DF(param_00,param_01,param_02)
{
	self.var_1198.var_11936 = undefined;
}

//Function Number: 5
func_7EAE()
{
	if(!isdefined(self.var_1198.var_FECD))
	{
		return undefined;
	}

	var_00 = 0;
	var_01 = (0,0,0);
	foreach(var_03 in lib_0C08::func_357A())
	{
		var_04 = self.var_1198.var_FECD.var_13CC3[var_03];
		if(isdefined(var_04))
		{
			if(isdefined(var_04.var_EF76))
			{
				foreach(var_06 in var_04.var_EF76)
				{
					if(isdefined(var_06))
					{
						var_01 = var_01 + var_06.origin;
						var_00++;
					}
				}

				continue;
			}

			if(isdefined(var_04.var_65D3))
			{
				var_01 = var_01 + var_04.var_65D3.origin;
				var_00++;
				continue;
			}

			if(isdefined(var_04.var_D699))
			{
				var_01 = var_01 + var_04.var_D699;
				var_00++;
			}
		}
	}

	if(var_00 == 0)
	{
		return;
	}

	var_09 = var_01 / var_00;
	return var_09;
}

//Function Number: 6
func_B32D(param_00)
{
	var_01 = [2,3,6,9,8,7,4,1,2];
	return var_01[param_00];
}

//Function Number: 7
func_3EA7(param_00,param_01,param_02)
{
	var_03 = self.var_1198.var_5279;
	if(!isdefined(var_03))
	{
		return undefined;
	}

	var_04 = vectortoangles(var_03);
	var_05 = var_04[1];
	var_06 = self.angles[1];
	var_07 = angleclamp180(var_05 - var_06);
	var_08 = function_02F9(var_07,15);
	var_09 = func_B32D(var_08);
	if(var_09 == 8)
	{
		return undefined;
	}

	var_0A = "turn_" + var_09;
	if(var_09 == 2)
	{
		if(var_08 == 0)
		{
			var_0A = var_0A + "r";
		}
		else
		{
			var_0A = var_0A + "l";
		}
	}

	var_0B = lib_0A1E::func_2356(param_01,var_0A);
	return var_0B;
}

//Function Number: 8
func_CEC3(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	if(!isdefined(var_04))
	{
		lib_0A1A::func_2330(param_01,"end");
		return;
	}

	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_04,1,param_02,1);
	lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
}

//Function Number: 9
func_7DD5()
{
	if(isdefined(self.var_28B))
	{
		return self.var_28B.origin;
	}

	if(isdefined(self.var_205))
	{
		return self.var_205.origin;
	}

	return self.var_15B;
}

//Function Number: 10
func_7DD4()
{
	if(isdefined(self.var_28B))
	{
		return self.var_28B.angles;
	}

	if(isdefined(self.var_205))
	{
		return self.var_205.angles;
	}

	return self.angles;
}

//Function Number: 11
func_1008C(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_55B0) && self.var_55B0)
	{
		return 0;
	}

	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(!lib_0A1A::func_232B(param_01,"cover_approach"))
	{
		return 0;
	}

	var_04 = func_7DD5();
	if(!isdefined(var_04))
	{
		return 0;
	}

	var_05 = 128;
	var_06 = var_04 - self.origin;
	var_07 = length(var_06);
	if(var_07 > var_05)
	{
		return 0;
	}

	var_08 = 1;
	if(var_08)
	{
		var_09 = gettime() - self.var_2303.var_7257.time;
		if(var_09 < 250 || var_09 > 400)
		{
			return 0;
		}

		var_0A = self.var_15C;
		if(isdefined(self.var_205) || isdefined(self.var_28B))
		{
			var_0A = 0;
		}

		self.var_2303.var_11068 = func_3722(param_02,var_04,var_0A,0);
	}
	else
	{
		self.var_2303.var_11068 = lib_0C5D::func_3721(param_00,param_01,param_02,"Exposed",1);
	}

	if(!isdefined(self.var_2303.var_11068))
	{
		return 0;
	}

	return 1;
}

//Function Number: 12
func_3722(param_00,param_01,param_02,param_03)
{
	param_01 = func_7DD5();
	var_04 = func_7DD4();
	var_05 = param_01 - self.origin;
	if(param_03)
	{
		var_06 = 0;
	}
	else if(length2dsquared(var_06) < 144)
	{
		var_06 = 4;
	}
	else
	{
		var_07 = self.angles[1];
		var_08 = angleclamp180(var_04[1] - var_07);
		var_06 = function_02F9(var_08,22.5);
	}

	var_09 = lib_0C5D::func_8174(param_00,undefined,1);
	if(!isdefined(var_09[var_06]))
	{
		return undefined;
	}

	var_0A = getmovedelta(var_09[var_06]);
	var_0B = getangledelta3d(var_09[var_06]);
	var_0C = rotatevector(var_0A,self.angles);
	var_0D = var_0C + self.origin;
	var_0E = 0;
	var_0F = distancesquared(var_0D,param_01);
	if(var_0F > param_02 * param_02)
	{
		var_10 = distancesquared(var_0D + var_0C,param_01);
		if(var_10 < var_0F)
		{
			return undefined;
		}

		var_0E = 1;
	}

	var_11 = getclosestpointonnavmesh(var_0D,self);
	var_12 = self method_84AC();
	if(!navisstraightlinereachable(var_12,var_11,self))
	{
		return undefined;
	}

	if(var_0E)
	{
		var_0C = rotatevector(var_0A,var_04 - var_0B);
		var_13 = param_01 - var_0C;
	}
	else if(distance2dsquared(var_12,var_0E) > 4)
	{
		var_0D = rotatevector(var_0B,var_05 - var_0C);
		var_13 = var_12 - var_0D;
	}
	else
	{
		var_13 = self.origin;
	}

	var_14 = spawnstruct();
	var_14.var_2C9 = var_09[var_06];
	var_14.var_3F = var_06;
	var_14.var_2C5 = var_13;
	var_14.var_3E = var_0B[1];
	var_14.var_130 = var_04;
	var_14.var_1F3 = var_0A;
	return var_14;
}

//Function Number: 13
func_3E99(param_00,param_01,param_02)
{
	if(self.var_2303.var_7257.var_7254 == "right")
	{
		var_03 = "right";
	}
	else
	{
		var_03 = "left";
	}

	var_04 = var_03 + "2";
	var_05 = lib_0A1E::func_2356(param_01,var_04);
	return var_05;
}

//Function Number: 14
func_CEAD(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_4C7E = ::lib_0F3D::func_22EA;
	self.var_1491.var_22E5 = param_01;
	if(isdefined(self.var_2303.var_11068))
	{
		var_04 = self.var_2303.var_11068;
		var_05 = var_04.var_2C9;
		var_06 = var_04.var_130;
		var_07 = var_04.var_2C5;
		var_08 = var_04.var_3E;
	}
	else
	{
		var_05 = lib_0A1E::func_2336(var_05,var_06);
		var_09 = getmovedelta(var_08);
		var_08 = getangledelta(var_05);
		var_0A = func_7DD5();
		var_06 = self.angles;
		var_0B = rotatevector(var_09,var_06);
		var_07 = var_0A - var_0B;
	}

	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_05,1,param_02,1);
	var_0C = var_06[1] - var_08;
	if(isdefined(self.var_2303.var_11068))
	{
		self method_8396(var_07,var_0C);
	}
	else
	{
		self method_8221("face angle",self.angles[1]);
	}

	lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
	self.var_1491.var_BCC8 = "stop";
}

//Function Number: 15
func_1008B(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_55B0) && self.var_55B0)
	{
		return 0;
	}

	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(!lib_0A1A::func_232B(param_01,"cover_approach"))
	{
		return 0;
	}

	var_04 = func_7DD5();
	if(!isdefined(var_04))
	{
		return 0;
	}

	var_05 = 48;
	var_06 = 96;
	var_07 = var_04 - self.origin;
	var_08 = length(var_07);
	if(var_08 > var_06)
	{
		return 0;
	}

	var_09 = 1;
	if(var_09)
	{
		var_0A = gettime() - self.var_2303.var_7257.time;
		if(var_0A > 850 || var_0A < 700)
		{
			return 0;
		}

		var_0B = self.var_15C;
		if(isdefined(self.var_205) || isdefined(self.var_28B))
		{
			var_0B = 0;
		}

		self.var_2303.var_11068 = func_3722(param_02,var_04,var_0B,1);
	}
	else
	{
		if(var_0A < var_07)
		{
			return 0;
		}

		return 1;
	}

	if(!isdefined(self.var_2303.var_11068))
	{
		return 0;
	}

	return 1;
}

//Function Number: 16
func_3E98(param_00,param_01,param_02)
{
	if(self.var_2303.var_7257.var_7254 == "right")
	{
		var_03 = "right8";
	}
	else
	{
		var_03 = "left8";
	}

	var_04 = lib_0A1E::func_2356(param_01,var_03);
	return var_04;
}

//Function Number: 17
func_10047(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_55ED) && self.var_55ED)
	{
		return 0;
	}

	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(distancesquared(self.origin,self.var_233) < 10000)
	{
		return 0;
	}

	if(lengthsquared(self.var_381) > 1)
	{
		return 0;
	}

	if(self.var_36A)
	{
		return 0;
	}

	self.var_2303.var_10D84 = lib_0C65::func_53CA(param_02,undefined,1);
	return isdefined(self.var_2303.var_10D84);
}

//Function Number: 18
func_10048(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_55ED) && self.var_55ED)
	{
		return 0;
	}

	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(distancesquared(self.origin,self.var_233) < 10000)
	{
		return 0;
	}

	if(lengthsquared(self.var_381) > 1)
	{
		return 0;
	}

	if(self.var_36A)
	{
		return 0;
	}

	var_04 = lib_0A1A::func_233C();
	if(var_04 != "walk" && var_04 != "casual")
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
func_3524(param_00,param_01,param_02)
{
	var_03 = self.var_2303.var_10D84;
	self.var_2303.var_10D84 = undefined;
	return var_03;
}

//Function Number: 20
func_100BE(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_04 = scripts\common\utility::func_6EE6(self.var_1BE);
	var_05 = self.var_233 - self.origin;
	if(param_03 && lengthsquared(var_05) < 32400)
	{
		var_06 = anglestoforward(self.angles);
		if(vectordot(var_06,var_04) > 0)
		{
			return 0;
		}
	}

	var_07 = lib_0C08::func_7E30();
	if(isdefined(var_07))
	{
		var_08 = var_07.origin - self.origin;
		if(lengthsquared(var_08) > self.var_1D0 * self.var_1D0)
		{
			return 0;
		}

		var_09 = 6;
		if(self.var_1BF < var_09)
		{
			return 0;
		}

		var_08 = vectornormalize(var_08);
		if(vectordot(var_08,var_04) > -0.342)
		{
			return 0;
		}

		var_0A = var_07 getlinkedparent();
		if(isdefined(var_0A) && var_0A == self)
		{
			return 0;
		}

		if(isplayer(var_07) && isdefined(self.var_1198.var_E5FD) && self.var_1198.var_E5FD)
		{
			return 0;
		}
	}
	else
	{
		var_0B = anglestoforward(self.angles);
		if(vectordot(var_04,var_0B) > -0.707)
		{
			return 0;
		}

		var_0C = lengthsquared(var_05);
		if(var_0C > 65536)
		{
			return 0;
		}

		var_05 = scripts\common\utility::func_6EE6(var_05);
		if(vectordot(var_05,var_04) < 0.966)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 21
func_100A2(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_233))
	{
		return 1;
	}

	var_04 = self.var_15B - self.origin;
	var_05 = lengthsquared(var_04);
	if(var_05 > 144)
	{
		var_06 = scripts\common\utility::func_6EE6(self.var_1BE);
		var_07 = anglestoforward(self.angles);
		var_04 = scripts\common\utility::func_6EE6(var_04);
		var_08 = lib_0C08::func_7E30(2000);
		if(isdefined(var_08))
		{
			var_09 = scripts\common\utility::func_6EE6(var_08.origin - self.origin);
			if(vectordot(var_09,var_06) > 0.5)
			{
				return 1;
			}
		}
		else if(var_05 > 90000)
		{
			return 1;
		}

		if(vectordot(var_04,var_06) < 0.866)
		{
			return 1;
		}

		if(vectordot(var_06,var_07) > 0)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 22
func_CEBB(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0F3D::func_136B4(param_00,param_01,param_03);
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	var_05 = func_7DD5();
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_04,1,param_02,1);
	childthread func_CEBC();
	lib_0A1E::func_231F(param_00,param_01);
}

//Function Number: 23
func_CEBC()
{
	for(;;)
	{
		if(!isdefined(self.var_233))
		{
			break;
		}

		if(distancesquared(self.origin,self.var_233) < 144)
		{
			break;
		}

		var_00 = self.var_1BE;
		var_01 = -1 * var_00;
		var_02 = vectortoyaw(var_01);
		self method_8221("face angle",var_02);
		wait(0.05);
	}
}

//Function Number: 24
func_CEB6(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	var_05 = -1 * self.var_1BE;
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_04,1,param_02,1);
	var_06 = vectortoyaw(var_05);
	var_07 = lib_0C08::func_7E30();
	if(isdefined(var_07))
	{
		var_08 = var_07.origin - self.origin;
		var_09 = vectorcross(var_05,var_08);
		if(var_09[2] < 0)
		{
			var_06 = var_06 - 10;
		}
		else
		{
			var_06 = var_06 + 10;
		}
	}

	self method_8221("face angle",var_06);
	lib_0A1E::func_231F(param_00,param_01);
}

//Function Number: 25
func_CEAC(param_00,param_01,param_02,param_03)
{
	self.var_4C7E = ::lib_0F3D::func_22EA;
	self.var_1491.var_22E5 = param_01;
	var_04 = func_100A2(param_00,param_01);
	var_05 = func_7DD5();
	if(isdefined(self.var_2303.var_11068))
	{
		var_06 = self.var_2303.var_11068;
		var_07 = var_06.var_2C9;
		var_08 = var_06.var_2C5;
		var_09 = var_06.var_1F3;
	}
	else
	{
		var_07 = lib_0A1E::func_2336(param_03,var_04);
		var_09 = getmovedelta(var_09);
		if(var_04)
		{
			var_08 = self.origin;
		}
		else
		{
			var_08 = var_05 - rotatevector(var_09,self.angles);
		}
	}

	var_0A = var_05 - self.origin;
	var_0B = -1 * var_0A;
	var_0C = vectortoyaw(var_0B);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_07,1,param_02,1);
	if(!var_04)
	{
		self method_8396(var_08,self.angles[1]);
	}
	else
	{
		var_0D = self.origin + rotatevector(var_09,self.angles);
		if(!self method_81FF(self.origin,var_0D))
		{
			self method_8396(var_08,self.angles[1]);
		}
		else
		{
			self method_8221("face current");
		}
	}

	lib_0A1E::func_231F(param_00,param_01);
	self method_841F();
	self.var_1491.var_BCC8 = "stop";
}

//Function Number: 26
func_CEAB(param_00,param_01,param_02)
{
	self.var_2303.var_11068 = undefined;
}