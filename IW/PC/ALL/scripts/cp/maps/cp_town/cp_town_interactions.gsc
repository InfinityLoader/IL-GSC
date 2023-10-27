/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_town\cp_town_interactions.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 103
 * Decompile Time: 5155 ms
 * Timestamp: 10/27/2023 12:07:32 AM
*******************************************************************/

//Function Number: 1
register_interactions()
{
	registerweaponinteractions();
	level.interaction_hintstrings["debris_350"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1000"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1500"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_2000"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_2500"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1250"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_750"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["team_door_switch"] = &"CP_TOWN_INTERACTIONS_TEAM_DOOR_SWITCH";
	level.interaction_hintstrings["power_door_sliding"] = &"COOP_INTERACTIONS_REQUIRES_POWER";
	level.interaction_hintstrings["weapon_upgrade"] = &"CP_TOWN_INTERACTIONS_UPGRADE_WEAPON";
	level.interaction_hintstrings["crank"] = &"CP_TOWN_INTERACTIONS_PICKUP_CRANK";
	level.interaction_hintstrings["front_barrel"] = &"CP_TOWN_INTERACTIONS_PICKUP_GRIP";
	level.interaction_hintstrings["plunger"] = &"CP_TOWN_INTERACTIONS_PICKUP_PLUNGER";
	scripts\cp\_interaction::func_DEBB("debris_350","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,350);
	scripts\cp\_interaction::func_DEBB("debris_1000","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1000);
	scripts\cp\_interaction::func_DEBB("debris_1500","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1500);
	scripts\cp\_interaction::func_DEBB("debris_2000","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,2000);
	scripts\cp\_interaction::func_DEBB("debris_2500","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,2500);
	scripts\cp\_interaction::func_DEBB("debris_1250","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1250);
	scripts\cp\_interaction::func_DEBB("debris_750","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,750);
	scripts\cp\_interaction::func_DEBB("team_door_switch","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_1302F,250);
	scripts\cp\_interaction::func_DEBB("power_door_sliding","door_buy",undefined,undefined,undefined,0,1,::func_9749);
	scripts\cp\_interaction::func_DEBB("weapon_upgrade","pap",undefined,::scripts\cp\maps\cp_town\cp_town_weapon_upgrade::weapon_upgrade_hint_func,::scripts\cp\maps\cp_town\cp_town_weapon_upgrade::func_13C62,5000,1,::scripts\cp\maps\cp_town\cp_town_weapon_upgrade::init_weapon_upgrade);
	town_register_interaction(1,"pap_fuse_switch",undefined,undefined,::papfuseswitchhint,::usepapfuseswitch,0,0);
	town_register_interaction(1,"fast_travel_panel_bridge",undefined,undefined,::blankhintfunc,::blankusefunc,0,0);
	town_register_interaction(1,"generator_field_center",undefined,undefined,::generator_field_hint,::usegeneratorfieldcenter,0,0);
	town_register_interaction(1,"pap_early_exit",undefined,undefined,::blankhintfunc,::papearlyexituse,0,0);
	town_register_interaction(1,"pap_fusebox",undefined,undefined,::blankhintfunc,::pickupfuse,0,0,::init_papfusebox);
	town_register_interaction(1,"fast_travel_panel",undefined,undefined,::papanomalyhint,::usepapanomaly,0,0,::init_papanomaly);
	town_register_interaction(1,"cutie",undefined,undefined,::blankhintfunc,::usecutiepickup,0,0);
	town_register_interaction(1,"crank",undefined,undefined,::cutie_hint_func,::addcutieattachment,0,0);
	town_register_interaction(1,"front_barrel",undefined,undefined,::cutie_hint_func,::addcutieattachment,0,0);
	town_register_interaction(1,"plunger",undefined,undefined,::cutie_hint_func,::addcutieattachment,0,0);
	town_register_interaction(1,"plunger_ammo",undefined,undefined,::cutieammohintfunc,::useplungerammo,0,0);
	level thread setup_additional_cutie_ammo();
	town_register_interaction(0,"technicolor_machine",undefined,undefined,::tcs_hint,::usetcs,0,0,::init_tcs);
	town_register_interaction(1,"missing_handle",undefined,undefined,::missinghandlehint,::usemissinghandle,0,0,::missinghandleinit);
	town_register_interaction(0,"generator_broken",undefined,undefined,::brokengeneratorhint,::usebrokengenerator,0,0);
	town_register_interaction(1,"pillage_item",undefined,undefined,::lib_0D5E::func_CB59,::lib_0D5E::func_D31E,0,0);
	town_register_interaction(1,"town_fast_travel",undefined,undefined,::fast_travel_hint,::fast_travel_use,0,0,::func_6B8F);
	town_register_interaction(1,"hidden_song_record",undefined,undefined,::blankhintfunc,::record_use_logic,0,0,::show_record_debug);
	town_register_interaction(1,"hidden_song_jukebox",undefined,undefined,::jukebox_interaction_hint,::jukebox_use_func,0,0);
	scripts\common\utility::flag_init("queue_hidden_song");
	scripts\common\utility::flag_init("hidden_song_ended");
	town_register_interaction(0,"figure_1",undefined,undefined,::scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_hint,::scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_func,0,0,::scripts\cp\maps\cp_town\cp_town_ghost_activation::init_fig1);
	town_register_interaction(0,"figure_2",undefined,undefined,::scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_hint,::scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_func,0,0,::scripts\cp\maps\cp_town\cp_town_ghost_activation::init_fig2);
	town_register_interaction(0,"figure_3",undefined,undefined,::scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_hint,::scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_func,0,0,::scripts\cp\maps\cp_town\cp_town_ghost_activation::init_fig3);
	town_register_interaction(0,"figure_4",undefined,undefined,::scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_hint,::scripts\cp\maps\cp_town\cp_town_ghost_activation::mem_object_func,0,0,::scripts\cp\maps\cp_town\cp_town_ghost_activation::init_fig4);
	town_register_interaction(1,"backstory_interaction",undefined,undefined,::backstory_hint_func,::backstory_activation,0,0,::init_backstory_interaction,undefined);
	town_register_interaction(0,"debug_crab_boss",undefined,undefined,::blankhintfunc,::scripts\cp\maps\cp_town\cp_town_crab_boss_fight::usecrabbossdebug,0,0);
	registeratminteractions();
	func_DE92();
	register_crab_boss_interactions();
	scripts\cp\maps\cp_town\cp_town_traps::register_traps();
	scripts\cp\maps\cp_town\cp_town_crafting::register_crafting();
	scripts\cp\maps\cp_town\cp_town_mpq::init_mpq_interactions();
	scripts\cp\maps\cp_town\cp_town_ghost_activation::init_skullbusters_interactions();
	scripts\common\utility::flag_set("interactions_initialized");
	scripts\cp\maps\cp_town\cp_town_elvira::register_elvira_interactions();
	if(isdefined(level.escape_interaction_registration_func))
	{
		[[ level.escape_interaction_registration_func ]]();
	}
}

//Function Number: 2
backstory_activation(param_00,param_01)
{
	param_01 endon("disconnect");
	if(!isdefined(param_01.completed_aliases_for_backstory_achievement))
	{
		param_01.completed_aliases_for_backstory_achievement = [];
	}

	if(param_01.var_134FD == "p5_")
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.playing_backstory))
	{
		return;
	}

	level.var_C9C1 = 1;
	var_02 = "";
	scripts\cp\_vo::func_C9CB([param_01]);
	var_02 = get_random_alias(param_00,param_01);
	if(var_02 != "" && !scripts\common\utility::func_2286(param_01.completed_aliases_for_backstory_achievement,var_02))
	{
		var_03 = strtok(var_02,"_");
		if(var_03[2] == "sally" || var_03[2] == "andre" || var_03[2] == "aj" || var_03[2] == "pdex")
		{
			switch(param_01.var_134FD)
			{
				case "p1_":
					var_02 = "ww_diary_sally_" + var_03[3];
					break;

				case "p2_":
					var_02 = "ww_diary_pdex_" + var_03[3];
					break;

				case "p3_":
					var_02 = "ww_diary_andre_" + var_03[3];
					break;

				case "p4_":
					var_02 = "ww_diary_aj_" + var_03[3];
					break;

				default:
					break;
			}

			param_00.array_of_aliases = scripts\common\utility::func_22A9(param_00.array_of_aliases,var_02);
		}

		param_01 playlocalsound(var_02);
		param_01.playing_backstory = 1;
		if(!scripts\common\utility::func_2286(param_01.completed_aliases_for_backstory_achievement,var_02))
		{
			param_01.completed_aliases_for_backstory_achievement[param_01.completed_aliases_for_backstory_achievement.size] = var_02;
		}

		if(!scripts\common\utility::istrue(level.defeated_crogboss))
		{
			scripts\cp\_interaction::func_E01A(param_00,param_01);
		}

		param_01 scripts\cp\_interaction::func_DE6E();
		wait(scripts\cp\_vo::func_7C76(var_02));
		param_01.playing_backstory = undefined;
		param_01.played_backstory_vo = 1;
	}

	if(param_01.completed_aliases_for_backstory_achievement.size >= 9)
	{
		param_01 lib_0D2A::func_12D7C("DEAR_DIARY",1);
	}

	scripts\cp\_vo::func_12BE3([param_01]);
	level.var_C9C1 = 0;
}

//Function Number: 3
get_random_alias(param_00,param_01)
{
	while(param_01.completed_aliases_for_backstory_achievement.size < 9)
	{
		var_02 = scripts\common\utility::random(param_00.array_of_aliases);
		var_03 = strtok(var_02,"_");
		if(var_03[2] == "sally" || var_03[2] == "andre" || var_03[2] == "aj" || var_03[2] == "pdex")
		{
			switch(param_01.var_134FD)
			{
				case "p1_":
					if(var_03[2] != "sally")
					{
						scripts\common\utility::func_136F7();
						break;
					}
					break;

				case "p2_":
					if(var_03[2] != "pdex")
					{
						scripts\common\utility::func_136F7();
						break;
					}
					break;

				case "p3_":
					if(var_03[2] != "andre")
					{
						scripts\common\utility::func_136F7();
						break;
					}
					break;

				case "p4_":
					if(var_03[2] != "aj")
					{
						scripts\common\utility::func_136F7();
						break;
					}
					break;
			}
		}

		if(scripts\common\utility::func_2286(param_01.completed_aliases_for_backstory_achievement,var_02))
		{
			scripts\common\utility::func_136F7();
			continue;
		}
		else
		{
			return var_02;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 4
backstory_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 5
init_backstory_interaction()
{
	var_00 = scripts\common\utility::getstructarray("backstory_interaction","script_noteworthy");
	foreach(var_04, var_02 in var_00)
	{
		var_03 = undefined;
		switch(var_02.name)
		{
			case "backstory_interaction":
				var_03 = spawn("script_model",var_02.origin);
				var_03 setmodel("cp_town_willard_book");
				var_03.angles = var_02.angles;
				var_02.array_of_aliases = ["ww_diary_sally_1","ww_diary_sally_2","ww_diary_sally_3","ww_diary_aj_1","ww_diary_aj_2","ww_diary_aj_3","ww_diary_andre_1","ww_diary_andre_2","ww_diary_andre_3","ww_diary_pdex_1","ww_diary_pdex_2","ww_diary_pdex_3","ww_diary_orig4_1","ww_diary_orig4_2","ww_diary_winona_1","ww_diary_alexandra_1","ww_diary_willard_1","ww_diary_willard_2"];
				break;

			default:
				break;
		}

		if(isdefined(var_03))
		{
			var_02.model = var_03;
		}

		level.backstory_interactions[var_04] = var_02;
	}
}

//Function Number: 6
func_9749()
{
	var_00 = scripts\common\utility::getstructarray("power_door_sliding","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_102F8();
	}
}

//Function Number: 7
func_102F8()
{
	if(scripts\common\utility::istrue(self.var_E1B9))
	{
		level scripts\common\utility::waittill_any_3("power_on",self.var_D71C + " power_on");
	}

	self.var_D776 = 1;
	if(isdefined(self.script_sound))
	{
		playsoundatpos(self.origin,self.script_sound);
	}

	var_00 = getentarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.classname == "script_brushmodel")
		{
			var_02 connectpaths();
			var_02 notsolid();
		}

		var_03 = undefined;
		if(isdefined(var_02.target))
		{
			var_03 = scripts\common\utility::getstruct(var_02.target,"targetname");
		}

		if(isdefined(var_03))
		{
			var_04 = var_03.origin - var_02.origin;
			var_02 moveto(var_02.origin + (var_04[0],var_04[1],0),0.5,0.1,0.1);
			continue;
		}

		if(isdefined(var_02.var_ECF3))
		{
			var_02 rotateto(var_02.var_ECF3,0.75);
			continue;
		}

		var_02 hide();
	}

	scripts\cp\_interaction::func_554F(self);
	scripts\cp\zombies\zombies_spawning::func_F28B(self);
	scripts\cp\zombies\zombies_spawning::func_15FC(self.script_area);
}

//Function Number: 8
func_DE92()
{
	level.interaction_hintstrings["basketball_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["laughingclown_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["bowling_for_planets_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["clown_tooth_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["game_race"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_icehock"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_seaques"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_boxing"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_oink"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_keyston"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_plaque"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_crackpo"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_hero"] = &"COOP_INTERACTIONS_PLAY_GAME";
	scripts\cp\_interaction::func_DEBB("arcade_hero","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_icehock","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_seaques","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_boxing","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_oink","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_keyston","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_plaque","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_crackpo","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("basketball_game_afterlife","afterlife_game",undefined,undefined,::lib_0D2E::func_12FA8,0,0,::lib_0D2E::func_94D8);
	scripts\cp\_interaction::func_DEBB("clown_tooth_game_afterlife","afterlife_game",undefined,undefined,::lib_0D33::func_12FBC,0,0,::lib_0D33::func_94D9);
	scripts\cp\_interaction::func_DEBB("laughingclown_afterlife","afterlife_game",undefined,undefined,::lib_0D36::func_AA4B,0,0,::lib_0D36::func_94EC);
	scripts\cp\_interaction::func_DEBB("bowling_for_planets_afterlife","afterlife_game",undefined,undefined,::lib_0D31::func_12FAB,0,0,::lib_0D31::func_9549);
	scripts\cp\_interaction::func_DEBB("game_race","arcade_game",undefined,::lib_0D3A::func_DBB3,::lib_0D3A::func_13003,0,1,::lib_0D3A::func_94F0);
}

//Function Number: 9
func_DEA7()
{
	scripts\cp\_interaction::func_DEBB("pillage_item",undefined,undefined,::lib_0D5E::func_CB59,::lib_0D5E::func_D31E,0,0);
}

//Function Number: 10
town_register_interaction(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = spawnstruct();
	var_0A.name = param_01;
	var_0A.var_8FFA = param_04;
	var_0A.var_109DA = param_02;
	var_0A.var_12AA2 = param_03;
	var_0A.var_161A = param_05;
	var_0A.var_6261 = 1;
	var_0A.disable_guided_interactions = param_00;
	if(!isdefined(param_06))
	{
		param_06 = 0;
	}

	var_0A.cost = param_06;
	if(isdefined(param_07))
	{
		var_0A.var_E1B9 = param_07;
	}
	else
	{
		var_0A.var_E1B9 = 0;
	}

	var_0A.var_95F2 = param_08;
	var_0A.var_3865 = param_09;
	level.interactions[param_01] = var_0A;
}

//Function Number: 11
registeratminteractions()
{
	level.interaction_hintstrings["atm_deposit"] = &"CP_TOWN_INTERACTIONS_ATM_DEPOSIT";
	level.interaction_hintstrings["atm_withdrawal"] = &"CP_TOWN_INTERACTIONS_ATM_WITHDRAWAL";
	town_register_interaction(0,"atm_deposit","atm",undefined,::scripts\cp\_interaction::atm_deposit_hint,::atm_deposit,1000,1,undefined);
	town_register_interaction(0,"atm_withdrawal","atm",undefined,::atm_withdrawal_hint,::atm_withdrawal,0,1,::setup_atm_system);
}

//Function Number: 12
registerweaponinteractions()
{
	level.interaction_hintstrings["iw7_ake_zml"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_cheytacc_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_rvn_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_fmg_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_g18c_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_lockon_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_revolver_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_minilmg_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_mp28_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_spasc_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ump45c_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_vr_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_arclassic_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_erad_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_udm45_zm"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_crb_zml"] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
	var_00 = 500;
	scripts\cp\_interaction::func_DEBB("iw7_revolver_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	var_00 = 750;
	scripts\cp\_interaction::func_DEBB("iw7_udm45_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_g18c_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	var_00 = 1000;
	scripts\cp\_interaction::func_DEBB("iw7_lockon_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_cheytacc_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_mp28_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_ump45c_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	var_00 = 1250;
	scripts\cp\_interaction::func_DEBB("iw7_erad_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_crb_zml","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_spasc_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	var_00 = 1500;
	scripts\cp\_interaction::func_DEBB("iw7_ake_zml","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_arclassic_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_rvn_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	var_00 = 2000;
	town_register_interaction(1,"iw7_knife_zm_cleaver",undefined,undefined,::blankhintfunc,::meleeweaponuse,0,0);
	town_register_interaction(1,"iw7_knife_zm_crowbar",undefined,undefined,::blankhintfunc,::meleeweaponuse,0,0);
}

//Function Number: 13
town_wait_for_interaction_triggered(param_00)
{
	self notify("interaction_logic_started");
	self endon("interaction_logic_started");
	self endon("stop_interaction_logic");
	self endon("disconnect");
	for(;;)
	{
		self.var_9A3F waittill("trigger",var_01);
		if(var_01 method_84D9())
		{
			continue;
		}

		while(var_01 ismeleeing() || var_01 meleebuttonpressed())
		{
			wait(0.05);
		}

		if(!scripts\cp\_interaction::func_9A27(param_00,var_01))
		{
			wait(0.1);
			continue;
		}

		param_00.var_127BA = 1;
		param_00 thread scripts\cp\_interaction::func_50FA();
		var_02 = level.interactions[param_00.script_noteworthy].cost;
		if(!isdefined(level.interactions[param_00.script_noteworthy].var_109DA))
		{
			level.interactions[param_00.script_noteworthy].var_109DA = "null";
		}

		if(isdefined(level.interactions[param_00.script_noteworthy].var_3865))
		{
			if(![[ level.interactions[param_00.script_noteworthy].var_3865 ]](param_00,var_01))
			{
				wait(0.1);
				continue;
			}
		}
		else if(param_00.script_noteworthy == "lost_and_found")
		{
			if(!scripts\common\utility::istrue(self.var_8C46))
			{
				wait(0.1);
				continue;
			}

			if(isdefined(self.var_B0A2) && self.var_B0A2 != param_00)
			{
				wait(0.1);
				continue;
			}

			if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
			{
				var_02 = 0;
			}
		}
		else if(scripts\cp\_interaction::func_9A29(param_00))
		{
			if(scripts\cp\_utility::is_codxp())
			{
				wait(0.1);
				continue;
			}

			var_03 = var_01 getcurrentweapon();
			level.var_D8C6 = var_01 getcurrentweapon();
			var_04 = scripts\cp\_weapon::func_7D62(var_03);
			if(scripts\common\utility::istrue(level.placed_alien_fuses))
			{
				if(var_04 == 3)
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_UPGRADE_MAXED");
					wait(0.1);
					continue;
				}
				else if(func_385F(var_03,1))
				{
					if(var_04 == 1)
					{
						var_02 = 5000;
					}
					else if(var_04 == 2)
					{
						var_02 = 10000;
					}
				}
				else
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"CP_TOWN_UPGRADE_WEAPON_FAIL");
					wait(0.1);
					continue;
				}
			}
			else if(var_04 == level.var_C8A4 && scripts\common\utility::istrue(level.has_picked_up_fuses) && isdefined(level.placed_alien_fuses))
			{
				scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_UPGRADE_MAXED");
				wait(0.1);
				continue;
			}
			else if(func_385F(var_03))
			{
				if(scripts\common\utility::istrue(level.has_picked_up_fuses) && !isdefined(level.placed_alien_fuses))
				{
					var_02 = 0;
				}
				else if(var_04 == 1)
				{
					var_02 = 5000;
				}
				else if(var_04 == 2)
				{
					var_02 = 10000;
				}
			}
			else
			{
				scripts\cp\_interaction::func_9A3C(param_00,&"CP_TOWN_UPGRADE_WEAPON_FAIL");
				wait(0.1);
				continue;
			}
		}
		else if(scripts\cp\_interaction::func_9A28(param_00))
		{
			if(scripts\cp\_utility::func_9D18())
			{
				wait(0.1);
				continue;
			}

			var_05 = var_01 getcurrentweapon();
			var_06 = scripts\cp\_utility::func_7DF7(var_05);
			if(scripts\cp\_weapon::func_8BBB(param_00.script_noteworthy))
			{
				if(!scripts\cp\_interaction::func_383D(param_00.script_noteworthy))
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_GAME_PLAY_AMMO_MAX");
					wait(0.1);
					continue;
				}
				else
				{
					var_07 = scripts\cp\_utility::func_80D8(param_00.script_noteworthy);
					var_04 = scripts\cp\_weapon::func_7D62(var_07);
					if(var_04 > 1)
					{
						var_02 = 4500;
					}
					else
					{
						var_02 = var_02 * 0.5;
					}
				}
			}
		}
		else if(scripts\cp\_interaction::func_9A1D(param_00))
		{
			if(!var_01 scripts\cp\_interaction::func_3867(param_00))
			{
				var_02 = 0;
			}
			else if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && param_00.var_CA4C == "perk_machine_revive" && var_01.var_F1E7 <= var_01.max_self_revive_machine_use)
			{
				var_02 = 500;
			}
			else
			{
				var_02 = scripts\cp\_interaction::func_7B78(param_00);
			}
		}
		else if(scripts\cp\_interaction::func_9A1A(param_00))
		{
			if(!scripts\common\utility::istrue(level.unlimited_fnf))
			{
				if(var_01.var_3A52 == 2)
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_NO_MORE_CARDS_OWNED");
					wait(0.1);
					continue;
				}
			}

			if(self.var_3A52 >= 1)
			{
				var_02 = level.var_732D;
			}
			else
			{
				var_02 = level.var_732C;
			}
		}

		if(!scripts\cp\_interaction::func_383E(param_00,var_02,level.interactions[param_00.script_noteworthy].var_109DA))
		{
			level notify("interaction","purchase_denied",level.interactions[param_00.script_noteworthy],self);
			if(param_00.var_EE79 == "tickets")
			{
				scripts\cp\_interaction::func_9A3C(param_00,&"CP_ZMB_INTERACTIONS_NEED_TICKETS");
				thread scripts\cp\_vo::try_to_play_vo("no_tickets","zmb_comment_vo","high",10,0,0,1,50);
			}
			else if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && scripts\cp\_interaction::func_9A1D(param_00) && param_00.var_CA4C == "perk_machine_revive" && var_01.var_F1E7 >= var_01.max_self_revive_machine_use)
			{
				scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_CANNOT_BUY_SELF_REVIVE");
			}
			else
			{
				thread scripts\cp\_vo::try_to_play_vo("no_cash","zmb_comment_vo","high",10,0,0,1,50);
				scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_NEED_MONEY");
			}

			wait(0.1);
			continue;
		}

		if(param_00.script_noteworthy == "atm_withdrawal")
		{
			if(isdefined(level.var_2417))
			{
				if(level.var_2416 < level.var_2417)
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_NEED_MONEY");
					wait(0.1);
					continue;
				}
			}
		}

		thread scripts\cp\_interaction::func_9A33(param_00);
		if(scripts\cp\_interaction::func_9A28(param_00))
		{
			level notify("interaction",param_00.name,undefined,self);
		}
		else
		{
			level notify("interaction","purchase",level.interactions[param_00.script_noteworthy],self);
		}

		var_08 = level.interactions[param_00.script_noteworthy].var_109DA;
		thread scripts\cp\_interaction::func_11449(var_02,var_08);
		level thread [[ level.interactions[param_00.script_noteworthy].var_161A ]](param_00,self);
		if(scripts\cp\_interaction::func_9A21(param_00))
		{
			level thread scripts\cp\_interaction::func_1048D(param_00.script_noteworthy,self);
		}

		scripts\cp\_interaction::func_9A34(param_00);
		wait(0.1);
		param_00.var_127BA = undefined;
	}
}

//Function Number: 14
func_385F(param_00,param_01)
{
	if(!isdefined(level.var_C8A2))
	{
		return 0;
	}

	if(isdefined(param_00))
	{
		var_02 = scripts\cp\_utility::func_80D8(param_00);
	}
	else
	{
		return 0;
	}

	if(!isdefined(var_02))
	{
		return 0;
	}

	if(!isdefined(level.var_C8A2[var_02]))
	{
		var_03 = getsubstr(var_02,0,var_02.size - 1);
		if(!isdefined(level.var_C8A2[var_03]))
		{
			return 0;
		}
	}

	if(isdefined(self.var_6670) && getweaponbasename(self.var_6670) == getweaponbasename(param_00))
	{
		return 0;
	}

	if(isdefined(level.weapon_upgrade_path) && isdefined(level.weapon_upgrade_path[getweaponbasename(param_00)]))
	{
		return 1;
	}

	if(var_02 == "dischord" || var_02 == "facemelter" || var_02 == "headcutter" || var_02 == "shredder")
	{
		if(!scripts\common\utility::flag("fuses_inserted"))
		{
			if(scripts\common\utility::istrue(param_01))
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		else if(isdefined(self.var_C8A2[var_02]) && self.var_C8A2[var_02].var_B111 == 2)
		{
			return 0;
		}
	}

	if(scripts\common\utility::istrue(level.has_picked_up_fuses) && !isdefined(level.placed_alien_fuses))
	{
		return 1;
	}

	if(scripts\common\utility::istrue(self.has_zis_soul_key) || scripts\common\utility::istrue(level.placed_alien_fuses))
	{
		if(isdefined(self.var_C8A2[var_02]) && self.var_C8A2[var_02].var_B111 >= 3)
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}

	if(scripts\common\utility::istrue(param_01) && isdefined(self.var_C8A2[var_02]) && self.var_C8A2[var_02].var_B111 <= min(level.var_C8A4 + 1,2))
	{
		return 1;
	}

	if(isdefined(self.var_C8A2[var_02]) && self.var_C8A2[var_02].var_B111 >= level.var_C8A4)
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
town_player_interaction_monitor()
{
	self notify("player_interaction_monitor");
	self endon("player_interaction_monitor");
	self endon("disconnect");
	self endon("death");
	var_00 = 5184;
	var_01 = 9216;
	var_02 = 2304;
	for(;;)
	{
		if(isdefined(level.var_9A45))
		{
			wait(1);
			continue;
		}

		var_04 = undefined;
		level.current_interaction_structs = scripts\common\utility::func_22BC(level.current_interaction_structs);
		var_05 = sortbydistance(level.current_interaction_structs,self.origin);
		foreach(var_07 in self.var_55BB)
		{
			var_05 = scripts\common\utility::func_22A9(var_05,var_07);
		}

		if(var_05.size == 0)
		{
			wait(0.1);
			continue;
		}

		if(scripts\common\utility::istrue(self.var_50BC))
		{
			wait(0.1);
			continue;
		}

		if(scripts\cp\_interaction::func_9A2B(var_05[0]) && distancesquared(var_05[0].origin,self.origin) < var_02)
		{
			var_04 = var_05[0];
		}

		if(!isdefined(var_04) && !scripts\cp\_interaction::func_9A2B(var_05[0]) && distancesquared(var_05[0].origin,self.origin) <= var_00)
		{
			var_04 = var_05[0];
		}

		if(isdefined(var_04) && scripts\cp\_interaction::func_9A18(var_04) || scripts\cp\_interaction::interaction_is_chi_door(var_04) && !scripts\cp\_interaction::func_9A22(var_04))
		{
			var_04 = undefined;
		}

		if(!isdefined(var_04) && isdefined(level.should_allow_far_search_dist_func))
		{
			if(distancesquared(var_05[0].origin,self.origin) <= var_01)
			{
				var_04 = var_05[0];
			}

			if(isdefined(var_04) && ![[ level.should_allow_far_search_dist_func ]](var_04))
			{
				var_04 = undefined;
			}
		}
		else if(!isdefined(var_04) && isdefined(var_05[0].var_4C72))
		{
			if(distance(var_05[0].origin,self.origin) <= var_05[0].var_4C72)
			{
				var_04 = var_05[0];
			}
		}

		if(!isdefined(var_04) || !scripts\common\utility::func_2286(level.current_interaction_structs,var_04))
		{
			scripts\cp\_interaction::func_E1F6();
			continue;
		}

		if(!scripts\cp\_interaction::func_3863(var_04))
		{
			scripts\cp\_interaction::func_E1F6();
			continue;
		}

		if(scripts\cp\_interaction::func_9A2B(var_04))
		{
			var_09 = scripts\cp\_utility::func_78B4(var_04.origin);
			if(!isdefined(var_09))
			{
				self.var_A8D3 = undefined;
				wait(0.05);
				continue;
			}

			if(scripts\cp\_utility::func_664F(var_09))
			{
				scripts\cp\_interaction::func_E1F6();
				if(isdefined(self.var_4B5C) && self.var_4B5C.var_195 == "crafted_windowtrap")
				{
					if(!isdefined(var_04.var_8BB7))
					{
						thread scripts\cp\_interaction::func_6EB9();
					}
				}

				self.var_A8D3 = var_04;
				continue;
			}
			else
			{
				self notify("stop_interaction_logic");
				self.var_A8D3 = undefined;
			}

			if(isdefined(self.var_4B5C) && self.var_4B5C.var_195 == "crafted_windowtrap")
			{
				if(!isdefined(var_04.var_8BB7))
				{
					thread scripts\cp\_interaction::func_6EB9();
				}
			}
		}

		if(scripts\cp\_interaction::func_9A1D(var_04) && self getstance() == "prone")
		{
			self.var_A8D3 = undefined;
			wait(0.05);
			continue;
		}

		if(!isdefined(self.var_A8D3))
		{
			scripts\cp\_interaction::func_F421(var_04);
		}
		else if(self.var_A8D3 == var_04 && scripts\cp\_interaction::func_9A28(var_04) && !scripts\common\utility::istrue(self.var_50BC))
		{
			scripts\cp\_interaction::func_F421(var_04,0);
		}
		else if(self.var_A8D3 != var_04)
		{
			scripts\cp\_interaction::func_F421(var_04);
		}

		wait(0.05);
	}
}

//Function Number: 16
setup_atm_system()
{
	level.var_2416 = 0;
}

//Function Number: 17
atm_deposit(param_00,param_01)
{
	param_01 notify("stop_interaction_logic");
	param_01.var_A8D3 = undefined;
	level.var_2416 = level.var_2416 + 1000;
	scripts\cp\_interaction::increase_total_deposit_amount(param_01,1000);
	param_01 thread scripts\cp\_vo::try_to_play_vo("atm_deposit","zmb_comment_vo","low");
	scripts\cp\zombies\zombie_analytics::func_AF5D(1,level.wave_num,param_01);
	param_01 scripts\cp\_interaction::func_DE6E();
	if(scripts\cp\_interaction::exceed_deposit_limit(param_01))
	{
		scripts\cp\_interaction::func_E01A(param_00,param_01);
	}
}

//Function Number: 18
atm_withdrawal(param_00,param_01)
{
	if(level.var_2416 < 1000)
	{
		return;
	}

	var_02 = 1000;
	param_01 scripts\cp\_persistence::func_82F9(var_02,undefined,undefined,undefined,"atm");
	level.var_2416 = level.var_2416 - var_02;
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\zombies\zombie_analytics::func_AF5D(1,level.wave_num,param_01);
	param_01 thread scripts\cp\_vo::try_to_play_vo("withdraw_cash","zmb_comment_vo","low");
	param_01 scripts\cp\_interaction::func_DE6E();
}

//Function Number: 19
atm_withdrawal_hint(param_00,param_01)
{
	if(param_00.var_E1B9 && !param_00.var_D776)
	{
		return &"COOP_INTERACTIONS_REQUIRES_POWER";
	}

	if(isdefined(level.var_2416) && level.var_2416 < 1000)
	{
		return &"CP_TOWN_INTERACTIONS_ATM_INSUFFICIENT_FUNDS";
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 20
register_crab_boss_interactions()
{
	level.interaction_hintstrings["bomb_start"] = &"CP_TOWN_INTERACTIONS_BOMB_CODE";
	level.interaction_hintstrings["push_bomb"] = &"CP_TOWN_INTERACTIONS_PUSH_BOMB";
	town_register_interaction(1,"bomb_start",undefined,undefined,undefined,::scripts\cp\maps\cp_town\cp_town_crab_boss_bomb::enter_bomb_code,0,0,::scripts\cp\maps\cp_town\cp_town_crab_boss_bomb::init_bomb_interaction);
	town_register_interaction(1,"push_bomb",undefined,undefined,undefined,::scripts\cp\maps\cp_town\cp_town_crab_boss_escort::push_bomb,0,0,::scripts\cp\maps\cp_town\cp_town_crab_boss_escort::init_escort_sequence);
	town_register_interaction(1,"death_ray_cannon",undefined,undefined,::scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::death_ray_hint_func,::blankusefunc,0,0);
	scripts\cp\_interaction::func_DEBB("vehicle_teleporter",undefined,undefined,::scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall::vehicle_teleporter_hint_func,::blankusefunc,0,0);
}

//Function Number: 21
blankhintfunc(param_00,param_01)
{
	return "";
}

//Function Number: 22
cutieammohintfunc(param_00,param_01)
{
	var_02 = param_01 getcurrentweapon();
	if(issubstr(var_02,"cutieplunger"))
	{
		if(param_01 getweaponammoclip(var_02) < weaponclipsize(var_02))
		{
			return &"CP_TOWN_CUTIE_AMMO";
		}

		return &"COOP_GAME_PLAY_AMMO_MAX";
	}

	return "";
}

//Function Number: 23
blankusefunc(param_00,param_01)
{
}

//Function Number: 24
meleeweaponuse(param_00,param_01)
{
	if(isdefined(param_01.var_4BF5) && param_01.var_4BF5 == param_00.script_noteworthy)
	{
		return;
	}

	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	if(isdefined(param_01.var_4BF5))
	{
		param_01 takeweapon(param_01.var_4BF5);
	}

	param_01 takeweapon("iw7_knife_zm_crowbar");
	param_01 takeweapon("iw7_knife_zm_cleaver");
	if(issubstr(param_00.script_noteworthy,"cleaver"))
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_2_collect_cleaver","town_comment_vo");
	}

	var_02 = param_00.script_noteworthy;
	param_01 giveweapon(var_02);
	param_01.var_501B = var_02;
	param_01.var_4BF5 = var_02;
	param_01.melee_weapon = var_02;
	playfx(level._effect["generic_pickup"],param_00.model.origin);
	param_01 playlocalsound("zmb_item_pickup");
	param_00.model method_8429(param_01);
	if(param_00.script_noteworthy == "iw7_knife_zm_cleaver")
	{
		var_03 = scripts\common\utility::getstruct("iw7_knife_zm_crowbar","script_noteworthy");
		var_03.model showtoplayer(param_01);
		return;
	}

	var_04 = scripts\common\utility::getstruct("iw7_knife_zm_cleaver","script_noteworthy");
	var_04.model showtoplayer(param_01);
}

//Function Number: 25
init_papfusebox()
{
	level endon("game_ended");
	scripts\common\utility::flag_init("picked_up_uncharged_fuses");
	scripts\common\utility::flag_init("picked_up_charged_fuses");
	scripts\common\utility::flag_init("fuses_charged");
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = getentarray("pap_upgrade_door","targetname");
	var_01 = scripts\common\utility::getstructarray("pap_fusebox","script_noteworthy");
	var_02 = getent("pap_upgrade_door_handle","targetname");
	var_02 notsolid();
	foreach(var_04 in var_01)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_04);
	}

	foreach(var_07 in var_00)
	{
		var_08 = scripts\common\utility::getclosest(var_07.origin,var_01);
		thread watchforcrowbardamage(var_07,var_08);
	}

	func_1298D();
}

//Function Number: 26
func_1298D()
{
	var_00 = (-10353.5,582.5,-1573);
	var_01 = anglestoforward((0,45,0));
	var_02 = spawnfx(level._effect["vfx_pap_return_portal"],var_00,var_01);
	thread scripts\common\utility::play_loopsound_in_space("zmb_portal_powered_on_activate_lp",var_00);
	triggerfx(var_02);
	level thread pap_exit_teleporter();
}

//Function Number: 27
pap_exit_teleporter()
{
	var_00 = spawn("script_origin",(-10353.5,582.5,-1573));
	var_00 makeusable();
	var_00 sethintstring(&"CP_TOWN_INTERACTIONS_HIDDEN_LEAVE");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(!isdefined(var_01.kicked_out))
		{
			var_01 notify("left_hidden_room_early");
			func_8E60(var_01);
		}

		wait(0.1);
	}
}

//Function Number: 28
watchforcrowbardamage(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_00 setcandamage(1);
	param_00 setcanradiusdamage(1);
	param_00.maxhealth = 9999999;
	param_00.health = 9999999;
	for(;;)
	{
		param_00 waittill("damage",var_04,var_05,var_06,var_06,var_06,var_06,var_06,var_06,var_06,var_07);
		if(isdefined(var_07) && issubstr(var_07,"crowbar"))
		{
			break;
		}

		param_00.maxhealth = 9999999;
		param_00.health = 9999999;
	}

	param_00.health = 0;
	param_00.maxhealth = 0;
	if(isdefined(param_01))
	{
		scripts\cp\_interaction::add_to_current_interaction_list(param_01);
	}

	if(!scripts\common\utility::istrue(param_02))
	{
		playfx(level._effect["fuse_door_break"],param_00.origin);
		playsoundatpos(param_00.origin,"zmb_wood_barrier_destroy");
	}
	else
	{
		param_00 playsound("town_pap_fuse_box_crowbar_open");
	}

	param_00 setcandamage(0);
	if(isdefined(param_03))
	{
		param_00 rotateto(param_00.angles + param_03,0.2);
		return;
	}

	param_00 hide();
	var_08 = getent("pap_upgrade_door_handle","targetname");
	var_08 hide();
}

//Function Number: 29
init_papanomaly()
{
	level.secretpapstructs = [];
	scripts\common\utility::flag_init("pap_portal_used");
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = scripts\common\utility::getstructarray("fast_travel_panel","script_noteworthy");
	level thread pap_anomaly_logic();
	foreach(var_02 in var_00)
	{
		var_03 = spawn("script_model",var_02.origin + (0,0,40));
		if(isdefined(var_02.angles))
		{
			var_03.angles = var_02.angles;
		}

		var_03 setmodel("tag_origin_portal");
		var_02.model = var_03;
		var_02.hidden = 1;
		scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
		var_02 thread activateonpoweron(var_02);
	}
}

//Function Number: 30
pap_anomaly_logic()
{
	while(!scripts\common\utility::istrue(level.anomaly_revealed))
	{
		wait(1);
	}

	for(;;)
	{
		foreach(var_01 in level.secretpapstructs)
		{
			if(level.active_pap_teleporter == var_01)
			{
				var_01.model setscriptablepartstate("portal","on");
				scripts\cp\_interaction::add_to_current_interaction_list(var_01);
				continue;
			}

			var_01.model setscriptablepartstate("portal","off");
			var_01.revealed = 1;
			var_01.teleporter_active = 0;
			scripts\cp\_interaction::remove_from_current_interaction_list(var_01);
		}

		scripts\common\utility::flag_wait("pap_portal_used");
		wait(15);
		level.active_pap_teleporter.model setscriptablepartstate("portal","off");
		level.active_pap_teleporter.teleporter_active = 0;
		scripts\cp\_interaction::remove_from_current_interaction_list(level.active_pap_teleporter);
		wait(60);
		scripts\common\utility::func_6E2A("pap_portal_used");
		var_03 = scripts\common\utility::array_randomize(level.secretpapstructs);
		foreach(var_05 in var_03)
		{
			if(var_05 == level.active_pap_teleporter)
			{
				continue;
			}

			level.active_pap_teleporter = var_05;
			level.active_pap_teleporter.teleporter_active = 1;
			break;
		}
	}
}

//Function Number: 31
activateonpoweron(param_00)
{
	level endon("game_ended");
	level waittill("activate_power");
	level.secretpapstructs[level.secretpapstructs.size] = param_00;
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	param_00.model setscriptablepartstate("portal","anomaly");
	param_00.hidden = undefined;
}

//Function Number: 32
generator_field_hint(param_00,param_01)
{
	if(scripts\common\utility::flag("fuses_charged"))
	{
		return &"CP_TOWN_INTERACTIONS_PICKUP_CHARGED_FUSES";
	}

	return "";
}

//Function Number: 33
generator_field_vibrate()
{
	var_00 = scripts\common\utility::getstruct("generator_field_center","script_noteworthy");
	for(;;)
	{
		if(!scripts\common\utility::flag("vial_filled"))
		{
			wait(0.05);
			continue;
		}

		var_01 = scripts\common\utility::func_782F(var_00.origin,level.players,undefined,4,96);
		foreach(var_03 in var_01)
		{
			var_03 setclientomnvar("ui_hud_shake",1);
			var_03 playrumbleonentity("artillery_rumble");
		}

		wait(randomfloatrange(0.5,2));
	}
}

//Function Number: 34
usegeneratorfieldcenter(param_00,param_01)
{
	if(!scripts\common\utility::flag("picked_up_charged_fuses") && scripts\common\utility::flag("fuses_charged"))
	{
		scripts\common\utility::flag_set("picked_up_charged_fuses");
		var_02 = getentarray("pap_fuses","targetname");
		playfx(level._effect["generic_pickup"],var_02[0].origin);
		foreach(var_04 in var_02)
		{
			var_04 delete();
		}

		param_01 playlocalsound("zmb_item_pickup");
		level.upgraded_fuses_pickedup = 1;
		level.has_picked_up_fuses = 1;
		param_01 thread scripts\cp\_vo::try_to_play_vo("pap_collect_fuse","town_comment_vo","low",10,0,0,1,100);
		foreach(var_07 in level.players)
		{
			var_07 setclientomnvar("zm_special_item",1);
		}

		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		return;
	}

	if(scripts\common\utility::flag("picked_up_uncharged_fuses") && scripts\common\utility::flag("vial_filled"))
	{
		foreach(var_07 in level.players)
		{
			var_07 setclientomnvar("zm_special_item",5);
		}

		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		scripts\common\utility::func_6E2A("picked_up_uncharged_fuses");
		var_0B = scripts\common\utility::getstructarray(param_00.target,"targetname");
		var_02 = getentarray("pap_fuses","targetname");
		foreach(var_0E, var_0D in var_0B)
		{
			var_04 = var_02[var_0E];
			var_04 dontinterpolate();
			var_04.origin = var_0D.origin;
			if(isdefined(var_0D.angles))
			{
				var_04.angles = var_0D.angles;
			}

			var_04 show();
		}

		var_02[0] playsound("town_pap_green_goo_start");
		foreach(var_07 in level.players)
		{
			var_07 setclientomnvar("zm_special_item",0);
		}

		level.generator_blood = spawnfx(level._effect["vfx_crog_blood"],param_00.origin + (0,0,-2));
		scripts\common\utility::func_6E2A("vial_filled");
		setomnvar("zom_general_fill_percent_2",0);
		thread chargefuses(var_02,param_00);
		wait(0.5);
		triggerfx(level.generator_blood);
		var_02[0] playloopsound("town_pap_green_goo_lp");
	}
}

//Function Number: 35
chargefuses(param_00,param_01)
{
	level endon("game_ended");
	level waittill("use_electric_trap");
	wait(2);
	var_02 = scripts\common\utility::getstructarray("electric_trap_spots","targetname");
	var_03 = scripts\common\utility::getclosest(param_01.origin,var_02);
	var_04 = var_03.origin + (0,0,randomintrange(100,170));
	var_05 = param_01.origin;
	function_02E0(level._effect["electric_trap_attack"],var_04,vectortoangles(var_05 - var_04),var_05);
	playsoundatpos(var_04,"town_pap_electric_bolt");
	wait(2);
	function_02E0(level._effect["electric_trap_attack"],var_04,vectortoangles(var_05 - var_04),var_05);
	playsoundatpos(var_04,"town_pap_electric_bolt");
	wait(0.05);
	playfx(level._effect["vfx_bomb_portal_in"],param_01.origin);
	wait(0.05);
	foreach(var_07 in param_00)
	{
		var_07 setmodel("park_alien_gray_fuse");
		wait(0.1);
		playfxontag(level._effect["fuse_charged"],var_07,"tag_origin");
	}

	scripts\common\utility::flag_set("fuses_charged");
	scripts\cp\_interaction::add_to_current_interaction_list(param_01);
	level.generator_blood delete();
	param_00[0] stoploopsound("town_pap_green_goo_lp");
}

//Function Number: 36
pickupfuse(param_00,param_01)
{
	var_02 = getentarray("pap_fuses","targetname");
	var_03 = scripts\common\utility::func_782F(param_00.origin,var_02,undefined,2);
	scripts\common\utility::flag_set("picked_up_uncharged_fuses");
	param_01 playlocalsound("part_pickup");
	playfx(level._effect["generic_pickup"],var_03[0].origin);
	foreach(var_05 in level.players)
	{
		var_05 setclientomnvar("zm_special_item",5);
	}

	foreach(var_08 in var_03)
	{
		var_08 hide();
	}

	param_00 scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	level thread generator_field_vibrate();
}

//Function Number: 37
papearlyexituse(param_00,param_01)
{
	if(scripts\common\utility::istrue(level.pap_upgrade_fuses_available))
	{
		level thread func_8E60(param_01);
	}
}

//Function Number: 38
papfuseswitchhint(param_00,param_01)
{
	return "";
}

//Function Number: 39
usepapfuseswitch(param_00,param_01)
{
	level endon("fuses_pickedup");
	var_02 = getent(param_00.target,"targetname");
	var_02 setmodel("mp_frag_button_on_green");
	playsoundatpos(var_02.origin,"town_pap_room_button_press");
	level.pap_upgrade_fuses_available = 1;
	wait(0.5);
	playfx(level._effect["vfx_pap_upgrade_symb"],(-10245,750,-1629.4));
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	wait(5);
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	level.pap_upgrade_fuses_available = undefined;
	var_02 setmodel("mp_frag_button_on");
}

//Function Number: 40
usepapanomaly(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.isrewinding))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.playing_game))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_00.hidden))
	{
		return;
	}

	if(!scripts\common\utility::istrue(param_00.revealed))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_00.teleporter_active))
	{
		thread teleporttopaproom(param_01,param_00);
		if(!scripts\common\utility::flag("pap_portal_used"))
		{
			scripts\common\utility::flag_set("pap_portal_used");
		}
	}
}

//Function Number: 41
teleporttopaproom(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 endon("left_hidden_room_early");
	var_02 = scripts\common\utility::getstructarray("pap_spawners","targetname");
	param_00.pap_interaction = param_01;
	wait(0.1);
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(param_00,var_02);
	param_00 method_8447();
	param_00.var_9C54 = 1;
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00 set_in_pap_room(param_00,1);
	param_00.disable_consumables = undefined;
	param_00 thread func_8E64(param_00);
	level notify("hidden_room_portal_used");
}

//Function Number: 42
set_in_pap_room(param_00,param_01)
{
	param_00.is_in_pap = param_01;
}

//Function Number: 43
func_8E64(param_00)
{
	param_00 endon("left_hidden_room_early");
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	param_00.kicked_out = undefined;
	param_00 thread func_C8A9();
	level thread pap_vo(self);
	param_00 waittill("kicked_out");
	param_00.kicked_out = 1;
	level thread func_8E60(param_00);
}

//Function Number: 44
func_C8A9()
{
	self endon("disconnect");
	if(!isdefined(self.var_C8A8))
	{
		thread runpaptimer(self);
		scripts\common\utility::waittill_any_timeout_1(30,"left_hidden_room_early");
		self setclientomnvar("zombie_papTimer",-1);
		self notify("kicked_out");
		self.var_C8A8 = undefined;
	}
}

//Function Number: 45
runpaptimer(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("left_hidden_room_early");
	param_00.var_C8A8 = 1;
	var_01 = 30;
	param_00 setclientomnvar("zombie_papTimer",var_01);
	wait(1);
	for(;;)
	{
		var_01--;
		if(var_01 < 0)
		{
			var_01 = 30;
			wait(1);
			break;
		}

		param_00 setclientomnvar("zombie_papTimer",var_01);
		wait(1);
	}
}

//Function Number: 46
pap_vo(param_00)
{
	param_00 endon("disconnect");
	level.var_C8A3 = 1;
	wait(4);
	param_00 thread scripts\cp\_vo::try_to_play_vo("ww_pap_nag","rave_pap_vo","high",undefined,undefined,undefined,1);
}

//Function Number: 47
func_8E60(param_00)
{
	param_00 endon("disconnect");
	param_00 method_80F3();
	param_00 notify("delete_equipment");
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	if(scripts\common\utility::istrue(level.pap_upgrade_fuses_available))
	{
		var_01 = get_valid_pap_upgrade_spot();
		thread completeteleporttopos(param_00,var_01,::delaysendingplayerback);
		return;
	}

	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	var_02 = get_valid_pap_return_spot(param_00.pap_interaction,1);
	scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(param_00,var_02);
	param_00 scripts\cp\_interaction::func_DE6E();
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00 method_80F3();
	param_00 notify("left_hidden_room_early");
	param_00 scripts\cp\_utility::func_E0E6("papRoom",0);
	param_00.disable_consumables = undefined;
	param_00.var_9C54 = undefined;
	param_00.kicked_out = undefined;
	param_00.pap_interaction = undefined;
	param_00 set_in_pap_room(param_00,0);
	param_00 notify("fast_travel_complete");
	scripts\cp\_vo::func_E01F("ww_pap_nag");
	scripts\cp\_vo::func_E01F("nag_find_pap");
}

//Function Number: 48
get_valid_pap_return_spot(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = scripts\common\utility::getstructarray("pap_return_spots","targetname")[0];
	}

	var_02 = scripts\common\utility::func_782F(param_00.origin,scripts\common\utility::getstructarray("pap_return_spots","targetname"),undefined,4);
	if(scripts\common\utility::istrue(param_01))
	{
		return var_02;
	}

	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	while(!isdefined(var_03))
	{
		foreach(var_07 in var_02)
		{
			var_08 = var_07.origin;
			if(!positionwouldtelefrag(var_08))
			{
				var_03 = var_08;
				var_04 = var_07.angles;
				return var_07;
			}
		}

		wait(0.1);
	}
}

//Function Number: 49
get_valid_pap_upgrade_spot()
{
	var_00 = scripts\common\utility::getstructarray("pap_upgrade_player","script_noteworthy");
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	while(!isdefined(var_01))
	{
		foreach(var_05 in var_00)
		{
			var_06 = var_05.origin;
			if(!positionwouldtelefrag(var_06))
			{
				var_01 = var_06;
				var_02 = var_05.angles;
				return var_05;
			}
		}

		wait(0.1);
	}
}

//Function Number: 50
delaysendingplayerback(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("death");
	param_00 endon("last_stand");
	param_00 thread scripts\common\utility::func_CD7F("quest_rewind_clock_tick_long");
	wait(7);
	param_00 thread scripts\common\utility::func_11018("quest_rewind_clock_tick_long");
	param_00 playsoundtoplayer("mpq_fail_buzzer",param_00);
	var_01 = get_valid_pap_return_spot(param_00.pap_interaction);
	thread completeteleporttopos(param_00,var_01);
}

//Function Number: 51
completeteleporttopos(param_00,param_01,param_02)
{
	param_00 notify("completeTeleportToPos");
	param_00 endon("completeTeleportToPos");
	param_00 endon("disconnect");
	param_00 scripts\cp\_interaction::func_DE6E();
	param_00 scripts\cp\powers\coop_powers::func_D72E();
	param_00 method_80F3();
	param_00 setorigin(param_01.origin);
	if(isdefined(param_01.angles))
	{
		param_00 setplayerangles(param_01.angles);
	}
	else
	{
		param_00 setplayerangles((0,0,0));
	}

	param_00 notify("left_hidden_room_early");
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
	wait(0.1);
	param_00 scripts\cp\_utility::func_E0E6("papRoom",0);
	if(isdefined(param_02))
	{
		[[ param_02 ]](param_00);
	}

	param_00.disable_consumables = undefined;
	param_00.var_9C54 = undefined;
	param_00.kicked_out = undefined;
	param_00.pap_interaction = undefined;
	param_00 set_in_pap_room(param_00,0);
	param_00 notify("fast_travel_complete");
	scripts\cp\_vo::func_E01F("ww_pap_nag");
	scripts\cp\_vo::func_E01F("nag_find_pap");
}

//Function Number: 52
papearlyexithint(param_00,param_01)
{
	return "";
}

//Function Number: 53
papanomalyhint(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_00.teleporter_active))
	{
		return &"CP_TOWN_INTERACTIONS_HIDDEN_TELEPORT";
	}

	if(scripts\common\utility::istrue(param_00.var_4622))
	{
		return &"COOP_INTERACTIONS_COOLDOWN";
	}

	return "";
}

//Function Number: 54
tcspieceinit()
{
	scripts\common\utility::flag_init("found_tcs_piece");
	scripts\common\utility::flag_init("tcs_piece_placed");
	scripts\common\utility::flag_init("main_power_on");
	var_00 = scripts\common\utility::getstructarray("tcs_piece","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.target))
		{
			var_03 = scripts\common\utility::getstruct(var_02.target,"targetname");
		}
		else
		{
			var_03 = var_02;
		}

		var_04 = spawn("script_model",var_03.origin);
		if(isdefined(var_03.angles))
		{
			var_04.angles = var_03.angles;
		}

		var_04 setmodel("cp_disco_film_reel_case");
		var_02.model = var_04;
	}
}

//Function Number: 55
usetcspiece(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	scripts\common\utility::flag_set("found_tcs_piece");
	param_01 playlocalsound("part_pickup");
	param_00.model delete();
}

//Function Number: 56
cutie_hint_func(param_00,param_01)
{
	if(!param_01 scripts\cp\_weapon::func_8BBB("iw7_cutie_zm") || !param_01 scripts\cp\_weapon::func_8BBB("iw7_cutier_zm"))
	{
		return "";
	}
	else
	{
		var_02 = param_01 getweaponslistall();
		var_03 = undefined;
		var_04 = undefined;
		foreach(var_06 in var_02)
		{
			if(issubstr(var_06,"iw7_cutie_zm") || issubstr(var_06,"iw7_cutier_zm"))
			{
				var_03 = var_06;
				break;
			}
		}

		if(isdefined(var_03))
		{
			var_08 = function_00E3(var_03);
			var_09 = [];
			var_0A = getcutieattachmentname(param_00);
			if(var_08.size > 0)
			{
				foreach(var_0C in var_08)
				{
					if(var_0C == var_0A)
					{
						return "";
					}
				}
			}
		}
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 57
addcutieattachment(param_00,param_01)
{
	if(param_01 scripts\cp\_weapon::func_8BBB("iw7_cutie_zm") || param_01 scripts\cp\_weapon::func_8BBB("iw7_cutier_zm"))
	{
		var_02 = param_01 getweaponslistall();
		var_03 = undefined;
		var_04 = undefined;
		foreach(var_06 in var_02)
		{
			if(issubstr(var_06,"iw7_cutie_zm"))
			{
				var_03 = var_06;
				break;
			}
		}

		if(isdefined(var_03))
		{
			var_08 = function_00E3(var_03);
			var_09 = [];
			var_0A = getcutieattachmentname(param_00);
			if(var_08.size > 0)
			{
				foreach(var_0C in var_08)
				{
					if(var_0C == var_0A)
					{
						return;
					}
				}

				var_04 = createcutieweaponstring(param_01,var_08,var_0A);
			}
			else
			{
				var_04 = createcutieweaponstring(param_01,var_08,var_0A);
			}

			if(var_0A == "cutiecrank")
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("weapon_pap_ww1_1","rave_comment_vo","low",10,0,2,1,40);
			}
			else if(var_0A == "cutiegrip")
			{
				param_01 thread scripts\cp\_vo::try_to_play_vo("weapon_pap_ww1_2","rave_comment_vo","low",10,0,2,1,40);
			}

			if(isdefined(var_04))
			{
				param_01 takeweapon(var_03);
				param_01 scripts\cp\_utility::func_12C6(var_04,-1,undefined,0);
				param_01 switchtoweapon(var_04);
			}

			if(var_04 == "iw7_cutie_zm+cutiecrank+cutiegrip+cutieplunger")
			{
				param_01 lib_0D2A::func_12D7C("MAD_PROTO",1);
				return;
			}

			return;
		}

		return;
	}

	var_04 scripts\cp\_interaction::func_9A3C(var_03,&"COOP_PILLAGE_CANT_USE");
}

//Function Number: 58
createcutieweaponstring(param_00,param_01,param_02)
{
	var_03 = "iw7_cutie_zm";
	if(param_01.size > 0)
	{
		param_01 = scripts\common\utility::array_add(param_01,param_02);
		param_01 = scripts\common\utility::func_1D3A(param_01);
		foreach(var_05 in param_01)
		{
			var_03 = var_03 + "+" + var_05;
		}
	}
	else
	{
		var_03 = var_03 + "+" + param_02;
	}

	return var_03;
}

//Function Number: 59
getcutieattachmentname(param_00)
{
	switch(param_00.script_noteworthy)
	{
		case "crank":
			return "cutiecrank";

		case "front_barrel":
			return "cutiegrip";

		case "plunger":
			return "cutieplunger";
	}
}

//Function Number: 60
usecutiepickup(param_00,param_01)
{
	if(!param_01 scripts\cp\_weapon::func_8BBB("iw7_cutie_zm"))
	{
		param_01 thread lib_0D2C::givevalidweapon(param_01,"iw7_cutie_zm");
	}
}

//Function Number: 61
useplungerammo(param_00,param_01)
{
	var_02 = param_01 scripts\cp\_utility::getvalidtakeweapon();
	if(param_01 getweaponammoclip(var_02) == weaponclipsize(var_02))
	{
		return;
	}

	if(issubstr(var_02,"iw7_cutie_zm") || issubstr(var_02,"iw7_cutier_zm"))
	{
		if(scripts\cp\_utility::func_13C90(var_02,"plunger"))
		{
			param_01 thread runcutieplungergesture(param_01,var_02,param_00);
		}
	}
}

//Function Number: 62
init_tcs()
{
	var_00 = scripts\common\utility::getstruct("technicolor_machine","script_noteworthy");
	level scripts\common\utility::waittill_any_3("power_on",var_00.var_D71C + " power_on");
	var_00.var_D776 = 1;
}

//Function Number: 63
tcs_hint(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_00.var_D776))
	{
		return &"COOP_INTERACTIONS_REQUIRES_POWER";
	}

	var_02 = ["color","red","green","blue"];
	if(!isdefined(param_00.var_10E19))
	{
		param_00.var_10E19 = 0;
	}

	var_03 = param_00.var_10E19 + 1;
	if(var_03 > 3)
	{
		var_03 = 0;
	}

	var_04 = var_02[var_03];
	switch(var_04)
	{
		case "red":
			return &"CP_TOWN_CINEMA_RED";

		case "green":
			return &"CP_TOWN_CINEMA_GREEN";

		case "blue":
			return &"CP_TOWN_CINEMA_BLUE";

		case "color":
			return &"CP_TOWN_CINEMA_COLOR";
	}
}

//Function Number: 64
usetcs(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_00.var_D776))
	{
		return;
	}

	var_02 = ["color","red","green","blue"];
	if(!isdefined(param_00.var_10E19))
	{
		param_00.var_10E19 = 0;
	}

	param_00.var_10E19++;
	if(param_00.var_10E19 > 3)
	{
		param_00.var_10E19 = 0;
	}

	var_03 = param_00.var_10E19;
	var_04 = var_02[var_03];
	var_05 = undefined;
	switch(var_04)
	{
		case "red":
			var_05 = "cp_town_bw_r";
			break;

		case "green":
			var_05 = "cp_town_bw_g";
			break;

		case "blue":
			var_05 = "cp_town_bw_b";
			break;

		case "color":
			var_05 = "cp_town_color";
			break;
	}

	level.current_vision_set = var_05;
	level.var_13445 = level.current_vision_set;
	level thread play_color_change_vo(param_01);
	applyvisionsettoallplayers(var_05);
}

//Function Number: 65
play_color_change_vo(param_00)
{
	if(randomint(100) > 50)
	{
		level thread scripts\cp\_vo::try_to_play_vo("ww_nag_color_alternate","rave_announcer_vo","highest",70,0,0,1);
		return;
	}

	param_00 thread scripts\cp\_vo::try_to_play_vo("color_alternate","town_comment_vo");
}

//Function Number: 66
runfunctionafterwait(param_00,param_01,param_02)
{
	level endon("game_ended");
	var_03 = 0;
	if(!isdefined(param_00))
	{
		var_04 = 1;
	}
	else
	{
		var_04 = param_01;
	}

	if(isdefined(param_01))
	{
		thread [[ param_01 ]]();
	}

	runwavewait(var_03,var_04);
	if(isdefined(param_02))
	{
		thread [[ param_02 ]]();
	}
}

//Function Number: 67
runwavewait(param_00,param_01)
{
	level endon("game_ended");
	level endon("runWaveWait_early_endon");
	for(;;)
	{
		level waittill("wave_starting");
		param_00++;
		if(param_00 >= param_01)
		{
			break;
		}
	}
}

//Function Number: 68
applyvisionsettoallplayers(param_00)
{
	level.current_vision_set = param_00;
	level.var_13445 = level.current_vision_set;
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

		var_02 visionsetnakedforplayer(param_00,1);
	}

	switch(param_00)
	{
		case "cp_town_bw_r":
			param_00 = "cp_town_bw_r";
			if(level.bomb_compound.color == "red")
			{
				setomnvar("zm_chem_value_choice",level.bomb_compound.choice);
				setomnvar("zm_chem_bvalue_choice",0);
			}
			else
			{
				setomnvar("zm_chem_bvalue_choice",level.bad_choice_index_color_red);
				setomnvar("zm_chem_value_choice",0);
			}
	
			scripts\cp\maps\cp_town\cp_town_chemistry::set_not_equal_constant("red");
			setomnvar("zm_chem_current_color",1);
			break;

		case "cp_town_bw_g":
			param_00 = "cp_town_bw_g";
			if(level.bomb_compound.color == "green")
			{
				setomnvar("zm_chem_value_choice",level.bomb_compound.choice);
				setomnvar("zm_chem_bvalue_choice",0);
			}
			else
			{
				setomnvar("zm_chem_bvalue_choice",level.bad_choice_index_color_green);
				setomnvar("zm_chem_value_choice",0);
			}
	
			scripts\cp\maps\cp_town\cp_town_chemistry::set_not_equal_constant("green");
			setomnvar("zm_chem_current_color",2);
			break;

		case "cp_town_bw_b":
			param_00 = "cp_town_bw_b";
			if(level.bomb_compound.color == "blue")
			{
				setomnvar("zm_chem_value_choice",level.bomb_compound.choice);
				setomnvar("zm_chem_bvalue_choice",0);
			}
			else
			{
				setomnvar("zm_chem_bvalue_choice",level.bad_choice_index_color_blue);
				setomnvar("zm_chem_value_choice",0);
			}
	
			scripts\cp\maps\cp_town\cp_town_chemistry::set_not_equal_constant("blue");
			setomnvar("zm_chem_current_color",3);
			break;

		case "cp_town_color":
			param_00 = "cp_town_color";
			scripts\cp\maps\cp_town\cp_town_chemistry::set_not_equal_constant("full");
			setomnvar("zm_chem_current_color",0);
			setomnvar("zm_chem_bvalue_choice",level.bad_choice_index_default);
			setomnvar("zm_chem_value_choice",0);
			break;
	}
}

//Function Number: 69
missinghandleinit()
{
	scripts\common\utility::flag_init("found_missing_handle");
	scripts\common\utility::flag_init("placed_missing_handle");
	var_00 = scripts\common\utility::getstructarray("missing_handle","script_noteworthy");
	var_00 = scripts\common\utility::func_22A8(var_00);
	var_01 = var_00[0];
	if(isdefined(var_01.target))
	{
		var_02 = scripts\common\utility::getstruct(var_01.target,"targetname");
	}
	else
	{
		var_02 = var_02;
	}

	var_03 = spawn("script_model",var_02.origin);
	if(isdefined(var_02.angles))
	{
		var_03.angles = var_02.angles;
	}

	var_03 setmodel("icbm_electricpanel_switch_02");
	var_01.model = var_03;
	level.missing_handle_struct = var_01;
}

//Function Number: 70
missinghandlehint(param_00,param_01)
{
	return &"CP_TOWN_INTERACTIONS_PICKUP_HANDLE";
}

//Function Number: 71
usemissinghandle(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	scripts\common\utility::flag_set("found_missing_handle");
	var_02 = scripts\common\utility::getstructarray("mpq_zom_body_part","script_noteworthy");
	var_03 = scripts\common\utility::getclosest(param_00.origin,var_02);
	scripts\cp\_interaction::add_to_current_interaction_list(var_03);
	playfx(level._effect["generic_pickup"],param_00.model.origin);
	param_01 playlocalsound("part_pickup");
	param_00.model delete();
	scripts\cp\maps\cp_town\cp_town_traps::givetrapparticon("lever");
}

//Function Number: 72
usebrokengenerator(param_00,param_01)
{
	if(scripts\common\utility::flag("found_missing_handle"))
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		param_00.fixed = 1;
		param_01 playlocalsound("part_pickup");
		var_02 = scripts\common\utility::getstruct(param_00.target,"targetname");
		var_03 = spawn("script_model",var_02.origin);
		if(isdefined(var_02.angles))
		{
			var_03.angles = var_02.angles;
		}

		var_03 setmodel("icbm_electricpanel_switch_02");
		var_03.script_noteworthy = var_02.script_noteworthy;
		var_03.var_EE79 = var_02.var_EE79;
		param_00.var_889B = var_03;
		param_00.var_889B.script_noteworthy = "-pitch";
		scripts\common\utility::flag_set("placed_missing_handle");
		wait(1);
		level notify("found_power");
		level thread lib_0D51::func_7757(param_00,param_01);
		if(isdefined(level.town_power_vo_func))
		{
			var_04 = scripts\common\utility::random(level.players);
			level thread [[ level.town_power_vo_func ]](var_04);
		}

		param_01 thread sfx_poweron(param_00);
		level thread scripts\cp\maps\cp_town\cp_town::enablepas();
		earthquake(0.3,1,param_00.origin,250);
		wait(1);
		var_05 = getent("box","script_noteworthy");
		var_05 setmodel("icbm_electricpanel9_on");
		scripts\cp\maps\cp_town\cp_town_traps::taketrapparticon("lever");
		setomnvar("zm_ui_color_eye_ent",level.color_eye);
	}
}

//Function Number: 73
sfx_poweron(param_00)
{
	wait(0.1);
	playsoundatpos(param_00.origin,"power_buy_plr_throw_switch");
	wait(0.2);
	playsoundatpos((6272,-2460,166),"power_buy_powerup_lr");
}

//Function Number: 74
brokengeneratorhint(param_00,param_01)
{
	if(!scripts\common\utility::flag("found_missing_handle"))
	{
		return &"CP_TOWN_INTERACTIONS_MISSING_HANDLE";
	}
	else if(!scripts\common\utility::flag("placed_missing_handle"))
	{
		return &"CP_TOWN_INTERACTIONS_ADD_PART";
	}

	return "";
}

//Function Number: 75
addtovisionsetarray(param_00)
{
	if(!scripts\common\utility::func_2286(level.current_vision_sets,param_00))
	{
		level.current_vision_sets[level.current_vision_sets.size] = param_00;
	}
}

//Function Number: 76
removefromvisionsetarray(param_00)
{
	if(scripts\common\utility::func_2286(level.current_vision_sets,param_00))
	{
		level.current_vision_sets = scripts\common\utility::func_22A9(level.current_vision_sets.size,param_00);
	}
}

//Function Number: 77
applyvisionsetarraytoplayer(param_00)
{
	if(level.current_vision_sets.size > 0)
	{
		foreach(var_02 in level.current_vision_sets)
		{
			param_00 visionsetnakedforplayer(var_02,0.1);
		}
	}
}

//Function Number: 78
initmeleeweapons()
{
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = scripts\common\utility::getstructarray("iw7_knife_zm_crowbar","script_noteworthy");
	var_01 = scripts\common\utility::getstructarray("iw7_knife_zm_cleaver","script_noteworthy");
	var_02 = scripts\common\utility::array_combine(var_00,var_01);
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.target))
		{
			var_05 = scripts\common\utility::getstruct(var_04.target,"targetname");
		}
		else
		{
			var_05 = var_04;
		}

		var_06 = spawn("script_model",var_05.origin);
		if(isdefined(var_05.angles))
		{
			var_06.angles = var_05.angles;
		}

		switch(var_04.script_noteworthy)
		{
			case "iw7_knife_zm_cleaver":
				var_06 setmodel("zmb_meat_cleaver_wm");
				break;

			case "iw7_knife_zm_crowbar":
				var_06 setmodel("zmb_crowbar_wm");
				break;
		}

		var_04.model = var_06;
	}
}

//Function Number: 79
initwwpieces()
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("interactions_initialized");
	level.weapon_change_func["iw7_cutie_zm"] = ::runcutielogic;
	level.weapon_change_func["iw7_cutier_zm"] = ::runcutielogic;
	var_00 = scripts\common\utility::getstructarray("front_barrel","script_noteworthy");
	var_01 = scripts\common\utility::getstructarray("plunger","script_noteworthy");
	var_02 = scripts\common\utility::getstructarray("crank","script_noteworthy");
	var_03 = scripts\common\utility::getstructarray("cutie","script_noteworthy");
	var_04 = scripts\common\utility::array_combine(var_00,var_01);
	var_05 = scripts\common\utility::array_combine(var_02,var_03);
	var_06 = scripts\common\utility::array_combine(var_04,var_05);
	var_07 = getentarray("rg_lid","targetname");
	foreach(var_09 in var_06)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_09);
		var_0A = scripts\common\utility::getclosest(var_09.origin,var_07);
		thread watchforcrowbardamage(var_0A,var_09,1,(0,-140,0));
		if(isdefined(var_09.target))
		{
			var_0B = scripts\common\utility::getstruct(var_09.target,"targetname");
		}
		else
		{
			var_0B = var_09;
		}

		var_0C = spawn("script_model",var_0B.origin);
		if(isdefined(var_0B.angles))
		{
			var_0C.angles = var_0B.angles;
		}

		switch(var_09.script_noteworthy)
		{
			case "cutie":
				var_0C setmodel("weapon_zmb_raygun_wm");
				break;

			case "front_barrel":
				var_0C setmodel("weapon_zmb_raygun_front_barrel_wm");
				break;

			case "plunger":
				var_0C setmodel("weapon_zmb_raygun_plunger_wm");
				break;

			case "crank":
				var_0C setmodel("weapon_zmb_raygun_crank_wm");
				break;
		}
	}
}

//Function Number: 80
runcutielogic(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("weapon_change");
	var_02 = 0;
	var_03 = 0;
	if(scripts\cp\_utility::func_13C90(param_01,"crank"))
	{
		var_03 = 1;
	}

	if(scripts\cp\_utility::func_13C90(param_01,"plunger"))
	{
		var_02 = 1;
	}

	param_00.cutiechargecount = 0;
	param_00 thread unsetcutieonweaponchange(param_00);
	param_00 setscriptablepartstate("cutie_fx","power_on");
	if(var_03 || var_02)
	{
		param_00 notifyonplayercommand("cutie_used","+speed_throw");
		param_00 notifyonplayercommand("cutie_used","+toggleads_throw");
		param_00 notifyonplayercommand("cutie_used","+ads_akimbo_accessible");
		for(;;)
		{
			param_00 waittill("cutie_used");
			if(param_00 usebuttonpressed() || scripts\common\utility::istrue(param_00.playingperkgesture))
			{
				continue;
			}

			if(scripts\common\utility::istrue(param_00.fired_fov_beam))
			{
				continue;
			}

			if(var_03 && !scripts\common\utility::istrue(param_00.disablecrank))
			{
				var_04 = 0;
				param_00 notify("end_cutie_gesture_loop");
				param_00 stopgestureviewmodel("ges_cutie_crank");
				var_05 = 0;
				if(param_00 getweaponammoclip(param_01) >= 5)
				{
					while(!scripts\common\utility::istrue(param_00.disablecrank) && param_00 adsbuttonpressed(1) && param_00 scripts\cp\_utility::getvalidtakeweapon() == param_01)
					{
						var_05 = 1;
						param_00 runcutiegestureloop(param_00,param_01);
						break;
					}

					continue;
				}

				param_00 playlocalsound("purchase_deny");
			}
		}
	}
}

//Function Number: 81
runcutieplungergesture(param_00,param_01,param_02)
{
	if(!scripts\common\utility::istrue(param_00.disableplunger))
	{
		level endon("game_ended");
		param_00 endon("disconnect");
		param_00.disablecrank = 1;
		param_00 setscriptablepartstate("cutiefov","plungersuck");
		param_00 playgestureviewmodel("ges_cutie_plunger",undefined,0);
		wait(param_00 method_8443("ges_cutie_plunger"));
		param_00 stopgestureviewmodel("ges_cutie_plunger");
		param_00 setscriptablepartstate("cutiefov","inactive");
		param_00 setweaponammoclip(param_01,weaponclipsize(param_01));
		if(isdefined(param_02))
		{
			param_00 thread cooldowninteractionstruct(param_02,param_00);
		}

		param_00.disablecrank = undefined;
	}
}

//Function Number: 82
cooldowninteractionstruct(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("disconnect");
	var_02 = scripts\common\utility::getclosest(param_00.origin,level.egg_sacs);
	playfx(level._effect["egg_sac_explode"],var_02.origin + (0,0,4));
	scripts\cp\_utility::func_D52A("egg_explode_after_refill_ammo",var_02.origin + (0,0,40));
	wait(0.05);
	var_02 setmodel("cp_town_creature_egg_sac_destroyed");
	stopfxontag(level._effect["vfx_egg_vapor"],var_02,"tag_origin");
	foreach(var_04 in level.plunger_ammo_spots)
	{
		if(distance(var_04.origin,var_02.origin) > 256)
		{
			continue;
		}

		scripts\cp\_interaction::remove_from_current_interaction_list(var_04);
	}

	level waittill("wave_starting");
	level waittill("wave_starting");
	level waittill("wave_starting");
	level waittill("wave_starting");
	level waittill("wave_starting");
	scripts\cp\_utility::func_D52A("egg_explode_after_refill_ammo",var_02.origin + (0,0,40));
	playfx(level._effect["egg_sac_explode"],var_02.origin + (0,0,4));
	wait(0.05);
	var_02 setmodel("cp_town_creature_egg_sac");
	wait(1);
	playfxontag(level._effect["vfx_egg_vapor"],var_02,"tag_origin");
	foreach(var_04 in level.plunger_ammo_spots)
	{
		if(distance(var_04.origin,var_02.origin) > 256)
		{
			continue;
		}

		scripts\cp\_interaction::add_to_current_interaction_list(var_04);
	}
}

//Function Number: 83
unsetcutieonweaponchange(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 waittill("weapon_change");
	param_00.disableplunger = undefined;
	param_00.disablecrank = undefined;
	param_00.cutiechargecount = 0;
	param_00.fired_fov_beam = undefined;
	if(isdefined(param_00.var_55C8) && param_00.var_55C8 >= 1)
	{
		param_00 scripts\common\utility::func_1C46(1);
	}

	param_00 stopgestureviewmodel("ges_cutie_crank");
	param_00 setscriptablepartstate("cutie_fx","inactive");
	param_00 notify("end_cutie_gesture_loop");
}

//Function Number: 84
runcutiegestureloop(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("weapon_change");
	param_00 notify("end_cutie_gesture_loop");
	param_00 endon("end_cutie_gesture_loop");
	if(isdefined(param_00.cutiechargecount) && param_00.cutiechargecount >= 5)
	{
		return;
	}

	var_02 = param_00 method_8513("ges_cutie_crank","crank_loop_end");
	if(isdefined(param_00.var_55C8) && param_00.var_55C8 < 1)
	{
		param_00 scripts\common\utility::func_1C46(0);
	}

	param_00.disableplunger = 1;
	var_03 = 5;
	param_00 playgestureviewmodel("ges_cutie_crank",undefined,0);
	while(param_00.cutiechargecount < var_03 && param_00 adsbuttonpressed(1) && param_00 scripts\cp\_utility::getvalidtakeweapon() == param_01)
	{
		wait(0.75);
		param_00.cutiechargecount++;
	}

	param_00 stopgestureviewmodel("ges_cutie_crank");
	if(param_00.cutiechargecount >= var_03)
	{
		param_00.fired_fov_beam = 1;
		param_00 thread watchforcutiefire(param_00,param_01);
	}
	else
	{
		param_00 thread delay_crank_fail_sfx();
	}

	param_00.cutiechargecount = 0;
	if(isdefined(param_00.var_55C8) && param_00.var_55C8 >= 1)
	{
		param_00 scripts\common\utility::func_1C46(1);
	}

	param_00.disableplunger = undefined;
	param_00 stopgestureviewmodel("ges_cutie_crank");
	wait(1.25);
}

//Function Number: 85
delay_crank_fail_sfx()
{
	self endon("disconnect");
	wait(0.05);
	self playlocalsound("purchase_deny");
}

//Function Number: 86
deal_damage_to_zombies_within_fov(param_00,param_01)
{
	if(self.var_134FD == "p5_")
	{
		thread scripts\cp\_vo::try_to_play_vo("ww_3","town_comment_vo","low",10,0,0,0,20);
	}
	else
	{
		thread scripts\cp\_vo::try_to_play_vo("killfirm_ww_3","town_comment_vo","low",10,0,0,0,20);
	}

	thread play_fov_fx();
	var_02 = 1;
	foreach(var_04 in scripts\cp\_agent_utils::func_7DB0("axis"))
	{
		if(var_04 scripts\cp\_utility::agentisfnfimmune())
		{
			continue;
		}

		if(scripts\common\utility::func_13D90(self.origin,self.angles,var_04.origin,cos(100)))
		{
			if(distance2dsquared(self.origin,var_04.origin) <= 250000)
			{
				var_04.nocorpse = 1;
				var_04.full_gib = 1;
				var_04.affectedbyfovdamage = 1;
				var_04 dodamage(var_02 * var_04.health + 1000,var_04.origin,self,self,"MOD_IMPACT",param_00);
			}
		}
	}
}

//Function Number: 87
play_fov_fx()
{
	self setscriptablepartstate("cutiefov","active");
	self playlocalsound("weap_cutie_cranked_fire_lyr_plr");
	wait(2);
	self setscriptablepartstate("cutiefov","inactive");
}

//Function Number: 88
watchforcutiefire(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("weapon_change");
	param_00 setscriptablepartstate("cutie_fx","charged");
	param_00 thread delayed_charged_sound();
	for(;;)
	{
		param_00 waittill("weapon_fired",var_02);
		if(getweaponbasename(var_02) == getweaponbasename(param_01))
		{
			var_03 = param_00 getweaponammoclip(var_02);
			var_04 = var_03 - 4;
			if(var_04 < 0)
			{
				var_04 = 0;
			}

			param_00 setweaponammoclip(var_02,var_04);
			param_00.cutiechargecount = 0;
			param_00 thread deal_damage_to_zombies_within_fov(var_02,var_03);
			param_00.fired_fov_beam = 0;
			break;
		}
	}

	param_00 setscriptablepartstate("cutie_fx","power_on");
}

//Function Number: 89
delayed_charged_sound()
{
	self endon("disconnect");
	wait(0.1);
	self playlocalsound("weap_cutie_first_raise_plr");
}

//Function Number: 90
fast_travel_hint(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_00.var_4622))
	{
		return &"COOP_INTERACTIONS_COOLDOWN";
	}

	if(!scripts\common\utility::istrue(param_00.var_D776))
	{
		return &"COOP_INTERACTIONS_REQUIRES_POWER";
	}

	if(!scripts\common\utility::istrue(param_00.var_1604))
	{
		return &"CP_TOWN_INTERACTIONS_ACTIVATE_FASTTRAVEL";
	}

	if(!scripts\common\utility::flag("fast_travel_ready"))
	{
		return &"CP_TOWN_INTERACTIONS_FASTTRAVEL_INACTIVE";
	}

	if(scripts\common\utility::flag("fast_travel_ready"))
	{
		return &"CP_TOWN_INTERACTIONS_ENTER_PORTAL";
	}
}

//Function Number: 91
fast_travel_use(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_00.var_4622))
	{
		return;
	}

	if(scripts\common\utility::flag("fast_travel_powered") && !scripts\common\utility::istrue(param_00.var_1604))
	{
		param_00.var_1604 = 1;
		var_02 = scripts\common\utility::getclosest(param_00.origin,getentarray("fast_travel","targetname"));
		var_02 setscriptablepartstate("portal","idle");
		param_00.portal = var_02;
	}

	if(!scripts\common\utility::flag("fast_travel_ready"))
	{
		foreach(var_04 in level.fast_travel_devices)
		{
			if(!scripts\common\utility::istrue(var_04.var_1604))
			{
				return;
			}
		}

		scripts\common\utility::flag_set("fast_travel_ready");
		foreach(var_04 in level.fast_travel_devices)
		{
			var_04.portal setscriptablepartstate("portal","on");
		}

		return;
	}

	var_08 = "";
	switch(var_06.name)
	{
		case "station":
			var_08 = "campsite";
			break;

		case "power":
			var_08 = "station";
			break;

		case "market":
			var_08 = "power";
			break;

		case "campsite":
			var_08 = "market";
			break;
	}

	var_09 = scripts\common\utility::getstructarray(var_08 + "_fast_travel","script_noteworthy");
	var_06 thread scripts\cp\maps\cp_town\cp_town_fast_travel::move_player_through_portal_tube(var_07,var_09);
	level thread fast_travel_cooldown(var_06);
}

//Function Number: 92
fast_travel_cooldown(param_00)
{
	if(isdefined(param_00.start_cooldown))
	{
		return;
	}

	if(!isdefined(param_00.start_cooldown))
	{
		param_00.start_cooldown = 1;
	}

	wait(10);
	param_00.var_4622 = 1;
	param_00.portal setscriptablepartstate("portal","idle");
	wait(60);
	param_00.portal setscriptablepartstate("portal","on");
	param_00.start_cooldown = undefined;
	param_00.var_4622 = undefined;
}

//Function Number: 93
func_6B8F()
{
	scripts\common\utility::flag_init("fast_travel_ready");
	scripts\common\utility::flag_init("fast_travel_powered");
	level.fast_travel_devices = scripts\common\utility::getstructarray("town_fast_travel","script_noteworthy");
	level scripts\common\utility::waittill_any_3("power_on",level.fast_travel_devices[0].var_D71C + " power_on");
	foreach(var_01 in level.fast_travel_devices)
	{
		var_01.var_4613 = 0;
		scripts\cp\_interaction::add_to_current_interaction_list(var_01);
		var_01.var_D776 = 1;
	}

	scripts\common\utility::flag_set("fast_travel_powered");
	if(scripts\common\utility::func_6E34("canFiresale"))
	{
		scripts\common\utility::flag_set("canFiresale");
	}

	scripts\common\utility::exploder(206);
}

//Function Number: 94
show_record_debug()
{
}

//Function Number: 95
jukebox_interaction_hint(param_00,param_01)
{
	if(!isdefined(level.music_playing) || level.music_playing != 1)
	{
		return &"COOP_INTERACTIONS_REQUIRES_POWER";
	}

	if(!isdefined(param_00.is_jukebox_on))
	{
		param_00.is_jukebox_on = 1;
	}

	if(param_00.is_jukebox_on)
	{
		return &"CP_TOWN_INTERACTIONS_JUKEBOX_OFF";
	}

	return &"CP_TOWN_INTERACTIONS_JUKEBOX_ON";
}

//Function Number: 96
disable_pa_speaker_for_town(param_00)
{
	disablepaspeaker(param_00);
	level.enabled_jukeboxes = scripts\common\utility::func_22A9(level.enabled_jukeboxes,param_00);
}

//Function Number: 97
enable_pa_speaker_for_town(param_00)
{
	enablepaspeaker(param_00);
	level.enabled_jukeboxes = scripts\common\utility::array_add_safe(level.enabled_jukeboxes,param_00);
	level.enabled_jukeboxes = scripts\common\utility::func_22AF(level.enabled_jukeboxes);
}

//Function Number: 98
jukebox_use_func(param_00,param_01)
{
	if(!isdefined(level.music_playing) || level.music_playing != 1)
	{
		return;
	}

	if(!isdefined(param_00.is_jukebox_on))
	{
		param_00.is_jukebox_on = 1;
	}

	if(!isdefined(level.enabled_jukeboxes))
	{
		level.enabled_jukeboxes = [];
	}

	param_01 playgestureviewmodel("ges_thumbs_up_mp");
	var_02 = param_00.is_jukebox_on;
	if(scripts\common\utility::istrue(var_02))
	{
		var_03 = ::disable_pa_speaker_for_town;
	}
	else
	{
		var_03 = ::enable_pa_speaker_for_town;
	}

	switch(param_00.var_EE79)
	{
		case "jukebox_icecream":
			[[ var_03 ]]("pa_town_icecream_out");
			[[ var_03 ]]("pa_town_icecream_in");
			break;

		case "jukebox_market":
			[[ var_03 ]]("pa_town_market_in");
			[[ var_03 ]]("pa_town_market_out");
			break;

		case "jukebox_campgrounds":
			[[ var_03 ]]("pa_town_camper_out");
			break;

		case "jukebox_motel":
			[[ var_03 ]]("pa_town_motel_out");
			break;

		default:
			break;
	}

	param_00.is_jukebox_on = !var_02;
}

//Function Number: 99
record_use_logic(param_00,param_01)
{
	var_02 = param_01 getstance();
	switch(param_00.target)
	{
		case "45_record_1":
			if(var_02 != "prone")
			{
				return;
			}
			break;

		case "45_record_4":
			if(var_02 != "prone")
			{
				return;
			}
			break;

		default:
			break;
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	if(!isdefined(level.records_found))
	{
		level.records_found = 0;
	}

	var_03 = getent(param_00.target,"targetname");
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	playfx(level._effect["generic_pickup"],var_03.origin);
	param_01 playlocalsound("zmb_item_pickup");
	var_03 delete();
	level.records_found++;
	if(level.records_found >= 5)
	{
		finished_town_hidden_song();
	}
}

//Function Number: 100
finished_town_hidden_song()
{
	level notify("add_hidden_song_to_playlist");
	level thread play_town_hidden_song((0,0,0),"mus_pa_town_hidden_track");
}

//Function Number: 101
play_town_hidden_song(param_00,param_01)
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("placed_missing_handle");
	scripts\common\utility::flag_set("queue_hidden_song",1);
	if(param_01 == "mus_pa_town_hidden_track")
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
				if(param_01 == "mus_pa_town_hidden_track")
				{
					var_03 setplayerdata("cp","hasSongsUnlocked","song_5",1);
				}
			}
		}

		scripts\common\utility::play_sound_in_space("zmb_jukebox_on",param_00);
		var_05 = spawn("script_origin",param_00);
		var_06 = "ee";
		var_07 = 1;
		foreach(var_03 in level.players)
		{
			var_03 scripts\cp\_persistence::give_player_xp(500,1);
		}

		var_05 playloopsound(param_01);
		var_05 thread scripts\cp\zombies\zombie_jukebox::earlyendon(var_05);
		var_0A = lookupsoundlength(param_01) / 1000;
		level scripts\common\utility::waittill_any_timeout_1(var_0A,"skip_song");
		var_05 stoploopsound();
		scripts\common\utility::flag_set("hidden_song_ended",1);
		var_05 delete();
	}
	else
	{
		wait(2);
	}

	level thread scripts\cp\zombies\zombie_jukebox::func_A4BE(param_00,1);
}

//Function Number: 102
setup_additional_cutie_ammo()
{
	var_00 = scripts\common\utility::getstructarray("plunger_ammo","script_noteworthy");
	foreach(var_02 in var_00)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
		var_02 = undefined;
	}

	var_04 = [(4836,-3370,-55),(4670,-3302,-55),(4780,-3250,-55),(4845,-3279,-55)];
	var_05 = [(513,2980,396),(579,2944,396),(577,2871,396),(499,2854,396),(463,2922,396),(519,686,426),(558,634,426),(524,571,426),(458,579,426),(444,646,426),(1123.5,625.5,425),(1076.5,591.5,425),(1175.5,595.5,425),(1524.5,893.5,425),(904,977,423),(4777,392.5,344),(4784,339.5,344),(4765,286.5,344),(4835,261.5,344),(4917,265.5,344),(5426.5,1025,342),(5478.5,975,342),(5446.5,894,342),(5367.5,900,342),(5344.5,959,342),(5737,-831,362),(5798.5,-807.5,362),(732.5,-1718,212)];
	var_04 = scripts\common\utility::array_combine(var_04,var_05);
	level.plunger_ammo_spots = [];
	foreach(var_07 in var_04)
	{
		var_08 = spawnstruct();
		var_08.name = "plunger_ammo";
		var_08.script_noteworthy = "plunger_ammo";
		var_08.origin = var_07;
		var_08.cost = 0;
		var_08.var_D776 = 1;
		var_08.var_109DA = undefined;
		var_08.var_EE79 = "";
		var_08.var_E1B9 = 0;
		var_08.var_8FFA = ::cutieammohintfunc;
		var_08.var_161A = ::useplungerammo;
		var_08.var_6261 = 1;
		var_08.disable_guided_interactions = 1;
		level.interactions["plunger_ammo"] = var_08;
		scripts\cp\_interaction::add_to_current_interaction_list(var_08);
		level.plunger_ammo_spots[level.plunger_ammo_spots.size] = var_08;
	}

	level.egg_sacs = [];
	add_egg_sac((525.5,2918.5,396),(0,275,0));
	add_egg_sac((4762,-3329.5,-75),(0,0,0));
	add_egg_sac((5778,-861.5,336.5),(0,0,0));
	add_egg_sac((5416.5,958,328),(0,0,0));
	add_egg_sac((4861,365.5,327.5),(0,0,0));
	add_egg_sac((1542.5,958,410),(0,85,0));
	add_egg_sac((1126.5,574,410),(0,115,0));
	add_egg_sac((806.5,950,410),(0,115,0));
	add_egg_sac((502.5,628,410),(0,0,0));
	add_egg_sac((773,-1692,197.386),(0,0,0));
}

//Function Number: 103
add_egg_sac(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02.angles = param_01;
	var_02 setmodel("cp_town_creature_egg_sac");
	wait(1);
	playfxontag(level._effect["vfx_egg_vapor"],var_02,"tag_origin");
	level.egg_sacs[level.egg_sacs.size] = var_02;
}