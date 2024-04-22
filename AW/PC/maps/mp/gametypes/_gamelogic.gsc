/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_gamelogic.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 97
 * Decompile Time: 1477 ms
 * Timestamp: 4/22/2024 2:09:25 AM
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

		if(maps\mp\_utility::practiceroundgame())
		{
			var_00 = "none";
		}

		logstring("time limit, win: " + var_00 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		var_00 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
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
		var_00 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
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
		var_01 = maps\mp\gametypes\_gamescore::getwinningteam();
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
		var_01 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
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
	return 1;
}

//Function Number: 11
updategameevents()
{
	if(maps\mp\_utility::matchmakinggame() && !level.ingraceperiod && !getdvarint("force_ranking") && !isdefined(level.disableforfeit) || !level.disableforfeit)
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
			if(level.teamcount["allies"] + level.teamcount["axis"] == 1 && level.maxplayercount >= 1 && !getdvarint("virtualLobbyActive",0))
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
	param_00.hasdonecombat = param_01;
	param_00 notify("hasDoneCombat");
	var_02 = !isdefined(param_00.hasdoneanycombat) || !param_00.hasdoneanycombat;
	if(var_02 && param_01)
	{
		param_00.hasdoneanycombat = 1;
		param_00.pers["participation"] = 1;
		if(isdefined(param_00.pers["hasMatchLoss"]) && param_00.pers["hasMatchLoss"])
		{
			return;
		}

		updatelossstats(param_00);
	}
}

//Function Number: 18
updatewinstats(param_00)
{
	if(!param_00 maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if((!isdefined(param_00.hasdoneanycombat) || !param_00.hasdoneanycombat) && !level.gametype == "infect")
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
	param_00 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_wins");
	param_00.combatrecordwin = 1;
	param_00 maps\mp\gametypes\_missions::processchallengedaily(25,undefined,undefined);
	param_00 maps\mp\gametypes\_missions::processchallengedaily(26,undefined,undefined);
	param_00 maps\mp\gametypes\_missions::processchallengedaily(27,undefined,undefined);
	param_00 maps\mp\gametypes\_missions::processchallengedaily(28,undefined,undefined);
	param_00 maps\mp\gametypes\_missions::processchallengedaily(29,undefined,undefined);
	param_00 maps\mp\gametypes\_missions::processchallengedaily(30,undefined,undefined);
	param_00 maps\mp\gametypes\_missions::processchallengedaily(36,undefined,undefined);
	param_00 maps\mp\gametypes\_missions::processchallengedaily(37,undefined,undefined);
	if(maps\mp\_utility::isgrapplinghookgamemode())
	{
		param_00 maps\mp\gametypes\_missions::processchallenge("ch_tier2_4_iw5_dlcgun12");
	}

	if(level.players.size > 5)
	{
		superstarchallenge(param_00);
		switch(level.gametype)
		{
			case "war":
				if(game["teamScores"][param_00.team] >= game["teamScores"][maps\mp\_utility::getotherteam(param_00.team)] + 20)
				{
					param_00 maps\mp\gametypes\_missions::processchallenge("ch_war_crushing");
				}
				break;

			case "hp":
				if(game["teamScores"][param_00.team] >= game["teamScores"][maps\mp\_utility::getotherteam(param_00.team)] + 70)
				{
					param_00 maps\mp\gametypes\_missions::processchallenge("ch_hp_crushing");
				}
				break;

			case "conf":
				if(game["teamScores"][param_00.team] >= game["teamScores"][maps\mp\_utility::getotherteam(param_00.team)] + 15)
				{
					param_00 maps\mp\gametypes\_missions::processchallenge("ch_conf_crushing");
				}
				break;

			case "ball":
				if(game["teamScores"][param_00.team] >= game["teamScores"][maps\mp\_utility::getotherteam(param_00.team)] + 7)
				{
					param_00 maps\mp\gametypes\_missions::processchallenge("ch_ball_crushing");
				}
				break;

			case "infect":
				if(param_00.team == "allies")
				{
					if(game["teamScores"][param_00.team] >= 4)
					{
						param_00 maps\mp\gametypes\_missions::processchallenge("ch_infect_crushing");
					}
	
					if(game["teamScores"][maps\mp\_utility::getotherteam(param_00.team)] == 1)
					{
						param_00 maps\mp\gametypes\_missions::processchallenge("ch_infect_cleanup");
					}
				}
				break;

			case "dm":
				if(isdefined(level.placement["all"][0]))
				{
					var_02 = level.placement["all"][0];
					var_03 = 9999;
					if(param_00 == var_02)
					{
						foreach(var_05 in level.players)
						{
							if(param_00 == var_05)
							{
								continue;
							}
	
							var_06 = param_00.score - var_05.score;
							if(var_06 < var_03)
							{
								var_03 = var_06;
							}
						}
	
						if(var_03 >= 7)
						{
							param_00 maps\mp\gametypes\_missions::processchallenge("ch_dm_crushing");
						}
					}
				}
				break;

			case "gun":
				foreach(var_09 in level.players)
				{
					if(param_00 == var_09)
					{
						continue;
					}
	
					if(param_00.score < var_09.score + 5)
					{
						break;
					}
				}
	
				param_00 maps\mp\gametypes\_missions::processchallenge("ch_gun_crushing");
				break;

			case "twar":
			case "ctf":
				if(game["shut_out"][param_00.team])
				{
					param_00 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_crushing");
				}
				break;
		}
	}
}

//Function Number: 19
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
		param_00 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_star");
	}
}

//Function Number: 20
checkgameendchallenges()
{
	if(level.gametype == "dom")
	{
		foreach(var_01 in level.domflags)
		{
			if(!isdefined(var_01.ownedtheentireround) || !var_01.ownedtheentireround)
			{
				continue;
			}

			var_02 = var_01 maps\mp\gametypes\_gameobjects::getownerteam();
			foreach(var_04 in level.players)
			{
				if(var_04.team != var_02)
				{
					continue;
				}

				switch(var_01.label)
				{
					case "_a":
						var_04 maps\mp\gametypes\_missions::processchallenge("ch_dom_alphalock");
						break;

					case "_b":
						var_04 maps\mp\gametypes\_missions::processchallenge("ch_dom_bravolock");
						break;

					case "_c":
						var_04 maps\mp\gametypes\_missions::processchallenge("ch_dom_charlielock");
						break;
				}
			}
		}
	}
}

//Function Number: 21
updatelossstats(param_00)
{
	if(!param_00 maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(!isdefined(param_00.hasdoneanycombat) || !param_00.hasdoneanycombat)
	{
		return;
	}

	param_00.pers["hasMatchLoss"] = 1;
	param_00 maps\mp\gametypes\_persistence::statadd("losses",1);
	param_00 maps\mp\_utility::updatepersratio("winLossRatio","wins","losses");
	param_00 maps\mp\gametypes\_persistence::statsetchild("round","loss",1);
}

//Function Number: 22
updatetiestats(param_00)
{
	if(!param_00 maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(!isdefined(param_00.hasdoneanycombat) || !param_00.hasdoneanycombat)
	{
		return;
	}

	param_00 maps\mp\gametypes\_persistence::statadd("losses",-1);
	param_00 maps\mp\gametypes\_persistence::statadd("ties",1);
	param_00 maps\mp\_utility::updatepersratio("winLossRatio","wins","losses");
	param_00 maps\mp\gametypes\_persistence::statset("currentWinStreak",0);
	param_00.combatrecordtie = 1;
}

//Function Number: 23
updatewinlossstats(param_00)
{
	if(maps\mp\_utility::privatematch())
	{
		return;
	}

	if(maps\mp\_utility::practiceroundgame())
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
			var_04 = maps\mp\gametypes\_gamescore::gethighestscoringplayersarray(3);
		}

		foreach(var_02 in var_04)
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

			updatewinstats(var_02);
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

			if(param_00 == "tie")
			{
				updatetiestats(var_02);
				continue;
			}

			if(var_02.pers["team"] == param_00)
			{
				updatewinstats(var_02);
				continue;
			}

			var_02 maps\mp\gametypes\_persistence::statset("currentWinStreak",0);
		}
	}

	if(level.players.size > 5)
	{
		var_04 = maps\mp\gametypes\_gamescore::gethighestscoringplayersarray(3);
		for(var_09 = 0;var_09 < var_04.size;var_09++)
		{
			if(var_09 == 0)
			{
				var_04[var_09] maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_mvp");
			}

			var_04[var_09] maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_superior");
		}
	}
}

//Function Number: 24
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

//Function Number: 25
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

	if(maps\mp\_utility::practiceroundgame())
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
				continue;
			}

			if(level.hostforcedend && var_04 ishost())
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

//Function Number: 26
givematchbonus(param_00,param_01)
{
	self endon("disconnect");
	level waittill("give_match_bonus");
	maps\mp\gametypes\_rank::giverankxp(param_00,param_01);
	maps\mp\_utility::logxpgains();
}

//Function Number: 27
setxenonranks(param_00)
{
	var_01 = level.players;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(!isdefined(var_03.score) || !isdefined(var_03.pers["team"]))
		{
			continue;
		}
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(!isdefined(var_03.score) || !isdefined(var_03.pers["team"]))
		{
			continue;
		}

		var_04 = var_03.score;
		if(maps\mp\_utility::getminutespassed())
		{
			var_04 = var_03.score / maps\mp\_utility::getminutespassed();
		}

		setplayerteamrank(var_03,var_03.clientid,int(var_04));
	}
}

//Function Number: 28
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

//Function Number: 29
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
			game["round_time_to_beat"] = maps\mp\_utility::getminutespassed();
			return 1;
		}
	}

	return 0;
}

//Function Number: 30
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

//Function Number: 31
gettimeremaining()
{
	var_00 = maps\mp\_utility::gettimepassed();
	var_01 = maps\mp\_utility::gettimelimit() * 60 * 1000;
	if(maps\mp\_utility::gethalftime() && game["status"] == "halftime" && isdefined(level.firsthalftimepassed))
	{
		var_02 = var_01 * 0.5;
		if(level.firsthalftimepassed < var_02)
		{
			if(level.halftimeonscorelimit)
			{
				var_00 = var_01 - level.firsthalftimepassed + var_00 - level.firsthalftimepassed;
			}
			else
			{
				var_00 = var_00 + var_02 - level.firsthalftimepassed;
			}
		}
	}

	return var_01 - var_00;
}

//Function Number: 32
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

//Function Number: 33
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
	if(var_00 < 2)
	{
		level notify("match_ending_soon","score");
	}
}

//Function Number: 34
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
			return 0;
		}
	}
	else if(level.teambased)
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

//Function Number: 35
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

//Function Number: 36
matchstarttimerwaitforplayers()
{
	setomnvar("ui_match_countdown_title",6);
	setomnvar("ui_match_countdown_toggle",0);
	if(level.currentgen)
	{
		setomnvar("ui_cg_world_blur",1);
	}

	waitforplayers(level.prematchperiod);
	if(level.prematchperiodend > 0 && !isdefined(level.hostmigrationtimer))
	{
		matchstarttimer(level.prematchperiodend);
	}
}

//Function Number: 37
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

	if(level.xpscale > 1 && !isdefined(level.ishorde) && level.ishorde && !maps\mp\_utility::privatematch() && !maps\mp\_utility::practiceroundgame() && !isdefined(level.iszombiegame) && level.iszombiegame)
	{
		foreach(var_02 in level.players)
		{
			var_02 thread maps\mp\gametypes\_hud_message::splashnotify("double_xp");
		}
	}

	setomnvar("ui_match_countdown_toggle",0);
	setomnvar("ui_match_countdown",0);
	setomnvar("ui_match_countdown_title",2);
	level endon("match_forfeit_timer_beginning");
	wait(1.5);
	setomnvar("ui_match_countdown_title",0);
}

//Function Number: 38
matchstarttimer(param_00)
{
	self notify("matchStartTimer");
	self endon("matchStartTimer");
	level notify("match_start_timer_beginning");
	var_01 = int(param_00);
	if(var_01 >= 2)
	{
		matchstarttimer_internal(var_01);
		visionsetnaked("",3);
		return;
	}

	if(level.currentgen)
	{
		setomnvar("ui_cg_world_blur_fade_out",1);
	}

	if(level.xpscale > 1 && !isdefined(level.ishorde) && level.ishorde && !maps\mp\_utility::privatematch() && !maps\mp\_utility::practiceroundgame() && !isdefined(level.iszombiegame) && level.iszombiegame)
	{
		foreach(var_03 in level.players)
		{
			var_03 thread maps\mp\gametypes\_hud_message::splashnotify("double_xp");
		}
	}

	visionsetnaked("",1);
}

//Function Number: 39
matchstarttimerskip()
{
	visionsetnaked("",0);
}

//Function Number: 40
onroundswitch()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(game["roundsWon"]["allies"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1)
	{
		var_00 = getbetterteam();
		if(var_00 != game["defenders"])
		{
			game["switchedsides"] = !game["switchedsides"];
		}

		level.halftimetype = "overtime";
		game["dynamicEvent_Overtime"] = 1;
		return;
	}

	level.halftimetype = "halftime";
	game["switchedsides"] = !game["switchedsides"];
}

//Function Number: 41
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

//Function Number: 42
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

//Function Number: 43
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

//Function Number: 44
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

//Function Number: 45
hostidledout()
{
	var_00 = gethostplayer();
	if(isdefined(var_00) && !var_00.hasspawned && !isdefined(var_00.selectedclass))
	{
		return 1;
	}

	return 0;
}

//Function Number: 46
roundendwait(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		var_03 maps\mp\gametypes\_damage::streamfinalkillcam();
	}

	var_05 = 0;
	while(!var_05)
	{
		var_06 = level.players;
		var_05 = 1;
		foreach(var_03 in var_06)
		{
			if(!isdefined(var_03.doingsplash))
			{
				continue;
			}

			if(!var_03 maps\mp\gametypes\_hud_message::isdoingsplash())
			{
				continue;
			}

			var_05 = 0;
		}

		wait(0.5);
	}

	if(!param_01)
	{
		wait(param_00);
		var_06 = level.players;
		foreach(var_03 in var_06)
		{
			var_03 setclientomnvar("ui_round_end",0);
		}

		level notify("round_end_finished");
		return;
	}

	wait(var_02 / 2);
	level notify("give_match_bonus");
	wait(var_02 / 2);
	var_07 = 0;
	while(!var_07)
	{
		var_08 = level.players;
		var_07 = 1;
		foreach(var_05 in var_08)
		{
			if(!isdefined(var_05.doingsplash))
			{
				continue;
			}

			if(!var_05 maps\mp\gametypes\_hud_message::isdoingsplash())
			{
				continue;
			}

			var_07 = 0;
		}

		wait(0.5);
	}

	var_08 = level.players;
	foreach(var_05 in var_08)
	{
		var_05 setclientomnvar("ui_round_end",0);
	}

	level notify("round_end_finished");
}

//Function Number: 47
roundenddof(param_00)
{
	self setdepthoffield(0,128,512,4000,6,1.8);
}

//Function Number: 48
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
				var_00 = "sentinel";
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
				var_01 = "atlas";
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
		game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
		game["strings"]["change_class_cancel"] = &"MP_CHANGE_CLASS_CANCEL";
		game["strings"]["change_class_wait"] = &"MP_CHANGE_CLASS_WAIT";
		game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
		game["strings"]["final_stand"] = &"MPUI_FINAL_STAND";
		game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";
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
	thread maps\mp\_teleport::main();
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
	thread maps\mp\gametypes\_high_jump_mp::init();
	thread maps\mp\_grappling_hook::init();
	thread maps\mp\_matchdata::init();
	thread maps\mp\_awards::init();
	thread maps\mp\_areas::init();
	if(!maps\mp\_utility::invirtuallobby())
	{
		thread maps\mp\killstreaks\_killstreaks_init::init();
	}

	thread maps\mp\perks\_perks::init();
	thread maps\mp\_events::init();
	thread maps\mp\gametypes\_damage::initfinalkillcam();
	thread maps\mp\_threatdetection::init();
	thread maps\mp\_exo_suit::init();
	thread maps\mp\_reinforcements::init();
	thread maps\mp\_snd_common_mp::init();
	thread maps\mp\_utility::buildattachmentmaps();
	if(level.teambased)
	{
		thread maps\mp\gametypes\_friendicons::init();
	}

	thread maps\mp\gametypes\_hud_message::init();
	thread maps\mp\gametypes\_divisions::init();
	foreach(var_05 in game["strings"])
	{
		precachestring(var_05);
	}

	foreach(var_08 in game["icons"])
	{
		precacheshader(var_08);
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

	var_0A = getdvarfloat("scr_" + level.gametype + "_waverespawndelay");
	if(var_0A > 0)
	{
		level.wavedelay["allies"] = var_0A;
		level.wavedelay["axis"] = var_0A;
		level.lastwave["allies"] = 0;
		level.lastwave["axis"] = 0;
		if(level.multiteambased)
		{
			for(var_03 = 0;var_03 < level.teamnamelist.size;var_03++)
			{
				level._wavedelay[level.teamnamelist[var_03]] = var_0A;
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
		maps\mp\gametypes\_gamescore::updateteamscore("axis");
		maps\mp\gametypes\_gamescore::updateteamscore("allies");
		if(level.multiteambased)
		{
			for(var_03 = 0;var_03 < level.teamnamelist.size;var_03++)
			{
				maps\mp\gametypes\_gamescore::updateteamscore(level.teamnamelist[var_03]);
			}
		}
	}
	else
	{
		thread maps\mp\gametypes\_gamescore::initialdmscoreupdate();
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

//Function Number: 49
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

//Function Number: 50
callback_codeendgame()
{
	endparty();
	if(!level.gameended)
	{
		level thread forceend();
	}
}

//Function Number: 51
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

//Function Number: 52
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
				wait(0.1);
				continue;
			}
		}

		wait(1);
	}
}

//Function Number: 53
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

//Function Number: 54
playtickingsound()
{
	self endon("death");
	self endon("stop_ticking");
	level endon("game_ended");
	var_00 = level.bombtimer;
	for(;;)
	{
		self playsound("ui_mp_suitcasebomb_timer");
		if(var_00 > 10)
		{
			var_00 = var_00 - 1;
			wait(1);
		}
		else if(var_00 > 4)
		{
			var_00 = var_00 - 0.5;
			wait(0.5);
		}
		else if(var_00 > 1)
		{
			var_00 = var_00 - 0.4;
			wait(0.4);
		}
		else
		{
			var_00 = var_00 - 0.3;
			wait(0.3);
		}

		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 55
stoptickingsound()
{
	self notify("stop_ticking");
}

//Function Number: 56
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

//Function Number: 57
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

//Function Number: 58
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
	}
}

//Function Number: 59
pausetimer()
{
	level.timerstoppedforgamemode = 1;
	updatetimerpausedness();
}

//Function Number: 60
resumetimer()
{
	level.timerstoppedforgamemode = 0;
	updatetimerpausedness();
}

//Function Number: 61
startgame()
{
	thread gametimer();
	level.timerstopped = 0;
	level.timerstoppedforgamemode = 0;
	setdvar("ui_inprematch",1);
	prematchperiod();
	maps\mp\_utility::gameflagset("prematch_done");
	level notify("prematch_over");
	setdvar("ui_inprematch",0);
	level.prematch_done_time = gettime();
	updatetimerpausedness();
	thread timelimitclock();
	thread graceperiod();
	thread maps\mp\gametypes\_missions::roundbegin();
	thread maps\mp\_matchdata::matchstarted();
	var_00 = isdefined(level.ishorde) && level.ishorde;
	var_01 = isdefined(level.iszombiegame) && level.iszombiegame;
	if(var_00 || var_01)
	{
		thread updategameduration();
	}

	lootserviceonstartgame();
}

//Function Number: 62
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

//Function Number: 63
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

//Function Number: 64
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

//Function Number: 65
displayroundend(param_00,param_01)
{
	if(!maps\mp\_utility::practiceroundgame())
	{
		foreach(var_03 in level.players)
		{
			if(isdefined(var_03.connectedpostgame) || var_03.pers["team"] == "spectator" && !var_03 ismlgspectator())
			{
				continue;
			}

			if(level.teambased)
			{
				var_03 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(param_00,1,param_01);
				continue;
			}

			var_03 thread maps\mp\gametypes\_hud_message::outcomenotify(param_00,param_01);
		}
	}

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

//Function Number: 66
displaygameend(param_00,param_01)
{
	if(!maps\mp\_utility::practiceroundgame())
	{
		foreach(var_03 in level.players)
		{
			if(isdefined(var_03.connectedpostgame) || var_03.pers["team"] == "spectator" && !var_03 ismlgspectator())
			{
				continue;
			}

			if(level.teambased)
			{
				var_03 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(param_00,0,param_01,1);
				continue;
			}

			var_03 thread maps\mp\gametypes\_hud_message::outcomenotify(param_00,param_01);
		}
	}

	level notify("game_win",param_00);
	roundendwait(level.postroundtime,1);
}

//Function Number: 67
displayroundswitch()
{
	var_00 = level.halftimetype;
	if(var_00 == "halftime")
	{
		if(maps\mp\_utility::getwatcheddvar("roundlimit"))
		{
			if(game["roundsPlayed"] * 2 == maps\mp\_utility::getwatcheddvar("roundlimit"))
			{
				var_00 = "halftime";
			}
			else
			{
				var_00 = "intermission";
			}
		}
		else if(maps\mp\_utility::getwatcheddvar("winlimit"))
		{
			if(game["roundsPlayed"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1)
			{
				var_00 = "halftime";
			}
			else
			{
				var_00 = "intermission";
			}
		}
		else
		{
			var_00 = "intermission";
		}
	}

	level notify("round_switch",var_00);
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.connectedpostgame) || var_02.pers["team"] == "spectator" && !var_02 ismlgspectator())
		{
			continue;
		}

		var_02 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(var_00,1,game["end_reason"]["switching_sides"]);
	}

	roundendwait(level.halftimeroundenddelay,0);
}

//Function Number: 68
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
			var_03 setclientdvars("cg_everyoneHearsEveryone",1,"cg_fovScale",1);
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

//Function Number: 69
endgameovertime(param_00,param_01)
{
	setdvar("bg_compassShowEnemies",0);
	freezeallplayers(1,1);
	foreach(var_03 in level.players)
	{
		var_03.pers["stats"] = var_03.stats;
		var_03.pers["segments"] = var_03.segments;
	}

	level notify("round_switch","overtime");
	var_05 = 0;
	var_06 = param_00 == "overtime";
	if(level.gametype == "ctf")
	{
		param_00 = "tie";
		var_05 = 1;
		if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			param_00 = "axis";
		}

		if(game["teamScores"]["allies"] > game["teamScores"]["axis"])
		{
			param_00 = "allies";
		}
	}

	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.connectedpostgame) || var_03.pers["team"] == "spectator" && !var_03 ismlgspectator())
		{
			continue;
		}

		if(level.teambased)
		{
			var_03 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(param_00,var_05,param_01);
			continue;
		}

		var_03 thread maps\mp\gametypes\_hud_message::outcomenotify(param_00,param_01);
	}

	roundendwait(level.roundenddelay,0);
	if(level.gametype == "ctf")
	{
		param_00 = "overtime_halftime";
	}

	if(isdefined(level.finalkillcam_winner) && var_06)
	{
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
		foreach(var_03 in level.players)
		{
			var_03 notify("reset_outcome");
		}

		level notify("game_cleanup");
		waittillfinalkillcamdone();
		if(level.gametype == "ctf")
		{
			param_00 = "overtime";
			param_01 = game["end_reason"]["tie"];
		}

		foreach(var_03 in level.players)
		{
			if(isdefined(var_03.connectedpostgame) || var_03.pers["team"] == "spectator" && !var_03 ismlgspectator())
			{
				continue;
			}

			if(level.teambased)
			{
				var_03 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(param_00,0,param_01);
				continue;
			}

			var_03 thread maps\mp\gametypes\_hud_message::outcomenotify(param_00,param_01);
		}

		roundendwait(level.halftimeroundenddelay,0);
	}

	game["status"] = param_00;
	level notify("restarting");
	game["state"] = "playing";
	setdvar("ui_game_state",game["state"]);
	map_restart(1);
}

//Function Number: 70
endgamehalftime(param_00)
{
	setdvar("bg_compassShowEnemies",0);
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
	foreach(var_05 in level.players)
	{
		if(isdefined(var_05.connectedpostgame) || var_05.pers["team"] == "spectator" && !var_05 ismlgspectator())
		{
			continue;
		}

		var_05 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(var_01,1,var_03);
	}

	roundendwait(level.roundenddelay,0);
	if(isdefined(level.finalkillcam_winner))
	{
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
		foreach(var_05 in level.players)
		{
			var_05 notify("reset_outcome");
		}

		level notify("game_cleanup");
		waittillfinalkillcamdone();
		var_0B = game["end_reason"]["switching_sides"];
		if(!var_02)
		{
			var_0B = var_03;
		}

		foreach(var_05 in level.players)
		{
			if(isdefined(var_05.connectedpostgame) || var_05.pers["team"] == "spectator" && !var_05 ismlgspectator())
			{
				continue;
			}

			var_05 thread maps\mp\gametypes\_hud_message::teamoutcomenotify("halftime",1,var_0B);
		}

		roundendwait(level.halftimeroundenddelay,0);
	}

	game["status"] = "halftime";
	level notify("restarting");
	game["state"] = "playing";
	setdvar("ui_game_state",game["state"]);
	map_restart(1);
}

//Function Number: 71
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

//Function Number: 72
getgameduration()
{
	var_00 = maps\mp\_utility::getgametimepassedseconds();
	if(isdefined(level.ishorde) && level.ishorde)
	{
		var_00 = gamedurationclamp(var_00);
	}

	return var_00;
}

//Function Number: 73
gamedurationclamp(param_00)
{
	if(param_00 > 86399)
	{
		return 86399;
	}

	return param_00;
}

//Function Number: 74
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
	wait 0.05;
	setgameendtime(0);
	setmatchdata("gameLengthSeconds",var_03);
	setmatchdata("endTimeUTC",getsystemtime());
	checkgameendchallenges();
	if(isdefined(param_00) && isstring(param_00) && maps\mp\_utility::isovertimetext(param_00))
	{
		level.finalkillcam_winner = "none";
		endgameovertime(param_00,param_01);
		return;
	}

	if(isdefined(param_00) && isstring(param_00) && param_00 == "halftime")
	{
		level.finalkillcam_winner = "none";
		endgamehalftime(param_01);
		return;
	}

	if(isdefined(level.finalkillcam_winner))
	{
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
	}

	game["roundsPlayed"]++;
	setomnvar("ui_current_round",game["roundsPlayed"]);
	if(level.teambased)
	{
		if((param_00 == "axis" || param_00 == "allies") && level.gametype != "ctf")
		{
			game["roundsWon"][param_00]++;
		}

		maps\mp\gametypes\_gamescore::updateteamscore("axis");
		maps\mp\gametypes\_gamescore::updateteamscore("allies");
	}
	else if(isdefined(param_00) && isplayer(param_00))
	{
		game["roundsWon"][param_00.guid]++;
	}

	maps\mp\gametypes\_gamescore::updateplacement();
	rankedmatchupdates(param_00);
	foreach(var_05 in level.players)
	{
		var_05 setclientdvar("ui_opensummary",1);
		if(maps\mp\_utility::wasonlyround() || maps\mp\_utility::waslastround())
		{
			var_05 maps\mp\killstreaks\_killstreaks::clearkillstreaks(1);
		}
	}

	setdvar("g_deadChat",1);
	setdvar("ui_allow_teamchange",0);
	setdvar("bg_compassShowEnemies",0);
	freezeallplayers(1,1);
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
				displayroundswitch();
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
		game["clientMatchDataDef"] = "mp/clientmatchdata.def";
		setclientmatchdatadef(game["clientMatchDataDef"]);
	}

	maps\mp\gametypes\_missions::roundend(param_02);
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
	var_0B = gettime();
	if(isdefined(level.finalkillcam_winner) && maps\mp\_utility::wasonlyround())
	{
		foreach(var_09 in level.players)
		{
			var_09 notify("reset_outcome");
		}

		level notify("game_cleanup");
		waittillfinalkillcamdone();
	}

	maps\mp\_utility::levelflagclear("block_notifies");
	level.intermission = 1;
	level notify("spawning_intermission");
	foreach(var_09 in level.players)
	{
		var_09 closepopupmenu();
		var_09 closeingamemenu();
		var_09 notify("reset_outcome");
		var_09 thread maps\mp\gametypes\_playerlogic::spawnintermission();
	}

	processlobbydata();
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
	foreach(var_09 in level.players)
	{
		if(var_09 maps\mp\_utility::rankingenabled())
		{
			var_09 maps\mp\_matchdata::logfinalstats();
		}

		var_09 maps\mp\gametypes\_playerlogic::logplayerstats();
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
	foreach(var_09 in level.players)
	{
		var_09.pers["stats"] = var_09.stats;
		var_09.pers["segments"] = var_09.segments;
	}

	tournamentreportendofgame();
	var_14 = 0;
	if(maps\mp\_utility::practiceroundgame())
	{
		var_14 = 5;
	}

	if(isdefined(level.endgamewaitfunc))
	{
		[[ level.endgamewaitfunc ]](var_04,level.postgamenotifies,var_14,param_02);
	}
	else if(!var_04 && !level.postgamenotifies)
	{
		if(!maps\mp\_utility::wasonlyround())
		{
			wait(6 + var_14);
		}
		else
		{
			wait(min(10,4 + var_14 + level.postgamenotifies));
		}
	}
	else
	{
		wait(min(10,4 + var_14 + level.postgamenotifies));
	}

	var_15 = "_gamelogic.gsc";
	var_16 = "all";
	if(level.teambased && isdefined(param_02))
	{
		var_16 = param_02;
	}

	var_17 = "undefined";
	if(isdefined(var_03))
	{
		switch(var_03)
		{
			case 1:
				var_17 = "MP_SCORE_LIMIT_REACHED";
				break;

			case 2:
				var_17 = "MP_TIME_LIMIT_REACHED";
				break;

			case 3:
				var_17 = "MP_PLAYERS_FORFEITED";
				break;

			case 4:
				var_17 = "MP_TARGET_DESTROYED";
				break;

			case 5:
				var_17 = "MP_BOMB_DEFUSED";
				break;

			case 6:
				var_17 = "MP_GHOSTS_ELIMINATED";
				break;

			case 7:
				var_17 = "MP_FEDERATION_ELIMINATED";
				break;

			case 8:
				var_17 = "MP_GHOSTS_FORFEITED";
				break;

			case 9:
				var_17 = "MP_FEDERATION_FORFEITED";
				break;

			case 10:
				var_17 = "MP_ENEMIES_ELIMINATED";
				break;

			case 11:
				var_17 = "MP_MATCH_TIE";
				break;

			case 12:
				var_17 = "GAME_OBJECTIVECOMPLETED";
				break;

			case 13:
				var_17 = "GAME_OBJECTIVEFAILED";
				break;

			case 14:
				var_17 = "MP_SWITCHING_SIDES";
				break;

			case 15:
				var_17 = "MP_ROUND_LIMIT_REACHED";
				break;

			case 16:
				var_17 = "MP_ENDED_GAME";
				break;

			case 17:
				var_17 = "MP_HOST_ENDED_GAME";
				break;

			default:
				break;
		}
	}

	if(!isdefined(var_0B))
	{
		var_0B = -1;
	}

	var_18 = 15;
	var_19 = var_18;
	var_1A = getmatchdata("playerCount");
	var_1B = getmatchdata("lifeCount");
	if(!isdefined(level.matchdata))
	{
		var_1C = 0;
		var_1D = 0;
		var_1E = 0;
		var_1F = 0;
		var_20 = 0;
		var_21 = 0;
		var_22 = 0;
	}
	else
	{
		if(isdefined(level.matchdata["botJoinCount"]))
		{
			var_1C = level.matchdata["botJoinCount"];
		}
		else
		{
			var_1C = 0;
		}

		if(isdefined(level.matchdata["deathCount"]))
		{
			var_1D = level.matchdata["deathCount"];
		}
		else
		{
			var_1D = 0;
		}

		if(isdefined(level.matchdata["badSpawnDiedTooFastCount"]))
		{
			var_1E = level.matchdata["badSpawnDiedTooFastCount"];
		}
		else
		{
			var_1E = 0;
		}

		if(isdefined(level.matchdata["badSpawnKilledTooFastCount"]))
		{
			var_1F = level.matchdata["badSpawnKilledTooFastCount"];
		}
		else
		{
			var_1F = 0;
		}

		if(isdefined(level.matchdata["badSpawnDmgDealtCount"]))
		{
			var_20 = level.matchdata["badSpawnDmgDealtCount"];
		}
		else
		{
			var_20 = 0;
		}

		if(isdefined(level.matchdata["badSpawnDmgReceivedCount"]))
		{
			var_21 = level.matchdata["badSpawnDmgReceivedCount"];
		}
		else
		{
			var_21 = 0;
		}

		if(isdefined(level.matchdata["badSpawnByAnyMeansCount"]))
		{
			var_22 = level.matchdata["badSpawnByAnyMeansCount"];
		}
		else
		{
			var_22 = 0;
		}
	}

	var_23 = 0;
	if(isdefined(level.spawnsighttracesused_pres1tu))
	{
		var_23 = var_23 + 1;
	}

	if(isdefined(level.spawnsighttracesused_posts1tu))
	{
		var_23 = var_23 + 2;
	}

	reconevent("@"script_mp_match_end: script_file %s, gameTime %d, match_winner %s, win_reason %s, version %d, joinCount %d, botJoinCount %d, spawnCount %d, deathCount %d, badSpawnDiedTooFastCount %d, badSpawnKilledTooFastCount %d, badSpawnDmgDealtCount %d, badSpawnDmgReceivedCount %d, badSpawnByAnyMeansCount %d, sightTraceMethodsUsed %d",var_15,var_0B,var_16,var_17,var_19,var_1A,var_1C,var_1B,var_1D,var_1E,var_1F,var_20,var_21,var_22,var_23);
	if(isdefined(level.ishorde) && level.ishorde)
	{
		if(isdefined(level.zombiescompleted) && level.zombiescompleted)
		{
			setdvar("cg_drawCrosshair",1);
		}
	}

	level notify("exitLevel_called");
	exitlevel(0);
}

//Function Number: 75
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

//Function Number: 76
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

//Function Number: 77
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

//Function Number: 78
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

//Function Number: 79
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

//Function Number: 80
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

//Function Number: 81
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

		setclientmatchdata("players",var_02.clientmatchdataid,"name",maps\mp\gametypes\_playerlogic::truncateplayername(var_02.name));
		setclientmatchdata("players",var_02.clientmatchdataid,"xuid",var_02.xuid);
	}

	maps\mp\_awards::assignawards();
	maps\mp\_scoreboard::processlobbyscoreboards();
	sendclientmatchdata();
	lootserviceonendgame();
}

//Function Number: 82
trackleaderboarddeathstats(param_00,param_01)
{
	thread threadedsetweaponstatbyname(param_00,1,"deaths");
}

//Function Number: 83
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

			if(maps\mp\_utility::ismeleemod(param_01) && !issubstr(param_00,"riotshield") && !issubstr(param_00,"combatknife"))
			{
				return;
			}

			thread threadedsetweaponstatbyname(param_00,1,"kills");
			var_03 = 0;
			if(isdefined(param_02) && isdefined(param_02.firedads))
			{
				var_03 = param_02.firedads;
			}
			else
			{
				var_03 = self playerads();
			}

			if(var_03 < 0.2)
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

//Function Number: 84
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

	if(param_00 == maps\mp\_grappling_hook::get_grappling_hook_weapon())
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
	if(var_03 != "timeInUse" && var_03 != "deaths" && !var_05)
	{
		var_06 = param_01;
		param_01 = self getcurrentweapon();
		if(param_01 != var_06 && maps\mp\_utility::iskillstreakweapon(param_01))
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
			self.trackingweaponshots++;
			self.currentfirefightshots++;
			break;

		case "hits":
			self.trackingweaponhits++;
			break;

		case "headShots":
			self.trackingweaponheadshots++;
			self.trackingweaponhits++;
			break;

		case "kills":
			self.trackingweaponkills++;
			break;

		case "hipfirekills":
			self.trackingweaponhipfirekills++;
			break;

		case "timeInUse":
			self.trackingweaponusetime = self.trackingweaponusetime + param_02;
			break;
	}

	if(var_03 == "deaths")
	{
		var_07 = maps\mp\_utility::getbaseweaponname(param_01);
		if(!maps\mp\_utility::iscacprimaryweapon(var_07) && !maps\mp\_utility::iscacsecondaryweapon(var_07))
		{
			return;
		}

		var_08 = maps\mp\_utility::getweaponattachmentsbasenames(param_01);
		maps\mp\gametypes\_persistence::incrementweaponstat(var_07,var_03,param_02);
		maps\mp\_matchdata::logweaponstat(var_07,"deaths",param_02);
		foreach(var_0A in var_08)
		{
			maps\mp\gametypes\_persistence::incrementattachmentstat(var_0A,var_03,param_02);
		}
	}
}

//Function Number: 85
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

//Function Number: 86
threadedsetweaponstatbyname(param_00,param_01,param_02)
{
	self endon("disconnect");
	waittillframeend;
	setweaponstat(param_00,param_01,param_02);
}

//Function Number: 87
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
			var_02 = var_01 getcommonplayerdata("round","kills");
			var_03 = var_01 getcommonplayerdata("round","deaths");
			var_04 = var_01.pers["summary"]["xp"];
			var_05 = var_01.score;
			var_06 = getroundaccuracy(var_01);
			var_07 = var_01 getrankedplayerdata("bestKills");
			var_08 = var_01 getrankedplayerdata("mostDeaths");
			var_09 = var_01 getrankedplayerdata("mostXp");
			var_0A = var_01 getrankedplayerdata("bestScore");
			var_0B = var_01 getrankedplayerdata("bestAccuracy");
			if(var_02 > var_07)
			{
				var_01 setrankedplayerdata("bestKills",var_02);
			}

			if(var_04 > var_09)
			{
				var_01 setrankedplayerdata("mostXp",var_04);
			}

			if(var_03 > var_08)
			{
				var_01 setrankedplayerdata("mostDeaths",var_03);
			}

			if(var_05 > var_0A)
			{
				var_01 setrankedplayerdata("bestScore",var_05);
			}

			if(var_06 > var_0B)
			{
				var_01 setrankedplayerdata("bestAccuracy",var_06);
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

//Function Number: 88
getroundaccuracy(param_00)
{
	var_01 = float(param_00 getrankedplayerdata("totalShots") - param_00.pers["previous_shots"]);
	if(var_01 == 0)
	{
		return 0;
	}

	var_02 = float(param_00 getrankedplayerdata("hits") - param_00.pers["previous_hits"]);
	var_03 = clamp(var_02 / var_01,0,1) * 10000;
	return int(var_03);
}

//Function Number: 89
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
			var_04 = self getrankedplayerdata("bestWeapon","kills");
			var_05 = 0;
			if(isdefined(self.pers["mpWeaponStats"][var_02]) && isdefined(self.pers["mpWeaponStats"][var_02]["kills"]))
			{
				var_05 = self.pers["mpWeaponStats"][var_02]["kills"];
				if(var_05 > var_04)
				{
					self setrankedplayerdata("bestWeapon","kills",var_05);
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

					self setrankedplayerdata("bestWeapon","shots",var_06);
					self setrankedplayerdata("bestWeapon","headShots",var_07);
					self setrankedplayerdata("bestWeapon","hits",var_08);
					self setrankedplayerdata("bestWeapon","deaths",var_09);
					var_0A = int(tablelookup("mp/statstable.csv",4,var_02,0));
					self setrankedplayerdata("bestWeaponIndex",var_0A);
				}
			}
		}
	}
}

//Function Number: 90
updatecombatrecordforplayertrends()
{
	var_00 = 5;
	var_01 = self getrankedplayerdata("combatRecord","numTrends");
	var_01++;
	if(var_01 > var_00)
	{
		var_01 = var_00;
		if(var_00 > 1)
		{
			for(var_02 = 0;var_02 < var_00 - 1;var_02++)
			{
				var_03 = self getrankedplayerdata("combatRecord","trend",var_02 + 1,"timestamp");
				var_04 = self getrankedplayerdata("combatRecord","trend",var_02 + 1,"kills");
				var_05 = self getrankedplayerdata("combatRecord","trend",var_02 + 1,"deaths");
				self setrankedplayerdata("combatRecord","trend",var_02,"timestamp",var_03);
				self setrankedplayerdata("combatRecord","trend",var_02,"kills",var_04);
				self setrankedplayerdata("combatRecord","trend",var_02,"deaths",var_05);
			}
		}
	}

	var_03 = maps\mp\_utility::gettimeutc_for_stat_recording();
	var_04 = self.kills;
	var_05 = self.deaths;
	self setrankedplayerdata("combatRecord","trend",var_01 - 1,"timestamp",var_03);
	self setrankedplayerdata("combatRecord","trend",var_01 - 1,"kills",var_04);
	self setrankedplayerdata("combatRecord","trend",var_01 - 1,"deaths",var_05);
	self setrankedplayerdata("combatRecord","numTrends",var_01);
}

//Function Number: 91
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

	var_01 = self getrankedplayerdata("combatRecord",level.gametype,"timeStampFirstGame");
	if(var_01 == 0)
	{
		setcombatrecordstat("timeStampFirstGame",var_00);
	}
}

//Function Number: 92
incrementcombatrecordstat(param_00,param_01)
{
	var_02 = self getrankedplayerdata("combatRecord",level.gametype,param_00);
	var_02 = var_02 + param_01;
	self setrankedplayerdata("combatRecord",level.gametype,param_00,var_02);
}

//Function Number: 93
setcombatrecordstat(param_00,param_01)
{
	self setrankedplayerdata("combatRecord",level.gametype,param_00,param_01);
}

//Function Number: 94
setcombatrecordstatifgreater(param_00,param_01)
{
	var_02 = self getrankedplayerdata("combatRecord",level.gametype,param_00);
	if(param_01 > var_02)
	{
		setcombatrecordstat(param_00,param_01);
	}
}

//Function Number: 95
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
		incrementcombatrecordstat("captures",var_02);
		incrementcombatrecordstat("defends",var_04);
		setcombatrecordstatifgreater("mostcaptures",var_02);
		setcombatrecordstatifgreater("mostdefends",var_04);
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
		var_0A = maps\mp\_utility::getplayerstat("contagious");
		var_0B = self.kills - var_0A;
		incrementcombatrecordstat("infectedKills",var_0B);
		incrementcombatrecordstat("survivorKills",var_0A);
		setcombatrecordstatifgreater("mostInfectedKills",var_0B);
		setcombatrecordstatifgreater("mostSurvivorKills",var_0A);
		return;
	}

	if(level.gametype == "gun")
	{
		updatecombatrecordcommondata();
		var_0C = maps\mp\_utility::getplayerstat("levelup");
		var_0D = maps\mp\_utility::getplayerstat("humiliation");
		incrementcombatrecordstat("gunPromotions",var_0C);
		incrementcombatrecordstat("stabs",var_0D);
		setcombatrecordstatifgreater("mostGunPromotions",var_0C);
		setcombatrecordstatifgreater("mostStabs",var_0D);
		return;
	}

	if(level.gametype == "ball")
	{
		updatecombatrecordcommondata();
		var_0E = maps\mp\_utility::getplayerstat("fieldgoal") + maps\mp\_utility::getplayerstat("touchdown") * 2;
		var_0F = maps\mp\_utility::getplayerstat("killedBallCarrier");
		incrementcombatrecordstat("pointsScored",var_0E);
		incrementcombatrecordstat("killedBallCarrier",var_0F);
		setcombatrecordstatifgreater("mostPointsScored",var_0E);
		setcombatrecordstatifgreater("mostKilledBallCarrier",var_0F);
		return;
	}

	if(level.gametype == "twar")
	{
		updatecombatrecordcommondata();
		var_02 = maps\mp\_utility::getpersstat("captures");
		var_10 = maps\mp\_utility::getplayerstat("kill_while_capture");
		incrementcombatrecordstat("captures",var_02);
		incrementcombatrecordstat("killWhileCaptures",var_10);
		setcombatrecordstatifgreater("mostCaptures",var_02);
		setcombatrecordstatifgreater("mostKillWhileCaptures",var_10);
		return;
	}
}

//Function Number: 96
updatecombatrecordforplayer()
{
	updatecombatrecordforplayertrends();
	updatecombatrecordforplayergamemodes();
}

//Function Number: 97
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
		if(maps\mp\_utility::practiceroundgame())
		{
			level maps\mp\gametypes\_playerlogic::checkpracticeroundlockout(var_01);
		}
	}
}