/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_missions.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	precachestring(&"MP_CHALLENGE_COMPLETED");
	if(!mayprocesschallenges())
	{
		return;
	}

	level.missioncallbacks = [];
	registermissioncallback("playerKilled", ::ch_kills);
	registermissioncallback("playerKilled", ::ch_vehicle_kills);
	registermissioncallback("playerHardpoint", ::ch_hardpoints);
	registermissioncallback("playerAssist", ::ch_assists);
	registermissioncallback("roundEnd", ::ch_roundwin);
	registermissioncallback("roundEnd", ::ch_roundplayed);
	registermissioncallback("vehicleKilled", ::ch_vehicle_killed);
	level thread createperkmap();
	level thread onplayerconnect();
}

createperkmap()
{
	level.perkmap = [];
	level.perkmap["specialty_bulletdamage"] = "specialty_stoppingpower";
	level.perkmap["specialty_quieter"] = "specialty_deadsilence";
	level.perkmap["specialty_localjammer"] = "specialty_scrambler";
	level.perkmap["specialty_fastreload"] = "specialty_sleightofhand";
	level.perkmap["specialty_pistoldeath"] = "specialty_laststand";
}

ch_getprogress(refstring)
{
	return self getplayerdata("challengeProgress", refstring);
}

ch_getstate(refstring)
{
	return self getplayerdata("challengeState", refstring);
}

ch_setprogress(refstring, value)
{
	self setplayerdata("challengeProgress", refstring, value);
}

ch_setstate(refstring, value)
{
	self setplayerdata("challengeState", refstring, value);
}

mayprocesschallenges()
{
	return level.rankedmatch;
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		if(!isdefined(player.pers["postGameChallenges"]))
		{
			player.pers["postGameChallenges"] = 0;
		}

		player thread onplayerspawned();
		player thread initmissiondata();
		player thread monitorbombuse();
		player thread monitorfalldistance();
		player thread monitorlivetime();
		player thread monitorstreaks();
		player thread monitorstreakreward();
		player thread monitorscavengerpickup();
		player thread monitorblastshieldsurvival();
		player thread monitortacinsertionsdestroyed();
		player thread monitorprocesschallenge();
		player thread monitorkillstreakprogress();
		player thread monitorfinalstandsurvival();
		player thread monitorcombathighsurvival();
		player thread monitorkilledkillstreak();
		if(isdefined(level.patientzeroname) && issubstr(player.name, level.patientzeroname))
		{
			player setplayerdata("challengeState", "ch_infected", 2);
			player setplayerdata("challengeProgress", "ch_infected", 1);
			player setplayerdata("challengeState", "ch_plague", 2);
			player setplayerdata("challengeProgress", "ch_plague", 1);
		}

		cardtitle = player getplayerdata("cardTitle");
		if(cardtitle == "cardtitle_infected")
		{
			player.infected = 1;
			continue;
		}

		if(cardtitle == "cardtitle_plague")
		{
			player.plague = 1;
		}
	}
}

onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread monitorsprintdistance();
	}
}

monitorscavengerpickup()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("scavenger_pickup");
		if(maps\mp\_utility::_hasperk("specialty_scavenger"))
		{
			processchallenge("ch_scavenger_pro");
		}

		wait 0.05;
	}
}

monitorstreakreward()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("received_earned_killstreak");
		if(maps\mp\_utility::_hasperk("specialty_hardline"))
		{
			processchallenge("ch_hardline_pro");
		}

		wait 0.05;
	}
}

monitorblastshieldsurvival()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("survived_explosion");
		if(maps\mp\_utility::_hasperk("_specialty_blastshield"))
		{
			processchallenge("ch_masterblaster");
		}

		common_scripts\utility::waitframe();
	}
}

monitortacinsertionsdestroyed()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("destroyed_insertion", owner);
		if(self == owner)
		{
			return;
		}

		processchallenge("ch_darkbringer");
		maps\mp\_utility::incplayerstat("mosttacprevented", 1);
		thread maps\mp\gametypes\_hud_message::splashnotify("denied", 20);
		owner maps\mp\gametypes\_hud_message::playercardsplashnotify("destroyed_insertion", self);
		common_scripts\utility::waitframe();
	}
}

monitorfinalstandsurvival()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("revive");
		processchallenge("ch_livingdead");
		common_scripts\utility::waitframe();
	}
}

monitorcombathighsurvival()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("combathigh_survived");
		processchallenge("ch_thenumb");
		common_scripts\utility::waitframe();
	}
}

initmissiondata()
{
	keys = getarraykeys(level.killstreakfuncs);
	foreach(key in keys)
	{
		self.pers[key] = 0;
	}

	self.pers["lastBulletKillTime"] = 0;
	self.pers["bulletStreak"] = 0;
	self.explosiveinfo = [];
}

registermissioncallback(callback, func)
{
	if(!isdefined(level.missioncallbacks[callback]))
	{
		level.missioncallbacks[callback] = [];
	}

	level.missioncallbacks[callback][level.missioncallbacks[callback].size] = func;
}

getchallengestatus(name)
{
	if(isdefined(self.challengedata[name]))
	{
		return self.challengedata[name];
	}

	return 0;
}

isstrstart(string1, substr)
{
	return getsubstr(string1, 0, substr.size) == substr;
}

ch_assists(data)
{
	player = data.player;
	player processchallenge("ch_assists");
}

ch_hardpoints(data)
{
	player = data.player;
	player.pers[data.hardpointtype]++;
	switch(data.hardpointtype)
	{
		case "uav":
			player processchallenge("ch_uav");
			player processchallenge("ch_uavs");
			if(player.pers["uav"] >= 3)
			{
				player processchallenge("ch_nosecrets");
			}
			break;

		case "counter_uav":
			player processchallenge("ch_counter_uav");
			player processchallenge("ch_uavs");
			if(player.pers["counter_uav"] >= 3)
			{
				player processchallenge("ch_sunblock");
			}
			break;

		case "precision_airstrike":
			player processchallenge("ch_precision_airstrike");
			player processchallenge("ch_airstrikes");
			if(player.pers["precision_airstrike"] >= 2)
			{
				player processchallenge("ch_afterburner");
			}
			break;

		case "stealth_airstrike":
			player processchallenge("ch_stealth_airstrike");
			player processchallenge("ch_airstrikes");
			break;

		case "harrier_airstrike":
			player processchallenge("ch_harrier_strike");
			player processchallenge("ch_airstrikes");
			break;

		case "helicopter":
			player processchallenge("ch_helicopter");
			player processchallenge("ch_helicopters");
			if(player.pers["helicopter"] >= 2)
			{
				player processchallenge("ch_airsuperiority");
			}
			break;

		case "helicopter_flares":
			player processchallenge("ch_helicopter_flares");
			player processchallenge("ch_helicopters");
			break;

		case "helicopter_minigun":
			player processchallenge("ch_helicopter_minigun");
			player processchallenge("ch_helicopters");
			break;

		case "airdrop":
			player processchallenge("ch_airdrop");
			player processchallenge("ch_airdrops");
			break;

		case "airdrop_sentry_minigun":
			player processchallenge("ch_sentry");
			player processchallenge("ch_airdrops");
			break;

		case "airdrop_mega":
			player processchallenge("ch_airdrop_mega");
			player processchallenge("ch_airdrops", 4);
			break;

		case "ac130":
			player processchallenge("ch_ac130");
			break;

		case "emp":
			player processchallenge("ch_emp");
			break;

		case "predator_missile":
			player processchallenge("ch_predator_missile");
			break;

		case "nuke":
			player processchallenge("ch_nuke");
			if(level.teambased && maps\mp\gametypes\_gamescore::getwinningteam() == level.otherteam[player.team])
			{
				player processchallenge("ch_wopr");
			}
			break;
	}
}

ch_vehicle_kills(data)
{
	if(!isdefined(data.attacker) || !isplayer(data.attacker))
	{
		return;
	}

	if(!maps\mp\_utility::iskillstreakweapon(data.sweapon))
	{
		return;
	}

	player = data.attacker;
	if(!isdefined(player.pers[data.sweapon + "_streak"]))
	{
		player.pers[data.sweapon + "_streak"] = 0;
	}

	player.pers[data.sweapon + "_streak"]++;
	switch(data.sweapon)
	{
		case "cobra_player_minigun_mp":
			player processchallenge("ch_cobracommander");
			if(isdefined(player.finalkill))
			{
				player processchallenge("ch_hidef");
			}
			break;

		case "artillery_mp":
			player processchallenge("ch_carpetbomber");
			if(player.pers[data.sweapon + "_streak"] >= 5)
			{
				player processchallenge("ch_carpetbomb");
			}
	
			if(isdefined(player.finalkill))
			{
				player processchallenge("ch_finishingtouch");
			}
			break;

		case "stealth_bomb_mp":
			player processchallenge("ch_thespirit");
			if(player.pers[data.sweapon + "_streak"] >= 6)
			{
				player processchallenge("ch_redcarpet");
			}
	
			if(isdefined(player.finalkill))
			{
				player processchallenge("ch_technokiller");
			}
			break;

		case "pavelow_minigun_mp":
			player processchallenge("ch_jollygreengiant");
			if(isdefined(player.finalkill))
			{
				player processchallenge("ch_transformer");
			}
			break;

		case "sentry_minigun_mp":
			player processchallenge("ch_looknohands");
			if(isdefined(player.finalkill))
			{
				player processchallenge("ch_absentee");
			}
			break;

		case "harrier_20mm_mp":
			player processchallenge("ch_yourefired");
			if(isdefined(player.finalkill))
			{
				player processchallenge("ch_truelies");
			}
			break;

		case "ac130_25mm_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
			player processchallenge("ch_spectre");
			if(isdefined(player.finalkill))
			{
				player processchallenge("ch_deathfromabove");
			}
			break;

		case "remotemissile_projectile_mp":
			player processchallenge("ch_predator");
			if(player.pers[data.sweapon + "_streak"] >= 4)
			{
				player processchallenge("ch_reaper");
			}
	
			if(isdefined(player.finalkill))
			{
				player processchallenge("ch_dronekiller");
			}
			break;

		case "cobra_20mm_mp":
			player processchallenge("ch_choppervet");
			if(isdefined(player.finalkill))
			{
				player processchallenge("ch_og");
			}
			break;

		case "nuke_mp":
			data.victim processchallenge("ch_radiationsickness");
			break;

		default:
			break;
	}
}

ch_vehicle_killed(data)
{
	if(!isdefined(data.attacker) || !isplayer(data.attacker))
	{
		return;
	}

	player = data.attacker;
}

clearidshortly(expid)
{
	self endon("disconnect");
	self notify("clearing_expID_" + expid);
	self endon("clearing_expID_" + expid);
	wait 3;
	self.explosivekills[expid] = undefined;
}

mgkill()
{
	player = self;
	if(!isdefined(player.pers["MGStreak"]))
	{
		player.pers["MGStreak"] = 0;
		player thread endmgstreakwhenleavemg();
		if(!isdefined(player.pers["MGStreak"]))
		{
			return;
		}
	}

	player.pers["MGStreak"]++;
	if(player.pers["MGStreak"] >= 5)
	{
		player processchallenge("ch_mgmaster");
		return;
	}
}

endmgstreakwhenleavemg()
{
	self endon("disconnect");
	for(;;)
	{
		if(!isalive(self) || self usebuttonpressed())
		{
			self.pers["MGStreak"] = undefined;
			break;
		}

		wait 0.05;
	}
}

endmgstreak()
{
	self.pers["MGStreak"] = undefined;
}

killedbestenemyplayer(wasbest)
{
	if(!isdefined(self.pers["countermvp_streak"]) || !wasbest)
	{
		self.pers["countermvp_streak"] = 0;
	}

	self.pers["countermvp_streak"]++;
	if(self.pers["countermvp_streak"] == 3)
	{
		processchallenge("ch_thebiggertheyare");
	}
	else if(self.pers["countermvp_streak"] == 5)
	{
		processchallenge("ch_thehardertheyfall");
	}

	if(self.pers["countermvp_streak"] >= 10)
	{
		processchallenge("ch_countermvp");
		return;
	}
}

ishighestscoringplayer(player)
{
	if(!isdefined(player.score) || player.score < 1)
	{
		return 0;
	}

	players = level.players;
	if(level.teambased)
	{
		team = player.pers["team"];
	}
	else
	{
		team = "all";
	}

	highscore = player.score;
	for(i = 0;i < players.size;i++)
	{
		if(!isdefined(players[i].score))
		{
			continue;
		}

		if(players[i].score < 1)
		{
			continue;
		}

		if(team != "all" && players[i].pers["team"] != team)
		{
			continue;
		}

		if(players[i].score > highscore)
		{
			return 0;
		}
	}

	return 1;
}

ch_kills(data, time)
{
	data.victim playerdied();
	if(!isdefined(data.attacker) || !isplayer(data.attacker))
	{
		return;
	}

	player = data.attacker;
	time = data.time;
	if(player.pers["cur_kill_streak"] == 10)
	{
		player processchallenge("ch_fearless");
	}

	if(level.teambased)
	{
		if(level.teamcount[data.victim.pers["team"]] > 3 && player.killedplayers.size >= level.teamcount[data.victim.pers["team"]])
		{
			player processchallenge("ch_tangodown");
			maps\mp\_awards::addawardwinner("killedotherteam", player.clientid);
		}

		if(level.teamcount[data.victim.pers["team"]] > 3 && player.killedplayerscurrent.size >= level.teamcount[data.victim.pers["team"]])
		{
			player processchallenge("ch_extremecruelty");
			maps\mp\_awards::addawardwinner("killedotherteamonelife", player.clientid);
		}
	}

	if(isdefined(player.killedplayers[data.victim.guid]) && player.killedplayers[data.victim.guid] == 5)
	{
		player processchallenge("ch_rival");
	}

	if(isdefined(player.tookweaponfrom[data.sweapon]))
	{
		if(player.tookweaponfrom[data.sweapon] == data.victim && data.smeansofdeath != "MOD_MELEE")
		{
			player processchallenge("ch_cruelty");
		}
	}

	oneleftcount = 0;
	secondarycount = 0;
	longshotcount = 0;
	killslast10s = 1;
	killedplayers[data.victim.name] = data.victim.name;
	usedweapons[data.sweapon] = data.sweapon;
	uniquekills = 1;
	killstreakkills = [];
	foreach(killdata in player.killsthislife)
	{
		if(maps\mp\_utility::iscacsecondaryweapon(killdata.sweapon) && killdata.smeansofdeath != "MOD_MELEE")
		{
			secondarycount++;
		}

		if(isdefined(killdata.modifiers["longshot"]))
		{
			longshotcount++;
		}

		if(time - killdata.time < 10000)
		{
			killslast10s++;
		}

		if(maps\mp\_utility::iskillstreakweapon(killdata.sweapon))
		{
			if(!isdefined(killstreakkills[killdata.sweapon]))
			{
				killstreakkills[killdata.sweapon] = 0;
			}

			killstreakkills[killdata.sweapon]++;
			continue;
		}

		if(isdefined(level.onelefttime[player.team]) && killdata.time > level.onelefttime[player.team])
		{
			oneleftcount++;
		}

		if(isdefined(killdata.victim))
		{
			if(!isdefined(killedplayers[killdata.victim.name]) && !isdefined(usedweapons[killdata.sweapon]) && !maps\mp\_utility::iskillstreakweapon(killdata.sweapon))
			{
				uniquekills++;
			}

			killedplayers[killdata.victim.name] = killdata.victim.name;
		}

		usedweapons[killdata.sweapon] = killdata.sweapon;
	}

	foreach(killcount in killstreakkills)
	{
		if(killcount >= 10)
		{
			player processchallenge("ch_crabmeat");
		}
	}

	if(uniquekills == 3)
	{
		player processchallenge("ch_renaissance");
	}

	if(killslast10s > 3 && level.teamcount[data.victim.team] <= killslast10s)
	{
		player processchallenge("ch_omnicide");
	}

	if(maps\mp\_utility::iscacsecondaryweapon(data.sweapon) && secondarycount == 2)
	{
		player processchallenge("ch_sidekick");
	}

	if(isdefined(data.modifiers["longshot"]) && longshotcount == 2)
	{
		player processchallenge("ch_nbk");
	}

	if(isdefined(level.onelefttime[player.team]) && oneleftcount == 2)
	{
		player processchallenge("ch_enemyofthestate");
	}

	if(data.victim.score > 0)
	{
		if(level.teambased)
		{
			victimteam = data.victim.pers["team"];
			if(isdefined(victimteam) && victimteam != player.pers["team"])
			{
				if(ishighestscoringplayer(data.victim) && level.players.size >= 6)
				{
					player killedbestenemyplayer(1);
				}
				else
				{
					player killedbestenemyplayer(0);
				}
			}
		}
		else if(ishighestscoringplayer(data.victim) && level.players.size >= 4)
		{
			player killedbestenemyplayer(1);
		}
		else
		{
			player killedbestenemyplayer(0);
		}
	}

	if(isdefined(data.modifiers["avenger"]))
	{
		player processchallenge("ch_avenger");
	}

	if(isdefined(data.modifiers["buzzkill"]) && data.modifiers["buzzkill"] >= 9)
	{
		player processchallenge("ch_thedenier");
	}

	if(maps\mp\_utility::iskillstreakweapon(data.sweapon))
	{
		return;
	}

	if(isdefined(data.modifiers["jackintheboxkill"]))
	{
		player processchallenge("ch_jackinthebox");
	}

	if(isdefined(data.modifiers["clonekill"]))
	{
		player processchallenge("ch_identitytheft");
	}

	if(isdefined(data.modifiers["cooking"]))
	{
		player processchallenge("ch_no");
	}

	if(isdefined(player.finalkill))
	{
		player processchallenge("ch_theedge");
		if(isdefined(data.modifiers["revenge"]))
		{
			player processchallenge("ch_moneyshot");
		}

		if(isdefined(player.inlaststand) && player.inlaststand)
		{
			player processchallenge("ch_lastresort");
		}
	}

	if(player isatbrinkofdeath())
	{
		player.brinkofdeathkillstreak++;
		if(player.brinkofdeathkillstreak >= 3)
		{
			player processchallenge("ch_thebrink");
		}
	}

	if(data.smeansofdeath == "MOD_PISTOL_BULLET" || data.smeansofdeath == "MOD_RIFLE_BULLET")
	{
		weaponclass = maps\mp\_utility::getweaponclass(data.sweapon);
		ch_bulletdamagecommon(data, player, time, weaponclass);
		if(maps\mp\_utility::ismg(data.sweapon))
		{
			player mgkill();
		}
		else
		{
			baseweapon = maps\mp\_utility::getbaseweaponname(data.sweapon);
			if(isdefined(level.challengeinfo["ch_marksman_" + baseweapon]))
			{
				player processchallenge("ch_marksman_" + baseweapon);
			}

			if(isdefined(level.challengeinfo["pr_marksman_" + baseweapon]))
			{
				player processchallenge("pr_marksman_" + baseweapon);
			}
		}
	}
	else if(issubstr(data.smeansofdeath, "MOD_GRENADE") || issubstr(data.smeansofdeath, "MOD_EXPLOSIVE") || issubstr(data.smeansofdeath, "MOD_PROJECTILE"))
	{
		if(player maps\mp\_utility::_hasperk("specialty_explosivedamage"))
		{
			player processchallenge("ch_dangerclose_pro");
		}

		if(isstrstart(data.sweapon, "frag_grenade_short") && !isdefined(data.victim.explosiveinfo["throwbackKill"]) || !data.victim.explosiveinfo["throwbackKill"])
		{
			player processchallenge("ch_martyr");
		}

		if(isdefined(data.victim.explosiveinfo["damageTime"]) && data.victim.explosiveinfo["damageTime"] == time)
		{
			if(data.sweapon == "none")
			{
				data.sweapon = data.victim.explosiveinfo["weapon"];
			}

			expid = time + "_" + data.victim.explosiveinfo["damageId"];
			if(!isdefined(player.explosivekills[expid]))
			{
				player.explosivekills[expid] = 0;
			}

			player thread clearidshortly(expid);
			player.explosivekills[expid]++;
			baseweapon = maps\mp\_utility::getbaseweaponname(data.sweapon);
			if(baseweapon == "javelin" || baseweapon == "m79" || baseweapon == "at4" || baseweapon == "rpg")
			{
				if(player.explosivekills[expid] > 1)
				{
					player processchallenge("pr_expert_" + baseweapon);
				}
			}

			if(baseweapon == "gl")
			{
				weaponattachments = maps\mp\_utility::getweaponattachments(data.sweapon);
				player processchallenge("ch_" + weaponattachments[0] + "_gl");
				if(isdefined(level.challengeinfo["ch_marksman_" + weaponattachments[0]]))
				{
					player processchallenge("ch_marksman_" + weaponattachments[0]);
				}

				if(player maps\mp\_utility::_hasperk("specialty_bling"))
				{
					baseweaponattachments = maps\mp\_utility::getweaponattachments(data.sprimaryweapon);
					if(baseweaponattachments.size == 2 && issubstr(data.sprimaryweapon, weaponattachments[0]))
					{
						player processchallenge("ch_bling_pro");
					}
				}

				if(isdefined(level.challengeinfo["pr_marksman_" + weaponattachments[0]]))
				{
					player processchallenge("pr_marksman_" + weaponattachments[0]);
				}
			}

			if(isdefined(data.victim.explosiveinfo["stickKill"]) && data.victim.explosiveinfo["stickKill"])
			{
				if(isdefined(data.modifiers["revenge"]))
				{
					player processchallenge("ch_overdraft");
				}

				if(isdefined(player.finalkill))
				{
					player processchallenge("ch_stickman");
				}

				if(player.explosivekills[expid] > 1)
				{
					player processchallenge("ch_grouphug");
				}
			}

			if(isdefined(data.victim.explosiveinfo["stickFriendlyKill"]) && data.victim.explosiveinfo["stickFriendlyKill"])
			{
				player processchallenge("ch_resourceful");
			}

			if(!issubstr(baseweapon, "stinger"))
			{
				if(isdefined(level.challengeinfo["ch_marksman_" + baseweapon]))
				{
					player processchallenge("ch_marksman_" + baseweapon);
				}

				if(isdefined(level.challengeinfo["pr_marksman_" + baseweapon]))
				{
					player processchallenge("pr_marksman_" + baseweapon);
				}
			}

			if(isstrstart(data.sweapon, "frag_"))
			{
				if(player.explosivekills[expid] > 1)
				{
					player processchallenge("ch_multifrag");
				}

				if(isdefined(data.modifiers["revenge"]))
				{
					player processchallenge("ch_bangforbuck");
				}

				player processchallenge("ch_grenadekill");
				if(data.victim.explosiveinfo["cookedKill"])
				{
					player processchallenge("ch_masterchef");
				}

				if(data.victim.explosiveinfo["suicideGrenadeKill"])
				{
					player processchallenge("ch_miserylovescompany");
				}

				if(data.victim.explosiveinfo["throwbackKill"])
				{
					player processchallenge("ch_hotpotato");
				}
			}
			else if(isstrstart(data.sweapon, "semtex_"))
			{
				if(isdefined(data.modifiers["revenge"]))
				{
					player processchallenge("ch_timeismoney");
				}
			}
			else if(isstrstart(data.sweapon, "c4_"))
			{
				if(isdefined(data.modifiers["revenge"]))
				{
					player processchallenge("ch_iamrich");
				}

				if(player.explosivekills[expid] > 1)
				{
					player processchallenge("ch_multic4");
				}

				if(data.victim.explosiveinfo["returnToSender"])
				{
					player processchallenge("ch_returntosender");
				}

				if(data.victim.explosiveinfo["counterKill"])
				{
					player processchallenge("ch_counterc4");
				}

				if(data.victim.explosiveinfo["bulletPenetrationKill"])
				{
					player processchallenge("ch_howthe");
				}

				if(data.victim.explosiveinfo["chainKill"])
				{
					player processchallenge("ch_dominos");
				}

				player processchallenge("ch_c4shot");
				if(isdefined(player.inlaststand) && player.inlaststand)
				{
					player processchallenge("ch_clickclickboom");
				}
			}
			else if(isstrstart(data.sweapon, "claymore_"))
			{
				if(isdefined(data.modifiers["revenge"]))
				{
					player processchallenge("ch_breakbank");
				}

				player processchallenge("ch_claymoreshot");
				if(player.explosivekills[expid] > 1)
				{
					player processchallenge("ch_multiclaymore");
				}

				if(data.victim.explosiveinfo["returnToSender"])
				{
					player processchallenge("ch_returntosender");
				}

				if(data.victim.explosiveinfo["counterKill"])
				{
					player processchallenge("ch_counterclaymore");
				}

				if(data.victim.explosiveinfo["bulletPenetrationKill"])
				{
					player processchallenge("ch_howthe");
				}

				if(data.victim.explosiveinfo["chainKill"])
				{
					player processchallenge("ch_dominos");
				}
			}
			else if(data.sweapon == "explodable_barrel")
			{
			}
			else if(data.sweapon == "destructible_car")
			{
				player processchallenge("ch_carbomb");
			}
			else if(isstrstart(data.sweapon, "rpg_") || isstrstart(data.sweapon, "at4_"))
			{
				if(player.explosivekills[expid] > 1)
				{
					player processchallenge("ch_multirpg");
				}
			}
		}
	}
	else if(issubstr(data.smeansofdeath, "MOD_MELEE") && !issubstr(data.sweapon, "riotshield_mp"))
	{
		player endmgstreak();
		player processchallenge("ch_knifevet");
		player.pers["meleeKillStreak"]++;
		if(player.pers["meleeKillStreak"] == 3)
		{
			player processchallenge("ch_slasher");
		}

		if(player maps\mp\_utility::_hasperk("specialty_extendedmelee"))
		{
			player processchallenge("ch_extendedmelee_pro");
		}

		if(player maps\mp\_utility::_hasperk("specialty_heartbreaker"))
		{
			player processchallenge("ch_deadsilence_pro");
		}

		vangles = data.victim.anglesondeath[1];
		pangles = player.anglesonkill[1];
		anglediff = angleclamp180(vangles - pangles);
		if(abs(anglediff) < 30)
		{
			player processchallenge("ch_backstabber");
			if(isdefined(player.attackers))
			{
				foreach(attacker in player.attackers)
				{
					if(attacker != data.victim)
					{
						continue;
					}

					player processchallenge("ch_neverforget");
					break;
				}
			}
		}

		if(!player playerhasammo())
		{
			player processchallenge("ch_survivor");
		}

		if(isdefined(player.infected))
		{
			data.victim processchallenge("ch_infected");
		}

		if(isdefined(data.victim.plague))
		{
			player processchallenge("ch_plague");
		}

		baseweapon = maps\mp\_utility::getbaseweaponname(data.sweapon);
		weaponattachments = maps\mp\_utility::getweaponattachments(data.sweapon);
		if(isdefined(weaponattachments[0]) && weaponattachments[0] == "tactical")
		{
			if(isdefined(level.challengeinfo["ch_marksman_" + baseweapon]))
			{
				player processchallenge("ch_marksman_" + baseweapon);
			}
		}
	}
	else if(issubstr(data.smeansofdeath, "MOD_MELEE") && issubstr(data.sweapon, "riotshield_mp"))
	{
		player endmgstreak();
		player processchallenge("ch_shieldvet");
		player.pers["shieldKillStreak"]++;
		if(player.pers["shieldKillStreak"] == 3)
		{
			player processchallenge("ch_smasher");
		}

		if(isdefined(player.finalkill))
		{
			player processchallenge("ch_owned");
		}

		if(player maps\mp\_utility::_hasperk("specialty_extendedmelee"))
		{
			player processchallenge("ch_extendedmelee_pro");
		}

		vangles = data.victim.anglesondeath[1];
		pangles = player.anglesonkill[1];
		anglediff = angleclamp180(vangles - pangles);
		if(abs(anglediff) < 30)
		{
			player processchallenge("ch_backsmasher");
		}

		if(!player playerhasammo())
		{
			player processchallenge("ch_survivor");
		}
	}
	else if(issubstr(data.smeansofdeath, "MOD_IMPACT"))
	{
		if(isstrstart(data.sweapon, "frag_"))
		{
			player processchallenge("ch_thinkfast");
		}
		else if(isstrstart(data.sweapon, "concussion_"))
		{
			player processchallenge("ch_thinkfastconcussion");
		}
		else if(isstrstart(data.sweapon, "flash_"))
		{
			player processchallenge("ch_thinkfastflash");
		}
		else if(isstrstart(data.sweapon, "gl_"))
		{
			player processchallenge("ch_ouch");
		}

		if(data.sweapon == "throwingknife_mp")
		{
			if(isdefined(data.modifiers["revenge"]))
			{
				player processchallenge("ch_atm");
			}

			if(time < player.flashendtime)
			{
				player processchallenge("ch_didyouseethat");
			}

			if(isdefined(player.finalkill))
			{
				player processchallenge("ch_unbelievable");
			}

			player processchallenge("ch_carnie");
			if(isdefined(data.victim.attackerdata[player.guid].isprimary))
			{
				player processchallenge("ch_its_personal");
			}
		}

		baseweapon = maps\mp\_utility::getbaseweaponname(data.sweapon);
		if(baseweapon == "gl")
		{
			weaponattachments = maps\mp\_utility::getweaponattachments(data.sweapon);
			if(isdefined(level.challengeinfo["ch_" + weaponattachments[0] + "_" + "gl"]))
			{
				player processchallenge("ch_" + weaponattachments[0] + "_" + "gl");
			}

			if(isdefined(level.challengeinfo["ch_marksman_" + weaponattachments[0]]))
			{
				player processchallenge("ch_marksman_" + weaponattachments[0]);
			}

			if(isdefined(level.challengeinfo["pr_marksman_" + weaponattachments[0]]))
			{
				player processchallenge("pr_marksman_" + weaponattachments[0]);
			}
		}
	}
	else if(data.smeansofdeath == "MOD_HEAD_SHOT")
	{
		weaponclass = maps\mp\_utility::getweaponclass(data.sweapon);
		ch_bulletdamagecommon(data, player, time, weaponclass);
		switch(weaponclass)
		{
			case "weapon_smg":
								player processchallenge("ch_expert_smg");
								break;

			case "weapon_lmg":
								player processchallenge("ch_expert_lmg");
								break;

			case "weapon_assault":
								player processchallenge("ch_expert_assault");
								break;
		}

		if(isdefined(data.modifiers["revenge"]))
		{
			player processchallenge("ch_colorofmoney");
		}

		if(maps\mp\_utility::ismg(data.sweapon))
		{
			player mgkill();
		}
		else if(isstrstart(data.sweapon, "frag_"))
		{
			player processchallenge("ch_thinkfast");
		}
		else if(isstrstart(data.sweapon, "concussion_"))
		{
			player processchallenge("ch_thinkfastconcussion");
		}
		else if(isstrstart(data.sweapon, "flash_"))
		{
			player processchallenge("ch_thinkfastflash");
		}
		else
		{
			baseweapon = maps\mp\_utility::getbaseweaponname(data.sweapon);
			if(isdefined(level.challengeinfo["ch_expert_" + baseweapon]))
			{
				player processchallenge("ch_expert_" + baseweapon);
			}

			if(isdefined(level.challengeinfo["pr_expert_" + baseweapon]))
			{
				player processchallenge("pr_expert_" + baseweapon);
			}

			if(isdefined(level.challengeinfo["ch_marksman_" + baseweapon]))
			{
				player processchallenge("ch_marksman_" + baseweapon);
			}

			if(isdefined(level.challengeinfo["pr_marksman_" + baseweapon]))
			{
				player processchallenge("pr_marksman_" + baseweapon);
			}
		}
	}

	if(data.smeansofdeath == "MOD_PISTOL_BULLET" || data.smeansofdeath == "MOD_RIFLE_BULLET" || data.smeansofdeath == "MOD_HEAD_SHOT" && !maps\mp\_utility::iskillstreakweapon(data.sweapon))
	{
		weaponattachments = maps\mp\_utility::getweaponattachments(data.sweapon);
		baseweapon = maps\mp\_utility::getbaseweaponname(data.sweapon);
		foreach(weaponattachment in weaponattachments)
		{
			switch(weaponattachment)
			{
				case "heartbeat":
					player processchallenge("ch_" + baseweapon + "_" + weaponattachment);
					break;

				case "silencer":
					player processchallenge("ch_" + baseweapon + "_" + weaponattachment);
					break;

				case "reflex":
					if(player playerads())
					{
						player processchallenge("ch_" + baseweapon + "_" + weaponattachment);
					}
					break;

				case "acog":
					if(player playerads())
					{
						player processchallenge("ch_" + baseweapon + "_" + weaponattachment);
					}
					break;

				case "rof":
					player processchallenge("ch_" + baseweapon + "_" + weaponattachment);
					break;

				case "fmj":
					if(data.victim.idflags & level.idflags_penetration)
					{
						player processchallenge("ch_" + baseweapon + "_" + weaponattachment);
					}
					break;

				default:
					break;
			}
		}

		if(player maps\mp\_utility::_hasperk("specialty_bulletaccuracy") && !player playerads())
		{
			player processchallenge("ch_bulletaccuracy_pro");
		}

		if(distancesquared(player.origin, data.victim.origin) < 65536)
		{
			if(player maps\mp\_utility::_hasperk("specialty_heartbreaker"))
			{
				player processchallenge("ch_deadsilence_pro");
			}

			if(player maps\mp\_utility::_hasperk("specialty_localjammer"))
			{
				player processchallenge("ch_scrambler_pro");
			}
		}

		if(player maps\mp\_utility::_hasperk("specialty_fastreload"))
		{
			player processchallenge("ch_sleightofhand_pro");
		}

		if(player maps\mp\_utility::_hasperk("specialty_bling") && weaponattachments.size == 2)
		{
			player processchallenge("ch_bling_pro");
		}

		if(player maps\mp\_utility::_hasperk("specialty_bulletdamage"))
		{
			player processchallenge("ch_stoppingpower_pro");
		}

		if(player maps\mp\_utility::_hasperk("specialty_pistoldeath") && isdefined(player.inlaststand) && player.inlaststand && !level.diehardmode && !isdefined(player.infinalstand) || !player.infinalstand && !isdefined(player.inc4death) || !player.inc4death)
		{
			if(isdefined(data.modifiers["revenge"]))
			{
				player processchallenge("ch_robinhood");
			}

			player processchallenge("ch_laststand_pro");
		}
	}

	if(player maps\mp\_utility::_hasperk("specialty_onemanarmy") || isdefined(player.omaclasschanged) && player.omaclasschanged)
	{
		player processchallenge("ch_onemanarmy_pro");
	}

	if(isdefined(data.victim.isplanting) && data.victim.isplanting)
	{
		player processchallenge("ch_bombplanter");
	}

	if(isdefined(data.victim.isdefusing) && data.victim.isdefusing)
	{
		player processchallenge("ch_bombdefender");
	}

	if(isdefined(data.victim.isbombcarrier) && data.victim.isbombcarrier && !isdefined(level.dd) || !level.dd)
	{
		player processchallenge("ch_bombdown");
	}

	if(isdefined(data.victim.wasti) && data.victim.wasti)
	{
		player processchallenge("ch_tacticaldeletion");
		return;
	}
}

ch_bulletdamagecommon(data, player, time, weaponclass)
{
	if(!maps\mp\_utility::ismg(data.sweapon))
	{
		player endmgstreak();
	}

	if(maps\mp\_utility::iskillstreakweapon(data.sweapon))
	{
		return;
	}

	if(player.pers["lastBulletKillTime"] == time)
	{
		player.pers["bulletStreak"]++;
	}
	else
	{
		player.pers["bulletStreak"] = 1;
	}

	player.pers["lastBulletKillTime"] = time;
	if(!data.victimonground)
	{
		player processchallenge("ch_hardlanding");
	}

	if(!data.attackeronground)
	{
		player.pers["midairStreak"]++;
	}

	if(player.pers["midairStreak"] == 2)
	{
		player processchallenge("ch_airborne");
	}

	if(time < data.victim.flashendtime)
	{
		player processchallenge("ch_flashbangvet");
	}

	if(time < player.flashendtime)
	{
		player processchallenge("ch_blindfire");
	}

	if(time < data.victim.concussionendtime)
	{
		player processchallenge("ch_concussionvet");
	}

	if(time < player.concussionendtime)
	{
		player processchallenge("ch_slowbutsure");
	}

	if(player.pers["bulletStreak"] == 2)
	{
		if(isdefined(data.modifiers["headshot"]))
		{
			foreach(killdata in player.killsthislife)
			{
				if(killdata.time != time)
				{
					continue;
				}

				if(!isdefined(data.modifiers["headshot"]))
				{
					continue;
				}

				player processchallenge("ch_allpro");
			}
		}

		if(weaponclass == "weapon_sniper")
		{
			player processchallenge("ch_collateraldamage");
		}
	}

	if(weaponclass == "weapon_pistol")
	{
		if(isdefined(data.victim.attackerdata) && isdefined(data.victim.attackerdata[player.guid]))
		{
			if(isdefined(data.victim.attackerdata[player.guid].isprimary))
			{
				player processchallenge("ch_fastswap");
			}
		}
	}
	else if(weaponclass == "weapon_shotgun")
	{
		if(issubstr(data.sweapon, "ranger") && isdefined(player.bothbarrels))
		{
			player processchallenge("ch_bothbarrels");
			player.bothbarrels = undefined;
		}
	}

	if(data.victim.idflagstime == time)
	{
		if(data.victim.idflags & level.idflags_penetration)
		{
			player processchallenge("ch_xrayvision");
		}
	}

	if(data.attackerinlaststand && !data.attacker maps\mp\_utility::_hasperk("specialty_finalstand"))
	{
		player processchallenge("ch_laststandvet");
	}
	else if(data.attackerstance == "crouch")
	{
		player processchallenge("ch_crouchshot");
	}
	else if(data.attackerstance == "prone")
	{
		player processchallenge("ch_proneshot");
		if(weaponclass == "weapon_sniper")
		{
			player processchallenge("ch_invisible");
		}
	}

	if(weaponclass == "weapon_sniper")
	{
		if(isdefined(data.modifiers["oneshotkill"]))
		{
			player processchallenge("ch_ghillie");
		}
	}

	if(issubstr(data.sweapon, "_silencer_"))
	{
		player processchallenge("ch_stealth");
		return;
	}
}

ch_roundplayed(data)
{
	player = data.player;
	if(player.wasaliveatmatchstart)
	{
		deaths = player.pers["deaths"];
		kills = player.pers["kills"];
		kdratio = 1000000;
		if(deaths > 0)
		{
			kdratio = kills / deaths;
		}

		if(kdratio >= 5 && kills >= 5)
		{
			player processchallenge("ch_starplayer");
		}

		if(deaths == 0 && maps\mp\_utility::gettimepassed() > 300000)
		{
			player processchallenge("ch_flawless");
		}

		if(player.score > 0)
		{
			switch(level.gametype)
			{
				case "dm":
					if(data.place < 3 && level.placement["all"].size > 3)
					{
						player processchallenge("ch_victor_dm");
					}
					break;
			}

			return;
		}

		return;
	}
}

ch_roundwin(data)
{
	if(!data.winner)
	{
		return;
	}

	player = data.player;
	if(player.wasaliveatmatchstart)
	{
		switch(level.gametype)
		{
			case "war":
				if(level.hardcoremode)
				{
					player processchallenge("ch_teamplayer_hc");
					if(data.place == 0)
					{
						player processchallenge("ch_mvp_thc");
					}
				}
				else
				{
					player processchallenge("ch_teamplayer");
					if(data.place == 0)
					{
						player processchallenge("ch_mvp_tdm");
					}
				}
				break;

			case "sab":
				player processchallenge("ch_victor_sab");
				break;

			case "sd":
				player processchallenge("ch_victor_sd");
				break;

			case "koth":
			case "hc":
			case "dom":
			case "ctf":
			case "dm":
				break;

			default:
				break;
		}

		return;
	}
}

playerdamaged(einflictor, attacker, idamage, smeansofdeath, sweapon, shitloc)
{
	self endon("disconnect");
	if(isdefined(attacker))
	{
		attacker endon("disconnect");
	}

	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	data = spawnstruct();
	data.victim = self;
	data.einflictor = einflictor;
	data.attacker = attacker;
	data.idamage = idamage;
	data.smeansofdeath = smeansofdeath;
	data.sweapon = sweapon;
	data.shitloc = shitloc;
	data.victimonground = data.victim isonground();
	if(isplayer(attacker))
	{
		data.attackerinlaststand = isdefined(data.attacker.laststand);
		data.attackeronground = data.attacker isonground();
		data.attackerstance = data.attacker getstance();
	}
	else
	{
		data.attackerinlaststand = 0;
		data.attackeronground = 0;
		data.attackerstance = "stand";
	}

	domissioncallback("playerDamaged", data);
}

playerkilled(einflictor, attacker, idamage, smeansofdeath, sweapon, sprimaryweapon, shitloc, modifiers)
{
	self.anglesondeath = self getplayerangles();
	if(isdefined(attacker))
	{
		attacker.anglesonkill = attacker getplayerangles();
	}

	self endon("disconnect");
	data = spawnstruct();
	data.victim = self;
	data.einflictor = einflictor;
	data.attacker = attacker;
	data.idamage = idamage;
	data.smeansofdeath = smeansofdeath;
	data.sweapon = sweapon;
	data.sprimaryweapon = sprimaryweapon;
	data.shitloc = shitloc;
	data.time = gettime();
	data.modifiers = modifiers;
	data.victimonground = data.victim isonground();
	if(isplayer(attacker))
	{
		data.attackerinlaststand = isdefined(data.attacker.laststand);
		data.attackeronground = data.attacker isonground();
		data.attackerstance = data.attacker getstance();
	}
	else
	{
		data.attackerinlaststand = 0;
		data.attackeronground = 0;
		data.attackerstance = "stand";
	}

	waitandprocessplayerkilledcallback(data);
	if(isdefined(attacker) && maps\mp\_utility::isreallyalive(attacker))
	{
		attacker.killsthislife[attacker.killsthislife.size] = data;
	}

	data.attacker notify("playerKilledChallengesProcessed");
}

vehiclekilled(owner, vehicle, einflictor, attacker, idamage, smeansofdeath, sweapon)
{
	data = spawnstruct();
	data.vehicle = vehicle;
	data.victim = owner;
	data.einflictor = einflictor;
	data.attacker = attacker;
	data.idamage = idamage;
	data.smeansofdeath = smeansofdeath;
	data.sweapon = sweapon;
	data.time = gettime();
}

waitandprocessplayerkilledcallback(data)
{
	if(isdefined(data.attacker))
	{
		data.attacker endon("disconnect");
	}

	self.processingkilledchallenges = 1;
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	domissioncallback("playerKilled", data);
	self.processingkilledchallenges = undefined;
}

playerassist()
{
	data = spawnstruct();
	data.player = self;
	domissioncallback("playerAssist", data);
}

usehardpoint(hardpointtype)
{
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	data = spawnstruct();
	data.player = self;
	data.hardpointtype = hardpointtype;
	domissioncallback("playerHardpoint", data);
}

roundbegin()
{
	domissioncallback("roundBegin");
}

roundend(winner)
{
	data = spawnstruct();
	if(level.teambased)
	{
		team = "allies";
		for(index = 0;index < level.placement[team].size;index++)
		{
			data.player = level.placement[team][index];
			data.winner = team == winner;
			data.place = index;
			domissioncallback("roundEnd", data);
		}

		team = "axis";
		for(index = 0;index < level.placement[team].size;index++)
		{
			data.player = level.placement[team][index];
			data.winner = team == winner;
			data.place = index;
			domissioncallback("roundEnd", data);
		}

		return;
	}

	for(index = 0;index < level.placement["all"].size;index++)
	{
		data.player = level.placement["all"][index];
		data.winner = isdefined(winner) && data.player == winner;
		data.place = index;
		domissioncallback("roundEnd", data);
	}
}

domissioncallback(callback, data)
{
	if(!mayprocesschallenges())
	{
		return;
	}

	if(getdvarint("disable_challenges") > 0)
	{
		return;
	}

	if(!isdefined(level.missioncallbacks[callback]))
	{
		return;
	}

	if(isdefined(data))
	{
		for(i = 0;i < level.missioncallbacks[callback].size;i++)
		{
			thread [[ level.missioncallbacks[callback][i] ]](data);
		}

		return;
	}

	for(i = 0;i < level.missioncallbacks[callback].size;i++)
	{
		thread [[ level.missioncallbacks[callback][i] ]]();
	}
}

monitorsprintdistance()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("sprint_begin");
		self.sprintdistthissprint = 0;
		thread monitorsprinttime();
		monitorsinglesprintdistance();
		if(maps\mp\_utility::_hasperk("specialty_marathon"))
		{
			processchallenge("ch_marathon_pro", int(self.sprintdistthissprint / 12));
		}

		if(maps\mp\_utility::_hasperk("specialty_lightweight"))
		{
			processchallenge("ch_lightweight_pro", int(self.sprintdistthissprint / 12));
		}
	}
}

monitorsinglesprintdistance()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	self endon("sprint_end");
	prevpos = self.origin;
	for(;;)
	{
		wait 0.1;
		self.sprintdistthissprint = self.sprintdistthissprint + distance(self.origin, prevpos);
		prevpos = self.origin;
	}
}

monitorsprinttime()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	starttime = gettime();
	self waittill("sprint_end");
	sprinttime = int(gettime() - starttime);
	maps\mp\_utility::incplayerstat("sprinttime", sprinttime);
}

monitorfalldistance()
{
	self endon("disconnect");
	self.pers["midairStreak"] = 0;
	for(;;)
	{
		if(!isalive(self))
		{
			self waittill("spawned_player");
			continue;
		}

		if(!self isonground())
		{
			self.pers["midairStreak"] = 0;
			highestpoint = self.origin[2];
			while(!self isonground() && isalive(self))
			{
				if(self.origin[2] > highestpoint)
				{
					highestpoint = self.origin[2];
				}

				wait 0.05;
			}

			self.pers["midairStreak"] = 0;
			falldist = highestpoint - self.origin[2];
			if(falldist < 0)
			{
				falldist = 0;
			}

			if(falldist / 12 > 15 && isalive(self))
			{
				processchallenge("ch_basejump");
			}

			if(falldist / 12 > 30 && !isalive(self))
			{
				processchallenge("ch_goodbye");
			}
		}

		wait 0.05;
	}
}

lastmansd()
{
	if(!mayprocesschallenges())
	{
		return;
	}

	if(!self.wasaliveatmatchstart)
	{
		return;
	}

	if(self.teamkillsthisround > 0)
	{
		return;
	}

	processchallenge("ch_lastmanstanding");
}

monitorbombuse()
{
	self endon("disconnect");
	for(;;)
	{
		result = common_scripts\utility::waittill_any_return("bomb_planted", "bomb_defused");
		if(!isdefined(result))
		{
			continue;
		}

		if(result == "bomb_planted")
		{
			processchallenge("ch_saboteur");
			continue;
		}

		if(result == "bomb_defused")
		{
			processchallenge("ch_hero");
		}
	}
}

monitorlivetime()
{
	for(;;)
	{
		self waittill("spawned_player");
		thread survivalistchallenge();
	}
}

survivalistchallenge()
{
	self endon("death");
	self endon("disconnect");
	wait 300;
	processchallenge("ch_survivalist");
}

monitorstreaks()
{
	self endon("disconnect");
	self.pers["airstrikeStreak"] = 0;
	self.pers["meleeKillStreak"] = 0;
	self.pers["shieldKillStreak"] = 0;
	thread monitormisc();
	for(;;)
	{
		self waittill("death");
		self.pers["airstrikeStreak"] = 0;
		self.pers["meleeKillStreak"] = 0;
		self.pers["shieldKillStreak"] = 0;
	}
}

monitormisc()
{
	thread monitormiscsingle("destroyed_explosive");
	thread monitormiscsingle("begin_airstrike");
	thread monitormiscsingle("destroyed_car");
	thread monitormiscsingle("destroyed_helicopter");
	thread monitormiscsingle("used_uav");
	thread monitormiscsingle("used_counter_uav");
	thread monitormiscsingle("used_airdrop");
	thread monitormiscsingle("used_emp");
	thread monitormiscsingle("used_nuke");
	thread monitormiscsingle("crushed_enemy");
	self waittill("disconnect");
	self notify("destroyed_explosive");
	self notify("begin_airstrike");
	self notify("destroyed_car");
	self notify("destroyed_helicopter");
}

monitormiscsingle(waittillstring)
{
	for(;;)
	{
		self waittill(waittillstring);
		if(!isdefined(self))
		{
			return;
		}

		monitormisccallback(waittillstring);
	}
}

monitormisccallback(result)
{
	switch(result)
	{
		case "begin_airstrike":
			self.pers["airstrikeStreak"] = 0;
			break;

		case "destroyed_explosive":
			if(maps\mp\_utility::_hasperk("specialty_detectexplosive"))
			{
				processchallenge("ch_detectexplosives_pro");
			}
	
			processchallenge("ch_backdraft");
			break;

		case "destroyed_helicopter":
			processchallenge("ch_flyswatter");
			break;

		case "destroyed_car":
			processchallenge("ch_vandalism");
			break;

		case "crushed_enemy":
			processchallenge("ch_heads_up");
			if(isdefined(self.finalkill))
			{
				processchallenge("ch_droppincrates");
			}
			break;
	}
}

healthregenerated()
{
	if(!isalive(self))
	{
		return;
	}

	if(!mayprocesschallenges())
	{
		return;
	}

	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	thread resetbrinkofdeathkillstreakshortly();
	if(isdefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy)
	{
		self.healthregenerationstreak++;
		if(self.healthregenerationstreak >= 5)
		{
			processchallenge("ch_invincible");
			return;
		}

		return;
	}
}

resetbrinkofdeathkillstreakshortly()
{
	self endon("disconnect");
	self endon("death");
	self endon("damage");
	wait 1;
	self.brinkofdeathkillstreak = 0;
}

playerspawned()
{
	self.brinkofdeathkillstreak = 0;
	self.healthregenerationstreak = 0;
	self.pers["MGStreak"] = 0;
}

playerdied()
{
	self.brinkofdeathkillstreak = 0;
	self.healthregenerationstreak = 0;
	self.pers["MGStreak"] = 0;
}

isatbrinkofdeath()
{
	ratio = self.health / self.maxhealth;
	return ratio <= level.healthoverlaycutoff;
}

processchallenge(basename, progressinc, param_532)
{
	if(!mayprocesschallenges())
	{
		return;
	}

	if(level.players.size < 2)
	{
		return;
	}

	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(!isdefined(progressinc))
	{
		progressinc = 1;
	}

	missionstatus = getchallengestatus(basename);
	if(missionstatus == 0)
	{
		return;
	}

	if(missionstatus > level.challengeinfo[basename]["targetval"].size)
	{
		return;
	}

	if(isdefined(param_532) && param_532)
	{
		progress = progressinc;
	}
	else
	{
		progress = ch_getprogress(basename);
		progress = progress + progressinc;
	}

	if(progress >= level.challengeinfo[basename]["targetval"][missionstatus])
	{
		ch_setprogress(basename, level.challengeinfo[basename]["targetval"][missionstatus]);
		thread giverankxpafterwait(basename, missionstatus);
		missionstatus++;
		ch_setstate(basename, missionstatus);
		self.challengedata[basename] = missionstatus;
		thread maps\mp\gametypes\_hud_message::challengesplashnotify(basename);
		thread masterychallengeprocess(basename, missionstatus);
		return;
	}

	ch_setprogress(basename, progress);
}

giverankxpafterwait(basename, missionstatus)
{
	self endon("disconnect");
	wait 0.25;
	maps\mp\gametypes\_rank::giverankxp("challenge", level.challengeinfo[basename]["reward"][missionstatus]);
}

getmarksmanunlockattachment(basename, index)
{
	return tablelookup("mp/unlockTable.csv", 0, basename, 4 + index);
}

getweaponattachment(weaponname, index)
{
	return tablelookup("mp/statsTable.csv", 4, weaponname, 11 + index);
}

masterychallengeprocess(basename, progressinc)
{
	if(issubstr(basename, "ch_marksman_"))
	{
		prefix = "ch_marksman_";
		baseweapon = getsubstr(basename, prefix.size, basename.size);
	}
	else
	{
		tokens = strtok(basename, "_");
		if(tokens.size != 3)
		{
			return;
		}

		baseweapon = tokens[1];
	}

	if(tablelookup("mp/allChallengesTable.csv", 0, "ch_" + baseweapon + "_mastery", 1) == "")
	{
		return;
	}

	progress = 0;
	for(index = 0;index <= 10;index++)
	{
		attachmentname = getweaponattachment(baseweapon, index);
		if(attachmentname == "")
		{
			continue;
		}

		if(self isitemunlocked(baseweapon + " " + attachmentname))
		{
			progress++;
		}
	}

	processchallenge("ch_" + baseweapon + "_mastery", progress, 1);
}

updatechallenges()
{
	self.challengedata = [];
	if(!mayprocesschallenges())
	{
		return;
	}

	if(!self isitemunlocked("challenges"))
	{
		return 0;
	}

	foreach(challengeref, challengedata in level.challengeinfo)
	{
		self.challengedata[challengeref] = 0;
		if(!self isitemunlocked(challengeref))
		{
			continue;
		}

		if(isdefined(challengedata["requirement"]) && !self isitemunlocked(challengedata["requirement"]))
		{
			continue;
		}

		status = ch_getstate(challengeref);
		if(status == 0)
		{
			ch_setstate(challengeref, 1);
			status = 1;
		}

		self.challengedata[challengeref] = status;
	}
}

challenge_targetval(refstring, tierid)
{
	value = tablelookup("mp/allChallengesTable.csv", 0, refstring, 6 + tierid - 1 * 2);
	return int(value);
}

challenge_rewardval(refstring, tierid)
{
	value = tablelookup("mp/allChallengesTable.csv", 0, refstring, 7 + tierid - 1 * 2);
	return int(value);
}

buildchallegeinfo()
{
	level.challengeinfo = [];
	tablename = "mp/allchallengesTable.csv";
	totalrewardxp = 0;
	refstring = tablelookupbyrow(tablename, 0, 0);
	for(index = 1;refstring != "";index++)
	{
		level.challengeinfo[refstring] = [];
		level.challengeinfo[refstring]["targetval"] = [];
		level.challengeinfo[refstring]["reward"] = [];
		for(tierid = 1;tierid < 11;tierid++)
		{
			targetval = challenge_targetval(refstring, tierid);
			rewardval = challenge_rewardval(refstring, tierid);
			if(targetval == 0)
			{
				break;
			}

			level.challengeinfo[refstring]["targetval"][tierid] = targetval;
			level.challengeinfo[refstring]["reward"][tierid] = rewardval;
			totalrewardxp = totalrewardxp + rewardval;
		}

		refstring = tablelookupbyrow(tablename, index, 0);
	}

	tiertable = tablelookupbyrow("mp/challengeTable.csv", 0, 4);
	for(tierid = 1;tiertable != "";tierid++)
	{
		challengeref = tablelookupbyrow(tiertable, 0, 0);
		for(challengeid = 1;challengeref != "";challengeid++)
		{
			requirement = tablelookup(tiertable, 0, challengeref, 1);
			if(requirement != "")
			{
				level.challengeinfo[challengeref]["requirement"] = requirement;
			}

			challengeref = tablelookupbyrow(tiertable, challengeid, 0);
		}

		tiertable = tablelookupbyrow("mp/challengeTable.csv", tierid, 4);
	}
}

monitorprocesschallenge()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		if(!mayprocesschallenges())
		{
			return;
		}

		self waittill("process", challengename);
		processchallenge(challengename);
	}
}

monitorkillstreakprogress()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		self waittill("got_killstreak", streakcount);
		if(!isdefined(streakcount))
		{
			continue;
		}

		if(streakcount == 10 && self.killstreaks.size == 0)
		{
			processchallenge("ch_theloner");
			continue;
		}

		if(streakcount == 9)
		{
			if(isdefined(self.killstreaks[7]) && isdefined(self.killstreaks[8]) && isdefined(self.killstreaks[9]))
			{
				processchallenge("ch_6fears7");
			}
		}
	}
}

monitorkilledkillstreak()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		self waittill("destroyed_killstreak", weapon);
		if(maps\mp\_utility::_hasperk("specialty_coldblooded"))
		{
			processchallenge("ch_coldblooded_pro");
		}

		if(isdefined(weapon) && weapon == "stinger_mp")
		{
			processchallenge("ch_marksman_stinger");
			processchallenge("pr_marksman_stinger");
		}
	}
}

genericchallenge(challengetype, value)
{
	switch(challengetype)
	{
		case "hijacker_airdrop":
			processchallenge("ch_smoothcriminal");
			break;

		case "hijacker_airdrop_mega":
			processchallenge("ch_poolshark");
			break;

		case "wargasm":
			processchallenge("ch_wargasm");
			break;

		case "weapon_assault":
			processchallenge("ch_surgical_assault");
			break;

		case "weapon_smg":
			processchallenge("ch_surgical_smg");
			break;

		case "weapon_lmg":
			processchallenge("ch_surgical_lmg");
			break;

		case "weapon_sniper":
			processchallenge("ch_surgical_sniper");
			break;

		case "shield_damage":
			processchallenge("ch_shield_damage", value);
			break;

		case "shield_bullet_hits":
			processchallenge("ch_shield_bullet", value);
			break;

		case "shield_explosive_hits":
			processchallenge("ch_shield_explosive", value);
			break;
	}
}

playerhasammo()
{
	primaryweapons = self getweaponslistprimaries();
	foreach(primary in primaryweapons)
	{
		if(self getweaponammoclip(primary))
		{
			return 1;
		}

		altweapon = weaponaltweaponname(primary);
		if(!isdefined(altweapon) || altweapon == "none")
		{
			continue;
		}

		if(self getweaponammoclip(altweapon))
		{
			return 1;
		}
	}

	return 0;
}