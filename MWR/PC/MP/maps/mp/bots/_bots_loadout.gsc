/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_loadout.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 704 ms
 * Timestamp: 10/27/2023 2:37:28 AM
*******************************************************************/

//Function Number: 1
init()
{
	init_template_table();
	init_class_table();
	init_bot_attachkittable();
	init_bot_weap_statstable();
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
	if(isusingmatchrulesdata())
	{
		if(!getmatchrulesdata("commonOption","allowCustomClasses"))
		{
			return 0;
		}
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
			break;

		case "attachment":
			break;

		case "perk":
			break;

		default:
			break;
	}
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
		while(var_0D < 5)
		{
			if(getmatchrulesdata("defaultClasses",bot_loadout_team(),"defaultClass",var_0D,"class","inUse"))
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
			if(getmatchrulesdata("defaultClasses",bot_loadout_team(),"defaultClass",var_01,"class","inUse"))
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
bot_loadout_fields()
{
	var_00 = "mp/botClassTable.csv";
	if(!isdefined(level.bot_loadout_fields))
	{
		level.bot_loadout_fields = [];
		var_01 = 2;
		for(;;)
		{
			var_02 = tablelookupbyrow(var_00,var_01,0);
			if(var_02 == "")
			{
				break;
			}

			level.bot_loadout_fields[level.bot_loadout_fields.size] = var_02;
			var_01++;
		}
	}

	return level.bot_loadout_fields;
}

//Function Number: 11
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

//Function Number: 12
bot_loadout_pick(param_00,param_01)
{
	var_02 = bot_loadout_set(param_00,param_01,0);
	if(isdefined(var_02) && isdefined(var_02.loadouts) && var_02.loadouts.size > 0)
	{
		var_03 = randomint(var_02.loadouts.size);
		return var_02.loadouts[var_03].loadoutvalues;
	}
}

//Function Number: 13
bot_validate_attachkit_for_weapon(param_00,param_01,param_02)
{
	if(param_01 == "none")
	{
		return 0;
	}

	if(param_00 == "none")
	{
		return 1;
	}

	if(!bot_loadout_item_allowed("attachment",param_00,undefined))
	{
		return 0;
	}

	if(param_01 == "h1_mp44" || param_01 == "h1_deserteagle" || param_01 == "h1_deserteagle55")
	{
		return 0;
	}

	var_03 = param_01 + "_mp";
	var_04 = weaponclass(var_03);
	if(param_00 == "silencer" && param_02 == "recruit")
	{
		if(var_04 != "pistol")
		{
			return 0;
		}
	}

	if(param_00 == "acog" && var_04 == "sniper")
	{
		if(!self.bot_loadout_can_pick_acog_for_sniper)
		{
			return 0;
		}
	}

	if(bot_attachkit_replaces_perk1(param_00))
	{
		if(isdefined(self.loadoutitemsalreadychosen) && isdefined(self.loadoutitemsalreadychosen["loadoutPerk1"]))
		{
			if(self.loadoutitemsalreadychosen["loadoutPerk1"] != "specialty_null")
			{
				return 0;
			}
		}
	}

	if(param_00 == "silencer")
	{
		if(!self.bot_loadout_can_pick_silencer)
		{
			return 0;
		}
	}

	var_05 = level.bot_attachkittable_reference[param_00]["validClasses"];
	var_06 = level.bot_attach_weaponclasstoattachtableclass[var_04];
	if(!common_scripts\utility::array_contains(var_05,var_06))
	{
		return 0;
	}

	var_07 = function_02F8(var_03);
	if(var_07.size == 0)
	{
		return 0;
	}

	var_08 = level.bot_attachkittable_reference[param_00]["attachmentArray"];
	if(var_08.size == 1)
	{
		if(!common_scripts\utility::array_contains(var_07,var_08[0]))
		{
			return 0;
		}
	}
	else
	{
		var_09 = 0;
		for(var_0A = 0;var_0A < var_08.size;var_0A++)
		{
			if(common_scripts\utility::array_contains(var_07,var_08[var_0A]))
			{
				var_09 = 1;
				for(var_0B = 0;var_0B < var_08.size;var_0B++)
				{
					if(var_0B != var_0A)
					{
					}
				}

				break;
			}
		}

		if(!var_09)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 14
init_bot_weap_statstable()
{
	var_00 = "mp/statstable.csv";
	var_01 = 4;
	var_02 = 57;
	var_03 = 58;
	level.bot_weap_statstable = [];
	level.bot_weap_personality = [];
	var_04 = 1;
	for(;;)
	{
		var_05 = tablelookupbyrow(var_00,var_04,0);
		if(var_05 == "")
		{
			break;
		}

		var_06 = tablelookupbyrow(var_00,var_04,var_01);
		var_07 = tablelookupbyrow(var_00,var_04,var_03);
		var_08 = tablelookupbyrow(var_00,var_04,var_02);
		if(var_07 != "" && var_06 != "" && var_08 != "")
		{
			var_09 = "loadoutPrimary";
			if(maps\mp\gametypes\_class::isvalidsecondary(var_06))
			{
				var_09 = "loadoutSecondary";
			}
			else if(!maps\mp\gametypes\_class::isvalidprimary(var_06))
			{
				var_04++;
				continue;
			}

			if(var_06 != "" && var_08 != "")
			{
				level.bot_weap_personality[var_06] = var_08;
			}

			if(!isdefined(level.bot_weap_statstable[var_09]))
			{
				level.bot_weap_statstable[var_09] = [];
			}

			var_0A = strtok(var_08,"| ");
			var_0B = strtok(var_07,"| ");
			foreach(var_0D in var_0A)
			{
				if(!isdefined(level.bot_weap_statstable[var_09][var_0D]))
				{
					level.bot_weap_statstable[var_09][var_0D] = [];
				}

				foreach(var_0F in var_0B)
				{
					if(!isdefined(level.bot_weap_statstable[var_09][var_0D][var_0F]))
					{
						level.bot_weap_statstable[var_09][var_0D][var_0F] = [];
					}

					var_10 = level.bot_weap_statstable[var_09][var_0D][var_0F].size;
					level.bot_weap_statstable[var_09][var_0D][var_0F][var_10] = var_06;
				}
			}
		}

		var_04++;
	}
}

//Function Number: 15
bot_loadout_choose_from_statstable(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	if(param_03 == "default")
	{
		param_03 = "run_and_gun";
	}

	var_06 = param_02;
	if(var_06 == "loadoutSecondary" && param_01["loadoutPerk2"] == "specialty_twoprimaries")
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

//Function Number: 16
bot_validate_offhand(param_00,param_01,param_02)
{
	if(!bot_loadout_item_allowed("perk",param_00,"Tactical"))
	{
		return 0;
	}

	if(!maps\mp\gametypes\_class::isvalidoffhand(param_00))
	{
		return 0;
	}

	if(param_00 == "h1_smokegrenade_mp")
	{
		if(isdefined(param_02["loadoutPerk1"]))
		{
			if(param_02["loadoutPerk1"] == "specialty_specialgrenade")
			{
				return 0;
			}
		}

		if(isdefined(self.loadoutitemsalreadychosen) && isdefined(self.loadoutitemsalreadychosen["loadoutPerk1"]))
		{
			if(self.loadoutitemsalreadychosen["loadoutPerk1"] == "specialty_specialgrenade")
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 17
bot_validate_perk(param_00,param_01,param_02)
{
	if(param_00 == "specialty_null")
	{
		return 1;
	}

	var_03 = "Perk_Slot1";
	if(param_01 == "loadoutPerk2")
	{
		var_03 = "Perk_Slot2";
	}
	else if(param_01 == "loadoutPerk3")
	{
		var_03 = "Perk_Slot3";
	}

	if(!bot_loadout_item_allowed("perk",param_00,var_03))
	{
		return 0;
	}

	if(param_00 == "specialty_specialgrenade")
	{
		if(isdefined(param_02["loadoutOffhand"]))
		{
			if(param_02["loadoutOffhand"] == "h1_smokegrenade_mp")
			{
				return 0;
			}
		}

		if(isdefined(self.loadoutitemsalreadychosen) && isdefined(self.loadoutitemsalreadychosen["loadoutOffhand"]))
		{
			if(self.loadoutitemsalreadychosen["loadoutOffhand"] == "h1_smokegrenade_mp")
			{
				return 0;
			}
		}
	}

	var_04 = int(getsubstr(param_01,11));
	if(var_04 == 1)
	{
		if(isdefined(self.loadoutitemsalreadychosen))
		{
			if(isdefined(self.loadoutitemsalreadychosen["loadoutPrimaryAttachKit"]))
			{
				if(bot_attachkit_replaces_perk1(self.loadoutitemsalreadychosen["loadoutPrimaryAttachKit"]))
				{
					return 0;
				}
			}

			if(isdefined(self.loadoutitemsalreadychosen["loadoutSecondaryAttachKit"]))
			{
				if(bot_attachkit_replaces_perk1(self.loadoutitemsalreadychosen["loadoutSecondaryAttachKit"]))
				{
					return 0;
				}
			}
		}
	}

	return 1;
}

//Function Number: 18
bot_loadout_choose_from_default_class(param_00,param_01)
{
	var_02 = int(getsubstr(param_00,5,6)) - 1;
	switch(param_01)
	{
		case "loadoutPrimary":
			break;

		case "loadoutPrimaryAttachKit":
			break;

		case "loadoutPrimaryFurnitureKit":
			break;

		case "loadoutPrimaryCamo":
			break;

		case "loadoutPrimaryReticle":
			break;

		case "loadoutSecondary":
			break;

		case "loadoutSecondaryAttachKit":
			break;

		case "loadoutSecondaryFurnitureKit":
			break;

		case "loadoutSecondaryCamo":
			break;

		case "loadoutSecondaryReticle":
			break;

		case "loadoutEquipment":
			break;

		case "loadoutOffhand":
			break;

		case "loadoutPerk3":
		case "loadoutPerk2":
		case "loadoutPerk1":
			break;
	}
}

//Function Number: 19
bot_loadout_choose_from_custom_default_class(param_00,param_01)
{
	var_02 = bot_loadout_team();
	switch(param_01)
	{
		case "loadoutPrimary":
			break;

		case "loadoutPrimaryAttachKit":
			break;

		case "loadoutPrimaryFurnitureKit":
			break;

		case "loadoutPrimaryCamo":
			break;

		case "loadoutPrimaryReticle":
			break;

		case "loadoutSecondary":
			break;

		case "loadoutSecondaryAttachKit":
			break;

		case "loadoutSecondaryFurnitureKit":
			break;

		case "loadoutSecondaryCamo":
			break;

		case "loadoutSecondaryReticle":
			break;

		case "loadoutEquipment":
			break;

		case "loadoutOffhand":
			break;

		case "loadoutPerk1":
			break;

		case "loadoutPerk2":
			break;

		case "loadoutPerk3":
			break;

		default:
			break;
	}
}

//Function Number: 20
init_bot_attachkittable()
{
	var_00 = "mp/attachkits.csv";
	var_01 = 1;
	var_02 = 2;
	var_03 = 5;
	var_04 = 6;
	var_05 = 12;
	var_06 = 13;
	level.bot_attachkittable = [];
	level.bot_attachkittable_reference = [];
	var_07 = 1;
	for(;;)
	{
		var_08 = tablelookupbyrow(var_00,var_07,0);
		if(var_08 == "")
		{
			break;
		}

		var_09 = tablelookupbyrow(var_00,var_07,var_01);
		var_0A = tablelookupbyrow(var_00,var_07,var_05);
		var_0B = tablelookupbyrow(var_00,var_07,var_06);
		if(var_09 != "" && var_0A != "" && var_0B != "")
		{
			var_0C = strtok(var_0A,"| ");
			foreach(var_0E in var_0C)
			{
				if(!isdefined(level.bot_attachkittable[var_0E]))
				{
					level.bot_attachkittable[var_0E] = [];
				}

				var_0F = strtok(var_0B,"| ");
				foreach(var_11 in var_0F)
				{
					if(!isdefined(level.bot_attachkittable[var_0E][var_11]))
					{
						level.bot_attachkittable[var_0E][var_11] = [];
					}

					var_12 = level.bot_attachkittable[var_0E][var_11].size;
					level.bot_attachkittable[var_0E][var_11][var_12] = var_09;
				}
			}

			var_15 = tablelookupbyrow(var_00,var_07,var_04);
			var_16 = strtok(var_15," ");
			level.bot_attachkittable_reference[var_09]["validClasses"] = var_16;
			var_17 = [];
			for(var_18 = var_02;var_18 <= var_03;var_18++)
			{
				var_19 = tablelookupbyrow(var_00,var_07,var_18);
				if(var_19 != "")
				{
					var_17[var_17.size] = var_19;
				}
			}

			level.bot_attachkittable_reference[var_09]["attachmentArray"] = var_17;
			level.bot_attachkittable_reference[var_09]["replacesPerk1"] = var_09 == "gl" || var_09 == "grip";
		}

		var_07++;
	}

	level.bot_attach_weaponclasstoattachtableclass["rifle"] = "ast";
	level.bot_attach_weaponclasstoattachtableclass["smg"] = "smg";
	level.bot_attach_weaponclasstoattachtableclass["spread"] = "sht";
	level.bot_attach_weaponclasstoattachtableclass["pistol"] = "pst";
	level.bot_attach_weaponclasstoattachtableclass["mg"] = "lmg";
	level.bot_attach_weaponclasstoattachtableclass["sniper"] = "snp";
}

//Function Number: 21
bot_pick_new_loadout_item(param_00,param_01,param_02,param_03)
{
	self.loadoutitemsalreadychosen[param_03] = param_01[param_03];
	var_04 = bot_loadout_choose_from_set([param_00],param_00,param_01,param_02);
	self.loadoutitemsalreadychosen[param_03] = undefined;
	return var_04;
}

//Function Number: 22
bot_cross_validate_attachkit_and_perk(param_00,param_01)
{
	var_02 = ["attachKit","perk"];
	var_03 = undefined;
	if(bot_attachkit_replaces_perk1(param_00["loadoutPrimaryAttachKit"]) && param_00["loadoutPerk1"] != "specialty_null")
	{
		var_03 = common_scripts\utility::random(var_02);
		if(var_03 == "attachKit")
		{
			var_04 = "loadoutPrimaryAttachKit";
			var_05 = "loadoutPerk1";
		}
		else
		{
			var_04 = "loadoutPerk1";
			var_05 = "loadoutPrimaryAttachKit";
		}

		param_00[var_05] = bot_pick_new_loadout_item(param_01[var_05],param_00,var_05,var_04);
	}

	if(bot_attachkit_replaces_perk1(param_00["loadoutSecondaryAttachKit"]) && param_00["loadoutPerk1"] != "specialty_null")
	{
		var_04 = "loadoutPerk1";
		var_05 = "loadoutSecondaryAttachKit";
		param_00[var_05] = bot_pick_new_loadout_item(param_01[var_05],param_00,var_05,var_04);
	}

	return param_00;
}

//Function Number: 23
bot_attachkit_replaces_perk1(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(maps\mp\_utility::is_true(level.bot_attachkittable_reference[param_00]["replacesPerk1"]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
bot_perk_get_explosive_list()
{
	return ["claymore_mp","c4_mp","specialty_fraggrenade","rpg_mp"];
}

//Function Number: 25
bot_perk_is_explosive(param_00)
{
	var_01 = bot_perk_get_explosive_list();
	if(common_scripts\utility::array_contains(var_01,param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
bot_loadout_choose_from_attachkittable(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.bot_attachkittable[param_03]) || !isdefined(level.bot_attachkittable[param_03][param_04]))
	{
		return "none";
	}

	var_05 = bot_loadout_choose_from_set(level.bot_attachkittable[param_03][param_04],param_00,param_01,param_02);
	return var_05;
}

//Function Number: 27
init_bot_camotable()
{
	var_00 = "mp/camotable.csv";
	var_01 = 1;
	var_02 = 8;
	var_03 = 9;
	level.bot_camotable = [];
	var_04 = 0;
	for(;;)
	{
		var_05 = tablelookupbyrow(var_00,var_04,var_01);
		if(!isdefined(var_05) || var_05 == "")
		{
			break;
		}

		var_06 = tablelookupbyrow(var_00,var_04,var_02);
		if(isdefined(var_06) && var_06 != "")
		{
			var_07 = tablelookupbyrow(var_00,var_04,var_03);
			if(var_07 != "")
			{
				var_08 = strtok(var_07,"| ");
				foreach(var_0A in var_08)
				{
					if(!isdefined(level.bot_camotable[var_0A]))
					{
						level.bot_camotable[var_0A] = [];
					}

					var_0B = level.bot_camotable[var_0A].size;
					level.bot_camotable[var_0A][var_0B] = var_05;
				}
			}
		}

		var_04++;
	}
}

//Function Number: 28
bot_loadout_choose_from_camotable(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	if(!isdefined(level.bot_camotable))
	{
		return var_05;
	}

	if(!isdefined(level.bot_camotable[param_04]))
	{
		return var_05;
	}

	var_06 = randomint(100) > 50;
	if(var_06)
	{
		var_05 = bot_loadout_choose_from_set(level.bot_camotable[param_04],param_00,param_01,param_02);
	}

	return var_05;
}

//Function Number: 29
bot_loadout_item_valid_for_rank(param_00,param_01,param_02)
{
	if(isagent(self))
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
		self.rank_for_items = self.pers["rank"];
		if(!isdefined(self.rank_for_items))
		{
			self.rank_for_items = level.bot_rnd_rank[param_02][0];
		}
	}

	if(level.bot_min_rank_for_item[param_01] <= self.rank_for_items)
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
bot_loadout_valid_choice(param_00,param_01,param_02,param_03)
{
	var_04 = 1;
	switch(param_02)
	{
		case "loadoutPrimary":
			break;

		case "loadoutEquipment":
			break;

		case "loadoutOffhand":
			break;

		case "loadoutPrimaryAttachKit":
			break;

		case "loadoutPrimaryFurnitureKit":
			break;

		case "loadoutPrimaryReticle":
			break;

		case "loadoutPrimaryCamo":
			break;

		case "loadoutSecondary":
			break;

		case "loadoutSecondaryAttachKit":
			break;

		case "loadoutSecondaryFurnitureKit":
			break;

		case "loadoutSecondaryReticle":
			break;

		case "loadoutSecondaryCamo":
			break;

		case "loadoutPerk3":
		case "loadoutPerk2":
		case "loadoutPerk1":
			break;

		default:
			break;
	}
}

//Function Number: 31
bot_loadout_choose_from_set(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "none";
	var_06 = undefined;
	var_07 = 0;
	if(common_scripts\utility::array_contains(param_00,"specialty_null"))
	{
		var_05 = "specialty_null";
	}
	else if(param_03 == "loadoutEquipment" || param_03 == "loadoutOffhand" || issubstr(param_03,"Perk"))
	{
		var_05 = "specialty_null";
	}

	if(param_01 == "classtable_any")
	{
		if(!isdefined(self.default_class_chosen))
		{
			self.default_class_chosen = common_scripts\utility::random(["class1","class2","class3","class4","class5","class6"]);
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

		if(var_09 == "attachkittable")
		{
			return bot_loadout_choose_from_attachkittable(param_01,param_02,param_03,self.personality,self.difficulty);
		}

		if(var_09 == "weap_statstable")
		{
			return bot_loadout_choose_from_statstable(param_01,param_02,param_03,self.personality,self.difficulty);
		}

		if(var_09 == "camotable")
		{
			return bot_loadout_choose_from_camotable(param_01,param_02,param_03,self.personality,self.difficulty);
		}

		if(getsubstr(var_09,0,5) == "class" && int(getsubstr(var_09,5,6)) > 0)
		{
			var_09 = bot_loadout_choose_from_default_class(var_09,param_03);
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

//Function Number: 32
bot_loadout_choose_values(param_00)
{
	self.chosentemplates = [];
	foreach(var_06, var_02 in param_00)
	{
		var_03 = undefined;
		if(!isdefined(var_03))
		{
			var_05 = strtok(var_02,"| ");
			var_03 = bot_loadout_choose_from_set(var_05,var_02,param_00,var_06);
		}

		param_00[var_06] = var_03;
	}

	return param_00;
}

//Function Number: 33
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

//Function Number: 34
bot_get_stored_custom_classes()
{
	if(isdefined(self.pers["botCustomClasses"]))
	{
		return self.pers["botCustomClasses"];
	}

	return [];
}

//Function Number: 35
bot_get_stored_launcher_class()
{
	if(bot_get_stored_custom_classes().size > 0)
	{
		if(isdefined(self.pers["botLauncherClassIndex"]))
		{
			var_00 = self.pers["botLauncherClassIndex"];
			return self.pers["botCustomClasses"][var_00];
		}
	}

	return undefined;
}

//Function Number: 36
bot_allowed_to_try_last_loadout()
{
	if(maps\mp\_utility::is_true(self.bot_pick_new_loadout_next_spawn))
	{
		return 0;
	}
	else if(!isdefined(self.pers["botLastLoadout"]))
	{
		return 0;
	}
	else if(maps\mp\_utility::is_true(self.respawn_with_launcher))
	{
		return 0;
	}
	else if(isdefined(self.hasdied) && !self.hasdied)
	{
		return 0;
	}

	return 1;
}

//Function Number: 37
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

	var_01 = [];
	var_02 = bot_loadout_get_difficulty();
	self.difficulty = var_02;
	var_03 = self botgetpersonality();
	if(!isdefined(self.bot_last_loadout_num))
	{
		self.bot_cur_loadout_num = 0;
	}

	self.bot_last_loadout_num = self.bot_cur_loadout_num;
	if(isdefined(self.pers["botLastLoadout"]) && maps\mp\_utility::is_true(param_00))
	{
		return self.pers["botLastLoadout"];
	}

	var_04 = !isdefined(self.pers["botLastLoadoutDifficulty"]) || self.pers["botLastLoadoutDifficulty"] == var_02;
	var_05 = !isdefined(self.pers["botLastLoadoutPersonality"]) || self.pers["botLastLoadoutPersonality"] == var_03;
	var_06 = 0;
	if(!var_04 || !var_05)
	{
		self.pers["botLastLoadout"] = undefined;
		self.pers["botCustomClasses"] = undefined;
		self.pers["botLauncherClassIndex"] = undefined;
		var_06 = 1;
	}

	var_07 = !var_06 && bot_allowed_to_try_last_loadout();
	if(var_07)
	{
		var_08 = randomfloat(1) > 0.1;
		if(var_08)
		{
			return self.pers["botLastLoadout"];
		}
	}

	self.bot_pick_new_loadout_next_spawn = undefined;
	if(!var_06)
	{
		var_09 = bot_get_stored_launcher_class();
		var_0A = undefined;
		if(isdefined(self.respawn_with_launcher) && isdefined(var_09))
		{
			self.respawn_with_launcher = undefined;
			self.bot_pick_new_loadout_next_spawn = 1;
			var_0A = var_09;
		}

		if(!isdefined(var_0A))
		{
			var_0B = bot_get_stored_custom_classes();
			var_0C = 0;
			if(isdefined(var_09))
			{
				if(var_0B.size < 5)
				{
					var_0C = 1;
				}
			}
			else if(isdefined(self.respawn_with_launcher))
			{
				var_0C = 1;
			}
			else if(var_0B.size < 4)
			{
				var_0C = 1;
			}

			if(!var_0C)
			{
				var_0A = common_scripts\utility::random(var_0B);
			}
		}

		if(isdefined(var_0A))
		{
			self.bot_cur_loadout_num++;
			self.pers["botLastLoadout"] = var_0A;
			return var_0A;
		}
	}

	self.bot_loadout_can_pick_acog_for_sniper = randomfloat(1) < 0.5;
	if(var_03 == "cqb")
	{
		self.bot_loadout_can_pick_silencer = randomfloat(1) < 0.5;
	}
	else
	{
		self.bot_loadout_can_pick_silencer = randomfloat(1) < 0.25;
	}

	var_0D = undefined;
	var_0E = bot_custom_classes_allowed();
	if(var_0E)
	{
		var_0D = bot_loadout_pick(var_03,var_02);
		var_01 = bot_loadout_choose_values(var_0D);
		if(isdefined(level.bot_funcs["gametype_loadout_modify"]))
		{
			var_01 = self [[ level.bot_funcs["gametype_loadout_modify"] ]](var_01);
		}

		var_01 = bot_cross_validate_attachkit_and_perk(var_01,var_0D);
		if(bot_match_rules_invalidate_loadout(var_01))
		{
			var_0E = 0;
		}
	}

	if(!var_0E)
	{
		var_01 = bot_default_class_random();
		bot_pick_personality_from_weapon(var_01["loadoutPrimary"]);
	}

	var_01["loadoutMelee"] = "none";
	if(var_01["loadoutPrimary"] == "none")
	{
		self.bot_fallback_personality = undefined;
		var_01["loadoutPrimary"] = bot_loadout_choose_fallback_primary(var_01);
		var_01["loadoutPrimaryCamo"] = "none";
		var_01["loadoutPrimaryAttachKit"] = "none";
		var_01["loadoutPrimaryFurnitureKit"] = "none";
		var_01["loadoutPrimaryReticle"] = "none";
		if(isdefined(self.bot_fallback_personality))
		{
			if(self.bot_fallback_personality == "weapon")
			{
				bot_pick_personality_from_weapon(var_01["loadoutPrimary"]);
			}
			else
			{
				maps\mp\bots\_bots_util::bot_set_personality(self.bot_fallback_personality);
			}

			var_03 = self.personality;
			self.bot_fallback_personality = undefined;
		}
	}

	var_12 = isdefined(self.respawn_with_launcher);
	if(var_0E && maps\mp\bots\_bots::bot_israndom())
	{
		if(isdefined(var_01["loadoutPrimaryCamo"]) && var_01["loadoutPrimaryCamo"] != "none" && !isdefined(self.botloadoutfavoritecamoprimary))
		{
			self.botloadoutfavoritecamoprimary = var_01["loadoutPrimaryCamo"];
		}

		if(isdefined(var_01["loadoutSecondaryCamo"]) && var_01["loadoutSecondaryCamo"] != "none" && !isdefined(self.botloadoutfavoritecamosecondary))
		{
			self.botloadoutfavoritecamosecondary = var_01["loadoutSecondaryCamo"];
		}

		if(var_12)
		{
			var_13 = level.bot_respawn_launcher_name[self botgetdifficulty()];
			if(bot_loadout_item_allowed("perk",var_13,"Perk_Slot1"))
			{
				var_01["loadoutPerk1"] = var_13;
				var_01["loadoutPrimaryAttachKit"] = "none";
				var_01["loadoutPrimaryAttachKit"] = bot_pick_new_loadout_item(var_0D["loadoutPrimaryAttachKit"],var_01,"loadoutPrimaryAttachKit","loadoutPerk1");
				self.bot_pick_new_loadout_next_spawn = 1;
			}

			self.respawn_with_launcher = undefined;
		}

		if(var_01["loadoutPerk2"] == "specialty_explosivedamage")
		{
			if(randomfloat(1) < 0.5)
			{
				var_14 = common_scripts\utility::array_randomize(["loadoutPrimaryAttachKit","loadoutPerk1"]);
				for(var_15 = 0;var_15 < var_14.size;var_15++)
				{
					if(bot_perk_is_explosive(var_01["loadoutPerk1"]))
					{
						continue;
					}

					if(var_01["loadoutPrimaryAttachKit"] == "gl")
					{
						continue;
					}

					if(var_14[var_15] == "loadoutPrimaryAttachKit")
					{
						var_01["loadoutPerk1"] = "specialty_null";
						var_16 = bot_loadout_choose_from_set(["gl"],"special_attachkit_choice",var_01,"loadoutPrimaryAttachKit");
						if(var_16 != "none")
						{
							var_01["loadoutPrimaryAttachKit"] = var_16;
						}
					}
					else if(var_14[var_15] == "loadoutPerk1")
					{
						var_01["loadoutPrimaryAttachKit"] = "none";
						var_17 = bot_perk_get_explosive_list();
						if(var_03 != "camper")
						{
							var_17 = common_scripts\utility::array_remove(var_17,"c4_mp");
						}

						var_18 = bot_loadout_choose_from_set(var_17,"special_perk_choice",var_01,"loadoutPerk1");
						if(var_18 != "specialty_null")
						{
							var_01["loadoutPerk1"] = var_18;
						}
					}

					var_19 = var_14[var_15];
					var_1A = var_14[var_15 + 1 % 2];
					var_01[var_1A] = bot_pick_new_loadout_item(var_0D[var_1A],var_01,var_1A,var_19);
				}
			}
		}
	}

	self.bot_cur_loadout_num++;
	self.pers["botLastLoadout"] = var_01;
	self.pers["botLastLoadoutDifficulty"] = var_02;
	self.pers["botLastLoadoutPersonality"] = var_03;
	if(!isdefined(self.pers["botCustomClasses"]))
	{
		self.pers["botCustomClasses"] = [];
	}

	var_1B = self.pers["botCustomClasses"].size;
	self.pers["botCustomClasses"][var_1B] = var_01;
	if(var_12)
	{
		self.pers["botLauncherClassIndex"] = var_1B;
	}

	return var_01;
}

//Function Number: 38
bot_match_rules_invalidate_loadout(param_00)
{
	if(isusingmatchrulesdata())
	{
		if(param_00["loadoutPrimary"] == "none")
		{
			return 1;
		}

		if(param_00["loadoutSecondary"] == "none")
		{
			return 1;
		}

		if(param_00["loadoutOffhand"] == "specialty_null")
		{
			return 1;
		}

		if(param_00["loadoutPerk1"] == "specialty_null")
		{
			if(!bot_attachkit_replaces_perk1(param_00["loadoutPrimaryAttachKit"]) && !bot_attachkit_replaces_perk1(param_00["loadoutSecondaryAttachKit"]))
			{
				return 1;
			}
		}

		if(param_00["loadoutPerk2"] == "specialty_null" || param_00["loadoutPerk3"] == "specialty_null")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 39
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

//Function Number: 40
bot_modify_behavior_from_loadout()
{
	foreach(var_02, var_01 in self.perks)
	{
		if(!var_01)
		{
			continue;
		}

		if(var_02 == "specialty_fraggrenade" || var_02 == "specialty_specialgrenade")
		{
			self botsetflag("encourage_grenade_use",1);
		}

		if(var_02 == "specialty_explosivedamage")
		{
			self.encourage_explosive_use = 1;
			self botsetflag("encourage_explosive_use",1);
		}
	}
}