/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_awards.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	initawards();
	level thread onplayerconnect();
	level thread monitormovementdistance();
	level thread monitorenemydistance();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		if(!isdefined(player.pers["stats"]))
		{
			player.pers["stats"] = [];
		}

		player.stats = player.pers["stats"];
		if(!player.stats.size)
		{
			player setplayerdata("round", "awardCount", 0);
			foreach(ref, award in level.awards)
			{
				if(isdefined(level.awards[ref].defaultvalue))
				{
					player maps\mp\_utility::initplayerstat(ref, level.awards[ref].defaultvalue);
					continue;
				}

				player maps\mp\_utility::initplayerstat(ref);
			}
		}

		player.prevpos = player.origin;
		player.previousdeaths = 0;
		player.altitudepolls = 0;
		player.totalaltitudesum = 0;
		player.usedweapons = [];
		player thread onplayerspawned();
		player thread monitorpositioncamping();
		player thread monitorclasschange();
	}
}

onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread monitorreloads();
		thread monitorshotsfired();
		thread monitorswaps();
		thread monitorexplosionssurvived();
		thread monitorshieldblocks();
		thread monitorflashhits();
		thread monitorstunhits();
		thread monitorstancetime();
	}
}

initawards()
{
	if(isdefined(level.initgametypeawards))
	{
		[[ level.initgametypeawards ]]();
	}

	initawardflag("10kills", ::isatleast, 10, "kills");
	initawardflag("1death", ::isatleast, 1, "deaths");
	initawardflag("nodeaths", ::isatmost, 0, "deaths");
	initawardflag("nokills", ::isatmost, 0, "kills");
	initmultiaward("mvp", "kills", "deaths");
	initmultiaward("highlander", "10kills", "nodeaths");
	initthresholdaward("kdratio10", ::isatleast, 10, "kdratio");
	initmultiaward("punisher", "kills", "killstreak");
	initmultiaward("overkill", "kills", "headshots");
	initderivedaward("killedotherteamonelife");
	initstataward("kdratio", 0, ::highestwins);
	initstataward("kills", 0, ::highestwins);
	initstataward("higherrankkills", 0, ::highestwins);
	initstataward("deaths", 0, ::lowestwithhalfplayedtime);
	initstataward("killstreak", 0, ::highestwins);
	initstataward("headshots", 0, ::highestwins);
	initderivedaward("finalkill");
	initderivedaward("killedotherteam");
	initstataward("closertoenemies", 0, ::highestwins);
	initstataward("throwingknifekills", 0, ::highestwins);
	initstataward("grenadekills", 0, ::highestwins);
	initstataward("helicopters", 0, ::highestwins);
	initstataward("airstrikes", 0, ::highestwins);
	initstataward("uavs", 0, ::highestwins);
	initstataward("mostmultikills", 0, ::highestwins);
	initstataward("multikill", 0, ::highestwins);
	initstataward("knifekills", 0, ::highestwins);
	initstataward("flankkills", 0, ::highestwins);
	initstataward("bulletpenkills", 0, ::highestwins);
	initstataward("laststandkills", 0, ::highestwins);
	initstataward("laststanderkills", 0, ::highestwins);
	initstataward("assists", 0, ::highestwins);
	initstataward("c4kills", 0, ::highestwins);
	initstataward("claymorekills", 0, ::highestwins);
	initstataward("fragkills", 0, ::highestwins);
	initstataward("semtexkills", 0, ::highestwins);
	initstataward("explosionssurvived", 0, ::highestwins);
	initstataward("mosttacprevented", 0, ::highestwins);
	initstataward("avengekills", 0, ::highestwins);
	initstataward("rescues", 0, ::highestwins);
	initstataward("longshots", 0, ::highestwins);
	initstataward("adskills", 0, ::highestwins);
	initstataward("hipfirekills", 0, ::highestwins);
	initstataward("revengekills", 0, ::highestwins);
	initstataward("longestlife", 0, ::highestwins);
	initstataward("throwbacks", 0, ::highestwins);
	initstataward("thumperkills", 0, ::highestwins);
	initstataward("otherweaponkills", 0, ::highestwins);
	initstataward("killedsameplayer", 0, ::highestwins, 2);
	initstataward("mostweaponsused", 0, ::highestwins, 3);
	initstataward("distancetraveled", 0, ::highestwins);
	initstataward("mostreloads", 0, ::highestwins);
	initstataward("mostswaps", 0, ::highestwins);
	initstat("flankdeaths", 0);
	initderivedaward("noflankdeaths", ::isatmostwithhalfplayedtime, 0, "flankdeaths");
	initstataward("thermalkills", 0, ::highestwins);
	initstataward("mostcamperkills", 0, ::highestwins);
	initstataward("fbhits", 0, ::highestwins);
	initstataward("stunhits", 0, ::highestwins);
	initstataward("scopedkills", 0, ::highestwins);
	initstataward("arkills", 0, ::highestwins);
	initstataward("arheadshots", 0, ::highestwins);
	initstataward("lmgkills", 0, ::highestwins);
	initstataward("lmgheadshots", 0, ::highestwins);
	initstataward("sniperkills", 0, ::highestwins);
	initstataward("sniperheadshots", 0, ::highestwins);
	initstataward("shieldblocks", 0, ::highestwins);
	initstataward("shieldkills", 0, ::highestwins);
	initstataward("smgkills", 0, ::highestwins);
	initstataward("smgheadshots", 0, ::highestwins);
	initstataward("shotgunkills", 0, ::highestwins);
	initstataward("shotgunheadshots", 0, ::highestwins);
	initstataward("pistolkills", 0, ::highestwins);
	initstataward("pistolheadshots", 0, ::highestwins);
	initstataward("rocketkills", 0, ::highestwins);
	initstataward("equipmentkills", 0, ::highestwins);
	initstataward("mostclasseschanged", 0, ::highestwins);
	initstataward("lowerrankkills", 0, ::highestwins);
	initstataward("sprinttime", 0, ::highestwins, 1);
	initstataward("crouchtime", 0, ::highestwins);
	initstataward("pronetime", 0, ::highestwins);
	initstataward("comebacks", 0, ::highestwins);
	initstataward("mostshotsfired", 0, ::highestwins);
	initstataward("timeinspot", 0, ::highestwins);
	initstataward("killcamtimewatched", 0, ::highestwins);
	initstataward("greatestavgalt", 0, ::highestwins);
	initstataward("leastavgalt", 9999999, ::lowestwins);
	if(!maps\mp\_utility::matchmakinggame())
	{
		initstataward("killcamskipped", 0, ::highestwins);
		initstataward("killsteals", 0, ::highestwins);
		if(!maps\mp\_utility::getgametypenumlives())
		{
			initstataward("deathstreak", 0, ::highestwins);
		}

		initstataward("shortestlife", 9999999, ::lowestwins);
		initstataward("suicides", 0, ::highestwins);
		initstataward("mostff", 0, ::highestwins);
		initstataward("shotgundeaths", 0, ::highestwins);
		initstataward("shielddeaths", 0, ::highestwins);
		initstataward("flankdeaths", 0, ::highestwins);
		initmultiaward("participant", "nokills", "1death");
		initmultiaward("afk", "nokills", "nodeaths");
		initderivedaward("noawards");
		return;
	}
}

initbaseaward(ref)
{
	level.awards[ref] = spawnstruct();
	level.awards[ref].winners = [];
	level.awards[ref].exclusive = 1;
}

initawardprocess(ref, process, var1, var2)
{
	if(isdefined(process))
	{
		level.awards[ref].process = process;
	}

	if(isdefined(var1))
	{
		level.awards[ref].var1 = var1;
	}

	if(isdefined(var2))
	{
		level.awards[ref].var2 = var2;
		return;
	}
}

initstat(ref, defaultvalue)
{
	initbaseaward(ref);
	level.awards[ref].defaultvalue = defaultvalue;
	level.awards[ref].type = "stat";
}

initstataward(ref, defaultvalue, process, var1, var2)
{
	initbaseaward(ref);
	initawardprocess(ref, process, var1, var2);
	level.awards[ref].defaultvalue = defaultvalue;
	level.awards[ref].type = "stat";
}

initderivedaward(ref, process, var1, var2)
{
	initbaseaward(ref);
	initawardprocess(ref, process, var1, var2);
	level.awards[ref].type = "derived";
}

initawardflag(ref, process, var1, var2)
{
	initbaseaward(ref);
	initawardprocess(ref, process, var1, var2);
	level.awards[ref].type = "flag";
}

initmultiaward(ref, award1_ref, award2_ref)
{
	initbaseaward(ref);
	level.awards[ref].award1_ref = award1_ref;
	level.awards[ref].award2_ref = award2_ref;
	level.awards[ref].type = "multi";
}

initthresholdaward(ref, process, var1, var2)
{
	initbaseaward(ref);
	initawardprocess(ref, process, var1, var2);
	level.awards[ref].type = "threshold";
}

setmatchrecordifgreater(ref)
{
	playervalue = maps\mp\_utility::getplayerstat(ref);
	playertime = maps\mp\_utility::getplayerstattime(ref);
	recordvalue = getawardrecord(ref);
	recordtime = getawardrecordtime(ref);
	if(!isdefined(recordvalue) || playervalue > recordvalue)
	{
		clearawardwinners(ref);
		addawardwinner(ref, self.clientid);
		setawardrecord(ref, playervalue, playertime);
		return;
	}

	if(playervalue == recordvalue)
	{
		if(isawardexclusive(ref))
		{
			if(!isdefined(recordtime) || playertime < recordtime)
			{
				clearawardwinners(ref);
				addawardwinner(ref, self.clientid);
				setawardrecord(ref, playervalue, playertime);
				return;
			}

			return;
		}

		addawardwinner(ref, self.clientid);
		return;
	}
}

setmatchrecordiflower(ref)
{
	playervalue = maps\mp\_utility::getplayerstat(ref);
	playertime = maps\mp\_utility::getplayerstattime(ref);
	recordvalue = getawardrecord(ref);
	recordtime = getawardrecordtime(ref);
	if(!isdefined(recordvalue) || playervalue < recordvalue)
	{
		clearawardwinners(ref);
		addawardwinner(ref, self.clientid);
		setawardrecord(ref, playervalue, playertime);
		return;
	}

	if(playervalue == recordvalue)
	{
		if(isawardexclusive(ref))
		{
			if(!isdefined(recordtime) || playertime < recordtime)
			{
				clearawardwinners(ref);
				addawardwinner(ref, self.clientid);
				setawardrecord(ref, playervalue, playertime);
				return;
			}

			return;
		}

		addawardwinner(ref, self.clientid);
		return;
	}
}

getdecodedratio(value)
{
	loval = getratioloval(value);
	hival = getratiohival(value);
	if(!loval)
	{
		return hival + 0.001;
	}

	return hival / loval;
}

setpersonalbestifgreater(ref)
{
	recordvalue = self getplayerdata("bests", ref);
	playervalue = maps\mp\_utility::getplayerstat(ref);
	if(recordvalue == 0 || playervalue > recordvalue)
	{
		playervalue = getformattedvalue(ref, playervalue);
		self setplayerdata("bests", ref, playervalue);
		return;
	}
}

setpersonalbestiflower(ref)
{
	recordvalue = self getplayerdata("bests", ref);
	playervalue = maps\mp\_utility::getplayerstat(ref);
	if(recordvalue == 0 || playervalue < recordvalue)
	{
		playervalue = getformattedvalue(ref, playervalue);
		self setplayerdata("bests", ref, playervalue);
		return;
	}
}

incplayerrecord(ref)
{
	recordvalue = self getplayerdata("awards", ref);
	self setplayerdata("awards", ref, recordvalue + 1);
}

addawardwinner(ref, clientid)
{
	foreach(winner in level.awards[ref].winners)
	{
		if(winner == clientid)
		{
			return;
		}
	}

	level.awards[ref].winners[level.awards[ref].winners.size] = clientid;
}

getawardwinners(ref)
{
	return level.awards[ref].winners;
}

clearawardwinners(ref)
{
	level.awards[ref].winners = [];
}

setawardrecord(ref, value, time)
{
	level.awards[ref].value = value;
	level.awards[ref].time = time;
}

getawardrecord(ref)
{
	return level.awards[ref].value;
}

getawardrecordtime(ref)
{
	return level.awards[ref].time;
}

assignawards()
{
	foreach(player in level.players)
	{
		kills = player maps\mp\_utility::getplayerstat("kills");
		deaths = player maps\mp\_utility::getplayerstat("deaths");
		if(deaths == 0)
		{
			deaths = 1;
		}

		player maps\mp\_utility::setplayerstat("kdratio", kills / deaths);
		if(isalive(player))
		{
			timealive = gettime() - player.spawntime;
			player maps\mp\_utility::setplayerstatifgreater("longestlife", timealive);
		}
	}

	foreach(ref, award in level.awards)
	{
		if(!isdefined(level.awards[ref].process))
		{
			continue;
		}

		process = level.awards[ref].process;
		var1 = level.awards[ref].var1;
		var2 = level.awards[ref].var2;
		if(isdefined(var1) && isdefined(var2))
		{
			[[ process ]](ref, var1, var2);
			continue;
		}

		if(isdefined(var1))
		{
			[[ process ]](ref, var1);
			continue;
		}

		[[ process ]](ref);
	}

	foreach(ref, award in level.awards)
	{
		if(!ismultiaward(ref))
		{
			continue;
		}

		award1_ref = level.awards[ref].award1_ref;
		award2_ref = level.awards[ref].award2_ref;
		award1_winners = getawardwinners(award1_ref);
		award2_winners = getawardwinners(award2_ref);
		if(!isdefined(award1_winners) || !isdefined(award2_winners))
		{
			continue;
		}

		foreach(winner1 in award1_winners)
		{
			foreach(winner2 in award2_winners)
			{
				if(winner1 == winner2)
				{
					addawardwinner(ref, winner1);
					player = maps\mp\_utility::playerforclientid(winner1);
					stat1 = player maps\mp\_utility::getplayerstat(award1_ref);
					stat2 = player maps\mp\_utility::getplayerstat(award2_ref);
					player maps\mp\_utility::setplayerstat(ref, encoderatio(stat1, stat2));
				}
			}
		}
	}

	foreach(ref, award in level.awards)
	{
		if(!isawardflag(ref))
		{
			assignaward(ref);
		}
	}

	if(!maps\mp\_utility::matchmakinggame())
	{
		foreach(player in level.players)
		{
			awardcount = player getplayerdata("round", "awardCount");
			if(awardcount == 0)
			{
				player giveaward("noawards");
			}
		}
	}

	foreach(player in level.players)
	{
		awardcount = player getplayerdata("round", "awardCount");
		for(i = 0;i < awardcount && i < 3;i++)
		{
			award = player getplayerdata("round", "awards", i, "award");
			value = player getplayerdata("round", "awards", i, "value");
		}
	}
}

assignaward(ref)
{
	winners = getawardwinners(ref);
	if(!isdefined(winners))
	{
		return;
	}

	foreach(winner in winners)
	{
		foreach(player in level.players)
		{
			if(player.clientid == winner)
			{
				player giveaward(ref);
			}
		}
	}
}

getawardtype(ref)
{
	if(isdefined(level.awards[ref].type))
	{
		return level.awards[ref].type;
	}

	return "none";
}

ismultiaward(ref)
{
	return getawardtype(ref) == "multi";
}

isstataward(ref)
{
	return getawardtype(ref) == "stat";
}

isthresholdaward(ref)
{
	return getawardtype(ref) == "threshold";
}

isawardflag(ref)
{
	return getawardtype(ref) == "flag";
}

isawardexclusive(ref)
{
	if(isdefined(level.awards[ref].exclusive))
	{
		return level.awards[ref].exclusive;
	}

	return 1;
}

hasdisplayvalue(ref)
{
	type = getawardtype(ref);
	switch(type)
	{
		case "derived":
			hasdisplayvalue = 0;
			break;

		case "multi":
		case "stat":
		default:
			hasdisplayvalue = 1;
			break;
	}

	return hasdisplayvalue;
}

giveaward(ref)
{
	awardcount = self getplayerdata("round", "awardCount");
	incplayerrecord(ref);
	if(hasdisplayvalue(ref))
	{
		if(isstataward(ref))
		{
		}

		value = maps\mp\_utility::getplayerstat(ref);
	}
	else
	{
		value = 1;
	}

	value = getformattedvalue(ref, value);
	if(awardcount < 3)
	{
		self setplayerdata("round", "awards", awardcount, "award", ref);
		self setplayerdata("round", "awards", awardcount, "value", value);
	}

	awardcount++;
	self setplayerdata("round", "awardCount", awardcount);
	if(awardcount == 1)
	{
		maps\mp\_highlights::givehighlight(ref, value);
		return;
	}
}

getformattedvalue(ref, value)
{
	awardformat = tablelookup("mp/awardTable.csv", 1, ref, 7);
	switch(awardformat)
	{
		case "float":
			value = maps\mp\_utility::limitdecimalplaces(value, 2);
			value = value * 100;
			break;

		case "multi":
		case "count":
		case "distance":
		case "ratio":
		case "time":
		case "none":
		default:
			break;
	}

	value = int(value);
	return value;
}

highestwins(ref, param_B7D)
{
	foreach(player in level.players)
	{
		if(player statvaluechanged(ref) && !isdefined(param_B7D) || player maps\mp\_utility::getplayerstat(ref) >= param_B7D)
		{
			player setmatchrecordifgreater(ref);
			if(!isawardflag(ref))
			{
				player setpersonalbestifgreater(ref);
			}
		}
	}
}

lowestwins(ref, param_B7E)
{
	foreach(player in level.players)
	{
		if(player statvaluechanged(ref) && !isdefined(param_B7E) || player maps\mp\_utility::getplayerstat(ref) <= param_B7E)
		{
			player setmatchrecordiflower(ref);
			if(!isawardflag(ref))
			{
				player setpersonalbestiflower(ref);
			}
		}
	}
}

lowestwithhalfplayedtime(ref)
{
	gamelength = maps\mp\_utility::gettimepassed() / 1000;
	halfgamelength = gamelength * 0.5;
	foreach(player in level.players)
	{
		if(player.hasspawned && player.timeplayed["total"] >= halfgamelength)
		{
			player setmatchrecordiflower(ref);
			if(!isawardflag(ref))
			{
				player setpersonalbestiflower(ref);
			}
		}
	}
}

statvaluechanged(ref)
{
	playervalue = maps\mp\_utility::getplayerstat(ref);
	defaultvalue = level.awards[ref].defaultvalue;
	if(playervalue == defaultvalue)
	{
		return 0;
	}

	return 1;
}

isatleast(ref, param_B80, param_B81)
{
	foreach(player in level.players)
	{
		playervalue = player maps\mp\_utility::getplayerstat(param_B81);
		checkvalue = playervalue;
		if(checkvalue >= param_B80)
		{
			addawardwinner(ref, player.clientid);
		}

		if(isthresholdaward(ref) || isawardflag(ref))
		{
			player maps\mp\_utility::setplayerstat(ref, playervalue);
		}
	}
}

isatmost(ref, param_B83, param_B84)
{
	foreach(player in level.players)
	{
		playervalue = player maps\mp\_utility::getplayerstat(param_B84);
		if(playervalue <= param_B83)
		{
			addawardwinner(ref, player.clientid);
		}
	}
}

isatmostwithhalfplayedtime(ref, param_B83, param_B84)
{
	gamelength = maps\mp\_utility::gettimepassed() / 1000;
	halfgamelength = gamelength * 0.5;
	foreach(player in level.players)
	{
		if(player.hasspawned && player.timeplayed["total"] >= halfgamelength)
		{
			playervalue = player maps\mp\_utility::getplayerstat(param_B84);
			if(playervalue <= param_B83)
			{
				addawardwinner(ref, player.clientid);
			}
		}
	}
}

setratio(ref, award1_ref, award2_ref)
{
	foreach(player in level.players)
	{
		playervalue1 = player maps\mp\_utility::getplayerstat(award1_ref);
		playervalue2 = player maps\mp\_utility::getplayerstat(award2_ref);
		if(playervalue2 == 0)
		{
			player maps\mp\_utility::setplayerstat(ref, playervalue1);
			continue;
		}

		ratio = playervalue1 / playervalue2;
		player maps\mp\_utility::setplayerstat(ref, ratio);
	}
}

getkillstreakawardref(streakname)
{
	switch(streakname)
	{
		case "double_uav":
		case "counter_uav":
		case "uav":
			return "uavs";

		case "super_airstrike":
		case "airstrike":
		case "harrier_airstrike":
		case "stealth_airstrike":
		case "precision_airstrike":
			return "airstrikes";

		case "helicopter_blackbox":
		case "helicopter_mk19":
		case "helicopter_flares":
		case "helicopter":
		case "helicopter_minigun":
			return "helicopters";

		default:
			return undefined;
	}
}

monitorreloads()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("reload");
		maps\mp\_utility::incplayerstat("mostreloads", 1);
	}
}

monitorshotsfired()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_fired");
		maps\mp\_utility::incplayerstat("mostshotsfired", 1);
	}
}

monitorswaps()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	lastweapon = "none";
	for(;;)
	{
		self waittill("weapon_change", weapon);
		if(lastweapon == weapon)
		{
			continue;
		}

		if(weapon == "none")
		{
			continue;
		}

		if(!maps\mp\gametypes\_weapons::isprimaryweapon(weapon))
		{
			continue;
		}

		lastweapon = weapon;
		maps\mp\_utility::incplayerstat("mostswaps", 1);
		alreadyused = 0;
		foreach(usedweapon in self.usedweapons)
		{
			if(weapon == usedweapon)
			{
				alreadyused = 1;
				break;
			}
		}

		if(!alreadyused)
		{
			self.usedweapons[self.usedweapons.size] = weapon;
			maps\mp\_utility::incplayerstat("mostweaponsused", 1);
		}
	}
}

monitormovementdistance()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		foreach(player in level.players)
		{
			if(!isalive(player))
			{
				continue;
			}

			if(player.deaths != player.previousdeaths)
			{
				player.prevpos = player.origin;
				player.previousdeaths = player.deaths;
			}

			distancetraveled = distance(player.origin, player.prevpos);
			player maps\mp\_utility::incplayerstat("distancetraveled", distancetraveled);
			player.prevpos = player.origin;
			player.altitudepolls++;
			player.totalaltitudesum = player.totalaltitudesum + player.origin[2];
			avgaltitude = player.totalaltitudesum / player.altitudepolls;
			player maps\mp\_utility::setplayerstat("leastavgalt", avgaltitude);
			player maps\mp\_utility::setplayerstat("greatestavgalt", avgaltitude);
			wait 0.05;
		}

		wait 0.05;
	}
}

monitorpositioncamping()
{
	level endon("game_ended");
	self endon("disconnect");
	self.lastcampchecked = gettime();
	self.positionarray = [];
	campthreshold = 512;
	for(;;)
	{
		if(!isalive(self))
		{
			wait 0.5;
			self.lastcampchecked = gettime();
			self.positionarray = [];
			continue;
		}

		self.positionarray[self.positionarray.size] = self.origin;
		if(gettime() - self.lastcampchecked >= 15000)
		{
			if(distance(self.positionarray[0], self.origin) < campthreshold && distance(self.positionarray[1], self.positionarray[0]) < campthreshold)
			{
				timecamping = gettime() - self.lastcampchecked;
				maps\mp\_utility::incplayerstat("timeinspot", timecamping);
			}

			self.positionarray = [];
			self.lastcampchecked = gettime();
		}

		wait 5;
	}
}

encoderatio(param_B91, param_B92)
{
	return param_B91 + param_B92 << 16;
}

getratiohival(value)
{
	return value & -1;
}

getratioloval(value)
{
	return value >> 16;
}

monitorenemydistance()
{
	level endon("game_ended");
	self endon("disconnect");
	while(level.players.size < 3)
	{
		wait 1;
	}

	for(;;)
	{
		foreach(player in level.players)
		{
			if(!isdefined(player))
			{
				continue;
			}

			if(player.team == "spectator")
			{
				continue;
			}

			if(!isalive(player))
			{
				continue;
			}

			sortedplayersbydistance = sortbydistance(level.players, player.origin);
			if(!sortedplayersbydistance.size)
			{
				wait 0.05;
				continue;
			}

			if(sortedplayersbydistance.size < 2)
			{
				wait 0.05;
				continue;
			}

			if(sortedplayersbydistance[1].team != player.team)
			{
				player maps\mp\_utility::incplayerstat("closertoenemies", 0.05);
			}

			wait 0.05;
		}

		wait 0.05;
	}
}

monitorclasschange()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned");
		if(self.team == "spectator")
		{
			continue;
		}

		if(isdefined(self.lastclass) && self.lastclass != "" && self.lastclass != self.class)
		{
			maps\mp\_utility::incplayerstat("mostclasseschanged", 1);
		}

		self.lastclass = self.class;
	}
}

monitorexplosionssurvived()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("survived_explosion");
		maps\mp\_utility::incplayerstat("explosionssurvived", 1);
		wait 0.05;
	}
}

monitorshieldblocks()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("shield_blocked");
		maps\mp\_utility::incplayerstat("shieldblocks", 1);
		wait 0.05;
	}
}

monitorflashhits()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("flash_hit");
		maps\mp\_utility::incplayerstat("fbhits", 1);
		wait 0.05;
	}
}

monitorstunhits()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("stun_hit");
		maps\mp\_utility::incplayerstat("stunhits", 1);
		wait 0.05;
	}
}

monitorstancetime()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		if(self getstance() == "crouch")
		{
			maps\mp\_utility::incplayerstat("crouchtime", 500);
		}
		else if(self getstance() == "prone")
		{
			maps\mp\_utility::incplayerstat("pronetime", 500);
		}

		wait 0.5;
	}
}