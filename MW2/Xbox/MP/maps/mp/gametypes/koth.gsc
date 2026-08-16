/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\koth.gsc
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
	maps\mp\_utility::registertimelimitdvar(level.gametype, 30, 0, 1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype, 300, 0, 1000);
	maps\mp\_utility::registerroundlimitdvar(level.gametype, 1, 0, 10);
	maps\mp\_utility::registerwinlimitdvar(level.gametype, 1, 0, 10);
	maps\mp\_utility::registernumlivesdvar(level.gametype, 0, 0, 10);
	maps\mp\_utility::registerhalftimedvar(level.gametype, 0, 0, 1);
	level.teambased = 1;
	level.doprematch = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.onplayerkilled = ::onplayerkilled;
	level.initgametypeawards = ::initgametypeawards;
	precacheshader("waypoint_captureneutral");
	precacheshader("waypoint_capture");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_targetneutral");
	precacheshader("waypoint_captureneutral");
	precacheshader("waypoint_capture");
	precacheshader("waypoint_defend");
	precachestring(&"MP_WAITING_FOR_HQ");
	if(getdvar("koth_autodestroytime") == "")
	{
		setdvar("koth_autodestroytime", "60");
	}

	level.hqautodestroytime = getdvarint("koth_autodestroytime");
	if(getdvar("koth_spawntime") == "")
	{
		setdvar("koth_spawntime", "0");
	}

	level.hqspawntime = getdvarint("koth_spawntime");
	if(getdvar("koth_kothmode") == "")
	{
		setdvar("koth_kothmode", "1");
	}

	level.kothmode = getdvarint("koth_kothmode");
	if(getdvar("koth_captureTime") == "")
	{
		setdvar("koth_captureTime", "20");
	}

	level.capturetime = getdvarint("koth_captureTime");
	if(getdvar("koth_destroyTime") == "")
	{
		setdvar("koth_destroyTime", "10");
	}

	level.destroytime = getdvarint("koth_destroyTime");
	if(getdvar("koth_delayPlayer") == "")
	{
		setdvar("koth_delayPlayer", 1);
	}

	level.delayplayer = getdvarint("koth_delayPlayer");
	if(getdvar("koth_spawnDelay") == "")
	{
		setdvar("koth_spawnDelay", 0);
	}

	level.spawndelay = getdvarint("koth_spawnDelay");
	if(getdvar("koth_extraDelay") == "")
	{
		setdvar("koth_extraDelay", 0);
	}

	level.extradelay = getdvarint("koth_extraDelay");
	setdvarifuninitialized("koth_proMode", 0);
	level.promode = getdvarint("koth_proMode");
	level.iconoffset = (0,0,32);
	level.onrespawndelay = ::getrespawndelay;
	game["dialog"]["gametype"] = "headquarters";
	if(getdvarint("g_hardcore"))
	{
		if(getmapcustom("allieschar") == "us_army")
		{
			game["dialog"]["allies_gametype"] = "hc_gtw";
		}

		if(getmapcustom("axischar") == "us_army")
		{
			game["dialog"]["axis_gametype"] = "hc_gtw";
		}

		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
		return;
	}

	if(getdvarint("camera_thirdPerson"))
	{
		game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
		return;
	}

	if(getdvarint("scr_diehard"))
	{
		game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
		return;
	}

	if(getdvarint("scr_" + level.gametype + "_promode"))
	{
		game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
		return;
	}
}

updateobjectivehintmessages(param_EE7, param_EE8)
{
	game["strings"]["objective_hint_allies"] = param_EE7;
	game["strings"]["objective_hint_axis"] = param_EE8;
	for(i = 0;i < level.players.size;i++)
	{
		player = level.players[i];
		if(isdefined(player.pers["team"]) && player.pers["team"] != "spectator")
		{
			hinttext = maps\mp\_utility::getobjectivehinttext(player.pers["team"]);
			player thread maps\mp\gametypes\_hud_message::hintmessage(hinttext);
		}
	}
}

getrespawndelay()
{
	maps\mp\_utility::clearlowermessage("hq_respawn");
	if(!isdefined(level.radioobject))
	{
		return undefined;
	}

	hqowningteam = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();
	if(self.pers["team"] == hqowningteam)
	{
		if(!isdefined(level.hqdestroytime))
		{
			return undefined;
		}

		if(!level.spawndelay)
		{
			return undefined;
		}

		timeremaining = level.hqdestroytime - gettime() / 1000;
		timeremaining = timeremaining + level.extradelay + 1;
		if(level.spawndelay >= level.hqautodestroytime)
		{
			maps\mp\_utility::setlowermessage("hq_respawn", &"MP_WAITING_FOR_HQ", undefined, 10);
		}

		if(!isalive(self))
		{
			self.forcespawnnearteammates = 1;
		}

		if(level.delayplayer)
		{
			return min(level.spawndelay, timeremaining);
		}

		return int(timeremaining) % level.spawndelay;
	}
}

onstartgametype()
{
	maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_KOTH");
	maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_KOTH");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_KOTH");
		maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_KOTH");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_KOTH_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_KOTH_SCORE");
	}

	level.objectivehintpreparehq = &"MP_CONTROL_HQ";
	level.objectivehintcapturehq = &"MP_CAPTURE_HQ";
	level.objectivehintdestroyhq = &"MP_DESTROY_HQ";
	level.objectivehintdefendhq = &"MP_DEFEND_HQ";
	precachestring(level.objectivehintpreparehq);
	precachestring(level.objectivehintcapturehq);
	precachestring(level.objectivehintdestroyhq);
	precachestring(level.objectivehintdefendhq);
	if(level.kothmode)
	{
		level.objectivehintdestroyhq = level.objectivehintcapturehq;
	}

	if(level.hqspawntime)
	{
		updateobjectivehintmessages(level.objectivehintpreparehq, level.objectivehintpreparehq);
	}
	else
	{
		updateobjectivehintmessages(level.objectivehintcapturehq, level.objectivehintcapturehq);
	}

	setclientnamemode("auto_change");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
	setmapcenter(level.mapcenter);
	level.spawn_all = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn");
	if(!level.spawn_all.size)
	{
		maps\mp\gametypes\_callbacksetup::abortlevel();
		return;
	}

	allowed[0] = "hq";
	maps\mp\gametypes\_gameobjects::main(allowed);
	thread setupradios();
	maps\mp\gametypes\_rank::registerscoreinfo("kill", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist", 10);
	maps\mp\gametypes\_rank::registerscoreinfo("defend", 10);
	maps\mp\gametypes\_rank::registerscoreinfo("assault", 10);
	maps\mp\gametypes\_rank::registerscoreinfo("capture", 250);
	thread hqmainloop();
}

hqmainloop()
{
	level endon("game_ended");
	level.hqrevealtime = -100000;
	hqspawninginstr = &"MP_HQ_AVAILABLE_IN";
	if(level.kothmode)
	{
		hqdestroyedinfriendlystr = &"MP_HQ_DESPAWN_IN";
		hqdestroyedinenemystr = &"MP_HQ_DESPAWN_IN";
	}
	else if(!level.splitscreen)
	{
		hqdestroyedinfriendlystr = &"MP_HQ_REINFORCEMENTS_IN";
		hqdestroyedinenemystr = &"MP_HQ_DESPAWN_IN";
	}
	else
	{
		hqdestroyedinfriendlystr = &"MP_HQ_REINFORCEMENTS_IN_SPLITSCREEN";
		hqdestroyedinenemystr = &"MP_HQ_DESPAWN_IN";
	}

	precachestring(hqspawninginstr);
	precachestring(hqdestroyedinfriendlystr);
	precachestring(hqdestroyedinenemystr);
	precachestring(&"MP_CAPTURING_HQ");
	precachestring(&"MP_DESTROYING_HQ");
	maps\mp\_utility::gameflagwait("prematch_done");
	wait 5;
	timerdisplay = [];
	timerdisplay["allies"] = maps\mp\gametypes\_hud_util::createservertimer("objective", 1.4, "allies");
	timerdisplay["allies"] maps\mp\gametypes\_hud_util::setpoint("TOPRIGHT", "TOPRIGHT", 0, 0);
	timerdisplay["allies"].label = hqspawninginstr;
	timerdisplay["allies"].alpha = 0;
	timerdisplay["allies"].archived = 0;
	timerdisplay["allies"].hidewheninmenu = 1;
	timerdisplay["axis"] = maps\mp\gametypes\_hud_util::createservertimer("objective", 1.4, "axis");
	timerdisplay["axis"] maps\mp\gametypes\_hud_util::setpoint("TOPRIGHT", "TOPRIGHT", 0, 0);
	timerdisplay["axis"].label = hqspawninginstr;
	timerdisplay["axis"].alpha = 0;
	timerdisplay["axis"].archived = 0;
	timerdisplay["axis"].hidewheninmenu = 1;
	level.timerdisplay = timerdisplay;
	thread hidetimerdisplayongameend(timerdisplay["allies"]);
	thread hidetimerdisplayongameend(timerdisplay["axis"]);
	locationobjid = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(locationobjid, "invisible", (0,0,0));
	for(;;)
	{
		radio = pickradiotospawn();
		radio makeradioactive();
		maps\mp\_utility::playsoundonplayers("mp_suitcase_pickup");
		maps\mp\_utility::leaderdialog("hq_located");
		radioobject = radio.gameobject;
		level.radioobject = radioobject;
		radioobject maps\mp\gametypes\_gameobjects::setmodelvisibility(1);
		level.hqrevealtime = gettime();
		if(level.hqspawntime)
		{
			nextobjpoint = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_next_hq", radio.origin + level.iconoffset, "all", "waypoint_targetneutral");
			nextobjpoint setwaypoint(1, 1);
			objective_position(locationobjid, radio.trigorigin);
			objective_icon(locationobjid, "waypoint_targetneutral");
			objective_state(locationobjid, "active");
			updateobjectivehintmessages(level.objectivehintpreparehq, level.objectivehintpreparehq);
			timerdisplay["allies"].label = hqspawninginstr;
			timerdisplay["allies"] settimer(level.hqspawntime);
			timerdisplay["allies"].alpha = 1;
			timerdisplay["axis"].label = hqspawninginstr;
			timerdisplay["axis"] settimer(level.hqspawntime);
			timerdisplay["axis"].alpha = 1;
			wait level.hqspawntime;
			maps\mp\gametypes\_objpoints::deleteobjpoint(nextobjpoint);
			objective_state(locationobjid, "invisible");
			maps\mp\_utility::leaderdialog("hq_online");
		}

		timerdisplay["allies"].alpha = 0;
		timerdisplay["axis"].alpha = 0;
		waittillframeend;
		maps\mp\_utility::leaderdialog("obj_capture");
		updateobjectivehintmessages(level.objectivehintcapturehq, level.objectivehintcapturehq);
		maps\mp\_utility::playsoundonplayers("mp_killstreak_radar");
		radioobject maps\mp\gametypes\_gameobjects::allowuse("any");
		radioobject maps\mp\gametypes\_gameobjects::setusetime(level.capturetime);
		radioobject maps\mp\gametypes\_gameobjects::setusetext(&"MP_CAPTURING_HQ");
		radioobject maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_captureneutral");
		radioobject maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_captureneutral");
		radioobject maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		radioobject maps\mp\gametypes\_gameobjects::setmodelvisibility(1);
		radioobject.onuse = ::onradiocapture;
		radioobject.onbeginuse = ::onbeginuse;
		radioobject.onenduse = ::onenduse;
		level waittill("hq_captured");
		ownerteam = radioobject maps\mp\gametypes\_gameobjects::getownerteam();
		otherteam = maps\mp\_utility::getotherteam(ownerteam);
		if(level.hqautodestroytime)
		{
			thread destroyhqaftertime(level.hqautodestroytime);
			timerdisplay[ownerteam] settimer(level.hqautodestroytime + level.extradelay);
			timerdisplay[otherteam] settimer(level.hqautodestroytime);
		}
		else
		{
			level.hqdestroyedbytimer = 0;
		}

		for(;;)
		{
			ownerteam = radioobject maps\mp\gametypes\_gameobjects::getownerteam();
			otherteam = maps\mp\_utility::getotherteam(ownerteam);
			if(ownerteam == "allies")
			{
				updateobjectivehintmessages(level.objectivehintdefendhq, level.objectivehintdestroyhq);
			}
			else
			{
				updateobjectivehintmessages(level.objectivehintdestroyhq, level.objectivehintdefendhq);
			}

			radioobject maps\mp\gametypes\_gameobjects::allowuse("enemy");
			radioobject maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defend");
			radioobject maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend");
			radioobject maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_capture");
			radioobject maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_capture");
			if(!level.kothmode)
			{
				radioobject maps\mp\gametypes\_gameobjects::setusetext(&"MP_DESTROYING_HQ");
			}

			radioobject.onuse = ::onradiodestroy;
			if(level.hqautodestroytime)
			{
				timerdisplay[ownerteam].label = hqdestroyedinfriendlystr;
				timerdisplay[ownerteam].alpha = 1;
				timerdisplay[otherteam].label = hqdestroyedinenemystr;
				timerdisplay[otherteam].alpha = 1;
			}

			level waittill("hq_destroyed");
			timerdisplay[otherteam].alpha = 0;
			if(!level.kothmode || level.hqdestroyedbytimer)
			{
				break;
			}

			thread forcespawnteam(ownerteam);
			radioobject maps\mp\gametypes\_gameobjects::setownerteam(maps\mp\_utility::getotherteam(ownerteam));
		}

		level notify("hq_reset");
		radioobject maps\mp\gametypes\_gameobjects::allowuse("none");
		radioobject maps\mp\gametypes\_gameobjects::setownerteam("neutral");
		radioobject maps\mp\gametypes\_gameobjects::setmodelvisibility(0);
		radio makeradioinactive();
		level.radioobject = undefined;
		thread forcespawnteam(ownerteam, level.extradelay);
		wait level.extradelay;
		wait max(1, 6 - level.extradelay);
	}
}

hidetimerdisplayongameend(timerdisplay)
{
	level waittill("game_ended");
	timerdisplay.alpha = 0;
}

forcespawnteam(team, extradelay)
{
	if(extradelay)
	{
		foreach(player in level.players)
		{
			if(isalive(player))
			{
				continue;
			}

			if(player.pers["team"] == team)
			{
				player maps\mp\_utility::setlowermessage("hq_respawn", game["strings"]["waiting_to_spawn"], extradelay);
			}
		}

		wait extradelay;
	}

	level.timerdisplay[team].alpha = 0;
	foreach(player in level.players)
	{
		if(player.pers["team"] == team)
		{
			player maps\mp\_utility::clearlowermessage("hq_respawn");
			if(!isalive(player))
			{
				player.forcespawnnearteammates = 1;
			}

			player notify("force_spawn");
		}
	}
}

onbeginuse(player)
{
	ownerteam = maps\mp\gametypes\_gameobjects::getownerteam();
	if(ownerteam == "neutral")
	{
		self.objpoints[player.pers["team"]] thread maps\mp\gametypes\_objpoints::startflashing();
		return;
	}

	self.objpoints["allies"] thread maps\mp\gametypes\_objpoints::startflashing();
	self.objpoints["axis"] thread maps\mp\gametypes\_objpoints::startflashing();
}

onenduse(team, player, success)
{
	self.objpoints["allies"] thread maps\mp\gametypes\_objpoints::stopflashing();
	self.objpoints["axis"] thread maps\mp\gametypes\_objpoints::stopflashing();
}

onradiocapture(player)
{
	team = player.pers["team"];
	player thread [[ level.onxpevent ]]("capture");
	maps\mp\gametypes\_gamescore::giveplayerscore("capture", player);
	player maps\mp\_utility::incplayerstat("hqscaptured", 1);
	player thread maps\mp\_matchdata::loggameevent("capture", player.origin);
	oldteam = maps\mp\gametypes\_gameobjects::getownerteam();
	maps\mp\gametypes\_gameobjects::setownerteam(team);
	if(!level.kothmode)
	{
		maps\mp\gametypes\_gameobjects::setusetime(level.destroytime);
	}

	otherteam = "axis";
	if(team == "axis")
	{
		otherteam = "allies";
	}

	maps\mp\_utility::teamplayercardsplash("callout_capturedhq", player);
	maps\mp\_utility::leaderdialog("hq_secured", team);
	maps\mp\_utility::leaderdialog("hq_enemy_captured", otherteam);
	thread maps\mp\_utility::playsoundonplayers("mp_war_objective_taken", team);
	thread maps\mp\_utility::playsoundonplayers("mp_war_objective_lost", otherteam);
	level thread awardhqpoints(team);
	player notify("objective", "captured");
	level notify("hq_captured");
}

onradiodestroy(player)
{
	team = player.pers["team"];
	otherteam = "axis";
	if(team == "axis")
	{
		otherteam = "allies";
	}

	player thread [[ level.onxpevent ]]("capture");
	maps\mp\gametypes\_gamescore::giveplayerscore("capture", player);
	player maps\mp\_utility::incplayerstat("hqsdestroyed", 1);
	player thread maps\mp\_matchdata::loggameevent("destroy", player.origin);
	if(level.kothmode)
	{
		maps\mp\_utility::teamplayercardsplash("callout_capturedhq", player);
		maps\mp\_utility::leaderdialog("hq_secured", team);
		maps\mp\_utility::leaderdialog("hq_enemy_captured", otherteam);
	}
	else
	{
		maps\mp\_utility::teamplayercardsplash("callout_destroyedhq", player);
		maps\mp\_utility::leaderdialog("hq_secured", team);
		maps\mp\_utility::leaderdialog("hq_enemy_destroyed", otherteam);
	}

	thread maps\mp\_utility::playsoundonplayers("mp_war_objective_taken", team);
	thread maps\mp\_utility::playsoundonplayers("mp_war_objective_lost", otherteam);
	level notify("hq_destroyed");
	if(level.kothmode)
	{
		level thread awardhqpoints(team);
		return;
	}
}

destroyhqaftertime(time)
{
	level endon("game_ended");
	level endon("hq_reset");
	level.hqdestroytime = gettime() + time * 1000;
	level.hqdestroyedbytimer = 0;
	wait time;
	level.hqdestroyedbytimer = 1;
	maps\mp\_utility::leaderdialog("hq_offline");
	level notify("hq_destroyed");
}

awardhqpoints(team)
{
	level endon("game_ended");
	level endon("hq_destroyed");
	level notify("awardHQPointsRunning");
	level endon("awardHQPointsRunning");
	steps = 12;
	baseline = 5;
	delta = 5;
	if(level.promode)
	{
		seconds = int(level.hqautodestroytime / steps);
	}
	else
	{
		seconds = 5;
	}

	curstep = 0;
	while(!level.gameended)
	{
		if(level.promode && level.hqautodestroytime)
		{
			maps\mp\gametypes\_gamescore::giveteamscoreforobjective(team, int(5 * curstep + 1));
		}
		else
		{
			maps\mp\gametypes\_gamescore::giveteamscoreforobjective(team, seconds);
		}

		for(index = 0;index < level.players.size;index++)
		{
			player = level.players[index];
			if(player.pers["team"] == team)
			{
				if(level.promode)
				{
					if(level.hqautodestroytime)
					{
						player thread maps\mp\gametypes\_rank::giverankxp("defend", int(baseline + delta * curstep));
					}
					else
					{
						player thread maps\mp\gametypes\_rank::giverankxp("defend", int(baseline + delta));
					}
				}
				else
				{
					player thread maps\mp\gametypes\_rank::giverankxp("defend");
				}

				if(isalive(player))
				{
					maps\mp\gametypes\_gamescore::giveplayerscore("defend", player);
				}
			}
		}

		curstep++;
		wait seconds;
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

getspawnpoint()
{
	spawnpoint = undefined;
	if(isdefined(level.radioobject))
	{
		hqowningteam = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();
		if(self.pers["team"] == hqowningteam)
		{
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_all, level.radioobject.nearspawns);
		}
		else
		{
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_all, level.radioobject.outerspawns);
		}
	}

	if(!isdefined(spawnpoint))
	{
		spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_all);
	}

	return spawnpoint;
}

onspawnplayer()
{
	maps\mp\_utility::clearlowermessage("hq_respawn");
	self.forcespawnnearteammates = undefined;
}

setupradios()
{
	maperrors = [];
	radios = getentarray("hq_hardpoint", "targetname");
	if(radios.size < 2)
	{
		maperrors[maperrors.size] = "There are not at least 2 entities with targetname \"radio\"";
	}

	trigs = getentarray("radiotrigger", "targetname");
	for(i = 0;i < radios.size;i++)
	{
		errored = 0;
		radio = radios[i];
		radio.trig = undefined;
		for(j = 0;j < trigs.size;j++)
		{
			if(radio istouching(trigs[j]))
			{
				if(isdefined(radio.trig))
				{
					maperrors[maperrors.size] = "Radio at " + radio.origin + " is touching more than one \"radiotrigger\" trigger";
					errored = 1;
					break;
				}

				radio.trig = trigs[j];
				break;
			}
		}

		if(!isdefined(radio.trig))
		{
			if(!errored)
			{
				maperrors[maperrors.size] = "Radio at " + radio.origin + " is not inside any \"radiotrigger\" trigger";
				continue;
			}
		}

		radio.trigorigin = radio.trig.origin;
		visuals = [];
		visuals[0] = radio;
		othervisuals = getentarray(radio.target, "targetname");
		for(j = 0;j < othervisuals.size;j++)
		{
			visuals[visuals.size] = othervisuals[j];
		}

		radio.visuals = visuals;
		radio maps\mp\gametypes\_gameobjects::setmodelvisibility(0);
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

	level.radios = radios;
	level.prevradio = undefined;
	level.prevradio2 = undefined;
	return 1;
}

makeradioactive()
{
	self.gameobject = maps\mp\gametypes\_gameobjects::createuseobject("neutral", self.trig, self.visuals, self.origin - self.trigorigin + level.iconoffset);
	self.gameobject maps\mp\gametypes\_gameobjects::setmodelvisibility(0);
	self.trig.useobj = self.gameobject;
	setupnearbyspawns();
}

makeradioinactive()
{
	self.gameobject maps\mp\gametypes\_gameobjects::deleteuseobject();
	self.gameobject = undefined;
}

setupnearbyspawns()
{
	spawns = level.spawn_all;
	for(i = 0;i < spawns.size;i++)
	{
		spawns[i].distsq = distancesquared(spawns[i].origin, self.origin);
	}

	for(i = 1;i < spawns.size;i++)
	{
		thespawn = spawns[i];
		for(j = i - 1;j >= 0 && thespawn.distsq < spawns[j].distsq;j--)
		{
			spawns[j + 1] = spawns[j];
		}

		spawns[j + 1] = thespawn;
	}

	first = [];
	outer = [];
	thirdsize = spawns.size / 3;
	for(i = 0;i < spawns.size;i++)
	{
		if(i <= thirdsize || spawns[i].distsq <= 490000)
		{
			first[first.size] = spawns[i];
		}

		if(i > thirdsize || spawns[i].distsq > 1000000)
		{
			if(outer.size < 10 || spawns[i].distsq < 2250000)
			{
				outer[outer.size] = spawns[i];
			}
		}
	}

	self.gameobject.nearspawns = first;
	self.gameobject.outerspawns = outer;
}

pickradiotospawn()
{
	validallies = [];
	validaxis = [];
	foreach(player in level.players)
	{
		if(player.team == "spectator")
		{
			continue;
		}

		if(!isalive(player))
		{
			continue;
		}

		player.dist = 0;
		if(player.team == "allies")
		{
			validallies[validallies.size] = player;
			continue;
		}

		validaxis[validaxis.size] = player;
	}

	if(!validallies.size || !validaxis.size)
	{
		radio = level.radios[randomint(level.radios.size)];
		while(isdefined(level.prevradio) && radio == level.prevradio)
		{
			radio = level.radios[randomint(level.radios.size)];
		}

		level.prevradio2 = level.prevradio;
		level.prevradio = radio;
		return radio;
	}

	for(i = 0;i < validallies.size;i++)
	{
		for(j = i + 1;j < validallies.size;j++)
		{
			dist = distancesquared(validallies[i].origin, validallies[j].origin);
			validallies[i].dist = validallies[i].dist + dist;
			validallies[j].dist = validallies[j].dist + dist;
		}
	}

	for(i = 0;i < validaxis.size;i++)
	{
		for(j = i + 1;j < validaxis.size;j++)
		{
			dist = distancesquared(validaxis[i].origin, validaxis[j].origin);
			validaxis[i].dist = validaxis[i].dist + dist;
			validaxis[j].dist = validaxis[j].dist + dist;
		}
	}

	bestplayer = validallies[0];
	foreach(player in validallies)
	{
		if(player.dist < bestplayer.dist)
		{
			bestplayer = player;
		}
	}

	avgpos["allies"] = bestplayer.origin;
	bestplayer = validaxis[0];
	foreach(player in validaxis)
	{
		if(player.dist < bestplayer.dist)
		{
			bestplayer = player;
		}
	}

	avgpos["axis"] = validaxis[0].origin;
	bestradio = undefined;
	lowestcost = undefined;
	for(i = 0;i < level.radios.size;i++)
	{
		radio = level.radios[i];
		cost = abs(distance(radio.origin, avgpos["allies"]) - distance(radio.origin, avgpos["axis"]));
		if(isdefined(level.prevradio) && radio == level.prevradio)
		{
			continue;
		}

		if(isdefined(level.prevradio2) && radio == level.prevradio2)
		{
			if(level.radios.size > 2)
			{
				continue;
			}
			else
			{
				cost = cost + 512;
			}
		}

		if(!isdefined(lowestcost) || cost < lowestcost)
		{
			lowestcost = cost;
			bestradio = radio;
		}
	}

	level.prevradio2 = level.prevradio;
	level.prevradio = bestradio;
	return bestradio;
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration, killid)
{
	if(!isplayer(attacker) || !self.touchtriggers.size && !attacker.touchtriggers.size || attacker.pers["team"] == self.pers["team"])
	{
		return;
	}

	if(self.touchtriggers.size)
	{
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

			team = self.pers["team"];
			if(team == ownerteam)
			{
				attacker thread [[ level.onxpevent ]]("assault");
				maps\mp\gametypes\_gamescore::giveplayerscore("assault", attacker);
				thread maps\mp\_matchdata::logkillevent(killid, "defending");
				continue;
			}

			attacker thread [[ level.onxpevent ]]("defend");
			maps\mp\gametypes\_gamescore::giveplayerscore("defend", attacker);
			thread maps\mp\_matchdata::logkillevent(killid, "assaulting");
		}
	}

	if(attacker.touchtriggers.size)
	{
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
				team = attacker.pers["team"];
			}

			if(team == ownerteam)
			{
				attacker thread [[ level.onxpevent ]]("defend");
				maps\mp\gametypes\_gamescore::giveplayerscore("defend", attacker);
				thread maps\mp\_matchdata::logkillevent(killid, "assaulting");
				continue;
			}

			attacker thread [[ level.onxpevent ]]("assault");
			maps\mp\gametypes\_gamescore::giveplayerscore("assault", attacker);
			thread maps\mp\_matchdata::logkillevent(killid, "defending");
		}

		return;
	}
}

initgametypeawards()
{
	maps\mp\_awards::initstataward("hqsdestroyed", 0, ::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("hqscaptured", 0, ::maps\mp\_awards::highestwins);
}