/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\ctf.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	maps\mp\_utility::registertimelimitdvar(level.gametype, 3, 0, 1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype, 1, 0, 10000);
	maps\mp\_utility::registerroundlimitdvar(level.gametype, 0, 0, 30);
	maps\mp\_utility::registerwinlimitdvar(level.gametype, 4, 0, 10);
	maps\mp\_utility::registerroundswitchdvar(level.gametype, 3, 0, 30);
	maps\mp\_utility::registernumlivesdvar(level.gametype, 0, 0, 10);
	maps\mp\_utility::registerhalftimedvar(level.gametype, 1, 0, 1);
	maps\mp\_utility::setovertimelimitdvar(4);
	level.teambased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.initgametypeawards = ::initgametypeawards;
	level.ontimelimit = ::ontimelimit;
	level.onspawnplayer = ::onspawnplayer;
	level.flagreturntime = maps\mp\_utility::getintproperty("scr_ctf_returntime", 30);
	game["dialog"]["gametype"] = "captureflag";
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

	game["dialog"]["offense_obj"] = "capture_obj";
	game["dialog"]["defense_obj"] = "capture_obj";
}

onprecachegametype()
{
	precachestring(&"MP_FLAG_TAKEN_BY");
	precachestring(&"MP_ENEMY_FLAG_TAKEN_BY");
	precachestring(&"MP_FLAG_CAPTURED_BY");
	precachestring(&"MP_ENEMY_FLAG_CAPTURED_BY");
	precachestring(&"MP_FLAG_RETURNED");
	precachestring(&"MP_ENEMY_FLAG_RETURNED");
	precachestring(&"MP_YOUR_FLAG_RETURNING_IN");
	precachestring(&"MP_ENEMY_FLAG_RETURNING_IN");
	precachestring(&"MP_ENEMY_FLAG_DROPPED_BY");
	precachestring(&"MP_DOM_NEUTRAL_FLAG_CAPTURED");
	precachestring(&"MP_GRABBING_FLAG");
	precachestring(&"MP_RETURNING_FLAG");
}

onspawnplayer()
{
	if(maps\mp\_utility::inovertime() && !isdefined(self.otspawned))
	{
		thread printothint();
		return;
	}
}

printothint()
{
	self endon("disconnect");
	wait 0.25;
	self.otspawned = 1;
	hintmessage = maps\mp\_utility::getobjectivehinttext(self.team);
	thread maps\mp\gametypes\_hud_message::hintmessage(hintmessage);
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
		if(maps\mp\_utility::inovertime())
		{
			maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_GRAB_FLAG");
			maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_GRAB_FLAG");
		}
		else
		{
			maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER");
			maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER");
		}
	}
	else if(maps\mp\_utility::inovertime())
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_GRAB_FLAG_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_GRAB_FLAG_SCORE");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_SCORE");
	}

	if(maps\mp\_utility::inovertime())
	{
		maps\mp\_utility::setobjectivetext(game["attackers"], &"OBJECTIVES_OVERTIME_CTF");
		maps\mp\_utility::setobjectivetext(game["defenders"], &"OBJECTIVES_OVERTIME_CTF");
		maps\mp\_utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_GRAB_FLAG_HINT");
		maps\mp\_utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_GRAB_FLAG_HINT");
	}
	else
	{
		maps\mp\_utility::setobjectivetext(game["attackers"], &"OBJECTIVES_CTF");
		maps\mp\_utility::setobjectivetext(game["defenders"], &"OBJECTIVES_CTF");
		maps\mp\_utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_ONE_FLAG_ATTACKER_HINT");
		maps\mp\_utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_ONE_FLAG_DEFENDER_HINT");
	}

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
	maps\mp\gametypes\_rank::registerscoreinfo("headshot", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist", 20);
	maps\mp\gametypes\_rank::registerscoreinfo("pickup", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("return", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("capture", 250);
	maps\mp\gametypes\_rank::registerscoreinfo("kill_carrier", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("defend", 100);
	maps\mp\gametypes\_rank::registerscoreinfo("defend_assist", 100);
	maps\mp\gametypes\_rank::registerscoreinfo("assault", 200);
	maps\mp\gametypes\_rank::registerscoreinfo("assault_assist", 40);
	allowed[0] = "ctf";
	maps\mp\gametypes\_gameobjects::main(allowed);
	thread ctf();
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

ctf()
{
	level.flagmodel["allies"] = maps\mp\gametypes\_teams::getteamflagmodel("allies");
	level.icon2d["allies"] = maps\mp\gametypes\_teams::getteamflagicon("allies");
	level.carryflag["allies"] = maps\mp\gametypes\_teams::getteamflagcarrymodel("allies");
	precachemodel(level.flagmodel["allies"]);
	precachemodel(level.carryflag["allies"]);
	level.flagmodel["axis"] = maps\mp\gametypes\_teams::getteamflagmodel("axis");
	level.icon2d["axis"] = maps\mp\gametypes\_teams::getteamflagicon("axis");
	level.carryflag["axis"] = maps\mp\gametypes\_teams::getteamflagcarrymodel("axis");
	precachemodel(level.flagmodel["axis"]);
	precachemodel(level.carryflag["axis"]);
	level.iconescort3d = "waypoint_escort";
	level.iconescort2d = "waypoint_escort";
	precacheshader(level.iconescort3d);
	precacheshader(level.iconescort2d);
	level.iconkill3d = "waypoint_kill";
	level.iconkill2d = "waypoint_kill";
	precacheshader(level.iconkill3d);
	precacheshader(level.iconkill2d);
	level.iconcaptureflag3d = "waypoint_capture_flag";
	level.iconcaptureflag2d = "waypoint_capture_flag";
	precacheshader(level.iconcaptureflag3d);
	precacheshader(level.iconcaptureflag2d);
	level.icondefendflag3d = "waypoint_defend_flag";
	level.icondefendflag2d = "waypoint_defend_flag";
	precacheshader(level.icondefendflag3d);
	precacheshader(level.icondefendflag2d);
	level.iconreturnflag3d = "waypoint_return_flag";
	level.iconreturnflag2d = "waypoint_return_flag";
	precacheshader(level.iconreturnflag3d);
	precacheshader(level.iconreturnflag2d);
	level.iconwaitforflag3d = "waypoint_waitfor_flag";
	level.iconwaitforflag2d = "waypoint_waitfor_flag";
	precacheshader(level.iconwaitforflag3d);
	precacheshader(level.iconwaitforflag2d);
	precacheshader(level.icon2d["axis"]);
	precacheshader(level.icon2d["allies"]);
	precacheshader("waypoint_flag_friendly");
	precacheshader("waypoint_flag_enemy");
	precachestring(&"OBJECTIVES_FLAG_HOME");
	precachestring(&"OBJECTIVES_FLAG_NAME");
	precachestring(&"OBJECTIVES_FLAG_AWAY");
	level.teamflags[game["defenders"]] = createteamflag(game["defenders"], "allies");
	level.teamflags[game["attackers"]] = createteamflag(game["attackers"], level.otherteam["allies"]);
	level.capzones[game["defenders"]] = createcapzone(game["defenders"], "allies");
	level.capzones[game["attackers"]] = createcapzone(game["attackers"], level.otherteam["allies"]);
	if(level.splitscreen)
	{
		hudelemalpha = 0;
	}
	else
	{
		hudelemalpha = 0.85;
	}

	level.friendlyflagstatusicon["allies"] = maps\mp\gametypes\_hud_util::createservericon("waypoint_flag_friendly", 32, 32, "allies");
	level.friendlyflagstatusicon["allies"] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT", "TOP LEFT", 132, 0);
	level.friendlyflagstatusicon["allies"].alpha = hudelemalpha;
	level.friendlyflagstatusicon["allies"].hidewheninmenu = 1;
	level.friendlyflagstatustext["allies"] = maps\mp\gametypes\_hud_util::createserverfontstring("small", 1.6, "allies");
	level.friendlyflagstatustext["allies"] maps\mp\gametypes\_hud_util::setparent(level.friendlyflagstatusicon["allies"]);
	level.friendlyflagstatustext["allies"] maps\mp\gametypes\_hud_util::setpoint("LEFT", "RIGHT", 4);
	level.friendlyflagstatustext["allies"] settext(&"OBJECTIVES_FLAG_HOME");
	level.friendlyflagstatustext["allies"].alpha = hudelemalpha;
	level.friendlyflagstatustext["allies"].color = (1,1,1);
	level.friendlyflagstatustext["allies"].glowalpha = 1;
	level.friendlyflagstatustext["allies"].hidewheninmenu = 1;
	level.enemyflagstatusicon["allies"] = maps\mp\gametypes\_hud_util::createservericon("waypoint_flag_enemy", 24, 24, "allies");
	level.enemyflagstatusicon["allies"] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT", "TOP LEFT", 132, 26);
	level.enemyflagstatusicon["allies"].alpha = hudelemalpha;
	level.enemyflagstatusicon["allies"].hidewheninmenu = 1;
	level.enemyflagstatustext["allies"] = maps\mp\gametypes\_hud_util::createserverfontstring("small", 1.6, "allies");
	level.enemyflagstatustext["allies"] maps\mp\gametypes\_hud_util::setparent(level.enemyflagstatusicon["allies"]);
	level.enemyflagstatustext["allies"] maps\mp\gametypes\_hud_util::setpoint("LEFT", "RIGHT", 4);
	level.enemyflagstatustext["allies"] settext(&"OBJECTIVES_FLAG_HOME");
	level.enemyflagstatustext["allies"].alpha = hudelemalpha;
	level.enemyflagstatustext["allies"].color = (1,1,1);
	level.enemyflagstatustext["allies"].glowalpha = 1;
	level.enemyflagstatustext["allies"].hidewheninmenu = 1;
	level.friendlyflagstatusicon["axis"] = maps\mp\gametypes\_hud_util::createservericon("waypoint_flag_friendly", 32, 32, "axis");
	level.friendlyflagstatusicon["axis"] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT", "TOP LEFT", 132, 0);
	level.friendlyflagstatusicon["axis"].alpha = hudelemalpha;
	level.friendlyflagstatusicon["axis"].hidewheninmenu = 1;
	level.friendlyflagstatustext["axis"] = maps\mp\gametypes\_hud_util::createserverfontstring("small", 1.6, "axis");
	level.friendlyflagstatustext["axis"] maps\mp\gametypes\_hud_util::setparent(level.friendlyflagstatusicon["axis"]);
	level.friendlyflagstatustext["axis"] maps\mp\gametypes\_hud_util::setpoint("LEFT", "RIGHT", 4);
	level.friendlyflagstatustext["axis"] settext(&"OBJECTIVES_FLAG_HOME");
	level.friendlyflagstatustext["axis"].alpha = hudelemalpha;
	level.friendlyflagstatustext["axis"].color = (1,1,1);
	level.friendlyflagstatustext["axis"].glowalpha = 1;
	level.friendlyflagstatustext["axis"].hidewheninmenu = 1;
	level.enemyflagstatusicon["axis"] = maps\mp\gametypes\_hud_util::createservericon("waypoint_flag_enemy", 24, 24, "axis");
	level.enemyflagstatusicon["axis"] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT", "TOP LEFT", 132, 26);
	level.enemyflagstatusicon["axis"].alpha = hudelemalpha;
	level.enemyflagstatusicon["axis"].hidewheninmenu = 1;
	level.enemyflagstatustext["axis"] = maps\mp\gametypes\_hud_util::createserverfontstring("small", 1.6, "axis");
	level.enemyflagstatustext["axis"] maps\mp\gametypes\_hud_util::setparent(level.enemyflagstatusicon["axis"]);
	level.enemyflagstatustext["axis"] maps\mp\gametypes\_hud_util::setpoint("LEFT", "RIGHT", 4);
	level.enemyflagstatustext["axis"] settext(&"OBJECTIVES_FLAG_HOME");
	level.enemyflagstatustext["axis"].alpha = hudelemalpha;
	level.enemyflagstatustext["axis"].color = (1,1,1);
	level.enemyflagstatustext["axis"].glowalpha = 1;
	level.enemyflagstatustext["axis"].hidewheninmenu = 1;
}

ontimelimit()
{
	if(!maps\mp\_utility::inovertime() && game["teamScores"]["allies"] == game["teamScores"]["axis"] && game["switchedsides"])
	{
		thread maps\mp\gametypes\_gamelogic::endgame("overtime", game["strings"]["time_limit_reached"]);
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

	if(maps\mp\_utility::inovertime())
	{
		thread maps\mp\gametypes\_gamelogic::endgame("tie", game["strings"]["time_limit_reached"]);
		return;
	}
}

spawnfxdelay(fxid, pos, forward, right, delay)
{
	wait delay;
	effect = spawnfx(fxid, pos, forward, right);
	triggerfx(effect);
}

createteamflag(team, entityteam)
{
	trigger = getent("ctf_zone_" + entityteam, "targetname");
	if(!isdefined(trigger))
	{
		common_scripts\utility::error("No ctf_zone_" + entityteam + " trigger found in map.");
		return;
	}

	visuals[0] = getent("ctf_flag_" + entityteam, "targetname");
	if(!isdefined(visuals[0]))
	{
		common_scripts\utility::error("No ctf_flag_" + entityteam + " script_model found in map.");
		return;
	}

	clonetrigger = spawn("trigger_radius", trigger.origin, 0, 96, trigger.height);
	trigger = clonetrigger;
	visuals[0] setmodel(level.flagmodel[team]);
	teamflag = maps\mp\gametypes\_gameobjects::createcarryobject(team, trigger, visuals, (0,0,85));
	teamflag maps\mp\gametypes\_gameobjects::setteamusetime("friendly", 0.5);
	teamflag maps\mp\gametypes\_gameobjects::setteamusetime("enemy", 0.5);
	teamflag maps\mp\gametypes\_gameobjects::setteamusetext("enemy", &"MP_GRABBING_FLAG");
	teamflag maps\mp\gametypes\_gameobjects::setteamusetext("friendly", &"MP_RETURNING_FLAG");
	teamflag maps\mp\gametypes\_gameobjects::allowcarry("enemy");
	teamflag maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	teamflag maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconkill2d);
	teamflag maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconkill3d);
	teamflag maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconescort2d);
	teamflag maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconescort3d);
	teamflag maps\mp\gametypes\_gameobjects::setcarryicon(level.icon2d[team]);
	teamflag.objidpingfriendly = 1;
	teamflag.allowweapons = 1;
	teamflag.onpickup = ::onpickup;
	teamflag.onpickupfailed = ::onpickup;
	teamflag.ondrop = ::ondrop;
	teamflag.onreset = ::onreset;
	teamflag.oldradius = trigger.radius;
	tracestart = trigger.origin + (0,0,32);
	traceend = trigger.origin + (0,0,-32);
	trace = bullettrace(tracestart, traceend, 0, undefined);
	fx = maps\mp\gametypes\_teams::getteamflagfx(team);
	fxid = loadfx(fx);
	upangles = vectortoangles(trace["normal"]);
	forward = anglestoforward(upangles);
	right = anglestoright(upangles);
	thread spawnfxdelay(fxid, trace["position"], forward, right, 0.5);
	return teamflag;
}

createcapzone(team, entityteam)
{
	trigger = getent("ctf_zone_" + entityteam, "targetname");
	if(!isdefined(trigger))
	{
		common_scripts\utility::error("No ctf_zone_" + entityteam + " trigger found in map.");
		return;
	}

	visuals = [];
	capzone = maps\mp\gametypes\_gameobjects::createuseobject(team, trigger, visuals, (0,0,85));
	capzone maps\mp\gametypes\_gameobjects::allowuse("friendly");
	capzone maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	capzone maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.icondefendflag2d);
	capzone maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.icondefendflag3d);
	capzone maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
	capzone maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
	capzone maps\mp\gametypes\_gameobjects::setusetime(0);
	capzone maps\mp\gametypes\_gameobjects::setkeyobject(level.teamflags[maps\mp\_utility::getotherteam(team)]);
	capzone.onuse = ::onuse;
	capzone.oncantuse = ::oncantuse;
	tracestart = trigger.origin + (0,0,32);
	traceend = trigger.origin + (0,0,-32);
	trace = bullettrace(tracestart, traceend, 0, undefined);
	fx = maps\mp\gametypes\_teams::getteamflagfx(team);
	fxid = loadfx(fx);
	upangles = vectortoangles(trace["normal"]);
	forward = anglestoforward(upangles);
	right = anglestoright(upangles);
	thread spawnfxdelay(fxid, trace["position"], forward, right, 0.5);
	return capzone;
}

onbeginuse(player)
{
	team = player.pers["team"];
	if(team == maps\mp\gametypes\_gameobjects::getownerteam())
	{
		self.trigger.radius = 1024;
		return;
	}

	self.trigger.radius = self.oldradius;
}

onenduse(player, team, success)
{
	self.trigger.radius = self.oldradius;
}

onpickup(player)
{
	self notify("picked_up");
	team = player.pers["team"];
	if(team == "allies")
	{
		otherteam = "axis";
	}
	else
	{
		otherteam = "allies";
	}

	if(team == maps\mp\gametypes\_gameobjects::getownerteam())
	{
		player thread maps\mp\gametypes\_hud_message::splashnotify("flagreturn", maps\mp\gametypes\_rank::getscoreinfovalue("return"));
		player thread [[ level.onxpevent ]]("return");
		thread returnflag();
		player maps\mp\_utility::incplayerstat("flagsreturned", 1);
		player thread maps\mp\_matchdata::loggameevent("return", player.origin);
		maps\mp\_utility::printandsoundoneveryone(team, maps\mp\_utility::getotherteam(team), &"MP_FLAG_RETURNED", &"MP_ENEMY_FLAG_RETURNED", "mp_obj_returned", "mp_obj_returned", "");
		maps\mp\_utility::leaderdialog("enemy_flag_returned", otherteam, "status");
		maps\mp\_utility::leaderdialog("flag_returned", team, "status");
		level.friendlyflagstatustext[team] settext(&"OBJECTIVES_FLAG_HOME");
		level.friendlyflagstatustext[team].glowcolor = (1,1,1);
		level.friendlyflagstatustext[team].glowalpha = 0;
		level.enemyflagstatustext[otherteam] settext(&"OBJECTIVES_FLAG_HOME");
		level.enemyflagstatustext[otherteam].glowcolor = (1,1,1);
		level.enemyflagstatustext[otherteam].glowalpha = 0;
		return;
	}

	if(maps\mp\_utility::inovertime())
	{
		if(isdefined(level.flagcaptured))
		{
			return;
		}

		level thread maps\mp\_utility::teamplayercardsplash("callout_grabbedtheflag", player);
		level.teamflags[team] maps\mp\gametypes\_gameobjects::allowuse("none");
		level.teamflags[otherteam] maps\mp\gametypes\_gameobjects::allowuse("none");
		level.capzones[team] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
		level.capzones[otherteam] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
		level.flagcaptured = 1;
		maps\mp\gametypes\_gamescore::giveteamscoreforobjective(team, 1);
		thread maps\mp\gametypes\_gamelogic::endgame("winner", game["strings"]["grabbed_flag"]);
	}

	player attachflag();
	level.friendlyflagstatustext[otherteam] setplayernamestring(player);
	level.friendlyflagstatustext[otherteam].glowcolor = (0.75,0.25,0.25);
	level.friendlyflagstatustext[otherteam].glowalpha = 1;
	level.enemyflagstatustext[team] setplayernamestring(player);
	level.enemyflagstatustext[team].glowcolor = (0.25,0.75,0.25);
	level.enemyflagstatustext[team].glowalpha = 1;
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconkill2d);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconkill3d);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconescort2d);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconescort3d);
	level.capzones[otherteam] maps\mp\gametypes\_gameobjects::allowuse("none");
	level.capzones[otherteam] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	if(!level.teamflags[team] maps\mp\gametypes\_gameobjects::ishome())
	{
		level.capzones[team].trigger maps\mp\_entityheadicons::setheadicon(player, level.iconwaitforflag3d, (0,0,85));
		if(isdefined(level.teamflags[team].carrier))
		{
			level.capzones[otherteam].trigger maps\mp\_entityheadicons::setheadicon(level.teamflags[team].carrier, level.iconwaitforflag3d, (0,0,85));
		}
	}

	maps\mp\_utility::printandsoundoneveryone(team, otherteam, &"MP_ENEMY_FLAG_TAKEN_BY", &"MP_FLAG_TAKEN_BY", "mp_obj_taken", "mp_enemy_obj_taken", player);
	maps\mp\_utility::leaderdialog("enemy_flag_taken", team, "status");
	maps\mp\_utility::leaderdialog("flag_taken", otherteam, "status");
	thread maps\mp\_utility::teamplayercardsplash("callout_flagpickup", player);
	player thread maps\mp\gametypes\_hud_message::splashnotify("flagpickup", maps\mp\gametypes\_rank::getscoreinfovalue("pickup"));
	maps\mp\gametypes\_gamescore::giveplayerscore("pickup", player);
	player thread [[ level.onxpevent ]]("pickup");
	player maps\mp\_utility::incplayerstat("flagscarried", 1);
	player thread maps\mp\_matchdata::loggameevent("pickup", player.origin);
}

returnflag()
{
	maps\mp\gametypes\_gameobjects::returnhome();
}

ondrop(player)
{
	team = maps\mp\gametypes\_gameobjects::getownerteam();
	otherteam = level.otherteam[team];
	maps\mp\gametypes\_gameobjects::allowcarry("any");
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconreturnflag2d);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconreturnflag3d);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
	level.friendlyflagstatustext[team] settext(&"OBJECTIVES_FLAG_AWAY");
	level.friendlyflagstatustext[team].glowcolor = (1,1,1);
	level.friendlyflagstatustext[team].glowalpha = 0;
	level.enemyflagstatustext[otherteam] settext(&"OBJECTIVES_FLAG_AWAY");
	level.enemyflagstatustext[otherteam].glowcolor = (1,1,1);
	level.enemyflagstatustext[otherteam].glowalpha = 0;
	level.capzones[otherteam].trigger maps\mp\_entityheadicons::setheadicon("none", "", (0,0,0));
	if(isdefined(player))
	{
		if(isdefined(player.carryflag))
		{
			player detachflag();
		}

		maps\mp\_utility::printandsoundoneveryone(otherteam, "none", &"MP_ENEMY_FLAG_DROPPED_BY", "", "mp_war_objective_lost", "", player);
	}
	else
	{
		maps\mp\_utility::playsoundonplayers("mp_war_objective_lost", otherteam);
	}

	maps\mp\_utility::leaderdialog("enemy_flag_dropped", otherteam, "status");
	maps\mp\_utility::leaderdialog("flag_dropped", team, "status");
	thread returnaftertime();
}

returnaftertime()
{
	self endon("picked_up");
	wait level.flagreturntime;
	maps\mp\gametypes\_gameobjects::returnhome();
}

onreset()
{
	team = maps\mp\gametypes\_gameobjects::getownerteam();
	otherteam = level.otherteam[team];
	maps\mp\gametypes\_gameobjects::allowcarry("enemy");
	maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.iconkill2d);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.iconkill3d);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconescort2d);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconescort3d);
	level.friendlyflagstatustext[team] settext(&"OBJECTIVES_FLAG_HOME");
	level.friendlyflagstatustext[team].glowcolor = (1,1,1);
	level.friendlyflagstatustext[team].glowalpha = 0;
	level.enemyflagstatustext[otherteam] settext(&"OBJECTIVES_FLAG_HOME");
	level.enemyflagstatustext[otherteam].glowcolor = (1,1,1);
	level.enemyflagstatustext[otherteam].glowalpha = 0;
	level.capzones[team] maps\mp\gametypes\_gameobjects::allowuse("friendly");
	level.capzones[team] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	level.capzones[team] maps\mp\gametypes\_gameobjects::set2dicon("friendly", level.icondefendflag2d);
	level.capzones[team] maps\mp\gametypes\_gameobjects::set3dicon("friendly", level.icondefendflag3d);
	level.capzones[team] maps\mp\gametypes\_gameobjects::set2dicon("enemy", level.iconcaptureflag2d);
	level.capzones[team] maps\mp\gametypes\_gameobjects::set3dicon("enemy", level.iconcaptureflag3d);
	level.capzones[team].trigger maps\mp\_entityheadicons::setheadicon("none", "", (0,0,0));
}

onuse(player)
{
	team = player.pers["team"];
	if(team == "allies")
	{
		otherteam = "axis";
	}
	else
	{
		otherteam = "allies";
	}

	maps\mp\_utility::leaderdialog("enemy_flag_captured", team, "status");
	maps\mp\_utility::leaderdialog("flag_captured", otherteam, "status");
	thread maps\mp\_utility::teamplayercardsplash("callout_flagcapture", player);
	maps\mp\gametypes\_gamescore::giveteamscoreforobjective(team, 1);
	player thread maps\mp\gametypes\_hud_message::splashnotify("flag_capture", maps\mp\gametypes\_rank::getscoreinfovalue("capture"));
	maps\mp\gametypes\_gamescore::giveplayerscore("capture", player);
	player thread [[ level.onxpevent ]]("capture");
	player maps\mp\_utility::incplayerstat("flagscaptured", 1);
	player notify("objective", "captured");
	player thread maps\mp\_matchdata::loggameevent("capture", player.origin);
	maps\mp\_utility::printandsoundoneveryone(team, otherteam, &"MP_ENEMY_FLAG_CAPTURED_BY", &"MP_FLAG_CAPTURED_BY", "mp_obj_captured", "mp_enemy_obj_captured", player);
	if(isdefined(player.carryflag))
	{
		player detachflag();
	}

	level.teamflags[otherteam] returnflag();
}

oncantuse(player)
{
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration, killid)
{
	if(isdefined(attacker) && isplayer(attacker) && attacker.pers["team"] != self.pers["team"])
	{
		if(isdefined(attacker.carryflag))
		{
			attacker maps\mp\_utility::incplayerstat("killsasflagcarrier", 1);
		}

		if(isdefined(self.carryflag))
		{
			attacker thread [[ level.onxpevent ]]("kill_carrier");
			maps\mp\gametypes\_gamescore::giveplayerscore("kill_carrier", attacker);
			attacker maps\mp\_utility::incplayerstat("flagcarrierkills", 1);
			thread maps\mp\_matchdata::logkillevent(killid, "carrying");
			detachflag();
			return;
		}

		return;
	}
}

attachflag()
{
	otherteam = level.otherteam[self.pers["team"]];
	self attach(level.carryflag[otherteam], "J_spine4", 1);
	self.carryflag = level.carryflag[otherteam];
}

detachflag()
{
	self detach(self.carryflag, "J_spine4");
	self.carryflag = undefined;
}

initgametypeawards()
{
	maps\mp\_awards::initstataward("flagscaptured", 0, ::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagsreturned", 0, ::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagcarrierkills", 0, ::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("flagscarried", 0, ::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("killsasflagcarrier", 0, ::maps\mp\_awards::highestwins);
}