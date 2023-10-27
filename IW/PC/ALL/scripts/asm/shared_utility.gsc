/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\shared_utility.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 1462 ms
 * Timestamp: 10/27/2023 12:26:20 AM
*******************************************************************/

//Function Number: 1
func_3EB7(param_00,param_01,param_02)
{
	var_03 = param_02;
	var_04 = self.var_1198.var_FED6 + "_" + var_03;
	if(isdefined(self.var_1198.var_FED6) && lib_0A1A::func_2346(param_01,var_04))
	{
		return lib_0A1A::func_2358(param_01,var_04);
	}

	return lib_0A1A::func_2358(param_01,param_02);
}

//Function Number: 2
func_3ECD(param_00,param_01,param_02)
{
	var_03 = lib_0A1A::func_233C();
	if(lib_0A1A::func_234A(var_03,param_02))
	{
		var_04 = lib_0A1A::func_233D(var_03,param_02);
		if(isarray(var_04))
		{
			return var_04[randomint(var_04.size)];
		}

		return var_04;
	}

	if(!lib_0A1A::func_2346(param_02,var_04))
	{
		return lib_0A1A::func_2358(param_02,"default");
	}

	return lib_0A1A::func_2358(param_02,var_04);
}

//Function Number: 3
func_3ECE(param_00,param_01,param_02)
{
	var_03 = lib_0A1A::func_233C();
	if(lib_0A1A::func_234A(var_03,param_02))
	{
		var_04 = lib_0A1A::func_233D(var_03,param_02);
		if(isarray(var_04))
		{
			return var_04[randomint(var_04.size)];
		}

		return var_04;
	}

	if(!lib_0A1A::func_2346(param_02,var_04))
	{
		var_05 = [];
		var_05[0] = lib_0A1A::func_2358(param_02,"trans_to_one_hand_run");
		var_05[1] = lib_0A1A::func_2358(param_02,"one_hand_run");
		var_05[2] = lib_0A1A::func_2358(param_02,"trans_to_two_hand_run");
		var_05[3] = lib_0A1A::func_2358(param_02,"two_hand_run");
		return var_05;
	}

	return lib_0A1A::func_2358(var_03,var_05);
}

//Function Number: 4
func_3EAA(param_00,param_01,param_02)
{
	var_03 = weaponclass(self.var_394);
	if(!lib_0A1A::func_2346(param_01,var_03))
	{
		var_03 = "rifle";
	}

	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 5
func_3E9A(param_00,param_01,param_02)
{
	var_03 = param_02;
	if(self.var_2303.var_FECD.var_FF0B == 1)
	{
		var_04 = "single";
	}
	else
	{
		var_04 = var_04 + self.var_2303.var_FECD.var_FF0B;
	}

	if(lib_0A1A::func_2346(param_01,var_04))
	{
		var_05 = lib_0A1A::func_2358(param_01,var_04);
	}
	else
	{
		var_05 = lib_0A1A::func_2358(param_02,"fire");
	}

	return var_05;
}

//Function Number: 6
func_3EAC(param_00,param_01,param_02)
{
	if(weaponclass(self.var_394) == "rocketlauncher" && lib_0A1A::func_2346(param_01,"drop_rpg"))
	{
		return lib_0A1A::func_2358(param_01,"drop_rpg");
	}

	var_03 = lib_0A1B::func_292E();
	if(!lib_0A1A::func_2346(param_01,var_03))
	{
		var_03 = "rifle";
	}

	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 7
func_12668(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 8
func_2B58(param_00,param_01,param_02,param_03)
{
}

//Function Number: 9
func_BD25(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_233C() == param_03;
}

//Function Number: 10
func_BD26(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_233C() != param_03;
}

//Function Number: 11
func_BD28(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1A::func_233C();
	return var_04 != "frantic" && var_04 != "combat" && var_04 != "sprint";
}

//Function Number: 12
func_BD27(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1A::func_233C();
	return var_04 != "casual" && var_04 != "casual_gun";
}

//Function Number: 13
func_7FF8(param_00,param_01)
{
	switch(param_01)
	{
		case "stand":
		case "crouch":
		case "prone":
			break;

		default:
			return param_01;
	}

	switch(param_00)
	{
		case "Cover Left":
			if(param_01 == "crouch")
			{
				return "Cover Left Crouch";
			}
			break;

		case "Cover Right":
			if(param_01 == "crouch")
			{
				return "Cover Right Crouch";
			}
			break;

		case "Conceal Crouch":
		case "Cover Crouch Window":
			return "Cover Crouch";

		case "Conceal Stand":
			return "Cover Stand";
	}

	return undefined;
}

//Function Number: 14
func_8000(param_00,param_01,param_02)
{
	var_03 = self.var_1491.var_D6A5;
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}
	else if(function_02A7(param_01) && !param_01 method_80B1(var_03))
	{
		var_03 = param_01 method_812D();
	}

	var_04 = func_7FF8(param_01.type,var_03);
	if(isdefined(var_04) && isdefined(param_00[var_04]))
	{
		return param_00[var_04];
	}

	if(isdefined(param_00[param_01.type]))
	{
		return param_00[param_01.type];
	}

	return undefined;
}

//Function Number: 15
func_1C9C()
{
	var_00 = scripts\common\utility::func_13C07(self.var_394) == "mg";
	return var_00 || isdefined(self.var_1198.var_522F) && isdefined(self.var_205) && self.var_205 == self.var_1198.var_522F;
}

//Function Number: 16
func_8001(param_00,param_01)
{
	if(function_02A4(param_00) || !isdefined(param_00.type))
	{
		return 0;
	}

	if(getdvarint("ai_iw7",0) == 1)
	{
		if((isdefined(self.var_1198.var_98F4) && self.var_1198.var_98F4) || isdefined(self.var_2303.var_1310E) && self.var_2303.var_1310E)
		{
			return 0;
		}

		if(self.var_2303.var_7360 && isdefined(level.var_7365) && isdefined(level.var_7365[self.var_238F]))
		{
			var_02 = func_8000(level.var_7365[self.var_238F],param_00,param_01);
			if(isdefined(var_02))
			{
				return var_02;
			}

			return 0;
		}
		else if(isdefined(level.var_C05A) && isdefined(level.var_C05A[self.var_238F]))
		{
			var_02 = func_8000(level.var_C05A[self.var_238F],param_01,var_02);
			if(isdefined(var_02))
			{
				return var_02;
			}

			return 0;
		}
	}

	if(!isdefined(self.var_8CD0))
	{
		if(scripts\common\utility::func_9EB4(param_01))
		{
			return 90;
		}
		else if(scripts\common\utility::func_9EB7(param_01))
		{
			return -90;
		}
	}

	return 0;
}

//Function Number: 17
func_812E(param_00,param_01)
{
	if(!isdefined(param_00.angles))
	{
		return 0;
	}

	var_02 = param_00.type;
	if(function_02A7(param_00) && !param_00 method_80B1("stand") && !isdefined(param_01))
	{
		switch(var_02)
		{
			case "Cover Left":
				param_01 = "crouch";
				break;

			case "Cover Right":
				param_01 = "crouch";
				break;
		}
	}

	var_03 = func_8001(param_00,param_01);
	if(param_00.type == "Cover Left")
	{
		if(self.var_238F == "soldier")
		{
			var_03 = var_03 + 45;
		}
	}

	return var_03;
}

//Function Number: 18
func_7FF7(param_00,param_01)
{
	var_02 = func_8001(param_00,param_01);
	return param_00.angles[1] + var_02;
}

//Function Number: 19
func_812D(param_00,param_01)
{
	var_02 = func_812E(param_00,param_01);
	return param_00.angles[1] + var_02;
}

//Function Number: 20
func_7FF6(param_00,param_01)
{
	var_02 = func_8001(param_00,param_01);
	return combineangles(param_00.angles,(0,var_02,0));
}

//Function Number: 21
func_7FF1(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(param_02 == "exposed")
	{
		var_03 = level.var_C046[param_00];
	}
	else if(param_02 == "lean" || param_02 == "leanover")
	{
		var_03 = level.var_C04D[param_00];
	}

	if(isdefined(var_03))
	{
		var_04 = func_8000(var_03,param_01,undefined);
		if(isdefined(var_04))
		{
			return var_04;
		}
	}

	return 0;
}

//Function Number: 22
func_7FF2(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(self.var_2303.var_7360)
	{
		if(param_02 == "lean")
		{
			var_03 = level.var_7364[param_00];
		}
		else if(param_02 == "A" || param_02 == "full" || param_02 == "right" || param_02 == "left")
		{
			var_03 = level.var_7363[param_00];
		}
	}
	else if(param_02 == "lean")
	{
		var_03 = level.var_C04E[param_00];
	}

	if(isdefined(var_03))
	{
		var_04 = func_8000(var_03,param_01,undefined);
		if(isdefined(var_04))
		{
			return var_04;
		}
	}

	return 0;
}

//Function Number: 23
func_C04B(param_00)
{
	if(param_00.type == "Cover Stand 3D")
	{
		return !func_C04A(param_00);
	}

	return 0;
}

//Function Number: 24
func_C04A(param_00)
{
	if(param_00.type == "Cover Stand 3D")
	{
		if(isdefined(param_00.var_EE79) && param_00.var_EE79 == "exposed")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 25
func_7FFF(param_00)
{
	if(isdefined(param_00))
	{
		if(func_C04A(param_00))
		{
			return "Cover Exposed 3D";
		}
		else
		{
			return param_00.type;
		}
	}

	return "undefined";
}

//Function Number: 26
func_3F04(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(abs(self.var_E3) > 150)
	{
		if(scripts\common\utility::func_4D59("left_leg_upper","left_leg_lower","right_leg_upper","right_leg_lower","left_foot","right_foot"))
		{
			var_03 = "legs";
		}
		else if(self.var_DD == "torso_lower")
		{
			var_03 = "torso_lower";
		}
		else
		{
			var_03 = "default";
		}
	}
	else if(self.var_E3 < 0)
	{
		var_03 = "right";
	}
	else
	{
		var_03 = "left";
	}

	return lib_0A1A::func_2358(param_01,var_03);
}

//Function Number: 27
func_9D50()
{
	return isdefined(lib_0A1B::func_2920());
}

//Function Number: 28
func_93DE(param_00,param_01,param_02,param_03)
{
	return !isdefined(lib_0A1B::func_2920());
}

//Function Number: 29
func_C17A(param_00,param_01,param_02,param_03)
{
	return !isdefined(lib_0A1B::func_2920());
}

//Function Number: 30
func_FB04(param_00,param_01)
{
	self endon(param_00 + "_finished");
	self.var_36A = 1;
	thread func_FB05(param_00);
	if(param_01 > 0)
	{
		wait(param_01);
	}

	self.var_36A = 0;
	self notify("StopUseAnimGoalWeight");
}

//Function Number: 31
func_FB05(param_00)
{
	self notify("StopUseAnimGoalWeight");
	self endon("StopUseAnimGoalWeight");
	self endon("death");
	self endon("entitydeleted");
	self waittill(param_00 + "_finished");
	self.var_36A = 0;
}

//Function Number: 32
func_DCB8(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_2303[param_00].var_10E2F[param_02];
	if(isdefined(var_04.var_1267B))
	{
		if(var_04.var_1267B.size == 2)
		{
			if(scripts\common\utility::func_4347())
			{
				var_05 = var_04.var_1267B[0];
				var_04.var_1267B[0] = var_04.var_1267B[1];
				var_04.var_1267B[1] = var_05;
			}
		}
		else
		{
			var_04.var_1267B = scripts\common\utility::array_randomize(var_04.var_1267B);
		}
	}

	return 1;
}