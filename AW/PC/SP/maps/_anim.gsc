/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_anim.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 154
 * Decompile Time: 2653 ms
 * Timestamp: 10/27/2023 1:58:13 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(level.scr_notetrack))
	{
		level.scr_notetrack = [];
	}

	if(!isdefined(level.scr_face))
	{
		level.scr_face = [];
	}

	if(!isdefined(level.scr_look))
	{
		level.scr_look = [];
	}

	if(!isdefined(level.scr_animsound))
	{
		level.scr_animsound = [];
	}

	if(!isdefined(level.scr_sound))
	{
		level.scr_sound = [];
	}

	if(!isdefined(level.scr_radio))
	{
		level.scr_radio = [];
	}

	if(!isdefined(level.scr_text))
	{
		level.scr_text = [];
	}

	if(!isdefined(level.scr_anim))
	{
		level.scr_anim[0][0] = 0;
	}

	if(!isdefined(level.scr_radio))
	{
		level.scr_radio = [];
	}

	if(!isdefined(level.scr_goaltime))
	{
		level.scr_goaltime = [];
	}

	common_scripts\utility::create_lock("moreThanThreeHack",3);
	if(maps\_utility::is_gen4())
	{
		common_scripts\utility::create_lock("trace_part_for_efx",12);
	}
	else
	{
		common_scripts\utility::create_lock("trace_part_for_efx");
	}
}

//Function Number: 2
endonremoveanimactive(param_00,param_01)
{
	self waittill(param_00);
	foreach(var_03 in param_01)
	{
		var_04 = var_03["guy"];
		if(!isdefined(var_04))
		{
			continue;
		}

		var_04._animactive--;
		var_04._lastanimtime = gettime();
	}
}

//Function Number: 3
anim_first_frame(param_00,param_01,param_02)
{
	var_03 = get_anim_position(param_02);
	var_04 = var_03["origin"];
	var_05 = var_03["angles"];
	common_scripts\utility::array_levelthread(param_00,::anim_first_frame_on_guy,param_01,var_04,var_05);
}

//Function Number: 4
anim_generic_first_frame(param_00,param_01,param_02)
{
	var_03 = get_anim_position(param_02);
	var_04 = var_03["origin"];
	var_05 = var_03["angles"];
	thread anim_first_frame_on_guy(param_00,param_01,var_04,var_05,"generic");
}

//Function Number: 5
anim_generic(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = param_00;
	anim_single(var_03,param_01,param_02,0,"generic");
}

//Function Number: 6
anim_generic_gravity(param_00,param_01,param_02)
{
	var_03 = param_00.allowpain;
	param_00 maps\_utility::disable_pain();
	anim_generic_custom_animmode(param_00,"gravity",param_01,param_02);
	if(var_03)
	{
		param_00 maps\_utility::enable_pain();
	}
}

//Function Number: 7
anim_generic_run(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = param_00;
	anim_single(var_03,param_01,param_02,0.25,"generic");
}

//Function Number: 8
anim_generic_reach(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = param_00;
	anim_reach(var_03,param_01,param_02,"generic");
}

//Function Number: 9
anim_generic_reach_and_arrive(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = param_00;
	anim_reach_with_funcs(var_03,param_01,param_02,"generic",::reach_with_arrivals_begin,::reach_with_standard_adjustments_end);
}

//Function Number: 10
anim_reach_and_plant(param_00,param_01,param_02)
{
	anim_reach_with_funcs(param_00,param_01,param_02,undefined,::reach_with_planting,::reach_with_standard_adjustments_end);
}

//Function Number: 11
anim_reach_and_plant_and_arrive(param_00,param_01,param_02)
{
	anim_reach_with_funcs(param_00,param_01,param_02,undefined,::reach_with_planting_and_arrivals,::reach_with_standard_adjustments_end);
}

//Function Number: 12
anim_generic_loop(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_04["guy"] = param_00;
	var_04["entity"] = self;
	var_04["tag"] = param_03;
	var_05[0] = var_04;
	anim_loop_packet(var_05,param_01,param_02,"generic");
}

//Function Number: 13
anim_custom_animmode(param_00,param_01,param_02,param_03)
{
	var_04 = get_anim_position(param_03);
	var_05 = var_04["origin"];
	var_06 = var_04["angles"];
	var_07 = undefined;
	foreach(var_09 in param_00)
	{
		var_07 = var_09;
		thread anim_custom_animmode_on_guy(var_09,param_01,param_02,var_05,var_06,var_09.animname,0);
	}

	var_07 wait_until_anim_finishes(param_02);
	self notify(param_02);
}

//Function Number: 14
anim_custom_animmode_loop(param_00,param_01,param_02,param_03)
{
	var_04 = get_anim_position(param_03);
	var_05 = var_04["origin"];
	var_06 = var_04["angles"];
	foreach(var_08 in param_00)
	{
		thread anim_custom_animmode_on_guy(var_08,param_01,param_02,var_05,var_06,var_08.animname,1);
	}

	param_00[0] wait_until_anim_finishes(param_02);
	self notify(param_02);
}

//Function Number: 15
wait_until_anim_finishes(param_00)
{
	self endon("finished_custom_animmode" + param_00);
	self waittill("death");
}

//Function Number: 16
anim_generic_custom_animmode(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = get_anim_position(param_03);
	var_07 = var_06["origin"];
	var_08 = var_06["angles"];
	thread anim_custom_animmode_on_guy(param_00,param_01,param_02,var_07,var_08,"generic",0,param_04,param_05);
	param_00 wait_until_anim_finishes(param_02);
	self notify(param_02);
}

//Function Number: 17
anim_generic_custom_animmode_loop(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = get_anim_position(param_03);
	var_07 = var_06["origin"];
	var_08 = var_06["angles"];
	thread anim_custom_animmode_on_guy(param_00,param_01,param_02,var_07,var_08,"generic",1,param_04,param_05);
	param_00 wait_until_anim_finishes(param_02);
	self notify(param_02);
}

//Function Number: 18
anim_custom_animmode_solo(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_04[0] = param_00;
	anim_custom_animmode(var_04,param_01,param_02,param_03);
}

//Function Number: 19
anim_custom_animmode_loop_solo(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_04[0] = param_00;
	anim_custom_animmode_loop(var_04,param_01,param_02,param_03);
}

//Function Number: 20
anim_first_frame_solo(param_00,param_01,param_02,param_03)
{
	var_04 = get_anim_position(param_02);
	var_05 = var_04["origin"];
	var_06 = var_04["angles"];
	thread anim_first_frame_on_guy(param_00,param_01,var_05,var_06,param_03);
}

//Function Number: 21
anim_last_frame_solo(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = param_00;
	anim_first_frame(var_03,param_01,param_02);
	anim_set_time(var_03,param_01,1);
}

//Function Number: 22
assert_existance_of_anim(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = self.animname;
	}

	var_02 = 0;
	if(isdefined(level.scr_anim[param_01]))
	{
		var_02 = 1;
		if(isdefined(level.scr_anim[param_01][param_00]))
		{
			return;
		}
	}

	var_03 = 0;
	if(isdefined(level.scr_sound[param_01]))
	{
		var_03 = 1;
		if(isdefined(level.scr_sound[param_01][param_00]))
		{
			return;
		}
	}

	if(var_02 || var_03)
	{
		if(var_02)
		{
			var_04 = getarraykeys(level.scr_anim[param_01]);
			foreach(var_06 in var_04)
			{
			}
		}

		if(var_03)
		{
			var_04 = getarraykeys(level.scr_sound[param_01]);
			foreach(var_06 in var_04)
			{
			}
		}

		return;
	}

	var_0A = getarraykeys(level.scr_anim);
	var_0A = common_scripts\utility::array_combine(var_0A,getarraykeys(level.scr_sound));
	foreach(var_0C in var_0A)
	{
	}
}

//Function Number: 23
anim_first_frame_on_guy(param_00,param_01,param_02,param_03,param_04)
{
	param_00.first_frame_time = gettime();
	if(isdefined(param_04))
	{
		var_05 = param_04;
	}
	else
	{
		var_05 = param_01.animname;
	}

	param_00 set_start_pos(param_01,param_02,param_03,var_05);
	if(isai(param_00))
	{
		param_00._first_frame_anim = param_01;
		param_00._animname = var_05;
		param_00 animcustom(::animscripts\first_frame::main);
		return;
	}

	param_00 stopanimscripted();
	param_00 setanimknob(level.scr_anim[var_05][param_01],1,0,0);
	param_00 setanimtime(level.scr_anim[var_05][param_01],0);
}

//Function Number: 24
anim_custom_animmode_on_guy(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isai(param_00) && param_00 maps\_utility::doinglongdeath())
	{
		return;
	}

	var_09 = undefined;
	if(isdefined(param_05))
	{
		var_09 = param_05;
	}
	else
	{
		var_09 = param_00.animname;
	}

	if(!isdefined(param_08) || !param_08)
	{
		param_00 set_start_pos(param_02,param_03,param_04,param_05,param_06);
	}

	param_00._animmode = param_01;
	param_00._custom_anim = param_02;
	param_00._tag_entity = self;
	param_00._anime = param_02;
	param_00._animname = var_09;
	param_00._custom_anim_loop = param_06;
	param_00._custom_anim_thread = param_07;
	param_00 animcustom(::animscripts\animmode::main);
}

//Function Number: 25
anim_loop(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	foreach(var_07 in param_00)
	{
		var_08 = [];
		var_08["guy"] = var_07;
		var_08["entity"] = self;
		var_08["tag"] = param_03;
		var_08["origin_offset"] = param_04;
		var_05[var_05.size] = var_08;
	}

	anim_loop_packet(var_05,param_01,param_02);
}

//Function Number: 26
anim_loop_packet_solo(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = param_00;
	anim_loop_packet(var_03,param_01,param_02);
}

//Function Number: 27
anim_loop_packet(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00.size <= 0)
	{
		return;
	}

	foreach(var_05 in param_00)
	{
		var_06 = var_05["guy"];
		if(!isdefined(var_06))
		{
			continue;
		}

		if(!isdefined(var_06._animactive))
		{
			var_06._animactive = 0;
		}

		var_06 endon("death");
		var_06._animactive++;
	}

	var_08 = param_00[0]["guy"];
	if(!isdefined(param_02))
	{
		param_02 = "stop_loop";
	}

	thread endonremoveanimactive(param_02,param_00);
	self endon(param_02);
	var_09 = "looping anim";
	var_0A = undefined;
	if(isdefined(param_03))
	{
		var_0A = param_03;
	}
	else
	{
		var_0A = var_08.animname;
	}

	if(!assert_existance_of_looping_anim(param_01,var_0A))
	{
		return;
	}

	var_0B = 0;
	var_0C = 0;
	for(;;)
	{
		for(var_0B = anim_weight(var_0A,param_01);var_0B == var_0C && var_0B != 0;var_0B = anim_weight(var_0A,param_01))
		{
		}

		var_0C = var_0B;
		var_0D = undefined;
		var_0E = 999999;
		var_0F = undefined;
		var_06 = undefined;
		foreach(var_22, var_05 in param_00)
		{
			var_11 = var_05["entity"];
			var_06 = var_05["guy"];
			var_12 = var_11 get_anim_position(var_05["tag"]);
			var_13 = var_12["origin"];
			var_14 = var_12["angles"];
			if(isdefined(var_05["origin_offset"]))
			{
				var_15 = var_05["origin_offset"];
				var_16 = anglestoforward(var_14);
				var_17 = anglestoright(var_14);
				var_18 = anglestoup(var_14);
				var_13 = var_13 + var_16 * var_15[0];
				var_13 = var_13 + var_17 * var_15[1];
				var_13 = var_13 + var_18 * var_15[2];
			}

			if(isdefined(var_06.remove_from_animloop))
			{
				var_06.remove_from_animloop = undefined;
				param_00[var_22] = undefined;
				continue;
			}

			var_19 = 0;
			var_1A = 0;
			var_1B = 0;
			var_1C = 0;
			var_1D = undefined;
			var_1E = undefined;
			var_1F = undefined;
			if(isdefined(param_03))
			{
				var_1F = param_03;
			}
			else
			{
				var_1F = var_06.animname;
			}

			if(isdefined(level.scr_face[var_1F]) && isdefined(level.scr_face[var_1F][param_01]) && isdefined(level.scr_face[var_1F][param_01][var_0B]))
			{
				var_19 = 1;
				var_1D = level.scr_face[var_1F][param_01][var_0B];
			}

			if(isdefined(level.scr_sound[var_1F]) && isdefined(level.scr_sound[var_1F][param_01]) && isdefined(level.scr_sound[var_1F][param_01][var_0B]))
			{
				var_1A = 1;
				var_1E = level.scr_sound[var_1F][param_01][var_0B];
			}

			if(isdefined(level.scr_animsound[var_1F]) && isdefined(level.scr_animsound[var_1F][var_0B + param_01]))
			{
				var_06 playsound(level.scr_animsound[var_1F][var_0B + param_01]);
			}

			if(isdefined(level.scr_anim[var_1F]) && isdefined(level.scr_anim[var_1F][param_01]) && !isai(var_06) || !var_06 maps\_utility::doinglongdeath())
			{
				var_1B = 1;
			}

			if(var_1B)
			{
				if(isdefined(level.scr_goaltime[var_1F]) && isdefined(level.scr_goaltime[var_1F][param_01]))
				{
					var_20 = level.scr_goaltime[var_1F][param_01];
				}
				else
				{
					var_20 = 0.2;
				}

				var_06 last_anim_time_check(param_01,var_1F);
				var_06 animscripted(var_09,var_13,var_14,level.scr_anim[var_1F][param_01][var_0B],undefined,undefined,var_20);
				var_21 = getanimlength(level.scr_anim[var_1F][param_01][var_0B]);
				if(var_21 < var_0E)
				{
					var_0E = var_21;
					var_0D = var_22;
				}

				thread start_notetrack_wait(var_06,var_09,param_01,var_1F,level.scr_anim[var_1F][param_01][var_0B]);
				thread animscriptdonotetracksthread(var_06,var_09,param_01);
			}

			if(var_19 || var_1A)
			{
				if(isai(var_06))
				{
					if(var_1B)
					{
						var_06 animscripts\face::sayspecificdialogue(var_1D,var_1E,1);
					}
					else
					{
						var_06 animscripts\face::sayspecificdialogue(var_1D,var_1E,1,var_09);
					}
				}
				else
				{
					var_06 maps\_utility::play_sound_on_entity(var_1E);
				}

				var_0F = var_22;
			}
		}

		if(!isdefined(var_06))
		{
			break;
		}

		if(isdefined(var_0D))
		{
			param_00[var_0D]["guy"] waittillmatch("end",var_09);
			waittillframeend;
			continue;
		}

		if(isdefined(var_0F))
		{
			param_00[var_0F]["guy"] waittill(var_09);
			continue;
		}
	}
}

//Function Number: 28
start_notetrack_wait(param_00,param_01,param_02,param_03,param_04)
{
	param_00 notify("stop_sequencing_notetracks");
	thread notetrack_wait(param_00,param_01,self,param_02,param_03,param_04);
}

//Function Number: 29
anim_single_failsafeonguy(param_00,param_01)
{
}

//Function Number: 30
anim_single_failsafe(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		var_03 thread anim_single_failsafeonguy(self,param_01);
	}
}

//Function Number: 31
anim_single(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	anim_single_internal(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 32
anim_single_run(param_00,param_01,param_02,param_03)
{
	anim_single_internal(param_00,param_01,param_02,0.25,param_03);
}

//Function Number: 33
anim_single_internal(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self;
	foreach(var_08 in param_00)
	{
		if(!isdefined(var_08))
		{
			continue;
		}

		if(!isdefined(var_08._animactive))
		{
			var_08._animactive = 0;
		}

		var_08._animactive++;
	}

	var_0A = get_anim_position(param_02);
	var_0B = var_0A["origin"];
	var_0C = var_0A["angles"];
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_0D = undefined;
	var_0E = 999999;
	if(param_05)
	{
		var_0E = 0;
	}

	var_0F = undefined;
	var_10 = undefined;
	var_11 = undefined;
	var_12 = "single anim";
	foreach(var_1F, var_08 in param_00)
	{
		var_14 = 0;
		var_15 = 0;
		var_16 = 0;
		var_17 = 0;
		var_18 = undefined;
		var_19 = undefined;
		var_1A = undefined;
		if(isdefined(param_04))
		{
			var_1A = param_04;
		}
		else
		{
			var_1A = var_08.animname;
		}

		if(isdefined(level.scr_face[var_1A]) && isdefined(level.scr_face[var_1A][param_01]))
		{
			var_14 = 1;
			var_19 = level.scr_face[var_1A][param_01];
			var_11 = var_19;
		}

		if(isdefined(level.scr_sound[var_1A]) && isdefined(level.scr_sound[var_1A][param_01]))
		{
			var_15 = 1;
			var_18 = level.scr_sound[var_1A][param_01];
		}

		if(isdefined(level.scr_anim[var_1A]) && isdefined(level.scr_anim[var_1A][param_01]) && !isai(var_08) || !var_08 maps\_utility::doinglongdeath())
		{
			var_16 = 1;
		}

		if(isdefined(level.scr_animsound[var_1A]) && isdefined(level.scr_animsound[var_1A][param_01]))
		{
			var_08 playsound(level.scr_animsound[var_1A][param_01]);
		}

		if(var_16)
		{
			if(isdefined(level.scr_goaltime[var_1A]) && isdefined(level.scr_goaltime[var_1A][param_01]))
			{
				var_1B = level.scr_goaltime[var_1A][param_01];
			}
			else
			{
				var_1B = 0.2;
			}

			var_08 last_anim_time_check(param_01,var_1A);
			if(isplayer(var_08))
			{
				var_1C = level.scr_anim[var_1A]["root"];
				var_08 setanim(var_1C,0,var_1B);
				var_1D = level.scr_anim[var_1A][param_01];
				var_08 setflaggedanim(var_12,var_1D,1,var_1B);
			}
			else if(var_08.code_classname == "misc_turret")
			{
				var_1D = level.scr_anim[var_1A][param_01];
				var_08 setflaggedanim(var_12,var_1D,1,var_1B);
			}
			else
			{
				var_08 animscripted(var_12,var_0B,var_0C,level.scr_anim[var_1A][param_01],undefined,undefined,var_1B);
			}

			var_1E = getanimlength(level.scr_anim[var_1A][param_01]);
			if((var_1E < var_0E && !param_05) || var_1E > var_0E && param_05)
			{
				var_0E = var_1E;
				var_0D = var_1F;
			}

			thread start_notetrack_wait(var_08,var_12,param_01,var_1A,level.scr_anim[var_1A][param_01]);
			thread animscriptdonotetracksthread(var_08,var_12,param_01);
		}

		if(var_14 || var_15)
		{
			if(var_14)
			{
				if(var_15)
				{
					var_08 thread delayeddialogue(param_01,var_14,var_18,level.scr_face[var_1A][param_01]);
				}

				thread anim_facialanim(var_08,param_01,level.scr_face[var_1A][param_01]);
				var_10 = var_1F;
			}
			else if(isai(var_08))
			{
				if(var_16)
				{
					var_08 animscripts\face::sayspecificdialogue(var_19,var_18,1);
				}
				else
				{
					if(!isdefined(var_08.disablefacialfilleranims) || !var_08.disablefacialfilleranims)
					{
						var_08 thread anim_facialfiller("single dialogue");
					}

					var_08 animscripts\face::sayspecificdialogue(var_19,var_18,1,"single dialogue");
				}
			}
			else
			{
				var_08 thread maps\_utility::play_sound_on_entity(var_18,"single dialogue");
				if(var_08 hasanimtree())
				{
					var_08 thread anim_facialfiller("single dialogue");
				}
			}

			var_0F = var_1F;
		}
	}

	if(isdefined(var_0D))
	{
		var_20 = spawnstruct();
		var_20 thread anim_deathnotify(param_00[var_0D],param_01);
		var_20 thread anim_animationendnotify(param_00[var_0D],param_01,var_0E,param_03);
		var_20 waittill(param_01);
	}
	else if(isdefined(var_10))
	{
		var_20 = spawnstruct();
		var_20 thread anim_deathnotify(param_00[var_10],param_01);
		var_20 thread anim_facialendnotify(param_00[var_10],param_01,var_11);
		var_20 waittill(param_01);
	}
	else if(isdefined(var_0F))
	{
		var_20 = spawnstruct();
		var_20 thread anim_deathnotify(param_00[var_0F],param_01);
		var_20 thread anim_dialogueendnotify(param_00[var_0F],param_01);
		var_20 waittill(param_01);
	}

	foreach(var_08 in param_00)
	{
		if(!isdefined(var_08))
		{
			continue;
		}

		if(isplayer(var_08))
		{
			var_1A = undefined;
			if(isdefined(param_04))
			{
				var_1A = param_04;
			}
			else
			{
				var_1A = var_08.animname;
			}

			if(isdefined(level.scr_anim[var_1A][param_01]))
			{
				var_1C = level.scr_anim[var_1A]["root"];
				var_08 setanim(var_1C,1,0.2);
				var_1D = level.scr_anim[var_1A][param_01];
				var_08 clearanim(var_1D,0.2);
			}
		}

		var_08._animactive--;
		var_08._lastanimtime = gettime();
	}

	self notify(param_01);
}

//Function Number: 34
anim_deathnotify(param_00,param_01)
{
	self endon(param_01);
	param_00 waittill("death");
	if(isdefined(param_00.anim_is_death) && param_00.anim_is_death)
	{
		return;
	}

	self notify(param_01);
}

//Function Number: 35
anim_facialendnotify(param_00,param_01,param_02)
{
	self endon(param_01);
	var_03 = getanimlength(param_02);
	wait(var_03);
	self notify(param_01);
}

//Function Number: 36
anim_dialogueendnotify(param_00,param_01)
{
	self endon(param_01);
	param_00 waittill("single dialogue");
	self notify(param_01);
}

//Function Number: 37
anim_animationendnotify(param_00,param_01,param_02,param_03)
{
	self endon(param_01);
	param_00 endon("death");
	param_02 = param_02 - param_03;
	if(param_03 > 0 && param_02 > 0)
	{
		param_00 maps\_utility::waittill_match_or_timeout("single anim","end",param_02);
		param_00 stopanimscripted();
	}
	else
	{
		param_00 waittillmatch("end","single anim");
	}

	self notify(param_01);
}

//Function Number: 38
animscriptdonotetracksthread(param_00,param_01,param_02)
{
	if(isdefined(param_00.dontdonotetracks) && param_00.dontdonotetracks)
	{
		return;
	}

	param_00 endon("stop_sequencing_notetracks");
	param_00 endon("death");
	param_00 animscripts\shared::donotetracks(param_01,undefined,undefined,1);
}

//Function Number: 39
add_animsound(param_00)
{
	for(var_01 = 0;var_01 < level.animsound_hudlimit;var_01++)
	{
		if(isdefined(self.animsounds[var_01]))
		{
			continue;
		}

		self.animsounds[var_01] = param_00;
		return;
	}

	var_02 = getarraykeys(self.animsounds);
	var_03 = var_02[0];
	var_04 = self.animsounds[var_03].end_time;
	for(var_01 = 1;var_01 < var_02.size;var_01++)
	{
		var_05 = var_02[var_01];
		if(self.animsounds[var_05].end_time < var_04)
		{
			var_04 = self.animsounds[var_05].end_time;
			var_03 = var_05;
		}
	}

	self.animsounds[var_03] = param_00;
}

//Function Number: 40
animsound_exists(param_00,param_01)
{
	param_01 = tolower(param_01);
	var_02 = getarraykeys(self.animsounds);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(self.animsounds[var_04].anime != param_00)
		{
			continue;
		}

		if(self.animsounds[var_04].notetrack != param_01)
		{
			continue;
		}

		self.animsounds[var_04].end_time = gettime() + 60000;
		return 1;
	}

	return 0;
}

//Function Number: 41
animsound_tracker(param_00,param_01,param_02)
{
	param_01 = tolower(param_01);
	add_to_animsound();
	if(param_01 == "end")
	{
		return;
	}

	if(animsound_exists(param_00,param_01))
	{
		return;
	}

	var_03 = spawnstruct();
	var_03.anime = param_00;
	var_03.notetrack = param_01;
	var_03.animname = param_02;
	var_03.end_time = gettime() + 60000;
	add_animsound(var_03);
}

//Function Number: 42
animsound_start_tracker(param_00,param_01)
{
	add_to_animsound();
	var_02 = spawnstruct();
	var_02.anime = param_00;
	var_02.notetrack = "#" + param_00;
	var_02.animname = param_01;
	var_02.end_time = gettime() + 60000;
	if(animsound_exists(param_00,var_02.notetrack))
	{
		return;
	}

	add_animsound(var_02);
}

//Function Number: 43
animsound_start_tracker_loop(param_00,param_01,param_02)
{
	add_to_animsound();
	param_00 = param_01 + param_00;
	var_03 = spawnstruct();
	var_03.anime = param_00;
	var_03.notetrack = "#" + param_00;
	var_03.animname = param_02;
	var_03.end_time = gettime() + 60000;
	if(animsound_exists(param_00,var_03.notetrack))
	{
		return;
	}

	add_animsound(var_03);
}

//Function Number: 44
notetrack_wait(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 endon("stop_sequencing_notetracks");
	param_00 endon("death");
	if(isdefined(param_02))
	{
		var_06 = param_02;
	}
	else
	{
		var_06 = self;
	}

	var_07 = undefined;
	if(isdefined(param_04))
	{
		var_07 = param_04;
	}
	else
	{
		var_07 = param_00.animname;
	}

	var_08 = spawnstruct();
	var_08.dialog = [];
	var_09 = [];
	if(isdefined(var_07) && isdefined(level.scr_notetrack[var_07]))
	{
		if(isdefined(level.scr_notetrack[var_07][param_03]))
		{
			var_09[param_03] = level.scr_notetrack[var_07][param_03];
		}

		if(isdefined(level.scr_notetrack[var_07]["any"]))
		{
			var_09["any"] = level.scr_notetrack[var_07]["any"];
		}
	}

	foreach(var_12, var_0B in var_09)
	{
		foreach(var_0D in level.scr_notetrack[var_07][var_12])
		{
			foreach(var_0F in var_0D)
			{
				if(isdefined(var_0F["dialog"]))
				{
					var_08.dialog[var_0F["dialog"]] = 1;
				}
			}
		}
	}

	var_16 = 0;
	var_17 = 0;
	var_08.dialoguenotetrack = 0;
	var_14 = undefined;
	if(!var_16 && isdefined(var_07) && isdefined(param_03))
	{
		var_16 = 1;
		var_18 = undefined;
		var_17 = isdefined(level.scr_notetrack[var_07]) && isdefined(level.scr_notetrack[var_07][param_03]) && isdefined(level.scr_notetrack[var_07][param_03]["start"]);
		if(!var_17)
		{
			continue;
		}

		var_14 = "start";
	}
	else
	{
		param_00 waittill(param_01,var_14);
	}

	if(var_14 == "end")
	{
		return;
	}

	foreach(var_12, var_0B in var_09)
	{
		if(isdefined(level.scr_notetrack[var_07][var_12][var_14]))
		{
			foreach(var_0F in level.scr_notetrack[var_07][var_12][var_14])
			{
				anim_handle_notetrack(var_0F,param_00,var_08,var_06);
			}
		}
	}

	var_1C = getsubstr(var_14,0,3);
	if(var_1C == "ps_")
	{
		var_1D = getsubstr(var_14,3);
		if(isdefined(param_00.anim_playsound_func))
		{
			param_00 thread [[ param_00.anim_playsound_func ]](var_1D,"j_head",1);
		}
		else
		{
			param_00 thread maps\_utility::play_sound_on_tag(var_1D,undefined,1);
		}

		continue;
	}

	if(var_1C == "vo_")
	{
		var_1D = getsubstr(var_14,3);
		if(isdefined(param_00.anim_playsound_func))
		{
			param_00 thread [[ param_00.anim_playsound_func ]](var_1D,"j_head",1);
		}
		else
		{
			param_00 thread maps\_utility::play_sound_on_tag(var_1D,"j_head",1);
		}

		continue;
	}

	if(var_1C == "sd_")
	{
		var_1D = getsubstr(var_14,3);
		param_00 thread maps\_utility::smart_dialogue(var_1D);
		continue;
	}

	if(var_1C == "fx_")
	{
		var_1E = strtok(tolower(getsubstr(var_14,3)),",() ");
		if(var_1E.size == 2)
		{
			if(var_1E[0] == "exploder")
			{
				common_scripts\_exploder::exploder(var_1E[1]);
				continue;
			}
			else if(var_1E[0] == "stop_exploder")
			{
				maps\_utility::stop_exploder(var_1E[1]);
				continue;
			}
			else
			{
				playfxontag(level._effect[var_1E[0]],param_00,var_1E[1]);
				continue;
			}
		}
		else if(var_1E.size == 3)
		{
			if(var_1E[0] == "playfxontag")
			{
				playfxontag(level._effect[var_1E[1]],param_00,var_1E[2]);
				continue;
			}
			else if(var_1E[0] == "stopfxontag")
			{
				stopfxontag(level._effect[var_1E[1]],param_00,var_1E[2]);
				continue;
			}
			else if(var_1E[0] == "killfxontag")
			{
				killfxontag(level._effect[var_1E[1]],param_00,var_1E[2]);
				continue;
			}
		}
		else if(var_1E.size == 11)
		{
			var_1F = (float(var_1E[2]),float(var_1E[3]),float(var_1E[4]));
			var_20 = (float(var_1E[5]),float(var_1E[6]),float(var_1E[7]));
			var_21 = (float(var_1E[8]),float(var_1E[9]),float(var_1E[10]));
			playfx(level._effect[var_1E[1]],var_1F,var_20,var_21);
		}
	}

	var_1C = getsubstr(var_14,0,4);
	if(var_1C == "psr_")
	{
		var_1D = getsubstr(var_14,4);
		maps\_utility::radio_dialogue(var_1D);
		continue;
	}

	switch(var_14)
	{
		case "ignoreall true":
			break;

		case "ignoreall false":
			break;

		case "ignoreme true":
			break;

		case "ignoreme false":
			break;

		case "allowdeath true":
			break;

		case "allowdeath false":
			break;
	}
}

//Function Number: 45
anim_handle_notetrack(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00["function"]))
	{
		if(!isdefined(param_00["function_args"]))
		{
			self thread [[ param_00["function"] ]](param_01);
		}
		else
		{
			self thread [[ param_00["function"] ]](param_01,param_00["function_args"]);
		}
	}

	if(isdefined(param_00["flag"]))
	{
		common_scripts\utility::flag_set(param_00["flag"]);
	}

	if(isdefined(param_00["flag_clear"]))
	{
		common_scripts\utility::flag_clear(param_00["flag_clear"]);
	}

	if(isdefined(param_00["notify"]))
	{
		level notify(param_00["notify"]);
	}

	if(isdefined(param_00["attach gun left"]))
	{
		param_01 gun_pickup_left();
		return;
	}

	if(isdefined(param_00["attach gun right"]))
	{
		param_01 gun_pickup_right();
		return;
	}

	if(isdefined(param_00["detach gun"]))
	{
		param_01 gun_leave_behind(param_00);
		return;
	}

	if(isdefined(param_00["attach model"]))
	{
		if(isdefined(param_00["selftag"]))
		{
			param_01 attach(param_00["attach model"],param_00["selftag"]);
		}
		else
		{
			param_03 attach(param_00["attach model"],param_00["tag"]);
		}

		return;
	}

	if(isdefined(param_00["detach model"]))
	{
		waittillframeend;
		if(isdefined(param_00["selftag"]))
		{
			param_01 detach(param_00["detach model"],param_00["selftag"]);
		}
		else
		{
			param_03 detach(param_00["detach model"],param_00["tag"]);
		}
	}

	if(isdefined(param_00["sound"]))
	{
		var_04 = undefined;
		if(!isdefined(param_00["sound_stays_death"]))
		{
			var_04 = 1;
		}

		var_05 = undefined;
		if(isdefined(param_00["sound_on_tag"]))
		{
			var_05 = param_00["sound_on_tag"];
		}

		param_01 thread maps\_utility::play_sound_on_tag(param_00["sound"],var_05,var_04);
	}

	if(isdefined(param_00["playersound"]))
	{
		level.player playsound(param_00["playersound"]);
	}

	if(!param_02.dialoguenotetrack)
	{
		if(isdefined(param_00["dialog"]) && isdefined(param_02.dialog[param_00["dialog"]]))
		{
			param_01 animscripts\face::sayspecificdialogue(undefined,param_00["dialog"],1);
			param_02.dialog[param_00["dialog"]] = undefined;
			param_02.dialoguenotetrack = 1;
		}
	}

	if(isdefined(param_00["create model"]))
	{
		anim_addmodel(param_01,param_00);
	}
	else if(isdefined(param_00["delete model"]))
	{
		anim_removemodel(param_01,param_00);
	}

	if(isdefined(param_00["selftag"]))
	{
		if(isdefined(param_00["effect"]))
		{
			var_06 = isdefined(param_00["moreThanThreeHack"]);
			if(var_06)
			{
				common_scripts\utility::lock("moreThanThreeHack");
			}

			playfxontag(level._effect[param_00["effect"]],param_01,param_00["selftag"]);
			if(var_06)
			{
				common_scripts\utility::unlock("moreThanThreeHack");
			}
		}

		if(isdefined(param_00["stop_effect"]))
		{
			stopfxontag(level._effect[param_00["stop_effect"]],param_01,param_00["selftag"]);
		}

		if(isdefined(param_00["swap_part_to_efx"]))
		{
			playfxontag(level._effect[param_00["swap_part_to_efx"]],param_01,param_00["selftag"]);
			param_01 hidepart(param_00["selftag"]);
		}

		if(isdefined(param_00["trace_part_for_efx"]))
		{
			var_07 = undefined;
			var_08 = common_scripts\utility::getfx(param_00["trace_part_for_efx"]);
			if(isdefined(param_00["trace_part_for_efx_water"]))
			{
				var_07 = common_scripts\utility::getfx(param_00["trace_part_for_efx_water"]);
			}

			var_09 = 0;
			if(isdefined(param_00["trace_part_for_efx_delete_depth"]))
			{
				var_09 = param_00["trace_part_for_efx_delete_depth"];
			}

			param_01 thread trace_part_for_efx(param_00["selftag"],var_08,var_07,var_09);
		}

		if(isdefined(param_00["trace_part_for_efx_canceling"]))
		{
			param_01 thread trace_part_for_efx_cancel(param_00["selftag"]);
		}
	}

	if(isdefined(param_00["tag"]) && isdefined(param_00["effect"]))
	{
		playfxontag(level._effect[param_00["effect"]],param_03,param_00["tag"]);
	}

	if(isdefined(param_00["selftag"]) && isdefined(param_00["effect_looped"]))
	{
		playfxontag(level._effect[param_00["effect_looped"]],param_01,param_00["selftag"]);
	}

	if(isdefined(param_00["lui_notify"]))
	{
		luinotifyevent(param_00["lui_notify"],0);
	}

	if(isdefined(param_00["omnvar"]))
	{
		setomnvar(param_00["omnvar"],param_00["value"]);
	}
}

//Function Number: 46
trace_part_for_efx_cancel(param_00)
{
	self notify("cancel_trace_for_part_" + param_00);
}

//Function Number: 47
trace_part_for_efx(param_00,param_01,param_02,param_03)
{
	var_04 = "trace_part_for_efx";
	self endon("cancel_trace_for_part_" + param_00);
	var_05 = self gettagorigin(param_00);
	var_06 = 0;
	var_07 = spawnstruct();
	var_07.last_pos = self gettagorigin(param_00);
	var_07.hit_surface = 0;
	var_07.part = param_00;
	var_07.hit_water = 0;
	var_07.effect = param_01;
	var_07.stationary = 0;
	var_07.last_motion_time = gettime();
	while(isdefined(self) && !var_07.hit_surface)
	{
		common_scripts\utility::lock(var_04);
		test_trace_tag(var_07);
		common_scripts\utility::unlock_wait(var_04);
		if(var_07.stationary == 1 && gettime() - var_07.last_motion_time > 3000)
		{
			return;
		}
	}

	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(param_02) && var_07.hit_water)
	{
		param_01 = param_02;
	}

	playfx(param_01,var_07.last_pos);
	if(param_03 == 0)
	{
		self hidepart(param_00);
		return;
	}

	thread hidepartatdepth(var_07.last_pos[2] - param_03,param_00);
}

//Function Number: 48
hidepartatdepth(param_00,param_01)
{
	self endon("entitydeleted");
	while(self gettagorigin(param_01)[2] > param_00)
	{
		wait(0.05);
	}

	self hidepart(param_01);
}

//Function Number: 49
test_trace_tag(param_00)
{
	var_01 = undefined;
	if(!isdefined(self))
	{
		return;
	}

	param_00.current_pos = self gettagorigin(param_00.part);
	if(param_00.current_pos != param_00.last_pos)
	{
		param_00.last_motion_time = gettime();
		param_00.stationary = 0;
		if(!bullettracepassed(param_00.last_pos,param_00.current_pos,0,self))
		{
			var_02 = bullettrace(param_00.last_pos,param_00.current_pos,0,self);
			if(var_02["fraction"] < 1)
			{
				param_00.last_pos = var_02["position"];
				param_00.hit_water = var_02["surfacetype"] == "water";
				param_00.hit_surface = 1;
				return;
			}
			else
			{
			}
		}
	}
	else
	{
		param_00.stationary = 1;
	}

	param_00.last_pos = param_00.current_pos;
}

//Function Number: 50
anim_addmodel(param_00,param_01)
{
	if(!isdefined(param_00.scriptmodel))
	{
		param_00.scriptmodel = [];
	}

	var_02 = param_00.scriptmodel.size;
	param_00.scriptmodel[var_02] = spawn("script_model",(0,0,0));
	param_00.scriptmodel[var_02] setmodel(param_01["create model"]);
	param_00.scriptmodel[var_02].origin = param_00 gettagorigin(param_01["selftag"]);
	param_00.scriptmodel[var_02].angles = param_00 gettagangles(param_01["selftag"]);
}

//Function Number: 51
anim_removemodel(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.scriptmodel.size;var_02++)
	{
		if(isdefined(param_01["explosion"]))
		{
			var_03 = anglestoforward(param_00.scriptmodel[var_02].angles);
			var_03 = var_03 * 120;
			var_03 = var_03 + param_00.scriptmodel[var_02].origin;
			playfx(level._effect[param_01["explosion"]],param_00.scriptmodel[var_02].origin);
			radiusdamage(param_00.scriptmodel[var_02].origin,350,700,50);
		}

		param_00.scriptmodel[var_02] delete();
	}
}

//Function Number: 52
gun_pickup_left()
{
	if(!isdefined(self.gun_on_ground))
	{
		return;
	}

	self.gun_on_ground delete();
	self.dropweapon = 1;
	animscripts\shared::placeweaponon(self.weapon,"left");
}

//Function Number: 53
gun_pickup_right()
{
	if(!isdefined(self.gun_on_ground))
	{
		return;
	}

	self.gun_on_ground delete();
	self.dropweapon = 1;
	animscripts\shared::placeweaponon(self.weapon,"right");
}

//Function Number: 54
gun_leave_behind(param_00)
{
	if(isdefined(self.gun_on_ground))
	{
		return;
	}

	var_01 = self gettagorigin(param_00["tag"]);
	var_02 = self gettagangles(param_00["tag"]);
	var_03 = 0;
	if(isdefined(param_00["suspend"]))
	{
		var_03 = param_00["suspend"];
	}

	var_04 = spawn("weapon_" + self.weapon,var_01,var_03);
	var_04.angles = var_02;
	self.gun_on_ground = var_04;
	animscripts\shared::placeweaponon(self.weapon,"none");
	self.dropweapon = 0;
}

//Function Number: 55
assert_existance_of_looping_anim(param_00,param_01)
{
	if(!isdefined(level.scr_anim[param_01][param_00]))
	{
		return 0;
	}

	if(!isarray(level.scr_anim[param_01][param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 56
anim_weight(param_00,param_01)
{
	var_02 = level.scr_anim[param_00][param_01].size;
	var_03 = randomint(var_02);
	if(var_02 > 1)
	{
		var_04 = 0;
		var_05 = 0;
		for(var_06 = 0;var_06 < var_02;var_06++)
		{
			if(isdefined(level.scr_anim[param_00][param_01 + "weight"]))
			{
				if(isdefined(level.scr_anim[param_00][param_01 + "weight"][var_06]))
				{
					var_04++;
					var_05 = var_05 + level.scr_anim[param_00][param_01 + "weight"][var_06];
				}
			}
		}

		if(var_04 == var_02)
		{
			var_07 = randomfloat(var_05);
			var_05 = 0;
			for(var_06 = 0;var_06 < var_02;var_06++)
			{
				var_05 = var_05 + level.scr_anim[param_00][param_01 + "weight"][var_06];
				if(var_07 < var_05)
				{
					var_03 = var_06;
					break;
				}
			}
		}
	}

	return var_03;
}

//Function Number: 57
anim_reach_and_idle(param_00,param_01,param_02,param_03,param_04)
{
	thread anim_reach(param_00,param_01,param_04);
	var_05 = spawnstruct();
	var_05.reachers = 0;
	foreach(var_07 in param_00)
	{
		var_05.reachers++;
		thread idle_on_reach(var_07,param_02,param_03,param_04,var_05);
	}

	for(;;)
	{
		var_05 waittill("reached_position");
		if(var_05.reachers <= 0)
		{
			return;
		}
	}
}

//Function Number: 58
wait_for_guy_to_die_or_get_in_position()
{
	self endon("death");
	self waittill("anim_reach_complete");
}

//Function Number: 59
idle_on_reach(param_00,param_01,param_02,param_03,param_04)
{
	param_00 wait_for_guy_to_die_or_get_in_position();
	param_04.reachers--;
	param_04 notify("reached_position");
	if(isalive(param_00))
	{
		anim_loop_solo(param_00,param_01,param_02,param_03);
	}
}

//Function Number: 60
get_anim_position(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	if(isdefined(param_00))
	{
		var_01 = self gettagorigin(param_00);
		var_02 = self gettagangles(param_00);
	}
	else
	{
		var_01 = self.origin;
		var_02 = self.angles;
		if(!isdefined(var_02))
		{
			var_02 = (0,0,0);
		}
	}

	var_03 = [];
	var_03["angles"] = var_02;
	var_03["origin"] = var_01;
	return var_03;
}

//Function Number: 61
anim_reach_together(param_00,param_01,param_02,param_03)
{
	thread modify_moveplaybackrate_together(param_00);
	anim_reach_with_funcs(param_00,param_01,param_02,param_03,::reach_with_standard_adjustments_begin,::reach_with_standard_adjustments_end);
}

//Function Number: 62
modify_moveplaybackrate_together(param_00)
{
	var_01 = 0.3;
	waittillframeend;
	for(;;)
	{
		param_00 = maps\_utility::remove_dead_from_array(param_00);
		var_02 = [];
		var_03 = 0;
		foreach(var_08, var_05 in param_00)
		{
			var_06 = var_05.goalpos;
			if(isdefined(var_05.reach_goal_pos))
			{
				var_06 = var_05.reach_goal_pos;
			}

			var_07 = distance(var_05.origin,var_06);
			var_02[var_05.unique_id] = var_07;
			if(var_07 <= 4)
			{
				param_00[var_08] = undefined;
				continue;
			}

			var_03 = var_03 + var_07;
		}

		if(param_00.size <= 1)
		{
			break;
		}

		var_03 = var_03 / param_00.size;
		foreach(var_05 in param_00)
		{
			var_0A = var_02[var_05.unique_id] - var_03;
			var_0B = var_0A * 0.003;
			if(var_0B > var_01)
			{
				var_0B = var_01;
			}
			else if(var_0B < var_01 * -1)
			{
				var_0B = var_01 * -1;
			}

			var_05.moveplaybackrate = 1 + var_0B;
		}

		wait(0.05);
	}

	foreach(var_05 in param_00)
	{
		if(isalive(var_05))
		{
			var_05.moveplaybackrate = 1;
		}
	}
}

//Function Number: 63
anim_reach_failsafe(param_00,param_01)
{
	if(isarray(param_00))
	{
		foreach(var_03 in param_00)
		{
			thread anim_reach_failsafe(var_03,param_01);
		}

		return;
	}

	var_03 = var_03;
	var_04 endon("new_anim_reach");
	wait(var_03);
	var_04 notify("goal");
}

//Function Number: 64
anim_reach(param_00,param_01,param_02,param_03,param_04)
{
	return anim_reach_with_funcs(param_00,param_01,param_02,param_03,::reach_with_standard_adjustments_begin,::reach_with_standard_adjustments_end,undefined,param_04);
}

//Function Number: 65
anim_reach_with_funcs(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = get_anim_position(param_02);
	var_09 = var_08["origin"];
	var_0A = var_08["angles"];
	if(isdefined(param_06))
	{
		self.type = param_06;
		self.arrivalstance = "stand";
	}

	var_0B = spawnstruct();
	var_0C = 0;
	var_0D = 0;
	foreach(var_0F in param_00)
	{
		if(isdefined(param_06))
		{
			var_0F.scriptedarrivalent = self;
		}

		if(isdefined(param_03))
		{
			var_10 = param_03;
		}
		else
		{
			var_10 = var_0F.animname;
		}

		if(isdefined(level.scr_anim[var_10][param_01]))
		{
			if(isarray(level.scr_anim[var_10][param_01]))
			{
				var_11 = getstartorigin(var_09,var_0A,level.scr_anim[var_10][param_01][0]);
			}
			else
			{
				var_11 = getstartorigin(var_09,var_0A,level.scr_anim[var_10][param_01]);
			}
		}
		else
		{
			var_11 = var_09;
		}

		var_0D++;
		var_0F thread begin_anim_reach(var_0B,var_11,param_04,param_05,param_01,param_07);
	}

	var_13 = 1;
	var_0B thread monitor_reach_thread_death(thisthread,param_00,self,param_06);
	while(var_0D)
	{
		var_0B waittill("reach_notify",var_0F,var_14);
		if(isdefined(var_0F))
		{
			var_0F.anim_reach_success = var_14;
		}

		if(!var_14)
		{
			var_13 = 0;
		}

		var_0D--;
	}

	anim_reach_cleanup(param_00,self,param_06);
	var_0B notify("end_reach_thread_monitor");
	return var_13;
}

//Function Number: 66
anim_reach_cleanup(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		if(isalive(var_04) && var_04.anim_reach_success)
		{
			var_04.goalradius = var_04.oldgoalradius;
			var_04.scriptedarrivalent = undefined;
			var_04.stopanimdistsq = 0;
		}

		if(isdefined(var_04))
		{
			var_04.anim_reach_success = undefined;
		}
	}

	if(isdefined(param_02))
	{
		param_01.type = undefined;
	}
}

//Function Number: 67
monitor_reach_thread_death(param_00,param_01,param_02,param_03)
{
	self endon("end_reach_thread_monitor");
	while(isdefined(param_00))
	{
		wait 0.05;
	}

	foreach(var_05 in param_01)
	{
		if(isdefined(var_05))
		{
			var_05.anim_reach_success = 1;
			var_05.reach_aborted = 1;
			var_05 notify("goal");
			if(isdefined(var_05.name))
			{
			}
			else
			{
			}

			continue;
		}
	}

	anim_reach_cleanup(param_01,param_02,param_03);
}

//Function Number: 68
anim_reach_cleanup_solo(param_00)
{
	if(!isalive(param_00))
	{
		return;
	}

	if(isdefined(param_00.oldgoalradius))
	{
		param_00.goalradius = param_00.oldgoalradius;
	}

	param_00.scriptedarrivalent = undefined;
	param_00.stopanimdistsq = 0;
}

//Function Number: 69
anim_teleport(param_00,param_01,param_02)
{
	var_03 = get_anim_position(param_02);
	var_04 = var_03["origin"];
	var_05 = var_03["angles"];
	foreach(var_07 in param_00)
	{
		var_08 = getstartorigin(var_04,var_05,level.scr_anim[var_07.animname][param_01]);
		var_09 = getstartangles(var_04,var_05,level.scr_anim[var_07.animname][param_01]);
		if(isai(var_07))
		{
			var_07 teleport(var_08);
			continue;
		}

		var_07.origin = var_08;
		var_07.angles = var_09;
	}
}

//Function Number: 70
anim_moveto(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = get_anim_position(param_02);
	var_07 = var_06["origin"];
	var_08 = var_06["angles"];
	foreach(var_0A in param_00)
	{
		var_0B = getstartorigin(var_07,var_08,level.scr_anim[var_0A.animname][param_01]);
		var_0C = getstartangles(var_07,var_08,level.scr_anim[var_0A.animname][param_01]);
		if(isai(var_0A))
		{
			continue;
		}

		var_0A moveto(var_0B,param_03,param_04,param_05);
		var_0A rotateto(var_0C,param_03,param_04,param_05);
	}
}

//Function Number: 71
anim_generic_teleport(param_00,param_01,param_02)
{
	var_03 = get_anim_position(param_02);
	var_04 = var_03["origin"];
	var_05 = var_03["angles"];
	var_06 = getstartorigin(var_04,var_05,level.scr_anim["generic"][param_01]);
	var_07 = getstartangles(var_04,var_05,level.scr_anim["generic"][param_01]);
	if(isai(param_00))
	{
		param_00 teleport(var_06);
		return;
	}

	param_00.origin = var_06;
	param_00.angles = var_07;
}

//Function Number: 72
anim_spawn_generic_model(param_00,param_01,param_02)
{
	return anim_spawn_model(param_00,"generic",param_01,param_02);
}

//Function Number: 73
anim_spawn_model(param_00,param_01,param_02,param_03)
{
	var_04 = get_anim_position(param_03);
	var_05 = var_04["origin"];
	var_06 = var_04["angles"];
	var_07 = getstartorigin(var_05,var_06,level.scr_anim[param_01][param_02]);
	var_08 = getstartorigin(var_05,var_06,level.scr_anim[param_01][param_02]);
	var_09 = spawn("script_model",var_07);
	var_09 setmodel(param_00);
	var_09.angles = var_08;
	return var_09;
}

//Function Number: 74
anim_spawn_tag_model(param_00,param_01)
{
	self attach(param_00,param_01);
}

//Function Number: 75
anim_link_tag_model(param_00,param_01)
{
	var_02 = self gettagorigin(param_01);
	var_03 = spawn("script_model",var_02);
	var_03 setmodel(param_00);
	var_03 linkto(self,param_01,(0,0,0),(0,0,0));
	return var_03;
}

//Function Number: 76
anim_spawner_teleport(param_00,param_01,param_02)
{
	var_03 = get_anim_position(param_02);
	var_04 = var_03["origin"];
	var_05 = var_03["angles"];
	var_06 = spawnstruct();
	foreach(var_08 in param_00)
	{
		var_09 = getstartorigin(var_04,var_05,level.scr_anim[var_08.animname][param_01]);
		var_08.origin = var_09;
	}
}

//Function Number: 77
reach_death_notify(param_00,param_01)
{
	common_scripts\utility::waittill_either("death","goal");
	var_02 = isalive(self) && distancesquared(self.origin,param_01) <= 2500;
	param_00 notify("reach_notify",self,var_02);
}

//Function Number: 78
begin_anim_reach(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	self endon("new_anim_reach");
	param_01 = [[ param_02 ]](param_01);
	thread reach_death_notify(param_00,param_01);
	maps\_utility::set_goal_pos(param_01);
	self.reach_goal_pos = param_01;
	self.goalradius = 0;
	self waittill("goal");
	if(isdefined(self.reach_aborted))
	{
		self.reach_aborted = undefined;
	}

	self notify("anim_reach_complete");
	[[ param_03 ]]();
	self notify("new_anim_reach");
}

//Function Number: 79
reach_with_standard_adjustments_begin(param_00)
{
	if(isdefined(self.currently_anim_reaching))
	{
	}

	self.oldgoalradius = self.goalradius;
	self.oldpathenemyfightdist = self.pathenemyfightdist;
	self.oldpathenemylookahead = self.pathenemylookahead;
	self.pathenemyfightdist = 128;
	self.pathenemylookahead = 128;
	self.oldscriptforcecolor = isdefined(self.script_forcecolor);
	if(!isdefined(self.perforing_color_driven_anim))
	{
		maps\_utility::disable_ai_color();
	}

	anim_changes_pushplayer(1);
	self.fixednodewason = self.fixednode;
	self.fixednode = 0;
	if(!isdefined(self.scriptedarrivalent))
	{
		self.old_disablearrivals = self.disablearrivals;
		self.disablearrivals = 1;
	}

	self.reach_goal_pos = undefined;
	self.currently_anim_reaching = 1;
	return param_00;
}

//Function Number: 80
reach_with_standard_adjustments_end()
{
	anim_changes_pushplayer(0);
	self.fixednode = self.fixednodewason;
	self.fixednodewason = undefined;
	self.pathenemyfightdist = self.oldpathenemyfightdist;
	self.pathenemylookahead = self.oldpathenemylookahead;
	self.disablearrivals = self.old_disablearrivals;
	if(self.oldscriptforcecolor)
	{
		if(!isdefined(self.perforing_color_driven_anim))
		{
			maps\_utility::enable_ai_color_dontmove();
		}

		self.oldscriptforcecolor = undefined;
	}

	self.currently_anim_reaching = undefined;
}

//Function Number: 81
anim_changes_pushplayer(param_00)
{
	if(isdefined(self.dontchangepushplayer))
	{
		return;
	}

	self pushplayer(param_00);
}

//Function Number: 82
reach_with_arrivals_begin(param_00)
{
	param_00 = reach_with_standard_adjustments_begin(param_00);
	self.disablearrivals = 0;
	return param_00;
}

//Function Number: 83
reach_with_planting(param_00)
{
	var_01 = self getdroptofloorposition(param_00);
	param_00 = var_01;
	param_00 = reach_with_standard_adjustments_begin(param_00);
	self.disablearrivals = 1;
	return param_00;
}

//Function Number: 84
reach_with_planting_and_arrivals(param_00)
{
	var_01 = self getdroptofloorposition(param_00);
	param_00 = var_01;
	param_00 = reach_with_standard_adjustments_begin(param_00);
	self.disablearrivals = 0;
	return param_00;
}

//Function Number: 85
setanimtree()
{
	self useanimtree(level.scr_animtree[self.animname]);
}

//Function Number: 86
anim_single_solo(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	var_05[0] = param_00;
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	anim_single(var_05,param_01,param_02,param_03,param_04);
}

//Function Number: 87
anim_single_solo_run(param_00,param_01,param_02)
{
	self endon("death");
	var_03[0] = param_00;
	anim_single(var_03,param_01,param_02,0.25);
}

//Function Number: 88
anim_single_run_solo(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04[0] = param_00;
	anim_single(var_04,param_01,param_02,0.25);
}

//Function Number: 89
anim_reach_and_idle_solo(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	var_05[0] = param_00;
	anim_reach_and_idle(var_05,param_01,param_02,param_03,param_04);
}

//Function Number: 90
anim_reach_solo(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04[0] = param_00;
	return anim_reach(var_04,param_01,param_02,undefined,param_03);
}

//Function Number: 91
anim_reach_and_approach_solo(param_00,param_01,param_02,param_03)
{
	self endon("death");
	var_04[0] = param_00;
	anim_reach_and_approach(var_04,param_01,param_02,param_03);
}

//Function Number: 92
anim_reach_and_approach_node_solo(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	var_05[0] = param_00;
	var_06 = get_anim_position(param_02);
	var_07 = var_06["origin"];
	var_08 = var_06["angles"];
	var_09 = param_00.animname;
	if(isdefined(level.scr_anim[var_09][param_01]))
	{
		if(isarray(level.scr_anim[var_09][param_01]))
		{
			var_0A = level.scr_anim[var_09][param_01][0];
		}
		else
		{
			var_0A = level.scr_anim[var_0A][param_02];
		}

		var_07 = getstartorigin(var_07,var_08,var_0A);
		var_08 = getstartorigin(var_07,var_08,var_0A);
	}

	var_0B = spawn("script_origin",var_07);
	var_0B.angles = var_08;
	if(isdefined(param_03))
	{
		var_0B.type = param_03;
	}
	else
	{
		var_0B.type = self.type;
	}

	if(isdefined(param_04))
	{
		var_0B.arrivalstance = param_04;
	}
	else
	{
		var_0B.arrivalstance = self gethighestnodestance();
	}

	param_00.scriptedarrivalent = var_0B;
	anim_reach_and_approach(var_05,param_01,param_02);
	param_00.scriptedarrivalent = undefined;
	var_0B delete();
	while(param_00.a.movement != "stop")
	{
		wait(0.05);
	}
}

//Function Number: 93
anim_reach_and_approach(param_00,param_01,param_02,param_03)
{
	self endon("death");
	anim_reach_with_funcs(param_00,param_01,param_02,undefined,::reach_with_arrivals_begin,::reach_with_standard_adjustments_end,param_03);
}

//Function Number: 94
anim_loop_solo(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	param_00 endon("death");
	var_06 = [];
	var_06["guy"] = param_00;
	var_06["entity"] = self;
	var_06["tag"] = param_03;
	var_06["origin_offset"] = param_05;
	var_07[0] = var_06;
	anim_loop_packet(var_07,param_01,param_02,param_04);
}

//Function Number: 95
anim_teleport_solo(param_00,param_01,param_02)
{
	self endon("death");
	var_03[0] = param_00;
	anim_teleport(var_03,param_01,param_02);
}

//Function Number: 96
add_animation(param_00,param_01)
{
	if(!isdefined(level.completedanims))
	{
		level.completedanims[param_00][0] = param_01;
		return;
	}

	if(!isdefined(level.completedanims[param_00]))
	{
		level.completedanims[param_00][0] = param_01;
		return;
	}

	for(var_02 = 0;var_02 < level.completedanims[param_00].size;var_02++)
	{
		if(level.completedanims[param_00][var_02] == param_01)
		{
			return;
		}
	}

	level.completedanims[param_00][level.completedanims[param_00].size] = param_01;
}

//Function Number: 97
anim_single_queue(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(isdefined(param_00.last_queue_time))
	{
		maps\_utility::wait_for_buffer_time_to_pass(param_00.last_queue_time,0.5);
	}

	maps\_utility::function_stack(::anim_single_solo,param_00,param_01,param_02,param_03);
	if(isalive(param_00))
	{
		param_00.last_queue_time = gettime();
	}
}

//Function Number: 98
anim_generic_queue(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(isdefined(param_00.last_queue_time))
	{
		maps\_utility::wait_for_buffer_time_to_pass(param_00.last_queue_time,0.5);
	}

	if(isdefined(param_04))
	{
		maps\_utility::function_stack_timeout(param_04,::anim_single_solo,param_00,param_01,param_02,param_03,"generic");
	}
	else
	{
		maps\_utility::function_stack(::anim_single_solo,param_00,param_01,param_02,param_03,"generic");
	}

	if(isalive(param_00))
	{
		param_00.last_queue_time = gettime();
	}
}

//Function Number: 99
anim_dontpushplayer(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 pushplayer(0);
	}
}

//Function Number: 100
anim_pushplayer(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02 pushplayer(1);
	}
}

//Function Number: 101
removenotetrack(param_00,param_01,param_02,param_03,param_04)
{
	param_01 = tolower(param_01);
	var_05 = level.scr_notetrack[param_00][param_02][param_01];
	param_02 = get_generic_anime(param_02);
	var_06 = -1;
	if(!isdefined(var_05) || !isarray(var_05) || var_05.size < 1)
	{
		return;
	}

	for(var_07 = 0;var_07 < var_05.size;var_07++)
	{
		if(isdefined(var_05[var_07][param_03]))
		{
			if(!isdefined(param_04) || var_05[var_07][param_03] == param_04)
			{
				var_06 = var_07;
				break;
			}
		}
	}

	if(var_06 < 0)
	{
		return;
	}

	if(var_05.size == 1)
	{
		var_05 = [];
	}
	else
	{
		var_05 = maps\_utility::array_remove_index(var_05,var_06);
	}

	level.scr_notetrack[param_00][param_02][param_01] = var_05;
}

//Function Number: 102
addnotetrack_dialogue(param_00,param_01,param_02,param_03)
{
	param_01 = tolower(param_01);
	param_02 = get_generic_anime(param_02);
	var_04 = add_notetrack_and_get_index(param_00,param_01,param_02);
	level.scr_notetrack[param_00][param_02][param_01][var_04] = [];
	level.scr_notetrack[param_00][param_02][param_01][var_04]["dialog"] = param_03;
}

//Function Number: 103
add_notetrack_and_get_index(param_00,param_01,param_02)
{
	param_01 = tolower(param_01);
	add_notetrack_array(param_00,param_01,param_02);
	return level.scr_notetrack[param_00][param_02][param_01].size;
}

//Function Number: 104
add_notetrack_array(param_00,param_01,param_02)
{
	param_01 = tolower(param_01);
	if(!isdefined(level.scr_notetrack))
	{
		level.scr_notetrack = [];
	}

	if(!isdefined(level.scr_notetrack[param_00]))
	{
		level.scr_notetrack[param_00] = [];
	}

	if(!isdefined(level.scr_notetrack[param_00][param_02]))
	{
		level.scr_notetrack[param_00][param_02] = [];
	}

	if(!isdefined(level.scr_notetrack[param_00][param_02][param_01]))
	{
		level.scr_notetrack[param_00][param_02][param_01] = [];
	}
}

//Function Number: 105
addnotetrack_sound(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_01 = tolower(param_01);
	param_02 = get_generic_anime(param_02);
	var_06 = add_notetrack_and_get_index(param_00,param_01,param_02);
	level.scr_notetrack[param_00][param_02][param_01][var_06] = [];
	level.scr_notetrack[param_00][param_02][param_01][var_06]["sound"] = param_03;
	if(isdefined(param_04))
	{
		level.scr_notetrack[param_00][param_02][param_01][var_06]["sound_stays_death"] = 1;
	}

	if(isdefined(param_05))
	{
		level.scr_notetrack[param_00][param_02][param_01][var_06]["sound_on_tag"] = param_05;
	}
}

//Function Number: 106
note_track_start_sound(param_00,param_01,param_02,param_03)
{
	var_04 = get_datascene();
	addnotetrack_sound(var_04.animname,param_00,var_04.anim_sequence,param_01,param_02,param_03);
}

//Function Number: 107
addnotetrack_playersound(param_00,param_01,param_02,param_03)
{
	param_01 = tolower(param_01);
	param_02 = get_generic_anime(param_02);
	var_04 = add_notetrack_and_get_index(param_00,param_01,param_02);
	level.scr_notetrack[param_00][param_02][param_01][var_04] = [];
	level.scr_notetrack[param_00][param_02][param_01][var_04]["playersound"] = param_03;
}

//Function Number: 108
get_generic_anime(param_00)
{
	if(!isdefined(param_00))
	{
		return "any";
	}

	return param_00;
}

//Function Number: 109
addonstart_animsound(param_00,param_01,param_02)
{
	if(!isdefined(level.scr_animsound[param_00]))
	{
		level.scr_animsound[param_00] = [];
	}

	level.scr_animsound[param_00][param_01] = param_02;
}

//Function Number: 110
addnotetrack_animsound(param_00,param_01,param_02,param_03)
{
	param_02 = tolower(param_02);
	param_01 = get_generic_anime(param_01);
	var_04 = add_notetrack_and_get_index(param_00,param_02,param_01);
	var_05 = [];
	var_05["sound"] = param_03;
	var_05["created_by_animSound"] = 1;
	level.scr_notetrack[param_00][param_01][param_02][var_04] = var_05;
}

//Function Number: 111
addnotetrack_attach(param_00,param_01,param_02,param_03,param_04)
{
	param_01 = tolower(param_01);
	param_04 = get_generic_anime(param_04);
	var_05 = add_notetrack_and_get_index(param_00,param_01,param_04);
	var_06 = [];
	var_06["attach model"] = param_02;
	var_06["selftag"] = param_03;
	level.scr_notetrack[param_00][param_04][param_01][var_05] = var_06;
}

//Function Number: 112
addnotetrack_detach(param_00,param_01,param_02,param_03,param_04)
{
	param_01 = tolower(param_01);
	param_04 = get_generic_anime(param_04);
	var_05 = add_notetrack_and_get_index(param_00,param_01,param_04);
	var_06 = [];
	var_06["detach model"] = param_02;
	var_06["selftag"] = param_03;
	level.scr_notetrack[param_00][param_04][param_01][var_05] = var_06;
}

//Function Number: 113
addnotetrack_detach_gun(param_00,param_01,param_02,param_03)
{
	param_01 = tolower(param_01);
	param_02 = get_generic_anime(param_02);
	var_04 = add_notetrack_and_get_index(param_00,param_01,param_02);
	var_05 = [];
	var_05["detach gun"] = 1;
	var_05["tag"] = "tag_weapon_right";
	if(isdefined(param_03))
	{
		var_05["suspend"] = param_03;
	}

	level.scr_notetrack[param_00][param_02][param_01][var_04] = var_05;
}

//Function Number: 114
addnotetrack_customfunction(param_00,param_01,param_02,param_03,param_04)
{
	param_01 = tolower(param_01);
	param_03 = get_generic_anime(param_03);
	var_05 = add_notetrack_and_get_index(param_00,param_01,param_03);
	var_06 = [];
	var_06["function"] = param_02;
	var_06["function_args"] = param_04;
	level.scr_notetrack[param_00][param_03][param_01][var_05] = var_06;
}

//Function Number: 115
addnotetrack_startfxontag(param_00,param_01,param_02,param_03,param_04,param_05)
{
	common_scripts\utility::getfx(param_03);
	param_01 = tolower(param_01);
	param_02 = get_generic_anime(param_02);
	var_06 = add_notetrack_and_get_index(param_00,param_01,param_02);
	var_07 = [];
	var_07["effect"] = param_03;
	var_07["selftag"] = param_04;
	if(isdefined(param_05))
	{
		var_07["moreThanThreeHack"] = param_05;
	}

	level.scr_notetrack[param_00][param_02][param_01][var_06] = var_07;
}

//Function Number: 116
addnotetrack_stopfxontag(param_00,param_01,param_02,param_03,param_04)
{
	common_scripts\utility::getfx(param_03);
	param_01 = tolower(param_01);
	param_02 = get_generic_anime(param_02);
	var_05 = add_notetrack_and_get_index(param_00,param_01,param_02);
	var_06 = [];
	var_06["stop_effect"] = param_03;
	var_06["selftag"] = param_04;
	level.scr_notetrack[param_00][param_02][param_01][var_05] = var_06;
}

//Function Number: 117
note_track_swap_to_efx(param_00,param_01,param_02)
{
	var_03 = get_datascene();
	common_scripts\utility::add_fx(param_01,param_01);
	addnotetrack_swapparttoefx(var_03.animname,param_00,var_03.animsequence,param_01,param_02);
}

//Function Number: 118
note_track_stop_efx_on_tag(param_00,param_01,param_02)
{
	var_03 = get_datascene();
	common_scripts\utility::add_fx(param_01,param_01);
	addnotetrack_stopfxontag(var_03.animname,param_00,var_03.animsequence,param_01,param_02);
}

//Function Number: 119
addnotetrack_swapparttoefx(param_00,param_01,param_02,param_03,param_04)
{
	common_scripts\utility::getfx(param_03);
	param_01 = tolower(param_01);
	param_02 = get_generic_anime(param_02);
	var_05 = add_notetrack_and_get_index(param_00,param_01,param_02);
	var_06 = [];
	var_06["swap_part_to_efx"] = param_03;
	var_06["selftag"] = param_04;
	level.scr_notetrack[param_00][param_02][param_01][var_05] = var_06;
}

//Function Number: 120
note_track_trace_to_efx(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = get_datascene();
	if(param_00 != "start" && !animhasnotetrack(var_06 maps\_utility::getanim(var_06.anim_sequence),param_00))
	{
		return;
	}

	common_scripts\utility::add_fx(param_03,param_03);
	if(isdefined(param_04))
	{
		common_scripts\utility::add_fx(param_04,param_04);
	}

	addnotetrack_tracepartforefx(var_06.animname,param_00,param_01,var_06.anim_sequence,param_02,param_03,param_04,param_05);
}

//Function Number: 121
note_track_start_fx_on_tag(param_00,param_01,param_02)
{
	var_03 = get_datascene();
	if(param_00 != "start" && !animhasnotetrack(var_03 maps\_utility::getanim(var_03.anim_sequence),param_00))
	{
		return;
	}

	common_scripts\utility::add_fx(param_02,param_02);
	addnotetrack_startfxontag(var_03.animname,param_00,var_03.anim_sequence,param_02,param_01,1);
}

//Function Number: 122
get_datascene()
{
	var_00 = level.current_anim_data_scene;
	return var_00;
}

//Function Number: 123
addnotetrack_tracepartforefx(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	common_scripts\utility::getfx(param_05);
	param_01 = tolower(param_01);
	param_03 = get_generic_anime(param_03);
	var_08 = add_notetrack_and_get_index(param_00,param_01,param_03);
	var_09 = [];
	var_09["trace_part_for_efx"] = param_05;
	var_09["trace_part_for_efx_water"] = param_06;
	var_09["trace_part_for_efx_cancel"] = param_02;
	var_09["trace_part_for_efx_delete_depth"] = param_07;
	var_09["selftag"] = param_04;
	level.scr_notetrack[param_00][param_03][param_01][var_08] = var_09;
	if(isdefined(param_02))
	{
		var_09 = [];
		var_09["trace_part_for_efx_canceling"] = param_02;
		var_09["selftag"] = param_04;
		var_08 = add_notetrack_and_get_index(param_00,param_02,param_03);
		level.scr_notetrack[param_00][param_03][param_02][var_08] = var_09;
	}
}

//Function Number: 124
addnotetrack_flag(param_00,param_01,param_02,param_03)
{
	param_01 = tolower(param_01);
	param_03 = get_generic_anime(param_03);
	var_04 = add_notetrack_and_get_index(param_00,param_01,param_03);
	var_05 = [];
	var_05["flag"] = param_02;
	level.scr_notetrack[param_00][param_03][param_01][var_04] = var_05;
	if(!isdefined(level.flag) || !isdefined(level.flag[param_02]))
	{
		common_scripts\utility::flag_init(param_02);
	}
}

//Function Number: 125
addnotetrack_flag_clear(param_00,param_01,param_02,param_03)
{
	param_01 = tolower(param_01);
	param_03 = get_generic_anime(param_03);
	var_04 = add_notetrack_and_get_index(param_00,param_01,param_03);
	var_05 = [];
	var_05["flag_clear"] = param_02;
	level.scr_notetrack[param_00][param_03][param_01][var_04] = var_05;
	if(!isdefined(level.flag) || !isdefined(level.flag[param_02]))
	{
		common_scripts\utility::flag_init(param_02);
	}
}

//Function Number: 126
addnotetrack_notify(param_00,param_01,param_02,param_03)
{
	param_01 = tolower(param_01);
	param_03 = get_generic_anime(param_03);
	var_04 = add_notetrack_and_get_index(param_00,param_01,param_03);
	var_05 = [];
	var_05["notify"] = param_02;
	level.scr_notetrack[param_00][param_03][param_01][var_04] = var_05;
}

//Function Number: 127
addnotetrack_lui_notify(param_00,param_01,param_02,param_03)
{
	param_01 = tolower(param_01);
	param_03 = get_generic_anime(param_03);
	var_04 = add_notetrack_and_get_index(param_00,param_01,param_03);
	var_05 = [];
	var_05["lui_notify"] = param_02;
	level.scr_notetrack[param_00][param_03][param_01][var_04] = var_05;
}

//Function Number: 128
addnotetrack_set_omnvar(param_00,param_01,param_02,param_03,param_04)
{
	param_01 = tolower(param_01);
	param_04 = get_generic_anime(param_04);
	var_05 = add_notetrack_and_get_index(param_00,param_01,param_04);
	var_06 = [];
	var_06["omnvar"] = param_02;
	var_06["value"] = param_03;
	level.scr_notetrack[param_00][param_04][param_01][var_05] = var_06;
}

//Function Number: 129
disabledefaultfacialanims(param_00)
{
	if(!isdefined(param_00) || param_00)
	{
		self.bdisabledefaultfacialanims = 1;
		self clearanim(%head,0.2);
		self.facialidx = undefined;
		return;
	}

	self.bdisabledefaultfacialanims = undefined;
}

//Function Number: 130
anim_facialanim(param_00,param_01,param_02)
{
	param_00 endon("death");
	self endon(param_01);
	var_03 = 0.05;
	param_00 notify("newLookTarget");
	waittillframeend;
	disabledefaultfacialanims();
	param_00 setanim(%scripted_talking,5,0.2);
	param_00 setflaggedanimknobrestart("face_done_" + param_01,param_02,1,0,1);
	thread force_face_anim_to_play(param_00,param_01,param_02);
	thread clearfaceanimonanimdone(param_00,"face_done_" + param_01,param_01);
}

//Function Number: 131
force_face_anim_to_play(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 endon("stop_loop");
	self endon(param_01);
	for(;;)
	{
		disabledefaultfacialanims();
		param_00 setanim(%scripted_talking,5,0.4);
		param_00 setflaggedanimknoblimited("face_done_" + param_01,param_02,1,0,1);
		wait(0.05);
	}
}

//Function Number: 132
anim_facialfiller(param_00,param_01)
{
	self endon("death");
	if(isai(self) && !isalive(self))
	{
		return;
	}

	var_02 = 0.05;
	self notify("newLookTarget");
	self endon("newLookTarget");
	waittillframeend;
	if(!isdefined(param_01) && isdefined(self.looktarget))
	{
		param_01 = self.looktarget;
	}

	if(self hasblendshapes())
	{
		var_03 = %generic_talker_blend;
	}
	else
	{
		var_04 = self gettagindex("jnt_lips_L");
		if(var_04 != -1)
		{
			var_03 = %generic_talker_bs;
		}
		else if(self isbadguy())
		{
			var_03 = %generic_talker_axis;
		}
		else
		{
			var_03 = %generic_talker_allies;
		}
	}

	self setanimknoblimitedrestart(var_03,1,0,1);
	self setanim(%scripted_talking,5,0.4);
	disabledefaultfacialanims();
	set_talker_until_msg(param_00,var_03);
	var_02 = 0.3;
	self clearanim(%scripted_talking,0.2);
	disabledefaultfacialanims(0);
}

//Function Number: 133
set_talker_until_msg(param_00,param_01)
{
	self endon(param_00);
	for(;;)
	{
		wait(0.2);
		self setanimknoblimited(param_01,1,0,1);
		self setanim(%scripted_talking,5,0.4);
		disabledefaultfacialanims();
	}
}

//Function Number: 134
talk_for_time(param_00)
{
	self endon("death");
	var_01 = %generic_talker_allies;
	if(self isbadguy())
	{
		var_01 = %generic_talker_axis;
	}

	self setanimknoblimitedrestart(var_01,1,0,1);
	self setanim(%scripted_talking,5,0.4);
	disabledefaultfacialanims();
	wait(param_00);
	var_02 = 0.3;
	self clearanim(%scripted_talking,0.2);
	disabledefaultfacialanims(0);
}

//Function Number: 135
getyawangles(param_00,param_01)
{
	var_02 = param_00[1] - param_01[1];
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 136
lookline(param_00,param_01)
{
	self notify("lookline");
	self endon("lookline");
	self endon(param_01);
	self endon("death");
	wait(0.05);
}

//Function Number: 137
anim_reach_idle(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.count = param_00.size;
	foreach(var_05 in param_00)
	{
		thread reachidle(var_05,param_01,param_02,var_03);
	}

	while(var_03.count)
	{
		var_03 waittill("reached_goal");
	}

	self notify("stopReachIdle");
}

//Function Number: 138
reachidle(param_00,param_01,param_02,param_03)
{
	anim_reach_solo(param_00,param_01);
	param_03.count--;
	param_03 notify("reached_goal");
	if(param_03.count > 0)
	{
		anim_loop_solo(param_00,param_02,"stopReachIdle");
	}
}

//Function Number: 139
delayeddialogue(param_00,param_01,param_02,param_03)
{
	if(animhasnotetrack(param_03,"dialog"))
	{
		self waittillmatch("dialog","face_done_" + param_00);
	}

	if(param_01)
	{
		animscripts\face::sayspecificdialogue(undefined,param_02,1);
		return;
	}

	animscripts\face::sayspecificdialogue(undefined,param_02,1,"single dialogue");
}

//Function Number: 140
clearfaceanimonanimdone(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 waittillmatch("end",param_01);
	var_03 = 0.3;
	param_00 clearanim(%scripted_talking,0.2);
	disabledefaultfacialanims(0);
}

//Function Number: 141
anim_start_pos(param_00,param_01,param_02)
{
	var_03 = get_anim_position(param_02);
	var_04 = var_03["origin"];
	var_05 = var_03["angles"];
	common_scripts\utility::array_thread(param_00,::set_start_pos,param_01,var_04,var_05);
}

//Function Number: 142
anim_start_pos_solo(param_00,param_01,param_02)
{
	var_03[0] = param_00;
	anim_start_pos(var_03,param_01,param_02);
}

//Function Number: 143
set_start_pos(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = undefined;
	if(isdefined(param_03))
	{
		var_05 = param_03;
	}
	else
	{
		var_05 = self.animname;
	}

	if(isdefined(param_04) && param_04)
	{
		var_06 = level.scr_anim[var_05][param_00][0];
	}
	else if(isarray(level.scr_anim[var_06][param_01]))
	{
		var_06 = common_scripts\utility::random(level.scr_anim[var_06][param_01]);
	}
	else
	{
		var_06 = level.scr_anim[var_06][param_01];
	}

	if(isai(self))
	{
		var_07 = getstartorigin(param_01,param_02,var_06);
		var_08 = getstartangles(param_01,param_02,var_06);
		if(isdefined(self.anim_start_at_groundpos))
		{
			var_07 = maps\_utility::groundpos(var_07);
		}

		self forceteleport(var_07,var_08);
		return;
	}

	if(self.code_classname == "script_vehicle")
	{
		self vehicle_teleport(getstartorigin(param_01,param_02,var_06),getstartangles(param_01,param_02,var_06));
		return;
	}

	self.origin = getstartorigin(param_01,param_02,var_06);
	self.angles = getstartangles(param_01,param_02,var_06);
}

//Function Number: 144
anim_at_self(param_00,param_01)
{
	var_02 = [];
	var_02["guy"] = self;
	var_02["entity"] = self;
	return var_02;
}

//Function Number: 145
anim_at_entity(param_00,param_01)
{
	var_02 = [];
	var_02["guy"] = self;
	var_02["entity"] = param_00;
	var_02["tag"] = param_01;
	return var_02;
}

//Function Number: 146
add_to_animsound()
{
	if(!isdefined(self.animsounds))
	{
		self.animsounds = [];
	}

	var_00 = 0;
	for(var_01 = 0;var_01 < level.animsounds.size;var_01++)
	{
		if(self == level.animsounds[var_01])
		{
			var_00 = 1;
			break;
		}
	}

	if(!var_00)
	{
		level.animsounds[level.animsounds.size] = self;
	}
}

//Function Number: 147
anim_set_rate_single(param_00,param_01,param_02)
{
	param_00 thread anim_set_rate_internal(param_01,param_02);
}

//Function Number: 148
anim_set_rate(param_00,param_01,param_02)
{
	common_scripts\utility::array_thread(param_00,::anim_set_rate_internal,param_01,param_02);
}

//Function Number: 149
anim_set_rate_internal(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(isdefined(param_02))
	{
		var_03 = param_02;
	}
	else
	{
		var_03 = self.animname;
	}

	var_04 = maps\_utility::getanim_from_animname(param_00,var_03);
	if(isarray(var_04))
	{
		var_04 = var_04[0];
	}

	self setflaggedanim("single anim",var_04,1,0,param_01);
}

//Function Number: 150
anim_set_time(param_00,param_01,param_02)
{
	common_scripts\utility::array_thread(param_00,::anim_self_set_time,param_01,param_02);
}

//Function Number: 151
anim_self_set_time(param_00,param_01)
{
	var_02 = maps\_utility::getanim(param_00);
	self setanimtime(var_02,param_01);
}

//Function Number: 152
last_anim_time_check(param_00,param_01)
{
	if(!isdefined(self.last_anim_time))
	{
		self.last_anim_time = gettime();
		return;
	}

	var_02 = gettime();
	if(self.last_anim_time == var_02)
	{
		self endon("death");
		wait(0.05);
	}

	self.last_anim_time = var_02;
}

//Function Number: 153
set_custom_move_start_transition(param_00,param_01)
{
	param_00.custommovetransition = ::animscripts\cover_arrival::custommovetransitionfunc;
	param_00.startmovetransitionanim = level.scr_anim[param_00.animname][param_01];
}

//Function Number: 154
create_anim_scene(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = "generic";
	}
	else
	{
		level.scr_animtree[param_03] = param_00;
	}

	var_05 = spawnstruct();
	var_05.animtree = param_00;
	var_05.model = param_04;
	if(isdefined(param_04))
	{
		level.scr_model[param_03] = param_04;
	}

	if(isdefined(param_02))
	{
		level.scr_anim[param_03][param_01] = param_02;
	}

	var_05.animname = param_03;
	var_05.anim_sequence = param_01;
	level.current_anim_data_scene = var_05;
}