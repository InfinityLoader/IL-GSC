/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_specialops.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 132
 * Decompile Time: 2136 ms
 * Timestamp: 10/27/2023 2:33:15 AM
*******************************************************************/

//Function Number: 1
specialops_init()
{
	foreach(var_01 in level.players)
	{
		var_01 thread roundstat_init();
	}

	if(maps\_utility::func_E89())
	{
		maps\_gameskill::setglobaldifficulty();
		foreach(var_01 in level.players)
		{
			var_01 maps\_gameskill::func_139A();
		}
	}

	if(!isdefined(level.so_override))
	{
		level.so_override = [];
	}

	if(!isdefined(level.friendlyfire_warnings))
	{
		level.friendlyfire_warnings = 1;
	}

	level.no_friendly_fire_penalty = 1;
	precacheminimapsentrycodeassets();
	precachemenu("sp_eog_summary");
	precachemenu("coop_eog_summary");
	precachemenu("coop_eog_summary2");
	precachemenu("surHUD_display");
	precacheshellshock("so_finished");
	precacheshader("hud_show_timer");
	precacheshader("specops_ui_equipmentstore");
	precacheshader("specops_ui_weaponstore");
	precacheshader("specops_ui_airsupport");
	so_precache_strings();
	foreach(var_01 in level.players)
	{
		var_01.so_hud_show_time = gettime() + so_standard_wait() * 1000;
		var_01 maps\_utility::ent_flag_init("so_hud_can_toggle");
	}

	level.challenge_time_nudge = 30;
	level.challenge_time_hurry = 10;
	level.func_destructible_crush_player = ::func_144D;
	setsaveddvar("g_friendlyfireDamageScale",2);
	setsaveddvar("turretSentryRestrictUsageToOwner",0);
	if(isdefined(level.so_compass_zoom))
	{
		var_07 = 0;
		switch(level.so_compass_zoom)
		{
			case "close":
				var_07 = 1500;
				break;

			case "far":
				var_07 = 6000;
				break;

			default:
				var_07 = 3000;
				break;
		}

		if(!issplitscreen())
		{
			var_07 = var_07 + var_07 * 0.1;
		}

		setsaveddvar("compassmaxrange",var_07);
	}

	common_scripts\utility::flag_init("challenge_timer_passed");
	common_scripts\utility::flag_init("challenge_timer_expired");
	common_scripts\utility::flag_init("special_op_succeeded");
	common_scripts\utility::flag_init("special_op_failed");
	common_scripts\utility::flag_init("special_op_terminated");
	common_scripts\utility::flag_init("special_op_p1ready");
	common_scripts\utility::flag_init("special_op_p2ready");
	common_scripts\utility::flag_init("special_op_no_unlink");
	common_scripts\utility::flag_init("special_op_final_xp_given");
	thread maps\_specialops_code::disable_saving();
	thread maps\_specialops_code::func_13A1();
	maps\_specialops_code::specialops_dialog_init();
	if(maps\_utility::func_E89())
	{
		maps\_specialops_battlechatter::init();
	}

	if(!isdefined(level.var_80E5))
	{
		level.var_80E5 = [];
	}

	if(!maps\_utility::func_E89())
	{
		maps\_utility::set_custom_gameskill_func(::maps\_gameskill::solo_player_in_special_ops);
	}
	else if(maps\_utility::is_survival())
	{
		maps\_utility::set_custom_gameskill_func(::maps\_gameskill::coop_player_in_special_ops_survival);
	}

	common_scripts\utility::array_thread(getentarray("trigger_multiple_SO_escapewarning","classname"),::maps\_specialops_code::enable_escape_warning_auto);
	common_scripts\utility::array_thread(getentarray("trigger_multiple_SO_escapefailure","classname"),::maps\_specialops_code::enable_escape_failure_auto);
	level.so_deadquotes_chance = 0.5;
	setdvar("ui_deadquote","");
	thread maps\_specialops_code::so_special_failure_hint();
	setdvar("ui_skip_level_select","1");
	setdvar("ui_opensummary",0);
	var_08 = "LB_" + level.script;
	var_09 = "";
	if(maps\_utility::func_E89())
	{
		var_08 = var_08 + "_TEAM";
	}

	if(maps\_utility::is_survival())
	{
		var_09 = " LB_EXT_" + level.script;
		if(maps\_utility::func_E89())
		{
			var_09 = var_09 + "_TEAM";
		}
	}

	precacheleaderboards(var_08 + var_09);
	maps\_specialops_code::pick_starting_location_so();
	level thread func_13B0();
	maps\_audio::aud_set_spec_ops();
	maps\_specialops_code::register_level_unlock("so_mw3_mission_2","mission");
	maps\_specialops_code::register_level_unlock("so_mw3_mission_3","mission");
	maps\_specialops_code::register_level_unlock("so_mw3_mission_4","mission");
	maps\_specialops_code::register_survival_unlock();
	maps\_rank::init();
	maps\_missions::init();
	maps\_utility::enable_damagefeedback();
	maps\_utility::add_global_spawn_function("axis",::maps\_specialops_code::func_8093);
	thread maps\_specialops_code::setup_xp();
	thread unlock_hint();
	thread func_80E7();
}

//Function Number: 2
roundstat_init()
{
	wait 0.05;
	self setplayerdata("round","kills",0);
	self setplayerdata("round","killStreak",0);
	self setplayerdata("round","deaths",0);
	self setplayerdata("round","difficulty",0);
	self setplayerdata("round","score",0);
	self setplayerdata("round","timePlayed",0);
	self setplayerdata("round","wave",0);
	self setplayerdata("round","xuidTeammate","0");
	self setplayerdata("round","totalXp",0);
	self setplayerdata("round","scoreXp",0);
	self setplayerdata("round","challengeXp",0);
}

//Function Number: 3
func_13B0()
{
	setsaveddvar("hud_fade_ammodisplay",30);
	setsaveddvar("hud_fade_stance",30);
	setsaveddvar("hud_fade_offhand",30);
	setsaveddvar("hud_fade_compass",0);
}

//Function Number: 4
so_precache_strings()
{
	precachestring(&"SPECIAL_OPS_TIME_NULL");
	precachestring(&"SPECIAL_OPS_TIME");
	precachestring(&"SPECIAL_OPS_WAITING_P1");
	precachestring(&"SPECIAL_OPS_WAITING_P2");
	precachestring(&"SPECIAL_OPS_REVIVE_NAG_HINT");
	precachestring(&"SPECIAL_OPS_CHALLENGE_SUCCESS");
	precachestring(&"SPECIAL_OPS_CHALLENGE_FAILURE");
	precachestring(&"SPECIAL_OPS_FAILURE_HINT_TIME");
	precachestring(&"SPECIAL_OPS_ESCAPE_WARNING");
	precachestring(&"SPECIAL_OPS_ESCAPE_SPLASH");
	precachestring(&"SPECIAL_OPS_WAITING_OTHER_PLAYER");
	precachestring(&"SPECIAL_OPS_STARTING_IN");
	precachestring(&"SPECIAL_OPS_UI_TIME");
	precachestring(&"SPECIAL_OPS_UI_KILLS");
	precachestring(&"SPECIAL_OPS_UI_DIFFICULTY");
	precachestring(&"SPECIAL_OPS_UI_PLAY_AGAIN");
	precachestring(&"SPECIAL_OPS_DASHDASH");
	precachestring(&"SPECIAL_OPS_HOSTILES");
	precachestring(&"SPECIAL_OPS_INTERMISSION_WAVENUM");
	precachestring(&"SPECIAL_OPS_INTERMISSION_WAVEFINAL");
	precachestring(&"SPECIAL_OPS_WAVENUM");
	precachestring(&"SPECIAL_OPS_WAVEFINAL");
	precachestring(&"SPECIAL_OPS_PRESS_TO_CANCEL");
	precachestring(&"SPECIAL_OPS_PLAYER_IS_READY");
	precachestring(&"SPECIAL_OPS_PRESS_TO_START");
	precachestring(&"SPECIAL_OPS_PLAYER_IS_NOT_READY");
	precachestring(&"SPECIAL_OPS_EMPTY");
}

//Function Number: 5
so_standard_wait()
{
	return 4;
}

//Function Number: 6
func_13B3()
{
	var_00 = getentarray();
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = maps\_utility::is_specialop();
	foreach(var_03 in var_00)
	{
		if(var_03 maps\_specialops_code::specialops_remove_entity_check(var_01))
		{
			var_03 delete();
		}
	}

	maps\_specialops_code::so_special_failure_hint_reset_dvars();
}

//Function Number: 7
enable_triggered_start(param_00)
{
	level endon("challenge_timer_expired");
	var_01 = getent(param_00,"script_noteworthy");
	var_01 waittill("trigger");
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 8
enable_triggered_complete(param_00,param_01,param_02)
{
	level endon("challenge_timer_expired");
	common_scripts\utility::flag_set(param_00);
	if(!isdefined(param_02))
	{
		param_02 = "freeze";
	}

	var_03 = getent(param_00,"script_noteworthy");
	thread maps\_specialops_code::disable_mission_end_trigger(var_03);
	switch(param_02)
	{
		case "all":
			maps\_specialops_code::wait_all_players_are_touching(var_03);
			break;

		case "any":
			maps\_specialops_code::wait_all_players_have_touched(var_03,param_02);
			break;

		case "freeze":
			maps\_specialops_code::wait_all_players_have_touched(var_03,param_02);
			break;
	}

	level.challenge_end_time = gettime();
	common_scripts\utility::flag_set(param_01);
}

//Function Number: 9
fade_challenge_in(param_00,param_01)
{
	if(!maps\_utility::is_survival())
	{
		foreach(var_03 in level.players)
		{
			var_03 thread enable_kill_counter();
		}
	}

	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	var_05 = 1;
	if(isdefined(level.so_waiting_for_players_alpha))
	{
		var_05 = level.so_waiting_for_players_alpha;
	}

	var_06 = maps\_hud_util::func_5BF("black",var_05);
	wait param_00;
	level notify("challenge_fading_in");
	var_07 = 1;
	var_06 thread maps\_hud_util::fade_over_time(0,var_07);
	level thread maps\_utility::func_FEC("challenge_fadein_complete",var_07);
	if(common_scripts\utility::flag_exist("slamzoom_finished"))
	{
		common_scripts\utility::flag_wait("slamzoom_finished");
	}

	wait 0.75;
	if(!isdefined(param_01) || param_01)
	{
		thread func_143A();
	}
}

//Function Number: 10
fade_challenge_out(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(isdefined(param_00))
	{
		common_scripts\utility::flag_wait(param_00);
	}

	var_02 = undefined;
	if(maps\_utility::is_survival())
	{
		var_02 = 1;
		if(!param_01)
		{
			param_01 = level.var_13BE < level.congrat_min_wave;
		}
	}

	if(!param_01)
	{
		thread so_dialog_mission_success(var_02);
	}

	maps\_endmission::so_eog_summary_calculate(1);
	maps\_specialops_code::specialops_mission_over_setup(1);
	maps\_specialops_code::func_8094();
	if(maps\_utility::is_survival())
	{
		level notify("so_generate_deathquote");
	}

	maps\_endmission::so_eog_summary_display();
}

//Function Number: 11
override_summary_time(param_00)
{
	self.var_128E["time"] = maps\_utility::round_millisec_on_sec(param_00,1,0);
}

//Function Number: 12
func_13C5(param_00)
{
	self.var_128E["kills"] = param_00;
}

//Function Number: 13
override_summary_score(param_00)
{
	self.var_128E["score"] = param_00;
}

//Function Number: 14
enable_countdown_timer(param_00,param_01,param_02,param_03)
{
	level endon("special_op_terminated");
	if(!isdefined(param_02))
	{
		param_02 = &"SPECIAL_OPS_STARTING_IN";
	}

	var_04 = func_127E(0,func_1423(),param_02);
	var_04 setpulsefx(50,param_00 * 1000,500);
	var_05 = func_127E(0,func_1423());
	var_05 thread show_countdown_timer_time(param_00,param_03);
	wait param_00;
	level.player playsound("arcademode_zerodeaths");
	if(isdefined(param_01) && param_01)
	{
		level.challenge_start_time = gettime();
	}

	thread func_13C8(var_04,var_05);
}

//Function Number: 15
func_13C8(param_00,param_01)
{
	wait 1;
	param_00 destroy();
	param_01 destroy();
}

//Function Number: 16
show_countdown_timer_time(param_00,param_01)
{
	self.alignx = "left";
	self settenthstimer(param_00);
	self.alpha = 0;
	if(!isdefined(param_01))
	{
		param_01 = 0.625;
	}

	wait param_01;
	param_00 = int(param_00 - param_01 * 1000);
	self setpulsefx(50,param_00,500);
	self.alpha = 1;
}

//Function Number: 17
enable_challenge_timer(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00))
	{
		if(!common_scripts\utility::flag_exist(param_00))
		{
			common_scripts\utility::flag_init(param_00);
		}

		level.start_flag = param_00;
	}

	if(isdefined(param_01))
	{
		if(!common_scripts\utility::flag_exist(param_01))
		{
			common_scripts\utility::flag_init(param_01);
		}

		level.passed_flag = param_01;
	}

	if(!isdefined(param_02))
	{
		param_02 = &"SPECIAL_OPS_TIME";
	}

	if(!isdefined(level.challenge_time_beep_start))
	{
		level.challenge_time_beep_start = level.challenge_time_hurry;
	}

	level.so_challenge_time_beep = level.challenge_time_beep_start + 1;
	foreach(var_05 in level.players)
	{
		var_05 thread maps\_specialops_code::challenge_timer_player_setup(param_00,param_01,param_02,param_03);
	}
}

//Function Number: 18
enable_challenge_counter(param_00,param_01,param_02)
{
	if(!isdefined(self.hud_so_counter_messages))
	{
		self.hud_so_counter_messages = [];
	}

	if(!isdefined(self.hud_so_counter_values))
	{
		self.hud_so_counter_values = [];
	}

	thread enable_challenge_counter_think(param_00,param_01,param_02);
}

//Function Number: 19
enable_challenge_counter_think(param_00,param_01,param_02)
{
	level endon("special_op_terminated");
	disable_challenge_counter(param_00);
	self endon(func_13D6(param_00));
	var_03 = func_1423();
	self.hud_so_counter_messages[param_00] = func_127E(param_00,var_03,param_01,self);
	self.hud_so_counter_values[param_00] = func_127E(param_00,var_03,undefined,self);
	self.hud_so_counter_values[param_00] settext(0);
	self.hud_so_counter_values[param_00].alignx = "left";
	childthread info_hud_handle_fade(self.hud_so_counter_messages[param_00]);
	childthread info_hud_handle_fade(self.hud_so_counter_values[param_00]);
	if(!isdefined(level.var_8095) || !level.var_8095)
	{
		common_scripts\utility::flag_wait(level.start_flag);
	}

	for(;;)
	{
		self waittill(param_02,var_04);
		self.hud_so_counter_values[param_00] settext(var_04);
	}
}

//Function Number: 20
disable_challenge_counter(param_00)
{
	param_00 = int(param_00);
	self notify(func_13D6(param_00));
	if(isdefined(self.hud_so_counter_messages[param_00]))
	{
		self.hud_so_counter_messages[param_00] destroy();
	}

	if(isdefined(self.hud_so_counter_values[param_00]))
	{
		self.hud_so_counter_values[param_00] destroy();
	}
}

//Function Number: 21
disable_challenge_counter_all()
{
	if(isdefined(self.hud_so_counter_messages))
	{
		foreach(var_02, var_01 in self.hud_so_counter_messages)
		{
			disable_challenge_counter(var_02);
		}

		self.hud_so_counter_messages = [];
		self.hud_so_counter_values = [];
	}
}

//Function Number: 22
func_13D6(param_00)
{
	param_00 = int(param_00);
	return "challenge_counter_disable" + param_00;
}

//Function Number: 23
enable_kill_counter()
{
	level.var_13D8 = 2;
	level endon("special_op_terminated");
	self notify("enabling_kill_counter");
	self endon("enabling_kill_counter");
	thread enable_challenge_counter(level.var_13D8,&"SPECIAL_OPS_KILL_COUNT","ui_kill_count");
	thread enable_kill_counter_think(level.var_13D8);
}

//Function Number: 24
enable_kill_counter_think(param_00)
{
	level endon("special_op_terminated");
	self endon(func_13D6(param_00));
	for(;;)
	{
		level waittill("specops_player_kill",var_01,var_02);
		if(self == var_01)
		{
			self notify("ui_kill_count",var_01.stats["kills"]);
		}
	}
}

//Function Number: 25
func_13DA()
{
	if(!isdefined(level.var_13D8))
	{
		return;
	}

	disable_challenge_counter(level.var_13D8);
}

//Function Number: 26
disable_challenge_timer()
{
	level notify("stop_challenge_timer_thread");
}

//Function Number: 27
so_get_difficulty_menu_string(param_00)
{
	param_00 = common_scripts\utility::ter_op(isdefined(param_00),param_00,level.specops_reward_gameskill);
	var_01 = "";
	switch(int(param_00))
	{
		case 0:
			var_01 = "@MENU_RECRUIT";
			break;

		case 1:
			var_01 = "@MENU_REGULAR";
			break;

		case 2:
			var_01 = "@MENU_HARDENED";
			break;

		case 3:
			var_01 = "@MENU_VETERAN";
			break;

		default:
			var_01 = "@MENU_REGULAR";
			break;
	}

	return var_01;
}

//Function Number: 28
func_13DC()
{
	if(!isdefined(level.var_13DD))
	{
		return;
	}

	if(!maps\_utility::func_E89() || issplitscreen())
	{
		return;
	}

	level.so_waiting_for_players = 1;
	level.so_waiting_for_players_alpha = 0.85;
	level.player thread so_wait_for_player_ready("special_op_p1ready",2);
	level.player2 thread so_wait_for_player_ready("special_op_p2ready",3.25);
	var_00 = maps\_hud_util::func_5BF("black",1);
	var_00 maps\_hud_util::fade_over_time(level.so_waiting_for_players_alpha,1);
	while(!common_scripts\utility::flag("special_op_p1ready") || !common_scripts\utility::flag("special_op_p2ready"))
	{
		wait 0.05;
	}

	var_01 = 1;
	level.player thread so_wait_for_player_ready_cleanup(var_01);
	level.player2 thread so_wait_for_player_ready_cleanup(var_01);
	wait var_01;
	var_00 destroy();
	level.so_waiting_for_players = undefined;
}

//Function Number: 29
so_wait_for_player_ready(param_00,param_01)
{
	self endon("stop_waiting_start");
	self freezecontrols(1);
	self disableweapons();
	self.waiting_to_start_hud = func_127E(0,0,&"SPECIAL_OPS_PRESS_TO_START",self,1);
	self.waiting_to_start_hud.alignx = "center";
	self.waiting_to_start_hud.horzalign = "center";
	self.ready_indication_hud = func_127E(param_01,0,&"SPECIAL_OPS_PLAYER_IS_NOT_READY",undefined,1);
	self.ready_indication_hud.alignx = "center";
	self.ready_indication_hud.horzalign = "center";
	self.ready_indication_hud settext(self.playername);
	self.ready_indication_hud set_hud_yellow();
	wait 0.05;
	self setblurforplayer(6,0);
	notifyoncommand(self.unique_id + "_is_ready","+gostand");
	notifyoncommand(self.unique_id + "_is_not_ready","+stance");
	for(;;)
	{
		self waittill(self.unique_id + "_is_ready");
		common_scripts\utility::flag_set(param_00);
		self playsound("so_player_is_ready");
		self.waiting_to_start_hud.label = &"SPECIAL_OPS_PRESS_TO_CANCEL";
		self.ready_indication_hud func_141C(&"SPECIAL_OPS_PLAYER_IS_READY");
		self waittill(self.unique_id + "_is_not_ready");
		common_scripts\utility::flag_clear(param_00);
		self playsound("so_player_not_ready");
		self.waiting_to_start_hud.label = &"SPECIAL_OPS_PRESS_TO_START";
		self.ready_indication_hud so_hud_pulse_warning(&"SPECIAL_OPS_PLAYER_IS_NOT_READY");
	}
}

//Function Number: 30
so_wait_for_player_ready_cleanup(param_00)
{
	self notify("stop_waiting_start");
	self.waiting_to_start_hud thread so_remove_hud_item(1);
	wait param_00;
	self.ready_indication_hud thread so_remove_hud_item(0,1);
	self freezecontrols(0);
	self enableweapons();
	self setblurforplayer(0,0.5);
}

//Function Number: 31
attacker_is_p1(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return param_00 == level.player;
}

//Function Number: 32
attacker_is_p2(param_00)
{
	if(!maps\_utility::func_E89())
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	return param_00 == level.player2;
}

//Function Number: 33
func_13E5()
{
	level endon("special_op_terminated");
	level.escape_warning_triggers = getentarray("player_trying_to_escape","script_noteworthy");
	maps\_utility::func_13E8("player_escape_warning",&"SPECIAL_OPS_EMPTY",::maps\_specialops_code::disable_escape_warning);
	for(;;)
	{
		wait 0.05;
		foreach(var_01 in level.escape_warning_triggers)
		{
			foreach(var_03 in level.players)
			{
				if(!isdefined(var_03.escape_hint_active))
				{
					if(var_03 istouching(var_01))
					{
						var_03.escape_hint_active = 1;
						var_03 thread maps\_specialops_code::ping_escape_warning();
						var_03 maps\_utility::display_hint_timeout("player_escape_warning");
					}

					continue;
				}

				if(!isdefined(var_03.ping_escape_splash))
				{
					var_03 thread maps\_specialops_code::ping_escape_warning();
				}
			}
		}
	}
}

//Function Number: 34
enable_escape_failure()
{
	level endon("special_op_terminated");
	common_scripts\utility::flag_wait("player_has_escaped");
	level.challenge_end_time = gettime();
	func_1407("@DEADQUOTE_SO_LEFT_PLAY_AREA");
	maps\_utility::func_13EE();
}

//Function Number: 35
so_delete_all_by_type(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = [param_00,param_01,param_02,param_03,param_04];
	var_06 = common_scripts\utility::array_removeundefined(var_06);
	var_07 = getentarray();
	foreach(var_09 in var_07)
	{
		if(!isdefined(var_09.code_classname))
		{
			continue;
		}

		var_0A = isdefined(var_09.script_specialops) && var_09.script_specialops == 1;
		if(var_0A)
		{
			continue;
		}

		var_0B = isdefined(var_09.targetname) && var_09.targetname == "intelligence_item";
		if(var_0B)
		{
			continue;
		}

		foreach(var_0D in var_06)
		{
			if(var_09 [[ var_0D ]]())
			{
				if(param_05)
				{
					var_09 notify("delete");
				}

				var_09 delete();
			}
		}
	}
}

//Function Number: 36
func_13F0()
{
	if(!isdefined(self.code_classname))
	{
		return 0;
	}

	return issubstr(self.code_classname,"actor_");
}

//Function Number: 37
type_vehicle()
{
	if(!isdefined(self.code_classname))
	{
		return 0;
	}

	if(self.code_classname == "script_vehicle_collmap")
	{
		return 0;
	}

	return issubstr(self.code_classname,"script_vehicle");
}

//Function Number: 38
type_spawn_trigger()
{
	if(!isdefined(self.classname))
	{
		return 0;
	}

	if(self.classname == "trigger_multiple_spawn")
	{
		return 1;
	}

	if(self.classname == "trigger_multiple_spawn_reinforcement")
	{
		return 1;
	}

	if(self.classname == "trigger_multiple_friendly_respawn")
	{
		return 1;
	}

	if(isdefined(self.targetname) && self.targetname == "flood_spawner")
	{
		return 1;
	}

	if(isdefined(self.targetname) && self.targetname == "friendly_respawn_trigger")
	{
		return 1;
	}

	if(isdefined(self.spawnflags) && self.spawnflags & 32)
	{
		return 1;
	}

	return 0;
}

//Function Number: 39
type_trigger()
{
	if(!isdefined(self.code_classname))
	{
		return 0;
	}

	var_00 = [];
	return isdefined(var_41[self.code_classname]);
}

//Function Number: 40
type_flag_trigger()
{
	if(!isdefined(self.classname))
	{
		return 0;
	}

	var_00 = [];
	return isdefined(var_41[self.classname]);
}

//Function Number: 41
type_killspawner_trigger()
{
	if(!type_trigger())
	{
		return 0;
	}

	if(isdefined(self.var_13F6))
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
type_goalvolume()
{
	if(!isdefined(self.classname))
	{
		return 0;
	}

	if(self.classname == "info_volume" && isdefined(self.script_goalvolume))
	{
		return 1;
	}

	return 0;
}

//Function Number: 43
type_infovolume()
{
	if(!isdefined(self.classname))
	{
		return 0;
	}

	return self.classname == "info_volume";
}

//Function Number: 44
func_13FA()
{
	if(!isdefined(self.classname))
	{
		return 0;
	}

	return self.classname == "misc_turret";
}

//Function Number: 45
type_weapon_placed()
{
	if(!isdefined(self.classname) || !isdefined(self.model))
	{
		return 0;
	}

	if(strtok(self.classname,"_")[0] == "weapon")
	{
		return 1;
	}

	return 0;
}

//Function Number: 46
func_13FC()
{
	so_delete_all_by_type(::type_spawn_trigger);
}

//Function Number: 47
so_delete_all_triggers()
{
	so_delete_all_by_type(::type_trigger,::type_spawn_trigger,::type_flag_trigger,::type_killspawner_trigger);
	animscripts/battlechatter::update_bcs_locations();
}

//Function Number: 48
so_delete_all_vehicles()
{
	so_delete_all_by_type(::type_vehicle,undefined,undefined,undefined,undefined,1);
}

//Function Number: 49
func_13FF()
{
	so_delete_all_by_type(::func_13F0);
}

//Function Number: 50
so_make_specialops_ent(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00,param_01);
	so_array_make_specialops(var_03,param_02);
}

//Function Number: 51
so_make_bcslocations_specialops_ent()
{
	so_array_make_specialops(level.bcs_locations);
}

//Function Number: 52
so_array_make_specialops(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	level.so_traversed_list = [];
	func_1404(param_00,param_01);
	level.so_traversed_list = undefined;
}

//Function Number: 53
func_1404(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(maps\_utility::func_6E9(level.so_traversed_list,var_03))
		{
			continue;
		}

		level.so_traversed_list[level.so_traversed_list.size] = var_03;
		var_03.script_specialops = 1;
		if(param_01)
		{
			if(isdefined(var_03.target))
			{
				var_04 = getentarray(var_03.target,"targetname");
				func_1404(var_04,param_01);
			}

			if(isdefined(var_03.linkto))
			{
				var_04 = var_03 common_scripts\utility::get_linked_ents();
				func_1404(var_04,param_01);
			}
		}
	}
}

//Function Number: 54
so_delete_breach_ents()
{
	var_00 = getentarray("breach_solid","targetname");
	foreach(var_02 in var_00)
	{
		var_02 connectpaths();
		var_02 delete();
	}
}

//Function Number: 55
func_1407(param_00,param_01)
{
	level.var_1408 = [];
	level.var_1408[0] = param_00;
	level.so_deadquotes_chance = 1;
	maps\_specialops_code::so_special_failure_hint_reset_dvars(param_01);
}

//Function Number: 56
so_force_deadquote_array(param_00,param_01)
{
	level.var_1408 = param_00;
	level.so_deadquotes_chance = 1;
	maps\_specialops_code::so_special_failure_hint_reset_dvars(param_01);
}

//Function Number: 57
so_include_deadquote_array(param_00)
{
	if(!isdefined(level.var_1408))
	{
		level.var_1408 = [];
	}

	level.var_1408 = maps\_utility::array_merge(level.var_1408,param_00);
}

//Function Number: 58
func_127E(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_03))
	{
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	param_00 = param_00 + 2;
	var_05 = undefined;
	if(isdefined(param_03))
	{
		var_05 = newclienthudelem(param_03);
	}
	else
	{
		var_05 = newhudelem();
	}

	var_05.alignx = "right";
	var_05.aligny = "middle";
	var_05.horzalign = "right";
	var_05.vertalign = "middle";
	var_05.x = param_01;
	var_05.y = -100 + 15 * param_00;
	var_05.font = "hudsmall";
	var_05.foreground = 1;
	var_05.hidewheninmenu = 1;
	var_05.hidewhendead = 1;
	var_05.sort = 2;
	var_05 set_hud_white();
	if(isdefined(param_02))
	{
		var_05.label = param_02;
	}

	if(!isdefined(param_04) || !param_04)
	{
		if(isdefined(param_03))
		{
			if(!param_03 maps\_specialops_code::so_hud_can_show())
			{
				param_03 thread maps\_specialops_code::so_create_hud_item_delay_draw(var_05);
			}
			else if(!maps\_utility::ent_flag("so_hud_can_toggle"))
			{
				maps\_utility::func_FA4("so_hud_can_toggle");
			}
		}
	}

	return var_05;
}

//Function Number: 59
so_create_hud_item_data(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_127E(param_00,param_01,param_02,param_03,param_04);
	var_05.alignx = "left";
	return var_05;
}

//Function Number: 60
so_create_hud_item_debug(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_127E(param_00,param_01,param_02,param_03,param_04);
	var_05.alignx = "left";
	var_05.horzalign = "left";
	return var_05;
}

//Function Number: 61
func_1410(param_00)
{
	if(!maps\_specialops_code::func_1411())
	{
		return;
	}

	self notify("update_hud_pulse");
	self endon("update_hud_pulse");
	self endon("destroying");
	if(isdefined(param_00))
	{
		self.label = param_00;
	}

	if(isdefined(self.var_1412))
	{
		level.player playsound(self.var_1412);
	}

	if(isdefined(self.var_1413) && self.var_1413)
	{
		maps\_specialops_code::so_hud_pulse_loop();
		return;
	}

	maps\_specialops_code::func_1418(self.pulse_scale_big,self.pulse_scale_normal,self.pulse_time);
}

//Function Number: 62
func_1419(param_00)
{
	if(!maps\_specialops_code::func_1411())
	{
		return;
	}

	self notify("update_hud_pulse");
	self endon("update_hud_pulse");
	self endon("destroying");
	if(isdefined(param_00))
	{
		self.label = param_00;
	}

	self.var_1413 = 0;
	maps\_specialops_code::func_1418(self.fontscale,self.pulse_scale_normal,self.pulse_time);
}

//Function Number: 63
func_141A(param_00)
{
	set_hud_white();
	self.var_1413 = 0;
	func_1410(param_00);
}

//Function Number: 64
func_141B(param_00)
{
	set_hud_green();
	self.var_1413 = 1;
	func_1410(param_00);
}

//Function Number: 65
func_141C(param_00)
{
	set_hud_green();
	self.var_1413 = 0;
	func_1410(param_00);
}

//Function Number: 66
so_hud_pulse_warning(param_00)
{
	set_hud_yellow();
	self.var_1413 = 0;
	func_1410(param_00);
}

//Function Number: 67
so_hud_pulse_alarm(param_00)
{
	set_hud_red();
	self.var_1413 = 1;
	func_1410(param_00);
}

//Function Number: 68
so_hud_pulse_failure(param_00)
{
	set_hud_red();
	self.var_1413 = 0;
	func_1410(param_00);
}

//Function Number: 69
so_hud_pulse_disabled(param_00)
{
	set_hud_grey();
	self.var_1413 = 0;
	func_1410(param_00);
}

//Function Number: 70
func_1421(param_00,param_01)
{
	if(!isdefined(self.pulse_bounds))
	{
		func_141A(param_01);
		return;
	}

	foreach(var_04, var_03 in self.pulse_bounds)
	{
		if(param_00 <= var_03)
		{
			switch(var_04)
			{
				case "pulse_disabled":
					so_hud_pulse_disabled(param_01);
					break;

				case "pulse_failure":
					so_hud_pulse_failure(param_01);
					break;

				case "pulse_alarm":
					so_hud_pulse_alarm(param_01);
					break;

				case "pulse_warning":
					so_hud_pulse_warning(param_01);
					break;

				case "pulse_default":
					func_141A(param_01);
					break;

				case "pulse_close":
					func_141B(param_01);
					break;

				case "pulse_success":
					func_141C(param_01);
					break;
			}
		}
	}

	func_141A(param_01);
}

//Function Number: 71
func_1423()
{
	return -72;
}

//Function Number: 72
so_remove_hud_item(param_00,param_01)
{
	if(isdefined(param_00) && param_00)
	{
		self notify("destroying");
		self destroy();
		return;
	}

	thread func_1419();
	if(isdefined(param_01) && param_01)
	{
		self setpulsefx(0,0,500);
		wait 0.5;
	}
	else
	{
		self setpulsefx(0,1500,500);
		wait 2;
	}

	self notify("destroying");
	self destroy();
}

//Function Number: 73
set_hud_white(param_00)
{
	if(isdefined(param_00))
	{
		self.alpha = param_00;
		self.glowalpha = param_00;
	}

	self.color = (1,1,1);
	self.glowcolor = (0.6,0.6,0.6);
}

//Function Number: 74
set_hud_blue(param_00)
{
	if(isdefined(param_00))
	{
		self.alpha = param_00;
		self.glowalpha = param_00;
	}

	self.color = (0.8,0.8,1);
	self.glowcolor = (0.301961,0.301961,0.6);
}

//Function Number: 75
set_hud_green(param_00)
{
	if(isdefined(param_00))
	{
		self.alpha = param_00;
		self.glowalpha = param_00;
	}

	self.color = (0.8,1,0.8);
	self.glowcolor = (0.301961,0.6,0.301961);
}

//Function Number: 76
set_hud_yellow(param_00)
{
	if(isdefined(param_00))
	{
		self.alpha = param_00;
		self.glowalpha = param_00;
	}

	self.color = (1,1,0.5);
	self.glowcolor = (0.7,0.7,0.2);
}

//Function Number: 77
set_hud_red(param_00)
{
	if(isdefined(param_00))
	{
		self.alpha = param_00;
		self.glowalpha = param_00;
	}

	self.color = (1,0.4,0.4);
	self.glowcolor = (0.7,0.2,0.2);
}

//Function Number: 78
set_hud_grey(param_00)
{
	if(isdefined(param_00))
	{
		self.alpha = param_00;
		self.glowalpha = param_00;
	}

	self.color = (0.4,0.4,0.4);
	self.glowcolor = (0.2,0.2,0.2);
}

//Function Number: 79
info_hud_wait_for_player(param_00)
{
	if(isdefined(self.so_infohud_toggle_state))
	{
		return;
	}

	level endon("challenge_timer_expired");
	level endon("challenge_timer_passed");
	level endon("special_op_terminated");
	self endon("death");
	if(isdefined(param_00))
	{
		level endon(param_00);
	}

	self setweaponhudiconoverride("actionslot1","hud_show_timer");
	notifyoncommand("toggle_challenge_timer","+actionslot 1");
	self.so_infohud_toggle_state = info_hud_start_state();
	if(!maps\_specialops_code::so_hud_can_show())
	{
		thread info_hud_wait_force_on();
		maps\_utility::func_121C("so_hud_can_toggle");
	}

	self notify("so_hud_toggle_available");
	for(;;)
	{
		self waittill("toggle_challenge_timer");
		switch(self.so_infohud_toggle_state)
		{
			case "on":
				self.so_infohud_toggle_state = "off";
				setdvar("so_ophud_" + self.unique_id,"0");
				break;
	
			case "off":
				self.so_infohud_toggle_state = "on";
				setdvar("so_ophud_" + self.unique_id,"1");
				break;
		}

		self notify("update_challenge_timer");
	}
}

//Function Number: 80
info_hud_wait_force_on()
{
	self endon("so_hud_toggle_available");
	notifyoncommand("force_challenge_timer","+actionslot 1");
	self waittill("force_challenge_timer");
	self.so_hud_show_time = gettime();
	self.so_infohud_toggle_state = "on";
	setdvar("so_ophud_" + self.unique_id,"1");
}

//Function Number: 81
info_hud_start_state()
{
	if(getdvarint("so_ophud_" + self.unique_id) == 1)
	{
		self.so_hud_show_time = gettime() + 1000;
		return "on";
	}

	if(isdefined(level.challenge_time_limit))
	{
		return "on";
	}

	if(isdefined(level.var_142D) && level.var_142D)
	{
		return "on";
	}

	return "off";
}

//Function Number: 82
info_hud_handle_fade(param_00,param_01)
{
	level endon("new_challenge_timer");
	level endon("challenge_timer_expired");
	level endon("challenge_timer_passed");
	level endon("special_op_terminated");
	self endon("death");
	if(isdefined(param_01))
	{
		level endon(param_01);
	}

	param_00.var_142F = 1;
	maps\_utility::func_121C("so_hud_can_toggle");
	func_1430(param_00);
	for(;;)
	{
		self waittill("update_challenge_timer");
		param_00 fadeovertime(0.25);
		func_1430(param_00);
	}
}

//Function Number: 83
func_1430(param_00)
{
	switch(self.so_infohud_toggle_state)
	{
		case "on":
			param_00.alpha = 1;
			break;

		case "off":
			param_00.alpha = 0;
			break;
	}
}

//Function Number: 84
func_1431(param_00)
{
	if(!isdefined(level.challenge_time_limit))
	{
		return;
	}

	if(common_scripts\utility::flag("challenge_timer_expired") || common_scripts\utility::flag("challenge_timer_passed"))
	{
		return;
	}

	level.so_challenge_time_left = level.so_challenge_time_left - param_00;
	if(level.so_challenge_time_left < 0)
	{
		level.so_challenge_time_left = 0.01;
	}

	var_01 = (0.6,0.2,0.2);
	var_02 = (0.4,0.1,0.1);
	foreach(var_04 in level.players)
	{
		var_04.hud_so_timer_time settenthstimer(level.so_challenge_time_left);
	}

	thread maps\_specialops_code::challenge_timer_thread();
}

//Function Number: 85
is_dvar_character_switcher(param_00)
{
	var_01 = getdvar(param_00);
	return var_01 == "so_char_client" || var_01 == "so_char_host";
}

//Function Number: 86
func_1436()
{
	var_00 = tablelookup("sp/specOpsTable.csv",1,level.script,9);
	if(var_00 == "")
	{
		return 0;
	}

	foreach(var_02 in level.players)
	{
		var_03 = var_02 getlocalplayerprofiledata(var_00);
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 != 0)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 87
is_best_wave(param_00)
{
	return 0;
}

//Function Number: 88
is_best_time(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		if(isdefined(level.challenge_start_time))
		{
			param_00 = level.challenge_start_time;
		}
		else
		{
			param_00 = 300;
		}
	}

	if(!isdefined(param_01))
	{
		param_01 = gettime();
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = param_01 - param_00;
	var_03 = int(min(var_03,86400000));
	var_04 = tablelookup("sp/specOpsTable.csv",1,level.script,9);
	if(var_04 == "")
	{
		return 0;
	}

	foreach(var_06 in level.players)
	{
		var_07 = var_06 getlocalplayerprofiledata(var_04);
		if(!isdefined(var_07))
		{
			continue;
		}

		var_08 = var_07 == 0;
		if(var_08)
		{
			continue;
		}

		var_07 = var_07 - var_07 * param_02;
		if(var_03 < var_07)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 89
is_poor_time(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		if(isdefined(level.challenge_start_time))
		{
			param_00 = level.challenge_start_time;
		}
		else
		{
			param_00 = 300;
		}
	}

	if(!isdefined(param_01))
	{
		param_01 = gettime();
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = param_01 - param_00;
	var_04 = level.challenge_time_limit * 1000;
	var_04 = var_04 - var_04 * param_02;
	return var_03 > var_04;
}

//Function Number: 90
func_143A()
{
	if(isdefined(level.var_80E5["ready_up"]))
	{
		[[ level.var_80E5["ready_up"] ]]();
		return;
	}

	maps\_specialops_code::func_143B("so_tf_1_plyr_prep",0,1);
}

//Function Number: 91
so_dialog_mission_success(param_00)
{
	if(!maps\_utility::is_survival() && is_best_time(level.challenge_start_time,level.challenge_end_time))
	{
		if(isdefined(level.var_80E5["success_best"]))
		{
			thread [[ level.var_80E5["success_best"] ]]();
			return;
		}

		thread maps\_specialops_code::func_143B("so_tf_1_success_best",0.5,1);
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
		if(level.gameskill >= 3)
		{
			if(func_1436())
			{
				param_00 = common_scripts\utility::cointoss();
			}
		}
	}

	if(isdefined(level.var_80E5["success_generic"]))
	{
		[[ level.var_80E5["success_generic"] ]](param_00);
		return;
	}

	if(param_00)
	{
		maps\_specialops_code::func_143B("so_tf_1_success_jerk",0.5,1);
		return;
	}

	maps\_specialops_code::func_143B("so_tf_1_success_generic",0.5,1);
}

//Function Number: 92
func_143D(param_00)
{
	if(isdefined(level.failed_dialog_played) && level.failed_dialog_played)
	{
		return;
	}

	level.failed_dialog_played = 1;
	maps\_specialops_code::func_143B(param_00,0.5,1);
}

//Function Number: 93
so_dialog_mission_failed_generic()
{
	if(isdefined(level.var_80E5["failed_generic"]))
	{
		[[ level.var_80E5["failed_generic"] ]]();
		return;
	}

	if(level.gameskill <= 2 || common_scripts\utility::cointoss())
	{
		func_143D("so_tf_1_fail_generic");
		return;
	}

	func_143D("so_tf_1_fail_generic_jerk");
}

//Function Number: 94
so_dialog_mission_failed_time()
{
	if(isdefined(level.var_80E5["failed_time"]))
	{
		[[ level.var_80E5["failed_time"] ]]();
		return;
	}

	func_143D("so_tf_1_fail_time");
}

//Function Number: 95
so_dialog_mission_failed_bleedout()
{
	if(isdefined(level.var_80E5["failed_bleedout"]))
	{
		[[ level.var_80E5["failed_bleedout"] ]]();
		return;
	}

	func_143D("so_tf_1_fail_bleedout");
}

//Function Number: 96
func_1442()
{
	if(isdefined(level.var_80E5["time_low_normal"]))
	{
		[[ level.var_80E5["time_low_normal"] ]]();
		return;
	}

	maps\_specialops_code::func_143B("so_tf_1_time_generic");
}

//Function Number: 97
so_dialog_time_low_hurry()
{
	if(isdefined(level.var_80E5["time_low_hurry"]))
	{
		[[ level.var_80E5["time_low_hurry"] ]]();
		return;
	}

	maps\_specialops_code::func_143B("so_tf_1_time_hurry");
}

//Function Number: 98
so_dialog_killing_civilians()
{
	if(!isdefined(level.civilian_warning_time))
	{
		level.civilian_warning_time = gettime();
		if(!isdefined(level.civilian_warning_throttle))
		{
			level.civilian_warning_throttle = 5000;
		}
	}
	else if(gettime() - level.civilian_warning_time < level.civilian_warning_throttle)
	{
		return;
	}

	var_00 = 0.5;
	level.civilian_warning_time = gettime() + var_00 * 1000;
	if(isdefined(level.var_80E5["killing_civilians"]))
	{
		[[ level.var_80E5["killing_civilians"] ]]();
		return;
	}

	maps\_specialops_code::func_143B("so_tf_1_civ_kill_warning",0.5);
}

//Function Number: 99
so_dialog_progress_update(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		return;
	}

	if(!isdefined(level.so_progress_goal_status))
	{
		level.so_progress_goal_status = "none";
	}

	var_02 = undefined;
	switch(level.so_progress_goal_status)
	{
		case "none":
			var_02 = 0.75;
			break;

		case "3quarter":
			var_02 = 0.5;
			break;

		case "half":
			var_02 = 0.25;
			break;

		default:
			break;
	}

	var_03 = param_01 * var_02;
	if(param_00 > var_03)
	{
		return;
	}

	var_04 = undefined;
	switch(level.so_progress_goal_status)
	{
		case "none":
			level.so_progress_goal_status = "3quarter";
			var_04 = "so_tf_1_progress_3quarter";
			break;

		case "3quarter":
			level.so_progress_goal_status = "half";
			var_04 = "so_tf_1_progress_half";
			break;

		case "half":
			level.so_progress_goal_status = "quarter";
			var_04 = "so_tf_1_progress_quarter";
			break;
	}

	if(isdefined(level.var_80E5["progress_goal_status"]))
	{
		[[ level.var_80E5["progress_goal_status"] ]]();
		return;
	}

	maps\_specialops_code::func_143B(var_04,0.5);
}

//Function Number: 100
so_dialog_progress_update_time_quality(param_00)
{
	if(isdefined(level.challenge_time_limit))
	{
		if(is_poor_time(level.challenge_start_time,gettime(),param_00))
		{
			if(isdefined(level.var_80E5["time_status_late"]))
			{
				[[ level.var_80E5["time_status_late"] ]]();
				return;
			}

			maps\_specialops_code::func_143B("so_tf_1_time_status_late",0.2);
			return;
		}
	}

	if(is_best_time(level.challenge_start_time,gettime(),param_00))
	{
		if(isdefined(level.var_80E5["time_status_good"]))
		{
			[[ level.var_80E5["time_status_good"] ]]();
			return;
		}

		maps\_specialops_code::func_143B("so_tf_1_time_status_good",0.2);
	}
}

//Function Number: 101
so_dialog_counter_update(param_00,param_01,param_02)
{
	if(!isdefined(level.so_counter_dialog_time))
	{
		level.so_counter_dialog_time = 0;
	}

	if(gettime() < level.so_counter_dialog_time)
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = int(param_00 / param_02);
	if(var_03 > 5)
	{
		if(!isdefined(level.challenge_progress_manual_update) || !level.challenge_progress_manual_update)
		{
			thread so_dialog_progress_update(param_00,param_01);
			level.so_counter_dialog_time = gettime() + 800;
		}

		return;
	}

	if(isdefined(level.var_80E5["progress"]))
	{
		thread [[ level.var_80E5["progress"] ]](var_03);
	}
	else
	{
		switch(var_03)
		{
			case 5:
				thread maps\_specialops_code::func_143B("so_tf_1_progress_5more",0.5);
				break;

			case 4:
				thread maps\_specialops_code::func_143B("so_tf_1_progress_4more",0.5);
				break;

			case 3:
				thread maps\_specialops_code::func_143B("so_tf_1_progress_3more",0.5);
				break;

			case 2:
				thread maps\_specialops_code::func_143B("so_tf_1_progress_2more",0.5);
				break;

			case 1:
				thread maps\_specialops_code::func_143B("so_tf_1_progress_1more",0.5);
				break;
		}
	}

	level.so_counter_dialog_time = gettime() + 800;
}

//Function Number: 102
func_144D(param_00,param_01)
{
	if(!isdefined(param_00.coop_death_reason))
	{
		param_00.coop_death_reason = [];
	}

	if(!isdefined(param_01))
	{
		param_01 = "MOD_EXPLOSIVE";
	}

	param_00.coop_death_reason["attacker"] = self;
	param_00.coop_death_reason["cause"] = param_01;
	param_00.coop_death_reason["weapon_name"] = "none";
	param_00 maps\_utility::kill_wrapper();
}

//Function Number: 103
get_previously_completed_difficulty()
{
	var_00 = level.specopssettings maps\_endmission::func_1452(level.script);
	var_01 = int(self getlocalplayerprofiledata("missionSOHighestDifficulty")[var_00]);
	var_01 = int(max(0,var_01));
	return var_01;
}

//Function Number: 104
func_1453()
{
	precacheshader("difficulty_star");
}

//Function Number: 105
so_hud_stars_init(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level.race_times = [];
	level.race_times["regular"] = param_02;
	level.race_times["hardened"] = param_03;
	level.race_times["veteran"] = param_04;
	param_05 = common_scripts\utility::ter_op(isdefined(param_05),param_05,4);
	self.stars_removed = [];
	thread so_hud_stars_single_think(param_00,param_01,0,level.race_times["regular"],"regular",param_05);
	thread so_hud_stars_single_think(param_00,param_01,1,level.race_times["hardened"],"hardened",param_05);
	thread so_hud_stars_single_think(param_00,param_01,2,level.race_times["veteran"],"veteran",param_05);
}

//Function Number: 106
so_hud_stars_single_think(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("special_op_terminated");
	level endon(param_01);
	if(!isdefined(self.so_hud_star_count))
	{
		self.so_hud_star_count = 0;
	}

	self.so_hud_star_count++;
	var_06 = 25;
	var_07 = func_1423();
	var_08 = func_127E(param_05,var_07,undefined,self);
	var_08.x = var_08.x - param_02 * var_06 - 30;
	var_08.y = var_08.y + 5;
	var_08 setshader("difficulty_star",25,25);
	common_scripts\utility::flag_wait(param_00);
	thread so_hud_stars_single_force_alpha_end(var_08,param_01);
	if(param_03 < 0)
	{
		return;
	}

	thread so_hud_stars_sound_and_flash(var_08,param_03,param_01);
	level common_scripts\utility::waittill_any_timeout(param_03,"star_hud_remove_" + param_04);
	waittillframeend;
	if(common_scripts\utility::flag(param_01))
	{
		return;
	}

	self.so_hud_star_count--;
	var_08 destroy();
}

//Function Number: 107
so_hud_stars_remove(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!isdefined(param_00))
		{
			if(!isdefined(var_02.stars_removed["veteran"]))
			{
				param_00 = "veteran";
			}
			else if(!isdefined(var_02.stars_removed["hardened"]))
			{
				param_00 = "hardened";
			}
			else if(!isdefined(var_02.stars_removed["regular"]))
			{
				param_00 = "regular";
			}
		}

		if(isdefined(var_02.stars_removed[param_00]))
		{
			return;
		}

		if(param_00 == "hardened" && !isdefined(var_02.stars_removed["veteran"]))
		{
			return;
		}
		else if(param_00 == "regular" && !isdefined(var_02.stars_removed["veteran"]) || !isdefined(var_02.stars_removed["hardened"]))
		{
			return;
		}

		var_02.stars_removed[param_00] = 1;
		level notify("star_hud_remove_" + param_00);
	}
}

//Function Number: 108
so_hud_stars_validate_difficulty(param_00)
{
	switch(param_00)
	{
		case "regular":
		case "veteran":
		case "hardened":
			break;

		default:
			break;
	}
}

//Function Number: 109
so_hud_stars_sound_and_flash(param_00,param_01,param_02)
{
	param_00 endon("death");
	level endon(param_02);
	level endon("special_op_terminated");
	var_03 = 5;
	var_04 = param_01 - var_03;
	wait var_04;
	for(var_05 = 0;var_05 < var_03;var_05++)
	{
		self playlocalsound("star_tick");
		param_00.alpha = 1;
		wait 0.5;
		param_00.alpha = 0.3;
		wait 0.5;
	}

	self playlocalsound("star_lost");
}

//Function Number: 110
so_hud_stars_single_force_alpha_end(param_00,param_01)
{
	param_00 endon("death");
	common_scripts\utility::flag_wait(param_01);
	waittillframeend;
	param_00.alpha = 1;
}

//Function Number: 111
unlock_hint()
{
	wait 0.05;
	foreach(var_01 in level.players)
	{
		var_01 thread unlock_hint_think();
	}
}

//Function Number: 112
unlock_hint_think()
{
	surhud_disable("unlock");
	for(var_00 = 0;var_00 < 3;var_00++)
	{
		unlock_hint_reset(var_00);
	}

	for(;;)
	{
		self waittill("update_rank");
		waittillframeend;
		if(!isdefined(self))
		{
			return;
		}

		var_01 = maps\_rank::getrank();
		var_02 = level.unlock_array[var_01];
		if(isdefined(var_02))
		{
			for(var_00 = 0;var_00 < 3;var_00++)
			{
				var_03 = var_02[var_00];
				if(isdefined(var_03))
				{
					register_recent_unlock(var_03);
					func_146F("surHUD_unlock_hint_" + var_00,"name",var_03.name);
					func_146F("surHUD_unlock_hint_" + var_00,"icon",var_03.icon);
					func_146F("surHUD_unlock_hint_" + var_00,"mode",var_03.mode);
					continue;
				}

				unlock_hint_reset(var_00);
			}

			func_1466("unlock");
		}
	}
}

//Function Number: 113
register_recent_unlock(param_00)
{
	if(!param_00.var_80E2)
	{
		var_01 = tablelookup("sp/survival_armories.csv",1,param_00.ref,2);
		var_02 = int(1 + var_01 == "weapon");
		var_03 = tablelookup("sp/survival_armories.csv",1,param_00.ref,6);
		var_04 = param_00.desc;
		pass_recent_item_unlock("recent_item_2","recent_item_3");
		pass_recent_item_unlock("recent_item_1","recent_item_2");
		func_146F("recent_item_1","name",param_00.name);
		func_146F("recent_item_1","icon",var_03);
		func_146F("recent_item_1","desc",var_04);
		func_146F("recent_item_1","icon_width_ratio",var_02);
		return;
	}

	var_05 = self getplayerdata("recent_feature_1","name");
	func_146F("recent_feature_2","name",var_05);
	func_146F("recent_feature_1","name",param_00.name);
}

//Function Number: 114
pass_recent_item_unlock(param_00,param_01)
{
	var_02 = self getplayerdata(param_00,"name");
	var_03 = self getplayerdata(param_00,"desc");
	var_04 = self getplayerdata(param_00,"icon");
	var_05 = self getplayerdata(param_00,"icon_width_ratio");
	func_146F(param_01,"name",var_02);
	func_146F(param_01,"desc",var_03);
	func_146F(param_01,"icon",var_04);
	func_146F(param_01,"icon_width_ratio",var_05);
}

//Function Number: 115
unlock_hint_reset(param_00)
{
	func_146F("surHUD_unlock_hint_" + param_00,"name","");
	func_146F("surHUD_unlock_hint_" + param_00,"icon","");
	func_146F("surHUD_unlock_hint_" + param_00,"mode","");
}

//Function Number: 116
func_1466(param_00)
{
	level endon("special_op_terminated");
	self endon("stop_animate_" + param_00);
	thread func_80E6("stop_animate_" + param_00);
	if(!isdefined(self.var_1467))
	{
		self.var_1467 = 0;
	}

	while(self.var_1467)
	{
		wait 0.05;
	}

	self.var_1467 = 1;
	if(!func_146B(param_00))
	{
		surhud_enable(param_00);
	}

	_setplayerdata_single("surHUD_set_animate",param_00);
	wait 0.05;
	self openmenu("surHUD_display");
	wait 0.05;
	self.var_1467 = 0;
	self notify("surHUD_free");
}

//Function Number: 117
func_80E6(param_00)
{
	self endon("surHUD_free");
	self waittill(param_00);
	self.var_1467 = 0;
}

//Function Number: 118
surhud_challenge_label(param_00,param_01)
{
	if(isdefined(self))
	{
		func_146F("surHUD_challenge_label","slot_" + param_00,param_01);
	}
}

//Function Number: 119
surhud_challenge_progress(param_00,param_01)
{
	if(isdefined(self))
	{
		func_146F("surHUD_challenge_progress","slot_" + param_00,param_01);
	}
}

//Function Number: 120
surhud_challenge_reward(param_00,param_01)
{
	if(isdefined(self))
	{
		func_146F("surHUD_challenge_reward","slot_" + param_00,param_01);
	}
}

//Function Number: 121
func_146B(param_00)
{
	if(isdefined(self) && self getplayerdata("surHUD",param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 122
surhud_enable(param_00)
{
	if(isdefined(self))
	{
		func_146F("surHUD",param_00,1);
	}
}

//Function Number: 123
surhud_disable(param_00)
{
	if(isdefined(self))
	{
		func_146F("surHUD",param_00,0);
	}
}

//Function Number: 124
_setplayerdata_single(param_00,param_01)
{
	self setplayerdata(param_00,param_01);
}

//Function Number: 125
func_146F(param_00,param_01,param_02)
{
	self setplayerdata(param_00,param_01,param_02);
}

//Function Number: 126
func_80E7()
{
	wait 0.05;
	foreach(var_01 in level.players)
	{
		var_01 thread func_80E8();
	}
}

//Function Number: 127
func_80E8()
{
	if(!isdefined(self.achievement_completed))
	{
		self.achievement_completed = [];
	}

	self.achievement_completed["ARMS_DEALER"] = 0;
	self.achievement_completed["DANGER_ZONE"] = 0;
	self.achievement_completed["DEFENSE_SPENDING"] = 0;
	self.achievement_completed["SURVIVOR"] = 0;
	self.achievement_completed["UNSTOPPABLE"] = 0;
}

//Function Number: 128
func_80E4(param_00,param_01)
{
	if(maps\_utility::is_survival())
	{
		switch(param_00)
		{
			case "DEFENSE_SPENDING":
			case "DANGER_ZONE":
			case "ARMS_DEALER":
				thread func_80EA(param_00,param_01);
				break;

			case "SURVIVOR":
				thread func_80EC(param_00,9);
				break;

			case "UNSTOPPABLE":
				thread func_80EC(param_00,14);
				break;

			case "GET_RICH_OR_DIE_TRYING":
			case "I_LIVE":
				thread maps\_utility::player_giveachievement_wrapper(param_00);
				break;
		}

		return;
	}

	switch(param_00)
	{
		case "BRAG_RAGS":
			thread maps\_utility::player_giveachievement_wrapper(param_00);
			break;

		case "TACTICIAN":
			thread func_80ED(param_00,1);
			break;

		case "OVERACHIEVER":
			thread func_80ED(param_00,3);
			break;
	}
}

//Function Number: 129
func_80EA(param_00,param_01)
{
	if(self.achievement_completed[param_00])
	{
		return;
	}

	var_02 = level.armory_all_items[param_01].type;
	if(self getplayerdata(var_02 + "_purchased",param_01) == 0)
	{
		self setplayerdata(var_02 + "_purchased",param_01,1);
	}
	else
	{
		return;
	}

	var_03 = 0;
	if(var_02 == "weapon" || var_02 == "weaponupgrade")
	{
		var_03 = func_80EB("weapon","weapon_purchased") && func_80EB("weaponupgrade","weaponupgrade_purchased");
	}
	else
	{
		var_03 = func_80EB(var_02,var_02 + "_purchased");
	}

	if(var_03)
	{
		maps\_utility::player_giveachievement_wrapper(param_00);
		self.achievement_completed[param_00] = 1;
	}
}

//Function Number: 130
func_80EB(param_00,param_01)
{
	foreach(var_03 in level.var_3892[param_00])
	{
		if(self getplayerdata(param_01,var_03.ref) == 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 131
func_80EC(param_00,param_01)
{
	if(self.achievement_completed[param_00])
	{
		return;
	}

	for(var_02 = 0;var_02 < 16;var_02++)
	{
		var_03 = level.specopssettings.var_14AA[var_02].name;
		var_04 = tablelookup("sp/specOpsTable.csv",1,var_03,9);
		var_05 = int(self getlocalplayerprofiledata(var_04) / 1000);
		if(var_03 == level.script)
		{
			var_05 = level.var_13BE;
		}

		if(var_05 < param_01)
		{
			return;
		}
	}

	maps\_utility::player_giveachievement_wrapper(param_00);
	self.achievement_completed[param_00] = 1;
	if(param_00 == "UNSTOPPABLE")
	{
		self setplayerdata("challengeState","ch_unstoppable",2);
	}
}

//Function Number: 132
func_80ED(param_00,param_01)
{
	for(var_02 = 16;var_02 < 32;var_02++)
	{
		var_03 = level.specopssettings.var_14AA[var_02].name;
		var_04 = int(self getlocalplayerprofiledata("missionSOHighestDifficulty")[var_02]);
		var_04 = int(max(0,var_04)) - 1;
		if(var_04 < param_01)
		{
			return;
		}
	}

	maps\_utility::player_giveachievement_wrapper(param_00);
	if(param_00 == "OVERACHIEVER")
	{
		self setplayerdata("challengeState","ch_overachiever",2);
	}
}