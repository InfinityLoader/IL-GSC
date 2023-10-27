/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_town\cp_town_vo.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 1219 ms
 * Timestamp: 10/27/2023 12:07:46 AM
*******************************************************************/

//Function Number: 1
town_vo_init()
{
	level.var_DDBC = [];
	level.var_2001 = 0;
	level.elvira_playing = 0;
	level.var_D336 = 0;
	level.var_ABE9 = ::rave_vo_callouts;
	level.pap_vo_approve_func = ::is_vo_in_pap;
	level.get_alias_2d_func = ::scripts\cp\_vo::func_77ED;
	level.var_10815 = ::town_starting_vo;
	level thread rave_vo_callouts();
	level.var_5472 = [];
	level thread func_12E45();
	level waittill("activate_power");
}

//Function Number: 2
rave_vo_callouts(param_00)
{
	level.var_134DC["rave_announcer_vo"] = ::func_2000;
	level.var_134DC["rave_ww_vo"] = ::func_13E0C;
	level.var_134DC["zmb_powerup_vo"] = ::func_CE7E;
	level.var_134DC["zmb_afterlife_vo"] = ::func_18E9;
	level.var_134DC["rave_pap_vo"] = ::pap_vo_handler;
	level.var_134DC["rave_dialogue_vo"] = ::func_549B;
	level.var_134DC["elvira_player_dialogue_vo"] = ::one_to_one_dialogue_vo_handler;
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
one_to_one_dialogue_vo_handler(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = self;
	var_08 = isdefined(level.var_134B4[param_00]);
	var_09 = 0;
	level.var_C9C1 = 1;
	scripts\cp\_vo::func_F60C(1);
	var_0A = scripts\cp\_music_and_dialog::func_7DD2(param_00,var_08);
	level.var_540D = var_0A;
	while(scripts\cp\_music_and_dialog::func_134DF())
	{
		wait(0.1);
	}

	level.elvira_playing = 1;
	foreach(var_13, var_0C in var_0A)
	{
		var_0D = 0;
		var_0E = undefined;
		var_09 = 0;
		if(var_08 && isdefined(level.var_134B4[var_0C].var_54AA))
		{
			var_0E = level.var_134B4[var_0C].var_54AA;
			var_0F = var_0E + var_0C;
		}
		else if(issubstr(var_0C,"ww_") || issubstr(var_0C,"el_"))
		{
			var_0F = var_0C;
			var_0D = 1;
			var_09 = 1;
		}
		else
		{
			continue;
		}

		if((isdefined(var_0E) && var_07.var_134FD == var_0E) || var_0D || getdvarint("scr_solo_dialogue",0) == 1)
		{
			var_10 = scripts\cp\_vo::func_4978(var_0F,param_03,param_05,param_06);
			var_07 scripts\cp\_vo::func_F60D(1);
			var_07 scripts\cp\_vo::func_F60B(var_10);
			if(isdefined(var_10.var_1B46) && scripts\common\utility::istrue(var_09))
			{
				if(isdefined(level.elvira))
				{
					scripts\common\utility::play_sound_in_space(var_10.var_1B46,level.elvira.origin,0,level.elvira);
					var_11 = scripts\cp\_vo::func_7C76(var_10.var_1B46);
					var_12 = scripts\common\utility::getstruct("elvira_talk","script_noteworthy");
					var_12 thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_talks(var_11,1);
					wait(scripts\cp\_vo::func_7C76(var_10.var_1B46));
				}
				else
				{
					var_07 scripts\cp\_vo::func_CE77(var_10);
				}
			}
			else
			{
				var_07 scripts\cp\_vo::func_CE77(var_10);
			}

			var_07 scripts\cp\_vo::func_C9B8(var_10);
			var_07 scripts\cp\_vo::func_12C63();
		}

		scripts\common\utility::func_136F7();
	}

	var_07 scripts\cp\_vo::func_F60D(0);
	scripts\cp\_vo::func_F60C(0);
	level.var_C9C1 = 0;
	level.elvira_playing = 0;
	level notify("dialogue_done",param_00);
}

//Function Number: 9
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

	scripts\cp\_vo::func_F60C(0);
}

//Function Number: 10
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

//Function Number: 11
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

//Function Number: 12
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

//Function Number: 13
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

//Function Number: 14
func_2000(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	func_CC8F(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 15
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

//Function Number: 16
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

//Function Number: 17
func_1094A(param_00)
{
	if(param_00 == "dj_jingle_intro")
	{
		level notify("jukebox_start");
	}
}

//Function Number: 18
func_CE7E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	wait(0.5);
	if(level.script == "cp_town")
	{
		func_2000("el_" + param_00,"rave_ww_vo","highest",60,0,0,1);
		if(randomint(100) > 50)
		{
			func_2000("ww_powerup_elvira","rave_ww_vo","highest",60,0,0,1);
			wait(3);
		}
	}
	else
	{
		func_2000("ww_" + param_00,"rave_ww_vo","highest",60,0,0,1);
	}

	param_00 = func_45EA(param_00);
	foreach(var_08 in level.players)
	{
		if(isdefined(var_08) && isalive(var_08))
		{
			var_08 thread scripts\cp\_vo::try_to_play_vo(param_00,"rave_comment_vo");
		}
	}
}

//Function Number: 19
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

//Function Number: 20
func_13D1F()
{
	level endon("game_ended");
	level waittill("wave_start_sound_done");
	if(level.players.size > 1)
	{
		level thread scripts\cp\_vo::try_to_play_vo("ww_intro","rave_ww_vo","highest",30,0,0,1,100);
		return;
	}

	if(level.players[0].var_134FD == "p5_")
	{
		if(randomint(100) > 50)
		{
			level.players[0] thread scripts\cp\_vo::try_to_play_vo("ww_intro_p5_solo","rave_ww_vo","highest",30,0,0,1,100);
			return;
		}

		level.players[0] thread scripts\cp\_vo::try_to_play_vo("ww_intro" + level.players[0].vo_suffix,"rave_ww_vo","highest",30,0,0,1,100);
		return;
	}

	level.players[0] thread scripts\cp\_vo::try_to_play_vo("ww_intro" + level.players[0].vo_suffix,"rave_ww_vo","highest",30,0,0,1,100);
}

//Function Number: 21
power_nag()
{
	level endon("game_ended");
	level endon("found_power");
	for(;;)
	{
		level waittill("wave_start_sound_done");
		if(level.wave_num > 0 && level.wave_num % 3 == 0)
		{
			scripts\cp\_vo::try_to_play_vo_on_all_players("nag_activate_power");
			continue;
		}
	}
}

//Function Number: 22
purchase_area_vo(param_00,param_01)
{
	if(!isdefined(level.played_area_vos))
	{
		level.played_area_vos = [];
	}

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
		level thread scripts\cp\_vo::try_to_play_vo("ww_access_area","rave_announcer_vo","highest",70,0,0,1);
	}
	else
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area_misc","rave_comment_vo","low",10,0,2,1,40);
	}

	param_01.played_vo = 1;
}

//Function Number: 23
town_starting_vo()
{
	scripts\common\utility::flag_wait("intro_gesture_done");
	if(scripts\cp\_music_and_dialog::func_3837())
	{
		var_00 = randomint(100);
		if(var_00 <= 30)
		{
			scripts\cp\_vo::try_to_play_vo_on_all_players("spawn_team_first");
			level thread func_13D1F();
			return;
		}

		var_01 = scripts\common\utility::random(level.players);
		if(isdefined(var_01.var_134FD))
		{
			switch(var_01.var_134FD)
			{
				case "p1_":
					if(randomint(100) > 50)
					{
						level thread scripts\cp\_vo::try_to_play_vo("sally_spawn_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["sally_spawn_1"] = 1;
					}
					else
					{
						level thread scripts\cp\_vo::try_to_play_vo("sally_spawn_alt_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["sally_spawn_alt_1"] = 1;
					}
					break;

				case "p2_":
					if(randomint(100) > 50)
					{
						level thread scripts\cp\_vo::try_to_play_vo("pdex_spawn_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["pdex_spawn_1"] = 1;
					}
					else
					{
						level thread scripts\cp\_vo::try_to_play_vo("pdex_spawn_alt_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["pdex_spawn_alt_1"] = 1;
					}
					break;

				case "p3_":
					if(randomint(100) > 50)
					{
						level thread scripts\cp\_vo::try_to_play_vo("andre_spawn_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["andre_spawn_1"] = 1;
					}
					else
					{
						level thread scripts\cp\_vo::try_to_play_vo("andre_spawn_alt_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["andre_spawn_alt_1"] = 1;
					}
					break;

				case "p4_":
					if(randomint(100) > 50)
					{
						level thread scripts\cp\_vo::try_to_play_vo("aj_spawn_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["aj_spawn_1"] = 1;
					}
					else
					{
						level thread scripts\cp\_vo::try_to_play_vo("aj_spawn_alt_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["aj_spawn_alt_1"] = 1;
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
		foreach(var_03 in level.players)
		{
			if(var_03 issplitscreenplayer())
			{
				if(var_03 issplitscreenplayerprimary())
				{
					if(isdefined(var_03.var_134FD))
					{
						if(var_03.var_134FD == "p5_")
						{
							var_03 multiple_elviras_intro_vo(var_03);
						}
						else
						{
							var_03 thread scripts\cp\_vo::try_to_play_vo("spawn_team_first","rave_comment_vo","high",20,0,0,1);
						}
					}
				}

				continue;
			}

			if(isdefined(var_03.var_134FD))
			{
				if(var_03.var_134FD == "p5_")
				{
					var_03 multiple_elviras_intro_vo(var_03);
					continue;
				}

				var_03 thread scripts\cp\_vo::try_to_play_vo("spawn_team_first","rave_comment_vo","high",20,0,0,1);
			}
		}

		level thread func_13D1F();
		return;
	}

	level.players[0] thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(["spawn_intro","spawn_solo_first"]),"rave_comment_vo","high",20,0,0,1);
	level thread func_13D1F();
}

//Function Number: 24
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
			param_00 thread scripts\cp\_vo::try_to_play_vo("spawn_intro","town_comment_vo");
			break;

		case 2:
			param_00 thread scripts\cp\_vo::try_to_play_vo("p5_players_3","town_comment_vo");
			break;

		case 3:
			param_00 thread scripts\cp\_vo::try_to_play_vo("p5_players_3","town_comment_vo");
			break;

		case 4:
			param_00 thread scripts\cp\_vo::try_to_play_vo("p5_players_4","town_comment_vo");
			break;

		default:
			break;
	}
}