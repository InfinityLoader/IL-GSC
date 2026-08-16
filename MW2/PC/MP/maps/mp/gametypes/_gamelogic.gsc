/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gamelogic.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

onforfeit(team)
{
	if(isdefined(level.forfeitinprogress))
	{
		return;
	}

	level endon("abort_forfeit");
	level.forfeitinprogress = 1;
	if(!level.teambased && level.players.size > 1)
	{
		wait 10;
	}

	forfeit_delay = 20;
	foreach(player in level.players)
	{
		player maps\mp\_utility::setlowermessage("forfeit_warning", game["strings"]["opponent_forfeiting_in"], forfeit_delay, 100);
		player thread forfeitwaitforabort();
	}

	wait forfeit_delay;
	endreason = &"";
	if(!isdefined(team))
	{
		endreason = game["strings"]["players_forfeited"];
		winner = level.players[0];
	}
	else if(team == "allies")
	{
		endreason = game["strings"]["allies_forfeited"];
		winner = "axis";
	}
	else if(team == "axis")
	{
		endreason = game["strings"]["axis_forfeited"];
		winner = "allies";
	}
	else
	{
		winner = "tie";
	}

	level.forcedend = 1;
	if(isplayer(winner))
	{
		logstring("forfeit, win: " + winner getxuid() + "(" + winner.name + ")");
	}
	else
	{
		logstring("forfeit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}

	thread endgame(winner, endreason);
}

forfeitwaitforabort()
{
	self endon("disconnect");
	level endon("game_ended");
	level waittill("abort_forfeit");
	maps\mp\_utility::clearlowermessage("forfeit_warning");
}

default_ondeadevent(team)
{
	if(team == "allies")
	{
		iprintln(game["strings"]["allies_eliminated"]);
		logstring("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
		thread endgame("axis", game["strings"]["allies_eliminated"]);
		return;
	}

	if(team == "axis")
	{
		iprintln(game["strings"]["axis_eliminated"]);
		logstring("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
		thread endgame("allies", game["strings"]["axis_eliminated"]);
		return;
	}

	logstring("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	if(level.teambased)
	{
		thread endgame("tie", game["strings"]["tie"]);
		return;
	}

	thread endgame(undefined, game["strings"]["tie"]);
}

default_ononeleftevent(team)
{
	if(level.teambased)
	{
		lastplayer = maps\mp\_utility::getlastlivingplayer(team);
		lastplayer thread givelastonteamwarning();
	}
	else
	{
		lastplayer = maps\mp\_utility::getlastlivingplayer();
		logstring("last one alive, win: " + lastplayer.name);
		thread endgame(lastplayer, &"MP_ENEMIES_ELIMINATED");
	}

	return 1;
}

default_ontimelimit()
{
	winner = undefined;
	if(level.teambased)
	{
		if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
		{
			winner = "tie";
		}
		else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			winner = "axis";
		}
		else
		{
			winner = "allies";
		}

		logstring("time limit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		winner = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
		if(isdefined(winner))
		{
			logstring("time limit, win: " + winner.name);
		}
		else
		{
			logstring("time limit, tie");
		}
	}

	thread endgame(winner, game["strings"]["time_limit_reached"]);
}

default_onhalftime()
{
	winner = undefined;
	thread endgame("halftime", game["strings"]["time_limit_reached"]);
}

forceend()
{
	if(level.hostforcedend || level.forcedend)
	{
		return;
	}

	winner = undefined;
	if(level.teambased)
	{
		if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
		{
			winner = "tie";
		}
		else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			winner = "axis";
		}
		else
		{
			winner = "allies";
		}

		logstring("host ended game, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		winner = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
		if(isdefined(winner))
		{
			logstring("host ended game, win: " + winner.name);
		}
		else
		{
			logstring("host ended game, tie");
		}
	}

	level.forcedend = 1;
	level.hostforcedend = 1;
	if(level.splitscreen)
	{
		endstring = &"MP_ENDED_GAME";
	}
	else
	{
		endstring = &"MP_HOST_ENDED_GAME";
	}

	thread endgame(winner, endstring);
}

onscorelimit()
{
	scoretext = game["strings"]["score_limit_reached"];
	winner = undefined;
	if(level.teambased)
	{
		if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
		{
			winner = "tie";
		}
		else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			winner = "axis";
		}
		else
		{
			winner = "allies";
		}

		logstring("scorelimit, win: " + winner + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		winner = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
		if(isdefined(winner))
		{
			logstring("scorelimit, win: " + winner.name);
		}
		else
		{
			logstring("scorelimit, tie");
		}
	}

	thread endgame(winner, scoretext);
	return 1;
}

updategameevents()
{
	if(maps\mp\_utility::matchmakinggame() && !level.ingraceperiod)
	{
		if(level.teambased)
		{
			if(level.teamcount["allies"] < 1 && level.teamcount["axis"] > 0 && game["state"] == "playing")
			{
				thread onforfeit("allies");
				return;
			}

			if(level.teamcount["axis"] < 1 && level.teamcount["allies"] > 0 && game["state"] == "playing")
			{
				thread onforfeit("axis");
				return;
			}

			if(level.teamcount["axis"] > 0 && level.teamcount["allies"] > 0)
			{
				level.forfeitinprogress = undefined;
				level notify("abort_forfeit");
			}
		}
		else
		{
			if(level.teamcount["allies"] + level.teamcount["axis"] == 1 && level.maxplayercount > 1)
			{
				thread onforfeit();
				return;
			}

			if(level.teamcount["axis"] + level.teamcount["allies"] > 1)
			{
				level.forfeitinprogress = undefined;
				level notify("abort_forfeit");
			}
		}
	}

	if(!maps\mp\_utility::getgametypenumlives() && !isdefined(level.disablespawning) || !level.disablespawning)
	{
		return;
	}

	if(!maps\mp\_utility::gamehasstarted())
	{
		return;
	}

	if(level.ingraceperiod)
	{
		return;
	}

	if(level.teambased)
	{
		livescount["allies"] = level.livescount["allies"];
		livescount["axis"] = level.livescount["axis"];
		if(isdefined(level.disablespawning) && level.disablespawning)
		{
			livescount["allies"] = 0;
			livescount["axis"] = 0;
		}

		if(!level.alivecount["allies"] && !level.alivecount["axis"] && !livescount["allies"] && !livescount["axis"])
		{
			return [[ level.ondeadevent ]]("all");
		}

		if(!level.alivecount["allies"] && !livescount["allies"])
		{
			return [[ level.ondeadevent ]]("allies");
		}

		if(!level.alivecount["axis"] && !livescount["axis"])
		{
			return [[ level.ondeadevent ]]("axis");
		}

		if(level.alivecount["allies"] == 1 && !livescount["allies"])
		{
			if(!isdefined(level.onelefttime["allies"]))
			{
				level.onelefttime["allies"] = gettime();
				return [[ level.ononeleftevent ]]("allies");
			}
		}

		if(level.alivecount["axis"] == 1 && !livescount["axis"])
		{
			if(!isdefined(level.onelefttime["axis"]))
			{
				level.onelefttime["axis"] = gettime();
				return [[ level.ononeleftevent ]]("axis");
			}

			return;
		}

		return;
	}

	if(!level.alivecount["allies"] && !level.alivecount["axis"] && !level.livescount["allies"] && !level.livescount["axis"])
	{
		return [[ level.ondeadevent ]]("all");
	}

	liveplayers = maps\mp\_utility::getpotentiallivingplayers();
	if(liveplayers.size == 1)
	{
		return [[ level.ononeleftevent ]]("all");
	}
}

waittillfinalkillcamdone()
{
	if(!level.showingfinalkillcam)
	{
		return 0;
	}

	while(level.showingfinalkillcam)
	{
		wait 0.05;
	}

	return 1;
}

timelimitclock_intermission(waittime)
{
	setgameendtime(gettime() + int(waittime * 1000));
	clockobject = spawn("script_origin", (0,0,0));
	clockobject hide();
	if(waittime >= 10)
	{
		wait waittime - 10;
	}

	for(;;)
	{
		clockobject playsound("ui_mp_timer_countdown");
		wait 1;
	}
}

waitforplayers(maxtime)
{
	endtime = gettime() + maxtime * 1000 - 200;
	if(level.teambased)
	{
		while((!level.hasspawned["axis"] || !level.hasspawned["allies"]) && gettime() < endtime)
		{
			wait 0.05;
		}

		return;
		for(;;)
		{
		}

		if(level.maxplayercount < 2 && gettime() < endtime)
		{
			wait 0.05;
		}
	}
}

prematchperiod()
{
	level endon("game_ended");
	if(level.prematchperiod > 0)
	{
		if(level.console)
		{
			thread matchstarttimer("match_starting_in", level.prematchperiod);
			wait level.prematchperiod;
		}
		else
		{
			matchstarttimerpc();
		}
	}
	else
	{
		matchstarttimerskip();
	}

	for(index = 0;index < level.players.size;index++)
	{
		level.players[index] maps\mp\_utility::freezecontrolswrapper(0);
		level.players[index] enableweapons();
		hintmessage = maps\mp\_utility::getobjectivehinttext(level.players[index].pers["team"]);
		if(!isdefined(hintmessage) || !level.players[index].hasspawned)
		{
			continue;
		}

		level.players[index] setclientdvar("scr_objectiveText", hintmessage);
		level.players[index] thread maps\mp\gametypes\_hud_message::hintmessage(hintmessage);
	}

	if(game["state"] != "playing")
	{
		return;
	}
}

graceperiod()
{
	level endon("game_ended");
	while(level.ingraceperiod)
	{
		wait 1;
		level.ingraceperiod--;
	}

	level notify("grace_period_ending");
	wait 0.05;
	maps\mp\_utility::gameflagset("graceperiod_done");
	level.ingraceperiod = 0;
	if(game["state"] != "playing")
	{
		return;
	}

	if(maps\mp\_utility::getgametypenumlives())
	{
		players = level.players;
		for(i = 0;i < players.size;i++)
		{
			player = players[i];
			if(!player.hasspawned && player.sessionteam != "spectator" && !isalive(player))
			{
				player.statusicon = "hud_status_dead";
			}
		}
	}

	level thread updategameevents();
}

updatewinstats(winner)
{
	if(!winner maps\mp\_utility::rankingenabled())
	{
		return;
	}

	winner maps\mp\gametypes\_persistence::statadd("losses", -1);
	winner maps\mp\gametypes\_persistence::statadd("wins", 1);
	winner maps\mp\_utility::updatepersratio("winLossRatio", "wins", "losses");
	winner maps\mp\gametypes\_persistence::statadd("currentWinStreak", 1);
	cur_win_streak = winner maps\mp\gametypes\_persistence::statget("currentWinStreak");
	if(cur_win_streak > winner maps\mp\gametypes\_persistence::statget("winStreak"))
	{
		winner maps\mp\gametypes\_persistence::statset("winStreak", cur_win_streak);
	}

	winner maps\mp\gametypes\_persistence::statsetchild("round", "win", 1);
	winner maps\mp\gametypes\_persistence::statsetchild("round", "loss", 0);
}

updatelossstats(loser)
{
	if(!loser maps\mp\_utility::rankingenabled())
	{
		return;
	}

	loser maps\mp\gametypes\_persistence::statadd("losses", 1);
	loser maps\mp\_utility::updatepersratio("winLossRatio", "wins", "losses");
	loser maps\mp\gametypes\_persistence::statsetchild("round", "loss", 1);
}

updatetiestats(loser)
{
	if(!loser maps\mp\_utility::rankingenabled())
	{
		return;
	}

	loser maps\mp\gametypes\_persistence::statadd("losses", -1);
	loser maps\mp\gametypes\_persistence::statadd("ties", 1);
	loser maps\mp\_utility::updatepersratio("winLossRatio", "wins", "losses");
	loser maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
}

updatewinlossstats(winner)
{
	if(maps\mp\_utility::privatematch())
	{
		return;
	}

	if(!maps\mp\_utility::waslastround())
	{
		return;
	}

	players = level.players;
	if(!isdefined(winner) || isdefined(winner) && isstring(winner) && winner == "tie")
	{
		foreach(player in level.players)
		{
			if(isdefined(player.connectedpostgame))
			{
				continue;
			}

			if(level.hostforcedend && player ishost())
			{
				player maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
				continue;
			}

			updatetiestats(player);
		}

		return;
	}

	if(isplayer(winner))
	{
		if(level.hostforcedend && winner ishost())
		{
			winner maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
			return;
		}

		updatewinstats(winner);
		return;
	}

	if(isstring(winner))
	{
		foreach(player in level.players)
		{
			if(isdefined(player.connectedpostgame))
			{
				continue;
			}

			if(level.hostforcedend && player ishost())
			{
				player maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
				continue;
			}

			if(winner == "tie")
			{
				updatetiestats(player);
				continue;
			}

			if(player.pers["team"] == winner)
			{
				updatewinstats(player);
				continue;
			}

			player maps\mp\gametypes\_persistence::statset("currentWinStreak", 0);
		}

		return;
	}
}

freezeplayerforroundend(delay)
{
	self endon("disconnect");
	maps\mp\_utility::clearlowermessages();
	if(!isdefined(delay))
	{
		delay = 0.05;
	}

	self closepopupmenu();
	self closeingamemenu();
	wait delay;
	maps\mp\_utility::freezecontrolswrapper(1);
}

updatematchbonusscores(winner)
{
	if(!game["timePassed"])
	{
		return;
	}

	if(!maps\mp\_utility::matchmakinggame())
	{
		return;
	}

	if(!maps\mp\_utility::gettimelimit() || level.forcedend)
	{
		gamelength = maps\mp\_utility::gettimepassed() / 1000;
		gamelength = min(gamelength, 1200);
	}
	else
	{
		gamelength = maps\mp\_utility::gettimelimit() * 60;
	}

	if(level.teambased)
	{
		if(winner == "allies")
		{
			winningteam = "allies";
			losingteam = "axis";
		}
		else if(winner == "axis")
		{
			winningteam = "axis";
			losingteam = "allies";
		}
		else
		{
			winningteam = "tie";
			losingteam = "tie";
		}

		if(winningteam != "tie")
		{
			winnerscale = maps\mp\gametypes\_rank::getscoreinfovalue("win");
			loserscale = maps\mp\gametypes\_rank::getscoreinfovalue("loss");
			setwinningteam(winningteam);
		}
		else
		{
			winnerscale = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
			loserscale = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
		}

		foreach(player in level.players)
		{
			if(isdefined(player.connectedpostgame))
			{
				continue;
			}

			if(!player maps\mp\_utility::rankingenabled())
			{
				continue;
			}

			if(player.timeplayed["total"] < 1 || player.pers["participation"] < 1)
			{
				player thread maps\mp\gametypes\_rank::endgameupdate();
				continue;
			}

			if(level.hostforcedend && player ishost())
			{
				continue;
			}

			spm = player maps\mp\gametypes\_rank::getspm();
			if(winningteam == "tie")
			{
				playerscore = int(winnerscale * gamelength / 60 * spm * player.timeplayed["total"] / gamelength);
				player thread givematchbonus("tie", playerscore);
				player.matchbonus = playerscore;
				continue;
			}

			if(isdefined(player.pers["team"]) && player.pers["team"] == winningteam)
			{
				playerscore = int(winnerscale * gamelength / 60 * spm * player.timeplayed["total"] / gamelength);
				player thread givematchbonus("win", playerscore);
				player.matchbonus = playerscore;
				continue;
			}

			if(isdefined(player.pers["team"]) && player.pers["team"] == losingteam)
			{
				playerscore = int(loserscale * gamelength / 60 * spm * player.timeplayed["total"] / gamelength);
				player thread givematchbonus("loss", playerscore);
				player.matchbonus = playerscore;
			}
		}

		return;
	}

	if(isdefined(spm))
	{
		winnerscale = maps\mp\gametypes\_rank::getscoreinfovalue("win");
		loserscale = maps\mp\gametypes\_rank::getscoreinfovalue("loss");
	}
	else
	{
		winnerscale = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
		loserscale = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
	}

	foreach(player in level.players)
	{
		if(isdefined(player.connectedpostgame))
		{
			continue;
		}

		if(player.timeplayed["total"] < 1 || player.pers["participation"] < 1)
		{
			player thread maps\mp\gametypes\_rank::endgameupdate();
			continue;
		}

		spm = player maps\mp\gametypes\_rank::getspm();
		iswinner = 0;
		for(pidx = 0;pidx < min(level.placement["all"].size, 3);pidx++)
		{
			if(level.placement["all"][pidx] != player)
			{
				continue;
			}

			iswinner = 1;
		}

		if(iswinner)
		{
			playerscore = int(winnerscale * gamelength / 60 * spm * player.timeplayed["total"] / gamelength);
			player thread givematchbonus("win", playerscore);
			player.matchbonus = playerscore;
			continue;
		}

		playerscore = int(loserscale * gamelength / 60 * spm * player.timeplayed["total"] / gamelength);
		player thread givematchbonus("loss", playerscore);
		player.matchbonus = playerscore;
	}
}

givematchbonus(scoretype, score)
{
	self endon("disconnect");
	level waittill("give_match_bonus");
	maps\mp\gametypes\_rank::giverankxp(scoretype, score);
	maps\mp\gametypes\_rank::endgameupdate();
}

setxenonranks(winner)
{
	players = level.players;
	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		if(!isdefined(player.score) || !isdefined(player.pers["team"]))
		{
			continue;
		}
	}

	for(i = 0;i < players.size;i++)
	{
		player = players[i];
		if(!isdefined(player.score) || !isdefined(player.pers["team"]))
		{
			continue;
		}

		print3d(player, player.clientid, player.score - 5 * player.deaths);
	}

	print3d();
}

checktimelimit(prevtimepassed)
{
	if(isdefined(level.timelimitoverride) && level.timelimitoverride)
	{
		return;
	}

	if(game["state"] != "playing")
	{
		setgameendtime(0);
		return;
	}

	if(maps\mp\_utility::gettimelimit() <= 0)
	{
		if(isdefined(level.starttime))
		{
			setgameendtime(level.starttime);
		}
		else
		{
			setgameendtime(0);
		}

		return;
	}

	if(!maps\mp\_utility::gameflag("prematch_done"))
	{
		setgameendtime(0);
		return;
	}

	if(!isdefined(level.starttime))
	{
		return;
	}

	timeleft = gettimeremaining();
	setgameendtime(gettime() + int(timeleft));
	if(timeleft > 0)
	{
		if(maps\mp\_utility::gethalftime() && checkhalftime(prevtimepassed))
		{
			[[ level.onhalftime ]]();
		}

		return;
	}

	[[ level.ontimelimit ]]();
}

checkhalftime(prevtimepassed)
{
	if(!level.teambased)
	{
		return 0;
	}

	if(maps\mp\_utility::gettimelimit())
	{
		halftime = maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5;
		if(maps\mp\_utility::gettimepassed() >= halftime && prevtimepassed < halftime && prevtimepassed > 0)
		{
			game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
			return 1;
		}
	}

	return 0;
}

gettimeremaining()
{
	return maps\mp\_utility::gettimelimit() * 60 * 1000 - maps\mp\_utility::gettimepassed();
}

checkteamscorelimitsoon(team)
{
	if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0 || maps\mp\_utility::isobjectivebased())
	{
		return;
	}

	if(isdefined(level.scorelimitoverride) && level.scorelimitoverride)
	{
		return;
	}

	if(!level.teambased)
	{
		return;
	}

	if(maps\mp\_utility::gettimepassed() < -5536)
	{
		return;
	}

	timeleft = estimatedtimetillscorelimit(team);
	if(timeleft < 2)
	{
		level notify("match_ending_soon", "score");
		return;
	}
}

checkplayerscorelimitsoon()
{
	if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0 || maps\mp\_utility::isobjectivebased())
	{
		return;
	}

	if(level.teambased)
	{
		return;
	}

	if(maps\mp\_utility::gettimepassed() < -5536)
	{
		return;
	}

	timeleft = estimatedtimetillscorelimit();
	if(timeleft < 2)
	{
		level notify("match_ending_soon", "score");
		return;
	}
}

checkscorelimit()
{
	if(maps\mp\_utility::isobjectivebased())
	{
		return 0;
	}

	if(isdefined(level.scorelimitoverride) && level.scorelimitoverride)
	{
		return 0;
	}

	if(game["state"] != "playing")
	{
		return 0;
	}

	if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0)
	{
		return 0;
	}

	if(level.teambased)
	{
		if(game["teamScores"]["allies"] < maps\mp\_utility::getwatcheddvar("scorelimit") && game["teamScores"]["axis"] < maps\mp\_utility::getwatcheddvar("scorelimit"))
		{
			return 0;
		}
	}
	else
	{
		if(!isplayer(self))
		{
			return 0;
		}

		if(self.score < maps\mp\_utility::getwatcheddvar("scorelimit"))
		{
			return 0;
		}
	}

	return onscorelimit();
}

updategametypedvars()
{
	level endon("game_ended");
	while(game["state"] == "playing")
	{
		if(isdefined(level.starttime))
		{
			if(gettimeremaining() < 3000)
			{
				wait 0.1;
				continue;
			}
		}

		wait 1;
	}
}

matchstarttimerpc()
{
	thread matchstarttimer("waiting_for_teams", level.prematchperiod + level.prematchperiodend);
	waitforplayers(level.prematchperiod);
	if(level.prematchperiodend > 0)
	{
		matchstarttimer("match_starting_in", level.prematchperiodend);
		return;
	}
}

matchstarttimer_internal(counttime, matchstarttimer)
{
	waittillframeend;
	visionsetnaked("mpIntro", 0);
	level endon("match_start_timer_beginning");
	while(counttime > 0 && !level.gameended)
	{
		matchstarttimer thread maps\mp\gametypes\_hud::fontpulse(level);
		wait matchstarttimer.inframes * 0.05;
		matchstarttimer setvalue(counttime);
		if(counttime == 2)
		{
			visionsetnaked(getdvar("mapname"), 3);
		}

		counttime--;
		wait 1 - matchstarttimer.inframes * 0.05;
	}
}

matchstarttimer(type, duration)
{
	level notify("match_start_timer_beginning");
	matchstarttext = maps\mp\gametypes\_hud_util::createserverfontstring("objective", 1.5);
	matchstarttext maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, -40);
	matchstarttext.sort = 1001;
	matchstarttext settext(game["strings"]["waiting_for_teams"]);
	matchstarttext.foreground = 0;
	matchstarttext.hidewheninmenu = 1;
	matchstarttext settext(game["strings"][type]);
	matchstarttimer = maps\mp\gametypes\_hud_util::createserverfontstring("hudbig", 1);
	matchstarttimer maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, 0);
	matchstarttimer.sort = 1001;
	matchstarttimer.color = (1,1,0);
	matchstarttimer.foreground = 0;
	matchstarttimer.hidewheninmenu = 1;
	matchstarttimer maps\mp\gametypes\_hud::fontpulseinit();
	counttime = int(duration);
	if(counttime >= 2)
	{
		matchstarttimer_internal(counttime, matchstarttimer);
		visionsetnaked(getdvar("mapname"), 3);
	}
	else
	{
		visionsetnaked("mpIntro", 0);
		visionsetnaked(getdvar("mapname"), 1);
	}

	matchstarttimer maps\mp\gametypes\_hud_util::destroyelem();
	matchstarttext maps\mp\gametypes\_hud_util::destroyelem();
}

matchstarttimerskip()
{
	visionsetnaked(getdvar("mapname"), 0);
}

onroundswitch()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(game["roundsWon"]["allies"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1)
	{
		aheadteam = getbetterteam();
		if(aheadteam != game["defenders"])
		{
			game["switchedsides"] = !game["switchedsides"];
		}
		else
		{
			level.halftimesubcaption = "";
		}

		level.halftimetype = "overtime";
		return;
	}

	level.halftimetype = "halftime";
	game["switchedsides"] = !game["switchedsides"];
}

checkroundswitch()
{
	if(!level.teambased)
	{
		return 0;
	}

	if(!isdefined(level.roundswitch) || !level.roundswitch)
	{
		return 0;
	}

	if(game["roundsPlayed"] % level.roundswitch == 0)
	{
		onroundswitch();
		return 1;
	}

	return 0;
}

timeuntilroundend()
{
	if(level.gameended)
	{
		timepassed = gettime() - level.gameendtime / 1000;
		timeremaining = level.postroundtime - timepassed;
		if(timeremaining < 0)
		{
			return 0;
		}

		return timeremaining;
	}

	if(maps\mp\_utility::gettimelimit() <= 0)
	{
		return undefined;
	}

	if(!isdefined(level.starttime))
	{
		return undefined;
	}

	tl = maps\mp\_utility::gettimelimit();
	timepassed = gettime() - level.starttime / 1000;
	timeremaining = maps\mp\_utility::gettimelimit() * 60 - timepassed;
	if(isdefined(level.timepaused))
	{
		timeremaining = timeremaining + level.timepaused;
	}

	return timeremaining + level.postroundtime;
}

freegameplayhudelems()
{
	if(isdefined(self.perkicon))
	{
		if(isdefined(self.perkicon[0]))
		{
			self.perkicon[0] maps\mp\gametypes\_hud_util::destroyelem();
			self.perkname[0] maps\mp\gametypes\_hud_util::destroyelem();
		}

		if(isdefined(self.perkicon[1]))
		{
			self.perkicon[1] maps\mp\gametypes\_hud_util::destroyelem();
			self.perkname[1] maps\mp\gametypes\_hud_util::destroyelem();
		}

		if(isdefined(self.perkicon[2]))
		{
			self.perkicon[2] maps\mp\gametypes\_hud_util::destroyelem();
			self.perkname[2] maps\mp\gametypes\_hud_util::destroyelem();
		}
	}

	self notify("perks_hidden");
	self.lowermessage maps\mp\gametypes\_hud_util::destroyelem();
	self.lowertimer maps\mp\gametypes\_hud_util::destroyelem();
	if(isdefined(self.proxbar))
	{
		self.proxbar maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(self.proxbartext))
	{
		self.proxbartext maps\mp\gametypes\_hud_util::destroyelem();
		return;
	}
}

gethostplayer()
{
	players = getentarray("player", "classname");
	for(index = 0;index < players.size;index++)
	{
		if(players[index] ishost())
		{
			return players[index];
		}
	}
}

hostidledout()
{
	hostplayer = gethostplayer();
	if(isdefined(hostplayer) && !hostplayer.hasspawned && !isdefined(hostplayer.selectedclass))
	{
		return 1;
	}

	return 0;
}

roundendwait(defaultdelay, matchbonus)
{
	notifiesdone = 0;
	while(!notifiesdone)
	{
		players = level.players;
		notifiesdone = 1;
		foreach(player in players)
		{
			if(!isdefined(player.doingsplash))
			{
				continue;
			}

			if(!player maps\mp\gametypes\_hud_message::isdoingsplash())
			{
				continue;
			}

			notifiesdone = 0;
		}

		wait 0.5;
	}

	if(!matchbonus)
	{
		wait defaultdelay;
		level notify("round_end_finished");
		return;
	}

	wait defaultdelay / 2;
	level notify("give_match_bonus");
	wait defaultdelay / 2;
	notifiesdone = 0;
	while(!notifiesdone)
	{
		players = level.players;
		notifiesdone = 1;
		foreach(player in players)
		{
			if(!isdefined(player.doingsplash))
			{
				continue;
			}

			if(!player maps\mp\gametypes\_hud_message::isdoingsplash())
			{
				continue;
			}

			notifiesdone = 0;
		}

		wait 0.5;
	}

	level notify("round_end_finished");
}

roundenddof(time)
{
	self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

callback_startgametype()
{
	maps\mp\_load::main();
	maps\mp\_utility::levelflaginit("round_over", 0);
	maps\mp\_utility::levelflaginit("game_over", 0);
	maps\mp\_utility::levelflaginit("block_notifies", 0);
	level.prematchperiod = 0;
	level.prematchperiodend = 0;
	level.postgamenotifies = 0;
	level.intermission = 0;
	makedvarserverinfo("cg_thirdPersonAngle", 356);
	makedvarserverinfo("scr_gameended", 0);
	if(!isdefined(game["gamestarted"]))
	{
		game["clientid"] = 0;
		alliescharset = getmapcustom("allieschar");
		if(!isdefined(alliescharset) || alliescharset == "")
		{
			if(!isdefined(game["allies"]))
			{
				alliescharset = "us_army";
			}
			else
			{
				alliescharset = game["allies"];
			}
		}

		axischarset = getmapcustom("axischar");
		if(!isdefined(axischarset) || axischarset == "")
		{
			if(!isdefined(game["axis"]))
			{
				axischarset = "opforce_composite";
			}
			else
			{
				axischarset = game["axis"];
			}
		}

		game["allies"] = alliescharset;
		game["axis"] = axischarset;
		if(!isdefined(game["attackers"]) || !isdefined(game["defenders"]))
		{
			thread common_scripts\utility::error("No attackers or defenders team defined in level .gsc.");
		}

		if(!isdefined(game["attackers"]))
		{
			game["attackers"] = "allies";
		}

		if(!isdefined(game["defenders"]))
		{
			game["defenders"] = "axis";
		}

		if(!isdefined(game["state"]))
		{
			game["state"] = "playing";
		}

		precachestatusicon("hud_status_dead");
		precachestatusicon("hud_status_connecting");
		precachestring(&"MPUI_REVIVING");
		precachestring(&"MPUI_BEING_REVIVED");
		print3d("damage_heavy");
		precacheshader("white");
		precacheshader("black");
		game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
		if(level.teambased)
		{
			game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_TEAMS";
			game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
		}
		else
		{
			game["strings"]["waiting_for_teams"] = &"MP_WAITING_FOR_MORE_PLAYERS";
			game["strings"]["opponent_forfeiting_in"] = &"MP_OPPONENT_FORFEITING_IN";
		}

		game["strings"]["match_starting_in"] = &"MP_MATCH_STARTING_IN";
		game["strings"]["match_resuming_in"] = &"MP_MATCH_RESUMING_IN";
		game["strings"]["waiting_for_players"] = &"MP_WAITING_FOR_PLAYERS";
		game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
		game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";
		game["strings"]["waiting_to_safespawn"] = &"MP_WAITING_TO_SAFESPAWN";
		game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
		game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
		game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
		game["strings"]["final_stand"] = &"MPUI_FINAL_STAND";
		game["strings"]["c4_death"] = &"MPUI_C4_DEATH";
		game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";
		game["strings"]["tie"] = &"MP_MATCH_TIE";
		game["strings"]["round_draw"] = &"MP_ROUND_DRAW";
		game["strings"]["grabbed_flag"] = &"MP_GRABBED_FLAG_FIRST";
		game["strings"]["enemies_eliminated"] = &"MP_ENEMIES_ELIMINATED";
		game["strings"]["score_limit_reached"] = &"MP_SCORE_LIMIT_REACHED";
		game["strings"]["round_limit_reached"] = &"MP_ROUND_LIMIT_REACHED";
		game["strings"]["time_limit_reached"] = &"MP_TIME_LIMIT_REACHED";
		game["strings"]["players_forfeited"] = &"MP_PLAYERS_FORFEITED";
		game["strings"]["S.A.S Win"] = &"SAS_WIN";
		game["strings"]["Spetsnaz Win"] = &"SPETSNAZ_WIN";
		game["colors"]["blue"] = (0.25,0.25,0.75);
		game["colors"]["red"] = (0.75,0.25,0.25);
		game["colors"]["white"] = (1,1,1);
		game["colors"]["black"] = (0,0,0);
		game["colors"]["green"] = (0.25,0.75,0.25);
		game["colors"]["yellow"] = (0.65,0.65,0);
		game["colors"]["orange"] = (1,0.45,0);
		game["strings"]["allies_eliminated"] = maps\mp\gametypes\_teams::getteameliminatedstring("allies");
		game["strings"]["allies_forfeited"] = maps\mp\gametypes\_teams::getteamforfeitedstring("allies");
		game["strings"]["allies_name"] = maps\mp\gametypes\_teams::getteamname("allies");
		game["icons"]["allies"] = maps\mp\gametypes\_teams::getteamicon("allies");
		game["colors"]["allies"] = maps\mp\gametypes\_teams::getteamcolor("allies");
		game["strings"]["axis_eliminated"] = maps\mp\gametypes\_teams::getteameliminatedstring("axis");
		game["strings"]["axis_forfeited"] = maps\mp\gametypes\_teams::getteamforfeitedstring("axis");
		game["strings"]["axis_name"] = maps\mp\gametypes\_teams::getteamname("axis");
		game["icons"]["axis"] = maps\mp\gametypes\_teams::getteamicon("axis");
		game["colors"]["axis"] = maps\mp\gametypes\_teams::getteamcolor("axis");
		if(game["colors"]["allies"] == (0,0,0))
		{
			game["colors"]["allies"] = (0.5,0.5,0.5);
		}

		if(game["colors"]["axis"] == (0,0,0))
		{
			game["colors"]["axis"] = (0.5,0.5,0.5);
		}

		[[ level.onprecachegametype ]]();
		if(level.console)
		{
			if(!level.splitscreen)
			{
				level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "graceperiod");
			}
		}
		else
		{
			level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "playerwaittime");
			level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "matchstarttime");
		}
	}

	if(!isdefined(game["status"]))
	{
		game["status"] = "normal";
	}

	makedvarserverinfo("ui_overtime", game["status"] == "overtime");
	if(game["status"] != "overtime" && game["status"] != "halftime")
	{
		game["teamScores"]["allies"] = 0;
		game["teamScores"]["axis"] = 0;
	}

	if(!isdefined(game["timePassed"]))
	{
		game["timePassed"] = 0;
	}

	if(!isdefined(game["roundsPlayed"]))
	{
		game["roundsPlayed"] = 0;
	}

	if(!isdefined(game["roundsWon"]))
	{
		game["roundsWon"] = [];
	}

	if(level.teambased)
	{
		if(!isdefined(game["roundsWon"]["axis"]))
		{
			game["roundsWon"]["axis"] = 0;
		}

		if(!isdefined(game["roundsWon"]["allies"]))
		{
			game["roundsWon"]["allies"] = 0;
		}
	}

	level.gameended = 0;
	level.forcedend = 0;
	level.hostforcedend = 0;
	level.hardcoremode = getdvarint("g_hardcore");
	if(level.hardcoremode)
	{
		logstring("game mode: hardcore");
	}

	level.diehardmode = getdvarint("scr_diehard");
	if(!level.teambased)
	{
		level.diehardmode = 0;
	}

	if(level.diehardmode)
	{
		logstring("game mode: diehard");
	}

	level.killstreakrewards = getdvarint("scr_game_hardpoints");
	level.usestartspawns = 1;
	level.objectivepointsmod = 1;
	if(maps\mp\_utility::matchmakinggame())
	{
		level.maxallowedteamkills = 2;
	}
	else
	{
		level.maxallowedteamkills = -1;
	}

	thread maps\mp\gametypes\_persistence::init();
	thread maps\mp\gametypes\_menus::init();
	thread maps\mp\gametypes\_hud::init();
	thread maps\mp\gametypes\_serversettings::init();
	thread maps\mp\gametypes\_teams::init();
	thread maps\mp\gametypes\_weapons::init();
	thread maps\mp\gametypes\_killcam::init();
	thread maps\mp\gametypes\_shellshock::init();
	thread maps\mp\gametypes\_deathicons::init();
	thread maps\mp\gametypes\_damagefeedback::init();
	thread maps\mp\gametypes\_healthoverlay::init();
	thread maps\mp\gametypes\_spectating::init();
	thread maps\mp\gametypes\_objpoints::init();
	thread maps\mp\gametypes\_gameobjects::init();
	thread maps\mp\gametypes\_spawnlogic::init();
	thread maps\mp\gametypes\_battlechatter_mp::init();
	thread maps\mp\gametypes\_music_and_dialog::init();
	thread maps\mp\_matchdata::init();
	thread maps\mp\_awards::init();
	thread maps\mp\_skill::init();
	thread maps\mp\_areas::init();
	thread maps\mp\killstreaks\_killstreaks::init();
	thread maps\mp\perks\_perks::init();
	thread maps\mp\_events::init();
	thread maps\mp\_defcon::init();
	if(level.teambased)
	{
		thread maps\mp\gametypes\_friendicons::init();
	}

	thread maps\mp\gametypes\_hud_message::init();
	if(!level.console)
	{
		thread maps\mp\gametypes\_quickmessages::init();
	}

	foreach(locstring in game["strings"])
	{
		precachestring(locstring);
	}

	foreach(icon in game["icons"])
	{
		precacheshader(icon);
	}

	game["gamestarted"] = 1;
	level.maxplayercount = 0;
	level.wavedelay["allies"] = 0;
	level.wavedelay["axis"] = 0;
	level.lastwave["allies"] = 0;
	level.lastwave["axis"] = 0;
	level.waveplayerspawnindex["allies"] = 0;
	level.waveplayerspawnindex["axis"] = 0;
	level.aliveplayers["allies"] = [];
	level.aliveplayers["axis"] = [];
	level.activeplayers = [];
	makedvarserverinfo("ui_scorelimit", 0);
	makedvarserverinfo("ui_allow_classchange", getdvar("ui_allow_classchange"));
	makedvarserverinfo("ui_allow_teamchange", 1);
	setdvar("ui_allow_teamchange", 1);
	if(maps\mp\_utility::getgametypenumlives())
	{
		setdvar("g_deadChat", 0);
	}
	else
	{
		setdvar("g_deadChat", 1);
	}

	wavedelay = getdvarint("scr_" + level.gametype + "_waverespawndelay");
	if(wavedelay)
	{
		level.wavedelay["allies"] = wavedelay;
		level.wavedelay["axis"] = wavedelay;
		level.lastwave["allies"] = 0;
		level.lastwave["axis"] = 0;
		level thread wavespawntimer();
	}

	maps\mp\_utility::gameflaginit("prematch_done", 0);
	level.graceperiod = 15;
	level.ingraceperiod = level.graceperiod;
	maps\mp\_utility::gameflaginit("graceperiod_done", 0);
	level.roundenddelay = 4;
	level.halftimeroundenddelay = 4;
	if(level.teambased)
	{
		maps\mp\gametypes\_gamescore::updateteamscore("axis");
		maps\mp\gametypes\_gamescore::updateteamscore("allies");
	}
	else
	{
		thread maps\mp\gametypes\_gamescore::initialdmscoreupdate();
	}

	thread updateuiscorelimit();
	level notify("update_scorelimit");
	[[ level.onstartgametype ]]();
	thread startgame();
	level thread maps\mp\_utility::updatewatcheddvars();
	level thread timelimitthread();
}

callback_codeendgame()
{
	print3d();
	if(!level.gameended)
	{
		level thread forceend();
		return;
	}
}

timelimitthread()
{
	level endon("game_ended");
	prevtimepassed = maps\mp\_utility::gettimepassed();
	while(game["state"] == "playing")
	{
		thread checktimelimit(prevtimepassed);
		prevtimepassed = maps\mp\_utility::gettimepassed();
		if(isdefined(level.starttime))
		{
			if(gettimeremaining() < 3000)
			{
				wait 0.1;
				continue;
			}
		}

		wait 1;
	}
}

updateuiscorelimit()
{
	for(;;)
	{
		level common_scripts\utility::waittill_either("update_scorelimit", "update_winlimit");
		if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased())
		{
			setdvar("ui_scorelimit", maps\mp\_utility::getwatcheddvar("scorelimit"));
			thread checkscorelimit();
			continue;
		}

		setdvar("ui_scorelimit", maps\mp\_utility::getwatcheddvar("winlimit"));
	}
}

playtickingsound()
{
	self endon("death");
	self endon("stop_ticking");
	level endon("game_ended");
	time = level.bombtimer;
	for(;;)
	{
		self playsound("ui_mp_suitcasebomb_timer");
		if(time > 10)
		{
			time = time - 1;
			wait 1;
		}
		else if(time > 4)
		{
			time = time - 0.5;
			wait 0.5;
		}
		else if(time > 1)
		{
			time = time - 0.4;
			wait 0.4;
		}
		else
		{
			time = time - 0.3;
			wait 0.3;
		}

		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

stoptickingsound()
{
	self notify("stop_ticking");
}

timelimitclock()
{
	level endon("game_ended");
	wait 0.05;
	clockobject = spawn("script_origin", (0,0,0));
	clockobject hide();
	while(game["state"] == "playing")
	{
		if(!level.timerstopped && maps\mp\_utility::gettimelimit())
		{
			timeleft = gettimeremaining() / 1000;
			timeleftint = int(timeleft + 0.5);
			if(maps\mp\_utility::gethalftime() && timeleftint > maps\mp\_utility::gettimelimit() * 60 * 0.5)
			{
				timeleftint = timeleftint - int(maps\mp\_utility::gettimelimit() * 60 * 0.5);
			}

			if(timeleftint >= 30 && timeleftint <= 60)
			{
				level notify("match_ending_soon", "time");
			}

			if(timeleftint <= 10 || timeleftint <= 30 && timeleftint % 2 == 0)
			{
				level notify("match_ending_very_soon");
				if(timeleftint == 0)
				{
					break;
				}

				clockobject playsound("ui_mp_timer_countdown");
			}

			if(timeleft - floor(timeleft) >= 0.05)
			{
				wait timeleft - floor(timeleft);
			}
		}

		wait 1;
	}
}

gametimer()
{
	level endon("game_ended");
	level waittill("prematch_over");
	level.starttime = gettime();
	level.discardtime = 0;
	if(isdefined(game["roundMillisecondsAlreadyPassed"]))
	{
		level.starttime = level.starttime - game["roundMillisecondsAlreadyPassed"];
		game["roundMillisecondsAlreadyPassed"] = undefined;
	}

	prevtime = gettime();
	while(game["state"] == "playing")
	{
		if(!level.timerstopped)
		{
			game["timePassed"] = game["timePassed"] + gettime() - prevtime;
		}

		prevtime = gettime();
		wait 1;
	}
}

updatetimerpausedness()
{
	shouldbestopped = level.timerstoppedforgamemode || isdefined(level.hostmigrationtimer);
	if(!maps\mp\_utility::gameflag("prematch_done"))
	{
		shouldbestopped = 0;
	}

	if(!level.timerstopped && shouldbestopped)
	{
		level.timerstopped = 1;
		level.timerpausetime = gettime();
		return;
	}

	if(level.timerstopped && !shouldbestopped)
	{
		level.timerstopped = 0;
		level.discardtime = level.discardtime + gettime() - level.timerpausetime;
		return;
	}
}

pausetimer()
{
	level.timerstoppedforgamemode = 1;
	updatetimerpausedness();
}

resumetimer()
{
	level.timerstoppedforgamemode = 0;
	updatetimerpausedness();
}

startgame()
{
	thread gametimer();
	level.timerstopped = 0;
	level.timerstoppedforgamemode = 0;
	thread maps\mp\gametypes\_spawnlogic::spawnperframeupdate();
	prematchperiod();
	maps\mp\_utility::gameflagset("prematch_done");
	level notify("prematch_over");
	updatetimerpausedness();
	thread timelimitclock();
	thread graceperiod();
	thread maps\mp\gametypes\_missions::roundbegin();
}

wavespawntimer()
{
	level endon("game_ended");
	while(game["state"] == "playing")
	{
		time = gettime();
		if(time - level.lastwave["allies"] > level.wavedelay["allies"] * 1000)
		{
			level notify("wave_respawn_allies");
			level.lastwave["allies"] = time;
			level.waveplayerspawnindex["allies"] = 0;
		}

		if(time - level.lastwave["axis"] > level.wavedelay["axis"] * 1000)
		{
			level notify("wave_respawn_axis");
			level.lastwave["axis"] = time;
			level.waveplayerspawnindex["axis"] = 0;
		}

		wait 0.05;
	}
}

getbetterteam()
{
	kills["allies"] = 0;
	kills["axis"] = 0;
	deaths["allies"] = 0;
	deaths["axis"] = 0;
	foreach(player in level.players)
	{
		team = player.pers["team"];
		if(isdefined(team) && team == "allies" || team == "axis")
		{
			kills[team] = kills[team] + player.kills;
			deaths[team] = deaths[team] + player.deaths;
		}
	}

	if(kills["allies"] > kills["axis"])
	{
		return "allies";
	}
	else if(kills["axis"] > kills["allies"])
	{
		return "axis";
	}

	if(deaths["allies"] < deaths["axis"])
	{
		return "allies";
	}
	else if(deaths["axis"] < deaths["allies"])
	{
		return "axis";
	}

	if(randomint(2) == 0)
	{
		return "allies";
	}

	return "axis";
}

rankedmatchupdates(winner)
{
	if(maps\mp\_utility::matchmakinggame())
	{
		setxenonranks();
		if(hostidledout())
		{
			level.hostforcedend = 1;
			logstring("host idled out");
			endlobby();
		}

		updatematchbonusscores(winner);
	}

	updatewinlossstats(winner);
}

displayroundend(winner, endreasontext)
{
	foreach(player in level.players)
	{
		if(isdefined(player.connectedpostgame) || player.pers["team"] == "spectator")
		{
			continue;
		}

		if(level.teambased)
		{
			player thread maps\mp\gametypes\_hud_message::teamoutcomenotify(winner, 1, endreasontext);
			continue;
		}

		player thread maps\mp\gametypes\_hud_message::outcomenotify(winner, endreasontext);
	}

	if(!maps\mp\_utility::waslastround())
	{
		level notify("round_win", winner);
	}

	if(maps\mp\_utility::waslastround())
	{
		roundendwait(level.roundenddelay, 0);
		return;
	}

	roundendwait(level.roundenddelay, 1);
}

displaygameend(winner, endreasontext)
{
	foreach(player in level.players)
	{
		if(isdefined(player.connectedpostgame) || player.pers["team"] == "spectator")
		{
			continue;
		}

		if(level.teambased)
		{
			player thread maps\mp\gametypes\_hud_message::teamoutcomenotify(winner, 0, endreasontext);
			continue;
		}

		player thread maps\mp\gametypes\_hud_message::outcomenotify(winner, endreasontext);
	}

	level notify("game_win", winner);
	roundendwait(level.postroundtime, 1);
}

displayroundswitch()
{
	switchtype = level.halftimetype;
	if(switchtype == "halftime")
	{
		if(maps\mp\_utility::getwatcheddvar("roundlimit"))
		{
			if(game["roundsPlayed"] * 2 == maps\mp\_utility::getwatcheddvar("roundlimit"))
			{
				switchtype = "halftime";
			}
			else
			{
				switchtype = "intermission";
			}
		}
		else if(maps\mp\_utility::getwatcheddvar("winlimit"))
		{
			if(game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1)
			{
				switchtype = "halftime";
			}
			else
			{
				switchtype = "intermission";
			}
		}
		else
		{
			switchtype = "intermission";
		}
	}

	level notify("round_switch", switchtype);
	foreach(player in level.players)
	{
		if(isdefined(player.connectedpostgame) || player.pers["team"] == "spectator")
		{
			continue;
		}

		player thread maps\mp\gametypes\_hud_message::teamoutcomenotify(switchtype, 1, level.halftimesubcaption);
	}

	roundendwait(level.halftimeroundenddelay, 0);
}

endgameovertime(winner, endreasontext)
{
	foreach(player in level.players)
	{
		player thread freezeplayerforroundend(0);
		player thread roundenddof(4);
		player freegameplayhudelems();
		player setclientdvars("cg_everyoneHearsEveryone", 1);
		player setclientdvars("cg_drawSpectatorMessages", 0, "g_compassShowEnemies", 0);
		if(player.pers["team"] == "spectator")
		{
			player thread maps\mp\gametypes\_playerlogic::spawnintermission();
		}
	}

	level notify("round_switch", "overtime");
	foreach(player in level.players)
	{
		if(isdefined(player.connectedpostgame) || player.pers["team"] == "spectator")
		{
			continue;
		}

		if(level.teambased)
		{
			player thread maps\mp\gametypes\_hud_message::teamoutcomenotify(winner, 0, endreasontext);
			continue;
		}

		player thread maps\mp\gametypes\_hud_message::outcomenotify(winner, endreasontext);
	}

	roundendwait(level.roundenddelay, 0);
	game["status"] = "overtime";
	level notify("restarting");
	game["state"] = "playing";
	map_restart(1);
}

endgamehalftime()
{
	visionsetnaked("mpOutro", 0.5);
	setdvar("scr_gameended", 2);
	game["switchedsides"] = !game["switchedsides"];
	foreach(player in level.players)
	{
		player thread freezeplayerforroundend(0);
		player thread roundenddof(4);
		player freegameplayhudelems();
		player setclientdvars("cg_everyoneHearsEveryone", 1);
		player setclientdvars("cg_drawSpectatorMessages", 0, "g_compassShowEnemies", 0);
		if(player.pers["team"] == "spectator")
		{
			player thread maps\mp\gametypes\_playerlogic::spawnintermission();
		}
	}

	foreach(player in level.players)
	{
		player.pers["stats"] = player.stats;
	}

	level notify("round_switch", "halftime");
	foreach(player in level.players)
	{
		if(isdefined(player.connectedpostgame) || player.pers["team"] == "spectator")
		{
			continue;
		}

		player thread maps\mp\gametypes\_hud_message::teamoutcomenotify("halftime", 1, level.halftimesubcaption);
	}

	roundendwait(level.roundenddelay, 0);
	game["status"] = "halftime";
	level notify("restarting");
	game["state"] = "playing";
	map_restart(1);
}

endgame(winner, endreasontext, nukedetonated)
{
	if(!isdefined(nukedetonated))
	{
		nukedetonated = 0;
	}

	if(game["state"] == "postgame" || level.gameended || isdefined(level.nukeincoming) && !nukedetonated && !isdefined(level.gtnw) || !level.gtnw)
	{
		return;
	}

	game["state"] = "postgame";
	level.gameendtime = gettime();
	level.gameended = 1;
	level.ingraceperiod = 0;
	level notify("game_ended", winner);
	maps\mp\_utility::levelflagset("game_over");
	maps\mp\_utility::levelflagset("block_notifies");
	common_scripts\utility::waitframe();
	setgameendtime(0);
	maps\mp\gametypes\_playerlogic::printpredictedspawnpointcorrectness();
	if(isdefined(winner) && isstring(winner) && winner == "overtime")
	{
		endgameovertime(winner, endreasontext);
		return;
	}

	if(isdefined(winner) && isstring(winner) && winner == "halftime")
	{
		endgamehalftime();
		return;
	}

	game["roundsPlayed"]++;
	if(level.teambased)
	{
		if(winner == "axis" || winner == "allies")
		{
			game["roundsWon"][winner]++;
		}

		maps\mp\gametypes\_gamescore::updateteamscore("axis");
		maps\mp\gametypes\_gamescore::updateteamscore("allies");
	}
	else if(isdefined(winner) && isplayer(winner))
	{
		game["roundsWon"][winner.guid]++;
	}

	maps\mp\gametypes\_gamescore::updateplacement();
	rankedmatchupdates(winner);
	foreach(player in level.players)
	{
		player setclientdvar("ui_opensummary", 1);
	}

	setdvar("g_deadChat", 1);
	setdvar("ui_allow_teamchange", 0);
	foreach(player in level.players)
	{
		player thread freezeplayerforroundend(1);
		player thread roundenddof(4);
		player freegameplayhudelems();
		player setclientdvars("cg_everyoneHearsEveryone", 1);
		player setclientdvars("cg_drawSpectatorMessages", 0, "g_compassShowEnemies", 0, "cg_fovScale", 1);
		if(player.pers["team"] == "spectator")
		{
			player thread maps\mp\gametypes\_playerlogic::spawnintermission();
		}
	}

	if(!nukedetonated)
	{
		visionsetnaked("mpOutro", 0.5);
	}

	if(!maps\mp\_utility::wasonlyround() && !nukedetonated)
	{
		setdvar("scr_gameended", 2);
		displayroundend(winner, endreasontext);
		if(level.showingfinalkillcam)
		{
			foreach(player in level.players)
			{
				player notify("reset_outcome");
			}

			level notify("game_cleanup");
			waittillfinalkillcamdone();
		}

		if(!maps\mp\_utility::waslastround())
		{
			maps\mp\_utility::levelflagclear("block_notifies");
			if(checkroundswitch())
			{
				displayroundswitch();
			}

			foreach(player in level.players)
			{
				player.pers["stats"] = player.stats;
			}

			level notify("restarting");
			game["state"] = "playing";
			map_restart(1);
			return;
		}

		if(!level.forcedend)
		{
			endreasontext = updateendreasontext(winner);
		}
	}

	setdvar("scr_gameended", 1);
	if(!isdefined(game["clientMatchDataDef"]))
	{
		game["clientMatchDataDef"] = "mp/clientmatchdata.def";
		setclientmatchdatadef(game["clientMatchDataDef"]);
	}

	maps\mp\gametypes\_missions::roundend(winner);
	displaygameend(winner, endreasontext);
	if(level.showingfinalkillcam && maps\mp\_utility::wasonlyround())
	{
		foreach(player in level.players)
		{
			player notify("reset_outcome");
		}

		level notify("game_cleanup");
		waittillfinalkillcamdone();
	}

	maps\mp\_utility::levelflagclear("block_notifies");
	level.intermission = 1;
	level notify("spawning_intermission");
	foreach(player in level.players)
	{
		player closepopupmenu();
		player closeingamemenu();
		player notify("reset_outcome");
		player thread maps\mp\gametypes\_playerlogic::spawnintermission();
	}

	processlobbydata();
	wait 1;
	if(maps\mp\_utility::matchmakinggame())
	{
		print3d();
	}

	foreach(player in level.players)
	{
		player.pers["stats"] = player.stats;
	}

	if(!nukedetonated && !level.postgamenotifies)
	{
		if(!maps\mp\_utility::wasonlyround())
		{
			wait 6;
		}
		else
		{
			wait 3;
		}
	}
	else
	{
		wait min(10, 4 + level.postgamenotifies);
	}

	level notify("exitLevel_called");
	exitlevel(0);
}

updateendreasontext(winner)
{
	if(!level.teambased)
	{
		return 1;
	}

	if(maps\mp\_utility::hitroundlimit())
	{
		return &"MP_ROUND_LIMIT_REACHED";
	}

	if(maps\mp\_utility::hitwinlimit())
	{
		return &"MP_SCORE_LIMIT_REACHED";
	}

	if(winner == "axis")
	{
		return &"SPETSNAZ_WIN";
	}

	return &"SAS_WIN";
}

estimatedtimetillscorelimit(team)
{
	scoreperminute = getscoreperminute(team);
	scoreremaining = getscoreremaining(team);
	estimatedtimeleft = 999999;
	if(scoreperminute)
	{
		estimatedtimeleft = scoreremaining / scoreperminute;
	}

	return estimatedtimeleft;
}

getscoreperminute(team)
{
	scorelimit = maps\mp\_utility::getwatcheddvar("scorelimit");
	timelimit = maps\mp\_utility::gettimelimit();
	minutespassed = maps\mp\_utility::gettimepassed() / -5536 + 0.0001;
	if(isplayer(self))
	{
		scoreperminute = self.score / minutespassed;
	}
	else
	{
		scoreperminute = getteamscore(team) / minutespassed;
	}

	return scoreperminute;
}

getscoreremaining(team)
{
	scorelimit = maps\mp\_utility::getwatcheddvar("scorelimit");
	if(isplayer(self))
	{
		scoreremaining = scorelimit - self.score;
	}
	else
	{
		scoreremaining = scorelimit - getteamscore(team);
	}

	return scoreremaining;
}

givelastonteamwarning()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::waittillrecoveredhealth(3);
	otherteam = maps\mp\_utility::getotherteam(self.pers["team"]);
	thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
	thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, otherteam);
	level notify("last_alive", self);
}

processlobbydata()
{
	curplayer = 0;
	foreach(player in level.players)
	{
		if(!isdefined(player))
		{
			continue;
		}

		player.clientmatchdataid = curplayer;
		curplayer++;
		if(level.ps3 && player.name.size > level.maxnamelength)
		{
			playername = "";
			for(i = 0;i < level.maxnamelength - 3;i++)
			{
				playername = playername + player.name[i];
			}

			playername = playername + "...";
		}
		else
		{
			playername = player.name;
		}

		setclientmatchdata("players", player.clientmatchdataid, "xuid", playername);
	}

	maps\mp\_awards::assignawards();
	maps\mp\_scoreboard::processlobbyscoreboards();
	sendclientmatchdata();
}