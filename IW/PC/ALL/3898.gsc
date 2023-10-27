/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3898.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 13 ms
 * Timestamp: 10/27/2023 12:31:10 AM
*******************************************************************/

//Function Number: 1
func_FFE6()
{
	if(isdefined(self.var_55B0) && self.var_55B0)
	{
		return 0;
	}

	if(isdefined(self.var_10C) && lib_0A1B::func_298E())
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

	if(isdefined(self.var_205) && self.var_205.type == "Cover Prone" || self.var_205.type == "Conceal Prone")
	{
		return 0;
	}

	if(!lib_0A1A::func_232B(param_01,"cover_approach"))
	{
		return 0;
	}

	if(!isdefined(self.var_20EE))
	{
		return 0;
	}

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

	if(!func_9D4C(param_00,param_01,param_02,var_04))
	{
		return 0;
	}

	var_05 = 0;
	if(isdefined(param_03) && isarray(param_03) && param_03.size >= 2 && param_03[1])
	{
		var_05 = 1;
	}

	self.var_2303.var_7360 = lib_0A1B::func_293B();
	self.var_2303.var_11068 = func_3721(param_00,param_02,var_04,var_05);
	if(!isdefined(self.var_2303.var_11068))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
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

	if(isdefined(self.var_205) && self.var_205.type == "Cover Prone" || self.var_205.type == "Conceal Prone")
	{
		return 0;
	}

	if(!lib_0A1A::func_232B(param_01,"cover_approach"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
func_10093(param_00,param_01,param_02,param_03)
{
	return func_1008A(param_00,param_01,param_02,param_03);
}

//Function Number: 7
func_10095(param_00,param_01,param_02,param_03)
{
	return func_1008A(param_00,param_01,param_02,param_03);
}

//Function Number: 8
func_10091(param_00,param_01,param_02,param_03)
{
	if(lib_0A1B::func_2941())
	{
		return 0;
	}

	return func_1008A(param_00,param_01,param_02,param_03);
}

//Function Number: 9
func_9D4C(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	if(isdefined(self.var_2303.var_4C86.var_22F1))
	{
		return var_04 == "Custom";
	}

	if(!isdefined(self.var_205))
	{
		return var_04 == "Exposed";
	}

	switch(var_04)
	{
		case "Exposed":
			return (self.var_205.type == "Path" || self.var_205.type == "Exposed") && self.var_205 method_80B1("stand");

		case "Exposed Crouch":
			if(lib_0A1B::func_292C() != "crouch")
			{
				return 0;
			}
			return (self.var_205.type == "Path" || self.var_205.type == "Exposed") && self.var_205 method_80B1("crouch");

		case "Cover Crouch":
			return self.var_205.type == "Cover Crouch" || self.var_205.type == "Conceal Crouch";

		case "Cover Stand":
			return self.var_205.type == "Cover Stand" || self.var_205.type == "Conceal Stand";

		case "Cover Prone":
			return self.var_205.type == "Cover Prone" || self.var_205.type == "Conceal Prone";

		case "Cover Left":
			return self.var_205.type == "Cover Left" && self.var_205 method_80B1("stand");

		case "Cover Left Crouch":
			return self.var_205.type == "Cover Left" && self.var_205 method_80B1("crouch");

		case "Cover Right":
			return self.var_205.type == "Cover Right" && self.var_205 method_80B1("stand");

		case "Cover Right Crouch":
			return self.var_205.type == "Cover Right" && self.var_205 method_80B1("crouch");
	}

	return var_04 == self.var_205.type;
}

//Function Number: 10
func_3E97(param_00,param_01,param_02)
{
	return self.var_2303.var_11068;
}

//Function Number: 11
func_3721(param_00,param_01,param_02,param_03)
{
	var_04 = func_7DD6();
	if(isdefined(var_04))
	{
		var_05 = var_04.origin;
	}
	else
	{
		var_05 = self.var_233;
	}

	var_06 = func_7E54();
	var_07 = self.var_20EE;
	var_08 = vectortoangles(var_07);
	if(isdefined(var_06))
	{
		var_09 = angleclamp180(var_06[1] - var_08[1]);
	}
	else if(isdefined(var_05) && var_05.type != "Path")
	{
		var_09 = angleclamp180(var_05.angles[1] - var_09[1]);
	}
	else
	{
		var_0A = var_06 - self.origin;
		var_0B = vectortoangles(var_0A);
		var_09 = angleclamp180(var_0B[1] - var_08[1]);
	}

	var_0C = function_02F9(var_09,22.5);
	var_0D = param_01;
	if(param_02 == "Custom")
	{
		var_0E = func_8174(self.var_2303.var_4C86.var_22F1,undefined,self.var_2303.var_4C86.var_22F6);
		var_0D = self.var_2303.var_4C86.var_22F1;
	}
	else
	{
		var_0E = func_8174(param_02,undefined,var_04);
	}

	var_0F = func_8177();
	var_10 = var_05 - self.origin;
	var_11 = lengthsquared(var_10);
	var_12 = var_0E[var_0C];
	if(!isdefined(var_12))
	{
		return undefined;
	}

	var_13 = self method_80FD(var_0D,var_12);
	var_14 = getmovedelta(var_13);
	var_15 = getangledelta(var_13);
	var_16 = length(self getvelocity());
	var_17 = var_16 * 0.053;
	var_18 = length(var_10);
	var_19 = length(var_14);
	if(abs(var_18 - var_19) > var_17)
	{
		return undefined;
	}

	if(var_11 < lengthsquared(var_14))
	{
		return undefined;
	}

	var_1A = func_36D9(var_0F.var_D699,var_0F.var_130[1],var_14,var_15);
	var_1B = getclosestpointonnavmesh(var_0F.var_D699,self);
	var_1C = func_36D9(var_1B,var_0F.var_130[1],var_14,var_15);
	var_1D = self method_84AC();
	var_1E = param_02 == "Cover Left" || param_02 == "Cover Right" || param_02 == "Cover Left Crouch" || param_02 == "Cover Right Crouch";
	if(var_1E && var_0C == 0 || var_0C == 8 || var_0C == 7 || var_0C == 1)
	{
		var_1F = undefined;
		var_20 = undefined;
		var_21 = getnotetracktimes(var_13,"corner");
		if(var_21.size > 0)
		{
			var_1F = getmovedelta(var_13,0,var_21[0]);
			var_20 = var_21[0];
		}
		else
		{
			var_22 = undefined;
			var_23 = undefined;
			if(param_02 == "Cover Left" || param_02 == "Cover Left Crouch")
			{
				var_22 = "left";
				if(var_0C == 7)
				{
					var_23 = "7";
				}
				else if(var_0C == 0 || var_0C == 8)
				{
					var_23 = "8";
				}
			}
			else if(param_02 == "Cover Right" || param_02 == "Cover Right Crouch")
			{
				var_22 = "right";
				if(var_0C == 0 || var_0C == 8)
				{
					var_23 = "8";
				}
				else if(var_0C == 1)
				{
					var_23 = "9";
				}
			}

			if(isdefined(var_22) && isdefined(var_23))
			{
				var_1F = func_81DF(param_00,param_01,var_23,param_03);
				var_20 = func_814C(param_00,param_01,var_23,param_03);
			}
		}

		if(isdefined(var_1F))
		{
			var_1F = rotatevector(var_1F,(0,var_0F.var_130[1] - var_15,0));
			var_1F = var_1C + var_1F;
			var_24 = navtrace(var_1D,var_1F,self,1);
			if(var_24["fraction"] >= 0.9 || navisstraightlinereachable(var_1D,var_1F,self))
			{
				var_25 = spawnstruct();
				var_25.var_11060 = var_12;
				var_25.var_3F = var_0C;
				var_25.var_2C5 = var_1A;
				var_25.var_3E = var_15;
				var_25.angles = var_0F.angles;
				var_25.var_130 = var_0F.var_130;
				var_25.var_1F3 = var_14;
				var_25.var_357 = var_1F;
				var_25.var_2BD = var_20;
				return var_25;
			}
		}
	}
	else
	{
		var_24 = navtrace(var_1E,var_1C,self,1);
		var_26 = var_24["fraction"] >= 0.9 || navisstraightlinereachable(var_1E,var_1C,self);
		if(!var_26)
		{
			var_27 = self method_841E();
			var_26 = var_27 < distance(var_1E,var_1C) + 8;
		}

		if(var_26)
		{
			var_25 = spawnstruct();
			var_25.var_11060 = var_13;
			var_25.var_3F = var_0D;
			var_25.var_2C5 = var_1B;
			var_25.var_3E = var_16;
			var_25.angles = var_10.angles;
			var_25.var_130 = var_10.var_130;
			var_25.var_11069 = var_15;
			var_25.var_22ED = var_06;
			return var_25;
		}
	}

	return undefined;
}

//Function Number: 12
func_CECA(param_00,param_01)
{
	self endon("runto_arrived");
	self endon(param_01 + "_finished");
	var_02 = self.var_15B;
	for(;;)
	{
		self waittill("path_set");
		var_03 = self.var_15B;
		if(!self.var_15D)
		{
			break;
		}

		if(distancesquared(var_02,var_03) > 1)
		{
			break;
		}

		var_02 = var_03;
	}

	lib_0A1A::func_2330(param_01,"abort");
}

//Function Number: 13
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

//Function Number: 14
func_136F5(param_00)
{
	self endon(param_00 + "_finished");
	self endon("waypoint_reached");
	self endon("waypoint_aborted");
	wait(2);
}

//Function Number: 15
func_CEAA(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = func_7DD6();
	var_05 = lib_0A1D::func_2337(param_00,param_01);
	if(!isdefined(var_05))
	{
		lib_0A1A::func_2330(param_01,"abort",undefined);
		return;
	}

	var_06 = lib_0A1A::func_2340();
	if(!isdefined(var_06))
	{
		var_06 = 1;
	}

	var_07 = var_05.var_130;
	var_08 = var_05.var_3F;
	var_09 = (0,var_07[1] - var_05.var_3E,0);
	var_0A = self method_80FD(param_01,var_05.var_11060);
	var_0B = getanimlength(var_0A);
	var_0B = var_0B * 1 / var_06;
	self method_8396(var_05.var_2C5,var_09[1],var_0B);
	lib_0A1D::func_2365(param_00,param_01,param_02,var_05.var_11060,var_06);
}

//Function Number: 16
func_22EA()
{
	self endon("killanimscript");
	self waittill(self.var_22E5 + "_finished");
}

//Function Number: 17
func_7DD6()
{
	if(isdefined(self.var_28B))
	{
		return self.var_28B;
	}

	if(isdefined(self.var_205))
	{
		return self.var_205;
	}

	if(isdefined(self.var_24A) && isdefined(self.var_233) && distance2dsquared(self.var_24A.origin,self.var_233) < 36)
	{
		return self.var_24A;
	}

	return undefined;
}

//Function Number: 18
func_7E54()
{
	if(isdefined(self.var_2303.var_4C86.var_22E3))
	{
		return self.var_2303.var_4C86.var_22E3;
	}

	return undefined;
}

//Function Number: 19
func_8177()
{
	var_00 = spawnstruct();
	var_01 = func_7DD6();
	if(isdefined(var_01) && var_01.type != "Path")
	{
		var_00.var_D699 = var_01.origin;
		var_00.angles = var_01.angles;
		var_00.var_130 = (0,scripts\asm\shared_utility::func_7FF7(var_01),0);
	}
	else
	{
		var_00.var_D699 = self.var_233;
		var_02 = self getvelocity();
		var_03 = self method_813A();
		if(lengthsquared(var_02) > 1)
		{
			var_00.angles = vectortoangles(var_00.var_D699 - self.origin);
		}
		else
		{
			var_00.angles = vectortoangles(var_03);
		}

		var_00.var_130 = var_00.angles;
	}

	var_04 = func_7E54();
	if(isdefined(var_04))
	{
		var_00.angles = var_04;
		var_00.var_130 = var_00.angles;
	}

	return var_00;
}

//Function Number: 20
func_36D9(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 - param_03;
	var_05 = (0,var_04,0);
	var_06 = rotatevector(param_02,var_05);
	return param_00 - var_06;
}

//Function Number: 21
func_8174(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[5] = lib_0A1A::func_235C(1,param_00,param_02);
	var_03[4] = lib_0A1A::func_235C(2,param_00,param_02);
	var_03[3] = lib_0A1A::func_235C(3,param_00,param_02);
	var_03[6] = lib_0A1A::func_235C(4,param_00,param_02);
	var_03[2] = lib_0A1A::func_235C(6,param_00,param_02);
	var_03[7] = lib_0A1A::func_235C(7,param_00,param_02);
	var_03[0] = lib_0A1A::func_235C(8,param_00,param_02);
	var_03[1] = lib_0A1A::func_235C(9,param_00,param_02);
	var_03[8] = var_03[0];
	return var_03;
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
	return undefined;
}

//Function Number: 24
func_1008F(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_20EE))
	{
		return 0;
	}

	var_04 = undefined;
	if(isdefined(param_03))
	{
		if(!isarray(param_03))
		{
			var_04 = param_03;
		}
		else if(param_03.size < 1)
		{
			var_04 = "Exposed";
		}
		else
		{
			var_04 = param_03[0];
		}
	}
	else
	{
		var_04 = "Exposed";
	}

	if(!func_9D4C(param_00,param_01,param_02,var_04))
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

	self.var_2303.var_7360 = lib_0A1B::func_293B();
	self.var_2303.var_11068 = func_3721(param_00,param_02,var_04,var_07);
	if(!isdefined(self.var_2303.var_11068))
	{
		return 0;
	}

	return 1;
}