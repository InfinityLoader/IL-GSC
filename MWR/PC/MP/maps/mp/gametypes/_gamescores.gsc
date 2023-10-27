/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gamescores.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 350 ms
 * Timestamp: 10/27/2023 2:41:31 AM
*******************************************************************/

//Function Number: 1
gethighestscoringplayer()
{
	updateplacement();
	if(!level.placement["all"].size)
	{
		return undefined;
	}

	return level.placement["all"][0];
}

//Function Number: 2
gethighestscoringplayersarray(param_00)
{
	var_01 = [];
	if(param_00 < 0)
	{
		return var_01;
	}

	updateplacement();
	for(var_02 = 0;var_02 < param_00;var_02++)
	{
		if(level.placement["all"].size == var_02)
		{
			break;
		}

		var_01[var_02] = level.placement["all"][var_02];
	}

	return var_01;
}

//Function Number: 3
getlosingplayers()
{
	updateplacement();
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

//Function Number: 4
updatescorestatsffa(param_00,param_01)
{
	if(level.teambased)
	{
		return;
	}

	param_00 maps\mp\gametypes\_persistence::statsetchild("round","score",param_00.extrascore0);
	param_00 maps\mp\gametypes\_persistence::statadd("score",param_01);
}

//Function Number: 5
displaypoints(param_00)
{
	if(!level.hardcoremode)
	{
		var_01 = maps\mp\gametypes\_rank::getscoreinfovalue(param_00);
		thread maps\mp\gametypes\_rank::xppointspopup(param_00,var_01);
	}
}

//Function Number: 6
giveplayerscore(param_00,param_01,param_02)
{
	if(isdefined(param_01.owner))
	{
		param_01 = param_01.owner;
	}

	if(!isplayer(param_01))
	{
		return;
	}

	param_01 displaypoints(param_00);
	var_03 = param_01.pers["score"];
	onplayerscore(param_00,param_01,param_02);
	var_04 = param_01.pers["score"] - var_03;
	if(var_04 == 0)
	{
		return;
	}

	if(param_01.pers["score"] < 65535)
	{
		param_01.score = param_01.pers["score"];
	}

	if(level.teambased)
	{
		param_01 maps\mp\gametypes\_persistence::statsetchild("round","score",param_01.score);
		param_01 maps\mp\gametypes\_persistence::statadd("score",var_04);
	}

	if(!level.teambased)
	{
		level thread sendupdateddmscores();
		param_01 maps\mp\gametypes\_gamelogic::checkplayerscorelimitsoon();
	}

	param_01 maps\mp\gametypes\_gamelogic::checkscorelimit();
}

//Function Number: 7
onplayerscore(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(isdefined(level.onplayerscore))
	{
		var_03 = [[ level.onplayerscore ]](param_00,param_01,param_02);
	}

	if(!isdefined(var_03))
	{
		var_03 = maps\mp\gametypes\_rank::getscoreinfovalue(param_00);
	}

	param_01.pers["score"] = param_01.pers["score"] + var_03 * level.objectivepointsmod;
}

//Function Number: 8
_setplayerscore(param_00,param_01)
{
	if(param_01 == param_00.pers["score"])
	{
		return;
	}

	param_00.pers["score"] = param_01;
	param_00.score = int(min(param_00.pers["score"],65535));
	param_00 thread maps\mp\gametypes\_gamelogic::checkscorelimit();
}

//Function Number: 9
_getplayerscore(param_00)
{
	return param_00.pers["score"];
}

//Function Number: 10
giveteamscoreforobjective(param_00,param_01)
{
	param_01 = param_01 * level.objectivepointsmod;
	_setteamscore(param_00,_getteamscore(param_00) + param_01);
	level notify("update_team_score",param_00,_getteamscore(param_00));
	thread giveteamscoreforobjectiveendofframe();
}

//Function Number: 11
giveteamscoreforobjectiveendofframe()
{
	level endon("update_team_score");
	level endon("game_ended");
	waittillframeend;
	var_00 = getwinningteam();
	if(!level.splitscreen && var_00 != "none" && var_00 != level.waswinning && gettime() - level.laststatustime > 5000 && maps\mp\_utility::getscorelimit() != 1)
	{
		level.laststatustime = gettime();
		maps\mp\_utility::leaderdialog("lead_taken",var_00,"status");
		if(level.waswinning != "none")
		{
			maps\mp\_utility::leaderdialog("lead_lost",level.waswinning,"status");
		}
	}

	if(var_00 != "none")
	{
		level.waswinning = var_00;
		var_01 = _getteamscore(var_00);
		var_02 = maps\mp\_utility::getwatcheddvar("scorelimit");
		if(var_01 == 0 || var_02 == 0)
		{
			return;
		}

		var_03 = var_01 / var_02 * 100;
		if(var_03 > level.scorepercentagecutoff)
		{
			setnojipscore(1);
		}
	}
}

//Function Number: 12
getwinningteam()
{
	var_00 = level.teamnamelist;
	var_01 = var_00[0];
	var_02 = game["teamScores"][var_00[0]];
	var_03 = 1;
	for(var_04 = 1;var_04 < var_00.size;var_04++)
	{
		if(game["teamScores"][var_00[var_04]] > var_02)
		{
			var_01 = var_00[var_04];
			var_02 = game["teamScores"][var_00[var_04]];
			var_03 = 1;
			continue;
		}

		if(game["teamScores"][var_00[var_04]] == var_02)
		{
			var_03 = var_03 + 1;
			var_01 = "none";
		}
	}

	return var_01;
}

//Function Number: 13
_setteamscore(param_00,param_01)
{
	if(param_01 == game["teamScores"][param_00])
	{
		return;
	}

	game["teamScores"][param_00] = param_01;
	updateteamscore(param_00);
	if((maps\mp\_utility::inovertime() && !isdefined(level.overtimescorewinoverride)) || isdefined(level.overtimescorewinoverride) && !level.overtimescorewinoverride)
	{
		thread maps\mp\gametypes\_gamelogic::onscorelimit();
		return;
	}

	thread maps\mp\gametypes\_gamelogic::checkteamscorelimitsoon(param_00);
	thread maps\mp\gametypes\_gamelogic::checkscorelimit();
}

//Function Number: 14
updateteamscore(param_00)
{
	var_01 = 0;
	if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased())
	{
		var_01 = _getteamscore(param_00);
	}
	else
	{
		var_01 = game["roundsWon"][param_00];
	}

	setteamscore(param_00,var_01);
}

//Function Number: 15
_getteamscore(param_00)
{
	return game["teamScores"][param_00];
}

//Function Number: 16
sendupdatedteamscores()
{
	level notify("updating_scores");
	level endon("updating_scores");
	wait(0.05);
	maps\mp\_utility::waittillslowprocessallowed();
	foreach(var_01 in level.players)
	{
		var_01 updatescores();
	}
}

//Function Number: 17
sendupdateddmscores()
{
	level notify("updating_dm_scores");
	level endon("updating_dm_scores");
	wait(0.05);
	maps\mp\_utility::waittillslowprocessallowed();
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] updatedmscores();
		level.players[var_00].updateddmscores = 1;
	}
}

//Function Number: 18
removedisconnectedplayerfromplacement()
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
	if(level.multiteambased)
	{
		mtdm_updateteamplacement();
	}

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

//Function Number: 19
updateplacement()
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
		if(!level.teambased)
		{
			var_05 = var_02.extrascore0;
		}

		for(var_06 = var_04 - 1;var_06 >= 0 && getbetterplayer(var_02,var_00[var_06]) == var_02;var_06--)
		{
			var_00[var_06 + 1] = var_00[var_06];
		}

		var_00[var_06 + 1] = var_02;
	}

	level.placement["all"] = var_00;
	if(level.multiteambased)
	{
		mtdm_updateteamplacement();
	}
	else if(level.teambased)
	{
		updateteamplacement();
	}
}

//Function Number: 20
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

//Function Number: 21
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

//Function Number: 22
mtdm_updateteamplacement()
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

//Function Number: 23
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