/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_persistance.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 318 ms
 * Timestamp: 10/27/2023 2:12:45 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.persistentdatainfo = [];
	maps\mp\gametypes\_class::init();
	maps\mp\gametypes\_rank::init();
	maps\mp\gametypes\_missions::init();
	maps\mp\gametypes\_playercards::init();
	level thread updatebufferedstats();
	level thread uploadglobalstatcounters();
}

//Function Number: 2
initbufferedstats()
{
	self.bufferedstats = [];
	self.bufferedstats["totalShots"] = self getplayerdata("totalShots");
	self.bufferedstats["accuracy"] = self getplayerdata("accuracy");
	self.bufferedstats["misses"] = self getplayerdata("misses");
	self.bufferedstats["hits"] = self getplayerdata("hits");
	self.bufferedstats["timePlayedAllies"] = self getplayerdata("timePlayedAllies");
	self.bufferedstats["timePlayedOpfor"] = self getplayerdata("timePlayedOpfor");
	self.bufferedstats["timePlayedOther"] = self getplayerdata("timePlayedOther");
	self.bufferedstats["timePlayedTotal"] = self getplayerdata("timePlayedTotal");
	self.bufferedchildstats = [];
	self.bufferedchildstats["round"] = [];
	self.bufferedchildstats["round"]["timePlayed"] = self getplayerdata("round","timePlayed");
	self.bufferedchildstats["xpMultiplierTimePlayed"] = [];
	self.bufferedchildstats["xpMultiplierTimePlayed"][0] = self getplayerdata("xpMultiplierTimePlayed",0);
	self.bufferedchildstats["xpMultiplierTimePlayed"][1] = self getplayerdata("xpMultiplierTimePlayed",1);
	self.bufferedchildstats["xpMultiplierTimePlayed"][2] = self getplayerdata("xpMultiplierTimePlayed",2);
	self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"] = [];
	self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0] = self getplayerdata("xpMaxMultiplierTimePlayed",0);
	self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1] = self getplayerdata("xpMaxMultiplierTimePlayed",1);
	self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2] = self getplayerdata("xpMaxMultiplierTimePlayed",2);
	self.bufferedchildstats["challengeXPMultiplierTimePlayed"] = [];
	self.bufferedchildstats["challengeXPMultiplierTimePlayed"][0] = self getplayerdata("challengeXPMultiplierTimePlayed",0);
	self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"] = [];
	self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0] = self getplayerdata("challengeXPMaxMultiplierTimePlayed",0);
	self.bufferedchildstats["weaponXPMultiplierTimePlayed"] = [];
	self.bufferedchildstats["weaponXPMultiplierTimePlayed"][0] = self getplayerdata("weaponXPMultiplierTimePlayed",0);
	self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"] = [];
	self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0] = self getplayerdata("weaponXPMaxMultiplierTimePlayed",0);
	self.bufferedstats["prestigeDoubleXp"] = self getplayerdata("prestigeDoubleXp");
	self.bufferedstats["prestigeDoubleXpTimePlayed"] = self getplayerdata("prestigeDoubleXpTimePlayed");
	self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"] = self getplayerdata("prestigeDoubleXpMaxTimePlayed");
	self.bufferedstats["prestigeDoubleWeaponXp"] = self getplayerdata("prestigeDoubleWeaponXp");
	self.bufferedstats["prestigeDoubleWeaponXpTimePlayed"] = self getplayerdata("prestigeDoubleWeaponXpTimePlayed");
	self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] = self getplayerdata("prestigeDoubleWeaponXpMaxTimePlayed");
}

//Function Number: 3
statget(param_00)
{
	return self getplayerdata(param_00);
}

//Function Number: 4
statset(param_00,param_01)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	self setplayerdata(param_00,param_01);
}

//Function Number: 5
statadd(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(isdefined(param_02))
	{
		var_03 = self getplayerdata(param_00,param_02);
		self setplayerdata(param_00,param_02,param_01 + var_03);
		return;
	}

	var_03 = self getplayerdata(param_01);
	self setplayerdata(param_00,param_01 + var_03);
}

//Function Number: 6
statgetchild(param_00,param_01)
{
	return self getplayerdata(param_00,param_01);
}

//Function Number: 7
statsetchild(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	self setplayerdata(param_00,param_01,param_02);
}

//Function Number: 8
stataddchild(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	var_03 = self getplayerdata(param_00,param_01);
	self setplayerdata(param_00,param_01,var_03 + param_02);
}

//Function Number: 9
statgetchildbuffered(param_00,param_01)
{
	return self.bufferedchildstats[param_00][param_01];
}

//Function Number: 10
statsetchildbuffered(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	self.bufferedchildstats[param_00][param_01] = param_02;
}

//Function Number: 11
stataddchildbuffered(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	var_03 = statgetchildbuffered(param_00,param_01);
	statsetchildbuffered(param_00,param_01,var_03 + param_02);
}

//Function Number: 12
stataddbufferedwithmax(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
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

	statsetbuffered(param_00,var_03);
}

//Function Number: 13
stataddchildbufferedwithmax(param_00,param_01,param_02,param_03)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	var_04 = statgetchildbuffered(param_00,param_01) + param_02;
	if(var_04 > param_03)
	{
		var_04 = param_03;
	}

	if(var_04 < statgetchildbuffered(param_00,param_01))
	{
		var_04 = param_03;
	}

	statsetchildbuffered(param_00,param_01,var_04);
}

//Function Number: 14
statgetbuffered(param_00)
{
	return self.bufferedstats[param_00];
}

//Function Number: 15
statsetbuffered(param_00,param_01)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	self.bufferedstats[param_00] = param_01;
}

//Function Number: 16
stataddbuffered(param_00,param_01)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	var_02 = statgetbuffered(param_00);
	statsetbuffered(param_00,var_02 + param_01);
}

//Function Number: 17
updatebufferedstats()
{
	wait 0.15;
	var_00 = 0;
	while(!level.gameended)
	{
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		var_00++;
		if(var_00 >= level.players.size)
		{
			var_00 = 0;
		}

		if(isdefined(level.players[var_00]))
		{
			level.players[var_00] writebufferedstats();
			level.players[var_00] updateweaponbufferedstats();
		}

		wait 2;
	}

	foreach(var_02 in level.players)
	{
		var_02 writebufferedstats();
		var_02 updateweaponbufferedstats();
	}
}

//Function Number: 18
writebufferedstats()
{
	foreach(var_02, var_01 in self.bufferedstats)
	{
		self setplayerdata(var_02,var_01);
	}

	foreach(var_02, var_01 in self.bufferedchildstats)
	{
		foreach(var_06, var_05 in var_01)
		{
			self setplayerdata(var_02,var_06,var_05);
		}
	}
}

//Function Number: 19
incrementweaponstat(param_00,param_01,param_02)
{
	if(maps\mp\_utility::iskillstreakweapon(param_00))
	{
		return;
	}

	if(maps\mp\_utility::rankingenabled())
	{
		var_03 = self getplayerdata("weaponStats",param_00,param_01);
		self setplayerdata("weaponStats",param_00,param_01,var_03 + param_02);
	}
}

//Function Number: 20
incrementattachmentstat(param_00,param_01,param_02)
{
	if(maps\mp\_utility::rankingenabled())
	{
		var_03 = self getplayerdata("attachmentsStats",param_00,param_01);
		self setplayerdata("attachmentsStats",param_00,param_01,var_03 + param_02);
	}
}

//Function Number: 21
updateweaponbufferedstats()
{
	if(!isdefined(self.trackingweaponname))
	{
		return;
	}

	if(self.trackingweaponname == "" || self.trackingweaponname == "none")
	{
		return;
	}

	var_00 = self.trackingweaponname;
	if(maps\mp\_utility::iskillstreakweapon(var_00) || maps\mp\_utility::isenvironmentweapon(var_00))
	{
		return;
	}

	var_01 = strtok(var_00,"_");
	if(var_01[0] == "iw5")
	{
	}

	if(var_7B[0] == "alt")
	{
		foreach(var_03 in var_7B)
		{
			if(var_03 == "gl" || var_03 == "gp25" || var_03 == "m320")
			{
				var_7B[0] = "gl";
				break;
			}

			if(var_03 == "shotgun")
			{
				var_7B[0] = "shotgun";
				break;
			}
		}

		if(var_7B[0] == "alt")
		{
			var_7B[0] = var_7B[1] + "_" + var_7B[2];
		}
	}

	if(var_7B[0] == "gl" || var_7B[0] == "shotgun")
	{
		if(self.trackingweaponshots > 0)
		{
			incrementattachmentstat(var_7B[0],"shots",self.trackingweaponshots);
			maps\mp\_matchdata::logattachmentstat(var_7B[0],"shots",self.trackingweaponshots);
		}

		if(self.trackingweaponkills > 0)
		{
			incrementattachmentstat(var_7B[0],"kills",self.trackingweaponkills);
			maps\mp\_matchdata::logattachmentstat(var_7B[0],"kills",self.trackingweaponkills);
		}

		if(self.trackingweaponhits > 0)
		{
			incrementattachmentstat(var_7B[0],"hits",self.trackingweaponhits);
			maps\mp\_matchdata::logattachmentstat(var_7B[0],"hits",self.trackingweaponhits);
		}

		if(self.trackingweaponheadshots > 0)
		{
			incrementattachmentstat(var_7B[0],"headShots",self.trackingweaponheadshots);
			maps\mp\_matchdata::logattachmentstat(var_7B[0],"headShots",self.trackingweaponheadshots);
		}

		if(self.trackingweapondeaths > 0)
		{
			incrementattachmentstat(var_7B[0],"deaths",self.trackingweapondeaths);
			maps\mp\_matchdata::logattachmentstat(var_7B[0],"deaths",self.trackingweapondeaths);
		}

		self.trackingweaponname = "none";
		self.trackingweaponshots = 0;
		self.trackingweaponkills = 0;
		self.trackingweaponhits = 0;
		self.trackingweaponheadshots = 0;
		self.trackingweapondeaths = 0;
		return;
	}

	if(!maps\mp\_utility::iscacprimaryweapon(var_7B[0]) && !maps\mp\_utility::iscacsecondaryweapon(var_7B[0]))
	{
		return;
	}

	if(self.trackingweaponshots > 0)
	{
		incrementweaponstat(var_7B[0],"shots",self.trackingweaponshots);
		maps\mp\_matchdata::logweaponstat(var_7B[0],"shots",self.trackingweaponshots);
	}

	if(self.trackingweaponkills > 0)
	{
		incrementweaponstat(var_7B[0],"kills",self.trackingweaponkills);
		maps\mp\_matchdata::logweaponstat(var_7B[0],"kills",self.trackingweaponkills);
	}

	if(self.trackingweaponhits > 0)
	{
		incrementweaponstat(var_7B[0],"hits",self.trackingweaponhits);
		maps\mp\_matchdata::logweaponstat(var_7B[0],"hits",self.trackingweaponhits);
	}

	if(self.trackingweaponheadshots > 0)
	{
		incrementweaponstat(var_7B[0],"headShots",self.trackingweaponheadshots);
		maps\mp\_matchdata::logweaponstat(var_7B[0],"headShots",self.trackingweaponheadshots);
	}

	if(self.trackingweapondeaths > 0)
	{
		incrementweaponstat(var_7B[0],"deaths",self.trackingweapondeaths);
		maps\mp\_matchdata::logweaponstat(var_7B[0],"deaths",self.trackingweapondeaths);
	}

	var_7B = strtok(var_01,"_");
	if(var_7B[0] != "none")
	{
		for(var_05 = 0;var_05 < var_7B.size;var_05++ = var_7B[0])
		{
			if(var_7B[var_05] == "mp" || var_7B[var_05] == "scope1" || var_7B[var_05] == "scope2" || var_7B[var_05] == "scope3" || var_7B[var_05] == "scope4" || var_7B[var_05] == "scope5" || var_7B[var_05] == "scope6" || var_7B[var_05] == "scope7" || var_7B[var_05] == "scope8" || var_7B[var_05] == "scope9" || var_7B[var_05] == "scope10")
			{
				continue;
			}

			if(issubstr(var_7B[var_05],"camo"))
			{
				continue;
			}

			if(issubstr(var_7B[var_05],"scope") && !issubstr(var_7B[var_05],"vz"))
			{
				continue;
			}

			if(var_7B[var_05] == "alt")
			{
				var_05 = var_05 + 2;
				continue;
			}

			if(var_7B[var_05] == "iw5")
			{
				var_05 = var_05 + 1;
				continue;
			}

			var_7B[var_05] = maps\mp\_utility::validateattachment(var_7B[var_05]);
			if(var_7B[var_05] == "gl" || var_7B[var_05] == "shotgun")
			{
				continue;
			}

			if(issubstr(var_7B[var_05],"scope") && issubstr(var_7B[var_05],"vz"))
			{
				var_7B[var_05] = "vzscope";
			}

			if(var_05 == 0 && var_7B[var_05] != "iw5" && var_7B[var_05] != "alt")
			{
				continue;
			}

			if(self.trackingweaponshots > 0)
			{
				incrementattachmentstat(var_7B[var_05],"shots",self.trackingweaponshots);
				maps\mp\_matchdata::logattachmentstat(var_7B[var_05],"shots",self.trackingweaponshots);
			}

			if(self.trackingweaponkills > 0)
			{
				incrementattachmentstat(var_7B[var_05],"kills",self.trackingweaponkills);
				maps\mp\_matchdata::logattachmentstat(var_7B[var_05],"kills",self.trackingweaponkills);
			}

			if(self.trackingweaponhits > 0)
			{
				incrementattachmentstat(var_7B[var_05],"hits",self.trackingweaponhits);
				maps\mp\_matchdata::logattachmentstat(var_7B[var_05],"hits",self.trackingweaponhits);
			}

			if(self.trackingweaponheadshots > 0)
			{
				incrementattachmentstat(var_7B[var_05],"headShots",self.trackingweaponheadshots);
				maps\mp\_matchdata::logattachmentstat(var_7B[var_05],"headShots",self.trackingweaponheadshots);
			}

			if(self.trackingweapondeaths > 0)
			{
				incrementattachmentstat(var_7B[var_05],"deaths",self.trackingweapondeaths);
				maps\mp\_matchdata::logattachmentstat(var_7B[var_05],"deaths",self.trackingweapondeaths);
			}
		}
	}

	self.trackingweaponname = "none";
	self.trackingweaponshots = 0;
	self.trackingweaponkills = 0;
	self.trackingweaponhits = 0;
	self.trackingweaponheadshots = 0;
	self.trackingweapondeaths = 0;
}

//Function Number: 22
uploadglobalstatcounters()
{
	level waittill("game_ended");
	if(!maps\mp\_utility::matchmakinggame())
	{
		return;
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

	incrementcounter("global_minutes",int(var_05 / 60));
	if(!maps\mp\_utility::waslastround())
	{
		return;
	}

	wait 0.05;
	foreach(var_07 in level.players)
	{
		var_00 = var_00 + var_07.kills;
		var_01 = var_01 + var_07.deaths;
		var_02 = var_02 + var_07.assists;
		var_03 = var_03 + var_07.headshots;
		var_04 = var_04 + var_07.suicides;
	}

	incrementcounter("global_kills",var_00);
	incrementcounter("global_deaths",var_01);
	incrementcounter("global_assists",var_02);
	incrementcounter("global_headshots",var_03);
	incrementcounter("global_suicides",var_04);
	incrementcounter("global_games",1);
}