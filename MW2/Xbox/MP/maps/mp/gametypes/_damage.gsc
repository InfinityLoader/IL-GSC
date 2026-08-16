/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_damage.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

isswitchingteams()
{
	if(isdefined(self.switching_teams))
	{
		return 1;
	}

	return 0;
}

isteamswitchbalanced()
{
	playercounts = maps\mp\gametypes\_teams::countplayers();
	playercounts[self.leaving_team]--;
	playercounts[self.joining_team]++;
	return playercounts[self.joining_team] - playercounts[self.leaving_team] < 2;
}

isfriendlyfire(victim, attacker)
{
	if(!level.teambased)
	{
		return 0;
	}

	if(!isdefined(attacker))
	{
		return 0;
	}

	if(!isplayer(attacker) && !isdefined(attacker.team))
	{
		return 0;
	}

	if(victim.team != attacker.team)
	{
		return 0;
	}

	if(victim == attacker)
	{
		return 0;
	}

	return 1;
}

killedself(attacker)
{
	if(!isplayer(attacker))
	{
		return 0;
	}

	if(attacker != self)
	{
		return 0;
	}

	return 1;
}

isheadshot(sweapon, shitloc, smeansofdeath, attacker)
{
	if(isdefined(attacker))
	{
		if(attacker.code_classname == "script_vehicle" && isdefined(attacker.owner))
		{
			return 0;
		}

		if(attacker.code_classname == "misc_turret" && isdefined(attacker.owner))
		{
			return 0;
		}

		if(attacker.code_classname == "script_model" && isdefined(attacker.owner))
		{
			return 0;
		}
	}

	return (shitloc == "head" || shitloc == "helmet") && smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_IMPACT" && !maps\mp\_utility::ismg(sweapon);
}

handleteamchangedeath()
{
	if(!level.teambased)
	{
		return;
	}

	if(self.joining_team == "spectator" || !isteamswitchbalanced())
	{
		self thread [[ level.onxpevent ]]("suicide");
		maps\mp\_utility::incpersstat("suicides", 1);
		self.suicides = maps\mp\_utility::getpersstat("suicides");
		return;
	}
}

handleworlddeath(attacker, lifeid, smeansofdeath, shitloc)
{
	if(!isdefined(attacker))
	{
		return;
	}

	if(!isdefined(attacker.team))
	{
		handlesuicidedeath(smeansofdeath, shitloc);
		return;
	}

	if(level.teambased && attacker.team != self.team)
	{
		if(isdefined(level.onnormaldeath) && isplayer(attacker) && attacker.team != "spectator")
		{
			[[ level.onnormaldeath ]](self, attacker, lifeid);
			return;
		}

		return;
	}
}

handlesuicidedeath(smeansofdeath, shitloc)
{
	self setcarddisplayslot(self, 7);
	self openmenu("killedby_card_display");
	self thread [[ level.onxpevent ]]("suicide");
	maps\mp\_utility::incpersstat("suicides", 1);
	self.suicides = maps\mp\_utility::getpersstat("suicides");
	if(!maps\mp\_utility::matchmakinggame())
	{
		maps\mp\_utility::incplayerstat("suicides", 1);
	}

	scoresub = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "suicidepointloss");
	maps\mp\gametypes\_gamescore::_setplayerscore(self, maps\mp\gametypes\_gamescore::_getplayerscore(self) - scoresub);
	if(smeansofdeath == "MOD_SUICIDE" && shitloc == "none" && isdefined(self.throwinggrenade))
	{
		self.lastgrenadesuicidetime = gettime();
	}

	if(isdefined(self.friendlydamage))
	{
		self iprintlnbold(&"MP_FRIENDLY_FIRE_WILL_NOT");
		return;
	}
}

handlefriendlyfiredeath(attacker)
{
	attacker setcarddisplayslot(self, 8);
	attacker openmenu("youkilled_card_display");
	self setcarddisplayslot(attacker, 7);
	self openmenu("killedby_card_display");
	attacker thread [[ level.onxpevent ]]("teamkill");
	attacker.pers["teamkills"] = attacker.pers["teamkills"] + 1;
	attacker.teamkillsthisround++;
	if(maps\mp\gametypes\_tweakables::gettweakablevalue("team", "teamkillpointloss"))
	{
		scoresub = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
		maps\mp\gametypes\_gamescore::_setplayerscore(attacker, maps\mp\gametypes\_gamescore::_getplayerscore(attacker) - scoresub);
	}

	if(level.maxallowedteamkills < 0)
	{
		return;
	}

	if(level.ingraceperiod)
	{
		teamkilldelay = 1;
		attacker.pers["teamkills"] = attacker.pers["teamkills"] + level.maxallowedteamkills;
	}
	else if(attacker.pers["teamkills"] > 1 && maps\mp\_utility::gettimepassed() < level.graceperiod * 1000 + 8000 + attacker.pers["teamkills"] * 1000)
	{
		teamkilldelay = 1;
		attacker.pers["teamkills"] = attacker.pers["teamkills"] + level.maxallowedteamkills;
	}
	else
	{
		teamkilldelay = attacker maps\mp\gametypes\_playerlogic::teamkilldelay();
	}

	if(teamkilldelay > 0)
	{
		attacker.pers["teamKillPunish"] = 1;
		attacker maps\mp\_utility::_suicide();
		return;
	}
}

handlenormaldeath(lifeid, attacker, einflictor, sweapon, smeansofdeath)
{
	attacker thread maps\mp\_events::killedplayer(lifeid, self, sweapon, smeansofdeath);
	attacker setcarddisplayslot(self, 8);
	attacker openmenu("youkilled_card_display");
	self setcarddisplayslot(attacker, 7);
	self openmenu("killedby_card_display");
	if(smeansofdeath == "MOD_HEAD_SHOT")
	{
		attacker maps\mp\_utility::incpersstat("headshots", 1);
		attacker.headshots = attacker maps\mp\_utility::getpersstat("headshots");
		attacker maps\mp\_utility::incplayerstat("headshots", 1);
		if(isdefined(attacker.laststand))
		{
			value = maps\mp\gametypes\_rank::getscoreinfovalue("kill") * 2;
		}
		else
		{
			value = undefined;
		}

		attacker playlocalsound("bullet_impact_headshot_2");
	}
	else if(isdefined(attacker.laststand))
	{
		value = maps\mp\gametypes\_rank::getscoreinfovalue("kill") * 2;
	}
	else
	{
		value = undefined;
	}

	attacker thread maps\mp\gametypes\_rank::giverankxp("kill", value);
	attacker maps\mp\_utility::incpersstat("kills", 1);
	attacker.kills = attacker maps\mp\_utility::getpersstat("kills");
	attacker maps\mp\_utility::updatepersratio("kdRatio", "kills", "deaths");
	attacker maps\mp\gametypes\_persistence::statsetchild("round", "kills", attacker.kills);
	attacker maps\mp\_utility::incplayerstat("kills", 1);
	if(isflankkill(self, attacker))
	{
		attacker maps\mp\_utility::incplayerstat("flankkills", 1);
		maps\mp\_utility::incplayerstat("flankdeaths", 1);
	}

	lastkillstreak = attacker.pers["cur_kill_streak"];
	self.pers["copyCatLoadout"] = undefined;
	if(maps\mp\_utility::_hasperk("specialty_copycat"))
	{
		self.pers["copyCatLoadout"] = attacker maps\mp\gametypes\_class::cloneloadout();
	}

	if(isalive(attacker))
	{
		if(isdefined(level.killstreakspecialcaseweapons[sweapon]))
		{
			switch(sweapon)
			{
				case "ac130_25mm_mp":
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
					if(attacker.ac130lifeid == attacker.pers["deaths"])
					{
						attacker.pers["cur_kill_streak"]++;
					}
					break;

				case "weapon_cobra_mk19_mp":
				case "cobra_player_minigun_mp":
					if(attacker.heliridelifeid == attacker.pers["deaths"])
					{
						attacker.pers["cur_kill_streak"]++;
					}
					break;

				case "cobra_20mm_mp":
				case "remotemissile_projectile_mp":
				case "harrier_20mm_mp":
				case "sentry_minigun_mp":
				case "pavelow_minigun_mp":
				case "stealth_bomb_mp":
				case "artillery_mp":
					if(isdefined(einflictor) && isdefined(einflictor.lifeid))
					{
						killstreaklifeid = einflictor.lifeid;
					}
					else
					{
						killstreaklifeid = attacker.lifeid;
					}
	
					if(killstreaklifeid == attacker.pers["deaths"])
					{
						attacker.pers["cur_kill_streak"]++;
					}
					break;

				default:
					attacker.pers["cur_kill_streak"]++;
					break;
			}
		}
		else
		{
			attacker.pers["cur_kill_streak"]++;
		}

		attacker maps\mp\_utility::setplayerstatifgreater("killstreak", attacker.pers["cur_kill_streak"]);
		if(attacker.pers["cur_kill_streak"] > attacker maps\mp\_utility::getpersstat("longestStreak"))
		{
			attacker maps\mp\_utility::setpersstat("longestStreak", attacker.pers["cur_kill_streak"]);
		}
	}

	attacker.pers["cur_death_streak"] = 0;
	if(attacker.pers["cur_kill_streak"] > attacker maps\mp\gametypes\_persistence::statgetchild("round", "killStreak"))
	{
		attacker maps\mp\gametypes\_persistence::statsetchild("round", "killStreak", attacker.pers["cur_kill_streak"]);
	}

	if(attacker.pers["cur_kill_streak"] > attacker.kill_streak)
	{
		attacker maps\mp\gametypes\_persistence::statset("killStreak", attacker.pers["cur_kill_streak"]);
		attacker.kill_streak = attacker.pers["cur_kill_streak"];
	}

	maps\mp\gametypes\_gamescore::giveplayerscore("kill", attacker, self);
	maps\mp\_skill::processkill(attacker, self);
	scoresub = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "deathpointloss");
	maps\mp\gametypes\_gamescore::_setplayerscore(self, maps\mp\gametypes\_gamescore::_getplayerscore(self) - scoresub);
	if(isdefined(level.ac130player) && level.ac130player == attacker)
	{
		level notify("ai_killed", self);
	}

	level notify("player_got_killstreak_" + attacker.pers["cur_kill_streak"], attacker);
	if(isalive(attacker))
	{
		attacker thread maps\mp\killstreaks\_killstreaks::checkkillstreakreward(attacker.pers["cur_kill_streak"]);
	}

	attacker notify("killed_enemy");
	if(!level.teambased)
	{
		self.attackers = [];
		return;
	}

	if(isdefined(level.onnormaldeath) && attacker.pers["team"] != "spectator")
	{
		[[ level.onnormaldeath ]](self, attacker, lifeid);
	}

	level thread maps\mp\gametypes\_battlechatter_mp::saylocalsounddelayed(attacker, "kill", 0.75);
	if(isdefined(self.lastattackedshieldplayer) && isdefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker)
	{
		if(gettime() - self.lastattackedshieldtime < 2500)
		{
			self.lastattackedshieldplayer thread maps\mp\gametypes\_gamescore::processshieldassist(self);
		}
		else if(isalive(self.lastattackedshieldplayer) && gettime() - self.lastattackedshieldtime < 5000)
		{
			forwardvec = vectornormalize(anglestoforward(self.angles));
			shieldvec = vectornormalize(self.lastattackedshieldplayer.origin - self.origin);
			if(vectordot(shieldvec, forwardvec) > 0.925)
			{
				self.lastattackedshieldplayer thread maps\mp\gametypes\_gamescore::processshieldassist(self);
			}
		}
	}

	if(isdefined(self.attackers))
	{
		foreach(player in self.attackers)
		{
			if(!isdefined(player))
			{
				continue;
			}

			if(player == attacker)
			{
				continue;
			}

			player thread maps\mp\gametypes\_gamescore::processassist(self);
		}

		self.attackers = [];
		return;
	}
}

isplayerweapon(weaponname)
{
	if(weaponclass(weaponname) == "non-player")
	{
		return 0;
	}

	if(weaponclass(weaponname) == "turret")
	{
		return 0;
	}

	if(weaponinventorytype(weaponname) == "primary" || weaponinventorytype(weaponname) == "altmode")
	{
		return 1;
	}

	return 0;
}

callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	playerkilled_internal(einflictor, attacker, self, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration, 0);
}

queueshieldforremoval(shield)
{
	my_max_shields_at_a_time = 5;
	if(!isdefined(level.shieldtrasharray))
	{
		level.shieldtrasharray = [];
	}

	if(level.shieldtrasharray.size >= my_max_shields_at_a_time)
	{
		idxmax = level.shieldtrasharray.size - 1;
		level.shieldtrasharray[0] delete();
		for(idx = 0;idx < idxmax;idx++)
		{
			level.shieldtrasharray[idx] = level.shieldtrasharray[idx + 1];
		}

		level.shieldtrasharray[idxmax] = undefined;
	}

	level.shieldtrasharray[level.shieldtrasharray.size] = shield;
}

launchshield(damage, meansofdeath)
{
	shieldmodel = "weapon_riot_shield_mp";
	self detachshieldmodel(shieldmodel, "tag_weapon_left");
	self.hasriotshield = 0;
	self.hasriotshieldequipped = 0;
}

playerkilled_internal(einflictor, attacker, victim, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration, param_B01)
{
	victim endon("spawned");
	victim notify("killed_player");
	if(isdefined(attacker))
	{
		attacker.assistedsuicide = undefined;
	}

	if(!isdefined(victim.idflags))
	{
		if(smeansofdeath == "MOD_SUICIDE")
		{
			victim.idflags = 0;
		}
		else if(smeansofdeath == "MOD_GRENADE" && issubstr(sweapon, "frag_grenade") && idamage == 100000)
		{
			victim.idflags = 0;
		}
		else if(sweapon == "nuke_mp")
		{
			victim.idflags = 0;
		}
		else if(level.friendlyfire >= 2)
		{
			victim.idflags = 0;
		}
		else
		{
		}
	}

	if(victim.hasriotshieldequipped)
	{
		victim launchshield(idamage, smeansofdeath);
	}

	if(!param_B01)
	{
		if(isdefined(victim.endgame))
		{
			victim visionsetnakedforplayer(getdvar("mapname"), 2);
		}
		else if(!isdefined(victim.nuked))
		{
			victim visionsetnakedforplayer(getdvar("mapname"), 0);
			victim thermalvisionoff();
		}
	}
	else
	{
		victim.fauxdead = 1;
		self notify("death");
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	deathtimeoffset = 0;
	if(!isplayer(einflictor) && isdefined(einflictor.primaryweapon))
	{
		sprimaryweapon = einflictor.primaryweapon;
	}
	else if(isdefined(attacker) && isplayer(attacker) && attacker getcurrentprimaryweapon() != "none")
	{
		sprimaryweapon = attacker getcurrentprimaryweapon();
	}
	else
	{
		sprimaryweapon = undefined;
	}

	if(isdefined(victim.uselaststandparams))
	{
		victim ensurelaststandparamsvalidity();
		victim.uselaststandparams = undefined;
		einflictor = victim.laststandparams.einflictor;
		attacker = victim.laststandparams.attacker;
		idamage = victim.laststandparams.idamage;
		smeansofdeath = victim.laststandparams.smeansofdeath;
		sweapon = victim.laststandparams.sweapon;
		sprimaryweapon = victim.laststandparams.sprimaryweapon;
		vdir = victim.laststandparams.vdir;
		shitloc = victim.laststandparams.shitloc;
		deathtimeoffset = gettime() - victim.laststandparams.laststandstarttime / 1000;
		victim.laststandparams = undefined;
	}

	if((!isdefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || attacker == victim) && isdefined(self.attackers))
	{
		bestplayer = undefined;
		foreach(player in self.attackers)
		{
			if(!isdefined(player))
			{
				continue;
			}

			if(!isdefined(victim.attackerdata[player.guid].damage))
			{
				continue;
			}

			if(player == victim || level.teambased && player.team == victim.team)
			{
				continue;
			}

			if(victim.attackerdata[player.guid].lasttimedamaged + 2500 < gettime())
			{
				continue;
			}

			if(victim.attackerdata[player.guid].damage > 1 && !isdefined(bestplayer))
			{
				bestplayer = player;
				continue;
			}

			if(isdefined(bestplayer) && victim.attackerdata[player.guid].damage > victim.attackerdata[bestplayer.guid].damage)
			{
				bestplayer = player;
			}
		}

		if(isdefined(bestplayer))
		{
			attacker = bestplayer;
			attacker.assistedsuicide = 1;
			sweapon = victim.attackerdata[bestplayer.guid].weapon;
			vdir = victim.attackerdata[bestplayer.guid].vdir;
			shitloc = victim.attackerdata[bestplayer.guid].shitloc;
			psoffsettime = victim.attackerdata[bestplayer.guid].psoffsettime;
			smeansofdeath = victim.attackerdata[bestplayer.guid].smeansofdeath;
			idamage = victim.attackerdata[bestplayer.guid].damage;
			sprimaryweapon = victim.attackerdata[bestplayer.guid].sprimaryweapon;
			einflictor = attacker;
		}
	}
	else if(isdefined(attacker))
	{
		attacker.assistedsuicide = undefined;
	}

	if(isheadshot(sweapon, shitloc, smeansofdeath, attacker))
	{
		smeansofdeath = "MOD_HEAD_SHOT";
	}
	else if(smeansofdeath != "MOD_MELEE" && !isdefined(victim.nuked))
	{
		victim maps\mp\_utility::playdeathsound();
	}

	friendlyfire = isfriendlyfire(victim, attacker);
	if(isdefined(attacker))
	{
		if(attacker.code_classname == "script_vehicle" && isdefined(attacker.owner))
		{
			attacker = attacker.owner;
		}

		if(attacker.code_classname == "misc_turret" && isdefined(attacker.owner))
		{
			attacker = attacker.owner;
		}

		if(attacker.code_classname == "script_model" && isdefined(attacker.owner))
		{
			attacker = attacker.owner;
			if(!isfriendlyfire(victim, attacker) && attacker != victim)
			{
				attacker notify("crushed_enemy");
			}
		}
	}

	victim maps\mp\gametypes\_weapons::dropscavengerfordeath(attacker);
	victim maps\mp\gametypes\_weapons::dropweaponfordeath(attacker);
	if(!param_B01)
	{
		victim.sessionstate = "dead";
		victim.statusicon = "hud_status_dead";
	}

	victim maps\mp\gametypes\_playerlogic::removefromalivecount();
	if(!isdefined(victim.switching_teams))
	{
		victim maps\mp\_utility::incpersstat("deaths", 1);
		victim.deaths = victim maps\mp\_utility::getpersstat("deaths");
		victim maps\mp\_utility::updatepersratio("kdRatio", "kills", "deaths");
		victim maps\mp\gametypes\_persistence::statsetchild("round", "deaths", victim.deaths);
		victim maps\mp\_utility::incplayerstat("deaths", 1);
	}

	if(isdefined(attacker))
	{
		attacker checkkillsteal(victim);
	}

	obituary(victim, attacker, sweapon, smeansofdeath);
	dokillcam = 0;
	lifeid = maps\mp\_utility::getnextlifeid();
	victim logprintplayerdeath(lifeid, attacker, idamage, smeansofdeath, sweapon, sprimaryweapon, shitloc);
	victim maps\mp\_matchdata::logplayerlife(lifeid);
	victim maps\mp\_matchdata::logplayerdeath(lifeid, attacker, idamage, smeansofdeath, sweapon, sprimaryweapon, shitloc);
	if(smeansofdeath == "MOD_MELEE")
	{
		if(issubstr(sweapon, "riotshield"))
		{
			attacker maps\mp\_utility::incplayerstat("shieldkills", 1);
			if(!maps\mp\_utility::matchmakinggame())
			{
				victim maps\mp\_utility::incplayerstat("shielddeaths", 1);
			}
		}
		else
		{
			attacker maps\mp\_utility::incplayerstat("knifekills", 1);
		}
	}

	if(victim isswitchingteams())
	{
		handleteamchangedeath();
	}
	else if(!isplayer(attacker) || isplayer(attacker) && smeansofdeath == "MOD_FALLING")
	{
		handleworlddeath(attacker, lifeid, smeansofdeath, shitloc);
	}
	else if(attacker == victim)
	{
		handlesuicidedeath(smeansofdeath, shitloc);
	}
	else if(friendlyfire)
	{
		if(!isdefined(victim.nuked))
		{
			handlefriendlyfiredeath(attacker);
		}
	}
	else
	{
		if(smeansofdeath == "MOD_GRENADE" && einflictor == attacker)
		{
			addattacker(victim, attacker, einflictor, sweapon, idamage, (0,0,0), vdir, shitloc, psoffsettime, smeansofdeath);
		}

		dokillcam = 1;
		handlenormaldeath(lifeid, attacker, einflictor, sweapon, smeansofdeath);
		victim thread maps\mp\gametypes\_missions::playerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, sprimaryweapon, shitloc, attacker.modifiers);
		victim.pers["cur_death_streak"]++;
		if(!maps\mp\_utility::getgametypenumlives() && !maps\mp\_utility::matchmakinggame())
		{
			victim maps\mp\_utility::setplayerstatifgreater("deathstreak", victim.pers["cur_death_streak"]);
		}
	}

	victim resetplayervariables();
	victim.lastattacker = attacker;
	victim.lastdeathpos = victim.origin;
	victim.deathtime = gettime();
	victim.wantsafespawn = 0;
	victim.revived = 0;
	victim.sameshotdamage = 0;
	if(param_B01)
	{
		dokillcam = 0;
		deathanimduration = victim playerforcedeathanim(einflictor, smeansofdeath, sweapon, shitloc, vdir);
	}

	victim.body = victim cloneplayer(deathanimduration);
	if(param_B01)
	{
		victim playerhide();
	}

	if(victim isonladder() || victim ismantling() || !victim isonground() || isdefined(victim.nuked))
	{
		victim.body startragdoll();
	}

	if(!isdefined(victim.switching_teams))
	{
		thread maps\mp\gametypes\_deathicons::adddeathicon(victim.body, victim, victim.team, 5);
	}

	thread delaystartragdoll(victim.body, shitloc, vdir, sweapon, einflictor, smeansofdeath);
	victim thread [[ level.onplayerkilled ]](einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration, lifeid);
	if(isplayer(attacker))
	{
		attackernum = attacker getentitynumber();
	}
	else
	{
		attackernum = -1;
	}

	killcamentity = victim getkillcamentity(attacker, einflictor, sweapon);
	killcamentityindex = -1;
	killcamentitystarttime = 0;
	if(isdefined(killcamentity))
	{
		killcamentityindex = killcamentity getentitynumber();
		killcamentitystarttime = killcamentity.birthtime;
		if(!isdefined(killcamentitystarttime))
		{
			killcamentitystarttime = 0;
		}
	}

	if(isdefined(attacker.finalkill))
	{
		maps\mp\_awards::addawardwinner("finalkill", attacker.clientid);
	}

	if(isdefined(attacker.finalkill) && dokillcam && !isdefined(level.nukedetonated))
	{
		level thread dofinalkillcam(5, victim, attacker, attackernum, killcamentityindex, killcamentitystarttime, sweapon, deathtimeoffset, psoffsettime);
		if(!param_B01)
		{
			wait 1;
		}
	}

	if(!param_B01)
	{
		if(!level.showingfinalkillcam && !level.killcam && dokillcam)
		{
			if(victim maps\mp\_utility::_hasperk("specialty_copycat") && isdefined(victim.pers["copyCatLoadout"]))
			{
				victim thread maps\mp\gametypes\_killcam::waitdeathcopycatbutton(attacker);
				wait 1;
			}
		}

		wait 0.25;
		victim thread maps\mp\gametypes\_killcam::cancelkillcamonuse();
		wait 0.25;
		self.respawntimerstarttime = gettime() + 1000;
		timeuntilspawn = maps\mp\gametypes\_playerlogic::timeuntilspawn(1);
		if(timeuntilspawn < 1)
		{
			timeuntilspawn = 1;
		}

		victim thread maps\mp\gametypes\_playerlogic::predictabouttospawnplayerovertime(timeuntilspawn);
		wait 1;
		victim notify("death_delay_finished");
	}

	postdeathdelay = gettime() - victim.deathtime / 1000;
	self.respawntimerstarttime = gettime();
	if(!isdefined(victim.cancelkillcam) && victim.cancelkillcam && dokillcam && level.killcam && game["state"] == "playing" && !victim maps\mp\_utility::isusingremote() && !level.showingfinalkillcam)
	{
		livesleft = !maps\mp\_utility::getgametypenumlives() && !victim.pers["lives"];
		timeuntilspawn = maps\mp\gametypes\_playerlogic::timeuntilspawn(1);
		willrespawnimmediately = livesleft && timeuntilspawn <= 0;
		if(!livesleft)
		{
			timeuntilspawn = -1;
		}

		victim maps\mp\gametypes\_killcam::killcam(attackernum, killcamentityindex, killcamentitystarttime, sweapon, postdeathdelay + deathtimeoffset, psoffsettime, timeuntilspawn, maps\mp\gametypes\_gamelogic::timeuntilroundend(), attacker, victim);
	}

	if(game["state"] != "playing")
	{
		if(!level.showingfinalkillcam)
		{
			victim.sessionstate = "dead";
			victim maps\mp\_utility::clearkillcamstate();
		}

		return;
	}

	if(maps\mp\_utility::isvalidclass(victim.class))
	{
		victim thread maps\mp\gametypes\_playerlogic::spawnclient();
	}
}

checkforcebleedout()
{
	if(level.diehardmode != 1)
	{
		return 0;
	}

	if(!maps\mp\_utility::getgametypenumlives())
	{
		return 0;
	}

	if(level.livescount[self.team] > 0)
	{
		return 0;
	}

	foreach(player in level.players)
	{
		if(!isalive(player))
		{
			continue;
		}

		if(player.team != self.team)
		{
			continue;
		}

		if(player == self)
		{
			continue;
		}

		if(!player.inlaststand)
		{
			return 0;
		}
	}

	foreach(player in level.players)
	{
		if(!isalive(player))
		{
			continue;
		}

		if(player.team != self.team)
		{
			continue;
		}

		if(player.inlaststand && player != self)
		{
			player laststandbleedout(0);
		}
	}

	return 1;
}

checkkillsteal(param_B12)
{
	if(maps\mp\_utility::matchmakinggame())
	{
		return;
	}

	greatestdamage = 0;
	greatestattacker = undefined;
	if(isdefined(param_B12.attackerdata) && param_B12.attackerdata.size > 1)
	{
		foreach(attacker in param_B12.attackerdata)
		{
			if(attacker.damage > greatestdamage)
			{
				greatestdamage = attacker.damage;
				greatestattacker = attacker.attackerent;
			}
		}

		if(isdefined(greatestattacker) && greatestattacker != self)
		{
			maps\mp\_utility::incplayerstat("killsteals", 1);
			return;
		}

		return;
	}
}

dofinalkillcam(delay, victim, attacker, attackernum, killcamentityindex, killcamentitystarttime, sweapon, deathtimeoffset, psoffsettime)
{
	level.showingfinalkillcam = 1;
	level waittill("round_end_finished");
	if(!isdefined(victim) || !isdefined(attacker))
	{
		level.showingfinalkillcam = 0;
		return;
	}

	postdeathdelay = gettime() - victim.deathtime / 1000;
	foreach(player in level.players)
	{
		player closepopupmenu();
		player closeingamemenu();
		player visionsetnakedforplayer(getdvar("mapname"), 0);
		player.killcamentitylookat = victim getentitynumber();
		if((player != victim || !maps\mp\_utility::isroundbased() || maps\mp\_utility::islastround()) && player maps\mp\_utility::_hasperk("specialty_copycat"))
		{
			player maps\mp\_utility::_unsetperk("specialty_copycat");
		}

		player thread maps\mp\gametypes\_killcam::killcam(attackernum, killcamentityindex, killcamentitystarttime, sweapon, postdeathdelay + deathtimeoffset, psoffsettime, 0, 10000, attacker, victim);
	}

	wait 0.1;
	while(anyplayersinkillcam())
	{
		wait 0.05;
	}

	level.showingfinalkillcam = 0;
}

anyplayersinkillcam()
{
	foreach(player in level.players)
	{
		if(isdefined(player.killcam))
		{
			return 1;
		}
	}

	return 0;
}

resetplayervariables()
{
	self.killedplayerscurrent = [];
	self.switching_teams = undefined;
	self.joining_team = undefined;
	self.leaving_team = undefined;
	self.pers["cur_kill_streak"] = 0;
	maps\mp\gametypes\_gameobjects::detachusemodels();
}

getkillcamentity(attacker, einflictor, sweapon)
{
	if(!isdefined(einflictor))
	{
		return undefined;
	}

	if(einflictor == attacker)
	{
		return undefined;
	}

	if(issubstr(sweapon, "ac130_"))
	{
		return undefined;
	}

	if(sweapon == "cobra_player_minigun_mp")
	{
		return undefined;
	}

	if(sweapon == "artillery_mp" || sweapon == "stealth_bomb_mp" || sweapon == "pavelow_minigun_mp")
	{
		return einflictor.killcament;
	}

	if(isdefined(einflictor.script_gameobjectname) && einflictor.script_gameobjectname == "bombzone")
	{
		return einflictor.killcament;
	}

	if(einflictor.classname == "script_origin" || einflictor.classname == "script_model" || einflictor.classname == "script_brushmodel")
	{
		return undefined;
	}

	if(issubstr(sweapon, "remotemissile_"))
	{
		return undefined;
	}

	if(issubstr(sweapon, "ac130_"))
	{
		return undefined;
	}

	return einflictor;
}

hitlocdebug(attacker, victim, damage, hitloc, dflags)
{
	colors = [];
	colors[0] = 2;
	colors[1] = 3;
	colors[2] = 5;
	colors[3] = 7;
	if(!getdvarint("scr_hitloc_debug"))
	{
		return;
	}

	if(!isdefined(attacker.hitlocinited))
	{
		for(i = 0;i < 6;i++)
		{
			attacker setclientdvar("ui_hitloc_" + i, "");
		}

		attacker.hitlocinited = 1;
	}

	if(level.splitscreen || !isplayer(attacker))
	{
		return;
	}

	elemcount = 6;
	if(!isdefined(attacker.damageinfo))
	{
		attacker.damageinfo = [];
		for(i = 0;i < elemcount;i++)
		{
			attacker.damageinfo[i] = spawnstruct();
			attacker.damageinfo[i].damage = 0;
			attacker.damageinfo[i].hitloc = "";
			attacker.damageinfo[i].bp = 0;
			attacker.damageinfo[i].jugg = 0;
			attacker.damageinfo[i].colorindex = 0;
		}

		attacker.damageinfocolorindex = 0;
		attacker.damageinfovictim = undefined;
	}

	for(i = elemcount - 1;i > 0;i--)
	{
		attacker.damageinfo[i].damage = attacker.damageinfo[i - 1].damage;
		attacker.damageinfo[i].hitloc = attacker.damageinfo[i - 1].hitloc;
		attacker.damageinfo[i].bp = attacker.damageinfo[i - 1].bp;
		attacker.damageinfo[i].jugg = attacker.damageinfo[i - 1].jugg;
		attacker.damageinfo[i].colorindex = attacker.damageinfo[i - 1].colorindex;
	}

	attacker.damageinfo[0].damage = damage;
	attacker.damageinfo[0].hitloc = hitloc;
	attacker.damageinfo[0].bp = dflags & level.idflags_penetration;
	attacker.damageinfo[0].jugg = victim hasperk("specialty_armorvest", 1);
	if(isdefined(attacker.damageinfovictim) && attacker.damageinfovictim != victim)
	{
		attacker.damageinfocolorindex++;
		if(attacker.damageinfocolorindex == colors.size)
		{
			attacker.damageinfocolorindex = 0;
		}
	}

	attacker.damageinfovictim = victim;
	attacker.damageinfo[0].colorindex = attacker.damageinfocolorindex;
	for(i = 0;i < elemcount;i++)
	{
		color = "^" + colors[attacker.damageinfo[i].colorindex];
		if(attacker.damageinfo[i].hitloc != "")
		{
			val = color + attacker.damageinfo[i].hitloc;
			if(attacker.damageinfo[i].bp)
			{
				val = val + " (BP)";
			}

			if(attacker.damageinfo[i].jugg)
			{
				val = val + " (Jugg)";
			}

			attacker setclientdvar("ui_hitloc_" + i, val);
		}

		attacker setclientdvar("ui_hitloc_damage_" + i, color + attacker.damageinfo[i].damage);
	}
}

giverecentshieldxp()
{
	self endon("death");
	self endon("disconnect");
	self notify("giveRecentShieldXP");
	self endon("giveRecentShieldXP");
	self.recentshieldxp++;
	wait 20;
	self.recentshieldxp = 0;
}

callback_playerdamage_internal(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(!maps\mp\_utility::isreallyalive(victim))
	{
		return;
	}

	if(isdefined(eattacker) && eattacker.classname == "script_origin" && isdefined(eattacker.type) && eattacker.type == "soft_landing")
	{
		return;
	}

	if(isdefined(level.hostmigrationtimer))
	{
		return;
	}

	if(smeansofdeath == "MOD_FALLING")
	{
		victim thread emitfalldamage(idamage);
	}

	if(smeansofdeath == "MOD_EXPLOSIVE_BULLET" && idamage != 1)
	{
		idamage = idamage * getdvarfloat("scr_explBulletMod");
		idamage = int(idamage);
	}

	if(isdefined(eattacker) && eattacker.classname == "worldspawn")
	{
		eattacker = undefined;
	}

	if(isdefined(eattacker) && isdefined(eattacker.gunner))
	{
		eattacker = eattacker.gunner;
	}

	attackerisnpc = isdefined(eattacker) && !isdefined(eattacker.gunner) && eattacker.classname == "script_vehicle" || eattacker.classname == "misc_turret" || eattacker.classname == "script_model";
	attackerishittingteammate = level.teambased && isdefined(eattacker) && victim != eattacker && isdefined(eattacker.team) && victim.pers["team"] == eattacker.team;
	stunfraction = 0;
	if(idflags & level.idflags_stun)
	{
		stunfraction = 0;
		idamage = 0;
	}
	else if(shitloc == "shield")
	{
		if(attackerishittingteammate && level.friendlyfire == 0)
		{
			return;
		}

		if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" && !attackerishittingteammate)
		{
			if(isplayer(eattacker))
			{
				eattacker.lastattackedshieldplayer = victim;
				eattacker.lastattackedshieldtime = gettime();
			}

			victim notify("shield_blocked");
			if(sweapon == "turret_minigun_mp")
			{
				shielddamage = 25;
			}
			else
			{
				shielddamage = maps\mp\perks\_perks::cac_modified_damage(victim, eattacker, idamage, smeansofdeath, sweapon, vpoint, vdir, shitloc);
			}

			victim.shielddamage = victim.shielddamage + shielddamage;
			if(sweapon != "turret_minigun_mp" || common_scripts\utility::cointoss())
			{
				victim.shieldbullethits++;
			}

			if(victim.shieldbullethits >= level.riotshieldxpbullets)
			{
				if(self.recentshieldxp > 4)
				{
					xpval = int(50 / self.recentshieldxp);
				}
				else
				{
					xpval = 50;
				}

				victim thread maps\mp\gametypes\_rank::giverankxp("shield_damage", xpval);
				victim thread giverecentshieldxp();
				victim thread maps\mp\gametypes\_missions::genericchallenge("shield_damage", victim.shielddamage);
				victim thread maps\mp\gametypes\_missions::genericchallenge("shield_bullet_hits", victim.shieldbullethits);
				victim.shielddamage = 0;
				victim.shieldbullethits = 0;
			}
		}

		if(idflags & level.idflags_shield_explosive_impact)
		{
			if(!attackerishittingteammate)
			{
				victim thread maps\mp\gametypes\_missions::genericchallenge("shield_explosive_hits", 1);
			}

			shitloc = "none";
			if(!idflags & level.idflags_shield_explosive_impact_huge)
			{
				idamage = idamage * 0;
			}
		}
		else if(idflags & level.idflags_shield_explosive_splash)
		{
			if(isdefined(einflictor) && isdefined(einflictor.stuckenemyentity) && einflictor.stuckenemyentity == victim)
			{
				idamage = 101;
			}

			victim thread maps\mp\gametypes\_missions::genericchallenge("shield_explosive_hits", 1);
			shitloc = "none";
		}
		else
		{
			return;
		}
	}
	else if(smeansofdeath == "MOD_MELEE" && issubstr(sweapon, "riotshield"))
	{
		if(!attackerishittingteammate && level.friendlyfire == 0)
		{
			stunfraction = 0;
			victim stunplayer(0);
		}
	}

	if(!attackerishittingteammate)
	{
		idamage = maps\mp\perks\_perks::cac_modified_damage(victim, eattacker, idamage, smeansofdeath, sweapon, vpoint, vdir, shitloc);
	}

	if(!idamage)
	{
		return 0;
	}

	victim.idflags = idflags;
	victim.idflagstime = gettime();
	if(game["state"] == "postgame")
	{
		return;
	}

	if(victim.sessionteam == "spectator")
	{
		return;
	}

	if(isdefined(victim.candocombat) && !victim.candocombat)
	{
		return;
	}

	if(isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.candocombat) && !eattacker.candocombat)
	{
		return;
	}

	if(attackerisnpc && attackerishittingteammate)
	{
		if(smeansofdeath == "MOD_CRUSH")
		{
			victim maps\mp\_utility::_suicide();
			return;
		}

		if(!level.friendlyfire)
		{
			return;
		}
	}

	if(!isdefined(vdir))
	{
		idflags = idflags | level.idflags_no_knockback;
	}

	friendly = 0;
	if((victim.health == victim.maxhealth && !isdefined(victim.laststand) || !victim.laststand) || !isdefined(victim.attackers) && !isdefined(victim.laststand))
	{
		victim.attackers = [];
		victim.attackerdata = [];
	}

	if(isheadshot(sweapon, shitloc, smeansofdeath, eattacker))
	{
		smeansofdeath = "MOD_HEAD_SHOT";
	}

	if(maps\mp\gametypes\_tweakables::gettweakablevalue("game", "onlyheadshots"))
	{
		if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET")
		{
			return;
		}

		if(smeansofdeath == "MOD_HEAD_SHOT")
		{
			idamage = 150;
		}
	}

	if(sweapon == "none" && isdefined(einflictor))
	{
		if(isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_"))
		{
			sweapon = "destructible_car";
		}
	}

	if(!idflags & level.idflags_no_protection)
	{
		if(!level.teambased && attackerisnpc && isdefined(eattacker.owner) && eattacker.owner == victim)
		{
			if(smeansofdeath == "MOD_CRUSH")
			{
				victim maps\mp\_utility::_suicide();
			}

			return;
		}

		if((issubstr(smeansofdeath, "MOD_GRENADE") || issubstr(smeansofdeath, "MOD_EXPLOSIVE") || issubstr(smeansofdeath, "MOD_PROJECTILE")) && isdefined(einflictor) && isdefined(eattacker))
		{
			if(einflictor.classname == "grenade" && victim.lastspawntime + 3500 > gettime() && isdefined(victim.lastspawnpoint) && distance(einflictor.origin, victim.lastspawnpoint.origin) < 250)
			{
				return;
			}

			victim.explosiveinfo = [];
			victim.explosiveinfo["damageTime"] = gettime();
			victim.explosiveinfo["damageId"] = einflictor getentitynumber();
			victim.explosiveinfo["returnToSender"] = 0;
			victim.explosiveinfo["counterKill"] = 0;
			victim.explosiveinfo["chainKill"] = 0;
			victim.explosiveinfo["cookedKill"] = 0;
			victim.explosiveinfo["throwbackKill"] = 0;
			victim.explosiveinfo["suicideGrenadeKill"] = 0;
			victim.explosiveinfo["weapon"] = sweapon;
			isfrag = issubstr(sweapon, "frag_");
			if(eattacker != victim)
			{
				if((issubstr(sweapon, "c4_") || issubstr(sweapon, "claymore_")) && isdefined(eattacker) && isdefined(einflictor.owner))
				{
					victim.explosiveinfo["returnToSender"] = einflictor.owner == victim;
					victim.explosiveinfo["counterKill"] = isdefined(einflictor.wasdamaged);
					victim.explosiveinfo["chainKill"] = isdefined(einflictor.waschained);
					victim.explosiveinfo["bulletPenetrationKill"] = isdefined(einflictor.wasdamagedfrombulletpenetration);
					victim.explosiveinfo["cookedKill"] = 0;
				}

				if(isdefined(eattacker.lastgrenadesuicidetime) && eattacker.lastgrenadesuicidetime >= gettime() - 50 && isfrag)
				{
					victim.explosiveinfo["suicideGrenadeKill"] = 1;
				}
			}

			if(isfrag)
			{
				victim.explosiveinfo["cookedKill"] = isdefined(einflictor.iscooked);
				victim.explosiveinfo["throwbackKill"] = isdefined(einflictor.threwback);
			}

			victim.explosiveinfo["stickKill"] = isdefined(einflictor.isstuck) && einflictor.isstuck == "enemy";
			victim.explosiveinfo["stickFriendlyKill"] = isdefined(einflictor.isstuck) && einflictor.isstuck == "friendly";
		}

		if(isplayer(eattacker))
		{
			eattacker.pers["participation"]++;
		}

		prevhealthratio = victim.health / victim.maxhealth;
		if(attackerishittingteammate)
		{
			if(!maps\mp\_utility::matchmakinggame() && isplayer(eattacker))
			{
				eattacker maps\mp\_utility::incplayerstat("mostff", 1);
			}

			if(level.friendlyfire == 0 || !isplayer(eattacker) && level.friendlyfire != 1)
			{
				if(sweapon == "artillery_mp" || sweapon == "stealth_bomb_mp")
				{
					victim damageshellshockandrumble(einflictor, sweapon, smeansofdeath, idamage, idflags, eattacker);
				}

				return;
			}

			if(level.friendlyfire == 1)
			{
				if(idamage < 1)
				{
					idamage = 1;
				}

				victim.lastdamagewasfromenemy = 0;
				victim finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, stunfraction);
			}
			else if(level.friendlyfire == 2 && maps\mp\_utility::isreallyalive(eattacker))
			{
				idamage = int(idamage * 0.5);
				if(idamage < 1)
				{
					idamage = 1;
				}

				eattacker.lastdamagewasfromenemy = 0;
				eattacker.friendlydamage = 1;
				eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, stunfraction);
				eattacker.friendlydamage = undefined;
			}
			else if(level.friendlyfire == 3 && maps\mp\_utility::isreallyalive(eattacker))
			{
				idamage = int(idamage * 0.5);
				if(idamage < 1)
				{
					idamage = 1;
				}

				victim.lastdamagewasfromenemy = 0;
				eattacker.lastdamagewasfromenemy = 0;
				victim finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, stunfraction);
				if(maps\mp\_utility::isreallyalive(eattacker))
				{
					eattacker.friendlydamage = 1;
					eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, stunfraction);
					eattacker.friendlydamage = undefined;
				}
			}

			friendly = 1;
		}
		else
		{
			if(idamage < 1)
			{
				idamage = 1;
			}

			if(isdefined(eattacker) && isplayer(eattacker))
			{
				addattacker(victim, eattacker, einflictor, sweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath);
			}

			if(smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" && idamage < victim.health)
			{
				victim notify("survived_explosion");
			}

			if(isdefined(eattacker))
			{
				level.lastlegitimateattacker = eattacker;
			}

			if(isdefined(eattacker) && isplayer(eattacker) && isdefined(sweapon))
			{
				eattacker thread maps\mp\gametypes\_weapons::checkhit(sweapon, victim);
			}

			if(isdefined(eattacker) && isplayer(eattacker) && isdefined(sweapon) && eattacker != victim)
			{
				eattacker thread maps\mp\_events::damagedplayer(self, idamage, sweapon);
				victim.attackerposition = eattacker.origin;
			}
			else
			{
				victim.attackerposition = undefined;
			}

			if(issubstr(smeansofdeath, "MOD_GRENADE") && isdefined(einflictor.iscooked))
			{
				victim.wascooked = gettime();
			}
			else
			{
				victim.wascooked = undefined;
			}

			victim.lastdamagewasfromenemy = isdefined(eattacker) && eattacker != victim;
			if(victim.lastdamagewasfromenemy)
			{
				eattacker.damagedplayers[victim.guid] = gettime();
			}

			victim finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, stunfraction);
			if(isdefined(level.ac130player) && isdefined(eattacker) && level.ac130player == eattacker)
			{
				level notify("ai_pain", victim);
			}

			victim thread maps\mp\gametypes\_missions::playerdamaged(einflictor, eattacker, idamage, smeansofdeath, sweapon, shitloc);
		}

		if(attackerisnpc && isdefined(eattacker.gunner))
		{
			damager = eattacker.gunner;
		}
		else
		{
			damager = eattacker;
		}

		if(isdefined(damager) && damager != victim && idamage > 0)
		{
			if(idflags & level.idflags_stun)
			{
				typehit = "stun";
			}
			else if(victim hasperk("specialty_armorvest", 1) || maps\mp\_utility::isexplosivedamage(smeansofdeath) && victim maps\mp\_utility::_hasperk("_specialty_blastshield"))
			{
				typehit = "hitBodyArmor";
			}
			else if(victim maps\mp\_utility::_hasperk("specialty_combathigh"))
			{
				typehit = "hitEndGame";
			}
			else
			{
				typehit = "standard";
			}

			damager thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(typehit);
		}

		victim.hasdonecombat = 1;
	}

	if(isdefined(eattacker) && eattacker != victim && !friendly)
	{
		level.usestartspawns = 0;
	}

	if(getdvarint("g_debugDamage"))
	{
	}

	if(victim.sessionstate != "dead")
	{
		lpselfnum = victim getentitynumber();
		lpselfname = victim.name;
		lpselfteam = victim.pers["team"];
		lpselfguid = victim.guid;
		lpattackerteam = "";
		if(isplayer(eattacker))
		{
			lpattacknum = eattacker getentitynumber();
			lpattackguid = eattacker.guid;
			lpattackname = eattacker.name;
			lpattackerteam = eattacker.pers["team"];
		}
		else
		{
			lpattacknum = -1;
			lpattackguid = "";
			lpattackname = "";
			lpattackerteam = "world";
		}

		logprint("D;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sweapon + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\\n");
	}

	hitlocdebug(eattacker, victim, idamage, shitloc, idflags);
}

addattacker(victim, eattacker, einflictor, sweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath)
{
	if(!isdefined(victim.attackerdata))
	{
		victim.attackerdata = [];
	}

	if(!isdefined(victim.attackerdata[eattacker.guid]))
	{
		victim.attackers[eattacker.guid] = eattacker;
		victim.attackerdata[eattacker.guid] = spawnstruct();
		victim.attackerdata[eattacker.guid].damage = 0;
		victim.attackerdata[eattacker.guid].attackerent = eattacker;
		victim.attackerdata[eattacker.guid].firsttimedamaged = gettime();
	}

	if(maps\mp\gametypes\_weapons::isprimaryweapon(sweapon) && !maps\mp\gametypes\_weapons::issidearm(sweapon))
	{
		victim.attackerdata[eattacker.guid].isprimary = 1;
	}

	victim.attackerdata[eattacker.guid].damage = victim.attackerdata[eattacker.guid].damage + idamage;
	victim.attackerdata[eattacker.guid].weapon = sweapon;
	victim.attackerdata[eattacker.guid].vpoint = vpoint;
	victim.attackerdata[eattacker.guid].vdir = vdir;
	victim.attackerdata[eattacker.guid].shitloc = shitloc;
	victim.attackerdata[eattacker.guid].psoffsettime = psoffsettime;
	victim.attackerdata[eattacker.guid].smeansofdeath = smeansofdeath;
	victim.attackerdata[eattacker.guid].attackerent = eattacker;
	victim.attackerdata[eattacker.guid].lasttimedamaged = gettime();
	if(isdefined(einflictor) && !isplayer(einflictor) && isdefined(einflictor.primaryweapon))
	{
		victim.attackerdata[eattacker.guid].sprimaryweapon = einflictor.primaryweapon;
		return;
	}

	if(isdefined(eattacker) && isplayer(eattacker) && eattacker getcurrentprimaryweapon() != "none")
	{
		victim.attackerdata[eattacker.guid].sprimaryweapon = eattacker getcurrentprimaryweapon();
		return;
	}

	victim.attackerdata[eattacker.guid].sprimaryweapon = undefined;
}

resetattackerlist()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	wait 1.75;
	self.attackers = [];
	self.attackerdata = [];
}

callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime)
{
	callback_playerdamage_internal(einflictor, eattacker, self, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime);
}

finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, stunfraction)
{
	if(maps\mp\_utility::isusingremote() && idamage >= self.health && !idflags & level.idflags_stun)
	{
		if(!isdefined(vdir))
		{
			vdir = (0,0,0);
		}

		if(!isdefined(eattacker) && !isdefined(einflictor))
		{
			eattacker = self;
			einflictor = eattacker;
		}

		playerkilled_internal(einflictor, eattacker, self, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, 0, 1);
	}
	else
	{
		if(!callback_killingblow(einflictor, eattacker, idamage - idamage * stunfraction, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime))
		{
			return;
		}

		self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, stunfraction);
	}

	if(smeansofdeath == "MOD_EXPLOSIVE_BULLET")
	{
		self shellshock("damage_mp", getdvarfloat("scr_csmode"));
	}

	damageshellshockandrumble(einflictor, sweapon, smeansofdeath, idamage, idflags, eattacker);
}

callback_playerlaststand(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	laststandparams = spawnstruct();
	laststandparams.einflictor = einflictor;
	laststandparams.attacker = attacker;
	laststandparams.idamage = idamage;
	laststandparams.attackerposition = attacker.origin;
	if(attacker == self)
	{
		laststandparams.smeansofdeath = "MOD_SUICIDE";
	}
	else
	{
		laststandparams.smeansofdeath = smeansofdeath;
	}

	laststandparams.sweapon = sweapon;
	if(isdefined(attacker) && isplayer(attacker) && attacker getcurrentprimaryweapon() != "none")
	{
		laststandparams.sprimaryweapon = attacker getcurrentprimaryweapon();
	}
	else
	{
		laststandparams.sprimaryweapon = undefined;
	}

	laststandparams.vdir = vdir;
	laststandparams.shitloc = shitloc;
	laststandparams.laststandstarttime = gettime();
	maydolaststand = maydolaststand(sweapon, smeansofdeath, shitloc);
	if(isdefined(self.endgame))
	{
		maydolaststand = 0;
	}

	if(level.teambased && isdefined(attacker.team) && attacker.team == self.team)
	{
		maydolaststand = 0;
	}

	if(!maydolaststand)
	{
		self.laststandparams = laststandparams;
		self.uselaststandparams = 1;
		maps\mp\_utility::_suicide();
		return;
	}

	self.inlaststand = 1;
	notifydata = spawnstruct();
	if(maps\mp\_utility::_hasperk("specialty_finalstand"))
	{
		notifydata.titletext = game["strings"]["final_stand"];
		notifydata.iconname = "specialty_finalstand";
	}
	else
	{
		notifydata.titletext = game["strings"]["last_stand"];
		notifydata.iconname = "specialty_pistoldeath";
	}

	notifydata.glowcolor = (1,0,0);
	notifydata.sound = "mp_last_stand";
	notifydata.duration = 2;
	self.health = 1;
	thread maps\mp\gametypes\_hud_message::notifymessage(notifydata);
	grenadetypeprimary = "frag_grenade_mp";
	if(isdefined(level.ac130player) && isdefined(attacker) && level.ac130player == attacker)
	{
		level notify("ai_crawling", self);
	}

	if(maps\mp\_utility::_hasperk("specialty_finalstand"))
	{
		self.laststandparams = laststandparams;
		self.infinalstand = 1;
		weaponlist = self getweaponslistexclusives();
		foreach(weapon in weaponlist)
		{
			self takeweapon(weapon);
		}

		common_scripts\utility::_disableusability();
		thread enablelaststandweapons();
		thread laststandtimer(20, 1);
		return;
	}

	if(level.diehardmode)
	{
		self.laststandparams = laststandparams;
		thread enablelaststandweapons();
		thread laststandtimer(20, 0);
		common_scripts\utility::_disableusability();
		return;
	}

	self.laststandparams = laststandparams;
	pistolweapon = undefined;
	weaponslist = self getweaponslistprimaries();
	foreach(weapon in weaponslist)
	{
		if(maps\mp\gametypes\_weapons::issidearm(weapon))
		{
			pistolweapon = weapon;
		}
	}

	if(!isdefined(pistolweapon))
	{
		pistolweapon = "beretta_mp";
		maps\mp\_utility::_giveweapon(pistolweapon);
	}

	self givemaxammo(pistolweapon);
	self disableweaponswitch();
	common_scripts\utility::_disableusability();
	if(!maps\mp\_utility::_hasperk("specialty_laststandoffhand"))
	{
		self disableoffhandweapons();
	}

	self switchtoweapon(pistolweapon);
	thread laststandtimer(10, 0);
}

dieaftertime(time)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	wait time;
	self.uselaststandparams = 1;
	maps\mp\_utility::_suicide();
}

detonateonuse()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self waittill("detonate");
	self.uselaststandparams = 1;
	c4deathdetonate();
}

detonateondeath()
{
	self endon("detonate");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self waittill("death");
	c4deathdetonate();
}

c4deathdetonate()
{
	self playsound("detpack_explo_default");
	self.c4deatheffect = playfx(level.c4death, self.origin);
	radiusdamage(self.origin, 400, 100, 100, self);
	if(isalive(self))
	{
		maps\mp\_utility::_suicide();
		return;
	}
}

enablelaststandweapons()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::freezecontrolswrapper(1);
	wait 0.3;
	maps\mp\_utility::freezecontrolswrapper(0);
}

laststandtimer(delay, param_B36)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	level notify("player_last_stand");
	thread laststandwaittilldeath();
	self.laststand = 1;
	if(!param_B36 && !level.diehardmode && !isdefined(self.inc4death) || !self.inc4death)
	{
		thread laststandallowsuicide();
		maps\mp\_utility::setlowermessage("last_stand", &"PLATFORM_COWARDS_WAY_OUT");
		thread laststandkeepoverlay();
	}

	if(level.diehardmode == 1 && level.diehardmode != 2)
	{
		reviveent = spawn("script_model", self.origin);
		reviveent setmodel("tag_origin");
		reviveent setcursorhint("HINT_NOICON");
		reviveent sethintstring(&"PLATFORM_REVIVE");
		reviveent revivesetup(self);
		reviveent endon("death");
		reviveicon = newteamhudelem(self.team);
		reviveicon setshader("waypoint_revive", 8, 8);
		reviveicon setwaypoint(1, 1);
		reviveicon settargetent(self);
		reviveicon thread destroyonreviveentdeath(reviveent);
		reviveicon.color = (0.33,0.75,0.24);
		maps\mp\_utility::playdeathsound();
		if(param_B36)
		{
			wait delay;
			if(self.infinalstand)
			{
				thread laststandbleedout(param_B36, reviveent);
			}
		}

		return;
	}

	if(level.diehardmode == 2)
	{
		thread laststandkeepoverlay();
		reviveent = spawn("script_model", self.origin);
		reviveent setmodel("tag_origin");
		reviveent setcursorhint("HINT_NOICON");
		reviveent sethintstring(&"PLATFORM_REVIVE");
		reviveent revivesetup(self);
		reviveent endon("death");
		reviveicon = newteamhudelem(self.team);
		reviveicon setshader("waypoint_revive", 8, 8);
		reviveicon setwaypoint(1, 1);
		reviveicon settargetent(self);
		reviveicon thread destroyonreviveentdeath(reviveent);
		reviveicon.color = (0.33,0.75,0.24);
		maps\mp\_utility::playdeathsound();
		if(param_B36)
		{
			wait delay;
			if(self.infinalstand)
			{
				thread laststandbleedout(param_B36, reviveent);
			}
		}

		wait delay / 3;
		reviveicon.color = (1,0.64,0);
		while(reviveent.inuse)
		{
			wait 0.05;
		}

		maps\mp\_utility::playdeathsound();
		wait delay / 3;
		reviveicon.color = (1,0,0);
		while(reviveent.inuse)
		{
			wait 0.05;
		}

		maps\mp\_utility::playdeathsound();
		wait delay / 3;
		while(reviveent.inuse)
		{
			wait 0.05;
		}

		wait 0.05;
		thread laststandbleedout(param_B36);
		return;
	}

	wait delay;
	thread laststandbleedout(param_B36);
}

maxhealthoverlay(maxhealth, refresh)
{
	self endon("stop_maxHealthOverlay");
	self endon("revive");
	self endon("death");
	for(;;)
	{
		self.health = self.health - 1;
		self.maxhealth = maxhealth;
		wait 0.05;
		self.maxhealth = 50;
		self.health = self.health + 1;
		wait 0.5;
	}
}

laststandbleedout(param_B3B, reviveent)
{
	if(param_B3B)
	{
		self.laststand = undefined;
		self.infinalstand = 0;
		maps\mp\_utility::clearlowermessage("last_stand");
		maps\mp\gametypes\_playerlogic::laststandrespawnplayer();
		if(isdefined(reviveent))
		{
			reviveent delete();
			return;
		}

		return;
	}

	self.uselaststandparams = 1;
	self.beingrevived = 0;
	maps\mp\_utility::_suicide();
}

laststandallowsuicide()
{
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	self endon("revive");
	for(;;)
	{
		if(self usebuttonpressed())
		{
			pressstarttime = gettime();
			while(self usebuttonpressed())
			{
				wait 0.05;
				if(gettime() - pressstarttime > 700)
				{
					break;
				}
			}

			if(gettime() - pressstarttime > 700)
			{
				break;
			}
		}

		wait 0.05;
	}

	thread laststandbleedout(0);
}

laststandkeepoverlay()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	while(!level.gameended)
	{
		self.health = 2;
		wait 0.05;
		self.health = 1;
		wait 0.5;
	}

	self.health = self.maxhealth;
}

laststandwaittilldeath()
{
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	self waittill("death");
	maps\mp\_utility::clearlowermessage("last_stand");
	self.laststand = undefined;
}

maydolaststand(sweapon, smeansofdeath, shitloc)
{
	if(smeansofdeath == "MOD_TRIGGER_HURT")
	{
		return 0;
	}

	if(smeansofdeath != "MOD_PISTOL_BULLET" && smeansofdeath != "MOD_RIFLE_BULLET" && smeansofdeath != "MOD_FALLING" && smeansofdeath != "MOD_EXPLOSIVE_BULLET")
	{
		return 0;
	}

	if(smeansofdeath == "MOD_IMPACT" && sweapon == "throwingknife_mp")
	{
		return 0;
	}

	if(smeansofdeath == "MOD_IMPACT" && sweapon == "m79_mp" || issubstr(sweapon, "gl_"))
	{
		return 0;
	}

	if(isheadshot(sweapon, shitloc, smeansofdeath))
	{
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	return 1;
}

ensurelaststandparamsvalidity()
{
	if(!isdefined(self.laststandparams.attacker))
	{
		self.laststandparams.attacker = self;
		return;
	}
}

gethitlocheight(shitloc)
{
	switch(shitloc)
	{
		case "neck":
		case "helmet":
		case "head":
			return 60;

		case "gun":
		case "left_hand":
		case "right_hand":
		case "left_arm_lower":
		case "right_arm_lower":
		case "left_arm_upper":
		case "right_arm_upper":
		case "torso_upper":
			return 48;

		case "torso_lower":
			return 40;

		case "left_leg_upper":
		case "right_leg_upper":
			return 32;

		case "left_leg_lower":
		case "right_leg_lower":
			return 10;

		case "left_foot":
		case "right_foot":
			return 5;
	}

	return 48;
}

delaystartragdoll(ent, shitloc, vdir, sweapon, einflictor, smeansofdeath)
{
	if(isdefined(ent))
	{
		deathanim = ent getcorpseanim();
		if(animhasnotetrack(deathanim, "ignore_ragdoll"))
		{
			return;
		}
	}

	wait 0.2;
	if(!isdefined(ent))
	{
		return;
	}

	if(ent isragdoll())
	{
		return;
	}

	deathanim = ent getcorpseanim();
	startfrac = 0.35;
	if(animhasnotetrack(deathanim, "start_ragdoll"))
	{
		times = getnotetracktimes(deathanim, "start_ragdoll");
		if(isdefined(times))
		{
			startfrac = times[0];
		}
	}

	waittime = startfrac * getanimlength(deathanim);
	wait waittime;
	if(isdefined(ent))
	{
		ent startragdoll(1);
		return;
	}
}

getmostkilledby()
{
	mostkilledby = "";
	killcount = 0;
	killedbynames = getarraykeys(self.killedby);
	for(index = 0;index < killedbynames.size;index++)
	{
		killedbyname = killedbynames[index];
		if(self.killedby[killedbyname] <= killcount)
		{
			continue;
		}

		killcount = self.killedby[killedbyname];
		mostkilleby = killedbyname;
	}

	return mostkilledby;
}

getmostkilled()
{
	mostkilled = "";
	killcount = 0;
	killednames = getarraykeys(self.killedplayers);
	for(index = 0;index < killednames.size;index++)
	{
		killedname = killednames[index];
		if(self.killedplayers[killedname] <= killcount)
		{
			continue;
		}

		killcount = self.killedplayers[killedname];
		mostkilled = killedname;
	}

	return mostkilled;
}

damageshellshockandrumble(einflictor, sweapon, smeansofdeath, idamage, idflags, eattacker)
{
	thread maps\mp\gametypes\_weapons::onweapondamage(einflictor, sweapon, smeansofdeath, idamage, eattacker);
	self playrumbleonentity("damage_heavy");
}

revivesetup(owner)
{
	team = owner.team;
	self linkto(owner, "tag_origin");
	self.owner = owner;
	self.inuse = 0;
	self makeusable();
	updateusablebyteam(team);
	thread trackteamchanges(team);
	thread revivetriggerthink(team);
	thread deleteonreviveordeathordisconnect();
}

deleteonreviveordeathordisconnect()
{
	self endon("death");
	self.owner common_scripts\utility::waittill_any("death", "disconnect");
	self delete();
}

updateusablebyteam(team)
{
	foreach(player in level.players)
	{
		if(team == player.team && player != self.owner)
		{
			self enableplayeruse(player);
			continue;
		}

		self disableplayeruse(player);
	}
}

trackteamchanges(team)
{
	self endon("death");
	for(;;)
	{
		level waittill("joined_team");
		updateusablebyteam(team);
	}
}

tracklaststandchanges(team)
{
	self endon("death");
	for(;;)
	{
		level waittill("player_last_stand");
		updateusablebyteam(team);
	}
}

revivetriggerthink(team)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger", player);
		self.owner.beingrevived = 1;
		if(isdefined(player.beingrevived) && player.beingrevived)
		{
			self.owner.beingrevived = 0;
			continue;
		}

		self makeunusable();
		self.owner maps\mp\_utility::freezecontrolswrapper(1);
		revived = useholdthink(player);
		self.owner.beingrevived = 0;
		if(!isalive(self.owner))
		{
			self delete();
			return;
		}

		self.owner maps\mp\_utility::freezecontrolswrapper(0);
		if(revived)
		{
			player thread maps\mp\gametypes\_hud_message::splashnotifydelayed("reviver", 200);
			player thread maps\mp\gametypes\_rank::giverankxp("reviver", 200);
			self.owner.laststand = undefined;
			self.owner maps\mp\_utility::clearlowermessage("last_stand");
			if(self.owner maps\mp\_utility::_hasperk("specialty_lightweight"))
			{
				self.owner.movespeedscaler = 1.1;
			}
			else
			{
				self.owner.movespeedscaler = 1;
			}

			self.owner.maxhealth = 100;
			self.owner maps\mp\gametypes\_weapons::updatemovespeedscale("primary");
			self.owner maps\mp\gametypes\_playerlogic::laststandrespawnplayer();
			self.owner setperk("specialty_pistoldeath", 1);
			self.owner.beingrevived = 0;
			self delete();
			return;
		}

		self makeusable();
		updateusablebyteam(team);
	}
}

useholdthink(player)
{
	revivespot = spawn("script_origin", self.origin);
	revivespot hide();
	player playerlinkto(revivespot);
	player playerlinkedoffsetenable();
	player common_scripts\utility::_disableweapon();
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	self.usetime = 3000;
	player thread personalusebar(self);
	result = useholdthinkloop(player);
	if(isdefined(player) && maps\mp\_utility::isreallyalive(player))
	{
		player unlink();
		player common_scripts\utility::_enableweapon();
	}

	if(isdefined(result) && result)
	{
		self.owner thread maps\mp\gametypes\_hud_message::playercardsplashnotify("revived", player);
		self.owner.inlaststand = 0;
		return 1;
	}

	self.inuse = 0;
	revivespot delete();
	return 0;
}

personalusebar(object)
{
	usebar = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
	usebartext = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
	usebartext settext(&"MPUI_REVIVING");
	objusebar = object.owner maps\mp\gametypes\_hud_util::createprimaryprogressbar();
	objusebartext = object.owner maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
	objusebartext settext(&"MPUI_BEING_REVIVED");
	lastrate = -1;
	while(maps\mp\_utility::isreallyalive(self) && isdefined(object) && object.inuse && !level.gameended && isdefined(self))
	{
		if(lastrate != object.userate)
		{
			if(object.curprogress > object.usetime)
			{
				object.curprogress = object.usetime;
			}

			usebar maps\mp\gametypes\_hud_util::updatebar(object.curprogress / object.usetime, 1000 / object.usetime * object.userate);
			objusebar maps\mp\gametypes\_hud_util::updatebar(object.curprogress / object.usetime, 1000 / object.usetime * object.userate);
			if(!object.userate)
			{
				usebar maps\mp\gametypes\_hud_util::hideelem();
				usebartext maps\mp\gametypes\_hud_util::hideelem();
				objusebar maps\mp\gametypes\_hud_util::hideelem();
				objusebartext maps\mp\gametypes\_hud_util::hideelem();
			}
			else
			{
				usebar maps\mp\gametypes\_hud_util::showelem();
				usebartext maps\mp\gametypes\_hud_util::showelem();
				objusebar maps\mp\gametypes\_hud_util::showelem();
				objusebartext maps\mp\gametypes\_hud_util::showelem();
			}
		}

		lastrate = object.userate;
		wait 0.05;
	}

	if(isdefined(usebar))
	{
		usebar maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(usebartext))
	{
		usebartext maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(objusebar))
	{
		objusebar maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(objusebartext))
	{
		objusebartext maps\mp\gametypes\_hud_util::destroyelem();
		return;
	}
}

useholdthinkloop(player)
{
	level endon("game_ended");
	self.owner endon("death");
	self.owner endon("disconnect");
	while(maps\mp\_utility::isreallyalive(player) && player usebuttonpressed() && self.curprogress < self.usetime)
	{
		self.curprogress = self.curprogress + 50 * self.userate;
		self.userate = 1;
		if(self.curprogress >= self.usetime)
		{
			self.inuse = 0;
			return maps\mp\_utility::isreallyalive(player);
		}

		wait 0.05;
	}

	return 0;
}

callback_killingblow(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(isdefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy && idamage >= self.health && isdefined(self.combathigh) && self.combathigh == "specialty_endgame")
	{
		maps\mp\_utility::setadrenaline(0);
		maps\mp\_utility::_setperk("specialty_endgame");
		return 0;
	}

	return 1;
}

emitfalldamage(idamage)
{
	physicsexplosionsphere(self.origin, 64, 64, 1);
	damageents = [];
	testangle = 0;
	while(testangle < 360)
	{
		xoffset = cos(testangle) * 16;
		yoffset = sin(testangle) * 16;
		tracedata = bullettrace(self.origin + (xoffset,yoffset,4), self.origin + (xoffset,yoffset,-6), 1, self);
		if(isdefined(tracedata["entity"]) && isdefined(tracedata["entity"].targetname) && tracedata["entity"].targetname == "destructible_vehicle" || tracedata["entity"].targetname == "destructible_toy")
		{
			damageents[damageents.size] = tracedata["entity"];
		}

		testangle = testangle + 30;
	}

	if(damageents.size)
	{
		damageowner = spawn("script_origin", self.origin);
		damageowner hide();
		damageowner.type = "soft_landing";
		damageowner.destructibles = damageents;
		radiusdamage(self.origin, 64, 100, 100, damageowner);
		wait 0.1;
		damageowner delete();
		return;
	}
}

drawline(start, end, timeslice)
{
	drawtime = int(timeslice * 20);
	for(time = 0;time < drawtime;time++)
	{
		wait 0.05;
	}
}

isflankkill(victim, attacker)
{
	victimforward = anglestoforward(victim.angles);
	victimforward = (victimforward[0],victimforward[1],0);
	victimforward = vectornormalize(victimforward);
	attackdirection = victim.origin - attacker.origin;
	attackdirection = (attackdirection[0],attackdirection[1],0);
	attackdirection = vectornormalize(attackdirection);
	dotproduct = vectordot(victimforward, attackdirection);
	if(dotproduct > 0)
	{
		return 1;
	}

	return 0;
}

_obituary(victim, attacker, sweapon, smeansofdeath)
{
	victimteam = victim.team;
	foreach(player in level.players)
	{
		playerteam = player.team;
		if(playerteam == "spectator")
		{
			player iprintln(&"MP_OBITUARY_NEUTRAL", attacker.name, victim.name);
			continue;
		}

		if(playerteam == victimteam)
		{
			player iprintln(&"MP_OBITUARY_ENEMY", attacker.name, victim.name);
			continue;
		}

		player iprintln(&"MP_OBITUARY_FRIENDLY", attacker.name, victim.name);
	}
}

logprintplayerdeath(lifeid, attacker, idamage, smeansofdeath, sweapon, sprimaryweapon, shitloc)
{
	lpselfnum = self getentitynumber();
	lpselfname = self.name;
	lpselfteam = self.team;
	lpselfguid = self.guid;
	if(isplayer(attacker))
	{
		lpattackguid = attacker.guid;
		lpattackname = attacker.name;
		lpattackerteam = attacker.team;
		lpattacknum = attacker getentitynumber();
		attackerstring = attacker getxuid() + "(" + lpattackname + ")";
	}
	else
	{
		lpattackguid = "";
		lpattackname = "";
		lpattackerteam = "world";
		lpattacknum = -1;
		attackerstring = "none";
	}

	logprint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sweapon + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\\n");
}

destroyonreviveentdeath(reviveent)
{
	reviveent waittill("death");
	self destroy();
}