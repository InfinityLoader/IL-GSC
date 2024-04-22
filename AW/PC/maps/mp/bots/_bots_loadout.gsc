/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\bots\_bots_loadout.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 545 ms
 * Timestamp: 4/22/2024 2:08:52 AM
*******************************************************************/

//Function Number: 1
init()
{
	init_template_table();
	init_class_table();
	init_bot_attachmenttable();
	init_bot_weap_statstable();
	init_bot_reticletable();
	init_bot_camotable();
	level.bot_min_rank_for_item = [];
	level.bot_loadouts_initialized = 1;
}

//Function Number: 2
init_class_table()
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
init_template_table()
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
bot_custom_classes_allowed()
{
	if(isusingmatchrulesdata() && !getmatchrulesdata("commonOption","allowCustomClasses"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
bot_loadout_item_allowed(param_00,param_01,param_02)
{
	if(!isusingmatchrulesdata())
	{
		return 1;
	}

	if(!bot_custom_classes_allowed())
	{
		return 0;
	}

	if(param_01 == "specialty_null")
	{
		return 1;
	}

	if(param_01 == "none")
	{
		return 1;
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
			if(getmatchrulesdata("commonOption","allStreaksRestricted"))
			{
				return 0;
			}
			break;

		case "module":
			var_05 = maps\mp\killstreaks\_killstreaks::getstreakmodulebasekillstreak(param_01);
			if(getsubstr(var_05,0,3) == "zm_")
			{
				return 0;
			}
			break;

		case "perk":
			var_05 = param_02;
			break;

		default:
			return 0;
	}

	if(getmatchrulesdata("commonOption",var_03,param_01))
	{
		return 0;
	}

	if(var_05 != "" && getmatchrulesdata("commonOption",var_04,var_05))
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
bot_loadout_choose_fallback_primary(param_00)
{
	var_01 = "none";
	var_02 = ["veteran","hardened","regular","recruit"];
	var_02 = common_scripts\utility::array_randomize(var_02);
	foreach(var_04 in var_02)
	{
		var_01 = bot_loadout_choose_from_statstable("weap_statstable",param_00,"loadoutPrimary",self.personality,var_04);
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
				var_01 = bot_loadout_choose_from_statstable("weap_statstable",param_00,"loadoutPrimary",var_08,var_04);
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
		var_0C = 0;
		var_0D = 0;
		var_0E = "none";
		while(var_0D < 6)
		{
			if(getmatchrulesdata("defaultClasses",bot_loadout_team(),var_0D,"class","inUse"))
			{
				var_01 = bot_loadout_choose_from_custom_default_class(var_0D,"loadoutPrimary");
				if(var_01 != "none")
				{
					var_0C = var_0C + 1;
					if(randomfloat(1) >= 1 / var_0C)
					{
						var_0E = var_01;
					}
				}
			}

			var_0D++;
		}

		if(var_0E != "none")
		{
			self.bot_fallback_personality = "weapon";
			return var_0E;
		}
	}

	self.bot_fallback_personality = "weapon";
	return level.bot_fallback_weapon;
}

//Function Number: 7
bot_loadout_team()
{
	if(!isdefined(level.teambased) || !level.teambased)
	{
		return "allies";
	}

	return maps\mp\bots\_bots::bot_get_player_team();
}

//Function Number: 8
bot_default_class_random()
{
	var_00 = ["class1","class2","class3","class4","class5"];
	if(isusingmatchrulesdata())
	{
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			if(getmatchrulesdata("defaultClasses",bot_loadout_team(),var_01,"class","inUse"))
			{
				var_00[var_01] = var_01;
			}
		}
	}

	var_02 = common_scripts\utility::random(var_00);
	var_03 = [];
	foreach(var_05 in level.bot_loadout_fields)
	{
		if(isstring(var_02))
		{
			var_03[var_05] = bot_loadout_choose_from_default_class(var_02,var_05);
			continue;
		}

		var_03[var_05] = bot_loadout_choose_from_custom_default_class(var_02,var_05);
	}

	return var_03;
}

//Function Number: 9
bot_pick_personality_from_weapon(param_00)
{
	if(isdefined(param_00))
	{
		var_01 = level.bot_weap_personality[param_00];
		if(isdefined(var_01))
		{
			var_02 = strtok(var_01,"| ");
			if(var_02.size > 0)
			{
				maps\mp\bots\_bots_util::bot_set_personality(common_scripts\utility::random(var_02));
				return;
			}
		}
	}
}

//Function Number: 10
bot_loadout_set_has_wildcard(param_00,param_01)
{
	if(param_00["loadoutWildcard1"] == param_01)
	{
		return 1;
	}

	if(param_00["loadoutWildcard2"] == param_01)
	{
		return 1;
	}

	if(param_00["loadoutWildcard3"] == param_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 11
bot_loadout_fields()
{
	var_00 = "mp/botClassTable.csv";
	if(!isdefined(level.bot_loadout_fields))
	{
		level.bot_loadout_fields = [];
		level.bot_loadout_fields[0] = "loadoutWildcard1";
		level.bot_loadout_fields[1] = "loadoutWildcard2";
		level.bot_loadout_fields[2] = "loadoutWildcard3";
		var_01 = 2;
		for(;;)
		{
			var_02 = tablelookupbyrow(var_00,var_01,0);
			if(var_02 == "")
			{
				break;
			}

			if(!issubstr(var_02,"Wildcard"))
			{
				level.bot_loadout_fields[level.bot_loadout_fields.size] = var_02;
			}

			var_01++;
		}
	}

	return level.bot_loadout_fields;
}

//Function Number: 12
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

//Function Number: 13
bot_loadout_pick(param_00,param_01)
{
	var_02 = bot_loadout_set(param_00,param_01,0);
	if(isdefined(var_02) && isdefined(var_02.loadouts) && var_02.loadouts.size > 0)
	{
		var_03 = randomint(var_02.loadouts.size);
		return var_02.loadouts[var_03].loadoutvalues;
	}
}

//Function Number: 14
bot_validate_weapon(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_05 = 0;
	if(isdefined(level.bot_weap_built_in_attachments[param_00]) && level.bot_weap_built_in_attachments[param_00] != "none")
	{
		var_04[var_04.size] = level.bot_weap_built_in_attachments[param_00];
		var_05++;
	}

	if(isdefined(param_01) && param_01 != "none")
	{
		var_04[var_04.size] = param_01;
	}

	if(isdefined(param_02) && param_02 != "none")
	{
		var_04[var_04.size] = param_02;
	}

	if(isdefined(param_03) && param_03 != "none")
	{
		var_04[var_04.size] = param_03;
	}

	var_06 = maps\mp\_utility::getweaponattachmentarrayfromstats(param_00);
	for(var_07 = var_05;var_07 < var_04.size;var_07++)
	{
		var_08 = maps\mp\_utility::attachmentmap_tobase(var_04[var_07]);
		if(var_08 != var_04[var_07])
		{
			return 0;
		}

		if(!bot_loadout_item_allowed("attachment",var_04[var_07],undefined))
		{
			return 0;
		}

		if(!common_scripts\utility::array_contains(var_06,var_04[var_07]))
		{
			return 0;
		}

		var_09 = 0;
		for(var_0A = var_07 - 1;var_0A >= 0;var_0A--)
		{
			if(var_04[var_07] == var_04[var_0A])
			{
				var_09++;
				if(var_09 == 1)
				{
					if(!isdefined(level.allowable_double_attachments[var_04[var_07]]))
					{
						return 0;
					}
				}
				else if(var_09 > 1)
				{
					return 0;
				}

				continue;
			}

			if(isdefined(level.bot_invalid_attachment_combos[var_04[var_07]]))
			{
				if(isdefined(level.bot_invalid_attachment_combos[var_04[var_07]][var_04[var_0A]]))
				{
					return 0;
				}
			}
		}
	}

	return 1;
}

//Function Number: 15
bot_validate_reticle(param_00,param_01,param_02)
{
	if(!maps\mp\gametypes\_class::isvalidreticle(param_02,1))
	{
		return 0;
	}

	var_03 = ["Attachment","Attachment2","Attachment3"];
	foreach(var_05 in var_03)
	{
		var_06 = param_00 + var_05;
		var_07 = param_01[var_06];
		if(isdefined(var_07) && isdefined(level.bot_attachment_reticle[var_07]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 16
init_bot_weap_statstable()
{
	var_00 = "mp/statstable.csv";
	var_01 = 4;
	var_02 = 57;
	var_03 = 58;
	var_04 = 40;
	level.bot_weap_statstable = [];
	level.bot_weap_personality = [];
	level.bot_weap_built_in_attachments = [];
	level.bot_weap_personality["iw5_combatknife"] = "cqb";
	var_05 = 1;
	for(;;)
	{
		var_06 = tablelookupbyrow(var_00,var_05,0);
		if(var_06 == "")
		{
			break;
		}

		var_07 = tablelookupbyrow(var_00,var_05,var_01);
		var_08 = tablelookupbyrow(var_00,var_05,var_03);
		var_09 = tablelookupbyrow(var_00,var_05,var_02);
		if(var_07 != "" && var_09 != "")
		{
			level.bot_weap_personality[var_07] = var_09;
		}

		if(var_08 != "" && var_07 != "" && var_09 != "")
		{
			var_0A = var_07;
			if(maps\mp\_utility::islootweapon(var_07))
			{
				var_0A = maps\mp\gametypes\_class::getbasefromlootversion(var_07);
			}

			var_0B = "loadoutPrimary";
			if(maps\mp\gametypes\_class::isvalidsecondary(var_0A,0))
			{
				var_0B = "loadoutSecondary";
			}
			else if(!maps\mp\gametypes\_class::isvalidprimary(var_0A))
			{
				var_05++;
				continue;
			}

			if(!isdefined(level.bot_weap_statstable[var_0B]))
			{
				level.bot_weap_statstable[var_0B] = [];
			}

			var_11 = strtok(var_09,"| ");
			var_12 = strtok(var_08,"| ");
			foreach(var_14 in var_11)
			{
				if(!isdefined(level.bot_weap_statstable[var_0B][var_14]))
				{
					level.bot_weap_statstable[var_0B][var_14] = [];
				}

				foreach(var_16 in var_12)
				{
					if(!isdefined(level.bot_weap_statstable[var_0B][var_14][var_16]))
					{
						level.bot_weap_statstable[var_0B][var_14][var_16] = [];
					}

					var_17 = level.bot_weap_statstable[var_0B][var_14][var_16].size;
					level.bot_weap_statstable[var_0B][var_14][var_16][var_17] = var_07;
				}
			}

			var_1A = tablelookupbyrow(var_00,var_05,var_04);
			if(var_1A != "")
			{
				level.bot_weap_built_in_attachments[var_07] = var_1A;
			}
		}

		var_05++;
	}
}

//Function Number: 17
bot_loadout_choose_from_statstable(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	if(param_03 == "default")
	{
		param_03 = "run_and_gun";
	}

	var_06 = param_02;
	if(var_06 == "loadoutSecondary" && bot_loadout_set_has_wildcard(param_01,"specialty_wildcard_dualprimaries"))
	{
		var_06 = "loadoutPrimary";
		if(param_03 == "camper" || param_03 == "run_and_gun")
		{
			param_03 = "cqb";
		}
		else if(param_03 == "cqb")
		{
			param_03 = "run_and_gun";
		}
	}

	if(!isdefined(level.bot_weap_statstable))
	{
		return var_05;
	}

	if(!isdefined(level.bot_weap_statstable[var_06]))
	{
		return var_05;
	}

	if(!isdefined(level.bot_weap_statstable[var_06][param_03]))
	{
		return var_05;
	}

	if(!isdefined(level.bot_weap_statstable[var_06][param_03][param_04]))
	{
		return var_05;
	}

	var_05 = bot_loadout_choose_from_set(level.bot_weap_statstable[var_06][param_03][param_04],param_00,param_01,param_02);
	return var_05;
}

//Function Number: 18
bot_validate_perk(param_00,param_01,param_02)
{
	var_03 = "Perk_Slot1";
	if(param_01 == "loadoutPerk3" || param_01 == "loadoutPerk4")
	{
		var_03 = "Perk_Slot2";
	}
	else if(param_01 == "loadoutPerk5" || param_01 == "loadoutPerk6")
	{
		var_03 = "Perk_Slot3";
	}

	if(!bot_loadout_item_allowed("perk",param_00,var_03))
	{
		return 0;
	}

	var_04 = int(getsubstr(param_01,11));
	var_05 = "";
	if(var_04 == 2)
	{
		var_05 = "specialty_wildcard_perkslot1";
	}
	else if(var_04 == 4)
	{
		var_05 = "specialty_wildcard_perkslot2";
	}
	else if(var_04 == 6)
	{
		var_05 = "specialty_wildcard_perkslot3";
	}

	if(var_05 != "")
	{
		if(!bot_loadout_set_has_wildcard(param_02,var_05))
		{
			return 0;
		}
	}

	for(var_06 = var_04 - 1;var_06 > 0;var_06--)
	{
		var_07 = "loadoutPerk" + var_06;
		if(param_02[var_07] == "none" || param_02[var_07] == "specialty_null")
		{
			continue;
		}

		if(param_00 == param_02[var_07])
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 19
bot_loadout_choose_from_default_class(param_00,param_01)
{
	var_02 = int(getsubstr(param_00,5,6)) - 1;
	switch(param_01)
	{
		case "loadoutPrimary":
			return maps\mp\gametypes\_class::table_getweapon(level.classtablename,var_02,0);

		case "loadoutPrimaryAttachment":
			return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename,var_02,0,0);

		case "loadoutPrimaryAttachment2":
			return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename,var_02,0,1);

		case "loadoutPrimaryAttachment3":
			return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename,var_02,0,2);

		case "loadoutPrimaryCamo":
			return maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename,var_02,0);

		case "loadoutPrimaryReticle":
			return maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename,var_02,0);

		case "loadoutSecondary":
			return maps\mp\gametypes\_class::table_getweapon(level.classtablename,var_02,1);

		case "loadoutSecondaryAttachment":
			return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename,var_02,1,0);

		case "loadoutSecondaryAttachment2":
			return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename,var_02,1,1);

		case "loadoutSecondaryAttachment3":
			return maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename,var_02,1,2);

		case "loadoutSecondaryCamo":
			return maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename,var_02,1);

		case "loadoutSecondaryReticle":
			return maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename,var_02,1);

		case "loadoutEquipment":
			return maps\mp\gametypes\_class::table_getequipment(level.classtablename,var_02);

		case "loadoutEquipment2":
			return tablelookup(level.classtablename,0,"loadoutEquipment2",var_02 + 1);

		case "loadoutOffhand":
			return maps\mp\gametypes\_class::table_getoffhand(level.classtablename,var_02);

		case "loadoutOffhand2":
			if(maps\mp\gametypes\_class::table_getoffhandextra(level.classtablename,var_02))
			{
				return maps\mp\gametypes\_class::table_getoffhand(level.classtablename,var_02);
			}
			else
			{
				return "specialty_null";
			}
	
			break;

		case "loadoutStreak1":
			return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename,var_02,0);

		case "loadoutStreakModule1a":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,0,0);

		case "loadoutStreakModule1b":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,0,1);

		case "loadoutStreakModule1c":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,0,2);

		case "loadoutStreak2":
			return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename,var_02,1);

		case "loadoutStreakModule2a":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,1,0);

		case "loadoutStreakModule2b":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,1,1);

		case "loadoutStreakModule2c":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,1,2);

		case "loadoutStreak3":
			return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename,var_02,2);

		case "loadoutStreakModule3a":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,2,0);

		case "loadoutStreakModule3b":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,2,1);

		case "loadoutStreakModule3c":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,2,2);

		case "loadoutStreak4":
			return maps\mp\gametypes\_class::table_getkillstreak(level.classtablename,var_02,3);

		case "loadoutStreakModule4a":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,3,0);

		case "loadoutStreakModule4b":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,3,1);

		case "loadoutStreakModule4c":
			return maps\mp\gametypes\_class::table_getkillstreakmodule(level.classtablename,var_02,3,2);

		case "loadoutPerk2":
		case "loadoutPerk1":
		case "loadoutPerk6":
		case "loadoutPerk5":
		case "loadoutPerk4":
		case "loadoutPerk3":
			var_03 = int(getsubstr(param_01,11)) - 1;
			var_04 = maps\mp\gametypes\_class::table_getperk(level.classtablename,var_02,var_03);
			if(var_04 == "")
			{
				return "specialty_null";
			}
			return var_04;

		case "loadoutWildcard1":
			return maps\mp\gametypes\_class::table_getwildcard(level.classtablename,var_04,0);

		case "loadoutWildcard2":
			return maps\mp\gametypes\_class::table_getwildcard(level.classtablename,var_04,1);

		case "loadoutWildcard3":
			return maps\mp\gametypes\_class::table_getwildcard(level.classtablename,var_04,2);
	}

	return var_02;
}

//Function Number: 20
bot_loadout_choose_from_custom_default_class(param_00,param_01)
{
	var_02 = bot_loadout_team();
	switch(param_01)
	{
		case "loadoutPrimary":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",0,"weapon");

		case "loadoutPrimaryAttachment":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",0,"attachment",0);

		case "loadoutPrimaryAttachment2":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",0,"attachment",1);

		case "loadoutPrimaryAttachment3":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",0,"attachment",2);

		case "loadoutPrimaryCamo":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",0,"camo");

		case "loadoutPrimaryReticle":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",0,"reticle");

		case "loadoutSecondary":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",1,"weapon");

		case "loadoutSecondaryAttachment":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",1,"attachment",0);

		case "loadoutSecondaryAttachment2":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",1,"attachment",1);

		case "loadoutSecondaryAttachment3":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",1,"attachment",2);

		case "loadoutSecondaryCamo":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",1,"camo");

		case "loadoutSecondaryReticle":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","weaponSetups",1,"reticle");

		case "loadoutEquipment":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","equipmentSetups",0,"equipment");

		case "loadoutEquipment2":
			if(getmatchrulesdata("defaultClasses",var_02,param_00,"class","equipmentSetups",0,"extra"))
			{
				return getmatchrulesdata("defaultClasses",var_02,param_00,"class","equipmentSetups",0,"equipment");
			}
			else
			{
				return "specialty_null";
			}
	
			break;

		case "loadoutOffhand":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","equipmentSetups",1,"equipment");

		case "loadoutOffhand2":
			return "specialty_null";

		case "loadoutStreak1":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",0,"streak");

		case "loadoutStreakModule1a":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",0,"modules",0);

		case "loadoutStreakModule1b":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",0,"modules",1);

		case "loadoutStreakModule1c":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",0,"modules",2);

		case "loadoutStreak2":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",1,"streak");

		case "loadoutStreakModule2a":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",1,"modules",0);

		case "loadoutStreakModule2b":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",1,"modules",1);

		case "loadoutStreakModule2c":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",1,"modules",2);

		case "loadoutStreak3":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",2,"streak");

		case "loadoutStreakModule3a":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",2,"modules",0);

		case "loadoutStreakModule3b":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",2,"modules",1);

		case "loadoutStreakModule3c":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",2,"modules",2);

		case "loadoutStreak4":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",3,"streak");

		case "loadoutStreakModule4a":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",3,"modules",0);

		case "loadoutStreakModule4b":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",3,"modules",1);

		case "loadoutStreakModule4c":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","assaultStreaks",3,"modules",2);

		case "loadoutPerk1":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","perkSlots",0);

		case "loadoutPerk2":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","perkSlots",1);

		case "loadoutPerk3":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","perkSlots",2);

		case "loadoutPerk4":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","perkSlots",3);

		case "loadoutPerk5":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","perkSlots",4);

		case "loadoutPerk6":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","perkSlots",5);

		case "loadoutWildcard1":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","wildcardSlots",0);

		case "loadoutWildcard2":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","wildcardSlots",1);

		case "loadoutWildcard3":
			return getmatchrulesdata("defaultClasses",var_02,param_00,"class","wildcardSlots",2);

		default:
			break;
	}

	return "none";
}

//Function Number: 21
init_bot_attachmenttable()
{
	var_00 = "mp/attachmenttable.csv";
	var_01 = 3;
	var_02 = 15;
	var_03 = 7;
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

	level.bot_invalid_attachment_combos = [];
	level.allowable_double_attachments = [];
	var_0D = "mp/attachmentcombos.csv";
	var_0E = 0;
	for(;;)
	{
		var_0E++;
		var_0F = tablelookupbyrow(var_0D,0,var_0E);
		if(var_0F == "")
		{
			break;
		}

		var_04 = 0;
		for(;;)
		{
			var_04++;
			var_10 = tablelookupbyrow(var_0D,var_04,0);
			if(var_10 == "")
			{
				break;
			}

			if(var_10 == var_0F)
			{
				if(tablelookupbyrow(var_0D,var_04,var_0E) != "no")
				{
					level.allowable_double_attachments[var_10] = 1;
				}

				continue;
			}

			if(tablelookupbyrow(var_0D,var_04,var_0E) == "no")
			{
				level.bot_invalid_attachment_combos[var_0F][var_10] = 1;
			}
		}
	}
}

//Function Number: 22
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

//Function Number: 23
init_bot_reticletable()
{
	var_00 = "mp/reticletable.csv";
	var_01 = 1;
	var_02 = 8;
	level.bot_reticletable = [];
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
			level.bot_reticletable[level.bot_reticletable.size] = var_04;
		}

		var_03++;
	}
}

//Function Number: 24
bot_loadout_choose_from_reticletable(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	if(!isdefined(level.bot_reticletable))
	{
		return var_05;
	}

	var_06 = randomint(100) > 50;
	if(var_06)
	{
		var_05 = bot_loadout_choose_from_set(level.bot_reticletable,param_00,param_01,param_02);
	}

	return var_05;
}

//Function Number: 25
init_bot_camotable()
{
	var_00 = "mp/camotable.csv";
	var_01 = 1;
	var_02 = 8;
	var_03 = 9;
	var_04 = 11;
	level.bot_camotable = [];
	var_05 = 0;
	for(;;)
	{
		var_06 = tablelookupbyrow(var_00,var_05,var_01);
		if(!isdefined(var_06) || var_06 == "")
		{
			break;
		}

		var_07 = int(tablelookupbyrow(var_00,var_05,var_04));
		var_08 = tablelookupbyrow(var_00,var_05,var_02);
		if(isdefined(var_08) && var_08 != "" && !var_07)
		{
			var_09 = tablelookupbyrow(var_00,var_05,var_03);
			if(isdefined(var_09) && int(var_09))
			{
				level.bot_camotable[level.bot_camotable.size] = var_06;
			}
		}

		var_05++;
	}
}

//Function Number: 26
bot_loadout_choose_from_camotable(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	if(!isdefined(level.bot_camotable))
	{
		return var_05;
	}

	var_06 = randomint(100) > 50;
	if(var_06)
	{
		var_05 = bot_loadout_choose_from_set(level.bot_camotable,param_00,param_01,param_02);
	}

	return var_05;
}

//Function Number: 27
bot_loadout_item_valid_for_rank(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return 1;
	}

	if(!isdefined(level.bot_min_rank_for_item[param_01]))
	{
		var_03 = "mp/unlockTable.csv";
		var_04 = tablelookuprownum(var_03,0,param_01);
		level.bot_min_rank_for_item[param_01] = int(tablelookupbyrow(var_03,var_04,2));
	}

	if(param_00 == "classtable_any" && param_02 == "recruit")
	{
		return 1;
	}

	if(!isdefined(self.rank_for_items))
	{
		if(param_02 == "recruit")
		{
			self.rank_for_items = 3;
		}
		else
		{
			self.rank_for_items = self.pers["rank"];
			if(!isdefined(self.rank_for_items))
			{
				self.rank_for_items = level.bot_rnd_rank[param_02][0];
			}
		}
	}

	if(level.bot_min_rank_for_item[param_01] <= self.rank_for_items)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
bot_loadout_valid_choice(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	switch(param_02)
	{
		case "loadoutPrimary":
			var_05 = param_03;
			if(maps\mp\_utility::islootweapon(var_05))
			{
				var_05 = maps\mp\gametypes\_class::getbasefromlootversion(var_05);
			}
	
			var_04 = bot_loadout_item_allowed("weapon",var_05,undefined);
			var_04 = var_04 && maps\mp\gametypes\_class::isvalidprimary(param_03);
			break;

		case "loadoutEquipment":
			var_04 = bot_loadout_item_allowed("perk",param_03,"Lethal");
			var_04 = var_04 && maps\mp\gametypes\_class::isvalidequipment(param_03,bot_loadout_set_has_wildcard(param_01,"specialty_wildcard_dualtacticals"));
			var_04 = var_04 && bot_loadout_item_valid_for_rank(param_00,param_03,self botgetdifficulty());
			break;

		case "loadoutEquipment2":
			var_04 = param_03 == "specialty_null" || param_03 == param_01["loadoutEquipment"];
			break;

		case "loadoutOffhand":
			var_04 = bot_loadout_item_allowed("perk",param_03,"Tactical");
			var_04 = var_04 && maps\mp\gametypes\_class::isvalidoffhand(param_03,bot_loadout_set_has_wildcard(param_01,"specialty_wildcard_duallethals"));
			var_04 = var_04 && bot_loadout_item_valid_for_rank(param_00,param_03,self botgetdifficulty());
			break;

		case "loadoutOffhand2":
			var_04 = param_03 == "specialty_null";
			break;

		case "loadoutPrimaryAttachment":
			var_04 = bot_validate_weapon(param_01["loadoutPrimary"],param_03);
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
			var_04 = !isdefined(self.botloadoutfavoritecamoprimary) || param_03 == self.botloadoutfavoritecamoprimary;
			var_04 = var_04 && maps\mp\gametypes\_class::isvalidcamo(param_03);
			break;

		case "loadoutSecondary":
			var_04 = param_03 != param_01["loadoutPrimary"];
			var_05 = param_03;
			if(maps\mp\_utility::islootweapon(var_05))
			{
				var_05 = maps\mp\gametypes\_class::getbasefromlootversion(var_05);
			}
	
			var_04 = var_04 && bot_loadout_item_allowed("weapon",var_05,undefined);
			var_04 = var_04 && maps\mp\gametypes\_class::isvalidsecondary(param_03,bot_loadout_set_has_wildcard(param_01,"specialty_wildcard_dualprimaries"));
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
			var_04 = !isdefined(self.botloadoutfavoritecamosecondary) || param_03 == self.botloadoutfavoritecamosecondary;
			var_04 = var_04 && maps\mp\gametypes\_class::isvalidcamo(param_03);
			break;

		case "loadoutStreak4":
		case "loadoutStreak3":
		case "loadoutStreak2":
		case "loadoutStreak1":
			var_04 = maps\mp\bots\_bots_ks::bot_killstreak_is_valid_internal(param_03,"bots",undefined);
			var_04 = var_04 && bot_loadout_item_allowed("killstreak",param_03,undefined);
			break;

		case "loadoutStreakModule4c":
		case "loadoutStreakModule4b":
		case "loadoutStreakModule4a":
		case "loadoutStreakModule3c":
		case "loadoutStreakModule3b":
		case "loadoutStreakModule3a":
		case "loadoutStreakModule2c":
		case "loadoutStreakModule2b":
		case "loadoutStreakModule2a":
		case "loadoutStreakModule1c":
		case "loadoutStreakModule1b":
		case "loadoutStreakModule1a":
			var_04 = bot_loadout_item_allowed("module",param_03,undefined);
			break;

		case "loadoutPerk2":
		case "loadoutPerk1":
		case "loadoutPerk6":
		case "loadoutPerk5":
		case "loadoutPerk4":
		case "loadoutPerk3":
			var_04 = param_03 == "specialty_null" || bot_validate_perk(param_03,param_02,param_01);
			var_04 = var_04 && bot_loadout_item_valid_for_rank(param_00,param_03,self botgetdifficulty());
			break;

		case "loadoutWildcard3":
		case "loadoutWildcard2":
		case "loadoutWildcard1":
			var_04 = 1;
			break;

		default:
			break;
	}

	return var_04;
}

//Function Number: 29
bot_loadout_choose_from_set(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	var_06 = undefined;
	var_07 = 0;
	if(common_scripts\utility::array_contains(param_00,"specialty_null"))
	{
		var_05 = "specialty_null";
	}
	else if(param_03 == "loadoutEquipment" || param_03 == "loadoutOffhand" || common_scripts\utility::string_find(param_03,"Perk") >= 0)
	{
		var_05 = "specialty_null";
	}

	if(param_01 == "classtable_any")
	{
		if(!isdefined(self.default_class_chosen))
		{
			self.default_class_chosen = common_scripts\utility::random(["class1","class2","class3","class4","class5"]);
		}

		param_00 = [self.default_class_chosen];
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
			return bot_loadout_choose_from_statstable(param_01,param_02,param_03,self.personality,self.difficulty);
		}

		if(var_09 == "reticletable")
		{
			return bot_loadout_choose_from_reticletable(param_01,param_02,param_03,self.personality,self.difficulty);
		}

		if(var_09 == "camotable")
		{
			return bot_loadout_choose_from_camotable(param_01,param_02,param_03,self.personality,self.difficulty);
		}

		if(getsubstr(var_09,0,5) == "class" && int(getsubstr(var_09,5,6)) > 0)
		{
			var_09 = bot_loadout_choose_from_default_class(var_09,param_03);
		}

		if(issubstr(param_03,"loadoutStreakModule"))
		{
			var_0C = int(getsubstr(param_03,19,20));
			var_0D = param_02["loadoutStreak" + var_0C];
			var_0E = getsubstr(param_03,20,21);
			switch(var_0D)
			{
				case "remote_mg_sentry_turret":
					if(var_0E == "a")
					{
						var_09 = "sentry_guardian";
					}
					break;

				case "warbird":
					if(var_0E == "a")
					{
						var_09 = "warbird_ai_attack";
					}
					break;

				case "assault_ugv":
					if(var_0E == "a")
					{
						var_09 = "assault_ugv_ai";
					}
					else if(var_0E == "b")
					{
						var_09 = "assault_ugv_mg";
					}
					break;
			}
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

//Function Number: 30
bot_loadout_choose_values(param_00)
{
	self.chosentemplates = [];
	foreach(var_06, var_02 in param_00)
	{
		var_03 = strtok(var_02,"| ");
		var_04 = bot_loadout_choose_from_set(var_03,var_02,param_00,var_06);
		param_00[var_06] = var_04;
	}

	if(self botgetdifficulty() != "recruit")
	{
		var_07 = bot_get_pick_13_count(param_00);
		for(var_08 = 0;var_07 < level.customclasspickcount && var_08 < 5;var_08++)
		{
			if(var_07 == level.customclasspickcount - 1)
			{
				param_00 = bot_find_1_loadout_option(param_00);
			}
			else if(var_07 <= level.customclasspickcount - 2)
			{
				param_00 = bot_find_2_loadout_options(param_00);
			}

			var_07 = bot_get_pick_13_count(param_00);
		}
	}

	return param_00;
}

//Function Number: 31
bot_find_1_loadout_option(param_00)
{
	if(param_00["loadoutSecondaryAttachment2"] == "none")
	{
		param_00["loadoutSecondaryAttachment2"] = bot_loadout_choose_from_set(["attachmenttable"],"attachmenttable",param_00,"loadoutSecondaryAttachment2");
	}

	if(bot_get_pick_13_count(param_00) == level.customclasspickcount)
	{
		return param_00;
	}

	var_02 = "add";
	var_03 = param_00["loadoutWildcard1"] != "specialty_null" && param_00["loadoutWildcard2"] != "specialty_null" && param_00["loadoutWildcard3"] != "specialty_null";
	if(randomint(100) < 50 && !var_03)
	{
		var_02 = "remove";
	}

	if(var_02 == "remove")
	{
		if(param_00["loadoutEquipment"] != "specialty_null")
		{
			param_00["loadoutEquipment"] = "specialty_null";
			if(bot_get_pick_13_count(param_00) == level.customclasspickcount - 2)
			{
				return param_00;
			}
		}
	}
	else if(var_02 == "add")
	{
		if(param_00["loadoutEquipment"] != "specialty_null" && param_00["loadoutEquipment2"] == "specialty_null")
		{
			param_00["loadoutEquipment2"] = param_00["loadoutEquipment"];
			if(bot_get_pick_13_count(param_00) == level.customclasspickcount)
			{
				return param_00;
			}
		}
	}

	if(!var_03)
	{
		var_04 = ["loadoutSecondaryAttachment2","loadoutSecondaryAttachment","loadoutStreak3","loadoutStreak2","loadoutStreak1"];
		foreach(var_06 in var_04)
		{
			if(param_00[var_06] != "none")
			{
				param_00[var_06] = "none";
				if(bot_get_pick_13_count(param_00) == level.customclasspickcount - 2)
				{
					return param_00;
				}
			}
		}
	}

	return param_00;
}

//Function Number: 32
bot_find_2_loadout_options(param_00)
{
	var_01 = ["loadoutWildcard1","loadoutWildcard2","loadoutWildcard3"];
	var_02 = common_scripts\utility::array_randomize(["loadoutPerk2","loadoutPerk4","loadoutPerk6"]);
	foreach(var_04 in var_02)
	{
		if(param_00[var_04] == "specialty_null")
		{
			var_05 = undefined;
			foreach(var_07 in var_01)
			{
				if(param_00[var_07] == "specialty_null")
				{
					var_05 = var_07;
					break;
				}
			}

			if(isdefined(var_05))
			{
				var_09 = 0;
				if(!var_09)
				{
					var_0B = int(getsubstr(var_04,11,12));
					param_00[var_05] = "specialty_wildcard_perkslot" + var_0B / 2;
					param_00[var_04] = bot_loadout_choose_from_set(["template_any"],"template_any",param_00,var_04);
					if(param_00[var_04] == "specialty_null")
					{
						param_00[var_05] = "specialty_null";
						continue;
					}

					if(bot_get_pick_13_count(param_00) > level.customclasspickcount - 2)
					{
						return param_00;
					}
				}
			}
		}
	}

	if(param_00["loadoutEquipment"] == "specialty_null")
	{
		var_0D = "template_any_noncamper";
		if(level.bot_personality_type[self.personality] == "stationary")
		{
			var_0D = "template_any_camper";
		}

		param_00["loadoutEquipment"] = bot_loadout_choose_from_set([var_0D],var_0D,param_00,"loadoutEquipment");
	}

	if(param_00["loadoutEquipment"] != "specialty_null" && param_00["loadoutEquipment2"] == "specialty_null")
	{
		param_00["loadoutEquipment2"] = param_00["loadoutEquipment"];
	}

	return param_00;
}

//Function Number: 33
bot_get_pick_13_count(param_00)
{
	var_01 = tablelookup("mp/statstable.csv",4,param_00["loadoutPrimary"],40);
	var_02 = tablelookup("mp/statstable.csv",4,param_00["loadoutSecondary"],40);
	var_03 = 0;
	if(param_00["loadoutPrimary"] != "iw5_combatknife")
	{
		var_03++;
	}

	if(param_00["loadoutPrimaryAttachment"] != "none" && var_01 == "")
	{
		var_03++;
	}

	if(param_00["loadoutPrimaryAttachment2"] != "none")
	{
		var_03++;
	}

	if(param_00["loadoutPrimaryAttachment3"] != "none")
	{
		var_03++;
	}

	if(param_00["loadoutSecondary"] != "iw5_combatknife")
	{
		var_03++;
	}

	if(param_00["loadoutSecondaryAttachment"] != "none" && var_02 == "")
	{
		var_03++;
	}

	if(param_00["loadoutSecondaryAttachment2"] != "none")
	{
		var_03++;
	}

	if(param_00["loadoutSecondaryAttachment3"] != "none")
	{
		var_03++;
	}

	if(param_00["loadoutEquipment"] != "specialty_null")
	{
		var_03++;
	}

	if(param_00["loadoutEquipment2"] != "specialty_null")
	{
		var_03++;
	}

	if(param_00["loadoutOffhand"] != "specialty_null")
	{
		var_03++;
	}

	if(isdefined(param_00["loadoutOffhandExtra"]) && param_00["loadoutOffhandExtra"])
	{
		var_03++;
	}

	for(var_04 = 1;var_04 <= 6;var_04++)
	{
		if(param_00["loadoutPerk" + var_04] != "specialty_null")
		{
			var_03++;
		}
	}

	for(var_04 = 1;var_04 <= 3;var_04++)
	{
		if(param_00["loadoutWildcard" + var_04] != "specialty_null")
		{
			var_03++;
		}
	}

	for(var_04 = 1;var_04 <= 4;var_04++)
	{
		if(param_00["loadoutStreak" + var_04] != "none")
		{
			var_03++;
		}
	}

	return var_03;
}

//Function Number: 34
bot_loadout_get_difficulty()
{
	var_00 = self botgetdifficulty();
	if(var_00 == "default")
	{
		maps\mp\bots\_bots_util::bot_set_difficulty("default");
		var_00 = self botgetdifficulty();
	}

	return var_00;
}

//Function Number: 35
bot_loadout_class_callback(param_00)
{
	while(!isdefined(level.bot_loadouts_initialized))
	{
		wait(0.05);
	}

	while(!isdefined(self.personality))
	{
		wait(0.05);
	}

	var_01 = 0;
	var_02 = 0;
	if(isdefined(param_00) && param_00)
	{
		var_02 = 1;
	}
	else if(isdefined(self.bot_pick_new_loadout_next_spawn) && self.bot_pick_new_loadout_next_spawn)
	{
		var_01 = 1;
		self.bot_pick_new_loadout_next_spawn = undefined;
	}

	var_03 = [];
	var_04 = bot_loadout_get_difficulty();
	self.difficulty = var_04;
	var_05 = self botgetpersonality();
	if(!isdefined(self.bot_last_loadout_num))
	{
		self.bot_cur_loadout_num = 0;
	}

	self.bot_last_loadout_num = self.bot_cur_loadout_num;
	if(isdefined(self.botlastloadout) && !var_01)
	{
		if(var_02)
		{
			return self.botlastloadout;
		}

		var_06 = self.botlastloadoutdifficulty == var_04;
		var_07 = self.botlastloadoutpersonality == var_05;
		if(var_06 && var_07 && !isdefined(self.hasdied) || self.hasdied && !isdefined(self.respawn_with_launcher))
		{
			var_08 = randomfloat(1) > 0.1;
			if(var_08)
			{
				return self.botlastloadout;
			}
		}
	}

	if(!bot_custom_classes_allowed())
	{
		var_03 = bot_default_class_random();
		bot_pick_personality_from_weapon(var_03["loadoutPrimary"]);
	}
	else
	{
		var_03 = bot_loadout_pick(var_05,var_04);
		var_03 = bot_loadout_choose_values(var_03);
		if(isdefined(level.bot_funcs["gametype_loadout_modify"]))
		{
			var_03 = self [[ level.bot_funcs["gametype_loadout_modify"] ]](var_03);
		}
	}

	if(var_03["loadoutPrimary"] == "none")
	{
		self.bot_fallback_personality = undefined;
		var_03["loadoutPrimary"] = bot_loadout_choose_fallback_primary(var_03);
		var_03["loadoutPrimaryCamo"] = "none";
		var_03["loadoutPrimaryAttachment"] = "none";
		var_03["loadoutPrimaryAttachment2"] = "none";
		var_03["loadoutPrimaryAttachment3"] = "none";
		var_03["loadoutPrimaryReticle"] = "none";
		if(isdefined(self.bot_fallback_personality))
		{
			if(self.bot_fallback_personality == "weapon")
			{
				bot_pick_personality_from_weapon(var_03["loadoutPrimary"]);
			}
			else
			{
				maps\mp\bots\_bots_util::bot_set_personality(self.bot_fallback_personality);
			}

			var_05 = self.personality;
			self.bot_fallback_personality = undefined;
		}
	}

	if(isdefined(var_03["loadoutPrimaryCamo"]) && var_03["loadoutPrimaryCamo"] != "none" && !isdefined(self.botloadoutfavoritecamoprimary))
	{
		self.botloadoutfavoritecamoprimary = var_03["loadoutPrimaryCamo"];
	}

	if(isdefined(var_03["loadoutSecondaryCamo"]) && var_03["loadoutSecondaryCamo"] != "none" && !isdefined(self.botloadoutfavoritecamosecondary))
	{
		self.botloadoutfavoritecamosecondary = var_03["loadoutSecondaryCamo"];
	}

	if(isdefined(self.respawn_with_launcher))
	{
		var_0C = level.bot_respawn_launcher_name[self botgetdifficulty()];
		if(bot_loadout_item_allowed("weapon",var_0C,undefined))
		{
			var_03["loadoutSecondary"] = var_0C;
			var_03["loadoutSecondaryAttachment"] = "none";
			var_03["loadoutSecondaryAttachment2"] = "none";
			var_03["loadoutSecondaryAttachment3"] = "none";
			self.bot_pick_new_loadout_next_spawn = 1;
		}

		self.respawn_with_launcher = undefined;
	}

	maps\mp\gametypes\_class::isvalidkillstreak(var_03["loadoutStreak1"]);
	maps\mp\gametypes\_class::isvalidkillstreak(var_03["loadoutStreak2"]);
	maps\mp\gametypes\_class::isvalidkillstreak(var_03["loadoutStreak3"]);
	self.bot_cur_loadout_num++;
	self.botlastloadout = var_03;
	self.botlastloadoutdifficulty = var_04;
	self.botlastloadoutpersonality = var_05;
	return var_03;
}

//Function Number: 36
bot_setup_loadout_callback()
{
	var_00 = self botgetpersonality();
	var_01 = bot_loadout_get_difficulty();
	var_02 = bot_loadout_set(var_00,var_01,0);
	if(isdefined(var_02) && isdefined(var_02.loadouts) && var_02.loadouts.size > 0)
	{
		self.classcallback = ::bot_loadout_class_callback;
		return 1;
	}

	var_03 = getsubstr(self.name,0,self.name.size - 10);
	self.classcallback = undefined;
	return 0;
}