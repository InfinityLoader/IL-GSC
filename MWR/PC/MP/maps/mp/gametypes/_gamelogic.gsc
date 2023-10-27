/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gamelogic.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 111
 * Decompile Time: 2013 ms
 * Timestamp: 10/27/2023 2:41:24 AM
*******************************************************************/

//Function Number: 1
onforfeit(param_00)
{
	if(isdefined(level.forfeitinprogress))
	{
		return;
	}

	level endon("abort_forfeit");
	level thread forfeitwaitforabort();
	level.forfeitinprogress = 1;
	if(!level.teambased && level.players.size > 1)
	{
		wait(10);
	}
	else
	{
		wait(1.05);
	}

	level.forfeit_aborted = 0;
	var_01 = 20;
	matchforfeittimer(var_01);
	var_02 = &"";
	if(!isdefined(param_00))
	{
		level.finalkillcam_winner = "none";
		var_02 = game["end_reason"]["players_forfeited"];
		var_03 = level.players[0];
	}
	else if(var_01 == "axis")
	{
		level.finalkillcam_winner = "axis";
		var_03 = game["end_reason"]["allies_forfeited"];
		if(level.gametype == "infect")
		{
			var_03 = game["end_reason"]["survivors_forfeited"];
		}

		var_03 = "axis";
	}
	else if(var_01 == "allies")
	{
		level.finalkillcam_winner = "allies";
		var_03 = game["end_reason"]["axis_forfeited"];
		if(level.gametype == "infect")
		{
			var_03 = game["end_reason"]["infected_forfeited"];
		}

		var_03 = "allies";
	}
	else if(level.multiteambased && issubstr(var_01,"team_"))
	{
		var_03 = var_01;
	}
	else
	{
		level.finalkillcam_winner = "none";
		var_03 = "tie";
	}

	level.forcedend = 1;
	if(isplayer(var_03))
	{
		logstring("forfeit, win: " + var_03 getxuid() + "(" + var_03.name + ")");
	}
	else
	{
		logstring("forfeit, win: " + var_03 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}

	thread endgame(var_03,var_02);
}

//Function Number: 2
forfeitwaitforabort()
{
	level endon("game_ended");
	level waittill("abort_forfeit");
	level.forfeit_aborted = 1;
	setomnvar("ui_match_countdown",0);
	setomnvar("ui_match_countdown_title",0);
	setomnvar("ui_match_countdown_toggle",0);
}

//Function Number: 3
matchforfeittimer_internal(param_00)
{
	waittillframeend;
	level endon("match_forfeit_timer_beginning");
	setomnvar("ui_match_countdown_title",3);
	setomnvar("ui_match_countdown_toggle",1);
	while(param_00 > 0 && !level.gameended && !level.forfeit_aborted && !level.ingraceperiod)
	{
		setomnvar("ui_match_countdown",param_00);
		wait(1);
		param_00--;
	}
}

//Function Number: 4
matchforfeittimer(param_00)
{
	level notify("match_forfeit_timer_beginning");
	var_01 = int(param_00);
	matchforfeittimer_internal(var_01);
	setomnvar("ui_match_countdown",0);
	setomnvar("ui_match_countdown_title",0);
	setomnvar("ui_match_countdown_toggle",0);
}

//Function Number: 5
default_ondeadevent(param_00)
{
	level.finalkillcam_winner = "none";
	if(param_00 == "allies")
	{
		logstring("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
		level.finalkillcam_winner = "axis";
		thread endgame("axis",game["end_reason"]["allies_eliminated"]);
		return;
	}

	if(param_00 == "axis")
	{
		logstring("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
		level.finalkillcam_winner = "allies";
		thread endgame("allies",game["end_reason"]["axis_eliminated"]);
		return;
	}

	logstring("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	level.finalkillcam_winner = "none";
	if(level.teambased)
	{
		thread endgame("tie",game["end_reason"]["tie"]);
		return;
	}

	thread endgame(undefined,game["end_reason"]["tie"]);
}

//Function Number: 6
default_ononeleftevent(param_00)
{
	if(level.teambased)
	{
		var_01 = maps\mp\_utility::getlastlivingplayer(param_00);
		var_01 thread givelastonteamwarning();
	}
	else
	{
		var_01 = maps\mp\_utility::getlastlivingplayer();
		logstring("last one alive, win: " + var_01.name);
		level.finalkillcam_winner = "none";
		thread endgame(var_01,game["end_reason"]["enemies_eliminated"]);
	}

	return 1;
}

//Function Number: 7
default_ontimelimit()
{
	var_00 = undefined;
	level.finalkillcam_winner = "none";
	if(level.teambased)
	{
		if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
		{
			var_00 = "tie";
		}
		else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			level.finalkillcam_winner = "axis";
			var_00 = "axis";
		}
		else
		{
			level.finalkillcam_winner = "allies";
			var_00 = "allies";
		}

		logstring("time limit, win: " + var_00 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		var_00 = maps\mp\gametypes\_gamescores::gethighestscoringplayer();
		if(isdefined(var_00))
		{
			logstring("time limit, win: " + var_00.name);
		}
		else
		{
			logstring("time limit, tie");
		}
	}

	thread endgame(var_00,game["end_reason"]["time_limit_reached"]);
}

//Function Number: 8
default_onhalftime(param_00)
{
	var_01 = undefined;
	level.finalkillcam_winner = "none";
	thread endgame("halftime",game["end_reason"][param_00]);
}

//Function Number: 9
forceend()
{
	if(level.hostforcedend || level.forcedend)
	{
		return;
	}

	var_00 = undefined;
	level.finalkillcam_winner = "none";
	if(level.teambased)
	{
		if(isdefined(level.ishorde))
		{
			var_00 = "axis";
		}
		else if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
		{
			var_00 = "tie";
		}
		else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			level.finalkillcam_winner = "axis";
			var_00 = "axis";
		}
		else
		{
			level.finalkillcam_winner = "allies";
			var_00 = "allies";
		}

		logstring("host ended game, win: " + var_00 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		var_00 = maps\mp\gametypes\_gamescores::gethighestscoringplayer();
		if(isdefined(var_00))
		{
			logstring("host ended game, win: " + var_00.name);
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
		var_01 = game["end_reason"]["ended_game"];
	}
	else
	{
		var_01 = game["end_reason"]["host_ended_game"];
	}

	setnojiptime(1);
	thread endgame(var_00,var_01);
}

//Function Number: 10
onscorelimit()
{
	var_00 = game["end_reason"]["score_limit_reached"];
	var_01 = undefined;
	level.finalkillcam_winner = "none";
	if(level.multiteambased)
	{
		var_01 = maps\mp\gametypes\_gamescores::getwinningteam();
		if(var_01 == "none")
		{
			var_01 = "tie";
		}
	}
	else if(level.teambased)
	{
		if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
		{
			var_01 = "tie";
		}
		else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			var_01 = "axis";
			level.finalkillcam_winner = "axis";
		}
		else
		{
			var_01 = "allies";
			level.finalkillcam_winner = "allies";
		}

		logstring("scorelimit, win: " + var_01 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		var_01 = maps\mp\gametypes\_gamescores::gethighestscoringplayer();
		if(isdefined(var_01))
		{
			logstring("scorelimit, win: " + var_01.name);
		}
		else
		{
			logstring("scorelimit, tie");
		}
	}

	thread endgame(var_01,var_00);
}

//Function Number: 11
updategameevents()
{
	if(maps\mp\_utility::matchmakinggame() && !level.ingraceperiod && !getdvarint("force_ranking") && !isdefined(level.disableforfeit) || !level.disableforfeit && !maps\mp\_utility::invirtuallobby())
	{
		if(level.multiteambased)
		{
			var_00 = 0;
			var_01 = 0;
			for(var_02 = 0;var_02 < level.teamnamelist.size;var_02++)
			{
				var_00 = var_00 + level.teamcount[level.teamnamelist[var_02]];
				if(level.teamcount[level.teamnamelist[var_02]])
				{
					var_01 = var_01 + 1;
				}
			}

			for(var_02 = 0;var_02 < level.teamnamelist.size;var_02++)
			{
				if(var_00 == level.teamcount[level.teamnamelist[var_02]] && game["state"] == "playing")
				{
					thread onforfeit(level.teamnamelist[var_02]);
					return;
				}
			}

			if(var_01 > 1)
			{
				level.forfeitinprogress = undefined;
				level notify("abort_forfeit");
			}
		}
		else if(level.teambased)
		{
			if(level.teamcount["allies"] < 1 && level.teamcount["axis"] > 0 && game["state"] == "playing")
			{
				thread onforfeit("axis");
				return;
			}

			if(level.teamcount["axis"] < 1 && level.teamcount["allies"] > 0 && game["state"] == "playing")
			{
				thread onforfeit("allies");
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
			if(level.teamcount["allies"] + level.teamcount["axis"] == 1 && game["state"] == "playing")
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

	if(isdefined(level.ongameeventlives))
	{
		self [[ level.ongameeventlives ]]();
		return;
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

	if(level.multiteambased)
	{
		return;
	}

	if(level.teambased)
	{
		var_03["allies"] = level.livescount["allies"];
		var_03["axis"] = level.livescount["axis"];
		if(isdefined(level.disablespawning) && level.disablespawning)
		{
			var_03["allies"] = 0;
			var_03["axis"] = 0;
		}

		if(!level.alivecount["allies"] && !level.alivecount["axis"] && !var_03["allies"] && !var_03["axis"])
		{
			return [[ level.ondeadevent ]]("all");
		}

		if(!level.alivecount["allies"] && !var_03["allies"])
		{
			return [[ level.ondeadevent ]]("allies");
		}

		if(!level.alivecount["axis"] && !var_03["axis"])
		{
			return [[ level.ondeadevent ]]("axis");
		}

		var_04 = level.alivecount["allies"] == 1 && !var_03["allies"];
		var_05 = level.alivecount["axis"] == 1 && !var_03["axis"];
		if((var_04 || var_05) && !isdefined(level.bot_spawn_from_devgui_in_progress))
		{
			var_06 = undefined;
			if(var_04 && !isdefined(level.onelefttime["allies"]))
			{
				level.onelefttime["allies"] = gettime();
				var_07 = [[ level.ononeleftevent ]]("allies");
				if(isdefined(var_07))
				{
					if(!isdefined(var_06))
					{
						var_06 = var_07;
					}

					var_06 = var_06 || var_07;
				}
			}

			if(var_05 && !isdefined(level.onelefttime["axis"]))
			{
				level.onelefttime["axis"] = gettime();
				var_08 = [[ level.ononeleftevent ]]("axis");
				if(isdefined(var_08))
				{
					if(!isdefined(var_06))
					{
						var_06 = var_08;
					}

					var_06 = var_06 || var_08;
				}
			}

			return var_06;
		}

		return;
	}

	if(!level.alivecount["allies"] && !level.alivecount["axis"] && !level.livescount["allies"] && !level.livescount["axis"])
	{
		return [[ level.ondeadevent ]]("all");
	}

	var_09 = maps\mp\_utility::getpotentiallivingplayers();
	if(var_09.size == 1)
	{
		return [[ level.ononeleftevent ]]("all");
	}
}

//Function Number: 12
waittillfinalkillcamdone()
{
	if(!isdefined(level.finalkillcam_winner))
	{
		return 0;
	}

	level waittill("final_killcam_done");
	return 1;
}

//Function Number: 13
timelimitclock_intermission(param_00)
{
	setgameendtime(gettime() + int(param_00 * 1000));
	var_01 = spawn("script_origin",(0,0,0));
	var_01 hide();
	if(param_00 >= 10)
	{
		wait(param_00 - 10);
	}

	for(;;)
	{
		var_01 playsound("ui_mp_timer_countdown");
		wait(1);
	}
}

//Function Number: 14
waitforplayers(param_00)
{
	var_01 = gettime();
	var_02 = var_01 + param_00 * 1000 - 200;
	if(param_00 > 5)
	{
		var_03 = gettime() + getdvarint("min_wait_for_players") * 1000;
	}
	else
	{
		var_03 = 0;
	}

	if(isdefined(level.iszombiegame) && level.iszombiegame)
	{
		var_04 = level.connectingplayers;
	}
	else
	{
		var_04 = level.connectingplayers / 3;
	}

	var_05 = 0;
	for(;;)
	{
		if(isdefined(game["roundsPlayed"]) && game["roundsPlayed"])
		{
			break;
		}

		var_06 = level.maxplayercount;
		var_07 = gettime();
		if((var_06 >= var_04 && var_07 > var_03) || var_07 > var_02)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 15
prematchperiod()
{
	level endon("game_ended");
	level.connectingplayers = getdvarint("party_partyPlayerCountNum");
	if(level.prematchperiod > 0)
	{
		level.waitingforplayers = 1;
		matchstarttimerwaitforplayers();
		level.waitingforplayers = 0;
	}
	else
	{
		matchstarttimerskip();
	}

	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] maps\mp\_utility::freezecontrolswrapper(0);
		level.players[var_00] enableweapons();
		level.players[var_00] enableammogeneration();
		var_01 = maps\mp\_utility::getobjectivehinttext(level.players[var_00].pers["team"]);
		if(!isdefined(var_01) || !level.players[var_00].hasspawned)
		{
			continue;
		}

		level.players[var_00] thread maps\mp\gametypes\_hud_message::hintmessage(var_01);
	}

	if(game["state"] != "playing")
	{
	}
}

//Function Number: 16
graceperiod()
{
	level endon("game_ended");
	if(!isdefined(game["clientActive"]))
	{
		while(getactiveclientcount() == 0)
		{
			wait(0.05);
		}

		game["clientActive"] = 1;
	}

	while(level.ingraceperiod > 0)
	{
		wait(1);
		level.ingraceperiod--;
	}

	level notify("grace_period_ending");
	wait(0.05);
	maps\mp\_utility::gameflagset("graceperiod_done");
	level.ingraceperiod = 0;
	if(game["state"] != "playing")
	{
		return;
	}

	level thread updategameevents();
}

//Function Number: 17
sethasdonecombat(param_00,param_01)
{
	param_00 notify("hasDoneCombat");
	param_00.hasdonecombat = param_01;
	if(!hasdoneanycombat(param_00) && param_01)
	{
		param_00.pers["hasDoneAnyCombat"] = 1;
		if(isdefined(param_00.pers["hasMatchLoss"]) && param_00.pers["hasMatchLoss"])
		{
			return;
		}

		updatelossstats(param_00);
	}
}

//Function Number: 18
hasdoneanycombat(param_00)
{
	return isdefined(param_00.pers["hasDoneAnyCombat"]);
}

//Function Number: 19
updatewinstats(param_00)
{
	if(!param_00 maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(!hasdoneanycombat(param_00) && !level.gametype == "infect" && !maps\mp\_utility::ishodgepodgeph())
	{
		return;
	}

	param_00 maps\mp\gametypes\_persistence::statadd("losses",-1);
	param_00 maps\mp\gametypes\_persistence::statadd("wins",1);
	param_00 maps\mp\_utility::updatepersratio("winLossRatio","wins","losses");
	param_00 maps\mp\gametypes\_persistence::statadd("currentWinStreak",1);
	var_01 = param_00 maps\mp\gametypes\_persistence::statget("currentWinStreak");
	if(var_01 > param_00 maps\mp\gametypes\_persistence::statget("winStreak"))
	{
		param_00 maps\mp\gametypes\_persistence::statset("winStreak",var_01);
	}

	param_00 maps\mp\gametypes\_persistence::statsetchild("round","win",1);
	param_00 maps\mp\gametypes\_persistence::statsetchild("round","loss",0);
	param_00 maps\mp\gametypes\_misions::processchallenge("ch_" + level.gametype + "_wins");
	param_00.combatrecordwin = 1;
	var_02 = maps\mp\_utility::getmapname();
	if(var_02 == "mp_crash_snow")
	{
		param_00 maps\mp\gametypes\_misions::processchallenge("ch_wc_wins");
	}
	else if(var_02 == "mp_farm_spring")
	{
		param_00 maps\mp\gametypes\_misions::processchallenge("ch_stpatty_wins");
	}
	else if(var_02 == "mp_bog_summer")
	{
		param_00 maps\mp\gametypes\_misions::processchallenge("ch_summer_wins");
	}

	if(level.players.size > 5)
	{
		superstarchallenge(param_00);
		switch(level.gametype)
		{
			case "war":
				break;

			case "hp":
				break;

			case "conf":
				break;

			case "ball":
				break;

			case "infect":
				break;

			case "dm":
				break;

			case "gun":
				break;

			case "twar":
			case "ctf":
				break;
		}
	}
}

//Function Number: 20
superstarchallenge(param_00)
{
	var_01 = 0;
	var_02 = 9999;
	foreach(var_04 in level.players)
	{
		if(var_04.kills > var_01)
		{
			var_01 = var_04.kills;
		}

		if(var_04.deaths < var_02)
		{
			var_02 = var_04.deaths;
		}
	}

	if(param_00.kills >= var_01 && param_00.deaths <= var_02 && param_00.kills > 0 && !isai(param_00))
	{
		param_00 maps\mp\gametypes\_misions::processchallenge("ch_superstar");
	}
}

//Function Number: 21
checkgameendchallenges()
{
	if(level.gametype == "dom")
	{
		var_00 = level.domflags;
		var_06 = getfirstarraykey(var_00);
		if(isdefined(var_06))
		{
			var_01 = var_00[var_06];
			if(!isdefined(var_01.ownedtheentireround) || !var_01.ownedtheentireround)
			{
				continue;
			}

			var_02 = var_01 maps\mp\gametypes\_gameobjects::getownerteam();
			var_03 = level.players;
			var_05 = getfirstarraykey(var_03);
			if(isdefined(var_05))
			{
				var_04 = var_03[var_05];
				if(var_04.team != var_02)
				{
					continue;
				}

				switch(var_01.label)
				{
					case "_a":
						break;

					case "_b":
						break;

					case "_c":
						break;
				}
			}
		}
	}
}

//Function Number: 22
updatelossstats(param_00)
{
	if(!param_00 maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(!hasdoneanycombat(param_00) && !maps\mp\_utility::ishodgepodgeph())
	{
		return;
	}

	param_00.pers["hasMatchLoss"] = 1;
	param_00 maps\mp\gametypes\_persistence::statadd("losses",1);
	param_00 maps\mp\_utility::updatepersratio("winLossRatio","wins","losses");
	param_00 maps\mp\gametypes\_persistence::statadd("gamesPlayed",1);
	param_00 maps\mp\gametypes\_persistence::statsetchild("round","loss",1);
}

//Function Number: 23
updatetiestats(param_00)
{
	if(!param_00 maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(!hasdoneanycombat(param_00) && !maps\mp\_utility::ishodgepodgeph())
	{
		return;
	}

	param_00 maps\mp\gametypes\_persistence::statadd("losses",-1);
	param_00 maps\mp\gametypes\_persistence::statadd("ties",1);
	param_00 maps\mp\_utility::updatepersratio("winLossRatio","wins","losses");
	param_00 maps\mp\gametypes\_persistence::statset("currentWinStreak",0);
	param_00.combatrecordtie = 1;
}

//Function Number: 24
updatewinlossstats(param_00)
{
	if(maps\mp\_utility::privatematch())
	{
		return;
	}

	if(!isdefined(param_00) || isdefined(param_00) && isstring(param_00) && param_00 == "tie")
	{
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02.connectedpostgame))
			{
				continue;
			}

			if(statlossprevention(var_02))
			{
				updatestatlossprevention(var_02);
				continue;
			}

			if(level.hostforcedend && var_02 ishost())
			{
				var_02 maps\mp\gametypes\_persistence::statset("currentWinStreak",0);
				continue;
			}

			updatetiestats(var_02);
		}
	}
	else if(isplayer(param_00))
	{
		var_04[0] = param_00;
		if(level.players.size > 5)
		{
			var_04 = maps\mp\gametypes\_gamescores::gethighestscoringplayersarray(3);
		}

		foreach(var_02 in level.players)
		{
			if(isdefined(var_02.connectedpostgame))
			{
				continue;
			}

			if(level.hostforcedend && var_02 ishost())
			{
				var_02 maps\mp\gametypes\_persistence::statset("currentWinStreak",0);
				continue;
			}

			if(common_scripts\utility::array_contains(var_04,var_02))
			{
				updatewinstats(var_02);
				continue;
			}

			if(statlossprevention(var_02))
			{
				updatestatlossprevention(var_02);
			}
		}
	}
	else if(isstring(param_00))
	{
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02.connectedpostgame))
			{
				continue;
			}

			if(level.hostforcedend && var_02 ishost())
			{
				var_02 maps\mp\gametypes\_persistence::statset("currentWinStreak",0);
				continue;
			}

			if(var_02.pers["team"] == param_00)
			{
				updatewinstats(var_02);
				continue;
			}

			if(statlossprevention(var_02))
			{
				updatestatlossprevention(var_02);
				continue;
			}

			var_02 maps\mp\gametypes\_persistence::statset("currentWinStreak",0);
		}
	}

	if(level.players.size > 5)
	{
		var_04 = maps\mp\gametypes\_gamescores::gethighestscoringplayersarray(3);
		for(var_09 = 0;var_09 < var_04.size;var_09++)
		{
			if(var_09 == 0)
			{
				var_04[var_09] maps\mp\gametypes\_misions::processchallenge("ch_mvp");
			}

			var_04[var_09] maps\mp\gametypes\_misions::processchallenge("ch_superior");
		}
	}
}

//Function Number: 25
updatestatlossprevention(param_00)
{
	if(!param_00 maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(!hasdoneanycombat(param_00) && !level.gametype == "infect" && !maps\mp\_utility::ishodgepodgeph())
	{
		return;
	}

	param_00 maps\mp\gametypes\_persistence::statadd("losses",-1);
	param_00.displaystatlossui = 1;
}

//Function Number: 26
statlossprevention(param_00)
{
	if(!isdefined(param_00.pers["absoluteJoinTime"]) || !isdefined(game["absoluteStartTime"]))
	{
		return 0;
	}

	var_01 = param_00.pers["absoluteJoinTime"] - game["absoluteStartTime"];
	var_02 = 95;
	if(var_01 >= var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
freezeplayerforroundend(param_00)
{
	self endon("disconnect");
	maps\mp\_utility::clearlowermessages();
	if(!isdefined(param_00))
	{
		param_00 = 0.05;
	}

	self closepopupmenu();
	self closeingamemenu();
	wait(param_00);
	maps\mp\_utility::freezecontrolswrapper(1);
}

//Function Number: 28
updatematchbonusscores(param_00)
{
	if(!game["timePassed"])
	{
		return;
	}

	if(!maps\mp\_utility::matchmakinggame())
	{
		return;
	}

	if(level.teambased)
	{
		if(param_00 == "allies")
		{
			var_01 = "allies";
			var_02 = "axis";
		}
		else if(var_02 == "axis")
		{
			var_01 = "axis";
			var_02 = "allies";
		}
		else
		{
			var_01 = "tie";
			var_02 = "tie";
		}

		if(var_01 != "tie")
		{
			setwinningteam(var_01);
		}

		foreach(var_04 in level.players)
		{
			if(isdefined(var_04.connectedpostgame))
			{
				continue;
			}

			if(!var_04 maps\mp\_utility::rankingenabled())
			{
				continue;
			}

			if(var_04.timeplayed["total"] < 1 || var_04.pers["participation"] < 1)
			{
				if(level.gametype != "infect" && level.gametype != "sd")
				{
					continue;
				}
			}

			if(level.hostforcedend && var_04 ishost())
			{
				continue;
			}

			if(!hasdoneanycombat(var_04) && !level.gametype == "infect" && !maps\mp\_utility::ishodgepodgeph())
			{
				continue;
			}

			var_05 = 0;
			if(var_01 == "tie")
			{
				var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
				var_04.didtie = 1;
				var_04.iswinner = 0;
			}
			else if(isdefined(var_04.pers["team"]) && var_04.pers["team"] == var_01)
			{
				var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("win");
				var_04.iswinner = 1;
			}
			else if(isdefined(var_04.pers["team"]) && var_04.pers["team"] == var_02)
			{
				var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("loss");
				var_04.iswinner = 0;
			}

			var_04.matchbonus = int(var_05);
		}
	}
	else
	{
		foreach(var_04 in level.players)
		{
			if(isdefined(var_04.connectedpostgame))
			{
				continue;
			}

			if(!var_04 maps\mp\_utility::rankingenabled())
			{
				continue;
			}

			if(var_04.timeplayed["total"] < 1 || var_04.pers["participation"] < 1)
			{
				continue;
			}

			if(level.hostforcedend && var_04 ishost())
			{
				continue;
			}

			if(!hasdoneanycombat(var_04))
			{
				continue;
			}

			var_04.iswinner = 0;
			for(var_08 = 0;var_08 < min(level.placement["all"].size,3);var_08++)
			{
				if(level.placement["all"][var_08] != var_04)
				{
					continue;
				}

				var_04.iswinner = 1;
			}

			var_05 = 0;
			if(var_04.iswinner)
			{
				var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("win");
			}
			else
			{
				var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("loss");
			}

			var_04.matchbonus = int(var_05);
		}
	}

	foreach(var_04 in level.players)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		if(!isdefined(var_04.iswinner))
		{
			continue;
		}

		var_0B = "loss";
		if(var_04.iswinner)
		{
			var_0B = "win";
		}

		if(isdefined(var_04.didtie) && var_04.didtie)
		{
			var_0B = "tie";
		}

		var_04 thread givematchbonus(var_0B,var_04.matchbonus);
	}
}

//Function Number: 29
givematchbonus(param_00,param_01)
{
	self endon("disconnect");
	level waittill("give_match_bonus");
	maps\mp\gametypes\_rank::giverankxp(param_00,param_01);
	maps\mp\_utility::logxpgains();
}

//Function Number: 30
setplayerrank(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_00.kills) || !isdefined(param_00.deaths))
	{
		return;
	}

	var_01 = param_00.timeplayed["total"] / 60;
	var_02 = var_01 >= 2;
	if(!var_02)
	{
		return;
	}

	var_03 = param_00.kills;
	var_04 = param_00.deaths;
	var_05 = float(var_03 - var_04) * 1000;
	var_06 = int(var_05 / var_01);
	setplayerteamrank(param_00,param_00.clientid,var_06);
}

//Function Number: 31
setxenonranks(param_00)
{
	var_01 = level.players;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		setplayerrank(var_03);
	}
}

//Function Number: 32
checktimelimit(param_00)
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

	if(maps\mp\_utility::gettimepassedpercentage() > level.timepercentagecutoff)
	{
		setnojiptime(1);
	}

	var_01 = gettimeremaining();
	if(maps\mp\_utility::gethalftime() && game["status"] != "halftime")
	{
		setgameendtime(gettime() + int(var_01) - int(maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5));
	}
	else
	{
		setgameendtime(gettime() + int(var_01));
	}

	if(var_01 > 0)
	{
		if(maps\mp\_utility::gethalftime() && checkhalftime(param_00))
		{
			[[ level.onhalftime ]]("time_limit_reached");
		}

		return;
	}

	[[ level.ontimelimit ]]();
}

//Function Number: 33
checkhalftimescore()
{
	if(!level.halftimeonscorelimit)
	{
		return 0;
	}

	if(!level.teambased)
	{
		return 0;
	}

	if(game["status"] != "normal")
	{
		return 0;
	}

	var_00 = maps\mp\_utility::getwatcheddvar("scorelimit");
	if(var_00)
	{
		if(game["teamScores"]["allies"] >= var_00 || game["teamScores"]["axis"] >= var_00)
		{
			return 0;
		}

		var_01 = int(var_00 / 2 + 0.5);
		if(game["teamScores"]["allies"] >= var_01 || game["teamScores"]["axis"] >= var_01)
		{
			game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
			if(level.halftimeonscorelimitsettimetobeat)
			{
				game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 34
checkhalftime(param_00)
{
	if(!level.teambased)
	{
		return 0;
	}

	if(game["status"] != "normal")
	{
		return 0;
	}

	if(maps\mp\_utility::gettimelimit())
	{
		var_01 = maps\mp\_utility::gettimelimit() * 60 * 1000 * 0.5;
		if(maps\mp\_utility::gettimepassed() >= var_01 && param_00 < var_01 && param_00 > 0)
		{
			game["roundMillisecondsAlreadyPassed"] = maps\mp\_utility::gettimepassed();
			return 1;
		}
	}

	return 0;
}

//Function Number: 35
gettimeremaining()
{
	var_00 = maps\mp\_utility::gettimepassed();
	var_01 = maps\mp\_utility::gettimelimit();
	var_02 = var_01 * 60 * 1000;
	if(maps\mp\_utility::gethalftime() && game["status"] == "halftime" && isdefined(level.firsthalftimepassed))
	{
		var_03 = var_02 * 0.5;
		if(level.firsthalftimepassed < var_03)
		{
			if(level.halftimeonscorelimit && level.halftimeonscorelimitsettimetobeat)
			{
				var_00 = var_02 - level.firsthalftimepassed + var_00 - level.firsthalftimepassed;
			}
			else
			{
				var_00 = var_00 + var_03 - level.firsthalftimepassed;
			}
		}
	}

	return var_02 - var_00;
}

//Function Number: 36
checkteamscorelimitsoon(param_00)
{
	if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0 || maps\mp\_utility::isobjectivebased())
	{
		return;
	}

	if(isdefined(level.scorelimitoverride) && level.scorelimitoverride)
	{
		return;
	}

	if(level.gametype == "conf")
	{
		return;
	}

	if(!level.teambased)
	{
		return;
	}

	if(maps\mp\_utility::ishodgepodgemm())
	{
		return;
	}

	if(maps\mp\_utility::gettimepassed() < 60000)
	{
		return;
	}

	var_01 = estimatedtimetillscorelimit(param_00);
	if(var_01 < 2)
	{
		level notify("match_ending_soon","score");
	}
}

//Function Number: 37
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

	if(maps\mp\_utility::gettimepassed() < 60000)
	{
		return;
	}

	var_00 = estimatedtimetillscorelimit();
	var_01 = 2;
	if(level.gametype == "gun")
	{
		var_01 = 1;
	}

	if(var_00 < var_01)
	{
		level notify("match_ending_soon","score");
	}
}

//Function Number: 38
checkscorelimit()
{
	if(maps\mp\_utility::isobjectivebased())
	{
		return;
	}

	if(isdefined(level.scorelimitoverride) && level.scorelimitoverride)
	{
		return;
	}

	if(game["state"] != "playing")
	{
		return;
	}

	if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0)
	{
		return;
	}

	if(maps\mp\_utility::is_true(level.checkscorelimitonframeend))
	{
		self notify("checkScoreLimit");
		self endon("checkScoreLimit");
		waittillframeend;
	}

	if(maps\mp\_utility::gethalftime() && checkhalftimescore())
	{
		return [[ level.onhalftime ]]("score_limit_reached");
	}
	else if(level.multiteambased)
	{
		var_00 = 0;
		for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
		{
			if(game["teamScores"][level.teamnamelist[var_01]] >= maps\mp\_utility::getwatcheddvar("scorelimit"))
			{
				var_00 = 1;
			}
		}

		if(!var_00)
		{
			return;
		}
	}
	else if(level.teambased)
	{
		if(game["teamScores"]["allies"] < maps\mp\_utility::getwatcheddvar("scorelimit") && game["teamScores"]["axis"] < maps\mp\_utility::getwatcheddvar("scorelimit"))
		{
			return;
		}
	}
	else
	{
		if(!isplayer(self))
		{
			return;
		}

		var_02 = maps\mp\_utility::getwatcheddvar("scorelimit");
		if(var_02 != 0)
		{
			var_03 = self.score / var_02 * 100;
			if(var_03 > level.scorepercentagecutoff)
			{
				setnojipscore(1);
			}
		}

		if(self.score < var_02)
		{
			return;
		}
	}

	onscorelimit();
}

//Function Number: 39
updategametypedvars()
{
	level endon("game_ended");
	while(game["state"] == "playing")
	{
		if(isdefined(level.starttime))
		{
			if(gettimeremaining() < 3000)
			{
				wait(0.1);
				continue;
			}
		}

		wait(1);
	}
}

//Function Number: 40
matchstarttimerwaitforplayers()
{
	level endon("devgui_end_graceperiod");
	setomnvar("ui_match_countdown_title",6);
	setomnvar("ui_match_countdown_toggle",0);
	if(level.currentgen)
	{
		setomnvar("ui_cg_world_blur",1);
	}

	visionsetpostapply("mpIntro",0);
	waitforplayers(level.prematchperiod);
	if(level.prematchperiodend > 0 && !isdefined(level.hostmigrationtimer))
	{
		matchstarttimer(level.prematchperiodend);
		return;
	}

	setomnvar("ui_match_countdown_title",0);
}

//Function Number: 41
matchstarttimer_internal(param_00)
{
	waittillframeend;
	level endon("match_start_timer_beginning");
	setomnvar("ui_match_countdown_title",1);
	setomnvar("ui_match_countdown_toggle",1);
	while(param_00 > 0 && !level.gameended)
	{
		setomnvar("ui_match_countdown",param_00);
		param_00--;
		if(level.currentgen)
		{
			setomnvar("ui_cg_world_blur",1);
		}

		wait(1);
	}

	if(level.currentgen)
	{
		setomnvar("ui_cg_world_blur_fade_out",1);
	}

	if(!maps\mp\_utility::privatematch() && !maps\mp\_utility::is_true(level.ishorde) && !maps\mp\_utility::is_true(level.iszombiegame))
	{
		if(level.xpscale > 1)
		{
			foreach(var_02 in level.players)
			{
				var_02 thread maps\mp\gametypes\_hud_message::splashnotify("double_xp");
			}
		}
		else if(level.xpscalewithparty > 1)
		{
			foreach(var_02 in level.players)
			{
				if(maps\mp\_utility::is_true(var_02.inpartywithotherplayers))
				{
					var_02 thread maps\mp\gametypes\_hud_message::splashnotify("double_xp");
				}
			}
		}
	}

	setomnvar("ui_match_countdown_toggle",0);
	setomnvar("ui_match_countdown",0);
	setomnvar("ui_match_countdown_title",0);
}

//Function Number: 42
matchstarting()
{
	setomnvar("ui_match_countdown_title",2);
	level endon("match_forfeit_timer_beginning");
	wait(1.5);
	setomnvar("ui_match_countdown_title",0);
}

//Function Number: 43
matchstarttimer(param_00)
{
	self notify("matchStartTimer");
	self endon("matchStartTimer");
	level notify("match_start_timer_beginning");
	var_01 = int(param_00);
	childthread matchstartvisionfadeout(var_01);
	if(var_01 >= 2)
	{
		matchstarttimer_internal(var_01);
		return;
	}

	if(level.currentgen)
	{
		setomnvar("ui_cg_world_blur_fade_out",1);
	}

	if(!maps\mp\_utility::privatematch() && !maps\mp\_utility::is_true(level.ishorde) && !maps\mp\_utility::is_true(level.iszombiegame))
	{
		if(level.xpscale > 1)
		{
			foreach(var_03 in level.players)
			{
				var_03 thread maps\mp\gametypes\_hud_message::splashnotify("double_xp");
			}

			return;
		}

		if(level.xpscalewithparty > 1)
		{
			foreach(var_03 in level.players)
			{
				if(maps\mp\_utility::is_true(var_03.inpartywithotherplayers))
				{
					var_03 thread maps\mp\gametypes\_hud_message::splashnotify("double_xp");
				}
			}

			return;
		}

		return;
	}
}

//Function Number: 44
matchstartvisionfadeout(param_00)
{
	if(param_00 > 2)
	{
		wait(param_00 - 2);
	}

	var_01 = 3;
	if(param_00 < 2)
	{
		var_01 = 1;
	}

	visionsetnaked("",var_01);
	visionsetpostapply("",var_01);
}

//Function Number: 45
matchstarttimerskip()
{
	visionsetnaked("",0);
	visionsetpostapply("",0);
}

//Function Number: 46
calculateroundswitchfortiebreakerround()
{
	var_00 = getbetterteam();
	var_01 = 0;
	if(isdefined(game["attackerWinCount"]))
	{
		var_01 = game["attackerWinCount"];
	}

	var_02 = 0;
	if(isdefined(game["defenderWinCount"]))
	{
		var_02 = game["defenderWinCount"];
	}

	if(var_01 > 0 || var_02 > 0)
	{
		if(var_01 > var_02)
		{
			if(var_00 != game["attackers"])
			{
				game["switchedsides"] = !game["switchedsides"];
				return;
			}

			return;
		}

		if(var_02 > var_01)
		{
			if(var_00 != game["defenders"])
			{
				game["switchedsides"] = !game["switchedsides"];
				return;
			}

			return;
		}

		if(var_00 != game["defenders"])
		{
			game["switchedsides"] = !game["switchedsides"];
			return;
		}

		return;
	}

	if(var_00 != game["defenders"])
	{
		game["switchedsides"] = !game["switchedsides"];
	}
}

//Function Number: 47
onroundswitch()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	var_00 = maps\mp\_utility::getwatcheddvar("winlimit");
	if(game["roundsWon"]["allies"] == var_00 - 1 && game["roundsWon"]["axis"] == var_00 - 1)
	{
		calculateroundswitchfortiebreakerround();
		level.halftimetype = "overtime";
		if(var_00 > 1)
		{
			game["tiebreaker"] = 1;
		}

		game["dynamicEvent_Overtime"] = 1;
		return;
	}

	level.halftimetype = "halftime";
	game["switchedsides"] = !game["switchedsides"];
}

//Function Number: 48
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

//Function Number: 49
timeuntilroundend()
{
	if(level.gameended)
	{
		var_00 = gettime() - level.gameendtime / 1000;
		var_01 = level.postroundtime - var_00;
		if(var_01 < 0)
		{
			return 0;
		}

		return var_01;
	}

	if(maps\mp\_utility::gettimelimit() <= 0)
	{
		return undefined;
	}

	if(!isdefined(level.starttime))
	{
		return undefined;
	}

	var_02 = maps\mp\_utility::gettimelimit();
	var_00 = gettime() - level.starttime / 1000;
	var_01 = maps\mp\_utility::gettimelimit() * 60 - var_02;
	if(isdefined(level.timepaused))
	{
		var_02 = var_02 + level.timepaused;
	}

	return var_02 + level.postroundtime;
}

//Function Number: 50
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
	}
}

//Function Number: 51
gethostplayer()
{
	var_00 = getentarray("player","classname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(var_00[var_01] ishost())
		{
			return var_00[var_01];
		}
	}
}

//Function Number: 52
hostidledout()
{
	var_00 = gethostplayer();
	if(isdefined(var_00) && !var_00.hasspawned && !isdefined(var_00.selectedclass))
	{
		return 1;
	}

	return 0;
}

//Function Number: 53
roundendwait(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		var_03 maps\mp\gametypes\_damage::streamfinalkillcam();
	}

	waitforsplashesdone();
	if(!param_01)
	{
		wait(param_00);
		var_05 = level.players;
		foreach(var_03 in var_05)
		{
			var_03 setclientomnvar("ui_round_end",0);
		}

		level notify("round_end_finished");
		return;
	}

	wait(var_03 / 2);
	level notify("give_match_bonus");
	wait(var_03 / 2);
	waitforsplashesdone();
	var_05 = level.players;
	foreach(var_05 in var_07)
	{
		var_05 setclientomnvar("ui_round_end",0);
	}

	level notify("round_end_finished");
}

//Function Number: 54
waitforsplashesdone()
{
	var_00 = 15;
	var_01 = gettime() + var_00 * 1000;
	var_02 = 0;
	while(!var_02 && gettime() < var_01)
	{
		wait(0.5);
		var_03 = level.players;
		var_02 = 1;
		foreach(var_05 in var_03)
		{
			if(!var_05 maps\mp\gametypes\_hud_message::isdoingsplash())
			{
				continue;
			}

			var_02 = 0;
			break;
		}
	}
}

//Function Number: 55
roundenddof(param_00)
{
	self setdepthoffield(0,128,512,4000,6,1.8);
}

//Function Number: 56
callback_startgametype()
{
	maps\mp\_load::main();
	maps\mp\_utility::levelflaginit("round_over",0);
	maps\mp\_utility::levelflaginit("game_over",0);
	maps\mp\_utility::levelflaginit("block_notifies",0);
	level.prematchperiod = 0;
	level.prematchperiodend = 0;
	level.postgamenotifies = 0;
	level.intermission = 0;
	setdvar("bg_compassShowEnemies",getdvar("scr_game_forceuav"));
	if(!isdefined(game["gamestarted"]))
	{
		game["clientid"] = 0;
		var_00 = getmapcustom("allieschar");
		if(!isdefined(var_00) || var_00 == "")
		{
			if(!isdefined(game["allies"]))
			{
				var_00 = "marines";
			}
			else
			{
				var_00 = game["allies"];
			}
		}

		var_01 = getmapcustom("axischar");
		if(!isdefined(var_01) || var_01 == "")
		{
			if(!isdefined(game["axis"]))
			{
				var_01 = "opfor";
			}
			else
			{
				var_01 = game["axis"];
			}
		}

		if(level.multiteambased)
		{
			var_02 = getmapcustom("allieschar");
			if(!isdefined(var_02) || var_02 == "")
			{
				var_02 = "delta_multicam";
			}

			for(var_03 = 0;var_03 < level.teamnamelist.size;var_03++)
			{
				game[level.teamnamelist[var_03]] = var_02;
			}
		}

		game["allies"] = var_00;
		game["axis"] = var_01;
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

		game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
		game["strings"]["match_starting_in"] = &"MP_MATCH_STARTING_IN";
		game["strings"]["match_resuming_in"] = &"MP_MATCH_RESUMING_IN";
		game["strings"]["waiting_for_players"] = &"MP_WAITING_FOR_PLAYERS";
		game["strings"]["spawn_tag_wait"] = &"MP_SPAWN_TAG_WAIT";
		game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
		game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";
		game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
		game["strings"]["change_team"] = &"MP_CHANGE_TEAM_NEXT_SPAWN";
		game["strings"]["change_team_cancel"] = &"MP_CHANGE_TEAM_CANCEL";
		game["strings"]["change_team_wait"] = &"MP_CHANGE_TEAM_WAIT";
		game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
		game["strings"]["change_class_cancel"] = &"MP_CHANGE_CLASS_CANCEL";
		game["strings"]["change_class_wait"] = &"MP_CHANGE_CLASS_WAIT";
		game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
		game["strings"]["final_stand"] = &"MPUI_FINAL_STAND";
		game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";
		game["strings"]["tie"] = &"MP_MATCH_TIE";
		game["colors"]["blue"] = (0.25,0.25,0.75);
		game["colors"]["red"] = (0.75,0.25,0.25);
		game["colors"]["white"] = (1,1,1);
		game["colors"]["black"] = (0,0,0);
		game["colors"]["grey"] = (0.5,0.5,0.5);
		game["colors"]["green"] = (0.25,0.75,0.25);
		game["colors"]["yellow"] = (0.65,0.65,0);
		game["colors"]["orange"] = (1,0.45,0);
		game["colors"]["cyan"] = (0.35,0.7,0.9);
		game["strings"]["allies_name"] = maps\mp\gametypes\_teams::getteamname("allies");
		game["icons"]["allies"] = maps\mp\gametypes\_teams::getteamicon("allies");
		game["colors"]["allies"] = maps\mp\gametypes\_teams::getteamcolor("allies");
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
		setdvarifuninitialized("min_wait_for_players",5);
		if(level.console)
		{
			if(!level.splitscreen)
			{
				if(isdedicatedserver())
				{
					level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game","graceperiod_ds");
				}
				else
				{
					level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game","graceperiod");
				}

				level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game","matchstarttime");
			}
		}
		else
		{
			if(isdedicatedserver())
			{
				level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game","playerwaittime_ds");
			}
			else
			{
				level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game","playerwaittime");
			}

			level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game","matchstarttime");
		}
	}
	else
	{
		setdvarifuninitialized("min_wait_for_players",5);
		if(level.console)
		{
			if(!level.splitscreen)
			{
				level.prematchperiod = 5;
				level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game","roundstarttime");
			}
		}
		else
		{
			level.prematchperiod = 5;
			level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game","roundstarttime");
		}
	}

	if(!isdefined(game["status"]))
	{
		game["status"] = "normal";
	}

	if(game["status"] != "overtime" && game["status"] != "halftime" && game["status"] != "overtime_halftime")
	{
		game["teamScores"]["allies"] = 0;
		game["teamScores"]["axis"] = 0;
		if(level.multiteambased)
		{
			for(var_03 = 0;var_03 < level.teamnamelist.size;var_03++)
			{
				game["teamScores"][level.teamnamelist[var_03]] = 0;
			}
		}
	}

	if(!isdefined(game["timePassed"]))
	{
		game["timePassed"] = 0;
	}

	if(!isdefined(game["roundsPlayed"]))
	{
		game["roundsPlayed"] = 0;
	}

	setomnvar("ui_current_round",game["roundsPlayed"] + 1);
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

		if(level.multiteambased)
		{
			for(var_03 = 0;var_03 < level.teamnamelist.size;var_03++)
			{
				if(!isdefined(game["roundsWon"][level.teamnamelist[var_03]]))
				{
					game["roundsWon"][level.teamnamelist[var_03]] = 0;
				}
			}
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

	level.oldschool = getdvarint("g_oldschool");
	if(level.oldschool)
	{
		logstring("game mode: oldschool");
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
	if(!isdefined(level.iszombiegame))
	{
		level.iszombiegame = 0;
	}

	level.usestartspawns = 1;
	level.objectivepointsmod = 1;
	level.baseplayermovescale = 1;
	level.maxallowedteamkills = 2;
	thread maps\mp\gametypes\_hodgepodge::init();
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
	thread maps\mp\gametypes\_oldschool::init();
	thread maps\mp\gametypes\_battlechatter_mp::init();
	thread maps\mp\gametypes\_music_and_dialog::init();
	thread maps\mp\_matchdata::init();
	thread maps\mp\_awards::init();
	thread maps\mp\_skill::init();
	thread maps\mp\_areas::init();
	thread maps\mp\perks\_perks::init();
	thread maps\mp\_events::init();
	thread maps\mp\gametypes\_damage::initfinalkillcam();
	thread maps\mp\_snd_common_mp::init();
	thread maps\mp\_utility::buildattachmentmaps();
	if(level.teambased)
	{
		thread maps\mp\gametypes\_friendicons::init();
	}

	thread maps\mp\gametypes\_hud_message::init();
	thread maps\mp\gametypes\_divisions::init();
	thread maps\mp\gametypes\_hardpoints::init();
	foreach(var_05 in game["strings"])
	{
		precachestring(var_05);
	}

	game["gamestarted"] = 1;
	if(!isdefined(game["absoluteStartTime"]))
	{
		game["absoluteStartTime"] = getsystemtime();
	}

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
	if(level.multiteambased)
	{
		for(var_03 = 0;var_03 < level.teamnamelist.size;var_03++)
		{
			level._wavedelay[level.teamnamelist[var_03]] = 0;
			level._lastwave[level.teamnamelist[var_03]] = 0;
			level._waveplayerspawnindex[level.teamnamelist[var_03]] = 0;
			level._aliveplayers[level.teamnamelist[var_03]] = [];
		}
	}

	setdvar("ui_scorelimit",0);
	setdvar("ui_allow_teamchange",1);
	if(maps\mp\_utility::getgametypenumlives())
	{
		setdvar("g_deadChat",0);
	}
	else
	{
		setdvar("g_deadChat",1);
	}

	var_07 = getdvarfloat("scr_" + level.gametype + "_waverespawndelay");
	if(var_07 > 0)
	{
		level.wavedelay["allies"] = var_07;
		level.wavedelay["axis"] = var_07;
		level.lastwave["allies"] = 0;
		level.lastwave["axis"] = 0;
		if(level.multiteambased)
		{
			for(var_03 = 0;var_03 < level.teamnamelist.size;var_03++)
			{
				level._wavedelay[level.teamnamelist[var_03]] = var_07;
				level._lastwave[level.teamnamelist[var_03]] = 0;
			}
		}

		level thread wavespawntimer();
	}

	maps\mp\_utility::gameflaginit("prematch_done",0);
	level.graceperiod = 15;
	level.ingraceperiod = level.graceperiod;
	maps\mp\_utility::gameflaginit("graceperiod_done",0);
	level.roundenddelay = 4;
	level.halftimeroundenddelay = 4;
	level.noragdollents = getentarray("noragdoll","targetname");
	if(level.teambased)
	{
		maps\mp\gametypes\_gamescores::updateteamscore("axis");
		maps\mp\gametypes\_gamescores::updateteamscore("allies");
		if(level.multiteambased)
		{
			for(var_03 = 0;var_03 < level.teamnamelist.size;var_03++)
			{
				maps\mp\gametypes\_gamescores::updateteamscore(level.teamnamelist[var_03]);
			}
		}
	}
	else
	{
		thread maps\mp\gametypes\_gamescores::initialdmscoreupdate();
	}

	thread updateuiscorelimit();
	level notify("update_scorelimit");
	[[ level.onstartgametype ]]();
	level.scorepercentagecutoff = getdvarint("scr_" + level.gametype + "_score_percentage_cut_off",80);
	level.timepercentagecutoff = getdvarint("scr_" + level.gametype + "_time_percentage_cut_off",80);
	if(!level.console && getdvar("dedicated") == "dedicated LAN server" || getdvar("dedicated") == "dedicated internet server")
	{
		thread verifydedicatedconfiguration();
	}

	setattackingteam();
	thread startgame();
	level thread maps\mp\_utility::updatewatcheddvars();
	level thread timelimitthread();
	level thread maps\mp\gametypes\_damage::dofinalkillcam();
}

//Function Number: 57
setattackingteam()
{
	if(game["attackers"] == "axis")
	{
		var_00 = 1;
	}
	else if(game["attackers"] == "allies")
	{
		var_00 = 2;
	}
	else
	{
		var_00 = 0;
	}

	setomnvar("ui_attacking_team",var_00);
}

//Function Number: 58
callback_codeendgame()
{
	endparty();
	if(!level.gameended)
	{
		level thread forceend();
	}
}

//Function Number: 59
verifydedicatedconfiguration()
{
	for(;;)
	{
		if(level.rankedmatch)
		{
			exitlevel(0);
		}

		if(!getdvarint("xblive_privatematch"))
		{
			exitlevel(0);
		}

		if(getdvar("dedicated") != "dedicated LAN server" && getdvar("dedicated") != "dedicated internet server")
		{
			exitlevel(0);
		}

		wait(5);
	}
}

//Function Number: 60
timelimitthread()
{
	level endon("game_ended");
	var_00 = maps\mp\_utility::gettimepassed();
	while(game["state"] == "playing")
	{
		thread checktimelimit(var_00);
		var_00 = maps\mp\_utility::gettimepassed();
		if(isdefined(level.starttime))
		{
			if(gettimeremaining() < 3000)
			{
				common_scripts\utility::waittill_notify_or_timeout("updateTimeLimit",0.1);
				continue;
			}
		}

		common_scripts\utility::waittill_notify_or_timeout("updateTimeLimit",1);
	}
}

//Function Number: 61
updateuiscorelimit()
{
	for(;;)
	{
		level common_scripts\utility::waittill_either("update_scorelimit","update_winlimit");
		if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased())
		{
			setdvar("ui_scorelimit",maps\mp\_utility::getwatcheddvar("scorelimit"));
			thread checkscorelimit();
			continue;
		}

		setdvar("ui_scorelimit",maps\mp\_utility::getwatcheddvar("winlimit"));
	}
}

//Function Number: 62
timelimitclock()
{
	level endon("game_ended");
	wait(0.05);
	var_00 = spawn("script_origin",(0,0,0));
	var_00 hide();
	while(game["state"] == "playing")
	{
		if(!level.timerstopped && maps\mp\_utility::gettimelimit())
		{
			var_01 = gettimeremaining() / 1000;
			var_02 = int(var_01 + 0.5);
			var_03 = int(maps\mp\_utility::gettimelimit() * 60 * 0.5);
			if(maps\mp\_utility::gethalftime() && var_02 > var_03)
			{
				var_02 = var_02 - var_03;
			}

			if(var_02 >= 30 && var_02 <= 60)
			{
				level notify("match_ending_soon","time");
			}

			if(var_02 <= 10 || var_02 <= 30 && var_02 % 2 == 0)
			{
				level notify("match_ending_very_soon");
				if(var_02 == 0)
				{
					break;
				}

				var_00 playsound("ui_mp_timer_countdown");
			}

			if(var_01 - floor(var_01) >= 0.05)
			{
				wait(var_01 - floor(var_01));
			}
		}

		wait(1);
	}
}

//Function Number: 63
gametimer()
{
	level endon("game_ended");
	level waittill("prematch_over");
	level.starttime = gettime();
	level.discardtime = 0;
	level.matchdurationstarttime = gettime();
	if(isdefined(game["roundMillisecondsAlreadyPassed"]))
	{
		level.starttime = level.starttime - game["roundMillisecondsAlreadyPassed"];
		level.firsthalftimepassed = game["roundMillisecondsAlreadyPassed"];
		game["roundMillisecondsAlreadyPassed"] = undefined;
	}

	var_00 = gettime();
	while(game["state"] == "playing")
	{
		if(!level.timerstopped)
		{
			game["timePassed"] = game["timePassed"] + gettime() - var_00;
		}

		var_00 = gettime();
		wait(1);
	}
}

//Function Number: 64
updatetimerpausedness()
{
	var_00 = level.timerstoppedforgamemode || isdefined(level.hostmigrationtimer);
	if(!maps\mp\_utility::gameflag("prematch_done"))
	{
		var_00 = 0;
	}

	if(!level.timerstopped && var_00)
	{
		level.timerstopped = 1;
		level.timerpausetime = gettime();
		return;
	}

	if(level.timerstopped && !var_00)
	{
		level.timerstopped = 0;
		level.discardtime = level.discardtime + gettime() - level.timerpausetime;
		level notify("updateTimeLimit");
	}
}

//Function Number: 65
pausetimer()
{
	level.timerstoppedforgamemode = 1;
	updatetimerpausedness();
}

//Function Number: 66
resumetimer()
{
	level.timerstoppedforgamemode = 0;
	updatetimerpausedness();
}

//Function Number: 67
startgame()
{
	thread gametimer();
	level.timerstopped = 0;
	level.timerstoppedforgamemode = 0;
	if(maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning())
	{
		thread maps\mp\gametypes\_legacyspawnlogic::spawnperframeupdate();
	}

	setdvar("ui_inprematch",1);
	prematchperiod();
	maps\mp\_utility::gameflagset("prematch_done");
	level notify("prematch_over");
	setdvar("ui_inprematch",0);
	level.prematch_done_time = gettime();
	updatetimerpausedness();
	thread timelimitclock();
	thread graceperiod();
	thread maps\mp\gametypes\_misions::roundbegin();
	thread maps\mp\_matchdata::matchstarted();
	var_00 = isdefined(level.ishorde) && level.ishorde;
	var_01 = isdefined(level.iszombiegame) && level.iszombiegame;
	if(var_00 || var_01)
	{
		thread updategameduration();
	}

	if(!maps\mp\_utility::invirtuallobby())
	{
		level thread maps\mp\_utility::gameplayactivewatch();
	}

	lootserviceonstartgame();
}

//Function Number: 68
wavespawntimer()
{
	level endon("game_ended");
	while(game["state"] == "playing")
	{
		var_00 = gettime();
		if(var_00 - level.lastwave["allies"] > level.wavedelay["allies"] * 1000)
		{
			level notify("wave_respawn_allies");
			level.lastwave["allies"] = var_00;
			level.waveplayerspawnindex["allies"] = 0;
		}

		if(var_00 - level.lastwave["axis"] > level.wavedelay["axis"] * 1000)
		{
			level notify("wave_respawn_axis");
			level.lastwave["axis"] = var_00;
			level.waveplayerspawnindex["axis"] = 0;
		}

		if(level.multiteambased)
		{
			for(var_01 = 0;var_01 < level.teamnamelist.size;var_01++)
			{
				if(var_00 - level.lastwave[level.teamnamelist[var_01]] > level._wavedelay[level.teamnamelist[var_01]] * 1000)
				{
					var_02 = "wave_rewpawn_" + level.teamnamelist[var_01];
					level notify(var_02);
					level.lastwave[level.teamnamelist[var_01]] = var_00;
					level.waveplayerspawnindex[level.teamnamelist[var_01]] = 0;
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 69
getbetterteam()
{
	var_00["allies"] = 0;
	var_00["axis"] = 0;
	var_01["allies"] = 0;
	var_01["axis"] = 0;
	var_02["allies"] = 0;
	var_02["axis"] = 0;
	foreach(var_04 in level.players)
	{
		var_05 = var_04.pers["team"];
		if(isdefined(var_05) && var_05 == "allies" || var_05 == "axis")
		{
			var_00[var_05] = var_00[var_05] + var_04.score;
			var_01[var_05] = var_01[var_05] + var_04.kills;
			var_02[var_05] = var_02[var_05] + var_04.deaths;
		}
	}

	if(var_00["allies"] > var_00["axis"])
	{
		return "allies";
	}
	else if(var_00["axis"] > var_00["allies"])
	{
		return "axis";
	}

	if(var_01["allies"] > var_01["axis"])
	{
		return "allies";
	}
	else if(var_01["axis"] > var_01["allies"])
	{
		return "axis";
	}

	if(var_02["allies"] < var_02["axis"])
	{
		return "allies";
	}
	else if(var_02["axis"] < var_02["allies"])
	{
		return "axis";
	}

	if(randomint(2) == 0)
	{
		return "allies";
	}

	return "axis";
}

//Function Number: 70
rankedmatchupdates(param_00)
{
	if(!maps\mp\_utility::waslastround())
	{
		return;
	}

	param_00 = getgamewinner(param_00,0);
	if(maps\mp\_utility::matchmakinggame())
	{
		setxenonranks();
		if(hostidledout())
		{
			level.hostforcedend = 1;
			logstring("host idled out");
			endlobby();
		}

		updatematchbonusscores(param_00);
	}

	updatewinlossstats(param_00);
}

//Function Number: 71
outcomenotifytoallplayers(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.onoutcomenotify))
	{
		[[ level.onoutcomenotify ]](param_00,param_01,param_02,param_03);
	}

	foreach(var_05 in level.players)
	{
		if(isdefined(var_05.connectedpostgame))
		{
			continue;
		}

		if(isdefined(var_05.displaystatlossui) && var_05.displaystatlossui)
		{
			var_06 = game["end_reason"]["stat_loss_prevention"];
		}
		else
		{
			var_06 = param_02;
		}

		if(level.teambased)
		{
			var_05 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(param_00,param_01,var_06,param_03);
			continue;
		}

		var_05 thread maps\mp\gametypes\_hud_message::outcomenotify(param_00,var_06);
	}
}

//Function Number: 72
displayroundend(param_00,param_01)
{
	outcomenotifytoallplayers(param_00,1,param_01);
	if(!maps\mp\_utility::waslastround())
	{
		level notify("round_win",param_00);
	}

	if(maps\mp\_utility::waslastround())
	{
		roundendwait(level.roundenddelay,0);
		return;
	}

	roundendwait(level.roundenddelay,1);
}

//Function Number: 73
displaygameend(param_00,param_01)
{
	outcomenotifytoallplayers(param_00,0,param_01,1);
	level notify("game_win",param_00);
	roundendwait(level.postroundtime,1);
}

//Function Number: 74
displayroundswitch(param_00)
{
	var_01 = level.halftimetype;
	if(var_01 == "halftime")
	{
		if(maps\mp\_utility::getwatcheddvar("roundlimit"))
		{
			if(game["roundsPlayed"] * 2 == maps\mp\_utility::getwatcheddvar("roundlimit"))
			{
				var_01 = "halftime";
			}
			else
			{
				var_01 = "intermission";
			}
		}
		else if(maps\mp\_utility::getwatcheddvar("winlimit"))
		{
			if(game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1)
			{
				var_01 = "halftime";
			}
			else
			{
				var_01 = "intermission";
			}
		}
		else
		{
			var_01 = "intermission";
		}
	}

	level notify("round_switch",var_01);
	var_02 = 0;
	if(param_00 != game["switchedsides"])
	{
		var_02 = game["end_reason"]["switching_sides"];
	}

	outcomenotifytoallplayers(var_01,1,var_02);
	roundendwait(level.halftimeroundenddelay,0);
}

//Function Number: 75
arraytostring(param_00)
{
	var_01 = "";
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = var_01 + param_00[var_02];
		if(var_02 != param_00.size - 1)
		{
			var_01 = var_01 + ",";
		}
	}

	return var_01;
}

//Function Number: 76
recordendgamecomscoreevent(param_00)
{
	var_01 = level.players;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		recordendgamecomscoreeventforplayer(var_01[var_02],param_00);
	}
}

//Function Number: 77
recordendgamecomscoreeventforplayer(param_00,param_01)
{
	var_02 = param_01;
	if(isdefined(param_00.team) && param_01 == param_00.team)
	{
		var_02 = "win";
	}
	else if(param_01 == "allies" || param_01 == "axis")
	{
		var_02 = "lose";
	}

	var_03 = "";
	var_04 = "";
	var_05 = "";
	var_06 = "";
	var_07 = "";
	var_08 = "";
	var_09 = "";
	var_0A = "";
	var_0B = param_00.team;
	var_0C = param_00.class;
	if(isdefined(var_0B) && isdefined(var_0C) && var_0C != "")
	{
		var_0D = param_00 maps\mp\gametypes\_class::getloadout(var_0B,var_0C,undefined,undefined,1);
		var_03 = var_0D.primary;
		var_04 = var_0D.primaryattachkit;
		var_05 = var_0D.secondary;
		var_06 = var_0D.secondaryattachkit;
		var_07 = var_0D.equipment;
		var_08 = var_0D.offhand;
		var_09 = arraytostring(var_0D.perks);
		var_0A = "";
	}

	function_02FC("end_match");
	function_02FD("game_variant","mp");
	var_0E = getmatchdata("gametype");
	function_02FD("game_mode",var_0E);
	var_0F = getmatchdata("privateMatch");
	function_02FD("private_match",var_0F);
	var_10 = getmatchdata("map");
	function_02FD("game_map",var_10);
	function_02FD("player_xuid",param_00 getxuid());
	var_11 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","kills");
	function_02FD("match_kills",var_11);
	var_12 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","deaths");
	function_02FD("match_deaths",var_12);
	var_13 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","totalXp");
	function_02FD("match_xp",var_13);
	var_14 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","score");
	function_02FD("match_score",var_14);
	var_15 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","captures");
	function_02FD("match_captures",var_15);
	var_16 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","defends");
	function_02FD("match_defends",var_16);
	var_17 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","headshots");
	function_02FD("match_headshots",var_17);
	var_18 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","plants");
	function_02FD("match_plants",var_18);
	var_19 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","defuses");
	function_02FD("match_defuses",var_19);
	var_1A = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","returns");
	function_02FD("match_returns",var_1A);
	function_02FD("prestige_max",param_00.pers["prestige"]);
	function_02FD("level_max",param_00.pers["rank"]);
	function_02FD("match_result",var_02);
	var_1B = param_00 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","timePlayed");
	function_02FD("match_duration",var_1B);
	if(param_00.clientid <= 30 && param_00.clientid != getmatchdata("playerCount"))
	{
		var_1C = getmatchdata("players",param_00.clientid,"startHits");
		var_1D = getmatchdata("players",param_00.clientid,"endHits");
		var_1E = getmatchdata("players",param_00.clientid,"startMisses");
		var_1F = getmatchdata("players",param_00.clientid,"endMisses");
		var_20 = var_1D + var_1F - var_1C + var_1E;
		var_21 = var_1D - var_1C;
		function_02FD("match_shots",var_20);
		function_02FD("match_hits",var_21);
	}
	else
	{
		function_02FD("match_shots",0);
		function_02FD("match_hits",0);
	}

	function_02FD("loadout_perks",var_09);
	function_02FD("loadout_lethal",var_07);
	function_02FD("loadout_tactical",var_08);
	function_02FD("loadout_scorestreaks",var_0A);
	function_02FD("loadout_primary_weapon",var_03);
	function_02FD("loadout_secondary_weapon",var_05);
	function_02FD("loadout_primary_attachments",var_04);
	function_02FD("loadout_secondary_attachments",var_06);
	var_22 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestScore");
	function_02FD("best_score",common_scripts\utility::tostring(var_22));
	var_23 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestKills");
	function_02FD("best_kills",common_scripts\utility::tostring(var_23));
	var_24 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"kills");
	function_02FD("total_kills",var_24);
	var_25 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"deaths");
	function_02FD("total_deaths",var_25);
	var_26 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"wins");
	function_02FD("total_wins",var_26);
	var_27 = param_00 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"experience");
	function_02FD("total_xp",var_27);
	function_02FE();
}

//Function Number: 78
freezeallplayers(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	foreach(var_03 in level.players)
	{
		var_03 disableammogeneration();
		var_03 thread freezeplayerforroundend(param_00);
		var_03 thread roundenddof(4);
		var_03 freegameplayhudelems();
		if(isdefined(param_01) && param_01)
		{
			if(level.splitscreen || var_03 issplitscreenplayerprimary())
			{
				var_03 setclientdvars("cg_everyoneHearsEveryone",1,"cg_fovscale",0.75);
			}
			else
			{
				var_03 setclientdvars("cg_everyoneHearsEveryone",1,"cg_fovScale",1);
			}

			var_03 setclientomnvar("fov_scale",1);
			continue;
		}

		var_03 setclientdvars("cg_everyoneHearsEveryone",1);
	}

	if(isdefined(level.agentarray))
	{
		foreach(var_06 in level.agentarray)
		{
			var_06 maps\mp\_utility::freezecontrolswrapper(1);
		}
	}
}

//Function Number: 79
endgameovertime(param_00,param_01)
{
	setdvar("bg_compassShowEnemies",0);
	handlekillstreaksonroundswitch(0);
	freezeallplayers(1,1);
	foreach(var_03 in level.players)
	{
		var_03.pers["stats"] = var_03.stats;
		var_03.pers["segments"] = var_03.segments;
	}

	level notify("round_switch","overtime");
	var_05 = 0;
	var_06 = 0;
	var_07 = param_00 == "overtime";
	if(level.gametype == "ctf")
	{
		if(param_00 == "overtime_halftime")
		{
			var_06 = 1;
		}

		param_00 = "tie";
		var_05 = 1;
		var_07 = 1;
		if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			param_00 = "axis";
		}

		if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
		{
			param_00 = "allies";
		}
	}

	outcomenotifytoallplayers(param_00,var_05,param_01);
	roundendwait(level.roundenddelay,0);
	if(level.gametype == "ctf")
	{
		param_00 = "overtime_halftime";
	}

	if(isdefined(level.finalkillcam_winner) && var_07)
	{
		foreach(var_03 in level.players)
		{
			var_03 notify("reset_outcome");
		}

		level notify("game_cleanup");
		waittillfinalkillcamdone();
		if(level.gametype == "ctf" && !var_06)
		{
			param_00 = "overtime";
			param_01 = game["end_reason"]["tie"];
		}

		outcomenotifytoallplayers(param_00,0,param_01);
		roundendwait(level.halftimeroundenddelay,0);
	}

	game["status"] = param_00;
	level notify("restarting");
	game["state"] = "playing";
	setdvar("ui_game_state",game["state"]);
	map_restart(1);
}

//Function Number: 80
handlekillstreaksonroundswitch(param_00)
{
	var_01 = isdefined(level.killcountpersistsoverrounds) && level.killcountpersistsoverrounds != 0;
	if(param_00 && maps\mp\_utility::wasonlyround() || maps\mp\_utility::waslastround())
	{
		var_01 = 0;
	}

	foreach(var_03 in level.players)
	{
		if(!var_01)
		{
			var_03.pers["cur_kill_streak"] = 0;
			var_03 setclientomnvar("ks_count1",0);
			continue;
		}

		var_04 = int(var_03 method_8443("ks_count1"));
		var_03.pers["cur_kill_count"] = var_04;
	}
}

//Function Number: 81
endgamehalftime(param_00)
{
	setdvar("bg_compassShowEnemies",0);
	handlekillstreaksonroundswitch(0);
	var_01 = "halftime";
	var_02 = 1;
	if(isdefined(level.halftime_switch_sides) && !level.halftime_switch_sides)
	{
		var_02 = 0;
	}

	if(var_02)
	{
		game["switchedsides"] = !game["switchedsides"];
		var_03 = game["end_reason"]["switching_sides"];
	}
	else
	{
		var_03 = var_01;
	}

	freezeallplayers(1,1);
	if(level.gametype == "ctf")
	{
		var_03 = param_00;
		var_01 = "tie";
		if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			var_01 = "axis";
		}

		if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
		{
			var_01 = "allies";
		}
	}

	foreach(var_05 in level.players)
	{
		var_05.pers["stats"] = var_05.stats;
		var_05.pers["segments"] = var_05.segments;
	}

	level notify("round_switch","halftime");
	outcomenotifytoallplayers(var_01,1,var_03);
	roundendwait(level.roundenddelay,0);
	if(isdefined(level.finalkillcam_winner))
	{
		foreach(var_05 in level.players)
		{
			var_05 notify("reset_outcome");
		}

		level notify("game_cleanup");
		waittillfinalkillcamdone();
		var_09 = game["end_reason"]["switching_sides"];
		if(!var_02)
		{
			var_09 = var_03;
		}

		outcomenotifytoallplayers("halftime",1,var_09);
		roundendwait(level.halftimeroundenddelay,0);
	}

	game["status"] = "halftime";
	level notify("restarting");
	game["state"] = "playing";
	setdvar("ui_game_state",game["state"]);
	map_restart(1);
}

//Function Number: 82
updategameduration()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = getgameduration();
		setomnvar("ui_game_duration",var_00 * 1000);
		wait(1);
	}
}

//Function Number: 83
getgameduration()
{
	var_00 = maps\mp\_utility::getgametimepassedseconds();
	if(isdefined(level.ishorde) && level.ishorde)
	{
		var_00 = gamedurationclamp(var_00);
	}

	return var_00;
}

//Function Number: 84
gamedurationclamp(param_00)
{
	if(param_00 > 86399)
	{
		return 86399;
	}

	return param_00;
}

//Function Number: 85
endgame(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(game["state"] == "postgame" || level.gameended)
	{
		return;
	}

	game["state"] = "postgame";
	setdvar("ui_game_state","postgame");
	level.gameendtime = gettime();
	level.gameended = 1;
	level.ingraceperiod = 0;
	level notify("game_ended",param_00);
	maps\mp\_utility::levelflagset("game_over");
	maps\mp\_utility::levelflagset("block_notifies");
	var_03 = getgameduration();
	setomnvar("ui_game_duration",var_03 * 1000);
	maps\mp\_utility::setgameplayactive(0);
	wait 0.05;
	setgameendtime(0);
	setmatchdata("gameLengthSeconds",var_03);
	setmatchdata("endTimeUTC",getsystemtime());
	checkgameendchallenges();
	if(isdefined(param_00) && isstring(param_00) && maps\mp\_utility::isovertimetext(param_00))
	{
		level.finalkillcam_winner = "none";
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
		endgameovertime(param_00,param_01);
		return;
	}

	if(isdefined(param_00) && isstring(param_00) && param_00 == "halftime")
	{
		level.finalkillcam_winner = "none";
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
		endgamehalftime(param_01);
		return;
	}

	if(isdefined(level.finalkillcam_winner))
	{
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
	}

	game["roundsPlayed"]++;
	if(level.gametype != "ctf")
	{
		setomnvar("ui_current_round",game["roundsPlayed"]);
	}

	if(level.teambased)
	{
		if((param_00 == "axis" || param_00 == "allies") && level.gametype != "ctf")
		{
			game["roundsWon"][param_00]++;
		}

		maps\mp\gametypes\_gamescores::updateteamscore("axis");
		maps\mp\gametypes\_gamescores::updateteamscore("allies");
	}
	else if(isdefined(param_00) && isplayer(param_00))
	{
		game["roundsWon"][param_00.guid]++;
	}

	maps\mp\gametypes\_gamescores::updateplacement();
	rankedmatchupdates(param_00);
	handlekillstreaksonroundswitch(1);
	foreach(var_05 in level.players)
	{
		var_05 setclientdvar("ui_opensummary",1);
	}

	setdvar("g_deadChat",1);
	setdvar("ui_allow_teamchange",0);
	setdvar("bg_compassShowEnemies",0);
	freezeallplayers(1,1);
	var_07 = game["switchedsides"];
	if(!maps\mp\_utility::wasonlyround() && !param_02)
	{
		displayroundend(param_00,param_01);
		if(isdefined(level.finalkillcam_winner))
		{
			foreach(var_05 in level.players)
			{
				var_05 notify("reset_outcome");
			}

			level notify("game_cleanup");
			waittillfinalkillcamdone();
		}

		if(!maps\mp\_utility::waslastround())
		{
			maps\mp\_utility::levelflagclear("block_notifies");
			if(checkroundswitch())
			{
				displayroundswitch(var_07);
			}

			foreach(var_05 in level.players)
			{
				var_05.pers["stats"] = var_05.stats;
				var_05.pers["segments"] = var_05.segments;
			}

			level notify("restarting");
			game["state"] = "playing";
			setdvar("ui_game_state","playing");
			map_restart(1);
			return;
		}

		if(!level.forcedend)
		{
			var_03 = updateendreasontext(param_02);
		}
	}

	if(!isdefined(game["clientMatchDataDef"]))
	{
		game["clientMatchDataDef"] = "mp/clientmatchdata.ddl";
		setclientmatchdatadef(game["clientMatchDataDef"]);
	}

	maps\mp\gametypes\_misions::roundend(param_02);
	param_02 = getgamewinner(param_02,1);
	if(level.teambased)
	{
		setomnvar("ui_game_victor",0);
		if(param_02 == "allies")
		{
			setomnvar("ui_game_victor",2);
		}
		else if(param_02 == "axis")
		{
			setomnvar("ui_game_victor",1);
		}
	}

	displaygameend(param_02,var_03);
	var_0C = gettime();
	if(isdefined(level.finalkillcam_winner) && maps\mp\_utility::wasonlyround())
	{
		foreach(var_07 in level.players)
		{
			var_07 notify("reset_outcome");
		}

		level notify("game_cleanup");
		waittillfinalkillcamdone();
	}

	maps\mp\_utility::levelflagclear("block_notifies");
	level.intermission = 1;
	level notify("spawning_intermission");
	foreach(var_07 in level.players)
	{
		var_07 closepopupmenu();
		var_07 closeingamemenu();
		var_07 notify("reset_outcome");
		var_07 setclientomnvar("ui_toggle_final_scoreboard",1);
		var_07 thread maps\mp\gametypes\_playerlogic::spawnintermission();
	}

	processlobbydata();
	maps\mp\_skill::process();
	wait(1);
	checkforpersonalbests();
	updatecombatrecord();
	if(level.teambased)
	{
		if(param_02 == "axis" || param_02 == "allies")
		{
			setmatchdata("victor",param_02);
		}
		else
		{
			setmatchdata("victor","none");
		}

		setmatchdata("alliesScore",game["teamScores"]["allies"]);
		setmatchdata("axisScore",game["teamScores"]["axis"]);
		tournamentreportwinningteam(param_02);
	}
	else
	{
		setmatchdata("victor","none");
	}

	level maps\mp\_matchdata::endofgamesummarylogger();
	foreach(var_07 in level.players)
	{
		if(var_07 maps\mp\_utility::rankingenabled())
		{
			var_07 maps\mp\_matchdata::logfinalstats();
		}

		var_07 maps\mp\gametypes\_playerlogic::logplayerstats();
	}

	setmatchdata("host",maps\mp\gametypes\_playerlogic::truncateplayername(level.hostname));
	if(maps\mp\_utility::matchmakinggame())
	{
		setmatchdata("playlistVersion",getplaylistversion());
		setmatchdata("playlistID",getplaylistid());
		setmatchdata("isDedicated",isdedicatedserver());
	}

	setmatchdata("levelMaxClients",level.maxclients);
	sendmatchdata();
	var_13 = getmatchdata("victor");
	recordendgamecomscoreevent(var_13);
	foreach(var_07 in level.players)
	{
		var_07.pers["stats"] = var_07.stats;
		var_07.pers["segments"] = var_07.segments;
	}

	tournamentreportendofgame();
	var_16 = 0;
	if(isdefined(level.endgamewaitfunc))
	{
		[[ level.endgamewaitfunc ]](var_04,level.postgamenotifies,var_16,param_02);
	}
	else if(!var_04 && !level.postgamenotifies)
	{
		if(!maps\mp\_utility::wasonlyround())
		{
			wait(6 + var_16);
		}
		else
		{
			wait(min(10,4 + var_16 + level.postgamenotifies));
		}
	}
	else
	{
		wait(min(10,4 + var_16 + level.postgamenotifies));
	}

	var_17 = "_gamelogic.gsc";
	var_18 = "all";
	if(level.teambased && isdefined(param_02))
	{
		var_18 = param_02;
	}

	var_19 = "undefined";
	if(isdefined(var_03))
	{
		switch(var_03)
		{
			case 1:
				break;

			case 2:
				break;

			case 3:
				break;

			case 4:
				break;

			case 5:
				break;

			case 6:
				break;

			case 7:
				break;

			case 8:
				break;

			case 9:
				break;

			case 10:
				break;

			case 11:
				break;

			case 12:
				break;

			case 13:
				break;

			case 14:
				break;

			case 15:
				break;

			case 16:
				break;

			case 17:
				break;

			case 18:
				break;

			case 19:
				break;

			case 20:
				break;

			default:
				break;
		}
	}
}

//Function Number: 86
clearallnonplayerentities()
{
	var_00 = vehicle_getarray();
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	maps\mp\gametypes\_objpoints::deleteallobjpoints();
	if(isdefined(level.turrets))
	{
		foreach(var_05 in level.turrets)
		{
			var_05 delete();
		}
	}
}

//Function Number: 87
getgamewinner(param_00,param_01)
{
	if(!isstring(param_00))
	{
		return param_00;
	}

	var_02 = param_00;
	if(level.teambased && maps\mp\_utility::isroundbased() || level.gametype == "ctf" && level.gameended)
	{
		var_03 = "roundsWon";
		if(isdefined(level.winbycaptures) && level.winbycaptures)
		{
			var_03 = "teamScores";
		}

		if(game[var_03]["allies"] == game[var_03]["axis"])
		{
			var_02 = "tie";
		}
		else if(game[var_03]["axis"] > game[var_03]["allies"])
		{
			var_02 = "axis";
		}
		else
		{
			var_02 = "allies";
		}
	}

	if(param_01 && var_02 == "allies" || var_02 == "axis")
	{
		level.finalkillcam_winner = var_02;
	}

	return var_02;
}

//Function Number: 88
updateendreasontext(param_00)
{
	if(!level.teambased)
	{
		return 1;
	}

	if(maps\mp\_utility::hitroundlimit())
	{
		return game["end_reason"]["round_limit_reached"];
	}

	if(maps\mp\_utility::hitwinlimit())
	{
		return game["end_reason"]["score_limit_reached"];
	}

	return game["end_reason"]["objective_completed"];
}

//Function Number: 89
estimatedtimetillscorelimit(param_00)
{
	var_01 = getscoreperminute(param_00);
	var_02 = getscoreremaining(param_00);
	var_03 = 999999;
	if(var_01)
	{
		var_03 = var_02 / var_01;
	}

	return var_03;
}

//Function Number: 90
getscoreperminute(param_00)
{
	var_01 = maps\mp\_utility::getwatcheddvar("scorelimit");
	var_02 = maps\mp\_utility::gettimelimit();
	var_03 = maps\mp\_utility::gettimepassed() / 60000 + 0.0001;
	if(isplayer(self))
	{
		var_04 = self.score / var_03;
	}
	else
	{
		var_04 = getteamscore(var_01) / var_04;
	}

	return var_04;
}

//Function Number: 91
getscoreremaining(param_00)
{
	var_01 = maps\mp\_utility::getwatcheddvar("scorelimit");
	if(isplayer(self))
	{
		var_02 = var_01 - self.score;
	}
	else
	{
		var_02 = var_02 - getteamscore(var_01);
	}

	return var_02;
}

//Function Number: 92
givelastonteamwarning()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::waittillrecoveredhealth(3);
	thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive",self,self.pers["team"]);
	if(level.multiteambased)
	{
		foreach(var_01 in level.teamnamelist)
		{
			if(self.pers["team"] != var_01)
			{
				thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive",self,var_01);
			}
		}
	}
	else
	{
		var_03 = maps\mp\_utility::getotherteam(self.pers["team"]);
		thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive",self,var_03);
	}

	level notify("last_alive",self);
}

//Function Number: 93
processlobbydata()
{
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		var_02.clientmatchdataid = var_00;
		var_00++;
		if(isdefined(level.iszombiegame) && level.iszombiegame)
		{
			var_02.clientmatchdataid = var_02 getentitynumber();
		}

		setclientmatchdata("players",var_02.clientmatchdataid,"name",maps\mp\gametypes\_playerlogic::extractplayername(var_02.name));
		setclientmatchdata("players",var_02.clientmatchdataid,"clanTag",maps\mp\gametypes\_playerlogic::extractclantag(var_02.name));
		setclientmatchdata("players",var_02.clientmatchdataid,"xuid",var_02.xuid);
		var_03 = 0;
		var_04 = 0;
		if(isdefined(var_02.pers["rank"]))
		{
			var_03 = var_02.pers["rank"];
		}

		if(isdefined(var_02.pers["prestige"]))
		{
			var_04 = var_02.pers["prestige"];
		}

		setclientmatchdata("players",var_02.clientmatchdataid,"rank",var_03);
		setclientmatchdata("players",var_02.clientmatchdataid,"prestige",var_04);
	}

	maps\mp\_awards::assignawards();
	maps\mp\_scoreboard::processlobbyscoreboards();
	sendclientmatchdata();
	lootserviceonendgame();
}

//Function Number: 94
trackleaderboarddeathstats(param_00,param_01)
{
	thread threadedsetweaponstatbyname(param_00,1,"deaths");
}

//Function Number: 95
trackattackerleaderboarddeathstats(param_00,param_01,param_02)
{
	if(isdefined(self) && isplayer(self))
	{
		if(param_01 != "MOD_FALLING")
		{
			if(maps\mp\_utility::ismeleemod(param_01) && issubstr(param_00,"tactical"))
			{
				return;
			}

			var_03 = maps\mp\gametypes\_weapons::ismeleeinventoryweapon(param_00);
			if(var_03)
			{
				thread threadedincmeleekill();
			}

			if(maps\mp\_utility::ismeleemod(param_01) && !issubstr(param_00,"riotshield") && !issubstr(param_00,"combatknife") && !var_03)
			{
				thread threadedincmeleekill();
				return;
			}
			else if(maps\mp\_utility::isdestructibleweapon(param_00))
			{
				thread threadedincdestructiblekill();
				return;
			}

			thread threadedsetweaponstatbyname(param_00,1,"kills");
			var_04 = 0;
			if(isdefined(param_02) && isdefined(param_02.firedads))
			{
				var_04 = param_02.firedads;
			}
			else
			{
				var_04 = self playerads();
			}

			if(var_04 < 0.2)
			{
				thread threadedsetweaponstatbyname(param_00,1,"hipfirekills");
			}
		}

		if(param_01 == "MOD_HEAD_SHOT")
		{
			thread threadedsetweaponstatbyname(param_00,1,"headShots");
		}
	}
}

//Function Number: 96
setweaponstat(param_00,param_01,param_02)
{
	if(!param_01)
	{
		return;
	}

	var_03 = maps\mp\_utility::getweaponclass(param_00);
	if(var_03 == "killstreak" || var_03 == "other")
	{
		return;
	}

	if(maps\mp\_utility::isenvironmentweapon(param_00))
	{
		return;
	}

	if(maps\mp\_utility::isbombsiteweapon(param_00))
	{
		return;
	}

	if(var_03 == "weapon_grenade" || var_03 == "weapon_explosive")
	{
		var_04 = maps\mp\_utility::strip_suffix(param_00,"_lefthand");
		var_04 = maps\mp\_utility::strip_suffix(var_04,"_mp");
		maps\mp\gametypes\_persistence::incrementweaponstat(var_04,param_02,param_01);
		maps\mp\_matchdata::logweaponstat(var_04,param_02,param_01);
		return;
	}

	var_05 = maps\mp\gametypes\_weapons::isprimaryorsecondaryprojectileweapon(param_01);
	var_06 = getsubstr(param_01,0,4) == "alt_";
	var_07 = maps\mp\gametypes\_weapons::ismeleeinventoryweapon(param_01);
	if(var_03 != "timeInUse" && var_03 != "deaths" && !var_05 && !var_06 && !var_07)
	{
		var_08 = param_01;
		param_01 = self getcurrentweapon();
		if(param_01 != var_08 && maps\mp\_utility::iskillstreakweapon(param_01))
		{
			return;
		}
	}

	if(!isdefined(self.trackingweaponname))
	{
		self.trackingweaponname = param_01;
	}

	if(param_01 != self.trackingweaponname)
	{
		maps\mp\gametypes\_persistence::updateweaponbufferedstats();
		self.trackingweaponname = param_01;
		self.currentfirefightshots = 0;
	}

	switch(var_03)
	{
		case "shots":
			break;

		case "hits":
			break;

		case "headShots":
			break;

		case "kills":
			break;

		case "hipfirekills":
			break;

		case "timeInUse":
			break;
	}
}

//Function Number: 97
setinflictorstat(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_01 setweaponstat(param_02,1,"hits");
		return;
	}

	if(!isdefined(param_00.playeraffectedarray))
	{
		param_00.playeraffectedarray = [];
	}

	var_03 = 1;
	for(var_04 = 0;var_04 < param_00.playeraffectedarray.size;var_04++)
	{
		if(param_00.playeraffectedarray[var_04] == self)
		{
			var_03 = 0;
			break;
		}
	}

	if(var_03)
	{
		param_00.playeraffectedarray[param_00.playeraffectedarray.size] = self;
		param_01 setweaponstat(param_02,1,"hits");
	}
}

//Function Number: 98
threadedsetweaponstatbyname(param_00,param_01,param_02)
{
	self endon("disconnect");
	waittillframeend;
	setweaponstat(param_00,param_01,param_02);
}

//Function Number: 99
threadedincmeleekill()
{
	self endon("disconnect");
	waittillframeend;
	maps\mp\gametypes\_persistence::incrementmeleestat();
}

//Function Number: 100
threadedincdestructiblekill()
{
	self endon("disconnect");
	waittillframeend;
	maps\mp\gametypes\_persistence::incrementdestructiblestat();
}

//Function Number: 101
checkforpersonalbests()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 maps\mp\_utility::rankingenabled())
		{
			var_02 = var_01 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","kills");
			var_03 = var_01 getplayerdata(common_scripts\utility::getstatsgroup_common(),"round","deaths");
			var_04 = var_01.pers["summary"]["xp"];
			var_05 = var_01.score;
			var_06 = getroundaccuracy(var_01);
			var_07 = var_01 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestKills");
			var_08 = var_01 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"mostDeaths");
			var_09 = var_01 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"mostXp");
			var_0A = var_01 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestScore");
			var_0B = var_01 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestAccuracy");
			if(var_02 > var_07)
			{
				var_01 setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestKills",var_02);
			}

			if(var_04 > var_09)
			{
				var_01 setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"mostXp",var_04);
			}

			if(var_03 > var_08)
			{
				var_01 setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"mostDeaths",var_03);
			}

			if(var_05 > var_0A)
			{
				var_01 setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestScore",var_05);
			}

			if(var_06 > var_0B)
			{
				var_01 setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestAccuracy",var_06);
			}

			var_01 checkforbestweapon();
			var_01 maps\mp\_matchdata::logplayerxp(var_04,"totalXp");
			var_01 maps\mp\_matchdata::logplayerxp(var_01.pers["summary"]["score"],"scoreXp");
			var_01 maps\mp\_matchdata::logplayerxp(var_01.pers["summary"]["challenge"],"challengeXp");
			var_01 maps\mp\_matchdata::logplayerxp(var_01.pers["summary"]["match"],"matchXp");
			var_01 maps\mp\_matchdata::logplayerxp(var_01.pers["summary"]["misc"],"miscXp");
		}

		if(isdefined(var_01.pers["confirmed"]))
		{
			var_01 maps\mp\_matchdata::logkillsconfirmed();
		}

		if(isdefined(var_01.pers["denied"]))
		{
			var_01 maps\mp\_matchdata::logkillsdenied();
		}
	}
}

//Function Number: 102
getroundaccuracy(param_00)
{
	var_01 = float(param_00 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"totalShots") - param_00.pers["previous_shots"]);
	if(var_01 == 0)
	{
		return 0;
	}

	var_02 = float(param_00 getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"hits") - param_00.pers["previous_hits"]);
	var_03 = clamp(var_02 / var_01,0,1) * 10000;
	return int(var_03);
}

//Function Number: 103
checkforbestweapon()
{
	var_00 = maps\mp\_matchdata::buildbaseweaponlist();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		var_02 = maps\mp\_utility::getbaseweaponname(var_02);
		var_03 = maps\mp\_utility::getweaponclass(var_02);
		if(!maps\mp\_utility::iskillstreakweapon(var_02) && var_03 != "killstreak" && var_03 != "other")
		{
			var_04 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestWeapon","kills");
			var_05 = 0;
			if(isdefined(self.pers["mpWeaponStats"][var_02]) && isdefined(self.pers["mpWeaponStats"][var_02]["kills"]))
			{
				var_05 = self.pers["mpWeaponStats"][var_02]["kills"];
				if(var_05 > var_04)
				{
					self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestWeapon","kills",var_05);
					var_06 = 0;
					if(isdefined(self.pers["mpWeaponStats"][var_02]["shots"]))
					{
						var_06 = self.pers["mpWeaponStats"][var_02]["shots"];
					}

					var_07 = 0;
					if(isdefined(self.pers["mpWeaponStats"][var_02]["headShots"]))
					{
						var_07 = self.pers["mpWeaponStats"][var_02]["headShots"];
					}

					var_08 = 0;
					if(isdefined(self.pers["mpWeaponStats"][var_02]["hits"]))
					{
						var_08 = self.pers["mpWeaponStats"][var_02]["hits"];
					}

					var_09 = 0;
					if(isdefined(self.pers["mpWeaponStats"][var_02]["deaths"]))
					{
						var_09 = self.pers["mpWeaponStats"][var_02]["deaths"];
					}

					self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestWeapon","shots",var_06);
					self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestWeapon","headShots",var_07);
					self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestWeapon","hits",var_08);
					self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestWeapon","deaths",var_09);
					var_0A = int(tablelookup("mp/statstable.csv",4,var_02,0));
					self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"bestWeaponIndex",var_0A);
				}
			}
		}
	}
}

//Function Number: 104
updatecombatrecordforplayertrends()
{
	var_00 = 5;
	var_01 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord","numTrends");
	var_01++;
	if(var_01 > var_00)
	{
		var_01 = var_00;
		if(var_00 > 1)
		{
			for(var_02 = 0;var_02 < var_00 - 1;var_02++)
			{
				var_03 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord","trend",var_02 + 1,"timestamp");
				var_04 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord","trend",var_02 + 1,"kills");
				var_05 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord","trend",var_02 + 1,"deaths");
				self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord","trend",var_02,"timestamp",var_03);
				self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord","trend",var_02,"kills",var_04);
				self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord","trend",var_02,"deaths",var_05);
			}
		}
	}

	var_03 = maps\mp\_utility::gettimeutc_for_stat_recording();
	var_04 = self.kills;
	var_05 = self.deaths;
	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord","trend",var_01 - 1,"timestamp",var_03);
	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord","trend",var_01 - 1,"kills",var_04);
	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord","trend",var_01 - 1,"deaths",var_05);
	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord","numTrends",var_01);
}

//Function Number: 105
updatecombatrecordcommondata()
{
	var_00 = maps\mp\_utility::gettimeutc_for_stat_recording();
	setcombatrecordstat("timeStampLastGame",var_00);
	incrementcombatrecordstat("numMatches",1);
	incrementcombatrecordstat("timePlayed",self.timeplayed["total"]);
	incrementcombatrecordstat("kills",self.kills);
	incrementcombatrecordstat("deaths",self.deaths);
	incrementcombatrecordstat("xpEarned",self.pers["summary"]["xp"]);
	if(isdefined(self.combatrecordwin))
	{
		incrementcombatrecordstat("wins",1);
	}

	if(isdefined(self.combatrecordtie))
	{
		incrementcombatrecordstat("ties",1);
	}

	var_01 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord",level.gametype,"timeStampFirstGame");
	if(var_01 == 0)
	{
		setcombatrecordstat("timeStampFirstGame",var_00);
	}
}

//Function Number: 106
incrementcombatrecordstat(param_00,param_01)
{
	var_02 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord",level.gametype,param_00);
	var_02 = var_02 + param_01;
	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord",level.gametype,param_00,var_02);
}

//Function Number: 107
setcombatrecordstat(param_00,param_01)
{
	self setplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord",level.gametype,param_00,param_01);
}

//Function Number: 108
setcombatrecordstatifgreater(param_00,param_01)
{
	var_02 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"combatRecord",level.gametype,param_00);
	if(param_01 > var_02)
	{
		setcombatrecordstat(param_00,param_01);
	}
}

//Function Number: 109
updatecombatrecordforplayergamemodes()
{
	if(level.gametype == "war" || level.gametype == "dm")
	{
		updatecombatrecordcommondata();
		var_00 = self.deaths;
		if(var_00 == 0)
		{
			var_00 = 1;
		}

		var_01 = int(self.kills / var_00) * 1000;
		setcombatrecordstatifgreater("mostkills",self.kills);
		setcombatrecordstatifgreater("bestkdr",var_01);
		return;
	}

	if(level.gametype == "ctf")
	{
		updatecombatrecordcommondata();
		var_02 = maps\mp\_utility::getpersstat("captures");
		var_03 = maps\mp\_utility::getpersstat("returns");
		incrementcombatrecordstat("captures",var_02);
		incrementcombatrecordstat("returns",var_03);
		setcombatrecordstatifgreater("mostcaptures",var_02);
		setcombatrecordstatifgreater("mostreturns",var_03);
		return;
	}

	if(level.gametype == "dom")
	{
		updatecombatrecordcommondata();
		var_02 = maps\mp\_utility::getpersstat("captures");
		var_04 = maps\mp\_utility::getpersstat("defends");
		incrementcombatrecordstat("captures",var_02);
		incrementcombatrecordstat("defends",var_04);
		setcombatrecordstatifgreater("mostcaptures",var_02);
		setcombatrecordstatifgreater("mostdefends",var_04);
		return;
	}

	if(level.gametype == "conf")
	{
		updatecombatrecordcommondata();
		var_05 = maps\mp\_utility::getpersstat("confirmed");
		var_06 = maps\mp\_utility::getpersstat("denied");
		incrementcombatrecordstat("confirms",var_05);
		incrementcombatrecordstat("denies",var_06);
		setcombatrecordstatifgreater("mostconfirms",var_05);
		setcombatrecordstatifgreater("mostdenies",var_06);
		return;
	}

	if(level.gametype == "sd")
	{
		updatecombatrecordcommondata();
		var_07 = maps\mp\_utility::getpersstat("plants");
		var_08 = maps\mp\_utility::getpersstat("defuses");
		var_09 = maps\mp\_utility::getpersstat("destructions");
		incrementcombatrecordstat("plants",var_07);
		incrementcombatrecordstat("defuses",var_08);
		incrementcombatrecordstat("detonates",var_09);
		setcombatrecordstatifgreater("mostplants",var_07);
		setcombatrecordstatifgreater("mostdefuses",var_08);
		setcombatrecordstatifgreater("mostdetonates",var_09);
		return;
	}

	if(level.gametype == "hp")
	{
		updatecombatrecordcommondata();
		var_02 = maps\mp\_utility::getpersstat("captures");
		var_04 = maps\mp\_utility::getpersstat("defends");
		var_0A = maps\mp\_utility::getpersstat("captureTime");
		incrementcombatrecordstat("captures",var_02);
		incrementcombatrecordstat("defends",var_04);
		incrementcombatrecordstat("captureTime",var_0A);
		setcombatrecordstatifgreater("mostcaptures",var_02);
		setcombatrecordstatifgreater("mostdefends",var_04);
		setcombatrecordstatifgreater("mostCaptureTime",var_0A);
		return;
	}

	if(level.gametype == "sr")
	{
		updatecombatrecordcommondata();
		var_07 = maps\mp\_utility::getpersstat("plants");
		var_08 = maps\mp\_utility::getpersstat("defuses");
		var_09 = maps\mp\_utility::getpersstat("destructions");
		var_05 = maps\mp\_utility::getpersstat("confirmed");
		var_06 = maps\mp\_utility::getpersstat("denied");
		incrementcombatrecordstat("plants",var_07);
		incrementcombatrecordstat("defuses",var_08);
		incrementcombatrecordstat("detonates",var_09);
		incrementcombatrecordstat("confirms",var_05);
		incrementcombatrecordstat("denies",var_06);
		setcombatrecordstatifgreater("mostplants",var_07);
		setcombatrecordstatifgreater("mostdefuses",var_08);
		setcombatrecordstatifgreater("mostdetonates",var_09);
		setcombatrecordstatifgreater("mostconfirms",var_05);
		setcombatrecordstatifgreater("mostdenies",var_06);
		return;
	}

	if(level.gametype == "infect")
	{
		updatecombatrecordcommondata();
		var_0B = maps\mp\_utility::getplayerstat("contagious");
		var_0C = self.kills - var_0B;
		incrementcombatrecordstat("infectedKills",var_0C);
		incrementcombatrecordstat("survivorKills",var_0B);
		setcombatrecordstatifgreater("mostInfectedKills",var_0C);
		setcombatrecordstatifgreater("mostSurvivorKills",var_0B);
		return;
	}

	if(level.gametype == "gun")
	{
		updatecombatrecordcommondata();
		var_0D = maps\mp\_utility::getplayerstat("levelup");
		var_0E = maps\mp\_utility::getplayerstat("humiliation");
		incrementcombatrecordstat("gunPromotions",var_0D);
		incrementcombatrecordstat("stabs",var_0E);
		setcombatrecordstatifgreater("mostGunPromotions",var_0D);
		setcombatrecordstatifgreater("mostStabs",var_0E);
		return;
	}

	if(level.gametype == "ball")
	{
		updatecombatrecordcommondata();
		var_0F = maps\mp\_utility::getplayerstat("fieldgoal") + maps\mp\_utility::getplayerstat("touchdown") * 2;
		var_10 = maps\mp\_utility::getplayerstat("killedBallCarrier");
		incrementcombatrecordstat("pointsScored",var_0F);
		incrementcombatrecordstat("killedBallCarrier",var_10);
		setcombatrecordstatifgreater("mostPointsScored",var_0F);
		setcombatrecordstatifgreater("mostKilledBallCarrier",var_10);
		return;
	}

	if(level.gametype == "twar")
	{
		updatecombatrecordcommondata();
		var_02 = maps\mp\_utility::getpersstat("captures");
		var_11 = maps\mp\_utility::getplayerstat("kill_while_capture");
		incrementcombatrecordstat("captures",var_02);
		incrementcombatrecordstat("killWhileCaptures",var_11);
		setcombatrecordstatifgreater("mostCaptures",var_02);
		setcombatrecordstatifgreater("mostKillWhileCaptures",var_11);
		return;
	}

	if(level.gametype == "sab")
	{
		updatecombatrecordcommondata();
		var_07 = maps\mp\_utility::getpersstat("plants");
		var_08 = maps\mp\_utility::getpersstat("defuses");
		var_09 = maps\mp\_utility::getpersstat("destructions");
		incrementcombatrecordstat("plants",var_07);
		incrementcombatrecordstat("defuses",var_08);
		incrementcombatrecordstat("detonates",var_09);
		setcombatrecordstatifgreater("mostplants",var_07);
		setcombatrecordstatifgreater("mostdefuses",var_08);
		setcombatrecordstatifgreater("mostdetonates",var_09);
		return;
	}

	if(level.gametype == "koth")
	{
		updatecombatrecordcommondata();
		var_02 = maps\mp\_utility::getpersstat("captures");
		var_04 = maps\mp\_utility::getpersstat("defends");
		incrementcombatrecordstat("captures",var_02);
		incrementcombatrecordstat("defends",var_04);
		setcombatrecordstatifgreater("mostcaptures",var_02);
		setcombatrecordstatifgreater("mostdefends",var_04);
		return;
	}

	if(level.gametype == "dd")
	{
		updatecombatrecordcommondata();
		var_07 = maps\mp\_utility::getpersstat("plants");
		var_08 = maps\mp\_utility::getpersstat("defuses");
		var_09 = maps\mp\_utility::getpersstat("destructions");
		incrementcombatrecordstat("plants",var_07);
		incrementcombatrecordstat("defuses",var_08);
		incrementcombatrecordstat("detonates",var_09);
		setcombatrecordstatifgreater("mostplants",var_07);
		setcombatrecordstatifgreater("mostdefuses",var_08);
		setcombatrecordstatifgreater("mostdetonates",var_09);
		return;
	}
}

//Function Number: 110
updatecombatrecordforplayer()
{
	updatecombatrecordforplayertrends();
	updatecombatrecordforplayergamemodes();
}

//Function Number: 111
updatecombatrecord()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 maps\mp\_utility::rankingenabled())
		{
			var_01 updatecombatrecordforplayer();
		}

		level maps\mp\gametypes\_playerlogic::writesegmentdata(var_01);
	}
}