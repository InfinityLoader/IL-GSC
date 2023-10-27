/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_rave\cp_rave.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 325
 * Decompile Time: 16577 ms
 * Timestamp: 10/27/2023 12:06:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("sm_sunSampleSizeNear",0.705);
	setdvar("r_volumetricsBulbAttenClamp",250);
	setdvar("r_umbraMinObjectContribution",8);
	setdvar("r_umbraAccurateOcclusionThreshold",4000);
	setdvar("sm_roundRobinPrioritySpotShadows",8);
	setdvar("sm_spotUpdateLimit",8);
	setdvar("groundPound_minActivateHeight",32);
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	setdvar("r_lightGridEnableTweaks",1);
	setdvar("r_lightGridIntensity",1.33);
	level.blumberjackdebugger = getdvarint("debug_lumberjack",0);
	level.bsasquatchdebugger = getdvarint("debug_sasquatch",0);
	level.bsuperslasherdebugger = getdvarint("debug_superslasher",0);
	level.bslasherdebugger = getdvarint("debug_slasher",0);
	registerscriptedagents();
	level.custom_onplayerconnect_func = ::func_4772;
	setminimap("",3072,3072,-3072,-3072);
	scripts\cp\_weapon_autosentry::init();
	scripts\cp\zombies\craftables\_zm_soul_collector::init();
	scripts\cp\zombies\craftables\_electric_trap::init();
	scripts\cp\crafted_trap_mower::init();
	scripts\cp\crafted_trap_balloons::init();
	scripts\cp\zombies\craftables\_boombox::init();
	scripts\cp\zombies\craftables\_revocator::init();
	lib_0F4F::main();
	scripts\cp\maps\cp_rave\gen\cp_rave_art::main();
	lib_0F4E::main();
	rave_precache();
	if(level.createfx_enabled)
	{
		return;
	}

	level.player_suit = "zom_dlc1_suit";
	level.player_run_suit = "zom_dlc1_suit_sprint";
	level.use_adjacent_volumes = 1;
	level.slasher_visible_in_normal_mode = 0;
	level.avoidance_radius = 8;
	level.scriptablestatefunc = ::scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate;
	level.custom_pillageinitfunc = ::func_4773;
	level.introscreen_text_func = ::func_4771;
	level.get_alias_2d_func = ::cp_rave_get_alias_2d_version;
	level.special_character_count = 0;
	level.map_interaction_func = ::scripts\cp\maps\cp_rave\cp_rave_interactions::register_interactions;
	level.wait_for_interaction_func = ::scripts\cp\maps\cp_rave\cp_rave_interactions::cp_rave_wait_for_interaction_triggered;
	level.player_interaction_monitor = ::scripts\cp\maps\cp_rave\cp_rave_interactions::cp_rave_interaction_monitor;
	level.callbackplayerdamage = ::scripts\cp\maps\cp_rave\cp_rave_damage::callback_ravezombieplayerdamage;
	level.coop_weapontable = "cp/cp_rave_weapontable.csv";
	level.var_107CA = 750;
	level.should_continue_progress_bar_think = ::func_4774;
	level.drop_max_ammo_func = ::scripts\cp\zombies\_powerups::drop_loot;
	level.var_D751 = ::scripts\cp\maps\cp_rave\cp_rave_powers::init;
	level.cac_vo_male = scripts\common\utility::array_randomize(["p1_","p3_"]);
	level.cac_vo_female = scripts\common\utility::array_randomize(["p2_"]);
	level.spawn_fx_func = ::cp_rave_spawn_fx_func;
	level.initial_active_volumes = ["front_gate"];
	level.door_properties_func = ::setup_rave_mode_door;
	level.var_2416 = 0;
	level.perk_registration_func = ::registerraveperks;
	level.lethaldamage_func = ::cp_rave_lethaldamage_func;
	level.onzombiedamage_func = ::cp_rave_onzombiedamage_func;
	level.var_6619 = ::func_6619;
	level.var_695D = ::func_695D;
	level.guidedinteractionexclusion = ::guidedinteractionsexclusions;
	level.guided_interaction_offset_func = ::guidedinteractionoffsetfunc;
	level.var_A9FF = ::cp_rave_exit_laststand_func;
	level.var_BC70 = ::cp_rave_updatemovespeedscale;
	level.auto_melee_agent_type_check = ::cp_rave_auto_melee_agent_type_check;
	level.custom_weaponnamestring_func = ::rave_getweaponnamestring;
	level.no_clown_spawn = 1;
	level.goon_spawner_patch_func = ::cp_rave_goon_spawner_patch_func;
	level.patch_update_spawners = ::cp_rave_patch_update_spawners;
	level.custom_epehermal_attachment_func = ::rave_ephemeral_attachment;
	level.custom_epehermal_weapon_func = ::rave_ephemeral_weapon;
	level.custom_ephermal_camo_func = ::rave_ephemeral_camo;
	level.event_funcs_init = ::cp_rave_event_wave_init;
	level.available_event_func = ::cp_rave_event_selection;
	level.event_funcs_start = ::cp_rave_event_start;
	level.event_funcs_end = ::cp_rave_event_end;
	level.should_run_event_func = ::cp_rave_should_run_event;
	level.ai_cleanup_func = ::scripts\cp\zombies\cp_rave_spawning::cp_rave_cleanup_main;
	level.should_do_damage_check_func = ::cp_rave_should_do_damage_check_func;
	level.var_4ADE = "kill_near_crystal";
	level.memory_quest_items = [];
	level.harpoon_projectiles = [];
	level.player_pap_machines = [];
	level.challenge_registration_func = ::scripts\cp\maps\cp_rave\cp_rave_challenges::register_default_challenges;
	level.challenge_scalar_func = ::scripts\cp\maps\cp_rave\cp_rave_challenges::challenge_scalar_func;
	level.custom_death_challenge_func = ::scripts\cp\maps\cp_rave\cp_rave_challenges::default_death_challenge_func;
	level.custom_playerdamage_challenge_func = ::scripts\cp\maps\cp_rave\cp_rave_challenges::default_playerdamage_challenge_func;
	level.death_challenge_update_func = ::scripts\cp\zombies\solo_challenges::func_12DA9;
	level.challenge_init_func = ::scripts\cp\zombies\solo_challenges::init_solo_challenges;
	level.char_intro_gesture = ::play_char_intro_gesture;
	level.mutilation_mask_override_func = ::cp_rave_mutilation_mask_func;
	level.char_intro_music = ::play_char_intro_music;
	level.harpoon_impale_additional_func = ::scripts\cp\_weapon::harpoon_impale_additional_func;
	level.purchase_area_vo = ::scripts\cp\maps\cp_rave\cp_rave_vo::purchase_area_vo;
	level.aa_ww_char_vo = ::scripts\cp\zombies\zombie_afterlife_arcade::choose_correct_vo_for_player;
	level.aa_memoirs_vo = ::scripts\cp\zombies\zombie_afterlife_arcade::play_ww_vo_memoirs;
	level.setup_direct_boss_fight_func = ::rave_setup_direct_boss_fight_func;
	level.start_direct_boss_fight_func = ::rave_start_direct_boss_fight_func;
	level.is_valid_spawn_weapon_func = ::rave_is_valid_spawn_weapon_func;
	level.get_fists_weapon_func = ::get_char_fist_weapon;
	level.enable_slasher_weapon = ::scripts\cp\maps\cp_rave\cp_rave_interactions::enable_slasher_weapon;
	level thread setupinvalidvolumes();
	level thread cp_rave_gns_2_setup();
	level thread show_sym_pap();
	level thread scripts\cp\maps\cp_rave\cp_rave_vo::rave_vo_init();
	scripts\cp\maps\cp_rave\cp_rave_player_character_setup::init_player_characters();
	level thread wait_for_pre_game_period();
	level.additional_laststand_weapon_exclusion = ["iw7_cpbasketball_mp","iw7_cpskeeball_mp","iw7_cpclowntoothball_mp","iw7_horseracepistol_zm_blue","iw7_horseracepistol_zm_yellow","iw7_horseracepistol_zm_red","iw7_horseracepistol_zm_green","iw7_shootgallery_zm","iw7_blackholegun_mp","iw7_penetrationrail_mp","iw7_atomizer_mp","iw7_glr_mp","iw7_claw_mp","iw7_steeldragon_mp","iw7_shootgallery_zm_blue","iw7_shootgallery_zm_yellow","iw7_shootgallery_zm_red","iw7_lawnmower_zm","iw7_shootgallery_zm_green"];
	level.last_stand_weapons = ["iw7_g18_zm","iw7_g18_zmr","iw7_g18_zml","iw7_g18c_zm","iw7_mag_zm","iw7_revolver_zm","iw7_revolver_zmr","iw7_revolver_zmr_explosive","iw7_revolver_zml","iw7_revolver_zml_single","iw7_emc_zm","iw7_emc_zmr","iw7_emc_zmr_burst","iw7_emc_zml","iw7_emc_zml_spread","iw7_nrg_zm","iw7_nrg_zmr","iw7_nrg_zmr_smart","iw7_nrg_zml","iw7_nrg_zml_charge","iw7_dischord_zm","iw7_headcutter_zm","iw7_shredder_zm","iw7_facemelter_zm","iw7_dischord_zm_pap1","iw7_headcutter_zm_pap1","iw7_shredder_zm_pap1","iw7_facemelter_zm_pap1","iw7_golf_club_mp_pap1","iw7_two_headed_axe_mp_pap1","iw7_spiked_bat_mp_pap1","iw7_machete_mp_pap1","iw7_golf_club_mp_pap2","iw7_two_headed_axe_mp_pap2","iw7_spiked_bat_mp_pap2","iw7_machete_mp_pap2","iw7_golf_club_mp","iw7_two_headed_axe_mp","iw7_spiked_bat_mp","iw7_machete_mp"];
	level.melee_weapons = ["iw7_machete_mp","iw7_golf_club_mp","iw7_two_headed_axe_mp","iw7_spiked_bat_mp","iw7_golf_club_mp_pap1","iw7_two_headed_axe_mp_pap1","iw7_spiked_bat_mp_pap1","iw7_machete_mp_pap1","iw7_golf_club_mp_pap2","iw7_two_headed_axe_mp_pap2","iw7_spiked_bat_mp_pap2","iw7_machete_mp_pap2","iw7_slasher_zm"];
	level.weapon_rank_event_table = "scripts/cp/maps/cp_rave/cp_rave_weaponrank_event.csv";
	scripts\cp\maps\cp_rave\cp_rave_crafting::set_crafting_starting_location("cabin_to_lake");
	scripts\cp\maps\cp_rave\cp_rave_crafting::init_crafting();
	setup_generic_zombie_model_list();
	level thread scripts\cp\zombies\interaction_rave_openareas::init_all_debris_and_door_positions();
	level thread setup_slide();
	level thread water_triggers();
	level thread setup_pap_camos();
	level thread scripts\cp\maps\cp_rave\cp_rave_interactions::setup_rave_dust_interactions();
	level thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::init_super_slasher_quest();
	level thread scripts\cp\maps\cp_rave\cp_rave_harpoon_quest::harpoon_quest_init();
	level thread scripts\cp\maps\cp_rave\cp_rave_j_mem_quest::j_mem_quest_init();
	level.var_D99D = ::rave_processenemykilledfunc;
	level.kill_reward_func = ::cp_rave_kill_reward;
	level.someones_in_rave = 0;
	level.slasher_level = 1;
	level.lumberjack_spawn_percent = 2;
	level.active_kill_quests = [];
	level.no_slasher = 0;
	level.custom_onspawnplayer_func = ::cp_rave_onplayerspawned;
	level.wave_complete_dialogues_func = ::wave_complete_dialogues;
	level.power_vo_func = ::rave_power_on_vo;
	level.magic_wheel_spin_hint = &"CP_RAVE_SPIN_WHEEL";
	level.reboard_barriers_hint = &"CP_RAVE_SECURE_WINDOW";
	level.enter_area_hint = &"CP_RAVE_ENTER_THIS_AREA";
	level thread setup_pa_speakers();
	init_weapon_change_funcs();
	init_wall_buys_array();
	init_rave_quests();
	adjust_player_spawn_pos();
	scripts\cp\maps\cp_rave\cp_rave_interactions::disable_slasher_weapon();
	level thread harpoon_upgrade_quest();
	level thread survivor_logic();
	level thread adjust_struct_positions();
	level thread rockwall_logic();
	level thread adjust_portal_location();
	level thread adjust_computer_interaction_pos();
	level thread setup_harpoon_cabinet_weapons();
	level thread b_man_head_tracking();
	level thread setup_glyph_targets();
	level thread setup_pool_balls();
	level thread watch_ee_song_quest_complete();
	level thread init_zombie_heads();
	level thread remove_door_ala();
	level.interaction_trigger_properties_func = ::rave_set_interaction_trigger_properties;
	scripts\cp\maps\cp_rave\cp_rave_memory_quests::rave_charm_mapping();
	scripts\cp\maps\cp_rave\cp_rave_memory_quests::init_memory_quests();
	scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::init_weapon_upgrade();
	scripts\cp\powers\coop_armageddon::init_armageddon();
	level thread scripts\cp\zombies\cp_rave_doors::rave_trap_door();
	level thread spawn_afterlife_speaker();
	level.no_ticket_machine = 1;
	level thread adjust_doorbuy_triggers();
	level.lnf_sign = getent("lost_found_island","targetname");
	if(isdefined(level.lnf_sign))
	{
		level.lnf_sign hide();
	}

	level thread setup_water_respawn_points();
	level thread show_pap_symbols();
	level thread fix_map_exploits();
	function_026C("MatchStarted: Completed");
}

//Function Number: 2
fix_map_exploits()
{
	level thread invalid_place_watcher();
	add_invalid_place((-1501,1764,-18),(0,250,0),32);
	add_invalid_place((-1471,1804,-18),(0,250,0),32);
	add_invalid_place((-1440.5,1844.5,-18),(0,250,0),32);
	add_invalid_place((-1409,1884.5,-18),(0,250,0),32);
	add_invalid_place((-1388,1912,-18),(0,250,0),32);
	add_invalid_place((-1368,1936.5,-18),(0,250,0),32);
	var_00 = spawn("script_model",(0,0,0));
	var_01 = spawn("script_model",(0,0,0));
	var_02 = spawn("script_model",(0,0,0));
	var_00 clonebrushmodeltoscriptmodel(getent("playerai128x128x8","targetname"));
	var_01 clonebrushmodeltoscriptmodel(getent("playerai128x128x8","targetname"));
	var_02 clonebrushmodeltoscriptmodel(getent("player64x64x8","targetname"));
	var_00.origin = (-2003.5,1365,-83);
	var_00.angles = (-90,45,0);
	var_01.origin = (-2425.5,-4892,393);
	var_01.angles = (-90,195,0);
	var_02.origin = (-1871.3,-4394,414);
	var_02.angles = (90,180,-150);
}

//Function Number: 3
add_invalid_place(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.origin = param_00;
	var_05.var_381 = param_01;
	var_05.distcheck = param_02 * param_02;
	var_05.moveplayer = param_03;
	var_05.moveplayerspot = param_04;
	level.invalid_orgs[level.invalid_orgs.size] = var_05;
}

//Function Number: 4
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
					var_03 playlocalsound("ww_magicbox_laughter");
					var_03 setvelocity(var_01.var_381);
				}
			}

			wait(0.25);
		}

		wait(0.5);
	}
}

//Function Number: 5
setup_pap_camos()
{
	level.pap_1_camo = "camo204";
	level.pap_2_camo = "camo205";
	level.no_pap_camos = ["harpoon","iw7_harpoon1_zm","iw7_harpoon2_zm","iw7_harpoon3_zm","iw7_harpoon4_zm","harpoon1","harpoon2","harpoon3","harpoon4","slasher","axe","two","golf","machete","spiked"];
}

//Function Number: 6
show_pap_symbols()
{
	wait(10);
	scripts\common\utility::exploder(21);
	wait(0.05);
	scripts\common\utility::exploder(22);
	wait(0.05);
	scripts\common\utility::exploder(23);
	wait(0.05);
	scripts\common\utility::exploder(24);
	wait(0.05);
	scripts\common\utility::exploder(25);
	wait(0.05);
	scripts\common\utility::exploder(26);
	wait(0.05);
}

//Function Number: 7
adjust_portal_location()
{
	wait(5);
	var_00 = scripts\common\utility::getstruct("selfrevive_portal","targetname");
	var_00.origin = var_00.origin + (0,7,11);
}

//Function Number: 8
setup_water_respawn_points()
{
	wait(10);
	level.water_respawn_points = [];
	setup_water_respawn_point((-4896,6128,-134.1));
	setup_water_respawn_point((-4800,6128,-133.8));
	setup_water_respawn_point((-4512,6192,-137.6));
	setup_water_respawn_point((-4288,6000,-129.2));
	setup_water_respawn_point((-4960,6144,-135.6));
	setup_water_respawn_point((-4432,6160,-135.6));
	setup_water_respawn_point((-3728,4384,-133.1));
	setup_water_respawn_point((-4336,6096,-132.7));
	setup_water_respawn_point((-4272,5872,-133.3));
	setup_water_respawn_point((-3792,4320,-135.5));
	setup_water_respawn_point((-4272,5760,-134.9));
	setup_water_respawn_point((-4272,5632,-133.8));
	setup_water_respawn_point((-4256,5456,-133.4));
	setup_water_respawn_point((-4208,5312,-132.3));
	setup_water_respawn_point((-4160,5248,-133.3));
	setup_water_respawn_point((-4096,5152,-134.4));
	setup_water_respawn_point((-4048,5072,-130.5));
	setup_water_respawn_point((-3968,5008,-126.3));
	setup_water_respawn_point((-3856,4944,-114.1));
	setup_water_respawn_point((-3712,4880,-110.4));
	setup_water_respawn_point((-3568,4720,-117));
	setup_water_respawn_point((-3584,4560,-123.4));
	setup_water_respawn_point((-3664,4448,-127.2));
	setup_water_respawn_point((-3856,4192,-140));
	setup_water_respawn_point((-3920,4064,-140));
	setup_water_respawn_point((-4048,4000,-140));
	setup_water_respawn_point((-4176,3936,-140));
	setup_water_respawn_point((-4304,3936,-140));
	setup_water_respawn_point((-4368,3872,-140));
	setup_water_respawn_point((-4496,3808,-140));
	setup_water_respawn_point((-1984,2000,-123.4));
	setup_water_respawn_point((-2112,1936,-123.4));
	setup_water_respawn_point((-2112,1808,-123.4));
	setup_water_respawn_point((-2112,1680,-123.4));
	setup_water_respawn_point((-2112,1744,-123.4));
	setup_water_respawn_point((-2144,1616,-123.4));
	setup_water_respawn_point((-2272,1616,-123.4));
	setup_water_respawn_point((-2432,1584,-123.4));
	setup_water_respawn_point((-2464,1488,-123.4));
	setup_water_respawn_point((-2400,1392,-123.4));
	setup_water_respawn_point((-2400,1296,-123.4));
	setup_water_respawn_point((-2080,1968,-123.4));
	setup_water_respawn_point((-2112,1872,-123.4));
	setup_water_respawn_point((1536,16,4.6));
	setup_water_respawn_point((1472,16,4.6));
	setup_water_respawn_point((1408,16,4.6));
	setup_water_respawn_point((1344,48,4.6));
	setup_water_respawn_point((1248,80,4.6));
	setup_water_respawn_point((1176,72,4.6));
	setup_water_respawn_point((1074,40,4.6));
}

//Function Number: 9
spawn_water_trigger(param_00)
{
	var_01 = spawn("trigger_radius",param_00,0,175,128);
	var_01.var_336 = "water_trigger";
}

//Function Number: 10
setup_water_respawn_point(param_00)
{
	var_01 = spawnstruct();
	var_01.origin = param_00;
	level.water_respawn_points[level.water_respawn_points.size] = var_01;
}

//Function Number: 11
super_slasher_barrier_test()
{
	for(var_00 = 30;var_00 > 0;var_00--)
	{
		wait(1);
		iprintlnbold("=== " + var_00);
	}

	for(;;)
	{
		scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::activate_super_slasher_barrier(1);
		wait(10);
		scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::activate_super_slasher_barrier(2);
		wait(10);
		scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::activate_super_slasher_barrier(3);
		wait(10);
		scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::activate_super_slasher_barrier(4);
		wait(10);
	}
}

//Function Number: 12
rave_power_on_vo(param_00)
{
	level endon("gamed_ended");
	param_00 endon("death");
	param_00 endon("disconnect");
	if(scripts\common\utility::func_6E34("canFiresale"))
	{
		scripts\common\utility::flag_set("canFiresale");
	}

	switch(param_00.var_134FD)
	{
		case "p1_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("poweron_first_chola_1","rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["poweron_first_chola_1"] = 1;
			break;

		case "p4_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("poweron_first_hiphop_1","rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["poweron_first_hiphop_1"] = 1;
			break;

		case "p3_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("poweron_first_rocker_1","rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["poweron_first_rocker_1"] = 1;
			break;

		case "p2_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("poweron_first_raver_1","rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["poweron_first_raver_1"] = 1;
			break;

		default:
			break;
	}
}

//Function Number: 13
watch_ee_song_quest_complete()
{
	level endon("gamed_ended");
	level endon("song_ee_achievement_given");
	for(;;)
	{
		scripts\common\utility::func_136F7();
		if(!isdefined(level.total_glyphs_found) && !isdefined(level.total_glyphs_to_find))
		{
			continue;
		}

		if(level.total_glyphs_found == level.total_glyphs_to_find)
		{
			foreach(var_01 in level.players)
			{
				var_01 lib_0D2A::func_12D7C("RAVE_ON",1);
			}

			level notify("add_hidden_song_to_playlist");
			level thread play_hidden_song((1785,-2077,211),"mus_pa_rave_hidden_track");
			level notify("song_ee_achievement_given");
			continue;
		}

		continue;
	}
}

//Function Number: 14
play_hidden_song(param_00,param_01)
{
	level endon("game_ended");
	if(param_01 == "mus_pa_rave_hidden_track")
	{
		level endon("add_hidden_song_to_playlist");
	}

	if(soundexists(param_01))
	{
		wait(2.5);
		foreach(var_03 in level.players)
		{
			if(scripts\common\utility::istrue(level.onlinegame))
			{
				var_03 setplayerdata("cp","hasSongsUnlocked","any_song",1);
				if(param_01 == "mus_pa_rave_hidden_track")
				{
					var_03 setplayerdata("cp","hasSongsUnlocked","song_3",1);
				}
			}
		}

		var_05 = undefined;
		if(isdefined(var_05))
		{
			level thread scripts\cp\_vo::try_to_play_vo(var_05,"zmb_dj_vo","high",60,1,0,1);
			var_06 = lookupsoundlength(var_05) / 1000;
			wait(var_06);
		}

		scripts\common\utility::play_sound_in_space("zmb_jukebox_on",param_00);
		var_07 = spawn("script_origin",param_00);
		var_08 = "ee";
		var_09 = 1;
		foreach(var_03 in level.players)
		{
			var_03 scripts\cp\_persistence::give_player_xp(500,1);
		}

		var_07 playloopsound(param_01);
		var_07 thread scripts\cp\zombies\zombie_jukebox::earlyendon(var_07);
		var_0C = lookupsoundlength(param_01) / 1000;
		level scripts\common\utility::waittill_any_timeout_1(var_0C,"skip_song");
		var_07 stoploopsound();
		var_07 delete();
	}
	else
	{
		wait(2);
	}

	level thread scripts\cp\zombies\zombie_jukebox::func_A4BE(param_00,1);
}

//Function Number: 15
init_zombie_heads()
{
	level.zombie_heads = getscriptablearray("mounted_zom_head","targetname");
}

//Function Number: 16
setup_harpoon_cabinet_weapons()
{
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = scripts\common\utility::getstructarray("iw7_harpoon_zm","script_noteworthy");
	foreach(var_02 in var_00)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
		var_02 thread activate_struct_when_quest_complete(var_02);
	}
}

//Function Number: 17
activate_struct_when_quest_complete(param_00)
{
	scripts\common\utility::flag_wait("harpoon_unlocked");
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 18
adjust_computer_interaction_pos()
{
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = scripts\common\utility::getstruct("computer","script_noteworthy");
	var_00.origin = (-554.2,-1444.3,252);
	thread delay_remove_from_interactions(var_00);
	thread turn_on_effect_with_power(var_00,(-524.4,-1445.5,265),(0,38,0));
}

//Function Number: 19
turn_on_effect_with_power(param_00,param_01,param_02)
{
	level endon("game_ended");
	var_03 = spawnfx(level._effect["computer_screen"],param_01,anglestoforward(param_02),anglestoup(param_02));
	level waittill("activate_power");
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	triggerfx(var_03);
}

//Function Number: 20
setup_scares()
{
	level endon("gamed_ended");
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = scripts\common\utility::getstructarray("slasher_scenes","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread func_135F7(var_02);
	}
}

//Function Number: 21
func_135F7(param_00)
{
	level endon("game_ended");
	var_01 = 26896;
	if(isdefined(param_00.target))
	{
		var_02 = scripts\common\utility::getstruct(param_00.target,"targetname");
		var_03 = 0;
		var_04 = spawn("script_model",param_00.origin);
		if(isdefined(param_00.angles))
		{
			var_04.angles = param_00.angles;
		}
		else
		{
			var_04.angles = (0,0,0);
		}

		var_04 setmodel("body_zmb_slasher");
		var_04 hide();
		while(!var_03)
		{
			if(!isdefined(level.slasher))
			{
				foreach(var_06 in level.players)
				{
					if(distance2dsquared(var_06.origin,var_02.origin) <= var_01)
					{
						if(scripts\common\utility::func_13D90(var_06.origin,var_06 getplayerangles(),var_04.origin,0.83))
						{
							var_03 = 1;
							break;
						}
					}
				}
			}

			wait(randomfloatrange(0.1,1));
		}

		wait(0.5);
		foreach(var_06 in level.players)
		{
			if(!scripts\common\utility::istrue(var_06.var_DCEB))
			{
				var_04 showtoplayer(var_06);
			}
		}

		var_04 scriptmodelplayanimdeltamotionfrompos("IW7_cp_slasher_walk_forward_01",var_04.origin,var_04.angles);
		var_0A = getanimlength(%iw7_cp_slasher_walk_forward_01);
		wait(var_0A);
		var_04 delete();
	}
}

//Function Number: 22
wave_complete_dialogues(param_00)
{
	if(!isdefined(level.var_4481))
	{
		level.var_4481 = [];
	}

	if(level.players.size < 2)
	{
		if(level.players[0].var_134FD == "p5_")
		{
			if(randomint(100) > 70)
			{
				level.players[0] thread scripts\cp\_vo::try_to_play_vo("ww_p5_taunt","rave_ww_vo");
			}
		}
	}

	if(param_00 >= 3 && param_00 <= 5)
	{
		if(randomint(100) > 60)
		{
			var_01 = scripts\common\utility::random(level.players);
			if(isdefined(var_01.var_134FD))
			{
				switch(var_01.var_134FD)
				{
					case "p1_":
						if(!isdefined(level.var_4481["round3to5_14_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("round3to5_14_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["round3to5_14_1"] = 1;
						}
						break;

					case "p4_":
						if(!isdefined(level.var_4481["round3to5_15_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("round3to5_15_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["round3to5_15_1"] = 1;
						}
						break;

					case "p3_":
						if(!isdefined(level.var_4481["round3to5_16_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("round3to5_16_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["round3to5_16_1"] = 1;
						}
						break;

					case "p2_":
						if(!isdefined(level.var_4481["round3to5_17_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("round3to5_17_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["round3to5_17_1"] = 1;
						}
						break;

					default:
						break;
				}

				return;
			}

			return;
		}

		return;
	}

	if(var_01 >= 9 && var_01 <= 12)
	{
		if(randomint(100) > 60)
		{
			var_01 = scripts\common\utility::random(level.players);
			if(isdefined(var_01.var_134FD))
			{
				switch(var_01.var_134FD)
				{
					case "p1_":
						if(!isdefined(level.var_4481["round9to12_22_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("round9to12_22_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["round9to12_22_1"] = 1;
						}
						break;

					case "p4_":
						if(!isdefined(level.var_4481["round9to12_23_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("round9to12_23_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["round9to12_23_1"] = 1;
						}
						break;

					case "p3_":
						if(!isdefined(level.var_4481["round3to5_16_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("round3to5_16_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["round3to5_16_1"] = 1;
						}
						break;

					case "p2_":
						if(!isdefined(level.var_4481["round3to5_17_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("round3to5_17_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["round3to5_17_1"] = 1;
						}
						break;

					default:
						break;
				}

				return;
			}

			return;
		}

		return;
	}

	if(randomint(100) > 60)
	{
		if(scripts\common\utility::istrue(level.met_kev))
		{
			var_02 = level.players[0];
			if(isdefined(level.players_who_met_kev))
			{
				var_02 = scripts\common\utility::random(level.players_who_met_kev);
			}

			switch(var_02.var_134FD)
			{
				case "p1_":
					if(!isdefined(level.var_4481["trustksmith_38_1"]))
					{
						var_02 thread scripts\cp\_vo::try_to_play_vo("trustksmith_38_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["trustksmith_38_1"] = 1;
					}
					break;

				case "p4_":
					if(!isdefined(level.var_4481["trustksmith_40_1"]))
					{
						var_02 thread scripts\cp\_vo::try_to_play_vo("trustksmith_40_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["trustksmith_40_1"] = 1;
					}
					break;

				case "p3_":
					if(!isdefined(level.var_4481["trustksmith_39_1"]))
					{
						var_02 thread scripts\cp\_vo::try_to_play_vo("trustksmith_39_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["trustksmith_39_1"] = 1;
					}
					break;

				case "p2_":
					if(!isdefined(level.var_4481["trustksmith_41_1"]))
					{
						var_02 thread scripts\cp\_vo::try_to_play_vo("trustksmith_41_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["trustksmith_41_1"] = 1;
					}
					break;

				default:
					break;
			}

			return;
		}

		return;
	}
}

//Function Number: 23
rave_precache()
{
	precachempanim("IW7_cp_wyler_afterlife_idle_01");
	precachempanim("IW7_cp_wyler_afterlife_idle_02");
	precachempanim("IW7_cp_wyler_afterlife_idle_03");
	precachempanim("IW7_cp_wyler_afterlife_idle_04");
	precachempanim("IW7_cp_wyler_afterlife_idle_05");
	precachempanim("IW7_cp_wyler_afterlife_idle_06");
	precachempanim("IW7_cp_wyler_afterlife_idle_07");
	precachempanim("IW7_cp_wyler_afterlife_idle_08");
	precachempanim("IW7_cp_wyler_afterlife_idle_09");
	precachempanim("IW7_cp_wyler_afterlife_idle_10");
	precachempanim("IW7_cp_survivor_cabin_idle_01");
	precachempanim("IW7_cp_survivor_cabin_idle_02");
	precachempanim("IW7_cp_slasher_walk_forward_01");
	precachempanim("IW7_cp_survivor_boat_idle");
	precachempanim("IW7_cp_survivor_boat_fall");
	precachempanim("IW7_cp_super_taunt_intro");
	precachempanim("IW7_cp_log_swing");
	scripts\common\utility::flag_init("survivor_released");
	scripts\common\utility::flag_init("survivor_trapped");
}

//Function Number: 24
setup_pa_speakers()
{
	level.var_A4BF = "cp/zombies/cp_rave_music_genre.csv";
	scripts\cp\zombies\zombie_jukebox::parse_music_genre_table();
	wait(1.15);
	disablepaspeaker("pa_speaker_stage");
	disablepaspeaker("pa_speaker_stage_2");
	disablepaspeaker("pa_speaker_path");
	disablepaspeaker("pa_super_slasher");
	level thread scripts\cp\zombies\zombie_jukebox::func_A4BE((1785,-2077,211));
	level thread wait_for_intro_complete();
}

//Function Number: 25
wait_for_intro_complete()
{
	level waittill("start_pa_music");
	wait(5);
	level thread func_6276();
	level notify("jukebox_start");
}

//Function Number: 26
func_6276()
{
	enablepaspeaker("pa_speaker_stage");
}

//Function Number: 27
disable_rave_speakers()
{
	scripts\common\utility::flag_set("jukebox_paused");
	level notify("skip_song");
}

//Function Number: 28
reenable_rave_speakers()
{
	scripts\common\utility::func_6E2A("jukebox_paused");
}

//Function Number: 29
init_rave_quests()
{
	init_statue_quest_flags();
	level.animal_statue_kills = [];
	level.animal_statue_kills["owl"] = 0;
	level.animal_statue_kills["wolf"] = 0;
	level.animal_statue_kills["eagle"] = 0;
	level.animal_statue_kills["deer"] = 0;
	level.animal_statue_weapons["owl"] = "iw7_harpoon1_zm";
	level.animal_statue_weapons["wolf"] = "iw7_harpoon2_zm";
	level.animal_statue_weapons["eagle"] = "iw7_harpoon3_zm+akimbo";
	level.animal_statue_weapons["deer"] = "iw7_harpoon4_zm";
	level.animal_quest_volume = getent("animal_statues","targetname");
	scripts\common\utility::flag_set("harpoon_upgrade_quest_active");
	level.rave_mode_activation_funcs = [];
	level.normal_mode_activation_funcs = [];
	spawn_missing_structs();
	move_struct((-1564.6,2717.8,31.3),(-1512.72,2658.01,22.7251),(15.5464,277.396,2.43727));
	move_struct((-3469.5,48.5,-134.3),(-3385.7,9.75768,-141.774),(0.443953,293.884,-4.28248));
	move_struct((-619.3,-1932.8,71.5),(-97.8,-3285.9,171.5),(0,350,0));
	move_struct((-556.5,-1731.6,123),(-551.5,-1725.6,112.5),(82.1009,226.684,176.654));
	move_struct((-3698.4,-2852.9,148),(-3737.24,-417.519,-52.3413),(356.817,0.973019,-16.0763));
	move_struct((-1914.5,-4326.5,290.1),(-2563.72,-1217.02,-24.1897),(15.7054,6.89507,18.1345));
	move_struct((-2254.8,-5120.2,359.9),(-2059.06,1297.45,-155.511),(357.057,358.937,8.51935));
	move_struct((-3036,481.7,-77.3),(-3082,580.7,-77.3),(0,116.2,0));
	add_additional_fix_pap_structs();
	var_00 = scripts\common\utility::getstructarray("animal_statue_toys","script_noteworthy");
	var_00 = scripts\common\utility::func_22A8(var_00);
	foreach(var_02 in var_00)
	{
		var_02 thread delay_remove_from_interactions(var_02);
	}

	var_04 = ["wolf","eagle","deer","owl"];
	var_04 = scripts\common\utility::func_22A8(var_04);
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_00[var_05] thread delay_add_to_interactions(var_00[var_05]);
		thread setup_statue_toy(var_00[var_05],var_04[var_05]);
	}
}

//Function Number: 30
spawn_missing_structs(param_00,param_01)
{
	var_02 = [(-5840.6,4469.1,140),(-5832.4,4364.8,140),(-5953.2,4358.7,140),(-5950.4,4467.2,140),(-6081.5,5111.1,148)];
	var_03 = [(0,0,0),(0,0,0),(0,0,0),(0,0,0),(0,102,0)];
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_05 = spawnstruct();
		var_05.origin = var_02[var_04];
		var_05.angles = var_03[var_04];
		var_05.var_86A2 = "1";
		var_05.var_257 = 21;
		var_05.script_noteworthy = "ritual_stone";
		var_05.var_336 = "interaction";
		var_05.var_E1B9 = 0;
		var_05.var_D776 = 1;
		var_05.var_EE79 = "default";
		thread delay_add_to_interactions(var_05);
	}

	var_06 = [(-6090.2,5151.6,138),(-5898.1,4410.2,140)];
	var_07 = [(0,0,0),(0,0,0)];
	for(var_04 = 0;var_04 < var_06.size;var_04++)
	{
		var_05 = spawnstruct();
		var_05.origin = var_06[var_04];
		var_05.angles = var_07[var_04];
		var_05.var_86A2 = "1";
		var_05.var_257 = 200;
		var_05.var_336 = "rave_fx";
		level.var_1115C["targetname"]["rave_fx"][level.var_1115C["targetname"]["rave_fx"].size] = var_05;
	}
}

//Function Number: 31
add_additional_fix_pap_structs()
{
	var_00 = [(-6094.4,4860.3,143),(-6147.6,4849.7,143)];
	var_01 = [(0,196,0),(0,16.5,0)];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = spawnstruct();
		var_03.origin = var_00[var_02];
		var_03.angles = var_01[var_02];
		var_03.var_336 = "interaction";
		var_03.script_noteworthy = "fix_pap";
		var_03.var_E1B9 = 0;
		var_03.var_D776 = 1;
		var_03.var_EE79 = "default";
		thread delay_add_to_interactions(var_03);
		var_03 thread remove_struct_when_machine_fixed(var_03);
	}
}

//Function Number: 32
remove_struct_when_machine_fixed(param_00)
{
	level endon("game_ended");
	scripts\common\utility::flag_init("pap_fixed");
	scripts\common\utility::flag_wait("pap_fixed");
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
}

//Function Number: 33
init_statue_quest_flags()
{
	scripts\common\utility::flag_init("harpoon_upgrade_quest_active");
	scripts\common\utility::flag_init("owl_quest_completed");
	scripts\common\utility::flag_init("wolf_quest_completed");
	scripts\common\utility::flag_init("eagle_quest_completed");
	scripts\common\utility::flag_init("deer_quest_completed");
	scripts\common\utility::flag_init("owl_toy_found");
	scripts\common\utility::flag_init("wolf_toy_found");
	scripts\common\utility::flag_init("eagle_toy_found");
	scripts\common\utility::flag_init("deer_toy_found");
	scripts\common\utility::flag_init("owl_toy_charged");
	scripts\common\utility::flag_init("wolf_toy_charged");
	scripts\common\utility::flag_init("eagle_toy_charged");
	scripts\common\utility::flag_init("deer_toy_charged");
	scripts\common\utility::flag_init("owl_toy_placed");
	scripts\common\utility::flag_init("wolf_toy_placed");
	scripts\common\utility::flag_init("eagle_toy_placed");
	scripts\common\utility::flag_init("deer_toy_placed");
}

//Function Number: 34
setup_statue_toy(param_00,param_01)
{
	wait(0.25);
	param_00.var_86A2 = "locOverride";
	param_00.model = spawn("script_model",param_00.origin);
	param_00.model setmodel("tag_origin_toy_statues");
	param_00.model.angles = param_00.angles;
	param_00.model setscriptablepartstate("toy_model",param_01);
	param_00.animal_type = param_01;
}

//Function Number: 35
use_toy_animal_statue(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_00.model setscriptablepartstate("events","pickup");
	param_00.model setscriptablepartstate("toy_model","neutral");
	param_00.model thread cleanup_model_after_time(param_00);
	switch(param_00.animal_type)
	{
		case "wolf":
			scripts\common\utility::flag_set("wolf_toy_found");
			level scripts\cp\_utility::set_quest_icon(17);
			break;

		case "owl":
			scripts\common\utility::flag_set("owl_toy_found");
			level scripts\cp\_utility::set_quest_icon(16);
			break;

		case "deer":
			scripts\common\utility::flag_set("deer_toy_found");
			level scripts\cp\_utility::set_quest_icon(2);
			break;

		case "eagle":
			scripts\common\utility::flag_set("eagle_toy_found");
			level scripts\cp\_utility::set_quest_icon(5);
			break;
	}
}

//Function Number: 36
cleanup_model_after_time(param_00)
{
	wait(1);
	if(isdefined(param_00.model))
	{
		param_00.model delete();
	}
}

//Function Number: 37
toy_animal_statue_hint_func(param_00,param_01)
{
	return &"CP_RAVE_PICKUP_ITEM";
}

//Function Number: 38
harpoon_upgrade_quest()
{
	scripts\common\utility::flag_wait("owl_quest_completed");
	scripts\common\utility::flag_wait("wolf_quest_completed");
	scripts\common\utility::flag_wait("eagle_quest_completed");
	scripts\common\utility::flag_wait("deer_quest_completed");
	level scripts\cp\_utility::set_completed_quest_mark(2);
}

//Function Number: 39
toy_charging_hint_func(param_00,param_01)
{
	var_02 = ["wolf","owl","deer","eagle"];
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(scripts\common\utility::flag(var_02[var_03] + "_toy_found") && !scripts\common\utility::flag(var_02[var_03] + "_toy_placed") && !scripts\common\utility::flag(var_02[var_03] + "_toy_charged"))
		{
			return &"CP_RAVE_PLACE_ITEM";
		}

		if(isdefined(param_00.current_statue) && scripts\common\utility::flag(var_02[var_03] + "_toy_placed") && scripts\common\utility::flag(var_02[var_03] + "_toy_charged"))
		{
			return &"CP_RAVE_PICKUP_ITEM";
		}
	}

	return "";
}

//Function Number: 40
toy_charging_use_func(param_00,param_01)
{
	var_02 = scripts\common\utility::func_22A8(["wolf","owl","deer","eagle"]);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(scripts\common\utility::flag(var_02[var_03] + "_quest_completed"))
		{
			continue;
		}

		if(isdefined(param_00.current_statue) && scripts\common\utility::flag(var_02[var_03] + "_toy_charged") && scripts\common\utility::flag(var_02[var_03] + "_toy_placed"))
		{
			param_00.model thread cleanup_toy(param_00);
			param_00.current_statue = undefined;
			if(scripts\common\utility::istrue(param_00.has_statue_equipped))
			{
				param_00.has_statue_equipped = undefined;
			}

			scripts\common\utility::func_6E2A(var_02[var_03] + "_toy_placed");
			scripts\common\utility::flag_set(var_02[var_03] + "_toy_found");
			return;
		}
		else if(scripts\common\utility::flag(var_02[var_03] + "_toy_found") && !scripts\common\utility::flag(var_02[var_03] + "_toy_placed") && !scripts\common\utility::flag(var_02[var_03] + "_toy_charged"))
		{
			if(scripts\common\utility::istrue(param_00.has_statue_equipped))
			{
				return;
			}

			scripts\common\utility::flag_set(var_02[var_03] + "_toy_placed");
			scripts\common\utility::func_6E2A(var_02[var_03] + "_toy_found");
			param_00.current_statue = var_02[var_03];
			thread run_charge_toy_statue_quest(param_00);
			return;
		}
	}
}

//Function Number: 41
toy_statue_end_pos_hint_func(param_00,param_01)
{
	if(!scripts\common\utility::flag(param_00.name + "_toy_found") || !scripts\common\utility::flag(param_00.name + "_toy_charged"))
	{
		return "";
	}

	if(!scripts\common\utility::flag(param_00.name + "_toy_placed"))
	{
		return &"CP_RAVE_PLACE_ITEM";
	}

	if(scripts\common\utility::flag(param_00.name + "_quest_completed"))
	{
		return &"CP_RAVE_PICKUP_ITEM";
	}

	return "";
}

//Function Number: 42
run_charge_toy_statue_quest(param_00)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	var_01 = scripts\common\utility::getstruct(param_00.target,"targetname");
	var_02 = spawn("script_model",var_01.origin);
	var_02.angles = var_01.angles;
	var_02 setmodel("tag_origin_toy_statues");
	var_02 setscriptablepartstate("events","place");
	var_02 setscriptablepartstate("toy_model",param_00.current_statue);
	param_00.model = var_02;
	thread setup_b_bman_quest(param_00);
	param_00 wait_for_charge_complete(param_00);
	param_00.has_statue_equipped = 1;
	scripts\common\utility::flag_set(param_00.current_statue + "_toy_charged");
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 43
setup_b_bman_quest(param_00)
{
	if(!isdefined(level.var_8C59.var_1AB))
	{
		level.var_8C59.var_1AB = [];
	}

	if(!isdefined(level.var_8C59.statues))
	{
		level.var_8C59.statues = [];
	}

	level.var_8C59.statues[level.var_8C59.statues.size] = param_00;
	if(!isdefined(level.var_8C59.var_1AB[param_00.current_statue]))
	{
		level.var_8C59.var_1AB[param_00.current_statue] = 0;
	}
}

//Function Number: 44
b_man_head_tracking()
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("interactions_initialized");
	level endon("all_statues_charged");
	var_00 = getent("b_man_head","targetname");
	var_00.var_C378 = var_00.angles;
	var_00.var_C38F = var_00.origin;
	level.var_8C59 = var_00;
	level.head_statues_charged = 0;
	var_00 thread watch_zombie_health();
	var_01 = -40;
	var_02 = 180;
	var_03 = 0;
	var_04 = undefined;
	var_05 = (1879,-2702,0);
	var_06 = (1660,-1825,128);
	var_07 = (2291,-1800,0);
	var_08 = (2284,-2407,128);
	for(;;)
	{
		var_09 = 0;
		var_0A = undefined;
		var_0B = var_00 get_valid_statue_enemy(var_05,var_06,var_07,var_08);
		if(var_0B.size < 1)
		{
			var_0C = sortbydistance(level.players,var_00.var_C38F);
			var_0D = 0;
			foreach(var_0F in var_0C)
			{
				if(scripts\cp\maps\cp_rave\cp_rave_memory_quests::is_in_box(var_05,var_06,var_07,var_08,var_0F.origin))
				{
					var_04 = var_0F.origin;
					var_0D = 1;
					break;
				}
			}

			if(!var_0D)
			{
				var_04 = undefined;
			}
		}
		else if(var_0B.size >= 1)
		{
			var_04 = var_0B[0].origin;
			foreach(var_12 in var_0B)
			{
				if(var_12.health < 0.4 * var_12.maxhealth)
				{
					var_0A = var_12;
					var_04 = var_12.origin;
					break;
				}
			}
		}
		else
		{
			var_04 = undefined;
		}

		if(isdefined(var_04))
		{
			var_00 rotateto(vectortoangles(var_04 - var_00.var_C38F) + (var_01,var_02,var_03),0.25);
			wait(0.25);
			if(isdefined(var_0A))
			{
				var_00 laser_eye_kill_target(var_0A);
			}

			continue;
		}

		var_00 rotateto(var_00.var_C378,0.25);
		wait(0.25);
	}
}

//Function Number: 45
watch_zombie_health()
{
	level endon("game_ended");
	level endon("all_statues_charged");
	var_00 = (1879,-2702,0);
	var_01 = (1660,-1825,128);
	var_02 = (2291,-1800,0);
	var_03 = (2284,-2407,128);
	for(;;)
	{
		var_04 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_05 = scripts\common\utility::func_782F(self.origin,var_04,undefined,24,1000,1);
		foreach(var_07 in var_04)
		{
			if(isdefined(var_07.agent_type) && var_07.agent_type == "superslasher" || var_07.agent_type == "slasher" || var_07.agent_type == "zombie_ghost")
			{
				continue;
			}

			if(scripts\cp\maps\cp_rave\cp_rave_memory_quests::is_in_box(var_00,var_01,var_02,var_03,var_07.origin))
			{
				if(var_07.health <= 0.4 * var_07.maxhealth)
				{
					var_07 setscriptablepartstate("eyes","red_eyes");
				}

				continue;
			}

			if(!scripts\common\utility::istrue(var_07.is_skeleton))
			{
				var_07 setscriptablepartstate("eyes","yellow_eyes");
			}
		}

		wait(0.5);
	}
}

//Function Number: 46
laser_eye_kill_target(param_00)
{
	param_00.atomize_me = 1;
	if(isalive(param_00) && param_00.health >= 1)
	{
		param_00 dodamage(param_00.health + 1000,self.origin,self,self,"MOD_RIFLE_BULLET");
		foreach(var_02 in level.var_8C59.statues)
		{
			self.var_1AB[var_02.current_statue]++;
			if(self.var_1AB[var_02.current_statue] >= 10)
			{
				if(scripts\common\utility::func_2286(level.var_8C59.statues,var_02))
				{
					level.var_8C59.statues = scripts\common\utility::func_22A9(level.var_8C59.statues,var_02);
				}

				level notify(var_02.current_statue + "_statue_charged");
				level.head_statues_charged++;
				playsoundatpos(var_02.origin,"zmb_quest_complete");
			}
		}

		if(level.head_statues_charged >= 4)
		{
			level notify("all_statues_charged");
			self rotateto(self.var_C378,0.25);
		}
	}
}

//Function Number: 47
get_valid_statue_enemy(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.var_8C59.statues) || level.var_8C59.statues.size < 1)
	{
		return [];
	}

	var_04 = 24;
	var_05 = 2000;
	var_06 = cos(45);
	var_07 = [];
	var_08 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_09 = scripts\common\utility::func_782F(self.origin,var_08,undefined,24,var_05,1);
	foreach(var_0B in var_09)
	{
		if(scripts\common\utility::istrue(var_0B.var_54CB))
		{
			continue;
		}

		var_0C = 0;
		var_0D = var_0B.origin;
		var_0E = scripts\cp\maps\cp_rave\cp_rave_memory_quests::is_in_box(param_00,param_01,param_02,param_03,var_0B.origin);
		if(var_0E)
		{
			var_0C = 1;
		}

		if(var_0C && var_07.size < var_04)
		{
			var_07[var_07.size] = var_0B;
		}
	}

	return var_07;
}

//Function Number: 48
wait_for_charge_complete(param_00)
{
	level endon("gamed_ended");
	level waittill(param_00.current_statue + "_statue_charged");
}

//Function Number: 49
disable_all_similar_interactions(param_00)
{
	var_01 = scripts\common\utility::getstructarray(param_00.script_noteworthy,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.name) && var_03.name == param_00.name)
		{
			scripts\cp\_interaction::remove_from_current_interaction_list(var_03);
		}
	}
}

//Function Number: 50
toy_animal_statue_end_pos(param_00,param_01)
{
	if(!scripts\common\utility::flag(param_00.name + "_toy_found") || !scripts\common\utility::flag(param_00.name + "_toy_charged"))
	{
		return;
	}

	if(scripts\common\utility::flag(param_00.name + "_quest_completed"))
	{
		var_02 = 0;
		foreach(var_04 in level.players)
		{
			var_04 thread scripts\cp\_interaction::func_DE6E();
		}

		foreach(var_07 in param_01 getweaponslistall())
		{
			if(issubstr(var_07,"harpoon_"))
			{
				param_01 takeweapon(var_07);
				var_02 = 1;
			}
		}

		if(var_02)
		{
			thread disable_all_similar_interactions(param_00);
			param_01 scripts\cp\_utility::func_12C6(level.animal_statue_weapons[param_00.name],undefined,undefined,0);
			param_01 notify("harpoon_quest_completed",level.animal_statue_weapons[param_00.name]);
			param_01 switchtoweapon(level.animal_statue_weapons[param_00.name]);
			var_09 = scripts\common\utility::getstructarray("animal_statue_end_pos","script_noteworthy");
			foreach(var_0B in var_09)
			{
				if(var_0B.name != param_00.name)
				{
					continue;
				}

				if(isdefined(var_0B.model))
				{
					var_0B.model thread cleanup_toy(var_0B);
				}
			}

			return;
		}

		scripts\cp\_interaction::add_to_current_interaction_list(param_00);
		return;
	}

	if(!scripts\common\utility::flag(param_00.name + "_toy_placed"))
	{
		scripts\common\utility::flag_set(param_00.name + "_toy_placed");
		var_09 = scripts\common\utility::getstructarray("animal_statue_end_pos","script_noteworthy");
		var_0D = [];
		foreach(var_0B in var_09)
		{
			if(var_0B.name != param_00.name)
			{
				continue;
			}
			else
			{
				var_0F = spawn("script_model",var_0B.origin);
				var_0F.angles = var_0B.angles;
				var_0F setmodel("tag_origin_toy_statues");
				var_0F setscriptablepartstate("events","place");
				var_0F setscriptablepartstate("toy_model",param_00.name);
				var_0B.model = var_0F;
				var_0D[var_0D.size] = var_0B.model;
			}
		}

		param_00 thread watch_for_quest_complete(param_00);
		foreach(param_01 in level.players)
		{
			param_01 thread watch_for_kills_with_correct_weapon(param_00,param_01,var_0D);
		}
	}
}

//Function Number: 51
watch_for_kills_with_correct_weapon(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_01 endon("disconnect");
	level endon(param_00.name + "_quest_completed");
	var_03 = 562500;
	for(;;)
	{
		param_01 waittill("zombie_killed",var_04,var_05,var_06,var_07);
		var_08 = getweaponbasename(var_06);
		if(var_08 == "iw7_harpoon_zm")
		{
			foreach(var_0A in param_02)
			{
				if(distancesquared(param_01.origin,var_0A.origin) <= 562500)
				{
					level.animal_statue_kills[param_00.name]++;
					break;
				}
			}

			if(level.animal_statue_kills[param_00.name] >= 20)
			{
				break;
			}
		}
	}

	scripts\common\utility::flag_set(param_00.name + "_quest_completed");
}

//Function Number: 52
watch_for_quest_complete(param_00)
{
	level endon("game_ended");
	scripts\common\utility::flag_wait(param_00.name + "_quest_completed");
	level notify(param_00.name + "_quest_completed");
}

//Function Number: 53
cleanup_toy(param_00)
{
	level endon("game_ended");
	param_00.model setscriptablepartstate("events","pickup");
	param_00.model setscriptablepartstate("toy_model","neutral");
	wait(1);
	param_00.model delete();
}

//Function Number: 54
func_136D3(param_00,param_01)
{
	level endon("game_ended");
	var_02 = "WaitForPlayerInput" + param_00;
	self notifyonplayercommand(var_02,param_00);
	for(;;)
	{
		self waittill(var_02);
		thread [[ param_01 ]]();
	}
}

//Function Number: 55
rave_processenemykilledfunc(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isplayer(param_01) && !scripts\common\utility::istrue(param_01.has_rave_dust) && !isdefined(param_01.rave_dust_pouch))
	{
		if((isdefined(param_01.var_1AB) && param_01.var_1AB % 20 == 0) || scripts\common\utility::istrue(param_01.should_drop_pouch))
		{
			param_01.should_drop_pouch = 1;
			var_0A = getclosestpointonnavmesh(param_09);
			if(!scripts\cp\zombies\_powerups::is_in_active_volume(var_0A))
			{
				return;
			}

			if(isdefined(param_01.rave_dust_pouch))
			{
				param_01.rave_dust_pouch delete();
			}

			param_01.rave_dust_pouch = spawn("script_model",var_0A + (0,0,40));
			param_01.rave_dust_pouch setmodel("zmb_pouch");
			foreach(var_0C in level.players)
			{
				if(var_0C == param_01)
				{
					param_01.rave_dust_pouch showtoplayer(var_0C);
					continue;
				}

				param_01.rave_dust_pouch method_8429(var_0C);
			}

			level thread show_rave_dust_pickup(param_01,param_01.rave_dust_pouch);
			level thread wait_dust_pickup(param_01,param_01.rave_dust_pouch);
			level thread destroy_rave_dust_on_player_disconnect(param_01,param_01.rave_dust_pouch);
			return;
		}
	}
}

//Function Number: 56
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

//Function Number: 57
init_weapon_change_funcs()
{
	level.weapon_change_func = [];
	level.weapon_change_func["iw7_two_headed_axe_mp"] = ::axe_fl;
	level.weapon_change_func["iw7_machete_mp"] = ::machete_fl;
	level.weapon_change_func["iw7_spiked_bat_mp"] = ::bat_fl;
	level.weapon_change_func["iw7_slasher_zm"] = ::use_slasher_saw;
	level.weapon_change_func["iw7_lawnmower_zm"] = ::use_lawn_mower;
	level.weapon_change_func["iw7_golf_club_mp"] = ::golf_fl;
}

//Function Number: 58
use_lawn_mower(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 thread unset_mower(param_00);
	param_00 setscriptablepartstate("mower","activated");
	for(;;)
	{
		if(param_00 adsbuttonpressed(1))
		{
			param_00 method_800C(0);
			param_00 mower_gesture(param_00);
		}

		param_00 method_800C(1);
		wait(0.25);
	}
}

//Function Number: 59
unset_mower(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 waittill("weapon_change");
	param_00 method_800C(1);
	param_00 stopgestureviewmodel("ges_mower_melee",0,0);
	param_00 notify("stop_lawn_mower_attack_logic");
	param_00 setscriptablepartstate("mower","neutral");
}

//Function Number: 60
mower_gesture(param_00)
{
	param_00 endon("disconnect");
	param_00 method_846F("ges_mower_melee",undefined,1,undefined,1,1);
	param_00 thread run_lawn_mower_logic(param_00);
	while(param_00 adsbuttonpressed(1) && param_00 isgestureplaying("ges_mower_melee"))
	{
		scripts\common\utility::func_136F7();
	}

	param_00 stopgestureviewmodel("ges_mower_melee",0.5,0);
	param_00 notify("stop_lawn_mower_attack_logic");
}

//Function Number: 61
run_lawn_mower_logic(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 endon("stop_lawn_mower_attack_logic");
	var_01 = 64;
	while(param_00 adsbuttonpressed(1) && param_00 isgestureplaying("ges_mower_melee"))
	{
		wait(1);
	}
}

//Function Number: 62
use_slasher_saw(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 setscriptablepartstate("slasher_saw_sound","first_pull_out");
	param_00 thread unset_saw(param_00);
	var_01 = 0;
	for(;;)
	{
		var_01 = param_00 getweaponammoclip("iw7_slasher_zm") + param_00 getweaponammostock("iw7_slasher_zm");
		if(var_01 > 0 && param_00 adsbuttonpressed(1) && !param_00 secondaryoffhandbuttonpressed() && !param_00 method_81C6() && !param_00 fragbuttonpressed())
		{
			param_00 method_80AB();
			param_00 method_800C(0);
			param_00 thread watch_for_player_attack(param_00);
			param_00 thread run_slasher_saw_logic(param_00);
			param_00 slasher_gesture(param_00);
		}

		if(!scripts\common\utility::istrue(param_00.playing_ghosts_n_skulls))
		{
			param_00 enableweaponswitch();
		}

		param_00 method_800C(1);
		wait(0.1);
	}
}

//Function Number: 63
slasher_gesture(param_00)
{
	param_00 endon("disconnect");
	param_00 method_846F("ges_slasher_charge",undefined,1,undefined,1,1);
	param_00 setscriptablepartstate("slasher_saw_sound","idle_high");
	param_00 setscriptablepartstate("slasher_weapon","active");
	while(param_00 adsbuttonpressed(1) && param_00 isgestureplaying("ges_slasher_charge") || param_00 isgestureplaying("ges_slasher_charge_hit"))
	{
		var_01 = param_00 getweaponammoclip("iw7_slasher_zm") + param_00 getweaponammostock("iw7_slasher_zm");
		if(var_01 < 1)
		{
			break;
		}

		wait(0.1);
		if(scripts\common\utility::istrue(param_00.should_lunge))
		{
			param_00 method_846F("ges_slasher_charge_hit",undefined,0.8,undefined,1,1);
			wait(0.8);
			param_00 method_846F("ges_slasher_charge",undefined,1,undefined,1,0);
			param_00.should_lunge = undefined;
		}
	}

	param_00 setscriptablepartstate("slasher_saw_sound","idle");
	param_00 setscriptablepartstate("slasher_weapon","neutral");
	param_00 stopgestureviewmodel("ges_slasher_charge_hit",0,0);
	param_00 stopgestureviewmodel("ges_slasher_charge",1,0);
	param_00 notify("stop_slasher_saw_attack_logic");
	while(param_00 isgestureplaying("ges_slasher_charge") || param_00 isgestureplaying("ges_slasher_charge_hit"))
	{
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 64
unset_saw(param_00)
{
	param_00 endon("disconnect");
	param_00 waittill("weapon_change");
	param_00 method_800C(1);
	if(!scripts\common\utility::istrue(param_00.playing_ghosts_n_skulls))
	{
		param_00 enableweaponswitch();
	}

	param_00 setscriptablepartstate("slasher_weapon","neutral");
	param_00 setscriptablepartstate("slasher_saw_sound","neutral");
	param_00 stopgestureviewmodel("ges_slasher_charge_hit",0,0);
	param_00 stopgestureviewmodel("ges_slasher_charge",0,0);
	param_00 notify("stop_slasher_saw_attack_logic");
}

//Function Number: 65
watch_for_player_attack(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 endon("stop_slasher_saw_attack_logic");
	param_00 notifyonplayercommand("lunge_weapon","+attack");
	param_00 notifyonplayercommand("lunge_weapon","+attack_akimbo_accessible");
	while(param_00 adsbuttonpressed(1) && param_00 isgestureplaying("ges_slasher_charge"))
	{
		param_00 waittill("lunge_weapon");
		param_00 notify("slasher_weapon_hit_zombie");
		param_00.should_lunge = 1;
		wait(1);
	}
}

//Function Number: 66
run_slasher_saw_logic(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 endon("stop_slasher_saw_attack_logic");
	var_01 = 64;
	for(var_02 = 0;param_00 adsbuttonpressed(1);var_02 = 0)
	{
		var_03 = func_3E08(35,var_01,5);
		foreach(var_05 in var_03)
		{
			if(isdefined(var_05.agent_type) && var_05.agent_type == "superslasher")
			{
				continue;
			}

			if(!scripts\common\utility::istrue(param_00.slasher_screen_blood))
			{
				param_00 thread screen_blood(param_00);
			}

			var_02 = 1;
			var_05.full_gib = 1;
			var_05 dodamage(var_05.maxhealth,param_00.origin,param_00,param_00,"MOD_MELEE","iw7_slasher_zm");
		}

		if(isdefined(var_03) && var_03.size > 0)
		{
			param_00.should_lunge = 1;
		}

		if(var_02)
		{
			param_00 setweaponammoclip("iw7_slasher_zm",0);
			param_00 notify("weapon_fired","iw7_slasher_zm");
		}

		var_07 = param_00 scripts\common\utility::waittill_any_timeout_1(0.1,"slasher_weapon_hit_zombie");
		if(isdefined(var_07) && var_07 == "slasher_weapon_hit_zombie")
		{
			var_01 = 80;
			continue;
		}

		var_01 = 64;
	}
}

//Function Number: 67
screen_blood(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00.slasher_screen_blood = 1;
	param_00 setscriptablepartstate("screen_effects","slasher_blood");
	wait(0.5);
	param_00.slasher_screen_blood = undefined;
}

//Function Number: 68
axe_fl(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 notifyonplayercommand("flourish","+usereload");
	param_00 notifyonplayercommand("flourish","+activate");
	param_00 thread func_13B09(param_00,"melee_weapon","two_headed_axe");
	for(;;)
	{
		param_00 waittill("flourish");
		var_01 = param_00 scripts\common\utility::waittill_any_timeout_1(0.25,"flourish");
		if(!isdefined(var_01) || var_01 != "flourish")
		{
			continue;
		}

		if(param_00 scripts\cp\_utility::is_valid_player())
		{
			param_00 setweaponammostock("two_headed_axe_flourish",1);
			param_00 giveandfireoffhand("two_headed_axe_flourish");
			waittillgesturefinished(param_00);
		}
	}
}

//Function Number: 69
golf_fl(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 notifyonplayercommand("flourish","+usereload");
	param_00 notifyonplayercommand("flourish","+activate");
	param_00 thread func_13B09(param_00,"melee_weapon","golf_club");
	for(;;)
	{
		param_00 waittill("flourish");
		var_01 = param_00 scripts\common\utility::waittill_any_timeout_1(0.25,"flourish");
		if(!isdefined(var_01) || var_01 != "flourish")
		{
			continue;
		}

		if(param_00 scripts\cp\_utility::is_valid_player())
		{
			param_00 setweaponammostock("golf_club_flourish",1);
			param_00 giveandfireoffhand("golf_club_flourish");
			waittillgesturefinished(param_00);
		}
	}
}

//Function Number: 70
bat_fl(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 notifyonplayercommand("flourish","+usereload");
	param_00 notifyonplayercommand("flourish","+activate");
	param_00 thread func_13B09(param_00,"melee_weapon","spiked_bat");
	for(;;)
	{
		param_00 waittill("flourish");
		var_01 = param_00 scripts\common\utility::waittill_any_timeout_1(0.25,"flourish");
		if(!isdefined(var_01) || var_01 != "flourish")
		{
			continue;
		}

		if(param_00 scripts\cp\_utility::is_valid_player())
		{
			param_00 setweaponammostock("spiked_bat_flourish",1);
			param_00 giveandfireoffhand("spiked_bat_flourish");
			waittillgesturefinished(param_00);
		}
	}
}

//Function Number: 71
machete_fl(param_00)
{
	level endon("game_ended");
	param_00 endon("weapon_change");
	param_00 endon("disconnect");
	param_00 notifyonplayercommand("flourish","+usereload");
	param_00 notifyonplayercommand("flourish","+activate");
	param_00 thread func_13B09(param_00,"melee_weapon","machete");
	for(;;)
	{
		param_00 waittill("flourish");
		var_01 = param_00 scripts\common\utility::waittill_any_timeout_1(0.25,"flourish");
		if(!isdefined(var_01) || var_01 != "flourish")
		{
			continue;
		}

		if(param_00 scripts\cp\_utility::is_valid_player())
		{
			param_00 setweaponammostock("machete_flourish",1);
			param_00 giveandfireoffhand("machete_flourish");
			waittillgesturefinished(param_00);
		}
	}
}

//Function Number: 72
set_melee_scriptable_state(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 notify("set_melee_scriptable_state");
	param_00 endon("set_melee_scriptable_state");
	param_00 endon("disconnect");
	param_00 setscriptablepartstate(param_01,param_02);
	param_00 scripts\common\utility::func_1372F(["death","weapon_change"],5);
	param_00 setscriptablepartstate(param_01,"neutral");
}

//Function Number: 73
waittillgesturefinished(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	while(param_00 isgestureplaying())
	{
		wait(0.1);
	}
}

//Function Number: 74
func_13B09(param_00,param_01,param_02)
{
	self notify("watchPlayerMelee");
	self endon("watchPlayerMelee");
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		self waittill("melee_weapon_hit",var_03);
		param_00 thread set_melee_scriptable_state(param_00,param_01,param_02);
	}
}

//Function Number: 75
spawn_initial_rave_pouch()
{
	scripts\common\utility::flag_wait("init_interaction_done");
	var_00 = scripts\common\utility::getstruct("ritual_pouch","targetname");
	var_00.origin = scripts\common\utility::func_5D14((-682,-1621,252),12,-200);
	foreach(var_02 in level.players)
	{
		var_02.rave_dust_pouch = spawn("script_model",var_00.origin + (0,0,40));
		var_02.rave_dust_pouch setmodel("zmb_pouch");
		foreach(var_04 in level.players)
		{
			if(var_04 == var_02)
			{
				var_02.rave_dust_pouch showtoplayer(var_04);
				continue;
			}

			var_02.rave_dust_pouch method_8429(var_04);
		}

		level thread dust_initial_pickup(var_02,var_02.rave_dust_pouch);
		level thread wait_dust_pickup(var_02,var_02.rave_dust_pouch);
		level thread destroy_rave_dust_on_player_disconnect(var_02,var_02.rave_dust_pouch);
	}
}

//Function Number: 76
wait_dust_pickup(param_00,param_01)
{
	param_01 endon("death");
	param_00 endon("disconnect");
	for(;;)
	{
		if(distancesquared(param_00.origin + (0,0,40),param_01.origin) < 2304)
		{
			break;
		}

		wait(0.1);
	}

	playsoundatpos(param_01.origin,"zmb_dust_pickup");
	playfx(level._effect["souvenir_pickup"],param_01.origin);
	param_00.has_rave_dust = 1;
	param_00 setclientomnvar("zm_hud_inventory_2",1);
	param_00.should_drop_pouch = undefined;
	param_01 delete();
}

//Function Number: 77
dust_initial_pickup(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("death");
	param_01 endon("timeout");
	var_02 = 0;
	for(;;)
	{
		if(var_02 == 0)
		{
			param_01 rotateyaw(360,2);
			param_01 movez(5,2);
		}

		if(var_02 == 2)
		{
			param_01 rotateyaw(360,2);
			param_01 movez(-5,2);
		}

		if(var_02 == 4)
		{
			var_02 = 0;
			continue;
		}

		wait(1);
		var_02++;
	}

	if(isdefined(param_01))
	{
		playsoundatpos(param_01.origin,"zmb_dust_pickup");
		playfx(level._effect["souvenir_pickup"],param_01.origin);
		param_01 delete();
	}
}

//Function Number: 78
show_rave_dust_pickup(param_00,param_01)
{
	param_01 endon("death");
	param_01 endon("timeout");
	var_02 = 25;
	var_03 = gettime() + var_02 * 1000;
	var_04 = 0;
	for(var_05 = 0;gettime() < var_03;var_05++)
	{
		if(var_05 == 0)
		{
			param_01 rotateyaw(360,2);
			param_01 movez(5,2);
		}

		if(var_05 == 2)
		{
			param_01 rotateyaw(360,2);
			param_01 movez(-5,2);
		}

		if(var_05 == 4)
		{
			var_05 = 0;
			continue;
		}

		wait(1);
	}

	playsoundatpos(param_01.origin,"zmb_dust_pickup");
	playfx(level._effect["souvenir_pickup"],param_01.origin);
	param_01 delete();
}

//Function Number: 79
destroy_rave_dust_on_player_disconnect(param_00,param_01)
{
	param_01 endon("death");
	param_00 waittill("disconnect");
	if(isdefined(param_01))
	{
		param_01 delete();
	}
}

//Function Number: 80
log_swing_trap()
{
	var_00 = getent("log_swing_rope","targetname");
	var_01 = getent("log_swing_log","targetname");
	var_01 linkto(var_00);
	wait(5);
	for(;;)
	{
		var_00 rotatepitch(110,1);
		var_00 waittill("rotatedone");
		var_00 rotatepitch(-110,1);
		var_00 waittill("rotatedone");
		wait(10);
	}
}

//Function Number: 81
registerscriptedagents()
{
	scripts\mp\_mp_agent::init_agent("mp/dlc1_agent_definition.csv");
	scripts\mp\agents\zombie_dlc1\zombie_dlc1_agent::registerscriptedagent();
	scripts\mp\agents\lumberjack\lumberjack_agent::registerscriptedagent();
	scripts\mp\agents\zombie_sasquatch\zombie_sasquatch_agent::registerscriptedagent();
	scripts\mp\agents\superslasher\superslasher_agent::registerscriptedagent();
	scripts\mp\agents\slasher\slasher_agent::registerscriptedagent();
	scripts\mp\agents\zombie_skeleton\zombie_skeleton::zombie_skeleton_init();
	setupslasherteleportpoints();
}

//Function Number: 82
setupslasherteleportpoints()
{
	level.slasherteleportpoints = [];
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-974.128,-1653.25,229.322);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-237.696,-1333.41,225.117);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1713.42,-2036.45,69.5272);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2679.01,-2930.95,150.04);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3074.45,-3063.72,150.059);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3333.1,-2468.59,152.189);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3552.75,-2211.7,114.532);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3937.56,-3210.75,301.126);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3551.87,-4254.81,211.927);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2240.87,-4400.34,257.723);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3673.82,-4371.53,216.624);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3862.66,-2883.01,149.145);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1305.97,-4018.11,275.623);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-658.716,-3718.46,250.124);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-5.15608,-4029.62,157.126);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (278.393,-3877.45,82.9562);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (131.01,-3233.66,218.734);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2530.01,-3047.51,155.124);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2201.91,-3088.46,155.625);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2976.63,-2139.66,59.1264);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2532.47,-1836.45,58.1255);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1542.53,-1974.05,-13.9781);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (776.267,792.22,48.1386);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (998.317,296.732,40.0368);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-331.755,776.199,52.5667);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-338.041,-25.8158,72.3431);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1060.12,-1119.1,225.121);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-107.68,-1152.33,224.123);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1154.41,1559.48,-15.8731);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1258.34,2449.81,44.1231);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1338.24,1756.7,-110.18);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2316.13,1772.21,-184.543);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2823.2,596.546,-127.876);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2073.68,238.421,-15.9696);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3612.04,1521.7,-126.87);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2914.09,-1710.62,-21.2738);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2944.36,-4052.84,210.896);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2382.61,-4395.84,252.127);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3082.08,-5074.05,312.862);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3003.76,-5115.83,311.234);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3172.69,-4780.86,312.124);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1228.32,-4017.54,272.112);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2329.19,-4867.79,257.182);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2573.54,-3004.51,151.126);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3878.05,-2596.36,142.499);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3439.8,-3442.85,151.259);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-4379.7,-2989,220.125);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3963.17,-3969.1,232.394);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-4137.16,-1062.74,46.7611);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3452.49,-103.671,-125.894);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3076.77,393.764,-126.874);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3022.44,698.133,-127.876);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3606.3,1533.1,-125.45);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3555.31,1834.37,-127.876);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2616.27,656.545,-126.874);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2092.21,1016.01,-158.436);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1683.96,1815.85,-145.871);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1934.77,2360.91,-153.877);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2243.52,2717.41,-153.877);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2194.19,2422.55,-153.877);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1444.36,2600.57,28.8089);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-913.834,1635.32,-15.873);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-851.021,1261.76,-15.873);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-613.604,890.768,-3.19943);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1041.02,1116.27,-13.1563);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (207.589,1128.83,48.032);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2027.47,95.396,96.124);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1973.11,-501.809,176.125);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1279.58,-577.696,176.125);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (671.612,-689.36,186.96);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (914.928,-1039.51,244.97);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (672.781,-1454.14,273.105);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1695.88,-1348.46,238.046);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2428.12,-395.565,288.122);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1102.86,-2231.27,143.999);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1240.59,-2957.3,99.2566);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1675.8,-3203.36,123.88);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2397.54,-2742.19,99.4899);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2203.36,-2133.85,-17.8656);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2210.27,-1370.78,-13.8699);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1163.34,-1124.65,23.1279);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1020.8,-3492.9,94.0181);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (223.932,-3464.44,228.627);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2171.09,-4619.85,358.093);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-2220.08,-5202.24,388.127);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3394.76,-1871.78,-5.56388);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3643.9,-2789.6,148.126);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1935.81,-4601.36,356.125);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-1821.63,-4425.31,312.055);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-5013.91,6160.46,-161.406);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-3535,4635.2,-151.093);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-5413.44,3645.18,-142.919);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-5885.3,4503.57,115.291);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (764.024,-3304.87,174.913);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (2362.01,-639.772,282.623);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (1853.81,-431.291,179.374);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (144.936,-1421,394.01);
	level.slasherteleportpoints[level.slasherteleportpoints.size] = (-720.185,-1075.81,398.18);
}

//Function Number: 83
setup_rave_mode_door(param_00)
{
	if(isdefined(param_00.var_86A2) && param_00.var_86A2 == "rave_door")
	{
		param_00 makeunusable();
		var_01 = getentarray(param_00.target,"targetname");
		foreach(var_03 in var_01)
		{
			if(isdefined(var_03.script_noteworthy) && var_03.script_noteworthy == "rave_objects")
			{
				if(isdefined(var_03.target))
				{
					var_04 = scripts\common\utility::getstructarray(var_03.target,"targetname");
					foreach(var_06 in var_04)
					{
						var_06 setup_rave_shimmer_fx(var_03);
					}
				}
			}
		}
	}
}

//Function Number: 84
cp_rave_get_alias_2d_version(param_00,param_01,param_02)
{
	var_03 = strtok(param_01,"_");
	if(var_03[0] == "ww" || var_03[0] == "dj" || var_03[0] == "ks")
	{
		return param_01;
	}

	var_04 = param_00.var_134FD + "plr_" + param_02;
	if(soundexists(var_04))
	{
		return var_04;
	}

	return undefined;
}

//Function Number: 85
wait_for_pre_game_period()
{
	if(!isdefined(level.agent_funcs))
	{
		level.agent_funcs = [];
	}

	level.current_rave_interaction_structs = [];
	wait(0.2);
	lib_0D4D::enable_windows_in_area("front_gate");
	scripts\common\utility::flag_set("zombie_drop_powerups");
	scripts\common\utility::flag_set("pillage_enabled");
	init_magic_wheel();
	level thread lib_0D55::func_6B8F();
	scripts\common\utility::flag_set("pre_game_over");
	level thread setupmemoryquestitems();
	level thread init_boat_and_pap_quest_structs();
	level thread scripts\cp\maps\cp_rave\cp_rave_memory_quests::set_up_ring_quest_interactions();
	level.agent_funcs["generic_zombie"]["on_damaged"] = ::scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiedamaged;
	level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiekilled;
	level.agent_funcs["slasher"]["on_damaged"] = ::scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiedamaged;
}

//Function Number: 86
init_magic_wheel()
{
	var_00 = ["messhall","rave","lake_shore"];
	scripts\cp\zombies\interaction_magicwheel::set_magic_wheel_starting_location(scripts\common\utility::random(var_00));
}

//Function Number: 87
func_4773()
{
	level.pillageinfo = spawnstruct();
	level.pillageinfo.default_use_time = 500;
	level.pillageinfo.var_B94E = "pb_money_stack_01";
	level.pillageinfo.var_2487 = "has_spotter_scope";
	level.pillageinfo.var_B47D = "mil_ammo_case_1_open";
	level.pillageinfo.var_4224 = "weapon_baseweapon_clip";
	level.pillageinfo.var_D73C = "misc_interior_card_game_01";
	level.pillageinfo.var_859A = "frag_grenade_wm";
	level.pillageinfo.ui_searching = 1;
	level.pillageable_powers = ["power_speedBoost","power_phaseShift","power_kineticPulse","power_teleport","power_barrier"];
	level.pillageable_explosives = ["power_clusterGrenade","power_gasGrenade","power_splashGrenade","power_bioSpike","power_semtex","power_frag"];
	level.pillageable_attachments = ["reflex","grip","barrelrange","xmags","overclock","fastaim","rof"];
	level.pillageinfo.clip = 33;
	level.pillageinfo.explosive = 33;
	level.pillageinfo.money = 33;
	lib_0D5E::register_zombie_pillageable("backpack_1","backpack","cp_rave_backpack_dropped","cp_rave_backpack","j_spine4");
	lib_0D5E::register_zombie_pillageable("backpack_2","backpack","cp_rave_backpack_dropped_green","cp_rave_backpack_green","j_spine4");
	lib_0D5E::register_zombie_pillageable("backpack_3","backpack","cp_rave_backpack_dropped_purple","cp_rave_backpack_purple","j_spine4");
	lib_0D5E::register_zombie_pillageable("backpack_4","backpack","cp_rave_backpack_dropped_red","cp_rave_backpack_red","j_spine4");
	lib_0D5E::register_zombie_pillageable("fanny_pack_1","backpack","zombies_fanny_pack_dropped","zombies_fanny_pack","J_HipTwist_LE");
	lib_0D5E::register_zombie_pillageable("fanny_pack_3","backpack","zombies_fanny_pack_dropped_purple","zombies_fanny_pack_purple","J_HipTwist_LE");
}

//Function Number: 88
func_4771()
{
	var_00 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_RAVE_INTRO_LINE_1",1);
	wait(1);
	var_01 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_RAVE_INTRO_LINE_2",2);
	wait(1);
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		var_02 = scripts\cp\_hud_util::introscreen_corner_line(&"DIRECT_BOSS_FIGHT_LINE4_RAVE",4);
	}
	else
	{
		var_02 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_RAVE_INTRO_LINE_3",3);
	}

	wait(1);
	var_03 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_RAVE_INTRO_LINE_4",4);
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

//Function Number: 89
func_4774(param_00)
{
	if(scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		return 1;
	}

	return !scripts\cp\_laststand::player_in_laststand(param_00);
}

//Function Number: 90
init_boat_and_pap_quest_structs()
{
	var_00 = scripts\common\utility::getstructarray("pap_quest_piece","script_noteworthy");
	var_01 = scripts\common\utility::getstructarray("boat_quest_piece","script_noteworthy");
	foreach(var_03 in var_00)
	{
		var_03.var_86A2 = "locOverride";
	}

	foreach(var_03 in var_01)
	{
		var_03.var_86A2 = "locOverride";
	}
}

//Function Number: 91
setupmemoryquestitems()
{
	var_00 = scripts\common\utility::getstructarray("memory_quest_start_pos","script_noteworthy");
	var_01 = scripts\common\utility::getstructarray("memory_quest_end_pos","script_noteworthy");
	var_02 = scripts\common\utility::func_22A8(var_00);
	var_03 = [];
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		var_05 = var_02[var_04];
		if(isdefined(var_05.name) && scripts\common\utility::func_2286(var_03,var_05.name))
		{
			var_05 thread delay_remove_from_interactions(var_05);
			continue;
		}

		var_03[var_03.size] = var_05.name;
		var_05.var_92B8 = var_05.name;
		var_05.name = var_05.script_noteworthy;
		var_05.ravetriggered = 0;
		var_05.currentlyownedby = [];
		var_05.var_86A2 = "locOverride";
		add_to_current_rave_interaction_list(var_05);
	}

	level.rave_mode_activation_funcs["memory_quest_start_pos"] = ::memory_start_struct_mode;
	level.normal_mode_activation_funcs["memory_quest_start_pos"] = ::memory_start_struct_mode;
	level.rave_mode_activation_funcs["memory_quest_end_pos"] = ::memory_struct_rave_mode;
	level.normal_mode_activation_funcs["memory_quest_end_pos"] = ::memory_struct_normal_mode;
	foreach(var_07 in var_01)
	{
		var_07.var_1604 = 0;
		var_07.var_86A2 = "locOverride";
		var_07.player_has_charm = 0;
	}
}

//Function Number: 92
delay_remove_from_interactions(param_00)
{
	param_00 notify("delay_interaction_array");
	param_00 endon("delay_interaction_array");
	scripts\common\utility::flag_wait("interactions_initialized");
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
}

//Function Number: 93
delay_add_to_interactions(param_00)
{
	param_00 notify("delay_interaction_array");
	param_00 endon("delay_interaction_array");
	scripts\common\utility::flag_wait("interactions_initialized");
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 94
get_valid_id(param_00)
{
	var_01 = ["pacifier","shovel","tiki_mask","arrowhead","lure","toad","pool_ball","ring","binoculars","boots"];
	var_02 = scripts\common\utility::getstructarray("memory_quest_end_pos","script_noteworthy");
	var_03 = sortbydistance(var_02,param_00);
	var_04 = [];
	for(var_05 = 0;var_05 < var_01.size;var_05++)
	{
		foreach(var_07 in var_03)
		{
			if(var_01[var_05] == var_07.name)
			{
				if(var_05 == 0)
				{
					continue;
				}
				else
				{
					return var_05;
				}
			}
		}
	}
}

//Function Number: 95
setupravetoys()
{
	var_00 = scripts\common\utility::getstructarray("rave_toys","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.var_EE24))
		{
			var_02.rave_model = var_02.var_EE24;
			var_02.normal_model = var_02.var_EE24;
		}

		var_02.name = var_02.script_noteworthy;
		var_02.ravetriggered = 0;
		var_02.var_86A2 = "locOverride";
		add_to_current_rave_interaction_list(var_02);
	}
}

//Function Number: 96
getscriptablestatefromstructmodel(param_00,param_01)
{
	switch(param_01)
	{
		case "zmb_spaceland_discoball_toy":
			if(param_00)
			{
				return "discoball";
			}
			else
			{
				return undefined;
			}
	
			break;

		default:
			return undefined;
	}
}

//Function Number: 97
setup_slide()
{
	var_00 = getent("slide","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(scripts\common\utility::istrue(var_01.onslide))
		{
			continue;
		}

		if(isplayer(var_01) && var_01 scripts\cp\_utility::is_valid_player(1))
		{
			var_01.onslide = 1;
			var_01 thread player_down_slide(var_00);
		}
	}
}

//Function Number: 98
player_down_slide(param_00)
{
	self endon("disconnect");
	self.is_slide_sfx_playing = 0;
	self.is_slide_land_sfx_playing = 0;
	var_01 = scripts\common\utility::getstruct("slide_dir_struct","targetname");
	while(self isjumping())
	{
		wait(0.05);
	}

	scripts\common\utility::allow_weapon(0);
	scripts\common\utility::allow_jump(0);
	self limitedmovement(1);
	self allowprone(0);
	self allowstand(0);
	scripts\cp\_utility::allow_player_teleport(0,"slide");
	thread slide_anim();
	while(self istouching(param_00))
	{
		if(scripts\cp\_laststand::player_in_laststand(self))
		{
			thread last_stand_player_down_slide(var_01);
			return;
		}

		self.ability_invulnerable = 1;
		self.disable_consumables = 1;
		if(self.is_slide_sfx_playing == 0)
		{
			self.is_slide_sfx_playing = 1;
		}

		self setvelocity(vectornormalize(var_01.origin - self.origin) * 500);
		wait(0.05);
	}

	self.ability_invulnerable = undefined;
	self notify("offslide");
	var_02 = self playanimscriptevent("power_active_cp","gesture014");
	self.is_slide_sfx_playing = 0;
	if(self.is_slide_land_sfx_playing == 0)
	{
		self.is_slide_land_sfx_playing = 1;
	}

	self limitedmovement(0);
	self.disable_consumables = undefined;
	self stopgestureviewmodel("ges_slide");
	scripts\common\utility::allow_jump(1);
	scripts\common\utility::allow_weapon(1);
	self allowprone(1);
	self allowcrouch(1);
	self allowstand(1);
	self setstance("stand");
	if(!scripts\cp\_utility::isteleportenabled())
	{
		scripts\cp\_utility::allow_player_teleport(1,"slide");
	}

	self.onslide = undefined;
	self notify("can_teleport");
}

//Function Number: 99
slide_anim()
{
	self endon("last_stand");
	self endon("death");
	self endon("disconnect");
	self endon("offslide");
	self endon("stopslideanim");
	var_00 = 0;
	while(scripts\common\utility::istrue(self.onslide))
	{
		if(self isgestureplaying())
		{
			wait(0.1);
			continue;
		}

		if(!var_00)
		{
			self playanimscriptevent("power_active_cp","gesture012");
			wait(0.1);
			var_00 = 1;
		}

		self playanimscriptevent("power_active_cp","gesture013");
		self playgestureviewmodel("ges_slide",undefined,0);
		wait(0.1);
	}
}

//Function Number: 100
last_stand_player_down_slide(param_00)
{
	self endon("disconnect");
	self notify("stopslideanim");
	if(scripts\cp\_laststand::self_revive_activated())
	{
		reset_slide_variables();
		self setorigin(param_00.origin);
		return;
	}

	if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && scripts\cp\_utility::has_zombie_perk("perk_machine_revive"))
	{
		reset_slide_variables();
		self setorigin(param_00.origin);
		return;
	}

	self setorigin(param_00.origin);
	reset_slide_variables();
}

//Function Number: 101
reset_slide_variables()
{
	self unlink();
	if(isdefined(self.anchor))
	{
		self.anchor delete();
	}

	self limitedmovement(0);
	self.disable_consumables = undefined;
	self stopgestureviewmodel("ges_slide");
	scripts\common\utility::allow_jump(1);
	self setstance("stand");
	self allowprone(1);
	self allowstand(1);
	self allowcrouch(1);
	scripts\common\utility::allow_weapon(1);
	if(!scripts\cp\_utility::isteleportenabled())
	{
		scripts\cp\_utility::allow_player_teleport(1,"slide");
	}

	self.onslide = undefined;
	self notify("can_teleport");
}

//Function Number: 102
setup_rave_shimmer_fx(param_00)
{
	if(!isdefined(param_00.spawnedfx))
	{
		param_00.spawnedfx = [];
	}

	var_01 = spawnfx(level._effect["rave_shimmer"],self.origin);
	wait(0.5);
	triggerfx(var_01);
	param_00.spawnedfx[param_00.spawnedfx.size] = var_01;
}

//Function Number: 103
watchforplayerzonechange(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	scripts\common\utility::flag_wait("init_interaction_done");
	var_01 = getent("rave_zone_change","targetname");
	for(;;)
	{
		if(param_00 istouching(var_01))
		{
			var_02 = gettime();
			if(var_02 < param_00.zonechangecooldown)
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			param_00 notify("rave_status_changed");
			param_00.zonechangecooldown = gettime() + 1000;
		}

		wait(0.1);
	}
}

//Function Number: 104
cp_rave_onplayerspawned()
{
	thread scripts\cp\powers\coop_powers::power_watch_hint(1);
	level thread func_100F5(self);
	foreach(var_01 in level.players)
	{
		if(var_01 == self)
		{
			continue;
		}

		if(isdefined(var_01.rave_dust_pouch))
		{
			var_01.rave_dust_pouch method_8429(self);
		}
	}

	if(scripts\common\utility::istrue(level.forceravemode))
	{
		self.unlimited_rave = 1;
		level thread func_6619(self);
	}
}

//Function Number: 105
func_4772(param_00)
{
	param_00 thread assignravemodelents(param_00);
	param_00 thread moveraveentstostructs(param_00);
	param_00.zonechangecooldown = 0;
	param_00 thread watchforplayerzonechange(param_00);
	param_00 thread func_13A7F(param_00);
	param_00 thread watchforstickerachievement(param_00);
	param_00 scripts\cp\zombies\zombies_rave_meter::init_rave_meter(param_00);
	var_01 = param_00 getplayerdata("cp","haveSoulKeys","any_soul_key");
	var_02 = param_00 getplayerdata("cp","haveSoulKeys","soul_key_1");
	if(var_02)
	{
		param_00.has_zis_soul_key = 1;
	}

	level thread watch_player_on_ladders(param_00);
	thread run_pap_machine_logic(param_00);
	thread run_harpoon_interaction_logic(param_00);
	if(!isdefined(level.kick_player_queue))
	{
		level thread kick_player_queue_loop();
	}

	param_00 thread kick_for_inactivity(param_00);
}

//Function Number: 106
watchforstickerachievement(param_00)
{
	level endon("game_ended");
	param_00 endon("all_collected");
	param_00 endon("disconnect");
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	for(;;)
	{
		if(scripts\common\utility::flag("pap_fixed"))
		{
			var_01 = 1;
		}

		if(scripts\common\utility::flag("owl_quest_completed") && scripts\common\utility::flag("wolf_quest_completed") && scripts\common\utility::flag("eagle_quest_completed") && scripts\common\utility::flag("deer_quest_completed"))
		{
			var_05 = 1;
		}

		if(scripts\common\utility::func_6E34("survivor_got_to_island") && scripts\common\utility::flag("survivor_got_to_island"))
		{
			var_03 = 1;
		}

		if(isdefined(level.charms_collected) && level.charms_collected >= 10)
		{
			var_04 = 1;
		}

		if(isdefined(level.boat_pieces_found) && level.boat_pieces_found == 3)
		{
			var_02 = 1;
		}

		if(var_01 && var_05 && var_03 && var_04 && var_02)
		{
			param_00 lib_0D2A::func_12D7C("SCRAPBOOKING",1);
			param_00 notify("all_collected");
		}

		wait(1);
	}
}

//Function Number: 107
run_harpoon_interaction_logic(param_00)
{
	while(!isdefined(level.harpoon_interactions))
	{
		wait(0.1);
	}

	while(!isdefined(level.players) || level.players.size < 1)
	{
		wait(0.1);
	}

	foreach(var_02 in level.harpoon_interactions)
	{
		var_03 = 0;
		foreach(param_00 in level.players)
		{
			if(isdefined(param_00.harpoon_interaction) && param_00.harpoon_interaction == var_02)
			{
				var_03 = 1;
			}
		}

		if(!var_03)
		{
			param_00.harpoon_interaction = var_02;
			break;
		}
	}

	if(!isdefined(param_00.harpoon_interaction))
	{
	}

	foreach(var_02 in level.harpoon_interactions)
	{
		if(param_00.harpoon_interaction != var_02)
		{
			scripts\cp\_interaction::func_E01A(var_02,param_00);
		}
	}
}

//Function Number: 108
run_pap_machine_logic(param_00)
{
	wait(3);
	var_01 = getent("pap_machine","targetname");
	var_02 = spawn("script_model",var_01.origin);
	var_02.angles = var_01.angles;
	if(scripts\common\utility::istrue(param_00.has_zis_soul_key) || scripts\common\utility::istrue(level.placed_alien_fuses))
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

//Function Number: 109
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

//Function Number: 110
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

//Function Number: 111
func_13A7F(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		param_00 waittill("weapon_change",var_01);
		var_02 = getweaponbasename(var_01);
		if(is_weapon_valid_primary(var_02))
		{
			param_00.last_valid_weapon = var_01;
		}

		if(isdefined(level.weapon_change_func[var_02]))
		{
			param_00 thread [[ level.weapon_change_func[var_02] ]](param_00);
		}
	}
}

//Function Number: 112
is_weapon_valid_primary(param_00)
{
	var_01 = level.additional_laststand_weapon_exclusion;
	if(param_00 == "none")
	{
		return 0;
	}

	if(scripts\common\utility::func_2286(var_01,param_00))
	{
		return 0;
	}

	if(scripts\common\utility::func_2286(var_01,getweaponbasename(param_00)))
	{
		return 0;
	}

	if(scripts\cp\_utility::func_9C42(param_00,1))
	{
		return 0;
	}

	return 1;
}

//Function Number: 113
assignravemodelents(param_00)
{
	param_00.ravemodeents = [];
	for(var_01 = 0;var_01 < 10;var_01++)
	{
		var_02 = spawn("script_model",(0,0,-5000));
		var_02.var_C3A2 = (0,0,-5000);
		var_02 setmodel("tag_origin");
		var_02.var_3FF2 = 0;
		var_02.var_1305B = 0;
		param_00.ravemodeents[param_00.ravemodeents.size] = var_02;
	}

	param_00 thread cleanup_ents_on_disconnect(param_00);
}

//Function Number: 114
cleanup_ents_on_disconnect(param_00)
{
	level endon("game_ended");
	var_01 = param_00.ravemodeents;
	param_00 waittill("disconnect");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03))
		{
			var_03 delete();
		}
	}
}

//Function Number: 115
moveraveentstostructs(param_00)
{
	param_00 endon("disconnect");
	if(!scripts\common\utility::flag("init_interaction_done"))
	{
		scripts\common\utility::flag_wait("init_interaction_done");
	}

	var_01 = ["zmb_spaceland_discoball_toy"];
	var_02 = ["zmb_spaceland_discoball_toy"];
	var_03 = scripts\common\utility::istrue(param_00.var_DCEB);
	for(;;)
	{
		param_00.rave_mode_updating = 1;
		var_04 = 0;
		var_05 = 0;
		if(scripts\common\utility::istrue(param_00.var_DCEB) != var_03)
		{
			var_03 = scripts\common\utility::istrue(param_00.var_DCEB);
			var_05 = 1;
		}

		var_06 = scripts\common\utility::func_782F(param_00.origin,level.current_rave_interaction_structs,undefined,100);
		var_06 = removeinvalidstructs(var_06,param_00);
		var_06 = sortbydistance(var_06,param_00.origin);
		param_00 resetents(param_00,var_06);
		foreach(var_08 in var_06)
		{
			var_09 = 0;
			if(var_08 hasplayerentattached(param_00,var_08))
			{
				var_0A = getattachedpersonalent(param_00,var_08);
				if(isdefined(var_0A))
				{
					if(var_05)
					{
						if(scripts\common\utility::istrue(param_00.var_DCEB))
						{
							if(isdefined(var_08.script_noteworthy) && isdefined(level.rave_mode_activation_funcs[var_08.script_noteworthy]))
							{
								var_09 = 1;
								var_0A [[ level.rave_mode_activation_funcs[var_08.script_noteworthy] ]](var_0A,var_08,0,param_00);
							}
							else if(isdefined(var_08.rave_model))
							{
								var_0A setmodel(var_08.rave_model);
							}
							else
							{
								var_0A setmodel(scripts\common\utility::random(var_01));
							}
						}
						else if(isdefined(var_08.script_noteworthy) && isdefined(level.normal_mode_activation_funcs[var_08.script_noteworthy]))
						{
							var_09 = 1;
							var_0A [[ level.normal_mode_activation_funcs[var_08.script_noteworthy] ]](var_0A,var_08,0,param_00);
						}
						else if(isdefined(var_08.normal_model))
						{
							var_0A setmodel(var_08.normal_model);
						}
						else
						{
							var_0A setmodel(scripts\common\utility::random(var_02));
						}
					}
					else if(scripts\common\utility::istrue(param_00.var_DCEB))
					{
						if(isdefined(var_08.script_noteworthy) && isdefined(level.rave_mode_activation_funcs[var_08.script_noteworthy]))
						{
							var_09 = 1;
							var_0A [[ level.rave_mode_activation_funcs[var_08.script_noteworthy] ]](var_0A,var_08,1,param_00);
						}
					}
					else if(isdefined(var_08.script_noteworthy) && isdefined(level.normal_mode_activation_funcs[var_08.script_noteworthy]))
					{
						var_09 = 1;
						var_0A [[ level.normal_mode_activation_funcs[var_08.script_noteworthy] ]](var_0A,var_08,1,param_00);
					}

					if(!var_09)
					{
						if(scripts\common\utility::istrue(param_00.var_DCEB))
						{
							if(isdefined(var_08.current_rave_state) && isdefined(var_08.current_rave_part))
							{
								var_0A setscriptablepartstate(var_08.current_rave_part,var_08.current_rave_state);
							}
						}
						else if(isdefined(var_08.current_normal_state) && isdefined(var_08.current_normal_part))
						{
							var_0A setscriptablepartstate(var_08.current_normal_part,var_08.current_normal_state);
						}
					}
				}

				continue;
			}

			var_0A = getunclaimedpersonalent(param_00,var_06);
			if(isdefined(var_0A))
			{
				var_08.currentlyownedby[param_00.name] = var_0A;
				var_0A.var_3FF2 = 1;
				var_0A.var_1305B = 1;
				var_0A dontinterpolate();
				var_0A.origin = var_08.origin;
				if(isdefined(var_08.angles))
				{
					var_0A.angles = var_08.angles;
				}
				else
				{
					var_0A.angles = (0,0,0);
				}

				if(scripts\common\utility::istrue(param_00.var_DCEB))
				{
					if(isdefined(var_08.script_noteworthy) && isdefined(level.rave_mode_activation_funcs[var_08.script_noteworthy]))
					{
						var_09 = 1;
						var_0A [[ level.rave_mode_activation_funcs[var_08.script_noteworthy] ]](var_0A,var_08,0,param_00);
					}
					else if(isdefined(var_08.rave_model))
					{
						var_0A setmodel(var_08.rave_model);
					}
					else
					{
						var_0A setmodel(scripts\common\utility::random(var_01));
					}
				}
				else if(isdefined(var_08.script_noteworthy) && isdefined(level.normal_mode_activation_funcs[var_08.script_noteworthy]))
				{
					var_09 = 1;
					var_0A [[ level.normal_mode_activation_funcs[var_08.script_noteworthy] ]](var_0A,var_08,0,param_00);
				}
				else if(isdefined(var_08.normal_model))
				{
					var_0A setmodel(var_08.normal_model);
				}
				else
				{
					var_0A setmodel(scripts\common\utility::random(var_02));
				}

				if(!var_09)
				{
					if(scripts\common\utility::istrue(param_00.var_DCEB))
					{
						if(isdefined(var_08.current_rave_state) && isdefined(var_08.current_rave_part))
						{
							var_0A setscriptablepartstate(var_08.current_rave_part,var_08.current_rave_state);
						}
					}
					else if(isdefined(var_08.current_normal_state) && isdefined(var_08.current_normal_part))
					{
						var_0A setscriptablepartstate(var_08.current_normal_part,var_08.current_normal_state);
					}
				}

				adjustmodelvis(param_00,var_0A);
			}
		}

		param_00.rave_mode_updating = undefined;
		param_00 notify("rave_mode_updated");
		param_00 scripts\common\utility::waittill_any_return_no_endon_death_3("zone_change","rave_status_changed","rave_interactions_updated");
	}
}

//Function Number: 116
memory_start_struct_mode(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01.name))
	{
		var_04 = param_01.name;
	}
	else
	{
		var_04 = undefined;
	}

	if(isdefined(var_04))
	{
		if(!isdefined(param_00.model) || isdefined(param_00.model) && param_00.model != "tag_origin_memory_quest")
		{
			param_00 setmodel("tag_origin_memory_quest");
		}

		var_05 = get_memory_attributes(var_04,undefined,!scripts\common\utility::istrue(param_03.var_DCEB),1,param_01);
		var_06 = set_memory_model(var_04,undefined,!scripts\common\utility::istrue(param_03.var_DCEB),param_00,1,param_01);
		for(var_07 = 0;var_07 < var_05.size;var_07++)
		{
			if(isdefined(var_05[var_07][0]) && isdefined(var_05[var_07][1]))
			{
				param_00 setscriptablepartstate(var_05[var_07][0],var_05[var_07][1]);
			}
		}
	}
}

//Function Number: 117
memory_struct_rave_mode(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01.name))
	{
		var_04 = param_01.name;
	}
	else
	{
		var_04 = undefined;
	}

	param_02 = scripts\common\utility::istrue(param_02);
	if(isdefined(var_04))
	{
		if(!isdefined(param_00.model) || isdefined(param_00.model) && param_00.model != "tag_origin_memory_quest")
		{
			param_00 setmodel("tag_origin_memory_quest");
		}

		if(isdefined(param_01.angles))
		{
			param_00.angles = param_01.angles;
		}

		var_05 = scripts\common\utility::istrue(param_01.var_1604);
		var_06 = get_memory_attributes(var_04,var_05,0,0,param_01);
		var_07 = set_memory_model(var_04,var_05,0,param_00,0,param_01);
		for(var_08 = 0;var_08 < var_06.size;var_08++)
		{
			if(isdefined(var_06[var_08][0]) && isdefined(var_06[var_08][1]))
			{
				param_00 setscriptablepartstate(var_06[var_08][0],var_06[var_08][1]);
			}
		}
	}
}

//Function Number: 118
set_memory_model(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_01 = scripts\common\utility::istrue(param_01);
	param_02 = scripts\common\utility::istrue(param_02);
	var_06 = scripts\common\utility::istrue(param_04);
	if(param_00 == "memory_quest_start_pos")
	{
		switch(param_05.var_92B8)
		{
			case "pacifier":
				param_03 setscriptablepartstate("model","pacifier");
				break;

			case "shovel":
				param_03 setscriptablepartstate("model","shovel");
				break;

			case "tiki_mask":
				param_03 setscriptablepartstate("model","mask");
				break;

			case "arrowhead":
				param_03 setscriptablepartstate("model","arrowhead");
				break;

			case "lure":
				param_03 setscriptablepartstate("model","lure");
				break;

			case "toad":
				param_03 setscriptablepartstate("model","toad");
				break;

			case "pool_ball":
				param_03 setscriptablepartstate("model","8ball");
				break;

			case "ring":
				param_03 setscriptablepartstate("model","ring");
				break;

			case "binoculars":
				param_03 setscriptablepartstate("model","binoculars");
				break;

			case "boots":
				param_03 setscriptablepartstate("model","boots");
				break;
		}

		return;
	}

	switch(param_00)
	{
		case "shovel":
			if(var_06)
			{
				param_03 setscriptablepartstate("model","shovel");
			}
			else if(param_02)
			{
				if(param_01)
				{
					param_03 setscriptablepartstate("model","shovel");
				}
				else
				{
					param_03 setscriptablepartstate("model","neutral");
				}
			}
			else if(param_01)
			{
				param_03 setscriptablepartstate("model","shovel");
			}
			else
			{
				param_03 setscriptablepartstate("model","neutral");
			}
			break;

		case "tiki_mask":
			if(var_06)
			{
				param_03 setscriptablepartstate("model","mask");
			}
			else if(param_02)
			{
				if(param_01)
				{
					param_03 setscriptablepartstate("model","mask");
				}
				else
				{
					param_03 setscriptablepartstate("model","neutral");
				}
			}
			else if(param_01)
			{
				param_03 setscriptablepartstate("model","mask");
			}
			else
			{
				param_03 setscriptablepartstate("model","neutral");
			}
			break;

		case "arrowhead":
			if(var_06)
			{
				param_03 setscriptablepartstate("model","arrowhead");
			}
			else if(param_02)
			{
				if(param_01)
				{
					param_03 setscriptablepartstate("model","arrowhead");
				}
				else
				{
					param_03 setscriptablepartstate("model","neutral");
				}
			}
			else if(param_01)
			{
				param_03 setscriptablepartstate("model","arrowhead");
			}
			else
			{
				param_03 setscriptablepartstate("model","neutral");
			}
			break;

		case "lure":
			if(var_06)
			{
				param_03 setscriptablepartstate("model","lure");
			}
			else if(param_02)
			{
				if(param_01)
				{
					param_03 setscriptablepartstate("model","lure");
				}
				else
				{
					param_03 setscriptablepartstate("model","neutral");
				}
			}
			else if(param_01)
			{
				param_03 setscriptablepartstate("model","lure");
			}
			else
			{
				param_03 setscriptablepartstate("model","neutral");
			}
			break;

		case "toad":
			if(var_06)
			{
				param_03 setscriptablepartstate("model","toad");
			}
			else if(param_02)
			{
				if(param_01)
				{
					param_03 setscriptablepartstate("model","toad");
				}
				else
				{
					param_03 setscriptablepartstate("model","neutral");
				}
			}
			else if(param_01)
			{
				param_03 setscriptablepartstate("model","toad");
			}
			else
			{
				param_03 setscriptablepartstate("model","neutral");
			}
			break;

		case "pool_ball":
			if(var_06)
			{
				param_03 setscriptablepartstate("model","8ball");
			}
			else if(param_02)
			{
				if(param_01)
				{
					param_03 setscriptablepartstate("model","8ball");
				}
				else
				{
					param_03 setscriptablepartstate("model","neutral");
				}
			}
			else if(param_01)
			{
				param_03 setscriptablepartstate("model","8ball");
			}
			else
			{
				param_03 setscriptablepartstate("model","neutral");
			}
			break;

		case "boots":
			if(var_06)
			{
				param_03 setscriptablepartstate("model","boots");
			}
			else if(param_02)
			{
				if(param_01)
				{
					param_03 setscriptablepartstate("model","boots");
				}
				else
				{
					param_03 setscriptablepartstate("model","neutral");
				}
			}
			else if(param_01)
			{
				param_03 setscriptablepartstate("model","boots");
			}
			else
			{
				param_03 setscriptablepartstate("model","neutral");
			}
			break;

		case "ring":
			if(var_06)
			{
				param_03 setscriptablepartstate("model","ring");
			}
			else if(param_02)
			{
				if(param_01)
				{
					param_03 setscriptablepartstate("model","ring");
				}
				else
				{
					param_03 setscriptablepartstate("model","neutral");
				}
			}
			else if(param_01)
			{
				param_03 setscriptablepartstate("model","ring");
			}
			else
			{
				param_03 setscriptablepartstate("model","neutral");
			}
			break;

		case "pacifier":
			if(var_06)
			{
				param_03 setscriptablepartstate("model","pacifier");
			}
			else if(param_02)
			{
				if(param_01)
				{
					param_03 setscriptablepartstate("model","pacifier");
				}
				else
				{
					param_03 setscriptablepartstate("model","neutral");
				}
			}
			else if(param_01)
			{
				param_03 setscriptablepartstate("model","pacifier");
			}
			else
			{
				param_03 setscriptablepartstate("model","neutral");
			}
			break;

		case "binoculars":
			if(var_06)
			{
				param_03 setscriptablepartstate("model","binoculars");
			}
			else if(param_02)
			{
				if(param_01)
				{
					param_03 setscriptablepartstate("model","binoculars");
				}
				else
				{
					param_03 setscriptablepartstate("model","neutral");
				}
			}
			else if(param_01)
			{
				param_03 setscriptablepartstate("model","binoculars");
			}
			else
			{
				param_03 setscriptablepartstate("model","neutral");
			}
			break;

		default:
			if(var_06)
			{
				param_03 setscriptablepartstate("model","discoball");
				return;
			}
	
			if(param_01)
			{
				param_03 setscriptablepartstate("model","discoball");
				return;
			}
			param_03 setscriptablepartstate("model","neutral");
			break;
	}
}

//Function Number: 119
get_memory_attributes(param_00,param_01,param_02,param_03,param_04)
{
	param_01 = scripts\common\utility::istrue(param_01);
	param_02 = scripts\common\utility::istrue(param_02);
	var_05 = scripts\common\utility::istrue(param_03);
	var_06 = scripts\common\utility::istrue(param_04.ravetriggered);
	var_07 = [];
	switch(param_00)
	{
		case "memory_quest_start_pos":
			if(param_02)
			{
				var_07[var_07.size] = ["idle_effects","neutral"];
			}
			else
			{
				var_07[var_07.size] = ["idle_effects","neutral"];
			}
	
			var_07[var_07.size] = ["sound","neutral"];
			return var_07;

		case "ring":
			if(param_02)
			{
				if(param_01)
				{
				}
				else
				{
					var_07[var_07.size] = ["idle_effects","neutral"];
				}
			}
			else if(param_01)
			{
				var_07[var_07.size] = ["idle_effects","neutral"];
				var_07[var_07.size] = ["sound","neutral"];
			}
			else
			{
				var_07[var_07.size] = ["sound","idle"];
				var_07[var_07.size] = ["idle_effects","idle"];
			}
			return var_07;

		case "pacifier":
			if(param_02)
			{
				if(param_01)
				{
					var_07[var_07.size] = ["sound","neutral"];
					var_07[var_07.size] = ["idle_effects","neutral"];
				}
				else
				{
					var_07[var_07.size] = ["sound","neutral"];
					var_07[var_07.size] = ["idle_effects","neutral"];
				}
			}
			else if(param_01)
			{
				var_07[var_07.size] = ["idle_effects","neutral"];
				var_07[var_07.size] = ["sound","pacifier"];
			}
			else
			{
				var_07[var_07.size] = ["sound","idle"];
				var_07[var_07.size] = ["idle_effects","idle"];
			}
			return var_07;

		default:
			if(param_02)
			{
				if(param_01)
				{
				}
				else
				{
					var_07[var_07.size] = ["idle_effects","neutral"];
				}
			}
			else if(param_01)
			{
				var_07[var_07.size] = ["idle_effects","neutral"];
				var_07[var_07.size] = ["sound","neutral"];
			}
			else
			{
				var_07[var_07.size] = ["sound","idle"];
				var_07[var_07.size] = ["idle_effects","idle"];
			}
			return var_07;
	}
}

//Function Number: 120
memory_struct_normal_mode(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01.name))
	{
		var_04 = param_01.name;
	}
	else
	{
		var_04 = undefined;
	}

	param_02 = scripts\common\utility::istrue(param_02);
	if(isdefined(var_04))
	{
		if(!isdefined(param_00.model) || isdefined(param_00.model) && param_00.model != "tag_origin_memory_quest")
		{
			param_00 setmodel("tag_origin_memory_quest");
		}

		if(isdefined(param_01.angles))
		{
			param_00.angles = param_01.angles;
		}

		var_05 = scripts\common\utility::istrue(param_01.var_1604);
		var_06 = get_memory_attributes(var_04,var_05,1,0,param_01);
		var_07 = set_memory_model(var_04,var_05,1,param_00,0,param_01);
		for(var_08 = 0;var_08 < var_06.size;var_08++)
		{
			if(isdefined(var_06[var_08][0]) && isdefined(var_06[var_08][1]))
			{
				param_00 setscriptablepartstate(var_06[var_08][0],var_06[var_08][1]);
			}
		}
	}
}

//Function Number: 121
resetents(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00.ravemodeents)
	{
		var_05 = 0;
		foreach(var_07 in param_01)
		{
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

//Function Number: 122
removeinvalidstructs(param_00,param_01)
{
	var_02 = [];
	param_00 = sortbydistance(param_00,param_01.origin);
	foreach(var_04 in param_00)
	{
		if(!scripts\common\utility::istrue(param_01.var_DCEB) && scripts\common\utility::istrue(var_04.only_rave_mode))
		{
			continue;
		}

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
			if(var_02.size >= 10)
			{
				break;
			}

			continue;
		}

		var_02[var_02.size] = var_04;
		if(var_02.size >= 10)
		{
			break;
		}
	}

	return var_02;
}

//Function Number: 123
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

//Function Number: 124
hasplayerentattached(param_00,param_01)
{
	foreach(var_03 in param_00.ravemodeents)
	{
		if(var_03.origin == param_01.origin)
		{
			var_03.var_1305B = 1;
			return 1;
		}
	}

	return 0;
}

//Function Number: 125
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

//Function Number: 126
resetpersonalents(param_00,param_01)
{
	foreach(var_03 in param_00.ravemodeents)
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

//Function Number: 127
resetpersonalent(param_00)
{
	param_00 setmodel("tag_origin");
	param_00.var_3FF2 = 0;
	param_00.var_1305B = 0;
	param_00 dontinterpolate();
	param_00.origin = param_00.var_C3A2;
}

//Function Number: 128
getattachedpersonalent(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00.ravemodeents)
	{
		var_05 = 0;
		if(var_04.origin == param_01.origin)
		{
			var_05 = 1;
		}

		if(var_05)
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 129
getunclaimedpersonalent(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00.ravemodeents)
	{
		var_05 = 0;
		foreach(var_07 in param_01)
		{
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

//Function Number: 130
add_to_current_rave_interaction_list(param_00)
{
	level.current_rave_interaction_structs = scripts\common\utility::array_add(level.current_rave_interaction_structs,param_00);
}

//Function Number: 131
remove_from_current_rave_interaction_list(param_00)
{
	level.current_rave_interaction_structs = scripts\common\utility::func_22A9(level.current_rave_interaction_structs,param_00);
}

//Function Number: 132
func_6619(param_00)
{
	level.someones_in_rave = 1;
	level notify("player_entered_rave",param_00);
	param_00 thread scripts\cp\zombies\zombies_rave_meter::rave_meter_on(param_00);
	param_00 playlocalsound("amb_rave_mode_lr_start");
	param_00 method_82C3("cp_rave_mode",0.5,"reverb","filter","ambient");
	param_00.var_13445 = "cp_rave_rave_mode";
	param_00.current_rave_mode_timer = 30;
	param_00.var_DCEB = 1;
	param_00.rave_cash_scalar = 2;
	param_00 notify("rave_status_changed");
	param_00 thread scripts\cp\_vo::try_to_play_vo("ww_rave_mode","rave_mode_vo","highest",5,0,0,1);
	param_00 thread watch_time_in_rave();
	param_00 thread watch_player_kills_in_rave(param_00);
	param_00 thread play_enter_rave_gesture();
	param_00 setscriptablepartstate("rave_light","active");
	if(randomint(100) > 50)
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("enter_rave","rave_comment_vo");
	}
	else
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("rave_mental","rave_comment_vo");
	}

	setimpactfx("cp_rave_mode",param_00);
	param_00 thread watch_for_ground_pound(param_00);
	param_00 method_8488(1);
	param_00 method_85B9(1);
	func_F565(param_00);
	func_8EA1(param_00);
	if(isdefined(level.wave_num) && level.wave_num >= 10)
	{
		level thread spawn_slasher_after_timer(5);
	}
}

//Function Number: 133
watch_time_in_rave()
{
	level endon("player_exited_rave");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(level.wave_num < 10)
	{
		return;
	}

	var_00 = gettime();
	while(gettime() < var_00 + 300000)
	{
		scripts\common\utility::func_136F7();
	}

	lib_0D2A::func_12D7C("HALLUCINATION_NATION",1);
}

//Function Number: 134
play_enter_rave_gesture()
{
	self setweaponammostock("iw7_tripping_zm",1);
	self giveandfireoffhand("iw7_tripping_zm");
}

//Function Number: 135
watch_player_kills_in_rave(param_00)
{
	param_00 endon("exit_rave");
	param_00 endon("disconnect");
	for(;;)
	{
		level waittill("zombie_killed",var_01,var_02,var_03,var_04);
		if(isdefined(var_04) && var_04 == param_00)
		{
			param_00 scripts\cp\zombies\zombies_rave_meter::rave_meter_kill_decrement();
		}
	}
}

//Function Number: 136
watch_for_ground_pound(param_00)
{
	param_00 endon("exit_rave");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("groundPoundLand");
		var_01 = param_00.origin;
		playrumbleonposition("slide_collision",var_01);
		param_00 earthquakeforplayer(0.75,0.5,var_01,128);
		param_00 shellshock("frag_grenade_mp",0.5,1,0);
		var_02 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_03 = scripts\common\utility::func_782F(var_01,var_02,undefined,24,128);
		param_00.ground_pound_active = 1;
		param_00 thread spawn_ground_pound_flowers(param_00);
		if(isdefined(level.toad_ent_array))
		{
			foreach(var_05 in level.toad_ent_array)
			{
				if(!isdefined(var_05))
				{
					continue;
				}

				if(distance2dsquared(var_01,var_05.origin) <= 2500)
				{
					var_05 dodamage(10000,var_05.origin,param_00,param_00,"MOD_IMPACT","zom_groundpound_rave_mp");
					scripts\common\utility::func_22A9(level.toad_ent_array,var_05);
				}
			}
		}

		foreach(var_09, var_08 in var_03)
		{
			if(isdefined(var_08.agent_type) && var_08.agent_type == "superslasher" || var_08.agent_type == "slasher")
			{
				continue;
			}

			var_08 thread killnearbyvictim(param_00,var_08.maxhealth,var_08.origin,var_01,var_01);
			if(var_09 % 3 == 1)
			{
				scripts\common\utility::func_136F7();
			}
		}
	}
}

//Function Number: 137
spawn_ground_pound_flowers(param_00)
{
	var_01 = param_00.origin;
	var_02 = param_00.angles;
	var_03 = param_00 geteye();
	var_04 = vectornormalize(anglestoforward(var_02)) * 50;
	var_05 = -1 * vectornormalize(var_04) * 50;
	var_06 = vectornormalize(anglestoright(var_02)) * 50;
	var_07 = -1 * vectornormalize(var_06) * 50;
	var_08 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_vehicleclip","physicscontents_item","physicscontents_detail","physicscontents_vehicleclip","physicscontents_vehicle","physicscontents_canshootclip","physicscontents_missileclip","physicscontents_clipshot"]);
	var_09 = [];
	var_09[var_09.size] = scripts\common\utility::func_5D14(var_01 + var_04,32,-100);
	var_09[var_09.size] = scripts\common\utility::func_5D14(var_01 + var_05,32,-100);
	var_09[var_09.size] = scripts\common\utility::func_5D14(var_01 + var_06,32,-100);
	var_09[var_09.size] = scripts\common\utility::func_5D14(var_01 + var_07,32,-100);
	var_0A = [];
	foreach(var_0C in var_09)
	{
		var_0D = scripts\common\trace::func_DCED(var_03,var_0C,param_00,var_08);
		var_0E = scripts\common\utility::func_5D14(var_0D["position"],32,-2000);
		var_0A[var_0A.size] = var_0E;
	}

	var_10 = [];
	foreach(var_12 in var_0A)
	{
		var_0D = scripts\common\trace::func_DCED(var_12 + (0,0,32),var_12,param_00,var_08);
		var_13 = var_0D["normal"];
		var_10[var_10.size] = vectortoangles(vectornormalize(var_13 + (-90,0,0)));
	}

	for(var_15 = 0;var_15 < var_0A.size;var_15++)
	{
		var_16 = spawn("script_model",var_0A[var_15]);
		var_16 setmodel("foliage_flowers_blue_patch_iw6");
		var_16.angles = var_10[var_15];
		var_16 thread delete_flowers_after_timeout();
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 138
delete_flowers_after_timeout()
{
	wait(2.5);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 139
spawn_slasher_after_timer(param_00,param_01,param_02)
{
	wait(param_00);
	if(isdefined(level.slasher))
	{
		return;
	}

	if(level.no_slasher)
	{
		return;
	}

	scripts\cp\zombies\zombies_spawning::func_93EB(1);
	while(scripts\mp\_mp_agent::func_7EC6() < 1)
	{
		wait(0.1);
	}

	var_03 = scripts\cp\zombies\zombies_spawning::func_7C2E();
	if(isdefined(var_03) && !isdefined(level.slasher))
	{
		var_04 = var_03.origin;
		if(isdefined(param_01))
		{
			var_04 = param_01;
		}

		var_05 = var_03.angles;
		if(isdefined(param_02))
		{
			var_05 = param_02;
		}

		var_04 = getclosestpointonnavmesh(var_04);
		level.slasher = scripts\mp\_mp_agent::func_108E8("slasher","axis",var_04,var_05);
		level thread play_slasher_vo();
		if(isdefined(level.slasher))
		{
			if(!isdefined(level.zombie_slasher_vo_prefix))
			{
				level.zombie_slasher_vo_prefix = "zmb_vo_slasher_";
			}

			level.slasher method_85B7(1);
			level.slasher.var_13550 = level.zombie_slasher_vo_prefix;
			level.slasher thread clear_slasher_on_death();
			level.slasher thread slasher_enemy_monitor();
			level.slasher thread slasher_audio_monitor();
			return;
		}

		return;
	}

	scripts\cp\zombies\zombies_spawning::func_4FB8(1);
}

//Function Number: 140
play_slasher_vo()
{
	foreach(var_01 in level.players)
	{
		if(var_01.var_134FD == "p5_")
		{
			if(randomint(100) > 50)
			{
				if(scripts\common\utility::istrue(var_01.var_DCEB))
				{
					var_01 thread scripts\cp\_vo::try_to_play_vo("ww_slasher_spawn_p5","rave_mode_vo","highest",5,0,0,1);
					wait(6);
					var_01 thread scripts\cp\_vo::try_to_play_vo("slasher_first","zmb_comment_vo","highest",20,0,0,1);
				}
			}
			else if(!scripts\common\utility::istrue(level.slasher_first_spawn))
			{
				level.slasher_first_spawn = 1;
				if(scripts\common\utility::istrue(var_01.var_DCEB))
				{
					var_01 thread scripts\cp\_vo::try_to_play_vo("ww_slasher_firstspawn","rave_mode_vo","highest",5,0,0,1);
					wait(6);
					var_01 thread scripts\cp\_vo::try_to_play_vo("slasher_first","zmb_comment_vo","highest",20,0,0,1);
				}
			}
			else if(scripts\common\utility::istrue(var_01.var_DCEB))
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("ww_slasher_spawn","rave_mode_vo","highest",5,0,0,1);
				wait(6);
				var_01 thread scripts\cp\_vo::try_to_play_vo("slasher_generic","zmb_comment_vo","highest",20,0,0,1);
			}

			continue;
		}

		if(!scripts\common\utility::istrue(level.slasher_first_spawn))
		{
			level.slasher_first_spawn = 1;
			if(scripts\common\utility::istrue(var_01.var_DCEB))
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("ww_slasher_firstspawn","rave_mode_vo","highest",5,0,0,1);
				wait(6);
				var_01 thread scripts\cp\_vo::try_to_play_vo("slasher_first","zmb_comment_vo","highest",20,0,0,1);
			}

			continue;
		}

		if(scripts\common\utility::istrue(var_01.var_DCEB))
		{
			var_01 thread scripts\cp\_vo::try_to_play_vo("ww_slasher_spawn","rave_mode_vo","highest",5,0,0,1);
			wait(6);
			var_01 thread scripts\cp\_vo::try_to_play_vo("slasher_generic","zmb_comment_vo","highest",20,0,0,1);
		}
	}
}

//Function Number: 141
slasher_audio_monitor()
{
	level endon("game_ended");
	self endon("death");
	thread lib_0D62::func_CE9B(self.var_13550,undefined,1);
	self.var_D4AA = 0;
	for(;;)
	{
		var_00 = scripts\common\utility::waittill_any_timeout_1(6,"attack_hit","taunt","attack_charge","attack_shoot");
		switch(var_00)
		{
			case "attack_hit":
				level thread lib_0D62::func_CE9C(self,"attack_melee",0);
				break;
	
			case "attack_shoot":
				level thread lib_0D62::func_CE9C(self,"attack_saw_blade_shoot",0);
				break;
	
			case "taunt":
				level thread lib_0D62::func_CE9C(self,"taunt",0);
				break;
	
			case "attack_charge":
				level thread lib_0D62::func_CE9C(self,"charge_grunt",0);
				break;
	
			case "timeout":
				level thread lib_0D62::func_CE9C(self,"walk_idle_grunt",0);
				break;
		}
	}
}

//Function Number: 142
clear_slasher_on_death()
{
	self waittill("death");
	level thread scripts\cp\_vo::try_to_play_vo("ww_slasher_death","rave_announcer_vo","highest",5,0,0,1);
	level.slasher = undefined;
	scripts\cp\zombies\zombies_spawning::func_4FB8(1);
}

//Function Number: 143
slasher_enemy_monitor()
{
	self endon("death");
	for(;;)
	{
		var_00 = 1;
		if(isdefined(self.main_enemy))
		{
			if(self method_85B8() && isdefined(self.main_enemy.var_DCEB))
			{
				var_00 = 0;
			}
		}

		if(var_00)
		{
			self.main_enemy = undefined;
			var_01 = scripts\common\utility::array_randomize(level.players);
			foreach(var_03 in var_01)
			{
				if(isdefined(var_03.var_DCEB))
				{
					self.main_enemy = var_03;
					break;
				}
			}
		}

		if(isdefined(self.main_enemy))
		{
			var_05 = self.main_enemy method_8163();
			if(function_0218(var_05 + "_enemy"))
			{
				self method_834E(var_05 + "_enemy");
			}

			self.var_180 = 0;
		}
		else
		{
			self method_834E();
			self.var_180 = 1;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 144
get_num_players_in_rave_mode()
{
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.var_DCEB))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 145
func_695D(param_00)
{
	level notify("player_exited_rave",param_00);
	param_00 playlocalsound("amb_rave_mode_lr_end");
	param_00 method_8070(1);
	param_00 method_85B9(0);
	param_00.var_13445 = undefined;
	param_00.var_DCEB = undefined;
	param_00.rave_cash_scalar = undefined;
	param_00 method_8488(0);
	param_00 thread scripts\cp\_vo::try_to_play_vo("exit_rave","rave_comment_vo");
	param_00 notify("rave_status_changed");
	setimpactfx("cp_rave",param_00);
	param_00 setscriptablepartstate("rave_light","neutral");
	func_12C61(param_00);
	func_100F5(param_00);
	param_00 notify("exit_rave");
	check_level_rave_status();
	param_00 scripts\cp\zombies\zombies_rave_meter::rave_meter_off(param_00);
}

//Function Number: 146
check_level_rave_status()
{
	foreach(var_01 in level.players)
	{
		if(scripts\common\utility::istrue(var_01.var_DCEB))
		{
			return;
		}
	}

	level notify("rave_mode_empty");
	level.someones_in_rave = 0;
}

//Function Number: 147
create_rave_fx_walls_after_time()
{
	level endon("rave_mode_empty");
	level.someones_in_rave = 1;
	var_00 = scripts\common\utility::getstructarray("rave_fx_structs","targetname");
	foreach(var_02 in var_00)
	{
		var_02.var_3FF2 = undefined;
	}

	wait(30);
	while(scripts\common\utility::istrue(level.someones_in_rave))
	{
		var_04 = get_players_in_rave_mode();
		var_05 = getbestraveeffectstruct(var_04,var_00);
		if(isdefined(var_05))
		{
			var_05.var_3FF2 = 1;
			var_06 = getraveeffectfromstruct(var_05);
			var_07 = spawnfx(level._effect[var_06],var_05.origin,anglestoforward(var_05.angles),anglestoup(var_05.angles));
			triggerfx(var_07);
			level thread run_additional_rave_effects(var_06,var_05,var_07);
			level thread delete_rave_effects_when_empty(var_07);
			level thread update_rave_effect_visibility(var_07);
			wait(30);
			continue;
		}

		wait(randomintrange(5,10));
	}
}

//Function Number: 148
run_additional_rave_effects(param_00,param_01,param_02)
{
	switch(param_00)
	{
		case "vfx_fire_lrg":
			level thread create_fire_damage_trigger(param_00,param_01,param_02);
			break;

		case "rave_barrier_fx":
			level thread knockback_nearby_rave_players(param_01,param_02);
			break;

		default:
			break;
	}
}

//Function Number: 149
create_fire_damage_trigger(param_00,param_01,param_02)
{
	level endon("rave_mode_empty");
	param_02 endon("death");
	var_03 = spawn("trigger_radius",param_01.origin,1,100,60);
	var_03.team = "axis";
	level thread kill_ents_on_ravefx_death(param_00,param_01,param_02,var_03);
	for(;;)
	{
		var_03 waittill("trigger",var_04);
		if(!isplayer(var_04))
		{
			continue;
		}

		if(!scripts\common\utility::istrue(var_04.var_DCEB))
		{
			continue;
		}

		if(scripts\cp\_utility::is_valid_player(var_04))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_04.var_C85F))
		{
			continue;
		}

		var_04.var_C85F = 1;
		var_04 dodamage(34,var_04.origin);
		var_04 thread func_E069();
	}
}

//Function Number: 150
func_E069()
{
	self endon("disconnect");
	wait(0.5);
	self.var_C85F = undefined;
}

//Function Number: 151
kill_ents_on_ravefx_death(param_00,param_01,param_02,param_03)
{
	param_02 waittill("death");
	playsoundatpos(param_03.origin,"trap_kindle_pops_fire_end");
	param_03 stoploopsound();
	param_03 delete();
}

//Function Number: 152
knockback_nearby_rave_players(param_00,param_01)
{
	level endon("rave_mode_empty");
	param_01 endon("death");
	var_02 = param_00.origin;
	var_03 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	for(;;)
	{
		var_04 = get_players_in_rave_mode();
		foreach(var_06 in var_04)
		{
			if(scripts\common\utility::istrue(var_06.rave_knockback))
			{
				continue;
			}

			var_07 = distance2dsquared(var_06.origin,var_02);
			if(var_07 > -25536)
			{
				continue;
			}

			var_08 = getbestendpos(var_06,param_00,var_03);
			var_09 = getdistancetocheck(var_08,var_02,var_06);
			if(isdefined(var_09) && distance2dsquared(var_06.origin,var_02) < var_09 * var_09)
			{
				var_06.rave_knockback = 1;
				var_06 thread setvelocitybasedonplayerpos(var_06,var_02,var_08,param_01);
			}
		}

		wait(0.2);
	}
}

//Function Number: 153
setvelocitybasedonplayerpos(param_00,param_01,param_02,param_03)
{
	level endon("rave_mode_empty");
	param_00 endon("disconnect");
	param_03 endon("death");
	param_00 thread unset_rave_knockback(param_00);
	var_04 = distance2dsquared(param_00.origin,param_01) < 10000;
	param_00.var_BCF6 = 0.1;
	param_00 [[ level.var_BC70 ]]();
	while(var_04)
	{
		param_00 setvelocity(vectornormalize(param_02.origin + (0,0,-100) - param_00.origin) * 100);
		scripts\common\utility::func_136F7();
		var_05 = getdistancetocheck(param_02,param_01,param_00);
		var_04 = isdefined(var_05) && distance2dsquared(param_00.origin,param_01) < var_05 * var_05;
	}

	param_00.var_BCF6 = 1;
	param_00.rave_knockback = undefined;
	param_00 [[ level.var_BC70 ]]();
}

//Function Number: 154
getdistancetocheck(param_00,param_01,param_02)
{
	var_03 = cos(89);
	var_04 = vectortoangles(param_00.origin - param_01);
	var_05 = vectornormalize(param_02.origin - param_01);
	var_06 = anglestoforward(var_04);
	var_07 = vectordot(var_06,var_05);
	if(var_07 >= var_03)
	{
		return int(max(1 - var_07 / var_03 * 50,75));
	}

	return undefined;
}

//Function Number: 155
unset_rave_knockback(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	for(;;)
	{
		level scripts\common\utility::waittill_any_3("rave_mode_empty","player_entered_rave","player_exited_rave");
		if(scripts\common\utility::istrue(param_00.var_DCEB))
		{
			continue;
		}
		else
		{
			param_00.rave_knockback = undefined;
			param_00.var_BCF6 = 1;
			param_00 [[ level.var_BC70 ]]();
		}
	}
}

//Function Number: 156
getbestendpos(param_00,param_01,param_02)
{
	foreach(var_04 in param_02)
	{
		var_05 = vectortoangles(var_04.origin - param_01.origin);
		if(scripts\common\utility::func_13D90(param_01.origin,var_05,param_00.origin,cos(90)))
		{
			return var_04;
		}
	}

	return scripts\common\utility::random(param_02);
}

//Function Number: 157
getraveeffectfromstruct(param_00)
{
	if(isdefined(param_00.script_noteworthy))
	{
		return param_00.script_noteworthy;
	}

	return "rave_barrier_fx";
}

//Function Number: 158
update_rave_effect_visibility(param_00)
{
	level endon("rave_mode_empty");
	param_00 endon("death");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(scripts\common\utility::istrue(var_02.var_DCEB))
			{
				param_00 showtoplayer(var_02);
				continue;
			}

			param_00 method_8429(var_02);
		}

		level scripts\common\utility::waittill_any_3("player_exited_rave","player_entered_rave");
	}
}

//Function Number: 159
delete_rave_effects_when_empty(param_00)
{
	level waittill("rave_mode_empty");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 160
getbestraveeffectstruct(param_00,param_01)
{
	var_02 = 999999;
	var_03 = undefined;
	foreach(var_05 in param_01)
	{
		var_06 = undefined;
		if(scripts\common\utility::istrue(var_05.var_3FF2))
		{
			continue;
		}

		foreach(var_08 in param_00)
		{
			var_09 = distance2dsquared(var_08.origin,var_05.origin);
			if(var_09 > 6250000)
			{
				continue;
			}

			if(isdefined(var_06))
			{
				var_06 = var_06 + var_09;
				continue;
			}

			var_06 = var_09;
		}

		if(isdefined(var_06) && var_06 < var_02)
		{
			var_02 = var_06;
			var_03 = var_05;
		}
	}

	if(isdefined(var_03))
	{
		return var_03;
	}

	return undefined;
}

//Function Number: 161
get_players_in_rave_mode()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(scripts\common\utility::istrue(var_02.var_DCEB))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 162
func_12BA6(param_00)
{
	self endon("disconnect");
	self endon("exit_rave");
	self endon(param_00 + "_removed");
	if(!isdefined(self.var_13CA0))
	{
		self.var_13CA0 = self getweaponslistprimaries();
	}

	scripts\cp\_utility::enable_infinite_ammo(1);
	for(;;)
	{
		var_01 = 0;
		foreach(var_03 in self.var_13CA0)
		{
			if(var_03 == self getcurrentweapon() && func_13C30(var_03))
			{
				var_01 = 1;
				self setweaponammoclip(var_03,weaponclipsize(var_03),"left");
			}

			if(var_03 == self getcurrentweapon() && func_13C30(var_03))
			{
				var_01 = 1;
				self setweaponammoclip(var_03,weaponclipsize(var_03),"right");
			}

			if(var_01 == 0)
			{
				func_1E39();
			}
		}

		wait(0.05);
	}
}

//Function Number: 163
func_1E39(param_00)
{
	self endon("death");
	self endon("disconnect");
	var_01 = [];
	if(isdefined(param_00))
	{
		var_01[param_00] = self method_80FB(param_00);
	}
	else
	{
		foreach(param_00 in self.var_13CA0)
		{
			var_01[param_00] = self method_80FB(param_00);
		}
	}

	return var_01;
}

//Function Number: 164
updateperks(param_00,param_01)
{
	if(!isdefined(param_00.var_13FA4))
	{
		return;
	}

	var_02 = getarraykeys(param_00.var_13FA4);
	foreach(var_04 in var_02)
	{
		param_00 lib_0D5D::func_834E(var_04);
	}
}

//Function Number: 165
func_13C30(param_00)
{
	var_01 = 1;
	foreach(var_03 in level.var_C6C1)
	{
		if(param_00 == var_03)
		{
			var_01 = 0;
		}
	}

	return var_01;
}

//Function Number: 166
func_8EA1(param_00)
{
	var_01 = getentarray("rave_objects","script_noteworthy");
	foreach(var_03 in var_01)
	{
		var_03 method_8429(param_00);
	}

	update_rave_mode_doors();
	if(isdefined(level.active_archery_target))
	{
		level.active_archery_target showtoplayer(param_00);
	}

	if(isdefined(level.zombie_heads))
	{
		foreach(var_06 in level.zombie_heads)
		{
			var_06 showtoplayer(param_00);
		}
	}

	foreach(var_09 in level.wall_buy_interactions)
	{
		if(isdefined(var_09.trigger))
		{
			var_09.trigger method_8429(param_00);
		}

		scripts\cp\_interaction::func_E01A(var_09,param_00);
	}
}

//Function Number: 167
func_F565(param_00)
{
	param_00 visionsetnakedforplayer("cp_rave_rave_mode",1);
}

//Function Number: 168
func_12C61(param_00)
{
	param_00 visionsetnakedforplayer("cp_rave",1);
}

//Function Number: 169
func_100F5(param_00)
{
	var_01 = getentarray("rave_objects","script_noteworthy");
	foreach(var_03 in var_01)
	{
		var_03 showtoplayer(param_00);
	}

	update_rave_mode_doors();
	if(isdefined(level.active_archery_target))
	{
		level.active_archery_target method_8429(param_00);
	}

	if(!isdefined(level.zombie_heads))
	{
		while(!isdefined(level.zombie_heads))
		{
			wait(0.05);
		}
	}

	if(isdefined(level.zombie_heads))
	{
		foreach(var_06 in level.zombie_heads)
		{
			var_06 method_8429(param_00);
		}
	}

	foreach(var_09 in level.wall_buy_interactions)
	{
		if(scripts\common\utility::istrue(var_09.should_be_hidden))
		{
			continue;
		}

		if(isdefined(var_09.trigger))
		{
			var_09.trigger showtoplayer(param_00);
		}

		scripts\cp\_interaction::func_175D(var_09,param_00);
	}
}

//Function Number: 170
update_rave_mode_doors()
{
	var_00 = getentarray("rave_door_buy","targetname");
	foreach(var_02 in var_00)
	{
		var_02 makeusable();
		var_03 = getentarray(var_02.target,"targetname");
		foreach(var_05 in level.players)
		{
			if(scripts\common\utility::istrue(var_05.var_DCEB))
			{
				var_02 enableplayeruse(var_05);
			}
			else
			{
				var_02 disableplayeruse(var_05);
			}

			foreach(var_07 in var_03)
			{
				if(!isdefined(var_07.script_noteworthy))
				{
					continue;
				}

				if(var_07.script_noteworthy == "rave_door")
				{
					if(scripts\common\utility::istrue(var_05.var_DCEB))
					{
						var_07 showtoplayer(var_05);
					}
					else
					{
						var_07 method_8429(var_05);
					}

					continue;
				}

				if(var_07.script_noteworthy == "normal_door")
				{
					if(scripts\common\utility::istrue(var_05.var_DCEB))
					{
						var_07 method_8429(var_05);
						continue;
					}

					var_07 showtoplayer(var_05);
				}
			}
		}
	}
}

//Function Number: 171
cp_rave_spawn_fx_func()
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

			default:
				break;
		}
	}
}

//Function Number: 172
dirt_fx(param_00)
{
	self endon("death");
	self setscriptablepartstate("dirt","active");
	wait(param_00);
	self setscriptablepartstate("dirt","inactive");
}

//Function Number: 173
dirt_concrete_fx(param_00)
{
	self endon("death");
	self setscriptablepartstate("dirt_concrete","active");
	wait(param_00);
	self setscriptablepartstate("dirt_concrete","inactive");
}

//Function Number: 174
water_triggers()
{
	spawn_water_trigger((-2736,1478,-260));
	spawn_water_trigger((-2602,1782,-260));
	spawn_water_trigger((-2370,1912,-260));
	spawn_water_trigger((-2236,2212,-260));
	var_00 = getentarray("water_trigger","targetname");
	scripts\common\utility::array_thread(var_00,::water_trigger);
}

//Function Number: 175
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

//Function Number: 176
monitor_player_in_water(param_00)
{
	self endon("disconnect");
	if(scripts\cp\_laststand::player_in_laststand(self))
	{
		self.waterspeedscalar = 1;
		cp_rave_updatemovespeedscale();
		self.in_water = undefined;
		if(scripts\cp\_laststand::self_revive_activated())
		{
			return;
		}

		if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && scripts\cp\_utility::has_zombie_perk("perk_machine_revive"))
		{
			return;
		}

		if(param_00.origin != (1218,-201,-48))
		{
			move_player_to_closest_spot(self);
		}

		return;
	}

	if(scripts\common\utility::istrue(self.noslowmovement))
	{
		self.in_water = undefined;
		self.waterspeedscalar = 1;
		cp_rave_updatemovespeedscale();
		return;
	}

	scripts\common\utility::func_1C40(0);
	scripts\common\utility::func_1C60(0);
	while(self istouching(param_00))
	{
		if(self.waterspeedscalar > 0.5)
		{
			self.waterspeedscalar = self.waterspeedscalar - 0.05;
		}
		else
		{
			self.waterspeedscalar = 0.5;
		}

		if(scripts\cp\_laststand::player_in_laststand(self))
		{
			self.waterspeedscalar = 1;
			cp_rave_updatemovespeedscale();
			self.in_water = undefined;
			if(scripts\cp\_laststand::self_revive_activated())
			{
				move_player_to_closest_spot(self);
				return;
			}

			if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && scripts\cp\_utility::has_zombie_perk("perk_machine_revive"))
			{
				return;
			}

			move_player_to_closest_spot(self);
			return;
		}

		cp_rave_updatemovespeedscale();
		wait(0.05);
	}

	if(scripts\common\utility::istrue(self.var_55C3))
	{
		scripts\common\utility::func_1C40(1);
	}

	if(scripts\common\utility::istrue(self.var_55DC))
	{
		scripts\common\utility::func_1C60(1);
	}

	thread reset_move_speed();
}

//Function Number: 177
reset_move_speed(param_00)
{
	self endon("disconnect");
	self.in_water = undefined;
	wait(1);
	if(!scripts\common\utility::istrue(self.in_water))
	{
		if(scripts\common\utility::istrue(self.var_55C3))
		{
			scripts\common\utility::func_1C40(1);
		}

		if(scripts\common\utility::istrue(self.var_55DC))
		{
			scripts\common\utility::func_1C60(1);
		}
	}

	while(!scripts\common\utility::istrue(self.in_water))
	{
		if(self.waterspeedscalar < 1)
		{
			self.waterspeedscalar = self.waterspeedscalar + 0.05;
			cp_rave_updatemovespeedscale();
			continue;
		}

		self.waterspeedscalar = 1;
		cp_rave_updatemovespeedscale();
		return;
		wait(0.05);
	}
}

//Function Number: 178
move_player_to_closest_spot(param_00)
{
	var_01 = get_closest_valid_respawn_struct(param_00);
	var_02 = var_01.origin + (0,0,20);
	var_03 = getgroundposition(var_02,8,32,32);
	if(!isdefined(var_03))
	{
		var_03 = var_01.origin;
	}

	param_00 setorigin(var_03);
	wait(0.5);
}

//Function Number: 179
get_closest_valid_respawn_struct(param_00)
{
	var_01 = sortbydistance(level.water_respawn_points,param_00.origin);
	foreach(var_03 in var_01)
	{
		if(canspawn(var_03.origin) && !positionwouldtelefrag(var_03.origin))
		{
			return var_03;
		}
	}
}

//Function Number: 180
setup_generic_zombie_model_list()
{
	level.generic_zombie_model_list = ["zombie_male_outfit_dlc1_1","zombie_male_outfit_dlc1_1_2","zombie_male_outfit_dlc1_1_3","zombie_male_outfit_dlc1_1_4","zombie_male_outfit_dlc1_1_5","zombie_male_outfit_dlc1_1_6","zombie_male_outfit_dlc1_2","zombie_male_outfit_dlc1_2_2","zombie_male_outfit_dlc1_2_3","zombie_male_outfit_dlc1_2_4","zombie_male_outfit_dlc1_2_5","zombie_male_outfit_dlc1_2_6","zombie_male_outfit_dlc1_3","zombie_male_outfit_dlc1_3_2","zombie_male_outfit_dlc1_3_3","zombie_male_outfit_dlc1_3_4","zombie_male_outfit_dlc1_3_5","zombie_male_outfit_dlc1_3_6","zombie_male_outfit_dlc1_4","zombie_male_outfit_dlc1_4_2","zombie_male_outfit_dlc1_4_3","zombie_male_outfit_dlc1_5","zombie_male_outfit_dlc1_5_2","zombie_male_outfit_dlc1_5_3","zombie_male_outfit_dlc1_6","zombie_male_outfit_dlc1_6_2","zombie_male_outfit_dlc1_6_3","zombie_male_outfit_dlc1_7","zombie_male_outfit_dlc1_7_2","zombie_male_outfit_dlc1_7_3","zombie_female_outfit_dlc1_1","zombie_female_outfit_dlc1_1_2","zombie_female_outfit_dlc1_1_3","zombie_female_outfit_dlc1_2","zombie_female_outfit_dlc1_2_2","zombie_female_outfit_dlc1_2_3","zombie_female_outfit_dlc1_3","zombie_female_outfit_dlc1_3_2","zombie_female_outfit_dlc1_3_3","zombie_female_outfit_dlc1_4","zombie_female_outfit_dlc1_4_2","zombie_female_outfit_dlc1_4_3","zombie_female_outfit_dlc1_5","zombie_female_outfit_dlc1_5_2","zombie_female_outfit_dlc1_5_3","zombie_female_outfit_dlc1_6","zombie_female_outfit_dlc1_6_2","zombie_female_outfit_dlc1_6_3"];
}

//Function Number: 181
cp_rave_onzombiedamage_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	return param_02;
}

//Function Number: 182
cp_rave_lethaldamage_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(param_05) && issubstr(param_05,"cos_092") && isdefined(param_01) && isplayer(param_01))
	{
		playheadshotexplosioneffects(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	}
}

//Function Number: 183
registerraveperks()
{
	registerraveperk("perk_machine_more",::setravemore,::unsetravemore);
	registerraveperk("perk_machine_tough",::setravetough,::unsetravetough);
	registerraveperk("perk_machine_revive",::setraverevive,::unsetraverevive);
	registerraveperk("perk_machine_flash",::setraveflash,::unsetraveflash);
	registerraveperk("perk_machine_rat_a_tat",::setravebangbangs,::unsetravebangbangs);
	registerraveperk("perk_machine_run",::allownormalmovementinwater,::forceslowmovementinwater);
	registerraveperk("perk_machine_fwoosh",::setravefwoosh,::unsetravefwoosh);
	registerraveperk("perk_machine_smack",::setravesmack,::unsetravesmack);
	registerraveperk("perk_machine_boom",::setraveboom,::unsetraveboom);
	registerraveperk("perk_machine_zap",::setravezap,::unsetravezap);
}

//Function Number: 184
registerraveperk(param_00,param_01,param_02)
{
	var_03 = level.var_462C[param_00];
	var_03.rave_set = param_01;
	var_03.rave_unset = param_02;
	level.var_462C[param_00] = var_03;
}

//Function Number: 185
takeraveperk(param_00,param_01)
{
	self [[ level.var_462C[param_00].rave_unset ]](param_00);
	var_02 = 0;
	switch(param_01)
	{
		case "cos_095":
			var_02 = 1;
			break;

		case "cos_086":
			var_02 = 2;
			break;

		case "cos_090":
			var_02 = 3;
			break;

		case "cos_089":
			var_02 = 4;
			break;

		case "cos_093":
			var_02 = 5;
			break;

		case "cos_085":
			var_02 = 6;
			break;

		case "cos_072":
			var_02 = 7;
			break;

		case "cos_091":
			var_02 = 8;
			break;

		case "cos_087":
			var_02 = 9;
			break;

		case "cos_092":
			var_02 = 10;
			break;

		default:
			break;
	}

	if(var_02 > 0)
	{
		self setclientomnvarbit("zm_charms_active",var_02,0);
	}
}

//Function Number: 186
giveraveperk(param_00,param_01)
{
	self [[ level.var_462C[param_00].rave_set ]](param_00);
	var_02 = 0;
	switch(param_01)
	{
		case "cos_095":
			var_02 = 1;
			break;

		case "cos_086":
			var_02 = 2;
			break;

		case "cos_090":
			var_02 = 3;
			break;

		case "cos_089":
			var_02 = 4;
			break;

		case "cos_093":
			var_02 = 5;
			break;

		case "cos_085":
			var_02 = 6;
			break;

		case "cos_072":
			var_02 = 7;
			break;

		case "cos_091":
			var_02 = 8;
			break;

		case "cos_087":
			var_02 = 9;
			break;

		case "cos_092":
			var_02 = 10;
			break;

		default:
			break;
	}

	if(var_02 > 0)
	{
		if(!isdefined(self.charms_equipped))
		{
			self.charms_equipped = [];
		}

		if(!isdefined(self.charms_equipped[param_01]))
		{
			self.charms_equipped[param_01] = 1;
			scripts\cp\_merits::func_D9AD("mt_dlc1_charms_added");
		}

		self setclientomnvarbit("zm_charms_active",var_02,1);
	}
}

//Function Number: 187
raveset(param_00)
{
	if(!isdefined(self.rave_perks))
	{
		self.rave_perks = 0;
	}

	self.rave_perks++;
}

//Function Number: 188
raveunset(param_00)
{
	if(!isdefined(self.rave_perks))
	{
		self.rave_perks = 0;
	}

	self.rave_perks--;
}

//Function Number: 189
setraveflash(param_00)
{
	thread regen_ammo_while_stowed(self,param_00);
}

//Function Number: 190
regen_ammo_while_stowed(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon(param_01 + "_removed");
	param_00 endon("disconnect");
	param_00 notify("regen_ammo_while_stowed");
	param_00 endon("regen_ammo_while_stowed");
	for(;;)
	{
		var_02 = param_00 scripts\cp\_utility::getvalidtakeweapon();
		var_03 = param_00 getweaponslistprimaries();
		foreach(var_05 in var_03)
		{
			if(scripts\cp\_utility::func_80D8(var_05) == scripts\cp\_utility::func_80D8(var_02))
			{
				continue;
			}

			if(scripts\cp\_utility::isstrstart(var_05,"alt_"))
			{
				continue;
			}

			if(param_00 hasweapon(var_05))
			{
				var_06 = param_00 getweaponammostock(var_05);
				if(var_06 >= 1)
				{
					var_07 = param_00 getweaponammoclip(var_05);
					if(var_07 < weaponclipsize(var_05))
					{
						param_00 setweaponammoclip(var_05,var_07 + 1);
						if(param_00 getweaponammoclip(var_05) != var_07)
						{
							param_00 setweaponammostock(var_05,var_06 - 1);
						}
					}
				}
			}

			if(issubstr(var_05,"akimbo"))
			{
				var_06 = param_00 getweaponammostock(var_05);
				if(var_06 >= 1)
				{
					var_07 = param_00 getweaponammoclip(var_05,"left");
					if(var_07 < weaponclipsize(var_05))
					{
						param_00 setweaponammoclip(var_05,var_07 + 1,"left");
						if(param_00 getweaponammoclip(var_05,"left") != var_07)
						{
							param_00 setweaponammostock(var_05,var_06 - 1);
						}
					}
				}
			}
		}

		wait(1);
	}
}

//Function Number: 191
unsetraveflash(param_00)
{
	self notify(param_00 + "_removed");
}

//Function Number: 192
forcepushenemieswhilerunning(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon(param_01 + "_removed");
	param_00 endon("disconnect");
	for(;;)
	{
		while(param_00 method_81BD())
		{
			var_02 = func_3E08(35,128,2);
			var_03 = sortbydistance(var_02,param_00.origin);
			foreach(var_05 in var_03)
			{
				if(scripts\common\utility::func_13D90(param_00 geteye(),param_00.angles,var_05 geteye(),cos(65)))
				{
					var_05 thread killnearbyvictim(param_00,var_05.maxhealth,var_05.origin,param_00.origin,param_00.origin);
				}
			}

			wait(0.25);
		}

		wait(0.25);
	}
}

//Function Number: 193
func_3E08(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 6;
	}

	var_03 = cos(param_00);
	var_04 = [];
	var_05 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_06 = scripts\common\utility::func_782F(self.origin,var_05,undefined,24,param_01,1);
	foreach(var_08 in var_06)
	{
		var_09 = anglestoforward(self.angles);
		var_0A = vectornormalize(var_09) * -35;
		var_0B = 0;
		var_0C = var_08.origin;
		var_0D = scripts\common\utility::func_13D90(self geteye() + var_0A,self.angles,var_0C + (0,0,30),var_03);
		if(var_0D)
		{
			if(isdefined(param_01))
			{
				var_0E = distance2d(self.origin,var_0C);
				if(var_0E < param_01)
				{
					var_0B = 1;
				}
			}
			else
			{
				var_0B = 1;
			}
		}

		if(var_0B && var_04.size < param_02)
		{
			var_04[var_04.size] = var_08;
		}
	}

	return var_04;
}

//Function Number: 194
setravemore(param_00)
{
	scripts\cp\_utility::func_13D1("specialty_autoaimhead");
}

//Function Number: 195
unsetravemore(param_00)
{
	self notify(param_00 + "_removed");
	scripts\cp\_utility::func_1430("specialty_autoaimhead");
}

//Function Number: 196
setraveboom(param_00)
{
}

//Function Number: 197
unsetraveboom(param_00)
{
	self notify(param_00 + "_removed");
}

//Function Number: 198
playheadshotexplosioneffects(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(scripts\mp\agents\zombie\zmb_zombie_agent::func_5F70())
	{
		return;
	}

	if(!scripts\common\utility::func_9D74(param_04))
	{
		return;
	}

	if(!scripts\cp\_utility::func_9E27(param_05,param_08,param_04,param_01))
	{
		return;
	}

	thread explodevictimshead(self,param_05,param_08,param_04,param_01);
}

//Function Number: 199
explodevictimshead(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	param_00.head_is_exploding = 1;
	var_05 = param_00 gettagorigin("J_Spine4");
	playsoundatpos(param_00.origin,"zmb_fnf_headpopper_explo");
	playfx(level._effect["bloody_death"],var_05);
	foreach(var_07 in level.players)
	{
		if(distance(var_07.origin,var_05) <= 350)
		{
			var_07 thread func_10142();
		}
	}

	if(isdefined(param_00.var_8C98))
	{
		param_00 detach(param_00.var_8C98);
	}

	if(!scripts\common\utility::istrue(param_00.var_9CDD))
	{
		param_00 setscriptablepartstate("head","hide");
	}
}

//Function Number: 200
func_10142()
{
	self notify("turn_on_screen_blood_on");
	self endon("turn_on_screen_blood_on");
	self setscriptablepartstate("on_screen_blood","on");
	scripts\common\utility::waittill_any_timeout_1(2,"death","last_stand");
	self setscriptablepartstate("on_screen_blood","neutral");
}

//Function Number: 201
setravefwoosh(param_00)
{
	thread lib_0CFD::func_F65B();
}

//Function Number: 202
unsetravefwoosh(param_00)
{
	self notify(param_00 + "_removed");
	thread lib_0CFD::func_12C7B();
}

//Function Number: 203
allownormalmovementinwater(param_00)
{
	self.noslowmovement = 1;
	scripts\cp\_utility::func_8387("specialty_fastsprintrecovery");
}

//Function Number: 204
forceslowmovementinwater(param_00)
{
	self notify(param_00 + "_removed");
	self.noslowmovement = undefined;
	scripts\cp\_utility::func_1430("specialty_fastsprintrecovery");
}

//Function Number: 205
setravebangbangs(param_00)
{
	if(!scripts\cp\_utility::_hasperk("specialty_momentum"))
	{
		scripts\cp\_utility::func_13D1("specialty_momentum");
	}
}

//Function Number: 206
unsetravebangbangs(param_00)
{
	self notify(param_00 + "_removed");
	scripts\cp\_utility::func_1430("specialty_momentum");
}

//Function Number: 207
setravetough(param_00)
{
	thread watchforplayerdamaged(self,param_00);
}

//Function Number: 208
unsetravetough(param_00)
{
	self notify(param_00 + "_removed");
}

//Function Number: 209
watchforplayerdamaged(param_00,param_01)
{
	param_00 notify("watchForPlayerDamaged");
	param_00 endon("watchForPlayerDamaged");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon(param_01 + "_removed");
	for(;;)
	{
		param_00 waittill("damage",var_02,var_03);
		if(isdefined(var_03.agent_type) && var_03.agent_type == "zombie_sasquatch" || var_03.agent_type == "slasher" || var_03.agent_type == "superslasher")
		{
			continue;
		}

		if(isdefined(var_03) && var_03 == param_00)
		{
			continue;
		}

		if(var_03.health >= 1)
		{
			var_03 thread setandunsetpain(var_03);
			var_03 dodamage(var_03.maxhealth * 0.2,param_00.origin,param_00,param_00,"MOD_UNKNOWN");
		}
	}
}

//Function Number: 210
setandunsetpain(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00.allowpain = 1;
	wait(1);
	param_00.allowpain = 0;
}

//Function Number: 211
setraverevive(param_00)
{
	self.forcepushrevive = 1;
	thread waitforplayertorevive(self,param_00);
}

//Function Number: 212
unsetraverevive(param_00)
{
	self notify(param_00 + "_removed");
	self.forcepushrevive = undefined;
}

//Function Number: 213
waitforplayertorevive(param_00,param_01)
{
	param_00 notify("waitForPlayerToRevive");
	param_00 endon(param_01 + "_removed");
	param_00 endon("disconnect");
	param_00 endon("waitForPlayerToRevive");
	for(;;)
	{
		param_00 waittill("revive_teammate",var_02);
		var_03 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_04 = scripts\common\utility::func_782F(param_00.origin,var_03,undefined,24,256);
		foreach(var_07, var_06 in var_04)
		{
			var_06 thread killnearbyvictim(param_00,var_06.maxhealth,var_06.origin,var_02.origin,var_02.origin);
			if(var_07 % 3 == 1)
			{
				scripts\common\utility::func_136F7();
			}
		}
	}
}

//Function Number: 214
killnearbyvictim(param_00,param_01,param_02,param_03,param_04)
{
	param_01 = self.maxhealth;
	var_05 = anglestoforward(param_00.angles);
	var_06 = vectornormalize(var_05) * -100;
	self setvelocity(vectornormalize(self.origin - param_04) * 800 + (0,0,300));
	self.do_immediate_ragdoll = 1;
	if(param_01 >= self.health)
	{
		self.var_4C87 = 1;
	}

	self dodamage(param_01,param_02,param_00,param_00,"MOD_IMPACT","zom_repulsor_mp");
}

//Function Number: 215
setravesmack(param_00)
{
	thread watchforplayermeleedamage(self,param_00);
}

//Function Number: 216
unsetravesmack(param_00)
{
	self notify(param_00 + "_removed");
}

//Function Number: 217
watchforplayermeleedamage(param_00,param_01)
{
	param_00 endon(param_01 + "_removed");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("weapon_hit_enemy",var_02,var_03,var_04,var_05,var_06,var_07);
		if(!isdefined(var_03))
		{
			continue;
		}

		if(!isplayer(var_03))
		{
			continue;
		}

		if(var_03 != param_00)
		{
			continue;
		}

		if(isdefined(var_07) && var_07 == "MOD_MELEE")
		{
			param_00.health = param_00.maxhealth;
		}
	}
}

//Function Number: 218
setravezap(param_00)
{
	thread watchforblueboltactivation(self,param_00);
}

//Function Number: 219
unsetravezap(param_00)
{
	self notify(param_00 + "_removed");
}

//Function Number: 220
watchforblueboltactivation(param_00,param_01)
{
	param_00 endon(param_01 + "_removed");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("reload_start");
		var_02 = scripts\common\utility::func_782F(param_00.origin,level.players,[param_00],3,256);
		foreach(var_04 in var_02)
		{
			if(var_04 != param_00)
			{
				var_05 = var_04 getcurrentweapon();
				var_06 = weaponclipsize(var_05);
				var_07 = var_04 getweaponammoclip(var_05);
				var_08 = var_06 - var_07 / var_06;
				var_09 = max(1045 * var_08,10);
				var_0A = max(128 * var_08,48);
				var_04 thread lib_0D5D::func_497F(var_0A,var_09);
			}
		}
	}
}

//Function Number: 221
cp_rave_event_start(param_00)
{
	switch(param_00)
	{
		case "team_rave_mode":
			level.var_13445 = "cp_rave_rave_mode";
			level notify("rave_event_started");
			foreach(var_02 in level.players)
			{
				var_02 func_6619(var_02);
			}
			break;

		case "sasquatch_wave":
			level thread clown_wave_music();
			break;

		default:
			break;
	}
}

//Function Number: 222
clown_wave_music()
{
	wait(0.5);
	level thread scripts\cp\_vo::try_to_play_vo("ww_clownwave_wavestart","rave_announcer_vo","highest",70,0,0,1);
	wait(3);
	if(soundexists("mus_zombies_eventwave_start"))
	{
		level thread mus_rave_eventwave_start();
	}

	level.wait_for_music_sasquatch = 1;
}

//Function Number: 223
mus_rave_eventwave_start()
{
	scripts\cp\_utility::func_D52A("mus_zombies_eventwave_start",(0,0,0));
	level notify("wave_start_sound_done");
}

//Function Number: 224
mus_rave_eventwave_end()
{
	scripts\cp\_utility::func_D52A("mus_zombies_eventwave_end",(0,0,0));
}

//Function Number: 225
cp_rave_event_end(param_00)
{
	switch(param_00)
	{
		case "team_rave_mode":
			level.var_13445 = undefined;
			foreach(var_02 in level.players)
			{
				var_02 func_695D(var_02);
			}
			break;

		case "sasquatch_wave":
			level thread mus_rave_eventwave_end();
			break;

		default:
			break;
	}
}

//Function Number: 226
cp_rave_event_selection(param_00)
{
	return "sasquatch_wave";
}

//Function Number: 227
guidedinteractionoffsetfunc(param_00,param_01)
{
	var_02 = (0,0,68);
	var_03 = scripts\cp\_interaction::func_7829(param_00);
	if(isdefined(param_00.script_noteworthy))
	{
		var_04 = param_00.script_noteworthy;
		switch(var_04)
		{
			case "iw7_ripper_zmr":
				if(isdefined(var_03) && var_03 == "lake_shore")
				{
					var_02 = (0,0,0);
				}
				break;

			case "iw7_revolver_zm":
				if(isdefined(var_03) && var_03 == "cabin_to_lake")
				{
					var_02 = (0,0,20);
				}
				break;

			default:
				var_02 = (0,0,56);
				break;
		}
	}

	return var_02;
}

//Function Number: 228
guidedinteractionsexclusions(param_00,param_01,param_02)
{
	if(scripts\common\utility::istrue(param_01.var_DCEB))
	{
		return 0;
	}

	if(isdefined(param_02))
	{
		switch(param_02)
		{
			case "interaction_packboat":
				if(level.boat_pieces_found < 3)
				{
					return 0;
				}
				else
				{
					return 1;
				}
	
				break;

			case "disco_toy_test":
			case "rave_toys":
			case "mushroom_patch":
			case "memory_quest_start_pos":
			case "computer":
			case "memory_vo_skull":
			case "atm_deposit":
			case "ritual_stone":
			case "atm_withdrawal":
				return 0;
		}
	}

	if(isdefined(param_00.script_noteworthy))
	{
		switch(param_00.script_noteworthy)
		{
			case "memory_quest_end_pos":
			case "charge_animal_toys":
			case "animal_statue_end_pos":
			case "animal_statue_toys":
			case "survivor_interaction":
			case "iw7_slasher_zm":
			case "fix_pap":
			case "iw7_harpoon_zm":
			case "iw7_harpoon4_zm":
			case "iw7_harpoon3_zm+akimbo":
			case "iw7_harpoon2_zm":
			case "iw7_harpoon1_zm":
				return 0;
		}
	}

	if(isdefined(param_00.var_86A2) && param_00.var_86A2 == "challenge")
	{
		return 0;
	}

	if(isdefined(param_00.script_label))
	{
		if(!scripts\common\utility::istrue(param_01.var_DCEB))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 229
func_2B53()
{
}

//Function Number: 230
func_4DDA()
{
	level endon("game_ended");
	var_00 = level.var_1646;
	if(!isdefined(level.volumes_before_fight))
	{
		level.volumes_before_fight = level.var_1646;
	}

	var_01 = getentarray("placed_transponder","script_noteworthy");
	foreach(var_03 in var_00)
	{
		if(var_03.var_28AB == "island")
		{
			continue;
		}

		var_03 scripts\cp\zombies\zombies_spawning::func_B292();
		foreach(var_05 in var_01)
		{
			if(function_010F(var_05.origin,var_03))
			{
				var_05 notify("detonateExplosive");
			}
		}
	}

	while(!scripts\common\utility::flag("disable_portals"))
	{
		wait(0.05);
	}

	scripts\common\utility::func_6E5A("disable_portals");
	foreach(var_09 in var_00)
	{
		var_09 scripts\cp\zombies\zombies_spawning::func_B291();
	}
}

//Function Number: 231
cp_rave_should_run_event(param_00)
{
	var_01 = param_00 - level.var_A8BC;
	if(var_01 < 5)
	{
		return 0;
	}

	if(scripts\common\utility::func_6E34("defense_sequence_active") && scripts\common\utility::flag("defense_sequence_active"))
	{
		return 0;
	}

	var_01 = var_01 - 4;
	var_02 = var_01 / 3 * 100;
	if(randomint(100) < var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 232
cp_rave_event_wave_init()
{
	level.var_6840["team_rave_mode"] = ::team_rave_event_func;
	level.var_6840["sasquatch_wave"] = ::scripts\cp\zombies\cp_rave_spawning::func_8453;
	init_rave_spawner_locations();
}

//Function Number: 233
init_rave_spawner_locations()
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

//Function Number: 234
team_rave_event_func()
{
	level.var_10E3C = ["generic_zombie"];
	level.var_5F7F = [];
	level.var_B467 = 24;
	level.var_B432 = 0;
	level.var_5274 = int(scripts\common\utility::func_116D7(level.var_1096B >= 1,min(level.var_1096B * 25,100),25));
	level.var_4B6E = 0;
	spawn_team_rave_zombies();
}

//Function Number: 235
spawn_team_rave_zombies()
{
	level endon("force_spawn_wave_done");
	level endon("game_ended");
	level.var_E299 = 0;
	level.var_C1E8 = 0;
	level.var_4BB5 = 0;
	level.var_10725 = [];
	var_00 = 0;
	while(level.var_4B6E < level.var_5274)
	{
		while(scripts\common\utility::istrue(level.var_13FA3) || scripts\common\utility::istrue(level.nuke_zombies_paused))
		{
			scripts\common\utility::func_136F7();
		}

		var_01 = scripts\cp\zombies\zombies_spawning::func_C1E9();
		var_02 = 0;
		if(isdefined(var_01) && var_01 >= 1)
		{
			var_02 = scripts\cp\zombies\zombies_spawning::func_10822();
			var_00 = var_00 + var_02;
		}

		if(var_02 > 0)
		{
			wait(wait_spawns(var_00,level.var_5274));
			continue;
		}

		wait(0.1);
	}

	level.var_B467 = 0;
	level.var_B432 = 0;
	level.var_11046 = 1;
}

//Function Number: 236
wait_spawns(param_00,param_01)
{
	var_02 = 1.5;
	switch(level.var_1096B)
	{
		case 0:
			var_02 = 3;
			break;

		case 1:
			var_02 = 2;
			break;

		case 2:
			var_02 = 1.5;
			break;

		case 3:
			var_02 = 1;
			break;

		default:
			var_02 = 1;
			break;
	}

	var_02 = var_02 - param_00 / param_01;
	var_02 = max(var_02,0.05);
	return var_02;
}

//Function Number: 237
cp_rave_kill_reward(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_04))
	{
		if(isdefined(level.melee_weapons) && scripts\common\utility::func_2286(level.melee_weapons,getweaponbasename(param_04)))
		{
			return 60;
		}

		if(isdefined(param_01) && isplayer(param_01) && scripts\common\utility::istrue(param_01.var_DCEB))
		{
			return param_06 * 2;
		}

		return param_06;
	}

	if(isdefined(param_01) && isplayer(param_01) && level.slasher_fight)
	{
		return 0;
	}

	if(isdefined(param_01) && isplayer(param_01) && scripts\common\utility::istrue(param_01.var_DCEB))
	{
		return param_06 * 2;
	}

	return param_06;
}

//Function Number: 238
cp_rave_exit_laststand_func(param_00)
{
	param_00 scripts\cp\powers\coop_powers::func_E2D1(param_00,param_00.var_D7CD);
	param_00 lib_0D5B::func_F53F(param_00,"healthy");
	param_00.flung = undefined;
	param_00 setclientomnvar("zm_ui_player_in_laststand",0);
	param_00 method_8070(0.5);
	param_00 stoplocalsound("zmb_laststand_music");
	param_00 method_8070(0.3);
	if(isdefined(level.var_13445))
	{
		param_00 thread func_E20F(0.2,level.var_13445);
	}
	else if(isdefined(param_00.var_13445))
	{
		param_00 thread func_E20F(0.2,param_00.var_13445);
	}

	param_00 visionsetnakedforplayer("",0.1);
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
}

//Function Number: 239
func_E20F(param_00,param_01)
{
	wait(param_00);
	if(isdefined(param_01))
	{
		self visionsetnakedforplayer(param_01,0.1);
	}
}

//Function Number: 240
cp_rave_updatemovespeedscale()
{
	var_00 = undefined;
	if(isdefined(self.var_D42F))
	{
		var_00 = 1;
		var_00 = var_00 + self.var_D42F;
	}
	else
	{
		var_00 = lib_0D5B::func_807F(self);
		if(isdefined(self.var_3D12))
		{
			var_00 = self.var_3D12;
		}
		else if(isdefined(self.var_101D3))
		{
			var_00 = self.var_101D3;
		}

		var_01 = self.var_3E6B;
		if(isdefined(var_01) && isdefined(var_01.var_109AE))
		{
			var_00 = var_00 + var_01.var_109AE;
		}

		if(isdefined(self.var_109BB))
		{
			var_00 = var_00 + self.var_109BB;
		}

		if(isdefined(self.var_CAB0))
		{
			var_00 = var_00 + self.var_CAB0;
		}

		if(isdefined(self.var_13C70))
		{
			var_00 = var_00 + self.var_13C70;
		}

		if(isdefined(self.var_13CB2))
		{
			var_00 = var_00 + self.var_13CB2;
		}

		if(isdefined(self.var_13CB3))
		{
			var_00 = var_00 + self.var_13CB3;
		}

		var_00 = min(1.5,var_00);
	}

	self.var_13CCF = var_00;
	if(!isdefined(self.var_440B))
	{
		self.var_440B = 1;
	}

	if(!isdefined(self.waterspeedscalar) || !isdefined(self.customweaponspeedscalar))
	{
		self.waterspeedscalar = 1;
		self.customweaponspeedscalar = 1;
	}

	self setmovespeedscale(var_00 * self.var_BCF6 * self.var_440B * self.waterspeedscalar * self.customweaponspeedscalar);
}

//Function Number: 241
rave_add_attachment_to_weapon(param_00,param_01)
{
	var_02 = param_01 scripts\cp\_utility::getvalidtakeweapon();
	if(!can_use_charm_attachment(var_02,param_00))
	{
		return 0;
	}

	param_01 notify("weapon_purchased");
	var_03 = function_00E3(var_02);
	var_04 = scripts\cp\_utility::func_7DF7(var_02);
	var_05 = param_01 scripts\cp\_utility::getweaponreticle(var_04);
	var_06 = undefined;
	if(param_01 method_819C())
	{
		var_06 = param_01 getweaponammoclip(var_02,"left");
	}

	var_07 = param_01 getweaponammoclip(var_02,"right");
	var_08 = param_01 getweaponammostock(var_02);
	if(issubstr(var_02,"+camo"))
	{
		var_09 = function_00E5(var_02);
	}
	else
	{
		var_09 = var_02 scripts\cp\_utility::getweaponcamo(var_05);
	}

	var_0A = param_01 scripts\cp\_utility::getweaponpaintjobid(var_04);
	foreach(var_0C in var_03)
	{
		if(issubstr(var_0C,"cos_"))
		{
			var_03 = scripts\common\utility::func_22A9(var_03,var_0C);
		}
	}

	var_0E = scripts\cp\_utility::func_BD68(scripts\cp\_utility::func_8234(var_02),var_03,var_09,var_05,scripts\cp\_utility::func_7D72(param_01,var_02),param_01 getentitynumber(),param_01.var_41F0,var_0A,param_00);
	if(isdefined(var_0E))
	{
		param_01 takeweapon(var_02);
		param_01 scripts\cp\_utility::func_12C6(var_0E,undefined,undefined,1);
		param_01 switchtoweapon(var_0E);
		param_01 setweaponammoclip(var_0E,var_07,"right");
		param_01 setweaponammostock(var_0E,var_08);
		if(isdefined(var_06))
		{
			param_01 setweaponammoclip(var_0E,var_06,"left");
		}
	}

	foreach(var_10 in param_01 getweaponslistall())
	{
		var_03 = function_00E3(var_10);
		foreach(var_0C in var_03)
		{
			if(issubstr(var_0C,"cos_"))
			{
				if(isdefined(level.rave_charm_attachment_perks[var_0C]))
				{
					param_01 giveraveperk(level.rave_charm_attachment_perks[var_0C],var_0C);
				}
			}
		}
	}

	return 1;
}

//Function Number: 242
can_use_charm_attachment(param_00,param_01)
{
	var_02 = scripts\cp\_utility::func_80D8(param_00);
	switch(var_02)
	{
		case "lockon":
		case "fists":
		case "slasher":
		case "glprox":
		case "chargeshot":
		case "spiked":
		case "golf":
		case "two":
		case "forgefreeze":
		case "axe":
		case "harpoon":
		case "harpoon4":
		case "harpoon3":
		case "harpoon2":
		case "harpoon1":
		case "knife":
		case "machete":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 243
set_charm_icon(param_00)
{
	if(!isdefined(level.charms_collected))
	{
		level.charms_collected = 0;
	}

	set_charm_icon_internal(param_00);
	level.charms_collected++;
}

//Function Number: 244
set_charm_icon_internal(param_00)
{
	setomnvarbit("zm_secondary_quest_pieces",param_00,1);
}

//Function Number: 245
cp_rave_currency_scalar_func(param_00,param_01)
{
	if(isdefined(param_00.rave_cash_scalar))
	{
		param_01 = param_01 * param_00.rave_cash_scalar;
	}

	return int(param_01);
}

//Function Number: 246
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

//Function Number: 247
play_char_intro_gesture()
{
	self endon("disconnect");
	level endon("game_ended");
	self setweaponammostock(self.intro_gesture,1);
	self giveandfireoffhand(self.intro_gesture);
	if(isdefined(self.var_134FD) && self.var_134FD == "p2_")
	{
		thread activate_glow_stick_glow();
	}

	if(isdefined(self.var_134FD) && self.var_134FD == "p4_")
	{
		thread throw_money();
	}

	wait(waitgesturelength());
	if(self hasweapon("iw7_gunless_zm"))
	{
		self takeweapon("iw7_gunless_zm");
	}

	var_00 = get_char_fist_weapon(self);
	scripts\cp\_utility::func_12C6(var_00,undefined,undefined,1);
	self switchtoweapon(var_00);
	self.starting_weapon = var_00;
	self.var_501C = var_00;
	var_01 = lib_0D5B::func_7B89();
	level.player_character_info[var_01].starting_weapon = var_00;
	level notify("start_pa_music");
	self notify("finish_intro_gesture");
}

//Function Number: 248
get_char_fist_weapon(param_00)
{
	var_01 = "iw7_fists_zm";
	if(isdefined(param_00.var_134FD))
	{
		switch(param_00.var_134FD)
		{
			case "p1_":
				return "iw7_fists_zm_chola";

			case "p2_":
				return "iw7_fists_zm_raver";

			case "p3_":
				return "iw7_fists_zm_grunge";

			case "p4_":
				return "iw7_fists_zm_hiphop";

			case "p5_":
				return "iw7_fists_zm_kevinsmith";

			default:
				return "iw7_fists_zm";
		}

		return;
	}

	return var_01;
}

//Function Number: 249
throw_money()
{
	self endon("disconnect");
	wait(2);
	self setscriptablepartstate("money","throw_money");
}

//Function Number: 250
activate_glow_stick_glow()
{
	self endon("disconnect");
	wait(1.35);
	self setscriptablepartstate("glow_stick","activated");
}

//Function Number: 251
waitgesturelength()
{
	switch(self.var_134FD)
	{
		case "p1_":
			return self method_8443("ges_load_in_chola");

		case "p2_":
			return self method_8443("ges_load_in_raver");

		case "p3_":
			return self method_8443("ges_load_in_grunge");

		case "p4_":
			return self method_8443("ges_load_in_hiphop") - 0.5;

		case "p5_":
			return self method_8443("ges_load_in_survivor");

		default:
			return 3;
	}
}

//Function Number: 252
cp_rave_mutilation_mask_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = undefined;
	var_07 = zombies_should_mutilate(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	return var_07;
}

//Function Number: 253
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
			if(isdefined(var_07) && var_07 == "iw7_nrg_zm" || var_07 == "iw7_forgefreeze_zm")
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

//Function Number: 254
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

//Function Number: 255
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
				case "concussion_grenade_mp":
					return 0;

				default:
					break;
			}
		}
	}

	return 1;
}

//Function Number: 256
adjust_struct_positions()
{
}

//Function Number: 257
move_struct(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getclosest(param_00,level.struct,500);
	var_03.origin = param_01;
	if(isdefined(param_02))
	{
		var_03.angles = param_02;
	}
}

//Function Number: 258
survivor_logic()
{
	var_00 = scripts\common\utility::getstruct("slasher_pos","targetname");
	level.survivor = spawn("script_model",var_00.origin);
	level.survivor.angles = var_00.angles;
	level.survivor setmodel("zmb_world_k_smith");
	var_01 = [%iw7_cp_survivor_cabin_idle_01,%iw7_cp_survivor_cabin_idle_02];
	var_02 = ["IW7_cp_survivor_cabin_idle_01","IW7_cp_survivor_cabin_idle_02"];
	var_03 = 0;
	for(;;)
	{
		var_04 = getanimlength(var_01[var_03]);
		level.survivor scriptmodelplayanimdeltamotionfrompos(var_02[var_03],var_00.origin + (0,0,3),var_00.angles,1);
		wait(var_04);
		var_03++;
		if(var_03 > 1)
		{
			var_03 = 0;
		}
	}
}

//Function Number: 259
rockwall_logic()
{
	var_00 = getent("rockwall","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(isdefined(var_01.on_rockwall))
		{
			continue;
		}

		var_01 thread player_rockwall_logic(var_00);
	}
}

//Function Number: 260
player_rockwall_logic(param_00)
{
	self endon("disconnect");
	self.on_rockwall = 1;
	self method_85BC(1);
	while(self istouching(param_00))
	{
		wait(1);
	}

	self method_85BC(0);
	self.on_rockwall = undefined;
}

//Function Number: 261
cp_rave_auto_melee_agent_type_check(param_00)
{
	if(param_00.agent_type == "zombie_sasquatch" || param_00.agent_type == "slasher" || param_00.agent_type == "superslasher")
	{
		return 0;
	}

	return 1;
}

//Function Number: 262
setup_pool_balls()
{
	level endon("gamed_ended");
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = scripts\common\utility::getstructarray("pool_balls","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = spawn("script_model",var_02.origin);
		if(isdefined(var_02.angles))
		{
			var_03.angles = var_02.angles;
		}

		if(isdefined(var_02.script_noteworthy))
		{
			var_03 setmodel(var_02.script_noteworthy);
		}
		else
		{
			var_03 setmodel("cp_rave_pool_ball_01");
		}

		var_02.model = var_03;
	}
}

//Function Number: 263
setup_glyph_targets()
{
	level endon("gamed_ended");
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = scripts\common\utility::getstructarray("ee_song_structs","targetname");
	var_00 = scripts\common\utility::func_22A8(var_00);
	level.total_glyphs_to_find = int(var_00.size);
	level.total_glyphs_found = 0;
	for(var_01 = 0;var_01 < 10;var_01++)
	{
		var_02 = spawn("script_model",var_00[var_01].origin);
		var_02 setmodel("tag_origin_ee_song_quest");
		var_02.angles = var_00[var_01].angles;
		var_02 thread glyph_watch_for_player_interaction(var_02,var_00[var_01],"glyph" + var_01 + 1);
	}
}

//Function Number: 264
glyph_watch_for_player_interaction(param_00,param_01,param_02)
{
	level endon("game_ended");
	while(!scripts\common\utility::istrue(param_00.var_7339))
	{
		if(!isdefined(level.someones_in_rave) || !level.someones_in_rave)
		{
			param_00 setscriptablepartstate("glyph","neutral");
			foreach(var_04 in level.players)
			{
				param_00 method_8429(var_04);
			}

			level waittill("player_entered_rave");
		}

		foreach(var_04 in level.players)
		{
			if(scripts\common\utility::istrue(var_04.var_DCEB))
			{
				param_00 showtoplayer(var_04);
			}
			else
			{
				param_00 method_8429(var_04);
			}

			if(scripts\common\utility::istrue(var_04.ee_song_tracking))
			{
				continue;
			}

			if(var_04 adsbuttonpressed())
			{
				var_04 thread check_ads_validity(var_04,param_00);
			}
		}

		wait(0.2);
	}

	param_00 setscriptablepartstate("glyph",param_02);
	level.total_glyphs_found++;
}

//Function Number: 265
check_ads_validity(param_00,param_01)
{
	var_02 = 0;
	var_03 = 1;
	param_00.ee_song_tracking = 1;
	while(param_00 method_8409(param_01.origin,65,15))
	{
		wait(0.05);
		var_02 = var_02 + 0.05;
		if(var_02 >= var_03)
		{
			param_00.ee_song_tracking = 0;
			param_01.var_7339 = 1;
			return 1;
		}
	}

	param_00.ee_song_tracking = 0;
	return 0;
}

//Function Number: 266
rave_set_interaction_trigger_properties(param_00,param_01,param_02)
{
	if(!isdefined(param_01.script_noteworthy))
	{
		return;
	}

	if(param_01.script_noteworthy == "memory_quest_start_pos" || param_01.script_noteworthy == "memory_quest_end_pos" || param_01.script_noteworthy == "ring_quest_lights" || param_01.script_noteworthy == "animal_statue_toys" || param_01.script_noteworthy == "animal_statue_end_pos" || param_01.script_noteworthy == "charge_animal_toys" || param_01.script_noteworthy == "survivor_interaction" || param_01.script_noteworthy == "boat_quest_piece" || param_01.script_noteworthy == "ritual_stone" || param_01.script_noteworthy == "pap_quest_piece" || param_01.script_noteworthy == "mushroom_patch")
	{
		self.var_9A3F method_83D6(0);
		self.var_9A3F method_84A5(360);
	}

	if(param_01.script_noteworthy == "charge_animal_toys")
	{
		self.var_9A3F method_83D6(1);
		self.var_9A3F method_84A5(160);
	}
}

//Function Number: 267
give_harpoon_weapon(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = self getweaponslistprimaries();
	var_06 = var_05.size;
	var_07 = 3;
	var_08 = scripts\cp\_utility::func_80D8(param_00.script_noteworthy);
	var_09 = 1;
	var_09 = 0;
	param_00.trigger hide();
	param_00 scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	thread watch_for_weapon_removed(param_00,self);
	if(!scripts\cp\_weapon::func_8BBB(param_00.script_noteworthy))
	{
		self notify("weapon_purchased");
		var_0A = scripts\cp\_utility::getvalidtakeweapon();
		self.var_4B32 = var_0A;
		if(isdefined(var_0A))
		{
			var_02 = 1;
			var_0B = scripts\cp\_utility::func_80D8(var_0A);
			if(scripts\cp\_utility::func_8BAE() && var_06 < var_07 + 1)
			{
				var_02 = 0;
			}

			foreach(var_0D in var_05)
			{
				if(scripts\cp\_utility::isstrstart(var_0D,"alt_"))
				{
					var_07++;
				}
			}

			if(scripts\cp\_utility::has_zombie_perk("perk_machine_more"))
			{
				var_07++;
			}

			if(var_05.size < var_07)
			{
				var_02 = 0;
			}

			if(var_02)
			{
				if(isdefined(self.var_C8A2[var_0B]))
				{
					self.var_C8A2[var_0B] = undefined;
					self notify("weapon_level_changed");
				}

				thread scripts\cp\_interaction::func_CE96(param_00,self);
				self takeweapon(var_0A);
			}
		}

		if(isdefined(self.var_13C00[var_08]))
		{
			var_03 = self.var_13C00[var_08];
		}
		else
		{
			var_03 = param_00.var_394;
		}

		var_0F = function_00E3(var_03);
		var_10 = scripts\cp\_weapon::func_E469(var_03,undefined,var_0F);
		var_10 = scripts\cp\_utility::func_12C6(var_10,undefined,undefined,var_09);
		self.var_A035 = var_10;
		level.var_12631 = randomint(100);
		scripts\cp\zombies\zombie_analytics::func_AF86(1,self,self.var_A035,self.var_4B32,level.wave_num,param_00.name,self.var_13BE3,self.var_A682,self.var_5AFC);
		removefistsweapons(var_05);
		var_11 = spawnstruct();
		var_11.var_B111 = 1;
		self.var_C8A2[var_08] = var_11;
		self notify("wor_item_pickup",var_10);
		if(param_00.trigger.cost > 1)
		{
			scripts\cp\_merits::func_D9AD("mt_purchased_weapon");
		}

		if(isdefined(var_10) && isdefined(param_00.clip))
		{
			self setweaponammoclip(var_10,param_00.clip);
		}

		if(isdefined(var_10) && isdefined(param_00.left_clip))
		{
			self setweaponammoclip(var_10,param_00.left_clip,"left");
		}

		if(isdefined(var_10) && isdefined(param_00.var_10FAF))
		{
			self setweaponammostock(var_10,param_00.var_10FAF);
		}
		else
		{
			self givemaxammo(var_10);
		}

		self notify("weapon_level_changed");
		self switchtoweapon(var_10);
		wait(0.25);
		while(self method_81C2())
		{
			wait(0.05);
		}

		thread scripts\cp\_vo::try_to_play_vo("purchase_weapon","zmb_comment_vo","low",10,0,1,0,50);
	}
	else
	{
		self notify("weapon_purchased");
		self.var_DB02 = 1;
		var_08 = undefined;
		var_12 = self getweaponslistall();
		var_13 = self getcurrentweapon();
		var_14 = scripts\cp\_utility::func_80D8(param_00.script_noteworthy);
		var_15 = undefined;
		foreach(var_17 in var_12)
		{
			var_08 = scripts\cp\_utility::func_80D8(var_17);
			if(var_08 == var_14)
			{
				var_15 = var_17;
				break;
			}
		}

		var_19 = function_0249(var_15);
		var_1A = lib_0CFF::func_D876();
		var_1B = int(var_1A * var_19);
		var_1C = self getweaponammostock(var_15);
		if(var_1C < var_1B)
		{
			self setweaponammostock(var_15,var_1B);
		}

		thread scripts\cp\_vo::try_to_play_vo("pillage_ammo","zmb_comment_vo","low",10,0,1,1,50);
	}

	wait(0.05);
	self.var_DB02 = undefined;
	scripts\cp\_interaction::func_DE6E();
}

//Function Number: 268
cp_rave_give_weapon(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = self getweaponslistprimaries();
	var_06 = var_05.size;
	var_07 = 3;
	var_08 = scripts\cp\_utility::func_80D8(param_00.script_noteworthy);
	var_09 = 1;
	if(scripts\cp\_utility::weapon_is_dlc_melee(param_00.script_noteworthy) || param_00.script_noteworthy == "iw7_harpoon_zm")
	{
		var_09 = 0;
		param_00.trigger hide();
		param_00 scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		thread watch_for_weapon_removed(param_00,self);
	}
	else if(var_08 == "harpoon")
	{
		var_09 = 0;
		param_00.trigger hide();
		param_00 scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		thread watch_for_weapon_removed(param_00,self);
	}

	if(!scripts\cp\_weapon::func_8BBB(param_00.script_noteworthy))
	{
		var_0A = scripts\cp\_utility::getvalidtakeweapon();
		self.var_4B32 = var_0A;
		if(isdefined(var_0A))
		{
			self notify("weapon_purchased");
			var_02 = 1;
			var_0B = scripts\cp\_utility::func_80D8(var_0A);
			if(scripts\cp\_utility::func_8BAE() && var_06 < var_07 + 1)
			{
				var_02 = 0;
			}

			foreach(var_0D in var_05)
			{
				if(scripts\cp\_utility::isstrstart(var_0D,"alt_"))
				{
					var_07++;
				}
			}

			if(scripts\cp\_utility::has_zombie_perk("perk_machine_more"))
			{
				var_07++;
			}

			if(var_05.size < var_07)
			{
				var_02 = 0;
			}

			if(var_02)
			{
				if(isdefined(self.var_C8A2[var_0B]))
				{
					self.var_C8A2[var_0B] = undefined;
					self notify("weapon_level_changed");
				}

				thread scripts\cp\_interaction::func_CE96(param_00,self);
				self takeweapon(var_0A);
			}
		}

		if(isdefined(self.var_13C00[var_08]))
		{
			var_03 = self.var_13C00[var_08];
		}
		else
		{
			var_03 = param_00.var_394;
		}

		if(scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::func_385F(var_03) && scripts\cp\_utility::func_9BA0("wall_power"))
		{
			self notify("weapon_purchased");
			var_04 = scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::get_pap_camo(2,var_08,var_03);
			var_0F = scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::return_pap_attachment(param_01,2,var_08,var_03);
			if(isdefined(var_0F) && var_0F != "replace_me")
			{
				var_10 = scripts\common\utility::array_combine(function_00E3(var_03),["pap1"]);
			}
			else
			{
				var_10 = function_00E3(var_03);
			}

			var_11 = scripts\cp\_utility::func_80D8(var_03);
			var_12 = spawnstruct();
			var_12.var_B111 = 1;
			self.var_C8A2[var_11] = var_12;
			var_13 = scripts\cp\_weapon::func_E469(var_03,undefined,var_10,undefined,var_04);
			var_13 = scripts\cp\_utility::func_12C6(var_13,undefined,undefined,var_09);
			self.var_C8A2[var_11].var_B111++;
			scripts\cp\_merits::func_D9AD("mt_upgrade_weapons");
			scripts\cp\_utility::func_C151("wall_power");
			removefistsweapons(var_05);
		}
		else
		{
			self notify("weapon_purchased");
			var_10 = function_00E3(var_06);
			var_13 = scripts\cp\_weapon::func_E469(var_05,undefined,var_13);
			var_13 = scripts\cp\_utility::func_12C6(var_13,undefined,undefined,var_09);
			self.var_A035 = var_13;
			level.var_12631 = randomint(100);
			scripts\cp\zombies\zombie_analytics::func_AF86(1,self,self.var_A035,self.var_4B32,level.wave_num,param_00.name,self.var_13BE3,self.var_A682,self.var_5AFC);
			removefistsweapons(var_05);
			var_12 = spawnstruct();
			var_12.var_B111 = 1;
			self.var_C8A2[var_08] = var_12;
		}

		self notify("wor_item_pickup",var_13);
		if(param_00.trigger.cost > 1)
		{
			scripts\cp\_merits::func_D9AD("mt_purchased_weapon");
		}

		if(issubstr(param_00.script_noteworthy,"iw7_slasher_zm"))
		{
			if(isdefined(self.saw_clip))
			{
				self setweaponammoclip(var_13,self.saw_clip);
			}

			if(issubstr(param_00.script_noteworthy,"+akimbo") && !isdefined(self.saw_left_clip))
			{
				self setweaponammoclip(var_13,self.saw_left_clip,"left");
			}

			if(isdefined(self.saw_stock))
			{
				self setweaponammostock(var_13,self.saw_stock);
			}
			else
			{
				self givemaxammo(var_13);
			}
		}
		else
		{
			self givemaxammo(var_13);
		}

		self notify("weapon_level_changed");
		self switchtoweapon(var_13);
		wait(0.25);
		while(self method_81C2())
		{
			wait(0.05);
		}

		thread scripts\cp\_vo::try_to_play_vo("purchase_weapon","zmb_comment_vo","low",10,0,1,0,50);
	}
	else
	{
		self notify("weapon_purchased");
		self.var_DB02 = 1;
		var_08 = undefined;
		var_14 = self getweaponslistall();
		var_15 = self getcurrentweapon();
		var_16 = scripts\cp\_utility::func_80D8(param_00.script_noteworthy);
		var_17 = undefined;
		foreach(var_19 in var_14)
		{
			var_08 = scripts\cp\_utility::func_80D8(var_19);
			if(var_08 == var_16)
			{
				var_17 = var_19;
				break;
			}
		}

		var_1B = function_0249(var_17);
		var_1C = lib_0CFF::func_D876();
		var_1D = int(var_1C * var_1B);
		var_1E = self getweaponammostock(var_17);
		if(var_1E < var_1D)
		{
			self setweaponammostock(var_17,var_1D);
		}

		thread scripts\cp\_vo::try_to_play_vo("pillage_ammo","zmb_comment_vo","low",10,0,1,1,50);
	}

	wait(0.05);
	self.var_DB02 = undefined;
	scripts\cp\_interaction::func_DE6E();
}

//Function Number: 269
removefistsweapons(param_00)
{
	foreach(var_02 in param_00)
	{
		if(issubstr(var_02,"iw7_fists"))
		{
			self takeweapon(var_02);
		}
	}
}

//Function Number: 270
watch_for_weapon_removed(param_00,param_01)
{
	param_00 notify("watch_for_weapon_removed");
	param_00 thread wait_for_weapon_disowned(param_00,param_01);
	level thread watch_player_disconnect(param_00,param_01);
	param_01 thread wait_for_weapon_removed(param_00,param_01);
	param_01 thread wait_for_player_death(param_00,param_01);
}

//Function Number: 271
watch_player_disconnect(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("watch_for_weapon_removed");
	param_00 endon("watch_for_weapon_removed_" + param_01.name);
	param_00 endon("weapon_disowned_" + param_00.script_noteworthy);
	param_01 waittill("disconnect");
	param_00 notify("weapon_disowned_" + param_00.script_noteworthy);
}

//Function Number: 272
wait_for_player_death(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("disconnect");
	param_00 endon("weapon_disowned_" + param_00.script_noteworthy);
	var_02 = 1;
	for(;;)
	{
		if(!var_02)
		{
			break;
		}

		var_03 = undefined;
		param_01 waittill("last_stand");
		var_02 = 0;
		var_04 = param_01 scripts\common\utility::waittill_any_return_no_endon_death_3("player_entered_ala","revive","death");
		if(var_04 != "revive")
		{
			var_03 = param_01 scripts\common\utility::func_13734("lost_and_found_collected","lost_and_found_time_out");
			if(isdefined(var_03) && var_03 == "lost_and_found_time_out")
			{
				continue;
			}
		}

		var_05 = param_01 getweaponslistall();
		foreach(var_07 in var_05)
		{
			if(issubstr(getweaponbasename(var_07),getweaponbasename(param_00.script_noteworthy)))
			{
				param_01 thread wait_for_weapon_removed(param_00,param_01);
				var_02 = 1;
				break;
			}
		}
	}

	param_00 notify("weapon_disowned_" + param_00.script_noteworthy);
}

//Function Number: 273
wait_for_weapon_removed(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("last_stand");
	param_01 endon("disconnect");
	param_00 endon("watch_for_weapon_removed");
	param_00 endon("weapon_disowned_" + param_00.script_noteworthy);
	var_02 = 1;
	for(;;)
	{
		if(!var_02)
		{
			break;
		}

		param_01 scripts\common\utility::waittill_any_3("weapon_purchased","mule_munchies_sold");
		var_02 = 0;
		var_03 = param_01 getweaponslistall();
		foreach(var_05 in var_03)
		{
			if(issubstr(getweaponbasename(var_05),getweaponbasename(param_00.script_noteworthy)))
			{
				var_02 = 1;
				break;
			}
		}
	}

	param_00 notify("weapon_disowned_" + param_00.script_noteworthy);
}

//Function Number: 274
wait_for_weapon_disowned(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("watch_for_weapon_removed");
	param_00.should_be_hidden = 1;
	param_00 waittill("weapon_disowned_" + param_00.script_noteworthy);
	param_00.should_be_hidden = undefined;
	param_00 scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	if(isdefined(param_01))
	{
		param_00 scripts\cp\_interaction::func_175D(param_00,param_01);
	}

	param_00.trigger show();
}

//Function Number: 275
get_camo_for_wall_buy(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(param_01 scripts\cp\_utility::func_9BA0("wall_power"))
	{
		if(isdefined(level.no_pap_camos) && scripts\common\utility::func_2286(level.no_pap_camos,param_02))
		{
			var_03 = undefined;
		}
		else if(isdefined(level.pap_1_camo))
		{
			var_03 = level.pap_1_camo;
		}
	}

	return var_03;
}

//Function Number: 276
rave_ephemeral_camo(param_00,param_01,param_02)
{
	var_03 = scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::get_pap_camo(param_00.var_C8A2[param_01].var_B111 + 1,param_01,param_02);
	return var_03;
}

//Function Number: 277
rave_ephemeral_weapon(param_00,param_01,param_02)
{
	return param_02;
}

//Function Number: 278
rave_ephemeral_attachment(param_00,param_01,param_02)
{
	var_03 = scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::return_pap_attachment(param_00,param_00.var_C8A2[param_01].var_B111 + 1,param_01,param_02,1);
	return var_03;
}

//Function Number: 279
rave_getweaponnamestring(param_00,param_01)
{
	var_02 = issubstr(param_01,"_pap1");
	var_03 = issubstr(param_01,"_pap2");
	switch(param_00)
	{
		case "iw7_two":
			if(var_02)
			{
				return &"CP_RAVE_WEAPONS_TWO_HEADED_AXE_PAP1";
			}
			else if(var_03)
			{
				return &"CP_RAVE_WEAPONS_TWO_HEADED_AXE_PAP2";
			}
			else
			{
				return &"CP_RAVE_WEAPONS_TWO_HEADED_AXE";
			}
	
			break;

		case "iw7_machete":
			if(var_02)
			{
				return &"CP_RAVE_WEAPONS_MACHETE_PAP1";
			}
			else if(var_03)
			{
				return &"CP_RAVE_WEAPONS_MACHETE_PAP2";
			}
			else
			{
				return &"CP_RAVE_WEAPONS_MACHETE";
			}
	
			break;

		case "iw7_spiked":
			if(var_02)
			{
				return &"CP_RAVE_WEAPONS_BAT_PAP1";
			}
			else if(var_03)
			{
				return &"CP_RAVE_WEAPONS_BAT_PAP2";
			}
			else
			{
				return &"CP_RAVE_WEAPONS_BAT";
			}
	
			break;

		case "iw7_slasher":
			return &"CP_RAVE_WEAPONS_SLASHER_SAW";

		case "iw7_harpoon":
			return &"CP_RAVE_WEAPONS_HARPOON";

		case "iw7_harpoon1":
			return &"CP_RAVE_WEAPONS_HARPOON1";

		case "iw7_harpoon2":
			return &"CP_RAVE_WEAPONS_HARPOON2";

		case "iw7_harpoon3":
			return &"CP_RAVE_WEAPONS_HARPOON3";

		case "iw7_harpoon4":
			return &"CP_RAVE_WEAPONS_HARPOON4";

		case "iw7_golf":
			if(var_02)
			{
				return &"CP_RAVE_WEAPONS_GOLF_CLUB_PAP1";
			}
			else if(var_03)
			{
				return &"CP_RAVE_WEAPONS_GOLF_CLUB_PAP2";
			}
			else
			{
				return &"CP_RAVE_WEAPONS_GOLF_CLUB";
			}
	
			break;

		default:
			return &"CP_ZMB_WEAPONS_GENERIC";
	}
}

//Function Number: 280
spawn_afterlife_speaker()
{
	var_00 = (-10101.5,-317,-1661.5);
	var_01 = (0,180,90);
	var_02 = spawn("script_model",var_00);
	var_02.angles = var_01;
	var_02 setmodel("ehq_speaker_monitor_01");
	level.willard_speaker = var_02;
}

//Function Number: 281
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
			while(param_00 method_81B5())
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
				}

				wait(0.05);
				param_00.time_on_ladders = param_00.time_on_ladders + 0.05;
			}
		}

		wait(0.05);
	}
}

//Function Number: 282
adjust_player_spawn_pos()
{
	var_00 = scripts\common\utility::getstructarray("default_player_start","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		switch(var_01)
		{
			case 0:
				var_02.origin = (-941,-1619,224);
				var_02.angles = (0,168,0);
				break;

			case 1:
				var_02.origin = (-942,-1555,224);
				var_02.angles = (0,185,0);
				break;

			case 2:
				var_02.origin = (-957,-1456,224);
				var_02.angles = (0,208,0);
				break;

			case 3:
				var_02.origin = (-981,-1695,224);
				var_02.angles = (0,155,0);
				break;
		}
	}
}

//Function Number: 283
cp_rave_goon_spawner_patch_func(param_00)
{
	remove_goon_spawner((1956,-1878,46),param_00);
	remove_goon_spawner((-4852.5,6318.4,-168),param_00);
}

//Function Number: 284
remove_goon_spawner(param_00,param_01)
{
	var_02 = scripts\common\utility::getclosest(param_00,param_01,500);
	var_02.remove_me = 1;
}

//Function Number: 285
cp_rave_patch_update_spawners()
{
	scripts\cp\zombies\zombies_spawning::remove_origin((-3431.8,-1972.2,29.7));
	scripts\cp\zombies\zombies_spawning::remove_origin((-575.5,-196.3,264.8));
	scripts\cp\zombies\zombies_spawning::remove_origin((1564.9,-1678.4,241.7));
	scripts\cp\zombies\zombies_spawning::remove_origin((1717.4,-1529.4,241.7));
	scripts\cp\zombies\zombies_spawning::remove_origin((-4921.2,6328,-110.9));
	scripts\cp\zombies\zombies_spawning::update_origin((-2614.5,283.6,-115.5),(-2664.5,283.6,-115.5));
	scripts\cp\zombies\zombies_spawning::update_origin((2063,-1848.8,-8.5),(2063,-1880.8,-8.5),(0,180,0));
}

//Function Number: 286
respawn_on_island(param_00)
{
	var_01 = scripts\common\utility::getstructarray("island_dropoff_player","targetname");
	for(var_02 = 0;var_02 < 40;var_02++)
	{
		foreach(var_04 in var_01)
		{
			if(canspawn(var_04.origin) && !positionwouldtelefrag(var_04.origin))
			{
				return var_04;
			}
		}

		wait(0.05);
	}

	return var_01[0];
}

//Function Number: 287
hotjoin_on_boat()
{
	level endon("end_boat_hotjoin");
	while(scripts\common\utility::flag("survivor_released"))
	{
		level waittill("player_spawned",var_00);
		var_01 = undefined;
		foreach(var_03 in level.var_2BFB.var_AD27)
		{
			if(!var_03 scripts\cp\_utility::is_valid_player())
			{
				continue;
			}

			for(var_04 = 1;var_04 < 5;var_04++)
			{
				if(distance2dsquared(level.var_2BFB gettagorigin("tag_player_0" + var_04),var_03.origin) < 64)
				{
					continue;
				}
				else
				{
					var_01 = "tag_player_0" + var_04;
					break;
				}
			}

			if(isdefined(var_01))
			{
				break;
			}
		}

		if(isdefined(var_01))
		{
			level thread scripts\cp\maps\cp_rave\cp_rave_boat::func_AD0A(var_00,undefined,var_01);
			continue;
		}

		level thread scripts\cp\maps\cp_rave\cp_rave_boat::func_AD0A(var_00,undefined,"tag_player_04");
	}
}

//Function Number: 288
remove_door_ala()
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = scripts\common\utility::getstructarray("afterlife_selfrevive_door","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(var_02.origin == (-10270.5,259.7,-1759))
		{
			scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
		}
	}
}

//Function Number: 289
adjust_doorbuy_triggers()
{
	scripts\common\utility::flag_wait("interactions_initialized");
	wait(1);
	var_00 = getentarray("debris_1250","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(distancesquared(var_02.origin,(-1680,1384,24.7)) < 1000)
		{
			var_02.origin = var_02.origin + (0,0,100);
		}
	}
}

//Function Number: 290
cp_rave_should_do_damage_check_func(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_03) && param_03 == "iw7_bait_zm")
	{
		return 0;
	}

	return 1;
}

//Function Number: 291
show_sym_pap()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread delay_play_soul_key_symbol(var_00);
	}
}

//Function Number: 292
setupinvalidvolumes()
{
	level.invalidtranspondervolumes = [];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-3538,-2455,150),(-3539,-2327,200),(-3364,-2280,125),(-3418,-2461,225)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(438,282,0),(148,382,-20),(89,235,200),(398,184,200)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-288,-1573,200),(-200,-1575,200),(-192,-1533,264),(-299,-1533,264)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(2589,-2724,75),(2496,-2911,75),(2689,-3010,225),(2813,-2679,225)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(70,674,0),(671,540,0),(701,400,200),(991,532,200)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-2937,-4267,200),(-2731,-4372,200),(-2727,-4428,350),(-2965,-4325,400)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-929,1695,-15),(-877,1753,-15),(-787,1568,200),(-744,1617,200)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-2422,-4034,240),(-2470,-4046,240),(-2300,-3868,400),(-2457,-3802,400)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-3740,-2181,70),(-3679,-1927,70),(-3840,-1860,250),(-3934,-2282,250)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-1107,1970,-20),(-1007,1787,-20),(-867,1897,150),(-1050,2070,150)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(848,-517,400),(847,-606,400),(1036,-603,-10),(1031,-517,-10)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-3284,3878,-200),(-5244,2985,-200),(-4289,1680,100),(-2139,2955,100)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-1525,-1716,100),(-2009,-1763,0),(-1475,-1544,300),(-1978,-1631,147)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(1680,-486,50),(1680,-606,0),(1032,-512,165),(1010,-750,165)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(-1066,-730,175),(-944,-653,300),(-950,-534,300),(-1203,-674,175)];
	level.invalidtranspondervolumes[level.invalidtranspondervolumes.size] = [(1708,-1247,150),(1720,-1512,350),(1835,-1464,350),(1803,-1211,150)];
}

//Function Number: 293
delay_play_soul_key_symbol(param_00)
{
	param_00 endon("disconnect");
	var_01 = (-10265,932,-1581);
	var_02 = (0,0,90);
	param_00 waittill("spawned_player");
	var_03 = param_00 getplayerdata("cp","haveSoulKeys","soul_key_1");
	if(scripts\common\utility::istrue(var_03))
	{
		playfx(level._effect["vfx_zb_pack_grd_small_a"],var_01,anglestoforward(var_02),anglestoup(var_02),param_00);
	}
}

//Function Number: 294
cp_rave_gns_2_setup()
{
	level.gns_num_of_wave = 3;
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::init();
	ghost_player_end_pos();
	form_5_priority();
	level.death_trigger_reset_y_pos = 7183;
	level.death_trigger_activate_y_pos = 8112;
	level.original_death_grid_lines_front_y_pos = 9779;
	level.zombie_ghost_model = "zombie_ghost_green";
	level.zombie_ghost_color_manager = ::cp_rave_ghost_color_manager;
	level.set_moving_target_color_func = ::cp_rave_set_moving_target_color;
	level.should_moving_target_explode = ::cp_rave_should_moving_target_explode;
	level.hit_wrong_moving_target_func = ::cp_rave_hit_wrong_moving_target_func;
	level.moving_target_activation_func = ::hide_show_color_logic;
	level.moving_target_pre_fly_time = 0.5;
	level.process_player_gns_combo_func = ::process_player_gns_combo;
	level.gns_laststand_monitor = ::gns2_laststand_monitor;
	level.ghost_n_skull_reactivate_func = ::scripts\cp\maps\cp_rave\cp_rave_ghost_activation::reactive_ghost_n_skull_cabinet;
	level.gns_reward_func = ::rave_gns_player_reward_func;
	level.gns_hotjoin_wait_notify = "finish_intro_gesture";
	register_ghost_form();
	register_waves_movement();
	load_cp_rave_ghost_exp_vfx();
	scripts\cp\maps\cp_rave\cp_rave_ghost_activation::init_ghost_n_skull_2_quest();
}

//Function Number: 295
ghost_player_end_pos()
{
	var_00 = scripts\common\utility::getstructarray("ghost_wave_player_end","targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.origin == (-8431.5,10156.5,-753.5))
		{
			var_02.origin = (-320,-1458,403);
			var_02.angles = (0,0,0);
			continue;
		}

		if(var_02.origin == (-8399.5,10156.5,-753.5))
		{
			var_02.origin = (-320,-1478,403);
			var_02.angles = (0,0,0);
			continue;
		}

		if(var_02.origin == (-8367.5,10156.5,-753.5))
		{
			var_02.origin = (-320,-1498,403);
			var_02.angles = (0,0,0);
			continue;
		}

		if(var_02.origin == (-8335.5,10156.5,-753.5))
		{
			var_02.origin = (-320,-1518,403);
			var_02.angles = (0,0,0);
		}
	}
}

//Function Number: 296
register_ghost_form()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1,1);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3,2);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,3);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,4);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1,5);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,7);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,9);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3,10);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,11);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,12);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3,13);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3,14);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3,15);
}

//Function Number: 297
register_waves_movement()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(1,1,2,0.3);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(2,1,1.8,0.3);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(3,1,1.6,0.3);
	level.available_formations = undefined;
	level.formation_movements = undefined;
}

//Function Number: 298
cp_rave_ghost_color_manager()
{
	var_00 = 6;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	foreach(var_06 in level.var_13F2D)
	{
		if(var_06.color == "red")
		{
			var_01++;
		}

		if(var_06.color == "green")
		{
			var_02++;
		}

		if(var_06.color == "yellow")
		{
			var_03++;
		}

		if(var_06.color == "blue")
		{
			var_04++;
		}
	}

	if(var_01 < var_00)
	{
		level.zombie_ghost_model = "zombie_ghost_red";
		return;
	}

	if(var_02 < var_00)
	{
		level.zombie_ghost_model = "zombie_ghost_green";
		return;
	}

	if(var_03 < var_00)
	{
		level.zombie_ghost_model = "zombie_ghost_yellow";
		return;
	}

	level.zombie_ghost_model = "zombie_ghost_blue";
}

//Function Number: 299
load_cp_rave_ghost_exp_vfx()
{
	level._effect["ghost_explosion_death_red"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_ghost_imp_red.vfx");
	level._effect["ghost_explosion_death_yellow"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_ghost_imp_yellow.vfx");
	level._effect["ghost_explosion_death_blue"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_ghost_imp_blue.vfx");
}

//Function Number: 300
cp_rave_set_moving_target_color(param_00,param_01)
{
	var_02 = ["green","yellow","blue"];
	var_03 = "";
	if(param_01 == 1)
	{
		if(!isdefined(level.moving_target_color_based_on_priority))
		{
			determine_color(var_02);
		}

		if(scripts\common\utility::func_2286(level.var_BD46["low"],param_00))
		{
			var_03 = level.moving_target_color_based_on_priority["low"];
		}
		else if(scripts\common\utility::func_2286(level.var_BD46["medium"],param_00))
		{
			var_03 = level.moving_target_color_based_on_priority["medium"];
		}
		else if(scripts\common\utility::func_2286(level.var_BD46["high"],param_00))
		{
			var_03 = level.moving_target_color_based_on_priority["high"];
		}
	}
	else
	{
		var_03 = scripts\common\utility::random(var_02);
	}

	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::set_moving_target_color(param_00,var_03);
}

//Function Number: 301
cp_rave_should_moving_target_explode(param_00,param_01)
{
	return isdefined(param_01.color) && param_00.color == param_01.color;
}

//Function Number: 302
cp_rave_hit_wrong_moving_target_func(param_00,param_01,param_02)
{
	reset_player_gns_combo(param_00);
	level thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(param_01);
}

//Function Number: 303
determine_color(param_00)
{
	var_01 = scripts\common\utility::array_randomize(param_00);
	level.moving_target_color_based_on_priority = [];
	level.moving_target_color_based_on_priority["low"] = var_01[0];
	level.moving_target_color_based_on_priority["medium"] = var_01[1];
	level.moving_target_color_based_on_priority["high"] = var_01[2];
}

//Function Number: 304
form_5_priority()
{
	var_00 = scripts\common\utility::getstructarray("ghost_formation_5","targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.var_EE79 == "RD")
		{
			var_03 = scripts\common\utility::getstructarray(var_02.target,"targetname");
			foreach(var_05 in var_03)
			{
				if(var_05.origin == (-10304,9604,-2288.5))
				{
					var_05.script_noteworthy = "low";
				}

				if(var_05.origin == (-10560,9604,-2288.5))
				{
					var_05.script_noteworthy = "medium";
				}
			}
		}
	}
}

//Function Number: 305
hide_show_color_logic(param_00)
{
	reset_all_players_gns_combo();
	if(param_00 == 2)
	{
		level thread wave_2_hide_show_color_logic();
		return;
	}

	if(param_00 == 3)
	{
		level thread wave_3_hide_show_color_logic();
	}
}

//Function Number: 306
wave_2_hide_show_color_logic()
{
	level notify("cp_rave_hide_show_logic");
	level endon("cp_rave_hide_show_logic");
	level endon("game_ended");
	level endon("stop_moving_target_sequence");
	var_00 = 12;
	for(;;)
	{
		wait(var_00);
		scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::all_moving_targets_hide_color();
		wait(var_00);
		scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::all_moving_targets_show_color();
	}
}

//Function Number: 307
wave_3_hide_show_color_logic()
{
	level notify("cp_rave_hide_show_logic");
	level endon("cp_rave_hide_show_logic");
	level endon("game_ended");
	level endon("stop_moving_target_sequence");
	var_00 = 20;
	wait(var_00);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::all_moving_targets_hide_color();
}

//Function Number: 308
reset_all_players_gns_combo()
{
	foreach(var_01 in level.players)
	{
		reset_player_gns_combo(var_01);
	}
}

//Function Number: 309
reset_player_gns_combo(param_00)
{
	param_00.current_gns_streak_color = "none";
	param_00.current_gns_streak_length = 0;
}

//Function Number: 310
process_player_gns_combo(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		reset_player_gns_combo(param_00);
		return;
	}

	if(param_01.color == "red")
	{
		reset_player_gns_combo(param_00);
		return;
	}

	if(!isdefined(param_00.current_gns_streak_color))
	{
		reset_player_gns_combo(param_00);
	}

	if(param_00.current_gns_streak_color == param_01.color)
	{
		param_00.current_gns_streak_length++;
	}
	else
	{
		param_00.current_gns_streak_color = param_01.color;
		param_00.current_gns_streak_length = 1;
	}

	if(param_00.current_gns_streak_length > 1)
	{
		level thread take_out_targets(param_00,param_00.current_gns_streak_length - 1,param_01);
	}
}

//Function Number: 311
take_out_targets(param_00,param_01,param_02)
{
	var_03 = get_color_targ(param_02);
	var_04 = sortbydistance(var_03,param_02.origin);
	var_05 = min(param_01,var_04.size);
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		var_07 = var_04[var_06];
		playfx(level._effect["ghost_explosion_death_" + var_07.color],var_07.origin,anglestoforward(var_07.angles),anglestoup(var_07.angles));
		lib_0C2D::remove_moving_target_default(var_07,param_00);
	}
}

//Function Number: 312
get_color_targ(param_00)
{
	var_01 = param_00.color;
	var_02 = [];
	foreach(var_04 in level.var_BD43)
	{
		foreach(var_06 in var_04)
		{
			if(var_06 == param_00)
			{
				continue;
			}

			if(isdefined(var_06) && var_06.color == var_01)
			{
				var_02[var_02.size] = var_06;
			}
		}
	}

	return var_02;
}

//Function Number: 313
rave_gns_player_reward_func()
{
	foreach(var_01 in level.players)
	{
		var_01 thread delay_give_gns_reward(var_01);
	}
}

//Function Number: 314
delay_give_gns_reward(param_00)
{
	param_00 endon("disconnect");
	param_00.max_self_revive_machine_use = 6;
	param_00.have_gns_perk = 1;
	param_00 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(param_00);
	wait(1);
	param_00 setclientomnvar("zm_nag_text",1);
}

//Function Number: 315
gns2_laststand_monitor(param_00)
{
	level endon("game_ended");
	level endon("delay_end_ghost");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("last_stand");
		reset_player_gns_combo(param_00);
	}
}

//Function Number: 316
kick_for_inactivity(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 thread check_for_move_change();
	param_00 thread check_for_movement();
	param_00.input_has_happened = 0;
	var_01 = gettime();
	var_02 = level.onlinegame && !getdvarint("xblive_privatematch");
	if(var_02)
	{
		param_00 notifyonplayercommand("inputReceived","+speed_throw");
		param_00 notifyonplayercommand("inputReceived","+stance");
		param_00 notifyonplayercommand("inputReceived","+goStand");
		param_00 notifyonplayercommand("inputReceived","+usereload");
		param_00 notifyonplayercommand("inputReceived","+activate");
		param_00 notifyonplayercommand("inputReceived","+melee_zoom");
		param_00 notifyonplayercommand("inputReceived","+breath_sprint");
		param_00 notifyonplayercommand("inputReceived","+attack");
		param_00 notifyonplayercommand("inputReceived","+frag");
		param_00 notifyonplayercommand("inputReceived","+smoke");
		var_03 = 120;
		var_04 = 0.1;
		for(;;)
		{
			if(isdefined(level.wave_num) && level.wave_num > 5)
			{
				break;
			}

			var_05 = scripts\common\utility::waittill_any_timeout_no_endon_death_2(var_04,"inputReceived","currency_earned");
			if(gettime() - var_01 < 30000)
			{
				continue;
			}

			if(var_05 != "timeout")
			{
				var_03 = 120;
				param_00.input_has_happened = 1;
				continue;
			}

			if(!scripts\common\utility::istrue(param_00.in_afterlife_arcade) && !scripts\common\utility::istrue(param_00.inlaststand))
			{
				var_03 = var_03 - var_04;
			}

			if(var_03 < 0)
			{
				if(level.players.size > 1)
				{
					if(param_00.input_has_happened)
					{
						param_00.input_has_happened = 0;
						continue;
					}

					add_to_kick_queue(param_00);
					break;
				}
			}
		}
	}
}

//Function Number: 317
check_for_movement()
{
	level endon("game_ended");
	self endon("disconnect");
	var_00 = level.onlinegame && !getdvarint("xblive_privatematch");
	if(var_00)
	{
		var_01 = self getnormalizedmovement();
		var_02 = gettime();
		for(;;)
		{
			wait(0.2);
			var_03 = self getnormalizedmovement();
			if(var_03[0] == var_01[0] && var_03[1] == var_01[1])
			{
				if(gettime() - var_02 > 90000 && level.players.size > 1)
				{
					add_to_kick_queue(self);
				}

				continue;
			}

			return;
		}
	}
}

//Function Number: 318
add_to_kick_queue(param_00)
{
	if(!scripts\common\utility::func_693B(level.kick_player_queue,param_00))
	{
		level.kick_player_queue = scripts\common\utility::array_add_safe(level.kick_player_queue,param_00);
	}
}

//Function Number: 319
kick_player_queue_loop()
{
	level.kick_player_queue = [];
	for(;;)
	{
		if(level.kick_player_queue.size > 0)
		{
			foreach(var_01 in level.kick_player_queue)
			{
				if(!isdefined(var_01))
				{
					continue;
				}

				if(!var_01 ishost())
				{
					kick(var_01 getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
				}
			}

			if(level.kick_player_queue.size > 0)
			{
				foreach(var_01 in level.kick_player_queue)
				{
					if(!isdefined(var_01))
					{
						continue;
					}

					kick(var_01 getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
				}
			}

			level.kick_player_queue = [];
		}

		wait(0.1);
	}
}

//Function Number: 320
check_for_move_change()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("done_inactivity_check");
	while(!isdefined(self.model))
	{
		wait(0.1);
	}

	var_00 = 1;
	var_01 = var_00;
	var_02 = var_00;
	for(;;)
	{
		var_03 = self getnormalizedmovement();
		var_01 = get_move_direction_from_vectors(var_03);
		if(var_02 != var_01)
		{
			var_02 = var_01;
			self notify("inputReceived");
		}

		wait(0.1);
	}
}

//Function Number: 321
get_move_direction_from_vectors(param_00)
{
	var_01 = 1;
	var_02 = 2;
	var_03 = 3;
	var_04 = 4;
	var_05 = 5;
	var_06 = 6;
	var_07 = 7;
	var_08 = 8;
	var_09 = var_01;
	if(param_00[0] > 0)
	{
		if(param_00[1] <= 0.7 && param_00[1] >= -0.7)
		{
			var_09 = var_01;
		}

		if(param_00[0] > 0.5 && param_00[1] > 0.7)
		{
			var_09 = var_02;
		}
		else if(param_00[0] > 0.5 && param_00[1] < -0.7)
		{
			var_09 = var_03;
		}
	}
	else if(param_00[0] < 0)
	{
		if(param_00[1] < 0.4 && param_00[1] > -0.4)
		{
			var_09 = var_04;
		}

		if(param_00[0] < -0.5 && param_00[1] > 0.5)
		{
			var_09 = var_05;
		}
		else if(param_00[0] < -0.5 && param_00[1] < -0.5)
		{
			var_09 = var_06;
		}
	}
	else if(param_00[1] > 0.4)
	{
		var_09 = var_07;
	}
	else if(param_00[1] < -0.4)
	{
		var_09 = var_08;
	}

	return var_09;
}

//Function Number: 322
rave_setup_direct_boss_fight_func()
{
	direct_boss_fight_zombie_spawning();
	scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::move_lost_and_found("island");
}

//Function Number: 323
direct_boss_fight_zombie_spawning()
{
	level.var_13FA3 = 1;
}

//Function Number: 324
rave_start_direct_boss_fight_func()
{
	level.var_8136 = ::respawn_on_island;
	scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::init_super_slasher_fight();
	level.var_13BD6 = int(max(38,level.wave_num));
	level.disable_loot_fly_to_player = 1;
	level.loot_time_out = 99999;
	level thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::max_ammo_manager();
	scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::deploy_stair_barrier();
	scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::stop_spawn_wave();
	scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::clear_existing_enemies();
	scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::activate_fight_stage_vfx();
	scripts\common\utility::func_6E2A("zombie_drop_powerups");
	for(;;)
	{
		level.superslasher = scripts\mp\_mp_agent::func_108E8("superslasher","axis",level.superslasherspawnspot,level.superslasherspawnangles);
		if(isdefined(level.superslasher))
		{
			break;
		}
		else
		{
			scripts\common\utility::func_136F7();
		}
	}

	thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::watch_for_player_connect();
	level.superslasher.dont_cleanup = 1;
	level.superslasher.var_E0 = 1;
	level.superslasher thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::put_on_happy_face(level.superslasher);
	level.force_respawn_location = ::respawn_on_island;
	scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::soul_collection_sequence_init();
	thread func_4DDA();
	wait(2);
	level notify("ss_intro_finished");
	foreach(var_01 in level.players)
	{
		var_01 playsoundtoplayer(var_01.var_134FD + "slasher_super_first",var_01);
	}

	wait(6);
	level thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::unlimited_zombie_spawn();
	level thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::soul_collection_sequence();
	level thread scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::enableslasherpas();
	level thread scripts\cp\_vo::try_to_play_vo("ww_superslasher_firstspawn","rave_announcer_vo","highest",5,0,0,1);
	level waittill("super_slasher_death");
	scripts\cp\zombies\direct_boss_fight::success_sequence(10,2);
}

//Function Number: 325
rave_is_valid_spawn_weapon_func(param_00)
{
	switch(param_00)
	{
		case "iw7_fists_zm_kevinsmith":
		case "iw7_fists_zm_raver":
		case "iw7_fists_zm_hiphop":
		case "iw7_fists_zm_grunge":
		case "iw7_fists_zm_chola":
			return 0;

		default:
			return 1;
	}
}