/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_interactions.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 537 ms
 * Timestamp: 10/27/2023 12:08:26 AM
*******************************************************************/

//Function Number: 1
register_interactions()
{
	level.interaction_hintstrings["neil_head"] = &"CP_ZMB_INTERACTIONS_NEIL_HEAD_PICKUP";
	level.interaction_hintstrings["neil_battery"] = &"CP_QUEST_WOR_PART";
	level.interaction_hintstrings["neil_firmware"] = &"CP_QUEST_WOR_PART";
	level.interaction_hintstrings["neil_repair"] = &"CP_ZMB_INTERACTIONS_REPAR_NEIL";
	level.interaction_hintstrings["dj_quest_part_1"] = "";
	level.interaction_hintstrings["dj_quest_part_2"] = "";
	level.interaction_hintstrings["dj_quest_part_3"] = "";
	level.interaction_hintstrings["dj_quest_speaker"] = &"CP_QUEST_WOR_PLACE_PART";
	level.interaction_hintstrings["rockettrap"] = &"CP_ZMB_INTERACTIONS_ROCKET_TRAP";
	level.interaction_hintstrings["beamtrap"] = &"CP_ZMB_INTERACTIONS_BEAMTRAP";
	level.interaction_hintstrings["interaction_discoballtrap"] = &"CP_ZMB_INTERACTIONS_USE_DISCO_TRAP";
	level.interaction_hintstrings["scrambler"] = &"CP_ZMB_INTERACTIONS_SCRAMBLER";
	level.interaction_hintstrings["blackhole_trap"] = &"CP_ZMB_INTERACTIONS_USE_BLACKHOLE_TRAP";
	level.interaction_hintstrings["debris_350"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1000"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1500"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_2000"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_2500"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1250"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_750"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["team_door_switch"] = &"CP_ZMB_INTERACTIONS_TEAM_DOOR_SWITCH";
	level.interaction_hintstrings["tutorial"] = &"CP_ZMB_INTERACTIONS_TURN_ON_TUTORIALS";
	level.interaction_hintstrings["iw7_ar57_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m4_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_fmg_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ake_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ake_zml"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_sonic_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_sonic_zmr"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_nrg_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m1_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m1_zmr"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m1c_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_revolver_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_spas_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_crb_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_crb_zml"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_erad_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_kbs_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ripper_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ripper_zmr"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ump45_zml"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m8_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_cheytac_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["crafting_pickup"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTINGITEM_PICKUP";
	level.interaction_hintstrings["crafting_item_swap"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTINGITEM_SWAP";
	level.interaction_hintstrings["crafting_station"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTING_ADDPIECE";
	level.interaction_hintstrings["crafting_nopiece"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTING_NOPIECE";
	level.interaction_hintstrings["crafting_addpiece"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTING_ADDPIECE";
	level.interaction_hintstrings["crafted_windowtrap"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_LASERTRAP";
	level.interaction_hintstrings["crafted_autosentry"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_AUTOSENTRY";
	level.interaction_hintstrings["crafted_ims"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_IMS";
	level.interaction_hintstrings["crafted_medusa"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_MEDUSA";
	level.interaction_hintstrings["crafted_electric_trap"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_ELECTRIC_TRAP";
	level.interaction_hintstrings["crafted_boombox"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_BOOMBOX";
	level.interaction_hintstrings["crafted_revocator"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_REVOCATOR";
	level.interaction_hintstrings["crafted_gascan"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_GASCAN";
	level.interaction_hintstrings["weapon_upgrade"] = &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON";
	level.interaction_hintstrings["atm_deposit"] = &"CP_ZMB_INTERACTIONS_ATM_DEPOSIT";
	level.interaction_hintstrings["atm_withdrawal"] = &"CP_ZMB_INTERACTIONS_ATM_WITHDRAWAL";
	level.interaction_hintstrings["power_armageddon"] = &"COOP_INTERACTIONS_CRAFTED_ARMAGEDDON";
	level.interaction_hintstrings["power_bioSpike"] = &"COOP_INTERACTIONS_CRAFTED_BIOSPIKE";
	level.interaction_hintstrings["power_c4"] = &"COOP_INTERACTIONS_CRAFTED_C4";
	level.interaction_hintstrings["power_barrier"] = &"COOP_INTERACTIONS_CRAFTED_BARRIER";
	level.interaction_hintstrings["power_cloak"] = &"COOP_INTERACTIONS_CRAFTED_CLOAK";
	level.interaction_hintstrings["power_mortarMount"] = &"COOP_INTERACTIONS_CRAFTED_MORTAR_MOUNT";
	level.interaction_hintstrings["power_teleport"] = &"COOP_INTERACTIONS_CRAFTED_TELEPORT";
	level.interaction_hintstrings["power_transponder"] = &"COOP_INTERACTIONS_CRAFTED_TRANSPONDER";
	level.interaction_hintstrings["power_speedBoost"] = &"COOP_INTERACTIONS_CRAFTED_SPEED_BO0ST";
	level.interaction_hintstrings["power_phaseShift"] = &"COOP_INTERACTIONS_CRAFTED_PHASE_SHIFT";
	level.interaction_hintstrings["power_kineticPulse"] = &"COOP_INTERACTIONS_CRAFTED_KINETIC_PULSE";
	level.interaction_hintstrings["power_microTurret"] = &"COOP_INTERACTIONS_CRAFTED_MICRO_TURRET";
	level.interaction_hintstrings["power_chargeMode"] = &"COOP_INTERACTIONS_CRAFTED_CHARGE_MODE";
	level.interaction_hintstrings["power_rewind"] = &"COOP_INTERACTIONS_CRAFTED_REWIND";
	level.interaction_hintstrings["fast_travel"] = &"CP_ZMB_INTERACTIONS_ENTER_PORTAL";
	level.interaction_hintstrings["small_ticket_prize"] = &"CP_ZMB_INTERACTIONS_BAG_O_BULLETS";
	level.interaction_hintstrings["medium_ticket_prize"] = &"CP_ZMB_INTERACTIONS_GRENADE_POUCH";
	level.interaction_hintstrings["large_ticket_prize"] = &"CP_ZMB_INTERACTIONS_ARK_ATTACHMENT";
	level.interaction_hintstrings["iw7_forgefreeze_zm"] = &"CP_ZMB_INTERACTIONS_REDEEM_FREEZE";
	level.interaction_hintstrings["zfreeze_semtex_mp"] = &"CP_ZMB_INTERACTIONS_REDEEM_CRYONADE";
	level.interaction_hintstrings["gold_teeth"] = &"CP_QUEST_WOR_GATOR_TEETH";
	level.interaction_hintstrings["gator_teeth_placement"] = &"CP_QUEST_WOR_PLACE_PART";
	level.interaction_hintstrings["laughingclown"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["laughingclown_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["coaster"] = &"CP_ZMB_INTERACTIONS_RIDE_COASTER";
	level.interaction_hintstrings["basketball_game"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["basketball_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["shooting_gallery"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["bowling_for_planets"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["bowling_for_planets_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["clown_tooth_game"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["clown_tooth_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["game_race"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["wor_crafting_crate"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["ark_quest_station"] = &"CP_QUEST_WOR_PLACE_PART";
	level.interaction_hintstrings["white_ark"] = &"CP_ZMB_INTERACTIONS_EQUIP_WHITE_ARK";
	level.interaction_hintstrings["arcade_barnstorming"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_robottank"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_spider"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_demon"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_starmaster"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_riverraid"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_pitfall"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_cosmic"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["spawned_essence"] = &"CP_QUEST_WOR_PART";
	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		scripts\cp\_interaction::func_DEBB("tutorial","quest",undefined,undefined,::interact_spaceland_tutorial,0,0,::init_spaceland_tutorial);
	}

	scripts\cp\_interaction::func_DEBB("arcade_barnstorming","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_robottank","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_spider","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_demon","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_starmaster","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_riverraid","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_pitfall","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_cosmic","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_counter_grenade","tickets",1,::lib_0D3F::func_1189D,::lib_0D3F::func_1189C,150,1,::lib_0D3F::func_952A);
	scripts\cp\_interaction::func_DEBB("arcade_counter_ammo","tickets",1,::lib_0D3F::func_1189D,::lib_0D3F::func_1189C,150,1,::lib_0D3F::func_9529);
	scripts\cp\_interaction::func_DEBB("small_ticket_prize","tickets",1,::lib_0D3F::func_1189D,::lib_0D3F::func_1189C,25,1,::lib_0D3F::func_974B);
	scripts\cp\_interaction::func_DEBB("medium_ticket_prize","tickets",1,::lib_0D3F::func_1189D,::lib_0D3F::func_1189C,50,1,::lib_0D3F::func_967A);
	scripts\cp\_interaction::func_DEBB("large_ticket_prize","tickets",1,::lib_0D3F::func_1189D,::lib_0D3F::func_1189C,300,1,::lib_0D3F::func_9651);
	scripts\cp\_interaction::func_DEBB("debris_350","door_buy",1,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,350);
	scripts\cp\_interaction::func_DEBB("debris_1000","door_buy",1,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1000);
	scripts\cp\_interaction::func_DEBB("debris_1500","door_buy",1,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1500);
	scripts\cp\_interaction::func_DEBB("debris_2000","door_buy",1,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,2000);
	scripts\cp\_interaction::func_DEBB("debris_2500","door_buy",1,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,2500);
	scripts\cp\_interaction::func_DEBB("debris_1250","door_buy",1,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1250);
	scripts\cp\_interaction::func_DEBB("debris_750","door_buy",1,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,750);
	scripts\cp\_interaction::func_DEBB("team_door_switch","team_door_buy",1,undefined,::scripts\cp\zombies\interaction_openareas::func_1302F,1000);
	scripts\cp\_interaction::func_DEBB("zfreeze_semtex_mp","ticket_weapon",undefined,::lib_0D3F::func_1189D,::func_82F8,350,0,::func_959A);
	scripts\cp\_interaction::func_DEBB("iw7_forgefreeze_zm","ticket_weapon",undefined,::lib_0D3F::func_1189D,::lib_0D2C::func_9A38,500,0,::func_95EA);
	scripts\cp\_interaction::func_DEBB("gold_teeth","ticket_prize",undefined,::scripts\cp\maps\cp_zmb\cp_zmb::gold_teeth_hint_func,::scripts\cp\maps\cp_zmb\cp_zmb::gold_teeth_pickup,300,1,::scripts\cp\maps\cp_zmb\cp_zmb::gator_tooth_init);
	scripts\cp\_interaction::func_DEBB("gator_teeth_placement","quest",undefined,::scripts\cp\maps\cp_zmb\cp_zmb::gator_mouth_hint_func,::scripts\cp\maps\cp_zmb\cp_zmb::gator_mouth_activation_func,0,0,::scripts\cp\maps\cp_zmb\cp_zmb::gator_tooth_placement_init);
	scripts\cp\_interaction::func_DEBB("iw7_m8_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1000);
	scripts\cp\_interaction::func_DEBB("iw7_cheytac_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1000);
	scripts\cp\_interaction::func_DEBB("iw7_m1_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,500);
	scripts\cp\_interaction::func_DEBB("iw7_m1_zmr","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,500);
	scripts\cp\_interaction::func_DEBB("iw7_m1c_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,500);
	scripts\cp\_interaction::func_DEBB("iw7_revolver_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,500);
	scripts\cp\_interaction::func_DEBB("iw7_sonic_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,750);
	scripts\cp\_interaction::func_DEBB("iw7_sonic_zmr","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,750);
	scripts\cp\_interaction::func_DEBB("iw7_nrg_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,750);
	scripts\cp\_interaction::func_DEBB("iw7_spas_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1250);
	scripts\cp\_interaction::func_DEBB("iw7_kbs_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1250);
	scripts\cp\_interaction::func_DEBB("iw7_crb_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1250);
	scripts\cp\_interaction::func_DEBB("iw7_crb_zml","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1250);
	scripts\cp\_interaction::func_DEBB("iw7_erad_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1250);
	scripts\cp\_interaction::func_DEBB("iw7_ripper_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1250);
	scripts\cp\_interaction::func_DEBB("iw7_ripper_zmr","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1250);
	scripts\cp\_interaction::func_DEBB("iw7_ump45_zml","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1250);
	scripts\cp\_interaction::func_DEBB("iw7_m4_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1500);
	scripts\cp\_interaction::func_DEBB("iw7_ar57_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1500);
	scripts\cp\_interaction::func_DEBB("iw7_ake_zml","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1500);
	scripts\cp\_interaction::func_DEBB("iw7_fmg_zm","wall_buy",1,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1500);
	scripts\cp\_interaction::func_DEBB("power_bioSpike","wall_buy",undefined,undefined,::scripts\cp\powers\coop_powers::func_8319,1000);
	scripts\cp\_interaction::func_DEBB("power_c4","wall_buy",undefined,undefined,::scripts\cp\powers\coop_powers::func_8319,1000);
	scripts\cp\_interaction::func_DEBB("ark_quest_station","quest",undefined,::lib_0D47::func_2157,::lib_0D47::func_2154,0,0,::lib_0D47::func_952B);
	scripts\cp\_interaction::func_DEBB("white_ark","quest",undefined,::lib_0D47::func_8BBD,::lib_0D47::func_1793,2000);
	scripts\cp\_interaction::func_DEBB("crafting_pickup","souvenir_coin",1,undefined,::scripts\cp\maps\cp_zmb\cp_zmb_crafting::func_47C4,0);
	scripts\cp\_interaction::func_DEBB("atm_withdrawal","atm",1,::lib_0D57::func_2418,::lib_0D57::func_9A0B,0,1,undefined);
	scripts\cp\_interaction::func_DEBB("atm_deposit","atm",1,::scripts\cp\_interaction::atm_deposit_hint,::lib_0D57::func_9A0A,1000,1,::lib_0D57::func_9538);
	scripts\cp\_interaction::func_DEBB("weapon_upgrade","pap",1,::lib_0D41::func_13C64,::lib_0D41::func_13C62,5000,0,::lib_0D41::func_94F2);
	scripts\cp\_interaction::func_DEBB("rockettrap","trap",1,undefined,::lib_0D3B::func_1300A,750,1,::lib_0D3B::func_9713);
	scripts\cp\_interaction::func_DEBB("crafting_station","souvenir_station",1,undefined,::scripts\cp\maps\cp_zmb\cp_zmb_crafting::func_12FBE,0,1,::scripts\cp\maps\cp_zmb\cp_zmb_crafting::func_9596);
	scripts\cp\_interaction::func_DEBB("beamtrap","trap",1,undefined,::lib_0D2F::func_12FAA,750,1,::lib_0D2F::func_9547);
	scripts\cp\_interaction::func_DEBB("basketball_game","arcade_game",undefined,::scripts\cp\zombies\arcade_game_utility::func_2110,::lib_0D2E::func_12FA8,0,0,::lib_0D2E::func_9541);
	scripts\cp\_interaction::func_DEBB("coaster","coaster",undefined,::scripts\cp\zombies\arcade_game_utility::func_2110,::scripts\cp\maps\cp_zmb\cp_zmb_coaster::func_12FBD,0,1,::scripts\cp\maps\cp_zmb\cp_zmb_coaster::func_957B);
	scripts\cp\_interaction::func_DEBB("laughingclown","arcade_game",undefined,::scripts\cp\zombies\arcade_game_utility::func_2110,::lib_0D36::func_AA4B,0,1,::lib_0D36::func_94EE);
	scripts\cp\_interaction::func_DEBB("bowling_for_planets","arcade_game",undefined,::scripts\cp\zombies\arcade_game_utility::func_2110,::lib_0D31::func_12FAB,0,1,::lib_0D31::func_954A);
	scripts\cp\_interaction::func_DEBB("clown_tooth_game","arcade_game",undefined,::scripts\cp\zombies\arcade_game_utility::func_2110,::lib_0D33::func_12FBC,0,1,::lib_0D33::func_957A);
	scripts\cp\_interaction::func_DEBB("game_race","arcade_game",undefined,::lib_0D3A::func_DBB3,::lib_0D3A::func_13003,0,1,::lib_0D3A::func_94F0);
	scripts\cp\_interaction::func_DEBB("basketball_game_afterlife","afterlife_game",undefined,undefined,::lib_0D2E::func_12FA8,0,0,::lib_0D2E::func_94D8);
	scripts\cp\_interaction::func_DEBB("clown_tooth_game_afterlife","afterlife_game",undefined,undefined,::lib_0D33::func_12FBC,0,0,::lib_0D33::func_94D9);
	scripts\cp\_interaction::func_DEBB("laughingclown_afterlife","afterlife_game",undefined,undefined,::lib_0D36::func_AA4B,0,0,::lib_0D36::func_94EC);
	scripts\cp\_interaction::func_DEBB("bowling_for_planets_afterlife","afterlife_game",undefined,undefined,::lib_0D31::func_12FAB,0,0,::lib_0D31::func_9549);
	scripts\cp\_interaction::func_DEBB("power_speedBoost",undefined,undefined,undefined,::scripts\cp\powers\coop_powers::func_82F7,0);
	scripts\cp\_interaction::func_DEBB("power_phaseShift",undefined,undefined,undefined,::scripts\cp\powers\coop_powers::func_82F7,0);
	scripts\cp\_interaction::func_DEBB("power_kineticPulse",undefined,undefined,undefined,::scripts\cp\powers\coop_powers::func_82F7,0);
	scripts\cp\_interaction::func_DEBB("power_microTurret",undefined,undefined,undefined,::scripts\cp\powers\coop_powers::func_82F7,0);
	scripts\cp\_interaction::func_DEBB("power_chargeMode",undefined,undefined,undefined,::scripts\cp\powers\coop_powers::func_82F7,0);
	scripts\cp\_interaction::func_DEBB("power_rewind",undefined,undefined,undefined,::scripts\cp\powers\coop_powers::func_82F7,0);
	scripts\cp\_interaction::func_DEBB("power_transponder",undefined,undefined,undefined,::scripts\cp\powers\coop_powers::func_82F7,0);
	scripts\cp\_interaction::func_DEBB("power_mortarMount",undefined,undefined,undefined,::scripts\cp\powers\coop_powers::func_82F7,0);
	scripts\cp\_interaction::func_DEBB("power_teleport",undefined,undefined,undefined,::scripts\cp\powers\coop_powers::func_82F7,0);
	scripts\cp\_interaction::func_DEBB("power_armageddon",undefined,undefined,undefined,::scripts\cp\powers\coop_powers::func_82F7,0);
	scripts\cp\_interaction::func_DEBB("power_barrier",undefined,undefined,undefined,::scripts\cp\powers\coop_powers::func_82F7,0);
	scripts\cp\_interaction::func_DEBB("crafted_autosentry","craftable",1,undefined,::scripts\cp\_weapon_autosentry::func_82BA,0);
	scripts\cp\_interaction::func_DEBB("crafted_ims","craftable",1,undefined,::scripts\cp\zombies\craftables\_fireworks_trap::func_82B5,0);
	scripts\cp\_interaction::func_DEBB("crafted_medusa","craftable",1,undefined,::scripts\cp\zombies\craftables\_zm_soul_collector::func_82B8,0);
	scripts\cp\_interaction::func_DEBB("crafted_electric_trap","craftable",1,undefined,::scripts\cp\zombies\craftables\_electric_trap::func_82BB,0);
	scripts\cp\_interaction::func_DEBB("crafted_boombox","craftable",1,undefined,::scripts\cp\zombies\craftables\_boombox::func_82B4,0);
	scripts\cp\_interaction::func_DEBB("crafted_revocator","craftable",1,undefined,::scripts\cp\zombies\craftables\_revocator::func_82B9,0);
	scripts\cp\_interaction::func_DEBB("crafted_gascan","craftable",1,undefined,::scripts\cp\zombies\craftables\_gascan::func_82B6,0);
	scripts\cp\_interaction::func_DEBB("crafted_windowtrap","craftable",1,undefined,::lib_0D43::func_DAFF,0);
	scripts\cp\_interaction::func_DEBB("interaction_discoballtrap","trap",1,undefined,::lib_0D34::func_12FC2,750,1,::lib_0D34::func_95B0);
	scripts\cp\_interaction::func_DEBB("fast_travel","fast_travel",undefined,::lib_0D4E::func_6B8E,::lib_0D4E::func_E7F4,0,1,::lib_0D4E::func_6B8F);
	scripts\cp\_interaction::func_DEBB("scrambler","trap",1,undefined,::lib_0D3C::func_1300B,750,1,::lib_0D3C::func_9721);
	scripts\cp\_interaction::func_DEBB("blackhole_trap","trap",1,undefined,::lib_0D30::func_12FAE,750,1,::lib_0D30::func_954B);
	scripts\cp\_interaction::func_DEBB("neil_head","quest",1,undefined,::lib_0D38::func_CB37,0,0);
	scripts\cp\_interaction::func_DEBB("neil_battery","quest",undefined,undefined,::lib_0D38::func_CB32,0,0);
	scripts\cp\_interaction::func_DEBB("neil_firmware","quest",undefined,undefined,::lib_0D38::func_CB34,0,0);
	scripts\cp\_interaction::func_DEBB("neil_repair","quest_neil",1,::lib_0D38::func_BEDD,::lib_0D38::func_1728,0,0);
	scripts\cp\_interaction::func_DEBB("spawned_essence","quest",undefined,undefined,::lib_0D64::func_6742,0,0);
	scripts\cp\_interaction::func_DEBB("dj_quest_part_1","quest",undefined,undefined,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_CB23,0,0,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_96AD);
	scripts\cp\_interaction::func_DEBB("dj_quest_part_2","quest",undefined,undefined,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_CB24,0,0,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_96AE);
	scripts\cp\_interaction::func_DEBB("dj_quest_part_3","quest",undefined,undefined,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_CB25,0,0,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_96AF);
	scripts\cp\_interaction::func_DEBB("dj_quest_door","quest",undefined,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_5731,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_12FC4,0,0,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_F93F);
	scripts\cp\_interaction::func_DEBB("dj_quest_speaker","quest",undefined,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_10929,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_10C10,0,0,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_95B4);
	scripts\cp\_interaction::func_DEBB("dj_quest_speaker_mid","quest",undefined,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_573E,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_136D9,0,0,::scripts\cp\maps\cp_zmb\cp_zmb_dj::func_4A1D);
	scripts\cp\_interaction::func_DEBB("pap_upgrade",undefined,undefined,::scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_C8AA,::scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_12F6F,0,0,::scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_96AB,::scripts\cp\maps\cp_zmb\cp_zmb_ufo::func_3866);
	scripts\cp\_interaction::func_DEBB("pillage_item","pillage_item",1,::lib_0D5E::func_CB59,::lib_0D5E::func_D31E,0,0);
	scripts\cp\_interaction::func_DEBB("wor_standee","quest",undefined,::lib_0D64::func_10B6E,::lib_0D64::func_10B6D,0,0,::lib_0D64::func_9764);
	if(scripts\cp\_utility::is_escape_gametype())
	{
		level.interaction_hintstrings["escape_exit"] = &"CP_ZMB_INTERACTIONS_ESCAPE_THE_PARK";
		scripts\cp\_interaction::func_DEBB("escape_exit",undefined,undefined,undefined,::scripts\cp\gametypes\escape::func_D055,0,0,::scripts\cp\maps\cp_zmb\cp_zmb_escape::func_95CC);
		return;
	}

	if(isdefined(level.escape_interaction_registration_func))
	{
		level thread [[ level.escape_interaction_registration_func ]]();
	}
}

//Function Number: 2
func_82F8(param_00,param_01)
{
	param_01 scripts\cp\powers\coop_powers::func_8397("power_cryobomb","primary",undefined,undefined,0,1);
	thread lib_0D3F::func_4DD2(param_00,param_01);
}

//Function Number: 3
func_959A()
{
	var_00 = scripts\common\utility::getstruct("zfreeze_semtex_mp","script_noteworthy");
	var_00.var_195 = var_00.trigger;
	var_00.var_195.var_9010 = level.interaction_hintstrings["zfreeze_semtex_mp"];
}

//Function Number: 4
func_95EA()
{
	var_00 = scripts\common\utility::getstruct("iw7_forgefreeze_zm+forgefreezealtfire","script_noteworthy");
	var_00.var_195 = var_00.trigger;
	var_00.var_195.var_9010 = level.interaction_hintstrings["iw7_forgefreeze_zm"];
}

//Function Number: 5
interact_spaceland_tutorial(param_00,param_01)
{
	param_01 thread scripts\cp\_hud_message::tutorial_interaction();
	param_01 setclientomnvar("zm_tutorial_num",-1);
}

//Function Number: 6
init_spaceland_tutorial()
{
	level.tutorial_interaction_1 = spawn_tutorial_interaction((688,3116.5,0));
	level.tutorial_interaction_2 = spawn_tutorial_interaction((688,3203,0));
}

//Function Number: 7
spawn_tutorial_interaction(param_00)
{
	var_01 = spawnstruct();
	var_01.script_noteworthy = "tutorial";
	var_01.origin = param_00;
	var_01.var_E1B9 = 0;
	var_01.var_D776 = 1;
	var_01.var_EE79 = "tutorial";
	var_01.name = "tutorial";
	var_01.var_109DA = "quest";
	var_01.var_336 = "interaction";
	scripts\cp\_interaction::add_to_current_interaction_list(var_01);
	return var_01;
}

//Function Number: 8
zmb_player_interaction_monitor()
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

		if(!scripts\cp\_interaction::func_3863(var_04))
		{
			scripts\cp\_interaction::func_E1F6();
			if(isdefined(self.ticket_item_outlined))
			{
				self.ticket_item_outlined hudoutlinedisableforclient(self);
				self.ticket_item_outlined = undefined;
			}

			continue;
		}

		if(!scripts\cp\_interaction::func_9A24(var_04))
		{
			if(isdefined(self.ticket_item_outlined))
			{
				self.ticket_item_outlined hudoutlinedisableforclient(self);
				self.ticket_item_outlined = undefined;
			}
		}

		if(scripts\cp\_interaction::func_9A14(var_04) && !isdefined(var_04.var_4AE2) || isdefined(var_04.var_4AE2) && var_04.var_4AE2.size < 1)
		{
			scripts\cp\_interaction::func_E1F6();
			continue;
		}
		else if(scripts\cp\_interaction::func_9A2A(var_04))
		{
			if(!scripts\cp\_weapon::func_3862("arkpink",self getcurrentweapon()))
			{
				scripts\cp\_interaction::func_E1F6();
				continue;
			}
			else if(scripts\common\utility::istrue(self.var_8BBC))
			{
				scripts\cp\_interaction::func_E1F6();
				continue;
			}
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

//Function Number: 9
zmb_wait_for_interaction_triggered(param_00)
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

		if(!scripts\cp\_interaction::func_9A27(param_00,var_01))
		{
			wait(0.1);
			continue;
		}

		param_00.var_127BA = 1;
		param_00 thread scripts\cp\_interaction::func_50FA();
		if(isdefined(param_00.var_269F))
		{
			if(param_00.var_269F > 0)
			{
				if(!isdefined(var_01.var_4B5E))
				{
					var_01 thread scripts\cp\_vo::try_to_play_vo("no_souvenir_coin","zmb_comment_vo","low",10,0,0,0,50);
				}
			}
		}

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
		else if(scripts\cp\_interaction::func_9A21(param_00) && scripts\cp\_interaction::func_D0C5(param_00,self))
		{
			scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_ALREADY_HAVE");
			wait(0.1);
			continue;
		}
		else if(param_00.script_noteworthy == "dj_quest_speaker")
		{
			var_03 = self canplayerplacesentry(1,24);
			if(!self isonground() || !var_03["result"] || abs(param_00.origin[2] - self.origin[2]) > 24)
			{
				scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_NOT_ENOUGH_SPACE");
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

			var_04 = var_01 getcurrentweapon();
			level.var_D8C6 = var_01 getcurrentweapon();
			var_05 = scripts\cp\_weapon::func_7D62(var_04);
			if(scripts\common\utility::istrue(var_01.has_zis_soul_key) || scripts\common\utility::istrue(level.placed_alien_fuses))
			{
				if(var_05 == 3)
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_UPGRADE_MAXED");
					wait(0.1);
					continue;
				}
				else if(scripts\cp\_weapon::func_385F(var_04))
				{
					if(var_05 == 1)
					{
						var_02 = 5000;
					}
					else if(var_05 == 2)
					{
						var_02 = 10000;
					}
				}
				else
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
					wait(0.1);
					continue;
				}
			}
			else if(var_05 == level.var_C8A4)
			{
				scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_UPGRADE_MAXED");
				wait(0.1);
				continue;
			}
			else if(scripts\cp\_weapon::func_385F(var_04))
			{
				if(var_05 == 1)
				{
					var_02 = 5000;
				}
				else if(var_05 == 2)
				{
					var_02 = 10000;
				}
			}
			else
			{
				scripts\cp\_interaction::func_9A3C(param_00,&"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
				wait(0.1);
				continue;
			}
		}
		else if(isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "spawned_essence")
		{
			if(!scripts\cp\_utility::func_13C90(var_01 getcurrentweapon(),"arcane_base"))
			{
				thread scripts\cp\_vo::try_to_play_vo("quest_arcane_nocore_fail","zmb_comment_vo","medium",10,0,0,1,100);
				scripts\cp\_interaction::func_9A3C(param_00,&"CP_QUEST_WOR_CANNOT_PICKUP_ESSENCE");
				wait(0.1);
				continue;
			}
		}
		else if(scripts\cp\_interaction::func_9A2A(param_00))
		{
			if(!scripts\cp\_utility::func_13C90(var_01 getcurrentweapon(),"arcane_base"))
			{
				scripts\cp\_interaction::func_9A3C(param_00,&"CP_QUEST_WOR_CANNOT_PICKUP_ESSENCE");
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

			var_06 = var_01 getcurrentweapon();
			var_07 = scripts\cp\_utility::func_7DF7(var_06);
			if(param_00.var_EE79 == "tickets")
			{
				if(self hasweapon(param_00.script_noteworthy))
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_ALREADY_HAVE");
					wait(0.1);
					continue;
				}

				self.var_A035 = param_00.script_noteworthy;
				scripts\cp\zombies\zombie_analytics::func_AF75(level.wave_num,self.var_A035,level.var_12631);
			}

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
					var_08 = scripts\cp\_utility::func_80D8(param_00.script_noteworthy);
					var_05 = scripts\cp\_weapon::func_7D62(var_08);
					if(var_05 > 1)
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
		else if(scripts\cp\_interaction::func_9A17(param_00))
		{
			if(!isdefined(var_01.var_4B5E) && param_00.var_269F > 0)
			{
				level notify("interaction","purchase_denied",level.interactions[param_00.script_noteworthy],self);
				wait(0.1);
				continue;
			}
		}
		else if(scripts\cp\_interaction::func_9A24(param_00))
		{
			if(param_00.script_noteworthy == "large_ticket_prize")
			{
				var_04 = self getcurrentweapon();
				var_09 = strtok(var_04,"_");
				if(var_09[0] == "alt" && issubstr(var_04,"meleervn"))
				{
					continue;
				}

				var_0A = scripts\cp\_utility::func_783C(param_00);
				if(scripts\cp\_utility::func_13C90(self getcurrentweapon(),var_0A))
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_ALREADY_HAVE");
					wait(0.1);
					continue;
				}

				if(!scripts\cp\_weapon::func_3862(var_0A))
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_PILLAGE_CANT_USE");
					wait(0.1);
					continue;
				}
			}
			else if(param_00.script_noteworthy == "arcade_counter_grenade")
			{
				var_0B = scripts\cp\powers\coop_powers::func_13CFC("primary");
				if(self.var_D782[var_0B].var_3D23 >= level.var_D782[var_0B].var_B486)
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_EQUIPMENT_FULL");
					wait(0.1);
					continue;
				}
			}
			else if(param_00.script_noteworthy == "arcade_counter_ammo")
			{
				var_0C = self getcurrentweapon();
				if(self getweaponammostock(var_0C) >= function_0249(var_0C))
				{
					var_0D = 1;
					if(function_0249(var_0C) == weaponclipsize(var_0C))
					{
						if(self getweaponammoclip(var_0C) < weaponclipsize(var_0C))
						{
							var_0D = 0;
						}
					}

					if(var_0D)
					{
						scripts\cp\_interaction::func_9A3C(param_00,&"COOP_GAME_PLAY_AMMO_MAX");
						wait(0.1);
						continue;
					}
				}
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
		else if(scripts\cp\_interaction::func_9A1B(param_00))
		{
			if(!isdefined(param_00.var_D742))
			{
				param_00.var_D742 = param_00.script_noteworthy;
			}

			if(isdefined(self.var_D782[param_00.var_D742]) && self.var_D782[param_00.var_D742].var_3D23 >= level.var_D782[param_00.var_D742].var_B486)
			{
				scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_EQUIPMENT_FULL");
				wait(0.1);
				continue;
			}
		}
		else if(scripts\cp\_interaction::interaction_is_challenge_station(param_00))
		{
			if(!isdefined(self.completed_challenges))
			{
				var_02 = 0;
			}
			else if(scripts\common\utility::func_2286(self.completed_challenges,param_00.var_EEFA))
			{
				var_02 = 0;
			}
			else
			{
				var_02 = 0;
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
					thread scripts\cp\_vo::try_to_play_vo("no_cash","zmb_comment_vo","high",30,0,0,1,50);
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

		if(param_00.var_EE79 == "tickets")
		{
			self.num_tickets = self.num_tickets - var_02;
			self setclientomnvar("zombie_number_of_ticket",int(self.num_tickets));
			self notify("spent_tickets_notify",var_02);
			if(isdefined(param_00.var_195) && isdefined(param_00.var_195.model))
			{
				self.var_A035 = param_00.var_195.model;
			}
			else
			{
				self.var_A035 = param_00.script_noteworthy;
			}

			level.var_12631 = randomint(100);
			scripts\cp\zombies\zombie_analytics::func_AF75(level.wave_num,self.var_A035,level.var_12631);
			thread scripts\cp\_vo::try_to_play_vo("purchase_tickets","zmb_comment_vo","medium",2,0,0,1,40);
			level thread [[ level.interactions[param_00.script_noteworthy].var_161A ]](param_00,self);
			scripts\cp\_interaction::func_9A34(param_00);
			wait(0.1);
			return;
		}

		var_0E = level.interactions[param_00.script_noteworthy].var_109DA;
		thread scripts\cp\_interaction::func_11449(var_02,var_0E);
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