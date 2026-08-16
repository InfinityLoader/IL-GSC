/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_nuke.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	precacheitem("nuke_mp");
	precachelocationselector("map_nuke_selector");
	precachestring(&"MP_TACTICAL_NUKE_CALLED");
	precachestring(&"MP_FRIENDLY_TACTICAL_NUKE");
	precachestring(&"MP_TACTICAL_NUKE");
	level._effect["nuke_player"] = loadfx("explosions/player_death_nuke");
	level._effect["nuke_flash"] = loadfx("explosions/player_death_nuke_flash");
	level._effect["nuke_aftermath"] = loadfx("dust/nuke_aftermath_mp");
	game["strings"]["nuclear_strike"] = &"MP_TACTICAL_NUKE";
	level.killstreakfuncs["nuke"] = ::tryusenuke;
	setdvarifuninitialized("scr_nukeTimer", 10);
	setdvarifuninitialized("scr_nukeCancelMode", 0);
	level.nuketimer = getdvarint("scr_nukeTimer");
	level.cancelmode = getdvarint("scr_nukeCancelMode");
}

tryusenuke(lifeid, allowcancel)
{
	if(isdefined(level.nukeincoming))
	{
		self iprintlnbold(&"MP_NUKE_ALREADY_INBOUND");
		return 0;
	}

	if(maps\mp\_utility::isusingremote() && !isdefined(level.gtnw) || !level.gtnw)
	{
		return 0;
	}

	if(!isdefined(allowcancel))
	{
		allowcancel = 1;
	}

	thread donuke(allowcancel);
	self notify("used_nuke");
	return 1;
}

delaythread_nuke(delay, func)
{
	level endon("nuke_cancelled");
	wait delay;
	thread [[ func ]]();
}

donuke(allowcancel)
{
	level endon("nuke_cancelled");
	level.nukeinfo = spawnstruct();
	level.nukeinfo.player = self;
	level.nukeinfo.team = self.pers["team"];
	level.nukeincoming = 1;
	maps\mp\gametypes\_gamelogic::pausetimer();
	level.timelimitoverride = 1;
	setgameendtime(int(gettime() + level.nuketimer * 1000));
	setdvar("ui_bomb_timer", 4);
	if(level.teambased)
	{
		thread maps\mp\_utility::teamplayercardsplash("used_nuke", self, self.team);
	}
	else if(!level.hardcoremode)
	{
		self iprintlnbold(&"MP_FRIENDLY_TACTICAL_NUKE");
	}

	level thread delaythread_nuke(level.nuketimer - 3.3, ::nukesoundincoming);
	level thread delaythread_nuke(level.nuketimer, ::nukesoundexplosion);
	level thread delaythread_nuke(level.nuketimer, ::nukeslowmo);
	level thread delaythread_nuke(level.nuketimer, ::nukeeffects);
	level thread delaythread_nuke(level.nuketimer + 0.25, ::nukevision);
	level thread delaythread_nuke(level.nuketimer + 1.5, ::nukedeath);
	level thread delaythread_nuke(level.nuketimer + 1.5, ::nukeearthquake);
	level thread nukeaftermatheffect();
	if(level.cancelmode && allowcancel)
	{
		level thread cancelnukeondeath(self);
	}

	clockobject = spawn("script_origin", (0,0,0));
	clockobject hide();
	while(!isdefined(level.nukedetonated))
	{
		clockobject playsound("ui_mp_nukebomb_timer");
		wait 1;
	}
}

cancelnukeondeath(player)
{
	player common_scripts\utility::waittill_any("death", "disconnect");
	if(isdefined(player) && level.cancelmode == 2)
	{
		player thread maps\mp\killstreaks\_emp::emp_use(0, 0);
	}

	maps\mp\gametypes\_gamelogic::resumetimer();
	level.timelimitoverride = 0;
	setdvar("ui_bomb_timer", 0);
	level notify("nuke_cancelled");
}

nukesoundincoming()
{
	level endon("nuke_cancelled");
	foreach(player in level.players)
	{
		player playlocalsound("nuke_incoming");
	}
}

nukesoundexplosion()
{
	level endon("nuke_cancelled");
	foreach(player in level.players)
	{
		player playlocalsound("nuke_explosion");
		player playlocalsound("nuke_wave");
	}
}

nukeeffects()
{
	level endon("nuke_cancelled");
	setdvar("ui_bomb_timer", 0);
	setgameendtime(0);
	level.nukedetonated = 1;
	level maps\mp\killstreaks\_emp::destroyactivevehicles(level.nukeinfo.player);
	foreach(player in level.players)
	{
		playerforward = anglestoforward(player.angles);
		playerforward = (playerforward[0],playerforward[1],0);
		playerforward = vectornormalize(playerforward);
		nukedistance = 5000;
		nukeent = spawn("script_model", player.origin + common_scripts\utility::vector_multiply(playerforward, nukedistance));
		nukeent setmodel("tag_origin");
		nukeent.angles = (0,player.angles[1] + 180,90);
		nukeent thread nukeeffect(player);
		player.nuked = 1;
	}
}

nukeeffect(player)
{
	level endon("nuke_cancelled");
	player endon("disconnect");
	common_scripts\utility::waitframe();
	playfxontagforclients(level._effect["nuke_flash"], self, "tag_origin", player);
}

nukeaftermatheffect()
{
	level endon("nuke_cancelled");
	level waittill("spawning_intermission");
	afermathent = getentarray("mp_global_intermission", "classname");
	afermathent = afermathent[0];
	up = anglestoup(afermathent.angles);
	right = anglestoright(afermathent.angles);
	playfx(level._effect["nuke_aftermath"], afermathent.origin, up, right);
}

nukeslowmo()
{
	level endon("nuke_cancelled");
	setslowmotion(1, 0.25, 0.5);
	level waittill("nuke_death");
	setslowmotion(0.25, 1, 2);
}

nukevision()
{
	level endon("nuke_cancelled");
	level.nukevisioninprogress = 1;
	visionsetnaked("mpnuke", 3);
	level waittill("nuke_death");
	visionsetnaked("mpnuke_aftermath", 5);
	wait 5;
	level.nukevisioninprogress = undefined;
}

nukedeath()
{
	level endon("nuke_cancelled");
	level notify("nuke_death");
	maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	ambientstop(1);
	foreach(player in level.players)
	{
		if(isalive(player))
		{
			player thread maps\mp\gametypes\_damage::finishplayerdamagewrapper(level.nukeinfo.player, level.nukeinfo.player, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", player.origin, player.origin, "none", 0, 0);
		}
	}

	level.postroundtime = 10;
	nukeendsgame = 1;
	if(level.teambased)
	{
		thread maps\mp\gametypes\_gamelogic::endgame(level.nukeinfo.team, game["strings"]["nuclear_strike"], 1);
		return;
	}

	if(isdefined(level.nukeinfo.player))
	{
		thread maps\mp\gametypes\_gamelogic::endgame(level.nukeinfo.player, game["strings"]["nuclear_strike"], 1);
		return;
	}

	thread maps\mp\gametypes\_gamelogic::endgame(level.nukeinfo, game["strings"]["nuclear_strike"], 1);
}

nukeearthquake()
{
	level endon("nuke_cancelled");
	level waittill("nuke_death");
}

waitfornukecancel()
{
	self waittill("cancel_location");
	self setblurforplayer(0, 0.3);
}

endselectionon(waitfor)
{
	self endon("stop_location_selection");
	self waittill(waitfor);
	thread stopnukelocationselection(waitfor == "disconnect");
}

endselectionongameend()
{
	self endon("stop_location_selection");
	level waittill("game_ended");
	thread stopnukelocationselection(0);
}

stopnukelocationselection(disconnected)
{
	if(!disconnected)
	{
		self setblurforplayer(0, 0.3);
		self endlocationselection();
		self.selectinglocation = undefined;
	}

	self notify("stop_location_selection");
}