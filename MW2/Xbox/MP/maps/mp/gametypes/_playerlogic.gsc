/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_playerlogic.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

timeuntilwavespawn(param_A23)
{
	if(!self.hasspawned)
	{
		return 0;
	}

	earliestspawntime = gettime() + param_A23 * 1000;
	lastwavetime = level.lastwave[self.pers["team"]];
	wavedelay = level.wavedelay[self.pers["team"]] * 1000;
	numwavespassedearliestspawntime = earliestspawntime - lastwavetime / wavedelay;
	numwaves = ceil(numwavespassedearliestspawntime);
	timeofspawn = lastwavetime + numwaves * wavedelay;
	if(isdefined(self.respawntimerstarttime))
	{
		timealreadypassed = gettime() - self.respawntimerstarttime / 1000;
		if(self.respawntimerstarttime < lastwavetime)
		{
			return 0;
		}
	}

	if(isdefined(self.wavespawnindex))
	{
		timeofspawn = timeofspawn + 50 * self.wavespawnindex;
	}

	return timeofspawn - gettime() / 1000;
}

teamkilldelay()
{
	teamkills = self.pers["teamkills"];
	if(level.maxallowedteamkills < 0 || teamkills <= level.maxallowedteamkills)
	{
		return 0;
	}

	exceeded = teamkills - level.maxallowedteamkills;
	return maps\mp\gametypes\_tweakables::gettweakablevalue("team", "teamkillspawndelay") * exceeded;
}

timeuntilspawn(includeteamkilldelay)
{
	if((level.ingraceperiod && !self.hasspawned) || level.gameended)
	{
		return 0;
	}

	respawndelay = 0;
	if(self.hasspawned)
	{
		result = self [[ level.onrespawndelay ]]();
		if(isdefined(result))
		{
			respawndelay = result;
		}
		else
		{
			respawndelay = getdvarint("scr_" + level.gametype + "_playerrespawndelay");
		}

		if(includeteamkilldelay && self.pers["teamKillPunish"])
		{
			respawndelay = respawndelay + teamkilldelay();
		}

		if(isdefined(self.respawntimerstarttime))
		{
			timealreadypassed = gettime() - self.respawntimerstarttime / 1000;
			respawndelay = respawndelay - timealreadypassed;
			if(respawndelay < 0)
			{
				respawndelay = 0;
			}
		}

		if(isdefined(self.setspawnpoint))
		{
			respawndelay = respawndelay + level.tispawndelay;
		}
	}

	wavebased = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;
	if(wavebased)
	{
		return timeuntilwavespawn(respawndelay);
	}

	return respawndelay;
}

mayspawn()
{
	if(maps\mp\_utility::getgametypenumlives() || isdefined(level.disablespawning))
	{
		if(isdefined(level.disablespawning) && level.disablespawning)
		{
			return 0;
		}

		if(self.pers["teamKillPunish"])
		{
			return 0;
		}

		if(!self.pers["lives"] && maps\mp\_utility::gamehasstarted())
		{
			return 0;
		}
		else if(maps\mp\_utility::gamehasstarted())
		{
			if(!level.ingraceperiod && !self.hasspawned)
			{
				return 0;
			}
		}
	}

	return 1;
}

spawnclient()
{
	if(!mayspawn())
	{
		currentorigin = self.origin;
		currentangles = self.angles;
		self notify("attempted_spawn");
		if(self.pers["teamKillPunish"])
		{
			self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
			maps\mp\_utility::setlowermessage("friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT");
			if(!self.hasspawned && self.pers["teamkills"] <= level.maxallowedteamkills)
			{
				self.pers["teamKillPunish"] = 0;
			}
		}
		else if(maps\mp\_utility::isroundbased() && !maps\mp\_utility::islastround())
		{
			maps\mp\_utility::setlowermessage("spawn_info", game["strings"]["spawn_next_round"]);
			thread removespawnmessageshortly(3);
		}

		thread spawnspectator(currentorigin + (0,0,60), currentangles);
		return;
	}

	if(self.waitingtospawn)
	{
		return;
	}

	self.waitingtospawn = 1;
	waitandspawnclient();
	if(isdefined(self))
	{
		self.waitingtospawn = 0;
		return;
	}
}

waitandspawnclient()
{
	self endon("disconnect");
	self endon("end_respawn");
	level endon("game_ended");
	self notify("attempted_spawn");
	spawnedasspectator = 0;
	if(self.pers["teamKillPunish"])
	{
		teamkilldelay = teamkilldelay();
		if(teamkilldelay > 0)
		{
			maps\mp\_utility::setlowermessage("friendly_fire", &"MP_FRIENDLY_FIRE_WILL_NOT", teamkilldelay);
			thread respawn_asspectator(self.origin + (0,0,60), self.angles);
			spawnedasspectator = 1;
			wait teamkilldelay;
			maps\mp\_utility::clearlowermessage("friendly_fire");
			self.respawntimerstarttime = gettime();
		}

		self.pers["teamKillPunish"] = 0;
	}
	else if(teamkilldelay())
	{
		self.pers["teamkills"] = max(self.pers["teamkills"] - 1, 0);
	}

	if(maps\mp\_utility::isusingremote())
	{
		self waittill("stopped_using_remote");
	}

	if(!isdefined(self.wavespawnindex) && isdefined(level.waveplayerspawnindex[self.team]))
	{
		self.wavespawnindex = level.waveplayerspawnindex[self.team];
		level.waveplayerspawnindex[self.team]++;
	}

	timeuntilspawn = timeuntilspawn(0);
	thread predictabouttospawnplayerovertime(timeuntilspawn);
	if(timeuntilspawn > 0)
	{
		maps\mp\_utility::setlowermessage("spawn_info", game["strings"]["waiting_to_spawn"], timeuntilspawn);
		if(!spawnedasspectator)
		{
			thread respawn_asspectator(self.origin + (0,0,60), self.angles);
		}

		spawnedasspectator = 1;
		maps\mp\_utility::waitfortimeornotify(timeuntilspawn, "force_spawn");
		self notify("stop_wait_safe_spawn_button");
	}

	wavebased = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;
	if(maps\mp\gametypes\_tweakables::gettweakablevalue("player", "forcerespawn") == 0 && self.hasspawned && !wavebased && !self.wantsafespawn)
	{
		maps\mp\_utility::setlowermessage("spawn_info", game["strings"]["press_to_spawn"]);
		if(!spawnedasspectator)
		{
			thread respawn_asspectator(self.origin + (0,0,60), self.angles);
		}

		spawnedasspectator = 1;
		waitrespawnbutton();
	}

	self.waitingtospawn = 0;
	maps\mp\_utility::clearlowermessage("spawn_info");
	self.wavespawnindex = undefined;
	thread spawnplayer();
}

waitrespawnbutton()
{
	self endon("disconnect");
	self endon("end_respawn");
	for(;;)
	{
		if(self usebuttonpressed())
		{
			break;
		}

		wait 0.05;
	}
}

removespawnmessageshortly(delay)
{
	self endon("disconnect");
	level endon("game_ended");
	waittillframeend;
	self endon("end_respawn");
	wait delay;
	maps\mp\_utility::clearlowermessage("spawn_info", 2);
}

laststandrespawnplayer()
{
	self laststandrevive();
	if(maps\mp\_utility::_hasperk("specialty_finalstand") && !level.diehardmode)
	{
		maps\mp\_utility::_unsetperk("specialty_finalstand");
	}

	if(level.diehardmode)
	{
		self.headicon = "";
	}

	self setstance("crouch");
	self.revived = 1;
	self notify("revive");
	if(isdefined(self.standardmaxhealth))
	{
		self.maxhealth = self.standardmaxhealth;
	}

	self.health = self.maxhealth;
	common_scripts\utility::_enableusability();
	if(game["state"] == "postgame")
	{
		maps\mp\gametypes\_gamelogic::freezeplayerforroundend();
		return;
	}
}

getdeathspawnpoint()
{
	spawnpoint = spawn("script_origin", self.origin);
	spawnpoint hide();
	spawnpoint.angles = self.angles;
	return spawnpoint;
}

showspawnnotifies()
{
	if(isdefined(game["defcon"]))
	{
		thread maps\mp\gametypes\_hud_message::defconsplashnotify(game["defcon"], 0);
	}

	if(maps\mp\_utility::isrested())
	{
		thread maps\mp\gametypes\_hud_message::splashnotify("rested");
		return;
	}
}

predictabouttospawnplayerovertime(preduration)
{
	self endon("disconnect");
	self endon("spawned");
	self endon("used_predicted_spawnpoint");
	self notify("predicting_about_to_spawn_player");
	self endon("predicting_about_to_spawn_player");
	if(preduration <= 0)
	{
		return;
	}

	if(preduration > 1)
	{
		wait preduration - 1;
	}

	predictabouttospawnplayer();
	self predictstreampos(self.predictedspawnpoint.origin + (0,0,60), self.predictedspawnpoint.angles);
	self.predictedspawnpointtime = gettime();
	for(i = 0;i < 30;i++)
	{
		wait 0.4;
		prevpredictedspawnpoint = self.predictedspawnpoint;
		predictabouttospawnplayer();
		if(self.predictedspawnpoint != prevpredictedspawnpoint)
		{
			self predictstreampos(self.predictedspawnpoint.origin + (0,0,60), self.predictedspawnpoint.angles);
			self.predictedspawnpointtime = gettime();
		}
	}
}

predictabouttospawnplayer()
{
	if(timeuntilspawn(1) > 1)
	{
		spawnpointname = "mp_global_intermission";
		spawnpoints = getentarray(spawnpointname, "classname");
		self.predictedspawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(spawnpoints);
		return;
	}

	if(isdefined(self.setspawnpoint))
	{
		self.predictedspawnpoint = self.setspawnpoint;
		return;
	}

	spawnpoint = self [[ level.getspawnpoint ]]();
	self.predictedspawnpoint = spawnpoint;
}

checkpredictedspawnpointcorrectness(spawnpointorigin)
{
	self notify("used_predicted_spawnpoint");
	self.predictedspawnpoint = undefined;
}

percentage(a, b)
{
	return a + " (" + int(a / b * 100) + "%)";
}

printpredictedspawnpointcorrectness()
{
}

getspawnorigin(spawnpoint)
{
	if(!positionwouldtelefrag(spawnpoint.origin))
	{
		return spawnpoint.origin;
	}

	if(!isdefined(spawnpoint.alternates))
	{
		return spawnpoint.origin;
	}

	foreach(alternate in spawnpoint.alternates)
	{
		if(!positionwouldtelefrag(alternate))
		{
			return alternate;
		}
	}

	return spawnpoint.origin;
}

tivalidationcheck()
{
	if(!isdefined(self.setspawnpoint))
	{
		return 0;
	}

	carepackages = getentarray("care_package", "targetname");
	foreach(package in carepackages)
	{
		if(distance(package.origin, self.setspawnpoint.playerspawnpos) > 64)
		{
			continue;
		}

		if(isdefined(package.owner))
		{
			maps\mp\gametypes\_hud_message::playercardsplashnotify("destroyed_insertion", package.owner);
		}

		maps\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
		return 0;
	}

	return 1;
}

spawnplayer()
{
	self endon("disconnect");
	self endon("joined_spectators");
	self notify("spawned");
	self notify("end_respawn");
	if(isdefined(self.setspawnpoint) && tivalidationcheck())
	{
		spawnpoint = self.setspawnpoint;
		self playlocalsound("tactical_spawn");
		if(level.teambased)
		{
			self playsoundtoteam("tactical_spawn", level.otherteam[self.team]);
		}
		else
		{
			self playsound("tactical_spawn");
		}

		spawnorigin = self.setspawnpoint.playerspawnpos;
		spawnangles = self.setspawnpoint.angles;
		if(isdefined(self.setspawnpoint.enemytrigger))
		{
			self.setspawnpoint.enemytrigger delete();
		}

		self.setspawnpoint delete();
		spawnpoint = undefined;
	}
	else
	{
		spawnpoint = self [[ level.getspawnpoint ]]();
		spawnorigin = spawnpoint.origin;
		spawnangles = spawnpoint.angles;
	}

	setspawnvariables();
	hadspawned = self.hasspawned;
	self.fauxdead = undefined;
	self.killsthislife = [];
	updatesessionstate("playing", "");
	maps\mp\_utility::clearkillcamstate();
	self.cancelkillcam = 1;
	self openmenu("killedby_card_hide");
	self.maxhealth = maps\mp\gametypes\_tweakables::gettweakablevalue("player", "maxhealth");
	self.health = self.maxhealth;
	self.friendlydamage = undefined;
	self.hasspawned = 1;
	self.spawntime = gettime();
	self.wasti = !isdefined(spawnpoint);
	self.afk = 0;
	self.laststand = undefined;
	self.infinalstand = undefined;
	self.inc4death = undefined;
	self.damagedplayers = [];
	self.movespeedscaler = 1;
	self.killstreakscaler = 1;
	self.xpscaler = 1;
	self.objectivescaler = 1;
	self.inlaststand = 0;
	self.clampedhealth = undefined;
	self.shielddamage = 0;
	self.shieldbullethits = 0;
	self.recentshieldxp = 0;
	self.disabledweapon = 0;
	self.disabledweaponswitch = 0;
	self.disabledoffhandweapons = 0;
	common_scripts\utility::resetusability();
	if(self.pers["lives"] == maps\mp\_utility::getgametypenumlives())
	{
		addtolivescount();
	}

	if(self.pers["lives"])
	{
		self.pers["lives"]--;
	}

	addtoalivecount();
	if(!hadspawned || maps\mp\_utility::gamehasstarted() || maps\mp\_utility::gamehasstarted() && level.ingraceperiod && self.hasdonecombat)
	{
		removefromlivescount();
	}

	if(!self.wasaliveatmatchstart)
	{
		acceptablepassedtime = 20;
		if(maps\mp\_utility::gettimelimit() > 0 && acceptablepassedtime < maps\mp\_utility::gettimelimit() * 60 / 4)
		{
			acceptablepassedtime = maps\mp\_utility::gettimelimit() * 60 / 4;
		}

		if(level.ingraceperiod || maps\mp\_utility::gettimepassed() < acceptablepassedtime * 1000)
		{
			self.wasaliveatmatchstart = 1;
		}
	}

	self setclientdvar("cg_thirdPerson", "0");
	self setdepthoffield(0, 0, 512, 512, 4, 0);
	self setclientdvar("cg_fov", "65");
	if(isdefined(spawnpoint))
	{
		maps\mp\gametypes\_spawnlogic::finalizespawnpointchoice(spawnpoint);
		spawnorigin = getspawnorigin(spawnpoint);
		spawnangles = spawnpoint.angles;
	}
	else
	{
		self.lastspawntime = gettime();
	}

	self.spawnpos = spawnorigin;
	self spawn(spawnorigin, spawnangles);
	[[ level.onspawnplayer ]]();
	if(isdefined(spawnpoint))
	{
		checkpredictedspawnpointcorrectness(spawnpoint.origin);
	}

	maps\mp\gametypes\_missions::playerspawned();
	maps\mp\gametypes\_class::setclass(self.class);
	maps\mp\gametypes\_class::giveloadout(self.team, self.class);
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(1);
	}

	if(!maps\mp\_utility::gameflag("prematch_done"))
	{
		maps\mp\_utility::freezecontrolswrapper(1);
	}
	else
	{
		maps\mp\_utility::freezecontrolswrapper(0);
	}

	if(!maps\mp\_utility::gameflag("prematch_done") || !hadspawned && game["state"] == "playing")
	{
		self setclientdvar("scr_objectiveText", maps\mp\_utility::getobjectivehinttext(self.pers["team"]));
		team = self.pers["team"];
		if(game["status"] == "overtime")
		{
			thread maps\mp\gametypes\_hud_message::oldnotifymessage(game["strings"]["overtime"], game["strings"]["overtime_hint"], undefined, (1,0,0), "mp_last_stand");
		}
		else if(maps\mp\_utility::getintproperty("useRelativeTeamColors", 0))
		{
			thread maps\mp\gametypes\_hud_message::oldnotifymessage(game["strings"][team + "_name"], undefined, game["icons"][team] + "_blue", game["colors"]["blue"]);
		}
		else
		{
			thread maps\mp\gametypes\_hud_message::oldnotifymessage(game["strings"][team + "_name"], undefined, game["icons"][team], game["colors"][team]);
		}

		thread showspawnnotifies();
	}

	if(!level.splitscreen && maps\mp\_utility::getintproperty("scr_showperksonspawn", 1) == 1 && game["state"] != "postgame")
	{
		self openmenu("perk_display");
		thread hideperksaftertime(5);
		thread hideperksondeath();
	}

	waittillframeend;
	self notify("spawned_player");
	level notify("player_spawned", self);
	if(game["state"] == "postgame")
	{
		maps\mp\gametypes\_gamelogic::freezeplayerforroundend();
		return;
	}
}

hideperksaftertime(delay)
{
	self endon("disconnect");
	self endon("perks_hidden");
	wait delay;
	self openmenu("perk_hide");
	self notify("perks_hidden");
}

hideperksondeath()
{
	self endon("disconnect");
	self endon("perks_hidden");
	self waittill("death");
	self openmenu("perk_hide");
	self notify("perks_hidden");
}

hideperksonkill()
{
	self endon("disconnect");
	self endon("death");
	self endon("perks_hidden");
	self waittill("killed_player");
	self openmenu("perk_hide");
	self notify("perks_hidden");
}

spawnspectator(origin, angles)
{
	self notify("spawned");
	self notify("end_respawn");
	in_spawnspectator(origin, angles);
}

respawn_asspectator(origin, angles)
{
	in_spawnspectator(origin, angles);
}

in_spawnspectator(origin, angles)
{
	setspawnvariables();
	if(isdefined(self.pers["team"]) && self.pers["team"] == "spectator" && !level.gameended)
	{
		maps\mp\_utility::clearlowermessage("spawn_info");
	}

	self.sessionstate = "spectator";
	maps\mp\_utility::clearkillcamstate();
	self.friendlydamage = undefined;
	if(isdefined(self.pers["team"]) && self.pers["team"] == "spectator")
	{
		self.statusicon = "";
	}
	else
	{
		self.statusicon = "hud_status_dead";
	}

	maps\mp\gametypes\_spectating::setspectatepermissions();
	onspawnspectator(origin, angles);
	if(level.teambased && !level.splitscreen)
	{
		self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
		return;
	}
}

getplayerfromclientnum(clientnum)
{
	if(clientnum < 0)
	{
		return undefined;
	}

	for(i = 0;i < level.players.size;i++)
	{
		if(level.players[i] getentitynumber() == clientnum)
		{
			return level.players[i];
		}
	}

	return undefined;
}

onspawnspectator(origin, angles)
{
	if(isdefined(origin) && isdefined(angles))
	{
		self setspectatedefaults(origin, angles);
		self spawn(origin, angles);
		checkpredictedspawnpointcorrectness(origin);
		return;
	}

	spawnpointname = "mp_global_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(spawnpoints);
	self setspectatedefaults(spawnpoint.origin, spawnpoint.angles);
	self spawn(spawnpoint.origin, spawnpoint.angles);
	checkpredictedspawnpointcorrectness(spawnpoint.origin);
}

spawnintermission()
{
	self endon("disconnect");
	self notify("spawned");
	self notify("end_respawn");
	setspawnvariables();
	self closepopupmenu();
	self closeingamemenu();
	maps\mp\_utility::clearlowermessages();
	maps\mp\_utility::freezecontrolswrapper(1);
	self setclientdvar("cg_everyoneHearsEveryone", 1);
	if(level.rankedmatch && self.postgamepromotion || self.pers["postGameChallenges"])
	{
		if(self.postgamepromotion)
		{
			self playlocalsound("mp_level_up");
		}
		else
		{
			self playlocalsound("mp_challenge_complete");
		}

		if(self.postgamepromotion > level.postgamenotifies)
		{
			level.postgamenotifies = 1;
		}

		if(self.pers["postGameChallenges"] > level.postgamenotifies)
		{
			level.postgamenotifies = self.pers["postGameChallenges"];
		}

		self closepopupmenu();
		self closeingamemenu();
		self openmenu(game["menu_endgameupdate"]);
		waittime = 4 + min(self.pers["postGameChallenges"], 3);
		while(waittime)
		{
			wait 0.25;
			waittime = waittime - 0.25;
			self openmenu(game["menu_endgameupdate"]);
		}

		self closemenu(game["menu_endgameupdate"]);
	}

	self.sessionstate = "intermission";
	maps\mp\_utility::clearkillcamstate();
	self.friendlydamage = undefined;
	spawnpoints = getentarray("mp_global_intermission", "classname");
	spawnpoint = spawnpoints[0];
	self spawn(spawnpoint.origin, spawnpoint.angles);
	checkpredictedspawnpointcorrectness(spawnpoint.origin);
	self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

spawnendofgame()
{
	if(1)
	{
		maps\mp\_utility::freezecontrolswrapper(1);
		spawnspectator();
		maps\mp\_utility::freezecontrolswrapper(1);
		return;
	}

	self notify("spawned");
	self notify("end_respawn");
	setspawnvariables();
	self closepopupmenu();
	self closeingamemenu();
	maps\mp\_utility::clearlowermessages();
	self setclientdvar("cg_everyoneHearsEveryone", 1);
	self.sessionstate = "dead";
	maps\mp\_utility::clearkillcamstate();
	self.friendlydamage = undefined;
	spawnpoints = getentarray("mp_global_intermission", "classname");
	spawnpoint = spawnpoints[0];
	self spawn(spawnpoint.origin, spawnpoint.angles);
	checkpredictedspawnpointcorrectness(spawnpoint.origin);
	spawnpoint setmodel("tag_origin");
	self playerlinkto(spawnpoint);
	self playerhide();
	maps\mp\_utility::freezecontrolswrapper(1);
	self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

setspawnvariables()
{
	self stopshellshock();
	self stoprumble("damage_heavy");
}

notifyconnecting()
{
	waittillframeend;
	if(isdefined(self))
	{
		level notify("connecting", self);
		return;
	}
}

callback_playerdisconnect()
{
	if(!isdefined(self.connected))
	{
		return;
	}

	removeplayerondisconnect();
	if(!level.teambased)
	{
		game["roundsWon"][self.guid] = undefined;
	}

	if(level.splitscreen)
	{
		players = level.players;
		if(players.size <= 1)
		{
			level thread maps\mp\gametypes\_gamelogic::forceend();
		}
	}

	if(isdefined(self.score) && isdefined(self.pers["team"]))
	{
		setplayerteamrank(self, self.clientid, self.score - 5 * self.deaths);
	}

	lpselfnum = self getentitynumber();
	lpguid = self.guid;
	logprint("Q;" + lpguid + ";" + lpselfnum + ";" + self.name + "\\n");
	thread maps\mp\_events::disconnected();
	if(level.gameended)
	{
		maps\mp\gametypes\_gamescore::removedisconnectedplayerfromplacement();
	}

	if(isdefined(self.team))
	{
		removefromteamcount();
	}

	if(self.sessionstate == "playing")
	{
		removefromalivecount(1);
		return;
	}

	if(self.sessionstate == "spectator")
	{
		level thread maps\mp\gametypes\_gamelogic::updategameevents();
		return;
	}
}

removeplayerondisconnect()
{
	found = 0;
	for(entry = 0;entry < level.players.size;entry++)
	{
		if(level.players[entry] == self)
		{
			found = 1;
			while(entry < level.players.size - 1)
			{
				level.players[entry] = level.players[entry + 1];
				entry++;
			}

			level.players[entry] = undefined;
			break;
		}
	}
}

initclientdvars()
{
	makedvarserverinfo("cg_drawTalk", 1);
	makedvarserverinfo("cg_drawCrosshair", 1);
	makedvarserverinfo("cg_drawCrosshairNames", 1);
	makedvarserverinfo("cg_hudGrenadeIconMaxRangeFrag", 250);
	if(level.hardcoremode)
	{
		setdvar("cg_drawTalk", 3);
		setdvar("cg_drawCrosshair", 0);
		setdvar("cg_drawCrosshairNames", 1);
		setdvar("cg_hudGrenadeIconMaxRangeFrag", 0);
	}

	self setclientdvars("cg_drawSpectatorMessages", 1, "g_compassShowEnemies", getdvar("scr_game_forceuav"), "cg_scoreboardPingGraph", 1);
	if(level.splitscreen)
	{
		self setclientdvars("cg_hudGrenadeIconHeight", "37.5", "cg_hudGrenadeIconWidth", "37.5", "cg_hudGrenadeIconOffset", "75", "cg_hudGrenadePointerHeight", "18", "cg_hudGrenadePointerWidth", "37.5", "cg_hudGrenadePointerPivot", "18 40.5", "cg_fovscale", "0.75");
	}
	else
	{
		self setclientdvars("cg_hudGrenadeIconHeight", "25", "cg_hudGrenadeIconWidth", "25", "cg_hudGrenadeIconOffset", "50", "cg_hudGrenadePointerHeight", "12", "cg_hudGrenadePointerWidth", "25", "cg_hudGrenadePointerPivot", "12 27", "cg_fovscale", "1");
	}

	if(maps\mp\_utility::getgametypenumlives())
	{
		self setclientdvars("cg_deadChatWithDead", 1, "cg_deadChatWithTeam", 0, "cg_deadHearTeamLiving", 0, "cg_deadHearAllLiving", 0);
	}
	else
	{
		self setclientdvars("cg_deadChatWithDead", 0, "cg_deadChatWithTeam", 1, "cg_deadHearTeamLiving", 1, "cg_deadHearAllLiving", 0);
	}

	if(level.teambased)
	{
		self setclientdvars("cg_everyonehearseveryone", 0);
	}

	self setclientdvar("ui_altscene", 0);
	if(getdvarint("scr_hitloc_debug"))
	{
		for(i = 0;i < 6;i++)
		{
			self setclientdvar("ui_hitloc_" + i, "");
		}

		self.hitlocinited = 1;
		return;
	}
}

callback_playerconnect()
{
	thread notifyconnecting();
	self.statusicon = "hud_status_connecting";
	self waittill("begin");
	self.statusicon = "";
	connecttime = undefined;
	level notify("connected", self);
	self.connected = 1;
	if(self ishost())
	{
		level.player = self;
	}

	if(!level.splitscreen && !isdefined(self.pers["score"]))
	{
		iprintln(&"MP_CONNECTED", self);
	}

	self.usingonlinedataoffline = self isusingonlinedataoffline();
	initclientdvars();
	initplayerstats();
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		level waittill("eternity");
	}

	self.guid = self getguid();
	firstconnect = 0;
	if(!isdefined(self.pers["clientid"]))
	{
		self.pers["clientid"] = game["clientid"];
		game["clientid"]++;
		firstconnect = 1;
	}

	self.clientid = self.pers["clientid"];
	logprint("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\\n");
	if(maps\mp\_utility::matchmakinggame() && game["clientid"] <= 24 && game["clientid"] != getmatchdata("playerCount"))
	{
		setmatchdata("playerCount", game["clientid"]);
		setmatchdata("players", self.clientid, "xuid", self getxuid());
		setmatchdata("players", self.clientid, "team", self.sessionteam);
	}

	if(!level.teambased)
	{
		game["roundsWon"][self.guid] = 0;
	}

	self.leaderdialogqueue = [];
	self.leaderdialogactive = "";
	self.leaderdialoggroups = [];
	self.leaderdialoggroup = "";
	if(!isdefined(self.pers["cur_kill_streak"]))
	{
		self.pers["cur_kill_streak"] = 0;
	}

	if(!isdefined(self.pers["cur_death_streak"]))
	{
		self.pers["cur_death_streak"] = 0;
	}

	self.kill_streak = maps\mp\gametypes\_persistence::statget("killStreak");
	self.lastgrenadesuicidetime = -1;
	self.teamkillsthisround = 0;
	self.hasspawned = 0;
	self.waitingtospawn = 0;
	self.wantsafespawn = 0;
	self.wasaliveatmatchstart = 0;
	self.movespeedscaler = 1;
	self.killstreakscaler = 1;
	self.xpscaler = 1;
	self.objectivescaler = 1;
	self.issniper = 0;
	self.saved_actionslotdata = [];
	setrestxpgoal();
	for(slotid = 1;slotid <= 4;slotid++)
	{
		self.saved_actionslotdata[slotid] = spawnstruct();
		self.saved_actionslotdata[slotid].type = "";
		self.saved_actionslotdata[slotid].item = undefined;
	}

	thread maps\mp\_flashgrenades::monitorflash();
	waittillframeend;
	level.players[level.players.size] = self;
	if(level.teambased)
	{
		self updatescores();
	}

	if(game["state"] == "postgame")
	{
		self.connectedpostgame = 1;
		if(maps\mp\_utility::matchmakinggame())
		{
			maps\mp\gametypes\_menus::addtoteam(maps\mp\gametypes\_menus::getteamassignment(), 1);
		}
		else
		{
			maps\mp\gametypes\_menus::addtoteam("spectator", 1);
		}

		self setclientdvars("cg_drawSpectatorMessages", 0);
		spawnintermission();
		return;
	}

	if(firstconnect)
	{
		maps\mp\gametypes\_gamelogic::updatelossstats(self);
	}

	level endon("game_ended");
	if(isdefined(level.hostmigrationtimer))
	{
		thread maps\mp\gametypes\_hostmigration::hostmigrationtimerthink();
	}

	if(!isdefined(self.pers["team"]))
	{
		if(maps\mp\_utility::matchmakinggame())
		{
			thread spawnspectator();
			self [[ level.autoassign ]]();
			thread kickifdontspawn();
			return;
		}

		self [[ level.spectator ]]();
		maps\mp\gametypes\_menus::beginteamchoice();
		return;
	}

	maps\mp\gametypes\_menus::addtoteam(self.pers["team"], 1);
	if(maps\mp\_utility::isvalidclass(self.pers["class"]))
	{
		thread spawnclient();
		return;
	}

	thread spawnspectator();
	if(self.pers["team"] == "spectator")
	{
		maps\mp\gametypes\_menus::beginteamchoice();
		return;
	}

	maps\mp\gametypes\_menus::beginclasschoice();
}

callback_playermigrated()
{
	if(isdefined(self.connected) && self.connected)
	{
		maps\mp\_utility::updateobjectivetext();
		maps\mp\_utility::updatemainmenu();
		if(level.teambased)
		{
			self updatescores();
		}
	}

	level.hostmigrationreturnedplayercount++;
	if(level.hostmigrationreturnedplayercount >= level.players.size * 2 / 3)
	{
		level notify("hostmigration_enoughplayers");
		return;
	}
}

addlevelstoexperience(experience, param_A5E)
{
	rank = maps\mp\gametypes\_rank::getrankforxp(experience);
	minxp = maps\mp\gametypes\_rank::getrankinfominxp(rank);
	maxxp = maps\mp\gametypes\_rank::getrankinfomaxxp(rank);
	rank = rank + experience - minxp / maxxp - minxp;
	rank = rank + param_A5E;
	if(rank < 0)
	{
		rank = 0;
		fractionalpart = 0;
	}
	else if(rank >= level.maxrank + 1)
	{
		rank = level.maxrank;
		fractionalpart = 1;
	}
	else
	{
		fractionalpart = rank - floor(rank);
		rank = int(floor(rank));
	}

	minxp = maps\mp\gametypes\_rank::getrankinfominxp(rank);
	maxxp = maps\mp\gametypes\_rank::getrankinfomaxxp(rank);
	return int(fractionalpart * maxxp - minxp) + minxp;
}

getrestxpcap(experience)
{
	levelstocap = getdvarfloat("scr_restxp_cap");
	return addlevelstoexperience(experience, levelstocap);
}

setrestxpgoal()
{
	if(!getdvarint("scr_restxp_enable"))
	{
		self setplayerdata("restXPGoal", 0);
		return;
	}

	secondssincelastgame = self getrestedtime();
	hourssincelastgame = secondssincelastgame / 3600;
	experience = self getplayerdata("experience");
	minrestxptime = getdvarfloat("scr_restxp_minRestTime");
	restxpgainrate = getdvarfloat("scr_restxp_levelsPerDay") / 24;
	restxpcap = getrestxpcap(experience);
	restxpgoal = self getplayerdata("restXPGoal");
	if(restxpgoal < experience)
	{
		restxpgoal = experience;
	}

	oldrestxpgoal = restxpgoal;
	restlevels = 0;
	if(hourssincelastgame > minrestxptime)
	{
		restlevels = restxpgainrate * hourssincelastgame;
		restxpgoal = addlevelstoexperience(restxpgoal, restlevels);
	}

	cappedstring = "";
	if(restxpgoal >= restxpcap)
	{
		restxpgoal = restxpcap;
		cappedstring = " (hit cap)";
	}

	self setplayerdata("restXPGoal", restxpgoal);
}

forcespawn()
{
	self endon("death");
	self endon("disconnect");
	self endon("spawned");
	wait 60;
	if(self.hasspawned)
	{
		return;
	}

	if(self.pers["team"] == "spectator")
	{
		return;
	}

	if(!maps\mp\_utility::isvalidclass(self.pers["class"]))
	{
		self.pers["class"] = "CLASS_CUSTOM1";
		self.class = self.pers["class"];
	}

	maps\mp\_utility::closemenus();
	thread spawnclient();
}

kickifdontspawn()
{
	self endon("death");
	self endon("disconnect");
	self endon("spawned");
	self endon("attempted_spawn");
	waittime = getdvarfloat("scr_kick_time", 90);
	mintime = getdvarfloat("scr_kick_mintime", 45);
	starttime = gettime();
	if(self ishost())
	{
		kickwait(120);
	}
	else
	{
		kickwait(waittime);
	}

	timepassed = gettime() - starttime / 1000;
	if(timepassed < waittime - 0.1 && timepassed < mintime)
	{
		return;
	}

	if(self.hasspawned)
	{
		return;
	}

	if(self.pers["team"] == "spectator")
	{
		return;
	}

	kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE");
	level thread maps\mp\gametypes\_gamelogic::updategameevents();
}

kickwait(waittime)
{
	level endon("game_ended");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

updatesessionstate(sessionstate, statusicon)
{
	self.sessionstate = sessionstate;
	self.statusicon = statusicon;
}

initplayerstats()
{
	maps\mp\gametypes\_persistence::initbufferedstats();
	maps\mp\_utility::initpersstat("score");
	self.score = self.pers["score"];
	maps\mp\_utility::initpersstat("deaths");
	self.deaths = maps\mp\_utility::getpersstat("deaths");
	maps\mp\_utility::initpersstat("suicides");
	self.suicides = maps\mp\_utility::getpersstat("suicides");
	maps\mp\_utility::initpersstat("kills");
	self.kills = maps\mp\_utility::getpersstat("kills");
	maps\mp\_utility::initpersstat("headshots");
	self.headshots = maps\mp\_utility::getpersstat("headshots");
	maps\mp\_utility::initpersstat("assists");
	self.assists = maps\mp\_utility::getpersstat("assists");
	maps\mp\_utility::initpersstat("teamkills");
	if(!isdefined(self.pers["teamKillPunish"]))
	{
		self.pers["teamKillPunish"] = 0;
	}

	maps\mp\_utility::initpersstat("longestStreak");
	self.pers["lives"] = maps\mp\_utility::getgametypenumlives();
	maps\mp\gametypes\_persistence::statsetchild("round", "kills", 0);
	maps\mp\gametypes\_persistence::statsetchild("round", "killStreak", 0);
	maps\mp\gametypes\_persistence::statsetchild("round", "deaths", 0);
	maps\mp\gametypes\_persistence::statsetchild("round", "score", 0);
	maps\mp\gametypes\_persistence::statsetchild("round", "loss", 0);
	maps\mp\gametypes\_persistence::statsetchild("round", "win", 0);
	maps\mp\gametypes\_persistence::statsetchild("round", "scoreboardType", "none");
	maps\mp\gametypes\_persistence::statsetchildbuffered("round", "timePlayed", 0);
}

addtoteamcount()
{
	level.teamcount[self.team]++;
	maps\mp\gametypes\_gamelogic::updategameevents();
}

removefromteamcount()
{
	level.teamcount[self.team]--;
}

addtoalivecount()
{
	level.alivecount[self.team]++;
	level.hasspawned[self.team]++;
	if(level.alivecount["allies"] + level.alivecount["axis"] > level.maxplayercount)
	{
		level.maxplayercount = level.alivecount["allies"] + level.alivecount["axis"];
		return;
	}
}

removefromalivecount(disconnected)
{
	if(isdefined(self.switching_teams) || isdefined(disconnected))
	{
		removeallfromlivescount();
		if(isdefined(self.switching_teams))
		{
			self.pers["lives"] = 0;
		}
	}

	level.alivecount[self.team]--;
	return maps\mp\gametypes\_gamelogic::updategameevents();
}

addtolivescount()
{
	level.livescount[self.team] = level.livescount[self.team] + self.pers["lives"];
}

removefromlivescount()
{
	level.livescount[self.team]--;
	level.livescount[self.team] = int(max(0, level.livescount[self.team]));
}

removeallfromlivescount()
{
	level.livescount[self.team] = level.livescount[self.team] - self.pers["lives"];
	level.livescount[self.team] = int(max(0, level.livescount[self.team]));
}