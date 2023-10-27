/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_class.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 101
 * Decompile Time: 1637 ms
 * Timestamp: 10/27/2023 2:41:09 AM
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
	level.agentcostumetablename = "mp/agentCostumeTable.csv";
	level.hardcorecostumetablename = "mp/hardcoreCostumeTable.csv";
	level.classpickcount = 13;
	if(!isdefined(level.customclasspickcount))
	{
		level.customclasspickcount = 13;
	}

	level thread onplayerconnecting();
}

//Function Number: 2
getemptyloadout()
{
	var_00 = [];
	var_00["loadoutPrimary"] = "h1_ak47";
	var_00["loadoutPrimaryAttachKit"] = "none";
	var_00["loadoutPrimaryFurnitureKit"] = "none";
	var_00["loadoutPrimaryCamo"] = "none";
	var_00["loadoutPrimaryReticle"] = "none";
	var_00["loadoutSecondary"] = "none";
	var_00["loadoutSecondaryAttachKit"] = "none";
	var_00["loadoutSecondaryFurnitureKit"] = "none";
	var_00["loadoutSecondaryCamo"] = "none";
	var_00["loadoutSecondaryReticle"] = "none";
	var_00["loadoutEquipment"] = "specialty_null";
	var_00["loadoutOffhand"] = "none";
	var_00["loadoutPerks"] = maps\mp\perks\_perks::getemptyperks();
	var_00["loadoutMelee"] = "none";
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
usevirtuallobbyfunction()
{
	return maps\mp\_utility::invirtuallobby();
}

//Function Number: 7
cac_getweapon(param_00,param_01,param_02)
{
	if(usevirtuallobbyfunction())
	{
		return function_02F9(param_02,maps\mp\_utility::cac_getcustomclassloc(),param_00,"weaponSetups",param_01,"weapon");
	}

	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"weaponSetups",param_01,"weapon");
	}

	return self getcacplayerdata(param_00,"weaponSetups",param_01,"weapon");
}

//Function Number: 8
cac_getweaponcamo(param_00,param_01,param_02)
{
	if(usevirtuallobbyfunction())
	{
		return function_02F9(param_02,maps\mp\_utility::cac_getcustomclassloc(),param_00,"weaponSetups",param_01,"camo");
	}

	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"weaponSetups",param_01,"camo");
	}

	return self getcacplayerdata(param_00,"weaponSetups",param_01,"camo");
}

//Function Number: 9
cac_getweaponreticle(param_00,param_01,param_02)
{
	if(usevirtuallobbyfunction())
	{
		return function_02F9(param_02,maps\mp\_utility::cac_getcustomclassloc(),param_00,"weaponSetups",param_01,"reticle");
	}

	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"weaponSetups",param_01,"reticle");
	}

	return self getcacplayerdata(param_00,"weaponSetups",param_01,"reticle");
}

//Function Number: 10
cac_getweaponattachkitid(param_00,param_01,param_02)
{
	if(usevirtuallobbyfunction())
	{
		return function_02F9(param_02,maps\mp\_utility::cac_getcustomclassloc(),param_00,"weaponSetups",param_01,"kit","attachKit");
	}
	else if(isdefined(level.forcecustomclassloc))
	{
		var_03 = self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"weaponSetups",param_01,"kit","attachKit");
	}
	else
	{
		var_03 = self getcacplayerdata(param_01,"weaponSetups",param_02,"kit","attachKit");
	}

	return var_03;
}

//Function Number: 11
cac_getweaponattachkit(param_00,param_01,param_02)
{
	var_03 = cac_getweaponattachkitid(param_00,param_01,param_02);
	var_04 = tablelookup("mp/attachkits.csv",0,common_scripts\utility::tostring(var_03),1);
	return var_04;
}

//Function Number: 12
cac_getweaponfurniturekitid(param_00,param_01,param_02)
{
	if(usevirtuallobbyfunction())
	{
		return function_02F9(param_02,maps\mp\_utility::cac_getcustomclassloc(),param_00,"weaponSetups",param_01,"kit","furnitureKit");
	}
	else if(isdefined(level.forcecustomclassloc))
	{
		var_03 = self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"weaponSetups",param_01,"kit","furnitureKit");
	}
	else
	{
		var_03 = self getcacplayerdata(param_01,"weaponSetups",param_02,"kit","furnitureKit");
	}

	return var_03;
}

//Function Number: 13
cac_getweaponfurniturekit(param_00,param_01,param_02)
{
	var_03 = cac_getweaponfurniturekitid(param_00,param_01,param_02);
	var_04 = tablelookup("mp/furniturekits.csv",0,common_scripts\utility::tostring(var_03),1);
	return var_04;
}

//Function Number: 14
cac_getmeleeweapon(param_00,param_01)
{
	if(usevirtuallobbyfunction())
	{
		return function_02F9(param_01,maps\mp\_utility::cac_getcustomclassloc(),param_00,"meleeWeapon");
	}

	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"meleeWeapon");
	}

	return self getcacplayerdata(param_00,"meleeWeapon");
}

//Function Number: 15
cac_getperk(param_00,param_01,param_02)
{
	if(usevirtuallobbyfunction())
	{
		return function_02F9(param_02,maps\mp\_utility::cac_getcustomclassloc(),param_00,"perkSlots",param_01);
	}

	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"perkSlots",param_01);
	}

	return self getcacplayerdata(param_00,"perkSlots",param_01);
}

//Function Number: 16
cac_getequipment(param_00,param_01,param_02)
{
	if(usevirtuallobbyfunction())
	{
		return function_02F9(param_02,maps\mp\_utility::cac_getcustomclassloc(),param_00,"equipment",param_01);
	}

	if(isdefined(level.forcecustomclassloc))
	{
		return self getcacplayerdataforgroup(level.forcecustomclassloc,param_00,"equipment",param_01);
	}

	return self getcacplayerdata(param_00,"equipment",param_01);
}

//Function Number: 17
cac_getoffhand(param_00,param_01)
{
	return cac_getequipment(param_00,1,param_01);
}

//Function Number: 18
cao_isglobalcostumecategory(param_00)
{
	return param_00 == "gender" || param_00 == "head";
}

//Function Number: 19
cao_getglobalcostumecategory(param_00,param_01)
{
	if(maps\mp\_utility::invirtuallobby() && isdefined(param_01))
	{
		return function_02FA(param_01,common_scripts\utility::getstatsgroup_common(),"globalCostume",param_00);
	}

	return self getplayerdata(common_scripts\utility::getstatsgroup_common(),"globalCostume",param_00);
}

//Function Number: 20
cao_getpercostumecategory(param_00,param_01,param_02)
{
	if(maps\mp\_utility::invirtuallobby() && isdefined(param_02))
	{
		return function_02FA(param_02,common_scripts\utility::getstatsgroup_common(),"costumes",param_01,param_00);
	}

	return self getplayerdata(common_scripts\utility::getstatsgroup_common(),"costumes",param_01,param_00);
}

//Function Number: 21
cao_setglobalcostumecategory(param_00,param_01)
{
	return self setplayerdata(common_scripts\utility::getstatsgroup_common(),"globalCostume",param_00,param_01);
}

//Function Number: 22
cao_setpercostumecategory(param_00,param_01,param_02)
{
	return self setplayerdata(common_scripts\utility::getstatsgroup_common(),"costumes",param_02,param_00,param_01);
}

//Function Number: 23
cao_getactivecostumeindex(param_00)
{
	if(maps\mp\_utility::invirtuallobby() && isdefined(param_00))
	{
		return function_02FA(param_00,common_scripts\utility::getstatsgroup_common(),"activeCostume");
	}

	return self getplayerdata(common_scripts\utility::getstatsgroup_common(),"activeCostume");
}

//Function Number: 24
cao_getcharactercamoindex(param_00)
{
	if(maps\mp\_utility::invirtuallobby() && isdefined(param_00))
	{
		return function_02FA(param_00,common_scripts\utility::getstatsgroup_common(),"characterCamoIndex");
	}

	return self getplayerdata(common_scripts\utility::getstatsgroup_common(),"characterCamoIndex");
}

//Function Number: 25
cao_getcostumebyindex(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < level.costumecategories.size;var_03++)
	{
		var_04 = level.costumecategories[var_03];
		if(cao_isglobalcostumecategory(var_04))
		{
			var_02[var_03] = cao_getglobalcostumecategory(var_04,param_01);
			continue;
		}

		var_02[var_03] = cao_getpercostumecategory(var_04,param_00,param_01);
	}

	return var_02;
}

//Function Number: 26
cao_getactivecostume(param_00)
{
	var_01 = cao_getactivecostumeindex(param_00);
	return cao_getcostumebyindex(var_01,param_00);
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
cac_setlastteam(param_00)
{
	if(maps\mp\_utility::invirtuallobby())
	{
		return;
	}

	var_01 = 0;
	if(param_00 == "axis")
	{
		var_01 = 1;
	}

	self setplayerdata(common_scripts\utility::getstatsgroup_common(),"lastGame","team",var_01);
}

//Function Number: 30
cac_setlastgrouplocation(param_00)
{
	if(maps\mp\_utility::invirtuallobby())
	{
		return;
	}

	self setplayerdata(common_scripts\utility::getstatsgroup_common(),"lastGame","classLocation",param_00);
}

//Function Number: 31
cac_setlastclassindex(param_00)
{
	if(maps\mp\_utility::invirtuallobby())
	{
		return;
	}

	self setplayerdata(common_scripts\utility::getstatsgroup_common(),"lastGame","classIndex",param_00);
}

//Function Number: 32
cac_setlastenvironment(param_00)
{
	if(maps\mp\_utility::invirtuallobby())
	{
		return;
	}

	var_01 = 0;
	if(param_00 == "desert")
	{
		var_01 = 2;
	}
	else if(param_00 == "woodland")
	{
		var_01 = 1;
	}

	self setplayerdata(common_scripts\utility::getstatsgroup_common(),"lastGame","environment",var_01);
}

//Function Number: 33
cac_getlastteam(param_00)
{
	var_01 = function_02FA(param_00,common_scripts\utility::getstatsgroup_common(),"lastGame","team");
	if(var_01)
	{
		return "axis";
	}

	return "allies";
}

//Function Number: 34
cac_getlastgroupstring(param_00)
{
	var_01 = "";
	var_02 = function_02FA(param_00,common_scripts\utility::getstatsgroup_common(),"lastGame","classLocation");
	if(var_02 == 0)
	{
		var_01 = "customClasses";
	}
	else
	{
		var_01 = "privateMatchCustomClasses";
	}

	return var_01;
}

//Function Number: 35
cac_getlastclassindex(param_00)
{
	var_01 = function_02FA(param_00,common_scripts\utility::getstatsgroup_common(),"lastGame","classIndex");
	return var_01;
}

//Function Number: 36
cac_getlastenvironment(param_00)
{
	var_01 = function_02FA(param_00,common_scripts\utility::getstatsgroup_common(),"lastGame","environment");
	if(var_01 == 0)
	{
		return "urban";
	}

	if(var_01 == 1)
	{
		return "woodland";
	}

	return "desert";
}

//Function Number: 37
table_getweapon(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimary",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondary",param_01 + 1);
}

//Function Number: 38
table_getweaponbuff(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryBuff",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryBuff",param_01 + 1);
}

//Function Number: 39
table_getweaponcamo(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryCamo",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryCamo",param_01 + 1);
}

//Function Number: 40
table_getweaponreticle(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryReticle",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryReticle",param_01 + 1);
}

//Function Number: 41
table_getweaponattachkit(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryAttachKit",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryAttachKit",param_01 + 1);
}

//Function Number: 42
table_getweaponfurniturekit(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryFurnitureKit",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryFurnitureKit",param_01 + 1);
}

//Function Number: 43
table_getperk(param_00,param_01,param_02)
{
	param_02++;
	var_03 = "loadoutPerk" + param_02;
	return tablelookup(param_00,0,var_03,param_01 + 1);
}

//Function Number: 44
table_getequipment(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutEquipment",param_01 + 1);
}

//Function Number: 45
table_getteamperk(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutTeamPerk",param_01 + 1);
}

//Function Number: 46
table_getoffhand(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutOffhand",param_01 + 1);
}

//Function Number: 47
attachkitnametoid(param_00)
{
	var_01 = tablelookup("mp/attachkits.csv",1,param_00,0);
	var_01 = int(var_01);
	return var_01;
}

//Function Number: 48
furniturekitnametoid(param_00)
{
	var_01 = function_0303("mp/furniturekits.csv",1,param_00,0);
	var_01 = int(var_01);
	return var_01;
}

//Function Number: 49
cloneloadout()
{
	var_00 = "none";
	var_01 = self.curclass;
	var_02 = self.classcallback;
	if(var_01 == "copycat")
	{
		var_01 = self.pers["copyCatLoadout"]["className"];
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

	var_03 = [];
	if(var_00 != "none")
	{
		var_04 = maps\mp\_utility::getclassindex(var_01);
		var_05 = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","weaponSetups",0,"weapon");
		var_06 = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","weaponSetups",0,"kit","attachKit");
		var_07 = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","weaponSetups",0,"kit","furnitureKit");
		var_08 = tablelookup("mp/attachkits.csv",0,common_scripts\utility::tostring(var_06),1);
		var_09 = tablelookup("mp/furniturekits.csv",0,common_scripts\utility::tostring(var_07),1);
		var_0A = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","weaponSetups",0,"camo");
		var_0B = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","weaponSetups",0,"reticle");
		var_0C = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","weaponSetups",1,"weapon");
		var_06 = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","weaponSetups",1,"kit","attachKit");
		var_07 = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","weaponSetups",1,"kit","furnitureKit");
		var_0D = tablelookup("mp/attachkits.csv",0,common_scripts\utility::tostring(var_06),1);
		var_0E = tablelookup("mp/furniturekits.csv",0,common_scripts\utility::tostring(var_07),1);
		var_0F = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","weaponSetups",1,"camo");
		var_10 = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","weaponSetups",1,"reticle");
		var_11 = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","equipment",0);
		var_12 = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","equipment",1);
		for(var_13 = 0;var_13 < 3;var_13++)
		{
			var_03[var_13] = getmatchrulesdata("defaultClasses",var_00,"defaultClass",var_04,"class","perkSlots",var_13);
		}

		var_14 = "none";
	}
	else if(issubstr(var_11,"custom"))
	{
		var_15 = maps\mp\_utility::getclassindex(var_11);
		var_05 = cac_getweapon(var_15,0);
		var_08 = cac_getweaponattachkit(var_15,0);
		var_09 = cac_getweaponfurniturekit(var_15,0);
		var_0A = cac_getweaponcamo(var_15,0);
		var_0B = cac_getweaponreticle(var_15,0);
		var_0C = cac_getweapon(var_15,1);
		var_0D = cac_getweaponattachkit(var_15,1);
		var_0E = cac_getweaponfurniturekit(var_15,1);
		var_0F = cac_getweaponcamo(var_15,1);
		var_10 = cac_getweaponreticle(var_15,1);
		var_11 = cac_getequipment(var_15,0);
		var_12 = cac_getequipment(var_15,1);
		for(var_13 = 0;var_13 < 3;var_13++)
		{
			var_03[var_13] = cac_getperk(var_15,var_13);
		}

		var_14 = cac_getmeleeweapon(var_15);
	}
	else if(var_11 == "callback")
	{
		if(!isdefined(var_12))
		{
			common_scripts\utility::error("self.classCallback function reference required for class \'callback\'");
		}

		var_16 = [[ var_12 ]](1);
		if(!isdefined(var_16))
		{
			common_scripts\utility::error("array required from self.classCallback for class \'callback\'");
		}

		var_05 = var_16["loadoutPrimary"];
		var_08 = var_16["loadoutPrimaryAttachKit"];
		var_09 = var_16["loadoutPrimaryFurnitureKit"];
		var_0A = var_16["loadoutPrimaryCamo"];
		var_0B = var_16["loadoutPrimaryReticle"];
		var_0C = var_16["loadoutSecondary"];
		var_0D = var_16["loadoutSecondaryAttachKit"];
		var_0E = var_16["loadoutSecondaryFurnitureKit"];
		var_0F = var_16["loadoutSecondaryCamo"];
		var_10 = var_16["loadoutSecondaryReticle"];
		var_11 = var_16["loadoutEquipment"];
		var_12 = var_16["loadoutOffhand"];
		var_03[0] = var_16["loadoutPerk1"];
		var_03[1] = var_16["loadoutPerk2"];
		var_03[2] = var_16["loadoutPerk3"];
		var_14 = var_16["loadoutMelee"];
	}
	else
	{
		var_15 = maps\mp\_utility::getclassindex(var_11);
		var_05 = table_getweapon(level.classtablename,var_15,0);
		var_08 = table_getweaponattachkit(level.classtablename,var_15,0);
		var_09 = table_getweaponfurniturekit(level.classtablename,var_15,0);
		var_0A = table_getweaponcamo(level.classtablename,var_15,0);
		var_0B = table_getweaponreticle(level.classtablename,var_15,0);
		var_0C = table_getweapon(level.classtablename,var_15,1);
		var_0D = table_getweaponattachkit(level.classtablename,var_15,1);
		var_0E = table_getweaponfurniturekit(level.classtablename,var_15,1);
		var_0F = table_getweaponcamo(level.classtablename,var_15,1);
		var_10 = table_getweaponreticle(level.classtablename,var_15,1);
		var_11 = table_getequipment(level.classtablename,var_15);
		var_12 = table_getoffhand(level.classtablename,var_15);
		for(var_13 = 0;var_13 < 3;var_13++)
		{
			var_03[var_13] = table_getperk(level.classtablename,var_15,var_13);
		}

		var_14 = "none";
	}

	var_17 = [];
	var_17["inUse"] = 0;
	var_17["className"] = var_01;
	if(var_01 == "callback" && isdefined(var_02))
	{
		var_17["classCallbackFunc"] = var_02;
	}

	var_17["loadoutPrimary"] = var_05;
	var_17["loadoutPrimaryAttachKit"] = var_08;
	var_17["loadoutPrimaryFurnitureKit"] = var_09;
	var_17["loadoutPrimaryCamo"] = var_0A;
	var_17["loadoutPrimaryReticle"] = var_0B;
	var_17["loadoutSecondary"] = var_0C;
	var_17["loadoutSecondaryAttachKit"] = var_0D;
	var_17["loadoutSecondaryFurnitureKit"] = var_0E;
	var_17["loadoutSecondaryCamo"] = var_0F;
	var_17["loadoutSecondaryReticle"] = var_10;
	var_17["loadoutEquipment"] = var_11;
	var_17["loadoutOffhand"] = var_12;
	for(var_13 = 0;var_13 < 3;var_13++)
	{
		var_17["loadoutPerks"][var_13] = var_03[var_13];
	}

	var_17["loadoutMelee"] = var_14;
	return var_17;
}

//Function Number: 50
getloadout(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_05 = 0;
	var_06 = undefined;
	var_07 = 0;
	var_08 = undefined;
	var_09 = issubstr(param_01,"custom");
	var_0A = 0;
	var_0B = [];
	var_0C = param_01 == "gamemode";
	if(issubstr(param_01,"axis"))
	{
		var_0D = "axis";
	}
	else if(issubstr(param_02,"allies"))
	{
		var_0D = "allies";
	}
	else
	{
		var_0D = "none";
	}

	var_0E = [];
	if(isdefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && param_02)
	{
		var_0A = 1;
		var_09 = 0;
		var_06 = maps\mp\_utility::getclassindex("copycat");
		var_0E = self.pers["copyCatLoadout"];
		var_0F = var_0E["loadoutPrimary"];
		var_10 = var_0E["loadoutPrimaryAttachKit"];
		var_11 = var_0E["loadoutPrimaryFurnitureKit"];
		var_12 = var_0E["loadoutPrimaryCamo"];
		var_13 = var_0E["loadoutPrimaryReticle"];
		var_14 = var_0E["loadoutSecondary"];
		var_15 = var_0E["loadoutSecondaryAttachKit"];
		var_16 = var_0E["loadoutSecondaryFurnitureKit"];
		var_17 = var_0E["loadoutSecondaryCamo"];
		var_18 = var_0E["loadoutSecondaryReticle"];
		var_19 = var_0E["loadoutEquipment"];
		var_1A = var_0E["loadoutOffhand"];
		for(var_1B = 0;var_1B < 3;var_1B++)
		{
			var_0B[var_1B] = var_0E["loadoutPerks"][var_1B];
		}

		var_1C = var_0E["loadoutMelee"];
	}
	else if(var_1A != "none")
	{
		var_1D = maps\mp\_utility::getclassindex(var_0E);
		var_06 = var_1D;
		self.class_num = var_1D;
		self.teamname = var_0D;
		var_0F = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","weaponSetups",0,"weapon");
		if(var_0F == "none")
		{
			var_0F = "h1_ak47";
			var_10 = "none";
			var_11 = "none";
		}
		else
		{
			var_1E = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","weaponSetups",0,"kit","attachKit");
			var_1F = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","weaponSetups",0,"kit","furnitureKit");
			var_10 = tablelookup("mp/attachkits.csv",0,common_scripts\utility::tostring(var_1E),1);
			var_11 = tablelookup("mp/furniturekits.csv",0,common_scripts\utility::tostring(var_1F),1);
		}

		var_12 = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","weaponSetups",0,"camo");
		var_13 = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","weaponSetups",0,"reticle");
		var_14 = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","weaponSetups",1,"weapon");
		var_1E = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","weaponSetups",1,"kit","attachKit");
		var_1F = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","weaponSetups",1,"kit","furnitureKit");
		var_15 = tablelookup("mp/attachkits.csv",0,common_scripts\utility::tostring(var_1E),1);
		var_16 = tablelookup("mp/furniturekits.csv",0,common_scripts\utility::tostring(var_1F),1);
		var_17 = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","weaponSetups",1,"camo");
		var_18 = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","weaponSetups",1,"reticle");
		var_19 = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","equipment",0);
		var_1A = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","equipment",1);
		for(var_1B = 0;var_1B < 3;var_1B++)
		{
			var_0B[var_1B] = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","perkSlots",var_1B);
		}

		var_1C = getmatchrulesdata("defaultClasses",var_0D,"defaultClass",var_1D,"class","meleeWeapon");
		if(var_0F == "none" && var_14 != "none")
		{
			var_0F = var_14;
			var_10 = var_15;
			var_11 = var_16;
			var_12 = var_17;
			var_13 = var_18;
			var_14 = "none";
			var_15 = "none";
			var_16 = "none";
			var_17 = "none";
			var_18 = "none";
		}
		else if(var_0F == "none" && var_14 == "none")
		{
			var_05 = 1;
			var_0F = "h1_beretta";
			var_10 = "none";
			var_11 = "none";
		}
	}
	else if(issubstr(var_0E,"custom"))
	{
		var_13 = maps\mp\_utility::getclassindex(var_0E);
		var_0F = cac_getweapon(var_13,0);
		var_10 = cac_getweaponattachkit(var_12,0);
		var_11 = cac_getweaponfurniturekit(var_11,0);
		var_12 = cac_getweaponcamo(var_10,0);
		var_13 = cac_getweaponreticle(var_0F,0);
		var_14 = cac_getweapon(var_0E,1);
		var_15 = cac_getweaponattachkit(var_0D,1);
		var_16 = cac_getweaponfurniturekit(var_0C,1);
		var_17 = cac_getweaponcamo(var_0B,1);
		var_18 = cac_getweaponreticle(var_0A,1);
		var_19 = cac_getequipment(var_09,0);
		var_1A = cac_getequipment(var_08,1);
		for(var_1B = 0;var_1B < 3;var_1B++)
		{
			var_0B[var_1B] = cac_getperk(var_06,var_1B);
		}

		var_1C = cac_getmeleeweapon(var_06);
	}
	else if(issubstr(var_0E,"lobby"))
	{
		var_13 = maps\mp\_utility::getclassindex(var_0E);
		var_20 = maps\mp\_utility::cac_getcustomclassloc();
		var_21 = [[ level.vl_loadoutfunc ]](var_20,var_06);
		var_0F = var_21["primary"];
		var_10 = var_21["primaryAttachKit"];
		var_11 = var_21["primaryFurnitureKit"];
		var_12 = var_21["primaryCamo"];
		var_13 = var_21["primaryReticle"];
		var_14 = var_21["secondary"];
		var_15 = var_21["secondaryAttachKit"];
		var_16 = var_21["secondaryFurnitureKit"];
		var_17 = var_21["secondaryCamo"];
		var_18 = var_21["secondaryReticle"];
		var_19 = var_21["equipment"];
		var_1A = var_21["offhand"];
		for(var_1B = 0;var_1B < 3;var_1B++)
		{
			var_0B[var_1B] = var_21["perk" + var_1B];
		}

		var_1C = var_21["meleeWeapon"];
	}
	else if(var_19)
	{
		var_22 = self.pers["gamemodeLoadout"];
		var_0F = var_22["loadoutPrimary"];
		var_10 = var_22["loadoutPrimaryAttachKit"];
		var_11 = var_22["loadoutPrimaryFurnitureKit"];
		var_12 = var_22["loadoutPrimaryCamo"];
		var_13 = var_22["loadoutPrimaryReticle"];
		var_14 = var_22["loadoutSecondary"];
		var_15 = var_22["loadoutSecondaryAttachKit"];
		var_16 = var_22["loadoutSecondaryFurnitureKit"];
		var_17 = var_22["loadoutSecondaryCamo"];
		var_18 = var_22["loadoutSecondaryReticle"];
		var_19 = var_22["loadoutEquipment"];
		var_1A = var_22["loadoutOffhand"];
		if(var_1A == "specialty_null")
		{
			var_1A = "none";
		}

		for(var_1B = 0;var_1B < 3;var_1B++)
		{
			var_0B[var_1B] = var_22["loadoutPerks"][var_1B];
		}

		var_1C = var_22["loadoutMelee"];
	}
	else if(var_0E == "callback")
	{
		if(!isdefined(self.classcallback))
		{
			common_scripts\utility::error("self.classCallback function reference required for class \'callback\'");
		}

		var_23 = [[ self.classcallback ]](var_11);
		if(!isdefined(var_23))
		{
			common_scripts\utility::error("array required from self.classCallback for class \'callback\'");
		}

		var_0F = var_23["loadoutPrimary"];
		var_10 = var_23["loadoutPrimaryAttachKit"];
		var_11 = var_23["loadoutPrimaryFurnitureKit"];
		var_12 = var_23["loadoutPrimaryCamo"];
		var_13 = var_23["loadoutPrimaryReticle"];
		var_14 = var_23["loadoutSecondary"];
		var_15 = var_23["loadoutSecondaryAttachKit"];
		var_16 = var_23["loadoutSecondaryFurnitureKit"];
		var_17 = var_23["loadoutSecondaryCamo"];
		var_18 = var_23["loadoutSecondaryReticle"];
		var_19 = var_23["loadoutEquipment"];
		var_1A = var_23["loadoutOffhand"];
		var_0B[0] = var_23["loadoutPerk1"];
		var_0B[1] = var_23["loadoutPerk2"];
		var_0B[2] = var_23["loadoutPerk3"];
		var_1C = var_23["loadoutMelee"];
	}
	else
	{
		var_13 = maps\mp\_utility::getclassindex(var_0E);
		var_0F = table_getweapon(level.classtablename,var_13,0);
		var_10 = table_getweaponattachkit(level.classtablename,var_12,0);
		var_11 = table_getweaponfurniturekit(level.classtablename,var_11,0);
		var_12 = table_getweaponcamo(level.classtablename,var_10,0);
		var_13 = table_getweaponreticle(level.classtablename,var_0F,0);
		var_14 = table_getweapon(level.classtablename,var_0E,1);
		var_15 = table_getweaponattachkit(level.classtablename,var_0D,1);
		var_16 = table_getweaponfurniturekit(level.classtablename,var_0C,1);
		var_17 = table_getweaponcamo(level.classtablename,var_0B,1);
		var_18 = table_getweaponreticle(level.classtablename,var_0A,1);
		var_19 = table_getequipment(level.classtablename,var_09);
		var_1A = table_getoffhand(level.classtablename,var_08);
		var_0C[0] = table_getperk(level.classtablename,var_07,0);
		var_0C[1] = table_getperk(level.classtablename,var_07,1);
		var_0C[2] = table_getperk(level.classtablename,var_07,2);
		var_1C = "none";
	}

	var_24 = issubstr(param_01,"custom") || issubstr(param_01,"lobby");
	var_25 = issubstr(param_01,"recipe");
	var_26 = 0;
	if(!var_0C && !var_25 && !level.oldschool && !isdefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && param_02)
	{
		if(!isvalidprimary(var_0F,1) || level.rankedmatch && var_24 && !var_26 && !self isitemunlocked(var_0F))
		{
			var_0F = table_getweapon(level.classtablename,10,0);
			var_12 = "none";
			var_13 = "none";
			var_10 = "none";
			var_11 = "none";
		}

		if(!isvalidcamo(var_12,1) || level.rankedmatch && var_24 && !var_26 && !iscamounlocked(var_0F,var_12))
		{
			var_12 = table_getweaponcamo(level.classtablename,10,0);
		}

		if(!isvalidreticle(var_13,1))
		{
			var_13 = table_getweaponreticle(level.classtablename,10,0);
		}

		if(!isvalidattachkit(var_10,var_0F,1) || level.rankedmatch && var_24 && !var_26 && !isattachkitunlocked(var_0F,var_10))
		{
			var_10 = table_getweaponattachkit(level.classtablename,10,0);
		}

		if(!isvalidfurniturekit(var_11,var_0F,1) || level.rankedmatch && var_24 && !var_26 && !isfurniturekitunlocked(var_0F,var_11))
		{
			var_11 = table_getweaponfurniturekit(level.classtablename,10,0);
		}

		var_28 = common_scripts\utility::array_contains(var_0B,"specialty_twoprimaries");
		if(!isvalidsecondary(var_14,var_28,1) || level.rankedmatch && var_24 && !var_26 && !self isitemunlocked(var_14))
		{
			var_14 = table_getweapon(level.classtablename,10,1);
			var_17 = "none";
			var_18 = "none";
			var_15 = "none";
			var_16 = "none";
		}

		if(!isvalidcamo(var_17,1) || level.rankedmatch && var_24 && !var_26 && !iscamounlocked(var_14,var_17))
		{
			var_17 = table_getweaponcamo(level.classtablename,10,1);
		}

		if(!isvalidreticle(var_18,1))
		{
			var_18 = table_getweaponreticle(level.classtablename,10,1);
		}

		if(!isvalidattachkit(var_15,var_14,1) || level.rankedmatch && var_24 && !var_26 && !isattachkitunlocked(var_14,var_15))
		{
			var_15 = table_getweaponattachkit(level.classtablename,10,1);
		}

		if(!isvalidfurniturekit(var_16,var_14,1) || level.rankedmatch && var_24 && !var_26 && !isfurniturekitunlocked(var_14,var_16))
		{
			var_16 = table_getweaponfurniturekit(level.classtablename,10,1);
		}

		if(!isvalidequipment(var_19,1) || level.rankedmatch && var_24 && !var_26 && !self isitemunlocked(var_19))
		{
			var_19 = table_getequipment(level.classtablename,10);
		}

		if(var_19 == var_1A)
		{
			var_19 = "specialty_null";
		}

		if(!isvalidoffhand(var_1A,1))
		{
			var_1A = table_getoffhand(level.classtablename,10);
		}

		if(!isvalidmeleeweapon(var_1C,1))
		{
			var_1C = "none";
		}
	}

	for(var_1B = 0;var_1B < 3;var_1B++)
	{
		if(var_0B[var_1B] == "specialty_null")
		{
			continue;
		}

		var_29 = var_0B[var_1B];
		var_0B[var_1B] = maps\mp\perks\_perks::validateperk(var_1B,var_0B[var_1B]);
		if(var_29 != var_0B[var_1B])
		{
			foundinfraction("^1Warning: Perk " + var_29 + " in wrong slot.");
		}

		if(var_1B == 0 && var_0B[var_1B] != "specialty_null" && isgrenadelauncher(var_10) || isgrenadelauncher(var_15))
		{
			foundinfraction("^1Warning: Player has a perk " + var_29 + " in slot 1 and a grenade launcher too.");
			var_0B[0] = "specialty_null";
		}

		if(var_1B == 0 && var_0B[var_1B] != "specialty_null" && isgrip(var_10) || isgrip(var_15))
		{
			foundinfraction("^1Warning: Player has a perk " + var_29 + " in slot 1 and a foregrip too.");
			var_0B[0] = "specialty_null";
		}

		if(var_1B == 0 && var_0B[var_1B] == "specialty_specialgrenade" && var_1A == "h1_smokegrenade_mp")
		{
			foundinfraction("^1Warning: Player has perk specialty_specialgrenade in slot 1 and smoke grenades too.");
			var_0B[0] = "specialty_null";
		}
	}

	var_2A = 0;
	var_2B = 0;
	var_2C = 0;
	if(maps\mp\_utility::invirtuallobby())
	{
		var_2A = self.emblemloadout.emblemindex;
		var_2B = self.emblemloadout.shouldapplyemblemtoweapon;
		var_2C = self.emblemloadout.shouldapplyemblemtocharacter;
	}
	else
	{
		var_2A = self getplayerdata(common_scripts\utility::getstatsgroup_common(),"emblemPatchIndex");
		if(isai(self))
		{
			var_2B = self.pers["shouldApplyEmblemToWeapon"];
			var_2C = self.pers["shouldApplyEmblemToCharacter"];
		}
		else
		{
			var_2B = self getplayerdata(common_scripts\utility::getstatsgroup_common(),"applyEmblemToWeapon");
			var_2C = self getplayerdata(common_scripts\utility::getstatsgroup_common(),"applyEmblemToCharacter");
		}
	}

	var_2D = var_2A;
	if(!var_2B)
	{
		var_2D = -1;
	}

	var_2E = 0;
	if(maps\mp\_utility::invirtuallobby())
	{
		var_2E = self.charactercamoloadout.camoindex;
	}
	else
	{
		var_2E = self getplayerdata(common_scripts\utility::getstatsgroup_common(),"characterCamoIndex");
	}

	var_21 = spawnstruct();
	var_21.class = param_01;
	var_21.class_num = var_06;
	var_21.teamname = var_0D;
	var_21.clearammo = var_05;
	var_21.copycatloadout = var_0A;
	var_21.cacloadout = var_09;
	var_21.isgamemodeclass = var_0C;
	var_21.primary = var_0F;
	var_21.primaryattachkit = var_10;
	var_21.primaryfurniturekit = var_11;
	var_21.primarycamo = var_12;
	var_21.primaryreticle = var_13;
	var_12 = int(tablelookup("mp/camoTable.csv",1,var_21.primarycamo,0));
	var_13 = int(tablelookup("mp/reticleTable.csv",1,var_21.primaryreticle,0));
	var_21.primaryname = buildweaponname(var_21.primary,var_21.primaryattachkit,var_21.primaryfurniturekit,var_12,var_13,var_2D);
	var_21.secondary = var_14;
	var_21.secondaryattachkit = var_15;
	var_21.secondaryfurniturekit = var_16;
	var_21.secondarycamo = var_17;
	var_21.secondaryreticle = var_18;
	var_17 = int(tablelookup("mp/camoTable.csv",1,var_21.secondarycamo,0));
	var_18 = int(tablelookup("mp/reticleTable.csv",1,var_21.secondaryreticle,0));
	var_21.secondaryname = buildweaponname(var_21.secondary,var_21.secondaryattachkit,var_21.secondaryfurniturekit,var_17,var_18,var_2D);
	var_21.equipment = var_19;
	var_21.offhand = var_1A;
	var_21.perks = var_0B;
	var_21.meleeweapon = var_1C;
	if(var_1C != "none")
	{
		var_21.meleeweaponname = var_1C + "_mp_a#none_f#base";
	}
	else
	{
		var_21.meleeweaponname = var_1C;
	}

	var_21.setprimaryspawnweapon = param_03;
	var_21.emblemindex = var_2A;
	var_21.weaponemblemindex = var_2D;
	var_21.var_A7EC = var_2C;
	var_21.var_A7ED = var_2E;
	if(maps\mp\_utility::is_true(level.movecompareactive) && isdefined(level.movecompareloadoutfunc))
	{
		var_21 = self [[ level.movecompareloadoutfunc ]]();
	}

	return var_21;
}

//Function Number: 51
giveloadout(param_00,param_01,param_02,param_03)
{
	self.loadout = getloadout(param_00,param_01,param_02,param_03);
}

//Function Number: 52
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
	self.loadoutprimary = var_00.primary;
	self.loadoutprimarycamo = int(tablelookup("mp/camoTable.csv",1,var_00.primarycamo,0));
	self.loadoutsecondary = var_00.secondary;
	self.loadoutsecondarycamo = int(tablelookup("mp/camoTable.csv",1,var_00.secondarycamo,0));
	if(!issubstr(var_00.primary,"iw5") && !issubstr(var_00.primary,"h1_"))
	{
		self.loadoutprimarycamo = 0;
	}

	if(!issubstr(var_00.secondary,"iw5") && !issubstr(var_00.secondary,"h1_"))
	{
		self.loadoutsecondarycamo = 0;
	}

	self.loadoutprimaryreticle = int(tablelookup("mp/reticleTable.csv",1,var_00.primaryreticle,0));
	self.loadoutsecondaryreticle = int(tablelookup("mp/reticleTable.csv",1,var_00.secondaryreticle,0));
	if(!issubstr(var_00.primary,"iw5") && !issubstr(var_00.primary,"h1_"))
	{
		self.loadoutprimaryreticle = 0;
	}

	if(!issubstr(var_00.secondary,"iw5") && !issubstr(var_00.secondary,"h1_"))
	{
		self.loadoutsecondaryreticle = 0;
	}

	self.loadoutmelee = var_00.meleeweapon;
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

	var_01 = var_00.meleeweaponname;
	if(var_01 != "none")
	{
		maps\mp\_utility::_giveweapon(var_01);
	}

	var_02 = var_00.secondaryname;
	if(var_02 != "none")
	{
		maps\mp\_utility::_giveweapon(var_02);
		if(level.oldschool)
		{
			maps\mp\gametypes\_oldschool::givestartammooldschool(var_02);
		}
	}

	if(level.diehardmode)
	{
		maps\mp\_utility::giveperk("specialty_pistoldeath",0);
	}

	loadoutallperks(var_00);
	maps\mp\perks\_perks::applyperks();
	self setoffhandprimaryclass(var_00.equipment);
	if(var_00.equipment != "specialty_null" && self hasweapon(var_00.equipment))
	{
		var_03 = self getweaponammoclip(var_00.equipment);
		self setweaponammoclip(var_00.equipment,var_03 + 1);
	}
	else
	{
		giveoffhand(var_00.equipment);
	}

	if(var_00.equipment != "specialty_null" && isdefined(self.perkscustom["grenades_count"]))
	{
		var_04 = self.perkscustom["grenades_count"];
		self setweaponammoclip(var_00.equipment,var_04);
	}

	var_05 = var_00.primaryname;
	maps\mp\_utility::_giveweapon(var_05);
	if(level.oldschool)
	{
		maps\mp\gametypes\_oldschool::givestartammooldschool(var_05);
	}

	if(!isai(self) && !maps\mp\_utility::ishodgepodgemm())
	{
		self switchtoweapon(var_05);
	}

	if(var_00.setprimaryspawnweapon)
	{
		self setspawnweapon(maps\mp\_utility::get_spawn_weapon_name(var_00));
	}

	self.pers["primaryWeapon"] = maps\mp\_utility::getbaseweaponname(var_05);
	self.loadoutoffhand = var_00.offhand;
	self setoffhandsecondaryclass(var_00.offhand);
	if(!level.oldschool)
	{
		giveoffhand(var_00.offhand);
	}

	if(level.oldschool)
	{
		self setweaponammoclip(var_00.offhand,0);
	}

	if(var_00.offhand != "specialty_null" && isdefined(self.perkscustom["specialgrenades_count"]))
	{
		var_04 = self.perkscustom["specialgrenades_count"];
		self setweaponammoclip(var_00.offhand,var_04);
	}

	var_06 = var_05;
	self.primaryweapon = var_06;
	self.secondaryweapon = var_02;
	self.meleeweapon = var_01;
	if(var_00.clearammo)
	{
		self setweaponammoclip(self.primaryweapon,0);
		self setweaponammostock(self.primaryweapon,0);
	}

	self.issniper = weaponclass(self.primaryweapon) == "sniper";
	maps\mp\_utility::_setactionslot(1,"nightvision");
	maps\mp\perks\_perks::giveperkinventory();
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
		self givemaxammo(var_05);
		if(var_02 != "none")
		{
			self givemaxammo(var_02);
		}
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
		if(!isdefined(self.gamemode_carrierclass))
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
			if(isplayer(self))
			{
				self.costume = cao_getactivecostume();
			}
			else if(isagent(self) && self.agent_type == "player")
			{
				self.costume = maps\mp\gametypes\_teams::getdefaultcostume();
			}
		}

		if(maps\mp\_utility::invirtuallobby() && isdefined(level.vl_cac_getfactionteam) && isdefined(level.vl_cac_getfactionenvironment))
		{
			var_07 = [[ level.vl_cac_getfactionteam ]]();
			var_08 = [[ level.vl_cac_getfactionenvironment ]]();
			maps\mp\gametypes\_teams::applycostume(var_06,var_07,var_08);
		}
		else if(level.teambased)
		{
			maps\mp\gametypes\_teams::applycostume();
		}
		else
		{
			maps\mp\gametypes\_teams::applycostume(var_06,self.team);
		}

		logplayercostume();
		self method_857C(var_00.var_A7ED);
	}

	switch(weaponclass(var_06))
	{
		case "rifle":
			break;

		case "pistol":
			break;

		case "mg":
			break;

		case "smg":
			break;

		case "spread":
			break;

		default:
			break;
	}
}

//Function Number: 53
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
		var_04 = cao_getpercostumecategory("gloves",var_02);
		setmatchdata("players",self.clientid,"costume","gender",var_00);
		setmatchdata("players",self.clientid,"costume","head",var_01);
		setmatchdata("players",self.clientid,"costume","shirt",var_03);
		setmatchdata("players",self.clientid,"costume","gloves",var_04);
		self.costumelogged = 1;
	}
}

//Function Number: 54
giveandapplyloadout(param_00,param_01,param_02,param_03)
{
	giveloadout(param_00,param_01,param_02,param_03);
	applyloadout();
}

//Function Number: 55
givedefaultperks()
{
	self.spawnperk = 0;
	if(!maps\mp\_utility::_hasperk("specialty_blindeye") && self.avoidkillstreakonspawntimer > 0)
	{
		thread maps\mp\perks\_perks::giveblindeyeafterspawn();
	}
}

//Function Number: 56
recordvalidationinfraction()
{
	if(isdefined(self) && isdefined(self.pers) && isdefined(self.pers["validationInfractions"]))
	{
		self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
	}
}

//Function Number: 57
_detachall()
{
	self.frontshieldmodel = undefined;
	self.backshieldmodel = undefined;
	self.headmodel = undefined;
	self detachall();
}

//Function Number: 58
giveoffhand(param_00)
{
	var_01 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	switch(var_01)
	{
		case "specialty_null":
		case "none":
			break;

		case "h1_flashgrenade_mp":
		case "h1_concussiongrenade_mp":
		case "h1_smokegrenade_mp":
		case "h1_fraggrenade_mp":
			break;

		default:
			break;
	}
}

//Function Number: 59
takeoffhand(param_00)
{
	var_01 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	switch(var_01)
	{
		case "specialty_null":
		case "none":
			break;

		case "h1_flashgrenade_mp":
		case "h1_concussiongrenade_mp":
		case "h1_smokegrenade_mp":
		case "h1_fraggrenade_mp":
			break;

		default:
			break;
	}
}

//Function Number: 60
loadoutallperks(param_00)
{
	var_01 = param_00.perks;
	for(var_02 = 0;var_02 < 3;var_02++)
	{
		var_01[var_02] = maps\mp\perks\_perks::validateperk(var_02,var_01[var_02]);
	}

	for(var_02 = 0;var_02 < 3;var_02++)
	{
		var_03 = var_01[var_02];
		if(var_03 == "specialty_null")
		{
			continue;
		}

		maps\mp\_utility::giveperk(var_03,1,var_02);
		var_04 = var_02 + 1;
		var_05 = "specialty" + var_04;
		maps\mp\perks\_perks::get_specialtydata(var_03,var_05,param_00);
	}

	self.loadoutperks = var_01;
	self.loadoutequipment = param_00.equipment;
}

//Function Number: 61
isexoxmg(param_00)
{
	if(issubstr(param_00,"_exoxmg"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 62
issac3(param_00)
{
	if(issubstr(param_00,"sac3"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 63
ismahem(param_00)
{
	if(issubstr(param_00,"mahem"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 64
needsscopeoverride(param_00,param_01)
{
	var_02 = maps\mp\_utility::getweaponclass(param_00) == "weapon_sniper";
	if(var_02 && !anyattachmentisscope(param_01) && !issubstr(param_00,"h1_"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 65
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

//Function Number: 66
addautomaticattachments(param_00,param_01)
{
	var_02 = [];
	var_03 = maps\mp\_utility::getbaseweaponname(param_00);
	if(needsscopeoverride(var_03,param_01))
	{
		var_04 = var_03;
		if(issubstr(var_03,"iw5_") || issubstr(var_03,"iw6_") || issubstr(var_03,"h1_"))
		{
			var_05 = var_03.size;
			var_04 = getsubstr(var_03,4,var_05);
		}

		var_06 = getbasefromlootversion(var_04) + "scope";
		var_02[var_02.size] = var_06;
	}

	return var_02;
}

//Function Number: 67
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

//Function Number: 68
array_checkaddattachment(param_00,param_01)
{
	if(isdefined(param_01) && param_01 != "none")
	{
		param_00[param_00.size] = param_01;
	}

	return param_00;
}

//Function Number: 69
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

//Function Number: 70
buildweaponname(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_00) || param_00 == "none" || param_00 == "")
	{
		return param_00;
	}

	if(!isdefined(level.lettertonumber))
	{
		level.lettertonumber = makeletterstonumbers();
	}

	var_06 = "";
	if(issubstr(param_00,"iw5_") || issubstr(param_00,"h1_"))
	{
		var_07 = param_00 + "_mp";
		var_08 = param_00.size;
		if(issubstr(param_00,"h1_"))
		{
			var_06 = getsubstr(param_00,3,var_08);
		}
		else
		{
			var_06 = getsubstr(param_00,4,var_08);
		}
	}
	else
	{
		var_07 = param_01;
		var_06 = param_00;
	}

	if(var_07 == "h1_junsho_mp")
	{
		param_01 = "akimbohidden";
	}

	var_09 = isdefined(param_01) && param_01 != "none";
	var_0A = isdefined(param_02) && param_02 != "none";
	if(!var_0A)
	{
		var_0B = tablelookuprownum("mp/furniturekits/base.csv",0,var_07);
		if(var_0B >= 0)
		{
			param_02 = "base";
			var_0A = 1;
		}
	}

	if(var_09 || var_0A)
	{
		if(!var_09)
		{
			param_01 = "none";
		}

		if(!var_0A)
		{
			param_02 = "base";
		}

		var_07 = var_07 + "_a#" + param_01;
		var_07 = var_07 + "_f#" + param_02;
	}

	if(issubstr(var_07,"iw5_") || issubstr(var_07,"h1_"))
	{
		var_07 = buildweaponnamereticle(var_07,param_04);
		var_07 = buildweaponnameemblem(var_07,param_05);
		var_07 = buildweaponnamecamo(var_07,param_03);
		return var_07;
	}

	if(!isvalidweapon(var_07 + "_mp"))
	{
		return param_00 + "_mp";
	}

	var_07 = buildweaponnamereticle(var_07,param_04);
	var_07 = buildweaponnameemblem(var_07,param_05);
	var_07 = buildweaponnamecamo(var_07,param_03);
	return var_07 + "_mp";
}

//Function Number: 71
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
		param_00 = param_00 + "_camo00";
	}
	else if(param_01 < 100)
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

//Function Number: 72
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

//Function Number: 73
buildweaponnameemblem(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return param_00;
	}

	if(param_01 < 0)
	{
		return param_00;
	}

	param_00 = param_00 + "_emblem";
	param_00 = param_00 + param_01 + 1;
	return param_00;
}

//Function Number: 74
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

//Function Number: 75
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
		if(var_04 == "h1_claymore_mp" || var_04 == "claymore_detonator_mp")
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

//Function Number: 76
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

//Function Number: 77
fadeaway(param_00,param_01)
{
	wait(param_00);
	self fadeovertime(param_01);
	self.alpha = 0;
}

//Function Number: 78
setclass(param_00)
{
	self.curclass = param_00;
}

//Function Number: 79
clearcopycatloadout()
{
	self.pers["copyCatLoadout"]["inUse"] = 0;
}

//Function Number: 80
foundinfraction(param_00)
{
	recordvalidationinfraction();
}

//Function Number: 81
isdefaultunlocked()
{
	if(maps\mp\_utility::ismlgmatch())
	{
		return 1;
	}

	return 0;
}

//Function Number: 82
isvalidprimary(param_00,param_01)
{
	if(maps\mp\_utility::islootweapon(param_00))
	{
		param_00 = getbasefromlootversion(param_00);
	}

	switch(param_00)
	{
		case "h1_junsnp":
		case "h1_febsnp":
		case "h1_remington700":
		case "h1_m40a3":
		case "h1_m21":
		case "h1_dragunov":
		case "h1_barrett":
		case "h1_junlmg":
		case "h1_feblmg":
		case "h1_saw":
		case "h1_rpd":
		case "h1_m60e4":
		case "h1_junsho":
		case "h1_kam12":
		case "h1_winchester1200":
		case "h1_m1014":
		case "h1_augsmg":
		case "h1_aprsmg":
		case "h1_febsmg":
		case "h1_uzi":
		case "h1_skorpion":
		case "h1_p90":
		case "h1_mp5":
		case "h1_ak74u":
		case "h1_augast":
		case "h1_aprast":
		case "h1_xmlar":
		case "h1_mp44":
		case "h1_m4":
		case "h1_m16":
		case "h1_m14":
		case "h1_g36c":
		case "h1_g3":
		case "h1_ak47":
			break;

		default:
			break;
	}
}

//Function Number: 83
isvalidsecondary(param_00,param_01,param_02)
{
	if(maps\mp\_utility::is_true(param_01))
	{
		return isvalidprimary(param_00);
	}

	if(maps\mp\_utility::islootweapon(param_00))
	{
		param_00 = getbasefromlootversion(param_00);
	}

	switch(param_00)
	{
		case "h1_rpg":
		case "h1_augpst":
		case "h1_aprpst":
		case "h1_janpst":
		case "h1_usp":
		case "h1_deserteagle55":
		case "h1_deserteagle":
		case "h1_colt45":
		case "h1_beretta":
		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 84
isvalidattachment(param_00,param_01,param_02)
{
	var_03 = 0;
	switch(param_00)
	{
		case "xmagmwr":
		case "varzoommwr":
		case "thermalmwr":
		case "reflexvarmwr":
		case "longbarrelmwr":
		case "holosightmwr":
		case "heartbeatmwr":
		case "akimbomwr":
		case "silencermwr":
		case "reflexmwr":
		case "gripmwr":
		case "acogmwr":
		case "silencersniper":
		case "silencerpistol":
		case "crossbowscopebase":
		case "rw1scopebase":
		case "heatsink":
		case "stabilizer":
		case "trackrounds":
		case "thorscopevz":
		case "lasersight":
		case "quickdraw":
		case "longrange":
		case "firerate":
		case "opticstargetenhancer":
		case "variablereddot":
		case "foregrip":
		case "sensorheartbeat":
		case "silencer01":
		case "opticsthermal":
		case "opticseotech":
		case "opticsacog2":
		case "opticsreddot":
		case "parabolicmicrophone":
		case "hybrid":
		case "hamrhybrid":
		case "scopevz":
		case "tactical":
		case "eotechlmg":
		case "eotechsmg":
		case "eotech":
		case "dualmag":
		case "xmags":
		case "rof":
		case "fmj":
		case "heartbeat":
		case "thermalsmg":
		case "m320":
		case "gp25":
		case "grip":
		case "silencer03":
		case "silencer02":
		case "silencer":
		case "reflexlmg":
		case "reflexsmg":
		case "reflex":
		case "acogsmg":
		case "acog":
		case "ironsights":
		case "zoomscope":
		case "akimbo":
		case "tacknifemwr":
		case "masterkeypremwr":
		case "glpremwr":
		case "masterkeymwr":
		case "glmwr":
		case "gl":
		case "shotgun":
		case "stock":
		case "thermal":
		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 85
isattachmentunlocked(param_00,param_01)
{
	if(isdefaultunlocked())
	{
		return 1;
	}

	var_02 = getbasefromlootversion(param_00);
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
		case "wc_super_reward":
		case "wc_super_07":
		case "wc_super_06":
		case "wc_super_05":
		case "wc_super_04":
		case "wc_super_03":
		case "wc_super_02":
		case "wc_super_01":
		case "wc_tomahawk_reward":
		case "wc_tomahawk_07":
		case "wc_tomahawk_06":
		case "wc_tomahawk_05":
		case "wc_tomahawk_04":
		case "wc_tomahawk_03":
		case "wc_tomahawk_02":
		case "wc_tomahawk_01":
		case "wc_sweettooth_reward":
		case "wc_sweettooth_07":
		case "wc_sweettooth_06":
		case "wc_sweettooth_05":
		case "wc_sweettooth_04":
		case "wc_sweettooth_03":
		case "wc_sweettooth_02":
		case "wc_sweettooth_01":
		case "wc_cosmos_reward":
		case "wc_cosmos_07":
		case "wc_cosmos_06":
		case "wc_cosmos_05":
		case "wc_cosmos_04":
		case "wc_cosmos_03":
		case "wc_cosmos_02":
		case "wc_cosmos_01":
		case "wc_dangerclose_01":
		case "wc_barber_01":
		case "wc_enforce_01":
		case "wc_specops_01":
		case "wc_firedrake_01":
		case "wc_urbanoperator_01":
		case "wc_ghillie_01":
		case "wc_obsidian_01":
		case "wc_elder_01":
		case "wc_centermass_01":
		case "wc_br9_01":
		case "wc_pkpsd9_01":
		case "wc_lynxcq300_01":
		case "wc_ranger_02":
		case "wc_ranger_01":
		case "wc_summer_04":
		case "wc_summer_03":
		case "wc_summer_02":
		case "wc_summer_01":
		case "wc_burnt_reward":
		case "wc_burnt_07":
		case "wc_burnt_06":
		case "wc_burnt_05":
		case "wc_burnt_04":
		case "wc_burnt_03":
		case "wc_burnt_02":
		case "wc_burnt_01":
		case "wc_iris_reward":
		case "wc_iris_07":
		case "wc_iris_06":
		case "wc_iris_05":
		case "wc_iris_04":
		case "wc_iris_03":
		case "wc_iris_02":
		case "wc_iris_01":
		case "wc_texture_reward":
		case "wc_texture_07":
		case "wc_texture_06":
		case "wc_texture_05":
		case "wc_texture_04":
		case "wc_texture_03":
		case "wc_texture_02":
		case "wc_texture_01":
		case "wc_pixel_reward":
		case "wc_pixel_07":
		case "wc_pixel_06":
		case "wc_pixel_05":
		case "wc_pixel_04":
		case "wc_pixel_03":
		case "wc_pixel_02":
		case "wc_pixel_01":
		case "wc_flow_reward":
		case "wc_flow_07":
		case "wc_flow_06":
		case "wc_flow_05":
		case "wc_flow_04":
		case "wc_flow_03":
		case "wc_flow_02":
		case "wc_flow_01":
		case "wc_foliage_reward":
		case "wc_foliage_07":
		case "wc_foliage_06":
		case "wc_foliage_05":
		case "wc_foliage_04":
		case "wc_foliage_03":
		case "wc_foliage_02":
		case "wc_foliage_01":
		case "wc_bludgeon_01":
		case "wc_tribal_01":
		case "wc_relic_01":
		case "wc_reaper_01":
		case "wc_neanderthal_01":
		case "wc_liquidator_01":
		case "wc_mudder_01":
		case "wc_don_01":
		case "wc_masterpiece_01":
		case "wc_glacier_01":
		case "wc_blackout_01":
		case "wc_grisly_01":
		case "wc_slate_01":
		case "wc_warscarred_01":
		case "wc_wolfen_01":
		case "wc_beredmk8_01":
		case "wc_stac330_01":
		case "wc_pyrotechnic_01":
		case "wc_celebration_01":
		case "wc_nauticus_01":
		case "wc_summertime_01":
		case "wc_operator_reward":
		case "wc_operator_07":
		case "wc_operator_06":
		case "wc_operator_05":
		case "wc_operator_04":
		case "wc_operator_03":
		case "wc_operator_02":
		case "wc_operator_01":
		case "wc_geist_reward":
		case "wc_geist_07":
		case "wc_geist_06":
		case "wc_geist_05":
		case "wc_geist_04":
		case "wc_geist_03":
		case "wc_geist_02":
		case "wc_geist_01":
		case "wc_rebel_reward":
		case "wc_rebel_07":
		case "wc_rebel_06":
		case "wc_rebel_05":
		case "wc_rebel_04":
		case "wc_rebel_03":
		case "wc_rebel_02":
		case "wc_rebel_01":
		case "wc_hightech_reward":
		case "wc_hightech_07":
		case "wc_hightech_06":
		case "wc_hightech_05":
		case "wc_hightech_04":
		case "wc_hightech_03":
		case "wc_hightech_02":
		case "wc_hightech_01":
		case "wc_prokolot_01":
		case "wc_fang45_01":
		case "wc_bos14_01":
		case "wc_sawtooth_01":
		case "wc_caveman_01":
		case "wc_diabolical_01":
		case "wc_battletested_01":
		case "wc_tacticalfighter_01":
		case "wc_kingfish_01":
		case "wc_fieldtested_01":
		case "wc_urbanwarfare_01":
		case "wc_phalanx_01":
		case "wc_highnoon_01":
		case "wc_stpatty_02":
		case "wc_stpatty_01":
		case "wc_leprechaun_01":
		case "wc_wartorn_01":
		case "wc_venom_01":
		case "wc_ultraviolet_01":
		case "wc_titanium_01":
		case "wc_samurai_01":
		case "wc_reptile_reward":
		case "wc_reptile_07":
		case "wc_reptile_06":
		case "wc_reptile_05":
		case "wc_reptile_04":
		case "wc_reptile_03":
		case "wc_reptile_02":
		case "wc_reptile_01":
		case "wc_reflex_01":
		case "wc_pkm_01":
		case "wc_pigpen_01":
		case "wc_noobtuber_01":
		case "wc_minerva_reward":
		case "wc_minerva_07":
		case "wc_minerva_06":
		case "wc_minerva_05":
		case "wc_minerva_04":
		case "wc_minerva_03":
		case "wc_minerva_02":
		case "wc_minerva_01":
		case "wc_mechanic_01":
		case "wc_mastercraft_01":
		case "wc_mac10_01":
		case "wc_kingpin_01":
		case "wc_killshot_01":
		case "wc_graves_01":
		case "wc_frag_01":
		case "wc_exlibris_reward":
		case "wc_exlibris_07":
		case "wc_exlibris_06":
		case "wc_exlibris_05":
		case "wc_exlibris_04":
		case "wc_exlibris_03":
		case "wc_exlibris_02":
		case "wc_exlibris_01":
		case "wc_etch_reward":
		case "wc_etch_07":
		case "wc_etch_06":
		case "wc_etch_05":
		case "wc_etch_04":
		case "wc_etch_03":
		case "wc_etch_02":
		case "wc_etch_01":
		case "wc_dmr25s_01":
		case "wc_decay_reward":
		case "wc_decay_07":
		case "wc_decay_06":
		case "wc_decay_05":
		case "wc_decay_04":
		case "wc_decay_03":
		case "wc_decay_02":
		case "wc_decay_01":
		case "wc_challenger_01":
		case "wc_chalk_01":
		case "wc_boss_01":
		case "wc_avalanche_01":
		case "wc_amoeba_reward":
		case "wc_amoeba_07":
		case "wc_amoeba_06":
		case "wc_amoeba_05":
		case "wc_amoeba_04":
		case "wc_amoeba_03":
		case "wc_amoeba_02":
		case "wc_amoeba_01":
		case "wc_arcticwolf_01":
		case "wc_xmlar_01":
		case "wc_magnum_01":
		case "wc_lawman_01":
		case "wc_kamchatka12_01":
		case "wc_huntsman_01":
		case "wc_hunter_reward":
		case "wc_hunter_07":
		case "wc_hunter_06":
		case "wc_hunter_05":
		case "wc_hunter_04":
		case "wc_hunter_03":
		case "wc_hunter_02":
		case "wc_hunter_01":
		case "wc_hatchetman_01":
		case "wc_gladiator_01":
		case "wc_funhouse_reward":
		case "wc_funhouse_07":
		case "wc_funhouse_06":
		case "wc_funhouse_05":
		case "wc_funhouse_04":
		case "wc_funhouse_03":
		case "wc_funhouse_02":
		case "wc_funhouse_01":
		case "wc_diablo_reward":
		case "wc_diablo_07":
		case "wc_diablo_06":
		case "wc_diablo_05":
		case "wc_diablo_04":
		case "wc_diablo_03":
		case "wc_diablo_02":
		case "wc_diablo_01":
		case "wc_czar_01":
		case "wc_battlescarred_01":
		case "wc_aftermath_reward":
		case "wc_aftermath_07":
		case "wc_aftermath_06":
		case "wc_aftermath_05":
		case "wc_aftermath_04":
		case "wc_aftermath_03":
		case "wc_aftermath_02":
		case "wc_aftermath_01":
		case "wcamo_code":
		case "camo089":
		case "camo088":
		case "camo087":
		case "camo086":
		case "camo085":
		case "camo084":
		case "camo083":
		case "camo082":
		case "camo081":
		case "camo080":
		case "camo079":
		case "camo078":
		case "camo077":
		case "camo076":
		case "camo075":
		case "camo074":
		case "camo073":
		case "camo072":
		case "camo071":
		case "camo070":
		case "camo069":
		case "camo068":
		case "camo067":
		case "camo066":
		case "camo065":
		case "camo064":
		case "camo063":
		case "camo062":
		case "camo061":
		case "camo060":
		case "camo059":
		case "camo058":
		case "camo057":
		case "camo056":
		case "camo055":
		case "camo054":
		case "camo053":
		case "camo052":
		case "camo051":
		case "camo050":
		case "camo049":
		case "camo048":
		case "camo047":
		case "camo046":
		case "camo045":
		case "camo044":
		case "camo043":
		case "camo042":
		case "camo041":
		case "camo040":
		case "camo039":
		case "camo038":
		case "camo037":
		case "camo036":
		case "camo035":
		case "camo034":
		case "camo033":
		case "camo032":
		case "camo031":
		case "camo030":
		case "camo029":
		case "camo028":
		case "camo027":
		case "camo026":
		case "camo025":
		case "camo024":
		case "camo023":
		case "camo022":
		case "camo021":
		case "camo020":
		case "camo019":
		case "camo018":
		case "camo017":
		case "camo016":
		case "darkmatter":
		case "diamond":
		case "neontiger":
		case "nickel":
		case "fde":
		case "odgreen":
		case "redhex":
		case "redtiger":
		case "bluetiger":
		case "digital":
		case "gold":
		case "woodland":
		case "desert":
		case "white":
		case "none":
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
		case "ret_wildcard_reward":
		case "ret_wildcard_07":
		case "ret_wildcard_06":
		case "ret_wildcard_05":
		case "ret_wildcard_04":
		case "ret_wildcard_03":
		case "ret_wildcard_02":
		case "ret_wildcard_01":
		case "ret_monarch2_reward":
		case "ret_monarch2_07":
		case "ret_monarch2_06":
		case "ret_monarch2_05":
		case "ret_monarch2_04":
		case "ret_monarch2_03":
		case "ret_monarch2_02":
		case "ret_monarch2_01":
		case "ret_dangerclose_01":
		case "ret_barber_01":
		case "ret_enforce_01":
		case "ret_specops_01":
		case "ret_firedrake_01":
		case "ret_urbanoperator_01":
		case "ret_ghillie_01":
		case "ret_obsidian_01":
		case "ret_elder_01":
		case "ret_centermass_01":
		case "ret_pkpsd9_01":
		case "ret_lynxcq300_01":
		case "ret_phantasm_reward":
		case "ret_phantasm_07":
		case "ret_phantasm_06":
		case "ret_phantasm_05":
		case "ret_phantasm_04":
		case "ret_phantasm_03":
		case "ret_phantasm_02":
		case "ret_phantasm_01":
		case "ret_interrupt_reward":
		case "ret_interrupt_07":
		case "ret_interrupt_06":
		case "ret_interrupt_05":
		case "ret_interrupt_04":
		case "ret_interrupt_03":
		case "ret_interrupt_02":
		case "ret_interrupt_01":
		case "ret_monarch_reward":
		case "ret_monarch_07":
		case "ret_monarch_06":
		case "ret_monarch_05":
		case "ret_monarch_04":
		case "ret_monarch_03":
		case "ret_monarch_02":
		case "ret_monarch_01":
		case "ret_subdivision_reward":
		case "ret_subdivision_07":
		case "ret_subdivision_06":
		case "ret_subdivision_05":
		case "ret_subdivision_04":
		case "ret_subdivision_03":
		case "ret_subdivision_02":
		case "ret_subdivision_01":
		case "ret_bludgeon_01":
		case "ret_tribal_01":
		case "ret_reaper_01":
		case "ret_neanderthal_01":
		case "ret_liquidator_01":
		case "ret_mudder_01":
		case "ret_don_01":
		case "ret_masterpiece_01":
		case "ret_glacier_01":
		case "ret_blackout_01":
		case "ret_grisly_01":
		case "ret_slate_01":
		case "ret_warscarred_01":
		case "ret_wolfen_01":
		case "ret_beredmk8_01":
		case "ret_stac330_01":
		case "ret_pyrotechnic_01":
		case "ret_celebration_01":
		case "ret_nauticus_01":
		case "ret_summertime_01":
		case "ret_facet_reward":
		case "ret_facet_07":
		case "ret_facet_06":
		case "ret_facet_05":
		case "ret_facet_04":
		case "ret_facet_03":
		case "ret_facet_02":
		case "ret_facet_01":
		case "ret_focal_reward":
		case "ret_focal_07":
		case "ret_focal_06":
		case "ret_focal_05":
		case "ret_focal_04":
		case "ret_focal_03":
		case "ret_focal_02":
		case "ret_focal_01":
		case "ret_phalanx_01":
		case "ret_fang45_01":
		case "ret_bos14_01":
		case "ret_sawtooth_01":
		case "ret_caveman_01":
		case "ret_diabolical_01":
		case "ret_battletested_01":
		case "ret_tacticalfighter_01":
		case "ret_kingfish_01":
		case "ret_fieldtested_01":
		case "ret_urbanwarfare_01":
		case "ret_highnoon_01":
		case "ret_leprechaun_01":
		case "ret_wartorn_01":
		case "ret_vortex_reward":
		case "ret_vortex_07":
		case "ret_vortex_06":
		case "ret_vortex_05":
		case "ret_vortex_04":
		case "ret_vortex_03":
		case "ret_vortex_02":
		case "ret_vortex_01":
		case "ret_venom_01":
		case "ret_ultraviolet_01":
		case "ret_titanium_01":
		case "ret_samurai_01":
		case "ret_reflex_01":
		case "ret_pkm_01":
		case "ret_pigpen_01":
		case "ret_noobtuber_01":
		case "ret_mechanic_01":
		case "ret_mastercraft_01":
		case "ret_mac10_01":
		case "ret_kingpin_01":
		case "ret_killshot_01":
		case "ret_ironsmith_reward":
		case "ret_ironsmith_07":
		case "ret_ironsmith_06":
		case "ret_ironsmith_05":
		case "ret_ironsmith_04":
		case "ret_ironsmith_03":
		case "ret_ironsmith_02":
		case "ret_ironsmith_01":
		case "ret_graves_01":
		case "ret_frag_01":
		case "ret_dmr25s_01":
		case "ret_challenger_01":
		case "ret_chalk_01":
		case "ret_bent_reward":
		case "ret_bent_07":
		case "ret_bent_06":
		case "ret_bent_05":
		case "ret_bent_04":
		case "ret_bent_03":
		case "ret_bent_02":
		case "ret_bent_01":
		case "ret_avalanche_01":
		case "ret_angle_reward":
		case "ret_angle_07":
		case "ret_angle_06":
		case "ret_angle_05":
		case "ret_angle_04":
		case "ret_angle_03":
		case "ret_angle_02":
		case "ret_angle_01":
		case "ret121":
		case "ret120":
		case "ret118":
		case "ret117":
		case "ret116":
		case "ret115":
		case "ret114":
		case "ret108":
		case "ret107":
		case "ret106":
		case "ret105":
		case "ret104":
		case "ret103":
		case "ret102":
		case "ret101":
		case "ret100":
		case "ret097":
		case "ret096":
		case "ret095":
		case "ret094":
		case "ret091":
		case "ret089":
		case "ret086":
		case "ret085":
		case "ret081":
		case "ret080":
		case "ret078":
		case "ret077":
		case "ret076":
		case "ret075":
		case "ret074":
		case "ret073":
		case "ret072":
		case "ret071":
		case "ret070":
		case "ret069":
		case "ret068":
		case "ret067":
		case "ret066":
		case "ret065":
		case "ret064":
		case "ret063":
		case "ret062":
		case "ret061":
		case "ret060":
		case "ret059":
		case "ret058":
		case "ret057":
		case "ret056":
		case "ret055":
		case "ret054":
		case "ret053":
		case "ret052":
		case "ret051":
		case "ret050":
		case "ret049":
		case "ret048":
		case "ret047":
		case "ret046":
		case "ret045":
		case "ret044":
		case "ret043":
		case "ret042":
		case "ret041":
		case "ret038":
		case "ret037":
		case "ret036":
		case "ret035":
		case "ret034":
		case "ret033":
		case "ret032":
		case "ret031":
		case "ret030":
		case "ret028":
		case "ret027":
		case "ret026":
		case "ret025":
		case "ret024":
		case "ret021":
		case "ret019":
		case "ret018":
		case "ret017":
		case "ret016":
		case "ret014":
		case "ret013":
		case "ret012":
		case "ret011":
		case "ret010":
		case "ret009":
		case "ret008":
		case "ret007":
		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 88
isattachkitunlocked(param_00,param_01)
{
	if(isdefaultunlocked())
	{
		return 1;
	}

	var_02 = tablelookup("mp/attachkits.csv",1,param_01,7);
	if(!self isitemunlocked(var_02))
	{
		return 0;
	}

	var_03 = getbasefromlootversion(param_00);
	var_04 = var_03 + " " + param_01;
	if(!self isitemunlocked(var_04))
	{
		return 0;
	}

	return 1;
}

//Function Number: 89
isvalidattachkit(param_00,param_01,param_02)
{
	if(param_00 == "none")
	{
		return 1;
	}

	var_03 = function_0304("mp/attachkits.csv",1,param_00);
	if(var_03 <= 0)
	{
		if(maps\mp\_utility::is_true(param_02))
		{
			foundinfraction("Replacing invalid attachKit " + param_00);
		}

		return 0;
	}

	if(param_01 == "h1_mp44" || param_01 == "h1_deserteagle" || param_01 == "h1_deserteagle55")
	{
		var_04 = tablelookupbyrow("mp/attachkits.csv",var_03,7);
		var_05 = getinventoryitemtype(var_04);
		if(var_05 == "default")
		{
			if(maps\mp\_utility::is_true(param_02))
			{
				foundinfraction("Replacing invalid attachKit " + param_00);
			}

			return 0;
		}
	}

	var_06 = tablelookupbyrow("mp/attachkits.csv",var_03,6);
	if(var_06 == "")
	{
		return 1;
	}

	var_07 = maps\mp\_utility::getweaponclass(param_01);
	var_08 = "";
	switch(var_07)
	{
		case "weapon_assault":
			break;

		case "weapon_smg":
			break;

		case "weapon_heavy":
		case "weapon_lmg":
			break;

		case "weapon_sniper":
			break;

		case "weapon_shotgun":
			break;

		case "weapon_pistol":
			break;

		default:
			break;
	}
}

//Function Number: 90
isfurniturekitunlocked(param_00,param_01)
{
	if(isdefaultunlocked())
	{
		return 1;
	}

	var_02 = function_0303("mp/furniturekits.csv",1,param_01,2);
	if(!self isitemunlocked(var_02))
	{
		return 0;
	}

	return 1;
}

//Function Number: 91
isvalidfurniturekit(param_00,param_01,param_02)
{
	var_03 = function_0304("mp/furniturekits.csv",1,param_00,0);
	if(var_03 < 0)
	{
		if(maps\mp\_utility::is_true(param_02))
		{
			foundinfraction("Replacing invalid furnitureKit " + param_00);
		}

		return 0;
	}

	var_04 = tablelookupbyrow("mp/furniturekits.csv",var_03,6);
	if(var_04 == "")
	{
		return 0;
	}

	var_05 = maps\mp\_utility::getweaponclass(param_01);
	var_06 = "";
	switch(var_05)
	{
		case "weapon_assault":
			break;

		case "weapon_smg":
			break;

		case "weapon_heavy":
		case "weapon_lmg":
			break;

		case "weapon_sniper":
			break;

		case "weapon_shotgun":
			break;

		case "weapon_pistol":
			break;

		default:
			break;
	}
}

//Function Number: 92
iscamounlocked(param_00,param_01,param_02,param_03)
{
	if(isdefaultunlocked())
	{
		return 1;
	}

	var_04 = getbasefromlootversion(param_00);
	var_05 = var_04 + " " + param_01;
	if(!maps\mp\_utility::invirtuallobby())
	{
		if(!self isitemunlocked(var_05,param_02))
		{
			return 0;
		}
	}
	else if(!self isitemunlocked(var_05,param_02,param_03))
	{
		return 0;
	}

	return 1;
}

//Function Number: 93
isperkequipment(param_00)
{
	var_01 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	switch(var_01)
	{
		case "h1_c4_mp":
		case "h1_claymore_mp":
			break;

		default:
			break;
	}
}

//Function Number: 94
isperkprimary(param_00)
{
	var_01 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	switch(var_01)
	{
		case "h1_rpg_mp":
			break;

		default:
			break;
	}
}

//Function Number: 95
isvalidequipment(param_00,param_01)
{
	param_00 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	switch(param_00)
	{
		case "h1_fraggrenade_mp":
		case "specialty_null":
			break;

		default:
			break;
	}
}

//Function Number: 96
isvalidoffhand(param_00,param_01)
{
	param_00 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
	switch(param_00)
	{
		case "h1_flashgrenade_mp":
		case "h1_concussiongrenade_mp":
		case "h1_smokegrenade_mp":
		case "specialty_null":
		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 97
isvalidweapon(param_00,param_01)
{
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

	if(maps\mp\_utility::is_true(param_01))
	{
		foundinfraction("Replacing invalid weapon/attachment combo: " + param_00);
	}

	return 0;
}

//Function Number: 98
isvalidkillstreak(param_00,param_01)
{
	switch(param_00)
	{
		case "uav":
		case "none":
			break;

		default:
			break;
	}
}

//Function Number: 99
isgrenadelauncher(param_00)
{
	var_01 = maps\mp\_utility::getbasearrayforattachkit(param_00);
	foreach(var_03 in var_01)
	{
		if(var_03 == "glmwr")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 100
isgrip(param_00)
{
	var_01 = maps\mp\_utility::getbasearrayforattachkit(param_00);
	foreach(var_03 in var_01)
	{
		if(var_03 == "gripmwr")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 101
isvalidmeleeweapon(param_00,param_01)
{
	switch(param_00)
	{
		case "h1_meleeaug4":
		case "h1_meleeaug3":
		case "h1_meleeaug2":
		case "h1_meleeaug1":
		case "h1_meleejun6":
		case "h1_meleejun5":
		case "h1_meleejun4":
		case "h1_meleejun3":
		case "h1_meleejun2":
		case "h1_meleejun1":
		case "h1_meleeapr4":
		case "h1_meleeapr3":
		case "h1_meleeapr2":
		case "h1_meleeapr1":
		case "h1_meleefeb5":
		case "h1_meleefeb4":
		case "h1_meleefeb3":
		case "h1_meleefeb2":
		case "h1_meleefeb1":
		case "h1_meleehatchet":
		case "h1_meleesickle":
		case "h1_meleegladius":
		case "h1_meleebayonet":
		case "h1_meleeicepick":
		case "h1_meleeblade":
		case "h1_meleebottle":
		case "h1_meleepaddle":
		case "h1_meleeshovel":
		case "none":
			break;

		default:
			break;
	}
}