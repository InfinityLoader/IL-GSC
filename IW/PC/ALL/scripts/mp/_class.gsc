/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_class.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 125
 * Decompile Time: 8476 ms
 * Timestamp: 10/27/2023 12:14:51 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_400C["class0"] = 0;
	level.var_400C["class1"] = 1;
	level.var_400C["class2"] = 2;
	level.var_400C["custom1"] = 0;
	level.var_400C["custom2"] = 1;
	level.var_400C["custom3"] = 2;
	level.var_400C["custom4"] = 3;
	level.var_400C["custom5"] = 4;
	level.var_400C["custom6"] = 5;
	level.var_400C["custom7"] = 6;
	level.var_400C["custom8"] = 7;
	level.var_400C["custom9"] = 8;
	level.var_400C["custom10"] = 9;
	level.var_400C["axis_recipe1"] = 0;
	level.var_400C["axis_recipe2"] = 1;
	level.var_400C["axis_recipe3"] = 2;
	level.var_400C["axis_recipe4"] = 3;
	level.var_400C["axis_recipe5"] = 4;
	level.var_400C["axis_recipe6"] = 5;
	level.var_400C["allies_recipe1"] = 0;
	level.var_400C["allies_recipe2"] = 1;
	level.var_400C["allies_recipe3"] = 2;
	level.var_400C["allies_recipe4"] = 3;
	level.var_400C["allies_recipe5"] = 4;
	level.var_400C["allies_recipe6"] = 5;
	level.var_400C["gamemode"] = 0;
	level.var_400C["callback"] = 0;
	level.var_400C["default1"] = 0;
	level.var_400C["default2"] = 1;
	level.var_400C["default3"] = 2;
	level.var_400C["default4"] = 3;
	level.var_400C["default5"] = 4;
	level.var_5034 = "CLASS_ASSAULT";
	level.var_4010 = "mp/classTable.csv";
	level thread func_C572();
}

//Function Number: 2
func_7E2A(param_00)
{
	return param_00;
}

//Function Number: 3
func_821E(param_00)
{
	var_01 = strtok(param_00,",");
	if(var_01.size > 1)
	{
		return int(var_01[1]);
	}

	return 0;
}

//Function Number: 4
func_3689(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"weaponSetups",param_01,"weapon");
}

//Function Number: 5
func_368A(param_00,param_01,param_02)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"weaponSetups",param_01,"attachment",param_02);
}

//Function Number: 6
func_3692(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"weaponSetups",param_01,"lootItemID");
}

//Function Number: 7
func_3695(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"weaponSetups",param_01,"variantID");
}

//Function Number: 8
func_3691(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"weaponSetups",param_01,"camo");
}

//Function Number: 9
func_3694(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"weaponSetups",param_01,"reticle");
}

//Function Number: 10
func_367B(param_00)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","killstreakSetups",param_00,"killstreak");
}

//Function Number: 11
func_3676()
{
	if(isdefined(self.var_3C56))
	{
		return self.var_3C56.var_2123;
	}

	return self getplayerdata(level.var_AEA6,"squadMembers","archetype");
}

//Function Number: 12
func_3682(param_00)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"powerSetups",0,"power");
}

//Function Number: 13
func_3678(param_00)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"powerSetups",0,"extraCharge");
}

//Function Number: 14
func_3684(param_00)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"powerSetups",1,"power");
}

//Function Number: 15
func_3679(param_00)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"powerSetups",1,"extraCharge");
}

//Function Number: 16
func_3683(param_00)
{
	var_01 = self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"powerSetups",0,"lootItemID");
	return scripts\mp\_powerloot::func_804B(var_01);
}

//Function Number: 17
func_3685(param_00)
{
	var_01 = self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"powerSetups",1,"lootItemID");
	return scripts\mp\_powerloot::func_804B(var_01);
}

//Function Number: 18
func_3688()
{
	if(isdefined(self.var_3C56))
	{
		return self.var_3C56.var_11234;
	}

	return self getplayerdata(level.var_AEA6,"squadMembers","archetypeSuper");
}

//Function Number: 19
func_367A()
{
	var_00 = "none";
	if(isdefined(self.var_3C56))
	{
		var_01 = level.var_2127[self.var_3C56.var_2123];
		if(level.rankedmatch)
		{
			var_00 = self getplayerdata("rankedloadouts","squadMembers","archetypePreferences",var_01,"gesture");
		}
		else
		{
			var_00 = self getplayerdata("privateloadouts","squadMembers","archetypePreferences",var_01,"gesture");
		}
	}
	else if(level.rankedmatch)
	{
		var_00 = self getplayerdata("rankedloadouts","squadMembers","gesture");
	}
	else
	{
		var_00 = self getplayerdata("privateloadouts","squadMembers","gesture");
	}

	return scripts\mp\_gestures_mp::func_7ED0(var_00);
}

//Function Number: 20
func_3680(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"loadoutPerks",param_01);
}

//Function Number: 21
func_367F(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"extraPerks",param_01);
}

//Function Number: 22
func_367E()
{
	if(isdefined(self.var_3C56))
	{
		return self.var_3C56.var_11B2C;
	}

	return self getplayerdata(level.var_AEA6,"squadMembers","archetypePerk");
}

//Function Number: 23
func_367C(param_00,param_01)
{
	var_02 = self getplayerdata(level.var_AEA6,"squadMembers","killstreakSetups",param_01,"lootItemID");
	return scripts\mp\_killstreak_loot::func_804B(var_02);
}

//Function Number: 24
cac_getkillstreakvariantid(param_00)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","killstreakSetups",param_00,"lootItemID");
}

//Function Number: 25
cac_getweaponcosmeticattachment(param_00,param_01)
{
	return self getplayerdata(level.var_AEA6,"squadMembers","loadouts",param_00,"weaponSetups",param_01,"cosmeticAttachment");
}

//Function Number: 26
func_DDD5(param_00,param_01,param_02)
{
	return scripts\mp\_utility::func_7F91("defaultClasses",param_00,param_01,"class","kilstreakSetups",param_02,"killstreak");
}

//Function Number: 27
func_113B3(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutArchetype",param_01 + 1);
}

//Function Number: 28
func_113C0(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimary",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondary",param_01 + 1);
}

//Function Number: 29
func_113C1(param_00,param_01,param_02,param_03)
{
	var_04 = "none";
	if(param_02 == 0)
	{
		var_04 = tablelookup(param_00,0,"loadoutPrimaryAttachment" + param_03 + 1,param_01 + 1);
	}
	else
	{
		var_04 = tablelookup(param_00,0,"loadoutSecondaryAttachment" + param_03 + 1,param_01 + 1);
	}

	if(var_04 == "" || var_04 == "none")
	{
		return "none";
	}

	return var_04;
}

//Function Number: 30
func_113C3(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryCamo",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryCamo",param_01 + 1);
}

//Function Number: 31
func_113C4(param_00,param_01,param_02)
{
	if(param_02 == 0)
	{
		return tablelookup(param_00,0,"loadoutPrimaryReticle",param_01 + 1);
	}

	return tablelookup(param_00,0,"loadoutSecondaryReticle",param_01 + 1);
}

//Function Number: 32
func_113BB(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,"loadoutPerk" + param_02 + 1,param_01 + 1);
}

//Function Number: 33
table_getextraperk(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,"loadoutExtraPerk" + param_02 + 1,param_01 + 1);
}

//Function Number: 34
func_113BC(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutPowerPrimary",param_01 + 1);
}

//Function Number: 35
func_113B6(param_00,param_01)
{
	var_02 = tablelookup(param_00,0,"loadoutExtraPowerPrimary",param_01 + 1);
	return isdefined(var_02) && var_02 == "TRUE";
}

//Function Number: 36
func_113BD(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutPowerSecondary",param_01 + 1);
}

//Function Number: 37
func_113B7(param_00,param_01)
{
	var_02 = tablelookup(param_00,0,"loadoutExtraPowerSecondary",param_01 + 1);
	return isdefined(var_02) && var_02 == "TRUE";
}

//Function Number: 38
func_113BE(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutSuper",param_01 + 1);
}

//Function Number: 39
func_113B8(param_00,param_01)
{
	return tablelookup(param_00,0,"loadoutGesture",param_01 + 1);
}

//Function Number: 40
func_113B9(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,"loadoutStreak" + param_02,param_01 + 1);
}

//Function Number: 41
func_AE33(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "streaktype_support":
			var_01 = "support";
			break;

		case "streaktype_specialist":
			var_01 = "specialist";
			break;

		case "streaktype_resource":
			var_01 = "resource";
			break;

		default:
			var_01 = "assault";
			break;
	}

	return var_01;
}

//Function Number: 42
func_7F7C(param_00)
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

//Function Number: 43
func_AE32(param_00)
{
	var_01 = undefined;
	if(issubstr(param_00,"axis"))
	{
		var_01 = "axis";
	}
	else if(issubstr(param_00,"allies"))
	{
		var_01 = "allies";
	}
	else
	{
		var_01 = "none";
	}

	return var_01;
}

//Function Number: 44
func_AE23()
{
	self.health = self.maxhealth;
	thread scripts\mp\_utility::func_DDD9(scripts\mp\_utility::func_9E59());
	self.var_9E59 = 1;
}

//Function Number: 45
func_AE3E()
{
	self notify("lost_juggernaut");
	self.var_9E59 = 0;
	self.var_BCF6 = 1;
}

//Function Number: 46
func_AE26()
{
	self method_83B7();
	scripts\mp\perks\_weaponpassives::resetmodeswitchkillweapons(self);
	func_11D7();
	scripts\mp\_powers::func_110C2();
	scripts\mp\_powers::func_41D0();
	if(isdefined(self.var_AE62))
	{
		func_41D8();
	}

	lib_0D69::func_E0D0(self.var_AE62);
	scripts\mp\perks\_perks::func_11AA();
	scripts\mp\perks\_weaponpassives::func_72FB();
	scripts\mp\_gestures_mp::func_41B2();
	func_E243();
	func_E250();
	if(isplayer(self))
	{
		scripts\mp\killstreaks\_emp_common::func_E24E();
	}
}

//Function Number: 47
func_AE31()
{
	var_00 = spawnstruct();
	var_00.var_AE62 = "none";
	var_00.var_AE7F = "none";
	var_00.var_AE86 = [];
	for(var_01 = 0;var_01 < 6;var_01++)
	{
		var_00.var_AE86[var_01] = "none";
	}

	var_00.var_AE88 = "none";
	var_00.var_AE90 = "none";
	var_00.var_AE8A = 0;
	var_00.var_AE91 = -1;
	var_00.loadoutprimarycosmeticattachment = "none";
	var_00.var_AE94 = "none";
	var_00.var_AE9A = [];
	for(var_01 = 0;var_01 < 5;var_01++)
	{
		var_00.var_AE9A[var_01] = "none";
	}

	var_00.var_AE9C = "none";
	var_00.var_AEA4 = "none";
	var_00.var_AE9E = 0;
	var_00.var_AEA5 = -1;
	var_00.loadoutsecondarycosmeticattachment = "none";
	var_00.var_AE7A = 0;
	var_00.var_AE79 = [];
	var_00.var_AEA7 = [];
	var_00.var_AE66 = [];
	var_00.var_AE92 = "specialty_null";
	var_00.var_AE7B = "none";
	var_00.var_AE7C = [];
	var_00.var_AE67 = 0;
	var_00.var_AE7D = "none";
	var_00.var_AE7E = [];
	var_00.var_AE68 = 0;
	var_00.var_AEAA = "none";
	var_00.var_AE6C = "none";
	var_00.var_AEA8 = 0;
	var_00.var_AEA9 = "streaktype_assault";
	var_00.var_AE6E = "none";
	var_00.loadoutkillstreak1variantid = -1;
	var_00.var_AE6F = [];
	var_00.var_AE70 = "none";
	var_00.loadoutkillstreak2variantid = -1;
	var_00.var_AE71 = [];
	var_00.var_AE72 = "none";
	var_00.loadoutkillstreak3variantid = -1;
	var_00.var_AE73 = [];
	return var_00;
}

//Function Number: 48
func_AE52(param_00,param_01,param_02)
{
	param_02 = func_AE32(param_01);
	var_03 = scripts\mp\_utility::func_7E2B(param_01);
	self.var_4006 = var_03;
	self.var_4012 = param_02;
	param_00.var_AE62 = scripts\mp\_utility::func_7F91("defaultClasses",param_02,var_03,"class","archetype");
	param_00.var_AE7F = scripts\mp\_utility::func_7F91("defaultClasses",param_02,var_03,"class","weaponSetups",0,"weapon");
	if(param_00.var_AE7F == "none")
	{
		param_00.var_AE7F = "iw7_fists";
	}
	else
	{
		for(var_04 = 0;var_04 < 6;var_04++)
		{
			param_00.var_AE86[var_04] = scripts\mp\_utility::func_7F91("defaultClasses",param_02,var_03,"class","weaponSetups",0,"attachment",var_04);
		}
	}

	param_00.var_AE88 = scripts\mp\_utility::func_7F91("defaultClasses",param_02,var_03,"class","weaponSetups",0,"camo");
	param_00.var_AE90 = scripts\mp\_utility::func_7F91("defaultClasses",param_02,var_03,"class","weaponSetups",0,"reticle");
	param_00.var_AE94 = scripts\mp\_utility::func_7F91("defaultClasses",param_02,var_03,"class","weaponSetups",1,"weapon");
	for(var_04 = 0;var_04 < 5;var_04++)
	{
		param_00.var_AE9A[var_04] = scripts\mp\_utility::func_7F91("defaultClasses",param_02,var_03,"class","weaponSetups",1,"attachment",var_04);
	}

	param_00.var_AE9C = scripts\mp\_utility::func_7F91("defaultClasses",param_02,var_03,"class","weaponSetups",1,"camo");
	param_00.var_AEA4 = scripts\mp\_utility::func_7F91("defaultClasses",param_02,var_03,"class","weaponSetups",1,"reticle");
	param_00.var_AE7B = "none";
	param_00.var_AE67 = 0;
	param_00.var_AE7D = "none";
	param_00.var_AE68 = 0;
	param_00.var_AEAA = "none";
	param_00.var_AE6C = scripts\mp\_utility::func_7F91("defaultClasses",param_02,var_03,"class","gesture");
	param_00.var_AEA8 = 1;
	param_00.var_AE6E = func_DDD5(param_02,var_03,0);
	param_00.var_AE70 = func_DDD5(param_02,var_03,1);
	param_00.var_AE72 = func_DDD5(param_02,var_03,2);
	param_00.var_AE6F = [];
	param_00.var_AE71 = [];
	param_00.var_AE73 = [];
	param_00.var_AE7C = [];
	param_00.var_AE7E = [];
	param_00.loadoutkillstreak1variantid = -1;
	param_00.loadoutkillstreak2variantid = -1;
	param_00.loadoutkillstreak3variantid = -1;
	if(scripts\mp\_utility::func_7F91("defaultClasses",param_02,var_03,"juggernaut"))
	{
		func_AE23();
		return;
	}

	if(scripts\mp\_utility::func_9E59())
	{
		func_AE3E();
	}
}

//Function Number: 49
func_AE4A(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_7E2B(param_01);
	self.var_4006 = var_02;
	param_00.var_AE62 = func_3676();
	param_00.var_AE7F = func_3689(var_02,0);
	for(var_03 = 0;var_03 < 6;var_03++)
	{
		param_00.var_AE86[var_03] = func_368A(var_02,0,var_03);
	}

	param_00.var_AE88 = func_3691(var_02,0);
	param_00.var_AE90 = func_3694(var_02,0);
	param_00.var_AE8A = func_3692(var_02,0);
	param_00.var_AE91 = func_3695(var_02,0);
	param_00.loadoutprimarycosmeticattachment = cac_getweaponcosmeticattachment(var_02,0);
	param_00.var_AE94 = func_3689(var_02,1);
	for(var_03 = 0;var_03 < 5;var_03++)
	{
		param_00.var_AE9A[var_03] = func_368A(var_02,1,var_03);
	}

	param_00.var_AE9C = func_3691(var_02,1);
	param_00.var_AEA4 = func_3694(var_02,1);
	param_00.var_AE9E = func_3692(var_02,1);
	param_00.var_AEA5 = func_3695(var_02,1);
	param_00.loadoutsecondarycosmeticattachment = cac_getweaponcosmeticattachment(var_02,1);
	param_00.var_AE7B = func_3682(var_02);
	param_00.var_AE7C = func_3683(var_02);
	param_00.var_AE67 = func_3678(var_02);
	param_00.var_AE7D = func_3684(var_02);
	param_00.var_AE7E = func_3685(var_02);
	param_00.var_AE68 = func_3679(var_02);
	param_00.var_AEAA = func_3688();
	param_00.var_AE6C = func_367A();
	param_00.var_AEA8 = 1;
	param_00.var_AE6E = func_367B(0);
	param_00.var_AE6F = func_367C(var_02,0);
	param_00.loadoutkillstreak1variantid = cac_getkillstreakvariantid(0);
	param_00.var_AE70 = func_367B(1);
	param_00.var_AE71 = func_367C(var_02,1);
	param_00.loadoutkillstreak2variantid = cac_getkillstreakvariantid(1);
	param_00.var_AE72 = func_367B(2);
	param_00.var_AE73 = func_367C(var_02,2);
	param_00.loadoutkillstreak3variantid = cac_getkillstreakvariantid(2);
}

//Function Number: 50
func_AE4E(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_7E2B(param_01);
	self.var_4006 = var_02;
	var_03 = self.pers["gamemodeLoadout"];
	if(isdefined(var_03["loadoutArchetype"]))
	{
		param_00.var_AE62 = var_03["loadoutArchetype"];
		if(isbot(self))
		{
			self.var_2ED8 = var_03["loadoutArchetype"];
		}
	}
	else if(isbot(self))
	{
		var_04 = scripts\mp\bots\_bots_loadout::func_2E05();
		param_00.var_AE62 = var_04["loadoutArchetype"];
	}
	else
	{
		param_00.var_AE62 = func_3676();
	}

	if(isdefined(var_03["loadoutRigTrait"]))
	{
		param_00.var_AE92 = var_03["loadoutRigTrait"];
	}

	if(isdefined(var_03["loadoutPrimary"]))
	{
		param_00.var_AE7F = var_03["loadoutPrimary"];
	}

	for(var_05 = 0;var_05 < 6;var_05++)
	{
		var_06 = func_7DE0(var_05,"primary");
		if(isdefined(var_03[var_06]))
		{
			param_00.var_AE86[var_05] = var_03[var_06];
		}
	}

	if(isdefined(var_03["loadoutPrimaryCamo"]))
	{
		param_00.var_AE88 = var_03["loadoutPrimaryCamo"];
	}

	if(isdefined(var_03["loadoutPrimaryReticle"]))
	{
		param_00.var_AE90 = var_03["loadoutPrimaryReticle"];
	}

	if(isdefined(var_03["loadoutSecondary"]))
	{
		param_00.var_AE94 = var_03["loadoutSecondary"];
	}

	for(var_05 = 0;var_05 < 5;var_05++)
	{
		var_06 = func_7DE0(var_05,"secondary");
		if(isdefined(var_03[var_06]))
		{
			param_00.var_AE9A[var_05] = var_03[var_06];
		}
	}

	if(isdefined(var_03["loadoutSecondaryCamo"]))
	{
		param_00.var_AE9C = var_03["loadoutSecondaryCamo"];
	}

	if(isdefined(var_03["loadoutSecondaryReticle"]))
	{
		param_00.var_AEA4 = var_03["loadoutSecondaryReticle"];
	}

	param_00.var_AE7A = isdefined(var_03["loadoutPerks"]);
	if(isdefined(var_03["loadoutPerks"]))
	{
		param_00.var_AE79 = var_03["loadoutPerks"];
	}

	if(isdefined(var_03["loadoutPowerPrimary"]))
	{
		param_00.var_AE7B = var_03["loadoutPowerPrimary"];
	}

	if(isdefined(var_03["loadoutExtraPowerPrimary"]))
	{
		param_00.var_AE67 = var_03["loadoutExtraPowerPrimary"];
	}

	if(isdefined(var_03["loadoutPowerPrimaryPassives"]))
	{
		param_00.var_AE7C = var_03["loadoutPowerPrimaryPassives"];
	}

	if(isdefined(var_03["loadoutPowerSecondary"]))
	{
		param_00.var_AE7D = var_03["loadoutPowerSecondary"];
	}

	if(isdefined(var_03["loadoutExtraPowerSecondary"]))
	{
		param_00.var_AE68 = var_03["loadoutExtraPowerSecondary"];
	}

	if(isdefined(var_03["loadoutPowerSecondaryPassives"]))
	{
		param_00.var_AE7E = var_03["loadoutPowerSecondaryPassives"];
	}

	if(isdefined(var_03["loadoutSuper"]))
	{
		param_00.var_AEAA = var_03["loadoutSuper"];
	}

	if(isdefined(var_03["loadoutGesture"]) && var_03["loadoutGesture"] == "playerData")
	{
		if(isbot(self))
		{
			param_00.var_AE6C = "none";
		}
		else
		{
			param_00.var_AE6C = func_367A();
		}
	}
	else if(isdefined(var_03["loadoutGesture"]))
	{
		param_00.var_AE6C = var_03["loadoutGesture"];
	}

	if((isdefined(var_03["loadoutKillstreak1"]) && var_03["loadoutKillstreak1"] != "specialty_null") || isdefined(var_03["loadoutKillstreak2"]) && var_03["loadoutKillstreak2"] != "specialty_null" || isdefined(var_03["loadoutKillstreak3"]) && var_03["loadoutKillstreak3"] != "specialty_null")
	{
		param_00.var_AEA8 = 1;
		param_00.var_AE6E = var_03["loadoutKillstreak1"];
		param_00.var_AE70 = var_03["loadoutKillstreak2"];
		param_00.var_AE72 = var_03["loadoutKillstreak3"];
		if(isdefined(var_03["loadoutKillstreak1Passives"]))
		{
			param_00.var_AE6F = var_03["loadoutKillstreak1Passives"];
		}

		if(isdefined(var_03["loadoutKillstreak2Passives"]))
		{
			param_00.var_AE71 = var_03["loadoutKillstreak2Passives"];
		}

		if(isdefined(var_03["loadoutKillstreak3Passives"]))
		{
			param_00.var_AE73 = var_03["loadoutKillstreak3Passives"];
		}
	}

	if(var_03["loadoutJuggernaut"])
	{
		func_AE23();
		return;
	}

	if(scripts\mp\_utility::func_9E59())
	{
		func_AE3E();
	}
}

//Function Number: 51
func_AE50(param_00)
{
	param_00.var_AE7F = "iw7_chargeshot_c8";
	param_00.var_AE94 = "iw7_c8landing";
}

//Function Number: 52
func_AE49(param_00)
{
	if(!isdefined(self.var_4009))
	{
		scripts\common\utility::func_66BD("self.classCallback function reference required for class \'callback\'");
	}

	var_01 = self [[ self.var_4009 ]]();
	if(!isdefined(var_01))
	{
		scripts\common\utility::func_66BD("array required from self.classCallback for class \'callback\'");
	}

	if(isdefined(var_01["loadoutArchetype"]))
	{
		param_00.var_AE62 = var_01["loadoutArchetype"];
	}

	if(isdefined(var_01["loadoutPrimary"]))
	{
		param_00.var_AE7F = var_01["loadoutPrimary"];
	}

	for(var_02 = 0;var_02 < 6;var_02++)
	{
		var_03 = func_7DE0(var_02,"primary");
		if(isdefined(var_01[var_03]))
		{
			param_00.var_AE86[var_02] = var_01[var_03];
		}
	}

	if(isdefined(var_01["loadoutPrimaryCamo"]))
	{
		param_00.var_AE88 = var_01["loadoutPrimaryCamo"];
	}

	if(isdefined(var_01["loadoutPrimaryReticle"]))
	{
		param_00.var_AE90 = var_01["loadoutPrimaryReticle"];
	}

	if(isdefined(var_01["loadoutSecondary"]))
	{
		param_00.var_AE94 = var_01["loadoutSecondary"];
	}

	for(var_02 = 0;var_02 < 5;var_02++)
	{
		var_03 = func_7DE0(var_02,"secondary");
		if(isdefined(var_01[var_03]))
		{
			param_00.var_AE9A[var_02] = var_01[var_03];
		}
	}

	if(isdefined(var_01["loadoutSecondaryCamo"]))
	{
		param_00.var_AE9C = var_01["loadoutSecondaryCamo"];
	}

	if(isdefined(var_01["loadoutSecondaryReticle"]))
	{
		param_00.var_AEA4 = var_01["loadoutSecondaryReticle"];
	}

	if(isdefined(var_01["loadoutPowerPrimary"]))
	{
		param_00.var_AE7B = var_01["loadoutPowerPrimary"];
	}

	if(isdefined(var_01["loadoutPowerPrimaryPassives"]))
	{
		param_00.var_AE7C = var_01["loadoutPowerPrimaryPassives"];
	}

	if(isdefined(var_01["loadoutExtraPowerPrimary"]))
	{
		param_00.var_AE67 = var_01["loadoutExtraPowerPrimary"];
	}

	if(isdefined(var_01["loadoutPowerSecondary"]))
	{
		param_00.var_AE7D = var_01["loadoutPowerSecondary"];
	}

	if(isdefined(var_01["loadoutPowerSecondaryPassives"]))
	{
		param_00.var_AE7E = var_01["loadoutPowerSecondaryPassives"];
	}

	if(isdefined(var_01["loadoutExtraPowerSecondary"]))
	{
		param_00.var_AE68 = var_01["loadoutPowerExtraSecondary"];
	}

	if(isdefined(var_01["loadoutSuper"]))
	{
		param_00.var_AEAA = var_01["loadoutSuper"];
	}

	if(isdefined(var_01["loadoutGesture"]))
	{
		param_00.var_AE6C = var_01["loadoutGesture"];
	}

	param_00.var_AEA8 = isdefined(var_01["loadoutStreak1"]) || isdefined(var_01["loadoutStreak2"]) || isdefined(var_01["loadoutStreak3"]);
	if(isdefined(var_01["loadoutStreakType"]))
	{
		param_00.var_AEA9 = var_01["loadoutStreakType"];
	}

	if(isdefined(var_01["loadoutStreak1"]))
	{
		param_00.var_AE6E = var_01["loadoutStreak1"];
	}

	if(isdefined(var_01["loadoutStreak2"]))
	{
		param_00.var_AE70 = var_01["loadoutStreak2"];
	}

	if(isdefined(var_01["loadoutStreak3"]))
	{
		param_00.var_AE72 = var_01["loadoutStreak3"];
	}

	if(isdefined(var_01["loadoutKillstreak1Passives"]))
	{
		param_00.var_AE6F = var_01["loadoutKillstreak1Passives"];
	}

	if(isdefined(var_01["loadoutKillstreak2Passives"]))
	{
		param_00.var_AE71 = var_01["loadoutKillstreak2Passives"];
	}

	if(isdefined(var_01["loadoutKillstreak3Passives"]))
	{
		param_00.var_AE73 = var_01["loadoutKillstreak3Passives"];
	}
}

//Function Number: 53
func_AE4B(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_7E2B(param_01);
	self.var_4006 = var_02;
	param_00.var_AE7F = func_113C0(level.var_4010,var_02,0);
	for(var_03 = 0;var_03 < 6;var_03++)
	{
		param_00.var_AE86[var_03] = func_113C1(level.var_4010,var_02,0,var_03);
	}

	param_00.var_AE88 = func_113C3(level.var_4010,var_02,0);
	param_00.var_AE90 = func_113C4(level.var_4010,var_02,0);
	param_00.var_AE94 = func_113C0(level.var_4010,var_02,1);
	for(var_03 = 0;var_03 < 5;var_03++)
	{
		param_00.var_AE9A[var_03] = func_113C1(level.var_4010,var_02,1,var_03);
	}

	param_00.var_AE9C = func_113C3(level.var_4010,var_02,1);
	param_00.var_AEA4 = func_113C4(level.var_4010,var_02,1);
	param_00.var_AE7B = func_113BC(level.var_4010,var_02);
	param_00.var_AE67 = func_113B6(level.var_4010,var_02);
	param_00.var_AE7D = func_113BD(level.var_4010,var_02);
	param_00.var_AE68 = func_113B7(level.var_4010,var_02);
	param_00.var_AE6C = func_113B8(level.var_4010,var_02);
	param_00.var_AE62 = func_3676();
	param_00.var_AEAA = func_3688();
	param_00.var_AE6E = func_367B(0);
	param_00.var_AE70 = func_367B(1);
	param_00.var_AE72 = func_367B(2);
	param_00.var_AE92 = func_367E();
	param_00.var_AE6C = func_367A();
}

//Function Number: 54
func_AE5D(param_00)
{
	self.var_110F4 = "streaktype_assault";
	param_00.var_AEA9 = self.var_110F4;
}

//Function Number: 55
func_AE47(param_00,param_01)
{
	if(!isdefined(self.pers["loadoutPerks"]))
	{
		self.pers["loadoutPerks"] = [];
	}

	if(!isdefined(self.pers["loadoutStandardPerks"]))
	{
		self.pers["loadoutStandardPerks"] = [];
	}

	if(!isdefined(self.pers["loadoutExtraPerks"]))
	{
		self.pers["loadoutExtraPerks"] = [];
	}

	if(!isdefined(self.pers["loadoutRigTrait"]))
	{
		self.pers["loadoutRigTrait"] = [];
	}

	if(scripts\mp\_utility::func_9E59())
	{
		return;
	}

	var_02 = getsubstr(param_01,0,7) == "default";
	if(param_00.var_AE7A)
	{
		return;
	}

	if(!scripts\mp\_utility::func_CA5F())
	{
		return;
	}

	if(isai(self))
	{
		if(isdefined(self.pers["loadoutPerks"]))
		{
			param_00.var_AE79 = self.pers["loadoutPerks"];
			return;
		}

		return;
	}

	if(func_8BDC() || func_8BDB())
	{
		var_03 = func_AE32(param_01);
		for(var_04 = 0;var_04 < 3;var_04++)
		{
			var_05 = "specialty_null";
			if(var_03 != "none")
			{
				var_06 = scripts\mp\_utility::func_7E2B(param_01);
				var_05 = scripts\mp\_utility::func_7F91("defaultClasses",var_03,var_06,"class","loadoutPerks");
			}
			else if(var_02)
			{
				var_06 = scripts\mp\_utility::func_7E2B(param_01);
				var_05 = func_113BB(level.var_4010,var_06,var_04);
			}
			else
			{
				var_05 = func_3680(self.var_4006,var_04);
			}

			if(var_05 != "specialty_null")
			{
				param_00.var_AE79[param_00.var_AE79.size] = var_05;
				param_00.var_AEA7[param_00.var_AEA7.size] = var_05;
			}
		}

		for(var_04 = 0;var_04 < 3;var_04++)
		{
			var_05 = "specialty_null";
			if(var_03 != "none")
			{
				var_06 = scripts\mp\_utility::func_7E2B(param_01);
				var_05 = scripts\mp\_utility::func_7F91("defaultClasses",var_03,var_06,"class","extraPerks");
			}
			else if(var_02)
			{
				var_06 = scripts\mp\_utility::func_7E2B(param_01);
				var_05 = table_getextraperk(level.var_4010,var_06,var_04);
			}
			else
			{
				var_05 = func_367F(self.var_4006,var_04);
			}

			if(var_05 != "specialty_null")
			{
				param_00.var_AE79[param_00.var_AE79.size] = var_05;
				param_00.var_AE66[param_00.var_AE66.size] = var_05;
			}
		}

		var_05 = "specialty_null";
		if(var_03 != "none")
		{
			var_06 = scripts\mp\_utility::func_7E2B(param_01);
			var_05 = scripts\mp\_utility::func_7F91("defaultClasses",var_03,var_06,"class","archetypePerk");
		}
		else
		{
			var_05 = func_367E();
		}

		if(var_05 != "specialty_null")
		{
			param_00.var_AE79[param_00.var_AE79.size] = var_05;
			self.pers["loadoutRigTrait"] = var_05;
			param_00.var_AE92 = var_05;
			return;
		}

		return;
	}

	param_00.var_AE79 = self.pers["loadoutPerks"];
	param_00.var_AEA7 = self.pers["loadoutStandardPerks"];
	param_00.var_AE66 = self.pers["loadoutExtraPerks"];
	param_00.var_AE92 = self.pers["loadoutRigTrait"];
}

//Function Number: 56
func_AE48(param_00,param_01)
{
	var_02 = func_AE32(param_01);
	if(var_02 != "none")
	{
		func_AE52(param_00,param_01);
	}
	else if(issubstr(param_01,"custom"))
	{
		func_AE4A(param_00,param_01);
	}
	else if(param_01 == "gamemode")
	{
		func_AE4E(param_00,param_01);
	}
	else if(param_01 == "rc8Agent")
	{
		func_AE50(param_00);
	}
	else if(param_01 == "callback")
	{
		func_AE49(param_00);
	}
	else
	{
		func_AE4B(param_00,param_01);
	}

	func_AE4D(param_00);
	func_AE5D(param_00);
	func_AE47(param_00,param_01);
	param_00 = func_AE5F(param_00,param_01);
	return param_00;
}

//Function Number: 57
func_AE4D(param_00)
{
	if(param_00.var_AE7F == "none")
	{
		param_00.var_AE7F = "iw7_fists";
	}

	if(param_00.var_AE94 == "none" && param_00.var_AE7F != "iw7_fists")
	{
		param_00.var_AE94 = "iw7_fists";
		return;
	}

	if(param_00.var_AE7F == "iw7_fists" && param_00.var_AE94 == "iw7_fists")
	{
		param_00.var_AE94 = "none";
	}
}

//Function Number: 58
func_AE5F(param_00,param_01)
{
	if(issubstr(param_01,"custom"))
	{
		return scripts\mp\_validation::func_13140(param_00);
	}

	return param_00;
}

//Function Number: 59
func_AE2E(param_00)
{
	var_01 = getdvarint("forceArchetype",0);
	if(var_01 > 0)
	{
		var_02 = getdvarint("forceArchetype",0);
		switch(var_02)
		{
			case 1:
				param_00.var_AE62 = "archetype_assault";
				break;

			case 2:
				param_00.var_AE62 = "archetype_heavy";
				break;

			case 3:
				param_00.var_AE62 = "archetype_scout";
				break;

			case 4:
				param_00.var_AE62 = "archetype_assassin";
				break;

			case 5:
				param_00.var_AE62 = "archetype_engineer";
				break;

			case 6:
				param_00.var_AE62 = "archetype_sniper";
				break;

			case 7:
				param_00.var_AE62 = "archetype_reaper";
				break;

			default:
				param_00.var_AE62 = "archetype_assault";
				break;
		}

		return;
	}

	if(var_01 == -1)
	{
		var_03 = ["archetype_assault","archetype_heavy","archetype_scout","archetype_assassin","archetype_engineer","archetype_sniper"];
		var_04 = randomint(var_03.size);
		param_00.var_AE62 = var_03[var_04];
		self iprintlnbold("Random Archetype: " + var_03[var_04]);
	}
}

//Function Number: 60
func_AE55(param_00)
{
	if(!scripts\common\utility::istrue(self.btestclient))
	{
		if(!isdefined(level.var_204B) || level.var_204B == 0)
		{
		}
	}

	self.var_AE62 = param_00.var_AE62;
	scripts\mp\_weapons::func_12ED5();
	var_01 = 1;
	var_02 = 2;
	var_03 = 4;
	var_04 = 8;
	var_05 = "defaultsuit_mp";
	var_06 = 0;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = 400;
	var_0A = 400;
	var_0B = 900;
	if(level.tactical)
	{
		var_0A = 133.3333;
		var_0B = 1800;
	}

	switch(self.var_AE62)
	{
		case "archetype_assault":
			var_05 = "assault_mp";
			var_06 = var_01 | var_02 | var_03;
			var_07 = ::lib_0D68::func_20BB;
			var_08 = "vestlight";
			break;

		case "archetype_heavy":
			var_05 = "armor_mp";
			var_06 = var_01 | var_02 | var_03;
			var_07 = ::lib_0D6C::func_20BB;
			var_08 = "vestheavy";
			break;

		case "archetype_scout":
			var_05 = "scout_mp";
			var_06 = var_01 | var_02 | var_03;
			var_07 = ::lib_0D6F::func_20BB;
			var_08 = "c6servo";
			break;

		case "archetype_assassin":
			var_05 = "assassin_mp";
			var_06 = var_01 | var_02 | var_03;
			var_07 = ::lib_0D67::func_20BB;
			var_08 = "vestftl";
			break;

		case "archetype_engineer":
			var_05 = "engineer_mp";
			var_06 = var_01 | var_02 | var_03;
			var_07 = ::lib_0D6B::func_20BB;
			var_08 = "vestlight";
			break;

		case "archetype_sniper":
			var_05 = "sniper_mp";
			var_06 = var_01 | var_02 | var_03;
			var_07 = ::lib_0D70::func_20BB;
			var_08 = "vestghost";
			break;

		default:
			if(!scripts\common\utility::istrue(self.btestclient))
			{
				if(!isdefined(level.var_204B) || level.var_204B == 0)
				{
				}
			}
			break;
	}

	if(level.tactical)
	{
		var_05 = var_05 + "_tactical";
		var_01 = 0;
	}

	self method_845E(0);
	self method_8422(var_06 & var_01);
	self allowslide(var_06 & var_02);
	self method_8424(var_06 & var_03);
	self method_8412(var_06 & var_04);
	self method_800E(0);
	self method_845A(var_05);
	self method_842E(0,var_09);
	self method_842C(0,var_09);
	self method_8434(0,var_0A);
	self method_8430(0,var_0B);
	self method_842E(1,50);
	self method_842C(1,50);
	self method_8434(1,10);
	self method_8430(1,scripts\common\utility::func_116D7(scripts\mp\_utility::func_9D46(),2500,0));
	if(isdefined(level.var_112C1))
	{
		if(!level.var_112C1)
		{
			scripts\common\utility::func_1C42(0);
		}
	}

	if(isdefined(level.var_112C6))
	{
		if(!level.var_112C6)
		{
			scripts\common\utility::func_1C70(0);
		}
	}

	if(isdefined(var_07))
	{
		self [[ var_07 ]]();
	}

	if(isdefined(var_08))
	{
		self method_82C6(var_08);
		if(var_08 == "c6servo")
		{
			self method_8460("clothtype","c6servo");
		}
		else
		{
			self method_8460("clothtype","");
		}

		self.var_42B0 = var_08;
	}

	thread lib_0D69::func_EF38();
	thread lib_0D69::func_EF41();
}

//Function Number: 61
func_AE4C(param_00)
{
	if(isdefined(self.var_4006))
	{
		param_00.var_AE8B = self.var_4006 * 2 + 0;
		param_00.var_AE9F = self.var_4006 * 2 + 1;
	}
	else
	{
		param_00.var_AE8B = -1;
		param_00.var_AE9F = -1;
	}

	param_00.var_AE89 = func_3224(param_00.var_AE7F,param_00.var_AE86,param_00.var_AE88,param_00.var_AE90,param_00.var_AE91,self getentitynumber(),self.var_41F0,param_00.var_AE8B,param_00.loadoutprimarycosmeticattachment);
	if(param_00.var_AE94 == "none")
	{
		param_00.var_AE9D = "none";
		return;
	}

	param_00.var_AE9D = func_3224(param_00.var_AE94,param_00.var_AE9A,param_00.var_AE9C,param_00.var_AEA4,param_00.var_AEA5,self getentitynumber(),self.var_41F0,param_00.var_AE9F,param_00.loadoutsecondarycosmeticattachment);
}

//Function Number: 62
func_AE5C(param_00,param_01,param_02)
{
	if(getdvarint("scr_require_loot",0) == 1 && !scripts\mp\_utility::func_9FB3(self.var_54BC))
	{
		if(param_00.var_AE8A == 0 && param_00.var_AE9E == 0)
		{
			iprintlnbold(self.name + " is not using a loot weapon!");
			self.var_54BC = 1;
		}
	}

	if(param_01 == "rc8Agent")
	{
		return;
	}

	func_AE4C(param_00);
	self.var_AE7F = param_00.var_AE7F;
	self.var_AE88 = param_00.var_AE88;
	self.var_AE94 = param_00.var_AE94;
	self.var_AE9C = param_00.var_AE9C;
	self.var_AE86 = param_00.var_AE86;
	self.var_AE9A = param_00.var_AE9A;
	self.var_AE90 = param_00.var_AE90;
	self.var_AEA4 = param_00.var_AEA4;
	self.var_AE8A = param_00.var_AE8A;
	self.var_AE91 = param_00.var_AE91;
	self.var_AE9E = param_00.var_AE9E;
	self.var_AEA5 = param_00.var_AEA5;
	var_03 = scripts\mp\_weapons::func_12E5C(param_00.var_AE89);
	scripts\mp\_utility::func_12C6(var_03,undefined,undefined,getweaponbasename(var_03) == "iw7_fists_mp");
	scripts\mp\_weapons::func_12F48(param_00.var_AE89);
	scripts\mp\perks\_weaponpassives::loadoutweapongiven(param_00.var_AE89);
	var_04 = "none";
	if(param_00.var_AE94 != "none")
	{
		var_04 = scripts\mp\_weapons::func_12E5C(param_00.var_AE9D);
		scripts\mp\_utility::func_12C6(var_04,undefined,undefined,1);
		scripts\mp\_weapons::func_12F48(param_00.var_AE9D);
		if(scripts\mp\_utility::func_8234(var_04) == "iw7_axe")
		{
			self setweaponammoclip(var_04,1);
		}

		scripts\mp\perks\_weaponpassives::loadoutweapongiven(param_00.var_AE9D);
	}

	var_05 = var_03;
	if(var_04 != "none" && getweaponbasename(var_05) == "iw7_fists_mp")
	{
		var_05 = var_04;
	}

	if(!isai(self))
	{
		self.var_EB6D = undefined;
		scripts\mp\_utility::_switchtoweapon(var_05);
	}

	if(!isdefined(param_02) || param_02)
	{
		var_06 = !scripts\mp\_utility::func_766C("prematch_done") && !scripts\mp\_weapons::func_9D3E(var_05);
		self method_833B(var_05,var_06);
	}

	self.var_D8E1 = param_00.var_AE89;
	self.var_F0C4 = param_00.var_AE9D;
	self.var_10922 = var_05;
	self.pers["primaryWeapon"] = param_00.var_AE89;
	self.pers["secondaryWeapon"] = param_00.var_AE9D;
	scripts\mp\_teams::func_FADC();
	scripts\mp\_weapons::func_12ED5();
	thread scripts\mp\_weapons::func_13BA9();
}

//Function Number: 63
func_AE58(param_00)
{
	scripts\mp\_utility::func_8387("specialty_marathon");
	scripts\mp\_utility::func_8387("specialty_sharp_focus");
	scripts\mp\_utility::func_8387("specialty_silentdoublejump");
	if(param_00.var_AE79.size > 0)
	{
		scripts\mp\perks\_perks::func_838A(param_00.var_AE79,0);
	}

	self.pers["loadoutPerks"] = param_00.var_AE79;
	self.pers["loadoutStandardPerks"] = param_00.var_AEA7;
	self.pers["loadoutExtraPerks"] = param_00.var_AE66;
	self.pers["loadoutRigTrait"] = param_00.var_AE92;
	self setclientomnvar("ui_trait_ref",scripts\mp\perks\_perks::func_805A(self.pers["loadoutRigTrait"]));
	if(!scripts\mp\_utility::func_9E59() && isdefined(self.var_26B9) && self.var_26B9 > 0)
	{
		thread scripts\mp\perks\_perks::func_838B();
	}
}

//Function Number: 64
func_AE59(param_00)
{
	self.var_D782 = [];
	self.var_AE7B = param_00.var_AE7B;
	self.var_AE7D = param_00.var_AE7D;
	scripts\mp\_powers::func_8397(param_00.var_AE7B,"primary",0,param_00.var_AE7C,param_00.var_AE67);
	scripts\mp\_powers::func_8397(param_00.var_AE7D,"secondary",0,param_00.var_AE7E,param_00.var_AE68);
}

//Function Number: 65
func_AE5B(param_00)
{
	var_01 = param_00.var_AEAA;
	if(isbot(self) && level.var_1CAA)
	{
		if(isdefined(self.var_AEAA))
		{
			var_01 = self.var_AEAA;
		}
		else
		{
			var_01 = scripts\mp\bots\_bots_supers::func_2EE9();
		}

		param_00.var_AEAA = var_01;
		if(isdefined(self.var_AE92))
		{
			var_02 = self.var_AE92;
		}
		else if(isdefined(var_01.var_AE92) && self.var_4004 == "gamemode")
		{
			var_02 = var_01.var_AE92;
		}
		else
		{
			var_02 = scripts\mp\bots\_bots_supers::botpicktrait();
		}

		param_00.var_AE92 = var_02;
		self.pers["loadoutRigTrait"] = var_02;
		if(var_02 != "specialty_null")
		{
			scripts\mp\_utility::func_8387(var_02);
			self setclientomnvar("ui_trait_ref",scripts\mp\perks\_perks::func_805A(self.pers["loadoutRigTrait"]));
		}
	}

	if(isdefined(scripts\mp\_supers::func_7E4E()))
	{
		var_03 = scripts\mp\_supers::func_7E4F();
		if(var_03 == var_01 && !func_8BDB())
		{
			scripts\mp\_supers::givesuperweapon(self.var_11234);
			return;
		}
	}

	if(var_01 == "none" || !level.var_1CAA)
	{
		scripts\mp\_supers::func_41E2();
		self.var_AEAA = undefined;
		return;
	}

	if(level.var_1CAA && isdefined(self.pers["gamemodeLoadout"]) && isdefined(self.pers["gamemodeLoadout"]["loadoutSuper"]))
	{
		self.var_AEAA = self.pers["gamemodeLoadout"]["loadoutSuper"];
		scripts\mp\_supers::func_83A8(self.var_AEAA,1);
		return;
	}

	self.var_AEAA = var_01;
	scripts\mp\_supers::func_83A8(var_01,1);
}

//Function Number: 66
func_AE56(param_00)
{
	if(!scripts\common\utility::istrue(self.btestclient))
	{
		if(param_00.var_AE6C != "none")
		{
			self.var_AE6C = param_00.var_AE6C;
			scripts\mp\_gestures_mp::func_8368(param_00.var_AE6C);
		}
	}
}

//Function Number: 67
func_AE5A(param_00)
{
	self.var_110F4 = func_AE33(param_00.var_AEA9);
}

//Function Number: 68
func_AE57(param_00,param_01)
{
	if(!level.var_1C98)
	{
		param_00.var_AE6E = "none";
		param_00.var_AE70 = "none";
		param_00.var_AE72 = "none";
	}

	self.streakvariantids = [];
	self.streakvariantids[param_00.var_AE6E] = param_00.loadoutkillstreak1variantid;
	self.streakvariantids[param_00.var_AE70] = param_00.loadoutkillstreak2variantid;
	self.streakvariantids[param_00.var_AE72] = param_00.loadoutkillstreak3variantid;
	if(param_00.var_AEA8 == 0 && isdefined(self.var_A6AB) && self.var_A6AB.size > 0 && param_01 == "gamemode" || issubstr(param_01,"juggernaut"))
	{
		var_02 = 0;
		foreach(var_04 in self.var_A6AB)
		{
			if(var_02 == 0)
			{
				param_00.var_AE6E = var_04;
				var_02++;
				continue;
			}

			if(var_02 == 1)
			{
				param_00.var_AE70 = var_04;
				var_02++;
				continue;
			}

			if(var_02 == 2)
			{
				param_00.var_AE72 = var_04;
				break;
			}
		}
	}

	level.sortedkillstreaksbycost = getsortedkillstreaksbycost(param_00);
	param_00.var_AE6E = level.sortedkillstreaksbycost[0];
	param_00.var_AE70 = level.sortedkillstreaksbycost[1];
	param_00.var_AE72 = level.sortedkillstreaksbycost[2];
	if(param_01 == "gamemode" && self.var_110F4 == "specialist")
	{
		self.pers["gamemodeLoadout"]["loadoutKillstreak1"] = param_00.var_AE6E;
		self.pers["gamemodeLoadout"]["loadoutKillstreak2"] = param_00.var_AE70;
		self.pers["gamemodeLoadout"]["loadoutKillstreak3"] = param_00.var_AE72;
	}

	func_F775(param_00.var_AE6E,param_00.var_AE70,param_00.var_AE72);
	var_06 = 0;
	if(!isagent(self))
	{
		var_06 = scripts\mp\killstreaks\_killstreaks::func_213F([param_00.var_AE6E,param_00.var_AE70,param_00.var_AE72]);
	}

	if(!isagent(self) && !var_06)
	{
		self notify("givingLoadout");
		var_07 = scripts\mp\killstreaks\_killstreaks::func_7ED6();
		var_08 = scripts\mp\killstreaks\_killstreaks::func_7DE7();
		if(!scripts\mp\_utility::_hasperk("specialty_support_killstreaks") && !isdefined(self.var_5FBD))
		{
			scripts\mp\killstreaks\_killstreaks::func_41C0();
		}

		if(isdefined(param_00.var_AE6E) && param_00.var_AE6E != "none" && param_00.var_AE6E != "")
		{
			scripts\mp\killstreaks\_killstreaks::func_66B9(param_00.var_AE6E,param_00.var_AE6F,param_00.loadoutkillstreak1variantid);
		}

		if(isdefined(param_00.var_AE70) && param_00.var_AE70 != "none" && param_00.var_AE70 != "")
		{
			scripts\mp\killstreaks\_killstreaks::func_66BB(param_00.var_AE70,param_00.var_AE71,param_00.loadoutkillstreak2variantid);
		}

		if(isdefined(param_00.var_AE72) && param_00.var_AE72 != "none" && param_00.var_AE72 != "")
		{
			scripts\mp\killstreaks\_killstreaks::func_66BA(param_00.var_AE72,param_00.var_AE73,param_00.loadoutkillstreak3variantid);
		}

		for(var_09 = var_07.size - 1;var_09 >= 0;var_09--)
		{
			scripts\mp\killstreaks\_killstreaks::func_26D5(var_07[var_09]);
		}

		for(var_09 = 0;var_09 < var_08.size;var_09++)
		{
			scripts\mp\killstreaks\_killstreaks::func_26D5(var_08[var_09]);
		}
	}

	self notify("equipKillstreaksFinished");
}

//Function Number: 69
getsortedkillstreaksbycost(param_00)
{
	var_01 = [param_00.var_AE6E,param_00.var_AE70,param_00.var_AE72];
	for(var_02 = 0;var_02 < var_01.size - 1;var_02++)
	{
		if(isdefined(var_01[var_02]) && var_01[var_02] != "none" && var_01[var_02] != "")
		{
			for(var_03 = var_02 + 1;var_03 < var_01.size;var_03++)
			{
				if(isdefined(var_01[var_03]) && var_01[var_03] != "none" && var_01[var_03] != "")
				{
					var_04 = scripts\mp\killstreaks\_killstreaks::func_817B(var_01[var_02]);
					var_05 = scripts\mp\killstreaks\_killstreaks::func_817B(var_01[var_03]);
					if(var_05 < var_04)
					{
						var_06 = var_01[var_03];
						var_01[var_03] = var_01[var_02];
						var_01[var_02] = var_06;
					}
				}
			}
		}
	}

	return var_01;
}

//Function Number: 70
func_AE53(param_00,param_01,param_02)
{
	func_AE5A(param_00);
	func_AE55(param_00);
	func_AE5C(param_00,param_01,param_02);
	func_AE58(param_00);
	func_AE59(param_00);
	func_AE5B(param_00);
	func_AE56(param_00);
	func_AE57(param_00,param_01);
	self.pers["lastClass"] = self.var_4004;
	self.var_A95C = self.var_4004;
	self.var_A93D = self.var_3C56;
	if(isdefined(self.var_7673))
	{
		self.pers["class"] = self.var_7673;
		self.pers["lastClass"] = self.var_7673;
		self.var_4004 = self.var_7673;
		self.var_A95C = self.var_7673;
		self.var_7673 = undefined;
	}
}

//Function Number: 71
func_F7A0(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 notify("setMLGSpectatorClientLoadoutData()");
	param_00 endon("setMLGSpectatorClientLoadoutData()");
	param_00 method_80BE(0,param_01.var_AE89);
	param_00 method_80BE(1,param_01.var_AE9D);
	var_02 = scripts\mp\_powers::func_D738(param_01.var_AE7B);
	param_00 method_80BC("primaryPower",var_02);
	var_03 = scripts\mp\_powers::func_D738(param_01.var_AE7D);
	param_00 method_80BC("secondaryPower",var_03);
	var_04 = scripts\mp\_supers::func_8186(param_01.var_AEAA);
	param_00 method_80BC("super",var_04);
	if(isai(param_00))
	{
		for(var_05 = 0;var_05 < param_01.var_AE79.size;var_05++)
		{
			var_06 = param_01.var_AE79[var_05];
			var_07 = scripts\mp\perks\_perks::func_805A(var_06);
			param_00 method_80BC(var_05 + 1 + "_perk",var_07);
		}
	}
	else
	{
		if(var_04.var_AE7A)
		{
			var_04.var_AEA7 = var_04.var_AE79;
		}

		for(var_05 = 0;var_05 < param_01.var_AEA7.size;var_05++)
		{
			var_06 = param_01.var_AEA7[var_05];
			var_07 = scripts\mp\perks\_perks::func_805A(var_06);
			param_00 method_80BC(var_05 + 1 + "_perk",var_07);
		}

		for(var_05 = 0;var_05 < param_01.var_AE66.size;var_05++)
		{
			var_06 = param_01.var_AE66[var_05];
			var_07 = scripts\mp\perks\_perks::func_805A(var_06);
			param_00 method_80BC(var_05 + 1 + "_extraPerk",var_07);
		}
	}

	var_08 = param_01.var_AE92;
	var_09 = scripts\mp\perks\_perks::func_805A(var_08);
	param_00 method_80BC("rigTrait",var_09);
	var_0A = lib_0D69::func_80F3(param_01.var_AE62);
	param_00 method_80BC("archetype",var_0A);
	param_00 method_80BD(0,param_01.var_AE67);
	param_00 method_80BD(1,param_01.var_AE68);
}

//Function Number: 72
func_FFBB()
{
	return level.ingraceperiod && level.var_8487 - level.ingraceperiod >= 0 && level.var_8487 - level.ingraceperiod < 5 && !self.var_8BE9;
}

//Function Number: 73
func_837A()
{
	func_F691(self.pers["class"]);
	self.var_322 = undefined;
	self.var_113E7 = undefined;
	self.var_11B2C = undefined;
	scripts\mp\_weapons::func_DDEC();
	scripts\mp\_weapons::func_DDF6();
	func_8379(self.pers["team"],self.pers["class"]);
	if(!scripts\mp\_utility::func_766C("prematch_done"))
	{
		scripts\mp\_playerlogic::func_1CA2(self);
	}
}

//Function Number: 74
func_8379(param_00,param_01,param_02)
{
	self notify("giveLoadout_start");
	self.var_81D1 = 1;
	if(isdefined(self.var_CA5B))
	{
		self.oldperks = self.var_CA5B;
	}

	func_AE26();
	var_03 = undefined;
	if(scripts\common\utility::istrue(self.var_400F))
	{
		var_03 = self.var_400E;
		self.var_400F = undefined;
	}
	else
	{
		var_03 = func_AE31();
		var_03 = func_AE48(var_03,param_01);
		self.var_400E = var_03;
	}

	loadout_giveextraweapons(var_03);
	func_AE53(var_03,param_01,param_02);
	func_AE38(var_03,param_01);
	self.var_81D1 = 0;
	self notify("changed_kit");
	self notify("giveLoadout");
}

//Function Number: 75
loadout_giveextraweapons(param_00)
{
}

//Function Number: 76
func_AE38(param_00,param_01)
{
	if(!isplayer(self) && !isalive(self))
	{
		return;
	}

	if(getdvarint("com_codcasterEnabled",0) == 1)
	{
		thread func_F7A0(self,param_00);
	}

	var_02 = scripts\mp\_utility::func_7E2B(param_01);
	var_03 = var_02;
	var_04 = getsubstr(param_01,0,7) == "default";
	if(var_04)
	{
		var_03 = var_03 + 20;
	}

	var_05 = 10;
	var_06 = -1;
	for(var_07 = 0;var_07 < var_05;var_07++)
	{
		var_08 = getmatchdata("players",self.var_41F0,"loadouts",var_07,"slotUsed");
		if(var_08)
		{
			var_09 = getmatchdata("players",self.var_41F0,"loadouts",var_07,"classIndex");
			if(var_09 == var_03)
			{
				var_06 = var_07;
				break;
			}

			continue;
		}

		var_06 = var_07;
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"slotUsed",1);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"classIndex",var_03);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"primaryWeaponSetup","weapon",param_00.var_AE7F);
		for(var_0A = 0;var_0A < 6;var_0A++)
		{
			setmatchdata("players",self.var_41F0,"loadouts",var_07,"primaryWeaponSetup","attachment",var_0A,param_00.var_AE86[var_0A]);
		}

		setmatchdata("players",self.var_41F0,"loadouts",var_07,"primaryWeaponSetup","camo",param_00.var_AE88);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"primaryWeaponSetup","reticle",param_00.var_AE90);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"primaryWeaponSetup","lootItemID",param_00.var_AE8A);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"primaryWeaponSetup","variantID",param_00.var_AE91);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"primaryWeaponSetup","paintJobID",param_00.var_AE8B);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"primaryWeaponSetup","cosmeticAttachment",param_00.loadoutprimarycosmeticattachment);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"secondaryWeaponSetup","weapon",param_00.var_AE94);
		for(var_0A = 0;var_0A < 5;var_0A++)
		{
			setmatchdata("players",self.var_41F0,"loadouts",var_07,"secondaryWeaponSetup","attachment",var_0A,param_00.var_AE9A[var_0A]);
		}

		setmatchdata("players",self.var_41F0,"loadouts",var_07,"secondaryWeaponSetup","camo",param_00.var_AE9C);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"secondaryWeaponSetup","reticle",param_00.var_AEA4);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"secondaryWeaponSetup","lootItemID",param_00.var_AE9E);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"secondaryWeaponSetup","variantID",param_00.var_AEA5);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"secondaryWeaponSetup","paintJobID",param_00.var_AE9F);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"secondaryWeaponSetup","cosmeticAttachment",param_00.loadoutsecondarycosmeticattachment);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"powerSetups",0,"power",param_00.var_AE7B);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"powerSetups",0,"extraCharge",func_3678(var_02));
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"powerSetups",1,"power",param_00.var_AE7D);
		setmatchdata("players",self.var_41F0,"loadouts",var_07,"powerSetups",1,"extraCharge",func_3679(var_02));
		var_0B = param_00.var_AEA7.size;
		if(var_0B > 3)
		{
			var_0B = 3;
		}

		for(var_0C = 0;var_0C < var_0B;var_0C++)
		{
			setmatchdata("players",self.var_41F0,"loadouts",var_07,"loadoutPerks",var_0C,param_00.var_AEA7[var_0C]);
		}

		var_0D = param_00.var_AE66.size;
		if(var_0D > 3)
		{
			var_0D = 3;
		}

		for(var_0C = 0;var_0C < var_0D;var_0C++)
		{
			setmatchdata("players",self.var_41F0,"loadouts",var_07,"extraPerks",var_0C,param_00.var_AE66[var_0C]);
		}

		setmatchdata("players",self.var_41F0,"killstreaks",0,param_00.var_AE6E);
		setmatchdata("players",self.var_41F0,"killstreaks",1,param_00.var_AE70);
		setmatchdata("players",self.var_41F0,"killstreaks",2,param_00.var_AE72);
		if(var_06 == 0)
		{
			self method_859B(self.var_41F0,self.var_8C98,self.model);
			if(isdefined(self.var_AE6C))
			{
				self method_85AB(self.var_41F0,self.var_AE6C);
			}
		}

		break;
	}

	if(isdefined(self.var_B3E3) && scripts\mp\_matchdata::func_38CA(self.var_B3E3))
	{
		if(isdefined(param_00.var_AE62))
		{
			setmatchdata("lives",self.var_B3E3,"archetype",param_00.var_AE62);
		}

		if(isdefined(param_00.var_AE92) && param_00.var_AE92 != "specialty_null")
		{
			setmatchdata("lives",self.var_B3E3,"trait",param_00.var_AE92);
			self.lastmatchdatarigtrait = param_00.var_AE92;
		}
		else if(isdefined(self.lastmatchdatarigtrait))
		{
			setmatchdata("lives",self.var_B3E3,"trait",self.lastmatchdatarigtrait);
		}

		if(isdefined(param_00.var_AEAA))
		{
			setmatchdata("lives",self.var_B3E3,"super",param_00.var_AEAA);
		}

		setmatchdata("lives",self.var_B3E3,"loadoutIndex",var_06);
	}

	self.var_AE6D = var_06;
}

//Function Number: 77
func_8C38()
{
	return isdefined(self.pers) && isdefined(self.pers["validationInfractions"]) && self.pers["validationInfractions"] > 0;
}

//Function Number: 78
func_DDF5()
{
	if(isdefined(self.pers) && isdefined(self.pers["validationInfractions"]))
	{
		self.pers["validationInfractions"] = self.pers["validationInfractions"] + 1;
	}
}

//Function Number: 79
func_11D7()
{
	self.var_8C98 = undefined;
	if(isdefined(self.var_E55A))
	{
		scripts\mp\_utility::func_E54F(1);
	}

	if(isdefined(self.var_E55B))
	{
		scripts\mp\_utility::func_E54F(0);
	}

	self.var_8C1F = 0;
	self detachall();
}

//Function Number: 80
func_9EE1(param_00)
{
	var_01 = tablelookup("mp/perktable.csv",1,param_00,8);
	if(var_01 == "" || var_01 == "specialty_null")
	{
		return 0;
	}

	if(!self isitemunlocked(var_01,"perk"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 81
func_805D(param_00)
{
	var_01 = tablelookup("mp/perktable.csv",1,param_00,8);
	if(var_01 == "" || var_01 == "specialty_null")
	{
		return "specialty_null";
	}

	if(!self isitemunlocked(var_01,"perk"))
	{
		return "specialty_null";
	}

	return var_01;
}

//Function Number: 82
func_11B05()
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

		if(!isdefined(self.var_E55A))
		{
			continue;
		}

		scripts\mp\_utility::func_E554(1);
		self waittill("offhand_end");
		if(scripts\mp\_weapons::func_9F2D(self getcurrentweapon()) && isdefined(self.var_E55B))
		{
			scripts\mp\_utility::func_E554(0);
		}
	}
}

//Function Number: 83
func_11B04()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.var_8C1E = scripts\mp\_utility::func_E552();
	self.var_8C1F = scripts\mp\_weapons::func_9F2D(self.var_4C16);
	if(self.var_8C1E)
	{
		if(self.var_8C1F)
		{
			scripts\mp\_utility::func_E54D(1,scripts\mp\_utility::func_E550());
		}
		else
		{
			scripts\mp\_utility::func_E54D(0,scripts\mp\_utility::func_E550());
		}
	}

	thread func_11B05();
	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 == "none")
		{
			continue;
		}

		var_01 = scripts\mp\_weapons::func_9F2D(var_00);
		var_02 = !var_01 && scripts\mp\_utility::func_E552();
		if(var_01)
		{
			if(!isdefined(self.var_E55A))
			{
				if(isdefined(self.var_E55B))
				{
					scripts\mp\_utility::func_E554(0);
				}
				else
				{
					scripts\mp\_utility::func_E54D(1,scripts\mp\_utility::func_E550());
				}
			}
		}
		else if(var_02)
		{
			if(!isdefined(self.var_E55B))
			{
				if(isdefined(self.var_E55A))
				{
					scripts\mp\_utility::func_E554(1);
				}
				else
				{
					scripts\mp\_utility::func_E54D(0,scripts\mp\_utility::func_E550());
				}
			}
		}
		else
		{
			if(isdefined(self.var_E55A))
			{
				scripts\mp\_utility::func_E54F(1);
			}

			if(isdefined(self.var_E55B))
			{
				scripts\mp\_utility::func_E54F(0);
			}
		}

		self.var_8C1E = var_01 || var_02;
		self.var_8C1F = var_01;
	}
}

//Function Number: 84
updateattachmentsformlg(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02];
		if(var_03 == "ripperrscope_camo")
		{
			var_03 = "ripperrscope_na_camo";
		}
		else if(var_03 == "m8scope_camo")
		{
			var_03 = "m8scope_na_camo";
		}
		else if(var_03 == "arripper" || var_03 == "arm8" || var_03 == "akimbofmg" || var_03 == "glarclassic" || var_03 == "glmp28" || var_03 == "shotgunlongshot" || var_03 == "glsmoke" || var_03 == "glsmoke_slow" || var_03 == "gltacburst" || var_03 == "gltacburst_big" || var_03 == "gltacburst_regen" || var_03 == "glmp28_smoke")
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 85
ismark2weapon(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return param_00 >= 32;
}

//Function Number: 86
isholidayweapon(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0)
	{
		return 0;
	}

	var_02 = scripts\mp\_loot::lookupvariantref(scripts\mp\_utility::func_8234(param_00),param_01);
	return var_02 == "weapon_iw7_ripper_common_3" || var_02 == "weapon_iw7_lmg03_rare_3" || var_02 == "weapon_iw7_ar57_legendary_3";
}

//Function Number: 87
isholidayweaponusingdefaultscope(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_2496("scope",getweaponbasename(param_00));
	return isdefined(var_02) && scripts\common\utility::func_2286(param_01,var_02);
}

//Function Number: 88
issummerholidayweapon(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0)
	{
		return 0;
	}

	var_02 = scripts\mp\_loot::lookupvariantref(scripts\mp\_utility::func_8234(param_00),param_01);
	return var_02 == "weapon_iw7_erad_legendary_4" || var_02 == "weapon_iw7_ake_epic_4" || var_02 == "weapon_iw7_sdflmg_legendary_4" || var_02 == "weapon_iw7_mod2187_legendary_3" || var_02 == "weapon_iw7_longshot_legendary_3";
}

//Function Number: 89
ishalloweenholidayweapon(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0)
	{
		return 0;
	}

	var_02 = scripts\mp\_loot::lookupvariantref(scripts\mp\_utility::func_8234(param_00),param_01);
	return var_02 == "weapon_iw7_kbs_rare_3" || var_02 == "weapon_iw7_ripper_rare_3" || var_02 == "weapon_iw7_m4_rare_3" || var_02 == "weapon_iw7_mod2187_legendary_5" || var_02 == "weapon_iw7_mag_rare_3" || var_02 == "weapon_iw7_minilmg_epic_3";
}

//Function Number: 90
hasscope(param_00)
{
	foreach(var_02 in param_00)
	{
		if(scripts\mp\_utility::getattachmenttype(var_02) == "rail")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 91
func_3224(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	param_01 = scripts\mp\_utility::func_13C7A(param_01);
	param_01 = scripts\common\utility::func_22A9(param_01,"none");
	var_09 = scripts\mp\_utility::func_13C76(param_00);
	var_0A = func_3220(param_00,param_04);
	if(isdefined(self.var_81D1) && self.var_81D1)
	{
		var_0B = func_80C6(var_0A,param_04,param_01);
		if(var_0B.size > 0)
		{
			param_01 = scripts\common\utility::func_2284(param_01,var_0B);
			foreach(var_0D in var_0B)
			{
				scripts\mp\perks\_weaponpassives::func_3E2F("passive_random_attachments","_" + scripts\mp\_utility::func_2496(var_0D,var_0A));
			}
		}
	}

	for(var_0F = 0;var_0F < param_01.size;var_0F++)
	{
		param_01[var_0F] = scripts\mp\_utility::func_2496(param_01[var_0F],var_0A);
	}

	if(isdefined(var_09))
	{
		for(var_0F = 0;var_0F < var_09.size;var_0F++)
		{
			var_09[var_0F] = scripts\mp\_utility::func_2496(var_09[var_0F],var_0A);
		}
	}

	if(isdefined(var_09))
	{
		param_01 = scripts\common\utility::func_2284(param_01,var_09);
	}

	if(isdefined(param_04))
	{
		var_10 = func_823A(var_0A,param_04);
		if(var_10.size > 0)
		{
			param_01 = scripts\common\utility::func_2284(param_01,var_10);
		}
	}

	if(isdefined(param_08) && param_08 != "none")
	{
		param_01[param_01.size] = param_08;
	}

	if(param_01.size > 0)
	{
		param_01 = func_6C18(param_01);
	}

	var_11 = [];
	foreach(var_13 in param_01)
	{
		var_14 = scripts\mp\_utility::func_2495(var_13);
		if(isdefined(var_14))
		{
			var_11[var_11.size] = scripts\mp\_utility::func_2496(var_14,var_0A);
		}
	}

	if(var_11.size > 0)
	{
		param_01 = scripts\common\utility::func_2284(param_01,var_11);
	}

	if(scripts\mp\_utility::func_9D46())
	{
		param_01 = updateattachmentsformlg(param_01);
	}

	if(param_01.size > 0)
	{
		param_01 = scripts\common\utility::func_1D3A(param_01);
	}

	foreach(var_17 in param_01)
	{
		var_0A = var_0A + "+" + var_17;
	}

	if(issubstr(var_0A,"iw7"))
	{
		var_0A = func_3225(var_0A,param_02,param_04);
		var_19 = 0;
		if(isholidayweapon(var_0A,param_04) || issummerholidayweapon(var_0A,param_04) || ishalloweenholidayweapon(var_0A,param_04))
		{
			var_19 = isholidayweaponusingdefaultscope(var_0A,param_01);
		}

		if(hasscope(param_01))
		{
			if(var_19 && !issubstr(var_0A,"iw7_longshot") && !issubstr(var_0A,"iw7_kbs"))
			{
				if(ishalloweenholidayweapon(var_0A,param_04))
				{
					var_0A = var_0A + "+scope" + gethalloweenscopenumber(var_0A,param_04);
				}
				else
				{
					var_0A = var_0A + "+scope1";
				}
			}
			else
			{
				var_0A = func_3227(var_0A,param_03);
			}
		}

		var_0A = func_3228(var_0A,param_04);
	}

	return var_0A;
}

//Function Number: 92
gethalloweenscopenumber(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0)
	{
		return 0;
	}

	var_02 = scripts\mp\_loot::lookupvariantref(scripts\mp\_utility::func_8234(param_00),param_01);
	var_03 = 0;
	switch(var_02)
	{
		case "weapon_iw7_minilmg_epic_3":
			var_03 = 1;
			break;

		case "weapon_iw7_mod2187_legendary_5":
		case "weapon_iw7_ripper_rare_3":
			var_03 = 2;
			break;
	}

	return var_03;
}

//Function Number: 93
func_80C6(param_00,param_01,param_02)
{
	var_03 = [];
	if(func_13C96(param_00,param_01,"passive_random_attachments"))
	{
		if(1)
		{
			var_04 = func_7DE6(param_00,param_02,0);
			var_03[var_03.size] = var_04[randomint(var_04.size)];
		}
		else
		{
			var_05 = randomintrange(1,2);
			var_03 = func_3217(param_00,var_05,param_02);
		}
	}

	return var_03;
}

//Function Number: 94
func_11754(param_00,param_01)
{
	var_02 = func_7DE6(param_00,[],0);
	foreach(var_04 in var_02)
	{
		scripts\mp\perks\_weaponpassives::func_11751("passive_random_attachments","_" + scripts\mp\_utility::func_2496(var_04,param_00));
	}
}

//Function Number: 95
func_3217(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = func_7DE2(param_00,param_02);
	if(var_04.size > 0)
	{
		var_03 = [];
		var_05 = scripts\common\utility::func_22A8(var_04);
		foreach(var_0A, var_07 in var_05)
		{
			if(param_01 <= 0)
			{
				break;
			}

			var_08 = 1;
			switch(var_0A)
			{
				case "undermount":
				case "barrel":
					var_08 = 1;
					break;

				case "rail":
					var_08 = 0;
					break;

				default:
					var_08 = randomintrange(1,param_01 + 1);
					break;
			}

			if(var_08 > 0)
			{
				if(var_08 > var_07.size)
				{
					var_08 = var_07.size;
				}

				param_01 = param_01 - var_08;
				var_07 = scripts\common\utility::func_22A8(var_07);
				while(var_08 > 0)
				{
					var_09 = var_07[var_07.size - var_08];
					var_03[var_03.size] = var_09;
					var_08--;
				}
			}
		}
	}

	return var_03;
}

//Function Number: 96
func_7DE2(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_8217(param_00);
	var_03 = [];
	foreach(var_05 in var_02)
	{
		var_06 = scripts\mp\_utility::getattachmenttype(var_05);
		if(func_AD7F(param_01,var_05))
		{
			continue;
		}

		if(!isdefined(var_03[var_06]))
		{
			var_03[var_06] = [];
		}

		var_07 = var_03[var_06];
		var_07[var_07.size] = var_05;
		var_03[var_06] = var_07;
	}

	return var_03;
}

//Function Number: 97
func_7DE6(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = scripts\mp\_utility::func_8217(param_00);
	var_04 = [];
	foreach(var_06 in var_03)
	{
		var_07 = scripts\mp\_utility::getattachmenttype(var_06);
		if(!param_02 && var_07 == "rail")
		{
			continue;
		}

		if(func_AD7F(param_01,var_06))
		{
			continue;
		}

		var_04[var_04.size] = var_06;
	}

	return var_04;
}

//Function Number: 98
func_AD7F(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(var_03 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 99
func_80B0(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_8217(param_00);
	return func_80B2(var_02,param_01);
}

//Function Number: 100
func_80B3(param_00,param_01,param_02)
{
	var_03 = scripts\mp\_utility::func_821B(param_00,param_01);
	return func_80B2(var_03,param_02);
}

//Function Number: 101
func_80B2(param_00,param_01)
{
	if(param_00.size > 0)
	{
		param_00 = scripts\common\utility::array_randomize(param_00);
		if(param_01 > param_00.size)
		{
			param_01 = param_00.size;
		}

		var_02 = [];
		while(param_01 > 0 && param_00.size > 0)
		{
			var_03 = param_00[param_00.size - param_01];
			var_02[var_02.size] = var_03;
			param_01--;
		}

		if(var_02.size > 0)
		{
			return var_02;
		}
	}

	return param_00;
}

//Function Number: 102
func_6C18(param_00)
{
	var_01 = [];
	if(isdefined(param_00))
	{
		foreach(var_03 in param_00)
		{
			if(var_03 == "none")
			{
				continue;
			}

			var_04 = 1;
			foreach(var_06 in var_01)
			{
				if(var_03 == var_06)
				{
					var_04 = 0;
					break;
				}

				if(!scripts\mp\_utility::func_249D(var_03,var_06))
				{
					var_04 = 0;
					break;
				}
			}

			if(var_04)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 103
func_3220(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0)
	{
		return scripts\mp\_utility::func_13C75(param_00);
	}

	var_02 = scripts\mp\_loot::func_8215(param_00,param_01);
	return var_02;
}

//Function Number: 104
func_3225(param_00,param_01,param_02)
{
	var_03 = -1;
	if(isholidayweapon(param_00,param_02))
	{
		var_03 = int(tablelookup("mp/camoTable.csv",1,"camo89",scripts\common\utility::getcamotablecolumnindex("weapon_index")));
		return param_00 + "+camo" + var_03;
	}
	else if(issummerholidayweapon(param_00,param_02))
	{
		var_03 = int(tablelookup("mp/camoTable.csv",1,"camo230",scripts\common\utility::getcamotablecolumnindex("weapon_index")));
		return param_00 + "+camo" + var_03;
	}
	else if(ishalloweenholidayweapon(param_00,param_02))
	{
		var_03 = int(tablelookup("mp/camoTable.csv",1,"camo242",scripts\common\utility::getcamotablecolumnindex("weapon_index")));
		return param_00 + "+camo" + var_03;
	}
	else if((!isdefined(param_01) || param_01 == "none") && ismark2weapon(param_02))
	{
		var_04 = scripts\mp\_loot::getweaponqualitybyid(param_00,param_02);
		var_05 = undefined;
		switch(var_04)
		{
			case 1:
						var_05 = "camo99";
						break;

			case 2:
						var_05 = "camo101";
						break;

			case 3:
						var_05 = "camo102";
						break;

			case 4:
						var_05 = "camo103";
						break;

			default:
						break;
		}

		var_03 = int(tablelookup("mp/camoTable.csv",1,var_05,scripts\common\utility::getcamotablecolumnindex("weapon_index")));
		return param_00 + "+camo" + var_03;
	}

	if(!isdefined(var_03))
	{
		var_05 = 0;
	}
	else
	{
		var_05 = int(tablelookup("mp/camoTable.csv",1,var_03,scripts\common\utility::getcamotablecolumnindex("weapon_index")));
	}

	if(var_05 <= 0)
	{
		var_04 = scripts\mp\_loot::getweaponqualitybyid(param_02,var_04);
		var_05 = undefined;
		switch(var_04)
		{
			case 1:
				var_05 = "camo24";
				break;

			case 2:
				var_05 = "camo19";
				break;

			case 3:
				var_05 = "camo18";
				break;

			default:
				break;
		}

		if(isdefined(var_05))
		{
			var_03 = int(tablelookup("mp/camoTable.csv",1,var_05,scripts\common\utility::getcamotablecolumnindex("weapon_index")));
		}
		else
		{
			return param_00;
		}
	}

	return param_00 + "+camo" + var_03;
}

//Function Number: 105
func_3227(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return param_00;
	}

	var_02 = int(tablelookup("mp/reticleTable.csv",1,param_01,5));
	if(!isdefined(var_02) || var_02 == 0)
	{
		return param_00;
	}

	param_00 = param_00 + "+scope" + var_02;
	return param_00;
}

//Function Number: 106
func_3228(param_00,param_01)
{
	if(!isdefined(param_01) || param_01 < 0)
	{
		return param_00;
	}

	param_00 = param_00 + "+loot" + param_01;
	return param_00;
}

//Function Number: 107
func_8229(param_00,param_01)
{
	return scripts\mp\_loot::func_804C(func_3228(param_00,param_01));
}

//Function Number: 108
func_13C96(param_00,param_01,param_02)
{
	var_03 = func_8229(param_00,param_01);
	if(!isdefined(var_03) || var_03.size <= 0)
	{
		return 0;
	}

	foreach(var_05 in var_03)
	{
		if(param_02 == var_05)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 109
func_823A(param_00,param_01)
{
	var_02 = [];
	var_03 = func_8229(param_00,param_01);
	if(isdefined(var_03))
	{
		foreach(var_05 in var_03)
		{
			var_06 = scripts\mp\_passives::func_8048(var_05);
			if(!isdefined(var_06))
			{
				continue;
			}

			var_02[var_02.size] = var_06;
		}
	}

	return var_02;
}

//Function Number: 110
func_F775(param_00,param_01,param_02)
{
	self.var_A6AB = [];
	var_03 = [];
	if(isdefined(param_00) && param_00 != "none")
	{
		var_04 = scripts\mp\killstreaks\_killstreaks::func_817B(param_00);
		var_03[var_04] = param_00;
	}

	if(isdefined(param_01) && param_01 != "none")
	{
		var_04 = scripts\mp\killstreaks\_killstreaks::func_817B(param_01);
		var_03[var_04] = param_01;
	}

	if(isdefined(param_02) && param_02 != "none")
	{
		var_04 = scripts\mp\killstreaks\_killstreaks::func_817B(param_02);
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
		self.var_A6AB[var_08] = var_03[var_08];
	}
}

//Function Number: 111
func_E19F()
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

	if(self method_80FB(level.var_400A[var_01]["primary"]["type"]) < level.var_400A[var_01]["primary"]["count"])
	{
		self setweaponammoclip(level.var_400A[var_01]["primary"]["type"],level.var_400A[var_01]["primary"]["count"]);
	}

	if(self method_80FB(level.var_400A[var_01]["secondary"]["type"]) < level.var_400A[var_01]["secondary"]["count"])
	{
		self setweaponammoclip(level.var_400A[var_01]["secondary"]["type"],level.var_400A[var_01]["secondary"]["count"]);
	}
}

//Function Number: 112
func_C572()
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

		var_00.var_4004 = var_00.pers["class"];
		var_00.var_A95C = var_00.pers["lastClass"];
		var_00.var_53AD = 0;
		var_00.var_2C66 = [];
		var_00.var_2C67 = [];
		var_00.var_3C56 = var_00.pers["changedArchetypeInfo"];
		var_00.var_A93D = undefined;
		if(!isai(var_00) && !scripts\common\utility::istrue(var_00.btestclient))
		{
			var_00 setclientomnvar("ui_selected_archetype",level.var_2127[var_00 func_3676()]);
			var_00 setclientomnvar("ui_selected_super",scripts\mp\_supers::func_8186(var_00 func_3688()));
			var_00 setclientomnvar("ui_selected_trait",scripts\mp\perks\_perks::func_805A(var_00 func_367E()));
		}

		if(!isdefined(var_00.pers["validationInfractions"]))
		{
			var_00.pers["validationInfractions"] = 0;
		}
	}
}

//Function Number: 113
func_6AB2(param_00,param_01)
{
	wait(param_00);
	self fadeovertime(param_01);
	self.alpha = 0;
}

//Function Number: 114
func_F691(param_00)
{
	self.var_4B1C = param_00;
}

//Function Number: 115
func_9E63(param_00)
{
	return scripts\mp\_utility::func_7F44(param_00) != -1;
}

//Function Number: 116
func_8BDC()
{
	if((isdefined(self.var_A95C) && self.var_A95C != self.var_4004) || !isdefined(self.var_A95C))
	{
		return 1;
	}

	if(level.gametype == "infect" && !isdefined(self.var_A8D0) || self.var_A8D0 != self.var_9419)
	{
		return 1;
	}

	return 0;
}

//Function Number: 117
func_8BDB()
{
	if(isdefined(self.var_3C56))
	{
		if(!isdefined(self.var_A93D))
		{
			return 1;
		}

		if(self.var_3C56 != self.var_A93D)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 118
func_E243()
{
	scripts\mp\_utility::_setactionslot(1,"");
	scripts\mp\_utility::_setactionslot(2,"");
	scripts\mp\_utility::_setactionslot(3,"");
	scripts\mp\_utility::_setactionslot(4,"");
	if(!level.console)
	{
		scripts\mp\_utility::_setactionslot(5,"");
		scripts\mp\_utility::_setactionslot(6,"");
		scripts\mp\_utility::_setactionslot(7,"");
	}
}

//Function Number: 119
func_E250()
{
	self method_80CD(0);
	self setclientomnvar("ui_hide_hud",0);
	self setclientomnvar("ui_hide_minimap",0);
	self.var_55E4 = undefined;
	self.var_55D5 = undefined;
	self.var_55C8 = undefined;
	self.var_55BE = undefined;
	self.var_55E6 = undefined;
	self.disabledweaponswitch = undefined;
	self.var_55D9 = undefined;
	self.var_55DC = undefined;
	self.var_55C3 = undefined;
	self.var_55E2 = undefined;
	self.var_55D0 = undefined;
	self.var_55C6 = undefined;
	self.var_5AE0 = undefined;
	self.var_5AE1 = undefined;
	self.var_55D4 = undefined;
	self.var_55E1 = undefined;
	self.var_55E0 = undefined;
	self.var_55E5 = undefined;
	self.var_6262 = undefined;
	self.var_6263 = undefined;
	self.var_8EC7 = undefined;
	self.var_8ECE = undefined;
	self.var_9F80 = undefined;
	self.var_9D6B = undefined;
	self.nocorpse = undefined;
	self.var_D84C = undefined;
	scripts\mp\_damage::func_E247();
	scripts\mp\_damage::clearcorpsetablefuncs();
	scripts\mp\killstreaks\_chill_common::func_3E70();
	scripts\mp\perks\_weaponpassives::passivecolddamageresetdata(self);
	scripts\mp\_utility::_resetenableignoreme();
}

//Function Number: 120
func_41D8()
{
	self setscriptablepartstate("CompassIcon","defaultIcon");
	scripts\mp\killstreaks\_chill_common::func_3E71();
	scripts\mp\perks\_weaponpassives::passivecolddamageresetscriptable(self);
	lib_0D6F::func_B946();
	lib_0DDF::func_E26A();
}

//Function Number: 121
func_3C53(param_00,param_01,param_02)
{
	if(isdefined(self.var_3C56))
	{
		var_03 = self.var_3C56;
		if(var_03.var_2123 == param_00 && var_03.var_11234 == param_01 && var_03.var_11B2C == param_02)
		{
			return;
		}
	}

	var_04 = spawnstruct();
	var_04.var_2123 = param_00;
	var_04.var_11234 = param_01;
	var_04.var_11B2C = param_02;
	self.var_3C56 = var_04;
	self.pers["changedArchetypeInfo"] = var_04;
	if(!isai(self))
	{
		self setclientomnvar("ui_selected_archetype",level.var_2127[param_00]);
		self setclientomnvar("ui_selected_super",scripts\mp\_supers::func_8186(param_01));
		self setclientomnvar("ui_selected_trait",scripts\mp\perks\_perks::func_805A(param_02));
	}

	if(isdefined(self.pers["class"]) && self.pers["class"] != "")
	{
		scripts\mp\_menus::func_D848(self.pers["class"]);
		if(func_FFBB())
		{
			func_837A();
			return;
		}

		if(isalive(self))
		{
			self iprintlnbold(game["strings"]["change_rig"]);
			return;
		}
	}
}

//Function Number: 122
func_7DE0(param_00,param_01)
{
	var_02 = scripts\common\utility::func_116D7(param_01 == "primary","loadoutPrimaryAttachment","loadoutSecondaryAttachment");
	if(param_00 == 0)
	{
		return var_02;
	}

	return var_02 + param_00 + 1;
}

//Function Number: 123
func_7F9E()
{
	return 6;
}

//Function Number: 124
func_7FA0()
{
	return 5;
}

//Function Number: 125
func_7F96(param_00)
{
	return scripts\common\utility::func_116D7(param_00 == "primary",func_7F9E(),func_7FA0());
}