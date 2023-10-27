/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_audio_submixes.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 323 ms
 * Timestamp: 10/27/2023 3:27:01 AM
*******************************************************************/

//Function Number: 1
func_524C()
{
	lib_02EF::func_524B();
	level.var_7FF7 = ::func_06B6;
}

//Function Number: 2
func_1E76(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	foreach(var_0C in level.var_744A)
	{
		if(issplitscreen() == 1)
		{
			if(var_0C issplitscreenplayer() == 1 && var_0C method_82ED() == 0)
			{
				continue;
			}
		}

		if(isdefined(param_00) == 1 && isdefined(var_0C.var_12C["team"]) == 1 && var_0C.var_12C["team"] != param_00)
		{
			continue;
		}

		var_0C lib_02EF::func_1E74(param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}
}

//Function Number: 3
submixexistsquick(param_00)
{
	if(!isdefined(level.var_94CA))
	{
		level.var_94CA = [];
	}

	if(isdefined(level.var_94CA[param_00]))
	{
		return level.var_94CA[param_00];
	}

	var_01 = lib_02EF::func_94CA(param_00);
	level.var_94CA[param_00] = var_01;
	return var_01;
}

//Function Number: 4
_sfx_player_submix_init()
{
	var_00 = self;
	if(isdefined(var_00) == 0)
	{
		return;
	}

	if(isdefined(var_00._audiosubmixes) == 0)
	{
		var_00._audiosubmixes = [];
	}
}

//Function Number: 5
func_8A9D(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	if(function_0279(var_04) == 1)
	{
		return;
	}

	var_04 _sfx_player_submix_init();
	if(submixexistsquick(param_00) == 0)
	{
		return;
	}

	if(isdefined(param_01) == 0)
	{
		param_01 = 0.1;
	}

	if(isdefined(param_02) == 0)
	{
		param_02 = 1;
	}

	if(isdefined(param_03) == 1)
	{
		var_04 method_8626(param_00,param_01,param_02,param_03);
	}
	else
	{
		var_04 method_8626(param_00,param_01,param_02);
	}

	var_04._audiosubmixes[param_00] = param_02;
	var_04 func_8A9E(param_00,param_02,param_01);
}

//Function Number: 6
_sfx_player_submix_blend_calc(param_00,param_01,param_02)
{
	var_03 = self;
	var_03 notify("sfx_player_submix_blend_calc_stop");
	var_03 endon("sfx_player_submix_blend_calc_stop");
	var_03 endon("disconnect");
	if(param_02 > 0)
	{
		var_04 = var_03._audiosubmixes[param_00];
		var_05 = param_01 - var_04;
		var_06 = int(param_02 / 0.05);
		var_07 = var_05 / param_02 / 0.05;
		while(var_06 > 0)
		{
			if(!isdefined(var_03._audiosubmixes[param_00]))
			{
				return;
			}

			var_03._audiosubmixes[param_00] = var_03._audiosubmixes[param_00] + var_07;
			var_06--;
			wait 0.05;
		}
	}

	var_03._audiosubmixes[param_00] = param_01;
}

//Function Number: 7
func_8A9E(param_00,param_01,param_02)
{
	var_03 = self;
	if(function_0279(var_03) == 1)
	{
		return;
	}

	var_03 _sfx_player_submix_init();
	if(submixexistsquick(param_00) == 0)
	{
		return;
	}

	if(isdefined(var_03._audiosubmixes[param_00]) == 0)
	{
		var_03 func_8A9D(param_00,0,0);
	}

	if(isdefined(param_02) == 1)
	{
		var_03 method_8629(param_00,param_01,param_02);
		var_03 thread _sfx_player_submix_blend_calc(param_00,param_01,param_02);
		return;
	}

	if(isdefined(param_01) == 1)
	{
		var_03 method_8629(param_00,param_01);
		var_03._audiosubmixes[param_00] = param_01;
		return;
	}

	var_03 method_8629(param_00);
	var_03._audiosubmixes[param_00] = param_01;
}

//Function Number: 8
func_8A9F(param_00,param_01)
{
	var_02 = self;
	if(function_0279(var_02) == 1)
	{
		return;
	}

	var_02 _sfx_player_submix_init();
	if(submixexistsquick(param_00) == 0)
	{
		return;
	}

	if(isdefined(param_01) == 1 && param_01 > 0)
	{
		var_02 func_8A9E(param_00,0,param_01);
		var_02 common_scripts\utility::func_2CBE(param_01 + 0.05,::method_8627,param_00,0);
		return;
	}

	var_02 method_8627(param_00);
	var_02._audiosubmixes[param_00] = undefined;
}

//Function Number: 9
sfx_player_submix_exists(param_00)
{
	var_01 = self;
	return isdefined(var_01._audiosubmixes) && isdefined(var_01._audiosubmixes[param_00]);
}

//Function Number: 10
func_8ABB(param_00,param_01,param_02,param_03,param_04)
{
	thread func_1E76(param_00,::func_8A9D,param_01,param_02,param_03,param_04);
}

//Function Number: 11
func_8ABC(param_00,param_01,param_02,param_03)
{
	thread func_1E76(param_00,::func_8A9E,param_01,param_02,param_03);
}

//Function Number: 12
func_8ABD(param_00,param_01,param_02)
{
	thread func_1E76(param_00,::func_8A9F,param_01,param_02);
}

//Function Number: 13
func_06B6(param_00,param_01,param_02,param_03)
{
	var_04 = "" + param_00;
	self scriptmodelplayanim(var_04,param_02,0,param_03,0);
}

//Function Number: 14
func_7A39(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0.5;
	}

	if(!isdefined(param_02))
	{
		param_02 = "shared_default";
	}

	if(!isdefined(level.var_5AB))
	{
		level.var_5AB = spawnstruct();
		level.var_5AB.var_E5 = 0;
	}

	param_03 = clamp(param_03,0,1);
	param_03 = common_scripts\utility::func_7F03(param_03,1);
	param_03 = param_03 * 5;
	var_04 = 0;
	for(var_05 = 0;var_05 < param_03;var_05++)
	{
		var_04 = var_04 + randomfloatrange(param_00,param_01);
	}

	var_06 = var_04 / param_03;
	if(var_06 > param_01 * 0.5)
	{
		var_06 = var_06 - param_01;
	}

	var_06 = var_06 + param_01 * 0.5;
	var_07 = level.var_5AB.var_E5;
	var_08 = param_01 - param_00;
	var_09 = var_08 * 0.5;
	if(abs(var_07 - var_06) < var_08 * 0.2)
	{
		var_06 = lib_02EF::func_8086(var_06,param_00,param_01,param_01 - randomfloatrange(0,var_08 * 0.35),param_00 + randomfloatrange(0,var_08 * 0.35));
		var_06 = clamp(var_06,param_00,param_01);
	}

	level.var_5AB.var_E5 = var_06;
	return var_06;
}

//Function Number: 15
func_06C6(param_00,param_01,param_02)
{
	if(isdefined(self) == 0)
	{
		return;
	}

	if(function_0279(self) == 1)
	{
		return;
	}

	self endon("death");
	if(isdefined(self.var_8F45) == 1)
	{
		self.var_8F45 endon("death");
		lib_02F0::func_800F(self,self.var_8F45);
	}

	if(isdefined(param_00) == 0)
	{
		return;
	}

	var_03 = self;
	if(isdefined(param_02))
	{
		param_02 waittill(param_00);
	}
	else
	{
		level waittill(param_00);
	}

	lib_02F0::func_800E(var_03,param_01);
}

//Function Number: 16
func_8001(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = self;
	var_09 = lib_02F0::func_800B(param_00,var_08,param_06,param_05,param_02,param_07);
	if(isdefined(var_09) == 1)
	{
		if(isdefined(param_04) == 1)
		{
			lib_02F0::func_800D(var_09,param_04,0);
		}

		var_09 thread func_06C6(param_01,param_03,var_08);
	}

	return var_09;
}

//Function Number: 17
func_7FFA(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = lib_02F0::func_800A(param_00,param_01,param_03,param_06);
	if(isdefined(var_07) == 1)
	{
		if(isdefined(param_05) == 1)
		{
			lib_02F0::func_800D(var_07,param_05,0);
		}

		var_07 thread func_06C6(param_02,param_04);
	}

	return var_07;
}

//Function Number: 18
func_7FF9(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = lib_02F0::func_800A(param_00,undefined,param_02,param_05);
	if(isdefined(var_06) == 1)
	{
		if(isdefined(param_04) == 1)
		{
			lib_02F0::func_800D(var_06,param_04,0);
		}

		var_06 thread func_06C6(param_01,param_03);
	}

	return var_06;
}

//Function Number: 19
func_8004(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = self;
	var_09 = lib_02F0::func_800B(param_00,var_08,param_06,param_05,param_02,param_07);
	if(isdefined(var_09) == 1)
	{
		if(isdefined(param_04) == 1)
		{
			lib_02F0::func_800D(var_09,param_04,0);
		}

		var_09 thread func_06C6(param_01,param_03,var_08);
	}

	return var_09;
}

//Function Number: 20
func_8002(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = lib_02F0::func_800A(param_00,undefined,param_02,param_05);
	if(isdefined(var_06) == 1)
	{
		if(isdefined(param_04) == 1)
		{
			lib_02F0::func_800D(var_06,param_04,0);
		}

		var_06 thread func_06C6(param_01,param_03);
	}

	return var_06;
}

//Function Number: 21
func_6262(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_04) == 1 && param_04 > 0)
	{
		wait(param_04);
	}

	lib_02EF::func_8AB8(param_00,param_01,param_02,param_03,param_05);
}