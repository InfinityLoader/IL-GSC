/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_debug.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 91
 * Decompile Time: 1458 ms
 * Timestamp: 10/27/2023 1:39:36 AM
*******************************************************************/

//Function Number: 1
debugchains()
{
	var_00 = getallnodes();
	var_01 = 0;
	var_02 = [];
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		if(!var_00[var_03].spawnflags & 2 && (isdefined(var_00[var_03].target) && getnodearray(var_00[var_03].target,"targetname").size > 0) || isdefined(var_00[var_03].targetname) && getnodearray(var_00[var_03].targetname,"target").size > 0)
		{
			var_02[var_01] = var_00[var_03];
			var_01++;
		}
	}

	var_04 = 0;
	for(;;)
	{
		if(getdvar("chain") == "1")
		{
			for(var_03 = 0;var_03 < var_02.size;var_03++)
			{
				if(distance(level.player getorigin(),var_02[var_03].origin) < 1500)
				{
				}
			}

			var_05 = function_016B("allies");
			for(var_03 = 0;var_03 < var_05.size;var_03++)
			{
				var_06 = var_05[var_03] animscripts/utility::func_3A52();
				if(isdefined(var_06))
				{
				}
			}
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 2
func_23E5(param_00)
{
	var_01 = function_016B();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		if(var_01[var_02] getentitynumber() != param_00)
		{
			continue;
		}

		var_01[var_02] thread debug_enemyposproc();
		break;
	}
}

//Function Number: 3
debug_stopenemypos(param_00)
{
	var_01 = function_016B();
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

//Function Number: 4
debug_enemyposproc()
{
	self endon("death");
	self endon("stop_drawing_enemy_pos");
	for(;;)
	{
		wait(0.05);
		if(isalive(self.enemy))
		{
		}

		if(!animscripts/utility::hasenemysightpos())
		{
			continue;
		}

		var_00 = animscripts/utility::func_3A97();
	}
}

//Function Number: 5
debug_enemyposreplay()
{
	var_00 = function_016B();
	var_01 = undefined;
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_01 = var_00[var_02];
		if(!isalive(var_01))
		{
			continue;
		}

		if(isdefined(var_01.lastenemysightpos))
		{
		}

		if(isdefined(var_01.goodshootpos))
		{
			if(var_01 method_824E())
			{
				var_03 = (1,0,0);
			}
			else
			{
				var_03 = (0,0,1);
			}

			var_04 = var_01.origin + (0,0,54);
			if(isdefined(var_01.node))
			{
				if(var_01.node.type == "Cover Left")
				{
					var_05 = 1;
					var_04 = anglestoright(var_01.node.angles);
					var_04 = var_04 * -32;
					var_04 = (var_04[0],var_04[1],64);
					var_04 = var_01.node.origin + var_04;
				}
				else if(var_01.node.type == "Cover Right")
				{
					var_05 = 1;
					var_04 = anglestoright(var_01.node.angles);
					var_04 = var_04 * 32;
					var_04 = (var_04[0],var_04[1],64);
					var_04 = var_01.node.origin + var_04;
				}
			}

			common_scripts\utility::draw_arrow(var_04,var_01.goodshootpos,var_03);
		}
	}

	if(1)
	{
	}

	if(!isalive(var_01))
	{
	}

	if(isalive(var_01.enemy))
	{
	}

	if(isdefined(var_01.lastenemysightpos))
	{
	}

	if(isalive(var_01.var_3D81))
	{
	}

	if(!var_01 animscripts/utility::hasenemysightpos())
	{
	}

	var_06 = var_01 animscripts/utility::func_3A97();
	if(isdefined(var_01.goodshootpos))
	{
	}
}

//Function Number: 6
drawenttag(param_00)
{
}

//Function Number: 7
drawtag(param_00,param_01,param_02)
{
	var_03 = self gettagorigin(param_00);
	var_04 = self gettagangles(param_00);
	drawarrow(var_03,var_04,param_01,param_02);
}

//Function Number: 8
draworgforever(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	for(;;)
	{
		if(isdefined(self))
		{
			var_01 = self.origin;
			var_02 = self.angles;
		}

		drawarrow(var_01,var_02,param_00);
		wait(0.05);
	}
}

//Function Number: 9
drawarrowforever(param_00,param_01)
{
	for(;;)
	{
		drawarrow(param_00,param_01);
		wait(0.05);
	}
}

//Function Number: 10
draworiginforever()
{
	while(isdefined(self))
	{
		drawarrow(self.origin,self.angles);
		wait(0.05);
	}
}

//Function Number: 11
drawarrow(param_00,param_01,param_02,param_03)
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

//Function Number: 12
drawforwardforever(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 100;
	}

	if(!isdefined(param_01))
	{
		param_01 = (0,1,0);
	}

	for(;;)
	{
		if(!isdefined(self))
		{
		}

		var_02 = anglestoforward(self.angles);
		wait(0.05);
	}
}

//Function Number: 13
drawplayerviewforever()
{
	for(;;)
	{
		drawarrow(level.player.origin,level.player getangles(),(1,1,1));
		wait(0.05);
	}
}

//Function Number: 14
drawtagforever(param_00,param_01)
{
	for(;;)
	{
		if(!isdefined(self))
		{
		}

		drawtag(param_00,param_01);
		wait(0.05);
	}
}

//Function Number: 15
func_2A8D(param_00,param_01)
{
	for(;;)
	{
		if(!isdefined(self.origin))
		{
			break;
		}

		drawtag(param_00,param_01,1000);
		wait(0.05);
	}
}

//Function Number: 16
func_2A47(param_00,param_01)
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

		drawtag(param_00,param_01);
		wait(0.05);
	}
}

//Function Number: 17
func_89BA(param_00,param_01)
{
	if(param_00 == "ai")
	{
		var_02 = function_016B();
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_02[var_03] drawtag(param_01);
		}
	}
}

//Function Number: 18
debug_corner()
{
	level.player.ignoreme = 1;
	var_00 = getallnodes();
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

	var_03 = function_016B();
	for(var_02 = 0;var_02 < var_03.size;var_02++)
	{
		var_03[var_02] delete();
	}

	level.debugspawners = function_016D();
	level.activenodes = [];
	level.completednodes = [];
	for(var_02 = 0;var_02 < level.debugspawners.size;var_02++)
	{
		level.debugspawners[var_02].targetname = "blah";
	}

	var_04 = 0;
	for(var_02 = 0;var_02 < 30;var_02++)
	{
		if(var_02 >= var_01.size)
		{
			break;
		}

		var_01[var_02] thread func_1FD6();
		var_04++;
	}

	if(var_01.size <= 30)
	{
	}

	for(;;)
	{
		level waittill("debug_next_corner");
		if(var_04 >= var_01.size)
		{
			var_04 = 0;
		}

		var_01[var_04] thread func_1FD6();
		var_04++;
	}
}

//Function Number: 19
func_1FD6()
{
	coversetupanim();
}

//Function Number: 20
coversetupanim()
{
	var_00 = undefined;
	var_01 = undefined;
	for(;;)
	{
		for(var_02 = 0;var_02 < level.debugspawners.size;var_02++)
		{
			wait(0.05);
			var_01 = level.debugspawners[var_02];
			var_03 = 0;
			for(var_04 = 0;var_04 < level.activenodes.size;var_04++)
			{
				if(distance(level.activenodes[var_04].origin,self.origin) > 250)
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
			for(var_04 = 0;var_04 < level.completednodes.size;var_04++)
			{
				if(level.completednodes[var_04] != self)
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

			level.activenodes[level.activenodes.size] = self;
			var_01.origin = self.origin;
			var_01.angles = self.angles;
			var_01.count = 1;
			var_00 = var_01 method_82CE();
			if(maps\_utility::func_77BE(var_00))
			{
				func_6575(self);
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
		var_00 method_8225(var_00.origin);
		thread createline(self.origin);
		var_00 thread maps\_utility::func_2425();
		thread func_2103(var_00);
		var_00 waittill("death");
	}

	func_6575(self);
	level.completednodes[level.completednodes.size] = self;
}

//Function Number: 21
func_6575(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.activenodes.size;var_02++)
	{
		if(level.activenodes[var_02] == param_00)
		{
			continue;
		}

		var_01[var_01.size] = level.activenodes[var_02];
	}

	level.activenodes = var_01;
}

//Function Number: 22
createline(param_00)
{
	wait(0.05);
}

//Function Number: 23
func_2103(param_00)
{
	var_01 = undefined;
	while(isalive(param_00))
	{
		var_01 = param_00.origin;
		wait(0.05);
	}

	wait(0.05);
}

//Function Number: 24
debugmisstime()
{
	self notify("stopdebugmisstime");
	self endon("stopdebugmisstime");
	self endon("death");
	for(;;)
	{
		if(self.a.var_52F4 <= 0)
		{
		}
		else
		{
		}

		wait(0.05);
	}
}

//Function Number: 25
func_2424()
{
	self notify("stopdebugmisstime");
}

//Function Number: 26
func_7028(param_00,param_01)
{
}

//Function Number: 27
func_2420(param_00)
{
}

//Function Number: 28
func_241D()
{
}

//Function Number: 29
func_654C()
{
}

//Function Number: 30
create_reflection_objects()
{
}

//Function Number: 31
func_20AD()
{
}

//Function Number: 32
debug_reflection()
{
}

//Function Number: 33
debug_reflection_buttons()
{
}

//Function Number: 34
func_6530()
{
}

//Function Number: 35
create_fxlighting_object()
{
}

//Function Number: 36
func_5CDD()
{
}

//Function Number: 37
func_23EB()
{
}

//Function Number: 38
debug_fxlighting_buttons()
{
}

//Function Number: 39
func_750B()
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
			var_02 = level.var_81E5;
		}

		if(!isdefined(var_01))
		{
			var_03 = level.player geteye();
		}

		var_04 = bullettrace(var_02,var_03,0,undefined);
	}
}

//Function Number: 40
func_23D0()
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
		var_08 = function_016B("allies").size;
		var_01 setvalue(var_08);
		var_09 = function_016B("bad_guys").size;
		var_02 setvalue(var_09);
		var_03 setvalue(getentarray("script_vehicle","classname").size);
		var_04 setvalue(var_07 + var_08 + var_09);
		wait(0.25);
	}
}

//Function Number: 41
func_5741()
{
	if(!self.damageshield)
	{
		self method_82E7((0,0,-500),level.player,level.player);
	}
}

//Function Number: 42
func_23FB()
{
}

//Function Number: 43
camera()
{
	wait(0.05);
	var_00 = getentarray("camera","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = getent(var_00[var_01].target,"targetname");
		var_00[var_01].var_59ED = var_02.origin;
		var_00[var_01].angles = vectortoangles(var_02.origin - var_00[var_01].origin);
	}

	for(;;)
	{
		var_03 = function_016B("axis");
		if(!var_03.size)
		{
			freeplayer();
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
			freeplayer();
			wait(0.5);
			continue;
		}

		var_06 = [];
		for(var_01 = 0;var_01 < var_04.size;var_01++)
		{
			var_07 = var_04[var_01];
			var_08 = var_07.var_59ED;
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
			freeplayer();
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

		func_70A3(var_0F);
		wait(3);
	}
}

//Function Number: 44
freeplayer()
{
	setdvar("cl_freemove","0");
}

//Function Number: 45
func_70A3(param_00)
{
	setdvar("cl_freemove","2");
}

//Function Number: 46
anglescheck()
{
	for(;;)
	{
		if(getdvar("angles","0") == "1")
		{
			setdvar("angles","0");
		}

		wait(1);
	}
}

//Function Number: 47
deathspawnerpreview()
{
	waittillframeend;
	for(var_00 = 0;var_00 < 50;var_00++)
	{
		if(!isdefined(level.deathspawnerents[var_00]))
		{
			continue;
		}

		var_01 = level.deathspawnerents[var_00];
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = var_01[var_02];
			if(isdefined(var_03.var_83E2))
			{
				continue;
			}
		}
	}
}

//Function Number: 48
func_4C99()
{
}

//Function Number: 49
func_8D02()
{
	precacheitem("defaultweapon");
	for(;;)
	{
		func_8703();
		wait(0.25);
	}
}

//Function Number: 50
func_8703()
{
	var_00 = getdvarfloat("scr_requiredMapAspectRatio",1);
	if(!isdefined(level.var_527E))
	{
		setdvar("scr_minimap_corner_targetname","minimap_corner");
		level.var_527E = "minimap_corner";
	}

	if(!isdefined(level.minimapheight))
	{
		setdvar("scr_minimap_height","0");
		level.minimapheight = 0;
	}

	var_01 = getdvarfloat("scr_minimap_height");
	var_02 = getdvar("scr_minimap_corner_targetname");
	if(var_01 != level.minimapheight || var_02 != level.var_527E)
	{
		if(isdefined(level.minimaporigin))
		{
			level.var_5281 unlink();
			level.minimaporigin delete();
			level notify("end_draw_map_bounds");
		}

		if(var_01 > 0)
		{
			level.minimapheight = var_01;
			level.var_527E = var_02;
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
						var_10 = func_8874(var_0B,vectordot(var_0B,var_06 - var_05) * var_0F - 1);
						var_07 = var_07 - var_10;
						var_06 = var_06 + var_10;
					}
					else
					{
						var_0F = var_10 / var_02;
						var_0D = var_0D * var_10;
						var_10 = func_8874(var_0B,vectordot(var_0B,var_07 - var_06) * var_10 - 1);
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
				function_0168("cg_fov",var_14);
				level.var_5281 = var_03;
				level.minimaporigin = var_09;
				thread drawminimapbounds(var_05,var_07,var_06);
			}
		}
	}
}

//Function Number: 51
func_3A4D()
{
	var_00 = [];
	var_00 = getentarray("minimap_line","script_noteworthy");
	var_01 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_01[var_02] = var_00[var_02] getchain();
	}

	return var_01;
}

//Function Number: 52
getchain()
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

//Function Number: 53
func_8874(param_00,param_01)
{
	return (param_00[0] * param_01,param_00[1] * param_01,param_00[2] * param_01);
}

//Function Number: 54
drawminimapbounds(param_00,param_01,param_02)
{
	level notify("end_draw_map_bounds");
	level endon("end_draw_map_bounds");
	var_03 = param_00[2] - param_02[2];
	var_04 = length(param_01 - param_02);
	var_05 = param_01 - param_00;
	var_05 = vectornormalize((var_05[0],var_05[1],0));
	param_01 = param_01 + func_8874(var_05,var_04 * 1 / 800 * 0);
	var_06 = param_02 - param_00;
	var_06 = vectornormalize((var_06[0],var_06[1],0));
	param_02 = param_02 + func_8874(var_06,var_04 * 1 / 800 * 0);
	var_07 = (cos(getnorthyaw()),sin(getnorthyaw()),0);
	var_08 = param_02 - param_01;
	var_09 = func_8874(var_07,vectordot(var_08,var_07));
	var_0A = func_8874(var_07,abs(vectordot(var_08,var_07)));
	var_0B = param_01;
	var_0C = param_01 + var_09;
	var_0D = param_02;
	var_0E = param_02 - var_09;
	var_0F = func_8874(param_01 + param_02,0.5) + func_8874(var_0A,0.51);
	var_10 = var_04 * 0.003;
	var_11 = func_3A4D();
	for(;;)
	{
		common_scripts\utility::array_levelthread(var_11,::common_scripts\utility::plot_points);
		wait(0.05);
	}
}

//Function Number: 55
func_4909(param_00)
{
	var_01 = vectornormalize(param_00 - self method_82D1());
	var_02 = vectornormalize(param_00 - (0,0,24) - self method_82D1());
	var_03 = vectordot(var_01,var_02);
	var_04 = anglestoforward(self getangles());
	var_05 = vectordot(var_04,var_01);
	if(var_05 > var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 56
func_23D7()
{
	wait(0.05);
	var_00 = function_016B();
	var_01 = [];
	var_01["axis"] = [];
	var_01["allies"] = [];
	var_01["neutral"] = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = var_00[var_02];
		if(!isdefined(var_03.currentcolorcode))
		{
			continue;
		}

		var_01[var_03.team][var_03.currentcolorcode] = 1;
		var_04 = (1,1,1);
		if(isdefined(var_03.var_6BCF))
		{
			var_04 = level.var_1E00[var_03.var_6BCF];
		}

		if(var_03.team == "axis")
		{
			continue;
		}

		var_03 func_83EF();
	}

	draw_colornodes(var_01,"allies");
	draw_colornodes(var_01,"axis");
}

//Function Number: 57
draw_colornodes(param_00,param_01)
{
	var_02 = getarraykeys(param_00[param_01]);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = (1,1,1);
		var_04 = level.var_1E00[getsubstr(var_02[var_03],0,1)];
		if(isdefined(level.colornodes_debug_array[param_01][var_02[var_03]]))
		{
			var_05 = level.colornodes_debug_array[param_01][var_02[var_03]];
			for(var_06 = 0;var_06 < var_05.size;var_06++)
			{
			}
		}
	}
}

//Function Number: 58
get_team_substr()
{
	if(self.team == "allies")
	{
		if(!isdefined(self.node.var_6B66))
		{
		}

		return self.node.var_6B66;
	}

	if(self.team == "axis")
	{
		if(!isdefined(self.node.script_color_axis))
		{
		}

		return self.node.script_color_axis;
	}
}

//Function Number: 59
func_83EF()
{
	if(!isdefined(self.node))
	{
	}

	if(!isdefined(self.var_6BCF))
	{
	}

	var_00 = get_team_substr();
	if(!isdefined(var_00))
	{
	}

	if(!issubstr(var_00,self.var_6BCF))
	{
	}
}

//Function Number: 60
func_3484()
{
	if(getdvar("depth_close") == "")
	{
		setdvar("depth_close","0");
	}

	if(getdvar("depth_far") == "")
	{
		setdvar("depth_far","1500");
	}

	var_00 = getdvarint("depth_close");
	var_01 = getdvarint("depth_far");
	setexponentialfog(var_00,var_01,1,1,1,1,0);
}

//Function Number: 61
debugthreat()
{
	level.var_4C2F = gettime();
	thread debugthreatcalc();
}

//Function Number: 62
debugthreatcalc()
{
}

//Function Number: 63
displaythreat(param_00,param_01)
{
	if(self.team == param_00.team)
	{
	}

	var_02 = 0;
	var_02 = var_02 + self.threatbias;
	var_03 = 0;
	var_03 = var_03 + param_00.threatbias;
	var_04 = undefined;
	if(isdefined(param_01))
	{
		var_04 = self getthreatbiasgroup();
		if(isdefined(var_04))
		{
			var_03 = var_03 + getthreatbias(param_01,var_04);
			var_02 = var_02 + getthreatbias(var_04,param_01);
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
	var_08 = !isplayer(self) && self.pacifist;
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

//Function Number: 64
debugcolorfriendlies()
{
	level.var_23D4 = [];
	level.debug_color_huds = [];
	for(;;)
	{
		level waittill("updated_color_friendlies");
		draw_color_friendlies();
	}
}

//Function Number: 65
draw_color_friendlies()
{
	level endon("updated_color_friendlies");
	var_00 = getarraykeys(level.var_23D4);
	var_01 = [];
	var_02 = [];
	var_02[var_02.size] = "r";
	var_02[var_02.size] = "o";
	var_02[var_02.size] = "y";
	var_02[var_02.size] = "g";
	var_02[var_02.size] = "c";
	var_02[var_02.size] = "b";
	var_02[var_02.size] = "p";
	var_03 = maps\_utility::func_3992();
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_01[var_02[var_04]] = 0;
	}

	for(var_04 = 0;var_04 < var_00.size;var_04++)
	{
		var_05 = level.var_23D4[var_00[var_04]];
		var_01[var_05]++;
	}

	for(var_04 = 0;var_04 < level.debug_color_huds.size;var_04++)
	{
		level.debug_color_huds[var_04] destroy();
	}

	level.debug_color_huds = [];
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
			var_0B setmaterial("white",16,16);
			var_0B.alignx = "left";
			var_0B.aligny = "bottom";
			var_0B.alpha = 1;
			var_0B.color = var_03[var_02[var_04]];
			level.debug_color_huds[level.debug_color_huds.size] = var_0B;
		}

		var_07 = var_07 + var_09;
	}
}

//Function Number: 66
func_5FCD()
{
	for(;;)
	{
		if(isdefined(level.player.node))
		{
		}

		wait(0.05);
	}
}

//Function Number: 67
func_2A8F()
{
	if(isalive(self.color_user))
	{
	}
}

//Function Number: 68
debuggoalpos()
{
	for(;;)
	{
		var_00 = function_016B();
		common_scripts\utility::func_F1B(var_00,::func_89A8);
		wait(0.05);
	}
}

//Function Number: 69
func_89A8()
{
	if(!isdefined(self.goalpos))
	{
	}
}

//Function Number: 70
colordebug()
{
	wait(0.5);
	var_00 = [];
	var_00[var_00.size] = "r";
	var_00[var_00.size] = "g";
	var_00[var_00.size] = "b";
	var_00[var_00.size] = "y";
	var_00[var_00.size] = "o";
	var_00[var_00.size] = "p";
	var_00[var_00.size] = "c";
	for(;;)
	{
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			var_02 = level.currentcolorforced["allies"][var_00[var_01]];
			if(isdefined(var_02))
			{
				draw_colored_nodes(var_02);
			}
		}

		wait(0.05);
	}
}

//Function Number: 71
draw_colored_nodes(param_00)
{
	var_01 = level.arrays_of_colorcoded_nodes["allies"][param_00];
	common_scripts\utility::func_F1B(var_01,::func_2A8F);
}

//Function Number: 72
add_hud_line(param_00,param_01,param_02)
{
	var_03 = newhudelem();
	var_03.alignx = "left";
	var_03.aligny = "middle";
	var_03.x = param_00;
	var_03.y = param_01;
	var_03.alpha = 1;
	var_03.fontscale = 1;
	var_03.label = param_02;
	level.animsound_hud_extralines[level.animsound_hud_extralines.size] = var_03;
	return var_03;
}

//Function Number: 73
get_alias_from_stored(param_00)
{
	if(!isdefined(level.animsound_aliases[param_00.animname]))
	{
	}

	if(!isdefined(level.animsound_aliases[param_00.animname][param_00.var_DF7]))
	{
	}

	if(!isdefined(level.animsound_aliases[param_00.animname][param_00.var_DF7][param_00.var_5696]))
	{
	}

	return level.animsound_aliases[param_00.animname][param_00.var_DF7][param_00.var_5696]["soundalias"];
}

//Function Number: 74
func_47F5(param_00,param_01,param_02)
{
	return isdefined(level.animsound_aliases[param_00][param_01][param_02]["created_by_animSound"]);
}

//Function Number: 75
func_27DA()
{
	if(distance(level.player.origin,self.origin) > 1500)
	{
	}

	level.animsounds_thisframe[level.animsounds_thisframe.size] = self;
}

//Function Number: 76
func_23CA(param_00)
{
}

//Function Number: 77
debug_animsoundtagselected()
{
}

//Function Number: 78
func_7E61(param_00,param_01)
{
	if(!isdefined(level.var_E11))
	{
	}

	if(!isdefined(level.var_E11.animsounds[param_01]))
	{
	}

	var_02 = level.var_E11.animsounds[param_01];
	var_03 = get_alias_from_stored(var_02);
	if(!isdefined(var_03) || func_47F5(var_02.animname,var_02.var_DF7,var_02.var_5696))
	{
		level.animsound_aliases[var_02.animname][var_02.var_DF7][var_02.var_5696]["soundalias"] = param_00;
		level.animsound_aliases[var_02.animname][var_02.var_DF7][var_02.var_5696]["created_by_animSound"] = 1;
	}
}

//Function Number: 79
func_8172(param_00)
{
	var_01 = "\";
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02] == "\")
		{
			var_01 = var_01 + "\\";
			var_01 = var_01 + "\";
			continue;
		}

		var_01 = var_01 + param_00[var_02];
	}

	var_01 = var_01 + "\";
	return var_01;
}

//Function Number: 80
func_4E1C(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_02))
	{
		param_02 = (1,1,1);
	}

	if(isdefined(param_05))
	{
		param_05 = param_05 * 20;
		for(var_06 = 0;var_06 < param_05;var_06++)
		{
			wait(0.05);
		}
	}

	wait(0.05);
}

//Function Number: 81
func_6196(param_00,param_01,param_02)
{
	wait(0.05);
}

//Function Number: 82
complete_me()
{
	if(getdvar("credits_active") == "1")
	{
		wait(7);
		setdvar("credits_active","0");
		maps\_endmission::func_2132();
	}

	wait(7);
	maps\_utility::func_55F6();
}

//Function Number: 83
find_new_chase_target(param_00)
{
}

//Function Number: 84
chasecam(param_00)
{
	if(!isdefined(level.chase_cam_last_num))
	{
		level.chase_cam_last_num = -1;
	}

	if(level.chase_cam_last_num == param_00)
	{
	}

	find_new_chase_target(param_00);
	if(!isdefined(level.var_1B24))
	{
	}

	level.chase_cam_last_num = param_00;
	if(!isdefined(level.chase_cam_ent))
	{
		level.chase_cam_ent = level.var_1B24 common_scripts\utility::func_7836();
	}

	thread chasecam_onent(level.var_1B24);
}

//Function Number: 85
chasecam_onent(param_00)
{
	level notify("new_chasecam");
	level endon("new_chasecam");
	param_00 endon("death");
	level.player unlink();
	level.player playerlinktoblend(level.chase_cam_ent,"tag_origin",2,0.5,0.5);
	wait(2);
	level.player playerlinktodelta(level.chase_cam_ent,"tag_origin",1,180,180,180,180);
	for(;;)
	{
		wait(0.2);
		if(!isdefined(level.var_1B24))
		{
		}

		var_01 = level.var_1B24.origin;
		var_02 = level.var_1B24.angles;
		var_03 = anglestoforward(var_02);
		var_03 = var_03 * 200;
		var_01 = var_01 + var_03;
		var_02 = level.player getangles();
		var_03 = anglestoforward(var_02);
		var_03 = var_03 * -200;
		level.chase_cam_ent moveto(var_01 + var_03,0.2);
	}
}

//Function Number: 86
viewfx()
{
	foreach(var_01 in level.createfxent)
	{
		if(isdefined(var_01.looper))
		{
		}
	}
}

//Function Number: 87
add_key(param_00,param_01)
{
}

//Function Number: 88
func_619F(param_00)
{
	if(!isdefined(level.var_8A2E))
	{
		level.var_8A2E = 9500;
	}

	level.var_8A2E++;
	var_01 = "bridge_helpers";
	add_key("origin",self.origin[0] + " " + self.origin[1] + " " + self.origin[2]);
	add_key("angles",self.angles[0] + " " + self.angles[1] + " " + self.angles[2]);
	add_key("targetname","helper_model");
	add_key("model",self.model);
	add_key("classname","script_model");
	add_key("spawnflags","4");
	add_key("_color","0.443137 0.443137 1.000000");
	if(isdefined(param_00))
	{
		add_key("script_noteworthy",param_00);
	}
}

//Function Number: 89
func_2A57(param_00)
{
}

//Function Number: 90
func_2A58()
{
	var_00 = level.player getangles();
	var_01 = anglestoforward(var_00);
	var_02 = level.player geteye();
	var_03 = self geteye();
	var_04 = vectortoangles(var_03 - var_02);
	var_05 = anglestoforward(var_04);
	var_06 = vectordot(var_05,var_01);
}

//Function Number: 91
func_46A2()
{
	var_00 = getentarray("explodable_barrel","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("explodable_barrel","script_noteworthy"));
	if(!var_00.size)
	{
	}

	foreach(var_02 in var_00)
	{
		var_02.destructible_type = "explodable_barrel";
		var_03 = var_02.model + "2";
		precachemodel(var_03);
		var_02 setmodel(var_03);
		if(isdefined(var_02.target))
		{
			var_04 = getent(var_02.target,"targetname");
			if(isdefined(var_04))
			{
				var_04.script_destruct_collision = "pre";
			}

			var_02.targetname = "destructible_toy";
		}
	}

	iprintlnbold("Old Interactive_Objects being converted, rebuild map to avoid this warning ");
}