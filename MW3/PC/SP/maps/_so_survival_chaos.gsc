/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_so_survival_chaos.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 203
 * Decompile Time: 3468 ms
 * Timestamp: 10/27/2023 2:19:10 AM
*******************************************************************/

//Function Number: 1
chaos_pre_preload()
{
	var_00 = getdvar("mapname");
	if(issplitscreen() || getdvar("coop") == "1")
	{
		level.var_3F63 = "sp/coop_" + var_00 + "_chaos_waves.csv";
		return;
	}

	level.var_3F63 = "sp/" + var_00 + "_chaos_waves.csv";
}

//Function Number: 2
chaos_preload()
{
	precachemodel("prop_dogtags_foe");
	precachemodel("prop_dogtags_friend");
	precacheshader("chaos_specialty_juiced");
	precacheshader("chaos_specialty_armorvest");
	precacheshader("chaos_bonus_points");
	precacheshader("chaos_bonus_combo");
	precacheshader("chaos_bonus_time");
	precacheshader("chaos_meter_1");
	precacheshader("chaos_meter_2");
	precacheshader("chaos_meter_3");
	precacheshader("chaos_meter_4");
	precacheshader("chaos_meter_5");
	precacheshader("chaos_meter_6");
	precacheshader("chaos_meter_7");
	precacheshader("chaos_meter_8");
	precacheshader("chaos_meter_9");
	precacheshader("chaos_meter_10");
	precacheshader("chaos_meter_11");
	precacheshader("chaos_meter_12");
	precacheshader("chaos_meter_13");
	precacheshader("chaos_meter_14");
	precacheshader("chaos_meter_15");
	precacheshader("chaos_meter_16");
	precacheshader("chaos_frozen_meter");
	precacheitem("chaos_freeze_meter");
	precacheshader("chaos_bonus_freeze_meter");
	precacheshader("chaos_bonus_sentry_gun");
	precacheshader("chaos_bonus_laststand");
	precacheshader("combathigh_overlay");
	precachestring(&"SO_SURVIVAL_CHAOS_EASY_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_PLUS_SIGN");
	precachestring(&"SO_SURVIVAL_CHAOS_EMPTY");
	precachestring(&"SO_SURVIVAL_CHAOS_DOG_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_EXP_DOG");
	precachestring(&"SO_SURVIVAL_CHAOS_SUICIDE_BOMBER");
	precachestring(&"SO_SURVIVAL_CHAOS_CHEMICAL_CORPS");
	precachestring(&"SO_SURVIVAL_CHAOS_CLAYMORE_CORPS");
	precachestring(&"SO_SURVIVAL_CHAOS_REG_JUG");
	precachestring(&"SO_SURVIVAL_CHAOS_EXP_JUG");
	precachestring(&"SO_SURVIVAL_CHAOS_SHIELD_JUG");
	precachestring(&"SO_SURVIVAL_CHAOS_MINIGUN_JUG");
	precachestring(&"SO_SURVIVAL_CHAOS_DES_CHOPPER");
	precachestring(&"SO_SURVIVAL_CHAOS_REGULAR_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_HARDENED_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_VETERAN_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_ELITE_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_STAB");
	precachestring(&"SO_SURVIVAL_CHAOS_HEAD_SHOT");
	precachestring(&"SO_SURVIVAL_CHAOS_EXPLOSION");
	precachestring(&"SO_SURVIVAL_CHAOS_GRENADE");
	precachestring(&"SO_SURVIVAL_CHAOS_EXECUTION");
	precachestring(&"SO_SURVIVAL_CHAOS_TRIPLE_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_QUAD_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_MULTI_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_LONG_SHOT");
	precachestring(&"SO_SURVIVAL_CHAOS_TRIPLE_HEADSHOT");
	precachestring(&"SO_SURVIVAL_CHAOS_TRIPLE_KNIFE_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_TRIPLE_LONGSHOT");
	precachestring(&"SO_SURVIVAL_CHAOS_MASSIVE_EXPLOSION");
	precachestring(&"SO_SURVIVAL_CHAOS_DOG_TAGS");
	precachestring(&"SO_SURVIVAL_CHAOS_NEW_WEAPON");
	precachestring(&"SO_SURVIVAL_CHAOS_BONUS_SCORE");
	precachestring(&"SO_SURVIVAL_CHAOS_CARE_PACKAGE");
	precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_FINAL_STAND");
	precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_DEMO_MAN");
	precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_LONG_SHOOTER");
	precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_HEAD_HUNTER");
	precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_SLASHER");
	precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_TRIPLE_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_QUAD_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_SPLASH_MULTI_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_ACR");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_CLAYMORE");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_C4");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_FLASH");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_1887");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_AA12");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_AK47");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_AS50");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_CM901");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_FAD");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_FMG9");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_G18");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MG36");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_G36");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_M16");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_M4");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_M60");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_M9");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MK14");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MK46");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MP5");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MP7");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_MP9");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_PP90");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_P90");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_PECHENEG");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_RSASS");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_SA80");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_SCAR");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_SKORPION");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_STRIKER");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_TYPE95");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_USP45");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_UMP45");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_USAS12");
	precachestring(&"SO_SURVIVAL_CHAOS_PICKUP_RPG");
	precachestring(&"SO_SURVIVAL_CHAOS_HIGHEST_COMBO");
	precachestring(&"SO_SURVIVAL_CHAOS_BONUS_POINT");
	precachestring(&"SO_SURVIVAL_CHAOS_BONUS_MULTIPLIER");
	precachestring(&"SO_SURVIVAL_CHAOS_BONUS_TIME");
	precachestring(&"SO_SURVIVAL_CHAOS_BONUS_LASTSTAND");
	precachestring(&"SO_SURVIVAL_CHAOS_BONUS_FREEZE_METER");
	precachestring(&"SO_SURVIVAL_CHAOS_BONUS_SENTRY");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_CHOPPER");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_EXP_JUG");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_MUL_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_TRI_LONGSHOT");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_TRI_KNIFE");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_TRI_HEADSHOT");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_MASSIVE_EXP");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_QUAD_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_SHIELD_JUG");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_TRI_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_REG_JUG");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_NEW_WEAPON");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_GRENADE");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_CHEMICAL");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_ELITE");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_VETERAN");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_EXECUTION");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_HARDENED");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_EXP_DOG");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_MARTYRDOM");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_LONG_SHOT");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_KNIFE");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_EXP_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_REG_KILL");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_REG_DOG");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_EASY");
	precachestring(&"SO_SURVIVAL_CHAOS_EOG_HEADSHOT");
	maps/_so_survival_chaos_entities::chaos_entities_precache();
	maps/_so_survival_chaos_entities::chaos_load_drop_location();
	maps/_so_survival_chaos_entities::chaos_load_drop_item();
	maps/_so_survival_chaos_entities::chaos_load_desired_drop_distance();
	maps/_so_survival_chaos_entities::chaos_load_ai_size();
}

//Function Number: 3
chaos_postload()
{
	var_00 = getdvar("mapname");
	if(issplitscreen() || getdvar("coop") == "1")
	{
		level.wave_table = "sp/coop_" + var_00 + "_chaos_waves.csv";
	}
	else
	{
		level.wave_table = "sp/" + var_00 + "_chaos_waves.csv";
	}

	add_chaos_killstreak("bonus_score");
	add_chaos_killstreak("bonus_multiplier");
	add_chaos_killstreak("bonus_time");
	add_chaos_killstreak("bonus_laststand");
	add_chaos_killstreak("bonus_freezemeter");
}

//Function Number: 4
add_chaos_killstreak(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	var_0A = undefined;
	var_0B = undefined;
	if(issubstr(param_00,"bonus_"))
	{
		var_01 = "airdrop_marker_mp";
		var_02 = ::maps\_sp_killstreaks::sp_killstreak_carepackage_main;
		var_0A = "SP_KILLSTREAKS_REWARDNAME_AIRDROP";
		var_03 = "UK_1mc_achieve_carepackage";
		var_04 = "UK_1mc_use_carepackage";
		var_05 = "specialty_carepackage";
		var_06 = &"SP_KILLSTREAKS_EARNED_AIRDROP";
		switch(param_00)
		{
			case "bonus_score":
				var_09 = ::sp_killstreak_bonus_score_crateopen;
				var_07 = "chaos_bonus_points";
				var_0B = &"SO_SURVIVAL_CHAOS_BONUS_POINT";
				break;

			case "bonus_multiplier":
				var_09 = ::sp_killstreak_bonus_multiplier_crateopen;
				var_07 = "chaos_bonus_combo";
				var_0B = &"SO_SURVIVAL_CHAOS_BONUS_MULTIPLIER";
				break;

			case "bonus_time":
				var_09 = ::sp_killstreak_bonus_time_crateopen;
				var_07 = "chaos_bonus_time";
				var_0B = &"SO_SURVIVAL_CHAOS_BONUS_TIME";
				break;

			case "bonus_laststand":
				var_09 = ::sp_killstreak_bonus_laststand_crateopen;
				var_07 = "chaos_bonus_laststand";
				var_0B = &"SO_SURVIVAL_CHAOS_BONUS_LASTSTAND";
				break;

			case "bonus_freezemeter":
				var_09 = ::sp_killstreak_bonus_freezemeter_crateopen;
				var_07 = "chaos_bonus_freeze_meter";
				var_0B = &"SO_SURVIVAL_CHAOS_BONUS_FREEZE_METER";
				break;

			default:
				break;
		}
	}
	else
	{
	}

	var_0C = spawnstruct();
	var_0C.streaktype = param_00;
	var_0C.weaponname = var_01;
	var_0C.streakfunc = var_02;
	var_0C.menurewarddesc = var_0A;
	var_0C.achievevo = var_03;
	var_0C.usevo = var_04;
	var_0C.splashicon = var_05;
	var_0C.splashhint = var_06;
	var_0C.crateicon = var_07;
	var_0C.cratehint = var_08;
	var_0C.crateopenfunc = var_09;
	var_0C.cratehudstring = var_0B;
	level.ks.killstreaktypes[param_00] = var_0C;
	maps\_sp_killstreaks::add_killstreak_radio_dialogue(var_03,var_04);
}

//Function Number: 5
chaos_init()
{
	level.perk_offset = 60;
	thread chaos_hud_survival_remove();
	thread chaos_ai_setup();
	thread chaos_armories_disable();
	thread chaos_score_init();
	thread chaos_players_setup();
	level.chaos_time_remaining = 120;
	thread chaos_timer_create(120,"start_survival","win_survival");
	thread chaos_music_intro();
	thread maps/_so_survival_chaos_entities::chaos_entities_place();
	level.var_16BD = ::chaos_eog_summary;
	level.start_combo_decay = 0;
	level.timer_started = 0;
	level.player_currently_getting_perk = 0;
	level.airdropcratetimeout = 0;
	level.freeze_combo_meter = 0;
	level.so_player_chatter_enabled = 0;
	var_00 = maps\_sp_killstreaks::get_sp_killstreak_info("sentry");
	var_00.cratehudstring = &"SO_SURVIVAL_CHAOS_BONUS_SENTRY";
	var_00.crateicon = "chaos_bonus_sentry_gun";
	var_00.streakfunc = ::chaos_killstreak_autosentry_main;
	level.ks.killstreaktypes["sentry"] = var_00;
	level.grnd_fx["smoke"] = loadfx("smoke/airdrop_flare_mp_effect_now");
	level.survival_wave = [];
	level.survival_wave = chaos_wave_populate();
	level.focus_on_player = 0;
}

//Function Number: 6
chaos_wave_populate()
{
	var_00 = 0;
	var_01 = 1000;
	var_02 = [];
	for(var_03 = var_00;var_03 <= var_01;var_03++)
	{
		var_04 = maps\_so_survival_ai::get_wave_number_by_index(var_03);
		if(!isdefined(var_04) || var_04 == 0)
		{
			continue;
		}

		var_05 = spawnstruct();
		var_05.idx = var_03;
		var_05.num = var_04;
		var_05.survival_ai_class_overrides = maps\_so_survival_ai::get_squad_type(var_04);
		var_05.var_3D4C = maps\_so_survival_ai::get_squad_array(var_04);
		var_05.var_3D4D = maps\_so_survival_ai::get_special_ai(var_04);
		var_05.var_3D4E = maps\_so_survival_ai::get_special_ai_quantity(var_04);
		var_05.var_3D4F = maps\_so_survival_ai::get_wave_boss_delay(var_04);
		var_05.bossai = maps\_so_survival_ai::get_bosses_ai(var_04);
		var_05.bossnonai = maps\_so_survival_ai::get_bosses_nonai(var_04);
		var_05.dogtype = maps\_so_survival_ai::get_dog_type(var_04);
		var_05.dogquantity = maps\_so_survival_ai::get_dog_quantity(var_04);
		var_05.repeating = maps\_so_survival_ai::is_repeating(var_04);
		var_06 = maps\_so_survival_ai::get_armory_unlocked(var_04);
		if(isdefined(var_06) && var_06.size)
		{
			if(!isdefined(level.armory_unlock))
			{
				level.armory_unlock = [];
			}

			foreach(var_08 in var_06)
			{
				level.armory_unlock[var_08] = var_04;
			}
		}

		var_02[var_04] = var_05;
		if(var_05.repeating)
		{
			level.survival_repeat_wave[level.survival_repeat_wave.size] = var_05;
		}
	}

	return var_02;
}

//Function Number: 7
chaos_players_setup()
{
	common_scripts\utility::array_thread(level.players,::chaos_player_infinite_ammo_pistol);
	foreach(var_01 in level.players)
	{
		var_01 thread hud_weapon_icon();
		var_01 thread live_1_hud_icon();
		var_01 thread live_2_hud_icon();
		var_01 thread live_3_hud_icon();
		var_01 thread live_4_hud_icon();
		var_01 thread live_5_hud_icon();
		var_01 thread manage_lives_left_hud();
		var_01 thread perk_hud_2();
		var_01 thread perk_hud_3();
		var_01 thread perk_hud_4();
		var_01 thread perk_hud_5();
		var_01 thread perk_hud_6();
		var_01 thread perk_hud_7();
		var_01 thread perk_hud_popup_icon();
		var_01 thread wait_for_death();
		var_01 thread listen_for_sentry_notification();
		var_01 thread listen_for_laststand_notification();
		if(maps\_utility::is_coop())
		{
			var_01 thread wait_for_revive_teammate();
		}

		var_01.num_perk_obtained = 0;
		var_01.recentkillcount = 0;
		var_01.recentheadshotcount = 0;
		var_01.recentknifekillcount = 0;
		var_01.recentlongshotcount = 0;
		var_01.recentrocketkillcount = 0;
		var_01.justopencrate = 0;
		var_01.dogs_dont_instant_kill = 1;
		var_01.laststand_info.type_getup_lives = level.map_specific_starting_lives_remaining - 1;
		var_01.action_streak = [];
		var_01.hud_chaoseventpopup = var_01 createchaoseventpopup();
		var_01.hud_chaosscorepopup = var_01 createchaosscorepopup();
	}

	thread chaos_players_performance();
}

//Function Number: 8
listen_for_sentry_notification()
{
	level endon("special_op_terminated");
	for(;;)
	{
		self waittill("sentry_notification",var_00);
		if(!isdefined(var_00))
		{
			self.hud_chaoseventpopup settext("");
			self.hud_chaoseventpopup.alpha = 0;
			continue;
		}

		self.hud_chaoseventpopup settext(var_00);
		self.hud_chaoseventpopup.color = (1,1,1);
		self.hud_chaoseventpopup.alpha = 0.85;
	}
}

//Function Number: 9
listen_for_laststand_notification()
{
	level endon("special_op_terminated");
	for(;;)
	{
		self waittill("laststand_notification",var_00);
		if(var_00 == &"SCRIPT_COOP_BLEEDING_OUT_PARTNER")
		{
			chaoseventpopup(var_00,(1,0.4,0.4),0,3);
			continue;
		}

		chaoseventpopup(var_00,(1,1,1));
	}
}

//Function Number: 10
chaos_players_performance()
{
	while(!isdefined(level.player.game_performance))
	{
		wait 0.05;
	}

	foreach(var_01 in level.players)
	{
		var_01.game_performance["headshot"] = 0;
		var_01.game_performance["knife_kill"] = 0;
		var_01.game_performance["long_shot"] = 0;
		var_01.game_performance["triple_kill"] = 0;
		var_01.game_performance["quad_kill"] = 0;
		var_01.game_performance["multi_kill"] = 0;
		var_01.game_performance["new_weapon_collected"] = 0;
		var_01.game_performance["comboscoremax"] = 0;
		var_01.game_performance["combomultmax"] = 0;
		var_01.game_performance["explosive_jug"] = 0;
		var_01.game_performance["triple_headshot"] = 0;
		var_01.game_performance["triple_knife_kill"] = 0;
		var_01.game_performance["triple_long_shot"] = 0;
		var_01.game_performance["massive_explosion"] = 0;
		var_01.game_performance["riot_shield_jug"] = 0;
		var_01.game_performance["regular_jug"] = 0;
		var_01.game_performance["grenade_kill"] = 0;
		var_01.game_performance["chemical_kill"] = 0;
		var_01.game_performance["elite_kill"] = 0;
		var_01.game_performance["veteran_kill"] = 0;
		var_01.game_performance["execution"] = 0;
		var_01.game_performance["hardened_kill"] = 0;
		var_01.game_performance["explosive_dog"] = 0;
		var_01.game_performance["martyrdom_kill"] = 0;
		var_01.game_performance["explosive_kill"] = 0;
		var_01.game_performance["regular_kill"] = 0;
		var_01.game_performance["regular_dog"] = 0;
		var_01.game_performance["easy_kill"] = 0;
		var_01.game_performance["chopper_kill"] = 0;
	}
}

//Function Number: 11
chaos_score_init()
{
	chaos_combo_system_setup();
	chaos_score_event_populate();
	chaos_register_perk_progression();
	thread chaos_score_event_creators();
}

//Function Number: 12
chaos_register_perk_progression()
{
	level.chaos_perk_progression = [];
	level.perk_progression_gap = 10;
	add_perk_progression(10,"specialty_fastreload");
	add_perk_progression(20,"specialty_quickdraw");
	add_perk_progression(30,"specialty_longersprint");
	add_perk_progression(40,"specialty_stalker");
	add_perk_progression(50,"specialty_bulletaccuracy");
	add_perk_progression(60,"specialty_armorvest");
	add_perk_progression(70,"specialty_juiced");
}

//Function Number: 13
add_perk_progression(param_00,param_01)
{
	var_02 = "combo_" + param_00;
	level.chaos_perk_progression[var_02] = param_01;
}

//Function Number: 14
chaos_score_event_populate()
{
	if(!isdefined(level.chaos_score_events))
	{
		level.chaos_score_events = [];
	}

	chaos_score_event_add("damage",0,0);
	chaos_score_event_add("damage_flash",0,0);
	chaos_score_event_add("damage_grenade",0,50);
	chaos_score_event_add("damage_explosive",0,250);
	chaos_score_event_add("damage_hipfire",0,0);
	chaos_score_event_add("dog_reg_kill",1,100,&"SO_SURVIVAL_CHAOS_DOG_KILL");
	chaos_score_event_add("dog_splode_kill",1,150,&"SO_SURVIVAL_CHAOS_EXP_DOG");
	chaos_score_event_add("martyrdom_kill",1,150,&"SO_SURVIVAL_CHAOS_SUICIDE_BOMBER");
	chaos_score_event_add("chemical_kill",1,300,&"SO_SURVIVAL_CHAOS_CHEMICAL_CORPS");
	chaos_score_event_add("claymore_kill",1,200,&"SO_SURVIVAL_CHAOS_CLAYMORE_CORPS");
	chaos_score_event_add("jug_regular_kill",1,500,&"SO_SURVIVAL_CHAOS_REG_JUG");
	chaos_score_event_add("jug_explosive_kill",1,1000,&"SO_SURVIVAL_CHAOS_EXP_JUG");
	chaos_score_event_add("jug_riotshield_kill",1,750,&"SO_SURVIVAL_CHAOS_SHIELD_JUG");
	chaos_score_event_add("jug_minigun_kill",1,1250,&"SO_SURVIVAL_CHAOS_MINIGUN_JUG");
	chaos_score_event_add("chopper_kill",1,2000,&"SO_SURVIVAL_CHAOS_DES_CHOPPER");
	chaos_score_event_add("easy_kill",1,50,&"SO_SURVIVAL_CHAOS_EASY_KILL");
	chaos_score_event_add("regular_kill",1,100,&"SO_SURVIVAL_CHAOS_REGULAR_KILL");
	chaos_score_event_add("hardened_kill",1,150,&"SO_SURVIVAL_CHAOS_HARDENED_KILL");
	chaos_score_event_add("veteran_kill",1,200,&"SO_SURVIVAL_CHAOS_VETERAN_KILL");
	chaos_score_event_add("elite_kill",1,250,&"SO_SURVIVAL_CHAOS_ELITE_KILL");
	chaos_score_event_add("kill_knife",1,150,&"SO_SURVIVAL_CHAOS_STAB");
	chaos_score_event_add("kill_headshot",1,300,&"SO_SURVIVAL_CHAOS_HEAD_SHOT");
	chaos_score_event_add("kill_explosive",1,150,&"SO_SURVIVAL_CHAOS_EXPLOSION");
	chaos_score_event_add("kill_grenade",1,400,&"SO_SURVIVAL_CHAOS_GRENADE");
	chaos_score_event_add("kill_execution",1,200,&"SO_SURVIVAL_CHAOS_EXECUTION");
	chaos_score_event_add("kill_triple",1,600,&"SO_SURVIVAL_CHAOS_TRIPLE_KILL");
	chaos_score_event_add("kill_quad",1,800,&"SO_SURVIVAL_CHAOS_QUAD_KILL");
	chaos_score_event_add("kill_multi",1,1000,&"SO_SURVIVAL_CHAOS_MULTI_KILL");
	chaos_score_event_add("kill_longshot",1,150,&"SO_SURVIVAL_CHAOS_LONG_SHOT");
	chaos_score_event_add("headshot_triple",1,1000,&"SO_SURVIVAL_CHAOS_TRIPLE_HEADSHOT");
	chaos_score_event_add("knife_triple",1,1000,&"SO_SURVIVAL_CHAOS_TRIPLE_KNIFE_KILL");
	chaos_score_event_add("longshot_triple",1,1000,&"SO_SURVIVAL_CHAOS_TRIPLE_LONGSHOT");
	chaos_score_event_add("massive_explosion",1,2000,&"SO_SURVIVAL_CHAOS_MASSIVE_EXPLOSION");
	chaos_score_event_add("dogtag",1,0,&"SO_SURVIVAL_CHAOS_DOG_TAGS");
	chaos_score_event_add("new_weapon_collect",1,500,&"SO_SURVIVAL_CHAOS_NEW_WEAPON");
	chaos_score_event_add("old_weapon_collect",1,0,"Old Weapon");
	chaos_score_event_add("placed_sentry",1,0,"Placed Sentry");
	chaos_score_event_add("revive_teammate",1,0,"Revived Teammate");
	chaos_score_event_add("weapon_ammo",0,0);
	chaos_score_event_add("bonus_score",1,5000,&"SO_SURVIVAL_CHAOS_BONUS_SCORE");
	chaos_score_event_add("bonus_multiplier",0,0,"Bonus Combo");
	chaos_score_event_add("care_package",1,500,&"SO_SURVIVAL_CHAOS_CARE_PACKAGE");
}

//Function Number: 15
chaos_score_event_add(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01 && !isdefined(param_03))
	{
	}

	if(!isdefined(param_03))
	{
		param_03 = "";
	}

	if(!isdefined(param_02))
	{
		param_02 = 100;
	}

	level.chaos_score_events[param_00] = [];
	level.chaos_score_events[param_00]["combo"] = param_01;
	level.chaos_score_events[param_00]["points"] = param_02;
	level.chaos_score_events[param_00]["name"] = param_03;
}

//Function Number: 16
chaos_combo_system_setup()
{
	common_scripts\utility::flag_init("chaos_players_in_combo");
	chaos_score_globals_init();
	chaos_combo_globals_init();
	common_scripts\utility::array_thread(level.players,::chaos_combo_player_create_hud);
	level thread chaos_combo_all_hud_destroy();
	chaos_combo_bar_set_fill(0);
	chaos_combo_bar_hide(1);
}

//Function Number: 17
chaos_combo_globals_init()
{
	level.chaos_combo_running = 0;
	level.chaos_combo_points = 0;
	level.chaos_combo_count = 0;
	level.chaos_combo_actions = [];
	level.chaos_combo_actions_max = 5;
}

//Function Number: 18
chaos_combo_globals_reset()
{
	chaos_combo_globals_init();
}

//Function Number: 19
chaos_wave()
{
	level endon("special_op_terminated");
	foreach(var_01 in level.chaos_entities)
	{
		foreach(var_03 in level.players)
		{
			var_01.headiconforplayer[var_03.unique_id] = undefined;
		}
	}

	level thread updateweaponheadiconforplayer();
	level.var_3C68["sentry_minigun"].health = 4000;
	if(issplitscreen())
	{
		level.revive_bar_offset = -60;
	}
	else
	{
		level.revive_bar_offset = 10;
	}

	lib_0623::func_3F80();
	thread lib_0623::func_3FB6();
	lib_0623::func_3F70();
	if(!common_scripts\utility::flag("start_survival"))
	{
		common_scripts\utility::flag_set("start_survival");
	}

	level notify("wave_started",level.current_wave);
	level.before_first_wave = 0;
	setsaveddvar("bg_viewKickScale","0.2");
	level thread lib_0623::func_3F82();
	foreach(var_03 in level.players)
	{
		var_03.var_3FC9.icon thread chaos_perk_icon_destroy_on_mode_end();
		var_03 thread wait_and_display_lives_left_hud();
	}

	var_08 = 0;
	if(!isdefined(level.crates_on_ground))
	{
		level.crates_on_ground = [];
	}

	for(;;)
	{
		var_09 = "wave_" + level.current_wave;
		if(isdefined(level.chaos_drop_items[var_09]) && level.crates_on_ground.size < 4)
		{
			if(maps\_utility::is_coop())
			{
				var_0A = 4 - level.crates_on_ground.size;
				if(var_0A > 1)
				{
					thread chaos_package_drop(2,level.player.origin);
				}
				else
				{
					thread chaos_package_drop(1,level.player.origin);
				}
			}
			else
			{
				thread chaos_package_drop(1,level.player.origin);
			}
		}

		if(isdefined(level.leaders.size) && level.leaders.size >= 3)
		{
		}

		var_0B = maps\_so_survival_ai::get_squad_array(level.current_wave);
		if(var_0B[0] == 0)
		{
			level.current_wave--;
			var_0B = maps\_so_survival_ai::get_squad_array(level.current_wave);
		}

		var_0C = 0;
		var_0D = maps\_so_survival_ai::get_squad_type(level.current_wave);
		level.regular_ai_spawned_in = 0;
		foreach(var_0F in var_0B)
		{
			if(var_0F > 0)
			{
				var_0C = var_0C + chaos_spawn_wave(1,var_0F,var_0D);
			}
		}

		level.special_ai = [];
		var_11 = maps\_so_survival_ai::get_special_ai(level.current_wave);
		if(isdefined(var_11))
		{
			foreach(var_13 in var_11)
			{
				if(issubstr(var_13,"dog"))
				{
					thread chaos_spawn_dogs(var_13,maps\_so_survival_ai::get_dog_quantity(level.current_wave),level.current_wave);
					var_14 = undefined;
					if(maps\_so_survival_ai::get_dog_quantity(level.current_wave) > 1)
					{
						var_14 = "so_hq_enemy_intel_dogs";
					}
					else
					{
						var_14 = "so_hq_enemy_intel_dog";
					}

					maps\_utility::radio_dialogue(var_14);
					continue;
				}

				var_15 = maps\_so_survival_ai::get_special_ai_type_quantity(level.current_wave,var_13);
				if(isdefined(var_15) && var_15 > 0)
				{
					var_16 = lib_0623::func_3F8C(var_13,var_15);
				}
			}
		}

		if(isdefined(level.special_ai))
		{
		}

		if(lib_0623::func_3F8F(level.current_wave))
		{
			thread lib_0623::func_3F90();
		}

		wait 3;
		common_scripts\utility::flag_set("aggressive_mode");
		maps\_squad_enemies::squad_disband(0,::maps\_so_survival_ai::default_squad_leader);
		var_18 = getaiarray("axis").size + maps\_so_survival_ai::dog_get_count();
		if(isdefined(level.map_specific_ai_size[var_09]))
		{
			var_08 = level.map_specific_ai_size[var_09];
		}

		while(var_18 > var_08)
		{
			level common_scripts\utility::waittill_any_timeout(1,"axis_died");
			var_18 = getaiarray("axis").size + maps\_so_survival_ai::dog_get_count();
		}

		var_19 = level.current_wave + 1;
		var_1A = 0;
		var_1B = [];
		var_1B = maps\_so_survival_ai::get_squad_array(var_19);
		foreach(var_1D in var_1B)
		{
			var_1A = var_1A + var_1D;
		}

		var_1F = maps\_so_survival_ai::get_special_ai(var_19);
		if(isdefined(var_1F))
		{
			foreach(var_21 in var_1F)
			{
				if(issubstr(var_21,"dog"))
				{
					var_1A = var_1A + maps\_so_survival_ai::get_dog_quantity(var_19);
					continue;
				}

				var_1A = var_1A + maps\_so_survival_ai::get_special_ai_type_quantity(var_19,var_21);
			}
		}

		if(lib_0623::func_3F8F(var_19))
		{
			if(isdefined(maps\_so_survival_ai::get_bosses_ai(var_19)))
			{
				var_1A = var_1A + maps\_so_survival_ai::get_bosses_ai(var_19).size;
			}

			if(isdefined(maps\_so_survival_ai::get_bosses_nonai(var_19)))
			{
				var_1A = var_1A + maps\_so_survival_ai::get_bosses_nonai(var_19).size;
			}
		}

		var_18 = getaiarray("axis").size + maps\_so_survival_ai::dog_get_count();
		if(var_18 + var_1A > 25)
		{
			while(var_18 + var_1A > 25)
			{
				level common_scripts\utility::waittill_any_timeout(1,"axis_died");
				var_18 = getaiarray("axis").size + maps\_so_survival_ai::dog_get_count();
			}
		}

		var_23 = getfreeaicount();
		if(var_1A > var_23)
		{
			while(var_1A > var_23)
			{
				level common_scripts\utility::waittill_any_timeout(1,"axis_died");
				var_23 = getfreeaicount();
			}
		}

		level.squad_leader_behavior_func = ::maps\_so_survival_ai::default_ai;
		level.special_ai_behavior_func = ::maps\_so_survival_ai::default_ai;
		if(lib_0623::func_3F8F(level.current_wave))
		{
			common_scripts\utility::flag_wait("bosses_spawned");
		}

		if(common_scripts\utility::flag("boss_music"))
		{
			level notify("end_boss_music");
			common_scripts\utility::flag_clear("boss_music");
			maps\_utility::music_stop(3);
		}

		level.current_wave++;
	}
}

//Function Number: 20
chaos_spawn_dogs(param_00,param_01,param_02)
{
	level endon("special_op_terminated");
	level endon("wave_ended");
	if(!isdefined(param_00) || param_00 == "" || !isdefined(param_01) || !param_01)
	{
		return;
	}

	level.dogs = [];
	var_03 = [];
	foreach(var_05 in level.players)
	{
		var_03[var_03.size] = var_05;
	}

	var_07 = getentarray("dog_spawner","targetname")[0];
	level.dogs_attach_c4 = isdefined(param_00) && param_00 == "dog_splode";
	var_07 maps\_utility::add_spawn_function(::maps\_so_survival_ai::dog_setup);
	var_07 maps\_utility::add_spawn_function(::maps\_so_survival_ai::dog_seek_player);
	var_07 maps\_utility::add_spawn_function(::maps\_so_survival_ai::dog_register_death);
	for(var_08 = 0;var_08 < param_01;var_08++)
	{
		var_09 = maps\_so_survival_code::get_furthest_from_these(level.wave_spawn_locs,var_03,4);
		var_07.count = 1;
		var_07.origin = var_09.origin;
		var_07.angles = var_09.angles;
		var_0A = int(40 + randomint(10) / param_01);
		level.survival_dog_spawning = 1;
		var_0B = var_07 maps\_utility::spawn_ai();
		if(isdefined(var_0B))
		{
			var_0B.ally_ref = maps\_so_survival_ai::get_ai_struct(param_00);
			var_0B setthreatbiasgroup("dogs");
			var_0B [[ level.var_3B89 ]]();
			var_0B.canclimbladders = 0;
			level.dogs[level.dogs.size] = var_0B;
		}

		level.survival_dog_spawning = undefined;
		if(!common_scripts\utility::flag("aggressive_mode"))
		{
			common_scripts\utility::waittill_any_timeout(var_0A,"aggressive_mode");
		}

		wait 0.05;
	}
}

//Function Number: 21
chaos_spawn_wave(param_00,param_01,param_02)
{
	level endon("special_op_terminated");
	for(param_00 = int(param_00);param_00;param_00--)
	{
		var_03 = spawn_chaos_squad(level.wave_spawn_locs,lib_0623::func_3F8B("leader"),lib_0623::func_3F8B("follower"),param_01 - 1);
		foreach(var_05 in var_03)
		{
			var_05.chaos_squad_type = param_02;
			var_05 setthreatbiasgroup("axis");
			var_05 thread maps\_so_survival_ai::setup_ai_weapon();
		}
	}

	return level.leaders.size;
}

//Function Number: 22
spawn_chaos_squad(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(maps\_utility::is_coop())
	{
		if(level.focus_on_player == 0)
		{
			var_04 = level.players[0];
			level.focus_on_player = 1;
		}
		else
		{
			var_04 = level.players[1];
			level.focus_on_player = 0;
		}
	}
	else
	{
		var_04 = level.player;
	}

	var_05 = param_00.size;
	for(;;)
	{
		var_06 = 0;
		for(var_07 = 1;var_07 < var_05;var_07++)
		{
			var_08 = vectornormalize(anglestoforward(var_04 getplayerangles()));
			var_09 = vectornormalize(param_00[var_07 - 1].origin - var_04 geteye());
			var_0A = vectordot(var_08,var_09);
			var_0B = vectornormalize(param_00[var_07].origin - var_04 geteye());
			var_0C = vectordot(var_08,var_0B);
			if(var_0A < var_0C)
			{
				var_0D = param_00[var_07 - 1];
				param_00[var_07 - 1] = param_00[var_07];
				param_00[var_07] = var_0D;
				var_06 = 1;
			}
		}

		if(var_06 == 0)
		{
			break;
		}

		var_05 = var_05 - 1;
	}

	var_0E = int(param_00.size / 3);
	var_0F = [];
	var_07 = 0;
	while(var_07 < var_0E)
	{
		var_08++ = var_7B[var_07];
	}

	var_10 = [];
	if(maps\_utility::is_coop())
	{
	}

	foreach(var_12 in level.leaders)
	{
		var_10[var_10.size] = var_12;
	}

	var_14 = undefined;
	while(var_7B.size > 1)
	{
		foreach(var_16 in var_10)
		{
			var_14 = maps\_utility::getclosest(var_16.origin,var_7B);
			var_7B = common_scripts\utility::array_remove(var_7B,var_14);
			if(var_7B.size == 1)
			{
				break;
			}
		}
	}

	var_14 = var_7B[0];
	if(isspawner(param_01[0]))
	{
		var_18 = getentarray(var_14.target,"targetname");
	}
	else
	{
		var_18 = common_scripts\utility::getstructarray(var_15.target,"targetname");
	}

	foreach(var_1A in var_18)
	{
		if(!isdefined(var_1A.script_noteworthy))
		{
			var_1A.script_noteworthy = "follower";
		}
	}

	common_scripts\utility::flag_set("squad_spawning");
	var_1C = [];
	var_1C = maps\_squad_enemies::spawn_enemy_group(var_18,param_02,param_03,var_04);
	level.regular_ai_spawned_in = level.regular_ai_spawned_in + var_04 + 1;
	common_scripts\utility::flag_clear("squad_spawning");
	wait 0.05;
	return var_1C;
}

//Function Number: 23
chaos_package_drop(param_00,param_01)
{
	level endon("special_op_terminated");
	level.drop_location_sorted = [];
	level.drop_location_sorted = level.chaos_drop_locations;
	var_02 = level.drop_location_sorted.size;
	var_03 = level.map_specific_desired_drop_distance;
	for(;;)
	{
		var_04 = 0;
		for(var_05 = 1;var_05 < var_02;var_05++)
		{
			var_06 = distance(level.drop_location_sorted[var_05 - 1],param_01);
			var_07 = distance(level.drop_location_sorted[var_05],param_01);
			if(abs(var_06 - var_03) > abs(var_07 - var_03))
			{
				var_08 = level.drop_location_sorted[var_05 - 1];
				level.drop_location_sorted[var_05 - 1] = level.drop_location_sorted[var_05];
				level.drop_location_sorted[var_05] = var_08;
				var_04 = 1;
			}
		}

		if(var_04 == 0)
		{
			break;
		}

		var_02 = var_02 - 1;
	}

	var_09 = "wave_" + level.current_wave;
	for(var_05 = 0;var_05 < param_00;var_05++)
	{
		level thread generatesmokefx(level.drop_location_sorted[var_05]);
	}

	level sp_airdrop_do_flyby(param_00,level.player,level.drop_location_sorted[0],randomfloat(360),undefined,var_09);
}

//Function Number: 24
sp_airdrop_do_flyby(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("special_op_terminated");
	var_06 = maps\_sp_airdrop::getflyheightoffset(param_02);
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_06 = var_06 + param_04;
	if(!isdefined(param_01))
	{
		return;
	}

	var_07 = param_02 * (1,1,0) + (0,0,var_06);
	var_08 = chaos_getpathstart(var_07,param_03);
	var_09 = chaos_getpathend(var_07,param_03);
	var_0A = maps\_sp_airdrop::sp_airdrop_heli_setup(param_01,var_08,var_07);
	var_0A endon("death");
	if(maps\_utility::is_coop())
	{
		maps\_utility::radio_dialogue("chaos_cps_inbound");
	}
	else
	{
		maps\_utility::radio_dialogue("chaos_cp_inbound");
	}

	level.drop_item_used = [];
	for(var_0B = 0;var_0B < param_00;var_0B++)
	{
		if(var_0B > 0)
		{
			param_03 = randomfloat(360);
			var_06 = maps\_sp_airdrop::getflyheightoffset(level.drop_location_sorted[var_0B]);
			if(!isdefined(param_04))
			{
				param_04 = 0;
			}

			var_06 = var_06 + param_04;
			var_07 = level.drop_location_sorted[var_0B] * (1,1,0) + (0,0,var_06);
			var_07 = var_07 + anglestoforward((0,param_03,0)) * -50;
		}

		var_0A setvehgoalpos(var_07,1);
		var_0A vehicle_setspeed(150,80);
		var_0A setyawspeed(180,180,180,0.3);
		var_0C = get_random_drop_item(param_05,param_00);
		if(var_0C == "bonus_laststand")
		{
			if(player_have_max_lives())
			{
				var_0C = "bonus_score";
			}
		}

		var_0A thread sp_airdrop_drop_the_crate(var_0C,level.drop_location_sorted[var_0B],var_06,0,undefined,var_08);
		wait 1;
		while(var_0A vehicle_getspeed() > 5)
		{
			wait 0.1;
		}

		var_0A notify("drop_crate");
		var_0D = undefined;
		switch(var_0C)
		{
			case "bonus_score":
				var_0D = "chaos_deliverd_socre";
				break;

			case "sentry":
				var_0D = "chaos_deliverd_sentry";
				break;

			case "bonus_laststand":
				var_0D = "chaos_deliverd_laststand";
				break;

			case "bonus_multiplier":
				var_0D = "chaos_deliverd_combomult";
				break;

			case "bonus_time":
				var_0D = "chaos_deliverd_extratime";
				break;

			case "bonus_freezemeter":
				var_0D = "chaos_deliverd_freeze";
				break;
		}

		if(isdefined(var_0D))
		{
			maps\_utility::radio_dialogue(var_0D);
		}
	}

	var_0A setvehgoalpos(var_09,1);
	var_0A vehicle_setspeed(300,75);
	var_0A.leaving = 1;
	var_0A waittill("goal");
	var_0A notify("leaving");
	var_0A notify("delete");
	var_0A delete();
}

//Function Number: 25
chaos_score_event_raise(param_00,param_01)
{
	if(level.timer_started == 0)
	{
		level notify("Start timer");
		level.challenge_start_time = gettime();
		level.timer_started = 1;
	}

	if(common_scripts\utility::flag("special_op_terminated"))
	{
		return;
	}

	if(!isdefined(level.chaos_score_events[param_00]))
	{
		return;
	}

	chaos_combo_update(level.chaos_score_events[param_00]["name"],level.chaos_score_events[param_00]["points"],level.chaos_score_events[param_00]["combo"],param_01);
	if(int(level.chaos_score_events[param_00]["points"]) > 0)
	{
		foreach(var_03 in level.players)
		{
			var_03 thread chaosscorepopup("+" + level.chaos_score_events[param_00]["points"]);
		}
	}
}

//Function Number: 26
chaos_combo_actions_update(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.action_string = param_00;
	var_02.point = param_01;
	if(level.chaos_combo_actions.size < level.chaos_combo_actions_max)
	{
		level.chaos_combo_actions[level.chaos_combo_actions.size] = var_02;
		return;
	}

	for(var_03 = 0;var_03 < level.chaos_combo_actions.size - 1;var_03++)
	{
		level.chaos_combo_actions[var_03] = level.chaos_combo_actions[var_03 + 1];
	}

	level.chaos_combo_actions[level.chaos_combo_actions.size - 1] = var_02;
}

//Function Number: 27
chaos_combo_update(param_00,param_01,param_02,param_03)
{
	if(!common_scripts\utility::flag("chaos_players_in_combo"))
	{
		common_scripts\utility::flag_set("chaos_players_in_combo");
	}

	level.chaos_combo_points = level.chaos_combo_points + param_01;
	if(level.chaos_combo_count == 0 || param_02)
	{
		level.chaos_combo_count++;
	}

	foreach(var_05 in level.players)
	{
		var_05 notify("combo_update");
	}

	if(param_02)
	{
		if(isdefined(param_03))
		{
			common_scripts\utility::array_call(level.players,::playlocalsound,param_03);
		}
		else
		{
			common_scripts\utility::array_call(level.players,::playlocalsound,"Chaos_combo");
		}

		var_07 = "combo_" + level.chaos_combo_count;
		if(isdefined(level.chaos_perk_progression[var_07]))
		{
			var_08 = level.chaos_perk_progression[var_07];
			thread chaos_give_perk_possible_wait(var_08);
		}
	}

	if(isstring(param_00))
	{
		var_09 = &"SO_SURVIVAL_CHAOS_PLUS_SIGN";
	}
	else
	{
		var_09 = param_01;
	}

	chaos_combo_display_update(var_09,param_01,level.chaos_combo_points,level.chaos_combo_count,param_02);
	if(level.start_combo_decay == 1)
	{
		thread chaos_combo_on_end(4,0.2);
	}
}

//Function Number: 28
chaos_give_perk_possible_wait(param_00)
{
	level endon("special_op_terminated");
	foreach(var_02 in level.players)
	{
		var_02 thread makecombomultiplyglowandpop();
	}

	if(level.player_currently_getting_perk == 1)
	{
		level waittill("proceed_with_next_perk");
	}

	foreach(var_02 in level.players)
	{
		var_02 chaos_give_perk(param_00);
	}

	level thread chaos_perk_radio(param_00);
}

//Function Number: 29
chaos_combo_on_end(param_00,param_01)
{
	level endon("special_op_terminated");
	level notify("combo_bumped");
	level endon("combo_bumped");
	level endon("stop_meter_decay");
	if(level.freeze_combo_meter == 1)
	{
		chaos_combo_bar_set_fill(1);
		chaos_combo_bar_hide(0);
		return;
	}

	var_02 = param_00 * 1000;
	var_03 = gettime();
	var_04 = var_03 + var_02;
	for(var_05 = var_03;var_05 < var_04;var_05 = gettime())
	{
		var_06 = 1 - var_05 - var_03 / var_02;
		chaos_combo_bar_set_fill(var_06);
		chaos_combo_bar_hide(0);
		wait 0.05;
	}

	if(isdefined(param_01) && param_01 > 0)
	{
		wait param_01;
	}

	chaos_running_score_update(level.chaos_combo_points,level.chaos_combo_count);
	common_scripts\utility::array_call(level.players,::playlocalsound,"Chaos_lose_combo");
	foreach(var_08 in level.players)
	{
		var_08 clearperks();
		var_08.var_3FC9.icon.alpha = 0;
		var_08.perk_icon_hud_2.icon.alpha = 0;
		var_08.perk_icon_hud_3.icon.alpha = 0;
		var_08.perk_icon_hud_4.icon.alpha = 0;
		var_08.perk_icon_hud_5.icon.alpha = 0;
		var_08.perk_icon_hud_6.icon.alpha = 0;
		var_08.perk_icon_hud_7.icon.alpha = 0;
		var_08 unsetjuiced();
		var_08 notify("chaos_stop_extra_health_regen");
		var_08.num_perk_obtained = 0;
	}

	chaos_combo_bar_set_fill(0);
	chaos_combo_bar_hide(1);
	chaos_combo_globals_reset();
	chaos_combo_display_clear();
	common_scripts\utility::flag_clear("chaos_players_in_combo");
	thread recreate_last_stand_hud();
}

//Function Number: 30
chaos_running_score_update(param_00,param_01)
{
	level notify("score_update_bump");
	level endon("score_update_bump");
	var_02 = param_00 * param_01;
	level.chaos_score = level.chaos_score + var_02;
	foreach(var_04 in level.players)
	{
		if(var_02 > var_04.game_performance["comboscoremax"])
		{
			var_04.game_performance["comboscoremax"] = var_02;
		}

		if(param_01 > var_04.game_performance["combomultmax"])
		{
			var_04.game_performance["combomultmax"] = param_01;
		}

		if(isdefined(var_04.chaos_score_hud))
		{
			var_04.chaos_score_hud settext(format_good_looking_score(level.chaos_score));
		}
	}
}

//Function Number: 31
chaos_score_event_creators()
{
	maps\_utility::add_global_spawn_function("axis",::chaos_score_on_ai_damage);
	maps\_utility::add_global_spawn_function("axis",::chaos_score_on_ai_flashed);
	maps\_utility::add_global_spawn_function("axis",::chaos_score_on_ai_death);
}

//Function Number: 32
chaos_score_on_ai_damage()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(var_01.owner) && isplayer(var_01.owner))
		{
			chaos_score_event_raise("damage");
			continue;
		}

		if(!isplayer(var_01))
		{
			continue;
		}

		var_0A = "damage";
		if(isdefined(var_04))
		{
			if((var_01 playerads() == 0 && var_04 == "MOD_PISTOL_BULLET") || var_04 == "MOD_RIFLE_BULLET")
			{
				var_0A = "damage_hipfire";
			}
			else
			{
				switch(var_04)
				{
					case "MOD_EXPLOSIVE":
						var_0A = "damage_explosive";
						break;
	
					case "MOD_GRENADE_SPLASH":
					case "MOD_GRENADE":
						var_0A = "damage_grenade";
						break;
	
					default:
						break;
				}
			}
		}

		chaos_score_event_raise(var_0A);
	}
}

//Function Number: 33
chaos_score_on_ai_flashed()
{
	self endon("death");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03);
		if(isplayer(var_03))
		{
			chaos_score_event_raise("damage_flash");
		}
	}
}

//Function Number: 34
chaos_score_on_ai_death()
{
	self waittill("death",var_00,var_01,var_02);
	if(isdefined(var_00) && isdefined(var_00.owner) && isplayer(var_00.owner))
	{
		var_03 = chaos_get_ai_type_ref() + "_kill";
		chaos_score_event_raise(var_03);
		return;
	}

	if(isdefined(var_02))
	{
		if(var_02 == "MOD_EXPLOSIVE" && !isdefined(var_03))
		{
			if(level.start_combo_decay == 0)
			{
				level.start_combo_decay = 1;
			}

			chaos_score_event_raise("kill_explosive");
			if(!maps\_utility::is_coop())
			{
				level.player.game_performance["explosive_kill"]++;
			}

			return;
		}
	}

	if(!isplayer(var_01))
	{
		return;
	}

	var_03 = chaos_get_ai_type_ref() + "_kill";
	if(isdefined(self.a) && isdefined(self.a.doinglongdeath))
	{
		var_03 = "kill_execution";
		var_00.game_performance["execution"]++;
	}
	else if(maps\_player_stats::was_headshot())
	{
		var_03 = "kill_headshot";
		var_00.game_performance["headshot"]++;
	}
	else if(isdefined(var_01))
	{
		if(var_01 == "MOD_MELEE")
		{
			var_03 = "kill_knife";
			var_00.game_performance["knife_kill"]++;
		}
		else if(var_01 == "MOD_EXPLOSIVE")
		{
			var_03 = "kill_explosive";
			var_00.game_performance["explosive_kill"]++;
		}
		else if(var_01 == "MOD_PROJECTILE_SPLASH")
		{
			var_03 = "kill_rocket";
		}
		else if(var_01 == "MOD_GRENADE_SPLASH" || var_01 == "MOD_GRENADE")
		{
			if(var_02 == "fraggrenade")
			{
				var_03 = "kill_grenade";
				var_00.game_performance["grenade_kill"]++;
			}
			else if(var_02 == "claymore")
			{
				var_03 = "kill_explosive";
				var_00.game_performance["explosive_kill"]++;
			}
		}
		else if(var_01 == "MOD_PISTOL_BULLET" || var_01 == "MOD_RIFLE_BULLET")
		{
			if(distancesquared(self.origin,var_00.origin) > 262144)
			{
				var_03 = "kill_longshot";
				var_00.game_performance["long_shot"]++;
			}
		}
	}

	if(level.start_combo_decay == 0)
	{
		level.start_combo_decay = 1;
	}

	if(var_03 == "kill_headshot")
	{
		var_00 thread updaterecentheadshots();
	}
	else if(var_03 == "kill_knife")
	{
		var_00 thread updaterecentknifekills();
	}
	else if(var_03 == "kill_longshot")
	{
		var_00 thread updaterecentlongshots();
	}
	else if(var_03 == "kill_rocket" || isdefined(var_02) && var_02 == "c4" || var_02 == "claymore")
	{
		var_00 thread updaterecentrocketkills();
	}

	var_00 thread updaterecentkills();
	if(var_03 == "kill_rocket")
	{
		var_03 = chaos_get_ai_type_ref() + "_kill";
	}

	var_04 = chaos_get_ai_type_ref();
	if(issubstr(var_04,"jug"))
	{
		var_03 = chaos_get_ai_type_ref() + "_kill";
		if(issubstr(var_03,"explosive"))
		{
			var_00.game_performance["explosive_jug"]++;
		}
		else if(issubstr(var_03,"riotshield"))
		{
			var_00.game_performance["riot_shield_jug"]++;
		}
		else if(issubstr(var_03,"regular"))
		{
			var_00.game_performance["regular_jug"]++;
		}
	}

	if(var_04 == "chopper")
	{
		var_03 = "chopper_kill";
		var_00.game_performance["chopper_kill"]++;
	}

	if(var_04 == "martyrdom" && var_03 != "kill_headshot")
	{
		var_03 = "martyrdom_kill";
		var_00.game_performance["martyrdom_kill"]++;
	}

	if(var_03 == "easy_kill")
	{
		var_00.game_performance["easy_kill"]++;
	}
	else if(var_03 == "regular_kill")
	{
		var_00.game_performance["regular_kill"]++;
	}
	else if(var_03 == "hardened_kill")
	{
		var_00.game_performance["hardened_kill"]++;
	}
	else if(var_03 == "veteran_kill")
	{
		var_00.game_performance["veteran_kill"]++;
	}
	else if(var_03 == "elite_kill")
	{
		var_00.game_performance["elite_kill"]++;
	}
	else if(var_03 == "elite_kill")
	{
		var_00.game_performance["elite_kill"]++;
	}
	else if(var_03 == "chemical_kill")
	{
		var_00.game_performance["chemical_kill"]++;
	}
	else if(var_03 == "martyrdom_kill")
	{
		var_00.game_performance["martyrdom_kill"]++;
	}
	else if(var_03 == "dog_reg_kill")
	{
		var_00.game_performance["regular_dog"]++;
	}
	else if(var_03 == "dog_splode_kill")
	{
		var_00.game_performance["explosive_dog"]++;
	}

	chaos_score_event_raise(var_03);
}

//Function Number: 35
updaterecentrocketkills()
{
	self endon("disconnect");
	level endon("special_op_terminated");
	self notify("updateRecentRocketKills");
	self endon("updateRecentRocketKills");
	self.recentrocketkillcount++;
	wait 1;
	if(self.recentrocketkillcount > 1)
	{
		multirocketkills(self.recentrocketkillcount);
	}

	self.recentrocketkillcount = 0;
}

//Function Number: 36
multirocketkills(param_00)
{
	if(param_00 > 10)
	{
		thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_DEMO_MAN","cm_bp_kills_explosion");
		chaos_score_event_raise("massive_explosion");
		self.game_performance["massive_explosion"]++;
	}
}

//Function Number: 37
updaterecentlongshots()
{
	self endon("disconnect");
	level endon("special_op_terminated");
	self notify("updateRecentLongshots");
	self endon("updateRecentLongshots");
	self.recentlongshotcount++;
	wait 1;
	if(self.recentlongshotcount > 1)
	{
		multilongshots(self.recentlongshotcount);
	}

	self.recentlongshotcount = 0;
}

//Function Number: 38
multilongshots(param_00)
{
	if(param_00 >= 3)
	{
		thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_LONG_SHOOTER","cm_bp_kills_3longshot");
		chaos_score_event_raise("longshot_triple");
		self.game_performance["triple_long_shot"]++;
	}
}

//Function Number: 39
updaterecentheadshots()
{
	self endon("disconnect");
	level endon("special_op_terminated");
	self notify("updateRecentHeadshots");
	self endon("updateRecentHeadshots");
	self.recentheadshotcount++;
	wait 1.5;
	if(self.recentheadshotcount > 1)
	{
		multiheadshots(self.recentheadshotcount);
	}

	self.recentheadshotcount = 0;
}

//Function Number: 40
multiheadshots(param_00)
{
	if(param_00 >= 3)
	{
		thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_HEAD_HUNTER","cm_bp_kills_3headshot");
		chaos_score_event_raise("headshot_triple");
		self.game_performance["triple_headshot"]++;
	}
}

//Function Number: 41
updaterecentknifekills()
{
	self endon("disconnect");
	level endon("special_op_terminated");
	self notify("updateRecentKnifekills");
	self endon("updateRecentKnifekills");
	self.recentknifekillcount++;
	wait 2;
	if(self.recentknifekillcount > 1)
	{
		multiknifekills(self.recentknifekillcount);
	}

	self.recentknifekillcount = 0;
}

//Function Number: 42
multiknifekills(param_00)
{
	if(param_00 >= 3)
	{
		thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_SLASHER","cm_bp_kills_3knife");
		chaos_score_event_raise("knife_triple");
		self.game_performance["triple_knife_kill"]++;
	}
}

//Function Number: 43
updaterecentkills()
{
	self endon("disconnect");
	level endon("special_op_terminated");
	self notify("updateRecentKills");
	self endon("updateRecentKills");
	self.recentkillcount++;
	wait 1;
	if(self.recentkillcount > 1)
	{
		multikill(self.recentkillcount);
	}

	self.recentkillcount = 0;
}

//Function Number: 44
multikill(param_00)
{
	if(param_00 == 3)
	{
		thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_TRIPLE_KILL","cm_bp_kills_triple");
		chaos_score_event_raise("kill_triple");
		self.game_performance["triple_kill"]++;
		return;
	}

	if(param_00 == 4)
	{
		thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_QUAD_KILL","cm_bp_kills_quad");
		chaos_score_event_raise("kill_quad");
		self.game_performance["quad_kill"]++;
		return;
	}

	if(param_00 > 4)
	{
		thread chaos_combo_splash(&"SO_SURVIVAL_CHAOS_SPLASH_MULTI_KILL","cm_bp_kills_multiple");
		chaos_score_event_raise("kill_multi");
		self.game_performance["multi_kill"]++;
		return;
	}
}

//Function Number: 45
chaos_timer_create(param_00,param_01,param_02)
{
	param_00 = common_scripts\utility::ter_op(isdefined(param_00) && param_00 > 0,param_00,1200);
	if(isdefined(param_01) && !common_scripts\utility::flag_exist(param_01))
	{
		common_scripts\utility::flag_init(param_01);
	}

	if(isdefined(param_02) && !common_scripts\utility::flag_exist(param_02))
	{
		common_scripts\utility::flag_init(param_02);
	}

	foreach(var_04 in level.players)
	{
		var_04 chaos_timer_player_setup(param_00,param_01,param_02);
	}

	level thread update_level_chaos_timer();
	level thread play_time_related_vo(param_00);
	level thread startcombodecayontimer();
}

//Function Number: 46
play_time_related_vo(param_00)
{
	level endon("special_op_terminated");
	level notify("stop_play_time_related_VO");
	level endon("stop_play_time_related_VO");
	level common_scripts\utility::waittill_notify_or_timeout("Start timer",10);
	var_01 = param_00 - 45;
	var_02 = 15;
	var_03 = 20;
	if(var_01 > 0)
	{
		wait var_01;
		level thread maps\_utility::radio_dialogue("chaos_time_almostup");
	}

	wait var_02;
	level thread maps\_utility::radio_dialogue("chaos_30sec_left",2);
	wait var_03;
	level thread maps\_utility::radio_dialogue("chaos_10sec_left",2);
	wait 10;
	level thread maps\_utility::radio_dialogue("chaos_keep_combo");
}

//Function Number: 47
chaos_timer_player_setup(param_00,param_01,param_02)
{
	var_03 = chaos_timer_create_hud_elem(self);
	thread chaos_timer_destroy(var_03);
	thread chaos_timer_update(var_03,param_00,param_01,param_02);
	self.chaos_timer = var_03;
}

//Function Number: 48
chaos_timer_update(param_00,param_01,param_02,param_03)
{
	level endon("special_op_terminated");
	level endon("chaos_timer_reached_zero");
	level endon("update_chaos_timer");
	if(param_01 <= 0)
	{
		param_01 = 60;
	}

	param_00 settenthstimerstatic(param_01);
	level common_scripts\utility::waittill_notify_or_timeout("Start timer",10);
	if(level.timer_started == 0)
	{
		level.challenge_start_time = gettime();
		level.timer_started = 1;
	}

	var_04 = param_01 * 1000;
	var_05 = param_01;
	var_06 = gettime();
	var_07 = gettime();
	thread chaos_timer_reached_zero(param_00,var_05,param_03);
	thread chaos_timer_update_color(param_00,var_05,60);
	thread chaos_timer_update_flash(param_00,var_05,30);
	thread chaos_timer_update_sound(var_05,5);
	thread chaos_timer_update_vo(var_05,10);
	for(;;)
	{
		param_00 settenthstimer(var_05);
		level waittill("wave_ended");
		var_07 = gettime();
		var_04 = var_04 - var_07 - var_06;
		var_05 = var_04 / 1000;
		level.chaos_time_remaining = var_05;
		param_00 settenthstimerstatic(var_05);
		level waittill("wave_started");
		var_06 = gettime();
	}
}

//Function Number: 49
chaos_timer_reached_zero(param_00,param_01,param_02)
{
	level endon("special_op_terminated");
	level endon("wave_ended");
	level endon("update_chaos_timer");
	param_00 endon("death");
	wait param_01;
	level notify("chaos_timer_reached_zero");
	for(;;)
	{
		if(common_scripts\utility::flag_exist("chaos_players_in_combo") && common_scripts\utility::flag("chaos_players_in_combo"))
		{
			common_scripts\utility::flag_waitopen("chaos_players_in_combo");
		}

		if(level.freeze_combo_meter != 1)
		{
			break;
		}

		wait 0.05;
	}

	common_scripts\utility::flag_set(param_02);
	thread chaos_timer_fade(param_00);
}

//Function Number: 50
sp_killstreak_bonus_freezemeter_crateopen()
{
	level endon("special_op_terminated");
	if(maps\_sp_killstreaks::has_killstreak("sentry"))
	{
		maps\_sp_killstreaks::take_sp_killstreak("sentry");
	}

	self giveweapon("chaos_freeze_meter");
	self setactionslot(4,"weapon","chaos_freeze_meter");
	thread radio_dialogue_to_player(self,"chaos_pickup_freeze");
	thread wait_for_meter_freeze_activiation();
}

//Function Number: 51
wait_for_meter_freeze_activiation()
{
	level endon("special_op_terminated");
	level endon("stop_wait_for_meter_freeze_activation");
	self notifyonplayercommand("freeze_combo_meter","+actionslot 4");
	for(;;)
	{
		self waittill("freeze_combo_meter");
		if(self.laststand_info.type_getup_lives == 0 && isdefined(self.laststand) && self.laststand == 1)
		{
			continue;
		}

		self takeweapon("chaos_freeze_meter");
		level thread execute_combo_freeze();
		break;
	}
}

//Function Number: 52
execute_combo_freeze()
{
	level endon("special_op_terminated");
	level notify("stop_freeze_meter_wait");
	level endon("stop_freeze_meter_wait");
	foreach(var_01 in level.players)
	{
		var_01 thread change_player_vision_set();
		var_01 playlocalsound("chaos_perk_activate");
	}

	level.freeze_combo_meter = 1;
	level notify("stop_meter_decay");
	chaos_combo_bar_set_fill(1);
	chaos_combo_bar_hide(0);
	wait 8;
	foreach(var_01 in level.players)
	{
		var_01 playlocalsound("chaos_perk_deactivate");
	}

	wait 2;
	level.freeze_combo_meter = 0;
	thread chaos_combo_on_end(4,0.2);
}

//Function Number: 53
sp_killstreak_bonus_multiplier_crateopen()
{
	level.chaos_combo_count = level.chaos_combo_count + 10;
	chaos_score_event_raise("bonus_multiplier");
	level thread maps\_utility::radio_dialogue("chaos_pickup_multiplier");
	if(level.player_currently_getting_perk == 1)
	{
		level waittill("proceed_with_next_perk");
	}

	if(level.player.num_perk_obtained < level.chaos_perk_progression.size)
	{
		var_00 = int(level.chaos_combo_count / level.perk_progression_gap);
		var_01 = level.player.num_perk_obtained;
		if(var_00 > var_01)
		{
			var_02 = var_00 * level.perk_progression_gap;
			var_03 = "combo_" + var_02;
			var_04 = level.chaos_perk_progression[var_03];
			foreach(var_06 in level.players)
			{
				var_06 chaos_give_perk(var_04);
			}

			level thread chaos_perk_radio(var_04);
		}
	}
}

//Function Number: 54
sp_killstreak_bonus_laststand_crateopen()
{
	var_00 = 0;
	self.laststand_info.type_getup_lives = self.laststand_info.type_getup_lives + 1;
	thread radio_dialogue_to_player(self,"chaos_pickup_laststand");
	if(isdefined(self.laststand) && self.laststand == 1)
	{
		return;
	}

	update_lives_left_hud(self.laststand_info.type_getup_lives);
}

//Function Number: 55
sp_killstreak_bonus_time_crateopen()
{
	level notify("update_chaos_timer");
	var_00 = level.chaos_time_remaining + 60;
	level.chaos_time_remaining = var_00;
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.chaos_timer))
		{
			var_02.chaos_timer.fontscale = 1;
			var_02.chaos_timer maps\_specialops::set_hud_white();
			thread chaos_timer_update(var_02.chaos_timer,var_00,undefined,"win_survival");
		}

		if(isdefined(var_02.combathighoverlay))
		{
			var_02.combathighoverlay destroy();
		}
	}

	level thread update_level_chaos_timer();
	level thread maps\_utility::radio_dialogue("chaos_pickup_time");
	level thread play_time_related_vo(var_00);
	level notify("Start timer");
}

//Function Number: 56
chaos_give_perk(param_00)
{
	if(param_00 != "specialty_juiced")
	{
		if(self hasperk(param_00,1))
		{
			return 1;
		}
	}

	level.player_currently_getting_perk = 1;
	var_01 = undefined;
	switch(param_00)
	{
		case "specialty_stalker":
			thread maps\_so_survival_perks::give_perk_stalker();
			break;

		case "specialty_longersprint":
			thread maps\_so_survival_perks::give_perk_longersprint();
			break;

		case "specialty_fastreload":
			thread maps\_so_survival_perks::give_perk_fastreload();
			break;

		case "specialty_quickdraw":
			thread maps\_so_survival_perks::give_perk_quickdraw();
			thread chaos_give_perk_fastoffhand();
			break;

		case "specialty_detectexplosive":
			thread maps\_so_survival_perks::give_perk_detectexplosive();
			break;

		case "specialty_bulletaccuracy":
			thread maps\_so_survival_perks::give_perk_bulletaccuracy();
			break;

		case "specialty_armorvest":
			self setperk("specialty_armorvest",1,0);
			thread chaos_extra_health_regen();
			break;

		case "specialty_juiced":
			self setmovespeedscale(1.25);
			break;

		default:
			thread maps\_so_survival_perks::give_perk_dummy();
			break;
	}

	self.num_perk_obtained++;
	self notify("perk_pop_up",param_00);
	return 1;
}

//Function Number: 57
chaos_extra_health_regen()
{
	level endon("special_op_terminated");
	self endon("chaos_stop_extra_health_regen");
	for(;;)
	{
		if(self.health < self.maxhealth)
		{
			var_00 = self.maxhealth - self.health;
			self.health = self.health + int(var_00 * 0.8);
		}

		wait 0.1;
	}
}

//Function Number: 58
chaos_give_perk_fastoffhand()
{
	self setperk("specialty_fastoffhand",1,0);
}

//Function Number: 59
unsetjuiced()
{
	self setmovespeedscale(1);
}

//Function Number: 60
chaos_eog_summary()
{
	var_00 = int(min(level.challenge_end_time - level.challenge_start_time,86400000));
	var_01 = int(var_00 % 1000 / 100);
	var_02 = int(var_00 / 1000) % 60;
	var_03 = int(var_00 / -5536) % 60;
	var_04 = int(var_00 / 3600000);
	if(var_04 < 10)
	{
		var_04 = "0" + var_04;
	}

	if(var_03 < 10)
	{
		var_03 = "0" + var_03;
	}

	if(var_02 < 10)
	{
		var_02 = "0" + var_02;
	}

	var_05 = var_04 + ":" + var_03 + ":" + var_02 + "." + var_01;
	chaos_clear_eog_summary_dvar();
	foreach(var_07 in level.players)
	{
		var_08 = var_07.game_performance["kill"];
		var_09 = lib_0623::func_3F6A(var_07,"kill");
		var_0A = var_07.game_performance["headshot"];
		var_0B = lib_0623::func_3F6A(var_07,"headshot");
		var_0C = var_07.game_performance["knife_kill"];
		var_0D = lib_0623::func_3F6A(var_07,"knife_kill");
		var_0E = var_07.game_performance["comboscoremax"];
		var_0F = var_07.game_performance["combomultmax"];
		var_10 = var_07.game_performance["long_shot"];
		var_11 = var_07.game_performance["triple_kill"];
		var_12 = var_07.game_performance["quad_kill"];
		var_13 = var_07.game_performance["multi_kill"];
		var_14 = var_07.game_performance["new_weapon_collected"];
		var_15 = var_07.game_performance["massive_explosion"];
		var_16 = var_07.game_performance["triple_long_shot"];
		var_17 = var_07.game_performance["triple_headshot"];
		var_18 = var_07.game_performance["triple_knife_kill"];
		var_19 = var_07.game_performance["explosive_kill"];
		var_1A = var_07.game_performance["execution"];
		var_1B = var_07.game_performance["grenade_kill"];
		var_1C = var_07.game_performance["explosive_jug"];
		var_1D = var_07.game_performance["riot_shield_jug"];
		var_1E = var_07.game_performance["regular_jug"];
		var_1F = var_07.game_performance["easy_kill"];
		var_20 = var_07.game_performance["regular_kill"];
		var_21 = var_07.game_performance["hardened_kill"];
		var_22 = var_07.game_performance["veteran_kill"];
		var_23 = var_07.game_performance["elite_kill"];
		var_24 = var_07.game_performance["chemical_kill"];
		var_25 = var_07.game_performance["martyrdom_kill"];
		var_26 = var_07.game_performance["regular_dog"];
		var_27 = var_07.game_performance["explosive_dog"];
		var_28 = var_07.game_performance["chopper_kill"];
		setdvar("ui_hide_hint",1);
		var_29 = 0;
		var_2A = 4;
		if(maps\_utility::is_coop())
		{
			var_07 chaos_add_custom_eog_summary_line("","@SPECIAL_OPS_PERFORMANCE_YOU","@SPECIAL_OPS_PERFORMANCE_PARTNER");
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_KILLS",var_08,var_09);
			var_07 chaos_add_custom_eog_summary_line("","","");
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_HIGHEST_COMBO",var_0F);
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_TIME",var_05);
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_SCORE",level.chaos_score);
			continue;
		}

		if(var_28 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_CHOPPER",var_28);
			var_29++;
		}

		if(var_15 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_MASSIVE_EXP",var_15);
			var_29++;
		}

		if(var_1C > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_EXP_JUG",var_1C);
			var_29++;
		}

		if(var_13 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_MUL_KILL",var_13);
			var_29++;
		}

		if(var_16 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_TRI_LONGSHOT",var_16);
			var_29++;
		}

		if(var_18 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_TRI_KNIFE",var_18);
			var_29++;
		}

		if(var_17 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_TRI_HEADSHOT",var_17);
			var_29++;
		}

		if(var_12 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_QUAD_KILL",var_12);
			var_29++;
		}

		if(var_1D > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_SHIELD_JUG",var_1D);
			var_29++;
		}

		if(var_11 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_TRI_KILL",var_11);
			var_29++;
		}

		if(var_1E > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_REG_JUG",var_1E);
			var_29++;
		}

		if(var_14 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_NEW_WEAPON",var_14);
			var_29++;
		}

		if(var_1B > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_GRENADE",var_1B);
			var_29++;
		}

		if(var_24 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_CHEMICAL",var_24);
			var_29++;
		}

		if(var_0A > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_HEADSHOT",var_0A);
			var_29++;
		}

		if(var_23 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_ELITE",var_23);
			var_29++;
		}

		if(var_22 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_VETERAN",var_22);
			var_29++;
		}

		if(var_1A > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_EXECUTION",var_1A);
			var_29++;
		}

		if(var_21 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_HARDENED",var_21);
			var_29++;
		}

		if(var_27 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_EXP_DOG",var_27);
			var_29++;
		}

		if(var_25 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_MARTYRDOM",var_25);
			var_29++;
		}

		if(var_10 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_LONG_SHOT",var_10);
			var_29++;
		}

		if(var_0C > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_KNIFE",var_0C);
			var_29++;
		}

		if(var_19 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_EXP_KILL",var_19);
			var_29++;
		}

		if(var_20 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_REG_KILL",var_20);
			var_29++;
		}

		if(var_26 > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_REG_DOG",var_26);
			var_29++;
		}

		if(var_1F > 0 && var_29 < var_2A)
		{
			var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_EOG_EASY",var_1F);
			var_29++;
		}

		var_07 chaos_add_custom_eog_summary_line_blank();
		var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_CHAOS_HIGHEST_COMBO",var_0F);
		var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_TIME",var_05);
		var_07 chaos_add_custom_eog_summary_line("@SO_SURVIVAL_PERFORMANCE_SCORE",level.chaos_score);
	}
}

//Function Number: 61
chaos_clear_eog_summary_dvar()
{
	var_00 = "";
	if(level.players.size > 1)
	{
		for(var_01 = 1;var_01 < 10;var_01++)
		{
			for(var_02 = 1;var_02 < 5;var_02++)
			{
				var_00 = "ui_eog_r" + var_01 + "c" + var_02 + "_player1";
				setdvar(var_00,"");
				var_00 = "ui_eog_r" + var_01 + "c" + var_02 + "_player2";
				setdvar(var_00,"");
			}
		}

		return;
	}

	for(var_01 = 1;var_01 < 10;var_01++)
	{
		for(var_02 = 1;var_02 < 5;var_02++)
		{
			var_00 = "ui_eog_r" + var_01 + "c" + var_02 + "_player1";
			setdvar(var_00,"");
		}
	}
}

//Function Number: 62
chaos_add_custom_eog_summary_line(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(self.eog_line))
	{
		self.eog_line = 0;
	}

	var_05 = undefined;
	if(isdefined(param_04))
	{
		var_05 = param_04;
		if(param_04 > self.eog_line)
		{
			self.eog_line = param_04;
		}
	}
	else
	{
		self.eog_line++;
		var_05 = self.eog_line;
	}

	chaos_set_custom_eog_summary(var_05,1,param_00);
	var_06 = [];
	if(isdefined(param_03))
	{
	}

	if(isdefined(param_03))
	{
	}

	if(isdefined(param_02))
	{
	}

	var_07 = 0;
	while(var_07 < var_7B.size)
	{
		chaos_set_custom_eog_summary(var_06,4 - var_07,var_7B[var_07]);
		var_07++ = var_7B[var_7B.size];
	}
}

//Function Number: 63
chaos_set_custom_eog_summary(param_00,param_01,param_02)
{
	var_03 = int(param_00);
	var_04 = int(param_01);
	var_05 = "";
	if(level.players.size > 1)
	{
		if(self == level.player)
		{
			var_05 = "ui_eog_r" + var_03 + "c" + var_04 + "_player1";
		}
		else if(self == level.player2)
		{
			var_05 = "ui_eog_r" + var_03 + "c" + var_04 + "_player2";
		}
		else
		{
		}
	}
	else
	{
		var_05 = "ui_eog_r" + var_03 + "c" + var_04 + "_player1";
	}

	setdvar(var_05,param_02);
}

//Function Number: 64
chaos_add_custom_eog_summary_line_blank()
{
	if(!isdefined(self.eog_line))
	{
		self.eog_line = 0;
	}

	self.eog_line++;
}

//Function Number: 65
radio_dialogue_to_player(param_00,param_01,param_02)
{
	if(!isdefined(level.player_radio_emitter))
	{
		var_03 = spawn("script_origin",(0,0,0));
		var_03 linkto(level.player,"",(0,0,0),(0,0,0));
		level.player_radio_emitter = var_03;
	}

	maps\_utility::bcs_scripted_dialogue_start();
	var_04 = 0;
	if(!isdefined(param_02))
	{
		var_04 = level.player_radio_emitter maps\_utility::function_stack(::chaos_play_sound_to_player,param_00,level.scr_radio[param_01],undefined,1);
	}
	else
	{
		var_04 = level.player_radio_emitter maps\_utility::function_stack_timeout(param_02,::chaos_play_sound_to_player,param_00,level.scr_radio[param_01],undefined,1);
	}

	return var_04;
}

//Function Number: 66
chaos_play_sound_to_player(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(maps\_utility::is_dead_sentient())
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	thread chaos_delete_on_death_wait_sound(param_00,"sounddone");
	param_00 playlocalsound(param_01,"sounddone",0);
	if(isdefined(param_03))
	{
		if(!isdefined(maps\_utility_code::wait_for_sounddone_or_death(param_00)))
		{
			param_00 stopsounds();
		}

		wait 0.05;
	}
	else
	{
		param_00 waittill("sounddone");
	}

	if(isdefined(param_04))
	{
		self notify(param_04);
	}
}

//Function Number: 67
chaos_delete_on_death_wait_sound(param_00,param_01)
{
	param_00 endon("death");
	self waittill("death");
	if(isdefined(param_00))
	{
		if(param_00 iswaitingonsound())
		{
			param_00 waittill(param_01);
		}
	}
}

//Function Number: 68
updateweaponheadiconforplayer()
{
	level endon("special_op_terminated");
	common_scripts\utility::flag_wait("slamzoom_finished");
	for(;;)
	{
		foreach(var_01 in level.chaos_entities)
		{
			foreach(var_03 in level.players)
			{
				if(sighttracepassed(var_03 geteye(),var_01.origin,0,var_03) || distancesquared(var_01.origin,var_03.origin) < 562500)
				{
					if(!isdefined(var_01.headiconforplayer[var_03.unique_id]) && var_01.weapon_in_use == 0)
					{
						var_04 = var_01 createweaponheadicon(var_03,var_01.hud_icon);
						var_01.headiconforplayer[var_03.unique_id] = var_04;
					}

					continue;
				}

				if(isdefined(var_01.headiconforplayer[var_03.unique_id]))
				{
					var_01.headiconforplayer[var_03.unique_id] destroy();
					var_01.headiconforplayer[var_03.unique_id] = undefined;
				}
			}
		}

		wait 0.5;
	}
}

//Function Number: 69
createweaponheadicon(param_00,param_01)
{
	var_02 = newclienthudelem(param_00);
	var_02.x = self.origin[0];
	var_02.y = self.origin[1];
	var_02.z = self.origin[2] + 5;
	var_02.alpha = 0.85;
	var_02.hidewheninmenu = 1;
	var_02 setshader(param_01,40,40);
	var_02 setwaypoint(1,0,1,0);
	var_02 thread chaoskeeppositioned(self,(0,0,5),0.05);
	return var_02;
}

//Function Number: 70
chaoskeeppositioned(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	var_03 = param_00.origin;
	for(;;)
	{
		if(!isdefined(param_00))
		{
			return;
		}

		if(var_03 != param_00.origin)
		{
			var_03 = param_00.origin;
			self.x = var_03[0] + param_01[0];
			self.y = var_03[1] + param_01[1];
			self.z = var_03[2] + param_01[2];
		}

		if(param_02 > 0.05)
		{
			self.alpha = 0.85;
			self fadeovertime(param_02);
			self.alpha = 0;
		}

		wait param_02;
	}
}

//Function Number: 71
manage_lives_left_hud()
{
	level endon("special_op_terminated");
	for(;;)
	{
		self waittill("player_downed");
		if(isdefined(self.laststand_info.type_getup_lives) && self.laststand_info.type_getup_lives > 0)
		{
			thread radio_dialogue_to_player(self,"chaos_get_onekill",1);
		}

		self.live_1_hud_icon.icon.alpha = 0;
		self.live_2_hud_icon.icon.alpha = 0;
		self.live_3_hud_icon.icon.alpha = 0;
		self.live_4_hud_icon.icon.alpha = 0;
		self.live_5_hud_icon.icon.alpha = 0;
		self waittill("revived");
		self disableinvulnerability();
		lib_0623::func_3F74("armor_1");
		if(isdefined(self.laststand_info.type_getup_lives) && self.laststand_info.type_getup_lives - 1 > 0)
		{
			var_00 = self.laststand_info.type_getup_lives - 1;
			wait 0.5;
			update_lives_left_hud(var_00);
			continue;
		}

		var_01 = spawnstruct();
		var_01.title = &"SO_SURVIVAL_CHAOS_SPLASH_FINAL_STAND";
		var_01.duration = 1.5;
		var_01.sound = "cm_bp_laststand_lastlife";
		thread player_combo_splash(var_01);
	}
}

//Function Number: 72
update_lives_left_hud(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	if(isdefined(self.live_1_hud_icon.icon) && isdefined(self.live_2_hud_icon.icon) && isdefined(self.live_3_hud_icon.icon) && isdefined(self.live_4_hud_icon.icon) && isdefined(self.live_5_hud_icon.icon))
	{
		if(param_00 == 5)
		{
			self.live_1_hud_icon.icon.alpha = 0.85;
			self.live_2_hud_icon.icon.alpha = 0.85;
			self.live_3_hud_icon.icon.alpha = 0.85;
			self.live_4_hud_icon.icon.alpha = 0.85;
			self.live_5_hud_icon.icon.alpha = 0.85;
			var_02 = -75;
		}
		else if(param_00 == 4)
		{
			self.live_1_hud_icon.icon.alpha = 0.85;
			self.live_2_hud_icon.icon.alpha = 0.85;
			self.live_3_hud_icon.icon.alpha = 0.85;
			self.live_4_hud_icon.icon.alpha = 0.85;
			self.live_5_hud_icon.icon.alpha = 0;
			var_02 = -60;
		}
		else if(param_00 == 3)
		{
			self.live_1_hud_icon.icon.alpha = 0.85;
			self.live_2_hud_icon.icon.alpha = 0.85;
			self.live_3_hud_icon.icon.alpha = 0.85;
			self.live_4_hud_icon.icon.alpha = 0;
			self.live_5_hud_icon.icon.alpha = 0;
			var_02 = -45;
		}
		else if(param_00 == 2)
		{
			self.live_1_hud_icon.icon.alpha = 0.85;
			self.live_2_hud_icon.icon.alpha = 0.85;
			self.live_3_hud_icon.icon.alpha = 0;
			self.live_4_hud_icon.icon.alpha = 0;
			self.live_5_hud_icon.icon.alpha = 0;
			var_02 = -30;
			if(!isdefined(param_01))
			{
				thread radio_dialogue_to_player(self,"chaos_2_last_stand",1);
			}
		}
		else if(param_00 == 1)
		{
			self.live_1_hud_icon.icon.alpha = 0.85;
			self.live_2_hud_icon.icon.alpha = 0;
			self.live_3_hud_icon.icon.alpha = 0;
			self.live_4_hud_icon.icon.alpha = 0;
			self.live_5_hud_icon.icon.alpha = 0;
			var_02 = -15;
			if(!isdefined(param_01))
			{
				thread radio_dialogue_to_player(self,"chaos_1_last_stand",1);
			}
		}
		else if(param_00 == 0)
		{
			self.live_1_hud_icon.icon.alpha = 0;
			self.live_2_hud_icon.icon.alpha = 0;
			self.live_3_hud_icon.icon.alpha = 0;
			self.live_4_hud_icon.icon.alpha = 0;
			self.live_5_hud_icon.icon.alpha = 0;
			var_02 = 0;
		}
		else
		{
		}

		if(issplitscreen())
		{
			var_03 = -80 - self != level.player * 19;
		}
		else
		{
			var_03 = 152;
		}

		self.live_1_hud_icon.icon maps\_hud_util::setpoint("LEFT","CENTER",var_02,var_03);
		self.live_2_hud_icon.icon maps\_hud_util::setpoint("LEFT","CENTER",var_02 + 30,var_03);
		self.live_3_hud_icon.icon maps\_hud_util::setpoint("LEFT","CENTER",var_02 + 60,var_03);
		self.live_4_hud_icon.icon maps\_hud_util::setpoint("LEFT","CENTER",var_02 + 90,var_03);
		self.live_5_hud_icon.icon maps\_hud_util::setpoint("LEFT","CENTER",var_02 + 120,var_03);
	}
}

//Function Number: 73
chaos_combo_player_create_hud()
{
	level.chaos_combo_all_hud_elems = [];
	self.chaos_score_hud = maps\_hud_util::createclientfontstring("hudbig",1.25);
	if(issplitscreen())
	{
		self.chaos_score_hud maps\_hud_util::setpoint("RIGHT","TOP RIGHT",undefined,0 + self != level.player * 27);
	}
	else
	{
		self.chaos_score_hud maps\_hud_util::setpoint("RIGHT","TOP RIGHT",undefined,undefined);
	}

	self.chaos_score_hud settext("0");
	self.chaos_score_hud.color = (1,1,0);
	self.chaos_score_hud.glowalpha = 0.25;
	self.chaos_score_hud.glowcolor = (0.2,0.2,0.2);
	self.chaos_score_hud.pulse_scale_normal = 1.25;
	self.chaos_score_hud.pulse_scale_big = 1.65;
	self.chaos_score_hud maps\_specialops_code::so_hud_pulse_init();
	self.chaos_score_hud.hidewheninmenu = 1;
	level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = self.chaos_score_hud;
	self.chaos_score_info_hud = maps\_hud_util::createclientfontstring("hudbig",1);
	self.chaos_score_info_hud maps\_hud_util::setpoint("RIGHT","TOP RIGHT",undefined,25);
	self.chaos_score_info_hud settext("0");
	self.chaos_score_info_hud maps\_specialops_code::so_hud_pulse_init();
	self.chaos_score_info_hud.hidewheninmenu = 1;
	self.chaos_score_info_hud.alpha = 0;
	level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = self.chaos_score_info_hud;
	self.chaos_combo_bar = chaos_special_item_hudelem(20,20);
	self.chaos_combo_bar.children = [];
	self.chaos_combo_bar maps\_hud_util::setparent(level.uiparent);
	self.chaos_combo_bar setshader("chaos_meter_16",162,8);
	if(issplitscreen())
	{
		self.chaos_combo_bar maps\_hud_util::setpoint("LEFT","CENTER",-79,85 - self != level.player * 27);
	}
	else
	{
		self.chaos_combo_bar maps\_hud_util::setpoint("LEFT","CENTER",-79,45);
	}

	self.chaos_combo_bar.glowcolor = (0.8,0.8,0.8);
	self.chaos_combo_bar.glowalpha = 0.5;
	self.chaos_combo_bar.hidewheninmenu = 1;
	level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = self.chaos_combo_bar;
	self.chaos_combo_hud_action_array = [];
	for(var_00 = 0;var_00 < level.chaos_combo_actions_max;var_00++)
	{
		var_01 = maps\_hud_util::createclientfontstring("hudsmall",1);
		if(issplitscreen())
		{
			var_01 maps\_hud_util::setpoint("RIGHT","CENTER RIGHT",undefined,var_00 * 18 + -20);
		}
		else
		{
			var_01 maps\_hud_util::setpoint("RIGHT","CENTER RIGHT",undefined,var_00 * 18);
		}

		var_01 settext("");
		var_01.alpha = 1 - var_00 * 1 / level.chaos_combo_actions_max;
		var_01.hidewheninmenu = 1;
		self.chaos_combo_hud_action_array[var_00] = var_01;
		level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = var_01;
	}

	self.chaos_combo_hud_multiply = maps\_hud_util::createclientfontstring("hudbig",1.6);
	if(issplitscreen())
	{
		self.chaos_combo_hud_multiply maps\_hud_util::setpoint("RIGHT","CENTER",-10,105 - self != level.player * 27);
	}
	else
	{
		self.chaos_combo_hud_multiply maps\_hud_util::setpoint("RIGHT","CENTER",-10,65);
	}

	self.chaos_combo_hud_multiply settext("");
	self.chaos_combo_hud_multiply.color = (1,1,0);
	self.chaos_combo_hud_multiply.glowcolor = (0,0,0);
	self.chaos_combo_hud_multiply.glowalpha = 0.8;
	self.chaos_combo_hud_multiply.pulse_scale_normal = 1.25;
	self.chaos_combo_hud_multiply.pulse_scale_big = 2;
	self.chaos_combo_hud_multiply.var_184D = 0.3;
	self.chaos_combo_hud_multiply maps\_specialops_code::so_hud_pulse_init();
	self.chaos_combo_hud_multiply.hidewheninmenu = 1;
	level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = self.chaos_combo_hud_multiply;
	self.chaos_combo_hud_score = maps\_hud_util::createclientfontstring("hudbig",1);
	if(issplitscreen())
	{
		self.chaos_combo_hud_score maps\_hud_util::setpoint("LEFT","CENTER",5,105 - self != level.player * 27);
	}
	else
	{
		self.chaos_combo_hud_score maps\_hud_util::setpoint("LEFT","CENTER",5,65);
	}

	self.chaos_combo_hud_score settext("");
	self.chaos_combo_hud_score.color = (1,1,0);
	self.chaos_combo_hud_score.hidewheninmenu = 1;
	level.chaos_combo_all_hud_elems[level.chaos_combo_all_hud_elems.size] = self.chaos_combo_hud_score;
}

//Function Number: 74
chaos_combo_all_hud_destroy()
{
	level waittill("special_op_terminated");
	foreach(var_01 in level.chaos_combo_all_hud_elems)
	{
		var_01 maps\_hud_util::destroyelem();
	}
}

//Function Number: 75
makecombomultiplyglowandpop()
{
	level endon("special_op_terminated");
	self.chaos_combo_hud_multiply.glowcolor = (0,0.2,1);
	self.chaos_combo_hud_multiply.glowalpha = 1;
	common_scripts\utility::waittill_notify_or_timeout("combo_update",1);
	self.chaos_combo_hud_multiply.glowcolor = (0,0,0);
	self.chaos_combo_hud_multiply.glowalpha = 0;
}

//Function Number: 76
chaos_combo_display_update(param_00,param_01,param_02,param_03,param_04)
{
	level endon("special_op_terminated");
	if(isdefined(param_04) && param_04)
	{
		if(param_01 != 0)
		{
			chaos_combo_actions_update(param_00,param_01);
		}
	}

	var_05 = level.chaos_score + param_02 * param_03;
	foreach(var_07 in level.players)
	{
		if(param_01 != 0)
		{
			var_07 chaos_combo_action_display_clear();
			var_08 = 0;
			for(var_09 = level.chaos_combo_actions.size - 1;var_09 >= 0;var_09--)
			{
				var_07.chaos_combo_hud_action_array[var_08].label = level.chaos_combo_actions[var_09].action_string;
				var_07.chaos_combo_hud_action_array[var_08] setvalue(level.chaos_combo_actions[var_09].point);
				var_08++;
			}

			if(issplitscreen())
			{
				var_07.chaos_combo_hud_action_array[0] maps\_hud_util::setpoint("CENTER","CENTER RIGHT",undefined,-20);
				var_07.chaos_combo_hud_action_array[0] maps\_hud_util::setpoint("RIGHT","CENTER RIGHT",undefined,-20,0.25);
			}
			else
			{
				var_07.chaos_combo_hud_action_array[0] maps\_hud_util::setpoint("CENTER","CENTER RIGHT",undefined,undefined);
				var_07.chaos_combo_hud_action_array[0] maps\_hud_util::setpoint("RIGHT","CENTER RIGHT",undefined,undefined,0.25);
			}
		}

		var_07.chaos_combo_hud_multiply settext(param_03 + "x");
		var_07.chaos_combo_hud_score settext(param_02);
		var_07.chaos_score_hud settext(format_good_looking_score(var_05));
		if(isdefined(param_04) && param_04)
		{
			var_07.chaos_combo_hud_multiply thread maps\_specialops::so_hud_pulse_create();
		}
	}
}

//Function Number: 77
format_good_looking_score(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	param_00 = int(param_00);
	if(param_00 < 1000)
	{
		if(isdefined(param_01) && param_01 == 1)
		{
			if(param_00 == 0)
			{
				return "000";
			}

			if(param_00 < 10)
			{
				return "00" + param_00;
			}

			if(param_00 < 100)
			{
				return "0" + param_00;
			}

			return param_00;
		}

		return param_00;
	}

	var_02 = param_00 % 1000;
	var_03 = float(param_00) - float(var_02) / 1000;
	return format_good_looking_score(var_03) + "," + format_good_looking_score(var_02,1);
}

//Function Number: 78
chaos_combo_display_clear()
{
	foreach(var_01 in level.players)
	{
		var_01 chaos_combo_action_display_clear();
		var_01.chaos_combo_hud_multiply settext("");
		var_01.chaos_combo_hud_score settext("");
	}
}

//Function Number: 79
chaos_combo_action_display_clear()
{
	for(var_00 = 0;var_00 < self.chaos_combo_hud_action_array.size;var_00++)
	{
		self.chaos_combo_hud_action_array[var_00].label = "";
		self.chaos_combo_hud_action_array[var_00] settext("");
	}
}

//Function Number: 80
recreate_last_stand_hud()
{
	common_scripts\utility::waitframe();
	if(!isdefined(level.player.revive_bar_getup))
	{
		level.laststand_hud_elements = [];
		maps\_laststand::laststand_revive_bar_getup_create();
	}
}

//Function Number: 81
chaos_combo_bar_hide(param_00)
{
	foreach(var_02 in level.players)
	{
		if(param_00)
		{
			var_02.chaos_combo_bar.alpha = 0;
			continue;
		}

		var_02.chaos_combo_bar.alpha = 1;
	}
}

//Function Number: 82
chaos_combo_bar_get_fill()
{
	return level.player.chaos_combo_bar.bar.frac;
}

//Function Number: 83
chaos_combo_bar_set_fill(param_00)
{
	common_scripts\utility::array_thread(level.players,::chaos_combo_bar_player_set_fill,param_00);
}

//Function Number: 84
chaos_combo_bar_player_set_fill(param_00)
{
	var_01 = "";
	if(isdefined(level.freeze_combo_meter) && level.freeze_combo_meter == 1)
	{
		var_01 = "chaos_frozen_meter";
		self.chaos_combo_bar setshader(var_01,162,32);
		return;
	}

	var_02 = int(param_00 * 100 / 6);
	if(var_02 == 0)
	{
		var_02 = 1;
	}

	var_01 = "chaos_meter_" + var_02;
	self.chaos_combo_bar setshader(var_01,162,8);
}

//Function Number: 85
chaos_score_hud_player_update(param_00)
{
	level endon("special_op_terminated");
	level endon("score_update_bump");
	self.chaos_score_info_hud.alpha = 1;
	self.chaos_score_info_hud settext(param_00 + "X COMBO!");
	self.chaos_score_info_hud maps\_hud_util::setpoint("LEFT","CENTER",undefined,-25);
	self.chaos_score_info_hud maps\_hud_util::setpoint("RIGHT","TOP RIGHT",undefined,25,0.5);
	self.chaos_score_info_hud maps\_specialops::so_hud_pulse_create();
	self.chaos_score_info_hud fadeovertime(0.5);
	self.chaos_score_info_hud.alpha = 0;
	self.chaos_score_hud settext(level.chaos_score);
	self.chaos_score_hud thread maps\_specialops::so_hud_pulse_create();
}

//Function Number: 86
chaos_timer_destroy(param_00)
{
	level waittill("special_op_terminated");
	if(isdefined(param_00))
	{
		param_00 maps\_hud_util::destroyelem();
	}
}

//Function Number: 87
set_player_time_up_vision()
{
	level endon("special_op_terminated");
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.combathighoverlay))
		{
			var_01.combathighoverlay = newclienthudelem(var_01);
			var_01.combathighoverlay.x = 0;
			var_01.combathighoverlay.y = 0;
			var_01.combathighoverlay.alignx = "left";
			var_01.combathighoverlay.aligny = "top";
			var_01.combathighoverlay.horzalign = "fullscreen";
			var_01.combathighoverlay.vertalign = "fullscreen";
			var_01.combathighoverlay setshader("combathigh_overlay",640,480);
			var_01.combathighoverlay.sort = -10;
			var_01.combathighoverlay.archived = 1;
		}
	}
}

//Function Number: 88
chaos_timer_fade(param_00)
{
	param_00 endon("death");
	param_00 maps\_hud_util::fade_over_time(0,2);
	wait 2;
	if(!isdefined(param_00))
	{
		return;
	}

	param_00 destroy();
}

//Function Number: 89
chaos_timer_create_hud_elem(param_00)
{
	var_01 = newclienthudelem(param_00);
	var_01.elemtype = "timer";
	var_01.font = "hudbig";
	var_01.fontscale = 1;
	var_01.basefontscale = var_01.fontscale;
	var_01.x = 0;
	var_01.y = 0;
	var_01.width = 0;
	var_01.height = int(level.fontheight * var_01.fontscale);
	var_01.hidewheninmenu = 1;
	var_01.xoffset = 0;
	var_01.yoffset = 0;
	var_01.children = [];
	var_01 maps\_hud_util::setparent(level.uiparent);
	if(issplitscreen())
	{
		var_01 maps\_hud_util::setpoint("TOP","TOP",undefined,-12 + self != level.player * 27);
	}
	else
	{
		var_01 maps\_hud_util::setpoint("TOP","TOP",undefined,-12);
	}

	var_01.hidden = 0;
	return var_01;
}

//Function Number: 90
chaos_timer_update_flash(param_00,param_01,param_02)
{
	level endon("special_op_terminated");
	level endon("wave_ended");
	level endon("update_chaos_timer");
	var_03 = param_01 - param_02;
	if(var_03 > 0)
	{
		wait var_03;
	}

	var_04 = param_02 / 1;
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		param_00.fontscale = 1.2;
		param_00 maps\_specialops::set_hud_red();
		wait 0.5;
		param_00.fontscale = 1;
		param_00 maps\_specialops::set_hud_yellow();
		wait 0.5;
	}

	param_00 maps\_specialops::set_hud_red();
	level thread set_player_time_up_vision();
}

//Function Number: 91
chaos_timer_update_color(param_00,param_01,param_02)
{
	level endon("special_op_terminated");
	level endon("wave_ended");
	level endon("update_chaos_timer");
	var_03 = param_01 - param_02;
	if(var_03 > 0)
	{
		wait var_03;
	}

	param_00 maps\_specialops::set_hud_yellow();
}

//Function Number: 92
chaos_timer_update_sound(param_00,param_01)
{
	level endon("special_op_terminated");
	level endon("wave_ended");
	level endon("chaos_timer_reached_zero");
	level endon("update_chaos_timer");
	var_02 = param_00 - param_01;
	if(var_02 >= 0)
	{
		if(var_02 > 0)
		{
			wait var_02;
		}

		param_00 = param_00 - var_02;
		self playlocalsound("so_countdown_beep");
	}

	for(;;)
	{
		var_03 = param_00 - int(param_00);
		if(var_03 == 0)
		{
			var_03 = 1;
		}

		if(param_00 - var_03 <= 0)
		{
			break;
		}

		wait var_03;
		param_00 = param_00 - var_03;
		self playlocalsound("so_countdown_beep");
	}
}

//Function Number: 93
chaos_destroyelem()
{
	var_00 = [];
	for(var_01 = 0;var_01 < self.children.size;var_01++)
	{
		if(isdefined(self.children[var_01]))
		{
			var_00[var_00.size] = self.children[var_01];
		}
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] maps\_hud_util::setparent(maps\_hud_util::getparent());
	}

	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		self.bar destroy();
	}

	self destroy();
}

//Function Number: 94
showelem()
{
	if(!self.hidden)
	{
		return;
	}

	self.hidden = 0;
	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		if(self.alpha != 0.5)
		{
			self.alpha = 0.5;
		}

		self.bar.hidden = 0;
		if(self.bar.alpha != 1)
		{
			self.bar.alpha = 1;
			return;
		}

		return;
	}

	if(self.alpha != 1)
	{
		self.alpha = 1;
	}
}

//Function Number: 95
hideelem()
{
	if(self.hidden)
	{
		return;
	}

	self.hidden = 1;
	if(self.alpha != 0)
	{
		self.alpha = 0;
	}

	if(self.elemtype == "bar" || self.elemtype == "bar_shader")
	{
		self.bar.hidden = 1;
		if(self.bar.alpha != 0)
		{
			self.bar.alpha = 0;
		}
	}
}

//Function Number: 96
chaos_updatebar(param_00,param_01)
{
	if(self.elemtype == "bar")
	{
		updatebarscale(param_00,param_01);
	}
}

//Function Number: 97
updatebarscale(param_00,param_01)
{
	var_02 = int(self.width * param_00 + 0.5);
	if(!var_02)
	{
		var_02 = 1;
	}

	self.bar.frac = param_00;
	self.bar setshader(self.bar.shader,var_02,self.height);
	if(isdefined(param_01) && var_02 < self.width)
	{
		if(param_01 > 0)
		{
			self.bar scaleovertime(1 - param_00 / param_01,self.width,self.height);
		}
		else if(param_01 < 0)
		{
			self.bar scaleovertime(param_00 / -1 * param_01,1,self.height);
		}
	}

	self.bar.rateofchange = param_01;
	self.bar.lastupdatetime = gettime();
}

//Function Number: 98
createprimaryprogressbartext(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = maps\_hud_util::createclientfontstring("hudbig",level.primaryprogressbarfontsize);
	var_01.hidden = 0;
	var_01 chaos_setpoint("CENTER",undefined,level.primaryprogressbartextx,level.primaryprogressbartexty - param_00);
	var_01.sort = -1;
	return var_01;
}

//Function Number: 99
createprimaryprogressbar(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = chaos_createbar((1,1,1),level.primaryprogressbarwidth,level.primaryprogressbarheight);
	var_01 chaos_setpoint("CENTER",undefined,level.primaryprogressbarx,level.primaryprogressbary - param_00);
	return var_01;
}

//Function Number: 100
chaos_createbar(param_00,param_01,param_02,param_03)
{
	var_04 = newclienthudelem(self);
	var_04.x = 0;
	var_04.y = 0;
	var_04.frac = 0;
	var_04.color = param_00;
	var_04.sort = -2;
	var_04.shader = "progress_bar_fill";
	var_04 setshader("progress_bar_fill",param_01,param_02);
	var_04.hidden = 0;
	if(isdefined(param_03))
	{
		var_04.flashfrac = param_03;
	}

	var_05 = newclienthudelem(self);
	var_05.elemtype = "bar";
	var_05.width = param_01;
	var_05.height = param_02;
	var_05.xoffset = 0;
	var_05.yoffset = 0;
	var_05.bar = var_04;
	var_05.children = [];
	var_05.sort = -3;
	var_05.color = (0,0,0);
	var_05.alpha = 0.5;
	var_05.padding = 0;
	var_05 maps\_hud_util::setparent(level.uiparent);
	var_05 setshader("progress_bar_bg",param_01 + 4,param_02 + 4);
	var_05.hidden = 0;
	return var_05;
}

//Function Number: 101
chaos_setpoint(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_05 = maps\_hud_util::getparent();
	if(param_04)
	{
		self moveovertime(param_04);
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	self.xoffset = param_02;
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	self.yoffset = param_03;
	self.point = param_00;
	self.alignx = "center";
	self.aligny = "middle";
	if(issubstr(param_00,"TOP"))
	{
		self.aligny = "top";
	}

	if(issubstr(param_00,"BOTTOM"))
	{
		self.aligny = "bottom";
	}

	if(issubstr(param_00,"LEFT"))
	{
		self.alignx = "left";
	}

	if(issubstr(param_00,"RIGHT"))
	{
		self.alignx = "right";
	}

	if(!isdefined(param_01))
	{
		param_01 = param_00;
	}

	self.relativepoint = param_01;
	var_06 = "center_adjustable";
	var_07 = "middle";
	if(issubstr(param_01,"TOP"))
	{
		var_07 = "top_adjustable";
	}

	if(issubstr(param_01,"BOTTOM"))
	{
		var_07 = "bottom_adjustable";
	}

	if(issubstr(param_01,"LEFT"))
	{
		var_06 = "left_adjustable";
	}

	if(issubstr(param_01,"RIGHT"))
	{
		var_06 = "right_adjustable";
	}

	if(var_05 == level.uiparent)
	{
		self.horzalign = var_06;
		self.vertalign = var_07;
	}
	else
	{
		self.horzalign = var_05.horzalign;
		self.vertalign = var_05.vertalign;
	}

	if(strip_suffix(var_06,"_adjustable") == var_05.alignx)
	{
		var_08 = 0;
		var_09 = 0;
	}
	else if(var_08 == "center" || var_07.alignx == "center")
	{
		var_08 = int(var_07.width / 2);
		if(var_07 == "left_adjustable" || var_06.alignx == "right")
		{
			var_09 = -1;
		}
		else
		{
			var_09 = 1;
		}
	}
	else
	{
		var_08 = var_07.width;
		if(var_07 == "left_adjustable")
		{
			var_09 = -1;
		}
		else
		{
			var_09 = 1;
		}
	}

	self.x = var_05.x + var_08 * var_09;
	if(strip_suffix(var_07,"_adjustable") == var_05.aligny)
	{
		var_0A = 0;
		var_0B = 0;
	}
	else if(var_09 == "middle" || var_07.aligny == "middle")
	{
		var_0A = int(var_07.height / 2);
		if(var_08 == "top_adjustable" || var_06.aligny == "bottom")
		{
			var_0B = -1;
		}
		else
		{
			var_0B = 1;
		}
	}
	else
	{
		var_0A = var_07.height;
		if(var_08 == "top_adjustable")
		{
			var_0B = -1;
		}
		else
		{
			var_0B = 1;
		}
	}

	self.y = var_05.y + var_0A * var_0B;
	self.x = self.x + self.xoffset;
	self.y = self.y + self.yoffset;
	switch(self.elemtype)
	{
		case "bar":
			chaos_setpointbar(param_00,param_01,param_02,param_03);
			break;
	}

	maps\_hud_util::updatechildren();
}

//Function Number: 102
chaos_setpointbar(param_00,param_01,param_02,param_03)
{
	self.bar.horzalign = self.horzalign;
	self.bar.vertalign = self.vertalign;
	self.bar.alignx = "left";
	self.bar.aligny = self.aligny;
	self.bar.y = self.y;
	if(self.alignx == "left")
	{
		self.bar.x = self.x;
	}
	else if(self.alignx == "right")
	{
		self.bar.x = self.x - self.width;
	}
	else
	{
		self.bar.x = self.x - int(self.width / 2);
	}

	if(self.aligny == "top")
	{
		self.bar.y = self.y;
	}
	else if(self.aligny == "bottom")
	{
		self.bar.y = self.y;
	}

	chaos_updatebar(self.bar.frac);
}

//Function Number: 103
strip_suffix(param_00,param_01)
{
	if(param_00.size <= param_01.size)
	{
		return param_00;
	}

	if(getsubstr(param_00,param_00.size - param_01.size,param_00.size) == param_01)
	{
		return getsubstr(param_00,0,param_00.size - param_01.size);
	}

	return param_00;
}

//Function Number: 104
destroyiconsondeath()
{
	self notify("destroyIconsOnDeath");
	self endon("destroyIconsOnDeath");
	self waittill("death");
	foreach(var_01 in self.crateworldicon)
	{
		var_01 destroy();
	}
}

//Function Number: 105
keeppositioned(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	var_03 = param_00.origin;
	for(;;)
	{
		if(var_03 != param_00.origin)
		{
			var_03 = param_00.origin;
			self.x = var_03[0] + param_01[0];
			self.y = var_03[0] + param_01[0];
			self.z = var_03[0] + param_01[0];
		}

		wait 0.05;
	}
}

//Function Number: 106
keepiconpositioned()
{
	self endon("kill_entity_headicon_thread");
	self endon("death");
	var_00 = self.origin;
	for(;;)
	{
		if(var_00 != self.origin)
		{
			updateheadiconorigin();
			var_00 = self.origin;
		}

		wait 0.05;
	}
}

//Function Number: 107
destroyheadiconsondeath()
{
	self endon("kill_entity_headicon_thread");
	self waittill("death");
	if(!isdefined(self.entityheadicon))
	{
		return;
	}

	self.entityheadicon destroy();
}

//Function Number: 108
updateheadiconorigin()
{
	self.entityheadicon.x = self.origin[0] + self.entityheadiconoffset[0];
	self.entityheadicon.y = self.origin[1] + self.entityheadiconoffset[1];
	self.entityheadicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

//Function Number: 109
perk_hud_popup_icon()
{
	self endon("death");
	self.perk_hud_popup_icon = spawnstruct();
	self.perk_hud_popup_icon.var_3FCA = -30;
	if(issplitscreen())
	{
		self.perk_hud_popup_icon.var_3FCB = 2 + self == level.player * 27;
	}
	else
	{
		self.perk_hud_popup_icon.var_3FCB = 86;
	}

	self.perk_hud_popup_icon.var_3FCC = 28;
	self.perk_hud_popup_icon.icon = chaos_special_item_hudelem(self.perk_hud_popup_icon.var_3FCA,self.perk_hud_popup_icon.var_3FCB);
	self.perk_hud_popup_icon.icon.color = (1,1,1);
	self.perk_hud_popup_icon.icon.alpha = 1;
	self.perk_hud_popup_icon.icon.children = [];
	self.perk_hud_popup_icon.icon maps\_hud_util::setparent(level.uiparent);
	self.perk_hud_popup_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
	for(;;)
	{
		self waittill("perk_pop_up",var_00);
		if(isdefined(self.live_1_hud_icon.icon) && isdefined(self.live_2_hud_icon.icon) && isdefined(self.live_3_hud_icon.icon) && isdefined(self.live_4_hud_icon.icon) && isdefined(self.live_5_hud_icon.icon))
		{
			if(!issplitscreen())
			{
				self.live_1_hud_icon.icon.alpha = 0;
				self.live_2_hud_icon.icon.alpha = 0;
				self.live_3_hud_icon.icon.alpha = 0;
				self.live_4_hud_icon.icon.alpha = 0;
				self.live_5_hud_icon.icon.alpha = 0;
			}
		}

		var_01 = getperkname(var_00);
		if(var_00 == "specialty_juiced")
		{
			var_02 = "chaos_specialty_juiced";
		}
		else if(var_00 == "specialty_armorvest")
		{
			var_02 = "chaos_specialty_armorvest";
		}
		else
		{
			var_02 = level.armory["airsupport"][var_00].icon;
		}

		self.perk_hud_popup_icon.icon setshader(var_02,self.perk_hud_popup_icon.var_3FCC,self.perk_hud_popup_icon.var_3FCC);
		self.perk_hud_popup_icon.icon.alpha = 0.85;
		if(issplitscreen())
		{
			self.perk_hud_popup_icon.icon maps\_hud_util::setpoint("LEFT","CENTER",self.perk_hud_popup_icon.var_3FCA - 150,self.perk_hud_popup_icon.var_3FCB + 80);
		}
		else
		{
			self.perk_hud_popup_icon.icon maps\_hud_util::setpoint("LEFT","CENTER",self.perk_hud_popup_icon.var_3FCA - 50,self.perk_hud_popup_icon.var_3FCB + 30);
		}

		wait 0.2;
		if(issplitscreen())
		{
			self.perk_hud_popup_icon.icon setshader(var_02,self.perk_hud_popup_icon.var_3FCC * 2,self.perk_hud_popup_icon.var_3FCC * 2);
		}
		else
		{
			self.perk_hud_popup_icon.icon setshader(var_02,self.perk_hud_popup_icon.var_3FCC * 3,self.perk_hud_popup_icon.var_3FCC * 3);
		}

		wait 0.45;
		self.perk_hud_popup_icon.icon setshader(var_02,self.perk_hud_popup_icon.var_3FCC,self.perk_hud_popup_icon.var_3FCC);
		if(issplitscreen())
		{
			self.perk_hud_popup_icon.icon maps\_hud_util::setpoint("LEFT","BOTTOM LEFT",241 - self.num_perk_obtained * 30 + level.perk_offset + self != level.player * 100,-8,0.35);
		}
		else
		{
			self.perk_hud_popup_icon.icon maps\_hud_util::setpoint("LEFT","BOTTOM LEFT",241 - self.num_perk_obtained * 30 + level.perk_offset,-8,0.35);
		}

		wait 0.35;
		self.perk_hud_popup_icon.icon.alpha = 0;
		if(self.num_perk_obtained > 1)
		{
			var_03 = "give_perk_" + self.num_perk_obtained;
			self notify(var_03,var_00);
		}
		else
		{
			self notify("give_perk",var_00);
		}

		level.player_currently_getting_perk = 0;
		level notify("proceed_with_next_perk");
		if(!maps\_utility::is_player_down(self))
		{
			update_lives_left_hud(self.laststand_info.type_getup_lives,1);
		}
	}
}

//Function Number: 110
live_1_hud_icon()
{
	self endon("death");
	self.live_1_hud_icon = spawnstruct();
	self.live_1_hud_icon.var_3FCA = -75;
	if(issplitscreen())
	{
		self.live_1_hud_icon.var_3FCB = 2 + self == level.player * 27;
	}
	else
	{
		self.live_1_hud_icon.var_3FCB = 86;
	}

	self.live_1_hud_icon.var_3FCC = 28;
	self.live_1_hud_icon.icon = chaos_special_item_hudelem(self.live_1_hud_icon.var_3FCA,self.live_1_hud_icon.var_3FCB);
	self.live_1_hud_icon.icon.color = (1,1,1);
	self.live_1_hud_icon.icon.alpha = 0;
	self.live_1_hud_icon.icon.children = [];
	self.live_1_hud_icon.icon maps\_hud_util::setparent(level.uiparent);
	self.live_1_hud_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
	self.live_1_hud_icon.icon setshader("specialty_self_revive",self.live_1_hud_icon.var_3FCC,self.live_1_hud_icon.var_3FCC);
	self.live_1_hud_icon.icon maps\_hud_util::setpoint("LEFT","TOP",self.live_1_hud_icon.var_3FCA,self.live_1_hud_icon.var_3FCB - 55);
}

//Function Number: 111
live_2_hud_icon()
{
	self endon("death");
	self.live_2_hud_icon = spawnstruct();
	self.live_2_hud_icon.var_3FCA = -45;
	if(issplitscreen())
	{
		self.live_2_hud_icon.var_3FCB = 2 + self == level.player * 27;
	}
	else
	{
		self.live_2_hud_icon.var_3FCB = 86;
	}

	self.live_2_hud_icon.var_3FCC = 28;
	self.live_2_hud_icon.icon = chaos_special_item_hudelem(self.live_2_hud_icon.var_3FCA,self.live_2_hud_icon.var_3FCB);
	self.live_2_hud_icon.icon.color = (1,1,1);
	self.live_2_hud_icon.icon.alpha = 0;
	self.live_2_hud_icon.icon.children = [];
	self.live_2_hud_icon.icon maps\_hud_util::setparent(level.uiparent);
	self.live_2_hud_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
	self.live_2_hud_icon.icon setshader("specialty_self_revive",self.live_2_hud_icon.var_3FCC,self.live_2_hud_icon.var_3FCC);
	self.live_2_hud_icon.icon maps\_hud_util::setpoint("LEFT","TOP",self.live_2_hud_icon.var_3FCA,self.live_2_hud_icon.var_3FCB - 55);
}

//Function Number: 112
live_3_hud_icon()
{
	self endon("death");
	self.live_3_hud_icon = spawnstruct();
	self.live_3_hud_icon.var_3FCA = -15;
	if(issplitscreen())
	{
		self.live_3_hud_icon.var_3FCB = 2 + self == level.player * 27;
	}
	else
	{
		self.live_3_hud_icon.var_3FCB = 86;
	}

	self.live_3_hud_icon.var_3FCC = 28;
	self.live_3_hud_icon.icon = chaos_special_item_hudelem(self.live_3_hud_icon.var_3FCA,self.live_3_hud_icon.var_3FCB);
	self.live_3_hud_icon.icon.color = (1,1,1);
	self.live_3_hud_icon.icon.alpha = 0;
	self.live_3_hud_icon.icon.children = [];
	self.live_3_hud_icon.icon maps\_hud_util::setparent(level.uiparent);
	self.live_3_hud_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
	self.live_3_hud_icon.icon setshader("specialty_self_revive",self.live_3_hud_icon.var_3FCC,self.live_3_hud_icon.var_3FCC);
	self.live_3_hud_icon.icon maps\_hud_util::setpoint("LEFT","TOP",self.live_3_hud_icon.var_3FCA,self.live_3_hud_icon.var_3FCB - 55);
}

//Function Number: 113
live_4_hud_icon()
{
	self endon("death");
	self.live_4_hud_icon = spawnstruct();
	self.live_4_hud_icon.var_3FCA = 15;
	if(issplitscreen())
	{
		self.live_4_hud_icon.var_3FCB = 2 + self == level.player * 27;
	}
	else
	{
		self.live_4_hud_icon.var_3FCB = 86;
	}

	self.live_4_hud_icon.var_3FCC = 28;
	self.live_4_hud_icon.icon = chaos_special_item_hudelem(self.live_4_hud_icon.var_3FCA,self.live_4_hud_icon.var_3FCB);
	self.live_4_hud_icon.icon.color = (1,1,1);
	self.live_4_hud_icon.icon.alpha = 0;
	self.live_4_hud_icon.icon.children = [];
	self.live_4_hud_icon.icon maps\_hud_util::setparent(level.uiparent);
	self.live_4_hud_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
	self.live_4_hud_icon.icon setshader("specialty_self_revive",self.live_4_hud_icon.var_3FCC,self.live_4_hud_icon.var_3FCC);
	self.live_4_hud_icon.icon maps\_hud_util::setpoint("LEFT","TOP",self.live_4_hud_icon.var_3FCA,self.live_4_hud_icon.var_3FCB - 55);
}

//Function Number: 114
live_5_hud_icon()
{
	self endon("death");
	self.live_5_hud_icon = spawnstruct();
	self.live_5_hud_icon.var_3FCA = 45;
	if(issplitscreen())
	{
		self.live_5_hud_icon.var_3FCB = 2 + self == level.player * 27;
	}
	else
	{
		self.live_5_hud_icon.var_3FCB = 86;
	}

	self.live_5_hud_icon.var_3FCC = 28;
	self.live_5_hud_icon.icon = chaos_special_item_hudelem(self.live_5_hud_icon.var_3FCA,self.live_5_hud_icon.var_3FCB);
	self.live_5_hud_icon.icon.color = (1,1,1);
	self.live_5_hud_icon.icon.alpha = 0;
	self.live_5_hud_icon.icon.children = [];
	self.live_5_hud_icon.icon maps\_hud_util::setparent(level.uiparent);
	self.live_5_hud_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
	self.live_5_hud_icon.icon setshader("specialty_self_revive",self.live_5_hud_icon.var_3FCC,self.live_5_hud_icon.var_3FCC);
	self.live_5_hud_icon.icon maps\_hud_util::setpoint("LEFT","TOP",self.live_5_hud_icon.var_3FCA,self.live_5_hud_icon.var_3FCB - 55);
}

//Function Number: 115
hud_weapon_icon()
{
	self endon("death");
	self.hud_weapon_icon = spawnstruct();
	self.hud_weapon_icon.var_3FCA = 0;
	if(issplitscreen())
	{
		self.hud_weapon_icon.var_3FCB = -122 + self == level.player * 27;
	}
	else
	{
		self.hud_weapon_icon.var_3FCB = -14;
	}

	self.hud_weapon_icon.var_3FCC = 28;
	self.hud_weapon_icon.icon = chaos_special_item_hudelem(self.hud_weapon_icon.var_3FCA,self.hud_weapon_icon.var_3FCB);
	self.hud_weapon_icon.icon.color = (1,1,1);
	self.hud_weapon_icon.icon.alpha = 0;
	self.hud_weapon_icon.icon thread chaos_perk_icon_destroy_on_mode_end();
	for(;;)
	{
		self waittill("weapon_icon_popup",var_00);
		if(issubstr(var_00,"fmg9") || issubstr(var_00,"m9") || issubstr(var_00,"glock"))
		{
			self.hud_weapon_icon.icon setshader(var_00,64,64);
		}
		else
		{
			self.hud_weapon_icon.icon setshader(var_00,128,64);
		}

		self.hud_weapon_icon.icon.alpha = 0.85;
		thread weapon_icon_fadeaway();
	}
}

//Function Number: 116
weapon_icon_fadeaway()
{
	self notify("end_on_weapon_icon_fadeaway");
	self endon("end_on_weapon_icon_fadeaway");
	wait 0.05;
	self.hud_weapon_icon.icon fadeovertime(0.05);
	self.hud_weapon_icon.icon.alpha = 0;
}

//Function Number: 117
perk_hud_2()
{
	self endon("death");
	self.perk_icon_hud_2 = spawnstruct();
	self.perk_icon_hud_2.var_3FCA = -168 + level.perk_offset;
	if(issplitscreen())
	{
		self.perk_icon_hud_2.var_3FCB = 112 + self == level.player * 27;
	}
	else
	{
		self.perk_icon_hud_2.var_3FCB = 196;
	}

	self.perk_icon_hud_2.var_3FCC = 28;
	self.perk_icon_hud_2.icon = chaos_special_item_hudelem(self.perk_icon_hud_2.var_3FCA,self.perk_icon_hud_2.var_3FCB);
	self.perk_icon_hud_2.icon.color = (1,1,1);
	self.perk_icon_hud_2.icon.alpha = 0;
	self.perk_icon_hud_2.icon thread chaos_perk_icon_destroy_on_mode_end();
	for(;;)
	{
		self waittill("give_perk_2",var_00);
		if(var_00 == "specialty_juiced")
		{
			var_01 = "chaos_specialty_juiced";
		}
		else if(var_00 == "specialty_armorvest")
		{
			var_01 = "chaos_specialty_armorvest";
		}
		else
		{
			var_01 = level.armory["airsupport"][var_00].icon;
		}

		self.perk_icon_hud_2.icon setshader(var_01,self.perk_icon_hud_2.var_3FCC,self.perk_icon_hud_2.var_3FCC);
		self.perk_icon_hud_2.icon.alpha = 0.85;
	}
}

//Function Number: 118
perk_hud_3()
{
	self endon("death");
	self.perk_icon_hud_3 = spawnstruct();
	self.perk_icon_hud_3.var_3FCA = -198 + level.perk_offset;
	if(issplitscreen())
	{
		self.perk_icon_hud_3.var_3FCB = 112 + self == level.player * 27;
	}
	else
	{
		self.perk_icon_hud_3.var_3FCB = 196;
	}

	self.perk_icon_hud_3.var_3FCC = 28;
	self.perk_icon_hud_3.icon = chaos_special_item_hudelem(self.perk_icon_hud_3.var_3FCA,self.perk_icon_hud_3.var_3FCB);
	self.perk_icon_hud_3.icon.color = (1,1,1);
	self.perk_icon_hud_3.icon.alpha = 0;
	self.perk_icon_hud_3.icon thread chaos_perk_icon_destroy_on_mode_end();
	for(;;)
	{
		self waittill("give_perk_3",var_00);
		if(var_00 == "specialty_juiced")
		{
			var_01 = "chaos_specialty_juiced";
		}
		else if(var_00 == "specialty_armorvest")
		{
			var_01 = "chaos_specialty_armorvest";
		}
		else
		{
			var_01 = level.armory["airsupport"][var_00].icon;
		}

		self.perk_icon_hud_3.icon setshader(var_01,self.perk_icon_hud_3.var_3FCC,self.perk_icon_hud_3.var_3FCC);
		self.perk_icon_hud_3.icon.alpha = 0.85;
	}
}

//Function Number: 119
perk_hud_4()
{
	self endon("death");
	self.perk_icon_hud_4 = spawnstruct();
	self.perk_icon_hud_4.var_3FCA = -228 + level.perk_offset;
	if(issplitscreen())
	{
		self.perk_icon_hud_4.var_3FCB = 112 + self == level.player * 27;
	}
	else
	{
		self.perk_icon_hud_4.var_3FCB = 196;
	}

	self.perk_icon_hud_4.var_3FCC = 28;
	self.perk_icon_hud_4.icon = chaos_special_item_hudelem(self.perk_icon_hud_4.var_3FCA,self.perk_icon_hud_4.var_3FCB);
	self.perk_icon_hud_4.icon.color = (1,1,1);
	self.perk_icon_hud_4.icon.alpha = 0;
	self.perk_icon_hud_4.icon thread chaos_perk_icon_destroy_on_mode_end();
	for(;;)
	{
		self waittill("give_perk_4",var_00);
		if(var_00 == "specialty_juiced")
		{
			var_01 = "chaos_specialty_juiced";
		}
		else if(var_00 == "specialty_armorvest")
		{
			var_01 = "chaos_specialty_armorvest";
		}
		else
		{
			var_01 = level.armory["airsupport"][var_00].icon;
		}

		self.perk_icon_hud_4.icon setshader(var_01,self.perk_icon_hud_4.var_3FCC,self.perk_icon_hud_4.var_3FCC);
		self.perk_icon_hud_4.icon.alpha = 0.85;
	}
}

//Function Number: 120
perk_hud_5()
{
	self endon("death");
	self.perk_icon_hud_5 = spawnstruct();
	self.perk_icon_hud_5.var_3FCA = -258 + level.perk_offset;
	if(issplitscreen())
	{
		self.perk_icon_hud_5.var_3FCB = 112 + self == level.player * 27;
	}
	else
	{
		self.perk_icon_hud_5.var_3FCB = 196;
	}

	self.perk_icon_hud_5.var_3FCC = 28;
	self.perk_icon_hud_5.icon = chaos_special_item_hudelem(self.perk_icon_hud_5.var_3FCA,self.perk_icon_hud_5.var_3FCB);
	self.perk_icon_hud_5.icon.color = (1,1,1);
	self.perk_icon_hud_5.icon.alpha = 0;
	self.perk_icon_hud_5.icon thread chaos_perk_icon_destroy_on_mode_end();
	for(;;)
	{
		self waittill("give_perk_5",var_00);
		if(var_00 == "specialty_juiced")
		{
			var_01 = "chaos_specialty_juiced";
		}
		else if(var_00 == "specialty_armorvest")
		{
			var_01 = "chaos_specialty_armorvest";
		}
		else
		{
			var_01 = level.armory["airsupport"][var_00].icon;
		}

		self.perk_icon_hud_5.icon setshader(var_01,self.perk_icon_hud_5.var_3FCC,self.perk_icon_hud_5.var_3FCC);
		self.perk_icon_hud_5.icon.alpha = 0.85;
	}
}

//Function Number: 121
perk_hud_6()
{
	self endon("death");
	self.perk_icon_hud_6 = spawnstruct();
	self.perk_icon_hud_6.var_3FCA = -288 + level.perk_offset;
	if(issplitscreen())
	{
		self.perk_icon_hud_6.var_3FCB = 112 + self == level.player * 27;
	}
	else
	{
		self.perk_icon_hud_6.var_3FCB = 196;
	}

	self.perk_icon_hud_6.var_3FCC = 28;
	self.perk_icon_hud_6.icon = chaos_special_item_hudelem(self.perk_icon_hud_6.var_3FCA,self.perk_icon_hud_6.var_3FCB);
	self.perk_icon_hud_6.icon.color = (1,1,1);
	self.perk_icon_hud_6.icon.alpha = 0;
	self.perk_icon_hud_6.icon thread chaos_perk_icon_destroy_on_mode_end();
	for(;;)
	{
		self waittill("give_perk_6",var_00);
		if(var_00 == "specialty_juiced")
		{
			var_01 = "chaos_specialty_juiced";
		}
		else if(var_00 == "specialty_armorvest")
		{
			var_01 = "chaos_specialty_armorvest";
		}
		else
		{
			var_01 = level.armory["airsupport"][var_00].icon;
		}

		self.perk_icon_hud_6.icon setshader(var_01,self.perk_icon_hud_6.var_3FCC,self.perk_icon_hud_6.var_3FCC);
		self.perk_icon_hud_6.icon.alpha = 0.85;
	}
}

//Function Number: 122
perk_hud_7()
{
	self endon("death");
	self.perk_icon_hud_7 = spawnstruct();
	self.perk_icon_hud_7.var_3FCA = -318 + level.perk_offset;
	if(issplitscreen())
	{
		self.perk_icon_hud_7.var_3FCB = 112 + self == level.player * 27;
	}
	else
	{
		self.perk_icon_hud_7.var_3FCB = 196;
	}

	self.perk_icon_hud_7.var_3FCC = 28;
	self.perk_icon_hud_7.icon = chaos_special_item_hudelem(self.perk_icon_hud_7.var_3FCA,self.perk_icon_hud_7.var_3FCB);
	self.perk_icon_hud_7.icon.color = (1,1,1);
	self.perk_icon_hud_7.icon.alpha = 0;
	self.perk_icon_hud_7.icon thread chaos_perk_icon_destroy_on_mode_end();
	for(;;)
	{
		self waittill("give_perk_7",var_00);
		if(var_00 == "specialty_juiced")
		{
			var_01 = "chaos_specialty_juiced";
		}
		else if(var_00 == "specialty_armorvest")
		{
			var_01 = "chaos_specialty_armorvest";
		}
		else
		{
			var_01 = level.armory["airsupport"][var_00].icon;
		}

		self.perk_icon_hud_7.icon setshader(var_01,self.perk_icon_hud_7.var_3FCC,self.perk_icon_hud_7.var_3FCC);
		self.perk_icon_hud_7.icon.alpha = 0.85;
	}
}

//Function Number: 123
chaos_perk_icon_destroy_on_mode_end()
{
	level waittill("special_op_terminated");
	self destroy();
}

//Function Number: 124
chaos_special_item_hudelem(param_00,param_01)
{
	var_02 = newclienthudelem(self);
	var_02.hidden = 0;
	var_02.elemtype = "icon";
	var_02.hidewheninmenu = 1;
	var_02.archived = 0;
	var_02.x = param_00;
	var_02.y = param_01;
	var_02.alignx = "center";
	var_02.aligny = "middle";
	var_02.horzalign = "center";
	var_02.vertalign = "middle";
	return var_02;
}

//Function Number: 125
createchaosscorepopup()
{
	var_00 = newclienthudelem(self);
	var_00.children = [];
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.alignx = "center";
	var_00.aligny = "middle";
	if(issplitscreen())
	{
		var_00.x = 60;
		var_00.y = 30;
	}
	else
	{
		var_00.x = 50;
		var_00.y = 0;
	}

	var_00.font = "hudbig";
	var_00.fontscale = 0.8;
	var_00.archived = 0;
	var_00.color = (1,1,0.8);
	var_00.sort = 10000;
	var_00.elemtype = "msgText";
	var_00 chaosfontpulseinit(3);
	return var_00;
}

//Function Number: 126
chaosscorepopup(param_00,param_01,param_02)
{
	thread chaosscorepopupfinalize(param_00,param_01,param_02);
	thread chaosscorepopupterminate();
}

//Function Number: 127
chaosscorepopupfinalize(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self notify("chaosScorePopup");
	self endon("chaosScorePopup");
	wait 0.05;
	if(!isdefined(param_01))
	{
		param_01 = (1,1,0.5);
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(self))
	{
		return;
	}

	self.hud_chaosscorepopup.color = param_01;
	self.hud_chaosscorepopup.glowcolor = param_01;
	self.hud_chaosscorepopup.glowalpha = param_02;
	self.hud_chaosscorepopup settext(param_00);
	self.hud_chaosscorepopup.alpha = 0.85;
	wait 1;
	if(!isdefined(self))
	{
		return;
	}

	self.hud_chaosscorepopup fadeovertime(0.75);
	self.hud_chaosscorepopup.alpha = 0;
	self notify("ScorePopComplete");
}

//Function Number: 128
chaosscorepopupterminate()
{
	self endon("ScorePopComplete");
	common_scripts\utility::waittill_any("joined_team","joined_spectators");
	self.hud_chaosscorepopup fadeovertime(0.05);
	self.hud_chaosscorepopup.alpha = 0;
}

//Function Number: 129
createchaoseventpopup()
{
	var_00 = newclienthudelem(self);
	var_00.children = [];
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.x = 55;
	if(issplitscreen())
	{
		var_00.y = -35;
	}
	else
	{
		var_00.y = -35;
	}

	var_00.font = "hudbig";
	var_00.fontscale = 0.65;
	var_00.archived = 0;
	var_00.color = (1,1,0.8);
	var_00.sort = 10000;
	var_00.elemtype = "msgText";
	var_00 chaosfontpulseinit(3);
	return var_00;
}

//Function Number: 130
chaosfontpulseinit(param_00)
{
	self.basefontscale = self.fontscale;
	if(isdefined(param_00))
	{
		self.maxfontscale = min(param_00,6.3);
	}
	else
	{
		self.maxfontscale = min(self.fontscale * 2,6.3);
	}

	self.inframes = 2;
	self.outframes = 4;
}

//Function Number: 131
chaoseventpopup(param_00,param_01,param_02,param_03)
{
	thread chaoseventpopupfinalize(param_00,param_01,param_02,param_03);
	thread chaoseventpopupterminate();
}

//Function Number: 132
chaoseventpopupfinalize(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self notify("chaosEventPopup");
	self endon("chaosEventPopup");
	wait 0.05;
	if(!isdefined(param_01))
	{
		param_01 = (1,1,0.5);
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(self))
	{
		return;
	}

	self.hud_chaoseventpopup.color = param_01;
	self.hud_chaoseventpopup.glowcolor = param_01;
	self.hud_chaoseventpopup.glowalpha = param_02;
	self.hud_chaoseventpopup settext(param_00);
	self.hud_chaoseventpopup.alpha = 0.85;
	if(!isdefined(param_03))
	{
		param_03 = 0.05;
	}

	wait param_03;
	if(!isdefined(self))
	{
		return;
	}

	self.hud_chaoseventpopup fadeovertime(0.05);
	self.hud_chaoseventpopup.alpha = 0;
	self notify("PopComplete");
	if(isdefined(self.placingsentry))
	{
		self notify("sentry_notification",&"SENTRY_PLACE");
	}
}

//Function Number: 133
chaoseventpopupterminate()
{
	self endon("PopComplete");
	common_scripts\utility::waittill_any("joined_team","joined_spectators");
	self.hud_chaoseventpopup fadeovertime(0.05);
	self.hud_chaoseventpopup.alpha = 0;
}

//Function Number: 134
chaos_combo_splash(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.title = param_00;
	var_02.duration = 1.5;
	thread chaos_splash_radio(param_01);
	player_combo_splash(var_02);
}

//Function Number: 135
chaos_splash_radio(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = undefined;
	switch(param_00)
	{
		case "cm_bp_kills_explosion":
			var_01 = "chaos_action_explosion";
			break;

		case "cm_bp_kills_3longshot":
			var_01 = "chaos_action_3longshot";
			break;

		case "cm_bp_kills_3headshot":
			var_01 = "chaos_action_3headshot";
			break;

		case "cm_bp_kills_3knife":
			var_01 = "chaos_action_3knife";
			break;

		case "cm_bp_kills_triple":
			var_01 = "chaos_action_triple";
			break;

		case "cm_bp_kills_quad":
			var_01 = "chaos_action_quad";
			break;

		case "cm_bp_kills_multiple":
			var_01 = "chaos_action_multiple";
			break;

		default:
			break;
	}

	if(isdefined(var_01))
	{
		thread radio_dialogue_to_player(self,var_01,1);
	}
}

//Function Number: 136
player_combo_splash(param_00)
{
	if(isdefined(self.doingnotify) && self.doingnotify)
	{
		while(self.doingnotify)
		{
			wait 0.05;
		}
	}

	if(!isdefined(param_00.duration))
	{
		param_00.duration = 1.5;
	}

	param_00.title_glowcolor = (0,0,0);
	param_00.title_color = (0.95,0.95,0);
	param_00.type = "wave";
	param_00.title_font = "hudbig";
	param_00.playsoundlocally = 1;
	param_00.zoomin = 1;
	param_00.var_3E34 = 1;
	param_00.fadein = 1;
	param_00.fadeout = 1;
	if(issplitscreen())
	{
		param_00.title_basefontscale = 1;
		param_00.desc_basefontscale = 1.2;
		thread turn_lives_hud_back_after_splash(param_00.duration);
	}
	else
	{
		param_00.title_basefontscale = 1.1;
		param_00.desc_basefontscale = 1.2;
	}

	maps\_so_survival_code::splash_notify_message(param_00);
}

//Function Number: 137
turn_lives_hud_back_after_splash(param_00)
{
	level endon("special_op_terminated");
	self notify("stop_turn_lives_back_on_wait");
	self endon("stop_turn_lives_back_on_wait");
	if(isdefined(self.live_1_hud_icon.icon) && isdefined(self.live_2_hud_icon.icon) && isdefined(self.live_3_hud_icon.icon) && isdefined(self.live_4_hud_icon.icon) && isdefined(self.live_5_hud_icon.icon))
	{
		self.live_1_hud_icon.icon.alpha = 0;
		self.live_2_hud_icon.icon.alpha = 0;
		self.live_3_hud_icon.icon.alpha = 0;
		self.live_4_hud_icon.icon.alpha = 0;
		self.live_5_hud_icon.icon.alpha = 0;
	}

	wait param_00 + 0.5;
	update_lives_left_hud(self.laststand_info.type_getup_lives);
}

//Function Number: 138
chaos_killstreak_autosentry_main(param_00)
{
	lib_0616::givesentry("sentry_minigun");
	thread chaos_sentry_cancel_notify();
	self notifyonplayercommand("controller_sentry_cancel","+actionslot 4");
	self notifyonplayercommand("controller_sentry_cancel","weapnext");
	chaos_waittill_any("sentry_placement_finished","sentry_placement_canceled");
	chaos_post_killstreak_weapon_switchback();
	return 1;
}

//Function Number: 139
chaos_waittill_any(param_00,param_01)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	self waittill(param_00);
	chaos_score_event_raise("placed_sentry");
}

//Function Number: 140
chaos_sentry_cancel_notify()
{
	self endon("sentry_placement_canceled");
	self endon("sentry_placement_finished");
	self waittill("controller_sentry_cancel");
	if(!isdefined(self.carrying_pickedup_sentry) || !self.carrying_pickedup_sentry)
	{
		self notify("sentry_placement_canceled");
	}
}

//Function Number: 141
chaos_post_killstreak_weapon_switchback()
{
	if(maps\_utility::is_player_down(self))
	{
		return;
	}

	if(isdefined(self.ks.lastweaponused))
	{
		if(self.ks.lastweaponused == "none")
		{
			var_00 = self getweaponslistprimaries();
			self switchtoweapon(var_00[0]);
			return;
		}

		self switchtoweapon(self.ks.lastweaponused);
	}
}

//Function Number: 142
sp_airdrop_drop_the_crate(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = [];
	self.owner endon("disconnect");
	var_06 = sp_create_airdrop_crate(self.owner,param_00,param_05);
	var_06 linkto(self,"tag_ground",(32,0,5),(0,0,0));
	var_06.angles = (0,0,0);
	var_06 show();
	var_07 = self.veh_speed;
	self waittill("drop_crate");
	var_06 unlink();
	var_06 physicslaunchserver((0,0,0),(randomint(5),randomint(5),randomint(5)));
	var_06 thread sp_airdrop_crate_physics_waiter();
	var_06 thread sp_airdrop_crate_damage_enemies_on_fall(param_01,64);
}

//Function Number: 143
sp_create_airdrop_crate(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_02);
	var_03.inuse = 0;
	var_03.curprogress = 0;
	var_03.usetime = 0;
	var_03.userate = 0;
	if(isdefined(param_00))
	{
		var_03.owner = param_00;
	}
	else
	{
		var_03.owner = undefined;
	}

	var_03.cratetype = param_01;
	var_03.targetname = "care_package";
	var_03 setmodel("com_plasticcase_taskforce141");
	var_03 sp_airdrop_crate_attach_collision();
	var_03.collision thread sp_airdrop_crate_unlink_collision(var_03);
	var_03.basemodel = spawn("script_model",param_02);
	var_03.basemodel setmodel("com_plasticcase_friendly");
	var_03.basemodel common_scripts\utility::delaycall(0.25,::linkto,var_03,"tag_origin",(0,0,0),(0,0,0));
	var_03 thread sp_airdrop_crate_delete_on_owner_death(param_00);
	level.numairdropcrates++;
	return var_03;
}

//Function Number: 144
sp_delete_airdrop_crate()
{
	if(isdefined(level.crates_on_ground) && level.crates_on_ground.size)
	{
		level.crates_on_ground = common_scripts\utility::array_remove(level.crates_on_ground,self);
		level.numairdropcrates--;
	}

	if(isdefined(self))
	{
		if(isdefined(self.care_package_trigger))
		{
			self.care_package_trigger delete();
		}

		self.basemodel delete();
		self delete();
	}
}

//Function Number: 145
sp_airdrop_setup_crate_collisions()
{
	var_00 = getentarray("airdrop_crate_collision","targetname");
	foreach(var_02 in var_00)
	{
		var_02 connectpaths();
		var_02 notsolid();
	}

	level.airdropcratecollisionboxes = var_00;
}

//Function Number: 146
sp_airdrop_get_free_sbmodel_collision()
{
	var_00 = undefined;
	foreach(var_02 in level.airdropcratecollisionboxes)
	{
		if(!isdefined(var_02.isinuse))
		{
			var_00 = var_02;
			break;
		}
	}

	return var_00;
}

//Function Number: 147
sp_airdrop_crate_attach_collision()
{
	var_00 = sp_airdrop_get_free_sbmodel_collision();
	var_00.origin = self.origin;
	var_00.angles = self.angles;
	var_00 solid();
	var_00 linkto(self);
	var_00.isinuse = 1;
	self.collision = var_00;
}

//Function Number: 148
sp_airdrop_crate_damage_enemies_on_fall(param_00,param_01)
{
	while(isdefined(self) && distancesquared(self.origin,param_00) > 1024)
	{
		wait 0.05;
	}

	if(!isdefined(self))
	{
		return;
	}

	var_02 = getaispeciesarray("axis","all");
	foreach(var_04 in var_02)
	{
		if(distancesquared(self.origin,var_04.origin) < param_01 * param_01)
		{
			if(isdefined(self.owner))
			{
				var_04 dodamage(300,self.origin,self.owner,self);
				continue;
			}

			var_04 dodamage(300,self.origin);
		}
	}
}

//Function Number: 149
sp_airdrop_crate_delete_on_owner_death(param_00)
{
	param_00 waittill("death");
	sp_delete_airdrop_crate();
}

//Function Number: 150
sp_airdrop_crate_delete_when_owner_pickups_one_crate()
{
	self endon("death");
	level waittill("delete_all_crates");
	sp_delete_airdrop_crate();
}

//Function Number: 151
sp_airdrop_crate_unlink_collision(param_00)
{
	param_00 waittill("death");
	self unlink();
	self connectpaths();
	self notsolid();
	self.isinuse = undefined;
}

//Function Number: 152
sp_airdrop_crate_physics_waiter()
{
	self waittill("physics_finished");
	self.crate_num = gettime();
	if(!isdefined(level.crates_on_ground))
	{
		level.crates_on_ground = [];
	}

	level.crates_on_ground[level.crates_on_ground.size] = self;
	if(level.crates_on_ground.size > 4)
	{
		level.crates_on_ground[0] sp_delete_airdrop_crate();
		level.crates_on_ground[1] sp_delete_airdrop_crate();
	}

	thread sp_airdrop_crate_think();
	level thread sp_airdrop_crate_timeout(self,self.owner);
}

//Function Number: 153
sp_airdrop_crate_timeout(param_00,param_01)
{
	param_00 endon("death");
	var_02 = 120;
	if(isdefined(level.airdropcratetimeout))
	{
		var_02 = level.airdropcratetimeout;
	}

	if(var_02 <= 0)
	{
		return;
	}

	wait var_02;
	while(param_00.curprogress != 0)
	{
		wait 1;
	}

	param_00 sp_delete_airdrop_crate();
}

//Function Number: 154
sp_airdrop_crate_think()
{
	self endon("death");
	sp_airdrop_crate_setup_for_use();
	var_00 = spawn("trigger_radius",self.origin,0,50,50);
	var_00 enablelinkto();
	var_00 linkto(self);
	var_00.radius = self;
	var_00.owner = self;
	self.care_package_trigger = var_00;
	var_00 thread cratetriggerthink(self.killstreakinfo.cratehudstring);
	thread sp_airdrop_teammate_capture_think();
	if(isdefined(level.sp_airdrop_crate_custom_thread))
	{
		self thread [[ level.sp_airdrop_crate_custom_thread ]]();
	}

	for(;;)
	{
		self waittill("captured",var_01);
		if(isdefined(self.owner) && var_01 != self.owner)
		{
			thread sp_airdrop_crate_hijack_notify(var_01);
		}

		if(isplayer(var_01))
		{
			var_02 = var_01;
			var_02 playlocalsound("cm_use_carepackage");
			if(isdefined(self.killstreakinfo.crateopenfunc))
			{
				if(issubstr(self.killstreakinfo.streaktype,"specialty_"))
				{
					var_02 thread chaos_give_perk(self.killstreakinfo.streaktype);
				}
				else
				{
					var_02 thread [[ self.killstreakinfo.crateopenfunc ]]();
				}
			}
			else
			{
				var_02 thread maps\_sp_killstreaks::give_sp_killstreak(self.cratetype);
			}
		}

		sp_delete_airdrop_crate();
	}
}

//Function Number: 155
cratetriggerthink(param_00)
{
	level endon("special_op_terminated");
	self.owner endon("death");
	var_01 = &"SO_SURVIVAL_CHAOS_BONUS_SENTRY";
	var_02 = &"SO_SURVIVAL_CHAOS_BONUS_FREEZE_METER";
	for(;;)
	{
		self waittill("trigger",var_03);
		var_03 chaoseventpopup(param_00,(1,1,1));
		if(!isplayer(var_03) || var_03 maps\_sp_killstreaks::isusingremote() || !var_03 usebuttonpressed())
		{
			continue;
		}

		if(isdefined(var_03.justopencrate) && var_03.justopencrate == 1)
		{
			continue;
		}

		if(isplayer(var_03))
		{
			if(param_00 == var_01)
			{
				if(var_03 hasweapon("chaos_freeze_meter"))
				{
					var_03 takeweapon("chaos_freeze_meter");
					level notify("stop_wait_for_meter_freeze_activation");
				}
			}

			if(param_00 == var_02)
			{
				if(var_03 hasweapon("chaos_freeze_meter"))
				{
					level notify("stop_wait_for_meter_freeze_activation");
				}
			}

			self.owner notify("captured",var_03);
			chaos_score_event_raise("care_package");
			level notify("crate_captured");
			var_03.justopencrate = 1;
			var_03 thread resetjustopencrateflag();
			break;
		}
	}
}

//Function Number: 156
resetjustopencrateflag()
{
	level endon("special_op_terminated");
	wait 1;
	self.justopencrate = 0;
}

//Function Number: 157
sp_airdrop_crate_hijack_notify(param_00)
{
	self notify("hijacked",param_00);
	if(!isplayer(self.owner))
	{
		return;
	}

	if(param_00.team == self.owner.team)
	{
		if(isdefined(level.sp_airdrop_crate_friendly_hijack_thread))
		{
			self.owner thread [[ level.sp_airdrop_crate_friendly_hijack_thread ]](param_00);
			return;
		}

		return;
	}

	if(isdefined(level.sp_airdrop_crate_enemy_hijack_thread))
	{
		self.owner thread [[ level.sp_airdrop_crate_enemy_hijack_thread ]](param_00);
	}
}

//Function Number: 158
sp_airdrop_crate_setup_for_use()
{
	self.collision disconnectpaths();
	var_00 = maps\_sp_killstreaks::get_sp_killstreak_info(self.cratetype);
	self.killstreakinfo = var_00;
	sp_crate_world_icon(var_00.crateicon,(0,0,12),256,256);
	self setcursorhint("HINT_NOICON");
	self makeusable();
	if(isdefined(level.airdropcrateunstuck) && level.airdropcrateunstuck)
	{
		thread sp_airdrop_unstuck_think();
	}
}

//Function Number: 159
sp_airdrop_unstuck_think()
{
	self endon("death");
	self endon("captured");
	wait 2;
	var_00 = undefined;
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(isdefined(self.collision) && self.collision istouching(var_03))
		{
			if(isdefined(self.owner) && self.owner == var_03)
			{
				var_00 = var_03;
				continue;
			}

			var_01[var_01.size] = var_03;
		}
	}

	if(isdefined(var_00))
	{
		self notify("trigger",var_00);
		return;
	}

	if(var_01.size > 0)
	{
		self notify("trigger",var_01[0]);
	}
}

//Function Number: 160
sp_airdrop_get_crate_obj_id()
{
	var_00 = undefined;
	if(!isdefined(level.lastusedkillstreakcrateobjid))
	{
		var_00 = level.startingkillstreakcrateobjid;
	}
	else
	{
		var_00 = level.lastusedkillstreakcrateobjid + 1;
	}

	if(var_00 > level.startingkillstreakcrateobjid + 7)
	{
		var_00 = level.startingkillstreakcrateobjid;
	}

	level.lastusedkillstreakcrateobjid = var_00;
	return var_00;
}

//Function Number: 161
sp_crate_world_icon(param_00,param_01,param_02,param_03)
{
	self.crateworldicon = [];
	foreach(var_05 in level.players)
	{
		var_06 = var_05 chaos_special_item_hudelem(20,20);
		var_06.children = [];
		var_06 maps\_hud_util::setparent(level.uiparent);
		var_06.archived = 1;
		var_06.x = self.origin[0] + param_01[0];
		var_06.y = self.origin[1] + param_01[1];
		var_06.z = self.origin[2] + param_01[2];
		var_06.alpha = 1;
		var_06 setshader(param_00,param_02,param_03);
		var_06 setwaypoint(0,1,0);
		var_06 thread keeppositioned(self,param_01,param_00);
		self.crateworldicon[self.crateworldicon.size] = var_06;
	}

	thread destroyiconsondeath();
}

//Function Number: 162
sp_airdrop_teammate_capture_think()
{
	while(isdefined(self))
	{
		self waittill("trigger",var_00);
		if(isdefined(self.owner) && var_00 == self.owner)
		{
			continue;
		}

		if(!sp_use_hold_think(var_00))
		{
			continue;
		}

		self notify("captured",var_00);
		level notify("crate_captured");
	}
}

//Function Number: 163
sp_use_hold_think(param_00,param_01)
{
	param_00 freezecontrols(1);
	param_00 common_scripts\utility::_disableweapon();
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	if(isdefined(level.airdropcrateusetime))
	{
		self.usetime = level.airdropcrateusetime;
	}
	else if(isdefined(param_01))
	{
		self.usetime = param_01;
	}
	else
	{
		self.usetime = 3000;
	}

	if(self.usetime > 0)
	{
		param_00 thread sp_personal_use_bar(self);
		var_02 = sp_use_hold_think_loop(param_00);
	}
	else
	{
		var_02 = 1;
	}

	if(isalive(param_00))
	{
		param_00 common_scripts\utility::_enableweapon();
		param_00 freezecontrols(0);
	}

	if(!isdefined(self))
	{
		return 0;
	}

	self.inuse = 0;
	self.curprogress = 0;
	return var_02;
}

//Function Number: 164
sp_use_hold_think_loop(param_00)
{
	while(isdefined(self) && isalive(param_00) && param_00 usebuttonpressed() && self.curprogress < self.usetime)
	{
		self.curprogress = self.curprogress + 50 * self.userate;
		if(isdefined(self.objectivescaler))
		{
			self.userate = 1 * self.objectivescaler;
		}
		else
		{
			self.userate = 1;
		}

		if(self.curprogress >= self.usetime)
		{
			return isalive(param_00);
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 165
sp_personal_use_bar(param_00)
{
	self endon("disconnect");
	var_01 = createprimaryprogressbar(-25);
	var_02 = createprimaryprogressbartext(-25);
	var_02 settext(&"SP_KILLSTREAKS_CAPTURING_CRATE");
	var_03 = -1;
	while(isalive(self) && isdefined(param_00) && param_00.inuse)
	{
		if(var_03 != param_00.userate)
		{
			if(param_00.curprogress > param_00.usetime)
			{
				param_00.curprogress = param_00.usetime;
			}

			var_01 chaos_updatebar(param_00.curprogress / param_00.usetime,1000 / param_00.usetime * param_00.userate);
			if(!param_00.userate)
			{
				var_01 hideelem();
				var_02 hideelem();
			}
			else
			{
				var_01 showelem();
				var_02 showelem();
			}
		}

		var_03 = param_00.userate;
		wait 0.05;
	}

	var_01 chaos_destroyelem();
	var_02 chaos_destroyelem();
}

//Function Number: 166
wait_and_display_lives_left_hud()
{
	level endon("special_op_terminated");
	if(issplitscreen())
	{
		wait 2.5;
	}

	update_lives_left_hud(self.laststand_info.type_getup_lives);
}

//Function Number: 167
player_have_max_lives()
{
	var_00 = 0;
	var_01 = 0;
	foreach(var_03 in level.crates_on_ground)
	{
		if(var_03.cratetype == "bonus_laststand")
		{
			var_01 = var_01 + 1;
		}
	}

	foreach(var_06 in level.players)
	{
		if(var_06.laststand_info.type_getup_lives + var_01 == 5)
		{
			var_00 = 1;
		}
	}

	return var_00;
}

//Function Number: 168
generatesmokefx(param_00)
{
	var_01 = spawnfx(level.grnd_fx["smoke"],param_00);
	triggerfx(var_01);
	wait 5;
	var_01 delete();
}

//Function Number: 169
drop_item_already_used(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.drop_item_used.size;var_02++)
	{
		if(level.drop_item_used[var_02] == param_00)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 170
chaos_give_weapon(param_00)
{
	if(!isdefined(param_00) || param_00 == "")
	{
		return 0;
	}

	self giveweapon(param_00);
	maps\_so_survival_armory::give_ammo_max(param_00);
	self switchtoweapon(param_00);
	return 1;
}

//Function Number: 171
chaos_give_grenade(param_00,param_01)
{
	if(!isdefined(param_00) || param_00 == "" || !isdefined(param_01) || param_01 == "")
	{
		return 0;
	}

	self giveweapon(param_00);
	if(param_01 == "max")
	{
		self setweaponammostock(param_00,weaponmaxammo(param_00));
	}
	else
	{
		self setweaponammostock(param_00,int(param_01));
	}

	if(param_00 == "flash_grenade")
	{
		self setoffhandsecondaryclass("flash");
	}

	return 1;
}

//Function Number: 172
chaos_give_armor(param_00)
{
	if(!isdefined(param_00) || param_00 == "")
	{
		return 0;
	}

	maps\_so_survival_armory::give_armor_amount("armor",int(param_00));
	return 1;
}

//Function Number: 173
chaos_player_infinite_laststand()
{
	for(;;)
	{
		self waittill("revived");
		maps\_laststand::update_lives_remaining(1);
	}
}

//Function Number: 174
chaos_player_infinite_ammo_pistol()
{
	self endon("death");
	for(;;)
	{
		common_scripts\utility::waittill_either("reload","weapon_change");
		if(isdefined(level.coop_incap_weapon) && self hasweapon(level.coop_incap_weapon))
		{
			self setweaponammostock(level.coop_incap_weapon,weaponmaxammo(level.coop_incap_weapon));
		}
	}
}

//Function Number: 175
chaos_music_intro()
{
	wait 2;
	maps\_utility::musicplaywrapper("music_intro_cm");
}

//Function Number: 176
startcombodecayontimer()
{
	level endon("special_op_terminated");
	level common_scripts\utility::waittill_notify_or_timeout("Start timer",10);
	wait 20;
	if(level.start_combo_decay == 0)
	{
		level.start_combo_decay = 1;
		thread chaos_combo_on_end(4,0.2);
	}
}

//Function Number: 177
chaos_hud_survival_remove()
{
	thread chaos_wave_hud_hide();
	wait 0.05;
	waittillframeend;
	common_scripts\utility::array_thread(level.players,::maps\_specialops::surhud_disable,"credits");
	common_scripts\utility::array_thread(level.players,::maps\_specialops::surhud_disable,"challenge");
	level.xp_enable = 0;
}

//Function Number: 178
chaos_wave_hud_hide()
{
	self endon("death");
	level waittill("wave_started",var_00);
	waittillframeend;
	common_scripts\utility::array_thread(level.players,::maps\_specialops::surhud_disable,"wave");
	common_scripts\utility::array_thread(level.players,::maps\_specialops::_setplayerdata_single,"surHUD_wave",0);
}

//Function Number: 179
wait_for_revive_teammate()
{
	level endon("special_op_terminated");
	for(;;)
	{
		self waittill("so_revive_success");
		chaos_score_event_raise("revive_teammate");
	}
}

//Function Number: 180
wait_for_death()
{
	level endon("special_op_terminated");
	self waittill("death");
	chaos_running_score_update(level.chaos_combo_points,level.chaos_combo_count);
}

//Function Number: 181
get_random_drop_item(param_00,param_01)
{
	if(param_01 == 1)
	{
		return level.chaos_drop_items[param_00][0];
	}

	for(;;)
	{
		var_02 = randomint(level.chaos_drop_items[param_00].size);
		var_03 = level.chaos_drop_items[param_00][var_02];
		if(drop_item_already_used(var_03))
		{
			continue;
		}
		else
		{
			level.drop_item_used[level.drop_item_used.size] = var_03;
			return var_03;
		}
	}
}

//Function Number: 182
chaos_dog_tags_spawn(param_00,param_01)
{
	var_02 = spawn("script_model",param_00 + (0,0,24));
	if(param_01 == 1)
	{
		var_02 setmodel("prop_dogtags_friend");
	}
	else
	{
		var_02 setmodel("prop_dogtags_foe");
	}

	var_02 endon("death");
	var_03 = spawn("trigger_radius",param_00,0,32,32);
	var_02 thread temp_chaos_dog_tags_rotate();
	var_02 thread chaos_dog_tags_flicker(10,5);
	var_02 thread chaos_dog_tags_cleanup(10,var_03);
	for(;;)
	{
		var_03 waittill("trigger",var_04);
		if(isdefined(var_04) && isplayer(var_04))
		{
			break;
		}
	}

	if(param_01 == 1)
	{
		chaos_score_event_raise("dogtag","cm_redtag_pickup");
		var_05 = 200;
		var_06 = var_04.armor["points"];
		var_04 maps\_so_survival_armory::give_armor_amount("armor",var_05 + var_06);
		var_04 thread radio_dialogue_to_player(var_04,"chaos_pickup_armor");
	}
	else
	{
		chaos_score_event_raise("dogtag");
	}

	var_03 delete();
	var_02 delete();
}

//Function Number: 183
temp_chaos_dog_tags_rotate()
{
	self endon("death");
	for(;;)
	{
		self rotateyaw(359,1,0,0);
		wait 1;
	}
}

//Function Number: 184
chaos_dog_tags_cleanup(param_00,param_01)
{
	self endon("death");
	wait param_00;
	param_01 delete();
	self delete();
}

//Function Number: 185
chaos_dog_tags_flicker(param_00,param_01)
{
	self endon("death");
	var_02 = param_00 * 1000;
	var_03 = gettime() + var_02;
	var_04 = min(param_01,param_00);
	if(var_04 > 0)
	{
		wait var_04;
		param_00 = param_00 - var_04;
	}

	var_05 = 1;
	for(;;)
	{
		if(var_05)
		{
			self hide();
			wait 0.1;
		}
		else
		{
			self show();
			wait 0.25;
		}

		var_05 = !var_05;
	}
}

//Function Number: 186
chaos_ai_setup()
{
	maps\_utility::add_global_spawn_function("axis",::chaos_on_ai_spawn);
}

//Function Number: 187
chaos_on_ai_spawn()
{
	self.dropweapon = 0;
	thread chaos_on_ai_death();
}

//Function Number: 188
chaos_on_ai_death()
{
	self waittill("death");
	if(!isdefined(self) || !isdefined(self.origin))
	{
		return;
	}

	var_00 = chaos_get_ai_type_ref();
	if(var_00 != "chopper")
	{
		if(issubstr(var_00,"jug"))
		{
			thread chaos_dog_tags_spawn(self.origin,1);
			return;
		}

		thread chaos_dog_tags_spawn(self.origin,0);
	}
}

//Function Number: 189
chaos_armories_disable()
{
	waittillframeend;
	var_00 = ["weapon","equipment","airsupport"];
	foreach(var_02 in var_00)
	{
		var_03 = "armory_" + var_02;
		var_04 = getent(var_03,"targetname");
		if(!isdefined(var_04))
		{
			continue;
		}

		var_04 makeunusable();
		var_04 maps\_utility::hide_entity();
		var_04.laptop_locked maps\_utility::hide_entity();
		var_04.laptop maps\_utility::hide_entity();
	}

	var_06 = getentarray("armory_script_brushmodel","targetname");
	foreach(var_08 in var_06)
	{
		var_08 notsolid();
	}
}

//Function Number: 190
chaos_score_globals_init()
{
	level.chaos_score = 0;
}

//Function Number: 191
chaos_score_update(param_00,param_01)
{
	level notify("score_update_bump");
	level endon("score_update_bump");
	level thread sound_wait_for_bank();
	var_02 = param_00 * param_01;
	var_03 = level.chaos_score;
	level.chaos_score = level.chaos_score + var_02;
	foreach(var_05 in level.players)
	{
		if(var_02 > var_05.game_performance["comboscoremax"])
		{
			var_05.game_performance["comboscoremax"] = var_02;
		}

		if(param_01 > var_05.game_performance["combomultmax"])
		{
			var_05.game_performance["combomultmax"] = param_01;
		}

		if(isdefined(var_05.chaos_score_hud))
		{
			var_05.chaos_score_hud settext(var_03);
			var_05 thread chaos_score_hud_player_update(param_01);
		}
	}
}

//Function Number: 192
sound_wait_for_bank()
{
	wait 0.3;
	common_scripts\utility::array_call(level.players,::playlocalsound,"chaos_bank");
}

//Function Number: 193
chaos_get_ai_type_ref()
{
	if(isdefined(self.ally_ref))
	{
		return self.ally_ref.ref;
	}

	if(isdefined(self.chaos_squad_type))
	{
		return self.chaos_squad_type;
	}

	return undefined;
}

//Function Number: 194
update_level_chaos_timer()
{
	level endon("special_op_terminated");
	level endon("update_chaos_timer");
	level endon("chaos_timer_reached_zero");
	level common_scripts\utility::waittill_notify_or_timeout("Start timer",10);
	for(;;)
	{
		wait 0.2;
		level.chaos_time_remaining = level.chaos_time_remaining - 0.2;
	}
}

//Function Number: 195
chaos_timer_update_vo(param_00,param_01)
{
	level endon("special_op_terminated");
	level endon("wave_ended");
	level endon("chaos_timer_reached_zero");
	level endon("update_chaos_timer");
	var_02 = param_00 - param_01;
	if(var_02 >= 0)
	{
		if(var_02 > 0)
		{
			wait var_02;
		}

		maps\_utility::musicplaywrapper("music_timeout_cm");
	}
}

//Function Number: 196
change_player_vision_set()
{
	level endon("special_op_terminated");
	self visionsetnakedforplayer("coup_sunblind",0.25);
	wait 0.2;
	self visionsetnakedforplayer("",1);
}

//Function Number: 197
sp_killstreak_bonus_score_crateopen()
{
	chaos_score_event_raise("bonus_score","cm_bp_cp_bonus");
}

//Function Number: 198
chaos_killstreaks_init_done()
{
	return isdefined(level.ks) && isdefined(level.ks.globalinitdone);
}

//Function Number: 199
chaos_killstreak_exists(param_00)
{
	foreach(var_03, var_02 in level.ks.killstreaktypes)
	{
		if(var_03 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 200
chaos_getpathstart(param_00,param_01)
{
	var_02 = 100;
	var_03 = 15000;
	var_04 = (0,param_01,0);
	var_05 = param_00 + anglestoforward(var_04) * -1 * var_03;
	var_05 = var_05 + (randomfloat(2) - 1 * var_02,randomfloat(2) - 1 * var_02,0);
	return var_05;
}

//Function Number: 201
chaos_getpathend(param_00,param_01)
{
	var_02 = 150;
	var_03 = 15000;
	var_04 = (0,param_01,0);
	var_05 = param_00 + anglestoforward(var_04 + (0,90,0)) * var_03;
	var_05 = var_05 + (randomfloat(2) - 1 * var_02,randomfloat(2) - 1 * var_02,0);
	return var_05;
}

//Function Number: 202
getperkname(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "specialty_fastreload":
			var_01 = "Sleight of Hand";
			break;

		case "specialty_quickdraw":
			var_01 = "Quick Draw";
			break;

		case "specialty_longersprint":
			var_01 = "Extreme Conditioning";
			break;

		case "specialty_stalker":
			var_01 = "Stalker";
			break;

		case "specialty_bulletaccuracy":
			var_01 = "Steady Aim";
			break;

		case "specialty_armorvest":
			var_01 = "Armor Vest";
			break;

		case "specialty_juiced":
			var_01 = "Juiced";
			break;

		default:
			break;
	}

	return var_01;
}

//Function Number: 203
chaos_perk_radio(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "specialty_stalker":
			var_01 = "chaos_perk_stalker";
			break;

		case "specialty_longersprint":
			var_01 = "chaos_perk_excond";
			break;

		case "specialty_fastreload":
			var_01 = "chaos_perk_sleight";
			break;

		case "specialty_quickdraw":
			var_01 = "chaos_perk_quickdraw";
			break;

		case "specialty_bulletaccuracy":
			var_01 = "chaos_perk_steadyaim";
			break;

		case "specialty_armorvest":
			var_01 = "chaos_perk_regeneration";
			break;

		case "specialty_juiced":
			var_01 = "chaos_perk_juiced";
			break;

		default:
			break;
	}

	if(isdefined(var_01))
	{
		maps\_utility::radio_dialogue(var_01);
	}
}