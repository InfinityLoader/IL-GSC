/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gamelogic.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 86
 * Decompile Time: 1758 ms
 * Timestamp: 10/27/2023 1:18:13 AM
*******************************************************************/

//Function Number: 1
func_593D(param_00)
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
	func_50BF(var_01);
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
		var_03 = "axis";
	}
	else if(var_01 == "allies")
	{
		level.finalkillcam_winner = "allies";
		var_03 = game["end_reason"]["axis_forfeited"];
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
	setomnvar("ui_match_start_countdown",0);
}

//Function Number: 3
func_50C0(param_00)
{
	waittillframeend;
	level endon("match_forfeit_timer_beginning");
	while(param_00 > 0 && !level.gameended && !level.forfeit_aborted && !level.ingraceperiod)
	{
		setomnvar("ui_match_start_countdown",param_00);
		param_00--;
		maps\mp\gametypes\_hostmigration::func_8B0D(1);
	}

	setomnvar("ui_match_start_countdown",0);
}

//Function Number: 4
func_50BF(param_00)
{
	level notify("match_forfeit_timer_beginning");
	var_01 = int(param_00);
	setomnvar("ui_match_start_text","opponent_forfeiting_in");
	func_50C0(var_01);
}

//Function Number: 5
default_ondeadevent(param_00)
{
	level.finalkillcam_winner = "none";
	if(param_00 == "allies")
	{
		iprintln(&"MP_GHOSTS_ELIMINATED");
		logstring("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
		level.finalkillcam_winner = "axis";
		thread endgame("axis",game["end_reason"]["allies_eliminated"]);
	}

	if(param_00 == "axis")
	{
		iprintln(&"MP_FEDERATION_ELIMINATED");
		logstring("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
		level.finalkillcam_winner = "allies";
		thread endgame("allies",game["end_reason"]["axis_eliminated"]);
	}

	logstring("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	level.finalkillcam_winner = "none";
	if(level.teambased)
	{
		thread endgame("tie",game["end_reason"]["tie"]);
	}

	thread endgame(undefined,game["end_reason"]["tie"]);
}

//Function Number: 6
default_ononeleftevent(param_00)
{
	if(level.teambased)
	{
		var_01 = maps\mp\_utility::func_3B09(param_00);
		if(isdefined(var_01))
		{
			var_01 thread func_3CF4();
		}
	}
	else
	{
		var_01 = maps\mp\_utility::func_3B09();
		logstring("last one alive, win: " + var_01.name);
		level.finalkillcam_winner = "none";
		thread endgame(var_01,game["end_reason"]["enemies_eliminated"]);
	}

	return 1;
}

//Function Number: 7
func_24A3()
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
func_24A1()
{
	var_00 = undefined;
	level.finalkillcam_winner = "none";
	thread endgame("halftime",game["end_reason"]["time_limit_reached"]);
}

//Function Number: 9
func_34D1(param_00)
{
	if(level.hostforcedend || level.forcedend)
	{
	}

	var_01 = undefined;
	level.finalkillcam_winner = "none";
	if(level.teambased)
	{
		if(getdvarint("squad_match") == 1 && isdefined(param_00) && param_00 == 2)
		{
			var_01 = "axis";
		}
		else if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
		{
			var_01 = "tie";
		}
		else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
		{
			level.finalkillcam_winner = "axis";
			var_01 = "axis";
		}
		else
		{
			level.finalkillcam_winner = "allies";
			var_01 = "allies";
		}

		logstring("host ended game, win: " + var_01 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		var_01 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
		if(isdefined(var_01))
		{
			logstring("host ended game, win: " + var_01.name);
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
		var_02 = game["end_reason"]["ended_game"];
	}
	else
	{
		var_02 = game["end_reason"]["host_ended_game"];
	}

	if(isdefined(param_00) && param_00 == 2)
	{
		var_02 = game["end_reason"]["allies_forfeited"];
	}

	level notify("force_end");
	thread endgame(var_01,var_02);
}

//Function Number: 10
onscorelimit()
{
	var_00 = game["end_reason"]["score_limit_reached"];
	var_01 = undefined;
	level.finalkillcam_winner = "none";
	if(level.multiteambased)
	{
		var_01 = maps\mp\gametypes\_gamescore::func_3C86();
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
func_86EE()
{
	if(maps\mp\_utility::func_50C1() && !level.ingraceperiod && !isdefined(level.disableforfeit) || !level.disableforfeit)
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
					thread func_593D(level.teamnamelist[var_02]);
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
				thread func_593D("axis");
			}

			if(level.teamcount["axis"] < 1 && level.teamcount["allies"] > 0 && game["state"] == "playing")
			{
				thread func_593D("allies");
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
				thread func_593D();
			}

			if(level.teamcount["axis"] + level.teamcount["allies"] > 1)
			{
				level.forfeitinprogress = undefined;
				level notify("abort_forfeit");
			}
		}
	}

	if(!maps\mp\_utility::func_3ABB() && !isdefined(level.disablespawning) || !level.disablespawning)
	{
	}

	if(!maps\mp\_utility::gamehasstarted())
	{
	}

	if(level.ingraceperiod)
	{
	}

	if(level.multiteambased)
	{
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
		if(var_04 || var_05)
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
	}

	if(!level.alivecount["allies"] && !level.alivecount["axis"] && !level.livescount["allies"] && !level.livescount["axis"])
	{
		return [[ level.ondeadevent ]]("all");
	}

	var_09 = maps\mp\_utility::func_3BA0();
	if(var_09.size == 1)
	{
		return [[ level.ononeleftevent ]]("all");
	}
}

//Function Number: 12
func_8BB7()
{
	if(!isdefined(level.finalkillcam_winner))
	{
		return 0;
	}

	level waittill("final_killcam_done");
	return 1;
}

//Function Number: 13
func_811F(param_00)
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
func_8AEE(param_00)
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

	var_04 = level.connectingplayers / 3;
	for(;;)
	{
		if(isdefined(game["roundsPlayed"]) && game["roundsPlayed"])
		{
			break;
		}

		var_05 = level.maxplayercount;
		var_06 = gettime();
		if((var_05 >= var_04 && var_06 > var_03) || var_06 > var_02)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 15
func_6130()
{
	level endon("game_ended");
	level.connectingplayers = getdvarint("party_partyPlayerCountNum");
	if(level.var_6130 > 0)
	{
		matchstarttimerwaitforplayers();
	}
	else
	{
		func_50CC();
	}

	foreach(var_01 in level.players)
	{
		var_01 maps\mp\_utility::func_350E(0);
		var_01 enableweapons();
		if(!isdefined(var_01.pers["team"]))
		{
			continue;
		}

		var_02 = var_01.pers["team"];
		var_03 = maps\mp\_utility::func_3B5E(var_02);
		if(!isdefined(var_03) || !var_01.hasspawned)
		{
			continue;
		}

		var_04 = 0;
		if(game["defenders"] == var_02)
		{
			var_04 = 1;
		}

		var_01 setclientomnvar("ui_objective_text",var_04);
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
	maps\mp\_utility::func_36F4("graceperiod_done");
	level.ingraceperiod = 0;
	if(game["state"] != "playing")
	{
	}

	if(maps\mp\_utility::func_3ABB())
	{
		var_00 = level.players;
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			var_02 = var_00[var_01];
			if(!var_02.hasspawned && var_02.sessionteam != "spectator" && !isalive(var_02))
			{
				var_02.statusicon = "hud_status_dead";
			}
		}
	}

	level thread func_86EE();
}

//Function Number: 17
func_7049(param_00,param_01)
{
	param_00.hasdonecombat = param_01;
	var_02 = !isdefined(param_00.hasdoneanycombat) || !param_00.hasdoneanycombat;
	if(var_02 && param_01)
	{
		param_00.hasdoneanycombat = 1;
		if(isdefined(param_00.pers["hasMatchLoss"]) && param_00.pers["hasMatchLoss"])
		{
		}

		if(!maps\mp\_utility::func_47BB())
		{
			func_86FB(param_00);
		}
	}
}

//Function Number: 18
func_8758(param_00)
{
	if(!param_00 maps\mp\_utility::func_634C())
	{
	}

	if(!isdefined(param_00.hasdoneanycombat) || !param_00.hasdoneanycombat)
	{
	}

	if(!issquadsmode())
	{
		param_00 maps\mp\gametypes\_persistence::func_7B07("losses",-1);
		param_00 maps\mp\gametypes\_persistence::func_7B07("wins",1);
		param_00 maps\mp\_utility::func_870C("winLossRatio","wins","losses");
		param_00 maps\mp\gametypes\_persistence::func_7B07("currentWinStreak",1);
		var_01 = param_00 maps\mp\gametypes\_persistence::func_7B16("currentWinStreak");
		if(var_01 > param_00 maps\mp\gametypes\_persistence::func_7B16("winStreak"))
		{
			param_00 maps\mp\gametypes\_persistence::func_7B26("winStreak",var_01);
		}
	}

	param_00 maps\mp\gametypes\_persistence::func_7B28("round","win",1);
	param_00 maps\mp\gametypes\_persistence::func_7B28("round","loss",0);
}

//Function Number: 19
func_86FB(param_00)
{
	if(!param_00 maps\mp\_utility::func_634C())
	{
	}

	if(!isdefined(param_00.hasdoneanycombat) || !param_00.hasdoneanycombat)
	{
	}

	param_00.pers["hasMatchLoss"] = 1;
	if(!issquadsmode())
	{
		param_00 maps\mp\gametypes\_persistence::func_7B07("losses",1);
		param_00 maps\mp\_utility::func_870C("winLossRatio","wins","losses");
		maps\mp\gametypes\_persistence::func_7B07("gamesPlayed",1);
	}

	param_00 maps\mp\gametypes\_persistence::func_7B28("round","loss",1);
}

//Function Number: 20
func_8746(param_00)
{
	if(!param_00 maps\mp\_utility::func_634C())
	{
	}

	if(!isdefined(param_00.hasdoneanycombat) || !param_00.hasdoneanycombat)
	{
	}

	if(!issquadsmode())
	{
		param_00 maps\mp\gametypes\_persistence::func_7B07("losses",-1);
		param_00 maps\mp\gametypes\_persistence::func_7B07("ties",1);
		param_00 maps\mp\_utility::func_870C("winLossRatio","wins","losses");
		param_00 maps\mp\gametypes\_persistence::func_7B26("currentWinStreak",0);
	}

	param_00 maps\mp\gametypes\_persistence::func_7B28("round","loss",0);
}

//Function Number: 21
updatewinlossstats(param_00)
{
	if(maps\mp\_utility::func_61B9())
	{
	}

	if(!maps\mp\_utility::func_8C49())
	{
	}

	var_01 = level.players;
	func_9559();
	if(!isdefined(param_00) || isdefined(param_00) && isstring(param_00) && param_00 == "tie")
	{
		foreach(var_03 in level.players)
		{
			if(isdefined(var_03.connectedpostgame))
			{
				continue;
			}

			if(level.hostforcedend && var_03 ishost())
			{
				if(!issquadsmode())
				{
					var_03 maps\mp\gametypes\_persistence::func_7B26("currentWinStreak",0);
				}

				continue;
			}

			func_8746(var_03);
		}
	}

	if(isplayer(param_00))
	{
		if(level.hostforcedend && param_00 ishost())
		{
			if(!issquadsmode())
			{
				param_00 maps\mp\gametypes\_persistence::func_7B26("currentWinStreak",0);
			}
		}

		func_8758(param_00);
	}

	if(isstring(param_00))
	{
		foreach(var_03 in level.players)
		{
			if(isdefined(var_03.connectedpostgame))
			{
				continue;
			}

			if(level.hostforcedend && var_03 ishost())
			{
				if(!issquadsmode())
				{
					var_03 maps\mp\gametypes\_persistence::func_7B26("currentWinStreak",0);
				}

				continue;
			}

			if(param_00 == "tie")
			{
				func_8746(var_03);
				continue;
			}

			if(var_03.pers["team"] == param_00)
			{
				func_8758(var_03);
				continue;
			}

			if(!issquadsmode())
			{
				var_03 maps\mp\gametypes\_persistence::func_7B26("currentWinStreak",0);
			}
		}
	}
}

//Function Number: 22
func_9559()
{
	if(level.gametype != "infect")
	{
	}

	foreach(var_01 in level.players)
	{
		if(var_01.sessionstate == "spectator" && !var_01.spectatekillcam)
		{
			continue;
		}
		else if(isdefined(var_01.hasdoneanycombat) && var_01.hasdoneanycombat)
		{
			continue;
		}
		else if(var_01.team == "axis")
		{
			continue;
		}
		else
		{
			var_01 func_7049(var_01,1);
		}
	}
}

//Function Number: 23
func_350F(param_00)
{
	self endon("disconnect");
	maps\mp\_utility::func_1D48();
	if(!isdefined(param_00))
	{
		param_00 = 0.05;
	}

	wait(param_00);
	maps\mp\_utility::func_350E(1);
}

//Function Number: 24
func_8700(param_00)
{
	if(!game["timePassed"])
	{
	}

	if(!maps\mp\_utility::func_50C1())
	{
	}

	if(!maps\mp\_utility::func_3C4A() || level.forcedend)
	{
		var_01 = maps\mp\_utility::func_3C4B() / 1000;
		var_01 = min(var_01,1200);
	}
	else
	{
		var_01 = maps\mp\_utility::func_3C4A() * 60;
	}

	if(level.teambased)
	{
		if(param_00 == "allies")
		{
			var_02 = "allies";
			var_03 = "axis";
		}
		else if(var_02 == "axis")
		{
			var_02 = "axis";
			var_03 = "allies";
		}
		else
		{
			var_02 = "tie";
			var_03 = "tie";
		}

		if(var_02 != "tie")
		{
			var_04 = maps\mp\gametypes\_rank::func_3BE0("win");
			var_05 = maps\mp\gametypes\_rank::func_3BE0("loss");
			setwinningteam(var_02);
		}
		else
		{
			var_04 = maps\mp\gametypes\_rank::func_3BE0("tie");
			var_05 = maps\mp\gametypes\_rank::func_3BE0("tie");
		}

		foreach(var_07 in level.players)
		{
			if(isdefined(var_07.connectedpostgame))
			{
				continue;
			}

			if(!var_07 maps\mp\_utility::func_634C())
			{
				continue;
			}

			if(var_07.timeplayed["total"] < 1 || var_07.pers["participation"] < 1)
			{
				var_07 thread maps\mp\gametypes\_rank::endgameupdate();
				continue;
			}

			if(level.hostforcedend && var_07 ishost())
			{
				continue;
			}

			if(!isdefined(var_07.hasdoneanycombat) || !var_07.hasdoneanycombat)
			{
				continue;
			}

			var_08 = var_07 maps\mp\gametypes\_rank::func_3BFD();
			if(var_02 == "tie")
			{
				var_09 = int(var_04 * var_01 / 60 * var_08 * var_07.timeplayed["total"] / var_01);
				var_07 thread givematchbonus("tie",var_09);
				var_07.matchbonus = var_09;
				continue;
			}

			if(isdefined(var_07.pers["team"]) && var_07.pers["team"] == var_02)
			{
				var_09 = int(var_04 * var_01 / 60 * var_08 * var_07.timeplayed["total"] / var_01);
				var_07 thread givematchbonus("win",var_09);
				var_07.matchbonus = var_09;
				continue;
			}

			if(isdefined(var_07.pers["team"]) && var_07.pers["team"] == var_03)
			{
				var_09 = int(var_05 * var_01 / 60 * var_08 * var_07.timeplayed["total"] / var_01);
				var_07 thread givematchbonus("loss",var_09);
				var_07.matchbonus = var_09;
			}
		}
	}

	if(isdefined(var_07))
	{
		var_04 = maps\mp\gametypes\_rank::func_3BE0("win");
		var_05 = maps\mp\gametypes\_rank::func_3BE0("loss");
	}
	else
	{
		var_04 = maps\mp\gametypes\_rank::func_3BE0("tie");
		var_05 = maps\mp\gametypes\_rank::func_3BE0("tie");
	}

	foreach(var_07 in level.players)
	{
		if(isdefined(var_07.connectedpostgame))
		{
			continue;
		}

		if(var_07.timeplayed["total"] < 1 || var_07.pers["participation"] < 1)
		{
			var_07 thread maps\mp\gametypes\_rank::endgameupdate();
			continue;
		}

		if(!isdefined(var_07.hasdoneanycombat) || !var_07.hasdoneanycombat)
		{
			continue;
		}

		var_08 = var_07 maps\mp\gametypes\_rank::func_3BFD();
		var_0C = 0;
		for(var_0D = 0;var_0D < min(level.placement["all"].size,3);var_0D++)
		{
			if(level.placement["all"][var_0D] != var_07)
			{
				continue;
			}

			var_0C = 1;
		}

		if(var_0C)
		{
			var_09 = int(var_04 * var_01 / 60 * var_08 * var_07.timeplayed["total"] / var_01);
			var_07 thread givematchbonus("win",var_09);
			var_07.matchbonus = var_09;
			continue;
		}

		var_09 = int(var_05 * var_01 / 60 * var_08 * var_07.timeplayed["total"] / var_01);
		var_07 thread givematchbonus("loss",var_09);
		var_07.matchbonus = var_09;
	}
}

//Function Number: 25
givematchbonus(param_00,param_01)
{
	self endon("disconnect");
	level waittill("give_match_bonus");
	maps\mp\gametypes\_rank::giverankxp(param_00,param_01);
	maps\mp\gametypes\_rank::endgameupdate();
}

//Function Number: 26
func_721B(param_00)
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
		if(maps\mp\_utility::func_3B2E())
		{
			var_04 = var_03.score / maps\mp\_utility::func_3B2E();
		}

		setplayerteamrank(var_03,var_03.clientid,int(var_04));
	}
}

//Function Number: 27
func_1BDB(param_00)
{
	if(isdefined(level.timelimitoverride) && level.timelimitoverride)
	{
	}

	if(game["state"] != "playing")
	{
		setgameendtime(0);
	}

	if(maps\mp\_utility::func_3C4A() <= 0)
	{
		if(isdefined(level.starttime))
		{
			setgameendtime(level.starttime);
		}
		else
		{
			setgameendtime(0);
		}
	}

	if(!maps\mp\_utility::func_36F1("prematch_done"))
	{
		setgameendtime(0);
	}

	if(!isdefined(level.starttime))
	{
	}

	if(maps\mp\_utility::gettimepassedpercentage() > level.timepercentagecutoff)
	{
		setnojiptime(1);
	}

	var_01 = gettimeremaining();
	setgameendtime(gettime() + int(var_01));
	if(var_01 > 0)
	{
	}

	[[ level.ontimelimit ]]();
}

//Function Number: 28
gettimeremaining()
{
	return maps\mp\_utility::func_3C4A() * 60 * 1000 - maps\mp\_utility::func_3C4B();
}

//Function Number: 29
func_3C4E()
{
	var_00 = maps\mp\_utility::func_3C4A() * 60 * 1000;
	return var_00 - maps\mp\_utility::func_3C4B() / var_00;
}

//Function Number: 30
func_1BDA(param_00)
{
	if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0 || maps\mp\_utility::func_491C())
	{
	}

	if(isdefined(level.scorelimitoverride) && level.scorelimitoverride)
	{
	}

	if(level.gametype == "conf" || level.gametype == "jugg")
	{
	}

	if(!level.teambased)
	{
	}

	if(maps\mp\_utility::func_3C4B() < -5536)
	{
	}

	var_01 = estimatedtimetillscorelimit(param_00);
	if(var_01 < 2)
	{
		level notify("match_ending_soon","score");
	}
}

//Function Number: 31
checkplayerscorelimitsoon()
{
	if(maps\mp\_utility::getwatcheddvar("scorelimit") <= 0 || maps\mp\_utility::func_491C())
	{
	}

	if(level.teambased)
	{
	}

	if(maps\mp\_utility::func_3C4B() < -5536)
	{
	}

	var_00 = estimatedtimetillscorelimit();
	if(var_00 < 2)
	{
		level notify("match_ending_soon","score");
	}
}

//Function Number: 32
func_1BD7()
{
	if(maps\mp\_utility::func_491C())
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

//Function Number: 33
func_86F0()
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

//Function Number: 34
matchstarttimerwaitforplayers()
{
	thread func_50C9("match_starting_in",level.var_6130 + level.prematchperiodend);
	func_8AEE(level.var_6130);
	if(level.prematchperiodend > 0 && !isdefined(level.hostmigrationtimer))
	{
		var_00 = level.prematchperiodend;
		if((maps\mp\_utility::func_4950() && !maps\mp\_utility::func_48C1()) || maps\mp\_utility::func_92AB())
		{
			var_00 = level.var_6130;
		}

		func_50C9("match_starting_in",var_00);
	}
}

//Function Number: 35
func_50CA(param_00)
{
	waittillframeend;
	introvisionset();
	level endon("match_start_timer_beginning");
	while(param_00 > 0 && !level.gameended)
	{
		setomnvar("ui_match_start_countdown",param_00);
		if(param_00 == 0)
		{
			visionsetnaked("",0);
		}

		param_00--;
		wait(1);
	}

	setomnvar("ui_match_start_countdown",0);
}

//Function Number: 36
func_50C9(param_00,param_01)
{
	self notify("matchStartTimer");
	self endon("matchStartTimer");
	level notify("match_start_timer_beginning");
	var_02 = int(param_01);
	if(var_02 >= 2)
	{
		setomnvar("ui_match_start_text",param_00);
		func_50CA(var_02);
		visionsetnaked("",3);
	}

	introvisionset();
	visionsetnaked("",1);
}

//Function Number: 37
introvisionset()
{
	if(!isdefined(level.introvisionset))
	{
		level.introvisionset = "mpIntro";
	}

	visionsetnaked(level.introvisionset,0);
}

//Function Number: 38
func_50CC()
{
	visionsetnaked("",0);
}

//Function Number: 39
func_5970()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(game["roundsWon"]["allies"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1 && game["roundsWon"]["axis"] == maps\mp\_utility::getwatcheddvar("winlimit") - 1)
	{
		var_00 = func_3A43();
		if(var_00 != game["defenders"])
		{
			game["switchedsides"] = !game["switchedsides"];
			level.switchedsides = 1;
		}
		else
		{
			level.switchedsides = undefined;
		}

		level.halftimetype = "overtime";
	}

	level.halftimetype = "halftime";
	game["switchedsides"] = !game["switchedsides"];
	level.switchedsides = 1;
}

//Function Number: 40
func_1BD5()
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
		func_5970();
		return 1;
	}

	return 0;
}

//Function Number: 41
func_8139()
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

	if(maps\mp\_utility::func_3C4A() <= 0)
	{
		return undefined;
	}

	if(!isdefined(level.starttime))
	{
		return undefined;
	}

	var_02 = maps\mp\_utility::func_3C4A();
	var_00 = gettime() - level.starttime / 1000;
	var_01 = maps\mp\_utility::func_3C4A() * 60 - var_02;
	if(isdefined(level.timepaused))
	{
		var_02 = var_02 + level.timepaused;
	}

	return var_02 + level.postroundtime;
}

//Function Number: 42
func_3509()
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

//Function Number: 43
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

//Function Number: 44
func_42C6()
{
	var_00 = gethostplayer();
	if(isdefined(var_00) && !var_00.hasspawned && !isdefined(var_00.selectedclass))
	{
		return 1;
	}

	return 0;
}

//Function Number: 45
roundendwait(param_00,param_01)
{
	var_02 = 0;
	while(!var_02)
	{
		var_03 = level.players;
		var_02 = 1;
		foreach(var_05 in var_03)
		{
			if(!isdefined(var_05.doingsplash))
			{
				continue;
			}

			if(!var_05 maps\mp\gametypes\_hud_message::func_48AF())
			{
				continue;
			}

			var_02 = 0;
		}

		wait(0.5);
	}

	if(!param_01)
	{
		wait(param_00);
		level notify("round_end_finished");
	}

	wait(param_00 / 2);
	level notify("give_match_bonus");
	wait(param_00 / 2);
	var_02 = 0;
	while(!var_02)
	{
		var_03 = level.players;
		var_02 = 1;
		foreach(var_05 in var_03)
		{
			if(!isdefined(var_05.doingsplash))
			{
				continue;
			}

			if(!var_05 maps\mp\gametypes\_hud_message::func_48AF())
			{
				continue;
			}

			var_02 = 0;
		}

		wait(0.5);
	}

	level notify("round_end_finished");
}

//Function Number: 46
func_6896(param_00)
{
	self setdepthoffield(0,128,512,4000,6,1.8);
}

//Function Number: 47
updatesquadvssquad()
{
	for(;;)
	{
		setnojiptime(1);
		wait(0.05);
	}
}

//Function Number: 48
callback_startgametype()
{
	maps\mp\_load::func_4FDD();
	maps\mp\_utility::func_4DB5("round_over",0);
	maps\mp\_utility::func_4DB5("game_over",0);
	maps\mp\_utility::func_4DB5("block_notifies",0);
	maps\mp\_utility::func_4DB5("post_game_level_event_active",0);
	level.var_6130 = 0;
	level.prematchperiodend = 0;
	level.postgamenotifies = 0;
	level.intermission = 0;
	setdvar("bg_compassShowEnemies",getdvar("scr_game_forceuav"));
	if(maps\mp\_utility::func_50C1())
	{
		setdvar("isMatchMakingGame",1);
	}
	else
	{
		setdvar("isMatchMakingGame",0);
	}

	if(level.multiteambased)
	{
		setdvar("ui_numteams",level.numteams);
	}

	if(!isdefined(game["gamestarted"]))
	{
		game["clientid"] = 0;
		game["truncated_killcams"] = 0;
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

		game["allies"] = "ghosts";
		game["axis"] = "federation";
		game["strings"]["press_to_spawn"] = &"PLATFORM_PRESS_TO_SPAWN";
		game["strings"]["spawn_next_round"] = &"MP_SPAWN_NEXT_ROUND";
		game["strings"]["spawn_flag_wait"] = &"MP_SPAWN_FLAG_WAIT";
		game["strings"]["spawn_tag_wait"] = &"MP_SPAWN_TAG_WAIT";
		game["strings"]["waiting_to_spawn"] = &"MP_WAITING_TO_SPAWN";
		game["strings"]["waiting_to_safespawn"] = &"MP_WAITING_TO_SAFESPAWN";
		game["strings"]["match_starting"] = &"MP_MATCH_STARTING";
		game["strings"]["change_class"] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
		game["strings"]["last_stand"] = &"MPUI_LAST_STAND";
		game["strings"]["final_stand"] = &"MPUI_FINAL_STAND";
		game["strings"]["c4_death"] = &"MPUI_C4_DEATH";
		game["strings"]["cowards_way"] = &"PLATFORM_COWARDS_WAY_OUT";
		game["colors"]["black"] = (0,0,0);
		game["colors"]["white"] = (1,1,1);
		game["colors"]["grey"] = (0.5,0.5,0.5);
		game["colors"]["cyan"] = (0.35,0.7,0.9);
		game["colors"]["orange"] = (0.9,0.6,0);
		game["colors"]["blue"] = (0.2,0.3,0.7);
		game["colors"]["red"] = (0.75,0.25,0.25);
		game["colors"]["green"] = (0.25,0.75,0.25);
		game["colors"]["yellow"] = (0.65,0.65,0);
		game["strings"]["allies_name"] = maps\mp\gametypes\_teams::func_3C3D("allies");
		game["icons"]["allies"] = maps\mp\gametypes\_teams::func_3C3A("allies");
		game["colors"]["allies"] = maps\mp\gametypes\_teams::getteamcolor("allies");
		game["strings"]["axis_name"] = maps\mp\gametypes\_teams::func_3C3D("axis");
		game["icons"]["axis"] = maps\mp\gametypes\_teams::func_3C3A("axis");
		game["colors"]["axis"] = maps\mp\gametypes\_teams::getteamcolor("axis");
		if(game["colors"]["allies"] == game["colors"]["black"])
		{
			game["colors"]["allies"] = game["colors"]["grey"];
		}

		if(game["colors"]["axis"] == game["colors"]["black"])
		{
			game["colors"]["axis"] = game["colors"]["grey"];
		}

		[[ level.onprecachegametype ]]();
		setdvarifuninitialized("min_wait_for_players",5);
		if(level.console)
		{
			if(!level.splitscreen)
			{
				if(maps\mp\_utility::func_92AB() || isdedicatedserver())
				{
					level.var_6130 = maps\mp\gametypes\_tweakables::func_3C5B("game","graceperiod_comp");
				}
				else
				{
					level.var_6130 = maps\mp\gametypes\_tweakables::func_3C5B("game","graceperiod");
				}

				level.prematchperiodend = maps\mp\gametypes\_tweakables::func_3C5B("game","matchstarttime");
			}
		}
		else
		{
			if(maps\mp\_utility::func_92AB() || isdedicatedserver())
			{
				level.var_6130 = maps\mp\gametypes\_tweakables::func_3C5B("game","playerwaittime_comp");
			}
			else
			{
				level.var_6130 = maps\mp\gametypes\_tweakables::func_3C5B("game","playerwaittime");
			}

			level.prematchperiodend = maps\mp\gametypes\_tweakables::func_3C5B("game","matchstarttime");
		}

		setnojipscore(0);
		setnojiptime(0);
		if(getdvar("squad_vs_squad") == "1")
		{
			thread updatesquadvssquad();
		}
	}
	else
	{
		setdvarifuninitialized("min_wait_for_players",5);
		if(level.console)
		{
			if(!level.splitscreen)
			{
				level.var_6130 = 5;
				level.prematchperiodend = maps\mp\gametypes\_tweakables::func_3C5B("game","matchstarttime");
			}
		}
		else
		{
			level.var_6130 = 5;
			level.prematchperiodend = maps\mp\gametypes\_tweakables::func_3C5B("game","matchstarttime");
		}
	}

	if(!isdefined(game["status"]))
	{
		game["status"] = "normal";
	}

	setdvar("ui_overtime",game["status"] == "overtime");
	if(game["status"] != "overtime" && game["status"] != "halftime")
	{
		if(!isdefined(game["switchedsides"]) && game["switchedsides"] == 1 && maps\mp\_utility::func_4912())
		{
			game["teamScores"]["allies"] = 0;
			game["teamScores"]["axis"] = 0;
		}

		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				game["teamScores"][level.teamnamelist[var_00]] = 0;
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
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				if(!isdefined(game["roundsWon"][level.teamnamelist[var_00]]))
				{
					game["roundsWon"][level.teamnamelist[var_00]] = 0;
				}
			}
		}
	}

	level.gameended = 0;
	level.forcedend = 0;
	level.hostforcedend = 0;
	if(!maps\mp\_utility::func_47BB())
	{
		level.hardcoremode = getdvarint("g_hardcore");
	}

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
	if(maps\mp\_utility::func_50C1())
	{
		level.maxallowedteamkills = 2;
	}
	else
	{
		level.maxallowedteamkills = -1;
	}

	if(!maps\mp\_utility::func_47BB())
	{
		thread maps\mp\gametypes\_healthoverlay::func_44DF();
		thread maps\mp\gametypes\_killcam::func_44DF();
		thread maps\mp\gametypes\_damage::func_460E();
		thread maps\mp\gametypes\_battlechatter_mp::func_44DF();
		thread maps\mp\gametypes\_music_and_dialog::func_44DF();
	}

	thread [[ level.intelinit ]]();
	thread maps\mp\gametypes\_persistence::func_44DF();
	thread lib_05D5::func_44DF();
	thread maps\mp\gametypes\_hud::func_44DF();
	thread maps\mp\gametypes\_serversettings::func_44DF();
	thread maps\mp\gametypes\_teams::func_44DF();
	thread maps\mp\gametypes\_weapons::func_44DF();
	thread maps\mp\gametypes\_outline::func_44DF();
	thread maps\mp\gametypes\_shellshock::func_44DF();
	thread maps\mp\gametypes\_deathicons::func_44DF();
	thread maps\mp\gametypes\_damagefeedback::func_44DF();
	thread maps\mp\gametypes\_objpoints::func_44DF();
	thread maps\mp\gametypes\_gameobjects::func_44DF();
	thread maps\mp\gametypes\_spectating::func_44DF();
	thread maps\mp\gametypes\_spawnlogic::func_44DF();
	thread maps\mp\_matchdata::func_44DF();
	thread maps\mp\_awards::func_44DF();
	thread maps\mp\_areas::func_44DF();
	thread [[ level.killstreakinit ]]();
	thread maps\mp\perks\_perks::func_44DF();
	thread maps\mp\_events::func_44DF();
	thread maps\mp\_defcon::func_44DF();
	thread [[ level.matcheventsinit ]]();
	thread maps\mp\_zipline::func_44DF();
	if(level.teambased)
	{
		thread maps\mp\gametypes\_friendicons::func_44DF();
	}

	thread maps\mp\gametypes\_hud_message::func_44DF();
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
		for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
		{
			level._wavedelay[level.teamnamelist[var_00]] = 0;
			level._lastwave[level.teamnamelist[var_00]] = 0;
			level._waveplayerspawnindex[level.teamnamelist[var_00]] = 0;
			level._aliveplayers[level.teamnamelist[var_00]] = [];
		}
	}

	setdvar("ui_scorelimit",0);
	setdvar("ui_allow_teamchange",1);
	if(maps\mp\_utility::func_3ABB())
	{
		setdvar("g_deadChat",0);
	}
	else
	{
		setdvar("g_deadChat",1);
	}

	var_01 = getdvarint("scr_" + level.gametype + "_waverespawndelay");
	if(var_01)
	{
		level.wavedelay["allies"] = var_01;
		level.wavedelay["axis"] = var_01;
		level.lastwave["allies"] = 0;
		level.lastwave["axis"] = 0;
		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				level._wavedelay[level.teamnamelist[var_00]] = var_01;
				level._lastwave[level.teamnamelist[var_00]] = 0;
			}
		}

		level thread func_8D8A();
	}

	maps\mp\_utility::func_36F3("prematch_done",0);
	if(maps\mp\_utility::func_47BB())
	{
		level.graceperiod = 10;
	}
	else
	{
		level.graceperiod = 15;
	}

	level.ingraceperiod = level.graceperiod;
	maps\mp\_utility::func_36F3("graceperiod_done",0);
	level.roundenddelay = 4;
	level.halftimeroundenddelay = 4;
	level.noragdollents = getentarray("noragdoll","targetname");
	if(level.teambased)
	{
		maps\mp\gametypes\_gamescore::func_8740("axis");
		maps\mp\gametypes\_gamescore::func_8740("allies");
		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				maps\mp\gametypes\_gamescore::func_8740(level.teamnamelist[var_00]);
			}
		}
	}
	else
	{
		thread maps\mp\gametypes\_gamescore::initialdmscoreupdate();
	}

	thread func_874F();
	level notify("update_scorelimit");
	[[ level.onstartgametype ]]();
	level.scorepercentagecutoff = getdvarint("scr_" + level.gametype + "_score_percentage_cut_off",80);
	level.timepercentagecutoff = getdvarint("scr_" + level.gametype + "_time_percentage_cut_off",80);
	if(!level.console && getdvar("dedicated") == "dedicated LAN server" || getdvar("dedicated") == "dedicated internet server")
	{
		thread verifydedicatedconfiguration();
	}

	thread func_7AD5();
	level thread maps\mp\_utility::func_8755();
	level thread timelimitthread();
	if(!maps\mp\_utility::func_47BB())
	{
		level thread maps\mp\gametypes\_damage::func_2893();
	}

	func_536F();
}

//Function Number: 49
func_1944()
{
	endparty();
	if(!level.gameended)
	{
		level thread func_34D1();
	}
}

//Function Number: 50
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

//Function Number: 51
timelimitthread()
{
	level endon("game_ended");
	var_00 = maps\mp\_utility::func_3C4B();
	while(game["state"] == "playing")
	{
		thread func_1BDB(var_00);
		var_00 = maps\mp\_utility::func_3C4B();
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

//Function Number: 52
func_874F()
{
	for(;;)
	{
		level common_scripts\utility::func_8B4F("update_scorelimit","update_winlimit");
		if(!maps\mp\_utility::func_4950() || !maps\mp\_utility::func_491C())
		{
			setdvar("ui_scorelimit",maps\mp\_utility::getwatcheddvar("scorelimit"));
			thread func_1BD7();
			continue;
		}

		setdvar("ui_scorelimit",maps\mp\_utility::getwatcheddvar("winlimit"));
	}
}

//Function Number: 53
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

		maps\mp\gametypes\_hostmigration::func_8BBA();
	}
}

//Function Number: 54
func_7C73()
{
	self notify("stop_ticking");
}

//Function Number: 55
func_811E()
{
	level endon("game_ended");
	wait(0.05);
	var_00 = spawn("script_origin",(0,0,0));
	var_00 hide();
	while(game["state"] == "playing")
	{
		if(!level.timerstopped && maps\mp\_utility::func_3C4A())
		{
			var_01 = gettimeremaining() / 1000;
			var_02 = int(var_01 + 0.5);
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

//Function Number: 56
func_3704()
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

//Function Number: 57
updatetimerpausedness()
{
	var_00 = level.timerstoppedforgamemode || isdefined(level.hostmigrationtimer);
	if(!maps\mp\_utility::func_36F1("prematch_done"))
	{
		var_00 = 0;
	}

	if(!level.timerstopped && var_00)
	{
		level.timerstopped = 1;
		level.timerpausetime = gettime();
	}

	if(level.timerstopped && !var_00)
	{
		level.timerstopped = 0;
		level.discardtime = level.discardtime + gettime() - level.timerpausetime;
	}
}

//Function Number: 58
func_5B5D()
{
	level.timerstoppedforgamemode = 1;
	updatetimerpausedness();
}

//Function Number: 59
func_6669()
{
	level.timerstoppedforgamemode = 0;
	updatetimerpausedness();
}

//Function Number: 60
func_7AD5()
{
	thread func_3704();
	level.timerstopped = 0;
	level.timerstoppedforgamemode = 0;
	setomnvar("ui_prematch_period",1);
	if(isdefined(level.customprematchperiod))
	{
		[[ level.customprematchperiod ]]();
	}
	else
	{
		func_6130();
	}

	maps\mp\_utility::func_36F4("prematch_done");
	level notify("prematch_over");
	setomnvar("ui_prematch_period",0);
	updatetimerpausedness();
	thread func_811E();
	thread graceperiod();
	if(!maps\mp\_utility::func_47BB())
	{
		thread maps\mp\gametypes\_missions::roundbegin();
	}
}

//Function Number: 61
func_8D8A()
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

//Function Number: 62
func_3A43()
{
	var_00["allies"] = 0;
	var_00["axis"] = 0;
	var_01["allies"] = 0;
	var_01["axis"] = 0;
	foreach(var_03 in level.players)
	{
		var_04 = var_03.pers["team"];
		if(isdefined(var_04) && var_04 == "allies" || var_04 == "axis")
		{
			var_00[var_04] = var_00[var_04] + var_03.kills;
			var_01[var_04] = var_01[var_04] + var_03.deaths;
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

	if(var_01["allies"] < var_01["axis"])
	{
		return "allies";
	}
	else if(var_01["axis"] < var_01["allies"])
	{
		return "axis";
	}

	if(randomint(2) == 0)
	{
		return "allies";
	}

	return "axis";
}

//Function Number: 63
func_634B(param_00)
{
	if(maps\mp\_utility::func_50C1())
	{
		func_721B();
		if(func_42C6())
		{
			level.hostforcedend = 1;
			logstring("host idled out");
			endlobby();
		}

		func_8700(param_00);
	}

	updatewinlossstats(param_00);
}

//Function Number: 64
displayroundend(param_00,param_01)
{
	if(maps\mp\_utility::func_4912())
	{
		param_00 = "roundend";
		var_02 = game["music"]["allies_suspense"].size;
		var_03 = game["music"]["axis_suspense"].size;
		maps\mp\_utility::func_6045(game["music"]["allies_suspense"][randomint(var_02)],"allies");
		maps\mp\_utility::func_6045(game["music"]["axis_suspense"][randomint(var_03)],"axis");
	}

	foreach(var_05 in level.players)
	{
		if(isdefined(var_05.connectedpostgame) || var_05.pers["team"] == "spectator" && !var_05 ismlgspectator())
		{
			continue;
		}

		if(level.teambased)
		{
			var_05 thread maps\mp\gametypes\_hud_message::func_7F9F(param_00,1,param_01);
			continue;
		}

		var_05 thread maps\mp\gametypes\_hud_message::func_5A23(param_00,param_01);
	}

	if(!maps\mp\_utility::func_8C49())
	{
		level notify("round_win",param_00);
	}

	if(maps\mp\_utility::func_8C49())
	{
		roundendwait(level.roundenddelay,0);
	}

	roundendwait(level.roundenddelay,1);
}

//Function Number: 65
displaygameend(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.connectedpostgame) || var_03.pers["team"] == "spectator" && !var_03 ismlgspectator())
		{
			continue;
		}

		if(level.teambased)
		{
			var_03 thread maps\mp\gametypes\_hud_message::func_7F9F(param_00,0,param_01);
			continue;
		}

		var_03 thread maps\mp\gametypes\_hud_message::func_5A23(param_00,param_01);
	}

	level notify("game_win",param_00);
	roundendwait(level.postroundtime,1);
}

//Function Number: 66
func_27F3()
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
	var_01 = 0;
	if(isdefined(level.switchedsides))
	{
		var_01 = game["end_reason"]["switching_sides"];
	}

	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.connectedpostgame) || var_03.pers["team"] == "spectator" && !var_03 ismlgspectator())
		{
			continue;
		}

		var_03 thread maps\mp\gametypes\_hud_message::func_7F9F(var_00,1,var_01);
	}

	roundendwait(level.halftimeroundenddelay,0);
}

//Function Number: 67
freezeallplayers(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	foreach(var_04 in level.players)
	{
		var_04 thread func_350F(param_00);
		var_04 thread func_6896(4);
		var_04 func_3509();
		var_04 setclientdvars("cg_everyoneHearsEveryone",1,"cg_drawSpectatorMessages",0);
		if(isdefined(param_01) && isdefined(param_02))
		{
			var_04 setclientdvars(param_01,param_02);
		}
	}

	foreach(var_07 in level.agentarray)
	{
		var_07 maps\mp\_utility::func_350E(1);
	}
}

//Function Number: 68
endgameovertime(param_00,param_01)
{
	visionsetnaked("mpOutro",0.5);
	setdvar("bg_compassShowEnemies",0);
	freezeallplayers();
	level notify("round_switch","overtime");
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.connectedpostgame) || var_03.pers["team"] == "spectator" && !var_03 ismlgspectator())
		{
			continue;
		}

		if(level.teambased)
		{
			var_03 thread maps\mp\gametypes\_hud_message::func_7F9F(param_00,0,param_01);
			continue;
		}

		var_03 thread maps\mp\gametypes\_hud_message::func_5A23(param_00,param_01);
	}

	roundendwait(level.roundenddelay,0);
	if(isdefined(level.finalkillcam_winner))
	{
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::func_3BE4();
		foreach(var_03 in level.players)
		{
			var_03 notify("reset_outcome");
		}

		level notify("game_cleanup");
		func_8BB7();
		foreach(var_03 in level.players)
		{
			if(isdefined(var_03.connectedpostgame) || var_03.pers["team"] == "spectator" && !var_03 ismlgspectator())
			{
				continue;
			}

			if(level.teambased)
			{
				var_03 thread maps\mp\gametypes\_hud_message::func_7F9F(param_00,0,param_01);
				continue;
			}

			var_03 thread maps\mp\gametypes\_hud_message::func_5A23(param_00,param_01);
		}
	}

	game["status"] = "overtime";
	level notify("restarting");
	game["state"] = "playing";
	map_restart(1);
}

//Function Number: 69
func_2D58()
{
	visionsetnaked("mpOutro",0.5);
	setdvar("bg_compassShowEnemies",0);
	game["switchedsides"] = !game["switchedsides"];
	level.switchedsides = undefined;
	freezeallplayers();
	foreach(var_01 in level.players)
	{
		var_01.pers["stats"] = var_01.stats;
	}

	level notify("round_switch","halftime");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.connectedpostgame) || var_01.pers["team"] == "spectator" && !var_01 ismlgspectator())
		{
			continue;
		}

		var_01 thread maps\mp\gametypes\_hud_message::func_7F9F("halftime",1,game["end_reason"]["switching_sides"]);
	}

	roundendwait(level.roundenddelay,0);
	if(isdefined(level.finalkillcam_winner))
	{
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::func_3BE4();
		foreach(var_01 in level.players)
		{
			var_01 notify("reset_outcome");
		}

		level notify("game_cleanup");
		func_8BB7();
		foreach(var_01 in level.players)
		{
			if(isdefined(var_01.connectedpostgame) || var_01.pers["team"] == "spectator" && !var_01 ismlgspectator())
			{
				continue;
			}

			var_01 thread maps\mp\gametypes\_hud_message::func_7F9F("halftime",1,game["end_reason"]["switching_sides"]);
		}
	}

	game["status"] = "halftime";
	level notify("restarting");
	game["state"] = "playing";
	setdvar("ui_game_state",game["state"]);
	map_restart(1);
}

//Function Number: 70
endgame(param_00,param_01,param_02)
{
	if(maps\mp\_utility::func_47BB())
	{
		[[ level.endgame_alien ]](param_00,param_01);
	}

	func_2D56(param_00,param_01,param_02);
}

//Function Number: 71
func_2D56(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(game["state"] == "postgame" || level.gameended && !isdefined(level.gtnw) || !level.gtnw)
	{
	}

	setomnvar("ui_pause_menu_show",0);
	game["state"] = "postgame";
	setdvar("ui_game_state","postgame");
	level.gameendtime = gettime();
	level.gameended = 1;
	level.ingraceperiod = 0;
	level notify("game_ended",param_00);
	maps\mp\_utility::levelflagset("game_over");
	maps\mp\_utility::levelflagset("block_notifies");
	common_scripts\utility::func_8AFE();
	setgameendtime(0);
	var_03 = getmatchdata("gameLength");
	var_03 = var_03 + int(maps\mp\_utility::func_3BE4());
	setmatchdata("gameLength",var_03);
	maps\mp\gametypes\_playerlogic::func_61AE();
	if(isdefined(param_00) && isstring(param_00) && param_00 == "overtime")
	{
		level.finalkillcam_winner = "none";
		endgameovertime(param_00,param_01);
	}

	if(isdefined(param_00) && isstring(param_00) && param_00 == "halftime")
	{
		level.finalkillcam_winner = "none";
		func_2D58();
	}

	if(isdefined(level.finalkillcam_winner))
	{
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::func_3BE4();
	}

	game["roundsPlayed"]++;
	if(level.teambased)
	{
		if(param_00 == "axis" || param_00 == "allies")
		{
			game["roundsWon"][param_00]++;
		}

		maps\mp\gametypes\_gamescore::func_8740("axis");
		maps\mp\gametypes\_gamescore::func_8740("allies");
	}
	else if(isdefined(param_00) && isplayer(param_00))
	{
		game["roundsWon"][param_00.guid]++;
	}

	maps\mp\gametypes\_gamescore::func_870E();
	func_634B(param_00);
	foreach(var_05 in level.players)
	{
		var_05 setclientdvar("ui_opensummary",1);
		if(maps\mp\_utility::func_8C4A() || maps\mp\_utility::func_8C49())
		{
			var_05 maps\mp\killstreaks\_killstreaks::clearkillstreaks();
		}
	}

	setdvar("g_deadChat",1);
	setdvar("ui_allow_teamchange",0);
	setdvar("bg_compassShowEnemies",0);
	freezeallplayers(1,"cg_fovScale",1);
	if(!param_02)
	{
		visionsetnaked("mpOutro",0.5);
	}

	if(!maps\mp\_utility::func_8C4A() && !param_02)
	{
		displayroundend(param_00,param_01);
		if(isdefined(level.finalkillcam_winner))
		{
			foreach(var_05 in level.players)
			{
				var_05 notify("reset_outcome");
			}

			level notify("game_cleanup");
			func_8BB7();
		}

		if(!maps\mp\_utility::func_8C49())
		{
			maps\mp\_utility::func_4DB4("block_notifies");
			if(func_1BD5())
			{
				func_27F3();
			}

			foreach(var_05 in level.players)
			{
				var_05.pers["stats"] = var_05.stats;
			}

			level notify("restarting");
			game["state"] = "playing";
			setdvar("ui_game_state","playing");
			map_restart(1);
		}

		if(!level.forcedend)
		{
			var_03 = func_8727(param_02);
		}
	}

	if(!isdefined(game["clientMatchDataDef"]))
	{
		game["clientMatchDataDef"] = "mp/clientmatchdata.def";
		setclientmatchdatadef(game["clientMatchDataDef"]);
	}

	maps\mp\gametypes\_missions::func_6894(param_02);
	if(level.teambased && maps\mp\_utility::func_4950() && level.gameended && !maps\mp\_utility::func_4912())
	{
		if(game["roundsWon"]["allies"] == game["roundsWon"]["axis"])
		{
			param_02 = "tie";
		}
		else if(game["roundsWon"]["axis"] > game["roundsWon"]["allies"])
		{
			level.finalkillcam_winner = "axis";
			param_02 = "axis";
		}
		else
		{
			level.finalkillcam_winner = "allies";
			param_02 = "allies";
		}
	}

	displaygameend(param_02,var_03);
	if(isdefined(level.finalkillcam_winner) && maps\mp\_utility::func_8C4A())
	{
		foreach(var_09 in level.players)
		{
			var_09 notify("reset_outcome");
		}

		level notify("game_cleanup");
		func_8BB7();
	}

	maps\mp\_utility::func_4DB4("block_notifies");
	level.intermission = 1;
	level notify("start_custom_ending");
	level notify("spawning_intermission");
	foreach(var_09 in level.players)
	{
		var_09 notify("reset_outcome");
		var_09 thread maps\mp\gametypes\_playerlogic::func_78AA();
	}

	func_61D3();
	wait(1);
	checkforpersonalbests();
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

		setmatchdata("alliesScore",getteamscore("allies"));
		setmatchdata("axisScore",getteamscore("axis"));
	}
	else
	{
		setmatchdata("victor","none");
	}

	foreach(var_09 in level.players)
	{
		var_09 setcommonplayerdata("round","endReasonTextIndex",var_03);
		if(var_09 maps\mp\_utility::func_634C() && !maps\mp\_utility::func_47BB())
		{
			var_09 maps\mp\_matchdata::logfinalstats();
		}
	}

	setmatchdata("host",level.hostname);
	if(maps\mp\_utility::func_50C1())
	{
		setmatchdata("playlistVersion",getplaylistversion());
		setmatchdata("playlistID",getplaylistid());
		setmatchdata("isDedicated",isdedicatedserver());
	}

	sendmatchdata();
	foreach(var_09 in level.players)
	{
		var_09.pers["stats"] = var_09.stats;
	}

	if(!var_04 && !level.postgamenotifies)
	{
		if(!maps\mp\_utility::func_8C4A())
		{
			wait(6);
		}
		else
		{
			wait(min(10,4 + level.postgamenotifies));
		}
	}
	else
	{
		wait(min(10,4 + level.postgamenotifies));
	}

	maps\mp\_utility::levelflagwaitopen("post_game_level_event_active");
	setnojipscore(0);
	setnojiptime(0);
	level notify("exitLevel_called");
	exitlevel(0);
}

//Function Number: 72
func_8727(param_00)
{
	if(!level.teambased)
	{
		return 1;
	}

	if(maps\mp\_utility::func_4912())
	{
		if(maps\mp\_utility::func_427E())
		{
			return game["end_reason"]["score_limit_reached"];
		}

		if(maps\mp\_utility::func_4280())
		{
			return game["end_reason"]["time_limit_reached"];
		}
	}
	else if(maps\mp\_utility::hitroundlimit())
	{
		return game["end_reason"]["round_limit_reached"];
	}

	if(maps\mp\_utility::func_4281())
	{
		return game["end_reason"]["score_limit_reached"];
	}

	return game["end_reason"]["objective_completed"];
}

//Function Number: 73
estimatedtimetillscorelimit(param_00)
{
	var_01 = getscoreperminute(param_00);
	var_02 = func_3BE3(param_00);
	var_03 = 999999;
	if(var_01)
	{
		var_03 = var_02 / var_01;
	}

	return var_03;
}

//Function Number: 74
getscoreperminute(param_00)
{
	var_01 = maps\mp\_utility::getwatcheddvar("scorelimit");
	var_02 = maps\mp\_utility::func_3C4A();
	var_03 = maps\mp\_utility::func_3C4B() / -5536 + 0.0001;
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

//Function Number: 75
func_3BE3(param_00)
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

//Function Number: 76
func_3CF4()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::func_8BBE(3);
	thread maps\mp\_utility::func_7FA0("callout_lastteammemberalive",self,self.pers["team"]);
	foreach(var_01 in level.teamnamelist)
	{
		if(self.pers["team"] != var_01)
		{
			thread maps\mp\_utility::func_7FA0("callout_lastenemyalive",self,var_01);
		}
	}

	level notify("last_alive",self);
}

//Function Number: 77
func_61D3()
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
		if(level.ps3 && var_02.name.size > level.maxnamelength)
		{
			var_03 = "";
			for(var_04 = 0;var_04 < level.maxnamelength - 3;var_04++)
			{
				var_03 = var_03 + var_02.name[var_04];
			}

			var_03 = var_03 + "...";
		}
		else
		{
			var_03 = var_02.name;
		}

		setclientmatchdata("players",var_02.clientmatchdataid,"xuid",var_03);
		var_02 setcommonplayerdata("round","clientMatchIndex",var_02.clientmatchdataid);
	}

	maps\mp\_awards::assignawards();
	maps\mp\_scoreboard::func_61D4();
	sendclientmatchdata();
}

//Function Number: 78
func_821F(param_00,param_01)
{
	thread func_8091(param_00,1,"deaths");
}

//Function Number: 79
func_8210(param_00,param_01)
{
	if(isdefined(self) && isplayer(self))
	{
		if(param_01 != "MOD_FALLING")
		{
			if(param_01 == "MOD_MELEE" && issubstr(param_00,"tactical"))
			{
				maps\mp\_matchdata::func_4F13("tactical","kills",1);
				maps\mp\_matchdata::func_4F13("tactical","hits",1);
				maps\mp\gametypes\_persistence::func_4486("tactical","kills",1);
				maps\mp\gametypes\_persistence::func_4486("tactical","hits",1);
			}

			if(param_01 == "MOD_MELEE" && !maps\mp\gametypes\_weapons::func_494E(param_00) && param_00 != "iw6_knifeonly_mp" && param_00 != "iw6_knifeonlyfast_mp")
			{
				maps\mp\_matchdata::func_4F13("none","kills",1);
				maps\mp\_matchdata::func_4F13("none","hits",1);
				maps\mp\gametypes\_persistence::func_4486("none","kills",1);
				maps\mp\gametypes\_persistence::func_4486("none","hits",1);
			}

			thread func_8091(param_00,1,"kills");
		}

		if(param_01 == "MOD_HEAD_SHOT")
		{
			thread func_8091(param_00,1,"headShots");
		}
	}
}

//Function Number: 80
func_7219(param_00,param_01,param_02)
{
	if(!param_01)
	{
	}

	var_03 = maps\mp\_utility::getweaponclass(param_00);
	if(var_03 == "killstreak" || var_03 == "other" && param_00 != "trophy_mp")
	{
	}

	if(maps\mp\_utility::func_48B7(param_00))
	{
	}

	if(var_03 == "weapon_grenade" || var_03 == "weapon_explosive" || param_00 == "trophy_mp")
	{
		var_04 = maps\mp\_utility::func_7CEA(param_00,"_mp");
		maps\mp\gametypes\_persistence::func_4488(var_04,param_02,param_01);
		maps\mp\_matchdata::logweaponstat(var_04,param_02,param_01);
	}

	if(!isdefined(self.trackingweaponname))
	{
		self.trackingweaponname = param_01;
	}

	if(param_01 != self.trackingweaponname)
	{
		maps\mp\gametypes\_persistence::func_8756();
		self.trackingweaponname = param_01;
	}

	switch(var_03)
	{
		case "shots":
			self.trackingweaponshots++;
			break;

		case "hits":
			self.trackingweaponhits++;
			break;

		case "headShots":
			self.trackingweaponheadshots++;
			break;

		case "kills":
			self.trackingweaponkills++;
			break;
	}

	if(var_03 == "deaths")
	{
		var_05 = undefined;
		var_06 = maps\mp\_utility::func_3A37(param_01);
		if(!maps\mp\_utility::iscacprimaryweapon(var_06) && !maps\mp\_utility::func_4890(var_06))
		{
		}

		var_07 = maps\mp\_utility::func_3C72(param_01);
		maps\mp\gametypes\_persistence::func_4488(var_06,var_03,param_02);
		maps\mp\_matchdata::logweaponstat(var_06,"deaths",param_02);
		foreach(var_09 in var_07)
		{
			if(var_09 == "scope")
			{
				continue;
			}

			maps\mp\gametypes\_persistence::func_4486(var_09,var_03,param_02);
			maps\mp\_matchdata::func_4F13(var_09,var_03,param_02);
		}
	}
}

//Function Number: 81
func_7057(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
	}

	if(!isdefined(param_00))
	{
		param_01 func_7219(param_02,1,"hits");
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
		param_01 func_7219(param_02,1,"hits");
	}
}

//Function Number: 82
func_8091(param_00,param_01,param_02)
{
	self endon("disconnect");
	waittillframeend;
	func_7219(param_00,param_01,param_02);
}

//Function Number: 83
checkforpersonalbests()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 maps\mp\_utility::func_634C())
		{
			var_02 = var_01 getcommonplayerdata("round","kills");
			var_03 = var_01 getcommonplayerdata("round","deaths");
			var_04 = var_01.pers["summary"]["xp"];
			var_05 = var_01 getrankedplayerdata("bestKills");
			var_06 = var_01 getrankedplayerdata("mostDeaths");
			var_07 = var_01 getrankedplayerdata("mostXp");
			if(var_02 > var_05)
			{
				var_01 setrankedplayerdata("bestKills",var_02);
			}

			if(var_04 > var_07)
			{
				var_01 setrankedplayerdata("mostXp",var_04);
			}

			if(var_03 > var_06)
			{
				var_01 setrankedplayerdata("mostDeaths",var_03);
			}

			if(!maps\mp\_utility::func_47BB())
			{
				var_01 checkforbestweapon();
			}

			var_01 maps\mp\_matchdata::func_4F28(var_04,"totalXp");
			var_01 maps\mp\_matchdata::func_4F28(var_01.pers["summary"]["score"],"scoreXp");
			var_01 maps\mp\_matchdata::func_4F28(var_01.pers["summary"]["operation"],"operationXp");
			var_01 maps\mp\_matchdata::func_4F28(var_01.pers["summary"]["challenge"],"challengeXp");
			var_01 maps\mp\_matchdata::func_4F28(var_01.pers["summary"]["match"],"matchXp");
			var_01 maps\mp\_matchdata::func_4F28(var_01.pers["summary"]["misc"],"miscXp");
		}

		if(isdefined(var_01.pers["confirmed"]))
		{
			var_01 maps\mp\_matchdata::logkillsconfirmed();
		}

		if(isdefined(var_01.pers["denied"]))
		{
			var_01 maps\mp\_matchdata::func_4F1C();
		}
	}
}

//Function Number: 84
isvalidbestweapon(param_00)
{
	var_01 = maps\mp\_utility::getweaponclass(param_00);
	return isdefined(param_00) && param_00 != "" && !maps\mp\_utility::func_48F7(param_00) && var_01 != "killstreak" && var_01 != "other";
}

//Function Number: 85
checkforbestweapon()
{
	var_00 = maps\mp\_matchdata::buildbaseweaponlist();
	var_01 = "";
	var_02 = -1;
	for(var_03 = 0;var_03 < var_00.size;var_03++)
	{
		var_04 = var_00[var_03];
		var_04 = maps\mp\_utility::func_3A37(var_04);
		if(isvalidbestweapon(var_04))
		{
			var_05 = self getrankedplayerdata("weaponStats",var_04,"kills");
			if(var_05 > var_02)
			{
				var_01 = var_04;
				var_02 = var_05;
			}
		}
	}

	var_06 = self getrankedplayerdata("weaponStats",var_01,"shots");
	var_07 = self getrankedplayerdata("weaponStats",var_01,"headShots");
	var_08 = self getrankedplayerdata("weaponStats",var_01,"hits");
	var_09 = self getrankedplayerdata("weaponStats",var_01,"deaths");
	var_0A = 0;
	self setrankedplayerdata("bestWeapon","kills",var_02);
	self setrankedplayerdata("bestWeapon","shots",var_06);
	self setrankedplayerdata("bestWeapon","headShots",var_07);
	self setrankedplayerdata("bestWeapon","hits",var_08);
	self setrankedplayerdata("bestWeapon","deaths",var_09);
	self setrankedplayerdata("bestWeaponXP",var_0A);
	var_0B = int(tablelookup("mp/statstable.csv",4,var_01,0));
	self setrankedplayerdata("bestWeaponIndex",var_0B);
}

//Function Number: 86
func_536F()
{
	level waittill("round_end_finished");
	level notify("final_killcam_done");
	level.forcedend = 1;
	level thread endgame("axis",game["end_reason"]["objective_failed"]);
}