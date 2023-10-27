/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3174.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 50
 * Decompile Time: 24 ms
 * Timestamp: 10/27/2023 12:26:25 AM
*******************************************************************/

//Function Number: 1
func_9DAD(param_00,param_01,param_02,param_03)
{
	if(!self.var_E0)
	{
		return scripts\common\utility::func_4D59("right_arm_upper","right_arm_lower","right_hand");
	}

	return 0;
}

//Function Number: 2
func_9DAE(param_00,param_01,param_02,param_03)
{
	if(!self.var_E0)
	{
		return scripts\common\utility::func_4D59("right_leg_upper","right_foot","right_leg_lower");
	}

	return 0;
}

//Function Number: 3
func_9DAC(param_00,param_01,param_02,param_03)
{
	if(!self.var_E0)
	{
		return scripts\common\utility::func_4D59("left_leg_upper","left_foot","left_leg_lower");
	}

	return 0;
}

//Function Number: 4
func_9DAA(param_00,param_01,param_02,param_03)
{
	if(!self.var_E0)
	{
		return scripts\common\utility::func_4D59("left_arm_upper","left_arm_lower","left_hand");
	}

	return 0;
}

//Function Number: 5
func_9DAF(param_00,param_01,param_02,param_03)
{
	if(!self.var_E0)
	{
		return scripts\common\utility::func_4D59("torso_upper","torso_lower");
	}

	return 0;
}

//Function Number: 6
func_9DA9(param_00,param_01,param_02,param_03)
{
	if(!self.var_E0)
	{
		return scripts\common\utility::func_4D59("head","neck","helmet");
	}

	return 0;
}

//Function Number: 7
func_9DAB(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::func_4D59("left_hand","left_arm_upper","left_arm_lower","left_leg_upper","left_leg_lower","left_foot","torso_lower");
}

//Function Number: 8
func_9DA8(param_00,param_01,param_02,param_03)
{
	if(!self.var_E0)
	{
		if(lib_0A1E::func_7F08() == 1 && !scripts\common\utility::func_4D59("left_leg_upper","left_leg_lower","left_foot","right_leg_upper","right_leg_lower","right_foot"))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
func_9DB0(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::func_4D59("right_arm_upper","right_arm_lower","right_hand","left_hand","left_arm_upper","left_arm_lower","left_leg_upper","left_leg_lower","left_foot","right_leg_upper","right_leg_lower","right_foot","torso_upper","torso_lower");
}

//Function Number: 10
func_89E1()
{
	self endon("death");
	self notify("new_secondary_pain");
	self endon("new_secondary_pain");
	self.var_2303.var_F0BC = 1;
	wait(0.5);
	self.var_2303.var_F0BC = 0;
}

//Function Number: 11
func_136E3(param_00,param_01)
{
	self endon(param_01 + "_finished");
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(!isalive(self))
		{
			break;
		}

		var_0C = func_3E95(param_00,param_01);
		self method_82AB(var_0C,1,0.01,1);
		thread func_89E1();
		wait(0.35);
	}
}

//Function Number: 12
func_9F3A(param_00)
{
	if(param_00 == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
func_3E95(param_00,param_01)
{
	var_02 = [];
	if(scripts\common\utility::func_4D59("torso_upper","torso_lower"))
	{
		var_02[var_02.size] = lib_0A1A::func_2358(param_01,"add_torso");
	}
	else if(scripts\common\utility::func_4D59("head","helmet","neck"))
	{
		var_02[var_02.size] = lib_0A1A::func_2358(param_01,"add_head");
	}
	else if(scripts\common\utility::func_4D59("right_arm_upper","right_arm_lower"))
	{
		var_02[var_02.size] = lib_0A1A::func_2358(param_01,"add_right_arm");
	}
	else if(scripts\common\utility::func_4D59("left_arm_upper","left_arm_lower"))
	{
		var_02[var_02.size] = lib_0A1A::func_2358(param_01,"add_left_arm");
	}
	else if(scripts\common\utility::func_4D59("left_leg_upper","left_leg_lower","left_foot"))
	{
		var_02[var_02.size] = lib_0A1A::func_2358(param_01,"add_left_leg");
	}
	else if(scripts\common\utility::func_4D59("right_leg_upper","right_leg_lower","right_foot"))
	{
		var_02[var_02.size] = lib_0A1A::func_2358(param_01,"add_right_leg");
	}

	if(var_02.size < 2)
	{
		var_02[var_02.size] = lib_0A1A::func_2358(param_01,"add_default");
	}

	return var_02[randomint(var_02.size)];
}

//Function Number: 14
func_3EF0(param_00,param_01,param_02)
{
	return lib_0A1A::func_2358(param_01,"shock_loop_" + self.var_1491.var_D6A5);
}

//Function Number: 15
func_D517(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon(param_01 + "_finished");
	var_04 = level.var_2303[param_00].var_10E2F[param_01].var_71A5;
	var_05 = self [[ var_04 ]](param_00,param_01,param_03);
	var_06 = scripts\common\utility::func_116D7(isdefined(self.var_61B4),self.var_61B4,3.5);
	lib_0A1E::func_D521();
	self method_8016("zonly_physics",0);
	wait(randomfloat(0.3));
	if(self.var_238F == "c6" || self.var_238F == "c6_worker")
	{
		thread func_FE4E(self.var_238F,param_01,param_02,1,0,1);
		self playsound("generic_flashbang_c6_1");
	}
	else
	{
		thread func_FE4E(self.var_238F,param_01,param_02,1,0);
	}

	wait(var_06);
	self notify("painloop_end");
	lib_0A1A::func_2330(param_01,"stop_loop_pain");
	self.var_61A9 = undefined;
	func_6CE0(param_00,param_01,param_03);
}

//Function Number: 16
func_FE4D(param_00,param_01,param_02)
{
	self method_83AD();
}

//Function Number: 17
func_FE4E(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon(param_01 + "_finished");
	self endon("painloop_end");
	var_06 = lib_0A1E::func_2339();
	self method_806F(var_06,param_02);
	if(isdefined(param_04) && param_04)
	{
		if(lib_0A1A::func_2346("Knobs","move"))
		{
			var_07 = lib_0A1E::func_2356("Knobs","move");
			self method_84F2(var_07);
		}
	}

	var_08 = var_06;
	var_09 = lib_0A1E::func_2336(param_00,param_01);
	for(;;)
	{
		if(isdefined(param_05))
		{
			var_09 = lib_0A1E::func_2336(param_00,param_01);
		}

		self method_82E7(param_01,var_09,1,param_02,param_03);
		lib_0A1E::func_2369(param_00,param_01,var_09);
		var_08 = var_09;
		lib_0A1E::func_2320(param_00,param_01,var_09,lib_0A1A::func_2341(param_00,param_01));
	}
}

//Function Number: 18
func_3EF7(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_2358(param_01,"shock_finish_" + self.var_1491.var_D6A5);
}

//Function Number: 19
func_D4EE(param_00,param_01,param_02,param_03)
{
	func_D4F1(param_00,param_01,param_02,param_03,0);
}

//Function Number: 20
func_D4F4(param_00,param_01,param_02,param_03)
{
	func_D4F1(param_00,param_01,param_02,param_03,1);
}

//Function Number: 21
func_D4F2(param_00,param_01,param_02,param_03)
{
	self.var_1198.var_98F4 = 1;
	func_D4F1(param_00,param_01,param_02,param_03,0);
}

//Function Number: 22
func_C860(param_00,param_01)
{
	if(param_00 == "pain_can_end")
	{
		return 1;
	}
}

//Function Number: 23
func_6374(param_00,param_01,param_02)
{
	self endon(param_01 + "_finished");
	while(isdefined(self.var_2303.var_F0BC) && self.var_2303.var_F0BC)
	{
		wait(0.05);
	}

	lib_0A1A::func_2330(param_01,"end");
	func_6CE0(param_00,param_01,param_02);
	self notify(param_01 + "_finished");
}

//Function Number: 24
func_D4F1(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon(param_01 + "_finished");
	if(isdefined(self.var_1491.var_C888))
	{
		self.var_1491.var_A9C8 = self.var_1491.var_C888;
	}
	else
	{
		self.var_1491.var_A9C8 = 0;
	}

	self.var_1491.var_C888 = gettime();
	if(self.var_2C0 != "none")
	{
		self.var_1491.var_C87B = 1;
	}
	else
	{
		self.var_1491.var_C87B = undefined;
	}

	if(isdefined(self.var_9E33))
	{
		scripts\anim\combat_utility::func_5D29();
		self.var_9E33 = undefined;
	}

	self method_8016("gravity");
	if(!isdefined(self.var_C006))
	{
		scripts\anim\face::func_EB83("pain");
	}

	if(lib_0C60::func_10025(func_1390C()))
	{
		lib_0C60::func_8E17();
	}

	var_06 = level.var_2303[param_00].var_10E2F[param_01].var_71A5;
	var_07 = self [[ var_06 ]](param_00,param_01,param_03);
	self method_82E4(param_01,var_07,lib_0A1E::func_2339(),1,param_02,1);
	if(param_04 == 1)
	{
		self.var_2303.var_F0BC = 0;
		thread func_136E3(param_00,param_01);
	}

	lib_0A1E::func_2369(param_00,param_01,var_07);
	if(animhasnotetrack(var_07,"pain_can_end"))
	{
		var_08 = getnotetracktimes(var_07,"pain_can_end");
		var_09 = getanimlength(var_07);
		wait(var_09 * var_08[0]);
		thread func_6374(param_00,param_01,param_03);
	}

	if(animhasnotetrack(var_07,"code_move"))
	{
		lib_0A1E::func_231F(param_00,param_01);
	}

	lib_0A1E::func_231F(param_00,param_01);
	func_6CE0(param_00,param_01,param_03,param_05);
}

//Function Number: 25
func_C872(param_00,param_01)
{
	switch(param_01)
	{
		case "pain_can_end":
			return 1;
	}
}

//Function Number: 26
func_6CE0(param_00,param_01,param_02,param_03)
{
	self notify("killanimscript");
	var_04 = level.var_2303[param_00].var_10E2F[param_01];
	if(isdefined(self.var_2303.var_F0BC))
	{
		self.var_2303.var_F0BC = undefined;
	}

	var_05 = undefined;
	if(!isdefined(param_03) || !param_03)
	{
		if(isarray(param_02))
		{
			var_05 = param_02[0];
		}
		else
		{
			var_05 = param_02;
		}
	}

	if(!isdefined(var_05))
	{
		if(isdefined(var_04.var_1267B) && var_04.var_1267B.size > 0)
		{
			return;
		}

		var_05 = "exposed_idle";
	}

	thread lib_0A1A::func_237C(var_05,undefined);
}

//Function Number: 27
func_CF05(param_00,param_01,param_02,param_03)
{
	self.var_1A4 = 1;
	func_D4F1(param_00,param_01,param_02,param_03,1);
}

//Function Number: 28
func_CF04(param_00,param_01,param_02,param_03)
{
	self.var_1A4 = 1;
	func_D4EE(param_00,param_01,param_02,param_03);
}

//Function Number: 29
func_100B7()
{
	if(self.var_E0 && !isdefined(self.var_55BF))
	{
		if(self.var_1491.var_D6A5 == "prone")
		{
			return 0;
		}

		if(isdefined(self.var_1B1) && isdefined(self.var_1B1.team) && self.var_1B1.team == self.team)
		{
			return 0;
		}

		if(self.var_4D68 > 0)
		{
			return 0;
		}

		return 1;
	}

	return 0;
}

//Function Number: 30
func_FFE0(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_E0) && self.var_E0 && !isdefined(self.var_55BF))
	{
		if(isdefined(self.var_1B1) && isdefined(self.var_1B1.var_12BA4) && self.var_1B1.var_12BA4 == "c8" && isdefined(self.var_E2) && function_02BE(self.var_E2))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 31
func_D4EF(param_00,param_01,param_02,param_03)
{
	self.var_2303.var_2AD2 = 1;
	func_D4F1(param_00,param_01,param_02,param_03,0,1);
}

//Function Number: 32
func_D4F0(param_00,param_01,param_02)
{
	self.var_2303.var_2AD2 = undefined;
}

//Function Number: 33
func_3E9D(param_00,param_01,param_02)
{
	return [[ self.var_7193 ]](param_01,"pain");
}

//Function Number: 34
func_3EEE(param_00,param_01,param_02)
{
	if(self.var_AA32 == "torso_upper")
	{
		var_03 = lib_0A1A::func_2358(param_01,"torso_upper");
	}
	else if(self.var_AA32 == "torso_lower")
	{
		var_03 = lib_0A1A::func_2358(param_02,"torso_lower");
	}
	else
	{
		var_03 = lib_0A1A::func_2358(param_02,"default");
	}

	self.var_AA32 = undefined;
	return var_03;
}

//Function Number: 35
func_3EED(param_00,param_01,param_02)
{
	if(scripts\common\utility::func_4D59("torso_upper"))
	{
		self.var_AA32 = "torso_upper";
		return lib_0A1A::func_2358(param_01,"torso_upper");
	}

	if(scripts\common\utility::func_4D59("torso_lower"))
	{
		self.var_AA32 = "torso_lower";
		return lib_0A1A::func_2358(param_01,"torso_lower");
	}

	self.var_AA32 = "default";
	return lib_0A1A::func_2358(param_01,"default");
}

//Function Number: 36
func_3EEC(param_00,param_01,param_02)
{
	if(func_100B7())
	{
		if(self.var_1491.var_D6A5 == "crouch")
		{
			return lib_0A1A::func_2358(param_01,"damage_shield_crouch");
		}
		else if(self.var_1491.var_D6A5 == "stand")
		{
			return lib_0A1A::func_2358(param_01,"damage_shield_stand");
		}
	}

	if(scripts\anim\utility_common::func_9FCA())
	{
		return func_3EEA(param_00,param_01,param_02);
	}

	var_03 = [];
	if(scripts\common\utility::func_4D59("torso_upper"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"torso_upper");
	}
	else if(scripts\common\utility::func_4D59("torso_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"torso_lower");
	}
	else if(scripts\common\utility::func_4D59("head","helmet","neck"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"head");
	}
	else if(scripts\common\utility::func_4D59("right_arm_upper","right_arm_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"right_arm");
	}
	else if(scripts\common\utility::func_4D59("left_arm_upper","left_arm_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"left_arm");
	}
	else if(scripts\common\utility::func_4D59("left_leg_upper","left_leg_lower","left_foot"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"left_leg");
	}
	else if(scripts\common\utility::func_4D59("right_leg_upper","right_leg_lower","right_foot"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"right_leg");
	}

	if(var_03.size < 2)
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"default");
	}

	return var_03[randomint(var_03.size)];
}

//Function Number: 37
func_3EE9(param_00,param_01,param_02)
{
	if(func_100B7())
	{
		if(self.var_1491.var_D6A5 == "crouch")
		{
			return lib_0A1A::func_2358(param_01,"damage_shield_crouch");
		}
		else if(self.var_1491.var_D6A5 == "stand")
		{
			return lib_0A1A::func_2358(param_01,"damage_shield_stand");
		}
	}

	var_03 = [];
	if(var_03.size < 2)
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"default");
	}

	return var_03[randomint(var_03.size)];
}

//Function Number: 38
func_3ED6(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[var_03.size] = lib_0A1A::func_2358(param_01,"default");
	return var_03[randomint(var_03.size)];
}

//Function Number: 39
func_3EE8(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[var_03.size] = lib_0A1A::func_2358(param_01,"default");
	if(scripts\common\utility::func_4D59("left_hand","left_arm_lower","left_arm_upper"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"left_arm");
	}

	if(scripts\common\utility::func_4D59("right_hand","right_arm_lower","right_arm_upper"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"right_arm");
	}

	return var_03[randomint(var_03.size)];
}

//Function Number: 40
func_3EEA(param_00,param_01,param_02)
{
	var_03 = [];
	if(scripts\common\utility::func_4D59("torso_upper"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_torso_upper");
	}
	else if(scripts\common\utility::func_4D59("torso_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_torso_lower");
	}
	else if(scripts\common\utility::func_4D59("neck"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_neck");
	}
	else if(scripts\common\utility::func_4D59("head"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_head");
	}
	else if(scripts\common\utility::func_4D59("left_leg_upper","right_leg_upper"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_leg");
	}
	else if(scripts\common\utility::func_4D59("left_arm_upper"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_left_arm_upper");
	}
	else if(scripts\common\utility::func_4D59("left_arm_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_left_arm_lower");
	}
	else if(scripts\common\utility::func_4D59("right_arm_upper"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_right_arm_upper");
	}
	else if(scripts\common\utility::func_4D59("right_arm_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_right_arm_lower");
	}

	if(var_03.size < 2)
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"pistol_default");
	}

	return var_03[randomint(var_03.size)];
}

//Function Number: 41
func_3EEB(param_00,param_01,param_02)
{
	var_03 = 120;
	var_04 = 200;
	var_05 = 300;
	var_06 = [];
	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	if(self method_8200(self method_81E7((var_05,0,0))))
	{
		var_08 = 1;
		var_07 = 1;
	}
	else if(self method_8200(self method_81E7((var_04,0,0))))
	{
		var_07 = 1;
	}

	if(isdefined(self.var_1491.var_55FD))
	{
		var_08 = 0;
		var_07 = 0;
	}

	if(var_08)
	{
		var_06[var_06.size] = lib_0A1A::func_2358(param_01,"long");
	}
	else if(var_07)
	{
		var_06[var_06.size] = lib_0A1A::func_2358(param_01,"medium");
	}
	else if(self method_8200(self method_81E7((var_03,0,0))))
	{
		var_06[var_06.size] = lib_0A1A::func_2358(param_01,"short");
	}

	if(var_06.size == 0)
	{
		return lib_0A1A::func_2358(param_01,"emergency_backup");
	}

	return var_06[randomint(var_06.size)];
}

//Function Number: 42
func_3EE5(param_00,param_01,param_02)
{
	if(isdefined(param_02) && isdefined(param_02[1]))
	{
		return lib_0A1A::func_2358(param_01,param_02[1]);
	}

	if(self.var_1491.var_D6A5 == "crouch")
	{
		return lib_0A1A::func_2358(param_01,"crouch");
	}

	return lib_0A1A::func_2358(param_01,"stand");
}

//Function Number: 43
func_3ED3(param_00,param_01,param_02)
{
	var_03 = "back";
	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 44
func_3EE6(param_00,param_01,param_02)
{
	var_03 = "crouch";
	if(isdefined(param_02))
	{
		var_03 = var_03 + "_" + param_02;
	}

	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 45
func_3ED4(param_00,param_01,param_02)
{
	var_03 = [];
	if(scripts\common\utility::func_4D59("torso_upper","torso_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"torso");
	}
	else if(scripts\common\utility::func_4D59("head","helmet","neck"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"head");
	}

	if(var_03.size < 2)
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"default");
	}

	return var_03[randomint(var_03.size)];
}

//Function Number: 46
func_3EE7(param_00,param_01,param_02)
{
	var_03 = "stand";
	if(isdefined(param_02) && isdefined(param_02))
	{
		var_03 = var_03 + "_" + param_02;
	}

	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 47
func_3ED5(param_00,param_01,param_02)
{
	var_03 = [];
	if(scripts\common\utility::func_4D59("torso_upper"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"torso_upper");
	}
	else if(scripts\common\utility::func_4D59("torso_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"torso_lower");
	}
	else if(scripts\common\utility::func_4D59("head","helmet","neck"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"head");
	}
	else if(scripts\common\utility::func_4D59("right_arm_upper","right_arm_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"right_arm");
	}
	else if(scripts\common\utility::func_4D59("left_arm_upper","left_arm_lower"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"left_arm");
	}
	else if(scripts\common\utility::func_4D59("left_leg_upper","left_leg_lower","left_foot"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"left_leg");
	}
	else if(scripts\common\utility::func_4D59("right_leg_upper","right_leg_lower","right_foot"))
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"right_leg");
	}

	if(var_03.size < 2)
	{
		var_03[var_03.size] = lib_0A1A::func_2358(param_01,"default");
	}

	return var_03[randomint(var_03.size)];
}

//Function Number: 48
func_3EEF(param_00,param_01,param_02)
{
	var_03 = 3;
	var_04 = "deaf_" + randomint(var_03) + 1;
	return lib_0A1A::func_2358(param_01,var_04);
}

//Function Number: 49
func_4109(param_00,param_01,param_02)
{
	if(self.script == "pain")
	{
		self notify("killanimscript");
	}

	if(isdefined(self.var_4D6A))
	{
		self.var_4D68 = undefined;
		self.var_4D6A = undefined;
		self.allowpain = 1;
		if(!isdefined(self.var_D817))
		{
			self.ignoreme = 0;
		}

		self.var_D817 = undefined;
	}

	if(isdefined(self.var_2BB9))
	{
		self.var_2BB9 = undefined;
		self.allowpain = 1;
	}
}

//Function Number: 50
func_1390C()
{
	if(function_0107(self.var_DE))
	{
		return 1;
	}

	if(gettime() - level.var_A955 <= 50)
	{
		var_00 = level.var_A954 * level.var_A954 * 1.2 * 1.2;
		if(distancesquared(self.origin,level.var_A952) < var_00)
		{
			var_01 = var_00 * 0.5 * 0.5;
			self.var_B4DF = distancesquared(self.origin,level.var_A953) < var_01;
			return 1;
		}
	}

	return 0;
}