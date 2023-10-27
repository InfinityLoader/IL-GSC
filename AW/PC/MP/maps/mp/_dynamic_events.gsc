/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_dynamic_events.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 137 ms
 * Timestamp: 10/27/2023 1:48:35 AM
*******************************************************************/

//Function Number: 1
dynamicevent(param_00,param_01,param_02)
{
	if(getdvarint("r_reflectionProbeGenerate"))
	{
		return;
	}

	if(isdefined(level.dynamiceventstype))
	{
		if(level.dynamiceventstype == 1)
		{
			return;
		}

		if(level.dynamiceventstype == 2)
		{
			if(isdefined(param_02))
			{
				level [[ param_02 ]]();
			}

			return;
		}
	}

	setdvarifuninitialized("scr_dynamic_event_state","on");
	if(getdvar("scr_dynamic_event_state","on") == "off")
	{
		return;
	}
	else if(getdvar("scr_dynamic_event_state","on") == "endstate")
	{
		if(isdefined(param_02))
		{
			level [[ param_02 ]]();
		}

		return;
	}

	if(!isdefined(level.dynamicevent))
	{
		level.dynamicevent = [];
	}

	if(level.gametype == "sd" || level.gametype == "sr")
	{
		level thread handle_sd_dynamicevent(param_00,param_02);
	}
	else
	{
		level thread handle_dynamicevent(param_00,param_01,0);
	}

	level thread logdynamiceventstarttime();
}

//Function Number: 2
logdynamiceventstarttime()
{
	level endon("game_ended");
	level waittill("dynamic_event_starting");
	var_00 = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();
	setmatchdata("dynamicEventTimeDeciSecondsFromMatchStart",maps\mp\_utility::clamptoshort(var_00));
}

//Function Number: 3
handle_sd_dynamicevent(param_00,param_01)
{
	game["dynamicEvent_switchedsides"] = game["switchedsides"];
	if(level.gametype == "sd")
	{
		game["dynamicEvent_scorelimit"] = getdvarint("scr_sd_winlimit",6);
	}
	else if(level.gametype == "sr")
	{
		game["dynamicEvent_scorelimit"] = getdvarint("scr_sr_winlimit",6);
	}

	if(!isdefined(game["dynamicEvent_switchedsides"]))
	{
		game["dynamicEvent_switchedsides"] = 0;
	}

	if(!isdefined(game["dynamicEvent_teamA_RoundTally"]))
	{
		game["dynamicEvent_teamA_RoundTally"] = 0;
	}

	if(!isdefined(game["dynamicEvent_teamB_RoundTally"]))
	{
		game["dynamicEvent_teamB_RoundTally"] = 0;
	}

	if(game["dynamicEvent_switchedsides"] == 0)
	{
		game["dynamicEvent_teamA_RoundTally"]++;
		check_do_event(param_00,param_01,game["dynamicEvent_teamA_RoundTally"]);
		return;
	}

	if(game["dynamicEvent_switchedsides"] == 1)
	{
		game["dynamicEvent_teamB_RoundTally"]++;
		check_do_event(param_00,param_01,game["dynamicEvent_teamB_RoundTally"]);
	}
}

//Function Number: 4
check_do_event(param_00,param_01,param_02)
{
	var_03 = int(game["dynamicEvent_scorelimit"] / 2);
	if(var_03 == 0)
	{
		var_03 = 3;
	}

	if(param_02 == var_03)
	{
		wait(10);
		level notify("dynamic_event_starting");
		if(isdefined(param_00) && isdefined(param_01))
		{
			level [[ param_00 ]]();
			return;
		}

		return;
	}

	if(param_02 > var_03)
	{
		if(isdefined(param_00) && isdefined(param_01))
		{
			level [[ param_01 ]]();
			return;
		}
	}
}

//Function Number: 5
handle_dynamicevent(param_00,param_01,param_02)
{
	var_03 = getdynamiceventtimelimit();
	var_04 = getdynamiceventstarttime();
	var_05 = undefined;
	var_06 = maps\mp\_utility::getscorelimit();
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	while(var_03 > var_04 && !param_02 || !isdefined(var_05) || var_05 <= var_06 * level.dynamicevent["start_percent"])
	{
		if(isdefined(level.ishorde) && level.ishorde)
		{
			if(isdefined(level.dynamiceventstartnow) && level.dynamiceventstartnow)
			{
				var_03 = var_04;
			}
		}

		wait(1);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		var_03 = var_03 - 1;
		var_05 = getdynamiceventhighestscore();
	}

	level notify("dynamic_event_starting");
	if(isdefined(param_00))
	{
		level [[ param_00 ]]();
	}
}

//Function Number: 6
setdynamiceventstartpercent(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.5;
	}

	if(param_00 < 0 || param_00 > 1)
	{
	}

	level.dynamicevent["start_percent"] = param_00;
}

//Function Number: 7
getdynamiceventstarttime()
{
	if(!isdefined(level.dynamicevent["start_percent"]))
	{
		setdynamiceventstartpercent();
	}

	var_00 = getdynamiceventtimelimit();
	var_01 = var_00 - var_00 * level.dynamicevent["start_percent"];
	return var_01;
}

//Function Number: 8
getdynamiceventhighestscore()
{
	var_00 = undefined;
	if(level.teambased)
	{
		var_01 = maps\mp\gametypes\_gamescore::getwinningteam();
		if(isdefined(var_01) && var_01 == "none" && isdefined(level.teamnamelist))
		{
			var_00 = maps\mp\gametypes\_gamescore::_getteamscore(level.teamnamelist[0]);
		}
		else if(isdefined(var_01))
		{
			var_00 = maps\mp\gametypes\_gamescore::_getteamscore(var_01);
		}
	}
	else
	{
		var_02 = maps\mp\gametypes\_gamescore::gethighestscoringplayer();
		if(!isdefined(var_02) && isdefined(level.players) && level.players.size > 0)
		{
			var_00 = maps\mp\gametypes\_gamescore::_getplayerscore(level.players[0]);
		}
		else if(isdefined(var_02))
		{
			var_00 = maps\mp\gametypes\_gamescore::_getplayerscore(var_02);
		}
	}

	return var_00;
}

//Function Number: 9
getdynamiceventtimelimit()
{
	var_00 = maps\mp\_utility::gettimelimit();
	if(var_00 == 0)
	{
		var_00 = 600;
	}
	else
	{
		var_00 = var_00 * 60;
	}

	var_01 = maps\mp\_utility::gethalftime();
	if(isdefined(var_01) && var_01)
	{
		var_00 = var_00 / 2;
	}

	return var_00;
}