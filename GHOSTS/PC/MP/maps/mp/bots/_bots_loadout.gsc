/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_loadout.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 41
 * Decompile Time: 797 ms
 * Timestamp: 10/27/2023 1:17:36 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	func_45BB();
	func_4526();
	func_4583();
	func_451E();
	init_bot_attachmenttable();
	init_bot_camotable();
	level.bot_loadouts_initialized = 1;
}

//Function Number: 2
func_4526()
{
	var_00 = "mp/botClassTable.csv";
	level.botloadoutsets = [];
	var_01 = bot_loadout_fields();
	var_02 = 0;
	for(;;)
	{
		var_02++;
		var_03 = tablelookup(var_00,0,"botPersonalities",var_02);
		var_04 = tablelookup(var_00,0,"botDifficulties",var_02);
		if(!isdefined(var_03) || var_03 == "")
		{
			break;
		}

		if(!isdefined(var_04) || var_04 == "")
		{
			break;
		}

		var_05 = [];
		foreach(var_07 in var_01)
		{
			var_05[var_07] = tablelookup(var_00,0,var_07,var_02);
		}

		var_09 = strtok(var_03,"| ");
		var_0A = strtok(var_04,"| ");
		foreach(var_0C in var_09)
		{
			foreach(var_0E in var_0A)
			{
				var_0F = bot_loadout_set(var_0C,var_0E,1);
				var_10 = spawnstruct();
				var_10.loadoutvalues = var_05;
				var_0F.loadouts[var_0F.loadouts.size] = var_10;
			}
		}
	}
}

//Function Number: 3
func_45BB()
{
	var_00 = "mp/botTemplateTable.csv";
	level.botloadouttemplates = [];
	var_01 = bot_loadout_fields();
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
		level.botloadouttemplates[var_04] = [];
		foreach(var_06 in var_01)
		{
			var_07 = tablelookup(var_00,0,var_06,var_02);
			if(isdefined(var_07) && var_07 != "")
			{
				level.botloadouttemplates[var_04][var_06] = var_07;
			}
		}
	}
}

//Function Number: 4
func_8FFE(param_00,param_01,param_02)
{
	if(!isusingmatchrulesdata())
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
			var_05 = maps\mp\_utility::getweaponclass(param_01);
			break;

		case "attachment":
			var_05 = maps\mp\_utility::getattachmenttype(param_01);
			break;

		case "killstreak":
			var_05 = param_02;
			break;

		case "perk":
			var_05 = "ability_" + level.bot_perktypes[param_01];
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

//Function Number: 5
func_8FFD(param_00)
{
	var_01 = "none";
	var_02 = ["veteran","hardened","regular","recruit"];
	var_02 = common_scripts\utility::array_randomize(var_02);
	foreach(var_04 in var_02)
	{
		var_01 = func_1623("weap_statstable",param_00,"loadoutPrimary",self.personality,var_04);
		if(var_01 != "none")
		{
			return var_01;
		}
	}

	if(isdefined(level.bot_personality_list))
	{
		var_06 = common_scripts\utility::array_randomize(level.bot_personality_list);
		foreach(var_08 in var_06)
		{
			foreach(var_04 in var_02)
			{
				var_01 = func_1623("weap_statstable",param_00,"loadoutPrimary",var_08,var_04);
				if(var_01 != "none")
				{
					self.bot_fallback_personality = var_08;
					return var_01;
				}
			}
		}
	}

	if(isusingmatchrulesdata())
	{
		for(var_0C = 0;var_0C < 6 && !isdefined(var_01) || var_01 == "none" || var_01 == "";var_0C++)
		{
			if(getmatchrulesdata("defaultClasses",self.team,var_0C,"class","inUse"))
			{
				var_01 = getmatchrulesdata("defaultClasses",self.team,var_0C,"class","weaponSetups",0,"weapon");
				if(var_01 != "none")
				{
					self.bot_fallback_personality = "weapon";
					return var_01;
				}
			}
		}
	}

	self.bot_fallback_personality = "weapon";
	return level.bot_fallback_weapon;
}

//Function Number: 6
func_9005(param_00)
{
	if(isdefined(param_00))
	{
		var_01 = level.bot_weap_personality[param_00];
		if(isdefined(var_01))
		{
			var_02 = strtok(var_01,"| ");
			if(var_02.size > 0)
			{
				maps/mp/bots/_bots_util::bot_set_personality(common_scripts\utility::func_6306(var_02));
			}
		}
	}
}

//Function Number: 7
bot_loadout_fields()
{
	var_00 = [];
	var_00[var_00.size] = "loadoutPrimary";
	var_00[var_00.size] = "loadoutPrimaryBuff";
	var_00[var_00.size] = "loadoutPrimaryAttachment";
	var_00[var_00.size] = "loadoutPrimaryAttachment2";
	var_00[var_00.size] = "loadoutPrimaryCamo";
	var_00[var_00.size] = "loadoutPrimaryReticle";
	var_00[var_00.size] = "loadoutSecondary";
	var_00[var_00.size] = "loadoutSecondaryBuff";
	var_00[var_00.size] = "loadoutSecondaryAttachment";
	var_00[var_00.size] = "loadoutSecondaryAttachment2";
	var_00[var_00.size] = "loadoutSecondaryCamo";
	var_00[var_00.size] = "loadoutSecondaryReticle";
	var_00[var_00.size] = "loadoutEquipment";
	var_00[var_00.size] = "loadoutOffhand";
	var_00[var_00.size] = "loadoutStreakType";
	var_00[var_00.size] = "loadoutStreak1";
	var_00[var_00.size] = "loadoutStreak2";
	var_00[var_00.size] = "loadoutStreak3";
	var_00[var_00.size] = "loadoutPerk1";
	var_00[var_00.size] = "loadoutPerk2";
	var_00[var_00.size] = "loadoutPerk3";
	var_00[var_00.size] = "loadoutPerk4";
	var_00[var_00.size] = "loadoutPerk5";
	var_00[var_00.size] = "loadoutPerk6";
	var_00[var_00.size] = "loadoutPerk7";
	var_00[var_00.size] = "loadoutPerk8";
	var_00[var_00.size] = "loadoutPerk9";
	var_00[var_00.size] = "loadoutPerk10";
	var_00[var_00.size] = "loadoutPerk11";
	var_00[var_00.size] = "loadoutPerk12";
	var_00[var_00.size] = "loadoutPerk13";
	var_00[var_00.size] = "loadoutPerk14";
	var_00[var_00.size] = "loadoutPerk15";
	var_00[var_00.size] = "loadoutPerk16";
	var_00[var_00.size] = "loadoutPerk17";
	var_00[var_00.size] = "loadoutPerk18";
	var_00[var_00.size] = "loadoutPerk19";
	var_00[var_00.size] = "loadoutPerk20";
	var_00[var_00.size] = "loadoutPerk21";
	var_00[var_00.size] = "loadoutPerk22";
	var_00[var_00.size] = "loadoutPerk23";
	return var_00;
}

//Function Number: 8
bot_loadout_set(param_00,param_01,param_02)
{
	var_03 = param_01 + "_" + param_00;
	if(!isdefined(level.botloadoutsets))
	{
		level.botloadoutsets = [];
	}

	if(!isdefined(level.botloadoutsets[var_03]) && param_02)
	{
		level.botloadoutsets[var_03] = spawnstruct();
		level.botloadoutsets[var_03].loadouts = [];
	}

	if(isdefined(level.botloadoutsets[var_03]))
	{
		return level.botloadoutsets[var_03];
	}
}

//Function Number: 9
bot_loadout_pick(param_00,param_01)
{
	var_02 = bot_loadout_set(param_00,param_01,0);
	if(isdefined(var_02) && isdefined(var_02.loadouts) && var_02.loadouts.size > 0)
	{
		var_03 = randomint(var_02.loadouts.size);
		return var_02.loadouts[var_03].loadoutvalues;
	}
}

//Function Number: 10
bot_validate_weapon(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\_utility::func_3C6F(param_00);
	if(isdefined(param_01) && param_01 != "none" && !func_8FFE("attachment",param_01))
	{
		return 0;
	}

	if(isdefined(param_02) && param_02 != "none" && !func_8FFE("attachment",param_02))
	{
		return 0;
	}

	if(isdefined(param_03) && param_03 != "none" && !func_8FFE("attachment",param_03))
	{
		return 0;
	}

	if(param_01 != "none" && !common_scripts\utility::array_contains(var_04,param_01))
	{
		return 0;
	}

	if(param_02 != "none" && !common_scripts\utility::array_contains(var_04,param_02))
	{
		return 0;
	}

	if(isdefined(param_03) && param_03 != "none" && !common_scripts\utility::array_contains(var_04,param_03))
	{
		return 0;
	}

	if((param_01 == "none" || param_02 == "none") && !isdefined(param_03) || param_03 == "none")
	{
		return 1;
	}

	if(!isdefined(level.bot_invalid_attachment_combos))
	{
		level.bot_invalid_attachment_combos = [];
		level.allowable_double_attachments = [];
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
						level.allowable_double_attachments[var_09] = 1;
					}

					continue;
				}

				if(tablelookupbyrow(var_05,var_08,var_06) == "no")
				{
					level.bot_invalid_attachment_combos[var_07][var_09] = 1;
				}
			}
		}
	}

	if(param_01 == param_02 && !isdefined(level.allowable_double_attachments[param_01]))
	{
		return 0;
	}

	if(isdefined(param_03))
	{
		if(param_02 == param_03 && !isdefined(level.allowable_double_attachments[param_02]))
		{
			return 0;
		}

		if(param_01 == param_03 && !isdefined(level.allowable_double_attachments[param_01]))
		{
			return 0;
		}

		if(param_03 != "none" && param_01 == param_03 && param_02 == param_03)
		{
			return 0;
		}

		if(isdefined(level.bot_invalid_attachment_combos[param_02]) && isdefined(level.bot_invalid_attachment_combos[param_02][param_03]))
		{
			return 0;
		}

		if(isdefined(level.bot_invalid_attachment_combos[param_01]) && isdefined(level.bot_invalid_attachment_combos[param_01][param_03]))
		{
			return 0;
		}
	}

	return !isdefined(level.bot_invalid_attachment_combos[param_01]) && isdefined(level.bot_invalid_attachment_combos[param_01][param_02]);
}

//Function Number: 11
bot_validate_reticle(param_00,param_01,param_02)
{
	if(isdefined(param_01[param_00 + "Attachment"]) && isdefined(level.bot_attachment_reticle[param_01[param_00 + "Attachment"]]))
	{
		return 1;
	}

	if(isdefined(param_01[param_00 + "Attachment2"]) && isdefined(level.bot_attachment_reticle[param_01[param_00 + "Attachment2"]]))
	{
		return 1;
	}

	if(isdefined(param_01[param_00 + "Attachment3"]) && isdefined(level.bot_attachment_reticle[param_01[param_00 + "Attachment3"]]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
bot_perk_cost(param_00)
{
	return level.perktable_costs[param_00];
}

//Function Number: 13
func_5BA1(param_00,param_01)
{
	if(bot_perk_cost(param_00) > 0)
	{
		var_02 = [];
		var_02["type"] = param_01;
		var_02["name"] = param_00;
		level.bot_perktable[level.bot_perktable.size] = var_02;
		level.bot_perktypes[param_00] = param_01;
	}
}

//Function Number: 14
func_4583()
{
	level.perktable_costs = [];
	var_00 = 1;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/perktable.csv",var_00,1);
		if(var_01 == "")
		{
			break;
		}

		level.perktable_costs[var_01] = int(tablelookupbyrow("mp/perktable.csv",var_00,10));
		var_00++;
	}

	level.perktable_costs["none"] = 0;
	level.perktable_costs["specialty_null"] = 0;
	level.bot_perktable = [];
	level.bot_perktypes = [];
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
				func_5BA1(var_01,var_02);
			}
		}

		var_00++;
		var_02 = tablelookupbyrow("mp/cacabilitytable.csv",var_00,1);
	}
}

//Function Number: 15
func_451E()
{
	var_00 = "mp/statstable.csv";
	var_01 = 4;
	var_02 = 37;
	var_03 = 38;
	level.bot_weap_statstable = [];
	level.bot_weap_personality = [];
	var_04 = 1;
	for(;;)
	{
		var_05 = tablelookupbyrow(var_00,var_04,var_01);
		if(var_05 == "specialty_null")
		{
			break;
		}

		var_06 = tablelookupbyrow(var_00,var_04,var_03);
		var_07 = tablelookupbyrow(var_00,var_04,var_02);
		if(var_05 != "" && var_07 != "")
		{
			level.bot_weap_personality[var_05] = var_07;
		}

		if(var_06 != "" && var_05 != "" && var_07 != "")
		{
			var_08 = "loadoutPrimary";
			if(maps\mp\gametypes\_class::isvalidsecondary(var_05,0))
			{
				var_08 = "loadoutSecondary";
			}
			else if(!maps\mp\gametypes\_class::func_49A6(var_05,0))
			{
				var_04++;
				continue;
			}

			if(!isdefined(level.bot_weap_statstable[var_08]))
			{
				level.bot_weap_statstable[var_08] = [];
			}

			var_09 = strtok(var_07,"| ");
			var_0A = strtok(var_06,"| ");
			foreach(var_0C in var_09)
			{
				if(!isdefined(level.bot_weap_statstable[var_08][var_0C]))
				{
					level.bot_weap_statstable[var_08][var_0C] = [];
				}

				foreach(var_0E in var_0A)
				{
					if(!isdefined(level.bot_weap_statstable[var_08][var_0C][var_0E]))
					{
						level.bot_weap_statstable[var_08][var_0C][var_0E] = [];
					}

					var_0F = level.bot_weap_statstable[var_08][var_0C][var_0E].size;
					level.bot_weap_statstable[var_08][var_0C][var_0E][var_0F] = var_05;
				}
			}
		}

		var_04++;
	}
}

//Function Number: 16
func_1623(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "specialty_null";
	if(param_02 == "loadoutPrimary")
	{
		var_05 = "iw6_honeybadger";
	}
	else if(param_02 == "loadoutSecondary")
	{
		var_05 = "iw6_p226";
	}

	if(param_03 == "default")
	{
		param_03 = "run_and_gun";
	}

	if(param_02 == "loadoutSecondary" && common_scripts\utility::array_contains(param_01,"specialty_twoprimaries"))
	{
		param_02 = "loadoutPrimary";
	}

	if(!isdefined(level.bot_weap_statstable))
	{
		return var_05;
	}

	if(!isdefined(level.bot_weap_statstable[param_02]))
	{
		return var_05;
	}

	if(!isdefined(level.bot_weap_statstable[param_02][param_03]))
	{
		return var_05;
	}

	if(!isdefined(level.bot_weap_statstable[param_02][param_03][param_04]))
	{
		return var_05;
	}

	var_05 = bot_loadout_choose_from_set(level.bot_weap_statstable[param_02][param_03][param_04],param_00,param_01,param_02);
	return var_05;
}

//Function Number: 17
bot_loadout_choose_from_perktable(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = "specialty_null";
	if(!isdefined(level.bot_perktable))
	{
		return var_06;
	}

	if(!isdefined(level.bot_perktable_groups))
	{
		level.bot_perktable_groups = [];
	}

	if(!isdefined(level.bot_perktable_groups[param_00]))
	{
		var_07 = strtok(param_00,"_");
		var_07[0] = "";
		var_08 = 0;
		if(common_scripts\utility::array_contains(var_07,"any"))
		{
			var_08 = 1;
		}

		var_09 = [];
		foreach(var_0B in level.bot_perktable)
		{
			if(var_08 || common_scripts\utility::array_contains(var_07,var_0B["type"]))
			{
				var_09[var_09.size] = var_0B["name"];
			}
		}

		level.bot_perktable_groups[param_00] = var_09;
	}

	if(level.bot_perktable_groups[param_00].size > 0)
	{
		var_06 = bot_loadout_choose_from_set(level.bot_perktable_groups[param_00],param_01,param_02,param_03);
	}

	return var_06;
}

//Function Number: 18
bot_validate_perk(param_00,param_01,param_02,param_03,param_04,param_05)
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

	if(!func_8FFE("perk",param_00))
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
			var_07 = var_07 + bot_perk_cost(param_02[var_0A]);
		}
	}

	if(var_07 + bot_perk_cost(param_00) > var_06)
	{
		return 0;
	}

	return 1;
}

//Function Number: 19
func_1620(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = int(getsubstr(param_00,5,6)) - 1;
	switch(param_03)
	{
		case "loadoutPrimary":
			return maps\mp\gametypes\_class::func_7E4F(level.classtablename,var_06,0);

		case "loadoutPrimaryAttachment":
			return maps\mp\gametypes\_class::func_7E50(level.classtablename,var_06,0,0);

		case "loadoutPrimaryAttachment2":
			return maps\mp\gametypes\_class::func_7E50(level.classtablename,var_06,0,1);

		case "loadoutPrimaryBuff":
			return maps\mp\gametypes\_class::table_getweaponbuff(level.classtablename,var_06,0);

		case "loadoutPrimaryCamo":
			return maps\mp\gametypes\_class::func_7E52(level.classtablename,var_06,0);

		case "loadoutPrimaryReticle":
			return maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename,var_06,0);

		case "loadoutSecondary":
			return maps\mp\gametypes\_class::func_7E4F(level.classtablename,var_06,1);

		case "loadoutSecondaryAttachment":
			return maps\mp\gametypes\_class::func_7E50(level.classtablename,var_06,1,0);

		case "loadoutSecondaryAttachment2":
			return maps\mp\gametypes\_class::func_7E50(level.classtablename,var_06,1,1);

		case "loadoutSecondaryBuff":
			return maps\mp\gametypes\_class::table_getweaponbuff(level.classtablename,var_06,1);

		case "loadoutSecondaryCamo":
			return maps\mp\gametypes\_class::func_7E52(level.classtablename,var_06,1);

		case "loadoutSecondaryReticle":
			return maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename,var_06,1);

		case "loadoutEquipment":
			return maps\mp\gametypes\_class::func_7E4A(level.classtablename,var_06,0);

		case "loadoutOffhand":
			return maps\mp\gametypes\_class::func_7E4C(level.classtablename,var_06,0);

		case "loadoutStreak1":
			return maps\mp\gametypes\_class::func_7E4B(level.classtablename,var_06,0);

		case "loadoutStreak2":
			return maps\mp\gametypes\_class::func_7E4B(level.classtablename,var_06,1);

		case "loadoutStreak3":
			return maps\mp\gametypes\_class::func_7E4B(level.classtablename,var_06,2);

		case "loadoutPerk6":
		case "loadoutPerk5":
		case "loadoutPerk4":
		case "loadoutPerk3":
		case "loadoutPerk2":
		case "loadoutPerk1":
			var_07 = int(getsubstr(param_03,11));
			var_08 = maps\mp\gametypes\_class::func_7E4D(level.classtablename,var_06,var_07);
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

//Function Number: 20
init_bot_attachmenttable()
{
	var_00 = "mp/attachmenttable.csv";
	var_01 = 5;
	var_02 = 19;
	var_03 = 11;
	level.bot_attachmenttable = [];
	level.bot_attachment_reticle = [];
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
				level.bot_attachment_reticle[var_05] = 1;
			}

			var_08 = strtok(var_06,"| ");
			foreach(var_0A in var_08)
			{
				if(!isdefined(level.bot_attachmenttable[var_0A]))
				{
					level.bot_attachmenttable[var_0A] = [];
				}

				if(!common_scripts\utility::array_contains(level.bot_attachmenttable[var_0A],var_05))
				{
					var_0B = level.bot_attachmenttable[var_0A].size;
					level.bot_attachmenttable[var_0A][var_0B] = var_05;
				}
			}
		}

		var_04++;
	}
}

//Function Number: 21
bot_loadout_choose_from_attachmenttable(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	if(!isdefined(level.bot_attachmenttable))
	{
		return var_05;
	}

	if(!isdefined(level.bot_attachmenttable[param_04]))
	{
		return var_05;
	}

	var_05 = bot_loadout_choose_from_set(level.bot_attachmenttable[param_04],param_00,param_01,param_02);
	return var_05;
}

//Function Number: 22
init_bot_camotable()
{
	var_00 = "mp/camotable.csv";
	var_01 = 1;
	var_02 = 5;
	level.bot_camotable = [];
	var_03 = 0;
	for(;;)
	{
		var_04 = tablelookupbyrow(var_00,var_03,var_01);
		if(!isdefined(var_04) || var_04 == "")
		{
			break;
		}

		var_05 = tablelookupbyrow(var_00,var_03,var_02);
		if(isdefined(var_05) && int(var_05))
		{
			level.bot_camotable[level.bot_camotable.size] = var_04;
		}

		var_03++;
	}
}

//Function Number: 23
bot_loadout_choose_from_camotable(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	if(!isdefined(level.bot_camotable))
	{
		return var_05;
	}

	var_05 = bot_loadout_choose_from_set(level.bot_camotable,param_00,param_01,param_02);
	return var_05;
}

//Function Number: 24
func_1628(param_00)
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

	if(isdefined(param_00["loadoutEquipment"]) && param_00["loadoutEquipment"] == "none")
	{
		var_01 = var_01 + 1;
	}

	if(isdefined(param_00["loadoutOffhand"]) && param_00["loadoutOffhand"] == "none")
	{
		var_01 = var_01 + 1;
	}

	return var_01;
}

//Function Number: 25
bot_loadout_valid_choice(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	switch(param_02)
	{
		case "loadoutPrimary":
			var_04 = func_8FFE("weapon",param_03);
			break;

		case "loadoutOffhand":
		case "loadoutEquipment":
			var_04 = func_8FFE("equipment",param_03);
			break;

		case "loadoutPrimaryBuff":
			var_04 = maps\mp\gametypes\_class::func_49AE(param_03,param_01["loadoutPrimary"]);
			break;

		case "loadoutPrimaryAttachment":
			var_04 = bot_validate_weapon(param_01["loadoutPrimary"],param_03,"none");
			break;

		case "loadoutPrimaryAttachment2":
			var_04 = bot_validate_weapon(param_01["loadoutPrimary"],param_01["loadoutPrimaryAttachment"],param_03);
			break;

		case "loadoutPrimaryAttachment3":
			var_04 = bot_validate_weapon(param_01["loadoutPrimary"],param_01["loadoutPrimaryAttachment"],param_01["loadoutPrimaryAttachment2"],param_03);
			break;

		case "loadoutPrimaryReticle":
			var_04 = bot_validate_reticle("loadoutPrimary",param_01,param_03);
			break;

		case "loadoutPrimaryCamo":
			var_04 = !isdefined(self.botloadoutfavoritecamo) || param_03 == self.botloadoutfavoritecamo;
			break;

		case "loadoutSecondary":
			var_04 = param_03 != param_01["loadoutPrimary"];
			var_04 = var_04 && func_8FFE("weapon",param_03);
			break;

		case "loadoutSecondaryBuff":
			var_04 = maps\mp\gametypes\_class::func_49AE(param_03,param_01["loadoutSecondary"]);
			break;

		case "loadoutSecondaryAttachment":
			var_04 = bot_validate_weapon(param_01["loadoutSecondary"],param_03,"none");
			break;

		case "loadoutSecondaryAttachment2":
			var_04 = bot_validate_weapon(param_01["loadoutSecondary"],param_01["loadoutSecondaryAttachment"],param_03);
			break;

		case "loadoutSecondaryAttachment3":
			var_04 = bot_validate_weapon(param_01["loadoutSecondary"],param_01["loadoutSecondaryAttachment"],param_01["loadoutSecondaryAttachment2"],param_03);
			break;

		case "loadoutSecondaryReticle":
			var_04 = bot_validate_reticle("loadoutSecondary",param_01,param_03);
			break;

		case "loadoutSecondaryCamo":
			var_04 = !isdefined(self.botloadoutfavoritecamo) || param_03 == self.botloadoutfavoritecamo;
			break;

		case "loadoutStreak3":
		case "loadoutStreak2":
		case "loadoutStreak1":
			var_04 = maps/mp/bots/_bots_ks::bot_killstreak_is_valid_internal(param_03,"bots",undefined,param_01["loadoutStreakType"]);
			var_04 = var_04 && func_8FFE("killstreak",param_03,param_01["loadoutStreakType"]);
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
			var_04 = bot_validate_perk(param_03,param_02,param_01,1,12,func_1628(param_01));
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
				var_04 = bot_validate_perk(param_03,param_02,param_01,-1,-1);
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
				var_04 = bot_validate_perk(param_03,param_02,param_01,16,23,8);
			}
			break;
	}

	return var_04;
}

//Function Number: 26
bot_loadout_choose_from_set(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	var_06 = undefined;
	var_07 = 0;
	if(common_scripts\utility::array_contains(param_00,"specialty_null"))
	{
		var_05 = "specialty_null";
	}

	foreach(var_09 in param_00)
	{
		var_0A = undefined;
		if(getsubstr(var_09,0,9) == "template_")
		{
			var_0A = var_09;
			var_0B = level.botloadouttemplates[var_09][param_03];
			var_09 = bot_loadout_choose_from_set(strtok(var_0B,"| "),param_01,param_02,param_03,1);
			if(isdefined(var_0A) && isdefined(self.chosentemplates[var_0A]))
			{
				return var_09;
			}
		}

		if(var_09 == "attachmenttable")
		{
			return bot_loadout_choose_from_attachmenttable(param_01,param_02,param_03,self.personality,self.difficulty);
		}

		if(var_09 == "weap_statstable")
		{
			return func_1623(param_01,param_02,param_03,self.personality,self.difficulty);
		}

		if(var_09 == "camotable")
		{
			return bot_loadout_choose_from_camotable(param_01,param_02,param_03,self.personality,self.difficulty);
		}

		if(getsubstr(var_09,0,5) == "class" && int(getsubstr(var_09,5,6)) > 0)
		{
			var_09 = func_1620(var_09,param_01,param_02,param_03,self.personality,self.difficulty);
		}

		if(isdefined(level.bot_perktable) && getsubstr(var_09,0,10) == "perktable_")
		{
			return bot_loadout_choose_from_perktable(var_09,param_01,param_02,param_03,self.personality,self.difficulty);
		}

		if(bot_loadout_valid_choice(param_01,param_02,param_03,var_09))
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
		self.chosentemplates[var_06] = 1;
	}

	return var_05;
}

//Function Number: 27
func_1624(param_00)
{
	self.chosentemplates = [];
	foreach(var_06, var_02 in param_00)
	{
		var_03 = strtok(var_02,"| ");
		var_04 = bot_loadout_choose_from_set(var_03,var_02,param_00,var_06);
		param_00[var_06] = var_04;
	}

	return param_00;
}

//Function Number: 28
func_161E(param_00)
{
	var_01 = "recruit";
	for(var_02 = 18;var_02 >= 0;var_02--)
	{
		var_03 = int(tablelookupbyrow("mp/squadEloTable.csv",var_02,0));
		if(param_00 >= var_03 || var_02 == 0)
		{
			return tablelookupbyrow("mp/squadEloTable.csv",var_02,self.pers["squadSlot"] + 1);
		}
	}

	return var_01;
}

//Function Number: 29
bot_loadout_get_difficulty()
{
	var_00 = "regular";
	if(getdvar("squad_match") == "1")
	{
		var_00 = func_161E(getsquadassaultelo());
	}
	else
	{
		var_00 = self botgetdifficulty();
		if(var_00 == "default")
		{
			maps/mp/bots/_bots_util::bot_set_difficulty("default");
			var_00 = self botgetdifficulty();
		}
	}

	return var_00;
}

//Function Number: 30
func_1625()
{
	while(!isdefined(level.bot_loadouts_initialized))
	{
		wait(0.05);
	}

	while(!isdefined(self.personality))
	{
		wait(0.05);
	}

	var_00 = [];
	var_01 = bot_loadout_get_difficulty();
	self.difficulty = var_01;
	var_02 = self botgetpersonality();
	if(getdvar("squad_match") == "1")
	{
		var_00 = bot_loadout_setup_squad_match(var_00);
		var_02 = self botgetpersonality();
	}
	else if(getdvar("squad_vs_squad") == "1")
	{
		var_00 = func_8FFF(var_00);
		var_02 = self botgetpersonality();
	}
	else if(getdvar("squad_use_hosts_squad") == "1" && level.wargame_client.team == self.team)
	{
		var_00 = func_9000(var_00);
		var_02 = self botgetpersonality();
	}
	else
	{
		if(isdefined(self.botlastloadout))
		{
			var_03 = self.botlastloadoutdifficulty == var_01;
			var_04 = self.botlastloadoutpersonality == var_02;
			if(var_03 && var_04 && !isdefined(self.hasdied) || self.hasdied && !isdefined(self.respawn_with_launcher))
			{
				return self.botlastloadout;
			}
		}

		var_00 = bot_loadout_pick(var_02,var_01);
		var_00 = func_1624(var_00);
		if(isdefined(level.bot_funcs["gametype_loadout_modify"]))
		{
			var_00 = self [[ level.bot_funcs["gametype_loadout_modify"] ]](var_00);
		}

		if(var_00["loadoutPrimary"] == "none")
		{
			self.bot_fallback_personality = undefined;
			var_00["loadoutPrimary"] = func_8FFD(var_00);
			var_00["loadoutPrimaryCamo"] = "none";
			var_00["loadoutPrimaryAttachment"] = "none";
			var_00["loadoutPrimaryAttachment2"] = "none";
			var_00["loadoutPrimaryAttachment3"] = "none";
			var_00["loadoutPrimaryReticle"] = "none";
			if(isdefined(self.bot_fallback_personality))
			{
				if(self.bot_fallback_personality == "weapon")
				{
					func_9005(var_00["loadoutPrimary"]);
				}
				else
				{
					maps/mp/bots/_bots_util::bot_set_personality(self.bot_fallback_personality);
				}

				var_02 = self.personality;
				self.bot_fallback_personality = undefined;
			}
		}

		self.botlastloadout = var_00;
		self.botlastloadoutdifficulty = var_01;
		self.botlastloadoutpersonality = var_02;
		if(isdefined(var_00["loadoutPrimaryCamo"]) && var_00["loadoutPrimaryCamo"] != "none")
		{
			self.botloadoutfavoritecamo = var_00["loadoutPrimaryCamo"];
		}

		if(isdefined(self.respawn_with_launcher))
		{
			if(isdefined(level.bot_respawn_launcher_name) && func_8FFE("weapon",level.bot_respawn_launcher_name))
			{
				var_00["loadoutSecondary"] = level.bot_respawn_launcher_name;
				var_00["loadoutSecondaryAttachment"] = "none";
				var_00["loadoutSecondaryAttachment2"] = "none";
				self.botlastloadout = undefined;
			}

			self.respawn_with_launcher = undefined;
		}
	}

	var_00 = bot_loadout_setup_perks(var_00);
	maps\mp\gametypes\_class::func_49A1(var_00["loadoutStreak1"]);
	maps\mp\gametypes\_class::func_49A1(var_00["loadoutStreak2"]);
	maps\mp\gametypes\_class::func_49A1(var_00["loadoutStreak3"]);
	if(maps\mp\_utility::func_8FFB())
	{
		if(common_scripts\utility::array_contains(self.pers["loadoutPerks"],"specialty_twoprimaries"))
		{
			var_05 = bot_loadout_pick("cqb",var_01);
			var_00["loadoutSecondary"] = var_05["loadoutPrimary"];
			var_00["loadoutSecondaryAttachment"] = var_05["loadoutPrimaryAttachment"];
			var_00["loadoutSecondaryAttachment2"] = var_05["loadoutPrimaryAttachment2"];
			var_00 = func_1624(var_00);
			var_00 = bot_loadout_setup_perks(var_00);
		}

		if(common_scripts\utility::array_contains(self.pers["loadoutPerks"],"specialty_extra_attachment"))
		{
			var_06 = bot_loadout_pick(var_02,var_01);
			var_00["loadoutPrimaryAttachment3"] = var_06["loadoutPrimaryAttachment2"];
			if(common_scripts\utility::array_contains(self.pers["loadoutPerks"],"specialty_twoprimaries"))
			{
				var_00["loadoutSecondaryAttachment2"] = var_06["loadoutPrimaryAttachment2"];
			}
			else
			{
				var_00["loadoutSecondaryAttachment2"] = var_06["loadoutSecondaryAttachment2"];
			}

			var_00 = func_1624(var_00);
			var_00 = bot_loadout_setup_perks(var_00);
		}
		else
		{
			var_00["loadoutSecondaryAttachment2"] = "none";
			if(!bot_validate_reticle("loadoutSecondary",var_00,var_00["loadoutSecondaryReticle"]))
			{
				var_00["loadoutSecondaryReticle"] = "none";
			}
		}
	}

	return var_00;
}

//Function Number: 31
bot_loadout_setup_perks(param_00)
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

			var_06 = maps\mp\_utility::getbaseperkname(var_04);
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

				self.pers["specialistStreakKills"][self.pers["specialistStreakKills"].size] = var_07 + bot_perk_cost(var_06) + 2;
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

//Function Number: 32
func_1691()
{
	var_00 = self botgetpersonality();
	var_01 = bot_loadout_get_difficulty();
	var_02 = bot_loadout_set(var_00,var_01,0);
	if(isdefined(var_02) && isdefined(var_02.loadouts) && var_02.loadouts.size > 0)
	{
		self.classcallback = ::func_1625;
		return 1;
	}

	var_03 = getsubstr(self.name,0,self.name.size - 10);
	self.classcallback = undefined;
	return 0;
}

//Function Number: 33
func_169F(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_06))
	{
		return param_00 getprivateplayerdata("privateMatchSquadMembers",param_01,"loadouts",param_02,param_03,param_04,param_05,param_06);
	}

	if(isdefined(param_05))
	{
		return param_00 getprivateplayerdata("privateMatchSquadMembers",param_01,"loadouts",param_02,param_03,param_04,param_05);
	}

	if(isdefined(param_04))
	{
		return param_00 getprivateplayerdata("privateMatchSquadMembers",param_01,"loadouts",param_02,param_03,param_04);
	}

	return param_00 getprivateplayerdata("privateMatchSquadMembers",param_01,"loadouts",param_02,param_03);
}

//Function Number: 34
bot_squad_lookup_ranked(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_06))
	{
		return param_00 getrankedplayerdata("squadMembers",param_01,"loadouts",param_02,param_03,param_04,param_05,param_06);
	}

	if(isdefined(param_05))
	{
		return param_00 getrankedplayerdata("squadMembers",param_01,"loadouts",param_02,param_03,param_04,param_05);
	}

	if(isdefined(param_04))
	{
		return param_00 getrankedplayerdata("squadMembers",param_01,"loadouts",param_02,param_03,param_04);
	}

	return param_00 getrankedplayerdata("squadMembers",param_01,"loadouts",param_02,param_03);
}

//Function Number: 35
bot_squad_lookup_enemy(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_06))
	{
		return getenemysquaddata("squadMembers",param_01,"loadouts",param_02,param_03,param_04,param_05,param_06);
	}

	if(isdefined(param_05))
	{
		return getenemysquaddata("squadMembers",param_01,"loadouts",param_02,param_03,param_04,param_05);
	}

	if(isdefined(param_04))
	{
		return getenemysquaddata("squadMembers",param_01,"loadouts",param_02,param_03,param_04);
	}

	return getenemysquaddata("squadMembers",param_01,"loadouts",param_02,param_03);
}

//Function Number: 36
bot_squad_lookup(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = ::bot_squad_lookup_ranked;
	if(getdvar("squad_match") == "1" && self.team == "axis")
	{
		var_07 = ::bot_squad_lookup_enemy;
	}
	else if(!maps\mp\_utility::func_50C1())
	{
		var_07 = ::func_169F;
	}

	return self [[ var_07 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 37
bot_squadmember_lookup(param_00,param_01,param_02)
{
	if(getdvar("squad_match") == "1" && self.team == "axis")
	{
		return getenemysquaddata("squadMembers",param_01,param_02);
	}

	if(!maps\mp\_utility::func_50C1())
	{
		return param_00 getprivateplayerdata("privateMatchSquadMembers",param_01,param_02);
	}

	return param_00 getrankedplayerdata("squadMembers",param_01,param_02);
}

//Function Number: 38
bot_loadout_copy_from_client(param_00,param_01,param_02,param_03)
{
	param_00["loadoutPrimary"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",0,"weapon");
	param_00["loadoutPrimaryAttachment"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",0,"attachment",0);
	param_00["loadoutPrimaryAttachment2"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",0,"attachment",1);
	param_00["loadoutPrimaryAttachment3"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",0,"attachment",2);
	param_00["loadoutPrimaryBuff"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",0,"buff");
	param_00["loadoutPrimaryCamo"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",0,"camo");
	param_00["loadoutPrimaryReticle"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",0,"reticle");
	param_00["loadoutSecondary"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",1,"weapon");
	param_00["loadoutSecondaryAttachment"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",1,"attachment",0);
	param_00["loadoutSecondaryAttachment2"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",1,"attachment",1);
	param_00["loadoutSecondaryBuff"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",1,"buff");
	param_00["loadoutSecondaryCamo"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",1,"camo");
	param_00["loadoutSecondaryReticle"] = bot_squad_lookup(param_01,param_02,param_03,"weaponSetups",1,"reticle");
	param_00["loadoutEquipment"] = bot_squad_lookup(param_01,param_02,param_03,"perks",0);
	param_00["loadoutOffhand"] = bot_squad_lookup(param_01,param_02,param_03,"perks",1);
	param_00["loadoutStreak1"] = "none";
	param_00["loadoutStreak2"] = "none";
	param_00["loadoutStreak3"] = "none";
	var_04 = bot_squad_lookup(param_01,param_02,param_03,"perks",5);
	if(isdefined(var_04))
	{
		param_00["loadoutStreakType"] = var_04;
		if(var_04 == "streaktype_assault")
		{
			param_00["loadoutStreak1"] = bot_squad_lookup(param_01,param_02,param_03,"assaultStreaks",0);
			param_00["loadoutStreak2"] = bot_squad_lookup(param_01,param_02,param_03,"assaultStreaks",1);
			param_00["loadoutStreak3"] = bot_squad_lookup(param_01,param_02,param_03,"assaultStreaks",2);
		}
		else if(var_04 == "streaktype_support")
		{
			param_00["loadoutStreak1"] = bot_squad_lookup(param_01,param_02,param_03,"supportStreaks",0);
			param_00["loadoutStreak2"] = bot_squad_lookup(param_01,param_02,param_03,"supportStreaks",1);
			param_00["loadoutStreak3"] = bot_squad_lookup(param_01,param_02,param_03,"supportStreaks",2);
		}
		else if(var_04 == "streaktype_specialist")
		{
			param_00["loadoutPerk13"] = bot_squad_lookup(param_01,param_02,param_03,"specialistStreaks",0);
			param_00["loadoutPerk14"] = bot_squad_lookup(param_01,param_02,param_03,"specialistStreaks",1);
			param_00["loadoutPerk15"] = bot_squad_lookup(param_01,param_02,param_03,"specialistStreaks",2);
		}
	}

	var_05 = 1;
	var_06 = maps\mp\gametypes\_class::getnumabilitycategories();
	var_07 = maps\mp\gametypes\_class::getnumsubability();
	for(var_08 = 0;var_08 < var_06;var_08++)
	{
		for(var_09 = 0;var_09 < var_07;var_09++)
		{
			var_0A = bot_squad_lookup(param_01,param_02,param_03,"abilitiesPicked",var_08,var_09);
			if(isdefined(var_0A) && var_0A)
			{
				var_0B = tablelookup("mp/cacAbilityTable.csv",0,var_08 + 1,4 + var_09);
				param_00["loadoutPerk" + var_05] = var_0B;
				var_05++;
				continue;
			}

			param_00["loadoutPerk" + var_05] = "specialty_null";
		}
	}

	var_05 = 16;
	for(var_08 = 0;var_08 < var_06;var_08++)
	{
		for(var_09 = 0;var_09 < var_07;var_09++)
		{
			var_0A = bot_squad_lookup(param_01,param_02,param_03,"specialistBonusStreaks",var_08,var_09);
			if(isdefined(var_0A) && var_0A)
			{
				var_0B = tablelookup("mp/cacAbilityTable.csv",0,var_08 + 1,4 + var_09);
				param_00["loadoutPerk" + var_05] = var_0B;
				var_05++;
				continue;
			}

			param_00["loadoutPerk" + var_05] = "specialty_null";
		}
	}

	param_00["loadoutCharacterType"] = bot_squad_lookup(param_01,param_02,param_03,"type");
	func_9005(param_00["loadoutPrimary"]);
	self.playercardpatch = bot_squadmember_lookup(param_01,param_02,"patch");
	self.playercardbackground = bot_squadmember_lookup(param_01,param_02,"background");
	if(getdvar("squad_match") == "1" && self.team == "axis")
	{
		self.squad_bot_dog_type = getenemysquaddogtype();
	}
	else
	{
		self.squad_bot_dog_type = param_01 getcommonplayerdatareservedint("mp_dog_type");
	}

	return param_00;
}

//Function Number: 39
bot_loadout_setup_squad_match(param_00)
{
	var_01 = level.players[0];
	foreach(var_03 in level.players)
	{
		if(!isai(var_03) && isplayer(var_03))
		{
			var_01 = var_03;
			break;
		}
	}

	var_05 = self.pers["squadSlot"];
	var_06 = bot_squadmember_lookup(var_01,var_05,"ai_loadout");
	self.pers["rankxp"] = bot_squadmember_lookup(var_01,var_05,"squadMemXP");
	if(self.team == "allies")
	{
		if(isdefined(var_01))
		{
			var_07 = var_01 getrankedplayerdatareservedint("prestigeLevel");
			self.pers["prestige_fake"] = var_07;
		}
	}
	else if(self.team == "axis")
	{
		self.pers["prestige_fake"] = getsquadassaultenemyprestige();
	}

	param_00 = bot_loadout_copy_from_client(param_00,var_01,var_05,var_06);
	return param_00;
}

//Function Number: 40
func_8FFF(param_00)
{
	var_01 = level.squad_vs_squad_allies_client;
	if(self.team == "axis")
	{
		var_01 = level.squad_vs_squad_axis_client;
	}

	var_02 = self.pers["squadSlot"];
	var_03 = bot_squadmember_lookup(var_01,var_02,"ai_loadout");
	self.pers["rankxp"] = bot_squadmember_lookup(var_01,var_02,"squadMemXP");
	if(isdefined(var_01))
	{
		var_04 = var_01 getrankedplayerdatareservedint("prestigeLevel");
		self.pers["prestige_fake"] = var_04;
	}

	param_00 = bot_loadout_copy_from_client(param_00,var_01,var_02,var_03);
	return param_00;
}

//Function Number: 41
func_9000(param_00)
{
	var_01 = level.wargame_client;
	var_02 = self.pers["squadSlot"];
	var_03 = bot_squadmember_lookup(var_01,var_02,"ai_loadout");
	self.pers["rankxp"] = bot_squadmember_lookup(var_01,var_02,"squadMemXP");
	if(isdefined(var_01))
	{
		var_04 = var_01 getrankedplayerdatareservedint("prestigeLevel");
		self.pers["prestige_fake"] = var_04;
	}

	param_00 = bot_loadout_copy_from_client(param_00,var_01,var_02,var_03);
	return param_00;
}