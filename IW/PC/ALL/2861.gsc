/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2861.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 12:24:19 AM
*******************************************************************/

//Function Number: 1
func_6B3D()
{
	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}

	if(self.var_ED8B == "path" || self.var_ED8B == "turn")
	{
		self.var_1366C = 2;
	}
	else
	{
		self.var_1366C = 0;
	}

	switch(self.var_ED8B)
	{
		case "traverse":
			if(isdefined(self.target))
			{
				var_00 = function_00B4(self.target,"targetname");
				if(!var_00.size)
				{
					if(isdefined(self.var_EE01))
					{
						var_00 = function_00B4(self.var_EE01,"script_linkname");
					}
				}
	
				if(var_00.size > 0)
				{
					foreach(var_02 in var_00)
					{
						if(var_02.type == "Begin")
						{
							self.var_126CD = var_02.var_48;
						}
					}
				}
	
				var_04 = scripts\common\utility::getstructarray(self.target,"targetname");
				if(isdefined(self.var_EE01))
				{
					var_04 = scripts\common\utility::array_combine(var_04,scripts\common\utility::getstructarray(self.var_EE01,"script_linkname"));
				}
	
				foreach(var_06 in var_04)
				{
					if(isdefined(var_06.var_1FA2))
					{
						self.origin = var_06.origin;
						self.angles = var_06.angles;
					}
				}
			}
			break;

		case "animation":
			break;
	}

	func_6B29();
	func_6B28();
	func_6B27();
	scripts\common\utility::func_136F7();
	switch(self.var_ED8B)
	{
		case "animation":
			self.var_1EEF = spawnstruct();
			self.var_1EEF.origin = self.origin;
			self.var_1EEF.angles = self.angles;
			var_08 = scripts\sp\_utility::func_7DC3(self.var_1FA2);
			var_09 = function_00CE(self.origin,self.angles,var_08);
			var_0A = function_00CD(self.origin,self.angles,var_08);
			self.origin = var_09;
			self.angles = var_0A;
			break;
	}
}

//Function Number: 2
func_6B29()
{
	switch(self.var_ED8B)
	{
		case "cover_left":
			self.type = "Cover Left";
			break;

		case "cover_right":
			self.type = "Cover Right";
			break;

		case "cover_crouch":
			self.type = "Cover Crouch";
			break;

		case "cover_stand":
			self.type = "Cover Stand";
			break;
	}
}

//Function Number: 3
func_6B28()
{
	if(!isdefined(self.var_EE79))
	{
		return;
	}

	var_00 = strtok(self.var_EE79," ");
	foreach(var_02 in var_00)
	{
		if(!isdefined(level.var_6B23[var_02]))
		{
			level.var_6B23[var_02] = [];
		}

		level.var_6B23[var_02] = scripts\common\utility::array_add(level.var_6B23[var_02],self);
	}
}

//Function Number: 4
func_6B27()
{
	if(!isdefined(self.var_2AF))
	{
		self.var_2AF = 0;
	}

	if(!self.var_2AF & 64)
	{
		var_00 = 32 * anglestoup(self.angles);
		var_01 = -20000 * anglestoup(self.angles);
		var_02 = scripts\common\trace::func_DCED(self.origin + var_00,self.origin + var_01,undefined,scripts\common\trace::func_4956());
		if(var_02["hittype"] == "hittype_none")
		{
		}

		self.origin = var_02["position"];
		if(self.var_2AF & 32)
		{
			if(isdefined(var_02["entity"]))
			{
				self.var_8625 = var_02["entity"];
				self.var_862A = self.var_8625 scripts\sp\_utility::func_13DCC(self.origin);
				if(!isdefined(self.angles))
				{
					self.angles = (0,0,0);
				}

				self.var_8627 = self.angles - self.var_8625.angles;
			}
		}
	}

	if(self.var_2AF & 8)
	{
		func_6B38(1);
	}

	if(self.var_2AF & 16)
	{
		self.var_1366C = 2;
	}

	self.var_C02F = [];
}

//Function Number: 5
func_F97C()
{
	level.var_6B23 = [];
	foreach(var_01 in level.struct)
	{
		if(isdefined(var_01.var_ED8B))
		{
			var_01 thread func_6B3D();
		}
	}
}

//Function Number: 6
func_9BE0()
{
	return isdefined(self.var_ED8B);
}

//Function Number: 7
func_6B3E()
{
	if(!isdefined(self.var_8625))
	{
		return;
	}

	self.origin = self.var_8625 method_81E7(self.var_862A);
	var_00 = spawn("script_origin",(0,0,0));
	var_00.angles = self.var_8625.angles;
	var_00 method_8002(self.var_8627[0]);
	var_00 method_8004(self.var_8627[1]);
	var_00 method_8003(self.var_8627[2]);
	self.angles = var_00.angles;
	var_00 delete();
}

//Function Number: 8
func_6B1F()
{
	var_00 = [];
	var_01 = 0;
	if(isdefined(self.var_2AF))
	{
		var_01 = self.var_2AF;
	}

	if(self.var_ED8B == "cover_left")
	{
		if(!var_01 & 1)
		{
			var_00 = scripts\common\utility::array_add(var_00,"cover_left");
		}

		if(!var_01 & 2)
		{
			var_00 = scripts\common\utility::array_add(var_00,"cover_left_crouch");
		}
	}
	else if(self.var_ED8B == "cover_right")
	{
		if(!var_01 & 1)
		{
			var_00 = scripts\common\utility::array_add(var_00,"cover_right");
		}

		if(!var_01 & 2)
		{
			var_00 = scripts\common\utility::array_add(var_00,"cover_right_crouch");
		}
	}
	else if(self.var_ED8B == "cover_stand")
	{
		var_00 = scripts\common\utility::array_add(var_00,"cover_stand");
	}
	else if(self.var_ED8B == "cover_crouch")
	{
		var_00 = scripts\common\utility::array_add(var_00,"cover_crouch");
	}
	else
	{
		var_00 = scripts\common\utility::array_add(var_00,"exposed");
	}

	if(var_00.size == 0)
	{
	}

	return var_00;
}

//Function Number: 9
func_6B20()
{
	if(!isdefined(self.target))
	{
		return undefined;
	}

	var_00 = func_6B1D();
	if(var_00.size)
	{
		return scripts\common\utility::random(var_00);
	}

	return undefined;
}

//Function Number: 10
func_6B1D()
{
	var_00 = [];
	if(!isdefined(self.target))
	{
		return var_00;
	}

	var_01 = scripts\common\utility::getstructarray(self.target,"targetname");
	foreach(var_03 in var_01)
	{
		if(!var_03 func_9BE0())
		{
			continue;
		}

		if(!var_03 func_6B34())
		{
			continue;
		}

		var_00 = scripts\common\utility::array_add(var_00,var_03);
	}

	return var_00;
}

//Function Number: 11
func_6B22()
{
	if(!isdefined(self.target))
	{
		return 0;
	}

	var_00 = scripts\common\utility::getstructarray(self.target,"targetname");
	var_01 = 0;
	foreach(var_03 in var_00)
	{
		if(!var_03 func_9BE0())
		{
			continue;
		}

		if(!var_03 func_6B34())
		{
			continue;
		}

		var_01++;
	}

	return var_01;
}

//Function Number: 12
func_6B1E(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = spawn("script_origin",(0,0,0));
	if(isdefined(self.angles))
	{
		var_01.angles = self.angles;
	}

	if(isdefined(self.type))
	{
		if(param_00 && isdefined(level.var_6A63))
		{
			if(isdefined(level.var_6A63[self.type]))
			{
				var_01 method_8004(level.var_6A63[self.type]);
			}
		}
		else if(isdefined(level.var_6A64))
		{
			if(isdefined(level.var_6A64[self.type]))
			{
				var_01 method_8004(level.var_6A64[self.type]);
			}
		}
	}

	var_02 = var_01.angles;
	var_01 delete();
	return var_02;
}

//Function Number: 13
func_6B21(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_04[0]["origin"] = param_01;
	var_04[0]["dist"] = 0;
	var_04[0]["radius"] = 0;
	var_04[0]["node"] = undefined;
	var_04[0]["total_dist"] = 0;
	var_05 = 1;
	var_06 = 200;
	for(;;)
	{
		var_07 = var_04.size;
		var_08 = undefined;
		if(var_05)
		{
			var_08 = param_00;
			var_05 = 0;
		}
		else
		{
			var_08 = var_04[var_07 - 1]["node"] func_6B20();
		}

		if(!isdefined(var_08))
		{
			break;
		}

		var_04[var_07]["node"] = var_08;
		var_09 = var_08.origin;
		if(isdefined(var_08.var_257))
		{
			if(!isdefined(self.var_5CC2))
			{
				self.var_5CC2 = -1 + randomfloat(2);
			}

			if(!isdefined(var_08.angles))
			{
				var_08.angles = (0,0,0);
			}

			var_0A = anglestoforward(var_08.angles);
			var_0B = anglestoright(var_08.angles);
			var_0C = anglestoup(var_08.angles);
			var_0D = (0,self.var_5CC2 * var_08.var_257,0);
			var_09 = var_09 + var_0A * var_0D[0];
			var_09 = var_09 + var_0B * var_0D[1];
			var_09 = var_09 + var_0C * var_0D[2];
		}

		var_04[var_07]["origin"] = var_09;
		var_04[var_07]["angles"] = var_08 func_6B1E(param_02);
		if(var_07 > 0)
		{
			var_0E = var_09 - var_04[var_07 - 1]["origin"];
			var_04[var_07 - 1]["dist"] = length(var_0E);
			var_04[0]["total_dist"] = var_04[0]["total_dist"] + var_04[var_07 - 1]["dist"];
			var_04[var_07 - 1]["to_next_node"] = vectornormalize(var_0E);
			if(isdefined(var_08.var_257))
			{
				var_04[var_07 - 1]["radius"] = var_08.var_257;
			}
			else
			{
				var_04[var_07 - 1]["radius"] = var_06;
			}
		}

		var_0F = param_03 && var_07 == 1;
		if(var_08 func_6B2D(var_0F))
		{
			break;
		}
	}

	var_04[var_07]["dist"] = 0;
	var_04[var_07]["radius"] = 0;
	var_04[var_07]["to_next_node"] = var_04[var_07 - 1]["to_next_node"];
	return var_04;
}

//Function Number: 14
func_6B34()
{
	if(isdefined(self.var_55BA))
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
func_6B2D(param_00)
{
	if(func_6B2A() && !param_00)
	{
		return 1;
	}

	if(func_6B32() && !param_00)
	{
		return 1;
	}

	if(func_6B33() && !param_00)
	{
		return 1;
	}

	if(func_6B22() == 0)
	{
		return 1;
	}

	if(func_6B30())
	{
		return 0;
	}

	if(func_6B35() && param_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 16
func_6B38(param_00)
{
	if(param_00)
	{
		self.var_55BA = 1;
		return;
	}

	self.var_55BA = undefined;
}

//Function Number: 17
func_6B24(param_00,param_01)
{
	if(isdefined(level.var_6B23[param_00]))
	{
		foreach(var_03 in level.var_6B23[param_00])
		{
			var_03 func_6B38(param_01);
		}
	}
}

//Function Number: 18
func_6B3B(param_00)
{
	self.var_C951 = param_00;
}

//Function Number: 19
func_6B1B()
{
	self.var_C951 = undefined;
}

//Function Number: 20
func_6B37(param_00)
{
	self.var_C02F[self.var_C02F.size] = param_00;
}

//Function Number: 21
func_6B2B(param_00)
{
	if(self.var_C02F.size <= 0)
	{
		return 0;
	}

	foreach(var_02 in self.var_C02F)
	{
		if(var_02 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 22
func_6B36(param_00)
{
	var_01 = [];
	foreach(var_03 in self.var_C02F)
	{
		if(var_03 != param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	self.var_C02F = var_01;
}

//Function Number: 23
func_6B1A()
{
	self.var_C02F = [];
}

//Function Number: 24
func_6B3C()
{
	self.var_1366C = 0;
}

//Function Number: 25
func_6B39()
{
	self.var_1366C = 1;
}

//Function Number: 26
func_6B3A()
{
	self.var_1366C = 2;
}

//Function Number: 27
func_6B35()
{
	return self.var_1366C == 0;
}

//Function Number: 28
func_6B2E()
{
	return self.var_1366C == 1;
}

//Function Number: 29
func_6B30()
{
	return self.var_1366C == 2;
}

//Function Number: 30
func_6B2F()
{
	return isdefined(self.var_8625);
}

//Function Number: 31
func_6B2C()
{
	return isdefined(self.var_55BA);
}

//Function Number: 32
func_6B33()
{
	return self.var_ED8B == "turn";
}

//Function Number: 33
func_6B32()
{
	return self.var_ED8B == "traverse" && isdefined(self.var_126CD);
}

//Function Number: 34
func_6B2A()
{
	return self.var_ED8B == "animation";
}

//Function Number: 35
func_6B19()
{
	return !self.var_2AF & 128;
}

//Function Number: 36
func_6B18()
{
	return !self.var_2AF & 256;
}

//Function Number: 37
func_6B1C()
{
}