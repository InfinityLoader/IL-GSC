/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3179.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 77
 * Decompile Time: 37 ms
 * Timestamp: 10/27/2023 12:26:28 AM
*******************************************************************/

//Function Number: 1
func_D55D(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	func_3E58(param_01);
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self.var_5270 = "crouch";
	scripts\anim\utility::func_12E5F();
	self endon("killanimscript");
	self method_8016("noclip");
	var_05 = self method_8148();
	self method_8221("face angle",var_05.angles[1]);
	var_05.var_126D4 = var_05.origin[2] + var_05.var_126D5;
	var_06 = var_05.var_126D4 - var_05.origin[2];
	thread func_11661(var_06 - param_03);
	param_02 = 0.15;
	var_07 = lib_0A1E::func_2339();
	self method_806F(var_07,param_02);
	self method_82E7(param_01,var_04,1,param_02,1);
	var_08 = 0.2;
	var_09 = 0.2;
	thread func_126D1(param_00,param_01);
	if(!animhasnotetrack(var_04,"gravity on"))
	{
		var_0A = 1.23;
		wait(var_0A - var_08);
		self method_8016("gravity");
		wait(var_08);
	}
	else
	{
		self waittillmatch("gravity on","traverse");
		self method_8016("gravity");
		if(!animhasnotetrack(var_04,"blend"))
		{
			wait(var_08);
		}
		else
		{
			self waittillmatch("blend","traverse");
		}
	}

	func_11701(param_00,param_01);
}

//Function Number: 2
func_D566(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	func_3E58(param_01);
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	lib_0A1B::func_296A("stand");
	var_05 = self method_8148();
	var_05.var_126D4 = var_05.origin[2] + var_05.var_126D5;
	self method_8221("face angle",var_05.angles[1]);
	self.var_126E6 = param_03;
	self.var_126EB = var_05;
	var_06 = 0;
	self method_8016("noclip");
	self.var_126EC = self.origin[2];
	if(!animhasnotetrack(var_04,"traverse_align"))
	{
		func_89F5();
	}

	var_07 = 0;
	lib_0A1E::func_2369(param_00,param_01,var_04);
	self.var_126DB = var_04;
	self.var_126DD = lib_0A1E::func_2339();
	self method_82E4(param_01,var_04,self.var_126DD,1,0.2,1);
	self.var_126E3 = 0;
	self.var_126E2 = undefined;
	lib_0A1E::func_231F(param_00,param_01,::func_89F8);
	self method_8016("gravity");
	if(self.var_EB)
	{
		func_11701(param_00,param_01);
		return;
	}

	self.var_1491.var_C043 = 0;
	if(var_07 && isdefined(self.var_205) && distancesquared(self.origin,self.var_205.origin) < 256)
	{
		self.var_1491.var_BCC8 = "stop";
		self method_83B9(self.var_205.origin);
	}
	else
	{
		self.var_1491.var_BCC8 = "run";
		self method_806F(var_04,0.2);
	}

	self.var_126DD = undefined;
	self.var_126DB = undefined;
	self.var_4E2A = undefined;
	self.var_126EB = undefined;
	func_11701(param_00,param_01);
}

//Function Number: 3
func_D55C(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	func_3E58(param_01);
	self method_8016("noclip");
	var_05 = self method_8148();
	self method_8221("face angle",var_05.angles[1]);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82E7(param_01,var_04,1,param_02,1);
	lib_0A1E::func_231F(param_00,param_01);
	func_11701(param_00,param_01);
}

//Function Number: 4
func_11701(param_00,param_01)
{
	self.var_36A = 0;
	self.var_A4CA = undefined;
	self.var_126C5 = undefined;
	self.var_126C3 = undefined;
	var_02 = level.var_2303[param_00].var_10E2F[param_01];
	var_03 = undefined;
	if(isdefined(var_02.var_116FB))
	{
		if(isarray(var_02.var_116FB[0]))
		{
			var_03 = var_02.var_116FB[0];
		}
		else
		{
			var_03 = var_02.var_116FB;
		}
	}

	var_04 = isdefined(var_02.var_1267B) && var_02.var_1267B.size > 0;
	if(!var_04 && !isdefined(var_03))
	{
		var_03 = "exposed_idle";
	}

	if(isdefined(var_03))
	{
		thread lib_0A1A::func_237C(var_03,undefined);
	}
	else
	{
		lib_0A1A::func_2330(param_01,"traverse_end");
	}

	self notify("killanimscript");
}

//Function Number: 5
func_11661(param_00)
{
	self endon("killanimscript");
	self notify("endTeleportThread");
	self endon("endTeleportThread");
	var_01 = 5;
	var_02 = (0,0,param_00 / var_01);
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		self method_80F1(self.origin + var_02);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 6
func_11662(param_00,param_01,param_02,param_03)
{
	self endon("killanimscript");
	self endon("death");
	self notify("endTeleportThread");
	self endon("endTeleportThread");
	if(param_00 == 0 || param_02 <= 0)
	{
		return;
	}

	if(param_01 > 0)
	{
		wait(param_01);
	}

	var_04 = (0,0,param_00 / param_02);
	if(isdefined(param_03) && param_03 < 1)
	{
		self method_82B1(self.var_126DB,param_03);
	}

	for(var_05 = 0;var_05 < param_02;var_05++)
	{
		self method_80F1(self.origin + var_04);
		scripts\common\utility::func_136F7();
	}

	if(isdefined(param_03) && param_03 < 1)
	{
		self method_82B1(self.var_126DB,1);
	}
}

//Function Number: 7
func_89F8(param_00)
{
	if(param_00 == "traverse_death")
	{
		return func_89F6();
	}

	if(param_00 == "traverse_align")
	{
		return func_89F5();
	}

	if(param_00 == "traverse_drop")
	{
		return func_89F7();
	}
}

//Function Number: 8
func_89F6()
{
	if(isdefined(self.var_126E2))
	{
		var_00 = self.var_126E2[self.var_126E3];
		self.var_4E2A = var_00[randomint(var_00.size)];
		self.var_126E3++;
	}
}

//Function Number: 9
func_89F5()
{
	self method_8016("noclip");
	if(isdefined(self.var_126E6) && isdefined(self.var_126EB.var_126D4))
	{
		var_00 = self.var_126EB.var_126D4 - self.var_126EC;
		thread func_11661(var_00 - self.var_126E6);
	}
}

//Function Number: 10
func_89F7()
{
	var_00 = self.origin + (0,0,32);
	var_01 = physicstrace(var_00,self.origin + (0,0,-512));
	var_02 = distance(var_00,var_01);
	var_03 = var_02 - 32 - 0.5;
	var_04 = self method_8102(self.var_126DB);
	var_05 = getmovedelta(self.var_126DB,var_04,1);
	var_06 = getanimlength(self.var_126DB);
	var_07 = var_04 * var_06;
	var_08 = 0 - var_05[2];
	var_09 = var_08 - var_03;
	if(var_08 < var_03)
	{
		var_0A = var_08 / var_03;
	}
	else
	{
		var_0A = 1;
	}

	var_0B = var_06 - var_04 / 3;
	var_0C = var_06 - var_07 / 3;
	var_0D = ceil(var_0C * 20);
	thread func_11662(var_09,0,var_0D,var_0A);
	thread func_6CE5(var_01[2]);
}

//Function Number: 11
func_6CE5(param_00)
{
	self endon("killanimscript");
	self endon("death");
	param_00 = param_00 + 4;
	for(;;)
	{
		if(self.origin[2] < param_00)
		{
			self method_8016("gravity");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 12
func_D55E(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("terminate_ai_threads");
	self endon(param_01 + "_finished");
	var_04 = getdvarint("ai_debug_doublejump",0);
	if(var_04 != 3 && var_04 != 4)
	{
		func_3E58(param_01);
	}

	self.var_DC1A = 1;
	var_05 = self method_8148();
	var_06 = self method_8146();
	var_05.var_126D4 = var_05.origin[2] + var_05.var_126D5 - 44;
	var_07 = [];
	if(var_05.var_126D4 > var_06[2])
	{
		var_08 = var_05.origin[0] + var_06[0] * 0.5;
		var_09 = var_05.origin[1] + var_06[1] * 0.5;
		var_07[var_07.size] = (var_08,var_09,var_05.var_126D4);
	}

	var_07[var_07.size] = var_06;
	var_0B = spawn("script_model",var_05.origin);
	var_0B setmodel("tag_origin");
	var_0B.angles = var_05.angles;
	thread scripts\common\utility::func_5179(var_0B);
	self method_8221("face angle",var_05.angles[1]);
	var_0C = 1.63;
	self linkto(var_0B);
	var_0D = lib_0A1E::func_2336(param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),0.2);
	lib_0A1E::func_2369(param_00,param_01,var_0D);
	self method_82EA(param_01,var_0D,1,param_02,1);
	thread func_126D1(param_00,param_01);
	foreach(var_0F in var_07)
	{
		var_10 = var_0C / var_07.size;
		var_0B moveto(var_0F,var_10);
		var_0B waittill("movedone");
	}

	self notify("double_jumped");
	self unlink();
	self.var_DC1A = undefined;
	var_0B delete();
	thread func_11701(param_00,param_01);
}

//Function Number: 13
func_126D2(param_00,param_01,param_02)
{
	self unlink();
	self.var_DC1A = undefined;
}

//Function Number: 14
func_D565(param_00,param_01,param_02,param_03)
{
	var_04 = self method_8148();
	var_05 = self method_8145();
	func_3E58(param_01);
	var_06 = distance(var_04.origin,var_05.origin);
	self method_8016("noclip");
	self method_8221("face angle",var_04.angles[1]);
	var_07 = lib_0A1E::func_2336(param_00,param_01);
	var_08 = getanimlength(var_07);
	var_09 = getmovedelta(var_07);
	var_0A = length(var_09) / var_08;
	var_0B = var_06 / var_0A;
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_07,1,param_02,1);
	wait(var_0B);
	func_11701(param_00,param_01);
}

//Function Number: 15
func_126D1(param_00,param_01)
{
	self endon("death");
	self endon("terminate_ai_threads");
	self endon(param_01 + "_finished");
	self endon("double_jumped");
	lib_0A1E::func_231F(param_00,param_01);
}

//Function Number: 16
func_D560(param_00,param_01,param_02,param_03)
{
	self waittill("external_traverse_complete");
	func_11701(param_00,param_01);
}

//Function Number: 17
func_CF1E(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self method_8016("noclip");
	self method_8221("face angle",self.angles[1]);
	self.var_36A = 1;
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self method_82E7(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	lib_0A1E::func_231F(param_00,param_01);
	thread func_11701(param_00,param_01);
}

//Function Number: 18
func_7E83(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = lib_0F3D::func_3E96(param_00,param_01);
	var_06 = getnotetracktimes(var_05,param_04);
	var_07 = var_06[0];
	var_08 = getmovedelta(var_05,0,var_07);
	var_09 = getangledelta(var_05,0,var_07);
	return lib_0C5E::func_36D9(param_02,param_03[1],var_08,var_09);
}

//Function Number: 19
func_5AE3(param_00,param_01,param_02,param_03)
{
	var_04 = param_03[2] - param_02.origin[2];
	if(var_04 < 0)
	{
		return 0;
	}

	if(isdefined(param_02.var_A4C9) && getdvarint("ai_debug_doublejump",0) != 2)
	{
		var_05 = param_02.var_A4C9;
		var_06 = param_02.angles - param_02.var_10DCE;
		if(var_06 != (0,0,0))
		{
			var_05 = rotatevector(var_05,var_06);
		}

		var_07 = param_02.origin + var_05;
		var_08 = var_07[2];
		var_08 = var_08 - 44;
		if(param_03[2] < var_08)
		{
			return 0;
		}
	}

	var_09 = param_03 - param_02.origin;
	var_09 = (var_09[0],var_09[1],0);
	var_0A = vectortoangles(var_09);
	var_0B = func_7E83(param_00,param_01,param_03,var_0A,"footstep_left_small");
	var_0C = var_0B - param_02.origin;
	if(vectordot(var_0C,var_09) < 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
func_3E04(param_00,param_01,param_02,param_03)
{
	var_04 = func_81D8();
	if(!isdefined(var_04))
	{
		thread func_11701(param_00,"double_jump");
		return 0;
	}

	var_05 = func_81D7();
	if(!func_5AE3(param_00,param_02,var_04,var_05))
	{
		thread func_11701(param_00,"double_jump");
		return 0;
	}

	return 1;
}

//Function Number: 21
func_81D8()
{
	if(isdefined(self.var_126C5))
	{
		return self.var_126C5;
	}

	return self method_8148();
}

//Function Number: 22
func_81D7()
{
	if(isdefined(self.var_126C3))
	{
		return self.var_126C3;
	}

	return self method_8146();
}

//Function Number: 23
func_CF21(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = func_81D8();
	var_05 = var_04.var_5AE2;
	var_06 = var_05 - var_04.origin;
	var_06 = (var_06[0],var_06[1],0);
	var_07 = vectortoangles(var_06);
	var_08 = lib_0A1E::func_2336(param_00,param_01);
	var_09 = param_01 + "_finish";
	var_0A = func_7E83(param_00,var_09,var_05,var_07,"mantle_align");
	var_0A = (var_0A[0],var_0A[1],var_0A[2] + param_03);
	func_D50F(param_00,param_01,var_08,param_02,var_0A,var_07,1,0,1);
}

//Function Number: 24
func_CF1F(param_00,param_01,param_02,param_03)
{
	func_CF21(param_00,param_01,param_02,-8);
}

//Function Number: 25
func_CF26(param_00,param_01,param_02,param_03)
{
	func_CF21(param_00,param_01,param_02,-42);
}

//Function Number: 26
doublejumpterminate(param_00,param_01,param_02)
{
	self.var_36A = 0;
	self.var_A4CA = undefined;
	self.var_126C5 = undefined;
	self.var_126C3 = undefined;
}

//Function Number: 27
doublejumpearlyterminate(param_00,param_01,param_02)
{
	if(!lib_0A1A::func_232B(param_01,"end"))
	{
		doublejumpterminate(param_00,param_01,param_02);
	}
}

//Function Number: 28
func_9DCA(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_68B0(param_00,param_01,param_02,"end");
}

//Function Number: 29
func_CF24(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = func_81D8();
	var_05 = func_81D7();
	var_06 = var_04.angles - var_04.var_10DCE;
	if(var_06 != (0,0,0))
	{
		var_05 = rotatevector(var_05,var_06);
	}

	var_07 = undefined;
	var_08 = getdvarint("ai_debug_doublejump",0);
	if(var_08 != 2)
	{
		if(isdefined(var_04.var_A4C9))
		{
			var_09 = var_04.var_A4C9;
			if(var_06 != (0,0,0))
			{
				var_09 = rotatevector(var_09,var_06);
			}

			var_07 = var_04.origin + var_09;
			var_0A = var_07[2];
			var_0A = var_0A - 44;
			if(var_0A > var_05[2])
			{
				var_0B = var_04.origin[0] + var_05[0] * 0.5;
				var_0C = var_04.origin[1] + var_05[1] * 0.5;
				var_07 = (var_0B,var_0C,var_07[2]);
			}
			else
			{
				var_07 = undefined;
			}
		}
	}

	var_0D = lib_0A1E::func_2336(param_00,param_01);
	self.var_A4CA = var_07;
	var_0E = param_01 + "_finish";
	if(func_5AE3(param_00,var_0E,var_04,var_05))
	{
		var_0F = var_05 - var_04.origin;
		var_0F = (var_0F[0],var_0F[1],0);
		var_10 = vectortoangles(var_0F);
		var_0E = param_01 + "_finish";
		var_11 = func_7E83(param_00,var_0E,var_05,var_10,"footstep_left_small");
		var_05 = var_11;
	}

	var_0F = var_05 - var_04.origin;
	var_12 = 0;
	var_13 = 1;
	if(var_0F[2] < 0)
	{
		var_12 = 1;
		var_14 = getnotetracktimes(var_0D,"gravity on");
		if(isdefined(var_14) && var_14.size > 0)
		{
			var_13 = var_14[0];
		}
	}

	var_0F = (var_0F[0],var_0F[1],0);
	var_10 = vectortoangles(var_0F);
	func_D50F(param_00,param_01,var_0D,param_02,var_05,var_10,var_13,var_12,1);
}

//Function Number: 30
func_3ED2(param_00,param_01,param_02)
{
	var_03 = func_81D7();
	var_04 = "double_jump_up";
	if(isdefined(param_02))
	{
		var_04 = "double_jump_" + param_02;
	}
	else if(var_03[2] < self.origin[2])
	{
		var_04 = "double_jump_down";
	}

	if(self.var_2303.var_7257.var_7254 == "right")
	{
		var_05 = "right_";
	}
	else
	{
		var_05 = "left_";
	}

	var_04 = var_05 + var_04;
	var_06 = lib_0A1A::func_2358(param_01,var_04);
	return var_06;
}

//Function Number: 31
func_820D(param_00,param_01)
{
	var_02 = param_00.angles - param_00.var_138A6.var_10DCE;
	if(var_02 != (0,0,0))
	{
		var_03 = rotatevector(param_00.var_138A6.var_C050[param_01],var_02);
		var_04 = param_00.origin + var_03;
	}
	else
	{
		var_04 = param_01.origin + param_01.var_138A6.var_C050[var_02];
	}

	return var_04;
}

//Function Number: 32
func_100BF(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	var_04 = self.var_10C.origin;
	var_05 = self.var_126C5;
	var_06 = func_820D(var_05,self.var_138BA);
	var_07 = func_820D(var_05,self.var_138BA + 1);
	var_07 = (var_07[0],var_07[1],var_06[2]);
	var_04 = (var_04[0],var_04[1],var_06[2]);
	var_08 = vectornormalize(var_07 - var_06);
	var_09 = vectornormalize(var_04 - var_06);
	var_0A = vectordot(var_08,var_09);
	if(var_0A < 0.2588)
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
func_3F0E(param_00,param_01,param_02)
{
	var_03 = lib_0A1A::func_2358(param_01,self.var_138BC);
	return var_03;
}

//Function Number: 34
func_812B(param_00)
{
	return param_00 * param_00 * 3 - 2 * param_00;
}

//Function Number: 35
func_11657(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon(param_00 + "_finished");
	if(param_01 > 0)
	{
		wait(param_01);
	}

	var_06 = param_02 / param_03;
	var_07 = self.origin[2];
	var_08 = var_07 + param_02[2];
	var_09 = self.origin[2];
	self method_82B1(param_04,param_05);
	for(var_0A = 0;var_0A < param_03;var_0A++)
	{
		var_0B = 1;
		if(var_0B)
		{
			var_0C = var_0A / param_03 - 1;
			var_0D = func_812B(var_0C);
			var_0E = var_08 * var_0D + var_07 * 1 - var_0D;
			var_0F = var_0E - var_09;
			var_06 = (var_06[0],var_06[1],var_0F);
			var_09 = var_0E;
		}

		var_10 = self.origin + var_06;
		self method_80F1(var_10);
		if(var_0A + 1 < param_03)
		{
			scripts\common\utility::func_136F7();
		}
	}

	self method_82B1(param_04,1);
}

//Function Number: 36
func_138D4(param_00,param_01)
{
	if(param_00 == "start_jump")
	{
		thread func_89BB(param_01);
		return;
	}

	if(param_00 == "end_mantle")
	{
		self method_8016("gravity");
	}
}

//Function Number: 37
func_89BB(param_00,param_01,param_02)
{
	var_03 = param_00[0];
	var_04 = param_00[1];
	var_05 = param_00[2];
	var_06 = param_00[3];
	var_07 = param_00[4];
	var_08 = param_00[5];
	var_09 = param_00[6];
	self endon(var_03 + "_finished");
	var_0A = getanimlength(var_04);
	if(!isdefined(param_01))
	{
		param_01 = gettime() - var_06 * 0.001;
	}

	var_0B = param_01 / var_0A;
	var_0C = getnotetracktimes(var_04,"end_jump");
	var_0D = getnotetracktimes(var_04,"end_double_jump");
	if(var_0D.size > 0)
	{
		self.var_138BD = 1;
		var_0C = var_0D;
	}
	else
	{
		self.var_138BD = 0;
	}

	if(isdefined(self.var_A4CA))
	{
		var_07 = var_0C[0] - var_0B / 2 + var_0B;
		var_0C[0] = var_07;
		var_05 = self.var_A4CA;
	}

	var_0E = getmovedelta(var_04,var_0B,var_07);
	var_0F = self method_81E7(var_0E);
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(var_09)
	{
		var_10 = distance(self.origin,var_0F);
		var_11 = distance(self.origin,var_05);
		param_02 = var_10 / var_11;
		if(param_02 < 0.7)
		{
			param_02 = 0.7;
		}
		else if(param_02 > 1.3)
		{
			param_02 = 1.3;
		}
	}

	var_13 = var_05 - var_0F;
	var_14 = var_0C[0] * var_0A;
	var_15 = var_14 - var_0B * var_0A;
	var_15 = var_15 * 1 / param_02;
	var_16 = var_15 * 20;
	var_16 = ceil(var_16);
	var_17 = gettime();
	func_11657(var_03,0,var_13,var_16,var_04,param_02);
	if(isdefined(self.var_A4CA))
	{
		var_18 = gettime() - var_17 * param_02;
		var_19 = param_01 + var_18 * 0.001;
		self.var_A4CA = undefined;
		param_00[6] = 0;
		func_89BB(param_00,var_19,param_02);
	}
}

//Function Number: 38
func_8213(param_00)
{
	var_01 = func_820D(param_00,1) - func_820D(param_00,0);
	var_02 = vectortoangles(var_01);
	return var_02[1];
}

//Function Number: 39
func_820F(param_00)
{
	self.var_138BA = 0;
	var_01 = func_820D(param_00,1) - func_820D(param_00,0);
	var_02 = vectortoangles(var_01);
	self.var_138C1 = var_02[1];
	var_03 = func_820D(param_00,self.var_138BA);
	var_04 = anglestoright(var_02);
	var_05 = var_03 - param_00.origin;
	var_06 = vectordot(var_04,var_05);
	if(var_06 > 0)
	{
		return "right";
	}

	return "left";
}

//Function Number: 40
func_FAF8()
{
	if(isdefined(self.var_138BC))
	{
		return;
	}

	if(!isdefined(self.var_126C5))
	{
		self.var_126C5 = self method_8148();
		self.var_126C3 = self method_8146();
	}

	var_00 = self.var_126C5;
	self.var_138BC = func_820F(var_00);
}

//Function Number: 41
func_820E()
{
	func_FAF8();
	return self.var_138BC;
}

//Function Number: 42
wallrunterminate(param_00,param_01,param_02)
{
	self.var_138BA = undefined;
	self.var_138BC = undefined;
	self.var_138BD = undefined;
	self.var_138C1 = undefined;
	self.var_138B9 = undefined;
	self method_82D0();
	self.var_36A = 0;
	self.var_A4CA = undefined;
	self.var_126C5 = undefined;
	self.var_126C3 = undefined;
}

//Function Number: 43
traversalorientearlyterminate(param_00,param_01,param_02)
{
	if(!lib_0A1A::func_232B(param_01,"end") && !lib_0A1A::func_232B(param_01,"code_move"))
	{
		func_4123(param_00,param_01,param_02);
	}
}

//Function Number: 44
func_D5CF(param_00,param_01,param_02,param_03)
{
	self method_8016("noclip");
	self method_8221("face angle",self.angles[1]);
	self.var_36A = 1;
	if(isdefined(param_03) && param_03 == "shoot")
	{
		func_FAF7();
	}

	var_04 = lib_0A1E::func_2336(param_00,param_01);
	var_05 = getnotetracktimes(var_04,"wall_contact");
	var_06 = var_05[0];
	var_07 = getangledelta(var_04,0,var_06);
	var_08 = self.var_138C1 - var_07;
	var_09 = (0,var_08,0);
	self method_80F1(self.origin,var_09);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82E7(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	var_0A = lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
	if(var_0A == "end")
	{
		thread lib_0A1A::func_2310(param_00,param_01,0);
	}
}

//Function Number: 45
func_820C(param_00)
{
	var_01 = func_3F0D(param_00,"wall_run_attach");
	var_02 = getnotetracktimes(var_01,"wall_contact");
	var_03 = var_02[0];
	var_04 = getmovedelta(var_01,0,var_03);
	var_05 = getangledelta(var_01,0,var_03);
	return lib_0C5E::func_36D9(func_820D(self.var_126C5,0),self.var_138C1,var_04,var_05);
}

//Function Number: 46
func_D5D2(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	var_05 = self.var_126C5;
	self.var_138BA = 0;
	var_06 = func_820D(var_05,0);
	var_07 = var_06 - self.origin;
	var_07 = (var_07[0],var_07[1],0);
	var_08 = vectortoangles(var_07);
	var_09 = func_820C();
	self method_8221("face angle",var_08[1]);
	var_0A = 1;
	var_0B = getnotetracktimes(var_04,"code_move");
	if(isdefined(var_0B) && var_0B.size > 0)
	{
		var_0A = var_0B[0];
	}

	func_D50F(param_00,param_01,var_04,param_02,var_09,var_08,var_0A,0,1);
	self method_80F1(var_09,var_08);
	thread lib_0A1A::func_2310(param_00,param_01,0);
}

//Function Number: 47
func_D50F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon(param_01 + "_finished");
	if(!isdefined(param_06))
	{
		param_06 = 1;
	}

	if(!isdefined(param_07))
	{
		param_07 = 0;
	}

	if(!isdefined(param_08))
	{
		param_08 = 0;
	}

	self method_80F1(self.origin,param_05);
	self method_8016("noclip");
	self method_8221("face angle",param_05[1]);
	var_09 = getanimlength(param_02);
	var_0A = int(var_09 * 1000);
	self method_85A1(gettime() + var_0A - 1000);
	self.var_36A = 1;
	self method_82E7(param_01,param_02,1,param_03,1);
	lib_0A1E::func_2369(param_00,param_01,param_02);
	var_0B = [param_01,param_02,param_04,gettime(),param_06,param_07,param_08];
	lib_0A1E::func_231F(param_00,param_01,::func_138D4,var_0B);
}

//Function Number: 48
func_3F0D(param_00,param_01,param_02)
{
	if(isdefined(self.var_138B9))
	{
		return self.var_138B9;
	}

	var_03 = self.var_138BC;
	var_04 = angleclamp180(self.var_138C1 - self.angles[1]);
	var_04 = abs(var_04);
	if(var_04 >= 22.5)
	{
		if(var_04 > 67.5)
		{
			var_03 = var_03 + "_90";
		}
		else
		{
			var_03 = var_03 + "_45";
		}
	}

	self.var_138B9 = lib_0A1A::func_2358(param_01,var_03);
	return self.var_138B9;
}

//Function Number: 49
func_3F0F(param_00,param_01,param_02)
{
	func_FAF8();
	var_03 = self.var_138BC;
	var_04 = self.var_126C5;
	var_05 = func_820D(var_04,0);
	var_06 = var_05[2] - self.origin[2];
	var_07 = 0;
	if(var_06 >= 0)
	{
		if(var_06 > 120)
		{
			var_07 = 1;
		}
	}
	else if(0 - var_06 > 240)
	{
		var_07 = 1;
	}

	if(var_07 == 0)
	{
		var_08 = distancesquared(self.origin,var_05);
		if(var_08 > -25536)
		{
			var_07 = 1;
		}
	}

	var_09 = "left_";
	if(self.var_2303.var_7257.var_7254 == "right")
	{
		var_09 = "right_";
	}

	if(var_07)
	{
		var_03 = var_09 + "double_jump";
	}
	else
	{
		var_03 = var_09 + "single_jump";
	}

	var_0A = lib_0A1A::func_2358(param_01,var_03);
	return var_0A;
}

//Function Number: 50
func_F22D(param_00,param_01,param_02,param_03)
{
	self endon(param_00 + "_finished");
	wait(param_01);
	lib_0A1A::func_2330(param_00,param_02);
	if(param_03)
	{
		self notify(param_02);
	}
}

//Function Number: 51
func_8BCB(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_138BA))
	{
		return 0;
	}

	var_04 = self.var_126C5;
	if(!isdefined(var_04))
	{
		return 0;
	}

	var_05 = self.var_138BA + 2;
	if(var_04.var_138A6.var_C050.size <= var_05)
	{
		return 0;
	}

	return 1;
}

//Function Number: 52
func_D5D0(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self.var_126C5;
	scripts\anim\combat::func_F296();
	self.var_138BA = self.var_138BA + 2;
	var_05 = func_820D(var_04,self.var_138BA);
	var_06 = self.angles;
	if(self.var_138BC == "left")
	{
		self.var_138BC = "right";
	}
	else
	{
		self.var_138BC = "left";
	}

	var_07 = lib_0A1E::func_2336(param_00,param_01);
	func_D50F(param_00,param_01,var_07,param_02,var_05,var_06);
}

//Function Number: 53
func_8211(param_00)
{
	var_01 = param_00.angles - param_00.var_138A6.var_10DCE;
	if(var_01 == (0,0,0))
	{
		return param_00.origin + param_00.var_138A6.var_B313;
	}

	var_02 = rotatevector(param_00.var_138A6.var_B313,var_01);
	return param_00.origin + var_02;
}

//Function Number: 54
func_8210(param_00)
{
	if(!isdefined(param_00.var_138A6.var_B312))
	{
		return undefined;
	}

	var_01 = param_00.angles[1] - param_00.var_138A6.var_10DCE[1];
	if(var_01 == 0)
	{
		return param_00.var_138A6.var_B312;
	}

	return (0,angleclamp180(param_00.var_138A6.var_B312[1] + var_01),0);
}

//Function Number: 55
func_8212()
{
	var_00 = self.var_126C5;
	if(!isdefined(var_00.var_138A6.var_B313))
	{
		return "none";
	}

	var_01 = func_8211(var_00);
	if(var_01[2] >= self.origin[2])
	{
		return "high";
	}

	return "low";
}

//Function Number: 56
func_100C0(param_00,param_01,param_02,param_03)
{
	var_04 = self.var_126C5;
	if(!isdefined(var_04.var_138A6.var_331A))
	{
		return 0;
	}

	return var_04.var_138A6.var_331A;
}

//Function Number: 57
func_D5D4(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self.var_126C5;
	func_FAF7();
	var_05 = lib_0A1E::func_2336(param_00,param_01);
	var_06 = getmovedelta(var_05);
	var_07 = length2d(var_06);
	if(!isdefined(var_04.var_138A6.var_B313) && self.var_138BA == var_04.var_138A6.var_C050.size - 2)
	{
		var_08 = lib_0A1E::func_2336(param_00,"wall_run_exit");
		var_09 = getnotetracktimes(var_08,"start_jump");
		var_0A = getanimlength(var_08);
		var_0B = getmovedelta(var_08,0,var_09[0]);
		var_0C = length2d(var_0B);
	}
	else
	{
		var_0C = 0;
	}

	var_0D = func_820D(var_04,self.var_138BA + 1) - self.origin;
	var_0E = length(var_0D);
	var_0E = var_0E - var_0C;
	if(var_0E < 0)
	{
		var_0E = 0;
	}

	var_0F = var_0E / var_07;
	var_10 = getanimlength(var_05);
	var_11 = var_10 * var_0F;
	thread func_F22D(param_01,var_11,"wall_run_loop_done",1);
	var_12 = vectornormalize(var_0D);
	self method_8221("face direction",var_12);
	thread func_D5D1(param_01);
	self method_8016("noclip");
	self method_82E7(param_01,var_05,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_05);
	lib_0A1E::func_231F(param_00,param_01);
}

//Function Number: 58
func_D5D1(param_00)
{
	self endon("death");
	if(soundexists("wallrun_end_npc"))
	{
		self waittill("wall_run_loop_done");
		self playsound("wallrun_end_npc");
	}
}

//Function Number: 59
func_3F10(param_00,param_01,param_02)
{
	var_03 = self.var_138BC;
	var_04 = self.var_126C3;
	var_05 = var_04[2] - self.origin[2];
	var_06 = 0;
	if(var_05 >= 0)
	{
		if(var_05 > 120)
		{
			var_06 = 1;
		}
	}
	else if(0 - var_05 > 240)
	{
		var_06 = 1;
	}

	if(var_06 == 0)
	{
		var_07 = distancesquared(self.origin,var_04);
		if(var_07 > -19311)
		{
			var_06 = 1;
		}
	}

	if(var_06)
	{
		var_03 = var_03 + "_double";
	}

	var_04 = self.var_126C3;
	var_08 = self.var_126C5;
	var_09 = self.var_126C3 - func_820D(var_08,var_08.var_138A6.var_C050.size - 1);
	var_09 = (var_09[0],var_09[1],0);
	var_09 = vectornormalize(var_09);
	var_0A = vectortoangles(var_09);
	var_0B = angleclamp180(var_0A[1] - self.angles[1]);
	var_0B = abs(var_0B);
	if(var_0B >= 22.5)
	{
		if(var_0B > 67.5)
		{
			var_03 = var_03 + "_90";
		}
		else
		{
			var_03 = var_03 + "_45";
		}
	}

	var_0C = lib_0A1A::func_2358(param_01,var_03);
	return var_0C;
}

//Function Number: 60
func_D5D3(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self.var_126C5;
	var_05 = self.var_126C3;
	var_06 = self.angles;
	var_07 = 1;
	var_08 = lib_0A1E::func_2336(param_00,param_01);
	var_09 = getnotetracktimes(var_08,"ground");
	scripts\anim\combat::func_F296();
	if(isdefined(var_09) && var_09.size > 0)
	{
		var_07 = var_09[0];
	}
	else
	{
		var_0A = getnotetracktimes(var_08,"end_double_jump");
		if(isdefined(var_0A) && var_0A.size > 0)
		{
			var_07 = var_0A[0];
		}
		else
		{
			var_0B = getnotetracktimes(var_08,"end_jump");
			if(isdefined(var_0B) && var_0B.size > 0)
			{
				var_07 = var_0B[0];
			}
		}
	}

	if(soundexists("wallrun_end_npc"))
	{
		self playsound("wallrun_end_npc");
	}

	func_D50F(param_00,param_01,var_08,param_02,var_05,var_06,var_07,1,1);
	thread func_11705(param_00,param_01);
}

//Function Number: 61
func_9EBA(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_126C5))
	{
		return 0;
	}

	return 1;
}

//Function Number: 62
func_11705(param_00,param_01)
{
	self.var_138BA = undefined;
	self.var_138BC = undefined;
	self.var_138BD = undefined;
	self.var_138C1 = undefined;
	self.var_138B9 = undefined;
	self method_82D0();
	func_11701(param_00,param_01);
}

//Function Number: 63
func_D5D5(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self.var_126C5;
	var_05 = self.var_126C3;
	var_06 = func_8211(var_04);
	if(isdefined(var_04.var_138A6.var_331A) || func_8212() == "high")
	{
		var_07 = func_8210(var_04);
		if(!isdefined(var_07))
		{
			var_08 = var_05 - var_06;
			var_08 = (var_08[0],var_08[1],0);
			var_07 = vectortoangles(var_08);
		}
	}
	else
	{
		var_08 = var_07 - self.origin;
		var_08 = (var_08[0],var_08[1],0);
		var_07 = vectortoangles(var_08);
	}

	var_09 = lib_0A1E::func_2336(param_00,param_01);
	var_0A = getanimlength(var_09);
	var_0B = getnotetracktimes(var_09,"start_mantle");
	var_0C = var_0B[0];
	var_0D = getnotetracktimes(var_09,"end_mantle");
	var_0E = var_0D[0];
	var_0F = getmovedelta(var_09,var_0C,var_0E);
	self method_80F1(self.origin,var_07);
	var_10 = self method_81E7(var_0F);
	var_11 = var_10 - self.origin;
	var_12 = var_06 - var_11;
	func_D50F(param_00,param_01,var_09,param_02,var_12,var_07,var_0C,0,1);
	thread func_11705(param_00,param_01);
}

//Function Number: 64
func_D55B(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	if(!isdefined(var_04))
	{
		lib_0A1A::func_2330(param_01,"code_move");
		return;
	}

	var_05 = 1;
	var_06 = undefined;
	if(getdvarint("ai_wall_run_use_align_notetrack",1) == 1)
	{
		var_06 = getnotetracktimes(var_04,"align");
	}

	if(!isdefined(var_06) || var_06.size == 0)
	{
		var_06 = getnotetracktimes(var_04,"code_move");
	}

	if(isdefined(var_06) && var_06.size > 0)
	{
		var_05 = var_06[0];
	}

	var_07 = getmovedelta(var_04,0,var_05);
	var_08 = getangledelta(var_04,0,var_05);
	var_09 = self.var_126C5;
	var_0A = getanimlength(var_04) * var_05;
	var_0B = int(ceil(var_0A * 20));
	if(self.var_126C5.var_48 == "wall_run")
	{
		var_0C = func_820D(self.var_126C5,0) - self.origin;
		var_0D = vectortoangles(var_0C);
		var_0E = var_0D[1];
	}
	else
	{
		var_0F = self.var_126C3 - self.var_126C5.origin;
		var_0F = (var_0F[0],var_0F[1],0);
		var_10 = vectortoangles(var_0F);
		var_0E = var_10[1];
	}

	var_11 = lib_0C5E::func_36D9(var_09.origin,var_0E,var_07,var_08);
	var_12 = var_0E - var_08;
	self.var_4C7E = ::lib_0F3D::func_22EA;
	self.var_1491.var_22E5 = param_01;
	self.var_36A = 1;
	self method_8396(var_11,var_12,var_0B);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82E7(param_01,var_04,1,param_02,1);
	lib_0A1E::func_2369(param_00,param_01,var_04);
	lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
	thread lib_0A1A::func_2310(param_00,param_01,0);
}

//Function Number: 65
func_3F12(param_00,param_01,param_02)
{
	return lib_0C65::func_3EF5(param_00,param_01,param_02);
}

//Function Number: 66
func_3F07(param_00,param_01,param_02)
{
	var_03 = anglestoforward(self.angles);
	var_04 = vectortoangles(var_03);
	if(self.var_126C5.var_48 == "wall_run")
	{
		var_05 = vectortoangles(func_820D(self.var_126C5,0) - self.origin);
	}
	else
	{
		var_06 = self.var_126C3 - self.var_126C5.origin;
		var_06 = (var_06[0],var_06[1],0);
		var_05 = vectortoangles(var_06);
	}

	var_07 = var_05[1];
	var_08 = angleclamp180(var_07 - var_04[1]);
	var_09 = function_02F9(var_08,22.5);
	var_0A = lib_0C5D::func_8174(param_01,undefined,1);
	if(!isdefined(var_0A[var_09]))
	{
		return undefined;
	}

	return var_0A[var_09];
}

//Function Number: 67
func_FAF0(param_00,param_01,param_02,param_03)
{
	var_04 = self method_84F9(120);
	if(!isdefined(var_04))
	{
		return 0;
	}

	var_05 = var_04["node"];
	var_06 = var_04["position"];
	if(!isdefined(var_05) || !isdefined(var_05.var_48))
	{
		return 0;
	}

	self.var_126C5 = var_05;
	self.var_126C3 = var_06;
	return 1;
}

//Function Number: 68
func_4123(param_00,param_01,param_02,param_03)
{
	self.var_126C5 = undefined;
	self.var_126C3 = undefined;
	self.var_138BC = undefined;
	return 0;
}

//Function Number: 69
func_FFB7(param_00,param_01,param_02,param_03)
{
	var_04 = distance2dsquared(self.origin,func_820D(self.var_126C5,1));
	if(var_04 < 144)
	{
		return 1;
	}

	return 0;
}

//Function Number: 70
func_FFFD(param_00,param_01,param_02,param_03)
{
	if(func_9EBA(param_00,param_01,param_02,param_03))
	{
		func_FAF0(param_00,param_01,param_02,param_03);
		if(!isdefined(self.var_126C5))
		{
			return 0;
		}

		if(self.var_126C5.var_48 != "wall_run")
		{
			return 0;
		}

		var_04 = self.var_126C5;
		var_05 = vectornormalize(func_820D(var_04,0) - self.origin);
		var_06 = lib_0C65::func_371C(param_01,param_02,var_05,0,1);
		if(!isdefined(var_06))
		{
			return 0;
		}

		self.var_1491.var_FC61 = var_06;
		self.var_138BC = func_820F(self.var_126C5);
		return 1;
	}

	return 0;
}

//Function Number: 71
func_100B3(param_00,param_01,param_02,param_03)
{
	if(param_02 == self.var_126C5.var_48)
	{
		return 1;
	}

	return 0;
}

//Function Number: 72
func_9FB1(param_00)
{
	switch(param_00)
	{
		case "rail_hop_double_jump_down":
		case "double_jump":
		case "double_jump_mantle":
		case "double_jump_vault":
		case "wall_run":
			return 1;
	}

	return 0;
}

//Function Number: 73
func_FFFC(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_126C5))
	{
		return 0;
	}

	if(!func_9FB1(self.var_126C5.var_48))
	{
		return 0;
	}

	if(!self.var_12A)
	{
		return 0;
	}

	var_04 = undefined;
	if(self.var_126C5.var_48 == "wall_run")
	{
		var_04 = func_820F(self.var_126C5);
		var_05 = func_820D(self.var_126C5,0) - self.origin;
		var_06 = vectortoangles(var_05);
	}
	else
	{
		var_05 = self.var_126C3 - self.var_126C5.origin;
		var_06 = (var_06[0],var_06[1],0);
		var_05 = vectornormalize(var_06);
		var_06 = vectortoangles(var_05);
	}

	var_07 = var_06[1];
	var_08 = anglestoforward(self.angles);
	var_09 = vectortoangles(var_08);
	var_0A = angleclamp180(var_07 - var_09[1]);
	var_0B = function_02F9(var_0A,22.5);
	var_0C = lib_0C5D::func_8174(param_02,undefined,1);
	var_0D = var_0C[var_0B];
	if(!isdefined(var_0D))
	{
		return 0;
	}

	var_0E = 1;
	var_0F = undefined;
	if(getdvarint("ai_wall_run_use_align_notetrack",1) == 1)
	{
		var_0F = getnotetracktimes(var_0D,"align");
	}

	if(!isdefined(var_0F) || var_0F.size == 0)
	{
		var_0F = getnotetracktimes(var_0D,"code_move");
	}

	if(isdefined(var_0F) && var_0F.size > 0)
	{
		var_0E = var_0F[0];
	}

	var_10 = getmovedelta(var_0D,0,var_0E);
	var_11 = getangledelta(var_0D,0,var_0E);
	var_12 = distance2d(self.origin,self.var_126C5.origin);
	var_13 = length(var_10);
	var_14 = var_12 - var_13;
	if(var_14 < 0)
	{
		var_15 = anglestoforward(var_06);
		var_16 = vectordot(var_08,var_15);
		if(var_16 > 0.707)
		{
			if(abs(var_14) > 10)
			{
				return 0;
			}
		}
		else if(abs(var_14) > 64)
		{
			return 0;
		}
	}
	else if(var_14 > 10)
	{
		return 0;
	}

	if(self.var_126C5.var_48 == "wall_run")
	{
		self.var_138BC = var_04;
	}

	return 1;
}

//Function Number: 74
func_89FB(param_00)
{
	if(param_00 == "wall_contact")
	{
		if(soundexists("wallrun_start_npc"))
		{
			self playsound("wallrun_start_npc");
		}
	}
}

//Function Number: 75
func_FAF7()
{
	self.var_368 = -45;
	self.var_100 = 45;
	self.var_268 = -90;
	self.var_1B7 = 90;
}

//Function Number: 76
func_126CE(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_8016("noclip",0);
	var_05 = self method_8148();
	self method_8221("face angle",var_05.angles[1]);
	self method_82EA(param_01,var_04,1,param_02,1);
	lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
	func_11701(param_00,param_01);
}

//Function Number: 77
func_3E58(param_00)
{
}