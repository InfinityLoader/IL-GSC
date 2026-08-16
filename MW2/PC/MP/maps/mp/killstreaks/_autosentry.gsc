/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_autosentry.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	level.sentrytype = [];
	level.sentrytype["sentry_minigun"] = "sentry";
	level.killstreakfuncs[level.sentrytype["sentry_minigun"]] = ::tryuseautosentry;
	level.sentrysettings = [];
	level.sentrysettings["sentry_minigun"] = spawnstruct();
	level.sentrysettings["sentry_minigun"].burstmin = 20;
	level.sentrysettings["sentry_minigun"].burstmax = 120;
	level.sentrysettings["sentry_minigun"].pausemin = 0.15;
	level.sentrysettings["sentry_minigun"].pausemax = 0.35;
	level.sentrysettings["sentry_minigun"].weaponinfo = "sentry_minigun_mp";
	level.sentrysettings["sentry_minigun"].modelbase = "sentry_minigun";
	level.sentrysettings["sentry_minigun"].modelplacement = "sentry_minigun_obj";
	level.sentrysettings["sentry_minigun"].modelplacementfailed = "sentry_minigun_obj_red";
	level.sentrysettings["sentry_minigun"].modeldestroyed = "sentry_minigun_destroyed";
	foreach(sentryinfo in level.sentrysettings)
	{
		precacheitem(sentryinfo.weaponinfo);
		precachemodel(sentryinfo.modelbase);
		precachemodel(sentryinfo.modelplacement);
		precachemodel(sentryinfo.modelplacementfailed);
		precachemodel(sentryinfo.modeldestroyed);
	}

	level._effect["sentry_overheat_mp"] = loadfx("smoke/sentry_turret_overheat_smoke");
	level._effect["sentry_explode_mp"] = loadfx("explosions/sentry_gun_explosion");
	level._effect["sentry_smoke_mp"] = loadfx("smoke/car_damage_blacksmoke");
}

tryuseautosentry(lifeid)
{
	result = givesentry("sentry_minigun");
	if(result)
	{
		maps\mp\_matchdata::logkillstreakevent("sentry", self.origin);
	}

	return result;
}

tryuseautoglsentry(lifeid)
{
	result = givesentry("sentry_gun");
	if(result)
	{
		maps\mp\_matchdata::logkillstreakevent("sentry_gl", self.origin);
	}

	return result;
}

givesentry(sentrytype)
{
	self.last_sentry = sentrytype;
	sentrygun = createsentryforplayer(sentrytype, self);
	setcarryingsentry(sentrygun, 1);
	if(isdefined(sentrygun))
	{
		return 1;
	}

	return 0;
}

setcarryingsentry(sentrygun, allowcancel)
{
	self endon("death");
	self endon("disconnect");
	sentrygun sentry_setcarried(self);
	common_scripts\utility::_disableweapon();
	self notifyonplayercommand("place_sentry", "+attack");
	self notifyonplayercommand("cancel_sentry", "+actionslot 4");
	for(;;)
	{
		result = common_scripts\utility::waittill_any_return("place_sentry", "cancel_sentry");
		if(result == "cancel_sentry")
		{
			if(!allowcancel)
			{
				continue;
			}

			sentrygun sentry_setcancelled();
			common_scripts\utility::_enableweapon();
			return 0;
		}

		if(!sentrygun.canbeplaced)
		{
			continue;
		}

		sentrygun sentry_setplaced();
		common_scripts\utility::_enableweapon();
		return 1;
	}
}

createsentryforplayer(sentrytype, owner)
{
	sentrygun = spawnturret("misc_turret", owner.origin, level.sentrysettings[sentrytype].weaponinfo);
	sentrygun.angles = owner.angles;
	sentrygun sentry_initsentry(sentrytype, owner);
	return sentrygun;
}

sentry_initsentry(sentrytype, owner)
{
	self.sentrytype = sentrytype;
	self setmodel(level.sentrysettings[self.sentrytype].modelbase);
	self.health = 1000;
	self setcandamage(1);
	self maketurretinoperable();
	self setturretmodechangewait(1);
	sentry_setinactive();
	self setdefaultdroppitch(-89);
	sentry_setowner(owner);
	thread sentry_handleowner();
	thread sentry_handledamage();
	thread sentry_handledeath();
	thread sentry_handleuse();
	thread sentry_timeout();
	thread sentry_attacktargets();
	thread sentry_beepsounds();
}

sentry_handledamage()
{
	healthbuffer = 20000;
	self.health = self.health + healthbuffer;
	while(self.health > 0)
	{
		self waittill("damage", amount, attacker, dir, point, type);
		if(isdefined(attacker) && isplayer(attacker) && attacker != self.owner && attacker isfriendlytosentry(self) && !isdefined(level.nukedetonated))
		{
			self.health = self.health + amount;
			continue;
		}

		if(maps\mp\_utility::isexplosivedamage(type))
		{
			self.health = self.health - amount * 1;
		}

		if(type == "MOD_MELEE")
		{
			self.health = 0;
		}

		if(isplayer(attacker))
		{
			attacker maps\mp\gametypes\_damagefeedback::updatedamagefeedback("sentry");
			if(attacker maps\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				damageadd = amount * level.armorpiercingmod;
				self.health = self.health - int(damageadd);
			}
		}

		if(self.health - healthbuffer < 0)
		{
			thread maps\mp\gametypes\_missions::vehiclekilled(self.owner, self, undefined, attacker, amount, type);
			if(isplayer(attacker) && !isdefined(self.owner) || attacker != self.owner)
			{
				attacker thread maps\mp\gametypes\_rank::giverankxp("kill", 100);
				attacker notify("destroyed_killstreak");
			}

			if(isdefined(self.owner))
			{
				self.owner thread maps\mp\_utility::leaderdialogonplayer("sentry_destroyed");
			}

			self notify("death");
			return;
		}
	}
}

sentry_handledeath()
{
	entnum = self getentitynumber();
	addtoturretlist(entnum);
	self waittill("death");
	removefromturretlist(entnum);
	if(!isdefined(self))
	{
		return;
	}

	self setmodel(level.sentrysettings[self.sentrytype].modeldestroyed);
	sentry_setinactive();
	self setdefaultdroppitch(40);
	self setsentryowner(undefined);
	self setturretminimapvisible(0);
	self playsound("sentry_explode");
	playfxontag(common_scripts\utility::getfx("sentry_explode_mp"), self, "tag_aim");
	self endon("death");
	wait 1.5;
	self playsound("sentry_explode_smoke");
	smoketime = 8;
	while(smoketime > 0)
	{
		playfxontag(common_scripts\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
		wait 0.4;
		smoketime = smoketime - 0.4;
	}

	self delete();
}

sentry_handleuse()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger", player);
		if(!maps\mp\_utility::isreallyalive(player))
		{
			continue;
		}

		player setcarryingsentry(self, 0);
	}
}

sentry_handleowner()
{
	self endon("death");
	level endon("game_ended");
	self notify("sentry_handleOwner");
	self endon("sentry_handleOwner");
	self.owner common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
	self notify("death");
}

sentry_setowner(owner)
{
	self.owner = owner;
	self setsentryowner(self.owner);
	self setturretminimapvisible(1);
	if(level.teambased)
	{
		self.team = self.owner.team;
		self setturretteam(self.team);
	}

	thread sentry_handleowner();
}

sentry_setplaced()
{
	self setmodel(level.sentrysettings[self.sentrytype].modelbase);
	self setsentrycarried(0);
	self setcandamage(1);
	sentry_makesolid();
	self.carriedby forceusehintoff();
	self.carriedby = undefined;
	sentry_setactive();
	self playsound("sentry_gun_plant");
	self notify("placed");
}

sentry_setcancelled()
{
	self.carriedby forceusehintoff();
	self delete();
}

sentry_setcarried(carrier)
{
	self setmodel(level.sentrysettings[self.sentrytype].modelplacement);
	self setsentrycarried(1);
	self setcandamage(0);
	sentry_makenotsolid();
	self.carriedby = carrier;
	carrier thread updatesentryplacement(self);
	thread sentry_oncarrierdeath(carrier);
	thread sentry_oncarrierdisconnect(carrier);
	thread sentry_ongameended();
	sentry_setinactive();
	self notify("carried");
}

updatesentryplacement(sentrygun)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	sentrygun endon("placed");
	sentrygun endon("death");
	sentrygun.canbeplaced = 1;
	lastcanplacesentry = -1;
	for(;;)
	{
		placement = self canplayerplacesentry();
		sentrygun.origin = placement["origin"];
		sentrygun.angles = placement["angles"];
		sentrygun.canbeplaced = self isonground() && placement["result"];
		if(sentrygun.canbeplaced != lastcanplacesentry)
		{
			if(sentrygun.canbeplaced)
			{
				sentrygun setmodel(level.sentrysettings[sentrygun.sentrytype].modelplacement);
				self forceusehinton(&"SENTRY_PLACE");
			}
			else
			{
				sentrygun setmodel(level.sentrysettings[sentrygun.sentrytype].modelplacementfailed);
				self forceusehinton(&"SENTRY_CANNOT_PLACE");
			}
		}

		lastcanplacesentry = sentrygun.canbeplaced;
		wait 0.05;
	}
}

sentry_oncarrierdeath(carrier)
{
	self endon("placed");
	self endon("death");
	carrier waittill("death");
	if(self.canbeplaced)
	{
		sentry_setplaced();
		return;
	}

	self delete();
}

sentry_oncarrierdisconnect(carrier)
{
	self endon("placed");
	self endon("death");
	carrier waittill("disconnect");
	self delete();
}

sentry_ongameended(carrier)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	self delete();
}

sentry_setactive()
{
	self setmode("sentry");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"SENTRY_PICKUP");
	self makeusable();
	foreach(player in level.players)
	{
		if(player == self.owner)
		{
			self enableplayeruse(player);
			continue;
		}

		self disableplayeruse(player);
	}

	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon(self.team, (0,0,65));
		return;
	}

	maps\mp\_entityheadicons::setplayerheadicon(self.owner, (0,0,65));
}

sentry_setinactive()
{
	self setmode("sentry_offline");
	self makeunusable();
	if(level.teambased)
	{
		maps\mp\_entityheadicons::setteamheadicon("none", (0,0,0));
		return;
	}

	if(isdefined(self.owner))
	{
		maps\mp\_entityheadicons::setplayerheadicon(undefined, (0,0,0));
		return;
	}
}

sentry_makesolid()
{
	self maketurretsolid();
}

sentry_makenotsolid()
{
	self setcontents(0);
}

isfriendlytosentry(sentrygun)
{
	if(level.teambased && self.team == sentrygun.team)
	{
		return 1;
	}

	return 0;
}

addtoturretlist(entnum)
{
	level.turrets[entnum] = self;
}

removefromturretlist(entnum)
{
	level.turrets[entnum] = undefined;
}

sentry_attacktargets()
{
	self endon("death");
	level endon("game_ended");
	self.momentum = 0;
	self.heatlevel = 0;
	self.overheated = 0;
	thread sentry_heatmonitor();
	for(;;)
	{
		common_scripts\utility::waittill_either("turretstatechange", "cooled");
		if(self isfiringturret())
		{
			thread sentry_burstfirestart();
			continue;
		}

		sentry_spindown();
		thread sentry_burstfirestop();
	}
}

sentry_timeout()
{
	self endon("death");
	level endon("game_ended");
	lifespan = 90;
	while(lifespan)
	{
		wait 1;
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		if(!isdefined(self.carriedby))
		{
			lifespan = max(0, lifespan - 1);
		}
	}

	if(isdefined(self.owner))
	{
		self.owner thread maps\mp\_utility::leaderdialogonplayer("sentry_gone");
	}

	self notify("death");
}

sentry_targetlocksound()
{
	self endon("death");
	self playsound("sentry_gun_beep");
	wait 0.1;
	self playsound("sentry_gun_beep");
	wait 0.1;
	self playsound("sentry_gun_beep");
}

sentry_spinup()
{
	thread sentry_targetlocksound();
	while(self.momentum < 0.05)
	{
		self.momentum = self.momentum + 0.1;
		wait 0.1;
	}
}

sentry_spindown()
{
	self.momentum = 0;
}

sentry_burstfirestart()
{
	self endon("death");
	self endon("stop_shooting");
	level endon("game_ended");
	sentry_spinup();
	firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
	minshots = level.sentrysettings[self.sentrytype].burstmin;
	maxshots = level.sentrysettings[self.sentrytype].burstmax;
	minpause = level.sentrysettings[self.sentrytype].pausemin;
	maxpause = level.sentrysettings[self.sentrytype].pausemax;
	for(;;)
	{
		numshots = randomintrange(minshots, maxshots + 1);
		for(i = 0;i < numshots && !self.overheated;i++)
		{
			self shootturret();
			self.heatlevel = self.heatlevel + firetime;
			wait firetime;
		}

		wait randomfloatrange(minpause, maxpause);
	}
}

sentry_burstfirestop()
{
	self notify("stop_shooting");
}

sentry_heatmonitor()
{
	self endon("death");
	firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
	lastheatlevel = 0;
	lastfxtime = 0;
	for(;;)
	{
		if(self.heatlevel != lastheatlevel)
		{
			wait firetime;
		}
		else
		{
			self.heatlevel = max(0, self.heatlevel - 0.05);
		}

		if(self.heatlevel > 8)
		{
			self.overheated = 1;
			thread playheatfx();
			while(self.heatlevel)
			{
				self.heatlevel = max(0, self.heatlevel - 0.1);
				wait 0.1;
			}

			self.overheated = 0;
			self notify("not_overheated");
		}

		lastheatlevel = self.heatlevel;
		wait 0.05;
	}
}

playheatfx()
{
	self endon("death");
	self endon("not_overheated");
	level endon("game_ended");
	for(;;)
	{
		playfxontag(common_scripts\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
		wait 0.3;
	}
}

sentry_beepsounds()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait 3;
		if(!isdefined(self.carriedby))
		{
			self playsound("sentry_gun_beep");
		}
	}
}