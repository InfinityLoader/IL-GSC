/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_rank.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 467 ms
 * Timestamp: 10/27/2023 2:42:01 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.xpscale = getxpscale();
	level.xpscalewithparty = getxpscalewithparty();
	level.xpeventinfo = [];
	level.ranktable = [];
	level.maxrank = int(tablelookup("mp/rankTable.csv",0,"maxrank",1));
	level.maxprestige = int(tablelookup("mp/rankIconTable.csv",0,"maxPrestige",1));
	level.maxrankformaxprestige = int(tablelookup("mp/rankTable.csv",0,"maxrankformaxprestige",1));
	if(!isdefined(level.xpgamemodescale))
	{
		level.xpgamemodescale = 1;
	}

	var_00 = 0;
	var_01 = tablelookup("mp/rankTable.csv",0,var_00,1);
	while(isdefined(var_01) && var_01 != "")
	{
		level.ranktable[var_00][1] = tablelookup("mp/rankTable.csv",0,var_00,1);
		level.ranktable[var_00][2] = tablelookup("mp/rankTable.csv",0,var_00,2);
		level.ranktable[var_00][3] = tablelookup("mp/rankTable.csv",0,var_00,3);
		level.ranktable[var_00][7] = tablelookup("mp/rankTable.csv",0,var_00,7);
		var_00++;
		var_01 = tablelookup("mp/rankTable.csv",0,var_00,1);
	}

	level.maxxp = int(level.ranktable[level.maxrank][7]);
	level.maxxponext = int(level.ranktable[level.maxrank][3]);
	maps\mp\gametypes\_misions::buildchallegeinfo();
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00) && var_00 maps\mp\_utility::rankingenabled())
		{
			var_01 = var_00 getprestigelevel();
			var_02 = var_00 maps\mp\gametypes\_persistence::statget("experience");
			if(var_02 < 0)
			{
				var_02 = 0;
			}

			var_03 = var_00 method_84FE() - var_02;
			var_04 = var_00 method_84FE();
		}
		else if(isai(var_00))
		{
			var_00 maps\mp\_utility::set_rank_xp_and_prestige_for_bot();
			var_02 = var_00.pers["rankxp"];
			var_01 = var_00.pers["prestige"];
			var_03 = 0;
			var_04 = var_02;
		}
		else
		{
			var_01 = 0;
			var_02 = 0;
			var_03 = 0;
			var_04 = var_02;
		}

		var_00.pers["rankxp"] = var_02;
		var_00.pers["redeemedxp"] = var_03;
		var_00.pers["prestige"] = var_01;
		if(!isdefined(var_00.pers["participation"]))
		{
			var_00.pers["participation"] = 0;
		}

		var_05 = function_02EC(var_00 gettotalxp(),var_01);
		var_00.pers["rank"] = var_05;
		if(isai(var_00))
		{
			var_00 maps\mp\_utility::set_rank_options_for_bot();
		}

		var_00.xpupdatetotal = 0;
		var_00.postgamepromotion = 0;
		var_00.explosivekills[0] = 0;
		var_00 setrank(var_05,var_01);
		var_00 thread processprestigemasteryonspawn(var_01,var_02);
		var_00 syncxpomnvars();
		if(var_00.clientid < level.maxlogclients)
		{
			setmatchdata("players",var_00.clientid,"Prestige",var_01);
			setmatchdata("players",var_00.clientid,"rankAtStart",maps\mp\_utility::clamptobyte(var_00.pers["rank"]));
		}

		if(!isdefined(var_00.pers["postGameChallenges"]))
		{
			var_00 setclientdvars("ui_challenge_1_ref","","ui_challenge_2_ref","","ui_challenge_3_ref","","ui_challenge_4_ref","","ui_challenge_5_ref","","ui_challenge_6_ref","","ui_challenge_7_ref","");
		}

		var_00 setclientdvar("ui_promotion",0);
		if(!isdefined(var_00.pers["summary"]))
		{
			var_00.pers["summary"] = [];
			var_00.pers["summary"]["xp"] = 0;
			var_00.pers["summary"]["score"] = 0;
			var_00.pers["summary"]["challenge"] = 0;
			var_00.pers["summary"]["match"] = 0;
			var_00.pers["summary"]["misc"] = 0;
			var_00.pers["summary"]["entitlementXP"] = 0;
			var_00.pers["summary"]["clanWarsXP"] = 0;
			var_00.pers["summary"]["matchStartXp"] = var_04;
		}

		if(getdvar("virtualLobbyActive") != "1")
		{
			var_00 setclientdvar("ui_opensummary",0);
			var_00 thread maps\mp\gametypes\_misions::updatechallenges();
		}

		var_00 thread onplayerspawned();
	}
}

//Function Number: 3
processprestigemasteryonspawn(param_00,param_01)
{
	self endon("disconnect");
	var_02 = processprestigemastery(param_00,param_01);
	if(isdefined(var_02))
	{
		self waittill("spawned_player");
		maps\mp\_utility::gameflagwait("prematch_done");
		thread maps\mp\gametypes\_hud_message::splashnotify(var_02);
	}
}

//Function Number: 4
onplayerspawned()
{
	self endon("disconnect");
	self waittill("spawned_player");
}

//Function Number: 5
getxpscale()
{
	var_00 = getdvarint("scr_xpscale");
	if(var_00 > 4 || var_00 < 0)
	{
		exitlevel(0);
	}

	return var_00;
}

//Function Number: 6
getxpscalewithparty()
{
	var_00 = getdvarint("scr_xpscalewithparty");
	if(var_00 > 4 || var_00 < 0)
	{
		exitlevel(0);
	}

	return var_00;
}

//Function Number: 7
isregisteredevent(param_00)
{
	if(isdefined(level.xpeventinfo[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
registerxpeventinfo(param_00,param_01,param_02,param_03)
{
	level.xpeventinfo[param_00]["value"] = param_01;
	level.xpeventinfo[param_00]["allowPlayerScore"] = 0;
	level.xpeventinfo[param_00]["playSplash"] = 0;
	if(isdefined(param_02) && param_02)
	{
		level.xpeventinfo[param_00]["allowPlayerScore"] = 1;
	}

	if(isdefined(param_03) && param_03)
	{
		level.xpeventinfo[param_00]["playSplash"] = 1;
	}
}

//Function Number: 9
allowplayerscore(param_00)
{
	return level.xpeventinfo[param_00]["allowPlayerScore"];
}

//Function Number: 10
shouldplaysplash(param_00)
{
	return level.xpeventinfo[param_00]["playSplash"];
}

//Function Number: 11
getscoreinfovalue(param_00)
{
	var_01 = "scr_" + level.gametype + "_score_" + param_00;
	if(getdvar(var_01) != "")
	{
		return getdvarint(var_01);
	}

	return level.xpeventinfo[param_00]["value"];
}

//Function Number: 12
getrankinfominxp(param_00)
{
	if(param_00 > level.maxrank)
	{
		var_01 = param_00 - level.maxrank;
		return level.maxxp + var_01 - 1 * level.maxxponext;
	}

	return int(level.ranktable[var_01][2]);
}

//Function Number: 13
getrankinfoxpamt(param_00)
{
	if(param_00 > level.maxrank)
	{
		return level.maxxponext;
	}

	return int(level.ranktable[param_00][3]);
}

//Function Number: 14
getrankinfomaxxp(param_00)
{
	if(param_00 > level.maxrank)
	{
		var_01 = param_00 - level.maxrank;
		return level.maxxp + var_01 * level.maxxponext;
	}

	return int(level.ranktable[var_01][7]);
}

//Function Number: 15
getrankinfofull(param_00)
{
	if(param_00 > level.maxrank)
	{
		return &"RANK_PARAGON_FULL";
	}

	return tablelookupistring("mp/rankTable.csv",0,param_00,16);
}

//Function Number: 16
getrankinfolevel(param_00)
{
	if(param_00 > level.maxrank)
	{
		return param_00 + 1;
	}

	return int(tablelookup("mp/rankTable.csv",0,param_00,13));
}

//Function Number: 17
awardgameevent(param_00,param_01,param_02,param_03,param_04)
{
	if(maps\mp\_utility::invirtuallobby())
	{
		return;
	}

	if(shouldplaysplash(param_00))
	{
		param_01 thread maps\mp\gametypes\_hud_message::medalsplashnotify(param_00);
	}

	param_01 giverankxp(param_00,undefined,param_02,param_04,undefined,param_03);
	if(allowplayerscore(param_00))
	{
		param_01 maps\mp\gametypes\_gamescores::giveplayerscore(param_00,param_01,param_03);
	}
}

//Function Number: 18
giverankxp(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("disconnect");
	if(isdefined(self.owner) && !isbot(self))
	{
		self.owner giverankxp(param_00,param_01,param_02,param_03,param_04,param_05);
		return;
	}

	if(isai(self))
	{
		return;
	}

	if(!isplayer(self))
	{
		return;
	}

	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(level.teambased && !level.teamcount["allies"] || !level.teamcount["axis"] && param_00 != "win")
	{
		return;
	}

	if(!level.teambased && level.teamcount["allies"] + level.teamcount["axis"] < 2 && param_00 != "win")
	{
		return;
	}

	if(isdefined(level.disableranking) && level.disableranking)
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = getscoreinfovalue(param_00);
	}

	if(param_01 == 0)
	{
		return;
	}

	if(param_01 > 0 && !isdefined(self.lootplaytimevalidated))
	{
		self.lootplaytimevalidated = 1;
		lootservicevalidateplaytime(self.xuid);
	}

	var_06 = param_01;
	var_07 = 0;
	switch(param_00)
	{
		case "loss":
		case "win":
		case "tie":
		case "challenge":
			break;

		default:
			break;
	}
}

//Function Number: 19
updaterank(param_00)
{
	var_01 = getrank();
	if(var_01 == self.pers["rank"])
	{
		return 0;
	}

	var_02 = self.pers["rank"];
	self.pers["rank"] = var_01;
	self setrank(var_01);
	return 1;
}

//Function Number: 20
updaterankannouncehud()
{
	self endon("disconnect");
	self notify("update_rank");
	self endon("update_rank");
	var_00 = self.pers["team"];
	if(!isdefined(var_00))
	{
		return;
	}

	if(!maps\mp\_utility::levelflag("game_over"))
	{
		level common_scripts\utility::waittill_notify_or_timeout("game_over",0.25);
	}

	var_01 = self.pers["rank"];
	var_02 = self.pers["prestige"];
	if(var_01 + 1 % 50 == 0)
	{
		var_03 = var_01 + 1;
		maps\mp\gametypes\_misions::processchallenge("ch_" + var_03 + "_paragon");
	}

	thread maps\mp\gametypes\_hud_message::rankupsplashnotify("ranked_up",var_01,var_02);
	if(var_01 <= level.maxrank)
	{
		var_04 = level.ranktable[var_01][1];
		var_05 = int(var_04[var_04.size - 1]);
		if(var_05 > 1)
		{
			return;
		}
	}

	var_06 = getrankinfofull(var_01);
	for(var_07 = 0;var_07 < level.players.size;var_07++)
	{
		var_08 = level.players[var_07];
		var_09 = var_08.pers["team"];
		if(isdefined(var_09) && var_08 != self)
		{
			if(var_09 == var_00)
			{
				if(var_01 > level.maxrank)
				{
					var_08 iprintln(&"RANK_PLAYER_WAS_PROMOTED_N",self,var_06,var_01 + 1);
					continue;
				}

				var_08 iprintln(&"RANK_PLAYER_WAS_PROMOTED",self,var_06);
			}
		}
	}
}

//Function Number: 21
xppointspopup(param_00,param_01)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	if(param_01 == 0)
	{
		return;
	}

	self notify("xpPointsPopup");
	self endon("xpPointsPopup");
	var_02 = tablelookuprownum("mp/xp_event_table.csv",0,param_00);
	if(getdvarint("scr_lua_score"))
	{
		if(var_02 >= 0)
		{
			self method_8561(&"score_event",2,var_02,param_01);
			self method_8579(&"score_event",2,var_02,param_01);
		}

		return;
	}

	self.xpupdatetotal = self.xpupdatetotal + param_01;
	self setclientomnvar("ui_points_popup",self.xpupdatetotal);
	if(!isdefined(var_02) || isdefined(var_02) && var_02 == -1)
	{
	}
	else
	{
		self setclientomnvar("ui_points_popup_event",var_02);
	}

	wait(1);
	self.xpupdatetotal = 0;
}

//Function Number: 22
getrank()
{
	var_00 = gettotalxp();
	var_01 = self.pers["rank"];
	var_02 = getprestigelevel();
	if(var_00 < getrankinfominxp(var_01) + getrankinfoxpamt(var_01))
	{
		return var_01;
	}

	return function_02EC(var_00,var_02);
}

//Function Number: 23
getprestigelevel()
{
	if(isai(self) && isdefined(self.pers["prestige_fake"]))
	{
		return self.pers["prestige_fake"];
	}

	return maps\mp\gametypes\_persistence::statget("prestige");
}

//Function Number: 24
getrankxp()
{
	if(isdefined(self.pers["rankxp"]))
	{
		return self.pers["rankxp"];
	}

	return 0;
}

//Function Number: 25
getredeemedxp()
{
	if(isdefined(self.pers["redeemedxp"]))
	{
		return self.pers["redeemedxp"];
	}

	return 0;
}

//Function Number: 26
gettotalxp()
{
	return getrankxp() + getredeemedxp();
}

//Function Number: 27
incrankxp(param_00)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	var_01 = getrankxp();
	var_02 = self.pers["prestige"];
	var_03 = level.maxrank;
	if(var_02 >= level.maxprestige)
	{
		var_03 = level.maxrankformaxprestige;
	}

	var_04 = getrankinfomaxxp(var_03) - getredeemedxp();
	var_05 = int(min(var_01,var_04)) + param_00;
	if(var_05 > var_04)
	{
		var_05 = var_04;
	}

	self.pers["rankxp"] = var_05;
	var_06 = processprestigemastery(var_02,var_05);
	if(isdefined(var_06))
	{
		thread maps\mp\gametypes\_hud_message::splashnotify(var_06);
	}
}

//Function Number: 28
processprestigemastery(param_00,param_01)
{
	var_02 = getrankinfomaxxp(level.maxrank) - getredeemedxp();
	var_03 = getrankinfomaxxp(level.maxrankformaxprestige - 1) - getredeemedxp();
	if(param_00 == level.maxprestige && param_01 >= var_03 && !isdefined(self.pers["prestigeMaster2"]))
	{
		var_04 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"challengeState","ch_prestige_max");
		var_05 = var_04 >= 3;
		self.pers["prestigeMaster2"] = self method_853E();
		if(isdefined(self.pers["prestigeMaster2"]) && !var_05)
		{
			return "prestigeMaster2";
		}
	}

	if(param_00 == level.maxprestige && param_01 >= var_02 && !isdefined(self.pers["prestigeMaster"]))
	{
		var_04 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"challengeState","ch_prestige_max");
		var_05 = var_04 >= 2;
		self.pers["prestigeMaster"] = self method_853E();
		if(isdefined(self.pers["prestigeMaster"]) && !var_05)
		{
			return "prestigeMaster";
		}
	}

	return undefined;
}

//Function Number: 29
syncxpomnvars()
{
	var_00 = self.pers["rankxp"];
	var_01 = self.pers["rank"];
	var_02 = self.pers["prestige"];
	var_03 = getrankinfominxp(var_01);
	var_04 = getrankinfomaxxp(var_01);
	var_05 = 0;
	if(var_04 - var_03 > 0)
	{
		var_05 = var_00 - var_03 / var_04 - var_03;
		var_05 = clamp(var_05,0,1);
	}

	if(var_02 == level.maxprestige && var_01 == level.maxrankformaxprestige)
	{
		var_05 = 1;
	}

	self setclientomnvar("ui_player_xp_rank",var_01);
	self setclientomnvar("ui_player_xp_pct",var_05);
	self setclientomnvar("ui_player_xp_prestige",var_02);
}

//Function Number: 30
syncxpstat()
{
	var_00 = getrankxp();
	maps\mp\gametypes\_persistence::statset("experience",var_00);
}