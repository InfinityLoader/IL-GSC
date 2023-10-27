/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2589.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:23:25 AM
*******************************************************************/

//Function Number: 1
func_234D(param_00)
{
	lib_0A1A::func_234E();
	self.var_2303 = spawnstruct();
	self.var_2303.var_1FC5 = [];
	self.var_2303.var_7360 = 0;
	self.var_164D = [];
	self.var_238F = param_00;
	self.var_718F = ::func_230F;
	self.var_7193 = ::func_235A;
	self.var_7192 = ::func_2347;
	self.var_7191 = ::func_2336;
	lib_0A1A::func_2351(param_00,1);
	self.var_1491 = spawnstruct();
	self.var_1491.var_D6A5 = "stand";
	self.var_1491.var_85E2 = "stand";
	self.var_1491.var_BCC8 = "stop";
	self.var_1491.var_10E19 = "stop";
	self.var_1491.var_10930 = "none";
	self.var_1491.var_870D = "none";
	self.var_1491.var_D8BD = -1;
	self.var_1491.var_BE98 = 0;
	self.var_1491.var_4401 = gettime();
	self.var_1491.var_A981 = gettime();
	self.var_1491.var_112CB = 0;
	self.var_1491.var_55FC = !self method_8198();
	self.var_1491.var_AFFF = 0;
	self.var_1491.var_C888 = 0;
	self.var_1491.var_A9ED = 0;
	self.var_1491.var_BF84 = 0;
	self.var_1491.var_DD61 = 0.8;
	self.var_1491.var_D707 = undefined;
	self.var_1491.var_10B53 = "stand";
	self.var_1491.var_B8D6 = 0;
	self.var_1491.var_C043 = 0;
	self.var_1491.var_B8D6 = 0;
	self.var_1491.var_B8D8 = 0;
	self.var_1491.var_5605 = 0;
}

//Function Number: 2
func_C878()
{
	self endon("death");
	self endon("terminate_ai_threads");
	for(;;)
	{
		self waittill("pain");
		if(isdefined(self.var_71D0))
		{
			if(![[ self.var_71D0 ]]())
			{
				continue;
			}
		}
		else if(!func_1004C())
		{
			continue;
		}

		foreach(var_04, var_01 in self.var_164D)
		{
			var_02 = var_01.var_4BC0;
			var_03 = level.var_2303[var_04].var_10E2F[var_02];
			if(!isdefined(var_03.var_C87F))
			{
				continue;
			}

			lib_0A1A::func_2388(var_04,var_02,var_03,var_03.var_116FB);
			lib_0A1A::func_238A(var_04,var_03.var_C87F,0.2,undefined,undefined,var_03.var_C87C);
		}
	}
}

//Function Number: 3
func_126E5()
{
	self endon("death");
	self endon("terminate_ai_threads");
	for(;;)
	{
		self waittill("traverse_begin",var_00,var_01);
		var_02 = self.var_238F;
		var_03 = level.var_2303[var_02];
		var_04 = var_03.var_10E2F[var_00];
		if(!isdefined(var_04))
		{
			var_00 = "traverse_external";
		}

		var_05 = self.var_164D[var_02].var_4BC0;
		var_06 = var_03.var_10E2F[var_05];
		lib_0A1A::func_2388(var_02,var_05,var_06,var_06.var_116FB);
		lib_0A1A::func_238A(var_02,var_00,0.2,undefined,undefined,undefined);
	}
}

//Function Number: 4
func_1004C()
{
	var_00 = 300;
	if(isdefined(self.allowpain) && self.allowpain == 0)
	{
		return 0;
	}

	if(!lib_0A1B::func_298E())
	{
		if(isdefined(self.var_233))
		{
			if(self method_841E() < var_00)
			{
				return 0;
			}

			var_01 = self method_8148();
			if(isdefined(var_01))
			{
				var_02 = distancesquared(self.origin,var_01.origin);
				if(var_02 < var_00 * var_00)
				{
					return 0;
				}
			}
		}
	}

	return 1;
}

//Function Number: 5
func_235F(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_01 + "_finished");
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_05 = lib_0A1A::func_2341(param_00,param_01);
	for(;;)
	{
		var_06 = func_2337(param_00,param_01);
		self method_82AF(param_01,var_06,param_03);
		scripts\mp\agents\_scriptedagents::func_1384C(param_01,"end",param_01,var_06,var_05);
	}
}

//Function Number: 6
func_2345(param_00,param_01,param_02,param_03)
{
	lib_0A1A::func_2330(param_01,param_00);
}

//Function Number: 7
func_2365(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_01 + "_finished");
	var_05 = lib_0A1A::func_2341(param_00,param_01);
	if(isdefined(param_04))
	{
		scripts\mp\agents\_scriptedagents::func_CED2(param_01,param_03,param_04,param_01,"end",var_05);
		return;
	}

	scripts\mp\agents\_scriptedagents::func_CED5(param_01,param_03,param_01,"end",var_05);
}

//Function Number: 8
func_2366(param_00,param_01,param_02,param_03)
{
	func_2364(param_00,param_01,param_02,param_03);
}

//Function Number: 9
func_2364(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = func_2337(param_00,param_01);
	var_05 = lib_0A1A::func_2341(param_00,param_01);
	scripts\mp\agents\_scriptedagents::func_CED5(param_01,var_04,param_01,"end",var_05);
}

//Function Number: 10
func_2367(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	var_04 = func_2337(param_00,param_01);
	var_05 = lib_0A1A::func_2341(param_00,param_01);
	scripts\mp\agents\_scriptedagents::func_CED5(param_01,var_04,param_01,param_03,var_05);
}

//Function Number: 11
func_2361(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
}

//Function Number: 12
func_2382(param_00,param_01)
{
	if(!isdefined(param_01.var_4E6D))
	{
		return 0;
	}

	if(isalive(self))
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
func_237E(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "code_move";
	}

	self method_8281(param_00);
}

//Function Number: 14
func_237F(param_00)
{
	switch(param_00)
	{
		case "face goal":
			var_01 = self method_8150();
			if(isdefined(var_01))
			{
				var_02 = var_01 - self.origin;
				var_03 = vectornormalize(var_02);
				var_04 = vectortoangles(var_03);
				self method_8289("face angle abs",var_04);
				break;
			}
	
			break;

		case "face current":
			self method_8289("face angle abs",self.angles);
			break;

		case "face motion":
		case "face enemy":
			self method_8289(param_00);
			break;

		case "face node":
			var_05 = self.angles[1];
			var_06 = 1024;
			if(isdefined(self.var_205) && distancesquared(self.origin,self.var_205.origin) < var_06)
			{
				var_05 = scripts\asm\shared_utility::func_7FF7(self.var_205);
			}
	
			var_07 = (0,var_05,0);
			self method_8289("face angle abs",var_07);
			break;

		default:
			break;
	}
}

//Function Number: 15
func_230F(param_00)
{
	if(isdefined(param_00.var_1FBA))
	{
		func_237E(param_00.var_1FBA);
	}

	if(isdefined(param_00.var_C704))
	{
		func_237F(param_00.var_C704);
	}
}

//Function Number: 16
func_2337(param_00,param_01)
{
	var_02 = level.var_2303[param_00].var_10E2F[param_01].var_71A5;
	var_03 = level.var_2303[param_00].var_10E2F[param_01].var_7DC8;
	var_04 = self [[ var_02 ]](param_00,param_01,var_03);
	return var_04;
}

//Function Number: 17
func_7EA3()
{
	var_00 = undefined;
	if(!isdefined(self.var_8CD0))
	{
		var_01 = 400;
	}
	else
	{
		var_01 = 4096;
	}

	if(isdefined(self.var_205) && distancesquared(self.origin,self.var_205.origin) < var_01)
	{
		var_00 = self.var_205;
	}
	else if(isdefined(self.var_24A) && distancesquared(self.origin,self.var_24A.origin) < var_01)
	{
		var_00 = self.var_24A;
	}

	if(isdefined(var_00) && isdefined(self.var_8CD0) && scripts\common\utility::func_152F(self.angles[1] - var_00.angles[1]) > 30)
	{
		return undefined;
	}

	return var_00;
}

//Function Number: 18
func_235A(param_00,param_01)
{
	param_01 = tolower(param_01);
	return self method_80FE(param_00,param_01);
}

//Function Number: 19
func_2347(param_00,param_01)
{
	param_01 = tolower(param_01);
	if(!self method_80FF(param_00,param_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
func_2336(param_00,param_01)
{
	var_02 = func_2337(param_00,param_01);
	var_03 = self method_80FD(param_01,var_02);
	return var_03;
}