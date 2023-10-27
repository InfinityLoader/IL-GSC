/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3405.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 12 ms
 * Timestamp: 10/27/2023 12:27:05 AM
*******************************************************************/

//Function Number: 1
func_97B2()
{
	level.var_13D37 = [];
	level.var_13D59 = scripts\common\utility::getstructarray("window_entrance","targetname");
	scripts\common\utility::array_thread(level.var_13D59,::func_97A8);
}

//Function Number: 2
func_4F32()
{
	wait(5);
	for(;;)
	{
		var_00 = scripts\common\utility::getclosest(level.players[0].origin,level.var_13D59);
		var_01 = scripts\common\utility::getstructarray(var_00.target,"targetname");
		var_01 = scripts\common\utility::array_add_safe(var_01,var_00);
		foreach(var_03 in var_01)
		{
			var_04 = 0;
			if(isdefined(var_03.angles))
			{
				var_04 = var_03.angles[1];
			}

			var_05 = (0,1,0);
			if(func_9CD3(var_03))
			{
				var_05 = (1,0,0);
			}
		}

		wait(0.25);
	}
}

//Function Number: 3
func_97A8()
{
	self.var_6261 = 0;
	self.var_C2D0 = undefined;
	var_00 = getentarray(self.target,"targetname");
	if(var_00.size)
	{
		foreach(var_02 in var_00)
		{
			if(isdefined(var_02.script_noteworthy) && var_02.script_noteworthy == "clip")
			{
				self.clip = var_02;
				continue;
			}

			self.var_284D = var_02;
		}
	}

	self.var_284D.var_C1DE = 6;
	self.var_284D.var_2BEB = [];
	self.var_284D.var_2BEB[0] = "boarded";
	self.var_284D.var_2BEB[1] = "boarded";
	self.var_284D.var_2BEB[2] = "boarded";
	self.var_284D.var_2BEB[3] = "boarded";
	self.var_284D.var_2BEB[4] = "boarded";
	self.var_284D.var_2BEB[5] = "boarded";
	var_04 = scripts\common\utility::getstructarray(self.target,"targetname");
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06.script_noteworthy) && var_06.script_noteworthy == "attack_spot")
		{
			self.var_24C6 = var_06;
			continue;
		}

		var_06.var_C2D0 = undefined;
		var_06.var_6261 = 0;
		level.var_13D37[level.var_13D37.size] = var_06;
	}

	level.var_13D37[level.var_13D37.size] = self;
	var_08 = scripts\common\utility::getclosest(self.origin,scripts\common\utility::getstructarray("secure_window","script_noteworthy"));
	self.script_noteworthy = func_7D7E(var_08);
	self.script_label = "mid";
	if(isdefined(self.var_EED9) && self.var_EED9 == "extended")
	{
		self.var_2A9F = 1;
	}

	var_09 = anglestoright(self.angles);
	foreach(var_06 in var_04)
	{
		var_0B = var_06.origin - self.origin;
		var_0C = vectordot(var_0B,var_09);
		if(var_0C > 0)
		{
			var_06.script_label = "left";
		}
		else
		{
			var_06.script_label = "right";
		}

		if(scripts\common\utility::istrue(self.var_2A9F))
		{
			var_06.var_2A9F = 1;
		}
	}
}

//Function Number: 4
func_7D7E(param_00)
{
	var_01 = getentarray("spawn_volume","targetname");
	foreach(var_03 in var_01)
	{
		if(function_010F(param_00.origin,var_03))
		{
			return var_03.var_27C;
		}
	}

	return undefined;
}

//Function Number: 5
func_6259(param_00)
{
	param_00.var_6261 = 1;
	param_00.var_C2D0 = undefined;
	var_01 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03.var_C2D0 = undefined;
		var_03.var_6261 = 1;
	}
}

//Function Number: 6
func_55A8(param_00)
{
	param_00.var_6261 = 0;
	param_00.var_C2D0 = undefined;
	var_01 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03.var_C2D0 = undefined;
		var_03.var_6261 = 0;
	}
}

//Function Number: 7
enable_windows_in_area(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		func_6259(var_03);
	}
}

//Function Number: 8
func_7998(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.var_130C8;var_02++)
	{
		if(param_00.var_130D0[var_02] == param_01)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 9
func_E005(param_00)
{
	if(!isdefined(param_00.var_130D0))
	{
		return;
	}

	var_01 = func_7998(param_00,self);
	if(!isdefined(var_01))
	{
		return;
	}

	if(param_00.var_130C8 == 1)
	{
		param_00.var_130D0 = [];
		param_00.var_130C8 = 0;
		return;
	}

	param_00.var_130D0[var_01] = param_00.var_130D0[param_00.var_130C8 - 1];
	param_00.var_130D0[param_00.var_130C8 - 1] = undefined;
	param_00.var_130C8--;
}

//Function Number: 10
func_16D1(param_00)
{
	func_E005(param_00);
	if(!isdefined(param_00.var_130D0))
	{
		param_00.var_130D0 = [];
		param_00.var_130C8 = 0;
	}

	var_01 = param_00.var_130C8;
	param_00.var_130D0[var_01] = self;
	param_00.var_130C8++;
}

//Function Number: 11
func_61D1()
{
	foreach(var_01 in level.var_13D59)
	{
		func_6259(var_01);
	}
}

//Function Number: 12
func_7B4D(param_00)
{
	var_01 = scripts\common\utility::func_782F(param_00,level.var_13D59);
	foreach(var_03 in var_01)
	{
		if(!func_664D(var_03))
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 13
func_7B14(param_00,param_01)
{
	var_02 = sortbydistance(level.var_13D59,param_00);
	foreach(var_04 in var_02)
	{
		if(isdefined(param_01))
		{
			if(var_04 == param_01)
			{
				param_01 = undefined;
			}

			continue;
		}

		if(var_04.var_6261)
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 14
func_9BD6(param_00)
{
	return param_00.var_6261;
}

//Function Number: 15
func_664D(param_00)
{
	if(isdefined(param_00.var_284D) && param_00.var_284D.var_C1DE > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
func_DF34(param_00)
{
	param_00.var_C2D0 = undefined;
}

//Function Number: 17
func_3FF0(param_00)
{
	param_00.var_C2D0 = self;
}

//Function Number: 18
func_9CD3(param_00)
{
	if(isdefined(param_00.var_C2D0) && isalive(param_00.var_C2D0))
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
func_9CD2(param_00)
{
	return !func_9CD3(param_00);
}

//Function Number: 20
func_F95E()
{
	var_00 = anglestoright(self.angles);
	var_01 = scripts\common\utility::getstructarray(self.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_04 = var_03.origin - self.origin;
		var_05 = vectordot(var_04,var_00);
		if(var_05 > 0)
		{
			self.var_E529 = var_03;
			continue;
		}

		self.var_AB4E = var_03;
	}
}

//Function Number: 21
func_36CF()
{
	var_00 = (0,0,0);
	foreach(var_02 in self.var_130D0)
	{
		var_00 = var_00 + var_02.origin;
	}

	var_04 = (var_00[0] / self.var_130C8,var_00[1] / self.var_130C8,var_00[2] / self.var_130C8);
	var_05 = sortbydistance(self.var_130D0,var_04);
	return var_05[0];
}

//Function Number: 22
func_9CF6(param_00,param_01)
{
	var_02 = self.origin - param_00.origin;
	var_03 = (var_02[0],var_02[1],0);
	var_04 = vectordot(var_03,param_01);
	if(var_04 > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
func_7A29(param_00)
{
	if(!isdefined(param_00.var_AB4E) && !isdefined(param_00.var_E529))
	{
		param_00 func_F95E();
	}

	if(param_00.var_130C8 <= 1)
	{
		return param_00;
	}

	if(param_00.var_130C8 > 1)
	{
		var_02 = param_00 func_36CF();
		var_03 = anglestoright(param_00.angles);
		var_04 = function_02D3(param_00.angles);
		if(self == var_02)
		{
			return param_00;
		}

		if(isdefined(param_00.var_E529) && func_9CF6(var_02,var_03))
		{
			return param_00.var_E529;
		}

		if(isdefined(param_00.var_AB4E) && func_9CF6(var_02,var_04))
		{
			return param_00.var_AB4E;
		}
	}

	var_05 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	var_05 = scripts\common\utility::array_add_safe(var_05,param_00);
	var_06 = sortbydistance(var_05,self.origin);
	return var_06[0];
}

//Function Number: 24
func_7B4C(param_00)
{
	var_01 = func_7A29(param_00);
	if(isdefined(var_01) && func_9CD2(var_01))
	{
		return var_01;
	}

	var_02 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	var_02 = scripts\common\utility::array_add_safe(var_02,param_00);
	var_02 = scripts\common\utility::array_randomize(var_02);
	foreach(var_04 in var_02)
	{
		if(func_9CD2(var_04))
		{
			return var_04;
		}
	}

	if(isdefined(var_01))
	{
		return var_01;
	}

	return scripts\common\utility::random(var_02);
}

//Function Number: 25
func_F2E3(param_00,param_01,param_02)
{
	param_00.var_284D.var_2BEB[param_01] = param_02;
}

//Function Number: 26
func_7872(param_00,param_01)
{
	return param_00.var_284D.var_2BEB[param_01];
}

//Function Number: 27
func_7B12(param_00)
{
	for(var_01 = 0;var_01 < 6;var_01++)
	{
		if(param_00.var_284D.var_2BEB[var_01] == "boarded")
		{
			return var_01 + 1;
		}
	}
}

//Function Number: 28
func_7B13(param_00)
{
	for(var_01 = 5;var_01 >= 0;var_01--)
	{
		if(param_00.var_284D.var_2BEB[var_01] == "destroyed")
		{
			return var_01 + 1;
		}
	}
}

//Function Number: 29
func_DFCB(param_00,param_01)
{
	if(!func_664D(param_00))
	{
		return;
	}

	var_02 = scripts\common\utility::getstructarray("secure_window","script_noteworthy");
	var_03 = scripts\common\utility::getclosest(param_00.origin,var_02);
	if(!isdefined(param_01))
	{
		param_01 = param_00.var_284D.var_C1DE;
		if(param_01 > 6)
		{
			param_01 = 6;
		}
		else if(param_01 < 1)
		{
			param_01 = 1;
		}
	}

	param_00.var_284D func_F2D7("board_" + param_01,"destroy");
	param_00.var_284D.var_C1DE--;
	if(!scripts\common\utility::func_2286(level.current_interaction_structs,var_03))
	{
		level.current_interaction_structs = scripts\common\utility::array_add(level.current_interaction_structs,var_03);
	}

	var_03.var_55BA = 0;
	if(param_00.var_284D.var_C1DE < 1)
	{
		var_03.var_55BA = 0;
	}
}

//Function Number: 30
func_F2D7(param_00,param_01)
{
	if(param_00 == "all" && param_01 == "rebuild")
	{
		self setscriptablepartstate("board_1","instant_rebuild");
		self setscriptablepartstate("board_2","instant_rebuild");
		self setscriptablepartstate("board_3","instant_rebuild");
		self setscriptablepartstate("board_4","instant_rebuild");
		self setscriptablepartstate("board_5","instant_rebuild");
		self setscriptablepartstate("board_6","instant_rebuild");
		return;
	}

	self setscriptablepartstate(param_00,param_01);
}