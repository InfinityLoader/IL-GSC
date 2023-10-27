/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_matchdata.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 25
 * Decompile Time: 450 ms
 * Timestamp: 10/27/2023 2:27:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(game["gamestarted"]))
	{
		setmatchdatadef("mp/matchdata.def");
		setmatchdata("map",level.script);
		if(level.hardcoremode)
		{
			var_00 = level.gametype + " hc";
			setmatchdata("gametype",var_00);
		}
		else
		{
			setmatchdata("gametype",level.gametype);
		}

		setmatchdata("buildVersion",getbuildversion());
		setmatchdata("buildNumber",getbuildnumber());
		setmatchdata("dateTime",getsystemtime());
		setmatchdataid();
	}

	level.maxlives = 285;
	level.maxnamelength = 26;
	level.maxevents = 150;
	level.maxkillstreaks = 125;
	level.maxlogclients = 30;
	level.maxnumchallengesperplayer = 10;
	level.maxnumawardsperplayer = 10;
	level thread gameendlistener();
	level thread func_28D2();
}

//Function Number: 2
getmatchdatetime()
{
	return getmatchdata("dateTime");
}

//Function Number: 3
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
	setmatchdata("killstreaks",var_02,"eventTime",gettime());
	setmatchdata("killstreaks",var_02,"eventPos",0,int(param_01[0]));
	setmatchdata("killstreaks",var_02,"eventPos",1,int(param_01[1]));
	setmatchdata("killstreaks",var_02,"eventPos",2,int(param_01[2]));
}

//Function Number: 4
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
	setmatchdata("events",var_02,"eventTime",gettime());
	setmatchdata("events",var_02,"eventPos",0,int(param_01[0]));
	setmatchdata("events",var_02,"eventPos",1,int(param_01[1]));
	setmatchdata("events",var_02,"eventPos",2,int(param_01[2]));
}

//Function Number: 5
func_28B4(param_00,param_01)
{
	if(!canloglife(param_00))
	{
		return;
	}

	setmatchdata("lives",param_00,"modifiers",param_01,1);
}

//Function Number: 6
logmultikill(param_00,param_01)
{
	if(!canloglife(param_00))
	{
		return;
	}

	setmatchdata("lives",param_00,"multikill",param_01);
}

//Function Number: 7
func_28B6(param_00)
{
	if(!canlogclient(self) || !canloglife(param_00))
	{
		return;
	}

	setmatchdata("lives",param_00,"player",self.clientid);
	setmatchdata("lives",param_00,"spawnPos",0,int(self.spawnpos[0]));
	setmatchdata("lives",param_00,"spawnPos",1,int(self.spawnpos[1]));
	setmatchdata("lives",param_00,"spawnPos",2,int(self.spawnpos[2]));
	setmatchdata("lives",param_00,"wasTacticalInsertion",self.wasti);
	setmatchdata("lives",param_00,"team",self.team);
	setmatchdata("lives",param_00,"spawnTime",self.spawntime);
	setmatchdata("lives",param_00,"duration",gettime() - self.spawntime);
	func_28BB(param_00);
}

//Function Number: 8
logplayerxp(param_00,param_01)
{
	if(!canlogclient(self))
	{
		return;
	}

	setmatchdata("players",self.clientid,param_01,param_00);
}

//Function Number: 9
func_28BB(param_00)
{
	if(!canlogclient(self) || !canloglife(param_00) || self.curclass == "gamemode")
	{
		return;
	}

	var_01 = self.curclass;
	if(var_01 == "copycat")
	{
		var_02 = self.pers["copyCatLoadout"];
		var_03 = var_02["loadoutPrimary"];
		var_04 = var_02["loadoutPrimaryAttachment"];
		var_05 = var_02["loadoutPrimaryAttachment2"];
		var_06 = var_02["loadoutPrimaryCamo"];
		var_07 = var_02["loadoutPrimaryBuff"];
		var_08 = var_02["loadoutSecondary"];
		var_09 = var_02["loadoutSecondaryAttachment"];
		var_0A = var_02["loadoutSecondaryAttachment2"];
		var_0B = var_02["loadoutSecondaryCamo"];
		var_0C = var_02["loadoutSecondaryBuff"];
		var_0D = var_02["loadoutEquipment"];
		var_0E = var_02["loadoutPerk1"];
		var_0F = var_02["loadoutPerk2"];
		var_10 = var_02["loadoutPerk3"];
		var_11 = var_02["loadoutOffhand"];
		var_12 = var_02["loadoutDeathstreak"];
		var_13 = var_02["loadoutStreakType"];
		var_14 = var_02["loadoutKillstreak1"];
		var_15 = var_02["loadoutKillstreak2"];
		var_16 = var_02["loadoutKillstreak3"];
	}
	else if(issubstr(var_16,"custom"))
	{
		var_17 = maps\mp\gametypes\_class::func_28BD(var_16);
		var_03 = maps\mp\gametypes\_class::func_282D(var_17,0);
		var_04 = maps\mp\gametypes\_class::cac_getweaponattachment(var_17,0);
		var_05 = maps\mp\gametypes\_class::func_28BF(var_17,0);
		var_08 = maps\mp\gametypes\_class::func_282D(var_17,1);
		var_09 = maps\mp\gametypes\_class::cac_getweaponattachment(var_17,1);
		var_0A = maps\mp\gametypes\_class::func_28BF(var_17,1);
		var_11 = maps\mp\gametypes\_class::cac_getoffhand(var_17);
		var_0D = maps\mp\gametypes\_class::func_28C1(var_17,0);
		var_0E = maps\mp\gametypes\_class::func_28C1(var_17,1);
		var_0F = maps\mp\gametypes\_class::func_28C1(var_17,2);
		var_10 = maps\mp\gametypes\_class::func_28C1(var_17,3);
		var_13 = maps\mp\gametypes\_class::func_28C1(var_17,5);
		var_12 = maps\mp\gametypes\_class::cac_getdeathstreak(var_17);
		var_07 = maps\mp\gametypes\_class::cac_getweaponbuff(var_17,0);
		var_0C = maps\mp\gametypes\_class::cac_getweaponbuff(var_17,1);
		var_14 = maps\mp\gametypes\_class::func_28C4(var_17,var_13,0);
		var_15 = maps\mp\gametypes\_class::func_28C4(var_17,var_13,1);
		var_16 = maps\mp\gametypes\_class::func_28C4(var_17,var_13,2);
	}
	else
	{
		var_17 = maps\mp\gametypes\_class::func_28BD(var_17);
		var_03 = maps\mp\gametypes\_class::func_28C6(level.classtablename,var_17,0);
		var_04 = maps\mp\gametypes\_class::func_28C7(level.classtablename,var_17,0,0);
		var_05 = maps\mp\gametypes\_class::func_28C7(level.classtablename,var_17,0,1);
		var_08 = maps\mp\gametypes\_class::func_28C6(level.classtablename,var_17,1);
		var_09 = maps\mp\gametypes\_class::func_28C7(level.classtablename,var_17,1,0);
		var_0A = maps\mp\gametypes\_class::func_28C7(level.classtablename,var_17,1,1);
		var_11 = maps\mp\gametypes\_class::table_getoffhand(level.classtablename,var_17);
		var_0D = maps\mp\gametypes\_class::table_getequipment(level.classtablename,var_17,0);
		var_0E = maps\mp\gametypes\_class::func_28CA(level.classtablename,var_17,1);
		var_0F = maps\mp\gametypes\_class::func_28CA(level.classtablename,var_17,2);
		var_10 = maps\mp\gametypes\_class::func_28CA(level.classtablename,var_17,3);
		var_13 = maps\mp\gametypes\_class::func_28CA(level.classtablename,var_17,5);
		var_12 = maps\mp\gametypes\_class::table_getdeathstreak(level.classtablename,var_17);
		var_07 = maps\mp\gametypes\_class::table_getweaponbuff(level.classtablename,var_17,0);
		var_0C = maps\mp\gametypes\_class::table_getweaponbuff(level.classtablename,var_17,1);
		var_14 = maps\mp\gametypes\_class::table_getkillstreak(level.classtablename,var_17,1);
		var_15 = maps\mp\gametypes\_class::table_getkillstreak(level.classtablename,var_17,2);
		var_16 = maps\mp\gametypes\_class::table_getkillstreak(level.classtablename,var_17,3);
	}

	var_04 = maps\mp\_utility::validateattachment(var_04);
	var_05 = maps\mp\_utility::validateattachment(var_05);
	var_09 = maps\mp\_utility::validateattachment(var_09);
	var_0A = maps\mp\_utility::validateattachment(var_0A);
	setmatchdata("lives",param_00,"primaryWeapon",var_03);
	setmatchdata("lives",param_00,"primaryAttachments",0,var_04);
	setmatchdata("lives",param_00,"primaryAttachments",1,var_05);
	setmatchdata("lives",param_00,"secondaryWeapon",var_08);
	setmatchdata("lives",param_00,"secondaryAttachments",0,var_09);
	setmatchdata("lives",param_00,"secondaryAttachments",1,var_09);
	setmatchdata("lives",param_00,"offhandWeapon",var_11);
	setmatchdata("lives",param_00,"equipment",var_0D);
	setmatchdata("lives",param_00,"perks",0,var_0E);
	setmatchdata("lives",param_00,"perks",1,var_0F);
	setmatchdata("lives",param_00,"perks",2,var_10);
	setmatchdata("lives",param_00,"strikePackage",var_13);
	setmatchdata("lives",param_00,"deathstreak",var_12);
	setmatchdata("lives",param_00,"weaponBuff",0,var_07);
	setmatchdata("lives",param_00,"weaponBuff",1,var_0C);
	switch(var_13)
	{
		case "streaktype_assault":
			setmatchdata("lives",param_00,"assaultStreaks",0,var_14);
			setmatchdata("lives",param_00,"assaultStreaks",1,var_15);
			setmatchdata("lives",param_00,"assaultStreaks",2,var_16);
			break;

		case "streaktype_support":
			setmatchdata("lives",param_00,"defenseStreaks",0,var_14);
			setmatchdata("lives",param_00,"defenseStreaks",1,var_15);
			setmatchdata("lives",param_00,"defenseStreaks",2,var_16);
			break;

		case "streaktype_specialist":
			setmatchdata("lives",param_00,"specialistStreaks",0,var_14);
			setmatchdata("lives",param_00,"specialistStreaks",1,var_15);
			setmatchdata("lives",param_00,"specialistStreaks",2,var_16);
			break;

		case "none":
			break;
	}
}

//Function Number: 10
func_28CF(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!canlogclient(self) || isplayer(param_01) && !canlogclient(param_01) || !canloglife(param_00))
	{
		return;
	}

	if(param_00 >= level.maxlives)
	{
		return;
	}

	if(param_04 == "none")
	{
		var_07 = "none";
		var_08 = "none";
	}
	else
	{
		var_07 = weaponinventorytype(param_06);
		var_08 = weaponclass(param_05);
	}

	if(issubstr(param_04,"destructible"))
	{
		param_04 = "destructible";
	}

	if(isdefined(var_07) && var_07 == "primary" || var_07 == "altmode" && var_08 == "pistol" || var_08 == "smg" || var_08 == "rifle" || var_08 == "spread" || var_08 == "mg" || var_08 == "grenade" || var_08 == "rocketlauncher" || var_08 == "sniper")
	{
		var_09 = undefined;
		if(var_07 == "altmode")
		{
			var_09 = param_04;
			param_04 = param_05;
			setmatchdata("lives",param_00,"altMode",1);
		}

		var_0A = strtok(param_04,"_");
		if(var_0A[0] == "iw5")
		{
			var_0F = var_0A[0] + "_" + var_0A[1];
			setmatchdata("lives",param_00,"weapon",var_0F);
			if(isdefined(var_0A[3]) && issubstr(var_0A[3],"scope") && issubstr(var_0A[3],"vz"))
			{
				var_0A[3] = "vzscope";
			}

			if(isdefined(var_0A[4]) && issubstr(var_0A[4],"scope") && issubstr(var_0A[4],"vz"))
			{
				var_0A[4] = "vzscope";
			}

			if(isdefined(var_0A[3]) && issubstr(var_0A[3],"scope") && !issubstr(var_0A[3],"vz"))
			{
				var_0A[3] = undefined;
			}

			if(isdefined(var_0A[4]) && issubstr(var_0A[4],"scope") && !issubstr(var_0A[4],"vz"))
			{
				var_0A[4] = undefined;
			}

			if(isdefined(var_0A[3]) && maps\mp\_utility::isattachment(var_0A[3]))
			{
				var_10 = maps\mp\_utility::validateattachment(var_0A[3]);
				setmatchdata("lives",param_00,"attachments",0,var_10);
			}

			if(isdefined(var_0A[4]) && maps\mp\_utility::isattachment(var_0A[4]))
			{
				var_10 = maps\mp\_utility::validateattachment(var_0A[4]);
				setmatchdata("lives",param_00,"attachments",1,var_10);
			}
		}
		else if(var_0A[0] == "alt")
		{
			var_0F = var_0A[1] + "_" + var_0A[2];
			setmatchdata("lives",param_00,"weapon",var_0F);
			if(isdefined(var_0A[4]) && maps\mp\_utility::isattachment(var_0A[4]))
			{
				var_10 = maps\mp\_utility::validateattachment(var_0A[4]);
				setmatchdata("lives",param_00,"attachments",0,var_10);
			}

			if(isdefined(var_0A[5]) && maps\mp\_utility::isattachment(var_0A[5]))
			{
				var_10 = maps\mp\_utility::validateattachment(var_0A[5]);
				setmatchdata("lives",param_00,"attachments",1,var_10);
			}
		}
		else
		{
			var_0A[var_0A.size - 1] = undefined;
			setmatchdata("lives",param_00,"weapon",var_0A[0]);
			if(isdefined(var_0A[1]) && var_07 != "altmode")
			{
				var_10 = maps\mp\_utility::validateattachment(var_0A[1]);
				setmatchdata("lives",param_00,"attachments",0,var_10);
			}

			if(isdefined(var_0A[2]) && var_07 != "altmode")
			{
				var_10 = maps\mp\_utility::validateattachment(var_0A[2]);
				setmatchdata("lives",param_00,"attachments",1,var_10);
			}
		}
	}
	else if(var_07 == "item" || var_07 == "offhand")
	{
		var_11 = maps\mp\_utility::strip_suffix(param_04,"_mp");
		setmatchdata("lives",param_00,"weapon",var_11);
	}
	else
	{
		setmatchdata("lives",param_00,"weapon",param_04);
	}

	if(maps\mp\_utility::func_2829(param_04))
	{
		setmatchdata("lives",param_00,"modifiers","killstreak",1);
	}

	setmatchdata("lives",param_00,"mod",param_03);
	if(isplayer(param_01))
	{
		setmatchdata("lives",param_00,"attacker",param_01.clientid);
		setmatchdata("lives",param_00,"attackerPos",0,int(param_01.origin[0]));
		setmatchdata("lives",param_00,"attackerPos",1,int(param_01.origin[1]));
		setmatchdata("lives",param_00,"attackerPos",2,int(param_01.origin[2]));
		var_12 = anglestoforward((0,self.angles[1],0));
		var_13 = self.origin - param_01.origin;
		var_13 = vectornormalize((var_13[0],var_13[1],0));
		setmatchdata("lives",param_00,"dotOfDeath",vectordot(var_12,var_13));
		if(param_01 maps\mp\_utility::isjuggernaut())
		{
			setmatchdata("lives",param_00,"attackerIsJuggernaut",1);
		}
	}
	else
	{
		setmatchdata("lives",param_00,"attacker",255);
		setmatchdata("lives",param_00,"attackerPos",0,int(self.origin[0]));
		setmatchdata("lives",param_00,"attackerPos",1,int(self.origin[1]));
		setmatchdata("lives",param_00,"attackerPos",2,int(self.origin[2]));
	}

	setmatchdata("lives",param_00,"player",self.clientid);
	setmatchdata("lives",param_00,"deathPos",0,int(self.origin[0]));
	setmatchdata("lives",param_00,"deathPos",1,int(self.origin[1]));
	setmatchdata("lives",param_00,"deathPos",2,int(self.origin[2]));
	setmatchdata("lives",param_00,"deathAngles",0,int(self.angles[0]));
	setmatchdata("lives",param_00,"deathAngles",1,int(self.angles[1]));
	setmatchdata("lives",param_00,"deathAngles",2,int(self.angles[2]));
}

//Function Number: 11
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
		return;
	}

	setmatchdata("players",self.clientid,"longestStreak",maps\mp\_utility::getpersstat("longestStreak"));
}

//Function Number: 12
func_28D2()
{
	level waittill("game_ended");
	foreach(var_01 in level.players)
	{
		wait 0.05;
		if(!isdefined(var_01))
		{
			continue;
		}

		if(isdefined(var_01.detectedexploit) && var_01.detectedexploit)
		{
			var_01 setplayerdata("restXPGoal",var_01.detectedexploit);
		}

		if(isdefined(var_01.weaponsused))
		{
			var_01 doublebubblesort();
			var_02 = 0;
			if(var_01.weaponsused.size > 3)
			{
				for(var_03 = var_01.weaponsused.size - 1;var_03 > var_01.weaponsused.size - 3;var_03--)
				{
					var_01 setplayerdata("round","weaponsUsed",var_02,var_01.weaponsused[var_03]);
					var_01 setplayerdata("round","weaponXpEarned",var_02,var_01.weaponxpearned[var_03]);
					var_02++;
				}
			}
			else
			{
				for(var_03 = var_01.weaponsused.size - 1;var_03 >= 0;var_03--)
				{
					var_01 setplayerdata("round","weaponsUsed",var_02,var_01.weaponsused[var_03]);
					var_01 setplayerdata("round","weaponXpEarned",var_02,var_01.weaponxpearned[var_03]);
					var_02++;
				}
			}
		}
		else
		{
			var_01 setplayerdata("round","weaponsUsed",0,"none");
			var_01 setplayerdata("round","weaponsUsed",1,"none");
			var_01 setplayerdata("round","weaponsUsed",2,"none");
			var_01 setplayerdata("round","weaponXpEarned",0,0);
			var_01 setplayerdata("round","weaponXpEarned",1,0);
			var_01 setplayerdata("round","weaponXpEarned",2,0);
		}

		if(isdefined(var_01.challengescompleted))
		{
			var_01 setplayerdata("round","challengeNumCompleted",var_01.challengescompleted.size);
		}
		else
		{
			var_01 setplayerdata("round","challengeNumCompleted",0);
		}

		for(var_03 = 0;var_03 < 20;var_03++)
		{
			if(isdefined(var_01.challengescompleted) && isdefined(var_01.challengescompleted[var_03]) && var_01.challengescompleted[var_03] != "ch_prestige" && !issubstr(var_01.challengescompleted[var_03],"_daily") && !issubstr(var_01.challengescompleted[var_03],"_weekly"))
			{
				var_01 setplayerdata("round","challengesCompleted",var_03,var_01.challengescompleted[var_03]);
				continue;
			}

			var_01 setplayerdata("round","challengesCompleted",var_03,"");
		}
	}
}

//Function Number: 13
doublebubblesort()
{
	var_00 = self.weaponxpearned;
	var_01 = self.weaponxpearned.size;
	for(var_02 = var_01 - 1;var_02 > 0;var_02--)
	{
		for(var_03 = 1;var_03 <= var_02;var_03++)
		{
			if(var_00[var_03 - 1] < var_00[var_03])
			{
				var_04 = self.weaponsused[var_03];
				self.weaponsused[var_03] = self.weaponsused[var_03 - 1];
				self.weaponsused[var_03 - 1] = var_04;
				var_05 = self.weaponxpearned[var_03];
				self.weaponxpearned[var_03] = self.weaponxpearned[var_03 - 1];
				self.weaponxpearned[var_03 - 1] = var_05;
				var_00 = self.weaponxpearned;
			}
		}
	}
}

//Function Number: 14
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

		var_02 = maps\mp\_utility::func_28D8();
		var_01 func_28B6(var_02);
	}
}

//Function Number: 15
canlogclient(param_00)
{
	return param_00.clientid < level.maxlogclients;
}

//Function Number: 16
canlogevent()
{
	return getmatchdata("eventCount") < level.maxevents;
}

//Function Number: 17
canlogkillstreak()
{
	return getmatchdata("killstreakCount") < level.maxkillstreaks;
}

//Function Number: 18
canloglife(param_00)
{
	return getmatchdata("lifeCount") < level.maxlives;
}

//Function Number: 19
logweaponstat(param_00,param_01,param_02)
{
	if(!canlogclient(self))
	{
		return;
	}

	if(maps\mp\_utility::func_2829(param_00))
	{
		return;
	}

	var_03 = getmatchdata("players",self.clientid,"weaponStats",param_00,param_01);
	if(param_01 == "kills" || param_01 == "deaths" || param_01 == "headShots")
	{
		if(var_03 + param_02 > 255)
		{
			setmatchdata("players",self.clientid,"weaponStats",param_00,param_01,255);
		}
		else
		{
			setmatchdata("players",self.clientid,"weaponStats",param_00,param_01,var_03 + param_02);
		}
	}

	setmatchdata("players",self.clientid,"weaponStats",param_00,param_01,var_03 + param_02);
}

//Function Number: 20
func_28DE(param_00,param_01,param_02)
{
	if(!canlogclient(self))
	{
		return;
	}

	var_03 = getmatchdata("players",self.clientid,"attachmentsStats",param_00,param_01);
	setmatchdata("players",self.clientid,"attachmentsStats",param_00,param_01,var_03 + param_02);
}

//Function Number: 21
func_28DF()
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

		var_00[var_00.size] = var_03;
	}

	return var_00;
}

//Function Number: 22
func_28E0(param_00,param_01)
{
	if(!canlogclient(self))
	{
		return;
	}

	if(issubstr(param_00,"_daily") || issubstr(param_00,"_weekly"))
	{
		return;
	}

	var_02 = getmatchdata("players",self.clientid,"challengeCount");
	if(var_02 < level.maxnumchallengesperplayer)
	{
		setmatchdata("players",self.clientid,"challenge",var_02,param_00);
		setmatchdata("players",self.clientid,"tier",var_02,param_01);
		setmatchdata("players",self.clientid,"challengeCount",var_02 + 1);
	}
}

//Function Number: 23
logaward(param_00)
{
	if(!canlogclient(self))
	{
		return;
	}

	var_01 = getmatchdata("players",self.clientid,"awardCount");
	if(var_01 < level.maxnumawardsperplayer)
	{
		setmatchdata("players",self.clientid,"awards",var_01,param_00);
		setmatchdata("players",self.clientid,"awardCount",var_01 + 1);
	}
}

//Function Number: 24
func_80EF()
{
	if(!canlogclient(self))
	{
		return;
	}

	setmatchdata("players",self.clientid,"killsConfirmed",self.pers["confirmed"]);
}

//Function Number: 25
func_80F0()
{
	if(!canlogclient(self))
	{
		return;
	}

	setmatchdata("players",self.clientid,"killsDenied",self.pers["denied"]);
}