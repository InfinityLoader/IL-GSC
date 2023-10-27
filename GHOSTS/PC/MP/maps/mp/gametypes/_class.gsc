/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_class.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 72
 * Decompile Time: 1403 ms
 * Timestamp: 10/27/2023 1:17:58 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.classmap["class0"] = 0;
	level.classmap["class1"] = 1;
	level.classmap["class2"] = 2;
	level.classmap["custom1"] = 0;
	level.classmap["custom2"] = 1;
	level.classmap["custom3"] = 2;
	level.classmap["custom4"] = 3;
	level.classmap["custom5"] = 4;
	level.classmap["custom6"] = 5;
	level.classmap["custom7"] = 6;
	level.classmap["custom8"] = 7;
	level.classmap["custom9"] = 8;
	level.classmap["custom10"] = 9;
	level.classmap["axis_recipe1"] = 0;
	level.classmap["axis_recipe2"] = 1;
	level.classmap["axis_recipe3"] = 2;
	level.classmap["axis_recipe4"] = 3;
	level.classmap["axis_recipe5"] = 4;
	level.classmap["axis_recipe6"] = 5;
	level.classmap["allies_recipe1"] = 0;
	level.classmap["allies_recipe2"] = 1;
	level.classmap["allies_recipe3"] = 2;
	level.classmap["allies_recipe4"] = 3;
	level.classmap["allies_recipe5"] = 4;
	level.classmap["allies_recipe6"] = 5;
	level.classmap["gamemode"] = 0;
	level.classmap["callback"] = 0;
	level.defaultclass = "CLASS_ASSAULT";
	level.classtablename = "mp/classTable.csv";
	level thread onplayerconnecting();
}

//Function Number: 2
func_3A54(param_00)
{
	return param_00;
}

//Function Number: 3
getweaponchoice(param_00)
{
	var_01 = strtok(param_00,",");
	if(var_01.size > 1)
	{
		return int(var_01[1]);
	}

	return 0;
}

//Function Number: 4
func_4F16(param_00,param_01,param_02,param_03)
{
	if(param_00 == self.lastclass)
	{
	}

	self logstring("choseclass: " + param_00 + " weapon: " + param_01 + " special: " + param_02);
	for(var_04 = 0;var_04 < param_03.size;var_04++)
	{
		self logstring("perk" + var_04 + ": " + param_03[var_04]);
	}

	self.lastclass = param_00;
}

//Function Number: 5
cac_getweapon(param_00,param_01)
{
	return self getcacplayerdata("loadouts",param_00,"weaponSetups",param_01,"weapon");
}

//Function Number: 6
cac_getweaponattachment(param_00,param_01)
{
	return self getcacplayerdata("loadouts",param_00,"weaponSetups",param_01,"attachment",0);
}

//Function Number: 7
cac_getweaponattachmenttwo(param_00,param_01)
{
	return self getcacplayerdata("loadouts",param_00,"weaponSetups",param_01,"attachment",1);
}

//Function Number: 8
func_1900(param_00,param_01)
{
	return self getcacplayerdata("loadouts",param_00,"weaponSetups",param_01,"attachment",2);
}

//Function Number: 9
cac_getweaponbuff(param_00,param_01)
{
	return self getcacplayerdata("loadouts",param_00,"weaponSetups",param_01,"buff");
}

//Function Number: 10
cac_getweaponcamo(param_00,param_01)
{
	return self getcacplayerdata("loadouts",param_00,"weaponSetups",param_01,"camo");
}

//Function Number: 11
cac_getweaponreticle(param_00,param_01)
{
	return self getcacplayerdata("loadouts",param_00,"weaponSetups",param_01,"reticle");
}

//Function Number: 12
cac_getperk(param_00,param_01)
{
	return self getcacplayerdata("loadouts",param_00,"perks",param_01);
}

//Function Number: 13
cac_getkillstreak(param_00,param_01)
{
	return self getcacplayerdata("loadouts",param_00,"killstreaks",param_01);
}

//Function Number: 14
cac_getkillstreakwithtype(param_00,param_01,param_02)
{
	var_03 = undefined;
	switch(param_01)
	{
		case "streaktype_support":
			var_03 = "supportStreaks";
			break;

		case "streaktype_specialist":
			var_03 = "specialistStreaks";
			break;

		default:
			var_03 = "assaultStreaks";
			break;
	}

	return self getcacplayerdata("loadouts",param_00,var_03,param_02);
}

//Function Number: 15
func_18F8(param_00)
{
	return self getcacplayerdata("loadouts",param_00,"type");
}

//Function Number: 16
func_18FC(param_00)
{
	return self getcacplayerdata("loadouts",param_00,"perks",0);
}

//Function Number: 17
cac_getsecondarygrenade(param_00)
{
	return self getcacplayerdata("loadouts",param_00,"perks",1);
}

//Function Number: 18
recipe_getkillstreak(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	switch(param_02)
	{
		case "streaktype_support":
			var_04 = "supportStreaks";
			break;

		case "streaktype_specialist":
			var_04 = "specialistStreaks";
			break;

		default:
			var_04 = "assaultStreaks";
			break;
	}

	return getmatchrulesdata("defaultClasses",param_00,param_01,"class",var_04,param_03);
}

//Function Number: 19
func_7E4F(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimary",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondary",param_01 + 1);
}

//Function Number: 20
func_7E50(param_00,param_01,param_02,param_03)
{
	var_04 = "none";
	if(param_02 == 0)
	{
		if(!isdefined(param_03) || param_03 == 0)
		{
			var_04 = tablelookup(param_00,0,"loadoutPrimaryAttachment",param_01 + 1);
		}
		else if(param_03 == 1)
		{
			var_04 = tablelookup(param_00,0,"loadoutPrimaryAttachment2",param_01 + 1);
		}
		else if(param_03 == 2)
		{
			var_04 = tablelookup(param_00,0,"loadoutPrimaryAttachment3",param_01 + 1);
		}
	}
	else if(!isdefined(param_03) || param_03 == 0)
	{
		var_04 = tablelookup(param_00,0,"loadoutSecondaryAttachment",param_01 + 1);
	}
	else
	{
		var_04 = tablelookup(param_00,0,"loadoutSecondaryAttachment2",param_01 + 1);
	}

	if(var_04 == "" || var_04 == "none")
	{
		return "none";
	}

	return var_04;
}

//Function Number: 21
table_getweaponbuff(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryBuff",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryBuff",param_01 + 1);
}

//Function Number: 22
func_7E52(param_00,param_01,param_02)
{
	return "none";
}

//Function Number: 23
table_getweaponreticle(param_00,param_01,param_02)
{
	return "none";
}

//Function Number: 24
func_7E4A(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,"loadoutEquipment",param_01 + 1);
}

//Function Number: 25
func_7E4D(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,"loadoutPerk" + param_02,param_01 + 1);
}

//Function Number: 26
func_7E4E(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutTeamPerk",param_01 + 1);
}

//Function Number: 27
func_7E4C(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutOffhand",param_01 + 1);
}

//Function Number: 28
func_7E4B(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,"loadoutStreak" + param_02,param_01 + 1);
}

//Function Number: 29
func_7E49(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutCharacterType",param_01 + 1);
}

//Function Number: 30
func_4EA1(param_00,param_01)
{
	switch(param_00)
	{
		case "streaktype_support":
			self.streaktype = "support";
			break;

		case "streaktype_specialist":
			self.streaktype = "specialist";
			break;

		default:
			self.streaktype = "assault";
			break;
	}
}

//Function Number: 31
func_3B17(param_00)
{
	if(!isdefined(param_00))
	{
		return "streaktype_assault";
	}

	switch(param_00)
	{
		case "support":
			return "streaktype_support";

		case "specialist":
			return "streaktype_specialist";

		case "assault":
			return "streaktype_assault";

		default:
			return "streaktype_assault";
	}
}

//Function Number: 32
giveloadout(param_00,param_01,param_02)
{
	self.gettingloadout = 1;
	self takeallweapons();
	self.changingweapon = undefined;
	var_03 = "none";
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_04 = 0;
	self.specialty = [];
	var_05 = undefined;
	var_06 = 0;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	var_0A = [];
	if(issubstr(param_01,"axis"))
	{
		var_03 = "axis";
	}
	else if(issubstr(param_01,"allies"))
	{
		var_03 = "allies";
	}

	if(var_03 != "none")
	{
		var_0B = maps\mp\_utility::func_3A55(param_01);
		self.class_num = var_0B;
		self.teamname = var_03;
		var_0C = "none";
		var_0D = "none";
		var_0E = "none";
		var_0F = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",0,"weapon");
		if(var_0F == "none")
		{
			var_0F = "iw6_knifeonly";
			var_10 = "none";
			var_0C = "none";
			var_0D = "none";
		}
		else
		{
			var_10 = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",0,"attachment",0);
			var_0C = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",0,"attachment",1);
			var_0D = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",0,"attachment",2);
		}

		var_11 = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",0,"buff");
		var_12 = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",0,"camo");
		var_13 = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",0,"reticle");
		var_14 = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",1,"weapon");
		var_15 = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",1,"attachment",0);
		var_0E = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",1,"attachment",1);
		var_16 = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",1,"buff");
		var_17 = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",1,"camo");
		var_18 = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","weaponSetups",1,"reticle");
		if((var_0F == "throwingknife" || var_0F == "none") && var_14 != "none")
		{
			var_0F = var_14;
			var_10 = var_15;
			var_0C = var_0E;
			var_11 = var_16;
			var_12 = var_17;
			var_13 = var_18;
			var_14 = "none";
			var_15 = "none";
			var_0E = "none";
			var_16 = "specialty_null";
			var_17 = "none";
			var_18 = "none";
		}
		else if((var_0F == "throwingknife" || var_0F == "none") && var_14 == "none")
		{
			var_06 = 1;
			var_0F = "iw6_p226";
			var_10 = "tactical";
		}

		var_19 = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","perks",0);
		var_1A = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","perks",5);
		if(var_1A == "specialty_null")
		{
			var_07 = "none";
			var_08 = "none";
			var_09 = "none";
		}
		else
		{
			var_07 = recipe_getkillstreak(var_03,var_0B,var_1A,0);
			var_08 = recipe_getkillstreak(var_03,var_0B,var_1A,1);
			var_09 = recipe_getkillstreak(var_03,var_0B,var_1A,2);
		}

		var_1B = getmatchrulesdata("defaultClasses",var_03,var_0B,"class","perks",1);
		if(var_1B == "specialty_null")
		{
			var_1B = "none";
		}

		if(getmatchrulesdata("defaultClasses",var_03,var_0B,"juggernaut"))
		{
			thread maps\mp\_utility::recipeclassapplyjuggernaut(maps\mp\_utility::isjuggernaut());
			self.isjuggernaut = 1;
			self.juggmovespeedscaler = 0.7;
		}
		else if(maps\mp\_utility::isjuggernaut())
		{
			self notify("lost_juggernaut");
			self.isjuggernaut = 0;
			self.movespeedscaler = 1;
		}
	}
	else if(issubstr(var_12,"custom"))
	{
		var_1C = maps\mp\_utility::func_3A55(var_12);
		self.class_num = var_1C;
		var_0F = cac_getweapon(var_1C,0);
		var_10 = cac_getweaponattachment(var_1C,0);
		var_0C = cac_getweaponattachmenttwo(var_1C,0);
		var_0D = func_1900(var_1C,0);
		var_11 = cac_getweaponbuff(var_1C,0);
		var_12 = cac_getweaponcamo(var_1C,0);
		var_13 = cac_getweaponreticle(var_1C,0);
		var_14 = cac_getweapon(var_1C,1);
		var_15 = cac_getweaponattachment(var_1C,1);
		var_0E = cac_getweaponattachmenttwo(var_1C,1);
		var_16 = cac_getweaponbuff(var_1C,1);
		var_17 = cac_getweaponcamo(var_1C,1);
		var_18 = cac_getweaponreticle(var_1C,1);
		var_19 = func_18FC(var_1C);
		var_1B = cac_getsecondarygrenade(var_1C);
		var_1A = cac_getperk(var_1C,5);
		self.character_type = func_18F8(var_1C);
	}
	else if(var_12 == "gamemode")
	{
		var_1C = maps\mp\_utility::func_3A55(var_12);
		self.class_num = var_1C;
		var_1D = self.pers["gamemodeLoadout"];
		var_0F = common_scripts\utility::func_803F(isdefined(var_1D["loadoutPrimary"]),var_1D["loadoutPrimary"],"none");
		var_10 = common_scripts\utility::func_803F(isdefined(var_1D["loadoutPrimaryAttachment"]),var_1D["loadoutPrimaryAttachment"],"none");
		var_0C = common_scripts\utility::func_803F(isdefined(var_1D["loadoutPrimaryAttachment2"]),var_1D["loadoutPrimaryAttachment2"],"none");
		var_0D = common_scripts\utility::func_803F(isdefined(var_1D["loadoutPrimaryAttachment3"]),var_1D["loadoutPrimaryAttachment3"],"none");
		var_11 = common_scripts\utility::func_803F(isdefined(var_1D["loadoutPrimaryBuff"]),var_1D["loadoutPrimaryBuff"],"specialty_null");
		var_12 = common_scripts\utility::func_803F(isdefined(var_1D["loadoutPrimaryCamo"]),var_1D["loadoutPrimaryCamo"],"none");
		var_13 = common_scripts\utility::func_803F(isdefined(var_1D["loadoutPrimaryReticle"]),var_1D["loadoutPrimaryReticle"],"none");
		var_14 = common_scripts\utility::func_803F(isdefined(var_1D["loadoutSecondary"]),var_1D["loadoutSecondary"],"none");
		var_15 = common_scripts\utility::func_803F(isdefined(var_1D["loadoutSecondaryAttachment"]),var_1D["loadoutSecondaryAttachment"],"none");
		var_0E = common_scripts\utility::func_803F(isdefined(var_1D["loadoutSecondaryAttachment2"]),var_1D["loadoutSecondaryAttachment2"],"none");
		var_16 = common_scripts\utility::func_803F(isdefined(var_1D["loadoutSecondaryBuff"]),var_1D["loadoutSecondaryBuff"],"specialty_null");
		var_17 = common_scripts\utility::func_803F(isdefined(var_1D["loadoutSecondaryCamo"]),var_1D["loadoutSecondaryCamo"],"none");
		var_18 = common_scripts\utility::func_803F(isdefined(var_1D["loadoutSecondaryReticle"]),var_1D["loadoutSecondaryReticle"],"none");
		var_0A = common_scripts\utility::func_803F(isdefined(var_1D["loadoutPerks"]),var_1D["loadoutPerks"],[]);
		if((var_0F == "throwingknife" || var_0F == "none") && var_14 != "none")
		{
			var_0F = var_14;
			var_10 = var_15;
			var_0C = var_0E;
			var_11 = var_16;
			var_12 = var_17;
			var_13 = var_18;
			var_14 = "none";
			var_15 = "none";
			var_0E = "none";
			var_16 = "specialty_null";
			var_17 = "none";
			var_18 = "none";
		}
		else if((var_0F == "throwingknife" || var_0F == "none") && var_14 == "none")
		{
			var_06 = 1;
			var_0F = "iw6_p226";
			var_10 = "tactical";
		}

		var_19 = var_1D["loadoutEquipment"];
		var_1B = var_1D["loadoutOffhand"];
		if(var_1B == "specialty_null")
		{
			var_1B = "none";
		}

		if(level.killstreakrewards && isdefined(var_1D["loadoutStreakType"]) && var_1D["loadoutStreakType"] != "specialty_null")
		{
			var_1A = var_1D["loadoutStreakType"];
			var_07 = var_1D["loadoutKillstreak1"];
			var_08 = var_1D["loadoutKillstreak2"];
			var_09 = var_1D["loadoutKillstreak3"];
		}
		else if(level.killstreakrewards && isdefined(self.streaktype))
		{
			var_1A = func_3B17(self.streaktype);
		}
		else
		{
			var_1A = "streaktype_assault";
			var_07 = "none";
			var_08 = "none";
			var_09 = "none";
		}

		if(var_1D["loadoutJuggernaut"])
		{
			self.health = self.maxhealth;
			thread maps\mp\_utility::recipeclassapplyjuggernaut(maps\mp\_utility::isjuggernaut());
			self.isjuggernaut = 1;
			self.juggmovespeedscaler = 0.7;
		}
		else if(maps\mp\_utility::isjuggernaut())
		{
			self notify("lost_juggernaut");
			self.isjuggernaut = 0;
			self.movespeedscaler = 1;
		}
	}
	else if(var_12 == "juggernaut")
	{
		var_0F = "iw6_minigunjugg";
		var_10 = "none";
		var_17 = "none";
		var_18 = "none";
		var_11 = "specialty_null";
		var_12 = "none";
		var_13 = "none";
		var_14 = "iw6_p226jugg";
		var_15 = "none";
		var_14 = "none";
		var_16 = "specialty_null";
		var_17 = "none";
		var_18 = "none";
		var_19 = "mortar_shelljugg_mp";
		var_1A = func_3B17(self.streaktype);
		var_1B = "none";
	}
	else if(var_12 == "juggernaut_recon")
	{
		var_0F = "iw6_riotshieldjugg";
		var_10 = "none";
		var_17 = "none";
		var_18 = "none";
		var_11 = "specialty_null";
		var_12 = "none";
		var_13 = "none";
		var_14 = "iw6_magnumjugg";
		var_15 = "none";
		var_14 = "none";
		var_16 = "specialty_null";
		var_17 = "none";
		var_18 = "none";
		var_19 = "specialty_null";
		var_1A = func_3B17(self.streaktype);
		var_1B = "smoke_grenadejugg_mp";
	}
	else if(var_12 == "juggernaut_maniac")
	{
		var_0F = "iw6_knifeonlyjugg";
		var_10 = "none";
		var_17 = "none";
		var_18 = "none";
		var_11 = "specialty_null";
		var_12 = "none";
		var_13 = "none";
		var_14 = "none";
		var_15 = "none";
		var_14 = "none";
		var_16 = "specialty_null";
		var_17 = "none";
		var_18 = "none";
		var_19 = "throwingknifejugg_mp";
		var_1A = func_3B17(self.streaktype);
		var_1B = "none";
	}
	else if(maps\mp\_utility::func_4971(var_12,"juggernaut_"))
	{
		var_1E = [[ level.mapcustomjuggsetclass ]](var_12);
		var_0F = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimary"]),var_1E["loadoutPrimary"],"none");
		var_10 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryAttachment"]),var_1E["loadoutPrimaryAttachment"],"none");
		var_0C = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryAttachment2"]),var_1E["loadoutPrimaryAttachment2"],"none");
		var_0D = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryAttachment3"]),var_1E["loadoutPrimaryAttachment3"],"none");
		var_11 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryBuff"]),var_1E["loadoutPrimaryBuff"],"specialty_null");
		var_12 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryCamo"]),var_1E["loadoutPrimaryCamo"],"none");
		var_13 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryReticle"]),var_1E["loadoutPrimaryReticle"],"none");
		var_14 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondary"]),var_1E["loadoutSecondary"],"none");
		var_15 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondaryAttachment"]),var_1E["loadoutSecondaryAttachment"],"none");
		var_0E = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondaryAttachment2"]),var_1E["loadoutSecondaryAttachment2"],"none");
		var_16 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondaryBuff"]),var_1E["loadoutSecondaryBuff"],"specialty_null");
		var_17 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondaryCamo"]),var_1E["loadoutSecondaryCamo"],"none");
		var_18 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondaryReticle"]),var_1E["loadoutSecondaryReticle"],"none");
		var_19 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutEquipment"]),var_1E["loadoutEquipment"],"none");
		var_1B = common_scripts\utility::func_803F(isdefined(var_1E["loadoutOffhand"]),var_1E["loadoutOffhand"],"none");
		var_1A = func_3B17(self.streaktype);
	}
	else if(var_12 == "reconAgent")
	{
		var_0F = "iw6_riotshield";
		var_10 = "none";
		var_17 = "none";
		var_18 = "none";
		var_11 = "specialty_null";
		var_12 = "none";
		var_13 = "none";
		var_14 = "iw6_mp443";
		var_15 = "none";
		var_14 = "none";
		var_16 = "specialty_null";
		var_17 = "none";
		var_18 = "none";
		var_19 = "specialty_null";
		var_1A = "streaktype_assault";
		var_1B = "none";
		var_07 = "none";
		var_08 = "none";
		var_09 = "none";
	}
	else if(var_12 == "callback")
	{
		if(!isdefined(self.classcallback))
		{
			common_scripts\utility::error("self.classCallback function reference required for class \'callback\'");
		}

		var_1E = [[ self.classcallback ]]();
		if(!isdefined(var_1E))
		{
			common_scripts\utility::error("array required from self.classCallback for class \'callback\'");
		}

		var_0F = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimary"]),var_1E["loadoutPrimary"],"none");
		var_10 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryAttachment"]),var_1E["loadoutPrimaryAttachment"],"none");
		var_0C = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryAttachment2"]),var_1E["loadoutPrimaryAttachment2"],"none");
		var_0D = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryAttachment3"]),var_1E["loadoutPrimaryAttachment3"],"none");
		var_11 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryBuff"]),var_1E["loadoutPrimaryBuff"],"specialty_null");
		var_12 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryCamo"]),var_1E["loadoutPrimaryCamo"],"none");
		var_13 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutPrimaryReticle"]),var_1E["loadoutPrimaryReticle"],"none");
		var_14 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondary"]),var_1E["loadoutSecondary"],"none");
		var_15 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondaryAttachment"]),var_1E["loadoutSecondaryAttachment"],"none");
		var_0E = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondaryAttachment2"]),var_1E["loadoutSecondaryAttachment2"],"none");
		var_16 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondaryBuff"]),var_1E["loadoutSecondaryBuff"],"specialty_null");
		var_17 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondaryCamo"]),var_1E["loadoutSecondaryCamo"],"none");
		var_18 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutSecondaryReticle"]),var_1E["loadoutSecondaryReticle"],"none");
		var_19 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutEquipment"]),var_1E["loadoutEquipment"],"none");
		var_1B = common_scripts\utility::func_803F(isdefined(var_1E["loadoutOffhand"]),var_1E["loadoutOffhand"],"none");
		var_1A = common_scripts\utility::func_803F(isdefined(var_1E["loadoutStreakType"]),var_1E["loadoutStreakType"],"none");
		var_07 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutStreak1"]),var_1E["loadoutStreak1"],"none");
		var_08 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutStreak2"]),var_1E["loadoutStreak2"],"none");
		var_09 = common_scripts\utility::func_803F(isdefined(var_1E["loadoutStreak3"]),var_1E["loadoutStreak3"],"none");
		self.character_type = var_1E["loadoutCharacterType"];
	}
	else
	{
		var_1C = maps\mp\_utility::func_3A55(var_12);
		self.class_num = var_1C;
		var_0F = func_7E4F(level.classtablename,var_1C,0);
		var_10 = func_7E50(level.classtablename,var_1C,0,0);
		var_0C = func_7E50(level.classtablename,var_1C,0,1);
		var_0D = func_7E50(level.classtablename,var_1C,0,2);
		var_11 = table_getweaponbuff(level.classtablename,var_1C,0);
		var_12 = func_7E52(level.classtablename,var_1C,0);
		var_13 = table_getweaponreticle(level.classtablename,var_1C,0);
		var_14 = func_7E4F(level.classtablename,var_1C,1);
		var_15 = func_7E50(level.classtablename,var_1C,1,0);
		var_0E = func_7E50(level.classtablename,var_1C,1,1);
		var_16 = table_getweaponbuff(level.classtablename,var_1C,1);
		var_17 = func_7E52(level.classtablename,var_1C,1);
		var_18 = table_getweaponreticle(level.classtablename,var_1C,1);
		var_19 = func_7E4A(level.classtablename,var_1C,0);
		var_1A = "specialty_null";
		var_1B = "specialty_null";
		self.character_type = func_7E49(level.classtablename,var_1C);
	}

	var_0F = common_scripts\utility::func_803F(var_0F == "uav","iw6_knifeonlyfast",var_0F);
	var_14 = common_scripts\utility::func_803F(var_14 == "uav","iw6_knifeonlyfast",var_14);
	var_14 = common_scripts\utility::func_803F(var_14 == "laser_designator","iw6_pdwauto",var_14);
	func_4EA1(var_1A);
	var_1F = issubstr(param_01,"custom");
	var_20 = issubstr(param_01,"recipe");
	var_21 = param_01 == "gamemode";
	var_22 = param_01 == "callback";
	if(!var_21 && !var_20 && !var_22)
	{
		if(!func_49A6(var_0F) || level.rankedmatch && var_1F && !self isitemunlocked(var_0F))
		{
			var_0F = func_7E4F(level.classtablename,10,0);
		}

		if(!isvalidattachment(var_10,var_0F) || level.rankedmatch && var_1F && !isattachmentunlocked(var_0F,var_10))
		{
			var_10 = func_7E50(level.classtablename,10,0,0);
		}

		if(!isvalidattachment(var_0C,var_0F) || level.rankedmatch && var_1F && !isattachmentunlocked(var_0F,var_0C))
		{
			var_0C = func_7E50(level.classtablename,10,0,1);
		}

		if(!isvalidattachment(var_0D,var_0F) || level.rankedmatch && var_1F && !isattachmentunlocked(var_0F,var_0D))
		{
			var_0D = func_7E50(level.classtablename,10,0,2);
		}

		if(!func_49AE(var_11,var_0F) || level.rankedmatch && var_1F && !isweaponbuffunlocked(var_0F,var_11))
		{
			var_11 = table_getweaponbuff(level.classtablename,10,0);
		}

		if(!func_499B(var_12) || level.rankedmatch && var_1F && !func_4894(var_0F,var_12))
		{
			var_12 = func_7E52(level.classtablename,10,0);
		}

		if(!func_49A7(var_13))
		{
			var_13 = table_getweaponreticle(level.classtablenum,10,0);
		}

		if(!isvalidattachment(var_15,var_14) || level.rankedmatch && var_1F && !isattachmentunlocked(var_14,var_15))
		{
			var_15 = func_7E50(level.classtablename,10,1,0);
		}

		if(!isvalidattachment(var_0E,var_14) || level.rankedmatch && var_1F && !isattachmentunlocked(var_14,var_0E))
		{
			var_0E = func_7E50(level.classtablename,10,1,1);
		}

		if(!func_49AE(var_16,var_14) || level.rankedmatch && var_1F && !self isitemunlocked(var_14 + " " + var_16))
		{
			var_16 = table_getweaponbuff(level.classtablename,10,1);
		}

		if(!func_499B(var_17) || level.rankedmatch && var_1F && !func_4894(var_14,var_17))
		{
			var_17 = func_7E52(level.classtablename,10,1);
		}

		if(!func_49A7(var_18))
		{
			var_18 = table_getweaponreticle(level.classtablename,10,1);
		}

		if(!func_499E(var_19) || level.rankedmatch && var_1F && !self isitemunlocked(var_19))
		{
			var_19 = func_7E4A(level.classtablename,10,0);
		}

		if(!func_49A2(var_1B))
		{
			var_1B = func_7E4C(level.classtablename,10);
		}
	}

	maps\mp\_utility::_clearperks();
	_detachall();
	if(level.diehardmode)
	{
		maps\mp\_utility::func_3CFB("specialty_pistoldeath",0);
	}

	if(!maps\mp\_utility::func_47BB())
	{
		func_4E9F(var_19,var_1B,var_0A,param_01 != "gamemode",param_01,var_03);
	}

	self.spawnperk = 0;
	if(!maps\mp\_utility::isjuggernaut() && isdefined(self.avoidkillstreakonspawntimer) && self.avoidkillstreakonspawntimer > 0)
	{
		thread maps\mp\perks\_perks::giveperksafterspawn();
	}

	var_23 = !maps\mp\_utility::perksenabled() || !maps\mp\_utility::_hasperk("specialty_twoprimaries");
	if(var_14 != "none" && !isvalidsecondary(var_14,0,var_23))
	{
		var_14 = "none";
		var_15 = "none";
		var_0E = "none";
		var_16 = "specialty_null";
		var_17 = "none";
		var_18 = "none";
	}

	self.loadoutprimary = var_0F;
	if(isdefined(var_12))
	{
		self.loadoutprimarycamo = int(tablelookup("mp/camoTable.csv",1,var_12,4));
	}

	self.loadoutsecondary = var_14;
	if(isdefined(var_17))
	{
		self.loadoutsecondarycamo = int(tablelookup("mp/camoTable.csv",1,var_17,4));
	}

	self.loadoutprimaryattachments = [];
	if(isdefined(var_10) && var_10 != "none")
	{
		self.loadoutprimaryattachments[self.loadoutprimaryattachments.size] = var_10;
	}

	if(isdefined(var_0C) && var_0C != "none")
	{
		self.loadoutprimaryattachments[self.loadoutprimaryattachments.size] = var_0C;
	}

	if(isdefined(var_0D) && var_0D != "none")
	{
		self.loadoutprimaryattachments[self.loadoutprimaryattachments.size] = var_0D;
	}

	self.loadoutsecondaryattachments = [];
	if(isdefined(var_15) && var_15 != "none")
	{
		self.loadoutsecondaryattachments[self.loadoutsecondaryattachments.size] = var_15;
	}

	if(isdefined(var_0E) && var_0E != "none")
	{
		self.loadoutsecondaryattachments[self.loadoutsecondaryattachments.size] = var_0E;
	}

	if(!issubstr(var_0F,"iw5") && !issubstr(var_0F,"iw6"))
	{
		self.loadoutprimarycamo = 0;
	}

	if(!issubstr(var_14,"iw5") && !issubstr(var_14,"iw6"))
	{
		self.loadoutsecondarycamo = 0;
	}

	self.loadoutprimaryreticle = int(tablelookup("mp/reticleTable.csv",1,var_13,5));
	self.loadoutsecondaryreticle = int(tablelookup("mp/reticleTable.csv",1,var_18,5));
	if(!issubstr(var_0F,"iw5") && !issubstr(var_0F,"iw6"))
	{
		self.loadoutprimaryreticle = 0;
	}

	if(!issubstr(var_14,"iw5") && !issubstr(var_14,"iw6"))
	{
		self.loadoutsecondaryreticle = 0;
	}

	maps\mp\_utility::_setactionslot(1,"");
	maps\mp\_utility::_setactionslot(2,"");
	maps\mp\_utility::_setactionslot(3,"altMode");
	maps\mp\_utility::_setactionslot(4,"");
	if(!level.console)
	{
		maps\mp\_utility::_setactionslot(5,"");
		maps\mp\_utility::_setactionslot(6,"");
		maps\mp\_utility::_setactionslot(7,"");
	}

	if(level.killstreakrewards && !isdefined(var_07) && !isdefined(var_08) && !isdefined(var_09))
	{
		var_24 = undefined;
		var_25 = undefined;
		var_26 = undefined;
		var_27 = undefined;
		switch(self.streaktype)
		{
			case "support":
				var_24 = func_7E4B(level.classtablename,2,0);
				var_25 = func_7E4B(level.classtablename,2,1);
				var_26 = func_7E4B(level.classtablename,2,2);
				var_27 = "supportStreaks";
				break;

			case "specialist":
				var_24 = func_7E4B(level.classtablename,1,0);
				var_25 = func_7E4B(level.classtablename,1,1);
				var_26 = func_7E4B(level.classtablename,1,2);
				var_27 = "specialistStreaks";
				break;

			default:
				var_24 = func_7E4B(level.classtablename,0,0);
				var_25 = func_7E4B(level.classtablename,0,1);
				var_26 = func_7E4B(level.classtablename,0,2);
				var_27 = "assaultStreaks";
				break;
		}

		var_07 = undefined;
		var_08 = undefined;
		var_09 = undefined;
		if(issubstr(param_01,"custom"))
		{
			var_07 = self getcacplayerdata("loadouts",self.class_num,var_27,0);
			var_08 = self getcacplayerdata("loadouts",self.class_num,var_27,1);
			var_09 = self getcacplayerdata("loadouts",self.class_num,var_27,2);
		}

		if(issubstr(param_01,"juggernaut") || var_21)
		{
			foreach(var_29 in self.killstreaks)
			{
				if(!isdefined(var_07))
				{
					var_07 = var_29;
					continue;
				}

				if(!isdefined(var_08))
				{
					var_08 = var_29;
					continue;
				}

				if(!isdefined(var_09))
				{
					var_09 = var_29;
				}
			}

			if(var_21 && self.streaktype == "specialist")
			{
				self.pers["gamemodeLoadout"]["loadoutKillstreak1"] = var_07;
				self.pers["gamemodeLoadout"]["loadoutKillstreak2"] = var_08;
				self.pers["gamemodeLoadout"]["loadoutKillstreak3"] = var_09;
			}
		}

		if(!issubstr(param_01,"custom") && !issubstr(param_01,"juggernaut") && !var_21)
		{
			var_07 = var_24;
			var_08 = var_25;
			var_09 = var_26;
		}

		if(!isdefined(var_07) || var_07 == "")
		{
			var_07 = "none";
		}

		if(!isdefined(var_08) || var_08 == "")
		{
			var_08 = "none";
		}

		if(!isdefined(var_09) || var_09 == "")
		{
			var_09 = "none";
		}

		if(!func_49A1(var_07,self.streaktype) || var_1F && !self isitemunlocked(var_07) || !func_49A1(var_08,self.streaktype) || var_1F && !self isitemunlocked(var_08) || !func_49A1(var_09,self.streaktype) || var_1F && !self isitemunlocked(var_09))
		{
			var_07 = "none";
			var_08 = "none";
			var_09 = "none";
		}
	}
	else if(!level.killstreakrewards)
	{
		var_07 = "none";
		var_08 = "none";
		var_09 = "none";
	}

	func_705F(var_07,var_08,var_09);
	if(!isagent(self) && func_4002() || self.class == "callback" && !issubstr(self.class,"juggernaut") && !issubstr(self.lastclass,"juggernaut") && !issubstr(param_01,"juggernaut"))
	{
		if(maps\mp\_utility::func_8C4A() || self.lastclass != "")
		{
			var_2B = [];
			var_2C = [];
			var_2D = 0;
			var_2E = self.pers["killstreaks"];
			if(var_2E.size > 5)
			{
				for(var_2F = 5;var_2F < var_2E.size;var_2F++)
				{
					var_2B[var_2D] = var_2E[var_2F].streakname;
					var_2C[var_2D] = var_2E[var_2F].kid;
					var_2D++;
				}
			}

			if(var_2E.size)
			{
				for(var_2F = 1;var_2F < 4;var_2F++)
				{
					if(isdefined(var_2E[var_2F]) && isdefined(var_2E[var_2F].streakname) && var_2E[var_2F].available && !var_2E[var_2F].isspecialist)
					{
						var_2B[var_2D] = var_2E[var_2F].streakname;
						var_2C[var_2D] = var_2E[var_2F].kid;
						var_2D++;
					}
				}
			}

			self notify("givingLoadout");
			maps\mp\killstreaks\_killstreaks::clearkillstreaks();
			for(var_2F = 0;var_2F < var_2B.size;var_2F++)
			{
				maps\mp\killstreaks\_killstreaks::func_3CF2(var_2B[var_2F],undefined,undefined,undefined,undefined,var_2C[var_2F]);
			}
		}
	}

	if(!issubstr(param_01,"juggernaut"))
	{
		if(func_4002())
		{
			maps\mp\_utility::func_447B("mostclasseschanged",1);
			self notify("changed_class");
		}

		self.pers["lastClass"] = self.class;
		self.lastclass = self.class;
	}

	if(isdefined(self.gamemode_chosenclass))
	{
		self.pers["class"] = self.gamemode_chosenclass;
		self.pers["lastClass"] = self.gamemode_chosenclass;
		self.class = self.gamemode_chosenclass;
		self.lastclass = self.gamemode_chosenclass;
		self.gamemode_chosenclass = undefined;
	}

	var_30 = [var_10,var_0C];
	if(maps\mp\_utility::perksenabled() && maps\mp\_utility::_hasperk("specialty_extra_attachment"))
	{
		var_30[var_30.size] = var_0D;
	}

	var_31 = 0;
	foreach(var_33 in var_30)
	{
		if(maps\mp\_utility::getattachmenttype(var_33) == "rail")
		{
			var_31 = 1;
			break;
		}
	}

	if(!var_31)
	{
		self.loadoutprimaryreticle = 0;
	}

	var_35 = buildweaponname(var_0F,var_30,self.loadoutprimarycamo,self.loadoutprimaryreticle);
	maps\mp\_utility::_giveweapon(var_35);
	if(!isai(self))
	{
		self.saved_lastweaponhack = undefined;
		self switchtoweapon(var_35);
	}

	var_36 = maps\mp\_utility::func_3A37(var_35);
	if(maps\mp\gametypes\_weapons::func_494E(var_35) && level.ingraceperiod)
	{
		self notify("weapon_change",var_35);
	}

	if(param_02)
	{
		self setspawnweapon(var_35);
	}

	if(var_06)
	{
		self setweaponammoclip(self.primaryweapon,0);
		self setweaponammostock(self.primaryweapon,0);
	}

	maps\mp\gametypes\_weapons::updatetogglescopestate(var_35);
	if(var_14 == "none")
	{
		var_37 = "none";
	}
	else
	{
		var_31 = [var_16];
		if(maps\mp\_utility::perksenabled() && maps\mp\_utility::_hasperk("specialty_extra_attachment"))
		{
			var_31[var_31.size] = var_0F;
		}

		var_37 = buildweaponname(var_15,var_31,self.loadoutsecondarycamo,self.loadoutsecondaryreticle);
		maps\mp\_utility::_giveweapon(var_37);
		var_36 = maps\mp\_utility::func_3A37(var_37);
		maps\mp\gametypes\_weapons::updatetogglescopestate(var_37);
	}

	self.primaryweapon = var_35;
	self.secondaryweapon = var_37;
	self.pers["primaryWeapon"] = var_35;
	self.pers["secondaryWeapon"] = var_37;
	maps\mp\gametypes\_teams::func_7205();
	self.issniper = weaponclass(self.primaryweapon) == "sniper";
	maps\mp\gametypes\_weapons::func_8707();
	maps\mp\perks\_perks::cac_selector();
	var_38 = isai(self) && issquadsmode() && !maps\mp\_utility::func_8FFB();
	if(!maps\mp\_utility::isjuggernaut() && !isai(self) || var_38 && !var_21)
	{
		var_39 = 0;
		if(var_19 == "specialty_null")
		{
			var_39 = var_39 + 1;
		}

		if(var_1B == "specialty_null" || var_1B == "none")
		{
			var_39 = var_39 + 1;
		}

		if(var_0F == "iw6_knifeonly" || var_0F == "iw6_knifeonlyfast")
		{
			var_39 = var_39 + 1;
		}

		if(var_14 == "none" || var_14 == "iw6_knifeonlyfast")
		{
			var_39 = var_39 + 1;
		}

		if(!isvalidperkweight(8 + var_39,self.pers["loadoutPerks"],1))
		{
			maps\mp\_utility::_clearperks();
			self setclientomnvar("ui_spawn_abilities1",0);
			self setclientomnvar("ui_spawn_abilities2",0);
			self.pers["loadoutPerks"] = [];
		}
	}

	self.gettingloadout = 0;
	self notify("changed_kit");
	self notify("giveLoadout");
}

//Function Number: 33
hasvalidationinfraction()
{
	return isdefined(self.pers) && isdefined(self.pers["validationInfractions"]) && self.pers["validationInfractions"] > 0;
}

//Function Number: 34
recordvalidationinfraction()
{
	if(isdefined(self.pers) && isdefined(self.pers["validationInfractions"]))
	{
		self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
	}
}

//Function Number: 35
isvalidperkweight(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = 0;
	foreach(var_05 in param_01)
	{
		switch(var_05)
		{
			case "specialty_null":
				var_03 = var_03 + 0;
				break;

			case "specialty_gambler":
			case "specialty_extra_equipment":
			case "specialty_falldamage":
			case "specialty_paint":
			case "specialty_silentkill":
			case "specialty_sprintreload":
			case "specialty_pitcher":
			case "specialty_fastsprintrecovery":
				var_03 = var_03 + 1;
				break;

			case "specialty_boom":
			case "specialty_extraammo":
			case "specialty_extra_deadly":
			case "_specialty_blastshield":
			case "specialty_regenfaster":
			case "specialty_selectivehearing":
			case "specialty_detectexplosive":
			case "specialty_scavenger":
			case "specialty_quieter":
			case "specialty_marathon":
			case "specialty_lightweight":
			case "specialty_fastreload":
			case "specialty_bulletaccuracy":
			case "specialty_quickswap":
			case "specialty_sharp_focus":
			case "specialty_blindeye":
			case "specialty_hardline":
			case "specialty_stun_resistance":
				var_03 = var_03 + 2;
				break;

			case "specialty_comexp":
			case "specialty_gpsjammer":
			case "specialty_quickdraw":
			case "specialty_stalker":
			case "specialty_extra_attachment":
			case "specialty_twoprimaries":
			case "specialty_incog":
				var_03 = var_03 + 3;
				break;

			case "specialty_explosivedamage":
				var_03 = var_03 + 4;
				break;

			case "specialty_deadeye":
				var_03 = var_03 + 5;
				break;

			default:
				if(param_02)
				{
				}
				break;
		}
	}

	if(var_03 > param_00 && param_02)
	{
		recordvalidationinfraction();
	}

	return var_03 <= param_00;
}

//Function Number: 36
_detachall()
{
	if(isdefined(self.riotshieldmodel))
	{
		maps\mp\_utility::riotshield_detach(1);
	}

	if(isdefined(self.riotshieldmodelstowed))
	{
		maps\mp\_utility::riotshield_detach(0);
	}

	self.hasriotshieldequipped = 0;
	self detachall();
}

//Function Number: 37
func_492E(param_00)
{
	var_01 = tablelookup("mp/perktable.csv",1,param_00,8);
	if(var_01 == "" || var_01 == "specialty_null")
	{
		return 0;
	}

	if(!self isitemunlocked(var_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 38
getperkupgrade(param_00)
{
	var_01 = tablelookup("mp/perktable.csv",1,param_00,8);
	if(var_01 == "" || var_01 == "specialty_null")
	{
		return "specialty_null";
	}

	if(!self isitemunlocked(var_01))
	{
		return "specialty_null";
	}

	return var_01;
}

//Function Number: 39
func_4E9F(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self;
	if(maps\mp\_utility::bot_is_fireteam_mode() && isbot(self))
	{
		if(!isdefined(self.fireteam_commander))
		{
		}

		var_06 = self.fireteam_commander;
	}
	else if(isai(self))
	{
		if(param_03)
		{
			param_00 = maps\mp\perks\_perks::validateequipment(param_00,1);
			param_01 = maps\mp\perks\_perks::validateequipment(param_01,0);
		}

		maps\mp\gametypes\_weapons::lethalstowed_clear();
		self.loadoutperkequipment = param_00;
		self.loadoutperkoffhand = param_01;
		maps\mp\_utility::giveperkequipment(param_00,1);
		maps\mp\_utility::func_3CFD(param_01,0);
		if(!isdefined(self.pers["loadoutPerks"]))
		{
			self.pers["loadoutPerks"] = [];
		}

		if(isdefined(param_02) && param_02.size > 0)
		{
			self.pers["loadoutPerks"] = param_02;
			maps\mp\perks\_abilities::func_3CFE(param_02,0);
		}
		else if(maps\mp\_utility::perksenabled())
		{
			var_07 = self.pers["loadoutPerks"];
			if(isdefined(var_07) && var_07.size > 0 && !maps\mp\_utility::isjuggernaut())
			{
				maps\mp\perks\_abilities::func_3CFE(var_07,1);
			}
		}
	}

	if(!isdefined(self.class_num))
	{
	}

	if(!maps\mp\_utility::isjuggernaut())
	{
		var_08 = [];
		if(isdefined(param_02) && param_02.size > 0)
		{
			var_08 = param_02;
			self.pers["loadoutPerks"] = var_08;
			maps\mp\perks\_abilities::func_3CFE(var_08,0);
		}
		else if(!maps\mp\_utility::perksenabled())
		{
			self.pers["loadoutPerks"] = var_08;
		}
		else
		{
			if(func_4002())
			{
				for(var_09 = 0;var_09 < 7;var_09++)
				{
					for(var_0A = 0;var_0A < 5;var_0A++)
					{
						var_0B = 0;
						if(param_05 != "none")
						{
							var_0C = maps\mp\_utility::func_3A55(param_04);
							var_0B = getmatchrulesdata("defaultClasses",param_05,var_0C,"class","abilitiesPicked",var_09,var_0A);
						}
						else
						{
							var_0B = self getcacplayerdata("loadouts",self.class_num,"abilitiesPicked",var_09,var_0A);
						}

						if(isdefined(var_0B) && var_0B)
						{
							var_0D = tablelookup("mp/cacAbilityTable.csv",0,var_09 + 1,4 + var_0A);
							var_08[var_08.size] = var_0D;
						}
					}
				}

				self.pers["loadoutPerks"] = var_08;
			}
			else
			{
				var_08 = self.pers["loadoutPerks"];
			}

			maps\mp\perks\_abilities::func_3CFE(var_08,1);
		}

		var_0E = [0,0];
		var_0F = self.pers["loadoutPerks"];
		for(var_10 = 0;var_10 < var_0F.size;var_10++)
		{
			var_11 = int(tablelookup("mp/killCamAbilitiesBitMaskTable.csv",1,var_0F[var_10],0));
			if(var_11 == 0)
			{
				continue;
			}

			var_12 = int(var_11 - 1 / 24);
			var_13 = 1 << var_11 - 1 % 24;
			var_0E[var_12] = var_0E[var_12] | var_13;
		}

		self setclientomnvar("ui_spawn_abilities1",var_0E[0]);
		self setclientomnvar("ui_spawn_abilities2",var_0E[1]);
		self.abilityflags = var_0E;
	}

	if(param_03)
	{
		param_00 = maps\mp\perks\_perks::validateequipment(param_00,1);
		param_01 = maps\mp\perks\_perks::validateequipment(param_01,0);
	}

	maps\mp\gametypes\_weapons::lethalstowed_clear();
	self.loadoutperkequipment = param_00;
	self.loadoutperkoffhand = param_01;
	maps\mp\_utility::giveperkequipment(param_00,1);
	maps\mp\_utility::func_3CFD(param_01,0);
}

//Function Number: 40
trackriotshield_ontrophystow()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_pullback",var_00);
		if(var_00 != "trophy_mp")
		{
			continue;
		}

		if(!isdefined(self.riotshieldmodel))
		{
			continue;
		}

		maps\mp\_utility::func_66D7(1);
		self waittill("offhand_end");
		if(maps\mp\gametypes\_weapons::func_494E(self getcurrentweapon()) && isdefined(self.riotshieldmodelstowed))
		{
			maps\mp\_utility::func_66D7(0);
		}
	}
}

//Function Number: 41
func_8229()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.hasriotshield = maps\mp\_utility::func_66D5();
	self.hasriotshieldequipped = maps\mp\gametypes\_weapons::func_494E(self.currentweaponatspawn);
	if(self.hasriotshield)
	{
		if(self.hasriotshieldequipped)
		{
			maps\mp\_utility::riotshield_attach(1,maps\mp\_utility::riotshield_getmodel());
		}
		else
		{
			maps\mp\_utility::riotshield_attach(0,maps\mp\_utility::riotshield_getmodel());
		}
	}

	thread trackriotshield_ontrophystow();
	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 == "none")
		{
			continue;
		}

		var_01 = maps\mp\gametypes\_weapons::func_494E(var_00);
		var_02 = !var_01 && maps\mp\_utility::func_66D5();
		if(var_01)
		{
			if(!isdefined(self.riotshieldmodel))
			{
				if(isdefined(self.riotshieldmodelstowed))
				{
					maps\mp\_utility::func_66D7(0);
				}
				else
				{
					maps\mp\_utility::riotshield_attach(1,maps\mp\_utility::riotshield_getmodel());
				}
			}
		}
		else if(var_02)
		{
			if(!isdefined(self.riotshieldmodelstowed))
			{
				if(isdefined(self.riotshieldmodel))
				{
					maps\mp\_utility::func_66D7(1);
				}
				else
				{
					maps\mp\_utility::riotshield_attach(0,maps\mp\_utility::riotshield_getmodel());
				}
			}
		}
		else
		{
			if(isdefined(self.riotshieldmodel))
			{
				maps\mp\_utility::riotshield_detach(1);
			}

			if(isdefined(self.riotshieldmodelstowed))
			{
				maps\mp\_utility::riotshield_detach(0);
			}
		}

		self.hasriotshield = var_01 || var_02;
		self.hasriotshieldequipped = var_01;
	}
}

//Function Number: 42
buildweaponname(param_00,param_01,param_02,param_03)
{
	param_01 = common_scripts\utility::array_remove(param_01,"none");
	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		param_01[var_04] = maps\mp\_utility::attachmentmap_tounique(param_01[var_04],param_00);
	}

	var_05 = "";
	if(issubstr(param_00,"iw5") || issubstr(param_00,"iw6"))
	{
		var_06 = param_00 + "_mp";
		var_07 = param_00.size;
		var_05 = getsubstr(param_00,4,var_07);
	}
	else
	{
		var_06 = param_01;
	}

	var_08 = maps\mp\_utility::getweaponclass(param_00);
	var_09 = var_08 == "weapon_sniper" || var_08 == "weapon_dmr" || param_00 == "iw6_dlcweap02";
	var_0A = 0;
	var_0B = 0;
	foreach(var_0D in param_01)
	{
		if(maps\mp\_utility::getattachmenttype(var_0D) == "rail")
		{
			var_0B = 1;
			var_0A = 1;
			break;
		}
	}

	if(var_09 && !var_0B)
	{
		param_01[param_01.size] = var_05 + "scope";
	}

	if(!var_0A && isdefined(param_03))
	{
		param_03 = 0;
	}

	if(isdefined(param_01.size) && param_01.size)
	{
		param_01 = common_scripts\utility::alphabetize(param_01);
	}

	foreach(var_0D in param_01)
	{
		var_06 = var_06 + "_" + var_0D;
	}

	if(issubstr(var_06,"iw5") || issubstr(var_06,"iw6"))
	{
		var_06 = func_186E(var_06,param_02);
		var_06 = buildweaponnamereticle(var_06,param_03);
	}
	else if(!func_49AD(var_06 + "_mp",0))
	{
		var_06 = param_00 + "_mp";
	}
	else
	{
		var_06 = func_186E(var_06,param_02);
		var_06 = buildweaponnamereticle(var_06,param_03);
		var_06 = var_06 + "_mp";
	}

	return var_06;
}

//Function Number: 43
func_186E(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 <= 0)
	{
		return param_00;
	}

	return param_00 + "_camo" + common_scripts\utility::func_803F(param_01 < 10,"0","") + param_01;
}

//Function Number: 44
buildweaponnamereticle(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 == 0)
	{
		return param_00;
	}

	param_00 = param_00 + "_scope" + param_01;
	return param_00;
}

//Function Number: 45
func_705F(param_00,param_01,param_02)
{
	self.killstreaks = [];
	var_03 = [];
	if(isdefined(param_00) && param_00 != "none")
	{
		var_04 = maps\mp\killstreaks\_killstreaks::func_3C16(param_00);
		var_03[var_04] = param_00;
	}

	if(isdefined(param_01) && param_01 != "none")
	{
		var_04 = maps\mp\killstreaks\_killstreaks::func_3C16(param_01);
		var_03[var_04] = param_01;
	}

	if(isdefined(param_02) && param_02 != "none")
	{
		var_04 = maps\mp\killstreaks\_killstreaks::func_3C16(param_02);
		var_03[var_04] = param_02;
	}

	var_05 = 0;
	foreach(var_04, var_07 in var_03)
	{
		if(var_04 > var_05)
		{
			var_05 = var_04;
		}
	}

	for(var_08 = 0;var_08 <= var_05;var_08++)
	{
		if(!isdefined(var_03[var_08]))
		{
			continue;
		}

		var_07 = var_03[var_08];
		self.killstreaks[var_08] = var_03[var_08];
	}
}

//Function Number: 46
replenishloadout()
{
	var_00 = self.pers["team"];
	var_01 = self.pers["class"];
	var_02 = self getweaponslistall();
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		self givemaxammo(var_04);
		self setweaponammoclip(var_04,9999);
		if(var_04 == "claymore_mp" || var_04 == "claymore_detonator_mp")
		{
			self setweaponammostock(var_04,2);
		}
	}

	if(self getammocount(level.classgrenades[var_01]["primary"]["type"]) < level.classgrenades[var_01]["primary"]["count"])
	{
		self setweaponammoclip(level.classgrenades[var_01]["primary"]["type"],level.classgrenades[var_01]["primary"]["count"]);
	}

	if(self getammocount(level.classgrenades[var_01]["secondary"]["type"]) < level.classgrenades[var_01]["secondary"]["count"])
	{
		self setweaponammoclip(level.classgrenades[var_01]["secondary"]["type"],level.classgrenades[var_01]["secondary"]["count"]);
	}
}

//Function Number: 47
onplayerconnecting()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isdefined(var_00.pers["class"]))
		{
			var_00.pers["class"] = "";
		}

		if(!isdefined(var_00.pers["lastClass"]))
		{
			var_00.pers["lastClass"] = "";
		}

		var_00.class = var_00.pers["class"];
		var_00.lastclass = var_00.pers["lastClass"];
		var_00.detectexplosives = 0;
		var_00.bombsquadicons = [];
		var_00.bombsquadids = [];
		if(!isdefined(var_00.pers["validationInfractions"]))
		{
			var_00.pers["validationInfractions"] = 0;
		}
	}
}

//Function Number: 48
fadeaway(param_00,param_01)
{
	wait(param_00);
	self fadeovertime(param_01);
	self.alpha = 0;
}

//Function Number: 49
func_7003(param_00)
{
	self.curclass = param_00;
}

//Function Number: 50
getperkforclass(param_00,param_01)
{
	var_02 = maps\mp\_utility::func_3A55(param_01);
	if(issubstr(param_01,"custom"))
	{
		return cac_getperk(var_02,param_00);
	}

	return func_7E4D(level.classtablename,var_02,param_00);
}

//Function Number: 51
classhasperk(param_00,param_01)
{
	return getperkforclass(0,param_00) == param_01 || getperkforclass(1,param_00) == param_01 || getperkforclass(2,param_00) == param_01;
}

//Function Number: 52
func_49A6(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = 0;
	switch(param_00)
	{
		case "iw6_dlcweap01":
		case "iw6_m27":
		case "iw6_lsat":
		case "iw6_kac":
		case "iw6_ameli":
		case "iw6_uts15":
		case "iw6_mts255":
		case "iw6_maul":
		case "iw6_fp6":
		case "iw6_svu":
		case "iw6_mk14":
		case "iw6_imbel":
		case "iw6_usr":
		case "iw6_l115a3":
		case "iw6_gm6":
		case "iw6_sc2010":
		case "iw6_r5rgp":
		case "iw6_fads":
		case "iw6_bren":
		case "iw6_arx160":
		case "iw6_ak12":
		case "iw6_vepr":
		case "iw6_pp19":
		case "iw6_microtar":
		case "iw6_kriss":
		case "iw6_knifeonlyfast":
		case "iw6_knifeonly":
		case "iw6_dlcweap03":
		case "iw6_cbjms":
		case "iw6_g28":
		case "iw6_msbs":
		case "iw6_honeybadger":
		case "iw6_k7":
		case "iw6_vks":
		case "iw6_dlcweap02":
		case "iw6_riotshield":
			var_02 = 1;
			break;

		case "iw6_mariachimagnum":
		case "iw6_predatorcannon":
		case "iw6_axe":
		case "iw6_knifeonlyjugg":
		case "iw6_riotshieldjugg":
		case "iw6_minigunjugg":
			if(maps\mp\_utility::isjuggernaut())
			{
				var_02 = 1;
			}
			else
			{
				var_02 = 0;
			}
			break;

		default:
			var_02 = 0;
			break;
	}

	if(!var_02 && param_01)
	{
		recordvalidationinfraction();
	}

	return var_02;
}

//Function Number: 53
isvalidsecondary(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = 0;
	switch(param_00)
	{
		case "iw6_panzerfaust3":
		case "iw6_rgm":
		case "iw6_mk32":
		case "iw6_m9a1":
		case "iw6_magnum":
		case "iw6_pdw":
		case "iw6_mp443":
		case "iw6_magnumjugg":
		case "iw6_p226jugg":
		case "iw6_p226":
		case "iw6_pdwauto":
		case "none":
			var_03 = 1;
			break;

		default:
			if(param_02 == 0)
			{
				var_03 = func_49A6(param_00,0);
			}
			break;
	}

	if(!var_03 && param_01)
	{
		recordvalidationinfraction();
	}

	return var_03;
}

//Function Number: 54
isvalidattachment(param_00,param_01,param_02)
{
	var_03 = 0;
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	switch(param_00)
	{
		case "xmags":
		case "vzscope":
		case "tracker":
		case "thermal":
		case "silencer":
		case "rshieldspikes":
		case "rshieldscrambler":
		case "rshieldradar":
		case "rof":
		case "reflex":
		case "ironsight":
		case "hybrid":
		case "heartbeat":
		case "grip":
		case "fmj":
		case "flashsuppress":
		case "eotech":
		case "barrelrange":
		case "barrelbored":
		case "ammoslug":
		case "acog":
		case "firetypesingle":
		case "firetypeauto":
		case "firetypeburst":
		case "tactical":
		case "gl":
		case "shotgun":
		case "akimbo":
		case "none":
			var_03 = 1;
			break;

		default:
			var_03 = 0;
			break;
	}

	if(var_03 && param_00 != "none")
	{
		var_04 = maps\mp\_utility::func_3C6F(param_01);
		var_03 = common_scripts\utility::array_contains(var_04,param_00);
	}

	if(!var_03 && param_02)
	{
		recordvalidationinfraction();
	}

	return var_03;
}

//Function Number: 55
isattachmentunlocked(param_00,param_01)
{
	if(maps\mp\_utility::func_92AB())
	{
		return 1;
	}

	if(1)
	{
		return 1;
	}

	var_02 = 0;
	var_03 = 2;
	var_04 = 4;
	var_05 = self getrankedplayerdata("weaponRank",param_00);
	var_06 = int(tablelookup("mp/weaponRankTable.csv",var_02,maps\mp\_utility::getweaponclass(param_00),var_03));
	var_07 = int(tablelookup("mp/weaponRankTable.csv",var_06,param_01,var_04));
	if(var_05 >= var_07)
	{
		return 1;
	}

	return 0;
}

//Function Number: 56
func_49AE(param_00,param_01)
{
	var_02 = maps\mp\_utility::getweaponclass(param_01);
	if(var_02 == "weapon_assault")
	{
		switch(param_00)
		{
			case "specialty_holdbreathwhileads":
			case "specialty_bling":
			case "specialty_marksman":
			case "specialty_bulletpenetration":
			case "specialty_reducedsway":
			case "specialty_sharp_focus":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}
	}

	if(var_02 == "weapon_smg")
	{
		switch(param_00)
		{
			case "specialty_fastermelee":
			case "specialty_longerrange":
			case "specialty_bling":
			case "specialty_marksman":
			case "specialty_reducedsway":
			case "specialty_sharp_focus":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}
	}

	if(var_02 == "weapon_lmg")
	{
		switch(param_00)
		{
			case "specialty_bling":
			case "specialty_marksman":
			case "specialty_lightweight":
			case "specialty_bulletpenetration":
			case "specialty_reducedsway":
			case "specialty_sharp_focus":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}
	}

	if(var_02 == "weapon_sniper")
	{
		switch(param_00)
		{
			case "specialty_bling":
			case "specialty_marksman":
			case "specialty_lightweight":
			case "specialty_bulletpenetration":
			case "specialty_reducedsway":
			case "specialty_sharp_focus":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}
	}

	if(var_02 == "weapon_shotgun")
	{
		switch(param_00)
		{
			case "specialty_moredamage":
			case "specialty_fastermelee":
			case "specialty_longerrange":
			case "specialty_bling":
			case "specialty_marksman":
			case "specialty_sharp_focus":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}
	}

	if(var_02 == "weapon_riot")
	{
		switch(param_00)
		{
			case "specialty_fastermelee":
			case "specialty_lightweight":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}
	}

	self.detectedexploit = 250;
	return 0;
}

//Function Number: 57
isweaponbuffunlocked(param_00,param_01)
{
	if(maps\mp\_utility::func_92AB())
	{
		return 1;
	}

	var_02 = 0;
	var_03 = 4;
	var_04 = 4;
	var_05 = self getrankedplayerdata("weaponRank",param_00);
	var_06 = int(tablelookup("mp/weaponRankTable.csv",var_02,maps\mp\_utility::getweaponclass(param_00),var_03));
	var_07 = int(tablelookup("mp/weaponRankTable.csv",var_06,param_01,var_04));
	if(var_05 >= var_07)
	{
		return 1;
	}

	return 0;
}

//Function Number: 58
func_499B(param_00)
{
	switch(param_00)
	{
		case "camo33":
		case "camo32":
		case "camo31":
		case "camo30":
		case "camo29":
		case "camo28":
		case "camo27":
		case "camo26":
		case "camo25":
		case "camo24":
		case "camo23":
		case "camo22":
		case "camo21":
		case "camo20":
		case "camo19":
		case "camo18":
		case "camo17":
		case "camo16":
		case "camo15":
		case "camo14":
		case "camo13":
		case "camo12":
		case "camo11":
		case "camo10":
		case "camo09":
		case "camo08":
		case "camo07":
		case "camo06":
		case "camo05":
		case "camo04":
		case "camo03":
		case "clan02":
		case "clan01":
		case "gold":
		case "winter":
		case "trail":
		case "net":
		case "green":
		case "dark":
		case "caustic":
		case "tan":
		case "ocean":
		case "autumn":
		case "brush":
		case "snow":
		case "red":
		case "none":
			return 1;

		default:
			recordvalidationinfraction();
			return 0;
	}
}

//Function Number: 59
func_49A7(param_00)
{
	switch(param_00)
	{
		case "retdlc31":
		case "retdlc30":
		case "retdlc29":
		case "retdlc28":
		case "retdlc27":
		case "retdlc26":
		case "retdlc25":
		case "retdlc24":
		case "retdlc23":
		case "retdlc22":
		case "retdlc21":
		case "retdlc20":
		case "retdlc19":
		case "retdlc18":
		case "retdlc17":
		case "retdlc16":
		case "retdlc15":
		case "retdlc14":
		case "retdlc13":
		case "retdlc12":
		case "retdlc11":
		case "retdlc10":
		case "retdlc09":
		case "retdlc08":
		case "retdlc07":
		case "retdlc06":
		case "retdlc05":
		case "retdlc04":
		case "retdlc03":
		case "retdlc02":
		case "retdlc01":
		case "retclan01":
		case "reflex05":
		case "reflex04":
		case "reflex03":
		case "reflex02":
		case "reflex01":
		case "reflexdef":
		case "hybrid05":
		case "hybrid04":
		case "hybrid03":
		case "hybrid02":
		case "hybrid01":
		case "hybriddef":
		case "eotech05":
		case "eotech04":
		case "eotech03":
		case "eotech02":
		case "eotech01":
		case "eotechdef":
		case "acog05":
		case "acog04":
		case "acog03":
		case "acog02":
		case "acog01":
		case "acogdef":
		case "ret05":
		case "ret04":
		case "ret03":
		case "ret02":
		case "ret01":
		case "none":
			return 1;

		default:
			recordvalidationinfraction();
			return 0;
	}
}

//Function Number: 60
func_4894(param_00,param_01)
{
	if(maps\mp\_utility::func_92AB())
	{
		return 1;
	}

	if(!isdefined(level.challengeinfo["ch_" + param_00 + "_" + param_01]))
	{
		return 1;
	}

	return 1;
}

//Function Number: 61
func_499E(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = 1;
	param_00 = common_scripts\utility::func_803F(param_00 == "none","specialty_null",param_00);
	if(maps\mp\perks\_perks::validateequipment(param_00,1,param_01) != param_00)
	{
		var_02 = 0;
		if(param_01)
		{
			recordvalidationinfraction();
		}
	}

	return var_02;
}

//Function Number: 62
func_49A2(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = 1;
	param_00 = common_scripts\utility::func_803F(param_00 == "none","specialty_null",param_00);
	if(maps\mp\perks\_perks::validateequipment(param_00,0,param_01) != param_00)
	{
		if(param_01)
		{
			recordvalidationinfraction();
		}
	}

	return var_02;
}

//Function Number: 63
isperk(param_00)
{
	return int(tablelookup("mp/perktable.csv",1,param_00,0));
}

//Function Number: 64
func_48F2(param_00)
{
	return maps\mp\_utility::func_3AFB(param_00) != -1;
}

//Function Number: 65
isvalidperk1(param_00)
{
	switch(param_00)
	{
		case "specialty_longersprint":
		case "specialty_scavenger":
		case "specialty_fastreload":
		case "specialty_paint":
		case "specialty_blindeye":
			return 1;

		default:
			return 1;
	}
}

//Function Number: 66
isvalidperk2(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 != "specialty_anytwo")
	{
		switch(param_00)
		{
			case "specialty_quickdraw":
			case "_specialty_blastshield":
			case "specialty_twoprimaries":
			case "specialty_coldblooded":
			case "specialty_assists":
			case "specialty_hardline":
				return 1;

			default:
				return 1;
		}
	}

	return 1;
}

//Function Number: 67
isvalidperk3(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 != "specialty_anytwo")
	{
		switch(param_00)
		{
			case "specialty_stalker":
			case "specialty_detectexplosive":
			case "specialty_quieter":
			case "specialty_paint":
			case "specialty_bulletaccuracy":
				return 1;

			default:
				return 1;
		}
	}

	return 1;
}

//Function Number: 68
func_49AD(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(level.weaponrefs))
	{
		level.weaponrefs = [];
		foreach(var_03 in level.weaponlist)
		{
			level.weaponrefs[var_03] = 1;
		}
	}

	if(isdefined(level.weaponrefs[param_00]))
	{
		return 1;
	}

	if(param_01)
	{
		recordvalidationinfraction();
	}

	return 0;
}

//Function Number: 69
func_49A1(param_00,param_01)
{
	var_02 = maps\mp\_utility::isassaultkillstreak(param_00) || maps\mp\_utility::issupportkillstreak(param_00) || maps\mp\_utility::func_496B(param_00) || param_00 == "none";
	if(isdefined(param_01))
	{
		if(param_01 == "assault")
		{
			var_02 = maps\mp\_utility::isassaultkillstreak(param_00) || param_00 == "none";
		}
		else if(param_01 == "support")
		{
			var_02 = maps\mp\_utility::issupportkillstreak(param_00) || param_00 == "none";
		}
		else if(param_01 == "specialist")
		{
			var_02 = maps\mp\_utility::func_496B(param_00) || param_00 == "none";
		}
	}

	if(!var_02)
	{
		recordvalidationinfraction();
	}

	return var_02;
}

//Function Number: 70
func_4002()
{
	var_00 = 0;
	if((isdefined(self.lastclass) && self.lastclass != self.class) || !isdefined(self.lastclass))
	{
		var_00 = 1;
	}

	if(level.gametype == "infect" && !isdefined(self.last_infected_class) || self.last_infected_class != self.infected_class)
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 71
getnumabilitycategories()
{
	return 7;
}

//Function Number: 72
getnumsubability()
{
	return 5;
}