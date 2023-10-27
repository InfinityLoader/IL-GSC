/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_class.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 68
 * Decompile Time: 952 ms
 * Timestamp: 10/27/2023 2:25:15 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.classmap["class0"] = 0;
	level.classmap["class1"] = 1;
	level.classmap["class2"] = 2;
	level.classmap["class3"] = 3;
	level.classmap["class4"] = 4;
	level.classmap["class5"] = 5;
	level.classmap["class6"] = 6;
	level.classmap["class7"] = 7;
	level.classmap["class8"] = 8;
	level.classmap["class9"] = 9;
	level.classmap["class10"] = 10;
	level.classmap["class11"] = 11;
	level.classmap["class12"] = 12;
	level.classmap["class13"] = 13;
	level.classmap["class14"] = 14;
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
	level.classmap["custom11"] = 10;
	level.classmap["custom12"] = 11;
	level.classmap["custom13"] = 12;
	level.classmap["custom14"] = 13;
	level.classmap["custom15"] = 14;
	level.classmap["axis_recipe1"] = 0;
	level.classmap["axis_recipe2"] = 1;
	level.classmap["axis_recipe3"] = 2;
	level.classmap["axis_recipe4"] = 3;
	level.classmap["axis_recipe5"] = 4;
	level.classmap["allies_recipe1"] = 0;
	level.classmap["allies_recipe2"] = 1;
	level.classmap["allies_recipe3"] = 2;
	level.classmap["allies_recipe4"] = 3;
	level.classmap["allies_recipe5"] = 4;
	level.classmap["copycat"] = -1;
	level.defaultclass = "CLASS_ASSAULT";
	level.classtablename = "mp/classTable.csv";
	level thread func_32C5();
}

//Function Number: 2
getclasschoice(param_00)
{
	return param_00;
}

//Function Number: 3
func_2AEC(param_00)
{
	var_01 = strtok(param_00,",");
	if(var_01.size > 1)
	{
		return int(var_01[1]);
	}

	return 0;
}

//Function Number: 4
func_32A4(param_00,param_01,param_02,param_03)
{
	if(param_00 == self.lastclass)
	{
		return;
	}

	self logstring("choseclass: " + param_00 + " weapon: " + param_01 + " special: " + param_02);
	for(var_04 = 0;var_04 < param_03.size;var_04++)
	{
		self logstring("perk" + var_04 + ": " + param_03[var_04]);
	}

	self.lastclass = param_00;
}

//Function Number: 5
func_8109()
{
	if(getdvarint("xblive_privatematch"))
	{
		return "privateMatchCustomClasses";
	}

	return "customClasses";
}

//Function Number: 6
func_282D(param_00,param_01)
{
	var_02 = func_8109();
	return self getplayerdata(var_02,param_00,"weaponSetups",param_01,"weapon");
}

//Function Number: 7
cac_getweaponattachment(param_00,param_01)
{
	var_02 = func_8109();
	return self getplayerdata(var_02,param_00,"weaponSetups",param_01,"attachment",0);
}

//Function Number: 8
func_28BF(param_00,param_01)
{
	var_02 = func_8109();
	return self getplayerdata(var_02,param_00,"weaponSetups",param_01,"attachment",1);
}

//Function Number: 9
cac_getweaponbuff(param_00,param_01)
{
	var_02 = func_8109();
	return self getplayerdata(var_02,param_00,"weaponSetups",param_01,"buff");
}

//Function Number: 10
cac_getweaponcamo(param_00,param_01)
{
	var_02 = func_8109();
	return self getplayerdata(var_02,param_00,"weaponSetups",param_01,"camo");
}

//Function Number: 11
func_32A6(param_00,param_01)
{
	var_02 = func_8109();
	return self getplayerdata(var_02,param_00,"weaponSetups",param_01,"reticle");
}

//Function Number: 12
func_28C1(param_00,param_01)
{
	var_02 = func_8109();
	return self getplayerdata(var_02,param_00,"perks",param_01);
}

//Function Number: 13
func_28C4(param_00,param_01,param_02)
{
	var_03 = undefined;
	switch(param_01)
	{
		case "streaktype_support":
			var_03 = "defenseStreaks";
			break;

		case "streaktype_specialist":
			var_03 = "specialistStreaks";
			break;

		default:
			var_03 = "assaultStreaks";
			break;
	}

	var_04 = func_8109();
	return self getplayerdata(var_04,param_00,var_03,param_02);
}

//Function Number: 14
cac_getdeathstreak(param_00)
{
	var_01 = func_8109();
	return self getplayerdata(var_01,param_00,"deathstreak");
}

//Function Number: 15
cac_getoffhand(param_00)
{
	var_01 = func_8109();
	return self getplayerdata(var_01,param_00,"perks",6);
}

//Function Number: 16
recipe_getkillstreak(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	switch(param_02)
	{
		case "streaktype_support":
			var_04 = "defenseStreaks";
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

//Function Number: 17
func_28C6(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimary",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondary",param_01 + 1);
}

//Function Number: 18
func_28C7(param_00,param_01,param_02,param_03)
{
	var_04 = "none";
	if(param_02 == 0)
	{
		if(!isdefined(param_03) || param_03 == 0)
		{
			var_04 = tablelookup(param_00,0,"loadoutPrimaryAttachment",param_01 + 1);
		}
		else
		{
			var_04 = tablelookup(param_00,0,"loadoutPrimaryAttachment2",param_01 + 1);
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

//Function Number: 19
table_getweaponbuff(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryBuff",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryBuff",param_01 + 1);
}

//Function Number: 20
func_32A8(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryCamo",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryCamo",param_01 + 1);
}

//Function Number: 21
func_32A9(param_00,param_01,param_02)
{
	return "none";
}

//Function Number: 22
table_getequipment(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,"loadoutEquipment",param_01 + 1);
}

//Function Number: 23
func_28CA(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,"loadoutPerk" + param_02,param_01 + 1);
}

//Function Number: 24
table_getteamperk(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutTeamPerk",param_01 + 1);
}

//Function Number: 25
table_getoffhand(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutOffhand",param_01 + 1);
}

//Function Number: 26
table_getkillstreak(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,"loadoutStreak" + param_02,param_01 + 1);
}

//Function Number: 27
table_getdeathstreak(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutDeathstreak",param_01 + 1);
}

//Function Number: 28
func_28BD(param_00)
{
	return level.classmap[param_00];
}

//Function Number: 29
cloneloadout()
{
	var_00 = "none";
	var_01 = [];
	var_02 = self.curclass;
	if(var_02 == "copycat")
	{
		return undefined;
	}

	if(issubstr(var_02,"axis"))
	{
		var_00 = "axis";
	}
	else if(issubstr(var_02,"allies"))
	{
		var_00 = "allies";
	}

	if(var_00 != "none")
	{
		var_03 = func_28BD(var_02);
		var_04 = "none";
		var_05 = "none";
		var_06 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",0,"weapon");
		var_07 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",0,"attachment",0);
		var_04 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",0,"attachment",1);
		var_08 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",0,"buff");
		var_09 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",0,"camo");
		var_0A = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",0,"reticle");
		var_0B = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",1,"weapon");
		var_0C = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",1,"attachment",0);
		var_05 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",1,"attachment",1);
		var_0D = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",1,"buff");
		var_0E = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",1,"camo");
		var_0F = getmatchrulesdata("defaultClasses",var_00,var_03,"class","weaponSetups",1,"reticle");
		var_10 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","perks",0);
		var_11 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","perks",1);
		var_12 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","perks",2);
		var_13 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","perks",3);
		var_14 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","perks",5);
		var_15 = recipe_getkillstreak(var_00,var_03,var_14,0);
		var_16 = recipe_getkillstreak(var_00,var_03,var_14,1);
		var_17 = recipe_getkillstreak(var_00,var_03,var_14,2);
		var_18 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","perks",6);
		var_19 = getmatchrulesdata("defaultClasses",var_00,var_03,"class","deathstreak");
	}
	else if(issubstr(var_19,"custom"))
	{
		var_1A = func_28BD(var_19);
		var_04 = "none";
		var_05 = "none";
		var_06 = func_282D(var_1A,0);
		var_07 = cac_getweaponattachment(var_1A,0);
		var_04 = func_28BF(var_1A,0);
		var_08 = cac_getweaponbuff(var_1A,0);
		var_09 = cac_getweaponcamo(var_1A,0);
		var_0A = func_32A6(var_1A,0);
		var_0B = func_282D(var_1A,1);
		var_0C = cac_getweaponattachment(var_1A,1);
		var_05 = func_28BF(var_1A,1);
		var_0D = cac_getweaponbuff(var_1A,1);
		var_0E = cac_getweaponcamo(var_1A,1);
		var_0F = func_32A6(var_1A,1);
		var_10 = func_28C1(var_1A,0);
		var_11 = func_28C1(var_1A,1);
		var_12 = func_28C1(var_1A,2);
		var_13 = func_28C1(var_1A,3);
		var_14 = func_28C1(var_1A,5);
		var_15 = func_28C4(var_1A,var_14,0);
		var_16 = func_28C4(var_1A,var_14,1);
		var_17 = func_28C4(var_1A,var_14,2);
		var_18 = cac_getoffhand(var_1A);
		var_19 = cac_getdeathstreak(var_1A);
	}
	else
	{
		var_1A = func_28BD(var_1A);
		var_06 = func_28C6(level.classtablename,var_1A,0);
		var_07 = func_28C7(level.classtablename,var_1A,0,0);
		var_04 = func_28C7(level.classtablename,var_1A,0,1);
		var_08 = table_getweaponbuff(level.classtablename,var_1A,0);
		var_09 = func_32A8(level.classtablename,var_1A,0);
		var_0A = func_32A9(level.classtablename,var_1A,0);
		var_0B = func_28C6(level.classtablename,var_1A,1);
		var_0C = func_28C7(level.classtablename,var_1A,1,0);
		var_05 = func_28C7(level.classtablename,var_1A,1,1);
		var_0D = table_getweaponbuff(level.classtablename,var_1A,1);
		var_0E = func_32A8(level.classtablename,var_1A,1);
		var_0F = func_32A9(level.classtablename,var_1A,1);
		var_10 = table_getequipment(level.classtablename,var_1A,0);
		var_11 = func_28CA(level.classtablename,var_1A,1);
		var_12 = func_28CA(level.classtablename,var_1A,2);
		var_13 = func_28CA(level.classtablename,var_1A,3);
		var_14 = func_28CA(level.classtablename,var_1A,5);
		var_18 = table_getoffhand(level.classtablename,var_1A);
		var_19 = table_getdeathstreak(level.classtablename,var_1A);
		switch(var_14)
		{
			case "streaktype_support":
				var_1B = table_getkillstreak(level.classtablename,3,1);
				var_1C = table_getkillstreak(level.classtablename,3,2);
				var_1D = table_getkillstreak(level.classtablename,3,3);
				break;

			case "streaktype_specialist":
				var_1B = table_getkillstreak(level.classtablename,1,1);
				var_1C = table_getkillstreak(level.classtablename,1,2);
				var_1D = table_getkillstreak(level.classtablename,1,3);
				break;

			default:
				var_1B = table_getkillstreak(level.classtablename,0,1);
				var_1C = table_getkillstreak(level.classtablename,0,2);
				var_1D = table_getkillstreak(level.classtablename,0,3);
				break;
		}

		var_15 = var_1B;
		var_16 = var_1C;
		var_17 = var_1D;
	}

	var_01["inUse"] = 0;
	var_01["loadoutPrimary"] = var_06;
	var_01["loadoutPrimaryAttachment"] = var_07;
	var_01["loadoutPrimaryAttachment2"] = var_04;
	var_01["loadoutPrimaryBuff"] = var_08;
	var_01["loadoutPrimaryCamo"] = var_09;
	var_01["loadoutPrimaryReticle"] = var_0A;
	var_01["loadoutSecondary"] = var_0B;
	var_01["loadoutSecondaryAttachment"] = var_0C;
	var_01["loadoutSecondaryAttachment2"] = var_05;
	var_01["loadoutSecondaryBuff"] = var_0D;
	var_01["loadoutSecondaryCamo"] = var_0E;
	var_01["loadoutSecondaryReticle"] = var_0F;
	var_01["loadoutEquipment"] = var_10;
	var_01["loadoutPerk1"] = var_11;
	var_01["loadoutPerk2"] = var_12;
	var_01["loadoutPerk3"] = var_13;
	var_01["loadoutStreakType"] = var_14;
	var_01["loadoutKillstreak1"] = var_15;
	var_01["loadoutKillstreak2"] = var_16;
	var_01["loadoutKillstreak3"] = var_17;
	var_01["loadoutDeathstreak"] = var_19;
	var_01["loadoutOffhand"] = var_18;
	return var_01;
}

//Function Number: 30
loadoutfakeperks(param_00,param_01)
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
getloadoutstreaktypefromstreaktype(param_00)
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
func_2A52(param_00,param_01,param_02,param_03)
{
	self takeallweapons();
	self.changingweapon = undefined;
	var_04 = "none";
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_05 = 0;
	self.specialty = [];
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_06 = undefined;
	var_07 = 0;
	var_08 = undefined;
	var_09 = undefined;
	var_0A = undefined;
	if(issubstr(param_01,"axis"))
	{
		var_04 = "axis";
	}
	else if(issubstr(param_01,"allies"))
	{
		var_04 = "allies";
	}

	var_0B = [];
	if(isdefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && param_02)
	{
		func_2AEE("copycat");
		self.class_num = func_28BD("copycat");
		var_0B = self.pers["copyCatLoadout"];
		var_0C = var_0B["loadoutPrimary"];
		var_0D = var_0B["loadoutPrimaryAttachment"];
		var_0E = var_0B["loadoutPrimaryAttachment2"];
		var_0F = var_0B["loadoutPrimaryBuff"];
		var_10 = var_0B["loadoutPrimaryCamo"];
		var_11 = var_0B["loadoutPrimaryReticle"];
		var_12 = var_0B["loadoutSecondary"];
		var_13 = var_0B["loadoutSecondaryAttachment"];
		var_14 = var_0B["loadoutSecondaryAttachment2"];
		var_15 = var_0B["loadoutSecondaryBuff"];
		var_16 = var_0B["loadoutSecondaryCamo"];
		var_17 = var_0B["loadoutSecondaryReticle"];
		var_18 = var_0B["loadoutEquipment"];
		var_19 = var_0B["loadoutPerk1"];
		var_1A = var_0B["loadoutPerk2"];
		var_1B = var_0B["loadoutPerk3"];
		var_1C = var_0B["loadoutStreakType"];
		var_1D = var_0B["loadoutOffhand"];
		var_1E = var_0B["loadoutDeathstreak"];
		var_1F = var_0B["loadoutAmmoType"];
	}
	else if(var_17 != "none")
	{
		var_20 = func_28BD(var_14);
		var_0E = "none";
		var_14 = "none";
		var_0C = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",0,"weapon");
		var_0D = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",0,"attachment",0);
		var_0E = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",0,"attachment",1);
		var_0F = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",0,"buff");
		var_10 = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",0,"camo");
		var_11 = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",0,"reticle");
		var_12 = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",1,"weapon");
		var_13 = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",1,"attachment",0);
		var_14 = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",1,"attachment",1);
		var_15 = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",1,"buff");
		var_16 = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",1,"camo");
		var_17 = getmatchrulesdata("defaultClasses",var_04,var_20,"class","weaponSetups",1,"reticle");
		if((var_0C == "throwingknife" || var_0C == "none") && var_12 != "none")
		{
			var_0C = var_12;
			var_0D = var_13;
			var_0E = var_14;
			var_0F = var_15;
			var_10 = var_16;
			var_11 = var_17;
			var_12 = "none";
			var_13 = "none";
			var_14 = "none";
			var_15 = "specialty_null";
			var_16 = "none";
			var_17 = "none";
		}
		else if((var_0C == "throwingknife" || var_0C == "none") && var_12 == "none")
		{
			var_07 = 1;
			var_0C = "iw5_usp45";
			var_0D = "tactical";
		}

		var_18 = getmatchrulesdata("defaultClasses",var_04,var_20,"class","perks",0);
		var_19 = getmatchrulesdata("defaultClasses",var_04,var_20,"class","perks",1);
		var_1A = getmatchrulesdata("defaultClasses",var_04,var_20,"class","perks",2);
		var_1B = getmatchrulesdata("defaultClasses",var_04,var_20,"class","perks",3);
		if(var_12 != "none" && !func_32A1(var_12,var_1A,var_1B,0))
		{
			var_12 = func_28C6(level.classtablename,10,1);
			var_13 = "none";
			var_14 = "none";
			var_15 = "specialty_null";
			var_16 = "none";
			var_17 = "none";
		}

		var_1C = getmatchrulesdata("defaultClasses",var_04,var_20,"class","perks",5);
		if(var_1C == "specialty_null")
		{
			var_08 = "none";
			var_09 = "none";
			var_0A = "none";
		}
		else
		{
			var_08 = recipe_getkillstreak(var_04,var_20,var_1C,0);
			var_09 = recipe_getkillstreak(var_04,var_20,var_1C,1);
			var_0A = recipe_getkillstreak(var_04,var_20,var_1C,2);
		}

		var_1D = getmatchrulesdata("defaultClasses",var_04,var_20,"class","perks",6);
		if(var_1D == "specialty_null")
		{
			var_1D = "none";
		}

		var_1E = getmatchrulesdata("defaultClasses",var_04,var_20,"class","deathstreak");
		if(getmatchrulesdata("defaultClasses",var_04,var_20,"juggernaut"))
		{
			thread maps\mp\_utility::recipeclassapplyjuggernaut(maps\mp\_utility::isjuggernaut());
			self.isjuggernaut = 1;
		}
		else if(maps\mp\_utility::isjuggernaut())
		{
			self notify("lost_juggernaut");
			self.isjuggernaut = 0;
			self.movespeedscaler = 1;
		}
	}
	else if(issubstr(var_14,"custom"))
	{
		var_21 = func_28BD(var_14);
		self.class_num = var_21;
		var_0C = func_282D(var_21,0);
		var_0D = cac_getweaponattachment(var_21,0);
		var_0E = func_28BF(var_21,0);
		var_0F = cac_getweaponbuff(var_21,0);
		var_10 = cac_getweaponcamo(var_21,0);
		var_11 = func_32A6(var_21,0);
		var_12 = func_282D(var_21,1);
		var_13 = cac_getweaponattachment(var_21,1);
		var_14 = func_28BF(var_21,1);
		var_15 = cac_getweaponbuff(var_21,1);
		var_16 = cac_getweaponcamo(var_21,1);
		var_17 = func_32A6(var_21,1);
		var_18 = func_28C1(var_21,0);
		var_19 = func_28C1(var_21,1);
		var_1A = func_28C1(var_21,2);
		var_1B = func_28C1(var_21,3);
		var_1C = func_28C1(var_21,5);
		var_1D = cac_getoffhand(var_21);
		var_1E = cac_getdeathstreak(var_21);
	}
	else if(var_14 == "gamemode")
	{
		var_22 = self.pers["gamemodeLoadout"];
		var_0C = var_22["loadoutPrimary"];
		var_0D = var_22["loadoutPrimaryAttachment"];
		var_0E = var_22["loadoutPrimaryAttachment2"];
		var_0F = var_22["loadoutPrimaryBuff"];
		var_10 = var_22["loadoutPrimaryCamo"];
		var_11 = var_22["loadoutPrimaryReticle"];
		var_12 = var_22["loadoutSecondary"];
		var_13 = var_22["loadoutSecondaryAttachment"];
		var_14 = var_22["loadoutSecondaryAttachment2"];
		var_15 = var_22["loadoutSecondaryBuff"];
		var_16 = var_22["loadoutSecondaryCamo"];
		var_17 = var_22["loadoutSecondaryReticle"];
		if((var_0C == "throwingknife" || var_0C == "none") && var_12 != "none")
		{
			var_0C = var_12;
			var_0D = var_13;
			var_0E = var_14;
			var_0F = var_15;
			var_10 = var_16;
			var_11 = var_17;
			var_12 = "none";
			var_13 = "none";
			var_14 = "none";
			var_15 = "specialty_null";
			var_16 = "none";
			var_17 = "none";
		}
		else if((var_0C == "throwingknife" || var_0C == "none") && var_12 == "none")
		{
			var_07 = 1;
			var_0C = "iw5_usp45";
			var_0D = "tactical";
		}

		var_18 = var_22["loadoutEquipment"];
		var_1D = var_22["loadoutOffhand"];
		if(var_1D == "specialty_null")
		{
			var_1D = "none";
		}

		var_19 = var_22["loadoutPerk1"];
		var_1A = var_22["loadoutPerk2"];
		var_1B = var_22["loadoutPerk3"];
		if(var_12 != "none" && !func_32A1(var_12,var_1A,var_1B,0))
		{
			var_12 = func_28C6(level.classtablename,10,1);
			var_13 = "none";
			var_14 = "none";
			var_15 = "specialty_null";
			var_16 = "none";
			var_17 = "none";
		}

		if(level.killstreakrewards && isdefined(var_22["loadoutStreakType"]) && var_22["loadoutStreakType"] != "specialty_null")
		{
			var_1C = var_22["loadoutStreakType"];
			var_08 = var_22["loadoutKillstreak1"];
			var_09 = var_22["loadoutKillstreak2"];
			var_0A = var_22["loadoutKillstreak3"];
		}
		else if(level.killstreakrewards && isdefined(self.streaktype))
		{
			var_1C = getloadoutstreaktypefromstreaktype(self.streaktype);
		}
		else
		{
			var_1C = "streaktype_assault";
			var_08 = "none";
			var_09 = "none";
			var_0A = "none";
		}

		var_1E = var_22["loadoutDeathstreak"];
		if(var_22["loadoutJuggernaut"])
		{
			self.health = self.maxhealth;
			thread maps\mp\_utility::recipeclassapplyjuggernaut(maps\mp\_utility::isjuggernaut());
			self.isjuggernaut = 1;
		}
		else if(maps\mp\_utility::isjuggernaut())
		{
			self notify("lost_juggernaut");
			self.isjuggernaut = 0;
			self.movespeedscaler = 1;
		}
	}
	else if(var_14 == "juggernaut")
	{
		var_0C = "iw5_m60jugg";
		var_0D = "none";
		var_0E = "none";
		var_0F = "specialty_null";
		var_10 = "none";
		var_11 = "none";
		var_12 = "iw5_mp412jugg";
		var_13 = "none";
		var_14 = "none";
		var_15 = "specialty_null";
		var_16 = "none";
		var_17 = "none";
		var_18 = "frag_grenade_mp";
		var_19 = "specialty_scavenger";
		var_1A = "specialty_quickdraw";
		var_1B = "specialty_detectexplosive";
		var_1C = getloadoutstreaktypefromstreaktype(self.streaktype);
		var_1D = "smoke_grenade_mp";
		var_1E = "specialty_null";
	}
	else if(var_14 == "juggernaut_recon")
	{
		var_0C = "iw5_riotshieldjugg";
		var_0D = "none";
		var_0E = "none";
		var_0F = "specialty_null";
		var_10 = "none";
		var_11 = "none";
		var_12 = "iw5_usp45jugg";
		var_13 = "none";
		var_14 = "none";
		var_15 = "specialty_null";
		var_16 = "none";
		var_17 = "none";
		var_18 = "specialty_portable_radar";
		var_19 = "specialty_scavenger";
		var_1A = "specialty_coldblooded";
		var_1B = "specialty_detectexplosive";
		var_1C = getloadoutstreaktypefromstreaktype(self.streaktype);
		var_1D = "smoke_grenade_mp";
		var_1E = "specialty_null";
	}
	else
	{
		var_21 = func_28BD(var_14);
		self.class_num = var_21;
		var_0C = func_28C6(level.classtablename,var_21,0);
		var_0D = func_28C7(level.classtablename,var_21,0,0);
		var_0E = func_28C7(level.classtablename,var_21,0,1);
		var_0F = table_getweaponbuff(level.classtablename,var_21,0);
		var_10 = func_32A8(level.classtablename,var_21,0);
		var_11 = func_32A9(level.classtablename,var_21,0);
		var_12 = func_28C6(level.classtablename,var_21,1);
		var_13 = func_28C7(level.classtablename,var_21,1,0);
		var_14 = func_28C7(level.classtablename,var_21,1,1);
		var_15 = table_getweaponbuff(level.classtablename,var_21,1);
		var_16 = func_32A8(level.classtablename,var_21,1);
		var_17 = func_32A9(level.classtablename,var_21,1);
		var_18 = table_getequipment(level.classtablename,var_21,0);
		var_19 = func_28CA(level.classtablename,var_21,1);
		var_1A = func_28CA(level.classtablename,var_21,2);
		var_1B = func_28CA(level.classtablename,var_21,3);
		var_1C = func_28CA(level.classtablename,var_21,5);
		var_1D = table_getoffhand(level.classtablename,var_21);
		var_1E = table_getdeathstreak(level.classtablename,var_21);
	}

	loadoutfakeperks(var_1C);
	var_23 = issubstr(param_01,"custom");
	var_24 = issubstr(param_01,"recipe");
	var_25 = param_01 == "gamemode";
	if(!var_25 && !var_24 && !isdefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && param_02)
	{
		if(!func_32A0(var_0C) || level.rankedmatch && var_23 && !self isitemunlocked(var_0C))
		{
			var_0C = func_28C6(level.classtablename,10,0);
		}

		if(!func_32C9(var_0D) || level.rankedmatch && var_23 && !isattachmentunlocked(var_0C,var_0D))
		{
			var_0D = func_28C7(level.classtablename,10,0,0);
		}

		if(!func_32C9(var_0E) || level.rankedmatch && var_23 && !isattachmentunlocked(var_0C,var_0E))
		{
			var_0E = func_28C7(level.classtablename,10,0,1);
		}

		if(!isvalidweaponbuff(var_0F,var_0C) || level.rankedmatch && var_23 && !isweaponbuffunlocked(var_0C,var_0F))
		{
			var_0F = table_getweaponbuff(level.classtablename,10,0);
		}

		if(!isvalidcamo(var_10) || level.rankedmatch && var_23 && !func_32CE(var_0C,var_10))
		{
			var_10 = func_32A8(level.classtablename,10,0);
		}

		if(!isvalidreticle(var_11))
		{
			var_11 = func_32A9(level.classtablenum,10,0);
		}

		if(!func_32A1(var_12,var_1A,var_1B) || level.rankedmatch && level.rankedmatch && var_23 && !self isitemunlocked(var_12))
		{
			var_12 = func_28C6(level.classtablename,10,1);
			var_13 = "none";
			var_14 = "none";
			var_15 = "specialty_null";
			var_16 = "none";
			var_17 = "none";
		}

		if(!func_32C9(var_13) || level.rankedmatch && var_23 && !isattachmentunlocked(var_12,var_13))
		{
			var_13 = func_28C7(level.classtablename,10,1,0);
		}

		if(!func_32C9(var_14) || level.rankedmatch && var_23 && !isattachmentunlocked(var_12,var_14))
		{
			var_14 = func_28C7(level.classtablename,10,1,1);
		}

		if((var_1A == "specialty_twoprimaries" && !isvalidweaponbuff(var_15,var_12)) || level.rankedmatch && var_23 && !self isitemunlocked(var_12 + " " + var_15))
		{
			var_15 = table_getweaponbuff(level.classtablename,10,1);
		}

		if(!isvalidcamo(var_16) || level.rankedmatch && var_23 && !func_32CE(var_12,var_16))
		{
			var_16 = func_32A8(level.classtablename,10,1);
		}

		if(!isvalidreticle(var_17))
		{
			var_17 = func_32A9(level.classtablename,10,1);
		}

		if(!func_32CF(var_18) || level.rankedmatch && var_23 && !self isitemunlocked(var_18))
		{
			var_18 = table_getequipment(level.classtablename,10,0);
		}

		if(!func_32D1(var_19) || level.rankedmatch && var_23 && !self isitemunlocked(var_19))
		{
			var_19 = func_28CA(level.classtablename,10,1);
		}

		if(!func_32D2(var_1A,var_19) || level.rankedmatch && var_23 && !self isitemunlocked(var_1A))
		{
			var_1A = func_28CA(level.classtablename,10,2);
		}

		if(!func_32D3(var_1B,var_19) || level.rankedmatch && var_23 && !self isitemunlocked(var_1B))
		{
			var_1B = func_28CA(level.classtablename,10,3);
		}

		if(!func_32D4(var_1E) || level.rankedmatch && var_23 && !self isitemunlocked(var_1E))
		{
			var_1E = table_getdeathstreak(level.classtablename,10);
		}

		if(!func_32D0(var_1D))
		{
			var_1D = table_getoffhand(level.classtablename,10);
		}
	}

	self.loadoutprimary = var_0C;
	self.loadoutprimarycamo = int(tablelookup("mp/camoTable.csv",1,var_10,0));
	self.loadoutsecondary = var_12;
	self.loadoutsecondarycamo = int(tablelookup("mp/camoTable.csv",1,var_16,0));
	if(!issubstr(var_0C,"iw5"))
	{
		self.loadoutprimarycamo = 0;
	}

	if(!issubstr(var_12,"iw5"))
	{
		self.loadoutsecondarycamo = 0;
	}

	self.loadoutprimaryreticle = int(tablelookup("mp/reticleTable.csv",1,var_11,0));
	self.loadoutsecondaryreticle = int(tablelookup("mp/reticleTable.csv",1,var_17,0));
	if(!issubstr(var_0C,"iw5"))
	{
		self.loadoutprimaryreticle = 0;
	}

	if(!issubstr(var_12,"iw5"))
	{
		self.loadoutsecondaryreticle = 0;
	}

	if(var_12 == "none")
	{
		var_26 = "none";
	}
	else
	{
		var_26 = func_32BC(var_13,var_14,var_15,self.loadoutsecondarycamo,self.loadoutsecondaryreticle);
		maps\mp\_utility::_giveweapon(var_26);
		var_27 = strtok(var_26,"_");
		if(var_27[0] == "iw5")
		{
		}
		else if(var_41[0] == "alt")
		{
		}

		var_28 = var_41[0];
		var_29 = maps\mp\gametypes\_rank::func_2881(var_28);
		var_2A = self getplayerdata("weaponRank",var_28);
		if(var_29 != var_2A)
		{
			self setplayerdata("weaponRank",var_28,var_29);
		}
	}

	self setoffhandprimaryclass("other");
	maps\mp\_utility::func_31F3(1,"");
	maps\mp\_utility::func_31F3(3,"altMode");
	maps\mp\_utility::func_31F3(4,"");
	if(!level.console)
	{
		maps\mp\_utility::func_31F3(5,"");
		maps\mp\_utility::func_31F3(6,"");
		maps\mp\_utility::func_31F3(7,"");
	}

	maps\mp\_utility::_clearperks();
	_detachall();
	if(level.diehardmode)
	{
		maps\mp\_utility::giveperk("specialty_pistoldeath",0);
	}

	loadoutallperks(var_19,var_1A,var_1B,var_1C,var_10,var_16);
	if(maps\mp\_utility::func_27AF("specialty_extraammo") && var_27 != "none" && maps\mp\_utility::getweaponclass(var_27) != "weapon_projectile")
	{
		self givemaxammo(var_27);
	}

	self.spawnperk = 0;
	if(!maps\mp\_utility::func_27AF("specialty_blindeye") && self.avoidkillstreakonspawntimer > 0)
	{
		thread maps\mp\perks\_perks::giveblindeyeafterspawn();
	}

	if(self.pers["cur_death_streak"] > 0)
	{
		var_2B = [];
		if(var_23 != "specialty_null")
		{
		}

		if(func_28F9(var_1B) == "specialty_rollover" || func_28F9(var_1C) == "specialty_rollover" || func_28F9(var_1D) == "specialty_rollover")
		{
			foreach(var_2E, var_2D in var_41)
			{
				var_41[var_2E] = var_41[var_2E] - 1;
			}
		}

		foreach(var_2E, var_2D in var_41)
		{
			if(self.pers["cur_death_streak"] >= var_2D)
			{
				if(var_2E == "specialty_carepackage" && self.pers["cur_death_streak"] > var_2D)
				{
					continue;
				}

				if(var_2E == "specialty_uav" && self.pers["cur_death_streak"] > var_2D)
				{
					continue;
				}

				thread maps\mp\_utility::giveperk(var_2E,1);
				thread maps\mp\gametypes\_hud_message::func_2892(var_2E);
			}
		}
	}

	if(level.killstreakrewards && !isdefined(var_0A) && !isdefined(var_0B) && !isdefined(var_0C))
	{
		if(isdefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && var_04)
		{
			var_0A = var_0D["loadoutKillstreak1"];
			var_0B = var_0D["loadoutKillstreak2"];
			var_0C = var_0D["loadoutKillstreak3"];
		}
		else
		{
			var_30 = undefined;
			var_31 = undefined;
			var_32 = undefined;
			var_33 = undefined;
			switch(self.streaktype)
			{
				case "support":
					var_30 = table_getkillstreak(level.classtablename,2,1);
					var_31 = table_getkillstreak(level.classtablename,2,2);
					var_32 = table_getkillstreak(level.classtablename,2,3);
					var_33 = "defenseStreaks";
					break;

				case "specialist":
					var_30 = table_getkillstreak(level.classtablename,1,1);
					var_31 = table_getkillstreak(level.classtablename,1,2);
					var_32 = table_getkillstreak(level.classtablename,1,3);
					var_33 = "specialistStreaks";
					break;

				default:
					var_30 = table_getkillstreak(level.classtablename,0,1);
					var_31 = table_getkillstreak(level.classtablename,0,2);
					var_32 = table_getkillstreak(level.classtablename,0,3);
					var_33 = "assaultStreaks";
					break;
			}

			var_0A = undefined;
			var_0B = undefined;
			var_0C = undefined;
			if(issubstr(param_03,"custom"))
			{
				var_34 = func_8109();
				var_0A = self getplayerdata(var_34,self.class_num,var_33,0);
				var_0B = self getplayerdata(var_34,self.class_num,var_33,1);
				var_0C = self getplayerdata(var_34,self.class_num,var_33,2);
			}

			if(issubstr(param_03,"juggernaut") || var_27)
			{
				foreach(var_36 in self.killstreaks)
				{
					if(!isdefined(var_0A))
					{
						var_0A = var_36;
						continue;
					}

					if(!isdefined(var_0B))
					{
						var_0B = var_36;
						continue;
					}

					if(!isdefined(var_0C))
					{
						var_0C = var_36;
					}
				}

				if(var_27 && self.streaktype == "specialist")
				{
					self.pers["gamemodeLoadout"]["loadoutKillstreak1"] = var_0A;
					self.pers["gamemodeLoadout"]["loadoutKillstreak2"] = var_0B;
					self.pers["gamemodeLoadout"]["loadoutKillstreak3"] = var_0C;
				}
			}

			if(!issubstr(param_03,"custom") && !issubstr(param_03,"juggernaut") && !var_27)
			{
				var_0A = var_30;
				var_0B = var_31;
				var_0C = var_32;
			}

			if(!isdefined(var_0A))
			{
				var_0A = "none";
			}

			if(!isdefined(var_0B))
			{
				var_0B = "none";
			}

			if(!isdefined(var_0C))
			{
				var_0C = "none";
			}

			if(!isvalidkillstreak(var_0A) || var_25 && !self isitemunlocked(var_0A))
			{
				var_0A = table_getkillstreak(level.classtablename,0,1);
			}

			if(!isvalidkillstreak(var_0B) || var_25 && !self isitemunlocked(var_0B))
			{
				var_0B = table_getkillstreak(level.classtablename,0,2);
			}

			if(!isvalidkillstreak(var_0C) || var_25 && !self isitemunlocked(var_0C))
			{
				var_0C = table_getkillstreak(level.classtablename,0,3);
			}
		}
	}
	else if(!level.killstreakrewards)
	{
		var_0A = "none";
		var_0B = "none";
		var_0C = "none";
	}

	func_32C2(var_0A,var_0B,var_0C);
	if(isdefined(self.lastclass) && self.lastclass != self.class && !issubstr(self.class,"juggernaut") && !issubstr(self.lastclass,"juggernaut") && !issubstr(param_03,"juggernaut"))
	{
		if(maps\mp\_utility::func_2F49() || self.lastclass != "")
		{
			var_38 = [];
			var_39 = 0;
			if(self.pers["killstreaks"].size > 5)
			{
				var_3A = 5;
				while(var_3A < self.pers["killstreaks"].size)
				{
					var_38[var_39] = self.pers["killstreaks"][var_3A].streakname;
					var_39++ = var_41[var_23];
					var_3A++ = int(tablelookup("mp/perkTable.csv",1,var_23,6));
				}
			}

			if(self.pers["killstreaks"].size)
			{
				for(var_3A = 1;var_3A < 4;var_3A++ = var_41[1] + "_" + var_41[2])
				{
					if(isdefined(self.pers["killstreaks"][var_3A]) && isdefined(self.pers["killstreaks"][var_3A].streakname) && self.pers["killstreaks"][var_3A].available && !self.pers["killstreaks"][var_3A].isspecialist)
					{
						var_38[var_39] = self.pers["killstreaks"][var_3A].streakname;
						var_39++ = var_41[0];
					}
				}
			}

			self notify("givingLoadout",var_41[0],var_27[0] + "_" + var_27[1]);
			maps\mp\killstreaks\_killstreaks::func_2DD6();
			for(var_3A = 0;var_3A < var_38.size;var_3A++)
			{
				maps\mp\killstreaks\_killstreaks::givekillstreak(var_38[var_3A]);
			}
		}
	}

	if(!issubstr(param_03,"juggernaut"))
	{
		if(isdefined(self.lastclass) && self.lastclass != "" && self.lastclass != self.class)
		{
			maps\mp\_utility::incplayerstat("mostclasseschanged",1);
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

	var_3B = func_32BC(var_0E,var_0F,var_10,self.loadoutprimarycamo,self.loadoutprimaryreticle);
	maps\mp\_utility::_giveweapon(var_3B);
	self switchtoweapon(var_3B);
	var_27 = strtok(var_3B,"_");
	if(var_3B[0] == "iw5")
	{
		var_28 = var_3B[0] + "_" + var_3B[1];
	}
	else if(var_28[0] == "alt")
	{
		var_28 = var_28[1] + "_" + var_28[2];
	}
	else
	{
		var_28 = var_28[0];
	}

	var_29 = maps\mp\gametypes\_rank::func_2881(var_28);
	var_2A = self getplayerdata("weaponRank",var_28);
	if(var_29 != var_2A)
	{
		self setplayerdata("weaponRank",var_28,var_29);
	}

	if(var_2B == "riotshield_mp" && level.ingraceperiod)
	{
		self notify("weapon_change","riotshield_mp");
	}

	if(maps\mp\_utility::func_27AF("specialty_extraammo"))
	{
		self givemaxammo(var_2B);
	}

	if(var_04)
	{
		self setspawnweapon(var_2B);
	}

	self.pers["primaryWeapon"] = var_28;
	var_3C = strtok(var_2B,"_");
	var_3D = var_1E;
	if(var_1E == "none")
	{
		self setoffhandsecondaryclass("none");
	}
	else if(var_1E == "flash_grenade_mp")
	{
		self setoffhandsecondaryclass("flash");
	}
	else if(var_1E == "smoke_grenade_mp" || var_1E == "concussion_grenade_mp")
	{
		self setoffhandsecondaryclass("smoke");
	}
	else
	{
		self setoffhandsecondaryclass("flash");
	}

	switch(var_3D)
	{
		case "none":
			break;

		case "specialty_tacticalinsertion":
		case "specialty_scrambler":
		case "specialty_portable_radar":
		case "trophy_mp":
			maps\mp\_utility::giveperk(var_3D,0);
			break;

		default:
			self giveweapon(var_3D);
			if(var_1E == "flash_grenade_mp")
			{
				self setweaponammoclip(var_3D,2);
			}
			else if(var_1E == "concussion_grenade_mp")
			{
				self setweaponammoclip(var_3D,2);
			}
			else
			{
				self setweaponammoclip(var_3D,1);
			}
			break;
	}

	var_07 = var_2B;
	self.primaryweapon = var_07;
	self.secondaryweapon = var_27;
	if(var_08)
	{
		self setweaponammoclip(self.primaryweapon,0);
		self setweaponammostock(self.primaryweapon,0);
	}

	maps\mp\gametypes\_teams::func_2762(self.pers["primaryWeapon"],maps\mp\_utility::getbaseweaponname(var_27));
	self.issniper = weaponclass(self.primaryweapon) == "sniper";
	maps\mp\gametypes\_weapons::func_2884();
	maps\mp\perks\_perks::func_298C();
	self notify("changed_kit");
	self notify("giveLoadout");
}

//Function Number: 33
_detachall()
{
	if(isdefined(self.hasriotshield) && self.hasriotshield)
	{
		if(self.hasriotshieldequipped && !isdefined(self.hasriotshieldhidden) || self.hasriotshieldhidden == 0)
		{
			self detachshieldmodel("weapon_riot_shield_mp","tag_weapon_left");
			self.hasriotshieldequipped = 0;
		}
		else
		{
			self detachshieldmodel("weapon_riot_shield_mp","tag_shield_back");
		}

		self.hasriotshield = 0;
	}

	self detachall();
}

//Function Number: 34
func_31F1(param_00)
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

//Function Number: 35
func_28F9(param_00)
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

//Function Number: 36
loadoutallperks(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 = maps\mp\perks\_perks::validateperk(1,param_00);
	param_01 = maps\mp\perks\_perks::validateperk(1,param_01);
	param_02 = maps\mp\perks\_perks::validateperk(2,param_02);
	param_03 = maps\mp\perks\_perks::validateperk(3,param_03);
	param_04 = maps\mp\perks\_perks::validateperk(undefined,param_04);
	if(param_02 == "specialty_twoprimaries")
	{
		param_05 = maps\mp\perks\_perks::validateperk(undefined,param_05);
	}

	self.loadoutperk1 = param_01;
	self.loadoutperk2 = param_02;
	self.loadoutperk3 = param_03;
	self.loadoutperkequipment = param_00;
	self.loadoutprimarybuff = param_04;
	self.loadoutsecondarybuff = param_05;
	if(param_00 != "specialty_null")
	{
		maps\mp\_utility::giveperk(param_00,1);
	}

	if(param_01 != "specialty_null")
	{
		maps\mp\_utility::giveperk(param_01,1);
	}

	if(param_02 != "specialty_null")
	{
		maps\mp\_utility::giveperk(param_02,1);
	}

	if(param_03 != "specialty_null")
	{
		maps\mp\_utility::giveperk(param_03,1);
	}

	if(param_04 != "specialty_null")
	{
		maps\mp\_utility::giveperk(param_04,1);
	}

	var_06[0] = tablelookup("mp/perktable.csv",1,param_01,8);
	foreach(var_08 in var_41)
	{
		if(var_08 == "" || var_08 == "specialty_null")
		{
			continue;
		}

		if(self isitemunlocked(var_08) || !maps\mp\_utility::rankingenabled())
		{
			maps\mp\_utility::giveperk(var_08,1);
		}
	}

	if(!maps\mp\_utility::func_27AF("specialty_assists"))
	{
		self.pers["assistsToKill"] = 0;
	}
}

//Function Number: 37
watchoffhanduse()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("grenade_pullback",var_00);
		if(self.hasriotshieldequipped)
		{
			self detachshieldmodel("weapon_riot_shield_mp","tag_weapon_left");
			self.hasriotshieldhidden = 1;
		}
		else
		{
			continue;
		}

		self waittill("offhand_end",var_00);
		if(self.hasriotshieldequipped)
		{
			self attachshieldmodel("weapon_riot_shield_mp","tag_weapon_left");
			self.hasriotshieldhidden = 0;
		}
	}
}

//Function Number: 38
func_281D()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.hasriotshield = self hasweapon("riotshield_mp");
	self.hasriotshieldequipped = self.currentweaponatspawn == "riotshield_mp";
	thread watchoffhanduse();
	if(self.hasriotshield)
	{
		if(self.primaryweapon == "riotshield_mp" && self.secondaryweapon == "riotshield_mp")
		{
			self attachshieldmodel("weapon_riot_shield_mp","tag_weapon_left");
			self attachshieldmodel("weapon_riot_shield_mp","tag_shield_back");
		}
		else if(self.hasriotshieldequipped)
		{
			self attachshieldmodel("weapon_riot_shield_mp","tag_weapon_left");
		}
		else
		{
			self attachshieldmodel("weapon_riot_shield_mp","tag_shield_back");
		}
	}

	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 == "riotshield_mp" || var_00 == "iw5_riotshieldjugg_mp")
		{
			if(self.hasriotshieldequipped)
			{
				continue;
			}

			if(self.primaryweapon == var_00 && self.secondaryweapon == var_00)
			{
				continue;
			}
			else if(self.hasriotshield)
			{
				self moveshieldmodel("weapon_riot_shield_mp","tag_shield_back","tag_weapon_left");
			}
			else
			{
				self attachshieldmodel("weapon_riot_shield_mp","tag_weapon_left");
			}

			self.hasriotshield = 1;
			self.hasriotshieldequipped = 1;
			continue;
		}

		if(self ismantling() && var_00 == "none")
		{
			continue;
		}

		if(self.hasriotshieldequipped)
		{
			self.hasriotshield = self hasweapon("riotshield_mp") || self hasweapon("iw5_riotshieldjugg_mp");
			if(self.hasriotshield)
			{
				self moveshieldmodel("weapon_riot_shield_mp","tag_weapon_left","tag_shield_back");
			}
			else
			{
				self detachshieldmodel("weapon_riot_shield_mp","tag_weapon_left");
			}

			self.hasriotshieldequipped = 0;
			continue;
		}

		if(self.hasriotshield)
		{
			if(!self hasweapon("riotshield_mp") && !self hasweapon("iw5_riotshieldjugg_mp"))
			{
				self detachshieldmodel("weapon_riot_shield_mp","tag_shield_back");
				self.hasriotshield = 0;
			}
		}
	}
}

//Function Number: 39
tryattach(param_00)
{
	if(!isdefined(param_00) || param_00 != "back")
	{
		var_01 = "tag_weapon_left";
	}
	else
	{
		var_01 = "tag_shield_back";
	}

	var_02 = self getattachsize();
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = self getattachtagname(var_03);
		if(var_04 == var_01 && self getattachmodelname(var_03) == "weapon_riot_shield_mp")
		{
			return;
		}
	}

	self attachshieldmodel("weapon_riot_shield_mp",var_01);
}

//Function Number: 40
func_32BB(param_00)
{
	if(!isdefined(param_00) || param_00 != "back")
	{
		var_01 = "tag_weapon_left";
	}
	else
	{
		var_01 = "tag_shield_back";
	}

	var_02 = self getattachsize();
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = self getattachmodelname(var_03);
		if(var_04 == "weapon_riot_shield_mp")
		{
			self detachshieldmodel(var_04,var_01);
			return;
		}
	}
}

//Function Number: 41
func_32BC(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.lettertonumber))
	{
		level.lettertonumber = makeletterstonumbers();
	}

	if(getdvarint("scr_game_perks") == 0)
	{
		param_02 = "none";
	}

	if(isdefined(param_04) && param_04 != 0 && maps\mp\_utility::func_32BE(param_01) != "rail" && maps\mp\_utility::func_32BE(param_02) != "rail")
	{
		param_04 = undefined;
	}

	if(maps\mp\_utility::func_32BE(param_01) == "rail")
	{
		param_01 = maps\mp\_utility::func_3F1D(param_01,param_00);
	}
	else if(maps\mp\_utility::func_32BE(param_02) == "rail")
	{
		param_02 = maps\mp\_utility::func_3F1D(param_02,param_00);
	}

	var_05 = "";
	if(issubstr(param_00,"iw5_"))
	{
		var_06 = param_00 + "_mp";
		var_07 = param_00.size;
		var_05 = getsubstr(param_00,4,var_07);
	}
	else
	{
		var_06 = param_01;
	}

	var_08 = [];
	if(param_01 != "none" && param_02 != "none")
	{
		if(level.lettertonumber[param_01[0]] < level.lettertonumber[param_02[0]])
		{
		}
		else if(level.lettertonumber[param_02[0]] == level.lettertonumber[param_03[0]])
		{
			if(level.lettertonumber[param_02[1]] < level.lettertonumber[param_03[1]])
			{
			}
			else
			{
			}
		}
		else
		{
		}

		if(maps\mp\_utility::getweaponclass(param_01) == "weapon_sniper" && maps\mp\_utility::func_32BE(param_02) != "rail" && maps\mp\_utility::func_32BE(param_03) != "rail")
		{
			if(param_02 != "zoomscope" && param_03 != "zoomscope")
			{
			}
		}
	}
	else if(param_02 != "none")
	{
		if(maps\mp\_utility::getweaponclass(param_01) == "weapon_sniper" && maps\mp\_utility::func_32BE(param_02) != "rail" && param_02 != "zoomscope")
		{
		}
	}
	else if(param_03 != "none")
	{
		if(maps\mp\_utility::getweaponclass(param_01) == "weapon_sniper" && maps\mp\_utility::func_32BE(param_03) != "rail" && param_03 != "zoomscope")
		{
		}
	}
	else if(maps\mp\_utility::getweaponclass(param_01) == "weapon_sniper")
	{
	}

	if(isdefined(var_41[0]) && var_41[0] == "vzscope")
	{
	}
	else if(isdefined(var_41[1]) && var_41[1] == "vzscope")
	{
	}
	else if(isdefined(var_41[2]) && var_41[2] == "vzscope")
	{
	}

	if(isdefined(var_41.size) && var_41.size)
	{
		for(var_09 = 0;var_09 < var_41.size;var_09++ = var_41[2])
		{
			if(isdefined(var_41[var_09 + 1]) && common_scripts\utility::is_later_in_alphabet(var_41[var_09],var_41[var_09 + 1]))
			{
				var_0A = var_41[var_09];
				var_41[var_09] = var_41[var_09 + 1];
				var_41[var_09 + 1] = var_0A;
				var_09 = 0;
				continue;
			}
		}
	}

	foreach(var_0C in var_41)
	{
		var_08 = var_08 + "_" + var_0C;
	}

	if(issubstr(var_08,"iw5_"))
	{
		var_08 = func_32BF(var_08,param_04);
		var_08 = buildweaponnamereticle(var_08,var_05);
		return var_08;
	}

	if(!isvalidweapon(var_08 + "_mp"))
	{
		return param_01 + "_mp";
	}

	var_08 = func_32BF(var_08,param_04);
	var_08 = buildweaponnamereticle(var_08,var_05);
	return var_08 + "_mp";
}

//Function Number: 42
func_32BF(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return param_00;
	}

	if(param_01 <= 0)
	{
		return param_00;
	}

	if(param_01 < 10)
	{
		param_00 = param_00 + "_camo0";
	}
	else
	{
		param_00 = param_00 + "_camo";
	}

	param_00 = param_00 + param_01;
	return param_00;
}

//Function Number: 43
buildweaponnamereticle(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return param_00;
	}

	if(param_01 <= 0)
	{
		return param_00;
	}

	param_00 = param_00 + "_scope";
	param_00 = param_00 + param_01;
	return param_00;
}

//Function Number: 44
makeletterstonumbers()
{
	var_00 = [];
	return var_41;
}

//Function Number: 45
func_32C2(param_00,param_01,param_02)
{
	self.killstreaks = [];
	var_03 = [];
	if(isdefined(param_00) && param_00 != "none")
	{
		var_04 = maps\mp\killstreaks\_killstreaks::getstreakcost(param_00);
		var_03[var_04] = param_00;
	}

	if(isdefined(param_01) && param_01 != "none")
	{
		var_04 = maps\mp\killstreaks\_killstreaks::getstreakcost(param_01);
		var_03[var_04] = param_01;
	}

	if(isdefined(param_02) && param_02 != "none")
	{
		var_04 = maps\mp\killstreaks\_killstreaks::getstreakcost(param_02);
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
func_32C5()
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
	}
}

//Function Number: 48
func_32C6(param_00,param_01)
{
	wait param_00;
	self fadeovertime(param_01);
	self.alpha = 0;
}

//Function Number: 49
func_2AEE(param_00)
{
	self.curclass = param_00;
}

//Function Number: 50
getperkforclass(param_00,param_01)
{
	var_02 = func_28BD(param_01);
	if(issubstr(param_01,"custom"))
	{
		return func_28C1(var_02,param_00);
	}

	return func_28CA(level.classtablename,var_02,param_00);
}

//Function Number: 51
func_32C8(param_00,param_01)
{
	return getperkforclass(0,param_00) == param_01 || getperkforclass(1,param_00) == param_01 || getperkforclass(2,param_00) == param_01;
}

//Function Number: 52
func_32A0(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	switch(param_00)
	{
		case "iw5_l96a1":
		case "iw5_mg36":
		case "iw5_sa80":
		case "iw5_pecheneg":
		case "iw5_mk46":
		case "iw5_m60":
		case "xm25":
		case "iw5_spas12":
		case "iw5_usas12":
		case "iw5_aa12":
		case "iw5_striker":
		case "iw5_1887":
		case "iw5_ksg":
		case "iw5_as50":
		case "iw5_msr":
		case "iw5_dragunov":
		case "iw5_rsass":
		case "iw5_barrett":
		case "iw5_ump45":
		case "iw5_pp90m1":
		case "iw5_p90":
		case "iw5_m9":
		case "iw5_mp7":
		case "iw5_mp5":
		case "iw5_cm901":
		case "iw5_g36c":
		case "iw5_scar":
		case "iw5_mk14":
		case "iw5_type95":
		case "iw5_acr":
		case "iw5_fad":
		case "iw5_m16":
		case "iw5_ak47":
		case "riotshield":
		case "iw5_m4":
		case "iw5_riotshieldjugg":
		case "iw5_m60jugg":
			return 1;

		default:
			if(param_01)
			{
			}
			return 0;
	}
}

//Function Number: 53
func_32A1(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	switch(param_00)
	{
		case "javelin":
		case "stinger":
		case "iw5_smaw":
		case "rpg":
		case "iw5_fnfiveseven":
		case "iw5_p99":
		case "iw5_skorpion":
		case "iw5_mp9":
		case "iw5_fmg9":
		case "iw5_g18":
		case "iw5_mp412":
		case "iw5_deserteagle":
		case "iw5_44magnum":
		case "xm25":
		case "iw5_usp45jugg":
		case "iw5_mp412jugg":
		case "iw5_usp45":
		case "m320":
			return 1;

		case "iw5_l96a1":
		case "iw5_mg36":
		case "iw5_sa80":
		case "iw5_pecheneg":
		case "iw5_mk46":
		case "iw5_m60":
		case "iw5_spas12":
		case "iw5_usas12":
		case "iw5_aa12":
		case "iw5_striker":
		case "iw5_1887":
		case "iw5_ksg":
		case "iw5_as50":
		case "iw5_msr":
		case "iw5_dragunov":
		case "iw5_rsass":
		case "iw5_barrett":
		case "iw5_ump45":
		case "iw5_pp90m1":
		case "iw5_p90":
		case "iw5_m9":
		case "iw5_mp7":
		case "iw5_mp5":
		case "iw5_cm901":
		case "iw5_g36c":
		case "iw5_scar":
		case "iw5_mk14":
		case "iw5_type95":
		case "iw5_acr":
		case "iw5_fad":
		case "iw5_m16":
		case "iw5_ak47":
		case "riotshield":
		case "iw5_m4":
			if(getdvarint("scr_game_perks") == 1 && param_01 == "specialty_twoprimaries" || param_02 == "specialty_twoprimaries")
			{
				return 1;
			}
			else
			{
				return 0;
			}
	
			break;

		default:
			if(param_03)
			{
			}
			return 0;
	}
}

//Function Number: 54
func_32C9(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	switch(param_00)
	{
		case "hybrid":
		case "hamrhybrid":
		case "xmags":
		case "rof":
		case "fmj":
		case "heartbeat":
		case "grip":
		case "zoomscope":
		case "gl":
		case "m320":
		case "gp25":
		case "silencer":
		case "silencer03":
		case "silencer02":
		case "eotechlmg":
		case "reflexlmg":
		case "thermalsmg":
		case "acogsmg":
		case "acog":
		case "eotechsmg":
		case "eotech":
		case "reflexsmg":
		case "reflex":
		case "vzscope":
		case "tactical":
		case "shotgun":
		case "akimbo":
		case "none":
		case "thermal":
			return 1;

		default:
			if(param_01)
			{
			}
			return 0;
	}
}

//Function Number: 55
isattachmentunlocked(param_00,param_01)
{
	var_02 = 0;
	var_03 = 2;
	var_04 = 4;
	var_05 = self getplayerdata("weaponRank",param_00);
	var_06 = int(tablelookup("mp/weaponRankTable.csv",var_02,maps\mp\_utility::getweaponclass(param_00),var_03));
	var_07 = int(tablelookup("mp/weaponRankTable.csv",var_06,param_01,var_04));
	if(var_05 >= var_07)
	{
		return 1;
	}

	return 0;
}

//Function Number: 56
isvalidweaponbuff(param_00,param_01)
{
	var_02 = maps\mp\_utility::getweaponclass(param_01);
	if(var_02 == "weapon_assault")
	{
		switch(param_00)
		{
			case "specialty_reducedsway":
			case "specialty_holdbreathwhileads":
			case "specialty_sharp_focus":
			case "specialty_bling":
			case "specialty_marksman":
			case "specialty_bulletpenetration":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}

		return;
	}

	if(var_02 == "weapon_smg")
	{
		switch(param_00)
		{
			case "specialty_fastermelee":
			case "specialty_longerrange":
			case "specialty_reducedsway":
			case "specialty_sharp_focus":
			case "specialty_bling":
			case "specialty_marksman":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}

		return;
	}

	if(var_02 == "weapon_lmg")
	{
		switch(param_00)
		{
			case "specialty_lightweight":
			case "specialty_reducedsway":
			case "specialty_sharp_focus":
			case "specialty_bling":
			case "specialty_marksman":
			case "specialty_bulletpenetration":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}

		return;
	}

	if(var_02 == "weapon_sniper")
	{
		switch(param_00)
		{
			case "specialty_lightweight":
			case "specialty_reducedsway":
			case "specialty_sharp_focus":
			case "specialty_bling":
			case "specialty_marksman":
			case "specialty_bulletpenetration":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}

		return;
	}

	if(var_02 == "weapon_shotgun")
	{
		switch(param_00)
		{
			case "specialty_moredamage":
			case "specialty_fastermelee":
			case "specialty_longerrange":
			case "specialty_sharp_focus":
			case "specialty_bling":
			case "specialty_marksman":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}

		return;
	}

	if(var_02 == "weapon_riot")
	{
		switch(param_00)
		{
			case "specialty_lightweight":
			case "specialty_fastermelee":
				return 1;

			default:
				self.detectedexploit = 250;
				return 0;
		}

		return;
	}

	self.detectedexploit = 250;
	return 0;
}

//Function Number: 57
isweaponbuffunlocked(param_00,param_01)
{
	var_02 = 0;
	var_03 = 4;
	var_04 = 4;
	var_05 = self getplayerdata("weaponRank",param_00);
	var_06 = int(tablelookup("mp/weaponRankTable.csv",var_02,maps\mp\_utility::getweaponclass(param_00),var_03));
	var_07 = int(tablelookup("mp/weaponRankTable.csv",var_06,param_01,var_04));
	if(var_05 >= var_07)
	{
		return 1;
	}

	return 0;
}

//Function Number: 58
isvalidcamo(param_00)
{
	switch(param_00)
	{
		case "gold":
		case "autumn":
		case "red":
		case "blue":
		case "winter":
		case "snake":
		case "marine":
		case "choco":
		case "hex":
		case "d_urban":
		case "multi":
		case "snow":
		case "classic":
		case "none":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 59
isvalidreticle(param_00)
{
	switch(param_00)
	{
		case "ret6":
		case "ret5":
		case "ret4":
		case "ret3":
		case "ret2":
		case "ret1":
		case "none":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 60
func_32CE(param_00,param_01)
{
	var_02 = 0;
	var_03 = 3;
	var_04 = 4;
	var_05 = self getplayerdata("weaponRank",param_00);
	var_06 = int(tablelookup("mp/weaponRankTable.csv",var_02,maps\mp\_utility::getweaponclass(param_00),var_03));
	var_07 = int(tablelookup("mp/weaponRankTable.csv",var_06,param_01,var_04));
	if(var_05 >= var_07)
	{
		return 1;
	}

	return 0;
}

//Function Number: 61
func_32CF(param_00)
{
	switch(param_00)
	{
		case "bouncingbetty_mp":
		case "c4_mp":
		case "semtex_mp":
		case "claymore_mp":
		case "specialty_portable_radar":
		case "throwingknife_mp":
		case "frag_grenade_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 62
func_32D0(param_00)
{
	switch(param_00)
	{
		case "emp_grenade_mp":
		case "specialty_tacticalinsertion":
		case "specialty_scrambler":
		case "concussion_grenade_mp":
		case "flash_grenade_mp":
		case "specialty_portable_radar":
		case "smoke_grenade_mp":
		case "trophy_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 63
func_32D1(param_00)
{
	switch(param_00)
	{
		case "specialty_paint":
		case "specialty_fastreload":
		case "specialty_longersprint":
		case "specialty_blindeye":
		case "specialty_scavenger":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 64
func_32D2(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 != "specialty_anytwo")
	{
		switch(param_00)
		{
			case "_specialty_blastshield":
			case "specialty_hardline":
			case "specialty_twoprimaries":
			case "specialty_quickdraw":
			case "specialty_assists":
			case "specialty_coldblooded":
				return 1;

			default:
				return 0;
		}
	}

	return 1;
}

//Function Number: 65
func_32D3(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 != "specialty_anytwo")
	{
		switch(param_00)
		{
			case "specialty_stalker":
			case "specialty_quieter":
			case "specialty_autospot":
			case "specialty_detectexplosive":
			case "specialty_bulletaccuracy":
				return 1;

			default:
				return 0;
		}
	}

	return 1;
}

//Function Number: 66
func_32D4(param_00)
{
	switch(param_00)
	{
		case "specialty_c4death":
		case "specialty_stopping_power":
		case "specialty_revenge":
		case "specialty_grenadepulldeath":
		case "specialty_juiced":
		case "specialty_uav":
		case "specialty_finalstand":
		case "specialty_null":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 67
isvalidweapon(param_00)
{
	if(!isdefined(level.var_32D6))
	{
		level.var_32D6 = [];
		foreach(var_02 in level.weaponlist)
		{
			level.var_32D6[var_02] = 1;
		}
	}

	if(isdefined(level.var_32D6[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 68
isvalidkillstreak(param_00)
{
	switch(param_00)
	{
		case "specialty_stalker_ks":
		case "specialty_quieter_ks":
		case "specialty_bulletaccuracy_ks":
		case "specialty_autospot_ks":
		case "specialty_detectexplosive_ks":
		case "_specialty_blastshield_ks":
		case "specialty_assists_ks":
		case "specialty_quickdraw_ks":
		case "specialty_coldblooded_ks":
		case "specialty_hardline_ks":
		case "specialty_paint_ks":
		case "specialty_blindeye_ks":
		case "specialty_scavenger_ks":
		case "specialty_fastreload_ks":
		case "specialty_longersprint_ks":
		case "littlebird_support":
		case "helicopter":
		case "sam_turret":
		case "airdrop_remote_tank":
		case "remote_tank":
		case "remote_uav":
		case "uav_support":
		case "airdrop_juggernaut_recon":
		case "remote_mg_turret":
		case "remote_mortar":
		case "aastrike":
		case "ims":
		case "heli_sniper":
		case "directional_uav":
		case "deployable_vest":
		case "osprey_gunner":
		case "escort_airdrop":
		case "minigun_turret":
		case "airdrop_trap":
		case "stealth_airstrike":
		case "littlebird_flock":
		case "helicopter_flares":
		case "airdrop_juggernaut":
		case "airdrop_sentry_minigun":
		case "airdrop_assault":
		case "sentry":
		case "counter_uav":
		case "predator_missile":
		case "precision_airstrike":
		case "ac130":
		case "triple_uav":
		case "double_uav":
		case "uav":
		case "emp":
		case "none":
			return 1;

		default:
			return 0;
	}
}