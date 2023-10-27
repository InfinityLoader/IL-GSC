/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_specialops_code.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 98
 * Decompile Time: 1603 ms
 * Timestamp: 10/27/2023 2:21:38 AM
*******************************************************************/

//Function Number: 1
setup_xp()
{
	wait 0.05;
	maps\_rank::xp_init();
}

//Function Number: 2
register_level_unlock(param_00,param_01)
{
	var_02 = int(tablelookup("sp/specOpsTable.csv",1,param_00,5));
	var_03 = tablelookup("sp/specOpsTable.csv",1,param_00,6);
	var_04 = 1;
	unlock_register(param_00,var_02,var_03,"","",param_01,var_04);
}

//Function Number: 3
register_survival_unlock()
{
	register_level_unlock("so_survival_2","survival");
	register_level_unlock("so_survival_3","survival");
	register_level_unlock("so_survival_4","survival");
	register_survival_armory_unlock(100,120,"weaponupgrade");
	register_survival_armory_unlock(0,64,"weapon");
	register_survival_armory_unlock(1000,1020,"equipment");
	register_survival_armory_unlock(10000,10020,"airsupport");
}

//Function Number: 4
register_survival_armory_unlock(param_00,param_01,param_02)
{
	for(var_03 = param_00;var_03 <= param_01;var_03++)
	{
		var_04 = tablelookup("sp/survival_armories.csv",0,var_03,1);
		if(!isdefined(var_04) || var_04 == "")
		{
			continue;
		}

		var_05 = var_03;
		var_06 = var_04;
		var_07 = param_02;
		var_08 = tablelookup("sp/survival_armories.csv",1,var_04,4);
		var_09 = tablelookup("sp/survival_armories.csv",1,var_04,5);
		var_0A = int(tablelookup("sp/survival_armories.csv",1,var_04,7));
		if(var_0A > 0)
		{
			var_0B = "weapon_missing_image";
			if(var_07 == "airsupport")
			{
				var_0B = "specops_ui_airsupport";
			}

			if(var_07 == "equipment")
			{
				var_0B = "specops_ui_equipmentstore";
			}

			if(var_07 == "weapon" || var_07 == "weaponupgrade")
			{
				var_0B = "specops_ui_weaponstore";
			}

			var_0C = 0;
			unlock_register(var_06,var_0A,var_08,var_09,var_0B,"survival",var_0C);
		}
	}
}

//Function Number: 5
unlock_register(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	var_07.ref = param_00;
	var_07.name = param_02;
	var_07.var_189B = param_03;
	var_07.icon = param_04;
	var_07.unlocklvl = param_01;
	var_07.mode = param_05;
	var_07.var_1DD = param_06;
	if(!isdefined(level.unlock_array))
	{
		level.unlock_array = [];
	}

	if(!isdefined(level.unlock_array[param_01]))
	{
		level.unlock_array[param_01] = [];
	}

	level.unlock_array[param_01][level.unlock_array[param_01].size] = var_07;
}

//Function Number: 6
pick_starting_location_so(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		if(isdefined(level.skip_playersetstreamorigin) && level.skip_playersetstreamorigin)
		{
			return undefined;
		}
	}

	if(isdefined(level.pmc_match) && level.pmc_match)
	{
		return pick_starting_location_pmc(param_00);
	}

	var_01 = getentarray("info_player_start_so","classname");
	if(var_01.size <= 0)
	{
		var_01 = getentarray("info_player_start","classname");
	}

	var_02 = common_scripts\utility::random(var_01);
	if(isdefined(param_00) && param_00)
	{
		return var_02.origin;
	}

	place_player_at_start_point(level.player,var_02);
	if(maps\_utility::is_coop())
	{
		var_03 = getentarray("info_player_start_soPlayer2","classname");
		if(var_03.size > 0)
		{
			var_04 = maps\_utility::getclosest(var_02.origin,var_03);
			place_player_at_start_point(level.player2,var_04);
			return;
		}

		place_player2_near_player1();
	}
}

//Function Number: 7
isdefendmatch()
{
	return level.pmc_gametype == "mode_defend";
}

//Function Number: 8
pick_starting_location_pmc(param_00)
{
	if(isdefendmatch())
	{
		var_01 = getentarray("info_player_start_pmcDefend","classname");
	}
	else
	{
		var_01 = getentarray("info_player_start_pmc","classname");
	}

	var_02 = [];
	var_03 = undefined;
	foreach(var_05 in level.players)
	{
		if(!var_02.size)
		{
			var_03 = common_scripts\utility::random(var_01);
		}
		else
		{
			var_03 = maps\_utility::get_closest_exclude(var_03.origin,var_01,var_02);
		}

		if(isdefined(param_00) && param_00)
		{
			return var_03.origin;
		}

		var_05 setorigin(var_03.origin);
		var_05 setplayerangles(var_03.angles);
		var_02[var_02.size] = var_03;
	}
}

//Function Number: 9
place_player_at_start_point(param_00,param_01)
{
	param_00 setorigin(param_01.origin);
	if(isdefined(param_01.angles))
	{
		param_00 setplayerangles(param_01.angles);
	}
}

//Function Number: 10
place_player2_near_player1()
{
	level.player2 setplayerangles(level.player.angles + (0,-25,0));
	level.player2 setorigin(level.player.origin);
	var_00 = spawnstruct();
	var_00.entity = level.player2;
	var_00.right = -20;
	var_00.forward = -50;
	var_00 maps\_utility::translate_local();
	level.player2 setorigin(level.player2.origin);
}

//Function Number: 11
specialops_remove_entity_check(param_00)
{
	if(specialops_remove_flag_check(param_00))
	{
		return 1;
	}

	if(specialops_remove_name_check(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
specialops_remove_flag_check(param_00)
{
	if(!isdefined(self.script_specialops))
	{
		return 0;
	}

	if(self.script_specialops == param_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
specialops_remove_name_check(param_00)
{
	if(!isdefined(self.script_specialopsname))
	{
		return 0;
	}

	if(param_00 == 0)
	{
		return 1;
	}

	var_01 = strtok(self.script_specialopsname,":;, ");
	var_02 = 1;
	foreach(var_04 in var_01)
	{
		if(var_04 == level.script)
		{
			var_02 = 0;
			break;
		}
	}

	return var_02;
}

//Function Number: 14
so_create_hud_item_delay_draw(param_00)
{
	param_00.alpha = 0;
	while(!so_hud_can_show())
	{
		wait 0.5;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(so_hud_can_toggle(param_00))
	{
		switch(self.so_infohud_toggle_state)
		{
			case "on":
			case "none":
				param_00 maps\_hud_util::fade_over_time(1,0.5);
				break;

			case "off":
				param_00 maps\_hud_util::fade_over_time(0,0.5);
				break;

			default:
				break;
		}
	}
	else
	{
		param_00 maps\_hud_util::fade_over_time(1,0.5);
	}

	if(!maps\_utility::ent_flag("so_hud_can_toggle"))
	{
		maps\_utility::ent_flag_set("so_hud_can_toggle");
	}
}

//Function Number: 15
so_hud_can_show()
{
	if(isdefined(level.so_waiting_for_players) && level.so_waiting_for_players)
	{
		return 0;
	}

	if(isdefined(level.challenge_time_force_on) && level.challenge_time_force_on)
	{
		return 1;
	}

	if(!isdefined(self.so_hud_show_time))
	{
		return 1;
	}

	return gettime() > self.so_hud_show_time;
}

//Function Number: 16
so_hud_can_toggle(param_00)
{
	if(!isdefined(param_00.so_can_toggle) || !param_00.so_can_toggle)
	{
		return 0;
	}

	if(!isdefined(self.so_infohud_toggle_state))
	{
		return 0;
	}

	return 1;
}

//Function Number: 17
challenge_timer_player_setup(param_00,param_01,param_02,param_03)
{
	level endon("challenge_timer_expired");
	level endon("new_challenge_timer");
	level endon("special_op_terminated");
	var_04 = undefined;
	if(isdefined(param_03) && param_03)
	{
		var_04 = 1;
	}

	var_05 = maps\_specialops::so_hud_ypos();
	self.hud_so_timer_msg = maps\_specialops::so_create_hud_item(1,var_05,param_02,self,var_04);
	if(isdefined(level.challenge_time_limit))
	{
		self.hud_so_timer_time = maps\_specialops::so_create_hud_item(1,var_05,undefined,self,var_04);
		self.hud_so_timer_time settenthstimerstatic(level.challenge_time_limit);
	}
	else
	{
		self.hud_so_timer_time = maps\_specialops::so_create_hud_item(1,var_05,&"SPECIAL_OPS_TIME_NULL",self,var_04);
	}

	self.hud_so_timer_time.alignx = "left";
	if(!isdefined(param_03) || param_03 == 0)
	{
		thread maps\_specialops::info_hud_wait_for_player();
		thread maps\_specialops::info_hud_handle_fade(self.hud_so_timer_msg);
		thread maps\_specialops::info_hud_handle_fade(self.hud_so_timer_time);
	}
	else
	{
		self.so_infohud_toggle_state = "none";
		self.hud_so_timer_msg.alpha = 0;
		self.hud_so_timer_time.alpha = 0;
	}

	challenge_timer_wait_start(self.hud_so_timer_msg,self.hud_so_timer_time,param_00);
	if(isdefined(level.challenge_time_limit))
	{
		level.so_challenge_time_left = level.challenge_time_limit;
		thread challenge_timer_show_nudge(self.hud_so_timer_msg,self.hud_so_timer_time);
		thread challenge_timer_show_hurry(self.hud_so_timer_msg,self.hud_so_timer_time);
		thread challenge_timer_show_failed(self.hud_so_timer_msg,self.hud_so_timer_time);
		thread challenge_timer_destroy_prematurely(self.hud_so_timer_msg,self.hud_so_timer_time);
	}

	thread challenge_timer_wait_passed(self.hud_so_timer_msg,self.hud_so_timer_time,param_01);
}

//Function Number: 18
challenge_timer_detect_3quarter()
{
	if(!common_scripts\utility::flag_exist("so_challenge_is_3quarter"))
	{
		common_scripts\utility::flag_init("so_challenge_is_3quarter");
	}

	common_scripts\utility::flag_wait("so_challenge_is_3quarter");
	maps\_specialops::so_dialog_progress_update(3,4);
}

//Function Number: 19
challenge_timer_detect_halfway()
{
	if(!common_scripts\utility::flag_exist("so_challenge_is_halfway"))
	{
		common_scripts\utility::flag_init("so_challenge_is_halfway");
	}

	common_scripts\utility::flag_wait("so_challenge_is_halfway");
	maps\_specialops::so_dialog_progress_update(2,4);
}

//Function Number: 20
challenge_timer_detect_quarter()
{
	if(!common_scripts\utility::flag_exist("so_challenge_is_quarter"))
	{
		common_scripts\utility::flag_init("so_challenge_is_quarter");
	}

	common_scripts\utility::flag_wait("so_challenge_is_quarter");
	maps\_specialops::so_dialog_progress_update(1,4);
}

//Function Number: 21
challenge_timer_wait_start(param_00,param_01,param_02)
{
	level endon("special_op_terminated");
	if(isdefined(param_02))
	{
		common_scripts\utility::flag_wait(param_02);
	}

	foreach(var_04 in level.players)
	{
		if(!var_04 so_hud_can_show())
		{
			var_04.so_hud_show_time = gettime();
		}
	}

	if(!isdefined(level.challenge_start_time))
	{
		if(challenge_timer_should_play_alarm())
		{
			level.player playsound("arcademode_zerodeaths");
		}

		level.challenge_start_time = gettime();
	}
	else
	{
		level.challenge_start_time_last = gettime();
	}

	param_01.label = "";
	if(isdefined(level.challenge_time_limit))
	{
		param_01 settenthstimer(level.challenge_time_limit);
		return;
	}

	param_01 settenthstimerup(0);
}

//Function Number: 22
challenge_timer_should_play_alarm()
{
	if(isdefined(level.challenge_time_limit))
	{
		return 1;
	}

	foreach(var_01 in level.players)
	{
		if(var_01.so_infohud_toggle_state != "off")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 23
challenge_timer_show_nudge(param_00,param_01)
{
	if(!validate_timer(level.challenge_time_nudge))
	{
		return;
	}

	level endon("challenge_timer_passed");
	level endon("new_challenge_timer");
	level endon("special_op_terminated");
	while(level.so_challenge_time_left > level.challenge_time_nudge)
	{
		wait 0.1;
	}

	param_00 set_hudelem_yellow();
	param_01 set_hudelem_yellow();
	if(!challenge_timer_be_silent())
	{
		thread maps\_specialops::so_dialog_time_low_normal();
	}
}

//Function Number: 24
challenge_timer_show_hurry(param_00,param_01)
{
	if(!validate_timer(level.challenge_time_hurry))
	{
		return;
	}

	level endon("challenge_timer_passed");
	level endon("new_challenge_timer");
	level endon("special_op_terminated");
	while(level.so_challenge_time_left > level.challenge_time_hurry)
	{
		wait 0.1;
	}

	param_00 set_hudelem_red();
	param_01 set_hudelem_red();
	if(!challenge_timer_be_silent())
	{
		thread maps\_specialops::so_dialog_time_low_hurry();
	}
}

//Function Number: 25
challenge_timer_be_silent()
{
	if(self != level.player)
	{
		return 1;
	}

	if(!isdefined(level.challenge_time_silent))
	{
		return 0;
	}

	return level.challenge_time_silent;
}

//Function Number: 26
challenge_timer_thread()
{
	level endon("special_op_terminated");
	level notify("stop_challenge_timer_thread");
	level endon("stop_challenge_timer_thread");
	while(level.so_challenge_time_left > 0)
	{
		wait 0.05;
		level.so_challenge_time_left = level.so_challenge_time_left - 0.05;
		thread challenge_timer_give_alert();
	}

	level notify("challenge_timer_failed");
}

//Function Number: 27
challenge_timer_give_alert()
{
	if(challenge_timer_should_pulse())
	{
		foreach(var_01 in level.players)
		{
			var_01.hud_so_timer_msg thread maps\_specialops::so_hud_pulse_create();
			var_01.hud_so_timer_time thread maps\_specialops::so_hud_pulse_create();
		}

		if(level.so_challenge_time_beep < 0)
		{
			level.player playsound("arcademode_kill_streak_lost");
			return;
		}

		level.player playsound("so_countdown_beep");
	}
}

//Function Number: 28
challenge_timer_should_pulse()
{
	if(level.so_challenge_time_left > level.so_challenge_time_beep)
	{
		return 0;
	}

	for(var_00 = 0;var_00 <= level.hud_so_counter_values;var_00++)
	{
		if(level.so_challenge_time_left > var_00)
		{
			if(level.so_challenge_time_beep < var_00)
			{
				level.so_challenge_time_beep = var_00 + 1;
			}

			continue;
		}

		level.so_challenge_time_beep = var_00 - 1;
		return 1;
	}

	return 0;
}

//Function Number: 29
challenge_timer_show_failed(param_00,param_01)
{
	if(!validate_timer(level.challenge_time_limit))
	{
		return;
	}

	level endon("challenge_timer_passed");
	level endon("new_challenge_timer");
	level endon("special_op_terminated");
	thread challenge_timer_thread();
	level waittill("challenge_timer_failed");
	common_scripts\utility::flag_set("challenge_timer_expired");
	challenge_timer_destroy(param_00,param_01);
	if(self == level.player)
	{
		thread maps\_specialops::so_dialog_mission_failed_time();
	}

	var_02 = "@SPECIAL_OPS_FAILURE_HINT_TIME";
	if(isdefined(level.so_deadquote_time))
	{
		var_02 = level.so_deadquote_time;
	}

	maps\_specialops::so_force_deadquote(var_02,"ui_time_failure");
	if(self == level.player)
	{
		maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 30
challenge_timer_wait_passed(param_00,param_01,param_02)
{
	level endon("challenge_timer_expired");
	level endon("new_challenge_timer");
	if(common_scripts\utility::flag_exist("individual_timers") && common_scripts\utility::flag("individual_timers"))
	{
		maps\_utility::ent_flag_wait(param_02);
	}
	else
	{
		common_scripts\utility::flag_wait(param_02);
	}

	common_scripts\utility::flag_set("challenge_timer_passed");
	level.challenge_end_time = gettime();
	var_03 = common_scripts\utility::ter_op(isdefined(level.challenge_start_time_last),level.challenge_start_time_last,level.challenge_start_time);
	var_04 = maps\_utility::round_millisec_on_sec(level.challenge_end_time - var_03,1,0);
	var_05 = var_04 / 1000;
	if(isdefined(level.challenge_time_limit))
	{
		var_05 = level.challenge_time_limit - var_05;
	}

	if(var_05 <= 0)
	{
		var_05 = 0.1;
	}

	param_01 settenthstimerstatic(var_05);
	if(!common_scripts\utility::flag_exist("individual_timers"))
	{
		return;
	}

	if(common_scripts\utility::flag("individual_timers"))
	{
		return;
	}

	challenge_timer_destroy(param_00,param_01);
}

//Function Number: 31
challenge_timer_destroy_prematurely(param_00,param_01)
{
	level waittill("new_challenge_timer");
	challenge_timer_destroy(param_00,param_01,1);
}

//Function Number: 32
challenge_timer_destroy(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		param_00 thread maps\_specialops::so_remove_hud_item(param_02);
	}

	if(isdefined(param_01))
	{
		param_01 thread maps\_specialops::so_remove_hud_item(param_02);
	}
}

//Function Number: 33
validate_timer(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 <= 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 34
failure_summary_display()
{
	if(getdvarint("so_nofail"))
	{
		return;
	}

	thread maps\_specialops::so_dialog_mission_failed_generic();
	missionfailed();
	maps\_endmission::so_eog_summary_calculate(0);
	specialops_mission_over_setup(0);
	level notify("so_generate_deathquote");
	maps\_endmission::so_eog_summary_display();
}

//Function Number: 35
specialops_mission_over_setup(param_00)
{
	setdvar("ui_opensummary",1);
	if(param_00)
	{
		setdvar("ui_mission_success",1);
	}
	else
	{
		setdvar("ui_mission_success",0);
	}

	if(common_scripts\utility::flag("special_op_terminated"))
	{
	}

	if(!isdefined(level.challenge_start_time))
	{
		level.challenge_start_time = gettime();
	}

	if(!isdefined(level.challenge_end_time))
	{
		level.challenge_end_time = gettime();
	}

	common_scripts\utility::flag_set("special_op_terminated");
	level notify("stop_music");
	thread maps\_utility_code::mission_recon(param_00);
	var_01 = undefined;
	if(isdefined(level.pmc_game) && level.pmc_game)
	{
		var_01 = pick_starting_location_pmc(1);
	}
	else
	{
		var_01 = pick_starting_location_so(1);
	}

	if(isdefined(var_01))
	{
		foreach(var_03 in level.players)
		{
			var_03 playersetstreamorigin(var_01);
		}
	}

	ambientstop(2);
	maps\_utility::music_stop(1);
	if(param_00)
	{
		thread specialops_mission_over_setup_success();
	}
	else
	{
		thread specialops_mission_over_setup_failure();
	}

	foreach(var_03 in level.players)
	{
		var_03 allowjump(0);
		var_03 disableweapons();
		var_03 disableusability();
		var_03 enableinvulnerability();
		var_03.ignoreme = 1;
	}

	thread specialops_blur_player_screen();
	if(param_00)
	{
		wait 0.5;
		foreach(var_03 in level.players)
		{
			var_03 setup_leaderboard_data();
		}

		wait 2.5;
		foreach(var_03 in level.players)
		{
			var_03 uploadleaderboards();
		}
	}
	else
	{
		wait 3;
	}

	thread specialops_mission_over_remove_ai();
	if(!common_scripts\utility::flag("special_op_no_unlink"))
	{
		foreach(var_03 in level.players)
		{
			var_03 unlink();
		}
	}

	foreach(var_03 in level.players)
	{
		var_03 freezecontrols(1);
	}

	specialops_mission_over_stats(param_00);
}

//Function Number: 36
setup_leaderboard_data()
{
	if(maps\_utility::is_coop() && level.players.size == 2)
	{
		self setplayerdata("round","xuidTeammate",maps\_utility::get_other_player(self) getxuid());
	}

	self setplayerdata("round","timePlayed",self.so_eog_summary_data["time"]);
	self setplayerdata("round","kills",self.so_eog_summary_data["kills"]);
	var_00 = 0;
	if(maps\_utility::is_survival())
	{
		self setplayerdata("round","score",self.so_eog_summary_data["score"]);
		self setplayerdata("round","wave",self.so_eog_summary_data["wave"]);
		var_01 = 0;
		var_02 = 0;
		if(self.stats["weapon"].size > 0)
		{
			foreach(var_04 in self.stats["weapon"])
			{
				var_01 = var_01 + var_04.shots_fired;
				var_02 = var_02 + var_04.shots_hit;
			}
		}

		self setplayerdata("round","bulletsFired",var_01);
		self setplayerdata("round","bulletsHit",var_02);
		self setplayerdata("round","headshots",self.game_performance["headshot"]);
		self setplayerdata("round","revives",self.game_performance["revives"]);
		self setplayerdata("round","credits",self.game_performance["credits"]);
		self setplayerdata("round","totalXp",self.game_performance["credits"]);
		return;
	}

	var_06 = level.so_enable_wait_for_players;
	if(isdefined(self.forcedgameskill))
	{
		var_06 = self.forcedgameskill;
	}

	self setplayerdata("round","difficulty",var_06);
	self setplayerdata("round","score",self.so_eog_summary_data["score"]);
}

//Function Number: 37
specialops_blur_player_screen()
{
	foreach(var_01 in level.players)
	{
		wait 0.1;
		var_01 setblurforplayer(6,1);
	}
}

//Function Number: 38
specialops_mission_over_remove_ai()
{
	wait 0.25;
	var_00 = getaiarray();
	var_00 = maps\_utility::array_merge(var_00,getaispeciesarray("axis","dog"));
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.so_no_mission_over_delete) && var_02.so_no_mission_over_delete == 1)
		{
			continue;
		}

		if(isdefined(var_02.magic_bullet_shield))
		{
			var_02 maps\_utility::stop_magic_bullet_shield();
		}

		var_02 delete();
	}
}

//Function Number: 39
specialops_mission_over_setup_success()
{
	common_scripts\utility::flag_set("special_op_succeeded");
	foreach(var_01 in level.players)
	{
		var_02 = maps\_hud_util::create_client_overlay("white",0,var_01);
		var_02.color = (0.7,0.7,1);
		var_02 thread maps\_hud_util::fade_over_time(0.25,2);
	}

	if(isdefined(level.suppress_challenge_success_print))
	{
		return;
	}

	var_04 = maps\_specialops::so_create_hud_item(3,0,&"SPECIAL_OPS_CHALLENGE_SUCCESS");
	var_04.alignx = "center";
	var_04.horzalign = "center";
	var_04 set_hudelem_blue();
	var_04 setpulsefx(60,2500,500);
	wait 1.5;
	var_05 = level.so_campaign;
	if(var_05 == "hijack" || var_05 == "fso")
	{
		var_05 = "delta";
	}

	maps\_utility::music_play("so_victory_" + var_05,undefined,0,1);
}

//Function Number: 40
specialops_mission_over_setup_failure()
{
	common_scripts\utility::flag_set("special_op_failed");
	var_00 = maps\_specialops::so_create_hud_item(3,0,&"SPECIAL_OPS_CHALLENGE_FAILURE");
	var_00.hidewhendead = 0;
	var_00.alignx = "center";
	var_00.horzalign = "center";
	var_00 set_hudelem_red();
	var_00 setpulsefx(60,2500,500);
	foreach(var_02 in level.players)
	{
		var_03 = maps\_hud_util::create_client_overlay("white",0,var_02);
		var_03.color = (1,0.4,0.4);
		var_03 thread maps\_hud_util::fade_over_time(0.25,2);
	}

	wait 1.5;
	var_05 = level.so_campaign;
	if(var_05 == "hijack" || var_05 == "fso")
	{
		var_05 = "delta";
	}

	maps\_utility::music_play("so_defeat_" + var_05,undefined,0,1);
}

//Function Number: 41
is_current_level_locked()
{
	var_00 = tablelookup("sp/specOpsTable.csv",1,level.script,13);
	var_01 = int(tablelookup("sp/specOpsTable.csv",1,var_00,5));
	var_02 = maps\_rank::getrank();
	return var_02 < var_01;
}

//Function Number: 42
is_so_player_signed_in()
{
	return 1;
}

//Function Number: 43
can_save_to_profile()
{
	return is_so_player_signed_in() && !is_current_level_locked();
}

//Function Number: 44
specialops_achievement_by_stars(param_00)
{
	if(maps\_utility::is_survival())
	{
	}
}

//Function Number: 45
get_total_mode_stars(param_00,param_01,param_02)
{
	var_03 = 0;
	for(var_04 = param_01;var_04 < param_02;var_04++)
	{
		var_03 = var_03 + int(max(0,int(param_00[var_04]) - 1));
	}

	return var_03;
}

//Function Number: 46
get_num_of_levels_with_star(param_00,param_01)
{
	var_02 = param_00.size;
	if(var_02 > level.specopssettings.levels.size)
	{
		var_02 = level.specopssettings.levels.size;
	}

	var_03 = 0;
	for(var_04 = 0;var_04 < var_02;var_04++)
	{
		if(max(0,int(param_00[var_04]) - 1) >= param_01)
		{
			var_03++;
		}
	}

	return var_03;
}

//Function Number: 47
specialops_mission_over_stats(param_00)
{
	if(!isdefined(param_00) || !param_00)
	{
		return;
	}

	foreach(var_02 in level.players)
	{
		if(!var_02 can_save_to_profile())
		{
			var_02.eog_noreward = 1;
		}
	}

	if(issplitscreen() && level.ps3)
	{
		level.player2.eog_noreward = 0;
	}

	var_04 = tablelookup("sp/specOpsTable.csv",1,level.script,9);
	if(isdefined(var_04) && var_04 != "")
	{
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02.eog_noreward) && var_02.eog_noreward)
			{
				continue;
			}

			var_06 = var_02 getlocalplayerprofiledata(var_04);
			if(!isdefined(var_06))
			{
				continue;
			}

			var_07 = var_06 == 0;
			level.never_played = 0;
			if(var_07)
			{
				level.never_played = 1;
			}

			var_08 = var_02.so_eog_summary_data["score"];
			if(var_07 || var_08 > var_06)
			{
				var_02 setlocalplayerprofiledata(var_04,var_08);
			}

			if(!var_07 && var_08 > var_06)
			{
				var_02.eog_bestscore = 1;
				var_02.eog_bestscore_value = var_08;
			}
		}
	}

	var_0A = level.specopssettings maps\_endmission::getlevelindex(level.script);
	if(!isdefined(var_0A))
	{
		missionsuccess(level.script);
		return;
	}

	level.specopssettings maps\_endmission::setsolevelcompleted(var_0A);
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.eog_noreward) && var_02.eog_noreward)
		{
			continue;
		}

		var_0C = var_02 getlocalplayerprofiledata("missionSOHighestDifficulty");
		if(!isdefined(var_0C))
		{
			continue;
		}

		var_0D = int(tablelookup("sp/specopstable.csv",0,"survival_count",1));
		var_0E = int(tablelookup("sp/specopstable.csv",0,"mission_count",1));
		var_0F = 0;
		var_10 = 0;
		if(maps\_utility::is_survival())
		{
			var_0F = get_total_mode_stars(var_0C,0,var_0D);
			var_11 = 100 * var_0F / var_0D * 3;
		}
		else
		{
			var_0F = get_total_mode_stars(var_0C,var_0D,var_0D + var_0E);
			var_11 = 100 * var_0F / var_0E * 3;
		}

		if(int(var_11 * 100) % 100 >= 0.5)
		{
			var_10 = int(var_11) + 1;
		}
		else
		{
			var_10 = int(var_11);
		}

		var_02 thread maps\_specialops::so_achievement_update("BRAG_RAGS");
		var_02 thread maps\_specialops::so_achievement_update("TACTICIAN");
		var_02 thread maps\_specialops::so_achievement_update("OVERACHIEVER");
		var_16 = var_02 getlocalplayerprofiledata("percentCompleteSO");
		var_17 = int(var_16 / 100);
		var_18 = var_02 maps\_rank::getrank();
		if(maps\_utility::is_survival())
		{
			var_19 = var_18 + var_17 * 100;
		}
		else
		{
			var_19 = var_18 + var_0F * 100;
		}

		var_02 setlocalplayerprofiledata("percentCompleteSO",var_19);
	}

	updategamerprofileall();
}

//Function Number: 48
wait_all_players_are_touching(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger");
		if(!maps\_utility::is_coop())
		{
			return;
		}

		level.player thread waiting_message_hide();
		level.player2 thread waiting_message_hide();
		if(!level.player istouching(param_00))
		{
			level.player2 thread display_waiting_message();
			continue;
		}

		if(!level.player2 istouching(param_00))
		{
			level.player thread display_waiting_message();
			continue;
		}

		break;
	}
}

//Function Number: 49
wait_all_players_have_touched(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	for(;;)
	{
		param_00 waittill("trigger");
		if(!maps\_utility::is_coop())
		{
			return;
		}

		level.player thread waiting_message_hide();
		level.player2 thread waiting_message_hide();
		if(level.player istouching(param_00))
		{
			var_02 = 1;
			if(!var_03 && !level.player2 istouching(param_00))
			{
				thread determine_waiting_message(level.player,param_01);
				continue;
			}
		}

		if(level.player2 istouching(param_00))
		{
			var_03 = 1;
			if(!var_02 && !level.player istouching(param_00))
			{
				thread determine_waiting_message(level.player2,param_01);
				continue;
			}
		}

		break;
	}
}

//Function Number: 50
disable_mission_end_trigger(param_00)
{
	level waittill("special_op_terminated");
	param_00 common_scripts\utility::trigger_off();
}

//Function Number: 51
determine_waiting_message(param_00,param_01)
{
	switch(param_01)
	{
		case "all":
			param_00 display_waiting_message();
			break;

		case "any":
			param_00 display_waiting_message();
			break;

		case "freeze":
			param_00 display_frozen_message();
			break;
	}
}

//Function Number: 52
display_waiting_message()
{
	self endon("death");
	level endon("challenge_timer_passed");
	level endon("challenge_timer_expired");
	level endon("special_op_terminated");
	level notify("players_touching_hint");
	level endon("players_touching_hint");
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.waiting_hud))
	{
		self.waiting_hud = create_waiting_message(self);
	}
	else
	{
		self.waiting_hud.alpha = 1;
	}

	wait 0.05;
	self.waiting_hud fadeovertime(0.25);
	self.waiting_hud.alpha = 0;
}

//Function Number: 53
display_frozen_message()
{
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.frozen_and_waiting) && self.frozen_and_waiting)
	{
		return;
	}

	self.frozen_and_waiting = 1;
	self enableinvulnerability();
	self freezecontrols(1);
	self.ignoreme = 1;
	self setblurforplayer(6,1);
	self.waiting_hud = create_waiting_message(self);
}

//Function Number: 54
create_waiting_message(param_00)
{
	self notify("rebuilding_waiting_hud");
	self endon("rebuilding_waiting_hud");
	var_01 = maps\_specialops::so_create_hud_item(3,0,&"SPECIAL_OPS_WAITING_OTHER_PLAYER",param_00);
	var_01.alignx = "center";
	var_01.horzalign = "center";
	var_01 set_hudelem_blue();
	thread waiting_message_delete_on_so_end(var_01);
	return var_01;
}

//Function Number: 55
waiting_message_hide()
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.waiting_hud))
	{
		return;
	}

	if(isdefined(self.frozen_and_waiting) && self.frozen_and_waiting)
	{
		return;
	}

	self.waiting_hud fadeovertime(0.25);
	self.waiting_hud.alpha = 0;
}

//Function Number: 56
waiting_message_delete_on_so_end(param_00)
{
	self endon("rebuilding_waiting_hud");
	level waittill("special_op_terminated");
	if(isdefined(param_00))
	{
		param_00 destroy();
	}
}

//Function Number: 57
disable_saving()
{
	common_scripts\utility::flag_set("disable_autosaves");
	for(;;)
	{
		common_scripts\utility::flag_wait("can_save");
		common_scripts\utility::flag_clear("can_save");
	}
}

//Function Number: 58
disable_escape_warning()
{
	if(common_scripts\utility::flag("player_has_escaped"))
	{
		return 1;
	}

	if(is_touching_escape_trigger())
	{
		return 0;
	}

	return 1;
}

//Function Number: 59
is_touching_escape_trigger()
{
	if(!isdefined(level.escape_warning_triggers))
	{
		return 0;
	}

	foreach(var_01 in level.escape_warning_triggers)
	{
		if(self istouching(var_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 60
ping_escape_warning()
{
	if(isdefined(self.ping_escape_splash))
	{
		return;
	}

	self endon("death");
	self.ping_escape_splash = maps\_specialops::so_create_hud_item(3.5,0,&"SPECIAL_OPS_ESCAPE_WARNING",self);
	self.ping_escape_splash.alignx = "center";
	self.ping_escape_splash.horzalign = "center";
	while(ping_escape_warning_valid())
	{
		self.ping_escape_splash.alpha = 1;
		self.ping_escape_splash fadeovertime(1);
		self.ping_escape_splash.alpha = 0.5;
		self.ping_escape_splash.fontscale = 1.5;
		self.ping_escape_splash changefontscaleovertime(1);
		self.ping_escape_splash.fontscale = 1;
		wait 1;
	}

	self.ping_escape_splash.alpha = 0.5;
	self.ping_escape_splash fadeovertime(0.25);
	self.ping_escape_splash.alpha = 0;
	wait 0.25;
	self.escape_hint_active = undefined;
	if(isdefined(self.ping_escape_splash))
	{
		self.ping_escape_splash destroy();
	}
}

//Function Number: 61
ping_escape_warning_valid()
{
	if(common_scripts\utility::flag("special_op_terminated"))
	{
		return 0;
	}

	if(!is_touching_escape_trigger())
	{
		return 0;
	}

	return 1;
}

//Function Number: 62
enable_escape_failure_auto()
{
	level endon("special_op_terminated");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isplayer(var_00))
		{
			continue;
		}

		if(isdefined(var_00.so_ignore_escape_failure) && var_00.so_ignore_escape_failure)
		{
			continue;
		}

		break;
	}

	maps\_specialops::so_force_deadquote("@DEADQUOTE_SO_LEFT_PLAY_AREA");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 63
enable_escape_warning_auto_init()
{
	if(common_scripts\utility::flag_exist("so_escape_warning") && common_scripts\utility::flag("so_escape_warning"))
	{
		return;
	}

	common_scripts\utility::flag_init("so_escape_warning");
	foreach(var_01 in level.players)
	{
		var_01 maps\_utility::ent_flag_init("so_escape_hint_active");
	}
}

//Function Number: 64
enable_escape_warning_auto()
{
	level endon("special_op_terminated");
	enable_escape_warning_auto_init();
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isplayer(var_00))
		{
			continue;
		}

		if(isdefined(var_00.so_ignore_escape_failure) && var_00.so_ignore_escape_failure)
		{
			continue;
		}

		var_00 thread show_escape_warning_auto(self);
	}
}

//Function Number: 65
show_escape_warning_auto(param_00)
{
	if(maps\_utility::ent_flag("so_escape_hint_active"))
	{
		return;
	}

	maps\_utility::ent_flag_set("so_escape_hint_active");
	thread ping_escape_warning_auto(param_00);
}

//Function Number: 66
ping_escape_warning_auto(param_00)
{
	self notify("so_escape_hint_ping");
	self endon("so_escape_hint_ping");
	thread remove_escape_warning_auto(param_00);
	if(!isdefined(self.ping_escape_splash_auto))
	{
		self.ping_escape_splash_auto = maps\_specialops::so_create_hud_item(3.5,0,&"SPECIAL_OPS_ESCAPE_WARNING",self);
		self.ping_escape_splash_auto.alignx = "center";
		self.ping_escape_splash_auto.horzalign = "center";
		if(isdefined(level.so_escape_warning_colorfunc))
		{
			self.ping_escape_splash_auto thread [[ level.so_escape_warning_colorfunc ]]();
		}
	}

	while(ping_escape_warning_auto_valid())
	{
		self.ping_escape_splash_auto.alpha = 1;
		self.ping_escape_splash_auto fadeovertime(1);
		self.ping_escape_splash_auto.alpha = 0.5;
		self.ping_escape_splash_auto.fontscale = 1.5;
		self.ping_escape_splash_auto changefontscaleovertime(1);
		self.ping_escape_splash_auto.fontscale = 1;
		wait 1;
	}

	self.ping_escape_splash_auto.alpha = 0.5;
	self.ping_escape_splash_auto fadeovertime(0.25);
	self.ping_escape_splash_auto.alpha = 0;
	wait 0.25;
	self.ping_escape_splash_auto destroy();
}

//Function Number: 67
remove_escape_warning_auto(param_00)
{
	while(self istouching(param_00))
	{
		wait 0.05;
	}

	maps\_utility::ent_flag_clear("so_escape_hint_active");
}

//Function Number: 68
ping_escape_warning_auto_valid()
{
	if(!isalive(self))
	{
		return 0;
	}

	if(common_scripts\utility::flag("special_op_terminated"))
	{
		return 0;
	}

	return maps\_utility::ent_flag("so_escape_hint_active");
}

//Function Number: 69
so_dialog_play(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		wait param_01;
	}

	if(isdefined(param_02) && param_02)
	{
		maps\_utility::radio_dialogue_stop();
	}

	maps\_utility::radio_dialogue(param_00);
}

//Function Number: 70
specialops_dialog_init()
{
	level.scr_radio["so_tf_1_plyr_prep"] = "so_tf_1_plyr_prep";
	level.scr_radio["so_tf_1_success_generic"] = "so_tf_1_success_generic";
	level.scr_radio["so_tf_1_success_jerk"] = "so_tf_1_success_jerk";
	level.scr_radio["so_tf_1_success_best"] = "so_tf_1_success_best";
	level.scr_radio["so_tf_1_fail_generic"] = "so_tf_1_fail_generic";
	level.scr_radio["so_tf_1_fail_generic_jerk"] = "so_tf_1_fail_generic_jerk";
	level.scr_radio["so_tf_1_fail_time"] = "so_tf_1_fail_time";
	level.scr_radio["so_tf_1_fail_bleedout"] = "so_tf_1_fail_bleedout";
	level.scr_radio["so_tf_1_time_generic"] = "so_tf_1_time_generic";
	level.scr_radio["so_tf_1_time_hurry"] = "so_tf_1_time_hurry";
	level.scr_radio["so_tf_1_civ_kill_warning"] = "so_tf_1_civ_kill_warning";
	level.scr_radio["so_tf_1_progress_5more"] = "so_tf_1_progress_5more";
	level.scr_radio["so_tf_1_progress_4more"] = "so_tf_1_progress_4more";
	level.scr_radio["so_tf_1_progress_3more"] = "so_tf_1_progress_3more";
	level.scr_radio["so_tf_1_progress_2more"] = "so_tf_1_progress_2more";
	level.scr_radio["so_tf_1_progress_1more"] = "so_tf_1_progress_1more";
	level.scr_radio["so_tf_1_time_status_late"] = "so_tf_1_time_status_late";
	level.scr_radio["so_tf_1_time_status_good"] = "so_tf_1_time_status_good";
	level.scr_radio["so_tf_1_progress_3quarter"] = "so_tf_1_progress_3quarter";
	level.scr_radio["so_tf_1_progress_half"] = "so_tf_1_progress_half";
	level.scr_radio["so_tf_1_progress_quarter"] = "so_tf_1_progress_quarter";
}

//Function Number: 71
set_hudelem_white()
{
	maps\_specialops::set_hud_white();
}

//Function Number: 72
set_hudelem_blue()
{
	maps\_specialops::set_hud_blue();
}

//Function Number: 73
set_hudelem_green()
{
	maps\_specialops::set_hud_green();
}

//Function Number: 74
set_hudelem_yellow()
{
	maps\_specialops::set_hud_yellow();
}

//Function Number: 75
set_hudelem_red()
{
	maps\_specialops::set_hud_red();
}

//Function Number: 76
set_hudelem_grey()
{
	maps\_specialops::set_hud_grey();
}

//Function Number: 77
so_hud_pulse_single(param_00,param_01,param_02)
{
	self endon("update_hud_pulse");
	self endon("destroying");
	self endon("death");
	self.fontscale = param_00;
	self changefontscaleovertime(param_02);
	self.fontscale = param_01;
	wait param_02;
}

//Function Number: 78
so_hud_pulse_loop()
{
	self endon("update_hud_pulse");
	self endon("destroying");
	self endon("death");
	if(self.pulse_start_big)
	{
		so_hud_pulse_single(self.pulse_scale_big,self.pulse_scale_loop_normal,self.var_184D);
	}

	while(isdefined(self.pulse_bounds) && self.pulse_bounds)
	{
		so_hud_pulse_single(self.pulse_scale_loop_normal,self.pulse_scale_loop_big,self.pulse_time_loop);
		so_hud_pulse_single(self.pulse_scale_loop_big,self.pulse_scale_loop_normal,self.pulse_time_loop);
	}
}

//Function Number: 79
so_hud_pulse_init()
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(!isdefined(self.var_184D))
	{
		self.var_184D = 0.5;
	}

	if(!isdefined(self.pulse_scale_normal))
	{
		self.pulse_scale_normal = 1;
	}

	if(!isdefined(self.pulse_scale_big))
	{
		self.pulse_scale_big = 1.6;
	}

	if(!isdefined(self.pulse_bounds))
	{
		self.pulse_bounds = 0;
	}

	if(!isdefined(self.pulse_time_loop))
	{
		self.pulse_time_loop = 1;
	}

	if(!isdefined(self.pulse_scale_loop_normal))
	{
		self.pulse_scale_loop_normal = 1;
	}

	if(!isdefined(self.pulse_scale_loop_big))
	{
		self.pulse_scale_loop_big = 1.15;
	}

	if(!isdefined(self.pulse_start_big))
	{
		self.pulse_start_big = 1;
	}

	return 1;
}

//Function Number: 80
specialops_detect_death()
{
	level endon("special_op_terminated");
	common_scripts\utility::flag_init("so_player_death_nofail");
	common_scripts\utility::array_thread(level.players,::specialops_detect_player_death);
	level waittill("so_player_has_died");
	if(common_scripts\utility::flag("so_player_death_nofail"))
	{
		return;
	}

	maps\_utility::missionfailedwrapper();
}

//Function Number: 81
specialops_detect_player_death()
{
	level endon("special_op_terminated");
	self waittill("death");
	level notify("so_player_has_died");
}

//Function Number: 82
so_special_failure_hint_reset_dvars(param_00)
{
	setdvar("ui_dog_death",0);
	setdvar("ui_vehicle_death",0);
	setdvar("ui_destructible_death",0);
	setdvar("ui_barrel_death",0);
	setdvar("ui_grenade_death",0);
	setdvar("ui_time_failure",0);
	setdvar("ui_ff_death",0);
	setdvar("ui_juggernaut_death",0);
	setdvar("ui_bled_out",0);
	setdvar("ui_icon_partner",0);
	setdvar("ui_icon_obj",0);
	setdvar("ui_icon_obj_offscreen",0);
	setdvar("ui_icon_stars",0);
	setdvar("ui_icon_claymore",0);
	setdvar("ui_icon_stealth_stance",0);
	if(isdefined(param_00))
	{
		setdvar(param_00,1);
	}
}

//Function Number: 83
so_special_failure_hint()
{
	so_special_failure_hint_reset_dvars();
	foreach(var_01 in level.players)
	{
		var_01 thread maps\_load::player_throwgrenade_timer();
		var_01 thread so_special_death_hint_tracker();
	}

	level waittill("so_generate_deathquote");
	maps\_quotes::setdeadquote_so();
}

//Function Number: 84
so_special_death_hint_tracker()
{
	level endon("so_special_failure_hint_set");
	self waittill("death",var_00,var_01,var_02);
	if(isdefined(self.coop_death_reason))
	{
		var_00 = self.coop_death_reason["attacker"];
		var_01 = self.coop_death_reason["cause"];
		var_02 = self.coop_death_reason["weapon_name"];
	}

	if(so_claymore_death(var_01,var_02))
	{
		return;
	}

	if(so_friendly_fire_death(var_00))
	{
		return;
	}

	if(so_radiation_death(var_00))
	{
		return;
	}

	if(so_dog_death(var_00))
	{
		return;
	}

	if(so_juggernaut_death(var_00))
	{
		return;
	}

	if(so_grenade_suicide_death(var_01))
	{
		return;
	}

	if(so_destructible_death(var_00,var_01))
	{
		return;
	}

	if(so_exploding_barrel_death(var_01))
	{
		return;
	}

	if(so_grenade_regular_death(var_01))
	{
		return;
	}

	if(so_vehicle_death(var_00,var_01))
	{
	}
}

//Function Number: 85
so_claymore_death(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_01) || isdefined(param_01) && param_01 != "claymore")
	{
		return 0;
	}

	return 1;
}

//Function Number: 86
so_friendly_fire_death(param_00)
{
	if(!maps\_utility::is_coop())
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = maps\_utility::get_other_player(self);
	if(var_01 != param_00)
	{
		return 0;
	}

	so_special_failure_hint_set("@DEADQUOTE_SO_FRIENDLY_FIRE_KILL","ui_ff_death");
	return 1;
}

//Function Number: 87
so_radiation_death(param_00)
{
	if(!isdefined(param_00) || param_00.classname != "worldspawn")
	{
		return 0;
	}

	if(!isdefined(self.radiationdeath) || !self.radiationdeath)
	{
		return 0;
	}

	so_special_failure_hint_set("@SCRIPT_RADIATION_DEATH");
	return 1;
}

//Function Number: 88
so_dog_death(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.weapon))
	{
		return 0;
	}

	if(param_00.weapon != "dog_bite")
	{
		return 0;
	}

	common_scripts\utility::flag_set("special_op_no_unlink");
	so_special_failure_hint_set(level.so_dog_death_quote,"ui_dog_death");
	return 1;
}

//Function Number: 89
so_juggernaut_death(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.juggernaut))
	{
		return 0;
	}

	var_01 = [];
	so_special_failure_hint_set_array(var_7B,"ui_juggernaut_death");
	return 1;
}

//Function Number: 90
so_destructible_death(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_01 != "MOD_EXPLOSIVE")
	{
		return 0;
	}

	if(!isdefined(param_00.destructible_type))
	{
		return 0;
	}

	if(issubstr(param_00.destructible_type,"vehicle"))
	{
		so_special_failure_hint_set("@SCRIPT_EXPLODING_VEHICLE_DEATH","ui_vehicle_death");
	}
	else
	{
		so_special_failure_hint_set("@SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH","ui_destructible_death");
	}

	return 1;
}

//Function Number: 91
so_exploding_barrel_death(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 != "MOD_EXPLOSIVE")
	{
		return 0;
	}

	if(!isdefined(level.lastexplodingbarrel))
	{
		return 0;
	}

	if(gettime() != level.lastexplodingbarrel["time"])
	{
		return 0;
	}

	var_01 = distance(self.origin,level.lastexplodingbarrel["origin"]);
	if(var_01 > level.lastexplodingbarrel["radius"])
	{
		return 0;
	}

	so_special_failure_hint_set("@SCRIPT_EXPLODING_BARREL_DEATH","ui_barrel_death");
	return 1;
}

//Function Number: 92
so_grenade_suicide_death(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 != "MOD_SUICIDE")
	{
		return 0;
	}

	if(self.lastgrenadetime - gettime() > 3500)
	{
		return 0;
	}

	so_special_failure_hint_set("@SCRIPT_GRENADE_SUICIDE_COMBINED");
	return 1;
}

//Function Number: 93
so_grenade_regular_death(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 != "MOD_GRENADE" && param_00 != "MOD_GRENADE_SPLASH")
	{
		return 0;
	}

	so_special_failure_hint_set("@SCRIPT_GRENADE_DEATH","ui_grenade_death");
	return 1;
}

//Function Number: 94
so_vehicle_death(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_01 != "MOD_CRUSH")
	{
		return 0;
	}

	if(param_00.code_classname != "script_vehicle")
	{
		return 0;
	}

	so_special_failure_hint_set("@DEADQUOTE_SO_RUN_OVER_BY_VEHICLE");
	return 1;
}

//Function Number: 95
so_special_failure_hint_set(param_00,param_01)
{
	maps\_specialops::so_force_deadquote(param_00,param_01);
	level notify("so_special_failure_hint_set");
}

//Function Number: 96
so_special_failure_hint_set_array(param_00,param_01)
{
	maps\_specialops::so_force_deadquote_array(param_00,param_01);
	level notify("so_special_failure_hint_set");
}

//Function Number: 97
so_ai_flashed_damage_feedback()
{
	self endon("death");
	level endon("special_op_terminated");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03);
		if(!maps\_utility::is_damagefeedback_enabled())
		{
			continue;
		}

		if(isdefined(var_03) && isplayer(var_03))
		{
			var_03 maps\_damagefeedback::updatedamagefeedback(self);
		}
	}
}

//Function Number: 98
so_mission_complete_achivements()
{
	if(!maps\_utility::is_survival() && level.players.size == 2 && level.players[0].so_eog_summary_data["kills"] > 0 && level.players[0].so_eog_summary_data["kills"] == level.players[1].so_eog_summary_data["kills"])
	{
		level.players[0] maps\_utility::player_giveachievement_wrapper("FIFTY_FIFTY");
		level.players[1] maps\_utility::player_giveachievement_wrapper("FIFTY_FIFTY");
	}

	if(level.players.size >= 2 && level.so_enable_wait_for_players >= 2)
	{
		var_00 = 0;
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02.laststand_down_count) && var_02.laststand_down_count > 0)
			{
				var_00 = 1;
			}

			if(var_02 maps\_utility::get_player_gameskill() < 2)
			{
				var_00 = 1;
			}
		}

		if(!var_00)
		{
			foreach(var_02 in level.players)
			{
				var_02 maps\_utility::player_giveachievement_wrapper("NO_ASSISTANCE_REQUIRED");
			}
		}
	}
}