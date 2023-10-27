/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_scoreboard.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 59 ms
 * Timestamp: 10/27/2023 2:40:33 AM
*******************************************************************/

//Function Number: 1
processlobbyscoreboards()
{
	foreach(var_01 in level.placement["all"])
	{
		var_01 setplayerscoreboardinfo();
	}

	if(level.multiteambased)
	{
		buildscoreboardtype("multiteam");
		foreach(var_01 in level.players)
		{
			var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","scoreboardType","multiteam");
		}

		setclientmatchdata("alliesScore",-1);
		setclientmatchdata("axisScore",-1);
		setclientmatchdata("alliesFaction","none");
		setclientmatchdata("axisFaction","none");
	}
	else if(level.teambased)
	{
		var_05 = getteamscore("allies");
		var_06 = getteamscore("axis");
		if(var_05 == var_06)
		{
			var_07 = "tied";
		}
		else if(var_06 > var_07)
		{
			var_07 = "allies";
		}
		else
		{
			var_07 = "axis";
		}

		setclientmatchdata("alliesScore",var_05);
		setclientmatchdata("axisScore",var_06);
		setclientmatchdata("alliesFaction",game["allies"]);
		setclientmatchdata("axisFaction",game["axis"]);
		if(var_07 == "tied")
		{
			buildscoreboardtype("allies");
			buildscoreboardtype("axis");
			foreach(var_01 in level.players)
			{
				var_09 = var_01.pers["team"];
				if(!isdefined(var_09))
				{
					continue;
				}

				if(var_09 == "spectator")
				{
					var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","scoreboardType","allies");
					continue;
				}

				var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","scoreboardType",var_09);
			}
		}
		else
		{
			buildscoreboardtype(var_07);
			foreach(var_01 in level.players)
			{
				var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","scoreboardType",var_07);
			}
		}
	}
	else
	{
		buildscoreboardtype("neutral");
		foreach(var_01 in level.players)
		{
			var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","scoreboardType","neutral");
		}

		setclientmatchdata("alliesScore",-1);
		setclientmatchdata("axisScore",-1);
		setclientmatchdata("alliesFaction","none");
		setclientmatchdata("axisFaction","none");
	}

	foreach(var_01 in level.players)
	{
		var_10 = 0;
		if(!var_01 maps\mp\_utility::rankingenabled())
		{
			var_10 = var_01.pers["summary"]["xp"];
		}
		else
		{
			var_10 = var_01 method_84FE() - var_01.pers["summary"]["matchStartXp"];
		}

		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","totalXp",var_10);
		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","scoreXp",var_01.pers["summary"]["score"]);
		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","challengeXp",var_01.pers["summary"]["challenge"]);
		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","matchXp",var_01.pers["summary"]["match"]);
		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","miscXp",var_01.pers["summary"]["misc"]);
		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","entitlementXp",var_01.pers["summary"]["entitlementXP"]);
		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","clanWarsXp",var_01.pers["summary"]["clanWarsXP"]);
		var_11 = "";
		var_12 = 0;
		var_13 = 0;
		if(var_01.pers["nemesis_guid"] != "")
		{
			var_14 = var_01.pers["nemesis_guid"];
			var_11 = getplayerxuidfromguid(var_14);
			if(isdefined(var_01.pers["killed_players"][var_14]))
			{
				var_12 = maps\mp\_utility::clamptoshort(var_01.pers["killed_players"][var_14]);
			}

			if(isdefined(var_01.pers["killed_by"][var_14]))
			{
				var_13 = maps\mp\_utility::clamptoshort(var_01.pers["killed_by"][var_14]);
			}
		}

		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","nemesisXuid",var_11);
		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","nemesisKills",var_12);
		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","nemesisKilledBy",var_13);
		var_15 = "";
		var_16 = 0;
		if(var_01.pers["prey_guid"] != "")
		{
			var_17 = var_01.pers["prey_guid"];
			var_15 = getplayerxuidfromguid(var_17);
			if(isdefined(var_01.pers["killed_players"][var_17]))
			{
				var_16 = maps\mp\_utility::clamptoshort(var_01.pers["killed_players"][var_17]);
			}
		}

		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","preyXuid",var_15);
		var_01 setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","preyKills",var_16);
	}
}

//Function Number: 2
getplayerxuidfromguid(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02.guid == param_00)
		{
			return var_02.xuid;
		}
	}

	return "";
}

//Function Number: 3
setplayerscoreboardinfo()
{
	var_00 = getclientmatchdata("scoreboardPlayerCount");
	if(var_00 <= 24)
	{
		setclientmatchdata("players",self.clientmatchdataid,"score",self.pers["score"]);
		var_01 = self.pers["kills"];
		setclientmatchdata("players",self.clientmatchdataid,"kills",var_01);
		if(level.gametype == "ctf" || level.gametype == "sr" || level.gametype == "gun")
		{
			var_02 = self.assists;
		}
		else
		{
			var_02 = self.pers["assists"];
		}

		setclientmatchdata("players",self.clientmatchdataid,"assists",var_02);
		var_03 = self.pers["deaths"];
		setclientmatchdata("players",self.clientmatchdataid,"deaths",var_03);
		var_04 = self.pers["headshots"];
		setclientmatchdata("players",self.clientmatchdataid,"headshots",var_04);
		var_05 = self.pers["team"];
		setclientmatchdata("players",self.clientmatchdataid,"team",var_05);
		var_06 = game[self.pers["team"]];
		setclientmatchdata("players",self.clientmatchdataid,"faction",var_06);
		var_07 = self.pers["extrascore0"];
		setclientmatchdata("players",self.clientmatchdataid,"extrascore0",var_07);
		var_08 = self.pers["extrascore1"];
		setclientmatchdata("players",self.clientmatchdataid,"extrascore1",var_08);
		var_09 = 0;
		if(isdefined(self.pers["division"]) && isdefined(self.pers["division"]["index"]))
		{
			var_09 = self.pers["division"]["index"];
		}

		setclientmatchdata("players",self.clientmatchdataid,"division",var_09);
		var_0A = self getplayerdata(common_scripts\utility::getstatsgroup_common(),"callingCardIndex");
		setclientmatchdata("players",self.clientmatchdataid,"callingCardIndex",var_0A);
		var_0B = self getplayerdata(common_scripts\utility::getstatsgroup_common(),"emblemPatchIndex");
		setclientmatchdata("players",self.clientmatchdataid,"emblemPatchIndex",var_0B);
		var_00++;
		setclientmatchdata("scoreboardPlayerCount",var_00);
	}
}

//Function Number: 4
buildscoreboardtype(param_00)
{
	if(param_00 == "multiteam")
	{
		var_01 = 0;
		foreach(var_03 in level.teamnamelist)
		{
			foreach(var_05 in level.placement[var_03])
			{
				setclientmatchdata("scoreboards","multiteam","scoreboard",var_01,var_05.clientmatchdataid);
				var_01++;
			}
		}

		return;
	}

	if(var_05 == "neutral")
	{
		var_01 = 0;
		foreach(var_05 in level.placement["all"])
		{
			setclientmatchdata("scoreboards",param_00,"scoreboard",var_01,var_05.clientmatchdataid);
			var_01++;
		}

		return;
	}

	var_0A = maps\mp\_utility::getotherteam(var_05);
	var_01 = 0;
	foreach(var_05 in level.placement[param_00])
	{
		setclientmatchdata("scoreboards",param_00,"scoreboard",var_01,var_05.clientmatchdataid);
		var_01++;
	}

	foreach(var_05 in level.placement[var_0A])
	{
		setclientmatchdata("scoreboards",param_00,"scoreboard",var_01,var_05.clientmatchdataid);
		var_01++;
	}
}