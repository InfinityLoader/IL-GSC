/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_town\cp_town_weapon_upgrade.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 1437 ms
 * Timestamp: 10/27/2023 12:07:47 AM
*******************************************************************/

//Function Number: 1
init_weapon_upgrade()
{
	level.pap_room_func = ::cp_town_pap_machine_func;
	level.max_pap_func = ::func_385F;
	func_94F2();
}

//Function Number: 2
func_94F2()
{
	var_00 = scripts\common\utility::getstructarray("weapon_upgrade","script_noteworthy");
	level.var_7D63 = ::scripts\cp\_weapon::func_7D62;
	foreach(var_02 in var_00)
	{
		var_02.var_D776 = 1;
		var_02 thread func_9795();
	}
}

//Function Number: 3
func_9795()
{
	if(scripts\common\utility::istrue(self.var_E1B9))
	{
		level scripts\common\utility::waittill_any_3("power_on",self.var_D71C + " power_on");
	}

	var_00 = getent("pap_machine","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(isdefined(level.pap_room_func))
	{
		[[ level.pap_room_func ]](self,var_00);
		return;
	}

	var_00 setscriptablepartstate("door","open_idle");
	var_00 setscriptablepartstate("reels","on");
	self.var_D776 = 1;
}

//Function Number: 4
set_fuse_icon_on_hotjoin(param_00)
{
	level notify("stop_hotjoin_fuse");
	level endon("stop_hotjoin_fuse");
	for(;;)
	{
		level waittill("connected",var_01);
		var_01 setclientomnvar("zm_special_item",param_00);
	}
}

//Function Number: 5
func_13C62(param_00,param_01)
{
	param_01 endon("disconnect");
	if(scripts\common\utility::istrue(level.has_picked_up_fuses) && !isdefined(level.placed_alien_fuses))
	{
		level.placed_alien_fuses = 1;
		param_01 thread scripts\cp\_vo::try_to_play_vo("pap_place_fuse","town_comment_vo","low",10,0,0,1,100);
		level thread place_fuses_in_machine(param_00,param_01);
		foreach(param_01 in level.players)
		{
			param_01 setclientomnvar("zm_special_item",0);
		}

		level thread set_fuse_icon_on_hotjoin(0);
		return;
	}

	var_04 = var_03 getcurrentweapon();
	var_05 = scripts\cp\_utility::func_80D8(var_04);
	var_06 = var_03 scripts\cp\_weapon::func_7D62(var_05);
	var_07 = undefined;
	var_08 = get_player_fists_weapon(var_03);
	var_09 = "none";
	var_0A = undefined;
	var_0B = 0;
	if(!can_use_pap_machine(var_05))
	{
		return;
	}

	if(var_03 func_385F(var_04))
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
		var_0C = scripts\common\utility::getstruct(var_02.target,"targetname");
		var_0D = vectornormalize(anglestoforward(var_03.angles)) * 16;
		var_06 = int(var_06);
		var_06++;
		var_0E = var_04;
		var_0F = validate_current_weapon(var_06,var_05,var_04);
		var_07 = get_pap_offhand_weapon(var_03,var_04);
		var_0A = get_pap_camo(var_06,var_05,var_04);
		var_0B = should_use_old_model(var_06,var_05,var_04);
		process_pap_stat_logging(var_05,var_03);
		thread play_pap_vo(var_03);
		var_09 = return_pap_attachment(var_03,var_06,var_05,var_04);
		if(isdefined(var_09) && var_09 == "replace_me")
		{
			var_09 = undefined;
		}

		var_10 = filter_current_weapon_attachments(var_04);
		var_11 = remove_invalid_wm_attachments(var_10);
		var_04 = var_03 scripts\cp\_weapon::func_E469(var_0F,undefined,var_11);
		var_12 = var_03 scripts\cp\_weapon::func_E469(var_0F,var_09,var_11,undefined,var_0A);
		var_13 = var_03 scripts\cp\_weapon::func_E469(var_0F,var_09,var_10,undefined,var_0A);
		if(var_0B)
		{
			var_14 = spawn("script_weapon",var_03 geteye() + var_0D,0,0,var_0E);
		}
		else
		{
			var_14 = spawn("script_weapon",var_04 geteye() + var_0E,0,0,var_05);
		}

		var_14.angles = var_02.angles;
		if(var_0B)
		{
			var_15 = disco_getoffsetfrombaseweaponname(var_0E);
		}
		else
		{
			var_15 = disco_getoffsetfrombaseweaponname(var_14);
		}

		level thread func_DF48(var_03,var_14,var_02);
		level notify("pap_used",var_03,var_06,var_13);
		var_14 makeunusable();
		var_03 thread disco_playpapgesture(var_03,var_03.pap_gesture,var_07,var_04,var_0E);
		var_03.var_C8AB = var_04;
		if(var_0B)
		{
			var_16 = getangleoffset(var_0E,var_0C);
		}
		else
		{
			var_16 = getangleoffset(var_14,var_0D);
		}

		var_17 = lib_0D41::func_8087(var_05);
		var_14 moveto(var_0C.origin + var_17,0.75);
		var_14 rotateto(var_16,0.75);
		var_14 waittill("movedone");
		var_14 moveto(var_0C.origin + var_15,0.25);
		var_14 waittill("movedone");
		update_level_pap_machines("door","close",undefined,undefined,"zmb_packapunch_machine_on");
		wait(0.75);
		if(!scripts\common\utility::flag("fuses_inserted"))
		{
			update_level_pap_machines("papfx","normal","papfx","upgraded");
		}

		wait(3.5);
		update_level_pap_machines("door","decomp");
		wait(0.8);
		var_14 method_8536(var_12);
		wait(0.4);
		update_level_pap_machines("door","open_idle");
		update_level_pap_machines("papfx","idle");
		wait(0.5);
		var_14 makeusable();
		var_14 method_84A2(100);
		if(var_03 scripts\cp\_utility::is_valid_player())
		{
			foreach(var_19 in level.players)
			{
				if(var_19 == var_03)
				{
					var_14 enableplayeruse(var_19);
					continue;
				}

				var_14 disableplayeruse(var_19);
			}

			if(var_0F == "iw7_katana_zm_pap1")
			{
				var_03 lib_0D2A::func_12D7C("SLICED_AND_DICED",1);
				var_03 thread scripts\cp\_vo::try_to_play_vo("weapon_pap_katana_1","zmb_pap_vo","high",undefined,undefined,undefined,1);
			}
			else if(var_0F == "iw7_katana_zm_pap2")
			{
				var_03 thread scripts\cp\_vo::try_to_play_vo("weapon_pap_katana_2","zmb_pap_vo","high",undefined,undefined,undefined,1);
			}
			else if(var_0F == "iw7_nunchucks_zm_pap1")
			{
				var_03 thread scripts\cp\_vo::try_to_play_vo("weapon_pap_nunchucks_1","zmb_pap_vo","high",undefined,undefined,undefined,1);
			}
			else if(var_0F == "iw7_nunchucks_zm_pap2")
			{
				var_03 thread scripts\cp\_vo::try_to_play_vo("weapon_pap_nunchucks_2","zmb_pap_vo","high",undefined,undefined,undefined,1);
			}

			var_03 scripts\cp\_merits::func_D9AD("mt_upgrade_weapons");
		}

		var_14 thread func_1360B(var_13,var_08,var_06);
		var_14 scripts\common\utility::waittill_any_timeout_1(30,"weapon_taken");
		if(var_03 scripts\cp\_utility::is_valid_player())
		{
			var_03 notify("weapon_purchased");
			var_03.var_C8AB = undefined;
			var_03 scripts\cp\_interaction::func_DE6E();
			var_03 scripts\cp\_merits::func_D9AD("mt_dlc3_upgrade_weapons");
		}

		var_14 delete();
		wait(1);
		scripts\cp\_interaction::add_to_current_interaction_list(var_02);
		level notify("pap_machine_activated");
	}
}

//Function Number: 6
func_1360B(param_00,param_01,param_02)
{
	self endon("death");
	self waittill("trigger",var_03);
	if(!isdefined(param_01))
	{
		param_01 = "iw7_fists_zm";
	}

	if(var_03 hasweapon(param_01))
	{
		var_03 takeweapon(param_01);
	}

	if(var_03 scripts\cp\_weapon::func_8BBB(param_00))
	{
		var_04 = scripts\cp\_utility::func_80D8(param_00);
		foreach(var_06 in var_03 getweaponslistall())
		{
			var_07 = scripts\cp\_utility::func_80D8(var_06);
			if(var_04 == var_07)
			{
				var_03 takeweapon(var_06);
			}
		}
	}

	if(lib_0D41::func_FFA6(var_03))
	{
		var_09 = var_03 getcurrentweapon();
		var_0A = scripts\cp\_utility::func_80D8(var_09);
		var_03 takeweapon(var_09);
	}

	self notify("weapon_taken");
	param_00 = var_03 scripts\cp\_utility::func_12C6(param_00,undefined,undefined,0);
	var_03 givemaxammo(param_00);
	var_0B = var_03 getweaponslistprimaries();
	foreach(var_06 in var_0B)
	{
		if(issubstr(var_06,param_00))
		{
			if(scripts\cp\_utility::func_9D3E(var_06))
			{
				var_04 = getweaponbasename(var_06);
				if(isdefined(level.mode_weapons_allowed) && scripts\common\utility::func_2286(level.mode_weapons_allowed,var_04))
				{
					param_00 = "alt_" + param_00;
					break;
				}
			}
		}
	}

	var_03 switchtoweapon(param_00);
	var_04 = scripts\cp\_utility::func_80D8(param_00);
	var_03.var_C8A2[var_04].var_B111++;
	var_03 scripts\cp\_persistence::give_player_xp(500,1);
	var_03 notify("weapon_level_changed");
}

//Function Number: 7
disco_playpapgesture(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = get_player_fists_weapon(param_00);
	param_00 scripts\cp\_utility::func_12C6(var_05,undefined,undefined,1);
	param_00 method_83B6(var_05);
	param_00 takeweapon(param_04);
	wait(1);
	thread scripts\cp\_utility::firegesturegrenade(param_00,param_01);
	wait(2.5);
	if(isdefined(param_02))
	{
		param_00 method_83B6(param_02);
		if(param_00 hasweapon(var_05))
		{
			param_00 takeweapon(var_05);
		}
	}
}

//Function Number: 8
get_player_fists_weapon(param_00)
{
	if(isdefined(param_00.var_134FD))
	{
		switch(param_00.var_134FD)
		{
			case "p1_":
				return "iw7_fists_zm";

			case "p2_":
				return "iw7_fists_zm";

			case "p3_":
				return "iw7_fists_zm";

			case "p4_":
				return "iw7_fists_zm";

			case "p5_":
				return "iw7_fists_zm";

			default:
				return "iw7_fists_zm";
		}

		return;
	}

	return "iw7_fists_zm";
}

//Function Number: 9
getangleoffset(param_00,param_01)
{
	var_02 = scripts\cp\_utility::func_7DF7(param_00);
	var_03 = param_01.angles;
	switch(var_02)
	{
		case "iw7_nunchucks":
		case "iw7_katana":
		case "iw7_spiked":
		case "iw7_golf":
		case "iw7_two":
		case "iw7_machete":
			return (90,90,0);

		default:
			return var_03;
	}
}

//Function Number: 10
disco_getoffsetfrombaseweaponname(param_00)
{
	var_01 = scripts\cp\_utility::func_7DF7(param_00);
	var_02 = lib_0D41::func_801F(param_00);
	switch(var_01)
	{
		case "iw7_machete":
			return (0,-6,2);

		case "iw7_two":
			return (0,-8,2);

		case "iw7_spiked":
		case "iw7_golf":
			return (0,-12,2);

		case "iw7_nunchucks":
		case "iw7_katana":
			return (0,-12,2);

		default:
			return var_02;
	}
}

//Function Number: 11
return_pap_attachment(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = undefined;
	if(isdefined(param_02))
	{
		switch(param_02)
		{
			case "spiked":
			case "golf":
			case "two":
			case "machete":
			case "nunchucks":
			case "katana":
				return "replace_me";

			default:
				if(scripts\common\utility::istrue(param_04))
				{
					return undefined;
				}
	
				if(isdefined(param_00.var_C8A2[param_02]))
				{
					return "pap" + param_00.var_C8A2[param_02].var_B111;
				}
				else
				{
					return "pap1";
				}
	
				break;
		}
	}

	return var_05;
}

//Function Number: 12
cp_town_pap_machine_func(param_00,param_01)
{
	level.pap_machine = param_01;
	level.pap_machine hide();
	param_00.var_D776 = 1;
}

//Function Number: 13
place_fuses_in_machine(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	upgrade_machine_for_all_players();
	update_level_pap_machines("door","close");
	wait(0.5);
	update_level_pap_machines("machine","upgraded");
	wait(0.25);
	update_level_pap_machines("reels","neutral");
	wait(0.25);
	update_level_pap_machines("reels","on");
	wait(0.25);
	update_level_pap_machines("door","open_idle");
	wait(0.25);
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	if(param_01 scripts\cp\_utility::is_valid_player())
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("pap_upgrade","zmb_pap_vo","high");
	}
}

//Function Number: 14
upgrade_machine_for_all_players()
{
	foreach(var_01 in level.player_pap_machines)
	{
		var_01 setmodel("zmb_pap_machine_animated_soul_key");
	}

	scripts\common\utility::func_136F7();
}

//Function Number: 15
update_level_pap_machines(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = isdefined(param_02) && isdefined(param_03);
	foreach(var_07 in level.player_pap_machines)
	{
		if(isdefined(param_04))
		{
			var_07 playsound(param_04);
		}

		if(scripts\common\utility::istrue(level.placed_alien_fuses) && var_05)
		{
			var_07 setscriptablepartstate(param_02,param_03);
			continue;
		}

		var_07 setscriptablepartstate(param_00,param_01);
	}
}

//Function Number: 16
func_DF48(param_00,param_01,param_02)
{
	level endon("pap_machine_activated");
	param_00 waittill("disconnect");
	update_level_pap_machines("door","decomp");
	wait(1.2);
	update_level_pap_machines("door","open_idle");
	update_level_pap_machines("papfx","idle");
	param_01 delete();
	wait(1);
	scripts\cp\_interaction::add_to_current_interaction_list(param_02);
	level notify("pap_machine_activated");
}

//Function Number: 17
can_use_pap_machine(param_00)
{
	if(param_00 == "dischord" || param_00 == "facemelter" || param_00 == "headcutter" || param_00 == "shredder")
	{
		if(!scripts\common\utility::flag("fuses_inserted"))
		{
			return 0;
		}

		return 1;
	}

	return 1;
}

//Function Number: 18
get_pap_offhand_weapon(param_00,param_01)
{
	var_02 = param_00 getweaponslistprimaries();
	foreach(var_04 in var_02)
	{
		if(!issubstr(param_01,var_04) && !scripts\cp\_utility::isstrstart(var_04,"alt_") && !issubstr(var_04,"knife") && var_04 != "iw7_knife_zm_disco")
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 19
validate_current_weapon(param_00,param_01,param_02)
{
	if(isdefined(level.weapon_upgrade_path) && isdefined(level.weapon_upgrade_path[getweaponbasename(param_02)]))
	{
		param_02 = level.weapon_upgrade_path[getweaponbasename(param_02)];
	}
	else if(isdefined(param_01))
	{
		switch(param_01)
		{
			case "two":
				if(param_00 == 2)
				{
					param_02 = "iw7_two_headed_axe_mp";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_two_headed_axe_mp";
				}
				break;

			case "golf":
				if(param_00 == 2)
				{
					param_02 = "iw7_golf_club_mp";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_golf_club_mp";
				}
				break;

			case "machete":
				if(param_00 == 2)
				{
					param_02 = "iw7_machete_mp";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_machete_mp";
				}
				break;

			case "spiked":
				if(param_00 == 2)
				{
					param_02 = "iw7_spiked_bat_mp";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_spiked_bat_mp";
				}
				break;

			case "axe":
				if(param_00 == 2)
				{
					param_02 = "iw7_axe_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_axe_zm_pap2";
				}
				break;

			case "katana":
				if(param_00 == 2)
				{
					param_02 = "iw7_katana_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_katana_zm_pap2";
				}
				break;

			case "nunchucks":
				if(param_00 == 2)
				{
					param_02 = "iw7_nunchucks_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_nunchucks_zm_pap2";
				}
				break;

			default:
				return param_02;
		}
	}

	return param_02;
}

//Function Number: 20
should_use_old_model(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		switch(param_01)
		{
			case "spiked":
			case "golf":
			case "two":
			case "axe":
			case "machete":
				return 1;

			default:
				return 0;
		}

		return;
	}

	return 0;
}

//Function Number: 21
get_pap_camo(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(isdefined(param_01))
	{
		if(isdefined(level.no_pap_camos) && scripts\common\utility::func_2286(level.no_pap_camos,param_01))
		{
			var_03 = undefined;
		}
		else if(isdefined(level.pap_1_camo) && isdefined(param_00) && param_00 == 2)
		{
			var_03 = level.pap_1_camo;
		}
		else if(isdefined(level.pap_2_camo) && isdefined(param_00) && param_00 == 3)
		{
			var_03 = level.pap_2_camo;
		}

		switch(param_01)
		{
			case "dischord":
				param_02 = "iw7_dischord_zm_pap1";
				var_03 = "camo20";
				break;

			case "facemelter":
				param_02 = "iw7_facemelter_zm_pap1";
				var_03 = "camo22";
				break;

			case "headcutter":
				param_02 = "iw7_headcutter_zm_pap1";
				var_03 = "camo21";
				break;

			case "nunchucks":
			case "katana":
				var_03 = "camo222";
				break;

			case "forgefreeze":
				if(param_00 == 2)
				{
					param_02 = "iw7_forgefreeze_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_forgefreeze_zm_pap2";
				}
	
				var_04 = 1;
				break;

			case "axe":
				if(param_00 == 2)
				{
					param_02 = "iw7_axe_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_axe_zm_pap2";
				}
	
				var_04 = 1;
				break;

			case "shredder":
				param_02 = "iw7_shredder_zm_pap1";
				var_03 = "camo23";
				break;
		}
	}

	return var_03;
}

//Function Number: 22
play_pap_vo(param_00)
{
	param_00 thread scripts\cp\_vo::try_to_play_vo("weapon_pap","rave_pap_vo","high");
}

//Function Number: 23
process_pap_stat_logging(param_00,param_01)
{
	level.var_1192E++;
	scripts\cp\zombies\zombie_analytics::func_AF7F(level.wave_num,param_00,level.var_1192E);
}

//Function Number: 24
filter_current_weapon_attachments(param_00)
{
	var_01 = function_00E3(param_00);
	if(issubstr(param_00,"g18_z"))
	{
		foreach(var_03 in var_01)
		{
			if(issubstr(var_03,"akimbo"))
			{
				var_01 = scripts\common\utility::func_22A9(var_01,var_03);
			}
		}
	}

	return var_01;
}

//Function Number: 25
remove_invalid_wm_attachments(param_00)
{
	var_01 = param_00;
	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"silencer") || issubstr(var_03,"arcane") || issubstr(var_03,"ark"))
		{
			var_01 = scripts\common\utility::func_22A9(var_01,var_03);
		}
	}

	return param_00;
}

//Function Number: 26
weapon_upgrade_hint_func(param_00,param_01)
{
	if(scripts\common\utility::istrue(level.has_picked_up_fuses) && !isdefined(level.placed_alien_fuses))
	{
		return &"CP_TOWN_PAP_UPGRADE";
	}

	level.interactions[param_00.script_noteworthy].cost = 5000;
	var_02 = param_01 getcurrentweapon();
	var_03 = scripts\cp\_weapon::func_7D62(var_02);
	if(scripts\common\utility::istrue(level.placed_alien_fuses))
	{
		if(var_03 == 3)
		{
			return &"COOP_INTERACTIONS_UPGRADE_MAXED";
		}
		else if(!func_385F(var_02))
		{
			return &"CP_TOWN_UPGRADE_WEAPON_FAIL";
		}
		else if(var_03 == 1)
		{
			return &"CP_TOWN_UPGRADE_WEAPON";
		}
		else
		{
			return &"CP_TOWN_UPGRADE_WEAPON";
		}

		return &"CP_TOWN_UPGRADE_WEAPON_FAIL";
	}

	if(var_03 == level.var_C8A4)
	{
		return &"COOP_INTERACTIONS_UPGRADE_MAXED";
	}
	else if(param_01 scripts\cp\_utility::func_9C42(var_02,1))
	{
		return "";
	}
	else if(!func_385F(var_02))
	{
		return &"CP_TOWN_UPGRADE_WEAPON_FAIL";
	}
	else if(var_03 == 1)
	{
		return &"CP_TOWN_UPGRADE_WEAPON";
	}
	else
	{
		return &"CP_TOWN_UPGRADE_WEAPON";
	}

	return &"CP_TOWN_UPGRADE_WEAPON_FAIL";
}

//Function Number: 27
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

	if(scripts\common\utility::istrue(level.placed_alien_fuses))
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