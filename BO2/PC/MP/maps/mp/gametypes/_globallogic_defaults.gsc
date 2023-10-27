/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_globallogic_defaults.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 58 ms
 * Timestamp: 10/27/2023 3:00:02 AM
*******************************************************************/

#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_audio;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_globallogic_utils;
#include maps/mp/gametypes/_rank;
#include maps/mp/gametypes/_spawnlogic;
#include maps/mp/killstreaks/_killstreaks;

//Function Number: 1
getwinningteamfromloser(losing_team)
{
	if(level.multiteam)
	{
		return "tie";
	}
	else if(losing_team == "axis")
	{
		return "allies";
	}

	return "axis";
}

//Function Number: 2
default_onforfeit(team)
{
	level.gameforfeited = 1;
	level notify("forfeit in progress");
	level endon("forfeit in progress");
	level endon("abort forfeit");
	forfeit_delay = 20;
	announcement(game["strings"]["opponent_forfeiting_in"],forfeit_delay,0);
	wait(10);
	announcement(game["strings"]["opponent_forfeiting_in"],10,0);
	wait(10);
	endreason = &"";
	if(level.multiteam)
	{
		setdvar("ui_text_endreason",game["strings"]["other_teams_forfeited"]);
		endreason = game["strings"]["other_teams_forfeited"];
		winner = team;
	}
	else if(!(IsDefined(team)))
	{
		setdvar("ui_text_endreason",game["strings"]["players_forfeited"]);
		endreason = game["strings"]["players_forfeited"];
		winner = level.players[0];
	}
	else if(IsDefined(level.teams[team]))
	{
		endreason = game["strings"][team + "_forfeited"];
		setdvar("ui_text_endreason",endreason);
		winner = getwinningteamfromloser(team);
	}
	else
	{
/#
				assert(IsDefined(team),"Forfeited team is not defined");
#/
/#
				assert(0,"Forfeited team " + team + " is not allies or axis");
#/
		winner = "tie";
	}

	level.forcedend = 1;
	if(isplayer(winner))
	{
		logstring("forfeit, win: " + winner getxuid() + "(" + winner.name + ")");
	}
	else
	{
		maps/mp/gametypes/_globallogic_utils::logteamwinstring("forfeit",winner);
	}

	thread maps/mp/gametypes/_globallogic::endgame(winner,endreason);
}

//Function Number: 3
default_ondeadevent(team)
{
	if(IsDefined(level.teams[team]))
	{
		eliminatedstring = game["strings"][team + "_eliminated"];
		iprintln(eliminatedstring);
		makedvarserverinfo("ui_text_endreason",eliminatedstring);
		setdvar("ui_text_endreason",eliminatedstring);
		winner = getwinningteamfromloser(team);
		maps/mp/gametypes/_globallogic_utils::logteamwinstring("team eliminated",winner);
		thread maps/mp/gametypes/_globallogic::endgame(winner,eliminatedstring);
	}
	else
	{
		makedvarserverinfo("ui_text_endreason",game["strings"]["tie"]);
		setdvar("ui_text_endreason",game["strings"]["tie"]);
		maps/mp/gametypes/_globallogic_utils::logteamwinstring("tie");
		if(level.teambased)
		{
			thread maps/mp/gametypes/_globallogic::endgame("tie",game["strings"]["tie"]);
		}
		else
		{
			thread maps/mp/gametypes/_globallogic::endgame(undefined,game["strings"]["tie"]);
		}
	}
}

//Function Number: 4
default_onlastteamaliveevent(team)
{
	if(IsDefined(level.teams[team]))
	{
		eliminatedstring = game["strings"]["enemies_eliminated"];
		iprintln(eliminatedstring);
		makedvarserverinfo("ui_text_endreason",eliminatedstring);
		setdvar("ui_text_endreason",eliminatedstring);
		winner = maps/mp/gametypes/_globallogic::determineteamwinnerbygamestat("teamScores");
		maps/mp/gametypes/_globallogic_utils::logteamwinstring("team eliminated",winner);
		thread maps/mp/gametypes/_globallogic::endgame(winner,eliminatedstring);
	}
	else
	{
		makedvarserverinfo("ui_text_endreason",game["strings"]["tie"]);
		setdvar("ui_text_endreason",game["strings"]["tie"]);
		maps/mp/gametypes/_globallogic_utils::logteamwinstring("tie");
		if(level.teambased)
		{
			thread maps/mp/gametypes/_globallogic::endgame("tie",game["strings"]["tie"]);
		}
		else
		{
			thread maps/mp/gametypes/_globallogic::endgame(undefined,game["strings"]["tie"]);
		}
	}
}

//Function Number: 5
default_onalivecountchange(team)
{
}

//Function Number: 6
default_onroundendgame(winner)
{
	return winner;
}

//Function Number: 7
default_ononeleftevent(team)
{
	if(!(level.teambased))
	{
		winner = maps/mp/gametypes/_globallogic_score::gethighestscoringplayer();
		if(IsDefined(winner))
		{
			logstring("last one alive, win: " + winner.name);
		}
		else
		{
			logstring("last one alive, win: unknown");
		}

		thread maps/mp/gametypes/_globallogic::endgame(winner,&"MP_ENEMIES_ELIMINATED");
	}
	else
	{
		for(index = 0;index < level.players.size;index++)
		{
			player = level.players[index];
			if(!(isalive(player)))
			{
			}
			else if(!IsDefined(player.pers["team"]) || player.pers["team"] != team)
			{
			}
			else
			{
				player maps/mp/gametypes/_globallogic_audio::leaderdialogonplayer("sudden_death");
			}
		}
	}
}

//Function Number: 8
default_ontimelimit()
{
	winner = undefined;
	if(level.teambased)
	{
		winner = maps/mp/gametypes/_globallogic::determineteamwinnerbygamestat("teamScores");
		maps/mp/gametypes/_globallogic_utils::logteamwinstring("time limit",winner);
	}
	else
	{
		winner = maps/mp/gametypes/_globallogic_score::gethighestscoringplayer();
		if(IsDefined(winner))
		{
			logstring("time limit, win: " + winner.name);
		}
		else
		{
			logstring("time limit, tie");
		}
	}

	makedvarserverinfo("ui_text_endreason",game["strings"]["time_limit_reached"]);
	setdvar("ui_text_endreason",game["strings"]["time_limit_reached"]);
	thread maps/mp/gametypes/_globallogic::endgame(winner,game["strings"]["time_limit_reached"]);
}

//Function Number: 9
default_onscorelimit()
{
	if(!(level.endgameonscorelimit))
	{
		return 0;
	}

	winner = undefined;
	if(level.teambased)
	{
		winner = maps/mp/gametypes/_globallogic::determineteamwinnerbygamestat("teamScores");
		maps/mp/gametypes/_globallogic_utils::logteamwinstring("scorelimit",winner);
	}
	else
	{
		winner = maps/mp/gametypes/_globallogic_score::gethighestscoringplayer();
		if(IsDefined(winner))
		{
			logstring("scorelimit, win: " + winner.name);
		}
		else
		{
			logstring("scorelimit, tie");
		}
	}

	makedvarserverinfo("ui_text_endreason",game["strings"]["score_limit_reached"]);
	setdvar("ui_text_endreason",game["strings"]["score_limit_reached"]);
	thread maps/mp/gametypes/_globallogic::endgame(winner,game["strings"]["score_limit_reached"]);
	return 1;
}

//Function Number: 10
default_onspawnspectator(origin,angles)
{
	if(IsDefined(origin) && IsDefined(angles))
	{
		self spawn(origin,angles);
		return;
	}

	spawnpointname = "mp_global_intermission";
	spawnpoints = getentarray(spawnpointname,"classname");
/#
	assert(spawnpoints.size,"There are no mp_global_intermission spawn points in the map.  There must be at least one.");
#/
	spawnpoint = maps/mp/gametypes/_spawnlogic::getspawnpoint_random(spawnpoints);
	self spawn(spawnpoint.origin,spawnpoint.angles);
}

//Function Number: 11
default_onspawnintermission()
{
	spawnpointname = "mp_global_intermission";
	spawnpoints = getentarray(spawnpointname,"classname");
	spawnpoint = spawnpoints[0];
	if(IsDefined(spawnpoint))
	{
		self spawn(spawnpoint.origin,spawnpoint.angles);
	}
	else
	{
/#
		maps/mp/_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
#/
	}
}

//Function Number: 12
default_gettimelimit()
{
	return clamp(getgametypesetting("timeLimit"),level.timelimitmin,level.timelimitmax);
}

//Function Number: 13
default_getteamkillpenalty(einflictor,attacker,smeansofdeath,sweapon)
{
	teamkill_penalty = 1;
	score = maps/mp/gametypes/_globallogic_score::_getplayerscore(attacker);
	if(score == 0)
	{
		teamkill_penalty = 2;
	}

	if(maps/mp/killstreaks/_killstreaks::iskillstreakweapon(sweapon))
	{
		teamkill_penalty = teamkill_penalty * maps/mp/killstreaks/_killstreaks::getkillstreakteamkillpenaltyscale(sweapon);
	}

	return teamkill_penalty;
}

//Function Number: 14
default_getteamkillscore(einflictor,attacker,smeansofdeath,sweapon)
{
	return maps/mp/gametypes/_rank::getscoreinfovalue("team_kill");
}