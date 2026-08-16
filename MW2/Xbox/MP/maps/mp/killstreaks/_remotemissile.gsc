/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_remotemissile.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	mapname = getdvar("mapname");
	if(mapname == "mp_suburbia")
	{
		level.missileremotelaunchvert = 7000;
		level.missileremotelaunchhorz = 10000;
		level.missileremotelaunchtargetdist = 2000;
	}
	else if(mapname == "mp_mainstreet")
	{
		level.missileremotelaunchvert = 7000;
		level.missileremotelaunchhorz = 10000;
		level.missileremotelaunchtargetdist = 2000;
	}
	else
	{
		level.missileremotelaunchvert = 14000;
		level.missileremotelaunchhorz = 7000;
		level.missileremotelaunchtargetdist = 1500;
	}

	precacheitem("remotemissile_projectile_mp");
	precacheshader("ac130_overlay_grain");
	precachestring(&"MP_CIVILIAN_AIR_TRAFFIC");
	level.rockets = [];
	level.killstreakfuncs["predator_missile"] = ::tryusepredatormissile;
	level.missilesforsighttraces = [];
}

tryusepredatormissile(lifeid)
{
	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	maps\mp\_utility::setusingremote("remotemissile");
	result = maps\mp\killstreaks\_killstreaks::initridekillstreak();
	if(result != "success")
	{
		if(result != "disconnect")
		{
			maps\mp\_utility::clearusingremote();
		}

		return 0;
	}

	level thread _fire(lifeid, self);
	return 1;
}

getbestspawnpoint(param_CA9)
{
	validenemies = [];
	foreach(spawnpoint in param_CA9)
	{
		spawnpoint.validplayers = [];
		spawnpoint.spawnscore = 0;
	}

	foreach(player in level.players)
	{
		if(!maps\mp\_utility::isreallyalive(player))
		{
			continue;
		}

		if(player.team == self.team)
		{
			continue;
		}

		if(player.team == "spectator")
		{
			continue;
		}

		bestdistance = 999999999;
		bestspawnpoint = undefined;
		foreach(spawnpoint in param_CA9)
		{
			spawnpoint.validplayers[spawnpoint.validplayers.size] = player;
			potentialbestdistance = distance2d(spawnpoint.targetent.origin, player.origin);
			if(potentialbestdistance <= bestdistance)
			{
				bestdistance = potentialbestdistance;
				bestspawnpoint = spawnpoint;
			}
		}

		bestspawnpoint.spawnscore = bestspawnpoint.spawnscore + 2;
	}

	bestspawn = param_CA9[0];
	foreach(spawnpoint in param_CA9)
	{
		foreach(player in spawnpoint.validplayers)
		{
			spawnpoint.spawnscore = spawnpoint.spawnscore + 1;
			if(bullettracepassed(player.origin + (0,0,32), spawnpoint.origin, 0, player))
			{
				spawnpoint.spawnscore = spawnpoint.spawnscore + 3;
			}

			if(spawnpoint.spawnscore > bestspawn.spawnscore)
			{
				bestspawn = spawnpoint;
				continue;
			}

			if(spawnpoint.spawnscore == bestspawn.spawnscore)
			{
				if(common_scripts\utility::cointoss())
				{
					bestspawn = spawnpoint;
				}
			}
		}
	}

	return bestspawn;
}

drawline(start, end, timeslice, color)
{
	drawtime = int(timeslice * 20);
	for(time = 0;time < drawtime;time++)
	{
		wait 0.05;
	}
}

_fire(lifeid, player)
{
	remotemissilespawnarray = getentarray("remoteMissileSpawn", "targetname");
	foreach(spawn in remotemissilespawnarray)
	{
		if(isdefined(spawn.target))
		{
			spawn.targetent = getent(spawn.target, "targetname");
		}
	}

	if(remotemissilespawnarray.size > 0)
	{
		remotemissilespawn = player getbestspawnpoint(remotemissilespawnarray);
	}
	else
	{
		remotemissilespawn = undefined;
	}

	if(isdefined(remotemissilespawn))
	{
		startpos = remotemissilespawn.origin;
		targetpos = remotemissilespawn.targetent.origin;
		vector = vectornormalize(startpos - targetpos);
		startpos = common_scripts\utility::vector_multiply(vector, 14000) + targetpos;
		rocket = magicbullet("remotemissile_projectile_mp", startpos, targetpos, player);
	}
	else
	{
		upvector = (0,0,level.missileremotelaunchvert);
		backdist = level.missileremotelaunchhorz;
		targetdist = level.missileremotelaunchtargetdist;
		forward = anglestoforward(player.angles);
		startpos = player.origin + upvector + forward * backdist * -1;
		targetpos = player.origin + forward * targetdist;
		rocket = magicbullet("remotemissile_projectile_mp", startpos, targetpos, player);
	}

	if(!isdefined(rocket))
	{
		player maps\mp\_utility::clearusingremote();
		return;
	}

	rocket thread maps\mp\gametypes\_weapons::addmissiletosighttraces(player.team);
	rocket thread handledamage();
	rocket.lifeid = lifeid;
	rocket.type = "remote";
	missileeyes(player, rocket);
}

handledamage()
{
	self endon("death");
	self endon("deleted");
	self setcandamage(1);
	self waittill("damage");
}

missileeyes(player, rocket)
{
	player endon("joined_team");
	player endon("joined_spectators");
	rocket thread rocket_cleanupondeath();
	player thread player_cleanupongameended(rocket);
	player thread player_cleanuponteamchange(rocket);
	player visionsetmissilecamforplayer("black_bw", 0);
	player endon("disconnect");
	if(isdefined(rocket))
	{
		player visionsetmissilecamforplayer(game["thermal_vision"], 1);
		player thread delayedfofoverlay();
		player cameralinkto(rocket, "tag_origin");
		player controlslinkto(rocket);
		if(getdvarint("camera_thirdPerson"))
		{
			player maps\mp\_utility::setthirdpersondof(0);
		}

		rocket waittill("death");
		if(isdefined(rocket))
		{
			player maps\mp\_matchdata::logkillstreakevent("predator_missile", rocket.origin);
		}

		player controlsunlink();
		player maps\mp\_utility::freezecontrolswrapper(1);
		if(!level.gameended || isdefined(player.finalkill))
		{
			player thread staticeffect(0.5);
		}

		wait 0.5;
		player thermalvisionfofoverlayoff();
		player cameraunlink();
		if(getdvarint("camera_thirdPerson"))
		{
			player maps\mp\_utility::setthirdpersondof(1);
		}
	}

	player maps\mp\_utility::clearusingremote();
}

delayedfofoverlay()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait 0.15;
	self thermalvisionfofoverlayon();
}

staticeffect(duration)
{
	self endon("disconnect");
	staticbg = newclienthudelem(self);
	staticbg.horzalign = "fullscreen";
	staticbg.vertalign = "fullscreen";
	staticbg setshader("white", 640, 480);
	staticbg.archive = 1;
	staticbg.sort = 10;
	static = newclienthudelem(self);
	static.horzalign = "fullscreen";
	static.vertalign = "fullscreen";
	static setshader("ac130_overlay_grain", 640, 480);
	static.archive = 1;
	static.sort = 20;
	wait duration;
	static destroy();
	staticbg destroy();
}

player_cleanuponteamchange(rocket)
{
	rocket endon("death");
	self endon("disconnect");
	common_scripts\utility::waittill_any("joined_team", "joined_spectators");
	if(self.team != "spectator")
	{
		self thermalvisionfofoverlayoff();
		self controlsunlink();
		self cameraunlink();
		if(getdvarint("camera_thirdPerson"))
		{
			maps\mp\_utility::setthirdpersondof(1);
		}
	}

	maps\mp\_utility::clearusingremote();
	level.remotemissileinprogress = undefined;
}

rocket_cleanupondeath()
{
	entitynumber = self getentitynumber();
	level.rockets[entitynumber] = self;
	self waittill("death");
	level.rockets[entitynumber] = undefined;
}

player_cleanupongameended(rocket)
{
	rocket endon("death");
	self endon("death");
	level waittill("game_ended");
	self thermalvisionfofoverlayoff();
	self controlsunlink();
	self cameraunlink();
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(1);
		return;
	}
}