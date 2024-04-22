/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_audio.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 97
 * Decompile Time: 1471 ms
 * Timestamp: 4/22/2024 2:14:25 AM
*******************************************************************/

//Function Number: 1
init()
{
	level zmbvox();
	level maps\mp\zombies\_zombies_audio_announcer::initannouncer();
	level thread maps\mp\zombies\_zombies_music::init();
	if(isdefined(level._zmbvoxlevelspecific))
	{
		level thread [[ level._zmbvoxlevelspecific ]]();
	}

	if(isdefined(level._zmbvoxgametypespecific))
	{
		level thread [[ level._zmbvoxgametypespecific ]]();
	}

	if(!isdefined(level.zmbsoundlengthpath))
	{
		level.zmbsoundlengthpath = "mp/sound/soundlength_zm_mp.csv";
	}

	level.zmbglobalpriorityvoonly = 0;
}

//Function Number: 2
zmbvox()
{
	level.vox = zmbvoxcreate();
	level.vox zmbvoxadd("player","general","intro","rnd_wave1",undefined);
	level.vox zmbvoxadd("player","general","wave1","wave1",undefined);
	level.vox zmbvoxadd("player","general","wave2","wave2",undefined,30);
	level.vox zmbvoxadd("player","general","wave_early","wave_early",undefined);
	level.vox zmbvoxadd("player","general","wave_start","wave_start",undefined,30);
	level.vox zmbvoxadd("player","general","wave_end","wave_end",undefined,30);
	level.vox zmbvoxadd("player","general","weapon_reminder","weapon_reminder",undefined);
	level.vox zmbvoxadd("player","general","dog_round","dog_round",undefined,50);
	level.vox zmbvoxadd("player","general","host_round","host_round",undefined,50);
	level.vox zmbvoxadd("player","general","crawl_spawn","turn_crawler","resp_crawler_start",10);
	level.vox zmbvoxadd("player","general","resp_crawler_start","crawler",undefined);
	level.vox zmbvoxadd("player","general","host_damaged","player_attk_host",undefined,10);
	level.vox zmbvoxadd("player","general","resp_crawler_start","crawler",undefined);
	level.vox zmbvoxadd("player","general","ammo_low","lowammo",undefined);
	level.vox zmbvoxadd("player","general","ammo_out","out_of_ammo",undefined);
	level.vox zmbvoxadd("player","general","exo_upgrade_no_suit","exo_upgrade_no_suit",undefined);
	level.vox zmbvoxadd("player","general","exo_upgrade_no_cash","exo_upgrade_no_cash",undefined);
	level.vox zmbvoxadd("player","general","exo_suit_no_cash","exo_suit_no_cash",undefined);
	level.vox zmbvoxadd("player","general","printer_moved","printer_moved",undefined);
	level.vox zmbvoxadd("player","general","found_printer","disc_prntr",undefined,30);
	level.vox zmbvoxadd("player","general","shoot_arm","dismemb",undefined,7);
	level.vox zmbvoxadd("player","general","oh_shit","zom_short_range","resp_surrounded",25);
	level.vox zmbvoxadd("player","general","resp_surrounded","surround",undefined);
	level.vox zmbvoxadd("player","general","power_on","power_on",undefined,75);
	level.vox zmbvoxadd("player","general","power_off","power_off",undefined,50);
	level.vox zmbvoxadd("player","general","wpn_no_cash","wpn_no_cash",undefined);
	level.vox zmbvoxadd("player","general","printer_no_cash","printer_no_cash",undefined);
	level.vox zmbvoxadd("player","general","reloading","wpn_reload",undefined,30);
	level.vox zmbvoxadd("player","general","thanks","thanks",undefined);
	level.vox zmbvoxadd("player","general","revive_down","laststand",undefined);
	level.vox zmbvoxadd("player","general","revive_up","revived","resp_revive");
	level.vox zmbvoxadd("player","general","resp_revive","revive",undefined,30);
	level.vox zmbvoxadd("player","general","crawl_hit","attk_crawler",undefined);
	level.vox zmbvoxadd("player","general","host_hit","host_attk_player",undefined,20);
	level.vox zmbvoxadd("player","general","infected","host_infect_player",undefined);
	level.vox zmbvoxadd("player","general","emp","emz_offline",undefined,25);
	level.vox zmbvoxadd("player","general","cured","player_clean_station",undefined,30);
	level.vox zmbvoxadd("player","general","dog_hit","dog_attk_player","resp_dog_hit",25);
	level.vox zmbvoxadd("player","general","resp_dog_hit","dog",undefined);
	level.vox zmbvoxadd("player","general","laser_traps","laser_traps",undefined);
	level.vox zmbvoxadd("player","general","bonus_line_over","bonus_line1",undefined,5);
	level.vox zmbvoxadd("player","general","bonus_line_not_over","bonus_line2",undefined,5);
	level.vox zmbvoxadd("player","general","round_5","rd05",undefined);
	level.vox zmbvoxadd("player","general","round_10","rd10",undefined);
	level.vox zmbvoxadd("player","general","round_20","rd20",undefined);
	level.vox zmbvoxadd("player","general","round_35","rd35",undefined);
	level.vox zmbvoxadd("player","general","round_50","rd50",undefined);
	level.vox zmbvoxadd("player","general","orbital_drop_pre","orbital_drop_pre",undefined);
	level.vox zmbvoxadd("player","general","orbital_drop_react","orbital_drop_react",undefined);
	level.vox zmbvoxadd("player","general","orbital_drop_1st_get","orbital_drop_1st_get",undefined);
	level.vox zmbvoxadd("player","general","ss_crate_capture","ss_grab_ocp",undefined);
	level.vox zmbvoxadd("player","general","ss_money","ss_bonus_ocp",undefined);
	level.vox zmbvoxadd("player","general","ss_shield","ss_invinc",undefined);
	level.vox zmbvoxadd("player","general","ss_use_assault_drone","ss_assault_drone",undefined);
	level.vox zmbvoxadd("player","general","ss_use_turret","ss_turret",undefined);
	level.vox zmbvoxadd("player","general","ss_zom_destroy_turret","ss_zom_destroy_turret",undefined);
	level.vox zmbvoxadd("player","perk","exo_suit","exo_suit",undefined);
	level.vox zmbvoxadd("player","perk","exo_health","exo_health",undefined);
	level.vox zmbvoxadd("player","perk","exo_slam","exo_slam",undefined);
	level.vox zmbvoxadd("player","perk","exo_revive","exo_stim",undefined);
	level.vox zmbvoxadd("player","perk","exo_stabilizer","exo_stabilizer",undefined);
	level.vox zmbvoxadd("player","perk","specialty_fastreload","exo_speed",undefined);
	level.vox zmbvoxadd("player","perk","exo_upgrade_no_suit","exo_upgrade_no_suit",undefined);
	level.vox zmbvoxadd("player","perk","exo_upgrade_no_cash","exo_upgrade_no_cash",undefined);
	level.vox zmbvoxadd("player","perk","exo_suit_no_cash","exo_suit_no_cash",undefined);
	level.vox zmbvoxadd("player","perk","weapon_upgrade","wpn_upgrade",undefined,40);
	level.vox zmbvoxadd("player","perk","weapon_upgrade_max","wpn_maxupgrd",undefined);
	level.vox zmbvoxadd("player","powerup","apocalypse","apocalypse",undefined);
	level.vox zmbvoxadd("player","powerup","insta_kill","instakill_pckup",undefined);
	level.vox zmbvoxadd("player","powerup","max_ammo","max_ammo",undefined);
	level.vox zmbvoxadd("player","powerup","2x_pts","2x_pts",undefined);
	level.vox zmbvoxadd("player","powerup","pow_surge","pow_surge",undefined);
	level.vox zmbvoxadd("player","powerup","traps","traps_pckup",undefined);
	level.vox zmbvoxadd("player","kill","melee","kill_w_melee",undefined,5);
	level.vox zmbvoxadd("player","kill","melee_instakill","melee_instakill",undefined,20);
	level.vox zmbvoxadd("player","kill","closekill","closekill",undefined,15);
	level.vox zmbvoxadd("player","kill","damage","close_dmg",undefined,15);
	level.vox zmbvoxadd("player","kill","streak","killstreak",undefined);
	level.vox zmbvoxadd("player","kill","headshot","headshot_dist","resp_kill_headshot",15);
	level.vox zmbvoxadd("player","kill","resp_kill_headshot","headshot",undefined);
	level.vox zmbvoxadd("player","kill","explosive","exp_kills",undefined,15);
	level.vox zmbvoxadd("player","kill","fusion_rifle","spec_weapon",undefined,7);
	level.vox zmbvoxadd("player","kill","bullet","kill_w_bullets",undefined,1);
	level.vox zmbvoxadd("player","kill","distract_drone","distract_drone_kill",undefined,15);
	level.vox zmbvoxadd("player","kill","nano_swarm","dna_bomb_kill",undefined,15);
	level.vox zmbvoxadd("player","kill","crawler","kill_crawler",undefined,15);
	level.vox zmbvoxadd("player","kill","host","player_kill_host",undefined,20);
	level.vox zmbvoxadd("player","kill","dog","kill_dog",undefined,20);
	level.vox zmbvoxadd("player","weapon_pickup","explosive_drone_zombie_mp","explosive_drone",undefined);
	level.vox zmbvoxadd("player","weapon_pickup","explosive_drone_throw_zombie_mp","explosive_drone",undefined);
	level.vox zmbvoxadd("player","weapon_pickup","contact_grenade_zombies_mp","contact_grenade",undefined);
	level.vox zmbvoxadd("player","weapon_pickup","contact_grenade_throw_zombies_mp","contact_grenade",undefined);
	level.vox zmbvoxadd("player","weapon_pickup","iw5_fusionzm_mp","laser_shotgun","resp_weapon_fav");
	level.vox zmbvoxadd("player","weapon_pickup","distraction_drone_zombie_mp","distract_drone",undefined);
	level.vox zmbvoxadd("player","weapon_pickup","distraction_drone_throw_zombie_mp","distract_drone",undefined);
	level.vox zmbvoxadd("player","weapon_pickup","dna_aoe_grenade_zombie_mp","dna_bomb",undefined);
	level.vox zmbvoxadd("player","weapon_pickup","dna_aoe_grenade_throw_zombie_mp","dna_bomb",undefined);
	level.vox zmbvoxadd("player","weapon_pickup","favorite","fav_wallweapon",undefined);
	level.vox zmbvoxadd("player","weapon_pickup","resp_weapon_fav","special_wpn",undefined);
	level.vox zmbvoxadd("player","weapon_pickup","bad_weapon","wpnpickup_bad",undefined,30);
	level.vox zmbvoxadd("player","weapon_pickup","generic","wpnpickup_gen",undefined,40);
	level.vox zmbvoxadd("player","exert","pain0","pain_grunt_low",undefined);
	level.vox zmbvoxadd("player","exert","pain1","pain_grunt_med",undefined);
	level.vox zmbvoxadd("player","exert","pain2","pain_grunt_high",undefined);
	level.vox zmbvoxadd("player","exert","death0","death_grunt_low",undefined);
	level.vox zmbvoxadd("player","exert","death1","death_grunt_med",undefined);
	level.vox zmbvoxadd("player","exert","death2","death_grunt_high",undefined);
	level.vox zmbvoxadd("player","exert","grunt","exertion_grunt",undefined);
	level.vox zmbvoxadd("player","exert","punch","punch",undefined,30);
	level.vox zmbvoxadd("player","exert","cough","cough",undefined,70);
	level.vox zmbvoxadd("player","exert","laugh","laugh",undefined,70);
	level.vox zmbvoxadd("player","exert","scream","scream",undefined);
	level.vox zmbvoxadd("player","exert","sigh","sigh",undefined);
	level.vox zmbvoxadd("player","movement","first_jump","exo_first_jump",undefined);
	level.vox zmbvoxadd("player","movement","hit_head","exo_headbump",undefined);
	level.vox zmbvoxadd("player","monologue","slide_chute","slide_chute",undefined,30);
	level.vox zmbvoxadd("player","an_conv","an_conv_1b","an_conv_1b","an_conv,an_conv_1c");
	level.vox zmbvoxadd("player","an_conv","an_conv_1d","an_conv_1d",undefined);
	level.vox zmbvoxadd("player","an_conv","an_conv_2","an_conv_2a","an_conv,an_conv_2b");
	level.vox zmbvoxadd("player","an_conv","an_conv_3","an_conv_3a","an_conv,an_conv_3b");
	level.vox zmbvoxadd("player","an_conv","an_conv_4","an_conv_4a","an_conv,an_conv_4b");
	level.vox zmbvoxadd("player","an_conv","an_conv_4c","an_conv_4c","an_conv,an_conv_4d");
	level.vox zmbvoxadd("player","an_conv","an_conv_5","an_conv_5a","an_conv,an_conv_5b");
	level.vox zmbvoxadd("player","an_conv","an_conv_5c","an_conv_5c","an_conv,an_conv_5d");
	level.vox zmbvoxadd("player","an_conv","an_conv_6b","an_conv_6b","an_conv,an_conv_6c");
	level.vox zmbvoxadd("player","an_conv","an_conv_6d","an_conv_6d",undefined);
	level.vox zmbvoxadd("player","an_conv","an_conv_7","an_conv_7a","an_conv,an_conv_7b");
	level.vox zmbvoxadd("player","an_conv","an_conv_7c","an_conv_7c","an_conv,an_conv_7d");
	level.vox zmbvoxadd("player","an_conv","an_conv_9b","an_conv_9b","an_conv,an_conv_9c");
	level.vox zmbvoxadd("player","an_conv","an_conv_11b","an_conv_11b",undefined);
	level.zmb_vox = [];
	level.zmb_vox["prefix"] = "zmb_";
	level.zmb_vox["zombie_generic"] = [];
	level.zmb_vox["zombie_generic"]["idle_low"] = "gen_idle_low";
	level.zmb_vox["zombie_generic"]["idle_high"] = "gen_idle_high";
	level.zmb_vox["zombie_generic"]["move"] = "gen_scream";
	level.zmb_vox["zombie_generic"]["attack"] = "gen_scream";
	level.zmb_vox["zombie_generic"]["spawn"] = "gen_spawn";
	level.zmb_vox["zombie_generic"]["taunt"] = "gen_scream";
	level.zmb_vox["zombie_generic"]["behind"] = "gen_behind";
	level.zmb_vox["zombie_generic"]["pain"] = "gen_pain";
	level.zmb_vox["zombie_dog"] = [];
	level.zmb_vox["zombie_dog"]["idle"] = "dog_idle";
	level.zmb_vox["zombie_dog"]["attack"] = "dog_bite";
	level.zmb_vox["zombie_dog"]["spawn"] = "dog_spawn";
	level.zmb_vox["zombie_dog"]["behind"] = "dog_behind";
	level.zmb_vox["zombie_dog"]["pain"] = "dog_pain";
	level.zmb_vox["zombie_host"] = [];
	level.zmb_vox["zombie_host"]["idle_low"] = "hst_scream";
	level.zmb_vox["zombie_host"]["idle_high"] = "hst_scream";
	level.zmb_vox["zombie_host"]["move"] = "hst_scream";
	level.zmb_vox["zombie_host"]["attack"] = "hst_attack_scream";
	level.zmb_vox["zombie_host"]["spawn"] = "hst_scream";
	level.zmb_vox["zombie_host"]["taunt"] = "hst_scream";
	level.zmb_vox["zombie_host"]["behind"] = "hst_behind";
	level.zmb_vox["zombie_host"]["pain"] = "hst_scream";
	if(maps\mp\zombies\_util::getzombieslevelnum() > 2)
	{
		level.zmb_vox["zombie_melee_goliath"] = [];
		level.zmb_vox["zombie_melee_goliath"]["idle_low"] = "gol_idle";
		level.zmb_vox["zombie_melee_goliath"]["idle_high"] = "gol_scream";
		level.zmb_vox["zombie_melee_goliath"]["move"] = "gol_scream";
		level.zmb_vox["zombie_melee_goliath"]["attack"] = "gol_scream";
		level.zmb_vox["zombie_melee_goliath"]["spawn"] = "gol_scream";
		level.zmb_vox["zombie_melee_goliath"]["taunt"] = "gol_scream";
		level.zmb_vox["zombie_melee_goliath"]["behind"] = "gol_scream";
		level.zmb_vox["zombie_melee_goliath"]["pain"] = "gol_pain";
		level.zmb_vox["zombie_ranged_goliath"] = [];
		level.zmb_vox["zombie_ranged_goliath"]["idle_low"] = "gol_idle";
		level.zmb_vox["zombie_ranged_goliath"]["idle_high"] = "gol_scream";
		level.zmb_vox["zombie_ranged_goliath"]["move"] = "gol_scream";
		level.zmb_vox["zombie_ranged_goliath"]["attack"] = "gol_scream";
		level.zmb_vox["zombie_ranged_goliath"]["spawn"] = "gol_scream";
		level.zmb_vox["zombie_ranged_goliath"]["taunt"] = "gol_scream";
		level.zmb_vox["zombie_ranged_goliath"]["behind"] = "gol_scream";
		level.zmb_vox["zombie_ranged_goliath"]["pain"] = "gol_pain";
	}
}

//Function Number: 3
volength(param_00,param_01)
{
	var_02 = tablelookup(level.zmbsoundlengthpath,0,param_00,1);
	if(!isdefined(var_02) || var_02 == "")
	{
		if(isdefined(param_01) && param_01 == "exert")
		{
			return 0.5;
		}
		else if(isdefined(param_01) && param_01 == "conversation" || param_01 == "an_conv")
		{
			return 3;
		}
		else
		{
			return 2;
		}
	}

	var_02 = int(var_02);
	var_02 = var_02 * 0.001;
	return var_02;
}

//Function Number: 4
init_audio_functions()
{
	thread zombie_behind_vox();
	thread player_killstreak_init();
	thread oh_shit_vox();
	thread player_track_ammo_count();
	thread player_zone_tracking();
	thread player_movement_tracking();
	thread player_track_reload();
	thread player_track_punching();
}

//Function Number: 5
player_track_punching()
{
	for(;;)
	{
		self waittill("melee_fired");
		var_00 = playerexert("punch");
		if(var_00)
		{
			wait(5);
		}
	}
}

//Function Number: 6
player_track_reload()
{
	self endon("disconnect");
	for(;;)
	{
		if(self isreloading())
		{
			create_and_play_dialog("general","reloading");
			wait(30);
		}

		wait 0.05;
	}
}

//Function Number: 7
player_movement_tracking()
{
	self endon("disconnect");
	var_00 = 0;
	var_01 = 0;
	var_02 = 1;
	for(;;)
	{
		if(var_00 && var_01)
		{
			return;
		}

		if(!var_00 && maps\mp\zombies\_util::is_true(self.exosuitonline) && self ishighjumping())
		{
			wait(0.2);
			if(isalive(self) && !maps\mp\zombies\_util::isplayerinlaststand(self))
			{
				var_00 = create_and_play_dialog("movement","first_jump");
			}
		}
		else if(!var_01 && maps\mp\zombies\_util::is_true(self.exosuitonline) && self ishighjumping() && self getvelocity()[2] >= 0)
		{
			var_03 = self geteye();
			var_04 = var_03 + (0,0,30);
			var_05 = bullettrace(var_03,var_04,0,self);
			if(var_05["fraction"] < 1)
			{
				var_01 = create_and_play_dialog("movement","hit_head");
			}
		}

		wait 0.05;
	}
}

//Function Number: 8
player_zone_tracking()
{
	self endon("disconnect");
	self waittill("spawned_player");
	var_00 = undefined;
	while(!isdefined(level.zone_data))
	{
		wait(0.05);
	}

	if(isdefined(level.zmbaudiozonetrackingdelay))
	{
		wait(level.zmbaudiozonetrackingdelay);
	}

	for(;;)
	{
		var_01 = maps\mp\zombies\_zombies_zone_manager::getcurrentplayeroccupiedzonestructs();
		if(var_01.size > 0)
		{
			var_02 = var_01[0];
			if(!isdefined(var_00))
			{
				var_00 = var_02;
				wait(1);
				continue;
			}
			else if(var_00 != var_02)
			{
				if(isdefined(var_02.power_switch) && !common_scripts\utility::flag(var_02.power_switch.script_flag) && !isdefined(var_02.nextpoweroffvotime) || gettime() > var_02.nextpoweroffvotime)
				{
					var_00 = var_02;
					thread playerpoweroffvo();
					var_00.nextpoweroffvotime = gettime() + 30000;
					wait(15);
				}
			}
		}

		wait(1);
	}
}

//Function Number: 9
zombie_behind_vox()
{
	self endon("disconnect");
	if(!isdefined(level._zbv_vox_last_update_time))
	{
		level._zbv_vox_last_update_time = 0;
		level._audio_zbv_shared_ent_list = maps\mp\zombies\_util::get_round_enemy_array();
	}

	for(;;)
	{
		wait 0.05;
		var_00 = gettime();
		if(var_00 > level._zbv_vox_last_update_time + 1000)
		{
			level._zbv_vox_last_update_time = var_00;
			level._audio_zbv_shared_ent_list = maps\mp\zombies\_util::get_round_enemy_array();
		}

		var_01 = level._audio_zbv_shared_ent_list;
		var_02 = 0;
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			if(!isdefined(var_01[var_03]) || !isdefined(var_01[var_03].agent_type) || !isdefined(var_01[var_03].enemy) || var_01[var_03].enemy != self)
			{
				continue;
			}

			var_04 = 200;
			var_05 = 50;
			if(isdefined(var_01[var_03].zombie_move_speed))
			{
				switch(var_01[var_03].zombie_move_speed)
				{
					case "walk":
						var_04 = 200;
						break;
	
					case "run":
						var_04 = 250;
						break;
	
					case "sprint":
						var_04 = 275;
						break;
				}
			}

			if(distancesquared(var_01[var_03].origin,self.origin) < var_04 * var_04)
			{
				var_06 = getyawtospot(var_01[var_03].origin);
				var_07 = self.origin[2] - var_01[var_03].origin[2];
				if((var_06 < -95 || var_06 > 95) && abs(var_07) < 50)
				{
					var_01[var_03] thread do_zombies_playvocals("behind",var_01[var_03].agent_type,self);
					var_02 = 1;
					break;
				}
			}
		}

		if(var_02)
		{
			wait(6);
		}
	}
}

//Function Number: 10
getyawtospot(param_00)
{
	var_01 = param_00;
	var_02 = self.angles[1] - getyaw(var_01);
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 11
getyaw(param_00)
{
	var_01 = vectortoangles(param_00 - self.origin);
	return var_01[1];
}

//Function Number: 12
do_zombies_playvocals(param_00,param_01,param_02)
{
	self endon("death");
	if(!isdefined(param_01))
	{
		param_01 = "zombie_generic";
	}

	if(!isdefined(self.talking))
	{
		self.talking = 0;
	}

	if(!isdefined(level.zmb_vox[param_01]))
	{
		return;
	}

	if(!isdefined(level.zmb_vox[param_01][param_00]))
	{
		return;
	}

	var_03 = level.zmb_vox["prefix"] + level.zmb_vox[param_01][param_00];
	if(!soundexists(var_03))
	{
		return;
	}

	if(param_00 == "behind")
	{
		self playsoundtoplayer(var_03,param_02);
		return;
	}

	if(param_00 == "spawn" || param_00 == "idle_low" || param_00 == "idle_high" || param_00 == "move" || param_00 == "taunt" || param_00 == "pain")
	{
		if(param_00 == "spawn")
		{
			wait(0.1);
		}

		self playsoundonmovingent(var_03);
		return;
	}

	if(!self.talking)
	{
		self.talking = 1;
		if(is_last_zombie() && soundexists(var_03 + "_loud"))
		{
			var_03 = var_03 + "_loud";
		}

		playsoundwaituntildone(var_03);
		self.talking = 0;
		return;
	}
}

//Function Number: 13
is_last_zombie()
{
	if(maps\mp\zombies\zombies_spawn_manager::getnumberofzombies() <= 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
oh_shit_vox()
{
	self endon("disconnect");
	var_00 = 62500;
	var_01 = 40000;
	var_02 = 0;
	var_03 = 0;
	for(;;)
	{
		wait(1);
		var_04 = gettime() > var_02;
		var_05 = gettime() > var_03;
		if(!var_05 && !var_04)
		{
			continue;
		}

		var_06 = maps\mp\zombies\_util::get_round_enemy_array();
		var_07 = 0;
		var_08 = 0;
		for(var_09 = 0;var_09 < var_06.size;var_09++)
		{
			var_0A = var_06[var_09];
			var_0B = distancesquared(var_0A.origin,self.origin);
			var_0C = (isdefined(var_0A.enemy) && var_0A.enemy == self) || !isdefined(var_0A.enemy);
			if(var_04 && var_0C && var_0B < var_00)
			{
				var_07++;
			}

			var_0D = isdefined(var_0A.agent_type) && var_0A.agent_type == "zombie_host";
			if(var_05 && var_0D && var_0B < var_01)
			{
				var_08 = 1;
			}
		}

		if(var_07 > 4)
		{
			var_0E = create_and_play_dialog("general","oh_shit");
			if(var_0E)
			{
				var_02 = gettime() + 15000;
			}

			continue;
		}

		if(var_08)
		{
			var_0E = playerexert("cough");
			if(var_0E)
			{
				var_03 = gettime() + 3000;
			}
		}
	}
}

//Function Number: 15
zmbsetglobalpriorityonly(param_00)
{
	if(param_00)
	{
		level.zmbglobalpriorityvoonly++;
	}
	else
	{
		level.zmbglobalpriorityvoonly--;
	}

	if(level.zmbglobalpriorityvoonly < 0)
	{
		level.zmbglobalpriorityvoonly = 0;
	}
}

//Function Number: 16
create_and_play_dialog_delay(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	self endon("disconnect");
	wait(param_05);
	thread create_and_play_dialog(param_00,param_01,param_02,param_03,param_04,param_06);
}

//Function Number: 17
create_and_play_dialog(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(self.zmbvoxid))
	{
		return 0;
	}

	if(!isdefined(level.vox.speaker[self.zmbvoxid]))
	{
		return 0;
	}

	if(level.zmbglobalpriorityvoonly > 0 && param_00 != "global_priority")
	{
		return 0;
	}

	if(maps\mp\zombies\_util::is_true(self.dontspeak))
	{
		return 0;
	}

	if(maps\mp\zombies\_util::isplayerinfected(self) && param_01 != "infected" && param_01 != "sq")
	{
		return 0;
	}

	if(!isdefined(self.isspeaking))
	{
		self.isspeaking = 0;
	}

	if(maps\mp\zombies\_util::is_true(self.isspeaking))
	{
		return 0;
	}

	if(areimportantspeakersnearby(param_00))
	{
		return 0;
	}

	var_07 = isdefined(param_02);
	var_08 = undefined;
	var_09 = undefined;
	var_0A = undefined;
	var_0B = maps\mp\zombies\_zombies_audio_announcer::isannouncer(self);
	if(!isdefined(level.vox.speaker[self.zmbvoxid].alias[param_00]) || !isdefined(level.vox.speaker[self.zmbvoxid].alias[param_00][param_01]))
	{
		return 0;
	}

	if(var_0B && !level.allowzmbannouncer)
	{
		return 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!param_04 && !can_event_play(self.zmbvoxid,param_00,param_01))
	{
		return 0;
	}

	var_0C = getarraykeys(level.vox.speaker[self.zmbvoxid].prefixes);
	var_0A = level.vox.speaker[self.zmbvoxid].prefixes[var_0C[0]];
	var_08 = level.vox.speaker[self.zmbvoxid].alias[param_00][param_01];
	if(isplayer(self) || maps\mp\zombies\_util::is_true(self.fakeplayer))
	{
		if(self.sessionstate != "playing")
		{
			return 0;
		}

		if(maps\mp\zombies\_util::isplayerinlaststand(self) && param_01 != "revive_down" && param_01 != "revive_up" && param_01 != "bonus_line_over")
		{
			return 0;
		}

		var_09 = maps\mp\zombies\_util::get_player_index(self);
		var_0A = level.vox.speaker[self.zmbvoxid].prefixes[var_09];
	}

	if(isdefined(level.zmbaudioplayaltvofunc) && self [[ level.zmbaudioplayaltvofunc ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06))
	{
		return 1;
	}

	var_0D = "";
	if(param_00 == "conversation")
	{
		if(!isdefined(param_03))
		{
			param_03 = 1;
		}

		var_0D = build_dialog_line("",var_08,param_03);
		if(!soundexists(var_0D))
		{
			return 0;
		}
	}
	else
	{
		if(var_07)
		{
			var_0E = param_02 + var_08;
			var_0F = "any_" + var_08;
			var_10 = zmbvoxgetlinevariant(var_0A,var_0F,param_03);
			if(isdefined(var_10) && soundexists(var_10) && randomint(100) > 50)
			{
				var_08 = var_0F;
			}
			else
			{
				var_08 = var_0E;
			}
		}

		var_0D = zmbvoxgetlinevariant(var_0A,var_08,param_03);
		if(!isdefined(var_0D) && soundexists(var_0A + var_08))
		{
			var_0D = var_0A + var_08;
		}
	}

	if(isdefined(var_0D))
	{
		if(!soundexists(var_0D))
		{
			return 0;
		}

		if(var_0B)
		{
			thread maps\mp\zombies\_zombies_audio_announcer::playannouncerdialog(var_0A,var_09,var_0D,param_00,param_01,var_07,param_05,param_03,param_06);
		}
		else
		{
			thread do_player_or_npc_playvox(var_0A,var_09,var_0D,param_00,param_01,var_07,param_05,param_03,param_06);
		}
	}
	else
	{
		return 0;
	}

	return 1;
}

//Function Number: 18
do_player_or_npc_playvox(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("disconnect");
	self endon("stopSpeaking");
	var_09 = 0.25;
	if(param_03 == "exert")
	{
		var_09 = 0;
	}

	self.speakingline = param_02;
	self.isspeaking = 1;
	self notify("speaking");
	playsoundwaituntildone(param_02,param_03,param_04,param_08);
	if(var_09 > 0)
	{
		wait(var_09);
	}

	self notify("done_speaking");
	level notify("done_speaking");
	self.isspeaking = 0;
	if(param_03 == "conversation")
	{
		level thread setup_conversation_response_line(self,param_01,param_03,param_04,param_06,param_07);
		return;
	}

	if(isdefined(level.vox.speaker[self.zmbvoxid].response) && isdefined(level.vox.speaker[self.zmbvoxid].response[param_03]) && isdefined(level.vox.speaker[self.zmbvoxid].response[param_03][param_04]))
	{
		if(isdefined(level._audio_custom_response_line))
		{
			level thread [[ level._audio_custom_response_line ]](self,param_01,param_03,param_04,param_06);
			return;
		}

		if(param_03 == "an_conv")
		{
			level thread setup_announcer_conversation_response_line(self,param_03,param_04);
			return;
		}

		level thread setup_response_line(self,param_01,param_03,param_04,param_06);
		return;
	}
}

//Function Number: 19
areimportantspeakersnearby(param_00)
{
	return arenearbyspeakersactive() && !maps\mp\zombies\_util::is_true(self.ignorenearbyspkrs) && param_00 != "global_priority" && param_00 != "exert" && param_00 != "conversation" && param_00 != "ignore_nearby" && param_00 != "sq";
}

//Function Number: 20
waituntilquietnearby(param_00,param_01)
{
	while(param_00 arenearbyspeakersactive())
	{
		wait 0.05;
	}
}

//Function Number: 21
player_stop_speaking()
{
	self notify("stopSpeaking");
	if(maps\mp\zombies\_util::is_true(self.isspeaking) && isdefined(self.speakingline))
	{
		self stopsound(self.speakingline);
		self.isspeaking = 0;
	}
}

//Function Number: 22
getrandomcharacterinrange(param_00)
{
	var_01 = 250000;
	var_02 = [];
	foreach(var_04 in level.players)
	{
		if(!isdefined(var_04) || var_04 == param_00)
		{
			continue;
		}

		var_05 = distancesquared(param_00.origin,var_04.origin) < var_01;
		if(var_05)
		{
			var_02[var_02.size] = var_04;
		}
	}

	if(var_02.size == 1)
	{
		return var_02[0];
	}

	if(var_02.size > 1)
	{
		var_07 = randomintrange(0,var_02.size);
		return var_02[var_07];
	}
}

//Function Number: 23
setup_response_line(param_00,param_01,param_02,param_03,param_04)
{
	if(level.players.size == 1)
	{
		return;
	}

	if(!isdefined(param_04))
	{
		param_04 = getrandomcharacterinrange(param_00);
	}

	if(isdefined(param_04))
	{
		var_05 = level.vox.speaker[param_04.zmbvoxid].response[param_02][param_03];
		if(isdefined(var_05))
		{
			var_06 = level.vox.speaker[param_00.zmbvoxid].prefixes[param_01];
			param_04 create_and_play_dialog(param_02,var_05,var_06);
		}
	}
}

//Function Number: 24
setup_conversation_response_line(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_04) && isalive(param_04))
	{
		param_04 create_and_play_dialog(param_02,param_03,undefined,param_05 + 1,undefined,param_00);
	}
}

//Function Number: 25
setup_announcer_conversation_response_line(param_00,param_01,param_02)
{
	var_03 = maps\mp\zombies\_zombies_audio_announcer::getannouncer();
	var_04 = level.vox.speaker[param_00.zmbvoxid].response[param_01][param_02];
	var_05 = strtok(var_04,",");
	if(var_05.size == 3)
	{
		var_06 = var_05[0];
		var_07 = maps\mp\zombies\_zombies_audio_announcer::getannouncers(var_06);
		if(var_07.size == 1)
		{
			param_01 = var_05[1];
			param_02 = var_05[2];
			var_07[0] create_and_play_dialog(param_01,param_02);
			return;
		}

		return;
	}

	if(var_05.size == 2)
	{
		param_01 = var_05[0];
		param_02 = var_05[1];
		var_03 create_and_play_dialog(param_01,param_02);
		return;
	}

	if(var_05.size == 1)
	{
		param_02 = var_05[0];
		var_08 = common_scripts\utility::array_randomize(level.players);
		foreach(param_00 in var_08)
		{
			var_0A = param_00 create_and_play_dialog(param_01,param_02,"");
			if(var_0A)
			{
				break;
			}
		}

		return;
	}
}

//Function Number: 26
player_killstreak_init()
{
	self.timerisrunning = 0;
	self.killcounter = 0;
}

//Function Number: 27
player_kill_zombie(param_00,param_01,param_02,param_03)
{
	var_04 = 8;
	var_05 = 5;
	self.killcounter++;
	var_06 = 16;
	var_07 = isdefined(param_01) && param_01 == "MOD_MELEE";
	var_08 = isdefined(param_03.missingbodyparts) && param_03.missingbodyparts & var_06;
	if(var_07 && var_08)
	{
		playerlaugh();
	}
	else
	{
		thread player_zombie_kill_vox(param_00,param_01,param_02,param_03);
	}

	if(self.timerisrunning != 1)
	{
		self.timerisrunning = 1;
		thread timer_actual(var_04,var_05);
	}
}

//Function Number: 28
player_zombie_kill_vox(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	if(!isdefined(param_03) || maps\mp\zombies\_util::is_true(self.force_wait_on_kill_line))
	{
		return;
	}

	param_02 = getweaponbasename(param_02);
	var_04 = playertryzombiekillvo(param_00,param_01,param_02,param_03);
	if(isdefined(var_04))
	{
		self.force_wait_on_kill_line = 1;
		wait(2);
		self.force_wait_on_kill_line = 0;
	}
}

//Function Number: 29
can_event_play(param_00,param_01,param_02)
{
	var_03 = get_event_chance(param_00,param_01,param_02);
	return var_03 > randomintrange(1,100);
}

//Function Number: 30
get_event_chance(param_00,param_01,param_02)
{
	if(!isdefined(level.vox.speaker[param_00]) || !isdefined(level.vox.speaker[param_00].chance) || !isdefined(level.vox.speaker[param_00].chance[param_01]) || !isdefined(level.vox.speaker[param_00].chance[param_01][param_02]))
	{
		return 0;
	}

	return level.vox.speaker[param_00].chance[param_01][param_02];
}

//Function Number: 31
playertryzombiekillvo(param_00,param_01,param_02,param_03)
{
	var_04 = "kill";
	if(maps\mp\zombies\_util::istrapweapon(param_02))
	{
		return;
	}

	if(isdefined(param_03.agent_type) && param_03.agent_type == "zombie_melee_goliath")
	{
		if(maps\mp\zombies\_util::getzombieslevelnum() > 2)
		{
			wait(2.5);
		}

		create_and_play_dialog(var_04,"goliath_kill");
		return "goliath_kill";
	}

	if(isdefined(param_03.sound_damage_player) && param_03.sound_damage_player == self && create_and_play_dialog(var_04,"damage"))
	{
		return "damage";
	}

	var_05 = distancesquared(self.origin,param_03.origin);
	if(maps\mp\_utility::isheadshot(param_02,param_00,param_01) && var_05 >= 160000 && create_and_play_dialog(var_04,"headshot"))
	{
		return "headshot";
	}

	var_06 = maps\mp\zombies\_util::gameflagexists("explosive_touch") && maps\mp\_utility::gameflag("explosive_touch");
	if(var_06 && isdefined(param_02) && param_02 == "explosive_touch_zombies_mp" && create_and_play_dialog(var_04,"melee_instakill"))
	{
		return "melee_instakill";
	}

	var_07 = maps\mp\zombies\_util::isinstakill();
	if(var_07)
	{
		if((param_01 == "MOD_MELEE" || param_01 == "MOD_MELEE_ALT") && create_and_play_dialog(var_04,"melee_instakill"))
		{
			return "melee_instakill";
		}
		else if(create_and_play_dialog(var_04,"weapon_instakill"))
		{
			return "weapon_instakill";
		}
	}

	if(maps\mp\zombies\_util::iszombiedistractiondrone(param_02) && create_and_play_dialog(var_04,"distract_drone"))
	{
		return "distract_drone";
	}

	if(maps\mp\zombies\_util::iszombiednagrenade(param_02) && create_and_play_dialog(var_04,"nano_swarm"))
	{
		return "nano_swarm";
	}

	if(isexplosivedamagemod(param_01) && param_02 != "repulsor_zombie_mp" && param_02 != "iw5_tridentzm_mp" && param_02 != "playermech_rocket_zm_mp" && param_02 != "iw5_juggernautrocketszm_mp" && create_and_play_dialog(var_04,"explosive"))
	{
		return "explosive";
	}

	if(var_05 < 4096 && create_and_play_dialog(var_04,"closekill"))
	{
		return "closekill";
	}

	if(param_03 maps\mp\zombies\_util::checkactivemutator("acid") && create_and_play_dialog(var_04,"acid_kill"))
	{
		return "acid_kill";
	}

	if(param_03.agent_type == "zombie_host" && create_and_play_dialog(var_04,"host"))
	{
		return "host";
	}

	if(param_03.agent_type == "zombie_dog" && create_and_play_dialog(var_04,"dog"))
	{
		return "dog";
	}

	if(maps\mp\zombies\_util::is_true(param_03.dismember_crawl) && create_and_play_dialog(var_04,"crawler"))
	{
		return "crawler";
	}

	if(param_02 == "iw5_microwavezm_mp" && create_and_play_dialog(var_04,"microwave"))
	{
		return "microwave";
	}

	if(param_02 == "iw5_fusionzm_mp" && create_and_play_dialog(var_04,"fusion_rifle"))
	{
		return "fusion_rifle";
	}

	if(maps\mp\zombies\_util::getzombieslevelnum() > 2)
	{
		if((param_02 == "iw5_linegunzm_mp" || param_02 == "iw5_linegundamagezm_mp") && create_and_play_dialog(var_04,"linegun"))
		{
			return "linegun";
		}

		if(param_02 == "iw5_dlcgun2zm_mp" && create_and_play_dialog(var_04,"ohm"))
		{
			return "ohm";
		}

		if(param_02 == "iw5_dlcgun3zm_mp" && create_and_play_dialog(var_04,"m1irons"))
		{
			return "m1irons";
		}

		if(param_02 == "repulsor_zombie_mp" && create_and_play_dialog(var_04,"respulsor"))
		{
			return "respulsor";
		}
	}

	if(maps\mp\zombies\_util::getzombieslevelnum() > 3)
	{
		if(param_02 == "iw5_tridentzm_mp" && create_and_play_dialog(var_04,"trident"))
		{
			return "trident";
		}

		if(param_02 == "iw5_dlcgun4zm_mp" && create_and_play_dialog(var_04,"blunderbuss"))
		{
			return "blunderbuss";
		}

		if(param_02 == "iw5_exominigunzm_mp")
		{
			if((param_01 == "MOD_MELEE" || param_01 == "MOD_MELEE_ALT") && create_and_play_dialog(var_04,"gol_melee_kill"))
			{
				return "gol_melee";
			}
		}

		if(param_02 == "playermech_rocket_zm_mp" && create_and_play_dialog(var_04,"gol_missile_kill"))
		{
			return "gol_missile";
		}

		if(param_02 == "iw5_juggernautrocketszm_mp" && create_and_play_dialog(var_04,"gol_rocket_kill"))
		{
			return "gol_rocket";
		}
	}

	if((param_01 == "MOD_MELEE" || param_01 == "MOD_MELEE_ALT") && create_and_play_dialog(var_04,"melee"))
	{
		return "melee";
	}

	if((param_01 == "MOD_RIFLE_BULLET" || param_01 == "MOD_PISTOL_BULLET") && create_and_play_dialog(var_04,"bullet"))
	{
		return "bullet";
	}
}

//Function Number: 32
timer_actual(param_00,param_01)
{
	self endon("disconnect");
	self endon("death");
	var_02 = gettime() + param_01 * 1000;
	while(gettime() < var_02)
	{
		if(self.killcounter > param_00)
		{
			thread create_and_play_dialog_delay("kill","streak",undefined,undefined,undefined,1);
			wait(2);
			self.killcounter = 0;
			var_02 = -2;
		}

		wait(0.1);
	}

	wait(10);
	self.killcounter = 0;
	self.timerisrunning = 0;
}

//Function Number: 33
player_hurt(param_00,param_01,param_02)
{
	if(isdefined(param_02) && param_02 == "MOD_FALLING" && !maps\mp\_utility::isjuggernaut())
	{
		thread playerexert("grunt");
		return;
	}

	if(isdefined(param_00) && isai(param_00))
	{
		if(isdefined(param_00.agent_type) && param_00.agent_type == "zombie_host")
		{
			thread create_and_play_dialog_delay("general","host_hit",undefined,undefined,1,1);
		}
		else if(isdefined(param_00.agent_type) && param_00.agent_type == "zombie_dog")
		{
			thread create_and_play_dialog_delay("general","dog_hit",undefined,undefined,1,1);
		}

		if(param_01 < self.health)
		{
			param_00.sound_damage_player = self;
			if(maps\mp\zombies\_util::is_true(param_00.dismember_crawl))
			{
				thread create_and_play_dialog("general","crawl_hit");
				return;
			}

			return;
		}
	}
}

//Function Number: 34
player_emp()
{
	var_00 = !isdefined(self.hitbyemp);
	thread create_and_play_dialog("general","emp",undefined,undefined,var_00);
	self.hitbyemp = 1;
}

//Function Number: 35
player_infected()
{
	if(isdefined(self.hasburgerinfected))
	{
		return;
	}

	thread create_and_play_dialog_delay("general","infected",undefined,undefined,undefined,3);
}

//Function Number: 36
player_cured()
{
	thread create_and_play_dialog_delay("general","cured",undefined,undefined,undefined,1);
}

//Function Number: 37
zombie_hurt(param_00,param_01)
{
	if(isdefined(param_00) && isplayer(param_00) && param_01 < self.health)
	{
		if(param_00 isjumping())
		{
			param_00 thread playerlaugh();
			return;
		}

		if(isdefined(self.agent_type) && self.agent_type == "zombie_host")
		{
			param_00 thread player_hurt_zombie_vox("host_damaged");
			return;
		}
	}
}

//Function Number: 38
playerlaugh()
{
	if(!isdefined(self.nextlaughtime) || gettime() > self.nextlaughtime)
	{
		var_00 = playerexert("laugh");
		if(var_00)
		{
			self.nextlaughtime = gettime() + 15000;
		}
	}
}

//Function Number: 39
player_hurt_zombie_vox(param_00)
{
	thread create_and_play_dialog_delay("general",param_00,undefined,undefined,undefined,1);
}

//Function Number: 40
player_track_ammo_count()
{
	self notify("stop_ammo_tracking");
	self endon("disconnect");
	self endon("stop_ammo_tracking");
	var_00 = [];
	var_01 = 0;
	var_02 = self getcurrentweapon();
	var_03 = var_02;
	for(;;)
	{
		wait(0.1);
		var_03 = var_02;
		var_02 = self getcurrentweapon();
		if(!isdefined(var_02) || var_02 == "none" || !can_track_ammo(var_02))
		{
			continue;
		}

		if(maps\mp\zombies\_util::gameflagexists("unlimited_ammo") && maps\mp\_utility::gameflag("unlimited_ammo"))
		{
			continue;
		}

		if(!isdefined(var_00[var_02]))
		{
			var_00[var_02] = 0;
		}

		if(!playerammolow(var_02) || maps\mp\zombies\_util::isplayerinlaststand(self))
		{
			continue;
		}

		if(playerammoout())
		{
			if(gettime() > var_01)
			{
				create_and_play_dialog("general","ammo_out");
				var_01 = gettime() + 20000;
			}

			continue;
		}

		if(gettime() > var_00[var_02])
		{
			create_and_play_dialog("general","ammo_low");
			var_00[var_02] = gettime() + 20000;
		}
	}
}

//Function Number: 41
playerammolow(param_00)
{
	if(isdefined(level.playerammolowfunc))
	{
		var_01 = [[ level.playerammolowfunc ]](param_00);
		if(isdefined(var_01))
		{
			return var_01;
		}
	}

	if(param_00 == "search_dstry_bomb_defuse_mp")
	{
		return 0;
	}

	if(issubstr(param_00,"iw5_em1zm_mp") && maps\mp\zombies\_util::playerhasem1ammoinfo())
	{
		var_02 = maps\mp\zombies\_util::playergetem1ammo();
		var_03 = maps\mp\gametypes\zombies::getem1maxammo();
		return var_02 / var_03 < 0.05;
	}

	if(maps\mp\zombies\_util::isrippedturretweapon(var_03) && maps\mp\killstreaks\_rippedturret::playerhasrippableturretinfo())
	{
		var_02 = maps\mp\killstreaks\_rippedturret::playergetrippableammo();
		var_03 = maps\mp\killstreaks\_rippedturret::getammoforturretweapontype(var_02);
		return var_02 / var_03 < 0.05;
	}

	return self setweaponammostock(var_03) == 0;
}

//Function Number: 42
playerammoout()
{
	var_00 = 0;
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(var_03 == "search_dstry_bomb_defuse_mp")
		{
			continue;
		}

		if(issubstr(var_03,"iw5_em1zm_mp") && maps\mp\zombies\_util::playerhasem1ammoinfo())
		{
			var_04 = maps\mp\zombies\_util::playergetem1ammo();
			if(var_04 > 0)
			{
				var_00 = 1;
				break;
			}

			continue;
		}

		if(maps\mp\zombies\_util::isrippedturretweapon(var_03) && maps\mp\killstreaks\_rippedturret::playerhasrippableturretinfo())
		{
			var_04 = maps\mp\killstreaks\_rippedturret::playergetrippableammo();
			if(var_04 > 0)
			{
				var_00 = 1;
				break;
			}

			continue;
		}

		if(self getammocount(var_03) > 0)
		{
			var_00 = 1;
			break;
		}
	}

	return !var_00;
}

//Function Number: 43
can_track_ammo(param_00)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return 0;
	}

	if(maps\mp\zombies\weapons\_zombie_weapons::isplaceableminetype(param_00) || maps\mp\zombies\_util::iszombieequipment(param_00) || maps\mp\zombies\_util::iszombiekillstreakweapon(param_00) || param_00 == maps\mp\gametypes\zombies::getexosuitequipweaponname() || param_00 == maps\mp\gametypes\zombies::getcharacterintroweaponname() || param_00 == maps\mp\gametypes\zombies::getcharacterintroidleweapon() || param_00 == maps\mp\gametypes\zombies::getexosuitperkweaponname("health") || param_00 == maps\mp\gametypes\zombies::getexosuitperkweaponname("stabilizer") || param_00 == maps\mp\gametypes\zombies::getexosuitperkweaponname("stim") || param_00 == maps\mp\gametypes\zombies::getexosuitperkweaponname("slam") || param_00 == maps\mp\gametypes\zombies::getexosuitperkweaponname("fastreload") || param_00 == "iw5_combatknife_mp" || param_00 == "iw5_combatknifegoliath_mp")
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
weapon_toggle_vox(param_00,param_01)
{
	self notify("audio_activated_trigger");
	self endon("audio_activated_trigger");
	var_02 = "vox_pa_switcher_";
	var_03 = var_02 + param_00;
	var_04 = undefined;
	if(isdefined(param_01))
	{
		var_04 = get_weapon_num(param_01);
		if(!isdefined(var_04))
		{
			return;
		}
	}

	self stopsounds();
	wait(0.05);
	if(isdefined(var_04))
	{
		playsoundwaituntildone(var_02 + "weapon_" + var_04,"sounddone");
	}

	self playsound(var_03 + "_0");
}

//Function Number: 45
get_weapon_num(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "humangun_zm":
			var_01 = 0;
			break;

		case "sniper_explosive_zm":
			var_01 = 1;
			break;

		case "tesla_gun_zm":
			var_01 = 2;
			break;
	}

	return var_01;
}

//Function Number: 46
addasspeakernpc(param_00)
{
	if(!isdefined(level.npcs))
	{
		level.npcs = [];
	}

	if(maps\mp\zombies\_util::is_true(param_00))
	{
		self.ignorenearbyspkrs = 1;
	}
	else
	{
		self.ignorenearbyspkrs = 0;
	}

	self.isnpc = 1;
	level.npcs[level.npcs.size] = self;
}

//Function Number: 47
arenearbyspeakersactive()
{
	var_00 = 1000000;
	var_01 = 0;
	var_02 = maps\mp\zombies\_zombies_audio_announcer::isannouncer(self);
	var_03 = level.players;
	if(isdefined(level.npcs))
	{
		var_03 = common_scripts\utility::array_combine(var_03,level.npcs);
	}

	foreach(var_05 in var_03)
	{
		if(self == var_05)
		{
			continue;
		}

		if(isplayer(var_05))
		{
			if(var_05.sessionstate != "playing" || maps\mp\zombies\_util::isplayerinlaststand(var_05))
			{
				continue;
			}
		}
		else
		{
		}

		if(maps\mp\zombies\_util::is_true(var_05.isspeaking) && !maps\mp\zombies\_util::is_true(var_05.ignorenearbyspkrs))
		{
			if(var_02 || distancesquared(self.origin,var_05.origin) < var_00)
			{
				var_01 = 1;
				break;
			}
		}
	}

	return var_01;
}

//Function Number: 48
zmbvoxcreate()
{
	var_00 = spawnstruct();
	var_00.speaker = [];
	return var_00;
}

//Function Number: 49
zmbvoxinitspeaker(param_00,param_01,param_02,param_03)
{
	param_02.zmbvoxid = param_00;
	if(!isdefined(self.speaker[param_00]))
	{
		self.speaker[param_00] = spawnstruct();
		self.speaker[param_00].alias = [];
		self.speaker[param_00].prefixes = [];
		self.speaker[param_00].ents = [];
	}

	self.speaker[param_00].ents[param_03] = param_02;
	self.speaker[param_00].prefixes[param_03] = param_01;
}

//Function Number: 50
zmbvoxadd(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(self.speaker[param_00]))
	{
		self.speaker[param_00] = spawnstruct();
		self.speaker[param_00].alias = [];
		self.speaker[param_00].prefixes = [];
		self.speaker[param_00].ents = [];
	}

	if(!isdefined(self.speaker[param_00].alias[param_01]))
	{
		self.speaker[param_00].alias[param_01] = [];
	}

	self.speaker[param_00].alias[param_01][param_02] = param_03;
	if(isdefined(param_04))
	{
		if(!isdefined(self.speaker[param_00].response))
		{
			self.speaker[param_00].response = [];
		}

		if(!isdefined(self.speaker[param_00].response[param_01]))
		{
			self.speaker[param_00].response[param_01] = [];
		}

		self.speaker[param_00].response[param_01][param_02] = param_04;
	}

	if(!isdefined(param_05))
	{
		param_05 = 100;
	}

	if(!isdefined(self.speaker[param_00].chance))
	{
		self.speaker[param_00].chance = [];
	}

	if(!isdefined(self.speaker[param_00].chance[param_01]))
	{
		self.speaker[param_00].chance[param_01] = [];
	}

	self.speaker[param_00].chance[param_01][param_02] = param_05;
}

//Function Number: 51
build_dialog_line(param_00,param_01,param_02)
{
	if(param_02 < 10)
	{
		return param_00 + param_01 + "_0" + param_02;
	}

	return param_00 + param_01 + "_" + param_02;
}

//Function Number: 52
zmbvoxgetlinevariant(param_00,param_01,param_02)
{
	if(!isdefined(self.sound_dialog))
	{
		self.sound_dialog = [];
		self.sound_dialog_available = [];
	}

	if(!isdefined(self.sound_dialog[param_01]))
	{
		var_03 = get_number_variants(param_00,param_01);
		if(var_03 <= 0)
		{
			return undefined;
		}

		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			self.sound_dialog[param_01][var_04] = var_04 + 1;
		}

		self.sound_dialog_available[param_01] = [];
	}

	if(self.sound_dialog_available[param_01].size <= 0)
	{
		for(var_04 = 0;var_04 < self.sound_dialog[param_01].size;var_04++)
		{
			self.sound_dialog_available[param_01][var_04] = self.sound_dialog[param_01][var_04];
		}
	}

	var_05 = common_scripts\utility::random(self.sound_dialog_available[param_01]);
	self.sound_dialog_available[param_01] = common_scripts\utility::array_remove(self.sound_dialog_available[param_01],var_05);
	if(isdefined(param_02))
	{
		var_05 = param_02;
	}

	return build_dialog_line(param_00,param_01,var_05);
}

//Function Number: 53
playsoundwaituntildone(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01) && param_01 == "monologue")
	{
		self playlocalsound(param_00);
	}
	else if(isdefined(param_03) && param_03.size > 0)
	{
		param_03 = common_scripts\utility::array_removeundefined(param_03);
		foreach(var_05 in param_03)
		{
			if(isdefined(var_05))
			{
				self playsoundtoplayer(param_00,var_05,1);
			}
		}
	}
	else
	{
		self playsoundonmovingent(param_00);
	}

	var_07 = volength(param_00,param_01);
	wait(var_07);
}

//Function Number: 54
get_number_variants(param_00,param_01)
{
	var_02 = 100;
	for(var_03 = 1;var_03 < var_02;var_03++)
	{
		if(!soundexists(build_dialog_line(param_00,param_01,var_03)))
		{
			return var_03 - 1;
		}
	}

	return var_02;
}

//Function Number: 55
play_level_start_vox()
{
	level thread setupwaveintermissiondialog();
	wait(1);
	if(isdefined(level.zmbaudiowave1vo))
	{
		level thread [[ level.zmbaudiowave1vo ]]();
	}
	else if(level.players.size == 1)
	{
		var_00 = randomintrange(0,level.players.size);
		level.players[var_00] thread create_and_play_dialog("general","intro");
	}
	else
	{
		level thread playwavenumintrodialog("wave1",1,2,0,3);
	}

	level.zmplayedearlywavevo = 0;
	for(;;)
	{
		level waittill("zombie_wave_started");
		wait(1);
		var_01 = 0;
		if(!maps\mp\zombies\_zombies_audio_announcer::isannouncinground())
		{
			maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
		}
		else
		{
			var_01 = 1;
		}

		if(isdefined(level.zmbaudiowavestartvo))
		{
			var_01 = [[ level.zmbaudiowavestartvo ]](var_01);
		}
		else
		{
			if(!var_01 && level.wavecounter == 2)
			{
				playwavenumintrodialog("wave2",2,0,1,3);
				var_01 = 1;
			}
			else if(!var_01 && level.wavecounter == 5 || level.wavecounter == 10 || level.wavecounter == 20 || level.wavecounter == 35 || level.wavecounter == 50)
			{
				var_00 = randomintrange(0,level.players.size);
				level.players[var_00] create_and_play_dialog("general","round_" + level.wavecounter);
				var_01 = 1;
			}

			if(!var_01 && level.wavecounter > 2 && !level.zmplayedearlywavevo)
			{
				var_02 = randomintrange(0,100);
				if(var_02 < 30)
				{
					playwavenumintrodialog("wave_early",0,2,1,3);
					level.zmplayedearlywavevo = 0;
					var_01 = 1;
				}
			}
		}

		if(!var_01 && level.wavecounter > 1)
		{
			var_00 = randomintrange(0,level.players.size);
			level.players[var_00] create_and_play_dialog("general","wave_start");
			var_01 = 1;
		}

		level waittill("zombie_wave_ended");
		var_03 = 1;
		var_04 = 0;
		if(isdefined(level.zmbdowaveendvo))
		{
			var_03 = [[ level.zmbdowaveendvo ]]();
		}

		if(var_03)
		{
			wait(1);
			var_00 = randomintrange(0,level.players.size);
			var_04 = level.players[var_00] create_and_play_dialog("general","wave_end");
			if(var_04)
			{
				level.players[var_00] common_scripts\utility::waittill_notify_or_timeout("done_speaking",6);
				wait(1);
			}
		}

		if(isdefined(level.zmbwaveintermissionvo))
		{
			var_04 = [[ level.zmbwaveintermissionvo ]](var_04);
		}

		if(!playweaponremindervo() && !var_04)
		{
			playwaveintermissiondialog();
		}
	}
}

//Function Number: 56
playwavenumintrodialog(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_05))
	{
		param_05 = "general";
	}

	var_06 = getcharacterbyindex(param_01);
	if(isdefined(var_06) && var_06 create_and_play_dialog(param_05,param_00))
	{
		level common_scripts\utility::waittill_notify_or_timeout("done_speaking",6);
	}

	var_06 = getcharacterbyindex(param_02);
	if(isdefined(var_06) && var_06 create_and_play_dialog(param_05,param_00))
	{
		level common_scripts\utility::waittill_notify_or_timeout("done_speaking",6);
	}

	var_06 = getcharacterbyindex(param_03);
	if(isdefined(var_06) && var_06 create_and_play_dialog(param_05,param_00))
	{
		level common_scripts\utility::waittill_notify_or_timeout("done_speaking",6);
	}

	var_06 = getcharacterbyindex(param_04);
	if(isdefined(var_06) && var_06 create_and_play_dialog(param_05,param_00))
	{
		level common_scripts\utility::waittill_notify_or_timeout("done_speaking",6);
	}
}

//Function Number: 57
playweaponremindervo()
{
	if(level.wavecounter == 2)
	{
		var_00 = getplayerwhoonlyhaspistol();
		if(isdefined(var_00))
		{
			return var_00 create_and_play_dialog("general","weapon_reminder",undefined,1);
		}
	}
	else if(level.wavecounter == 10)
	{
		var_00 = getplayerwhohasnotupgraded();
		if(isdefined(var_00))
		{
			return var_00 create_and_play_dialog("general","weapon_reminder",undefined,2);
		}
	}

	return 0;
}

//Function Number: 58
getplayerwhoonlyhaspistol()
{
	foreach(var_01 in level.players)
	{
		var_02 = var_01 getweaponslistprimaries();
		if(var_02.size == 1 && var_02[0] == "iw5_titan45zm_mp")
		{
			return var_01;
		}
	}
}

//Function Number: 59
getplayerwhohasnotupgraded()
{
	foreach(var_01 in level.players)
	{
		var_02 = var_01 getweaponslistprimaries();
		foreach(var_04 in var_02)
		{
			if(maps\mp\zombies\_util::getzombieweaponlevel(var_01,var_04) < 2)
			{
				return var_01;
			}
		}
	}
}

//Function Number: 60
setupwaveintermissiondialog()
{
	level.zmwaveintermissiondialog = [];
	level.zmwaveintermissiondialog[0] = newwaveintermissionstruct();
	level.zmwaveintermissiondialog[1] = newwaveintermissionstruct();
}

//Function Number: 61
newwaveintermissionstruct()
{
	var_00 = spawnstruct();
	var_00.characters = [];
	var_00.prefixes = [];
	var_00.sequence = 1;
	var_00.active = 0;
	var_00.completed = 0;
	var_00.nextround = 1;
	return var_00;
}

//Function Number: 62
playwaveintermissiondialog()
{
	if(level.players.size == 1 || !isdefined(level.vox.speaker["player"].alias["conversation"]))
	{
		return 0;
	}

	foreach(var_01 in level.zmwaveintermissiondialog)
	{
		if(dialogcanplay(var_01) && playdialog(var_01))
		{
			dialogincrement(var_01);
			return 1;
		}
	}

	foreach(var_01 in level.zmwaveintermissiondialog)
	{
		if(!var_01.active && createdialog(var_01))
		{
			if(playdialog(var_01))
			{
				dialogincrement(var_01);
				return 1;
			}
			else
			{
				return 0;
			}
		}
	}

	return 0;
}

//Function Number: 63
dialogcanplay(param_00)
{
	return param_00.active && param_00.nextround <= level.wavecounter && dialogcharactersactive(param_00);
}

//Function Number: 64
dialogcharactersactive(param_00)
{
	if(param_00.characters.size != 2)
	{
		return 0;
	}

	foreach(var_02 in param_00.characters)
	{
		if(!isdefined(var_02) || !maps\mp\_utility::isreallyalive(var_02))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 65
dialogincrement(param_00)
{
	param_00.nextround = param_00.nextround + randomintrange(2,4);
	param_00.sequence++;
}

//Function Number: 66
playerinanydialog()
{
	foreach(var_01 in level.zmwaveintermissiondialog)
	{
		if(common_scripts\utility::array_contains(var_01.characters,self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 67
createdialog(param_00)
{
	var_01 = common_scripts\utility::array_randomize(level.players);
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in var_01)
	{
		if(!var_05 playerinanydialog())
		{
			if(!isdefined(var_02))
			{
				var_02 = var_05;
			}
			else
			{
				var_03 = var_05;
			}
		}

		if(isdefined(var_02) && isdefined(var_03))
		{
			break;
		}
	}

	if(!isdefined(var_02) || !isdefined(var_03))
	{
		return 0;
	}

	param_00.characters[0] = var_02;
	param_00.characters[1] = var_03;
	param_00.prefixes[0] = level.vox.speaker[var_02.zmbvoxid].prefixes[maps\mp\zombies\_util::get_player_index(var_02)];
	param_00.prefixes[1] = level.vox.speaker[var_03.zmbvoxid].prefixes[maps\mp\zombies\_util::get_player_index(var_03)];
	param_00.active = 1;
	param_00.completed = 0;
	return 1;
}

//Function Number: 68
playdialog(param_00)
{
	var_01 = "" + param_00.prefixes[0] + param_00.prefixes[1] + param_00.sequence;
	var_02 = param_00.characters[0];
	var_03 = param_00.characters[1];
	if(!isdefined(level.vox.speaker["player"].alias["conversation"][var_01]))
	{
		var_01 = "" + param_00.prefixes[1] + param_00.prefixes[0] + param_00.sequence;
		var_02 = param_00.characters[1];
		var_03 = param_00.characters[0];
		if(!isdefined(level.vox.speaker["player"].alias["conversation"][var_01]))
		{
			param_00.completed = 1;
			return 0;
		}
	}

	return var_02 create_and_play_dialog("conversation",var_01,undefined,undefined,undefined,var_03);
}

//Function Number: 69
getcharacterbyindex(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02.characterindex == param_00)
		{
			return var_02;
		}
	}
}

//Function Number: 70
getcharacterindexbyprefix(param_00)
{
	switch(param_00)
	{
		case "guard":
			return 0;

		case "exec":
			return 1;

		case "it":
			return 2;

		case "pilot":
		case "janitor":
			return 3;
	}
}

//Function Number: 71
getcharacterbyprefix(param_00)
{
	return getcharacterbyindex(getcharacterindexbyprefix(param_00));
}

//Function Number: 72
getanycharacterbyprefixexcept(param_00)
{
	var_01 = getcharacterbyprefix(param_00);
	if(!isdefined(var_01))
	{
		return level.players[randomint(level.players.size)];
	}

	var_02 = common_scripts\utility::array_randomize(level.players);
	foreach(var_04 in level.players)
	{
		if(var_04 != var_01)
		{
			return var_04;
		}
	}
}

//Function Number: 73
play_weapon_vo(param_00)
{
	if(!isplayer(self))
	{
		return;
	}

	param_00 = getweaponbasename(param_00);
	var_01 = weapon_type_check(param_00);
	if(var_01 == "skip")
	{
		return;
	}

	create_and_play_dialog("weapon_pickup",var_01);
}

//Function Number: 74
is_favorite_weapon(param_00)
{
	if(!isdefined(self.favorite_wall_weapons_list))
	{
		return 0;
	}

	foreach(var_02 in self.favorite_wall_weapons_list)
	{
		if(issubstr(param_00,var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 75
is_bad_weapon(param_00)
{
	return 0;
}

//Function Number: 76
has_custom_weapon_vo(param_00)
{
	switch(param_00)
	{
		case "iw5_dlcgun4zm_mp":
		case "iw5_dlcgun3zm_mp":
		case "iw5_dlcgun2zm_mp":
		case "iw5_linegunzm_mp":
		case "iw5_fusionzm_mp":
		case "iw5_tridentzm_mp":
		case "iw5_microwavezm_mp":
		case "teleport_throw_zombies_mp":
		case "dna_aoe_grenade_zombie_mp":
		case "distraction_drone_throw_zombie_mp":
		case "distraction_drone_zombie_mp":
		case "explosive_drone_throw_zombie_mp":
		case "explosive_drone_zombie_mp":
		case "contact_grenade_throw_zombies_mp":
		case "contact_grenade_zombies_mp":
		case "dna_aoe_grenade_throw_zombie_mp":
		case "teleport_zombies_mp":
		case "repulsor_zombie_mp":
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 77
skip_weapon_vo(param_00)
{
	switch(param_00)
	{
		case "frag_grenade_zombies_mp":
		case "frag_grenade_throw_zombies_mp":
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 78
weapon_type_check(param_00)
{
	param_00 = getweaponbasename(param_00);
	if(is_favorite_weapon(param_00))
	{
		return "favorite";
	}

	if(is_bad_weapon(param_00))
	{
		return "bad_weapon";
	}

	if(has_custom_weapon_vo(param_00))
	{
		return param_00;
	}

	if(skip_weapon_vo(param_00))
	{
		return "skip";
	}

	return "generic";
}

//Function Number: 79
zmplaydeathsound()
{
	var_00 = randomintrange(0,3);
	player_stop_speaking();
	playerstopexerting();
	playerexert("death" + var_00);
}

//Function Number: 80
zmplaydamagesound(param_00)
{
	if(isdefined(self.damage_sound_time) && self.damage_sound_time + 5000 > param_00)
	{
		return;
	}

	if(!maps\mp\zombies\_util::is_true(self.isexerting))
	{
		self.damage_sound_time = param_00;
		var_01 = randomintrange(0,3);
		player_stop_speaking();
		playerexert("pain" + var_01);
	}
}

//Function Number: 81
playerexert(param_00)
{
	if(maps\mp\zombies\_util::is_true(self.isspeaking) || maps\mp\zombies\_util::is_true(self.isexerting))
	{
		return 0;
	}

	var_01 = create_and_play_dialog("exert",param_00);
	if(!maps\mp\zombies\_util::is_true(self.isexerting))
	{
		thread exert_timer();
	}

	return var_01;
}

//Function Number: 82
playerstopexerting()
{
	self notify("stopExerting");
	self.isexerting = undefined;
}

//Function Number: 83
exert_timer()
{
	self endon("disconnect");
	self endon("stopExerting");
	wait(1);
	self.isexerting = 1;
	wait(randomfloatrange(1.5,3));
	self.isexerting = undefined;
}

//Function Number: 84
playerkillstreakcratevo(param_00)
{
	self endon("disconnect");
	if(issubstr(param_00,"drop_pre"))
	{
		wait(2);
	}
	else
	{
		wait(0.5);
	}

	thread create_and_play_dialog("general",param_00);
}

//Function Number: 85
playerpoweronvo()
{
	thread create_and_play_dialog_delay("general","power_on",undefined,undefined,undefined,1);
}

//Function Number: 86
playerpoweroffvo()
{
	thread create_and_play_dialog_delay("general","power_off",undefined,undefined,undefined,1);
}

//Function Number: 87
playerrevivevo(param_00)
{
	self endon("disconnect");
	wait(1);
	var_01 = create_and_play_dialog("general","bonus_line_not_over",undefined,undefined,undefined,param_00);
	if(!var_01)
	{
		create_and_play_dialog("general","revive_up",undefined,undefined,undefined,param_00);
	}
}

//Function Number: 88
playerlaststandvo()
{
	self endon("disconnect");
	wait(1);
	var_00 = create_and_play_dialog("general","bonus_line_over");
	if(!var_00)
	{
		create_and_play_dialog("general","revive_down");
	}
}

//Function Number: 89
playerexosuit(param_00)
{
	self endon("death");
	self endon("disconnect");
	wait(0.5);
	thread create_and_play_dialog_delay("perk",param_00,undefined,undefined,undefined,0.5);
}

//Function Number: 90
playerexosuitrejected(param_00,param_01)
{
	var_02 = param_00;
	if(param_00 != "exo_suit")
	{
		var_02 = "exo_upgrade";
	}

	var_02 = var_02 + "_" + param_01;
	thread _playerbuyrejected(var_02);
}

//Function Number: 91
_playerbuyrejected(param_00)
{
	if(!maps\mp\zombies\_util::is_true(self.force_wait_on_buy_line))
	{
		self.force_wait_on_buy_line = 1;
		create_and_play_dialog("general",param_00);
		wait(10);
		self.force_wait_on_buy_line = undefined;
	}
}

//Function Number: 92
playerweaponbuy(param_00)
{
	thread _playerbuyrejected(param_00);
}

//Function Number: 93
playerweaponupgrade(param_00,param_01)
{
	if(param_01 == 20)
	{
		thread create_and_play_dialog_delay("perk","weapon_upgrade_max",undefined,undefined,undefined,1);
		return;
	}

	if(!isdefined(self.weaponupgradevodebounce) || self.weaponupgradevodebounce < gettime())
	{
		thread create_and_play_dialog_delay("perk","weapon_upgrade",undefined,undefined,undefined,1);
		self.weaponupgradevodebounce = gettime() + 20000;
	}
}

//Function Number: 94
playerfoundprinter()
{
	thread create_and_play_dialog("general","found_printer");
}

//Function Number: 95
moneyspend()
{
	self playlocalsound("interact_purchase");
}

//Function Number: 96
playertrashchute()
{
	self endon("disconnect");
	var_00 = "slide_chute";
	if(maps\mp\zombies\_util::getzombieslevelnum() == 3)
	{
		wait(2);
		var_00 = "teleport_machine";
	}

	thread create_and_play_dialog_delay("monologue",var_00,undefined,undefined,undefined,0.5);
}

//Function Number: 97
plinko_clink(param_00,param_01)
{
	param_00 playsoundonmovingent("plinko_clink_" + param_01);
}