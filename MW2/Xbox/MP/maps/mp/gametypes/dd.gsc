/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dd.gsc
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
	maps\mp\_utility::registerroundswitchdvar(level.gametype, 1, 0, 9);
	maps\mp\_utility::registertimelimitdvar(level.gametype, 3, 0, 1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype, 0, 0, 500);
	maps\mp\_utility::registerroundlimitdvar(level.gametype, 3, 0, 12);
	maps\mp\_utility::registerwinlimitdvar(level.gametype, 2, 0, 12);
	maps\mp\_utility::registernumlivesdvar(level.gametype, 0, 0, 10);
	maps\mp\_utility::registerhalftimedvar(level.gametype, 0, 0, 1);
	level.objectivebased = 1;
	level.teambased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.ondeadevent = ::ondeadevent;
	level.ontimelimit = ::ontimelimit;
	level.onnormaldeath = ::onnormaldeath;
	level.initgametypeawards = ::initgametypeawards;
	level.dd = 1;
	level.bombsplanted = 0;
	level.ddbombmodel = [] setbombtimerdvar();
	makedvarserverinfo("ui_bombtimer_a", -1);
	makedvarserverinfo("ui_bombtimer_b", -1);
	game["dialog"]["gametype"] = "demolition";
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
	precacheshader("waypoint_defuse_a");
	precacheshader("waypoint_defuse_b");
	precacheshader("waypoint_target");
	precacheshader("waypoint_target_a");
	precacheshader("waypoint_target_b");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_defend_a");
	precacheshader("waypoint_defend_b");
	precacheshader("waypoint_defuse");
	precacheshader("waypoint_defuse_a");
	precacheshader("waypoint_defuse_b");
	precachestring(&"MP_EXPLOSIVES_RECOVERED_BY");
	precachestring(&"MP_EXPLOSIVES_DROPPED_BY");
	precachestring(&"MP_EXPLOSIVES_PLANTED_BY");
	precachestring(&"MP_EXPLOSIVES_DEFUSED_BY");
	precachestring(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	precachestring(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	precachestring(&"MP_CANT_PLANT_WITHOUT_BOMB");
	precachestring(&"MP_PLANTING_EXPLOSIVE");
	precachestring(&"MP_DEFUSING_EXPLOSIVE");
	precachestring(&"MP_BOMB_A_TIMER");
	precachestring(&"MP_BOMB_B_TIMER");
	precachestring(&"MP_BOMBSITE_IN_USE");
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

	level.usestartspawns = 1;
	setclientnamemode("manual_change");
	game["strings"]["target_destroyed"] = &"MP_TARGET_DESTROYED";
	game["strings"]["bomb_defused"] = &"MP_BOMB_DEFUSED";
	precachestring(game["strings"]["target_destroyed"]);
	precachestring(game["strings"]["bomb_defused"]);
	level._effect["bombexplosion"] = loadfx("explosions/tanker_explosion");
	maps\mp\_utility::setobjectivetext(game["attackers"], &"OBJECTIVES_DD_ATTACKER");
	maps\mp\_utility::setobjectivetext(game["defenders"], &"OBJECTIVES_DD_DEFENDER");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_DD_ATTACKER");
		maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_DD_DEFENDER");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"], &"OBJECTIVES_DD_ATTACKER_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"], &"OBJECTIVES_DD_DEFENDER_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext(game["attackers"], &"OBJECTIVES_DD_ATTACKER_HINT");
	maps\mp\_utility::setobjectivehinttext(game["defenders"], &"OBJECTIVES_DD_DEFENDER_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn_defender");
	maps\mp\gametypes\_spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn_defender_a", 1);
	maps\mp\gametypes\_spawnlogic::addspawnpoints(game["defenders"], "mp_dd_spawn_defender_b", 1);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_dd_spawn_defender_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn_attacker");
	maps\mp\gametypes\_spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn_attacker_a", 1);
	maps\mp\gametypes\_spawnlogic::addspawnpoints(game["attackers"], "mp_dd_spawn_attacker_b", 1);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_dd_spawn_attacker_start");
	level.spawn_defenders = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_defender");
	level.spawn_defenders_a = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_defender_a");
	level.spawn_defenders_a = common_scripts\utility::array_combine(level.spawn_defenders, level.spawn_defenders_a);
	level.spawn_defenders_b = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_defender_b");
	level.spawn_defenders_b = common_scripts\utility::array_combine(level.spawn_defenders, level.spawn_defenders_b);
	level.spawn_attackers = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_attacker");
	level.spawn_attackers_a = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_a");
	level.spawn_attackers_a = common_scripts\utility::array_combine(level.spawn_attackers, level.spawn_attackers_a);
	level.spawn_attackers_b = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_b");
	level.spawn_attackers_b = common_scripts\utility::array_combine(level.spawn_attackers, level.spawn_attackers_b);
	level.spawn_defenders_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_defender_start");
	level.spawn_attackers_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn_attacker_start");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
	level.aplanted = 0;
	level.bplanted = 0;
	setmapcenter(level.mapcenter);
	maps\mp\gametypes\_rank::registerscoreinfo("win", 2);
	maps\mp\gametypes\_rank::registerscoreinfo("loss", 1);
	maps\mp\gametypes\_rank::registerscoreinfo("tie", 1.5);
	maps\mp\gametypes\_rank::registerscoreinfo("kill", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist", 20);
	maps\mp\gametypes\_rank::registerscoreinfo("plant", 100);
	maps\mp\gametypes\_rank::registerscoreinfo("defuse", 100);
	thread updategametypedvars();
	thread waittoprocess();
	winlimit = maps\mp\_utility::getwatcheddvar("winlimit");
	allowed[0] = "dd";
	bombzones = getentarray("dd_bombzone", "targetname");
	if(bombzones.size)
	{
		allowed[1] = "dd_bombzone";
	}
	else
	{
		allowed[1] = "bombzone";
	}

	allowed[2] = "blocker";
	maps\mp\gametypes\_gameobjects::main(allowed);
	thread bombs();
}

waittoprocess()
{
	level endon("game_end");
	for(;;)
	{
		if(level.ingraceperiod == 0)
		{
			break;
		}

		wait 0.05;
	}

	level.usestartspawns = 0;
}

getspawnpoint()
{
	spawnteam = self.pers["team"];
	if(level.usestartspawns)
	{
		if(spawnteam == game["attackers"])
		{
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_attackers_start);
		}
		else
		{
			spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_defenders_start);
		}
	}
	else if(spawnteam == game["attackers"])
	{
		if(!level.aplanted && !level.bplanted)
		{
			spawnpoints = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(spawnteam);
		}
		else if(level.aplanted && !level.bplanted)
		{
			spawnpoints = level.spawn_attackers_a;
		}
		else if(level.bplanted && !level.aplanted)
		{
			spawnpoints = level.spawn_attackers_b;
		}
		else
		{
			spawnpoints = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(spawnteam);
		}

		spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(spawnpoints);
	}
	else
	{
		if(!level.aplanted && !level.bplanted)
		{
			spawnpoints = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(spawnteam);
		}
		else if(level.aplanted && !level.bplanted)
		{
			spawnpoints = level.spawn_defenders_a;
		}
		else if(level.bplanted && !level.aplanted)
		{
			spawnpoints = level.spawn_defenders_b;
		}
		else
		{
			spawnpoints = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(spawnteam);
		}

		spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(spawnpoints);
	}

	return spawnpoint;
}

onspawnplayer()
{
	if(self.pers["team"] == game["attackers"])
	{
		self.isplanting = 0;
		self.isdefusing = 0;
		self.isbombcarrier = 1;
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
	else
	{
		self.isplanting = 0;
		self.isdefusing = 0;
		self.isbombcarrier = 0;
		if(isdefined(self.carryicon))
		{
			self.carryicon destroy();
		}
	}

	level notify("spawned_player");
}

dd_endgame(winningteam, param_573)
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
			dd_endgame(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
			return;
		}

		dd_endgame(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(team == game["attackers"])
	{
		if(level.bombplanted)
		{
			return;
		}

		level thread dd_endgame(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(team == game["defenders"])
	{
		level thread dd_endgame(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
		return;
	}
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
		return;
	}

	if(victim.isdefusing)
	{
		thread maps\mp\_matchdata::logkillevent(lifeid, "defusing");
		return;
	}
}

ontimelimit()
{
	dd_endgame(game["defenders"], game["strings"]["time_limit_reached"]);
}

updategametypedvars()
{
	level.planttime = maps\mp\_utility::dvarfloatvalue("planttime", 5, 0, 20);
	level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime", 5, 0, 20);
	level.bombtimer = maps\mp\_utility::dvarintvalue("bombtimer", 45, 1, 300);
	level.ddtimetoadd = maps\mp\_utility::dvarfloatvalue("addtime", 2, 0, 5);
}

bombs()
{
	level.bombplanted = 0;
	level.bombdefused = 0;
	level.bombexploded = 0;
	level.bombzones = [];
	bombzones = getentarray("dd_bombzone", "targetname");
	if(!bombzones.size)
	{
		bombzones = getentarray("bombzone", "targetname");
	}

	for(index = 0;index < bombzones.size;index++)
	{
		trigger = bombzones[index];
		visuals = getentarray(bombzones[index].target, "targetname");
		bombzone = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"], trigger, visuals, (0,0,64));
		bombzone maps\mp\gametypes\_gameobjects::allowuse("enemy");
		bombzone maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
		bombzone maps\mp\gametypes\_gameobjects::setusetext(&"MP_PLANTING_EXPLOSIVE");
		bombzone maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
		bombzone maps\mp\gametypes\_gameobjects::setkeyobject(level.ddbomb);
		label = bombzone maps\mp\gametypes\_gameobjects::getlabel();
		bombzone.label = label;
		bombzone.index = index;
		bombzone maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defend" + label);
		bombzone maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend" + label);
		bombzone maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_target" + label);
		bombzone maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_target" + label);
		bombzone maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		bombzone.onbeginuse = ::onbeginuse;
		bombzone.onenduse = ::onenduse;
		bombzone.onuse = ::onuseobject;
		bombzone.oncantuse = ::oncantuse;
		bombzone.useweapon = "briefcase_bomb_mp";
		bombzone.visuals[0].killcament = spawn("script_model", bombzone.visuals[0].origin + (0,0,128));
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

onuseobject(player)
{
	team = player.pers["team"];
	otherteam = level.otherteam[team];
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(player.pers["team"]))
	{
		player notify("bomb_planted");
		player playsound("mp_bomb_plant");
		thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted", player);
		maps\mp\_utility::leaderdialog("bomb_planted");
		player thread maps\mp\gametypes\_hud_message::splashnotify("plant", maps\mp\gametypes\_rank::getscoreinfovalue("plant"));
		player thread maps\mp\gametypes\_rank::giverankxp("plant");
		maps\mp\gametypes\_gamescore::giveplayerscore("plant", player);
		player maps\mp\_utility::incplayerstat("bombsplanted", 1);
		player thread maps\mp\_matchdata::loggameevent("plant", player.origin);
		player.bombplantedtime = gettime();
		level thread bombplanted(self, player);
		level.bombowner = player;
		self.useweapon = "briefcase_bomb_defuse_mp";
		setupfordefusing();
		return;
	}

	thread bombhandler(player, "defused");
}

resetbombzone()
{
	maps\mp\gametypes\_gameobjects::allowuse("enemy");
	maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
	maps\mp\gametypes\_gameobjects::setusetext(&"MP_PLANTING_EXPLOSIVE");
	maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	maps\mp\gametypes\_gameobjects::setkeyobject(level.ddbomb);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defend" + self.label);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defend" + self.label);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_target" + self.label);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_target" + self.label);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	self.useweapon = "briefcase_bomb_mp";
}

setupfordefusing()
{
	maps\mp\gametypes\_gameobjects::allowuse("friendly");
	maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
	maps\mp\gametypes\_gameobjects::setusetext(&"MP_DEFUSING_EXPLOSIVE");
	maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	maps\mp\gametypes\_gameobjects::setkeyobject(undefined);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly", "waypoint_defuse" + self.label);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly", "waypoint_defuse" + self.label);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy", "waypoint_defend" + self.label);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy", "waypoint_defend" + self.label);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
}

onbeginuse(player)
{
	if(maps\mp\gametypes\_gameobjects::isfriendlyteam(player.pers["team"]))
	{
		player playsound("mp_bomb_defuse");
		player.isdefusing = 1;
		bestdistance = 9000000;
		closestbomb = undefined;
		if(isdefined(level.ddbombmodel))
		{
			foreach(bomb in level.ddbombmodel)
			{
				if(!isdefined(bomb))
				{
					continue;
				}

				dist = distancesquared(player.origin, bomb.origin);
				if(dist < bestdistance)
				{
					bestdistance = dist;
					closestbomb = bomb;
				}
			}

			player.defusing = closestbomb;
			closestbomb hide();
			return;
		}

		return;
	}

	player.isplanting = 1;
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
		if(isdefined(player.defusing) && !result)
		{
			player.defusing show();
			return;
		}

		return;
	}
}

oncantuse(player)
{
	player iprintlnbold(&"MP_BOMBSITE_IN_USE");
}

onreset()
{
}

bombplanted(param_EAE, player)
{
	param_EAE endon("defused");
	level.bombsplanted = level.bombsplanted + 1;
	setbombtimerdvar();
	maps\mp\gametypes\_gamelogic::pausetimer();
	level.timepausestart = gettime();
	level.timelimitoverride = 1;
	level.bombplanted = 1;
	level.destroyedobject = param_EAE;
	if(level.destroyedobject.label == "_a")
	{
		level.aplanted = 1;
	}
	else
	{
		level.bplanted = 1;
	}

	level.destroyedobject.bombplanted = 1;
	param_EAE.visuals[0] thread playdemolitiontickingsound(param_EAE);
	level.tickingobject = param_EAE.visuals[0];
	dropbombmodel(player, param_EAE.label);
	param_EAE.bombdefused = 0;
	param_EAE maps\mp\gametypes\_gameobjects::allowuse("none");
	param_EAE maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	param_EAE setupfordefusing();
	param_EAE bombtimerwait(param_EAE);
	param_EAE thread bombhandler(player, "explode");
}

bombhandler(player, param_F27)
{
	self.visuals[0] notify("stopTicking");
	level.bombsplanted = level.bombsplanted - 1;
	if(self.label == "_a")
	{
		level.aplanted = 0;
	}
	else
	{
		level.bplanted = 0;
	}

	self.bombplanted = 0;
	restarttimer();
	setbombtimerdvar();
	setdvar("ui_bombtimer" + self.label, -1);
	if(level.gameended)
	{
		return;
	}

	if(param_F27 == "explode")
	{
		level.bombexploded = level.bombexploded + 1;
		explosionorigin = self.curorigin;
		level.ddbombmodel[self.label] delete();
		if(isdefined(player))
		{
			self.visuals[0] radiusdamage(explosionorigin, 512, 200, 20, player);
			player maps\mp\_utility::incplayerstat("targetsdestroyed", 1);
		}
		else
		{
			self.visuals[0] radiusdamage(explosionorigin, 512, 200, 20);
		}

		rot = randomfloat(360);
		explosioneffect = spawnfx(level._effect["bombexplosion"], explosionorigin + (0,0,50), (0,0,1), (cos(rot),sin(rot),0));
		triggerfx(explosioneffect);
		playrumbleonposition("grenade_rumble", explosionorigin);
		earthquake(0.75, 2, explosionorigin, 2000);
		thread maps\mp\_utility::playsoundinspace("exp_suitcase_bomb_main", explosionorigin);
		if(isdefined(self.exploderindex))
		{
			common_scripts\utility::exploder(self.exploderindex);
		}

		maps\mp\gametypes\_gameobjects::disableobject();
		if(level.bombexploded < 2)
		{
			foreach(splashplayer in level.players)
			{
				splashplayer thread maps\mp\gametypes\_hud_message::splashnotify("time_added");
			}
		}

		wait 2;
		if(level.bombexploded > 1)
		{
			dd_endgame(game["attackers"], game["strings"]["target_destroyed"]);
			return;
		}

		level thread maps\mp\_utility::teamplayercardsplash("callout_time_added", player);
		return;
	}

	player notify("bomb_defused");
	self notify("defused");
	maps\mp\_utility::leaderdialog("bomb_defused");
	level thread maps\mp\_utility::teamplayercardsplash("callout_bombdefused", player);
	level thread bombdefused(self);
	resetbombzone();
	if(isdefined(level.bombowner) && level.bombowner.bombplantedtime + 4000 + level.defusetime * 1000 > gettime() && maps\mp\_utility::isreallyalive(level.bombowner))
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

playdemolitiontickingsound(param_F29)
{
	self endon("death");
	self endon("stopTicking");
	level endon("game_ended");
	for(;;)
	{
		self playsound("ui_mp_suitcasebomb_timer");
		if(!isdefined(param_F29.waittime) || param_F29.waittime > 10)
		{
			wait 1;
		}
		else if(isdefined(param_F29.waittime) && param_F29.waittime > 5)
		{
			wait 0.5;
		}
		else
		{
			wait 0.25;
		}

		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

setbombtimerdvar()
{
	if(level.bombsplanted == 1)
	{
		setdvar("ui_bomb_timer", 2);
		return;
	}

	if(level.bombsplanted == 2)
	{
		setdvar("ui_bomb_timer", 3);
		return;
	}

	setdvar("ui_bomb_timer", 0);
}

dropbombmodel(player, param_F29)
{
	trace = bullettrace(player.origin + (0,0,20), player.origin - (0,0,2000), 0, player);
	tempangle = randomfloat(360);
	forward = (cos(tempangle),sin(tempangle),0);
	forward = vectornormalize(forward - common_scripts\utility::vector_multiply(trace["normal"], vectordot(forward, trace["normal"])));
	dropangles = vectortoangles(forward);
	level.ddbombmodel[param_F29] = spawn("script_model", trace["position"]);
	level.ddbombmodel[param_F29].angles = dropangles;
	level.ddbombmodel[param_F29] setmodel("prop_suitcase_bomb");
}

restarttimer()
{
	if(level.bombsplanted <= 0)
	{
		maps\mp\gametypes\_gamelogic::resumetimer();
		level.timepaused = gettime() - level.timepausestart;
		level.timelimitoverride = 0;
		return;
	}
}

bombtimerwait(param_F2A)
{
	level endon("game_ended");
	level endon("bomb_defused" + param_F2A.label);
	param_F2A.waittime = level.bombtimer;
	while(param_F2A.waittime >= 0)
	{
		param_F2A.waittime--;
		setdvar("ui_bombtimer" + param_F2A.label, param_F2A.waittime);
		if(param_F2A.waittime >= 0)
		{
			wait 1;
		}

		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

bombdefused(param_F2B)
{
	level.tickingobject maps\mp\gametypes\_gamelogic::stoptickingsound();
	param_F2B.bombdefused = 1;
	setbombtimerdvar();
	setdvar("ui_bombtimer" + param_F2B.label, -1);
	level notify("bomb_defused" + param_F2B.label);
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