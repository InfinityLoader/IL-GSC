/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_town\cp_town.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 108
 * Decompile Time: 5492 ms
 * Timestamp: 10/27/2023 12:06:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("sm_sunSampleSizeNear",0.97);
	setdvar("sm_sunCascadeSizeMultiplier1",2);
	setdvar("sm_sunCascadeSizeMultiplier2",3);
	setdvar("r_sdfShadowPenumbra",0.4);
	setdvar("r_umbraMinObjectContribution",6);
	setdvar("r_umbraAccurateOcclusionThreshold",2000);
	setdvar("sm_roundRobinPrioritySpotShadows",8);
	setdvar("sm_spotUpdateLimit",8);
	level.bcrabbrutedebugger = getdvarint("debug_crab_brute",0);
	level.bcrabminidebugger = getdvarint("debug_crab_mini",0);
	level.bcrabbossdebugger = getdvarint("debug_crab_boss",0);
	level.belviradebugger = getdvarint("debug_elvira",0);
	if(scripts\common\utility::istrue(level.belviradebugger))
	{
		level.bzombiedebugger_nospawner = 1;
	}

	if(!isdefined(level.var_10970))
	{
		level.var_10970 = [];
	}

	registerscriptedagents();
	registerlevelenemyarrays();
	level.coop_weapontable = "cp/cp_town_weapontable.csv";
	scripts\cp\_utility::coop_mode_enable(["pillage"]);
	scripts\cp\maps\cp_town\cp_town_precache::main();
	scripts\cp\maps\cp_town\gen\cp_town_art::main();
	scripts\cp\maps\cp_town\cp_town_fx::main();
	if(level.createfx_enabled)
	{
		return;
	}

	level.melee_weapons = [];
	level.player_pap_machines = [];
	level.current_vision_sets = [];
	level.current_vision_set = "cp_town_bw";
	level.var_13445 = level.current_vision_set;
	lib_0D2C::init();
	level.map_interaction_func = ::scripts\cp\maps\cp_town\cp_town_interactions::register_interactions;
	level.custom_onplayerconnect_func = ::func_C56E;
	level.weapon_rank_event_table = "scripts/cp/maps/cp_town/cp_town_weaponrank_event.csv";
	level.coop_weapontable = "cp/cp_town_weapontable.csv";
	level.custom_onspawnplayer_func = ::func_C57B;
	level.guidedinteractionexclusion = ::guidedinteractionsexclusions;
	level.guided_interaction_offset_func = ::guidedinteractionoffsetfunc;
	level.guidedinteractionendposoverride = ::guidedinteractionendposoverride;
	level.interaction_trigger_properties_func = ::interactiontriggerproperties;
	level.wait_to_be_revived_func = ::wait_to_be_revived_func;
	level.auto_melee_agent_type_check = ::auto_melee_agent_type_check;
	level.callbackplayerdamage = ::scripts\cp\maps\cp_town\cp_town_damage::callback_townzombieplayerdamage;
	level.aa_ww_char_vo = ::town_choose_correct_vo_for_player;
	level.spawn_fx_func = ::cp_town_spawn_fx_func;
	level.scriptablestatefunc = ::scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate;
	level.introscreen_text_func = ::cp_town_introscreen_text;
	level.mutilation_mask_override_func = ::mutilation_mask_func;
	level.customhostmigrationend = ::townhostmigrationfunc;
	level.ismeleeblocked_func = ::cp_town_ismeleeblocked_func;
	level.nextwheelweaponfunc = ::town_wheelnextweapon;
	scripts\cp\crafted_trap_portal::init();
	scripts\cp\crafted_trap_violetray::init();
	scripts\cp\crafted_trap_seismic::init();
	scripts\cp\crafted_trap_mindcontrol::init();
	scripts\cp\crafted_trap_hypnosis::init();
	level.magic_wheel_spin_hint = &"CP_TOWN_INTERACTIONS_SPIN_WHEEL";
	level.reboard_barriers_hint = &"CP_TOWN_INTERACTIONS_SECURE_WINDOW";
	level.enter_area_hint = &"CP_TOWN_INTERACTIONS_ENTER_THIS_AREA";
	level.primary_melee_weapons = ["iw7_knife_zm_schoolgirl","iw7_knife_zm_scientist","iw7_knife_zm_soldier","iw7_knife_zm_rebel","iw7_knife_zm_crowbar","iw7_knife_zm_elvira","iw7_knife_zm_cleaver"];
	level.additional_laststand_weapon_exclusion = ["iw7_cpbasketball_mp","iw7_cpskeeball_mp","iw7_cpclowntoothball_mp","iw7_horseracepistol_zm_blue","iw7_horseracepistol_zm_yellow","iw7_horseracepistol_zm_red","iw7_horseracepistol_zm_green","iw7_shootgallery_zm","iw7_blackholegun_mp","iw7_penetrationrail_mp","iw7_atomizer_mp","iw7_glr_mp","iw7_claw_mp","iw7_steeldragon_mp","iw7_shootgallery_zm_blue","iw7_shootgallery_zm_yellow","iw7_shootgallery_zm_red","iw7_shootgallery_zm_green","iw7_gunless_zm"];
	level.last_stand_weapons = ["iw7_g18_zm","iw7_g18_zmr","iw7_g18_zml","iw7_g18c_zm","iw7_mag_zm","iw7_revolver_zm","iw7_revolver_zmr","iw7_revolver_zmr_explosive","iw7_revolver_zml","iw7_revolver_zml_single","iw7_emc_zm","iw7_emc_zmr","iw7_emc_zmr_burst","iw7_emc_zml","iw7_emc_zml_spread","iw7_nrg_zm","iw7_nrg_zmr","iw7_nrg_zmr_smart","iw7_nrg_zml","iw7_nrg_zml_charge","iw7_dischord_zm","iw7_headcutter_zm","iw7_shredder_zm","iw7_facemelter_zm","iw7_dischord_zm_pap1","iw7_headcutter_zm_pap1","iw7_shredder_zm_pap1","iw7_facemelter_zm_pap1","iw7_golf_club_mp_pap1","iw7_two_headed_axe_mp_pap1","iw7_spiked_bat_mp_pap1","iw7_machete_mp_pap1","iw7_golf_club_mp_pap2","iw7_two_headed_axe_mp_pap2","iw7_spiked_bat_mp_pap2","iw7_machete_mp_pap2","iw7_golf_club_mp","iw7_two_headed_axe_mp","iw7_spiked_bat_mp","iw7_machete_mp"];
	level.melee_weapons = ["iw7_knife_zm_cleaver","iw7_knife_zm_crowbar"];
	level.invalid_gesture_weapon = ["iw7_nunchucks_zm"];
	setup_generic_zombie_model_list();
	scripts\cp\maps\cp_town\cp_town_crab_boss_bomb::generate_nuclear_code();
	level.player_suit = "zom_dlc3_suit";
	level.player_run_suit = "zom_dlc3_suit_sprint";
	level.player_interaction_monitor = ::scripts\cp\maps\cp_town\cp_town_interactions::town_player_interaction_monitor;
	level.wait_for_interaction_func = ::scripts\cp\maps\cp_town\cp_town_interactions::town_wait_for_interaction_triggered;
	level.should_run_event_func = ::cp_town_should_run_event;
	level.event_funcs_init = ::cp_town_event_wave_init;
	level.available_event_func = ::cp_town_event_selection;
	level.event_funcs_start = ::cp_town_event_start;
	level.event_funcs_end = ::cp_town_event_end;
	level.custom_pillageinitfunc = ::func_CB5A;
	level.pap_room_func = ::pap_machine_func;
	level.should_do_damage_check_func = ::cp_town_should_do_damage_check_func;
	level.boss_spawn_func = ::scripts\cp\zombies\cp_town_spawning::cp_town_boss_spawn;
	level.should_spawn_special_zombie_func = ::scripts\cp\zombies\cp_town_spawning::should_spawn_skater;
	level.special_zombie_spawn_func = ::scripts\cp\zombies\cp_town_spawning::get_spawner_and_spawn_goons;
	level.goon_spawner_patch_func = ::cp_town_goon_patch_func;
	level.patch_update_spawners = ::patch_update_spawners;
	level.setup_direct_boss_fight_func = ::town_setup_direct_boss_fight_func;
	level.start_direct_boss_fight_func = ::town_start_direct_boss_fight_func;
	level.special_zap_start_func = ::cp_town_zap_start_func;
	level.special_zap_end_func = ::cp_town_zap_end_func;
	level.town_power_vo_func = ::town_power_on_vo;
	scripts\cp\maps\cp_town\cp_town_player_character_setup::init_player_characters();
	level scripts\common\utility::func_5127(3,::colorize_sound_state_change,"fullblackandwhite",1);
	function_02A9("color","bw");
	level.char_intro_music = ::play_char_intro_music;
	level.char_intro_gesture = ::play_char_intro_gesture;
	level.initial_active_volumes = ["morgue"];
	level.drop_max_ammo_func = ::scripts\cp\zombies\_powerups::drop_loot;
	level thread scripts\cp\maps\cp_town\cp_town_vo::town_vo_init();
	level thread wait_for_pre_game_period();
	level thread watchforpowerontriggers();
	level thread setup_pap_camos();
	level thread map_exploit_spots();
	level thread scripts\cp\maps\cp_town\cp_town_interactions::initmeleeweapons();
	level thread scripts\cp\maps\cp_town\cp_town_interactions::initwwpieces();
	level thread scripts\cp\maps\cp_town\cp_town_mpq::cp_town_mpq_init();
	level thread scripts\cp\maps\cp_town\cp_town_ghost_activation::cp_town_gns_4_setup();
	level thread scripts\cp\maps\cp_town\cp_town_crab_boss_fight::init_crab_boss_stage();
	level thread scripts\cp\zombies\cp_town_spawning::cp_town_spawning_init();
	level thread setup_pa_speakers();
	level thread scripts\cp\maps\cp_town\cp_town_vo::power_nag();
	level.purchase_area_vo = ::scripts\cp\maps\cp_town\cp_town_vo::purchase_area_vo;
	level thread water_triggers();
	scripts\cp\maps\cp_town\cp_town_crafting::init_crafting();
	scripts\common\utility::flag_init("fuses_inserted");
	level thread fix_doors();
	level thread add_cutie_eggs();
	function_026C("MatchStarted: Completed");
	thread scripts\cp\maps\cp_town\cp_town_chemistry::init();
}

//Function Number: 2
play_char_intro_gesture()
{
	thread scripts\cp\_utility::firegesturegrenade(self,self.intro_gesture);
	wait(waitgesturelength());
	self notify("finish_intro_gesture");
}

//Function Number: 3
fix_doors()
{
	while(!isdefined(level.struct))
	{
		wait(1);
	}

	var_00 = scripts\common\utility::getstructarray("debris_750","script_noteworthy");
	var_01 = scripts\common\utility::getclosest((4792.2,-4374,9.5),var_00);
	var_01.script_area = "drive_in_elvira";
	var_02 = scripts\common\utility::getclosest((4832.3,-4347.3,9.5),var_00);
	var_02.script_area = "morgue";
}

//Function Number: 4
waitgesturelength()
{
	switch(self.var_134FD)
	{
		case "p1_":
			return self method_8443("ges_load_in_schoolgirl");

		case "p2_":
			return self method_8443("ges_load_in_scientist");

		case "p3_":
			return self method_8443("ges_load_in_soldier");

		case "p4_":
			return self method_8443("ges_load_in_rebel");

		case "p5_":
			return self method_8443("ges_load_in_elvira");

		default:
			return 3;
	}
}

//Function Number: 5
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
	lib_0D4D::enable_windows_in_area("morgue");
	level thread scripts\cp\maps\cp_town\cp_town_elvira::init_elvira();
	level thread bink_test();
	init_magic_wheel();
}

//Function Number: 6
bink_test()
{
}

//Function Number: 7
registerlevelenemyarrays()
{
	level.ignoreimmune = ["crab_brute","crab_boss"];
	level.fnfimmune = ["crab_brute","crab_boss","crab_mini"];
	level.instakillimmune = ["crab_brute","crab_boss"];
	level.specialzombie = ["crab_brute"];
}

//Function Number: 8
init_magic_wheel()
{
	var_00 = ["camp_transition","generator_transition","elvira_transition","elvira_station"];
	scripts\cp\zombies\interaction_magicwheel::set_magic_wheel_starting_location(scripts\common\utility::random(var_00));
}

//Function Number: 9
func_C57B()
{
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		level.current_vision_set = "cp_town_color";
		self visionsetnakedforplayer("cp_town_color",0);
		return;
	}

	if(isdefined(level.current_vision_set))
	{
		self visionsetnakedforplayer(level.current_vision_set,1);
		return;
	}

	self visionsetnakedforplayer("cp_town_c_bw",0);
}

//Function Number: 10
func_C56E(param_00)
{
	param_00 thread func_1110F(param_00);
	param_00 thread run_pap_machine_logic(param_00);
	param_00 thread func_13A7F(param_00);
	param_00 thread setupdamagetriggers(param_00);
	param_00 thread assignpersonalmodelents(param_00);
	param_00 thread watchforplayerzonechange(param_00);
	param_00 thread movepentstostructs(param_00);
	param_00 thread watch_for_cdc_shade(param_00);
	param_00 thread start_chemistry_interaction_items(param_00);
	level thread show_soul_key_progress(param_00);
	level thread watch_player_on_ladders(param_00);
	param_00 thread update_client_omnvars();
	param_00 thread scripts\cp\_vo::func_1769("nag_board_windows","rave_comment_vo",180,60,20,1);
	param_00 thread scripts\cp\maps\cp_town\cp_town_ghost_activation::watch_for_player_position();
}

//Function Number: 11
update_client_omnvars()
{
	wait(5);
	if(scripts\common\utility::istrue(level.has_picked_up_fuses) && !isdefined(level.placed_alien_fuses))
	{
		foreach(var_01 in level.players)
		{
			var_01 setclientomnvar("zm_special_item",1);
		}

		return;
	}

	if(scripts\common\utility::flag("picked_up_uncharged_fuses"))
	{
		foreach(var_01 in level.players)
		{
			var_01 setclientomnvar("zm_special_item",5);
		}
	}
}

//Function Number: 12
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

//Function Number: 13
start_chemistry_interaction_items(param_00)
{
	param_00 endon("disconnect");
	while(!scripts\common\utility::istrue(level.crafted_chem_set))
	{
		wait(1);
	}

	if(isdefined(level.h_p_button_objects))
	{
		foreach(var_02 in level.h_p_button_objects)
		{
			param_00 thread scripts\cp\maps\cp_town\cp_town_chemistry::update_player_monitor_buttons(var_02);
			param_00 thread scripts\cp\maps\cp_town\cp_town_chemistry::watch_for_input_entered_on_button(var_02);
		}
	}

	param_00 thread scripts\cp\maps\cp_town\cp_town_chemistry::watch_for_reaction_start_pressed(level.reaction_start_model);
	param_00 thread scripts\cp\maps\cp_town\cp_town_chemistry::update_player_monitor_reaction_start(level.reaction_start_model);
}

//Function Number: 14
watch_for_cdc_shade(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	level thread hide_on_game_ended();
	wait(5);
	var_01 = getent("cdc_shade","targetname");
	var_02 = getent("cdc_shade_volume","targetname");
	param_00.shade_hidden = 0;
	for(;;)
	{
		if(param_00 istouching(var_02) && !scripts\common\utility::istrue(param_00.zoom_out_camera))
		{
			if(!param_00.shade_hidden)
			{
				var_01 showtoplayer(param_00);
				param_00.shade_hidden = 1;
			}
		}
		else if(param_00.shade_hidden)
		{
			var_01 method_8429(param_00);
			param_00.shade_hidden = 0;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 15
hide_on_game_ended()
{
	level waittill("game_ended");
	wait(0.1);
	var_00 = getent("cdc_shade","targetname");
	var_00 hide();
}

//Function Number: 16
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
			param_00 thread [[ level.weapon_change_func[var_02] ]](param_00,var_01);
		}
	}
}

//Function Number: 17
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

//Function Number: 18
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
}

//Function Number: 19
registerscriptedagents()
{
	scripts\mp\_mp_agent::init_agent("mp/dlc3_agent_definition.csv");
	scripts\mp\agents\zombie_dlc3\zombie_dlc3_agent::registerscriptedagent();
	scripts\mp\agents\crab_brute\crab_brute_agent::registerscriptedagent();
	scripts\mp\agents\crab_mini\crab_mini_agent::registerscriptedagent();
	scripts\mp\agents\crab_boss\crab_boss_agent::registerscriptedagent();
	scripts\mp\agents\elvira\elvira_agent::registerscriptedagent();
}

//Function Number: 20
add_cutie_eggs()
{
	wait(5);
}

//Function Number: 21
cp_town_event_wave_init()
{
	level.var_6840["crab_mini"] = ::scripts\cp\zombies\cp_town_spawning::func_8453;
	init_town_spawner_locations();
}

//Function Number: 22
init_town_spawner_locations()
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

	level thread scripts\cp\zombies\cp_town_spawning::update_crog_spawners();
}

//Function Number: 23
cp_town_should_run_event(param_00)
{
	if(param_00 < 5)
	{
		return 0;
	}

	if(!level.tent_door_opened)
	{
		return 0;
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

//Function Number: 24
cp_town_event_selection(param_00)
{
	return "crab_mini";
}

//Function Number: 25
cp_town_event_start(param_00)
{
	switch(param_00)
	{
		case "crab_mini":
			level thread clown_wave_music();
			break;

		default:
			break;
	}
}

//Function Number: 26
clown_wave_music()
{
	wait(0.5);
	if(!scripts\common\utility::istrue(level.playspecialwave))
	{
		level thread play_willard_elvira_exchange("special_wave");
		level.playspecialwave = 1;
	}
	else
	{
		level thread scripts\cp\_vo::try_to_play_vo("ww_crog_wavestart","rave_announcer_vo","highest",70,0,0,1);
	}

	wait(2.5);
	if(soundexists("mus_zombies_eventwave_start"))
	{
		level thread mus_rave_eventwave_start();
	}
}

//Function Number: 27
play_willard_elvira_exchange(param_00,param_01)
{
	if(scripts\common\utility::istrue(level.var_13517) || scripts\common\utility::istrue(level.var_C9C1))
	{
		wait(1);
		return;
	}

	scripts\cp\_vo::func_F60C(1);
	level.var_C9C1 = 1;
	foreach(var_03 in level.players)
	{
		scripts\cp\_vo::func_C9CB([var_03]);
	}

	var_05 = level.elvira;
	switch(param_00)
	{
		case "special_wave":
			var_05 playsound("ww_specialwave_first_1");
			wait(scripts\cp\_vo::func_7C76("ww_specialwave_first_1"));
			var_05 playsound("el_specialwave_first_2");
			wait(scripts\cp\_vo::func_7C76("el_specialwave_first_2"));
			var_05 playsound("ww_specialwave_first_3");
			wait(scripts\cp\_vo::func_7C76("ww_specialwave_first_3"));
			break;

		case "escortingelvira":
			var_05 playsound("ww_escortingelvira_1");
			wait(scripts\cp\_vo::func_7C76("ww_escortingelvira_1"));
			var_05 playsound("el_escortingelvira_2");
			wait(scripts\cp\_vo::func_7C76("el_escortingelvira_2"));
			var_05 playsound("ww_escortingelvira_3");
			wait(scripts\cp\_vo::func_7C76("ww_escortingelvira_3"));
			var_05 playsound("el_escortingelvira_4");
			wait(scripts\cp\_vo::func_7C76("el_escortingelvira_4"));
			break;

		case "elvira_upgrade1":
			var_05 playsound("ww_elvira_upgrade1_1");
			wait(scripts\cp\_vo::func_7C76("ww_elvira_upgrade1_1"));
			var_05 playsound("el_elvira_upgrade1_2");
			wait(scripts\cp\_vo::func_7C76("el_elvira_upgrade1_2"));
			var_05 playsound("ww_elvira_upgrade1_3");
			wait(scripts\cp\_vo::func_7C76("ww_elvira_upgrade1_3"));
			var_05 playsound("el_elvira_upgrade1_4");
			wait(scripts\cp\_vo::func_7C76("el_elvira_upgrade1_4"));
			break;

		case "elvira_upgrade2":
			var_05 playsound("el_elvira_upgrade2_1");
			var_06 = scripts\cp\_vo::func_7C76("el_elvira_upgrade2_1");
			param_01 thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_talks(var_06);
			wait(var_06);
			var_05 playsound("ww_elvira_upgrade2_2");
			wait(scripts\cp\_vo::func_7C76("ww_elvira_upgrade2_2"));
			scripts\cp\_interaction::add_to_current_interaction_list(param_01);
			break;

		case "evirasbook":
			scripts\common\utility::play_sound_in_space("el_pap_nag_spellbook_vial",level.elvira.origin,0,level.elvira);
			var_06 = scripts\cp\_vo::func_7C76("el_pap_nag_spellbook_vial");
			param_01 thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_talks(var_06);
			wait(var_06);
			var_05 playsound("el_evirasbook_1");
			var_06 = scripts\cp\_vo::func_7C76("el_evirasbook_1");
			param_01 thread scripts\cp\maps\cp_town\cp_town_elvira::elvira_talks(var_06);
			wait(var_06);
			var_05 playsound("ww_evirasbook_2");
			wait(scripts\cp\_vo::func_7C76("ww_evirasbook_2"));
			scripts\cp\_interaction::add_to_current_interaction_list(param_01);
			break;

		case "crogboss_defeat":
			var_05 playsound("el_crogboss_defeat_1");
			wait(scripts\cp\_vo::func_7C76("el_crogboss_defeat_1"));
			var_05 playsound("ww_crogboss_defeat_2");
			wait(scripts\cp\_vo::func_7C76("ww_crogboss_defeat_2"));
			var_05 playsound("el_crogboss_defeat_3");
			wait(scripts\cp\_vo::func_7C76("el_crogboss_defeat_3"));
			break;
	}

	foreach(var_08 in level.players)
	{
		scripts\cp\_vo::func_12BE3([var_08]);
	}

	level.var_C9C1 = 0;
	scripts\cp\_vo::func_F60C(0);
}

//Function Number: 28
mus_rave_eventwave_start()
{
	scripts\cp\_utility::func_D52A("mus_zombies_eventwave_start",(0,0,0));
	level notify("wave_start_sound_done");
}

//Function Number: 29
mus_rave_eventwave_end()
{
	scripts\cp\_utility::func_D52A("mus_zombies_eventwave_end",(0,0,0));
}

//Function Number: 30
cp_town_event_end(param_00)
{
	switch(param_00)
	{
		case "crab_mini":
			level thread mus_rave_eventwave_end();
			break;

		default:
			break;
	}
}

//Function Number: 31
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

//Function Number: 32
cp_town_goon_patch_func(param_00)
{
	remove_goon_spawner((2848,335.6,-14.5),param_00);
	remove_goon_spawner((2428.1,462,-28.6),param_00);
	remove_goon_spawner((-415.2,-3898.9,392),param_00);
	remove_goon_spawner((-42.7,-3045.9,528.3),param_00);
	remove_goon_spawner((-413.1,-3389.7,524.8),param_00);
	remove_goon_spawner((4849.3,-2515.9,-61.5),param_00);
	remove_goon_spawner((5001.4,-3962.1,-30.4),param_00);
	remove_goon_spawner((-181.3,-2857.9,543.5),param_00);
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(116.2,-4497,297.9),(564.2,-4993,313.9));
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(874.5,-470.4,417.5),(602.5,-134.4,417.5));
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(-133.9,-3881.3,422.8),(-117.9,-4185.3,356.8));
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(-600,-2656,528),(-766,-2392,536));
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(5396.6,404.9,336),(5342.6,274.9,336));
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(5071,767.3,353.1),(4847,771.3,353.1));
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(5733.5,-3525.6,42.8),(5781.5,-3545.6,80.8));
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(5502,-3900.8,-22.8),(5820,-3994.8,5.2));
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(5152.2,-3497.8,-58.4),(4824.2,-3603.8,-58.4));
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(4637.8,-3391.1,-67.1),(4567.8,-3213.1,-61.1));
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(4492.1,-2471.5,-51.6),(5535.4,-3147.6,210.8));
	scripts\cp\zombies\zombies_spawning::move_goon_spawner(param_00,(-894.2,-4525,334.7),(-1070.2,-4461,334.7));
}

//Function Number: 33
remove_goon_spawner(param_00,param_01)
{
	var_02 = scripts\common\utility::getclosest(param_00,param_01,500);
	var_02.remove_me = 1;
}

//Function Number: 34
patch_update_spawners()
{
	scripts\cp\zombies\zombies_spawning::remove_origin((4795.6,1395.2,344));
	scripts\cp\zombies\zombies_spawning::remove_origin((-608.7,-3560,528.3));
	scripts\cp\zombies\zombies_spawning::remove_origin((-411.7,-3557.8,532.6));
}

//Function Number: 35
pap_machine_func(param_00,param_01)
{
	level.pap_machine = param_01;
	level.pap_machine hide();
	param_00.var_D776 = 1;
}

//Function Number: 36
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

//Function Number: 37
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

//Function Number: 38
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

//Function Number: 39
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
	level.pillageinfo.var_28C5 = "crafting_battery_single_01";
	level.pillageable_powers = [];
	level.pillageable_explosives = ["power_clusterGrenade","power_gasGrenade","power_bioSpike","power_c4","power_frag"];
	level.pillageable_attachments = [];
	level.pillageinfo.clip = 33;
	level.pillageinfo.explosive = 33;
	level.pillageinfo.money = 34;
	level.pillageinfo.var_28C2 = 0;
	lib_0D5E::register_zombie_pillageable("backpack_1","backpack","cp_rave_backpack_dropped","cp_rave_backpack","j_spine4");
	lib_0D5E::register_zombie_pillageable("backpack_2","backpack","cp_rave_backpack_dropped_green","cp_rave_backpack_green","j_spine4");
	lib_0D5E::register_zombie_pillageable("backpack_3","backpack","cp_rave_backpack_dropped_purple","cp_rave_backpack_purple","j_spine4");
	lib_0D5E::register_zombie_pillageable("backpack_4","backpack","cp_rave_backpack_dropped_red","cp_rave_backpack_red","j_spine4");
	level.battery_drop_wave = randomintrange(7,11);
	level thread rebalance_pillage_after_wave(level.battery_drop_wave);
	level thread wait_for_radios_fixed();
}

//Function Number: 40
rebalance_pillage_after_wave(param_00)
{
	level endon("game_ended");
	level endon("both_radios_fixed");
	for(;;)
	{
		level waittill("regular_wave_starting");
		if(level.wave_num >= param_00)
		{
			for(var_01 = 0;var_01 < level.var_CB87.size;var_01++)
			{
				switch(level.var_CB87[var_01].var_DE3F)
				{
					case "explosive":
						var_02 = 20;
						break;
	
					case "clip":
						var_02 = 15;
						break;
	
					case "money":
						var_02 = 15;
						break;
	
					case "battery":
						var_02 = 50;
						break;
	
					default:
						var_02 = 0;
						break;
				}

				level.var_CB87[var_01].var_3C35 = var_02;
			}
		}
	}
}

//Function Number: 41
rebalance_pillage_after_batteries()
{
	for(var_00 = 0;var_00 < level.var_CB87.size;var_00++)
	{
		switch(level.var_CB87[var_00].var_DE3F)
		{
			case "explosive":
				var_01 = 33;
				break;

			case "clip":
				var_01 = 33;
				break;

			case "money":
				var_01 = 34;
				break;

			case "battery":
				var_01 = 0;
				break;

			default:
				var_01 = 0;
				break;
		}

		level.var_CB87[var_00].var_3C35 = var_01;
	}

	foreach(var_03 in level.players)
	{
		var_03 setclientomnvar("zm_nag_text",0);
	}
}

//Function Number: 42
wait_for_radios_fixed()
{
	level endon("game_ended");
	level.chem_radios_fixed = 0;
	for(;;)
	{
		level waittill("radio_fixed");
		if(level.chem_radios_fixed == 2)
		{
			level notify("both_radios_fixed");
			level thread rebalance_pillage_after_batteries();
			break;
		}
	}
}

//Function Number: 43
watchforpowerontriggers()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("volume_activated",var_00);
		if(var_00 == "generator_transition" || var_00 == "elvira_transition")
		{
			break;
		}
	}

	wait(randomintrange(8,10));
	if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		level.players[0] thread scripts\cp\_vo::try_to_play_vo("el_color_restore_first","elvira_player_dialogue_vo","highest",70,0,0,1);
	}

	level thread colorize_sound_state_change("colorized",2.5);
	function_02A9("color","full",3);
	level.current_vision_set = "cp_town_color";
	level.var_13445 = level.current_vision_set;
	scripts\cp\maps\cp_town\cp_town_interactions::applyvisionsettoallplayers("cp_town_color");
	level.film_grain_off = 1;
	foreach(var_02 in level.players)
	{
		if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
		{
			var_02 playlocalsound("mus_zmb_town_full_color_lr");
		}

		var_02 setclientomnvar("zm_ui_dialpad_9",2);
	}
}

//Function Number: 44
colorize_sound_state_change(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1.5;
	}

	switch(param_00)
	{
		case "fullblackandwhite":
			function_02AA("worldcolorstate","full_black_and_white",param_01);
			break;

		case "colorized":
			function_02AA("worldcolorstate","color",param_01);
			break;

		default:
			function_02AA("worldcolorstate","color",param_01);
			break;
	}
}

//Function Number: 45
wait_for_pam_revive(param_00,param_01)
{
	level endon("hoff_death");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("revive_success");
	param_00 endon("death");
	var_02 = param_00.reviveent scripts\common\utility::waittill_any_timeout_1(param_01,"pg_trigger");
	if(!isdefined(var_02) || var_02 != "pg_trigger")
	{
		return undefined;
	}

	return 1;
}

//Function Number: 46
wait_to_be_revived_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(scripts\common\utility::istrue(level.the_hoff_revive))
	{
		if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
		{
			if(scripts\common\utility::istrue(param_0B))
			{
				wait(5);
				scripts\cp\_laststand::func_4164(param_00);
				self notify("revive_success");
				return 1;
			}

			var_0C = watchforpamrevive(param_00,param_07);
			if(scripts\common\utility::istrue(var_0C))
			{
				return 1;
			}

			scripts\cp\_laststand::func_4164(param_00);
			level thread [[ level.endgame ]]("axis",level.end_game_string_index["kia"]);
			level waittill("forever");
			return 0;
		}

		thread threadedpamrevivewatch(param_00,param_05);
		return;
	}

	return undefined;
}

//Function Number: 47
threadedpamrevivewatch(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("revive_success");
	var_02 = wait_for_pam_revive(param_00,param_01);
	if(scripts\common\utility::istrue(var_02))
	{
		scripts\cp\_laststand::func_4164(param_00);
		self notify("revive_success");
		return 1;
	}
}

//Function Number: 48
watchforreviveduringpamrevive()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("stop_watchForReviveDuringPamRevive");
	self waittill("revive_success");
	self.brevivedbeforepamcoulddoit = 1;
}

//Function Number: 49
watchforpamrevive(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	level notify("abort_debugendon");
	param_00 notify("abort_debugendon");
	param_00 thread watchforreviveduringpamrevive();
	var_02 = wait_for_pam_revive(param_00,param_01);
	scripts\common\utility::func_136F7();
	param_00 notify("stop_watchForReviveDuringPamRevive");
	if(scripts\common\utility::istrue(var_02))
	{
		scripts\cp\_laststand::func_4164(param_00);
		self notify("revive_success");
		return 1;
	}

	if(scripts\common\utility::istrue(self.brevivedbeforepamcoulddoit))
	{
		self.brevivedbeforepamcoulddoit = undefined;
		return 1;
	}

	return undefined;
}

//Function Number: 50
cp_town_spawn_fx_func()
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

			default:
				break;
		}
	}
}

//Function Number: 51
dirt_fx(param_00)
{
	self endon("death");
	self setscriptablepartstate("dirt","active");
	wait(param_00);
	self setscriptablepartstate("dirt","inactive");
}

//Function Number: 52
dirt_concrete_fx(param_00)
{
	self endon("death");
	self setscriptablepartstate("dirt_concrete","active");
	wait(param_00);
	self setscriptablepartstate("dirt_concrete","inactive");
}

//Function Number: 53
guidedinteractionsexclusions(param_00,param_01,param_02)
{
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

//Function Number: 54
guidedinteractionendposoverride(param_00,param_01)
{
	var_02 = (0,0,0);
	var_03 = scripts\cp\_interaction::func_7829(param_01);
	if(isdefined(param_01.script_noteworthy))
	{
		var_04 = param_01.script_noteworthy;
		switch(var_04)
		{
			case "iw7_mp28_zm":
				if(isdefined(var_03) && var_03 == "motel_transition")
				{
					var_02 = (0,0,24);
				}
				break;

			case "debris_750":
				if(isdefined(var_03) && var_03 == "morgue")
				{
					var_02 = (0,0,56);
				}
				break;

			case "perk_machine_rat_a_tat":
				if(isdefined(var_03) && var_03 == "elvira_station")
				{
					var_02 = (0,0,56);
				}
				break;

			case "debris_1500":
				if(isdefined(var_03) && var_03 == "supermarket")
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

//Function Number: 55
guidedinteractionoffsetfunc(param_00,param_01)
{
	var_02 = (0,0,56);
	var_03 = scripts\cp\_interaction::func_7829(param_00);
	if(isdefined(param_00.script_noteworthy))
	{
		var_04 = param_00.script_noteworthy;
		switch(var_04)
		{
			case "iw7_fmg_zm":
				if(isdefined(var_03) && var_03 == "camp_transition")
				{
					var_02 = (0,0,48);
				}
				break;

			case "iw7_cheytacc_zm":
				if(isdefined(var_03) && var_03 == "motel_transition")
				{
					var_02 = (0,0,16);
				}
				break;

			case "iw7_mp28_zm":
				if(isdefined(var_03) && var_03 == "motel_transition")
				{
					var_02 = (0,0,40);
				}
				break;

			case "iw7_revolver_zm":
				if(isdefined(var_03) && var_03 == "morgue")
				{
					var_02 = (0,0,45);
				}
				break;

			case "iw7_erad_zm":
				if(isdefined(var_03) && var_03 == "drive_in_theater")
				{
					var_02 = (0,0,5);
				}
				break;

			case "iw7_ump45c_zm":
				if(isdefined(var_03) && var_03 == "elvira_station")
				{
					var_02 = (0,0,62);
				}
				break;

			case "iw7_lockon_zm":
				if(isdefined(var_03) && var_03 == "bridge_beach")
				{
					var_02 = (0,0,57);
				}
				break;

			case "iw7_crb_zml":
				if(isdefined(var_03) && var_03 == "generator_transition")
				{
					var_02 = (0,0,68);
				}
				break;

			case "iw7_rvn_zm":
				if(isdefined(var_03) && var_03 == "gas_station_street")
				{
					var_02 = (0,0,45);
				}
				break;

			case "debris_1500":
				if(isdefined(var_03) && var_03 == "supermarket")
				{
					var_02 = (6,0,56);
				}
				break;

			default:
				var_02 = (0,0,56);
				break;
		}
	}

	return var_02;
}

//Function Number: 56
assignpersonalmodelents(param_00)
{
	param_00.personalents = [];
	for(var_01 = 0;var_01 < 15;var_01++)
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

//Function Number: 57
deletepentsondisconnect(param_00)
{
	level endon("game_ended");
	param_00 waittill("disconnect");
	foreach(var_02 in param_00.personalents)
	{
		var_02 delete();
	}
}

//Function Number: 58
addtopersonalinteractionlist(param_00)
{
	level.current_personal_interaction_structs = scripts\common\utility::array_add(level.current_personal_interaction_structs,param_00);
}

//Function Number: 59
removefrompersonalinteractionlist(param_00)
{
	level.current_personal_interaction_structs = scripts\common\utility::func_22A9(level.current_personal_interaction_structs,param_00);
}

//Function Number: 60
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
										var_09 [[ level.special_mode_activation_funcs[var_06.script_noteworthy] ]](var_09,var_06,0,param_00);
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
						}
						else if(scripts\common\utility::istrue(param_00.kung_fu_mode))
						{
							if(isdefined(var_06.script_noteworthy) && isdefined(level.special_mode_activation_funcs[var_06.script_noteworthy]))
							{
								var_08 = 1;
								if(isdefined(var_07))
								{
									var_09 [[ level.special_mode_activation_funcs[var_06.script_noteworthy] ]](var_09,var_07,1,param_00);
								}
								else
								{
									var_09 [[ level.special_mode_activation_funcs[var_06.script_noteworthy] ]](var_09,var_06,1,param_00);
								}
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

//Function Number: 61
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

//Function Number: 62
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

//Function Number: 63
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
		if(!scripts\common\utility::istrue(param_01.kung_fu_mode) && scripts\common\utility::istrue(var_04.only_kung_fu_mode))
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
			if(var_02.size >= 15)
			{
				break;
			}

			continue;
		}

		var_02[var_02.size] = var_04;
		if(var_02.size >= 15)
		{
			break;
		}
	}

	return var_02;
}

//Function Number: 64
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

//Function Number: 65
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

//Function Number: 66
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

//Function Number: 67
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

//Function Number: 68
resetpersonalent(param_00)
{
	param_00 setmodel("tag_origin");
	param_00.var_3FF2 = 0;
	param_00.var_1305B = 0;
	param_00 dontinterpolate();
	param_00.origin = param_00.var_C3A2;
	param_00 notify("p_ent_reset");
}

//Function Number: 69
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

//Function Number: 70
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

//Function Number: 71
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

//Function Number: 72
mutilation_mask_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = undefined;
	var_07 = zombies_should_mutilate(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	return var_07;
}

//Function Number: 73
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
			case "MOD_GRENADE":
			case "MOD_PROJECTILE_SPLASH":
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

//Function Number: 74
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

//Function Number: 75
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

//Function Number: 76
setup_generic_zombie_model_list()
{
	level.generic_zombie_model_list = ["zombie_dlc3_male_outfit_1","zombie_dlc3_male_outfit_1_2","zombie_dlc3_male_outfit_2","zombie_dlc3_male_outfit_2_2","zombie_dlc3_male_outfit_2_3","zombie_dlc3_male_outfit_3","zombie_dlc3_male_outfit_3_2","zombie_dlc3_male_outfit_3_3","zombie_dlc3_male_outfit_4","zombie_dlc3_male_outfit_4_2","zombie_dlc3_male_outfit_4_3","zombie_dlc3_male_outfit_5","zombie_dlc3_male_outfit_5_2","zombie_dlc3_male_outfit_5_3","zombie_dlc3_male_outfit_6","zombie_dlc3_male_outfit_6_2","zombie_dlc3_male_outfit_6_3","zombie_dlc3_female_outfit_1","zombie_dlc3_female_outfit_1_2","zombie_dlc3_female_outfit_1_3","zombie_dlc3_female_outfit_2","zombie_dlc3_female_outfit_2_2","zombie_dlc3_female_outfit_2_3","zombie_dlc3_female_outfit_3","zombie_dlc3_female_outfit_3_2","zombie_dlc3_female_outfit_3_3","zombie_dlc3_female_outfit_4","zombie_dlc3_female_outfit_4_2","zombie_dlc3_female_outfit_4_3","zombie_dlc3_female_outfit_5","zombie_dlc3_female_outfit_5_2","zombie_dlc3_female_outfit_5_3","zombie_dlc3_female_outfit_6","zombie_dlc3_female_outfit_6_2","zombie_dlc3_female_outfit_6_3","zombie_dlc3_male_greaser_01","zombie_dlc3_male_greaser_02","zombie_dlc3_male_greaser_01","zombie_dlc3_male_greaser_02"];
}

//Function Number: 77
interactiontriggerproperties(param_00,param_01,param_02)
{
	if(isdefined(param_01.script_noteworthy))
	{
		switch(param_01.script_noteworthy)
		{
			case "bomb_start":
			case "push_bomb":
				self.var_9A3F method_83D6(1);
				self.var_9A3F method_84A5(360);
				break;

			case "crafting_piece":
				self.var_9A3F method_83D6(1);
				self.var_9A3F method_84A5(270);
				break;

			case "iw7_knife_zm_crowbar":
				self.var_9A3F method_83D6(1);
				self.var_9A3F method_84A5(270);
				self.var_9A3F.origin = param_01.origin + (0,0,10);
				break;

			case "iw7_knife_zm_cleaver":
				self.var_9A3F method_83D6(1);
				self.var_9A3F method_84A5(270);
				break;

			case "hidden_song_record":
				self.var_9A3F method_83D6(1);
				self.var_9A3F method_84A5(30);
				if(param_01.target == "45_record_2")
				{
					self.var_9A3F.origin = param_01.origin + (20,8,10);
				}
				else if(param_01.target == "45_record_1")
				{
					self.var_9A3F.origin = param_01.origin + (5,0,5);
				}
				else if(param_01.target == "45_record_3")
				{
					self.var_9A3F.origin = param_01.origin + (-30,-5,0);
				}
				else if(param_01.target == "45_record_4")
				{
					self.var_9A3F.origin = param_01.origin + (15,15,25);
				}
				else
				{
					self.var_9A3F method_84A5(20);
					self.var_9A3F.origin = param_01.origin + (-15,-35,0);
				}
				break;

			case "mpq_zom_body_part":
				self.var_9A3F.origin = param_01.origin + (0,0,10);
				self.var_9A3F method_83D6(1);
				self.var_9A3F method_84A5(270);
				break;

			case "element_pickup":
			case "radiation_collector_interaction":
			case "cipher_interaction":
			case "radiation_extraction_interaction":
			case "town_fast_travel":
			case "plunger_ammo":
			case "generator_field_center":
			case "bomb_teleporter_part":
				self.var_9A3F.origin = param_01.origin + (0,0,10);
				self.var_9A3F method_83D6(1);
				self.var_9A3F method_84A5(270);
				break;

			case "compound_storage_4":
			case "compound_storage_3":
			case "compound_storage_2":
			case "compound_storage_1":
			case "chem_container_04":
			case "chem_container_03":
			case "chem_container_02":
			case "chem_container_01":
				self.var_9A3F.origin = param_01.origin + (0,0,10);
				self.var_9A3F method_83D6(1);
				self.var_9A3F method_84A5(270);
				break;

			case "discard_chem_interaction":
				self.var_9A3F.origin = param_01.origin + (0,0,20);
				self.var_9A3F method_83D6(1);
				self.var_9A3F method_84A5(270);
				break;
		}
	}
}

//Function Number: 78
cp_town_zap_start_func(param_00)
{
	self.var_EF64 = 1;
	self method_8286(self.origin);
}

//Function Number: 79
cp_town_zap_end_func(param_00)
{
	self.var_EF64 = 0;
}

//Function Number: 80
auto_melee_agent_type_check(param_00)
{
	if(isdefined(param_00.agent_type))
	{
		if(param_00.agent_type == "crab_mini")
		{
			return 0;
		}

		if(param_00.agent_type == "crab_brute")
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

//Function Number: 81
cp_town_should_do_damage_check_func(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(self.nodamage))
	{
		return 0;
	}

	return 1;
}

//Function Number: 82
setupdamagetriggers(param_00)
{
	param_00 endon("disconnect");
	scripts\common\utility::flag_wait("interactions_initialized");
	var_01 = getent("boundary_toxic_line","targetname");
	var_02 = scripts\common\utility::getstructarray("boundary_toxic_line_center","targetname");
	for(;;)
	{
		if(param_00 scripts\cp\_utility::is_valid_player() && function_010F(param_00.origin,var_01))
		{
			if(!isdefined(param_00.geiger_counter))
			{
				param_00.geiger_counter = 1;
				param_00 playlocalsound("town_geiger_counter_lvl4_plr");
			}

			if(scripts\cp\_laststand::player_in_laststand(param_00))
			{
				if(isdefined(param_00.geiger_counter))
				{
					param_00.geiger_counter = undefined;
					param_00 scripts\cp\_utility::stoplocalsound_safe("town_geiger_counter_lvl4_plr");
				}
			}

			if(param_00 istouching(level.radiation_collection_volume))
			{
				if(param_00 scripts\cp\_utility::has_zombie_perk("perk_machine_tough"))
				{
					var_03 = scripts\common\utility::getclosest(param_00.origin,var_02);
					var_04 = scripts\common\utility::func_116D7(distance(var_03.origin,param_00.origin) >= 128,int(param_00.maxhealth * 0.2),int(param_00.maxhealth * 0.5));
					param_00 dodamage(var_04 / 10,var_03.origin,var_01,var_01,"MOD_UNKNOWN","iw7_contamination_zm");
					wait(0.5);
				}
				else
				{
					var_03 = scripts\common\utility::getclosest(var_02.origin,var_04);
					var_04 = scripts\common\utility::func_116D7(distance(var_04.origin,var_01.origin) >= 128,int(var_01.maxhealth * 0.2),int(var_01.maxhealth * 0.5));
					param_00 dodamage(var_04,var_03.origin,var_01,var_01,"MOD_UNKNOWN","iw7_contamination_zm");
					wait(0.5);
				}

				param_00 setscriptablepartstate("screen_effects","screen_goo");
			}
			else
			{
				var_03 = scripts\common\utility::getclosest(var_02.origin,var_04);
				var_04 = scripts\common\utility::func_116D7(distance(var_04.origin,var_01.origin) >= 128,int(var_01.maxhealth * 0.2),int(var_01.maxhealth * 0.5));
				param_00 dodamage(var_04,var_03.origin,var_01,var_01,"MOD_UNKNOWN","iw7_contamination_zm");
				wait(0.5);
				param_00 setscriptablepartstate("screen_effects","screen_goo");
			}

			continue;
		}

		wait(0.1);
		if(isdefined(param_00.geiger_counter))
		{
			param_00.geiger_counter = undefined;
			param_00 scripts\cp\_utility::stoplocalsound_safe("town_geiger_counter_lvl4_plr");
		}
	}
}

//Function Number: 83
car_trap_test()
{
	wait(10);
	var_00 = getvehiclenode("car_path_1","targetname");
	var_01 = spawnvehicle("park_roller_coaster_cart","vehicle_car","cp_town_temp_vehicle",var_00.origin,var_00.angles);
	var_01 attachpath(var_00);
	var_01 startpath();
	for(;;)
	{
		wait(25);
		var_01 attachpath(var_00);
		var_01 startpath();
	}
}

//Function Number: 84
town_wheelnextweapon(param_00,param_01,param_02)
{
	if(!param_02 scripts\cp\_weapon::func_8BBB("iw7_cutier_zm") && !param_02 scripts\cp\_weapon::func_8BBB("iw7_cutie_zm") && randomint(100) <= 10)
	{
		param_00.var_13C25 = scripts\common\utility::array_add(param_00.var_13C25,"iw7_cutie_zm");
		return "iw7_cutie_zm";
	}

	return param_01;
}

//Function Number: 85
town_choose_correct_vo_for_player(param_00)
{
	wait(18);
	var_01 = "";
	if(param_00.times_self_revived >= param_00.max_self_revive_machine_use)
	{
		var_01 = "ww_afterlife_p4_notoken";
	}
	else
	{
		var_02 = ["ww_afterlife_p1_generic","ww_afterlife_p5_alt_1","ww_afterlife_arrive"];
		var_01 = scripts\common\utility::random(var_02);
	}

	if(var_01 == "ww_afterlife_arrive")
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo(var_01,"zmb_afterlife_vo","high",20,0,0,1);
		return;
	}

	var_03 = strtok(var_01,"_");
	var_04 = "";
	var_05 = var_03[3];
	var_06 = param_00.vo_suffix;
	var_07 = strtok(var_06,"_");
	var_08 = var_07[0];
	switch(var_08)
	{
		case "p5":
		case "p4":
		case "p3":
		case "p2":
		case "p1":
			var_04 = choose_vo_based_on_type(var_08,var_05);
			break;

		default:
			var_04 = var_01;
			break;
	}

	if(soundexists(var_04))
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo(var_04,"zmb_afterlife_vo","high",60,1,0,1);
	}
}

//Function Number: 86
choose_vo_based_on_type(param_00,param_01)
{
	var_02 = "ww_afterlife_";
	for(;;)
	{
		var_02 = "ww_afterlife_";
		switch(param_01)
		{
			case "generic":
				var_02 = var_02 + param_00 + "_generic";
				break;
	
			case "notoken":
				var_02 = var_02 + param_00 + "_notoken";
				break;
	
			case "alt":
				var_02 = var_02 + param_00 + "_alt_1";
				break;
	
			default:
				break;
		}

		if(!soundexists(var_02))
		{
			var_03 = ["ww_afterlife_p1_generic","ww_afterlife_arrive","ww_afterlife_p5_alt_1"];
			var_02 = scripts\common\utility::random(var_03);
			if(var_02 == "ww_afterlife_arrive")
			{
				return var_02;
			}
			else
			{
				var_04 = strtok(var_02,"_");
				param_01 = var_04[3];
				continue;
			}
		}
		else
		{
			return var_02;
		}

		scripts\common\utility::func_136F7();
	}

	return var_02;
}

//Function Number: 87
setup_pap_camos()
{
	level.no_pap_camos = ["cutie","iw7_cutier_zm"];
	level.pap_1_camo = "camo92";
	level.pap_2_camo = "camo93";
}

//Function Number: 88
setupweaponupgradearray()
{
	level.weapon_upgrade_path = [];
	level.weapon_upgrade_path["iw7_cutie_zm"] = "iw7_cutie_zm+cutiegrip";
	level.weapon_upgrade_path["iw7_cutie_zm+cutiegrip"] = " iw7_cutie_zm+cutiecrank+cutiegrip+cutieplunger";
}

//Function Number: 89
water_triggers()
{
	var_00 = getentarray("water_trigger","targetname");
	scripts\common\utility::array_thread(var_00,::water_trigger);
	level.water_respawn_spots = scripts\common\utility::getstructarray("water_respawn_spot","targetname");
}

//Function Number: 90
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
				if(isdefined(var_00.var_3AA5) && isdefined(var_00.var_3AA5.name) && var_00.var_3AA5.name == "crafted_rad_extractor")
				{
					if(!scripts\common\utility::istrue(level.completed_pool_part_skulltop_quest))
					{
						continue;
					}
					else
					{
						if(isdefined(level.pool_extraction_fx))
						{
							level.pool_extraction_fx delete();
						}

						level.rad_extractor_owner = undefined;
					}
				}

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

//Function Number: 91
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
		move_player_to_closest_spot(self);
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
				move_player_to_closest_spot(self);
				reset_water_values();
				return;
			}

			if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && scripts\cp\_utility::has_zombie_perk("perk_machine_revive"))
			{
				reset_water_values();
				return;
			}

			move_player_to_closest_spot(self);
			reset_water_values();
			return;
		}

		wait(0.05);
	}

	reset_water_values();
}

//Function Number: 92
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

//Function Number: 93
move_player_to_closest_spot(param_00)
{
	var_01 = get_closest_valid_water_respawn_spots(param_00);
	var_02 = var_01.origin + (0,0,20);
	var_03 = getgroundposition(var_02,8,32,32);
	if(!isdefined(var_03))
	{
		var_03 = var_01.origin;
	}

	param_00 setorigin(var_03);
	wait(0.5);
}

//Function Number: 94
get_closest_valid_water_respawn_spots(param_00)
{
	var_01 = sortbydistance(level.water_respawn_spots,param_00.origin);
	foreach(var_03 in var_01)
	{
		if(canspawn(var_03.origin) && !positionwouldtelefrag(var_03.origin))
		{
			return var_03;
		}
	}
}

//Function Number: 95
setup_pa_speakers()
{
	level.var_A4BF = "cp/zombies/cp_town_music_genre.csv";
	scripts\cp\zombies\zombie_jukebox::parse_music_genre_table();
	wait(1.15);
	disablepaspeaker("pa_town_icecream_out");
	disablepaspeaker("pa_town_icecream_in");
	disablepaspeaker("pa_town_snackshake_out");
	disablepaspeaker("pa_town_motel_out");
	disablepaspeaker("pa_town_market_in");
	disablepaspeaker("pa_town_market_out");
	disablepaspeaker("pa_town_camper_out");
	level thread reenablepas_after_host_migration();
}

//Function Number: 96
reenablepas_after_host_migration()
{
	level endon("game_ended");
	level waittill("host_migration_begin");
	level waittill("host_migration_end");
	if(scripts\common\utility::istrue(level.music_playing))
	{
		if(!isdefined(level.enabled_jukeboxes))
		{
			return;
		}

		foreach(var_01 in level.enabled_jukeboxes)
		{
			scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town(var_01);
		}
	}

	if(isdefined(level.current_vision_set))
	{
		scripts\cp\maps\cp_town\cp_town_interactions::applyvisionsettoallplayers(level.current_vision_set);
	}
}

//Function Number: 97
enablepas()
{
	level.music_playing = 1;
	if(!isdefined(level.enabled_jukeboxes))
	{
		level.enabled_jukeboxes = [];
	}

	scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_icecream_out");
	scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_icecream_in");
	scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_snackshake_out");
	scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_motel_out");
	scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_market_in");
	scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_market_out");
	scripts\cp\maps\cp_town\cp_town_interactions::enable_pa_speaker_for_town("pa_town_camper_out");
	wait(1);
	if(scripts\common\utility::flag("queue_hidden_song"))
	{
		scripts\common\utility::flag_wait("hidden_song_ended");
	}

	level thread scripts\cp\zombies\zombie_jukebox::func_A4BE((1785,-2077,211));
	wait(4);
	level notify("jukebox_start");
}

//Function Number: 98
show_soul_key_progress(param_00)
{
	param_00 endon("disconnect");
	var_01 = (-10265,932,-1581);
	var_02 = (0,0,90);
	var_03 = (-10260,932,-1561);
	var_04 = (0,0,90);
	var_05 = (-10250,932,-1555);
	var_06 = (0,0,90);
	param_00 waittill("spawned_player");
	var_07 = param_00 getplayerdata("cp","haveSoulKeys","soul_key_1");
	var_08 = param_00 getplayerdata("cp","haveSoulKeys","soul_key_2");
	var_09 = param_00 getplayerdata("cp","haveSoulKeys","soul_key_3");
	if(scripts\common\utility::istrue(var_07))
	{
		playfx(level._effect["soul_jar_d"],var_01,anglestoforward(var_02),anglestoup(var_02),param_00);
	}

	if(scripts\common\utility::istrue(var_08))
	{
		playfx(level._effect["soul_jar_e"],var_03,anglestoforward(var_04),anglestoup(var_04),param_00);
	}

	if(scripts\common\utility::istrue(var_08))
	{
		playfx(level._effect["soul_jar_a"],var_05,anglestoforward(var_06),anglestoup(var_06),param_00);
	}
}

//Function Number: 99
town_power_on_vo(param_00)
{
	level endon("gamed_ended");
	param_00 endon("death");
	param_00 endon("disconnect");
	if(scripts\common\utility::func_6E34("canFiresale"))
	{
		scripts\common\utility::flag_set("canFiresale");
	}

	var_01 = "final_1";
	switch(param_00.var_134FD)
	{
		case "p1_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("sally_power_" + var_01,"rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["sally_power_" + var_01] = 1;
			break;

		case "p4_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("aj_power_" + var_01,"rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["aj_power_" + var_01] = 1;
			break;

		case "p3_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("andre_power_" + var_01,"rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["andre_power_" + var_01] = 1;
			break;

		case "p2_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("pdex_power_" + var_01,"rave_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["pdex_power_" + var_01] = 1;
			break;

		default:
			break;
	}

	scripts\cp\_vo::func_E01F("nag_activate_power",1);
}

//Function Number: 100
cp_town_introscreen_text()
{
	var_00 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_TOWN_INTRO_LINE_1",1);
	wait(1);
	var_01 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_TOWN_INTRO_LINE_2",2);
	wait(1);
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		var_02 = scripts\cp\_hud_util::introscreen_corner_line(&"DIRECT_BOSS_FIGHT_LINE4_TOWN",4);
	}
	else
	{
		var_02 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_TOWN_INTRO_LINE_3",3);
	}

	wait(1);
	var_03 = scripts\cp\_hud_util::introscreen_corner_line(&"CP_TOWN_INTRO_LINE_4",4);
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

//Function Number: 101
comp_test()
{
	wait(10);
	foreach(var_01 in level.chemistry_set_parts)
	{
		if(isdefined(var_01.model) && var_01.model == "cp_town_chem_lab_computer_interactive")
		{
			var_01 show();
			var_01 setscriptablepartstate("screen","on");
			for(;;)
			{
				var_01 setscriptablepartstate("screen","on");
				wait(2);
				var_01 setscriptablepartstate("redlight","on");
				wait(2);
				var_01 setscriptablepartstate("redlight","off");
				wait(2);
				var_01 setscriptablepartstate("greenlight","on");
				wait(2);
				var_01 setscriptablepartstate("greenlight","off");
				wait(2);
				var_01 setscriptablepartstate("yellowlight","on");
				wait(2);
				var_01 setscriptablepartstate("yellowlight","off");
				wait(2);
			}
		}
	}
}

//Function Number: 102
map_exploit_spots()
{
	level.invalid_orgs = [];
	var_00 = spawn("script_model",(4969.5,-2212.4,166));
	var_00.angles = (88.7987,51.7666,2.36934);
	var_00 setmodel("player128x128x8");
	var_01 = spawn("script_model",(4904.5,-2156.1,166));
	var_01.angles = (88.7989,51.8044,3.00622);
	var_01 setmodel("player128x128x8");
	var_02 = spawn("script_model",(912,-945.5,544.5));
	var_02 setmodel("player16x16x128_rounded");
}

//Function Number: 103
townhostmigrationfunc()
{
	if(isdefined(level.film_grain_off))
	{
		foreach(var_01 in level.players)
		{
			var_01 setclientomnvar("zm_ui_dialpad_9",2);
		}
	}

	scripts\cp\maps\cp_town\cp_town_interactions::applyvisionsettoallplayers(level.current_vision_set);
}

//Function Number: 104
cp_town_ismeleeblocked_func()
{
	var_00 = self.origin + (0,0,self.var_B5F9);
	var_01 = self.var_4B26.origin + (0,0,self.var_B5F9);
	if(!isplayer(self.var_4B26) && !isai(self.var_4B26))
	{
		return 0;
	}

	if(isplayer(self.var_4B26))
	{
		if(self.var_4B26 isusingturret())
		{
			return 0;
		}
	}

	var_02 = [];
	var_02[var_02.size] = self.var_4B26;
	foreach(var_04 in level.death_ray_cannons)
	{
		var_02[var_02.size] = var_04;
	}

	var_06 = scripts\common\trace::func_48BC(0,1,1,1,0,1,0);
	if(scripts\common\trace::func_DCF1(var_00,var_01,var_02,var_06))
	{
		return 0;
	}

	if(isplayer(self.var_4B26))
	{
		var_06 = scripts\common\trace::func_48CC(0);
		var_07 = scripts\common\trace::func_DCED(var_00,var_01,level.var_1900,var_06);
		if(var_07["hittype"] == "hittype_entity" && var_07["entity"] == self.var_4B26)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 105
town_setup_direct_boss_fight_func()
{
	level.var_13FA3 = 1;
	level.direct_boss_fight_flag_wait = "crab_boss_combat_ready";
	scripts\cp\maps\cp_town\cp_town_crab_boss_fight::advance_pre_combat_stage();
}

//Function Number: 106
town_start_direct_boss_fight_func()
{
	level notify("crab_boss_quest_completed");
	level.var_8136 = ::respawn_in_crab_boss_fight;
	wait(2);
	give_players_cleaver();
	scripts\cp\_utility::set_quest_icon(23);
	scripts\common\utility::func_6E2A("vial_filled");
	level thread scripts\cp\maps\cp_town\cp_town_elvira::crog_vial_meter();
	setomnvar("zom_general_fill_percent_2",0);
	scripts\cp\_utility::set_quest_icon(20);
}

//Function Number: 107
give_players_cleaver()
{
	var_00 = "iw7_knife_zm_cleaver";
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.var_4BF5))
		{
			var_02 takeweapon(var_02.var_4BF5);
		}

		var_02 giveweapon(var_00);
		var_02.var_501B = var_00;
		var_02.var_4BF5 = var_00;
		var_02.melee_weapon = var_00;
	}
}

//Function Number: 108
respawn_in_crab_boss_fight()
{
	var_00 = [(1654,-1472,304),(1812,-1366,239),(1914,-1174,187),(2185,-1170,185)];
	var_01 = (3035,2829,-141);
	var_02 = [];
	foreach(var_06, var_04 in var_00)
	{
		var_05 = spawnstruct();
		var_05.origin = var_04;
		var_05.angles = vectortoangles(var_01 - var_04);
		var_02[var_06] = var_05;
	}

	foreach(var_05 in var_02)
	{
		if(positionwouldtelefrag(var_05.origin))
		{
			continue;
		}

		return var_05;
	}

	return var_02[0];
}