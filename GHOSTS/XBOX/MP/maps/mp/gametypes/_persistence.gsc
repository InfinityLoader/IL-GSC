/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_persistence.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 30
 * Decompile Time: 475 ms
 * Timestamp: 10/27/2023 1:31:24 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	maps\mp\gametypes\_class::func_44DF();
	if(!maps\mp\_utility::func_47BB())
	{
		level.persistentdatainfo = [];
		maps\mp\gametypes\_missions::func_44DF();
		maps\mp\gametypes\_rank::func_44DF();
		level thread func_86D0();
		level thread func_876D();
		level thread writekdhistorystats();
	}

	maps\mp\gametypes\_playercards::func_44DF();
}

//Function Number: 2
func_45F6()
{
	self.bufferedstats = [];
	self.squadmemberbufferedstats = [];
	if(maps\mp\_utility::func_634C())
	{
		self.bufferedstats["totalShots"] = self getrankedplayerdata("totalShots");
		self.bufferedstats["accuracy"] = self getrankedplayerdata("accuracy");
		self.bufferedstats["misses"] = self getrankedplayerdata("misses");
		self.bufferedstats["hits"] = self getrankedplayerdata("hits");
		self.bufferedstats["timePlayedAllies"] = self getrankedplayerdata("timePlayedAllies");
		self.bufferedstats["timePlayedOpfor"] = self getrankedplayerdata("timePlayedOpfor");
		self.bufferedstats["timePlayedOther"] = self getrankedplayerdata("timePlayedOther");
		self.bufferedstats["timePlayedTotal"] = self getrankedplayerdata("timePlayedTotal");
		var_00 = self getrankedplayerdata("activeSquadMember");
		self.squadmemberbufferedstats["experienceToPrestige"] = self getrankedplayerdata("squadMembers",var_00,"experienceToPrestige");
	}

	self.bufferedchildstats = [];
	self.bufferedchildstats["round"] = [];
	self.bufferedchildstats["round"]["timePlayed"] = self getcommonplayerdata("round","timePlayed");
	if(maps\mp\_utility::func_634C())
	{
		self.bufferedchildstats["xpMultiplierTimePlayed"] = [];
		self.bufferedchildstats["xpMultiplierTimePlayed"][0] = self getrankedplayerdata("xpMultiplierTimePlayed",0);
		self.bufferedchildstats["xpMultiplierTimePlayed"][1] = self getrankedplayerdata("xpMultiplierTimePlayed",1);
		self.bufferedchildstats["xpMultiplierTimePlayed"][2] = self getrankedplayerdata("xpMultiplierTimePlayed",2);
		self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"] = [];
		self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0] = self getrankedplayerdata("xpMaxMultiplierTimePlayed",0);
		self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1] = self getrankedplayerdata("xpMaxMultiplierTimePlayed",1);
		self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2] = self getrankedplayerdata("xpMaxMultiplierTimePlayed",2);
		self.bufferedchildstats["challengeXPMultiplierTimePlayed"] = [];
		self.bufferedchildstats["challengeXPMultiplierTimePlayed"][0] = self getrankedplayerdata("challengeXPMultiplierTimePlayed",0);
		self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"] = [];
		self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0] = self getrankedplayerdata("challengeXPMaxMultiplierTimePlayed",0);
		self.bufferedchildstats["weaponXPMultiplierTimePlayed"] = [];
		self.bufferedchildstats["weaponXPMultiplierTimePlayed"][0] = self getrankedplayerdata("weaponXPMultiplierTimePlayed",0);
		self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"] = [];
		self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0] = self getrankedplayerdata("weaponXPMaxMultiplierTimePlayed",0);
		if(getactiveclientcount())
		{
			self.bufferedstats["prestigeDoubleXp"] = self getrankedplayerdata("prestigeDoubleXp");
			self.bufferedstats["prestigeDoubleXpTimePlayed"] = self getrankedplayerdata("prestigeDoubleXpTimePlayed");
			self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"] = self getrankedplayerdata("prestigeDoubleXpMaxTimePlayed");
		}

		self.bufferedstats["prestigeDoubleWeaponXp"] = self getrankedplayerdata("prestigeDoubleWeaponXp");
		self.bufferedstats["prestigeDoubleWeaponXpTimePlayed"] = self getrankedplayerdata("prestigeDoubleWeaponXpTimePlayed");
		self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] = self getrankedplayerdata("prestigeDoubleWeaponXpMaxTimePlayed");
	}
}

//Function Number: 3
func_7B16(param_00)
{
	return self getrankedplayerdata(param_00);
}

//Function Number: 4
func_7B26(param_00,param_01)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	self setrankedplayerdata(param_00,param_01);
}

//Function Number: 5
func_7B07(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	if(isdefined(param_02))
	{
		var_03 = self getrankedplayerdata(param_00,param_02);
		self setrankedplayerdata(param_00,param_02,param_01 + var_03);
	}

	var_03 = self getrankedplayerdata(param_01);
	self setrankedplayerdata(param_00,param_01 + var_03);
}

//Function Number: 6
func_7B18(param_00,param_01)
{
	if(param_00 == "round")
	{
		return self getcommonplayerdata(param_00,param_01);
	}

	return self getrankedplayerdata(param_00,param_01);
}

//Function Number: 7
func_7B28(param_00,param_01,param_02)
{
	if(isbot(self))
	{
	}

	if(!maps\mp\_utility::func_634C())
	{
	}

	if(param_00 == "round")
	{
		self setcommonplayerdata(param_00,param_01,param_02);
	}

	self setrankedplayerdata(param_00,param_01,param_02);
}

//Function Number: 8
func_7B0A(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	var_03 = self getrankedplayerdata(param_00,param_01);
	self setrankedplayerdata(param_00,param_01,var_03 + param_02);
}

//Function Number: 9
func_7B19(param_00,param_01)
{
	if(!maps\mp\_utility::func_634C())
	{
		return 0;
	}

	return self.bufferedchildstats[param_00][param_01];
}

//Function Number: 10
func_7B29(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	self.bufferedchildstats[param_00][param_01] = param_02;
}

//Function Number: 11
func_7B0B(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	var_03 = func_7B19(param_00,param_01);
	func_7B29(param_00,param_01,var_03 + param_02);
}

//Function Number: 12
func_7B09(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	var_03 = statgetbuffered(param_00) + param_01;
	if(var_03 > param_02)
	{
		var_03 = param_02;
	}

	if(var_03 < statgetbuffered(param_00))
	{
		var_03 = param_02;
	}

	func_7B27(param_00,var_03);
}

//Function Number: 13
func_7B0C(param_00,param_01,param_02,param_03)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	var_04 = func_7B19(param_00,param_01) + param_02;
	if(var_04 > param_03)
	{
		var_04 = param_03;
	}

	if(var_04 < func_7B19(param_00,param_01))
	{
		var_04 = param_03;
	}

	func_7B29(param_00,param_01,var_04);
}

//Function Number: 14
statgetbuffered(param_00)
{
	if(!maps\mp\_utility::func_634C())
	{
		return 0;
	}

	return self.bufferedstats[param_00];
}

//Function Number: 15
statgetsquadbuffered(param_00)
{
	if(!maps\mp\_utility::func_634C())
	{
		return 0;
	}

	return self.squadmemberbufferedstats[param_00];
}

//Function Number: 16
func_7B27(param_00,param_01)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	self.bufferedstats[param_00] = param_01;
}

//Function Number: 17
statsetsquadbuffered(param_00,param_01)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	self.squadmemberbufferedstats[param_00] = param_01;
}

//Function Number: 18
func_7B08(param_00,param_01)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	var_02 = statgetbuffered(param_00);
	func_7B27(param_00,var_02 + param_01);
}

//Function Number: 19
stataddsquadbuffered(param_00,param_01)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	var_02 = statgetsquadbuffered(param_00);
	statsetsquadbuffered(param_00,var_02 + param_01);
}

//Function Number: 20
func_86D0()
{
	wait(0.15);
	var_00 = 0;
	while(!level.gameended)
	{
		maps\mp\gametypes\_hostmigration::func_8BBA();
		var_00++;
		if(var_00 >= level.players.size)
		{
			var_00 = 0;
		}

		if(isdefined(level.players[var_00]))
		{
			level.players[var_00] func_8E5C();
			level.players[var_00] func_8756();
		}

		wait(2);
	}

	foreach(var_02 in level.players)
	{
		var_02 func_8E5C();
		var_02 func_8756();
	}
}

//Function Number: 21
func_8E5C()
{
	var_00 = maps\mp\_utility::func_634C();
	if(var_00)
	{
		foreach(var_03, var_02 in self.bufferedstats)
		{
			self setrankedplayerdata(var_03,var_02);
		}

		if(!isai(self))
		{
			foreach(var_03, var_02 in self.squadmemberbufferedstats)
			{
				self setrankedplayerdata("squadMembers",self.pers["activeSquadMember"],var_03,var_02);
			}
		}
	}

	foreach(var_03, var_02 in self.bufferedchildstats)
	{
		foreach(var_08, var_07 in var_02)
		{
			if(var_03 == "round")
			{
				self setcommonplayerdata(var_03,var_08,var_07);
				continue;
			}

			if(var_00)
			{
				self setrankedplayerdata(var_03,var_08,var_07);
			}
		}
	}
}

//Function Number: 22
writekdhistorystats()
{
	if(!maps\mp\_utility::func_50C1())
	{
	}

	if(getactiveclientcount())
	{
	}

	level waittill("game_ended");
	wait(0.1);
	if(maps\mp\_utility::func_8C49() || !maps\mp\_utility::func_4950() && maps\mp\_utility::func_4280())
	{
		foreach(var_01 in level.players)
		{
			var_01 incrementrankedreservedhistory(var_01.kills,var_01.deaths);
		}
	}
}

//Function Number: 23
incrementrankedreservedhistory(param_00,param_01)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	for(var_02 = 0;var_02 < 4;var_02++)
	{
		var_03 = self getclanwarsbonusforcurrentplaylist("kdHistoryK" + var_02 + 1);
		self getrankedplayerdatareservedint("kdHistoryK" + var_02,var_03);
		var_03 = self getclanwarsbonusforcurrentplaylist("kdHistoryD" + var_02 + 1);
		self getrankedplayerdatareservedint("kdHistoryD" + var_02,var_03);
	}

	self getrankedplayerdatareservedint("kdHistoryK4",castint(clamp(param_00,0,255)));
	self getrankedplayerdatareservedint("kdHistoryD4",castint(clamp(param_01,0,255)));
}

//Function Number: 24
func_4488(param_00,param_01,param_02)
{
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

	if(isdefined(level.disableweaponstats))
	{
	}

	if(maps\mp\_utility::func_634C())
	{
		var_03 = self getrankedplayerdata("weaponStats",param_00,param_01);
		self setrankedplayerdata("weaponStats",param_00,param_01,var_03 + param_02);
	}
}

//Function Number: 25
func_4486(param_00,param_01,param_02)
{
	if(isdefined(level.disableweaponstats))
	{
	}

	if(maps\mp\_utility::func_634C())
	{
		var_03 = self getrankedplayerdata("attachmentsStats",param_00,param_01);
		self setrankedplayerdata("attachmentsStats",param_00,param_01,var_03 + param_02);
	}
}

//Function Number: 26
func_8756()
{
	if(!isdefined(self.trackingweaponname))
	{
	}

	if(self.trackingweaponname == "" || self.trackingweaponname == "none")
	{
	}

	if(maps\mp\_utility::func_48F7(self.trackingweaponname) || maps\mp\_utility::func_48B7(self.trackingweaponname))
	{
	}

	var_00 = self.trackingweaponname;
	var_01 = undefined;
	var_02 = getsubstr(var_00,0,4);
	if(var_02 == "alt_")
	{
		var_03 = maps\mp\_utility::func_3C72(var_00);
		foreach(var_05 in var_03)
		{
			if(var_05 == "shotgun" || var_05 == "gl")
			{
				var_01 = var_05;
				break;
			}
		}

		if(!isdefined(var_01))
		{
			var_07 = strtok(var_00,"_");
			var_01 = var_07[1] + "_" + var_07[2];
		}
	}
	else if(var_02 == "iw5_" || var_02 == "iw6_")
	{
		var_07 = strtok(var_00,"_");
		var_01 = var_07[0] + "_" + var_07[1];
	}

	if(var_01 == "gl" || var_01 == "shotgun")
	{
		func_5BAE(var_01);
		func_5BA9();
	}

	if(!maps\mp\_utility::iscacprimaryweapon(var_01) && !maps\mp\_utility::func_4890(var_01))
	{
	}

	perslog_weaponstats(var_01);
	var_03 = getweaponattachments(var_00);
	foreach(var_05 in var_03)
	{
		var_09 = maps\mp\_utility::attachmentmap_tobase(var_05);
		switch(var_09)
		{
			case "scope":
			case "gl":
			case "shotgun":
				break;
		}

		func_5BAE(var_09);
	}

	func_5BA9();
}

//Function Number: 27
func_5BA9()
{
	self.trackingweaponname = "none";
	self.trackingweaponshots = 0;
	self.trackingweaponkills = 0;
	self.trackingweaponhits = 0;
	self.trackingweaponheadshots = 0;
	self.trackingweapondeaths = 0;
}

//Function Number: 28
perslog_weaponstats(param_00)
{
	if(self.trackingweaponshots > 0)
	{
		func_4488(param_00,"shots",self.trackingweaponshots);
		maps\mp\_matchdata::logweaponstat(param_00,"shots",self.trackingweaponshots);
	}

	if(self.trackingweaponkills > 0)
	{
		func_4488(param_00,"kills",self.trackingweaponkills);
		maps\mp\_matchdata::logweaponstat(param_00,"kills",self.trackingweaponkills);
	}

	if(self.trackingweaponhits > 0)
	{
		func_4488(param_00,"hits",self.trackingweaponhits);
		maps\mp\_matchdata::logweaponstat(param_00,"hits",self.trackingweaponhits);
	}

	if(self.trackingweaponheadshots > 0)
	{
		func_4488(param_00,"headShots",self.trackingweaponheadshots);
		maps\mp\_matchdata::logweaponstat(param_00,"headShots",self.trackingweaponheadshots);
	}

	if(self.trackingweapondeaths > 0)
	{
		func_4488(param_00,"deaths",self.trackingweapondeaths);
		maps\mp\_matchdata::logweaponstat(param_00,"deaths",self.trackingweapondeaths);
	}
}

//Function Number: 29
func_5BAE(param_00)
{
	if(self.trackingweaponshots > 0 && param_00 != "tactical")
	{
		func_4486(param_00,"shots",self.trackingweaponshots);
		maps\mp\_matchdata::func_4F13(param_00,"shots",self.trackingweaponshots);
	}

	if(self.trackingweaponkills > 0 && param_00 != "tactical")
	{
		func_4486(param_00,"kills",self.trackingweaponkills);
		maps\mp\_matchdata::func_4F13(param_00,"kills",self.trackingweaponkills);
	}

	if(self.trackingweaponhits > 0 && param_00 != "tactical")
	{
		func_4486(param_00,"hits",self.trackingweaponhits);
		maps\mp\_matchdata::func_4F13(param_00,"hits",self.trackingweaponhits);
	}

	if(self.trackingweaponheadshots > 0 && param_00 != "tactical")
	{
		func_4486(param_00,"headShots",self.trackingweaponheadshots);
		maps\mp\_matchdata::func_4F13(param_00,"headShots",self.trackingweaponheadshots);
	}

	if(self.trackingweapondeaths > 0)
	{
		func_4486(param_00,"deaths",self.trackingweapondeaths);
		maps\mp\_matchdata::func_4F13(param_00,"deaths",self.trackingweapondeaths);
	}
}

//Function Number: 30
func_876D()
{
	level waittill("game_ended");
	if(!maps\mp\_utility::func_50C1())
	{
	}

	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	foreach(var_07 in level.players)
	{
		var_05 = var_05 + var_07.timeplayed["total"];
	}

	incrementcounter("global_minutes",castint(var_05 / 60));
	if(maps\mp\_utility::func_4950() && !maps\mp\_utility::func_8C49())
	{
	}

	wait(0.05);
	foreach(var_07 in level.players)
	{
		var_00 = var_00 + var_07.kills;
		var_01 = var_01 + var_07.deaths;
		var_02 = var_02 + var_07.assists;
		var_03 = var_03 + var_07.headshots;
		var_04 = var_04 + var_07.suicides;
	}

	incrementcounter("global_headshots",var_03);
	incrementcounter("global_suicides",var_04);
	incrementcounter("global_games",1);
	if(!isdefined(level.assists_disabled))
	{
		incrementcounter("global_assists",var_02);
	}

	if(!isdefined(level.ishorde))
	{
		incrementcounter("global_kills",var_00);
	}

	if(!isdefined(level.ishorde))
	{
		incrementcounter("global_deaths",var_01);
	}
}