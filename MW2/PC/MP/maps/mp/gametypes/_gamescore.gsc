/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gamescore.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

gethighestscoringplayer()
{
	updateplacement();
	if(!level.placement["all"].size)
	{
		return undefined;
	}

	return level.placement["all"][0];
}

getlosingplayers()
{
	updateplacement();
	players = level.placement["all"];
	losingplayers = [];
	foreach(player in players)
	{
		if(player == level.placement["all"][0])
		{
			continue;
		}

		losingplayers[losingplayers.size] = player;
	}

	return losingplayers;
}

giveplayerscore(event, player, victim)
{
	if(isdefined(level.nukeincoming))
	{
		return;
	}

	score = player.pers["score"];
	onplayerscore(event, player, victim);
	if(score == player.pers["score"])
	{
		return;
	}

	if(!player maps\mp\_utility::rankingenabled() && !level.hardcoremode)
	{
		player thread maps\mp\gametypes\_rank::scorepopup(player.pers["score"] - score, 0, (0.85,0.85,0.85), 0);
	}

	player maps\mp\gametypes\_persistence::statadd("score", player.pers["score"] - score);
	player.score = player.pers["score"];
	player maps\mp\gametypes\_persistence::statsetchild("round", "score", player.score);
	if(!level.teambased)
	{
		thread sendupdateddmscores();
	}

	player maps\mp\gametypes\_gamelogic::checkplayerscorelimitsoon();
	scoreendedmatch = player maps\mp\gametypes\_gamelogic::checkscorelimit();
	if(scoreendedmatch && event == "kill")
	{
		player.finalkill = 1;
		return;
	}
}

onplayerscore(event, player, victim)
{
	score = maps\mp\gametypes\_rank::getscoreinfovalue(event);
	player.pers["score"] = player.pers["score"] + score * level.objectivepointsmod;
}

_setplayerscore(player, score)
{
	if(score == player.pers["score"])
	{
		return;
	}

	player.pers["score"] = score;
	player.score = player.pers["score"];
	player thread maps\mp\gametypes\_gamelogic::checkscorelimit();
}

_getplayerscore(player)
{
	return player.pers["score"];
}

giveteamscoreforobjective(team, score)
{
	if(isdefined(level.nukeincoming))
	{
		return;
	}

	score = score * level.objectivepointsmod;
	teamscore = game["teamScores"][team];
	otherteam = level.otherteam[team];
	if(game["teamScores"][team] > game["teamScores"][otherteam])
	{
		level.waswinning = team;
	}
	else if(game["teamScores"][otherteam] > game["teamScores"][team])
	{
		level.waswinning = otherteam;
	}

	_setteamscore(team, _getteamscore(team) + score);
	iswinning = "none";
	if(game["teamScores"][team] > game["teamScores"][otherteam])
	{
		iswinning = team;
	}
	else if(game["teamScores"][otherteam] > game["teamScores"][team])
	{
		iswinning = otherteam;
	}

	if(!level.splitscreen && iswinning != "none" && iswinning != level.waswinning && gettime() - level.laststatustime > 5000 && maps\mp\_utility::getscorelimit() != 1)
	{
		level.laststatustime = gettime();
		maps\mp\_utility::leaderdialog("lead_taken", iswinning, "status");
		if(level.waswinning != "none")
		{
			maps\mp\_utility::leaderdialog("lead_lost", level.waswinning, "status");
		}
	}

	if(iswinning != "none")
	{
		level.waswinning = iswinning;
		return;
	}
}

getwinningteam()
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

_setteamscore(team, teamscore)
{
	if(teamscore == game["teamScores"][team])
	{
		return;
	}

	if(isdefined(level.nukeincoming))
	{
		return;
	}

	game["teamScores"][team] = teamscore;
	updateteamscore(team);
	if(game["status"] == "overtime")
	{
		thread maps\mp\gametypes\_gamelogic::onscorelimit();
		return;
	}

	thread maps\mp\gametypes\_gamelogic::checkteamscorelimitsoon(team);
	thread maps\mp\gametypes\_gamelogic::checkscorelimit();
}

updateteamscore(team)
{
	teamscore = 0;
	if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased())
	{
		teamscore = _getteamscore(team);
	}
	else
	{
		teamscore = game["roundsWon"][team];
	}

	setteamscore(team, teamscore);
}

_getteamscore(team)
{
	return game["teamScores"][team];
}

sendupdatedteamscores()
{
	level notify("updating_scores");
	level endon("updating_scores");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	foreach(player in level.players)
	{
		player updatescores();
	}
}

sendupdateddmscores()
{
	level notify("updating_dm_scores");
	level endon("updating_dm_scores");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	for(i = 0;i < level.players.size;i++)
	{
		level.players[i] updatedmscores();
		level.players[i].updateddmscores = 1;
	}
}

removedisconnectedplayerfromplacement()
{
	offset = 0;
	numplayers = level.placement["all"].size;
	found = 0;
	for(i = 0;i < numplayers;i++)
	{
		if(level.placement["all"][i] == self)
		{
			found = 1;
		}

		if(found)
		{
			level.placement["all"][i] = level.placement["all"][i + 1];
		}
	}

	if(!found)
	{
		return;
	}

	level.placement["all"][numplayers - 1] = undefined;
	if(level.teambased)
	{
		updateteamplacement();
		return;
	}

	numplayers = level.placement["all"].size;
	for(i = 0;i < numplayers;i++)
	{
		player = level.placement["all"][i];
		player notify("update_outcome");
	}
}

updateplacement()
{
	placementall = [];
	foreach(player in level.players)
	{
		if(isdefined(player.connectedpostgame) || player.pers["team"] != "allies" && player.pers["team"] != "axis")
		{
			continue;
		}

		placementall[placementall.size] = player;
	}

	for(i = 1;i < placementall.size;i++)
	{
		player = placementall[i];
		playerscore = player.score;
		for(j = i - 1;j >= 0 && getbetterplayer(player, placementall[j]) == player;j--)
		{
			placementall[j + 1] = placementall[j];
		}

		placementall[j + 1] = player;
	}

	level.placement["all"] = placementall;
	if(level.teambased)
	{
		updateteamplacement();
	}
}

getbetterplayer(playera, playerb)
{
	if(playera.score > playerb.score)
	{
		return playera;
	}

	if(playerb.score > playera.score)
	{
		return playerb;
	}

	if(playera.deaths < playerb.deaths)
	{
		return playera;
	}

	if(playerb.deaths < playera.deaths)
	{
		return playerb;
	}

	if(common_scripts\utility::cointoss())
	{
		return playera;
	}

	return playerb;
}

updateteamplacement()
{
	placement["allies"] = [];
	placement["axis"] = [];
	placement["spectator"] = [];
	placementall = level.placement["all"];
	placementallsize = placementall.size;
	for(i = 0;i < placementallsize;i++)
	{
		player = placementall[i];
		team = player.pers["team"];
		placement[team][placement[team].size] = player;
	}

	level.placement["allies"] = placement["allies"];
	level.placement["axis"] = placement["axis"];
}

initialdmscoreupdate()
{
	wait 0.2;
	numsent = 0;
	for(;;)
	{
		didany = 0;
		players = level.players;
		for(i = 0;i < players.size;i++)
		{
			player = players[i];
			if(!isdefined(player))
			{
				continue;
			}

			if(isdefined(player.updateddmscores))
			{
				continue;
			}

			player.updateddmscores = 1;
			player updatedmscores();
			didany = 1;
			wait 0.5;
		}

		if(!didany)
		{
			wait 3;
		}
	}
}

processassist(param_6F1)
{
	self endon("disconnect");
	param_6F1 endon("disconnect");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	if(self.pers["team"] != "axis" && self.pers["team"] != "allies")
	{
		return;
	}

	if(self.pers["team"] == param_6F1.pers["team"])
	{
		return;
	}

	self thread [[ level.onxpevent ]]("assist");
	maps\mp\_utility::incpersstat("assists", 1);
	self.assists = maps\mp\_utility::getpersstat("assists");
	maps\mp\_utility::incplayerstat("assists", 1);
	giveplayerscore("assist", self, param_6F1);
	thread maps\mp\_utility::giveadrenaline("assist");
	thread maps\mp\gametypes\_missions::playerassist();
}

processshieldassist(param_6F1)
{
	self endon("disconnect");
	param_6F1 endon("disconnect");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	if(self.pers["team"] != "axis" && self.pers["team"] != "allies")
	{
		return;
	}

	if(self.pers["team"] == param_6F1.pers["team"])
	{
		return;
	}

	self thread [[ level.onxpevent ]]("assist");
	self thread [[ level.onxpevent ]]("assist");
	maps\mp\_utility::incpersstat("assists", 1);
	self.assists = maps\mp\_utility::getpersstat("assists");
	maps\mp\_utility::incplayerstat("assists", 1);
	giveplayerscore("assist", self, param_6F1);
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("shield_assist");
	thread maps\mp\gametypes\_missions::playerassist();
}