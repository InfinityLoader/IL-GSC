/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_playerlogic.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 53
 * Decompile Time: 764 ms
 * Timestamp: 10/27/2023 2:12:48 AM
*******************************************************************/

//Function Number: 1
timeuntilwavespawn(param_00)
{
	if(!self.hasspawned)
	{
		return 0;
	}

	var_01 = gettime() + param_00 * 1000;
	var_02 = level.lastwave[self.pers["team"]];
	var_03 = level.wavedelay[self.pers["team"]] * 1000;
	var_04 = var_01 - var_02 / var_03;
	var_05 = ceil(var_04);
	var_06 = var_02 + var_05 * var_03;
	if(isdefined(self.respawntimerstarttime))
	{
		var_07 = gettime() - self.respawntimerstarttime / 1000;
		if(self.respawntimerstarttime < var_02)
		{
			return 0;
		}
	}

	if(isdefined(self.wavespawnindex))
	{
		var_06 = var_06 + 50 * self.wavespawnindex;
	}

	return var_06 - gettime() / 1000;
}

//Function Number: 2
teamkilldelay()
{
	var_00 = self.pers["teamkills"];
	if(level.maxallowedteamkills < 0 || var_00 <= level.maxallowedteamkills)
	{
		return 0;
	}

	var_01 = var_00 - level.maxallowedteamkills;
	return maps\mp\gametypes\_tweakables::gettweakablevalue("team","teamkillspawndelay") * var_01;
}

//Function Number: 3
timeuntilspawn(param_00)
{
	if((level.ingraceperiod && !self.hasspawned) || level.gameended)
	{
		return 0;
	}

	var_01 = 0;
	if(self.hasspawned)
	{
		var_02 = self [[ level.onrespawndelay ]]();
		if(isdefined(var_02))
		{
			var_01 = var_02;
		}
		else
		{
			var_01 = getdvarint("scr_" + level.gametype + "_playerrespawndelay");
		}

		if(param_00 && isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
		{
			var_01 = var_01 + teamkilldelay();
		}

		if(isdefined(self.respawntimerstarttime))
		{
			var_03 = gettime() - self.respawntimerstarttime / 1000;
			var_01 = var_01 - var_03;
			if(var_01 < 0)
			{
				var_01 = 0;
			}
		}

		if(isdefined(self.setspawnpoint))
		{
			var_01 = var_01 + level.tispawndelay;
		}
	}

	var_04 = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;
	if(var_04)
	{
		return timeuntilwavespawn(var_01);
	}

	return var_01;
}

//Function Number: 4
mayspawn()
{
	if(maps\mp\_utility::getgametypenumlives() || isdefined(level.disablespawning))
	{
		if(isdefined(level.disablespawning) && level.disablespawning)
		{
			return 0;
		}

		if(isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
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

//Function Number: 5
spawnclient()
{
	if(isdefined(self.addtoteam))
	{
		maps\mp\gametypes\_menus::addtoteam(self.addtoteam);
		self.addtoteam = undefined;
	}

	if(!mayspawn())
	{
		var_00 = self.origin;
		var_01 = self.angles;
		self notify("attempted_spawn");
		if(isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
		{
			self.pers["teamkills"] = max(self.pers["teamkills"] - 1,0);
			maps\mp\_utility::setlowermessage("friendly_fire",&"MP_FRIENDLY_FIRE_WILL_NOT");
			if(!self.hasspawned && self.pers["teamkills"] <= level.maxallowedteamkills)
			{
				self.pers["teamKillPunish"] = 0;
			}
		}
		else if(maps\mp\_utility::isroundbased() && !maps\mp\_utility::islastround())
		{
			maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["spawn_next_round"]);
			thread removespawnmessageshortly(3);
		}

		if(self.sessionstate != "spectator")
		{
			var_00 = var_00 + (0,0,60);
		}

		thread spawnspectator(var_00,var_01);
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
	}
}

//Function Number: 6
waitandspawnclient()
{
	self endon("disconnect");
	self endon("end_respawn");
	level endon("game_ended");
	self notify("attempted_spawn");
	var_00 = 0;
	if(isdefined(self.pers["teamKillPunish"]) && self.pers["teamKillPunish"])
	{
		var_01 = teamkilldelay();
		if(var_01 > 0)
		{
			maps\mp\_utility::setlowermessage("friendly_fire",&"MP_FRIENDLY_FIRE_WILL_NOT",var_01,1,1);
			thread respawn_asspectator(self.origin + (0,0,60),self.angles);
			var_00 = 1;
			wait var_01;
			maps\mp\_utility::clearlowermessage("friendly_fire");
			self.respawntimerstarttime = gettime();
		}

		self.pers["teamKillPunish"] = 0;
	}
	else if(teamkilldelay())
	{
		self.pers["teamkills"] = max(self.pers["teamkills"] - 1,0);
	}

	if(maps\mp\_utility::isusingremote())
	{
		self.spawningafterremotedeath = 1;
		self waittill("stopped_using_remote");
	}

	if(!isdefined(self.wavespawnindex) && isdefined(level.waveplayerspawnindex[self.team]))
	{
		self.wavespawnindex = level.waveplayerspawnindex[self.team];
		level.waveplayerspawnindex[self.team]++;
	}

	var_02 = timeuntilspawn(0);
	thread predictabouttospawnplayerovertime(var_02);
	if(var_02 > 0)
	{
		maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["waiting_to_spawn"],var_02,1,1);
		if(!var_00)
		{
			thread respawn_asspectator(self.origin + (0,0,60),self.angles);
		}

		var_00 = 1;
		maps\mp\_utility::waitfortimeornotify(var_02,"force_spawn");
		self notify("stop_wait_safe_spawn_button");
	}

	var_03 = getdvarint("scr_" + level.gametype + "_waverespawndelay") > 0;
	if(maps\mp\gametypes\_tweakables::gettweakablevalue("player","forcerespawn") == 0 && self.hasspawned && !var_03 && !self.wantsafespawn)
	{
		maps\mp\_utility::setlowermessage("spawn_info",game["strings"]["press_to_spawn"],undefined,undefined,undefined,undefined,undefined,undefined,1);
		if(!var_00)
		{
			thread respawn_asspectator(self.origin + (0,0,60),self.angles);
		}

		var_00 = 1;
		waitrespawnbutton();
	}

	self.waitingtospawn = 0;
	maps\mp\_utility::clearlowermessage("spawn_info");
	self.wavespawnindex = undefined;
	thread spawnplayer();
}

//Function Number: 7
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

//Function Number: 8
removespawnmessageshortly(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	waittillframeend;
	self endon("end_respawn");
	wait param_00;
	maps\mp\_utility::clearlowermessage("spawn_info");
}

//Function Number: 9
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
	}
}

//Function Number: 10
getdeathspawnpoint()
{
	var_00 = spawn("script_origin",self.origin);
	var_00 hide();
	var_00.angles = self.angles;
	return var_00;
}

//Function Number: 11
showspawnnotifies()
{
	if(isdefined(game["defcon"]))
	{
		thread maps\mp\gametypes\_hud_message::defconsplashnotify(game["defcon"],0);
	}

	if(maps\mp\_utility::isrested())
	{
		thread maps\mp\gametypes\_hud_message::splashnotify("rested");
	}
}

//Function Number: 12
predictabouttospawnplayerovertime(param_00)
{
	self endon("disconnect");
	self endon("spawned");
	self endon("used_predicted_spawnpoint");
	self notify("predicting_about_to_spawn_player");
	self endon("predicting_about_to_spawn_player");
	if(param_00 <= 0)
	{
		return;
	}

	if(param_00 > 1)
	{
		wait param_00 - 1;
	}

	predictabouttospawnplayer();
	self predictstreampos(self.predictedspawnpoint.origin + (0,0,60),self.predictedspawnpoint.angles);
	self.predictedspawnpointtime = gettime();
	for(var_01 = 0;var_01 < 30;var_01++)
	{
		wait 0.4;
		var_02 = self.predictedspawnpoint;
		predictabouttospawnplayer();
		if(self.predictedspawnpoint != var_02)
		{
			self predictstreampos(self.predictedspawnpoint.origin + (0,0,60),self.predictedspawnpoint.angles);
			self.predictedspawnpointtime = gettime();
		}
	}
}

//Function Number: 13
predictabouttospawnplayer()
{
	if(timeuntilspawn(1) > 1)
	{
		var_00 = "mp_global_intermission";
		var_01 = getentarray(var_00,"classname");
		self.predictedspawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
		return;
	}

	if(isdefined(self.setspawnpoint))
	{
		self.predictedspawnpoint = self.setspawnpoint;
		return;
	}

	var_02 = self [[ level.getspawnpoint ]]();
	self.predictedspawnpoint = var_02;
}

//Function Number: 14
checkpredictedspawnpointcorrectness(param_00)
{
	self notify("used_predicted_spawnpoint");
	self.predictedspawnpoint = undefined;
}

//Function Number: 15
percentage(param_00,param_01)
{
	return param_00 + " (" + int(param_00 / param_01 * 100) + "%)";
}

//Function Number: 16
printpredictedspawnpointcorrectness()
{
}

//Function Number: 17
getspawnorigin(param_00)
{
	if(!positionwouldtelefrag(param_00.origin))
	{
		return param_00.origin;
	}

	if(!isdefined(param_00.alternates))
	{
		return param_00.origin;
	}

	foreach(var_02 in param_00.alternates)
	{
		if(!positionwouldtelefrag(var_02))
		{
			return var_02;
		}
	}

	return param_00.origin;
}

//Function Number: 18
tivalidationcheck()
{
	if(!isdefined(self.setspawnpoint))
	{
		return 0;
	}

	var_00 = getentarray("care_package","targetname");
	foreach(var_02 in var_00)
	{
		if(distance(var_02.origin,self.setspawnpoint.playerspawnpos) > 64)
		{
			continue;
		}

		if(isdefined(var_02.owner))
		{
			maps\mp\gametypes\_hud_message::playercardsplashnotify("destroyed_insertion",var_02.owner);
		}

		maps\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
		return 0;
	}

	return 1;
}

//Function Number: 19
spawnplayer(param_00)
{
	self endon("disconnect");
	self endon("joined_spectators");
	self notify("spawned");
	self notify("end_respawn");
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(isdefined(self.setspawnpoint) && isdefined(self.setspawnpoint.notti) || tivalidationcheck())
	{
		var_01 = self.setspawnpoint;
		if(!isdefined(self.setspawnpoint.notti))
		{
			self playlocalsound("tactical_spawn");
			if(level.teambased)
			{
				self playsoundtoteam("tactical_spawn",level.otherteam[self.team]);
			}
			else
			{
				self playsound("tactical_spawn");
			}
		}

		foreach(var_03 in level.ugvs)
		{
			if(distancesquared(var_03.origin,var_01.playerspawnpos) < 1024)
			{
				var_03 notify("damage",5000,var_03.owner,(0,0,0),(0,0,0),"MOD_EXPLOSIVE","","","",undefined,"killstreak_emp_mp");
			}
		}

		var_05 = self.setspawnpoint.playerspawnpos;
		var_06 = self.setspawnpoint.angles;
		if(isdefined(self.setspawnpoint.enemytrigger))
		{
			self.setspawnpoint.enemytrigger delete();
		}

		self.setspawnpoint delete();
		var_01 = undefined;
	}
	else
	{
		var_01 = self [[ level.getspawnpoint ]]();
		var_05 = var_06.origin;
		var_06 = var_05.angles;
	}

	setspawnvariables();
	var_07 = self.hasspawned;
	self.fauxdead = undefined;
	if(!param_00)
	{
		self.killsthislife = [];
		updatesessionstate("playing","");
		maps\mp\_utility::clearkillcamstate();
		self.cancelkillcam = 1;
		self openmenu("killedby_card_hide");
		self.maxhealth = maps\mp\gametypes\_tweakables::gettweakablevalue("player","maxhealth");
		self.health = self.maxhealth;
		self.friendlydamage = undefined;
		self.hasspawned = 1;
		self.spawntime = gettime();
		self.wasti = !isdefined(var_01);
		self.afk = 0;
		self.damagedplayers = [];
		self.killstreakscaler = 1;
		self.xpscaler = 1;
		self.objectivescaler = 1;
		self.clampedhealth = undefined;
		self.shielddamage = 0;
		self.shieldbullethits = 0;
		self.recentshieldxp = 0;
	}

	self.movespeedscaler = 1;
	self.inlaststand = 0;
	self.laststand = undefined;
	self.infinalstand = undefined;
	self.inc4death = undefined;
	self.disabledweapon = 0;
	self.disabledweaponswitch = 0;
	self.disabledoffhandweapons = 0;
	common_scripts\utility::resetusability();
	if(!param_00)
	{
		self.avoidkillstreakonspawntimer = 5;
		if(self.pers["lives"] == maps\mp\_utility::getgametypenumlives())
		{
			addtolivescount();
		}

		if(self.pers["lives"])
		{
			self.pers["lives"]--;
		}

		addtoalivecount();
		if(!var_07 || maps\mp\_utility::gamehasstarted() || maps\mp\_utility::gamehasstarted() && level.ingraceperiod && self.hasdonecombat)
		{
			removefromlivescount();
		}

		if(!self.wasaliveatmatchstart)
		{
			var_08 = 20;
			if(maps\mp\_utility::gettimelimit() > 0 && var_08 < maps\mp\_utility::gettimelimit() * 60 / 4)
			{
				var_08 = maps\mp\_utility::gettimelimit() * 60 / 4;
			}

			if(level.ingraceperiod || maps\mp\_utility::gettimepassed() < var_08 * 1000)
			{
				self.wasaliveatmatchstart = 1;
			}
		}
	}

	self setclientdvar("cg_thirdPerson","0");
	self setdepthoffield(0,0,512,512,4,0);
	self setclientdvar("cg_fov","65");
	if(isdefined(var_01))
	{
		maps\mp\gametypes\_spawnlogic::finalizespawnpointchoice(var_01);
		var_05 = getspawnorigin(var_01);
		var_06 = var_01.angles;
	}
	else
	{
		self.lastspawntime = gettime();
	}

	self.spawnpos = var_05;
	self spawn(var_05,var_06);
	if(param_00 && isdefined(self.faux_spawn_stance))
	{
		self setstance(self.faux_spawn_stance);
		self.faux_spawn_stance = undefined;
	}

	[[ level.onspawnplayer ]]();
	if(isdefined(var_01))
	{
		checkpredictedspawnpointcorrectness(var_01.origin);
	}

	if(!param_00)
	{
		maps\mp\gametypes\_missions::playerspawned();
	}

	maps\mp\gametypes\_class::setclass(self.class);
	maps\mp\gametypes\_class::giveloadout(self.team,self.class);
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

	if(!maps\mp\_utility::gameflag("prematch_done") || !var_07 && game["state"] == "playing")
	{
		self setclientdvar("scr_objectiveText",maps\mp\_utility::getobjectivehinttext(self.pers["team"]));
		var_09 = self.pers["team"];
		if(game["status"] == "overtime")
		{
			thread maps\mp\gametypes\_hud_message::oldnotifymessage(game["strings"]["overtime"],game["strings"]["overtime_hint"],undefined,(1,0,0),"mp_last_stand");
		}
		else if(maps\mp\_utility::getintproperty("useRelativeTeamColors",0))
		{
			thread maps\mp\gametypes\_hud_message::oldnotifymessage(game["strings"][var_09 + "_name"],undefined,game["icons"][var_09] + "_blue",game["colors"]["blue"]);
		}
		else
		{
			thread maps\mp\gametypes\_hud_message::oldnotifymessage(game["strings"][var_09 + "_name"],undefined,game["icons"][var_09],game["colors"][var_09]);
		}

		thread showspawnnotifies();
	}

	if(maps\mp\_utility::getintproperty("scr_showperksonspawn",1) == 1 && game["state"] != "postgame")
	{
		self openmenu("perk_display");
		thread hideperksaftertime(4);
		thread hideperksondeath();
	}

	waittillframeend;
	self.spawningafterremotedeath = undefined;
	self notify("spawned_player");
	level notify("player_spawned",self);
	if(game["state"] == "postgame")
	{
		maps\mp\gametypes\_gamelogic::freezeplayerforroundend();
	}
}

//Function Number: 20
hideperksaftertime(param_00)
{
	self endon("disconnect");
	self endon("perks_hidden");
	wait param_00;
	self openmenu("perk_hide");
	self notify("perks_hidden");
}

//Function Number: 21
hideperksondeath()
{
	self endon("disconnect");
	self endon("perks_hidden");
	self waittill("death");
	self openmenu("perk_hide");
	self notify("perks_hidden");
}

//Function Number: 22
hideperksonkill()
{
	self endon("disconnect");
	self endon("death");
	self endon("perks_hidden");
	self waittill("killed_player");
	self openmenu("perk_hide");
	self notify("perks_hidden");
}

//Function Number: 23
spawnspectator(param_00,param_01)
{
	self notify("spawned");
	self notify("end_respawn");
	self notify("joined_spectators");
	in_spawnspectator(param_00,param_01);
}

//Function Number: 24
respawn_asspectator(param_00,param_01)
{
	in_spawnspectator(param_00,param_01);
}

//Function Number: 25
in_spawnspectator(param_00,param_01)
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
	onspawnspectator(param_00,param_01);
	if(level.teambased && !level.splitscreen && !self issplitscreenplayer())
	{
		self setdepthoffield(0,128,512,4000,6,1.8);
	}
}

//Function Number: 26
getplayerfromclientnum(param_00)
{
	if(param_00 < 0)
	{
		return undefined;
	}

	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(level.players[var_01] getentitynumber() == param_00)
		{
			return level.players[var_01];
		}
	}

	return undefined;
}

//Function Number: 27
onspawnspectator(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		self setspectatedefaults(param_00,param_01);
		self spawn(param_00,param_01);
		checkpredictedspawnpointcorrectness(param_00);
		return;
	}

	var_02 = "mp_global_intermission";
	var_03 = getentarray(var_02,"classname");
	var_04 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_03);
	self setspectatedefaults(var_04.origin,var_04.angles);
	self spawn(var_04.origin,var_04.angles);
	checkpredictedspawnpointcorrectness(var_04.origin);
}

//Function Number: 28
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
	self setclientdvar("cg_everyoneHearsEveryone",1);
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
		var_00 = 4 + min(self.pers["postGameChallenges"],3);
		while(var_00)
		{
			wait 0.25;
			var_00 = var_00 - 0.25;
			self openmenu(game["menu_endgameupdate"]);
		}

		self closemenu(game["menu_endgameupdate"]);
	}

	self.sessionstate = "intermission";
	maps\mp\_utility::clearkillcamstate();
	self.friendlydamage = undefined;
	var_01 = getentarray("mp_global_intermission","classname");
	var_02 = var_01[0];
	self spawn(var_02.origin,var_02.angles);
	checkpredictedspawnpointcorrectness(var_02.origin);
	self setdepthoffield(0,128,512,4000,6,1.8);
}

//Function Number: 29
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
	self setclientdvar("cg_everyoneHearsEveryone",1);
	self.sessionstate = "dead";
	maps\mp\_utility::clearkillcamstate();
	self.friendlydamage = undefined;
	var_00 = getentarray("mp_global_intermission","classname");
	var_01 = var_00[0];
	self spawn(var_01.origin,var_01.angles);
	checkpredictedspawnpointcorrectness(var_01.origin);
	var_01 setmodel("tag_origin");
	self playerlinkto(var_01);
	self playerhide();
	maps\mp\_utility::freezecontrolswrapper(1);
	self setdepthoffield(0,128,512,4000,6,1.8);
}

//Function Number: 30
setspawnvariables()
{
	self stopshellshock();
	self stoprumble("damage_heavy");
}

//Function Number: 31
notifyconnecting()
{
	waittillframeend;
	if(isdefined(self))
	{
		level notify("connecting",self);
	}
}

//Function Number: 32
callback_playerdisconnect()
{
	if(!isdefined(self.connected))
	{
		return;
	}

	var_00 = getmatchdata("gameLength");
	var_00 = var_00 + int(maps\mp\_utility::getsecondspassed());
	setmatchdata("players",self.clientid,"disconnectTime",var_00);
	if(isdefined(self.pers["confirmed"]))
	{
		maps\mp\_matchdata::logkillsconfirmed();
	}

	if(isdefined(self.pers["denied"]))
	{
		maps\mp\_matchdata::logkillsdenied();
	}

	removeplayerondisconnect();
	if(!level.teambased)
	{
		game["roundsWon"][self.guid] = undefined;
	}

	if(level.splitscreen)
	{
		var_01 = level.players;
		if(var_01.size <= 1)
		{
			level thread maps\mp\gametypes\_gamelogic::forceend();
		}
	}

	if(isdefined(self.score) && isdefined(self.pers["team"]))
	{
		setplayerteamrank(self,self.clientid,self.score - 5 * self.deaths);
	}

	var_02 = self getentitynumber();
	var_03 = self.guid;
	logprint("Q;" + var_03 + ";" + var_02 + ";" + self.name + "\n");
	thread maps\mp\_events::disconnected();
	if(level.gameended)
	{
		lib_036E::func_2B9B();
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
	}
}

//Function Number: 33
removeplayerondisconnect()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(level.players[var_01] == self)
		{
			var_00 = 1;
			while(var_01 < level.players.size - 1)
			{
				level.players[var_01] = level.players[var_01 + 1];
				var_01++;
			}

			level.players[var_01] = undefined;
			break;
		}
	}
}

//Function Number: 34
initclientdvarssplitscreenspecific()
{
	if(level.splitscreen || self issplitscreenplayer())
	{
		self setclientdvars("cg_hudGrenadeIconHeight","37.5","cg_hudGrenadeIconWidth","37.5","cg_hudGrenadeIconOffset","75","cg_hudGrenadePointerHeight","18","cg_hudGrenadePointerWidth","37.5","cg_hudGrenadePointerPivot","18 40.5","cg_fovscale","0.75");
		return;
	}

	self setclientdvars("cg_hudGrenadeIconHeight","25","cg_hudGrenadeIconWidth","25","cg_hudGrenadeIconOffset","50","cg_hudGrenadePointerHeight","12","cg_hudGrenadePointerWidth","25","cg_hudGrenadePointerPivot","12 27","cg_fovscale","1");
}

//Function Number: 35
func_2FF6()
{
	makedvarserverinfo("cg_drawTalk",1);
	makedvarserverinfo("cg_drawCrosshair",1);
	makedvarserverinfo("cg_drawCrosshairNames",1);
	makedvarserverinfo("cg_hudGrenadeIconMaxRangeFrag",250);
	if(level.hardcoremode)
	{
		setdvar("cg_drawTalk",3);
		setdvar("cg_drawCrosshair",0);
		setdvar("cg_drawCrosshairNames",1);
		setdvar("cg_hudGrenadeIconMaxRangeFrag",0);
	}

	self setclientdvars("cg_drawSpectatorMessages",1,"g_compassShowEnemies",getdvar("scr_game_forceuav"),"cg_scoreboardPingGraph",1);
	initclientdvarssplitscreenspecific();
	if(maps\mp\_utility::getgametypenumlives())
	{
		self setclientdvars("cg_deadChatWithDead",1,"cg_deadChatWithTeam",0,"cg_deadHearTeamLiving",0,"cg_deadHearAllLiving",0);
	}
	else
	{
		self setclientdvars("cg_deadChatWithDead",0,"cg_deadChatWithTeam",1,"cg_deadHearTeamLiving",1,"cg_deadHearAllLiving",0);
	}

	if(level.teambased)
	{
		self setclientdvars("cg_everyonehearseveryone",0);
	}

	self setclientdvar("ui_altscene",0);
	if(getdvarint("scr_hitloc_debug"))
	{
		for(var_00 = 0;var_00 < 6;var_00++)
		{
			self setclientdvar("ui_hitloc_" + var_00,"");
		}

		self.hitlocinited = 1;
	}
}

//Function Number: 36
getlowestavailableclientid()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < 30;var_01++)
	{
		foreach(var_03 in level.players)
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			if(var_03.clientid == var_01)
			{
				var_00 = 1;
				break;
			}

			var_00 = 0;
		}

		if(!var_00)
		{
			return var_01;
		}
	}
}

//Function Number: 37
callback_playerconnect()
{
	thread notifyconnecting();
	self.statusicon = "hud_status_connecting";
	self waittill("begin");
	self.statusicon = "";
	var_00 = undefined;
	level notify("connected",self);
	self.connected = 1;
	if(self ishost())
	{
		level.player = self;
	}

	if(!level.splitscreen && !isdefined(self.pers["score"]))
	{
		iprintln(&"MP_CONNECTED",self);
	}

	self.usingonlinedataoffline = self isusingonlinedataoffline();
	func_2FF6();
	initplayerstats();
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		level waittill("eternity");
	}

	self.guid = self getguid();
	var_01 = 0;
	if(!isdefined(self.pers["clientid"]))
	{
		if(game["clientid"] >= 30)
		{
			self.pers["clientid"] = getlowestavailableclientid();
		}
		else
		{
			self.pers["clientid"] = game["clientid"];
		}

		if(game["clientid"] < 30)
		{
			game["clientid"]++;
		}

		var_01 = 1;
	}

	if(var_01)
	{
		maps\mp\killstreaks\_killstreaks::resetadrenaline();
	}

	self.clientid = self.pers["clientid"];
	self.pers["teamKillPunish"] = 0;
	logprint("J;" + self.guid + ";" + self getentitynumber() + ";" + self.name + "\n");
	if(game["clientid"] <= 30 && game["clientid"] != getmatchdata("playerCount"))
	{
		var_02 = 0;
		var_03 = 0;
		setmatchdata("playerCount",game["clientid"]);
		setmatchdata("players",self.clientid,"xuid",self getxuid());
		setmatchdata("players",self.clientid,"gamertag",self.name);
		var_03 = self getplayerdata("connectionIDChunkLow");
		var_02 = self getplayerdata("connectionIDChunkHigh");
		setmatchdata("players",self.clientid,"connectionIDChunkLow",var_03);
		setmatchdata("players",self.clientid,"connectionIDChunkHigh",var_02);
		setmatchclientip(self,self.clientid);
		var_04 = getmatchdata("gameLength");
		var_04 = var_04 + int(maps\mp\_utility::getsecondspassed());
		setmatchdata("players",self.clientid,"connectTime",var_04);
		setmatchdata("players",self.clientid,"startXp",self getplayerdata("experience"));
		if(maps\mp\_utility::matchmakinggame() && maps\mp\_utility::allowteamchoice())
		{
			setmatchdata("players",self.clientid,"team",self.sessionteam);
		}
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

	if(!isdefined(self.pers["assistsToKill"]))
	{
		self.pers["assistsToKill"] = 0;
	}

	if(!isdefined(self.pers["cur_kill_streak_for_nuke"]))
	{
		self.pers["cur_kill_streak_for_nuke"] = 0;
	}

	self.kill_streak = maps\mp\gametypes\_persistance::statget("killStreak");
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
	for(var_05 = 1;var_05 <= 4;var_05++)
	{
		self.saved_actionslotdata[var_05] = spawnstruct();
		self.saved_actionslotdata[var_05].type = "";
		self.saved_actionslotdata[var_05].item = undefined;
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
			maps\mp\gametypes\_menus::addtoteam(maps\mp\gametypes\_menus::getteamassignment(),1);
		}
		else
		{
			maps\mp\gametypes\_menus::addtoteam("spectator",1);
		}

		self setclientdvars("cg_drawSpectatorMessages",0);
		spawnintermission();
		return;
	}

	if(var_01)
	{
		maps\mp\gametypes\_gamelogic::updatelossstats(self);
	}

	level endon("game_ended");
	if(isdefined(level.hostmigrationtimer))
	{
		thread maps\mp\gametypes\_hostmigration::hostmigrationtimerthink();
	}

	if(isdefined(level.onplayerconnectaudioinit))
	{
		[[ level.onplayerconnectaudioinit ]]();
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

		if(maps\mp\_utility::allowteamchoice())
		{
			self [[ level.spectator ]]();
			maps\mp\gametypes\_menus::beginteamchoice();
			return;
		}

		self [[ level.spectator ]]();
		self [[ level.autoassign ]]();
		return;
	}

	maps\mp\gametypes\_menus::addtoteam(self.pers["team"],1);
	if(maps\mp\_utility::isvalidclass(self.pers["class"]))
	{
		thread spawnclient();
		return;
	}

	thread spawnspectator();
	if(self.pers["team"] == "spectator")
	{
		if(maps\mp\_utility::allowteamchoice())
		{
			maps\mp\gametypes\_menus::beginteamchoice();
			return;
		}

		self [[ level.autoassign ]]();
		return;
	}

	maps\mp\gametypes\_menus::beginclasschoice();
}

//Function Number: 38
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

	if(self ishost())
	{
		initclientdvarssplitscreenspecific();
	}

	level.hostmigrationreturnedplayercount++;
	if(level.hostmigrationreturnedplayercount >= level.players.size * 2 / 3)
	{
		level notify("hostmigration_enoughplayers");
	}
}

//Function Number: 39
addlevelstoexperience(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_rank::getrankforxp(param_00);
	var_03 = maps\mp\gametypes\_rank::getrankinfominxp(var_02);
	var_04 = maps\mp\gametypes\_rank::getrankinfomaxxp(var_02);
	var_02 = var_02 + param_00 - var_03 / var_04 - var_03;
	var_02 = var_02 + param_01;
	if(var_02 < 0)
	{
		var_02 = 0;
		var_05 = 0;
	}
	else if(var_03 >= level.maxrank + 1)
	{
		var_03 = level.maxrank;
		var_05 = 1;
	}
	else
	{
		var_05 = var_03 - floor(var_03);
		var_02 = int(floor(var_02));
	}

	var_03 = maps\mp\gametypes\_rank::getrankinfominxp(var_02);
	var_04 = maps\mp\gametypes\_rank::getrankinfomaxxp(var_02);
	return int(var_05 * var_04 - var_03) + var_03;
}

//Function Number: 40
getrestxpcap(param_00)
{
	var_01 = getdvarfloat("scr_restxp_cap");
	return addlevelstoexperience(param_00,var_01);
}

//Function Number: 41
setrestxpgoal()
{
	if(!getdvarint("scr_restxp_enable"))
	{
		self setplayerdata("restXPGoal",0);
		return;
	}

	var_00 = self getrestedtime();
	var_01 = var_00 / 3600;
	var_02 = self getplayerdata("experience");
	var_03 = getdvarfloat("scr_restxp_minRestTime");
	var_04 = getdvarfloat("scr_restxp_levelsPerDay") / 24;
	var_05 = getrestxpcap(var_02);
	var_06 = self getplayerdata("restXPGoal");
	if(var_06 < var_02)
	{
		var_06 = var_02;
	}

	var_07 = var_06;
	var_08 = 0;
	if(var_01 > var_03)
	{
		var_08 = var_04 * var_01;
		var_06 = addlevelstoexperience(var_06,var_08);
	}

	var_09 = "";
	if(var_06 >= var_05)
	{
		var_06 = var_05;
		var_09 = " (hit cap)";
	}

	self setplayerdata("restXPGoal",var_06);
}

//Function Number: 42
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

//Function Number: 43
kickifdontspawn()
{
	self endon("death");
	self endon("disconnect");
	self endon("spawned");
	self endon("attempted_spawn");
	var_00 = getdvarfloat("scr_kick_time",90);
	var_01 = getdvarfloat("scr_kick_mintime",45);
	var_02 = gettime();
	if(self ishost())
	{
		kickwait(120);
	}
	else
	{
		kickwait(var_00);
	}

	var_03 = gettime() - var_02 / 1000;
	if(var_03 < var_00 - 0.1 && var_03 < var_01)
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

	kick(self getentitynumber(),"EXE_PLAYERKICKED_INACTIVE");
	level thread maps\mp\gametypes\_gamelogic::updategameevents();
}

//Function Number: 44
kickwait(param_00)
{
	level endon("game_ended");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
}

//Function Number: 45
updatesessionstate(param_00,param_01)
{
	self.sessionstate = param_00;
	self.statusicon = param_01;
}

//Function Number: 46
initplayerstats()
{
	maps\mp\gametypes\_persistance::initbufferedstats();
	self.pers["lives"] = maps\mp\_utility::getgametypenumlives();
	if(!isdefined(self.pers["deaths"]))
	{
		maps\mp\_utility::initpersstat("deaths");
		maps\mp\gametypes\_persistance::statsetchild("round","deaths",0);
	}

	self.deaths = maps\mp\_utility::getpersstat("deaths");
	if(!isdefined(self.pers["score"]))
	{
		maps\mp\_utility::initpersstat("score");
		maps\mp\gametypes\_persistance::statsetchild("round","score",0);
	}

	self.score = maps\mp\_utility::getpersstat("score");
	if(!isdefined(self.pers["suicides"]))
	{
		maps\mp\_utility::initpersstat("suicides");
	}

	self.suicides = maps\mp\_utility::getpersstat("suicides");
	if(!isdefined(self.pers["kills"]))
	{
		maps\mp\_utility::initpersstat("kills");
		maps\mp\gametypes\_persistance::statsetchild("round","kills",0);
	}

	self.kills = maps\mp\_utility::getpersstat("kills");
	if(!isdefined(self.pers["headshots"]))
	{
		maps\mp\_utility::initpersstat("headshots");
	}

	self.headshots = maps\mp\_utility::getpersstat("headshots");
	if(!isdefined(self.pers["assists"]))
	{
		maps\mp\_utility::initpersstat("assists");
	}

	self.assists = maps\mp\_utility::getpersstat("assists");
	if(!isdefined(self.pers["captures"]))
	{
		maps\mp\_utility::initpersstat("captures");
		maps\mp\gametypes\_persistance::statsetchild("round","captures",0);
	}

	self.var_3015 = maps\mp\_utility::getpersstat("captures");
	if(!isdefined(self.pers["returns"]))
	{
		maps\mp\_utility::initpersstat("returns");
		maps\mp\gametypes\_persistance::statsetchild("round","returns",0);
	}

	self.var_3016 = maps\mp\_utility::getpersstat("returns");
	if(!isdefined(self.pers["defends"]))
	{
		maps\mp\_utility::initpersstat("defends");
		maps\mp\gametypes\_persistance::statsetchild("round","defends",0);
	}

	self.var_3017 = maps\mp\_utility::getpersstat("defends");
	if(!isdefined(self.pers["plants"]))
	{
		maps\mp\_utility::initpersstat("plants");
		maps\mp\gametypes\_persistance::statsetchild("round","plants",0);
	}

	self.var_3018 = maps\mp\_utility::getpersstat("plants");
	if(!isdefined(self.pers["defuses"]))
	{
		maps\mp\_utility::initpersstat("defuses");
		maps\mp\gametypes\_persistance::statsetchild("round","defuses",0);
	}

	self.var_3019 = maps\mp\_utility::getpersstat("defuses");
	if(!isdefined(self.pers["destructions"]))
	{
		maps\mp\_utility::initpersstat("destructions");
		maps\mp\gametypes\_persistance::statsetchild("round","destructions",0);
	}

	self.var_301A = maps\mp\_utility::getpersstat("destructions");
	if(!isdefined(self.pers["confirmed"]))
	{
		maps\mp\_utility::initpersstat("confirmed");
		maps\mp\gametypes\_persistance::statsetchild("round","confirmed",0);
	}

	self.var_301B = maps\mp\_utility::getpersstat("confirmed");
	if(!isdefined(self.pers["denied"]))
	{
		maps\mp\_utility::initpersstat("denied");
		maps\mp\gametypes\_persistance::statsetchild("round","denied",0);
	}

	self.var_301C = maps\mp\_utility::getpersstat("denied");
	if(!isdefined(self.pers["teamkills"]))
	{
		maps\mp\_utility::initpersstat("teamkills");
	}

	if(!isdefined(self.pers["teamKillPunish"]))
	{
		self.pers["teamKillPunish"] = 0;
	}

	maps\mp\_utility::initpersstat("longestStreak");
	self.pers["lives"] = maps\mp\_utility::getgametypenumlives();
	maps\mp\gametypes\_persistance::statsetchild("round","killStreak",0);
	maps\mp\gametypes\_persistance::statsetchild("round","loss",0);
	maps\mp\gametypes\_persistance::statsetchild("round","win",0);
	maps\mp\gametypes\_persistance::statsetchild("round","scoreboardType","none");
	maps\mp\gametypes\_persistance::statsetchildbuffered("round","timePlayed",0);
}

//Function Number: 47
addtoteamcount()
{
	level.teamcount[self.team]++;
	maps\mp\gametypes\_gamelogic::updategameevents();
}

//Function Number: 48
removefromteamcount()
{
	level.teamcount[self.team]--;
}

//Function Number: 49
addtoalivecount()
{
	level.alivecount[self.team]++;
	level.hasspawned[self.team]++;
	if(level.alivecount["allies"] + level.alivecount["axis"] > level.maxplayercount)
	{
		level.maxplayercount = level.alivecount["allies"] + level.alivecount["axis"];
	}
}

//Function Number: 50
removefromalivecount(param_00)
{
	if(isdefined(self.switching_teams) || isdefined(param_00))
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

//Function Number: 51
addtolivescount()
{
	level.livescount[self.team] = level.livescount[self.team] + self.pers["lives"];
}

//Function Number: 52
removefromlivescount()
{
	level.livescount[self.team]--;
	level.livescount[self.team] = int(max(0,level.livescount[self.team]));
}

//Function Number: 53
removeallfromlivescount()
{
	level.livescount[self.team] = level.livescount[self.team] - self.pers["lives"];
	level.livescount[self.team] = int(max(0,level.livescount[self.team]));
}