/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\sd.gsc
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
	maps\mp\_utility::registerroundswitchdvar(level.gametype, 3, 0, 9);
	maps\mp\_utility::registertimelimitdvar(level.gametype, 2.5, 0, 1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype, 1, 0, 500);
	maps\mp\_utility::registerroundlimitdvar(level.gametype, 0, 0, 12);
	maps\mp\_utility::registerwinlimitdvar(level.gametype, 4, 0, 12);
	maps\mp\_utility::registernumlivesdvar(level.gametype, 1, 0, 10);
	maps\mp\_utility::registerhalftimedvar(level.gametype, 0, 0, 1);
	level.objectivebased = 1;
	level.teambased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	level.ononeleftevent = ::ononeleftevent;
	level.ontimelimit = ::ontimelimit;
	level.onnormaldeath = ::onnormaldeath;
	level.initgametypeawards = ::initgametypeawards;
	game["dialog"]["gametype"] = "searchdestroy";
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
}

onprecachegametype()
{
	game["bomb_dropped_sound"] = "mp_war_objective_lost";
	game["bomb_recovered_sound"] = "mp_war_objective_taken";
	precacheshader("waypoint_bomb");
	precacheshader("hud_suitcase_bomb");
	precacheshader("waypoint_target");
	precacheshader("waypoint_target_a");
	precacheshader("waypoint_target_b");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_defend_a");
	precacheshader("waypoint_defend_b");
	precacheshader("waypoint_defuse");
	precacheshader("waypoint_defuse_a");
	precacheshader("waypoint_defuse_b");
	precacheshader("waypoint_escort");
	precachestring(&"MP_EXPLOSIVES_RECOVERED_BY");
	precachestring(&"MP_EXPLOSIVES_DROPPED_BY");
	precachestring(&"MP_EXPLOSIVES_PLANTED_BY");
	precachestring(&"MP_EXPLOSIVES_DEFUSED_BY");
	precachestring(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	precachestring(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	precachestring(&"MP_CANT_PLANT_WITHOUT_BOMB");
	precachestring(&"MP_PLANTING_EXPLOSIVE");
	precachestring(&"MP_DEFUSING_EXPLOSIVE");
}

onstartgametype()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(game["switchedsides"])
	{
		oldattackers = game["attackers"];
		olddefenders = game["defenders"];
		game["attackers"] = olddefenders;
		game["defenders"] = oldattackers;
	}

	setclientnamemode("manual_change");
	game["strings"]["target_destroyed"] = &"MP_TARGET_DESTROYED";
	game["strings"]["bomb_defused"] = &"MP_BOMB_DEFUSED";
	precachestring(game["strings"]["target_destroyed"]);
	precachestring(game["strings"]["bomb_defused"]);
	level._effect["bombexplosion"] = loadfx("explosions/tanker_explosion");
	maps\mp\_utility::setobjectivetext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
	maps\mp\_utility::setobjectivetext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
		maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT");
	maps\mp\_utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sd_spawn_attacker");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sd_spawn_defender");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
	setmapcenter(level.mapcenter);
	baseweapon = baseweapon[0];
	baseweapon[1] = "bombzone";
	baseweapon[2] = "blocker";
	maps\mp\gametypes\_gameobjects::main(baseweapon);
	maps\mp\gametypes\_rank::registerscoreinfo("win", 2);
	maps\mp\gametypes\_rank::registerscoreinfo("loss", 1);
	maps\mp\gametypes\_rank::registerscoreinfo("tie", 1.5);
	maps\mp\gametypes\_rank::registerscoreinfo("kill", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist", 20);
	maps\mp\gametypes\_rank::registerscoreinfo("plant", 100);
	maps\mp\gametypes\_rank::registerscoreinfo("defuse", 100);
	thread updategametypedvars();
	thread bombs();
}

getspawnpoint()
{
	if(self.pers["team"] == game["attackers"])
	{
		spawnpointname = "mp_sd_spawn_attacker";
	}
	else
	{
		spawnpointname = "mp_sd_spawn_defender";
	}

	spawnpoints = maps\mp\gametypes\_spawnlogic::getspawnpointarray(spawnpointname);
	spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(spawnpoints);
	return spawnpoint;
}

onspawnplayer()
{
	self.isplanting = 0;
	self.isdefusing = 0;
	self.isbombcarrier = 0;
	if(level.multibomb && !isdefined(self.carryicon) && self.pers["team"] == game["attackers"] && !level.bombplanted)
	{
		if(level.splitscreen)
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon("hud_suitcase_bomb", 33, 33);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", 0, -78);
			self.carryicon.alpha = 0.75;
		}
		else
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon("hud_suitcase_bomb", 50, 50);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", -90, -65);
			self.carryicon.alpha = 0.75;
		}
	}

	level notify("spawned_player");
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration, killid)
{
	thread checkallowspectating();
}

checkallowspectating()
{
	wait 0.05;
	update = 0;
	if(!level.alivecount[game["attackers"]])
	{
		level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
		update = 1;
	}

	if(!level.alivecount[game["defenders"]])
	{
		level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
		update = 1;
	}

	if(update)
	{
		maps\mp\gametypes\_spectating::updatespectatesettings();
		return;
	}
}

sd_endgame(winningteam, param_573)
{
	thread maps\mp\gametypes\_gamelogic::endgame(winningteam, param_573);
}

ondeadevent(team)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	if(team == "all")
	{
		if(level.bombplanted)
		{
			sd_endgame(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
			return;
		}

		sd_endgame(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(team == game["attackers"])
	{
		if(level.bombplanted)
		{
			return;
		}

		level thread sd_endgame(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(team == game["defenders"])
	{
		level thread sd_endgame(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
		return;
	}
}

ononeleftevent(team)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	lastplayer = maps\mp\_utility::getlastlivingplayer(team);
	lastplayer thread givelastonteamwarning();
}

onnormaldeath(victim, attacker, lifeid)
{
	score = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
	team = victim.team;
	if(game["state"] == "postgame" && victim.team == game["defenders"] || !level.bombplanted)
	{
		attacker.finalkill = 1;
	}

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
	maps\mp\gametypes\_missions::lastmansd();
}

ontimelimit()
{
	sd_endgame(game["defenders"], game["strings"]["time_limit_reached"]);
}

updategametypedvars()
{
	level.planttime = maps\mp\_utility::dvarfloatvalue("planttime", 5, 0, 20);
	level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime", 5, 0, 20);
	level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer", 45, 1, 300);
	level.multibomb = maps\mp\_utility::dvarintvalue("multibomb", 0, 0, 1);
}

bombs()
{
	level.bombplanted = 0;
	level.bombdefused = 0;
	level.bombexploded = 0;
	trigger = getent("sd_bomb_pickup_trig", "targetname");
	if(!isdefined(trigger))
	{
		common_scripts\utility::error("No sd_bomb_pickup_trig trigger found in map.");
		return;
	}

	visuals[0] = getent("sd_bomb", "targetname");
	if(!isdefined(visuals[0]))
	{
		common_scripts\utility::error("No sd_bomb script_model found in map.");
		return;
	}

	precachemodel("prop_suitcase_bomb");
	visuals[0] setmodel("prop_suitcase_bomb");
	if(!level.multibomb)
	{
		level.sdbomb = maps\mp\gametypes\_gameobjects::createcarryobject(game["attackers"], trigger, visuals, (0,0,32));
		level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry("friendly");
		level.sdbomb maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_bomb");
		level.sdbomb maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_bomb");
		level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
		level.sdbomb maps\mp\gametypes\_gameobjects::setcarryicon("hud_suitcase_bomb");
		level.sdbomb.allowweapons = 1;
		level.sdbomb.onpickup = ::onpickup;
		level.sdbomb.ondrop = ::ondrop;
	}
	else
	{
		trigger delete();
		visuals[0] delete();
	}

	level.bombzones = [];
	bombzones = getentarray("bombzone", "targetname");
	for(index = 0;index < bombzones.size;index++)
	{
		trigger = bombzones[index];
		visuals = getentarray(bombzones[index].target, "targetname");
		bombzone = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"], trigger, visuals, (0,0,64));
		bombzone maps\mp\gametypes\_gameobjects::allowuse("enemy");
		bombzone maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
		bombzone maps\mp\gametypes\_gameobjects::setusetext(&"MP_PLANTING_EXPLOSIVE");
		bombzone maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
		if(!level.multibomb)
		{
			bombzone maps\mp\gametypes\_gameobjects::setkeyobject(level.sdbomb);
		}

		label = bombzone maps\mp\gametypes\_gameobjects::getlabel();
		bombzone.label = label;
		bombzone maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defend" + label);
		bombzone maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend" + label);
		bombzone maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_target" + label);
		bombzone maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_target" + label);
		bombzone maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		bombzone.onbeginuse = ::onbeginuse;
		bombzone.onenduse = ::onenduse;
		bombzone.onuse = ::onuseplantobject;
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

		level.bombzones[level.bombzones.size] = bombzone;
		bombzone.bombdefusetrig = getent(visuals[0].target, "targetname");
		bombzone.bombdefusetrig.origin = bombzone.bombdefusetrig.origin + (0,0,-10000);
		bombzone.bombdefusetrig.label = label;
	}

	for(index = 0;index < level.bombzones.size;index++)
	{
		array = [];
		for(otherindex = 0;otherindex < level.bombzones.size;otherindex++)
		{
			if(otherindex != index)
			{
				array[array.size] = level.bombzones[otherindex];
			}
		}

		level.bombzones[index].otherbombzones = array;
	}
}

onbeginuse(player)
{
	if(maps\mp\gametypes\_gameobjects::isfriendlyteam(player.pers["team"]))
	{
		player playsound("mp_bomb_defuse");
		player.isdefusing = 1;
		if(isdefined(level.sdbombmodel))
		{
			level.sdbombmodel hide();
			return;
		}

		return;
	}

	player.isplanting = 1;
	if(level.multibomb)
	{
		for(i = 0;i < self.otherbombzones.size;i++)
		{
			self.otherbombzones[i] maps\mp\gametypes\_gameobjects::allowuse("none");
			self.otherbombzones[i] maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
		}

		return;
	}
}

onenduse(team, player, result)
{
	if(!isdefined(player))
	{
		return;
	}

	if(isalive(player))
	{
		player.isdefusing = 0;
		player.isplanting = 0;
	}

	if(maps\mp\gametypes\_gameobjects::isfriendlyteam(player.pers["team"]))
	{
		if(isdefined(level.sdbombmodel) && !result)
		{
			level.sdbombmodel show();
			return;
		}

		return;
	}

	if(level.multibomb && !result)
	{
		for(i = 0;i < self.otherbombzones.size;i++)
		{
			self.otherbombzones[i] maps\mp\gametypes\_gameobjects::allowuse("enemy");
			self.otherbombzones[i] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		}

		return;
	}
}

oncantuse(player)
{
	player iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

onuseplantobject(player)
{
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(player.pers["team"]))
	{
		level thread bombplanted(self, player);
		for(index = 0;index < level.bombzones.size;index++)
		{
			if(level.bombzones[index] == self)
			{
				continue;
			}

			level.bombzones[index] maps\mp\gametypes\_gameobjects::disableobject();
		}

		player playsound("mp_bomb_plant");
		player notify("bomb_planted");
		maps\mp\_utility::leaderdialog("bomb_planted");
		level thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted", player);
		level.bombowner = player;
		player thread maps\mp\gametypes\_hud_message::splashnotify("plant", maps\mp\gametypes\_rank::getscoreinfovalue("plant"));
		player thread maps\mp\gametypes\_rank::giverankxp("plant");
		player.bombplantedtime = gettime();
		maps\mp\gametypes\_gamescore::giveplayerscore("plant", player);
		player maps\mp\_utility::incplayerstat("bombsplanted", 1);
		player thread maps\mp\_matchdata::loggameevent("plant", player.origin);
		return;
	}
}

onusedefuseobject(player)
{
	player notify("bomb_defused");
	level thread bombdefused();
	maps\mp\gametypes\_gameobjects::disableobject();
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
}

ondrop(player)
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_bomb");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_bomb");
	maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"], game["attackers"]);
}

onpickup(player)
{
	player.isbombcarrier = 1;
	player maps\mp\_utility::incplayerstat("bombscarried", 1);
	player thread maps\mp\_matchdata::loggameevent("pickup", player.origin);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_escort");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_escort");
	if(!level.bombdefused)
	{
		maps\mp\_utility::teamplayercardsplash("callout_bombtaken", player, player.team);
		maps\mp\_utility::leaderdialog("bomb_taken", player.pers["team"]);
	}

	maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"], game["attackers"]);
}

onreset()
{
}

bombplanted(param_EAE, player)
{
	maps\mp\gametypes\_gamelogic::pausetimer();
	level.bombplanted = 1;
	param_EAE.visuals[0] thread maps\mp\gametypes\_gamelogic::playtickingsound();
	level.tickingobject = param_EAE.visuals[0];
	level.timelimitoverride = 1;
	setgameendtime(int(gettime() + level.bombtimer * 1000));
	setdvar("ui_bomb_timer", 1);
	if(!level.multibomb)
	{
		level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry("none");
		level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
		level.sdbomb maps\mp\gametypes\_gameobjects::setdropped();
		level.sdbombmodel = level.sdbomb.visuals[0];
	}
	else
	{
		for(index = 0;index < level.players.size;index++)
		{
			if(isdefined(level.players[index].carryicon))
			{
				level.players[index].carryicon maps\mp\gametypes\_hud_util::destroyelem();
			}
		}

		trace = bullettrace(player.origin + (0,0,20), player.origin - (0,0,2000), 0, player);
		tempangle = randomfloat(360);
		forward = (cos(tempangle),sin(tempangle),0);
		forward = vectornormalize(forward - common_scripts\utility::vector_multiply(trace["normal"], vectordot(forward, trace["normal"])));
		dropangles = vectortoangles(forward);
		level.sdbombmodel = spawn("script_model", trace["position"]);
		level.sdbombmodel.angles = dropangles;
		level.sdbombmodel setmodel("prop_suitcase_bomb");
	}

	param_EAE maps\mp\gametypes\_gameobjects::allowuse("none");
	param_EAE maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	label = param_EAE maps\mp\gametypes\_gameobjects::getlabel();
	trigger = param_EAE.bombdefusetrig;
	trigger.origin = level.sdbombmodel.origin;
	visuals = [];
	defuseobject = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"], trigger, visuals, (0,0,32));
	defuseobject maps\mp\gametypes\_gameobjects::allowuse("friendly");
	defuseobject maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
	defuseobject maps\mp\gametypes\_gameobjects::setusetext(&"MP_DEFUSING_EXPLOSIVE");
	defuseobject maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	defuseobject maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	defuseobject maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defuse" + label);
	defuseobject maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_defend" + label);
	defuseobject maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defuse" + label);
	defuseobject maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_defend" + label);
	defuseobject.label = label;
	defuseobject.onbeginuse = ::onbeginuse;
	defuseobject.onenduse = ::onenduse;
	defuseobject.onuse = ::onusedefuseobject;
	defuseobject.useweapon = "briefcase_bomb_defuse_mp";
	bombtimerwait();
	setdvar("ui_bomb_timer", 0);
	param_EAE.visuals[0] maps\mp\gametypes\_gamelogic::stoptickingsound();
	if(level.gameended || level.bombdefused)
	{
		return;
	}

	level.bombexploded = 1;
	explosionorigin = level.sdbombmodel.origin;
	level.sdbombmodel hide();
	if(isdefined(player))
	{
		param_EAE.visuals[0] radiusdamage(explosionorigin, 512, 200, 20, player);
		player maps\mp\_utility::incplayerstat("targetsdestroyed", 1);
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

	for(index = 0;index < level.bombzones.size;index++)
	{
		level.bombzones[index] maps\mp\gametypes\_gameobjects::disableobject();
	}

	defuseobject maps\mp\gametypes\_gameobjects::disableobject();
	setgameendtime(0);
	wait 3;
	sd_endgame(game["attackers"], game["strings"]["target_destroyed"]);
}

bombtimerwait()
{
	level endon("game_ended");
	level endon("bomb_defused");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

bombdefused()
{
	level.tickingobject maps\mp\gametypes\_gamelogic::stoptickingsound();
	level.bombdefused = 1;
	setdvar("ui_bomb_timer", 0);
	level notify("bomb_defused");
	wait 1.5;
	setgameendtime(0);
	sd_endgame(game["defenders"], game["strings"]["bomb_defused"]);
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