/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots_loadout.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 1927 ms
 * Timestamp: 10/27/2023 12:27:39 AM
*******************************************************************/

//Function Number: 1
init()
{
	func_9779();
	func_9579();
	func_96D0();
	func_955A();
	func_9555();
	func_9556();
	func_9554();
	level.var_2E14 = 1;
}

//Function Number: 2
func_9579()
{
	var_00 = "mp/botClassTable.csv";
	level.var_2EE7 = [];
	var_01 = func_2E07();
	var_02 = 0;
	for(;;)
	{
		var_02++;
		var_03 = tablelookup(var_00,0,"botArchetype",var_02);
		var_04 = tablelookup(var_00,0,"botPersonalities",var_02);
		var_05 = tablelookup(var_00,0,"botDifficulties",var_02);
		if(!isdefined(var_03) || var_03 == "")
		{
			break;
		}

		if(!isdefined(var_04) || var_04 == "")
		{
			break;
		}

		if(!isdefined(var_05) || var_05 == "")
		{
			break;
		}

		var_06 = [];
		foreach(var_08 in var_01)
		{
			var_06[var_08] = tablelookup(var_00,0,var_08,var_02);
		}

		var_0A = strtok(var_03,"|");
		var_0B = strtok(var_04,"| ");
		var_0C = strtok(var_05,"| ");
		foreach(var_0E in var_0A)
		{
			var_0E = "archetype_" + var_0E;
			var_06["loadoutArchetype"] = var_0E;
			foreach(var_10 in var_0B)
			{
				foreach(var_12 in var_0C)
				{
					var_13 = func_2E0E(var_0E,var_10,var_12,1);
					var_14 = spawnstruct();
					var_14.var_AEAC = var_06;
					var_13.var_AE93[var_13.var_AE93.size] = var_14;
				}
			}
		}
	}
}

//Function Number: 3
func_9779()
{
	var_00 = "mp/botTemplateTable.csv";
	level.var_2EE8 = [];
	var_01 = func_2E07();
	var_02 = 0;
	for(;;)
	{
		var_02++;
		var_03 = tablelookup(var_00,0,"template_",var_02);
		if(!isdefined(var_03) || var_03 == "")
		{
			break;
		}

		var_04 = "template_" + var_03;
		level.var_2EE8[var_04] = [];
		foreach(var_06 in var_01)
		{
			var_07 = tablelookup(var_00,0,var_06,var_02);
			if(isdefined(var_07) && var_07 != "")
			{
				level.var_2EE8[var_04][var_06] = var_07;
			}
		}
	}
}

//Function Number: 4
func_9554()
{
	level.var_2ED9 = [];
	level.var_2ED9["cqb"] = ["archetype_assault","archetype_scout","archetype_assassin","archetype_heavy","archetype_engineer"];
	level.var_2ED9["run_and_gun"] = ["archetype_assault","archetype_scout","archetype_heavy","archetype_engineer"];
	level.var_2ED9["camper"] = ["archetype_assassin","archetype_heavy","archetype_sniper"];
	level.var_2ED9["default"] = ["archetype_assault"];
}

//Function Number: 5
func_2E0A(param_00,param_01,param_02)
{
	if(!function_011C())
	{
		return 1;
	}

	if(!getmatchrulesdata("commonOption","allowCustomClasses"))
	{
		return 1;
	}

	if(param_01 == "specialty_null")
	{
		return 1;
	}

	if(param_01 == "none")
	{
		return 1;
	}

	if(param_00 == "equipment")
	{
		if(getmatchrulesdata("commonOption","perkRestricted",param_01))
		{
			return 0;
		}

		param_00 = "weapon";
	}

	var_03 = param_00 + "Restricted";
	var_04 = param_00 + "ClassRestricted";
	var_05 = "";
	switch(param_00)
	{
		case "weapon":
			var_05 = scripts\mp\_utility::func_8225(param_01);
			break;

		case "attachment":
			var_05 = scripts\mp\_utility::getattachmenttype(param_01);
			break;

		case "killstreak":
			var_05 = param_02;
			break;

		case "perk":
			var_05 = "ability_" + level.var_2E41[param_01];
			break;

		default:
			return 0;
	}

	if(getmatchrulesdata("commonOption",var_03,param_01))
	{
		return 0;
	}

	if(getmatchrulesdata("commonOption",var_04,var_05))
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
func_2DFD(param_00)
{
	var_01 = "none";
	var_02 = ["veteran","hardened","regular","recruit"];
	var_02 = scripts\common\utility::array_randomize(var_02);
	foreach(var_04 in var_02)
	{
		var_01 = func_2E03("weap_statstable",param_00,"loadoutPrimary",self.var_2ED8,self.var_CA79,var_04);
		if(var_01 != "none")
		{
			return var_01;
		}
	}

	if(isdefined(level.var_2E45))
	{
		var_06 = scripts\common\utility::array_randomize(level.var_2E45);
		foreach(var_08 in var_06)
		{
			foreach(var_04 in var_02)
			{
				var_01 = func_2E03("weap_statstable",param_00,"loadoutPrimary",param_00["loadoutArchetype"],var_08,var_04);
				if(var_01 != "none")
				{
					self.var_2D6F = var_08;
					return var_01;
				}
			}
		}
	}

	if(function_011C())
	{
		for(var_0C = 0;var_0C < 6 && !isdefined(var_01) || var_01 == "none" || var_01 == "";var_0C++)
		{
			if(scripts\mp\_utility::func_7F91("defaultClasses",self.team,var_0C,"class","inUse"))
			{
				var_01 = scripts\mp\_utility::func_7F91("defaultClasses",self.team,var_0C,"class","weaponSetups",0,"weapon");
				if(var_01 != "none")
				{
					self.var_2D6F = "weapon";
					return var_01;
				}
			}
		}
	}

	self.var_2D6F = "weapon";
	return level.var_2D70;
}

//Function Number: 7
func_2E48(param_00)
{
	if(isdefined(param_00))
	{
		var_01 = level.var_2ED5[param_00];
		if(isdefined(var_01))
		{
			var_02 = strtok(var_01,"| ");
			if(var_02.size > 0)
			{
				scripts\mp\bots\_bots_util::func_2E83(scripts\common\utility::random(var_02));
				return;
			}
		}
	}
}

//Function Number: 8
func_2E07()
{
	var_00 = [];
	var_00[var_00.size] = "loadoutPrimary";
	var_00[var_00.size] = "loadoutPrimaryAttachment";
	var_00[var_00.size] = "loadoutPrimaryAttachment2";
	var_00[var_00.size] = "loadoutPrimaryCamo";
	var_00[var_00.size] = "loadoutPrimaryReticle";
	var_00[var_00.size] = "loadoutSecondary";
	var_00[var_00.size] = "loadoutSecondaryAttachment";
	var_00[var_00.size] = "loadoutSecondaryAttachment2";
	var_00[var_00.size] = "loadoutSecondaryCamo";
	var_00[var_00.size] = "loadoutSecondaryReticle";
	var_00[var_00.size] = "loadoutStreakType";
	var_00[var_00.size] = "loadoutStreak1";
	var_00[var_00.size] = "loadoutStreak2";
	var_00[var_00.size] = "loadoutStreak3";
	var_00[var_00.size] = "loadoutPowerPrimary";
	var_00[var_00.size] = "loadoutPowerSecondary";
	var_00[var_00.size] = "loadoutPerk1";
	var_00[var_00.size] = "loadoutPerk2";
	var_00[var_00.size] = "loadoutPerk3";
	return var_00;
}

//Function Number: 9
func_2E0E(param_00,param_01,param_02,param_03)
{
	var_04 = func_2E0B(param_00,param_01,param_02);
	if(!isdefined(level.var_2EE7))
	{
		level.var_2EE7 = [];
	}

	if(!isdefined(level.var_2EE7[var_04]) && param_03)
	{
		level.var_2EE7[var_04] = spawnstruct();
		level.var_2EE7[var_04].var_AE93 = [];
	}

	if(isdefined(level.var_2EE7[var_04]))
	{
		return level.var_2EE7[var_04];
	}
}

//Function Number: 10
func_2E0D(param_00,param_01,param_02)
{
	var_03 = func_2E0E(param_00,param_01,param_02,0);
	if(isdefined(var_03) && isdefined(var_03.var_AE93) && var_03.var_AE93.size > 0)
	{
		var_04 = randomint(var_03.var_AE93.size);
		return var_03.var_AE93[var_04].var_AEAC;
	}
}

//Function Number: 11
func_2EC2(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_utility::func_8217(param_00);
	if(isdefined(param_01) && param_01 != "none" && !func_2E0A("attachment",param_01))
	{
		return 0;
	}

	if(isdefined(param_02) && param_02 != "none" && !func_2E0A("attachment",param_02))
	{
		return 0;
	}

	if(isdefined(param_03) && param_03 != "none" && !func_2E0A("attachment",param_03))
	{
		return 0;
	}

	if(param_01 != "none" && !scripts\common\utility::func_2286(var_04,param_01))
	{
		return 0;
	}

	if(param_02 != "none" && !scripts\common\utility::func_2286(var_04,param_02))
	{
		return 0;
	}

	if(isdefined(param_03) && param_03 != "none" && !scripts\common\utility::func_2286(var_04,param_03))
	{
		return 0;
	}

	if((param_01 == "none" || param_02 == "none") && !isdefined(param_03) || param_03 == "none")
	{
		return 1;
	}

	if(!isdefined(level.var_2DD2))
	{
		level.var_2DD2 = [];
		level.var_1C77 = [];
		var_05 = "mp/attachmentcombos.csv";
		var_06 = 0;
		for(;;)
		{
			var_06++;
			var_07 = tablelookupbyrow(var_05,0,var_06);
			if(var_07 == "")
			{
				break;
			}

			var_08 = 0;
			for(;;)
			{
				var_08++;
				var_09 = tablelookupbyrow(var_05,var_08,0);
				if(var_09 == "")
				{
					break;
				}

				if(var_09 == var_07)
				{
					if(tablelookupbyrow(var_05,var_08,var_06) != "no")
					{
						level.var_1C77[var_09] = 1;
					}

					continue;
				}

				if(tablelookupbyrow(var_05,var_08,var_06) == "no")
				{
					level.var_2DD2[var_07][var_09] = 1;
				}
			}
		}
	}

	if(param_01 == param_02 && !isdefined(level.var_1C77[param_01]))
	{
		return 0;
	}

	if(isdefined(param_03))
	{
		if(param_02 == param_03 && !isdefined(level.var_1C77[param_02]))
		{
			return 0;
		}

		if(param_01 == param_03 && !isdefined(level.var_1C77[param_01]))
		{
			return 0;
		}

		if(param_03 != "none" && param_01 == param_03 && param_02 == param_03)
		{
			return 0;
		}

		if(isdefined(level.var_2DD2[param_02]) && isdefined(level.var_2DD2[param_02][param_03]))
		{
			return 0;
		}

		if(isdefined(level.var_2DD2[param_01]) && isdefined(level.var_2DD2[param_01][param_03]))
		{
			return 0;
		}
	}

	return !isdefined(level.var_2DD2[param_01]) && isdefined(level.var_2DD2[param_01][param_02]);
}

//Function Number: 12
func_2EC1(param_00,param_01,param_02)
{
	if(isdefined(param_01[param_00 + "Attachment"]) && isdefined(level.var_2D0D[param_01[param_00 + "Attachment"]]))
	{
		return 1;
	}

	if(isdefined(param_01[param_00 + "Attachment2"]) && isdefined(level.var_2D0D[param_01[param_00 + "Attachment2"]]))
	{
		return 1;
	}

	if(isdefined(param_01[param_00 + "Attachment3"]) && isdefined(level.var_2D0D[param_01[param_00 + "Attachment3"]]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
func_2E3E(param_00)
{
	return level.var_CA65[param_00];
}

//Function Number: 14
func_CA64(param_00,param_01)
{
	if(func_2E3E(param_00) > 0)
	{
		var_02 = [];
		var_02["type"] = param_01;
		var_02["name"] = param_00;
		level.var_2E3F[level.var_2E3F.size] = var_02;
		level.var_2E41[param_00] = param_01;
	}
}

//Function Number: 15
func_96D0()
{
	level.var_CA65 = [];
	var_00 = 1;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/perktable.csv",var_00,1);
		if(var_01 == "")
		{
			break;
		}

		level.var_CA65[var_01] = int(tablelookupbyrow("mp/perktable.csv",var_00,10));
		var_00++;
	}

	level.var_CA65["none"] = 0;
	level.var_CA65["specialty_null"] = 0;
	level.var_2E3F = [];
	level.var_2E41 = [];
	var_00 = 1;
	var_02 = "ability_null";
	while(isdefined(var_02) && var_02 != "")
	{
		var_02 = getsubstr(var_02,8);
		for(var_03 = 4;var_03 <= 13;var_03++)
		{
			var_01 = tablelookupbyrow("mp/cacabilitytable.csv",var_00,var_03);
			if(var_01 != "")
			{
				func_CA64(var_01,var_02);
			}
		}

		var_00++;
		var_02 = tablelookupbyrow("mp/cacabilitytable.csv",var_00,1);
	}
}

//Function Number: 16
func_955A()
{
	var_00 = "mp/statstable.csv";
	var_01 = 4;
	var_02 = 38;
	var_03 = 39;
	var_04 = 40;
	level.var_2ED6 = [];
	level.var_2ED5 = [];
	var_05 = 1;
	for(;;)
	{
		var_06 = tablelookupbyrow(var_00,var_05,var_01);
		if(var_06 == "specialty_null")
		{
			break;
		}

		var_07 = tablelookupbyrow(var_00,var_05,var_02);
		var_08 = tablelookupbyrow(var_00,var_05,var_04);
		var_09 = tablelookupbyrow(var_00,var_05,var_03);
		if(var_06 != "" && var_09 != "")
		{
			level.var_2ED5[var_06] = var_09;
		}

		if(var_08 != "" && var_06 != "" && var_09 != "" && var_07 != "")
		{
			var_0A = "loadoutPrimary";
			if(scripts\mp\_utility::func_9D79(var_06))
			{
				var_0A = "loadoutSecondary";
			}
			else if(!scripts\mp\_utility::func_9D78(var_06))
			{
				var_05++;
				continue;
			}

			if(!isdefined(level.var_2ED6[var_0A]))
			{
				level.var_2ED6[var_0A] = [];
			}

			var_0B = strtok(var_07,"|");
			var_0C = strtok(var_09,"| ");
			var_0D = strtok(var_08,"| ");
			foreach(var_0F in var_0B)
			{
				var_0F = "archetype_" + var_0F;
				foreach(var_11 in var_0C)
				{
					foreach(var_13 in var_0D)
					{
						var_14 = func_2E0B(var_0F,var_11,var_13);
						if(!isdefined(level.var_2ED6[var_0A][var_14]))
						{
							level.var_2ED6[var_0A][var_14] = [];
						}

						var_15 = level.var_2ED6[var_0A][var_14].size;
						level.var_2ED6[var_0A][var_14][var_15] = var_06;
					}
				}
			}
		}

		var_05++;
	}
}

//Function Number: 17
func_2E03(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = "specialty_null";
	if(param_02 == "loadoutPrimary")
	{
		var_06 = "iw7_ar57";
	}
	else if(param_02 == "loadoutSecondary")
	{
		var_06 = "iw7_revolver";
	}

	if(param_04 == "default")
	{
		param_04 = "run_and_gun";
	}

	if(param_02 == "loadoutSecondary" && scripts\common\utility::func_2286(param_01,"specialty_twoprimaries"))
	{
		param_02 = "loadoutPrimary";
	}

	if(!isdefined(level.var_2ED6))
	{
		return var_06;
	}

	if(!isdefined(level.var_2ED6[param_02]))
	{
		return var_06;
	}

	var_07 = func_2E0B(param_03,param_04,param_05);
	if(!isdefined(level.var_2ED6[param_02][var_07]))
	{
		return var_06;
	}

	var_06 = func_2E02(level.var_2ED6[param_02][var_07],param_00,param_01,param_02);
	return var_06;
}

//Function Number: 18
func_2E01(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = "specialty_null";
	if(!isdefined(level.var_2E3F))
	{
		return var_06;
	}

	if(!isdefined(level.var_2E40))
	{
		level.var_2E40 = [];
	}

	if(!isdefined(level.var_2E40[param_00]))
	{
		var_07 = strtok(param_00,"_");
		var_07[0] = "";
		var_08 = 0;
		if(scripts\common\utility::func_2286(var_07,"any"))
		{
			var_08 = 1;
		}

		var_09 = [];
		foreach(var_0B in level.var_2E3F)
		{
			if(var_08 || scripts\common\utility::func_2286(var_07,var_0B["type"]))
			{
				var_09[var_09.size] = var_0B["name"];
			}
		}

		level.var_2E40[param_00] = var_09;
	}

	if(level.var_2E40[param_00].size > 0)
	{
		var_06 = func_2E02(level.var_2E40[param_00],param_01,param_02,param_03);
	}

	return var_06;
}

//Function Number: 19
func_2EC0(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_04 - param_03 + 1;
	if(isdefined(param_05))
	{
		var_06 = param_05;
	}

	var_07 = 0;
	var_08 = int(getsubstr(param_01,11));
	if(param_00 == "specialty_twoprimaries")
	{
		return 0;
	}

	if(param_00 == "specialty_extra_attachment")
	{
		return 0;
	}

	if(!func_2E0A("perk",param_00))
	{
		return 0;
	}

	for(var_09 = var_08 - 1;var_09 > 0;var_09--)
	{
		var_0A = "loadoutPerk" + var_09;
		if(param_02[var_0A] == "none" || param_02[var_0A] == "specialty_null")
		{
			continue;
		}

		if(param_00 == param_02[var_0A])
		{
			return 0;
		}

		if(var_09 >= param_03 && var_09 <= param_04)
		{
			var_07 = var_07 + func_2E3E(param_02[var_0A]);
		}
	}

	if(var_07 + func_2E3E(param_00) > var_06)
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
func_2E00(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = int(getsubstr(param_00,5,6)) - 1;
	switch(param_03)
	{
		case "loadoutPrimary":
			return scripts\mp\_class::func_113C0(level.var_4010,var_06,0);

		case "loadoutPrimaryAttachment":
			return scripts\mp\_class::func_113C1(level.var_4010,var_06,0,0);

		case "loadoutPrimaryAttachment2":
			return scripts\mp\_class::func_113C1(level.var_4010,var_06,0,1);

		case "loadoutPrimaryCamo":
			return scripts\mp\_class::func_113C3(level.var_4010,var_06,0);

		case "loadoutPrimaryReticle":
			return scripts\mp\_class::func_113C4(level.var_4010,var_06,0);

		case "loadoutSecondary":
			return scripts\mp\_class::func_113C0(level.var_4010,var_06,1);

		case "loadoutSecondaryAttachment":
			return scripts\mp\_class::func_113C1(level.var_4010,var_06,1,0);

		case "loadoutSecondaryAttachment2":
			return scripts\mp\_class::func_113C1(level.var_4010,var_06,1,1);

		case "loadoutSecondaryCamo":
			return scripts\mp\_class::func_113C3(level.var_4010,var_06,1);

		case "loadoutSecondaryReticle":
			return scripts\mp\_class::func_113C4(level.var_4010,var_06,1);

		case "loadoutStreak1":
			return scripts\mp\_class::func_113B9(level.var_4010,var_06,0);

		case "loadoutStreak2":
			return scripts\mp\_class::func_113B9(level.var_4010,var_06,1);

		case "loadoutStreak3":
			return scripts\mp\_class::func_113B9(level.var_4010,var_06,2);

		case "loadoutPerk6":
		case "loadoutPerk5":
		case "loadoutPerk4":
		case "loadoutPerk3":
		case "loadoutPerk2":
		case "loadoutPerk1":
			var_07 = int(getsubstr(param_03,11));
			var_08 = scripts\mp\_class::func_113BB(level.var_4010,var_06,var_07);
			if(var_08 == "")
			{
				return "specialty_null";
			}
	
			var_09 = int(getsubstr(var_08,0,1));
			var_0A = int(getsubstr(var_08,1,2));
			var_0B = tablelookupbyrow("mp/cacabilitytable.csv",var_09 + 1,var_0A + 3);
			return var_0B;
	}

	return param_05;
}

//Function Number: 21
func_9555()
{
	var_00 = "mp/attachmenttable.csv";
	var_01 = 5;
	var_02 = 19;
	var_03 = 11;
	level.var_2D0E = [];
	level.var_2D0D = [];
	var_04 = 1;
	for(;;)
	{
		var_05 = tablelookupbyrow(var_00,var_04,var_01);
		if(var_05 == "done")
		{
			break;
		}

		var_06 = tablelookupbyrow(var_00,var_04,var_02);
		if(var_05 != "" && var_06 != "")
		{
			var_07 = tablelookupbyrow(var_00,var_04,var_03);
			if(var_07 == "TRUE")
			{
				level.var_2D0D[var_05] = 1;
			}

			var_08 = strtok(var_06,"| ");
			foreach(var_0A in var_08)
			{
				if(!isdefined(level.var_2D0E[var_0A]))
				{
					level.var_2D0E[var_0A] = [];
				}

				if(!scripts\common\utility::func_2286(level.var_2D0E[var_0A],var_05))
				{
					var_0B = level.var_2D0E[var_0A].size;
					level.var_2D0E[var_0A][var_0B] = var_05;
				}
			}
		}

		var_04++;
	}
}

//Function Number: 22
func_2DFE(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	if(!isdefined(level.var_2D0E))
	{
		return var_05;
	}

	if(!isdefined(level.var_2D0E[param_04]))
	{
		return var_05;
	}

	var_05 = func_2E02(level.var_2D0E[param_04],param_00,param_01,param_02);
	return var_05;
}

//Function Number: 23
func_9556()
{
	var_00 = "mp/camotable.csv";
	level.var_2D1E = [];
	var_01 = 0;
	for(;;)
	{
		var_02 = tablelookupbyrow(var_00,var_01,scripts\common\utility::getcamotablecolumnindex("ref"));
		if(!isdefined(var_02) || var_02 == "")
		{
			break;
		}

		var_03 = tablelookupbyrow(var_00,var_01,scripts\common\utility::getcamotablecolumnindex("bot_valid"));
		if(isdefined(var_03) && int(var_03))
		{
			level.var_2D1E[level.var_2D1E.size] = var_02;
		}

		var_01++;
	}
}

//Function Number: 24
func_2DFF(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	return var_05;
}

//Function Number: 25
func_2E0C(param_00)
{
	var_01 = 8;
	if(isdefined(param_00["loadoutPrimary"]) && param_00["loadoutPrimary"] == "none")
	{
		var_01 = var_01 + 1;
	}

	if(isdefined(param_00["loadoutSecondary"]) && param_00["loadoutSecondary"] == "none")
	{
		var_01 = var_01 + 1;
	}

	if(isdefined(param_00["loadoutPowerPrimary"]) && param_00["loadoutPowerPrimary"] == "none")
	{
		var_01 = var_01 + 1;
	}

	if(isdefined(param_00["loadoutPowerSecondary"]) && param_00["loadoutPowerSecondary"] == "none")
	{
		var_01 = var_01 + 1;
	}

	return var_01;
}

//Function Number: 26
func_2E13(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	switch(param_02)
	{
		case "loadoutPrimary":
			var_04 = func_2E0A("weapon",param_03);
			break;

		case "loadoutPowerSecondary":
		case "loadoutPowerPrimary":
			var_04 = func_2E0A("equipment",param_03);
			break;

		case "loadoutPrimaryAttachment":
			var_04 = func_2EC2(param_01["loadoutPrimary"],param_03,"none");
			break;

		case "loadoutPrimaryAttachment2":
			var_04 = func_2EC2(param_01["loadoutPrimary"],param_01["loadoutPrimaryAttachment"],param_03);
			break;

		case "loadoutPrimaryAttachment3":
			var_04 = func_2EC2(param_01["loadoutPrimary"],param_01["loadoutPrimaryAttachment"],param_01["loadoutPrimaryAttachment2"],param_03);
			break;

		case "loadoutPrimaryReticle":
			var_04 = func_2EC1("loadoutPrimary",param_01,param_03);
			break;

		case "loadoutPrimaryCamo":
			var_04 = !isdefined(self.var_2EE6) || param_03 == self.var_2EE6;
			break;

		case "loadoutSecondary":
			var_04 = param_03 != param_01["loadoutPrimary"];
			var_04 = var_04 && func_2E0A("weapon",param_03);
			break;

		case "loadoutSecondaryAttachment":
			var_04 = func_2EC2(param_01["loadoutSecondary"],param_03,"none");
			break;

		case "loadoutSecondaryAttachment2":
			var_04 = func_2EC2(param_01["loadoutSecondary"],param_01["loadoutSecondaryAttachment"],param_03);
			break;

		case "loadoutSecondaryAttachment3":
			var_04 = func_2EC2(param_01["loadoutSecondary"],param_01["loadoutSecondaryAttachment"],param_01["loadoutSecondaryAttachment2"],param_03);
			break;

		case "loadoutSecondaryReticle":
			var_04 = func_2EC1("loadoutSecondary",param_01,param_03);
			break;

		case "loadoutSecondaryCamo":
			var_04 = !isdefined(self.var_2EE6) || param_03 == self.var_2EE6;
			break;

		case "loadoutStreak3":
		case "loadoutStreak2":
		case "loadoutStreak1":
			var_04 = scripts\mp\bots\_bots_killstreaks::func_2DEE(param_03,"bots",undefined,param_01["loadoutStreakType"]);
			var_04 = var_04 && func_2E0A("killstreak",param_03,param_01["loadoutStreakType"]);
			break;

		case "loadoutPerk12":
		case "loadoutPerk11":
		case "loadoutPerk10":
		case "loadoutPerk9":
		case "loadoutPerk8":
		case "loadoutPerk7":
		case "loadoutPerk6":
		case "loadoutPerk5":
		case "loadoutPerk4":
		case "loadoutPerk3":
		case "loadoutPerk2":
		case "loadoutPerk1":
			var_04 = func_2EC0(param_03,param_02,param_01,1,12,func_2E0C(param_01));
			break;

		case "loadoutPerk15":
		case "loadoutPerk14":
		case "loadoutPerk13":
			if(param_01["loadoutStreakType"] != "streaktype_specialist")
			{
				var_04 = 0;
			}
			else
			{
				var_04 = func_2EC0(param_03,param_02,param_01,-1,-1);
			}
			break;

		case "loadoutPerk23":
		case "loadoutPerk22":
		case "loadoutPerk21":
		case "loadoutPerk20":
		case "loadoutPerk19":
		case "loadoutPerk18":
		case "loadoutPerk17":
		case "loadoutPerk16":
			if(param_01["loadoutStreakType"] != "streaktype_specialist")
			{
				var_04 = 0;
			}
			else
			{
				var_04 = func_2EC0(param_03,param_02,param_01,16,23,8);
			}
			break;
	}

	return var_04;
}

//Function Number: 27
func_2E02(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	var_06 = undefined;
	var_07 = 0;
	if(scripts\common\utility::func_2286(param_00,"specialty_null"))
	{
		var_05 = "specialty_null";
	}

	foreach(var_09 in param_00)
	{
		var_0A = undefined;
		if(getsubstr(var_09,0,9) == "template_")
		{
			var_0A = var_09;
			var_0B = level.var_2EE8[var_09][param_03];
			var_09 = func_2E02(strtok(var_0B,"| "),param_01,param_02,param_03,1);
			if(isdefined(var_0A) && isdefined(self.var_3F29[var_0A]))
			{
				return var_09;
			}
		}

		if(var_09 == "attachmenttable")
		{
			return func_2DFE(param_01,param_02,param_03,self.var_CA79,self.var_54CF);
		}

		if(var_09 == "weap_statstable")
		{
			return func_2E03(param_01,param_02,param_03,self.var_2ED8,self.var_CA79,self.var_54CF);
		}

		if(var_09 == "camotable")
		{
			return func_2DFF(param_01,param_02,param_03,self.var_CA79,self.var_54CF);
		}

		if(getsubstr(var_09,0,5) == "class" && int(getsubstr(var_09,5,6)) > 0)
		{
			var_09 = func_2E00(var_09,param_01,param_02,param_03,self.var_CA79,self.var_54CF);
		}

		if(isdefined(level.var_2E3F) && getsubstr(var_09,0,10) == "perktable_")
		{
			return func_2E01(var_09,param_01,param_02,param_03,self.var_CA79,self.var_54CF);
		}

		if(func_2E13(param_01,param_02,param_03,var_09))
		{
			var_07 = var_07 + 1;
			if(randomfloat(1) <= 1 / var_07)
			{
				var_05 = var_09;
				var_06 = var_0A;
			}
		}
	}

	if(isdefined(var_06))
	{
		self.var_3F29[var_06] = 1;
	}

	return var_05;
}

//Function Number: 28
func_2E04(param_00)
{
	self.var_3F29 = [];
	foreach(var_06, var_02 in param_00)
	{
		var_03 = strtok(var_02,"| ");
		var_04 = func_2E02(var_03,var_02,param_00,var_06);
		param_00[var_06] = var_04;
	}

	return param_00;
}

//Function Number: 29
func_2E09()
{
	var_00 = "regular";
	var_00 = self botgetdifficulty();
	if(var_00 == "default")
	{
		scripts\mp\bots\_bots_util::func_2E81("default");
		var_00 = self botgetdifficulty();
	}

	return var_00;
}

//Function Number: 30
func_2E08()
{
	if(!isdefined(self.var_2ED8))
	{
		var_00 = self method_8035();
		var_01 = level.var_2ED9[var_00];
		var_02 = randomint(var_01.size);
		self.var_2ED8 = var_01[var_02];
	}

	return self.var_2ED8;
}

//Function Number: 31
func_2E05()
{
	while(!isdefined(level.var_2E14))
	{
		wait(0.05);
	}

	while(!isdefined(self.var_CA79))
	{
		wait(0.05);
	}

	var_00 = [];
	var_01 = func_2E09();
	self.var_54CF = var_01;
	var_02 = self method_8035();
	var_03 = func_2E08();
	if(isdefined(self.var_2EE3))
	{
		var_04 = self.var_2EE4 == var_01;
		var_05 = self.var_2EE5 == var_02;
		if(var_04 && var_05 && !isdefined(self.var_8BE2) || self.var_8BE2 && !isdefined(self.var_E293))
		{
			return self.var_2EE3;
		}
	}

	var_00 = func_2E0D(var_03,var_02,var_01);
	var_00 = func_2E04(var_00);
	if(isdefined(level.var_2D9E["gametype_loadout_modify"]))
	{
		var_00 = self [[ level.var_2D9E["gametype_loadout_modify"] ]](var_00);
	}

	if(var_00["loadoutPrimary"] == "none")
	{
		self.var_2D6F = undefined;
		var_00["loadoutPrimary"] = func_2DFD(var_00);
		var_00["loadoutPrimaryCamo"] = "none";
		var_00["loadoutPrimaryAttachment"] = "none";
		var_00["loadoutPrimaryAttachment2"] = "none";
		var_00["loadoutPrimaryAttachment3"] = "none";
		var_00["loadoutPrimaryReticle"] = "none";
		if(isdefined(self.var_2D6F))
		{
			if(self.var_2D6F == "weapon")
			{
				func_2E48(var_00["loadoutPrimary"]);
			}
			else
			{
				scripts\mp\bots\_bots_util::func_2E83(self.var_2D6F);
			}

			var_02 = self.var_CA79;
			self.var_2D6F = undefined;
		}
	}

	self.var_2EE3 = var_00;
	self.var_2EE4 = var_01;
	self.var_2EE5 = var_02;
	if(isdefined(var_00["loadoutPrimaryCamo"]) && var_00["loadoutPrimaryCamo"] != "none")
	{
		self.var_2EE6 = var_00["loadoutPrimaryCamo"];
	}

	if(isdefined(self.var_E293))
	{
		if(isdefined(level.var_2E66) && func_2E0A("weapon",level.var_2E66))
		{
			var_00["loadoutSecondary"] = level.var_2E66;
			var_00["loadoutSecondaryAttachment"] = "none";
			var_00["loadoutSecondaryAttachment2"] = "none";
			self.var_2EE3 = undefined;
		}

		self.var_E293 = undefined;
	}

	var_00 = func_2E0F(var_00);
	if(scripts\mp\_utility::func_2DE2())
	{
		if(scripts\common\utility::func_2286(self.pers["loadoutPerks"],"specialty_twoprimaries"))
		{
			var_06 = func_2E0D("cqb",var_01);
			var_00["loadoutSecondary"] = var_06["loadoutPrimary"];
			var_00["loadoutSecondaryAttachment"] = var_06["loadoutPrimaryAttachment"];
			var_00["loadoutSecondaryAttachment2"] = var_06["loadoutPrimaryAttachment2"];
			var_00 = func_2E04(var_00);
			var_00 = func_2E0F(var_00);
		}

		if(scripts\common\utility::func_2286(self.pers["loadoutPerks"],"specialty_extra_attachment"))
		{
			var_07 = func_2E0D(var_02,var_01);
			var_00["loadoutPrimaryAttachment3"] = var_07["loadoutPrimaryAttachment2"];
			if(scripts\common\utility::func_2286(self.pers["loadoutPerks"],"specialty_twoprimaries"))
			{
				var_00["loadoutSecondaryAttachment2"] = var_07["loadoutPrimaryAttachment2"];
			}
			else
			{
				var_00["loadoutSecondaryAttachment2"] = var_07["loadoutSecondaryAttachment2"];
			}

			var_00 = func_2E04(var_00);
			var_00 = func_2E0F(var_00);
		}
		else
		{
			var_00["loadoutSecondaryAttachment2"] = "none";
			if(!func_2EC1("loadoutSecondary",var_00,var_00["loadoutSecondaryReticle"]))
			{
				var_00["loadoutSecondaryReticle"] = "none";
			}
		}
	}

	return var_00;
}

//Function Number: 32
func_2E0F(param_00)
{
	self.pers["loadoutPerks"] = [];
	self.pers["specialistBonusStreaks"] = [];
	self.pers["specialistStreaks"] = [];
	self.pers["specialistStreakKills"] = [];
	var_01 = 0;
	var_02 = isdefined(param_00["loadoutStreakType"]) && param_00["loadoutStreakType"] == "streaktype_specialist";
	if(var_02)
	{
		param_00["loadoutStreak1"] = "none";
		param_00["loadoutStreak2"] = "none";
		param_00["loadoutStreak3"] = "none";
	}

	foreach(var_08, var_04 in param_00)
	{
		if(var_04 == "specialty_null" || var_04 == "none")
		{
			continue;
		}

		if(getsubstr(var_08,0,11) == "loadoutPerk")
		{
			var_05 = int(getsubstr(var_08,11));
			if(!var_02 && var_05 > 12)
			{
				continue;
			}

			var_06 = scripts\mp\_utility::func_7DF6(var_04);
			if(var_05 <= 12)
			{
				self.pers["loadoutPerks"][self.pers["loadoutPerks"].size] = var_06;
			}
			else if(var_05 <= 15)
			{
				param_00["loadoutStreak" + var_01 + 1] = var_06 + "_ks";
				self.pers["specialistStreaks"][self.pers["specialistStreaks"].size] = var_06 + "_ks";
				var_07 = 0;
				if(var_01 > 0)
				{
					var_07 = self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size - 1];
				}

				self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size] = var_07 + func_2E3E(var_06) + 2;
				var_01++;
			}
			else
			{
				self.pers["specialistBonusStreaks"][self.pers["specialistBonusStreaks"].size] = var_06;
			}
		}
	}

	if(var_02 && !isdefined(self.pers["specialistStreakKills"][0]))
	{
		self.pers["specialistStreakKills"][0] = 0;
		self.pers["specialistStreaks"][0] = "specialty_null";
	}

	if(var_02 && !isdefined(self.pers["specialistStreakKills"][1]))
	{
		self.pers["specialistStreakKills"][1] = self.pers["specialistStreakKills"][0];
		self.pers["specialistStreaks"][1] = "specialty_null";
	}

	if(var_02 && !isdefined(self.pers["specialistStreakKills"][2]))
	{
		self.pers["specialistStreakKills"][2] = self.pers["specialistStreakKills"][1];
		self.pers["specialistStreaks"][2] = "specialty_null";
	}

	return param_00;
}

//Function Number: 33
func_2E89()
{
	var_00 = func_2E08();
	var_01 = self method_8035();
	var_02 = func_2E09();
	var_03 = func_2E0E(var_00,var_01,var_02,0);
	if(isdefined(var_03) && isdefined(var_03.var_AE93) && var_03.var_AE93.size > 0)
	{
		self.var_4009 = ::func_2E05;
		return 1;
	}

	var_04 = getsubstr(self.name,0,self.name.size - 10);
	self.var_4009 = undefined;
	return 0;
}

//Function Number: 34
func_2E9C(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_06))
	{
		return param_00 getplayerdata("privateloadouts","squadMembers","loadouts",param_02,param_03,param_04,param_05,param_06);
	}

	if(isdefined(param_05))
	{
		return param_00 getplayerdata("privateloadouts","squadMembers","loadouts",param_02,param_03,param_04,param_05);
	}

	if(isdefined(param_04))
	{
		return param_00 getplayerdata("privateloadouts","squadMembers","loadouts",param_02,param_03,param_04);
	}

	return param_00 getplayerdata("privateloadouts","squadMembers","loadouts",param_02,param_03);
}

//Function Number: 35
func_2E9D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_06))
	{
		return param_00 getplayerdata("rankedloadouts","squadMembers","loadouts",param_02,param_03,param_04,param_05,param_06);
	}

	if(isdefined(param_05))
	{
		return param_00 getplayerdata("rankedloadouts","squadMembers","loadouts",param_02,param_03,param_04,param_05);
	}

	if(isdefined(param_04))
	{
		return param_00 getplayerdata("rankedloadouts","squadMembers","loadouts",param_02,param_03,param_04);
	}

	return param_00 getplayerdata("rankedloadouts","squadMembers","loadouts",param_02,param_03);
}

//Function Number: 36
func_2E9B(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_06))
	{
		return function_0096("squadMembers","loadouts",param_02,param_03,param_04,param_05,param_06);
	}

	if(isdefined(param_05))
	{
		return function_0096("squadMembers","loadouts",param_02,param_03,param_04,param_05);
	}

	if(isdefined(param_04))
	{
		return function_0096("squadMembers","loadouts",param_02,param_03,param_04);
	}

	return function_0096("squadMembers","loadouts",param_02,param_03);
}

//Function Number: 37
func_2E9A(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = ::func_2E9D;
	if(getdvar("squad_match") == "1" && self.team == "axis")
	{
		var_07 = ::func_2E9B;
	}
	else if(!scripts\mp\_utility::func_B3EC())
	{
		var_07 = ::func_2E9C;
	}

	return self [[ var_07 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 38
func_2E9E(param_00,param_01,param_02)
{
	if(getdvar("squad_match") == "1" && self.team == "axis")
	{
		return function_0096("squadMembers",param_01,param_02);
	}

	if(!scripts\mp\_utility::func_B3EC())
	{
		return param_00 getplayerdata("privateloadouts","squadMembers",param_02);
	}

	return param_00 getplayerdata("rankedloadouts","squadMembers",param_02);
}

//Function Number: 39
func_2E06(param_00,param_01,param_02,param_03)
{
	param_00["loadoutPrimary"] = func_2E9A(param_01,param_02,param_03,"weaponSetups",0,"weapon");
	param_00["loadoutPrimaryAttachment"] = func_2E9A(param_01,param_02,param_03,"weaponSetups",0,"attachment",0);
	param_00["loadoutPrimaryAttachment2"] = func_2E9A(param_01,param_02,param_03,"weaponSetups",0,"attachment",1);
	param_00["loadoutPrimaryAttachment3"] = func_2E9A(param_01,param_02,param_03,"weaponSetups",0,"attachment",2);
	param_00["loadoutPrimaryCamo"] = func_2E9A(param_01,param_02,param_03,"weaponSetups",0,"camo");
	param_00["loadoutPrimaryReticle"] = func_2E9A(param_01,param_02,param_03,"weaponSetups",0,"reticle");
	param_00["loadoutSecondary"] = func_2E9A(param_01,param_02,param_03,"weaponSetups",1,"weapon");
	param_00["loadoutSecondaryAttachment"] = func_2E9A(param_01,param_02,param_03,"weaponSetups",1,"attachment",0);
	param_00["loadoutSecondaryAttachment2"] = func_2E9A(param_01,param_02,param_03,"weaponSetups",1,"attachment",1);
	param_00["loadoutSecondaryCamo"] = func_2E9A(param_01,param_02,param_03,"weaponSetups",1,"camo");
	param_00["loadoutSecondaryReticle"] = func_2E9A(param_01,param_02,param_03,"weaponSetups",1,"reticle");
	param_00["loadoutPowerPrimary"] = func_2E9A(param_01,param_02,param_03,"perks",0);
	param_00["loadoutPowerSecondary"] = func_2E9A(param_01,param_02,param_03,"perks",1);
	param_00["loadoutStreak1"] = "none";
	param_00["loadoutStreak2"] = "none";
	param_00["loadoutStreak3"] = "none";
	var_04 = func_2E9A(param_01,param_02,param_03,"perks",5);
	if(isdefined(var_04))
	{
		param_00["loadoutStreakType"] = var_04;
		if(var_04 == "streaktype_assault")
		{
			param_00["loadoutStreak1"] = func_2E9A(param_01,param_02,param_03,"assaultStreaks",0);
			param_00["loadoutStreak2"] = func_2E9A(param_01,param_02,param_03,"assaultStreaks",1);
			param_00["loadoutStreak3"] = func_2E9A(param_01,param_02,param_03,"assaultStreaks",2);
		}
		else if(var_04 == "streaktype_support")
		{
			param_00["loadoutStreak1"] = func_2E9A(param_01,param_02,param_03,"supportStreaks",0);
			param_00["loadoutStreak2"] = func_2E9A(param_01,param_02,param_03,"supportStreaks",1);
			param_00["loadoutStreak3"] = func_2E9A(param_01,param_02,param_03,"supportStreaks",2);
		}
		else if(var_04 == "streaktype_specialist")
		{
			param_00["loadoutPerk13"] = func_2E9A(param_01,param_02,param_03,"specialistStreaks",0);
			param_00["loadoutPerk14"] = func_2E9A(param_01,param_02,param_03,"specialistStreaks",1);
			param_00["loadoutPerk15"] = func_2E9A(param_01,param_02,param_03,"specialistStreaks",2);
		}
	}

	param_00["loadoutCharacterType"] = func_2E9A(param_01,param_02,param_03,"type");
	func_2E48(param_00["loadoutPrimary"]);
	self.var_240 = func_2E9E(param_01,param_02,"patch");
	self.var_23F = func_2E9E(param_01,param_02,"background");
	return param_00;
}

//Function Number: 40
func_2E0B(param_00,param_01,param_02)
{
	return param_00 + "_" + param_01 + "_" + param_02;
}