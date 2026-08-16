/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dom.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	maps\mp\_utility::registertimelimitdvar(level.gametype, 30, 0, 1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype, 300, 0, 1000);
	maps\mp\_utility::registerroundlimitdvar(level.gametype, 1, 0, 10);
	maps\mp\_utility::registerwinlimitdvar(level.gametype, 1, 0, 10);
	maps\mp\_utility::registernumlivesdvar(level.gametype, 0, 0, 10);
	maps\mp\_utility::registerhalftimedvar(level.gametype, 0, 0, 1);
	level.teambased = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.onprecachegametype = ::onprecachegametype;
	level.initgametypeawards = ::initgametypeawards;
	level.onspawnplayer = ::onspawnplayer;
	game["dialog"]["gametype"] = "domination";
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

	game["dialog"]["offense_obj"] = "capture_objs";
	game["dialog"]["defense_obj"] = "capture_objs";
}

onprecachegametype()
{
	precacheshader("waypoint_captureneutral");
	precacheshader("waypoint_capture");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_captureneutral_a");
	precacheshader("waypoint_capture_a");
	precacheshader("waypoint_defend_a");
	precacheshader("waypoint_captureneutral_b");
	precacheshader("waypoint_capture_b");
	precacheshader("waypoint_defend_b");
	precacheshader("waypoint_captureneutral_c");
	precacheshader("waypoint_capture_c");
	precacheshader("waypoint_defend_c");
	precacheshader("waypoint_captureneutral");
	precacheshader("waypoint_capture");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_captureneutral_a");
	precacheshader("waypoint_capture_a");
	precacheshader("waypoint_defend_a");
	precacheshader("waypoint_captureneutral_b");
	precacheshader("waypoint_capture_b");
	precacheshader("waypoint_defend_b");
	precacheshader("waypoint_captureneutral_c");
	precacheshader("waypoint_capture_c");
	precacheshader("waypoint_defend_c");
}

onstartgametype()
{
	maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_DOM");
	maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_DOM");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM");
		maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DOM_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DOM_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_DOM_HINT");
	maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_DOM_HINT");
	setclientnamemode("auto_change");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_dom_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_dom_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_dom_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_dom_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
	setmapcenter(level.mapcenter);
	level.spawn_all = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn");
	level.spawn_axis_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
	level.spawn_allies_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
	level.startpos["allies"] = level.spawn_allies_start[0].origin;
	level.startpos["axis"] = level.spawn_axis_start[0].origin;
	level.flagbasefxid["allies"] = loadfx(maps\mp\gametypes\_teams::getteamflagfx("allies"));
	level.flagbasefxid["axis"] = loadfx(maps\mp\gametypes\_teams::getteamflagfx("axis"));
	allowed[0] = "dom";
	maps\mp\gametypes\_gameobjects::main(allowed);
	maps\mp\gametypes\_rank::registerscoreinfo("kill", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist", 10);
	maps\mp\gametypes\_rank::registerscoreinfo("capture", 150);
	maps\mp\gametypes\_rank::registerscoreinfo("defend", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("defend_assist", 10);
	maps\mp\gametypes\_rank::registerscoreinfo("assault", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("assault_assist", 10);
	thread domflags();
	thread updatedomscores();
}

getspawnpoint()
{
	spawnpoint = undefined;
	if(!level.usestartspawns)
	{
		flagsowned = 0;
		enemyflagsowned = 0;
		myteam = self.pers["team"];
		enemyteam = maps\mp\_utility::getotherteam(myteam);
		for(i = 0;i < level.flags.size;i++)
		{
			team = level.flags[i] getflagteam();
			if(team == myteam)
			{
				flagsowned++;
				continue;
			}

			if(team == enemyteam)
			{
				enemyflagsowned++;
			}
		}

		if(flagsowned == level.flags.size)
		{
			enemybestspawnflag = level.bestspawnflag[maps\mp\_utility::getotherteam(self.pers["team"])];
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_all, getspawnsboundingflag(enemybestspawnflag));
		}
		else if(flagsowned > 0)
		{
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_all, getboundaryflagspawns(myteam));
		}
		else
		{
			bestflag = undefined;
			if(enemyflagsowned > 0 && enemyflagsowned < level.flags.size)
			{
				bestflag = getunownedflagneareststart(myteam);
			}

			if(!isdefined(bestflag))
			{
				bestflag = level.bestspawnflag[self.pers["team"]];
			}

			level.bestspawnflag[self.pers["team"]] = bestflag;
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_all, bestflag.nearbyspawns);
		}
	}

	if(!isdefined(spawnpoint))
	{
		if(self.pers["team"] == "axis")
		{
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_axis_start);
		}
		else
		{
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_allies_start);
		}
	}

	return spawnpoint;
}

domflags()
{
	level.laststatus["allies"] = 0;
	level.laststatus["axis"] = 0;
	game["flagmodels"] = [];
	game["flagmodels"]["neutral"] = "prop_flag_neutral";
	game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::getteamflagmodel("allies");
	game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::getteamflagmodel("axis");
	precachemodel(game["flagmodels"]["neutral"]);
	precachemodel(game["flagmodels"]["allies"]);
	precachemodel(game["flagmodels"]["axis"]);
	precachestring(&"MP_SECURING_POSITION");
	primaryflags = getentarray("flag_primary", "targetname");
	secondaryflags = getentarray("flag_secondary", "targetname");
	if(primaryflags.size + secondaryflags.size < 2)
	{
		maps\mp\gametypes\_callbacksetup::abortlevel();
		return;
	}

	level.flags = [];
	for(index = 0;index < primaryflags.size;index++)
	{
		level.flags[level.flags.size] = primaryflags[index];
	}

	for(index = 0;index < secondaryflags.size;index++)
	{
		level.flags[level.flags.size] = secondaryflags[index];
	}

	level.domflags = [];
	for(index = 0;index < level.flags.size;index++)
	{
		trigger = level.flags[index];
		if(isdefined(trigger.target))
		{
			visuals[0] = getent(trigger.target, "targetname");
		}
		else
		{
			visuals[0] = spawn("script_model", trigger.origin);
			visuals[0].angles = trigger.angles;
		}

		visuals[0] setmodel(game["flagmodels"]["neutral"]);
		domflag = maps\mp\gametypes\_gameobjects::createuseobject("neutral", trigger, visuals, (0,0,100));
		domflag maps\mp\gametypes\_gameobjects::allowuse("enemy");
		domflag maps\mp\gametypes\_gameobjects::setusetime(10);
		domflag maps\mp\gametypes\_gameobjects::setusetext(&"MP_SECURING_POSITION");
		label = domflag maps\mp\gametypes\_gameobjects::getlabel();
		domflag.label = label;
		domflag maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defend" + label);
		domflag maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend" + label);
		domflag maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_captureneutral" + label);
		domflag maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_captureneutral" + label);
		domflag maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		domflag.onuse = ::onuse;
		domflag.onbeginuse = ::onbeginuse;
		domflag.onuseupdate = ::onuseupdate;
		domflag.onenduse = ::onenduse;
		tracestart = visuals[0].origin + (0,0,32);
		traceend = visuals[0].origin + (0,0,-32);
		trace = bullettrace(tracestart, traceend, 0, undefined);
		upangles = vectortoangles(trace["normal"]);
		domflag.baseeffectforward = anglestoforward(upangles);
		domflag.baseeffectright = anglestoright(upangles);
		domflag.baseeffectpos = trace["position"];
		level.flags[index].useobj = domflag;
		level.flags[index].adjflags = [];
		level.flags[index].nearbyspawns = [];
		domflag.levelflag = level.flags[index];
		level.domflags[level.domflags.size] = domflag;
	}

	level.bestspawnflag = [];
	level.bestspawnflag["allies"] = getunownedflagneareststart("allies", undefined);
	level.bestspawnflag["axis"] = getunownedflagneareststart("axis", level.bestspawnflag["allies"]);
	flagsetup();
}

getunownedflagneareststart(team, excludeflag)
{
	best = undefined;
	bestdistsq = undefined;
	for(i = 0;i < level.flags.size;i++)
	{
		flag = level.flags[i];
		if(flag getflagteam() != "neutral")
		{
			continue;
		}

		distsq = distancesquared(flag.origin, level.startpos[team]);
		if((!isdefined(excludeflag) || flag != excludeflag) && !isdefined(best) || distsq < bestdistsq)
		{
			bestdistsq = distsq;
			best = flag;
		}
	}

	return best;
}

onbeginuse(player)
{
	ownerteam = maps\mp\gametypes\_gameobjects::getownerteam();
	self.didstatusnotify = 0;
	if(ownerteam == "neutral")
	{
		statusdialog("securing" + self.label, player.pers["team"]);
		self.objpoints[player.pers["team"]] thread maps\mp\gametypes\_objpoints::startflashing();
		return;
	}

	if(ownerteam == "allies")
	{
		otherteam = "axis";
	}
	else
	{
		otherteam = "allies";
	}

	self.objpoints["allies"] thread maps\mp\gametypes\_objpoints::startflashing();
	self.objpoints["axis"] thread maps\mp\gametypes\_objpoints::startflashing();
}

onuseupdate(team, progress, change)
{
	if(progress > 0.05 && change && !self.didstatusnotify)
	{
		ownerteam = maps\mp\gametypes\_gameobjects::getownerteam();
		if(ownerteam == "neutral")
		{
			statusdialog("securing" + self.label, team);
		}
		else
		{
			statusdialog("losing" + self.label, ownerteam);
			statusdialog("securing" + self.label, team);
		}

		self.didstatusnotify = 1;
		return;
	}
}

statusdialog(dialog, team, forcedialog)
{
	time = gettime();
	if(gettime() < level.laststatus[team] + 5000 && !isdefined(forcedialog) || !forcedialog)
	{
		return;
	}

	thread delayedleaderdialog(dialog, team);
	level.laststatus[team] = gettime();
}

onenduse(team, player, success)
{
	self.objpoints["allies"] thread maps\mp\gametypes\_objpoints::stopflashing();
	self.objpoints["axis"] thread maps\mp\gametypes\_objpoints::stopflashing();
}

resetflagbaseeffect()
{
	if(isdefined(self.baseeffect))
	{
		self.baseeffect delete();
	}

	team = maps\mp\gametypes\_gameobjects::getownerteam();
	if(team != "axis" && team != "allies")
	{
		return;
	}

	fxid = level.flagbasefxid[team];
	self.baseeffect = spawnfx(fxid, self.baseeffectpos, self.baseeffectforward, self.baseeffectright);
	triggerfx(self.baseeffect);
}

onuse(player)
{
	team = player.pers["team"];
	oldteam = maps\mp\gametypes\_gameobjects::getownerteam();
	label = maps\mp\gametypes\_gameobjects::getlabel();
	self.capturetime = gettime();
	maps\mp\gametypes\_gameobjects::setownerteam(team);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_capture" + label);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_capture" + label);
	self.visuals[0] setmodel(game["flagmodels"][team]);
	resetflagbaseeffect();
	level.usestartspawns = 0;
	if(oldteam == "neutral")
	{
		otherteam = maps\mp\_utility::getotherteam(team);
		thread maps\mp\_utility::printandsoundoneveryone(team, otherteam, undefined, undefined, "mp_war_objective_taken", undefined, player);
		statusdialog("secured" + self.label, team, 1);
		statusdialog("enemy_has" + self.label, otherteam, 1);
	}
	else
	{
		thread maps\mp\_utility::printandsoundoneveryone(team, oldteam, undefined, undefined, "mp_war_objective_taken", "mp_war_objective_lost", player);
		if(getteamflagcount(team) == level.flags.size)
		{
			statusdialog("secure_all", team);
			statusdialog("lost_all", oldteam);
		}
		else
		{
			statusdialog("secured" + self.label, team, 1);
			statusdialog("lost" + self.label, oldteam, 1);
		}

		level.bestspawnflag[oldteam] = self.levelflag;
	}

	player notify("objective", "captured");
	thread giveflagcapturexp(self.touchlist[team]);
}

giveflagcapturexp(touchlist)
{
	level endon("game_ended");
	players = getarraykeys(touchlist);
	for(index = 0;index < players.size;index++)
	{
		player = touchlist[players[index]].player;
		player thread maps\mp\gametypes\_hud_message::splashnotify("capture", maps\mp\gametypes\_rank::getscoreinfovalue("capture"));
		player thread updatecpm();
		player thread maps\mp\gametypes\_rank::giverankxp("capture", maps\mp\gametypes\_rank::getscoreinfovalue("capture") * player getcapxpscale());
		maps\mp\gametypes\_gamescore::giveplayerscore("capture", player);
		player maps\mp\_utility::incplayerstat("pointscaptured", 1);
	}

	player = maps\mp\gametypes\_gameobjects::getearliestclaimplayer();
	level thread maps\mp\_utility::teamplayercardsplash("callout_securedposition" + self.label, player);
	player thread maps\mp\_matchdata::loggameevent("capture", player.origin);
}

delayedleaderdialog(sound, team)
{
	level endon("game_ended");
	wait 0.1;
	maps\mp\_utility::waittillslowprocessallowed();
	maps\mp\_utility::leaderdialog(sound, team);
}

delayedleaderdialogbothteams(sound1, team1, sound2, team2)
{
	level endon("game_ended");
	wait 0.1;
	maps\mp\_utility::waittillslowprocessallowed();
	maps\mp\_utility::leaderdialogbothteams(sound1, team1, sound2, team2);
}

updatedomscores()
{
	level endon("game_ended");
	while(!level.gameended)
	{
		domflags = getowneddomflags();
		if(domflags.size)
		{
			for(i = 1;i < domflags.size;i++)
			{
				domflag = domflags[i];
				flagscore = gettime() - domflag.capturetime;
				for(j = i - 1;j >= 0 && flagscore > gettime() - domflags[j].capturetime;j--)
				{
					domflags[j + 1] = domflags[j];
				}

				domflags[j + 1] = domflag;
			}

			foreach(domflag in domflags)
			{
				team = domflag maps\mp\gametypes\_gameobjects::getownerteam();
				maps\mp\gametypes\_gamescore::giveteamscoreforobjective(team, 1);
			}
		}

		if(((maps\mp\_utility::gettimepassed() / 1000 > 120 && domflags.size < 2) || maps\mp\_utility::gettimepassed() / 1000 > 300 && domflags.size < 3) && maps\mp\_utility::matchmakinggame())
		{
			thread maps\mp\gametypes\_gamelogic::endgame("none", game["strings"]["time_limit_reached"]);
			return;
		}

		wait 5;
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration, killid)
{
	if(!isplayer(attacker) || !self.touchtriggers.size && !attacker.touchtriggers.size || attacker.pers["team"] == self.pers["team"])
	{
		return;
	}

	awardedassault = 0;
	awardeddefend = 0;
	foreach(trigger in self.touchtriggers)
	{
		if(!isdefined(trigger.useobj))
		{
			continue;
		}

		ownerteam = trigger.useobj.ownerteam;
		team = self.pers["team"];
		if(ownerteam == "neutral")
		{
			continue;
		}

		if(team == ownerteam)
		{
			awardedassault = 1;
			attacker thread maps\mp\gametypes\_hud_message::splashnotify("assault", maps\mp\gametypes\_rank::getscoreinfovalue("assault"));
			attacker thread maps\mp\gametypes\_rank::giverankxp("assault");
			maps\mp\gametypes\_gamescore::giveplayerscore("assault", attacker);
			thread maps\mp\_matchdata::logkillevent(killid, "defending");
			continue;
		}

		awardeddefend = 1;
		attacker thread maps\mp\gametypes\_hud_message::splashnotify("defend", maps\mp\gametypes\_rank::getscoreinfovalue("defend"));
		attacker thread maps\mp\gametypes\_rank::giverankxp("defend");
		maps\mp\gametypes\_gamescore::giveplayerscore("defend", attacker);
		thread maps\mp\_matchdata::logkillevent(killid, "assaulting");
	}

	foreach(trigger in attacker.touchtriggers)
	{
		if(!isdefined(trigger.useobj))
		{
			continue;
		}

		ownerteam = trigger.useobj.ownerteam;
		team = attacker.pers["team"];
		if(ownerteam == "neutral")
		{
			continue;
		}

		if(team == ownerteam)
		{
			if(!awardeddefend)
			{
				attacker thread maps\mp\gametypes\_hud_message::splashnotify("defend", maps\mp\gametypes\_rank::getscoreinfovalue("defend"));
			}

			attacker thread maps\mp\gametypes\_rank::giverankxp("defend");
			maps\mp\gametypes\_gamescore::giveplayerscore("defend", attacker);
			thread maps\mp\_matchdata::logkillevent(killid, "assaulting");
			continue;
		}

		if(!awardedassault)
		{
			attacker thread maps\mp\gametypes\_hud_message::splashnotify("assault", maps\mp\gametypes\_rank::getscoreinfovalue("assault"));
		}

		attacker thread maps\mp\gametypes\_rank::giverankxp("assault");
		maps\mp\gametypes\_gamescore::giveplayerscore("assault", attacker);
		thread maps\mp\_matchdata::logkillevent(killid, "defending");
	}
}

getowneddomflags()
{
	domflags = [];
	foreach(domflag in level.domflags)
	{
		if(domflag maps\mp\gametypes\_gameobjects::getownerteam() != "neutral" && isdefined(domflag.capturetime))
		{
			domflags[domflags.size] = domflag;
		}
	}

	return domflags;
}

getteamflagcount(team)
{
	score = 0;
	for(i = 0;i < level.flags.size;i++)
	{
		if(level.domflags[i] maps\mp\gametypes\_gameobjects::getownerteam() == team)
		{
			score++;
		}
	}

	return score;
}

getflagteam()
{
	return self.useobj maps\mp\gametypes\_gameobjects::getownerteam();
}

getboundaryflags()
{
	bflags = [];
	for(i = 0;i < level.flags.size;i++)
	{
		for(j = 0;j < level.flags[i].adjflags.size;j++)
		{
			if(level.flags[i].useobj maps\mp\gametypes\_gameobjects::getownerteam() != level.flags[i].adjflags[j].useobj maps\mp\gametypes\_gameobjects::getownerteam())
			{
				bflags[bflags.size] = level.flags[i];
				break;
			}
		}
	}

	return bflags;
}

getboundaryflagspawns(team)
{
	spawns = [];
	bflags = getboundaryflags();
	for(i = 0;i < bflags.size;i++)
	{
		if(isdefined(team) && bflags[i] getflagteam() != team)
		{
			continue;
		}

		for(j = 0;j < bflags[i].nearbyspawns.size;j++)
		{
			spawns[spawns.size] = bflags[i].nearbyspawns[j];
		}
	}

	return spawns;
}

getspawnsboundingflag(avoidflag)
{
	spawns = [];
	for(i = 0;i < level.flags.size;i++)
	{
		flag = level.flags[i];
		if(flag == avoidflag)
		{
			continue;
		}

		isbounding = 0;
		for(j = 0;j < flag.adjflags.size;j++)
		{
			if(flag.adjflags[j] == avoidflag)
			{
				isbounding = 1;
				break;
			}
		}

		if(!isbounding)
		{
			continue;
		}

		for(j = 0;j < flag.nearbyspawns.size;j++)
		{
			spawns[spawns.size] = flag.nearbyspawns[j];
		}
	}

	return spawns;
}

getownedandboundingflagspawns(team)
{
	spawns = [];
	for(i = 0;i < level.flags.size;i++)
	{
		if(level.flags[i] getflagteam() == team)
		{
			for(s = 0;s < level.flags[i].nearbyspawns.size;s++)
			{
				spawns[spawns.size] = level.flags[i].nearbyspawns[s];
			}

			continue;
		}

		for(j = 0;j < level.flags[i].adjflags.size;j++)
		{
			if(level.flags[i].adjflags[j] getflagteam() == team)
			{
				for(s = 0;s < level.flags[i].nearbyspawns.size;s++)
				{
					spawns[spawns.size] = level.flags[i].nearbyspawns[s];
				}

				break;
			}
		}
	}

	return spawns;
}

getownedflagspawns(team)
{
	spawns = [];
	for(i = 0;i < level.flags.size;i++)
	{
		if(level.flags[i] getflagteam() == team)
		{
			for(s = 0;s < level.flags[i].nearbyspawns.size;s++)
			{
				spawns[spawns.size] = level.flags[i].nearbyspawns[s];
			}
		}
	}

	return spawns;
}

flagsetup()
{
	maperrors = [];
	descriptorsbylinkname = [];
	descriptors = getentarray("flag_descriptor", "targetname");
	flags = level.flags;
	for(i = 0;i < level.domflags.size;i++)
	{
		closestdist = undefined;
		closestdesc = undefined;
		for(j = 0;j < descriptors.size;j++)
		{
			dist = distance(flags[i].origin, descriptors[j].origin);
			if(!isdefined(closestdist) || dist < closestdist)
			{
				closestdist = dist;
				closestdesc = descriptors[j];
			}
		}

		if(!isdefined(closestdesc))
		{
			maperrors[maperrors.size] = "there is no flag_descriptor in the map! see explanation in dom.gsc";
			break;
		}

		if(isdefined(closestdesc.flag))
		{
			maperrors[maperrors.size] = "flag_descriptor with script_linkname \"" + closestdesc.script_linkname + "\" is nearby more than one flag; is there a unique descriptor near each flag?";
			continue;
		}

		flags[i].descriptor = closestdesc;
		closestdesc.flag = flags[i];
		descriptorsbylinkname[closestdesc.script_linkname] = closestdesc;
	}

	if(maperrors.size == 0)
	{
		for(i = 0;i < flags.size;i++)
		{
			if(isdefined(flags[i].descriptor.script_linkto))
			{
				adjdescs = strtok(flags[i].descriptor.script_linkto, " ");
			}
			else
			{
				adjdescs = [];
			}

			for(j = 0;j < adjdescs.size;j++)
			{
				otherdesc = descriptorsbylinkname[adjdescs[j]];
				if(!isdefined(otherdesc) || otherdesc.targetname != "flag_descriptor")
				{
					maperrors[maperrors.size] = "flag_descriptor with script_linkname \"" + flags[i].descriptor.script_linkname + "\" linked to \"" + adjdescs[j] + "\" which does not exist as a script_linkname of any other entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
					continue;
				}

				adjflag = otherdesc.flag;
				if(adjflag == flags[i])
				{
					maperrors[maperrors.size] = "flag_descriptor with script_linkname \"" + flags[i].descriptor.script_linkname + "\" linked to itself";
					continue;
				}

				flags[i].adjflags[flags[i].adjflags.size] = adjflag;
			}
		}
	}

	spawnpoints = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn");
	for(i = 0;i < spawnpoints.size;i++)
	{
		if(isdefined(spawnpoints[i].script_linkto))
		{
			desc = descriptorsbylinkname[spawnpoints[i].script_linkto];
			if(!isdefined(desc) || desc.targetname != "flag_descriptor")
			{
				maperrors[maperrors.size] = "Spawnpoint at " + spawnpoints[i].origin + "\" linked to \"" + spawnpoints[i].script_linkto + "\" which does not exist as a script_linkname of any entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
				continue;
			}

			nearestflag = desc.flag;
		}
		else
		{
			nearestflag = undefined;
			nearestdist = undefined;
			for(j = 0;j < flags.size;j++)
			{
				dist = distancesquared(flags[j].origin, spawnpoints[i].origin);
				if(!isdefined(nearestflag) || dist < nearestdist)
				{
					nearestflag = flags[j];
					nearestdist = dist;
				}
			}
		}

		nearestflag.nearbyspawns[nearestflag.nearbyspawns.size] = spawnpoints[i];
	}

	if(maperrors.size > 0)
	{
		for(i = 0;i < maperrors.size;i++)
		{
		}

		common_scripts\utility::error("Map errors. See above");
		maps\mp\gametypes\_callbacksetup::abortlevel();
		return;
	}
}

initgametypeawards()
{
	maps\mp\_awards::initstataward("pointscaptured", 0, ::maps\mp\_awards::highestwins);
}

onspawnplayer()
{
}

updatecpm()
{
	if(!isdefined(self.cpm))
	{
		self.numcaps = 0;
		self.cpm = 0;
	}

	self.numcaps++;
	if(maps\mp\_utility::getminutespassed() < 1)
	{
		return;
	}

	self.cpm = self.numcaps / maps\mp\_utility::getminutespassed();
}

getcapxpscale()
{
	if(self.cpm < 4)
	{
		return 1;
	}

	return 0.25;
}