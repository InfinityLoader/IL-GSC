/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_rave\cp_rave_interactions.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 77
 * Decompile Time: 4037 ms
 * Timestamp: 10/27/2023 12:06:25 AM
*******************************************************************/

//Function Number: 1
register_interactions()
{
	level.interaction_hintstrings["debris_350"] = &"CP_RAVE_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1000"] = &"CP_RAVE_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1500"] = &"CP_RAVE_PURCHASE_AREA";
	level.interaction_hintstrings["debris_2000"] = &"CP_RAVE_PURCHASE_AREA";
	level.interaction_hintstrings["debris_2500"] = &"CP_RAVE_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1250"] = &"CP_RAVE_PURCHASE_AREA";
	level.interaction_hintstrings["debris_750"] = &"CP_RAVE_PURCHASE_AREA";
	level.interaction_hintstrings["power_door_sliding"] = &"COOP_INTERACTIONS_REQUIRES_POWER";
	level.interaction_hintstrings["weapon_upgrade"] = &"CP_RAVE_UPGRADE_WEAPON";
	level.interaction_hintstrings["interaction_packboat"] = &"CP_RAVE_USEBOAT";
	level.interaction_hintstrings["fast_travel"] = &"CP_RAVE_ENTER_PORTAL";
	level.interaction_hintstrings["interaction_woodchipper"] = &"CP_RAVE_TRAP_GENERIC";
	level.interaction_hintstrings["trap_loudspeaker"] = &"CP_RAVE_TRAP_GENERIC";
	level.interaction_hintstrings["trap_electric"] = &"CP_RAVE_TRAP_FISH";
	level.interaction_hintstrings["trap_logswing"] = &"CP_RAVE_TRAP_LOGSWING";
	level.interaction_hintstrings["trap_waterfall"] = &"CP_RAVE_TRAP_GENERIC";
	level.interaction_hintstrings["atm_deposit"] = &"CP_RAVE_ATM_DEPOSIT";
	level.interaction_hintstrings["atm_withdrawal"] = &"CP_RAVE_ATM_WITHDRAWAL";
	level.interaction_hintstrings["fix_pap"] = &"CP_RAVE_FIX_PAP";
	scripts\cp\_interaction::func_DEBB("pap_portal","fast_travel",undefined,::scripts\cp\maps\cp_rave\cp_rave_boat::pap_portal_hint_logic,::scripts\cp\maps\cp_rave\cp_rave_boat::pap_portal_use_func,0,0);
	scripts\cp\_interaction::func_DEBB("fix_pap","pap",undefined,::scripts\cp\maps\cp_rave\cp_rave_boat::func_C8A5,::scripts\cp\maps\cp_rave\cp_rave_boat::func_6DFD,0);
	scripts\cp\_interaction::func_DEBB("interaction_packboat","door_buy",undefined,::scripts\cp\maps\cp_rave\cp_rave_boat::packboat_hint_func,::scripts\cp\maps\cp_rave\cp_rave_boat::func_13000,0,0,::scripts\cp\maps\cp_rave\cp_rave_boat::func_96A9);
	scripts\cp\_interaction::func_DEBB("weapon_upgrade","pap",undefined,::scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::weapon_upgrade_hint_func,::scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::func_13C62,5000,1,::lib_0D41::func_94F2);
	scripts\cp\_interaction::func_DEBB("debris_350","door_buy",undefined,undefined,::scripts\cp\zombies\cp_rave_doors::func_4142,350);
	scripts\cp\_interaction::func_DEBB("debris_1000","door_buy",undefined,undefined,::scripts\cp\zombies\cp_rave_doors::func_4142,1000);
	scripts\cp\_interaction::func_DEBB("debris_1500","door_buy",undefined,undefined,::scripts\cp\zombies\cp_rave_doors::func_4142,1500);
	scripts\cp\_interaction::func_DEBB("debris_2000","door_buy",undefined,undefined,::scripts\cp\zombies\cp_rave_doors::func_4142,2000);
	scripts\cp\_interaction::func_DEBB("debris_2500","door_buy",undefined,undefined,::scripts\cp\zombies\cp_rave_doors::func_4142,2500);
	scripts\cp\_interaction::func_DEBB("debris_1250","door_buy",undefined,undefined,::scripts\cp\zombies\cp_rave_doors::func_4142,1250);
	scripts\cp\_interaction::func_DEBB("debris_750","door_buy",undefined,undefined,::scripts\cp\zombies\cp_rave_doors::func_4142,750);
	scripts\cp\_interaction::func_DEBB("power_door_sliding","door_buy",undefined,undefined,undefined,0,1,::scripts\cp\zombies\interaction_rave_openareas::func_9749);
	register_wall_buys();
	scripts\cp\_interaction::func_DEBB("ritual_stone",undefined,undefined,::rave_ritual_stone_hint,::use_rave_ritual_stone,0,0);
	scripts\cp\_interaction::func_DEBB("interaction_woodchipper","trap",undefined,undefined,::scripts\cp\zombies\interaction_woodchipper_trap::use_woodchipper_trap,750,1,::scripts\cp\zombies\interaction_woodchipper_trap::init_woodchipper_trap);
	scripts\cp\_interaction::func_DEBB("trap_loudspeaker","trap",undefined,undefined,::scripts\cp\zombies\interaction_loudspeaker::use_loudspeaker_trap,750,1,::scripts\cp\zombies\interaction_loudspeaker::init_loudspeaker_trap);
	scripts\cp\_interaction::func_DEBB("trap_electric","trap",undefined,undefined,::scripts\cp\zombies\interaction_fishtrap::use_fishtrap,750,1,::scripts\cp\zombies\interaction_fishtrap::init_fishtrap);
	scripts\cp\_interaction::func_DEBB("trap_logswing","trap",undefined,undefined,::scripts\cp\zombies\interaction_logswing::use_logswing_trap,350,1,::scripts\cp\zombies\interaction_logswing::init_logswing_trap);
	scripts\cp\_interaction::func_DEBB("trap_waterfall","trap",undefined,undefined,::scripts\cp\zombies\interaction_waterfall::use_waterfall_trap,750,1,::scripts\cp\zombies\interaction_waterfall::init_waterfall_trap);
	scripts\cp\_interaction::func_DEBB("atm_withdrawal","atm",undefined,::func_2418,::atm_withdrawal,0);
	scripts\cp\_interaction::func_DEBB("atm_deposit","atm",undefined,::scripts\cp\_interaction::atm_deposit_hint,::atm_deposit,1000);
	scripts\cp\_interaction::func_DEBB("memory_vo_skull",undefined,undefined,::blank_hint_func,::use_memory_skull,0,1);
	scripts\cp\_interaction::func_DEBB("computer",undefined,undefined,::blank_hint_func,::use_computer,0,1);
	func_DE92();
	func_DEA7();
	register_mini_games();
	register_arcade_rom_games();
	register_challenges();
	register_super_slasher_fight_interactions();
	level notify("interactions_initialized");
	scripts\common\utility::flag_set("interactions_initialized");
	if(isdefined(level.escape_interaction_registration_func))
	{
		[[ level.escape_interaction_registration_func ]]();
	}
}

//Function Number: 2
atm_deposit(param_00,param_01)
{
	param_01 notify("stop_interaction_logic");
	param_01.var_A8D3 = undefined;
	level.var_2416 = level.var_2416 + 1000;
	scripts\cp\_interaction::increase_total_deposit_amount(param_01,1000);
	param_01 thread scripts\cp\_vo::try_to_play_vo("atm_deposit","zmb_comment_vo","low");
	scripts\cp\zombies\zombie_analytics::func_AF5D(1,level.wave_num,param_01);
	if(scripts\cp\_interaction::exceed_deposit_limit(param_01))
	{
		scripts\cp\_interaction::func_E01A(param_00,param_01);
	}
}

//Function Number: 3
atm_withdrawal(param_00,param_01)
{
	if(level.var_2416 < 1000)
	{
		return;
	}

	var_02 = 1000;
	param_01 scripts\cp\_persistence::func_82F9(var_02,undefined,undefined,undefined,"atm");
	param_01 notify("stop_interaction_logic");
	param_01.var_A8D3 = undefined;
	level.var_2416 = level.var_2416 - var_02;
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\zombies\zombie_analytics::func_AF5D(1,level.wave_num,param_01);
	param_01 thread scripts\cp\_vo::try_to_play_vo("withdraw_cash","zmb_comment_vo","low");
}

//Function Number: 4
func_2418(param_00,param_01)
{
	if(param_00.var_E1B9 && !param_00.var_D776)
	{
		return &"COOP_INTERACTIONS_REQUIRES_POWER";
	}

	if(isdefined(level.var_2416) && level.var_2416 < 1000)
	{
		return &"CP_RAVE_ATM_INSUFFICIENT_FUNDS";
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 5
use_memory_skull(param_00,param_01)
{
}

//Function Number: 6
use_computer(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.has_zis_soul_key))
	{
		return;
	}

	if(scripts\common\utility::istrue(level.has_picked_up_fuses))
	{
		return;
	}

	param_01 playlocalsound("zmb_item_pickup");
	param_00 thread wait_for_delivery();
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
}

//Function Number: 7
wait_for_delivery()
{
	level endon("game_ended");
	self notify("wait_for_delivery");
	self endon("wait_for_delivery");
	var_00 = 3;
	var_01 = 0;
	thread scripts\cp\_utility::func_D52A("quest_modem_connect",(-515,-1439,284));
	while(var_01 < var_00)
	{
		level waittill("wave_starting");
		var_01++;
	}

	var_02 = spawn("script_model",(-532,-1477,284));
	var_02 setmodel("park_alien_gray_fuse");
	var_02.angles = (randomintrange(0,360),randomintrange(0,360),randomintrange(0,360));
	var_03 = spawn("script_model",(-518,-1471,284));
	var_03 setmodel("park_alien_gray_fuse");
	var_03.angles = (randomintrange(0,360),randomintrange(0,360),randomintrange(0,360));
	var_03 thread func_50D2(var_03,"souvenir_glow");
	var_03 thread func_A022(var_03);
	var_02 thread func_50D2(var_02,"souvenir_glow");
	var_02 thread func_A022(var_02);
	var_02 thread func_74E4(var_02,var_03);
}

//Function Number: 8
func_50D2(param_00,param_01)
{
	param_00 endon("death");
	wait(0.3);
	playfxontag(level._effect[param_01],param_00,"tag_origin");
}

//Function Number: 9
func_A022(param_00)
{
	param_00 endon("death");
	var_01 = param_00.angles;
	for(;;)
	{
		param_00 rotateto(var_01 + (randomintrange(-40,40),randomintrange(-40,90),randomintrange(-40,90)),3);
		wait(3);
	}
}

//Function Number: 10
func_74E4(param_00,param_01)
{
	param_00 endon("death");
	param_00 makeusable();
	param_00 sethintstring(&"CP_RAVE_PICKUP_ITEM");
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(isplayer(var_02))
		{
			level.has_picked_up_fuses = 1;
			var_02 playlocalsound("part_pickup");
			var_02 thread scripts\cp\_vo::try_to_play_vo("quest_ufo_collect_alienfuse_2","zmb_comment_vo","highest",10,0,0,1,100);
			break;
		}
	}

	foreach(var_02 in level.players)
	{
		var_02 setclientomnvar("zm_special_item",1);
	}

	param_01 delete();
	param_00 delete();
}

//Function Number: 11
blank_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 12
register_challenges()
{
	level.interaction_hintstrings["challenge_repulsor"] = &"CP_RAVE_CHALLENGES_REPULSOR_CHALLENGE";
	scripts\cp\_interaction::func_DEBB("challenge_repulsor","wall_buy",undefined,::scripts\cp\maps\cp_rave\cp_rave_challenges::repulsor_challenge_hint,::scripts\cp\maps\cp_rave\cp_rave_challenges::activate_repulsor_challenge,0);
	level.interaction_hintstrings["challenge_tripmine"] = &"CP_RAVE_CHALLENGES_ARMAGEDDON_CHALLENGE";
	scripts\cp\_interaction::func_DEBB("challenge_armageddon","wall_buy",undefined,::scripts\cp\maps\cp_rave\cp_rave_challenges::armageddon_challenge_hint,::scripts\cp\maps\cp_rave\cp_rave_challenges::activate_armageddon_challenge,0);
	level.interaction_hintstrings["challenge_blackhole"] = &"CP_RAVE_CHALLENGES_BLACKHOLE_CHALLENGE";
	scripts\cp\_interaction::func_DEBB("challenge_blackhole","wall_buy",undefined,::scripts\cp\maps\cp_rave\cp_rave_challenges::blackhole_challenge_hint,::scripts\cp\maps\cp_rave\cp_rave_challenges::activate_blackhole_challenge,0);
	level.interaction_hintstrings["challenge_transponder"] = &"CP_RAVE_CHALLENGES_TRANSPONDER_CHALLENGE";
	scripts\cp\_interaction::func_DEBB("challenge_transponder","wall_buy",undefined,::scripts\cp\maps\cp_rave\cp_rave_challenges::transponder_challenge_hint,::scripts\cp\maps\cp_rave\cp_rave_challenges::activate_transponder_challenge,0);
	level.interaction_hintstrings["challenge_rewind"] = &"CP_RAVE_CHALLENGES_REWIND_CHALLENGE";
	scripts\cp\_interaction::func_DEBB("challenge_rewind","wall_buy",undefined,::scripts\cp\maps\cp_rave\cp_rave_challenges::rewind_challenge_hint,::scripts\cp\maps\cp_rave\cp_rave_challenges::activate_rewind_challenge,0);
	level thread init_challenge_stations();
}

//Function Number: 13
register_wall_buys()
{
	level.interaction_hintstrings["iw7_devastator_zm"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ar57_zm"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m4_zm"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_fmg_zm"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ake_zml"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_sonic_zmr"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_revolver_zm"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m1_zm"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m1c_zm"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_spas_zmr"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_crb_zml"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_erad_zm"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_kbs_zm"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ripper_zmr"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_ump45_zml"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_m8_zm"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_cheytac_zmr"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_two_headed_axe_mp"] = &"CP_RAVE_PICKUP_WEAPON";
	level.interaction_hintstrings["iw7_golf_club_mp"] = &"CP_RAVE_PICKUP_WEAPON";
	level.interaction_hintstrings["iw7_spiked_bat_mp"] = &"CP_RAVE_PICKUP_WEAPON";
	level.interaction_hintstrings["iw7_machete_mp"] = &"CP_RAVE_PICKUP_WEAPON";
	level.interaction_hintstrings["iw7_g18_zmr"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_axe_zm"] = &"CP_RAVE_BUY_WEAPON";
	level.interaction_hintstrings["iw7_slasher_zm"] = &"CP_RAVE_PICKUP_WEAPON";
	level.interaction_hintstrings["iw7_harpoon_zm"] = &"CP_RAVE_PICKUP_WEAPON";
	level.interaction_hintstrings["iw7_harpoon1_zm"] = &"CP_RAVE_PICKUP_WEAPON";
	level.interaction_hintstrings["iw7_harpoon2_zm"] = &"CP_RAVE_PICKUP_WEAPON";
	level.interaction_hintstrings["iw7_harpoon3_zm+akimbo"] = &"CP_RAVE_PICKUP_WEAPON";
	level.interaction_hintstrings["iw7_harpoon4_zm"] = &"CP_RAVE_PICKUP_WEAPON";
	scripts\cp\_interaction::func_DEBB("iw7_harpoon_zm","wall_buy",undefined,::harpoon_hint_func,::interaction_pickup_harpoon_weapon,0);
	scripts\cp\_interaction::func_DEBB("iw7_harpoon1_zm","wall_buy",undefined,::harpoon_hint_func,::interaction_pickup_harpoon_weapon,0);
	scripts\cp\_interaction::func_DEBB("iw7_harpoon2_zm","wall_buy",undefined,::harpoon_hint_func,::interaction_pickup_harpoon_weapon,0);
	scripts\cp\_interaction::func_DEBB("iw7_harpoon3_zm+akimbo","wall_buy",undefined,::harpoon_hint_func,::interaction_pickup_harpoon_weapon,0);
	scripts\cp\_interaction::func_DEBB("iw7_harpoon4_zm","wall_buy",undefined,::harpoon_hint_func,::interaction_pickup_harpoon_weapon,0);
	scripts\cp\_interaction::func_DEBB("iw7_machete_mp","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,0);
	scripts\cp\_interaction::func_DEBB("iw7_golf_club_mp","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,0);
	scripts\cp\_interaction::func_DEBB("iw7_two_headed_axe_mp","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,0);
	scripts\cp\_interaction::func_DEBB("iw7_spiked_bat_mp","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,0);
	scripts\cp\_interaction::func_DEBB("iw7_devastator_zm","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1250);
	scripts\cp\_interaction::func_DEBB("iw7_m8_zm","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1000);
	scripts\cp\_interaction::func_DEBB("iw7_g18_zmr","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,0);
	scripts\cp\_interaction::func_DEBB("iw7_cheytac_zmr","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1000);
	scripts\cp\_interaction::func_DEBB("iw7_m1c_zm","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,500);
	scripts\cp\_interaction::func_DEBB("iw7_sonic_zmr","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,750);
	scripts\cp\_interaction::func_DEBB("iw7_spas_zmr","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1250);
	scripts\cp\_interaction::func_DEBB("iw7_kbs_zm","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1250);
	scripts\cp\_interaction::func_DEBB("iw7_crb_zml","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1250);
	scripts\cp\_interaction::func_DEBB("iw7_erad_zm","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1250);
	scripts\cp\_interaction::func_DEBB("iw7_ripper_zmr","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1250);
	scripts\cp\_interaction::func_DEBB("iw7_ump45_zml","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1250);
	scripts\cp\_interaction::func_DEBB("iw7_m4_zm","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1500);
	scripts\cp\_interaction::func_DEBB("iw7_ar57_zm","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1500);
	scripts\cp\_interaction::func_DEBB("iw7_ake_zml","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1500);
	scripts\cp\_interaction::func_DEBB("iw7_fmg_zm","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1500);
	scripts\cp\_interaction::func_DEBB("iw7_revolver_zm","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,500);
	scripts\cp\_interaction::func_DEBB("iw7_axe_zm","wall_buy",undefined,::rave_wall_buy_hint_func,::interaction_pickup_unique_weapon,1500);
	scripts\cp\_interaction::func_DEBB("iw7_slasher_zm","wall_buy",undefined,undefined,::slasher_weapon_use_func,0);
}

//Function Number: 14
func_DE92()
{
	level.interaction_hintstrings["basketball_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["laughingclown_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["bowling_for_planets_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["clown_tooth_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["game_race"] = &"COOP_INTERACTIONS_PLAY_GAME";
	scripts\cp\_interaction::func_DEBB("basketball_game_afterlife","afterlife_game",undefined,undefined,::lib_0D2E::func_12FA8,0,0,::lib_0D2E::func_94D8);
	scripts\cp\_interaction::func_DEBB("clown_tooth_game_afterlife","afterlife_game",undefined,undefined,::lib_0D33::func_12FBC,0,0,::lib_0D33::func_94D9);
	scripts\cp\_interaction::func_DEBB("laughingclown_afterlife","afterlife_game",undefined,undefined,::lib_0D36::func_AA4B,0,0,::lib_0D36::func_94EC);
	scripts\cp\_interaction::func_DEBB("bowling_for_planets_afterlife","afterlife_game",undefined,undefined,::lib_0D31::func_12FAB,0,0,::lib_0D31::func_9549);
	scripts\cp\_interaction::func_DEBB("game_race","arcade_game",undefined,::lib_0D3A::func_DBB3,::lib_0D3A::func_13003,0,1,::lib_0D3A::func_94F0);
}

//Function Number: 15
rave_wall_buy_hint_func(param_00,param_01)
{
	if(scripts\cp\_utility::func_9D18())
	{
		return &"CP_RAVE_WALL_BUY_DISABLED";
	}

	if(!param_01 lib_0D2C::func_381D(param_00))
	{
		return &"COOP_INTERACTIONS_CANNOT_BUY";
	}

	var_02 = func_13C1B(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	var_03 = getweaponbasename(param_00.script_noteworthy);
	return level.interaction_hintstrings[var_03];
}

//Function Number: 16
func_13C1B(param_00,param_01)
{
	if(param_01 scripts\cp\_weapon::func_8BBB(param_00.script_noteworthy))
	{
		return &"COOP_INTERACTIONS_PURCHASE_AMMO";
	}

	return undefined;
}

//Function Number: 17
harpoon_hint_func(param_00,param_01)
{
	if(param_01 hasweapon(param_00.script_noteworthy))
	{
		return &"COOP_GAME_PLAY_RESTRICTED";
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 18
interaction_pickup_harpoon_weapon(param_00,param_01)
{
	if(!scripts\common\utility::flag("harpoon_unlocked"))
	{
		return;
	}

	if(scripts\cp\_utility::func_9D18())
	{
		return;
	}

	if(param_01 hasweapon(param_00.script_noteworthy))
	{
		return;
	}

	if(!scripts\common\utility::istrue(param_00.quest_complete))
	{
		param_00 thread wait_for_quest_completed(param_00,param_01);
	}

	if(!isdefined(param_00.clip))
	{
		param_00.clip = weaponclipsize(param_00.script_noteworthy);
	}

	if(issubstr(param_00.script_noteworthy,"+akimbo") && !isdefined(param_00.left_clip))
	{
		param_00.left_clip = weaponclipsize(param_00.script_noteworthy);
	}

	if(!isdefined(param_00.var_10FAF))
	{
		param_00.var_10FAF = function_0249(param_00.script_noteworthy);
	}

	param_00 thread watch_player_ammo_count(param_00,param_01,param_00.script_noteworthy);
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_01 scripts\cp\maps\cp_rave\cp_rave::give_harpoon_weapon(param_00,param_01);
}

//Function Number: 19
watch_player_ammo_count_for_player(param_00,param_01,param_02)
{
	param_00 notify("watch_player_ammo_count_" + param_01.name);
	param_00 endon("watch_player_ammo_count_" + param_01.name);
	param_00 endon("weapon_disowned_" + param_00.script_noteworthy);
	param_01 endon("disconnect");
	for(;;)
	{
		if(param_01 getcurrentweapon() == param_02)
		{
			while(param_01 scripts\cp\_utility::getvalidtakeweapon() == param_02)
			{
				param_01 waittill("weapon_fired",var_03);
				while(param_01 method_81B8())
				{
					scripts\common\utility::func_136F7();
				}

				if(var_03 == param_02 && param_01 hasweapon(param_02))
				{
					param_01.saw_clip = param_01 getweaponammoclip(param_02);
					param_01.saw_stock = param_01 getweaponammostock(param_02);
					if(param_01 method_819C() && isdefined(param_01.saw_left_clip))
					{
						param_01.saw_left_clip = param_01 getweaponammoclip(param_02,"left");
					}
				}
			}
		}

		param_01 waittill("weapon_change");
	}
}

//Function Number: 20
watch_player_ammo_count(param_00,param_01,param_02)
{
	param_00 notify("watch_player_ammo_count");
	param_00 endon("watch_player_ammo_count");
	param_00 endon("weapon_disowned_" + param_00.script_noteworthy);
	param_01 endon("disconnect");
	for(;;)
	{
		if(param_01 getcurrentweapon() == param_02)
		{
			while(param_01 scripts\cp\_utility::getvalidtakeweapon() == param_02)
			{
				param_01 waittill("weapon_fired",var_03);
				while(param_01 method_81B8())
				{
					scripts\common\utility::func_136F7();
				}

				if(var_03 == param_02 && param_01 hasweapon(param_02))
				{
					param_00.clip = param_01 getweaponammoclip(param_02);
					param_00.var_10FAF = param_01 getweaponammostock(param_02);
					if(param_01 method_819C() && isdefined(param_00.left_clip))
					{
						param_00.left_clip = param_01 getweaponammoclip(param_02,"left");
					}
				}
			}
		}

		param_01 waittill("weapon_change");
	}
}

//Function Number: 21
wait_for_quest_completed(param_00,param_01)
{
	param_00 endon("weapon_disowned_" + param_00.script_noteworthy);
	param_01 endon("disconnect");
	param_01 waittill("harpoon_quest_completed",var_02);
	param_00.trigger setmodel(function_00EA(var_02));
	param_00.quest_complete = 1;
	param_00.script_noteworthy = var_02;
	param_00.clip = weaponclipsize(var_02);
	param_00.var_10FAF = function_0249(var_02);
	param_00.var_394 = var_02;
	param_01 thread scripts\cp\maps\cp_rave\cp_rave::watch_for_weapon_removed(param_00,param_01);
	param_00 thread watch_player_ammo_count(param_00,param_01,var_02);
}

//Function Number: 22
interaction_pickup_unique_weapon(param_00,param_01)
{
	if(scripts\cp\_utility::func_9D18())
	{
		return;
	}

	param_01 scripts\cp\maps\cp_rave\cp_rave::cp_rave_give_weapon(param_00,param_01);
	param_01.var_A8D3 = undefined;
}

//Function Number: 23
melee_weapon_init()
{
	var_00 = scripts\common\utility::getstructarray("starting_melee_weapons","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.model = spawn("script_weapon",var_02.origin,0,0,var_02.name);
		var_02.model.angles = var_02.angles;
	}
}

//Function Number: 24
func_DEA7()
{
	level.interaction_hintstrings["crafting_pickup"] = &"CP_RAVE_PICKUP_OFFERING";
	level.interaction_hintstrings["crafting_item_swap"] = &"CP_RAVE_CRAFTING_ITEM_SWAP";
	level.interaction_hintstrings["crafting_station"] = &"CP_RAVE_ADD_CRAFTING_ITEM";
	level.interaction_hintstrings["crafting_nopiece"] = &"CP_RAVE_NEED_OFFERING";
	level.interaction_hintstrings["crafted_windowtrap"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_LASERTRAP";
	level.interaction_hintstrings["crafted_autosentry"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_AUTOSENTRY";
	level.interaction_hintstrings["crafted_ims"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_IMS";
	level.interaction_hintstrings["crafted_medusa"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_MEDUSA";
	level.interaction_hintstrings["crafted_electric_trap"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_ELECTRIC_TRAP";
	level.interaction_hintstrings["crafted_boombox"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_BOOMBOX";
	level.interaction_hintstrings["crafted_revocator"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_REVOCATOR";
	level.interaction_hintstrings["crafted_gascan"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_GASCAN";
	level.interaction_hintstrings["crafted_trap_mower"] = &"CP_RAVE_EQUIP_MOWER";
	level.interaction_hintstrings["crafted_trap_balloon"] = &"CP_RAVE_EQUIP_BALLOONS";
	level.interaction_hintstrings["lair_secret_door"] = "";
	level.interaction_hintstrings["survivor_interaction"] = &"CP_RAVE_KEVIN";
	scripts\cp\_interaction::func_DEBB("crafting_station","souvenir_station",undefined,undefined,::scripts\cp\maps\cp_rave\cp_rave_crafting::func_12FBE,0,1,::scripts\cp\maps\cp_rave\cp_rave_crafting::func_9596);
	scripts\cp\_interaction::func_DEBB("crafting_pickup","souvenir_coin",undefined,undefined,::scripts\cp\maps\cp_rave\cp_rave_crafting::func_47C4,0);
	scripts\cp\_interaction::func_DEBB("crafted_autosentry","craftable",undefined,undefined,::scripts\cp\_weapon_autosentry::func_82BA,0);
	scripts\cp\_interaction::func_DEBB("crafted_ims","craftable",1,undefined,::scripts\cp\zombies\craftables\_fireworks_trap::func_82B5,0);
	scripts\cp\_interaction::func_DEBB("crafted_medusa","craftable",undefined,undefined,::scripts\cp\zombies\craftables\_zm_soul_collector::func_82B8,0);
	scripts\cp\_interaction::func_DEBB("crafted_electric_trap","craftable",undefined,undefined,::scripts\cp\zombies\craftables\_electric_trap::func_82BB,0);
	scripts\cp\_interaction::func_DEBB("crafted_boombox","craftable",undefined,undefined,::scripts\cp\zombies\craftables\_boombox::func_82B4,0);
	scripts\cp\_interaction::func_DEBB("crafted_revocator","craftable",undefined,undefined,::scripts\cp\zombies\craftables\_revocator::func_82B9,0);
	scripts\cp\_interaction::func_DEBB("crafted_gascan","craftable",undefined,undefined,::scripts\cp\zombies\craftables\_gascan::func_82B6,0);
	scripts\cp\_interaction::func_DEBB("crafted_windowtrap","craftable",undefined,undefined,::lib_0D43::func_DAFF,0);
	scripts\cp\_interaction::func_DEBB("crafted_trap_mower","craftable",undefined,undefined,::scripts\cp\crafted_trap_mower::func_82BB,0);
	scripts\cp\_interaction::func_DEBB("crafted_trap_balloon","craftable",undefined,undefined,::scripts\cp\crafted_trap_balloons::func_82BB,0);
	scripts\cp\_interaction::func_DEBB("pillage_item",undefined,undefined,::lib_0D5E::func_CB59,::lib_0D5E::func_D31E,0,0);
	scripts\cp\_interaction::func_DEBB("animal_statue_toys",undefined,undefined,::scripts\cp\maps\cp_rave\cp_rave::toy_animal_statue_hint_func,::scripts\cp\maps\cp_rave\cp_rave::use_toy_animal_statue,0);
	scripts\cp\_interaction::func_DEBB("animal_statue_end_pos",undefined,undefined,::scripts\cp\maps\cp_rave\cp_rave::toy_statue_end_pos_hint_func,::scripts\cp\maps\cp_rave\cp_rave::toy_animal_statue_end_pos,0);
	scripts\cp\_interaction::func_DEBB("charge_animal_toys",undefined,undefined,::scripts\cp\maps\cp_rave\cp_rave::toy_charging_hint_func,::scripts\cp\maps\cp_rave\cp_rave::toy_charging_use_func,0);
	scripts\cp\_interaction::func_DEBB("memory_quest_start_pos",undefined,undefined,::scripts\cp\maps\cp_rave\cp_rave_memory_quests::memory_start_hint_func,::scripts\cp\maps\cp_rave\cp_rave_memory_quests::memory_quest_start_func,0,0);
	scripts\cp\_interaction::func_DEBB("memory_quest_end_pos",undefined,undefined,::scripts\cp\maps\cp_rave\cp_rave_memory_quests::memories_end_hint_func,::scripts\cp\maps\cp_rave\cp_rave_memory_quests::memories_end_use_func,0,0);
	scripts\cp\_interaction::func_DEBB("ring_quest_lights",undefined,undefined,::scripts\cp\maps\cp_rave\cp_rave_memory_quests::ring_quest_hint_func,::scripts\cp\maps\cp_rave\cp_rave_memory_quests::ring_quest_use_func,0,0);
	scripts\cp\_interaction::func_DEBB("mushroom_patch",undefined,undefined,::mushroom_patch_hint_func,::mushroom_patch_use_func,0,0);
	scripts\cp\_interaction::func_DEBB("survivor_interaction",undefined,undefined,::survivor_hint_func,::survivor_use_func,0,0);
	scripts\cp\_interaction::func_DEBB("boat_quest_piece",undefined,undefined,::boat_quest_hint_func,::boat_quest_use_func,0,0,::init_boat_quest);
	scripts\cp\_interaction::func_DEBB("pap_quest_piece",undefined,undefined,::pap_quest_hint_func,::pap_quest_use_func,0,0,::init_pap_quest);
	scripts\cp\_interaction::func_DEBB("lair_secret_door",undefined,undefined,undefined,::use_lair_door,0,0,::init_lair_door);
}

//Function Number: 25
survivor_hint_func(param_00,param_01)
{
	return level.interaction_hintstrings["survivor_interaction"];
}

//Function Number: 26
survivor_use_func(param_00,param_01)
{
	var_02 = scripts\common\utility::getstructarray(param_00.script_noteworthy,"script_noteworthy");
	foreach(var_04 in var_02)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_04);
	}

	if(!scripts\common\utility::istrue(level.metks))
	{
		level thread play_first_meeting_with_ks_vo(param_01,param_00);
		return;
	}

	level thread play_meet_ks_vo(param_01,param_00);
}

//Function Number: 27
add_back_to_interaction_system(param_00,param_01,param_02)
{
	level endon("game_ended");
	while(scripts\cp\_vo::func_9D13())
	{
		wait(1);
	}

	if(!scripts\cp\_vo::func_9D13())
	{
		foreach(var_04 in level.var_134FE)
		{
			if(isdefined(param_02))
			{
				if(isdefined(param_02.var_13516.var_134FF[var_04]) && param_02.var_13516.var_134FF[var_04].size > 0)
				{
					foreach(var_06 in param_02.var_13516.var_134FF[var_04])
					{
						if(isdefined(var_06))
						{
							if(soundexists(var_06.var_1B46))
							{
								wait(scripts\cp\_vo::func_7C76(var_06.var_1B46));
							}
						}
					}
				}
			}
		}
	}

	var_09 = scripts\common\utility::getstructarray(param_00.script_noteworthy,"script_noteworthy");
	foreach(var_0B in var_09)
	{
		scripts\cp\_interaction::add_to_current_interaction_list(var_0B);
	}
}

//Function Number: 28
play_first_meeting_with_ks_vo(param_00,param_01)
{
	level endon("game_ended");
	if(isdefined(param_00.var_13516.var_134C6))
	{
		if(isdefined(param_00.var_13516.var_134C6.var_1B46) && soundexists(param_00.var_13516.var_134C6.var_1B46))
		{
			param_00 stoplocalsound(param_00.var_13516.var_134C6.var_1B46);
			param_00.var_13518 = 0;
		}
	}

	switch(param_00.var_134FD)
	{
		case "p1_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("meetksmith_32_1","rave_kevin_smith_dialogue_vo","highest",666,0,0,0,100,1);
			level thread add_back_to_interaction_system(param_01,"meetksmith_32_1",param_00);
			break;

		case "p2_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("meetksmith_35_1","rave_kevin_smith_dialogue_vo","highest",666,0,0,0,100,1);
			level thread add_back_to_interaction_system(param_01,"meetksmith_35_1",param_00);
			break;

		case "p3_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("ks_meetksmith_33_1","rave_kevin_smith_dialogue_vo","highest",666,0,0,0,100,1);
			level thread add_back_to_interaction_system(param_01,"ks_meetksmith_33_1",param_00);
			break;

		case "p4_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("meetksmith_34_1","rave_kevin_smith_dialogue_vo","highest",666,0,0,0,100,1);
			level thread add_back_to_interaction_system(param_01,"meetksmith_34_1",param_00);
			break;

		case "p5_":
			param_00 thread scripts\cp\_vo::try_to_play_vo("meetksmith_36_1","rave_kevin_smith_dialogue_vo","highest",666,0,0,0,100,1);
			level thread add_back_to_interaction_system(param_01,"meetksmith_36_1",param_00);
			break;

		default:
			break;
	}

	level.met_kev = 1;
	level.metks = 1;
	if(!isdefined(level.players_who_met_kev))
	{
		level.players_who_met_kev = [];
	}

	level.players_who_met_kev = level.players;
	level thread add_back_to_interaction_system(param_01,"");
}

//Function Number: 29
play_meet_ks_vo(param_00,param_01)
{
	level endon("game_ended");
	if(scripts\common\utility::flag("photo_1_kev_given") && !scripts\common\utility::flag("photo_1_kev_vo_done"))
	{
		param_00 scripts\cp\maps\cp_rave\cp_rave_j_mem_quest::play_jay_memory_to_kev(param_01);
		scripts\common\utility::flag_set("photo_1_kev_vo_done");
		return;
	}

	if(scripts\common\utility::flag("photo_2_kev_given") && !scripts\common\utility::flag("photo_2_kev_vo_done"))
	{
		param_00 scripts\cp\maps\cp_rave\cp_rave_j_mem_quest::play_jay_memory_to_kev(param_01);
		scripts\common\utility::flag_set("photo_2_kev_vo_done");
		return;
	}

	if(randomint(100) > 50)
	{
		if(!scripts\common\utility::flag("pap_fixed"))
		{
			param_00 thread scripts\cp\_vo::try_to_play_vo("ks_pap_outoforder","rave_ks_vo");
			level thread add_back_to_interaction_system(param_01,"ks_pap_outoforder",param_00);
			return;
		}

		level thread add_back_to_interaction_system(param_01,"");
		return;
	}

	var_02 = function_00E3(param_00 getcurrentweapon());
	if(scripts\common\utility::func_2286(var_02,"cos_087") || scripts\common\utility::func_2286(var_02,"cos_085"))
	{
		foreach(var_04 in var_02)
		{
			if(issubstr(var_04,"cos_087"))
			{
				param_00 thread scripts\cp\_vo::try_to_play_vo("ks_memento_wwyler","rave_ks_vo");
				level thread add_back_to_interaction_system(param_01,"ks_memento_wwyler",param_00);
				continue;
			}

			if(issubstr(var_04,"cos_085"))
			{
				param_00 thread scripts\cp\_vo::try_to_play_vo("ks_memento_carya","rave_ks_vo");
				level thread add_back_to_interaction_system(param_01,"ks_memento_carya",param_00);
			}
		}

		return;
	}

	level thread add_back_to_interaction_system(param_01,"");
}

//Function Number: 30
init_pap_quest()
{
	scripts\common\utility::flag_wait("interactions_initialized");
	var_00 = (-6122.09,4854.49,149);
	var_01 = (0,101.998,0);
	var_02 = spawn("script_model",var_00);
	var_02.angles = var_01;
	var_02 setmodel("cp_rave_projector");
	level.projector_struct = var_02;
	level.pap_pieces_found = 0;
	var_03 = scripts\common\utility::getstructarray("pap_quest_piece","script_noteworthy");
	foreach(var_05 in var_03)
	{
		if(!isdefined(var_05.name))
		{
			continue;
		}

		var_06 = var_05.name;
		var_05.model = spawn("script_model",var_05.origin);
		if(isdefined(var_05.angles))
		{
			var_05.model.angles = var_05.angles;
		}
		else
		{
			var_05.model.angles = (0,0,0);
		}

		switch(var_06)
		{
			case "reel":
				var_05.model setmodel("cp_rave_projector_reel");
				break;
		}
	}
}

//Function Number: 31
init_boat_quest()
{
	level.boat_pieces_found = 0;
	var_00 = scripts\common\utility::getstructarray("boat_quest_piece","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.name))
		{
			continue;
		}

		var_03 = var_02.name;
		var_02.model = spawn("script_model",var_02.origin);
		var_02.model.angles = var_02.angles;
		switch(var_03)
		{
			case "propeller":
				var_02.model setmodel("cp_rave_boat_motor_prop");
				break;

			case "engine":
				var_02.model setmodel("cp_rave_boat_motor_handle");
				break;

			case "tiller":
				var_02.model setmodel("cp_rave_boat_motor_stalk");
				break;
		}
	}
}

//Function Number: 32
boat_quest_hint_func(param_00,param_01)
{
	return &"CP_RAVE_INSPECT_ITEM";
}

//Function Number: 33
boat_quest_use_func(param_00,param_01)
{
	level.boat_pieces_found++;
	param_00.model delete();
	param_01 playlocalsound("part_pickup");
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	switch(param_00.name)
	{
		case "propeller":
			level scripts\cp\_utility::set_quest_icon(7);
			break;

		case "engine":
			level scripts\cp\_utility::set_quest_icon(9);
			break;

		case "tiller":
			level scripts\cp\_utility::set_quest_icon(8);
			break;
	}

	if(level.boat_pieces_found == 3)
	{
		switch(param_01.var_134FD)
		{
			case "p1_":
				param_01 thread scripts\cp\_vo::try_to_play_vo("island_46_1","rave_dialogue_vo","highest",666,0,0,0,100);
				level.var_4481["island_46_1"] = 1;
				break;

			case "p4_":
				param_01 thread scripts\cp\_vo::try_to_play_vo("island_48_1","rave_dialogue_vo","highest",666,0,0,0,100);
				level.var_4481["island_48_1"] = 1;
				break;

			case "p3_":
				param_01 thread scripts\cp\_vo::try_to_play_vo("island_47_1","rave_dialogue_vo","highest",666,0,0,0,100);
				level.var_4481["island_47_1"] = 1;
				break;

			case "p2_":
				param_01 thread scripts\cp\_vo::try_to_play_vo("island_49_1","rave_dialogue_vo","highest",666,0,0,0,100);
				level.var_4481["island_49_1"] = 1;
				break;

			default:
				break;
		}
	}
}

//Function Number: 34
pap_quest_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 35
pap_quest_use_func(param_00,param_01)
{
	level.pap_pieces_found++;
	if(level.pap_pieces_found == 1)
	{
		level scripts\cp\_utility::set_quest_icon(11);
	}
	else
	{
		level scripts\cp\_utility::set_quest_icon(12);
	}

	param_00.model delete();
	param_01 playlocalsound("part_pickup");
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
}

//Function Number: 36
register_arcade_rom_games()
{
	level.interaction_hintstrings["arcade_atlantis"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_beamrid"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_boombang"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_command"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_kaboom"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_ghostbu"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_hero"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_megaman"] = &"COOP_INTERACTIONS_PLAY_GAME";
	scripts\cp\_interaction::func_DEBB("arcade_atlantis","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_beamrid","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_boombang","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_command","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_kaboom","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_ghostbu","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_hero","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_megaman","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	level.interaction_hintstrings["arcade_icehock"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_seaques"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_boxing"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_oink"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_keyston"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_plaque"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_crackpo"] = &"COOP_INTERACTIONS_PLAY_GAME";
	scripts\cp\_interaction::func_DEBB("arcade_icehock","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_seaques","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_boxing","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_oink","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_keyston","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_plaque","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_crackpo","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
}

//Function Number: 37
collect_zombie_souls(param_00)
{
	level endon("game_ended");
	level.memory_quest_items[level.memory_quest_items.size] = param_00;
	var_01 = 0;
	param_00.var_E866 = 0;
	param_00.expected_souls = 0;
	var_02 = 10;
	while(var_01 < var_02)
	{
		level waittill("kill_near_crystal",var_03,var_04,var_05);
		param_00.expected_souls--;
		if(param_00 != var_05)
		{
			continue;
		}

		thread func_4AE3(var_03,param_00);
		param_00.var_E866++;
		var_01++;
	}

	while(param_00.var_E866 >= 1)
	{
		wait(0.05);
	}

	param_00.var_74BE = 1;
	param_00 notify("fully_charged");
	foreach(var_07 in level.players)
	{
		var_07 playlocalsound("part_pickup");
	}

	if(isdefined(param_00) && scripts\common\utility::func_2286(level.memory_quest_items,param_00))
	{
		level.memory_quest_items = scripts\common\utility::func_22A9(level.memory_quest_items,param_00);
	}
}

//Function Number: 38
func_4AE3(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02 setmodel("tag_origin_soultrail");
	var_03 = param_01.origin;
	var_04 = param_00 + (0,0,40);
	for(;;)
	{
		var_05 = distance(var_04,var_03);
		var_06 = 1500;
		var_07 = var_05 / var_06;
		if(var_07 < 0.05)
		{
			var_07 = 0.05;
		}

		var_02 moveto(var_03,var_07);
		var_02 waittill("movedone");
		if(distance(var_02.origin,param_01.origin) > 16)
		{
			var_03 = param_01.origin;
			var_04 = var_02.origin;
			continue;
		}

		break;
	}

	wait(0.25);
	param_01.var_E866--;
	var_02 delete();
}

//Function Number: 39
update_rave_mode_for_player(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	while(scripts\common\utility::istrue(param_00.rave_mode_updating))
	{
		scripts\common\utility::func_136F7();
	}

	waittillframeend;
	param_00 notify("rave_interactions_updated");
}

//Function Number: 40
unsetravetriggeraftertime(param_00,param_01,param_02,param_03,param_04)
{
	level endon("game_ended");
	param_00 scripts\common\utility::waittill_any_timeout_1(scripts\common\utility::func_116D7(scripts\common\utility::istrue(level.only_one_player) || scripts\cp\_utility::isplayingsolo(),60,2),"picked_up");
	param_00.ravetriggered = 0;
	foreach(var_06 in level.players)
	{
		var_06 thread update_rave_mode_for_player(var_06);
	}
}

//Function Number: 41
setup_rave_dust_interactions()
{
	scripts\common\utility::flag_init("init_interaction_done");
	scripts\common\utility::flag_wait("init_interaction_done");
	level.rave_mode_activation_funcs["mushroom_patch"] = ::rave_dust_rave_mode;
	var_00 = [1,2,3,4];
	for(var_01 = 0;var_01 <= var_00.size;var_01++)
	{
		if(var_01 == 0)
		{
			var_02 = scripts\common\utility::getstructarray("mushroom_patch","targetname");
		}
		else
		{
			var_02 = scripts\common\utility::getstructarray("mushroom_patch_" + var_01,"targetname");
		}

		foreach(var_04 in var_02)
		{
			var_04.script_noteworthy = "mushroom_patch";
			var_04.var_E1B9 = 0;
			var_04.var_D776 = 1;
			var_04.var_EE79 = "default";
			var_04.var_4C72 = 32;
			var_04.currentlyownedby = [];
			var_04.only_rave_mode = 1;
			scripts\cp\_interaction::add_to_current_interaction_list(var_04);
			scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(var_04);
		}
	}
}

//Function Number: 42
rave_dust_rave_mode(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00.model) || isdefined(param_00.model) && param_00.model != "tag_origin_rave_dust")
	{
		param_00 setmodel("tag_origin_rave_dust");
	}

	scripts\common\utility::func_136F7();
	param_00 setscriptablepartstate("rave_dust","active");
}

//Function Number: 43
mushroom_patch_use_func(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.var_DCEB))
	{
		param_00 thread delay_use_for_time(param_00,param_01);
		scripts\cp\_interaction::func_E01A(param_00,param_01);
		param_01 scripts\cp\zombies\zombies_rave_meter::rave_meter_large_bump();
		param_01 thread update_rave_mode_for_player(param_01);
		param_01 setscriptablepartstate("screen_effects","fairies");
		param_01 playsoundtoplayer("cp_rave_talk_to_fairies",param_01);
		if(isdefined(param_00.currentlyownedby[param_01.name]))
		{
			param_00.currentlyownedby[param_01.name] scripts\cp\maps\cp_rave\cp_rave::resetpersonalent(param_00.currentlyownedby[param_01.name]);
			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 44
resetmushroompatchaftercooldown(param_00)
{
	level endon("game_ended");
	level waittill("wave_starting");
	param_00.rave_model = scripts\common\utility::random(["rave_shroom_patch_01","rave_shroom_patch_02","rave_shroom_patch_03"]);
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(param_00);
	foreach(var_02 in level.players)
	{
		var_02 notify("rave_interactions_updated");
	}
}

//Function Number: 45
mushroom_patch_hint_func(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.var_DCEB))
	{
		if(isdefined(param_00.currentlyownedby[param_01.name]))
		{
			return &"CP_RAVE_USE_FAIRIES";
		}

		return "";
	}

	return "";
}

//Function Number: 46
delay_use_for_time(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("disconnect");
	level waittill("wave_starting");
	scripts\cp\_interaction::func_175D(param_00,param_01);
	param_01 thread update_rave_mode_for_player(param_01);
}

//Function Number: 47
rave_ritual_stone_hint(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_rave_dust))
	{
		return &"CP_RAVE_NEED_POUCH";
	}

	return &"CP_RAVE_THROW_POUCH";
}

//Function Number: 48
use_rave_ritual_stone(param_00,param_01)
{
	if(!scripts\common\utility::istrue(param_01.has_rave_dust))
	{
		return;
	}

	var_02 = scripts\common\utility::func_782F(param_01.origin,scripts\common\utility::getstructarray("ritual_stone","script_noteworthy"),undefined,4);
	param_01.has_rave_dust = undefined;
	param_01 setclientomnvar("zm_hud_inventory_2",0);
	level thread trigger_rave_mode_ritual(param_00,param_01);
}

//Function Number: 49
trigger_rave_mode_ritual(param_00,param_01)
{
	var_02 = gettime() + 5000;
	var_03 = scripts\common\utility::getclosest(param_00.origin,scripts\common\utility::getstructarray("rave_fx","targetname"));
	var_04 = (var_03.origin[0],var_03.origin[1],param_01.origin[2]);
	playfx(level._effect["ritual_stone_use"],var_04 + (0,0,25));
	var_05 = -25536;
	while(gettime() < var_02)
	{
		foreach(var_07 in level.players)
		{
			if(scripts\common\utility::istrue(var_07.inlaststand))
			{
				continue;
			}

			if(!isalive(var_07))
			{
				continue;
			}

			if(scripts\common\utility::istrue(var_07.var_DCEB))
			{
				continue;
			}

			if(distance2dsquared(var_07.origin,var_04) > var_05)
			{
				continue;
			}

			scripts\cp\maps\cp_rave\cp_rave::func_6619(var_07);
			var_07 thread exit_rave_on_laststand();
		}

		wait(0.1);
	}
}

//Function Number: 50
exit_rave_after_time()
{
	self notify("exit_rave_after_time");
	self endon("exit_rave_after_time");
	level endon("game_ended");
	level endon("rave_event_started");
	self endon("disconnect");
	self endon("last_stand");
	for(;;)
	{
		var_00 = scripts\common\utility::waittill_any_timeout_1(self.current_rave_mode_timer,"update_rave_mode_timer");
		if(var_00 == "timeout")
		{
			scripts\cp\maps\cp_rave\cp_rave::func_695D(self);
		}
	}
}

//Function Number: 51
exit_rave_on_laststand()
{
	self notify("exit_rave_on_laststand");
	self endon("exit_rave_on_laststand");
	level endon("game_ended");
	level endon("rave_event_started");
	self endon("exit_rave");
	self endon("disconnect");
	self waittill("last_stand");
	scripts\cp\maps\cp_rave\cp_rave::func_695D(self);
}

//Function Number: 52
register_mini_games()
{
	level.interaction_hintstrings["interaction_knife_throw"] = &"COOP_INTERACTIONS_PLAY_GAME";
	scripts\cp\_interaction::func_DEBB("interaction_knife_throw","arcade_game",undefined,undefined,::lib_0D35::func_12FF7,0,0,::lib_0D35::func_964A);
}

//Function Number: 53
register_super_slasher_fight_interactions()
{
	level.interaction_hintstrings["memory_trap_trigger"] = &"COOP_INTERACTIONS_PLAY_GAME";
	scripts\cp\_interaction::func_DEBB("memory_trap_trigger","memory_trap_trigger",undefined,undefined,::scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::use_memory_trap,0,0,::scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::init_memory_traps);
}

//Function Number: 54
cp_rave_interaction_monitor()
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

		if(isdefined(var_04) && scripts\cp\_interaction::func_9A18(var_04) && !scripts\cp\_interaction::func_9A22(var_04))
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

//Function Number: 55
cp_rave_wait_for_interaction_triggered(param_00)
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
			if(scripts\common\utility::istrue(level.has_picked_up_fuses) && !isdefined(level.placed_alien_fuses))
			{
				var_02 = 0;
			}
			else if(scripts\common\utility::istrue(var_01.has_zis_soul_key) || scripts\common\utility::istrue(level.placed_alien_fuses))
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
					scripts\cp\_interaction::func_9A3C(param_00,&"CP_RAVE_UPGRADE_WEAPON_FAIL");
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
				scripts\cp\_interaction::func_9A3C(param_00,&"CP_RAVE_UPGRADE_WEAPON_FAIL");
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
					else if(var_08 == "g18")
					{
						var_02 = 250;
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
				var_09 = scripts\cp\_utility::func_783C(param_00);
				if(scripts\cp\_utility::func_13C90(self getcurrentweapon(),var_09))
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_ALREADY_HAVE");
					wait(0.1);
					continue;
				}

				if(!scripts\cp\_weapon::func_3862(var_09))
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_PILLAGE_CANT_USE");
					wait(0.1);
					continue;
				}
			}
			else if(param_00.script_noteworthy == "arcade_counter_grenade")
			{
				var_0A = scripts\cp\powers\coop_powers::func_13CFC("primary");
				if(self.var_D782[var_0A].var_3D23 >= level.var_D782[var_0A].var_B486)
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_EQUIPMENT_FULL");
					wait(0.1);
					continue;
				}
			}
			else if(param_00.script_noteworthy == "arcade_counter_ammo")
			{
				var_0B = self getcurrentweapon();
				if(self getweaponammostock(var_0B) >= function_0249(var_0B))
				{
					var_0C = 1;
					if(function_0249(var_0B) == weaponclipsize(var_0B))
					{
						if(self getweaponammoclip(var_0B) < weaponclipsize(var_0B))
						{
							var_0C = 0;
						}
					}

					if(var_0C)
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
			if((scripts\cp\_utility::isplayingsolo() || level.only_one_player) && scripts\cp\_interaction::func_9A1D(param_00) && param_00.var_CA4C == "perk_machine_revive" && var_01.var_F1E7 >= var_01.max_self_revive_machine_use)
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

		if(param_00.var_EE79 == "tickets")
		{
			self.num_tickets = self.num_tickets - var_02;
			self setclientomnvar("zombie_number_of_ticket",int(self.num_tickets));
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
			level thread [[ level.interactions[param_00.script_noteworthy].var_161A ]](param_00,self);
			scripts\cp\_interaction::func_9A34(param_00);
			wait(0.1);
			return;
		}

		var_0D = level.interactions[param_00.script_noteworthy].var_109DA;
		thread scripts\cp\_interaction::func_11449(var_02,var_0D);
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

//Function Number: 56
init_lair_door()
{
	level.lair_door_switch_structs = scripts\common\utility::getstructarray("lair_secret_door","script_noteworthy");
	level thread init_lair_door_switches();
}

//Function Number: 57
use_lair_door(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_00.pressed = 1;
	getent(param_00.var_EE67,"targetname") setscriptablepartstate("light","on");
	param_01 playlocalsound("zmb_power_switch");
	while(param_01 scripts\cp\_utility::is_valid_player() && param_01 usebuttonpressed() && distance(param_01.origin,param_00.origin) < 96 && !scripts\common\utility::flag("survivor_released"))
	{
		try_to_release_survivor();
		wait(0.05);
	}

	if(scripts\common\utility::flag("survivor_released"))
	{
		return;
	}
	else
	{
		getent(param_00.var_EE67,"targetname") setscriptablepartstate("light","off");
	}

	wait(0.25);
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	param_00.pressed = undefined;
}

//Function Number: 58
init_survivor_trapped()
{
}

//Function Number: 59
init_survivor_released()
{
}

//Function Number: 60
wait_for_survivor_trapped()
{
	scripts\common\utility::flag_wait("survivor_trapped");
}

//Function Number: 61
wait_for_survivor_released()
{
	level thread lair_door_player_monitor();
	while(!scripts\common\utility::flag("survivor_released"))
	{
		playsoundatpos((-84,-1859,117),"survivor_pounding_door");
		wait(randomintrange(1,2));
		if(!scripts\common\utility::flag("survivor_released"))
		{
			scripts\cp\_utility::func_D52A("ks_inside_cellar",(-84,-1859,117));
		}

		if(!scripts\common\utility::flag("survivor_released"))
		{
			wait(randomintrange(5,8));
		}

		if(!scripts\common\utility::flag("survivor_released"))
		{
			playsoundatpos((-84,-1859,117),"survivor_pounding_door");
		}

		if(!scripts\common\utility::flag("survivor_released"))
		{
			wait(randomintrange(6,8));
		}
	}

	playsoundatpos((-29,-1859,115),"survivor_portal_teleport");
	wait(0.4);
	scripts\cp\_utility::func_D52A("ks_outside_cellar",(-84,-1859,117));
}

//Function Number: 62
init_lair_door_switches()
{
	while(!isdefined(level.players) || level.players.size < 1)
	{
		wait(1);
	}

	var_00 = getent("trap_door_switch1","targetname");
	var_01 = getent("trap_door_switch2","targetname");
	var_02 = getent("trap_door_switch3","targetname");
	var_03 = getent("trap_door_switch4","targetname");
	var_00 setscriptablepartstate("light","off");
	var_01 setscriptablepartstate("light","off");
	var_02 setscriptablepartstate("light","off");
	var_03 setscriptablepartstate("light","off");
	disable_door_interaction("trap_door_switch1");
	disable_door_interaction("trap_door_switch2");
	disable_door_interaction("trap_door_switch3");
	disable_door_interaction("trap_door_switch4");
	set_switch_pressed(0,0,0,0);
}

//Function Number: 63
lair_door_player_monitor()
{
	var_00 = 0;
	var_01 = getent("trap_door_switch1","targetname");
	var_02 = getent("trap_door_switch2","targetname");
	var_03 = getent("trap_door_switch3","targetname");
	var_04 = getent("trap_door_switch4","targetname");
	while(!scripts\common\utility::flag("survivor_released"))
	{
		if(level.players.size == var_00)
		{
			wait(0.25);
			continue;
		}

		var_00 = level.players.size;
		switch(level.players.size)
		{
			case 1:
				var_01 setscriptablepartstate("light","off");
				var_02 setscriptablepartstate("light","on");
				var_03 setscriptablepartstate("light","on");
				var_04 setscriptablepartstate("light","on");
				enable_door_interaction("trap_door_switch1");
				disable_door_interaction("trap_door_switch2");
				disable_door_interaction("trap_door_switch3");
				disable_door_interaction("trap_door_switch4");
				set_switch_pressed(0,1,1,1);
				break;

			case 2:
				var_01 setscriptablepartstate("light","off");
				var_02 setscriptablepartstate("light","off");
				var_03 setscriptablepartstate("light","on");
				var_04 setscriptablepartstate("light","on");
				enable_door_interaction("trap_door_switch1");
				enable_door_interaction("trap_door_switch2");
				disable_door_interaction("trap_door_switch3");
				disable_door_interaction("trap_door_switch4");
				set_switch_pressed(0,0,1,1);
				break;

			case 3:
				var_01 setscriptablepartstate("light","off");
				var_02 setscriptablepartstate("light","off");
				var_03 setscriptablepartstate("light","off");
				var_04 setscriptablepartstate("light","on");
				enable_door_interaction("trap_door_switch1");
				enable_door_interaction("trap_door_switch2");
				enable_door_interaction("trap_door_switch3");
				disable_door_interaction("trap_door_switch4");
				set_switch_pressed(0,0,0,1);
				break;

			case 4:
				var_01 setscriptablepartstate("light","off");
				var_02 setscriptablepartstate("light","off");
				var_03 setscriptablepartstate("light","off");
				var_04 setscriptablepartstate("light","off");
				enable_door_interaction("trap_door_switch1");
				enable_door_interaction("trap_door_switch2");
				enable_door_interaction("trap_door_switch3");
				enable_door_interaction("trap_door_switch4");
				set_switch_pressed(0,0,0,0);
				break;
		}

		level scripts\common\utility::waittill_any_timeout_1(1,"connected");
	}
}

//Function Number: 64
disable_door_interaction(param_00)
{
	foreach(var_02 in level.lair_door_switch_structs)
	{
		if(param_00 == var_02.var_EE67)
		{
			scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
		}
	}
}

//Function Number: 65
enable_door_interaction(param_00)
{
	foreach(var_02 in level.lair_door_switch_structs)
	{
		if(param_00 == var_02.var_EE67)
		{
			scripts\cp\_interaction::add_to_current_interaction_list(var_02);
		}
	}
}

//Function Number: 66
get_door_switch_struct(param_00)
{
	foreach(var_02 in level.lair_door_switch_structs)
	{
		if(param_00 == var_02.var_EE67)
		{
			return var_02;
		}
	}
}

//Function Number: 67
try_to_release_survivor()
{
	var_00 = 1;
	foreach(var_02 in level.lair_door_switch_structs)
	{
		if(!isdefined(var_02.pressed))
		{
			var_00 = 0;
		}
	}

	if(var_00 && !scripts\common\utility::flag("survivor_released"))
	{
		scripts\cp\_utility::func_D52A("archery_fail_buzzer",(-84,-1859,117));
		level thread scripts\cp\maps\cp_rave\cp_rave_boat::spawn_survivor_on_boat();
		scripts\common\utility::func_136F7();
		scripts\common\utility::flag_set("survivor_released");
	}
}

//Function Number: 68
set_switch_pressed(param_00,param_01,param_02,param_03)
{
	var_04 = get_door_switch_struct("trap_door_switch1");
	if(param_00)
	{
		var_04.pressed = 1;
	}
	else
	{
		var_04.pressed = undefined;
	}

	var_05 = get_door_switch_struct("trap_door_switch2");
	if(param_01)
	{
		var_05.pressed = 1;
	}
	else
	{
		var_05.pressed = undefined;
	}

	var_06 = get_door_switch_struct("trap_door_switch3");
	if(param_02)
	{
		var_06.pressed = 1;
	}
	else
	{
		var_06.pressed = undefined;
	}

	var_07 = get_door_switch_struct("trap_door_switch4");
	if(param_03)
	{
		var_07.pressed = 1;
		return;
	}

	var_07.pressed = undefined;
}

//Function Number: 69
enable_slasher_weapon()
{
	var_00 = scripts\common\utility::getstructarray("iw7_slasher_zm","script_noteworthy");
	foreach(var_02 in var_00)
	{
		scripts\cp\_interaction::add_to_current_interaction_list(var_02);
		var_02.trigger show();
	}
}

//Function Number: 70
disable_slasher_weapon()
{
	level endon("game_ended");
	level waittill("interactions_initialized");
	var_00 = scripts\common\utility::getstructarray("iw7_slasher_zm","script_noteworthy");
	foreach(var_02 in var_00)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
		var_02.trigger hide();
	}
}

//Function Number: 71
slasher_weapon_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 72
slasher_weapon_use_func(param_00,param_01)
{
	scripts\cp\_interaction::func_E01A(param_00,param_01);
	param_00.trigger method_8429(param_01);
	param_01 scripts\cp\maps\cp_rave\cp_rave::cp_rave_give_weapon(param_00,param_01);
	if(!isdefined(param_01.saw_clip))
	{
		param_01.saw_clip = weaponclipsize(param_00.script_noteworthy);
	}

	if(issubstr(param_00.script_noteworthy,"+akimbo") && !isdefined(param_01.saw_left_clip))
	{
		param_01.saw_left_clip = weaponclipsize(param_00.script_noteworthy);
	}

	if(!isdefined(param_01.saw_stock))
	{
		param_01.saw_stock = function_0249(param_00.script_noteworthy);
	}

	param_00 thread watch_player_ammo_count_for_player(param_00,param_01,"iw7_slasher_zm");
	param_01 thread watch_for_saw_removed(param_00,param_01);
}

//Function Number: 73
watch_for_saw_removed(param_00,param_01)
{
	param_00 notify("watch_for_weapon_removed_" + param_01.name);
	param_00 thread wait_for_saw_disowned(param_00,param_01);
	level thread scripts\cp\maps\cp_rave\cp_rave::watch_player_disconnect(param_00,param_01);
	param_01 thread wait_for_saw_removed(param_00,param_01);
	param_01 thread saw_wait_for_player_death(param_00,param_01);
}

//Function Number: 74
saw_wait_for_player_death(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("disconnect");
	param_01 endon("watch_for_weapon_removed_" + param_01.name);
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
			if(getweaponbasename(var_07) == getweaponbasename(param_00.script_noteworthy))
			{
				param_01 thread wait_for_saw_removed(param_00,param_01);
				var_02 = 1;
				break;
			}
		}
	}

	param_00 notify("weapon_disowned_" + param_00.script_noteworthy);
}

//Function Number: 75
wait_for_saw_removed(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("last_stand");
	param_01 endon("disconnect");
	param_00 endon("watch_for_weapon_removed_" + param_01.name);
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
			if(getweaponbasename(var_05) == getweaponbasename(param_00.script_noteworthy))
			{
				var_02 = 1;
				break;
			}
		}
	}

	param_00 notify("weapon_disowned_" + param_00.script_noteworthy);
}

//Function Number: 76
wait_for_saw_disowned(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("watch_for_weapon_removed_" + param_01.name);
	param_00.should_be_hidden = 1;
	param_00 waittill("weapon_disowned_" + param_00.script_noteworthy);
	param_00.should_be_hidden = undefined;
	if(isdefined(param_01))
	{
		param_00 scripts\cp\_interaction::func_175D(param_00,param_01);
		param_00.trigger showtoplayer(param_01);
	}
}

//Function Number: 77
init_challenge_stations()
{
	wait(5);
	var_00 = getentarray("challenge_power","targetname");
	var_01 = getentarray("challenge_pole","targetname");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.script_noteworthy) || int(var_03.script_noteworthy) != 0)
		{
			continue;
		}

		var_04 = scripts\common\utility::getclosest(var_03.origin,level.current_interaction_structs);
		var_04.challenge_stations = scripts\common\utility::func_782F(var_03.origin,var_01,undefined,4);
		var_04.var_D719 = scripts\common\utility::getclosest(var_03.origin,var_00);
		foreach(var_06 in var_04.challenge_stations)
		{
			var_06.var_9A09 = var_04;
			var_06 thread scripts\cp\maps\cp_rave\cp_rave_challenges::challenge_station_visibility_monitor();
		}

		level thread scripts\cp\maps\cp_rave\cp_rave_challenges::power_visiblity_monitor(var_04.var_D719,var_04.var_EEFA);
	}
}