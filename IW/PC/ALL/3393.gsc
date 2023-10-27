/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3393.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 12:26:55 AM
*******************************************************************/

//Function Number: 1
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

//Function Number: 2
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

//Function Number: 3
func_9A40(param_00,param_01)
{
	if(scripts\cp\_utility::is_codxp())
	{
		return;
	}

	param_01 thread func_13C62(param_00);
}

//Function Number: 4
func_13C64(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.var_13DB4))
	{
		return "";
	}

	var_02 = param_01 getcurrentweapon();
	var_03 = scripts\cp\_weapon::func_7D62(var_02);
	if(var_03 == level.var_C8A4)
	{
		return &"COOP_INTERACTIONS_UPGRADE_MAXED";
	}
	else if(param_01 scripts\cp\_utility::func_9C42(var_02,1))
	{
		return "";
	}
	else if(!scripts\cp\_weapon::func_385F(var_02))
	{
		return &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL";
	}
	else if(var_03 == 1)
	{
		return &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON";
	}
	else
	{
		return &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_GENERIC";
	}

	return &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL";
}

//Function Number: 5
func_13C62(param_00,param_01)
{
	param_01 endon("disconnect");
	var_02 = param_01 getcurrentweapon();
	var_03 = scripts\cp\_utility::func_80D8(var_02);
	var_04 = param_01 scripts\cp\_weapon::func_7D62(var_03);
	var_05 = undefined;
	var_06 = undefined;
	var_07 = "none";
	var_08 = undefined;
	var_09 = 0;
	if(var_03 == "dischord" || var_03 == "facemelter" || var_03 == "headcutter" || var_03 == "shredder")
	{
		if(!scripts\common\utility::flag("fuses_inserted") && !scripts\cp\zombies\directors_cut::directors_cut_is_activated())
		{
			return;
		}
	}

	if(var_04 < level.var_C8A4)
	{
		var_0A = scripts\common\utility::getstruct(param_00.target,"targetname");
		var_0B = vectornormalize(anglestoforward(param_01.angles)) * 16;
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		var_0C = param_01 getweaponslistprimaries();
		param_01 scripts\cp\_merits::func_D9AD("mt_upgrade_weapons");
		foreach(var_0E in var_0C)
		{
			if(!issubstr(var_02,var_0E) && !scripts\cp\_utility::isstrstart(var_0E,"alt_") && !issubstr(var_0E,"knife"))
			{
				var_05 = var_0E;
				break;
			}
		}

		var_04 = int(var_04);
		var_04++;
		var_10 = var_02;
		if(isdefined(level.pap_1_camo) && isdefined(var_04) && var_04 == 2)
		{
			var_08 = level.pap_1_camo;
		}
		else if(isdefined(level.pap_2_camo) && isdefined(var_04) && var_04 == 3)
		{
			var_08 = level.pap_2_camo;
		}

		if(isdefined(level.no_pap_camos) && scripts\common\utility::func_2286(level.no_pap_camos,var_03))
		{
			var_08 = undefined;
		}

		if(var_04 == 2)
		{
			if(isdefined(var_03))
			{
				switch(var_03)
				{
					case "dischord":
						var_02 = "iw7_dischord_zm_pap1";
						var_08 = "camo20";
						break;

					case "facemelter":
						var_02 = "iw7_facemelter_zm_pap1";
						var_08 = "camo22";
						break;

					case "headcutter":
						var_02 = "iw7_headcutter_zm_pap1";
						var_08 = "camo21";
						break;

					case "shredder":
						var_02 = "iw7_shredder_zm_pap1";
						var_08 = "camo23";
						break;

					default:
						break;
				}
			}
		}

		if(var_03 == "axe")
		{
			if(var_04 == 2)
			{
				var_02 = "iw7_axe_zm_pap1";
			}
			else if(var_04 == 3)
			{
				var_02 = "iw7_axe_zm_pap2";
			}

			var_09 = 1;
		}

		if(var_03 == "nunchucks")
		{
			if(var_04 == 2)
			{
				var_02 = "iw7_nunchucks_zm_pap1";
			}
			else if(var_04 == 3)
			{
				var_02 = "iw7_nunchucks_zm_pap2";
			}

			var_09 = 1;
		}

		if(var_03 == "katana")
		{
			if(var_04 == 2)
			{
				var_02 = "iw7_katana_zm_pap1";
			}
			else if(var_04 == 3)
			{
				var_02 = "iw7_katana_zm_pap2";
			}

			var_09 = 1;
		}

		if(var_03 == "venomx")
		{
			if(var_04 == 2)
			{
				var_02 = "iw7_venomx_zm_pap1";
			}
			else if(var_04 == 3)
			{
				var_02 = "iw7_venomx_zm_pap2";
			}

			var_09 = 1;
		}

		if(var_03 == "forgefreeze")
		{
			if(var_04 == 2)
			{
				var_02 = "iw7_forgefreeze_zm_pap1";
			}
			else if(var_04 == 3)
			{
				var_02 = "iw7_forgefreeze_zm_pap2";
			}

			var_09 = 1;
		}

		level.var_1192E++;
		scripts\cp\zombies\zombie_analytics::func_AF7F(level.wave_num,var_03,level.var_1192E);
		param_01 lib_0D2A::func_12D7C("GET_PACKED",1);
		param_01 thread scripts\cp\_vo::try_to_play_vo("weapon_pap","zmb_pap_vo","high",undefined,undefined,undefined,1);
		var_07 = return_pap_attachment(param_01,var_04,var_03,var_02);
		if(isdefined(var_07) && var_07 == "replace_me")
		{
			var_07 = undefined;
		}

		var_11 = function_00E3(var_02);
		if(issubstr(var_02,"g18_z"))
		{
			foreach(var_13 in var_11)
			{
				if(issubstr(var_13,"akimbo"))
				{
					var_11 = scripts\common\utility::func_22A9(var_11,var_13);
				}
			}
		}

		var_15 = var_11;
		foreach(var_13 in var_15)
		{
			if(issubstr(var_13,"silencer") || issubstr(var_13,"arcane") || issubstr(var_13,"ark"))
			{
				var_15 = scripts\common\utility::func_22A9(var_15,var_13);
			}
		}

		var_02 = param_01 scripts\cp\_weapon::func_E469(var_02,undefined,var_15);
		var_18 = param_01 scripts\cp\_weapon::func_E469(var_02,var_07,var_15,undefined,var_08);
		var_19 = param_01 scripts\cp\_weapon::func_E469(var_02,var_07,var_11,undefined,var_08);
		if(var_09)
		{
			var_1A = spawn("script_weapon",param_01 geteye() + var_0B,0,0,var_10);
		}
		else
		{
			var_1A = spawn("script_weapon",var_02 geteye() + var_0C,0,0,var_03);
		}

		var_1A.angles = param_00.angles;
		var_1B = func_801F(var_19);
		var_1C = getent("pap_machine","targetname");
		level thread func_DF48(param_01,var_1A,param_00,var_1C);
		level notify("pap_used",param_01,var_04,var_19);
		var_1A makeunusable();
		param_01 thread playpapgesture(param_01,param_01.pap_gesture,var_05,var_02,var_10);
		param_01.var_C8AB = var_02;
		var_1D = func_8087(var_03);
		var_1A moveto(var_0A.origin + var_1D,0.75);
		var_1A rotateto(var_0A.angles,0.75);
		var_1A waittill("movedone");
		var_1A moveto(var_0A.origin + var_1B,0.25);
		var_1A waittill("movedone");
		var_1C playsound("zmb_packapunch_machine_on");
		var_1C setscriptablepartstate("door","close");
		wait(0.75);
		if(!scripts\common\utility::flag("fuses_inserted"))
		{
			var_1C setscriptablepartstate("papfx","normal");
		}
		else
		{
			var_1C setscriptablepartstate("papfx","upgraded");
		}

		wait(3.5);
		var_1C setscriptablepartstate("door","decomp");
		wait(0.8);
		var_1A method_8536(var_18);
		wait(0.4);
		var_1C setscriptablepartstate("door","open_idle");
		var_1C setscriptablepartstate("papfx","idle");
		wait(0.5);
		var_1A makeusable();
		var_1A method_84A2(100);
		foreach(var_1F in level.players)
		{
			if(var_1F == param_01)
			{
				var_1A enableplayeruse(var_1F);
				continue;
			}

			var_1A disableplayeruse(var_1F);
		}

		if(var_03 == "dischord" || var_03 == "facemelter" || var_03 == "headcutter" || var_03 == "shredder")
		{
			param_01 thread scripts\cp\_vo::try_to_play_vo("pap_wor","zmb_pap_vo","high",undefined,undefined,undefined,1);
		}

		var_1A thread func_1360B(var_19,var_06,var_04);
		var_1A scripts\common\utility::waittill_any_timeout_1(30,"weapon_taken");
		param_01 notify("weapon_purchased");
		param_01.var_C8AB = undefined;
		var_1A delete();
		level thread scripts\cp\_vo::func_E01F("dj_quest_ufo_pap1_nag");
		param_01 scripts\cp\_interaction::func_DE6E();
		wait(1);
		scripts\cp\_interaction::add_to_current_interaction_list(param_00);
		level notify("pap_machine_activated");
	}
}

//Function Number: 6
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
			case "katana":
			case "nunchucks":
			case "venomx":
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

//Function Number: 7
playpapgesture(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "iw7_fists_zm";
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
func_7E25()
{
	if(isdefined(self.pap_gesture_anim))
	{
		return self method_8443(self.pap_gesture_anim);
	}

	return 3;
}

//Function Number: 9
func_8087(param_00)
{
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "forgefreeze":
				return (-32,0,24);

			default:
				return (-32,0,16);
		}

		return;
	}

	return (-32,0,16);
}

//Function Number: 10
func_DF48(param_00,param_01,param_02,param_03)
{
	level endon("pap_machine_activated");
	param_00 waittill("disconnect");
	param_03 setscriptablepartstate("door","decomp");
	wait(1.2);
	param_03 setscriptablepartstate("door","open_idle");
	param_03 setscriptablepartstate("papfx","idle");
	param_01 delete();
	wait(1);
	scripts\cp\_interaction::add_to_current_interaction_list(param_02);
	level notify("pap_machine_activated");
}

//Function Number: 11
func_801F(param_00)
{
	var_01 = scripts\cp\_utility::func_7DF7(param_00);
	switch(var_01)
	{
		case "iw7_devastator":
		case "iw7_erad":
		case "iw7_ar57":
			return (0,-4,3);

		case "iw7_sdflmg":
			return (0,2,3);

		case "iw7_fmg":
		case "iw7_glprox":
			return (0,-4,2);

		case "iw7_m4":
		case "iw7_lmg03":
		case "iw7_sonic":
			return (0,-2,2);

		case "iw7_m8":
		case "iw7_lockon":
			return (0,2,2);

		case "iw7_fhr":
			return (0,-6,3);

		case "iw7_sdfar":
			return (0,-1,3);

		case "iw7_ripper":
			return (0,-7,3);

		case "iw7_chargeshot":
			return (0,-4,4);

		case "iw7_axe":
			return (0,4,0);

		case "iw7_m1":
			return (0,4,0);

		case "iw7_kbs":
			return (0,4,2);

		case "iw7_cheytac":
			return (0,8,2);

		case "iw7_mauler":
		case "iw7_g18":
		case "iw7_ake":
			return (0,0,2);

		case "iw7_crb":
			return (0,-7,3);

		case "iw7_shredder":
		case "iw7_headcutter":
		case "iw7_facemelter":
		case "iw7_dischord":
		case "iw7_nrg":
		case "iw7_emc":
			return (0,0,0);

		case "iw7_forgefreeze":
			return (0,0,16);

		case "iw7_revolver":
		case "iw7_spas":
			return (0,3,1);

		case "iw7_sdfshotty":
			return (0,1,4);

		case "iw7_ump45":
			return (0,-6,2);

		default:
			return (0,0,0);
	}
}

//Function Number: 12
func_1360B(param_00,param_01,param_02)
{
	self endon("death");
	self waittill("trigger",var_03);
	param_01 = "iw7_fists_zm";
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

	if(func_FFA6(var_03))
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

//Function Number: 13
func_FFA6(param_00)
{
	var_01 = 3;
	if(param_00 scripts\cp\_utility::has_zombie_perk("perk_machine_more"))
	{
		var_01 = 4;
	}

	var_02 = param_00 getweaponslistprimaries("primary");
	foreach(var_04 in var_02)
	{
		if(scripts\cp\_utility::isstrstart(var_04,"alt_"))
		{
			var_02 = scripts\common\utility::func_22A9(var_02,var_04);
		}
	}

	return var_02.size >= var_01;
}

//Function Number: 14
canupgradefunctionreroute(param_00,param_01)
{
	if(isdefined(level.max_pap_func))
	{
		return self [[ level.max_pap_func ]](param_00,param_01);
	}

	return scripts\cp\_weapon::func_385F(param_00,param_01);
}

//Function Number: 15
func_12F73()
{
	foreach(var_01 in level.players)
	{
		var_02 = var_01 getweaponslistall();
		var_03 = 1;
		var_04 = [];
		var_05 = scripts\cp\_utility::func_80D8(var_01 scripts\cp\_utility::getvalidtakeweapon());
		foreach(var_07 in var_02)
		{
			var_08 = scripts\cp\_utility::func_80D8(var_07);
			if(!scripts\common\utility::istrue(var_04[var_08]))
			{
				var_04[var_08] = 1;
				if(isdefined(var_01.var_C8A2[var_08]))
				{
					if(var_01 canupgradefunctionreroute(var_07))
					{
						var_09 = func_12F72(var_01,var_07);
						if(var_08 == var_05 && !scripts\common\utility::istrue(var_01.kung_fu_mode))
						{
							var_01 method_83B6(var_09);
						}
					}
				}
			}
		}
	}
}

//Function Number: 16
func_12F72(param_00,param_01,param_02)
{
	var_03 = scripts\cp\_utility::func_80D8(param_01);
	var_04 = undefined;
	if(isdefined(param_00.var_C8A2[var_03]))
	{
		if(param_00 canupgradefunctionreroute(param_01,param_02))
		{
			var_05 = param_00 scripts\cp\_weapon::func_7D62(var_03);
			var_05 = int(var_05);
			var_05++;
			if(isdefined(level.no_pap_camos) && scripts\common\utility::func_2286(level.no_pap_camos,var_03))
			{
				var_04 = undefined;
			}
			else if(isdefined(level.pap_1_camo) && isdefined(var_05) && var_05 == 2)
			{
				var_04 = level.pap_1_camo;
			}
			else if(isdefined(level.pap_2_camo) && isdefined(var_05) && var_05 == 3)
			{
				var_04 = level.pap_2_camo;
			}

			switch(var_03)
			{
				case "dischord":
					var_06 = "iw7_dischord_zm_pap1";
					var_04 = "camo20";
					break;

				case "facemelter":
					var_06 = "iw7_facemelter_zm_pap1";
					var_04 = "camo22";
					break;

				case "headcutter":
					var_06 = "iw7_headcutter_zm_pap1";
					var_04 = "camo21";
					break;

				case "katana":
				case "nunchucks":
					var_04 = "camo222";
					break;

				case "shredder":
					var_06 = "iw7_shredder_zm_pap1";
					var_04 = "camo23";
					break;

				case "venomx":
					if(var_05 == 2)
					{
						var_06 = "iw7_venomx_zm_pap1";
						var_04 = "camo32";
						break;
					}
					else if(var_05 == 3)
					{
						var_06 = "iw7_venomx_zm_pap2";
						var_04 = "camo34";
						break;
					}
	
					break;
			}

			if(var_03 == "axe")
			{
				if(var_05 == 2)
				{
					var_06 = "iw7_axe_zm_pap1";
				}
				else if(var_05 == 3)
				{
					var_06 = "iw7_axe_zm_pap2";
				}
			}

			if(var_03 == "nunchucks")
			{
				if(var_05 == 2)
				{
					var_06 = "iw7_nunchucks_zm_pap1";
				}
				else if(var_05 == 3)
				{
					var_06 = "iw7_nunchucks_zm_pap2";
				}
			}

			if(var_03 == "katana")
			{
				if(var_05 == 2)
				{
					var_06 = "iw7_katana_zm_pap1";
				}
				else if(var_05 == 3)
				{
					var_06 = "iw7_katana_zm_pap2";
				}
			}

			if(var_03 == "forgefreeze")
			{
				if(var_05 == 2)
				{
					var_06 = "iw7_forgefreeze_zm_pap1";
				}
				else if(var_05 == 3)
				{
					var_06 = "iw7_forgefreeze_zm_pap2";
				}
			}

			if(var_03 == "venomx")
			{
				if(var_05 == 2)
				{
					var_06 = "iw7_venomx_zm_pap1";
				}
				else if(var_05 == 3)
				{
					var_06 = "iw7_venomx_zm_pap2";
				}
			}

			param_00 takeweapon(param_01);
			param_01 = validate_current_weapon(var_05,var_03,param_01);
			var_07 = return_pap_attachment(param_00,var_05,var_03,param_01);
			if(isdefined(var_07) && var_07 == "replace_me")
			{
				var_07 = undefined;
			}

			var_08 = function_00E3(param_01);
			if(issubstr(param_01,"g18_z"))
			{
				foreach(var_0A in var_08)
				{
					if(issubstr(var_0A,"akimbo"))
					{
						var_08 = scripts\common\utility::func_22A9(var_08,var_0A);
					}
				}
			}

			var_0C = param_00 scripts\cp\_weapon::func_E469(param_01,var_07,var_08,undefined,var_04);
			var_0C = param_00 scripts\cp\_utility::func_12C6(var_0C,undefined,undefined,1);
			param_00.var_C8A2[var_03].var_B111++;
			param_00 notify("weapon_level_changed");
			param_00 givemaxammo(var_0C);
			return var_0C;
		}
	}

	return undefined;
}

//Function Number: 17
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

			case "venomx":
				if(param_00 == 2)
				{
					param_02 = "iw7_venomx_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_venomx_zm_pap2";
				}

				break;

			default:
				return param_02;
		}
	}

	return param_02;
}

//Function Number: 18
func_9CCD(param_00)
{
	if(param_00 == "iw7_zm1coaster_zm" || param_00 == "iw7_cpbasketball_mp" || param_00 == "iw7_shootgallery_zm_blue" || param_00 == "iw7_shootgallery_zm_red" || param_00 == "iw7_shootgallery_zm_yellow" || param_00 == "iw7_shootgallery_zm_green")
	{
		return 1;
	}

	return 0;
}