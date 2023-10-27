/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3165.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 16 ms
 * Timestamp: 10/27/2023 12:26:22 AM
*******************************************************************/

//Function Number: 1
func_FFE6()
{
	if(isdefined(self.var_55B0) && self.var_55B0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 2
func_C186(param_00,param_01,param_02,param_03)
{
	return !func_1008A(param_00,param_01,param_03);
}

//Function Number: 3
func_7F95(param_00)
{
	return 256;
}

//Function Number: 4
func_1008A(param_00,param_01,param_02,param_03)
{
	if(!func_FFE6())
	{
		return 0;
	}

	if(!isdefined(self.var_233))
	{
		return 0;
	}

	var_04 = lib_0F3D::func_7DD6();
	if(isdefined(var_04) && isdefined(var_04.type) && var_04.type == "Cover Prone" || var_04.type == "Conceal Prone")
	{
		return 0;
	}

	if(!lib_0A1A::func_232B(param_01,"cover_approach"))
	{
		return 0;
	}

	if(isdefined(param_03))
	{
		if(!isarray(param_03))
		{
			var_05 = param_03;
		}
		else if(var_04.size < 1)
		{
			var_05 = "Exposed";
		}
		else
		{
			var_05 = var_04[0];
		}
	}
	else
	{
		var_05 = "Exposed";
	}

	if(!lib_0F3D::func_9D4C(param_00,param_01,param_02,var_05))
	{
		return 0;
	}

	var_06 = distance(self.origin,self.var_233);
	var_07 = func_7F95(var_05);
	if(var_06 > var_07)
	{
		return 0;
	}

	var_08 = 0;
	if(isdefined(param_03) && param_03.size > 1)
	{
		var_08 = int(param_03[1]);
	}

	var_09 = undefined;
	if(isdefined(param_03) && isarray(param_03) && param_03.size > 2)
	{
		var_09 = lib_0A1B::func_2928(param_03[2]);
	}

	var_0A = lib_0A1A::func_233C();
	if(var_0A == "casual" || var_0A == "casual_gun")
	{
		var_0B = 0.4;
		if(self method_841E() < 25)
		{
			var_0B = 2;
		}

		self.var_2303.var_11068 = func_3721(param_00,param_01,param_02,var_05,var_08,undefined,var_09,var_0B);
	}
	else
	{
		self.var_2303.var_11068 = func_3721(param_00,param_01,param_02,var_05,var_08,undefined,var_09);
	}

	if(!isdefined(self.var_2303.var_11068))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_10094(param_00,param_01,param_02,param_03)
{
	if(!lib_0A1A::func_232B(param_01,"code_move"))
	{
		return 0;
	}

	return func_10093(param_00,param_01,param_02,param_03);
}

//Function Number: 6
func_10093(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1A::func_233C();
	if(!isdefined(param_03) || var_04 != param_03[2])
	{
		return 0;
	}

	if(!lib_0A1A::func_232C(param_01,"pass_left") && !lib_0A1A::func_232C(param_01,"pass_right") && self method_841E() > 25)
	{
		return 0;
	}

	return func_1008A(param_00,param_01,param_02,param_03);
}

//Function Number: 7
func_10096(param_00,param_01,param_02,param_03)
{
	if(!lib_0A1A::func_232B(param_01,"code_move"))
	{
		return 0;
	}

	return func_10095(param_00,param_01,param_02,param_03);
}

//Function Number: 8
func_10095(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1A::func_233C();
	if(!isdefined(param_03) || var_04 != param_03[2])
	{
		return 0;
	}

	if(!lib_0A1A::func_232C(param_01,"pass_left") && !lib_0A1A::func_232C(param_01,"pass_right") && self method_841E() > 20)
	{
		return 0;
	}

	return func_1008A(param_00,param_01,param_02,param_03);
}

//Function Number: 9
func_C9B5()
{
	var_00 = lib_0F3D::func_7DD6();
	if(!isdefined(var_00))
	{
		return 1;
	}

	if(!isdefined(var_00.var_C9A7))
	{
		return 1;
	}

	return var_00.var_C9A7;
}

//Function Number: 10
func_10091(param_00,param_01,param_02,param_03)
{
	if(lib_0A1B::func_2941())
	{
		return 0;
	}

	if(!func_C9B5())
	{
		return 0;
	}

	return func_1008A(param_00,param_01,param_02,param_03);
}

//Function Number: 11
func_3E97(param_00,param_01,param_02)
{
	return self.var_2303.var_11068;
}

//Function Number: 12
func_3EA4(param_00,param_01,param_02)
{
	var_03 = lib_0F3D::func_7DD6();
	if(isdefined(var_03))
	{
		var_04 = scripts\asm\shared_utility::func_7FF7(var_03);
		var_05 = angleclamp(var_04 - var_03.angles[1]);
		var_06 = angleclamp(self.angles[1] - var_03.angles[1]);
		var_07 = func_812C(var_05);
		var_08 = func_812C(var_06);
		var_09 = var_08 + "_to_" + var_07;
		var_0A = lib_0A1A::func_2358(param_01,var_09);
		return var_0A;
	}
}

//Function Number: 13
func_812C(param_00)
{
	var_01 = 8;
	if(param_00 > 45 && param_00 <= 135)
	{
		var_01 = 4;
	}
	else if(param_00 > 135 && param_00 <= 225)
	{
		var_01 = 2;
	}
	else if(param_00 > 225 && param_00 <= 315)
	{
		var_01 = 6;
	}

	return var_01;
}

//Function Number: 14
func_3721(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = lib_0F3D::func_7DD6();
	if(isdefined(var_08) && !self method_858D() && isdefined(self.var_28B) && self.var_28B == var_08)
	{
		if(distance2dsquared(self.var_28B.origin,self.var_233) > 4096)
		{
			if(!isdefined(self.var_28B.var_3723) || self.var_28B.var_3723 < gettime() - 50)
			{
				self.var_28B.var_3723 = gettime();
			}
			else
			{
				self.var_28B delete();
				self.var_28B = undefined;
				var_08 = lib_0F3D::func_7DD6();
			}
		}
	}

	if(param_03 == "Custom")
	{
		param_02 = self.var_2303.var_4C86.var_22F1;
		param_04 = self.var_2303.var_4C86.var_22F6;
	}

	if(!isdefined(param_06))
	{
		param_06 = "";
	}

	var_09 = "";
	if(param_04)
	{
		if(lib_0A1A::func_232C(param_01,"pass_left"))
		{
			var_09 = param_06 + "left";
		}
		else if(lib_0A1A::func_232C(param_01,"pass_right"))
		{
			var_09 = param_06 + "right";
		}
		else if(self.var_2303.var_7257.var_7254 == "right")
		{
			var_09 = param_06 + "right";
		}
		else
		{
			var_09 = param_06 + "left";
		}
	}
	else
	{
		var_09 = param_06;
	}

	var_0A = undefined;
	if(isdefined(var_08))
	{
		var_0A = var_08.origin;
	}
	else
	{
		var_0A = self.var_233;
	}

	if(vectordot(vectornormalize(var_0A - self.origin),anglestoforward(self.angles)) < 0.707)
	{
		return undefined;
	}

	var_0B = lib_0F3D::func_C057(var_08);
	var_0C = undefined;
	var_0D = undefined;
	if(var_0B)
	{
		var_0C = scripts\asm\shared_utility::func_7FF7(var_08,param_03);
		var_0D = var_08.angles;
	}

	return self method_8547(var_0A,var_0D,func_7E54(),param_05,var_0B,self.var_2303.var_2123,param_02,lib_0A1A::func_2353(),var_0C,var_09,param_06,param_07,param_03);
}

//Function Number: 15
func_CECA(param_00,param_01)
{
	self endon("runto_arrived");
	self endon(param_01 + "_finished");
	for(;;)
	{
		self waittill("path_set");
		if(!self.var_15D)
		{
			break;
		}
	}

	lib_0A1A::func_2330(param_01,"abort");
}

//Function Number: 16
func_CEC9(param_00,param_01)
{
	self endon("runto_arrived");
	self endon(param_01 + "_finished");
	for(;;)
	{
		if(!isdefined(self.var_233))
		{
			break;
		}

		wait(0.05);
	}

	lib_0A1A::func_2330(param_01,"abort");
}

//Function Number: 17
func_22F3(param_00,param_01,param_02)
{
	if(func_C9B5())
	{
		var_03 = lib_0F3D::func_7DD6();
		var_04 = self;
		if(lib_0F3D::func_C057(var_03))
		{
			var_04 = var_03;
		}

		self method_8221("face angle",var_04.angles[1]);
	}
}

//Function Number: 18
func_22F4(param_00)
{
	self endon("death");
	self.var_2303.var_22F8 = param_00;
	self waittill(param_00 + "_finished");
	self.var_2303.var_22F8 = undefined;
}

//Function Number: 19
func_CEAA(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = 1;
	if(isdefined(param_03))
	{
		var_04 = param_03;
	}

	self.var_4C7E = ::lib_0F3D::func_22EA;
	self.var_1491.var_22E5 = param_01;
	self method_8221("face motion");
	thread func_22F4(param_01);
	var_05 = lib_0A1E::func_2336(param_00,param_01);
	if(!isdefined(var_05))
	{
		lib_0A1A::func_2330(param_01,"abort",undefined);
		return;
	}

	var_06 = var_05.var_130;
	var_07 = var_05.var_3F;
	var_08 = (0,var_06[1] - var_05.var_3E,0);
	var_09 = var_05.var_2C5;
	var_0A = var_08[1];
	if(isdefined(var_05.var_229) && isdefined(var_05.var_226))
	{
		var_0B = var_05.var_2C5 - var_05.var_229;
		var_0B = rotatevectorinverted(var_0B,var_05.var_226);
		var_0C = invertangles(var_05.var_226);
		var_0D = combineangles(var_08,var_0C);
		var_0E = self method_846B();
		var_0B = rotatevector(var_0B,var_0E.angles);
		var_09 = var_0B + var_0E.origin;
		var_0F = combineangles(var_0D,var_0E.angles);
		var_0A = var_0F[1];
	}

	var_10 = self.var_233;
	self method_8396(var_09,var_0A);
	if(isdefined(self.var_2303.var_4C86.var_4C38))
	{
		var_11 = self.var_2303.var_4C86.var_4C38;
		self method_8016(var_11);
	}
	else
	{
		self method_8016("zonly_physics",0);
	}

	lib_0A1E::func_2369(param_00,param_01,var_05.var_2C9);
	self method_806F(lib_0A1E::func_2339(),param_02);
	var_12 = 1;
	if(isdefined(var_10))
	{
		var_13 = length(var_05.var_1F3);
		var_14 = length(self.origin - var_10);
		if(var_14 > 1)
		{
			var_12 = var_13 / length(self.origin - var_10);
		}

		var_12 = clamp(var_12,0.8,1.3);
	}

	if(isdefined(self.var_22EE))
	{
		self method_82E7(param_01,var_05.var_2C9,1,param_02,self.var_BD22 * self.var_22EE * var_04 * var_12);
	}
	else
	{
		self method_82E7(param_01,var_05.var_2C9,1,param_02,self.var_BD22 * var_04 * var_12);
	}

	thread lib_0F3D::func_444B(param_01);
	lib_0A1E::func_231F(param_00,param_01);
	self.var_1491.var_BCC8 = "stop";
}

//Function Number: 20
func_7E54()
{
	if(isdefined(self.var_2303.var_4C86.var_22E3))
	{
		return self.var_2303.var_4C86.var_22E3;
	}

	return undefined;
}

//Function Number: 21
func_8174(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_04[5] = lib_0A1A::func_235C(1,param_00,param_02,param_03);
	var_04[4] = lib_0A1A::func_235C(2,param_00,param_02,param_03);
	var_04[3] = lib_0A1A::func_235C(3,param_00,param_02,param_03);
	var_04[6] = lib_0A1A::func_235C(4,param_00,param_02,param_03);
	var_04[2] = lib_0A1A::func_235C(6,param_00,param_02,param_03);
	var_04[7] = lib_0A1A::func_235C(7,param_00,param_02,param_03);
	var_04[0] = lib_0A1A::func_235C(8,param_00,param_02,param_03);
	var_04[1] = lib_0A1A::func_235C(9,param_00,param_02,param_03);
	var_04[8] = var_04[0];
	return var_04;
}

//Function Number: 22
func_814C(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_04["cover_left_arrival"]["7"] = 0.369369;
	var_04["cover_left_crouch_arrival"]["7"] = 0.321321;
	var_04["cqb_cover_left_crouch_arrival"]["7"] = 0.2002;
	var_04["cqb_cover_left_arrival"]["7"] = 0.275275;
	var_04["cover_left_arrival"]["8"] = 0.525526;
	var_04["cover_left_crouch_arrival"]["8"] = 0.448448;
	var_04["cqb_cover_left_crouch_arrival"]["8"] = 0.251251;
	var_04["cqb_cover_left_arrival"]["8"] = 0.335335;
	var_04["cover_right_arrival"]["8"] = 0.472472;
	var_04["cover_right_crouch_arrival"]["8"] = 0.248248;
	var_04["cqb_cover_right_arrival"]["8"] = 0.345345;
	var_04["cqb_cover_right_crouch_arrival"]["8"] = 0.428428;
	var_04["cover_right_arrival"]["9"] = 0.551552;
	var_04["cover_right_crouch_arrival"]["9"] = 0.2002;
	var_04["cqb_cover_right_arrival"]["9"] = 0.3003;
	var_04["cqb_cover_right_crouch_arrival"]["9"] = 0.224224;
	return var_04[param_01][param_02];
}

//Function Number: 23
func_81DF(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.var_2128[param_00].var_1FAD))
	{
		level.var_2128[param_00].var_1FAD = [];
	}

	if(!isdefined(level.var_2128[param_00].var_1FAD[param_01]))
	{
		level.var_2128[param_00].var_1FAD[param_01] = [];
	}

	if(!isdefined(level.var_2128[param_00].var_1FAD[param_01][param_02]))
	{
		var_04 = func_814C(param_00,param_01,param_02,param_03);
		var_05 = lib_0A1A::func_235C(param_02,param_01,param_03);
		level.var_2128[param_00].var_1FAD[param_01][param_02] = getmovedelta(var_05,0,var_04);
	}

	var_06 = level.var_2128[param_00].var_1FAD[param_01][param_02];
	return var_06;
}

//Function Number: 24
func_FFD4(param_00,param_01,param_02,param_03)
{
	if(!func_FFE6())
	{
		return 0;
	}

	if(!isdefined(self.var_233))
	{
		return 0;
	}

	lib_0A1A::func_238C();
	var_04 = lib_0F3D::func_7DD6();
	if(isdefined(var_04) && isdefined(var_04.type) && var_04.type == "Cover Prone" || var_04.type == "Conceal Prone")
	{
		return 0;
	}

	if(isdefined(var_04))
	{
		var_05 = undefined;
		if((scripts\common\utility::func_9EB4(var_04) && lib_0F3D::func_9D4C(param_00,param_01,undefined,"Cover Left Crouch")) || scripts\common\utility::func_9EB7(var_04) && lib_0F3D::func_9D4C(param_00,param_01,undefined,"Cover Right Crouch"))
		{
			var_05 = "crouch";
		}

		var_06 = scripts\asm\shared_utility::func_812E(var_04,var_05);
		self method_853D(var_06);
	}

	var_07 = self.var_164D[param_00].var_4BC0;
	if(!lib_0A1A::func_232B(var_07,"cover_approach"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
func_FFD5(param_00,param_01,param_02,param_03)
{
	if(!lib_0A1A::func_232B(param_01,"code_move"))
	{
		return 0;
	}

	return func_FFD4(param_00,param_01,param_02,param_03);
}

//Function Number: 26
func_1008F(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		if(!isarray(param_03))
		{
			var_04 = param_03;
		}
		else if(var_04.size < 1)
		{
			var_04 = "Exposed";
		}
		else
		{
			var_04 = var_04[0];
		}
	}
	else
	{
		var_04 = "Exposed";
	}

	if(!lib_0F3D::func_9D4C(param_00,param_01,param_02,var_04))
	{
		return 0;
	}

	var_05 = distance(self.origin,self.var_233);
	var_06 = func_7F95(var_04);
	if(var_05 > var_06)
	{
		return 0;
	}

	var_07 = 0;
	if(isdefined(param_03) && isarray(param_03) && param_03.size >= 2)
	{
		var_07 = 1;
	}

	var_08 = undefined;
	var_09 = self.var_164D[param_00].var_4BC0;
	var_0A = lib_0A1A::func_233F(var_09,"cover_approach");
	if(isdefined(var_0A))
	{
		var_08 = var_0A.var_C8F0;
	}

	self.var_2303.var_11068 = func_3721(param_00,param_01,param_02,var_04,var_07,var_08);
	if(!isdefined(self.var_2303.var_11068))
	{
		return 0;
	}

	return 1;
}

//Function Number: 27
func_10090(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03) || param_03.size < 1)
	{
		var_04 = "Exposed";
	}
	else
	{
		var_04 = var_04[0];
	}

	if(!lib_0F3D::func_9D4C(param_00,param_01,param_02,var_04))
	{
		return 0;
	}

	var_05 = distance(self.origin,self.var_233);
	var_06 = func_7F95(var_04);
	if(var_05 > var_06)
	{
		return 0;
	}

	var_07 = 0;
	if(isdefined(param_03) && param_03.size >= 2)
	{
		var_07 = 1;
	}

	var_08 = undefined;
	var_09 = lib_0A1A::func_233F(param_01,"cover_approach");
	if(isdefined(var_09))
	{
		var_08 = var_09.var_C8F0;
	}

	self.var_2303.var_11068 = func_3721(param_00,param_01,param_02,var_04,var_07,var_08);
	if(!isdefined(self.var_2303.var_11068))
	{
		return 0;
	}

	return 1;
}