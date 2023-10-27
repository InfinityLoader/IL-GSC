/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_matchdata.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 28
 * Decompile Time: 493 ms
 * Timestamp: 10/27/2023 1:22:24 AM
*******************************************************************/

//Function Number: 1
func_44DF()
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
	level.maxkillstreaks = 64;
	level.maxlogclients = 30;
	level.maxnumchallengesperplayer = 10;
	level.maxnumawardsperplayer = 10;
	if(!maps\mp\_utility::func_47BB())
	{
		level thread gameendlistener();
		level thread func_2DDE();
	}
}

//Function Number: 2
func_3B23()
{
	return getmatchdata("dateTime");
}

//Function Number: 3
func_4F1D(param_00,param_01)
{
	if(!canlogclient(self) || !canlogkillstreak())
	{
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
func_4F1A(param_00,param_01)
{
	if(!canloglife(param_00))
	{
	}

	setmatchdata("lives",param_00,"modifiers",param_01,1);
}

//Function Number: 6
func_4F1E(param_00,param_01)
{
	if(!canloglife(param_00))
	{
	}

	setmatchdata("lives",param_00,"multikill",param_01);
}

//Function Number: 7
func_4F27()
{
	if(!canlogclient(self))
	{
		var_00 = level.maxlives;
	}

	if(self.curclass == "gamemode")
	{
		var_00 = self logmatchdatalife(self.clientid,self.spawnpos,self.var_78C4,self.var_8C4D);
	}
	else if(issubstr(self.curclass,"custom"))
	{
		var_01 = maps\mp\_utility::func_3A55(self.curclass);
		var_02 = maps\mp\gametypes\_class::cac_getweapon(var_01,0);
		var_03 = maps\mp\gametypes\_class::cac_getweaponattachment(var_01,0);
		var_04 = maps\mp\gametypes\_class::cac_getweaponattachmenttwo(var_01,0);
		var_05 = maps\mp\gametypes\_class::cac_getweapon(var_01,1);
		var_06 = maps\mp\gametypes\_class::cac_getweaponattachment(var_01,1);
		var_07 = maps\mp\gametypes\_class::cac_getweaponattachmenttwo(var_01,1);
		var_08 = "none";
		var_09 = maps\mp\gametypes\_class::cac_getperk(var_01,0);
		var_00 = self logmatchdatalife(self.clientid,self.spawnpos,self.var_78C4,self.var_8C4D,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		logplayerabilityperks(var_00);
	}
	else
	{
		var_01 = maps\mp\_utility::func_3A55(self.curclass);
		var_02 = maps\mp\gametypes\_class::func_7E4F(level.classtablename,var_09,0);
		var_03 = maps\mp\gametypes\_class::func_7E50(level.classtablename,var_08,0,0);
		var_04 = maps\mp\gametypes\_class::func_7E50(level.classtablename,var_07,0,1);
		var_05 = maps\mp\gametypes\_class::func_7E4F(level.classtablename,var_06,1);
		var_06 = maps\mp\gametypes\_class::func_7E50(level.classtablename,var_05,1,0);
		var_07 = maps\mp\gametypes\_class::func_7E50(level.classtablename,var_04,1,1);
		var_08 = maps\mp\gametypes\_class::func_7E4C(level.classtablename,var_03);
		var_09 = maps\mp\gametypes\_class::func_7E4A(level.classtablename,var_02,0);
		var_00 = self logmatchdatalife(self.clientid,self.spawnpos,self.var_78C4,self.var_8C4D,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		logplayerabilityperks(var_00);
	}

	return var_00;
}

//Function Number: 8
logplayerabilityperks(param_00)
{
	if(getdvarint("scr_trackPlayerAbilities",0) != 0)
	{
		if(isdefined(self.abilityflags) && self.abilityflags.size == 2)
		{
			setmatchdata("lives",param_00,"abilityFlags",0,self.abilityflags[0]);
			setmatchdata("lives",param_00,"abilityFlags",1,self.abilityflags[1]);
		}
	}
}

//Function Number: 9
func_4F28(param_00,param_01)
{
	if(!canlogclient(self))
	{
	}

	setmatchdata("players",self.clientid,param_01,param_00);
}

//Function Number: 10
func_4F26(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!canlogclient(self))
	{
	}

	if(param_00 >= level.maxlives)
	{
	}

	if(isplayer(param_01) && canlogclient(param_01))
	{
		self logmatchdatadeath(param_00,self.clientid,param_01,param_01.clientid,param_04,param_03,maps\mp\_utility::func_48F7(param_04),param_01 maps\mp\_utility::isjuggernaut());
	}

	self logmatchdatadeath(param_00,self.clientid,undefined,undefined,param_04,param_03,maps\mp\_utility::func_48F7(param_04),0);
}

//Function Number: 11
logplayerdata()
{
	if(!canlogclient(self))
	{
	}

	setmatchdata("players",self.clientid,"score",maps\mp\_utility::func_3B8D("score"));
	if(maps\mp\_utility::func_3B8D("assists") > 255)
	{
		setmatchdata("players",self.clientid,"assists",255);
	}
	else
	{
		setmatchdata("players",self.clientid,"assists",maps\mp\_utility::func_3B8D("assists"));
	}

	if(maps\mp\_utility::func_3B8D("longestStreak") > 255)
	{
		setmatchdata("players",self.clientid,"longestStreak",255);
	}
	else
	{
		setmatchdata("players",self.clientid,"longestStreak",maps\mp\_utility::func_3B8D("longestStreak"));
	}

	if(maps\mp\_utility::func_3B8D("validationInfractions") > 255)
	{
		setmatchdata("players",self.clientid,"validationInfractions",255);
	}

	setmatchdata("players",self.clientid,"validationInfractions",maps\mp\_utility::func_3B8D("validationInfractions"));
}

//Function Number: 12
func_2DDE()
{
	level waittill("game_ended");
	foreach(var_01 in level.players)
	{
		wait(0.05);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(isdefined(var_01.detectedexploit) && var_01.detectedexploit && var_01 maps\mp\_utility::func_634C())
		{
			var_01 setrankedplayerdata("restXPGoal",var_01.detectedexploit);
		}

		if(isdefined(var_01.weaponsused))
		{
			var_01 func_2A27();
			var_02 = 0;
			if(var_01.weaponsused.size > 3)
			{
				for(var_03 = var_01.weaponsused.size - 1;var_03 > var_01.weaponsused.size - 3;var_03--)
				{
					var_01 setcommonplayerdata("round","weaponsUsed",var_02,var_01.weaponsused[var_03]);
					var_01 setcommonplayerdata("round","weaponXpEarned",var_02,var_01.weaponxpearned[var_03]);
					var_02++;
				}
			}
			else
			{
				for(var_03 = var_01.weaponsused.size - 1;var_03 >= 0;var_03--)
				{
					var_01 setcommonplayerdata("round","weaponsUsed",var_02,var_01.weaponsused[var_03]);
					var_01 setcommonplayerdata("round","weaponXpEarned",var_02,var_01.weaponxpearned[var_03]);
					var_02++;
				}
			}
		}
		else
		{
			var_01 setcommonplayerdata("round","weaponsUsed",0,"none");
			var_01 setcommonplayerdata("round","weaponsUsed",1,"none");
			var_01 setcommonplayerdata("round","weaponsUsed",2,"none");
			var_01 setcommonplayerdata("round","weaponXpEarned",0,0);
			var_01 setcommonplayerdata("round","weaponXpEarned",1,0);
			var_01 setcommonplayerdata("round","weaponXpEarned",2,0);
		}

		if(isdefined(var_01.operationscompleted))
		{
			var_01 setcommonplayerdata("round","operationNumCompleted",var_01.operationscompleted.size);
		}
		else
		{
			var_01 setcommonplayerdata("round","operationNumCompleted",0);
		}

		for(var_03 = 0;var_03 < 5;var_03++)
		{
			if(isdefined(var_01.operationscompleted) && isdefined(var_01.operationscompleted[var_03]) && var_01.operationscompleted[var_03] != "ch_prestige" && !issubstr(var_01.operationscompleted[var_03],"_daily") && !issubstr(var_01.operationscompleted[var_03],"_weekly"))
			{
				var_01 setcommonplayerdata("round","operationsCompleted",var_03,var_01.operationscompleted[var_03]);
				continue;
			}

			var_01 setcommonplayerdata("round","operationsCompleted",var_03,"");
		}

		if(isdefined(var_01.challengescompleted))
		{
			var_01 setcommonplayerdata("round","challengeNumCompleted",var_01.challengescompleted.size);
		}
		else
		{
			var_01 setcommonplayerdata("round","challengeNumCompleted",0);
		}

		for(var_03 = 0;var_03 < 20;var_03++)
		{
			if(isdefined(var_01.challengescompleted) && isdefined(var_01.challengescompleted[var_03]) && var_01.challengescompleted[var_03] != "ch_prestige" && !issubstr(var_01.challengescompleted[var_03],"_daily") && !issubstr(var_01.challengescompleted[var_03],"_weekly"))
			{
				var_01 setcommonplayerdata("round","challengesCompleted",var_03,var_01.challengescompleted[var_03]);
				continue;
			}

			var_01 setcommonplayerdata("round","challengesCompleted",var_03,"");
		}

		var_01 setcommonplayerdata("round","gameMode",level.gametype);
		var_01 setcommonplayerdata("round","map",tolower(getdvar("mapname")));
		if(issquadsmode())
		{
			var_01 setcommonplayerdata("round","squadMode",1);
			continue;
		}

		var_01 setcommonplayerdata("round","squadMode",0);
	}
}

//Function Number: 13
func_2A27()
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

		var_01 func_4F27();
	}
}

//Function Number: 15
canlogclient(param_00)
{
	if(isagent(param_00))
	{
		return 0;
	}

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
	}

	if(param_00 == "iw6_pdwauto")
	{
		param_00 = "iw6_pdw";
	}
	else if(param_00 == "iw6_knifeonlyfast")
	{
		param_00 = "iw6_knifeonly";
	}

	if(maps\mp\_utility::func_48F7(param_00))
	{
	}

	storeweaponandattachmentstats("weaponStats",param_00,param_01,param_02);
}

//Function Number: 20
func_4F13(param_00,param_01,param_02)
{
	if(!canlogclient(self))
	{
	}

	storeweaponandattachmentstats("attachmentsStats",param_00,param_01,param_02);
}

//Function Number: 21
storeweaponandattachmentstats(param_00,param_01,param_02,param_03)
{
	var_04 = getmatchdata("players",self.clientid,param_00,param_01,param_02);
	var_05 = var_04 + param_03;
	if(param_02 == "kills" || param_02 == "deaths" || param_02 == "headShots")
	{
		if(var_05 > 255)
		{
			var_05 = 255;
		}
	}
	else if(var_05 > -1)
	{
		var_05 = -1;
	}

	setmatchdata("players",self.clientid,param_00,param_01,param_02,var_05);
}

//Function Number: 22
buildbaseweaponlist()
{
	var_00 = [];
	var_01 = 149;
	for(var_02 = 0;var_02 <= var_01;var_02++)
	{
		var_03 = tablelookup("mp/statstable.csv",0,var_02,4);
		if(var_03 == "" || var_03 == "uav" || var_03 == "iw6_knifeonlyfast" || var_03 == "laser_designator" || var_03 == "iw6_pdwauto")
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

//Function Number: 23
func_4F15(param_00,param_01)
{
	if(!canlogclient(self))
	{
	}

	if(issubstr(param_00,"_daily") || issubstr(param_00,"_weekly"))
	{
	}

	var_02 = getmatchdata("players",self.clientid,"challengeCount");
	if(var_02 < level.maxnumchallengesperplayer)
	{
		setmatchdata("players",self.clientid,"challenge",var_02,param_00);
		setmatchdata("players",self.clientid,"tier",var_02,param_01);
		setmatchdata("players",self.clientid,"challengeCount",var_02 + 1);
	}
}

//Function Number: 24
logaward(param_00)
{
	if(!canlogclient(self))
	{
	}

	var_01 = getmatchdata("players",self.clientid,"awardCount");
	if(var_01 < level.maxnumawardsperplayer)
	{
		setmatchdata("players",self.clientid,"awards",var_01,param_00);
		setmatchdata("players",self.clientid,"awardCount",var_01 + 1);
	}
}

//Function Number: 25
logkillsconfirmed()
{
	if(!canlogclient(self))
	{
	}

	setmatchdata("players",self.clientid,"killsConfirmed",self.pers["confirmed"]);
}

//Function Number: 26
func_4F1C()
{
	if(!canlogclient(self))
	{
	}

	setmatchdata("players",self.clientid,"killsDenied",self.pers["denied"]);
}

//Function Number: 27
loginitialstats()
{
	if(getdvarint("mdsd") > 0)
	{
		setmatchdata("players",self.clientid,"startXp",self getrankedplayerdata("experience"));
		setmatchdata("players",self.clientid,"startKills",self getrankedplayerdata("kills"));
		setmatchdata("players",self.clientid,"startDeaths",self getrankedplayerdata("deaths"));
		setmatchdata("players",self.clientid,"startWins",self getrankedplayerdata("wins"));
		setmatchdata("players",self.clientid,"startLosses",self getrankedplayerdata("losses"));
		setmatchdata("players",self.clientid,"startHits",self getrankedplayerdata("hits"));
		setmatchdata("players",self.clientid,"startMisses",self getrankedplayerdata("misses"));
		setmatchdata("players",self.clientid,"startGamesPlayed",self getrankedplayerdata("gamesPlayed"));
		setmatchdata("players",self.clientid,"startTimePlayedTotal",self getrankedplayerdata("timePlayedTotal"));
		setmatchdata("players",self.clientid,"startScore",self getrankedplayerdata("score"));
		setmatchdata("players",self.clientid,"startUnlockPoints",self getrankedplayerdata("unlockPoints"));
		setmatchdata("players",self.clientid,"startPrestige",self getrankedplayerdata("prestige"));
		for(var_00 = 0;var_00 < 10;var_00++)
		{
			setmatchdata("players",self.clientid,"startCharacterXP",var_00,self getrankedplayerdata("characterXP",var_00));
		}
	}
}

//Function Number: 28
logfinalstats()
{
	if(getdvarint("mdsd") > 0)
	{
		setmatchdata("players",self.clientid,"endXp",self getrankedplayerdata("experience"));
		setmatchdata("players",self.clientid,"endKills",self getrankedplayerdata("kills"));
		setmatchdata("players",self.clientid,"endDeaths",self getrankedplayerdata("deaths"));
		setmatchdata("players",self.clientid,"endWins",self getrankedplayerdata("wins"));
		setmatchdata("players",self.clientid,"endLosses",self getrankedplayerdata("losses"));
		setmatchdata("players",self.clientid,"endHits",self getrankedplayerdata("hits"));
		setmatchdata("players",self.clientid,"endMisses",self getrankedplayerdata("misses"));
		setmatchdata("players",self.clientid,"endGamesPlayed",self getrankedplayerdata("gamesPlayed"));
		setmatchdata("players",self.clientid,"endTimePlayedTotal",self getrankedplayerdata("timePlayedTotal"));
		setmatchdata("players",self.clientid,"endScore",self getrankedplayerdata("score"));
		setmatchdata("players",self.clientid,"endUnlockPoints",self getrankedplayerdata("unlockPoints"));
		setmatchdata("players",self.clientid,"endPrestige",self getrankedplayerdata("prestige"));
		for(var_00 = 0;var_00 < 10;var_00++)
		{
			setmatchdata("players",self.clientid,"endCharacterXP",var_00,self getrankedplayerdata("characterXP",var_00));
		}
	}
}