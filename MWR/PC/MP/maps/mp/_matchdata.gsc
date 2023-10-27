/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_matchdata.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 606 ms
 * Timestamp: 10/27/2023 2:40:26 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(game["gamestarted"]))
	{
		setmatchdatadef("mp/matchdata.ddl");
		setmatchdata("map",level.script);
		if(level.hardcoremode)
		{
			var_00 = level.gametype + " hc";
			setmatchdata("gametype",var_00);
		}
		else if(level.oldschool)
		{
			var_00 = level.gametype + " os";
			setmatchdata("gametype",var_00);
		}
		else
		{
			setmatchdata("gametype",level.gametype);
		}

		setmatchdata("buildVersion",getbuildversion());
		setmatchdata("buildNumber",getbuildnumber());
		setmatchdataid();
	}

	level.maxlives = 285;
	level.maxevents = 150;
	level.maxkillstreaks = 64;
	level.maxlogclients = 30;
	level.maxnumchallengesperplayer = 5;
	level.maxnumawardsperplayer = 10;
	level.maxloadouts = 10;
	level thread gameendlistener();
	if(getdvar("virtualLobbyActive") != "1")
	{
		level thread reconlogplayerinfo();
	}
}

//Function Number: 2
matchstarted()
{
	if(getdvar("virtualLobbyActive") == "1")
	{
		return;
	}

	if(getdvar("mapname") == getdvar("virtualLobbyMap"))
	{
		return;
	}

	sysprint("MatchStarted: Completed");
	var_00 = getplaylistname();
	setmatchdata("playlistName",var_00);
	var_01 = getlocaltimestring();
	setmatchdata("localTimeStringAtMatchStart",var_01);
	if(getmatchstarttimeutc() == 0)
	{
		setmatchdata("startTimeUTC",getsystemtime());
	}

	setmatchdata("iseSports",maps\mp\_utility::ismlgmatch());
	if(maps\mp\_utility::privatematch())
	{
		setmatchdata("privateMatch",1);
	}

	if(maps\mp\_utility::isdivisionmode())
	{
		setmatchdata("divisionMode",1);
	}

	thread logbreadcrumbdata();
	thread accumulateplayerpingdata();
}

//Function Number: 3
logbreadcrumbdata()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = maps\mp\_utility::getgametimepassedseconds();
		foreach(var_02 in level.players)
		{
			if(isbot(var_02) || istestclient(var_02))
			{
				continue;
			}

			if(maps\mp\_utility::isreallyalive(var_02) && isdefined(var_02.lifeid) && canloglife(var_02.lifeid))
			{
				var_03 = 31;
				if(isdefined(var_02.lastshotby))
				{
					var_03 = var_02.lastshotby;
				}

				recordbreadcrumbdataforplayer(var_02,var_02.lifeid,var_00,var_03);
				var_02.lastshotby = undefined;
			}
		}

		if(isdefined(level.iszombiegame) && level.iszombiegame)
		{
			wait(5);
			continue;
		}

		wait(2);
	}
}

//Function Number: 4
accumulateplayerpingdata()
{
	level endon("game_ended");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(isbot(var_01) || istestclient(var_01))
			{
				continue;
			}

			if(!isdefined(var_01.pers["pingAccumulation"]) || !isdefined(var_01.pers["minPing"]) || !isdefined(var_01.pers["maxPing"]) || !isdefined(var_01.pers["pingSampleCount"]))
			{
				continue;
			}

			var_02 = var_01 method_8517();
			var_01.pers["pingAccumulation"] = var_01.pers["pingAccumulation"] + var_02;
			var_01.pers["pingSampleCount"]++;
			if(var_01.pers["pingSampleCount"] > 5 && var_02 > 0)
			{
				if(var_02 > var_01.pers["maxPing"])
				{
					var_01.pers["maxPing"] = var_02;
				}

				if(var_02 < var_01.pers["minPing"])
				{
					var_01.pers["minPing"] = var_02;
				}
			}
		}

		wait(2);
	}
}

//Function Number: 5
getmatchstarttimeutc()
{
	return getmatchdata("startTimeUTC");
}

//Function Number: 6
logkillstreakevent(param_00,param_01)
{
	if(!canlogclient(self) || !canlogkillstreak())
	{
		return;
	}

	var_02 = getmatchdata("killstreakCount");
	setmatchdata("killstreakCount",var_02 + 1);
	setmatchdata("killstreaks",var_02,"eventType",param_00);
	setmatchdata("killstreaks",var_02,"player",self.clientid);
	setmatchdata("killstreaks",var_02,"eventStartTimeDeciSecondsFromMatchStart",maps\mp\_utility::gettimepasseddeciseconds());
	setmatchdata("killstreaks",var_02,"eventPos",0,int(param_01[0]));
	setmatchdata("killstreaks",var_02,"eventPos",1,int(param_01[1]));
	setmatchdata("killstreaks",var_02,"eventPos",2,int(param_01[2]));
	setmatchdata("killstreaks",var_02,"index",var_02);
	self.currentkillstreakindex = var_02;
	reconspatialevent(param_01,"script_mp_killstreak: eventType %s, player_name %s, player %d, gameTime %d",param_00,self.name,self.clientid,gettime());
}

//Function Number: 7
loggameevent(param_00,param_01)
{
	if(!canlogclient(self) || !canlogevent())
	{
		return;
	}

	var_02 = getmatchdata("eventCount");
	setmatchdata("eventCount",var_02 + 1);
	setmatchdata("events",var_02,"eventType",param_00);
	setmatchdata("events",var_02,"player",self.clientid);
	setmatchdata("events",var_02,"eventTimeDeciSecondsFromMatchStart",maps\mp\_utility::gettimepasseddeciseconds());
	setmatchdata("events",var_02,"eventPos",0,int(param_01[0]));
	setmatchdata("events",var_02,"eventPos",1,int(param_01[1]));
	setmatchdata("events",var_02,"eventPos",2,int(param_01[2]));
	reconspatialevent(param_01,"script_mp_event: event_type %s, player_name %s, player %d, gameTime %d",param_00,self.name,self.clientid,gettime());
}

//Function Number: 8
logkillevent(param_00,param_01)
{
	if(!canloglife(param_00))
	{
		return;
	}

	setmatchdata("lives",param_00,"modifiers",param_01,1);
}

//Function Number: 9
logmultikill(param_00,param_01)
{
	if(!canloglife(param_00))
	{
		return;
	}

	setmatchdata("lives",param_00,"multikill",param_01);
}

//Function Number: 10
logplayerlife(param_00)
{
	if(!canlogclient(self) || !canloglife(self.lifeid))
	{
		return;
	}

	var_01 = gettime() - self.spawntime;
	self.totallifetime = self.totallifetime + var_01;
	var_02 = maps\mp\_utility::convertmillisecondstodecisecondsandclamptoshort(var_01);
	setmatchdata("lives",self.lifeid,"player",self.clientid);
	setmatchdata("lives",self.lifeid,"spawnPos",0,int(self.spawnpos[0]));
	setmatchdata("lives",self.lifeid,"spawnPos",1,int(self.spawnpos[1]));
	setmatchdata("lives",self.lifeid,"spawnPos",2,int(self.spawnpos[2]));
	setmatchdata("lives",self.lifeid,"team",self.team);
	if(isdefined(self.spawntimedecisecondsfrommatchstart))
	{
		setmatchdata("lives",self.lifeid,"spawnTimeDeciSecondsFromMatchStart",self.spawntimedecisecondsfrommatchstart);
	}
	else
	{
		setmatchdata("lives",self.lifeid,"spawnTimeDeciSecondsFromMatchStart",-1);
	}

	setmatchdata("lives",self.lifeid,"durationDeciSeconds",var_02);
	var_03 = logloadout();
	setmatchdata("lives",self.lifeid,"loadoutIndex",var_03);
	var_04 = maps\mp\_utility::clamptoshort(self.pers["score"] - self.scoreatlifestart);
	setmatchdata("lives",self.lifeid,"scoreEarnedDuringThisLife",var_04);
	if(isdefined(self.pers["summary"]) && isdefined(self.pers["summary"]["xp"]))
	{
		if(isdefined(self.xpatlifestart))
		{
			var_05 = maps\mp\_utility::clamptoshort(self.pers["summary"]["xp"] - self.xpatlifestart);
			setmatchdata("lives",self.lifeid,"xpEarnedDuringThisLife",var_05);
		}
	}
}

//Function Number: 11
logplayerxp(param_00,param_01)
{
	if(!canlogclient(self))
	{
		return;
	}

	setmatchdata("players",self.clientid,param_01,param_00);
}

//Function Number: 12
logcompletedchallenge(param_00)
{
	if(!isplayer(self) || !canlogclient(self) || isbot(self))
	{
		return;
	}

	var_01 = getmatchdata("players",self.clientid,"challengeCount");
	if(var_01 < level.maxnumchallengesperplayer)
	{
		setmatchdata("players",self.clientid,"challenges",var_01,param_00);
		setmatchdata("players",self.clientid,"challengeCount",var_01 + 1);
	}
}

//Function Number: 13
logloadout()
{
	var_00 = 255;
	if(!canlogclient(self) || !canloglife(self.lifeid) || self.curclass == "gamemode")
	{
		return var_00;
	}

	var_01 = self.curclass;
	var_02 = 0;
	for(var_02 = 0;var_02 < level.maxloadouts;var_02++)
	{
		var_03 = getmatchdata("players",self.clientid,"loadouts",var_02,"slotUsed");
		if(!var_03)
		{
			break;
		}
		else
		{
			var_04 = getmatchdata("players",self.clientid,"loadouts",var_02,"className");
			if(var_01 == var_04)
			{
				return var_02;
			}
		}
	}

	if(var_02 == level.maxloadouts)
	{
		return var_00;
	}

	setmatchdata("players",self.clientid,"loadouts",var_02,"slotUsed",1);
	setmatchdata("players",self.clientid,"loadouts",var_02,"className",var_01);
	var_05 = [];
	var_06 = "";
	var_07 = "";
	if(var_01 == "copycat")
	{
		var_08 = self.pers["copyCatLoadout"];
		var_09 = var_08["loadoutPrimary"];
		var_0A = var_08["loadoutPrimaryAttachKit"];
		var_0B = var_08["loadoutPrimaryFurnitureKit"];
		var_0C = var_08["loadoutPrimaryCamo"];
		var_0D = var_08["loadoutPrimaryReticle"];
		var_0E = var_08["loadoutSecondary"];
		var_0F = var_08["loadoutSecondaryAttachKit"];
		var_10 = var_08["loadoutSecondaryFurnitureKit"];
		var_11 = var_08["loadoutSecondaryCamo"];
		var_12 = var_08["loadoutSecondaryReticle"];
		var_06 = var_08["loadoutEquipment"];
		var_07 = var_08["loadoutOffhand"];
		for(var_13 = 0;var_13 < 3;var_13++)
		{
			var_05[var_13] = var_08["loadoutPerks"][var_13];
		}

		var_14 = var_08["loadoutMelee"];
	}
	else if(issubstr(var_0C,"custom"))
	{
		var_15 = maps\mp\_utility::getclassindex(var_0C);
		var_09 = maps\mp\gametypes\_class::cac_getweapon(var_15,0);
		var_0A = maps\mp\gametypes\_class::cac_getweaponattachkit(var_15,0);
		var_0B = maps\mp\gametypes\_class::cac_getweaponfurniturekit(var_15,0);
		var_0C = maps\mp\gametypes\_class::cac_getweaponcamo(var_15,0);
		for(var_13 = 0;var_13 < 3;var_13++)
		{
			var_05[var_13] = maps\mp\gametypes\_class::cac_getperk(var_15,var_13);
		}

		var_0E = maps\mp\gametypes\_class::cac_getweapon(var_15,1);
		var_0F = maps\mp\gametypes\_class::cac_getweaponattachkit(var_15,1);
		var_10 = maps\mp\gametypes\_class::cac_getweaponfurniturekit(var_15,1);
		var_11 = maps\mp\gametypes\_class::cac_getweaponcamo(var_15,1);
		var_06 = maps\mp\gametypes\_class::cac_getequipment(var_15,0);
		var_07 = maps\mp\gametypes\_class::cac_getoffhand(var_15);
		var_14 = maps\mp\gametypes\_class::cac_getmeleeweapon(var_15);
	}
	else
	{
		var_15 = maps\mp\_utility::getclassindex(var_0E);
		var_09 = maps\mp\gametypes\_class::table_getweapon(level.classtablename,var_15,0);
		var_0A = maps\mp\gametypes\_class::table_getweaponattachkit(level.classtablename,var_15,0);
		var_0B = maps\mp\gametypes\_class::table_getweaponfurniturekit(level.classtablename,var_15,0);
		var_0C = maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename,var_15,0);
		for(var_13 = 0;var_13 < 3;var_13++)
		{
			var_05[var_13] = maps\mp\gametypes\_class::table_getperk(level.classtablename,var_15,var_13);
		}

		var_0E = maps\mp\gametypes\_class::table_getweapon(level.classtablename,var_15,1);
		var_0F = maps\mp\gametypes\_class::table_getweaponattachkit(level.classtablename,var_15,1);
		var_10 = maps\mp\gametypes\_class::table_getweaponfurniturekit(level.classtablename,var_15,1);
		var_11 = maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename,var_15,1);
		var_06 = maps\mp\gametypes\_class::table_getequipment(level.classtablename,var_15);
		var_07 = maps\mp\gametypes\_class::table_getoffhand(level.classtablename,var_15);
		var_14 = "none";
	}

	setmatchdata("players",self.clientid,"loadouts",var_02,"primaryWeapon",var_09);
	for(var_13 = 0;var_13 < 3;var_13++)
	{
		setmatchdata("players",self.clientid,"loadouts",var_02,"perkSlots",var_13,var_05[var_13]);
	}

	setmatchdata("players",self.clientid,"loadouts",var_02,"secondaryWeapon",var_0E);
	var_16 = maps\mp\gametypes\_class::attachkitnametoid(var_0A);
	var_17 = maps\mp\gametypes\_class::attachkitnametoid(var_0F);
	setmatchdata("players",self.clientid,"loadouts",var_02,"primaryAttachKit",var_16);
	setmatchdata("players",self.clientid,"loadouts",var_02,"secondaryAttachKit",var_17);
	var_18 = maps\mp\gametypes\_class::furniturekitnametoid(var_0B);
	var_19 = maps\mp\gametypes\_class::furniturekitnametoid(var_10);
	setmatchdata("players",self.clientid,"loadouts",var_02,"primaryFurnitureKit",var_18);
	setmatchdata("players",self.clientid,"loadouts",var_02,"secondaryFurnitureKit",var_19);
	setmatchdata("players",self.clientid,"loadouts",var_02,"offhandWeapon",var_07);
	setmatchdata("players",self.clientid,"loadouts",var_02,"equipment",var_06);
	thread recon_log_loadout(self,var_09,var_0A,var_0B,var_0C,var_0E,var_0F,var_10,var_11,var_06,var_07,var_05[0],var_05[1],var_05[2]);
	return var_02;
}

//Function Number: 14
recon_log_loadout(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	var_0E = isbot(param_00) || istestclient(param_00);
	var_0F = "_matchdata.gsc";
	var_10 = param_00.spawntime;
	var_11 = param_00.curclass;
	var_12 = param_00.name;
	reconevent("@"script_mp_loadout_gear: script_file %s, gameTime %d, player_name %s, is_bot %b, class %s, primary_weapon %s, primary_attach_kit %s, primary_furniture_kit %s, primary_camo %s, secondary_weapon %s, secondary_attach_kit %s,  secondary_furniture_kit %s, secondary_camo %s, equipment %s, offhand %s",var_0F,var_10,var_12,var_0E,var_11,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	reconevent("script_mp_loadout_perks: script_file %s, gameTime %d, player_name %s, perk_1 %s, perk_2 %s, perk_3 %s",var_0F,var_10,var_12,param_0B,param_0C,param_0D);
}

//Function Number: 15
logplayerandkilleradsandfov(param_00,param_01)
{
	if(!canlogclient(self) || isplayer(param_01) && !canlogclient(param_01) || !canloglife(param_00))
	{
		return;
	}

	if(param_00 >= level.maxlives)
	{
		return;
	}

	if(isplayer(param_01))
	{
		if(param_01 playerads() > 0.5)
		{
			setmatchdata("lives",param_00,"killerWasADS",1);
		}

		var_02 = param_01 geteye();
		if(common_scripts\utility::within_fov(var_02,param_01.angles,self.origin,cos(getdvarfloat("cg_fov"))))
		{
			setmatchdata("lives",param_00,"victimWasInKillersFOV",1);
		}

		var_03 = self geteye();
		if(common_scripts\utility::within_fov(var_03,self.angles,param_01.origin,cos(getdvarfloat("cg_fov"))))
		{
			setmatchdata("lives",param_00,"killerWasInVictimsFOV",1);
		}
	}

	if(self playerads() > 0.5)
	{
		setmatchdata("lives",param_00,"victimWasADS",1);
	}
}

//Function Number: 16
determineweaponnameandattachments(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	if(param_00 == "none")
	{
		var_02 = "none";
		var_03 = "none";
	}
	else
	{
		var_02 = weaponinventorytype(param_00);
		var_03 = weaponclass(param_00);
	}

	if(issubstr(param_00,"destructible"))
	{
		param_00 = "destructible";
	}

	var_04 = [];
	var_04[0] = "None";
	var_04[1] = "None";
	var_04[2] = "None";
	var_05 = "none";
	var_06 = "none";
	var_07 = "";
	if(maps\mp\_utility::iskillstreakweapon(param_00))
	{
		var_07 = maps\mp\_utility::strip_suffix(param_00,"_mp");
	}
	else if(param_00 == "destructible")
	{
		var_07 = param_00;
	}
	else if(isdefined(var_02) && var_02 == "primary" || var_02 == "altmode" || var_02 == "melee" && var_03 == "pistol" || var_03 == "smg" || var_03 == "rifle" || var_03 == "spread" || var_03 == "mg" || var_03 == "grenade" || var_03 == "rocketlauncher" || var_03 == "sniper" || var_03 == "cone" || var_03 == "beam" || var_03 == "shield")
	{
		if(var_02 == "altmode")
		{
			if(isdefined(param_01))
			{
				param_00 = param_01;
			}
		}

		var_08 = maps\mp\_utility::getweaponnametokens(param_00);
		var_07 = maps\mp\_utility::getbaseweaponname(param_00);
		if(var_08[0] == "iw5" || var_08[0] == "iw6" || var_08[0] == "h1")
		{
			foreach(var_0A in var_08)
			{
				var_0B = strtok(var_0A,"#");
				if(var_0B.size > 1)
				{
					if(var_0B[0] == "a")
					{
						var_05 = var_0B[1];
						continue;
					}

					if(var_0B[0] == "f")
					{
						var_06 = var_0B[1];
					}
				}
			}

			if(var_05 == "none" && var_06 == "none")
			{
				var_0D = getweaponattachments(param_00);
				var_0E = 0;
				foreach(var_10 in var_0D)
				{
					if(!maps\mp\_utility::isattachment(var_10))
					{
						continue;
					}

					var_11 = maps\mp\_utility::attachmentmap_tobase(var_10);
					if(var_0E <= 2)
					{
						var_04[var_0E] = var_11;
						var_0E++;
						continue;
					}

					break;
				}
			}
		}
		else if(var_08[0] == "alt")
		{
			var_13 = var_08[1] + "_" + var_08[2];
			var_07 = var_13;
			if(isdefined(var_08[4]) && maps\mp\_utility::isattachment(var_08[4]))
			{
				var_11 = maps\mp\_utility::attachmentmap_tobase(var_08[4]);
				var_04[0] = var_11;
			}

			if(isdefined(var_08[5]) && maps\mp\_utility::isattachment(var_08[5]))
			{
				var_11 = maps\mp\_utility::attachmentmap_tobase(var_08[5]);
				var_04[1] = var_11;
			}
		}
		else
		{
			var_08[var_08.size - 1] = undefined;
			if(isdefined(var_08[1]) && var_02 != "altmode")
			{
				var_11 = maps\mp\_utility::attachmentmap_tobase(var_08[1]);
				var_04[0] = var_11;
			}

			if(isdefined(var_08[2]) && var_02 != "altmode")
			{
				var_11 = maps\mp\_utility::attachmentmap_tobase(var_08[2]);
				var_04[1] = var_11;
			}
		}
	}
	else if(var_02 == "item" || var_02 == "offhand")
	{
		var_07 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
		var_07 = maps\mp\_utility::strip_suffix(var_07,"_mp");
	}
	else
	{
		var_07 = param_00;
	}

	var_14 = spawnstruct();
	var_14.weaponname = var_07;
	var_14.attachments = var_04;
	var_14.attachkit = var_05;
	var_14.furniturekit = var_06;
	var_14.weapontype = var_02;
	var_14.weaponclass = var_03;
	var_14.weaponnamefull = param_00;
	return var_14;
}

//Function Number: 17
logfirefightshotshits(param_00,param_01)
{
	if(!canlogclient(self) || isplayer(param_01) && !canlogclient(param_01) || !canloglife(param_00))
	{
		return;
	}

	if(!isplayer(param_01))
	{
		return;
	}

	if(param_00 >= level.maxlives)
	{
		return;
	}

	if(self.currentfirefightshots > 0)
	{
		setmatchdata("lives",param_00,"shots",maps\mp\_utility::clamptobyte(self.currentfirefightshots));
	}

	if(isdefined(param_01.enemyhitcounts) && isdefined(param_01.enemyhitcounts[self.guid]) && param_01.enemyhitcounts[self.guid] > 0)
	{
		setmatchdata("lives",param_00,"hits",maps\mp\_utility::clamptobyte(param_01.enemyhitcounts[self.guid]));
	}

	if(param_01.currentfirefightshots > 0)
	{
		setmatchdata("lives",param_00,"killerShots",maps\mp\_utility::clamptobyte(param_01.currentfirefightshots));
	}

	if(isdefined(self.enemyhitcounts) && isdefined(self.enemyhitcounts[param_01.guid]) && self.enemyhitcounts[param_01.guid] > 0)
	{
		setmatchdata("lives",param_00,"killerHits",maps\mp\_utility::clamptobyte(self.enemyhitcounts[param_01.guid]));
	}
}

//Function Number: 18
logplayerandkillerstanceandmotionstate(param_00,param_01)
{
	if(!canloglife(param_00))
	{
		return;
	}

	if(isplayer(self) && canlogclient(self))
	{
		var_02 = getstanceandmotionstateforplayer(self);
		setmatchdata("lives",param_00,"victimStanceAndMotionState",var_02);
	}

	if(isplayer(param_01) && canlogclient(param_01))
	{
		var_02 = getstanceandmotionstateforplayer(param_01);
		setmatchdata("lives",param_00,"killerStanceAndMotionState",var_02);
	}
}

//Function Number: 19
logassists(param_00,param_01)
{
	if(!canloglife(param_00))
	{
		return;
	}

	if(isplayer(self) && canlogclient(self))
	{
		if(isdefined(self.attackerdata))
		{
			var_02 = 0;
			foreach(var_04 in self.attackerdata)
			{
				if(isplayer(var_04.attackerent))
				{
					if(var_04.attackerent != param_01)
					{
						setmatchdata("lives",param_00,"assists",var_02,"assistingPlayerIndex",var_04.attackerent.clientid);
						setmatchdata("lives",param_00,"assists",var_02,"damage",maps\mp\_utility::clamptobyte(var_04.damage));
						var_02++;
						if(var_02 == 5)
						{
							break;
						}
					}
				}
			}

			if(var_02 < 5)
			{
				for(var_06 = var_02;var_06 < 5;var_06++)
				{
					setmatchdata("lives",param_00,"assists",var_06,"assistingPlayerIndex",255);
				}

				return;
			}
		}
	}
}

//Function Number: 20
logspecialassists(param_00,param_01)
{
	if(!isplayer(self) || !canlogclient(self))
	{
		return;
	}

	if(!isplayer(param_00) || !canlogclient(param_00))
	{
		return;
	}

	var_02 = self.lifeid;
	if(!canloglife(var_02))
	{
		return;
	}

	if(param_01 == "assist_uav" || param_01 == "assist_concussion" || param_01 == "assist_flash")
	{
		for(var_03 = 0;var_03 < 5;var_03++)
		{
			var_04 = getmatchdata("lives",var_02,"assists",var_03,"assistingPlayerIndex");
			if(var_04 == param_00.clientid || var_04 == 255)
			{
				if(var_04 == 255)
				{
					setmatchdata("lives",var_02,"assists",var_03,"assistingPlayerIndex",param_00.clientid);
				}

				if(param_01 == "assist_uav")
				{
					setmatchdata("lives",var_02,"assists",var_03,"assistUAV",1);
				}
				else if(param_01 == "assist_concussion")
				{
					setmatchdata("lives",var_02,"assists",var_03,"assistConcussion",1);
				}
				else if(param_01 == "assist_flash")
				{
					setmatchdata("lives",var_02,"assists",var_03,"assistFlash",1);
				}
				else
				{
				}

				break;
			}
		}
	}
}

//Function Number: 21
logplayerdeath(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!canlogclient(self) || isplayer(param_01) && !canlogclient(param_01) || !canloglife(param_00))
	{
		return;
	}

	if(param_00 >= level.maxlives)
	{
		return;
	}

	if(level.iszombiegame)
	{
		return;
	}

	if(isdefined(level.ishorde) && level.ishorde)
	{
		return;
	}

	logplayerandkilleradsandfov(param_00,param_01);
	logfirefightshotshits(param_00,param_01);
	logplayerandkillerstanceandmotionstate(param_00,param_01);
	logassists(param_00,param_01);
	var_08 = determineweaponnameandattachments(param_04,param_05);
	var_09 = maps\mp\gametypes\_class::attachkitnametoid(var_08.attachkit);
	setmatchdata("lives",param_00,"killersWeaponAttachKit",var_09);
	var_0A = maps\mp\gametypes\_class::furniturekitnametoid(var_08.furniturekit);
	setmatchdata("lives",param_00,"killersWeaponFurnitureKit",var_0A);
	if(var_08.weapontype != "exclusive")
	{
		setmatchdata("lives",param_00,"killersWeapon",var_08.weaponname);
	}

	if(var_08.weaponnamefull == "altmode")
	{
		setmatchdata("lives",param_00,"killersWeaponAltMode",1);
	}

	if(maps\mp\_utility::iskillstreakweapon(var_08.weaponnamefull))
	{
		setmatchdata("lives",param_00,"modifiers","killstreak",1);
		if(isdefined(param_01.currentkillstreakindex))
		{
			var_0B = getmatchdata("killstreaks",param_01.currentkillstreakindex,"killsTotal");
			var_0B++;
			setmatchdata("killstreaks",param_01.currentkillstreakindex,"killsTotal",maps\mp\_utility::clamptoshort(var_0B));
			setmatchdata("lives",param_00,"killerKillstreakIndex",param_01.currentkillstreakindex);
		}
	}
	else
	{
		setmatchdata("lives",param_00,"killerKillstreakIndex",255);
	}

	var_0C = determineweaponnameandattachments(param_07,undefined);
	var_09 = maps\mp\gametypes\_class::attachkitnametoid(var_0C.attachkit);
	setmatchdata("lives",param_00,"victimCurrentWeaponAtDeathAttachKit",var_09);
	var_0A = maps\mp\gametypes\_class::furniturekitnametoid(var_0C.furniturekit);
	setmatchdata("lives",param_00,"victimCurrentWeaponAtDeathFurnitureKit",var_0A);
	if(var_0C.weapontype != "exclusive")
	{
		if(maps\mp\_utility::iskillstreakweapon(var_0C.weaponname))
		{
			if(isdefined(self.primaryweapon))
			{
				var_0D = maps\mp\_utility::getbaseweaponname(self.primaryweapon);
				setmatchdata("lives",param_00,"victimCurrentWeaponAtDeath",var_0D);
			}
		}
		else
		{
			setmatchdata("lives",param_00,"victimCurrentWeaponAtDeath",var_0C.weaponname);
		}
	}

	if(isdefined(self.pickedupweaponfrom) && isdefined(self.pickedupweaponfrom[var_0C.weaponnamefull]))
	{
		setmatchdata("lives",param_00,"victimCurrentWeaponPickedUp",1);
	}

	setmatchdata("lives",param_00,"meansOfDeath",param_03);
	var_0E = 2;
	if(isplayer(param_01))
	{
		setmatchdata("lives",param_00,"killer",param_01.clientid);
		setmatchdata("lives",param_00,"killerLifeIndex",param_01.lifeid);
		setmatchdata("lives",param_00,"killerPos",0,int(param_01.origin[0]));
		setmatchdata("lives",param_00,"killerPos",1,int(param_01.origin[1]));
		setmatchdata("lives",param_00,"killerPos",2,int(param_01.origin[2]));
		setmatchdata("lives",param_00,"killerAngles",0,int(param_01.angles[0]));
		setmatchdata("lives",param_00,"killerAngles",1,int(param_01.angles[1]));
		setmatchdata("lives",param_00,"killerAngles",2,int(param_01.angles[2]));
		var_0F = anglestoforward((0,self.angles[1],0));
		var_10 = self.origin - param_01.origin;
		var_10 = vectornormalize((var_10[0],var_10[1],0));
		var_0E = vectordot(var_0F,var_10);
		setmatchdata("lives",param_00,"dotOfDeath",var_0E);
		if(isdefined(param_01.pickedupweaponfrom) && isdefined(param_01.pickedupweaponfrom[var_08.weaponnamefull]))
		{
			setmatchdata("lives",param_00,"killerCurrentWeaponPickedUp",1);
		}
	}
	else
	{
		setmatchdata("lives",param_00,"killer",255);
		setmatchdata("lives",param_00,"killerLifeIndex",65535);
		setmatchdata("lives",param_00,"killerPos",0,int(self.origin[0]));
		setmatchdata("lives",param_00,"killerPos",1,int(self.origin[1]));
		setmatchdata("lives",param_00,"killerPos",2,int(self.origin[2]));
		setmatchdata("lives",param_00,"killerAngles",0,int(self.angles[0]));
		setmatchdata("lives",param_00,"killerAngles",1,int(self.angles[1]));
		setmatchdata("lives",param_00,"killerAngles",2,int(self.angles[2]));
	}

	setmatchdata("lives",param_00,"kill_timestamp",getsystemtime());
	setmatchdata("lives",param_00,"player",self.clientid);
	setmatchdata("lives",param_00,"victimPos",0,int(self.origin[0]));
	setmatchdata("lives",param_00,"victimPos",1,int(self.origin[1]));
	setmatchdata("lives",param_00,"victimPos",2,int(self.origin[2]));
	setmatchdata("lives",param_00,"victimAngles",0,int(self.angles[0]));
	setmatchdata("lives",param_00,"victimAngles",1,int(self.angles[1]));
	setmatchdata("lives",param_00,"victimAngles",2,int(self.angles[2]));
	var_11 = "world";
	if(isplayer(param_01))
	{
		var_11 = param_01.name;
	}

	var_12 = 1;
	var_13 = 0;
	var_14 = maps\mp\_utility::isaiteamparticipant(self);
	var_15 = 0;
	if(isplayer(param_01))
	{
		var_15 = maps\mp\_utility::isaiteamparticipant(param_01);
	}

	var_16 = length(self.origin - param_01.origin);
	var_17 = 0;
	var_18 = 0;
	var_19 = -1;
	var_1A = -1;
	var_1B = gettime();
	if(isplayer(param_01))
	{
		var_18 = param_01 playerads();
	}

	var_1C = param_01.clientid;
	if(!isdefined(var_1C))
	{
		var_1C = -1;
	}

	var_1D = param_01.lifeid;
	if(!isdefined(var_1D))
	{
		var_1D = -1;
	}

	var_1E = 0.1;
	if(self.damage_info.size > 1)
	{
		var_12 = 0;
	}

	if(isdefined(self.damage_info[param_01 getentitynumber()]))
	{
		var_13 = self.damage_info[param_01 getentitynumber()].num_shots;
	}

	var_1F = self.pers["primaryWeapon"] + "_mp";
	var_20 = weaponclass(var_1F);
	if(issubstr(var_08.weaponname,"loot"))
	{
		var_17 = 1;
	}

	if(isdefined(self.spawninfo) && isdefined(self.spawninfo.spawntime))
	{
		var_19 = var_1B - self.spawninfo.spawntime / 1000;
	}

	if(isdefined(param_01.spawninfo) && isdefined(param_01.spawninfo.spawntime) && isplayer(param_01))
	{
		var_1A = var_1B - param_01.spawninfo.spawntime / 1000;
	}

	reconspatialevent(self.origin,"script_mp_playerdeath: player_name %s, life_id %d, angles %v, death_dot %f, is_jugg %b, is_killstreak %b, mod %s, gameTime %d, spawnToDeathTime %f, attackerAliveTime %f, attacker_life_id %d",self.name,self.lifeid,self.angles,var_0E,param_01 maps\mp\_utility::isjuggernaut(),maps\mp\_utility::iskillstreakweapon(var_08.weaponnamefull),param_03,var_1B,var_19,var_1A,var_1D);
	reconspatialevent(self.origin,"@"script_mp_weaponinfo: player_name %s, life_id %d, isbot %b, attacker_name %s, attacker %d, attacker_pos %v, distance %f, ads_fraction %f, is_jugg %b, is_killstreak %b, weapon_type %s, weapon_class %s, weapon_name %s, isLoot %b, attachKit %s, furnitureKit %s, numShots %d, soleAttacker %b, gameTime %d",self.name,self.lifeid,var_14,var_11,var_1C,param_01.origin,var_16,var_18,param_01 maps\mp\_utility::isjuggernaut(),maps\mp\_utility::iskillstreakweapon(var_08.weaponnamefull),var_08.weapontype,var_08.weaponclass,var_08.weaponname,var_17,var_08.attachkit,var_08.furniturekit,var_13,var_12,var_1B);
	reconspatialevent(self.origin,"script_mp_weaponinfo_ext: player_name %s, life_id %d, gametime %d, version %f, victimWeapon %s, victimWeaponClass %s, killerIsBot %b",self.name,self.lifeid,var_1B,var_1E,var_1F,var_20,var_15);
	if(!isdefined(level.matchdata))
	{
		level.matchdata = [];
	}

	if(!isdefined(level.matchdata["deathCount"]))
	{
		level.matchdata["deathCount"] = 1;
	}
	else
	{
		level.matchdata["deathCount"]++;
	}

	if(var_19 <= 3)
	{
		if(!isdefined(level.matchdata["badSpawnDiedTooFastCount"]))
		{
			level.matchdata["badSpawnDiedTooFastCount"] = 1;
		}
		else
		{
			level.matchdata["badSpawnDiedTooFastCount"]++;
		}

		if(self.spawninfo.badspawn == 0)
		{
			if(!isdefined(level.matchdata["badSpawnByAnyMeansCount"]))
			{
				level.matchdata["badSpawnByAnyMeansCount"] = 1;
			}
			else
			{
				level.matchdata["badSpawnByAnyMeansCount"]++;
			}

			self.spawninfo.badspawn = 1;
		}
	}

	if(isplayer(param_01) && var_1A <= 3)
	{
		if(!isdefined(level.matchdata["badSpawnKilledTooFastCount"]))
		{
			level.matchdata["badSpawnKilledTooFastCount"] = 1;
		}
		else
		{
			level.matchdata["badSpawnKilledTooFastCount"]++;
		}

		if(param_01.spawninfo.badspawn == 0)
		{
			if(!isdefined(level.matchdata["badSpawnByAnyMeansCount"]))
			{
				level.matchdata["badSpawnByAnyMeansCount"] = 1;
			}
			else
			{
				level.matchdata["badSpawnByAnyMeansCount"]++;
			}

			param_01.spawninfo.badspawn = 1;
		}
	}
}

//Function Number: 22
logplayerdata()
{
	if(!canlogclient(self))
	{
		return;
	}

	setmatchdata("players",self.clientid,"score",maps\mp\_utility::getpersstat("score"));
	if(maps\mp\_utility::getpersstat("assists") > 255)
	{
		setmatchdata("players",self.clientid,"assists",255);
	}
	else
	{
		setmatchdata("players",self.clientid,"assists",maps\mp\_utility::getpersstat("assists"));
	}

	if(maps\mp\_utility::getpersstat("longestStreak") > 255)
	{
		setmatchdata("players",self.clientid,"longestStreak",255);
	}
	else
	{
		setmatchdata("players",self.clientid,"longestStreak",maps\mp\_utility::getpersstat("longestStreak"));
	}

	if(isdefined(self) && isdefined(self.pers) && isdefined(self.pers["validationInfractions"]))
	{
		if(maps\mp\_utility::getpersstat("validationInfractions") > 255)
		{
			setmatchdata("players",self.clientid,"validationInfractions",255);
			return;
		}

		setmatchdata("players",self.clientid,"validationInfractions",maps\mp\_utility::getpersstat("validationInfractions"));
	}
}

//Function Number: 23
combinelbstat(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = param_01;
	}

	var_04 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round",param_03);
	var_05 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"lbstats",param_02,param_01);
	param_00 setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"lbstats",param_02,param_01,var_05 + var_04);
}

//Function Number: 24
endofgamesummarylogger()
{
	foreach(var_01 in level.players)
	{
		wait(0.05);
		if(!isdefined(var_01))
		{
			continue;
		}

		logplayerping(var_01);
		if(isdefined(var_01.detectedexploit) && var_01.detectedexploit && var_01 maps\mp\_utility::rankingenabled())
		{
			var_01 setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"restXPGoal",var_01.detectedexploit);
		}

		var_02 = undefined;
		var_03 = 0;
		if(isdefined(game["challengeStruct"]) && isdefined(game["challengeStruct"]["challengesCompleted"]) && isdefined(game["challengeStruct"]["challengesCompleted"][var_01.guid]))
		{
			var_03 = 1;
		}

		if(var_03)
		{
			var_02 = game["challengeStruct"]["challengesCompleted"][var_01.guid];
			if(var_02.size > 0)
			{
				var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","challengeNumCompleted",var_02.size);
				var_04 = maps\mp\_utility::clamptobyte(var_02.size);
				setmatchdata("players",var_01.clientid,"challengesCompleted",var_04);
			}
			else
			{
				var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","challengeNumCompleted",0);
			}
		}
		else
		{
			var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","challengeNumCompleted",0);
		}

		for(var_05 = 0;var_05 < 20;var_05++)
		{
			if(isdefined(var_02) && isdefined(var_02[var_05]) && var_02[var_05] != 8000)
			{
				var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","challengesCompleted",var_05,var_02[var_05]);
				continue;
			}

			var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","challengesCompleted",var_05,0);
		}

		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","gameMode",level.gametype);
		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","map",tolower(getdvar("mapname")));
		if(maps\mp\_utility::matchmakinggame())
		{
			var_06 = level.gametype;
			if(getdvarint("g_hardcore"))
			{
				var_06 = level.gametype + "_HC";
			}
			else if(getdvarint("g_oldschool"))
			{
				var_06 = level.gametype + "_OS";
			}

			combinelbstat(var_01,"score",var_06);
			combinelbstat(var_01,"timePlayed",var_06);
			combinelbstat(var_01,"kills",var_06);
			combinelbstat(var_01,"deaths",var_06);
			var_07 = var_01 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"lbstats",var_06,"gamesPlayed");
			var_01 setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"lbstats",var_06,"gamesPlayed",var_07 + 1);
			if(level.gametype == "war")
			{
				combinelbstat(var_01,"assists",var_06);
			}
			else if(level.gametype == "dm")
			{
				combinelbstat(var_01,"headshots",var_06);
			}
			else if(level.gametype == "conf")
			{
				combinelbstat(var_01,"confirms",var_06,"confirmed");
				combinelbstat(var_01,"denies",var_06,"denied");
			}
			else if(level.gametype == "sd")
			{
				combinelbstat(var_01,"plants",var_06);
				combinelbstat(var_01,"defuses",var_06);
				combinelbstat(var_01,"defends",var_06);
			}
			else if(level.gametype == "dom")
			{
				combinelbstat(var_01,"captures",var_06);
				combinelbstat(var_01,"defends",var_06);
			}
			else if(level.gametype == "koth")
			{
				combinelbstat(var_01,"captures",var_06);
				combinelbstat(var_01,"defends",var_06);
				combinelbstat(var_01,"destructions",var_06);
			}
			else if(level.gametype == "sab")
			{
				combinelbstat(var_01,"plants",var_06);
				combinelbstat(var_01,"defuses",var_06);
				combinelbstat(var_01,"defends",var_06);
			}
			else if(level.gametype == "ctf")
			{
				combinelbstat(var_01,"captures",var_06);
				combinelbstat(var_01,"returns",var_06);
				combinelbstat(var_01,"defends",var_06);
			}
			else if(level.gametype == "gun")
			{
				combinelbstat(var_01,"humiliations",var_06);
				combinelbstat(var_01,"setbacks",var_06);
			}
			else if(level.gametype == "hp")
			{
				combinelbstat(var_01,"captures",var_06);
				combinelbstat(var_01,"defends",var_06);
				combinelbstat(var_01,"captureTime",var_06);
			}
			else if(level.gametype == "dd")
			{
				combinelbstat(var_01,"plants",var_06);
				combinelbstat(var_01,"defuses",var_06);
				combinelbstat(var_01,"defends",var_06);
			}
			else if(level.gametype == "mugger")
			{
				combinelbstat(var_01,"muggings",var_06);
				combinelbstat(var_01,"banked",var_06);
			}
		}
	}
}

//Function Number: 25
logplayerping(param_00)
{
	if(!isdefined(param_00.pers["maxPing"]) || !isdefined(param_00.pers["minPing"]) || !isdefined(param_00.pers["pingAccumulation"]) || !isdefined(param_00.pers["pingSampleCount"]))
	{
		return;
	}

	if(param_00.pers["pingSampleCount"] > 0 && param_00.pers["maxPing"] > 0)
	{
		var_01 = maps\mp\_utility::clamptoshort(param_00.pers["pingAccumulation"] / param_00.pers["pingSampleCount"]);
		setmatchdata("players",param_00.clientid,"averagePing",var_01);
		setmatchdata("players",param_00.clientid,"maxPing",maps\mp\_utility::clamptoshort(param_00.pers["maxPing"]));
		setmatchdata("players",param_00.clientid,"minPing",maps\mp\_utility::clamptoshort(param_00.pers["minPing"]));
	}
}

//Function Number: 26
gameendlistener()
{
	level waittill("game_ended");
	foreach(var_01 in level.players)
	{
		var_01 logplayerdata();
		if(!isalive(var_01))
		{
			continue;
		}

		var_01 logplayerlife(0);
	}

	foreach(var_01 in level.players)
	{
		if(var_01.totallifetime > 0)
		{
			var_04 = var_01 maps\mp\_utility::getpersstat("score") / var_01.totallifetime / 60000;
			tournamentreportplayerspm(var_01.xuid,var_04,var_01.team);
		}

		var_01.totallifetime = 0;
	}
}

//Function Number: 27
canlogclient(param_00)
{
	if(isagent(param_00))
	{
		return 0;
	}

	var_01 = param_00.code_classname;
	if(!isdefined(var_01))
	{
		var_01 = "undefined";
	}

	return param_00.clientid < level.maxlogclients;
}

//Function Number: 28
canlogevent()
{
	return getmatchdata("eventCount") < level.maxevents;
}

//Function Number: 29
canlogkillstreak()
{
	return getmatchdata("killstreakCount") < level.maxkillstreaks;
}

//Function Number: 30
canloglife(param_00)
{
	return getmatchdata("lifeCount") < level.maxlives;
}

//Function Number: 31
logweaponstat(param_00,param_01,param_02)
{
	if(!canlogclient(self))
	{
		return;
	}

	if(maps\mp\_utility::iskillstreakweapon(param_00))
	{
		return;
	}

	if(!isdefined(self.pers["mpWeaponStats"][param_00]))
	{
		self.pers["mpWeaponStats"][param_00] = [];
	}

	if(!isdefined(self.pers["mpWeaponStats"][param_00][param_01]))
	{
		self.pers["mpWeaponStats"][param_00][param_01] = 0;
	}

	var_03 = self.pers["mpWeaponStats"][param_00][param_01];
	var_03 = var_03 + param_02;
	self.pers["mpWeaponStats"][param_00][param_01] = var_03;
}

//Function Number: 32
buildbaseweaponlist()
{
	var_00 = [];
	var_01 = 149;
	for(var_02 = 0;var_02 <= var_01;var_02++)
	{
		var_03 = tablelookup("mp/statstable.csv",0,var_02,4);
		if(var_03 == "")
		{
			continue;
		}

		if(!issubstr(tablelookup("mp/statsTable.csv",0,var_02,2),"weapon_"))
		{
			continue;
		}

		if(tablelookup("mp/statsTable.csv",0,var_02,2) == "weapon_other")
		{
			continue;
		}

		if(tablelookup("mp/statsTable.csv",0,var_02,51) != "")
		{
			continue;
		}

		var_00[var_00.size] = var_03;
	}

	return var_00;
}

//Function Number: 33
logkillsconfirmed()
{
	if(!canlogclient(self))
	{
		return;
	}

	setmatchdata("players",self.clientid,"killsConfirmed",self.pers["confirmed"]);
}

//Function Number: 34
logkillsdenied()
{
	if(!canlogclient(self))
	{
		return;
	}

	setmatchdata("players",self.clientid,"killsDenied",self.pers["denied"]);
}

//Function Number: 35
loginitialstats()
{
	if(getdvarint("mdsd") > 0)
	{
		var_00 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"experience");
		setmatchdata("players",self.clientid,"startXp",var_00);
		setmatchdata("players",self.clientid,"startKills",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"kills"));
		setmatchdata("players",self.clientid,"startDeaths",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"deaths"));
		setmatchdata("players",self.clientid,"startWins",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"wins"));
		setmatchdata("players",self.clientid,"startLosses",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"losses"));
		setmatchdata("players",self.clientid,"startHits",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"hits"));
		setmatchdata("players",self.clientid,"startMisses",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"misses"));
		setmatchdata("players",self.clientid,"startGamesPlayed",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"gamesPlayed"));
		setmatchdata("players",self.clientid,"startScore",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"score"));
		setmatchdata("players",self.clientid,"startPrestige",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"prestige"));
		setmatchdata("players",self.clientid,"startDP",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"division"));
		var_01 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"mmr");
		setmatchdata("players",self.clientid,"startMMR",var_01);
	}
}

//Function Number: 36
logfinalstats()
{
	if(getdvarint("mdsd") > 0)
	{
		var_00 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"experience");
		setmatchdata("players",self.clientid,"endXp",var_00);
		setmatchdata("players",self.clientid,"endKills",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"kills"));
		setmatchdata("players",self.clientid,"endDeaths",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"deaths"));
		setmatchdata("players",self.clientid,"endWins",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"wins"));
		setmatchdata("players",self.clientid,"endLosses",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"losses"));
		setmatchdata("players",self.clientid,"endHits",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"hits"));
		setmatchdata("players",self.clientid,"endMisses",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"misses"));
		setmatchdata("players",self.clientid,"endGamesPlayed",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"gamesPlayed"));
		setmatchdata("players",self.clientid,"endScore",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"score"));
		setmatchdata("players",self.clientid,"endPrestige",self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"prestige"));
		var_01 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"mmr");
		setmatchdata("players",self.clientid,"endMMR",var_01);
		if(isdefined(self.pers["rank"]))
		{
			var_03 = maps\mp\_utility::clamptobyte(maps\mp\gametypes\_rank::getrank());
			setmatchdata("players",self.clientid,"rankAtEnd",var_03);
		}
	}
}

//Function Number: 37
reconlogplayerinfo()
{
	for(;;)
	{
		if(getdvarint("cl_freemove") == 0)
		{
			foreach(var_01 in level.players)
			{
				var_02 = 0;
				if(maps\mp\_utility::isreallyalive(var_01))
				{
					var_02 = 1;
				}

				if(istestclient(var_01))
				{
					continue;
				}

				if(!isdefined(var_01.origin))
				{
					continue;
				}

				var_03 = "disconnected?";
				if(isdefined(var_01.name))
				{
					var_03 = var_01.name;
				}

				var_04 = -1;
				if(isdefined(var_01.clientid))
				{
					var_04 = var_01.clientid;
				}

				var_05 = (-999,-999,-999);
				if(isdefined(var_01.angles))
				{
					var_05 = var_01.angles;
				}

				var_06 = "undefined";
				if(isdefined(var_01.team))
				{
					var_06 = var_01.team;
				}

				var_07 = gettime();
				reconspatialevent(var_01.origin,"script_mp_playerpos: player_name %s, angles %v, gameTime %d, playerTeam %s, is_alive %b",var_03,var_05,var_07,var_06,var_02);
			}
		}

		wait(0.2);
	}
}