/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3173.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 36 ms
 * Timestamp: 10/27/2023 12:26:25 AM
*******************************************************************/

//Function Number: 1
func_CEB5(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self.var_2303.var_4C86.var_697F = undefined;
	if(isdefined(self.var_28CF) && self.var_28CF)
	{
		var_05 = issubstr(param_01,"cover");
		func_BCF9(var_05);
	}

	if(!isdefined(var_04))
	{
		lib_0A1A::func_2330(param_01,"abort");
		lib_0A1A::func_2330(param_01,"code_move",undefined);
		lib_0A1A::func_2330(param_01,"end",undefined);
		lib_0A1A::func_2330(param_01,"finish",undefined);
		return;
	}

	var_06 = 0;
	if(isdefined(param_03))
	{
		var_06 = param_03;
	}

	func_D53A(param_00,param_01,var_04,param_02,var_06);
}

//Function Number: 2
func_3E9F(param_00,param_01,param_02)
{
	if(!func_3E57())
	{
		return undefined;
	}

	var_03 = undefined;
	var_04 = 0;
	if(isarray(param_02) && isdefined(param_02[1]))
	{
		var_04 = param_02[1];
	}

	if(isdefined(param_02) && isarray(param_02) && isdefined(param_02[0]))
	{
		var_03 = func_53CA(param_01,lib_0A1B::func_2928(param_02[0]),var_04);
	}
	else if(isdefined(param_02) && !isarray(param_02))
	{
		var_03 = func_53CA(param_01,lib_0A1B::func_2928(param_02),var_04);
	}
	else
	{
		var_03 = func_53CA(param_01,undefined,var_04);
	}

	return var_03;
}

//Function Number: 3
func_8162(param_00,param_01)
{
	var_02 = [];
	var_03 = "";
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	var_04 = "";
	if(isdefined(self.var_2303.var_13CAF) && self.var_2303.var_13CAF)
	{
		if(lib_0A1A::func_2346(param_00,var_03 + "2_2h"))
		{
			var_04 = "_2h";
		}
	}

	if(lib_0A1A::func_2346(param_00,var_03 + "1" + var_04))
	{
		var_02[7] = lib_0A1A::func_2358(param_00,var_03 + "1" + var_04);
	}

	if(lib_0A1A::func_2346(param_00,var_03 + "2" + var_04))
	{
		var_02[0] = lib_0A1A::func_2358(param_00,var_03 + "2" + var_04);
		var_02[8] = var_02[0];
	}

	if(lib_0A1A::func_2346(param_00,var_03 + "3" + var_04))
	{
		var_02[1] = lib_0A1A::func_2358(param_00,var_03 + "3" + var_04);
	}

	if(lib_0A1A::func_2346(param_00,var_03 + "4" + var_04))
	{
		var_02[6] = lib_0A1A::func_2358(param_00,var_03 + "4" + var_04);
	}

	if(lib_0A1A::func_2346(param_00,var_03 + "6" + var_04))
	{
		var_02[2] = lib_0A1A::func_2358(param_00,var_03 + "6" + var_04);
	}

	if(lib_0A1A::func_2346(param_00,var_03 + "7" + var_04))
	{
		var_02[5] = lib_0A1A::func_2358(param_00,var_03 + "7" + var_04);
	}

	if(lib_0A1A::func_2346(param_00,var_03 + "8" + var_04))
	{
		var_02[4] = lib_0A1A::func_2358(param_00,var_03 + "8" + var_04);
	}

	if(lib_0A1A::func_2346(param_00,var_03 + "9" + var_04))
	{
		var_02[3] = lib_0A1A::func_2358(param_00,var_03 + "9" + var_04);
	}

	return var_02;
}

//Function Number: 4
func_8163()
{
	var_00 = lib_0A1A::func_233C();
	if(var_00 == "casual" || var_00 == "casual_gun")
	{
		return 75;
	}

	return 100;
}

//Function Number: 5
func_53CA(param_00,param_01,param_02)
{
	var_03 = self method_8148();
	if(isdefined(var_03))
	{
		var_04 = var_03.origin;
	}
	else
	{
		var_04 = self.var_233;
	}

	var_05 = scripts\anim\exit_node::func_7EA3();
	if(self.var_36F)
	{
		if(param_02)
		{
			var_06 = self.origin + self.var_1BE * self.var_1BF;
		}
		else
		{
			var_06 = self method_845C(128);
		}

		var_07 = vectortoangles(var_06 - self.origin);
	}
	else
	{
		var_07 = vectortoangles(self.var_1BE);
	}

	if(lib_0F3D::func_C057(var_05) && !param_02)
	{
		var_08 = var_05.angles;
	}
	else
	{
		var_08 = self.angles;
	}

	var_09 = angleclamp180(var_07[1] - var_08[1]);
	if(length2dsquared(self.var_381) > 16)
	{
		var_0A = vectortoangles(self.var_381);
		if(abs(angleclamp180(var_0A[1] - var_07[1])) < 45)
		{
			return;
		}
	}

	var_0B = func_8163();
	if(distancesquared(var_04,self.origin) < var_0B * var_0B)
	{
		return;
	}

	if(isdefined(self.var_2303.var_4C86.var_697F))
	{
		var_0C = func_8162(self.var_2303.var_4C86.var_697F,param_01);
	}
	else
	{
		var_0C = func_8162(param_01,param_02);
	}

	var_0D = function_02F8(var_09);
	var_0E = self method_84AC();
	var_0F = undefined;
	var_10 = 0;
	for(var_10 = 0;var_10 < var_0D.size;var_10++)
	{
		var_11 = var_0D[var_10];
		if(!isdefined(var_0C[var_11]))
		{
			continue;
		}

		var_0F = var_0C[var_11];
		var_12 = 1;
		var_13 = getnotetracktimes(var_0F,"code_move");
		if(var_13.size > 0)
		{
			var_12 = var_13[0];
		}

		var_14 = getmovedelta(var_0F,0,var_12);
		var_15 = rotatevector(var_14,self.angles) + var_0E;
		var_16 = getnotetracktimes(var_0F,"corner");
		if(var_16.size == 0)
		{
			var_16 = getnotetracktimes(var_0F,"exit_align");
		}

		if(var_16.size > 0)
		{
			var_17 = getmovedelta(var_0F,0,var_16[0]);
			var_18 = rotatevector(var_17,self.angles) + var_0E;
			var_19 = self method_81FF(var_18,var_15,1,1);
			if(var_19)
			{
				break;
			}

			continue;
		}

		if(self method_81FF(var_0E,var_15,1,1))
		{
			break;
		}
	}

	if(var_10 == var_0D.size)
	{
		return undefined;
	}

	return var_0F;
}

//Function Number: 6
func_D53A(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_01 + "_finished");
	if(self.var_36F)
	{
		var_05 = self method_845C(128);
		var_06 = vectortoangles(var_05 - self.origin);
	}
	else
	{
		var_06 = vectortoangles(self.var_1BE);
	}

	var_07 = angleclamp180(var_06[1] - self.angles[1]);
	var_08 = getnotetracktimes(param_02,"code_move");
	var_09 = 1;
	if(var_08.size > 0)
	{
		thread lib_0F3D::func_136B4(param_00,param_01,undefined);
		thread lib_0F3D::func_136E7(param_00,param_01,undefined);
		var_09 = var_08[0];
	}

	var_0A = getangledelta3d(param_02,0,var_09);
	self method_8016("zonly_physics",0);
	childthread scripts\asm\shared_utility::func_FB04(param_01,param_03);
	thread lib_0F3D::func_444B(param_01);
	lib_0A1E::func_2369(param_00,param_01,param_02);
	if(isdefined(self.var_22EE))
	{
		self method_82E4(param_01,param_02,lib_0A1E::func_2339(),1,param_03,self.var_BCD6 * self.var_22EE);
	}
	else
	{
		self method_82E4(param_01,param_02,lib_0A1E::func_2339(),1,param_03,self.var_BCD6);
	}

	lib_0A1E::func_231F(param_00,param_01,::func_899E,param_02,undefined,1);
	if(param_04)
	{
		lib_0F3D::func_11065();
		self method_8016("normal",0);
		self method_8221("face motion");
		lib_0A1E::func_231F(param_00,param_01);
	}
}

//Function Number: 7
func_899E(param_00,param_01)
{
	if(param_00 == "exit_align" || param_00 == "corner")
	{
		var_02 = param_01;
		var_03 = self method_845C(36);
		var_04 = vectortoangles(var_03 - self.origin);
		var_05 = self method_8102(var_02);
		var_06 = getangledelta3d(var_02,var_05,1);
		self method_8221("face angle",angleclamp180(var_04[1] - var_06[1]));
	}
}

//Function Number: 8
func_3E57()
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(!self method_8380())
	{
		return 0;
	}

	if(self.var_1491.var_D6A5 == "prone")
	{
		return 0;
	}

	if(isdefined(self.var_55ED) && self.var_55ED)
	{
		return 0;
	}

	if(self.var_2C0 != "none")
	{
		return 0;
	}

	if(!self method_81BF("stand") && !isdefined(self.var_8CD0))
	{
		return 0;
	}

	var_00 = 10000;
	var_01 = lib_0A1A::func_233C();
	if(lib_0A1A::func_233C() == "casual" || lib_0A1A::func_233C() == "casual_gun")
	{
		var_00 = 2500;
	}

	if(distancesquared(self.origin,self.var_233) < var_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 9
func_3B1F(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1A::func_233C();
	if(!isdefined(param_03[2]) || param_03[2] != var_04)
	{
		return 0;
	}

	if(!func_FFF8(param_00,param_01,param_02,param_03))
	{
		return 0;
	}

	var_05 = self.var_1491.var_FC62;
	return var_05 < 2 || var_05 > 6;
}

//Function Number: 10
func_FFF8(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_C189) && self.var_C189)
	{
		return 0;
	}

	if(isdefined(self.var_932E) && self.var_932E)
	{
		return 0;
	}

	var_04 = self.var_164D[param_00].var_4BC0;
	var_05 = lib_0A1A::func_233F(var_04,"sharp_turn");
	if(!isdefined(var_05))
	{
		return 0;
	}

	var_06 = 50;
	var_07 = gettime();
	if(var_07 - var_05.var_7686 > var_06)
	{
		return 0;
	}

	var_08 = var_05.var_C8F0[1];
	var_09 = var_05.var_C8F0[2];
	var_0A = 0;
	var_0B = undefined;
	if(!isarray(param_03))
	{
		var_0C = param_03;
	}
	else
	{
		var_0C = var_04[0];
		if(param_03.size > 1 && param_03[1] == 1)
		{
			var_0A = 1;
		}

		if(param_03.size > 2)
		{
			var_0B = lib_0A1B::func_2928(param_03[2]);
		}
	}

	var_0D = func_371C(param_01,var_0C,var_08,var_09,var_0A,var_0B);
	if(!isdefined(var_0D))
	{
		return 0;
	}

	self.var_1491.var_FC61 = var_0D;
	return 1;
}

//Function Number: 11
func_371C(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 10;
	if(param_03 || self.var_1BF > self.var_292 * 2)
	{
		var_06 = 30;
	}

	if(!isdefined(param_05))
	{
		param_05 = "";
	}

	if(param_04)
	{
		if(lib_0A1A::func_232C(param_00,"pass_left"))
		{
			var_07 = param_05 + "left";
		}
		else if(lib_0A1A::func_232C(param_01,"pass_right"))
		{
			var_07 = var_06 + "right";
		}
		else if(self.var_2303.var_7257.var_7254 == "right")
		{
			var_07 = var_06 + "right";
		}
		else
		{
			var_07 = var_06 + "left";
		}
	}
	else
	{
		var_07 = var_06;
	}

	if(isdefined(self.var_22F0))
	{
		var_08 = self.var_22F0;
	}
	else
	{
		var_08 = -1;
	}

	var_09 = self method_8546(self.var_2303.var_2123,param_01,lib_0A1A::func_2353(),param_02,param_03,var_06,var_08,var_07,param_05);
	var_0A = var_09[0];
	var_0B = var_09[1];
	if(isdefined(self.var_2303.var_13CAF) && self.var_2303.var_13CAF && isdefined(var_0B))
	{
		var_0C = var_0B;
		if(var_0B == 0 || var_0B == 8)
		{
			var_0C = 2;
		}

		if(var_0B == 1)
		{
			var_0C = 3;
		}

		if(var_0B == 2)
		{
			var_0C = 6;
		}

		if(var_0B == 3)
		{
			var_0C = 9;
		}

		if(var_0B == 4)
		{
			var_0C = 8;
		}

		if(var_0B == 5)
		{
			var_0C = 7;
		}

		if(var_0B == 6)
		{
			var_0C = 4;
		}

		if(var_0B == 7)
		{
			var_0C = 1;
		}

		var_0D = var_07 + var_0C + "_2h";
		if(lib_0A1E::func_2305(self.var_2303.var_2123,param_01,var_0D))
		{
			var_0A = lib_0A1E::func_2359(self.var_2303.var_2123,param_01,var_0D);
		}
	}

	self.var_1491.var_FC62 = var_0B;
	return var_0A;
}

//Function Number: 12
func_3EF5(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_FC61;
}

//Function Number: 13
func_8989(param_00)
{
	if(param_00 == "corner")
	{
		self method_8221("face motion");
	}
}

//Function Number: 14
func_D514(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self.var_1491.var_FC61 = undefined;
	self method_8016("zonly_physics",0);
	self method_8221("face angle",self.angles[1]);
	self method_806F(lib_0A1E::func_2339(),param_02);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	thread lib_0F3D::func_444B(param_01);
	self method_82EA(param_01,var_04,1,param_02,self.var_BCD6);
	var_05 = lib_0A1E::func_231F(param_00,param_01,::func_8989,undefined,undefined,0);
	self method_8221("face motion");
	self method_8016("normal",0);
	if(var_05 == "code_move")
	{
		lib_0F3D::func_11065();
		thread lib_0F3D::func_136B4(param_00,param_01,param_03);
		thread lib_0F3D::func_136E7(param_00,param_01,param_03);
		var_06 = getnotetracktimes(var_04,"finish");
		if(var_06.size > 0)
		{
			lib_0A1E::func_231F(param_00,param_01);
		}
	}
}

//Function Number: 15
func_98C6(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_E873))
	{
		self notify("stop_move_anim_update");
		self.var_12DEF = undefined;
		thread lib_0F3D::func_136B4(param_00,param_01,param_03);
		thread lib_0F3D::func_136E7(param_00,param_01,param_03);
		self method_806F(lib_0A1E::func_2339(),param_02);
		self.var_E879 = 0;
		self.var_E873 = 1;
	}
}

//Function Number: 16
func_11088(param_00,param_01,param_02)
{
	if(isdefined(self.var_E873))
	{
		self method_806F(lib_0A1A::func_2358(param_01,"run_n_gun"),0.2);
		self.var_E873 = undefined;
	}

	return 0;
}

//Function Number: 17
func_D50D(param_00,param_01,param_02,param_03)
{
	func_98C6(param_00,param_01,param_02,param_03);
	func_E877(param_00,param_01,param_02,param_03);
}

//Function Number: 18
func_E875()
{
	if(isalive(self.var_10C) && self method_805F(self.var_10C))
	{
		return self.var_10C;
	}
}

//Function Number: 19
func_1006E(param_00,param_01,param_02,param_03)
{
	if(self.team == "allies" && func_9EC3(param_00,param_01,param_02,param_03))
	{
		return 0;
	}

	if(self method_841E() < 200)
	{
		return 0;
	}

	var_04 = func_E875();
	return self.var_12A && isdefined(var_04) && scripts\anim\move::func_B4EC() && lib_0A1B::func_2956("combat");
}

//Function Number: 20
func_10070(param_00,param_01,param_02,param_03)
{
	return func_390F();
}

//Function Number: 21
func_1006F(param_00,param_01,param_02,param_03)
{
	return func_390E();
}

//Function Number: 22
func_1009F(param_00,param_01,param_02,param_03)
{
	return !func_1006E(param_00,param_01,param_03) || !func_10070(param_00,param_01,param_02,param_03);
}

//Function Number: 23
func_1009E(param_00,param_01,param_02,param_03)
{
	return !func_1006E(param_00,param_01,param_03) || !func_1006F(param_00,param_01,param_02,param_03);
}

//Function Number: 24
func_390F()
{
	if((!isdefined(self.var_E879) || self.var_E879 == 0) && abs(self method_813E()) > self.var_B4C3)
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
func_390E()
{
	if(!isdefined(self.var_E879) || self.var_E879 == 0)
	{
		return 0;
	}

	if(180 - abs(self method_813E()) >= 45)
	{
		return 0;
	}

	var_00 = func_8096(0.2);
	if(abs(var_00) > 30)
	{
		return 0;
	}

	return 1;
}

//Function Number: 26
func_390D()
{
	return scripts\anim\move::func_B4EC() && isdefined(self.var_10C) && func_390F() || func_390E();
}

//Function Number: 27
func_8096(param_00)
{
	var_01 = self.origin;
	var_02 = self.angles[1] + self method_813E();
	var_01 = var_01 + (cos(var_02),sin(var_02),0) * length(self.var_381) * param_00;
	var_03 = self.angles[1] - vectortoyaw(self.var_10C.origin - var_01);
	var_03 = angleclamp180(var_03);
	return var_03;
}

//Function Number: 28
func_E877(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1A::func_2358(param_01,"F");
	var_05 = lib_0A1A::func_2358(param_01,"L");
	var_06 = lib_0A1A::func_2358(param_01,"R");
	var_07 = lib_0A1A::func_2358(param_01,"LB");
	var_08 = lib_0A1A::func_2358(param_01,"RB");
	var_09 = lib_0A1A::func_2358(param_01,"run_n_gun");
	var_0A = self.var_B4C3;
	var_0B = self.var_E878;
	var_0C = self.var_E876;
	for(;;)
	{
		var_0D = func_E875();
		if(isdefined(var_0D))
		{
			var_0E = func_8096(0.2);
			var_0F = var_0E < 0;
		}
		else
		{
			var_0E = 0;
			var_0F = self.var_E879 < 0;
		}

		var_10 = 1 - var_0F;
		var_11 = var_0E / var_0A;
		var_12 = var_11 - self.var_E879;
		if(abs(var_12) < var_0B * 0.7)
		{
			self.var_E879 = var_11;
		}
		else if(var_12 > 0)
		{
			self.var_E879 = self.var_E879 + var_0C;
		}
		else
		{
			self.var_E879 = self.var_E879 - var_0C;
		}

		var_13 = abs(self.var_E879);
		if(var_13 > var_0B)
		{
			var_14 = var_13 - var_0B / var_0B;
			var_14 = clamp(var_14,0,1);
			self method_806F(var_04,0.2);
			self method_82AC(var_05,1 - var_14 * var_0F,0.2);
			self method_82AC(var_06,1 - var_14 * var_10,0.2);
			self method_82AC(var_07,var_14 * var_0F,0.2);
			self method_82AC(var_08,var_14 * var_10,0.2);
		}
		else
		{
			var_14 = clamp(var_13 / var_0B,0,1);
			self method_82AC(var_04,1 - var_14,0.2);
			self method_82AC(var_05,var_14 * var_0F,0.2);
			self method_82AC(var_06,var_14 * var_10,0.2);
			if(var_0B < 1)
			{
				self method_806F(var_07,0.2);
				self method_806F(var_08,0.2);
			}
		}

		self method_82A4(var_09,1,0.3,0.8);
		self.var_1491.var_1C8D = gettime() + 500;
		if(isdefined(var_0D) && isplayer(var_0D))
		{
			self method_83CE();
		}

		wait(0.2);
	}
}

//Function Number: 29
func_D50E(param_00,param_01,param_02,param_03)
{
	func_98C6(param_00,param_01,param_02,param_03);
	func_E874(param_00,param_01,param_02,param_03);
}

//Function Number: 30
func_E874(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	for(;;)
	{
		if(isplayer(self.var_10C))
		{
			self method_83CE();
		}

		var_04 = lib_0A1E::func_2336(param_00,param_01);
		self method_82E2(param_01,var_04,1,param_02,1);
		lib_0A1E::func_2369(param_00,param_01,var_04);
		wait(0.2);
	}
}

//Function Number: 31
func_D4E6(param_00,param_01,param_02,param_03)
{
	if(getdvarint("ai_usefullstrafe",0) == 0)
	{
		func_D4E5(param_00,param_01,param_02,param_03);
		return;
	}

	self method_806F(lib_0A1E::func_2339(),param_02);
	func_98A3(param_00,param_01,param_02,param_03);
	thread func_BCFD(param_00,param_01,param_02,param_03);
}

//Function Number: 32
func_98A3(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	if(isdefined(param_03))
	{
		var_04 = param_03;
	}

	var_05 = lib_0A1E::func_2336(param_00,param_01);
	self method_82A4(var_05[0],1,0.2,var_04,1);
}

//Function Number: 33
func_817A(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < 9;var_02++)
	{
		var_01[var_02] = 0;
	}

	var_03 = [-180,-135,-90,-45,0,45,90,135,180];
	for(var_02 = 0;param_00 >= var_03[var_02];var_02++)
	{
	}

	var_04 = var_02 - 1;
	var_05 = var_02;
	var_06 = param_00 - var_03[var_04] / var_03[var_05] - var_03[var_04];
	var_07 = 1 - var_06;
	var_01[var_04] = var_07;
	var_01[var_05] = var_06;
	if(var_01[0] > var_01[8])
	{
		var_01[8] = var_01[0];
	}
	else
	{
		var_01[0] = var_01[8];
	}

	return var_01;
}

//Function Number: 34
func_3F03(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = lib_0A1A::func_2358(param_01,"0");
	var_03[1] = lib_0A1A::func_2358(param_01,"1");
	var_03[2] = lib_0A1A::func_2358(param_01,"2");
	var_03[3] = lib_0A1A::func_2358(param_01,"3");
	var_03[4] = lib_0A1A::func_2358(param_01,"4");
	var_03[5] = lib_0A1A::func_2358(param_01,"5");
	var_03[6] = lib_0A1A::func_2358(param_01,"6");
	var_03[7] = lib_0A1A::func_2358(param_01,"7");
	var_03[8] = lib_0A1A::func_2358(param_01,"8");
	return var_03;
}

//Function Number: 35
func_3F0C(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_04 = [];
	var_04[0] = lib_0A1A::func_2358(param_01,"0");
	var_04[1] = lib_0A1A::func_2358(param_01,"1");
	var_04[2] = lib_0A1A::func_2358(param_01,"2");
	var_03.var_47 = var_04;
	var_03.var_7332 = lib_0A1A::func_2358(param_01,"forward");
	return var_03;
}

//Function Number: 36
func_100BD()
{
	return lib_0A1B::func_2955() && isdefined(self.var_1198.var_13863) && self.var_1198.var_13863;
}

//Function Number: 37
func_13874(param_00,param_01)
{
	self endon(param_01 + "_finished");
	lib_0A1E::func_231F(param_00,param_01);
}

//Function Number: 38
func_BD2C(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0F3D::func_136B4(param_00,param_01,param_03);
	thread lib_0F3D::func_136E7(param_00,param_01,param_03);
	var_04 = lib_0A1A::func_2340();
	lib_0A1A::func_238C();
	self method_84F1(var_04);
	lib_0A1A::func_238C();
	var_05 = lib_0A1E::func_2336(param_00,param_01);
	var_06 = var_05.var_47;
	var_07 = var_05.var_7332;
	self method_806F(lib_0A1E::func_2339(),0.2);
	self method_82E1(param_01,var_07,1,0.2,1);
	thread func_13874(param_00,param_01);
	var_08 = 0;
	var_09 = 20;
	for(;;)
	{
		var_0A = lib_0A1A::func_232B(param_01,"cover_approach");
		var_0B = self method_841E();
		if(var_0A && var_0B < 150)
		{
			var_0C = func_1E80();
			var_0D = 1;
			while(var_0D <= var_09)
			{
				var_0E = var_0D / var_09;
				var_0F = var_0E * var_0E * 3 - 2 * var_0E;
				var_10 = var_0C;
				var_11 = var_10 * var_0F;
				var_12 = var_10 - var_11;
				var_13 = func_820A(var_12);
				for(var_14 = 0;var_14 < var_13.size;var_14++)
				{
					self method_82A2(var_06[var_14],var_13[var_14],0.2,1,1);
				}

				var_0D++;
				wait(0.05);
				waittillframeend;
			}

			while(var_0A)
			{
				var_13 = func_820A(0);
				for(var_0D = 0;var_0D < var_13.size;var_0D++)
				{
					if(isdefined(var_06[var_0D]))
					{
						self method_82A2(var_06[var_0D],var_13[var_0D],0.2,1,1);
					}
				}

				wait(0.05);
				waittillframeend;
			}

			continue;
		}

		var_0C = func_1E80();
		var_15 = var_08 - var_0C;
		if(var_15 < 0)
		{
			var_15 = var_15 * -1;
		}

		if(var_15 >= 60)
		{
			var_16 = var_08;
			var_17 = var_08;
			var_0D = 1;
			while(var_0D <= var_09)
			{
				var_0C = func_1E80();
				var_18 = var_16 - var_0C;
				if(var_18 < 0)
				{
					var_18 = var_18 * -1;
				}

				if(var_18 >= 60)
				{
					if(var_0D == 1)
					{
						var_0D = 1;
					}
					else
					{
						var_0D = var_0D - 1;
					}

					var_19 = var_16 - var_08;
					var_0E = var_0D / var_09;
					var_0F = var_0E * var_0E * 3 - 2 * var_0E;
					var_1A = var_19 * var_0F;
					var_17 = var_1A + var_08;
					var_0D = 1;
					var_08 = var_17;
				}

				var_0E = var_0D / var_09;
				var_0F = var_0E * var_0E * 3 - 2 * var_0E;
				var_10 = var_0C - var_17;
				var_11 = var_10 * var_0F;
				var_12 = var_11 + var_08;
				var_13 = func_820A(var_12);
				for(var_14 = 0;var_14 < var_13.size;var_14++)
				{
					self method_82A2(var_06[var_14],var_13[var_14],0.2,1,1);
				}

				var_0D++;
				var_16 = var_0C;
				wait(0.05);
				waittillframeend;
			}
		}
		else
		{
			var_13 = func_820A(var_0C);
			for(var_0D = 0;var_0D < var_13.size;var_0D++)
			{
				if(isdefined(var_06[var_0D]))
				{
					self method_82A2(var_06[var_0D],var_13[var_0D],0.2,1,1);
				}
			}

			wait(0.05);
			waittillframeend;
		}

		var_08 = var_0C;
	}
}

//Function Number: 39
func_1E80()
{
	var_00 = self.var_13864.origin;
	var_01 = self.origin;
	var_02 = var_00 - var_01;
	var_03 = anglestoforward(self.angles);
	var_04 = vectorcross(var_03,var_02);
	var_05 = vectornormalize(var_04);
	var_06 = vectornormalize(var_02);
	var_07 = vectornormalize(var_03);
	var_08 = vectordot(var_06,var_07);
	if(isdefined(self.var_13862))
	{
		var_09 = scripts\common\utility::func_1E7C(var_02,var_03);
		if(self.var_13862 == "right")
		{
			if(var_08 <= -1)
			{
				return -180;
			}

			return var_09 * -1;
		}

		if(var_08 >= 1)
		{
			return 180;
		}

		return var_09;
	}

	if(var_08 >= 1)
	{
		return 180;
	}

	if(var_08 <= -1)
	{
		return -180;
	}

	var_09 = scripts\common\utility::func_1E7C(var_02,var_03);
	if(var_05[2] == -1)
	{
		var_09 = var_09 * -1;
	}

	return var_09;
}

//Function Number: 40
func_820A(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < 3;var_02++)
	{
		var_01[var_02] = 0;
	}

	var_03 = [-180,0,180];
	for(var_02 = 0;param_00 >= var_03[var_02];var_02++)
	{
	}

	var_04 = var_02 - 1;
	var_05 = var_02;
	var_06 = param_00 - var_03[var_04] / var_03[var_05] - var_03[var_04];
	var_07 = 1 - var_06;
	var_01[var_04] = var_07;
	var_01[var_05] = var_06;
	var_01[1] = max(0.01,var_01[1]);
	return var_01;
}

//Function Number: 41
func_BCFD(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = 1;
	if(isdefined(param_03))
	{
		var_04 = param_03;
	}

	var_05 = lib_0A1E::func_2336(param_00,param_01);
	self.var_110D5 = 0;
	var_06 = self method_813E();
	for(;;)
	{
		if(length(self.var_381) > 1)
		{
			var_06 = self method_813E();
		}

		self.var_110D5 = var_06;
		var_07 = func_817A(self.var_110D5);
		for(var_08 = 0;var_08 < var_07.size;var_08++)
		{
			if(isdefined(var_05[var_08]))
			{
				self method_82AC(var_05[var_08],var_07[var_08],0.1,var_04,1);
			}
		}

		wait(0.1);
	}
}

//Function Number: 42
func_D4E5(param_00,param_01,param_02,param_03)
{
	func_98A2(param_00,param_01,param_02,param_03);
	thread func_BCFC(param_00,param_01,param_02,param_03);
}

//Function Number: 43
func_98A2(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	if(isdefined(param_03) && lib_0A1A::func_233C() != "frantic")
	{
		var_04 = param_03;
	}

	var_05 = lib_0A1A::func_2358(param_01,"F");
	var_06 = lib_0A1A::func_2358(param_01,"L");
	var_07 = lib_0A1A::func_2358(param_01,"R");
	var_08 = lib_0A1A::func_2358(param_01,"B");
	self method_82A9(var_05,1,0.1,var_04,1);
	self method_82A9(var_08,1,0.1,var_04,1);
	self method_82A9(var_07,1,0.1,var_04,1);
	self method_82A9(var_06,1,0.1,var_04,1);
}

//Function Number: 44
func_BCFC(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = 1;
	if(isdefined(param_03))
	{
		var_04 = param_03;
	}

	self method_84F1(var_04);
	var_05 = lib_0A1A::func_2358(param_01,"f_knob");
	var_06 = lib_0A1A::func_2358(param_01,"l_knob");
	var_07 = lib_0A1A::func_2358(param_01,"r_knob");
	var_08 = lib_0A1A::func_2358(param_01,"b_knob");
	for(;;)
	{
		var_09 = scripts\anim\utility_common::func_DB51(self method_813E());
		self method_82A2(var_05,var_09["front"],0.2,1,1);
		self method_82A2(var_08,var_09["back"],0.2,1,1);
		self method_82A2(var_06,var_09["left"],0.2,1,1);
		self method_82A2(var_07,var_09["right"],0.2,1,1);
		wait(0.05);
		waittillframeend;
	}
}

//Function Number: 45
func_3EFF(param_00,param_01,param_02)
{
	if(isdefined(self.var_15F))
	{
		return lib_0A1A::func_2358(param_01,"sprint_short");
	}

	if(lib_0A1A::func_234A("sprint","move"))
	{
		var_03 = lib_0A1A::func_233D("sprint","move");
		if(isarray(var_03))
		{
			return var_03[randomint(var_03.size)];
		}

		return var_03;
	}

	return lib_0A1A::func_2358(param_02,"sprint");
}

//Function Number: 46
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

	if(self.var_1BF < 100)
	{
		return 0;
	}

	if(!isdefined(self.var_233) || distancesquared(self.var_233,self.origin) < 160000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 47
func_BCF9(param_00)
{
	var_01 = lib_0A1A::func_233C();
	if(var_01 == "frantic" || var_01 == "combat" || var_01 == "sprint")
	{
		scripts\anim\battlechatter_ai::func_67D2(param_00);
	}
}

//Function Number: 48
func_10068(param_00,param_01,param_02,param_03)
{
	if(!lib_0A1B::func_2959())
	{
		return 0;
	}

	if(lib_0A1A::func_2353())
	{
		var_04 = 400;
	}
	else if(lib_0A1B::func_2956("cqb"))
	{
		var_04 = 500;
	}
	else
	{
		var_04 = 600;
	}

	var_05 = self method_841E();
	return var_04 < var_05;
}

//Function Number: 49
func_D506(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	thread lib_0F3D::func_136B4(param_00,param_01,param_03);
	thread lib_0F3D::func_136E7(param_00,param_01,param_03);
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self method_82E7(param_01,var_04,1,param_02,self.var_BCD6);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	lib_0A1E::func_231F(param_00,param_01);
}

//Function Number: 50
func_116FE(param_00,param_01,param_02)
{
	if(!lib_0A1A::func_232B(param_01,"reload done"))
	{
		scripts\anim\weaponlist::func_DE4D();
	}

	lib_0C68::func_DF4F(param_00,param_01,param_02);
}

//Function Number: 51
func_10B4F(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		var_03 = lib_0A1B::func_2928(param_02);
		if(isdefined(var_03))
		{
			param_01 = var_03 + param_01;
		}
	}

	return scripts\common\utility::istrue(lib_0A1A::func_2346(param_00,param_01));
}

//Function Number: 52
func_9EC3(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_233) && self.var_2C0 != "none";
}

//Function Number: 53
func_9EC9(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(isarray(param_03))
	{
		var_04 = param_03[0];
	}
	else
	{
		var_04 = var_04;
	}

	return self.var_2C0 == var_04;
}

//Function Number: 54
func_8157()
{
	var_00 = lib_0A1A::func_233C();
	switch(var_00)
	{
		case "casual":
			return 23;

		case "casual_gun":
			return 17;

		case "cqb":
			return 20;

		default:
			return 36;
	}
}

//Function Number: 55
func_10006(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(isarray(param_03))
	{
		var_04 = param_03[0];
	}
	else
	{
		var_04 = param_03;
	}

	if(self.var_2C0 == var_04)
	{
		return 1;
	}

	var_05 = func_8157();
	var_06 = self method_84D7(var_05);
	if(var_06 == var_04)
	{
		return 1;
	}

	return 0;
}

//Function Number: 56
func_10005(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(isarray(param_03))
	{
		var_04 = param_03[0];
	}
	else
	{
		var_04 = param_03;
	}

	if(self.var_2C0 == var_04)
	{
		var_05 = undefined;
		if(isarray(param_03))
		{
			var_05 = param_03[1];
		}

		return func_10B4F(param_02,"left",var_05);
	}

	var_06 = func_8157();
	var_07 = self method_84D7(var_06);
	if(var_07 == var_05)
	{
		var_05 = undefined;
		if(isarray(param_03))
		{
			var_07 = param_03[1];
		}

		return func_10B4F(param_02,"left",var_07);
	}

	return 0;
}

//Function Number: 57
func_8158()
{
	var_00 = lib_0A1A::func_233C();
	switch(var_00)
	{
		case "casual":
			return 13;

		case "casual_gun":
			return 10;

		case "cqb":
			return 13;

		case "combat":
			return 10;

		case "frantic":
			return 10;

		default:
			return 28;
	}
}

//Function Number: 58
func_8159()
{
	var_00 = lib_0A1A::func_233C();
	switch(var_00)
	{
		case "casual":
			return 24;

		case "casual_gun":
			return 24;

		case "cqb":
			return 15;

		default:
			return 28;
	}
}

//Function Number: 59
func_7EEA()
{
	var_00 = self method_8552();
	if(abs(var_00) > 0.99)
	{
		return 0;
	}

	var_01 = acos(var_00);
	return var_01;
}

//Function Number: 60
func_10030(param_00,param_01,param_02,param_03)
{
	return self.var_2C0 != "none" && func_1000E(param_00,param_01,param_02,param_03);
}

//Function Number: 61
func_1000E(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_1198.disablestairsexits) && self.var_1198.disablestairsexits)
	{
		return 0;
	}

	if(self.var_2C0 == "none")
	{
		return 1;
	}

	var_04 = param_03;
	var_05 = func_8158();
	if(isdefined(param_03) && param_03 == "up")
	{
		var_05 = func_8159();
	}

	if(self.var_2C0 != var_04)
	{
		return 1;
	}

	var_06 = self method_84D7(var_05);
	return var_06 != self.var_2C0;
}

//Function Number: 62
func_3EA5(param_00,param_01,param_02)
{
	if(self.var_2303.var_7257.var_7254 == "left")
	{
		var_03 = "right";
	}
	else
	{
		var_03 = "left";
	}

	if(isdefined(param_02))
	{
		var_04 = lib_0A1B::func_2928(param_02);
		if(isdefined(var_04))
		{
			var_03 = var_04 + var_03;
		}
	}

	var_05 = lib_0A1E::func_2356(param_01,var_03);
	return var_05;
}

//Function Number: 63
func_3EA6(param_00,param_01,param_02)
{
	var_03 = "8x10";
	var_04 = func_7EEA();
	if(var_04 < 27.75)
	{
		var_03 = "8x20";
	}

	if(var_04 >= 27.75 && var_04 < 36.2)
	{
		var_03 = "8x12";
	}

	if(var_04 >= 36.2 && var_04 < 41.85)
	{
		var_03 = "8x10";
	}

	if(var_04 >= 41.85)
	{
		var_03 = "8x8";
	}

	var_05 = lib_0A1E::func_2356(param_01,var_03);
	return var_05;
}