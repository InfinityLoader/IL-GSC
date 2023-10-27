/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_rave\cp_rave_vo.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 1983 ms
 * Timestamp: 10/27/2023 12:06:42 AM
*******************************************************************/

//Function Number: 1
rave_vo_init()
{
	level.var_DDBC = [];
	level.var_2001 = 0;
	level.var_D336 = 0;
	level.var_10815 = ::func_10DB3;
	level.var_ABE9 = ::rave_vo_callouts;
	level.pap_vo_approve_func = ::is_vo_in_pap;
	level.get_alias_2d_func = ::scripts\cp\_vo::func_77ED;
	level.rave_vo_approve_func = ::is_vo_in_rave;
	level thread rave_vo_callouts();
	level.var_5472 = [];
	level thread func_12E45();
	level waittill("activate_power");
	level thread func_13539();
}

//Function Number: 2
rave_vo_callouts(param_00)
{
	level.var_134DC["rave_announcer_vo"] = ::func_2000;
	level.var_134DC["rave_ww_vo"] = ::func_13E0C;
	level.var_134DC["zmb_powerup_vo"] = ::func_CE7E;
	level.var_134DC["zmb_afterlife_vo"] = ::func_18E9;
	level.var_134DC["rave_pap_vo"] = ::pap_vo_handler;
	level.var_134DC["rave_mode_vo"] = ::rave_vo_handler;
	level.var_134DC["rave_intro_dialogue_vo"] = ::func_433D;
	level.var_134DC["rave_dialogue_vo"] = ::func_549B;
	level.var_134DC["rave_kevin_smith_dialogue_vo"] = ::one_to_one_dialogue_vo_handler;
	level.var_134DC["rave_ks_vo"] = ::ks_vo_handler;
	level.var_134DC["rave_memory_vo"] = ::memory_vo_handler;
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
one_to_one_dialogue_vo_handler(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = self;
	var_09 = isdefined(level.var_134B4[param_00]);
	scripts\cp\_vo::func_F60C(1);
	var_0A = scripts\cp\_music_and_dialog::func_7DD2(param_00,var_09);
	level.var_540D = var_0A;
	while(scripts\cp\_music_and_dialog::func_134DF())
	{
		wait(0.1);
	}

	if(scripts\common\utility::istrue(param_07))
	{
		var_08 play_special_vo_dialogue(var_0A,var_09,param_03,param_05,param_06,param_07);
		scripts\common\utility::func_136F7();
	}
	else
	{
		foreach(var_13, var_0C in var_0A)
		{
			var_0D = 0;
			var_0E = undefined;
			if(var_09 && isdefined(level.var_134B4[var_0C].var_54AA))
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

			foreach(var_08 in level.players)
			{
				if((isdefined(var_0E) && var_08.var_134FD == var_0E) || var_0D || getdvarint("scr_solo_dialogue",0) == 1)
				{
					var_11 = scripts\cp\_vo::func_4978(var_0F,param_03,param_05,param_06);
					var_08 scripts\cp\_vo::func_F60D(1);
					var_08 scripts\cp\_vo::func_F60B(var_11);
					var_08 scripts\cp\_vo::func_CE77(var_11);
					var_08 scripts\cp\_vo::func_C9B8(var_11);
					var_08 scripts\cp\_vo::func_12C63();
					break;
				}
			}

			scripts\common\utility::func_136F7();
		}
	}

	foreach(var_08 in level.players)
	{
		var_08 scripts\cp\_vo::func_F60D(0);
	}

	scripts\cp\_vo::func_F60C(0);
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

//Function Number: 12
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

//Function Number: 13
func_D5D8(param_00,param_01)
{
	param_01 playlocalsound(param_00);
	wait(scripts\cp\_vo::func_7C76(param_00));
}

//Function Number: 14
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

//Function Number: 15
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

//Function Number: 16
rave_vo_handler(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!scripts\cp\_vo::func_FF12(param_00))
	{
		thread scripts\cp\_vo::func_CE8A(param_00,param_02,param_03,param_04,param_05,param_06,param_00);
		return;
	}

	var_07 = self.var_134FD + param_00;
	thread scripts\cp\_vo::func_CE8A(var_07,param_02,param_03,param_04,param_05,param_06,param_00);
}

//Function Number: 17
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

//Function Number: 18
func_13E0C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
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

		var_0A = scripts\cp\_vo::func_4978(param_00,param_03,param_05,param_06);
		var_09 thread scripts\cp\_vo::func_CE8B(var_0A,param_07);
	}

	wait(scripts\cp\_vo::func_7C76(param_00));
	foreach(var_09 in level.players)
	{
		var_09 scripts\cp\_vo::func_F60D(0);
	}

	scripts\cp\_vo::func_F60C(0);
}

//Function Number: 19
func_2000(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	func_CC8F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 20
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

//Function Number: 21
is_vo_in_rave(param_00)
{
	if(isdefined(level.var_134B4[param_00].rave_approval))
	{
		if(level.var_134B4[param_00].rave_approval == 1)
		{
			return 1;
		}

		return 0;
	}

	return 0;
}

//Function Number: 22
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

//Function Number: 23
func_CD98(param_00,param_01,param_02)
{
	if(!soundexists(param_01))
	{
		wait(0.1);
		return;
	}

	param_00 playlocalsound(param_01);
}

//Function Number: 24
func_CC8F(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
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

	foreach(var_0A in level.players)
	{
		if(!isdefined(var_0A))
		{
			continue;
		}

		if(var_0A issplitscreenplayer() && !var_0A issplitscreenplayerprimary())
		{
			continue;
		}

		if(isdefined(param_08) && var_0A.var_134FD == param_08)
		{
			var_0B = param_08 + param_00;
			if(soundexists(var_0B))
			{
				var_0A playlocalsound(var_0B);
			}

			continue;
		}
		else
		{
			var_0C = scripts\cp\_vo::func_4978(param_00,param_03,param_05,param_06);
			var_0A thread scripts\cp\_vo::func_CE8B(var_0C);
		}
	}

	wait(scripts\cp\_vo::func_7C76(param_00));
	foreach(var_0A in level.players)
	{
		var_0A scripts\cp\_vo::func_F60D(0);
	}

	func_1094A(param_00);
	level.var_2001 = 0;
}

//Function Number: 25
func_1094A(param_00)
{
	if(param_00 == "dj_jingle_intro")
	{
		level notify("jukebox_start");
	}
}

//Function Number: 26
func_CE7E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	wait(0.5);
	func_2000("ww_" + param_00,"rave_ww_vo","highest",60,0,0,1);
	param_00 = func_45EA(param_00);
	foreach(var_08 in level.players)
	{
		if(isdefined(var_08) && isalive(var_08))
		{
			var_08 thread scripts\cp\_vo::try_to_play_vo(param_00,"rave_comment_vo");
		}
	}
}

//Function Number: 27
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

//Function Number: 28
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

//Function Number: 29
func_13539()
{
	for(;;)
	{
		level waittill("volume_activated",var_00);
		switch(var_00)
		{
			case "moon":
				foreach(var_02 in level.players)
				{
					var_02 thread scripts\cp\_vo::func_1769("nag_board_windows","rave_comment_vo",180,60,20,1);
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

//Function Number: 30
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

//Function Number: 31
power_nag()
{
	level endon("game_ended");
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
		case "front_gate":
			if(!isdefined(level.played_area_vos[param_00]))
			{
				level.played_area_vos[param_00] = 1;
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_door_cabins","rave_comment_vo","low",10,0,2,0,40);
			}
			else
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area","rave_comment_vo","low",10,0,2,1,40);
			}
			break;

		case "camper_to_lake":
		case "lake_shore":
		case "cabin_to_lake":
			if(!isdefined(level.played_area_vos[param_00]))
			{
				level.played_area_vos[param_00] = 1;
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_door_lake","rave_comment_vo","low",10,0,2,0,40);
			}
			else
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area","rave_comment_vo","low",10,0,2,1,40);
			}
	
			break;

		case "obstacle_course":
			if(!isdefined(level.played_area_vos[param_00]))
			{
				level.played_area_vos[param_00] = 1;
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_door_obcourse","rave_comment_vo","low",10,0,2,0,40);
			}
			else
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area","rave_comment_vo","low",10,0,2,1,40);
			}
	
			break;

		case "cave":
			if(!isdefined(level.played_area_vos[param_00]))
			{
				level.played_area_vos[param_00] = 1;
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_door_caves","rave_comment_vo","low",10,0,2,0,40);
			}
			else
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area","rave_comment_vo","low",10,0,2,1,40);
			}
			break;

		case "rave":
			if(!isdefined(level.played_area_vos[param_00]))
			{
				level.played_area_vos[param_00] = 1;
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area_rave","rave_comment_vo","low",10,0,2,0,40);
			}
			else
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area","rave_comment_vo","low",10,0,2,1,40);
			}
			break;

		default:
			if(level.players.size > 1)
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("purchase_area","rave_comment_vo","low",10,0,2,1,40);
			}
			else
			{
				level.players[0] thread scripts\cp\_vo::try_to_play_vo("purchase_area","rave_comment_vo","low",10,0,2,1,40);
			}
			break;
	}
}

//Function Number: 33
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

		var_01 = scripts\common\utility::random(level.players);
		if(isdefined(var_01.var_134FD))
		{
			switch(var_01.var_134FD)
			{
				case "p1_":
					if(randomint(100) > 50)
					{
						level thread scripts\cp\_vo::try_to_play_vo("spawn_team_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["spawn_team_1_1"] = 1;
					}
					else
					{
						level thread scripts\cp\_vo::try_to_play_vo("spawn_cabin_20_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["spawn_cabin_20_1"] = 1;
					}
					break;

				case "p4_":
					if(randomint(100) > 50)
					{
						level thread scripts\cp\_vo::try_to_play_vo("spawn_alt_2_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["spawn_alt_2_1"] = 1;
					}
					else
					{
						level thread scripts\cp\_vo::try_to_play_vo("spawn_alt_3_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["spawn_alt_3_1"] = 1;
					}
					break;

				case "p3_":
					if(randomint(100) > 50)
					{
						level thread scripts\cp\_vo::try_to_play_vo("spawn_alt_4_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["spawn_alt_4_1"] = 1;
					}
					else
					{
						level thread scripts\cp\_vo::try_to_play_vo("spawn_cabin_18_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["spawn_cabin_18_1"] = 1;
					}
					break;

				case "p2_":
					if(randomint(100) > 50)
					{
						level thread scripts\cp\_vo::try_to_play_vo("spawn_alt_5_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["spawn_alt_5_1"] = 1;
					}
					else
					{
						level thread scripts\cp\_vo::try_to_play_vo("spawn_cabin_19_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["spawn_cabin_19_1"] = 1;
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
							var_03 multiple_kevinsmith_intro_vo(var_03);
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
					var_03 multiple_kevinsmith_intro_vo(var_03);
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

//Function Number: 34
multiple_kevinsmith_intro_vo(param_00)
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
			param_00 thread scripts\cp\_vo::try_to_play_vo("spawn_team_first","rave_comment_vo");
			break;

		case 2:
			param_00 thread scripts\cp\_vo::try_to_play_vo("extra_ksmith_2","rave_comment_vo");
			break;

		case 3:
			param_00 thread scripts\cp\_vo::try_to_play_vo("extra_ksmith_3","rave_comment_vo");
			break;

		case 4:
			param_00 thread scripts\cp\_vo::try_to_play_vo("extra_ksmith_4","rave_comment_vo");
			break;

		default:
			break;
	}
}

//Function Number: 35
memory_vo_handler(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("disconnect");
	var_07 = self;
	if(!isdefined(var_07))
	{
		return;
	}

	if(var_07 issplitscreenplayer() && !var_07 issplitscreenplayerprimary())
	{
		return;
	}

	var_08 = scripts\cp\_vo::func_4978(param_00,param_03,param_05,param_06);
	var_07 scripts\cp\_vo::func_F60D(1);
	var_07 scripts\cp\_vo::func_F60B(var_08);
	var_07 scripts\cp\_vo::func_CE77(var_08);
	var_07 scripts\cp\_vo::func_C9B8(var_08);
	var_07 scripts\cp\_vo::func_F60D(0);
	var_07 scripts\cp\_vo::func_12C63();
}

//Function Number: 36
ks_vo_handler(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	while(scripts\cp\_vo::func_9D13())
	{
		wait(0.1);
	}

	if(scripts\common\utility::istrue(param_04))
	{
		foreach(var_08 in level.players)
		{
			var_08 scripts\cp\_vo::func_F60D(0);
			var_08.var_13518 = 0;
		}
	}

	scripts\cp\_vo::func_F60C(1);
	while(scripts\cp\_music_and_dialog::func_134DF())
	{
		wait(0.1);
	}

	play_ks_vo(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	scripts\cp\_vo::func_F60C(0);
	foreach(var_08 in level.players)
	{
		var_08 scripts\cp\_vo::func_F60D(0);
	}
}

//Function Number: 37
play_ks_vo(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = scripts\cp\_vo::func_4978(param_00,param_03,param_05,param_06);
	if(self == level)
	{
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

			if(isdefined(level.survivor))
			{
				if(isdefined(level.boat_survivor))
				{
					scripts\common\utility::play_sound_in_space(param_00,level.boat_survivor.origin,0,level.boat_survivor);
				}
				else
				{
					scripts\common\utility::play_sound_in_space(param_00,level.survivor.origin,0,level.survivor);
				}

				continue;
			}

			if(isdefined(level.boat_survivor))
			{
				scripts\common\utility::play_sound_in_space(param_00,level.boat_survivor.origin,0,level.boat_survivor);
				continue;
			}

			var_09 thread scripts\cp\_vo::func_CE8B(var_07);
		}

		wait(scripts\cp\_vo::func_7C76(param_00));
		return;
	}

	if(isdefined(level.survivor))
	{
		if(isdefined(level.boat_survivor))
		{
			scripts\common\utility::play_sound_in_space(param_00,level.boat_survivor.origin,0,level.boat_survivor);
		}
		else
		{
			scripts\common\utility::play_sound_in_space(param_00,level.survivor.origin,0,level.survivor);
		}
	}
	else if(isdefined(level.boat_survivor))
	{
		scripts\common\utility::play_sound_in_space(param_00,level.boat_survivor.origin,0,level.boat_survivor);
	}
	else if(isplayer(self))
	{
		if(isdefined(self.var_134FD))
		{
			thread scripts\cp\_vo::func_CE8B(var_07);
		}
	}

	wait(scripts\cp\_vo::func_7C76(param_00));
}