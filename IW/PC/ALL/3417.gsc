/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3417.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 168
 * Decompile Time: 153 ms
 * Timestamp: 10/27/2023 12:27:09 AM
*******************************************************************/

//Function Number: 1
func_9589()
{
	level.var_456B = [];
	setup_irish_luck_consumables();
	func_C8FE();
}

//Function Number: 2
setup_irish_luck_consumables()
{
	level.irish_luck_consumables = [];
	level.irish_luck_consumables["grenade_cooldown"] = [];
	level.irish_luck_consumables["spawn_reboard_windows"] = [];
	level.irish_luck_consumables["burned_out"] = [];
	level.irish_luck_consumables["faster_health_regen_upgrade"] = [];
	level.irish_luck_consumables["sniper_soft_upgrade"] = [];
	level.irish_luck_consumables["extra_sniping_points"] = [];
	level.irish_luck_consumables["shock_melee_upgrade"] = [];
	level.irish_luck_consumables["penetration_gun"] = [];
	level.irish_luck_consumables["bonus_damage_on_last_bullets"] = [];
	level.irish_luck_consumables["reload_damage_increase"] = [];
	level.irish_luck_consumables["door_buy_refund"] = [];
	level.irish_luck_consumables["faster_window_reboard"] = [];
	level.irish_luck_consumables["headshot_explosion"] = [];
	level.irish_luck_consumables["increased_melee_damage"] = [];
	level.irish_luck_consumables["sharp_shooter_upgrade"] = [];
	level.irish_luck_consumables["spawn_double_money"] = [];
	level.irish_luck_consumables["anywhere_but_here"] = [];
	level.irish_luck_consumables["atomizer_gun"] = [];
	level.irish_luck_consumables["bh_gun"] = [];
	level.irish_luck_consumables["claw_gun"] = [];
	level.irish_luck_consumables["damage_booster_upgrade"] = [];
	level.irish_luck_consumables["headshot_reload"] = [];
	level.irish_luck_consumables["hit_reward_upgrade"] = [];
	level.irish_luck_consumables["killing_time"] = [];
	level.irish_luck_consumables["slow_enemy_movement"] = [];
	level.irish_luck_consumables["spawn_infinite_ammo"] = [];
	level.irish_luck_consumables["spawn_instakill"] = [];
	level.irish_luck_consumables["spawn_max_ammo"] = [];
	level.irish_luck_consumables["spawn_nuke"] = [];
	level.irish_luck_consumables["wall_power"] = [];
	level.irish_luck_consumables["ephemeral_enhancement"] = [];
	level.irish_luck_consumables["secret_service"] = [];
	level.irish_luck_consumables["cant_miss"] = [];
	level.irish_luck_consumables["spawn_fire_sale"] = [];
	level.irish_luck_consumables["self_revive"] = [];
	level.irish_luck_consumables["just_a_flesh_wound"] = [];
	level.irish_luck_consumables["force_push_near_death"] = [];
	level.irish_luck_consumables["next_purchase_free"] = [];
	level.irish_luck_consumables["masochist"] = [];
	level.irish_luck_consumables["magic_wheel_upgrade"] = [];
	level.irish_luck_consumables["steel_dragon"] = [];
	level.irish_luck_consumables["timely_torrent"] = [];
	level.irish_luck_consumables["purify"] = [];
	level.irish_luck_consumables["explosive_touch"] = [];
	level.irish_luck_consumables["shared_fate"] = [];
	level.irish_luck_consumables["fire_chains"] = [];
	level.irish_luck_consumables["temporal_increase"] = [];
	level.irish_luck_consumables["twist_of_fate"] = [];
	level.irish_luck_consumables["dodge_mode"] = [];
	level.irish_luck_consumables["ammo_crate"] = [];
	level.irish_luck_consumables["stimulus"] = [];
	level.irish_luck_consumables_gotten = [];
}

//Function Number: 3
func_C8FE()
{
	if(isdefined(level.var_4569))
	{
		var_00 = level.var_4569;
	}
	else
	{
		var_00 = "cp/loot/iw7_zombiefatefortune_loot_master.csv";
	}

	var_01 = 0;
	for(;;)
	{
		var_02 = tablelookupbyrow(var_00,var_01,1);
		if(var_02 == "")
		{
			break;
		}

		var_03 = tablelookupbyrow(var_00,var_01,6);
		var_04 = int(tablelookupbyrow(var_00,var_01,7));
		var_05 = int(tablelookupbyrow(var_00,var_01,8));
		var_06 = int(tablelookupbyrow(var_00,var_01,9));
		func_DEA4(var_02,var_03,var_04,var_05,var_06,::func_82B2,::func_DFDD);
		var_01++;
	}

	func_4565("ephemeral_enhancement",::func_12FEA,undefined,undefined,1);
	func_4565("grenade_cooldown",::func_12FF1,undefined,::func_12955,undefined);
	func_4565("reload_damage_increase",::func_13006,undefined,undefined,undefined);
	func_4565("headshot_reload",::func_12FF2,undefined,undefined,undefined);
	func_4565("anywhere_but_here",::func_12FA2,undefined,undefined,undefined);
	func_4565("now_you_see_me",::func_12FFF,undefined,undefined,undefined);
	func_4565("killing_time",::func_12FF6,undefined,undefined,undefined);
	func_4565("phoenix_up",::func_13002,undefined,undefined,1);
	func_4565("spawn_instakill",::func_1301A,undefined,undefined,1);
	func_4565("spawn_fire_sale",::func_13018,undefined,undefined,1);
	func_4565("spawn_nuke",::func_1301C,undefined,undefined,1);
	func_4565("spawn_double_money",::func_13017,undefined,undefined,1);
	func_4565("spawn_max_ammo",::func_1301B,undefined,undefined,1);
	func_4565("spawn_reboard_windows",::func_1301D,undefined,undefined,1);
	func_4565("spawn_infinite_ammo",::func_13019,undefined,undefined,1);
	func_4565("bh_gun",::func_12FAC,undefined,undefined,1);
	func_4565("atomizer_gun",::func_12FA6,undefined,undefined,1);
	func_4565("claw_gun",::func_12FBB,undefined,undefined,1);
	func_4565("steel_dragon",::func_1302A,undefined,undefined,1);
	func_4565("penetration_gun",::func_13001,undefined,undefined,1);
	func_4565("life_link",::func_12FF8,undefined,undefined,undefined);
	func_4565("slow_enemy_movement",::func_13012,undefined,undefined,undefined);
	func_4565("increased_team_efficiency",::func_12FF5,undefined,undefined,undefined);
	func_4565("welfare",::func_13038,undefined,undefined,undefined);
	func_4565("cant_miss",::func_12FB4,undefined,undefined,undefined);
	func_4565("self_revive",::func_1300E,undefined,undefined,undefined);
	func_4565("force_push_near_death",::func_12FED,undefined,undefined,undefined);
	func_4565("masochist",::func_12FFB,undefined,undefined,undefined);
	func_4565("timely_torrent",::use_timely_torrent,undefined,undefined,1);
	func_4565("purify",::use_purify,undefined,undefined,undefined);
	func_4565("explosive_touch",::use_explosive_touch,undefined,undefined,undefined);
	func_4565("shared_fate",::use_shared_fate,undefined,undefined,undefined);
	func_4565("fire_chains",::use_fire_chains,undefined,undefined,undefined);
	func_4565("irish_luck",::use_irish_luck,undefined,undefined,undefined);
	func_4565("temporal_increase",::use_temporal_increase,undefined,undefined,undefined);
	func_4565("twist_of_fate",::use_twister,undefined,undefined,undefined);
	func_4565("dodge_mode",::use_dodge_mode,undefined,undefined,undefined);
	func_4565("ammo_crate",::use_ammo_crate,undefined,undefined,undefined);
	func_4565("stimulus",::use_stimulus,undefined,undefined,undefined);
	func_4565("activate_gns_machine",::use_activate_gns_machine,undefined,undefined,undefined);
	func_4565("double_pap_weap",::use_get_pap2_gun,undefined,undefined,undefined);
}

//Function Number: 4
func_DEA4(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	var_07.type = param_01;
	var_07.var_130D1 = param_02;
	var_07.var_12F9A = param_03;
	var_07.var_C948 = param_04;
	var_07.var_F286 = param_05;
	var_07.var_12BF4 = param_06;
	var_07.var_1193C = param_00 + "_timeup";
	level.var_456B[param_00] = var_07;
	foreach(var_0A, var_09 in level.irish_luck_consumables)
	{
		if(var_0A == param_00)
		{
			level.irish_luck_consumables[param_00] = level.var_456B[param_00];
			level.irish_luck_consumables[param_00].name = param_00;
		}
	}
}

//Function Number: 5
func_4565(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.var_456B[param_00];
	if(isdefined(param_01))
	{
		var_05.var_13089 = param_01;
	}

	if(isdefined(param_02))
	{
		var_05.var_F286 = param_02;
	}

	if(isdefined(param_03))
	{
		var_05.var_12BF4 = param_03;
	}

	if(isdefined(param_04))
	{
		var_05.var_1174E = param_04;
	}
}

//Function Number: 6
func_96DB()
{
	func_F949();
	func_F524();
	func_1297A(1);
	func_9588();
	func_958C();
}

//Function Number: 7
func_9588()
{
	thread func_B69D();
}

//Function Number: 8
func_958C()
{
	self.var_4572 = [];
	self setplayerdata("common","numConsumables",0);
	for(var_00 = 0;var_00 < 32;var_00++)
	{
		self setplayerdata("common","consumablesUsed",var_00,0);
	}
}

//Function Number: 9
func_F524()
{
	self.var_456B = [];
	for(var_00 = 0;var_00 < 5;var_00++)
	{
		var_01 = self getplayerdata("cp","zombiePlayerLoadout","zombie_consumables",var_00);
		self.var_456B[var_01] = spawnstruct();
		self.var_456B[var_01].var_130D1 = level.var_456B[var_01].var_130D1;
		self.var_456B[var_01].var_C4A4 = 0;
		self.var_456B[var_01].var_11925 = 0;
	}

	self.consumables_pre_irish_luck_usage = self.var_456B;
}

//Function Number: 10
func_1297A(param_00)
{
	var_01 = func_788C(self);
	self setclientomnvar("zm_consumables_remaining",var_01);
	self setclientomnvar("zm_dpad_up_activated",4);
	self.var_1030B = [];
	self playlocalsound("zmb_fnf_replenish");
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		self.var_1030B[self.var_1030B.size] = var_02;
		self setclientomnvarbit("zm_card_selection_count",var_02,1);
	}

	func_12DE5(0);
}

//Function Number: 11
reset_meter()
{
	self notify("give_new_deck");
	self.var_4560 = 0;
	func_9588();
	thread func_ACAF();
	self setclientomnvar("zm_dpad_up_activated",5);
	self setclientomnvar("zm_consumable_selection_ready",0);
}

//Function Number: 12
func_788C(param_00)
{
	var_01 = param_00 isitemunlocked("fate_card_slot_4","fatedecksize",1);
	var_02 = param_00 isitemunlocked("fate_card_slot_5","fatedecksize",1);
	var_03 = 3;
	if(var_01 && var_02)
	{
		var_03 = 5;
	}
	else if(var_01 && !var_02)
	{
		var_03 = 4;
	}
	else if(!var_01 && !var_02)
	{
		var_03 = 3;
	}

	return var_03;
}

//Function Number: 13
func_F949()
{
	self method_8299(1,"");
	self method_8299(2,"");
	self method_8299(3,"");
	self method_8299(4,"");
	self notifyonplayercommand("D_pad_up","+actionslot 1");
	self notifyonplayercommand("D_pad_down","+actionslot 2");
	thread func_13950("super_default_zm");
}

//Function Number: 14
func_13950(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("offhand_fired",var_01);
		if(var_01 == param_00)
		{
			if(scripts\common\utility::istrue(self.inlaststand))
			{
				self setweaponammoclip(param_00,1);
				continue;
			}

			self notify("fired_super");
			self setweaponammoclip(param_00,1);
		}
	}
}

//Function Number: 15
func_5B00()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("consumable_selected");
	self endon("give_new_deck");
	var_00 = 0;
	self setclientomnvar("zm_consumable_selection_ready",1);
	func_12DE5(var_00);
	self.deck_select_ready = 1;
	for(;;)
	{
		var_01 = scripts\common\utility::func_13734("D_pad_up","D_pad_down","fired_super");
		if(self.var_1030B.size <= 0 || scripts\common\utility::istrue(level.disable_consumables) || scripts\common\utility::istrue(self.disable_consumables) || scripts\common\utility::istrue(self.var_1097A) || scripts\common\utility::istrue(self.inlaststand))
		{
			self playlocalsound("ui_consumable_deny");
			wait(0.25);
			continue;
		}

		if(var_01 == "fired_super")
		{
			self.deck_select_ready = undefined;
			thread func_4557(self.var_1030B[var_00],var_00);
		}
		else if(var_01 == "D_pad_up" && self.var_1030B.size > 1)
		{
			self setclientomnvar("zm_dpad_pressed",1);
			var_00 = func_7C52(var_00 + 1,0,self.var_1030B.size - 1);
			func_12DE5(var_00);
			self playlocalsound("ui_consumable_scroll");
		}
		else if(var_01 == "D_pad_down" && self.var_1030B.size > 1)
		{
			self setclientomnvar("zm_dpad_pressed",1);
			var_00 = func_7C52(var_00 - 1,0,self.var_1030B.size - 1);
			func_12DE5(var_00);
			self playlocalsound("ui_consumable_scroll");
		}

		scripts\common\utility::func_136F7();
		self setclientomnvar("zm_dpad_pressed",0);
	}
}

//Function Number: 16
func_12DE5(param_00)
{
	wait(0.1);
	self setclientomnvar("zm_consumable_deck_slot_on",self.var_1030B[param_00]);
	self setclientomnvar("zm_consumables_slot_count",param_00 + 1);
}

//Function Number: 17
func_7C52(param_00,param_01,param_02)
{
	if(param_00 > param_02)
	{
		return param_01;
	}

	if(param_00 < param_01)
	{
		return param_02;
	}

	return param_00;
}

//Function Number: 18
func_DFD4(param_00)
{
	self.var_1030B = scripts\common\utility::func_22A9(self.var_1030B,self.var_1030B[param_00]);
	self setclientomnvar("zm_consumables_remaining",self.var_1030B.size);
	if(isdefined(self.var_1030B[0]))
	{
		self setclientomnvar("zm_consumable_deck_slot_on",self.var_1030B[0]);
	}
}

//Function Number: 19
func_4557(param_00,param_01)
{
	var_02 = self getplayerdata("cp","zombiePlayerLoadout","zombie_consumables",param_00);
	var_03 = "zm_card" + param_00 + 1 + "_drain";
	var_04 = "slot_" + param_00 + 1 + "_used";
	self.var_456B[var_02].var_1307B = var_04;
	if(var_02 == "irish_luck")
	{
		thread consumable_activate_internal_irish(var_02,var_03,"zm_dpad_up_uses","zm_dpad_up_activated",var_04,param_00,param_01);
		return;
	}

	thread func_4558(var_02,var_03,"zm_dpad_up_uses","zm_dpad_up_activated",var_04,param_00,param_01);
}

//Function Number: 20
func_4558(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("dpad_end_" + param_00);
	self endon("give_new_deck");
	if(self.var_456B[param_00].var_130D1 > 0 && self.var_456B[param_00].var_C4A4 == 0 && !scripts\cp\_laststand::player_in_laststand(self))
	{
		self setclientomnvar("zm_fate_card_used",param_05);
		self.var_456B[param_00].var_D9A1 = 1;
		var_07 = undefined;
		var_08 = "fired_super";
		thread func_F306(param_00);
		if(isdefined(level.var_456B[param_00].var_13089))
		{
			if(isdefined(level.var_456B[param_00].var_1174E))
			{
				var_07 = self [[ level.var_456B[param_00].var_13089 ]](param_00);
			}
			else
			{
				var_07 = self thread [[ level.var_456B[param_00].var_13089 ]](param_00);
			}
		}

		if(!isdefined(var_07) || isdefined(var_07) && var_07)
		{
			func_4574(self,param_00);
			self.var_456B[param_00].var_11925++;
			scripts\cp\zombies\zombie_analytics::func_AF6C(1,param_00,level.wave_num,self);
			scripts\cp\_merits::func_D9AD("mt_faf_uses");
			thread scripts\cp\_vo::try_to_play_vo("wonder_consume","zmb_comment_vo","low",10,0,1,0,40);
			if(self.var_456B[param_00].var_11925 == 1)
			{
				thread decrement_counter_of_consumables(param_00);
			}

			self setclientomnvar(param_01,1);
			thread func_ACAF();
			self setclientomnvar("zm_dpad_up_activated",5);
			self setclientomnvarbit("zm_card_fill_display",param_05,1);
			self setclientomnvar("zm_consumable_selection_ready",0);
			func_DFD4(param_06);
			thread func_B69D();
			self playlocalsound("ui_consumable_select");
			func_CCCC(self);
			self notify("consumable_selected");
			thread scripts\cp\_utility::firegesturegrenade(self,self.var_6BA3);
			self.var_4561 = undefined;
			thread scripts\cp\_vo::func_E01F("nag_use_fateandfort");
			var_09 = level.var_456B[param_00].type;
			if(var_09 == "timedactivations")
			{
				thread func_5B02(param_00,level.var_456B[param_00].var_12F9A,param_01,var_08,param_02,param_03,param_04,param_05);
			}
			else if(var_09 == "wave")
			{
				thread func_5B04(param_00,level.var_456B[param_00].var_12F9A,param_01,var_08,param_02,param_03,param_04,param_05);
			}
			else if(var_09 == "triggernow" || level.var_456B[param_00].type == "triggerwait")
			{
				thread func_5B01(param_00,level.var_456B[param_00].type,self.var_456B[param_00].var_130D1,param_01,var_08,param_02,param_03,param_04,param_05);
			}
			else if(var_09 == "triggerpassive")
			{
				thread func_5B03(param_00,level.var_456B[param_00].var_C948,param_01,var_08,param_02,param_03,param_04,param_05);
			}

			if(isdefined(var_07))
			{
				scripts\cp\_utility::func_C151(param_00);
				return;
			}

			return;
		}

		self playlocalsound("ui_consumable_deny");
		self.var_456B[param_00].var_D9A1 = undefined;
	}
}

//Function Number: 21
decrement_counter_of_consumables(param_00)
{
	var_01 = get_consumable_index_in_player_data(self,param_00);
	if(isdefined(var_01))
	{
		var_02 = self getplayerdata("cp","zombiePlayerLoadout","consumables_counter",var_01);
		var_03 = var_02 - 1;
		self setplayerdata("cp","zombiePlayerLoadout","consumables_counter",var_01,var_03);
	}
}

//Function Number: 22
func_CCCC(param_00)
{
	switch(param_00.var_6BA3)
	{
		case "iw7_jockcard_zm":
			param_00 playlocalsound("wondercard_jock_use_gesture");
			break;

		case "iw7_nerdcard_zm":
			param_00 playlocalsound("wondercard_nerd_use_gesture");
			break;

		case "iw7_valleygirlcard_zm":
			param_00 playlocalsound("wondercard_valleygirl_use_gesture");
			break;

		case "iw7_rappercard_zm":
			param_00 playlocalsound("wondercard_rapper_use_gesture");
			break;

		case "iw7_grungecard_zm":
			param_00 playlocalsound("wondercard_gesture_grunge");
			break;

		case "iw7_cholacard_zm":
			param_00 playlocalsound("wondercard_gesture_chola");
			break;

		case "iw7_ravercard_zm":
			param_00 playlocalsound("wondercard_gesture_raver");
			break;

		case "iw7_hiphopcard_zm":
			param_00 playlocalsound("wondercard_gesture_hiphop");
			break;

		case "iw7_survivorcard_zm":
			param_00 playlocalsound("wondercard_gesture_survivor");
			break;

		case "iw7_wylercard_zm":
			param_00 playlocalsound("vm_gest_zmb_willard_wondercard");
			break;

		default:
			param_00 playlocalsound("wondercard_jock_use_gesture");
			break;
	}
}

//Function Number: 23
func_4574(param_00,param_01)
{
	var_02 = func_78DE(param_01);
	if(scripts\common\utility::func_2286(param_00.var_4572,var_02))
	{
		return;
	}

	var_03 = param_00.var_4572.size;
	if(isdefined(level.var_4569))
	{
		var_04 = level.var_4569;
	}
	else
	{
		var_04 = "cp/loot/iw7_zombiefatefortune_loot_master.csv";
	}

	var_05 = tablelookup(var_04,1,param_01,3);
	if(isdefined(var_05))
	{
		if(var_05 == "Fortune")
		{
			param_00 setplayerdata("common","consumablesUsed",var_03,int(var_02));
			var_06 = param_00 getplayerdata("common","numConsumables");
			param_00 setplayerdata("common","numConsumables",var_06 + 1);
			param_00.var_4572 = scripts\common\utility::array_add(param_00.var_4572,var_02);
		}
	}
}

//Function Number: 24
get_consumable_index_in_player_data(param_00,param_01)
{
	for(var_02 = 0;var_02 < 5;var_02++)
	{
		var_03 = param_00 getplayerdata("cp","zombiePlayerLoadout","zombie_consumables",var_02);
		if(param_01 == var_03)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 25
func_ACB0()
{
	self setclientomnvar("lb_gsc_controlled",1);
	self setclientomnvar("lb_color",0);
	self setclientomnvar("lb_pulse_time",1);
}

//Function Number: 26
func_ACAF()
{
	self setclientomnvar("lb_gsc_controlled",0);
}

//Function Number: 27
func_5B02(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	level endon("game_ended");
	thread func_13A3A(param_00,param_04,param_02,param_05,param_06,param_07);
	var_08 = 1;
	var_09 = var_08 / param_01;
	wait(func_7E25());
	for(;;)
	{
		if(!scripts\common\utility::istrue(self.var_1097A) && !scripts\common\utility::istrue(self.inlaststand))
		{
			self setclientomnvar(param_02,var_08);
			var_08 = var_08 - var_09;
			if(var_08 <= 0)
			{
				self setclientomnvar(param_02,0);
				func_5510(param_00,param_04,param_02,param_05,param_06,param_07);
				break;
			}
		}

		wait(1);
	}
}

//Function Number: 28
func_5B04(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	thread func_13A3A(param_00,param_04,param_02,param_05,param_06,param_07);
	var_08 = 1;
	var_09 = var_08 / param_01;
	for(;;)
	{
		self setclientomnvar(param_02,var_08);
		level waittill("spawn_wave_done");
		var_08 = var_08 - var_09;
		if(var_08 <= 0)
		{
			self setclientomnvar(param_02,0);
			func_5510(param_00,param_04,param_02,param_05,param_06,param_07);
			break;
		}

		wait(1);
	}
}

//Function Number: 29
func_5B01(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	thread func_13A3A(param_00,param_05,param_03,param_06,param_07,param_08);
	var_09 = self.var_456B[param_00].var_1307B;
	var_0A = 1;
	if(param_01 == "triggerwait")
	{
		self waittill(var_09);
	}

	wait(1);
	for(;;)
	{
		if(!scripts\common\utility::istrue(self.var_1097A) && !scripts\common\utility::istrue(self.inlaststand))
		{
			var_0A = var_0A - 0.05;
			self setclientomnvar(param_03,var_0A);
			if(var_0A <= 0)
			{
				self setclientomnvar(param_03,0);
				func_5510(param_00,param_05,param_03,param_06,param_07,param_08);
				break;
			}
		}

		wait(0.05);
	}
}

//Function Number: 30
func_5B03(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	thread func_13A3A(param_00,param_04,param_02,param_05,param_06,param_07);
	var_08 = 1 / param_01;
	var_09 = self.var_456B[param_00].var_1307B;
	var_0A = 1;
	for(;;)
	{
		self waittill(var_09);
		if((!scripts\common\utility::istrue(self.var_1097A) && !scripts\common\utility::istrue(self.inlaststand)) || param_00 == "coagulant")
		{
			var_0A = var_0A - var_08;
			self setclientomnvar(param_02,var_0A);
			if(var_0A < 0.0001)
			{
				self setclientomnvar(param_02,0);
				func_5510(param_00,param_04,param_02,param_05,param_06,param_07);
				break;
			}
		}
	}
}

//Function Number: 31
func_7E25()
{
	if(scripts\cp\_utility::map_check(0))
	{
		switch(self.var_134FD)
		{
			case "p3_":
			case "p2_":
			case "p1_":
				return 2;

			case "p4_":
				return self method_8443("ges_wondercard_jock");

			default:
				return 2;
		}

		return;
	}

	if(scripts\cp\_utility::map_check(1))
	{
		switch(self.var_134FD)
		{
			case "p4_":
			case "p3_":
			case "p2_":
			case "p1_":
				return 2;

			default:
				return 2;
		}

		return;
	}

	switch(self.var_134FD)
	{
		case "p4_":
		case "p3_":
		case "p2_":
		case "p1_":
			return 2;

		default:
			return 2;
	}
}

//Function Number: 32
func_13A3A(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("dpad_end_" + param_00);
	self waittill(param_00 + "_exited_early");
	self setclientomnvar(param_02,0);
	thread func_5510(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 33
func_B69D()
{
	self notify("starting_meter_fill");
	self endon("starting_meter_fill");
	self endon("disconnect");
	level endon("game_ended");
	if(self.var_1030B.size == 0)
	{
		self setclientomnvar("zm_consumables_remaining",0);
		self setclientomnvar("zm_dpad_up_fill",0);
		thread scripts\cp\_vo::func_1769("nag_need_fateandfort","zmb_comment_vo",60,300,6,1);
		thread scripts\cp\_vo::func_E01F("nag_use_fateandfort");
		return;
	}

	self.var_4560 = 0;
	self.var_4563 = func_7AC6();
	self setclientomnvar("zm_dpad_up_fill",0);
	while(self.var_4560 < self.var_4563)
	{
		self waittill("consumable_charge",var_00);
		if(scripts\common\utility::istrue(self.disable_consumables))
		{
			continue;
		}

		if(scripts\cp\_laststand::player_in_laststand(self))
		{
			continue;
		}

		if(isdefined(self.consumable_meter_scalar))
		{
			var_00 = var_00 * self.consumable_meter_scalar;
		}

		var_01 = self.var_4563 - self.var_4560;
		if(var_00 > var_01)
		{
			var_00 = var_01;
		}

		self.var_4560 = self.var_4560 + var_00;
		self setclientomnvar("zm_dpad_up_fill",self.var_4560 / self.var_4563);
	}

	self notify("meter_full");
	thread scripts\cp\_vo::func_1769("nag_use_fateandfort","zmb_comment_vo",60,180,6,1);
	self playlocalsound("ui_consumable_meter_full");
	self setclientomnvar("zm_dpad_up_activated",1);
	self setweaponammoclip("super_default_zm",1);
	thread func_ACB0();
	self.var_4561 = 1;
	thread func_5B00();
	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		thread scripts\cp\_hud_message::wait_and_play_tutorial_message("cards",5);
	}
}

//Function Number: 34
func_7AC6()
{
	var_00 = 1250;
	if(self.var_3A52 == 1)
	{
		var_00 = 3000;
	}
	else if(self.var_3A52 >= 2)
	{
		var_00 = 5000;
	}

	return var_00;
}

//Function Number: 35
func_5510(param_00,param_01,param_02,param_03,param_04,param_05)
{
	func_1294C(param_00,param_03);
	self.var_456B[param_00].var_130D1 = self.var_456B[param_00].var_130D1 - 1;
	self.var_456B[param_00].var_D9A1 = undefined;
	self setclientomnvar(param_01,self.var_456B[param_00].var_130D1);
	if(self.var_456B[param_00].var_130D1 == 0)
	{
		self.var_456B[param_00].var_130D1 = level.var_456B[param_00].var_130D1;
		self notify("dpad_end_" + param_00);
		self setclientomnvarbit("zm_card_selection_count",param_05,0);
		self setclientomnvarbit("zm_card_fill_display",param_05,0);
		return;
	}

	self setclientomnvar(param_02,1);
}

//Function Number: 36
func_1294C(param_00,param_01)
{
	self.var_456B[param_00].var_C4A4 = 0;
	scripts\cp\_utility::func_C150(param_00);
	thread func_12BF6(param_00);
}

//Function Number: 37
func_82B2(param_00,param_01)
{
	var_02 = level.var_456B[param_00];
	if(isdefined(var_02.var_1307B))
	{
		self notify(var_02.var_1307B);
	}
	else
	{
		self notify(param_00 + " activated");
	}

	if(isdefined(level.random_consumable_chosen) && level.random_consumable_chosen.name == param_00)
	{
		return;
	}

	self.var_456B[param_00].var_C4A4 = 1;
}

//Function Number: 38
func_DFDD(param_00)
{
	if(isdefined(self.var_456B[param_00]))
	{
		self.var_456B[param_00].var_C4A4 = 0;
	}
}

//Function Number: 39
func_13006(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self.var_DF50 = undefined;
	for(;;)
	{
		self waittill("reload");
		self.var_DF50 = 1;
		wait(5);
		self.var_DF50 = undefined;
	}
}

//Function Number: 40
func_12FEA(param_00)
{
	if(scripts\common\utility::istrue(self.var_9FCB))
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	var_01 = self getcurrentweapon();
	var_02 = scripts\cp\_utility::func_80D8(var_01);
	if(isdefined(self.var_C8A2[var_02]) && scripts\cp\_weapon::func_385F(var_01,1))
	{
		thread fnf_upgrade_weapon(self,param_00,var_02,var_01);
		return 1;
	}

	self.var_456B["ephemeral_enhancement"].var_C4A4 = 0;
	return 0;
}

//Function Number: 41
fnf_upgrade_weapon(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	var_04 = undefined;
	param_00.var_9FCB = 1;
	var_05 = "pap" + param_00.var_C8A2[param_02].var_B111;
	var_06 = function_00E3(param_03);
	var_07 = 0;
	var_08 = param_03;
	if(issubstr(param_03,"g18_z"))
	{
		foreach(var_0A in var_06)
		{
			if(issubstr(var_0A,"akimbo"))
			{
				var_07 = 1;
				var_06 = scripts\common\utility::func_22A9(var_06,var_0A);
			}
		}
	}

	if(isdefined(level.custom_epehermal_attachment_func))
	{
		var_0C = [[ level.custom_epehermal_attachment_func ]](param_00,param_02,param_03);
		if(isdefined(var_0C))
		{
			if(var_0C == "replace_me")
			{
				var_05 = undefined;
			}
			else
			{
				var_05 = var_0C;
			}
		}
	}

	if(isdefined(level.weapon_upgrade_path) && isdefined(level.weapon_upgrade_path[getweaponbasename(param_03)]))
	{
		param_03 = level.weapon_upgrade_path[getweaponbasename(param_03)];
	}
	else if(isdefined(level.custom_epehermal_weapon_func))
	{
		param_03 = [[ level.custom_epehermal_weapon_func ]](param_00,param_02,param_03);
	}

	if(isdefined(level.custom_ephermal_camo_func))
	{
		var_04 = [[ level.custom_ephermal_camo_func ]](param_00,param_02,param_03);
	}
	else
	{
		if(isdefined(param_02))
		{
			if(isdefined(level.no_pap_camos) && scripts\common\utility::func_2286(level.no_pap_camos,param_02))
			{
				var_04 = undefined;
			}
			else if(isdefined(level.pap_1_camo) && param_00.var_C8A2[param_02].var_B111 == 1)
			{
				var_04 = level.pap_1_camo;
			}
			else if(isdefined(level.pap_2_camo) && param_00.var_C8A2[param_02].var_B111 == 2)
			{
				var_04 = level.pap_2_camo;
			}

			var_0D = param_00 scripts\cp\_weapon::func_7D62(param_03);
			switch(param_02)
			{
				case "dischord":
					var_0E = "iw7_dischord_zm_pap1";
					var_04 = "camo20";
					break;

				case "facemelter":
					var_0E = "iw7_facemelter_zm_pap1";
					var_04 = "camo22";
					break;

				case "headcutter":
					var_0E = "iw7_headcutter_zm_pap1";
					var_04 = "camo21";
					break;

				case "forgefreeze":
					if(var_0D == 2)
					{
						var_0E = "iw7_forgefreeze_zm_pap1";
					}
					else if(var_0D == 3)
					{
						var_0E = "iw7_forgefreeze_zm_pap2";
					}
	
					var_0F = 1;
					break;

				case "axe":
					if(var_0D == 2)
					{
						var_0E = "iw7_axe_zm_pap1";
					}
					else if(var_0D == 3)
					{
						var_0E = "iw7_axe_zm_pap2";
					}
					break;

				case "shredder":
					var_0E = "iw7_shredder_zm_pap1";
					var_04 = "camo23";
					break;

				case "katana":
				case "nunchucks":
					var_04 = "camo222";
					break;
			}
		}

		var_0F = 0;
		if(isdefined(param_02))
		{
			switch(param_02)
			{
				case "spiked":
				case "golf":
				case "two":
				case "axe":
				case "machete":
					var_0F = 1;
					break;

				default:
					var_0F = 0;
					break;
			}
		}
		else
		{
			var_0F = 0;
		}

		var_05 = undefined;
		if(isdefined(param_02))
		{
			switch(param_02)
			{
				case "spiked":
				case "golf":
				case "two":
				case "machete":
				case "katana":
				case "nunchucks":
					var_05 = "replace_me";
					break;

				default:
					if(isdefined(param_00.var_C8A2[param_02]))
					{
						var_05 = "pap" + param_00.var_C8A2[param_02].var_B111;
					}
					else
					{
						var_05 = "pap1";
					}
	
					break;
			}
		}

		if(isdefined(var_05) && var_05 == "replace_me")
		{
			var_05 = undefined;
		}

		var_10 = function_00E3(param_03);
		if(issubstr(param_03,"g18_z"))
		{
			foreach(var_0A in var_10)
			{
				if(issubstr(var_0A,"akimbo"))
				{
					var_10 = scripts\common\utility::func_22A9(var_10,var_0A);
				}
			}
		}
	}

	var_13 = param_00 scripts\cp\_weapon::func_E469(param_03,var_05,var_06,undefined,var_04);
	if(isdefined(var_13))
	{
		param_00.var_C8A2[param_02].var_B111++;
		param_00 notify("weapon_level_changed");
		param_00.var_6670 = getweaponbasename(var_13);
		param_00 thread func_5AFA(param_01,param_00,var_13,var_07);
		param_00 endon("last_stand");
		wait(func_7E25());
		var_13 = param_00 scripts\cp\_utility::func_12C6(var_13,undefined,undefined,1);
		if(isdefined(var_08))
		{
			param_00 takeweapon(var_08);
		}
		else
		{
			param_00 takeweapon(param_03);
		}

		param_00 switchtoweapon(var_13);
	}
}

//Function Number: 42
func_5AFA(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_01 endon("disconnect");
	var_04 = param_01.var_6670;
	var_05 = 0;
	var_06 = scripts\cp\_utility::func_80D8(param_02);
	var_07 = "pap" + param_01.var_C8A2[var_06].var_B111 - 1;
	var_08 = param_01.var_C8A2[var_06].var_B111 - 2;
	switch(var_06)
	{
		case "venomx":
			param_01.var_C8A2[var_06].var_B111--;
			if(param_01.var_C8A2[var_06].var_B111 == 1)
			{
				param_01.base_weapon = 1;
				param_02 = "iw7_venomx_zm";
			}
			else
			{
				param_01.ephemeral_downgrade = 1;
				param_02 = "iw7_venomx_zm_pap1";
			}
			break;

		case "katana":
			param_01.var_C8A2[var_06].var_B111--;
			if(param_01.var_C8A2[var_06].var_B111 == 1)
			{
				param_01.base_weapon = 1;
				param_02 = "iw7_katana_zm";
			}
			else
			{
				param_01.ephemeral_downgrade = 1;
				param_02 = "iw7_katana_zm_pap1";
			}
			break;

		case "nunchucks":
			param_01.var_C8A2[var_06].var_B111--;
			if(param_01.var_C8A2[var_06].var_B111 == 1)
			{
				param_01.base_weapon = 1;
				param_02 = "iw7_nunchucks_zm";
			}
			else
			{
				param_01.ephemeral_downgrade = 1;
				param_02 = "iw7_nunchucks_zm_pap1";
			}
			break;

		case "two":
			param_01.var_C8A2[var_06].var_B111--;
			if(param_01.var_C8A2[var_06].var_B111 == 1)
			{
				param_01.base_weapon = 1;
				param_02 = "iw7_two_headed_axe_mp";
			}
			else
			{
				param_01.ephemeral_downgrade = 1;
				param_02 = "iw7_two_headed_axe_mp_pap1";
			}
			break;

		case "machete":
			param_01.var_C8A2[var_06].var_B111--;
			if(param_01.var_C8A2[var_06].var_B111 == 1)
			{
				param_01.base_weapon = 1;
				param_02 = "iw7_machete_mp";
			}
			else
			{
				param_01.ephemeral_downgrade = 1;
				param_02 = "iw7_machete_mp_pap1";
			}
			break;

		case "golf":
			param_01.var_C8A2[var_06].var_B111--;
			if(param_01.var_C8A2[var_06].var_B111 == 1)
			{
				param_01.base_weapon = 1;
				param_02 = "iw7_golf_club_mp";
			}
			else
			{
				param_01.ephemeral_downgrade = 1;
				param_02 = "iw7_golf_club_mp_pap1";
			}
			break;

		case "spiked":
			param_01.var_C8A2[var_06].var_B111--;
			if(param_01.var_C8A2[var_06].var_B111 == 1)
			{
				param_01.base_weapon = 1;
				param_02 = "iw7_spiked_bat_mp";
			}
			else
			{
				param_01.ephemeral_downgrade = 1;
				param_02 = "iw7_spiked_bat_mp_pap1";
			}
			break;
	}

	param_02 = func_5AF9(param_01,param_02,var_06,var_07,var_08,param_03);
	param_01.base_weapon = undefined;
	param_01.ephemeral_downgrade = undefined;
	var_09 = param_01 scripts\common\utility::func_13734("ephemeral_enhancement_timeup","last_stand");
	if(var_09 != "ephemeral_enhancement_timeup")
	{
		param_01 notify(param_00 + "_exited_early");
	}

	param_01.var_9FCB = undefined;
	var_0A = scripts\cp\_utility::func_80D8(param_01 scripts\cp\_utility::getvalidtakeweapon());
	if(param_01 scripts\cp\_weapon::func_8BBB(var_04))
	{
		var_0B = param_01 getweaponslistall();
		foreach(var_0D in var_0B)
		{
			var_0E = scripts\cp\_utility::func_80D8(var_0D);
			if(var_0E == scripts\cp\_utility::func_80D8(var_04))
			{
				param_01 takeweapon(var_0D);
				var_05 = 1;
				param_02 = param_01 scripts\cp\_utility::func_12C6(param_02,undefined,undefined,1);
				if(scripts\cp\_utility::func_80D8(param_02) == var_0A)
				{
					param_01 method_83B6(param_02);
				}

				param_01.var_C8A2[var_06].var_B111 = int(max(param_01.var_C8A2[var_06].var_B111 - 1,1));
				param_01 notify("weapon_level_changed");
				break;
			}
		}
	}

	if(isdefined(param_01.var_4643))
	{
		var_10 = param_01.var_4643;
		foreach(var_12 in var_10)
		{
			var_0E = getweaponbasename(var_12);
			if(var_0E == var_04)
			{
				var_13 = param_01.var_4648[var_12];
				var_14 = param_01.var_464A[var_12];
				param_01.var_4643 = scripts\common\utility::func_22A9(param_01.var_4643,var_12);
				if(var_0E == getweaponbasename(param_01.var_464B))
				{
					param_01.var_464B = param_02;
				}

				param_01.var_4643 = scripts\common\utility::array_add(param_01.var_4643,param_02);
				param_01.var_4648[param_02] = var_13;
				param_01.var_464A[param_02] = var_14;
				break;
			}
		}
	}

	if(isdefined(param_01.var_A913))
	{
		if(getweaponbasename(param_01.var_A913) == param_01.var_6670)
		{
			param_01.var_A913 = param_02;
		}
	}

	if(isdefined(param_01.saved_last_stand_pistol))
	{
		if(getweaponbasename(param_01.saved_last_stand_pistol) == param_01.var_6670)
		{
			param_01.saved_last_stand_pistol = param_02;
		}
	}

	if(isdefined(param_01.var_B0A0))
	{
		var_10 = param_01.var_B0A0.var_4643;
		foreach(var_12 in var_10)
		{
			var_0E = getweaponbasename(var_12);
			if(var_0E == var_04)
			{
				var_13 = param_01.var_4648[var_12];
				var_14 = param_01.var_464A[var_12];
				param_01.var_B0A0.var_4643 = scripts\common\utility::func_22A9(param_01.var_B0A0.var_4643,var_12);
				if(var_0E == getweaponbasename(param_01.var_B0A0.var_464B))
				{
					param_01.var_B0A0.var_464B = param_02;
				}

				param_01.var_B0A0.var_4643 = scripts\common\utility::array_add(param_01.var_B0A0.var_4643,param_02);
				param_01.var_4648[param_02] = var_13;
				param_01.var_464A[param_02] = var_14;
				break;
			}
		}
	}

	param_01.var_6670 = undefined;
}

//Function Number: 43
func_5AF9(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = undefined;
	if(param_04 >= 1)
	{
		if(isdefined(level.no_pap_camos) && scripts\common\utility::func_2286(level.no_pap_camos,param_02))
		{
			var_06 = undefined;
		}
		else if(isdefined(level.pap_1_camo))
		{
			var_06 = level.pap_1_camo;
		}

		var_07 = "pap" + param_04;
		switch(param_02)
		{
			case "dischord":
				var_06 = "camo20";
				break;

			case "facemelter":
				var_06 = "camo22";
				break;

			case "headcutter":
				var_06 = "camo21";
				break;

			case "shredder":
				var_06 = "camo23";
				break;

			case "katana":
			case "nunchucks":
				var_06 = "camo222";
				break;
		}
	}
	else
	{
		var_07 = undefined;
	}

	switch(param_02)
	{
		case "katana":
		case "nunchucks":
			var_07 = undefined;
			break;

		case "two":
			var_07 = undefined;
			break;

		case "golf":
			var_07 = undefined;
			break;

		case "machete":
			var_07 = undefined;
			break;

		case "spiked":
			var_07 = undefined;
			break;
	}

	var_08 = function_00E3(param_01);
	if(scripts\common\utility::istrue(param_05))
	{
		var_08 = scripts\common\utility::array_add(var_08,"akimbo");
	}

	foreach(var_0A in var_08)
	{
		if(issubstr(var_0A,param_03))
		{
			var_08 = scripts\common\utility::func_22A9(var_08,var_0A);
		}
	}

	var_0C = param_00 scripts\cp\_weapon::func_E469(param_01,var_07,var_08,undefined,var_06);
	return var_0C;
}

//Function Number: 44
func_1301A(param_00)
{
	var_01 = self;
	if(func_107AA(var_01,"instakill_30",param_00))
	{
		return 1;
	}

	self.var_456B["spawn_instakill"].var_C4A4 = 0;
	return 0;
}

//Function Number: 45
func_13018(param_00)
{
	var_01 = self;
	if(func_107AA(var_01,"fire_30",param_00))
	{
		return 1;
	}

	self.var_456B["fire_30"].var_C4A4 = 0;
	return 0;
}

//Function Number: 46
func_1301C(param_00)
{
	var_01 = self;
	if(func_107AA(var_01,"kill_50",param_00))
	{
		return 1;
	}

	self.var_456B["spawn_nuke"].var_C4A4 = 0;
	return 0;
}

//Function Number: 47
func_13017(param_00)
{
	var_01 = self;
	if(func_107AA(var_01,"cash_2",param_00))
	{
		return 1;
	}

	self.var_456B["spawn_double_money"].var_C4A4 = 0;
	return 0;
}

//Function Number: 48
func_1301B(param_00)
{
	var_01 = self;
	if(func_107AA(var_01,"ammo_max",param_00))
	{
		return 1;
	}

	self.var_456B["spawn_max_ammo"].var_C4A4 = 0;
	return 0;
}

//Function Number: 49
func_1301D(param_00)
{
	var_01 = self;
	if(func_107AA(var_01,"board_windows",param_00))
	{
		return 1;
	}

	self.var_456B["spawn_reboard_windows"].var_C4A4 = 0;
	return 0;
}

//Function Number: 50
func_13019(param_00)
{
	var_01 = self;
	if(func_107AA(var_01,"infinite_20",param_00))
	{
		return 1;
	}

	self.var_456B["spawn_infinite_ammo"].var_C4A4 = 0;
	return 0;
}

//Function Number: 51
func_107AA(param_00,param_01,param_02)
{
	var_03 = param_00.origin;
	var_04 = (0,40,0);
	var_05 = self getplayerangles();
	var_06 = 7;
	var_03 = var_03 + var_04[0] * anglestoright(var_05);
	var_03 = var_03 + var_04[1] * anglestoforward(var_05);
	var_03 = var_03 + var_04[2] * anglestoup(var_05);
	var_07 = rotatepointaroundvector(anglestoup(var_05),anglestoforward(var_05),var_06);
	var_08 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_vehicleclip","physicscontents_item","physicscontents_detail","physicscontents_vehicleclip","physicscontents_vehicle","physicscontents_canshootclip","physicscontents_missileclip","physicscontents_clipshot"]);
	var_09 = scripts\common\trace::func_DCED(param_00 geteye(),var_03 + var_07,self,var_08);
	var_03 = scripts\common\utility::func_5D14(var_09["position"] + var_07 * -18,32,-2000);
	if(!scripts\cp\_weapon::func_9E54(var_03,level.var_9B0B,undefined,undefined,1))
	{
		var_03 = param_00.origin;
	}

	if(level scripts\cp\zombies\_powerups::drop_loot(var_03,param_00,param_01,undefined,undefined,1))
	{
		wait(0.25);
		param_00 scripts\cp\_utility::func_C151(param_02);
		return 1;
	}

	return 0;
}

//Function Number: 52
func_1302A(param_00)
{
	if(scripts\common\utility::istrue(self.var_9FCB))
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	if(self method_81C2())
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	thread func_82EF(param_00,"iw7_steeldragon_mp");
	return 1;
}

//Function Number: 53
func_12FBB(param_00)
{
	if(scripts\common\utility::istrue(self.var_9FCB))
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	if(self method_81C2())
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	thread func_82EF(param_00,"iw7_claw_mp");
	return 1;
}

//Function Number: 54
func_12FA6(param_00)
{
	if(scripts\common\utility::istrue(self.var_9FCB))
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	if(self method_81C2())
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	thread func_82EF(param_00,"iw7_atomizer_mp+atomizerscope");
	return 1;
}

//Function Number: 55
func_13001(param_00)
{
	if(scripts\common\utility::istrue(self.var_9FCB))
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	if(self method_81C2())
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	thread func_82EF(param_00,"iw7_penetrationrail_mp+penetrationrailscope");
	return 1;
}

//Function Number: 56
func_12FAC(param_00)
{
	if(scripts\common\utility::istrue(self.var_9FCB))
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	if(self method_81C2())
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	thread func_82EF(param_00,"iw7_blackholegun_mp+blackholegunscope");
	return 1;
}

//Function Number: 57
func_82EF(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	var_02 = self getcurrentweapon();
	var_03 = 0;
	if(var_02 == "none")
	{
		var_03 = 1;
	}
	else if(scripts\common\utility::func_2286(level.additional_laststand_weapon_exclusion,var_02))
	{
		var_03 = 1;
	}
	else if(scripts\common\utility::func_2286(level.additional_laststand_weapon_exclusion,getweaponbasename(var_02)))
	{
		var_03 = 1;
	}
	else if(scripts\cp\_utility::func_9C42(var_02,1))
	{
		var_03 = 1;
	}

	if(var_03)
	{
		self.var_4643 = self getweaponslistall();
		var_02 = scripts\cp\_laststand::func_3E88(level.additional_laststand_weapon_exclusion,1,1);
	}

	self.var_A92C = var_02;
	self.var_4643 = undefined;
	thread func_E18A(param_00,param_01,var_02);
	self endon(param_00 + "_exited_early");
	self endon("last_stand");
	wait(func_7E25());
	param_01 = scripts\cp\_utility::func_12C6(param_01,undefined,undefined,0);
	self method_83B6(param_01);
	var_04 = func_1E39(param_01);
	while(self getcurrentweapon() != param_01)
	{
		wait(0.05);
	}

	self notify("super_weapon_given");
	thread func_12BA6(var_04,param_01);
}

//Function Number: 58
func_E18A(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon("disconnect");
	self.var_9FCB = 1;
	self.var_BD6C = param_02;
	scripts\common\utility::func_1C62(0);
	scripts\common\utility::waittill_any_timeout_1(func_7E25() + 1,"super_weapon_given");
	self allowmelee(0);
	while(self method_81C2())
	{
		wait(0.05);
	}

	self allowmelee(1);
	if(self getcurrentweapon() == param_01 && scripts\cp\_utility::func_9BA0(param_00))
	{
		var_03 = scripts\common\utility::func_13734(param_00 + "_timeup","last_stand","weapon_switch_started","weapon_purchased","coaster_ride_beginning","cards_replenished");
	}
	else
	{
		var_03 = undefined;
	}

	scripts\common\utility::func_1C62(1);
	if(!isdefined(var_03) || var_03 != param_00 + "_timeup")
	{
		self notify(param_00 + "_exited_early");
	}

	self.var_9FCB = undefined;
	if(!isdefined(var_03) || isdefined(var_03) && var_03 != "last_stand")
	{
		if(self hasweapon(param_02))
		{
			self switchtoweapon(param_02);
		}
		else
		{
			self switchtoweapon(self getweaponslistprimaries()[1]);
		}
	}

	if(self hasweapon(param_01))
	{
		self takeweapon(param_01);
	}

	thread func_4DB9();
	self.var_BD6C = undefined;
	self.var_A92C = undefined;
}

//Function Number: 59
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

//Function Number: 60
func_12BA6(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	if(!isdefined(self.var_13CA0))
	{
		self.var_13CA0 = self getweaponslistprimaries();
	}

	var_02 = self.var_13CA0;
	if(isdefined(param_01))
	{
		var_02[var_02.size] = param_01;
	}

	self.var_8B7D = 1;
	scripts\cp\_utility::enable_infinite_ammo(1);
	while(scripts\common\utility::istrue(self.var_8B7D))
	{
		var_03 = 0;
		foreach(var_05 in var_02)
		{
			if(var_05 == self getcurrentweapon() && func_13C30(var_05))
			{
				var_03 = 1;
				self setweaponammoclip(var_05,weaponclipsize(var_05),"left");
			}

			if(var_05 == self getcurrentweapon() && func_13C30(var_05))
			{
				var_03 = 1;
				self setweaponammoclip(var_05,weaponclipsize(var_05),"right");
			}

			if(var_03 == 0)
			{
				func_1E39(param_01);
			}
		}

		wait(0.05);
	}
}

//Function Number: 61
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

//Function Number: 62
func_4DB9()
{
	level endon("disconnect");
	level endon("game_ended");
	self.var_8B7D = undefined;
	wait(0.2);
	scripts\cp\_utility::enable_infinite_ammo(0);
}

//Function Number: 63
func_12FB4(param_00)
{
	self endon("disconnect");
	self endon(param_00 + "_timeup");
	level endon("game_ended");
	for(;;)
	{
		self waittill("shot_missed",var_01);
		if(!scripts\cp\_weapon::func_9D75(var_01))
		{
			continue;
		}

		if(scripts\cp\_weapon::func_8BD1(var_01,"g18pap1") || scripts\cp\_weapon::func_8BD1(var_01,"g18pap2"))
		{
			continue;
		}

		var_02 = self getweaponammoclip(var_01);
		self setweaponammoclip(var_01,var_02 + 1);
	}
}

//Function Number: 64
func_12FED(param_00)
{
	self endon("disconnect");
	self endon(param_00 + "_timeup");
	level endon("game_ended");
	for(;;)
	{
		self waittill("player_damaged");
		if(self.health <= 45)
		{
			thread func_F63F();
			thread func_A66A();
			scripts\cp\_utility::func_C151(param_00);
		}
	}
}

//Function Number: 65
func_F63F()
{
	self notify("setAndRemoveInvulnerability");
	self endon("setAndRemoveInvulnerability");
	self endon("disconnect");
	level endon("game_ended");
	scripts\cp\_utility::func_17C0("near_death_consumable",0,0);
	scripts\common\utility::waittill_any_timeout_no_endon_death_2(1,"death","last_stand");
	scripts\cp\_utility::func_E0E6("near_death_consumable",0);
}

//Function Number: 66
func_A66A(param_00)
{
	var_01 = 128;
	var_02 = vectornormalize(anglestoforward(self.angles));
	var_03 = var_02 * var_01;
	var_04 = self.origin + var_03;
	physicsexplosionsphere(var_04,var_01,1,2.5);
	var_05 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_06 = scripts\common\utility::func_782F(self.origin,var_05,undefined,24,256);
	foreach(var_08 in var_06)
	{
		if(isdefined(var_08.agent_type) && var_08.agent_type == "zombie_sasquatch" || var_08.agent_type == "slasher" || var_08.agent_type == "superslasher" || var_08.agent_type == "zombie_brute" || var_08.agent_type == "zombie_grey" || var_08.agent_type == "zombie_clown" || var_08.agent_type == "alien_rhino")
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_08.var_9342))
		{
			var_08 func_A672(self,var_08.maxhealth,var_08.origin,self.origin);
			continue;
		}

		var_08 playsound("zmb_fnf_second_wind_push");
		var_09 = 0;
		var_0A = var_08.origin;
		var_0B = var_08.maxhealth;
		var_02 = anglestoforward(self.angles);
		var_0C = vectornormalize(var_02) * -100;
		var_08 setvelocity(vectornormalize(var_08.origin - self.origin + var_0C) * 800 + (0,0,300));
		var_08 func_A672(self,var_0B,var_0A,self.origin);
	}
}

//Function Number: 67
func_A672(param_00,param_01,param_02,param_03)
{
	self.do_immediate_ragdoll = 1;
	if(param_01 >= self.health)
	{
		self.var_4C87 = 1;
	}

	self dodamage(param_01,param_02,param_00,param_00,"MOD_IMPACT","zom_repulsor_mp");
}

//Function Number: 68
torrent_start(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	level endon("game_ended");
	if(param_03 == 0 || param_03 == 3 || param_03 == 6)
	{
		playsoundatpos(param_01,"zmb_fnf_timely_torrent_lava");
	}

	playfx(level._effect["lava_torrent"],self.origin,undefined,anglestoup((0,0,90)));
	foreach(var_06 in param_02)
	{
		var_07 = (var_06.origin[0],var_06.origin[1],90);
		if(var_06 scripts\cp\_utility::agentisfnfimmune())
		{
			continue;
		}

		if(isdefined(var_06.flung) || isdefined(var_06.agent_type) && var_06.agent_type == "zombie_brute" || var_06.agent_type == "zombie_ghost" || var_06.agent_type == "zombie_grey" || var_06.agent_type == "slasher" || var_06.agent_type == "superslasher")
		{
			continue;
		}

		if(distancesquared(var_06.origin,param_01) < 5184)
		{
			var_06.flung = 1;
			var_06.do_immediate_ragdoll = 1;
			var_06.disable_armor = 1;
			var_06 setsolid(0);
			var_06 setvelocity((0,0,600));
			wait(0.1);
			if(isdefined(var_06))
			{
				var_06 dodamage(10000,param_01,param_04,param_04,"MOD_EXPLOSIVE");
			}
		}
	}

	self delete();
}

//Function Number: 69
use_timely_torrent(param_00)
{
	self endon("disconnect");
	self endon(param_00 + "_timeup");
	level endon("game_ended");
	thread run_timely_torrent(param_00);
}

//Function Number: 70
select_spot_array(param_00,param_01)
{
	if(!isdefined(param_00.array_of_torrent_points))
	{
		param_00.array_of_torrent_points = [];
	}

	var_02 = param_00.origin;
	var_03 = (0,128,0);
	var_04 = param_00 getplayerangles();
	var_05 = 7;
	var_06 = 0;
	var_02 = var_02 + var_03[0] * anglestoright(var_04);
	var_02 = var_02 + var_03[1] * anglestoforward(var_04);
	var_02 = var_02 + var_03[2] * anglestoup(var_04);
	var_07 = rotatepointaroundvector(anglestoup(var_04),anglestoforward(var_04),0);
	var_08 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_vehicleclip","physicscontents_item","physicscontents_detail","physicscontents_vehicleclip","physicscontents_vehicle","physicscontents_canshootclip","physicscontents_missileclip","physicscontents_clipshot"]);
	var_09 = scripts\common\trace::func_DCED(param_00 geteye(),var_02 + var_07,param_00,var_08);
	var_02 = var_09["position"] + var_07;
	if(param_01 == 0)
	{
		param_00.array_of_torrent_points[param_01] = var_02 + anglestoforward(var_04) * 60;
	}
	else
	{
		param_00.array_of_torrent_points[param_01] = var_02 + anglestoforward(var_04) * param_01 + 1 * 60;
	}

	return param_00.array_of_torrent_points;
}

//Function Number: 71
run_timely_torrent(param_00)
{
	self endon(param_00 + "_timeup");
	self endon("disconnect");
	level endon("game_ended");
	var_01 = [];
	var_02 = 0;
	for(;;)
	{
		self waittill("melee_fired");
		for(var_03 = 0;var_03 <= 5;var_03++)
		{
			var_01 = select_spot_array(self,var_03);
		}

		var_04 = 1200;
		self.closestenemies_array = [];
		var_05 = scripts\cp\_agent_utils::get_alive_enemies();
		foreach(var_08, var_07 in var_01)
		{
			var_01[var_08] = spawn("script_origin",var_07);
		}

		foreach(var_08, var_07 in var_01)
		{
			if(!isdefined(var_07))
			{
				continue;
			}

			var_07 thread torrent_start(param_00,var_07.origin,var_05,var_08,self);
		}

		scripts\cp\_utility::func_C151("timely_torrent");
	}
}

//Function Number: 72
use_purify(param_00)
{
	self endon("disconnect");
	self endon(param_00 + "_timeup");
	self endon(param_00 + "_exited_early");
	level endon("game_ended");
	if(!isdefined(level.purify_active))
	{
		level.purify_active = 1;
	}
	else
	{
		level.purify_active++;
	}

	foreach(var_02 in level.players)
	{
		if(var_02 scripts\cp\_utility::is_valid_player())
		{
			thread purify_activate(var_02);
		}
	}

	var_04 = scripts\common\utility::func_782F(self.origin,level.players,undefined,24,99999,0);
	foreach(var_06 in var_04)
	{
		var_06 thread dealaoedamage(param_00);
		wait(0.1);
	}

	scripts\cp\_utility::func_C151("purify");
	return 1;
}

//Function Number: 73
purify_activate(param_00)
{
	param_00 notify("force_regeneration");
	thread disablepurifyregenafterdelay();
}

//Function Number: 74
disablepurifyregenafterdelay()
{
	level endon("game_ended");
	wait(2);
	level.purify_active--;
	if(level.purify_active <= 0)
	{
		level.purify_active = 0;
	}
}

//Function Number: 75
dealaoedamage(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	var_01 = scripts\cp\_agent_utils::get_alive_enemies();
	var_02 = scripts\common\utility::func_782F(self.origin,var_01,undefined,24,128,0);
	if(var_02.size > 0)
	{
		self notify("force_regeneration");
		foreach(var_04 in var_02)
		{
			if(isdefined(var_04.agent_type) && var_04.agent_type == "zombie_brute" || var_04.agent_type == "zombie_ghost" || var_04.agent_type == "zombie_grey" || var_04.agent_type == "slasher" || var_04.agent_type == "alien_rhino" || var_04.agent_type == "superslasher")
			{
				continue;
			}
			else
			{
				playfx(level._effect["penetration_railgun_explosion"],self.origin);
				var_04 dodamage(var_04.health + 100,var_04.origin,self,self,"MOD_EXPLOSIVE","iw7_explosive_touch_zm");
			}
		}

		self playsound("zmb_fnf_purify_explo");
	}
}

//Function Number: 76
func_6220(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 hudoutlineenableforclient(param_01,param_02,param_03,param_04);
}

//Function Number: 77
func_5561(param_00,param_01)
{
	param_00 hudoutlinedisableforclient(param_01);
}

//Function Number: 78
func_1309(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = magicbullet(param_00,param_01,param_02,param_03,param_04);
	if(isdefined(var_05) && isdefined(param_03))
	{
		var_05 method_831F(param_03);
	}

	return var_05;
}

//Function Number: 79
func_12FFB(param_00)
{
	self endon("disconnect");
	self endon(param_00 + "_timeup");
	self endon(param_00 + "_exited_early");
	level endon("game_ended");
	thread func_E16D(param_00);
	for(;;)
	{
		self waittill("player_damaged");
		scripts\cp\_persistence::func_82F9(100,undefined,undefined,1,"bonus");
	}
}

//Function Number: 80
use_explosive_touch(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	self endon(param_00 + "_timeup");
	thread func_E00B(param_00);
	for(;;)
	{
		if(!scripts\common\utility::istrue(self.has_explosive_touch))
		{
			self.has_explosive_touch = 1;
			thread watch_for_zombie_touch(param_00);
			scripts\cp\_utility::func_17C0("health_boost",0.1,0);
			self notify("force_regeneration");
			self playlocalsound("breathing_heartbeat_alt");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 81
watch_for_zombie_touch(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	self endon(param_00 + "_timeup");
	while(scripts\common\utility::istrue(self.has_explosive_touch))
	{
		var_01 = scripts\cp\_agent_utils::get_alive_enemies();
		foreach(var_03 in var_01)
		{
			if(scripts\common\utility::func_56F4(var_03.origin,self.origin) <= 5184)
			{
				if(var_03 scripts\cp\_utility::agentisfnfimmune())
				{
					continue;
				}

				if(var_03 scripts\cp\_utility::func_9D20() && var_03.agent_type != "slasher" && var_03.agent_type != "superslasher" && var_03.agent_type != "zombie_brute" && var_03.agent_type != "zombie_grey")
				{
					var_03.exp_touch = 1;
					var_03.nocorpse = 1;
					var_03.full_gib = 1;
					playsoundatpos(var_03 gettagorigin("j_spineupper"),"zmb_fnf_explosive_touch_explo");
					wait(0.1);
					playfx(scripts\common\utility::getfx("exp_touch"),var_03 gettagorigin("j_spineupper"));
					self radiusdamage(self.origin,100,var_03.health + 1000,var_03.health,self,"MOD_EXPLOSIVE","iw7_explosive_touch_zm");
					wait(0.3);
				}
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 82
func_E00B(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	scripts\common\utility::waittill_any_3(param_00 + "_timeup",param_00 + "_exited_early");
	self.has_explosive_touch = 0;
	scripts\cp\_utility::func_E0E6("health_boost",0);
	if(isdefined(self.var_6A08))
	{
		self.var_6A08 delete();
	}
}

//Function Number: 83
use_shared_fate(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	self endon(param_00 + "_timeup");
	self.marked_ents = [];
	thread look_at_and_outline_enemies(param_00);
	thread damage_on_marked_enemies(param_00);
}

//Function Number: 84
damage_on_marked_enemies(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	self endon(param_00 + "_timeup");
	for(;;)
	{
		self waittill("weapon_hit_marked_target",var_01,var_02,var_03,var_04,var_05);
		self.marked_ents = scripts\common\utility::func_22BC(self.marked_ents);
		self.marked_ents = scripts\common\utility::func_22A9(self.marked_ents,var_05);
		foreach(var_07 in self.marked_ents)
		{
			if(var_05 == var_07)
			{
				continue;
			}

			if(var_07 scripts\cp\_utility::agentisfnfimmune())
			{
				continue;
			}

			if(var_07.health - var_02 <= 0)
			{
				var_07 setscriptablepartstate("shared_fate_fx","inactive",1);
			}

			self.marked_ents = scripts\common\utility::func_22A9(self.marked_ents,var_07);
			var_07 dodamage(var_02,var_07.origin,var_01,var_01,var_03,"iw7_shared_fate_weapon");
		}
	}
}

//Function Number: 85
outline_enemeies(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	self endon(param_00 + "_timeup");
	for(;;)
	{
		foreach(var_02 in self.marked_ents)
		{
			if(var_02 scripts\cp\_utility::agentisfnfimmune())
			{
				continue;
			}

			if(isdefined(var_02.agent_type) && var_02.agent_type == "zombie_sasquatch" || var_02.agent_type == "slasher" || var_02.agent_type == "superslasher" || var_02.agent_type == "zombie_brute" || var_02.agent_type == "zombie_grey" || var_02.agent_type == "zombie_clown" || var_02.agent_type == "skater")
			{
				continue;
			}

			if(scripts\cp\_utility::func_9C42(self getcurrentweapon()) || scripts\cp\_utility::weapon_is_dlc_melee(self getcurrentweapon()) || scripts\cp\_utility::weapon_is_dlc2_melee(self getcurrentweapon()))
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			if(scripts\common\utility::istrue(var_02.marked_shared_fate_fnf))
			{
				var_02 setscriptablepartstate("shared_fate_fx","active",1);
				continue;
			}

			if(isdefined(var_02))
			{
				var_02 setscriptablepartstate("shared_fate_fx","inactive",1);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 86
look_at_and_outline_enemies(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	self endon(param_00 + "_timeup");
	var_01 = 0;
	for(;;)
	{
		if(self adsbuttonpressed() && !var_01)
		{
			if(scripts\cp\_utility::func_9C42(self getcurrentweapon()) || scripts\cp\_utility::weapon_is_dlc_melee(self getcurrentweapon()))
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			var_01 = 1;
			var_02 = self getplayerangles();
			var_03 = self geteye();
			var_04 = anglestoforward(var_02);
			var_05 = var_03 + var_04 * 500;
			var_06 = scripts\common\trace::func_48BC(1,0,0,0,0,0,0);
			var_07 = function_0287(var_03,var_05,var_06,self,0,"physicsquery_closest");
			if(var_07.size <= 0)
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			var_08 = var_07[0]["entity"];
			if(isdefined(var_08))
			{
				if(var_08 scripts\cp\_utility::agentisfnfimmune())
				{
					continue;
				}

				if(isdefined(var_08.agent_type) && var_08.agent_type == "zombie_sasquatch" || var_08.agent_type == "slasher" || var_08.agent_type == "superslasher" || var_08.agent_type == "zombie_brute" || var_08.agent_type == "zombie_grey" || var_08.agent_type == "zombie_clown")
				{
					continue;
				}

				if(var_08 scripts\cp\_utility::func_9D20())
				{
					if(!scripts\common\utility::func_2286(self.marked_ents,var_08))
					{
						self playlocalsound("zmb_fnf_shared_fate_highlight");
						var_08.marked_shared_fate_fnf = 1;
						self.marked_ents = scripts\common\utility::array_add(self.marked_ents,var_08);
						var_08 setscriptablepartstate("shared_fate_fx","active",1);
					}
				}
			}

			var_01 = 0;
		}
		else
		{
			var_01 = 0;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 87
use_fire_chains(param_00)
{
	self endon(param_00 + "_timeup");
	self endon("last_stand");
	self endon("disconnect");
	level endon("game_ended");
	self.life_link_active = undefined;
	self.var_AC4B = 1;
	var_01 = "j_spine4";
	var_02 = ["j_spine4","j_spineupper","j_spinelower","j_head","j_knee_ri","j_knee_le","j_elbow_ri","j_elbow_le","j_ankle_le","j_ankle_ri","j_wrist_le","j_wrist_ri"];
	thread removefirechainsdamagemodifierontimeout(param_00);
	thread removefirechainsdamagemodifieronlaststand(param_00);
	var_03 = self;
	for(;;)
	{
		var_04 = getfirechainstarget(self);
		if(isdefined(var_04))
		{
			self.var_2A9A = var_04;
			self.var_AD2D = 1;
			thread playfirechainsfx(var_04,var_01,param_00);
			var_03.life_link_active = 1;
			linktoplayer_fire_chains(self,var_04,var_02);
		}
		else
		{
			var_03.life_link_active = undefined;
			wait(0.5);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 88
getfirechainstarget(param_00)
{
	var_01 = scripts\common\utility::func_782F(param_00.origin,level.players,[param_00],4,512);
	var_02 = sortbydistance(var_01,param_00.origin);
	var_03 = undefined;
	foreach(var_05 in var_02)
	{
		var_06 = sighttracepassed(param_00 geteye(),var_05 geteye(),0,param_00);
		if(!var_06)
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_05.inlaststand))
		{
			continue;
		}

		var_03 = var_05;
		break;
	}

	return var_03;
}

//Function Number: 89
linktoplayer_fire_chains(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	param_00 endon("disconnect");
	while(scripts\common\utility::istrue(param_00.var_AD2D))
	{
		thread deal_damage_to_zombies_entering_the_link(self,param_02);
		if(scripts\common\utility::istrue(param_01.inlaststand))
		{
			param_00.var_AD2D = undefined;
			param_00 notify("lost_target_fire_chains");
			break;
		}
		else if(distance(param_00.origin,param_01.origin) > 512)
		{
			param_00.var_AD2D = undefined;
			param_00 notify("lost_target_fire_chains");
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 90
deal_damage_to_zombies_entering_the_link(param_00,param_01)
{
	param_00 endon("disconnect");
	var_02 = [];
	var_03 = scripts\common\trace::func_48B1();
	var_02 = [param_00,param_00.var_2A9A];
	if(!isdefined(param_00.var_2A9A))
	{
		return;
	}

	foreach(var_05 in param_01)
	{
		var_06 = scripts\common\trace::func_DCED(param_00 gettagorigin(var_05),param_00.var_2A9A gettagorigin(var_05),var_02,var_03);
		if(isdefined(var_06["entity"]))
		{
			if(var_06["entity"] scripts\cp\_utility::agentisfnfimmune())
			{
				continue;
			}

			var_07 = scripts\common\utility::istrue(var_06["entity"].is_skeleton);
			if(level.script == "cp_final")
			{
				var_07 = 0;
			}

			if(var_06["entity"] scripts\cp\_utility::func_9D20() && var_06["entity"].agent_type != "slasher" && var_06["entity"].agent_type != "superslasher" && var_06["entity"].agent_type != "zombie_brute" && var_06["entity"].agent_type != "zombie_grey")
			{
				scripts\common\utility::array_add(var_02,var_06["entity"]);
				var_06["entity"].nocorpse = 1;
				var_06["entity"].full_gib = 1;
				var_06["entity"] dodamage(1000000,var_06["entity"].origin,param_00,param_00);
			}
		}
	}
}

//Function Number: 91
playfirechainsfx(param_00,param_01,param_02)
{
	var_03 = [];
	foreach(var_05 in level.players)
	{
		var_03[var_03.size] = function_02DF(level._effect["fire_chains"],self,param_01,param_00,param_01,var_05);
	}

	self.fx_array_fire_chains = var_03;
	self playloopsound("zmb_fnf_fire_chains_lp");
	param_00 playloopsound("zmb_fnf_fire_chains_lp");
	var_07 = scripts\cp\_utility::func_1372D(self,"disconnect",self,"lost_target_fire_chains",self,"last_stand",self,param_02 + "_timeup",param_00,"disconnect",param_00,"last_stand",level,"game_ended");
	if(isdefined(self))
	{
		self stoploopsound();
	}

	if(isdefined(param_00))
	{
		param_00 stoploopsound();
	}

	foreach(var_09 in var_03)
	{
		if(isdefined(var_09))
		{
			var_09 delete();
		}
	}
}

//Function Number: 92
removefirechainsdamagemodifieronlaststand(param_00)
{
	self endon(param_00 + "_timeup");
	self waittill("last_stand");
	self.var_AC4B = undefined;
	self.life_link_active = undefined;
	if(isdefined(self.var_AD2D))
	{
		self.var_AD2D = undefined;
	}

	self notify(param_00 + "_exited_early");
}

//Function Number: 93
removefirechainsdamagemodifierontimeout(param_00)
{
	self endon("last_stand");
	self waittill(param_00 + "_timeup");
	self.var_AC4B = undefined;
	self.life_link_active = undefined;
	if(isdefined(self.var_AD2D))
	{
		self.var_AD2D = undefined;
	}
}

//Function Number: 94
use_irish_luck(param_00)
{
	self endon(param_00 + "_timeup");
	self endon("last_stand");
	self endon("disconnect");
	level endon("game_ended");
}

//Function Number: 95
irish_luck_choose_random_consumable(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(param_00.stored_fnf))
	{
		param_00.stored_fnf = [];
	}

	foreach(var_03, var_02 in param_00.var_456B)
	{
		param_00.stored_fnf[var_03] = var_03;
	}

	for(;;)
	{
		var_04 = scripts\common\utility::random(level.irish_luck_consumables);
		if(getdvar("irish_luck_debug","") != "")
		{
			param_00.stored_fnf = [];
			var_05 = getdvar("irish_luck_debug","");
			foreach(var_08, var_07 in level.irish_luck_consumables)
			{
				if(var_08 == var_05)
				{
					var_04 = level.irish_luck_consumables[var_08];
				}
			}
		}

		if(scripts\common\utility::func_2286(param_00.stored_fnf,var_04.name))
		{
			scripts\common\utility::func_136F7();
			continue;
		}
		else
		{
			scripts\common\utility::func_136F7();
			return var_04;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 96
clear_omnvar(param_00)
{
	self endon("disconnect");
	wait(5);
	self setclientomnvar(param_00,0);
}

//Function Number: 97
consumable_activate_internal_irish(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("dpad_end_" + param_00);
	self endon("give_new_deck");
	self endon("last_stand");
	level.random_consumable_chosen = irish_luck_choose_random_consumable(self);
	if(self.var_456B[param_00].var_130D1 > 0 && self.var_456B[param_00].var_C4A4 == 0 && !scripts\cp\_laststand::player_in_laststand(self))
	{
		self.var_456B[level.random_consumable_chosen.name] = spawnstruct();
		self.var_456B[level.random_consumable_chosen.name].var_130D1 = level.var_456B[level.random_consumable_chosen.name].var_130D1;
		self.var_456B[level.random_consumable_chosen.name].var_C4A4 = 1;
		self.var_456B[level.random_consumable_chosen.name].var_11925 = 0;
		self.var_456B[level.random_consumable_chosen.name].var_1307B = param_04;
		level.random_consumable_chosen.var_DE3F = int(tablelookup("cp/loot/iw7_zombiefatefortune_loot_master.csv",1,level.random_consumable_chosen.name,0));
		self setclientomnvar("zm_ui_irish_luck",level.random_consumable_chosen.var_DE3F);
		thread clear_omnvar("zm_ui_irish_luck");
		self setclientomnvar("zm_fate_card_used",param_05);
		self.var_456B[param_00].var_D9A1 = 1;
		var_07 = undefined;
		var_08 = "fired_super";
		thread func_F306(param_00);
		if(isdefined(level.var_456B[level.random_consumable_chosen.name].var_13089))
		{
			if(isdefined(level.var_456B[level.random_consumable_chosen.name].var_1174E))
			{
				var_07 = self [[ level.var_456B[level.random_consumable_chosen.name].var_13089 ]](level.random_consumable_chosen.name);
			}
			else
			{
				var_07 = self thread [[ level.var_456B[level.random_consumable_chosen.name].var_13089 ]](level.random_consumable_chosen.name);
			}
		}

		self.var_456B[param_00].var_C4A4 = 0;
		if(!isdefined(var_07) || isdefined(var_07) && var_07)
		{
			func_4574(self,param_00);
			self.var_456B[param_00].var_11925++;
			scripts\cp\zombies\zombie_analytics::func_AF6C(1,param_00,level.wave_num,self);
			scripts\cp\_merits::func_D9AD("mt_faf_uses");
			thread scripts\cp\_vo::try_to_play_vo("wonder_consume","zmb_comment_vo","low",10,0,1,0,40);
			if(self.var_456B[param_00].var_11925 == 1)
			{
				thread decrement_counter_of_consumables(param_00);
			}

			thread func_ACAF();
			self setclientomnvar("zm_dpad_up_activated",5);
			self setclientomnvarbit("zm_card_fill_display",param_05,1);
			self setclientomnvar("zm_consumable_selection_ready",0);
			func_DFD4(param_06);
			thread func_B69D();
			self playlocalsound("ui_consumable_select");
			func_CCCC(self);
			self notify("consumable_selected");
			self setweaponammostock(self.var_6BA3,1);
			self giveandfireoffhand(self.var_6BA3);
			self.var_4561 = undefined;
			thread scripts\cp\_vo::func_E01F("nag_use_fateandfort");
			var_09 = level.var_456B[level.random_consumable_chosen.name].type;
			if(var_09 == "timedactivations")
			{
				thread func_5B02(level.random_consumable_chosen.name,level.var_456B[level.random_consumable_chosen.name].var_12F9A,param_01,var_08,param_02,param_03,param_04,param_05);
			}
			else if(var_09 == "wave")
			{
				thread func_5B04(level.random_consumable_chosen.name,level.var_456B[level.random_consumable_chosen.name].var_12F9A,param_01,var_08,param_02,param_03,param_04,param_05);
			}
			else if(var_09 == "triggernow" || level.var_456B[level.random_consumable_chosen.name].type == "triggerwait")
			{
				thread func_5B01(level.random_consumable_chosen.name,level.var_456B[level.random_consumable_chosen.name].type,self.var_456B[level.random_consumable_chosen.name].var_130D1,param_01,var_08,param_02,param_03,param_04,param_05);
			}
			else if(var_09 == "triggerpassive")
			{
				thread func_5B03(level.random_consumable_chosen.name,level.var_456B[level.random_consumable_chosen.name].var_C948,param_01,var_08,param_02,param_03,param_04,param_05);
			}

			if(isdefined(var_07))
			{
				scripts\cp\_utility::func_C151(param_00);
				return;
			}

			return;
		}

		self playlocalsound("ui_consumable_deny");
		self.var_456B[param_00].var_D9A1 = undefined;
	}
}

//Function Number: 98
use_temporal_increase(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	self endon(param_00 + "_timeup");
	self endon("last_stand");
	if(isdefined(level.temporal_increase))
	{
		return 0;
	}

	level.temporal_increase = 2;
	thread remove_temporal_increase(param_00);
}

//Function Number: 99
remove_temporal_increase(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	scripts\common\utility::waittill_any_3(param_00 + "_timeup","disconnect","death",param_00 + "_exited_early");
	level.temporal_increase = undefined;
	return 1;
}

//Function Number: 100
use_twister(param_00)
{
	self endon("disconnect");
	self endon(param_00 + "_timeup");
	self endon(param_00 + "_exited_early");
	self endon("death");
	self endon("last_stand");
	level endon("game_ended");
	var_01 = self getplayerangles();
	var_02 = self geteye();
	var_03 = (0,0,0);
	var_04 = anglestoforward(var_01);
	var_05 = var_02 + var_04 * 100;
	thread remove_twister(param_00,self);
	thread activate_twister_homing(self.origin,param_00);
}

//Function Number: 101
remove_twister(param_00,param_01)
{
	level endon("game_ended");
	param_01 scripts\common\utility::waittill_any_3(param_00 + "_timeup",param_00 + "_exited_early","disconnect");
	level notify("stop_twister_sfx");
	if(isdefined(param_01.var_757B))
	{
		param_01.var_757B delete();
	}

	if(isdefined(param_01.trigger_move_ent))
	{
		param_01.trigger_move_ent delete();
	}
}

//Function Number: 102
activate_twister_homing(param_00,param_01)
{
	self endon("disconnect");
	self endon(param_01 + "_timeup");
	self endon(param_01 + "_exited_early");
	level endon("game_ended");
	if(!isdefined(self.twister_array_zombie))
	{
		self.twister_array_zombie = [];
	}

	self.trigger_move_ent = spawn("script_model",param_00,0,512,128);
	self.trigger_move_ent setmodel("tag_origin");
	level.trigger_move_ent_sfx = spawn("script_model",param_00,0,512,128);
	level.trigger_move_ent_sfx linkto(self.trigger_move_ent);
	wait(0.5);
	level.trigger_move_ent_sfx thread twister_sfx();
	playfxontag(level._effect["twister"],self.trigger_move_ent,"tag_origin");
	self.trigger_move_ent method_831F(self);
	self.trigger_move_ent thread deal_damage_to_enemies(self,param_01);
	thread move_ent_function(self.trigger_move_ent,param_01);
}

//Function Number: 103
twister_sfx()
{
	self playsound("fnf_tornado_start_lr");
	wait(0.4);
	self playloopsound("fnf_tornado_lr_lp");
	level waittill("stop_twister_sfx");
	level thread scripts\common\utility::play_sound_in_space("fnf_tornado_stop_lr",self.origin);
	wait(0.15);
	self stoploopsound();
	self delete();
}

//Function Number: 104
get_zombie_targets(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 endon(param_01 + "_timeup");
	param_00 endon(param_01 + "_exited_early");
	level endon("game_ended");
	for(;;)
	{
		var_02 = scripts\cp\_agent_utils::get_alive_enemies();
		var_03 = scripts\common\utility::func_782F(param_00.origin,var_02,undefined,24,2048);
		if(isdefined(level.dlc4_boss))
		{
			if(scripts\common\utility::func_2286(var_03,level.dlc4_boss))
			{
				var_03 = scripts\common\utility::func_22A9(var_03,level.dlc4_boss);
			}
		}

		if(var_03.size <= 0)
		{
			scripts\common\utility::func_136F7();
			param_00.twister_array_zombie = [];
			param_00.twister_array_zombie[param_00.twister_array_zombie.size] = getclosestpointonnavmesh(self.origin) + (0,10,0);
			continue;
		}
		else
		{
			foreach(var_05 in var_03)
			{
				if(var_05 scripts\cp\_utility::agentisfnfimmune() && var_05.agent_type != "alien_rhino")
				{
					scripts\common\utility::func_136F7();
					continue;
				}

				if(scripts\common\utility::istrue(level.meph_fight_started))
				{
					if(var_05 scripts\cp\_utility::agentisfnfimmune())
					{
						scripts\common\utility::func_136F7();
						continue;
					}
					else
					{
						param_00.twister_array_zombie = param_00 method_8428(param_00.origin,scripts\common\utility::func_5D14(var_03[var_03.size - 1].origin,1,1));
					}

					continue;
				}

				if(isdefined(level.rhino_array) && level.rhino_array.size > 0)
				{
					param_00.twister_array_zombie = param_00 method_8428(param_00.origin,scripts\common\utility::func_5D14(var_03[var_03.size - 1].origin,1,1));
					continue;
				}

				if(scripts\common\utility::istrue(var_05.entered_playspace))
				{
					param_00.twister_array_zombie = param_00 method_8428(param_00.origin,scripts\common\utility::func_5D14(var_03[var_03.size - 1].origin,1,1));
				}
			}
		}

		wait(2.5);
	}
}

//Function Number: 105
deal_damage_to_enemies(param_00,param_01)
{
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon(param_01 + "_timeup");
	param_00 endon(param_01 + "_exited_early");
	level endon("game_ended");
	for(;;)
	{
		var_02 = scripts\cp\_agent_utils::get_alive_enemies();
		foreach(var_04 in var_02)
		{
			if(!isdefined(var_04))
			{
				continue;
			}

			if(!var_04 scripts\cp\_utility::func_9D20())
			{
				continue;
			}

			if(distance2dsquared(self.origin,var_04.origin) < 22500)
			{
				if(var_04 scripts\cp\_utility::agentisfnfimmune())
				{
					var_04 dodamage(5,var_04.origin,param_00,param_00,"MOD_UNKNOWN");
					continue;
				}

				if(isdefined(var_04.agent_type) && var_04.agent_type == "slasher" || var_04.agent_type == "superslasher")
				{
					var_04 dodamage(1000,var_04.origin,param_00,param_00,"MOD_UNKNOWN");
					continue;
				}

				var_04 thread fling_zombie_thundergun_harpoon(var_04.health + 1000,var_04,param_00,self);
			}
		}

		wait(1);
	}
}

//Function Number: 106
fling_zombie_thundergun_harpoon(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_03 endon("death");
	if(!isdefined(param_03))
	{
		return;
	}

	var_04 = param_01.origin - param_03.origin;
	var_05 = anglestoup(self.angles);
	self setvelocity(vectornormalize(param_03.origin - self.origin * 400) + (0,0,800));
	wait(0.16);
	if(isdefined(param_02))
	{
		param_01.do_immediate_ragdoll = 1;
		param_01.disable_armor = 1;
		param_01.var_4C87 = 1;
		wait(0.1);
		param_01.nocorpse = 1;
		param_01.full_gib = 1;
		self dodamage(self.health + 1000,param_01.origin,param_02,param_02,"MOD_UNKNOWN","iw7_twister_zm");
		return;
	}

	self.nocorpse = 1;
	self.full_gib = 1;
	self dodamage(self.health + 1000,param_01.origin,param_01,param_01,"MOD_UNKNOWN","iw7_twister_zm");
}

//Function Number: 107
move_ent_function(param_00,param_01)
{
	self endon("disconnect");
	self endon(param_01 + "_timeup");
	self endon(param_01 + "_exited_early");
	var_02 = 0;
	thread get_zombie_targets(self,param_01);
	for(;;)
	{
		if(!isdefined(self.twister_array_zombie[var_02]) && var_02 >= self.twister_array_zombie.size)
		{
			if(self.twister_array_zombie.size > 0)
			{
				if(isdefined(self.twister_array_zombie[0]))
				{
					if([[ level.var_164B ]](self.twister_array_zombie[0]))
					{
						param_00 moveto(self.twister_array_zombie[0],0.5,0.25,0);
					}
					else
					{
						var_03 = getclosestpointonnavmesh(self.twister_array_zombie[0]) + (0,10,0);
						param_00 moveto(var_03,0.5);
					}

					var_02--;
				}
			}
			else
			{
				var_02 = 0;
			}

			scripts\common\utility::func_136F7();
			continue;
		}
		else
		{
			param_00 moveto(self.twister_array_zombie[var_02],0.5,0,0);
		}

		var_02 = var_02 + 1;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 108
use_dodge_mode(param_00)
{
	self endon("disconnect");
	self endon(param_00 + "_timeup");
	self endon(param_00 + "_exited_early");
	self endon("last_stand");
	self endon("death");
	level endon("game_ended");
	self method_842E(1,50);
	self method_842C(1,50);
	self method_8434(1,25);
	self method_8430(1,0);
	self method_8412(1);
	self method_8454(5);
	thread func_139F9(param_00);
	thread remove_dodge_mode(param_00);
}

//Function Number: 109
remove_dodge_mode(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_3(param_00 + "_timeup",param_00 + "_exited_early","death","last_stand");
	self method_8412(0);
	self notify(param_00 + "_timeup");
	self notify(param_00 + "_exited_early");
}

//Function Number: 110
watchforzombiecollisions(param_00)
{
	self endon("death");
	self endon("disconnect");
	self notify("setDodge");
	self endon("setDodge");
	self endon(param_00 + "_timeup");
	self endon(param_00 + "_exited_early");
	level endon("game_ended");
	self endon("last_stand");
	while(scripts\common\utility::istrue(self.var_5812))
	{
		var_01 = scripts\cp\_agent_utils::get_alive_enemies();
		foreach(var_03 in var_01)
		{
			if(scripts\common\utility::func_56F4(var_03.origin,self.origin) <= 5184)
			{
				if(var_03 scripts\cp\_utility::agentisfnfimmune())
				{
					continue;
				}

				if(var_03 scripts\cp\_utility::func_9D20() && var_03.agent_type != "slasher" && var_03.agent_type != "superslasher" && var_03.agent_type != "zombie_brute" && var_03.agent_type != "zombie_grey")
				{
					var_03.exp_touch = 1;
					var_03.nocorpse = 1;
					var_03.full_gib = 1;
					var_03.hit_by_dodging_player = 1;
					playsoundatpos(var_03 gettagorigin("j_spineupper"),"zmb_fnf_explosive_touch_explo");
					wait(0.1);
					playfx(scripts\common\utility::getfx("dodge_touch"),var_03 gettagorigin("j_spineupper"));
					var_03 dodamage(var_03.health + 100,var_03.origin,self,self,"MOD_EXPLOSIVE","iw7_pickup_zm");
				}
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 111
func_139F9(param_00)
{
	self endon("disconnect");
	self endon(param_00 + "_timeup");
	self endon(param_00 + "_exited_early");
	level endon("game_ended");
	self endon("last_stand");
	self endon("death");
	for(;;)
	{
		self waittill("dodgeBegin");
		if(isdefined(self.var_45D6) && self.var_45D6 == 1)
		{
			continue;
		}

		self.var_5812 = 1;
		thread func_139FB(param_00);
		thread watchforzombiecollisions(param_00);
		var_01 = self getnormalizedmovement();
		for(;;)
		{
			if(var_01[0] > 0)
			{
				if(var_01[1] <= 0.7 && var_01[1] >= -0.7)
				{
					playfx(scripts\common\utility::getfx("dodge_fwd_screen"),self gettagorigin("tag_eye"),anglestoforward(self.angles),anglestoup(self.angles),self);
					break;
				}

				if(var_01[0] > 0.5 && var_01[1] > 0.7)
				{
					playfx(scripts\common\utility::getfx("dodge_fwd_right_screen"),self gettagorigin("tag_eye"),anglestoforward(self.angles),anglestoup(self.angles),self);
					break;
				}

				if(var_01[0] > 0.5 && var_01[1] < -0.7)
				{
					playfx(scripts\common\utility::getfx("dodge_fwd_left_screen"),self gettagorigin("tag_eye"),anglestoforward(self.angles),anglestoup(self.angles),self);
					break;
				}
			}

			if(var_01[0] < 0)
			{
				if(var_01[1] < 0.4 && var_01[1] > -0.4)
				{
					playfx(scripts\common\utility::getfx("dodge_back_screen"),self gettagorigin("tag_eye"),anglestoforward(self.angles),anglestoup(self.angles),self);
					break;
				}

				if(var_01[0] < -0.5 && var_01[1] > 0.5)
				{
					playfx(scripts\common\utility::getfx("dodge_back_right_screen"),self gettagorigin("tag_eye"),anglestoforward(self.angles),anglestoup(self.angles),self);
					break;
				}

				if(var_01[0] < -0.5 && var_01[1] < -0.5)
				{
					playfx(scripts\common\utility::getfx("dodge_back_left_screen"),self gettagorigin("tag_eye"),anglestoforward(self.angles),anglestoup(self.angles),self);
					break;
				}
			}

			if(var_01[1] > 0.4)
			{
				playfx(scripts\common\utility::getfx("dodge_right_screen"),self gettagorigin("tag_eye"),anglestoforward(self.angles),anglestoup(self.angles),self);
				break;
			}

			if(var_01[1] < -0.4)
			{
				playfx(scripts\common\utility::getfx("dodge_left_screen"),self gettagorigin("tag_eye"),anglestoforward(self.angles),anglestoup(self.angles),self);
				break;
			}
			else
			{
				break;
			}
		}

		self playlocalsound("zmb_fnf_evade");
		self playsound("zmb_fnf_evade_npc");
	}
}

//Function Number: 112
func_139FB(param_00)
{
	level endon("game_ended");
	scripts\common\utility::waittill_any_3("dodgeEnd","death","disconnect","last_stand");
	self.var_5812 = 0;
	if(isdefined(self.var_5809))
	{
		self.var_5809 delete();
	}
}

//Function Number: 113
use_ammo_crate(param_00)
{
	if(isdefined(level.ammo_crate))
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	create_ammo_crate_interaction(param_00);
}

//Function Number: 114
create_ammo_crate_interaction(param_00)
{
	self endon("disconnect");
	self endon(param_00 + "_timeup");
	self endon(param_00 + "_exited_early");
	self endon("death");
	self endon("last_stand");
	level endon("game_ended");
	var_01 = scripts\common\utility::func_5D14(self.origin,0,-2000);
	var_02 = spawn("script_model",var_01);
	var_02 setmodel("tag_origin_ammo_crate");
	level.ammo_crate = var_02;
	level.ammo_crate thread give_ammo_to_players_standing_nearby(self,param_00);
	thread remove_ammo_crate(param_00);
}

//Function Number: 115
give_ammo_to_players_standing_nearby(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("last_stand");
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon(param_01 + "_timeup");
	param_00 endon(param_01 + "_exited_early");
	level endon("game_ended");
	for(;;)
	{
		foreach(param_00 in level.players)
		{
			if(!isdefined(param_00))
			{
				continue;
			}

			if(distance2dsquared(self.origin,param_00.origin) < 22500)
			{
				if(param_00 cangive_ammo())
				{
					playfx(level._effect["ammo_crate_ping"],self.origin,anglestoforward(self.angles),anglestoup(self.angles));
					param_00 give_ammo_to_player_through_crate();
					param_00 notify("consumable_charge",150);
					param_00 thread scripts\cp\_vo::try_to_play_vo("pillage_ammo","zmb_comment_vo","low",10,0,1,0,50);
					scripts\common\utility::func_136F7();
					continue;
				}

				param_00 scripts\cp\_utility::setlowermessage("max_ammo",&"COOP_GAME_PLAY_AMMO_MAX",3);
			}
		}

		wait(5);
	}
}

//Function Number: 116
cangive_ammo()
{
	var_00 = scripts\cp\_utility::getvalidtakeweapon();
	var_01 = self getweaponammoclip(var_00);
	var_02 = weaponclipsize(var_00);
	var_03 = function_0249(var_00);
	var_04 = self getweaponammostock(var_00);
	if(var_04 < var_03 || var_01 < var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 117
give_ammo_to_player_through_crate()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(!scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(function_024C(var_02) == "riotshield")
		{
			continue;
		}

		if(scripts\cp\_weapon::func_9C22(var_02))
		{
			continue;
		}

		var_03 = weaponclipsize(var_02);
		adjust_clip_ammo_from_stock(self,var_02,"right",var_03,0);
		if(self method_819C())
		{
			adjust_clip_ammo_from_stock(self,var_02,"left",var_03,1);
		}
	}

	self playlocalsound("weap_ammo_pickup");
}

//Function Number: 118
adjust_clip_ammo_from_stock(param_00,param_01,param_02,param_03,param_04)
{
	if(!scripts\common\utility::istrue(param_04))
	{
		var_05 = function_0249(param_01);
		var_06 = param_00 getweaponammostock(param_01);
		var_07 = var_05 - var_06;
		var_08 = scripts\common\utility::func_116D7(var_07 >= param_03,var_06 + param_03,var_05);
		param_00 setweaponammostock(param_01,var_08);
	}

	var_09 = param_00 getweaponammoclip(param_01,param_02);
	var_0A = param_03 - var_09;
	var_0B = min(var_09 + var_0A,param_03);
	param_00 setweaponammoclip(param_01,int(var_0B),param_02);
}

//Function Number: 119
remove_ammo_crate(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_3(param_00 + "_timeup",param_00 + "_exited_early","last_stand","death");
	scripts\cp\_utility::func_C151("ammo_crate");
	if(isdefined(level.ammo_crate))
	{
		level.ammo_crate delete();
	}
}

//Function Number: 120
use_stimulus(param_00)
{
	self endon("disconnect");
	self endon(param_00 + "_timeup");
	self endon(param_00 + "_exited_early");
	self endon("death");
	self endon("last_stand");
	level endon("game_ended");
	self.stimulus_active = 1;
	thread remove_stimulus(param_00);
}

//Function Number: 121
revive_downed_entities(param_00)
{
	param_00 scripts\cp\zombies\zombie_afterlife_arcade::func_1794();
	scripts\cp\_laststand::func_992F(param_00);
	param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::func_E0AE(0.1);
}

//Function Number: 122
remove_stimulus(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_3(param_00 + "_timeup",param_00 + "_exited_early","last_stand","death");
	if(scripts\common\utility::istrue(self.stimulus_active))
	{
		self.stimulus_active = undefined;
	}
}

//Function Number: 123
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
	
			setomnvar("zm_chem_current_color",3);
			break;

		case "cp_town_color":
			param_00 = "cp_town_color";
			setomnvar("zm_chem_current_color",0);
			setomnvar("zm_chem_bvalue_choice",level.bad_choice_index_default);
			setomnvar("zm_chem_value_choice",0);
			break;
	}
}

//Function Number: 124
use_activate_gns_machine(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	foreach(var_02 in level.players)
	{
		if(self != var_02)
		{
			if(var_02 scripts\cp\_utility::func_9BA0(param_00))
			{
				self playlocalsound("ui_consumable_deny");
				return 0;
			}
		}
	}

	level.skulls_before_activation = getomnvar("zm_num_ghost_n_skull_coin");
	if(level.skulls_before_activation == 6 || level.skulls_before_activation == -1)
	{
		return 0;
	}

	self.activate_gns_machine = 1;
	level thread func_135F6(self);
	thread remove_activate_gns_machine(param_00);
	self waittill("end_this_gns_fnf_card");
	if(isdefined(level.gns_game_console_vfx))
	{
		level.gns_game_console_vfx delete();
	}

	if(isdefined(level.entered_thru_card))
	{
		level.entered_thru_card = undefined;
	}

	scripts\cp\_utility::func_C151(param_00);
	self notify(param_00 + "_timeup");
	self notify(param_00 + "_exited_early");
}

//Function Number: 125
remove_activate_gns_machine(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("end_this_gns_fnf_card");
	for(;;)
	{
		var_01 = scripts\cp\_utility::func_1372D(self,"last_stand",self,param_00 + "_timeup",self,param_00 + "_exited_early",level,"end_this_thread_of_gns_fnf_card");
		if(isdefined(var_01))
		{
			if(var_01 == "last_stand")
			{
				if(!scripts\common\utility::istrue(level.entered_thru_card))
				{
					cleanup_gns_scriptstuff();
				}

				continue;
			}

			cleanup_gns_scriptstuff();
		}
	}
}

//Function Number: 126
cleanup_gns_scriptstuff()
{
	if(scripts\common\utility::istrue(self.activate_gns_machine))
	{
		self.activate_gns_machine = undefined;
	}

	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_12DF8(level.skulls_before_activation);
	if(level.script == "cp_town")
	{
		if(!isdefined(level.film_grain_off))
		{
			level thread applyvisionsettoallplayers("cp_town_bw");
		}
		else
		{
			level thread applyvisionsettoallplayers(level.current_vision_set);
		}
	}

	self notify("end_this_gns_fnf_card");
}

//Function Number: 127
get_activated_vfx_postion_based_on_map(param_00)
{
	switch(param_00)
	{
		case "cp_zmb":
			return (5459,-4767,29);

		case "cp_rave":
			return (-282,-1483,437);

		case "cp_disco":
			return (-713,2609,943);

		case "cp_town":
			return (5459,-4767,29);

		case "cp_final":
			return (5638,-6260,103);
	}
}

//Function Number: 128
get_corner_position_based_on_map(param_00)
{
	switch(param_00)
	{
		case "cp_zmb":
			return (2874,-542,242);

		case "cp_rave":
			return (-294,-1469,396);

		case "cp_disco":
			return (-731,2611,898);

		case "cp_town":
			return (5444,-4760,-14);

		case "cp_final":
			return (5652,-6231,71);
	}
}

//Function Number: 129
get_activation_radius_square_based_on_map(param_00)
{
	switch(param_00)
	{
		case "cp_zmb":
			return 2500;

		case "cp_rave":
			return 2500;

		case "cp_disco":
			return 2500;

		case "cp_town":
			return 10000;

		case "cp_final":
			return 10000;
	}
}

//Function Number: 130
func_135F6(param_00)
{
	self endon("last_stand");
	self endon("end_this_gns_fnf_card");
	level endon("player_debug_activate_cabinet");
	level endon("end_this_thread_of_gns_fnf_card");
	var_01 = get_activated_vfx_postion_based_on_map(level.script);
	var_02 = undefined;
	if(level.script == "cp_zmb")
	{
		var_02 = disable_arcade_cabinet_next_to_ghost_n_skull();
		var_03 = getent("ghost_arcade_activation_area","targetname");
	}

	level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"],var_01);
	triggerfx(level.gns_game_console_vfx);
	var_04 = get_corner_position_based_on_map(level.script);
	var_05 = get_activation_radius_square_based_on_map(level.script);
	for(;;)
	{
		var_06 = 1;
		foreach(var_08 in level.players)
		{
			if(scripts\common\utility::istrue(var_08.inlaststand))
			{
				var_06 = 0;
				break;
			}

			if(scripts\common\utility::istrue(var_08.var_9D81))
			{
				var_06 = 0;
				break;
			}

			if(scripts\common\utility::istrue(var_08.var_9FCB))
			{
				var_06 = 0;
				break;
			}

			if(distancesquared(var_08.origin,var_04) > var_05)
			{
				var_06 = 0;
				break;
			}

			if(!var_08 usebuttonpressed())
			{
				var_06 = 0;
				break;
			}

			if(!scripts\common\utility::istrue(param_00.activate_gns_machine))
			{
				var_06 = 0;
				break;
			}
		}

		wait(0.25);
		if(var_06)
		{
			var_06 = 1;
			foreach(var_08 in level.players)
			{
				if(scripts\common\utility::istrue(var_08.inlaststand))
				{
					var_06 = 0;
					break;
				}

				if(scripts\common\utility::istrue(var_08.var_9D81))
				{
					var_06 = 0;
					break;
				}

				if(scripts\common\utility::istrue(var_08.var_9FCB))
				{
					var_06 = 0;
					break;
				}

				if(distancesquared(var_08.origin,var_04) > var_05)
				{
					var_06 = 0;
					break;
				}

				if(!var_08 usebuttonpressed())
				{
					var_06 = 0;
					break;
				}

				if(!scripts\common\utility::istrue(param_00.activate_gns_machine))
				{
					var_06 = 0;
					break;
				}

				if(level.script == "cp_disco")
				{
					if(isdefined(level.clock_interaction) && isdefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_08)
					{
						var_06 = 0;
					}

					if(isdefined(level.clock_interaction_q2) && isdefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_08)
					{
						var_06 = 0;
					}

					if(isdefined(level.clock_interaction_q3) && isdefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_08)
					{
						var_06 = 0;
					}

					if(scripts\common\utility::istrue(var_08.start_breaking_clock))
					{
						var_06 = 0;
					}

					if(scripts\common\utility::istrue(var_08.is_using_gourd))
					{
						var_06 = 0;
					}

					if(scripts\common\utility::istrue(var_08.kung_fu_mode))
					{
						var_06 = 0;
					}
				}
			}
		}

		if(var_06)
		{
			if(isdefined(level.gns_game_console_vfx))
			{
				level.gns_game_console_vfx delete();
				if(level.script == "cp_zmb")
				{
					enable_arcade_cabinet_next_to_ghost_n_skull(var_02);
				}

				level thread func_447F();
				return;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 131
func_447F()
{
	level.entered_thru_card = 1;
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(level.skulls_before_activation,0.5);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_10C61();
}

//Function Number: 132
disable_arcade_cabinet_next_to_ghost_n_skull()
{
	var_00 = get_arcade_interaction_next_to_ghost_n_skull();
	scripts\cp\_interaction::remove_from_current_interaction_list(var_00);
	return var_00;
}

//Function Number: 133
enable_arcade_cabinet_next_to_ghost_n_skull(param_00)
{
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 134
get_arcade_interaction_next_to_ghost_n_skull()
{
	var_00 = (2829,-538,241);
	foreach(var_02 in level.current_interaction_structs)
	{
		if(distancesquared(var_02.origin,var_00) < 100)
		{
			return var_02;
		}
	}
}

//Function Number: 135
use_get_pap2_gun(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	if(self method_81B5())
	{
		self.var_456B[param_00].var_C4A4 = 0;
		self playlocalsound("perk_machine_deny");
		return 0;
	}

	if(scripts\common\utility::istrue(self.is_in_pap))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(level.gns_active))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_9FCB))
	{
		self.var_456B[param_00].var_C4A4 = 0;
		return 0;
	}

	var_01 = choose_random_weapon_from_list(param_00);
	scripts\cp\_utility::func_C151(param_00);
	return var_01;
}

//Function Number: 136
choose_random_weapon_from_list(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	self endon(param_00 + "_timeup");
	for(;;)
	{
		var_01 = scripts\common\utility::random(level.var_C8A2);
		var_02 = self getcurrentweapon();
		var_03 = scripts\cp\_utility::func_80D8(var_01);
		if(can_upgrade_via_pap2fnfcard(var_01,1))
		{
			thread func_834A(self,param_00,var_03,var_01);
			self.var_9FCB = 0;
			return 1;
		}
		else
		{
			scripts\common\utility::func_136F7();
			continue;
		}
	}
}

//Function Number: 137
func_834A(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = self getweaponslistprimaries();
	var_0A = self getweaponslistprimaries().size;
	var_0B = 3;
	var_0C = param_02;
	var_0D = spawnstruct();
	var_0D.var_B111 = 2;
	param_00.var_C8A2[var_0C] = var_0D;
	if(!param_00 scripts\cp\_weapon::func_8BBB(param_03))
	{
		var_0E = param_00 scripts\cp\_utility::getvalidtakeweapon();
		param_00.var_4B32 = var_0E;
		if(isdefined(var_0E))
		{
			var_05 = 1;
			var_0F = scripts\cp\_utility::func_80D8(var_0E);
			if(param_00 scripts\cp\_utility::func_8BAE() && var_0A < var_0B + 1)
			{
				var_05 = 0;
			}

			foreach(var_11 in var_09)
			{
				if(scripts\cp\_utility::isstrstart(var_11,"alt_"))
				{
					var_0B++;
				}
			}

			if(scripts\cp\_utility::has_zombie_perk("perk_machine_more"))
			{
				var_0B++;
			}

			if(var_09.size < var_0B)
			{
				var_05 = 0;
			}

			if(var_05)
			{
				if(isdefined(param_00.var_C8A2[var_0F]))
				{
					param_00.var_C8A2[var_0F] = undefined;
					param_00 notify("weapon_level_changed");
				}

				param_00 takeweapon(var_0E);
			}
		}

		if(isdefined(param_00.var_13C00[var_0C]))
		{
			var_06 = param_00.var_13C00[var_0C];
		}
		else
		{
			var_06 = param_03;
		}

		if(isdefined(param_02))
		{
			if(isdefined(level.no_pap_camos) && scripts\common\utility::func_2286(level.no_pap_camos,param_02))
			{
				var_08 = undefined;
			}
			else if(isdefined(level.pap_1_camo) && param_00.var_C8A2[param_02].var_B111 == 1)
			{
				var_08 = level.pap_1_camo;
			}
			else if(isdefined(level.pap_2_camo) && param_00.var_C8A2[param_02].var_B111 == 2)
			{
				var_08 = level.pap_2_camo;
			}

			var_13 = param_00 scripts\cp\_weapon::func_7D62(param_03);
		}

		var_14 = 0;
		var_15 = undefined;
		if(isdefined(param_02))
		{
			if(isdefined(param_00.var_C8A2[param_02]))
			{
				var_15 = "pap" + param_00.var_C8A2[param_02].var_B111;
			}
			else
			{
				var_15 = "pap1";
			}
		}

		if(isdefined(var_15) && var_15 == "replace_me")
		{
			var_15 = undefined;
		}

		var_16 = function_00E3(var_06);
		var_17 = scripts\cp\_weapon::func_E469(var_06,var_15,var_16,undefined,var_08);
		var_17 = scripts\cp\_utility::func_12C6(var_17,undefined,undefined,1);
		self.pap2_card_weapon = var_17;
		param_00.var_A035 = var_17;
		param_00 scripts\cp\_utility::take_fists_weapon(self);
		param_00 notify("weapon_purchased");
		param_00.var_C8A2[param_02].var_B111 = 3;
		param_00 givemaxammo(var_17);
		param_00 notify("weapon_level_changed");
		param_00 switchtoweapon(var_17);
		while(param_00 method_81C2())
		{
			wait(0.05);
		}
	}
	else
	{
		param_00.var_DB02 = 1;
		var_0C = undefined;
		var_18 = param_00 getweaponslistall();
		var_19 = param_00 getcurrentweapon();
		var_1A = scripts\cp\_utility::func_80D8(param_03);
		var_1B = undefined;
		foreach(param_03 in var_18)
		{
			var_0C = scripts\cp\_utility::func_80D8(param_03);
			if(var_0C == var_1A)
			{
				var_1B = param_03;
				break;
			}
		}

		var_1E = function_0249(var_1B);
		var_1F = param_00 lib_0CFF::func_D876();
		var_20 = int(var_1F * var_1E);
		var_21 = param_00 getweaponammostock(var_1B);
		if(var_21 < var_20)
		{
			param_00 setweaponammostock(var_1B,var_20);
		}
	}

	wait(0.05);
	param_00 notify("weapon_purchased");
	param_00.var_DB02 = undefined;
}

//Function Number: 138
can_upgrade_via_pap2fnfcard(param_00,param_01)
{
	var_02 = self getweaponslistall();
	foreach(var_04 in var_02)
	{
		var_05 = scripts\cp\_utility::func_80D8(param_00);
		var_06 = scripts\cp\_utility::func_80D8(var_04);
		if(var_05 == var_06)
		{
			return 0;
		}
	}

	if(scripts\cp\_utility::weapon_is_dlc_melee(param_00) || scripts\cp\_utility::weapon_is_dlc2_melee(param_00) || issubstr(param_00,"knife") || issubstr(param_00,"slasher") || issubstr(param_00,"axe") || issubstr(param_00,"lawnmower") || issubstr(param_00,"harpoon"))
	{
		return 0;
	}

	if(isdefined(level.weapon_upgrade_path) && isdefined(level.weapon_upgrade_path[getweaponbasename(param_00)]))
	{
		return 0;
	}

	if(issubstr(param_00,"forgefreeze") || issubstr(param_00,"cutie") || issubstr(param_00,"nunchucks") || issubstr(param_00,"katana") || issubstr(param_00,"headcutter") || issubstr(param_00,"dischord") || issubstr(param_00,"facemelter") || issubstr(param_00,"shredder"))
	{
		return 0;
	}

	if(!isdefined(level.var_C8A2))
	{
		return 0;
	}

	if(isdefined(param_00))
	{
		var_05 = scripts\cp\_utility::func_80D8(param_00);
	}
	else
	{
		return 0;
	}

	if(!isdefined(var_05))
	{
		return 0;
	}

	if(!isdefined(level.var_C8A2[var_05]))
	{
		var_04 = getsubstr(var_05,0,var_05.size - 1);
		if(!isdefined(level.var_C8A2[var_04]))
		{
			return 0;
		}
	}

	if(isdefined(self.var_C8A2[var_05]) && self.var_C8A2[var_05].var_B111 >= 3)
	{
		return 0;
	}
	else
	{
		return 1;
	}

	if(scripts\common\utility::istrue(param_01) && isdefined(self.var_C8A2[var_05]) && self.var_C8A2[var_05].var_B111 <= min(level.var_C8A4 + 1,2))
	{
		return 1;
	}

	return 1;
}

//Function Number: 139
func_1300E(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_exited_early");
	scripts\cp\_laststand::func_6235(self);
	thread func_E167(param_00);
	for(;;)
	{
		self waittill("player_has_self_revive",var_01);
		if(var_01)
		{
			continue;
		}

		self waittill("revive");
		self stoplocalsound("zmb_laststand_music");
		scripts\cp\_laststand::func_557F(self);
		if(scripts\cp\_utility::has_zombie_perk("perk_machine_tough"))
		{
			self.maxhealth = 200;
			self.health = self.maxhealth;
		}

		scripts\cp\_utility::func_C151(param_00);
		break;
	}
}

//Function Number: 140
func_E167(param_00)
{
	self endon(param_00 + " activated");
	self endon("disconnect");
	level endon("game_ended");
	self waittill(param_00 + "_exited_early");
	scripts\cp\_laststand::func_557F(self);
}

//Function Number: 141
func_13038(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	var_01 = scripts\cp\_persistence::func_7B8B();
	var_02 = int(var_01 / level.players.size);
	scripts\cp\_persistence::func_F525(var_02);
	foreach(var_04 in level.players)
	{
		if(var_04 == self)
		{
			continue;
		}

		var_04 scripts\cp\_persistence::func_82F9(var_02,undefined,undefined,1,"bonus");
	}

	scripts\cp\_utility::func_C151(param_00);
	return 1;
}

//Function Number: 142
func_12FF5(param_00)
{
	self endon(param_00 + "_timeup");
	self endon("disconnect");
	if(!isdefined(level.var_455C))
	{
		level.var_455C = 0;
	}

	thread func_12E39(param_00);
	thread func_40E2(param_00);
	setomnvar("zom_escape_combo_multiplier",1);
	for(;;)
	{
		var_01 = scripts\common\utility::func_13734("shot_missed","weapon_hit_enemy");
		if(var_01 == "shot_missed")
		{
			level.var_455C = level.var_455C - 0.02;
		}
		else
		{
			level.var_455C = level.var_455C + 0.02;
		}

		if(level.var_455C < 0)
		{
			level.var_455C = 0;
		}

		self notify("update_team_efficiency");
	}
}

//Function Number: 143
func_12E39(param_00)
{
	self endon(param_00 + "_timeup");
	self endon("disconnect");
	while(isdefined(level.var_455C))
	{
		self waittill("update_team_efficiency");
		var_01 = 1 + level.var_455C;
		setomnvar("zom_escape_combo_multiplier",var_01);
	}

	setomnvar("zom_escape_combo_multiplier",-1);
}

//Function Number: 144
func_40E2(param_00)
{
	var_01 = scripts\common\utility::func_13734(param_00 + "_timeup",param_00 + "_exited_early","disconnect");
	level.var_455C = undefined;
}

//Function Number: 145
func_13012(param_00)
{
	self endon(param_00 + "_timeup");
	self endon("disconnect");
	thread func_E16D(param_00);
	foreach(var_02 in scripts\cp\_agent_utils::func_7DB0("axis"))
	{
		var_02 thread func_1887(var_02,param_00,self);
	}

	for(;;)
	{
		level waittill("agent_spawned",var_04);
		var_04 thread func_1887(var_04,param_00,self,1);
	}
}

//Function Number: 146
func_1887(param_00,param_01,param_02,param_03)
{
	param_00 endon("death");
	if(isdefined(param_00.agent_type) && param_00.agent_type == "zombie_brute" || param_00.agent_type == "zombie_grey" || param_00.agent_type == "zombie_ghost")
	{
		return;
	}

	if(isdefined(param_00.agent_type) && param_00.agent_type == "crab_brute" || param_00.agent_type == "crab_mini")
	{
		return;
	}

	if(param_00 scripts\cp\_utility::agentisfnfimmune())
	{
		return;
	}

	if(scripts\common\utility::istrue(param_00.var_9CDD))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_03))
	{
		wait(0.5);
	}

	if(!isdefined(param_00.var_2303.var_4B12))
	{
		var_04 = param_00.var_1F5;
	}
	else
	{
		var_04 = param_01.var_2303.var_4B12;
	}

	switch(var_04)
	{
		case "slow_walk":
			break;

		case "walk":
		case "sprint":
		case "run":
			param_00 lib_0A1B::func_2968("slow_walk");
			break;
	}

	param_02 scripts\common\utility::waittill_any_3(param_01 + "_timeup","last_stand","disconnect");
	param_00 lib_0A1B::func_2968(var_04);
}

//Function Number: 147
func_E16D(param_00)
{
	self endon(param_00 + "_timeup");
	self waittill("last_stand");
	self notify(param_00 + "_exited_early");
}

//Function Number: 148
func_12FF8(param_00)
{
	self endon(param_00 + "_timeup");
	self endon("last_stand");
	self endon("disconnect");
	level endon("game_ended");
	self.life_link_active = undefined;
	self.var_AC4B = 1;
	var_01 = "j_spine4";
	thread func_E0E8(param_00);
	thread func_E0E7(param_00);
	var_02 = self;
	for(;;)
	{
		var_03 = func_7F72(self);
		if(isdefined(var_03))
		{
			self notify("lost_target",var_03);
			self.var_AD2D = 1;
			thread func_D4BC(var_03,var_01,param_00);
			var_02.life_link_active = 1;
			func_AD4A(self,var_03);
			continue;
		}

		var_02.life_link_active = undefined;
		wait(0.5);
	}
}

//Function Number: 149
func_7F72(param_00)
{
	var_01 = scripts\common\utility::func_782F(param_00.origin,level.players,[param_00],4,512);
	var_02 = sortbydistance(var_01,param_00.origin);
	var_03 = undefined;
	foreach(var_05 in var_02)
	{
		var_06 = sighttracepassed(param_00 geteye(),var_05 geteye(),0,param_00);
		if(!var_06)
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_05.inlaststand))
		{
			continue;
		}

		var_03 = var_05;
		break;
	}

	return var_03;
}

//Function Number: 150
func_AD4A(param_00,param_01)
{
	param_00 endon("disconnect");
	while(scripts\common\utility::istrue(param_00.var_AD2D))
	{
		if(scripts\common\utility::istrue(param_01.inlaststand))
		{
			param_00.var_AD2D = undefined;
			param_00 notify("lost_target");
			break;
		}
		else if(distance(param_00.origin,param_01.origin) > 512)
		{
			param_00.var_AD2D = undefined;
			param_00 notify("lost_target");
			break;
		}
		else
		{
			var_02 = sighttracepassed(param_00 geteye(),param_01 geteye(),0,param_00);
			if(!var_02)
			{
				param_00.var_AD2D = undefined;
				param_00 notify("lost_target");
			}
		}

		wait(0.25);
	}
}

//Function Number: 151
func_D4BC(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	self endon("disconnect");
	var_03 = [];
	playfxontag(level._effect["life_link_target"],param_00,param_01);
	foreach(var_05 in level.players)
	{
		var_03[var_03.size] = function_02DF(level._effect["life_link"],self,param_01,param_00,param_01,var_05);
	}

	self playloopsound("zmb_fnf_lifelink_heal_lp");
	param_00 playloopsound("zmb_fnf_lifelink_heal_lp");
	var_07 = scripts\cp\_utility::func_1372D(self,"disconnect",self,"lost_target",self,"last_stand",self,param_02 + "_timeup",param_00,"disconnect",param_00,"last_stand",level,"game_ended");
	if(isdefined(self))
	{
		self stoploopsound();
	}

	if(isdefined(param_00))
	{
		param_00 stoploopsound();
	}

	foreach(var_09 in var_03)
	{
		if(isdefined(var_09))
		{
			var_09 delete();
		}
	}

	if(isdefined(param_00))
	{
		killfxontag(level._effect["life_link_target"],param_00,param_01);
	}
}

//Function Number: 152
func_E0E7(param_00)
{
	self endon(param_00 + "_timeup");
	self waittill("last_stand");
	self.var_AC4B = undefined;
	self.life_link_active = undefined;
	if(isdefined(self.var_AD2D))
	{
		self.var_AD2D = undefined;
	}

	self notify(param_00 + "_exited_early");
}

//Function Number: 153
func_E0E8(param_00)
{
	self endon("last_stand");
	self waittill(param_00 + "_timeup");
	self.var_AC4B = undefined;
	self.life_link_active = undefined;
	if(isdefined(self.var_AD2D))
	{
		self.var_AD2D = undefined;
	}
}

//Function Number: 154
func_13002(param_00)
{
	var_01 = level.players;
	var_02 = 0;
	foreach(var_04 in var_01)
	{
		var_05 = var_04;
		if(isdefined(var_04.var_222))
		{
			var_05 = var_04.var_222;
		}

		if(scripts\cp\_laststand::player_in_laststand(var_05))
		{
			var_02 = 1;
			if(scripts\common\utility::istrue(var_05.var_A623))
			{
				thread delayed_instant_revive(var_05);
				continue;
			}

			scripts\cp\_laststand::func_992F(var_05);
			scripts\cp\_laststand::func_DDEA(self,var_05);
		}
	}

	if(!var_02)
	{
		self.var_456B["phoenix_up"].var_C4A4 = 0;
		scripts\common\utility::func_136F7();
		return 0;
	}

	wait(0.25);
	scripts\cp\_utility::func_C151("phoenix_up");
	return 1;
}

//Function Number: 155
delayed_instant_revive(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("revive");
	wait(4);
	scripts\cp\_laststand::func_992F(param_00);
	scripts\cp\_laststand::func_DDEA(self,param_00);
}

//Function Number: 156
func_12FF6(param_00)
{
	level endon("game_ended");
	if(isdefined(level.meph_fight_started))
	{
		return 0;
	}

	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02.killing_time))
		{
			var_02.killing_time = 0;
		}

		var_02.killing_time++;
	}

	scripts\common\utility::func_136F7();
	scripts\cp\_utility::func_C151("killing_time");
	scripts\common\utility::waittill_any_timeout_1(20,"death","last_stand","disconnect");
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.killing_time))
		{
			var_02.killing_time--;
			if(var_02.killing_time <= 0)
			{
				var_02.killing_time = undefined;
			}
		}
	}
}

//Function Number: 157
func_12FFF(param_00)
{
	level endon("game_ended");
	self endon("last_stand");
	self endon("disconnect");
	thread func_E141(param_00);
	foreach(var_02 in level.players)
	{
		if(var_02 == self)
		{
			if(var_02 scripts\cp\_utility::func_9E3A())
			{
				var_02 scripts\cp\_utility::func_1C5C(0);
			}

			continue;
		}

		var_02 scripts\cp\_utility::func_1C5C(1);
	}

	wait(10);
	foreach(var_02 in level.players)
	{
		if(var_02 scripts\cp\_utility::func_9E3A())
		{
			var_02 scripts\cp\_utility::func_1C5C(0);
		}
	}
}

//Function Number: 158
func_E141(param_00)
{
	var_01 = scripts\common\utility::func_13734("last_stand","disconnect",param_00 + "_timeup",param_00 + "_exited_early");
	foreach(var_03 in level.players)
	{
		if(var_03 scripts\cp\_utility::func_9E3A())
		{
			var_03 scripts\cp\_utility::func_1C5C(0);
		}
	}

	if(isdefined(var_01) && var_01 == "last_stand")
	{
		self notify(param_00 + "_exited_early");
	}
}

//Function Number: 159
func_12FA2(param_00)
{
	if(!scripts\cp\_utility::isteleportenabled() || scripts\common\utility::istrue(self.is_in_pap))
	{
		self.var_456B["anywhere_but_here"].var_C4A4 = 0;
		return 0;
	}

	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		self.var_456B["anywhere_but_here"].var_C4A4 = 0;
		return 0;
	}

	var_01 = level.active_player_respawn_locs;
	var_01 = scripts\common\utility::func_22AF(var_01);
	foreach(var_03 in level.active_player_respawn_locs)
	{
		var_04 = scripts\cp\zombies\zombies_spawning::func_7C82(0,1,self);
		foreach(var_06 in var_04)
		{
			if(function_010F(var_03.origin,var_06))
			{
				var_01 = scripts\common\utility::func_22A9(var_01,var_03);
			}
		}
	}

	if(var_01.size < 1)
	{
		var_01 = level.active_player_respawn_locs;
	}

	var_09 = scripts\cp\gametypes\zombie::func_7C0B(level.players,var_01);
	if(!isdefined(var_09))
	{
		self.var_456B["anywhere_but_here"].var_C4A4 = 0;
		return 0;
	}

	if(scripts\cp\_utility::map_check(4))
	{
		var_0A = scripts\cp\zombies\zombies_spawning::func_7C82(0,1,self);
		foreach(var_0C in var_0A)
		{
			if(isdefined(level.facilityvolumes) && scripts\common\utility::func_2286(level.facilityvolumes,var_0C.var_28AB))
			{
				self.currentlocation = "facility";
				continue;
			}

			self.currentlocation = "theater";
		}
	}

	lib_0D12::func_5AA3();
	scripts\cp\_interaction::func_DE6E();
	scripts\cp\powers\coop_powers::func_D72E();
	self method_80F3();
	self setorigin(var_09.origin);
	self setplayerangles(var_09.angles);
	self notify("left_hidden_room_early");
	scripts\cp\_utility::func_C151("anywhere_but_here");
	self.abh_used = gettime();
	return 1;
}

//Function Number: 160
func_A4F5(param_00)
{
	level endon("game_ended");
	level.players[0] endon("death");
	level.players[0] endon("last_stand");
	foreach(var_02 in level.active_player_respawn_locs)
	{
		level.players[0] lib_0D12::func_5AA3();
		level.players[0] scripts\cp\_interaction::func_DE6E();
		level.players[0] scripts\cp\powers\coop_powers::func_D72E();
		level.players[0] method_80F3();
		level.players[0] setorigin(var_02.origin);
		level.players[0] setplayerangles(var_02.angles);
		wait(2);
	}
}

//Function Number: 161
func_12FF2(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon(param_00 + "_timeup");
	self.var_8C9E = gettime();
}

//Function Number: 162
func_8C9D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!scripts\cp\_utility::func_9BA0("headshot_reload"))
	{
		return 0;
	}

	if(!scripts\common\utility::func_9D74(param_03))
	{
		return 0;
	}

	if(!scripts\cp\_utility::func_9E27(param_04,param_06,param_03,param_01))
	{
		return 0;
	}

	if(isdefined(param_09) && param_09 scripts\cp\_utility::agentisfnfimmune())
	{
		return 0;
	}

	param_04 = self getcurrentweapon();
	var_0A = self getweaponammostock(param_04);
	var_0B = weaponclipsize(param_04);
	var_0C = self getweaponammoclip(param_04);
	var_0D = var_0B - var_0C;
	if(var_0A >= var_0D)
	{
		self setweaponammostock(param_04,var_0A - var_0D);
	}
	else
	{
		var_0B = var_0A;
		self setweaponammostock(param_04,0);
	}

	var_0E = var_0B;
	var_0F = min(var_0C + var_0E,var_0B);
	self setweaponammoclip(param_04,int(var_0F));
	if(self method_819C())
	{
		var_0C = self getweaponammoclip(param_04,"left");
		var_0F = min(var_0C + var_0E,var_0B);
		self setweaponammoclip(param_04,int(var_0F),"left");
	}
}

//Function Number: 163
func_12FF1(param_00)
{
	self.var_D721 = 1;
	scripts\cp\powers\coop_powers::func_D71A(1,"primary");
	var_01 = getarraykeys(self.var_D782);
	foreach(var_03 in var_01)
	{
		self.var_D782[var_03].var_461B = 1;
	}
}

//Function Number: 164
func_12955(param_00)
{
	self.var_D721 = 0;
}

//Function Number: 165
func_13DFE(param_00,param_01)
{
	if(!isdefined(param_00.var_456B))
	{
		return;
	}

	var_02 = 0;
	foreach(var_06, var_04 in param_00.consumables_pre_irish_luck_usage)
	{
		var_05 = func_78DE(var_06);
		setclientmatchdata("player",param_01,"cardsUsed",var_02,"loot_ID",int(var_05));
		setclientmatchdata("player",param_01,"cardsUsed",var_02,"num_of_times_used",var_04.var_11925);
		var_02++;
	}
}

//Function Number: 166
func_78DE(param_00)
{
	return tablelookup("cp/loot/iw7_zombiefatefortune_loot_master.csv",1,param_00,0);
}

//Function Number: 167
func_F306(param_00)
{
	return self [[ level.var_456B[param_00].var_F286 ]](param_00);
}

//Function Number: 168
func_12BF6(param_00)
{
	self [[ level.var_456B[param_00].var_12BF4 ]](param_00);
}