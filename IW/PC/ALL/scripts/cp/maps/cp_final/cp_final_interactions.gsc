/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_final\cp_final_interactions.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 2532 ms
 * Timestamp: 10/27/2023 12:05:13 AM
*******************************************************************/

//Function Number: 1
register_interactions()
{
	registerdoorinteractions();
	scripts\cp\_interaction::func_DEBB("weapon_upgrade","pap",undefined,::scripts\cp\maps\cp_final\cp_final_weapon_upgrade::weapon_upgrade_hint_func,::scripts\cp\maps\cp_final\cp_final_weapon_upgrade::func_13C62,5000,1,::scripts\cp\maps\cp_final\cp_final_weapon_upgrade::init_weapon_upgrade);
	levelinteractionregistration(1,"pap_fusebox",undefined,undefined,::blankhintfunc,::pickupfuse,0,0,::init_pap_fuses);
	func_DE92();
	register_arcade_roms();
	register_pap_interactions();
	registeratminteractions();
	levelinteractionregistration(1,"fig_1",undefined,undefined,::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint,::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func,0,0,::scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig1);
	levelinteractionregistration(1,"fig_2",undefined,undefined,::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint,::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func,0,0,::scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig2);
	levelinteractionregistration(1,"fig_3",undefined,undefined,::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint,::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func,0,0,::scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig3);
	levelinteractionregistration(1,"fig_4",undefined,undefined,::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_hint,::scripts\cp\maps\cp_final\cp_final_venomx_quest::fig_func,0,0,::scripts\cp\maps\cp_final\cp_final_venomx_quest::init_fig4);
	levelinteractionregistration(1,"emp_console",undefined,undefined,::scripts\cp\maps\cp_final\cp_final_rhino_boss::empconsolehint,::scripts\cp\maps\cp_final\cp_final_rhino_boss::empconsoleuse,0,0);
	scripts\cp\maps\cp_final\cp_final_fast_travel::register_portal_interactions();
	scripts\cp\maps\cp_final\cp_final_mpq::registermpqinteractions();
	scripts\cp\maps\cp_final\cp_final_venomx_quest::init_venomx_models_interactions();
	weaponinteractions();
	scripts\cp\maps\cp_final\cp_final_traps::register_traps();
	func_DEA7();
	if(isdefined(level.escape_interaction_registration_func))
	{
		[[ level.escape_interaction_registration_func ]]();
	}

	register_ritual_circle_interactions();
	foreach(var_01 in scripts\common\utility::getstructarray("iw7_kbs_zm","script_noteworthy"))
	{
		var_01.var_4C72 = 96;
	}

	scripts\common\utility::flag_set("interactions_initialized");
}

//Function Number: 2
structhacks()
{
	move_struct((3853.5,-4291.5,93.5),(3845,-4252,92),(326.979,62.3168,-86.8204));
}

//Function Number: 3
move_struct(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getclosest(param_00,level.struct,500);
	var_03.origin = param_01;
	if(isdefined(param_02))
	{
		var_03.angles = param_02;
	}
}

//Function Number: 4
registerdoorinteractions()
{
	level.interaction_hintstrings["debris_350"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1000"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1500"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_2000"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_2500"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_1250"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["debris_750"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	level.interaction_hintstrings["team_door_switch"] = &"CP_TOWN_INTERACTIONS_TEAM_DOOR_SWITCH";
	level.interaction_hintstrings["power_door_sliding"] = &"CP_FINAL_INTERACTIONS_SYSTEM_OFFLINE";
	level.interaction_hintstrings["power_door_sliding"] = &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
	levelinteractionregistration(0,"debris_350","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,350,0,undefined);
	levelinteractionregistration(0,"debris_1000","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1000,0,undefined);
	levelinteractionregistration(0,"debris_1500","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1500,0,undefined);
	levelinteractionregistration(0,"debris_2000","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,2000,0,undefined);
	levelinteractionregistration(0,"debris_2500","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,2500,0,undefined);
	levelinteractionregistration(0,"debris_1250","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,1250,0,undefined);
	levelinteractionregistration(0,"debris_750","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_4142,750,0,undefined);
	levelinteractionregistration(0,"team_door_switch","door_buy",undefined,undefined,::scripts\cp\zombies\interaction_openareas::func_1302F,250,0,undefined);
	levelinteractionregistration(0,"facility_sliding_door_750","door_buy",undefined,::slidingdoorhint,::openslidingdoor,750,0,::initslidingdoor);
	levelinteractionregistration(0,"facility_sliding_door_1000","door_buy",undefined,::slidingdoorhint,::openslidingdoor,1000,0,undefined);
	levelinteractionregistration(0,"facility_sliding_door_1250","door_buy",undefined,::slidingdoorhint,::openslidingdoor,1250,0,undefined);
	levelinteractionregistration(0,"facility_sliding_door_1500","door_buy",undefined,::slidingdoorhint,::openslidingdoor,1250,0,undefined);
	levelinteractionregistration(0,"facility_sliding_door_2000","door_buy",undefined,::slidingdoorhint,::openslidingdoor,2000,0,undefined);
	levelinteractionregistration(0,"power_door_sliding","door_buy",undefined,undefined,undefined,0,1,::scripts\cp\zombies\interaction_openareas::func_9749);
}

//Function Number: 5
register_ritual_circle_interactions()
{
}

//Function Number: 6
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

//Function Number: 7
register_arcade_roms()
{
	level.interaction_hintstrings["arcade_hero"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_icehock"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_seaques"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_boxing"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_oink"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_keyston"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_plaque"] = &"COOP_INTERACTIONS_PLAY_GAME";
	level.interaction_hintstrings["arcade_crackpo"] = &"COOP_INTERACTIONS_PLAY_GAME";
	scripts\cp\_interaction::func_DEBB("arcade_hero","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_icehock","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_seaques","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_boxing","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_oink","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_keyston","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_plaque","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
	scripts\cp\_interaction::func_DEBB("arcade_crackpo","arcade_game",undefined,undefined,::lib_0D46::func_12FA3,0,1);
}

//Function Number: 8
func_DEA7()
{
	scripts\cp\_interaction::func_DEBB("pillage_item",undefined,undefined,::lib_0D5E::func_CB59,::lib_0D5E::func_D31E,0,0);
}

//Function Number: 9
level_specific_wait_for_interaction_triggered(param_00)
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
			continue;
		}

		if(!scripts\common\utility::istrue(param_00.dontdelaytrigger))
		{
			param_00.var_127BA = 1;
			param_00 thread scripts\cp\_interaction::func_50FA();
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
				continue;
			}
		}
		else if(param_00.script_noteworthy == "lost_and_found")
		{
			if(!scripts\common\utility::istrue(self.var_8C46))
			{
				continue;
			}

			if(isdefined(self.var_B0A2) && self.var_B0A2 != param_00)
			{
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
				continue;
			}

			var_03 = var_01 getcurrentweapon();
			level.var_D8C6 = var_01 getcurrentweapon();
			var_04 = scripts\cp\_weapon::func_7D62(var_03);
			if(scripts\common\utility::istrue(var_01.has_zis_soul_key) || scripts\common\utility::istrue(level.placed_alien_fuses))
			{
				if(var_04 == 3)
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_UPGRADE_MAXED");
					continue;
				}
				else if(scripts\cp\maps\cp_final\cp_final_weapon_upgrade::func_385F(var_03,1))
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
				continue;
			}
			else if(scripts\cp\maps\cp_final\cp_final_weapon_upgrade::func_385F(var_03))
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
				continue;
			}
		}
		else if(scripts\cp\_interaction::func_9A28(param_00))
		{
			if(scripts\cp\_utility::func_9D18())
			{
				continue;
			}

			var_05 = var_01 getcurrentweapon();
			var_06 = scripts\cp\_utility::func_7DF7(var_05);
			if(scripts\cp\_weapon::func_8BBB(param_00.script_noteworthy))
			{
				if(!scripts\cp\_interaction::func_383D(param_00.script_noteworthy))
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_GAME_PLAY_AMMO_MAX");
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

			if(isdefined(level.fnf_cost))
			{
				var_02 = level.fnf_cost;
			}
		}
		else if(scripts\cp\_interaction::interaction_is_sliding_door(param_00))
		{
			if(scripts\common\utility::istrue(param_00.player_opened))
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

			continue;
		}

		if(param_00.script_noteworthy == "atm_withdrawal")
		{
			if(isdefined(level.var_2417))
			{
				if(level.var_2416 < level.var_2417)
				{
					scripts\cp\_interaction::func_9A3C(param_00,&"COOP_INTERACTIONS_NEED_MONEY");
					continue;
				}
			}
		}

		thread scripts\cp\_interaction::func_9A33(param_00);
		if(scripts\cp\_interaction::func_9A28(param_00))
		{
			level notify("interaction",param_00.name,param_00,self);
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
		param_00.var_127BA = undefined;
	}
}

//Function Number: 10
level_specific_player_interaction_monitor()
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

//Function Number: 11
weaponinteractions()
{
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("cp/zombies/cp_final_weapontable.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		var_02 = tablelookupbyrow("cp/zombies/cp_final_weapontable.csv",var_00,2);
		if(!issubstr(var_02,"wall"))
		{
			var_00++;
			continue;
		}

		var_03 = int(tablelookupbyrow("cp/zombies/cp_final_weapontable.csv",var_00,4));
		var_04 = tablelookupbyrow("cp/zombies/cp_final_weapontable.csv",var_00,1);
		level.interaction_hintstrings[var_04] = &"CP_TOWN_INTERACTIONS_BUY_WEAPON";
		levelinteractionregistration(0,var_04,"wall_buy",undefined,::lib_0D2C::func_7D50,::lib_0D2C::func_9A38,var_03);
		var_00++;
	}
}

//Function Number: 12
registeratminteractions()
{
	level.interaction_hintstrings["atm_deposit"] = &"CP_TOWN_INTERACTIONS_ATM_DEPOSIT";
	level.interaction_hintstrings["atm_withdrawal"] = &"CP_TOWN_INTERACTIONS_ATM_WITHDRAWAL";
	levelinteractionregistration(0,"atm_deposit","atm",undefined,::scripts\cp\_interaction::atm_deposit_hint,::atm_deposit,1000,0,undefined);
	levelinteractionregistration(0,"atm_withdrawal","atm",undefined,::atm_withdrawal_hint,::atm_withdrawal,0,0,::setup_atm_system);
}

//Function Number: 13
levelinteractionregistration(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
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

//Function Number: 14
blankusefunc(param_00,param_01)
{
}

//Function Number: 15
blankhintfunc(param_00,param_01)
{
	return "";
}

//Function Number: 16
use_ritual_site(param_00,param_01)
{
}

//Function Number: 17
setup_atm_system()
{
	level.var_2417 = 1000;
	level.var_2416 = 0;
	var_00 = scripts\common\utility::array_combine(scripts\common\utility::getstructarray("atm_deposit","script_noteworthy"),scripts\common\utility::getstructarray("atm_withdrawal","script_noteworthy"));
	foreach(var_02 in var_00)
	{
		var_02.var_E1B9 = 0;
		var_02.var_D776 = 1;
	}
}

//Function Number: 18
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

//Function Number: 19
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

//Function Number: 20
atm_withdrawal_hint(param_00,param_01)
{
	if(param_00.var_E1B9 && !param_00.var_D776)
	{
		return &"CP_FINAL_INTERACTIONS_SYSTEM_OFFLINE";
	}

	if(isdefined(level.var_2416) && level.var_2416 < 1000)
	{
		return &"CP_TOWN_INTERACTIONS_ATM_INSUFFICIENT_FUNDS";
	}

	return level.interaction_hintstrings[param_00.script_noteworthy];
}

//Function Number: 21
register_pap_interactions()
{
	scripts\cp\_interaction::func_DEBB("pap_portal","fast_travel",undefined,::pap_portal_hint,::scripts\cp\maps\cp_final\cp_final_fast_travel::func_E7F4,0,1,::init_pap_portal);
	levelinteractionregistration(1,"brute_interaction",undefined,undefined,::blankhintfunc,::use_brute_func,0,1,::init_brute_func);
	levelinteractionregistration(1,"sasquatch_interaction",undefined,undefined,::blankhintfunc,::use_sasquatch_func,0,1,::init_sasquatch_func);
	levelinteractionregistration(1,"reel_change",undefined,undefined,::blankhintfunc,::change_reel_func,0,1,::init_reel_change_func);
	levelinteractionregistration(1,"zis_reel",undefined,undefined,::blankhintfunc,::pickup_zis_reel,0,1,::init_zis_reel);
	levelinteractionregistration(1,"construct_bridge",undefined,undefined,::scripts\cp\maps\cp_final\cp_final_mpq::constructbridgehint,::scripts\cp\maps\cp_final\cp_final_mpq::constructbridgeuse,0,1,::scripts\cp\maps\cp_final\cp_final_mpq::constructbridgeinit);
}

//Function Number: 22
init_pap_fuses()
{
	level endon("game_ended");
	scripts\common\utility::flag_init("opened_fusebox");
	scripts\common\utility::flag_init("picked_up_uncharged_fuses");
	scripts\common\utility::flag_init("fuses_charged");
	level thread watch_for_open_fusebox();
}

//Function Number: 23
watch_for_open_fusebox()
{
	var_00 = getent("fuse_box_damage_trigger","targetname");
	for(;;)
	{
		if(isdefined(var_00))
		{
			var_00 waittill("damage",var_01,var_02);
			if(!isdefined(var_02))
			{
				continue;
			}

			var_03 = getent("fuse_box_door_moveable","script_noteworthy");
			var_04 = scripts\common\utility::getstruct("fuse_box_door_open","script_noteworthy");
			var_03 rotateto(var_04.angles,0.3);
			scripts\common\utility::flag_set("opened_fusebox");
			playsoundatpos(var_03.origin,"zmb_pap_fuse_box_open");
			var_00 delete();
			break;
		}
		else
		{
			level waittill("forever");
		}
	}
}

//Function Number: 24
pickupfuse(param_00,param_01)
{
	if(!scripts\common\utility::flag("opened_fusebox"))
	{
		return;
	}

	var_02 = getentarray("pap_fuses","targetname");
	var_03 = scripts\common\utility::func_782F(param_00.origin,var_02,undefined,2);
	param_01 thread scripts\cp\_vo::try_to_play_vo("quest_pap_fuse_uncharged","zmb_comment_vo");
	scripts\common\utility::flag_set("picked_up_uncharged_fuses");
	generic_pickup_gesture_and_fx(param_01,var_03[0].origin);
	foreach(var_05 in level.players)
	{
		var_05 setclientomnvar("zm_special_item",5);
	}

	foreach(var_08 in var_03)
	{
		var_08 delete();
	}

	param_00 scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
}

//Function Number: 25
init_pap_portal()
{
	scripts\common\utility::flag_init("disable_portals");
	scripts\common\utility::flag_init("fuses_inserted");
	var_00 = scripts\common\utility::getstruct("pap_portal","script_noteworthy");
	var_00.end_positions = scripts\common\utility::getstructarray(var_00.target,"targetname");
}

//Function Number: 26
pap_portal_hint(param_00,param_01)
{
	if(scripts\common\utility::flag("disable_portals") || !param_01 scripts\cp\_utility::isteleportenabled())
	{
		return "";
	}

	if(isdefined(param_00.var_4622))
	{
		return &"COOP_INTERACTIONS_COOLDOWN";
	}

	return &"CP_FINAL_ENTER_PAP_PORTAL";
}

//Function Number: 27
init_brute_func()
{
	scripts\common\utility::flag_init("pulled_out_helmet");
	scripts\common\utility::flag_init("obtained_brute_helmet");
	scripts\common\utility::flag_init("placed_brute_helmet");
}

//Function Number: 28
init_sasquatch_func()
{
	scripts\common\utility::flag_init("placed_uncharged_fuses");
	scripts\common\utility::flag_init("picked_up_charged_fuses");
}

//Function Number: 29
use_sasquatch_func(param_00,param_01)
{
	if(scripts\common\utility::flag("fuses_charged") && !scripts\common\utility::flag("picked_up_charged_fuses"))
	{
		scripts\common\utility::flag_set("picked_up_charged_fuses");
		var_02 = getent("fuses_to_power","targetname");
		generic_pickup_gesture_and_fx(param_01,var_02.origin);
		foreach(var_04 in level.players)
		{
			var_04 setclientomnvar("zm_special_item",1);
		}

		var_02 delete();
		level.has_picked_up_fuses = 1;
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		return;
	}

	if(scripts\common\utility::flag("picked_up_uncharged_fuses") && !scripts\common\utility::flag("placed_uncharged_fuses"))
	{
		foreach(var_04 in level.players)
		{
			var_04 setclientomnvar("zm_special_item",0);
		}

		scripts\common\utility::flag_set("placed_uncharged_fuses");
		var_08 = scripts\common\utility::getstruct(param_00.target,"targetname");
		var_09 = var_08.origin;
		generic_place_gesture_and_fx(param_01,var_09);
		var_0A = spawn("script_model",var_09);
		var_0A.var_336 = "fuses_to_power";
		var_0A.angles = var_08.angles;
		var_0A setmodel("cp_final_alien_fuse_combined");
		level.fuse_in_hand = var_0A;
		check_for_charge_fuse_sequence(param_00,param_01);
	}
}

//Function Number: 30
use_brute_func(param_00,param_01)
{
	if(scripts\common\utility::flag("obtained_brute_helmet") && !scripts\common\utility::flag("placed_brute_helmet"))
	{
		scripts\common\utility::flag_set("placed_brute_helmet");
		var_02 = scripts\common\utility::getstruct(param_00.target,"targetname");
		generic_place_gesture_and_fx(param_01,var_02);
		level.helmet_on_brute.origin = var_02.origin;
		level.helmet_on_brute.angles = var_02.angles;
		level.helmet_on_brute notify("end_entangler_funcs");
		level.helmet_on_brute show();
		scripts\cp\_utility::set_quest_icon(1);
		check_for_charge_fuse_sequence(param_00,param_01);
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	}
}

//Function Number: 31
check_for_charge_fuse_sequence(param_00,param_01)
{
	if(scripts\common\utility::flag("placed_brute_helmet") && scripts\common\utility::flag("placed_uncharged_fuses"))
	{
		var_02 = scripts\common\utility::getstruct("helmet_shoot_point","targetname");
		var_03 = spawn("script_model",var_02.origin);
		var_03 setmodel("tag_origin");
		thread playfusechargesounds(var_02,var_03);
		level thread playpapupgradevo(param_01);
		var_04 = function_02DF(scripts\common\utility::getfx("vfx_charge_fuse_beam"),var_03,"tag_origin",level.fuse_in_hand,"tag_origin");
		level thread charging_sequence_rumble(param_00);
		level thread changetochargedfuses();
		var_05 = getent("fuse_laser_trigger","script_noteworthy");
		var_05 thread scripts\cp\maps\cp_final\cp_final_traps::damage_enemies_in_trigger(var_03,level.fuse_in_hand,var_05,1);
		wait(6);
		var_04 delete();
		var_03 delete();
		var_05 notify("death");
		level notify("stop_charging_fuse");
		scripts\common\utility::flag_set("fuses_charged");
		param_01 thread scripts\cp\_vo::try_to_play_vo("quest_pap_fuse_charged","zmb_comment_vo");
	}
}

//Function Number: 32
changetochargedfuses()
{
	level endon("game_ended");
	wait(0.1);
	level.fuse_in_hand setmodel("cp_final_alien_fuse_combined_on");
	level.fuse_effect = playfxontag(level._effect["fuse_charged"],level.fuse_in_hand,"tag_origin");
}

//Function Number: 33
playpapupgradevo(param_00)
{
	if(isdefined(param_00.var_134FD))
	{
		switch(param_00.var_134FD)
		{
			case "p1_":
				if(!isdefined(level.var_4481["conv_pap_upgrade_sally_1_1"]))
				{
					level thread scripts\cp\_vo::try_to_play_vo("conv_pap_upgrade_sally_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["conv_pap_upgrade_sally_1_1"] = 1;
				}
				break;

			case "p2_":
				if(!isdefined(level.var_4481["conv_pap_upgrade_pdex_1_1"]))
				{
					level thread scripts\cp\_vo::try_to_play_vo("conv_pap_upgrade_pdex_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["conv_pap_upgrade_pdex_1_1"] = 1;
				}
				break;

			case "p3_":
				if(!isdefined(level.var_4481["conv_pap_upgrade_andre_1_1"]))
				{
					level thread scripts\cp\_vo::try_to_play_vo("conv_pap_upgrade_andre_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["conv_pap_upgrade_andre_1_1"] = 1;
				}
				break;

			case "p4_":
				if(!isdefined(level.var_4481["conv_pap_upgrade_aj_1_1"]))
				{
					level thread scripts\cp\_vo::try_to_play_vo("conv_pap_upgrade_aj_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
					level.var_4481["conv_pap_upgrade_aj_1_1"] = 1;
				}
				break;
		}
	}
}

//Function Number: 34
playfusechargesounds(param_00,param_01)
{
	level endon("game_ended");
	playsoundatpos(param_00.origin,"zmb_pap_brute_laser_start");
	wait(0.25);
	param_01 playloopsound("zmb_pap_brute_laser_lp");
	wait(4.8);
	param_01 stoploopsound();
	playsoundatpos(param_00.origin,"zmb_pap_brute_laser_end");
}

//Function Number: 35
charging_sequence_rumble(param_00)
{
	level endon("stop_charging_fuse");
	for(;;)
	{
		wait(0.15);
		earthquake(0.18,1,param_00.origin,784);
		wait(0.05);
		playrumbleonposition("artillery_rumble",param_00.origin);
	}
}

//Function Number: 36
init_reel_change_func()
{
	scripts\common\utility::flag_init("set_movie_spaceland");
}

//Function Number: 37
change_reel_func(param_00,param_01)
{
	if(scripts\common\utility::flag("has_film_reel"))
	{
		playsoundatpos(param_00.origin,"zmb_pap_film_reel_placement");
		scripts\common\utility::flag_set("set_movie_spaceland");
		generic_place_gesture_and_fx(param_01,param_00.origin + (-3,0,75));
		level.movie_playing = "cp_zmb_screen_640";
		function_030E(level.movie_playing);
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	}
}

//Function Number: 38
init_zis_reel()
{
	scripts\common\utility::flag_init("has_film_reel");
}

//Function Number: 39
pickup_zis_reel(param_00,param_01)
{
	scripts\common\utility::flag_set("has_film_reel");
	scripts\cp\_utility::set_quest_icon(3);
	var_02 = getent(param_00.target,"targetname");
	generic_pickup_gesture_and_fx(param_01,var_02.origin);
	var_02 hide();
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
}

//Function Number: 40
initslidingdoor()
{
	var_00 = scripts\common\utility::getstructarray("facility_sliding_door_750","script_noteworthy");
	var_01 = scripts\common\utility::getstructarray("facility_sliding_door_1000","script_noteworthy");
	var_02 = scripts\common\utility::getstructarray("facility_sliding_door_1250","script_noteworthy");
	var_03 = scripts\common\utility::getstructarray("facility_sliding_door_1500","script_noteworthy");
	var_04 = scripts\common\utility::getstructarray("facility_sliding_door_2000","script_noteworthy");
	var_00 = scripts\common\utility::array_combine(var_00,var_01);
	var_00 = scripts\common\utility::array_combine(var_00,var_02,var_03,var_04);
	var_00 = scripts\common\utility::func_22AF(var_00);
	level.allslidingdoors = var_00;
	foreach(var_06 in var_00)
	{
		var_06.var_4284 = 1;
		var_06.var_D71C = scripts\cp\_interaction::func_7829(var_06);
		var_06.var_5A2B = [];
		var_07 = getentarray(var_06.target,"targetname");
		foreach(var_09 in var_07)
		{
			if(isdefined(var_09.classname) && var_09.classname == "script_brushmodel")
			{
				continue;
			}

			if(!isdefined(var_09.script_noteworthy))
			{
			}

			var_09.var_C3A2 = var_09.origin;
			var_06.var_5A2B[var_06.var_5A2B.size] = var_09;
		}
	}
}

//Function Number: 41
slidingdoorhint(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_00.var_E1B9))
	{
		return &"CP_FINAL_INTERACTIONS_SYSTEM_OFFLINE";
	}

	if(scripts\common\utility::istrue(param_00.player_opened))
	{
		param_01.var_9A3F method_852E(level.enter_area_hint);
		return &"CP_FINAL_INTERACTIONS_OPEN_AREA";
	}

	var_02 = int(level.interactions[param_00.script_noteworthy].cost);
	param_01.var_9A3F method_852E(level.enter_area_hint,var_02);
	return &"CP_TOWN_INTERACTIONS_PURCHASE_AREA";
}

//Function Number: 42
openslidingdoor(param_00,param_01)
{
	level endon("game_ended");
	if(scripts\common\utility::istrue(param_00.var_E1B9))
	{
		level scripts\common\utility::waittill_any_3("power_on",param_00.var_D71C + " power_on");
		param_00.var_D776 = 1;
	}

	var_02 = [];
	foreach(var_04 in level.allslidingdoors)
	{
		if(var_04.target == param_00.target)
		{
			var_02[var_02.size] = var_04;
		}
	}

	foreach(var_04 in var_02)
	{
		var_04.var_C626 = 1;
		var_04.var_4284 = 0;
	}

	while(scripts\common\utility::istrue(param_00.var_42AF))
	{
		scripts\common\utility::func_136F7();
	}

	foreach(var_04 in var_02)
	{
		var_04.var_C62C = 1;
	}

	if(isdefined(param_01) && isplayer(param_01))
	{
		if(!scripts\common\utility::istrue(param_00.player_opened))
		{
			if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
			{
				param_01 scripts\cp\_merits::func_D9AD("mt_purchase_doors");
			}

			param_01 notify("door_opened_notify");
			scripts\cp\_persistence::increment_player_career_doors_opened(param_01);
			level notify("door_opened_notify");
			foreach(var_04 in var_02)
			{
				if(var_04.target == param_00.target)
				{
					var_04.player_opened = 1;
				}
			}
		}
	}

	var_0C = getentarray(param_00.target,"targetname");
	foreach(var_0E in var_0C)
	{
		if(isdefined(var_0E.classname) && var_0E.classname == "script_brushmodel")
		{
			continue;
		}

		var_0E setscriptablepartstate("door","open");
	}

	foreach(var_04 in var_02)
	{
		if(var_04.target == param_00.target)
		{
			scripts\cp\zombies\zombies_spawning::func_F28B(var_04);
		}
	}

	wait(0.4);
	foreach(var_0E in var_0C)
	{
		if(isdefined(var_0E.classname) && var_0E.classname == "script_brushmodel")
		{
			var_0E connectpaths();
			var_0E notsolid();
		}
	}

	wait(1.1);
	scripts\cp\_interaction::func_554F(param_00);
	scripts\cp\zombies\zombies_spawning::func_F28B(param_00);
	scripts\cp\zombies\zombies_spawning::func_15FC(param_00.script_area);
	foreach(var_04 in var_02)
	{
		var_04.var_C62C = undefined;
	}
}

//Function Number: 43
closeslidingdoor(param_00,param_01)
{
	level endon("game_ended");
	var_02 = [];
	foreach(var_04 in level.allslidingdoors)
	{
		if(var_04.target == param_00.target)
		{
			var_02[var_02.size] = var_04;
		}
	}

	var_06 = undefined;
	foreach(var_04 in var_02)
	{
		if(var_04 != param_00 && var_04.target == param_00.target)
		{
			var_06 = var_04;
		}

		var_04.var_C626 = undefined;
		var_04.var_4284 = 1;
	}

	while(scripts\common\utility::istrue(param_00.var_C62C))
	{
		scripts\common\utility::func_136F7();
	}

	foreach(var_04 in var_02)
	{
		var_04.var_42AF = 1;
	}

	var_0B = getentarray(param_00.target,"targetname");
	foreach(var_0D in var_0B)
	{
		if(isdefined(var_0D.classname) && var_0D.classname == "script_brushmodel")
		{
			if(scripts\common\utility::istrue(param_00.player_opened))
			{
				var_0D connectpaths();
			}
			else
			{
				var_0D disconnectpaths();
			}

			var_0D solid();
			continue;
		}

		var_0D setscriptablepartstate("door","close");
	}

	wait(0.3);
	if(isdefined(var_06))
	{
		var_0F = vectornormalize(var_06.origin - param_00.origin);
		var_10 = scripts\common\utility::func_782F(param_00.origin,level.var_3CB5,undefined,undefined,40,0);
		var_11 = param_00.var_5A2B[0].origin;
		foreach(var_13 in var_10)
		{
			if(vectordot(vectornormalize(var_06.origin - param_00.origin),var_0F) > 0.75)
			{
				if(distance(param_00.origin,var_06.origin) > distance(var_13.origin,param_00.origin))
				{
					if(distance(var_11,var_13.origin) <= 16)
					{
						var_14 = scripts\common\utility::getclosest(var_13.origin,[var_06,param_00]);
						if(isplayer(var_13))
						{
							if(!var_13 scripts\cp\_utility::is_valid_player())
							{
								var_13 setvelocity(var_14.origin);
								continue;
							}
						}
						else if(var_13 scripts\cp\_utility::agentisinstakillimmune())
						{
							continue;
						}
						else
						{
							var_13.var_54CB = 1;
							var_13.died_poorly_health = var_13.health;
						}

						var_13 setvelocity(var_14.origin);
						var_13 dodamage(var_13.maxhealth,var_06.origin,undefined,undefined,"MOD_UNKNOWN","iw7_zombieDoors_zm");
					}
				}
			}
		}
	}

	if(!scripts\common\utility::istrue(param_00.nointeraction))
	{
		scripts\cp\_interaction::func_6214(param_00);
	}

	wait(0.45);
	foreach(var_04 in var_02)
	{
		var_04.var_42AF = undefined;
	}
}

//Function Number: 44
helmet_useable()
{
	self makeusable();
	self sethintstring(&"CP_FINAL_INTERACTIONS_PICKUP_BRUTE_HELMET");
}

//Function Number: 45
helmet_not_useable()
{
	self method_851B();
	self makeunusable();
}

//Function Number: 46
pickup_helmet()
{
	helmet_useable();
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isdefined(var_00.kicked_out))
		{
			scripts\common\utility::flag_set("obtained_brute_helmet");
			var_00 thread scripts\cp\_vo::try_to_play_vo("quest_pap_helmet","zmb_comment_vo");
			scripts\cp\_utility::set_quest_icon(1);
			generic_pickup_gesture_and_fx(var_00,self.origin);
			helmet_not_useable();
			self hide();
		}
	}
}

//Function Number: 47
generic_pickup_gesture_and_fx(param_00,param_01)
{
	param_00 endon("disconnect");
	if(function_02A6(param_01) || !function_02A5(param_01))
	{
		param_01 = param_01.origin;
	}

	param_00 thread scripts\cp\_utility::func_1308C(param_00,"iw7_swipegrab_zm");
	wait(0.28);
	playfx(level._effect["generic_pickup"],param_01);
	param_00 playlocalsound("part_pickup");
}

//Function Number: 48
generic_place_gesture_and_fx(param_00,param_01)
{
	param_00 endon("disconnect");
	if(function_02A6(param_01) || !function_02A5(param_01))
	{
		param_01 = param_01.origin;
	}

	param_00 thread scripts\cp\_utility::func_1308C(param_00,"iw7_placethrow_zm");
	wait(0.35);
	playfx(level._effect["generic_pickup"],param_01);
	param_00 playlocalsound("part_pickup");
}