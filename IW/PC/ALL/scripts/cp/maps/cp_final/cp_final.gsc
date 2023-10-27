/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_final\cp_final.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 119
 * Decompile Time: 6135 ms
 * Timestamp: 10/27/2023 12:04:52 AM
*******************************************************************/

//Function Number: 1
setuphacks()
{
	level.var_2001 = 0;
	level.var_D336 = 0;
	level.var_502E = "iw7_arclassic_zm+glclassic";
	level.var_A913 = "iw7_g18_zmr";
	level.melee_weapons = [];
	level.force_used_clip = 100;
	level.force_starting_ammo = 280;
}

//Function Number: 2
main()
{
	setdvar("sm_sunSampleSizeNear",2.2);
	setdvar("sm_sunCascadeSizeMultiplier1",4);
	setdvar("sm_sunCascadeSizeMultiplier2",3);
	setdvar("r_sdfShadowPenumbra",0.4);
	setdvar("r_umbraMinObjectContribution",8);
	setdvar("r_umbraAccurateOcclusionThreshold",500);
	setdvar("sm_roundRobinPrioritySpotShadows",8);
	setdvar("sm_spotUpdateLimit",8);
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	level.skeleton_model_override = "dlc4_fullbody_zmb_skeleton";
	level.bslasherdebugger = getdvarint("debug_slasher",0);
	scripts\cp\_utility::coop_mode_enable(["pillage"]);
	scripts\cp\maps\cp_final\cp_final_interactions::structhacks();
	level.all_perk_list = ["perk_machine_boom","perk_machine_flash","perk_machine_fwoosh","perk_machine_more","perk_machine_rat_a_tat","perk_machine_revive","perk_machine_run","perk_machine_smack","perk_machine_tough","perk_machine_zap","perk_machine_change","perk_machine_deadeye"];
	scripts\cp\maps\cp_final\cp_final_precache::main();
	scripts\cp\maps\cp_final\gen\cp_final_art::main();
	scripts\cp\maps\cp_final\cp_final_fx::main();
	level.player_respawn_locations_init = ::init_player_respawn_locations;
	setup_generic_zombie_model_list();
	level.coop_weapontable = "cp/zombies/cp_final_weapontable.csv";
	registerscriptedagents();
	level.var_1094E = undefined;
	lib_0F77::func_13F17();
	level.clown_spawn_fx_func = ::scripts\cp\zombies\cp_final_spawning::func_1B99;
	setuphacks();
	if(level.createfx_enabled)
	{
		return;
	}

	level thread hackfxfan();
	level thread resettrapcooldownseachwave();
	level thread scripts\cp\maps\cp_final\cp_final_mpq::mpq_init();
	level thread scripts\cp\maps\cp_final\cp_final_venomx_quest::venomx_init();
	level.venom_x_weapon_logic_thread = ::scripts\cp\maps\cp_final\cp_final_venomx_quest::venomx_weapon_logic_start;
	level thread scripts\cp\maps\cp_final\cp_final_rhino_boss::rhino_boss_init();
	level thread scripts\cp\maps\cp_final\cp_final_fast_travel::init_teleport_portals();
	level.magic_wheel_spin_hint = &"CP_TOWN_INTERACTIONS_SPIN_WHEEL";
	level.reboard_barriers_hint = &"CP_TOWN_INTERACTIONS_SECURE_WINDOW";
	level.enter_area_hint = &"CP_TOWN_INTERACTIONS_ENTER_THIS_AREA";
	level.needspowerstring = &"CP_FINAL_INTERACTIONS_SYSTEM_OFFLINE";
	level.zombie_ghost_model = "zombie_ghost_green";
	lib_0D2C::init();
	level.map_interaction_func = ::scripts\cp\maps\cp_final\cp_final_interactions::register_interactions;
	level.custom_pillageinitfunc = ::func_CB5A;
	level.custom_onplayerconnect_func = ::func_C56E;
	level.weapon_rank_event_table = "scripts/cp/maps/cp_final/cp_final_weaponrank_event.csv";
	level.player_interaction_monitor = ::scripts\cp\maps\cp_final\cp_final_interactions::level_specific_player_interaction_monitor;
	level.wait_for_interaction_func = ::scripts\cp\maps\cp_final\cp_final_interactions::level_specific_wait_for_interaction_triggered;
	level.auto_melee_agent_type_check = ::auto_melee_agent_type_check;
	level.should_drop_pillage = ::should_drop_pillage;
	level.mutilation_mask_override_func = ::mutilation_mask_func;
	level.interaction_trigger_properties_func = ::interactiontriggerproperties;
	level.should_post_activate_delay_func = ::should_post_activate_delay;
	level.should_run_event_func = ::cp_final_should_run_event;
	level.event_funcs_init = ::cp_final_event_wave_init;
	level.available_event_func = ::cp_final_event_selection;
	level.event_funcs_start = ::cp_final_event_start;
	level.event_funcs_end = ::cp_final_event_end;
	level.ai_cleanup_func = ::scripts\cp\zombies\cp_final_spawning::cp_final_cleanup_main;
	level.spawn_fx_func = ::cp_final_spawn_fx_func;
	level.boss_spawn_func = ::scripts\cp\zombies\cp_final_spawning::cp_final_boss_spawn;
	level.char_intro_music = ::play_char_intro_music;
	level.char_intro_gesture = ::play_char_intro_gesture;
	level.guidedinteractionexclusion = ::guidedinteractionsexclusions;
	level.guided_interaction_offset_func = ::guidedinteractionoffsetfunc;
	level.guidedinteractionendposoverride = ::guidedinteractionendposoverride;
	level.on_zombie_killed_quests_func = ::phantomfloppydiskdrop;
	level.should_spawn_special_zombie_func = ::scripts\cp\zombies\cp_final_spawning::func_FF96;
	level.special_zombie_spawn_func = ::scripts\cp\zombies\cp_final_spawning::choose_agent_type_and_spawn;
	level.initial_weapon_scale_func = ::scripts\cp\maps\cp_final\cp_final_damage::cp_final_initial_weapon_scale;
	level.var_164B = ::cp_final_active_volume_check;
	level.var_107CA = 750;
	level.callbackplayerdamage = ::scripts\cp\maps\cp_final\cp_final_damage::callback_finalzombieplayerdamage;
	level.introscreen_text_func = ::cp_final_introscreen_text;
	level.zombie_health_func = ::scripts\cp\zombies\zombies_spawning::func_3728;
	level.special_zap_start_func = ::cp_final_zap_start_func;
	level.special_zap_end_func = ::cp_final_zap_end_func;
	level.wave_complete_dialogues_func = ::scripts\cp\zombies\cp_final_spawning::wave_complete_vo;
	level.final_wave_vo_func = ::scripts\cp\zombies\cp_final_spawning::special_vo_during_wave;
	level.eligable_for_reward_func = ::cp_final_eligable_for_reward_func;
	level.slasher_loot_func = ::cp_final_slasher_loot_func;
	level.shouldplayeroutline = ::shouldplayeroutline;
	level.should_do_damage_check_func = ::shoulddodamage;
	level thread scripts\cp\maps\cp_final\cp_final_vo::final_vo_init();
	level.purchase_area_vo = ::scripts\cp\maps\cp_final\cp_final_vo::purchase_area_vo;
	level.laststand_enter_levelspecificaction = ::final_last_stand_handler;
	level.afterlife_arcade_set_audio_zone_func = ::delay_set_audio_zone;
	level.afterlife_arcade_unset_audio_zone_func = ::delay_unset_audio_zone;
	level.custom_onspawnplayer_func = ::cp_final_onplayerspawned;
	level.setup_direct_boss_fight_func = ::final_setup_direct_boss_fight_func;
	level.start_direct_boss_fight_func = ::final_start_direct_boss_fight_func;
	level.player_suit = "zom_dlc4_suit";
	level.player_run_suit = "zom_dlc4_suit_sprint";
	level.var_A9FF = ::cp_final_exit_laststand_func;
	level.have_self_revive_override = ::have_self_revive_override;
	scripts\cp\maps\cp_final\cp_final_player_character_setup::init_player_characters();
	level.initial_active_volumes = ["facility_start"];
	level thread setupweaponupgradearray();
	level thread init_weapon_change_funcs();
	level thread scripts\cp\zombies\cp_final_spawning::cp_final_spawning_init();
	level thread wait_for_pre_game_period();
	level thread setup_pap_camos();
	level thread update_one_way_adjacencies();
	level thread init_wall_buys_array();
	level.no_ticket_machine = 1;
	registerlevelenemyarrays();
	scripts\cp\crafted_entangler::init();
	level thread scripts\cp\maps\cp_final\cp_final_turnstile::turnstile_init();
	level thread scripts\cp\maps\cp_final\cp_final_ghost_activation::cp_final_gns_5_setup();
	level thread setup_pa_speakers();
	level.additional_laststand_weapon_exclusion = ["iw7_cpbasketball_mp","iw6_minigunsiege_mp","iw7_cpskeeball_mp","iw7_entangler_zm","iw7_blackholegun_mp","iw7_penetrationrail_mp","iw7_atomizer_mp","iw7_glr_mp","iw7_claw_mp","iw7_steeldragon_mp","iw7_entangler2_zm","iw7_cpclowntoothball_mp","iw7_zshootgallery_mp"];
	level.last_stand_weapons = ["iw7_g18_zm","iw7_g18_zmr","iw7_g18_zml","iw7_g18c_zm","iw7_mag_zm","iw7_revolver_zm","iw7_revolver_zmr","iw7_revolver_zmr_explosive","iw7_revolver_zml","iw7_revolver_zml_single","iw7_emc_zm","iw7_emc_zmr","iw7_emc_zmr_burst","iw7_emc_zml","iw7_emc_zml_spread","iw7_nrg_zm","iw7_nrg_zmr","iw7_nrg_zmr_smart","iw7_nrg_zml","iw7_nrg_zml_charge"];
	level.facilityvolumes = ["facility_start","flood_room","messhall","medical_lab","op_room","planet_outside","cargo"];
	level.totalphantomsjumping = 0;
	level.totalphantomsallowedtojump = 4;
	scripts\cp\maps\cp_final\cp_final_final_boss::init();
	level thread water_triggers();
	level thread watchforalldoorsopened();
	level thread pit_kill_trigger();
	setupslasherteleportpoints();
	level.player_pap_machines = [];
	level thread fix_map_exploits();
	level thread host_migration_handler();
	finalprecache();
	function_026C("MatchStarted: Completed");
}

//Function Number: 3
host_migration_handler()
{
	level endon("game_ended");
	level waittill("host_migration_begin");
	level waittill("host_migration_end");
	if(isdefined(level.current_vision_set))
	{
		var_00 = level.current_vision_set;
	}
	else
	{
		var_00 = "";
	}

	foreach(var_02 in level.players)
	{
		if(!var_02 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		var_02 visionsetnakedforplayer(var_00,1);
	}
}

//Function Number: 4
setup_generic_zombie_model_list()
{
	level.generic_zombie_model_list = ["zombie_dlc4_male_outfit_1","zombie_dlc4_male_outfit_1_b","zombie_dlc4_male_outfit_1_c","zombie_dlc4_male_outfit_2","zombie_dlc4_male_outfit_2_b","zombie_dlc4_male_outfit_2_c","zombie_dlc4_female_outfit_2","zombie_dlc4_female_outfit_2_b","zombie_dlc4_female_outfit_2_c"];
}

//Function Number: 5
setup_era_zombie_model_list()
{
	level.generic_zombie_model_list = ["zombie_dlc4_male_outfit_1","zombie_dlc4_male_outfit_1_b","zombie_dlc4_male_outfit_1_c","zombie_dlc4_male_outfit_2","zombie_dlc4_male_outfit_2_b","zombie_dlc4_male_outfit_2_c","zombie_dlc4_female_outfit_2","zombie_dlc4_female_outfit_2_b","zombie_dlc4_female_outfit_2_c","zombie_dlc4_male_outfit_1","zombie_dlc4_male_outfit_1_b","zombie_dlc4_male_outfit_1_c","zombie_dlc4_male_outfit_2","zombie_dlc4_male_outfit_2_b","zombie_dlc4_male_outfit_2_c","zombie_dlc4_female_outfit_2","zombie_dlc4_female_outfit_2_b","zombie_dlc4_female_outfit_2_c","zombie_female_outfit_1_zmb","zombie_female_outfit_1_b_zmb","zombie_female_outfit_1_c_zmb","zombie_female_outfit_1_2_zmb","zombie_female_outfit_1_2_b_zmb","zombie_female_outfit_1_2_c_zmb","zombie_female_outfit_1_3_zmb","zombie_female_outfit_1_3_b_zmb","zombie_female_outfit_1_3_c_zmb","zombie_male_outfit_2_zmb","zombie_male_outfit_2_c_zmb","zombie_male_outfit_2_2_zmb","zombie_male_outfit_2_2_c_zmb","zombie_male_outfit_2_3_zmb","zombie_male_outfit_2_3_c_zmb","zombie_male_outfit_2_4_zmb","zombie_male_outfit_2_4_c_zmb","zombie_male_outfit_2_5_zmb","zombie_male_outfit_2_5_c_zmb","zombie_male_outfit_2_6_zmb","zombie_male_outfit_2_6_c_zmb","zombie_dlc1_female_outfit_3_rave","zombie_dlc1_female_outfit_3_2_rave","zombie_dlc1_female_outfit_3_3_rave","zombie_dlc1_male_outfit_2_2_rave","zombie_dlc1_male_outfit_2_4_rave","zombie_dlc1_male_outfit_2_6_rave","zombie_dlc1_female_outfit_3_rave","zombie_dlc1_female_outfit_3_2_rave","zombie_dlc1_female_outfit_3_3_rave","zombie_dlc1_male_outfit_2_2_rave","zombie_dlc1_male_outfit_2_4_rave","zombie_dlc1_male_outfit_2_6_rave","zombie_dlc1_female_outfit_3_rave","zombie_dlc1_female_outfit_3_2_rave","zombie_dlc1_female_outfit_3_3_rave","zombie_dlc1_male_outfit_2_2_rave","zombie_dlc1_male_outfit_2_4_rave","zombie_dlc1_male_outfit_2_6_rave","zombie_dlc2_female_outfit_3_disco","zombie_dlc2_female_outfit_3_b_disco","zombie_dlc2_female_outfit_3_c_disco","zombie_dlc2_female_outfit_3_2_disco","zombie_dlc2_female_outfit_3_2_b_disco","zombie_dlc2_female_outfit_3_2_c_disco","zombie_dlc2_female_outfit_3_3_disco","zombie_dlc2_female_outfit_3_3_b_disco","zombie_dlc2_female_outfit_3_3_c_disco","zombie_dlc2_male_outfit_2_disco","zombie_dlc2_male_outfit_2_b_disco","zombie_dlc2_male_outfit_2_c_disco","zombie_dlc2_male_outfit_2_2_disco","zombie_dlc2_male_outfit_2_2_b_disco","zombie_dlc2_male_outfit_2_2_c_disco","zombie_dlc2_male_outfit_2_3_disco","zombie_dlc2_male_outfit_2_3_b_disco","zombie_dlc2_male_outfit_2_3_c_disco","zombie_dlc3_female_outfit_2_town","zombie_dlc3_female_outfit_2_2_town","zombie_dlc3_female_outfit_2_3_town","zombie_dlc3_female_outfit_2_town","zombie_dlc3_female_outfit_2_2_town","zombie_dlc3_female_outfit_2_3_town","zombie_dlc3_female_outfit_2_town","zombie_dlc3_female_outfit_2_2_town","zombie_dlc3_female_outfit_2_3_town","zombie_dlc3_male_soldier_02_town","zombie_dlc3_male_greaser_01_town","zombie_dlc3_male_greaser_02_town","zombie_dlc3_male_soldier_02_town","zombie_dlc3_male_greaser_01_town","zombie_dlc3_male_greaser_02_town","zombie_dlc3_male_soldier_02_town","zombie_dlc3_male_greaser_01_town","zombie_dlc3_male_greaser_02_town","zombie_dlc3_male_soldier_02_town","zombie_dlc3_male_greaser_01_town","zombie_dlc3_male_greaser_02_town"];
}

//Function Number: 6
init_player_respawn_locations()
{
	var_00 = [(-710.375,2862.46,88.125),(-530.446,2919.84,88.125),(-298.821,2921.36,140.123),(-17.5109,2857.1,140.627),(153.965,2855.95,88.125),(245.983,3236.8,24.1279),(-156.418,2933.24,24.1279),(-133.329,3322.01,24.1279),(279.338,3688.93,24.1279),(1268.01,3968.14,16.1231),(1109.93,3389.57,-119.876),(957.966,2863.51,-175.875),(1105.29,2158.62,-176.875),(1992.52,2195.66,-175.874),(1157.69,2077,16.123),(1417.36,1928.05,16.123),(1775.28,1957.53,16.123),(2041.56,3391.34,-175.876),(-94.2012,4326.77,224.124),(-88.2897,5166.86,224.126),(634.858,6081.25,224.129),(1689.66,5873.94,192.121),(2854.95,6446.78,128.124),(4276.24,6957.25,158.134),(4451.24,7847.76,161.747),(3287.03,5429.8,88.3919),(2225.64,4215.86,15.1268),(-498.797,5073.83,-71.8799),(-1172.75,4787.37,-207.376),(-627.745,3686.55,25.127),(-88.2314,5608.86,55.1273),(691.295,6271.88,56.1222),(4896.09,-4072.34,-69.3799),(4205.02,-4381.25,56.5922),(3646.11,-4932,56.8968),(5347.28,-5162.53,59.5922),(6158.73,-5231.12,59.6251),(6360.78,-6415.02,59.5767),(5642.33,-7126.72,59.6216),(4890.99,-6679.08,51.9114),(4963.07,-5986.15,60.125),(3989.1,-3920.09,54.0031)];
	var_01 = [(0,27.8827,0),(0,135.977,0),(0,90.5817,0),(0,89.5709,0),(0,100.497,0),(0,-174.546,0),(0,89.8676,0),(0,1.81214,0),(0,-141.548,0),(0,-175.172,0),(0,-58.5632,0),(0,21.7413,0),(0,57.1777,0),(0,149.633,0),(0,0.85084,0),(0,74.5471,0),(0,108.506,0),(0,-123.443,0),(0,53.4644,0),(0,-5.83434,0),(0,-48.4888,0),(0,154.44,0),(0,-49.071,0),(0,-157.418,0),(0,-136.929,0),(0,100.019,0),(0,86.8903,0),(0,176.313,0),(0,75.4315,0),(0,89.8566,0),(0,-120.598,0),(0,-176.639,0),(0,-66.7755,0),(0,4.08082,0),(0,70.3339,0),(0,162.075,0),(0,-97.691,0),(0,103.628,0),(0,59.776,0),(0,-15.5902,0),(0,-9.10827,0),(0,-106.881,0)];
	var_02 = [];
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		var_02[var_03] = spawnstruct();
		var_02[var_03].origin = var_00[var_03];
		var_02[var_03].angles = var_01[var_03];
		var_02[var_03].var_336 = "player_respawn_loc";
		if(!isdefined(level.var_1115C["targetname"]["player_respawn_loc"]))
		{
			level.var_1115C["targetname"]["player_respawn_loc"] = [];
		}

		level.var_1115C["targetname"]["player_respawn_loc"][level.var_1115C["targetname"]["player_respawn_loc"].size] = var_02[var_03];
	}
}

//Function Number: 7
run_pap_machine_logic(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	wait(3);
	var_01 = getent("pap_machine","targetname");
	var_02 = spawn("script_model",var_01.origin);
	var_02.angles = var_01.angles;
	if(scripts\common\utility::istrue(level.placed_alien_fuses))
	{
		var_02 setmodel("zmb_pap_machine_animated_soul_key");
		var_02 setscriptablepartstate("machine","upgraded");
	}
	else
	{
		var_02 setmodel("zmb_pap_machine_animated_rave");
	}

	var_02 setscriptablepartstate("reels","on");
	var_02 setscriptablepartstate("door","open_idle");
	var_02.var_222 = param_00;
	foreach(var_04 in level.players)
	{
		if(var_04 != param_00)
		{
			var_02 method_8429(var_04);
		}
	}

	level.player_pap_machines[level.player_pap_machines.size] = var_02;
	var_02 thread watch_for_player_connect(param_00);
	var_02 thread cleanup_ent_on_player_disconnect(param_00);
}

//Function Number: 8
cleanup_ent_on_player_disconnect(param_00)
{
	level endon("game_ended");
	param_00 waittill("disconnect");
	if(isdefined(self))
	{
		self delete();
	}

	level.player_pap_machines = scripts\common\utility::func_22BC(level.player_pap_machines);
}

//Function Number: 9
watch_for_player_connect(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	for(;;)
	{
		level waittill("connected",var_01);
		if(var_01 != param_00)
		{
			self method_8429(var_01);
		}
	}
}

//Function Number: 10
finalprecache()
{
	precachempanim("IW7_cp_zom_ghost_trapped_idle");
}

//Function Number: 11
resettrapcooldownseachwave()
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("interactions_initialized");
	for(;;)
	{
		level waittill("wave_starting");
		var_00 = getarraykeys(level.trapcooldownarray);
		foreach(var_02 in var_00)
		{
			level.trapcooldownarray[var_02] = 0;
		}
	}
}

//Function Number: 12
hackfxfan()
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = scripts\common\utility::getstructarray("fx_fan","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = spawnfx(level._effect["vfx_fan_hack"],var_02.origin,anglestoforward(var_02.angles),anglestoup(var_02.angles));
		triggerfx(var_03);
	}
}

//Function Number: 13
init_weapon_change_funcs()
{
	level.weapon_change_func = [];
	level.weapon_change_func["iw7_venomx_zm"] = ::watchvenomxusage;
	level.weapon_change_func["iw7_venomx_zm_pap1"] = ::watchvenomxpap1usage;
	level.weapon_change_func["iw7_venomx_zm_pap2"] = ::watchvenomxpap2usage;
}

//Function Number: 14
func_13A7F(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		param_00 waittill("weapon_change",var_01);
		var_02 = getweaponbasename(var_01);
		if(isdefined(level.weapon_change_func[var_02]))
		{
			param_00 thread [[ level.weapon_change_func[var_02] ]](param_00);
		}
	}
}

//Function Number: 15
setupweaponupgradearray()
{
	level.weapon_upgrade_path = [];
	level.weapon_upgrade_path["iw7_venomx_zm"] = "iw7_venomx_zm_pap1";
	level.weapon_upgrade_path["iw7_venomx_zm_pap1"] = "iw7_venomx_zm_pap2";
}

//Function Number: 16
watchvenomxusage(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 notifyonplayercommand("ads_pressed_in","+speed_throw");
	param_00 notifyonplayercommand("ads_pressed_out","-speed_throw");
	param_00 notifyonplayercommand("ads_pressed_in","+toggleads_throw");
	param_00 notifyonplayercommand("ads_pressed_in","+ads_akimbo_accessible");
	param_00 notifyonplayercommand("ads_pressed_out","-toggleads_throw");
	param_00 notifyonplayercommand("ads_pressed_out","-ads_akimbo_accessible");
	for(;;)
	{
		var_01 = param_00 scripts\common\utility::func_13734("ads_pressed_in","ads_pressed_out");
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 == "ads_pressed_in" || var_01 == "ads_pressed_out")
		{
			param_00 notify("detonate_venomx_projectile_early");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 17
watchvenomxpap1usage(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 notifyonplayercommand("pap1_ads_pressed_in","+speed_throw");
	param_00 notifyonplayercommand("pap1_ads_pressed_out","-speed_throw");
	param_00 notifyonplayercommand("pap1_ads_pressed_in","+toggleads_throw");
	param_00 notifyonplayercommand("pap1_ads_pressed_in","+ads_akimbo_accessible");
	param_00 notifyonplayercommand("pap1_ads_pressed_out","-toggleads_throw");
	param_00 notifyonplayercommand("pap1_ads_pressed_out","-ads_akimbo_accessible");
	for(;;)
	{
		var_01 = param_00 scripts\common\utility::func_13734("pap1_ads_pressed_in","pap1_ads_pressed_out");
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 == "pap1_ads_pressed_in" || var_01 == "pap1_ads_pressed_out")
		{
			param_00 notify("detonate_pap1venomx_projectile_early");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 18
watchvenomxpap2usage(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 notifyonplayercommand("pap2_ads_pressed_in","+speed_throw");
	param_00 notifyonplayercommand("pap2_ads_pressed_out","-speed_throw");
	param_00 notifyonplayercommand("pap2_ads_pressed_in","+toggleads_throw");
	param_00 notifyonplayercommand("pap2_ads_pressed_in","+ads_akimbo_accessible");
	param_00 notifyonplayercommand("pap2_ads_pressed_out","-toggleads_throw");
	param_00 notifyonplayercommand("pap2_ads_pressed_out","-ads_akimbo_accessible");
	for(;;)
	{
		var_01 = param_00 scripts\common\utility::func_13734("pap2_ads_pressed_in","pap2_ads_pressed_out");
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 == "pap2_ads_pressed_in" || var_01 == "pap2_ads_pressed_out")
		{
			param_00 notify("detonate_pap2venomx_projectile_early");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 19
setup_pa_speakers()
{
	level.var_A4BF = "cp/zombies/cp_final_music_genre.csv";
	scripts\cp\zombies\zombie_jukebox::parse_music_genre_table();
	scripts\common\utility::flag_wait("interactions_initialized");
	level thread scripts\cp\zombies\zombie_jukebox::func_A4BE((649,683,254));
	disablepas();
}

//Function Number: 20
registerlevelenemyarrays()
{
	level.ignoreimmune = ["slasher","zombie_ghost","dlc4_boss"];
	level.fnfimmune = ["slasher","zombie_ghost","dlc4_boss","alien_phantom","alien_rhino"];
	level.instakillimmune = ["slasher","zombie_ghost","dlc4_boss","alien_phantom","alien_rhino"];
	level.specialzombie = ["karatemaster","slasher","zombie_ghost","dlc4_boss","alien_goon","alien_phantom","alien_rhino"];
}

//Function Number: 21
wait_for_pre_game_period()
{
	if(!isdefined(level.agent_funcs))
	{
		level.agent_funcs = [];
	}

	level.current_personal_interaction_structs = [];
	wait(0.2);
	scripts\common\utility::flag_set("zombie_drop_powerups");
	scripts\common\utility::flag_set("pillage_enabled");
	lib_0D4D::enable_windows_in_area("facility_start");
	init_magic_wheel();
	if(getdvar("dlc4_boss_fight") == "1" || 0)
	{
		level.debug_boss_fight = 1;
		if(0)
		{
			level.debug_boss_fight_skip_loadout = 1;
		}

		if(0)
		{
			level.debug_boss_fight_loadouts = 1;
		}

		level thread boss_fight_test();
	}

	thread cinematic_thread();
	while(!isdefined(level.interactions))
	{
		wait(1);
	}

	level.interaction_hintstrings["jaroslav_machine_meph"] = &"CP_FINAL_FNF_MEPH";
	scripts\cp\_interaction::func_DEBB("jaroslav_machine_meph","wondercard_machine",0,::lib_0D58::func_A438,::lib_0D58::func_9A2D,0,0);
	level.interaction_hintstrings["meph_perks"] = &"CP_FINAL_MEPH_PERKS";
	scripts\cp\_interaction::func_DEBB("meph_perks","perk",0,undefined,::take_final_fight_perks,0,0);
	level.interaction_hintstrings["start_meph_battle"] = &"CP_FINAL_EXIT_AFTERLIFE";
	scripts\cp\_interaction::func_DEBB("start_meph_battle","perk",0,undefined,::scripts\cp\maps\cp_final\cp_final_final_boss::try_to_leave_bossfight,0,0);
	level.centhub_portal_fx = level._effect["afterlife_portal_fx"];
	thread scripts\cp\maps\cp_final\cp_final_final_boss::pre_bossfight_init();
	scripts\common\utility::flag_wait("interactions_initialized");
	level thread scripts\cp\maps\cp_final\cp_final_rhino_boss::restorelnfinteractions();
}

//Function Number: 22
take_final_fight_perks(param_00,param_01)
{
	if(scripts\cp\zombies\directors_cut::directors_cut_activated_for(param_01) || isdefined(param_01.has_meph_perks))
	{
		if(!param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_revive"))
		{
			if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && self.var_F1E7 < self.max_self_revive_machine_use)
			{
				param_01 lib_0D5D::func_834E("perk_machine_revive",0);
				param_01 playlocalsound("purchase_perk");
			}
			else
			{
				param_01 playlocalsound("purchase_deny");
			}

			return;
		}

		param_01 scripts\cp\_interaction::func_9A3C(param_00,&"CP_FINAL_TAKE_PERK_FAIL");
		param_01 scripts\cp\_interaction::func_DE6E();
		param_01 playlocalsound("purchase_deny");
		return;
	}

	param_01 endon("disconnect");
	param_01 endon("last_stand");
	param_01.has_meph_perks = 1;
	var_02 = ["perk_machine_boom","perk_machine_flash","perk_machine_rat_a_tat","perk_machine_revive","perk_machine_tough"];
	param_01 playlocalsound("purchase_perk");
	foreach(var_04 in var_02)
	{
		if(param_01 scripts\cp\_utility::has_zombie_perk(var_04))
		{
			continue;
		}

		param_01 lib_0D5D::func_834E(var_04,0);
		wait(0.1);
	}

	wait(0.5);
	param_01 playlocalsound(param_01.var_134FD + "pillage_generic");
}

//Function Number: 23
cinematic_thread()
{
	level.movie_playing = "cp_final_screen_640";
	preloadcinematicforall(level.movie_playing);
	scripts\common\utility::flag_wait("neil_head_placed");
	function_030E(level.movie_playing);
}

//Function Number: 24
boss_fight_test()
{
	level.var_13FA3 = 1;
	wait(23);
	if(isdefined(level.fbd) && isdefined(level.fbd.fightstarted) && !level.fbd.fightstarted)
	{
		scripts\cp\maps\cp_final\cp_final_final_boss::start_boss_fight();
	}
}

//Function Number: 25
init_magic_wheel()
{
	level.show_wheel_location_func = ::show_wheel_location;
	var_00 = ["op_room","cargo","planet_outside"];
	scripts\cp\zombies\interaction_magicwheel::set_magic_wheel_starting_location(scripts\common\utility::random(var_00));
	scripts\common\utility::func_5127(3,::show_wheel_location,level.var_B161);
}

//Function Number: 26
show_wheel_location(param_00)
{
	if(isdefined(level.wheel_location_fx))
	{
		level.wheel_location_fx delete();
	}

	var_01 = get_location_struct(param_00);
	if(isdefined(var_01))
	{
		if(!isdefined(var_01.angles))
		{
			var_01.angles = (0,0,0);
		}

		level.wheel_location_fx = spawnfx(level._effect["vfx_zm_mw_icon"],var_01.origin,anglestoforward(var_01.angles),anglestoup(var_01.angles));
		triggerfx(level.wheel_location_fx);
	}
}

//Function Number: 27
get_location_struct(param_00)
{
	var_01 = scripts\common\utility::getstructarray("mw_topdown_locs","targetname");
	if(var_01.size == 0)
	{
		return undefined;
	}

	foreach(var_03 in var_01)
	{
		if(var_03.name == param_00)
		{
			if(var_03.name == "planet_outside" && !isdefined(var_03.adjusted))
			{
				var_03.adjusted = 1;
				var_03.origin = var_03.origin + (-1.5,0.5,0);
			}

			return var_03;
		}
	}

	return undefined;
}

//Function Number: 28
func_CB5A()
{
	level.pillageinfo = spawnstruct();
	level.pillageinfo.default_use_time = 500;
	level.pillageinfo.var_B94E = "pb_money_stack_01";
	level.pillageinfo.var_2487 = "has_spotter_scope";
	level.pillageinfo.var_B47D = "mil_ammo_case_1_open";
	level.pillageinfo.var_4224 = "weapon_baseweapon_clip";
	level.pillageinfo.var_D73C = "misc_interior_card_game_01";
	level.pillageinfo.var_859A = "weapon_m67_grenade";
	level.pillageinfo.ui_searching = 1;
	level.pillageable_powers = [];
	level.pillageable_explosives = ["power_clusterGrenade","power_bioSpike","power_c4","power_frag"];
	level.pillageable_attachments = [];
	level.pillageinfo.clip = 33;
	level.pillageinfo.explosive = 33;
	level.pillageinfo.money = 34;
	lib_0D5E::register_zombie_pillageable("backpack_1","backpack","cp_rave_backpack_dropped","cp_rave_backpack","j_spine4");
	lib_0D5E::register_zombie_pillageable("backpack_2","backpack","cp_rave_backpack_dropped_green","cp_rave_backpack_green","j_spine4");
	lib_0D5E::register_zombie_pillageable("backpack_3","backpack","cp_rave_backpack_dropped_purple","cp_rave_backpack_purple","j_spine4");
	lib_0D5E::register_zombie_pillageable("backpack_4","backpack","cp_rave_backpack_dropped_red","cp_rave_backpack_red","j_spine4");
}

//Function Number: 29
func_C56E(param_00)
{
	if(0)
	{
		toggle_debug_light(param_00);
	}

	param_00 thread run_pap_machine_logic(param_00);
	param_00 thread func_1110F(param_00);
	param_00 thread func_13A7F(param_00);
	param_00 thread start_wire_models_tracking();
	param_00 thread assignpersonalmodelents(param_00);
	param_00 thread watchforplayerzonechange(param_00);
	param_00 thread movepentstostructs(param_00);
	check_cinematic_needed_on_connect();
	level thread watch_player_on_ladders(param_00);
	param_00 thread waittochangehud(param_00);
	param_00 thread show_soul_key_progress(param_00);
	param_00.currentlocation = "facility";
}

//Function Number: 30
show_soul_key_progress(param_00)
{
	param_00 endon("disconnect");
	var_01 = (5116.5,-5006,333);
	var_02 = (0,0,90);
	var_03 = (5113,-5006,347);
	var_04 = (0,0,90);
	var_05 = (5128.5,-5006,354);
	var_06 = (0,0,90);
	var_07 = (5144,-5006,347);
	var_08 = (0,0,90);
	param_00 waittill("spawned_player");
	var_09 = param_00 getplayerdata("cp","haveSoulKeys","soul_key_1");
	var_0A = param_00 getplayerdata("cp","haveSoulKeys","soul_key_2");
	var_0B = param_00 getplayerdata("cp","haveSoulKeys","soul_key_3");
	var_0C = param_00 getplayerdata("cp","haveSoulKeys","soul_key_4");
	if(scripts\common\utility::istrue(var_09))
	{
		playfx(level._effect["soul_jar_d"],var_01,anglestoforward(var_02),anglestoup(var_02),param_00);
	}

	if(scripts\common\utility::istrue(var_0A))
	{
		playfx(level._effect["soul_jar_e"],var_03,anglestoforward(var_04),anglestoup(var_04),param_00);
	}

	if(scripts\common\utility::istrue(var_0B))
	{
		playfx(level._effect["soul_jar_a"],var_05,anglestoforward(var_06),anglestoup(var_06),param_00);
	}

	if(scripts\common\utility::istrue(var_0C))
	{
		playfx(level._effect["soul_jar_t"],var_07,anglestoforward(var_08),anglestoup(var_08),param_00);
	}
}

//Function Number: 31
waittochangehud(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	setomnvar("zm_neil_state",0);
	wait(2);
	if(isdefined(level.currentneilstate))
	{
		scripts\cp\maps\cp_final\cp_final_mpq::setneilstate(level.currentneilstate);
	}
}

//Function Number: 32
watch_player_on_ladders(param_00)
{
	param_00 endon("disconnect");
	param_00.time_on_ladders = 0;
	param_00.time_off_ladders = 0;
	var_01 = 20;
	var_02 = 30;
	var_03 = 10;
	for(;;)
	{
		if(!param_00 method_81B5())
		{
			wait(0.05);
			param_00.time_off_ladders = param_00.time_off_ladders + 0.05;
			if(param_00.time_off_ladders >= var_03)
			{
				param_00.time_off_ladders = 0;
				param_00.time_on_ladders = 0;
			}

			continue;
		}
		else
		{
			param_00.time_off_ladders = 0;
			var_04 = 0;
			while(param_00 method_81B5() && param_00 scripts\cp\_utility::is_valid_player())
			{
				if(param_00.time_on_ladders >= var_01 && !var_04)
				{
					param_00 dodamage(50,param_00.origin);
					wait(0.5);
					param_00 playlocalsound("ww_magicbox_laughter");
					var_04 = 1;
				}

				if(param_00.time_on_ladders >= var_02)
				{
					param_00 playlocalsound("ww_magicbox_laughter");
					wait(1);
					param_00 dodamage(param_00.health + 200,param_00.origin,param_00,param_00,"MOD_MELEE");
					wait(1);
				}

				wait(0.05);
				param_00.time_on_ladders = param_00.time_on_ladders + 0.05;
			}
		}

		wait(0.05);
	}
}

//Function Number: 33
check_cinematic_needed_on_connect()
{
	if(scripts\common\utility::flag("neil_head_placed"))
	{
		function_030E(level.movie_playing);
	}
}

//Function Number: 34
setup_pap_camos()
{
	level.pap_1_camo = "camo32";
	level.pap_2_camo = "camo34";
}

//Function Number: 35
start_wire_models_tracking()
{
	self endon("disconnect");
	wait(15);
	foreach(var_01 in level.wire_models)
	{
		thread scripts\cp\maps\cp_final\cp_final_venomx_quest::update_player_monitor_wires(var_01);
		thread scripts\cp\maps\cp_final\cp_final_venomx_quest::watch_for_input_entered_on_button(var_01);
	}
}

//Function Number: 36
func_1110F(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	param_00 scripts\common\utility::waittill_any_timeout_1(10,"player_spawned");
	scripts\common\utility::flag_wait("wall_buy_setup_done");
	var_01 = [];
	var_02 = scripts\common\utility::getstructarray("interaction","targetname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.name) && var_04.name == "wall_buy")
		{
			var_01[var_01.size] = var_04;
		}
	}

	var_06 = 1;
	for(;;)
	{
		var_07 = 0;
		var_08 = 0;
		var_09 = [self.var_A913];
		var_0A = scripts\common\utility::func_782F(param_00.origin,var_01,undefined,10,5000,0);
		while(var_07 <= var_06 && var_08 < var_0A.size)
		{
			var_0B = scripts\cp\_utility::func_80D8(var_0A[var_08].script_noteworthy);
			if(isdefined(param_00.var_13C00[var_0B]))
			{
				var_0C = param_00.var_13C00[var_0B];
			}
			else
			{
				var_0C = var_0A[var_08].script_noteworthy;
			}

			var_09[var_09.size] = var_0C;
			var_09 = scripts\common\utility::func_22AF(var_09);
			var_07 = var_09.size;
			var_08++;
		}

		param_00 loadweaponsforplayer(var_09);
		wait(1);
	}

	param_00 thread scripts\cp\gametypes\zombie::func_1110F(param_00);
}

//Function Number: 37
registerscriptedagents()
{
	scripts\mp\_mp_agent::init_agent("mp/dlc4_agent_definition.csv");
	level.baliengoondebugger = getdvarint("debug_alien_goon",0);
	level.balienrhinodebugger = getdvarint("debug_alien_rhino",0);
	level.balienphantomdebugger = getdvarint("debug_alien_phantom",0);
	level.bdlc4bossdebugger = getdvarint("debug_dlc4_boss",0);
	level.bclowndebugger = getdvarint("debug_clown",0);
	level.bkaratemasterdebugger = getdvarint("debug_karatemaster",0);
	level.bslasherdebugger = getdvarint("debug_slasher",0);
	level.bskeletondebugger = getdvarint("debug_skeleton",0);
	scripts\mp\agents\zombie_dlc4\zombie_dlc4_agent::registerscriptedagent();
	scripts\mp\agents\alien_goon\alien_goon_agent::registerscriptedagent();
	scripts\mp\agents\alien_rhino\alien_rhino_agent::registerscriptedagent();
	scripts\mp\agents\alien_phantom\alien_phantom_agent::registerscriptedagent();
	scripts\mp\agents\dlc4_boss\dlc4_boss_agent::registerscriptedagent();
	scripts\mp\agents\zombie_skeleton\zombie_skeleton::zombie_skeleton_init();
	scripts\mp\agents\zombie\zmb_zombie_agent::registerscriptedagent();
	level.on_zombie_damaged_func = ::scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiedamaged;
	level.var_C4BE = ::scripts\mp\agents\zombie_dlc4\zombie_dlc4_agent::func_C5D2;
	scripts\mp\agents\karatemaster\karatemaster_agent_dlc4::registerscriptedagent();
	scripts\mp\agents\slasher\slasher_agent_dlc4::registerscriptedagent();
	level.agent_funcs["skeleton"]["on_damaged"] = ::scripts\cp\maps\cp_final\cp_final_damage::cp_final_onzombiedamaged;
}

//Function Number: 38
cp_final_event_wave_init()
{
	level.var_6840["alien_goon_start"] = ::scripts\cp\zombies\cp_final_spawning::start_goon_spawn_event_func;
	level.var_6840["alien_goon"] = ::scripts\cp\zombies\cp_final_spawning::func_8453;
	level.var_6840["zombie_clown"] = ::scripts\cp\zombies\zombies_spawning::func_8453;
	level.var_6840["karatemaster"] = ::scripts\cp\zombies\cp_final_spawning::km_spawn_event_func;
	level.var_6840["slasher"] = ::scripts\cp\zombies\cp_final_spawning::func_8453;
	init_final_spawner_locations();
}

//Function Number: 39
init_final_spawner_locations()
{
	level.var_8457 = [];
	var_00 = scripts\common\utility::getstructarray("dog_spawner","targetname");
	if(isdefined(level.goon_spawner_patch_func))
	{
		[[ level.goon_spawner_patch_func ]](var_00);
	}

	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(!scripts\common\utility::istrue(var_03.remove_me))
		{
			var_01[var_01.size] = var_03;
		}
	}

	var_00 = var_01;
	foreach(var_03 in var_00)
	{
		var_06 = 0;
		foreach(var_08 in level.var_9B0B)
		{
			if(function_010F(var_03.origin,var_08))
			{
				var_06 = 1;
			}
		}

		if(!var_06)
		{
			foreach(var_08 in level.var_10816)
			{
				if(function_010F(var_03.origin,var_08))
				{
					if(!isdefined(var_03.angles))
					{
						var_03.angles = (0,0,0);
					}

					level.var_8457[level.var_8457.size] = var_03;
					var_03.var_13538 = var_08;
					if(!isdefined(var_08.var_8457))
					{
						var_08.var_8457 = [];
					}

					var_08.var_8457[var_08.var_8457.size] = var_03;
					break;
				}
			}
		}
	}
}

//Function Number: 40
cp_final_should_run_event(param_00)
{
	if(param_00 > 0 && !scripts\common\utility::flag("power_on"))
	{
		return 1;
	}

	var_01 = param_00 - level.var_A8BC;
	if(var_01 < 5)
	{
		return 0;
	}
	else
	{
		var_01 = var_01 - 4;
		var_02 = var_01 / 3 * 100;
		if(randomint(100) < var_02)
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	return 0;
}

//Function Number: 41
cp_final_event_selection(param_00)
{
	if(isdefined(level.event_wave_override))
	{
		return level.event_wave_override;
	}

	if(!scripts\common\utility::flag("power_on"))
	{
		if(param_00 > 0)
		{
			return "alien_goon_start";
		}
	}
	else if(!scripts\common\utility::istrue(level.used_portal))
	{
		return "alien_goon";
	}
	else
	{
		return scripts\common\utility::random(["alien_goon","zombie_clown","karatemaster"]);
	}

	return "alien_goon";
}

//Function Number: 42
cp_final_event_start(param_00)
{
	switch(param_00)
	{
		case "zombie_clown":
		case "karatemaster":
		case "alien_goon":
			level thread mus_rave_eventwave_start();
			break;

		default:
			break;
	}
}

//Function Number: 43
mus_rave_eventwave_start()
{
	scripts\cp\_utility::func_D52A("mus_zombies_eventwave_start",(0,0,0));
	level notify("wave_start_sound_done");
}

//Function Number: 44
mus_rave_eventwave_end()
{
}

//Function Number: 45
cp_final_event_end(param_00)
{
	switch(param_00)
	{
		case "clown":
		case "karatemaster":
		case "alien_goon":
			level thread mus_rave_eventwave_end();
			break;

		default:
			break;
	}
}

//Function Number: 46
auto_melee_agent_type_check(param_00)
{
	if(isdefined(param_00.agent_type))
	{
		if(param_00.agent_type == "alien_rhino")
		{
			return 0;
		}

		if(param_00.agent_type == "alien_phantom")
		{
			return 0;
		}

		if(param_00.agent_type == "alien_goon")
		{
			return 0;
		}

		if((scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player)) && param_00.agent_type == "skeleton" && randomint(100) > 75)
		{
			return 0;
		}
	}
	else
	{
		return 0;
	}

	return 1;
}

//Function Number: 47
should_drop_pillage(param_00,param_01)
{
	if(scripts\common\utility::istrue(self.var_54CB))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.flung))
	{
		return 0;
	}

	if(isdefined(self.entered_playspace) && !self.entered_playspace)
	{
		return 0;
	}

	if(!lib_0D5E::is_in_active_volume(param_01))
	{
		return 0;
	}

	if(isdefined(self.hasplayedvignetteanim) && !self.hasplayedvignetteanim)
	{
		return 0;
	}

	if(scripts\cp\_utility::too_close_to_other_interactions(param_01))
	{
		return 0;
	}

	if(isdefined(param_00) && isplayer(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 48
update_one_way_adjacencies()
{
	while(!scripts\common\utility::func_6E34("init_adjacent_volumes_done"))
	{
		wait(0.1);
	}

	scripts\common\utility::flag_wait("init_adjacent_volumes_done");
	level.var_C50A["op_room"]["facility start"] = 1;
}

//Function Number: 49
toggle_debug_light(param_00)
{
	if(param_00 method_8551("debug_light") == "off")
	{
		param_00 setscriptablepartstate("debug_light","active");
		return;
	}

	param_00 setscriptablepartstate("debug_light","off");
}

//Function Number: 50
mutilation_mask_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = undefined;
	var_07 = zombies_should_mutilate(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	return var_07;
}

//Function Number: 51
zombies_should_mutilate(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(scripts\common\utility::istrue(self.is_skeleton))
	{
		return 0;
	}

	var_07 = getweaponbasename(param_01);
	var_08 = param_03 >= 1;
	if(isdefined(param_02))
	{
		switch(param_02)
		{
			case "MOD_PROJECTILE_SPLASH":
			case "MOD_GRENADE":
			case "MOD_GRENADE_SPLASH":
			case "MOD_EXPLOSIVE":
				if(is_mutilate_explosion(param_01))
				{
					if(var_08 && isdefined(param_06) && distance2dsquared(self.origin,param_06.origin) < 1600)
					{
						return 31;
					}
					else
					{
						return 12;
					}
				}
				else
				{
					return 0;
				}
				break;

			case "MOD_MELEE":
				if(!var_08 && isdefined(var_07) && var_07 == "iw7_axe_zm" || var_07 == "iw7_axe_zm_pap1" || var_07 == "iw7_axe_zm_pap2")
				{
					return param_00;
				}
				else
				{
					return 0;
				}
	
				break;

			case "MOD_UNKNOWN":
				return 0;

			default:
				break;
		}
	}

	if(isdefined(param_01))
	{
		var_09 = weaponclass(param_01);
		var_07 = getweaponbasename(param_01);
		if(isdefined(var_09) && var_09 == "spread" && param_02 != "mod_melee")
		{
			if(isdefined(var_07) && var_07 == "iw7_nrg_zm" || var_07 == "iw7_forgefreeze_zm" || var_07 == "iw7_entangler2_zm")
			{
				return 0;
			}

			if(var_08 && isdefined(param_06) && distance2dsquared(self.origin,param_06.origin) < 10000)
			{
				return 31;
			}
			else
			{
				return param_00;
			}
		}

		if(isdefined(var_07))
		{
			switch(var_07)
			{
				case "iw7_chargeshot_zm":
					if(var_08 && isdefined(param_02) && param_02 == "MOD_PROJECTILE")
					{
						return 31;
					}
	
					break;

				case "iw7_cheytac_zm":
				case "iw7_ameli_zm":
				case "iw7_sdflmg_zm":
				case "iw7_unsalmg_zm":
				case "iw7_minilmg_zm":
				case "iw7_mauler_zm":
				case "iw7_lmg03_zm":
				case "iw7_m8_zm":
				case "iw7_kbs_zm":
					return param_00;

				default:
					if(is_arm_or_head_damage(param_00))
					{
						return param_00;
					}
	
					break;
			}
		}
	}

	return 0;
}

//Function Number: 52
is_arm_or_head_damage(param_00)
{
	switch(param_00)
	{
		case 16:
		case 2:
		case 1:
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 53
is_mutilate_explosion(param_00)
{
	if(isdefined(param_00))
	{
		var_01 = getweaponbasename(param_00);
		if(isdefined(var_01))
		{
			switch(var_01)
			{
				case "kineticwave_mp":
				case "iw7_bluebolts_zm":
				case "concussion_grenade_mp":
					return 0;

				default:
					break;
			}
		}
	}

	return 1;
}

//Function Number: 54
cp_final_spawn_fx_func()
{
	if(isdefined(self.spawner.script_fxid))
	{
		switch(self.spawner.script_fxid)
		{
			case "concrete":
				if(!isdefined(self.spawner.last_ground_fx_time))
				{
					self.spawner.last_ground_fx_time = gettime();
					self setscriptablepartstate("spawn_fx_concrete","active");
				}
				else if(self.spawner.last_ground_fx_time + -5536 < gettime())
				{
					self.spawner.last_ground_fx_time = gettime();
					self setscriptablepartstate("spawn_fx_concrete","active");
				}
				else
				{
					self setscriptablepartstate("spawn_fx_dirt","active");
				}
	
				thread dirt_concrete_fx(3);
				thread dirt_fx(6);
				break;

			case "dirt":
				self setscriptablepartstate("spawn_fx_dirt","active");
				thread dirt_fx(6);
				break;

			case "ceiling":
				self setscriptablepartstate("spawn_fx_ceiling","active");
				break;

			case "sand":
				self setscriptablepartstate("spawn_fx_sand","active");
				break;

			case "snow":
				self setscriptablepartstate("spawn_fx_snow","active",1);
				break;

			default:
				break;
		}
	}
}

//Function Number: 55
dirt_fx(param_00)
{
	self endon("death");
	self setscriptablepartstate("dirt","active");
	wait(param_00);
	self setscriptablepartstate("dirt","inactive");
}

//Function Number: 56
dirt_concrete_fx(param_00)
{
	self endon("death");
	self setscriptablepartstate("dirt_concrete","active");
	wait(param_00);
	self setscriptablepartstate("dirt_concrete","inactive");
}

//Function Number: 57
cp_final_zap_start_func(param_00)
{
	self.var_EF64 = 1;
	self method_8286(self.origin);
}

//Function Number: 58
cp_final_zap_end_func(param_00)
{
	self.var_EF64 = 0;
}

//Function Number: 59
interactiontriggerproperties(param_00,param_01,param_02)
{
	if(isdefined(param_01.script_noteworthy))
	{
		switch(param_01.script_noteworthy)
		{
			case "iw7_mag_zm":
			case "iw7_longshot_zm":
			case "iw7_kbs_zm":
				self.var_9A3F method_83D6(1);
				self.var_9A3F method_84A5(270);
				break;

			case "pap_portal":
			case "construct_bridge":
			case "entangler_button":
			case "pap_fusebox":
			case "puzzle_pieces":
				self.var_9A3F method_83D6(0);
				self.var_9A3F method_84A5(360);
				break;

			case "dash_interaction":
			case "dot_interaction":
				self.var_9A3F method_83D6(0);
				self.var_9A3F method_84A5(70);
				break;

			case "rhino_console":
			case "rhino_ammo_crate":
			case "rhino_sentry":
			case "pap_bridge":
			case "neil_head_final_pos":
				self.var_9A3F method_83D6(1);
				self.var_9A3F method_84A5(360);
				break;

			case "electric_trap":
				self.var_9A3F method_84A5(180);
				break;
		}
	}
}

//Function Number: 60
should_post_activate_delay(param_00)
{
	if(param_00.script_noteworthy == "entangler_button")
	{
		return 0;
	}

	return 1;
}

//Function Number: 61
validateplayspace(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01) || !isalive(param_01))
	{
		param_01 = level.players[0];
	}

	if(!isdefined(param_04))
	{
		param_04 = 12;
	}

	var_05 = 1;
	if(!ispointonnavmesh(param_00) && distance(getclosestpointonnavmesh(param_00),param_00) > param_04)
	{
		var_05 = 0;
	}
	else if(!scripts\common\utility::istrue(param_02) && isdefined(level.var_164B) && !self [[ level.var_164B ]](param_00))
	{
		var_05 = 0;
	}
	else if(!scripts\common\utility::istrue(param_03) && param_01 method_8428(param_01.origin,param_00,0,0).size < 1)
	{
		var_05 = 0;
	}
	else if(isdefined(level.debug_origin_array) && param_01 method_8428(param_00,scripts\common\utility::getclosest(param_00,level.debug_origin_array).origin,0,0).size < 1)
	{
		var_05 = 0;
	}

	if(!var_05)
	{
		thread scripts\cp\_utility::debugprintline("Entity at: " + param_01.origin + " is not in valid play space.");
	}
	else
	{
		thread scripts\cp\_utility::debugprintline("Entity at: " + param_01.origin + " is in valid play space.");
	}

	return var_05;
}

//Function Number: 62
play_char_intro_music()
{
	if(self issplitscreenplayer() && !self issplitscreenplayerprimary())
	{
		return;
	}

	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		return;
	}

	self playlocalsound(self.intro_music);
}

//Function Number: 63
play_char_intro_gesture()
{
	thread scripts\cp\_utility::firegesturegrenade(self,self.intro_gesture);
	wait(waitgesturelength());
	self notify("finish_intro_gesture");
}

//Function Number: 64
waitgesturelength()
{
	switch(self.var_134FD)
	{
		case "p1_":
			return self method_8443("ges_load_in_arx");

		case "p2_":
			return self method_8443("ges_load_in_arx");

		case "p3_":
			return self method_8443("ges_load_in_arx");

		case "p4_":
			return self method_8443("ges_load_in_arx");

		case "p5_":
			return self method_8443("ges_load_in_arx");

		default:
			return 3;
	}
}

//Function Number: 65
guidedinteractionsexclusions(param_00,param_01,param_02)
{
	if(!isdefined(level.interactions[param_00.script_noteworthy]))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(level.interactions[param_00.script_noteworthy].disable_guided_interactions))
	{
		return 0;
	}

	if(!isdefined(param_00.script_noteworthy) || param_00.script_noteworthy == "puzzle")
	{
		return 0;
	}

	if(isdefined(param_02))
	{
		switch(param_02)
		{
			default:
				break;
		}
	}

	if(scripts\cp\_interaction::interactionislostandfound(param_00) && !scripts\common\utility::istrue(param_01.var_8C46))
	{
		return 0;
	}

	if(isdefined(param_00.script_noteworthy))
	{
		switch(param_00.script_noteworthy)
		{
			case "weapon_upgrade":
				if(!scripts\common\utility::istrue(param_01.var_9C54))
				{
					return 0;
				}
				break;

			default:
				break;
		}
	}

	if(isdefined(param_00.var_86A2) && param_00.var_86A2 == "challenge")
	{
		return 0;
	}

	if(isdefined(param_00.script_label))
	{
	}

	return 1;
}

//Function Number: 66
guidedinteractionendposoverride(param_00,param_01)
{
	var_02 = (0,0,0);
	var_03 = scripts\cp\_interaction::func_7829(param_01);
	if(isdefined(param_01.script_noteworthy))
	{
		var_04 = param_01.script_noteworthy;
		switch(var_04)
		{
			case "facility_sliding_door_750":
				if(var_03 == "medical_lab")
				{
					var_02 = (0,0,24);
				}
				break;

			case "facility_sliding_door_1000":
				if(var_03 == "flood_room")
				{
					var_02 = (0,0,64);
				}
				break;

			case "blackhole_trap":
				var_02 = (0,0,24);
				break;

			case "iw7_vr_zm":
				if(var_03 == "cargo")
				{
					var_02 = (0,0,56);
				}
				break;

			default:
				var_02 = (0,0,0);
				break;
		}
	}

	return param_01.origin + var_02;
}

//Function Number: 67
guidedinteractionoffsetfunc(param_00,param_01)
{
	var_02 = (0,0,56);
	var_03 = scripts\cp\_interaction::func_7829(param_00);
	if(isdefined(param_00.script_noteworthy))
	{
		var_04 = param_00.script_noteworthy;
		switch(var_04)
		{
			case "blackhole_trap":
				var_02 = (0,0,24);
				break;

			case "iw7_mag_zm":
				if(var_03 == "facility_start")
				{
					var_02 = (0,0,34);
				}
				break;

			case "iw7_nrg_zm":
				if(var_03 == "facility_start")
				{
					var_02 = (0,0,64);
				}
				break;

			case "iw7_crb_zml":
				if(var_03 == "flood_room")
				{
					var_02 = (0,0,64);
				}
				break;

			case "iw7_sdfshotty_zm":
				if(var_03 == "op_room")
				{
					var_02 = (0,0,30);
				}
				break;

			case "iw7_m8_zm":
				if(var_03 == "op_room")
				{
					var_02 = (0,0,74);
				}
				break;

			case "iw7_sdfar_zm":
				if(var_03 == "op_room")
				{
					var_02 = (0,0,36);
				}
				break;

			case "iw7_chargeshot_zm":
				if(var_03 == "cargo")
				{
					var_02 = (0,0,48);
				}
				break;

			case "iw7_longshot_zm":
				if(var_03 == "messhall")
				{
					var_02 = (0,0,50);
				}
				break;

			case "iw7_gauss_zm":
				if(var_03 == "planet_outside")
				{
					var_02 = (0,0,36);
				}
				break;

			case "iw7_crdb_zm":
				if(var_03 == "theater_main")
				{
					var_02 = (0,0,68);
				}
				break;

			case "iw7_erad_zm":
				if(var_03 == "messhall")
				{
					var_02 = (0,0,50);
				}
				break;

			case "iw7_vr_zm":
				if(var_03 == "cargo")
				{
					var_02 = (0,0,72);
				}
				break;

			default:
				var_02 = (0,0,56);
				break;
		}
	}

	return var_02;
}

//Function Number: 68
assignpersonalmodelents(param_00)
{
	param_00.personalents = [];
	for(var_01 = 0;var_01 < 20;var_01++)
	{
		var_02 = spawn("script_model",(0,0,-5000));
		var_02.var_C3A2 = (0,0,-5000);
		var_02 setmodel("tag_origin");
		var_02.var_3FF2 = 0;
		var_02.var_1305B = 0;
		param_00.personalents[param_00.personalents.size] = var_02;
	}

	level thread deletepentsondisconnect(param_00);
}

//Function Number: 69
deletepentsondisconnect(param_00)
{
	level endon("game_ended");
	param_00 waittill("disconnect");
	foreach(var_02 in param_00.personalents)
	{
		var_02 delete();
	}
}

//Function Number: 70
addtopersonalinteractionlist(param_00)
{
	level.current_personal_interaction_structs = scripts\common\utility::array_add(level.current_personal_interaction_structs,param_00);
}

//Function Number: 71
removefrompersonalinteractionlist(param_00)
{
	level.current_personal_interaction_structs = scripts\common\utility::func_22A9(level.current_personal_interaction_structs,param_00);
}

//Function Number: 72
movepentstostructs(param_00)
{
	param_00 endon("disconnect");
	if(!scripts\common\utility::flag("init_interaction_done"))
	{
		scripts\common\utility::flag_wait("init_interaction_done");
	}

	var_01 = scripts\common\utility::istrue(param_00.kung_fu_mode);
	for(;;)
	{
		param_00.mode_updating = 1;
		var_02 = 0;
		var_03 = 0;
		if(scripts\common\utility::istrue(param_00.kung_fu_mode) != var_01)
		{
			var_01 = scripts\common\utility::istrue(param_00.kung_fu_mode);
			var_03 = 1;
		}

		var_04 = scripts\common\utility::func_782F(param_00.origin,level.current_personal_interaction_structs,undefined,100);
		if(var_04.size > 0)
		{
			var_04 = removeinvalidstructs(var_04,param_00);
			var_04 = sortbydistance(var_04,param_00.origin);
			param_00 resetents(param_00,var_04);
			foreach(var_06 in var_04)
			{
				var_07 = undefined;
				if(isdefined(var_06.target))
				{
					var_07 = scripts\common\utility::getstruct(var_06.target,"targetname");
				}

				var_08 = 0;
				if(var_06 hasplayerentattached(param_00,var_06))
				{
					var_09 = getattachedpersonalent(param_00,var_06);
					if(isdefined(var_09))
					{
						if(var_03)
						{
							if(isdefined(var_06.script_noteworthy) && isdefined(level.normal_mode_activation_funcs[var_06.script_noteworthy]))
							{
								var_08 = 1;
								if(isdefined(var_07))
								{
									var_09 [[ level.normal_mode_activation_funcs[var_06.script_noteworthy] ]](var_09,var_07,0,param_00);
								}
								else
								{
									var_09 thread [[ level.normal_mode_activation_funcs[var_06.script_noteworthy] ]](var_09,var_06,0,param_00);
								}
							}
							else if(isdefined(var_06.normal_model))
							{
								var_09 setmodel(var_06.normal_model);
							}
						}
						else if(isdefined(var_06.script_noteworthy) && isdefined(level.normal_mode_activation_funcs[var_06.script_noteworthy]))
						{
							var_08 = 1;
							if(isdefined(var_07))
							{
								var_09 [[ level.normal_mode_activation_funcs[var_06.script_noteworthy] ]](var_09,var_07,1,param_00);
							}
							else
							{
								var_09 thread [[ level.normal_mode_activation_funcs[var_06.script_noteworthy] ]](var_09,var_06,1,param_00);
							}
						}
					}

					continue;
				}

				var_09 = getunclaimedpersonalent(param_00,var_04);
				if(isdefined(var_09))
				{
					var_09 setcandamage(0);
					var_06.currentlyownedby[param_00.name] = var_09;
					var_09.var_3FF2 = 1;
					var_09.var_1305B = 1;
					var_09 dontinterpolate();
					if(isdefined(var_06.target))
					{
						var_07 = scripts\common\utility::getstruct(var_06.target,"targetname");
						var_09.origin = var_07.origin;
						if(isdefined(var_07.angles))
						{
							var_09.angles = var_07.angles;
						}
						else
						{
							var_09.angles = (0,0,0);
						}
					}
					else
					{
						var_09.origin = var_06.origin;
						if(isdefined(var_06.angles))
						{
							var_09.angles = var_06.angles;
						}
						else
						{
							var_09.angles = (0,0,0);
						}
					}

					if(scripts\common\utility::istrue(param_00.kung_fu_mode))
					{
						if(isdefined(var_06.script_noteworthy) && isdefined(level.special_mode_activation_funcs[var_06.script_noteworthy]))
						{
							var_08 = 1;
							if(isdefined(var_07))
							{
								var_09 [[ level.special_mode_activation_funcs[var_06.script_noteworthy] ]](var_09,var_07,0,param_00);
							}
							else
							{
								var_09 thread [[ level.special_mode_activation_funcs[var_06.script_noteworthy] ]](var_09,var_06,0,param_00);
							}
						}
						else if(isdefined(var_06.kung_fu_model))
						{
							var_09 setmodel(var_06.kung_fu_model);
						}
					}
					else if(isdefined(var_06.script_noteworthy) && isdefined(level.normal_mode_activation_funcs[var_06.script_noteworthy]))
					{
						var_08 = 1;
						if(isdefined(var_07))
						{
							var_09 [[ level.normal_mode_activation_funcs[var_06.script_noteworthy] ]](var_09,var_07,0,param_00);
						}
						else
						{
							var_09 thread [[ level.normal_mode_activation_funcs[var_06.script_noteworthy] ]](var_09,var_06,0,param_00);
						}
					}
					else if(isdefined(var_06.normal_model))
					{
						var_09 setmodel(var_06.normal_model);
					}

					adjustmodelvis(param_00,var_09);
				}
			}
		}

		param_00.mode_updating = undefined;
		param_00 notify("rave_mode_updated");
		param_00 scripts\common\utility::waittill_any_return_no_endon_death_3("zone_change","rave_status_changed","rave_interactions_updated");
	}
}

//Function Number: 73
update_special_mode_for_player(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	while(scripts\common\utility::istrue(param_00.mode_updating))
	{
		scripts\common\utility::func_136F7();
	}

	waittillframeend;
	param_00 notify("rave_interactions_updated");
}

//Function Number: 74
resetents(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00.personalents)
	{
		var_05 = 0;
		foreach(var_07 in param_01)
		{
			if(isdefined(var_07.playeroffset) && isdefined(var_07.playeroffset[param_00.name]))
			{
				if(var_04.origin == var_07.playeroffset[param_00.name])
				{
					var_05 = 1;
					break;
				}
			}

			if(isdefined(var_07.target))
			{
				var_08 = scripts\common\utility::getstruct(var_07.target,"targetname");
				if(var_04.origin == var_08.origin)
				{
					var_05 = 1;
					break;
				}

				continue;
			}

			if(var_04.origin == var_07.origin)
			{
				var_05 = 1;
				break;
			}
		}

		if(!var_05)
		{
			var_04 resetpersonalent(var_04);
		}
	}

	scripts\common\utility::func_136F7();
}

//Function Number: 75
removeinvalidstructs(param_00,param_01)
{
	var_02 = [];
	param_00 = sortbydistance(param_00,param_01.origin);
	if(!isdefined(param_00))
	{
		return;
	}

	foreach(var_04 in param_00)
	{
		if(isdefined(param_01.var_55BB) && scripts\common\utility::func_2286(param_01.var_55BB,var_04))
		{
			continue;
		}

		if(isdefined(var_04.target))
		{
			var_05 = scripts\common\utility::getstructarray(var_04.var_336,"targetname");
			foreach(var_07 in var_05)
			{
				if(isdefined(var_07.target) && var_07.target == var_04.target)
				{
					param_00 = scripts\common\utility::func_22A9(param_00,var_07);
				}
			}

			var_02[var_02.size] = var_04;
			if(var_02.size >= 20)
			{
				break;
			}

			continue;
		}

		var_02[var_02.size] = var_04;
		if(var_02.size >= 20)
		{
			break;
		}
	}

	return var_02;
}

//Function Number: 76
is_in_active_volume(param_00)
{
	if(!isdefined(level.var_1646))
	{
		return 1;
	}

	var_01 = sortbydistance(level.var_1646,param_00);
	foreach(var_03 in var_01)
	{
		if(function_010F(param_00,var_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 77
hasplayerentattached(param_00,param_01)
{
	foreach(var_03 in param_00.personalents)
	{
		if(isdefined(param_01.playeroffset) && isdefined(param_01.playeroffset[param_00.name]))
		{
			if(var_03.origin == param_01.playeroffset[param_00.name])
			{
				var_03.var_1305B = 1;
				return 1;
			}
		}

		if(isdefined(param_01.target))
		{
			var_04 = scripts\common\utility::getstruct(param_01.target,"targetname");
			if(var_03.origin == var_04.origin)
			{
				var_03.var_1305B = 1;
				return 1;
			}
		}

		if(var_03.origin == param_01.origin)
		{
			var_03.var_1305B = 1;
			return 1;
		}
	}

	return 0;
}

//Function Number: 78
adjustmodelvis(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 == param_00)
		{
			param_01 showtoplayer(var_03);
			continue;
		}

		param_01 method_8429(var_03);
	}
}

//Function Number: 79
resetpersonalents(param_00,param_01)
{
	foreach(var_03 in param_00.personalents)
	{
		if(scripts\common\utility::istrue(param_01))
		{
			var_03 thread resetpersonalent(var_03);
			continue;
		}

		if(scripts\common\utility::istrue(var_03.var_1305B))
		{
			var_03.var_1305B = 0;
			continue;
		}

		var_03 thread resetpersonalent(var_03);
	}

	scripts\common\utility::func_136F7();
}

//Function Number: 80
resetpersonalent(param_00)
{
	param_00 setmodel("tag_origin");
	param_00.var_3FF2 = 0;
	param_00.var_1305B = 0;
	param_00 dontinterpolate();
	param_00.origin = param_00.var_C3A2;
	param_00 notify("p_ent_reset");
}

//Function Number: 81
getattachedpersonalent(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00.personalents)
	{
		if(isdefined(param_01.playeroffset) && isdefined(param_01.playeroffset[param_00.name]))
		{
			if(var_04.origin == param_01.playeroffset[param_00.name])
			{
				return var_04;
			}
		}

		if(isdefined(param_01.target))
		{
			var_05 = scripts\common\utility::getstruct(param_01.target,"targetname");
			if(var_04.origin == var_05.origin)
			{
				return var_04;
			}
		}

		if(var_04.origin == param_01.origin)
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 82
getunclaimedpersonalent(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00.personalents)
	{
		var_05 = 0;
		foreach(var_07 in param_01)
		{
			if(isdefined(var_07.playeroffset) && isdefined(var_07.playeroffset[param_00.name]))
			{
				if(var_04.origin == var_07.playeroffset[param_00.name])
				{
					var_05 = 1;
					break;
				}
			}

			if(isdefined(var_07.target))
			{
				var_08 = scripts\common\utility::getstruct(var_07.target,"targetname");
				if(var_04.origin == var_08.origin)
				{
					var_05 = 1;
					break;
				}
			}

			if(var_04.origin == var_07.origin)
			{
				var_05 = 1;
				break;
			}
		}

		if(!var_05)
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 83
watchforplayerzonechange(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	scripts\common\utility::flag_wait("init_interaction_done");
	var_01 = getent("zone_change","targetname");
	if(isdefined(var_01))
	{
		for(;;)
		{
			if(param_00 istouching(var_01))
			{
				param_00 notify("rave_status_changed");
				wait(1);
				continue;
			}
			else
			{
				wait(0.1);
			}
		}
	}
}

//Function Number: 84
phantomfloppydiskdrop(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isphantom() && !scripts\common\utility::flag("phantom_disk_drop"))
	{
		level thread dropfloppydisk(self,param_01);
	}
}

//Function Number: 85
isphantom()
{
	return isdefined(self.agent_type) && self.agent_type == "alien_phantom";
}

//Function Number: 86
dropfloppydisk(param_00,param_01)
{
	var_02 = param_00.origin + (0,0,24);
	var_03 = spawn("script_model",var_02);
	var_03.angles = (0,0,0);
	var_03 setmodel("tag_origin_puzzle_piece");
	var_03 setscriptablepartstate("puzzle_pieces",level.phantomdisk);
	var_04 = var_02 + (0,0,24);
	var_03 physicslaunchserver(var_02,var_04);
	for(;;)
	{
		var_05 = var_03.origin;
		var_06 = var_03.angles;
		wait(0.1);
		if(distance(var_05,var_03.origin) < 2 && var_06 == var_03.angles)
		{
			break;
		}
	}

	var_03 method_851B();
	var_03.angles = (0,var_03.angles[1],0);
	if(validateplayspace(var_03.origin,param_01))
	{
		scripts\common\utility::flag_set("phantom_disk_drop");
		creatediskinteraction(var_03);
		return;
	}

	if(validateplayspace(param_01.origin,param_01))
	{
		var_03.origin = scripts\common\utility::func_5D14(param_01.origin,12,-128);
		scripts\common\utility::flag_set("phantom_disk_drop");
		creatediskinteraction(var_03);
		return;
	}

	var_03 scripts\cp\_weapon::func_CC16("floppy_disk",1,var_03.origin,var_03.angles);
	var_03 delete();
}

//Function Number: 87
creatediskinteraction(param_00)
{
	var_01 = spawnstruct();
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_01.script_noteworthy = "puzzle_pieces";
	var_01.var_336 = "interaction";
	var_01.var_E1B9 = 0;
	var_01.var_D776 = 1;
	var_01.var_EE79 = "default";
	var_01.var_10E19 = level.phantomdisk;
	var_01.model = param_00;
	level.var_1115C["targetname"]["interaction"][level.var_1115C["targetname"]["interaction"].size] = var_01;
	level.var_1115C["script_noteworthy"]["puzzle_pieces"][level.var_1115C["script_noteworthy"]["puzzle_pieces"].size] = var_01;
	playfx(level._effect["generic_pickup"],var_01.origin + (0,0,24));
	scripts\cp\_interaction::add_to_current_interaction_list(var_01);
}

//Function Number: 88
water_triggers()
{
	var_00 = getentarray("water_trigger","targetname");
	scripts\common\utility::array_thread(var_00,::water_trigger);
}

//Function Number: 89
water_trigger()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isplayer(var_00))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_00.in_afterlife_arcade) || isdefined(var_00.in_water))
		{
			if(scripts\common\utility::istrue(var_00.var_9D81))
			{
				var_00 notify("force_cancel_placement");
				var_00 playlocalsound("ww_magicbox_laughter");
			}

			continue;
		}

		if(!isalive(var_00))
		{
			continue;
		}

		var_00.in_water = 1;
		var_00 thread monitor_player_in_water(self);
	}
}

//Function Number: 90
monitor_player_in_water(param_00)
{
	self endon("disconnect");
	if(scripts\cp\_laststand::player_in_laststand(self))
	{
		self.in_water = undefined;
		if(scripts\cp\_laststand::self_revive_activated())
		{
			reset_water_values();
			return;
		}

		if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && scripts\cp\_utility::has_zombie_perk("perk_machine_revive"))
		{
			reset_water_values();
			return;
		}

		reset_water_values();
		return;
	}

	scripts\common\utility::func_1C40(0);
	scripts\common\utility::func_1C60(0);
	scripts\common\utility::func_1C64(0);
	while(self istouching(param_00))
	{
		if(scripts\cp\_laststand::player_in_laststand(self))
		{
			self.in_water = undefined;
			if(scripts\cp\_laststand::self_revive_activated())
			{
				reset_water_values();
				return;
			}

			if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && scripts\cp\_utility::has_zombie_perk("perk_machine_revive"))
			{
				reset_water_values();
				return;
			}
		}

		wait(0.05);
	}

	reset_water_values();
}

//Function Number: 91
reset_water_values()
{
	if(scripts\common\utility::istrue(self.var_55C3))
	{
		scripts\common\utility::func_1C40(1);
	}

	if(scripts\common\utility::istrue(self.var_55DC))
	{
		scripts\common\utility::func_1C60(1);
	}

	if(scripts\common\utility::istrue(self.var_55E0))
	{
		scripts\common\utility::func_1C64(1);
	}

	self.in_water = undefined;
}

//Function Number: 92
cp_final_eligable_for_reward_func(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_04.agent_type) && param_04.agent_type == "alien_phantom")
	{
		return 0;
	}

	return 1;
}

//Function Number: 93
cp_final_active_volume_check(param_00)
{
	if(isdefined(level.meph_fight_started))
	{
		return 1;
	}

	if(!isdefined(level.var_1646))
	{
		return 1;
	}

	var_01 = sortbydistance(level.var_1646,param_00);
	foreach(var_03 in var_01)
	{
		if(function_010F(param_00,var_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 94
cp_final_exit_laststand_func(param_00)
{
	param_00 scripts\cp\powers\coop_powers::func_E2D1(param_00,param_00.var_D7CD);
	param_00 lib_0D5B::func_F53F(param_00,"healthy");
	param_00.flung = undefined;
	param_00 setclientomnvar("zm_ui_player_in_laststand",0);
	param_00 method_8070(0.5);
	param_00 scripts\cp\_utility::stoplocalsound_safe("zmb_laststand_music");
	param_00 method_8070(0.3);
	if(isdefined(level.var_13445))
	{
		param_00 thread scripts\cp\gametypes\zombie::func_E20F(0.2);
	}

	param_00 visionsetnakedforplayer("",0);
	var_01 = randomintrange(1,5);
	var_02 = "zmb_revive_music_lr_0" + var_01;
	if(soundexists(var_02))
	{
		param_00 playlocalsound(var_02);
	}

	if(param_00 scripts\cp\_utility::func_9E3A())
	{
		param_00 scripts\cp\_utility::func_1C5C(0);
	}

	if(scripts\common\utility::istrue(param_00.have_permanent_perks) && !scripts\common\utility::istrue(param_00.playing_ghosts_n_skulls))
	{
		param_00 thread scripts\cp\gametypes\zombie::give_permanent_perks(param_00);
	}

	if(scripts\common\utility::istrue(level.meph_fight_started))
	{
		if(isdefined(param_00.var_F1E5) && param_00.var_F1E5 > 0)
		{
			scripts\cp\_laststand::func_557F(param_00);
		}
	}
}

//Function Number: 95
have_self_revive_override(param_00)
{
	if(scripts\common\utility::istrue(level.meph_fight_started))
	{
		return param_00 scripts\cp\_utility::func_9BA0("self_revive") && !scripts\common\utility::istrue(param_00.disable_self_revive_fnf);
	}

	return param_00 scripts\cp\_utility::has_zombie_perk("perk_machine_revive") || param_00 scripts\cp\_utility::func_9BA0("self_revive") && !scripts\common\utility::istrue(param_00.disable_self_revive_fnf);
}

//Function Number: 96
setupslasherteleportpoints()
{
	level.slasherteleportpoints = [];
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-763.096,2932.43,88.125);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-86.6098,2821.48,140.123);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-271.863,3916.64,116.126);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-48.2376,3694.55,24.1319);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-0.312063,2863.88,24.1319);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-540.489,4124.97,-70.873);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-491.627,4699.13,-207.375);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1125.62,4943.22,-207.375);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-886.284,5410.85,-71.8799);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-138.956,5215.65,56.123);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (763.939,5989.08,56.1221);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (885.454,6224.87,56.1221);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-243.133,3999.05,224.125);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (251.009,3002.64,24.1279);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (301.9,5828.11,55.124);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (522.446,3941.74,24.1279);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1716.39,4245.89,16.1231);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1578.08,4164.05,132.127);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (588.637,5739.52,224.124);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-74.9128,5177.15,224.124);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1188.91,5935.99,192.121);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1238.23,6325.17,188.127);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1983.1,6154.77,53.3216);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2847.13,6464.34,128.124);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (3211.37,5360.48,85.1315);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2147.4,5589.08,36.0474);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1799.45,3579.26,16.1241);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1026.09,2509.85,-175.875);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2110.64,2627.55,-295.873);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1309.31,3329.39,-295.873);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1427.89,2222.42,-295.873);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1424.06,3597.79,-175.876);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1380.62,1893.22,16.123);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2.12145,4452.89,88.125);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1465.48,3724.93,16.1231);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1029.05,4156.71,132.127);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1410.12,1961.46,-175.876);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (969.395,3077.33,-175.876);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1184.6,5330.2,56.1224);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1645.95,6025.87,56.1224);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (3457.42,7660.43,159.056);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (4395.63,6938.52,166.909);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2556.4,6502.01,128.124);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2208.05,5137.75,78.2488);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (4628.7,-4212.29,-8.83374);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (5058.08,-4925.53,59.6211);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (4933.16,-5866.15,60.125);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (5574.22,-6221.36,60.125);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (5185.66,-6343.28,59.6211);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (5614.86,-7142.93,59.6211);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (6123.36,-6027.08,59.5575);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (5645.58,-5412.81,68.0706);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (3744.17,-4921.51,58.7204);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (4011.46,-4596.49,64.975);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (5724.94,-5699.07,60.125);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (6388.87,-5997.56,59.5046);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (508.512,5309.78,88.125);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-887.158,5096.47,-71.8796);
}

//Function Number: 97
watchforalldoorsopened()
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("interactions_initialized");
	scripts\common\utility::flag_wait("init_interaction_done");
	scripts\common\utility::flag_wait("doors_initialized");
	var_00 = level.allslidingdoors.size / 2;
	var_01 = level.door_trigs.size - 1;
	var_02 = var_01 + var_00;
	var_03 = 0;
	for(;;)
	{
		level waittill("door_opened_notify");
		var_03++;
		if(var_03 >= var_02)
		{
			foreach(var_05 in level.players)
			{
				var_05 scripts\cp\_merits::func_D9AD("mt_dlc4_all_doors");
			}

			break;
		}
	}
}

//Function Number: 98
disablepas()
{
	disablepaspeaker("pa_facility");
	disablepaspeaker("pa_facility_rhino_room");
	disablepaspeaker("pa_meph");
	disablepaspeaker("pa_theater");
}

//Function Number: 99
enablepas()
{
	enablepaspeaker("pa_facility");
	enablepaspeaker("pa_facility_rhino_room");
	enablepaspeaker("pa_meph");
	enablepaspeaker("pa_theater");
}

//Function Number: 100
enablepa(param_00)
{
	enablepaspeaker(param_00);
}

//Function Number: 101
disablepa(param_00)
{
	disablepaspeaker(param_00);
}

//Function Number: 102
cp_final_introscreen_text()
{
	var_00 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_FINAL_INTRO_LINE_1",1);
	wait(1);
	var_01 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_FINAL_INTRO_LINE_2",2);
	wait(1);
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight() && !scripts\cp\zombies\direct_boss_fight::is_meph_fight())
	{
		var_02 = scripts\cp\_hud_util::introscreen_corner_line(&"DIRECT_BOSS_FIGHT_LINE4_FINAL",3);
	}
	else if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight() && scripts\cp\zombies\direct_boss_fight::is_meph_fight())
	{
		var_02 = scripts\cp\_hud_util::introscreen_corner_line(&"DIRECT_BOSS_FIGHT_LINE4_DC",3);
	}
	else
	{
		var_02 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_FINAL_INTRO_LINE_3",3);
	}

	wait(1);
	var_03 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_FINAL_INTRO_LINE_4",4);
	wait(3);
	var_00 fadeovertime(3);
	var_01 fadeovertime(3);
	var_02 fadeovertime(3);
	var_03 fadeovertime(3);
	var_00.alpha = 0;
	var_01.alpha = 0;
	var_02.alpha = 0;
	var_03.alpha = 0;
	var_00 destroy();
	var_01 destroy();
	var_02 destroy();
	var_03 destroy();
}

//Function Number: 103
init_wall_buys_array()
{
	level.wall_buy_interactions = [];
	var_00 = scripts\common\utility::getstructarray("interaction","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.name) && var_02.name == "wall_buy")
		{
			level.wall_buy_interactions[level.wall_buy_interactions.size] = var_02;
		}
	}
}

//Function Number: 104
pit_kill_trigger()
{
	var_00 = getent("player_kill_trig","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		var_02 = self;
		var_03 = self;
		var_04 = 100;
		var_05 = "MOD_TRIGGER_HURT";
		var_06 = undefined;
		var_07 = self.origin;
		var_08 = "none";
		var_09 = undefined;
		var_01 scripts\cp\_damage::onplayertouchkilltrigger(var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
	}
}

//Function Number: 105
shoulddodamage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(scripts\common\utility::istrue(param_05.nodamage))
	{
		return 0;
	}

	return 1;
}

//Function Number: 106
shouldplayeroutline(param_00,param_01)
{
	if(isdefined(param_00.currentlocation) && isdefined(param_01.currentlocation) && param_00.currentlocation != param_01.currentlocation)
	{
		return 0;
	}

	return 1;
}

//Function Number: 107
cp_final_slasher_loot_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(level.no_loot_drop) || !level.no_loot_drop)
	{
		var_09 = scripts\common\utility::random(["ammo_max","instakill_30","cash_2","instakill_30","cash_2","instakill_30","cash_2"]);
		if(isdefined(var_09) && !isdefined(self.var_72AC))
		{
			if(!isdefined(level.brute_loot_check[self.spawn_round_num]))
			{
				level.brute_loot_check[self.spawn_round_num] = 1;
				level thread scripts\cp\zombies\_powerups::drop_loot(self.origin,param_01,var_09,undefined,undefined,1);
			}
		}

		var_0A = 400;
		foreach(var_0C in level.players)
		{
			var_0C scripts\cp\_persistence::func_82F9(var_0A);
			var_0C scripts\cp\_merits::func_D9AD("mt_dlc4_special_wave_kills");
			var_0C scripts\cp\_utility::func_316C("kill_event_buffered",param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,self.agent_type);
		}
	}
}

//Function Number: 108
nudge_turret_interaction()
{
	var_00 = scripts\common\utility::getstructarray("rhino_sentry","targetname");
	var_01 = scripts\common\utility::getclosest((2913,2313,-26),var_00);
	var_01.origin = var_01.origin + (-16,0,-4);
}

//Function Number: 109
fix_map_exploits()
{
	level thread invalid_place_watcher();
	add_invalid_place((2925,2364.5,-67),(0,250,0),32);
	add_invalid_place((2964.5,2365.5,-67),(0,250,0),32);
	add_invalid_place((3031,2850.5,-76),(0,-250,0),32);
	add_invalid_place((3072,2850.5,-76.5),(0,-250,0),32);
	var_00 = spawn("script_model",(2892,2258,-138));
	var_00 setmodel("player128x64x8");
	var_00.angles = (0,0,-90);
	var_01 = spawn("script_model",(4863.5,-3923,40));
	var_01 setmodel("player512x512x8");
	var_01.angles = (90,351.5,37.5);
	var_02 = spawn("script_model",(5661.5,-3919,32));
	var_02 setmodel("player512x512x8");
	var_02.angles = (90,65.5,6);
	var_00 = spawn("script_model",(3162.5,3328,-16));
	var_00 setmodel("player128x128x8");
	var_00.angles = (90,0,0);
	var_00 = spawn("script_model",(3100,2796,-18));
	var_00 setmodel("player128x128x8");
	var_00.angles = (-90,0,0);
	var_03 = getentarray("rhino_spawn_door_3_clip","targetname");
	var_04 = scripts\common\utility::getclosest((3052,3086.5,-125),var_03);
	var_04.var_336 = "rhino_spawn_door_4_clip";
	var_05 = getentarray("rhino_sentry_door_clip","targetname");
	var_04 = scripts\common\utility::getclosest((2943.5,2957.25,-135.5),var_05);
	var_04.var_336 = "rhino_sentry_door_2_clip";
}

//Function Number: 110
add_invalid_place(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = spawnstruct();
	var_04.origin = param_00;
	var_04.var_381 = param_01;
	var_04.distcheck = param_02 * param_02;
	var_04.dolaugh = param_03;
	level.invalid_orgs[level.invalid_orgs.size] = var_04;
}

//Function Number: 111
invalid_place_watcher()
{
	level.invalid_orgs = [];
	while(level.invalid_orgs.size == 0)
	{
		wait(0.1);
	}

	for(;;)
	{
		foreach(var_01 in level.invalid_orgs)
		{
			foreach(var_03 in level.players)
			{
				if(distancesquared(var_03.origin,var_01.origin) <= var_01.distcheck)
				{
					if(var_01.dolaugh)
					{
						var_03 playlocalsound("ww_magicbox_laughter");
					}

					var_03 setvelocity(var_01.var_381);
				}
			}

			wait(0.05);
		}

		wait(0.1);
	}
}

//Function Number: 112
final_last_stand_handler(param_00)
{
	if(param_00 scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		if(!scripts\common\utility::istrue(param_00.have_self_revive))
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("laststand","zmb_comment_vo");
			return;
		}

		if(isdefined(param_00.times_self_revived))
		{
			if(param_00.times_self_revived > 3)
			{
				param_00 thread scripts\cp\_vo::try_to_play_vo("laststand","zmb_comment_vo");
				return;
			}

			return;
		}
	}
}

//Function Number: 113
delay_set_audio_zone(param_00)
{
	param_00 endon("disconnect");
	wait(1);
	param_00 method_82C0("cp_zmb_afterlife_lg_room",0.5);
}

//Function Number: 114
delay_unset_audio_zone(param_00)
{
	param_00 endon("disconnect");
	wait(1);
	param_00 method_8070(0.5);
}

//Function Number: 115
cp_final_onplayerspawned()
{
	if((scripts\common\utility::func_6E34("start_rhino_sequence") && scripts\common\utility::flag("start_rhino_sequence")) || scripts\common\utility::istrue(level.meph_fight_started))
	{
		scripts\cp\_utility::allow_player_teleport(0);
	}
}

//Function Number: 116
final_setup_direct_boss_fight_func()
{
	level.var_13FA3 = 1;
	level.var_4481 = [];
	if(scripts\cp\zombies\direct_boss_fight::is_meph_fight())
	{
		level.boss_fight_post_portal_tube_func = ::freeze_player_control_post_portal_tube;
	}

	if(!scripts\common\utility::func_6E34("phantom_disk_drop"))
	{
		scripts\common\utility::flag_init("phantom_disk_drop");
	}

	scripts\common\utility::flag_set("phantom_disk_drop");
	level thread direct_boss_fight_player_connect_monitor();
}

//Function Number: 117
final_start_direct_boss_fight_func()
{
	level notify("starting_direct_boss_fight");
	foreach(var_01 in level.players)
	{
		var_01 thread delay_unset_audio_zone(var_01);
	}

	if(scripts\cp\zombies\direct_boss_fight::is_meph_fight())
	{
		level notify("start_rhino_fight");
		scripts\cp\maps\cp_final\cp_final_final_boss::spawn_meph();
		scripts\cp\maps\cp_final\cp_final_final_boss::func_10B89(level.dlc4_boss);
		return;
	}

	level thread scripts\cp\maps\cp_final\cp_final_rhino_boss::start_rhino_fight();
}

//Function Number: 118
freeze_player_control_post_portal_tube(param_00)
{
	param_00 setplayerangles(vectortoangles((-13314,-337,-48) - param_00.origin));
	param_00 freezecontrols(1);
}

//Function Number: 119
direct_boss_fight_player_connect_monitor()
{
	level endon("game_ended");
	level endon("starting_direct_boss_fight");
	foreach(var_01 in level.players)
	{
		var_01 thread delay_set_audio_zone(var_01);
	}

	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread delay_set_audio_zone(var_01);
	}
}