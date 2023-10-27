/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1274.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 24 ms
 * Timestamp: 10/27/2023 3:24:15 AM
*******************************************************************/

//Function Number: 1
func_52FD(param_00)
{
	level.var_50A7 = [];
	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		level.var_50A7[level.var_50A7.size] = func_05EE(1);
	}
}

//Function Number: 2
func_05EE(param_00)
{
	var_01 = (0,0,0);
	if(isdefined(level.var_5FEB))
	{
		var_01 = level.var_5FEB;
	}

	var_02 = spawn("script_model",var_01);
	var_02 setmodel("tag_origin");
	var_02.var_1D = (0,0,0);
	var_02 method_8511();
	var_02.var_15FF = param_00;
	var_02.var_A203 = 0;
	var_02.var_1A5 = "imageTimerEnt";
	return var_02;
}

//Function Number: 3
func_06AE()
{
	if(!isdefined(level.var_50A7))
	{
		func_52FD(1);
	}

	for(var_00 = 0;var_00 < level.var_50A7.size;var_00++)
	{
		var_01 = level.var_50A7[var_00];
		if(!var_01.var_A203)
		{
			var_01.var_A203 = 1;
			var_01 method_805B();
			var_01 method_8511();
			return var_01;
		}
	}

	var_01 = func_05EE(0);
	var_01.var_A203 = 1;
	level.var_50A7[level.var_50A7.size] = var_01;
	return var_01;
}

//Function Number: 4
func_062C(param_00)
{
	param_00 unlink();
	param_00.var_A203 = 0;
}

//Function Number: 5
func_0934(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	func_0594(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,undefined,undefined,undefined,param_0B);
}

//Function Number: 6
func_0986(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E)
{
	func_0594(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E);
}

//Function Number: 7
func_0594(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E)
{
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	if(!isdefined(param_07))
	{
		param_07 = 0;
	}

	if(!isdefined(param_08))
	{
		param_08 = 1;
	}

	if(!isdefined(param_09))
	{
		param_09 = 0;
	}

	if(!isdefined(param_0A))
	{
		param_0A = [];
	}

	if(!isdefined(param_0E))
	{
		param_0E = param_0A.size;
	}

	self.var_50A9 = func_0653();
	self.var_50A9.var_500F = func_06AE();
	self.var_50A9.var_C8 = self.var_50A9.var_500F getentitynumber();
	self.var_50A9.var_1B4 = int(param_03);
	self.var_50A9.var_C9 = param_04;
	self.var_50A9.var_DB = param_05;
	self.var_50A9.var_DC = param_06;
	self.var_50A9.var_18D = param_07;
	self.var_50A9.var_18E = 0;
	self.var_50A9.var_86 = param_08;
	self.var_50A9.var_87 = 0;
	self.var_50A9.var_BE = param_09;
	self.var_50A9.var_61 = gettime();
	self.var_50A9.var_83 = 0;
	if(param_0A.size > 0)
	{
		self.var_50A9.var_30 = param_0A[0];
		self.var_50A9.var_35 = 0;
	}

	if(param_0A.size > 1)
	{
		self.var_50A9.var_31 = param_0A[1];
		self.var_50A9.alpha = 0;
	}

	if(param_0A.size > 2)
	{
		self.var_50A9.var_32 = param_0A[2];
		self.var_50A9.var_37 = 0;
	}

	if(param_0A.size > 3)
	{
		self.var_50A9.allowpain = param_0A[3];
		self.var_50A9.var_38 = 0;
	}

	if(param_0A.size > 4)
	{
		self.var_50A9.var_34 = param_0A[4];
		self.var_50A9.var_39 = 0;
	}

	self.var_50A9.var_111 = param_0E;
	if(isdefined(param_0B))
	{
		self.var_50A9.var_1A4 = param_0B getentitynumber();
		self.var_50A9.var_1A6 = lib_0502::func_4713(param_0C);
		self.var_50A9.var_1A3 = lib_0502::func_4713(param_0D);
	}

	if(!function_0296(param_00))
	{
		func_5DC1(param_00,param_01,param_02);
		return;
	}

	self.var_50A9.var_500F.var_116 = param_00 + param_02;
}

//Function Number: 8
func_5DC1(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "tag_origin";
	}

	if(param_00 method_8445(param_01) != -1)
	{
		self.var_50A9.var_500F method_8449(param_00,param_01,param_02,(0,0,0));
		return;
	}

	self.var_50A9.var_500F.var_116 = param_00.var_116 + param_02;
	self.var_50A9.var_500F.var_1D = param_00.var_1D;
	self.var_50A9.var_500F method_8449(param_00);
}

//Function Number: 9
func_6F1A(param_00,param_01)
{
	if(!func_50AC())
	{
		return;
	}

	var_02 = !self.var_50A9.var_DC;
	if(isdefined(param_00) && self.var_50A9.var_C9 != param_00)
	{
		self.var_50A9.var_C9 = param_00;
		var_02 = 1;
	}

	if(!isdefined(param_01))
	{
		param_01 = self;
	}

	if(var_02)
	{
		var_03 = param_01.var_A23F - param_01.var_28D5;
		var_04 = param_01.var_A23F - var_03;
		self.var_50A9.var_1B4 = int(param_01.var_A23F);
		self.var_50A9.var_61 = gettime();
		self.var_50A9.var_83 = int(var_04);
		self.var_50A9.var_DB = 0;
		self.var_50A9.var_DC = 1;
	}
}

//Function Number: 10
func_6F1C(param_00,param_01,param_02,param_03)
{
	if(!func_50AC())
	{
		return;
	}

	if(isdefined(param_01) && self.var_50A9.var_C9 != param_01)
	{
		self.var_50A9.var_C9 = param_01;
	}

	if(isdefined(param_02))
	{
		self.var_50A9.var_18D = param_02;
	}

	if(isdefined(param_03))
	{
		self.var_50A9.var_86 = param_03;
	}

	self.var_50A9.var_1B4 = int(self.var_A23F);
	self.var_50A9.var_61 = gettime();
	self.var_50A9.var_83 = int(param_00);
	self.var_50A9.var_DB = 0;
	self.var_50A9.var_DC = 1;
}

//Function Number: 11
func_7DFB(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!func_50AC())
	{
		return;
	}

	var_07 = common_scripts\utility::func_562E(self.var_50A9.var_DC);
	var_08 = var_07;
	if(isdefined(param_01) && self.var_50A9.var_C9 != param_01)
	{
		self.var_50A9.var_C9 = param_01;
		var_08 = 1;
	}

	if((isdefined(param_02) && self.var_50A9.var_18D != param_02) || isdefined(param_03) && self.var_50A9.var_86 != param_03)
	{
		self.var_50A9.var_18D = param_02;
		self.var_50A9.var_86 = param_03;
		var_08 = 1;
	}

	var_09 = -1;
	if(isdefined(param_04))
	{
		var_0A = lib_0502::func_4713(param_04);
		if(self.var_50A9.var_1A3 != var_0A)
		{
			self.var_50A9.var_1A3 = var_0A;
			var_09 = var_0A;
			var_08 = 1;
		}
	}

	if(!isdefined(param_06))
	{
		param_06 = self;
	}

	if(param_00 == "taking" || param_00 == "losing")
	{
		self.var_50A9.var_1B4 = int(param_06.var_A23F / abs(param_06.var_A22B));
		var_0B = param_06.var_A23F - param_06.var_28D5 / abs(param_06.var_A22B);
		var_0C = self.var_50A9.var_1B4 - var_0B;
		self.var_50A9.var_83 = int(var_0C);
		if(param_00 == "taking")
		{
			self.var_50A9.var_DB = 0;
			self.var_50A9.var_83 = int(var_0C);
		}
		else
		{
			self.var_50A9.var_DB = 1;
			self.var_50A9.var_83 = int(var_0B);
		}

		var_08 = 1;
	}
	else if(param_00 == "ctf")
	{
		if(isdefined(param_05))
		{
			self.var_50A9.var_1B4 = int(param_05);
		}
		else
		{
			self.var_50A9.var_1B4 = int(param_06.var_A23F);
		}

		var_0B = self.var_50A9.var_1B4 - param_06.var_28D5;
		var_0C = self.var_50A9.var_1B4 - var_0B;
		self.var_50A9.var_83 = int(var_0C);
		self.var_50A9.var_DB = 0;
		var_08 = 1;
	}
	else if(param_00 == "build")
	{
		var_0D = maps\mp\gametypes\_gameobjects::func_45D4(param_06);
		self.var_50A9.var_1B4 = int(param_06.var_A23F / var_0D);
		var_0B = param_06.var_A23F - param_06.var_28D5 / var_0D;
		var_0C = self.var_50A9.var_1B4 - var_0B;
		self.var_50A9.var_83 = int(var_0C);
		var_08 = 1;
	}
	else if(param_00 == "none")
	{
		var_08 = 1;
	}

	if(var_08)
	{
		self.var_50A9.var_61 = gettime();
		self.var_50A9.var_DC = 0;
	}
}

//Function Number: 12
func_84E6(param_00)
{
	if(!func_50AC())
	{
		return;
	}

	self.var_50A9.var_C9 = param_00;
}

//Function Number: 13
set_image_timer_num_sections(param_00)
{
	if(!func_50AC())
	{
		return;
	}

	self.var_50A9.var_61 = gettime();
	self.var_50A9.var_111 = param_00;
}

//Function Number: 14
func_7D38(param_00)
{
	if(!func_50AC())
	{
		return;
	}

	self.var_50A9.var_61 = gettime();
	self.var_50A9.var_83 = 0;
	self.var_50A9.var_DC = 1;
	if(isdefined(param_00))
	{
		self.var_50A9.var_C9 = param_00;
	}
}

//Function Number: 15
func_7C95()
{
	if(!func_50AC())
	{
		return;
	}

	self notify("image_timer_removed");
	func_0654(self.var_50A9.var_59E1);
	if(isdefined(self) && isdefined(self.var_50A9.var_500F))
	{
		func_062C(self.var_50A9.var_500F);
		self.var_50A9.var_500F = undefined;
	}

	self.var_50A9 method_869E();
	self.var_50A9 = undefined;
}

//Function Number: 16
func_0654(param_00)
{
	if(isdefined(level.var_50AB) && isdefined(level.var_50AB[param_00]))
	{
		var_01 = level.var_50AB[param_00].var_D4 - 1;
		level.image_timer_indices[level.image_timer_indices.size] = var_01;
		level.var_50AB[param_00] = undefined;
	}
}

//Function Number: 17
func_50AD(param_00)
{
	if(!func_50AC())
	{
		return;
	}

	self.var_50A9.var_1A3 = lib_0502::func_4713(param_00);
	self.var_50A9.var_61 = gettime();
}

//Function Number: 18
func_0653()
{
	var_00 = 255;
	if(!isdefined(level.var_50AB))
	{
		level.var_50AB = [];
		level.image_timer_indices = [];
		for(var_01 = 0;var_01 < var_00;var_01++)
		{
			level.image_timer_indices[level.image_timer_indices.size] = var_01;
		}

		thread func_0652();
	}

	if(level.image_timer_indices.size <= 0)
	{
		iprintlnbold("Maxed out image timer index - this means we have used over " + var_00 + " icons in one game; Increase the number of icons if needed");
		return undefined;
	}

	var_02 = common_scripts\utility::func_F82(level.image_timer_indices);
	level.image_timer_indices = common_scripts\utility::func_F93(level.image_timer_indices,var_02);
	var_03 = "t" + var_02;
	level.var_50AB[var_03] = function_03A6();
	level.var_50AB[var_03].var_D4 = var_02 + 1;
	level.var_50AB[var_03].var_59E1 = var_03;
	return level.var_50AB[var_03];
}

//Function Number: 19
func_0652()
{
	level waittill("game_ended");
	foreach(var_01 in level.var_50AB)
	{
		if(isdefined(var_01.var_500F))
		{
			func_062C(var_01.var_500F);
			var_01.var_500F = undefined;
		}

		var_01 method_869E();
	}

	level.image_timer_indices = undefined;
	level.var_50AB = undefined;
}

//Function Number: 20
func_50AC()
{
	if(!isdefined(level.var_50AB))
	{
		return 0;
	}

	if(!isdefined(self.var_50A9))
	{
		return 0;
	}

	if(!isdefined(level.var_50AB[self.var_50A9.var_59E1]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
func_1130(param_00,param_01)
{
	if(!func_50AC())
	{
		return;
	}

	self.var_50A9 luaattach(param_00,param_01);
}