/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3155.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 12:26:18 AM
*******************************************************************/

//Function Number: 1
func_B063(param_00,param_01,param_02,param_03)
{
	lib_0A1E::func_235F(param_00,param_01,param_02,self.var_BCD6);
}

//Function Number: 2
func_B064(param_00,param_01,param_02,param_03)
{
}

//Function Number: 3
func_F171(param_00,param_01,param_02,param_03)
{
	var_04 = getclosestpointonnavmesh(self.origin);
	var_05 = distancesquared(var_04,self.origin);
	if(var_05 > squared(15))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
func_11701(param_00,param_01)
{
	var_02 = level.var_2303[param_00].var_10E2F[param_01];
	var_03 = undefined;
	if(isarray(var_02.var_116FB))
	{
		var_03 = var_02.var_116FB[0];
	}
	else
	{
		var_03 = var_02.var_116FB;
	}

	lib_0A1A::func_2388(param_00,param_01,var_02,var_02.var_116FB);
	lib_0A1A::func_238A(param_00,var_03,0.2,undefined,undefined,undefined);
	self notify("killanimscript");
}

//Function Number: 5
func_F16E(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_2303[param_00].var_10E2F[param_01].var_71A5;
	var_05 = self [[ var_04 ]](param_00,param_01,param_03);
	var_06 = getanimlength(var_05);
	self method_82E4("deathanim",var_05,lib_0A1E::func_2339(),1,0.1);
	wait(var_06);
	self notify("terminate_ai_threads");
	self notify("killanimscript");
}

//Function Number: 6
func_F16C(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_2029))
	{
		self.var_2029 delete();
	}

	self.var_EA0E = 1;
	stopfxontag(level.var_7649["seeker_" + self.team],self,"tag_fx");
	self method_8484();
	self method_8481(self.origin);
	if(isdefined(self.var_B14F))
	{
		self notify("stop_magic_bullet_shield");
		self.var_B14F = undefined;
		self.var_E0 = 0;
		self notify("internal_stop_magic_bullet_shield");
	}

	playfx(level.var_7649["seeker_sparks"],self gettagorigin("tag_fx"));
	function_0178("seeker_expire",self.origin);
	self method_818B();
	self notify("terminate_ai_threads");
	self notify("killanimscript");
	self delete();
}

//Function Number: 7
func_9DEE(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	var_04 = vectortoangles(self.var_1BE);
	self method_8221("face angle",var_04[1]);
	var_05 = vectordot(vectornormalize((self.var_1BE[0],self.var_1BE[1],0)),anglestoforward(self.angles));
	var_06 = 0.966;
	return var_05 > var_06;
}

//Function Number: 8
func_D55F(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = self method_8148();
	var_05 = scripts\common\utility::func_5D14(var_04.origin,5);
	var_06 = self method_8146();
	var_06 = scripts\common\utility::func_5D14(var_06,5);
	self method_8221("face angle",var_04.angles[1]);
	var_07 = distance(var_05,var_06);
	var_08 = scripts\sp\_utility::func_BD6B(20,var_07);
	var_09 = 30;
	var_0A = 1 / var_09 * var_08;
	var_0B = 0;
	var_0C = 0;
	while(!var_0C)
	{
		if(var_0B > 1)
		{
			var_0B = 1;
			var_0C = 1;
		}

		var_0D = vectorlerp(var_05,var_06,var_0B);
		var_0B = var_0B + var_0A;
		self method_80F1(var_0D,self.angles,10000);
		scripts\common\utility::func_136F7();
	}

	self method_80F1(var_06,self.angles,10000);
	func_11701(param_00,param_01);
}

//Function Number: 9
func_CF22(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self method_8148();
	var_05 = var_04.var_5AE2;
	var_06 = var_05 - var_04.origin;
	thread func_D561(param_00,param_01,param_02,[var_06[2]]);
}

//Function Number: 10
func_CF20(param_00,param_01,param_02,param_03)
{
	func_CF22(param_00,param_01,param_02,-8);
}

//Function Number: 11
func_CF27(param_00,param_01,param_02,param_03)
{
	func_CF22(param_00,param_01,param_02,-42);
}

//Function Number: 12
func_CF23(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = self.origin;
	var_05 = getclosestpointonnavmesh(var_04,self);
	var_05 = scripts\common\utility::func_5D14(var_05,50);
	var_06 = 0;
	func_A4E8(param_00,param_01,param_02,var_04,self.angles,var_05,var_06,1);
	lib_0A1A::func_2330(param_01,"end");
}

//Function Number: 13
func_CF25(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = self method_8148();
	var_05 = self method_8146();
	var_06 = var_05 - var_04.origin;
	var_06 = (var_06[0],var_06[1],0);
	func_D561(param_00,param_01,param_02,[var_06[2]]);
}

//Function Number: 14
func_3EA3(param_00,param_01,param_02)
{
	return lib_0A1A::func_2358("traverse_external",param_02);
}

//Function Number: 15
func_D561(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04 = self method_8148();
	var_05 = scripts\common\utility::func_5D14(var_04.origin,5);
	var_06 = self method_8146();
	var_06 = scripts\common\utility::func_5D14(var_06,5);
	var_07 = 0;
	if(isdefined(param_03))
	{
		if(isarray(param_03))
		{
			var_07 = param_03[0];
		}
		else
		{
			var_07 = param_03;
		}
	}
	else if(isdefined(var_04.var_126D4))
	{
		var_07 = var_04.var_126D5;
	}

	func_A4E8(param_00,param_01,param_02,var_05,var_04.angles,var_06,var_07,0);
	func_11701(param_00,param_01);
}

//Function Number: 16
func_A4E8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self method_8016("noclip");
	self.var_36A = 1;
	var_08 = 16;
	var_09 = (0,0,5);
	var_0A = param_03 + var_09;
	var_0B = param_05 + var_09;
	var_0C = max(var_08,param_06 + var_08);
	var_0D = var_0B + var_0A * 0.5;
	var_0E = var_0D[2];
	var_0F = var_0C + var_0A[2] - var_0E;
	var_10 = var_0D + (0,0,1) * var_0F;
	if(param_07)
	{
		var_11 = scripts\common\trace::func_4956(1);
		var_12 = scripts\common\trace::func_DCED(var_10,var_0A,self,var_11);
		var_13 = scripts\common\trace::func_DCED(var_10,var_0B,self,var_11);
		if(var_12["fraction"] < 0.95 || var_13["fraction"] < 0.95)
		{
			return;
		}
	}

	var_14 = func_3EA3(param_00,param_01,"takeoff");
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_14,1,param_02,1);
	wait(getanimlength(var_14) - 0.1);
	var_15 = distance(var_0A,var_10) + distance(var_0B,var_10);
	var_16 = scripts\sp\_utility::func_BD6B(25,var_15);
	var_17 = 30;
	var_18 = 1 / var_17 * var_16;
	self method_8221("face angle",param_04[1]);
	func_F154(self.var_168);
	thread scripts\sp\_utility::func_CE2F("seeker_jump_start");
	var_19 = func_3EA3(param_00,param_01,"jumploop");
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_19,1,param_02,1);
	self.var_A481 = scripts\common\utility::spawn_tag_origin();
	self.var_A481 linkto(self,"tag_origin",(0,0,0),(90,0,0));
	playfxontag(level.var_7649["seeker_thruster"],self.var_A481,"tag_origin");
	var_1A = 0;
	var_1B = 0;
	var_1C = 0;
	while(!var_1B)
	{
		if(var_1A > 1)
		{
			var_1A = 1;
			var_1B = 1;
		}

		var_1D = lib_0B4D::func_7BC5(var_0A,var_0B,var_0F,var_1A);
		var_1A = var_1A + var_18;
		self method_80F1(var_1D,self.angles,10000);
		if(var_1A > 0.7 && !var_1C)
		{
			var_19 = func_3EA3(param_00,param_01,"fallloop");
			self method_806F(lib_0A1E::func_2339(),param_02);
			self method_82EA(param_01,var_19,1,param_02,1);
			killfxontag(level.var_7649["seeker_thruster"],self,"tag_origin");
			var_1C = 1;
		}

		scripts\common\utility::func_136F7();
	}

	self.var_A481 delete();
	self method_80F1(var_0B,self.angles,10000);
	func_F154(self.var_168);
	var_1E = func_3EA3(param_00,param_01,"land");
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_1E,1,param_02,1);
	thread scripts\sp\_utility::func_CE2F("seeker_jump_end");
	wait(getanimlength(var_1E) - 0.05);
	self.var_36A = 0;
}

//Function Number: 17
func_F154(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(level.var_C6BD) && isdefined(level.var_C6BD[param_00]))
	{
		if(!isdefined(level._effect["step_" + param_00][self.var_12BA4]))
		{
			if(!isdefined(level._effect["step_" + param_00]["soldier"]))
			{
				return;
			}

			level._effect["step_" + param_00][self.var_12BA4] = level._effect["step_" + param_00]["soldier"];
		}

		scripts\anim\notetracks::func_D47F("tag_origin",param_00);
	}
}

//Function Number: 18
func_9FBC(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_B55B.target))
	{
		return 0;
	}

	if(param_03 == "player")
	{
		return isplayer(self.var_B55B.target);
	}

	return isdefined(self.var_B55B.target.var_12BA4) && tolower(self.var_B55B.target.var_12BA4) == tolower(param_03);
}