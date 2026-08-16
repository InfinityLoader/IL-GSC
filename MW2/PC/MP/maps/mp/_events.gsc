/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_events.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	maps\mp\gametypes\_rank::registerscoreinfo("headshot", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("execution", 100);
	maps\mp\gametypes\_rank::registerscoreinfo("avenger", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("defender", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("posthumous", 25);
	maps\mp\gametypes\_rank::registerscoreinfo("revenge", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("double", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("triple", 75);
	maps\mp\gametypes\_rank::registerscoreinfo("multi", 100);
	maps\mp\gametypes\_rank::registerscoreinfo("buzzkill", 100);
	maps\mp\gametypes\_rank::registerscoreinfo("firstblood", 100);
	maps\mp\gametypes\_rank::registerscoreinfo("comeback", 100);
	maps\mp\gametypes\_rank::registerscoreinfo("longshot", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("assistedsuicide", 100);
	maps\mp\gametypes\_rank::registerscoreinfo("knifethrow", 100);
	maps\mp\_utility::registeradrenalineinfo("damage", 10);
	maps\mp\_utility::registeradrenalineinfo("damaged", 20);
	maps\mp\_utility::registeradrenalineinfo("kill", 50);
	maps\mp\_utility::registeradrenalineinfo("killed", 20);
	maps\mp\_utility::registeradrenalineinfo("headshot", 20);
	maps\mp\_utility::registeradrenalineinfo("melee", 10);
	maps\mp\_utility::registeradrenalineinfo("backstab", 20);
	maps\mp\_utility::registeradrenalineinfo("longshot", 10);
	maps\mp\_utility::registeradrenalineinfo("assistedsuicide", 10);
	maps\mp\_utility::registeradrenalineinfo("defender", 10);
	maps\mp\_utility::registeradrenalineinfo("avenger", 10);
	maps\mp\_utility::registeradrenalineinfo("execution", 10);
	maps\mp\_utility::registeradrenalineinfo("comeback", 50);
	maps\mp\_utility::registeradrenalineinfo("revenge", 20);
	maps\mp\_utility::registeradrenalineinfo("buzzkill", 20);
	maps\mp\_utility::registeradrenalineinfo("double", 10);
	maps\mp\_utility::registeradrenalineinfo("triple", 20);
	maps\mp\_utility::registeradrenalineinfo("multi", 30);
	maps\mp\_utility::registeradrenalineinfo("assist", 20);
	maps\mp\_utility::registeradrenalineinfo("3streak", 30);
	maps\mp\_utility::registeradrenalineinfo("5streak", 30);
	maps\mp\_utility::registeradrenalineinfo("7streak", 30);
	maps\mp\_utility::registeradrenalineinfo("10streak", 30);
	maps\mp\_utility::registeradrenalineinfo("regen", 30);
	precacheshader("crosshair_red");
	level._effect["money"] = loadfx("props/cash_player_drop");
	level.numkills = 0;
	level thread onplayerconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player.killedplayers = [];
		player.killedplayerscurrent = [];
		player.killedby = [];
		player.lastkilledby = undefined;
		player.greatestuniqueplayerkills = 0;
		player.recentkillcount = 0;
		player.lastkilltime = 0;
		player.damagedplayers = [];
		player.adrenaline = 0;
		player maps\mp\_utility::setadrenaline(0);
		player thread monitorcratejacking();
		player thread monitorobjectives();
	}
}

damagedplayer(victim, damage, weapon)
{
}

killedplayer(killid, victim, weapon, meansofdeath)
{
	victimguid = victim.guid;
	myguid = self.guid;
	curtime = gettime();
	thread updaterecentkills(killid);
	self.lastkilltime = gettime();
	self.lastkilledplayer = victim;
	self.modifiers = [];
	level.numkills++;
	self.damagedplayers[victimguid] = undefined;
	maps\mp\_utility::giveadrenaline("kill");
	victim maps\mp\_utility::giveadrenaline("killed");
	if(!maps\mp\_utility::iskillstreakweapon(weapon))
	{
		if(weapon == "none")
		{
			return 0;
		}

		if(isdefined(self.pers["copyCatLoadout"]) && isdefined(self.pers["copyCatLoadout"]["owner"]))
		{
			if(victim == self.pers["copyCatLoadout"]["owner"])
			{
				self.modifiers["clonekill"] = 1;
			}
		}

		if(victim.attackers.size == 1)
		{
			weaponclass = maps\mp\_utility::getweaponclass(weapon);
			if(gettime() == victim.attackerdata[self.guid].firsttimedamaged && meansofdeath != "MOD_MELEE" && weaponclass == "weapon_sniper")
			{
				self.modifiers["oneshotkill"] = 1;
				thread maps\mp\gametypes\_hud_message::splashnotifydelayed("one_shot_kill");
			}
		}

		if(isdefined(victim.throwinggrenade) && victim.throwinggrenade == "frag_grenade_mp")
		{
			self.modifiers["cooking"] = 1;
		}

		if(isdefined(self.assistedsuicide) && self.assistedsuicide)
		{
			assistedsuicide(killid);
		}

		if(level.numkills == 1)
		{
			firstblood(killid);
		}

		if(self.pers["cur_death_streak"] > 3)
		{
			comeback(killid);
		}

		if(meansofdeath == "MOD_HEAD_SHOT")
		{
			if(isdefined(victim.laststand))
			{
				execution(killid);
			}
			else
			{
				headshot(killid);
			}
		}

		if(isdefined(self.wasti) && self.wasti && gettime() - self.spawntime <= 5000)
		{
			self.modifiers["jackintheboxkill"] = 1;
		}

		if(!isalive(self) && self.deathtime + 800 < gettime())
		{
			postdeathkill(killid);
		}

		fakeavenge = 0;
		if(level.teambased && curtime - victim.lastkilltime < 500)
		{
			if(victim.lastkilledplayer != self)
			{
				avengedplayer(killid);
			}
		}

		foreach(guid, damagetime in victim.damagedplayers)
		{
			if(guid == self.guid)
			{
				continue;
			}

			if(level.teambased && curtime - damagetime < 500)
			{
				defendedplayer(killid);
			}
		}

		if(isdefined(victim.attackerposition))
		{
			attackerposition = victim.attackerposition;
		}
		else
		{
			attackerposition = self.origin;
		}

		if(isalive(self) && !maps\mp\_utility::isusingremote() && meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT" && distance(attackerposition, victim.origin) > 1536 && !maps\mp\_utility::iskillstreakweapon(weapon) && !isdefined(self.assistedsuicide))
		{
			thread longshot(killid);
		}

		if(isdefined(victim.killstreaks[victim.pers["cur_kill_streak"] + 1]))
		{
			buzzkill(killid, victim);
		}

		thread checkmatchdatakills(killid, victim, weapon, meansofdeath);
	}

	if(!isdefined(self.killedplayers[victimguid]))
	{
		self.killedplayers[victimguid] = 0;
	}

	if(!isdefined(self.killedplayerscurrent[victimguid]))
	{
		self.killedplayerscurrent[victimguid] = 0;
	}

	if(!isdefined(victim.killedby[myguid]))
	{
		victim.killedby[myguid] = 0;
	}

	self.killedplayers[victimguid]++;
	if(self.killedplayers[victimguid] > self.greatestuniqueplayerkills)
	{
		maps\mp\_utility::setplayerstat("killedsameplayer", self.killedplayers[victimguid]);
	}

	self.killedplayerscurrent[victimguid]++;
	victim.killedby[myguid]++;
	victim.lastkilledby = self;
}

checkmatchdatakills(killid, victim, weapon, meansofdeath)
{
	weaponclass = maps\mp\_utility::getweaponclass(weapon);
	alreadyused = 0;
	thread campercheck();
	if(isdefined(self.lastkilledby) && self.lastkilledby == victim)
	{
		self.lastkilledby = undefined;
		revenge(killid);
		playfx(level._effect["money"], victim gettagorigin("j_spine4"));
	}

	if(victim.idflags & level.idflags_penetration)
	{
		maps\mp\_utility::incplayerstat("bulletpenkills", 1);
	}

	if(self.pers["rank"] < victim.pers["rank"])
	{
		maps\mp\_utility::incplayerstat("higherrankkills", 1);
	}

	if(self.pers["rank"] > victim.pers["rank"])
	{
		maps\mp\_utility::incplayerstat("lowerrankkills", 1);
	}

	if(isdefined(self.laststand) && self.laststand)
	{
		maps\mp\_utility::incplayerstat("laststandkills", 1);
	}

	if(isdefined(victim.laststand) && victim.laststand)
	{
		maps\mp\_utility::incplayerstat("laststanderkills", 1);
	}

	if(self getcurrentweapon() != self.loadoutprimary + "_mp" && self getcurrentweapon() != self.loadoutsecondary + "_mp")
	{
		maps\mp\_utility::incplayerstat("otherweaponkills", 1);
	}

	if(maps\mp\_utility::getbaseweaponname(weapon) == "m79")
	{
		maps\mp\_utility::incplayerstat("thumperkills", 1);
	}

	timealive = gettime() - victim.spawntime;
	if(!maps\mp\_utility::matchmakinggame())
	{
		victim maps\mp\_utility::setplayerstatiflower("shortestlife", timealive);
	}

	victim maps\mp\_utility::setplayerstatifgreater("longestlife", timealive);
	switch(weaponclass)
	{
		case "weapon_shotgun":
		case "weapon_pistol":
		case "weapon_lmg":
		case "weapon_sniper":
		case "weapon_assault":
		case "weapon_smg":
		case "weapon_projectile":
			checkmatchdataweaponkills(victim, weapon, meansofdeath, weaponclass);
			break;

		case "weapon_explosive":
		case "weapon_grenade":
			checkmatchdataequipmentkills(victim, weapon, meansofdeath);
			break;

		default:
			break;
	}
}

checkmatchdataweaponkills(victim, weapon, meansofdeath, weapontype)
{
	attacker = self;
	kill_ref = undefined;
	headshot_ref = undefined;
	death_ref = undefined;
	switch(weapontype)
	{
		case "weapon_pistol":
			kill_ref = "pistolkills";
			headshot_ref = "pistolheadshots";
			break;

		case "weapon_smg":
			kill_ref = "smgkills";
			headshot_ref = "smgheadshots";
			break;

		case "weapon_assault":
			kill_ref = "arkills";
			headshot_ref = "arheadshots";
			break;

		case "weapon_projectile":
			if(weaponclass(weapon) == "rocketlauncher")
			{
				kill_ref = "rocketkills";
			}
			break;

		case "weapon_sniper":
			kill_ref = "sniperkills";
			headshot_ref = "sniperheadshots";
			break;

		case "weapon_shotgun":
			kill_ref = "shotgunkills";
			headshot_ref = "shotgunheadshots";
			death_ref = "shotgundeaths";
			break;

		case "weapon_lmg":
			kill_ref = "lmgkills";
			headshot_ref = "lmgheadshots";
			break;

		default:
			break;
	}

	if(isdefined(kill_ref))
	{
		attacker maps\mp\_utility::incplayerstat(kill_ref, 1);
	}

	if(isdefined(headshot_ref) && meansofdeath == "MOD_HEAD_SHOT")
	{
		attacker maps\mp\_utility::incplayerstat(headshot_ref, 1);
	}

	if(isdefined(death_ref) && !maps\mp\_utility::matchmakinggame())
	{
		victim maps\mp\_utility::incplayerstat(death_ref, 1);
	}

	if(attacker playerads() > 0.5)
	{
		attacker maps\mp\_utility::incplayerstat("adskills", 1);
		if(weapontype == "weapon_sniper" || issubstr(weapon, "acog"))
		{
			attacker maps\mp\_utility::incplayerstat("scopedkills", 1);
		}

		if(issubstr(weapon, "thermal"))
		{
			attacker maps\mp\_utility::incplayerstat("thermalkills", 1);
			return;
		}

		return;
	}

	attacker maps\mp\_utility::incplayerstat("hipfirekills", 1);
}

checkmatchdataequipmentkills(victim, weapon, meansofdeath)
{
	attacker = self;
	switch(weapon)
	{
		case "frag_grenade_mp":
			attacker maps\mp\_utility::incplayerstat("fragkills", 1);
			attacker maps\mp\_utility::incplayerstat("grenadekills", 1);
			isequipment = 1;
			break;

		case "c4_mp":
			isequipment maps\mp\_utility::incplayerstat("c4kills", 1);
			isequipment = 1;
			break;

		case "semtex_mp":
			isequipment maps\mp\_utility::incplayerstat("semtexkills", 1);
			isequipment maps\mp\_utility::incplayerstat("grenadekills", 1);
			isequipment = 1;
			break;

		case "claymore_mp":
			isequipment maps\mp\_utility::incplayerstat("claymorekills", 1);
			isequipment = 1;
			break;

		case "throwingknife_mp":
			isequipment maps\mp\_utility::incplayerstat("throwingknifekills", 1);
			thread maps\mp\gametypes\_hud_message::splashnotifydelayed("knifethrow", maps\mp\gametypes\_rank::getscoreinfovalue("knifethrow"));
			isequipment = 1;
			break;

		default:
			isequipment = 0;
			break;
	}

	if(isequipment)
	{
		attacker maps\mp\_utility::incplayerstat("equipmentkills", 1);
		return;
	}
}

campercheck()
{
	if(!isdefined(self.lastkilllocation))
	{
		self.lastkilllocation = self.origin;
		self.lastcampkilltime = gettime();
		return;
	}

	if(distance(self.lastkilllocation, self.origin) < 512 && gettime() - self.lastcampkilltime > 5000)
	{
		maps\mp\_utility::incplayerstat("mostcamperkills", 1);
	}

	self.lastkilllocation = self.origin;
	self.lastcampkilltime = gettime();
}

consolation(killid)
{
}

longshot(killid)
{
	self.modifiers["longshot"] = 1;
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("longshot", maps\mp\gametypes\_rank::getscoreinfovalue("longshot"));
	thread maps\mp\gametypes\_rank::giverankxp("longshot");
	thread maps\mp\_utility::giveadrenaline("longshot");
	maps\mp\_utility::incplayerstat("longshots", 1);
	thread maps\mp\_matchdata::logkillevent(killid, "longshot");
}

execution(killid)
{
	self.modifiers["execution"] = 1;
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("execution", maps\mp\gametypes\_rank::getscoreinfovalue("execution"));
	thread maps\mp\gametypes\_rank::giverankxp("execution");
	thread maps\mp\_utility::giveadrenaline("execution");
	thread maps\mp\_matchdata::logkillevent(killid, "execution");
}

headshot(killid)
{
	self.modifiers["headshot"] = 1;
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("headshot", maps\mp\gametypes\_rank::getscoreinfovalue("headshot"));
	thread maps\mp\gametypes\_rank::giverankxp("headshot");
	thread maps\mp\_utility::giveadrenaline("headshot");
	thread maps\mp\_matchdata::logkillevent(killid, "headshot");
}

avengedplayer(killid)
{
	self.modifiers["avenger"] = 1;
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("avenger", maps\mp\gametypes\_rank::getscoreinfovalue("avenger"));
	thread maps\mp\gametypes\_rank::giverankxp("avenger");
	thread maps\mp\_utility::giveadrenaline("avenger");
	thread maps\mp\_matchdata::logkillevent(killid, "avenger");
	maps\mp\_utility::incplayerstat("avengekills", 1);
}

assistedsuicide(killid)
{
	self.modifiers["assistedsuicide"] = 1;
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("assistedsuicide", maps\mp\gametypes\_rank::getscoreinfovalue("assistedsuicide"));
	thread maps\mp\gametypes\_rank::giverankxp("assistedsuicide");
	thread maps\mp\_utility::giveadrenaline("assistedsuicide");
	thread maps\mp\_matchdata::logkillevent(killid, "assistedsuicide");
}

defendedplayer(killid)
{
	self.modifiers["defender"] = 1;
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("defender", maps\mp\gametypes\_rank::getscoreinfovalue("defender"));
	thread maps\mp\gametypes\_rank::giverankxp("defender");
	thread maps\mp\_utility::giveadrenaline("defender");
	thread maps\mp\_matchdata::logkillevent(killid, "defender");
	maps\mp\_utility::incplayerstat("rescues", 1);
}

postdeathkill(killid)
{
	self.modifiers["posthumous"] = 1;
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("posthumous", maps\mp\gametypes\_rank::getscoreinfovalue("posthumous"));
	thread maps\mp\gametypes\_rank::giverankxp("posthumous");
	thread maps\mp\_matchdata::logkillevent(killid, "posthumous");
}

backstab(killid)
{
	self iprintlnbold("backstab");
}

revenge(killid)
{
	self.modifiers["revenge"] = 1;
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("revenge", maps\mp\gametypes\_rank::getscoreinfovalue("revenge"));
	thread maps\mp\gametypes\_rank::giverankxp("revenge");
	thread maps\mp\_utility::giveadrenaline("revenge");
	thread maps\mp\_matchdata::logkillevent(killid, "revenge");
	maps\mp\_utility::incplayerstat("revengekills", 1);
}

multikill(killid, killcount)
{
	if(killcount == 2)
	{
		thread maps\mp\gametypes\_hud_message::splashnotifydelayed("doublekill", maps\mp\gametypes\_rank::getscoreinfovalue("double"));
		thread maps\mp\_utility::giveadrenaline("double");
	}
	else if(killcount == 3)
	{
		thread maps\mp\gametypes\_hud_message::splashnotifydelayed("triplekill", maps\mp\gametypes\_rank::getscoreinfovalue("triple"));
		thread maps\mp\_utility::giveadrenaline("triple");
		thread maps\mp\_utility::teamplayercardsplash("callout_3xkill", self);
	}
	else
	{
		thread maps\mp\gametypes\_hud_message::splashnotifydelayed("multikill", maps\mp\gametypes\_rank::getscoreinfovalue("multi"));
		thread maps\mp\_utility::giveadrenaline("multi");
		thread maps\mp\_utility::teamplayercardsplash("callout_3xpluskill", self);
	}

	thread maps\mp\_matchdata::logmultikill(killid, killcount);
	maps\mp\_utility::setplayerstatifgreater("multikill", killcount);
	maps\mp\_utility::incplayerstat("mostmultikills", 1);
}

firstblood(killid)
{
	self.modifiers["firstblood"] = 1;
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("firstblood", maps\mp\gametypes\_rank::getscoreinfovalue("firstblood"));
	thread maps\mp\gametypes\_rank::giverankxp("firstblood");
	thread maps\mp\_matchdata::logkillevent(killid, "firstblood");
	thread maps\mp\_utility::teamplayercardsplash("callout_firstblood", self);
}

winningshot(killid)
{
}

buzzkill(killid, victim)
{
	self.modifiers["buzzkill"] = victim.pers["cur_kill_streak"];
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("buzzkill", maps\mp\gametypes\_rank::getscoreinfovalue("buzzkill"));
	thread maps\mp\gametypes\_rank::giverankxp("buzzkill");
	thread maps\mp\_utility::giveadrenaline("buzzkill");
	thread maps\mp\_matchdata::logkillevent(killid, "buzzkill");
}

comeback(killid)
{
	self.modifiers["comeback"] = 1;
	thread maps\mp\gametypes\_hud_message::splashnotifydelayed("comeback", maps\mp\gametypes\_rank::getscoreinfovalue("comeback"));
	thread maps\mp\gametypes\_rank::giverankxp("comeback");
	thread maps\mp\_utility::giveadrenaline("comeback");
	thread maps\mp\_matchdata::logkillevent(killid, "comeback");
	maps\mp\_utility::incplayerstat("comebacks", 1);
}

disconnected()
{
	myguid = self.guid;
	for(entry = 0;entry < level.players.size;entry++)
	{
		if(isdefined(level.players[entry].killedplayers[myguid]))
		{
			level.players[entry].killedplayers[myguid] = undefined;
		}

		if(isdefined(level.players[entry].killedplayerscurrent[myguid]))
		{
			level.players[entry].killedplayerscurrent[myguid] = undefined;
		}

		if(isdefined(level.players[entry].killedby[myguid]))
		{
			level.players[entry].killedby[myguid] = undefined;
		}
	}
}

updaterecentkills(killid)
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("updateRecentKills");
	self endon("updateRecentKills");
	self.recentkillcount++;
	wait 1;
	if(self.recentkillcount > 1)
	{
		multikill(killid, self.recentkillcount);
	}

	self.recentkillcount = 0;
}

monitorcratejacking()
{
	level endon("end_game");
	self endon("disconnect");
	for(;;)
	{
		self waittill("hijacker", cratetype, owner);
		if(cratetype == "sentry")
		{
			thread maps\mp\gametypes\_hud_message::splashnotifydelayed("hijacker", 100);
			thread maps\mp\gametypes\_rank::giverankxp("hijacker", 100);
			if(isdefined(owner))
			{
				owner maps\mp\gametypes\_hud_message::playercardsplashnotify("hijacked_sentry", self);
			}

			self notify("process", "ch_hijacker");
			continue;
		}

		if(cratetype == "mega" || cratetype == "emergency_airdrop")
		{
			if(self.team == owner.team)
			{
				continue;
			}

			thread maps\mp\gametypes\_hud_message::splashnotifydelayed("hijacker", 100);
			thread maps\mp\gametypes\_rank::giverankxp("hijacker", 100);
			if(isdefined(owner))
			{
				owner maps\mp\gametypes\_hud_message::playercardsplashnotify("hijacked_emergency_airdrop", self);
			}

			self notify("process", "ch_newjack");
			continue;
		}

		thread maps\mp\gametypes\_hud_message::splashnotifydelayed("hijacker", 100);
		thread maps\mp\gametypes\_rank::giverankxp("hijacker", 100);
		if(isdefined(owner))
		{
			owner maps\mp\gametypes\_hud_message::playercardsplashnotify("hijacked_airdrop", self);
		}

		self notify("process", "ch_hijacker");
	}
}

monitorobjectives()
{
	level endon("end_game");
	self endon("disconnect");
	self waittill("objective", objtype);
	if(objtype == "captured")
	{
		if(isdefined(self.laststand) && self.laststand)
		{
			thread maps\mp\gametypes\_hud_message::splashnotifydelayed("heroic", 100);
			thread maps\mp\gametypes\_rank::giverankxp("reviver", 100);
			return;
		}

		return;
	}
}