/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_uav.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	precachestring(&"MP_WAR_RADAR_ACQUIRED");
	precachestring(&"MP_WAR_RADAR_ACQUIRED_ENEMY");
	precachestring(&"MP_WAR_RADAR_EXPIRED");
	precachestring(&"MP_WAR_RADAR_EXPIRED_ENEMY");
	precachestring(&"MP_WAR_COUNTER_RADAR_ACQUIRED");
	precachestring(&"MP_WAR_COUNTER_RADAR_ACQUIRED_ENEMY");
	precachestring(&"MP_WAR_COUNTER_RADAR_EXPIRED");
	precachestring(&"MP_WAR_COUNTER_RADAR_EXPIRED_ENEMY");
	precachemodel("vehicle_uav_static_mp");
	level.radarviewtime = 30;
	level.uavblocktime = 30;
	level.uav_fx["explode"] = loadfx("explosions/helicopter_explosion_cobra_low");
	level.killstreakfuncs["uav"] = ::tryuseuav;
	level.killstreakfuncs["double_uav"] = ::tryusedoubleuav;
	level.killstreakfuncs["counter_uav"] = ::tryusecounteruav;
	minimaporigins = getentarray("minimap_corner", "targetname");
	if(minimaporigins.size)
	{
		uavorigin = maps\mp\gametypes\_spawnlogic::findboxcenter(minimaporigins[0].origin, minimaporigins[1].origin);
	}
	else
	{
		uavorigin = (0,0,0);
	}

	level.uavrig = spawn("script_model", uavorigin);
	level.uavrig setmodel("c130_zoomrig");
	level.uavrig.angles = (0,115,0);
	level.uavrig hide();
	level.uavrig thread rotateuavrig();
	if(level.teambased)
	{
		level.radarmode["allies"] = "normal_radar";
		level.radarmode["axis"] = "normal_radar";
		level.activeuavs["allies"] = 0;
		level.activeuavs["axis"] = 0;
		level.activecounteruavs["allies"] = 0;
		level.activecounteruavs["axis"] = 0;
		level.uavmodels["allies"] = [];
		level.uavmodels["axis"] = [];
	}
	else
	{
		level.radarmode = [];
		level.activeuavs = [];
		level.activecounteruavs = [];
		level.uavmodels = [];
		level thread onplayerconnect();
	}

	level thread uavtracker();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		level.activeuavs[player.guid] = 0;
		level.activecounteruavs[player.guid] = 0;
		level.radarmode[player.guid] = "normal_radar";
	}
}

rotateuavrig()
{
	for(;;)
	{
		self rotateyaw(-360, 60);
		wait 60;
	}
}

launchuav(owner, team, duration, param_CC8)
{
	uavmodel = spawn("script_model", level.uavrig gettagorigin("tag_origin"));
	uavmodel setmodel("vehicle_uav_static_mp");
	uavmodel thread damagetracker(param_CC8);
	uavmodel.team = team;
	uavmodel.owner = owner;
	uavmodel thread handleincomingstinger();
	adduavmodel(uavmodel);
	zoffset = randomintrange(3000, 5000);
	angle = randomint(360);
	radiusoffset = randomint(2000) + 5000;
	xoffset = cos(angle) * radiusoffset;
	yoffset = sin(angle) * radiusoffset;
	anglevector = vectornormalize((xoffset,yoffset,zoffset));
	anglevector = common_scripts\utility::vector_multiply(anglevector, randomintrange(6000, 7000));
	uavmodel linkto(level.uavrig, "tag_origin", anglevector, (0,angle - 90,0));
	uavmodel thread updateuavmodelvisibility();
	if(param_CC8)
	{
		uavmodel addactivecounteruav();
	}
	else
	{
		uavmodel addactiveuav();
	}

	level notify("uav_update");
	uavmodel waittill_notify_or_timeout_hostmigration_pause("death", duration - 7);
	if(uavmodel.health <= 0)
	{
		forward = common_scripts\utility::vector_multiply(anglestoright(uavmodel.angles), 200);
		playfx(level.uav_fx["explode"], uavmodel.origin, forward);
	}
	else
	{
		uavmodel unlink();
		destpoint = uavmodel.origin + common_scripts\utility::vector_multiply(anglestoforward(uavmodel.angles), 20000);
		uavmodel moveto(destpoint, 60);
		playfxontag(level._effect["ac130_engineeffect"], uavmodel, "tag_origin");
		uavmodel waittill_notify_or_timeout_hostmigration_pause("death", 3);
		uavmodel moveto(destpoint, 4, 4, 0);
		uavmodel waittill_notify_or_timeout_hostmigration_pause("death", 4);
	}

	if(param_CC8)
	{
		uavmodel removeactivecounteruav();
	}
	else
	{
		uavmodel removeactiveuav();
	}

	uavmodel delete();
	removeuavmodel(uavmodel);
	level notify("uav_update");
}

waittill_notify_or_timeout_hostmigration_pause(msg, timer)
{
	self endon(msg);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(timer);
}

updateuavmodelvisibility()
{
	self endon("death");
	for(;;)
	{
		level common_scripts\utility::waittill_either("joined_team", "uav_update");
		self hide();
		foreach(player in level.players)
		{
			if(level.teambased)
			{
				if(player.team != self.team)
				{
					self showtoplayer(player);
				}

				continue;
			}

			if(isdefined(self.owner) && player == self.owner)
			{
				continue;
			}

			self showtoplayer(player);
		}
	}
}

damagetracker(param_CCC)
{
	level endon("game_ended");
	self setcandamage(1);
	self.maxhealth = 700;
	self.health = self.maxhealth;
	for(;;)
	{
		self waittill("damage", damage, attacker, direction_vec, point, smeansofdeath);
		if(!isplayer(attacker))
		{
			if(!isdefined(self))
			{
				return;
			}

			continue;
		}

		attacker maps\mp\gametypes\_damagefeedback::updatedamagefeedback("");
		if(attacker maps\mp\_utility::_hasperk("specialty_armorpiercing") && isdefined(self))
		{
			damageadd = damage * level.armorpiercingmod;
			self.health = self.health - int(damageadd);
		}

		if(!isdefined(self))
		{
			if(isplayer(attacker) && !isdefined(self.owner) || attacker != self.owner)
			{
				if(param_CCC)
				{
					thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_counter_uav", attacker);
				}
				else
				{
					thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_uav", attacker);
				}

				thread maps\mp\gametypes\_missions::vehiclekilled(self.owner, self, undefined, attacker, damage, smeansofdeath);
				attacker thread maps\mp\gametypes\_rank::giverankxp("kill", 50);
				attacker notify("destroyed_killstreak");
			}

			return;
		}
	}
}

tryuseuav(lifeid)
{
	return useuav("uav");
}

tryusedoubleuav(lifeid)
{
	return useuav("double_uav");
}

tryusecounteruav(lifeid)
{
	return useuav("counter_uav");
}

useuav(param_CCD)
{
	maps\mp\_matchdata::logkillstreakevent(param_CCD, self.origin);
	team = self.pers["team"];
	usetime = level.radarviewtime;
	level thread launchuav(self, team, usetime, param_CCD == "counter_uav");
	if(param_CCD == "counter_uav")
	{
		self notify("used_counter_uav");
	}
	else
	{
		self notify("used_uav");
	}

	return 1;
}

uavtracker()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("uav_update");
		if(level.teambased)
		{
			updateteamuavstatus("allies");
			updateteamuavstatus("axis");
			continue;
		}

		updateplayersuavstatus();
	}
}

updateteamuavstatus(team)
{
	activeuavs = level.activeuavs[team];
	activecounteruavs = level.activecounteruavs[level.otherteam[team]];
	if(!activecounteruavs)
	{
		unblockteamradar(team);
	}
	else
	{
		blockteamradar(team);
	}

	if(!activeuavs)
	{
		setteamradarwrapper(team, 0);
		return;
	}

	if(activeuavs > 1)
	{
		level.radarmode[team] = "fast_radar";
	}
	else
	{
		level.radarmode[team] = "normal_radar";
	}

	updateteamuavtype();
	setteamradarwrapper(team, 1);
}

updateplayersuavstatus()
{
	totalactivecounteruavs = 0;
	counteruavplayer = undefined;
	foreach(player in level.players)
	{
		activeuavs = level.activeuavs[player.guid];
		activecounteruavs = level.activecounteruavs[player.guid];
		if(activecounteruavs)
		{
			totalactivecounteruavs++;
			counteruavplayer = player;
		}

		if(!activeuavs)
		{
			player.hasradar = 0;
			player.radarmode = "normal_radar";
			continue;
		}

		if(activeuavs > 1)
		{
			player.radarmode = "fast_radar";
		}
		else
		{
			player.radarmode = "normal_radar";
		}

		player.hasradar = 1;
	}

	foreach(player in level.players)
	{
		if(!totalactivecounteruavs)
		{
			player.isradarblocked = 0;
			continue;
		}

		if(totalactivecounteruavs == 1 && player == counteruavplayer)
		{
			player.isradarblocked = 0;
			continue;
		}

		player.isradarblocked = 1;
	}
}

blockplayeruav()
{
	self endon("disconnect");
	self notify("blockPlayerUAV");
	self endon("blockPlayerUAV");
	self.isradarblocked = 1;
	wait level.uavblocktime;
	self.isradarblocked = 0;
}

updateteamuavtype()
{
	foreach(player in level.players)
	{
		if(player.team == "spectator")
		{
			continue;
		}

		player.radarmode = level.radarmode[player.team];
	}
}

useplayeruav(doubleuav, usetime)
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("usePlayerUAV");
	self endon("usePlayerUAV");
	if(doubleuav)
	{
		self.radarmode = "fast_radar";
	}
	else
	{
		self.radarmode = "normal_radar";
	}

	self.hasradar = 1;
	wait usetime;
	self.hasradar = 0;
}

setteamradarwrapper(team, value)
{
	setteamradar(team, value);
	level notify("radar_status_change", team);
}

handleincomingstinger()
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("stinger_fired", player, missile, locktarget);
		if(!isdefined(locktarget) || locktarget != self)
		{
			continue;
		}

		missile thread stingerproximitydetonate(locktarget, player);
	}
}

stingerproximitydetonate(targetent, player)
{
	self endon("death");
	mindist = distance(self.origin, targetent getpointinbounds(0, 0, 0));
	lastcenter = targetent getpointinbounds(0, 0, 0);
	for(;;)
	{
		if(!isdefined(targetent))
		{
			center = lastcenter;
		}
		else
		{
			center = targetent getpointinbounds(0, 0, 0);
		}

		lastcenter = center;
		curdist = distance(self.origin, center);
		if(curdist < mindist)
		{
			mindist = curdist;
		}

		if(curdist > mindist)
		{
			if(curdist > 1536)
			{
				return;
			}

			radiusdamage(self.origin, 1536, 600, 600, player);
			playfx(level.stingerfxid, self.origin);
			self hide();
			self notify("deleted");
			wait 0.05;
			self delete();
			player notify("killstreak_destroyed");
		}

		wait 0.05;
	}
}

adduavmodel(uavmodel)
{
	if(level.teambased)
	{
		level.uavmodels[uavmodel.team][level.uavmodels[uavmodel.team].size] = uavmodel;
		return;
	}

	level.uavmodels[uavmodel.owner.guid + "_" + gettime()] = uavmodel;
}

removeuavmodel(uavmodel)
{
	uavmodels = [];
	if(level.teambased)
	{
		team = uavmodel.team;
		foreach(uavmodel in level.uavmodels[team])
		{
			if(!isdefined(uavmodel))
			{
				continue;
			}

			uavmodels[uavmodels.size] = uavmodel;
		}

		level.uavmodels[team] = uavmodels;
		return;
	}

	foreach(uavmodel in level.uavmodels)
	{
		if(!isdefined(uavmodel))
		{
			continue;
		}

		uavmodels[uavmodels.size] = uavmodel;
	}

	level.uavmodels = uavmodels;
}

addactiveuav()
{
	if(level.teambased)
	{
		level.activeuavs[self.team]++;
		return;
	}

	level.activeuavs[self.owner.guid]++;
}

addactivecounteruav()
{
	if(level.teambased)
	{
		level.activecounteruavs[self.team]++;
		return;
	}

	level.activecounteruavs[self.owner.guid]++;
}

removeactiveuav()
{
	if(level.teambased)
	{
		level.activeuavs[self.team]--;
		if(!level.activeuavs[self.team])
		{
			return;
		}

		return;
	}

	if(isdefined(self.owner))
	{
		level.activeuavs[self.owner.guid]--;
		return;
	}
}

removeactivecounteruav()
{
	if(level.teambased)
	{
		level.activecounteruavs[self.team]--;
		if(!level.activecounteruavs[self.team])
		{
			return;
		}

		return;
	}

	if(isdefined(self.owner))
	{
		level.activecounteruavs[self.owner.guid]--;
		return;
	}
}