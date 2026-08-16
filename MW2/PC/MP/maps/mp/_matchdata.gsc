/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_matchdata.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	if(!isdefined(game["gamestarted"]))
	{
		print3d("mp/matchdata.def");
		print3d("map", level.script);
		print3d("gametype", level.gametype);
		print3d("buildVersion", getbuildversion());
		print3d("buildNumber", getbuildnumber());
		print3d("dateTime", getsystemtime());
	}

	level.maxlives = 250;
	level.maxnamelength = 21;
	level.maxevents = 150;
	level.maxkillstreaks = 125;
	level.maxlogclients = 128;
	level thread gameendlistener();
}

logkillstreakevent(event, position)
{
	if(!maps\mp\_utility::matchmakinggame() || !canlogclient(self) || !canlogkillstreak())
	{
		return;
	}

	eventid = getmatchdata("killstreakCount");
	print3d("killstreakCount", eventid + 1);
	print3d("killstreaks", eventid, "eventType", event);
	print3d("killstreaks", eventid, "player", self.clientid);
	print3d("killstreaks", eventid, "eventTime", gettime());
	print3d("killstreaks", eventid, "eventPos", 0, int(position[0]));
	print3d("killstreaks", eventid, "eventPos", 1, int(position[1]));
	print3d("killstreaks", eventid, "eventPos", 2, int(position[2]));
}

loggameevent(event, position)
{
	if(!maps\mp\_utility::matchmakinggame() || !canlogclient(self) || !canlogevent())
	{
		return;
	}

	eventid = getmatchdata("eventCount");
	print3d("eventCount", eventid + 1);
	print3d("events", eventid, "eventType", event);
	print3d("events", eventid, "player", self.clientid);
	print3d("events", eventid, "eventTime", gettime());
	print3d("events", eventid, "eventPos", 0, int(position[0]));
	print3d("events", eventid, "eventPos", 1, int(position[1]));
	print3d("events", eventid, "eventPos", 2, int(position[2]));
}

logkillevent(lifeid, eventref)
{
	if(!maps\mp\_utility::matchmakinggame() || !canloglife(lifeid))
	{
		return;
	}

	print3d("lives", lifeid, "modifiers", eventref, 1);
}

logmultikill(lifeid, multikillcount)
{
	if(!maps\mp\_utility::matchmakinggame() || !canloglife(lifeid))
	{
		return;
	}

	print3d("lives", lifeid, "multikill", multikillcount);
}

logplayerlife(lifeid)
{
	if(!maps\mp\_utility::matchmakinggame() || !canlogclient(self) || !canloglife(lifeid))
	{
		return;
	}

	print3d("lives", lifeid, "player", self.clientid);
	print3d("lives", lifeid, "spawnPos", 0, int(self.spawnpos[0]));
	print3d("lives", lifeid, "spawnPos", 1, int(self.spawnpos[1]));
	print3d("lives", lifeid, "spawnPos", 2, int(self.spawnpos[2]));
	print3d("lives", lifeid, "wasTacticalInsertion", self.wasti);
	print3d("lives", lifeid, "team", self.team);
	print3d("lives", lifeid, "spawnTime", self.spawntime);
	print3d("lives", lifeid, "duration", gettime() - self.spawntime);
	logloadout(lifeid);
}

logloadout(lifeid)
{
	if(!maps\mp\_utility::matchmakinggame() || !canlogclient(self) || !canloglife(lifeid))
	{
		return;
	}

	class = self.curclass;
	if(class == "copycat")
	{
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
		class_num = maps\mp\gametypes\_class::getclassindex(class);
		loadoutprimary = maps\mp\gametypes\_class::cac_getweapon(class_num, 0);
		loadoutprimaryattachment = maps\mp\gametypes\_class::cac_getweaponattachment(class_num, 0);
		loadoutprimaryattachment2 = maps\mp\gametypes\_class::cac_getweaponattachmenttwo(class_num, 0);
		loadoutsecondary = maps\mp\gametypes\_class::cac_getweapon(class_num, 1);
		loadoutsecondaryattachment = maps\mp\gametypes\_class::cac_getweaponattachment(class_num, 1);
		loadoutsecondaryattachment2 = maps\mp\gametypes\_class::cac_getweaponattachmenttwo(class_num, 1);
		loadoutoffhand = maps\mp\gametypes\_class::cac_getoffhand(class_num);
		loadoutequipment = maps\mp\gametypes\_class::cac_getperk(class_num, 0);
		loadoutperk1 = maps\mp\gametypes\_class::cac_getperk(class_num, 1);
		loadoutperk2 = maps\mp\gametypes\_class::cac_getperk(class_num, 2);
		loadoutperk3 = maps\mp\gametypes\_class::cac_getperk(class_num, 3);
	}
	else
	{
		class_num = maps\mp\gametypes\_class::getclassindex(class);
		loadoutprimary = maps\mp\gametypes\_class::table_getweapon(level.classtablename, class_num, 0);
		loadoutprimaryattachment = maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, class_num, 0, 0);
		loadoutprimaryattachment2 = maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, class_num, 0, 1);
		loadoutsecondary = maps\mp\gametypes\_class::table_getweapon(level.classtablename, class_num, 1);
		loadoutsecondaryattachment = maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, class_num, 1, 0);
		loadoutsecondaryattachment2 = maps\mp\gametypes\_class::table_getweaponattachment(level.classtablename, class_num, 1, 1);
		loadoutoffhand = maps\mp\gametypes\_class::table_getoffhand(level.classtablename, class_num);
		loadoutequipment = maps\mp\gametypes\_class::table_getequipment(level.classtablename, class_num, 0);
		loadoutperk1 = maps\mp\gametypes\_class::table_getperk(level.classtablename, class_num, 1);
		loadoutperk2 = maps\mp\gametypes\_class::table_getperk(level.classtablename, class_num, 2);
		loadoutperk3 = maps\mp\gametypes\_class::table_getperk(level.classtablename, class_num, 3);
	}

	print3d("lives", lifeid, "primaryWeapon", loadoutprimary);
	print3d("lives", lifeid, "primaryAttachments", 0, loadoutprimaryattachment);
	print3d("lives", lifeid, "primaryAttachments", 1, loadoutprimaryattachment2);
	print3d("lives", lifeid, "secondaryWeapon", loadoutsecondary);
	print3d("lives", lifeid, "secondaryAttachments", 0, loadoutsecondaryattachment);
	print3d("lives", lifeid, "secondaryAttachments", 1, loadoutsecondaryattachment);
	print3d("lives", lifeid, "offhandWeapon", loadoutoffhand);
	print3d("lives", lifeid, "equipment", loadoutequipment);
	print3d("lives", lifeid, "perks", 0, loadoutperk1);
	print3d("lives", lifeid, "perks", 1, loadoutperk2);
	print3d("lives", lifeid, "perks", 2, loadoutperk3);
}

logplayerdeath(lifeid, attacker, idamage, smeansofdeath, sweapon, sprimaryweapon, shitloc)
{
	if(!maps\mp\_utility::matchmakinggame() || !canlogclient(self) || isplayer(attacker) && !canlogclient(attacker) || !canloglife(lifeid))
	{
		return;
	}

	if(lifeid >= level.maxlives)
	{
		return;
	}

	if(sweapon == "none")
	{
		sweapontype = "none";
		sweaponclass = "none";
	}
	else
	{
		sweapontype = weaponinventorytype(sweapon);
		sweaponclass = weaponclass(sweapon);
	}

	if(isdefined(sweapontype) && sweapontype == "primary" || sweapontype == "altmode" && sweaponclass == "pistol" || sweaponclass == "smg" || sweaponclass == "rifle" || sweaponclass == "spread" || sweaponclass == "mg" || sweaponclass == "grenade" || sweaponclass == "rocketlauncher" || sweaponclass == "sniper")
	{
		sweaponoriginal = undefined;
		if(sweapontype == "altmode")
		{
			sweaponoriginal = sweapon;
			sweapon = sprimaryweapon;
			print3d("lives", lifeid, "altMode", 1);
		}

		weapontokens = strtok(sweapon, "_");
		weapontokens[weapontokens.size - 1] = undefined;
		print3d("lives", lifeid, "weapon", weapontokens[0]);
		if(isdefined(weapontokens[1]))
		{
			print3d("lives", lifeid, "attachments", 0, weapontokens[1]);
		}

		if(isdefined(weapontokens[2]))
		{
			print3d("lives", lifeid, "attachments", 1, weapontokens[2]);
		}
	}
	else if(sweapontype == "item" || sweapontype == "offhand")
	{
		weaponname = maps\mp\_utility::strip_suffix(sweapon, "_mp");
		print3d("lives", lifeid, "weapon", weaponname);
	}
	else
	{
		print3d("lives", lifeid, "weapon", sweapon);
	}

	if(maps\mp\_utility::iskillstreakweapon(sweapon))
	{
		print3d("lives", lifeid, "modifiers", "killstreak", 1);
	}

	print3d("lives", lifeid, "mod", smeansofdeath);
	if(isplayer(attacker))
	{
		print3d("lives", lifeid, "attacker", attacker.clientid);
		print3d("lives", lifeid, "attackerPos", 0, int(attacker.origin[0]));
		print3d("lives", lifeid, "attackerPos", 1, int(attacker.origin[1]));
		print3d("lives", lifeid, "attackerPos", 2, int(attacker.origin[2]));
		victimforward = anglestoforward((0,self.angles[1],0));
		attackdirection = self.origin - attacker.origin;
		attackdirection = vectornormalize((attackdirection[0],attackdirection[1],0));
		print3d("lives", lifeid, "dotOfDeath", vectordot(victimforward, attackdirection));
	}
	else
	{
		print3d("lives", lifeid, "attacker", 255);
		print3d("lives", lifeid, "attackerPos", 0, int(self.origin[0]));
		print3d("lives", lifeid, "attackerPos", 1, int(self.origin[1]));
		print3d("lives", lifeid, "attackerPos", 2, int(self.origin[2]));
	}

	print3d("lives", lifeid, "player", self.clientid);
	print3d("lives", lifeid, "deathPos", 0, int(self.origin[0]));
	print3d("lives", lifeid, "deathPos", 1, int(self.origin[1]));
	print3d("lives", lifeid, "deathPos", 2, int(self.origin[2]));
	print3d("lives", lifeid, "deathAngles", 0, int(self.angles[0]));
	print3d("lives", lifeid, "deathAngles", 1, int(self.angles[1]));
	print3d("lives", lifeid, "deathAngles", 2, int(self.angles[2]));
}

logplayerdata()
{
	if(!maps\mp\_utility::matchmakinggame() || !canlogclient(self))
	{
		return;
	}

	print3d("players", self.clientid, "score", maps\mp\_utility::getpersstat("score"));
	print3d("players", self.clientid, "assists", maps\mp\_utility::getpersstat("assists"));
	print3d("players", self.clientid, "longestStreak", maps\mp\_utility::getpersstat("longestStreak"));
}

gameendlistener()
{
	if(!maps\mp\_utility::matchmakinggame())
	{
		return;
	}

	level waittill("game_ended");
	print3d("gameLength", int(maps\mp\_utility::gettimepassed()));
	foreach(player in level.players)
	{
		if(player.team != "allies" && player.team != "axis")
		{
			continue;
		}

		player logplayerdata();
		if(!isalive(player))
		{
			continue;
		}

		lifeid = maps\mp\_utility::getnextlifeid();
		player logplayerlife(lifeid);
	}
}

canlogclient(client)
{
	return client.clientid < level.maxlogclients;
}

canlogevent()
{
	return getmatchdata("eventCount") < level.maxevents;
}

canlogkillstreak()
{
	return getmatchdata("killstreakCount") < level.maxkillstreaks;
}

canloglife(lifeid)
{
	return getmatchdata("lifeCount") < level.maxlives;
}