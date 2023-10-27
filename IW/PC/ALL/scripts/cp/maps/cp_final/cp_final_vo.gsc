/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_final\cp_final_vo.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 1292 ms
 * Timestamp: 10/27/2023 12:05:43 AM
*******************************************************************/

//Function Number: 1
final_vo_init()
{
	level.var_DDBC = [];
	level.var_2001 = 0;
	level.elvira_playing = 0;
	level.var_D336 = 0;
	level.var_ABE9 = ::rave_vo_callouts;
	level.pap_vo_approve_func = ::is_vo_in_pap;
	level.get_alias_2d_func = ::scripts\cp\_vo::func_77ED;
	level.var_10815 = ::final_starting_vo;
	level thread rave_vo_callouts();
	level.var_5472 = [];
	level thread func_12E45();
	level waittill("activate_power");
}

//Function Number: 2
rave_vo_callouts(param_00)
{
	level.var_134DC["final_announcer_vo"] = ::func_2000;
	level.var_134DC["final_ww_vo"] = ::func_13E0C;
	level.var_134DC["zmb_powerup_vo"] = ::func_CE7E;
	level.var_134DC["zmb_afterlife_vo"] = ::func_18E9;
	level.var_134DC["rave_pap_vo"] = ::pap_vo_handler;
	level.var_134DC["rave_dialogue_vo"] = ::func_549B;
	level.var_134DC["final_backstory_vo"] = ::backstory_vo_handler;
}

//Function Number: 3
func_177A(param_00)
{
	level.var_DDBC[param_00] = func_7BFF(param_00);
}

//Function Number: 4
func_1779(param_00)
{
	self.var_DDBC[param_00] = func_7BFF(param_00);
}

//Function Number: 5
func_7BFF(param_00)
{
	if(!isdefined(level.var_134B4[param_00].var_4613))
	{
		return 0;
	}

	return level.var_134B4[param_00].var_4613;
}

//Function Number: 6
func_12E45()
{
	level endon("game_ended");
	for(;;)
	{
		foreach(var_02, var_01 in level.var_DDBC)
		{
			if(scripts\common\utility::istrue(level.var_DDBC[var_02]))
			{
				level.var_DDBC[var_02] = level.var_DDBC[var_02] - 1;
			}
		}

		wait(1);
	}
}

//Function Number: 7
func_12E22()
{
	self endon("disconnect");
	for(;;)
	{
		foreach(var_02, var_01 in self.var_DDBC)
		{
			if(scripts\common\utility::istrue(self.var_DDBC[var_02]))
			{
				self.var_DDBC[var_02] = self.var_DDBC[var_02] - 1;
			}
		}

		wait(1);
	}
}

//Function Number: 8
func_549B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!scripts\cp\_music_and_dialog::func_3837())
	{
		return;
	}

	var_08 = isdefined(level.var_134B4[param_00]);
	scripts\cp\_vo::func_F60C(1);
	var_09 = scripts\cp\_music_and_dialog::func_7DD2(param_00,var_08);
	level.var_540D = var_09;
	while(scripts\cp\_music_and_dialog::func_134DF())
	{
		wait(0.1);
	}

	level.dialogues_playing = 1;
	if(isdefined(level.masterpcinteraction))
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(level.masterpcinteraction);
	}

	if(isdefined(level.backstoryinteraction))
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(level.backstoryinteraction);
	}

	if(scripts\common\utility::istrue(param_07))
	{
		var_0A = self;
		var_0A play_special_vo_dialogue(var_09,var_08,param_03,param_05,param_06);
		scripts\common\utility::func_136F7();
	}
	else
	{
		foreach(var_13, var_0C in var_0A)
		{
			var_0D = 0;
			var_0E = undefined;
			if(var_08 && isdefined(level.var_134B4[var_0C].var_54AA))
			{
				var_0E = level.var_134B4[var_0C].var_54AA;
				var_0F = var_0E + var_0C;
			}
			else if(issubstr(var_0C,"ww_") || issubstr(var_0C,"ks_"))
			{
				var_0F = var_0C;
				var_0D = 1;
			}
			else
			{
				continue;
			}

			foreach(var_0A in level.players)
			{
				if((isdefined(var_0E) && var_0A.var_134FD == var_0E) || var_0D || getdvarint("scr_solo_dialogue",0) == 1)
				{
					var_11 = scripts\cp\_vo::func_4978(var_0F,param_03,param_05,param_06);
					var_0A scripts\cp\_vo::func_F60D(1);
					var_0A scripts\cp\_vo::func_F60B(var_11);
					var_0A scripts\cp\_vo::func_CE77(var_11);
					var_0A scripts\cp\_vo::func_C9B8(var_11);
					var_0A scripts\cp\_vo::func_12C63();
					break;
				}
			}

			scripts\common\utility::func_136F7();
		}
	}

	foreach(var_0A in level.players)
	{
		var_0A scripts\cp\_vo::func_F60D(0);
	}

	level.dialogues_playing = 0;
	if(isdefined(level.masterpcinteraction))
	{
		scripts\cp\_interaction::add_to_current_interaction_list(level.masterpcinteraction);
	}

	if(isdefined(level.backstoryinteraction))
	{
		scripts\cp\_interaction::add_to_current_interaction_list(level.backstoryinteraction);
	}

	scripts\cp\_vo::func_F60C(0);
}

//Function Number: 9
play_special_vo_dialogue(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 0;
	var_07 = "";
	while(var_06 < param_00.size)
	{
		var_08 = 1;
		var_09 = undefined;
		if(param_01 && isdefined(level.var_134B4[param_00[var_06]].var_54AA))
		{
			var_09 = level.var_134B4[param_00[var_06]].var_54AA;
			var_07 = var_09 + param_00[var_06];
		}
		else if(issubstr(param_00[var_06],"ks_"))
		{
			var_07 = param_00[var_06];
			var_08 = 1;
			if(isdefined(level.survivor))
			{
				if(isdefined(level.boat_survivor))
				{
					scripts\common\utility::play_sound_in_space(var_07,level.boat_survivor.origin,0,level.boat_survivor);
				}
				else
				{
					scripts\common\utility::play_sound_in_space(var_07,level.survivor.origin,0,level.survivor);
				}

				wait(scripts\cp\_vo::func_7C76(var_07));
			}
			else if(isdefined(level.boat_survivor))
			{
				scripts\common\utility::play_sound_in_space(var_07,level.boat_survivor.origin,0,level.boat_survivor);
				wait(scripts\cp\_vo::func_7C76(var_07));
			}
			else
			{
				var_0A = scripts\cp\_vo::func_4978(var_07,param_02,param_03,param_04,param_00[var_06]);
				scripts\cp\_vo::func_CE8B(var_0A,param_05);
			}

			var_06++;
			continue;
		}
		else
		{
			continue;
			scripts\common\utility::func_136F7();
		}

		if(((isdefined(var_09) && self.var_134FD == var_09) || var_08 || getdvarint("scr_solo_dialogue",0) == 1) && !issubstr(var_07,"ks_"))
		{
			var_0A = scripts\cp\_vo::func_4978(var_07,param_02,param_03,param_04,param_00[var_06]);
			scripts\cp\_vo::func_CE8B(var_0A);
			var_06++;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 10
pap_vo_handler(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!scripts\cp\_vo::func_FF12(param_00))
	{
		thread scripts\cp\_vo::func_CE8A(param_00,param_02,param_03,param_04,param_05,param_06,param_00);
		return;
	}

	var_07 = self.var_134FD + param_00;
	thread scripts\cp\_vo::func_CE8A(var_07,param_02,param_03,param_04,param_05,param_06,param_00);
}

//Function Number: 11
func_18E9(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!scripts\cp\_vo::func_FF12(param_00))
	{
		thread scripts\cp\_vo::func_CE8A(param_00,param_02,param_03,param_04,param_05,param_06,param_00);
		return;
	}

	var_07 = self.var_134FD + param_00;
	thread scripts\cp\_vo::func_CE8A(var_07,param_02,param_03,param_04,param_05,param_06,param_00);
}

//Function Number: 12
func_13E0C(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	level endon(param_00 + "_timed_out");
	level thread scripts\cp\_vo::func_11908(param_00,param_03);
	while(scripts\cp\_vo::func_9D13())
	{
		wait(0.1);
	}

	scripts\cp\_vo::func_F60C(1);
	while(scripts\cp\_music_and_dialog::func_134DF())
	{
		wait(0.1);
	}

	level notify(param_00 + "_about_to_play");
	foreach(var_08 in level.players)
	{
		if(!isdefined(var_08))
		{
			continue;
		}

		if(var_08 issplitscreenplayer() && !var_08 issplitscreenplayerprimary())
		{
			continue;
		}

		var_09 = scripts\cp\_vo::func_4978(param_00,param_03,param_05,param_06);
		var_08 thread scripts\cp\_vo::func_CE8B(var_09);
	}

	wait(scripts\cp\_vo::func_7C76(param_00));
	foreach(var_08 in level.players)
	{
		var_08 scripts\cp\_vo::func_F60D(0);
	}

	scripts\cp\_vo::func_F60C(0);
}

//Function Number: 13
func_2000(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	func_CC8F(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 14
is_vo_in_pap(param_00)
{
	if(isdefined(level.var_134B4[param_00].pap_approval))
	{
		if(level.var_134B4[param_00].pap_approval == 1)
		{
			return 0;
		}

		return 1;
	}

	return 1;
}

//Function Number: 15
func_CC8F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(scripts\cp\_vo::func_9D13())
	{
		wait(5);
		if(scripts\cp\_vo::func_9D13())
		{
			return;
		}
	}

	if(scripts\cp\_vo::func_9D14())
	{
		return;
	}

	level.var_2001 = 1;
	scripts\cp\_vo::func_F60C(1);
	if(isdefined(param_07))
	{
		param_00 = param_07 + param_00;
	}

	if(!soundexists(param_00))
	{
		wait(0.1);
		level.var_2001 = 0;
		return;
	}

	foreach(var_09 in level.players)
	{
		if(!isdefined(var_09))
		{
			continue;
		}

		if(var_09 issplitscreenplayer() && !var_09 issplitscreenplayerprimary())
		{
			continue;
		}
		else
		{
			var_0A = scripts\cp\_vo::func_4978(param_00,param_03,param_05,param_06);
			var_09 thread scripts\cp\_vo::func_CE8B(var_0A);
		}
	}

	wait(scripts\cp\_vo::func_7C76(param_00));
	foreach(var_09 in level.players)
	{
		var_09 scripts\cp\_vo::func_F60D(0);
	}

	scripts\cp\_vo::func_F60C(0);
	func_1094A(param_00);
	level.var_2001 = 0;
}

//Function Number: 16
func_1094A(param_00)
{
	if(param_00 == "dj_jingle_intro")
	{
		level notify("jukebox_start");
	}
}

//Function Number: 17
func_CE7E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	wait(0.5);
	if(level.script == "cp_town")
	{
		func_2000("el_" + param_00,"final_ww_vo","highest",60,0,0,1);
		if(randomint(100) > 50)
		{
			func_2000("ww_powerup_elvira","final_ww_vo","highest",60,0,0,1);
			wait(3);
		}
	}
	else
	{
		func_2000("ww_" + param_00,"final_ww_vo","highest",60,0,0,1);
	}

	param_00 = func_45EA(param_00);
	foreach(var_08 in level.players)
	{
		if(isdefined(var_08) && isalive(var_08))
		{
			var_08 thread scripts\cp\_vo::try_to_play_vo(param_00,"final_comment_vo");
		}
	}
}

//Function Number: 18
func_45EA(param_00)
{
	switch(param_00)
	{
		case "powerup_carpenter":
		case "powerup_maxammo":
		case "powerup_instakill":
		case "powerup_nuke":
		case "powerup_firesale":
			return param_00;

		case "powerup_doublemoney":
			return "powerup_2xmoney";

		case "powerup_infiniteammo":
			return "powerup_ammo";

		case "powerup_infinitegrenades":
			return "powerup_grenade";

		default:
			return param_00;
	}
}

//Function Number: 19
func_13D1F()
{
	level endon("game_ended");
	level scripts\common\utility::waittill_any_3("regular_wave_starting","event_wave_starting");
	if(scripts\common\utility::istrue(level.directors_cut_is_activated))
	{
		level thread scripts\cp\_vo::try_to_play_vo("ww_zmb_dc_intro","zmb_ww_vo","highest",30,0,0,1,100);
		return;
	}

	if(level.players.size > 1)
	{
		level thread scripts\cp\_vo::try_to_play_vo("ww_intro","final_ww_vo","highest",30,0,0,1,100);
		return;
	}

	if(level.players[0].var_134FD == "p5_")
	{
		if(randomint(100) > 50)
		{
			level.players[0] thread scripts\cp\_vo::try_to_play_vo("ww_intro_p5_solo","final_ww_vo","highest",30,0,0,1,100);
			return;
		}

		level.players[0] thread scripts\cp\_vo::try_to_play_vo("ww_intro" + level.players[0].vo_suffix,"final_ww_vo","highest",30,0,0,1,100);
		return;
	}

	level.players[0] thread scripts\cp\_vo::try_to_play_vo("ww_intro" + level.players[0].vo_suffix,"final_ww_vo","highest",30,0,0,1,100);
}

//Function Number: 20
power_nag()
{
	level endon("game_ended");
	level endon("found_power");
	var_00 = 0;
	for(;;)
	{
		level waittill("wave_start_sound_done");
		if(level.wave_num > 0 && level.wave_num % 3 == 0)
		{
			if(!var_00)
			{
				var_00 = 1;
				foreach(var_02 in level.players)
				{
					var_02 thread scripts\cp\_vo::func_1769("nag_find_pap","zmb_comment_vo",200,200,3,1);
				}
			}

			continue;
		}
	}
}

//Function Number: 21
purchase_area_vo(param_00,param_01)
{
	if(scripts\common\utility::istrue(level.var_C617))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.played_vo))
	{
		param_01.played_vo = 0;
		return;
	}

	param_01.played_vo = 1;
	if(randomint(100) < 50)
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area","final_comment_vo","highest",70,0,0,1);
	}

	param_01.played_vo = 1;
}

//Function Number: 22
final_starting_vo()
{
	scripts\common\utility::flag_wait("intro_gesture_done");
	if(scripts\cp\_music_and_dialog::func_3837())
	{
		var_00 = randomint(100);
		if(var_00 <= 30)
		{
			scripts\cp\_vo::try_to_play_vo_on_all_players("spawn_team_first");
			foreach(var_02 in level.players)
			{
				var_03 = scripts\cp\_vo::func_7C76(var_02.var_134FD + "spawn_team_first");
				wait(var_03);
			}

			level thread func_13D1F();
			return;
		}

		var_05 = scripts\common\utility::random(level.players);
		if(isdefined(var_05.var_134FD))
		{
			switch(var_05.var_134FD)
			{
				case "p1_":
					if(randomint(100) > 50)
					{
						level thread scripts\cp\_vo::try_to_play_vo("conv_spawn_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["conv_spawn_1_1"] = 1;
					}
					else
					{
						level thread scripts\cp\_vo::try_to_play_vo("conv_spawn_alt_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["conv_spawn_alt_1_1"] = 1;
					}
					break;

				case "p2_":
					if(randomint(100) > 50)
					{
						level thread scripts\cp\_vo::try_to_play_vo("conv_spawn_3_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["conv_spawn_3_1"] = 1;
					}
					else
					{
						level thread scripts\cp\_vo::try_to_play_vo("conv_spawn_alt_3_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["conv_spawn_alt_3_1"] = 1;
					}
					break;

				case "p3_":
					if(randomint(100) > 50)
					{
						level thread scripts\cp\_vo::try_to_play_vo("conv_spawn_alt_2_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["conv_spawn_alt_2_1"] = 1;
					}
					break;

				case "p4_":
					if(randomint(100) > 60)
					{
						level thread scripts\cp\_vo::try_to_play_vo("conv_spawn_2_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["conv_spawn_2_1"] = 1;
					}
					else
					{
						var_06 = randomint(100);
						if(var_06 <= 60 && var_06 > 30)
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_spawn_4_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_spawn_4_1"] = 1;
						}
						else
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_spawn_alt_4_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_spawn_alt_4_1"] = 1;
						}
					}
					break;

				default:
					break;
			}
		}

		level thread func_13D1F();
		return;
	}

	if(level.players.size > 1)
	{
		foreach(var_08 in level.players)
		{
			if(var_08 issplitscreenplayer())
			{
				if(var_08 issplitscreenplayerprimary())
				{
					if(isdefined(var_08.var_134FD))
					{
						if(var_08.var_134FD == "p5_")
						{
							var_08 multiple_elviras_intro_vo(var_08);
						}
						else
						{
							var_08 thread scripts\cp\_vo::try_to_play_vo("spawn_team_first","final_comment_vo","high",20,0,0,1);
						}
					}
				}

				continue;
			}

			if(isdefined(var_08.var_134FD))
			{
				if(var_08.var_134FD == "p5_")
				{
					var_08 multiple_elviras_intro_vo(var_08);
					continue;
				}

				var_08 thread scripts\cp\_vo::try_to_play_vo("spawn_team_first","final_comment_vo","high",20,0,0,1);
			}
		}

		foreach(var_0B in level.players)
		{
			var_03 = scripts\cp\_vo::func_7C76(var_0B.var_134FD + "spawn_team_first");
			wait(var_03);
		}

		level thread func_13D1F();
		return;
	}

	var_0D = scripts\common\utility::random(["spawn_intro","spawn_solo_first"]);
	level.players[0] thread scripts\cp\_vo::try_to_play_vo(var_0D,"final_comment_vo","high",20,0,0,1);
	var_03 = scripts\cp\_vo::func_7C76(level.players[0].var_134FD + var_0D);
	if(isdefined(var_03))
	{
		wait(var_03);
	}

	level thread func_13D1F();
}

//Function Number: 23
multiple_elviras_intro_vo(param_00)
{
	if(!isdefined(level.special_character_count))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	switch(level.special_character_count)
	{
		case 1:
			param_00 thread scripts\cp\_vo::try_to_play_vo("spawn_intro","final_comment_vo");
			break;

		case 2:
			param_00 thread scripts\cp\_vo::try_to_play_vo("p5_players_3","final_comment_vo");
			break;

		case 3:
			param_00 thread scripts\cp\_vo::try_to_play_vo("p5_players_3","final_comment_vo");
			break;

		case 4:
			param_00 thread scripts\cp\_vo::try_to_play_vo("p5_players_4","final_comment_vo");
			break;

		default:
			break;
	}
}

//Function Number: 24
can_play_backstory_vo()
{
	if(scripts\common\utility::istrue(level.started_backstory_dialogue))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(level.dialogues_playing))
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
clear_up_all_vo(param_00)
{
	foreach(var_02 in level.var_134FE)
	{
		if(isdefined(param_00.var_13516.var_134FF[var_02]) && param_00.var_13516.var_134FF[var_02].size > 0)
		{
			foreach(var_04 in param_00.var_13516.var_134FF[var_02])
			{
				if(isdefined(var_04))
				{
					param_00 stoplocalsound(var_04.var_1B46);
				}
			}
		}
	}

	var_07 = undefined;
	if(isdefined(param_00.var_13516))
	{
		if(isdefined(param_00.var_13516.var_134C6))
		{
			if(isdefined(param_00.var_13516.var_134C6.var_1B46))
			{
				var_07 = param_00.var_13516.var_134C6.var_1B46;
			}
		}
	}

	if(isdefined(var_07))
	{
		param_00 stoplocalsound(var_07);
	}
}

//Function Number: 26
backstory_vo_handler(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!can_play_backstory_vo())
	{
		return;
	}

	clear_up_all_vo(self);
	scripts\cp\_vo::func_C9CB([self]);
	self.started_backstory_dialogue = 1;
	if(isdefined(level.masterpcinteraction))
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(level.masterpcinteraction);
	}

	if(isdefined(level.backstoryinteraction))
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(level.backstoryinteraction);
	}

	var_07 = scripts\cp\_vo::func_4978(param_00,param_03,param_05,param_06);
	scripts\cp\_vo::func_F60D(1);
	scripts\cp\_vo::func_F60B(var_07);
	scripts\cp\_vo::func_CE77(var_07);
	scripts\cp\_vo::func_12C63();
	self.started_backstory_dialogue = 0;
	if(isdefined(self.samcrossvoarr))
	{
		self.samcrossvoarr = scripts\common\utility::func_22A9(self.samcrossvoarr,param_00);
	}

	if(isdefined(self.backstoryvoarr))
	{
		self.backstoryvoarr = scripts\common\utility::func_22A9(self.backstoryvoarr,param_00);
	}

	scripts\cp\_vo::func_12BE3([self]);
	if(isdefined(level.masterpcinteraction))
	{
		scripts\cp\_interaction::add_to_current_interaction_list(level.masterpcinteraction);
	}

	if(isdefined(level.backstoryinteraction))
	{
		scripts\cp\_interaction::add_to_current_interaction_list(level.backstoryinteraction);
	}
}