/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3879.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 69
 * Decompile Time: 33 ms
 * Timestamp: 10/27/2023 12:31:07 AM
*******************************************************************/

//Function Number: 1
func_79F5(param_00)
{
	if(!isdefined(level.var_10E6D.var_8677.var_86A3[param_00]))
	{
		return undefined;
	}

	if(level.var_10E6D.var_8677.var_86A3[param_00].size)
	{
		level.var_10E6D.var_8677.var_86A3[param_00] = scripts\sp\_utility::func_22B9(level.var_10E6D.var_8677.var_86A3[param_00]);
	}

	return level.var_10E6D.var_8677.var_86A3[param_00];
}

//Function Number: 2
func_868A(param_00,param_01)
{
	var_02 = func_79F6(param_00,param_01);
	scripts\common\utility::func_6E2A(var_02);
	var_03 = level.var_10E6D.var_8677.var_134[param_00];
	var_04 = 1;
	foreach(var_06 in var_03)
	{
		if(!issubstr(var_06,"allies") && scripts\common\utility::flag(var_06))
		{
			return;
		}
	}

	if(scripts\common\utility::flag(var_02) && self != level)
	{
		self notify(param_00);
	}

	scripts\common\utility::func_6E2A(param_00);
}

//Function Number: 3
func_868C(param_00)
{
	var_01 = func_79F6(param_00);
	if(!scripts\common\utility::flag(var_01) && self != level)
	{
		self notify(param_00);
	}

	scripts\common\utility::flag_set(var_01);
	scripts\common\utility::flag_set(param_00);
}

//Function Number: 4
func_8689(param_00)
{
	var_01 = func_79F6(param_00);
	return scripts\common\utility::flag(var_01);
}

//Function Number: 5
func_79F6(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = self.var_EED1;
	}

	var_02 = param_00 + "-Group:" + param_01;
	return var_02;
}

//Function Number: 6
func_868D(param_00)
{
	var_01 = func_79F6(param_00);
	scripts\common\utility::flag_wait(var_01);
}

//Function Number: 7
func_868E(param_00)
{
	var_01 = func_79F6(param_00);
	scripts\common\utility::func_6E5A(var_01);
}

//Function Number: 8
func_868B(param_00)
{
	if(isdefined(self.var_EED1))
	{
		self.var_EED1 = scripts\sp\_utility::func_11145(self.var_EED1);
	}
	else
	{
		self.var_EED1 = "default";
	}

	if(self.team == "allies")
	{
		self.var_EED1 = self.var_EED1 + "allies";
	}

	if(!scripts\common\utility::func_6E34(param_00))
	{
		scripts\common\utility::flag_init(param_00);
	}

	var_01 = func_79F6(param_00);
	if(!scripts\common\utility::func_6E34(var_01))
	{
		scripts\common\utility::flag_init(var_01);
		if(!isdefined(level.var_10E6D.var_8677.var_134[param_00]))
		{
			level.var_10E6D.var_8677.var_134[param_00] = [];
		}

		level.var_10E6D.var_8677.var_134[param_00][level.var_10E6D.var_8677.var_134[param_00].size] = var_01;
	}
}

//Function Number: 9
func_8682()
{
	if(!isdefined(level.var_10E6D.var_8677.var_86A3[self.var_EED1]))
	{
		level.var_10E6D.var_8677.var_86A3[self.var_EED1] = [];
		level.var_10E6D.var_8677 notify(self.var_EED1);
	}

	level.var_10E6D.var_8677.var_86A3[self.var_EED1][level.var_10E6D.var_8677.var_86A3[self.var_EED1].size] = self;
}

//Function Number: 10
func_869D()
{
	var_00 = func_79F6("stealth_spotted");
	return scripts\common\utility::flag(var_00);
}

//Function Number: 11
func_7CAD()
{
	switch(self.var_10E6D.var_10E19)
	{
		case 0:
			return "normal";

		case 1:
			return "warning";

		case 2:
			return "warning";

		case 3:
			return "attack";
	}
}

//Function Number: 12
func_F5B7(param_00)
{
	switch(param_00)
	{
		case "attack":
			var_01 = 3;
			break;

		case "warning2":
			var_01 = 2;
			break;

		case "warning1":
			var_01 = 1;
			break;

		default:
			var_01 = 0;
			break;
	}

	self.var_10E6D.var_10E19 = var_01;
}

//Function Number: 13
func_3DD1()
{
}

//Function Number: 14
func_1B3C()
{
	level.var_10E6D.var_1B2C = [];
	level.var_10E6D.var_1B2C["normal"] = "noncombat";
	level.var_10E6D.var_1B2C["reset"] = "noncombat";
	level.var_10E6D.var_1B2C["warning1"] = "alert";
	level.var_10E6D.var_1B2C["warning2"] = "alert";
	level.var_10E6D.var_1B2C["attack"] = "combat";
	level.var_10E6D.var_1B2D = [];
	level.var_10E6D.var_1B2D["normal"] = 0;
	level.var_10E6D.var_1B2D["reset"] = 0;
	level.var_10E6D.var_1B2D["warning1"] = 1;
	level.var_10E6D.var_1B2D["warning2"] = 2;
	level.var_10E6D.var_1B2D["attack"] = 3;
	level.var_10E6D.var_1B2C["combat"] = 3;
}

//Function Number: 15
func_1B40(param_00)
{
	if(isdefined(level.var_10E6D.var_1B2C[param_00]))
	{
		return level.var_10E6D.var_1B2C[param_00];
	}

	return param_00;
}

//Function Number: 16
func_F557(param_00)
{
	self.var_10E6D.var_D7DE = param_00;
}

//Function Number: 17
func_F353(param_00,param_01)
{
	if(!isdefined(param_00) && !isdefined(param_01))
	{
	}

	lib_0F23::func_F354(param_00,param_01);
}

//Function Number: 18
func_57C7()
{
	switch(self.team)
	{
		case "team3":
		case "axis":
			level.player lib_0F24::main();
			thread lib_0F1B::main();
			break;

		case "allies":
			thread lib_0F1D::main();
			break;
	}
}

//Function Number: 19
func_9C1E()
{
	if(!isdefined(self.var_10E6D))
	{
		return 0;
	}

	if(self.team == "allies")
	{
		return 1;
	}

	if(self.var_10E6D.var_10E19 == 4)
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
func_EB62()
{
	if(isdefined(self.var_10E6D.var_A8C3))
	{
		return;
	}

	self.var_EB6E = self.var_EDB0;
	if(isdefined(self.var_A906))
	{
		self.var_10E6D.var_A8C3 = self.var_A906;
		return;
	}

	if(isdefined(self.var_A905))
	{
		self.var_10E6D.var_A8C3 = self.var_A905.origin;
		return;
	}

	if(isdefined(self.var_A907))
	{
		self.var_10E6D.var_A8C3 = self.var_A907;
		return;
	}

	self.var_10E6D.var_A8C3 = self.origin;
}

//Function Number: 21
func_F4C5(param_00)
{
	self.var_10E6D.var_C98D = param_00;
	func_F4C8(self.var_10E6D.var_C9A8);
}

//Function Number: 22
func_F341(param_00)
{
	self.var_10E6D.var_500C = param_00;
	if(isdefined(self.var_10E6D.var_500C))
	{
		func_F4C8(self.var_10E6D.var_500C,1);
	}
}

//Function Number: 23
func_C9A9(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "unaware":
			return 0;

		case "alert":
			return 1;

		case "seek":
		case "run":
			return 2;

		case "combat":
			return 3;
	}

	return 0;
}

//Function Number: 24
func_F4C8(param_00,param_01,param_02)
{
	if(isdefined(self.var_527B) && self.var_527B == "combat")
	{
		self.var_10E6D.var_C9A8 = "combat";
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = "unaware";
	}

	if(param_00 == "noncombat" || param_00 == "cleared")
	{
		param_00 = "unaware";
	}

	var_03 = self.var_10E6D.var_C9A8;
	switch(param_00)
	{
		case "unaware":
		case "alert":
		case "seek":
		case "run":
			self.var_527B = "patrol";
			lib_0A1B::func_2980("patrol",param_00);
			self.var_10E6D.var_C9A8 = param_00;
			break;

		case "combat":
			self.var_527B = "combat";
			self.var_10E6D.var_C9A8 = param_00;
			break;

		default:
			self.var_10E6D.var_C9A8 = "combat";
			break;
	}

	if(isdefined(self.var_10E6D.var_C98D))
	{
		if(param_00 != "seek" && param_00 != "combat")
		{
			self.var_1491.var_C98D = self.var_10E6D.var_C98D;
			self.var_C189 = 1;
		}
		else
		{
			self.var_1491.var_C98D = undefined;
			self.var_C189 = undefined;
		}
	}

	if(scripts\common\utility::istrue(param_01) && isdefined(var_03) && var_03 != self.var_10E6D.var_C9A8)
	{
		func_F4C6(var_03,self.var_10E6D.var_C9A8,param_02);
	}
}

//Function Number: 25
func_7B71()
{
	return self.var_10E6D.var_C9A8;
}

//Function Number: 26
func_7B72()
{
	var_00 = self.var_10E6D.var_500C;
	if(!isdefined(var_00))
	{
		var_00 = level.var_10E6D.var_500C;
	}

	return var_00;
}

//Function Number: 27
func_F4C9()
{
	var_00 = func_7B72();
	if(isdefined(var_00))
	{
		func_F4C8(var_00,1);
		return;
	}

	func_F4C8("unaware",1);
}

//Function Number: 28
func_F4C6(param_00,param_01,param_02)
{
	if(isdefined(self.var_10E6D.var_C999) && func_C9A9(self.var_10E6D.var_C999) >= func_C9A9(param_01))
	{
		return;
	}

	if(param_01 != "combat" && isdefined(self.var_10E6D.var_C997) && gettime() - self.var_10E6D.var_C997 < 3000)
	{
		return;
	}

	if(!scripts\common\utility::istrue(self.var_10E6D.var_4C96))
	{
		self.var_10E6D.var_C997 = gettime();
		self.var_10E6D.var_C996 = param_00;
		self.var_10E6D.var_C999 = param_01;
		self.var_10E6D.var_C998 = param_02;
	}

	self notify("stealth_react",param_00,param_01,param_02);
}

//Function Number: 29
func_8468()
{
	self notify("going_back");
	self endon("death");
	if(isdefined(self.var_10E6D.var_8439))
	{
		self [[ self.var_10E6D.var_8439 ]]();
	}

	var_00 = self.var_10E6D.var_A8C3;
	if(isdefined(self.var_EB6E))
	{
		self.var_EDB0 = self.var_EB6E;
		self.var_EB6E = undefined;
	}

	if(function_02A7(var_00))
	{
		self.var_10E6D.var_A8C3 = undefined;
		func_10EE4(0);
		return;
	}

	if(isdefined(var_00))
	{
		self method_82EF(var_00);
		self.var_15C = 40;
	}

	if(isdefined(var_00))
	{
		thread func_8469(var_00);
	}

	wait(0.05);
	func_10EE4(0);
}

//Function Number: 30
func_8469(param_00)
{
	self endon("death");
	scripts\sp\_utility::func_13817(param_00);
	self.var_10E6D.var_A912 = undefined;
}

//Function Number: 31
func_4F6C(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_A88F))
	{
		self.var_A88F = gettime();
	}
	else
	{
		var_04 = gettime();
		if(var_04 < self.var_A88F + 10000)
		{
			return;
		}
		else
		{
			self.var_A88F = gettime();
		}
	}

	var_05 = func_79F5(self.var_EED1);
	var_05 = sortbydistance(var_05,self.origin);
	var_06 = 0;
	foreach(var_08 in var_05)
	{
		if(!isalive(var_08))
		{
			continue;
		}

		if(!isdefined(var_08.var_10E6D))
		{
			continue;
		}

		var_08 method_84F7("trigger_cover_blown",self,self.origin);
		if(var_08 == self)
		{
			continue;
		}

		if(isdefined(param_03) && distancesquared(self.origin,var_08.origin) > squared(param_03))
		{
			continue;
		}

		if(isdefined(var_08.var_10C) || isdefined(var_08.var_12E))
		{
			continue;
		}

		if(isdefined(var_08.var_10E6D) && var_08 scripts\sp\_utility::func_65DB("stealth_hold_position"))
		{
			continue;
		}

		if(isdefined(param_02))
		{
			if(param_02 <= 0)
			{
				continue;
			}

			param_02--;
		}

		var_06 = 1;
		var_08 method_84F7(param_00,self,param_01);
	}
}

//Function Number: 32
func_1B24(param_00)
{
	var_01 = distance(self.origin,param_00.origin) * 0.0005;
	var_02 = level.var_10E6D.var_B739 + var_01;
	return var_02;
}

//Function Number: 33
func_F4C4(param_00)
{
	param_00.var_571D = func_7B6E(self.origin,param_00.origin,self);
}

//Function Number: 34
func_7B6E(param_00,param_01,param_02)
{
	var_03 = self method_8428(param_00,param_01);
	if(isdefined(param_02))
	{
		param_02.var_C94F = var_03;
	}

	var_04 = 0;
	for(var_05 = 1;var_05 < var_03.size;var_05++)
	{
		var_04 = var_04 + distancesquared(var_03[var_05 - 1],var_03[var_05]);
	}

	return var_04;
}

//Function Number: 35
func_E06B()
{
	self.var_C94F = undefined;
	self.var_571D = undefined;
}

//Function Number: 36
func_9D11(param_00)
{
	if(isplayer(self))
	{
		if(scripts\common\utility::func_13D90(self.origin,self.angles,param_00.origin,0.766))
		{
			if(isdefined(param_00.var_11413) || lib_0F25::func_1140D())
			{
				return 1;
			}

			if(scripts\sp\_utility::func_CFAC(param_00,250))
			{
				return 1;
			}
		}
	}
	else
	{
		return self method_805F(param_00);
	}

	return 0;
}

//Function Number: 37
func_54E4(param_00)
{
	if(!isarray(param_00))
	{
		return;
	}

	var_01 = getarraykeys(param_00);
	var_02 = ["default","forward","forward_left","forward_right","back","back_left","back_right","left","right"];
	foreach(var_04 in var_01)
	{
		if(!scripts\common\utility::func_2286(var_02,var_04))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 38
func_92CF(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_05))
	{
	}

	param_00 func_3DD1();
	var_07 = param_00 func_79F6("stealth_spotted");
	if(scripts\common\utility::flag(var_07))
	{
		return;
	}

	if(!func_54E4(param_02))
	{
		return;
	}

	if(isdefined(param_03))
	{
		param_00.var_4E2A = param_00 scripts\sp\_utility::func_7ECF(param_03);
	}

	param_00.var_10E6D.var_92CC = 1;
	if(!isdefined(param_05))
	{
		thread lib_0B06::func_1EC9(param_00,"gravity",param_01,param_04);
	}
	else
	{
		thread lib_0B06::func_1ECC(param_00,param_01,undefined,param_04);
	}

	param_00.var_1FD = 0;
	param_00 func_F321(self,param_02,param_04,param_06);
}

//Function Number: 39
func_413E()
{
	if(!isdefined(self.var_10E6D.var_4C70))
	{
		return;
	}

	if(isdefined(self.var_4E2A))
	{
		self.var_4E2A = undefined;
	}

	self notify("stop_loop");
	self.var_10E6D.var_4C70.var_205 notify("stop_loop");
	self.var_10E6D.var_4C70 = undefined;
	self.var_10E6D.var_92CC = undefined;
	self.var_1FD = squared(512);
}

//Function Number: 40
func_F321(param_00,param_01,param_02,param_03)
{
	self.var_10E6D.var_4C70 = spawnstruct();
	self.var_10E6D.var_4C70.var_205 = param_00;
	self.var_10E6D.var_4C70.var_1FAF = param_01;
	self.var_10E6D.var_4C70.var_2DD = param_02;
	self.var_10E6D.var_4C70.var_74C2 = param_03;
}

//Function Number: 41
func_F320(param_00)
{
	if(!func_54E4(param_00))
	{
		return;
	}

	self.var_10E6D.var_4C4F = param_00;
}

//Function Number: 42
func_CCD3(param_00)
{
	if(isdefined(self.var_10E6D.var_4C70.var_CF30))
	{
		return;
	}

	self.var_10E6D.var_4C70.var_CF30 = 1;
	var_01 = self.var_10E6D.var_4C70.var_74C2;
	if(isdefined(var_01))
	{
		[[ var_01 ]]();
	}

	var_02 = self.var_10E6D.var_4C70.var_205;
	var_03 = self.var_10E6D.var_4C70.var_2DD;
	if(!isarray(self.var_10E6D.var_4C70.var_1FAF))
	{
		var_04 = self.var_10E6D.var_4C70.var_1FAF;
	}
	else
	{
		var_04 = func_793D(self.var_10E6D.var_4C70.var_1FAF,level.player.origin);
		if(!isdefined(var_04))
		{
			var_04 = self.var_10E6D.var_4C70.var_1FAF[0];
		}
	}

	var_02 notify("stop_loop");
	if(param_00 != "doFlashBanged")
	{
		if(isdefined(var_03))
		{
			var_02 lib_0B06::func_1EC7(self,var_04,var_03);
		}
		else
		{
			var_02 lib_0B06::func_1EC8(self,"gravity",var_04,var_03);
		}
	}

	self.var_10E6D.var_92CC = undefined;
	self.var_10E6D.var_4C70 = undefined;
	self.var_1FD = squared(512);
}

//Function Number: 43
func_CCD4(param_00,param_01,param_02)
{
	var_03 = self.var_10E6D.var_4C4F;
	var_04 = func_793D(var_03,param_00.origin);
	if(!isdefined(var_04))
	{
		var_04 = var_03[0];
	}

	self.var_10E6D.var_4C70.var_205 notify("stop_loop");
	if(!isdefined(param_01))
	{
		self.var_10E6D.var_4C70.var_205 lib_0B06::func_1EC7(self,var_04);
	}
	else
	{
		self.var_10E6D.var_4C70.var_205 lib_0B06::func_1EC8(self,"gravity",var_04,param_02);
	}

	self.var_10E6D.var_92CC = undefined;
	self.var_10E6D.var_4C70 = undefined;
	self.var_1FD = squared(512);
}

//Function Number: 44
func_793D(param_00,param_01)
{
	var_02 = func_7AFF(param_01);
	if(!isdefined(var_02))
	{
		if(isdefined(param_00["default"]))
		{
			return param_00["default"];
		}
		else
		{
			return undefined;
		}
	}

	if(isdefined(param_00[var_02]))
	{
		return param_00[var_02];
	}

	switch(var_02)
	{
		case "back":
			if(isdefined(param_00["back"]))
			{
				return param_00["back"];
			}
	
			if(isdefined(param_00["back_left"]))
			{
				return param_00["back_left"];
			}
	
			if(isdefined(param_00["back_right"]))
			{
				return param_00["back_right"];
			}
			break;

		case "back_left":
			if(isdefined(param_00["back_left"]))
			{
				return param_00["back_left"];
			}
	
			if(isdefined(param_00["back"]))
			{
				return param_00["back"];
			}
			break;

		case "back_right":
			if(isdefined(param_00["back_right"]))
			{
				return param_00["back_right"];
			}
	
			if(isdefined(param_00["back"]))
			{
				return param_00["back"];
			}
			break;

		case "forward_left":
			if(isdefined(param_00["forward_left"]))
			{
				return param_00["forward_left"];
			}
	
			if(isdefined(param_00["forward"]))
			{
				return param_00["forward"];
			}
	
			if(isdefined(param_00["left"]))
			{
				return param_00["left"];
			}
			break;

		case "left":
			if(isdefined(param_00["left"]))
			{
				return param_00["left"];
			}
	
			if(isdefined(param_00["forward"]))
			{
				return param_00["forward"];
			}
			break;

		case "forward_right":
			if(isdefined(param_00["forward_right"]))
			{
				return param_00["forward_right"];
			}
	
			if(isdefined(param_00["forward"]))
			{
				return param_00["forward"];
			}
	
			if(isdefined(param_00["right"]))
			{
				return param_00["right"];
			}
			break;

		case "right":
			if(isdefined(param_00["right"]))
			{
				return param_00["right"];
			}
	
			if(isdefined(param_00["forward_right"]))
			{
				return param_00["forward_right"];
			}
	
			break;
	}

	if(isdefined(param_00["default"]))
	{
		return param_00["default"];
	}
}

//Function Number: 45
func_7AFF(param_00)
{
	var_01 = self.angles;
	var_02 = self.origin;
	var_03 = 0.85;
	var_04 = 0.5;
	var_05 = undefined;
	var_06 = vectornormalize(param_00 - var_02);
	var_07 = vectordot(anglestoforward(var_01),var_06);
	var_08 = vectordot(anglestoright(var_01),var_06);
	if(var_07 <= var_03 * -1)
	{
		return "back";
	}
	else if(var_07 <= var_04 * -1 && var_08 < 0)
	{
		return "back_left";
	}
	else if(var_08 <= var_03 * -1)
	{
		return "left";
	}
	else if(var_07 >= var_03)
	{
		return "forward";
	}
	else if(var_07 >= var_04 && var_08 < 0)
	{
		return "forward_left";
	}
	else if(var_07 >= var_04 && var_08 >= 0)
	{
		return "forward_right";
	}
	else if(var_08 >= var_03)
	{
		return "right";
	}
	else if(var_07 <= var_04 * -1 && var_08 >= 0)
	{
		return "back_right";
	}

	return undefined;
}

//Function Number: 46
func_1FFA(param_00)
{
	var_01 = param_00.origin;
	var_02 = param_00 func_78E7();
	wait(1.5);
	if(isdefined(param_00) && isdefined(param_00.var_10E6D.var_13529))
	{
		var_03 = param_00.var_10E6D.var_13529;
		var_01 = param_00.origin + (0,0,45);
	}
	else
	{
		var_03 = randomint(3);
	}

	var_04 = var_02 + var_03 + "_stealth_alert_r";
}

//Function Number: 47
func_1284A(param_00,param_01)
{
	self notify("try_announce_sound_" + param_00);
	self endon("try_announce_sound_" + param_00);
	self endon("death");
	self endon("pain_death");
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	if(!func_37F7(param_00))
	{
		return 0;
	}

	return func_CE42(param_00);
}

//Function Number: 48
func_37F7(param_00)
{
	if(!isalive(self))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_939E))
	{
		return 0;
	}

	if(!isdefined(level.var_10E6D.var_BF5D) || !isdefined(level.var_10E6D.var_BF5D[param_00]))
	{
		level.var_10E6D.var_BF5D[param_00] = -10;
	}

	var_01 = gettime();
	if(var_01 < level.var_10E6D.var_BF5D[param_00])
	{
		return 0;
	}

	func_1698(param_00);
	return 1;
}

//Function Number: 49
func_1698(param_00,param_01)
{
	self endon("death");
	if(isdefined(param_01) && param_01 > 0)
	{
		wait(param_01);
	}

	if(isarray(param_00))
	{
		foreach(var_03 in param_00)
		{
			level.var_10E6D.var_BF5D[var_03] = gettime() + level.var_10E6D.var_BF5E;
		}

		return;
	}

	level.var_10E6D.var_BF5D[param_00] = gettime() + level.var_10E6D.var_BF5E;
}

//Function Number: 50
func_CE42(param_00,param_01)
{
	var_02 = 0;
	if(!isdefined(self.var_10E6D.var_13529))
	{
		return 0;
	}

	var_03 = "stealth_";
	if(scripts\common\utility::istrue(param_01))
	{
		var_03 = func_78E7();
	}

	switch(param_00)
	{
		case "warning1":
			param_00 = "_enemyalerted";
			break;

		case "hmph":
			param_00 = "_backtopatrol";
			break;

		case "warning2":
			param_00 = scripts\common\utility::array_randomize(["_enemysearch","_enemyfindplayer"])[0];
			break;

		case "backup_call":
			param_00 = "_enemybackup";
			break;

		case "acknowledgement":
			param_00 = "_reinforcements";
			break;

		case "spotted":
			param_00 = "_targetfound";
			break;

		case "start_seek":
		case "order_team_seek":
			param_00 = "_enemysearch";
			break;

		case "saw_corpse":
			param_00 = "_enemyalerted";
			break;

		case "found_corpse":
			param_00 = "_corpsefound";
			break;

		case "explosion":
			param_00 = "_noisealert";
			break;

		case "enemysweep":
			param_00 = scripts\common\utility::array_randomize(["_enemysweep","_searchreport"])[0];
			break;

		case "chatter":
			param_00 = scripts\common\utility::array_randomize(["_areasecure","_confirmclear"])[0];
			break;
	}

	var_04 = var_03 + self.var_10E6D.var_13529 + param_00;
	var_02 = func_CE43(var_04);
	return var_02;
}

//Function Number: 51
func_CE43(param_00)
{
	var_01 = 0;
	if(soundexists(param_00))
	{
		if(!isdefined(self.stealth_vo_ent))
		{
			self.stealth_vo_ent = spawn("script_origin",self.origin);
		}

		if(isdefined(self.stealth_vo_ent))
		{
			if(isdefined(self.model) && scripts\sp\_utility::func_8C32(self.model,"j_head"))
			{
				self.stealth_vo_ent linkto(self,"j_head",(0,0,0),(0,0,0));
			}

			self.stealth_vo_ent playsound(param_00,"stealth_vo",1);
		}

		if(isdefined(self.var_10E6D))
		{
			self.var_10E6D.var_A90B = gettime();
		}

		var_01 = 1;
	}
	else
	{
	}

	return var_01;
}

//Function Number: 52
func_78E7()
{
	if(!isdefined(level.var_46BD))
	{
		return "";
	}

	if(!isdefined(self.var_13525) || !isdefined(level.var_46BD[self.var_13525]))
	{
		return "";
	}

	return level.var_46BD[self.var_13525] + "_";
}

//Function Number: 53
func_10ED8(param_00,param_01)
{
	self notify("stealth_music");
	self endon("stealth_music");
	thread func_10ED9();
	for(;;)
	{
		scripts\common\utility::flag_wait("stealth_enabled");
		scripts\common\utility::func_6E5A("stealth_spotted");
		scripts\common\utility::func_6E5A("stealth_music_pause");
		foreach(var_03 in level.players)
		{
			var_03 thread func_10EDB(param_00);
		}

		scripts\common\utility::flag_wait("stealth_spotted");
		scripts\common\utility::func_6E5A("stealth_music_pause");
		foreach(var_03 in level.players)
		{
			var_03 thread func_10EDB(param_01);
		}
	}
}

//Function Number: 54
func_10EDA()
{
	self notify("stealth_music");
	self notify("stealth_music_pause_monitor");
	foreach(var_01 in level.players)
	{
		var_01 thread func_10EDB(undefined);
	}
}

//Function Number: 55
func_10ED9(param_00,param_01)
{
	self notify("stealth_music_pause_monitor");
	self endon("stealth_music_pause_monitor");
	for(;;)
	{
		scripts\common\utility::flag_wait("stealth_music_pause");
		foreach(var_03 in level.players)
		{
			var_03 thread func_10EDB(undefined);
		}

		scripts\common\utility::func_6E5A("stealth_music_pause");
		if(scripts\common\utility::flag("stealth_spotted"))
		{
			foreach(var_03 in level.players)
			{
				var_03 thread func_10EDB(param_01);
			}

			continue;
		}

		foreach(var_03 in level.players)
		{
			var_03 thread func_10EDB(param_00);
		}
	}
}

//Function Number: 56
func_10EDB(param_00)
{
	self notify("stealth_music_transition");
	self endon("stealth_music_transition");
	self endon("disconnect");
	if(!isdefined(self.var_10E6D))
	{
		thread lib_0F24::main();
	}

	var_01 = 1;
	var_02 = 0.05;
	if(!isdefined(self.var_10E6D.var_BDDB))
	{
		self.var_10E6D.var_BDDB = [];
	}

	var_03 = param_00;
	if(isdefined(var_03) && !isdefined(self.var_10E6D.var_BDDB[var_03]))
	{
		self.var_10E6D.var_BDDB[var_03] = spawn("script_model",self.origin);
		self.var_10E6D.var_BDDB[var_03] linkto(self);
		self.var_10E6D.var_BDDB[var_03].var_4B15 = 0;
		self.var_10E6D.var_BDDB[var_03] method_8278(0);
		self.var_10E6D.var_BDDB[var_03] playloopsound(var_03);
	}

	for(;;)
	{
		wait(var_02);
		var_04 = 0;
		foreach(var_03, var_06 in self.var_10E6D.var_BDDB)
		{
			var_07 = undefined;
			if(isdefined(param_00) && var_03 == param_00)
			{
				var_06.var_4B15 = min(1,var_06.var_4B15 + var_02 / var_01);
				var_07 = 1;
			}
			else
			{
				var_06.var_4B15 = max(0,var_06.var_4B15 - var_02 / var_01);
				var_07 = 0;
			}

			var_06 method_8278(var_06.var_4B15);
			if(var_06.var_4B15 == var_07)
			{
				var_04++;
			}
		}

		if(var_04 == self.var_10E6D.var_BDDB.size)
		{
			foreach(var_03, var_06 in self.var_10E6D.var_BDDB)
			{
				if(!isdefined(param_00) || var_03 != param_00)
				{
					self.var_10E6D.var_BDDB[var_03] delete();
					self.var_10E6D.var_BDDB[var_03] = undefined;
				}
			}

			return;
		}
	}
}

//Function Number: 57
func_F357(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(param_00)
	{
		level.var_10E6D.var_5659 = 1;
		level.var_10E6D.var_117EB = 0.4;
		level.var_10E6D.var_117EA = 0.4;
		level.var_10E6D.var_DAB2 = 0;
		level.var_10E6D.var_DAB3 = 0;
		function_01C5("ai_threatSightFacingScale",0.25);
		function_01C5("ai_threatSightFacingScaleDot",cos(90));
		function_01C5("ai_threatSightDisplaySpikePoint",0.025);
		function_01C5("ai_threatSightDisplaySpikeValue",0.25);
	}
	else
	{
		level.var_10E6D.var_5659 = undefined;
		level.var_10E6D.var_117EB = undefined;
		level.var_10E6D.var_117EA = undefined;
		level.var_10E6D.var_DAB2 = 50;
		level.var_10E6D.var_DAB3 = 100;
		function_01C5("ai_threatSightFacingScale",0.5);
		function_01C5("ai_threatSightFacingScaleDot",cos(180));
		function_01C5("ai_threatSightDisplaySpikePoint",0.01);
		function_01C5("ai_threatSightDisplaySpikeValue",0.1);
	}

	var_01 = function_0072();
	foreach(var_03 in var_01)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(isdefined(var_03.var_10E6D) && isdefined(var_03.var_10E6D.var_117DB))
		{
			var_03 lib_0F26::func_117D5();
		}
	}
}

//Function Number: 58
func_10EE4(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(param_00)
	{
		scripts\sp\_utility::func_1F53();
		self.var_E014 = 1;
		scripts\sp\_utility::func_65E1("stealth_override_goal");
		lib_0F1B::func_F2E0(0);
		self.var_A905 = undefined;
		return;
	}

	scripts\sp\_utility::func_65DD("stealth_override_goal");
}

//Function Number: 59
func_10E82()
{
	return scripts\sp\_utility::func_65DF("stealth_override_goal") && scripts\sp\_utility::func_65DB("stealth_override_goal");
}

//Function Number: 60
func_10E87()
{
	if(func_10E82())
	{
		scripts\sp\_utility::func_65E8("stealth_override_goal");
	}
}

//Function Number: 61
func_558C()
{
	scripts\common\utility::func_6E2A("stealth_enabled");
	var_00 = function_0075("all","all");
	foreach(var_02 in var_00)
	{
		var_02 func_623D(0);
	}

	foreach(var_05 in level.players)
	{
		var_05.var_1D4 = 8192;
		if(var_05 scripts\sp\_utility::func_65DF("stealth_enabled"))
		{
			var_05 scripts\sp\_utility::func_65DD("stealth_enabled");
		}
	}

	lib_0F23::func_6806("spotted");
}

//Function Number: 62
func_623F()
{
	scripts\common\utility::flag_set("stealth_enabled");
	var_00 = function_0075("all","all");
	foreach(var_02 in var_00)
	{
		var_02 func_623D(1);
	}

	foreach(var_05 in level.players)
	{
		if(var_05 scripts\sp\_utility::func_65DF("stealth_enabled"))
		{
			var_05 scripts\sp\_utility::func_65E1("stealth_enabled");
		}
	}
}

//Function Number: 63
func_623D(param_00)
{
	if(!param_00)
	{
		self.var_1D4 = 8192;
		if(scripts\sp\_utility::func_65DF("stealth_enabled") && scripts\sp\_utility::func_65DB("stealth_enabled") && self.team == "axis")
		{
			var_01 = spawnstruct();
			var_01.origin = level.player.origin;
			var_01.var_9B20 = level.player.origin;
			lib_0F1B::func_6808(var_01);
		}
	}

	if(scripts\sp\_utility::func_65DF("stealth_enabled"))
	{
		if(param_00)
		{
			scripts\sp\_utility::func_65E1("stealth_enabled");
			return;
		}

		scripts\sp\_utility::func_65DD("stealth_enabled");
	}
}

//Function Number: 64
func_4C75(param_00)
{
	if(isdefined(param_00["spotted"]))
	{
		self.var_10F04["spotted"] = param_00["spotted"];
	}

	if(isdefined(param_00["hidden"]))
	{
		self.var_10F04["hidden"] = param_00["hidden"];
	}
}

//Function Number: 65
func_F5B4(param_00,param_01)
{
	self.var_10E6D.var_74D5[param_00] = param_01;
}

//Function Number: 66
func_57D8()
{
	self endon("death");
	scripts\sp\_utility::func_57D5();
}

//Function Number: 67
func_8693()
{
	self endon("death");
	var_00 = self.var_EED1;
	if(isdefined(var_00))
	{
		var_01 = func_79F5(var_00);
		if(isdefined(var_01) && var_01.size)
		{
			foreach(var_03 in var_01)
			{
				var_04 = var_03 func_7B71();
				if(var_03 != self && isdefined(var_04) && var_04 == "seek")
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 68
func_CD58(param_00,param_01)
{
	func_10EE4(1);
	func_F4C8("seek",1,param_00);
	var_02 = param_00 - self.origin;
	var_02 = vectornormalize((var_02[0],var_02[1],0));
	var_03 = spawnstruct();
	var_03.origin = param_00;
	var_03.angles = vectortoangles(var_02);
	var_04 = (0,0,20);
	var_03.origin = physicstrace(var_03.origin + var_04,var_03.origin - var_04);
	var_05 = getclosestpointonnavmesh(var_03.origin,self);
	var_06 = "goal";
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	var_0A = undefined;
	var_0B = isdefined(self.var_1FBB) && isdefined(level.var_EC85[self.var_1FBB]) && isdefined(level.var_EC85[self.var_1FBB][param_01]);
	if(!var_0B || distance2dsquared(var_03.origin,var_05) > 0.1)
	{
		scripts\sp\_utility::func_F3DC(var_05);
		self.var_15C = 8;
		var_06 = scripts\common\utility::func_13734("goal","bad_path");
		var_0B = 0;
	}
	else
	{
		var_07 = function_00CE(var_03.origin,var_03.angles,level.var_EC85[self.var_1FBB][param_01]);
		var_08 = getclosestpointonnavmesh(var_07,self);
		if(distance2dsquared(var_07,var_08) > 0.1)
		{
			var_0B = 0;
		}
		else
		{
			var_09 = var_07 + rotatevector(getmovedelta(level.var_EC85[self.var_1FBB][param_01],0,1),var_03.angles);
			var_0A = getclosestpointonnavmesh(var_09,self);
			if(distance2dsquared(var_09,var_0A) > 0.1)
			{
				var_0B = 0;
			}
			else
			{
				if(distance2dsquared(param_00,self.origin) < squared(100))
				{
					self.var_10E6D.var_C994 = 1;
				}

				var_03 lib_0B06::func_1ECE(self,param_01);
			}
		}
	}

	if(var_06 == "goal" && var_0B)
	{
		var_03 lib_0B06::func_1F35(self,param_01);
		var_0C = getclosestpointonnavmesh(self.origin,self);
		if(distance2dsquared(self.origin,var_0C) > 0.0001)
		{
			self method_80F1(var_0C,self.angles);
		}

		scripts\sp\_utility::func_F3DC(self.origin);
	}
}

//Function Number: 69
func_F397(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(level.var_10E6D) && isdefined(level.var_10E6D.var_74D5))
	{
		level.var_10E6D.var_74D5["event_" + param_00] = param_01;
	}
}