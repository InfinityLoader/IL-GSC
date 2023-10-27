/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_gamelogic.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 77
 * Decompile Time: 1193 ms
 * Timestamp: 10/27/2023 2:12:25 AM
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
		wait 10;
	}

	level.forfeit_aborted = 0;
	var_01 = 20;
	matchforfeittimer(var_01);
	var_02 = &"";
	if(!isdefined(param_00))
	{
		level.finalkillcam_winner = "none";
		var_02 = game["strings"]["players_forfeited"];
		var_03 = level.players[0];
	}
	else if(var_01 == "allies")
	{
		level.finalkillcam_winner = "axis";
		var_03 = game["strings"]["allies_forfeited"];
		var_03 = "axis";
	}
	else if(var_01 == "axis")
	{
		level.finalkillcam_winner = "allies";
		var_03 = game["strings"]["axis_forfeited"];
		var_03 = "allies";
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
	if(isdefined(level.matchforfeittimer))
	{
		level.matchforfeittimer maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(level.matchforfeittext))
	{
		level.matchforfeittext maps\mp\gametypes\_hud_util::destroyelem();
	}
}

//Function Number: 3
matchforfeittimer_internal(param_00,param_01)
{
	waittillframeend;
	level endon("match_forfeit_timer_beginning");
	while(param_00 > 0 && !level.gameended && !level.forfeit_aborted && !level.ingraceperiod)
	{
		param_01 thread maps\mp\gametypes\_hud::fontpulse(level);
		wait param_01.inframes * 0.05;
		param_01 setvalue(param_00);
		param_00--;
		wait 1 - param_01.inframes * 0.05;
	}
}

//Function Number: 4
matchforfeittimer(param_00)
{
	level notify("match_forfeit_timer_beginning");
	var_01 = maps\mp\gametypes\_hud_util::createserverfontstring("objective",1.5);
	var_01 maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,-40);
	var_01.sort = 1001;
	var_01 settext(game["strings"]["opponent_forfeiting_in"]);
	var_01.foreground = 0;
	var_01.hidewheninmenu = 1;
	var_02 = maps\mp\gametypes\_hud_util::createserverfontstring("hudbig",1);
	var_02 maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,0);
	var_02.sort = 1001;
	var_02.color = (1,1,0);
	var_02.foreground = 0;
	var_02.hidewheninmenu = 1;
	var_02 maps\mp\gametypes\_hud::fontpulseinit();
	var_03 = int(param_00);
	level.matchforfeittimer = var_02;
	level.matchforfeittext = var_01;
	matchforfeittimer_internal(var_03,var_02);
	var_02 maps\mp\gametypes\_hud_util::destroyelem();
	var_01 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 5
default_ondeadevent(param_00)
{
	level.finalkillcam_winner = "none";
	if(param_00 == "allies")
	{
		iprintln(game["strings"]["allies_eliminated"]);
		logstring("team eliminated, win: opfor, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
		level.finalkillcam_winner = "axis";
		thread endgame("axis",game["strings"]["allies_eliminated"]);
		return;
	}

	if(param_00 == "axis")
	{
		iprintln(game["strings"]["axis_eliminated"]);
		logstring("team eliminated, win: allies, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
		level.finalkillcam_winner = "allies";
		thread endgame("allies",game["strings"]["axis_eliminated"]);
		return;
	}

	logstring("tie, allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	level.finalkillcam_winner = "none";
	if(level.teambased)
	{
		thread endgame("tie",game["strings"]["tie"]);
		return;
	}

	thread endgame(undefined,game["strings"]["tie"]);
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
		thread endgame(var_01,&"MP_ENEMIES_ELIMINATED");
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
		var_00 = lib_036E::func_2B78();
		if(isdefined(var_00))
		{
			logstring("time limit, win: " + var_00.name);
		}
		else
		{
			logstring("time limit, tie");
		}
	}

	thread endgame(var_00,game["strings"]["time_limit_reached"]);
}

//Function Number: 8
default_onhalftime()
{
	var_00 = undefined;
	level.finalkillcam_winner = "none";
	thread endgame("halftime",game["strings"]["time_limit_reached"]);
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

		logstring("host ended game, win: " + var_00 + ", allies: " + game["teamScores"]["allies"] + ", opfor: " + game["teamScores"]["axis"]);
	}
	else
	{
		var_00 = lib_036E::func_2B78();
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
		var_01 = &"MP_ENDED_GAME";
	}
	else
	{
		var_01 = &"MP_HOST_ENDED_GAME";
	}

	thread endgame(var_00,var_01);
}

//Function Number: 10
onscorelimit()
{
	var_00 = game["strings"]["score_limit_reached"];
	var_01 = undefined;
	level.finalkillcam_winner = "none";
	if(level.teambased)
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
		var_01 = lib_036E::func_2B78();
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
		var_00["allies"] = level.livescount["allies"];
		if(isdefined(level.disablespawning) && level.disablespawning)
		{
		}

		if(!level.alivecount["allies"] && !level.alivecount["axis"] && !var_7B["allies"] && !var_7B["axis"])
		{
			return [[ level.ondeadevent ]]("all");
		}

		if(!level.alivecount["allies"] && !var_7B["allies"])
		{
			return [[ level.ondeadevent ]]("allies");
		}

		if(!level.alivecount["axis"] && !var_7B["axis"])
		{
			return [[ level.ondeadevent ]]("axis");
		}

		if(level.alivecount["allies"] == 1 && !var_7B["allies"])
		{
			if(!isdefined(level.onelefttime["allies"]))
			{
				level.onelefttime["allies"] = gettime();
				return [[ level.ononeleftevent ]]("allies");
			}
		}

		if(level.alivecount["axis"] == 1 && !var_7B["axis"])
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

	var_01 = maps\mp\_utility::getpotentiallivingplayers();
	if(var_01.size == 1)
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
		wait param_00 - 10;
	}

	for(;;)
	{
		var_01 playsound("ui_mp_timer_countdown");
		wait 1;
	}
}

//Function Number: 14
waitforplayers(param_00)
{
	var_01 = gettime() + param_00 * 1000 - 200;
	if(level.teambased)
	{
		while((!level.hasspawned["axis"] || !level.hasspawned["allies"]) && gettime() < var_01)
		{
			wait 0.05;
		}

		return;
	}

	while(level.maxplayercount < 2 && gettime() < var_01)
	{
		wait 0.05;
	}
}

//Function Number: 15
prematchperiod()
{
	level endon("game_ended");
	if(level.prematchperiod > 0)
	{
		if(level.console)
		{
			thread matchstarttimer("match_starting_in",level.prematchperiod);
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

	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] maps\mp\_utility::freezecontrolswrapper(0);
		level.players[var_00] enableweapons();
		var_01 = maps\mp\_utility::getobjectivehinttext(level.players[var_00].pers["team"]);
		if(!isdefined(var_01) || !level.players[var_00].hasspawned)
		{
			continue;
		}

		level.players[var_00] setclientdvar("scr_objectiveText",var_01);
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
	while(level.ingraceperiod > 0)
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

	level thread updategameevents();
}

//Function Number: 17
updatewinstats(param_00)
{
	if(!param_00 maps\mp\_utility::rankingenabled())
	{
		return;
	}

	param_00 maps\mp\gametypes\_persistance::statadd("losses",-1);
	param_00 maps\mp\gametypes\_persistance::statadd("wins",1);
	param_00 maps\mp\_utility::updatepersratio("winLossRatio","wins","losses");
	param_00 maps\mp\gametypes\_persistance::statadd("currentWinStreak",1);
	var_01 = param_00 maps\mp\gametypes\_persistance::statget("currentWinStreak");
	if(var_01 > param_00 maps\mp\gametypes\_persistance::statget("winStreak"))
	{
		param_00 maps\mp\gametypes\_persistance::statset("winStreak",var_01);
	}

	param_00 maps\mp\gametypes\_persistance::statsetchild("round","win",1);
	param_00 maps\mp\gametypes\_persistance::statsetchild("round","loss",0);
}

//Function Number: 18
updatelossstats(param_00)
{
	if(!param_00 maps\mp\_utility::rankingenabled())
	{
		return;
	}

	param_00 maps\mp\gametypes\_persistance::statadd("losses",1);
	param_00 maps\mp\_utility::updatepersratio("winLossRatio","wins","losses");
	param_00 maps\mp\gametypes\_persistance::statsetchild("round","loss",1);
}

//Function Number: 19
updatetiestats(param_00)
{
	if(!param_00 maps\mp\_utility::rankingenabled())
	{
		return;
	}

	param_00 maps\mp\gametypes\_persistance::statadd("losses",-1);
	param_00 maps\mp\gametypes\_persistance::statadd("ties",1);
	param_00 maps\mp\_utility::updatepersratio("winLossRatio","wins","losses");
	param_00 maps\mp\gametypes\_persistance::statset("currentWinStreak",0);
}

//Function Number: 20
updatewinlossstats(param_00)
{
	if(maps\mp\_utility::privatematch())
	{
		return;
	}

	if(!maps\mp\_utility::waslastround())
	{
		return;
	}

	var_01 = level.players;
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
				var_03 maps\mp\gametypes\_persistance::statset("currentWinStreak",0);
				continue;
			}

			updatetiestats(var_03);
		}

		return;
	}

	if(isplayer(param_00))
	{
		if(level.hostforcedend && param_00 ishost())
		{
			param_00 maps\mp\gametypes\_persistance::statset("currentWinStreak",0);
			return;
		}

		updatewinstats(param_00);
		return;
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
				var_03 maps\mp\gametypes\_persistance::statset("currentWinStreak",0);
				continue;
			}

			if(param_00 == "tie")
			{
				updatetiestats(var_03);
				continue;
			}

			if(var_03.pers["team"] == param_00)
			{
				updatewinstats(var_03);
				continue;
			}

			var_03 maps\mp\gametypes\_persistance::statset("currentWinStreak",0);
		}

		return;
	}
}

//Function Number: 21
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
	wait param_00;
	maps\mp\_utility::freezecontrolswrapper(1);
}

//Function Number: 22
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

	if(!maps\mp\_utility::gettimelimit() || level.forcedend)
	{
		var_01 = maps\mp\_utility::gettimepassed() / 1000;
		var_01 = min(var_01,1200);
	}
	else
	{
		var_01 = maps\mp\_utility::gettimelimit() * 60;
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
			var_04 = maps\mp\gametypes\_rank::getscoreinfovalue("win");
			var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("loss");
			setwinningteam(var_02);
		}
		else
		{
			var_04 = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
			var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
		}

		foreach(var_07 in level.players)
		{
			if(isdefined(var_07.connectedpostgame))
			{
				continue;
			}

			if(!var_07 maps\mp\_utility::rankingenabled())
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

			var_08 = var_07 maps\mp\gametypes\_rank::getspm();
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

		return;
	}

	if(isdefined(var_07))
	{
		var_04 = maps\mp\gametypes\_rank::getscoreinfovalue("win");
		var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("loss");
	}
	else
	{
		var_04 = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
		var_05 = maps\mp\gametypes\_rank::getscoreinfovalue("tie");
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

		var_08 = var_07 maps\mp\gametypes\_rank::getspm();
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

//Function Number: 23
givematchbonus(param_00,param_01)
{
	self endon("disconnect");
	level waittill("give_match_bonus");
	maps\mp\gametypes\_rank::giverankxp(param_00,param_01);
	maps\mp\gametypes\_rank::endgameupdate();
}

//Function Number: 24
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

		setplayerteamrank(var_03,var_03.clientid,var_03.score - 5 * var_03.deaths);
	}
}

//Function Number: 25
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

	var_01 = gettimeremaining();
	setgameendtime(gettime() + int(var_01));
	if(var_01 > 0)
	{
		if(maps\mp\_utility::gethalftime() && checkhalftime(param_00))
		{
			[[ level.onhalftime ]]();
		}

		return;
	}

	[[ level.ontimelimit ]]();
}

//Function Number: 26
checkhalftime(param_00)
{
	if(!level.teambased)
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

//Function Number: 27
gettimeremaining()
{
	return maps\mp\_utility::gettimelimit() * 60 * 1000 - maps\mp\_utility::gettimepassed();
}

//Function Number: 28
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

	if(level.gametype == "conf" || level.gametype == "jugg")
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

	var_01 = estimatedtimetillscorelimit(param_00);
	if(var_01 < 2)
	{
		level notify("match_ending_soon","score");
	}
}

//Function Number: 29
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

	var_00 = estimatedtimetillscorelimit();
	if(var_00 < 2)
	{
		level notify("match_ending_soon","score");
	}
}

//Function Number: 30
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

//Function Number: 31
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

//Function Number: 32
matchstarttimerpc()
{
	thread matchstarttimer("waiting_for_teams",level.prematchperiod + level.prematchperiodend);
	waitforplayers(level.prematchperiod);
	if(level.prematchperiodend > 0)
	{
		matchstarttimer("match_starting_in",level.prematchperiodend);
	}
}

//Function Number: 33
matchstarttimer_internal(param_00,param_01)
{
	waittillframeend;
	visionsetnaked("mpIntro",0);
	level endon("match_start_timer_beginning");
	while(param_00 > 0 && !level.gameended)
	{
		param_01 thread maps\mp\gametypes\_hud::fontpulse(level);
		wait param_01.inframes * 0.05;
		param_01 setvalue(param_00);
		if(param_00 == 0)
		{
			visionsetnaked("",0);
		}

		param_00--;
		wait 1 - param_01.inframes * 0.05;
	}
}

//Function Number: 34
matchstarttimer(param_00,param_01)
{
	level notify("match_start_timer_beginning");
	var_02 = maps\mp\gametypes\_hud_util::createserverfontstring("objective",1.5);
	var_02 maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,-40);
	var_02.sort = 1001;
	var_02 settext(game["strings"]["waiting_for_teams"]);
	var_02.foreground = 0;
	var_02.hidewheninmenu = 1;
	var_02 settext(game["strings"][param_00]);
	var_03 = maps\mp\gametypes\_hud_util::createserverfontstring("hudbig",1);
	var_03 maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,0);
	var_03.sort = 1001;
	var_03.color = (1,1,0);
	var_03.foreground = 0;
	var_03.hidewheninmenu = 1;
	var_03 maps\mp\gametypes\_hud::fontpulseinit();
	var_04 = int(param_01);
	if(var_04 >= 2)
	{
		matchstarttimer_internal(var_04,var_03);
		visionsetnaked("",3);
	}
	else
	{
		visionsetnaked("mpIntro",0);
		visionsetnaked("",1);
	}

	var_03 maps\mp\gametypes\_hud_util::destroyelem();
	var_02 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 35
matchstarttimerskip()
{
	visionsetnaked("",0);
}

//Function Number: 36
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

//Function Number: 37
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

//Function Number: 38
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

//Function Number: 39
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

//Function Number: 40
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

//Function Number: 41
hostidledout()
{
	var_00 = gethostplayer();
	if(isdefined(var_00) && !var_00.hasspawned && !isdefined(var_00.selectedclass))
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
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

			if(!var_05 maps\mp\gametypes\_hud_message::isdoingsplash())
			{
				continue;
			}

			var_02 = 0;
		}

		wait 0.5;
	}

	if(!param_01)
	{
		wait param_00;
		level notify("round_end_finished");
		return;
	}

	wait param_00 / 2;
	level notify("give_match_bonus");
	wait param_00 / 2;
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

			if(!var_05 maps\mp\gametypes\_hud_message::isdoingsplash())
			{
				continue;
			}

			var_02 = 0;
		}

		wait 0.5;
	}

	level notify("round_end_finished");
}

//Function Number: 43
roundenddof(param_00)
{
	self setdepthoffield(0,128,512,4000,6,1.8);
}

//Function Number: 44
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
	makedvarserverinfo("cg_thirdPersonAngle",356);
	makedvarserverinfo("scr_gameended",0);
	if(!isdefined(game["gamestarted"]))
	{
		game["clientid"] = 0;
		var_00 = getmapcustom("allieschar");
		if(!isdefined(var_00) || var_00 == "")
		{
			if(!isdefined(game["allies"]))
			{
				var_00 = "sas_urban";
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
				var_01 = "opforce_henchmen";
			}
			else
			{
				var_01 = game["axis"];
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

		precachestatusicon("hud_status_dead");
		precachestatusicon("hud_status_connecting");
		precachestring(&"MPUI_REVIVING");
		precachestring(&"MPUI_BEING_REVIVED");
		precacherumble("damage_heavy");
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
				level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game","graceperiod");
			}
		}
		else
		{
			level.prematchperiod = maps\mp\gametypes\_tweakables::gettweakablevalue("game","playerwaittime");
			level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game","matchstarttime");
		}
	}
	else if(level.console)
	{
		if(!level.splitscreen)
		{
			level.prematchperiod = 5;
		}
	}
	else
	{
		level.prematchperiod = 5;
		level.prematchperiodend = maps\mp\gametypes\_tweakables::gettweakablevalue("game","matchstarttime");
	}

	if(!isdefined(game["status"]))
	{
		game["status"] = "normal";
	}

	makedvarserverinfo("ui_overtime",game["status"] == "overtime");
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

	thread maps\mp\gametypes\_persistance::init();
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
	thread lib_037A::init();
	thread maps\mp\_areas::init();
	thread maps\mp\killstreaks\_killstreaks::init();
	thread maps\mp\perks\_perks::init();
	thread maps\mp\_events::init();
	thread maps\mp\_defcon::init();
	thread maps\mp\_matchevents::init();
	thread maps\mp\gametypes\_damage::initfinalkillcam();
	if(level.teambased)
	{
		thread maps\mp\gametypes\_friendicons::init();
	}

	thread maps\mp\gametypes\_hud_message::init();
	if(!level.console)
	{
		thread maps\mp\gametypes\_quickmessages::init();
	}

	foreach(var_03 in game["strings"])
	{
		precachestring(var_03);
	}

	foreach(var_06 in game["icons"])
	{
		precacheshader(var_06);
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
	makedvarserverinfo("ui_scorelimit",0);
	makedvarserverinfo("ui_allow_classchange",getdvar("ui_allow_classchange"));
	makedvarserverinfo("ui_allow_teamchange",1);
	setdvar("ui_allow_teamchange",1);
	if(maps\mp\_utility::getgametypenumlives())
	{
		setdvar("g_deadChat",0);
	}
	else
	{
		setdvar("g_deadChat",1);
	}

	var_08 = getdvarint("scr_" + level.gametype + "_waverespawndelay");
	if(var_08)
	{
		level.wavedelay["allies"] = var_08;
		level.wavedelay["axis"] = var_08;
		level.lastwave["allies"] = 0;
		level.lastwave["axis"] = 0;
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
		lib_036E::func_2B93("axis");
		lib_036E::func_2B93("allies");
	}
	else
	{
		thread lib_036E::func_2BA0();
	}

	thread updateuiscorelimit();
	level notify("update_scorelimit");
	[[ level.onstartgametype ]]();
	thread startgame();
	level thread maps\mp\_utility::updatewatcheddvars();
	level thread timelimitthread();
	level thread maps\mp\gametypes\_damage::dofinalkillcam();
}

//Function Number: 45
callback_codeendgame()
{
	endparty();
	if(!level.gameended)
	{
		level thread forceend();
	}
}

//Function Number: 46
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
				wait 0.1;
				continue;
			}
		}

		wait 1;
	}
}

//Function Number: 47
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

//Function Number: 48
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
			wait 1;
		}
		else if(var_00 > 4)
		{
			var_00 = var_00 - 0.5;
			wait 0.5;
		}
		else if(var_00 > 1)
		{
			var_00 = var_00 - 0.4;
			wait 0.4;
		}
		else
		{
			var_00 = var_00 - 0.3;
			wait 0.3;
		}

		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 49
stoptickingsound()
{
	self notify("stop_ticking");
}

//Function Number: 50
timelimitclock()
{
	level endon("game_ended");
	wait 0.05;
	var_00 = spawn("script_origin",(0,0,0));
	var_00 hide();
	while(game["state"] == "playing")
	{
		if(!level.timerstopped && maps\mp\_utility::gettimelimit())
		{
			var_01 = gettimeremaining() / 1000;
			var_02 = int(var_01 + 0.5);
			if(maps\mp\_utility::gethalftime() && var_02 > maps\mp\_utility::gettimelimit() * 60 * 0.5)
			{
				var_02 = var_02 - int(maps\mp\_utility::gettimelimit() * 60 * 0.5);
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
				wait var_01 - floor(var_01);
			}
		}

		wait 1;
	}
}

//Function Number: 51
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

	var_00 = gettime();
	while(game["state"] == "playing")
	{
		if(!level.timerstopped)
		{
			game["timePassed"] = game["timePassed"] + gettime() - var_00;
		}

		var_00 = gettime();
		wait 1;
	}
}

//Function Number: 52
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

//Function Number: 53
pausetimer()
{
	level.timerstoppedforgamemode = 1;
	updatetimerpausedness();
}

//Function Number: 54
resumetimer()
{
	level.timerstoppedforgamemode = 0;
	updatetimerpausedness();
}

//Function Number: 55
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

//Function Number: 56
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

		wait 0.05;
	}
}

//Function Number: 57
getbetterteam()
{
	var_00["allies"] = 0;
	var_00["allies"] = 0;
	foreach(var_03 in level.players)
	{
		var_04 = var_03.pers["team"];
		if(isdefined(var_04) && var_04 == "allies" || var_04 == "axis")
		{
			var_00[var_04] = var_00[var_04] + var_03.kills;
			var_7B[var_04] = var_7B[var_04] + var_03.deaths;
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

	if(var_7B["allies"] < var_7B["axis"])
	{
		return "allies";
	}
	else if(var_7B["axis"] < var_7B["allies"])
	{
		return "axis";
	}

	if(randomint(2) == 0)
	{
		return "allies";
	}

	return "axis";
}

//Function Number: 58
rankedmatchupdates(param_00)
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

		updatematchbonusscores(param_00);
	}

	updatewinlossstats(param_00);
}

//Function Number: 59
displayroundend(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.connectedpostgame) || var_03.pers["team"] == "spectator")
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

//Function Number: 60
displaygameend(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.connectedpostgame) || var_03.pers["team"] == "spectator")
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

	level notify("game_win",param_00);
	roundendwait(level.postroundtime,1);
}

//Function Number: 61
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
		if(isdefined(var_02.connectedpostgame) || var_02.pers["team"] == "spectator")
		{
			continue;
		}

		var_02 thread maps\mp\gametypes\_hud_message::teamoutcomenotify(var_00,1,level.halftimesubcaption);
	}

	roundendwait(level.halftimeroundenddelay,0);
}

//Function Number: 62
endgameovertime(param_00,param_01)
{
	visionsetnaked("mpOutro",0.5);
	setdvar("scr_gameended",3);
	foreach(var_03 in level.players)
	{
		var_03 thread freezeplayerforroundend(0);
		var_03 thread roundenddof(4);
		var_03 freegameplayhudelems();
		var_03 setclientdvars("cg_everyoneHearsEveryone",1);
		var_03 setclientdvars("cg_drawSpectatorMessages",0,"g_compassShowEnemies",0);
		if(var_03.pers["team"] == "spectator")
		{
			var_03 thread maps\mp\gametypes\_playerlogic::spawnintermission();
		}
	}

	level notify("round_switch","overtime");
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03.connectedpostgame) || var_03.pers["team"] == "spectator")
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

	roundendwait(level.roundenddelay,0);
	if(isdefined(level.finalkillcam_winner))
	{
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
		foreach(var_03 in level.players)
		{
			var_03 notify("reset_outcome");
		}

		level notify("game_cleanup");
		waittillfinalkillcamdone();
	}

	game["status"] = "overtime";
	level notify("restarting");
	game["state"] = "playing";
	map_restart(1);
}

//Function Number: 63
endgamehalftime()
{
	visionsetnaked("mpOutro",0.5);
	setdvar("scr_gameended",2);
	game["switchedsides"] = !game["switchedsides"];
	foreach(var_01 in level.players)
	{
		var_01 thread freezeplayerforroundend(0);
		var_01 thread roundenddof(4);
		var_01 freegameplayhudelems();
		var_01 setclientdvars("cg_everyoneHearsEveryone",1);
		var_01 setclientdvars("cg_drawSpectatorMessages",0,"g_compassShowEnemies",0);
		if(var_01.pers["team"] == "spectator")
		{
			var_01 thread maps\mp\gametypes\_playerlogic::spawnintermission();
		}
	}

	foreach(var_01 in level.players)
	{
		var_01.pers["stats"] = var_01.stats;
	}

	level notify("round_switch","halftime");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.connectedpostgame) || var_01.pers["team"] == "spectator")
		{
			continue;
		}

		var_01 thread maps\mp\gametypes\_hud_message::teamoutcomenotify("halftime",1,level.halftimesubcaption);
	}

	roundendwait(level.roundenddelay,0);
	if(isdefined(level.finalkillcam_winner))
	{
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
		foreach(var_01 in level.players)
		{
			var_01 notify("reset_outcome");
		}

		level notify("game_cleanup");
		waittillfinalkillcamdone();
	}

	game["status"] = "halftime";
	level notify("restarting");
	game["state"] = "playing";
	map_restart(1);
}

//Function Number: 64
endgame(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(game["state"] == "postgame" || level.gameended && !isdefined(level.gtnw) || !level.gtnw)
	{
		return;
	}

	game["state"] = "postgame";
	level.gameendtime = gettime();
	level.gameended = 1;
	level.ingraceperiod = 0;
	level notify("game_ended",param_00);
	maps\mp\_utility::levelflagset("game_over");
	maps\mp\_utility::levelflagset("block_notifies");
	common_scripts\utility::waitframe();
	setgameendtime(0);
	var_03 = getmatchdata("gameLength");
	var_03 = var_03 + int(maps\mp\_utility::getsecondspassed());
	setmatchdata("gameLength",var_03);
	maps\mp\gametypes\_playerlogic::printpredictedspawnpointcorrectness();
	if(isdefined(param_00) && isstring(param_00) && param_00 == "overtime")
	{
		level.finalkillcam_winner = "none";
		endgameovertime(param_00,param_01);
		return;
	}

	if(isdefined(param_00) && isstring(param_00) && param_00 == "halftime")
	{
		level.finalkillcam_winner = "none";
		endgamehalftime();
		return;
	}

	if(isdefined(level.finalkillcam_winner))
	{
		level.finalkillcam_timegameended[level.finalkillcam_winner] = maps\mp\_utility::getsecondspassed();
	}

	game["roundsPlayed"]++;
	if(level.teambased)
	{
		if(param_00 == "axis" || param_00 == "allies")
		{
			game["roundsWon"][param_00]++;
		}

		lib_036E::func_2B93("axis");
		lib_036E::func_2B93("allies");
	}
	else if(isdefined(param_00) && isplayer(param_00))
	{
		game["roundsWon"][param_00.guid]++;
	}

	lib_036E::func_2B9C();
	rankedmatchupdates(param_00);
	foreach(var_05 in level.players)
	{
		var_05 setclientdvar("ui_opensummary",1);
		if(maps\mp\_utility::wasonlyround() || maps\mp\_utility::waslastround())
		{
			var_05 maps\mp\killstreaks\_killstreaks::clearkillstreaks();
		}
	}

	setdvar("g_deadChat",1);
	setdvar("ui_allow_teamchange",0);
	foreach(var_05 in level.players)
	{
		var_05 thread freezeplayerforroundend(1);
		var_05 thread roundenddof(4);
		var_05 freegameplayhudelems();
		var_05 setclientdvars("cg_everyoneHearsEveryone",1);
		var_05 setclientdvars("cg_drawSpectatorMessages",0,"g_compassShowEnemies",0,"cg_fovScale",1);
		if(var_05.pers["team"] == "spectator")
		{
			var_05 thread maps\mp\gametypes\_playerlogic::spawnintermission();
		}
	}

	if(!param_02)
	{
		visionsetnaked("mpOutro",0.5);
	}

	if(!maps\mp\_utility::wasonlyround() && !param_02)
	{
		setdvar("scr_gameended",2);
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
			}

			level notify("restarting");
			game["state"] = "playing";
			map_restart(1);
			return;
		}

		if(!level.forcedend)
		{
			var_03 = updateendreasontext(param_02);
		}
	}

	if(var_03 == game["strings"]["time_limit_reached"])
	{
		setdvar("scr_gameended",3);
	}
	else
	{
		switch(level.gametype)
		{
			case "conf":
			case "ctf":
			case "dom":
			case "sd":
			case "sab":
			case "koth":
				setdvar("scr_gameended",4);
				break;

			default:
				setdvar("scr_gameended",1);
				break;
		}
	}

	if(!isdefined(game["clientMatchDataDef"]))
	{
		game["clientMatchDataDef"] = "mp/clientmatchdata.def";
		setclientmatchdatadef(game["clientMatchDataDef"]);
	}

	maps\mp\gametypes\_missions::roundend(param_02);
	displaygameend(param_02,var_03);
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
		var_07 thread maps\mp\gametypes\_playerlogic::spawnintermission();
	}

	processlobbydata();
	wait 1;
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

	setmatchdata("host",level.hostname);
	sendmatchdata();
	foreach(var_07 in level.players)
	{
		var_07.pers["stats"] = var_07.stats;
	}

	if(!var_04 && !level.postgamenotifies)
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
		wait min(10,4 + level.postgamenotifies);
	}

	level notify("exitLevel_called");
	exitlevel(0);
}

//Function Number: 65
updateendreasontext(param_00)
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

	if(param_00 == "axis")
	{
		return &"SPETSNAZ_WIN";
	}

	return &"SAS_WIN";
}

//Function Number: 66
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

//Function Number: 67
getscoreperminute(param_00)
{
	var_01 = maps\mp\_utility::getwatcheddvar("scorelimit");
	var_02 = maps\mp\_utility::gettimelimit();
	var_03 = maps\mp\_utility::gettimepassed() / -5536 + 0.0001;
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

//Function Number: 68
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

//Function Number: 69
givelastonteamwarning()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::waittillrecoveredhealth(3);
	var_00 = maps\mp\_utility::getotherteam(self.pers["team"]);
	thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive",self,self.pers["team"]);
	thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive",self,var_00);
	level notify("last_alive",self);
}

//Function Number: 70
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
	}

	maps\mp\_awards::assignawards();
	maps\mp\_scoreboard::processlobbyscoreboards();
	sendclientmatchdata();
}

//Function Number: 71
trackleaderboarddeathstats(param_00,param_01)
{
	thread threadedsetweaponstatbyname(param_00,1,"deaths");
}

//Function Number: 72
trackattackerleaderboarddeathstats(param_00,param_01)
{
	if(isdefined(self) && isplayer(self))
	{
		if(param_01 != "MOD_FALLING")
		{
			if(param_01 == "MOD_MELEE" && !issubstr(param_00,"riotshield"))
			{
				return;
			}

			thread threadedsetweaponstatbyname(param_00,1,"kills");
		}

		if(param_01 == "MOD_HEAD_SHOT")
		{
			thread threadedsetweaponstatbyname(param_00,1,"headShots");
		}
	}
}

//Function Number: 73
setweaponstat(param_00,param_01,param_02)
{
	if(!param_01)
	{
		return;
	}

	var_03 = maps\mp\_utility::getweaponclass(param_00);
	if(maps\mp\_utility::iskillstreakweapon(param_00) || var_03 == "killstreak" || var_03 == "deathstreak" || var_03 == "other")
	{
		return;
	}

	if(maps\mp\_utility::isenvironmentweapon(param_00))
	{
		return;
	}

	if(var_03 == "weapon_grenade" || var_03 == "weapon_riot" || var_03 == "weapon_explosive")
	{
		var_04 = maps\mp\_utility::strip_suffix(param_00,"_mp");
		maps\mp\gametypes\_persistance::incrementweaponstat(var_04,param_02,param_01);
		maps\mp\_matchdata::logweaponstat(var_04,param_02,param_01);
		return;
	}

	if(var_03 != "deaths")
	{
		param_01 = self getcurrentweapon();
	}

	if(maps\mp\_utility::iskillstreakweapon(param_01) || var_04 == "killstreak" || var_04 == "deathstreak" || var_04 == "other")
	{
		return;
	}

	if(!isdefined(self.trackingweaponname))
	{
		self.trackingweaponname = param_01;
	}

	if(param_01 != self.trackingweaponname)
	{
		maps\mp\gametypes\_persistance::updateweaponbufferedstats();
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
			self.trackingweaponhits++;
			break;

		case "kills":
			self.trackingweaponkills++;
			break;
	}

	if(var_03 == "deaths")
	{
		var_05 = param_01;
		var_06 = strtok(param_01,"_");
		var_07 = undefined;
		if(var_06[0] == "iw5")
		{
			var_04 = var_06[0] + "_" + var_06[1];
		}
		else if(var_06[0] == "alt")
		{
			var_04 = var_06[1] + "_" + var_06[2];
		}
		else
		{
			var_04 = var_06[0];
		}

		if(!maps\mp\_utility::iscacprimaryweapon(var_07) && !maps\mp\_utility::iscacsecondaryweapon(var_07))
		{
			return;
		}

		if(var_05[0] == "alt")
		{
			var_07 = var_05[1] + "_" + var_05[2];
			foreach(var_09 in var_05)
			{
				if(var_09 == "gl" || var_09 == "gp25" || var_09 == "m320")
				{
					var_06 = "gl";
					break;
				}

				if(var_09 == "shotgun")
				{
					var_06 = "shotgun";
					break;
				}
			}
		}

		if(isdefined(var_06) && var_06 == "gl" || var_06 == "shotgun")
		{
			maps\mp\gametypes\_persistance::incrementattachmentstat(var_06,param_02,param_01);
			maps\mp\_matchdata::logattachmentstat(var_06,param_02,param_01);
			return;
		}

		maps\mp\gametypes\_persistance::incrementweaponstat(var_07,param_02,param_01);
		maps\mp\_matchdata::logweaponstat(var_07,"deaths",param_01);
		if(var_05[0] != "none")
		{
			for(var_0B = 0;var_0B < var_05.size;var_0B++)
			{
				if(var_05[var_0B] == "alt")
				{
					var_0B = var_0B + 2;
					continue;
				}

				if(var_05[var_0B] == "iw5")
				{
					var_0B = var_0B + 1;
					continue;
				}

				if(var_05[var_0B] == "mp")
				{
					continue;
				}

				if(issubstr(var_05[var_0B],"camo"))
				{
					continue;
				}

				if(issubstr(var_05[var_0B],"scope") && !issubstr(var_05[var_0B],"vz"))
				{
					continue;
				}

				if(issubstr(var_05[var_0B],"scope") && issubstr(var_05[var_0B],"vz"))
				{
					var_05[var_0B] = "vzscope";
				}

				var_05[var_0B] = maps\mp\_utility::validateattachment(var_05[var_0B]);
				if(var_0B == 0 && var_05[var_0B] != "iw5" && var_05[var_0B] != "alt")
				{
					continue;
				}

				maps\mp\gametypes\_persistance::incrementattachmentstat(var_05[var_0B],param_02,param_01);
				maps\mp\_matchdata::logattachmentstat(var_05[var_0B],param_02,param_01);
			}
		}
	}
}

//Function Number: 74
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

//Function Number: 75
threadedsetweaponstatbyname(param_00,param_01,param_02)
{
	self endon("disconnect");
	waittillframeend;
	setweaponstat(param_00,param_01,param_02);
}

//Function Number: 76
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
			var_02 = var_01 getplayerdata("round","kills");
			var_03 = var_01 getplayerdata("round","deaths");
			var_04 = var_01.pers["summary"]["xp"];
			var_05 = var_01 getplayerdata("bestKills");
			var_06 = var_01 getplayerdata("mostDeaths");
			var_07 = var_01 getplayerdata("mostXp");
			if(var_02 > var_05)
			{
				var_01 setplayerdata("bestKills",var_02);
			}

			if(var_04 > var_07)
			{
				var_01 setplayerdata("mostXp",var_04);
			}

			if(var_03 > var_06)
			{
				var_01 setplayerdata("mostDeaths",var_03);
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

//Function Number: 77
checkforbestweapon()
{
	var_00 = maps\mp\_matchdata::buildbaseweaponlist();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		var_03 = strtok(var_02,"_");
		if(var_03[0] == "iw5")
		{
			var_02 = var_03[0] + "_" + var_03[1];
		}

		if(var_03[0] == "alt")
		{
			var_02 = var_03[1] + "_" + var_03[2];
		}

		var_04 = maps\mp\_utility::getweaponclass(var_02);
		if(!maps\mp\_utility::iskillstreakweapon(var_02) && var_04 != "killstreak" && var_04 != "deathstreak" && var_04 != "other")
		{
			var_05 = self getplayerdata("bestWeapon","kills");
			var_06 = getmatchdata("players",self.clientid,"weaponStats",var_02,"kills");
			if(var_06 > var_05)
			{
				self setplayerdata("bestWeapon","kills",var_06);
				var_07 = getmatchdata("players",self.clientid,"weaponStats",var_02,"shots");
				var_08 = getmatchdata("players",self.clientid,"weaponStats",var_02,"headShots");
				var_09 = getmatchdata("players",self.clientid,"weaponStats",var_02,"hits");
				var_0A = getmatchdata("players",self.clientid,"weaponStats",var_02,"deaths");
				var_0B = getmatchdata("players",self.clientid,"weaponStats",var_02,"XP");
				self setplayerdata("bestWeapon","shots",var_07);
				self setplayerdata("bestWeapon","headShots",var_08);
				self setplayerdata("bestWeapon","hits",var_09);
				self setplayerdata("bestWeapon","deaths",var_0A);
				self setplayerdata("bestWeaponXP",var_0B);
				self setplayerdata("bestWeaponIndex",var_01);
			}
		}
	}
}