/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/gametypes/_class.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 92
 * Decompile Time: 1504 ms
 * Timestamp: 10/27/2023 1:50:04 AM
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
	level.classmap["custom16"] = 15;
	level.classmap["custom17"] = 16;
	level.classmap["custom18"] = 17;
	level.classmap["custom19"] = 18;
	level.classmap["custom20"] = 19;
	level.classmap["custom21"] = 20;
	level.classmap["custom22"] = 21;
	level.classmap["custom23"] = 22;
	level.classmap["custom24"] = 23;
	level.classmap["custom25"] = 24;
	level.classmap["custom26"] = 25;
	level.classmap["custom27"] = 26;
	level.classmap["custom28"] = 27;
	level.classmap["custom29"] = 28;
	level.classmap["custom30"] = 29;
	level.classmap["custom31"] = 30;
	level.classmap["custom32"] = 31;
	level.classmap["custom33"] = 32;
	level.classmap["custom34"] = 33;
	level.classmap["custom35"] = 34;
	level.classmap["custom36"] = 35;
	level.classmap["custom37"] = 36;
	level.classmap["custom38"] = 37;
	level.classmap["custom39"] = 38;
	level.classmap["custom40"] = 39;
	level.classmap["custom41"] = 40;
	level.classmap["custom42"] = 41;
	level.classmap["custom43"] = 42;
	level.classmap["custom44"] = 43;
	level.classmap["custom45"] = 44;
	level.classmap["custom46"] = 45;
	level.classmap["custom47"] = 46;
	level.classmap["custom48"] = 47;
	level.classmap["custom49"] = 48;
	level.classmap["custom50"] = 49;
	level.classmap["custom51"] = 50;
	level.classmap["custom52"] = 51;
	level.classmap["custom53"] = 52;
	level.classmap["custom54"] = 53;
	level.classmap["custom55"] = 54;
	level.classmap["custom56"] = 55;
	level.classmap["custom57"] = 56;
	level.classmap["custom58"] = 57;
	level.classmap["custom59"] = 58;
	level.classmap["custom60"] = 59;
	level.classmap["practice1"] = 0;
	level.classmap["practice2"] = 1;
	level.classmap["practice3"] = 2;
	level.classmap["practice4"] = 3;
	level.classmap["practice5"] = 4;
	level.classmap["practice6"] = 5;
	level.classmap["practice7"] = 6;
	level.classmap["practice8"] = 7;
	level.classmap["practice9"] = 8;
	level.classmap["practice10"] = 9;
	level.classmap["lobby1"] = 0;
	level.classmap["lobby2"] = 1;
	level.classmap["lobby3"] = 2;
	level.classmap["lobby4"] = 3;
	level.classmap["lobby5"] = 4;
	level.classmap["lobby6"] = 5;
	level.classmap["lobby7"] = 6;
	level.classmap["lobby8"] = 7;
	level.classmap["lobby9"] = 8;
	level.classmap["lobby10"] = 9;
	level.classmap["lobby11"] = 10;
	level.classmap["lobby12"] = 11;
	level.classmap["lobby13"] = 12;
	level.classmap["lobby14"] = 13;
	level.classmap["lobby15"] = 14;
	level.classmap["lobby16"] = 15;
	level.classmap["lobby17"] = 16;
	level.classmap["lobby18"] = 17;
	level.classmap["lobby19"] = 18;
	level.classmap["lobby20"] = 19;
	level.classmap["lobby21"] = 20;
	level.classmap["lobby22"] = 21;
	level.classmap["lobby23"] = 22;
	level.classmap["lobby24"] = 23;
	level.classmap["lobby25"] = 24;
	level.classmap["lobby26"] = 25;
	level.classmap["lobby27"] = 26;
	level.classmap["lobby28"] = 27;
	level.classmap["lobby29"] = 28;
	level.classmap["lobby30"] = 29;
	level.classmap["lobby31"] = 30;
	level.classmap["lobby32"] = 31;
	level.classmap["lobby33"] = 32;
	level.classmap["lobby34"] = 33;
	level.classmap["lobby35"] = 34;
	level.classmap["lobby36"] = 35;
	level.classmap["lobby37"] = 36;
	level.classmap["lobby38"] = 37;
	level.classmap["lobby39"] = 38;
	level.classmap["lobby40"] = 39;
	level.classmap["lobby41"] = 40;
	level.classmap["lobby42"] = 41;
	level.classmap["lobby43"] = 42;
	level.classmap["lobby44"] = 43;
	level.classmap["lobby45"] = 44;
	level.classmap["lobby46"] = 45;
	level.classmap["lobby47"] = 46;
	level.classmap["lobby48"] = 47;
	level.classmap["lobby49"] = 48;
	level.classmap["lobby50"] = 49;
	level.classmap["lobby51"] = 50;
	level.classmap["lobby52"] = 51;
	level.classmap["lobby53"] = 52;
	level.classmap["lobby54"] = 53;
	level.classmap["lobby55"] = 54;
	level.classmap["lobby56"] = 55;
	level.classmap["lobby57"] = 56;
	level.classmap["lobby58"] = 57;
	level.classmap["lobby59"] = 58;
	level.classmap["lobby60"] = 59;
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
	level.classmap["copycat"] = -1;
	level.classmap["gamemode"] = 0;
	level.classmap["callback"] = 0;
	level.defaultclass = "CLASS_ASSAULT";
	level.classtablename = "mp/classTable.csv";
	level.practiceroundclasstablename = "mp/practiceRoundClassTable.csv";
	level.practiceroundcostumetablename = "mp/practiceRoundCostumeTable.csv";
	level.agentcostumetablename = "mp/agentCostumeTable.csv";
	level.hardcorecostumetablename = "mp/hardcoreCostumeTable.csv";
	level.classpickcount = 13;
	if(!isdefined(level.customclasspickcount))
	{
		level.customclasspickcount = 13;
	}

	level.costumecat2gearsettablecol = [];
	level.costumecat2gearsettablecol["shirt"] = 8;
	level.costumecat2gearsettablecol["pants"] = 11;
	level.costumecat2gearsettablecol["gloves"] = 10;
	level.costumecat2gearsettablecol["shoes"] = 13;
	level.costumecat2gearsettablecol["kneepads"] = 12;
	level.costumecat2gearsettablecol["gear"] = 9;
	level.costumecat2gearsettablecol["hat"] = 7;
	level.costumecat2gearsettablecol["eyewear"] = 6;
	level.costumecat2gearsettablecol["exo"] = 14;
	level thread onplayerconnecting();
}

//Function Number: 2
getemptyloadout()
{
	var_00 = [];
	var_00["loadoutPrimary"] = "iw5_combatknife";
	var_00["loadoutPrimaryAttachment"] = "none";
	var_00["loadoutPrimaryAttachment2"] = "none";
	var_00["loadoutPrimaryAttachment3"] = "none";
	var_00["loadoutPrimaryCamo"] = "none";
	var_00["loadoutPrimaryReticle"] = "none";
	var_00["loadoutSecondary"] = "none";
	var_00["loadoutSecondaryAttachment"] = "none";
	var_00["loadoutSecondaryAttachment2"] = "none";
	var_00["loadoutSecondaryAttachment3"] = "none";
	var_00["loadoutSecondaryCamo"] = "none";
	var_00["loadoutSecondaryReticle"] = "none";
	var_00["loadoutEquipment"] = "specialty_null";
	var_00["loadoutEquipmentExtra"] = 0;
	var_00["loadoutOffhand"] = "none";
	var_00["loadoutOffhandExtra"] = 0;
	var_00["loadoutKillstreaks"][0] = "none";
	var_00["loadoutKillstreaks"][1] = "none";
	var_00["loadoutKillstreaks"][2] = "none";
	var_00["loadoutKillstreaks"][3] = "none";
	var_00["loadoutKillstreakModules"][0][0] = "none";
	var_00["loadoutKillstreakModules"][0][1] = "none";
	var_00["loadoutKillstreakModules"][0][2] = "none";
	var_00["loadoutKillstreakModules"][1][0] = "none";
	var_00["loadoutKillstreakModules"][1][1] = "none";
	var_00["loadoutKillstreakModules"][1][2] = "none";
	var_00["loadoutKillstreakModules"][2][0] = "none";
	var_00["loadoutKillstreakModules"][2][1] = "none";
	var_00["loadoutKillstreakModules"][2][2] = "none";
	var_00["loadoutKillstreakModules"][3][0] = "none";
	var_00["loadoutKillstreakModules"][3][1] = "none";
	var_00["loadoutKillstreakModules"][3][2] = "none";
	var_00["loadoutPerks"] = maps\mp\perks\_perks::getemptyperks();
	var_00["loadoutWildcards"] = ["specialty_null","specialty_null","specialty_null"];
	var_00["loadoutJuggernaut"] = 0;
	return var_00;
}

//Function Number: 3
getclasschoice(param_00)
{
	return param_00;
}

//Function Number: 4
getweaponchoice(param_00)
{
	var_01 = strtok(param_00,",");
	if(var_01.size > 1)
	{
		return int(var_01[1]);
	}

	return 0;
}

//Function Number: 5
logclasschoice(param_00,param_01,param_02,param_03)
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

//Function Number: 6
cac_getweapon(param_00,param_01)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"weaponSetups",param_01,"weapon");
	}

	return self getcacplayerdata(param_00,"weaponSetups",param_01,"weapon");
}

//Function Number: 7
cac_getweaponattachment(param_00,param_01)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"weaponSetups",param_01,"attachment",0);
	}

	return self getcacplayerdata(param_00,"weaponSetups",param_01,"attachment",0);
}

//Function Number: 8
cac_getweaponattachmenttwo(param_00,param_01)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"weaponSetups",param_01,"attachment",1);
	}

	return self getcacplayerdata(param_00,"weaponSetups",param_01,"attachment",1);
}

//Function Number: 9
cac_getweaponattachmentthree(param_00,param_01)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"weaponSetups",param_01,"attachment",2);
	}

	return self getcacplayerdata(param_00,"weaponSetups",param_01,"attachment",2);
}

//Function Number: 10
cac_getweaponcamo(param_00,param_01)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"weaponSetups",param_01,"camo");
	}

	return self getcacplayerdata(param_00,"weaponSetups",param_01,"camo");
}

//Function Number: 11
cac_getweaponreticle(param_00,param_01)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"weaponSetups",param_01,"reticle");
	}

	return self getcacplayerdata(param_00,"weaponSetups",param_01,"reticle");
}

//Function Number: 12
cac_getperk(param_00,param_01)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"perkSlots",param_01);
	}

	return self getcacplayerdata(param_00,"perkSlots",param_01);
}

//Function Number: 13
cac_getwildcard(param_00,param_01)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"wildcardSlots",param_01);
	}

	return self getcacplayerdata(param_00,"wildcardSlots",param_01);
}

//Function Number: 14
cac_getkillstreak(param_00,param_01)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"assaultStreaks",param_01,"streak");
	}

	return self getcacplayerdata(param_00,"assaultStreaks",param_01,"streak");
}

//Function Number: 15
cac_getkillstreakmodule(param_00,param_01,param_02)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"assaultStreaks",param_01,"modules",param_02);
	}

	return self getcacplayerdata(param_00,"assaultStreaks",param_01,"modules",param_02);
}

//Function Number: 16
cac_getequipment(param_00,param_01)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"equipmentSetups",param_01,"equipment");
	}

	return self getcacplayerdata(param_00,"equipmentSetups",param_01,"equipment");
}

//Function Number: 17
cac_getequipmentextra(param_00,param_01)
{
	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"equipmentSetups",param_01,"extra");
	}

	return self getcacplayerdata(param_00,"equipmentSetups",param_01,"extra");
}

//Function Number: 18
cac_getoffhand(param_00)
{
	return cac_getequipment(param_00,1);
}

//Function Number: 19
cao_isglobalcostumecategory(param_00)
{
	return param_00 == "gender" || param_00 == "head";
}

//Function Number: 20
cao_getglobalcostumecategory(param_00)
{
	return self getcommonplayerdata("globalCostume",param_00);
}

//Function Number: 21
cao_getpercostumecategory(param_00,param_01)
{
	return self getcommonplayerdata("costumes",param_01,param_00);
}

//Function Number: 22
cao_setglobalcostumecategory(param_00,param_01)
{
	return self setcommonplayerdata("globalCostume",param_00,param_01);
}

//Function Number: 23
cao_setpercostumecategory(param_00,param_01,param_02)
{
	return self setcommonplayerdata("costumes",param_02,param_00,param_01);
}

//Function Number: 24
cao_getactivecostumeindex()
{
	return self getcommonplayerdata("activeCostume");
}

//Function Number: 25
cao_getcostumebyindex(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.costumecategories.size;var_02++)
	{
		var_03 = level.costumecategories[var_02];
		if(cao_isglobalcostumecategory(var_03))
		{
			var_01[var_02] = cao_getglobalcostumecategory(var_03);
			continue;
		}

		var_01[var_02] = cao_getpercostumecategory(var_03,param_00);
	}

	return var_01;
}

//Function Number: 26
cao_getactivecostume()
{
	var_00 = cao_getactivecostumeindex();
	return cao_getcostumebyindex(var_00);
}

//Function Number: 27
cao_setcostumebyindex(param_00,param_01)
{
	param_00 = validatecostume(param_00);
	for(var_02 = 0;var_02 < level.costumecategories.size;var_02++)
	{
		var_03 = level.costumecategories[var_02];
		if(cao_isglobalcostumecategory(var_03))
		{
			cao_setglobalcostumecategory(var_03,param_00[var_02]);
			continue;
		}

		cao_setpercostumecategory(var_03,param_00[var_02],param_01);
	}
}

//Function Number: 28
cao_setactivecostume(param_00)
{
	var_01 = cao_getactivecostumeindex();
	cao_setcostumebyindex(param_00,var_01);
}

//Function Number: 29
checkforcostumeset()
{
	if(isdefined(self.costume) && getdvarint("bg_customization_gearSetBonusEnabled"))
	{
		var_00 = [];
		self.costumebonus = [];
		for(var_01 = 0;var_01 < self.costume.size;var_01++)
		{
			var_02 = level.costumecategories[var_01];
			var_03 = level.costumetypehexids[var_02];
			var_04 = self.costume[var_01];
			var_05 = function_02DE(var_03,var_04);
			var_06 = level.costumecat2gearsettablecol[var_02];
			if(isdefined(var_06))
			{
				var_07 = tablelookuprownum("mp/characterGearSetTable.csv",var_06,var_05);
				while(isdefined(var_07) && var_07 >= 0)
				{
					var_08 = tablelookupbyrow("mp/characterGearSetTable.csv",var_07,0);
					if(!isdefined(var_00[var_08]))
					{
						var_09 = tablelookupbyrow("mp/characterGearSetTable.csv",var_07,3);
						var_0A = getdvarfloat("bg_customization_gearSetBonusXP");
						var_0B = tablelookupbyrow("mp/characterGearSetTable.csv",var_07,5);
						var_0C = [];
						var_0C["bonusType"] = var_09;
						var_0C["bonus"] = var_0A;
						var_0C["amtInSet"] = var_0B;
						var_0C["foundAmt"] = 1;
						var_00[var_08] = var_0C;
					}
					else
					{
						var_00[var_08]["foundAmt"]++;
					}

					var_07 = var_07 - 1;
					if(var_07 >= 0)
					{
						var_07 = tablelookuprownum("mp/characterGearSetTable.csv",var_06,var_05,var_07);
					}
				}
			}
		}

		var_0D = getarraykeys(var_00);
		for(var_01 = 0;var_01 < var_0D.size;var_01++)
		{
			var_08 = var_0D[var_01];
			var_0E = tablelookup("mp/characterGearSetTable.csv",0,var_08,15);
			var_0F = int(tablelookup("mp/characterGearSetTable.csv",0,var_08,16));
			var_10 = getdvarint("bg_customization_gearSetKillswitch_" + var_0E);
			if(var_0F & var_10 > 0)
			{
				var_09 = var_00[var_08]["bonusType"];
				var_0A = var_00[var_08]["bonus"];
				var_0B = int(var_00[var_08]["amtInSet"]);
				var_11 = var_00[var_08]["foundAmt"];
				if(var_0B == var_11)
				{
					if(!isdefined(self.costumebonus[var_09]))
					{
						var_12 = [];
						var_12[var_08] = var_0A;
						self.costumebonus[var_09] = [];
						self.costumebonus[var_09]["refs"] = var_12;
						self.costumebonus[var_09]["bonusTotal"] = var_0A;
					}
					else
					{
						self.costumebonus[var_09]["refs"][var_08] = var_0A;
						self.costumebonus[var_09]["bonusTotal"] = self.costumebonus[var_09]["bonusTotal"] + var_0A;
					}
				}
			}
		}
	}
}

//Function Number: 30
table_getweapon(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimary",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondary",param_01 + 1);
}

//Function Number: 31
table_getweaponattachment(param_00,param_01,param_02,param_03)
{
	var_04 = "none";
	var_05 = "loadoutPrimaryAttachment";
	if(param_02)
	{
		var_05 = "loadoutSecondaryAttachment";
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	switch(param_03)
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			break;

		default:
			break;
	}
}

//Function Number: 32
table_getweaponbuff(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryBuff",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryBuff",param_01 + 1);
}

//Function Number: 33
table_getweaponcamo(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryCamo",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryCamo",param_01 + 1);
}

//Function Number: 34
table_getweaponreticle(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryReticle",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryReticle",param_01 + 1);
}

//Function Number: 35
table_getperk(param_00,param_01,param_02)
{
	param_02++;
	var_03 = "loadoutPerk" + param_02;
	return tablelookup(param_00,0,var_03,param_01 + 1);
}

//Function Number: 36
table_getwildcard(param_00,param_01,param_02)
{
	param_02++;
	var_03 = "loadoutWildcard" + param_02;
	return tablelookup(param_00,0,var_03,param_01 + 1);
}

//Function Number: 37
table_getequipment(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutEquipment",param_01 + 1);
}

//Function Number: 38
table_getequipmentextra(param_00,param_01)
{
	var_02 = tablelookup(param_00,0,"loadoutEquipment2",param_01 + 1);
	return var_02 != "" && var_02 != "specialty_null";
}

//Function Number: 39
table_getteamperk(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutTeamPerk",param_01 + 1);
}

//Function Number: 40
table_getoffhand(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutOffhand",param_01 + 1);
}

//Function Number: 41
table_getoffhandextra(param_00,param_01)
{
	var_02 = tablelookup(param_00,0,"loadoutOffhand2",param_01 + 1);
	return var_02 != "" && var_02 != "specialty_null";
}

//Function Number: 42
table_getkillstreak(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,"loadoutStreak" + param_02 + 1,param_01 + 1);
}

//Function Number: 43
table_getkillstreakmodule(param_00,param_01,param_02,param_03)
{
	switch(param_03)
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			break;

		default:
			break;
	}
}

//Function Number: 44
cloneloadout()
{
	var_00 = "none";
	var_01 = self.curclass;
	var_02 = self.classcallback;
	var_03 = undefined;
	if(var_01 == "copycat")
	{
		var_01 = self.pers["copyCatLoadout"]["className"];
		var_03 = self.pers["copyCatLoadout"]["practiceClassNum"];
		if(var_01 == "callback")
		{
			var_02 = self.pers["copyCatLoadout"]["classCallbackFunc"];
		}
	}

	if(issubstr(var_01,"axis"))
	{
		var_00 = "axis";
	}
	else if(issubstr(var_01,"allies"))
	{
		var_00 = "allies";
	}

	var_04 = [];
	var_05 = [];
	var_06 = [];
	var_07 = [];
	if(var_00 != "none")
	{
		var_08 = maps\mp\_utility::getclassindex(var_01);
		var_09 = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",0,"weapon");
		var_0A = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",0,"attachment",0);
		var_0B = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",0,"attachment",1);
		var_0C = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",0,"attachment",2);
		var_0D = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",0,"camo");
		var_0E = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",0,"reticle");
		var_0F = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",1,"weapon");
		var_10 = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",1,"attachment",0);
		var_11 = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",1,"attachment",1);
		var_12 = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",1,"attachment",2);
		var_13 = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",1,"camo");
		var_14 = getmatchrulesdata("defaultClasses",var_00,var_08,"class","weaponSetups",1,"reticle");
		var_15 = getmatchrulesdata("defaultClasses",var_00,var_08,"class","equipmentSetups",0,"equipment");
		var_16 = getmatchrulesdata("defaultClasses",var_00,var_08,"class","equipmentSetups",0,"extra");
		var_17 = getmatchrulesdata("defaultClasses",var_00,var_08,"class","equipmentSetups",1,"equipment");
		var_18 = getmatchrulesdata("defaultClasses",var_00,var_08,"class","equipmentSetups",1,"extra");
		for(var_19 = 0;var_19 < 6;var_19++)
		{
			var_04[var_19] = getmatchrulesdata("defaultClasses",var_00,var_08,"class","perkSlots",var_19);
		}

		for(var_19 = 0;var_19 < 3;var_19++)
		{
			var_05[var_19] = getmatchrulesdata("defaultClasses",var_00,var_08,"class","wildcardSlots",var_19);
		}

		for(var_19 = 0;var_19 < 4;var_19++)
		{
			var_06[var_19] = getmatchrulesdata("defaultClasses",var_00,var_08,"class","assaultStreaks",var_19,"streak");
			var_07[var_19] = [];
			for(var_1A = 0;var_1A < 3;var_1A++)
			{
				var_07[var_19][var_1A] = getmatchrulesdata("defaultClasses",var_00,var_08,"class","assaultStreaks",var_19,"modules",var_1A);
			}
		}
	}
	else if(issubstr(var_14,"custom"))
	{
		var_1B = maps\mp\_utility::getclassindex(var_14);
		var_09 = cac_getweapon(var_1B,0);
		var_0A = cac_getweaponattachment(var_1B,0);
		var_0B = cac_getweaponattachmenttwo(var_1B,0);
		var_0C = cac_getweaponattachmentthree(var_1B,0);
		var_0D = cac_getweaponcamo(var_1B,0);
		var_0E = cac_getweaponreticle(var_1B,0);
		var_0F = cac_getweapon(var_1B,1);
		var_10 = cac_getweaponattachment(var_1B,1);
		var_11 = cac_getweaponattachmenttwo(var_1B,1);
		var_12 = cac_getweaponattachmentthree(var_1B,1);
		var_13 = cac_getweaponcamo(var_1B,1);
		var_14 = cac_getweaponreticle(var_1B,1);
		var_15 = cac_getequipment(var_1B,0);
		var_16 = cac_getequipmentextra(var_1B,0);
		var_17 = cac_getequipment(var_1B,1);
		var_18 = cac_getequipmentextra(var_1B,1);
		for(var_19 = 0;var_19 < 6;var_19++)
		{
			var_04[var_19] = cac_getperk(var_1B,var_19);
		}

		for(var_19 = 0;var_19 < 3;var_19++)
		{
			var_05[var_19] = cac_getwildcard(var_1B,var_19);
		}

		for(var_19 = 0;var_19 < 4;var_19++)
		{
			var_06[var_19] = cac_getkillstreak(var_1B,var_19);
			var_07[var_19] = [];
			for(var_1A = 0;var_1A < 3;var_1A++)
			{
				var_07[var_19][var_1A] = cac_getkillstreakmodule(var_1B,var_19,var_1A);
			}
		}
	}
	else if(maps\mp\_utility::practiceroundgame() && issubstr(var_14,"practice"))
	{
		var_1B = maps\mp\_utility::getclassindex(var_14);
		if(isdefined(var_03))
		{
			var_1B = var_03;
		}
		else
		{
			var_1B = self.pers["practiceRoundClasses"][var_1B];
			var_03 = var_1B;
		}

		var_09 = table_getweapon(level.practiceroundclasstablename,var_1B,0);
		var_0A = table_getweaponattachment(level.practiceroundclasstablename,var_1B,0,0);
		var_0B = table_getweaponattachment(level.practiceroundclasstablename,var_1B,0,1);
		var_0C = table_getweaponattachment(level.practiceroundclasstablename,var_1B,0,2);
		var_0D = table_getweaponcamo(level.practiceroundclasstablename,var_1B,0);
		var_0E = table_getweaponreticle(level.practiceroundclasstablename,var_1B,0);
		var_0F = table_getweapon(level.practiceroundclasstablename,var_1B,1);
		var_10 = table_getweaponattachment(level.practiceroundclasstablename,var_1B,1,0);
		var_11 = table_getweaponattachment(level.practiceroundclasstablename,var_1B,1,1);
		var_12 = table_getweaponattachment(level.practiceroundclasstablename,var_1B,1,2);
		var_13 = table_getweaponcamo(level.practiceroundclasstablename,var_1B,1);
		var_14 = table_getweaponreticle(level.practiceroundclasstablename,var_1B,1);
		var_15 = table_getequipment(level.practiceroundclasstablename,var_1B);
		var_16 = table_getequipmentextra(level.practiceroundclasstablename,var_1B);
		var_17 = table_getoffhand(level.practiceroundclasstablename,var_1B);
		var_18 = table_getoffhandextra(level.practiceroundclasstablename,var_1B);
		for(var_19 = 0;var_19 < 6;var_19++)
		{
			var_04[var_19] = table_getperk(level.practiceroundclasstablename,var_1B,var_19);
		}

		for(var_19 = 0;var_19 < 3;var_19++)
		{
			var_05[var_19] = table_getwildcard(level.practiceroundclasstablename,var_1B,var_19);
		}

		for(var_19 = 0;var_19 < 4;var_19++)
		{
			var_06[var_19] = table_getkillstreak(level.practiceroundclasstablename,var_1B,var_19);
			var_07[var_19] = [];
			for(var_1A = 0;var_1A < 3;var_1A++)
			{
				var_07[var_19][var_1A] = table_getkillstreakmodule(level.practiceroundclasstablename,var_1B,var_19,var_1A);
			}
		}
	}
	else if(var_14 == "callback")
	{
		if(!isdefined(var_15))
		{
			common_scripts\utility::error("self.classCallback function reference required for class \'callback\'");
		}

		var_1C = [[ var_15 ]](1);
		if(!isdefined(var_1C))
		{
			common_scripts\utility::error("array required from self.classCallback for class \'callback\'");
		}

		var_09 = var_1C["loadoutPrimary"];
		var_0A = var_1C["loadoutPrimaryAttachment"];
		var_0B = var_1C["loadoutPrimaryAttachment2"];
		var_0C = var_1C["loadoutPrimaryAttachment3"];
		var_0D = var_1C["loadoutPrimaryCamo"];
		var_0E = var_1C["loadoutPrimaryReticle"];
		for(var_19 = 0;var_19 < 6;var_19++)
		{
			var_04[var_19] = var_1C["loadoutPerk" + var_19 + 1];
		}

		for(var_19 = 0;var_19 < 3;var_19++)
		{
			var_05[var_19] = var_1C["loadoutWildcard" + var_19 + 1];
		}

		var_0F = var_1C["loadoutSecondary"];
		var_10 = var_1C["loadoutSecondaryAttachment"];
		var_11 = var_1C["loadoutSecondaryAttachment2"];
		var_12 = var_1C["loadoutSecondaryAttachment3"];
		var_13 = var_1C["loadoutSecondaryCamo"];
		var_14 = var_1C["loadoutSecondaryReticle"];
		var_15 = var_1C["loadoutEquipment"];
		var_16 = var_1C["loadoutEquipment2"] != "specialty_null";
		var_17 = var_1C["loadoutOffhand"];
		var_18 = var_1C["loadoutOffhand2"] != "specialty_null";
		for(var_19 = 0;var_19 < 4;var_19++)
		{
			var_06[var_19] = var_1C["loadoutStreak" + var_19 + 1];
			var_07[var_19] = [];
			for(var_1A = 0;var_1A < 3;var_1A++)
			{
				var_07[var_19][var_1A] = var_1C["loadoutStreakModule" + var_19 + 1 + var_1A + 1];
			}
		}
	}
	else
	{
		var_1B = maps\mp\_utility::getclassindex(var_14);
		var_09 = table_getweapon(level.classtablename,var_1B,0);
		var_0A = table_getweaponattachment(level.classtablename,var_1B,0,0);
		var_0B = table_getweaponattachment(level.classtablename,var_1B,0,1);
		var_0C = table_getweaponattachment(level.classtablename,var_1B,0,2);
		var_0D = table_getweaponcamo(level.classtablename,var_1B,0);
		var_0E = table_getweaponreticle(level.classtablename,var_1B,0);
		var_0F = table_getweapon(level.classtablename,var_1B,1);
		var_10 = table_getweaponattachment(level.classtablename,var_1B,1,0);
		var_11 = table_getweaponattachment(level.classtablename,var_1B,1,1);
		var_12 = table_getweaponattachment(level.classtablename,var_1B,1,2);
		var_13 = table_getweaponcamo(level.classtablename,var_1B,1);
		var_14 = table_getweaponreticle(level.classtablename,var_1B,1);
		var_15 = table_getequipment(level.classtablename,var_1B);
		var_16 = table_getequipmentextra(level.classtablename,var_1B);
		var_17 = table_getoffhand(level.classtablename,var_1B);
		var_18 = table_getoffhandextra(level.classtablename,var_1B);
		for(var_19 = 0;var_19 < 6;var_19++)
		{
			var_04[var_19] = table_getperk(level.classtablename,var_1B,var_19);
		}

		for(var_19 = 0;var_19 < 3;var_19++)
		{
			var_05[var_19] = table_getwildcard(level.classtablename,var_1B,var_19);
		}

		for(var_19 = 0;var_19 < 4;var_19++)
		{
			var_06[var_19] = table_getkillstreak(level.classtablename,var_1B,var_19);
			var_07[var_19] = [];
			for(var_1A = 0;var_1A < 3;var_1A++)
			{
				var_07[var_19][var_1A] = table_getkillstreakmodule(level.classtablename,var_1B,var_19,var_1A);
			}
		}
	}

	var_1D = [];
	var_1D["inUse"] = 0;
	var_1D["className"] = var_01;
	if(isdefined(var_03))
	{
		var_1D["practiceClassNum"] = var_03;
	}

	if(var_01 == "callback" && isdefined(var_02))
	{
		var_1D["classCallbackFunc"] = var_02;
	}

	var_1D["loadoutPrimary"] = var_09;
	var_1D["loadoutPrimaryAttachment"] = var_0A;
	var_1D["loadoutPrimaryAttachment2"] = var_0B;
	var_1D["loadoutPrimaryAttachment3"] = var_0C;
	var_1D["loadoutPrimaryCamo"] = var_0D;
	var_1D["loadoutPrimaryReticle"] = var_0E;
	var_1D["loadoutSecondary"] = var_0F;
	var_1D["loadoutSecondaryAttachment"] = var_10;
	var_1D["loadoutSecondaryAttachment2"] = var_11;
	var_1D["loadoutSecondaryAttachment3"] = var_12;
	var_1D["loadoutSecondaryCamo"] = var_13;
	var_1D["loadoutSecondaryReticle"] = var_14;
	var_1D["loadoutEquipment"] = var_15;
	var_1D["loadoutEquipmentExtra"] = var_16;
	var_1D["loadoutOffhand"] = var_17;
	var_1D["loadoutOffhandExtra"] = var_18;
	for(var_19 = 0;var_19 < 6;var_19++)
	{
		var_1D["loadoutPerks"][var_19] = var_04[var_19];
	}

	for(var_19 = 0;var_19 < 3;var_19++)
	{
		var_1D["loadoutWildcards"][var_19] = var_05[var_19];
	}

	for(var_19 = 0;var_19 < 4;var_19++)
	{
		var_1D["loadoutKillstreaks"][var_19] = var_06[var_19];
		for(var_1A = 0;var_1A < 3;var_1A++)
		{
			var_1D["loadoutKillstreakModules"][var_19][var_1A] = var_07[var_19][var_1A];
		}
	}

	return var_1D;
}

//Function Number: 45
getloadout(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_04 = 0;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	var_0A = 0;
	var_0B = undefined;
	var_0C = undefined;
	var_0D = issubstr(param_01,"custom");
	var_0E = maps\mp\_utility::practiceroundgame() && issubstr(param_01,"practice");
	var_0F = 0;
	var_10 = [];
	var_11 = [];
	var_11[0] = "specialty_null";
	var_11[1] = "specialty_null";
	var_11[2] = "specialty_null";
	var_12 = undefined;
	var_13 = level.classpickcount;
	var_14 = param_01 == "gamemode";
	if(issubstr(param_01,"axis"))
	{
		var_15 = "axis";
	}
	else if(issubstr(param_02,"allies"))
	{
		var_15 = "allies";
	}
	else
	{
		var_15 = "none";
	}

	var_16 = [];
	if(isdefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && param_02)
	{
		var_0F = 1;
		var_0D = 0;
		var_0E = 0;
		var_05 = maps\mp\_utility::getclassindex("copycat");
		var_16 = self.pers["copyCatLoadout"];
		var_17 = var_16["loadoutPrimary"];
		var_18 = var_16["loadoutPrimaryAttachment"];
		var_19 = var_16["loadoutPrimaryAttachment2"];
		var_1A = var_16["loadoutPrimaryAttachment3"];
		var_1B = var_16["loadoutPrimaryCamo"];
		var_1C = var_16["loadoutPrimaryReticle"];
		var_1D = var_16["loadoutSecondary"];
		var_1E = var_16["loadoutSecondaryAttachment"];
		var_1F = var_16["loadoutSecondaryAttachment2"];
		var_20 = var_16["loadoutSecondaryAttachment3"];
		var_21 = var_16["loadoutSecondaryCamo"];
		var_22 = var_16["loadoutSecondaryReticle"];
		var_23 = var_16["loadoutEquipment"];
		var_24 = var_16["loadoutEquipmentExtra"];
		var_25 = var_16["loadoutOffhand"];
		var_26 = var_16["loadoutOffhandExtra"];
		for(var_27 = 0;var_27 < 6;var_27++)
		{
			var_10[var_27] = var_16["loadoutPerks"][var_27];
		}

		for(var_27 = 0;var_27 < 3;var_27++)
		{
			var_11[var_27] = var_16["loadoutWildcards"][var_27];
		}

		var_06 = var_16["loadoutKillstreaks"][0];
		var_07 = var_16["loadoutKillstreaks"][1];
		var_08 = var_16["loadoutKillstreaks"][2];
		var_09 = var_16["loadoutKillstreaks"][3];
	}
	else if(var_25 != "none")
	{
		var_28 = maps\mp\_utility::getclassindex(var_11);
		var_05 = var_28;
		self.class_num = var_28;
		self.teamname = var_15;
		var_13 = 20;
		var_17 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",0,"weapon");
		if(var_17 == "none")
		{
			var_17 = "iw5_combatknife";
			var_18 = "none";
			var_19 = "none";
			var_1A = "none";
		}
		else
		{
			var_18 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",0,"attachment",0);
			var_19 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",0,"attachment",1);
			var_1A = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",0,"attachment",2);
		}

		var_1B = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",0,"camo");
		var_1C = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",0,"reticle");
		var_1D = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",1,"weapon");
		var_1E = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",1,"attachment",0);
		var_1F = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",1,"attachment",1);
		var_20 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",1,"attachment",2);
		var_21 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",1,"camo");
		var_22 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","weaponSetups",1,"reticle");
		var_23 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","equipmentSetups",0,"equipment");
		var_24 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","equipmentSetups",0,"extra");
		var_25 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","equipmentSetups",1,"equipment");
		var_26 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","equipmentSetups",1,"extra");
		for(var_27 = 0;var_27 < 6;var_27++)
		{
			var_10[var_27] = getmatchrulesdata("defaultClasses",var_15,var_28,"class","perkSlots",var_27);
		}

		for(var_27 = 0;var_27 < 3;var_27++)
		{
			var_11[var_27] = getmatchrulesdata("defaultClasses",var_15,var_28,"class","wildcardSlots",var_27);
		}

		var_06 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","assaultStreaks",0,"streak");
		var_07 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","assaultStreaks",1,"streak");
		var_08 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","assaultStreaks",2,"streak");
		var_09 = getmatchrulesdata("defaultClasses",var_15,var_28,"class","assaultStreaks",3,"streak");
		if((var_17 == "throwingknife" || var_17 == "none") && var_1D != "none")
		{
			var_17 = var_1D;
			var_18 = var_1E;
			var_19 = var_1F;
			var_1A = var_20;
			var_1B = var_21;
			var_1C = var_22;
			var_1D = "none";
			var_1E = "none";
			var_1F = "none";
			var_20 = "none";
			var_21 = "none";
			var_22 = "none";
		}
		else if((var_17 == "throwingknife" || var_17 == "none") && var_1D == "none")
		{
			var_04 = 1;
			var_17 = "iw5_usp45";
			var_18 = "tactical";
		}

		var_0C = getmatchrulesdata("defaultClasses",var_15,var_28,"juggernaut");
	}
	else if(issubstr(var_11,"custom"))
	{
		var_15 = maps\mp\_utility::getclassindex(var_11);
		var_23 = level.customclasspickcount;
		var_17 = cac_getweapon(var_15,0);
		var_18 = cac_getweaponattachment(var_14,0);
		var_19 = cac_getweaponattachmenttwo(var_13,0);
		var_1A = cac_getweaponattachmentthree(var_12,0);
		var_1B = cac_getweaponcamo(var_11,0);
		var_1C = cac_getweaponreticle(var_10,0);
		var_1D = cac_getweapon(var_0F,1);
		var_1E = cac_getweaponattachment(var_0E,1);
		var_1F = cac_getweaponattachmenttwo(var_0D,1);
		var_20 = cac_getweaponattachmentthree(var_0C,1);
		var_21 = cac_getweaponcamo(var_0B,1);
		var_22 = cac_getweaponreticle(var_0A,1);
		var_23 = cac_getequipment(var_09,0);
		var_24 = cac_getequipmentextra(var_08,0);
		var_25 = cac_getequipment(var_07,1);
		var_26 = cac_getequipmentextra(var_06,1);
		for(var_27 = 0;var_27 < 6;var_27++)
		{
			var_10[var_27] = cac_getperk(var_05,var_27);
		}

		for(var_27 = 0;var_27 < 3;var_27++)
		{
			var_11[var_27] = cac_getwildcard(var_05,var_27);
		}

		var_06 = cac_getkillstreak(var_05,0);
		var_07 = cac_getkillstreak(var_05,1);
		var_08 = cac_getkillstreak(var_05,2);
		var_09 = cac_getkillstreak(var_05,3);
	}
	else if(maps\mp\_utility::practiceroundgame() && issubstr(var_11,"practice"))
	{
		var_15 = maps\mp\_utility::getclassindex(var_11);
		var_15 = self.pers["practiceRoundClasses"][var_15];
		var_17 = table_getweapon(level.practiceroundclasstablename,var_15,0);
		var_18 = table_getweaponattachment(level.practiceroundclasstablename,var_14,0,0);
		var_19 = table_getweaponattachment(level.practiceroundclasstablename,var_13,0,1);
		var_1A = table_getweaponattachment(level.practiceroundclasstablename,var_12,0,2);
		var_1B = table_getweaponcamo(level.practiceroundclasstablename,var_11,0);
		var_1C = table_getweaponreticle(level.practiceroundclasstablename,var_10,0);
		var_1D = table_getweapon(level.practiceroundclasstablename,var_0F,1);
		var_1E = table_getweaponattachment(level.practiceroundclasstablename,var_0E,1,0);
		var_1F = table_getweaponattachment(level.practiceroundclasstablename,var_0D,1,1);
		var_20 = table_getweaponattachment(level.practiceroundclasstablename,var_0C,1,2);
		var_21 = table_getweaponcamo(level.practiceroundclasstablename,var_0B,1);
		var_22 = table_getweaponreticle(level.practiceroundclasstablename,var_0A,1);
		var_23 = table_getequipment(level.practiceroundclasstablename,var_09);
		var_24 = table_getequipmentextra(level.practiceroundclasstablename,var_08);
		var_25 = table_getoffhand(level.practiceroundclasstablename,var_07);
		var_26 = table_getoffhandextra(level.practiceroundclasstablename,var_06);
		for(var_27 = 0;var_27 < 6;var_27++)
		{
			var_10[var_27] = table_getperk(level.practiceroundclasstablename,var_05,var_27);
		}

		for(var_27 = 0;var_27 < 3;var_27++)
		{
			var_11[var_27] = table_getwildcard(level.practiceroundclasstablename,var_05,var_27);
		}

		var_06 = table_getkillstreak(level.practiceroundclasstablename,var_05,0);
		var_07 = table_getkillstreak(level.practiceroundclasstablename,var_05,1);
		var_08 = table_getkillstreak(level.practiceroundclasstablename,var_05,2);
		var_09 = table_getkillstreak(level.practiceroundclasstablename,var_05,3);
	}
	else if(issubstr(var_11,"lobby"))
	{
		var_15 = maps\mp\_utility::getclassindex(var_11);
		var_29 = maps\mp\_utility::cac_getcustomclassloc();
		var_2A = self.loadouts[var_29][var_05];
		var_17 = var_2A["primary"];
		var_18 = var_2A["primaryAttachment1"];
		var_19 = var_2A["primaryAttachment2"];
		var_1A = var_2A["primaryAttachment3"];
		var_1B = var_2A["primaryCamo"];
		var_1C = var_2A["primaryReticle"];
		for(var_27 = 0;var_27 < 6;var_27++)
		{
			var_10[var_27] = var_2A["perk" + var_27];
		}

		var_23 = var_2A["equipment"];
		var_25 = var_2A["offhand"];
		var_24 = 0;
		var_26 = 0;
		for(var_27 = 0;var_27 < 3;var_27++)
		{
			var_11[var_27] = var_2A["wildcard" + var_27];
			if(var_11[var_27] == "specialty_wildcard_duallethals")
			{
				var_24 = 1;
			}
		}

		var_1D = var_2A["secondary"];
		var_1E = var_2A["secondaryAttachment1"];
		var_1F = var_2A["secondaryAttachment2"];
		var_20 = var_2A["secondaryAttachment3"];
		var_21 = var_2A["secondaryCamo"];
		var_22 = var_2A["secondaryReticle"];
	}
	else if(var_24)
	{
		var_2B = self.pers["gamemodeLoadout"];
		var_17 = var_2B["loadoutPrimary"];
		var_18 = var_2B["loadoutPrimaryAttachment"];
		var_19 = var_2B["loadoutPrimaryAttachment2"];
		var_1A = var_2B["loadoutPrimaryAttachment3"];
		var_1B = var_2B["loadoutPrimaryCamo"];
		var_1C = var_2B["loadoutPrimaryReticle"];
		for(var_27 = 0;var_27 < 6;var_27++)
		{
			var_10[var_27] = var_2B["loadoutPerks"][var_27];
		}

		for(var_27 = 0;var_27 < 3;var_27++)
		{
			var_11[var_27] = var_2B["loadoutWildcards"][var_27];
		}

		var_1D = var_2B["loadoutSecondary"];
		var_1E = var_2B["loadoutSecondaryAttachment"];
		var_1F = var_2B["loadoutSecondaryAttachment2"];
		var_20 = var_2B["loadoutSecondaryAttachment3"];
		var_21 = var_2B["loadoutSecondaryCamo"];
		var_22 = var_2B["loadoutSecondaryReticle"];
		var_23 = var_2B["loadoutEquipment"];
		var_24 = var_2B["loadoutEquipmentExtra"];
		var_25 = var_2B["loadoutOffhand"];
		var_26 = var_2B["loadoutOffhandExtra"];
		if(var_25 == "specialty_null")
		{
			var_25 = "none";
		}

		if(level.killstreakrewards)
		{
			var_2C = 1;
			if(isdefined(self.gamemode_carrierclass) && self.gamemode_carrierclass)
			{
				var_2D = 1;
				foreach(var_2F in var_2B["loadoutKillstreaks"])
				{
					if(var_2F != "none" && var_2F != "")
					{
						var_2D = 0;
						break;
					}
				}

				if(var_2D)
				{
					var_2C = 0;
					var_0A = 1;
				}
			}

			if(var_2C)
			{
				var_06 = var_2B["loadoutKillstreaks"][0];
				var_07 = var_2B["loadoutKillstreaks"][1];
				var_08 = var_2B["loadoutKillstreaks"][2];
				var_09 = var_2B["loadoutKillstreaks"][3];
			}
		}
		else
		{
			var_06 = "none";
			var_07 = "none";
			var_08 = "none";
			var_09 = "none";
		}

		var_0C = var_2B["loadoutJuggernaut"];
	}
	else if(issubstr(var_11,"juggernaut_exosuit"))
	{
		if(var_11 == "juggernaut_exosuit_maniac")
		{
			var_17 = "iw5_mechpunch";
			var_18 = "none";
			var_1D = "iw5_mechpunch";
			var_23 = "exoknife_jug_mp";
		}
		else
		{
			var_17 = "iw5_exominigun";
			var_18 = "none";
			var_1D = "none";
			var_23 = "frag_grenade_mp";
		}

		var_1C = "none";
		var_1D = "none";
		var_1E = "none";
		var_1F = "none";
		var_13[0] = "specialty_class_fasthands";
		var_13[1] = "specialty_null";
		var_13[2] = "specialty_null";
		var_13[3] = "specialty_null";
		var_13[4] = "specialty_null";
		var_13[5] = "specialty_null";
		var_14[0] = "specialty_null";
		var_14[1] = "specialty_null";
		var_14[2] = "specialty_null";
		var_21 = "none";
		var_22 = "none";
		var_23 = "none";
		var_24 = "none";
		var_25 = "none";
		var_24 = 0;
		var_25 = "none";
		var_26 = 0;
	}
	else if(var_11 == "minion")
	{
		var_17 = "iw5_titan45_mp";
		var_18 = "none";
		var_1D = "none";
		var_23 = "none";
		var_1C = "none";
		var_1D = "none";
		var_1E = "none";
		var_1F = "none";
		var_13[0] = "specialty_null";
		var_13[1] = "specialty_null";
		var_13[2] = "specialty_null";
		var_13[3] = "specialty_null";
		var_13[4] = "specialty_null";
		var_13[5] = "specialty_null";
		var_14[0] = "specialty_null";
		var_14[1] = "specialty_null";
		var_14[2] = "specialty_null";
		var_21 = "none";
		var_22 = "none";
		var_23 = "none";
		var_24 = "none";
		var_25 = "none";
		var_24 = 0;
		var_25 = "none";
		var_26 = 0;
	}
	else if(var_11 == "callback")
	{
		var_23 = level.customclasspickcount;
		if(!isdefined(self.classcallback))
		{
			common_scripts\utility::error("self.classCallback function reference required for class \'callback\'");
		}

		var_31 = [[ self.classcallback ]]();
		if(!isdefined(var_31))
		{
			common_scripts\utility::error("array required from self.classCallback for class \'callback\'");
		}

		var_17 = var_31["loadoutPrimary"];
		var_18 = var_31["loadoutPrimaryAttachment"];
		var_19 = var_31["loadoutPrimaryAttachment2"];
		var_1A = var_31["loadoutPrimaryAttachment3"];
		var_1B = var_31["loadoutPrimaryCamo"];
		var_1C = var_31["loadoutPrimaryReticle"];
		for(var_27 = 0;var_27 < 6;var_27++)
		{
			var_10[var_27] = var_31["loadoutPerk" + var_27 + 1];
		}

		for(var_27 = 0;var_27 < 3;var_27++)
		{
			var_11[var_27] = var_31["loadoutWildcard" + var_27 + 1];
		}

		var_1D = var_31["loadoutSecondary"];
		var_1E = var_31["loadoutSecondaryAttachment"];
		var_1F = var_31["loadoutSecondaryAttachment2"];
		var_20 = var_31["loadoutSecondaryAttachment3"];
		var_21 = var_31["loadoutSecondaryCamo"];
		var_22 = var_31["loadoutSecondaryReticle"];
		var_23 = var_31["loadoutEquipment"];
		var_24 = var_31["loadoutEquipment2"] != "specialty_null";
		var_25 = var_31["loadoutOffhand"];
		var_26 = var_31["loadoutOffhand2"] != "specialty_null";
		var_06 = var_31["loadoutStreak1"];
		var_07 = var_31["loadoutStreak2"];
		var_08 = var_31["loadoutStreak3"];
		var_09 = var_31["loadoutStreak4"];
		var_32 = ["a","b","c"];
		for(var_27 = 0;var_27 < 4;var_27++)
		{
			var_12[var_27] = [];
			for(var_33 = 0;var_33 < 3;var_33++)
			{
				var_12[var_27][var_33] = var_31["loadoutStreakModule" + var_27 + 1 + var_32[var_33]];
			}
		}
	}
	else
	{
		var_16 = maps\mp\_utility::getclassindex(var_12);
		var_17 = table_getweapon(level.classtablename,var_16,0);
		var_18 = table_getweaponattachment(level.classtablename,var_15,0,0);
		var_19 = table_getweaponattachment(level.classtablename,var_14,0,1);
		var_1A = table_getweaponattachment(level.classtablename,var_13,0,2);
		var_1B = table_getweaponcamo(level.classtablename,var_12,0);
		var_1C = table_getweaponreticle(level.classtablename,var_11,0);
		for(var_27 = 0;var_27 < 6;var_27++)
		{
			var_10[var_27] = table_getperk(level.classtablename,var_05,var_27);
		}

		for(var_27 = 0;var_27 < 3;var_27++)
		{
			var_11[var_27] = table_getwildcard(level.classtablename,var_05,var_27);
		}

		var_1D = table_getweapon(level.classtablename,var_05,1);
		var_1E = table_getweaponattachment(level.classtablename,var_05,1,0);
		var_1F = table_getweaponattachment(level.classtablename,var_05,1,1);
		var_20 = table_getweaponattachment(level.classtablename,var_05,1,2);
		var_21 = table_getweaponcamo(level.classtablename,var_05,1);
		var_22 = table_getweaponreticle(level.classtablename,var_05,1);
		var_23 = table_getequipment(level.classtablename,var_05);
		var_24 = table_getequipmentextra(level.classtablename,var_05);
		var_25 = table_getoffhand(level.classtablename,var_05);
		var_26 = table_getoffhandextra(level.classtablename,var_05);
		var_06 = table_getkillstreak(level.classtablename,var_05,0);
		var_07 = table_getkillstreak(level.classtablename,var_05,1);
		var_08 = table_getkillstreak(level.classtablename,var_05,2);
		var_09 = table_getkillstreak(level.classtablename,var_05,3);
		if(!isdefined(var_06) || var_06 == "")
		{
			var_06 = "none";
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
	}

	var_34 = issubstr(param_01,"custom") || issubstr(param_01,"lobby");
	var_35 = issubstr(param_01,"recipe");
	var_36 = 0;
	if(level.killstreakrewards && !isdefined(var_06) && !isdefined(var_07) && !isdefined(var_08) && !isdefined(var_09))
	{
		if(!issubstr(param_01,"juggernaut") && param_01 != "minion")
		{
			var_05 = maps\mp\_utility::getclassindex(param_01);
			if(isdefined(self.class_num))
			{
				var_05 = self.class_num;
			}
		}
		else
		{
			var_05 = 0;
		}

		var_38 = undefined;
		var_39 = undefined;
		var_3A = undefined;
		var_3B = undefined;
		var_0B = "assaultStreaks";
		var_38 = table_getkillstreak(level.classtablename,var_05,0);
		var_39 = table_getkillstreak(level.classtablename,var_05,1);
		var_3A = table_getkillstreak(level.classtablename,var_05,2);
		var_3B = table_getkillstreak(level.classtablename,var_05,3);
		var_06 = undefined;
		var_07 = undefined;
		var_08 = undefined;
		var_09 = undefined;
		if(var_0D)
		{
			var_06 = self getcacplayerdata(self.class_num,var_0B,0,"streak");
			var_07 = self getcacplayerdata(self.class_num,var_0B,1,"streak");
			var_08 = self getcacplayerdata(self.class_num,var_0B,2,"streak");
			var_09 = self getcacplayerdata(self.class_num,var_0B,3,"streak");
		}

		if(issubstr(param_01,"juggernaut") || var_14)
		{
			foreach(var_2F in self.killstreaks)
			{
				if(!isdefined(var_06))
				{
					var_06 = var_2F;
					continue;
				}

				if(!isdefined(var_07))
				{
					var_07 = var_2F;
					continue;
				}

				if(!isdefined(var_08))
				{
					var_08 = var_2F;
					continue;
				}

				if(!isdefined(var_09))
				{
					var_09 = var_2F;
				}
			}
		}

		if(!issubstr(param_01,"custom") && !issubstr(param_01,"juggernaut") && !var_14 && param_01 != "minion")
		{
			var_06 = var_38;
			var_07 = var_39;
			var_08 = var_3A;
			var_09 = var_3B;
		}

		if(!isdefined(var_06) || var_06 == "")
		{
			var_06 = "none";
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

		if(!isvalidkillstreak(var_06) || var_34 && !self isitemunlocked(var_06))
		{
			var_06 = table_getkillstreak(level.classtablename,0,0);
		}

		if(!isvalidkillstreak(var_07) || var_34 && !self isitemunlocked(var_07))
		{
			var_07 = table_getkillstreak(level.classtablename,0,1);
		}

		if(!isvalidkillstreak(var_08) || var_34 && !self isitemunlocked(var_08))
		{
			var_08 = table_getkillstreak(level.classtablename,0,2);
		}

		if(!isvalidkillstreak(var_09) || var_34 && !self isitemunlocked(var_09))
		{
			var_09 = table_getkillstreak(level.classtablename,0,3);
		}
	}
	else if(!level.killstreakrewards)
	{
		var_06 = "none";
		var_07 = "none";
		var_08 = "none";
		var_09 = "none";
	}

	var_20 = "none";
	var_3E = tablelookup("mp/statstable.csv",4,var_17,40);
	var_3F = tablelookup("mp/statstable.csv",4,var_1D,40);
	var_40 = 0;
	if(var_17 != "iw5_combatknife")
	{
		var_40++;
	}

	if(var_18 != "none" && var_3E == "")
	{
		var_40++;
	}

	if(var_19 != "none")
	{
		var_40++;
	}

	if(var_1A != "none")
	{
		var_40++;
	}

	if(var_1D != "iw5_combatknife")
	{
		var_40++;
	}

	if(var_1E != "none" && var_3F == "")
	{
		var_40++;
	}

	if(var_1F != "none")
	{
		var_40++;
	}

	if(var_20 != "none")
	{
		var_40++;
	}

	if(var_23 != "specialty_null")
	{
		var_40++;
	}

	if(isdefined(var_24) && var_24)
	{
		var_40++;
	}

	if(var_25 != "specialty_null")
	{
		var_40++;
	}

	if(isdefined(var_26) && var_26)
	{
		var_40++;
	}

	for(var_27 = 0;var_27 < 6;var_27++)
	{
		if(var_10[var_27] != "specialty_null")
		{
			var_40++;
		}
	}

	for(var_27 = 0;var_27 < 3;var_27++)
	{
		if(var_11[var_27] != "specialty_null")
		{
			var_40++;
		}
	}

	if(var_06 != "none")
	{
		var_40++;
	}

	if(var_07 != "none")
	{
		var_40++;
	}

	if(var_08 != "none")
	{
		var_40++;
	}

	if(var_09 != "none")
	{
		var_40++;
	}

	if(var_40 > var_13)
	{
		for(;;)
		{
			if(var_09 != "none")
			{
				var_09 = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_08 != "none")
			{
				var_08 = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_07 != "none")
			{
				var_07 = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_06 != "none")
			{
				var_06 = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_10[5] != "specialty_null")
			{
				var_10[5] = "specialty_null";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_10[4] != "specialty_null")
			{
				var_10[4] = "specialty_null";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_10[3] != "specialty_null")
			{
				var_10[3] = "specialty_null";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_10[2] != "specialty_null")
			{
				var_10[2] = "specialty_null";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_10[1] != "specialty_null")
			{
				var_10[1] = "specialty_null";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_10[0] != "specialty_null")
			{
				var_10[0] = "specialty_null";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(isdefined(var_26) && var_26)
			{
				var_26 = 0;
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_25 != "specialty_null")
			{
				var_25 = "specialty_null";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(isdefined(var_24) && var_24)
			{
				var_24 = 0;
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_23 != "specialty_null")
			{
				var_23 = "specialty_null";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_20 != "none")
			{
				var_20 = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_1F != "none")
			{
				var_1F = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_1E != "none" && var_3F == "")
			{
				var_1E = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_1D != "iw5_combatknife")
			{
				var_1D = "iw5_combatknife";
				var_1E = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_1A != "none")
			{
				var_1A = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_19 != "none")
			{
				var_19 = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_18 != "none" && var_3E == "")
			{
				var_18 = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_17 != "iw5_combatknife")
			{
				var_17 = "iw5_combatknife";
				var_18 = "none";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_11[2] != "specialty_null")
			{
				var_11[2] = "specialty_null";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_11[1] != "specialty_null")
			{
				var_11[1] = "specialty_null";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			if(var_11[0] != "specialty_null")
			{
				var_11[0] = "specialty_null";
				var_40--;
				if(var_40 == var_13)
				{
					break;
				}
			}

			break;
		}
	}

	for(var_27 = 0;var_27 < 3;var_27++)
	{
		if(getdvarint("scr_game_perks") == 0)
		{
			var_11[var_27] = "specialty_null";
		}
	}

	var_41 = [];
	var_41["specialty_wildcard_perkslot1"] = 0;
	var_41["specialty_wildcard_perkslot2"] = 0;
	var_41["specialty_wildcard_perkslot3"] = 0;
	var_41["specialty_wildcard_primaryattachment"] = 0;
	var_41["specialty_wildcard_secondaryattachment"] = 0;
	var_41["specialty_wildcard_dualprimaries"] = 0;
	var_41["specialty_wildcard_dualtacticals"] = 0;
	var_41["specialty_wildcard_duallethals"] = 0;
	var_41["specialty_wildcard_extrastreak"] = 0;
	for(var_27 = 0;var_27 < 3;var_27++)
	{
		var_41[var_11[var_27]] = 1;
	}

	if(!var_41["specialty_wildcard_extrastreak"])
	{
		var_09 = "none";
	}

	if(!var_41["specialty_wildcard_perkslot1"])
	{
		var_10[1] = "specialty_null";
	}

	if(!var_41["specialty_wildcard_perkslot2"])
	{
		var_10[3] = "specialty_null";
	}

	if(!var_41["specialty_wildcard_perkslot3"])
	{
		var_10[5] = "specialty_null";
	}

	if(!var_41["specialty_wildcard_primaryattachment"])
	{
		var_1A = "none";
	}

	if(!var_41["specialty_wildcard_secondaryattachment"])
	{
		var_1F = "none";
	}

	if(!var_14 && !var_35 && !isdefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && param_02)
	{
		if(!isvalidprimary(var_17) || level.rankedmatch && var_34 && !self isitemunlocked(var_17) && !var_36)
		{
			var_17 = table_getweapon(level.classtablename,10,0);
			var_18 = "none";
			var_19 = "none";
			var_1A = "none";
		}

		if(var_3E != "")
		{
			var_18 = var_3E;
		}
		else if(!isvalidattachment(var_18,var_17) || level.rankedmatch && var_34 && !isattachmentunlocked(var_17,var_18) && !var_36)
		{
			var_18 = table_getweaponattachment(level.classtablename,10,0,0);
		}

		if(!isvalidattachment(var_19,var_17) || level.rankedmatch && var_34 && !isattachmentunlocked(var_17,var_19) && !var_36)
		{
			var_19 = table_getweaponattachment(level.classtablename,10,0,1);
		}

		if(!isvalidattachment(var_1A,var_17) || level.rankedmatch && var_34 && !isattachmentunlocked(var_17,var_1A) && !var_36)
		{
			var_1A = table_getweaponattachment(level.classtablename,10,0,2);
		}

		var_42 = [];
		var_42[var_42.size] = var_18;
		var_42[var_42.size] = var_19;
		var_42[var_42.size] = var_1A;
		for(var_43 = 0;var_43 < var_42.size;var_43++)
		{
			if(var_42[var_43] == "none")
			{
				continue;
			}

			for(var_44 = var_43 + 1;var_44 < var_42.size;var_44++)
			{
				if(var_42[var_44] == "none")
				{
					continue;
				}

				if(var_42[var_43] == var_42[var_44])
				{
					recordvalidationinfraction();
					var_42[var_44] = "none";
					if(var_44 == 1)
					{
						var_19 = "none";
						continue;
					}

					if(var_44 == 2)
					{
						var_1A = "none";
						continue;
					}
				}
			}
		}

		if(!isvalidcamo(var_1B) || level.rankedmatch && var_34 && !iscamounlocked(var_17,var_1B) && !var_36)
		{
			var_1B = table_getweaponcamo(level.classtablename,10,0);
		}

		if(!isvalidreticle(var_1C))
		{
			var_1C = table_getweaponreticle(level.classtablenum,10,0);
		}

		if(!isvalidsecondary(var_1D,var_41["specialty_wildcard_dualprimaries"]) || level.rankedmatch && var_34 && !self isitemunlocked(var_1D) && !var_36)
		{
			var_1D = table_getweapon(level.classtablename,10,1);
			var_1E = "none";
			var_1F = "none";
			var_21 = "none";
			var_22 = "none";
		}

		if(var_3F != "")
		{
			var_1E = var_3F;
		}
		else if(!isvalidattachment(var_1E,var_1D) || level.rankedmatch && var_34 && !isattachmentunlocked(var_1D,var_1E) && !var_36)
		{
			var_1E = table_getweaponattachment(level.classtablename,10,1,0);
		}

		if(!isvalidattachment(var_1F,var_1D) || level.rankedmatch && var_34 && !isattachmentunlocked(var_1D,var_1F) && !var_36)
		{
			var_1F = table_getweaponattachment(level.classtablename,10,1,1);
		}

		if(var_1E != "none")
		{
			if(var_1E == var_1F)
			{
				recordvalidationinfraction();
				var_1F = "none";
			}
		}

		if(!isvalidcamo(var_21) || level.rankedmatch && var_34 && !iscamounlocked(var_1D,var_21) && !var_36)
		{
			var_21 = table_getweaponcamo(level.classtablename,10,1);
		}

		if(!isvalidreticle(var_22))
		{
			var_22 = table_getweaponreticle(level.classtablename,10,1);
		}

		if(!isvalidequipment(var_23,var_41["specialty_wildcard_dualtacticals"]) || level.rankedmatch && var_34 && !self isitemunlocked(var_23) && !var_36)
		{
			var_23 = table_getequipment(level.classtablename,10);
		}

		if(var_23 == var_25)
		{
			var_23 = "specialty_null";
		}

		if(!isvalidoffhand(var_25,var_41["specialty_wildcard_duallethals"]))
		{
			var_25 = table_getoffhand(level.classtablename,10);
		}
	}

	if(var_41["specialty_wildcard_duallethals"] && var_25 != "specialty_null")
	{
		var_25 = var_25 + "_lefthand";
	}

	for(var_27 = 0;var_27 < 6;var_27++)
	{
		if(var_10[var_27] == "specialty_null")
		{
			continue;
		}

		var_45 = var_10[var_27];
		var_10[var_27] = maps\mp\perks\_perks::validateperk(var_27,var_10[var_27]);
		if(var_45 != var_10[var_27])
		{
			recordvalidationinfraction();
		}
	}

	var_2A = spawnstruct();
	var_2A.class = param_01;
	var_2A.class_num = var_05;
	var_2A.teamname = var_15;
	var_2A.clearammo = var_04;
	var_2A.copycatloadout = var_0F;
	var_2A.cacloadout = var_0D;
	var_2A.practiceloadout = var_0E;
	var_2A.isgamemodeclass = var_14;
	var_2A.primary = var_17;
	var_2A.primaryattachment = var_18;
	var_2A.primaryattachment2 = var_19;
	var_2A.primaryattachment3 = var_1A;
	var_2A.primarycamo = var_1B;
	var_2A.primaryreticle = var_1C;
	var_1B = int(tablelookup("mp/camoTable.csv",1,var_2A.primarycamo,0));
	var_1C = int(tablelookup("mp/reticleTable.csv",1,var_2A.primaryreticle,0));
	var_2A.primaryname = buildweaponname(var_2A.primary,var_2A.primaryattachment,var_2A.primaryattachment2,var_2A.primaryattachment3,var_1B,var_1C);
	var_2A.secondary = var_1D;
	var_2A.secondaryattachment = var_1E;
	var_2A.secondaryattachment2 = var_1F;
	var_2A.secondaryattachment3 = "none";
	var_2A.secondarycamo = var_21;
	var_2A.secondaryreticle = var_22;
	var_21 = int(tablelookup("mp/camoTable.csv",1,var_2A.secondarycamo,0));
	var_22 = int(tablelookup("mp/reticleTable.csv",1,var_2A.secondaryreticle,0));
	var_2A.secondaryname = buildweaponname(var_2A.secondary,var_2A.secondaryattachment,var_2A.secondaryattachment2,var_2A.secondaryattachment3,var_21,var_22);
	var_2A.equipment = var_23;
	var_2A.equipmentextra = var_24;
	var_2A.offhand = var_25;
	var_2A.offhandextra = var_26;
	var_2A.perks = var_10;
	var_2A.killstreak1 = var_06;
	var_2A.killstreak2 = var_07;
	var_2A.killstreak3 = var_08;
	var_2A.killstreak4 = var_09;
	var_2A.loadoutkillstreakmodules = var_12;
	var_2A.keepcurrentkillstreaks = var_0A;
	var_2A.wildcards = var_11;
	var_2A.wildcardsowned = var_41;
	var_2A.juggernaut = var_0C;
	var_2A.setprimaryspawnweapon = param_03;
	return var_2A;
}

//Function Number: 46
giveloadout(param_00,param_01,param_02,param_03)
{
	self.loadout = getloadout(param_00,param_01,param_02,param_03);
}

//Function Number: 47
applyloadout()
{
	var_00 = self.loadout;
	if(!isdefined(self.loadout))
	{
		return;
	}

	self.loadout = undefined;
	self.spectatorviewloadout = var_00;
	self takeallweapons();
	maps\mp\_utility::_clearperks();
	_detachall();
	self.changingweapon = undefined;
	if(var_00.copycatloadout)
	{
		setclass("copycat");
	}

	self.class_num = var_00.class_num;
	self.loadoutwildcards = var_00.wildcards;
	self.loadoutprimary = var_00.primary;
	self.loadoutprimarycamo = int(tablelookup("mp/camoTable.csv",1,var_00.primarycamo,0));
	self.loadoutsecondary = var_00.secondary;
	self.loadoutsecondarycamo = int(tablelookup("mp/camoTable.csv",1,var_00.secondarycamo,0));
	if(!issubstr(var_00.primary,"iw5"))
	{
		self.loadoutprimarycamo = 0;
	}

	if(!issubstr(var_00.secondary,"iw5"))
	{
		self.loadoutsecondarycamo = 0;
	}

	self.loadoutprimaryreticle = int(tablelookup("mp/reticleTable.csv",1,var_00.primaryreticle,0));
	self.loadoutsecondaryreticle = int(tablelookup("mp/reticleTable.csv",1,var_00.secondaryreticle,0));
	if(!issubstr(var_00.primary,"iw5"))
	{
		self.loadoutprimaryreticle = 0;
	}

	if(!issubstr(var_00.secondary,"iw5"))
	{
		self.loadoutsecondaryreticle = 0;
	}

	if(isdefined(var_00.juggernaut) && var_00.juggernaut)
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
		self.movespeedscaler = level.baseplayermovescale;
	}

	var_01 = var_00.secondaryname;
	if(var_01 != "none")
	{
		maps\mp\_utility::_giveweapon(var_01);
	}

	if(var_00.wildcardsowned["specialty_wildcard_dualtacticals"])
	{
		maps\mp\_utility::giveperk("specialty_wildcard_dualtacticals",0);
	}

	if(var_00.wildcardsowned["specialty_wildcard_duallethals"] && !maps\mp\_utility::isgrapplinghookgamemode())
	{
		maps\mp\_utility::giveperk("specialty_wildcard_duallethals",0);
	}

	if(level.diehardmode)
	{
		maps\mp\_utility::giveperk("specialty_pistoldeath",0);
	}

	loadoutallperks(var_00.equipment,var_00.perks);
	maps\mp\perks\_perks::applyperks();
	givedefaultperks();
	self setlethalweapon(var_00.equipment);
	if(var_00.equipment != "specialty_null" && self hasweapon(var_00.equipment))
	{
		var_02 = self getweaponammoclip(var_00.equipment);
		self setweaponammoclip(var_00.equipment,var_02 + 1);
	}
	else
	{
		giveoffhand(var_00.equipment);
	}

	if(isdefined(var_00.equipmentextra) && var_00.equipmentextra)
	{
		maps\mp\_utility::giveperk("specialty_extralethal",0);
		var_02 = self getweaponammoclip(var_00.equipment);
		self setweaponammoclip(var_00.equipment,var_02 + 1);
	}

	var_03 = var_00.primaryname;
	maps\mp\_utility::_giveweapon(var_03);
	if(!isai(self))
	{
		self switchtoweapon(var_03);
	}

	if(var_03 == "riotshield_mp" && level.ingraceperiod)
	{
		self notify("weapon_change","riotshield_mp");
	}

	if(var_00.setprimaryspawnweapon)
	{
		self setspawnweapon(maps\mp\_utility::get_spawn_weapon_name(var_00));
	}

	self.pers["primaryWeapon"] = maps\mp\_utility::getbaseweaponname(var_03);
	self.loadoutoffhand = var_00.offhand;
	self settacticalweapon(var_00.offhand);
	giveoffhand(var_00.offhand);
	if(isdefined(var_00.offhandextra) && var_00.offhandextra)
	{
		maps\mp\_utility::giveperk("specialty_extratactical",0);
		var_02 = self getweaponammoclip(var_00.offhand);
		self setweaponammoclip(var_00.offhand,var_02 + 1);
	}

	thread loadouttrackvariablegrenades(var_00.class,var_00.equipment,var_00.offhand);
	var_04 = var_03;
	self.primaryweapon = var_04;
	self.secondaryweapon = var_01;
	if(var_00.clearammo)
	{
		self setweaponammoclip(self.primaryweapon,0);
		self setweaponammostock(self.primaryweapon,0);
	}

	self.issniper = weaponclass(self.primaryweapon) == "sniper";
	maps\mp\_utility::_setactionslot(1,"");
	maps\mp\_utility::_setactionslot(3,"altMode");
	maps\mp\_utility::_setactionslot(4,"");
	if(!level.console)
	{
		maps\mp\_utility::_setactionslot(5,"");
		maps\mp\_utility::_setactionslot(6,"");
		maps\mp\_utility::_setactionslot(7,"");
		maps\mp\_utility::_setactionslot(8,"");
	}

	if(maps\mp\_utility::_hasperk("specialty_extraammo"))
	{
		var_05 = self setweaponammostock(var_03);
		self setweaponammostock(var_03,var_05 * 2);
		if(var_01 != "none" && maps\mp\_utility::getweaponclass(var_01) != "weapon_projectile")
		{
			var_05 = self setweaponammostock(var_01);
			self setweaponammostock(var_01,var_05 * 2);
		}
	}

	if(!maps\mp\_utility::invirtuallobby())
	{
		if(!issubstr(var_00.class,"juggernaut"))
		{
			setkillstreaks(var_00.killstreak1,var_00.killstreak2,var_00.killstreak3,var_00.killstreak4,var_00.cacloadout,var_00.practiceloadout,var_00.copycatloadout,var_00.isgamemodeclass,var_00.teamname,var_00.loadoutkillstreakmodules);
		}

		var_06 = 1;
		if(var_00.keepcurrentkillstreaks)
		{
			var_06 = 0;
		}
		else if(isagent(self))
		{
			var_06 = 0;
		}
		else if(!isdefined(self.lastclass))
		{
			var_06 = 0;
		}
		else if(!isbot(self) && self.lastclass == self.class && !isdefined(self.gamemode_carrierclass) && self.gamemode_carrierclass)
		{
			var_06 = 0;
		}
		else if(isbot(self) && self.bot_last_loadout_num == self.bot_cur_loadout_num)
		{
			var_06 = 0;
		}
		else if(issubstr(self.class,"juggernaut") || issubstr(self.lastclass,"juggernaut") || issubstr(var_00.class,"juggernaut"))
		{
			var_06 = 0;
		}

		var_00.keepcurrentkillstreaks = !var_06;
		if(var_06)
		{
			if(maps\mp\_utility::wasonlyround() || self.lastclass != "")
			{
				var_07 = [];
				var_08 = [];
				var_09 = 0;
				var_0A = self.pers["killstreaks"];
				if(var_0A.size > level.killstreak_stacking_start_slot)
				{
					for(var_0B = level.killstreak_stacking_start_slot;var_0B < var_0A.size;var_0B++)
					{
						var_07[var_09] = var_0A[var_0B].streakname;
						var_08[var_09] = var_0A[var_0B].modules;
						var_09++;
					}
				}

				if(var_0A.size)
				{
					for(var_0B = level.killstreak_slot_1;var_0B < level.killstreak_stacking_start_slot;var_0B++)
					{
						if(isdefined(var_0A[var_0B]) && isdefined(var_0A[var_0B].streakname) && var_0A[var_0B].available)
						{
							var_07[var_09] = var_0A[var_0B].streakname;
							var_08[var_09] = var_0A[var_0B].modules;
							var_09++;
						}
					}
				}

				self notify("givingLoadout");
				maps\mp\killstreaks\_killstreaks::clearkillstreaks(1);
				for(var_0B = 0;var_0B < var_07.size;var_0B++)
				{
					maps\mp\killstreaks\_killstreaks::givekillstreak(var_07[var_0B],undefined,undefined,undefined,var_08[var_0B]);
				}
			}
		}

		self.loadoutkeepcurrentkillstreaks = var_00.keepcurrentkillstreaks;
	}

	if(!issubstr(var_00.class,"juggernaut"))
	{
		if(isdefined(self.lastclass) && self.lastclass != "" && self.lastclass != self.class)
		{
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
		if(!isdefined(self.gamemode_carrierclass) || var_00.keepcurrentkillstreaks)
		{
			self.lastclass = self.gamemode_chosenclass;
		}

		self.gamemode_chosenclass = undefined;
	}

	self.gamemode_carrierclass = undefined;
	if(!isdefined(level.iszombiegame) || !level.iszombiegame)
	{
		if(!isdefined(self.costume))
		{
			if(maps\mp\_utility::practiceroundgame())
			{
				self.costume = maps\mp\gametypes\_teams::getpracticeroundcostume();
			}
			else if(isplayer(self))
			{
				self.costume = cao_getactivecostume();
				checkforcostumeset();
			}
			else if(isagent(self) && self.agent_type == "player")
			{
				self.costume = maps\mp\gametypes\_teams::getdefaultcostume();
			}
		}

		if(!maps\mp\gametypes\_teams::validcostume(self.costume))
		{
			if(isdefined(self.sessioncostume) && maps\mp\gametypes\_teams::validcostume(self.sessioncostume))
			{
				self.costume = self.sessioncostume;
			}
			else
			{
				self.costume = maps\mp\gametypes\_teams::getdefaultcostume();
				if(isplayer(self))
				{
					cao_setactivecostume(self.costume);
				}

				self.sessioncostume = self.costume;
			}
		}

		logplayercostume();
		maps\mp\gametypes\_teams::playermodelforweapon(self.pers["primaryWeapon"],maps\mp\_utility::getbaseweaponname(var_01));
	}

	maps\mp\gametypes\_weapons::updatemovespeedscale();
	maps\mp\perks\_perks::cac_selector();
	self notify("changed_kit");
	self notify("applyLoadout");
}

//Function Number: 48
logplayercostume()
{
	if(isagent(self))
	{
		return;
	}

	if(!isdefined(self.costumelogged))
	{
		var_00 = cao_getglobalcostumecategory("gender");
		var_01 = cao_getglobalcostumecategory("head");
		var_02 = cao_getactivecostumeindex();
		var_03 = cao_getpercostumecategory("shirt",var_02);
		var_04 = cao_getpercostumecategory("pants",var_02);
		var_05 = cao_getpercostumecategory("eyewear",var_02);
		var_06 = cao_getpercostumecategory("hat",var_02);
		var_07 = cao_getpercostumecategory("kneepads",var_02);
		var_08 = cao_getpercostumecategory("gloves",var_02);
		var_09 = cao_getpercostumecategory("shoes",var_02);
		var_0A = cao_getpercostumecategory("gear",var_02);
		var_0B = cao_getpercostumecategory("exo",var_02);
		setmatchdata("players",self.clientid,"costume","gender",var_00);
		setmatchdata("players",self.clientid,"costume","head",var_01);
		setmatchdata("players",self.clientid,"costume","shirt",var_03);
		setmatchdata("players",self.clientid,"costume","pants",var_04);
		setmatchdata("players",self.clientid,"costume","eyewear",var_05);
		setmatchdata("players",self.clientid,"costume","hat",var_06);
		setmatchdata("players",self.clientid,"costume","kneepads",var_07);
		setmatchdata("players",self.clientid,"costume","gloves",var_08);
		setmatchdata("players",self.clientid,"costume","shoes",var_09);
		setmatchdata("players",self.clientid,"costume","gear",var_0A);
		setmatchdata("players",self.clientid,"costume","exo",var_0B);
		self.costumelogged = 1;
	}
}

//Function Number: 49
giveandapplyloadout(param_00,param_01,param_02,param_03)
{
	giveloadout(param_00,param_01,param_02,param_03);
	applyloadout();
}

//Function Number: 50
givedefaultperks()
{
	self.spawnperk = 0;
	if(!maps\mp\_utility::_hasperk("specialty_blindeye") && self.avoidkillstreakonspawntimer > 0)
	{
		thread maps\mp\perks\_perks::giveblindeyeafterspawn();
	}

	if((!isdefined(level.ishorde) || !level.ishorde) && !level.iszombiegame)
	{
		maps\mp\_utility::giveperk("specialty_marathon",0);
	}

	maps\mp\_utility::giveperk("specialty_falldamage",0);
}

//Function Number: 51
recordvalidationinfraction()
{
	if(isdefined(self) && isdefined(self.pers) && isdefined(self.pers["validationInfractions"]))
	{
		self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
	}
}

//Function Number: 52
_detachall()
{
	self.frontshieldmodel = undefined;
	self.backshieldmodel = undefined;
	self.headmodel = undefined;
	self detachall();
}

//Function Number: 53
giveoffhand(param_00)
{
	var_01 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	switch(var_01)
	{
		case "specialty_null":
		case "none":
			break;

		case "explosive_gel_mp":
		case "exoknife_mp":
		case "throwingknife_mp":
		case "tri_drone_mp":
		case "c4_mp":
		case "bouncingbetty_mp":
		case "semtex_mp":
		case "trophy_mp":
		case "exoknife_jug_mp":
		case "frag_grenade_mp":
		case "claymore_mp":
			break;

		case "smoke_grenade_var_mp":
		case "paint_grenade_var_mp":
		case "emp_grenade_var_mp":
		case "stun_grenade_var_mp":
		case "mute_bomb_mp":
		case "fast_heal_mp":
		case "explosive_drone_mp":
		case "tracking_drone_mp":
		case "smoke_grenade_mp":
		case "emp_grenade_mp":
		case "paint_grenade_mp":
		case "stun_grenade_mp":
		case "concussion_grenade_mp":
		case "flash_grenade_mp":
		case "scrambler_mp":
		case "s1_tactical_insertion_device_mp":
		case "portable_radar_mp":
			break;

		case "exoshield_equipment_mp":
			break;

		case "adrenaline_mp":
			break;

		case "extra_health_mp":
			break;

		case "exorepulsor_equipment_mp":
			break;

		case "exocloak_equipment_mp":
			break;

		case "exoping_equipment_mp":
			break;

		case "exohover_equipment_mp":
			break;

		case "exomute_equipment_mp":
			break;

		case "iw5_dlcgun12loot7_mp":
			break;

		default:
			break;
	}
}

//Function Number: 54
takeoffhand(param_00)
{
	var_01 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	switch(var_01)
	{
		case "specialty_null":
		case "none":
			break;

		case "s1_tactical_insertion_device_mp":
		case "explosive_gel_mp":
		case "exoknife_mp":
		case "throwingknife_mp":
		case "tri_drone_mp":
		case "c4_mp":
		case "bouncingbetty_mp":
		case "semtex_mp":
		case "trophy_mp":
		case "exoknife_jug_mp":
		case "frag_grenade_mp":
		case "claymore_mp":
			break;

		case "smoke_grenade_var_mp":
		case "paint_grenade_var_mp":
		case "emp_grenade_var_mp":
		case "stun_grenade_var_mp":
		case "mute_bomb_mp":
		case "fast_heal_mp":
		case "explosive_drone_mp":
		case "tracking_drone_mp":
		case "smoke_grenade_mp":
		case "emp_grenade_mp":
		case "paint_grenade_mp":
		case "stun_grenade_mp":
		case "concussion_grenade_mp":
		case "flash_grenade_mp":
		case "scrambler_mp":
		case "portable_radar_mp":
			break;

		case "exoshield_equipment_mp":
			break;

		case "adrenaline_mp":
			break;

		case "extra_health_mp":
			break;

		case "exorepulsor_equipment_mp":
			break;

		case "exocloak_equipment_mp":
			break;

		case "exoping_equipment_mp":
			break;

		case "exohover_equipment_mp":
			break;

		case "exomute_equipment_mp":
			break;

		case "iw5_dlcgun12loot7_mp":
			break;

		default:
			break;
	}
}

//Function Number: 55
loadoutallperks(param_00,param_01)
{
	for(var_02 = 0;var_02 < 6;var_02++)
	{
		param_01[var_02] = maps\mp\perks\_perks::validateperk(var_02,param_01[var_02]);
	}

	for(var_02 = 0;var_02 < 6;var_02++)
	{
		if(param_01[var_02] != "specialty_null")
		{
			maps\mp\_utility::giveperk(param_01[var_02],1,var_02);
		}
	}

	self.loadoutperks = param_01;
	self.loadoutequipment = param_00;
}

//Function Number: 56
loadouttrackvariablegrenades(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self notify("loadoutTrackVariableGrenades");
	self endon("loadoutTrackVariableGrenades");
	switch(param_01)
	{
		case "contact_grenade_var_mp":
		case "semtex_grenade_var_mp":
		case "frag_grenade_var_mp":
		case "smoke_grenade_var_mp":
		case "paint_grenade_var_mp":
		case "emp_grenade_var_mp":
		case "stun_grenade_var_mp":
			break;

		default:
			break;
	}
}

//Function Number: 57
isexoxmg(param_00)
{
	if(issubstr(param_00,"_exoxmg"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 58
issac3(param_00)
{
	if(issubstr(param_00,"sac3"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 59
ismahem(param_00)
{
	if(issubstr(param_00,"mahem"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 60
isdlcgun2(param_00)
{
	if(param_00 == "iw5_dlcgun2" || param_00 == "iw5_dlcgun2zm" || issubstr(param_00,"iw5_dlcgun2loot"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 61
isdlcgun3(param_00)
{
	if(issubstr(param_00,"dlcgun3"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 62
needsscopeoverride(param_00,param_01)
{
	var_02 = maps\mp\_utility::getweaponclass(param_00) == "weapon_sniper";
	if(var_02 && !anyattachmentisscope(param_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 63
anyattachmentisscope(param_00)
{
	foreach(var_02 in param_00)
	{
		if(maps\mp\_utility::getattachmenttype(var_02) == "rail" || var_02 == "zoomscope" || var_02 == "ironsights")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 64
addautomaticattachments(param_00,param_01)
{
	var_02 = [];
	var_03 = undefined;
	var_04 = maps\mp\_utility::getbaseweaponname(param_00);
	if(var_04 == "iw5_dlcgun9loot0")
	{
		var_04 = "iw5_mors";
	}
	else if(var_04 == "iw5_dlcgun10")
	{
		var_04 = "iw5_gm6";
	}
	else if(var_04 == "iw5_dlcgun10loot0")
	{
		var_04 = "iw5_m990";
	}
	else if(var_04 == "iw5_dlcgun10loot1")
	{
		var_04 = "iw5_thor";
	}
	else if(var_04 == "iw5_dlcgun11loot2")
	{
		var_04 = "iw5_stingerm7";
	}
	else if(var_04 == "iw5_dlcgun11loot3")
	{
		var_04 = "iw5_maaws";
	}
	else if(var_04 == "iw5_dlcgun11loot4")
	{
		var_04 = "iw5_mahem";
	}
	else if(var_04 == "iw5_dlcgun10loot5")
	{
		var_04 = "iw5_exoxmg";
	}
	else if(var_04 == "iw5_dlcgun10loot3")
	{
		var_04 = "iw5_dlcgun2";
	}

	if(var_04 == "iw5_dlcgun6loot5" || var_04 == "iw5_dlcgun6loot6" || var_04 == "iw5_dlcgun6loot7" || var_04 == "iw5_dlcgun6loot8" || var_04 == "iw5_dlcgun6loot9" || var_04 == "iw5_dlcgun7")
	{
		var_03 = 1;
	}

	if(isdefined(var_03) && var_03)
	{
		if(!anyattachmentisscope(param_01))
		{
			var_02[var_02.size] = "dragunovdlcscope";
		}
	}
	else if(needsscopeoverride(var_04,param_01))
	{
		var_05 = var_04;
		if(issubstr(var_04,"iw5_") || issubstr(var_04,"iw6_"))
		{
			var_06 = var_04.size;
			var_05 = getsubstr(var_04,4,var_06);
		}

		var_07 = getbasefromlootversion(var_05) + "scope";
		var_02[var_02.size] = var_07;
	}

	if(isexoxmg(var_04))
	{
		var_02[var_02.size] = "akimboxmg";
	}

	if(issac3(var_04))
	{
		var_02[var_02.size] = "akimbosac3";
	}

	if(ismahem(var_04))
	{
		var_02[var_02.size] = "mahemscopebase";
	}

	if(isdlcgun2(var_04))
	{
		if(isdefined(level.iszombiegame) && level.iszombiegame)
		{
			var_02[var_02.size] = "sensorheartbeatzm";
		}
		else
		{
			var_02[var_02.size] = "sensorheartbeat";
		}
	}

	if(isdlcgun3(var_04))
	{
		if(isdefined(level.iszombiegame) && level.iszombiegame)
		{
			var_02[var_02.size] = "akimbo";
		}
	}

	return var_02;
}

//Function Number: 65
processattachments(param_00,param_01)
{
	var_02 = param_00.size;
	if(var_02 > 1)
	{
		param_00 = common_scripts\utility::alphabetize(param_00);
	}

	var_03 = addautomaticattachments(param_01,param_00);
	param_00 = common_scripts\utility::array_combine(param_00,var_03);
	return param_00;
}

//Function Number: 66
array_checkaddattachment(param_00,param_01)
{
	if(isdefined(param_01) && param_01 != "none")
	{
		param_00[param_00.size] = param_01;
	}

	return param_00;
}

//Function Number: 67
getbasefromlootversion(param_00)
{
	var_01 = 0;
	var_02 = [];
	var_02[0] = "loot";
	var_02[1] = "gold";
	var_02[2] = "atlas";
	var_02[3] = "blops2";
	var_02[4] = "ghosts";
	foreach(var_04 in var_02)
	{
		for(var_05 = 0;var_05 < param_00.size;var_05++)
		{
			if(tolower(param_00[var_05]) != tolower(var_04[var_01]))
			{
				var_05 = var_05 - var_01;
				var_01 = 0;
				continue;
			}

			var_01++;
			if(var_01 == var_04.size)
			{
				break;
			}
		}

		if(var_01 == var_04.size)
		{
			param_00 = getsubstr(param_00,0,var_05 - var_01 + 1);
			break;
		}
		else
		{
			var_01 = 0;
		}
	}

	return param_00;
}

//Function Number: 68
buildweaponname(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return param_00;
	}

	if(!isdefined(level.lettertonumber))
	{
		level.lettertonumber = makeletterstonumbers();
	}

	if(isdefined(param_05) && param_05 != 0 && maps\mp\_utility::getattachmenttype(param_01) != "rail" && maps\mp\_utility::getattachmenttype(param_02) != "rail" && maps\mp\_utility::getattachmenttype(param_03) != "rail")
	{
		param_05 = undefined;
	}

	param_01 = maps\mp\_utility::attachmentmap_tounique(param_01,param_00);
	param_02 = maps\mp\_utility::attachmentmap_tounique(param_02,param_00);
	param_03 = maps\mp\_utility::attachmentmap_tounique(param_03,param_00);
	var_06 = "";
	if(issubstr(param_00,"iw5_"))
	{
		var_07 = param_00 + "_mp";
		var_08 = param_00.size;
		var_06 = getsubstr(param_00,4,var_08);
	}
	else
	{
		var_07 = param_01;
		var_06 = param_00;
	}

	var_09 = [];
	var_09 = array_checkaddattachment(var_09,param_01);
	var_09 = array_checkaddattachment(var_09,param_02);
	var_09 = array_checkaddattachment(var_09,param_03);
	var_09 = processattachments(var_09,param_00);
	if(isdefined(var_09[0]) && var_09[0] == "vzscope")
	{
		var_09[0] = var_06 + "scopevz";
	}
	else if(isdefined(var_09[1]) && var_09[1] == "vzscope")
	{
		var_09[1] = var_06 + "scopevz";
	}
	else if(isdefined(var_09[2]) && var_09[2] == "vzscope")
	{
		var_09[2] = var_06 + "scopevz";
	}

	if(isdefined(var_09.size) && var_09.size)
	{
		for(var_0A = 0;var_0A < var_09.size;var_0A++)
		{
			if(isdefined(var_09[var_0A + 1]) && common_scripts\utility::is_later_in_alphabet(var_09[var_0A],var_09[var_0A + 1]))
			{
				var_0B = var_09[var_0A];
				var_09[var_0A] = var_09[var_0A + 1];
				var_09[var_0A + 1] = var_0B;
				var_0A = 0;
				continue;
			}
		}
	}

	foreach(var_0D in var_09)
	{
		var_07 = var_07 + "_" + var_0D;
	}

	if(issubstr(var_07,"iw5_"))
	{
		var_07 = buildweaponnamecamo(var_07,param_04);
		var_07 = buildweaponnamereticle(var_07,param_05);
		return var_07;
	}

	if(!isvalidweapon(var_07 + "_mp"))
	{
		return param_00 + "_mp";
	}

	var_07 = buildweaponnamecamo(var_07,param_04);
	var_07 = buildweaponnamereticle(var_07,param_05);
	return var_07 + "_mp";
}

//Function Number: 69
buildweaponnamecamo(param_00,param_01)
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

//Function Number: 70
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

//Function Number: 71
makeletterstonumbers()
{
	var_00 = [];
	var_00["a"] = 0;
	var_00["b"] = 1;
	var_00["c"] = 2;
	var_00["d"] = 3;
	var_00["e"] = 4;
	var_00["f"] = 5;
	var_00["g"] = 6;
	var_00["h"] = 7;
	var_00["i"] = 8;
	var_00["j"] = 9;
	var_00["k"] = 10;
	var_00["l"] = 11;
	var_00["m"] = 12;
	var_00["n"] = 13;
	var_00["o"] = 14;
	var_00["p"] = 15;
	var_00["q"] = 16;
	var_00["r"] = 17;
	var_00["s"] = 18;
	var_00["t"] = 19;
	var_00["u"] = 20;
	var_00["v"] = 21;
	var_00["w"] = 22;
	var_00["x"] = 23;
	var_00["y"] = 24;
	var_00["z"] = 25;
	return var_00;
}

//Function Number: 72
setkillstreaks(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self.killstreaks = [];
	self.killstreakmodules = [];
	var_0A = [];
	var_0B = [param_00,param_01,param_02,param_03];
	var_0C = 0;
	foreach(var_0E in var_0B)
	{
		if(isdefined(var_0E) && var_0E != "none")
		{
			var_0F = 3;
			if(param_06)
			{
				for(var_10 = 0;var_10 < var_0F;var_10++)
				{
					var_11 = self.pers["copyCatLoadout"]["loadoutKillstreakModules"][var_0C][var_10];
					if(isdefined(var_11) && var_11 != "none")
					{
						var_12 = maps\mp\killstreaks\_killstreaks::getstreakmodulecost(var_11);
						self.killstreakmodules[var_11] = var_12;
					}
				}
			}
			else if(isdefined(param_08) && param_08 != "none")
			{
				for(var_10 = 0;var_10 < var_0F;var_10++)
				{
					var_11 = getmatchrulesdata("defaultClasses",param_08,self.class_num,"class","assaultStreaks",var_0C,"modules",var_10);
					if(isdefined(var_11) && var_11 != "none")
					{
						var_12 = maps\mp\killstreaks\_killstreaks::getstreakmodulecost(var_11);
						self.killstreakmodules[var_11] = var_12;
					}
				}
			}
			else if(param_04)
			{
				for(var_10 = 0;var_10 < var_0F;var_10++)
				{
					var_11 = self getcacplayerdata(self.class_num,"assaultStreaks",var_0C,"modules",var_10);
					if(isdefined(var_11) && var_11 != "none")
					{
						var_12 = maps\mp\killstreaks\_killstreaks::getstreakmodulecost(var_11);
						self.killstreakmodules[var_11] = var_12;
					}
				}
			}
			else if(param_05)
			{
				for(var_10 = 0;var_10 < var_0F;var_10++)
				{
					var_11 = table_getkillstreakmodule(level.practiceroundclasstablename,self.class_num,var_0C,var_10);
					if(isdefined(var_11) && var_11 != "none")
					{
						var_12 = maps\mp\killstreaks\_killstreaks::getstreakmodulecost(var_11);
						self.killstreakmodules[var_11] = var_12;
					}
				}
			}
			else if(isdefined(param_09))
			{
				for(var_10 = 0;var_10 < var_0F;var_10++)
				{
					var_11 = param_09[var_0C][var_10];
					if(isdefined(var_11) && var_11 != "none")
					{
						var_12 = maps\mp\killstreaks\_killstreaks::getstreakmodulecost(var_11);
						self.killstreakmodules[var_11] = var_12;
					}
				}
			}
			else if(isdefined(self.class_num))
			{
				for(var_10 = 0;var_10 < var_0F;var_10++)
				{
					var_11 = table_getkillstreakmodule(level.classtablename,self.class_num,var_0C,var_10);
					if(isdefined(var_11) && var_11 != "none")
					{
						var_12 = maps\mp\killstreaks\_killstreaks::getstreakmodulecost(var_11);
						self.killstreakmodules[var_11] = var_12;
					}
				}
			}
			else if(isdefined(param_07))
			{
				var_13 = self.pers["gamemodeLoadout"]["loadoutKillstreakModules"];
				for(var_10 = 0;var_10 < var_0F;var_10++)
				{
					var_11 = var_13[var_0C][var_10];
					if(isdefined(var_11) && var_11 != "none")
					{
						var_12 = maps\mp\killstreaks\_killstreaks::getstreakmodulecost(var_11);
						self.killstreakmodules[var_11] = var_12;
					}
				}
			}

			for(var_14 = maps\mp\killstreaks\_killstreaks::getstreakcost(var_0E);isdefined(var_0A[var_14]);var_14++)
			{
			}

			var_0A[var_14] = var_0E;
		}

		var_0C++;
	}

	var_16 = 0;
	foreach(var_14, var_18 in var_0A)
	{
		if(var_14 > var_16)
		{
			var_16 = var_14;
		}
	}

	for(var_19 = 0;var_19 <= var_16;var_19++)
	{
		if(!isdefined(var_0A[var_19]))
		{
			continue;
		}

		var_18 = var_0A[var_19];
		self.killstreaks[var_19] = var_0A[var_19];
	}
}

//Function Number: 73
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

//Function Number: 74
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
	}
}

//Function Number: 75
fadeaway(param_00,param_01)
{
	wait(param_00);
	self fadeovertime(param_01);
	self.alpha = 0;
}

//Function Number: 76
setclass(param_00)
{
	self.curclass = param_00;
}

//Function Number: 77
assignpracticeroundclasses()
{
	if(!isdefined(level.practiceroundclasses))
	{
		level.practiceroundclasses = [];
		level.practiceroundclassorder = [];
		var_00 = tablegetcolumncount(level.practiceroundclasstablename);
		for(var_01 = 1;var_01 < var_00;var_01++)
		{
			var_02 = tablelookupbyrow(level.practiceroundclasstablename,0,var_01);
			if(isdefined(level.practiceroundclasses[var_02]))
			{
				level.practiceroundclasses[var_02][level.practiceroundclasses[var_02].size] = var_01 - 1;
				continue;
			}

			level.practiceroundclasses[var_02][0] = var_01 - 1;
		}

		var_03 = getarraykeys(level.practiceroundclasses);
		var_03 = common_scripts\utility::alphabetize(var_03);
		for(var_01 = 0;var_01 < var_03.size;var_01++)
		{
			level.practiceroundclassorder[var_03[var_01]] = var_01;
		}
	}

	self.pers["practiceRoundClasses"] = [];
	foreach(var_02, var_05 in level.practiceroundclasses)
	{
		var_06 = 0;
		if(isdefined(level.practiceroundclassorder[var_02]))
		{
			var_06 = level.practiceroundclassorder[var_02];
		}

		var_07 = 0;
		var_08 = randomintrange(0,var_05.size);
		if(isdefined(var_05[var_08]))
		{
			var_07 = var_05[var_08];
		}

		self.pers["practiceRoundClasses"][var_06] = var_07;
		self setrankedplayerdata("practiceRoundClassMap",var_06,self.pers["practiceRoundClasses"][var_06]);
	}
}

//Function Number: 78
getpracticeroundclass(param_00)
{
	return self.pers["practiceRoundClasses"][param_00];
}

//Function Number: 79
loadoutvalidforcopycat(param_00)
{
	if(!maps\mp\_utility::practiceroundgame())
	{
		return 0;
	}

	var_01 = self.class;
	var_02 = maps\mp\_utility::getclassindex(var_01);
	if(!isdefined(var_01) || !isdefined(var_02))
	{
		return 0;
	}

	var_03 = 1;
	if(var_02 == -1)
	{
		var_01 = self.pers["copyCatLoadout"]["className"];
		var_02 = maps\mp\_utility::getclassindex(var_01);
		if(issubstr(var_01,"practice"))
		{
			var_02 = self.pers["copyCatLoadout"]["practiceClassNum"];
			var_03 = 0;
		}
	}
	else if(issubstr(var_01,"practice"))
	{
		var_02 = self.pers["practiceRoundClasses"][var_02];
		var_03 = 0;
	}
	else if(var_01 == "callback")
	{
		return 1;
	}

	var_04 = param_00.class;
	var_05 = maps\mp\_utility::getclassindex(var_04);
	if(!isdefined(var_04) || !isdefined(var_05))
	{
		return 0;
	}

	var_06 = 1;
	if(var_05 == -1)
	{
		var_04 = param_00.pers["copyCatLoadout"]["className"];
		var_05 = maps\mp\_utility::getclassindex(var_04);
		if(issubstr(var_04,"practice"))
		{
			var_05 = param_00.pers["copyCatLoadout"]["practiceClassNum"];
			var_06 = 0;
		}
	}
	else if(issubstr(var_04,"practice"))
	{
		var_05 = param_00.pers["practiceRoundClasses"][var_05];
		var_06 = 0;
	}
	else if(var_04 == "callback")
	{
		return 1;
	}

	return var_02 != var_05 || var_03 != var_06;
}

//Function Number: 80
setcopycatloadout(param_00)
{
	if(!maps\mp\_utility::practiceroundgame())
	{
		return;
	}

	self.class = "copycat";
	self.pers["class"] = "copycat";
	var_01 = param_00 cloneloadout();
	self.pers["copyCatLoadout"] = var_01;
	self.pers["copyCatLoadout"]["inUse"] = 1;
}

//Function Number: 81
clearcopycatloadout()
{
	self.pers["copyCatLoadout"]["inUse"] = 0;
}

//Function Number: 82
isvalidprimary(param_00)
{
	switch(param_00)
	{
		case "iw5_dlcgun8loot0":
		case "iw5_dlcgun8":
		case "iw5_dlcgun7loot9":
		case "iw5_dlcgun7loot8":
		case "iw5_dlcgun7loot7":
		case "iw5_dlcgun7loot5":
		case "iw5_dlcgun7loot4":
		case "iw5_dlcgun7loot3":
		case "iw5_dlcgun7loot2":
		case "iw5_dlcgun7loot1":
		case "iw5_dlcgun6loot4":
		case "iw5_dlcgun6loot3":
		case "iw5_dlcgun6loot2":
		case "iw5_dlcgun6loot1":
		case "iw5_dlcgun6loot0":
		case "iw5_dlcgun11loot1":
		case "iw5_dlcgun10loot6":
		case "iw5_dlcgun10loot4":
		case "iw5_dlcgun10loot2":
		case "iw5_dlcgun9loot9":
		case "iw5_dlcgun9loot8":
		case "iw5_dlcgun9loot7":
		case "iw5_dlcgun9loot6":
		case "iw5_dlcgun9loot5":
		case "iw5_dlcgun9loot4":
		case "iw5_dlcgun9loot3":
		case "iw5_dlcgun9loot2":
		case "iw5_dlcgun9loot1":
		case "iw5_dlcgun9":
		case "iw5_dlcgun8loot9":
		case "iw5_dlcgun8loot8":
		case "iw5_dlcgun8loot7":
		case "iw5_dlcgun8loot6":
		case "iw5_dlcgun8loot5":
		case "iw5_dlcgun8loot4":
		case "iw5_dlcgun8loot3":
		case "iw5_dlcgun8loot2":
		case "iw5_dlcgun5loot6":
		case "iw5_dlcgun5loot5":
		case "iw5_dlcgun5loot4":
		case "iw5_dlcgun5loot3":
		case "iw5_dlcgun5loot2":
		case "iw5_dlcgun5loot1":
		case "iw5_dlcgun5loot0":
		case "iw5_dlcgun7":
		case "iw5_dlcgun6loot9":
		case "iw5_dlcgun6loot8":
		case "iw5_dlcgun6loot7":
		case "iw5_dlcgun6loot6":
		case "iw5_dlcgun10loot3":
		case "iw5_dlcgun10loot5":
		case "iw5_dlcgun10loot1":
		case "iw5_dlcgun10loot0":
		case "iw5_dlcgun10":
		case "iw5_dlcgun9loot0":
		case "iw5_dlcgun8loot1":
		case "iw5_dlcgun7loot6":
		case "iw5_dlcgun7loot0":
		case "iw5_dlcgun6loot5":
		case "iw5_dlcgun6":
			break;

		default:
			break;
	}
}

//Function Number: 83
isvalidsecondary(param_00,param_01)
{
	if(isdefined(param_01) && param_01)
	{
		return isvalidprimary(param_00);
	}

	switch(param_00)
	{
		case "iw5_dlcgun17":
		case "iw5_dlcgun16":
		case "iw5_dlcgun15":
		case "iw5_dlcgun14":
		case "iw5_dlcgun13":
		case "iw5_dlcgun11loot0":
		case "iw5_dlcgun11":
		case "iw5_dlcgun10loot9":
		case "iw5_dlcgun10loot8":
		case "iw5_dlcgun10loot7":
		case "iw5_dlcgun11loot4":
		case "iw5_dlcgun11loot3":
		case "iw5_dlcgun11loot2":
			break;

		default:
			break;
	}
}

//Function Number: 84
isvalidattachment(param_00,param_01,param_02)
{
	var_03 = 0;
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	switch(param_00)
	{
		case "dragunovedlcstabilizer":
		case "dragunovdlcscopevz":
		case "silencersniper":
		case "silencerpistol":
		case "crossbowscopebase":
		case "thorstabilizer":
		case "m990stabilizer":
		case "gm6stabilizer":
		case "morsstabilizer":
		case "rw1scopebase":
		case "shieldshockplant":
		case "shieldfastplant":
		case "shieldfastmelee":
		case "heatsink":
		case "stabilizer":
		case "trackrounds":
		case "m990scopevz":
		case "thorscopevz":
		case "gm6scopevz":
		case "morsscopevz":
		case "lasersight":
		case "stock":
		case "quickdraw":
		case "longrange":
		case "firerate":
		case "opticstargetenhancer":
		case "directhack":
		case "variablereddot":
		case "foregrip":
		case "silencer01":
		case "opticsthermal":
		case "opticseotech":
		case "opticsacog2":
		case "opticsreddot":
		case "parabolicmicrophone":
		case "hybrid":
		case "hamrhybrid":
		case "eotechlmg":
		case "eotechsmg":
		case "eotech":
		case "dualmag":
		case "xmags":
		case "rof":
		case "fmj":
		case "heartbeat":
		case "thermalsmg":
		case "thermal":
		case "grip":
		case "silencer03":
		case "silencer02":
		case "silencer":
		case "reflexlmg":
		case "reflexsmg":
		case "reflex":
		case "acogsmg":
		case "acog":
		case "scopevz":
		case "sensorheartbeat":
		case "mahemscopebase":
		case "akimbosac3":
		case "akimboxmg":
		case "ironsights":
		case "zoomscope":
		case "akimbo":
		case "tactical":
		case "shotgun":
		case "m320":
		case "gp25":
		case "gl":
		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 85
isattachmentunlocked(param_00,param_01)
{
	if(maps\mp\_utility::ismlgmatch())
	{
		return 1;
	}

	var_02 = maps\mp\_utility::getbaseweaponname(param_00,1);
	if(maps\mp\_utility::islootweapon(var_02))
	{
		var_02 = getbasefromlootversion(var_02);
	}

	var_03 = var_02 + " " + param_01;
	if(!self isitemunlocked(var_03))
	{
		return 0;
	}

	return 1;
}

//Function Number: 86
isvalidcamo(param_00,param_01)
{
	switch(param_00)
	{
		case "sentinel":
		case "diamond":
		case "carbon":
		case "tiger":
		case "neptune":
		case "urbanjet":
		case "concrete":
		case "digital1":
		case "yeti":
		case "highlander":
		case "digital3":
		case "raid":
		case "wooldand":
		case "stranden":
		case "urban":
		case "multicamd":
		case "multicame":
		case "gold":
		case "none":
			break;

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
		case "camo02":
		case "camo01":
			break;

		default:
			break;
	}
}

//Function Number: 87
isvalidreticle(param_00,param_01)
{
	switch(param_00)
	{
		case "retdlc42":
		case "retdlc41":
		case "retdlc40":
		case "retdlc39":
		case "retdlc38":
		case "retdlc37":
		case "retdlc36":
		case "retdlc35":
		case "retdlc34":
		case "retdlc33":
		case "retdlc32":
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
		case "ret9":
		case "ret8":
		case "ret7":
		case "ret6":
		case "ret5":
		case "ret4":
		case "ret3":
		case "ret2":
		case "ret1":
		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 88
iscamounlocked(param_00,param_01)
{
	if(maps\mp\_utility::ismlgmatch())
	{
		return 1;
	}

	var_02 = maps\mp\_utility::getbaseweaponname(param_00,1);
	if(maps\mp\_utility::islootweapon(var_02))
	{
		var_02 = getbasefromlootversion(var_02);
	}

	var_03 = var_02 + " " + param_01;
	if(!self isitemunlocked(var_03))
	{
		return 0;
	}

	return 1;
}

//Function Number: 89
isvalidequipment(param_00,param_01)
{
	if(param_01)
	{
		return isvalidoffhand(param_00,0);
	}

	param_00 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	switch(param_00)
	{
		case "contact_grenade_var_mp":
		case "semtex_grenade_var_mp":
		case "frag_grenade_var_mp":
		case "smoke_grenade_var_mp":
		case "paint_grenade_var_mp":
		case "emp_grenade_var_mp":
		case "stun_grenade_var_mp":
		case "mute_bomb_mp":
		case "explosive_drone_mp":
		case "tracking_drone_mp":
		case "smoke_grenade_mp":
		case "emp_grenade_mp":
		case "paint_grenade_mp":
		case "stun_grenade_mp":
		case "concussion_grenade_mp":
		case "flash_grenade_mp":
		case "scrambler_mp":
		case "s1_tactical_insertion_device_mp":
		case "portable_radar_mp":
		case "explosive_gel_mp":
		case "exoknife_mp":
		case "throwingknife_mp":
		case "tri_drone_mp":
		case "c4_mp":
		case "bouncingbetty_mp":
		case "semtex_mp":
		case "trophy_mp":
		case "exoknife_jug_mp":
		case "specialty_null":
		case "frag_grenade_mp":
		case "claymore_mp":
			break;

		default:
			break;
	}
}

//Function Number: 90
isvalidoffhand(param_00,param_01)
{
	if(param_01)
	{
		return isvalidequipment(param_00,0);
	}

	param_00 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	switch(param_00)
	{
		case "exoslide_equipment_mp":
		case "exododge_equipment_mp":
		case "exoboost_equipment_mp":
		case "fast_heal_mp":
		case "exomute_equipment_mp":
		case "exoshield_equipment_mp":
		case "exorepulsor_equipment_mp":
		case "exoping_equipment_mp":
		case "exohover_equipment_mp":
		case "exocloak_equipment_mp":
		case "extra_health_mp":
		case "adrenaline_mp":
		case "specialty_null":
		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 91
isvalidweapon(param_00)
{
	if(!isdefined(level.weaponrefs))
	{
		level.weaponrefs = [];
		foreach(var_02 in level.weaponlist)
		{
			level.weaponrefs[var_02] = 1;
		}
	}

	if(isdefined(level.weaponrefs[param_00]))
	{
		return 1;
	}

	recordvalidationinfraction();
	return 0;
}

//Function Number: 92
isvalidkillstreak(param_00)
{
	switch(param_00)
	{
		case "zm_ripped_turret":
		case "zm_ugv":
		case "zm_sentry":
		case "zm_squadmate":
		case "zm_camouflage":
		case "next_gen_exo":
		case "drone_carepackage":
		case "heavy_exosuit":
		case "mp_spark":
		case "mp_blackbox":
		case "mp_odium":
		case "mp_laser2":
		case "mp_lab2":
		case "map_killstreak":
		case "remote_mg_turret":
		case "directional_uav":
		case "airdrop_reinforcement_practice":
		case "airdrop_reinforcement_rare":
		case "airdrop_reinforcement_uncommon":
		case "airdrop_reinforcement_common":
		case "airdrop_trap":
		case "orbital_carepackage":
		case "uav":
		case "airdrop_assault":
		case "airdrop_sentry_minigun":
		case "strafing_run_airstrike":
		case "remote_mg_sentry_turret":
		case "mp_seoul2":
		case "mp_bigben2":
		case "assault_ugv":
		case "warbird":
		case "recon_ugv":
		case "mp_recreation":
		case "orbitalsupport":
		case "orbital_strike_drone":
		case "orbital_strike_cluster":
		case "orbital_strike_laser_chem":
		case "orbital_strike_chem":
		case "orbital_strike_laser":
		case "orbital_strike":
		case "missile_strike":
		case "mp_lost":
		case "sentry":
		case "emp":
		case "mp_comeback":
		case "mp_torqued":
		case "mp_terrace":
		case "mp_solar":
		case "mp_recovery":
		case "mp_levity":
		case "mp_instinct":
		case "mp_greenband":
		case "mp_dam":
		case "mp_prison":
		case "mp_refraction":
		case "none":
			break;

		default:
			break;
	}
}