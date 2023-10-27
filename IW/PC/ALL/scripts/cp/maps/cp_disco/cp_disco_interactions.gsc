/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\cp_disco_interactions.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 118
 * Decompile Time: 5988 ms
 * Timestamp: 10/27/2023 12:04:05 AM
*******************************************************************/

//Function Number: 1
register_interactions()
{
	level.interaction_hintstrings["debris_350"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1000"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1500"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_2000"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_2500"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1250"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_750"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["power_door_sliding"] = &"COOP_INTERACTIONS_REQUIRES_POWER";
	level.interaction_hintstrings["power_door_pivot"] = &"COOP_INTERACTIONS_REQUIRES_POWER";
	level.interaction_hintstrings["chi_0"] = "";
	level.interaction_hintstrings["chi_1"] = "";
	level.interaction_hintstrings["chi_2"] = "";
	level.interaction_hintstrings["fan_trap"] = &"CP_DISCO_INTERACTIONS_FAN_TRAP";
	level.interaction_hintstrings["electric_trap"] = &"CP_DISCO_INTERACTIONS_ELECTRIC_TRAP";
	level.interaction_hintstrings["trap_buffer"] = &"CP_DISCO_INTERACTIONS_TRAP_BUFFER_HINT";
	level.interaction_hintstrings["trap_hydrant"] = &"CP_DISCO_INTERACTIONS_TRAP_HYDRANT_HINT";
	level.interaction_hintstrings["trap_mosh"] = &"CP_DISCO_INTERACTIONS_TRAP_MOSH_HINT";
	scripts\cp\_interaction::func_DEBB("debris_350","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,350);
	scripts\cp\_interaction::func_DEBB("debris_1000","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1000);
	scripts\cp\_interaction::func_DEBB("debris_1500","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1500);
	scripts\cp\_interaction::func_DEBB("debris_2000","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,2000);
	scripts\cp\_interaction::func_DEBB("debris_2500","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,2500);
	scripts\cp\_interaction::func_DEBB("debris_1250","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1250);
	scripts\cp\_interaction::func_DEBB("debris_750","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,750);
	scripts\cp\_interaction::func_DEBB("team_killdoor","team_killdoor",undefined,undefined,undefined,0,1);
	scripts\cp\_interaction::func_DEBB("chi_0","chi_door",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,0,0);
	scripts\cp\_interaction::func_DEBB("chi_1","chi_door",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1,0);
	scripts\cp\_interaction::func_DEBB("chi_2","chi_door",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,2,0);
	scripts\cp\_interaction::func_DEBB("power_door_sliding","door_buy",undefined,undefined,undefined,0,1,::func_9749);
	scripts\cp\_interaction::func_DEBB("power_door_pivot","door_buy",undefined,undefined,undefined,0,1,::init_pivot_power_doors);
	disco_register_interaction(1,"phonebooth",undefined,undefined,::scripts\cp\maps\cp_disco\phonebooth::hint_phonebooth,::scripts\cp\maps\cp_disco\phonebooth::use_phonebooth,0,1,::scripts\cp\maps\cp_disco\phonebooth::init_phonebooth);
	disco_register_interaction(1,"disco_record",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::discorecordhint,::scripts\cp\maps\cp_disco\cp_disco::discorecorduse,0,1,::scripts\cp\maps\cp_disco\cp_disco::init_disco_record);
	disco_register_interaction(1,"punk_record",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::punkrecordhint,::scripts\cp\maps\cp_disco\cp_disco::punkrecorduse,0,1,::scripts\cp\maps\cp_disco\cp_disco::init_punk_record);
	disco_register_interaction(1,"pa_turntable",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::paturntablehint,::scripts\cp\maps\cp_disco\cp_disco::paturntableuse,0,1,::scripts\cp\maps\cp_disco\cp_disco::init_pa_turntables);
	disco_register_interaction(1,"clock",undefined,undefined,::hint_nunchucks,::use_nunchucks_object,0,0,::init_nunchucks);
	disco_register_interaction(1,"clock_2",undefined,undefined,::hint_nunchucks,::use_nunchucks_object_2,0,0,::init_nunchucks_2);
	disco_register_interaction(1,"clock_3",undefined,undefined,::hint_nunchucks,::use_nunchucks_object_3,0,0,::init_nunchucks_3);
	disco_register_interaction(1,"memory_tv",undefined,undefined,::hint_nunchucks,::use_memory_tv_object,0,0,::init_memory_tv);
	disco_register_interaction(1,"memory_object_three",undefined,undefined,::mem_object_hint,::mem_object_func,0,0,::init_mem3);
	disco_register_interaction(1,"memory_object_four",undefined,undefined,::mem_object_hint,::mem_object_func,0,0,::init_mem4);
	disco_register_interaction(1,"memory_object_five",undefined,undefined,::mem_object_hint,::mem_object_func,0,0,::init_mem5);
	disco_register_interaction(1,"memory_object_six",undefined,undefined,::mem_object_hint,::mem_object_func,0,0,::init_mem6);
	register_environment_interactions();
	disco_register_interaction(1,"rk_relic_pos",undefined,undefined,::scripts\cp\maps\cp_disco\rat_king_fight::rkrelic_hint_func,::scripts\cp\maps\cp_disco\rat_king_fight::pickuprkrelic,0,0,::scripts\cp\maps\cp_disco\rat_king_fight::init_rkrelic);
	disco_register_interaction(1,"rk_arena_center",undefined,undefined,::scripts\cp\maps\cp_disco\rat_king_fight::rkarenacenter_hint_func,::scripts\cp\maps\cp_disco\rat_king_fight::userkarenacenter,0,0,undefined);
	disco_register_interaction(1,"rk_debug",undefined,undefined,::scripts\cp\maps\cp_disco\rat_king_fight::rkdebug_hint_func,::scripts\cp\maps\cp_disco\rat_king_fight::userkdebug,0,0,undefined);
	scripts\cp\_interaction::func_DEBB("trap_buffer","trap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_traps::use_buffer_trap,750,1,::scripts\cp\maps\cp_disco\cp_disco_traps::init_buffer_trap);
	scripts\cp\_interaction::func_DEBB("trap_hydrant","trap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_traps::use_hydrant_trap,350,1,::scripts\cp\maps\cp_disco\cp_disco_traps::init_hydrant_trap);
	scripts\cp\_interaction::func_DEBB("trap_mosh","trap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_traps::use_mosh_trap,750,1,::scripts\cp\maps\cp_disco\cp_disco_traps::init_mosh_trap);
	scripts\cp\_interaction::func_DEBB("fan_trap","trap",undefined,undefined,::use_fan_trap,750,1,::init_fan_trap);
	scripts\cp\_interaction::func_DEBB("electric_trap","trap",undefined,undefined,::func_12FE5,750,0,::init_electric_trap);
	disco_register_interaction(1,"turnstile",undefined,undefined,::scripts\cp\maps\cp_disco\disco_mpq::empty_hint,::scripts\cp\maps\cp_disco\disco_mpq::use_turnstile,0,0,::scripts\cp\maps\cp_disco\disco_mpq::init_turnstile);
	disco_register_interaction(1,"disco_fever_interact",undefined,undefined,::scripts\cp\maps\cp_disco\disco_mpq::discofeverhintfunc,::scripts\cp\maps\cp_disco\disco_mpq::use_turntable,0,0,::scripts\cp\maps\cp_disco\disco_mpq::init_turntable);
	disco_register_interaction(1,"mpq_relics",undefined,undefined,::scripts\cp\maps\cp_disco\disco_mpq::mpqrelichintfunc,::scripts\cp\maps\cp_disco\disco_mpq::mpqrelicusefunc,0,0);
	register_martial_arts_style_interactions();
	register_weapon_interactions();
	register_pack_a_punch_interactions();
	func_DE92();
	func_DEA7();
	level notify("interactions_initialized");
	scripts\common\utility::flag_set("interactions_initialized");
	if(isdefined(level.escape_interaction_registration_func))
	{
		[[ level.escape_interaction_registration_func ]]();
	}
}

//Function Number: 2
register_pack_a_punch_interactions()
{
	level.interaction_hintstrings["enter_stall"] = &"CP_DISCO_INTERACTIONS_NEED_TOKENS";
	level.interaction_hintstrings["enter_stall_allowed"] = &"CP_DISCO_INTERACTIONS_ENTER_THIS_AREA";
	level.interaction_hintstrings["enter_peepshow"] = &"CP_DISCO_INTERACTIONS_NEED_TICKET";
	level.interaction_hintstrings["enter_peepshow_allowed"] = &"CP_DISCO_INTERACTIONS_ENTER_THIS_AREA";
	level.interaction_hintstrings["peepshow_flyer"] = "";
	level.interaction_hintstrings["pickup_reel"] = "";
	level.interaction_hintstrings["add_reel"] = &"CP_DISCO_INTERACTIONS_ADD_REEL";
	level.interaction_hintstrings["pap_fuse_switch"] = "";
	level.interaction_hintstrings["pap_fusebox"] = "";
	level.interaction_hintstrings["weapon_upgrade"] = &"CP_DISCO_INTERACTIONS_UPGRADE_WEAPON";
	scripts\cp\_interaction::func_DEBB("enter_stall","pap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::enter_pap_stall,0,0);
	scripts\cp\_interaction::func_DEBB("add_reel","pap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::add_reel,0,0,::scripts\cp\maps\cp_disco\cp_disco::init_projector);
	scripts\cp\_interaction::func_DEBB("pickup_reel","pap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::pickup_reel,0,0);
	scripts\cp\_interaction::func_DEBB("pap_portal","fast_travel",undefined,::scripts\cp\maps\cp_disco\cp_disco::pap_portal_hint_logic,::scripts\cp\maps\cp_disco\cp_disco::pap_portal_use_func,0,0);
	scripts\cp\_interaction::func_DEBB("enter_stall_allowed","pap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::enter_pap_stall,0,0);
	scripts\cp\_interaction::func_DEBB("enter_peepshow","pap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::enter_peepshow,0,0);
	scripts\cp\_interaction::func_DEBB("enter_peepshow_allowed","pap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::enter_peepshow,0,0);
	scripts\cp\_interaction::func_DEBB("peepshow_flyer","pap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::take_peepshow_flyer,0,0,::scripts\cp\maps\cp_disco\cp_disco::init_peepshow_flyer);
	scripts\cp\_interaction::func_DEBB("pap_fuse_switch","pap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::use_pap_upgrade_switch,0,0);
	scripts\cp\_interaction::func_DEBB("pap_fusebox","pap",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco::take_fuses,0,0);
	scripts\cp\_interaction::func_DEBB("weapon_upgrade","pap",undefined,::scripts\cp\maps\cp_disco\cp_disco_weapon_upgrade::weapon_upgrade_hint_func,::scripts\cp\maps\cp_disco\cp_disco_weapon_upgrade::func_13C62,5000,1,::lib_0D41::func_94F2);
}

//Function Number: 3
register_martial_arts_style_interactions()
{
	disco_register_interaction(1,"martial_arts_animals",undefined,undefined,::scripts\cp\maps\cp_disco\kung_fu_mode::style_hint_func,::scripts\cp\maps\cp_disco\kung_fu_mode::choose_martial_arts_style,0,0,::scripts\cp\maps\cp_disco\kung_fu_mode::ma_style_init);
	disco_register_interaction(1,"gourd_station",undefined,undefined,::scripts\cp\maps\cp_disco\kung_fu_mode::usegourd_hint_func,::scripts\cp\maps\cp_disco\kung_fu_mode::usegourdstation,0,0,::scripts\cp\maps\cp_disco\kung_fu_mode::guord_interaction_init);
	disco_register_interaction(0,"martial_arts_trainer",undefined,undefined,::scripts\cp\maps\cp_disco\kung_fu_mode::trainer_hint_func,::scripts\cp\maps\cp_disco\kung_fu_mode::talk_to_trainer,0,0,::scripts\cp\maps\cp_disco\kung_fu_mode::init_martial_arts_trainer);
	disco_register_interaction(1,"black_cat",undefined,undefined,::scripts\cp\maps\cp_disco\kung_fu_mode::blackcathintfunc,::scripts\cp\maps\cp_disco\kung_fu_mode::blackcatusefunc,0,0,::scripts\cp\maps\cp_disco\kung_fu_mode::blackcatinitfunc);
	disco_register_interaction(1,"perk_candy_box",undefined,undefined,::scripts\cp\maps\cp_disco\rat_king_fight::perkbox_hintfunc,::scripts\cp\maps\cp_disco\rat_king_fight::perkbox_usefunc,0,0,::scripts\cp\maps\cp_disco\rat_king_fight::init_rk_candy_interactions);
}

//Function Number: 4
register_environment_interactions()
{
	level.interaction_hintstrings["atm_deposit"] = &"CP_DISCO_INTERACTIONS_ATM_DEPOSIT";
	level.interaction_hintstrings["atm_withdrawal"] = &"CP_DISCO_INTERACTIONS_ATM_WITHDRAWAL";
	disco_register_interaction(1,"pay_phones","atm",undefined,::blank_hint,::func_2B53,0);
	disco_register_interaction(1,"trash_cans","atm",undefined,::blank_hint,::trash_can_use,0);
	disco_register_interaction(0,"atm_deposit","atm",undefined,::scripts\cp\_interaction::atm_deposit_hint,::atm_deposit,1000,1,undefined);
	disco_register_interaction(0,"atm_withdrawal","atm",undefined,::atm_withdrawal_hint,::atm_withdrawal,0,1,::setup_atm_system);
}

//Function Number: 5
trash_can_use(param_00,param_01)
{
	if(!isdefined(param_00.var_1305D))
	{
		param_00.var_1305D = [];
	}

	if(isdefined(param_01.first_cipher_seen) && param_01.first_cipher_seen && !scripts\common\utility::func_2286(param_00.var_1305D,param_01))
	{
		param_00.var_1305D[param_00.var_1305D.size] = param_01;
		param_00.used_by_player = 1;
		param_01.treasure_cans_used++;
		param_01 notify("player_used_trashcan");
		param_01 playlocalsound("skullbuster_arcade_pickup_spraycleaner");
		level notify("player_used_trashcan");
	}
}

//Function Number: 6
func_2B53(param_00,param_01)
{
}

//Function Number: 7
blank_hint(param_00,param_01)
{
	return "";
}

//Function Number: 8
blank_use(param_00,param_01)
{
	param_01 playlocalsound("part_pickup");
	thread disableinteractionfortime(param_00,5);
}

//Function Number: 9
register_weapon_interactions()
{
	level.interaction_hintstrings["iw7_ar57_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m4_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_fmg_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ake_zml"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_sonic_zmr"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_g18_zmr"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_revolver_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m1_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m1c_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_spas_zmr"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_crb_zml"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_erad_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_kbs_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_g18c_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ripper_zmr"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ump45_zml"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m8_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_cheytac_zmr"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_devastator_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_axe_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_katana_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_rvn_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_udm45_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	level.interaction_hintstrings["iw7_katana_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
	disco_register_interaction(1,"iw7_katana_zm","wall_buy",undefined,::scripts\cp\maps\cp_disco\rat_king_fight::katanahintfunc,::scripts\cp\maps\cp_disco\rat_king_fight::katanausefunc,10000);
	var_00 = 500;
	scripts\cp\_interaction::func_DEBB("iw7_revolver_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_m1c_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	var_00 = 750;
	scripts\cp\_interaction::func_DEBB("iw7_g18c_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_sonic_zmr","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_udm45_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	var_00 = 1000;
	scripts\cp\_interaction::func_DEBB("iw7_m8_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_cheytac_zmr","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_g18_zmr","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_rvn_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_spas_zmr","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_kbs_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_crb_zml","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_erad_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_ripper_zmr","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_ump45_zml","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_devastator_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_00);
	scripts\cp\_interaction::func_DEBB("iw7_m4_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1500);
	scripts\cp\_interaction::func_DEBB("iw7_ar57_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1500);
	scripts\cp\_interaction::func_DEBB("iw7_ake_zml","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1500);
	scripts\cp\_interaction::func_DEBB("iw7_fmg_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1500);
	scripts\cp\_interaction::func_DEBB("iw7_axe_zm","wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,1500);
}

//Function Number: 10
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

//Function Number: 11
func_DEA7()
{
	level.interaction_hintstrings["craft_robot"] = "";
	level.interaction_hintstrings["purchase_robot"] = &"CP_DISCO_PURCHASE_ROBOT";
	level.interaction_hintstrings["craft_zombgone"] = "";
	level.interaction_hintstrings["purchase_zombgone"] = &"CP_DISCO_PURCHASE_ZOMBGONE";
	level.interaction_hintstrings["craft_turret"] = "";
	level.interaction_hintstrings["purchase_turret"] = &"CP_DISCO_PURCHASE_TURRET";
	level.interaction_hintstrings["craft_boombox"] = "";
	level.interaction_hintstrings["purchase_boombox"] = &"CP_DISCO_PURCHASE_BOOMBOX";
	level.interaction_hintstrings["craft_lavalamp"] = "";
	level.interaction_hintstrings["purchase_lavalamp"] = &"CP_DISCO_PURCHASE_LAVALAMP";
	level.interaction_hintstrings["puzzle"] = "";
	scripts\cp\_interaction::func_DEBB("craft_zombgone","souvenir_station",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_crafting::func_12FBE,0);
	scripts\cp\_interaction::func_DEBB("purchase_zombgone","souvenir_station",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_crafting::func_12FBE,0);
	scripts\cp\_interaction::func_DEBB("craft_turret","souvenir_station",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_crafting::func_12FBE,0);
	scripts\cp\_interaction::func_DEBB("purchase_turret","souvenir_station",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_crafting::func_12FBE,0);
	scripts\cp\_interaction::func_DEBB("craft_boombox","souvenir_station",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_crafting::func_12FBE,0);
	scripts\cp\_interaction::func_DEBB("purchase_boombox","souvenir_station",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_crafting::func_12FBE,0);
	scripts\cp\_interaction::func_DEBB("craft_lavalamp","souvenir_station",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_crafting::func_12FBE,0);
	scripts\cp\_interaction::func_DEBB("purchase_lavalamp","souvenir_station",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_crafting::func_12FBE,0);
	scripts\cp\_interaction::func_DEBB("craft_robot","souvenir_station",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_crafting::func_12FBE,0);
	scripts\cp\_interaction::func_DEBB("purchase_robot","souvenir_station",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_crafting::func_12FBE,0);
	scripts\cp\_interaction::func_DEBB("pillage_item",undefined,undefined,::lib_0D5E::func_CB59,::lib_0D5E::func_D31E,0,0);
	scripts\cp\_interaction::func_DEBB("puzzle","souvenir_coin",undefined,undefined,::scripts\cp\maps\cp_disco\cp_disco_crafting::pickup_puzzle,0);
	scripts\cp\maps\cp_disco\cp_disco_crafting::init_crafting();
}

//Function Number: 12
disco_register_interaction(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
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

//Function Number: 13
init_pivot_power_doors()
{
	var_00 = scripts\common\utility::getstructarray("power_door_pivot","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread pivot_power_door();
	}
}

//Function Number: 14
pivot_power_door()
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

	if(isdefined(self.target) && self.target == "subway_left_door")
	{
		wait(0.2);
		playsoundatpos(self.origin,"power_buy_subway_gate_open_left");
		wait(0.7);
	}

	if(isdefined(self.target) && self.target == "subway_right_door")
	{
		playsoundatpos(self.origin,"power_buy_subway_gate_open_right");
		wait(0.9);
	}

	var_00 = getentarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.classname == "script_brushmodel")
		{
			var_02 connectpaths();
			var_02 notsolid();
		}

		if(isdefined(self.var_ECF3))
		{
			if(!isdefined(var_02.angles))
			{
				var_02.angles = (0,0,0);
			}

			var_02 rotateto(var_02.angles + self.var_ECF3,1);
			continue;
		}

		var_02 hide();
	}

	scripts\cp\_interaction::func_554F(self);
	scripts\cp\zombies\zombies_spawning::func_F28B(self);
	scripts\cp\zombies\zombies_spawning::func_15FC(self.script_area);
}

//Function Number: 15
func_9749()
{
	var_00 = scripts\common\utility::getstructarray("power_door_sliding","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_102F8();
	}
}

//Function Number: 16
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

//Function Number: 17
disableinteractionfortime(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	if(isdefined(param_01))
	{
		wait(param_01);
	}
	else
	{
		wait(3);
	}

	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 18
setup_atm_system()
{
	level.var_2416 = 0;
}

//Function Number: 19
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

//Function Number: 20
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

//Function Number: 21
atm_withdrawal_hint(param_00,param_01)
{
	if(param_00.var_E1B9 && !param_00.var_D776)
	{
		return &"COOP_INTERACTIONS_REQUIRES_POWER";
	}

	if(isdefined(level.var_2416) && level.var_2416 < 1000)
	{
		return &"CP_DISCO_INTERACTIONS_ATM_INSUFFICIENT_FUNDS";
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 22
final_part_rewind_quest()
{
	if(!isdefined(self.clocks_destroyed))
	{
		self.clocks_destroyed = 0;
	}

	if(!isdefined(self.array_of_clocks))
	{
		self.array_of_clocks = [];
	}

	self.array_of_clocks = level.clocks_to_be_destroyed;
	self.start_breaking_clock = 1;
	foreach(var_02, var_01 in self.array_of_clocks)
	{
		var_01.object_num = var_02 + 1;
		thread watch_for_damage_on_clock(var_01);
	}

	thread watch_for_final_quest_end();
	thread reset_clocks_on_failure(self);
}

//Function Number: 23
watch_for_rewind_triggered_on_completion()
{
	self endon("disconnect");
	self endon("death");
	self endon("ended_on_successful_teleport");
	for(;;)
	{
		if(!scripts\common\utility::istrue(self.isrewinding) || !isdefined(self.rewindmover))
		{
			scripts\common\utility::func_136F7();
			continue;
		}
		else
		{
			var_00 = getclosestpointonnavmesh(self.origin);
			scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
			thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.05);
			thread play_fx_rewind(0.05);
			self setscriptablepartstate("scripted_rewind","inactive");
			self setscriptablepartstate("clockFx","inactive");
			self dontinterpolate();
			self setorigin(var_00,1);
			self setvelocity((0,0,0));
			self setstance("stand");
			if(!scripts\common\utility::func_A009())
			{
				scripts\common\utility::func_1C76(1);
			}

			if(!scripts\common\utility::func_9FBE())
			{
				scripts\common\utility::func_1C6E(1);
			}

			if(!scripts\cp\_utility::isteleportenabled())
			{
				scripts\cp\_utility::allow_player_teleport(1);
			}

			scripts\cp\_utility::func_E0E6("rewind_invulnerability",0);
			self playanimscriptevent("power_exit","rewind");
			self method_8447();
			self method_84D8(0);
			scripts\common\utility::func_1C53(1);
			scripts\common\utility::allow_weapon(1);
			scripts\common\utility::allow_jump(1);
			self allowprone(1);
			self limitedmovement(0);
			self unlink();
			if(isdefined(self.rewindmover))
			{
				self.rewindmover delete();
			}

			if(scripts\common\utility::istrue(self.isrewinding))
			{
				self.isrewinding = 0;
			}

			self notify("ended_on_successful_teleport");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 24
watch_for_final_quest_end()
{
	self endon("backstory_quest_complete");
	self endon("disconnect");
	for(;;)
	{
		if(self.clocks_destroyed == 3)
		{
			if(isdefined(self.rewindmover) || scripts\common\utility::istrue(self.isrewinding))
			{
				thread watch_for_rewind_triggered_on_completion();
			}

			foreach(var_01 in level.players)
			{
				var_01.start_breaking_clock = 0;
				var_01.clocks_destroyed = 0;
				if(!isdefined(var_01.array_of_clocks))
				{
					var_01.array_of_clocks = level.clocks_to_be_destroyed;
				}

				foreach(var_03 in var_01.array_of_clocks)
				{
					var_03.health = 5;
					var_03.var_4CE9 = 0;
					var_03.maxhealth = 5;
					var_03 showtoplayer(self);
					var_03.already_attacked_by_player = 0;
				}
			}

			switch(self.var_134FD)
			{
				case "p1_":
					thread scripts\cp\_vo::try_to_play_vo("ww_bio_all_sally","rave_ww_vo","highest",70,0,0,1);
					self setplayerdata("cp","alienSession","escapedRank0",1);
					break;
	
				case "p2_":
					thread scripts\cp\_vo::try_to_play_vo("ww_bio_all_poindexter","rave_ww_vo","highest",70,0,0,1);
					self setplayerdata("cp","alienSession","escapedRank1",1);
					break;
	
				case "p3_":
					thread scripts\cp\_vo::try_to_play_vo("ww_bio_all_andre","rave_ww_vo","highest",70,0,0,1);
					self setplayerdata("cp","alienSession","escapedRank2",1);
					break;
	
				case "p4_":
					thread scripts\cp\_vo::try_to_play_vo("ww_bio_all_aj","rave_ww_vo","highest",70,0,0,1);
					self setplayerdata("cp","alienSession","escapedRank3",1);
					break;
	
				default:
					level thread scripts\cp\_vo::try_to_play_vo("ww_bio_all","rave_announcer_vo","highest",70,0,0,1);
					break;
			}

			level thread dont_play_powerup_vo_for_delay(30);
			self.start_breaking_clock = 0;
			self setscriptablepartstate("scripted_rewind","inactive");
			self setscriptablepartstate("clockFx","inactive");
			if(!isdefined(level.var_B15E["nunchucks"]))
			{
				level.var_B15E["nunchucks"] = "iw7_nunchucks_zm";
			}

			self.finished_backstory = 1;
			func_107AA(self,"fire_30");
			self notify("backstory_quest_complete");
		}

		wait(1);
	}
}

//Function Number: 25
func_107AA(param_00,param_01)
{
	var_02 = param_00.origin;
	var_03 = (0,0,0);
	var_04 = self getplayerangles();
	var_05 = 7;
	var_02 = var_02 + var_03[0] * anglestoright(var_04);
	var_02 = var_02 + var_03[1] * anglestoforward(var_04);
	var_02 = var_02 + var_03[2] * anglestoup(var_04);
	var_06 = rotatepointaroundvector(anglestoup(var_04),anglestoforward(var_04),var_05);
	var_07 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_vehicleclip","physicscontents_item","physicscontents_detail","physicscontents_vehicleclip","physicscontents_vehicle","physicscontents_canshootclip","physicscontents_missileclip","physicscontents_clipshot"]);
	var_08 = scripts\common\trace::func_DCED(param_00 geteye(),var_02 + var_06,self,var_07);
	var_02 = scripts\common\utility::func_5D14(var_08["position"] + var_06 * -18,32,-2000);
	if(!scripts\cp\_weapon::func_9E54(var_02,level.var_9B0B,undefined,undefined,1))
	{
		var_02 = getclosestpointonnavmesh(param_00.origin);
	}

	level scripts\cp\zombies\_powerups::drop_loot(var_02,param_00,param_01);
}

//Function Number: 26
start_rewind_sequence()
{
	self setscriptablepartstate("clockFx","active");
	level thread player_clock_tick_sfx(self);
	func_E266();
	self.var_E4C8[self.var_E4D8] = self getplayerangles();
	self.var_E4D7[self.var_E4D8] = self.origin;
	self.var_E4DA[self.var_E4D8] = self getvelocity();
	var_00 = gettime();
	thread func_DDF2(4);
	func_E897(4);
}

//Function Number: 27
watch_for_damage_on_clock(param_00)
{
	self endon("backstory_quest_complete");
	self endon("end_this_thread");
	self endon("disconnect");
	self endon("death");
	self endon("last_stand");
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!isplayer(var_02) && !isagent(var_02))
		{
			param_00.health = param_00.maxhealth;
			continue;
		}

		if(scripts\common\utility::istrue(param_00.already_attacked_by_player))
		{
			param_00.health = param_00.maxhealth;
			continue;
		}

		if(scripts\common\utility::istrue(var_02.finished_backstory))
		{
			continue;
		}

		if(var_02 != self)
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_02.kung_fu_mode))
		{
			continue;
		}

		if(isdefined(var_05) && var_05 != "MOD_MELEE")
		{
			param_00.health = param_00.maxhealth;
			continue;
		}

		if(var_01 >= param_00.health)
		{
			var_02.clocks_destroyed++;
			param_00.already_attacked_by_player = 1;
			if(var_02.clocks_destroyed == 1)
			{
				var_02 thread start_rewind_sequence();
			}

			param_00 playfx_and_shatter_clock(var_02);
			continue;
		}

		param_00.health = param_00.maxhealth;
		continue;
	}
}

//Function Number: 28
playfx_and_shatter_clock(param_00)
{
	self endon("death");
	level endon("game_ended");
	playfx(level._effect["crafting_pickup"],self.origin);
	param_00 playlocalsound("disco_backstory_clock_smash");
	if(self.health < 0)
	{
		self.health = 5;
	}

	if(isdefined(param_00.clocks_destroyed) && param_00.clocks_destroyed == 3)
	{
		self method_8429(param_00);
		param_00 notify("end_this_thread");
	}
}

//Function Number: 29
reset_clocks_on_failure(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 notify("ended_on_successful_teleport");
	for(;;)
	{
		scripts\common\utility::waittill_any_3("rewind_power_finished","remove_rewind_ability","rewind_activated","rat_king_fight_started","last_stand");
		if(param_00.clocks_destroyed != 3)
		{
			foreach(var_02 in param_00.array_of_clocks)
			{
				var_02.health = 5;
				var_02.var_4CE9 = 0;
				var_02.maxhealth = 5;
				var_02 showtoplayer(param_00);
				var_02.already_attacked_by_player = 0;
			}

			param_00.start_breaking_clock = 0;
			param_00.clocks_destroyed = 0;
			param_00 setscriptablepartstate("scripted_rewind","inactive");
			param_00 setscriptablepartstate("clockFx","inactive");
			param_00 notify("stop_clock_sfx");
			param_00 notify("clocks_reset");
		}
	}
}

//Function Number: 30
hint_memory_tv(param_00,param_01)
{
	return &"CP_DISCO_INTERACTIONS_PHONEBOOTH_USE";
}

//Function Number: 31
init_memory_tv()
{
	foreach(var_01 in level.players)
	{
		while(!isdefined(var_01.var_134FD))
		{
			wait(1);
		}
	}

	level.tv_channels_models = ["cp_disco_tv_crt","cp_disco_tv_sally","cp_disco_tv_pointd","cp_disco_tv_andre","cp_disco_tv_aj","cp_disco_tv_yeti"];
	level.tv_modelsarray = [];
	level.tv_modelsarray = scripts\common\utility::getstructarray("tv_model","script_noteworthy");
	level.tv_array = [];
	level.tv_array = scripts\common\utility::getstructarray("memory_tv","script_noteworthy");
	if(level.tv_array.size <= 0)
	{
		return;
	}

	foreach(var_06, var_04 in level.tv_modelsarray)
	{
		var_05 = undefined;
		switch(var_04.name)
		{
			case "tv_sally":
				var_05 = spawn("script_model",var_04.origin);
				var_05 setmodel("cp_disco_tv_crt_01_off");
				var_05.angles = var_04.angles;
				var_04.model = var_05;
				var_04.var_222 = "p1_";
				break;

			case "tv_pointd":
				var_05 = spawn("script_model",var_04.origin);
				var_05 setmodel("cp_disco_tv_crt_01_off");
				var_05.angles = var_04.angles;
				var_04.model = var_05;
				var_04.var_222 = "p2_";
				break;

			case "tv_andre":
				var_05 = spawn("script_model",var_04.origin);
				var_05 setmodel("cp_disco_tv_crt_01_off");
				var_05.angles = var_04.angles;
				var_04.model = var_05;
				var_04.var_222 = "p3_";
				break;

			case "tv_aj":
				var_05 = spawn("script_model",var_04.origin);
				var_05 setmodel("cp_disco_tv_crt_01_off");
				var_05.angles = var_04.angles;
				var_04.model = var_05;
				var_04.var_222 = "p4_";
				break;

			default:
				break;
		}

		level.tv_modelsarray[var_06] = var_04;
	}

	var_07 = getentarray("clock_model","targetname");
	foreach(var_06, var_09 in var_07)
	{
		switch(var_09.script_noteworthy)
		{
			case "clock_3":
			case "clock_2":
			case "clock":
				var_09.maxhealth = 5;
				var_09.health = 5;
				var_09.var_4CE9 = 0;
				var_09 setcandamage(1);
				break;

			default:
				break;
		}

		level.clocks_to_be_destroyed[var_06] = var_09;
	}

	foreach(var_04 in level.tv_array)
	{
		switch(var_04.name)
		{
			case "tv_p1":
				var_04.number_of_tv_interactions = 4;
				var_04.times_interacted = 0;
				var_04.owner_prefix = "p1_";
				break;

			case "tv_p2":
				var_04.number_of_tv_interactions = 4;
				var_04.times_interacted = 0;
				var_04.owner_prefix = "p2_";
				break;

			case "tv_p3":
				var_04.number_of_tv_interactions = 4;
				var_04.times_interacted = 0;
				var_04.owner_prefix = "p3_";
				break;

			case "tv_p4":
				var_04.number_of_tv_interactions = 4;
				var_04.times_interacted = 0;
				var_04.owner_prefix = "p4_";
				break;

			default:
				break;
		}

		foreach(var_01 in level.players)
		{
			if(var_01.var_134FD == var_04.owner_prefix)
			{
				if(!isdefined(var_01.tv_interaction))
				{
					var_01.tv_interaction = var_04;
				}
			}
		}
	}
}

//Function Number: 32
watch_for_quest_progress(param_00)
{
	level endon("game_ended");
	self endon("tv_quest_complete");
	self endon("disconnect");
	if(scripts\common\utility::istrue(self.finished_final_part))
	{
		return;
	}

	for(;;)
	{
		if(scripts\common\utility::istrue(self.finished_final_part))
		{
			self.tv_interaction.times_interacted = 0;
			self.interacted_with_set = undefined;
			thread final_part_rewind_quest();
			wait(5);
			self notify("tv_quest_complete");
		}

		wait(1);
	}
}

//Function Number: 33
use_memory_tv_object(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("tv_quest_complete");
	param_01 endon("disconnect");
	param_01 endon("last_stand");
	param_01 endon("death");
	if(param_01.var_134FD == "p5_")
	{
		playsoundatpos(param_00.origin,"ww_magicbox_laughter");
		return;
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.isrewinding))
	{
		return;
	}

	var_02 = 666;
	var_03 = " ";
	if(param_01.var_134FD == "p5_")
	{
		playsoundatpos(param_00.origin,"ww_magicbox_laughter");
		return;
	}

	if(!isdefined(param_01.tv_interaction))
	{
		foreach(var_05 in level.tv_array)
		{
			if(var_05.owner_prefix == param_01.var_134FD)
			{
				param_01.tv_interaction = var_05;
			}
		}
	}

	if(!isdefined(param_01.tv_model))
	{
		foreach(var_08 in level.tv_modelsarray)
		{
			if(var_08.var_222 == param_01.var_134FD)
			{
				param_01.tv_model = var_08;
			}
		}
	}

	if((scripts\common\utility::istrue(param_01.finished_part_one) && scripts\common\utility::istrue(param_01.finished_part_two) && scripts\common\utility::istrue(param_01.finished_part_three)) || getdvar("scr_tv_quest") != "")
	{
		if(!isdefined(param_01.var_134FD))
		{
			return;
		}

		if(scripts\common\utility::istrue(param_01.finished_backstory))
		{
			return;
		}

		if(scripts\common\utility::istrue(param_01.interacted_with_set))
		{
			return;
		}

		if(param_01.tv_interaction.name != param_00.name)
		{
			playsoundatpos(param_00.origin,"ww_magicbox_laughter");
			return;
		}

		var_0A = randomint(6);
		switch(var_0A)
		{
			case 0:
				var_02 = 0;
				var_03 = "yeti";
				param_01.tv_model.model setmodel("cp_disco_tv_yeti");
				playsoundatpos(param_00.origin,"ww_magicbox_laughter");
				level thread delay_tv_interaction(param_00,3,param_01);
				break;

			case 1:
				var_02 = 1;
				var_03 = "p1_";
				param_01.tv_model.model setmodel("cp_disco_tv_sally");
				break;

			case 2:
				var_02 = 2;
				var_03 = "p2_";
				param_01.tv_model.model setmodel("cp_disco_tv_pointdexter");
				break;

			case 3:
				var_02 = 3;
				var_03 = "p3_";
				param_01.tv_model.model setmodel("cp_disco_tv_andre");
				break;

			case 4:
				var_02 = 4;
				var_03 = "p4_";
				param_01.tv_model.model setmodel("cp_disco_tv_aj");
				break;

			default:
				var_02 = 5;
				var_03 = "crt";
				param_01.tv_model.model setmodel("cp_disco_tv_crt");
				param_01 playlocalsound("disco_backstory_tv_channel");
				level thread delay_tv_interaction(param_00,3,param_01);
				break;
		}

		param_01 playlocalsound("disco_backstory_tv_channel");
		if(var_03 == param_01.var_134FD)
		{
			param_01 thread watch_for_quest_progress(param_00);
			param_01.interacted_with_set = 1;
			wait(1);
			param_01 thread start_fake_spawn_sequence(param_01);
			level thread delay_tv_interaction(param_00,60,param_01);
			return;
		}

		level thread delay_tv_interaction(param_00,3,param_01);
		return;
	}
}

//Function Number: 34
delay_tv_interaction(param_00,param_01,param_02)
{
	param_02 endon("disconnect");
	scripts\cp\_interaction::func_E01A(param_00,param_02);
	level scripts\common\utility::waittill_any_timeout_1(param_01,"tv_quest_complete");
	scripts\cp\_interaction::func_175D(param_00,param_02);
}

//Function Number: 35
watch_for_tries()
{
	self endon("tv_quest_complete");
	level endon("game_ended");
	self endon("disconnect");
	if(self.tv_interaction.times_interacted == self.tv_interaction.number_of_tv_interactions)
	{
		thread start_fake_spawn_sequence(self);
		return;
	}

	self.interacted_with_set = undefined;
}

//Function Number: 36
choose_number_of_karatemasters()
{
	var_00 = 1;
	if(isdefined(level.players.size) && level.players.size > 0)
	{
		switch(level.players.size)
		{
			case 1:
				var_00 = 4;
				break;

			case 4:
			case 3:
			case 2:
				var_00 = 8;
				break;

			default:
				var_00 = 4;
				break;
		}

		return var_00;
	}
}

//Function Number: 37
start_fake_spawn_sequence(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	var_01 = choose_number_of_karatemasters();
	var_02 = var_01;
	level.skeletons_alive = var_02;
	var_03 = 0;
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	if(scripts\cp\zombies\zombies_spawning::func_C209() < var_02)
	{
		var_04 = level.var_4B6E;
		var_05 = level.var_B467;
		var_06 = level.var_5274;
		var_07 = level.wave_num;
		while(level.var_4B6E == level.var_5274)
		{
			wait(0.05);
		}

		level.var_4B6E = 0;
		level.var_5274 = 24;
		level.var_10942 = 1;
		var_03 = 1;
	}

	var_08 = getrandomnavpoints(self.tv_interaction.origin,128,var_02);
	scripts\cp\zombies\zombies_spawning::func_93EB(var_02);
	wait(2);
	var_09 = skeleton_spawner(var_08,param_00);
	while(level.skeletons_alive > 0)
	{
		wait(0.1);
	}

	param_00.finished_final_part = 1;
	param_00.tv_model.model setmodel("cp_disco_tv_crt");
	if(var_03)
	{
		level.var_10847 = undefined;
		level.var_13BD6 = undefined;
		level.var_10942 = undefined;
		level.var_13FA3 = 0;
		if(level.wave_num == var_07)
		{
			level.var_4B6E = var_04;
			level.var_B467 = var_05;
			level.var_5274 = var_06;
		}
		else
		{
			level.var_4B6E = 0;
			level.var_B467 = scripts\cp\zombies\zombies_spawning::func_7ACD(level.wave_num);
			level.var_5274 = scripts\cp\zombies\zombies_spawning::func_7D10(level.wave_num);
		}
	}

	scripts\cp\zombies\zombies_spawning::func_4FB8(var_02);
	return 1;
}

//Function Number: 38
determine_best_shovel_spawns(param_00,param_01)
{
	var_02 = [];
	var_03 = scripts\common\utility::getstructarray("camper_to_lake_spawner","targetname");
	var_03 = sortbydistance(var_03,param_00);
	for(var_04 = 0;var_04 < param_01;var_04++)
	{
		var_02[var_04] = var_03[var_04];
	}

	var_05 = scripts\common\utility::array_randomize(var_02);
	return var_02;
}

//Function Number: 39
get_rand_point(param_00)
{
	while(![[ level.var_164B ]](param_00))
	{
		param_00 = getrandomnavpoint(param_00,128);
		scripts\common\utility::func_136F7();
	}

	return param_00;
}

//Function Number: 40
skeleton_spawner(param_00,param_01)
{
	param_01 endon("disconnect");
	var_02 = [];
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		param_00[var_03] = get_rand_point(param_00[var_03]);
		var_04 = spawn_skeleton_solo(param_00[var_03]);
		if(isdefined(var_04))
		{
			var_04 thread skeleton_death_watcher(param_01);
			var_02[var_02.size] = var_04;
			var_04 thread set_skeleton_attributes();
			if(!isdefined(param_01.skeletons))
			{
				param_01.skeletons = [];
			}

			param_01.skeletons[param_01.skeletons.size] = var_04;
			wait(1);
			continue;
		}

		level.skeletons_alive--;
	}

	return var_02;
}

//Function Number: 41
skeleton_death_watcher(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	self waittill("death");
	level.skeletons_alive--;
	if(level.skeletons_alive <= 0)
	{
		param_00.finished_final_part = 1;
	}
}

//Function Number: 42
spawn_skeleton_solo(param_00)
{
	param_00 = scripts\common\utility::func_5D14(param_00,30,-100);
	var_01 = spawnstruct();
	var_01.origin = param_00;
	var_01.var_EE79 = "ground_spawn_no_boards";
	var_01.var_ECF5 = "spawn_ground";
	var_02 = 4;
	var_03 = 0.3;
	for(var_04 = 0;var_04 < var_02;var_04++)
	{
		var_05 = var_01 scripts\cp\zombies\zombies_spawning::func_1081B("karatemaster",1,var_01,param_00);
		if(isdefined(var_05))
		{
			return var_05;
		}

		wait(var_03);
	}

	return undefined;
}

//Function Number: 43
set_skeleton_attributes()
{
	level endon("game_ended");
	self endon("death");
	self.dont_cleanup = 1;
	self.var_1F5 = "sprint";
	if(!scripts\common\utility::istrue(self.aj_karatemaster))
	{
		self.aj_karatemaster = 1;
	}

	self.health = scripts\cp\zombies\cp_disco_spawning::func_3728("karatemaster");
	self.maxhealth = scripts\cp\zombies\cp_disco_spawning::func_3728("karatemaster");
}

//Function Number: 44
skeleton_arrival_cowbell(param_00)
{
	var_01 = (0,0,-11);
	var_02 = spawnfx(level._effect["superslasher_summon_zombie_portal"],param_00 + var_01,(0,0,1),(1,0,0));
	triggerfx(var_02);
	scripts\common\utility::waittill_any_3("death","intro_vignette_done");
	var_02 delete();
}

//Function Number: 45
hint_nunchucks(param_00,param_01)
{
	return "";
}

//Function Number: 46
remove_influence_of_rewind_afterlife(param_00)
{
	if(isdefined(param_00.rewindmover))
	{
		param_00 setstance("stand");
		param_00.rewindmover solid();
		if(!param_00 scripts\common\utility::func_A009())
		{
			param_00 scripts\common\utility::func_1C76(1);
		}

		if(!param_00 scripts\common\utility::func_9FBE())
		{
			param_00 scripts\common\utility::func_1C6E(1);
		}

		if(!param_00 scripts\cp\_utility::isteleportenabled())
		{
			param_00 scripts\cp\_utility::allow_player_teleport(1);
		}

		param_00 scripts\cp\_utility::func_E0E6("rewind_invulnerability",0);
		param_00 playanimscriptevent("power_exit","rewind");
		param_00 method_8447();
		param_00 method_84D8(0);
		param_00 scripts\common\utility::func_1C53(1);
		param_00 scripts\common\utility::allow_weapon(1);
		param_00 scripts\common\utility::allow_jump(1);
		param_00 allowprone(1);
		param_00 limitedmovement(0);
		param_00 unlink();
		param_00.flung = undefined;
		param_00.rewindmover delete();
		param_00 setscriptablepartstate("scripted_rewind","inactive");
		param_00 setscriptablepartstate("clockFx","inactive");
		param_00 notify("rewind_power_finished");
		if(isdefined(param_00.clocks_destroyed))
		{
			param_00.clocks_destroyed = 0;
		}

		param_00.isrewinding = 0;
	}
}

//Function Number: 47
init_nunchucks()
{
	level.rewind_afterlife_func = ::remove_influence_of_rewind_afterlife;
	if(!isdefined(level.clock))
	{
		level.clock = [];
	}

	if(!isdefined(level.clock[0]))
	{
		level.clock[0] = undefined;
	}

	level.quest_one_objects = [];
	foreach(var_01 in scripts\common\utility::getstructarray("clock","script_noteworthy"))
	{
		level.clock[0] = var_01;
	}

	var_03 = scripts\common\utility::getstructarray("mem","targetname");
	foreach(var_02, var_01 in var_03)
	{
		var_05 = undefined;
		switch(var_01.script_noteworthy)
		{
			case "memory_object_one":
				var_05 = spawn("script_model",var_01.origin);
				var_05 setmodel("p7_book_vintage_05");
				var_05.angles = var_01.angles;
				var_01.object_num = 1;
				break;

			case "memory_object_two":
				var_05 = spawn("script_model",var_01.origin);
				var_05 setmodel("p7_book_vintage_05");
				var_05.angles = var_01.angles;
				var_01.object_num = 2;
				break;

			default:
				break;
		}

		var_05 setcandamage(1);
		var_05.maxhealth = 5;
		var_05.health = 5;
		var_05.var_4CE9 = 0;
		if(isdefined(var_05))
		{
			var_01.model = var_05;
		}

		level.quest_one_objects[var_02] = var_01;
	}

	foreach(var_07 in level.players)
	{
		var_07.attacked_first_object = 0;
	}

	if(isdefined(level.clock_interaction))
	{
		scripts\cp\_interaction::func_6214(level.clock_interaction);
	}
}

//Function Number: 48
watch_for_player_disconnect(param_00,param_01,param_02,param_03)
{
	level endon("clock_tick_done_1");
	level endon("objects_reset");
	level endon(param_02);
	param_00 waittill("disconnect");
	foreach(var_05 in param_03)
	{
		var_05.health = 5;
		var_05.var_4CE9 = 0;
		var_05.model showtoplayer(param_00);
		var_05.maxhealth = 5;
	}

	param_00 setscriptablepartstate("clockFx","inactive");
	param_01.clock_owner = undefined;
	param_00.objects_array_sequence["part1"] = [];
	param_01.clock_active = 0;
	scripts\cp\_interaction::func_6214(param_01);
	level notify("objects_reset");
}

//Function Number: 49
use_nunchucks_object(param_00,param_01)
{
	level endon("clock_tick_done_1");
	if(param_01.var_134FD == "p5_")
	{
		playsoundatpos(param_00.origin,"ww_magicbox_laughter");
		return;
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.isrewinding))
	{
		return;
	}

	foreach(var_03 in level.players)
	{
		if(var_03 == param_01)
		{
			if(isdefined(level.clock_interaction_q2) && isdefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_03)
			{
				return;
			}
			else if(isdefined(level.clock_interaction_q3) && isdefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_03)
			{
				return;
			}

			continue;
		}

		if(isdefined(level.clock_interaction) && isdefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_03)
		{
			return;
		}
	}

	if(scripts\common\utility::istrue(param_01.isrewinding))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.finished_part_one) && getdvar("scr_nunchucks") == "")
	{
		return;
	}

	param_01 setscriptablepartstate("clockFx","active");
	level thread player_clock_tick_sfx(param_01);
	level thread watch_for_player_disconnect(param_01,param_00,"part_1_VO_done",level.quest_one_objects);
	level thread watch_for_player_laststand(param_01,param_00,"part_1_VO_done",level.quest_one_objects);
	scripts\cp\_interaction::func_E01A(param_00,param_01);
	level.clock_interaction = param_00;
	param_00.clock_owner = param_01;
	if(!isdefined(param_01.objects_array_sequence))
	{
		param_01.objects_array_sequence = [];
	}

	if(!isdefined(param_01.objects_array_sequence["part1"]))
	{
		param_01.objects_array_sequence["part1"] = [];
	}

	param_00.clock_active = 1;
	param_01.angles_when_using_clock = param_01 getplayerangles();
	param_01 func_E266();
	param_01.var_E4D8 = 0;
	param_01.var_E4C8[param_01.var_E4D8] = param_01 getplayerangles();
	param_01.var_E4D7[param_01.var_E4D8] = param_01.origin;
	param_01.var_E4DA[param_01.var_E4D8] = param_01 getvelocity();
	var_05 = gettime();
	param_01 thread func_DDF2(1);
	param_01 thread watch_for_sequence_trigger(param_01,"1");
	param_01 thread clock_watcher(param_00,var_05,param_01,1);
	param_01 func_E897(1);
	level thread delay_enable_linked_interaction(param_00,30,param_01);
}

//Function Number: 50
player_clock_tick_sfx(param_00)
{
	var_01 = spawn("script_origin",param_00.origin);
	var_01 linkto(param_00);
	var_01 playloopsound("quest_rewind_clock_tick_long");
	param_00 scripts\common\utility::waittill_any_3("stop_clock_sfx","objects_reset_q2","objects_reset_q3","part_1_VO_done","part_2_VO_done","part_3_VO_done","backstory_quest_complete","clocks_reset");
	var_01 stoploopsound();
	var_01 delete();
}

//Function Number: 51
watch_for_player_laststand(param_00,param_01,param_02,param_03)
{
	level endon("clock_tick_done_1");
	level endon("objects_reset");
	level endon(param_02);
	param_00 endon("disconnect");
	param_00 waittill("last_stand");
	foreach(var_05 in param_03)
	{
		var_05.model.health = 5;
		var_05.model.var_4CE9 = 0;
		var_05.model.maxhealth = 5;
		var_05.model showtoplayer(param_00);
	}

	foreach(var_08 in level.players)
	{
		var_08.attacked_first_object = 0;
	}

	param_01.clock_owner = undefined;
	param_00 notify("stop_clock_sfx");
	param_00.objects_array_sequence["part1"] = [];
	param_00 setscriptablepartstate("clockFx","inactive");
	param_00 setscriptablepartstate("scripted_rewind","inactive");
	param_01.clock_active = 0;
	scripts\cp\_interaction::func_6214(param_01);
	level notify("objects_reset");
}

//Function Number: 52
clock_watcher(param_00,param_01,param_02,param_03)
{
	param_02 endon("disconnect");
	param_02 endon("death");
	level endon("game_ended");
	var_04 = 0;
	if(isdefined(param_03))
	{
		switch(param_03)
		{
			case 1:
				var_04 = 14;
				break;

			case 2:
				var_04 = 15.45;
				break;

			case 3:
				var_04 = 16.25;
				break;
		}
	}

	while(gettime() <= param_01 + var_04 * 1000)
	{
		scripts\common\utility::func_136F7();
	}

	param_00.clock_active = 0;
	param_00.clock_owner = undefined;
	param_02 notify("stop_clock_sfx");
	level notify("clock_tick_done_" + param_03);
	param_02 setscriptablepartstate("scripted_rewind","inactive");
	param_02 setscriptablepartstate("clockFx","inactive");
	level thread delay_enable_linked_interaction(param_00,30,param_02);
}

//Function Number: 53
delay_enable_linked_interaction(param_00,param_01,param_02)
{
	param_02 endon("disconnect");
	level waittill("spawn_wave_done");
	scripts\cp\_interaction::func_175D(param_00,param_02);
}

//Function Number: 54
watch_for_sequence_trigger(param_00,param_01)
{
	param_00 endon("part_" + param_01 + "_VO_done");
	param_00 endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	level endon("objects_reset");
	param_00 endon("objects_reset_q" + param_01);
	param_00 notify("ending_thread_for_" + param_00.name + " running quest " + param_01);
	param_00 endon("ending_thread_for_" + param_00.name + " running quest " + param_01);
	var_02 = [];
	var_03 = 0;
	var_04 = "part";
	var_05 = undefined;
	if(isdefined(param_01))
	{
		switch(param_01)
		{
			case "1":
				var_02 = level.quest_one_objects;
				var_03 = 2;
				var_04 = "part1";
				var_05 = ::watch_for_damage_on_struct;
				break;

			case "2":
				var_02 = param_00.quest_two_objects;
				var_03 = 2;
				var_06 = scripts\common\utility::getstructarray("memory_object_three","script_noteworthy");
				foreach(var_08 in var_06)
				{
					param_00.quest_active_q2 = 1;
					param_00 scripts\cp\_interaction::func_175D(var_08,param_00);
				}
	
				var_06 = scripts\common\utility::getstructarray("memory_object_four","script_noteworthy");
				foreach(var_08 in var_06)
				{
					param_00.quest_active_q2 = 1;
					param_00 scripts\cp\_interaction::func_175D(var_08,param_00);
				}
	
				param_00 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
				var_04 = "quest_2";
				break;

			case "3":
				var_02 = param_00.quest_three_objects;
				var_03 = 2;
				var_06 = scripts\common\utility::getstructarray("memory_object_five","script_noteworthy");
				foreach(var_08 in var_06)
				{
					param_00.quest_active_q3 = 1;
					param_00 scripts\cp\_interaction::func_175D(var_08,param_00);
				}
	
				var_06 = scripts\common\utility::getstructarray("memory_object_six","script_noteworthy");
				foreach(var_08 in var_06)
				{
					param_00.quest_active_q3 = 1;
					param_00 scripts\cp\_interaction::func_175D(var_08,param_00);
				}
	
				param_00 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
				var_04 = "quest_3";
				break;
		}
	}

	if(isdefined(var_05))
	{
		foreach(var_08 in var_02)
		{
			var_08 thread [[ var_05 ]](param_00);
		}
	}

	for(;;)
	{
		if(param_00.objects_array_sequence[var_04].size == var_03)
		{
			param_00 setscriptablepartstate("scripted_rewind","inactive");
			param_00 setscriptablepartstate("clockFx","inactive");
			level thread play_character_bio(int(param_01),param_00);
			param_00 thread reset_rewind_mover(param_01);
			switch(param_01)
			{
				case "1":
					foreach(var_13 in level.players)
					{
						var_13.attacked_first_object = 0;
					}
		
					param_00.finished_part_one = 1;
					level.clock_interaction.clock_owner = undefined;
					param_00 notify("part_" + param_01 + "_VO_done");
					break;
	
				case "2":
					foreach(var_13 in level.players)
					{
						var_13.attacked_first_object_q2 = 0;
					}
		
					param_00.finished_part_two = 1;
					param_00.quest_active_q2 = 0;
					level.clock_interaction_q2.clock_owner = undefined;
					param_00 notify("part_" + param_01 + "_VO_done");
					break;
	
				case "3":
					foreach(var_13 in level.players)
					{
						var_13.attacked_first_object_q3 = 0;
					}
		
					param_00.finished_part_three = 1;
					param_00.quest_active_q3 = 0;
					level.clock_interaction_q3.clock_owner = undefined;
					param_00 notify("part_" + param_01 + "_VO_done");
					break;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 55
play_char_bio_vo_after_delay(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	wait(param_02 + 10);
	switch(param_00)
	{
		case 1:
			if(param_01.var_134FD == "p1_")
			{
				if(!isdefined(level.var_4481["sally_willard_bio_1_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("sally_willard_bio_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["sally_willard_bio_1_1"] = 1;
				}
			}
	
			if(param_01.var_134FD == "p2_")
			{
				if(!isdefined(level.var_4481["pdex_willard_bio_1_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("pdex_willard_bio_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["pdex_willard_bio_1_1"] = 1;
				}
			}
	
			if(param_01.var_134FD == "p3_")
			{
				if(!isdefined(level.var_4481["andre_willard_bio_1_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("andre_willard_bio_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["andre_willard_bio_1_1"] = 1;
				}
			}
	
			if(param_01.var_134FD == "p4_")
			{
				if(!isdefined(level.var_4481["aj_willard_bio_1_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("aj_willard_bio_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["aj_willard_bio_1_1"] = 1;
				}
			}
			break;

		case 2:
			if(param_01.var_134FD == "p1_")
			{
				if(!isdefined(level.var_4481["sally_willard_bio_2_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("sally_willard_bio_2_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["sally_willard_bio_2_1"] = 1;
				}
			}
	
			if(param_01.var_134FD == "p2_")
			{
				if(!isdefined(level.var_4481["pdex_willard_bio_2_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("pdex_willard_bio_2_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["pdex_willard_bio_2_1"] = 1;
				}
			}
	
			if(param_01.var_134FD == "p3_")
			{
				if(!isdefined(level.var_4481["andre_willard_bio_2_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("andre_willard_bio_2_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["andre_willard_bio_2_1"] = 1;
				}
			}
	
			if(param_01.var_134FD == "p4_")
			{
				if(!isdefined(level.var_4481["aj_willard_bio_2_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("aj_willard_bio_2_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["aj_willard_bio_2_1"] = 1;
				}
			}
			break;

		case 3:
			if(param_01.var_134FD == "p1_")
			{
				if(!isdefined(level.var_4481["sally_willard_bio_3_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("sally_willard_bio_3_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["sally_willard_bio_3_1"] = 1;
				}
			}
	
			if(param_01.var_134FD == "p2_")
			{
				if(!isdefined(level.var_4481["pdex_willard_bio_3_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("pdex_willard_bio_3_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["pdex_willard_bio_3_1"] = 1;
				}
			}
	
			if(param_01.var_134FD == "p3_")
			{
				if(!isdefined(level.var_4481["andre_willard_bio_3_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("andre_willard_bio_3_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["andre_willard_bio_3_1"] = 1;
				}
			}
	
			if(param_01.var_134FD == "p4_")
			{
				if(!isdefined(level.var_4481["aj_willard_bio_3_1"]))
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("aj_willard_bio_3_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["aj_willard_bio_3_1"] = 1;
				}
			}
			break;
	}
}

//Function Number: 56
play_character_bio(param_00,param_01)
{
	param_01 endon("disconnect");
	wait(3);
	var_02 = 60;
	var_03 = " ";
	switch(param_00)
	{
		case 1:
			if(param_01.var_134FD == "p1_")
			{
				var_03 = "ww_bio_sally_1";
			}
	
			if(param_01.var_134FD == "p2_")
			{
				var_03 = "ww_bio_pdex_1";
			}
	
			if(param_01.var_134FD == "p3_")
			{
				var_03 = "ww_bio_andre_1";
			}
	
			if(param_01.var_134FD == "p4_")
			{
				var_03 = "ww_bio_aj_1";
			}
			break;

		case 2:
			if(param_01.var_134FD == "p1_")
			{
				var_03 = "ww_bio_sally_2";
			}
	
			if(param_01.var_134FD == "p2_")
			{
				var_03 = "ww_bio_pdex_2";
			}
	
			if(param_01.var_134FD == "p3_")
			{
				var_03 = "ww_bio_andre_2";
			}
	
			if(param_01.var_134FD == "p4_")
			{
				var_03 = "ww_bio_aj_2";
			}
			break;

		case 3:
			if(param_01.var_134FD == "p1_")
			{
				var_03 = "ww_bio_sally_3";
			}
	
			if(param_01.var_134FD == "p2_")
			{
				var_03 = "ww_bio_pdex_3";
			}
	
			if(param_01.var_134FD == "p3_")
			{
				var_03 = "ww_bio_andre_3";
			}
	
			if(param_01.var_134FD == "p4_")
			{
				var_03 = "ww_bio_aj_3";
			}
			break;
	}

	param_01 thread scripts\cp\_vo::try_to_play_vo(var_03,"rave_ww_vo","highest",30,1,0,1,100);
	var_02 = scripts\cp\_vo::func_7C76(var_03);
	level thread dont_play_powerup_vo_for_delay(var_02);
	play_char_bio_vo_after_delay(param_00,param_01,var_02);
}

//Function Number: 57
dont_play_powerup_vo_for_delay(param_00)
{
	level.dont_play_powerup_vo = 1;
	wait(param_00);
	level.dont_play_powerup_vo = 0;
}

//Function Number: 58
reset_rewind_mover(param_00)
{
	if(scripts\common\utility::istrue(self.finished_part_one) || scripts\common\utility::istrue(self.finished_part_two) || scripts\common\utility::istrue(self.finished_part_three))
	{
		if(isdefined(self.rewindmover))
		{
			param_00 = int(param_00);
			var_01 = level.clock[param_00 - 1].origin;
			var_02 = level.clock[param_00 - 1].angles;
			var_03 = (0,0,0);
			thread watch_for_rewind_triggered_on_completion();
		}

		return;
	}

	param_00 = int(param_00);
	var_01 = level.clock[param_00 - 1].origin;
	var_02 = level.clock[param_00 - 1].angles;
	var_03 = (0,0,0);
	if(isdefined(self.rewindmover) || scripts\common\utility::istrue(self.isrewinding))
	{
		thread watch_for_rewind_triggered_on_completion();
	}
}

//Function Number: 59
reset_on_failure(param_00)
{
	level endon("objects_reset");
	level endon("game_ended");
	self endon("death");
	param_00 endon("part_1_VO_done");
	param_00 endon("part_one_complete");
	param_00 endon("disconnect");
	param_00 endon("death");
	param_00 endon("last_stand");
	for(;;)
	{
		level waittill("clock_tick_done_1");
		if(param_00.objects_array_sequence["part1"].size != 2)
		{
			foreach(var_02 in level.quest_one_objects)
			{
				var_02.model.health = 5;
				var_02.model.var_4CE9 = 0;
				var_02.model showtoplayer(param_00);
				var_02.model.maxhealth = 5;
			}

			foreach(var_05 in level.players)
			{
				var_05.attacked_first_object = 0;
			}

			level.clock_interaction.clock_owner = undefined;
			param_00.objects_array_sequence["part1"] = [];
			level.clock_interaction.clock_active = 0;
			param_00 setscriptablepartstate("scripted_rewind","inactive");
			param_00 setscriptablepartstate("clockFx","inactive");
			if(isdefined(param_00.rewindmover))
			{
				param_00 thread reset_rewind_mover(1);
			}

			param_00.quest_num = undefined;
			level notify("objects_reset");
		}

		wait(1);
	}
}

//Function Number: 60
watch_for_damage_on_struct(param_00)
{
	param_00 endon("part_one_complete");
	level endon("objects_reset");
	param_00 endon("disconnect");
	param_00 endon("death");
	param_00 endon("last_stand");
	thread reset_on_failure(param_00);
	for(;;)
	{
		self.model waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!isplayer(var_02) && !isagent(var_02))
		{
			continue;
		}

		if(isdefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner != var_02)
		{
			continue;
		}

		if(isdefined(var_05) && var_05 != "MOD_MELEE")
		{
			continue;
		}

		if(self.object_num == 2 && var_02.objects_array_sequence["part1"].size == 0)
		{
			continue;
		}
		else if(!scripts\common\utility::istrue(var_02.attacked_first_object) && self.object_num == 1 && var_02.objects_array_sequence["part1"].size == 0)
		{
			var_02.objects_array_sequence["part1"][self.object_num - 1] = self;
			self.model.var_4CE9 = self.model.var_4CE9 + var_01;
			var_02.attacked_first_object = 1;
			self.model method_8429(var_02);
			var_02 playlocalsound("part_pickup");
		}

		if(self.object_num == 2 && scripts\common\utility::istrue(var_02.attacked_first_object))
		{
			var_02.objects_array_sequence["part1"][self.object_num - 1] = self;
			self.model.var_4CE9 = self.model.var_4CE9 + var_01;
			var_02.attacked_first_object = 1;
			self.model method_8429(var_02);
			var_02 playlocalsound("part_pickup");
		}

		if(var_02.objects_array_sequence["part1"].size == 2)
		{
			foreach(var_0C in var_02.objects_array_sequence["part1"])
			{
				var_0C playfx_and_shatter(var_02);
			}

			var_02 playlocalsound("zmb_ui_earn_tickets");
			param_00 notify("part_one_complete");
		}
	}
}

//Function Number: 61
playfx_and_shatter(param_00)
{
	self endon("death");
	level endon("game_ended");
	playfx(level._effect["crafting_pickup"],self.origin);
	param_00 playlocalsound("part_pickup");
	if(self.model.health < 0)
	{
		self.model.health = 5;
		scripts\cp\_interaction::func_E01A(self,param_00);
		param_00 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
	}
}

//Function Number: 62
removememorystructonconnect(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread removememorystructswhenvalid(param_00,var_01);
	}
}

//Function Number: 63
removememorystructswhenvalid(param_00,param_01)
{
	while(!isdefined(param_01.var_55BB))
	{
		scripts\common\utility::func_136F7();
	}

	scripts\cp\_interaction::func_E01A(param_00,param_01);
	param_01 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_01);
}

//Function Number: 64
setup_backstory_models_hotjoined_player()
{
	if(isdefined(level.quest_one_objects))
	{
		var_00 = level.quest_one_objects;
		foreach(var_03, var_02 in var_00)
		{
			var_02.model showtoplayer(self);
			if(!isdefined(self.quest_one_objects))
			{
				self.quest_one_objects = [];
			}

			self.quest_one_objects[var_03] = var_02;
		}
	}

	if(!isdefined(self.quest_two_objects))
	{
		self.quest_two_objects = [];
	}

	if(!isdefined(self.quest_three_objects))
	{
		self.quest_three_objects = [];
	}

	self.quest_two_objects = level.quest_two_objects;
	self.quest_three_objects = level.quest_three_objects;
}

//Function Number: 65
setup_backstory_models(param_00,param_01)
{
	if(!isdefined(level.quest_two_objects))
	{
		level.quest_two_objects = [];
	}

	if(!isdefined(level.quest_three_objects))
	{
		level.quest_three_objects = [];
	}

	scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(param_00);
	foreach(var_03 in level.players)
	{
		param_00.object_num = 1;
		switch(param_01)
		{
			case "memory_object_three":
				param_00.object_num = 1;
				var_03.attacked_first_object_q2 = 0;
				break;

			case "memory_object_four":
				param_00.object_num = 2;
				break;

			case "memory_object_five":
				param_00.object_num = 1;
				var_03.attacked_first_object_q3 = 0;
				break;

			case "memory_object_six":
				param_00.object_num = 2;
				break;

			default:
				break;
		}

		if(param_01 == "memory_object_three" || param_01 == "memory_object_four")
		{
			level.quest_two_objects[param_00.object_num - 1] = param_00;
		}

		if(param_01 == "memory_object_five" || param_01 == "memory_object_six")
		{
			level.quest_three_objects[param_00.object_num - 1] = param_00;
		}

		if(!isdefined(var_03.quest_two_objects))
		{
			var_03.quest_two_objects = [];
		}

		if(!isdefined(var_03.quest_three_objects))
		{
			var_03.quest_three_objects = [];
		}

		var_03.quest_two_objects[param_00.object_num - 1] = level.quest_two_objects[param_00.object_num - 1];
		var_03.quest_three_objects[param_00.object_num - 1] = level.quest_three_objects[param_00.object_num - 1];
		if(isdefined(level.quest_one_objects))
		{
			var_03.quest_one_objects = level.quest_one_objects;
		}
	}
}

//Function Number: 66
mem_object_hint(param_00,param_01)
{
	return "";
}

//Function Number: 67
mem_object_func(param_00,param_01)
{
}

//Function Number: 68
getcurrentquestfromstruct(param_00,param_01)
{
	if(!isdefined(param_00.script_noteworthy))
	{
		return undefined;
	}

	switch(param_00.script_noteworthy)
	{
		case "memory_object_four":
		case "memory_object_three":
			return "quest_2";

		case "memory_object_six":
		case "memory_object_five":
			return "quest_3";

		default:
			return undefined;
	}

	return undefined;
}

//Function Number: 69
activatememquestmodel(param_00,param_01,param_02)
{
	level notify(param_00.script_noteworthy + "_" + param_01.name);
	level endon(param_00.script_noteworthy + "_" + param_01.name);
	level endon("game_ended");
	param_01 endon("disconnect");
	param_01 endon("last_stand");
	param_02 endon("p_ent_reset");
	if(!isdefined(param_00.model))
	{
		return;
	}

	param_00.model.health = 5;
	param_00.model.maxhealth = 5;
	param_00.model setcandamage(1);
	var_03 = getcurrentquestfromstruct(param_00,param_01);
	for(;;)
	{
		param_00.model waittill("damage",var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		if(!isplayer(var_05))
		{
			continue;
		}

		if(var_05 != param_01)
		{
			continue;
		}

		if(!isdefined(var_03))
		{
			continue;
		}

		if(!var_05 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(var_03 == "quest_2" && !scripts\common\utility::istrue(param_01.quest_active_q2))
		{
			continue;
		}

		if(var_03 == "quest_3" && !scripts\common\utility::istrue(param_01.quest_active_q3))
		{
			continue;
		}

		if(isdefined(var_08) && var_08 != "MOD_MELEE")
		{
			continue;
		}

		if(param_00.object_num == 2 && var_05.objects_array_sequence[var_03].size == 0)
		{
			continue;
		}
		else if(param_00.object_num == 1 && var_05.objects_array_sequence[var_03].size == 0)
		{
			if(var_03 == "quest_2" && !scripts\common\utility::istrue(var_05.attacked_first_object_q2))
			{
				var_05.objects_array_sequence[var_03][0] = param_00;
				param_00.model.var_4CE9 = param_00.model.var_4CE9 + var_04;
				var_05.attacked_first_object_q2 = 1;
				scripts\cp\_interaction::func_E01A(param_00,var_05);
				var_05 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_05);
				var_05 playlocalsound("part_pickup");
			}
			else if(var_03 == "quest_3" && !scripts\common\utility::istrue(var_05.attacked_first_object_q3))
			{
				var_05.objects_array_sequence[var_03][0] = param_00;
				param_00.model.var_4CE9 = param_00.model.var_4CE9 + var_04;
				var_05.attacked_first_object_q3 = 1;
				scripts\cp\_interaction::func_E01A(param_00,var_05);
				var_05 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_05);
				var_05 playlocalsound("part_pickup");
			}
		}

		if(param_00.object_num == 2)
		{
			if((var_03 == "quest_2" && scripts\common\utility::istrue(var_05.attacked_first_object_q2)) || var_03 == "quest_3" && scripts\common\utility::istrue(var_05.attacked_first_object_q3))
			{
				var_05.objects_array_sequence[var_03][1] = param_00;
				param_00.model.var_4CE9 = param_00.model.var_4CE9 + var_04;
				scripts\cp\_interaction::func_E01A(param_00,var_05);
				var_05 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_05);
				var_05 playlocalsound("part_pickup");
			}
		}

		if(var_05.objects_array_sequence[var_03].size == 2)
		{
			var_05 playlocalsound("zmb_ui_earn_tickets");
			if(var_03 == "quest_2")
			{
				var_05 notify("part_two_complete");
			}
			else if(var_03 == "quest_3")
			{
				var_05 notify("part_three_complete");
			}

			foreach(var_0F in var_05.objects_array_sequence[var_03])
			{
				var_0F playfx_and_shatter(var_05);
			}
		}
	}
}

//Function Number: 70
applymemquestattributes(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03.var_134FD))
	{
		return;
	}

	if(!isdefined(param_01.script_noteworthy))
	{
		return;
	}

	switch(param_01.script_noteworthy)
	{
		case "memory_object_three":
			if(param_03.var_134FD == "p1_")
			{
				param_01.playeroffset[param_03.name] = (-2462.58,4604.5,782.219);
				if(scripts\common\utility::istrue(param_03.quest_active_q2))
				{
					param_00 setmodel("cp_disco_memory_quest_newspaper");
				}
				else
				{
					param_00 setmodel("cp_disco_memory_quest_newspaper_nophy");
				}
	
				param_00.origin = (-2462.58,4604.5,782.219);
				param_00.angles = (0,180,0);
			}
			else if(param_03.var_134FD == "p2_")
			{
				param_01.playeroffset[param_03.name] = (-2462.58,4604.5,782.219);
				if(scripts\common\utility::istrue(param_03.quest_active_q2))
				{
					param_00 setmodel("cp_disco_comic_book");
				}
				else
				{
					param_00 setmodel("cp_disco_comic_book_nophy");
				}
	
				param_00.origin = (-2462.58,4604.5,782.219);
				param_00.angles = (0,180,0);
			}
			else if(param_03.var_134FD == "p3_")
			{
				param_01.playeroffset[param_03.name] = (-2459.6,4597.5,783.2);
				if(scripts\common\utility::istrue(param_03.quest_active_q2))
				{
					param_00 setmodel("cp_disco_microphone_quest");
				}
				else
				{
					param_00 setmodel("cp_disco_microphone_nophy");
				}
	
				param_00.origin = (-2459.6,4597.5,783.2);
				param_00.angles = (85,0,0);
			}
			else if(param_03.var_134FD == "p4_")
			{
				param_01.playeroffset[param_03.name] = (-2459.5,4597.5,782.1);
				if(scripts\common\utility::istrue(param_03.quest_active_q2))
				{
					param_00 setmodel("cp_disco_trophy");
				}
				else
				{
					param_00 setmodel("cp_disco_trophy_nophy");
				}
	
				param_00.origin = (-2459.5,4597.5,782.1);
				param_00.angles = (0,0,0);
			}
			break;

		case "memory_object_four":
			if(param_03.var_134FD == "p1_")
			{
				param_01.playeroffset[param_03.name] = (-1215,294.5,956.5);
				if(scripts\common\utility::istrue(param_03.quest_active_q2))
				{
					param_00 setmodel("cp_disco_memory_quest_newspaper");
				}
				else
				{
					param_00 setmodel("cp_disco_memory_quest_newspaper_nophy");
				}
	
				param_00.origin = (-1215,294.5,956.5);
				param_00.angles = (0,317.1,0);
			}
			else if(param_03.var_134FD == "p2_")
			{
				param_01.playeroffset[param_03.name] = (-1215,294.5,956.5);
				if(scripts\common\utility::istrue(param_03.quest_active_q2))
				{
					param_00 setmodel("cp_disco_comic_book");
				}
				else
				{
					param_00 setmodel("cp_disco_comic_book_nophy");
				}
	
				param_00.origin = (-1215,294.5,956.5);
				param_00.angles = (0,317.1,0);
			}
			else if(param_03.var_134FD == "p3_")
			{
				param_01.playeroffset[param_03.name] = (-1215,301.5,957.5);
				if(scripts\common\utility::istrue(param_03.quest_active_q2))
				{
					param_00 setmodel("cp_disco_microphone_quest");
				}
				else
				{
					param_00 setmodel("cp_disco_microphone_nophy");
				}
	
				param_00.origin = (-1215,301.5,957.5);
				param_00.angles = (0,0,-86.6);
			}
			else if(param_03.var_134FD == "p4_")
			{
				param_01.playeroffset[param_03.name] = (-1215,299.5,956.5);
				if(scripts\common\utility::istrue(param_03.quest_active_q2))
				{
					param_00 setmodel("cp_disco_trophy");
				}
				else
				{
					param_00 setmodel("cp_disco_trophy_nophy");
				}
	
				param_00.origin = (-1215,299.5,956.5);
				param_00.angles = (0,90,0);
			}
			break;

		case "memory_object_six":
		case "memory_object_five":
			if(param_03.var_134FD == "p1_")
			{
				if(scripts\common\utility::istrue(param_03.quest_active_q3))
				{
					param_00 setmodel("cp_disco_movie_script_book_04");
				}
				else
				{
					param_00 setmodel("cp_disco_movie_script_book_04_nophy");
				}
			}
			else if(param_03.var_134FD == "p2_")
			{
				if(scripts\common\utility::istrue(param_03.quest_active_q3))
				{
					param_00 setmodel("cp_disco_movie_script_book_02");
				}
				else
				{
					param_00 setmodel("cp_disco_movie_script_book_02_nophy");
				}
			}
			else if(param_03.var_134FD == "p3_")
			{
				if(scripts\common\utility::istrue(param_03.quest_active_q3))
				{
					param_00 setmodel("cp_disco_movie_script_book_03");
				}
				else
				{
					param_00 setmodel("cp_disco_movie_script_book_03_nophy");
				}
			}
			else if(param_03.var_134FD == "p4_")
			{
				if(scripts\common\utility::istrue(param_03.quest_active_q3))
				{
					param_00 setmodel("cp_disco_movie_script_book_01");
				}
				else
				{
					param_00 setmodel("cp_disco_movie_script_book_01_nophy");
				}
			}
			break;
	}

	param_01.model = param_00;
	param_01.model.var_4CE9 = 0;
	thread activatememquestmodel(param_01,param_03,param_00);
}

//Function Number: 71
init_mem3()
{
	level.special_mode_activation_funcs["memory_object_three"] = ::applymemquestattributes;
	level.normal_mode_activation_funcs["memory_object_three"] = ::applymemquestattributes;
	var_00 = scripts\common\utility::getstructarray("memory_object_three","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_backstory_models(var_02,"memory_object_three");
	}
}

//Function Number: 72
init_mem4()
{
	level.special_mode_activation_funcs["memory_object_four"] = ::applymemquestattributes;
	level.normal_mode_activation_funcs["memory_object_four"] = ::applymemquestattributes;
	var_00 = scripts\common\utility::getstructarray("memory_object_four","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_backstory_models(var_02,"memory_object_four");
	}
}

//Function Number: 73
init_mem5()
{
	level.special_mode_activation_funcs["memory_object_five"] = ::applymemquestattributes;
	level.normal_mode_activation_funcs["memory_object_five"] = ::applymemquestattributes;
	var_00 = scripts\common\utility::getstructarray("memory_object_five","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_backstory_models(var_02,"memory_object_five");
	}
}

//Function Number: 74
init_mem6()
{
	level.special_mode_activation_funcs["memory_object_six"] = ::applymemquestattributes;
	level.normal_mode_activation_funcs["memory_object_six"] = ::applymemquestattributes;
	var_00 = scripts\common\utility::getstructarray("memory_object_six","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_backstory_models(var_02,"memory_object_six");
	}
}

//Function Number: 75
init_nunchucks_2()
{
	level.quest_two_objects = [];
	if(!isdefined(level.clock[1]))
	{
		level.clock[1] = undefined;
	}

	foreach(var_01 in scripts\common\utility::getstructarray("clock_2","script_noteworthy"))
	{
		level.clock[1] = var_01;
	}

	foreach(var_04 in level.players)
	{
		var_04.attacked_first_object_q2 = 0;
	}

	if(isdefined(level.clock_interaction_q2))
	{
		scripts\cp\_interaction::func_6214(level.clock_interaction_q2);
	}
}

//Function Number: 76
watch_for_player_disconnect_q2(param_00,param_01,param_02,param_03)
{
	level endon("clock_tick_done_2");
	param_00 endon("objects_reset_q2");
	level endon(param_02);
	param_00 waittill("disconnect");
	foreach(var_05 in param_03)
	{
		if(isdefined(var_05.model))
		{
			var_05.model.health = 5;
			var_05.model.var_4CE9 = 0;
			var_05.model.maxhealth = 5;
		}

		scripts\cp\_interaction::func_175D(var_05,param_00);
		param_00.quest_active_q2 = 0;
		param_00 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
	}

	param_01.clock_owner = undefined;
	param_00.objects_array_sequence["quest_2"] = [];
	param_00 setscriptablepartstate("clockFx","inactive");
	param_00 setscriptablepartstate("scripted_rewind","inactive");
	param_01.clock_active = 0;
	scripts\cp\_interaction::func_6214(param_01);
	param_00 notify("objects_reset_q2");
}

//Function Number: 77
use_nunchucks_object_2(param_00,param_01)
{
	level endon("clock_tick_done_2");
	if(param_01.var_134FD == "p5_")
	{
		playsoundatpos(param_00.origin,"ww_magicbox_laughter");
		return;
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.isrewinding))
	{
		return;
	}

	foreach(var_03 in level.players)
	{
		if(var_03 == param_01)
		{
			if(isdefined(level.clock_interaction) && isdefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_03)
			{
				return;
			}
			else if(isdefined(level.clock_interaction_q3) && isdefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_03)
			{
				return;
			}

			continue;
		}

		if(isdefined(level.clock_interaction_q2) && isdefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_03)
		{
			return;
		}
	}

	if(scripts\common\utility::istrue(param_01.finished_part_two) && getdvar("scr_nunchucks") == "")
	{
		return;
	}

	if(!isdefined(param_01.objects_array_sequence))
	{
		param_01.objects_array_sequence = [];
	}

	if(!isdefined(param_01.objects_array_sequence["quest_2"]))
	{
		param_01.objects_array_sequence["quest_2"] = [];
	}

	param_01 setscriptablepartstate("clockFx","active");
	level thread player_clock_tick_sfx(param_01);
	param_01 thread reset_on_failure_q2(param_01);
	level thread watch_for_player_disconnect_q2(param_01,param_00,"part_2_VO_done",param_01.quest_two_objects);
	level thread watch_for_player_laststand_q2(param_01,param_00,"part_2_VO_done",param_01.quest_two_objects);
	scripts\cp\_interaction::func_E01A(param_00,param_01);
	level.clock_interaction_q2 = param_00;
	param_00.clock_owner = param_01;
	param_00.clock_active = 1;
	param_01.angles_when_using_clock = param_01 getplayerangles();
	param_01 func_E266();
	param_01.var_E4D8 = 0;
	param_01.var_E4C8[param_01.var_E4D8] = param_01 getplayerangles();
	param_01.var_E4D7[param_01.var_E4D8] = param_01.origin;
	param_01.var_E4DA[param_01.var_E4D8] = param_01 getvelocity();
	var_05 = gettime();
	param_01 thread func_DDF2(2);
	param_01 thread watch_for_sequence_trigger(param_01,"2");
	param_01 thread clock_watcher(param_00,var_05,param_01,2);
	param_01 func_E897(2);
	level thread delay_enable_linked_interaction(param_00,30,param_01);
}

//Function Number: 78
watch_for_player_laststand_q2(param_00,param_01,param_02,param_03)
{
	level endon("clock_tick_done_2");
	param_00 endon("objects_reset_q2");
	level endon(param_02);
	param_00 endon("disconnect");
	param_00 waittill("last_stand");
	foreach(var_05 in param_03)
	{
		if(isdefined(var_05.model))
		{
			var_05.model.health = 5;
			var_05.model.var_4CE9 = 0;
			var_05.model.maxhealth = 5;
		}

		foreach(var_07 in level.players)
		{
			var_07.attacked_first_object_q2 = 0;
		}

		param_00.quest_active_q2 = 0;
		scripts\cp\_interaction::func_175D(var_05,param_00);
		param_00 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
	}

	param_01.clock_owner = undefined;
	param_00.objects_array_sequence["quest_2"] = [];
	param_00 setscriptablepartstate("clockFx","inactive");
	param_00 setscriptablepartstate("scripted_rewind","inactive");
	param_01.clock_active = 0;
	scripts\cp\_interaction::func_6214(param_01);
	param_00 notify("objects_reset_q2");
}

//Function Number: 79
reset_on_failure_q2(param_00)
{
	param_00 endon("part_2_VO_done");
	param_00 endon("objects_reset_q2");
	level endon("game_ended");
	self endon("death");
	param_00 endon("part_two_complete");
	param_00 notify("end_reset_thread_for_" + param_00.name + " for quest 2");
	param_00 endon("end_reset_thread_for_" + param_00.name + " for quest 2");
	for(;;)
	{
		level waittill("clock_tick_done_2");
		if(param_00.objects_array_sequence["quest_2"].size != 2)
		{
			foreach(var_02 in param_00.quest_two_objects)
			{
				if(isdefined(var_02.model))
				{
					var_02.model.health = 5;
					var_02.model.var_4CE9 = 0;
					var_02.model.maxhealth = 5;
				}

				param_00.quest_active_q2 = 0;
				scripts\cp\_interaction::func_175D(var_02,param_00);
				param_00 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
			}

			foreach(var_05 in level.players)
			{
				var_05.attacked_first_object_q2 = 0;
			}

			level.clock_interaction_q2.clock_owner = undefined;
			param_00.objects_array_sequence["quest_2"] = [];
			param_00 setscriptablepartstate("clockFx","inactive");
			param_00 setscriptablepartstate("scripted_rewind","inactive");
			level.clock_interaction_q2.clock_active = 0;
			if(isdefined(param_00.rewindmover))
			{
				param_00 thread reset_rewind_mover(2);
			}

			param_00.quest_num = undefined;
			param_00 notify("objects_reset_q2");
		}
	}
}

//Function Number: 80
watch_for_damage_on_struct_q2(param_00)
{
	param_00 endon("part_two_complete");
	param_00 endon("objects_reset_q2");
	param_00 endon("delete_previous_thread");
	for(;;)
	{
		self.model waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!isplayer(var_02) && !isagent(var_02))
		{
			continue;
		}

		if(isdefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner != var_02)
		{
			continue;
		}

		if(!scripts\common\utility::istrue(var_02.quest_active))
		{
			continue;
		}

		if(isdefined(var_05) && var_05 != "MOD_MELEE")
		{
			continue;
		}

		if(self.object_num == 2 && var_02.objects_array_sequence["quest_2"].size == 0)
		{
			continue;
		}
		else if(!scripts\common\utility::istrue(var_02.attacked_first_object_q2) && self.object_num == 1 && var_02.objects_array_sequence["part2"].size == 0)
		{
			var_02.objects_array_sequence["quest_2"][self.object_num - 1] = self;
			self.model.var_4CE9 = self.model.var_4CE9 + var_01;
			var_02.attacked_first_object_q2 = 1;
			scripts\cp\_interaction::func_E01A(self,var_02);
			var_02 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_02);
			var_02 playlocalsound("part_pickup");
		}

		if(self.object_num == 2 && scripts\common\utility::istrue(var_02.attacked_first_object_q2))
		{
			var_02.objects_array_sequence["quest_2"][self.object_num - 1] = self;
			self.model.var_4CE9 = self.model.var_4CE9 + var_01;
			scripts\cp\_interaction::func_E01A(self,var_02);
			var_02 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_02);
			var_02 playlocalsound("part_pickup");
		}

		if(var_02.objects_array_sequence["quest_2"].size == 2)
		{
			foreach(var_0C in var_02.objects_array_sequence["quest_2"])
			{
				var_0C playfx_and_shatter(var_02);
			}

			var_02 playlocalsound("zmb_ui_earn_tickets");
			var_02 notify("part_two_complete");
		}
	}
}

//Function Number: 81
init_nunchucks_3()
{
	level.quest_three_objects = [];
	if(!isdefined(level.clock[2]))
	{
		level.clock[2] = undefined;
	}

	foreach(var_01 in scripts\common\utility::getstructarray("clock_3","script_noteworthy"))
	{
		level.clock[2] = var_01;
	}

	foreach(var_04 in level.players)
	{
		var_04.attacked_first_object_q3 = 0;
	}

	if(isdefined(level.clock_interaction_q3))
	{
		scripts\cp\_interaction::func_6214(level.clock_interaction_q3);
	}
}

//Function Number: 82
watch_for_player_disconnect_q3(param_00,param_01,param_02,param_03)
{
	level endon("clock_tick_done_3");
	param_00 endon("objects_reset_q3");
	level endon(param_02);
	param_00 waittill("disconnect");
	foreach(var_05 in param_03)
	{
		if(isdefined(var_05.model))
		{
			var_05.model.health = 5;
			var_05.model.var_4CE9 = 0;
			var_05.model.maxhealth = 5;
		}

		param_00.quest_active_q3 = 0;
		scripts\cp\_interaction::func_175D(var_05,param_00);
		param_00 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
	}

	param_01.clock_owner = undefined;
	param_00.objects_array_sequence["quest_3"] = [];
	param_00 setscriptablepartstate("clockFx","inactive");
	param_00 setscriptablepartstate("scripted_rewind","inactive");
	param_01.clock_active = 0;
	scripts\cp\_interaction::func_6214(param_01);
	param_00 notify("objects_reset_q3");
}

//Function Number: 83
use_nunchucks_object_3(param_00,param_01)
{
	level endon("clock_tick_done_3");
	if(param_01.var_134FD == "p5_")
	{
		playsoundatpos(param_00.origin,"ww_magicbox_laughter");
		return;
	}

	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.isrewinding))
	{
		return;
	}

	foreach(var_03 in level.players)
	{
		if(var_03 == param_01)
		{
			if(isdefined(level.clock_interaction) && isdefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_03)
			{
				return;
			}
			else if(isdefined(level.clock_interaction_q2) && isdefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_03)
			{
				return;
			}

			continue;
		}

		if(isdefined(level.clock_interaction_q3) && isdefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_03)
		{
			return;
		}
	}

	if(scripts\common\utility::istrue(param_01.finished_part_three) && getdvar("scr_nunchucks") == "")
	{
		return;
	}

	if(!isdefined(param_01.objects_array_sequence))
	{
		param_01.objects_array_sequence = [];
	}

	if(!isdefined(param_01.objects_array_sequence["quest_3"]))
	{
		param_01.objects_array_sequence["quest_3"] = [];
	}

	param_01 setscriptablepartstate("clockFx","active");
	level thread player_clock_tick_sfx(param_01);
	param_01 thread reset_on_failure_q3(param_01);
	level thread watch_for_player_disconnect_q3(param_01,param_00,"part_3_VO_done",param_01.quest_three_objects);
	level thread watch_for_player_laststand_q3(param_01,param_00,"part_3_VO_done",param_01.quest_three_objects);
	scripts\cp\_interaction::func_E01A(param_00,param_01);
	level.clock_interaction_q3 = param_00;
	param_00.clock_owner = param_01;
	param_00.clock_active = 1;
	param_01.angles_when_using_clock = param_01 getplayerangles();
	param_01 func_E266();
	param_01.var_E4D8 = 0;
	param_01.var_E4C8[param_01.var_E4D8] = param_01 getplayerangles();
	param_01.var_E4D7[param_01.var_E4D8] = param_01.origin;
	param_01.var_E4DA[param_01.var_E4D8] = param_01 getvelocity();
	var_05 = gettime();
	param_01 thread func_DDF2(3);
	param_01 thread watch_for_sequence_trigger(param_01,"3");
	param_01 thread clock_watcher(param_00,var_05,param_01,3);
	param_01 func_E897(3);
	level thread delay_enable_linked_interaction(param_00,30,param_01);
}

//Function Number: 84
watch_for_player_laststand_q3(param_00,param_01,param_02,param_03)
{
	level endon("clock_tick_done_3");
	param_00 endon("objects_reset_q3");
	level endon(param_02);
	param_00 endon("disconnect");
	param_00 waittill("last_stand");
	foreach(var_05 in param_03)
	{
		if(isdefined(var_05.model))
		{
			var_05.model.health = 5;
			var_05.model.var_4CE9 = 0;
			var_05.model.maxhealth = 5;
		}

		foreach(var_07 in level.players)
		{
			var_07.attacked_first_object_q3 = 0;
		}

		param_00.quest_active_q3 = 0;
		scripts\cp\_interaction::func_175D(var_05,param_00);
		param_00 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
	}

	param_01.clock_owner = undefined;
	param_00.objects_array_sequence["quest_3"] = [];
	param_01.clock_active = 0;
	scripts\cp\_interaction::func_6214(param_01);
	param_00 notify("objects_reset_q3");
}

//Function Number: 85
reset_on_failure_q3(param_00)
{
	param_00 endon("objects_reset_q3");
	level endon("game_ended");
	self endon("death");
	param_00 endon("part_3_VO_done");
	param_00 endon("part_three_complete");
	param_00 notify("end_reset_thread_for_" + param_00.name + " for quest 3");
	param_00 endon("end_reset_thread_for_" + param_00.name + " for quest 3");
	for(;;)
	{
		level waittill("clock_tick_done_3");
		if(param_00.objects_array_sequence["quest_3"].size != 2)
		{
			foreach(var_02 in param_00.quest_three_objects)
			{
				if(isdefined(var_02.model))
				{
					var_02.model.health = 5;
					var_02.model.var_4CE9 = 0;
					var_02.model.maxhealth = 5;
				}

				param_00.quest_active_q3 = 0;
				scripts\cp\_interaction::func_175D(var_02,param_00);
				param_00 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(param_00);
			}

			foreach(var_05 in level.players)
			{
				var_05.attacked_first_object_q3 = 0;
			}

			level.clock_interaction_q3.clock_owner = undefined;
			param_00.objects_array_sequence["quest_3"] = [];
			param_00 setscriptablepartstate("clockFx","inactive");
			param_00 setscriptablepartstate("scripted_rewind","inactive");
			level.clock_interaction_q3.clock_active = 0;
			if(isdefined(param_00.rewindmover))
			{
				param_00 thread reset_rewind_mover(3);
			}

			param_00.quest_num = undefined;
			param_00 notify("objects_reset_q3");
		}
	}
}

//Function Number: 86
watch_for_damage_on_struct_q3(param_00)
{
	param_00 endon("part_three_complete");
	param_00 endon("objects_reset_q3");
	param_00 endon("delete_previous_thread");
	thread reset_on_failure_q3(param_00);
	for(;;)
	{
		self.model waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!isplayer(var_02) && !isagent(var_02))
		{
			continue;
		}

		if(isdefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner != var_02)
		{
			continue;
		}

		if(isdefined(var_05) && var_05 != "MOD_MELEE")
		{
			continue;
		}

		if(self.object_num == 2 && var_02.objects_array_sequence["quest_3"].size == 0)
		{
			continue;
		}
		else if(!scripts\common\utility::istrue(var_02.attacked_first_object_q3) && self.object_num == 1 && var_02.objects_array_sequence["part3"].size == 0)
		{
			var_02.objects_array_sequence["quest_3"][self.object_num - 1] = self;
			self.model.var_4CE9 = self.model.var_4CE9 + var_01;
			var_02.attacked_first_object_q3 = 1;
			scripts\cp\_interaction::func_E01A(self,var_02);
			var_02 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_02);
			var_02 playlocalsound("part_pickup");
		}

		if(self.object_num == 2 && scripts\common\utility::istrue(var_02.attacked_first_object_q3))
		{
			var_02.objects_array_sequence["quest_3"][self.object_num - 1] = self;
			self.model.var_4CE9 = self.model.var_4CE9 + var_01;
			var_02.attacked_first_object_q3 = 1;
			scripts\cp\_interaction::func_E01A(self,var_02);
			var_02 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_02);
			var_02 playlocalsound("part_pickup");
		}

		if(var_02.objects_array_sequence["quest_3"].size == 2)
		{
			foreach(var_0C in var_02.objects_array_sequence["quest_3"])
			{
				var_0C playfx_and_shatter(var_02);
			}

			var_02 playlocalsound("zmb_ui_earn_tickets");
			var_02 notify("part_three_complete");
		}
	}
}

//Function Number: 87
disco_wait_for_interaction_triggered(param_00)
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
				else if(scripts\cp\maps\cp_disco\cp_disco_weapon_upgrade::func_385F(var_03,1))
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
					scripts\cp\_interaction::func_9A3C(param_00,&"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
					wait(0.1);
					continue;
				}
			}
			else if(scripts\common\utility::istrue(level.has_picked_up_fuses) && !isdefined(level.placed_alien_fuses))
			{
				var_02 = 0;
			}
			else if(var_04 == level.var_C8A4)
			{
				scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_UPGRADE_MAXED");
				wait(0.1);
				continue;
			}
			else if(scripts\cp\maps\cp_disco\cp_disco_weapon_upgrade::func_385F(var_03))
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
				scripts\cp\_interaction::func_9A3C(param_00,&"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
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
			var_07 = issubstr(param_00.script_noteworthy,"katana");
			if(var_07 && !scripts\common\utility::istrue(var_01.has_disco_soul_key) && !scripts\common\utility::flag("rk_fight_ended"))
			{
				wait(0.1);
				continue;
			}

			if(scripts\cp\_weapon::func_8BBB(param_00.script_noteworthy))
			{
				if(var_07 && !scripts\common\utility::istrue(var_01.has_disco_soul_key))
				{
					wait(0.1);
					continue;
				}

				if(!scripts\cp\_interaction::func_383D(param_00.script_noteworthy) || var_07)
				{
					if(!var_07)
					{
						scripts\cp\_interaction::func_9A3C(param_00,&"COOP_GAME_PLAY_AMMO_MAX");
					}

					wait(0.1);
					continue;
				}
				else
				{
					var_08 = scripts\cp\_utility::func_80D8(param_00.script_noteworthy);
					var_04 = scripts\cp\_weapon::func_7D62(var_08);
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
			else if(var_07 && scripts\common\utility::flag("rk_fight_ended"))
			{
				var_02 = 0;
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

		var_09 = level.interactions[param_00.script_noteworthy].var_109DA;
		thread scripts\cp\_interaction::func_11449(var_02,var_09);
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

//Function Number: 88
get_closest_interaction_struct(param_00)
{
	var_01 = undefined;
	var_02 = 0;
	foreach(var_04 in level.current_interaction_structs)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		var_05 = distancesquared(param_00,var_04.origin);
		if(!isdefined(var_01) || var_05 < var_02)
		{
			if(scripts\common\utility::func_2286(self.var_55BB,var_04))
			{
				continue;
			}

			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 89
disco_player_interaction_monitor()
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
		var_05 = get_closest_interaction_struct(self.origin);
		if(!isdefined(var_05))
		{
			wait(0.1);
			continue;
		}

		if(scripts\common\utility::istrue(self.var_50BC))
		{
			wait(0.1);
			continue;
		}

		if(scripts\cp\_interaction::func_9A2B(var_05) && distancesquared(var_05.origin,self.origin) < var_02)
		{
			var_04 = var_05;
		}

		if(!isdefined(var_04) && !scripts\cp\_interaction::func_9A2B(var_05) && distancesquared(var_05.origin,self.origin) <= var_00)
		{
			var_04 = var_05;
		}

		if(isdefined(var_04) && scripts\cp\_interaction::func_9A18(var_04) || scripts\cp\_interaction::interaction_is_chi_door(var_04) && !scripts\cp\_interaction::func_9A22(var_04))
		{
			var_04 = undefined;
		}

		if(!isdefined(var_04) && isdefined(level.should_allow_far_search_dist_func))
		{
			if(distancesquared(var_05.origin,self.origin) <= var_01)
			{
				var_04 = var_05;
			}

			if(isdefined(var_04) && ![[ level.should_allow_far_search_dist_func ]](var_04))
			{
				var_04 = undefined;
			}
		}
		else if(!isdefined(var_04) && isdefined(var_05.var_4C72))
		{
			if(distance(var_05.origin,self.origin) <= var_05.var_4C72)
			{
				var_04 = var_05;
			}
		}

		if(!isdefined(var_04))
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
			var_06 = scripts\cp\_utility::func_78B4(var_04.origin);
			if(!isdefined(var_06))
			{
				self.var_A8D3 = undefined;
				wait(0.05);
				continue;
			}

			if(scripts\cp\_utility::func_664F(var_06))
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

//Function Number: 90
func_DDF2(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("remove_rewind_ability");
	self endon("clocks_reset");
	var_01 = 0;
	var_02 = 0;
	switch(param_00)
	{
		case 1:
			var_01 = 7;
			var_02 = 2.9166;
			break;

		case 2:
			var_01 = 11.45;
			var_02 = 2;
			break;

		case 3:
			var_01 = 8.25;
			var_02 = 3.416;
			break;

		case 4:
			var_01 = 19;
			var_02 = 4;
			break;
	}

	var_03 = self.origin;
	var_04 = var_01 / var_02 * 0.05;
	var_05 = var_01 / var_04;
	for(;;)
	{
		wait(var_04);
		if(scripts\common\utility::istrue(self.isrewinding))
		{
			self waittill("rewind_power_finished");
			wait(2);
			self notify("remove_rewind_ability");
		}

		if(distance2dsquared(self.origin,var_03) < 484)
		{
			continue;
		}

		var_03 = self.origin;
		if(self.var_E4D7.size < int(var_05))
		{
			func_DDF1(self.var_E4D7.size);
			continue;
		}

		func_41DD(self.var_E4D8);
		var_06 = self.var_E4D8 + int(var_05);
		func_DDF1(var_06);
		self.var_E4D8++;
	}
}

//Function Number: 91
func_1397(param_00,param_01,param_02)
{
	var_03 = 0.05;
	var_04 = float(gettime()) / 1000;
	var_05 = var_04 + param_02;
	if(param_02 <= 0)
	{
		return;
	}

	param_00.angles = self.angles_when_using_clock;
	if(!isdefined(param_00))
	{
		return;
	}

	var_06 = self getplayerangles();
	param_00.angles = self.angles_when_using_clock;
	self setworldupreference(param_00);
	self setplayerangles((0,0,0));
	self setworldupreferenceangles(var_06,0);
	while(var_04 < var_05)
	{
		var_07 = cos(var_05 - var_04 / param_02 * 90);
		param_00.angles = function_02EC(var_06,param_01,var_07);
		wait(var_03);
		var_04 = float(gettime()) / 1000;
	}

	param_00.angles = param_01;
	var_06 = self getplayerangles();
	self setworldupreference(undefined);
	self setplayerangles((0,0,0));
	self setworldupreferenceangles(var_06,0);
}

//Function Number: 92
func_E897(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("backstory_quest_complete");
	self endon("part_1_VO_done");
	self endon("part_2_VO_done");
	self endon("part_3_VO_done");
	self endon("part_two_complete");
	self endon("part_three_complete");
	self endon("last_stand");
	self endon("death");
	self endon("rat_king_fight_started");
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = "quest_rewind_sound_long";
	switch(param_00)
	{
		case 1:
			var_01 = 7;
			var_02 = 7;
			var_03 = 2.9166;
			var_04 = "quest_rewind_sound_short";
			break;

		case 2:
			var_01 = 11.45;
			var_02 = 11.45;
			var_03 = 2;
			var_04 = "quest_rewind_sound_med";
			break;

		case 3:
			var_01 = 8.25;
			var_02 = 8.25;
			var_03 = 3.416;
			var_04 = "quest_rewind_sound_med";
			break;

		case 4:
			var_01 = 19;
			var_02 = 19;
			var_03 = 4;
			var_04 = "quest_rewind_sound_long";
			break;
	}

	wait(var_01 - 0.2);
	self playlocalsound(var_04);
	wait(0.2);
	self.quest_num = param_00;
	if(self.var_E4D7.size <= 0)
	{
		return;
	}

	self notify("rewind_activated");
	self setscriptablepartstate("scripted_rewind","active");
	self.angles_when_using_clock = self getplayerangles();
	scripts\common\utility::func_136F7();
	self cancelmantle();
	self method_83AB();
	self setscriptablepartstate("screen_effects","kung_fu_punch");
	self.isrewinding = 1;
	self method_84D8(1);
	var_05 = (0,0,0);
	if(isdefined(level.clock[int(param_00) - 1]) && param_00 != 4)
	{
		var_05 = level.clock[int(param_00) - 1].origin;
	}
	else if(param_00 == 4)
	{
		var_05 = self.var_E4D7[self.var_E4D8];
	}

	var_06 = self.var_E4C8[self.var_E4D8];
	var_07 = self.var_E4DA[self.var_E4D8];
	scripts\cp\_utility::func_17C0("rewind_invulnerability",0,0);
	self.rewindmover = spawn("script_model",self geteye());
	self.rewindmover setmodel("tag_origin");
	self.rewindmover.angles = self getplayerangles();
	self.rewindmover method_8429(self);
	self.rewindmover notsolid();
	self playerlinkto(self.rewindmover,"tag_origin",0,10,10,10,10,0);
	self method_8232();
	scripts\common\utility::func_1C53(0);
	scripts\common\utility::allow_weapon(0);
	scripts\common\utility::func_1C76(0);
	scripts\common\utility::func_1C6E(0);
	scripts\cp\_utility::allow_player_teleport(0);
	scripts\common\utility::allow_jump(0);
	self allowprone(0);
	self limitedmovement(1);
	self.flung = 1;
	scripts\common\utility::func_136F7();
	self playanimscriptevent("power_active","rewind");
	var_08 = var_02 / var_03 * 0.05;
	var_09 = var_02 / var_08;
	var_0A = var_03 / var_09;
	self method_81DF(var_03,var_0A,0,0,0,0,0);
	thread play_fx_rewind(var_03);
	for(var_0B = self.var_E4D7.size - 1;var_0B >= 0;var_0B--)
	{
		var_0C = self.var_E4D7[var_0B];
		var_0D = var_0B + self.var_E4D8;
		var_0E = self.var_E4D7[var_0D];
		var_0F = self.var_E4C8[var_0D];
		scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
		thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(var_0A);
		if(!isdefined(var_0E))
		{
			var_0E = self.var_E4D7[self.var_E4D7.size - 1];
		}

		if(isdefined(var_0C))
		{
			self.rewindmover.origin = vectorlerp(var_0C,var_0E,0.05);
		}
		else
		{
			self.rewindmover.origin = var_0E;
		}

		wait(var_0A);
	}

	thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(self);
	func_4485(self.rewindmover,var_05,var_06,var_07,param_00);
}

//Function Number: 93
play_fx_rewind(param_00)
{
	self shellshock("default_nosound",param_00);
}

//Function Number: 94
return_player_to_clock(param_00,param_01)
{
	while(isdefined(param_00.rewindmover))
	{
		wait(0.1);
	}

	var_02 = 2;
	switch(param_01)
	{
		case 1:
			var_03 = 7;
			var_04 = 7;
			var_02 = 2.9166;
			break;

		case 2:
			var_03 = 11.45;
			var_04 = 11.45;
			var_02 = 2;
			break;

		case 3:
			var_03 = 8.25;
			var_04 = 8.25;
			var_02 = 3.416;
			break;

		case 4:
			var_03 = 19;
			var_04 = 19;
			var_02 = 4;
			break;
	}

	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	var_05 = level.clock[param_01 - 1].origin;
	var_06 = level.clock[param_01 - 1].angles;
	var_07 = (0,0,0);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.05);
	param_00 thread play_fx_rewind(var_02);
	if(isdefined(param_00.rewindmover))
	{
		param_00 func_4485(param_00.rewindmover,var_05,var_06,var_07,param_01);
		return;
	}

	var_08 = vectorlerp(param_00.origin,var_05,0.05);
	var_09 = getclosestpointonnavmesh(var_05);
	param_00 setorigin(var_09,0);
	param_00 setvelocity(var_07);
	param_00 setstance("stand");
	param_00 setscriptablepartstate("scripted_rewind","inactive");
}

//Function Number: 95
func_DDF1(param_00)
{
	self.var_E4D7[param_00] = self.origin;
	self.var_E4C8[param_00] = self getplayerangles();
	self.var_E4DA[param_00] = self getvelocity();
}

//Function Number: 96
func_41DD(param_00)
{
	self.var_E4D7[param_00] = undefined;
	self.var_E4C8[param_00] = undefined;
	self.var_E4DA[param_00] = undefined;
}

//Function Number: 97
func_E266()
{
	self.var_E4D7 = [];
	self.var_E4C8 = [];
	self.var_E4DA = [];
	self.var_E4D8 = 0;
}

//Function Number: 98
func_4485(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = vectorlerp(param_00.origin,param_01,0.05);
	self setorigin(var_05,0);
	self setvelocity(param_03);
	self setstance("stand");
	scripts\common\utility::func_136F7();
	param_00 solid();
	if(!scripts\common\utility::func_A009())
	{
		scripts\common\utility::func_1C76(1);
	}

	if(!scripts\common\utility::func_9FBE())
	{
		scripts\common\utility::func_1C6E(1);
	}

	if(!scripts\cp\_utility::isteleportenabled())
	{
		scripts\cp\_utility::allow_player_teleport(1);
	}

	scripts\cp\_utility::func_E0E6("rewind_invulnerability",0);
	self playanimscriptevent("power_exit","rewind");
	self method_8447();
	self method_84D8(0);
	scripts\common\utility::func_1C53(1);
	scripts\common\utility::allow_weapon(1);
	scripts\common\utility::allow_jump(1);
	self allowprone(1);
	self limitedmovement(0);
	self unlink();
	self.flung = undefined;
	self.rewindmover delete();
	self setscriptablepartstate("scripted_rewind","inactive");
	self notify("rewind_power_finished");
	if(isdefined(self.clocks_destroyed))
	{
		self.clocks_destroyed = 0;
	}

	self.isrewinding = 0;
	self.quest_num = undefined;
}

//Function Number: 99
func_E2EB()
{
	if(scripts\common\utility::istrue(self.var_E4D9))
	{
		return;
	}

	self.var_E4D9 = 1;
	scripts\common\utility::func_1C76(0);
	scripts\common\utility::func_1C6E(0);
	scripts\cp\_utility::allow_player_teleport(0);
	thread func_E2EC();
}

//Function Number: 100
func_E2DC()
{
	if(!scripts\common\utility::istrue(self.var_E4D9))
	{
		return;
	}

	self.var_E4D9 = undefined;
	if(!scripts\common\utility::func_A009())
	{
		scripts\common\utility::func_1C76(1);
	}

	if(!scripts\common\utility::func_9FBE())
	{
		scripts\common\utility::func_1C6E(1);
	}

	if(!scripts\cp\_utility::isteleportenabled())
	{
		scripts\cp\_utility::allow_player_teleport(1);
	}
}

//Function Number: 101
func_E2EC()
{
	self endon("disconnect");
	self endon("rewindUnset");
	self notify("rewindRestrictFunctionalityCleanup");
	self endon("rewindRestrictFunctionalityCleanup");
	self waittill("death");
	self.var_E4D9 = undefined;
}

//Function Number: 102
rotate_fans()
{
	level endon("stop_waterfall_trap");
	level.center_sewer_fan rotateyaw(7200,28,2,5);
	foreach(var_01 in level.sewer_fans)
	{
		var_01 rotateyaw(14400,28,randomintrange(1,4),5);
	}
}

//Function Number: 103
rotate_center_fan()
{
	for(;;)
	{
		if(isdefined(level.fan_trap_active))
		{
			wait(0.1);
			continue;
		}
		else
		{
			level.center_sewer_fan rotateyaw(15,1);
		}

		wait(1);
	}
}

//Function Number: 104
init_fan_trap()
{
	level.sewer_fans = getentarray("sewer_fans","targetname");
	level.center_sewer_fan = getent("center_fan","targetname");
	level.sewer_fan_interactions = scripts\common\utility::getstructarray("fan_trap","script_noteworthy");
	level.sewer_fan_switches = getentarray(level.sewer_fan_interactions[0].target,"targetname");
	level.lower_sewer_phys_vol = getent("lower_sewer_phys_vol","targetname");
	level.upper_sewer_phys_vol = getent("upper_sewer_phys_vol","targetname");
	level.lower_sewer_phys_point = scripts\common\utility::getstruct(level.lower_sewer_phys_vol.target,"targetname");
	level.sewer_fan_trig = spawn("trigger_radius",(-882.5,1846,151.5),0,585,96);
	foreach(var_01 in level.sewer_fan_interactions)
	{
		var_01 thread sewer_fan_power_handler();
	}

	level thread rotate_center_fan();
}

//Function Number: 105
sewer_fan_power_handler()
{
	level scripts\common\utility::waittill_any_3("power_on",self.var_D71C + " power_on");
	self.var_D776 = 1;
	foreach(var_01 in level.sewer_fan_switches)
	{
		var_01 setmodel("mp_frag_button_on_green");
	}
}

//Function Number: 106
init_electric_trap()
{
	scripts\common\utility::flag_init("rooftop_walkway_open");
	var_00 = scripts\common\utility::getstructarray("electric_trap","script_noteworthy");
	foreach(var_02 in var_00)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
	}

	wait(10);
	for(;;)
	{
		if(scripts\common\utility::istrue(level.var_10816["punk_street"].var_19) && scripts\common\utility::istrue(level.var_10816["rooftops_1"].var_19))
		{
			break;
		}

		wait(1);
	}

	scripts\common\utility::flag_set("rooftop_walkway_open");
	foreach(var_02 in var_00)
	{
		scripts\cp\_interaction::add_to_current_interaction_list(var_02);
	}
}

//Function Number: 107
func_12FE5(param_00,param_01)
{
	level thread electric_trap_fx();
	param_01 thread scripts\cp\_vo::try_to_play_vo("activate_trap_generic","zmb_comment_vo","low",10,0,1,0,40);
	level thread scripts\cp\_interaction::func_9A0D(param_00,115);
	level thread func_6015(param_00,param_01);
	wait(25);
	level notify("stop_electric_trap");
}

//Function Number: 108
electric_trap_fx()
{
	scripts\common\utility::exploder(120);
	playsoundatpos((-380,532,961),"disco_gen_electric_trap_power_up");
	wait(1.3);
	var_00 = scripts\common\utility::play_loopsound_in_space("disco_gen_electric_trap_lp",(-380,532,961));
	wait(0.05);
	var_01 = scripts\common\utility::play_loopsound_in_space("disco_trap_electric_on_lp",(-485,463,962));
	level waittill("stop_electric_trap");
	playsoundatpos((-380,532,961),"disco_gen_electric_trap_power_down");
	wait(0.25);
	var_00 stoploopsound();
	var_01 stoploopsound();
	var_00 delete();
	var_01 delete();
}

//Function Number: 109
func_6015(param_00,param_01)
{
	level endon("stop_electric_trap");
	var_02 = gettime();
	var_03 = getent(param_00.target,"targetname");
	for(;;)
	{
		var_03 waittill("trigger",var_04);
		if(isplayer(var_04) && isalive(var_04) && !scripts\cp\_laststand::player_in_laststand(var_04) && !isdefined(var_04.var_C85F))
		{
			playsoundatpos(var_04.origin,"trap_electric_shock");
			playfxontagforclients(level._effect["electric_shock_plyr"],var_04,"tag_eye",var_04);
			var_04.var_C85F = 1;
			var_04 dodamage(20,var_04.origin);
			var_04 thread func_E069();
			continue;
		}

		if(scripts\common\utility::istrue(var_04.var_9CEF) || !scripts\cp\_utility::func_FF18(var_04,0,1))
		{
			continue;
		}

		if(var_04.agent_type == "ratking")
		{
			continue;
		}

		if(gettime() > var_02 + 1000)
		{
			playsoundatpos(var_04.origin,"trap_electric_shock");
			var_02 = gettime();
		}

		level thread func_601A(var_04,param_01);
		var_05 = ["kill_trap_generic","trap_kill_elecfence"];
		param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_05),"zmb_comment_vo","highest",10,0,0,1,25);
	}
}

//Function Number: 110
func_601A(param_00,param_01)
{
	param_00 endon("death");
	wait(randomfloat(2));
	param_00.dontmutilate = 1;
	param_00.electrocuted = 1;
	param_00 setscriptablepartstate("electrocuted","on");
	if(param_01 scripts\cp\_utility::is_valid_player(1))
	{
		var_02 = param_01;
	}
	else
	{
		var_02 = undefined;
	}

	param_00 dodamage(param_00.health + 100,param_00.origin,var_02,var_02,"MOD_UNKNOWN","iw7_electrictrap_zm");
}

//Function Number: 111
func_E069()
{
	self endon("disconnect");
	wait(0.5);
	self.var_C85F = undefined;
}

//Function Number: 112
use_fan_trap(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_00.var_D776))
	{
		return;
	}

	scripts\cp\_interaction::func_554F(param_00);
	level thread fan_trap_sfx();
	foreach(var_03 in level.sewer_fan_switches)
	{
		var_03 setmodel("mp_frag_button_on");
	}

	param_00.var_126A4 = 0;
	param_01 thread scripts\cp\_vo::try_to_play_vo("activate_trap_generic","zmb_comment_vo","low",10,0,1,0,40);
	var_05 = gettime() + 2000;
	playrumbleonposition("light_3s",level.center_sewer_fan.origin + (0,0,50));
	while(gettime() < var_05)
	{
		earthquake(0.2,2,param_00.origin + (0,0,100),500);
		wait(0.5);
		playrumbleonposition("light_3s",level.center_sewer_fan.origin + (0,0,-50));
		wait(0.5);
	}

	level thread rotate_fans();
	level.fan_trap_active = 1;
	scripts\common\utility::exploder(49);
	level.upper_sewer_phys_vol method_852B(1,anglestoforward((-90,0,0)),5000);
	level.upper_sewer_phys_vol method_8529(1);
	level.upper_sewer_phys_vol method_8526(1);
	level.lower_sewer_phys_vol method_852C(1,level.lower_sewer_phys_point.origin,2500);
	level.lower_sewer_phys_vol method_8529(1);
	level.lower_sewer_phys_vol method_8526(1);
	level thread func_A631(param_00,param_01);
	var_05 = gettime() + 25000;
	while(gettime() < var_05)
	{
		playrumbleonposition("heavy_3s",level.center_sewer_fan.origin + (0,0,50));
		earthquake(0.2,3,level.center_sewer_fan.origin + (0,0,-100),500);
		wait(1);
	}

	level notify("stop_waterfall_trap");
	level.fan_trap_active = undefined;
	level.upper_sewer_phys_vol method_8529(0);
	level.upper_sewer_phys_vol method_8526(0);
	level.lower_sewer_phys_vol method_8529(0);
	level.lower_sewer_phys_vol method_8526(0);
	scripts\cp\_interaction::func_6214(param_00);
	scripts\cp\_interaction::func_9A0D(param_00,300);
	foreach(var_03 in level.sewer_fan_switches)
	{
		var_03 setmodel("mp_frag_button_on_green");
	}
}

//Function Number: 113
fan_trap_sfx()
{
	playsoundatpos((-920,1832,450),"giant_fan_startup_lr");
	var_00 = scripts\common\utility::play_loopsound_in_space("giant_fan_grate_impacts_lp",(-920,1832,450));
	wait(0.85);
	var_01 = scripts\common\utility::play_loopsound_in_space("giant_fan_lp_lr",(-920,1832,450));
	var_02 = scripts\common\utility::play_loopsound_in_space("giant_fan_wind_paper_01",(-1295,1662,234));
	var_03 = scripts\common\utility::play_loopsound_in_space("giant_fan_wind_paper_02",(-438,1644,234));
	var_04 = scripts\common\utility::play_loopsound_in_space("giant_fan_wind_paper_03",(-879,2349,234));
	level waittill("stop_waterfall_trap");
	playsoundatpos((-920,1832,450),"giant_fan_stop_lr");
	var_00 stoploopsound();
	var_00 delete();
	wait(0.1);
	var_01 stoploopsound();
	var_01 delete();
	wait(0.15);
	var_02 stoploopsound();
	var_02 delete();
	wait(0.2);
	var_03 stoploopsound();
	var_03 delete();
	wait(0.13);
	var_04 stoploopsound();
	var_04 delete();
}

//Function Number: 114
waterfall_trap_sfx()
{
	wait(0.65);
	playsoundatpos((-1714,-2031,248),"trap_waterfall_start");
	var_00 = scripts\common\utility::play_loopsound_in_space("trap_waterfall_rushing_lp",(-1717,-2013,189));
	wait(4);
	var_01 = scripts\common\utility::play_loopsound_in_space("trap_waterfall_splashing_lp",(-1702,-1824,101));
	level waittill("stop_waterfall_trap");
	playsoundatpos((-1714,-2031,248),"trap_waterfall_end");
	wait(0.2);
	var_00 stoploopsound();
	var_00 delete();
	var_01 stoploopsound();
	var_01 delete();
}

//Function Number: 115
func_A631(param_00,param_01)
{
	level endon("stop_waterfall_trap");
	for(;;)
	{
		level.sewer_fan_trig waittill("trigger",var_02);
		if(!scripts\cp\_utility::func_FF18(var_02,undefined,1))
		{
			continue;
		}

		param_00.var_126A4++;
		var_03 = ["kill_trap_generic","trap_kill_fanblade"];
		param_01 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_03),"zmb_comment_vo","high",10,0,0,1,25);
		var_02 thread func_6F32(param_00,param_01);
	}
}

//Function Number: 116
func_6F32(param_00,param_01)
{
	self endon("death");
	self.flung = 1;
	self.var_B36E = 1;
	self.do_immediate_ragdoll = 1;
	self.var_4C87 = 1;
	self.disable_armor = 1;
	wait(randomfloatrange(0.5,1.5));
	if(param_01 scripts\cp\_utility::is_valid_player())
	{
		var_02 = param_01;
	}
	else
	{
		var_02 = undefined;
	}

	self.dontmutilate = 1;
	self dodamage(self.health + 100,level.sewer_fan_trig.origin,var_02,var_02,"MOD_UNKNOWN","iw7_fantrap_zm");
}

//Function Number: 117
delay_remove_from_interactions(param_00)
{
	param_00 notify("delay_interaction_array");
	param_00 endon("delay_interaction_array");
	scripts\common\utility::flag_wait("interactions_initialized");
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
}

//Function Number: 118
delay_add_to_interactions(param_00)
{
	param_00 notify("delay_interaction_array");
	param_00 endon("delay_interaction_array");
	scripts\common\utility::flag_wait("interactions_initialized");
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
}