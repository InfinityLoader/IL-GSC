/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_scriptedagents.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 356 ms
 * Timestamp: 10/27/2023 3:09:05 AM
*******************************************************************/

//Function Number: 1
func_0114(param_00,param_01)
{
	if(isdefined(self.var_6AFF))
	{
		self [[ self.var_6AFF ]](param_00,param_01);
	}
}

//Function Number: 2
func_0113()
{
	self notify("killanimscript");
}

//Function Number: 3
func_7201(param_00,param_01,param_02,param_03)
{
	func_71FC(param_00,0,param_01,param_02,param_03);
}

//Function Number: 4
func_71FC(param_00,param_01,param_02,param_03,param_04)
{
	self method_83D7(param_00,param_01);
	if(!isdefined(param_03))
	{
		param_03 = "end";
	}

	func_A79E(param_02,param_03,param_00,param_01,param_04);
}

//Function Number: 5
func_71F9(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self method_83D7(param_00,param_01,param_02);
	if(!isdefined(param_04))
	{
		param_04 = "end";
	}

	func_A79E(param_03,param_04,param_00,param_01,param_05);
}

//Function Number: 6
func_A79E(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = gettime();
	var_06 = undefined;
	var_07 = undefined;
	if(isdefined(param_02) && isdefined(param_03))
	{
		var_07 = getanimlength(self method_83D8(param_02,param_03));
	}

	for(;;)
	{
		self waittill(param_00,var_08);
		if(isdefined(var_07))
		{
			var_06 = gettime() - var_05 * 0.001 / var_07;
		}

		if(!isdefined(var_07) || var_06 > 0)
		{
			if(var_08 == param_01 || var_08 == "end" || var_08 == "anim_will_finish" || var_08 == "finish")
			{
				break;
			}
		}

		if(isdefined(param_04))
		{
			[[ param_04 ]](var_08,param_02,param_03,var_06);
		}
	}
}

//Function Number: 7
func_71F7(param_00,param_01)
{
	func_71FB(param_00,0,param_01);
}

//Function Number: 8
func_71FB(param_00,param_01,param_02)
{
	self method_83D7(param_00,param_01);
	wait(param_02);
}

//Function Number: 9
func_71F8(param_00,param_01,param_02,param_03)
{
	self method_83D7(param_00,param_01,param_02);
	wait(param_03);
}

//Function Number: 10
func_441C(param_00,param_01,param_02)
{
	var_03 = length2d(param_00);
	var_04 = param_00[2];
	var_05 = length2d(param_01);
	var_06 = param_01[2];
	var_07 = 1;
	var_08 = 1;
	if(isdefined(param_02) && param_02)
	{
		var_09 = (param_01[0],param_01[1],0);
		var_0A = vectornormalize(var_09);
		if(vectordot(var_0A,param_00) < 0)
		{
			var_07 = 0;
		}
		else if(var_05 > 0)
		{
			var_07 = var_03 / var_05;
		}
	}
	else if(var_05 > 0)
	{
		var_07 = var_03 / var_05;
	}

	if(abs(var_06) > 0.001 && var_06 * var_04 >= 0)
	{
		var_08 = var_04 / var_06;
	}

	var_0B = spawnstruct();
	var_0B.var_AAE3 = var_07;
	var_0B.var_1D9 = var_08;
	return var_0B;
}

//Function Number: 11
func_4414(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 10;
	}

	if(param_00 < 0)
	{
		return int(ceil(180 + param_00 - param_01 / 45));
	}

	return int(floor(180 + param_00 + param_01 / 45));
}

//Function Number: 12
func_34A6(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 18;
	}

	var_02 = param_00 + (0,0,param_01);
	var_03 = param_00 + (0,0,param_01 * -1);
	var_04 = self method_83EB(var_02,var_03,self.var_14F,self.var_BD,1);
	if(abs(var_04[2] - var_02[2]) < 0.1)
	{
		return undefined;
	}

	if(abs(var_04[2] - var_03[2]) < 0.1)
	{
		return undefined;
	}

	return var_04;
}

//Function Number: 13
func_1F5B(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	if(!isdefined(param_03))
	{
		param_03 = self.var_14F;
	}

	var_04 = (0,0,1) * param_02;
	var_05 = param_00 + var_04;
	var_06 = param_01 + var_04;
	return self method_83EC(var_05,var_06,param_03,self.var_BD - param_02,1);
}

//Function Number: 14
func_470B(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	var_03 = (0,0,1) * param_02;
	var_04 = param_00 + var_03;
	var_05 = param_01 + var_03;
	return self method_83EB(var_04,var_05,self.var_14F + 4,self.var_BD - param_02,1);
}

//Function Number: 15
func_466C(param_00)
{
	var_01 = getmovedelta(param_00);
	var_02 = self localtoworldcoords(var_01);
	var_03 = func_470B(self.var_116,var_02);
	var_04 = distance(self.var_116,var_03);
	var_05 = distance(self.var_116,var_02);
	return min(1,var_04 / var_05);
}

//Function Number: 16
func_802E(param_00,param_01,param_02,param_03)
{
	var_04 = func_464A(param_00);
	func_802D(param_00,var_04,param_01,param_02,param_03);
}

//Function Number: 17
func_802B(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_464A(param_00);
	func_802C(param_00,var_05,param_01,param_02,param_03,param_04);
}

//Function Number: 18
func_802C(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self method_83D7(param_00,param_01,param_02);
	func_802D(param_00,param_01,param_03,param_04,param_05);
}

//Function Number: 19
func_802D(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self method_83D8(param_00,param_01);
	var_06 = func_466C(var_05);
	self method_839A(var_06,1);
	func_71FC(param_00,param_01,param_02,param_03,param_04);
	self method_839A(1,1);
}

//Function Number: 20
func_464A(param_00)
{
	var_01 = self method_83DB(param_00);
	return randomint(var_01);
}

//Function Number: 21
func_4415(param_00)
{
	var_01 = vectortoangles(param_00);
	var_02 = angleclamp180(var_01[1] - self.var_1D[1]);
	return func_4414(var_02);
}