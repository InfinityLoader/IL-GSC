/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_class.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

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
	level.classmap["copycat"] = -1;
	level.defaultclass = "CLASS_ASSAULT";
	level.classtablename = "mp/classTable.csv";
	precacheshader("specialty_pistoldeath");
	precacheshader("specialty_finalstand");
	level thread onplayerconnecting();
}

getclasschoice(response)
{
	return response;
}

getweaponchoice(response)
{
	tokens = strtok(response, ",");
	if(tokens.size > 1)
	{
		return int(tokens[1]);
	}

	return 0;
}

logclasschoice(class, primaryweapon, specialtype, perks)
{
	if(class == self.lastclass)
	{
		return;
	}

	self logstring("choseclass: " + class + " weapon: " + primaryweapon + " special: " + specialtype);
	for(i = 0;i < perks.size;i++)
	{
		self logstring("perk" + i + ": " + perks[i]);
	}

	self.lastclass = class;
}

cac_getweapon(classindex, weaponindex)
{
	return self getplayerdata("customClasses", classindex, "weaponSetups", weaponindex, "weapon");
}

cac_getweaponattachment(classindex, weaponindex)
{
	return self getplayerdata("customClasses", classindex, "weaponSetups", weaponindex, "attachment", 0);
}

cac_getweaponattachmenttwo(classindex, weaponindex)
{
	return self getplayerdata("customClasses", classindex, "weaponSetups", weaponindex, "attachment", 1);
}

cac_getweaponcamo(classindex, weaponindex)
{
	return self getplayerdata("customClasses", classindex, "weaponSetups", weaponindex, "camo");
}

cac_getperk(classindex, perkindex)
{
	return self getplayerdata("customClasses", classindex, "perks", perkindex);
}

cac_getkillstreak(classindex, streakindex)
{
	return self getplayerdata("killstreaks", streakindex);
}

cac_getdeathstreak(classindex)
{
	return self getplayerdata("customClasses", classindex, "perks", 4);
}

cac_getoffhand(classindex)
{
	return self getplayerdata("customClasses", classindex, "specialGrenade");
}

table_getweapon(tablename, classindex, weaponindex)
{
	if(weaponindex == 0)
	{
		return tablelookup(tablename, 0, "loadoutPrimary", classindex + 1);
	}

	return tablelookup(tablename, 0, "loadoutSecondary", classindex + 1);
}

table_getweaponattachment(tablename, classindex, weaponindex, attachmentindex)
{
	tempname = "none";
	if(weaponindex == 0)
	{
		if(!isdefined(attachmentindex) || attachmentindex == 0)
		{
			tempname = tablelookup(tablename, 0, "loadoutPrimaryAttachment", classindex + 1);
		}
		else
		{
			tempname = tablelookup(tablename, 0, "loadoutPrimaryAttachment2", classindex + 1);
		}
	}
	else if(!isdefined(attachmentindex) || attachmentindex == 0)
	{
		tempname = tablelookup(tablename, 0, "loadoutSecondaryAttachment", classindex + 1);
	}
	else
	{
		tempname = tablelookup(tablename, 0, "loadoutSecondaryAttachment2", classindex + 1);
	}

	if(tempname == "" || tempname == "none")
	{
		return "none";
	}

	return tempname;
}

table_getweaponcamo(tablename, classindex, weaponindex)
{
	if(weaponindex == 0)
	{
		return tablelookup(tablename, 0, "loadoutPrimaryCamo", classindex + 1);
	}

	return tablelookup(tablename, 0, "loadoutSecondaryCamo", classindex + 1);
}

table_getequipment(tablename, classindex, perkindex)
{
	return tablelookup(tablename, 0, "loadoutEquipment", classindex + 1);
}

table_getperk(tablename, classindex, perkindex)
{
	return tablelookup(tablename, 0, "loadoutPerk" + perkindex, classindex + 1);
}

table_getoffhand(tablename, classindex)
{
	return tablelookup(tablename, 0, "loadoutOffhand", classindex + 1);
}

table_getkillstreak(tablename, classindex, streakindex)
{
	return "none";
}

table_getdeathstreak(tablename, classindex)
{
	return tablelookup(tablename, 0, "loadoutDeathstreak", classindex + 1);
}

getclassindex(classname)
{
	return level.classmap[classname];
}

cloneloadout()
{
	clonedloadout = [];
	class = self.curclass;
	if(class == "copycat")
	{
		return undefined;
	}

	if(issubstr(class, "custom"))
	{
		class_num = getclassindex(class);
		loadoutprimaryattachment2 = "none";
		loadoutsecondaryattachment2 = "none";
		loadoutprimary = cac_getweapon(class_num, 0);
		loadoutprimaryattachment = cac_getweaponattachment(class_num, 0);
		loadoutprimaryattachment2 = cac_getweaponattachmenttwo(class_num, 0);
		loadoutprimarycamo = cac_getweaponcamo(class_num, 0);
		loadoutsecondarycamo = cac_getweaponcamo(class_num, 1);
		loadoutsecondary = cac_getweapon(class_num, 1);
		loadoutsecondaryattachment = cac_getweaponattachment(class_num, 1);
		loadoutsecondaryattachment2 = cac_getweaponattachmenttwo(class_num, 1);
		loadoutsecondarycamo = cac_getweaponcamo(class_num, 1);
		loadoutequipment = cac_getperk(class_num, 0);
		loadoutperk1 = cac_getperk(class_num, 1);
		loadoutperk2 = cac_getperk(class_num, 2);
		loadoutperk3 = cac_getperk(class_num, 3);
		loadoutoffhand = cac_getoffhand(class_num);
		loadoutdeathstreak = cac_getdeathstreak(class_num);
	}
	else
	{
		class_num = getclassindex(class);
		loadoutprimary = table_getweapon(level.classtablename, class_num, 0);
		loadoutprimaryattachment = table_getweaponattachment(level.classtablename, class_num, 0, 0);
		loadoutprimaryattachment2 = table_getweaponattachment(level.classtablename, class_num, 0, 1);
		loadoutprimarycamo = table_getweaponcamo(level.classtablename, class_num, 0);
		loadoutsecondary = table_getweapon(level.classtablename, class_num, 1);
		loadoutsecondaryattachment = table_getweaponattachment(level.classtablename, class_num, 1, 0);
		loadoutsecondaryattachment2 = table_getweaponattachment(level.classtablename, class_num, 1, 1);
		loadoutsecondarycamo = table_getweaponcamo(level.classtablename, class_num, 1);
		loadoutequipment = table_getequipment(level.classtablename, class_num, 0);
		loadoutperk1 = table_getperk(level.classtablename, class_num, 1);
		loadoutperk2 = table_getperk(level.classtablename, class_num, 2);
		loadoutperk3 = table_getperk(level.classtablename, class_num, 3);
		loadoutoffhand = table_getoffhand(level.classtablename, class_num);
		loadoutdeathstreak = table_getdeathstreak(level.classtablename, class_num);
	}

	clonedloadout["inUse"] = 0;
	clonedloadout["loadoutPrimary"] = loadoutprimary;
	clonedloadout["loadoutPrimaryAttachment"] = loadoutprimaryattachment;
	clonedloadout["loadoutPrimaryAttachment2"] = loadoutprimaryattachment2;
	clonedloadout["loadoutPrimaryCamo"] = loadoutprimarycamo;
	clonedloadout["loadoutSecondary"] = loadoutsecondary;
	clonedloadout["loadoutSecondaryAttachment"] = loadoutsecondaryattachment;
	clonedloadout["loadoutSecondaryAttachment2"] = loadoutsecondaryattachment2;
	clonedloadout["loadoutSecondaryCamo"] = loadoutsecondarycamo;
	clonedloadout["loadoutEquipment"] = loadoutequipment;
	clonedloadout["loadoutPerk1"] = loadoutperk1;
	clonedloadout["loadoutPerk2"] = loadoutperk2;
	clonedloadout["loadoutPerk3"] = loadoutperk3;
	clonedloadout["loadoutOffhand"] = loadoutoffhand;
	return clonedloadout;
}

giveloadout(team, class, allowcopycat)
{
	self takeallweapons();
	primaryindex = 0;
	self.specialty = [];
	if(!isdefined(allowcopycat))
	{
		allowcopycat = 1;
	}

	primaryweapon = undefined;
	if(isdefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && allowcopycat)
	{
		setclass("copycat");
		self.class_num = getclassindex("copycat");
		clonedloadout = self.pers["copyCatLoadout"];
		loadoutprimary = clonedloadout["loadoutPrimary"];
		loadoutprimaryattachment = clonedloadout["loadoutPrimaryAttachment"];
		loadoutprimaryattachment2 = clonedloadout["loadoutPrimaryAttachment2"];
		loadoutprimarycamo = clonedloadout["loadoutPrimaryCamo"];
		loadoutsecondary = clonedloadout["loadoutSecondary"];
		loadoutsecondaryattachment = clonedloadout["loadoutSecondaryAttachment"];
		loadoutsecondaryattachment2 = clonedloadout["loadoutSecondaryAttachment2"];
		loadoutsecondarycamo = clonedloadout["loadoutSecondaryCamo"];
		loadoutequipment = clonedloadout["loadoutEquipment"];
		loadoutperk1 = clonedloadout["loadoutPerk1"];
		loadoutperk2 = clonedloadout["loadoutPerk2"];
		loadoutperk3 = clonedloadout["loadoutPerk3"];
		loadoutoffhand = clonedloadout["loadoutOffhand"];
		loadoutdeathstreak = "specialty_copycat";
	}
	else if(issubstr(class, "custom"))
	{
		class_num = getclassindex(class);
		self.class_num = class_num;
		loadoutprimary = cac_getweapon(class_num, 0);
		loadoutprimaryattachment = cac_getweaponattachment(class_num, 0);
		loadoutprimaryattachment2 = cac_getweaponattachmenttwo(class_num, 0);
		loadoutprimarycamo = cac_getweaponcamo(class_num, 0);
		loadoutsecondarycamo = cac_getweaponcamo(class_num, 1);
		loadoutsecondary = cac_getweapon(class_num, 1);
		loadoutsecondaryattachment = cac_getweaponattachment(class_num, 1);
		loadoutsecondaryattachment2 = cac_getweaponattachmenttwo(class_num, 1);
		loadoutsecondarycamo = cac_getweaponcamo(class_num, 1);
		loadoutequipment = cac_getperk(class_num, 0);
		loadoutperk1 = cac_getperk(class_num, 1);
		loadoutperk2 = cac_getperk(class_num, 2);
		loadoutperk3 = cac_getperk(class_num, 3);
		loadoutoffhand = cac_getoffhand(class_num);
		loadoutdeathstreak = cac_getdeathstreak(class_num);
	}
	else
	{
		class_num = getclassindex(class);
		self.class_num = class_num;
		loadoutprimary = table_getweapon(level.classtablename, class_num, 0);
		loadoutprimaryattachment = table_getweaponattachment(level.classtablename, class_num, 0, 0);
		loadoutprimaryattachment2 = table_getweaponattachment(level.classtablename, class_num, 0, 1);
		loadoutprimarycamo = table_getweaponcamo(level.classtablename, class_num, 0);
		loadoutsecondarycamo = table_getweaponcamo(level.classtablename, class_num, 1);
		loadoutsecondary = table_getweapon(level.classtablename, class_num, 1);
		loadoutsecondaryattachment = table_getweaponattachment(level.classtablename, class_num, 1, 0);
		loadoutsecondaryattachment2 = table_getweaponattachment(level.classtablename, class_num, 1, 1);
		loadoutsecondarycamo = table_getweaponcamo(level.classtablename, class_num, 1);
		loadoutequipment = table_getequipment(level.classtablename, class_num, 0);
		loadoutperk1 = table_getperk(level.classtablename, class_num, 1);
		loadoutperk2 = table_getperk(level.classtablename, class_num, 2);
		loadoutperk3 = table_getperk(level.classtablename, class_num, 3);
		loadoutoffhand = table_getoffhand(level.classtablename, class_num);
		loadoutdeathstreak = table_getdeathstreak(level.classtablename, class_num);
	}

	if(!isdefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && allowcopycat)
	{
		iscustomclass = issubstr(class, "custom");
		if(!isvalidprimary(loadoutprimary) || iscustomclass && !self isitemunlocked(loadoutprimary))
		{
			loadoutprimary = table_getweapon(level.classtablename, 10, 0);
		}

		if(!isvalidattachment(loadoutprimaryattachment) || iscustomclass && !self isitemunlocked(loadoutprimary + " " + loadoutprimaryattachment))
		{
			loadoutprimaryattachment = table_getweaponattachment(level.classtablename, 10, 0, 0);
		}

		if(!isvalidattachment(loadoutprimaryattachment2) || iscustomclass && !self isitemunlocked(loadoutprimary + " " + loadoutprimaryattachment2))
		{
			loadoutprimaryattachment2 = table_getweaponattachment(level.classtablename, 10, 0, 1);
		}

		if(!isvalidcamo(loadoutprimarycamo) || iscustomclass && !self isitemunlocked(loadoutprimary + " " + loadoutprimarycamo))
		{
			loadoutprimarycamo = table_getweaponcamo(level.classtablename, 10, 0);
		}

		if(!isvalidsecondary(loadoutsecondary) || iscustomclass && !self isitemunlocked(loadoutsecondary))
		{
			loadoutsecondary = table_getweapon(level.classtablename, 10, 1);
		}

		if(!isvalidattachment(loadoutsecondaryattachment) || iscustomclass && !self isitemunlocked(loadoutsecondary + " " + loadoutsecondaryattachment))
		{
			loadoutsecondaryattachment = table_getweaponattachment(level.classtablename, 10, 1, 0);
		}

		if(!isvalidattachment(loadoutsecondaryattachment2) || iscustomclass && !self isitemunlocked(loadoutsecondary + " " + loadoutsecondaryattachment2))
		{
			loadoutsecondaryattachment2 = table_getweaponattachment(level.classtablename, 10, 1, 1);
		}

		if(!isvalidcamo(loadoutsecondarycamo) || iscustomclass && !self isitemunlocked(loadoutsecondary + " " + loadoutsecondarycamo))
		{
			loadoutsecondarycamo = table_getweaponcamo(level.classtablename, 10, 1);
		}

		if(!isvalidequipment(loadoutequipment) || iscustomclass && !self isitemunlocked(loadoutequipment))
		{
			loadoutequipment = table_getequipment(level.classtablename, 10, 0);
		}

		if(!isvalidperk1(loadoutperk1) || iscustomclass && !self isitemunlocked(loadoutperk1))
		{
			loadoutperk1 = table_getperk(level.classtablename, 10, 1);
		}

		if(!isvalidperk2(loadoutperk2) || iscustomclass && !self isitemunlocked(loadoutperk2))
		{
			loadoutperk2 = table_getperk(level.classtablename, 10, 2);
		}

		if(!isvalidperk3(loadoutperk3) || iscustomclass && !self isitemunlocked(loadoutperk3))
		{
			loadoutperk3 = table_getperk(level.classtablename, 10, 3);
		}

		if(!isvalidoffhand(loadoutoffhand))
		{
			loadoutoffhand = table_getoffhand(level.classtablename, 10);
		}

		if(!isvaliddeathstreak(loadoutdeathstreak) || iscustomclass && !self isitemunlocked(loadoutdeathstreak))
		{
			loadoutdeathstreak = table_getdeathstreak(level.classtablename, 10);
		}
	}

	if(loadoutperk1 != "specialty_bling")
	{
		loadoutprimaryattachment2 = "none";
		loadoutsecondaryattachment2 = "none";
	}

	if(loadoutperk1 != "specialty_onemanarmy" && loadoutsecondary == "onemanarmy")
	{
		loadoutsecondary = table_getweapon(level.classtablename, 10, 1);
	}

	loadoutsecondarycamo = "none";
	if(level.killstreakrewards)
	{
		loadoutkillstreak1 = self getplayerdata("killstreaks", 0);
		loadoutkillstreak2 = self getplayerdata("killstreaks", 1);
		loadoutkillstreak3 = self getplayerdata("killstreaks", 2);
	}
	else
	{
		loadoutkillstreak1 = "none";
		loadoutkillstreak2 = "none";
		loadoutkillstreak3 = "none";
	}

	secondaryname = buildweaponname(loadoutsecondary, loadoutsecondaryattachment, loadoutsecondaryattachment2);
	maps\mp\_utility::_giveweapon(secondaryname, int(tablelookup("mp/camoTable.csv", 1, loadoutsecondarycamo, 0)));
	self.loadoutprimarycamo = int(tablelookup("mp/camoTable.csv", 1, loadoutprimarycamo, 0));
	self.loadoutprimary = loadoutprimary;
	self.loadoutsecondary = loadoutsecondary;
	self.loadoutsecondarycamo = int(tablelookup("mp/camoTable.csv", 1, loadoutsecondarycamo, 0));
	self setoffhandprimaryclass("other");
	maps\mp\_utility::_setactionslot(1, "");
	maps\mp\_utility::_setactionslot(3, "altMode");
	maps\mp\_utility::_setactionslot(4, "");
	maps\mp\_utility::_clearperks();
	_detachall();
	if(level.diehardmode)
	{
		maps\mp\perks\_perks::giveperk("specialty_pistoldeath");
	}

	if(loadoutdeathstreak != "specialty_null" && gettime() == self.spawntime)
	{
		deathval = int(tablelookup("mp/perkTable.csv", 1, loadoutdeathstreak, 6));
		if(getperkupgrade(loadoutperk1) == "specialty_rollover" || getperkupgrade(loadoutperk2) == "specialty_rollover" || getperkupgrade(loadoutperk3) == "specialty_rollover")
		{
			deathval = deathval - 1;
		}

		if(self.pers["cur_death_streak"] == deathval)
		{
			thread maps\mp\perks\_perks::giveperk(loadoutdeathstreak);
			thread maps\mp\gametypes\_hud_message::splashnotify(loadoutdeathstreak);
		}
		else if(self.pers["cur_death_streak"] > deathval)
		{
			thread maps\mp\perks\_perks::giveperk(loadoutdeathstreak);
		}
	}

	loadoutallperks(loadoutequipment, loadoutperk1, loadoutperk2, loadoutperk3);
	setkillstreaks(loadoutkillstreak1, loadoutkillstreak2, loadoutkillstreak3);
	if(self hasperk("specialty_extraammo", 1) && maps\mp\_utility::getweaponclass(secondaryname) != "weapon_projectile")
	{
		self givemaxammo(secondaryname);
	}

	primaryname = buildweaponname(loadoutprimary, loadoutprimaryattachment, loadoutprimaryattachment2);
	maps\mp\_utility::_giveweapon(primaryname, self.loadoutprimarycamo);
	if(primaryname == "riotshield_mp" && level.ingraceperiod)
	{
		self notify("weapon_change", "riotshield_mp");
	}

	if(self hasperk("specialty_extraammo", 1))
	{
		self givemaxammo(primaryname);
	}

	self setspawnweapon(primaryname);
	primarytokens = strtok(primaryname, "_");
	self.pers["primaryWeapon"] = primarytokens[0];
	offhandsecondaryweapon = loadoutoffhand + "_mp";
	if(loadoutoffhand == "flash_grenade")
	{
		self setoffhandsecondaryclass("flash");
	}
	else
	{
		self setoffhandsecondaryclass("smoke");
	}

	self giveweapon(offhandsecondaryweapon);
	if(loadoutoffhand == "smoke_grenade")
	{
		self setweaponammoclip(offhandsecondaryweapon, 1);
	}
	else if(loadoutoffhand == "flash_grenade")
	{
		self setweaponammoclip(offhandsecondaryweapon, 2);
	}
	else if(loadoutoffhand == "concussion_grenade")
	{
		self setweaponammoclip(offhandsecondaryweapon, 2);
	}
	else
	{
		self setweaponammoclip(offhandsecondaryweapon, 1);
	}

	primaryweapon = primaryname;
	self.primaryweapon = primaryweapon;
	self.secondaryweapon = secondaryname;
	maps\mp\gametypes\_teams::playermodelforweapon(self.pers["primaryWeapon"], maps\mp\_utility::getbaseweaponname(secondaryname));
	self.issniper = weaponclass(self.primaryweapon) == "sniper";
	maps\mp\gametypes\_weapons::updatemovespeedscale("primary");
	maps\mp\perks\_perks::cac_selector();
	self notify("changed_kit");
	self notify("giveLoadout");
}

_detachall()
{
	if(isdefined(self.hasriotshield) && self.hasriotshield)
	{
		if(self.hasriotshieldequipped)
		{
			self detachshieldmodel("weapon_riot_shield_mp", "tag_weapon_left");
			self.hasriotshieldequipped = 0;
		}
		else
		{
			self detachshieldmodel("weapon_riot_shield_mp", "tag_shield_back");
		}

		self.hasriotshield = 0;
	}

	self detachall();
}

isperkupgraded(perkname)
{
	perkupgrade = tablelookup("mp/perktable.csv", 1, perkname, 8);
	if(perkupgrade == "" || perkupgrade == "specialty_null")
	{
		return 0;
	}

	if(!self isitemunlocked(perkupgrade))
	{
		return 0;
	}

	return 1;
}

getperkupgrade(perkname)
{
	perkupgrade = tablelookup("mp/perktable.csv", 1, perkname, 8);
	if(perkupgrade == "" || perkupgrade == "specialty_null")
	{
		return "specialty_null";
	}

	if(!self isitemunlocked(perkupgrade))
	{
		return "specialty_null";
	}

	return perkupgrade;
}

loadoutallperks(loadoutequipment, loadoutperk1, loadoutperk2, loadoutperk3)
{
	loadoutequipment = maps\mp\perks\_perks::validateperk(1, loadoutequipment);
	loadoutperk1 = maps\mp\perks\_perks::validateperk(1, loadoutperk1);
	loadoutperk2 = maps\mp\perks\_perks::validateperk(2, loadoutperk2);
	loadoutperk3 = maps\mp\perks\_perks::validateperk(3, loadoutperk3);
	maps\mp\perks\_perks::giveperk(loadoutequipment);
	maps\mp\perks\_perks::giveperk(loadoutperk1);
	maps\mp\perks\_perks::giveperk(loadoutperk2);
	maps\mp\perks\_perks::giveperk(loadoutperk3);
	perkupgrd[0] = tablelookup("mp/perktable.csv", 1, loadoutperk1, 8);
	perkupgrd[1] = tablelookup("mp/perktable.csv", 1, loadoutperk2, 8);
	perkupgrd[2] = tablelookup("mp/perktable.csv", 1, loadoutperk3, 8);
	foreach(upgrade in perkupgrd)
	{
		if(upgrade == "" || upgrade == "specialty_null")
		{
			continue;
		}

		if(self isitemunlocked(upgrade))
		{
			maps\mp\perks\_perks::giveperk(upgrade);
		}
	}
}

trackriotshield()
{
	self endon("death");
	self endon("disconnect");
	self.hasriotshield = self hasweapon("riotshield_mp");
	self.hasriotshieldequipped = self.currentweaponatspawn == "riotshield_mp";
	if(self.hasriotshield)
	{
		if(self.hasriotshieldequipped)
		{
			self attachshieldmodel("weapon_riot_shield_mp", "tag_weapon_left");
		}
		else
		{
			self attachshieldmodel("weapon_riot_shield_mp", "tag_shield_back");
		}
	}

	for(;;)
	{
		self waittill("weapon_change", newweapon);
		if(newweapon == "riotshield_mp")
		{
			if(self.hasriotshieldequipped)
			{
				continue;
			}

			if(self.hasriotshield)
			{
				self moveshieldmodel("weapon_riot_shield_mp", "tag_shield_back", "tag_weapon_left");
			}
			else
			{
				self attachshieldmodel("weapon_riot_shield_mp", "tag_weapon_left");
			}

			self.hasriotshield = 1;
			self.hasriotshieldequipped = 1;
			continue;
		}

		if(self ismantling() && newweapon == "none")
		{
			continue;
		}

		if(self.hasriotshieldequipped)
		{
			self.hasriotshield = self hasweapon("riotshield_mp");
			if(self.hasriotshield)
			{
				self moveshieldmodel("weapon_riot_shield_mp", "tag_weapon_left", "tag_shield_back");
			}
			else
			{
				self detachshieldmodel("weapon_riot_shield_mp", "tag_weapon_left");
			}

			self.hasriotshieldequipped = 0;
			continue;
		}

		if(self.hasriotshield)
		{
			if(!self hasweapon("riotshield_mp"))
			{
				self detachshieldmodel("weapon_riot_shield_mp", "tag_shield_back");
				self.hasriotshield = 0;
			}
		}
	}
}

tryattach(placement)
{
	if(!isdefined(placement) || placement != "back")
	{
		tag = "tag_weapon_left";
	}
	else
	{
		tag = "tag_shield_back";
	}

	attachsize = self getattachsize();
	for(i = 0;i < attachsize;i++)
	{
		attachedtag = self getattachtagname(i);
		if(attachedtag == tag && self getattachmodelname(i) == "weapon_riot_shield_mp")
		{
			return;
		}
	}

	self attachshieldmodel("weapon_riot_shield_mp", tag);
}

trydetach(placement)
{
	if(!isdefined(placement) || placement != "back")
	{
		tag = "tag_weapon_left";
	}
	else
	{
		tag = "tag_shield_back";
	}

	attachsize = self getattachsize();
	for(i = 0;i < attachsize;i++)
	{
		attachedmodel = self getattachmodelname(i);
		if(attachedmodel == "weapon_riot_shield_mp")
		{
			self detachshieldmodel(attachedmodel, tag);
			return;
		}
	}
}

buildweaponname(basename, attachment1, attachment2)
{
	if(!isdefined(level.lettertonumber))
	{
		level.lettertonumber = makeletterstonumbers();
	}

	if(getdvarint("scr_game_perks") == 0)
	{
		attachment2 = "none";
		if(basename == "onemanarmy")
		{
			return "beretta_mp";
		}
	}

	weaponname = basename;
	attachments = [];
	if(attachment1 != "none" && attachment2 != "none")
	{
		if(level.lettertonumber[attachment1[0]] < level.lettertonumber[attachment2[0]])
		{
			attachments[0] = attachment1;
			attachments[1] = attachment2;
		}
		else if(level.lettertonumber[attachment1[0]] == level.lettertonumber[attachment2[0]])
		{
			if(level.lettertonumber[attachment1[1]] < level.lettertonumber[attachment2[1]])
			{
				attachments[0] = attachment1;
				attachments[1] = attachment2;
			}
			else
			{
				attachments[0] = attachment2;
				attachments[1] = attachment1;
			}
		}
		else
		{
			attachments[0] = attachment2;
			attachments[1] = attachment1;
		}
	}
	else if(attachment1 != "none")
	{
		attachments[0] = attachment1;
	}
	else if(attachment2 != "none")
	{
		attachments[0] = attachment2;
	}

	foreach(attachment in attachments)
	{
		weaponname = weaponname + "_" + attachment;
	}

	if(!isvalidweapon(weaponname + "_mp"))
	{
		return basename + "_mp";
	}

	return weaponname + "_mp";
}

makeletterstonumbers()
{
	array = [];
	array["a"] = 0;
	array["b"] = 1;
	array["c"] = 2;
	array["d"] = 3;
	array["e"] = 4;
	array["f"] = 5;
	array["g"] = 6;
	array["h"] = 7;
	array["i"] = 8;
	array["j"] = 9;
	array["k"] = 10;
	array["l"] = 11;
	array["m"] = 12;
	array["n"] = 13;
	array["o"] = 14;
	array["p"] = 15;
	array["q"] = 16;
	array["r"] = 17;
	array["s"] = 18;
	array["t"] = 19;
	array["u"] = 20;
	array["v"] = 21;
	array["w"] = 22;
	array["x"] = 23;
	array["y"] = 24;
	array["z"] = 25;
	return array;
}

setkillstreaks(streak1, streak2, streak3)
{
	self.killstreaks = [];
	if(maps\mp\_utility::_hasperk("specialty_hardline"))
	{
		modifier = -1;
	}
	else
	{
		modifier = 0;
	}

	killstreaks = [];
	if(streak1 != "none")
	{
		streakval = int(tablelookup("mp/killstreakTable.csv", 1, streak1, 4));
		killstreaks[streakval + modifier] = streak1;
	}

	if(streak2 != "none")
	{
		streakval = int(tablelookup("mp/killstreakTable.csv", 1, streak2, 4));
		killstreaks[streakval + modifier] = streak2;
	}

	if(streak3 != "none")
	{
		streakval = int(tablelookup("mp/killstreakTable.csv", 1, streak3, 4));
		killstreaks[streakval + modifier] = streak3;
	}

	maxval = 0;
	foreach(streakval, streakname in killstreaks)
	{
		if(streakval > maxval)
		{
			maxval = streakval;
		}
	}

	for(streakindex = 0;streakindex <= maxval;streakindex++)
	{
		if(!isdefined(killstreaks[streakindex]))
		{
			continue;
		}

		streakname = killstreaks[streakindex];
		self.killstreaks[streakindex] = killstreaks[streakindex];
	}

	maxrollovers = 10;
	newkillstreaks = self.killstreaks;
	for(rollover = 1;rollover <= maxrollovers;rollover++)
	{
		foreach(streakval, streakname in self.killstreaks)
		{
			newkillstreaks[streakval + maxval * rollover] = streakname + "-rollover" + rollover;
		}
	}

	self.killstreaks = newkillstreaks;
}

replenishloadout()
{
	team = self.pers["team"];
	class = self.pers["class"];
	weaponslist = self getweaponslistall();
	for(idx = 0;idx < weaponslist.size;idx++)
	{
		weapon = weaponslist[idx];
		self givemaxammo(weapon);
		self setweaponammoclip(weapon, 9999);
		if(weapon == "claymore_mp" || weapon == "claymore_detonator_mp")
		{
			self setweaponammostock(weapon, 2);
		}
	}

	if(self getammocount(level.classgrenades[class]["primary"]["type"]) < level.classgrenades[class]["primary"]["count"])
	{
		self setweaponammoclip(level.classgrenades[class]["primary"]["type"], level.classgrenades[class]["primary"]["count"]);
	}

	if(self getammocount(level.classgrenades[class]["secondary"]["type"]) < level.classgrenades[class]["secondary"]["count"])
	{
		self setweaponammoclip(level.classgrenades[class]["secondary"]["type"], level.classgrenades[class]["secondary"]["count"]);
		return;
	}
}

onplayerconnecting()
{
	for(;;)
	{
		level waittill("connected", player);
		if(!isdefined(player.pers["class"]))
		{
			player.pers["class"] = "";
		}

		player.class = player.pers["class"];
		player.lastclass = "";
		player.detectexplosives = 0;
		player.bombsquadicons = [];
		player.bombsquadids = [];
	}
}

fadeaway(waitdelay, fadedelay)
{
	wait waitdelay;
	self fadeovertime(fadedelay);
	self.alpha = 0;
}

setclass(newclass)
{
	self.curclass = newclass;
}

getperkforclass(perkslot, classname)
{
	class_num = getclassindex(classname);
	if(issubstr(classname, "custom"))
	{
		return cac_getperk(class_num, perkslot);
	}

	return table_getperk(level.classtablename, class_num, perkslot);
}

classhasperk(classname, perkname)
{
	return getperkforclass(0, classname) == perkname || getperkforclass(1, classname) == perkname || getperkforclass(2, classname) == perkname;
}

isvalidprimary(refstring)
{
	switch(refstring)
	{
		case "aug":
		case "m240":
		case "mg4":
		case "sa80":
		case "rpd":
		case "cheytac":
		case "m21":
		case "wa2000":
		case "barrett":
		case "ump45":
		case "kriss":
		case "p90":
		case "uzi":
		case "mp5k":
		case "tavor":
		case "scar":
		case "fal":
		case "famas":
		case "masada":
		case "fn2000":
		case "m4":
		case "m16":
		case "ak47":
		case "riotshield":
			return 1;

		default:
			return 0;
	}
}

isvalidsecondary(refstring)
{
	switch(refstring)
	{
		case "spas12":
		case "m1014":
		case "aa12":
		case "striker":
		case "model1887":
		case "ranger":
		case "javelin":
		case "stinger":
		case "at4":
		case "rpg":
		case "m79":
		case "tmp":
		case "pp2000":
		case "beretta393":
		case "coltanaconda":
		case "deserteagle":
		case "glock":
		case "usp":
		case "beretta":
		case "onemanarmy":
			return 1;

		default:
			return 0;
	}
}

isvalidattachment(refstring)
{
	switch(refstring)
	{
		case "tactical":
		case "eotech":
		case "xmags":
		case "rof":
		case "heartbeat":
		case "fmj":
		case "shotgun":
		case "gl":
		case "grip":
		case "silencer":
		case "reflex":
		case "acog":
		case "akimbo":
		case "thermal":
		case "none":
			return 1;

		default:
			return 0;
	}
}

isvalidcamo(refstring)
{
	switch(refstring)
	{
		case "orange_fall":
		case "blue_tiger":
		case "red_tiger":
		case "red_urban":
		case "digital":
		case "arctic":
		case "woodland":
		case "desert":
		case "none":
			return 1;

		default:
			return 0;
	}
}

isvalidequipment(refstring)
{
	switch(refstring)
	{
		case "c4_mp":
		case "specialty_blastshield":
		case "specialty_tacticalinsertion":
		case "throwingknife_mp":
		case "semtex_mp":
		case "claymore_mp":
		case "frag_grenade_mp":
			return 1;

		default:
			return 0;
	}
}

isvalidoffhand(refstring)
{
	switch(refstring)
	{
		case "concussion_grenade":
		case "smoke_grenade":
		case "flash_grenade":
			return 1;

		default:
			return 0;
	}
}

isvalidperk1(refstring)
{
	switch(refstring)
	{
		case "specialty_scavenger":
		case "specialty_fastreload":
		case "specialty_marathon":
		case "specialty_onemanarmy":
		case "specialty_bling":
			return 1;

		default:
			return 0;
	}
}

isvalidperk2(refstring)
{
	switch(refstring)
	{
		case "specialty_explosivedamage":
		case "specialty_coldblooded":
		case "specialty_lightweight":
		case "specialty_bulletdamage":
		case "specialty_hardline":
			return 1;

		default:
			return 0;
	}
}

isvalidperk3(refstring)
{
	switch(refstring)
	{
		case "specialty_detectexplosive":
		case "specialty_heartbreaker":
		case "specialty_localjammer":
		case "specialty_bulletaccuracy":
		case "specialty_extendedmelee":
		case "specialty_pistoldeath":
			return 1;

		default:
			return 0;
	}
}

isvaliddeathstreak(refstring)
{
	switch(refstring)
	{
		case "specialty_grenadepulldeath":
		case "specialty_combathigh":
		case "specialty_copycat":
		case "specialty_finalstand":
			return 1;

		default:
			return 0;
	}
}

isvalidweapon(refstring)
{
	if(!isdefined(level.weaponrefs))
	{
		level.weaponrefs = [];
		foreach(weaponref in level.weaponlist)
		{
			level.weaponrefs[weaponref] = 1;
		}
	}

	if(isdefined(level.weaponrefs[refstring]))
	{
		return 1;
	}

	return 0;
}