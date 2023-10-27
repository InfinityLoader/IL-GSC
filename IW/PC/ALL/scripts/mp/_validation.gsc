/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_validation.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 809 ms
 * Timestamp: 10/27/2023 12:22:14 AM
*******************************************************************/

//Function Number: 1
func_1314D(param_00,param_01,param_02)
{
	var_03 = param_00;
	if(isdefined(param_01))
	{
		var_03 = var_03 + "_" + param_01;
	}

	if(isdefined(param_02))
	{
		var_03 = var_03 + " - " + param_02;
	}

	if(getdvarint("scr_validate_print",0) == 1)
	{
	}

	if(getdvarint("scr_validate_assert",0) == 1)
	{
	}

	if(getdvarint("scr_validate_record",0) == 1)
	{
		scripts\mp\_class::func_DDF5();
	}
}

//Function Number: 2
func_13140(param_00)
{
	var_01 = spawnstruct();
	var_01.var_D640 = 0;
	var_01.var_13D1E = [];
	var_01.var_9B0F = [];
	var_01.var_9B0F[2] = [];
	var_01.var_9B0F[5] = [];
	var_01.var_9B0F[9] = [];
	func_1314B(var_01,param_00.var_AE7F,param_00.var_AE86,param_00.var_AE88,param_00.var_AE90,param_00.var_AE8A,param_00.var_AE91,0);
	func_1314B(var_01,param_00.var_AE94,param_00.var_AE9A,param_00.var_AE9C,param_00.var_AEA4,param_00.var_AE9E,param_00.var_AEA5,1);
	func_13146(var_01,param_00.var_AE7B,"primary",param_00.var_AE69);
	func_13146(var_01,param_00.var_AE7D,"secondary",param_00.var_AE6A);
	func_13145(var_01,param_00.var_AE79,param_00.var_AE62);
	func_13147(var_01,param_00.var_AE6E,param_00.var_AE70,param_00.var_AE72);
	func_13148(var_01,param_00.var_AEAA,param_00.var_AE62);
	func_1313A(var_01,param_00.var_AE62);
	if(var_01.var_D640 > 10)
	{
		func_1314D("totalPointCost");
		var_01.var_9B0F[0] = 1;
	}

	func_1314C(var_01);
	param_00 = func_6E06(param_00,var_01.var_9B0F);
	return param_00;
}

//Function Number: 3
func_1314B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = scripts\mp\_utility::func_8234(param_01);
	var_09 = scripts\mp\_utility::func_9D79(param_01);
	var_0A = scripts\common\utility::func_116D7(param_07,"secondary","primary");
	var_0B = scripts\common\utility::func_116D7(param_07,4,1);
	if(isdefined(param_01) && param_01 != "none" && param_01 != "iw7_fists")
	{
		param_00.var_D640++;
		if(param_07)
		{
			if(!var_09)
			{
				param_00.var_D640++;
				param_00.var_13D1E["overkill"] = 1;
			}
		}
		else if(var_09)
		{
			func_1314D("secondaryAsPrimary",undefined,param_01);
			param_00.var_9B0F[var_0B] = 1;
		}

		var_0C = scripts\mp\_utility::func_13CAC(var_08);
		if(!isdefined(var_0C))
		{
			func_1314D("unknownWeapon",var_0A,param_01);
			param_00.var_9B0F[var_0B] = 1;
		}
		else
		{
			var_0D = tablelookup("mp/statstable.csv",0,var_0C,41);
			if(int(var_0D) < 0)
			{
				func_1314D("unreleasedWeapon",var_0A,param_01);
				param_00.var_9B0F[var_0B] = 1;
			}
		}

		if(!self isitemunlocked(var_08,"weapon") && !weaponunlocksvialoot(var_08))
		{
			func_1314D("lockedWeapon",var_0A,param_01);
			param_00.var_9B0F[var_0B] = 1;
		}

		if(param_05 == 0)
		{
			if(param_06 != -1)
			{
				func_1314D("emptyItemIDMismatch",var_0A,param_01);
				param_00.var_9B0F[var_0B] = 1;
			}
		}
		else if(param_06 == -1)
		{
			func_1314D("emptyVariantIDMismatch",var_0A,param_01);
			param_00.var_9B0F[var_0B] = 1;
		}
		else
		{
			if(!scripts\mp\_loot::func_A001(param_05))
			{
				func_1314D("nonWeaponLootItemID",var_0A,param_01);
				param_00.var_9B0F[var_0B] = 1;
			}

			var_0E = scripts\mp\_loot::getlootweaponref(param_05);
			if(!isdefined(var_0E))
			{
				func_1314D("badLootItemID",var_0A,param_01);
				param_00.var_9B0F[var_0B] = 1;
			}
			else
			{
				var_0F = scripts\mp\_loot::lookupvariantref(param_01,param_06);
				if(!isdefined(var_0F))
				{
					func_1314D("badVariantRef",var_0A,param_01);
					param_00.var_9B0F[var_0B] = 1;
				}
				else if(var_0F != var_0E)
				{
					func_1314D("lootDataMismatch",var_0A,param_01);
					param_00.var_9B0F[var_0B] = 1;
				}
			}
		}

		func_1313B(param_00,param_02,param_01,var_08,var_0A);
	}
}

//Function Number: 4
func_1313B(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\mp\_utility::func_13C8F(param_02);
	var_06 = getsubstr(var_05,7) + "Attach";
	var_07 = scripts\common\utility::func_116D7(param_04 == "primary",2,5);
	var_08 = 0;
	var_09 = 0;
	var_0A = scripts\common\utility::func_116D7(param_04 == "primary",2,2);
	foreach(var_11, var_0C in param_01)
	{
		var_0D = 0;
		if(isdefined(var_0C) && var_0C != "none")
		{
			var_0E = scripts\mp\_utility::getattachmenttype(var_0C);
			if(isdefined(var_0E) && var_0E != "")
			{
				var_0F = scripts\mp\_utility::func_2496(var_0C,param_02);
				if(isdefined(var_0F))
				{
					if(var_0E == "rail")
					{
						var_0D = 1;
					}
				}
			}

			var_10 = param_03 + "+" + var_0C;
			if(!self isitemunlocked(var_10,var_06))
			{
				func_1314D("lockedAttachment",param_04,var_0C);
				param_00.var_9B0F[var_07][param_00.var_9B0F[var_07].size] = var_11;
			}

			if(!scripts\mp\_weapons::func_9F3C(param_03,var_0C))
			{
				func_1314D("nonSelectableAttachment",param_04,var_0C);
				param_00.var_9B0F[var_07][param_00.var_9B0F[var_07].size] = var_11;
			}

			if(var_0D)
			{
				var_08++;
				param_00.var_D640++;
			}
			else
			{
				var_09++;
				if(var_09 <= var_0A)
				{
					param_00.var_D640++;
				}
				else
				{
					param_00.var_13D1E[param_04 + "_attachment_" + var_09 + 1] = 1;
					param_00.var_D640 = param_00.var_D640 + 2;
				}
			}
		}
	}

	if(var_09 > 5)
	{
		func_1314D("tooManyAttachments",param_04,var_09);
		param_00.var_9B0F[scripts\common\utility::func_116D7(param_04 == "primary",3,6)] = 1;
	}

	if(var_08 > 1)
	{
		func_1314D("tooManyOpticAttachments",param_04,var_08);
		param_00.var_9B0F[scripts\common\utility::func_116D7(param_04 == "primary",3,6)] = 1;
	}
}

//Function Number: 5
func_13146(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\common\utility::func_116D7(param_02 == "primary",7,8);
	if(isdefined(param_01) && param_01 != "none")
	{
		if(!isdefined(level.var_D782[param_01]))
		{
			func_1314D("unknownPower",param_02,param_01);
			param_00.var_9B0F[var_04] = 1;
		}

		if(!self isitemunlocked(param_01,"power"))
		{
			func_1314D("lockedPower",param_02,param_01);
			param_00.var_9B0F[var_04] = 1;
		}

		var_05 = func_B02F(param_01);
		if(!isdefined(var_05))
		{
			func_1314D("unknownMenuPower",param_02,param_01);
			param_00.var_9B0F[var_04] = 1;
		}
		else if(var_05 != param_02)
		{
			func_1314D("powerInWrongSlot",param_02,param_01);
			param_00.var_9B0F[var_04] = 1;
		}

		param_00.var_D640++;
	}

	if(scripts\mp\_utility::func_9FB3(param_03))
	{
		param_00.var_D640 = param_00.var_D640 + 2;
		var_06 = scripts\common\utility::func_116D7(param_02 == "primary","extra_lethal","extra_tactical");
		param_00.var_13D1E[var_06] = 1;
	}
}

//Function Number: 6
func_13145(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[1] = 0;
	var_03[2] = 0;
	var_03[3] = 0;
	foreach(var_05 in param_01)
	{
		if(isdefined(var_05) && var_05 != "none")
		{
			if(!isdefined(level.var_CA63[var_05]))
			{
				func_1314D("invalidPerk",undefined,var_05);
				param_00.var_9B0F[9][param_00.var_9B0F[9].size] = var_05;
			}

			var_06 = scripts\mp\perks\_perks::func_805C(var_05);
			if(isdefined(var_06))
			{
				var_03[var_06]++;
				if(var_03[var_06] > 2)
				{
					func_1314D("tooManyPerks",var_06,var_05);
					param_00.var_9B0F[9][param_00.var_9B0F[9].size] = var_05;
				}

				if(!self isitemunlocked(var_05,"perk"))
				{
					func_1314D("lockedPerk",var_06,var_05);
					param_00.var_9B0F[9][param_00.var_9B0F[9].size] = var_05;
				}

				if(var_03[var_06] == 1)
				{
					param_00.var_D640++;
				}
				else
				{
					param_00.var_13D1E["extra_perk_" + var_06] = 1;
					param_00.var_D640 = param_00.var_D640 + 2;
				}
			}
			else if(isdefined(level.var_B676[var_05]))
			{
				if(level.var_B676[var_05].var_2123 != param_02)
				{
					func_1314D("rigPerkOnWrongRig",undefined,var_05);
					param_00.var_9B0F[9][param_00.var_9B0F[9].size] = var_05;
				}

				if(!self isitemunlocked(var_05,"trait"))
				{
					func_1314D("lockedRigPerk",var_06,var_05);
					param_00.var_9B0F[9][param_00.var_9B0F[9].size] = var_05;
				}
			}
			else
			{
				func_1314D("unknownPerkType",undefined,var_05);
				param_00.var_9B0F[9][param_00.var_9B0F[9].size] = var_05;
			}
		}
	}
}

//Function Number: 7
func_13147(param_00,param_01,param_02,param_03)
{
	var_04 = [param_01,param_02,param_03];
	foreach(var_06 in var_04)
	{
		if(var_06 == "none")
		{
			continue;
		}

		var_07 = scripts\mp\killstreaks\_killstreaks::func_7F50(var_06);
		if(!isdefined(var_07))
		{
			func_1314D("unknownStreak",undefined,var_06);
			param_00.var_9B0F[12] = 1;
		}

		if(!self isitemunlocked(var_06,"killstreak"))
		{
			func_1314D("lockedStreak",undefined,var_06);
			param_00.var_9B0F[12] = 1;
		}
	}

	if(param_01 == param_02 && param_01 != "none")
	{
		func_1314D("duplicateStreak",undefined,param_01);
		param_00.var_9B0F[12] = 1;
		return;
	}

	if(param_01 == param_03 && param_01 != "none")
	{
		func_1314D("duplicateStreak",undefined,param_01);
		param_00.var_9B0F[12] = 1;
		return;
	}

	if(param_02 == param_03 && param_02 != "none")
	{
		func_1314D("duplicateStreak",undefined,param_02);
		param_00.var_9B0F[12] = 1;
		return;
	}
}

//Function Number: 8
func_1313A(param_00,param_01)
{
	if(!isdefined(level.var_2127[param_01]))
	{
		func_1314D("unknownArchetype",undefined,param_01);
		param_00.var_9B0F[10] = 1;
	}

	if(!self isitemunlocked(param_01,"rig"))
	{
		func_1314D("lockedArchetype",undefined,param_01);
		param_00.var_9B0F[10] = 1;
	}
}

//Function Number: 9
func_13148(param_00,param_01,param_02)
{
	if(!isdefined(param_01) || param_01 == "none")
	{
		return;
	}

	var_03 = level.var_10E4E[param_01];
	if(!isdefined(var_03))
	{
		func_1314D("unknownSuper",undefined,param_01);
		param_00.var_9B0F[11] = 1;
	}
	else if(var_03.var_2123 != param_02)
	{
		func_1314D("superOnWrongRig",undefined,param_01);
		param_00.var_9B0F[11] = 1;
	}

	if(!self isitemunlocked(param_01,"super"))
	{
		func_1314D("lockedSuper",undefined,param_01);
		param_00.var_9B0F[11] = 1;
	}
}

//Function Number: 10
func_1314C(param_00)
{
}

//Function Number: 11
func_6E08(param_00)
{
	var_01 = scripts\mp\_class::func_AE31();
	var_01.var_AE62 = "archetype_assault";
	var_01.var_AE7F = "iw7_m4";
	return var_01;
}

//Function Number: 12
func_6E10(param_00,param_01)
{
	if(param_01 == "primary")
	{
		param_00.var_AE7F = "iw7_m4";
		param_00.var_AE88 = "none";
		param_00.var_AE90 = "none";
		param_00.var_AE8A = 0;
		param_00.var_AE91 = -1;
		for(var_02 = 0;var_02 < scripts\mp\_class::func_7F9E();var_02++)
		{
			param_00.var_AE86[var_02] = "none";
		}

		return;
	}

	param_01.var_AE94 = "none";
	param_01.var_AE9C = "none";
	param_01.var_AEA4 = "none";
	param_01.var_AE9E = 0;
	param_01.var_AEA5 = -1;
	for(var_02 = 0;var_02 < scripts\mp\_class::func_7FA0();var_02++)
	{
		param_00.var_AE9A[var_02] = "none";
	}
}

//Function Number: 13
func_6E00(param_00,param_01,param_02)
{
	if(param_01 == "primary")
	{
		param_00.var_AE86[param_02] = "none";
		return;
	}

	param_00.var_AE9A[param_02] = "none";
}

//Function Number: 14
func_6E0A(param_00,param_01)
{
	if(param_01 == "primary")
	{
		param_00.var_AE7B = "none";
		param_00.var_AE7C = [];
		param_00.var_AE67 = 0;
		return;
	}

	param_00.var_AE7D = "none";
	param_00.var_AE7E = [];
	param_00.var_AE68 = 0;
}

//Function Number: 15
func_6E09(param_00,param_01)
{
	param_00.var_AE79 = scripts\common\utility::func_22A9(param_00.var_AE79,param_01);
}

//Function Number: 16
func_6E07(param_00)
{
	param_00.var_AE6E = "none";
	param_00.var_AE6F = [];
	param_00.var_AE70 = "none";
	param_00.var_AE71 = [];
	param_00.var_AE72 = "none";
	param_00.var_AE73 = [];
}

//Function Number: 17
func_6DFF(param_00)
{
	param_00.var_AE62 = "archetype_assault";
	func_6E0B(param_00);
	foreach(var_02 in param_00.var_AE79)
	{
		if(isdefined(level.var_B676[var_02]))
		{
			func_6E09(param_00,var_02);
			break;
		}
	}
}

//Function Number: 18
func_6E0B(param_00)
{
	param_00.var_AEAA = "none";
}

//Function Number: 19
func_6E06(param_00,param_01)
{
	if(isdefined(param_01[0]))
	{
		param_00 = func_6E08(param_00);
		return param_00;
	}

	if(isdefined(param_01[1]))
	{
		func_6E10(param_00,"primary");
	}
	else if(isdefined(param_01[3]))
	{
		for(var_02 = 0;var_02 < scripts\mp\_class::func_7F9E();var_02++)
		{
			func_6E00(param_00,"primary",var_02);
		}
	}
	else
	{
		foreach(var_02 in var_02[2])
		{
			func_6E00(param_00,"primary",var_02);
		}
	}

	if(isdefined(param_01[4]))
	{
		func_6E10(param_00,"secondary");
	}
	else if(isdefined(param_01[6]))
	{
		for(var_02 = 0;var_02 < scripts\mp\_class::func_7FA0();var_02++)
		{
			func_6E00(param_00,"secondary",var_02);
		}
	}
	else
	{
		foreach(var_02 in var_02[5])
		{
			func_6E00(param_00,"secondary",var_02);
		}
	}

	if(isdefined(param_01[7]))
	{
		func_6E0A(param_00,"primary");
	}

	if(isdefined(param_01[8]))
	{
		func_6E0A(param_00,"secondary");
	}

	foreach(var_08 in param_01[9])
	{
		func_6E09(param_00,var_08);
	}

	if(isdefined(param_01[10]))
	{
		func_6DFF(param_00);
	}
	else if(isdefined(param_01[11]))
	{
		func_6DFF(param_00);
	}

	if(isdefined(param_01[12]))
	{
		func_6E07(param_00);
	}

	return param_00;
}

//Function Number: 20
func_B02F(param_00)
{
	var_01 = tablelookup("mp/menuPowers.csv",3,param_00,2);
	if(!isdefined(var_01) || var_01 != "1" && var_01 != "2")
	{
		return undefined;
	}

	return scripts\common\utility::func_116D7(var_01 == "1","primary","secondary");
}

//Function Number: 21
weaponunlocksvialoot(param_00)
{
	switch(param_00)
	{
		case "iw7_venomx":
		case "iw7_unsalmg":
		case "iw7_mp28":
		case "iw7_crdb":
		case "iw7_udm45":
		case "iw7_katana":
		case "iw7_nunchucks":
		case "iw7_mag":
		case "iw7_mod2187":
		case "iw7_ba50cal":
		case "iw7_vr":
		case "iw7_minilmg":
		case "iw7_longshot":
		case "iw7_axe":
		case "iw7_gauss":
		case "iw7_revolver":
		case "iw7_tacburst":
		case "iw7_rvn":
			return 1;
	}

	return 0;
}