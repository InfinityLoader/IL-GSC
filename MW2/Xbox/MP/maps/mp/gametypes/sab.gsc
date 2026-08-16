/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\sab.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
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
	level.teambased = 1;
	maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
	maps\mp\_utility::registertimelimitdvar(level.gametype, 10, 0, 1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype, 0, 0, 500);
	maps\mp\_utility::registerroundlimitdvar(level.gametype, 1, 0, 10);
	maps\mp\_utility::registerwinlimitdvar(level.gametype, 1, 0, 10);
	maps\mp\_utility::registernumlivesdvar(level.gametype, 0, 0, 10);
	maps\mp\_utility::registerhalftimedvar(level.gametype, 0, 0, 1);
	maps\mp\_utility::setovertimelimitdvar(2);
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.ononeleftevent = ::ononeleftevent;
	level.ontimelimit = ::ontimelimit;
	level.onnormaldeath = ::onnormaldeath;
	level.initgametypeawards = ::initgametypeawards;
	game["dialog"]["gametype"] = "sabotage";
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
	badtrig = getent("sab_bomb_defuse_allies", "targetname");
	if(isdefined(badtrig))
	{
		badtrig delete();
	}

	badtrig = getent("sab_bomb_defuse_axis", "targetname");
	if(isdefined(badtrig))
	{
		badtrig delete();
		return;
	}
}

onprecachegametype()
{
	game["bomb_dropped_sound"] = "mp_war_objective_lost";
	game["bomb_recovered_sound"] = "mp_war_objective_taken";
	precacheshader("waypoint_bomb");
	precacheshader("waypoint_kill");
	precacheshader("waypoint_bomb_enemy");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_defuse");
	precacheshader("waypoint_target");
	precacheshader("waypoint_escort");
	precacheshader("waypoint_bomb");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_defuse");
	precacheshader("waypoint_target");
	precacheshader("hud_suitcase_bomb");
	precachestring(&"MP_EXPLOSIVES_RECOVERED_BY");
	precachestring(&"MP_EXPLOSIVES_DROPPED_BY");
	precachestring(&"MP_EXPLOSIVES_PLANTED_BY");
	precachestring(&"MP_EXPLOSIVES_DEFUSED_BY");
	precachestring(&"MP_YOU_HAVE_RECOVERED_THE_BOMB");
	precachestring(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	precachestring(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	precachestring(&"MP_PLANTING_EXPLOSIVE");
	precachestring(&"MP_DEFUSING_EXPLOSIVE");
	precachestring(&"MP_TARGET_DESTROYED");
	precachestring(&"MP_NO_RESPAWN");
	precachestring(&"MP_TIE_BREAKER");
	precachestring(&"MP_NO_RESPAWN");
	precachestring(&"MP_SUDDEN_DEATH");
}

onstartgametype()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	setclientnamemode("auto_change");
	game["strings"]["target_destroyed"] = &"MP_TARGET_DESTROYED";
	game["strings"]["target_defended"] = &"MP_TARGET_DEDEFEND";
	maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_SAB");
	maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_SAB");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_SAB");
		maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_SAB");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_SAB_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_SAB_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_SAB_HINT");
	maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_SAB_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sab_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sab_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_sab_spawn_allies");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_sab_spawn_axis");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_sab_spawn_allies_planted", 1);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_sab_spawn_axis_planted", 1);
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
	setmapcenter(level.mapcenter);
	level.spawn_axis = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_axis");
	level.spawn_axis_planted = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_axis_planted");
	level.spawn_axis_planted = common_scripts\utility::array_combine(level.spawn_axis_planted, level.spawn_axis);
	level.spawn_allies = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_allies");
	level.spawn_allies_planted = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_allies_planted");
	level.spawn_allies_planted = common_scripts\utility::array_combine(level.spawn_allies_planted, level.spawn_allies);
	level.spawn_axis_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_axis_start");
	level.spawn_allies_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_allies_start");
	maps\mp\gametypes\_rank::registerscoreinfo("plant", 200);
	maps\mp\gametypes\_rank::registerscoreinfo("destroy", 1000);
	maps\mp\gametypes\_rank::registerscoreinfo("defuse", 150);
	allowed[0] = "sab";
	maps\mp\gametypes\_gameobjects::main(allowed);
	thread updategametypedvars();
	thread sabotage();
}

getspawnpoint()
{
	spawnteam = self.pers["team"];
	if(game["switchedsides"])
	{
		spawnteam = maps\mp\_utility::getotherteam(spawnteam);
	}

	if(level.usestartspawns)
	{
		if(spawnteam == "axis")
		{
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_axis_start);
		}
		else
		{
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_allies_start);
		}
	}
	else if(isdefined(level.bombplanted) && level.bombplanted && isdefined(level.bombowner) && spawnteam == level.bombowner.team)
	{
		if(spawnteam == "axis")
		{
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_axis_planted);
		}
		else
		{
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_allies_planted);
		}
	}
	else if(spawnteam == "axis")
	{
		spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_axis);
	}
	else
	{
		spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_allies);
	}

	return spawnpoint;
}

onspawnplayer()
{
	self.isplanting = 0;
	self.isdefusing = 0;
	self.isbombcarrier = 0;
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
	thread maps\mp\gametypes\_hud_message::splashnotify("sudden_death");
	self.otspawned = 1;
}

updategametypedvars()
{
	level.planttime = maps\mp\_utility::dvarfloatvalue("planttime", 5, 0, 20);
	level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime", 5, 0, 20);
	level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer", 45, 1, 300);
	level.hotpotato = maps\mp\_utility::dvarintvalue("hotpotato", 1, 0, 1);
	level.scoremode = maps\mp\_utility::getwatcheddvar("scorelimit");
}

sabotage()
{
	level.bombplanted = 0;
	level.bombexploded = 0;
	level._effect["bombexplosion"] = loadfx("explosions/tanker_explosion");
	trigger = getent("sab_bomb_pickup_trig", "targetname");
	if(!isdefined(trigger))
	{
		common_scripts\utility::error("No sab_bomb_pickup_trig trigger found in map.");
		return;
	}

	visuals[0] = getent("sab_bomb", "targetname");
	if(!isdefined(visuals[0]))
	{
		common_scripts\utility::error("No sab_bomb script_model found in map.");
		return;
	}

	precachemodel("prop_suitcase_bomb");
	visuals[0] setmodel("prop_suitcase_bomb");
	level.sabbomb = maps\mp\gametypes\_gameobjects::createcarryobject("neutral", trigger, visuals, (0,0,32));
	level.sabbomb maps\mp\gametypes\_gameobjects::allowcarry("any");
	level.sabbomb maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_bomb");
	level.sabbomb maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_bomb");
	level.sabbomb maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_bomb");
	level.sabbomb maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_bomb");
	level.sabbomb maps\mp\gametypes\_gameobjects::setcarryicon("hud_suitcase_bomb");
	level.sabbomb maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	level.sabbomb.objidpingenemy = 1;
	level.sabbomb.onpickup = ::onpickup;
	level.sabbomb.ondrop = ::ondrop;
	level.sabbomb.allowweapons = 1;
	level.sabbomb.objpoints["allies"].archived = 1;
	level.sabbomb.objpoints["axis"].archived = 1;
	level.sabbomb.autoresettime = 60;
	if(!isdefined(getent("sab_bomb_axis", "targetname")))
	{
		common_scripts\utility::error("No sab_bomb_axis trigger found in map.");
		return;
	}

	if(!isdefined(getent("sab_bomb_allies", "targetname")))
	{
		common_scripts\utility::error("No sab_bomb_allies trigger found in map.");
		return;
	}

	if(game["switchedsides"])
	{
		level.bombzones["allies"] = createbombzone("allies", getent("sab_bomb_axis", "targetname"));
		level.bombzones["axis"] = createbombzone("axis", getent("sab_bomb_allies", "targetname"));
	}
	else
	{
		level.bombzones["allies"] = createbombzone("allies", getent("sab_bomb_allies", "targetname"));
		level.bombzones["axis"] = createbombzone("axis", getent("sab_bomb_axis", "targetname"));
	}

	if(level.scoremode)
	{
		level thread scorethread();
	}

	if(maps\mp\_utility::inovertime())
	{
		level thread overtimethread();
		return;
	}
}

getclosestsite()
{
	if(distance2d(self.origin, level.bombzones["allies"].trigger.origin) < distance2d(self.origin, level.bombzones["axis"].trigger.origin))
	{
		return "allies";
	}

	return "axis";
}

distancetosite(team)
{
	return distance2d(self.origin, level.bombzones[team].trigger.origin);
}

scorethread()
{
	level.bombdistance = distance2d(getent("sab_bomb_axis", "targetname") getorigin(), getent("sab_bomb_allies", "targetname") getorigin());
	threatdistance = level.bombdistance / 2 - 384;
	bombent = level.sabbomb.trigger;
	if(threatdistance > bombent distancetosite("allies") || threatdistance > bombent distancetosite("axis"))
	{
		threatdistance = bombent distancetosite(bombent getclosestsite()) - 128;
	}

	dangerteam = "";
	for(;;)
	{
		if(isdefined(level.sabbomb.carrier))
		{
			bombent = level.sabbomb.carrier;
		}
		else
		{
			bombent = level.sabbomb.trigger;
		}

		lastdangerteam = dangerteam;
		dangerteam = "none";
		if(bombent distancetosite("allies") < threatdistance)
		{
			dangerteam = level.bombzones["allies"] maps\mp\gametypes\_gameobjects::getownerteam();
		}
		else if(bombent distancetosite("axis") < threatdistance)
		{
			dangerteam = level.bombzones["axis"] maps\mp\gametypes\_gameobjects::getownerteam();
		}
		else if(bombent distancetosite("allies") > level.bombdistance && bombent getclosestsite() != "allies")
		{
			dangerteam = level.bombzones["axis"] maps\mp\gametypes\_gameobjects::getownerteam();
		}
		else if(bombent distancetosite("axis") > level.bombdistance && bombent getclosestsite() != "axis")
		{
			dangerteam = level.bombzones["allies"] maps\mp\gametypes\_gameobjects::getownerteam();
		}

		if(dangerteam != "none")
		{
			if(!level.bombplanted || !maps\mp\_utility::getwatcheddvar("scorelimit") || level.bombplanted && maps\mp\gametypes\_gamescore::_getteamscore(level.otherteam[dangerteam]) < maps\mp\_utility::getwatcheddvar("scorelimit") - 1)
			{
				maps\mp\gametypes\_gamescore::_setteamscore(level.otherteam[dangerteam], maps\mp\gametypes\_gamescore::_getteamscore(level.otherteam[dangerteam]) + 1);
				maps\mp\gametypes\_gamescore::updateteamscore(level.otherteam[dangerteam]);
			}
		}

		if(dangerteam != lastdangerteam && !level.bombexploded)
		{
			setdvar("ui_danger_team", dangerteam);
		}

		wait 2.5;
	}
}

createbombzone(team, trigger)
{
	visuals = getentarray(trigger.target, "targetname");
	bombzone = maps\mp\gametypes\_gameobjects::createuseobject(team, trigger, visuals, (0,0,64));
	bombzone resetbombsite();
	bombzone.onuse = ::onuse;
	bombzone.onbeginuse = ::onbeginuse;
	bombzone.onenduse = ::onenduse;
	bombzone.oncantuse = ::oncantuse;
	bombzone.useweapon = "briefcase_bomb_mp";
	for(i = 0;i < visuals.size;i++)
	{
		if(isdefined(visuals[i].script_exploder))
		{
			bombzone.exploderindex = visuals[i].script_exploder;
			break;
		}
	}

	return bombzone;
}

onbeginuse(player)
{
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(player.pers["team"]))
	{
		player.isplanting = 1;
		return;
	}

	player.isdefusing = 1;
}

onenduse(team, player, result)
{
	if(!isalive(player))
	{
		return;
	}

	player.isplanting = 0;
	player.isdefusing = 0;
}

onpickup(player)
{
	level notify("bomb_picked_up");
	self.autoresettime = 60;
	level.usestartspawns = 0;
	team = player.pers["team"];
	if(team == "allies")
	{
		otherteam = "axis";
	}
	else
	{
		otherteam = "allies";
	}

	player playlocalsound("mp_suitcase_pickup");
	player maps\mp\_utility::leaderdialogonplayer("obj_destroy", "bomb");
	excludelist[0] = player;
	maps\mp\_utility::leaderdialog("bomb_taken", team, "bomb", excludelist);
	if(!level.splitscreen)
	{
		maps\mp\_utility::leaderdialog("bomb_lost", otherteam, "bomb");
		maps\mp\_utility::leaderdialog("obj_defend", otherteam, "bomb");
	}

	player.isbombcarrier = 1;
	if(team == maps\mp\gametypes\_gameobjects::getownerteam())
	{
		maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"], team);
	}
	else
	{
		maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"]);
	}

	maps\mp\gametypes\_gameobjects::setownerteam(team);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_target");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_kill");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_escort");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_escort");
	level.bombzones[team] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.bombzones[otherteam] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	player maps\mp\_utility::incplayerstat("bombscarried", 1);
	player thread maps\mp\_matchdata::loggameevent("pickup", player.origin);
}

ondrop(player)
{
	if(level.bombplanted)
	{
		return;
	}

	if(isdefined(player))
	{
		maps\mp\_utility::printonteamarg(&"MP_EXPLOSIVES_DROPPED_BY", maps\mp\gametypes\_gameobjects::getownerteam(), player);
	}

	maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"], maps\mp\gametypes\_gameobjects::getownerteam());
	thread abandonmentthink(0);
}

abandonmentthink(delay)
{
	level endon("bomb_picked_up");
	wait delay;
	if(isdefined(self.carrier))
	{
		return;
	}

	if(maps\mp\gametypes\_gameobjects::getownerteam() == "allies")
	{
		otherteam = "axis";
	}
	else
	{
		otherteam = "allies";
	}

	maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"], otherteam);
	maps\mp\gametypes\_gameobjects::setownerteam("neutral");
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_bomb");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_bomb");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_bomb");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_bomb");
	level.bombzones["allies"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.bombzones["axis"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
}

onuse(player)
{
	team = player.pers["team"];
	otherteam = level.otherteam[team];
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(player.pers["team"]))
	{
		player notify("bomb_planted");
		player playsound("mp_bomb_plant");
		level thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted", player);
		maps\mp\_utility::leaderdialog("bomb_planted");
		player thread maps\mp\gametypes\_hud_message::splashnotify("plant", maps\mp\gametypes\_rank::getscoreinfovalue("plant"));
		player thread maps\mp\gametypes\_rank::giverankxp("plant");
		maps\mp\gametypes\_gamescore::giveplayerscore("plant", player);
		player maps\mp\_utility::incplayerstat("bombsplanted", 1);
		player thread maps\mp\_matchdata::loggameevent("plant", player.origin);
		player.bombplantedtime = gettime();
		level thread bombplanted(self, player.pers["team"]);
		level.bombowner = player;
		level.sabbomb.autoresettime = undefined;
		level.sabbomb maps\mp\gametypes\_gameobjects::allowcarry("none");
		level.sabbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
		level.sabbomb maps\mp\gametypes\_gameobjects::setdropped();
		self.useweapon = "briefcase_bomb_defuse_mp";
		setupfordefusing();
		return;
	}

	player notify("bomb_defused");
	maps\mp\_utility::leaderdialog("bomb_defused");
	level thread maps\mp\_utility::teamplayercardsplash("callout_bombdefused", player);
	if(isdefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && maps\mp\_utility::isreallyalive(level.bombowner))
	{
		player thread maps\mp\gametypes\_hud_message::splashnotify("ninja_defuse", maps\mp\gametypes\_rank::getscoreinfovalue("defuse"));
	}
	else
	{
		player thread maps\mp\gametypes\_hud_message::splashnotify("defuse", maps\mp\gametypes\_rank::getscoreinfovalue("defuse"));
	}

	player thread maps\mp\gametypes\_rank::giverankxp("defuse");
	maps\mp\gametypes\_gamescore::giveplayerscore("defuse", player);
	player maps\mp\_utility::incplayerstat("bombsdefused", 1);
	player thread maps\mp\_matchdata::loggameevent("defuse", player.origin);
	if(maps\mp\_utility::inovertime())
	{
		thread maps\mp\gametypes\_gamelogic::endgame(team, game["strings"]["target_destroyed"]);
		return;
	}

	level thread bombdefused(self);
	resetbombsite();
	level.sabbomb maps\mp\gametypes\_gameobjects::allowcarry("any");
	level.sabbomb maps\mp\gametypes\_gameobjects::setpickedup(player);
}

oncantuse(player)
{
	player iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

bombplanted(param_EAE, team)
{
	level endon("overtime");
	maps\mp\gametypes\_gamelogic::pausetimer();
	level.bombplanted = 1;
	level.timelimitoverride = 1;
	level.scorelimitoverride = 1;
	setdvar("ui_bomb_timer", 1);
	setgameendtime(int(gettime() + level.bombtimer * 1000));
	param_EAE.visuals[0] thread maps\mp\gametypes\_gamelogic::playtickingsound();
	starttime = gettime();
	bombtimerwait();
	setdvar("ui_bomb_timer", 0);
	param_EAE.visuals[0] maps\mp\gametypes\_gamelogic::stoptickingsound();
	if(!level.bombplanted)
	{
		if(level.hotpotato)
		{
			timepassed = gettime() - starttime / 1000;
			level.bombtimer = level.bombtimer - timepassed;
		}

		return;
	}

	explosionorigin = level.sabbomb.visuals[0].origin;
	level.bombexploded = 1;
	setdvar("ui_danger_team", "BombExploded");
	if(isdefined(level.bombowner))
	{
		param_EAE.visuals[0] radiusdamage(explosionorigin, 512, 200, 20, level.bombowner);
		level.bombowner maps\mp\_utility::incplayerstat("targetsdestroyed", 1);
	}
	else
	{
		param_EAE.visuals[0] radiusdamage(explosionorigin, 512, 200, 20);
	}

	rot = randomfloat(360);
	explosioneffect = spawnfx(level._effect["bombexplosion"], explosionorigin + (0,0,50), (0,0,1), (cos(rot),sin(rot),0));
	triggerfx(explosioneffect);
	playrumbleonposition("grenade_rumble", explosionorigin);
	earthquake(0.75, 2, explosionorigin, 2000);
	thread maps\mp\_utility::playsoundinspace("exp_suitcase_bomb_main", explosionorigin);
	if(isdefined(param_EAE.exploderindex))
	{
		common_scripts\utility::exploder(param_EAE.exploderindex);
	}

	level.sabbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.bombzones["allies"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.bombzones["axis"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	setgameendtime(0);
	level.scorelimitoverride = 1;
	if(level.scoremode)
	{
		maps\mp\gametypes\_gamescore::_setteamscore(team, int(max(maps\mp\_utility::getwatcheddvar("scorelimit"), maps\mp\gametypes\_gamescore::_getteamscore(level.otherteam[team]) + 1)));
	}
	else
	{
		maps\mp\gametypes\_gamescore::_setteamscore(team, 1);
	}

	maps\mp\gametypes\_gamescore::updateteamscore(team);
	if(isdefined(level.bombowner))
	{
		level.bombowner thread maps\mp\gametypes\_rank::giverankxp("destroy");
		maps\mp\gametypes\_gamescore::giveplayerscore("destroy", level.bombowner);
		level thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_objective", level.bombowner);
	}

	wait 3;
	thread maps\mp\gametypes\_gamelogic::endgame(team, game["strings"]["target_destroyed"]);
}

bombtimerwait()
{
	level endon("bomb_defused");
	level endon("overtime_ended");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

givelastonteamwarning()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::waittillrecoveredhealth(3);
	otherteam = maps\mp\_utility::getotherteam(self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive", self, self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive", self, otherteam);
	level notify("last_alive", self);
}

ontimelimit()
{
	if(level.bombexploded)
	{
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

	if(game["teamScores"]["axis"] == game["teamScores"]["allies"])
	{
		if(maps\mp\_utility::inovertime())
		{
			thread maps\mp\gametypes\_gamelogic::endgame("tie", game["strings"]["time_limit_reached"]);
			return;
		}

		thread maps\mp\gametypes\_gamelogic::endgame("overtime", game["strings"]["time_limit_reached"]);
		return;
	}
}

overtimethread(time)
{
	level endon("game_ended");
	level.inovertime = 1;
	wait 5;
	level.disablespawning = 1;
}

bombdistancethread()
{
	level endon("game_ended");
	if(common_scripts\utility::cointoss())
	{
		level.dangerteam = "allies";
	}
	else
	{
		level.dangerteam = "axis";
	}

	for(;;)
	{
		if(isdefined(level.sabbomb.carrier))
		{
			bombent = level.sabbomb.carrier;
		}
		else
		{
			bombent = level.sabbomb.visuals[0];
		}

		if(distance(bombent.origin, level.bombzones[maps\mp\_utility::getotherteam(level.dangerteam)].visuals[0].origin) < distance(bombent.origin, level.bombzones[level.dangerteam].visuals[0].origin))
		{
			level.dangerteam = maps\mp\_utility::getotherteam(level.dangerteam);
		}

		wait 0.05;
	}
}

resetbombsite()
{
	maps\mp\gametypes\_gameobjects::allowuse("enemy");
	maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
	maps\mp\gametypes\_gameobjects::setusetext(&"MP_PLANTING_EXPLOSIVE");
	maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	maps\mp\gametypes\_gameobjects::setkeyobject(level.sabbomb);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defend");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_target");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_target");
	maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	self.useweapon = "briefcase_bomb_mp";
}

setupfordefusing()
{
	maps\mp\gametypes\_gameobjects::allowuse("friendly");
	maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
	maps\mp\gametypes\_gameobjects::setusetext(&"MP_DEFUSING_EXPLOSIVE");
	maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	maps\mp\gametypes\_gameobjects::setkeyobject(undefined);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defuse");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defuse");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_defend");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_defend");
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
}

bombdefused(object)
{
	setdvar("ui_bomb_timer", 0);
	maps\mp\gametypes\_gamelogic::resumetimer();
	level.bombplanted = 0;
	level.timelimitoverride = 0;
	level.scorelimitoverride = 0;
	level notify("bomb_defused");
}

ononeleftevent(team)
{
	if(level.bombexploded)
	{
		return;
	}

	lastplayer = maps\mp\_utility::getlastlivingplayer(team);
	lastplayer thread givelastonteamwarning();
}

onnormaldeath(victim, attacker, lifeid)
{
	if(victim.isplanting)
	{
		thread maps\mp\_matchdata::logkillevent(lifeid, "planting");
	}
	else if(victim.isbombcarrier)
	{
		attacker maps\mp\_utility::incplayerstat("bombcarrierkills", 1);
		thread maps\mp\_matchdata::logkillevent(lifeid, "carrying");
	}
	else if(victim.isdefusing)
	{
		thread maps\mp\_matchdata::logkillevent(lifeid, "defusing");
	}

	if(attacker.isbombcarrier)
	{
		attacker maps\mp\_utility::incplayerstat("killsasbombcarrier", 1);
		return;
	}
}

initgametypeawards()
{
	maps\mp\_awards::initstataward("targetsdestroyed", 0, ::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombsplanted", 0, ::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombsdefused", 0, ::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombcarrierkills", 0, ::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombscarried", 0, ::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("killsasbombcarrier", 0, ::maps\mp\_awards::highestwins);
}