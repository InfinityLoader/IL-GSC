/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_misions.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 84
 * Decompile Time: 1453 ms
 * Timestamp: 10/27/2023 2:41:50 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachestring(&"MP_CHALLENGE_COMPLETED");
	if(!mayprocesschallenges())
	{
		return;
	}

	level.missioncallbacks = [];
	registermissioncallback("playerKilled",::ch_kills);
	registermissioncallback("playerKilled",::ch_vehicle_kills);
	registermissioncallback("playerHardpoint",::ch_hardpoints);
	registermissioncallback("playerAssist",::ch_assists);
	registermissioncallback("roundEnd",::ch_roundwin);
	registermissioncallback("roundEnd",::ch_roundplayed);
	registermissioncallback("vehicleKilled",::ch_vehicle_killed);
	level thread onplayerconnect();
}

//Function Number: 2
mayprocesschallenges()
{
	return level.rankedmatch;
}

//Function Number: 3
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(isbot(var_00))
		{
			continue;
		}

		if(!isdefined(var_00.pers["postGameChallenges"]))
		{
			var_00.pers["postGameChallenges"] = 0;
		}

		var_00 thread onplayerspawned();
		var_00 thread initmissiondata();
		var_00 thread monitorbombuse();
		var_00 thread monitorfalldistance();
		var_00 thread monitorlivetime();
		var_00 thread monitorstreaks();
		var_00 thread monitorscavengerpickup();
		var_00 thread monitorprocesschallenge();
		var_00 thread monitorkillstreakprogress();
		var_00 thread monitoradstime();
		var_00 thread monitorpronetime();
		var_00 thread monitorweaponswap();
		var_00 thread monitorflashbang();
		var_00 thread monitorconcussion();
		var_00 notifyonplayercommand("hold_breath","+breath_sprint");
		var_00 notifyonplayercommand("hold_breath","+melee_breath");
		var_00 notifyonplayercommand("release_breath","-breath_sprint");
		var_00 notifyonplayercommand("release_breath","-melee_breath");
		var_00 thread monitorholdbreath();
		var_00 notifyonplayercommand("jumped","+goStand");
		var_00 thread monitormantle();
	}
}

//Function Number: 4
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread onplayerdeath();
		thread monitorsprintdistance();
	}
}

//Function Number: 5
onplayerdeath()
{
	self endon("disconnect");
	self waittill("death");
	if(isdefined(self.hasscavengedammothislife))
	{
		self.hasscavengedammothislife = 0;
	}
}

//Function Number: 6
monitorscavengerpickup()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("scavenger_pickup");
		if(self isitemunlocked("specialty_scavenger") && maps\mp\_utility::_hasperk("specialty_scavenger") && !maps\mp\_utility::isjuggernaut())
		{
			self.hasscavengedammothislife = 1;
		}

		wait(0.05);
	}
}

//Function Number: 7
initmissiondata()
{
	var_00 = getarraykeys(level.killstreakfuncs);
	foreach(var_02 in var_00)
	{
		self.pers[var_02] = 0;
	}

	self.pers["lastBulletKillTime"] = 0;
	self.pers["bulletStreak"] = 0;
	self.explosiveinfo = [];
}

//Function Number: 8
registermissioncallback(param_00,param_01)
{
	if(!isdefined(level.missioncallbacks[param_00]))
	{
		level.missioncallbacks[param_00] = [];
	}

	level.missioncallbacks[param_00][level.missioncallbacks[param_00].size] = param_01;
}

//Function Number: 9
getchallengestatus(param_00)
{
	if(isdefined(self.challengedata[param_00]))
	{
		return self.challengedata[param_00];
	}

	return 0;
}

//Function Number: 10
ch_assists(param_00)
{
	var_01 = param_00.player;
	var_01 processchallenge("ch_assists");
}

//Function Number: 11
ch_streak_kill(param_00)
{
}

//Function Number: 12
ch_hardpoints(param_00)
{
	if(isbot(param_00.player))
	{
		return;
	}

	var_01 = param_00.player;
	var_01.pers[param_00.hardpointtype]++;
	switch(param_00.hardpointtype)
	{
		case "radar_mp":
			break;

		case "airstrike_mp":
			break;

		case "helicopter_mp":
			break;
	}
}

//Function Number: 13
ch_vehicle_kills(param_00)
{
	if(!isdefined(param_00.attacker) || !isplayer(param_00.attacker))
	{
		return;
	}

	if(!maps\mp\_utility::iskillstreakweapon(param_00.sweapon))
	{
		return;
	}

	var_01 = param_00.attacker;
	if(isdefined(param_00.einflictor) && isdefined(level.chopper) && param_00.einflictor == level.chopper)
	{
		var_01 processchallenge("ch_choppervet");
	}

	if(!isdefined(var_01.pers[param_00.sweapon + "_streak"]) || isdefined(var_01.pers[param_00.sweapon + "_streakTime"]) && gettime() - var_01.pers[param_00.sweapon + "_streakTime"] > 7000)
	{
		var_01.pers[param_00.sweapon + "_streak"] = 0;
		var_01.pers[param_00.sweapon + "_streakTime"] = gettime();
	}

	var_01.pers[param_00.sweapon + "_streak"]++;
	switch(param_00.sweapon)
	{
		case "artillery_mp":
			break;

		default:
			break;
	}
}

//Function Number: 14
ch_vehicle_killed(param_00)
{
	if(!isdefined(param_00.attacker) || !isplayer(param_00.attacker))
	{
		return;
	}

	var_01 = param_00.attacker;
	var_02 = maps\mp\_utility::getbaseweaponname(param_00.sweapon);
	if(maps\mp\_utility::islootweapon(var_02))
	{
		var_02 = maps\mp\gametypes\_class::getbasefromlootversion(var_02);
	}

	var_03 = get_challenge_weapon_class(param_00.sweapon,var_02);
	if(var_03 == "weapon_launcher")
	{
		var_01 processchallenge("ch_launcher_kill");
	}
}

//Function Number: 15
clearidshortly(param_00)
{
	self endon("disconnect");
	self notify("clearing_expID_" + param_00);
	self endon("clearing_expID_" + param_00);
	wait(3);
	self.explosivekills[param_00] = undefined;
}

//Function Number: 16
mgkill()
{
	var_00 = self;
	if(!isdefined(var_00.pers["MGStreak"]))
	{
		var_00.pers["MGStreak"] = 0;
		var_00 thread endmgstreakwhenleavemg();
		if(!isdefined(var_00.pers["MGStreak"]))
		{
			return;
		}
	}

	var_00.pers["MGStreak"]++;
	if(var_00.pers["MGStreak"] >= 5)
	{
		var_00 processchallenge("ch_mgmaster");
	}
}

//Function Number: 17
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

		wait(0.05);
	}
}

//Function Number: 18
endmgstreak()
{
	self.pers["MGStreak"] = undefined;
}

//Function Number: 19
killedbestenemyplayer(param_00)
{
	if(!isdefined(self.pers["countermvp_streak"]) || !param_00)
	{
		self.pers["countermvp_streak"] = 0;
	}

	self.pers["countermvp_streak"]++;
	if(self.pers["countermvp_streak"] >= 10)
	{
		self.pers["countermvp_streak"] = 0;
		processchallenge("ch_countermvp");
	}
}

//Function Number: 20
ishighestscoringplayer(param_00)
{
	if(!isdefined(param_00.score) || param_00.score < 1)
	{
		return 0;
	}

	var_01 = level.players;
	if(level.teambased)
	{
		var_02 = param_00.pers["team"];
	}
	else
	{
		var_02 = "all";
	}

	var_03 = param_00.score;
	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		if(!isdefined(var_01[var_04].score))
		{
			continue;
		}

		if(var_01[var_04].score < 1)
		{
			continue;
		}

		if(var_02 != "all" && var_01[var_04].pers["team"] != var_02)
		{
			continue;
		}

		if(var_01[var_04].score > var_03)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 21
ch_kills(param_00)
{
	param_00.victim playerdied();
	if(!isdefined(param_00.attacker) || !isplayer(param_00.attacker))
	{
		return;
	}
	else
	{
		var_01 = param_00.attacker;
	}

	if(isbot(var_01))
	{
		return;
	}

	var_02 = 0;
	var_03 = 0;
	var_04 = 1;
	var_05[param_00.victim.name] = param_00.victim.name;
	var_06[param_00.sweapon] = param_00.sweapon;
	var_07 = 1;
	var_08 = [];
	var_09 = param_00.smeansofdeath;
	var_0A = param_00.time;
	var_0B = 0;
	if(isdefined(var_01.pickedupweaponfrom[param_00.sweapon]) && !maps\mp\_utility::ismeleemod(var_09))
	{
		var_0B++;
	}

	var_0C = maps\mp\_utility::iskillstreakweapon(param_00.sweapon);
	var_0D = maps\mp\_utility::isenvironmentweapon(param_00.sweapon);
	var_0E = 0;
	if(var_09 == "MOD_HEAD_SHOT")
	{
		var_0E = 1;
	}

	var_0F = 0;
	var_10 = 0;
	if(isdefined(param_00.modifiers["longshot"]))
	{
		var_0F = 1;
		var_10++;
	}

	var_11 = param_00.was_ads;
	var_12 = 0;
	if(var_01.recentkillcount == 2)
	{
		var_12 = 1;
	}

	var_13 = 0;
	if(var_01.recentkillcount == 3)
	{
		var_13 = 1;
	}

	var_14 = "";
	if(isdefined(param_00.attackerstance))
	{
		var_14 = param_00.attackerstance;
	}

	var_15 = 0;
	var_16 = 0;
	var_17 = 0;
	var_18 = 0;
	var_19 = 0;
	var_1A = 0;
	switch(var_01.killsthislife.size + 1)
	{
		case 5:
			break;

		case 10:
			break;

		case 15:
			break;

		case 20:
			break;

		case 25:
			break;

		case 30:
			break;

		default:
			break;
	}
}

//Function Number: 22
get_challenge_weapon_class(param_00,param_01)
{
	var_02 = maps\mp\_utility::getweaponclass(param_00);
	if(!isdefined(param_01))
	{
		param_01 = maps\mp\_utility::getbaseweaponname(param_00);
		if(maps\mp\_utility::islootweapon(param_01))
		{
			param_01 = maps\mp\gametypes\_class::getbasefromlootversion(param_01);
		}
	}

	if(param_01 == "h1_rpg")
	{
		return "weapon_launcher";
	}

	return var_02;
}

//Function Number: 23
ch_bulletdamagecommon(param_00,param_01,param_02,param_03)
{
	if(!maps\mp\_utility::isenvironmentweapon(param_00.sweapon))
	{
		param_01 endmgstreak();
	}

	if(maps\mp\_utility::iskillstreakweapon(param_00.sweapon))
	{
		return;
	}

	if(isbot(param_01))
	{
		return;
	}

	if(param_01.pers["lastBulletKillTime"] == param_02)
	{
		param_01.pers["bulletStreak"]++;
	}
	else
	{
		param_01.pers["bulletStreak"] = 1;
	}

	param_01.pers["lastBulletKillTime"] = param_02;
	if(!param_00.victimonground)
	{
		param_01 processchallenge("ch_hardlanding");
	}

	if(!param_00.attackeronground)
	{
		param_01.pers["midairStreak"]++;
	}

	if(param_01.pers["midairStreak"] == 2)
	{
		param_01 processchallenge("ch_airborne");
	}

	if(param_02 < param_00.victim.flashendtime)
	{
		param_01 processchallenge("ch_flashbangvet");
	}

	if(param_02 < param_01.flashendtime)
	{
		param_01 processchallenge("ch_blindfire");
	}

	if(param_02 < param_00.victim.concussionendtime)
	{
		param_01 processchallenge("ch_concussionvet");
	}

	if(param_02 < param_01.concussionendtime)
	{
		param_01 processchallenge("ch_slowbutsure");
	}

	if(param_01.pers["bulletStreak"] == 2)
	{
		if(isdefined(param_00.modifiers["headshot"]))
		{
			foreach(var_05 in param_01.killsthislife)
			{
				if(var_05.time != param_02)
				{
					continue;
				}

				if(!isdefined(param_00.modifiers["headshot"]))
				{
					continue;
				}

				param_01 processchallenge("ch_allpro");
			}
		}

		if(param_03 == "weapon_sniper")
		{
			param_01 processchallenge("ch_collateraldamage");
			if(maps\mp\_utility::getmapname() == "mp_bog_summer")
			{
				param_01 processchallenge("ch_summer_collateraldamage");
			}
		}
	}

	if(param_03 == "weapon_pistol")
	{
		if(isdefined(param_00.victim.attackerdata) && isdefined(param_00.victim.attackerdata[param_01.guid]))
		{
			if(isdefined(param_00.victim.attackerdata[param_01.guid].isprimary))
			{
				param_01 processchallenge("ch_fastswap");
			}
		}
	}

	if(!isdefined(param_01.infinalstand) || !param_01.infinalstand)
	{
		var_07 = maps\mp\_utility::getbaseweaponname(param_00.sweapon);
		if(param_00.attackerstance == "crouch")
		{
			param_01 processchallenge("ch_crouchshot");
			param_01 processchallenge("ch_crouch_" + var_07);
		}
		else if(param_00.attackerstance == "prone")
		{
			param_01 processchallenge("ch_proneshot");
			param_01 processchallenge("ch_prone_" + var_07);
			if(param_03 == "weapon_sniper")
			{
				param_01 processchallenge("ch_invisible");
			}
		}
	}

	if(issubstr(param_00.sweapon,"silencer"))
	{
		param_01 processchallenge("ch_stealth");
	}
}

//Function Number: 24
ch_roundplayed(param_00)
{
	var_01 = param_00.player;
	if(var_01.wasaliveatmatchstart)
	{
		var_02 = var_01.pers["deaths"];
		var_03 = var_01.pers["kills"];
		var_04 = 1000000;
		if(var_02 > 0)
		{
			var_04 = var_03 / var_02;
		}

		if(var_04 >= 5 && var_03 >= 5)
		{
			var_01 processchallenge("ch_starplayer");
		}

		if(var_02 == 0 && maps\mp\_utility::gettimepassed() > 300000)
		{
			var_01 processchallenge("ch_flawless");
		}

		if(level.placement["all"].size < 3)
		{
			return;
		}

		if(var_01.score > 0)
		{
			switch(level.gametype)
			{
				case "dm":
					break;

				default:
					break;
			}
		}
	}
}

//Function Number: 25
ch_roundwin(param_00)
{
	if(!param_00.winner)
	{
		return;
	}

	var_01 = param_00.player;
	if(var_01.wasaliveatmatchstart)
	{
		switch(level.gametype)
		{
			case "war":
				break;

			case "sab":
				break;

			case "sd":
				break;

			case "hc":
			case "koth":
			case "dom":
			case "ctf":
			case "dm":
			case "hp":
				break;

			default:
				break;
		}
	}
}

//Function Number: 26
playerdamaged(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	if(isdefined(param_01))
	{
		param_01 endon("disconnect");
	}

	wait(0.05);
	maps\mp\_utility::waittillslowprocessallowed();
	var_06 = spawnstruct();
	var_06.victim = self;
	var_06.einflictor = param_00;
	var_06.attacker = param_01;
	var_06.idamage = param_02;
	var_06.smeansofdeath = param_03;
	var_06.sweapon = param_04;
	var_06.shitloc = param_05;
	var_06.victimonground = var_06.victim isonground();
	if(isplayer(param_01))
	{
		var_06.attackerinlaststand = isdefined(var_06.attacker.laststand);
		var_06.attackeronground = var_06.attacker isonground();
		var_06.attackerstance = var_06.attacker getstance();
	}
	else
	{
		var_06.attackerinlaststand = 0;
		var_06.attackeronground = 0;
		var_06.attackerstance = "stand";
	}

	domissioncallback("playerDamaged",var_06);
}

//Function Number: 27
playerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self.anglesondeath = self getplayerangles();
	if(isdefined(param_01))
	{
		param_01.anglesonkill = param_01 getplayerangles();
	}

	self endon("disconnect");
	var_09 = spawnstruct();
	var_09.victim = self;
	var_09.einflictor = param_00;
	var_09.attacker = param_01;
	var_09.idamage = param_02;
	var_09.smeansofdeath = param_03;
	var_09.sweapon = param_04;
	var_09.sprimaryweapon = param_05;
	var_09.shitloc = param_06;
	var_09.time = gettime();
	var_09.modifiers = param_07;
	var_09.duetodisconnect = param_08;
	var_09.victimonground = var_09.victim isonground();
	if(isplayer(param_01))
	{
		var_09.attackerinlaststand = isdefined(var_09.attacker.laststand);
		var_09.attackeronground = var_09.attacker isonground();
		var_09.attackerstance = var_09.attacker getstance();
	}
	else
	{
		var_09.attackerinlaststand = 0;
		var_09.attackeronground = 0;
		var_09.attackerstance = "stand";
	}

	var_0A = 0;
	if(isdefined(var_09.einflictor) && isdefined(var_09.einflictor.firedads))
	{
		var_0A = var_09.einflictor.firedads;
	}
	else if(isdefined(param_01) && isplayer(param_01))
	{
		var_0A = param_01 playerads();
	}

	var_09.was_ads = 0;
	if(var_0A >= 0.2)
	{
		var_09.was_ads = 1;
	}

	waitandprocessplayerkilledcallback(var_09);
	if(isdefined(param_01) && maps\mp\_utility::isreallyalive(param_01))
	{
		param_01.killsthislife[param_01.killsthislife.size] = var_09;
	}

	var_09.attacker notify("playerKilledChallengesProcessed");
}

//Function Number: 28
vehiclekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	var_07.vehicle = param_01;
	var_07.victim = param_00;
	var_07.einflictor = param_02;
	var_07.attacker = param_03;
	var_07.idamage = param_04;
	var_07.smeansofdeath = param_05;
	var_07.sweapon = param_06;
	var_07.time = gettime();
	domissioncallback("vehicleKilled",var_07);
}

//Function Number: 29
waitandprocessplayerkilledcallback(param_00)
{
	if(isdefined(param_00.attacker))
	{
		param_00.attacker endon("disconnect");
	}

	self.processingkilledchallenges = 1;
	if(!isdefined(param_00.duetodisconnect) || !param_00.duetodisconnect)
	{
		wait(0.05);
		maps\mp\_utility::waittillslowprocessallowed();
	}

	domissioncallback("playerKilled",param_00);
	self.processingkilledchallenges = undefined;
}

//Function Number: 30
playerassist()
{
	var_00 = spawnstruct();
	var_00.player = self;
	domissioncallback("playerAssist",var_00);
}

//Function Number: 31
usehardpoint(param_00)
{
	self endon("disconnect");
	wait(0.05);
	maps\mp\_utility::waittillslowprocessallowed();
	var_01 = spawnstruct();
	var_01.player = self;
	var_01.hardpointtype = param_00;
	domissioncallback("playerHardpoint",var_01);
}

//Function Number: 32
roundbegin()
{
	domissioncallback("roundBegin");
}

//Function Number: 33
roundend(param_00)
{
	var_01 = spawnstruct();
	if(level.teambased)
	{
		var_02 = "allies";
		for(var_03 = 0;var_03 < level.placement[var_02].size;var_03++)
		{
			var_01.player = level.placement[var_02][var_03];
			var_01.winner = var_02 == param_00;
			var_01.place = var_03;
			domissioncallback("roundEnd",var_01);
		}

		var_02 = "axis";
		for(var_03 = 0;var_03 < level.placement[var_02].size;var_03++)
		{
			var_01.player = level.placement[var_02][var_03];
			var_01.winner = var_02 == param_00;
			var_01.place = var_03;
			domissioncallback("roundEnd",var_01);
		}

		return;
	}

	for(var_03 = 0;var_03 < level.placement["all"].size;var_03++)
	{
		var_01.player = level.placement["all"][var_03];
		var_01.winner = isdefined(param_00) && isplayer(param_00) && var_01.player == param_00;
		var_01.place = var_03;
		domissioncallback("roundEnd",var_01);
	}
}

//Function Number: 34
domissioncallback(param_00,param_01)
{
	if(!mayprocesschallenges())
	{
		return;
	}

	if(getdvarint("disable_challenges") > 0)
	{
		return;
	}

	if(!isdefined(level.missioncallbacks[param_00]))
	{
		return;
	}

	if(isdefined(param_01))
	{
		for(var_02 = 0;var_02 < level.missioncallbacks[param_00].size;var_02++)
		{
			thread [[ level.missioncallbacks[param_00][var_02] ]](param_01);
		}

		return;
	}

	for(var_02 = 0;var_02 < level.missioncallbacks[param_00].size;var_02++)
	{
		thread [[ level.missioncallbacks[param_00][var_02] ]]();
	}
}

//Function Number: 35
monitorsprintdistance()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	if(!isdefined(self.pers["totalGameSprintDist"]))
	{
		self.pers["totalGameSprintDist"] = 0;
	}

	for(;;)
	{
		self waittill("sprint_begin");
		self.sprintdistthissprint = 0;
		monitorsinglesprintdistance();
		processchallenge("ch_marathon",int(self.sprintdistthissprint));
		if(maps\mp\_utility::getmapname() == "mp_crash_snow")
		{
			processchallenge("ch_wc_sprint",int(self.sprintdistthissprint));
		}

		self.pers["totalGameSprintDist"] = self.pers["totalGameSprintDist"] + self.sprintdistthissprint;
		if(maps\mp\_utility::_hasperk("specialty_longersprint"))
		{
			if(int(self.pers["totalGameSprintDist"]) >= 15840)
			{
				processchallenge("ch_extremeconditioning");
				self.pers["totalGameSprintDist"] = 0;
			}
		}
	}
}

//Function Number: 36
monitorsinglesprintdistance()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	self endon("sprint_end");
	var_00 = self.origin;
	for(;;)
	{
		wait(0.1);
		self.sprintdistthissprint = self.sprintdistthissprint + distance(self.origin,var_00);
		var_00 = self.origin;
	}
}

//Function Number: 37
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
			var_00 = self.origin[2];
			while(!self isonground())
			{
				if(self.origin[2] > var_00)
				{
					var_00 = self.origin[2];
				}

				wait(0.05);
			}

			self.pers["midairStreak"] = 0;
			var_01 = var_00 - self.origin[2];
			if(var_01 < 0)
			{
				var_01 = 0;
			}

			if(var_01 / 12 > 15 && isalive(self))
			{
				processchallenge("ch_basejump");
			}

			if(var_01 / 12 > 30 && !isalive(self))
			{
				processchallenge("ch_goodbye");
			}
		}

		wait(0.05);
	}
}

//Function Number: 38
remove_tracking_on_disconnect(param_00)
{
	level endon("game_ended");
	self waittill("disconnect");
	if(isdefined(game[param_00][self.guid]))
	{
		game[param_00][self.guid] = undefined;
	}
}

//Function Number: 39
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

//Function Number: 40
monitorbombuse()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("bomb_planted","bomb_defused");
		if(!isdefined(var_00))
		{
			continue;
		}

		if(var_00 == "bomb_defused")
		{
			processchallenge("ch_hero");
		}
	}
}

//Function Number: 41
monitorlivetime()
{
	for(;;)
	{
		self waittill("spawned_player");
		thread survivalistchallenge();
	}
}

//Function Number: 42
survivalistchallenge()
{
	self endon("death");
	self endon("disconnect");
	wait(300);
	if(isdefined(self))
	{
		processchallenge("ch_survivalist");
	}
}

//Function Number: 43
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

//Function Number: 44
monitormisc()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return_no_endon_death("destroyed_explosive","begin_airstrike","destroyed_helicopter","destroyed_car","crushed_enemy");
		monitormisccallback(var_00);
	}
}

//Function Number: 45
monitormisccallback(param_00)
{
	switch(param_00)
	{
		case "begin_airstrike":
			break;

		case "destroyed_explosive":
			break;

		case "destroyed_helicopter":
			break;

		case "destroyed_car":
			break;

		default:
			break;
	}
}

//Function Number: 46
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
			self.healthregenerationstreak = 0;
			processchallenge("ch_invincible");
		}
	}
}

//Function Number: 47
resetbrinkofdeathkillstreakshortly()
{
	self endon("disconnect");
	self endon("death");
	self endon("damage");
	wait(1);
	self.brinkofdeathkillstreak = 0;
}

//Function Number: 48
playerspawned()
{
	self.brinkofdeathkillstreak = 0;
	self.healthregenerationstreak = 0;
}

//Function Number: 49
playerdied()
{
	self.brinkofdeathkillstreak = 0;
	self.healthregenerationstreak = 0;
}

//Function Number: 50
isatbrinkofdeath()
{
	var_00 = self.health / self.maxhealth;
	return var_00 <= level.healthoverlaycutoff;
}

//Function Number: 51
processchallenge(param_00,param_01,param_02)
{
	if(!mayprocesschallenges())
	{
		return;
	}

	if(level.players.size < 2 && !getdvarint("force_ranking"))
	{
		var_03 = undefined;
		if(isdefined(var_03))
		{
			if(var_03 == 0)
			{
				return;
			}
		}
		else
		{
			return;
		}
	}

	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_04 = getchallengestatus(param_00);
	if(var_04 == 0)
	{
		return;
	}

	if(var_04 > level.challengeinfo[param_00]["targetval"].size)
	{
		return;
	}

	var_05 = maps\mp\gametypes\_hud_util::ch_getprogress(param_00);
	if(isdefined(param_02) && param_02)
	{
		var_06 = param_01;
	}
	else if(maps\mp\gametypes\_hud_util::isweaponclasschallenge(param_01))
	{
		var_06 = var_06;
	}
	else
	{
		var_06 = var_06 + param_02;
	}

	var_07 = 0;
	var_08 = level.challengeinfo[param_00]["targetval"][var_04];
	while(isdefined(var_08) && var_06 >= var_08)
	{
		var_07++;
		var_08 = level.challengeinfo[param_00]["targetval"][var_04 + var_07];
	}

	if(var_05 < var_06)
	{
		maps\mp\gametypes\_hud_util::ch_setprogress(param_00,var_06);
	}

	if(var_07 > 0)
	{
		var_09 = var_04;
		while(var_07)
		{
			thread giverankxpafterwait(param_00,var_04);
			var_0A = getchallengeid(param_00,var_04);
			self method_843F(var_0A);
			var_0B = common_scripts\utility::tostring(var_0A);
			var_0C = int(getsubstr(var_0B,0,var_0B.size - 2));
			if(!isdefined(game["challengeStruct"]["challengesCompleted"][self.guid]))
			{
				game["challengeStruct"]["challengesCompleted"][self.guid] = [];
			}

			var_0D = 0;
			foreach(var_0F in game["challengeStruct"]["challengesCompleted"][self.guid])
			{
				if(var_0F == var_0C)
				{
					var_0D = 1;
				}
			}

			if(!var_0D)
			{
				game["challengeStruct"]["challengesCompleted"][self.guid][game["challengeStruct"]["challengesCompleted"][self.guid].size] = var_0C;
			}

			if(var_04 >= level.challengeinfo[param_00]["targetval"].size && level.challengeinfo[param_00]["parent_challenge"] != "")
			{
				processchallenge(level.challengeinfo[param_00]["parent_challenge"]);
			}

			var_04++;
			var_07--;
			maps\mp\_matchdata::logcompletedchallenge(var_0A);
		}

		if(!issubstr(param_00,"ch_limited_bloodshed"))
		{
			thread maps\mp\gametypes\_hud_message::challengesplashnotify(param_00,var_09,var_04);
		}

		maps\mp\gametypes\_hud_util::ch_setstate(param_00,var_04);
		self.challengedata[param_00] = var_04;
	}
}

//Function Number: 52
giverankxpafterwait(param_00,param_01)
{
	self endon("disconnect");
	wait(0.25);
	maps\mp\gametypes\_rank::giverankxp("challenge",level.challengeinfo[param_00]["reward"][param_01],undefined,undefined,param_00);
}

//Function Number: 53
getmarksmanunlockattachment(param_00,param_01)
{
	return tablelookup("mp/unlockTable.csv",0,param_00,4 + param_01);
}

//Function Number: 54
getlastchallengetier(param_00)
{
	var_01 = 0;
	if(isdefined(level.challengeinfo[param_00]) && isdefined(level.challengeinfo[param_00]["targetval"].size))
	{
		var_01 = level.challengeinfo[param_00]["targetval"].size;
	}

	return var_01;
}

//Function Number: 55
getchallengetiernumber(param_00)
{
	var_01 = getsubstr(param_00,param_00.size - 2,param_00.size);
	if(getsubstr(var_01,0,1) == "_")
	{
		var_02 = int(getsubstr(var_01,1,2));
	}
	else
	{
		var_02 = 0;
	}

	return var_02;
}

//Function Number: 56
ischallengeresetafterprestige(param_00,param_01)
{
	var_02 = tablelookupbyrow("mp/allChallengesTable.csv",param_00,45);
	if(!isdefined(param_01))
	{
		param_01 = tablelookupbyrow("mp/allChallengesTable.csv",param_00,6);
	}

	if(var_02 != "" && int(var_02) && int(param_01) != 4)
	{
		return 1;
	}

	return 0;
}

//Function Number: 57
ischallengeunlocked(param_00,param_01)
{
	var_02 = tablelookupbyrow("mp/allChallengesTable.csv",param_01,9);
	if(var_02 != "")
	{
		var_03 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(),"challengeState",var_02);
		if(var_03 > 1)
		{
			return 1;
		}
	}

	var_04 = tablelookupbyrow("mp/allChallengesTable.csv",param_01,6);
	if(var_04 != "")
	{
		var_05 = maps\mp\gametypes\_rank::getrank();
		var_06 = maps\mp\gametypes\_rank::getprestigelevel();
		if(var_05 < int(var_04))
		{
			if(var_06 < 1)
			{
				return 0;
			}

			if(int(var_04) > 54)
			{
				return 0;
			}

			if(ischallengeresetafterprestige(param_01,var_04))
			{
				return 0;
			}
		}
	}

	var_07 = tablelookupbyrow("mp/allChallengesTable.csv",param_01,47);
	if(var_07 != "")
	{
		var_06 = maps\mp\gametypes\_rank::getprestigelevel();
		if(var_06 < int(var_07))
		{
			return 0;
		}
	}

	var_08 = tablelookupbyrow("mp/allChallengesTable.csv",param_01,8);
	if(var_08 != "")
	{
		var_09 = self isitemunlocked(var_08);
		if(!var_09)
		{
			return 0;
		}
	}

	var_0A = tablelookupbyrow("mp/allChallengesTable.csv",param_01,7);
	if(var_0A != "")
	{
		var_0B = getchallengetiernumber(var_0A);
		if(var_0B == 0)
		{
			var_0B = getlastchallengetier(var_0A);
		}

		if(var_0B > 0)
		{
			var_0C = getchallengestatus(var_0A);
			if(var_0C <= var_0B)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 58
updatechallenges()
{
	self.challengedata = [];
	if(!isdefined(self.ch_unique_earned_streaks))
	{
		self.ch_unique_earned_streaks = [];
	}

	if(!isdefined(game["challengeStruct"]))
	{
		game["challengeStruct"] = [];
	}

	if(!isdefined(game["challengeStruct"]["limitedChallengesReset"]))
	{
		game["challengeStruct"]["limitedChallengesReset"] = [];
	}

	if(!isdefined(game["challengeStruct"]["challengesCompleted"]))
	{
		game["challengeStruct"]["challengesCompleted"] = [];
	}

	self endon("disconnect");
	if(!mayprocesschallenges())
	{
		return;
	}

	if(!self isitemunlocked("feature_challenges"))
	{
		return;
	}

	var_00 = 0;
	foreach(var_05, var_02 in level.challengeinfo)
	{
		var_00++;
		if(var_00 % 40 == 0)
		{
			wait(0.05);
		}

		self.challengedata[var_05] = 0;
		var_03 = var_02["index"];
		if(!ischallengeunlocked(var_05,var_03))
		{
			continue;
		}

		var_04 = maps\mp\gametypes\_hud_util::ch_getstate(var_05);
		if(maps\mp\gametypes\_hud_util::istimelimitedchallenge(var_05) && !isdefined(game["challengeStruct"]["limitedChallengesReset"][self.guid]))
		{
			maps\mp\gametypes\_hud_util::ch_setprogress(var_05,0);
			var_04 = 0;
		}

		if(var_04 == 0)
		{
			maps\mp\gametypes\_hud_util::ch_setstate(var_05,1);
			var_04 = 1;
		}

		self.challengedata[var_05] = var_04;
	}

	game["challengeStruct"]["limitedChallengesReset"][self.guid] = 1;
}

//Function Number: 59
isinunlocktable(param_00)
{
	return tablelookup("mp/unlockTable.csv",0,param_00,0) != "";
}

//Function Number: 60
getchallengefilter(param_00)
{
	return tablelookup("mp/allChallengesTable.csv",0,param_00,5);
}

//Function Number: 61
getchallengetable(param_00)
{
	return tablelookup("mp/challengeTable.csv",8,param_00,4);
}

//Function Number: 62
gettierfromtable(param_00,param_01)
{
	return tablelookup(param_00,0,param_01,1);
}

//Function Number: 63
isweaponchallenge(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = getchallengefilter(param_00);
	if(isdefined(var_01) && var_01 == "riotshield")
	{
		return 1;
	}

	var_02 = maps\mp\_utility::getweaponnametokens(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(var_04 == "iw5" || var_04 == "iw6" || var_04 == "h1")
		{
			var_04 = var_02[var_03] + "_" + var_02[var_03 + 1];
		}

		if(maps\mp\gametypes\_class::isvalidprimary(var_04) || maps\mp\gametypes\_class::isvalidsecondary(var_04))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 64
getweaponfromchallenge(param_00)
{
	var_01 = "ch_";
	if(issubstr(param_00,"ch_marksman_"))
	{
		var_01 = "ch_marksman_";
	}
	else if(issubstr(param_00,"ch_expert_"))
	{
		var_01 = "ch_expert_";
	}
	else if(issubstr(param_00,"pr_marksman_"))
	{
		var_01 = "pr_marksman_";
	}
	else if(issubstr(param_00,"pr_expert_"))
	{
		var_01 = "pr_expert_";
	}

	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	var_03 = maps\mp\_utility::getweaponnametokens(var_02);
	var_02 = undefined;
	if(var_03[0] == "iw5" || var_03[0] == "iw6" || var_03[0] == "h1")
	{
		var_02 = var_03[0] + "_" + var_03[1];
	}
	else
	{
		var_02 = var_03[0];
	}

	return var_02;
}

//Function Number: 65
getweaponattachmentfromchallenge(param_00)
{
	var_01 = "ch_";
	if(issubstr(param_00,"ch_marksman_"))
	{
		var_01 = "ch_marksman_";
	}
	else if(issubstr(param_00,"ch_expert_"))
	{
		var_01 = "ch_expert_";
	}
	else if(issubstr(param_00,"pr_marksman_"))
	{
		var_01 = "pr_marksman_";
	}
	else if(issubstr(param_00,"pr_expert_"))
	{
		var_01 = "pr_expert_";
	}

	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	var_03 = maps\mp\_utility::getweaponnametokens(var_02);
	var_04 = undefined;
	if(isdefined(var_03[2]) && maps\mp\_utility::isattachment(var_03[2]))
	{
		var_04 = var_03[2];
	}

	return var_04;
}

//Function Number: 66
iskillstreakchallenge(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = getchallengefilter(param_00);
	if(isdefined(var_01) && var_01 == "killstreaks_assault" || var_01 == "killstreaks_support")
	{
		return 1;
	}

	return 0;
}

//Function Number: 67
getkillstreakfromchallenge(param_00)
{
	var_01 = "ch_";
	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	if(var_02 == "assault_streaks" || var_02 == "support_streaks")
	{
		var_02 = undefined;
	}

	return var_02;
}

//Function Number: 68
challenge_targetval(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,10 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 69
challenge_rewardval(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,11 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 70
challenge_parentchallenge(param_00,param_01)
{
	var_02 = tablelookup(param_00,0,param_01,43);
	if(!isdefined(var_02))
	{
		var_02 = "";
	}

	return var_02;
}

//Function Number: 71
buildchallengetableinfo(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	for(;;)
	{
		var_03++;
		var_04 = tablelookupbyrow(param_00,var_03,0);
		if(var_04 == "")
		{
			break;
		}

		var_05 = tablelookupbyrow(param_00,var_03,44);
		if(var_05 == "1")
		{
			continue;
		}

		level.challengeinfo[var_04] = [];
		level.challengeinfo[var_04]["index"] = var_03;
		level.challengeinfo[var_04]["type"] = param_01;
		level.challengeinfo[var_04]["targetval"] = [];
		level.challengeinfo[var_04]["reward"] = [];
		level.challengeinfo[var_04]["parent_challenge"] = "";
		if(isweaponchallenge(var_04))
		{
			var_06 = getweaponfromchallenge(var_04);
			var_07 = getweaponattachmentfromchallenge(var_04);
			if(isdefined(var_06))
			{
				level.challengeinfo[var_04]["weapon"] = var_06;
			}

			if(isdefined(var_07))
			{
				level.challengeinfo[var_04]["attachment"] = var_07;
			}
		}
		else if(iskillstreakchallenge(var_04))
		{
			var_08 = getkillstreakfromchallenge(var_04);
			if(isdefined(var_08))
			{
				level.challengeinfo[var_04]["killstreak"] = var_08;
			}
		}

		for(var_09 = 1;var_09 < 11;var_09++)
		{
			var_0A = challenge_targetval(param_00,var_04,var_09);
			var_0B = challenge_rewardval(param_00,var_04,var_09);
			if(var_0A == 0)
			{
				break;
			}

			level.challengeinfo[var_04]["targetval"][var_09] = var_0A;
			level.challengeinfo[var_04]["reward"][var_09] = var_0B;
			var_02 = var_02 + var_0B;
		}

		level.challengeinfo[var_04]["parent_challenge"] = challenge_parentchallenge(param_00,var_04);
	}

	return int(var_02);
}

//Function Number: 72
buildchallegeinfo()
{
	level.challengeinfo = [];
	if(getdvar("virtualLobbyActive") == "1")
	{
		return;
	}

	var_00 = 0;
	var_00 = var_00 + buildchallengetableinfo("mp/allChallengesTable.csv",0);
}

//Function Number: 73
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

		self waittill("process",var_00);
		processchallenge(var_00);
	}
}

//Function Number: 74
monitorkillstreakprogress()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		self waittill("got_killstreak",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}
	}
}

//Function Number: 75
genericchallenge(param_00,param_01)
{
	switch(param_00)
	{
		default:
			break;
	}
}

//Function Number: 76
playerhasammo()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(self getweaponammoclip(var_02))
		{
			return 1;
		}

		var_03 = weaponaltweaponname(var_02);
		if(!isdefined(var_03) || var_03 == "none")
		{
			continue;
		}

		if(self getweaponammoclip(var_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 77
monitoradstime()
{
	self endon("disconnect");
	self.adstime = 0;
	for(;;)
	{
		if(self playerads() == 1)
		{
			self.adstime = self.adstime + 0.05;
		}
		else
		{
			self.adstime = 0;
		}

		wait(0.05);
	}
}

//Function Number: 78
monitorpronetime()
{
	self endon("disconnect");
	level endon("game_ended");
	self.pronetime = undefined;
	var_00 = 0;
	for(;;)
	{
		var_01 = self getstance();
		if(var_01 == "prone" && var_00 == 0)
		{
			self.pronetime = gettime();
			var_00 = 1;
		}
		else if(var_01 != "prone")
		{
			self.pronetime = undefined;
			var_00 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 79
monitorholdbreath()
{
	self endon("disconnect");
	self.holdingbreath = 0;
	for(;;)
	{
		self waittill("hold_breath");
		self.holdingbreath = 1;
		self waittill("release_breath");
		self.holdingbreath = 0;
	}
}

//Function Number: 80
monitormantle()
{
	self endon("disconnect");
	self.mantling = 0;
	for(;;)
	{
		self waittill("jumped");
		var_00 = self getcurrentweapon();
		common_scripts\utility::waittill_notify_or_timeout("weapon_change",1);
		var_01 = self getcurrentweapon();
		if(var_01 == "none")
		{
			self.mantling = 1;
		}
		else
		{
			self.mantling = 0;
		}

		if(self.mantling)
		{
			common_scripts\utility::waittill_notify_or_timeout("weapon_change",1);
			var_01 = self getcurrentweapon();
			if(var_01 == var_00)
			{
				self.mantling = 0;
			}
		}
	}
}

//Function Number: 81
monitorweaponswap()
{
	self endon("disconnect");
	var_00 = self getcurrentweapon();
	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(var_01 == "none")
		{
			continue;
		}

		if(var_01 == var_00)
		{
			continue;
		}

		if(maps\mp\_utility::iskillstreakweapon(var_01))
		{
			continue;
		}

		if(maps\mp\_utility::isbombsiteweapon(var_01))
		{
			continue;
		}

		var_02 = weaponinventorytype(var_01);
		if(var_02 != "primary")
		{
			continue;
		}

		self.lastprimaryweaponswaptime = gettime();
	}
}

//Function Number: 82
monitorflashbang()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03);
		if(isdefined(var_03) && self == var_03)
		{
			continue;
		}

		self.lastflashedtime = gettime();
	}
}

//Function Number: 83
monitorconcussion()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("concussed",var_00);
		if(self == var_00)
		{
			continue;
		}

		self.lastconcussedtime = gettime();
	}
}

//Function Number: 84
is_lethal_equipment(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "h1_fraggrenade_mp":
			break;

		default:
			break;
	}
}