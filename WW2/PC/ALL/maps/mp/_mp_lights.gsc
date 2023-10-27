/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_mp_lights.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 378 ms
 * Timestamp: 10/27/2023 3:21:38 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	if(!isdefined(level.var_94E5))
	{
		level.var_94E5 = getdvarint("1084",1);
	}

	if(!isdefined(level.var_94EF))
	{
		level.var_94EF = getdvarfloat("3158",1);
	}

	if(!isdefined(level.var_911F))
	{
		level.var_911F = getdvarint("sm_spotlimit",4);
	}

	if(!isdefined(level.var_94EE))
	{
		level.var_94EE = getdvarfloat("5699",0.25);
	}

	if(!isdefined(level.var_781B))
	{
		level.var_781B = getdvarfloat("sm_qualityspotshadow",1);
	}

	thread func_63C5();
	if(!isdefined(level.var_672))
	{
		level.var_672 = spawnstruct();
		func_5D25();
		func_5D11();
	}

	var_00 = getentarray("trigger_multiple_light_sunshadow","classname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		level thread func_94E4(var_00[var_01]);
	}
}

//Function Number: 2
func_8588(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_00))
	{
		level.var_94E5 = param_00;
	}

	if(isdefined(param_01))
	{
		level.var_94EF = param_01;
	}

	if(isdefined(param_02))
	{
		level.var_911F = param_02;
	}

	if(isdefined(param_03))
	{
		level.var_94EE = param_03;
	}

	if(isdefined(param_04))
	{
		level.var_781B = param_04;
	}
}

//Function Number: 3
func_63C5()
{
	if(isdefined(level.var_744A))
	{
		foreach(var_01 in level.var_744A)
		{
			var_01 func_5330();
		}
	}

	for(;;)
	{
		level waittill("connected",var_01);
		var_01 func_5330();
		var_01 thread func_6379();
	}
}

//Function Number: 4
func_5330()
{
	self.var_94E5 = level.var_94E5;
	self.var_94EF = level.var_94EF;
	self.var_911F = level.var_911F;
	self.var_94EE = level.var_94EE;
	self.var_781B = level.var_781B;
	self setclientdvars("1084",self.var_94E5,"3158",self.var_94EF,"sm_spotlimit",self.var_911F,"sm_qualityspotshadow",self.var_781B,"5699",self.var_94EE);
}

//Function Number: 5
func_6379()
{
	self waittill("spawned");
	func_5330();
}

//Function Number: 6
func_94E4(param_00)
{
	var_01 = 1;
	if(isdefined(param_00.var_817A))
	{
		var_01 = param_00.var_817A;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 func_8599(var_01,var_02);
	}
}

//Function Number: 7
func_8599(param_00,param_01)
{
	var_02 = param_01.var_94E5;
	var_03 = param_01.var_94EF;
	var_04 = param_01.var_911F;
	var_05 = param_01.var_94EE;
	var_06 = param_01.var_781B;
	if(isdefined(self.var_82A9))
	{
		var_02 = self.var_82A9;
	}

	if(isdefined(self.var_82AB))
	{
		var_03 = self.var_82AB;
	}

	if(isdefined(self.var_8294))
	{
		var_04 = self.var_8294;
	}

	if(isdefined(self.var_82AA))
	{
		var_05 = self.var_82AA;
	}

	var_05 = min(max(0.016,var_05),32);
	if(isdefined(self.var_8275))
	{
		var_06 = self.var_8275;
	}

	param_01 setclientdvars("1084",var_02,"3158",var_03,"sm_spotlimit",var_04,"sm_qualityspotshadow",var_06);
	param_01.var_94E5 = var_02;
	param_01.var_94EF = var_03;
	param_01.var_911F = var_04;
	var_07 = param_01.var_94EE;
	param_01.var_94EE = var_05;
	param_01.var_781B = var_06;
	thread func_5C9B(var_05,var_07,param_00,param_01);
}

//Function Number: 8
func_5C9B(param_00,param_01,param_02,param_03)
{
	level notify("changing_sunsamplesizenear" + param_03.var_109);
	level endon("changing_sunsamplesizenear" + param_03.var_109);
	if(param_00 == param_01)
	{
		return;
	}

	var_04 = param_00 - param_01;
	var_05 = 0.1;
	var_06 = param_02 / var_05;
	if(var_06 > 0)
	{
		var_07 = var_04 / var_06;
		var_08 = param_01;
		for(var_09 = 0;var_09 < var_06;var_09++)
		{
			var_08 = var_08 + var_07;
			param_03 setclientdvar("5699",var_08);
			param_03.var_94EE = var_08;
			wait(var_05);
		}
	}

	param_03 setclientdvar("5699",param_00);
	param_03.var_94EE = param_00;
}

//Function Number: 9
func_5D25()
{
	func_279A("fire",(0.972549,0.62451,0.345098),(0.2,0.1462746,0.0878432),0.005,0.2,8);
	func_279A("blue_fire",(0.445098,0.62451,0.972549),(0.05,0.150451,0.3078432),0.005,0.2,8);
	func_279A("white_fire",(0.972549,0.972549,0.972549),(0.2,0.2,0.2),0.005,0.2,8);
	func_279A("pulse",(0,0,0),(255,107,107),0.2,1,8);
	func_279A("lightbulb",(0.972549,0.62451,0.345098),(0.2,0.1462746,0.0878432),0.005,0.2,6);
	func_279A("fluorescent",(0.972549,0.62451,0.345098),(0.2,0.1462746,0.0878432),0.005,0.2,7);
	func_279A("static_screen",(0.63,0.72,0.92),(0.4,0.43,0.48),0.005,0.2,7);
}

//Function Number: 10
func_279A(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.var_672.var_3D62))
	{
		level.var_672.var_3D62 = [];
	}

	var_06 = spawnstruct();
	var_06.var_24F2 = param_01;
	var_06.var_24F4 = param_02;
	var_06.var_61BE = param_03;
	var_06.var_607C = param_04;
	var_06.var_D8 = param_05;
	level.var_672.var_3D62[param_00] = var_06;
}

//Function Number: 11
func_4198(param_00)
{
	if(isdefined(level.var_672.var_3D62) && isdefined(level.var_672.var_3D62[param_00]))
	{
		return level.var_672.var_3D62[param_00];
	}

	return undefined;
}

//Function Number: 12
func_711E(param_00,param_01,param_02)
{
	var_03 = getent(param_01,"targetname");
	if(!isdefined(var_03))
	{
		return;
	}

	var_04 = func_4198(param_00);
	if(!isdefined(var_04))
	{
		return;
	}

	if(isdefined(param_02))
	{
		if(param_02 < 0)
		{
			param_02 = 0;
		}

		var_04.var_D8 = param_02;
	}

	var_03 method_81DF(var_04.var_D8);
	var_03.var_5749 = 1;
	var_03.var_574A = 0;
	var_03 thread func_351B(var_04.var_24F2,var_04.var_24F4,var_04.var_61BE,var_04.var_607C);
	return var_03;
}

//Function Number: 13
func_93CB(param_00,param_01,param_02)
{
	var_03 = getent(param_01,"targetname");
	if(!isdefined(var_03))
	{
		return;
	}

	if(!isdefined(var_03.var_5749))
	{
		return;
	}

	if(isdefined(param_02))
	{
		if(param_02 < 0)
		{
			param_02 = 0;
		}
	}

	var_03 method_81DF(param_02);
	var_03 notify("kill_flicker");
	var_03.var_5749 = undefined;
}

//Function Number: 14
func_6F19(param_00,param_01)
{
	var_02 = getent(param_01,"targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	if(!isdefined(var_02.var_5749))
	{
		return;
	}

	var_02.var_574A = 1;
}

//Function Number: 15
func_A03E(param_00,param_01)
{
	var_02 = getent(param_01,"targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	if(!isdefined(var_02.var_5749))
	{
		return;
	}

	var_02.var_574A = 0;
}

//Function Number: 16
func_351B(param_00,param_01,param_02,param_03)
{
	self endon("kill_flicker");
	var_04 = param_00;
	var_05 = 0;
	for(;;)
	{
		if(self.var_574A)
		{
			wait 0.05;
			continue;
		}

		var_06 = var_04;
		var_04 = param_00 + param_01 - param_00 * randomfloat(1);
		if(param_02 != param_03)
		{
			var_05 = var_05 + randomfloatrange(param_02,param_03);
		}
		else
		{
			var_05 = var_05 + param_02;
		}

		if(var_05 == 0)
		{
			var_05 = var_05 + 1E-07;
		}

		var_07 = var_06 - var_04 * 1 / var_05;
		while(var_05 > 0 && !self.var_574A)
		{
			self method_804C(var_04 + var_07 * var_05);
			wait 0.05;
			var_05 = var_05 - 0.05;
		}
	}
}

//Function Number: 17
func_6284(param_00,param_01,param_02,param_03)
{
	var_04 = getentarray(param_00,"script_noteworthy");
	if(!isdefined(var_04))
	{
		return;
	}

	self endon("death");
	var_05 = 0;
	var_06 = randomfloatrange(0.1,0.25);
	if(isdefined(param_02))
	{
		func_392A(param_02);
	}

	while(var_05 < param_01)
	{
		if(isdefined(param_03))
		{
			func_392A(param_03);
		}

		foreach(var_08 in var_04)
		{
			var_08 method_805B();
		}

		wait(var_06);
		if(isdefined(param_03))
		{
			func_93C7(param_03);
		}

		foreach(var_08 in var_04)
		{
			var_08 method_805C();
		}

		var_05++;
		wait(var_06);
	}
}

//Function Number: 18
func_5D11()
{
	level.var_672.var_611B = [];
}

//Function Number: 19
func_5D09()
{
}

//Function Number: 20
func_5D1F(param_00,param_01)
{
	level.var_672.var_611B[param_00] = param_01;
}

//Function Number: 21
func_5D10(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.var_672.var_611B[param_00]))
	{
		if(isdefined(param_03))
		{
			thread [[ level.var_672.var_611B[param_00] ]](param_01,param_02,param_03);
			return;
		}

		if(isdefined(param_02))
		{
			thread [[ level.var_672.var_611B[param_00] ]](param_01,param_02);
			return;
		}

		if(isdefined(param_01))
		{
			thread [[ level.var_672.var_611B[param_00] ]](param_01);
			return;
		}

		thread [[ level.var_672.var_611B[param_00] ]]();
		return;
	}
}

//Function Number: 22
func_93C7(param_00)
{
	param_00 = param_00 + "";
	if(isdefined(level.var_2807))
	{
		var_01 = level.var_2807[param_00];
		if(isdefined(var_01))
		{
			foreach(var_03 in var_01)
			{
				if(!isdefined(var_03.var_5EED))
				{
					continue;
				}

				var_03.var_5EED delete();
			}

			return;
		}

		return;
	}

	var_05 = 0;
	while(var_03 < level.var_2804.size)
	{
		var_05 = level.var_2804[var_03];
		if(!isdefined(var_05))
		{
			continue;
		}

		if(var_05.var_A265["type"] != "exploder")
		{
			continue;
		}

		if(!isdefined(var_05.var_A265["exploder"]))
		{
			continue;
		}

		if(var_05.var_A265["exploder"] + "" != var_02)
		{
			continue;
		}

		if(!isdefined(var_05.var_5EED))
		{
			continue;
		}

		var_05.var_5EED delete();
		var_03++;
	}
}

//Function Number: 23
func_392A(param_00)
{
	[[ level.var_3945 ]](param_00);
}