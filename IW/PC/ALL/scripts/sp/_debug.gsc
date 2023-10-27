/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_debug.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 79
 * Decompile Time: 3703 ms
 * Timestamp: 10/27/2023 12:24:04 AM
*******************************************************************/

//Function Number: 1
func_6636()
{
}

//Function Number: 2
func_6639()
{
}

//Function Number: 3
func_7D0D(param_00)
{
}

//Function Number: 4
func_1876()
{
}

//Function Number: 5
func_F390(param_00,param_01,param_02)
{
}

//Function Number: 6
func_6638(param_00,param_01)
{
}

//Function Number: 7
func_1877(param_00)
{
}

//Function Number: 8
func_7997(param_00,param_01)
{
	var_02 = getentarray();
	var_03 = [];
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	foreach(var_05 in var_02)
	{
		if(!isdefined(var_05.classname))
		{
			var_06 = "UNKNOWN?";
		}
		else
		{
			var_06 = var_05.classname;
		}

		if(param_00)
		{
			if(isai(var_05))
			{
				var_06 = "actors";
			}
			else if(isspawner(var_05))
			{
				var_07 = getsubstr(var_06,0,5);
				if(var_07 == "actor")
				{
					var_06 = "AI_spawners";
				}
				else
				{
					var_06 = "vehicle_spawners";
				}
			}
			else if(isdefined(var_05.var_49BD))
			{
				var_06 = var_05.classname + " CREATEFX";
			}
			else if(!isdefined(var_05.var_9F))
			{
			}
			else if(var_05.var_9F == "script_model")
			{
				if(var_05.model == "tag_origin")
				{
					var_06 = "script_model TAG_ORIGIN";
				}
			}
			else if(var_05.var_9F == "trigger_multiple")
			{
				var_07 = getsubstr(var_06,0,22);
				if(var_07 == "trigger_multiple_bcs_")
				{
					var_06 = "trigger_multiple_bcs";
				}
				else
				{
					var_06 = "trigger_multiple";
				}
			}
			else
			{
				var_07 = getsubstr(var_06.var_9F,0,10);
				if(var_07 == "weapon_iw7")
				{
					var_06 = "weapons";
				}

				var_07 = getsubstr(var_05.var_9F,0,5);
				if(var_07 == "actor")
				{
					var_06 = "drones";
				}
			}
		}
		else
		{
			if(isdefined(var_05.var_49BD))
			{
				var_06 = "CREATEFX " + var_05.classname;
			}

			if(var_06 == "script_model")
			{
				var_06 = var_06 + " " + var_05.model;
			}
		}

		if(!isdefined(var_03[var_06]))
		{
			var_03[var_06] = 0;
		}

		var_03[var_06]++;
	}

	if(!isdefined(param_01) || !param_01)
	{
		var_03 = func_10418(var_03);
	}

	return var_03;
}

//Function Number: 9
func_10418(param_00)
{
	var_01 = getarraykeys(param_00);
	for(var_02 = 0;var_02 < var_01.size - 1;var_02++)
	{
		for(var_03 = var_02 + 1;var_03 < var_01.size;var_03++)
		{
			if(stricmp(var_01[var_02],var_01[var_03]) > 0)
			{
				var_04 = var_01[var_03];
				var_01[var_03] = var_01[var_02];
				var_01[var_02] = var_04;
			}
		}
	}

	var_05 = [];
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_05[var_01[var_02]] = param_00[var_01[var_02]];
	}

	return var_05;
}

//Function Number: 10
func_4ED2(param_00)
{
	var_01 = function_0072();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] getentitynumber() != param_00)
		{
			continue;
		}

		var_01[var_02] thread func_4ED3();
		break;
	}
}

//Function Number: 11
func_4F22(param_00)
{
	var_01 = function_0072();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] getentitynumber() != param_00)
		{
			continue;
		}

		var_01[var_02] notify("stop_drawing_enemy_pos");
		break;
	}
}

//Function Number: 12
func_4ED3()
{
	self endon("death");
	self endon("stop_drawing_enemy_pos");
	for(;;)
	{
		wait(0.05);
		if(isalive(self.var_10C))
		{
		}

		if(!scripts\anim\utility::func_8BED())
		{
			continue;
		}

		var_00 = scripts\anim\utility::func_7E90();
	}
}

//Function Number: 13
func_4ED4()
{
	var_00 = function_0072();
	var_01 = undefined;
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_01 = var_00[var_02];
		if(!isalive(var_01))
		{
			continue;
		}

		if(isdefined(var_01.var_1B2))
		{
		}

		if(isdefined(var_01.var_8451))
		{
			if(var_01 method_8198())
			{
				var_03 = (1,0,0);
			}
			else
			{
				var_03 = (0,0,1);
			}

			var_04 = var_01.origin + (0,0,54);
			if(isdefined(var_01.var_205))
			{
				if(var_01.var_205.type == "Cover Left")
				{
					var_05 = 1;
					var_04 = anglestoright(var_01.var_205.angles);
					var_04 = var_04 * -32;
					var_04 = (var_04[0],var_04[1],64);
					var_04 = var_01.var_205.origin + var_04;
				}
				else if(var_01.var_205.type == "Cover Right")
				{
					var_05 = 1;
					var_04 = anglestoright(var_01.var_205.angles);
					var_04 = var_04 * 32;
					var_04 = (var_04[0],var_04[1],64);
					var_04 = var_01.var_205.origin + var_04;
				}
			}

			scripts\common\utility::func_5B21(var_04,var_01.var_8451,var_03);
		}
	}

	if(1)
	{
		return;
	}

	if(!isalive(var_01))
	{
		return;
	}

	if(isalive(var_01.var_10C))
	{
	}

	if(isdefined(var_01.var_1B2))
	{
	}

	if(isalive(var_01.var_8450))
	{
	}

	if(!var_01 scripts\anim\utility::func_8BED())
	{
		return;
	}

	var_06 = var_01 scripts\anim\utility::func_7E90();
	if(isdefined(var_01.var_8451))
	{
	}
}

//Function Number: 14
func_5B76(param_00)
{
}

//Function Number: 15
func_5B88(param_00,param_01,param_02)
{
	if(isdefined(self.model) && scripts\sp\_utility::func_8C32(self.model,param_00))
	{
		var_03 = self gettagorigin(param_00);
		var_04 = self gettagangles(param_00);
		func_5B6D(var_03,var_04,param_01,param_02);
	}
}

//Function Number: 16
func_5B6D(param_00,param_01,param_02,param_03)
{
	var_04 = 10;
	var_05 = anglestoforward(param_01);
	var_06 = var_05 * var_04;
	var_07 = var_05 * var_04 * 0.8;
	var_08 = anglestoright(param_01);
	var_09 = var_08 * var_04 * -0.2;
	var_0A = var_08 * var_04 * 0.2;
	var_0B = anglestoup(param_01);
	var_08 = var_08 * var_04;
	var_0B = var_0B * var_04;
	var_0C = (0.9,0.2,0.2);
	var_0D = (0.2,0.9,0.2);
	var_0E = (0.2,0.2,0.9);
	if(isdefined(param_02))
	{
		var_0C = param_02;
		var_0D = param_02;
		var_0E = param_02;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}
}

//Function Number: 17
func_5B89(param_00,param_01)
{
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		func_5B88(param_00,param_01);
		wait(0.05);
	}
}

//Function Number: 18
func_5B1D(param_00,param_01)
{
	self endon("death");
	for(;;)
	{
		if(!isdefined(self))
		{
			break;
		}

		if(!isdefined(self.origin))
		{
			break;
		}

		func_5B88(param_00,param_01);
		wait(0.05);
	}
}

//Function Number: 19
func_133A3(param_00,param_01)
{
	if(param_00 == "ai")
	{
		var_02 = function_0072();
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_02[var_03] func_5B88(param_01);
		}
	}
}

//Function Number: 20
func_4EC1()
{
	level.player.ignoreme = 1;
	var_00 = function_0076();
	var_01 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(var_00[var_02].type == "Cover Left")
		{
			var_01[var_01.size] = var_00[var_02];
		}

		if(var_00[var_02].type == "Cover Right")
		{
			var_01[var_01.size] = var_00[var_02];
		}
	}

	var_03 = function_0072();
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		var_03[var_02] delete();
	}

	level.var_4F54 = function_00C8();
	level.var_1658 = [];
	level.var_4484 = [];
	for(var_02 = 0;var_02 < level.var_4F54.size;var_02++)
	{
		level.var_4F54[var_02].var_336 = "blah";
	}

	var_04 = 0;
	for(var_02 = 0;var_02 < 30;var_02++)
	{
		if(var_02 >= var_01.size)
		{
			break;
		}

		var_01[var_02] thread func_474E();
		var_04++;
	}

	if(var_01.size <= 30)
	{
		return;
	}

	for(;;)
	{
		level waittill("debug_next_corner");
		if(var_04 >= var_01.size)
		{
			var_04 = 0;
		}

		var_01[var_04] thread func_474E();
		var_04++;
	}
}

//Function Number: 21
func_474E()
{
	func_4747();
}

//Function Number: 22
func_4747()
{
	var_00 = undefined;
	var_01 = undefined;
	for(;;)
	{
		for(var_02 = 0;var_02 < level.var_4F54.size;var_02++)
		{
			wait(0.05);
			var_01 = level.var_4F54[var_02];
			var_03 = 0;
			for(var_04 = 0;var_04 < level.var_1658.size;var_04++)
			{
				if(distance(level.var_1658[var_04].origin,self.origin) > 250)
				{
					continue;
				}

				var_03 = 1;
				break;
			}

			if(var_03)
			{
				continue;
			}

			var_05 = 0;
			for(var_04 = 0;var_04 < level.var_4484.size;var_04++)
			{
				if(level.var_4484[var_04] != self)
				{
					continue;
				}

				var_05 = 1;
				break;
			}

			if(var_05)
			{
				continue;
			}

			level.var_1658[level.var_1658.size] = self;
			var_01.origin = self.origin;
			var_01.angles = self.angles;
			var_01.var_C1 = 1;
			var_00 = var_01 method_8393();
			if(scripts\sp\_utility::func_106ED(var_00))
			{
				func_E0C0(self);
				continue;
			}

			break;
		}

		if(isalive(var_00))
		{
			break;
		}
	}

	wait(1);
	if(isalive(var_00))
	{
		var_00.ignoreme = 1;
		var_00.team = "neutral";
		var_00 method_82EF(var_00.origin);
		thread func_49E3(self.origin);
		var_00 thread scripts\sp\_utility::func_4F4B();
		thread func_49E4(var_00);
		var_00 waittill("death");
	}

	func_E0C0(self);
	level.var_4484[level.var_4484.size] = self;
}

//Function Number: 23
func_E0C0(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.var_1658.size;var_02++)
	{
		if(level.var_1658[var_02] == param_00)
		{
			continue;
		}

		var_01[var_01.size] = level.var_1658[var_02];
	}

	level.var_1658 = var_01;
}

//Function Number: 24
func_49E3(param_00)
{
	wait(0.05);
}

//Function Number: 25
func_49E4(param_00)
{
	var_01 = undefined;
	while(isalive(param_00))
	{
		var_01 = param_00.origin;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 26
func_4F49()
{
	self notify("stopdebugmisstime");
	self endon("stopdebugmisstime");
	self endon("death");
	for(;;)
	{
		if(self.var_1491.var_B8D6 <= 0)
		{
		}
		else
		{
		}

		wait(0.05);
	}
}

//Function Number: 27
func_4F4A()
{
	self notify("stopdebugmisstime");
}

//Function Number: 28
func_4F46(param_00)
{
}

//Function Number: 29
func_4F41()
{
}

//Function Number: 30
func_E02E()
{
}

//Function Number: 31
func_48F2()
{
}

//Function Number: 32
func_CD1E()
{
}

//Function Number: 33
func_4EDC()
{
}

//Function Number: 34
func_4EDD()
{
}

//Function Number: 35
func_1011D()
{
	var_00 = undefined;
	var_01 = undefined;
	var_00 = (15.1859,-12.2822,4.071);
	var_01 = (947.2,-10918,64.9514);
	for(;;)
	{
		wait(0.05);
		var_02 = var_00;
		var_03 = var_01;
		if(!isdefined(var_00))
		{
			var_02 = level.var_11A8E;
		}

		if(!isdefined(var_01))
		{
			var_03 = level.player geteye();
		}

		var_04 = bullettrace(var_02,var_03,0,undefined);
	}
}

//Function Number: 36
func_4EBB()
{
	var_00 = newhudelem();
	var_00.alignx = "left";
	var_00.aligny = "middle";
	var_00.x = 10;
	var_00.y = 100;
	var_00.label = &"DEBUG_DRONES";
	var_00.alpha = 0;
	var_01 = newhudelem();
	var_01.alignx = "left";
	var_01.aligny = "middle";
	var_01.x = 10;
	var_01.y = 115;
	var_01.label = &"DEBUG_ALLIES";
	var_01.alpha = 0;
	var_02 = newhudelem();
	var_02.alignx = "left";
	var_02.aligny = "middle";
	var_02.x = 10;
	var_02.y = 130;
	var_02.label = &"DEBUG_AXIS";
	var_02.alpha = 0;
	var_03 = newhudelem();
	var_03.alignx = "left";
	var_03.aligny = "middle";
	var_03.x = 10;
	var_03.y = 145;
	var_03.label = &"DEBUG_VEHICLES";
	var_03.alpha = 0;
	var_04 = newhudelem();
	var_04.alignx = "left";
	var_04.aligny = "middle";
	var_04.x = 10;
	var_04.y = 160;
	var_04.label = &"DEBUG_TOTAL";
	var_04.alpha = 0;
	var_05 = "off";
	for(;;)
	{
		var_06 = getdvar("debug_character_count");
		if(var_06 == "off")
		{
			if(var_06 != var_05)
			{
				var_00.alpha = 0;
				var_01.alpha = 0;
				var_02.alpha = 0;
				var_03.alpha = 0;
				var_04.alpha = 0;
				var_05 = var_06;
			}

			wait(0.25);
			continue;
		}
		else if(var_06 != var_05)
		{
			var_00.alpha = 1;
			var_01.alpha = 1;
			var_02.alpha = 1;
			var_03.alpha = 1;
			var_04.alpha = 1;
			var_05 = var_06;
		}

		var_07 = getentarray("drone","targetname").size;
		var_00 setvalue(var_07);
		var_08 = function_0072("allies").size;
		var_01 setvalue(var_08);
		var_09 = function_0072("bad_guys").size;
		var_02 setvalue(var_09);
		var_03 setvalue(getentarray("script_vehicle","classname").size);
		var_04 setvalue(var_07 + var_08 + var_09);
		wait(0.25);
	}
}

//Function Number: 37
func_C1A6()
{
	if(!self.var_E0)
	{
		if(isdefined(self.var_12BA4) && self.var_12BA4 == "c12")
		{
			self method_81D0((0,0,-500),level.player);
			return;
		}

		self method_81D0((0,0,-500),level.player,level.player);
	}
}

//Function Number: 38
func_4EFD()
{
}

//Function Number: 39
func_37A5()
{
	wait(0.05);
	var_00 = getentarray("camera","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = getent(var_00[var_01].target,"targetname");
		var_00[var_01].var_C712 = var_02.origin;
		var_00[var_01].angles = vectortoangles(var_02.origin - var_00[var_01].origin);
	}

	for(;;)
	{
		var_03 = function_0072("axis");
		if(!var_03.size)
		{
			func_7370();
			wait(0.5);
			continue;
		}

		var_04 = [];
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			for(var_05 = 0;var_05 < var_03.size;var_05++)
			{
				if(distance(var_00[var_01].origin,var_03[var_05].origin) > 256)
				{
					continue;
				}

				var_04[var_04.size] = var_00[var_01];
				break;
			}
		}

		if(!var_04.size)
		{
			func_7370();
			wait(0.5);
			continue;
		}

		var_06 = [];
		for(var_01 = 0;var_01 < var_04.size;var_01++)
		{
			var_07 = var_04[var_01];
			var_08 = var_07.var_C712;
			var_09 = var_07.origin;
			var_0A = vectortoangles((var_09[0],var_09[1],var_09[2]) - (var_08[0],var_08[1],var_08[2]));
			var_0B = (0,var_0A[1],0);
			var_0C = anglestoforward(var_0B);
			var_0A = vectornormalize(var_09 - level.player.origin);
			var_0D = vectordot(var_0C,var_0A);
			if(var_0D < 0.85)
			{
				continue;
			}

			var_06[var_06.size] = var_07;
		}

		if(!var_06.size)
		{
			func_7370();
			wait(0.5);
			continue;
		}

		var_0E = distance(level.player.origin,var_06[0].origin);
		var_0F = var_06[0];
		for(var_01 = 1;var_01 < var_06.size;var_01++)
		{
			var_10 = distance(level.player.origin,var_06[var_01].origin);
			if(var_10 > var_0E)
			{
				continue;
			}

			var_0F = var_06[var_01];
			var_0E = var_10;
		}

		func_F7FD(var_0F);
		wait(3);
	}
}

//Function Number: 40
func_7370()
{
	setdvar("cl_freemove","0");
}

//Function Number: 41
func_F7FD(param_00)
{
	setdvar("cl_freemove","2");
}

//Function Number: 42
func_4E6B()
{
	waittillframeend;
	for(var_00 = 0;var_00 < 50;var_00++)
	{
		if(!isdefined(level.var_4E6A[var_00]))
		{
			continue;
		}

		var_01 = level.var_4E6A[var_00];
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = var_01[var_02];
			if(isdefined(var_03.var_12844))
			{
				continue;
			}
		}
	}
}

//Function Number: 43
func_A9EF()
{
}

//Function Number: 44
func_13ACF()
{
	for(;;)
	{
		func_12ED1();
		wait(0.25);
	}
}

//Function Number: 45
func_12ED1()
{
	var_00 = getdvarfloat("scr_requiredMapAspectRatio",1);
	if(!isdefined(level.var_B7AF))
	{
		setdvar("scr_minimap_corner_targetname","minimap_corner");
		level.var_B7AF = "minimap_corner";
	}

	if(!isdefined(level.var_B7B1))
	{
		setdvar("scr_minimap_height","0");
		level.var_B7B1 = 0;
	}

	var_01 = getdvarfloat("scr_minimap_height");
	var_02 = getdvar("scr_minimap_corner_targetname");
	if(var_01 != level.var_B7B1 || var_02 != level.var_B7AF)
	{
		if(isdefined(level.var_B7B2))
		{
			level.var_B7B3 unlink();
			level.var_B7B2 delete();
			level notify("end_draw_map_bounds");
		}

		if(var_01 > 0)
		{
			level.var_B7B1 = var_01;
			level.var_B7AF = var_02;
			var_03 = level.player;
			var_04 = getentarray(var_02,"targetname");
			if(var_04.size == 2)
			{
				var_05 = var_04[0].origin + var_04[1].origin;
				var_05 = (var_05[0] * 0.5,var_05[1] * 0.5,var_05[2] * 0.5);
				var_06 = (var_04[0].origin[0],var_04[0].origin[1],var_05[2]);
				var_07 = (var_04[0].origin[0],var_04[0].origin[1],var_05[2]);
				if(var_04[1].origin[0] > var_04[0].origin[0])
				{
					var_06 = (var_04[1].origin[0],var_06[1],var_06[2]);
				}
				else
				{
					var_07 = (var_04[1].origin[0],var_07[1],var_07[2]);
				}

				if(var_04[1].origin[1] > var_04[0].origin[1])
				{
					var_06 = (var_06[0],var_04[1].origin[1],var_06[2]);
				}
				else
				{
					var_07 = (var_07[0],var_04[1].origin[1],var_07[2]);
				}

				var_08 = var_06 - var_05;
				var_05 = (var_05[0],var_05[1],var_05[2] + var_01);
				var_09 = spawn("script_origin",var_03.origin);
				var_0A = (cos(getnorthyaw()),sin(getnorthyaw()),0);
				var_0B = (var_0A[1],0 - var_0A[0],0);
				var_0C = vectordot(var_0A,var_08);
				if(var_0C < 0)
				{
					var_0C = 0 - var_0C;
				}

				var_0D = vectordot(var_0B,var_08);
				if(var_0D < 0)
				{
					var_0D = 0 - var_0D;
				}

				if(var_00 > 0)
				{
					var_0E = var_0D / var_0C;
					if(var_0E < var_00)
					{
						var_0F = var_00 / var_0E;
						var_0D = var_0D * var_0F;
						var_10 = func_13193(var_0B,vectordot(var_0B,var_06 - var_05) * var_0F - 1);
						var_07 = var_07 - var_10;
						var_06 = var_06 + var_10;
					}
					else
					{
						var_0F = var_10 / var_02;
						var_0D = var_0D * var_10;
						var_10 = func_13193(var_0B,vectordot(var_0B,var_07 - var_06) * var_10 - 1);
						var_07 = var_07 - var_10;
						var_06 = var_06 + var_10;
					}
				}

				if(level.console)
				{
					var_11 = 1.777778;
					var_12 = 2 * atan(var_0D * 0.8 / var_01);
					var_13 = 2 * atan(var_0C * var_11 * 0.8 / var_01);
				}
				else
				{
					var_11 = 1.333333;
					var_12 = 2 * atan(var_12 * 1.05 / var_03);
					var_13 = 2 * atan(var_0D * var_12 * 1.05 / var_02);
				}

				if(var_12 > var_13)
				{
					var_14 = var_12;
				}
				else
				{
					var_14 = var_14;
				}

				var_15 = var_01 - 1000;
				if(var_15 < 16)
				{
					var_15 = 16;
				}

				if(var_15 > 10000)
				{
					var_15 = 10000;
				}

				var_03 playerlinktoabsolute(var_09);
				var_09.origin = var_05 + (0,0,-62);
				var_09.angles = (90,getnorthyaw(),0);
				var_03 giveweapon("defaultweapon");
				function_01C5("cg_fov",var_14);
				level.var_B7B3 = var_03;
				level.var_B7B2 = var_09;
				thread func_5B7E(var_05,var_07,var_06);
				return;
			}

			return;
		}
	}
}

//Function Number: 46
func_7E1F()
{
	var_00 = [];
	var_00 = getentarray("minimap_line","script_noteworthy");
	var_01 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_01[var_02] = var_00[var_02] func_7E1E();
	}

	return var_01;
}

//Function Number: 47
func_7E1E()
{
	var_00 = [];
	var_01 = self;
	while(isdefined(var_01))
	{
		var_00[var_00.size] = var_01;
		if(!isdefined(var_01) || !isdefined(var_01.target))
		{
			break;
		}

		var_01 = getent(var_01.target,"targetname");
		if(isdefined(var_01) && var_01 == var_00[0])
		{
			var_00[var_00.size] = var_01;
			break;
		}
	}

	var_02 = [];
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		var_02[var_03] = var_00[var_03].origin;
	}

	return var_02;
}

//Function Number: 48
func_13193(param_00,param_01)
{
	return (param_00[0] * param_01,param_00[1] * param_01,param_00[2] * param_01);
}

//Function Number: 49
func_5B7E(param_00,param_01,param_02)
{
	level notify("end_draw_map_bounds");
	level endon("end_draw_map_bounds");
	var_03 = param_00[2] - param_02[2];
	var_04 = length(param_01 - param_02);
	var_05 = param_01 - param_00;
	var_05 = vectornormalize((var_05[0],var_05[1],0));
	param_01 = param_01 + func_13193(var_05,var_04 * 1 / 800 * 0);
	var_06 = param_02 - param_00;
	var_06 = vectornormalize((var_06[0],var_06[1],0));
	param_02 = param_02 + func_13193(var_06,var_04 * 1 / 800 * 0);
	var_07 = (cos(getnorthyaw()),sin(getnorthyaw()),0);
	var_08 = param_02 - param_01;
	var_09 = func_13193(var_07,vectordot(var_08,var_07));
	var_0A = func_13193(var_07,abs(vectordot(var_08,var_07)));
	var_0B = param_01;
	var_0C = param_01 + var_09;
	var_0D = param_02;
	var_0E = param_02 - var_09;
	var_0F = func_13193(param_01 + param_02,0.5) + func_13193(var_0A,0.51);
	var_10 = var_04 * 0.003;
	var_11 = func_7E1F();
	for(;;)
	{
		scripts\common\utility::func_22A1(var_11,::scripts\common\utility::func_D5DA);
		wait(0.05);
	}
}

//Function Number: 50
func_4EC0()
{
	wait(0.05);
	var_00 = function_0072();
	var_01 = [];
	var_01["axis"] = [];
	var_01["allies"] = [];
	var_01["neutral"] = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = var_00[var_02];
		if(!isdefined(var_03.var_4BDF))
		{
			continue;
		}

		var_01[var_03.team][var_03.var_4BDF] = 1;
		var_04 = (1,1,1);
		if(isdefined(var_03.var_EDAD))
		{
			var_04 = level.var_4391[var_03.var_EDAD];
		}

		if(var_03.team == "axis")
		{
			continue;
		}

		var_03 func_12879();
	}

	func_5B2E(var_01,"allies");
	func_5B2E(var_01,"axis");
}

//Function Number: 51
func_5B2E(param_00,param_01)
{
	var_02 = getarraykeys(param_00[param_01]);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = (1,1,1);
		var_04 = level.var_4391[getsubstr(var_02[var_03],0,1)];
		if(isdefined(level.var_43AD[param_01][var_02[var_03]]))
		{
			var_05 = level.var_43AD[param_01][var_02[var_03]];
			for(var_06 = 0;var_06 < var_05.size;var_06++)
			{
			}
		}
	}
}

//Function Number: 52
func_7CE8()
{
	if(self.team == "allies")
	{
		if(!isdefined(self.var_205.var_ED33))
		{
			return;
		}

		return self.var_205.var_ED33;
	}

	if(self.team == "axis")
	{
		if(!isdefined(self.var_205.var_ED34))
		{
			return;
		}

		return self.var_205.var_ED34;
	}
}

//Function Number: 53
func_12879()
{
	if(!isdefined(self.var_205))
	{
		return;
	}

	if(!isdefined(self.var_EDAD))
	{
		return;
	}

	var_00 = func_7CE8();
	if(!isdefined(var_00))
	{
		return;
	}

	if(!issubstr(var_00,self.var_EDAD))
	{
	}
}

//Function Number: 54
func_4F55()
{
	level.var_A91E = gettime();
	thread func_4F56();
}

//Function Number: 55
func_4F56()
{
}

//Function Number: 56
func_56E2(param_00,param_01)
{
	if(self.team == param_00.team)
	{
		return;
	}

	var_02 = 0;
	var_02 = var_02 + self.var_33F;
	var_03 = 0;
	var_03 = var_03 + param_00.var_33F;
	var_04 = undefined;
	if(isdefined(param_01))
	{
		var_04 = self method_8163();
		if(isdefined(var_04))
		{
			var_03 = var_03 + function_00D7(param_01,var_04);
			var_02 = var_02 + function_00D7(var_04,param_01);
		}
	}

	if(param_00.ignoreme || var_03 < -900000)
	{
		var_03 = "Ignore";
	}

	if(self.ignoreme || var_02 < -900000)
	{
		var_02 = "Ignore";
	}

	var_05 = 20;
	var_06 = (1,0.5,0.2);
	var_07 = (0.2,0.5,1);
	var_08 = !isplayer(self) && self.var_223;
	for(var_09 = 0;var_09 <= var_05;var_09++)
	{
		if(isdefined(param_01))
		{
		}

		if(isdefined(var_04))
		{
		}

		if(var_08)
		{
		}

		wait(0.05);
	}
}

//Function Number: 57
func_4F3B()
{
	level.var_4EBE = [];
	level.var_4EBF = [];
	for(;;)
	{
		level waittill("updated_color_friendlies");
		func_5B2C();
	}
}

//Function Number: 58
func_7C31()
{
	var_00 = [];
	var_00["r"] = (1,0,0);
	var_00["o"] = (1,0.5,0);
	var_00["y"] = (1,1,0);
	var_00["g"] = (0,1,0);
	var_00["c"] = (0,1,1);
	var_00["b"] = (0,0,1);
	var_00["p"] = (1,0,1);
	return var_00;
}

//Function Number: 59
func_5B2C()
{
	level endon("updated_color_friendlies");
	var_00 = getarraykeys(level.var_4EBE);
	var_01 = [];
	var_02 = [];
	var_02[var_02.size] = "r";
	var_02[var_02.size] = "o";
	var_02[var_02.size] = "y";
	var_02[var_02.size] = "g";
	var_02[var_02.size] = "c";
	var_02[var_02.size] = "b";
	var_02[var_02.size] = "p";
	var_03 = func_7C31();
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_01[var_02[var_04]] = 0;
	}

	for(var_04 = 0;var_04 < var_00.size;var_04++)
	{
		var_05 = level.var_4EBE[var_00[var_04]];
		var_01[var_05]++;
	}

	for(var_04 = 0;var_04 < level.var_4EBF.size;var_04++)
	{
		level.var_4EBF[var_04] destroy();
	}

	level.var_4EBF = [];
	var_06 = 15;
	var_07 = 365;
	var_08 = 25;
	var_09 = 25;
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		if(var_01[var_02[var_04]] <= 0)
		{
			continue;
		}

		for(var_0A = 0;var_0A < var_01[var_02[var_04]];var_0A++)
		{
			var_0B = newhudelem();
			var_0B.x = var_06 + 25 * var_0A;
			var_0B.y = var_07;
			var_0B setshader("white",16,16);
			var_0B.alignx = "left";
			var_0B.aligny = "bottom";
			var_0B.alpha = 1;
			var_0B.color = var_03[var_02[var_04]];
			level.var_4EBF[level.var_4EBF.size] = var_0B;
		}

		var_07 = var_07 + var_09;
	}
}

//Function Number: 60
func_77F0(param_00)
{
	if(!isdefined(level.var_1FD4[param_00.var_1FBB]))
	{
		return;
	}

	if(!isdefined(level.var_1FD4[param_00.var_1FBB][param_00.var_1FAF]))
	{
		return;
	}

	if(!isdefined(level.var_1FD4[param_00.var_1FBB][param_00.var_1FAF][param_00.var_C0C2]))
	{
		return;
	}

	return level.var_1FD4[param_00.var_1FBB][param_00.var_1FAF][param_00.var_C0C2]["soundalias"];
}

//Function Number: 61
func_9BEC(param_00,param_01,param_02)
{
	return isdefined(level.var_1FD4[param_00][param_01][param_02]["created_by_animSound"]);
}

//Function Number: 62
func_4EA9(param_00)
{
}

//Function Number: 63
func_4EAA()
{
}

//Function Number: 64
func_113E6(param_00,param_01)
{
	if(!isdefined(level.var_1FDA))
	{
		return;
	}

	if(!isdefined(level.var_1FDA.var_1FDC[param_01]))
	{
		return;
	}

	var_02 = level.var_1FDA.var_1FDC[param_01];
	var_03 = func_77F0(var_02);
	if(!isdefined(var_03) || func_9BEC(var_02.var_1FBB,var_02.var_1FAF,var_02.var_C0C2))
	{
		level.var_1FD4[var_02.var_1FBB][var_02.var_1FAF][var_02.var_C0C2]["soundalias"] = param_00;
		level.var_1FD4[var_02.var_1FBB][var_02.var_1FAF][var_02.var_C0C2]["created_by_animSound"] = 1;
	}
}

//Function Number: 65
func_6C96(param_00)
{
}

//Function Number: 66
func_3D44(param_00)
{
	if(!isdefined(level.var_3D30))
	{
		level.var_3D30 = -1;
	}

	if(level.var_3D30 == param_00)
	{
		return;
	}

	func_6C96(param_00);
	if(!isdefined(level.var_3D31))
	{
		return;
	}

	level.var_3D30 = param_00;
	if(!isdefined(level.var_3D2F))
	{
		level.var_3D2F = level.var_3D31 scripts\common\utility::spawn_tag_origin();
	}

	thread func_3D45(level.var_3D31);
}

//Function Number: 67
func_3D45(param_00)
{
	level notify("new_chasecam");
	level endon("new_chasecam");
	param_00 endon("death");
	level.player unlink();
	level.player playerlinktoblend(level.var_3D2F,"tag_origin",2,0.5,0.5);
	wait(2);
	level.player playerlinktodelta(level.var_3D2F,"tag_origin",1,180,180,180,180);
	for(;;)
	{
		wait(0.2);
		if(!isdefined(level.var_3D31))
		{
			return;
		}

		var_01 = level.var_3D31.origin;
		var_02 = level.var_3D31.angles;
		var_03 = anglestoforward(var_02);
		var_03 = var_03 * 200;
		var_01 = var_01 + var_03;
		var_02 = level.player getplayerangles();
		var_03 = anglestoforward(var_02);
		var_03 = var_03 * -200;
		level.var_3D2F moveto(var_01 + var_03,0.2);
	}
}

//Function Number: 68
func_13399()
{
	foreach(var_01 in level.var_49C9)
	{
		if(isdefined(var_01.var_B051))
		{
		}
	}
}

//Function Number: 69
func_1705(param_00,param_01)
{
}

//Function Number: 70
func_D908(param_00)
{
	if(!isdefined(level.var_134AD))
	{
		level.var_134AD = 9500;
	}

	level.var_134AD++;
	var_01 = "bridge_helpers";
	func_1705("origin",self.origin[0] + " " + self.origin[1] + " " + self.origin[2]);
	func_1705("angles",self.angles[0] + " " + self.angles[1] + " " + self.angles[2]);
	func_1705("targetname","helper_model");
	func_1705("model",self.model);
	func_1705("classname","script_model");
	func_1705("spawnflags","4");
	func_1705("_color","0.443137 0.443137 1.000000");
	if(isdefined(param_00))
	{
		func_1705("script_noteworthy",param_00);
	}
}

//Function Number: 71
func_5B3B(param_00)
{
}

//Function Number: 72
func_5B3C()
{
	var_00 = level.player getplayerangles();
	var_01 = anglestoforward(var_00);
	var_02 = level.player geteye();
	var_03 = self geteye();
	var_04 = vectortoangles(var_03 - var_02);
	var_05 = anglestoforward(var_04);
	var_06 = vectordot(var_05,var_01);
}

//Function Number: 73
func_13C26()
{
	setdvarifuninitialized("weaponlist","0");
	if(!getdvarint("weaponlist"))
	{
		return;
	}

	var_00 = getentarray();
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(!isdefined(var_03.var_9F))
		{
			continue;
		}

		if(issubstr(var_03.var_9F,"weapon"))
		{
			var_01[var_03.classname] = 1;
		}
	}

	foreach(var_06 in var_01)
	{
	}

	var_08 = function_00C8();
	var_09 = [];
	foreach(var_0B in var_08)
	{
		var_09[var_0B.var_9F] = 1;
	}

	foreach(var_06 in var_09)
	{
	}
}

//Function Number: 74
func_B514()
{
	thread func_4EC2();
	setdvar("debug_measure",2);
	var_00 = [];
	var_01 = 0;
	while(getdvarint("debug_measure"))
	{
		if(level.player usebuttonpressed() && gettime() > var_01)
		{
			if(var_00.size == 2)
			{
				var_00 = [];
			}
			else
			{
				var_02 = level.var_4EA1.var_4C23;
				var_00[var_00.size] = var_02;
			}

			var_01 = gettime() + 500;
		}

		foreach(var_07, var_02 in var_00)
		{
			func_5B38(var_02);
			if(var_07 > 0)
			{
				var_04 = distance(var_02,var_00[var_07 - 1]);
				var_05 = vectornormalize(var_00[var_07 - 1] - var_02);
				var_06 = var_02 + var_05 * var_04 * 0.5;
			}
		}

		if(var_00.size == 2)
		{
			var_08 = (1,0,0);
			var_08 = (0,1,0);
			var_08 = (0.2,0.2,1);
			var_09 = var_00;
			if(var_00[1][2] > var_09[0][2])
			{
				var_09 = [var_00[1],var_00[0]];
			}

			var_0A = var_09[0];
			var_0B = (var_0A[0],var_0A[1],var_09[1][2]);
			var_04 = distance(var_0A,var_0B);
			var_05 = vectornormalize(var_0B - var_0A);
			var_0C = var_0A + var_05 * var_04 * 0.6;
		}

		wait(0.05);
	}

	level notify("stop_debug_cursor");
}

//Function Number: 75
func_4EC2()
{
	level.var_4EA1.var_4C23 = (0,0,0);
	level notify("stop_debug_cursor");
	level endon("stop_debug_cursor");
	for(;;)
	{
		var_00 = level.player geteye();
		var_01 = anglestoforward(level.player getplayerangles());
		var_02 = var_00 + var_01 * 10000;
		var_03 = bullettrace(var_00,var_02,0);
		level.var_4EA1.var_4C23 = var_03["position"];
		func_5B38(level.var_4EA1.var_4C23);
		wait(0.05);
	}
}

//Function Number: 76
func_5B38(param_00)
{
	level endon("stop_debug_cursor");
	var_01 = 4;
	var_02 = (1,1,1);
	var_03 = 1;
	var_04 = 1;
}

//Function Number: 77
func_5B54(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	if(!isdefined(param_03))
	{
		param_03 = 32;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = anglestoup(param_01);
	var_07 = anglestoforward(param_01);
	var_08 = param_00 + var_06 * param_03 * 0.5;
	var_09 = var_08 + var_07 * param_03;
	func_5B5D(var_08,var_09,param_02,param_04,param_05);
	func_5B24(param_00,param_02,param_01,param_03,param_04,param_05);
}

//Function Number: 78
func_5B5D(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_05 = vectortoangles(param_01 - param_00);
	var_06 = length(param_01 - param_00);
	var_07 = anglestoforward(var_05);
	var_08 = var_07 * var_06;
	var_09 = 5;
	var_0A = var_07 * var_06 - var_09;
	var_0B = anglestoright(var_05);
	var_0C = var_0B * var_09 * -1;
	var_0D = var_0B * var_09;
}

//Function Number: 79
func_5B24(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		param_03 = 32;
	}

	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = anglestoforward(param_02);
	var_07 = anglestoright(param_02);
	var_08 = anglestoup(param_02);
	var_09 = param_00 + var_06 * param_03 * 0.5;
	var_09 = var_09 + var_07 * param_03 * 0.5;
	var_0A = [];
	var_0A[var_0A.size] = var_09;
	var_0A[var_0A.size] = var_0A[var_0A.size - 1] + var_06 * param_03 * -1;
	var_0A[var_0A.size] = var_0A[var_0A.size - 1] + var_07 * param_03 * -1;
	var_0A[var_0A.size] = var_0A[var_0A.size - 1] + var_06 * param_03;
	var_0B = param_03 * var_08;
	for(var_0C = 0;var_0C < var_0A.size;var_0C++)
	{
		if(var_0C == var_0A.size - 1)
		{
			continue;
		}
	}
}