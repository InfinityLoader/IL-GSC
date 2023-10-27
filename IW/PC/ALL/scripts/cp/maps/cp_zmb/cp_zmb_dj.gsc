/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_dj.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 144
 * Decompile Time: 7309 ms
 * Timestamp: 10/27/2023 12:08:10 AM
*******************************************************************/

//Function Number: 1
init_dj_quests()
{
	level.var_CF2F = [];
	level.var_CF2F[""] = 0;
	lib_0D52::func_DED3("ufo",0,::func_95DC,::func_5785,::func_446C,::func_4EB0);
	lib_0D52::func_DED3("ufo",1,::func_2B53,::func_13693,::func_2B53,::func_4F2F);
	lib_0D52::func_DED3("ufo",2,::func_95DF,::func_5787,::func_2B53,::func_4EB2);
	lib_0D52::func_DED3("ufo",3,::func_9729,::func_57BA,::func_2B53,::func_4EB2);
	lib_0D52::func_DED3("ufo",4,::func_977E,::func_57CE,::func_446A,::func_4EB2);
	lib_0D52::func_DED3("ufo",5,::func_2B53,::func_13650,::func_2B53,::func_4EB5);
	lib_0D52::func_DED3("ufo",6,::func_95FF,::func_7D09,::func_4470,::func_4EE3);
	lib_0D52::func_DED3("ufo",7,::func_96D6,::func_CC02,::func_4479,::func_4F01);
	lib_0D52::func_DED3("ufo",8,::func_9678,::func_B3DC,::func_4476,::func_4EF5);
	lib_0D52::func_DED3("ufo",9,::func_2B53,::func_12B0C,::func_2B53,::func_4EB4);
	lib_0D52::func_DED3("ufo",10,::func_94EA,::func_1B6F,::func_4471,::func_4EAF);
	lib_0D52::func_DED3("ufo",11,::func_9791,::func_12B0A,::func_447E,::func_4EB3);
}

//Function Number: 2
func_573B()
{
	for(;;)
	{
		if(isdefined(level.var_CF2F["dj_quest_ufo_partsrecovery_start"]))
		{
			level thread scripts\cp\_vo::try_to_play_vo("quest_dj_intro_1","zmb_dialogue_vo");
			return;
		}

		wait(1);
	}
}

//Function Number: 3
func_95DC()
{
	level.var_F1B0 = [];
	level.var_12FC8 = ::func_6BD7;
	scripts\common\utility::flag_init("dj_fetch_quest_completed");
	scripts\common\utility::flag_init("ufo_destroyed");
}

//Function Number: 4
func_4EC5()
{
	for(;;)
	{
		if(getdvar("scr_dj_location") != "")
		{
			level thread func_F93F();
			setdvar("scr_dj_location","");
		}

		wait(1);
	}
}

//Function Number: 5
func_446C()
{
	if(!scripts\common\utility::istrue(level.var_5738))
	{
		func_CB23(level.var_F1B0[1],level.players[0]);
	}

	if(!scripts\common\utility::istrue(level.var_5739))
	{
		func_CB24(level.var_F1B0[2],level.players[0]);
	}

	if(!scripts\common\utility::istrue(level.var_573A))
	{
		func_CB25(level.var_F1B0[3],level.players[0]);
	}
}

//Function Number: 6
func_5785()
{
	scripts\common\utility::flag_wait("dj_fetch_quest_completed");
}

//Function Number: 7
func_4EB0()
{
}

//Function Number: 8
func_6BD7(param_00,param_01)
{
	if(!isdefined(level.first_time_use_door_allparts))
	{
		level.first_time_use_door_allparts = 0;
	}

	level thread func_CCE0(param_01,param_00);
}

//Function Number: 9
play_dj_willard_exchange(param_00)
{
	level.var_C9C1 = 1;
	level.var_550B = 1;
	scripts\cp\maps\cp_zmb\cp_zmb_vo::clear_up_all_vo(param_00);
	scripts\cp\_vo::func_C9CB([param_00]);
	level.var_572A func_F35B("approach_mic");
	if(randomint(100) >= 50)
	{
		playsoundatpos(level.var_572A.origin,"dj_dj_noparts_1");
		wait(scripts\cp\_vo::func_7C76("dj_dj_noparts_1"));
		if(param_00.var_134FD == "p6_")
		{
			param_00 playlocalsound("p6_plr_dj_noparts_2");
		}
		else
		{
			param_00 playlocalsound("p6_dj_noparts_2");
		}

		wait(scripts\cp\_vo::func_7C76("p6_dj_noparts_2"));
		playsoundatpos(level.var_572A.origin,"dj_dj_noparts_3");
		wait(scripts\cp\_vo::func_7C76("dj_dj_noparts_3"));
	}
	else
	{
		playsoundatpos(level.var_572A.origin,"dj_dj_quest_success_1");
		wait(scripts\cp\_vo::func_7C76("dj_dj_quest_success_1"));
		if(param_00.var_134FD == "p6_")
		{
			param_00 playlocalsound("p6_plr_dj_quest_success_2");
		}
		else
		{
			param_00 playlocalsound("p6_dj_quest_success_2");
		}

		wait(scripts\cp\_vo::func_7C76("p6_dj_quest_success_2"));
		playsoundatpos(level.var_572A.origin,"dj_dj_quest_success_3");
		wait(scripts\cp\_vo::func_7C76("dj_dj_quest_success_3"));
	}

	level.var_572A func_F35B("open_window");
	scripts\cp\_vo::func_12BE3([param_00]);
	level.var_C9C1 = 0;
	level.var_550B = undefined;
}

//Function Number: 10
func_CCE0(param_00,param_01)
{
	level.var_550B = 1;
	scripts\cp\_interaction::remove_from_current_interaction_list(param_01);
	if(isdefined(param_00.var_134FD))
	{
		if(param_00.var_134FD == "p5_" || param_00.var_134FD == "p6_")
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("quest_intro","zmb_comment_vo");
			wait(scripts\cp\_vo::func_7C76(param_00.var_134FD + "quest_intro") + 3);
		}
	}

	if(func_7B37() == 0)
	{
		if(randomint(100) > 50)
		{
			if(param_00.var_134FD == "p6_")
			{
				play_dj_willard_exchange(param_00);
			}
			else if(param_00.var_134FD == "p5_")
			{
				playsoundatpos(level.var_572A.origin,"dj_quest_ufo_partsrecovery_fail");
				wait(scripts\cp\_vo::func_7C76("dj_quest_ufo_partsrecovery_fail"));
				param_00 thread scripts\cp\_vo::try_to_play_vo("quest_return_noparts","zmb_comment_vo");
			}
		}
		else
		{
			playsoundatpos(level.var_572A.origin,"dj_quest_ufo_partsrecovery_fail");
			wait(scripts\cp\_vo::func_7C76(param_00.var_134FD + "quest_return_noparts"));
			param_00 thread scripts\cp\_vo::try_to_play_vo("quest_return_noparts","zmb_comment_vo");
		}

		level.first_time_use_door_allparts = 1;
	}
	else if(func_7B37() == 1)
	{
		if(param_00.var_134FD == "p6_" || param_00.var_134FD == "p5_")
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("quest_return_generic","zmb_comment_vo");
			wait(scripts\cp\_vo::func_7C76(param_00.var_134FD + "quest_return_generic"));
			playsoundatpos(level.var_572A.origin,"dj_quest_parts_1");
		}

		level.first_time_use_door_allparts = 1;
	}
	else if(func_7B37() == 2)
	{
		if(param_00.var_134FD == "p6_" || param_00.var_134FD == "p5_")
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("quest_return_generic","zmb_comment_vo");
			wait(scripts\cp\_vo::func_7C76(param_00.var_134FD + "quest_return_generic"));
			playsoundatpos(level.var_572A.origin,"dj_quest_parts_2");
		}

		level.first_time_use_door_allparts = 1;
	}
	else if(func_7B37() == 3)
	{
		scripts\cp\_vo::func_E01F("nag_return_djpart");
		if(level.first_time_use_door_allparts == 0)
		{
			playsoundatpos(level.var_572A.origin,"dj_quest_ufo_parts_before_quest");
		}
		else
		{
			playsoundatpos(level.var_572A.origin,"dj_quest_parts_all");
		}

		scripts\cp\zombies\zombie_analytics::func_AF70(level.wave_num,param_01.name);
		level.var_12FC8 = undefined;
	}

	level.var_550B = undefined;
	scripts\cp\_vo::func_E01F("dj_quest_ufo_partsrecovery_start");
	level scripts\cp\_vo::func_1769("dj_craft_nag","zmb_dj_vo",60,60,2,1);
	scripts\cp\_interaction::add_to_current_interaction_list(param_01);
}

//Function Number: 11
func_96AD()
{
	func_95B2("dj_quest_part_1","zmb_frequency_device_radio");
}

//Function Number: 12
func_CB23(param_00,param_01)
{
	level.var_5738 = 1;
	if(randomint(100) > 50)
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("collect_dj","zmb_comment_vo","low",10,0,0,1,50);
	}
	else
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("quest_dj_boombox","zmb_comment_vo","highest",10,1,0,0,100);
	}

	level thread scripts\cp\_vo::func_E01F("dj_craft_nag",1);
	func_CB21(param_00,param_01,22);
}

//Function Number: 13
func_96AE()
{
	func_95B2("dj_quest_part_2","zmb_frequency_device_calculator");
}

//Function Number: 14
func_CB24(param_00,param_01)
{
	level.var_5739 = 1;
	if(randomint(100) > 50)
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("collect_dj","zmb_comment_vo","low",10,0,0,1,50);
	}
	else
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("quest_dj_calculator","zmb_comment_vo","highest",10,1,0,0,100);
	}

	func_CB21(param_00,param_01,23);
}

//Function Number: 15
func_96AF()
{
	func_95B2("dj_quest_part_3","zmb_frequency_device_umbrella_ground");
}

//Function Number: 16
func_CB25(param_00,param_01)
{
	level.var_573A = 1;
	if(randomint(100) > 50)
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("collect_dj","zmb_comment_vo","low",10,0,0,1,50);
	}
	else
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("quest_dj_umbrella","zmb_comment_vo","highest",10,1,0,0,100);
	}

	func_CB21(param_00,param_01,24);
	level thread scripts\cp\_vo::func_E01F("dj_quest_ufo_partsrecovery_hint");
}

//Function Number: 17
func_95B2(param_00,param_01)
{
	if(scripts\cp\_utility::is_codxp())
	{
		return;
	}

	if(!isdefined(level.var_5749))
	{
		level.var_5749 = ["area_1","area_2","area_3"];
	}

	var_02 = scripts\common\utility::getstructarray(param_00,"script_noteworthy");
	var_03 = scripts\common\utility::random(level.var_5749);
	var_04 = scripts\common\utility::array_randomize(var_02);
	var_05 = undefined;
	foreach(var_07 in var_04)
	{
		if(!isdefined(var_05) && var_03 == var_07.var_86A2)
		{
			var_05 = var_07;
			level.var_5749 = scripts\common\utility::func_22A9(level.var_5749,var_07.var_86A2);
		}

		scripts\cp\_interaction::remove_from_current_interaction_list(var_07);
	}

	var_09 = scripts\common\utility::getstruct(var_05.target,"targetname");
	var_0A = spawn("script_model",var_09.origin);
	var_0A setmodel(param_01);
	if(isdefined(var_09.angles))
	{
		var_0A.angles = var_09.angles;
	}

	var_05.var_C921 = var_0A;
	var_05.var_4C72 = 96;
	scripts\cp\_interaction::add_to_current_interaction_list(var_05);
	func_1761(var_05);
}

//Function Number: 18
func_CB21(param_00,param_01,param_02)
{
	if(func_7B37() == 3)
	{
		scripts\common\utility::flag_set("dj_fetch_quest_completed");
		param_01 thread scripts\cp\_vo::func_1769("nag_return_djpart","zmb_comment_vo",60,100,3,1);
	}

	playfx(level._effect["souvenir_pickup"],param_00.var_C921.origin);
	param_01 playlocalsound("part_pickup");
	scripts\cp\zombies\zombie_analytics::func_AF6F(level.wave_num,param_00.var_86A2,param_00.var_C921.model);
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_00.var_C921 delete();
	level scripts\cp\_utility::set_quest_icon(param_02);
}

//Function Number: 19
func_7B37()
{
	var_00 = 0;
	if(scripts\common\utility::istrue(level.var_5738))
	{
		var_00++;
	}

	if(scripts\common\utility::istrue(level.var_5739))
	{
		var_00++;
	}

	if(scripts\common\utility::istrue(level.var_573A))
	{
		var_00++;
	}

	return var_00;
}

//Function Number: 20
func_1761(param_00)
{
	level.var_F1B0[level.var_F1B0.size + 1] = param_00;
}

//Function Number: 21
func_F93F()
{
	var_00 = scripts\common\utility::getstructarray("dj_quest_door","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_F1AE = 0;
	}

	if(isdefined(level.the_hoff))
	{
		return;
	}

	level.var_F1AF = scripts\common\utility::random(var_00);
	level.var_F1AF.var_F1AE = 1;
	level thread func_F93E(level.var_F1AF);
}

//Function Number: 22
func_3E89()
{
	level notify("choose_new_dj_door");
	level endon("choose_new_dj_door");
	if(isdefined(level.the_hoff))
	{
		return;
	}

	level.var_550B = 1;
	while(!isdefined(level.var_572A) || !isdefined(level.var_572A.var_4BBE) || level.var_572A.var_4BBE != "idle")
	{
		wait(1);
	}

	for(;;)
	{
		if(level.var_572A.var_4BBE != "close_window")
		{
			func_F35B("close_window");
		}

		wait(1);
		if(level.var_572A.var_4BBE == "close_window")
		{
			break;
		}
	}

	var_00 = scripts\common\utility::getstructarray("dj_quest_door","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_F1AE = 0;
	}

	level.var_572A waittill("window_closed");
	if(isdefined(level.the_hoff))
	{
		return;
	}

	level.var_F1AF = scripts\common\utility::random(var_00);
	level.var_F1AF.var_F1AE = 1;
	level thread func_F93E(level.var_F1AF);
}

//Function Number: 23
func_13693()
{
	for(;;)
	{
		level waittill("wave_start_sound_done");
		if(scripts\common\utility::flag("pap_portal_used"))
		{
			break;
		}
	}
}

//Function Number: 24
func_4F2F()
{
}

//Function Number: 25
func_13666()
{
	level endon("stop_wait_some_wave");
	var_00 = 3;
	var_01 = 0;
	for(;;)
	{
		level waittill("wave_start_sound_done");
		var_01++;
		if(var_01 >= var_00)
		{
			break;
		}
	}
}

//Function Number: 26
func_4EB6()
{
}

//Function Number: 27
func_13650()
{
	level endon("stop_wait_one_wave");
	level waittill("regular_wave_starting");
}

//Function Number: 28
func_4EB5()
{
}

//Function Number: 29
func_95DF()
{
	scripts\common\utility::flag_init("defend_sequence");
	scripts\common\utility::flag_init("dj_request_defense_done");
	level.var_F1B7 = [];
	level.var_1092A = 60;
	level.var_12FC8 = ::func_12FCB;
	level.frequency_device_clip = getent("frequency_device_clip","targetname");
	level.frequency_device_clip.originalloc = level.frequency_device_clip.origin;
}

//Function Number: 30
func_12FCB(param_00,param_01)
{
	scripts\common\utility::flag_set("dj_request_defense_done");
	level thread scripts\cp\_vo::try_to_play_vo("dj_quest_ufo_speakerdefense_start","zmb_dj_vo");
	foreach(param_01 in level.players)
	{
		param_01 setclientomnvar("zm_special_item",3);
	}
}

//Function Number: 31
func_12FC7(param_00,param_01)
{
	playsoundatpos(level.var_572A.origin,"dj_quest_freq_notready");
}

//Function Number: 32
func_12FC5(param_00,param_01)
{
	scripts\common\utility::flag_set("dj_request_defense_done");
	level.var_12FC8 = ::func_12FC7;
	foreach(param_01 in level.players)
	{
		param_01 setclientomnvar("zm_special_item",3);
	}
}

//Function Number: 33
func_12FCA(param_00,param_01)
{
}

//Function Number: 34
func_9729()
{
	level.var_12FC8 = ::func_12FCB;
	level.var_1092A = 90;
}

//Function Number: 35
func_977E()
{
	level.var_12FC8 = ::func_12FCB;
	level.var_1092A = 120;
}

//Function Number: 36
func_5787()
{
	level thread ufo_light_sequence_pre_defense();
	func_57C3(20);
}

//Function Number: 37
func_57BA()
{
	func_57C3(22);
}

//Function Number: 38
func_57CE()
{
	func_57C3(25);
}

//Function Number: 39
func_57C3(param_00)
{
	scripts\common\utility::flag_wait("dj_request_defense_done");
	scripts\common\utility::flag_set("defend_sequence");
	var_01 = func_7C90(param_00);
	for(;;)
	{
		var_02 = level scripts\common\utility::func_13734("speaker_defense_failed","speaker_defense_completed");
		if(var_02 == "speaker_defense_failed")
		{
			level thread scripts\cp\_vo::try_to_play_vo("dj_quest_ufo_partsrecovery_fail","zmb_dj_vo","high",20,0,0,1);
			scripts\common\utility::flag_wait("dj_request_defense_done");
			var_01 thread func_D53C(var_01);
			var_01 thread func_B2F3(var_01);
			continue;
		}
		else
		{
			level scripts\common\utility::func_137AC("speaker_picked_up","regular_wave_starting");
			level.var_12FC8 = undefined;
			break;
		}
	}
}

//Function Number: 40
func_446A()
{
	level.var_12FC8 = undefined;
	scripts\common\utility::func_6E2A("defend_sequence");
	level thread func_3E89();
}

//Function Number: 41
ufo_light_sequence_pre_defense()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_6EE0(0);
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_D511(["01","02","03","04","05","06"],0);
}

//Function Number: 42
func_4EB2()
{
}

//Function Number: 43
func_F1A1()
{
	var_00 = scripts\common\utility::getstructarray("dj_quest_speaker","script_noteworthy");
	var_03 = [];
	var_04 = [];
	foreach(var_06 in var_00)
	{
		if(isdefined(var_06.var_2135) && var_06.var_2135 == "underground_route")
		{
			var_03[var_03.size] = var_06;
			continue;
		}

		var_04[var_04.size] = var_06;
	}

	for(var_01 = 0;var_01 < 3;var_01++)
	{
		if(var_01 < 1)
		{
			var_08 = scripts\common\utility::random(var_03);
			var_03 = scripts\common\utility::func_22A9(var_03,var_08);
			level.var_F1B7[level.var_F1B7.size] = var_08;
			continue;
		}

		var_09 = scripts\common\utility::random(var_04);
		var_04 = scripts\common\utility::func_22A9(var_04,var_09);
		level.var_F1B7[level.var_F1B7.size] = var_09;
	}
}

//Function Number: 44
func_95FF()
{
	level.var_12FC8 = ::func_12FC9;
	scripts\common\utility::flag_init("tone_generators_given");
}

//Function Number: 45
func_7D09()
{
	scripts\common\utility::flag_wait("tone_generators_given");
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("zm_special_item",5);
	}
}

//Function Number: 46
func_4470()
{
	level.var_12FC8 = undefined;
	level thread scripts\cp\_vo::func_1769("dj_quest_ufo_tonegen_hint","zmb_dj_vo",60,15,2,1);
}

//Function Number: 47
func_4EE3()
{
}

//Function Number: 48
func_12FC9(param_00,param_01)
{
	scripts\common\utility::flag_set("tone_generators_given");
	level scripts\cp\_vo::func_1769("dj_quest_ufo_tonegen_nag","zmb_dj_vo",60,60,2,1);
	scripts\cp\zombies\zombie_analytics::func_AF70(level.wave_num,param_00.name);
	level thread scripts\cp\_vo::func_1769("dj_quest_ufo_tonegen_nag","zmb_dj_vo",60,15,2,1);
	level.var_12FC8 = ::func_12FC6;
}

//Function Number: 49
func_12FC6(param_00,param_01)
{
}

//Function Number: 50
func_96D6()
{
	scripts\common\utility::flag_init("all_structs_placed");
	scripts\common\utility::flag_init("all_center_positions_used");
	level.var_3BB8 = [];
	func_1602();
}

//Function Number: 51
func_CC02()
{
	scripts\common\utility::flag_wait("all_center_positions_used");
	level thread scripts\cp\_vo::func_E01F("dj_quest_ufo_tonegen_nag",1);
}

//Function Number: 52
func_4479()
{
	scripts\common\utility::flag_set("jukebox_paused");
	level notify("skip_song");
	func_5606();
}

//Function Number: 53
func_4F01()
{
}

//Function Number: 54
func_9678()
{
	scripts\common\utility::flag_init("ufo_listening");
	scripts\common\utility::flag_init("tones_played_successfully");
	scripts\common\utility::flag_init("ufo_intro_reach_center_portal");
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_10C6B();
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_560B();
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_F63A();
	level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_12B06();
	level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_BC31();
	level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_12B12();
}

//Function Number: 55
func_B3DC()
{
	var_00 = level.var_12B01;
	level thread func_12B07();
	scripts\cp\zombies\zombie_analytics::func_AF8D(level.wave_num);
	var_00 thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_10CA8();
	scripts\common\utility::flag_wait("tones_played_successfully");
}

//Function Number: 56
func_12B07()
{
	level endon("game_ended");
	scripts\cp\_vo::try_to_play_vo_on_all_players("ufo_first");
	wait(4);
	level thread scripts\cp\_vo::try_to_play_vo("ww_ufo_spawn_action","zmb_announcer_vo","highest",60,0,0,1);
}

//Function Number: 57
func_4476()
{
	level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_52CC();
	scripts\common\utility::flag_set("tones_played_successfully");
}

//Function Number: 58
func_4EF5()
{
}

//Function Number: 59
func_12B0C()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_12B0D();
}

//Function Number: 60
func_4EB4()
{
}

//Function Number: 61
func_94EA()
{
}

//Function Number: 62
func_1B6F()
{
	level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_10C6C();
	level waittill("complete_alien_grey_fight");
}

//Function Number: 63
func_4471()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_4159();
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_10FFE();
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_10FFD();
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_5CDF();
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_6279();
	var_00 = spawn("script_model",level.players[0].origin);
	var_00 setmodel("tag_origin");
	var_00.team = "allies";
	level.var_72AA = 1;
	scripts\cp\zombies\_powerups::func_D980(level.players[0],"kill_50",var_00,0);
	level.var_13BD6 = undefined;
	level.var_10847 = undefined;
	wait(5);
	scripts\common\utility::func_6E2A("pause_wave_progression");
	scripts\common\utility::func_6E2A("all_center_positions_used");
	if(level.wave_num == level.ufo_starting_wave)
	{
		level.var_4B6E = level.savedcurrentdeaths;
		level.var_B467 = level.savemaxspawns;
		level.var_5274 = level.savedesireddeaths;
		return;
	}

	level.var_4B6E = 0;
	level.var_B467 = scripts\cp\zombies\zombies_spawning::func_7ACD(level.wave_num);
	level.var_5274 = scripts\cp\zombies\zombies_spawning::func_7D10(level.wave_num);
}

//Function Number: 64
func_4EAF()
{
}

//Function Number: 65
func_9791()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_15E6();
}

//Function Number: 66
func_12B0A()
{
	level thread scripts\cp\_vo::try_to_play_vo("dj_quest_ufo_destroy_nag","zmb_dj_vo","high",10,0,3,0);
	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_10D29(level.var_12B01);
	level waittill("ufo_destroyed");
}

//Function Number: 67
func_447E()
{
	scripts\common\utility::flag_set("ufo_quest_finished");
	level thread wait_drop_soul_key();
	scripts\common\utility::func_6E2A("jukebox_paused");
	func_6276();
}

//Function Number: 68
wait_drop_soul_key()
{
	level endon("game_ended");
	if(scripts\cp\maps\cp_zmb\cp_zmb_ufo::any_player_is_willard())
	{
		if(scripts\common\utility::func_6E34("pause_spawn_after_UFO_destroyed"))
		{
			scripts\common\utility::func_6E5A("pause_spawn_after_UFO_destroyed");
		}
	}

	scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_5D12();
}

//Function Number: 69
func_4EB3()
{
}

//Function Number: 70
func_12FC4(param_00,param_01)
{
	if(param_00.var_F1AE == 1)
	{
		if(level.var_572A.var_4BBE == "mic_loop")
		{
			param_01 playlocalsound("dj_deny");
			return;
		}

		if(isdefined(level.var_12FC8))
		{
			[[ level.var_12FC8 ]](param_00,param_01);
			param_01 playlocalsound("dj_turn_in");
			return;
		}

		func_4FE7(param_00,param_01);
		return;
	}

	param_01 playlocalsound("dj_deny");
}

//Function Number: 71
func_4FE7(param_00,param_01)
{
	if(isdefined(level.var_10405) && gettime() >= level.var_10405 || level.var_10405 == 0)
	{
		level notify("skip_song");
		level.var_10405 = gettime() + 30000;
		param_01 playlocalsound("dj_turn_in");
		var_02 = scripts\common\utility::random(["dj_newtrack_request"]);
		playsoundatpos(level.var_572A.origin,var_02);
		return;
	}

	var_02 playlocalsound("dj_turn_in");
	var_02 = scripts\common\utility::random(["dj_newtrack_cooldown"]);
	playsoundatpos(level.var_572A.origin,var_02);
}

//Function Number: 72
disable_dj_broadcast_for_time(param_00)
{
	level.var_550B = 1;
	wait(param_00);
	level.var_550B = undefined;
}

//Function Number: 73
func_7C90(param_00)
{
	if(level.var_F1B7.size == 0)
	{
		func_F1A1();
	}

	var_01 = scripts\common\utility::random(level.var_F1B7);
	level.var_F1B7 = scripts\common\utility::func_22A9(level.var_F1B7,var_01);
	var_01 thread func_D53C(var_01);
	var_01 thread func_B2F3(var_01);
	var_01.var_13BD6 = param_00;
	return var_01;
}

//Function Number: 74
func_572C(param_00,param_01)
{
	return &"CP_QUEST_WOR_PART";
}

//Function Number: 75
func_573E(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_00.placed))
	{
		return &"CP_QUEST_WOR_USE_TONE_EQUIP";
	}

	return &"CP_QUEST_WOR_PLACE_PART";
}

//Function Number: 76
func_5731(param_00,param_01)
{
	if(param_00.var_F1AE)
	{
		return &"CP_ZMB_INTERACTIONS_TALK_TO_DJ";
	}

	return &"CP_ZMB_INTERACTIONS_DJ_NOT_HERE";
}

//Function Number: 77
func_95B4()
{
	var_00 = scripts\common\utility::getstructarray("dj_quest_speaker","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_03 = scripts\cp\_interaction::func_7829(var_02);
		if(isdefined(var_03))
		{
			var_02.var_2135 = var_03;
		}

		scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
		var_02.var_4C72 = 128;
	}
}

//Function Number: 78
func_D53C(param_00)
{
	level endon("speaker_defense_completed");
	level endon("speaker_defense_started");
	level endon("speaker_defense_failed");
	param_00 endon("death");
	for(;;)
	{
		if(!scripts\common\utility::flag("dj_request_defense_done"))
		{
			scripts\common\utility::flag_wait("dj_request_defense_done");
		}

		if(scripts\common\utility::istrue(level.var_106E2))
		{
			level waittill("regular_wave_starting");
		}

		var_01 = scripts\common\utility::func_782F(param_00.origin,level.players,undefined,4,96);
		foreach(var_03 in var_01)
		{
			var_03 setclientomnvar("ui_hud_shake",1);
			var_03 playrumbleonentity("artillery_rumble");
		}

		playsoundatpos(param_00.origin,"tone_placement_close");
		wait(randomfloatrange(0.5,2));
	}
}

//Function Number: 79
func_B2F3(param_00)
{
	param_00 notify("speaker_loc_manager");
	param_00 endon("speaker_loc_manager");
	level endon("speaker_defense_started");
	if(scripts\common\utility::istrue(level.var_106E2))
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	}
	else
	{
		scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	}

	for(;;)
	{
		var_01 = level scripts\common\utility::func_13734("event_wave_starting","regular_wave_starting");
		if(var_01 == "event_wave_starting")
		{
			scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
			continue;
		}

		scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	}
}

//Function Number: 80
func_136A9(param_00)
{
	param_00 notify("waiting_for_all_structs_used");
	param_00 endon("waiting_for_all_structs_used");
	if(!scripts\common\utility::func_2286(level.var_3BB8,param_00))
	{
		level.var_3BB8[level.var_3BB8.size] = param_00;
	}

	if(level.var_3BB8.size == level.players.size)
	{
		scripts\common\utility::flag_set("all_center_positions_used");
	}

	wait(1);
	if(scripts\common\utility::func_2286(level.var_3BB8,param_00))
	{
		level.var_3BB8 = scripts\common\utility::func_22A9(level.var_3BB8,param_00);
	}
}

//Function Number: 81
func_5606()
{
	disablepaspeaker("starting_area");
	disablepaspeaker("cosmic_way");
	disablepaspeaker("kepler");
	disablepaspeaker("triton");
	disablepaspeaker("astrocade");
	disablepaspeaker("journey");
}

//Function Number: 82
func_6276()
{
	enablepaspeaker("starting_area");
	enablepaspeaker("cosmic_way");
	enablepaspeaker("kepler");
	enablepaspeaker("triton");
	enablepaspeaker("astrocade");
	enablepaspeaker("journey");
}

//Function Number: 83
func_10929(param_00,param_01)
{
	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 84
func_10C10(param_00,param_01)
{
	var_02 = param_01 func_3835(param_00);
	if(!isdefined(var_02))
	{
		return 0;
	}

	func_F5E6();
	func_C13D();
	func_5586(param_00);
	func_F34A();
	level thread keep_park_workers_from_despawning();
	level thread scripts\cp\_vo::try_to_play_vo("dj_sign_off","zmb_dj_vo","medium",3,0,0,1);
	func_F5E1(param_00,var_02);
	foreach(param_01 in level.players)
	{
		param_01 setclientomnvar("zm_special_item",0);
	}

	level.var_12FC8 = ::func_12FC7;
	level thread func_110A0(param_00);
	thread func_10DF2(param_00);
}

//Function Number: 85
func_3835(param_00)
{
	var_01 = self canplayerplacesentry(1,24);
	if(self isonground() && var_01["result"] && abs(param_00.origin[2] - self.origin[2]) < 24)
	{
		return var_01;
	}

	return undefined;
}

//Function Number: 86
keep_park_workers_from_despawning()
{
	level endon("speaker_defense_failed");
	level endon("speaker_defense_completed");
	while(scripts\common\utility::flag("defense_sequence_active"))
	{
		level waittill("agent_spawned",var_00);
		var_00.dont_cleanup = 1;
	}
}

//Function Number: 87
turn_despawn_back_on()
{
	foreach(var_01 in level.spawned_enemies)
	{
		var_01.dont_cleanup = undefined;
	}
}

//Function Number: 88
func_1092B(param_00,param_01)
{
	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 89
func_110A0(param_00)
{
	var_01 = level.var_4632;
	var_02 = level.var_4B6E;
	var_03 = level.var_B467;
	var_04 = level.var_5274;
	var_05 = level.wave_num;
	while(level.var_4B6E == level.var_5274)
	{
		wait(0.05);
	}

	level.var_4B6E = 0;
	if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
	{
		level.var_B467 = 16;
	}
	else
	{
		level.var_B467 = 24;
	}

	level.var_5274 = 24;
	level.var_10942 = 1;
	scripts\common\utility::flag_set("pause_wave_progression");
	var_06 = level scripts\common\utility::func_13734("speaker_defense_failed","speaker_defense_completed");
	if(var_06 == "speaker_defense_completed")
	{
		level.var_726C = "ammo_max";
	}

	var_07 = spawn("script_model",level.players[0].origin);
	var_07 setmodel("tag_origin");
	var_07.team = "allies";
	level.var_72AA = 1;
	scripts\cp\zombies\_powerups::func_D980(level.players[0],"kill_50",var_07,0);
	level.var_10847 = undefined;
	level.var_13BD6 = undefined;
	level.var_10942 = undefined;
	turn_despawn_back_on();
	wait(2);
	if(var_06 == "speaker_defense_failed")
	{
		scripts\common\utility::flag_set("force_spawn_boss");
	}

	wait(3);
	scripts\common\utility::func_6E2A("pause_wave_progression");
	if(level.wave_num == var_05)
	{
		level.var_4B6E = var_02;
		level.var_B467 = var_03;
		level.var_5274 = var_04;
		return;
	}

	level.var_4B6E = 0;
	level.var_B467 = scripts\cp\zombies\zombies_spawning::func_7ACD(level.wave_num);
	level.var_5274 = scripts\cp\zombies\zombies_spawning::func_7D10(level.wave_num);
}

//Function Number: 90
func_10DF2(param_00)
{
	var_01 = level.var_1646;
	var_02 = undefined;
	var_03 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_04 = scripts\common\utility::func_782F(param_00.origin,level.players,undefined,4,1000);
	foreach(var_06 in scripts\cp\_agent_utils::func_7DB0("axis"))
	{
		var_06 thread func_1887(var_06);
	}

	foreach(var_09 in var_01)
	{
		if(function_010F(param_00.origin,var_09))
		{
			var_02 = var_09;
			foreach(var_0B in var_03)
			{
				var_0B thread func_F231(var_0B,var_02);
			}

			break;
		}
	}

	if(isdefined(var_02.var_1087B))
	{
		var_0E = scripts\common\utility::func_782F(param_00.origin,var_02.var_1087B,undefined,100,400);
		foreach(var_10 in var_0E)
		{
			var_10 scripts\cp\zombies\zombies_spawning::func_B288();
		}
	}

	foreach(var_13 in var_01)
	{
		if(var_13 == var_02)
		{
			continue;
		}

		var_13 scripts\cp\zombies\zombies_spawning::func_B292();
	}

	level scripts\common\utility::func_13734("speaker_defense_failed","speaker_defense_completed");
	foreach(var_16 in var_01)
	{
		var_16 scripts\cp\zombies\zombies_spawning::func_B291();
	}
}

//Function Number: 91
func_F231(param_00,param_01)
{
	var_02 = 250000;
	param_00 endon("death");
	level endon("speaker_defense_failed");
	level endon("speaker_defense_completed");
	while(!isdefined(level.current_speaker))
	{
		wait(0.05);
	}

	param_00.var_EF64 = 1;
	param_00.var_180 = 1;
	param_00 method_82EF(level.frequency_device_clip.origin);
	for(;;)
	{
		if(distance(param_00.origin,level.current_speaker.origin) < 750)
		{
			break;
		}

		wait(0.5);
	}

	param_00.var_EF64 = 0;
	param_00.var_180 = 0;
}

//Function Number: 92
func_C13D()
{
	level notify("speaker_defense_started");
}

//Function Number: 93
func_5586(param_00)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
}

//Function Number: 94
func_F34A()
{
	if(!scripts\common\utility::func_6E34("defense_sequence_active"))
	{
		scripts\common\utility::flag_init("defense_sequence_active");
	}

	scripts\common\utility::flag_set("defense_sequence_active");
	level.var_5093 = gettime();
}

//Function Number: 95
func_F5E1(param_00,param_01)
{
	var_02 = param_01["origin"];
	if(isdefined(param_00.var_13BD6))
	{
		level.var_13BD6 = param_00.var_13BD6;
	}

	if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
	{
		level.var_10847 = 0.7;
	}
	else
	{
		level.var_10847 = 0.35;
	}

	var_02 = var_02 + (0,0,0.5);
	var_03 = spawn("script_model",var_02);
	var_03 setmodel("zmb_frequency_device");
	var_03 notsolid();
	if(isdefined(param_00.angles))
	{
		var_03.angles = param_00.angles;
		level.frequency_device_clip.angles = param_00.angles;
	}
	else
	{
		var_03.angles = (0,0,0);
		level.frequency_device_clip.angles = (0,0,0);
	}

	level.frequency_device_clip dontinterpolate();
	level.frequency_device_clip.origin = var_03.origin + (0,0,48);
	level.frequency_device_clip.special_case_ignore = 1;
	level.frequency_device_clip method_81F1("allies",0);
	level.frequency_device_clip.navrepulsor = function_0277("speaker_nav_repulsor",0,var_03.origin,72,1);
	var_03 thread func_4D07(var_03,level.frequency_device_clip);
	level thread destroyspeakerifonlyoneplayer(var_03);
	var_03 thread func_23DB(var_03,level.frequency_device_clip);
	var_03 thread func_DB5E(var_03,param_00);
	level.current_speaker = var_03;
	var_03.var_902E = 10;
	level.fake_players = scripts\common\utility::array_add_safe(level.fake_players,level.frequency_device_clip);
}

//Function Number: 96
destroyspeakerifonlyoneplayer(param_00)
{
	level endon("speaker_defense_completed");
	level endon("speaker_defense_failed");
	level waittill("destroy_speaker");
	level thread func_5094(param_00);
}

//Function Number: 97
func_1887(param_00,param_01)
{
	param_00 endon("death");
	if(isdefined(param_00.agent_type) && param_00.agent_type == "zombie_brute" || param_00.agent_type == "zombie_grey" || param_00.agent_type == "zombie_ghost")
	{
		return;
	}

	if(scripts\common\utility::istrue(param_00.var_9CDD))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01))
	{
		wait(0.5);
	}

	param_00.var_1F5 = "sprint";
	param_00 lib_0A1B::func_2968("sprint");
}

//Function Number: 98
func_7C8F(param_00)
{
	var_01 = 0;
	var_01 = param_00.var_902E / 10;
	setomnvar("zm_speaker_defense_health",var_01);
}

//Function Number: 99
func_4D07(param_00,param_01)
{
	level endon("speaker_defense_completed");
	level endon("destroy_speaker");
	param_00 endon("death");
	param_01 setcandamage(1);
	param_01.health = 9999999;
	param_00.nextdamagetime = 0;
	for(;;)
	{
		param_01 waittill("damage",var_02,var_03);
		if(isdefined(var_03) && isdefined(var_03.team) && var_03.team == "allies")
		{
			continue;
		}

		if(!var_03 scripts\cp\_utility::func_9D20())
		{
			continue;
		}

		if(!isdefined(var_03.agent_type) || isdefined(var_03.agent_type) && var_03.agent_type != "zombie_brute")
		{
			if(!isdefined(var_03.attackent))
			{
				var_03.attackent = param_01;
				var_03 thread removelockedonflagonspeakerdeath(var_03,param_00);
			}
		}

		playfx(level._effect["vfx_zb_thu_sparks"],param_00.origin + (0,0,32));
		var_03 notify("speaker_attacked");
		foreach(var_05 in level.players)
		{
			var_05 thread scripts\cp\_vo::try_to_play_vo("quest_ufo_defend_speakers","zmb_comment_vo");
		}

		var_07 = gettime();
		if(var_07 >= param_00.nextdamagetime)
		{
			param_00.nextdamagetime = var_07 + 1000;
			param_00.var_902E--;
		}

		if(param_00.var_902E == 0)
		{
			break;
		}

		param_00.var_9298 = func_7C8F(param_00);
	}

	func_5094(param_00);
}

//Function Number: 100
removelockedonflagonspeakerdeath(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("death");
	param_01 scripts\common\utility::waittill_any_3("death","speaker_defense_completed");
	param_00.attackent = undefined;
}

//Function Number: 101
func_DB5E(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("death");
	var_02 = spawn("script_model",param_00.origin + (0,0,32));
	setomnvar("zm_speaker_defense_target",var_02);
	setomnvar("zm_speaker_defense_timer",level.var_1092A);
	setomnvar("zm_speaker_defense_health",1);
	func_1092C(var_02,param_01);
	func_5096(param_00);
	func_6949(param_00);
}

//Function Number: 102
func_1092C(param_00,param_01)
{
	level endon("complete_defense");
	param_00 playloopsound("speaker_defense_tone_scrubbing");
	var_02 = level.var_1092A;
	thread func_12971(var_02,param_00);
	var_03 = var_02;
	while(var_03 > 0)
	{
		var_04 = level scripts\common\utility::waittill_notify_or_timeout_return("debug_beat_speaker_defense",1);
		if(isdefined(var_04) && var_04 == "timeout")
		{
			var_03 = var_03 - 1;
			setomnvar("zm_speaker_defense_timer",var_03);
			continue;
		}

		setomnvar("zm_speaker_defense_timer",0);
		return;
	}
}

//Function Number: 103
func_12971(param_00,param_01)
{
	level endon("game_ended");
	level scripts\common\utility::waittill_any_timeout_1(param_00,"complete_defense","speaker_defense_failed");
	playsoundatpos(param_01.origin,"speaker_defense_tone_scrubbing_end");
	param_01 stoploopsound();
	setomnvar("zm_speaker_defense_timer",0);
	setomnvar("zm_speaker_defense_health",0);
	setomnvar("zm_speaker_defense_target",undefined);
	param_01 delete();
}

//Function Number: 104
func_6949(param_00)
{
	scripts\common\utility::func_6E2A("defense_sequence_active");
	level.var_5093 = gettime() - level.var_5093;
	scripts\cp\zombies\zombie_analytics::func_AF8A(level.wave_num,param_00.origin,level.var_5093,param_00.health);
	setomnvar("zm_ui_timer",0);
	param_00 waittill("trigger",var_01);
	var_01 playlocalsound("part_pickup");
	level.var_12FC8 = undefined;
	level.var_8BAD = 1;
	level notify("speaker_picked_up");
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("zm_special_item",3);
	}

	param_00 makeunusable();
	if(isdefined(level.frequency_device_clip.navrepulsor))
	{
		function_0278(level.frequency_device_clip.navrepulsor);
	}

	param_00 delete();
}

//Function Number: 105
func_4A1D()
{
	level.var_12B13 = scripts\common\utility::array_randomize(["speaker_tone_playback_01","speaker_tone_playback_02","speaker_tone_playback_03","speaker_tone_playback_04"]);
	level.var_5744 = [];
	level.alldjcenterstructs = [];
	var_00 = [(300,663,60),(660,335,60),(985,665,60),(647,792,116)];
	foreach(var_02 in var_00)
	{
		var_03 = scripts\common\utility::func_5D14(var_02,32,-300) + (0,0,48);
		var_04 = spawnstruct("script_origin",var_03);
		var_04.origin = var_03;
		var_04.script_noteworthy = "dj_quest_speaker_mid";
		var_04.var_55BA = 1;
		var_04.var_E1B9 = 0;
		var_04.var_D776 = 0;
		var_04.var_EE79 = "default";
		var_04.var_336 = "interaction";
		var_04.name = "center_speaker_locs";
		var_04.var_4C72 = 96;
		level.alldjcenterstructs[level.alldjcenterstructs.size] = var_04;
		level.var_5744[level.var_5744.size] = var_04;
	}
}

//Function Number: 106
func_23DB(param_00,param_01)
{
	param_00 endon("death");
	level.var_C1F3 = 0;
	func_54E0(param_01);
	for(;;)
	{
		level waittill("agent_spawned",var_02);
		if(isdefined(var_02.agent_type) && var_02.agent_type == "zombie_brute")
		{
			continue;
		}

		var_02 thread func_1887(var_02,1);
		if(level.var_C1F3 < 3)
		{
			if(isdefined(var_02.var_1096F) && var_02.var_1096F == "zombie" && !scripts\common\utility::istrue(var_02.var_1648))
			{
				func_24C9(var_02,param_01);
			}
		}
	}
}

//Function Number: 107
func_24C9(param_00,param_01)
{
	param_00.var_12E = param_01;
	param_00.var_1648 = 1;
	level.var_C1F3++;
	param_00 thread func_4E13(param_00,param_01);
}

//Function Number: 108
func_24BC(param_00,param_01)
{
	param_01 endon("death");
	param_00 endon("death");
	param_00 waittill("speaker_attacked");
	param_00.var_12E = scripts\common\utility::getclosest(param_00.origin,level.players);
	param_00.var_1648 = undefined;
	level.var_C1F3--;
	wait(3);
	func_7B10(param_01,param_00);
}

//Function Number: 109
func_4E13(param_00,param_01)
{
	param_01 endon("death");
	param_00 waittill("death");
	wait(3);
	level.var_C1F3--;
	func_7B10(param_01);
}

//Function Number: 110
func_54E0(param_00,param_01)
{
	foreach(var_03 in level.var_3CB5)
	{
		if(isdefined(param_01) && var_03 == param_01)
		{
			continue;
		}

		if(isdefined(var_03.agent_type) && var_03.agent_type == "zombie_brute")
		{
			continue;
		}

		if(isdefined(var_03.var_1096F) && var_03.var_1096F == "zombie" && !scripts\common\utility::istrue(var_03.var_1648))
		{
			func_24C9(var_03,param_00);
			if(level.var_C1F3 >= 3)
			{
				break;
			}
		}
	}
}

//Function Number: 111
func_7B10(param_00,param_01)
{
	foreach(var_03 in level.var_3CB5)
	{
		if(isdefined(param_01) && var_03 == param_01)
		{
			continue;
		}

		if(isdefined(var_03.agent_type) && var_03.agent_type == "zombie_brute")
		{
			continue;
		}

		if(isdefined(var_03.var_1096F) && var_03.var_1096F == "zombie" && !scripts\common\utility::istrue(var_03.var_1648))
		{
			func_24C9(var_03,param_00);
			if(level.var_C1F3 >= 3)
			{
				break;
			}
		}
	}
}

//Function Number: 112
func_4157(param_00)
{
	param_00.var_9292 delete();
	foreach(var_02 in param_00.var_8423)
	{
		if(isdefined(var_02))
		{
			var_02 destroy();
			var_02 scripts\cp\zombies\zombie_afterlife_arcade::func_E01E(var_02.var_222,var_02);
		}
	}
}

//Function Number: 113
playspeakerdefencefailsound()
{
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	self endon("play_vo_speaker_defence");
	var_00 = scripts\common\utility::getstructarray("dj_quest_door","script_noteworthy");
	for(;;)
	{
		level.var_572A waittill("state_changed",var_01);
		if(var_01 == "close_window")
		{
			wait(5);
			self playlocalsound("dj_quest_ufo_speakerdefense_fail");
			self notify("play_vo_speaker_defence");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 114
func_5094(param_00)
{
	scripts\common\utility::func_6E2A("dj_request_defense_done");
	level.frequency_device_clip method_80F7();
	level.frequency_device_clip dontinterpolate();
	level.frequency_device_clip.origin = level.frequency_device_clip.originalloc;
	foreach(var_02 in level.players)
	{
		var_02 thread playspeakerdefencefailsound();
		var_02 setclientomnvar("zm_special_item",2);
	}

	level notify("speaker_defense_failed");
	level thread scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_CD0D();
	scripts\common\utility::func_6E2A("defense_sequence_active");
	func_4144();
	setomnvar("zm_ui_timer",0);
	if(isdefined(level.current_speaker))
	{
		level.current_speaker = undefined;
	}

	param_00 makeunusable();
	if(isdefined(level.frequency_device_clip.navrepulsor))
	{
		function_0278(level.frequency_device_clip.navrepulsor);
	}

	level.var_12FC8 = ::func_12FC5;
	level thread func_3E89();
	level.fake_players = scripts\common\utility::func_22A9(level.fake_players,level.frequency_device_clip);
	param_00 delete();
}

//Function Number: 115
func_5096(param_00)
{
	level.frequency_device_clip dontinterpolate();
	level.frequency_device_clip.origin = level.frequency_device_clip.originalloc;
	var_01 = scripts\common\utility::getstructarray("dj_quest_door","script_noteworthy");
	level.var_12FC8 = ::func_12FCA;
	func_4144();
	level.frequency_device_clip method_80F7();
	var_02 = &"CP_QUEST_WOR_PART";
	param_00 sethintstring(var_02);
	param_00 makeusable();
	if(isdefined(level.current_speaker))
	{
		level.current_speaker = undefined;
	}

	foreach(var_04 in level.players)
	{
		var_04 scripts\cp\_persistence::give_player_xp(250,1);
		param_00 notify("speaker_defense_completed");
		level notify("speaker_defense_completed");
	}

	level.fake_players = scripts\common\utility::func_22A9(level.fake_players,level.frequency_device_clip);
}

//Function Number: 116
func_1602()
{
	foreach(var_01 in level.alldjcenterstructs)
	{
		var_01.var_55BA = undefined;
		if(!scripts\common\utility::func_2286(level.current_interaction_structs,var_01))
		{
			scripts\cp\_interaction::add_to_current_interaction_list(var_01);
		}
	}
}

//Function Number: 117
func_4DDD()
{
	foreach(var_01 in level.alldjcenterstructs)
	{
		var_01.var_55BA = 1;
		scripts\cp\_interaction::remove_from_current_interaction_list(var_01);
	}
}

//Function Number: 118
func_160C()
{
	foreach(var_01 in level.var_5744)
	{
		var_01.var_55BA = undefined;
		scripts\cp\_interaction::add_to_current_interaction_list(var_01);
	}
}

//Function Number: 119
func_4DDF()
{
	foreach(var_01 in level.var_5744)
	{
		var_01.var_55BA = 1;
		scripts\cp\_interaction::remove_from_current_interaction_list(var_01);
	}
}

//Function Number: 120
func_136D9(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_00.placed))
	{
		if(isdefined(level.var_106E2) && level.var_106E2)
		{
			func_CE6B(param_00,param_01,0);
			return;
		}

		if(scripts\common\utility::flag("all_structs_placed"))
		{
			func_CE6B(param_00,param_01,1);
			return;
		}

		func_CE6B(param_00,param_01,0);
		return;
	}

	func_CC03(param_00);
}

//Function Number: 121
func_CC03(param_00)
{
	param_00.placed = 1;
	var_01 = spawn("script_model",param_00.origin);
	var_01.origin = scripts\common\utility::func_5D14(param_00.origin,32,-400);
	var_01.angles = (270,0,-90);
	var_01 setmodel("zmb_tone_speaker");
	param_00.model = var_01;
	param_00.model setscriptablepartstate("tone","neutral");
	param_00.var_119D9 = level.var_12B13[level.var_5744.size - 1];
	level.var_5744 = scripts\common\utility::func_22A9(level.var_5744,param_00);
	playsoundatpos(var_01.origin,"sentry_gun_plant");
	if(level.var_5744.size == 0)
	{
		scripts\common\utility::flag_set("all_structs_placed");
		foreach(var_03 in level.players)
		{
			var_03 setclientomnvar("zm_special_item",4);
		}
	}
}

//Function Number: 122
func_CE6B(param_00,param_01,param_02)
{
	playsoundatpos(param_00.origin,param_00.var_119D9);
	var_03 = strtok(param_00.var_119D9,"_");
	param_01 thread lib_0D5E::func_778A("ges_devil_horns_zm",undefined,0,0.5);
	level notify("tone_played",var_03[3],param_00);
	if(scripts\common\utility::istrue(param_02))
	{
		level thread func_136A9(param_00);
	}
}

//Function Number: 123
func_F5E6()
{
	level.generic_zombie_model_override_list = ["zombie_male_park_worker","zombie_male_park_worker_a","zombie_male_park_worker_b","zombie_male_park_worker_c"];
}

//Function Number: 124
func_4144()
{
	level.generic_zombie_model_override_list = undefined;
}

//Function Number: 125
func_2B53()
{
}

//Function Number: 126
func_F93E(param_00)
{
	if(!isdefined(level.var_572A))
	{
		level scripts\common\utility::waittill_any_3("power_on","moon power_on");
		level.var_1628 = scripts\common\utility::getstruct(param_00.target,"targetname");
		level.var_1627 = scripts\common\utility::getclosest(level.var_1628.origin,getentarray("dj_doors","targetname"));
		level.var_134DC["zmb_dj_vo"] = ::func_572D;
		func_106A7();
		level thread func_573F(level.var_572A);
		func_F35B("open_window");
		return;
	}

	if(!isdefined(level.var_550B))
	{
		func_F35B("close_window");
		level.var_572A waittill("window_closed");
		return;
	}

	level.var_1628 = scripts\common\utility::getstruct(param_00.target,"targetname");
	level.var_1627 = scripts\common\utility::getclosest(level.var_1628.origin,getentarray("dj_doors","targetname"));
	func_F35B("open_window");
}

//Function Number: 127
func_572D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(level.var_550B))
	{
		return;
	}

	if(!isdefined(level.var_572A.var_4BBE))
	{
		return;
	}

	while(scripts\cp\_vo::func_9D13() && !isdefined(level.var_5741))
	{
		wait(0.1);
	}

	if(scripts\common\utility::istrue(param_04))
	{
		level.var_572A notify("end_dj_broadcast_handler");
		level.var_5741 = undefined;
		foreach(var_08 in level.players)
		{
			var_08 scripts\cp\_vo::func_F60D(0);
			var_08.var_13518 = 0;
		}

		level func_7948();
	}

	if(isdefined(level.var_5741))
	{
		return;
	}

	level.var_572A endon("end_dj_broadcast_handler");
	level.var_5741 = 1;
	scripts\cp\_vo::func_F60C(1);
	while(scripts\cp\_music_and_dialog::func_134DF())
	{
		wait(0.1);
	}

	level.var_572A thread func_636D("approach_mic");
	level.var_572A thread func_5732(30);
	level.var_572A func_F35B("approach_mic");
	func_CCDF(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	level.var_5741 = undefined;
	scripts\cp\_vo::func_F60C(0);
	foreach(var_08 in level.players)
	{
		var_08 scripts\cp\_vo::func_F60D(0);
	}

	func_F35B("exit_mic");
	level.var_572A notify("finished_dj_broadcast");
	level.var_572E = undefined;
}

//Function Number: 128
func_CCDF(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	level.var_572A endon("end_dj_broadcast_early");
	if(level.var_572A.var_4BBE != "at_mic")
	{
		level.var_572A waittill("at_mic");
	}

	level.var_572E = 1;
	var_07 = scripts\cp\_vo::func_4978(param_00,param_03,param_05,param_06);
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

		var_09 thread scripts\cp\_vo::func_CE8B(var_07);
	}

	level.var_CF2F[param_00] = 1;
	wait(scripts\cp\_vo::func_7C76(param_00));
}

//Function Number: 129
func_7948()
{
	level.var_572A endon("end_dj_broadcast_handler");
	switch(level.var_572A.var_4BBE)
	{
		case "open_window":
			func_F35B("idle");
			break;

		case "approach_mic":
			while(level.var_572A.var_4BBE != "mic_loop")
			{
				wait(0.1);
			}
	
			break;

		case "mic_loop":
			func_F35B("exit_mic");
			break;

		case "exit_mic":
			break;
	}

	while(level.var_572A.var_4BBE != "idle")
	{
		wait(0.1);
	}
}

//Function Number: 130
func_636D(param_00)
{
	level.var_572A endon("finished_dj_broadcast");
	level.var_572A waittill("state_changed",var_01);
	if(param_00 != var_01)
	{
		level.var_572A notify("end_dj_broadcast_early");
	}
}

//Function Number: 131
func_5732(param_00)
{
	level.var_572A endon("finished_dj_broadcast");
	level.var_572A endon("at_mic");
	wait(param_00);
	level.var_572A notify("end_dj_broadcast_early");
}

//Function Number: 132
func_106A7()
{
	level.var_572A = spawn("script_model",level.var_1628.origin);
	level.var_572A.angles = level.var_1628.angles;
	level.var_572A setmodel("fullbody_zmb_hero_dj");
	level.var_5740 = [];
	level.var_5740["open_window"] = ::func_5737;
	level.var_5740["close_window"] = ::func_572F;
	level.var_5740["idle"] = ::func_5734;
	level.var_5740["vo"] = ::func_573D;
	level.var_5740["approach_mic"] = ::func_572B;
	level.var_5740["exit_mic"] = ::func_5733;
	level.var_5740["mic_loop"] = ::func_5736;
}

//Function Number: 133
func_573F(param_00)
{
	level endon("stop_dj_manager");
	for(;;)
	{
		if(!isdefined(level.var_572A.var_5276))
		{
			wait(0.05);
		}

		level.var_572A notify("state_changed",level.var_572A.var_5276);
		switch(level.var_572A.var_5276)
		{
			case "open_window":
				[[ level.var_5740["open_window"] ]]();
				func_F35B("idle");
				break;
	
			case "dance":
			case "exit_mic":
			case "mic_loop":
			case "close_window":
			case "approach_mic":
			case "idle":
				[[ level.var_5740[level.var_572A.var_5276] ]]();
				break;
		}

		wait(0.05);
	}
}

//Function Number: 134
func_F35B(param_00)
{
	level.var_572A.var_5276 = param_00;
}

//Function Number: 135
func_5735()
{
	var_00 = 1;
	for(;;)
	{
		level thread scripts\cp\_vo::try_to_play_vo("dj_fateandfort_replenish_nag","zmb_dj_vo","high",20,1,0,1);
		wait(2);
	}
}

//Function Number: 136
func_5737()
{
	level.var_572A.var_4BBE = "open_window";
	func_12990();
	var_00 = getanimlength(%iw7_cp_zom_hoff_dj_window_open);
	level.var_572A scriptmodelplayanimdeltamotionfrompos("IW7_cp_zom_hoff_dj_window_open",level.var_1628.origin,level.var_1628.angles);
	level.var_1627 movez(29,0.75);
	wait(var_00 - 0.15);
}

//Function Number: 137
func_572F()
{
	level.var_572A.var_4BBE = "close_window";
	func_1296D();
	var_00 = getanimlength(%iw7_cp_zom_hoff_dj_window_close);
	level.var_572A scriptmodelplayanimdeltamotionfrompos("IW7_cp_zom_hoff_dj_window_close",level.var_1628.origin,level.var_1628.angles);
	wait(2.25);
	level.var_1627 movez(-29,0.75);
	wait(var_00);
	level.var_572A notify("window_closed");
}

//Function Number: 138
func_5734()
{
	level.var_572A.var_4BBE = "idle";
	var_00 = scripts\common\utility::random([%iw7_cp_zom_hoff_dj_desk_01,%iw7_cp_zom_hoff_dj_desk_02,%iw7_cp_zom_hoff_dj_desk_03,%iw7_cp_zom_hoff_dj_desk_04,%iw7_cp_zom_hoff_dj_desk_05,%iw7_cp_zom_hoff_dj_desk_06]);
	var_01 = %iw7_cp_zom_hoff_dj_idle_01;
	var_02 = var_01;
	if(randomint(100) > 80)
	{
		var_02 = var_00;
	}

	var_03 = getanimlength(var_02);
	level.var_572A scriptmodelplayanimdeltamotionfrompos(var_02,level.var_1628.origin,level.var_1628.angles);
	wait(var_03 - 0.1);
}

//Function Number: 139
func_572B()
{
	level.var_572A.var_4BBE = "approach_mic";
	var_00 = getanimlength(%iw7_cp_zom_hoff_dj_vo_06_enter);
	level.var_572A scriptmodelplayanimdeltamotionfrompos("IW7_cp_zom_hoff_dj_vo_06_enter",level.var_1628.origin,level.var_1628.angles);
	wait(var_00);
	level.var_572A notify("at_mic");
	func_F35B("mic_loop");
}

//Function Number: 140
func_5733()
{
	level.var_572A.var_4BBE = "exit_mic";
	var_00 = getanimlength(%iw7_cp_zom_hoff_dj_vo_06_exit);
	level.var_572A scriptmodelplayanimdeltamotionfrompos("IW7_cp_zom_hoff_dj_vo_06_exit",level.var_1628.origin,level.var_1628.angles);
	wait(var_00);
	func_F35B("idle");
}

//Function Number: 141
func_5736()
{
	level.var_572A.var_4BBE = "mic_loop";
	var_00 = [%iw7_cp_zom_hoff_dj_vo_06,%iw7_cp_zom_hoff_dj_vo_05,%iw7_cp_zom_hoff_dj_vo_04,%iw7_cp_zom_hoff_dj_vo_03,%iw7_cp_zom_hoff_dj_vo_02,%iw7_cp_zom_hoff_dj_vo_01];
	var_01 = ["IW7_cp_zom_hoff_dj_vo_05","IW7_cp_zom_hoff_dj_vo_04","IW7_cp_zom_hoff_dj_vo_03","IW7_cp_zom_hoff_dj_vo_02","IW7_cp_zom_hoff_dj_vo_01","IW7_cp_zom_hoff_dj_vo_06"];
	var_02 = scripts\common\utility::random(var_01);
	var_03 = undefined;
	switch(var_02)
	{
		case "IW7_cp_zom_hoff_dj_vo_06":
			var_03 = %iw7_cp_zom_hoff_dj_vo_06;
			break;

		case "IW7_cp_zom_hoff_dj_vo_05":
			var_03 = %iw7_cp_zom_hoff_dj_vo_05;
			break;

		case "IW7_cp_zom_hoff_dj_vo_04":
			var_03 = %iw7_cp_zom_hoff_dj_vo_04;
			break;

		case "IW7_cp_zom_hoff_dj_vo_03":
			var_03 = %iw7_cp_zom_hoff_dj_vo_03;
			break;

		case "IW7_cp_zom_hoff_dj_vo_02":
			var_03 = %iw7_cp_zom_hoff_dj_vo_02;
			break;

		case "IW7_cp_zom_hoff_dj_vo_01":
			var_03 = %iw7_cp_zom_hoff_dj_vo_01;
			break;
	}

	var_04 = getanimlength(var_03);
	level.var_572A scriptmodelplayanimdeltamotionfrompos(var_02,level.var_1628.origin,level.var_1628.angles);
	wait(var_04);
}

//Function Number: 142
func_573D()
{
}

//Function Number: 143
func_12990(param_00)
{
	var_01 = scripts\common\utility::getclosest(level.var_1627.origin,getentarray("cosmic_tunes","targetname"));
	var_01 setscriptablepartstate("sign","on");
}

//Function Number: 144
func_1296D(param_00)
{
	var_01 = scripts\common\utility::getclosest(level.var_1627.origin,getentarray("cosmic_tunes","targetname"));
	var_01 setscriptablepartstate("sign","off");
}