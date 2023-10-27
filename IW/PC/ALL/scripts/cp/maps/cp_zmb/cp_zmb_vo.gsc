/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_vo.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 1816 ms
 * Timestamp: 10/27/2023 12:08:35 AM
*******************************************************************/

//Function Number: 1
zmb_vo_init()
{
	level.var_DDBC = [];
	level.var_2001 = 0;
	level.var_D336 = 0;
	level.var_10815 = ::func_10DB3;
	level.var_ABE9 = ::func_13F08;
	level.pap_vo_approve_func = ::is_vo_in_pap;
	level.get_alias_2d_func = ::scripts\cp\_vo::func_77ED;
	level thread func_13F08();
	level.var_5472 = [];
	level thread func_12E45();
	level waittill("activate_power");
	level thread func_13539();
}

//Function Number: 2
func_13F08(param_00)
{
	level.var_134DC["zmb_announcer_vo"] = ::func_2000;
	level.var_134DC["zmb_ww_vo"] = ::func_13E0C;
	level.var_134DC["zmb_powerup_vo"] = ::func_CE7E;
	level.var_134DC["zmb_afterlife_vo"] = ::func_18E9;
	level.var_134DC["zmb_pap_vo"] = ::pap_vo_handler;
	level.var_134DC["zmb_intro_dialogue_vo"] = ::func_433D;
	level.var_134DC["zmb_dialogue_vo"] = ::func_549B;
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
func_549B(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!scripts\cp\_music_and_dialog::func_3837())
	{
		return;
	}

	var_07 = isdefined(level.var_134B4[param_00]);
	scripts\cp\_vo::func_F60C(1);
	var_08 = scripts\cp\_music_and_dialog::func_7DD2(param_00,var_07);
	level.var_540D = var_08;
	while(scripts\cp\_music_and_dialog::func_134DF())
	{
		wait(0.1);
	}

	foreach(var_0A in var_08)
	{
		var_0B = 0;
		var_0C = undefined;
		if(var_07 && isdefined(level.var_134B4[var_0A].var_54AA))
		{
			var_0C = level.var_134B4[var_0A].var_54AA;
			var_0D = var_0C + var_0A;
		}
		else if(issubstr(var_0A,"ww_"))
		{
			var_0D = var_0A;
			var_0B = 1;
		}
		else
		{
			continue;
		}

		foreach(var_0F in level.players)
		{
			if((isdefined(var_0C) && var_0F.var_134FD == var_0C) || var_0B || getdvarint("scr_solo_dialogue",0) == 1)
			{
				var_10 = scripts\cp\_vo::func_4978(var_0D,param_03,param_05,param_06);
				var_0F scripts\cp\_vo::func_F60D(1);
				var_0F scripts\cp\_vo::func_F60B(var_10);
				var_0F scripts\cp\_vo::func_CE77(var_10);
				var_0F scripts\cp\_vo::func_C9B8(var_10);
				var_0F scripts\cp\_vo::func_12C63();
				break;
			}
		}

		scripts\common\utility::func_136F7();
	}

	foreach(var_0F in level.players)
	{
		var_0F scripts\cp\_vo::func_F60D(0);
	}

	scripts\cp\_vo::func_F60C(0);
}

//Function Number: 9
func_433D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	wait(6);
	scripts\cp\_vo::func_F60C(1);
	foreach(var_08 in level.players)
	{
		var_08 thread func_CE99(var_08);
	}

	scripts\common\utility::flag_wait("dialogue_done");
	scripts\cp\_vo::func_F60C(0);
}

//Function Number: 10
func_CE99(param_00)
{
	param_00 func_D5D8("ww_spawn_alt_first_1",param_00);
	param_00 func_D4FC("plr_spawn_alt_first_2",param_00);
	param_00 func_D5D8("ww_spawn_alt_first_6",param_00);
	if(param_00.var_134FD == "p4_")
	{
		param_00 func_D4FC("plr_spawn_alt_first_7",param_00);
	}
	else
	{
		param_00 playlocalsound("p4_spawn_alt_first_7");
		wait(scripts\cp\_vo::func_7C76("p4_spawn_alt_first_7"));
	}

	param_00 func_D5D8("ww_spawn_alt_first_8",param_00);
	scripts\common\utility::flag_set("dialogue_done");
}

//Function Number: 11
func_D5D8(param_00,param_01)
{
	param_01 playlocalsound(param_00);
	wait(scripts\cp\_vo::func_7C76(param_00));
}

//Function Number: 12
func_D4FC(param_00,param_01)
{
	if(isdefined(param_01))
	{
		if(isdefined(param_01.var_134FD))
		{
			param_01 playlocalsound(param_01.var_134FD + param_00);
		}
	}

	wait(scripts\cp\_vo::func_7C76(param_01.var_134FD + param_00));
}

//Function Number: 13
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

//Function Number: 14
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

//Function Number: 15
func_13E0C(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	level endon(param_00 + "_timed_out");
	if(isdefined(level.special_character_count_ww) && level.special_character_count_ww > 0 && issubstr(param_00,"powerup"))
	{
		return;
	}

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

//Function Number: 16
func_2000(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	func_CC8F(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 17
is_vo_in_pap(param_00)
{
	if(isdefined(level.var_134B4[param_00].pap_approval))
	{
		if(level.var_134B4[param_00].pap_approval == 1)
		{
			if(lib_0D4E::is_in_pap_room(self))
			{
				return 1;
			}

			return 0;
		}

		return 1;
	}

	return 1;
}

//Function Number: 18
func_B798(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		var_02 = scripts\cp\_utility::func_7833();
		if(var_02.size < 1)
		{
			return;
		}

		param_00 = var_02[0];
	}

	if(self == param_00)
	{
		if(!isdefined(param_00.var_DDBC))
		{
			self.var_DDBC = [];
			thread func_12E22();
		}

		if(scripts\common\utility::istrue(param_00.var_DDBC[param_01]))
		{
			return;
		}

		param_00 func_1779(param_01);
		func_CD98(param_00,param_01);
		return;
	}

	if(scripts\common\utility::istrue(level.var_DDBC[param_01]))
	{
		return;
	}

	func_177A(param_01);
	func_CD98(param_00,param_01);
}

//Function Number: 19
func_CD98(param_00,param_01,param_02)
{
	if(!soundexists(param_01))
	{
		wait(0.1);
		return;
	}

	param_00 playlocalsound(param_01);
}

//Function Number: 20
func_CC8F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	level.var_2001 = 1;
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

	func_1094A(param_00);
	level.var_2001 = 0;
}

//Function Number: 21
func_1094A(param_00)
{
	if(param_00 == "dj_jingle_intro")
	{
		level notify("jukebox_start");
	}
}

//Function Number: 22
func_CE7E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	wait(0.5);
	if(scripts\common\utility::istrue(level.directors_cut_is_activated) && isdefined(level.special_character_count_ww) && level.special_character_count_ww > 0)
	{
		func_2000("dj_" + param_00,"zmb_ww_vo","highest",60,0,0,1);
	}
	else
	{
		func_2000("ww_" + param_00,"zmb_ww_vo","highest",60,0,0,1);
	}

	param_00 = func_45EA(param_00);
	foreach(var_08 in level.players)
	{
		if(isdefined(var_08) && isalive(var_08))
		{
			var_08 thread scripts\cp\_vo::try_to_play_vo(param_00,"zmb_comment_vo");
		}
	}
}

//Function Number: 23
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

//Function Number: 24
func_D338()
{
	for(;;)
	{
		level waittill("volume_activated",var_00);
		switch(var_00)
		{
			case "moon":
				break;
	
			case "mars_3":
			case "europa_tunnel":
			case "arcade":
			case "moon_rocket_space":
				break;
		}
	}
}

//Function Number: 25
func_13BC4()
{
	for(;;)
	{
		level waittill("wave_starting");
		if(level.wave_num > 3)
		{
			break;
		}
	}
}

//Function Number: 26
func_13539()
{
	for(;;)
	{
		level waittill("volume_activated",var_00);
		switch(var_00)
		{
			case "moon":
				if(scripts\common\utility::istrue(level.directors_cut_is_activated) && !scripts\common\utility::istrue(level.played_once))
				{
					level.played_once = 1;
					var_01 = ["dj_dc_dj_hoff","dj_dc_intro"];
					var_02 = scripts\common\utility::random(var_01);
					level thread scripts\cp\_vo::try_to_play_vo(var_02,"zmb_dj_vo","high",20,0,0,1);
					var_03 = scripts\cp\_vo::func_7C76(var_02);
					if(isdefined(var_03))
					{
						wait(var_03 + 25);
					}
		
					if(isdefined(level.special_character_count_ww) && level.special_character_count_ww > 0)
					{
						foreach(var_05 in level.players)
						{
							var_05 thread play_willard_dj_exchange(var_05);
						}
					}
				}
				else
				{
					var_01 = ["dj_music_next","dj_music_set","dj_interup_wave_start"];
					level thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_01),"zmb_dj_vo","high",20,0,0,1);
				}
		
				level thread scripts\cp\_vo::try_to_play_vo("spawn_dj_first_1","zmb_dialogue_vo","highest",666,0,0,0,100);
				foreach(var_08 in level.players)
				{
					var_08 thread scripts\cp\_vo::func_1769("nag_board_windows","zmb_comment_vo",180,60,20,1);
				}
				break;
	
			case "mars_3":
			case "arcade":
			case "moon_rocket_space":
				break;
	
			case "europa_tunnel":
				break;
		}
	}
}

//Function Number: 27
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

//Function Number: 28
play_willard_dj_exchange(param_00)
{
	self endon("disconnect");
	clear_up_all_vo(param_00);
	scripts\cp\_vo::func_C9CB([param_00]);
	level.var_572A scripts\cp\maps\cp_zmb\cp_zmb_dj::func_F35B("approach_mic");
	if(param_00.var_134FD == "p6_")
	{
		param_00 playlocalsound("p6_plr_spawn_dj_first_1");
	}
	else
	{
		param_00 playlocalsound("p6_spawn_dj_first_1");
	}

	wait(scripts\cp\_vo::func_7C76("p6_spawn_dj_first_1"));
	param_00 playlocalsound("dj_spawn_dj_first_2");
	wait(scripts\cp\_vo::func_7C76("dj_spawn_dj_first_2"));
	if(param_00.var_134FD == "p6_")
	{
		param_00 playlocalsound("p6_plr_spawn_dj_first_3");
	}
	else
	{
		param_00 playlocalsound("p6_spawn_dj_first_3");
	}

	wait(scripts\cp\_vo::func_7C76("p6_spawn_dj_first_3"));
	param_00 playlocalsound("dj_spawn_dj_first_4");
	wait(scripts\cp\_vo::func_7C76("dj_spawn_dj_first_4"));
	foreach(param_00 in level.players)
	{
		if(param_00.var_134FD == "p6_")
		{
			param_00 playlocalsound("p6_plr_spawn_dj_first_5");
			continue;
		}

		param_00 playlocalsound("p6_spawn_dj_first_5");
	}

	wait(scripts\cp\_vo::func_7C76("p6_spawn_dj_first_5"));
	param_00 playlocalsound("dj_spawn_dj_first_6");
	wait(scripts\cp\_vo::func_7C76("dj_spawn_dj_first_6"));
	scripts\cp\_vo::func_12BE3([param_00]);
	level.var_572A scripts\cp\maps\cp_zmb\cp_zmb_dj::func_F35B("open_window");
}

//Function Number: 29
func_13D1F()
{
	level endon("game_ended");
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		return;
	}

	level waittill("wave_start_sound_done");
	if(scripts\common\utility::istrue(level.directors_cut_is_activated))
	{
		if(isdefined(level.special_character_count_ww) && level.special_character_count_ww > 0)
		{
			if(scripts\common\utility::flag("power_on"))
			{
				level thread scripts\cp\_vo::try_to_play_vo("dj_dc_intro","zmb_dj_vo","highest",30,0,0,1,100);
				return;
			}

			level.var_550B = 1;
			if(isdefined(level.var_572A))
			{
				playsoundatpos(level.var_572A.origin,"dj_dc_intro");
			}

			wait(scripts\cp\_vo::func_7C76("dj_dc_intro"));
			level.var_550B = undefined;
			return;
		}

		level thread scripts\cp\_vo::try_to_play_vo("ww_zmb_dc_intro","zmb_ww_vo","highest",30,0,0,1,100);
		return;
	}

	level thread scripts\cp\_vo::try_to_play_vo("ww_intro","zmb_ww_vo","highest",30,0,0,1,100);
}

//Function Number: 30
power_nag()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("wave_start_sound_done");
		var_00 = scripts\cp\maps\cp_zmb\cp_zmb_environment_scriptable::func_9B5F();
		if(var_00)
		{
			return;
		}

		if(level.wave_num > 0 && level.wave_num % 3 == 0)
		{
			scripts\cp\_vo::try_to_play_vo_on_all_players("nag_activate_power");
			continue;
		}
	}
}

//Function Number: 31
purchase_team_buy_vos(param_00,param_01)
{
	switch(param_00.script_side)
	{
		case "moon":
			if(level.moon_donations == 3)
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_door_journey","zmb_comment_vo","low",10,0,0,0,40);
			}
			break;

		case "kepler":
			if(level.kepler_donations == 3)
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_door_keppler","zmb_comment_vo","low",10,0,0,0,70);
			}
			break;

		case "triton":
			if(level.triton_donations == 3)
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_door_triton","zmb_comment_vo","low",10,0,0,0,70);
			}
			break;
	}
}

//Function Number: 32
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

	switch(param_00)
	{
		case "moon":
		case "front_gate":
			if(!isdefined(level.played_area_vos[param_00]))
			{
				level.played_area_vos[param_00] = 1;
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_door_mainstreet","zmb_comment_vo","low",10,0,0,0,40);
			}
			break;

		case "swamp_stage":
			if(!isdefined(level.played_area_vos[param_00]))
			{
				level.played_area_vos[param_00] = 1;
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area_underground","zmb_comment_vo","low",10,0,0,0,40);
			}
			else
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area","zmb_comment_vo","low",10,0,0,1,40);
			}
	
			break;

		case "underground_route":
			if(!isdefined(level.played_area_vos[param_00]))
			{
				level.played_area_vos[param_00] = 1;
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area_underground","zmb_comment_vo","low",10,0,0,0,40);
			}
			else
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area","zmb_comment_vo","low",10,0,0,1,40);
			}
			break;

		case "arcade":
			if(!isdefined(level.played_area_vos[param_00]))
			{
				level.played_area_vos[param_00] = 1;
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area_astrocade","zmb_comment_vo","low",10,0,0,0,40);
			}
			else
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area","zmb_comment_vo","low",10,0,0,1,40);
			}
			break;

		default:
			if(level.players.size > 1)
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area","zmb_comment_vo","low",10,0,0,1,40);
			}
			else
			{
				level.players[0] thread scripts\cp\_vo::try_to_play_vo("purchase_area","zmb_comment_vo","low",10,0,0,1,40);
			}
			break;
	}
}

//Function Number: 33
multiple_hoffs_intro_vo(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(scripts\common\utility::istrue(level.directors_cut_is_activated) || getdvarint("scr_solo_ww_dialogue",0) != 0)
	{
		if(isdefined(level.special_character_count_ww) && level.special_character_count_ww > 0)
		{
			if(isdefined(level.special_character_count) && level.special_character_count > 0)
			{
				var_01 = scripts\common\utility::random(["spawn_addtl_celebs_1_1","spawn_addtl_celebs_2_1"]);
				level thread scripts\cp\_vo::try_to_play_vo(var_01,"zmb_dialogue_vo","highest",666,0,0,0,100);
				return;
			}

			switch(level.special_character_count_ww)
			{
				case 1:
					if(randomint(100) > 50)
					{
						param_00 thread scripts\cp\_vo::try_to_play_vo("spawn_intro","zmb_comment_vo");
					}
					else
					{
						param_00 thread scripts\cp\_vo::try_to_play_vo("spawn_solo_first","zmb_comment_vo");
					}
					break;

				case 2:
					param_00 thread scripts\cp\_vo::try_to_play_vo("extra_willard_2","zmb_comment_vo");
					break;

				case 3:
					param_00 thread scripts\cp\_vo::try_to_play_vo("extra_willard_3","zmb_comment_vo");
					break;

				case 4:
					param_00 thread scripts\cp\_vo::try_to_play_vo("extra_willard_4","zmb_comment_vo");
					break;

				default:
					break;
			}

			return;
		}

		return;
	}

	if(!isdefined(level.special_character_count))
	{
		return;
	}

	switch(level.special_character_count)
	{
		case 1:
			param_00 thread scripts\cp\_vo::try_to_play_vo("afterlife_first","zmb_comment_vo");
			break;

		case 2:
			param_00 thread scripts\cp\_vo::try_to_play_vo("extra_hasselhoff_2","zmb_comment_vo");
			break;

		case 3:
			param_00 thread scripts\cp\_vo::try_to_play_vo("extra_hasselhoff_3","zmb_comment_vo");
			break;

		case 4:
			param_00 thread scripts\cp\_vo::try_to_play_vo("extra_hasselhoff_4","zmb_comment_vo");
			break;

		default:
			break;
	}
}

//Function Number: 34
func_10DB3()
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

		if(var_00 <= 70)
		{
			level thread scripts\cp\_vo::try_to_play_vo("spawn_team_first_1","zmb_dialogue_vo","highest",666,0,0,0,100);
			level thread func_13D1F();
			return;
		}

		level thread scripts\cp\_vo::try_to_play_vo("ww_spawn_alt_first_1","zmb_intro_dialogue_vo","highest",666,0,0,0,100);
		return;
	}

	if(level.players.size > 1)
	{
		foreach(var_02 in level.players)
		{
			if(var_02 issplitscreenplayer())
			{
				if(var_02 issplitscreenplayerprimary())
				{
					if(isdefined(var_02.var_134FD))
					{
						if(var_02.var_134FD == "p5_" || var_02.var_134FD == "p6_")
						{
							var_02 multiple_hoffs_intro_vo(var_02);
						}
						else
						{
							var_02 thread scripts\cp\_vo::try_to_play_vo("spawn_team_first","zmb_comment_vo","high",20,0,0,1);
						}
					}
				}

				continue;
			}

			if(isdefined(var_02.var_134FD))
			{
				if(var_02.var_134FD == "p5_" || var_02.var_134FD == "p6_")
				{
					var_02 multiple_hoffs_intro_vo(var_02);
					continue;
				}

				var_02 thread scripts\cp\_vo::try_to_play_vo("spawn_team_first","zmb_comment_vo","high",20,0,0,1);
			}
		}

		level thread func_13D1F();
		return;
	}

	var_04 = scripts\common\utility::random(["spawn_intro","spawn_solo_first"]);
	level.players[0] thread scripts\cp\_vo::try_to_play_vo(var_04,"zmb_comment_vo","high",20,0,0,1);
	level thread func_13D1F();
}