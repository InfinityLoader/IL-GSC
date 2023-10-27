/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 752.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 12 ms
 * Timestamp: 10/27/2023 3:26:59 AM
*******************************************************************/

//Function Number: 1
func_7FE7()
{
	level.var_6B2 = spawnstruct();
	level.var_6B2.var_61A = [];
	level.var_6B2.var_720 = [];
	level.var_6B2.var_5E5 = [];
	level.var_6B2.var_5F8 = "entity";
	level.var_6B2.var_5F7 = 0.05;
	level.var_6B2.var_622 = spawn("script_origin",(0,0,0));
}

//Function Number: 2
rv_audio_update_entnotify_origin(param_00)
{
	level.var_6B2.var_622.var_116 = param_00;
}

//Function Number: 3
func_800B(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = level.var_6B2.var_5F8;
	var_07 = func_06C7(var_06,param_00,param_01,param_02,param_03,param_04,param_05);
	return var_07;
}

//Function Number: 4
func_800A(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_6B2.var_5F8;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = param_01;
	var_08 = func_06C7(var_04,param_00,var_05,var_06,var_07,param_02,param_03);
	return var_08;
}

//Function Number: 5
func_800E(param_00,param_01,param_02)
{
	if(isdefined(param_00) == 0)
	{
		return;
	}

	if(isarray(param_00) == 1)
	{
		foreach(var_04 in param_00)
		{
			if(function_0279(var_04) == 0)
			{
				var_04 thread func_06C9(var_04,param_01);
			}
		}

		return;
	}

	param_00 thread func_06C9(param_00,param_01);
}

//Function Number: 6
func_800F(param_00,param_01,param_02,param_03)
{
	param_01 thread func_06CA(param_00,param_01,param_02,param_03);
}

//Function Number: 7
func_8007(param_00)
{
	return lib_02EF::func_8AAB(param_00);
}

//Function Number: 8
func_800D(param_00,param_01,param_02,param_03,param_04)
{
	param_00 lib_02EF::func_8AAF(param_01,param_02,param_03,param_04);
}

//Function Number: 9
func_8005(param_00)
{
	return lib_02EF::func_8AAA(param_00);
}

//Function Number: 10
func_800C(param_00,param_01,param_02,param_03,param_04)
{
	param_00 lib_02EF::func_8AAC(param_01,param_02,param_03,param_04);
}

//Function Number: 11
func_8013(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00 = func_8015(param_00);
	var_07 = func_06C7(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	return var_07;
}

//Function Number: 12
func_8012(param_00,param_01,param_02,param_03,param_04)
{
	param_00 = func_8015(param_00);
	var_05 = undefined;
	var_06 = undefined;
	var_07 = param_02;
	var_08 = func_06C7(param_00,param_01,var_05,var_06,var_07,param_03,param_04);
	return var_08;
}

//Function Number: 13
func_8010()
{
	return "entity";
}

//Function Number: 14
func_8011()
{
	return level.var_6B2.var_5F8;
}

//Function Number: 15
func_8014(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00) == 0)
	{
		param_00 = "entity";
	}

	level.var_6B2.var_5F8 = func_8015(param_00);
}

//Function Number: 16
func_8006(param_00)
{
	if(isdefined(param_00.var_8F4E) == 1)
	{
		return param_00.var_8F4E;
	}

	return "";
}

//Function Number: 17
func_8015(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case 0:
		case "ent":
		case "e":
		case "entity":
			var_01 = "entity";
			break;

		case 1:
		case "sound_entity":
		case "soundentity":
		case "sndent":
		case "snd":
		case "sndentity":
		case "s":
			var_01 = "sndentity";
			break;

		case 2:
		case "client_sound":
		case "clientsound":
		case "clisnd":
		case "cs":
		case "clientsnd":
		case "client":
		case "c":
			var_01 = "clientsnd";
			break;

		default:
			var_01 = undefined;
			break;
	}

	return var_01;
}

//Function Number: 18
func_06B5(param_00,param_01)
{
}

//Function Number: 19
func_06B4(param_00,param_01)
{
}

//Function Number: 20
func_06B3()
{
	var_00 = self.var_8F4E;
	self waittill("death");
}

//Function Number: 21
func_06BE(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_02) == 1)
	{
		param_03 = param_02 lib_02EF::func_46BD(param_03);
		var_04 = (0,0,0);
		var_05 = (0,0,0);
		if(isdefined(param_01) == 1)
		{
			var_04 = param_01;
		}

		param_00 method_8449(param_02,param_03,var_04,var_05);
	}
}

//Function Number: 22
func_06BC(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = undefined;
	var_07 = undefined;
	var_08 = 0;
	if(isdefined(param_02) == 1 && isdefined(param_03) == 1 && isdefined(param_01) == 1)
	{
		var_07 = param_02 gettagorigin(param_03);
		var_07 = var_07 + param_01;
	}
	else if(isdefined(param_02) == 1 && isdefined(param_03) == 1)
	{
		var_07 = param_02 gettagorigin(param_03);
	}
	else if(isdefined(param_02) == 1)
	{
		var_07 = param_02.var_116;
	}
	else if(isdefined(param_02) == 0 && isdefined(param_01) == 0)
	{
		var_07 = (-32768,-32768,-32768);
	}
	else
	{
		var_07 = param_01;
	}

	var_06 = spawn("script_origin",var_07);
	func_06BE(var_06,param_01,param_02,param_03);
	var_06.var_8F45 = param_02;
	var_06.var_8F4E = "entity";
	return var_06;
}

//Function Number: 23
func_06BD(param_00)
{
	if(isdefined(param_00) == 1 && function_0279(param_00) == 0)
	{
		param_00 delete();
	}
}

//Function Number: 24
func_06BF(param_00,param_01,param_02,param_03)
{
	var_04 = param_00;
	var_05 = undefined;
	if(isdefined(param_00.var_8F45) == 1)
	{
		waittillframeend;
		if(function_0279(param_00) == 1)
		{
			return;
		}
	}

	var_05 = func_8007(var_04);
	if(isdefined(param_02) == 0 && isdefined(var_05) == 1)
	{
		param_02 = var_05;
	}

	if(issoundaliaslooping(param_01) == 1)
	{
		var_04 method_861D(param_01,param_02);
	}
	else
	{
		var_06 = "sounddone";
		var_04 method_8617(param_01,var_06,undefined,undefined,undefined,param_02);
		var_07 = getsndaliasvalue(param_01,"secondaryaliasname");
		if(isdefined(var_07) == 1 && var_07 != "")
		{
			var_04 thread func_06C1(param_01);
		}
		else
		{
			var_04 thread func_06C2(var_06);
		}
	}

	var_04.var_8F3E = param_01;
}

//Function Number: 25
func_06C0(param_00)
{
	param_00 endon("death");
	var_01 = param_00;
	if(isdefined(var_01) == 1 && function_0279(var_01) == 0)
	{
		var_01 method_8614();
		wait 0.05;
		func_06BD(var_01);
	}
}

//Function Number: 26
func_06C1(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_02 = lookupsoundlength(param_00);
	var_03 = lib_02EF::func_468E(param_00,"pitch_min");
	if(isdefined(var_03) == 1)
	{
		var_02 = var_02 * 1 / var_03;
	}

	wait(var_02);
	func_06BD(var_01);
}

//Function Number: 27
func_06C2(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 waittill(param_00);
	func_06BD(var_01);
}

//Function Number: 28
func_06C3(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 1;
	var_07 = 0;
	if(isdefined(param_04) == 0)
	{
		param_04 = 1;
	}

	if(isdefined(param_05) == 0)
	{
		param_05 = lib_02EF::func_4625();
	}

	var_08 = spawnsoundentity(param_00,param_01,var_06,var_07,param_04,param_02,param_03,param_05);
	var_08.var_8F45 = param_02;
	var_08.var_8F4E = "sndentity";
	return var_08;
}

//Function Number: 29
func_06C4(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03) == 0)
	{
		param_03 = lib_02EF::func_4625();
	}

	param_00 method_863E(0,param_02,param_03);
	param_00.var_8F3E = param_01;
}

//Function Number: 30
func_06C5(param_00)
{
	var_01 = param_00;
	if(isdefined(var_01) == 1)
	{
		var_02 = 0;
		var_01 method_863F(var_02);
	}
}

//Function Number: 31
func_06B9(param_00,param_01)
{
	var_02 = param_01.var_8F4E;
	var_03 = param_01.var_4983;
	var_04 = "_rvsnd_clientsnd_notify_" + var_03;
	self endon("death");
	self endon(var_04);
	self waittill(param_00);
	param_01 notify("death");
}

//Function Number: 32
func_06B8(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_01) == 0)
	{
		param_01 = (0,0,0);
	}

	if(isdefined(param_03) == 1)
	{
		param_03 = param_02 lib_02EF::func_46BD(param_03);
		var_06 = param_02 gettagorigin(param_03);
		if(isdefined(var_06) == 1)
		{
			param_01 = var_06 - param_02.var_116;
		}
	}

	var_07 = spawnstruct();
	var_07.var_8F49 = param_01;
	var_07.var_8F45 = param_02;
	var_07.var_8F44 = param_03;
	return var_07;
}

//Function Number: 33
func_06BA(param_00,param_01,param_02,param_03)
{
	var_04 = param_00.var_8F49;
	var_05 = param_00.var_8F45;
	var_06 = param_00.var_8F44;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	var_0A = undefined;
	var_0B = undefined;
	if(isdefined(var_04) == 1)
	{
		var_07 = "world";
	}

	if(isdefined(var_05) == 1)
	{
		var_07 = "body";
		var_08 = "soft_oriented";
	}

	if(isdefined(param_03) == 0)
	{
		param_03 = lib_02EF::func_4625();
	}

	param_00 = spawnstruct();
	param_00.var_4983 = playclientsound(param_01,var_05,var_04,var_07,var_06,var_08,var_09,var_0A,param_02,var_0B,param_03);
	if(isdefined(param_00.var_4983) == 0)
	{
		param_00 = undefined;
		return undefined;
	}

	param_00.var_8F3E = param_01;
	param_00.var_8F45 = var_05;
	param_00.var_8F4E = "clientsnd";
	param_00.var_8F49 = var_04;
	param_00.var_8F44 = var_06;
	return param_00;
}

//Function Number: 34
func_06BB(param_00)
{
	if(isdefined(param_00) == 1 && isdefined(param_00.var_4983) == 1)
	{
		var_01 = 0;
		stopclientsound(param_00.var_4983,var_01);
		param_00.var_4983 = undefined;
	}
}

//Function Number: 35
func_06C7(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = undefined;
	var_08 = param_04;
	var_09 = undefined;
	if(function_0344(param_01) == 0)
	{
		return undefined;
	}

	if(isdefined(level.var_6B2.var_5F8) == 0)
	{
		param_00 = level.var_6B2.var_5F8;
	}

	if(isdefined(param_05) == 0)
	{
		if(issoundaliaslooping(param_01) == 1)
		{
			param_05 = level.var_6B2.var_5F7;
		}
		else
		{
			param_05 = 0;
		}
	}

	if(isdefined(param_05) == 1 && param_05 > 0)
	{
		var_09 = 0;
	}

	switch(param_00)
	{
		case "entity":
		default:
			var_07 = func_06BC(param_01,var_08,param_02,param_03,var_09,param_06);
			var_07 thread func_06BF(var_07,param_01,var_09,param_06);
			break;

		case "sndentity":
			var_07 = func_06C3(param_01,var_08,param_02,param_03,var_09,param_06);
			var_07 thread func_06C4(var_07,param_01,var_09,param_06);
			break;

		case "clientsnd":
			var_07 = func_06B8(param_01,var_08,param_02,param_03,var_09,param_06);
			var_07 = func_06BA(var_07,param_01,var_09,param_06);
			break;
	}

	if(param_05 > 0)
	{
		var_0B = 0;
		if(param_00 == "entity" && isdefined(param_02) == 1)
		{
			var_0B = 0.05;
		}

		var_07 thread func_06C8(var_07,param_05,var_0B);
	}

	return var_07;
}

//Function Number: 36
func_06C9(param_00,param_01)
{
	param_00 endon("death");
	var_02 = param_00.var_8F4E;
	var_03 = param_00.var_8F3E;
	if(isdefined(var_03) == 1 && issoundaliaslooping(param_00.var_8F3E) == 1 && isdefined(param_01) == 0)
	{
		param_01 = level.var_6B2.var_5F7;
	}

	if(isdefined(param_01) == 1)
	{
		func_800D(param_00,0,param_01);
		wait(param_01 + 0.05);
		if(function_0279(param_00) == 1)
		{
			return;
		}
	}
	else
	{
		param_01 = 0;
	}

	switch(var_02)
	{
		case "entity":
		default:
			func_06C0(param_00);
			break;

		case "sndentity":
			func_06C5(param_00);
			break;

		case "clientsnd":
			func_06BB(param_00);
			break;
	}
}

//Function Number: 37
func_06CA(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	param_01 common_scripts\utility::knock_off_battery("death","deleted");
	func_06C9(param_00,param_02);
}

//Function Number: 38
func_06C8(param_00,param_01,param_02)
{
	func_800D(param_00,0,0);
	if(isdefined(param_02) == 1 && param_02 > 0)
	{
		param_00 endon("rvSndAbortInitialFadeIn");
		wait(param_02);
		waittillframeend;
	}

	if(isdefined(param_00) && !function_0279(param_00))
	{
		func_800D(param_00,1,param_01);
	}
}

//Function Number: 39
func_8009(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	if(isdefined(param_02) == 0)
	{
		param_02 = 0;
	}

	if(isdefined(param_03) == 0)
	{
		param_03 = 0;
	}

	if(isdefined(var_04.var_8F4E) == 0 && lib_02EF::func_56DB(var_04) == 1)
	{
		var_04 moveto(param_00,param_01,param_02,param_03);
		return;
	}

	switch(var_04.var_8F4E)
	{
		case "entity":
		default:
			var_04 moveto(param_00,param_01,param_02,param_03);
			break;

		case "sndentity":
			if(isdefined(var_04.var_8F45) == 1)
			{
				var_04.var_8F45 moveto(param_00,param_01,param_02,param_03);
			}
			else
			{
				var_04 moveto(param_00,param_01,param_02,param_03);
			}
			break;

		case "clientsnd":
			break;
	}
}

//Function Number: 40
func_8008(param_00)
{
	if(isdefined(param_00) == 1 && isdefined(param_00.var_8F4E) == 1)
	{
		switch(param_00.var_8F4E)
		{
			default:
				break;

			case "clientsnd":
			case "sndentity":
			case "entity":
				return 1;
		}
	}

	return 0;
}