/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_persistance.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 388 ms
 * Timestamp: 10/27/2023 1:42:24 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.persistentdatainfo = [];
	maps\mp\gametypes\_class::init();
	maps\mp\gametypes\_missions::init();
	maps\mp\gametypes\_playercards::init();
	maps\mp\gametypes\_rank::init();
	if(getdvarint("virtualLobbyActive",0) > 0)
	{
		return;
	}

	level thread updatebufferedstats();
	level thread uploadglobalstatcounters();
}

//Function Number: 2
initbufferedstats()
{
	self.bufferedstats = [];
	if(maps\mp\_utility::rankingenabled())
	{
		self.bufferedstats["totalShots"] = self getrankedplayerdata("totalShots");
		self.bufferedstats["accuracy"] = self getrankedplayerdata("accuracy");
		self.bufferedstats["misses"] = self getrankedplayerdata("misses");
		self.bufferedstats["hits"] = self getrankedplayerdata("hits");
		self.bufferedstats["timePlayedAllies"] = self getrankedplayerdata("timePlayedAllies");
		self.bufferedstats["timePlayedOpfor"] = self getrankedplayerdata("timePlayedOpfor");
		self.bufferedstats["timePlayedOther"] = self getrankedplayerdata("timePlayedOther");
		self.bufferedstats["timePlayedTotal"] = self getrankedplayerdata("timePlayedTotal");
	}

	self.bufferedchildstats = [];
	self.bufferedchildstats["round"] = [];
	self.bufferedchildstats["round"]["timePlayed"] = self getcommonplayerdata("round","timePlayed");
}

//Function Number: 3
statget(param_00)
{
	return self getrankedplayerdata(param_00);
}

//Function Number: 4
statset(param_00,param_01)
{
	if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame())
	{
		return;
	}

	self setrankedplayerdata(param_00,param_01);
}

//Function Number: 5
statadd(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame())
	{
		return;
	}

	if(isdefined(param_02))
	{
		var_03 = self getrankedplayerdata(param_00,param_02);
		self setrankedplayerdata(param_00,param_02,param_01 + var_03);
		return;
	}

	var_03 = self getrankedplayerdata(param_01);
	self setrankedplayerdata(param_00,param_01 + var_03);
}

//Function Number: 6
statgetchild(param_00,param_01)
{
	if(param_00 == "round")
	{
		return self getcommonplayerdata(param_00,param_01);
	}

	return self getrankedplayerdata(param_00,param_01);
}

//Function Number: 7
statsetchild(param_00,param_01,param_02)
{
	if(isagent(self))
	{
		return;
	}

	if(maps\mp\_utility::invirtuallobby())
	{
		return;
	}

	if(param_00 == "round")
	{
		self setcommonplayerdata(param_00,param_01,param_02);
		return;
	}

	if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame())
	{
		return;
	}

	self setrankedplayerdata(param_00,param_01,param_02);
}

//Function Number: 8
stataddchild(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::practiceroundgame())
	{
		return;
	}

	var_03 = self getrankedplayerdata(param_00,param_01);
	self setrankedplayerdata(param_00,param_01,var_03 + param_02);
}

//Function Number: 9
statgetchildbuffered(param_00,param_01)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return 0;
	}

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
	if(!maps\mp\_utility::rankingenabled())
	{
		return 0;
	}

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
	wait(0.15);
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

		wait(2);
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
	var_00 = maps\mp\_utility::rankingenabled() && !maps\mp\_utility::practiceroundgame();
	if(var_00)
	{
		foreach(var_03, var_02 in self.bufferedstats)
		{
			self setrankedplayerdata(var_03,var_02);
		}
	}

	foreach(var_03, var_02 in self.bufferedchildstats)
	{
		foreach(var_07, var_06 in var_02)
		{
			if(var_03 == "round")
			{
				self setcommonplayerdata(var_03,var_07,var_06);
				continue;
			}

			if(var_00)
			{
				self setrankedplayerdata(var_03,var_07,var_06);
			}
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

	if(isdefined(level.disableweaponstats) && level.disableweaponstats)
	{
		return;
	}

	if(maps\mp\_utility::rankingenabled() && !maps\mp\_utility::practiceroundgame())
	{
		var_03 = self getrankedplayerdata("weaponStats",param_00,param_01);
		self setrankedplayerdata("weaponStats",param_00,param_01,var_03 + param_02);
	}
}

//Function Number: 20
incrementattachmentstat(param_00,param_01,param_02)
{
	if(maps\mp\_utility::rankingenabled() && !maps\mp\_utility::practiceroundgame())
	{
		var_03 = self getrankedplayerdata("attachmentsStats",param_00,param_01);
		self setrankedplayerdata("attachmentsStats",param_00,param_01,var_03 + param_02);
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

	var_01 = maps\mp\_utility::getweaponnametokens(var_00);
	if(var_01[0] == "iw5")
	{
		var_01[0] = var_01[0] + "_" + var_01[1];
	}

	if(var_01[0] == "alt")
	{
		foreach(var_03 in var_01)
		{
			if(var_03 == "gl" || var_03 == "gp25" || var_03 == "m320")
			{
				var_01[0] = "gl";
				break;
			}

			if(var_03 == "shotgun")
			{
				var_01[0] = "shotgun";
				break;
			}
		}

		if(var_01[0] == "alt")
		{
			var_01[0] = var_01[1] + "_" + var_01[2];
		}
	}

	if(var_01[0] == "gl" || var_01[0] == "shotgun")
	{
		if(self.trackingweaponshots > 0)
		{
			incrementattachmentstat(var_01[0],"shots",self.trackingweaponshots);
		}

		if(self.trackingweaponkills > 0)
		{
			incrementattachmentstat(var_01[0],"kills",self.trackingweaponkills);
		}

		if(self.trackingweaponhits > 0)
		{
			incrementattachmentstat(var_01[0],"hits",self.trackingweaponhits);
		}

		if(self.trackingweaponheadshots > 0)
		{
			incrementattachmentstat(var_01[0],"headShots",self.trackingweaponheadshots);
		}

		if(self.trackingweapondeaths > 0)
		{
			incrementattachmentstat(var_01[0],"deaths",self.trackingweapondeaths);
		}

		if(self.trackingweaponhipfirekills > 0)
		{
			incrementattachmentstat(var_01[0],"hipfirekills",self.trackingweaponhipfirekills);
		}

		if(self.trackingweaponusetime > 0)
		{
			incrementattachmentstat(var_01[0],"timeInUse",self.trackingweaponusetime);
		}

		self.trackingweaponname = "none";
		self.trackingweaponshots = 0;
		self.trackingweaponkills = 0;
		self.trackingweaponhits = 0;
		self.trackingweaponheadshots = 0;
		self.trackingweapondeaths = 0;
		self.trackingweaponhipfirekills = 0;
		self.trackingweaponusetime = 0;
		return;
	}

	if(!maps\mp\_utility::iscacprimaryweapon(var_01[0]) && !maps\mp\_utility::iscacsecondaryweapon(var_01[0]))
	{
		return;
	}

	if(self.trackingweaponshots > 0)
	{
		incrementweaponstat(var_01[0],"shots",self.trackingweaponshots);
		maps\mp\_matchdata::logweaponstat(var_01[0],"shots",self.trackingweaponshots);
	}

	if(self.trackingweaponkills > 0)
	{
		incrementweaponstat(var_01[0],"kills",self.trackingweaponkills);
		maps\mp\_matchdata::logweaponstat(var_01[0],"kills",self.trackingweaponkills);
	}

	if(self.trackingweaponhits > 0)
	{
		incrementweaponstat(var_01[0],"hits",self.trackingweaponhits);
		maps\mp\_matchdata::logweaponstat(var_01[0],"hits",self.trackingweaponhits);
	}

	if(self.trackingweaponheadshots > 0)
	{
		incrementweaponstat(var_01[0],"headShots",self.trackingweaponheadshots);
		maps\mp\_matchdata::logweaponstat(var_01[0],"headShots",self.trackingweaponheadshots);
	}

	if(self.trackingweapondeaths > 0)
	{
		incrementweaponstat(var_01[0],"deaths",self.trackingweapondeaths);
		maps\mp\_matchdata::logweaponstat(var_01[0],"deaths",self.trackingweapondeaths);
	}

	if(self.trackingweaponhipfirekills > 0)
	{
		incrementweaponstat(var_01[0],"hipfirekills",self.trackingweaponhipfirekills);
		maps\mp\_matchdata::logweaponstat(var_01[0],"hipfirekills",self.trackingweaponhipfirekills);
	}

	if(self.trackingweaponusetime > 0)
	{
		incrementweaponstat(var_01[0],"timeInUse",self.trackingweaponusetime);
		maps\mp\_matchdata::logweaponstat(var_01[0],"timeInUse",self.trackingweaponusetime);
	}

	var_05 = getweaponattachments(var_00);
	foreach(var_07 in var_05)
	{
		var_08 = maps\mp\_utility::attachmentmap_tobase(var_07);
		if(var_08 == "gl" || var_08 == "shotgun")
		{
			continue;
		}

		if(self.trackingweaponshots > 0)
		{
			if(var_08 != "tactical")
			{
				incrementattachmentstat(var_08,"shots",self.trackingweaponshots);
			}
		}

		if(self.trackingweaponkills > 0)
		{
			if(var_08 != "tactical")
			{
				incrementattachmentstat(var_08,"kills",self.trackingweaponkills);
			}
		}

		if(self.trackingweaponhits > 0)
		{
			if(var_08 != "tactical")
			{
				incrementattachmentstat(var_08,"hits",self.trackingweaponhits);
			}
		}

		if(self.trackingweaponheadshots > 0)
		{
			if(var_08 != "tactical")
			{
				incrementattachmentstat(var_08,"headShots",self.trackingweaponheadshots);
			}
		}

		if(self.trackingweaponhipfirekills > 0)
		{
			if(var_08 != "tactical")
			{
				incrementattachmentstat(var_08,"hipfirekills",self.trackingweaponhipfirekills);
			}
		}

		if(self.trackingweaponusetime > 0)
		{
			if(var_08 != "tactical")
			{
				incrementattachmentstat(var_08,"timeInUse",self.trackingweaponusetime);
			}
		}

		if(self.trackingweapondeaths > 0)
		{
			incrementattachmentstat(var_08,"deaths",self.trackingweapondeaths);
		}
	}

	self.trackingweaponname = "none";
	self.trackingweaponshots = 0;
	self.trackingweaponkills = 0;
	self.trackingweaponhits = 0;
	self.trackingweaponheadshots = 0;
	self.trackingweapondeaths = 0;
	self.trackingweaponhipfirekills = 0;
	self.trackingweaponusetime = 0;
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

	wait(0.05);
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