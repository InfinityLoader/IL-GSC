/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_matchdata.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 1459 ms
 * Timestamp: 10/27/2023 12:20:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(game["gamestarted"]))
	{
		setmatchdatadef("mp/matchdata.ddl");
		setmatchdata("commonMatchData","map",level.script);
		if(level.var_8B38)
		{
			var_00 = level.gametype + " hc";
			setmatchdata("commonMatchData","gametype",var_00);
		}
		else
		{
			setmatchdata("commonMatchData","gametype",level.gametype);
		}

		setmatchdata("commonMatchData","buildVersion",function_007F());
		setmatchdata("commonMatchData","buildNumber",function_007E());
		setmatchdataid();
		setmatchdata("commonMatchData","isPrivateMatch",scripts\mp\_utility::func_D957());
		setmatchdata("firstOvertimeRoundIndex",-1);
		if(scripts\mp\_utility::func_9EA6())
		{
			setmatchdata("codESportsRules",1);
		}
	}

	level.var_B4AF = 475;
	level.var_B4B3 = 26;
	level.var_B49F = 250;
	level.var_B4A8 = 64;
	level.var_B4A9 = 64;
	level.var_B4B0 = 30;
	level.var_B4B5 = 10;
	level.var_B4B4 = 10;
	level.maxsupersavailable = 50;
	level.maxsupersactivated = 50;
	level.maxsupersexpired = 50;
	level thread func_766A();
	level thread func_636A();
}

//Function Number: 2
func_C558()
{
	setmatchdata("commonMatchData","utcStartTimeSeconds",function_00D2());
	setmatchdata("commonMatchData","playerCountStart",level.players.size);
}

//Function Number: 3
func_C557()
{
	setmatchdata("commonMatchData","utcEndTimeSeconds",function_00D2());
	setmatchdata("commonMatchData","playerCountEnd",level.players.size);
	setmatchdata("globalPlayerXpModifier",int(scripts\mp\_rank::func_7ED9()));
	setmatchdata("globalWeaponXpModifier",int(scripts\mp\_weaponrank::func_7EDB()));
}

//Function Number: 4
func_7F93()
{
	return getmatchdata("commonMatchData","utcStartTimeSeconds");
}

//Function Number: 5
func_81C8(param_00)
{
	var_01 = param_00;
	if(isdefined(level.var_10E00))
	{
		var_01 = var_01 - level.var_10E00;
		if(var_01 < 0)
		{
			var_01 = 0;
		}
	}
	else
	{
		var_01 = 0;
	}

	return var_01;
}

//Function Number: 6
logsupercommoneventdata(param_00,param_01,param_02,param_03)
{
	var_04 = func_81C8(gettime());
	setmatchdata(param_00,param_01,"lifeIndex",param_02);
	setmatchdata(param_00,param_01,"time_msFromMatchStart",var_04);
	setmatchdata(param_00,param_01,"playerPos",0,int(param_03[0]));
	setmatchdata(param_00,param_01,"playerPos",1,int(param_03[1]));
	setmatchdata(param_00,param_01,"playerPos",2,int(param_03[2]));
}

//Function Number: 7
logsuperavailableevent(param_00,param_01)
{
	var_02 = getmatchdata("supersAvailableCount");
	var_03 = var_02 + 1;
	setmatchdata("supersAvailableCount",var_03);
	if(var_02 >= level.maxsupersavailable)
	{
		return;
	}

	logsupercommoneventdata("supersAvailable",var_02,param_00,param_01);
}

//Function Number: 8
logsuperactivatedevent(param_00,param_01)
{
	var_02 = getmatchdata("supersActivatedCount");
	var_03 = var_02 + 1;
	setmatchdata("supersActivatedCount",var_03);
	if(var_02 >= level.maxsupersactivated)
	{
		return;
	}

	logsupercommoneventdata("supersActivated",var_02,param_00,param_01);
	self.scoreatsuperactivation = self.var_278;
}

//Function Number: 9
logsuperexpiredevent(param_00,param_01,param_02)
{
	var_03 = getmatchdata("supersExpiredCount");
	var_04 = var_03 + 1;
	setmatchdata("supersExpiredCount",var_04);
	if(var_03 >= level.maxsupersexpired)
	{
		return;
	}

	logsupercommoneventdata("supersExpired",var_03,param_00,param_01);
	setmatchdata("supersExpired",var_03,"expirationThroughDeath",param_02);
	var_05 = 0;
	if(isdefined(self.scoreatsuperactivation))
	{
		var_05 = self.var_278 - self.scoreatsuperactivation;
	}

	setmatchdata("supersExpired",var_03,"scoreEarned",var_05);
}

//Function Number: 10
func_AFC8(param_00)
{
	if(scripts\mp\_utility::func_9E0E(self) == 0)
	{
		return;
	}

	var_01 = getmatchdata("killstreakAvailableCount");
	var_02 = var_01 + 1;
	setmatchdata("killstreakAvailableCount",var_02);
	if(!func_38C6(self) || var_01 >= level.var_B4A9)
	{
		return;
	}

	var_03 = func_81C8(gettime());
	var_04 = -1;
	if(isdefined(self.var_B3E3))
	{
		var_04 = self.var_B3E3;
	}

	setmatchdata("killstreaksAvailable",var_01,"eventType",param_00);
	setmatchdata("killstreaksAvailable",var_01,"playerLifeIndex",var_04);
	setmatchdata("killstreaksAvailable",var_01,"eventTime_msFromMatchStart",var_03);
}

//Function Number: 11
func_AFC9(param_00,param_01)
{
	if(scripts\mp\_utility::func_9E0E(self) == 0)
	{
		return;
	}

	param_01 = self.origin;
	var_02 = getmatchdata("killstreakCount");
	var_03 = var_02 + 1;
	setmatchdata("killstreakCount",var_03);
	if(!func_38C6(self) || var_02 >= level.var_B4A8)
	{
		return;
	}

	var_04 = func_81C8(gettime());
	var_05 = -1;
	if(isdefined(self.var_B3E3))
	{
		var_05 = self.var_B3E3;
	}

	setmatchdata("killstreaks",var_02,"eventType",param_00);
	setmatchdata("killstreaks",var_02,"playerLifeIndex",var_05);
	setmatchdata("killstreaks",var_02,"eventTime_msFromMatchStart",var_04);
	setmatchdata("killstreaks",var_02,"playerPos",0,int(param_01[0]));
	setmatchdata("killstreaks",var_02,"playerPos",1,int(param_01[1]));
	setmatchdata("killstreaks",var_02,"playerPos",2,int(param_01[2]));
	self.lastmatchdatakillstreakindex = var_02;
}

//Function Number: 12
func_AFBA(param_00,param_01)
{
	if(isplayer(self) && !func_38C6(self))
	{
		return;
	}

	var_02 = getmatchdata("gameEventCount");
	var_03 = var_02 + 1;
	setmatchdata("gameEventCount",var_03);
	if(var_02 >= level.var_B49F)
	{
		return;
	}

	var_04 = func_81C8(gettime());
	var_05 = -1;
	if(scripts\mp\_utility::func_9E0E(self) == 1)
	{
		if(isdefined(self.var_B3E3))
		{
			var_05 = self.var_B3E3;
		}
	}

	setmatchdata("gameEvents",var_02,"eventType",param_00);
	setmatchdata("gameEvents",var_02,"playerLifeIndex",var_05);
	setmatchdata("gameEvents",var_02,"eventTime_msFromMatchStart",var_04);
	setmatchdata("gameEvents",var_02,"eventPos",0,int(param_01[0]));
	setmatchdata("gameEvents",var_02,"eventPos",1,int(param_01[1]));
	setmatchdata("gameEvents",var_02,"eventPos",2,int(param_01[2]));
}

//Function Number: 13
func_AFC5(param_00,param_01)
{
	if(!func_38CA(param_00))
	{
		return;
	}

	setmatchdata("lives",param_00,"modifiers",param_01,1);
}

//Function Number: 14
func_AFCB(param_00,param_01)
{
	if(!func_38CA(param_00))
	{
		return;
	}

	setmatchdata("lives",param_00,"multikill",param_01);
}

//Function Number: 15
func_AFD6()
{
	if(!func_38C6(self))
	{
		return level.var_B4AF - 1;
	}

	var_00 = 0;
	var_01 = (0,0,0);
	var_02 = 0;
	var_03 = -1;
	if(isdefined(self.var_10916))
	{
		var_00 = self.var_10916;
	}

	if(isdefined(self.var_108FF))
	{
		var_01 = self.var_108FF;
	}

	if(isdefined(self.var_1391E))
	{
		var_02 = self.var_1391E;
	}

	if(isdefined(self.var_AE6D))
	{
		var_03 = self.var_AE6D;
	}

	var_04 = func_81C8(var_00);
	var_05 = self logmatchdatalife(self.var_41F0,var_01,var_04,var_02,var_03);
	return var_05;
}

//Function Number: 16
func_AFD7(param_00,param_01)
{
	if(!func_38C6(self))
	{
		return;
	}

	setmatchdata("players",self.var_41F0,param_01,param_00);
}

//Function Number: 17
func_AFD5(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!func_38C6(self))
	{
		return;
	}

	if(param_00 >= level.var_B4AF)
	{
		return;
	}

	if(param_04 == "agent_mp")
	{
		var_07 = [];
	}
	else
	{
		var_07 = scripts\mp\_utility::func_821A(param_05);
		var_07 = scripts\mp\_utility::func_249F(var_07);
	}

	var_08 = func_81C8(gettime());
	var_09 = undefined;
	var_0A = [];
	if(isdefined(self.var_AA47))
	{
		var_09 = self.var_AA47;
		var_0A = scripts\mp\_utility::func_821A(var_09);
		var_0A = scripts\mp\_utility::func_249F(var_0A);
		if(scripts\mp\_utility::ispickedupweapon(var_09))
		{
			setmatchdata("lives",param_00,"victimCurrentWeaponPickedUp",1);
		}
	}

	if(isdefined(self.var_11234) && self.var_11234.var_9E53)
	{
		setmatchdata("lives",param_00,"victimSuperActive",1);
	}

	var_0B = 0;
	if(isdefined(self.var_13905))
	{
		var_0B = self.var_13905;
	}

	if(isplayer(param_01) && func_38C6(param_01))
	{
		var_0C = param_01 scripts\mp\_utility::func_9EE8();
		var_0D = 0.4226;
		var_0E = scripts\common\utility::func_13D90(self.origin,self.angles,param_01.origin,var_0D);
		var_0F = scripts\common\utility::func_13D90(param_01.origin,param_01.angles,self.origin,var_0D);
		var_10 = -1;
		if(isdefined(param_01.var_B3E3))
		{
			var_10 = param_01.var_B3E3;
		}

		if(param_01 scripts\mp\_utility::ispickedupweapon(param_04))
		{
			setmatchdata("lives",param_00,"attackerWeaponPickedUp",1);
		}

		if(isdefined(param_01.var_11234) && param_01.var_11234.var_9E53 && param_03 != "MOD_SUICIDE" && param_01.var_41F0 != self.var_41F0)
		{
			setmatchdata("lives",param_00,"attackerSuperActive",1);
			if(isdefined(param_01.pers["matchdataSuperKills"]))
			{
				param_01.pers["matchdataSuperKills"]++;
			}
			else
			{
				param_01.pers["matchdataSuperKills"] = 1;
			}
		}

		var_11 = scripts\mp\_utility::func_9E6C(param_04);
		self logmatchdatadeath(param_00,self.var_41F0,param_01,param_01.var_41F0,param_04,param_03,var_11,param_01 scripts\mp\_utility::func_9E59(),var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0F,var_0E,var_10);
		if(var_11)
		{
			if(isdefined(param_01.lastmatchdatakillstreakindex) && param_01.lastmatchdatakillstreakindex != -1)
			{
				setmatchdata("lives",param_00,"attackerKillstreakIndex",param_01.lastmatchdatakillstreakindex);
			}
		}
		else
		{
			setmatchdata("lives",param_00,"attackerKillstreakIndex",-1);
		}

		if(isdefined(level.var_B3FB))
		{
			var_12 = gettime();
			[[ level.var_B3FB ]](self.var_41F0,self.team,"DEATH",self.origin[0],self.origin[1],var_12);
			if(issubstr(tolower(param_03),"bullet") && isdefined(param_04) && !scripts\mp\_utility::func_9E6C(param_04))
			{
				[[ level.var_B3FB ]](param_01.var_41F0,param_01.team,"BULLET",param_01.origin[0],param_01.origin[1],var_12,undefined,self.origin[0],self.origin[1]);
			}
		}
	}
	else
	{
		self logmatchdatadeath(param_00,self.var_41F0,undefined,undefined,param_04,param_03,scripts\mp\_utility::func_9E6C(param_04),0,var_07,var_08,var_09,var_0A,var_0B,0,0,0,-1);
		setmatchdata("lives",param_00,"attackerKillstreakIndex",-1);
	}

	logxpscoreearnedinlife(param_00);
}

//Function Number: 18
logxpscoreearnedinlife(param_00)
{
	var_01 = self.pers["summary"]["xp"];
	var_02 = var_01 - self.pers["xpAtLastDeath"];
	self.pers["xpAtLastDeath"] = var_01;
	var_03 = self.var_278 - self.pers["scoreAtLastDeath"];
	self.pers["scoreAtLastDeath"] = self.var_278;
	setmatchdata("lives",param_00,"scoreEarned",var_03);
	setmatchdata("lives",param_00,"xpEarned",var_02);
}

//Function Number: 19
func_AFD4()
{
	if(!func_38C6(self))
	{
		return;
	}

	setmatchdata("players",self.var_41F0,"score",scripts\mp\_utility::getpersstat("score"));
	if(scripts\mp\_utility::getpersstat("assists") > 255)
	{
		setmatchdata("players",self.var_41F0,"assists",255);
	}
	else
	{
		setmatchdata("players",self.var_41F0,"assists",scripts\mp\_utility::getpersstat("assists"));
	}

	if(scripts\mp\_utility::getpersstat("longestStreak") > 255)
	{
		setmatchdata("players",self.var_41F0,"longestStreak",255);
	}
	else
	{
		setmatchdata("players",self.var_41F0,"longestStreak",scripts\mp\_utility::getpersstat("longestStreak"));
	}

	if(scripts\mp\_utility::getpersstat("validationInfractions") > 255)
	{
		setmatchdata("players",self.var_41F0,"validationInfractions",255);
	}
	else
	{
		setmatchdata("players",self.var_41F0,"validationInfractions",scripts\mp\_utility::getpersstat("validationInfractions"));
	}

	setmatchdata("players",self.var_41F0,"kills",scripts\mp\_utility::getpersstat("kills"));
	setmatchdata("players",self.var_41F0,"deaths",scripts\mp\_utility::getpersstat("deaths"));
	self method_8572(self.var_41F0);
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in self.pers["matchdataWeaponStats"])
	{
		setmatchdata("players",self.var_41F0,"weaponStats",var_02,"weapon",var_04.var_394);
		setmatchdata("players",self.var_41F0,"weaponStats",var_02,"variantID",var_04.var_1318B);
		foreach(var_07, var_06 in var_04.var_10E53)
		{
			setmatchdata("players",self.var_41F0,"weaponStats",var_02,var_07,int(var_06));
			if(var_07 == "hits")
			{
				var_00 = var_00 + var_06;
			}

			if(var_07 == "shots")
			{
				var_01 = var_01 + var_06;
			}
		}

		var_02++;
		if(var_02 >= 20)
		{
			break;
		}
	}

	self method_859A(self.var_41F0,var_01,var_00);
	var_09 = 0;
	if(isdefined(self.pers["matchdataSuperKills"]))
	{
		var_09 = self.pers["matchdataSuperKills"];
	}

	var_0A = 0;
	if(isdefined(self.pers["matchdataLongshotCount"]))
	{
		var_0A = self.pers["matchdataLongshotCount"];
	}

	var_0B = 0;
	if(isdefined(self.pers["matchdataDoubleKillsCount"]))
	{
		var_0B = self.pers["matchdataDoubleKillsCount"];
	}

	self method_85AC(self.var_41F0,scripts\mp\_utility::getpersstat("headshots"),var_0A,var_0B,var_09);
	foreach(var_08, var_0D in self.pers["matchdataScoreEventCounts"])
	{
		setmatchdata("players",self.var_41F0,"scoreEventCount",var_08,var_0D);
	}

	setmatchdata("players",self.var_41F0,"playerXpModifier",int(scripts\mp\_rank::func_80D3()));
	if(level.teambased)
	{
		setmatchdata("players",self.var_41F0,"teamXpModifier",int(scripts\mp\_rank::func_81B6(self.team)));
	}

	setmatchdata("players",self.var_41F0,"weaponXpModifier",int(scripts\mp\_weaponrank::func_8232()));
	level scripts\mp\_playerlogic::writesegmentdata(self);
	if(isdefined(self.contracts))
	{
		foreach(var_10, var_0F in self.contracts)
		{
			setmatchdata("players",self.var_41F0,"contracts",var_0F.var_10307,"challengeID",var_0F.var_92B8);
			setmatchdata("players",self.var_41F0,"contracts",var_0F.var_10307,"progress",var_0F.var_D9D9);
		}
	}
}

//Function Number: 20
func_AFD8(param_00)
{
	if(scripts\mp\_utility::func_9E0E(self) == 0)
	{
		return;
	}

	if(!func_38C6(self))
	{
		return;
	}

	if(isdefined(self.pers["matchdataScoreEventCounts"][param_00]))
	{
		self.pers["matchdataScoreEventCounts"][param_00]++;
		return;
	}

	self.pers["matchdataScoreEventCounts"][param_00] = 1;
}

//Function Number: 21
func_636A()
{
	level waittill("game_ended");
	foreach(var_01 in level.players)
	{
		wait(0.05);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(isdefined(var_01.var_13CD5))
		{
			var_01 func_5ADD();
			var_02 = 0;
			if(var_01.var_13CD5.size > 3)
			{
				for(var_03 = var_01.var_13CD5.size - 1;var_03 > var_01.var_13CD5.size - 3;var_03--)
				{
					var_01 setplayerdata("common","round","weaponsUsed",var_02,var_01.var_13CD5[var_03]);
					var_01 setplayerdata("common","round","weaponXpEarned",var_02,var_01.var_13CE2[var_03]);
					var_02++;
				}
			}
			else
			{
				for(var_03 = var_01.var_13CD5.size - 1;var_03 >= 0;var_03--)
				{
					var_01 setplayerdata("common","round","weaponsUsed",var_02,var_01.var_13CD5[var_03]);
					var_01 setplayerdata("common","round","weaponXpEarned",var_02,var_01.var_13CE2[var_03]);
					var_02++;
				}
			}
		}
		else
		{
			var_01 setplayerdata("common","round","weaponsUsed",0,"none");
			var_01 setplayerdata("common","round","weaponsUsed",1,"none");
			var_01 setplayerdata("common","round","weaponsUsed",2,"none");
			var_01 setplayerdata("common","round","weaponXpEarned",0,0);
			var_01 setplayerdata("common","round","weaponXpEarned",1,0);
			var_01 setplayerdata("common","round","weaponXpEarned",2,0);
		}

		if(isdefined(var_01.var_3C30))
		{
			var_01 setplayerdata("common","round","challengeNumCompleted",var_01.var_3C30.size);
		}
		else
		{
			var_01 setplayerdata("common","round","challengeNumCompleted",0);
		}

		for(var_03 = 0;var_03 < 20;var_03++)
		{
			if(isdefined(var_01.var_3C30) && isdefined(var_01.var_3C30[var_03]) && var_01.var_3C30[var_03] != "ch_prestige" && !issubstr(var_01.var_3C30[var_03],"_daily") && !issubstr(var_01.var_3C30[var_03],"_weekly"))
			{
				var_01 setplayerdata("common","round","challengesCompleted",var_03,var_01.var_3C30[var_03]);
				continue;
			}

			var_01 setplayerdata("common","round","challengesCompleted",var_03,"ch_none");
		}

		var_01 setplayerdata("common","round","gameMode",level.gametype);
		var_01 setplayerdata("common","round","map",tolower(getdvar("mapname")));
	}
}

//Function Number: 22
func_5ADD()
{
	var_00 = self.var_13CE2;
	var_01 = self.var_13CE2.size;
	for(var_02 = var_01 - 1;var_02 > 0;var_02--)
	{
		for(var_03 = 1;var_03 <= var_02;var_03++)
		{
			if(var_00[var_03 - 1] < var_00[var_03])
			{
				var_04 = self.var_13CD5[var_03];
				self.var_13CD5[var_03] = self.var_13CD5[var_03 - 1];
				self.var_13CD5[var_03 - 1] = var_04;
				var_05 = self.var_13CE2[var_03];
				self.var_13CE2[var_03] = self.var_13CE2[var_03 - 1];
				self.var_13CE2[var_03 - 1] = var_05;
				var_00 = self.var_13CE2;
			}
		}
	}
}

//Function Number: 23
func_766A()
{
	level waittill("game_ended");
	foreach(var_01 in level.players)
	{
		var_01 func_AFD4();
		if(!isalive(var_01))
		{
			continue;
		}
	}
}

//Function Number: 24
func_38C6(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}
	else if(isagent(param_00))
	{
		return 0;
	}
	else if(!isplayer(param_00))
	{
		return 0;
	}

	return param_00.var_41F0 < level.var_B4B0;
}

//Function Number: 25
func_38CA(param_00)
{
	return param_00 < level.var_B4AF;
}

//Function Number: 26
func_AFDC(param_00,param_01,param_02,param_03)
{
	if(!func_38C6(self))
	{
		return;
	}

	if(scripts\mp\_utility::func_9E6C(param_00))
	{
		return;
	}

	var_04 = param_00;
	if(isdefined(param_03))
	{
		var_04 = var_04 + "+loot" + param_03;
	}

	if(!isdefined(self.pers["matchdataWeaponStats"][var_04]))
	{
		self.pers["matchdataWeaponStats"][var_04] = spawnstruct();
		self.pers["matchdataWeaponStats"][var_04].var_10E53 = [];
		self.pers["matchdataWeaponStats"][var_04].var_394 = param_00;
		if(isdefined(param_03))
		{
			self.pers["matchdataWeaponStats"][var_04].var_1318B = param_03;
		}
		else
		{
			self.pers["matchdataWeaponStats"][var_04].var_1318B = -1;
		}
	}

	if(!isdefined(self.pers["matchdataWeaponStats"][var_04].var_10E53[param_01]))
	{
		self.pers["matchdataWeaponStats"][var_04].var_10E53[param_01] = param_02;
		return;
	}

	self.pers["matchdataWeaponStats"][var_04].var_10E53[param_01] = self.pers["matchdataWeaponStats"][var_04].var_10E53[param_01] + param_02;
}

//Function Number: 27
func_AF94(param_00,param_01,param_02)
{
	if(!func_38C6(self))
	{
		return;
	}

	if(!scripts\mp\_utility::func_2490(param_00))
	{
		return;
	}

	var_03 = getmatchdata("players",self.var_41F0,"attachmentsStats",param_00,param_01);
	var_04 = var_03 + param_02;
	setmatchdata("players",self.var_41F0,"attachmentsStats",param_00,param_01,var_04);
}

//Function Number: 28
func_322A()
{
	var_00 = [];
	var_01 = 149;
	for(var_02 = 0;var_02 <= var_01;var_02++)
	{
		var_03 = tablelookup("mp/statstable.csv",0,var_02,4);
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

//Function Number: 29
func_AF99(param_00,param_01)
{
	if(!func_38C6(self))
	{
		return;
	}

	if(issubstr(param_00,"_daily") || issubstr(param_00,"_weekly"))
	{
		return;
	}

	var_02 = getmatchdata("players",self.var_41F0,"challengeCount");
	if(var_02 < level.var_B4B5)
	{
		setmatchdata("players",self.var_41F0,"challenge",var_02,param_00);
		setmatchdata("players",self.var_41F0,"challengeCount",var_02 + 1);
	}
}

//Function Number: 30
func_AF97(param_00)
{
	if(!func_38C6(self))
	{
		return;
	}

	var_01 = getmatchdata("players",self.var_41F0,"awardCount");
	var_02 = var_01 + 1;
	setmatchdata("players",self.var_41F0,"awardCount",var_02);
	if(var_01 < level.var_B4B4)
	{
		setmatchdata("players",self.var_41F0,"awards",var_01,param_00);
	}

	if(param_00 == "double")
	{
		if(isdefined(self.pers["matchdataDoubleKillsCount"]))
		{
			self.pers["matchdataDoubleKillsCount"]++;
			return;
		}

		self.pers["matchdataDoubleKillsCount"] = 1;
		return;
	}

	if(param_00 == "longshot")
	{
		if(isdefined(self.pers["matchdataLongshotCount"]))
		{
			self.pers["matchdataLongshotCount"]++;
			return;
		}

		self.pers["matchdataLongshotCount"] = 1;
		return;
	}
}

//Function Number: 31
func_AFC6()
{
	if(!func_38C6(self))
	{
		return;
	}

	setmatchdata("players",self.var_41F0,"killsConfirmed",self.pers["confirmed"]);
}

//Function Number: 32
func_AFC7()
{
	if(!func_38C6(self))
	{
		return;
	}

	setmatchdata("players",self.var_41F0,"killsDenied",self.pers["denied"]);
}

//Function Number: 33
func_AFC4()
{
	if(getdvarint("mdsd") > 0)
	{
		setmatchdata("players",self.var_41F0,"startXp",self getplayerdata("mp","progression","playerLevel","xp"));
		setmatchdata("players",self.var_41F0,"startKills",self getplayerdata("mp","kills"));
		setmatchdata("players",self.var_41F0,"startDeaths",self getplayerdata("mp","deaths"));
		setmatchdata("players",self.var_41F0,"startWins",self getplayerdata("mp","wins"));
		setmatchdata("players",self.var_41F0,"startLosses",self getplayerdata("mp","losses"));
		setmatchdata("players",self.var_41F0,"startHits",self getplayerdata("mp","hits"));
		setmatchdata("players",self.var_41F0,"startMisses",self getplayerdata("mp","misses"));
		setmatchdata("players",self.var_41F0,"startGamesPlayed",self getplayerdata("mp","gamesPlayed"));
		setmatchdata("players",self.var_41F0,"startTimePlayedTotal",self getplayerdata("mp","timePlayedTotal"));
		setmatchdata("players",self.var_41F0,"startScore",self getplayerdata("mp","score"));
		setmatchdata("players",self.var_41F0,"startPrestige",self getplayerdata("mp","progression","playerLevel","prestige"));
	}
}

//Function Number: 34
func_AFB9()
{
	if(!self method_8592())
	{
		return;
	}

	if(getdvarint("mdsd") > 0)
	{
		setmatchdata("players",self.var_41F0,"endXp",self getplayerdata("mp","progression","playerLevel","xp"));
		setmatchdata("players",self.var_41F0,"endKills",self getplayerdata("mp","kills"));
		setmatchdata("players",self.var_41F0,"endDeaths",self getplayerdata("mp","deaths"));
		setmatchdata("players",self.var_41F0,"endWins",self getplayerdata("mp","wins"));
		setmatchdata("players",self.var_41F0,"endLosses",self getplayerdata("mp","losses"));
		setmatchdata("players",self.var_41F0,"endHits",self getplayerdata("mp","hits"));
		setmatchdata("players",self.var_41F0,"endMisses",self getplayerdata("mp","misses"));
		setmatchdata("players",self.var_41F0,"endGamesPlayed",self getplayerdata("mp","gamesPlayed"));
		setmatchdata("players",self.var_41F0,"endTimePlayedTotal",self getplayerdata("mp","timePlayedTotal"));
		setmatchdata("players",self.var_41F0,"endScore",self getplayerdata("mp","score"));
		setmatchdata("players",self.var_41F0,"endPrestige",self getplayerdata("mp","progression","playerLevel","prestige"));
	}
}