/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gamescore.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 20
 * Decompile Time: 325 ms
 * Timestamp: 10/27/2023 2:28:54 AM
*******************************************************************/

//Function Number: 1
func_26D0()
{
	func_26F4();
	if(!level.placement["all"].size)
	{
		return undefined;
	}

	return level.placement["all"][0];
}

//Function Number: 2
getlosingplayers()
{
	func_26F4();
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
func_26D3(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	var_05 = param_01.pers["score"];
	onplayerscore(param_00,param_01,param_02);
	if(var_05 == param_01.pers["score"])
	{
		return;
	}

	if(!param_01 maps\mp\_utility::rankingenabled() && !level.hardcoremode && !param_04)
	{
		param_01 thread maps\mp\gametypes\_rank::xppointspopup(param_01.pers["score"] - var_05,0,(0.85,0.85,0.85),0);
	}

	param_01 maps\mp\gametypes\_persistence::statadd("score",param_01.pers["score"] - var_05);
	param_01.score = param_01.pers["score"];
	param_01 maps\mp\gametypes\_persistence::func_26D8("round","score",param_01.score);
	if(!level.teambased)
	{
		thread sendupdateddmscores();
	}

	if(!param_03)
	{
		param_01 maps\mp\gametypes\_gamelogic::func_26DA();
	}

	var_06 = param_01 maps\mp\gametypes\_gamelogic::func_26DB();
}

//Function Number: 4
onplayerscore(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::getscoreinfovalue(param_00);
	param_01.pers["score"] = param_01.pers["score"] + var_03 * level.objectivepointsmod;
}

//Function Number: 5
_setplayerscore(param_00,param_01)
{
	if(param_01 == param_00.pers["score"])
	{
		return;
	}

	param_00.pers["score"] = param_01;
	param_00.score = param_00.pers["score"];
	param_00 thread maps\mp\gametypes\_gamelogic::func_26DB();
}

//Function Number: 6
_getplayerscore(param_00)
{
	return param_00.pers["score"];
}

//Function Number: 7
giveteamscoreforobjective(param_00,param_01)
{
	param_01 = param_01 * level.objectivepointsmod;
	var_02 = game["teamScores"][param_00];
	var_03 = level.otherteam[param_00];
	if(game["teamScores"][param_00] > game["teamScores"][var_03])
	{
		level.waswinning = param_00;
	}
	else if(game["teamScores"][var_03] > game["teamScores"][param_00])
	{
		level.waswinning = var_03;
	}

	_setteamscore(param_00,func_26EE(param_00) + param_01);
	var_04 = "none";
	if(game["teamScores"][param_00] > game["teamScores"][var_03])
	{
		var_04 = param_00;
	}
	else if(game["teamScores"][var_03] > game["teamScores"][param_00])
	{
		var_04 = var_03;
	}

	if(!level.splitscreen && var_04 != "none" && var_04 != level.waswinning && gettime() - level.laststatustime > 5000 && maps\mp\_utility::func_26E4() != 1)
	{
		level.laststatustime = gettime();
		maps\mp\_utility::func_26E5("lead_taken",var_04,"status");
		if(level.waswinning != "none")
		{
			maps\mp\_utility::func_26E5("lead_lost",level.waswinning,"status");
		}
	}

	if(var_04 != "none")
	{
		level.waswinning = var_04;
	}
}

//Function Number: 8
func_26E6()
{
	if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
	{
		return "allies";
	}
	else if(game["teamScores"]["allies"] < game["teamScores"]["axis"])
	{
		return "axis";
	}

	return "none";
}

//Function Number: 9
_setteamscore(param_00,param_01)
{
	if(param_01 == game["teamScores"][param_00])
	{
		return;
	}

	game["teamScores"][param_00] = param_01;
	func_26EB(param_00);
	if((game["status"] == "overtime" && !isdefined(level.overtimescorewinoverride)) || isdefined(level.overtimescorewinoverride) && !level.overtimescorewinoverride)
	{
		thread maps\mp\gametypes\_gamelogic::func_26E9();
		return;
	}

	thread maps\mp\gametypes\_gamelogic::func_26EA(param_00);
	thread maps\mp\gametypes\_gamelogic::func_26DB();
}

//Function Number: 10
func_26EB(param_00)
{
	var_01 = 0;
	if(!maps\mp\_utility::func_26EC() || !maps\mp\_utility::isobjectivebased())
	{
		var_01 = func_26EE(param_00);
	}
	else
	{
		var_01 = game["roundsWon"][param_00];
	}

	setteamscore(param_00,var_01);
}

//Function Number: 11
func_26EE(param_00)
{
	return game["teamScores"][param_00];
}

//Function Number: 12
sendupdatedteamscores()
{
	level notify("updating_scores");
	level endon("updating_scores");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	foreach(var_01 in level.players)
	{
		var_01 updatescores();
	}
}

//Function Number: 13
sendupdateddmscores()
{
	level notify("updating_dm_scores");
	level endon("updating_dm_scores");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] updatedmscores();
		level.players[var_00].updateddmscores = 1;
	}
}

//Function Number: 14
func_26F3()
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
		return;
	}

	level.placement["all"][var_01 - 1] = undefined;
	if(level.teambased)
	{
		updateteamplacement();
		return;
	}

	var_01 = level.placement["all"].size;
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		var_04 = level.placement["all"][var_03];
		var_04 notify("update_outcome");
	}
}

//Function Number: 15
func_26F4()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.connectedpostgame) || var_02.pers["team"] != "allies" && var_02.pers["team"] != "axis")
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
	if(level.teambased)
	{
		updateteamplacement();
	}
}

//Function Number: 16
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

	if(common_scripts\utility::cointoss())
	{
		return param_00;
	}

	return param_01;
}

//Function Number: 17
updateteamplacement()
{
	var_00["allies"] = [];
	var_01 = level.placement["all"];
	var_02 = var_01.size;
	for(var_03 = 0;var_03 < var_02;var_03++ = var_41["spectator"])
	{
		var_04 = var_01[var_03];
		var_05 = var_04.pers["team"];
		var_41[var_05][var_41[var_05].size] = var_04;
	}

	level.placement["allies"] = var_41["allies"];
	level.placement["axis"] = var_41["axis"];
}

//Function Number: 18
func_26F8()
{
	wait 0.2;
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
			wait 0.5;
		}

		if(!var_01)
		{
			wait 3;
		}
	}
}

//Function Number: 19
func_26F9(param_00)
{
	self endon("disconnect");
	param_00 endon("disconnect");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	if(self.pers["team"] != "axis" && self.pers["team"] != "allies")
	{
		return;
	}

	if(self.pers["team"] == param_00.pers["team"])
	{
		return;
	}

	self thread [[ level.onxpevent ]]("assist");
	maps\mp\_utility::func_26FB("assists",1);
	self.assists = maps\mp\_utility::getpersstat("assists");
	maps\mp\_utility::incplayerstat("assists",1);
	maps\mp\gametypes\_persistence::func_26D8("round","assists",self.assists);
	func_26D3("assist",self,param_00);
	maps\mp\killstreaks\_killstreaks::giveadrenaline("assist");
	thread maps\mp\gametypes\_missions::func_26FF();
}

//Function Number: 20
func_2700(param_00)
{
	self endon("disconnect");
	param_00 endon("disconnect");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	if(self.pers["team"] != "axis" && self.pers["team"] != "allies")
	{
		return;
	}

	if(self.pers["team"] == param_00.pers["team"])
	{
		return;
	}

	self thread [[ level.onxpevent ]]("assist");
	self thread [[ level.onxpevent ]]("assist");
	maps\mp\_utility::func_26FB("assists",1);
	self.assists = maps\mp\_utility::getpersstat("assists");
	maps\mp\_utility::incplayerstat("assists",1);
	maps\mp\gametypes\_persistence::func_26D8("round","assists",self.assists);
	func_26D3("assist",self,param_00);
	thread maps\mp\gametypes\_hud_message::func_2701("shield_assist");
	thread maps\mp\gametypes\_missions::func_26FF();
}