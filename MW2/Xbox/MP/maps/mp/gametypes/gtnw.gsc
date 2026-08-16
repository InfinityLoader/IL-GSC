/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\gtnw.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	maps\mp\_utility::registertimelimitdvar(level.gametype, 3, 0, 1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype, 101, 0, 10000);
	maps\mp\_utility::registerroundlimitdvar(level.gametype, 1, 0, 30);
	maps\mp\_utility::registerwinlimitdvar(level.gametype, 1, 0, 10);
	maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 30);
	maps\mp\_utility::registernumlivesdvar(level.gametype, 0, 0, 10);
	maps\mp\_utility::registerhalftimedvar(level.gametype, 0, 0, 1);
	level.teambased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.ondeadevent = ::ondeadevent;
	level.initgametypeawards = ::initgametypeawards;
	level.ontimelimit = ::ontimelimit;
	level.onnormaldeath = ::onnormaldeath;
	level.gtnw = 1;
	game["dialog"]["gametype"] = "gtw";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}
	else if(getdvarint("camera_thirdPerson"))
	{
		game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
	}
	else if(getdvarint("scr_diehard"))
	{
		game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
	}
	else if(getdvarint("scr_" + level.gametype + "_promode"))
	{
		game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
	}

	game["dialog"]["offense_obj"] = "obj_destroy";
	game["dialog"]["defense_obj"] = "obj_defend";
	level thread onplayerconnect();
}

gtnw_endgame(winningteam, param_573)
{
	thread maps\mp\gametypes\_gamelogic::endgame(winningteam, param_573);
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		usebar = player maps\mp\gametypes\_hud_util::createprimaryprogressbar();
		usebartext = player maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
		usebartext settext(&"MP_CAPTURING_NUKE");
		usebar.usetime = 100;
		player.usebar = usebar;
		player.usebar maps\mp\gametypes\_hud_util::hideelem();
		player.usebartext = usebartext;
		player.usebartext maps\mp\gametypes\_hud_util::hideelem();
	}
}

onstartgametype()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(!isdefined(game["original_defenders"]))
	{
		game["original_defenders"] = game["defenders"];
	}

	if(game["switchedsides"])
	{
		oldattackers = game["attackers"];
		olddefenders = game["defenders"];
		game["attackers"] = olddefenders;
		game["defenders"] = oldattackers;
	}

	setclientnamemode("auto_change");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_GTNW");
		maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_GTNW");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_GTNW_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_GTNW_SCORE");
	}

	maps\mp\_utility::setobjectivetext(game["attackers"], &"OBJECTIVES_GTNW");
	maps\mp\_utility::setobjectivetext(game["defenders"], &"OBJECTIVES_GTNW");
	maps\mp\_utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_GTNW_HINT");
	maps\mp\_utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_GTNW_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_ctf_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_ctf_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_ctf_spawn_allies");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_ctf_spawn_axis");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
	setmapcenter(level.mapcenter);
	thread maps\mp\gametypes\_dev::init();
	maps\mp\gametypes\_rank::registerscoreinfo("kill", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot", 100);
	maps\mp\gametypes\_rank::registerscoreinfo("assist", 20);
	maps\mp\gametypes\_rank::registerscoreinfo("capture", 500);
	allowed[0] = "airdrop_pallet";
	allowed[1] = "gtnw";
	allowed[2] = "gtnw_zone";
	maps\mp\gametypes\_gameobjects::main(allowed);
	thread setupnukesite();
}

onprecachegametype()
{
	precacheshader("waypoint_defend");
	precacheshader("waypoint_target");
	precacheshader("waypoint_capture");
	precacheshader("compass_waypoint_target");
	precacheshader("compass_waypoint_defend");
	precacheshader("compass_waypoint_capture");
	precachestring(&"MP_CAPTURING_NUKE");
}

setupnukesite()
{
	level.laststatus["allies"] = 0;
	level.laststatus["axis"] = 0;
	nukezone = getent("gtnw_zone", "targetname");
	visuals = [];
	nukesite = maps\mp\gametypes\_gameobjects::createuseobject("neutral", nukezone, visuals, (0,0,100));
	nukesite maps\mp\gametypes\_gameobjects::set2dicon("friendly", "compass_waypoint_defend");
	nukesite maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend");
	nukesite maps\mp\gametypes\_gameobjects::set2dicon("enemy", "compass_waypoint_captureneutral");
	nukesite maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_captureneutral");
	nukesite maps\mp\gametypes\_gameobjects::allowuse("enemy");
	nukesite.nousebar = 1;
	nukesite maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	nukesite.onbeginuse = ::onbeginuse;
	nukesite.onenduse = ::onenduse;
	level.nukesite = nukesite;
	nukesite thread scorecounter();
}

getspawnpoint()
{
	if(self.team == "axis")
	{
		spawnteam = game["attackers"];
	}
	else
	{
		spawnteam = game["defenders"];
	}

	if(level.ingraceperiod)
	{
		spawnpoints = getentarray("mp_ctf_spawn_" + spawnteam + "_start", "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(spawnpoints);
	}
	else
	{
		spawnpoints = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(spawnteam);
		spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(spawnpoints);
	}

	return spawnpoint;
}

spawnfxdelay(fxid, pos, forward, right, delay)
{
	wait delay;
	effect = spawnfx(fxid, pos, forward, right);
	triggerfx(effect);
}

ondeadevent(team)
{
	if((isdefined(level.nukeincoming) && level.nukeincoming) || isdefined(level.nukedetonated) && level.nukedetonated)
	{
		return;
	}

	if(team == game["attackers"])
	{
		maps\mp\gametypes\_gamescore::giveteamscoreforobjective(team, 1);
		level thread gtnw_endgame(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(team == game["defenders"])
	{
		maps\mp\gametypes\_gamescore::giveteamscoreforobjective(team, 1);
		level thread gtnw_endgame(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
		return;
	}
}

initgametypeawards()
{
}

ontimelimit()
{
	if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
	{
		level thread overtimethread();
		return;
	}

	if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
	{
		thread maps\mp\gametypes\_gamelogic::endgame("axis", game["strings"]["time_limit_reached"]);
		return;
	}

	if(game["teamScores"]["axis"] < game["teamScores"]["allies"])
	{
		thread maps\mp\gametypes\_gamelogic::endgame("allies", game["strings"]["time_limit_reached"]);
		return;
	}
}

overtimethread(time)
{
	level endon("game_ended");
	level.inovertime = 1;
	level thread disablespawning(5);
	level.endgametime = 120;
	time = level.endgametime;
	foreach(player in level.players)
	{
		player thread maps\mp\gametypes\_hud_message::splashnotify("gtnw_overtime");
	}

	maps\mp\gametypes\_gamelogic::pausetimer();
	level.timelimitoverride = 1;
	setgameendtime(int(gettime() + level.endgametime * 1000));
	maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(time);
	if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
	{
		thread maps\mp\gametypes\_gamelogic::endgame("axis", game["strings"]["time_limit_reached"]);
		return;
	}

	if(game["teamScores"]["axis"] < game["teamScores"]["allies"])
	{
		thread maps\mp\gametypes\_gamelogic::endgame("allies", game["strings"]["time_limit_reached"]);
		return;
	}

	thread maps\mp\gametypes\_gamelogic::endgame("tie", game["strings"]["time_limit_reached"]);
}

disablespawning(waittime)
{
	level endon("game_ended");
	wait 5;
	level.disablespawning = 1;
}

onbeginuse(player)
{
	player.usebar maps\mp\gametypes\_hud_util::showelem();
	player.usebartext maps\mp\gametypes\_hud_util::showelem();
}

onenduse(team, player, success)
{
	player.usebar maps\mp\gametypes\_hud_util::hideelem();
	player.usebartext maps\mp\gametypes\_hud_util::hideelem();
}

scorecounter()
{
	level endon("game_ended");
	self endon("stop_counting");
	for(;;)
	{
		if(!self.touchlist["axis"].size && !self.touchlist["allies"].size)
		{
			setdvar("ui_danger_team", "none");
			maps\mp\gametypes\_gameobjects::set2dicon("enemy", "compass_waypoint_captureneutral");
			maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_captureneutral");
			maps\mp\gametypes\_gameobjects::setownerteam("none");
			updatehudelems();
			wait 1;
			continue;
		}

		maps\mp\gametypes\_gameobjects::set2dicon("friendly", "compass_waypoint_defend");
		maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend");
		maps\mp\gametypes\_gameobjects::set2dicon("enemy", "compass_waypoint_capture");
		maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_capture");
		if(self.touchlist["axis"].size > self.touchlist["allies"].size)
		{
			if(maps\mp\gametypes\_gamescore::_getteamscore("axis") < 100)
			{
				maps\mp\gametypes\_gamescore::giveteamscoreforobjective("axis", 1);
			}

			thread setusebarscore("axis");
			setdvar("ui_danger_team", "allies");
			maps\mp\gametypes\_gameobjects::setownerteam("axis");
			if(maps\mp\gametypes\_gamescore::_getteamscore("axis") >= 100)
			{
				maps\mp\gametypes\_gameobjects::allowuse("none");
				activatenuke("axis");
				self notify("stop_counting");
			}
		}
		else if(self.touchlist["axis"].size < self.touchlist["allies"].size)
		{
			if(maps\mp\gametypes\_gamescore::_getteamscore("allies") < 100)
			{
				maps\mp\gametypes\_gamescore::giveteamscoreforobjective("allies", 1);
			}

			thread setusebarscore("allies");
			setdvar("ui_danger_team", "axis");
			maps\mp\gametypes\_gameobjects::setownerteam("allies");
			if(maps\mp\gametypes\_gamescore::_getteamscore("allies") >= 100)
			{
				maps\mp\gametypes\_gameobjects::allowuse("none");
				activatenuke("allies");
				self notify("stop_counting");
			}
		}
		else
		{
			maps\mp\gametypes\_gameobjects::set2dicon("enemy", "compass_waypoint_captureneutral");
			maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_captureneutral");
			maps\mp\gametypes\_gameobjects::setownerteam("none");
			setdvar("ui_danger_team", "contested");
		}

		updatehudelems();
		wait 1;
	}
}

activatenuke(team)
{
	giveflagcapturexp(self.touchlist[team]);
	maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	maps\mp\gametypes\_gameobjects::allowuse("none");
	besttime = 99999999;
	nukeowner = undefined;
	foreach(player in level.players)
	{
		if(!isdefined(player))
		{
			continue;
		}

		player.usebar maps\mp\gametypes\_hud_util::hideelem();
		player.usebartext maps\mp\gametypes\_hud_util::hideelem();
		if(player.team != team)
		{
			continue;
		}

		if(!isdefined(self.touchlist[team][player.guid]))
		{
			continue;
		}

		timestarted = self.touchlist[team][player.guid].starttime;
		if(timestarted < besttime)
		{
			nukeowner = player;
			besttime = timestarted;
		}
	}

	nukeowner maps\mp\killstreaks\_nuke::tryusenuke(1);
}

giveflagcapturexp(touchlist)
{
	level endon("game_ended");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	players = getarraykeys(touchlist);
	for(index = 0;index < players.size;index++)
	{
		player = touchlist[players[index]].player;
		player thread maps\mp\gametypes\_hud_message::splashnotify("captured_nuke", maps\mp\gametypes\_rank::getscoreinfovalue("capture"));
		player thread [[ level.onxpevent ]]("capture");
		maps\mp\gametypes\_gamescore::giveplayerscore("capture", player);
	}
}

setusebarscore(team)
{
	teamscore = getteamscore(team);
	foreach(player in level.players)
	{
		if(!isdefined(player))
		{
			continue;
		}

		if(player.team != team)
		{
			continue;
		}

		if(!isdefined(self.touchlist[team][player.guid]))
		{
			continue;
		}

		player.usebar maps\mp\gametypes\_hud_util::updatebar(teamscore / 100, 0);
	}
}

updatehudelems()
{
	foreach(player in level.players)
	{
		if(!isdefined(player))
		{
			continue;
		}

		if(!isdefined(self.touchlist["axis"][player.guid]) && !isdefined(self.touchlist["allies"][player.guid]))
		{
			player.usebar maps\mp\gametypes\_hud_util::hideelem();
			player.usebartext maps\mp\gametypes\_hud_util::hideelem();
		}

		if(isdefined(self.touchlist["axis"][player.guid]) || isdefined(self.touchlist["allies"][player.guid]))
		{
			player.usebar maps\mp\gametypes\_hud_util::showelem();
			player.usebartext maps\mp\gametypes\_hud_util::showelem();
		}
	}
}

onnormaldeath(victim, attacker, lifeid)
{
	if(!isdefined(level.inovertime) || !level.inovertime)
	{
		return;
	}

	team = victim.team;
	if(game["state"] == "postgame")
	{
		attacker.finalkill = 1;
		return;
	}
}