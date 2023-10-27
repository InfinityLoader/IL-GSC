/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_idle.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 943 ms
 * Timestamp: 10/27/2023 12:24:34 AM
*******************************************************************/

//Function Number: 1
func_DEB8(param_00,param_01)
{
	level.var_1DBE[param_00] = param_01;
}

//Function Number: 2
func_7A2D(param_00)
{
	if(!isdefined(level.var_1DBE) || !isdefined(level.var_1DBE[param_00]))
	{
		return undefined;
	}

	return level.var_1DBE[param_00];
}

//Function Number: 3
func_CC7F(param_00,param_01)
{
	self.var_DC6F = 0;
	if(isai(param_00) && !isdefined(param_00.var_9B89))
	{
		param_00 method_8016("noclip");
	}

	wait(0.1);
	param_00 method_806F(%root,0);
	if(isdefined(param_00.var_9B89))
	{
		if(isdefined(param_01) && param_01)
		{
			thread func_DC82(param_00);
			thread func_DC86(param_00);
		}
		else
		{
			thread func_DC81(param_00);
			thread func_DC86(param_00);
		}
	}
	else if(isdefined(param_01) && param_01)
	{
		thread func_DC82(param_00);
		thread func_DC85();
	}
	else
	{
		thread func_DC81(param_00);
		thread func_DC85();
	}

	self waittill("ambient_idle_scene_end");
}

//Function Number: 4
func_CC80(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(isdefined(self.var_1DBC))
	{
		self.var_1DBC = scripts\common\utility::func_107CE();
	}

	var_03 = [];
	foreach(var_05 in param_00)
	{
		var_05.var_DC6F = 0;
		if(!param_01 && isai(var_05))
		{
			var_05 method_8016("noclip");
			var_05 method_80F1(self.origin,self.angles,100000);
			continue;
		}

		var_05.origin = self.origin;
		var_05.angles = self.angles;
	}

	if(param_02)
	{
		thread func_DC83(param_00);
		thread func_DC87(param_00);
	}
	else
	{
		thread func_DC84(param_00);
		thread func_DC87(param_00);
	}

	self waittill("ambient_idle_scene_end");
}

//Function Number: 5
func_4179()
{
	self method_806F(%root,0.1);
}

//Function Number: 6
func_DC81(param_00)
{
	self endon("death");
	self endon("ambient_idle_scene_end");
	var_01 = 0;
	var_02 = level.var_EC85[param_00.var_1FBB]["idle_anims"].size;
	var_03 = level.var_EC85[param_00.var_1FBB]["idle_base"];
	var_04 = [];
	var_05 = 0;
	self notify("ambient_idle_scene_start");
	thread lib_0B06::func_10CBF(param_00,"single anim");
	thread lib_0B06::func_1FCA(param_00,"single anim");
	for(;;)
	{
		if(var_04.size >= var_02)
		{
			var_05 = randomint(var_02);
			var_04 = [];
			var_04 = scripts\common\utility::array_add(var_04,var_05);
		}
		else
		{
			var_05 = randomint(var_02);
			for(;;)
			{
				if(scripts\common\utility::func_2286(var_04,var_05))
				{
					var_05 = randomint(var_02);
					continue;
				}

				var_04 = scripts\common\utility::array_add(var_04,var_05);
				break;
			}
		}

		if(!isdefined(param_00))
		{
			return;
		}

		var_06 = level.var_EC85[param_00.var_1FBB]["idle_anims"][var_05];
		var_07 = function_00CE(self.origin,self.angles,var_03);
		var_08 = function_00CD(self.origin,self.angles,var_03);
		if(isdefined(param_00.var_9B89) || !isai(param_00))
		{
			param_00.origin = var_07;
			param_00.angles = var_08;
		}
		else
		{
			param_00 method_80F1(var_07,var_08,100000);
		}

		var_09 = undefined;
		if(isdefined(param_00.var_1ED4))
		{
			var_09 = [[ param_00.var_1ED4 ]]();
		}

		var_0A = getanimlength(var_03);
		var_0B = randomintrange(1,4);
		var_0C = var_0A * float(var_0B);
		if(!isdefined(param_00))
		{
			return;
		}

		param_00 method_8018("single anim",self.origin,self.angles,var_03,undefined,undefined,0.2);
		wait(var_0C);
		if(!isdefined(param_00))
		{
			return;
		}

		func_13596(var_03,var_06[0],param_00);
		if(!isdefined(param_00))
		{
			return;
		}

		param_00 method_806F(var_03,0.1);
		param_00 method_8018("single anim",self.origin,self.angles,var_06[0],undefined,undefined,0.2);
		var_0D = getanimlength(var_06[0]);
		wait(var_0D);
		if(!isdefined(param_00))
		{
			return;
		}

		param_00 method_806F(var_06[0],0.1);
		param_00 method_8018("single anim",self.origin,self.angles,var_06[1],undefined,undefined,0.2);
		var_0A = getanimlength(var_06[1]);
		var_0B = randomintrange(1,4);
		var_0C = var_0A * float(var_0B);
		wait(var_0C);
		if(!isdefined(param_00))
		{
			return;
		}

		func_13596(var_06[1],var_06[2],param_00);
		if(!isdefined(param_00))
		{
			return;
		}

		param_00 method_806F(var_06[1],0.1);
		param_00 method_8018("single anim",self.origin,self.angles,var_06[2],undefined,undefined,0.2);
		var_0E = getanimlength(var_06[2]);
		wait(var_0E);
		if(!isdefined(param_00))
		{
			return;
		}

		param_00 method_806F(var_06[2],0.1);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 7
func_DC84(param_00)
{
	self endon("death");
	self endon("ambient_idle_scene_end");
	var_01 = 0;
	var_02 = level.var_EC85[param_00[0].var_1FBB]["idle_anims"].size;
	var_03 = level.var_EC85[param_00[0].var_1FBB]["idle_base"];
	var_04 = [];
	var_05 = 0;
	self notify("ambient_idle_scene_start");
	foreach(var_07 in param_00)
	{
		if(!isdefined(var_07.var_1FEC))
		{
			var_07 lib_0B06::func_F64A();
		}

		thread lib_0B06::func_10CBF(var_07,"single anim");
		thread lib_0B06::func_1FCA(var_07,"single anim");
	}

	for(;;)
	{
		if(var_04.size >= var_02)
		{
			var_05 = randomint(var_02);
			var_04 = [];
			var_04 = scripts\common\utility::array_add(var_04,var_05);
		}
		else
		{
			var_05 = randomint(var_02);
			for(;;)
			{
				if(scripts\common\utility::func_2286(var_04,var_05))
				{
					var_05 = randomint(var_02);
					continue;
				}

				var_04 = scripts\common\utility::array_add(var_04,var_05);
				break;
			}
		}

		var_09 = 0;
		var_0A = undefined;
		foreach(var_07 in param_00)
		{
			var_0A = level.var_EC85[var_07.var_1FBB]["idle_anims"][var_05];
			var_0C = function_00CE(self.origin,self.angles,var_03);
			var_0D = function_00CD(self.origin,self.angles,var_03);
			var_03 = level.var_EC85[var_07.var_1FBB]["idle_base"];
			if(isdefined(var_07.var_9B89) || !isai(var_07))
			{
				var_07.origin = var_0C;
				var_07.angles = var_0D;
			}
			else
			{
				var_07 method_80F1(var_0C,var_0D,100000);
			}

			var_0E = undefined;
			if(isdefined(var_07.var_1ED4))
			{
				var_0E = [[ var_07.var_1ED4 ]]();
			}

			var_0F = getanimlength(var_03);
			var_10 = randomintrange(1,4);
			var_09 = var_0F * float(var_10);
			var_07 method_8018("single anim",self.origin,self.angles,var_03,undefined,undefined,0.2);
		}

		wait(var_09);
		var_12 = [];
		foreach(var_07 in param_00)
		{
			var_12 = scripts\common\utility::array_add(var_12,level.var_EC85[var_07.var_1FBB]["idle_anims"][var_05][0]);
		}

		func_13597(var_03,var_12,param_00);
		foreach(var_07 in param_00)
		{
			var_03 = level.var_EC85[var_07.var_1FBB]["idle_base"];
			var_0A = level.var_EC85[var_07.var_1FBB]["idle_anims"][var_05];
			var_07 method_806F(var_03,0.1);
			var_07 method_8018("single anim",self.origin,self.angles,var_0A[0],undefined,undefined,0.2);
		}

		var_17 = getanimlength(var_0A[0]);
		wait(var_17);
		foreach(var_07 in param_00)
		{
			var_0A = level.var_EC85[var_07.var_1FBB]["idle_anims"][var_05];
			var_07 method_806F(var_0A[0],0.1);
			var_07 method_8018("single anim",self.origin,self.angles,var_0A[1],undefined,undefined,0.2);
		}

		var_0F = getanimlength(var_0A[1]);
		var_10 = randomintrange(1,4);
		var_09 = var_0F * float(var_10);
		wait(var_09);
		var_12 = [];
		foreach(var_07 in param_00)
		{
			var_12 = scripts\common\utility::array_add(var_12,level.var_EC85[var_07.var_1FBB]["idle_anims"][var_05][2]);
		}

		func_13597(var_0A[1],var_12,param_00);
		foreach(var_07 in param_00)
		{
			var_03 = level.var_EC85[var_07.var_1FBB]["idle_base"];
			var_0A = level.var_EC85[var_07.var_1FBB]["idle_anims"][var_05];
			var_07 method_806F(var_0A[1],0.1);
			var_07 method_8018("single anim",self.origin,self.angles,var_0A[2],undefined,undefined,0.2);
		}

		var_1E = getanimlength(var_0A[2]);
		wait(var_1E);
		foreach(var_07 in param_00)
		{
			var_0A = level.var_EC85[var_07.var_1FBB]["idle_anims"][var_05];
			var_07 method_806F(var_0A[2],0.1);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 8
func_DC85()
{
	lib_0A1E::func_2386();
	self notify("ambient_idle_scene_end");
}

//Function Number: 9
func_DC88(param_00)
{
	foreach(var_02 in param_00)
	{
		if(function_02A6(var_02))
		{
			var_02 lib_0A1E::func_2386();
			var_02 notify("ambient_idle_scene_end");
		}
	}
}

//Function Number: 10
func_DC86(param_00)
{
	self endon("death");
	self waittill("ambient_scene_end");
	if(function_02A6(param_00))
	{
		param_00 func_4179();
	}

	self notify("ambient_idle_scene_end");
}

//Function Number: 11
func_DC87(param_00)
{
	self endon("death");
	self waittill("ambient_scene_end");
	foreach(var_02 in param_00)
	{
		if(function_02A6(var_02))
		{
			var_02 method_83A1();
		}
	}

	self notify("ambient_idle_scene_end");
}

//Function Number: 12
func_DC82(param_00)
{
	self endon("death");
	self endon("ambient_idle_scene_end");
	var_01 = level.var_EC85[param_00.var_1FBB]["idle_anims"].size;
	var_02 = level.var_EC85[param_00.var_1FBB]["idle_base"];
	var_03 = [];
	var_04 = 0;
	self notify("ambient_idle_scene_start");
	thread lib_0B06::func_10CBF(param_00,"single anim");
	thread lib_0B06::func_1FCA(param_00,"single anim");
	for(;;)
	{
		if(var_03.size >= var_01)
		{
			var_04 = randomint(var_01);
			var_03 = [];
			var_03 = scripts\common\utility::array_add(var_03,var_04);
		}
		else
		{
			var_04 = randomint(var_01);
			for(;;)
			{
				if(scripts\common\utility::func_2286(var_03,var_04))
				{
					var_04 = randomint(var_01);
					continue;
				}

				var_03 = scripts\common\utility::array_add(var_03,var_04);
				break;
			}
		}

		var_05 = level.var_EC85[param_00.var_1FBB]["idle_anims"][var_04];
		var_06 = function_00CE(self.origin,self.angles,var_02);
		var_07 = function_00CD(self.origin,self.angles,var_02);
		if(isdefined(param_00.var_9B89) || !isai(param_00))
		{
			param_00.origin = var_06;
			param_00.angles = var_07;
		}
		else
		{
			param_00 method_80F1(var_06,var_07,100000);
		}

		var_08 = undefined;
		if(isdefined(param_00.var_1ED4))
		{
			var_08 = [[ param_00.var_1ED4 ]]();
		}

		var_09 = getanimlength(var_02);
		var_0A = randomintrange(1,4);
		var_0B = var_09 * float(var_0A);
		param_00 method_8018("single anim",self.origin,self.angles,var_02,undefined,undefined,0.2);
		wait(var_0B);
		param_00 method_806F(var_02,0.1);
		param_00 method_8018("single anim",self.origin,self.angles,var_05,undefined,undefined,0.2);
		var_0C = getanimlength(var_05);
		wait(var_0C);
		param_00 method_806F(var_05,0.1);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 13
func_DC83(param_00)
{
	self endon("death");
	self endon("ambient_idle_scene_end");
	var_01 = level.var_EC85[param_00[0].var_1FBB]["idle_anims"].size;
	var_02 = [];
	var_03 = 0;
	var_04 = self;
	self notify("ambient_idle_scene_start");
	foreach(var_06 in param_00)
	{
		var_07 = level.var_EC85[var_06.var_1FBB]["idle_base"];
		var_08 = function_00CE(self.origin,self.angles,var_07);
		var_09 = function_00CD(self.origin,self.angles,var_07);
		var_06.origin = var_08;
		var_06.angles = var_09;
		thread lib_0B06::func_10CBF(var_06,"single anim");
		thread lib_0B06::func_1FCA(var_06,"single anim");
		var_0A = undefined;
		if(isdefined(var_06.var_1ED4))
		{
			var_0A = [[ var_06.var_1ED4 ]]();
		}

		var_06 method_8018("single anim",self.origin,self.angles,var_07,undefined,var_0A,0);
	}

	for(;;)
	{
		if(var_02.size >= var_01)
		{
			var_03 = randomint(var_01);
			var_02 = [];
			var_02 = scripts\common\utility::array_add(var_02,var_03);
		}
		else
		{
			var_03 = randomint(var_01);
			for(;;)
			{
				if(scripts\common\utility::func_2286(var_02,var_03))
				{
					var_03 = randomint(var_01);
					continue;
				}

				var_02 = scripts\common\utility::array_add(var_02,var_03);
				break;
			}
		}

		var_0C = [];
		var_0D = 0;
		var_0E = randomintrange(1,4);
		foreach(var_06 in param_00)
		{
			var_07 = level.var_EC85[var_06.var_1FBB]["idle_base"];
			var_08 = function_00CE(self.origin,self.angles,var_07);
			var_09 = function_00CD(self.origin,self.angles,var_07);
			var_06.origin = var_08;
			var_06.angles = var_09;
			var_0A = undefined;
			if(isdefined(var_06.var_1ED4))
			{
				var_0A = [[ var_06.var_1ED4 ]]();
			}

			var_10 = getanimlength(var_07);
			var_0D = var_10;
			var_06 method_8018("single anim",self.origin,self.angles,var_07,undefined,var_0A,0.2);
		}

		wait(var_0D);
		var_12 = 0;
		foreach(var_06 in param_00)
		{
			var_07 = level.var_EC85[var_06.var_1FBB]["idle_base"];
			var_14 = level.var_EC85[var_06.var_1FBB]["idle_anims"][var_03];
			var_08 = function_00CE(self.origin,self.angles,var_14);
			var_09 = function_00CD(self.origin,self.angles,var_14);
			var_06.origin = var_08;
			var_06.angles = var_09;
			var_0A = undefined;
			if(isdefined(var_06.var_1ED4))
			{
				var_0A = [[ var_06.var_1ED4 ]]();
			}

			var_06 method_8018("single anim",self.origin,self.angles,var_14,undefined,var_0A,0.2);
			var_12 = getanimlength(var_14);
		}

		wait(var_12);
	}
}

//Function Number: 14
func_9B63(param_00)
{
	return isdefined(level.var_1DBE) && isdefined(level.var_1DBE[param_00]);
}

//Function Number: 15
func_9B62(param_00)
{
	if(isdefined(param_00.script_noteworthy) && func_9B63(param_00.script_noteworthy))
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
func_13596(param_00,param_01,param_02)
{
	self endon("death");
	self endon("ambient_idle_scene_end");
	param_02 endon("death");
	if(!isdefined(param_02))
	{
		return;
	}

	var_03 = length2d(level.player.origin - param_02.origin);
	var_04 = length2d(level.player.origin - param_02 scripts\anim\utility::func_7DC6(param_01));
	var_05 = float(getdvar("g_speed")) * 0.25;
	for(;;)
	{
		if(var_03 / var_05 > getanimlength(param_01) && var_04 / var_05 > getanimlength(param_01))
		{
			break;
		}

		if(!isdefined(param_02))
		{
			return;
		}

		var_03 = length2d(level.player.origin - param_02.origin);
		var_04 = length2d(level.player.origin - param_02 scripts\anim\utility::func_7DC6(param_01));
		var_05 = float(getdvar("g_speed")) * 0.25;
		var_06 = getanimlength(param_00);
		wait(var_06);
	}
}

//Function Number: 17
func_13597(param_00,param_01,param_02)
{
	self endon("death");
	self endon("ambient_idle_scene_end");
	var_03 = undefined;
	var_04 = undefined;
	var_05 = float(getdvar("g_speed")) * 0.25;
	for(;;)
	{
		var_06 = 0;
		for(var_07 = 0;var_07 < param_02.size;var_07++)
		{
			var_08 = param_02[var_07];
			var_03 = length2d(level.player.origin - var_08.origin);
			var_04 = length2d(level.player.origin - var_08 scripts\anim\utility::func_7DC6(param_01[var_07]));
			var_05 = float(getdvar("g_speed")) * 0.25;
			if(var_03 / var_05 > getanimlength(param_01[var_07]) && var_04 / var_05 > getanimlength(param_01[var_07]))
			{
				var_06++;
			}
		}

		if(var_06 >= param_02.size)
		{
			break;
		}

		var_09 = getanimlength(param_00);
		wait(var_09);
	}
}

//Function Number: 18
func_CDD6(param_00,param_01,param_02)
{
	self endon("stop_idles");
	self endon("death");
	param_00 endon("death");
	var_03 = [];
	var_04 = param_02;
	var_05 = undefined;
	param_00.var_DC89 = 1;
	for(;;)
	{
		lib_0B06::func_1F35(param_00,param_01);
		if(var_04.size < 1)
		{
			var_04 = var_03;
		}

		var_05 = randomint(var_04.size);
		lib_0B06::func_1F35(param_00,var_04[var_05]);
		var_03 = scripts\common\utility::array_add(var_03,var_04[var_05]);
		var_04 = scripts\common\utility::func_22A9(var_04,var_04[var_05]);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 19
func_11036()
{
	self notify("stop_idles");
	self.var_DC89 = undefined;
}