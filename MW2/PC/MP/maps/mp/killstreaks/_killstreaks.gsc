/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_killstreaks.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	precachestring(&"MP_KILLSTREAK_N");
	precachestring(&"MP_NUKE_ALREADY_INBOUND");
	precachestring(&"MP_UNAVILABLE_IN_LASTSTAND");
	precachestring(&"MP_UNAVAILABLE_WHEN_EMP");
	precachestring(&"MP_UNAVAILABLE_USING_TURRET");
	precachestring(&"MP_UNAVAILABLE_WHEN_INCAP");
	precachestring(&"MP_HELI_IN_QUEUE");
	initkillstreakdata();
	level.killstreakfuncs = [];
	level.killstreaksetupfuncs = [];
	level.killstreakweapons = [];
	level.killstreakmod = 0;
	thread maps\mp\killstreaks\_ac130::init();
	thread maps\mp\killstreaks\_remotemissile::init();
	thread maps\mp\killstreaks\_uav::init();
	thread maps\mp\killstreaks\_airstrike::init();
	thread maps\mp\killstreaks\_airdrop::init();
	thread maps\mp\killstreaks\_helicopter::init();
	thread maps\mp\killstreaks\_autosentry::init();
	thread maps\mp\killstreaks\_tank::init();
	thread maps\mp\killstreaks\_emp::init();
	thread maps\mp\killstreaks\_nuke::init();
	level.killstreakrounddelay = maps\mp\_utility::getintproperty("scr_game_killstreakdelay", 8);
	level thread onplayerconnect();
}

initkillstreakdata()
{
	i = 1;
	for(;;)
	{
		retval = tablelookup("mp/killstreakTable.csv", 0, i, 1);
		if(!isdefined(retval) || retval == "")
		{
			break;
		}

		streakref = tablelookup("mp/killstreakTable.csv", 0, i, 1);
		streakusehint = tablelookupistring("mp/killstreakTable.csv", 0, i, 6);
		precachestring(streakusehint);
		streakearndialog = tablelookup("mp/killstreakTable.csv", 0, i, 8);
		game["dialog"][streakref] = streakearndialog;
		streakalliesusedialog = tablelookup("mp/killstreakTable.csv", 0, i, 9);
		game["dialog"]["allies_friendly_" + streakref + "_inbound"] = "use_" + streakalliesusedialog;
		game["dialog"]["allies_enemy_" + streakref + "_inbound"] = "enemy_" + streakalliesusedialog;
		streakaxisusedialog = tablelookup("mp/killstreakTable.csv", 0, i, 10);
		game["dialog"]["axis_friendly_" + streakref + "_inbound"] = "use_" + streakaxisusedialog;
		game["dialog"]["axis_enemy_" + streakref + "_inbound"] = "enemy_" + streakaxisusedialog;
		streakweapon = tablelookup("mp/killstreakTable.csv", 0, i, 12);
		precacheitem(streakweapon);
		streakpoints = int(tablelookup("mp/killstreakTable.csv", 0, i, 13));
		maps\mp\gametypes\_rank::registerscoreinfo("killstreak_" + streakref, streakpoints);
		streakshader = tablelookup("mp/killstreakTable.csv", 0, i, 14);
		precacheshader(streakshader);
		streakshader = tablelookup("mp/killstreakTable.csv", 0, i, 15);
		if(streakshader != "")
		{
			precacheshader(streakshader);
		}

		i++;
	}
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		if(!isdefined(player.pers["killstreaks"]))
		{
			player.pers["killstreaks"] = [];
		}

		if(!isdefined(player.pers["kID"]))
		{
			player.pers["kID"] = 10;
		}

		if(!isdefined(player.pers["kIDs_valid"]))
		{
			player.pers["kIDs_valid"] = [];
		}

		player.lifeid = 0;
		if(isdefined(player.pers["deaths"]))
		{
			player.lifeid = player.pers["deaths"];
		}

		player visionsetmissilecamforplayer(game["thermal_vision"]);
		player thread onplayerspawned();
		player thread onplayerchangekit();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread killstreakusewaiter();
		thread waitforchangeteam();
		giveownedkillstreakitem(1);
	}
}

onplayerchangekit()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("changed_kit");
		giveownedkillstreakitem();
	}
}

waitforchangeteam()
{
	self endon("disconnect");
	self notify("waitForChangeTeam");
	self endon("waitForChangeTeam");
	for(;;)
	{
		self waittill("joined_team");
		clearkillstreaks();
	}
}

isridekillstreak(streakname)
{
	switch(streakname)
	{
		case "helicopter_mk19":
		case "predator_missile":
		case "helicopter_minigun":
		case "ac130":
			return 1;

		default:
			return 0;
	}
}

iscarrykillstreak(streakname)
{
	switch(streakname)
	{
		case "sentry_gl":
		case "sentry":
			return 1;

		default:
			return 0;
	}
}

deadlykillstreak(streakname)
{
	switch(streakname)
	{
		case "harrier_airstrike":
		case "stealth_airstrike":
		case "precision_airstrike":
		case "predator_missile":
		case "ac130":
			return 1;
	}

	return 0;
}

killstreakusepressed()
{
	streakname = self.pers["killstreaks"][0].streakname;
	lifeid = self.pers["killstreaks"][0].lifeid;
	isearned = self.pers["killstreaks"][0].earned;
	awardxp = self.pers["killstreaks"][0].awardxp;
	kid = self.pers["killstreaks"][0].kid;
	if(!self isonground() && isridekillstreak(streakname) || iscarrykillstreak(streakname))
	{
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(isdefined(self.selectinglocation))
	{
		return 0;
	}

	if(deadlykillstreak(streakname) && level.killstreakrounddelay && maps\mp\_utility::getgametypenumlives())
	{
		if(level.graceperiod - level.ingraceperiod < level.killstreakrounddelay)
		{
			self iprintlnbold(&"MP_UNAVAILABLE_FOR_N", level.killstreakrounddelay - level.graceperiod - level.ingraceperiod);
			return 0;
		}
	}

	if((level.teambased && level.teamemped[self.team]) || !level.teambased && isdefined(level.empplayer) && level.empplayer != self)
	{
		self iprintlnbold(&"MP_UNAVAILABLE_WHEN_EMP");
		return 0;
	}

	if(self isusingturret() && isridekillstreak(streakname) || iscarrykillstreak(streakname))
	{
		self iprintlnbold(&"MP_UNAVAILABLE_USING_TURRET");
		return 0;
	}

	if(isdefined(self.laststand) && isridekillstreak(streakname))
	{
		self iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
		return 0;
	}

	if(!common_scripts\utility::isweaponenabled())
	{
		return 0;
	}

	if(streakname == "airdrop" || streakname == "airdrop_sentry_minigun" || streakname == "airdrop_mega")
	{
		if(!self [[ level.killstreakfuncs[streakname] ]](lifeid, kid))
		{
			return 0;
		}
	}
	else if(!self [[ level.killstreakfuncs[streakname] ]](lifeid))
	{
		return 0;
	}

	usedkillstreak(streakname, awardxp);
	shufflekillstreaksfilo(streakname, kid);
	giveownedkillstreakitem();
	return 1;
}

shufflekillstreaksfilo(streakname, kid)
{
	maps\mp\_utility::_setactionslot(4, "");
	arraysize = self.pers["killstreaks"].size;
	streakindex = -1;
	for(i = 0;i < arraysize;i++)
	{
		if(self.pers["killstreaks"][i].streakname != streakname)
		{
			continue;
		}

		if(isdefined(kid) && self.pers["killstreaks"][i].kid != kid)
		{
			continue;
		}

		streakindex = i;
		break;
	}

	self.pers["killstreaks"][streakindex] = undefined;
	for(i = streakindex + 1;i < arraysize;i++)
	{
		if(i == arraysize - 1)
		{
			self.pers["killstreaks"][i - 1] = self.pers["killstreaks"][i];
			self.pers["killstreaks"][i] = undefined;
			continue;
		}

		self.pers["killstreaks"][i - 1] = self.pers["killstreaks"][i];
	}
}

usedkillstreak(streakname, awardxp)
{
	self playlocalsound("weap_c4detpack_trigger_plr");
	if(awardxp)
	{
		self thread [[ level.onxpevent ]]("killstreak_" + streakname);
	}

	thread maps\mp\gametypes\_missions::usehardpoint(streakname);
	awardref = maps\mp\_awards::getkillstreakawardref(streakname);
	if(isdefined(awardref))
	{
		thread maps\mp\_utility::incplayerstat(awardref, 1);
	}

	team = self.team;
	if(level.teambased)
	{
		thread maps\mp\_utility::leaderdialog(team + "_friendly_" + streakname + "_inbound", team);
		if(getkillstreakinformenemy(streakname))
		{
			thread maps\mp\_utility::leaderdialog(team + "_enemy_" + streakname + "_inbound", level.otherteam[team]);
			return;
		}

		return;
	}

	thread maps\mp\_utility::leaderdialogonplayer(team + "_friendly_" + streakname + "_inbound");
	if(getkillstreakinformenemy(streakname))
	{
		excludelist[0] = self;
		thread maps\mp\_utility::leaderdialog(team + "_enemy_" + streakname + "_inbound", undefined, undefined, excludelist);
		return;
	}
}

clearkillstreaks()
{
	foreach(index, streakstruct in self.pers["killstreaks"])
	{
		self.pers["killstreaks"][index] = undefined;
	}
}

getfirstprimaryweapon()
{
	weaponslist = self getweaponslistprimaries();
	if(weaponslist[0] == "onemanarmy_mp")
	{
		return weaponslist[1];
	}

	return weaponslist[0];
}

killstreakusewaiter()
{
	self endon("disconnect");
	self endon("finish_death");
	level endon("game_ended");
	self.lastkillstreak = 0;
	if(!isdefined(self.pers["lastEarnedStreak"]))
	{
		self.pers["lastEarnedStreak"] = undefined;
	}

	thread finishdeathwaiter();
	for(;;)
	{
		self waittill("weapon_change", newweapon);
		if(!isalive(self))
		{
			continue;
		}

		if(!isdefined(self.pers["killstreaks"][0]))
		{
			continue;
		}

		if(newweapon != getkillstreakweapon(self.pers["killstreaks"][0].streakname))
		{
			continue;
		}

		waittillframeend;
		streakname = self.pers["killstreaks"][0].streakname;
		result = killstreakusepressed();
		if(!isridekillstreak(streakname) || !result)
		{
			if(!self hasweapon(common_scripts\utility::getlastweapon()))
			{
				self switchtoweapon(getfirstprimaryweapon());
			}
			else
			{
				self switchtoweapon(common_scripts\utility::getlastweapon());
			}
		}

		if(self getcurrentweapon() == "none")
		{
			while(self getcurrentweapon() == "none")
			{
				wait 0.05;
			}

			waittillframeend;
		}
	}
}

finishdeathwaiter()
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	wait 0.05;
	self notify("finish_death");
	self.pers["lastEarnedStreak"] = undefined;
}

checkkillstreakreward(streakcount)
{
	self notify("got_killstreak", streakcount);
	maxval = 0;
	killstreaks = [];
	foreach(streakval, streakname in self.killstreaks)
	{
		killstreaks[streakname] = streakval;
		if(streakval > maxval)
		{
			maxval = streakval;
		}
	}

	foreach(streakval, streakname in self.killstreaks)
	{
		actualval = streakval + level.killstreakmod;
		if(actualval > streakcount)
		{
			break;
		}

		if(isdefined(self.pers["lastEarnedStreak"]) && killstreaks[streakname] <= killstreaks[self.pers["lastEarnedStreak"]])
		{
			continue;
		}

		if(issubstr(streakname, "-rollover"))
		{
			continue;
		}
		else
		{
			usestreakname = streakname;
		}

		if(trygivekillstreak(usestreakname, int(max(actualval, streakcount))))
		{
			thread killstreakearned(usestreakname);
			self.pers["lastEarnedStreak"] = streakname;
		}
	}
}

killstreakearned(streakname)
{
	if(self getplayerdata("killstreaks", 0) == streakname)
	{
		self.firstkillstreakearned = gettime();
		return;
	}

	if(self getplayerdata("killstreaks", 2) == streakname && isdefined(self.firstkillstreakearned))
	{
		if(gettime() - self.firstkillstreakearned < 20000)
		{
			thread maps\mp\gametypes\_missions::genericchallenge("wargasm");
			return;
		}

		return;
	}
}

rewardnotify(streakname, streakval)
{
	self endon("disconnect");
	maps\mp\gametypes\_hud_message::killstreaksplashnotify(streakname, streakval);
}

trygivekillstreak(streakname, streakval)
{
	level notify("gave_killstreak", streakname);
	if(!level.gameended)
	{
		thread rewardnotify(streakname, streakval);
	}

	givekillstreak(streakname, streakval, 1);
	return 1;
}

givekillstreak(streakname, isearned, awardxp, owner)
{
	self endon("disconnect");
	weapon = getkillstreakweapon(streakname);
	givekillstreakweapon(weapon);
	for(i = self.pers["killstreaks"].size;i >= 0;i--)
	{
		self.pers["killstreaks"][i + 1] = self.pers["killstreaks"][i];
	}

	self.pers["killstreaks"][0] = spawnstruct();
	self.pers["killstreaks"][0].streakname = streakname;
	self.pers["killstreaks"][0].earned = isdefined(isearned) && isearned;
	self.pers["killstreaks"][0].awardxp = isdefined(awardxp) && awardxp;
	self.pers["killstreaks"][0].owner = owner;
	self.pers["killstreaks"][0].kid = self.pers["kID"];
	self.pers["kIDs_valid"][self.pers["kID"]] = 1;
	self.pers["kID"]++;
	if(!self.pers["killstreaks"][0].earned)
	{
		self.pers["killstreaks"][0].lifeid = -1;
	}
	else
	{
		self.pers["killstreaks"][0].lifeid = self.pers["deaths"];
	}

	if(isdefined(level.killstreaksetupfuncs[streakname]))
	{
		self [[ level.killstreaksetupfuncs[streakname] ]]();
	}

	if(isdefined(isearned) && isearned && isdefined(awardxp) && awardxp)
	{
		self notify("received_earned_killstreak");
		return;
	}
}

givekillstreakweapon(weapon)
{
	weaponlist = self getweaponslistitems();
	foreach(item in weaponlist)
	{
		if(!issubstr(item, "killstreak"))
		{
			continue;
		}

		if(self getcurrentweapon() == item)
		{
			continue;
		}

		self takeweapon(item);
	}

	maps\mp\_utility::_giveweapon(weapon, 0);
	maps\mp\_utility::_setactionslot(4, "weapon", weapon);
}

getstreakcost(streakname)
{
	return int(tablelookup("mp/killstreakTable.csv", 1, streakname, 4));
}

getkillstreakhint(streakname)
{
	return tablelookupistring("mp/killstreakTable.csv", 1, streakname, 6);
}

getkillstreakinformenemy(streakname)
{
	return int(tablelookup("mp/killstreakTable.csv", 1, streakname, 11));
}

getkillstreaksound(streakname)
{
	return tablelookup("mp/killstreakTable.csv", 1, streakname, 7);
}

getkillstreakdialog(streakname)
{
	return tablelookup("mp/killstreakTable.csv", 1, streakname, 8);
}

getkillstreakweapon(streakname)
{
	return tablelookup("mp/killstreakTable.csv", 1, streakname, 12);
}

getkillstreakicon(streakname)
{
	return tablelookup("mp/killstreakTable.csv", 1, streakname, 14);
}

getkillstreakcrateicon(streakname)
{
	return tablelookup("mp/killstreakTable.csv", 1, streakname, 15);
}

giveownedkillstreakitem(skipdialog)
{
	if(!isdefined(self.pers["killstreaks"][0]))
	{
		return;
	}

	streakname = self.pers["killstreaks"][0].streakname;
	weapon = getkillstreakweapon(streakname);
	givekillstreakweapon(weapon);
	if(!isdefined(skipdialog) && !level.ingraceperiod)
	{
		maps\mp\_utility::leaderdialogonplayer(streakname, "killstreak_earned");
		return;
	}
}

initridekillstreak()
{
	common_scripts\utility::_disableusability();
	result = initridekillstreak_internal();
	if(isdefined(self))
	{
		common_scripts\utility::_enableusability();
	}

	return result;
}

initridekillstreak_internal()
{
	laptopwait = common_scripts\utility::waittill_any_timeout(1, "disconnect", "death", "weapon_switch_started");
	if(laptopwait == "weapon_switch_started")
	{
		return "fail";
	}

	if(!isalive(self))
	{
		return "fail";
	}

	if(laptopwait == "disconnect" || laptopwait == "death")
	{
		if(laptopwait == "disconnect")
		{
			return "disconnect";
		}

		if(self.team == "spectator")
		{
			return "fail";
		}

		return "success";
	}

	if(maps\mp\_utility::isemped() || maps\mp\_utility::isnuked())
	{
		return "fail";
	}

	self visionsetnakedforplayer("black_bw", 0.75);
	blackoutwait = common_scripts\utility::waittill_any_timeout(0.8, "disconnect", "death");
	if(blackoutwait != "disconnect")
	{
		thread clearrideintro(1);
		if(self.team == "spectator")
		{
			return "fail";
		}
	}

	if(!isalive(self))
	{
		return "fail";
	}

	if(maps\mp\_utility::isemped() || maps\mp\_utility::isnuked())
	{
		return "fail";
	}

	if(blackoutwait == "disconnect")
	{
		return "disconnect";
	}

	return "success";
}

clearrideintro(delay)
{
	self endon("disconnect");
	if(isdefined(delay))
	{
		wait delay;
	}

	if(!isdefined(level.nukevisioninprogress))
	{
		self visionsetnakedforplayer(getdvar("mapname"), 0);
		return;
	}
}