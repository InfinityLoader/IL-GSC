/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 888.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 91
 * Decompile Time: 23 ms
 * Timestamp: 10/27/2023 3:27:05 AM
*******************************************************************/

//Function Number: 1
func_8D89()
{
	level.var_71D = spawnstruct();
	level.var_11CB = spawnstruct();
	func_8D88();
	func_8D75();
	if(getdvarint("2803",0) > 0)
	{
		thread func_A8E4();
	}

	if(isdefined(level.var_8D62))
	{
		self [[ level.var_8D62 ]]();
		return;
	}

	maps\mp\_snd_common_mp::func_8D80();
}

//Function Number: 2
func_A8E4()
{
	self endon("game_ended");
	setdvarifuninitialized("e3_trailer_submix",0);
	setdvarifuninitialized("e3_mix_mode_activate",0);
	for(;;)
	{
		if(getdvarint("e3_mix_mode_activate",0) == 1)
		{
			setdvar("e3_mix_mode_activate",0);
			if(getdvarint("e3_trailer_submix",0) == 0)
			{
				foreach(var_01 in level.var_744A)
				{
					var_01 method_8628(0.5);
					wait 0.05;
					var_01 method_8626("mp_init_mix");
				}
			}
			else if(getdvarint("e3_trailer_submix",0) == 1)
			{
				foreach(var_01 in level.var_744A)
				{
					var_01 method_8628(0.5);
					wait 0.05;
					var_01 method_8626("mp_init_mix");
					wait 0.05;
					var_01 method_8626("mp_e3_trailer_mix_no_vox");
				}
			}
			else if(getdvarint("e3_trailer_submix",0) == 2)
			{
				foreach(var_01 in level.var_744A)
				{
					var_01 method_8628(0.5);
					wait 0.05;
					var_01 method_8626("mp_init_mix");
					wait 0.05;
					var_01 method_8626("mp_e3_trailer_mix_vox");
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 3
func_8D88()
{
	var_00 = "OmnvarChanged";
	var_00 = "ClientScriptInit";
	var_00 = "OmnvarChanged";
	var_00 = "FxNotify";
	var_00 = "FxBounceNotify";
	var_00 = "FxSparkNotify";
	var_00 = "NotetrackNotify";
	var_00 = "PlaySoundAttached";
	var_00 = "UpdateSoundAttached";
}

//Function Number: 4
func_8D8A()
{
	self.var_71D = spawnstruct();
	self.var_11CB = spawnstruct();
	func_8D74("player_connect");
}

//Function Number: 5
func_8D75()
{
	if(!isdefined(level.var_71D))
	{
		level.var_71D = spawnstruct();
	}

	if(!isdefined(level.var_71D.var_611B))
	{
		level.var_71D.var_611B = [];
	}
}

//Function Number: 6
func_8DC7(param_00,param_01)
{
	func_8D14(isdefined(level.var_71D),"Need to call snd_message_init( ) before calling this function.");
	func_8D14(isarray(level.var_71D.var_611B));
	level.var_71D.var_611B[param_00] = param_01;
}

//Function Number: 7
func_8D84(param_00,param_01,param_02)
{
	level notify("stop_other_music");
	level endon("stop_other_music");
	if(isdefined(param_02))
	{
		childthread func_8D74("snd_music_handler",param_00,param_01,param_02);
		return;
	}

	if(isdefined(param_01))
	{
		childthread func_8D74("snd_music_handler",param_00,param_01);
		return;
	}

	childthread func_8D74("snd_music_handler",param_00);
}

//Function Number: 8
func_8D74(param_00,param_01,param_02,param_03)
{
	func_8D14(isdefined(level.var_71D),"Need to call snd_message_init( ) before calling this function.");
	func_8D14(isarray(level.var_71D.var_611B));
	if(isdefined(level.var_71D.var_611B[param_00]))
	{
		if(isdefined(param_03))
		{
			thread [[ level.var_71D.var_611B[param_00] ]](param_01,param_02,param_03);
			return;
		}

		if(isdefined(param_02))
		{
			thread [[ level.var_71D.var_611B[param_00] ]](param_01,param_02);
			return;
		}

		if(isdefined(param_01))
		{
			thread [[ level.var_71D.var_611B[param_00] ]](param_01);
			return;
		}

		thread [[ level.var_71D.var_611B[param_00] ]]();
		return;
	}
}

//Function Number: 9
snd_zmb_set_sound_alias_parameter_modifier(param_00,param_01)
{
	self method_85A7("snd_zmb_set_sound_alias_parameter_modifier",param_00,param_01);
}

//Function Number: 10
func_9266()
{
	self method_85A7("snd_start_player_vox");
}

//Function Number: 11
func_93E2()
{
	self method_85A7("snd_stop_player_vox");
}

//Function Number: 12
func_8DDD(param_00,param_01)
{
	self method_85A7("snd_set_plr_speed_smoothing",param_00,param_01);
}

//Function Number: 13
func_8DDB(param_00,param_01)
{
	self method_85A7("snd_set_plr_fatigue_smoothing",param_00,param_01);
}

//Function Number: 14
func_8DDC(param_00)
{
	self method_85A7("snd_set_plr_is_female",param_00);
}

//Function Number: 15
func_8DDA(param_00)
{
	self method_85A7("snd_set_plr_char_id",param_00);
}

//Function Number: 16
func_8DCE(param_00,param_01)
{
	self method_85A7("snd_set_breath_master_vol",param_00,param_01);
}

//Function Number: 17
func_8DD3(param_00)
{
	self method_85A7("snd_set_expletive_enabled",param_00);
}

//Function Number: 18
set_expletive_chance(param_00)
{
	self method_85A7("set_expletive_chance",param_00);
}

//Function Number: 19
set_max_breath_lev_num(param_00)
{
	self method_85A7("set_max_breath_lev_num",param_00);
}

//Function Number: 20
func_851F(param_00)
{
	self method_85A7("set_max_plr_speed",param_00);
}

//Function Number: 21
func_92F3(param_00,param_01)
{
	thread func_9266();
	if(isdefined(param_00) && isdefined(param_01))
	{
		func_8DDB(param_00,param_01);
	}
}

//Function Number: 22
func_1BBE()
{
	self endon("disconnect");
	self waittill("death");
	thread func_93E2();
}

//Function Number: 23
func_1BBF()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		level common_scripts\utility::knock_off_battery("game_ended","round_end_finished");
		thread func_93E2();
	}
}

//Function Number: 24
func_1BBD()
{
	var_00 = 0;
	var_01 = self.var_20D8;
	if(self method_843D())
	{
		var_00 = 1;
	}

	if(isdefined(var_01))
	{
		func_8DDA(var_01);
		switch(var_01)
		{
			case 5:
			case 3:
			case 2:
				var_00 = 1;
				break;
		}
	}
	else
	{
		func_8DDA(undefined);
	}

	func_8DDC(var_00);
}

//Function Number: 25
func_8DF7(param_00)
{
	var_01 = 0;
	if(isdefined(level.var_744A))
	{
		foreach(var_03 in level.var_744A)
		{
			if(param_00 == var_03)
			{
				return 1;
			}
		}
	}

	return var_01;
}

//Function Number: 26
func_8DF8(param_00)
{
	var_01 = 1;
	if(!isarray(param_00))
	{
		var_01 = 0;
	}
	else
	{
		foreach(var_03 in param_00)
		{
			var_04 = 1;
			foreach(var_06 in level.var_744A)
			{
				if(var_03 == var_06)
				{
					var_04 = 0;
					break;
				}
			}

			if(var_04)
			{
				var_01 = 0;
				break;
			}
		}
	}

	return var_01;
}

//Function Number: 27
func_8DFE(param_00,param_01,param_02)
{
}

//Function Number: 28
func_8D14(param_00,param_01,param_02)
{
}

//Function Number: 29
func_8D86()
{
	if(!isdefined(level.var_71D.var_48CA))
	{
		level.var_71D.var_48CA = 0;
	}

	if(maps\mp\_utility::func_585F())
	{
		if(level.var_71D.var_48CA > 10000)
		{
			level.var_71D.var_48CA = 0;
		}
	}

	level.var_71D.var_48CA++;
	return level.var_71D.var_48CA;
}

//Function Number: 30
func_8D72(param_00,param_01)
{
	return piecewiselinearlookup(param_00,param_01);
}

//Function Number: 31
func_8D73(param_00,param_01,param_02,param_03)
{
	func_8D14(isdefined(param_00));
	func_8D14(isdefined(param_03));
	func_8D14(param_02 != param_01);
	var_04 = param_00 - param_01 / param_02 - param_01;
	var_04 = clamp(var_04,0,1);
	return piecewiselinearlookup(var_04,param_03);
}

//Function Number: 32
func_8DCB(param_00,param_01,param_02)
{
	param_01 = func_8D49(1,param_01);
	param_02 = func_8D49(1,param_02);
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		param_00[var_03][0] = param_00[var_03][0] * param_01;
		param_00[var_03][1] = param_00[var_03][1] * param_02;
	}

	return param_00;
}

//Function Number: 33
func_8D49(param_00,param_01)
{
	var_02 = param_00;
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	return var_02;
}

//Function Number: 34
func_8D1B(param_00)
{
	return randomfloat(1) < func_8D49(0.5,param_00);
}

//Function Number: 35
func_8DEB(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self;
	var_07 = param_00 + "_line_emitter_" + func_8D86();
	func_8D14(function_0344(param_00));
	func_8D14(isdefined(param_01));
	func_8D14(isdefined(param_02));
	param_03 = max(func_8D49(0.1,param_03),0);
	param_04 = max(func_8D49(0.1,param_04),0);
	param_05 = max(func_8D49(0.05,param_05),0.05);
	if(!isdefined(var_06.var_71D.var_5D87))
	{
		var_06.var_71D.var_5D87 = [];
	}

	var_08 = spawn("script_origin",(0,0,0));
	var_06.var_71D.var_5D87[var_07] = var_08;
	var_06 method_85A7("snd_start_line_emitter",var_07,var_08,param_00,param_01,param_02,param_03,param_04,param_05);
	return var_07;
}

//Function Number: 36
func_8DEE(param_00)
{
	func_8D14(isstring(param_00));
	func_8D14(isarray(level.var_71D.var_5D87));
	if(isdefined(level.var_71D.var_5D87[param_00]))
	{
		callclientscript(level.var_744A,"snd_stop_line_emitter",param_00);
		var_01 = level.var_71D.var_5D87[param_00];
		level.var_71D.var_5D87[param_00] = undefined;
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 37
func_8DA7(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(getdvarint("snd_debug"))
	{
		func_8D14(0,"snd_play_loop_at() IS OBSOLETE - DO NOT USE");
	}

	func_8D14(isstring(param_00));
	func_8D14(isdefined(param_01));
	func_8D14(isstring(param_02));
	param_01 = func_8D49((0,0,0),param_01);
	var_07 = func_8D49(0,param_03);
	var_08 = func_8D49(0.1,param_04);
	var_09 = func_8D49(1,param_05);
	var_0A = func_8D49(level,param_06);
	thread func_8E88(param_00,param_01,param_02,var_07,var_08,var_09,var_0A);
}

//Function Number: 38
func_8E88(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = playclientsound(param_00,undefined,param_01,undefined,undefined,undefined,param_03,undefined,param_05);
	if(!isdefined(var_07))
	{
		return;
	}

	param_06 common_scripts\utility::func_A732(param_02,"death");
	stopclientsound(var_07,param_04);
}

//Function Number: 39
func_8DAA(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(getdvarint("snd_debug"))
	{
		func_8D14(0,"snd_play_loop_on() IS OBSOLETE - DO NOT USE");
	}

	func_8D14(isstring(param_00));
	func_8D14(isdefined(param_01));
	func_8D14(isstring(param_02));
	var_06 = func_8D49(0,param_03);
	var_07 = func_8D49(0.1,param_04);
	var_08 = func_8D49(1,param_05);
	thread func_8E8A(param_00,param_01,param_02,var_06,var_07,var_08);
}

//Function Number: 40
func_8E8A(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = playclientsound(param_00,param_01,undefined,undefined,undefined,"hard",param_03,param_04,param_05);
	if(!isdefined(var_06))
	{
		return;
	}

	param_01 common_scripts\utility::func_A732(param_02,"death");
	stopclientsound(var_06,param_04);
}

//Function Number: 41
func_8D9E(param_00,param_01,param_02,param_03,param_04)
{
	callclientscript(level.var_744A,"snd_play_dist_conditional_at",param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 42
func_8D55(param_00,param_01,param_02,param_03)
{
}

//Function Number: 43
func_8D5B(param_00,param_01)
{
}

//Function Number: 44
func_8D56(param_00)
{
	foreach(var_02 in self.var_5ADF)
	{
		func_8D5B(var_02,"");
	}
}

//Function Number: 45
func_8D5A(param_00,param_01)
{
}

//Function Number: 46
func_8D57(param_00,param_01,param_02)
{
}

//Function Number: 47
func_8E7A(param_00,param_01,param_02)
{
}

//Function Number: 48
func_8E7B(param_00)
{
}

//Function Number: 49
func_8D58()
{
}

//Function Number: 50
func_8DC2(param_00,param_01)
{
}

//Function Number: 51
func_8D64(param_00)
{
}

//Function Number: 52
func_8D3B()
{
}

//Function Number: 53
func_8DE8(param_00)
{
}

//Function Number: 54
func_7207(param_00,param_01,param_02,param_03)
{
	var_04 = param_00;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	var_0A = param_02;
	var_0B = undefined;
	var_0C = param_03;
	var_0D = param_02;
	var_0E = param_01;
	var_0F = undefined;
	return playclientsound(var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F);
}

//Function Number: 55
func_7208(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00;
	var_06 = undefined;
	param_02 = param_02;
	var_07 = "world";
	var_08 = undefined;
	var_09 = undefined;
	var_0A = param_03;
	var_0B = undefined;
	var_0C = param_04;
	var_0D = param_03;
	var_0E = param_01;
	var_0F = undefined;
	return playclientsound(var_05,var_06,param_02,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F);
}

//Function Number: 56
func_7209(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = param_00;
	var_08 = param_02;
	var_09 = undefined;
	var_0A = undefined;
	var_0B = undefined;
	var_0C = func_8D49("hard",param_06);
	var_0D = param_03;
	var_0E = param_04;
	var_0F = param_05;
	var_10 = param_03;
	var_11 = param_01;
	var_12 = undefined;
	return playclientsound(var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,var_11,var_12);
}

//Function Number: 57
func_8D0B(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		var_02 method_8626(param_00);
	}
}

//Function Number: 58
func_8D18(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		var_02 method_8627(param_00);
	}
}

//Function Number: 59
func_8D0C(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = level.var_744A;
	}
	else if(!isarray(param_01))
	{
		param_01 = [param_01];
	}

	foreach(var_03 in param_01)
	{
		var_03 method_8626(param_00);
	}
}

//Function Number: 60
func_8D19(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = level.var_744A;
	}
	else if(!isarray(param_01))
	{
		param_01 = [param_01];
	}

	foreach(var_03 in param_01)
	{
		var_03 method_8627(param_00);
	}
}

//Function Number: 61
func_307C(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_77EF = hidden_pictures(::func_3082);
	var_03.var_586D = undefined;
	var_03.var_20CD = [];
	var_03.var_20CE = [];
	var_03.char_name_callouts = [];
	var_03.char_name_overrides = [];
	if(isdefined(param_00))
	{
		for(var_04 = 0;var_04 < param_00.size;var_04++)
		{
			var_03.var_20CD[var_04] = param_00[var_04];
			var_03.var_20CE[param_00[var_04]] = var_04;
			if(isdefined(param_01) && param_01.size > 0 && isdefined(param_01[var_04]))
			{
				var_03.char_name_callouts[var_04] = param_01[var_04];
			}

			if(isdefined(param_02) && param_02.size > 0 && isdefined(param_02[var_04]))
			{
				var_03.char_name_overrides[var_04] = param_02[var_04];
			}
		}
	}

	level.var_71D.var_305D = var_03;
	var_03 thread func_3086();
}

//Function Number: 62
func_307D()
{
}

//Function Number: 63
func_307E(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_3083();
	var_06 = self;
	var_07 = undefined;
	if(isdefined(param_01))
	{
		if(isarray(param_01))
		{
			var_07 = param_01;
		}
		else
		{
			var_07 = [param_01];
		}
	}

	var_0B = var_05 func_3080(param_00,var_06,var_07,param_02,param_03);
	if(isstring(param_04))
	{
		var_05 thread func_308A(var_06,var_0B,param_04);
	}
	else
	{
		var_06 waittill(var_0B);
	}
}

//Function Number: 64
func_308A(param_00,param_01,param_02)
{
	param_00 waittill(param_01);
	param_00 notify(param_02);
}

//Function Number: 65
func_307B(param_00)
{
	var_01 = func_3083();
	return var_01.var_20CD[param_00];
}

//Function Number: 66
func_307A(param_00)
{
	var_01 = func_3083();
	return var_01.var_20CE[param_00];
}

//Function Number: 67
dlg_get_char_name_callouts_from_name(param_00)
{
	var_01 = func_3083();
	var_02 = func_307A(param_00);
	return var_01.char_name_callouts[var_02];
}

//Function Number: 68
dlg_get_char_name_callouts_from_index(param_00)
{
	var_01 = func_3083();
	return var_01.char_name_callouts[param_00];
}

//Function Number: 69
dlg_get_char_name_override_from_index(param_00)
{
	var_01 = func_3083();
	return var_01.char_name_overrides[param_00];
}

//Function Number: 70
dlg_get_char_name_override_from_name(param_00)
{
	var_01 = func_3083();
	var_02 = func_307A(param_00);
	return var_01.char_name_overrides[var_02];
}

//Function Number: 71
func_307F(param_00)
{
	var_01 = func_3083();
	var_01.var_A22A = param_00;
}

//Function Number: 72
func_3083()
{
	return level.var_71D.var_305D;
}

//Function Number: 73
func_3080(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self;
	var_06 = var_05 func_3087(param_00,param_01,param_02,param_03,param_04);
	var_05.var_77EF func_8E61(var_06);
	return var_06.var_3220;
}

//Function Number: 74
func_3087(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.var_BB4 = param_00;
	var_05.var_90BE = param_01;
	var_05.var_5DD0 = param_02;
	var_05.var_90C0 = func_307B(param_01.var_20D8);
	var_05.var_7734 = func_8D49(0,param_03);
	var_05.var_1F18 = func_8D49(0,param_04);
	var_05.var_3220 = param_00 + "_" + func_8D86();
	return var_05;
}

//Function Number: 75
func_3086()
{
	var_00 = undefined;
	for(;;)
	{
		if(self.var_77EF func_8E62() > 0)
		{
			var_01 = func_3084();
			var_02 = func_3088(var_01);
			if(isdefined(var_02))
			{
				if(isdefined(self.var_A22A))
				{
					var_03 = var_01.var_90BE [[ self.var_A22A ]]("begin",var_02,var_01.var_BB4);
					if(isdefined(var_03))
					{
						dlgx_set_sound_handle_volume(var_02,var_03);
					}
				}

				var_01.var_90BE waittill(var_01.var_3220);
				if(isdefined(self.var_A22A))
				{
					var_01.var_90BE [[ self.var_A22A ]]("end",var_02,var_01.var_BB4);
				}
			}
			else
			{
				wait 0.05;
			}

			continue;
		}

		self.var_77EF waittill("size_changed");
	}
}

//Function Number: 76
func_3088(param_00)
{
	var_01 = [param_00.var_90BE];
	if(isdefined(param_00.var_5DD0))
	{
		foreach(var_03 in param_00.var_5DD0)
		{
			if(var_03 != param_00.var_90BE)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	var_05 = param_00.var_90BE;
	var_06 = 0;
	var_07 = 0.25;
	var_08 = 1;
	var_09 = lib_0380::func_288D(param_00.var_BB4,var_01,var_05,var_06,var_08,var_07);
	if(isdefined(var_09))
	{
		param_00.var_8E51 = var_09;
		func_308B(param_00);
		thread func_3089(param_00);
	}
	else
	{
		func_8D14(0,"dlgx_monitor(): could not play alias <" + param_00.var_BB4 + "> on CharacterIndex " + param_00.var_90BE.var_20D8);
	}

	return var_09;
}

//Function Number: 77
dlgx_set_sound_handle_volume(param_00,param_01)
{
	lib_0380::func_2891(param_00,param_01,0);
}

//Function Number: 78
func_3089(param_00)
{
	registerclientsounddonenotify(param_00.var_8E51,param_00.var_90BE,param_00.var_3220);
	var_01 = gettime();
	param_00.var_90BE waittill(param_00.var_3220);
	var_02 = gettime() - var_01 / 1000;
	func_3081();
}

//Function Number: 79
func_3082(param_00,param_01)
{
}

//Function Number: 80
func_3085()
{
	return isdefined(self.var_586D);
}

//Function Number: 81
func_308B(param_00)
{
	self.var_586D = param_00;
}

//Function Number: 82
func_3081()
{
	self.var_586D = undefined;
}

//Function Number: 83
func_3084()
{
	return self.var_77EF func_8E60();
}

//Function Number: 84
hidden_pictures(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_586C = func_8D49(::func_8E5F,param_00);
	var_02.var_6062 = func_8D49(10,param_01);
	var_02.var_28CC = 0;
	var_02.color = 0;
	var_02.var_95BE = 0;
	var_02.var_2A35 = [];
	return var_02;
}

//Function Number: 85
func_8E5F(param_00,param_01)
{
}

//Function Number: 86
func_8E61(param_00)
{
	if(!func_8E64())
	{
		self.var_2A35[self.var_95BE] = param_00;
		self.var_95BE = self.var_95BE + 1 % self.var_6062;
		self.var_28CC++;
		self notify("size_changed");
		return;
	}

	func_8D14(0,"QUE OVERFLOW");
}

//Function Number: 87
func_8E60()
{
	var_00 = undefined;
	if(!func_8E63())
	{
		var_00 = self.var_2A35[self.color];
		self.color = self.color + 1 % self.var_6062;
		self.var_28CC--;
		self notify("size_changed");
	}
	else
	{
		func_8D14(0,"QUE UNDERFLOW");
	}

	return var_00;
}

//Function Number: 88
func_8E62()
{
	return self.var_28CC;
}

//Function Number: 89
func_8E63()
{
	return self.color == self.var_95BE;
}

//Function Number: 90
func_8E64()
{
	return self.color == self.var_95BE + 1 % self.var_6062;
}

//Function Number: 91
func_8DE9(param_00,param_01,param_02,param_03)
{
	var_04 = func_8D49(param_02,param_03);
	var_05 = 1;
	if(param_01 > param_00)
	{
		var_05 = param_02;
	}
	else if(param_01 < param_00)
	{
		var_05 = var_04;
	}

	return param_00 + var_05 * param_01 - param_00;
}