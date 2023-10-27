/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gamescore.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 25
 * Decompile Time: 418 ms
 * Timestamp: 10/27/2023 1:30:56 AM
*******************************************************************/

//Function Number: 1
gethighestscoringplayer()
{
	func_870E();
	if(!level.placement["all"].size)
	{
		return undefined;
	}

	return level.placement["all"][0];
}

//Function Number: 2
getlosingplayers()
{
	func_870E();
	var_00 = level.placement["all"];
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(var_03 == level.placement["all"][0])
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 3
func_3D00(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(maps\mp\_utility::func_47BB())
	{
	}

	func_3D01(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 4
func_3D01(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_01.owner) && !botsentientswap(param_01))
	{
		param_01 = param_01.owner;
	}

	if(!botsentientswap(param_01))
	{
		if(isdefined(param_01.commanding_bot))
		{
			param_01 = param_01.commanding_bot;
		}
	}

	if(!isplayer(param_01))
	{
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_06 = param_01.pers["score"];
	onplayerscore(param_00,param_01,param_02,param_05);
	var_07 = param_01.pers["score"] - var_06;
	if(var_07 == 0)
	{
	}

	if(param_05)
	{
		var_07 = castint(var_07 * 10);
	}

	var_08 = maps\mp\gametypes\_rank::func_3BE0(param_00);
	if(!param_01 maps\mp\_utility::func_634C() && !level.hardcoremode && !param_04)
	{
		if(func_917C(level.gametype))
		{
			param_01 thread maps\mp\gametypes\_rank::func_8E77(var_08);
		}
		else
		{
			param_01 thread maps\mp\gametypes\_rank::func_8E77(var_07);
		}
	}

	if(func_917C(level.gametype))
	{
		param_01 maps\mp\gametypes\_persistence::func_7B07("score",var_08);
	}
	else if(!getactiveclientcount())
	{
		param_01 maps\mp\gametypes\_persistence::func_7B07("score",var_07);
	}

	if(param_01.pers["score"] >= -536)
	{
		param_01.pers["score"] = -536;
	}

	param_01.score = param_01.pers["score"];
	var_09 = param_01.score;
	if(param_05)
	{
		var_09 = castint(var_09 * 10);
	}

	if(func_917C(level.gametype))
	{
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","score",var_09 * var_08);
	}
	else
	{
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","score",var_09);
	}

	if(!level.teambased)
	{
		thread func_6D9E();
	}

	if(!param_03)
	{
		param_01 maps\mp\gametypes\_gamelogic::checkplayerscorelimitsoon();
	}

	var_0A = param_01 maps\mp\gametypes\_gamelogic::func_1BD7();
}

//Function Number: 5
onplayerscore(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	if(isdefined(level.onplayerscore))
	{
		var_04 = [[ level.onplayerscore ]](param_00,param_01,param_02);
	}

	if(!isdefined(var_04))
	{
		var_04 = maps\mp\gametypes\_rank::func_3BE0(param_00);
	}

	var_04 = var_04 * level.objectivepointsmod;
	if(param_03)
	{
		var_04 = castint(var_04 / 10);
	}

	param_01.pers["score"] = param_01.pers["score"] + var_04;
}

//Function Number: 6
_setplayerscore(param_00,param_01)
{
	if(param_01 == param_00.pers["score"])
	{
	}

	if(param_01 < 0)
	{
	}

	param_00.pers["score"] = param_01;
	param_00.score = param_00.pers["score"];
	param_00 thread maps\mp\gametypes\_gamelogic::func_1BD7();
}

//Function Number: 7
_getplayerscore(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	return param_00.pers["score"];
}

//Function Number: 8
giveteamscoreforobjective(param_00,param_01)
{
	param_01 = param_01 * level.objectivepointsmod;
	_setteamscore(param_00,func_06A3(param_00) + param_01);
	level notify("update_team_score",param_00,func_06A3(param_00));
	var_02 = func_3C86();
	if(!level.splitscreen && var_02 != "none" && var_02 != level.waswinning && gettime() - level.laststatustime > 5000 && maps\mp\_utility::getscorelimit() != 1)
	{
		level.laststatustime = gettime();
		maps\mp\_utility::func_4D30("lead_taken",var_02,"status");
		if(level.waswinning != "none")
		{
			maps\mp\_utility::func_4D30("lead_lost",level.waswinning,"status");
		}
	}

	if(var_02 != "none")
	{
		level.waswinning = var_02;
		var_03 = func_06A3(var_02);
		var_04 = maps\mp\_utility::getwatcheddvar("scorelimit");
		if(var_03 == 0 || var_04 == 0)
		{
		}

		var_05 = var_03 / var_04 * 100;
		if(var_05 > level.scorepercentagecutoff)
		{
			calccsplinecorridor(1);
		}
	}
}

//Function Number: 9
func_3C86()
{
	var_00 = level.teamnamelist;
	if(!isdefined(level.waswinning))
	{
		level.waswinning = "none";
	}

	var_01 = "none";
	var_02 = 0;
	if(level.waswinning != "none")
	{
		var_01 = level.waswinning;
		var_02 = game["teamScores"][level.waswinning];
	}

	var_03 = 1;
	foreach(var_05 in var_00)
	{
		if(var_05 == level.waswinning)
		{
			continue;
		}

		if(game["teamScores"][var_05] > var_02)
		{
			var_01 = var_05;
			var_02 = game["teamScores"][var_05];
			var_03 = 1;
			continue;
		}

		if(game["teamScores"][var_05] == var_02)
		{
			var_03 = var_03 + 1;
			var_01 = "none";
		}
	}

	return var_01;
}

//Function Number: 10
_setteamscore(param_00,param_01)
{
	if(param_01 == game["teamScores"][param_00])
	{
	}

	game["teamScores"][param_00] = param_01;
	func_8740(param_00);
	if((game["status"] == "overtime" && !isdefined(level.overtimescorewinoverride)) || isdefined(level.overtimescorewinoverride) && !level.overtimescorewinoverride)
	{
		thread maps\mp\gametypes\_gamelogic::onscorelimit();
	}

	thread maps\mp\gametypes\_gamelogic::func_1BDA(param_00);
	thread maps\mp\gametypes\_gamelogic::func_1BD7();
}

//Function Number: 11
func_8740(param_00)
{
	var_01 = 0;
	if(!maps\mp\_utility::func_4950() || !maps\mp\_utility::func_491C() || level.gametype == "blitz")
	{
		var_01 = func_06A3(param_00);
	}
	else
	{
		var_01 = game["roundsWon"][param_00];
	}

	setteamscore(param_00,var_01);
}

//Function Number: 12
func_06A3(param_00)
{
	return game["teamScores"][param_00];
}

//Function Number: 13
func_6D9F()
{
	level notify("updating_scores");
	level endon("updating_scores");
	wait(0.05);
	maps\mp\_utility::func_8BC1();
	foreach(var_01 in level.players)
	{
		var_01 updatescores();
	}
}

//Function Number: 14
func_6D9E()
{
	level notify("updating_dm_scores");
	level endon("updating_dm_scores");
	wait(0.05);
	maps\mp\_utility::func_8BC1();
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] updatedmscores();
		level.players[var_00].updateddmscores = 1;
	}
}

//Function Number: 15
func_6587()
{
	var_00 = 0;
	var_01 = level.placement["all"].size;
	var_02 = 0;
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		if(level.placement["all"][var_03] == self)
		{
			var_02 = 1;
		}

		if(var_02)
		{
			level.placement["all"][var_03] = level.placement["all"][var_03 + 1];
		}
	}

	if(!var_02)
	{
	}

	level.placement["all"][var_01 - 1] = undefined;
	if(level.multiteambased)
	{
		func_54F8();
	}

	if(level.teambased)
	{
		updateteamplacement();
	}

	var_01 = level.placement["all"].size;
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		var_04 = level.placement["all"][var_03];
		var_04 notify("update_outcome");
	}
}

//Function Number: 16
func_870E()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.connectedpostgame))
		{
			continue;
		}

		if(var_02.pers["team"] == "spectator" || var_02.pers["team"] == "none")
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	for(var_04 = 1;var_04 < var_00.size;var_04++)
	{
		var_02 = var_00[var_04];
		var_05 = var_02.score;
		for(var_06 = var_04 - 1;var_06 >= 0 && getbetterplayer(var_02,var_00[var_06]) == var_02;var_06--)
		{
			var_00[var_06 + 1] = var_00[var_06];
		}

		var_00[var_06 + 1] = var_02;
	}

	level.placement["all"] = var_00;
	if(level.multiteambased)
	{
		func_54F8();
	}
	else if(level.teambased)
	{
		updateteamplacement();
	}
}

//Function Number: 17
getbetterplayer(param_00,param_01)
{
	if(param_00.score > param_01.score)
	{
		return param_00;
	}

	if(param_01.score > param_00.score)
	{
		return param_01;
	}

	if(param_00.deaths < param_01.deaths)
	{
		return param_00;
	}

	if(param_01.deaths < param_00.deaths)
	{
		return param_01;
	}

	if(common_scripts\utility::func_1DE9())
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 18
updateteamplacement()
{
	var_00["allies"] = [];
	var_00["axis"] = [];
	var_00["spectator"] = [];
	var_01 = level.placement["all"];
	var_02 = var_01.size;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_01[var_03];
		var_05 = var_04.pers["team"];
		var_00[var_05][var_00[var_05].size] = var_04;
	}

	level.placement["allies"] = var_00["allies"];
	level.placement["axis"] = var_00["axis"];
}

//Function Number: 19
func_54F8()
{
	var_00["spectator"] = [];
	foreach(var_02 in level.teamnamelist)
	{
		var_00[var_02] = [];
	}

	var_04 = level.placement["all"];
	var_05 = var_04.size;
	for(var_06 = 0;var_06 < var_05;var_06++)
	{
		var_07 = var_04[var_06];
		var_08 = var_07.pers["team"];
		var_00[var_08][var_00[var_08].size] = var_07;
	}

	foreach(var_02 in level.teamnamelist)
	{
		level.placement[var_02] = var_00[var_02];
	}
}

//Function Number: 20
initialdmscoreupdate()
{
	wait(0.2);
	var_00 = 0;
	for(;;)
	{
		var_01 = 0;
		var_02 = level.players;
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_04 = var_02[var_03];
			if(!isdefined(var_04))
			{
				continue;
			}

			if(isdefined(var_04.updateddmscores))
			{
				continue;
			}

			var_04.updateddmscores = 1;
			var_04 updatedmscores();
			var_01 = 1;
			wait(0.5);
		}

		if(!var_01)
		{
			wait(3);
		}
	}
}

//Function Number: 21
processassist(param_00)
{
	if(isdefined(level.assists_disabled))
	{
	}

	if(maps\mp\_utility::func_47BB())
	{
	}

	func_61CD(param_00);
}

//Function Number: 22
func_61CD(param_00)
{
	self endon("disconnect");
	param_00 endon("disconnect");
	wait(0.05);
	maps\mp\_utility::func_8BC1();
	var_01 = self.pers["team"];
	if(var_01 != "axis" && var_01 != "allies")
	{
	}

	if(var_01 == param_00.pers["team"])
	{
	}

	var_02 = self;
	if(isdefined(self.commanding_bot))
	{
		var_02 = self.commanding_bot;
	}

	var_02 thread [[ level.onxpevent ]]("assist");
	var_02 maps\mp\_utility::func_4479("assists",1);
	var_02.assists = var_02 maps\mp\_utility::func_3B8D("assists");
	var_02 maps\mp\_utility::func_447B("assists",1);
	var_02 maps\mp\gametypes\_persistence::func_7B28("round","assists",var_02.assists);
	func_3D00("assist",self,param_00);
	maps\mp\killstreaks\_killstreaks::func_3CDB("assist");
	thread maps\mp\gametypes\_missions::func_5F95(param_00);
}

//Function Number: 23
func_61D6(param_00)
{
	if(isdefined(level.assists_disabled))
	{
	}

	if(maps\mp\_utility::func_47BB())
	{
	}

	func_61D7(param_00);
}

//Function Number: 24
func_61D7(param_00)
{
	self endon("disconnect");
	param_00 endon("disconnect");
	wait(0.05);
	maps\mp\_utility::func_8BC1();
	if(self.pers["team"] != "axis" && self.pers["team"] != "allies")
	{
	}

	if(self.pers["team"] == param_00.pers["team"])
	{
	}

	self thread [[ level.onxpevent ]]("assist");
	self thread [[ level.onxpevent ]]("assist");
	maps\mp\_utility::func_4479("assists",1);
	self.assists = maps\mp\_utility::func_3B8D("assists");
	maps\mp\_utility::func_447B("assists",1);
	maps\mp\gametypes\_persistence::func_7B28("round","assists",self.assists);
	func_3D00("assist",self,param_00);
	thread maps\mp\gametypes\_hud_message::func_794D("shield_assist");
	thread maps\mp\gametypes\_missions::func_5F95(param_00);
}

//Function Number: 25
func_917C(param_00)
{
	return param_00 == "dm" || param_00 == "sotf_ffa";
}