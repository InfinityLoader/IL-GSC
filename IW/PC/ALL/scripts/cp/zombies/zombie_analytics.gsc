/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\zombie_analytics.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 67
 * Decompile Time: 3126 ms
 * Timestamp: 10/27/2023 12:27:02 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\cp\_analytics::func_10C5A("mp/zombieMatchdata.ddl","mp/zombieclientmatchdata.ddl","cp/zombies/zombie_analytics.csv");
	level.var_1192B = 0;
	level.var_1192C = 0;
	level.var_1192D = 0;
	level.var_1192E = 0;
	level.var_10490 = " ";
	level.var_E4BB = [];
	level.var_E4BC = [];
	level.var_76CB = [];
	level.var_76CC = [];
	level.var_76CD = 0;
	level.var_E4BD = 0;
	level.var_AA0B = 0;
	level.var_3C2B = [];
	level.var_28BF = 0;
	level.var_13BD1 = 0;
	level.var_13BD2 = 0;
	level.var_13BCD = 0;
	level.var_13BCE = 0;
	level.var_13BCF = 0;
	level.var_13BD0 = 0;
	level.var_8288 = 0;
	level.var_8286 = 0;
	level.var_8287 = 0;
	level.var_5093 = 0;
	level.var_12631 = 0;
	level.var_1E5F = ::func_13F5C;
	level.var_311A = 0;
	level.var_D71D = ["front_gate","hidden_room","moon","moon_outside_begin","moon_rocket_space","moon_second","moon_bridge","arcade","arcade_back","europa_tunnel","room_europa","europa_2","roller_coast_back","swamp_stage","mars_3","mars"];
	level.var_D745 = 0;
	level.var_D746 = 0;
	level.var_2137 = 0;
	level.var_E4A4 = ::func_13F51;
	level.var_C8A3 = 0;
	level.var_AE60 = ["iw7_nrg","iw7_emc","iw7_revolver","iw7_g18","iw7_g18c","iw7_erad","iw7_crb","iw7_smgmags","iw7_ripper","iw7_fhr","iw7_ump45","iw7_ump45c","iw7_knife","iw7_fists","iw7_reaperblade","iw7_ar57","iw7_ake","iw7_m4","iw7_fmg","iw7_sdfar","iw7_arclassic","iw7_kbs","iw7_m8","iw7_cheytac","iw7_cheytacc","iw7_m1","iw7_m1c","iw7_devastator","iw7_sonic","iw7_sdfshotty","iw7_spas","iw7_spasc","iw7_mauler","iw7_sdflmg","iw7_lmg03","iw7_lockon","iw7_glprox","iw7_chargeshot","iw7_rvn","iw7_udm45","iw7_vr","iw7_crdb","iw7_mp28","iw7_minilmg","iw7_mod2187","iw7_ba50cal","iw7_gauss","iw7_longshot","iw7_unsalmg","iw7_mag","iw7_tacburst"];
	level.var_2115 = ["arcade_spider","arcade_barnstorming","arcade_cosmic","arcade_demon","arcade_pitfall","arcade_riverraid","arcade_robottank","arcade_starmaster","bowling_for_planets","bowling_for_planets_afterlife","coaster","laughingclown","laughingclown_afterlife","basketball_game","basketball_game_afterlife","clown_tooth_game","clown_tooth_game_afterlife","game_race","shooting_gallery","shooting_gallery_afterlife"];
}

//Function Number: 2
func_13F51(param_00)
{
	scripts\cp\_analytics::func_AF6A("revived_another_player",1,[param_00.var_41F0],[param_00.var_41F0],[param_00.var_41F0]);
}

//Function Number: 3
func_97A4(param_00)
{
	param_00 endon("disconnect");
	param_00.var_1567 = ::lib_0D2A::func_DEAA;
	lib_0D2A::func_96D8(param_00);
	while(!isdefined(param_00.pers))
	{
		wait(1);
	}

	param_00.var_1193D = [];
	param_00.var_A6C6 = [];
	param_00.var_A039 = " ";
	param_00.var_118F0 = [];
	if(!isdefined(level.var_311A))
	{
		level.var_311A = 0;
	}

	if(level.wave_num == 0)
	{
		param_00.pers["timesPerWave"] = spawnstruct();
		param_00.pers["timesPerWave"].var_11930 = [];
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1] = [];
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["coaster"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["game_race"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
	}

	if(!isdefined(param_00.pers["timesPerWave"]))
	{
		param_00.pers["timesPerWave"] = spawnstruct();
		param_00.pers["timesPerWave"].var_11930 = [];
		param_00.pers["timesPerWave"].var_11930[level.wave_num] = [];
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["bowling_for_planets"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["bowling_for_planets_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["coaster"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["laughingclown"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["laughingclown_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["basketball_game"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["basketball_game_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["clown_tooth_game"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["clown_tooth_game_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["game_race"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["shooting_gallery"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num]["shooting_gallery_afterlife"] = 0;
	}
	else if(!isdefined(param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]))
	{
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["coaster"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["game_race"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery"] = 0;
		param_00.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
	}

	param_00.var_A03C = [];
	param_00.var_A034 = [];
	param_00.var_A032 = " ";
	param_00.var_A037 = " ";
	param_00.var_A035 = " ";
	param_00.var_A03C[param_00.var_A035] = 0;
	param_00.var_A034[param_00.var_A035] = 0;
	if(!isdefined(param_00.var_11A3D))
	{
		param_00.var_11A3D = 0;
	}

	if(!isdefined(param_00.score_earned))
	{
		param_00.score_earned = 0;
	}

	param_00.var_5AFC = [];
	param_00.var_A682 = [];
	param_00.var_13BE3 = [];
	param_00.var_FF09 = [];
	param_00.var_FF0A = [];
	param_00.var_8CA0 = [];
	param_00.var_11A25 = 0;
	param_00.var_190B = [];
	param_00.var_13C2F = " ";
	param_00.accuracy_shots_fired = 0;
	param_00.var_154B = 0;
	param_00.explosive_kills = 0;
	param_00.total_trap_kills = 0;
	if(!isdefined(param_00.var_6977))
	{
		param_00.var_6977 = 0;
	}

	param_00.var_B625 = 0;
	param_00.kung_fu_vo = 0;
	if(!isdefined(param_00.trapkills))
	{
		param_00.trapkills = [];
	}

	var_01 = ["trap_gator","trap_dragon","trap_gravitron","trap_danceparty","trap_rocket","trap_spin"];
	foreach(var_03 in var_01)
	{
		if(!isdefined(param_00.trapkills[var_03]))
		{
			param_00.trapkills[var_03] = 0;
		}
	}

	var_05 = param_00.var_8235;
	if(isdefined(var_05))
	{
		foreach(var_07 in var_05)
		{
			param_00.var_13C2F = scripts\cp\_utility::func_7DF7(var_07);
			if(!isdefined(param_00.var_190B[param_00.var_13C2F]))
			{
				param_00.var_190B[param_00.var_13C2F] = 0;
			}
		}
	}
}

//Function Number: 4
func_AF67(param_00,param_01)
{
	if(isdefined(param_00.score_earned))
	{
		param_00.score_earned = param_00.score_earned + param_01;
	}

	scripts\cp\_analytics::func_AF6A("currency_earned",param_01,[param_01],[param_00.var_41F0],[param_00.var_41F0]);
}

//Function Number: 5
func_AF92(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_03) && param_03 != "none")
	{
		scripts\cp\_analytics::func_AF6A("zombie_death",param_00,[param_01,param_02.var_41F0,param_03,param_04,"" + param_05],[param_02.var_41F0,param_03],[param_02.var_41F0]);
	}
}

//Function Number: 6
func_AF90(param_00,param_01,param_02,param_03)
{
	scripts\cp\_analytics::func_AF6A("wave_complete",1,[level.script,param_00,param_01,param_02,param_03],[level.script]);
	foreach(var_05 in level.players)
	{
		var_05.var_AF9B = "wave_complete";
	}
}

//Function Number: 7
func_AF68(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(param_04))
	{
		var_08 = param_04.agent_type;
	}
	else
	{
		var_08 = "";
	}

	scripts\cp\_analytics::func_AF6A("dropped_to_last_stand",param_00,[param_01.var_41F0,param_03,var_08,"" + param_05,param_06,param_07],[param_01.var_41F0,param_02],[param_01.var_41F0]);
	if(!isdefined(param_01.var_AF9B))
	{
		param_01.var_AF9B = "droppedToLastStand";
	}

	param_01.var_AF9B = "droppedToLastStand";
}

//Function Number: 8
func_AF69(param_00,param_01,param_02,param_03,param_04)
{
	scripts\cp\_analytics::func_AF6A("entering_afterlife_arcade",param_00,[param_01.var_41F0,param_02,param_03,param_04],[param_01.var_41F0,param_03],[param_01.var_41F0]);
}

//Function Number: 9
func_45F3(param_00)
{
	switch(param_00)
	{
		case "Wave Complete":
			return 1;

		case "Self Revive":
			return 2;

		default:
			return 1;
	}
}

//Function Number: 10
func_AF6B(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_45F3(param_03);
	scripts\cp\_analytics::func_AF6A("exiting_afterlife_arcade",param_00,[param_01.var_41F0,param_02,var_05,param_04],[param_01.var_41F0,var_05]);
}

//Function Number: 11
func_AF8E(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("turning_on_the_power",1,[level.script,param_00,param_01],[level.script]);
}

//Function Number: 12
func_AF7E(param_00,param_01,param_02,param_03,param_04)
{
	scripts\cp\_persistence::increment_player_career_doors_opened(param_01);
	scripts\cp\_analytics::func_AF6A("opening_the_doors",param_00,[param_01.var_41F0,param_02,param_03,param_04],[param_01.var_41F0,param_02]);
}

//Function Number: 13
log_purchasingforateamdoor(param_00,param_01,param_02,param_03,param_04)
{
	scripts\cp\_analytics::func_AF6A("purchasing_for_a_team_door",param_00,[param_01.var_41F0,param_02,param_03,param_04],[param_01.var_41F0,param_02]);
}

//Function Number: 14
func_AF62(param_00,param_01)
{
	if(param_00 != "next_challenge")
	{
		scripts\cp\_analytics::func_AF6A("challenge_activated",1,[level.script,param_00,param_01],[level.script]);
	}
}

//Function Number: 15
func_AF63(param_00,param_01,param_02)
{
	scripts\cp\_analytics::func_AF6A("challenge_completed",1,[level.script,param_00,param_01,param_02],[level.script]);
}

//Function Number: 16
func_AF64(param_00,param_01,param_02,param_03)
{
	scripts\cp\_analytics::func_AF6A("challenge_failed",1,[level.script,param_00,param_01,int(param_02),param_03],[level.script]);
}

//Function Number: 17
func_AF79(param_00)
{
	scripts\cp\_analytics::func_AF6A("magic_box_used",1,[level.script,param_00],[level.script]);
}

//Function Number: 18
func_AF86(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_03))
	{
		param_03 = "none";
	}

	if(param_03 == "none")
	{
		param_01.var_13BE3[getweaponbasename(param_02)] = param_04;
		if(isdefined(param_07[param_03]))
		{
			var_09 = param_07[param_03];
		}
		else
		{
			var_09 = 0;
		}

		if(isdefined(param_08[param_03]))
		{
			var_0A = param_08[param_03];
		}
		else
		{
			var_0A = 0;
		}

		param_06 = 0;
	}
	else
	{
		var_0B = param_03.var_13BE3[getweaponbasename(param_05)];
		param_06 = param_04 - var_0B;
		param_01.var_13BE3[getweaponbasename(param_02)] = param_04;
		if(!isdefined(param_01.var_A682[param_03]))
		{
			param_01.var_A682[param_03] = 0;
		}

		if(!isdefined(param_01.var_5AFC[param_03]))
		{
			param_01.var_5AFC[param_03] = 0;
		}

		var_09 = param_01.var_A682[param_03];
		var_0A = param_01.var_5AFC[param_03];
	}

	scripts\cp\_analytics::func_AF6A("purchasing_weapon",param_00,[param_01.var_41F0,param_02,param_03,param_04,param_05,param_06,var_09,var_0A],[param_01.var_41F0,var_09]);
}

//Function Number: 19
func_AF5D(param_00,param_01,param_02)
{
	scripts\cp\_analytics::func_AF6A("atm_used",param_00,[param_01,param_02.var_41F0],[param_02.var_41F0,param_01]);
}

//Function Number: 20
func_AF85(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("portal_used",1,[level.script,param_00,param_01],[level.script]);
}

//Function Number: 21
func_AF77(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("souvenir_item_crafted",1,[level.script,param_00,param_01],[level.script]);
}

//Function Number: 22
func_AF78(param_00,param_01,param_02)
{
	scripts\cp\_analytics::func_AF6A("lost_and_found",1,[level.script,param_00,param_01,param_02],[level.script]);
}

//Function Number: 23
func_AF6C(param_00,param_01,param_02,param_03)
{
	scripts\cp\_analytics::func_AF6A("faf_card_used",param_00,[param_01,param_02,param_03.var_41F0],[param_03.var_41F0,param_02]);
}

//Function Number: 24
func_AF6D(param_00,param_01,param_02)
{
	scripts\cp\_analytics::func_AF6A("faf_card_refill",param_00,[param_01,param_02.var_41F0],[param_02.var_41F0,param_01]);
}

//Function Number: 25
func_AF7F(param_00,param_01,param_02)
{
	var_03 = scripts\cp\_utility::func_7DF7(param_01);
	scripts\cp\_analytics::func_AF6A("pack_a_punch_used",1,[level.script,param_00,var_03,param_02],[level.script]);
}

//Function Number: 26
func_AF89(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("souvenir_coin_used",1,[level.script,param_00,param_01],[level.script]);
}

//Function Number: 27
func_AF66(param_00,param_01,param_02,param_03,param_04,param_05)
{
	scripts\cp\_analytics::func_AF6A("crafted_item_placed",param_00,[param_01.var_41F0,param_02,param_03,param_04,param_05],[param_01.var_41F0,param_03]);
}

//Function Number: 28
func_AF74(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("interaction_status",1,[level.script,param_00,param_01],[level.script]);
}

//Function Number: 29
func_AF80(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("perk_machine_used",1,[level.script,param_00,param_01],[level.script]);
}

//Function Number: 30
func_AF81(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("perk_returned",1,[level.script,param_00,param_01],[level.script]);
}

//Function Number: 31
func_AF6E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_01 lib_0D2A::func_12D7E(param_01,param_03,param_02);
	if(param_05 > 0 && param_03 != "coaster")
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("arcade_complete","zmb_comment_vo","low",10,0,0,0,45);
	}

	scripts\cp\_analytics::func_AF6A("finished_mini_game",param_00,[param_01.var_41F0,param_02,param_03,param_04,param_05,param_06],[param_01.var_41F0,param_03]);
}

//Function Number: 32
func_AF82(param_00,param_01,param_02,param_03,param_04,param_05)
{
	scripts\cp\_analytics::func_AF6A("pillage_event",param_00,[param_01.var_41F0,param_02,param_03,param_04,param_05],[param_01.var_41F0,param_03]);
}

//Function Number: 33
func_AF75(param_00,param_01,param_02)
{
	scripts\cp\_analytics::func_AF6A("item_purchase_with_tickets",1,[level.script,param_00,param_01,param_02],[level.script]);
}

//Function Number: 34
func_AF76(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("item_replaced",1,[level.script,param_00,param_01],[level.script]);
}

//Function Number: 35
func_AF7D(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("neil_head_found",param_00,[level.script,param_00],[level.script]);
	scripts\cp\_analytics::func_AF6A("neil_head_placed",param_01,[level.script,param_01],[level.script]);
}

//Function Number: 36
func_AF7B(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("neil_battery",param_00,[level.script,param_00,param_01],[level.script]);
}

//Function Number: 37
func_AF7C(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("neil_floppy",param_00,[level.script,param_00,param_01],[level.script]);
}

//Function Number: 38
func_AF5E(param_00)
{
	scripts\cp\_analytics::func_AF6A("balloons_popped",param_00,[level.script,param_00],[level.script]);
}

//Function Number: 39
log_boss_fight_result(param_00)
{
	scripts\cp\_analytics::func_AF6A("shot_icemonster",param_00,[level.script,param_00],[level.script]);
}

//Function Number: 40
log_wave_dur_boss_fight(param_00)
{
	scripts\cp\_analytics::func_AF6A("ghost_spelled",param_00,[level.script,param_00],[level.script]);
}

//Function Number: 41
log_using_dc_mode(param_00)
{
	scripts\cp\_analytics::func_AF6A("beating_arcade_games",param_00,[level.script,param_00],[level.script]);
}

//Function Number: 42
log_using_boss_fight_playlist(param_00)
{
	scripts\cp\_analytics::func_AF6A("brute_hits_cabinet",param_00,[level.script,param_00],[level.script]);
}

//Function Number: 43
func_AF5B(param_00)
{
	scripts\cp\_analytics::func_AF6A("activate_enter_ghostskulls_game",param_00,[level.script,param_00],[level.script]);
}

//Function Number: 44
func_AF83(param_00,param_01,param_02)
{
	scripts\cp\_analytics::func_AF6A("player_exits_ghostskulls_games",param_00,[level.script,param_00,param_01,int(param_02)],[level.script]);
}

//Function Number: 45
func_AF6F(param_00,param_01,param_02)
{
	scripts\cp\_analytics::func_AF6A("frequency_device_collected",param_00,[level.script,param_00,param_01,param_02],[level.script]);
}

//Function Number: 46
func_AF70(param_00,param_01)
{
	scripts\cp\_analytics::func_AF6A("frequency_device_crafted_dj",param_00,[level.script,param_00,param_01],[level.script]);
}

//Function Number: 47
func_AF8A(param_00,param_01,param_02,param_03)
{
	scripts\cp\_analytics::func_AF6A("speaker_defence_sequence_ends",param_00,[level.script,param_00,"" + param_01,param_02,param_03],[level.script]);
}

//Function Number: 48
func_AF8D(param_00)
{
	scripts\cp\_analytics::func_AF6A("tone_sequence_activated",param_00,[level.script,param_00],[level.script]);
}

//Function Number: 49
func_AF8B(param_00)
{
	scripts\cp\_analytics::func_AF6A("suicide_bomber_sequence_activated",param_00,[level.script,param_00],[level.script]);
}

//Function Number: 50
func_AF72(param_00)
{
	scripts\cp\_analytics::func_AF6A("grey_sequence_activated",param_00,[level.script,param_00],[level.script]);
}

//Function Number: 51
func_AF8F(param_00)
{
	scripts\cp\_analytics::func_AF6A("ufo_destroyed",param_00,[level.script,param_00],[level.script]);
}

//Function Number: 52
func_AF87(param_00,param_01,param_02,param_03)
{
	scripts\cp\_analytics::func_AF6A("xp_earned",param_00,[param_01,param_02.var_41F0,param_03],[param_02.var_41F0,param_01]);
}

//Function Number: 53
func_AF73(param_00,param_01)
{
	foreach(var_06, var_03 in param_01.var_8CA0)
	{
		if(var_06 == "none" || var_06 == "" || var_03 == 0 || !scripts\common\utility::func_2286(level.var_AE60,var_06))
		{
			continue;
		}

		var_04 = scripts\cp\_utility::func_7DF7(var_06);
		setclientmatchdata("player",param_00,"headShots",var_04,var_03);
		var_05 = param_01 getplayerdata("cp","headShots",var_04);
		param_01 setplayerdata("cp","headShots",var_04,var_05 + var_03);
	}

	setclientmatchdata("player",param_00,"total_headshots",param_01.var_11A25);
}

//Function Number: 54
log_card_data(param_00,param_01)
{
	if(!isdefined(param_01.var_456B))
	{
		return;
	}

	foreach(var_05, var_03 in param_01.var_456B)
	{
		var_04 = param_01 getplayerdata("cp","cards_used",var_05);
		param_01 setplayerdata("cp","cards_used",var_05,var_04 + var_03.var_11925);
	}
}

//Function Number: 55
log_explosive_kills(param_00,param_01)
{
	if(!isdefined(param_01.explosive_kills))
	{
		return;
	}

	var_02 = param_01 getplayerdata("cp","explosive_kills");
	param_01 setplayerdata("cp","explosive_kills",var_02 + param_01.explosive_kills);
}

//Function Number: 56
func_AF91(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	var_04 = "";
	foreach(var_08, var_06 in param_01.var_190B)
	{
		if(var_08 == "none" || var_08 == "" || var_06 == 0 || !scripts\common\utility::func_2286(level.var_AE60,var_08))
		{
			continue;
		}

		setclientmatchdata("player",param_00,"killsPerWeapon",scripts\cp\_utility::func_7DF7(var_08),var_06);
		var_07 = param_01 getplayerdata("cp","killsPerWeapon",scripts\cp\_utility::func_7DF7(var_08));
		param_01 setplayerdata("cp","killsPerWeapon",scripts\cp\_utility::func_7DF7(var_08),var_07 + var_06);
		if(param_01.var_190B[var_08] > 0 && var_02 == 0)
		{
			var_03 = param_01.var_190B[var_08];
			var_02 = 1;
			var_04 = scripts\cp\_utility::func_7DF7(var_08);
		}

		if(param_01.var_190B[var_08] > var_03)
		{
			var_03 = param_01.var_190B[var_08];
			var_04 = scripts\cp\_utility::func_7DF7(var_08);
		}
	}

	if(var_03 > 0)
	{
		setclientmatchdata("player",param_00,"DeadliestWeapon",var_04);
		setclientmatchdata("player",param_00,"DeadliestWeaponKills",var_03);
	}

	var_09 = param_01 getplayerdata("cp","DeadliestWeaponName");
	var_07 = param_01 getplayerdata("cp","DeadliestWeaponKills",var_09);
	if(var_07 < var_03)
	{
		if(var_03 > 0)
		{
			var_0A = param_01 getplayerdata("cp","killsPerWeapon",var_04);
			if(!isdefined(param_01.var_190B[var_04]))
			{
				param_01 setplayerdata("cp","DeadliestWeaponKills",var_04,var_0A);
			}
			else
			{
				param_01 setplayerdata("cp","DeadliestWeaponKills",var_04,var_0A);
			}

			param_01 setplayerdata("cp","DeadliestWeaponName",var_04);
			return;
		}

		return;
	}

	var_0B = var_02 getplayerdata("cp","killsPerWeapon",var_0A);
	if(!isdefined(var_02.var_190B[var_0A]))
	{
		var_02 setplayerdata("cp","DeadliestWeaponKills",var_0A,var_0B);
	}
	else
	{
		var_02 setplayerdata("cp","DeadliestWeaponKills",var_0A,var_02.var_190B[var_0A] + var_0B);
	}

	var_02 setplayerdata("cp","DeadliestWeaponName",var_0A);
}

//Function Number: 57
func_13F5C()
{
	var_00 = ["trap_gator","trap_dragon","trap_gravitron","trap_danceparty","trap_rocket","trap_spin"];
	foreach(var_06, var_02 in level.players)
	{
		func_AF91(var_06,var_02);
		func_AF73(var_06,var_02);
		log_card_data(var_06,var_02);
		log_explosive_kills(var_06,var_02);
		foreach(var_04 in var_00)
		{
			if(isdefined(var_02.trapkills[var_04]))
			{
				var_02.total_trap_kills = var_02.total_trap_kills + var_02.trapkills[var_04];
			}
		}
	}
}

//Function Number: 58
func_AF84(param_00,param_01)
{
}

//Function Number: 59
log_playershotsontarget(param_00,param_01,param_02)
{
	scripts\cp\_analytics::func_AF6A("shots_on_target",param_00,[param_01.var_41F0,param_02],[param_01.var_41F0,param_02]);
}

//Function Number: 60
func_AF8C(param_00,param_01)
{
	if(!isdefined(param_01.pers["timesPerWave"].var_11930))
	{
		param_01.pers["timesPerWave"].var_11930 = [];
	}

	if(!isdefined(param_01.pers["timesPerWave"].var_11930[level.var_13BD4]))
	{
		param_01.pers["timesPerWave"].var_11930[level.var_13BD4] = [];
	}

	if(!isdefined(param_01.pers["timesPerWave"].var_11930[level.var_13BD4][param_00]))
	{
		param_01.pers["timesPerWave"].var_11930[level.var_13BD4][param_00] = 0;
	}

	param_01.pers["timesPerWave"].var_11930[level.var_13BD4][param_00]++;
}

//Function Number: 61
log_hidden_song_one_found(param_00)
{
	scripts\cp\_analytics::func_AF6A("hidden_song_one_discovered",undefined,[param_00],undefined);
}

//Function Number: 62
log_hidden_song_two_found(param_00)
{
	scripts\cp\_analytics::func_AF6A("hidden_song_two_discovered",undefined,[param_00],undefined);
}

//Function Number: 63
log_crafted_wor_facemelter(param_00)
{
	scripts\cp\_analytics::func_AF6A("crafted_wor_facemelter",undefined,[param_00],undefined);
}

//Function Number: 64
log_crafted_wor_headcutter(param_00)
{
	scripts\cp\_analytics::func_AF6A("crafted_wor_headcutter",undefined,[param_00],undefined);
}

//Function Number: 65
log_crafted_wor_dischord(param_00)
{
	scripts\cp\_analytics::func_AF6A("crafted_wor_dischord",undefined,[param_00],undefined);
}

//Function Number: 66
log_crafted_wor_shredder(param_00)
{
	scripts\cp\_analytics::func_AF6A("crafted_wor_shredder",undefined,[param_00],undefined);
}

//Function Number: 67
log_pink_ark_obtained(param_00)
{
	scripts\cp\_analytics::func_AF6A("pink_ark_obtained",undefined,[param_00],undefined);
}