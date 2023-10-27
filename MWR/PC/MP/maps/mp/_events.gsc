/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_events.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 87
 * Decompile Time: 1318 ms
 * Timestamp: 10/27/2023 2:40:21 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = getdvar("g_gametype");
	var_01 = 0;
	var_02 = [];
	var_02["dm"] = 4;
	var_02["war"] = 5;
	var_02["sd"] = 6;
	var_02["dom"] = 7;
	var_02["conf"] = 8;
	var_02["sr"] = 9;
	var_02["infect"] = 10;
	var_02["gun"] = 11;
	var_02["ctf"] = 12;
	var_02["horde"] = 13;
	var_02["twar"] = 14;
	var_02["hp"] = 15;
	var_02["ball"] = 16;
	var_02["dd"] = 17;
	var_02["koth"] = 18;
	var_02["sab"] = 19;
	var_02["mugger"] = 20;
	for(;;)
	{
		if(!isdefined(var_02[var_00]))
		{
			var_00 = "war";
		}

		var_03 = tablelookupbyrow("mp/xp_event_table.csv",var_01,0);
		var_04 = tablelookupbyrow("mp/xp_event_table.csv",var_01,1);
		var_05 = tablelookupbyrow("mp/xp_event_table.csv",var_01,2);
		var_06 = tablelookupbyrow("mp/xp_event_table.csv",var_01,var_02[var_00]);
		if(!isdefined(var_03) || var_03 == "")
		{
			break;
		}

		if(var_03 == "win" || var_03 == "loss" || var_03 == "tie")
		{
			var_06 = float(var_06);
		}
		else
		{
			var_06 = int(var_06);
		}

		if(var_06 != -1)
		{
			var_05 = int(var_05);
			var_04 = int(var_04);
			maps\mp\gametypes\_rank::registerxpeventinfo(var_03,var_06,var_05,var_04);
		}

		var_01++;
	}

	level.numkills = 0;
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.killedplayerscurrent = [];
		var_00.damagedplayers = [];
		var_00.lastkilledby = undefined;
		var_00.recentkillcount = 0;
		var_00.lastkilltime = 0;
		var_00.bulletstreak = 0;
		var_00.lastcoopstreaktime = 0;
	}
}

//Function Number: 3
addnemesisscoreforplayer(param_00,param_01)
{
	if(!isdefined(self.pers["nemesis_tracking"][param_00]))
	{
		self.pers["nemesis_tracking"][param_00] = 0;
	}

	self.pers["nemesis_tracking"][param_00] = self.pers["nemesis_tracking"][param_00] + param_01;
	if(self.pers["nemesis_guid"] == "" || self.pers["nemesis_tracking"][param_00] > self.pers["nemesis_tracking"][self.pers["nemesis_guid"]])
	{
		self.pers["nemesis_guid"] = param_00;
	}
}

//Function Number: 4
killedplayer(param_00,param_01,param_02,param_03,param_04)
{
	level.numkills++;
	var_05 = param_01.guid;
	var_06 = param_01.pers["cur_kill_streak"];
	var_07 = self.guid;
	var_08 = gettime();
	if(maps\mp\_utility::isbulletdamage(param_03))
	{
		if(self.lastkilltime == var_08)
		{
			self.bulletstreak++;
		}
		else
		{
			self.bulletstreak = 1;
		}
	}
	else
	{
		self.bulletstreak = 0;
	}

	self.lastkilltime = gettime();
	self.lastkilledplayer = param_01;
	self.modifiers = [];
	self.damagedplayers[var_05] = undefined;
	thread updaterecentkills(param_00,param_02);
	if(!maps\mp\_utility::iskillstreakweapon(param_02))
	{
		if(param_02 == "none")
		{
			return 0;
		}

		if(isdefined(param_01.throwinggrenade))
		{
			if(param_01.throwinggrenade == "h1_fraggrenade_mp")
			{
				self.modifiers["cooking"] = 1;
			}
		}

		if(weaponinventorytype(param_02) == "primary")
		{
			self.segments["killDistanceTotal"] = self.segments["killDistanceTotal"] + distance2d(self.origin,param_01.origin);
			self.segments["killDistanceCount"]++;
		}

		if(param_03 == "MOD_HEAD_SHOT")
		{
			headshotevent(param_00,param_02,param_03);
		}

		if(level.numkills == 1)
		{
			firstbloodevent(param_00,param_02,param_03);
		}

		if(level.teambased && var_08 - param_01.lastkilltime < 3000 && param_01.lastkilledplayer != self)
		{
			avengedplayerevent(param_00,param_02,param_03);
		}

		if(!isalive(self) && self != param_01 && isdefined(self.deathtime) && self.deathtime + 1200 < gettime())
		{
			postdeathkillevent(param_00);
		}

		if(self.pers["cur_death_streak"] > 3)
		{
			comebackevent(param_00,param_02,param_03);
		}

		if(isdefined(self.assistedsuicide) && self.assistedsuicide)
		{
			assistedsuicideevent(param_00,param_02,param_03);
		}

		if(islongshot(self,param_02,param_03,param_01))
		{
			longshotevent(param_00,param_02,param_03);
		}

		if(isresuce(param_01,var_08))
		{
			defendedplayerevent(param_00,param_02,param_03);
		}

		if(var_06 > 0 && isbuzzkillevent(param_01))
		{
			buzzkillevent(param_00,param_01,param_02,param_03);
		}

		if(isoneshotkill(param_01,param_02,param_03))
		{
			oneshotkillevent(param_00,param_02,param_03);
		}

		if(isdefined(self.lastkilledby) && self.lastkilledby == param_01)
		{
			revengeevent(param_00);
		}

		if(param_01.idflags & level.idflags_penetration)
		{
			bulletpenetrationevent(param_00,param_02);
		}

		if(ispointblank(param_01,param_03))
		{
			pointblankevent(param_00,param_02,param_03);
		}

		if(self.health < 20 && self.health > 0)
		{
			neardeathkillevent(param_02,param_03);
		}

		if(common_scripts\utility::isflashed())
		{
			flashedkillevent(param_02,param_03);
		}

		if(isthinkfast(param_02,param_03))
		{
			thinkfastevent();
		}

		if(self.bulletstreak == 2)
		{
			multikillonebulletevent();
		}

		if(isbackstabevent(param_01,param_02,param_03))
		{
			backstabevent();
		}

		if(isthrowbackevent(param_01,param_02,param_03))
		{
			throwbackkillevent();
		}

		if(isdefined(self.pickedupweaponfrom[param_02]) && self.pickedupweaponfrom[param_02] == param_01 && !maps\mp\_utility::ismeleemod(param_03))
		{
			takeandkillevent();
		}

		if(maps\mp\_utility::isbulletdamage(param_03) && !isdefined(self.assistedsuicide))
		{
			if(maps\mp\_utility::_hasperk("specialty_bulletdamage"))
			{
				stoppingpowerevent();
			}

			if(maps\mp\_utility::_hasperk("specialty_fastreload"))
			{
				sleightofhandevent(param_02);
			}

			if(maps\mp\_utility::_hasperk("specialty_rof") && maps\mp\_utility::is_true(param_01.laststand))
			{
				doubletapevent();
			}

			if(maps\mp\_utility::_hasperk("specialty_twoprimaries") && param_02 == self.secondaryweapon)
			{
				overkillevent();
			}

			if(maps\mp\_utility::_hasperk("specialty_bulletaccuracy") && self playerads() < 0.5)
			{
				steadyaimevent();
			}

			if(maps\mp\_utility::_hasperk("specialty_pistoldeath") && maps\mp\_utility::is_true(self.laststand) && maps\mp\_utility::is_true(param_01.laststand))
			{
				laststandevent();
			}

			if(maps\mp\_utility::_hasperk("specialty_holdbreath") && weaponclass(param_02) == "sniper")
			{
				ironlungsevent();
			}

			if(maps\mp\_utility::_hasperk("specialty_parabolic"))
			{
				eavesdropevent();
			}
		}

		if(maps\mp\_utility::_hasperk("specialty_radarimmune") && param_01 maps\mp\gametypes\_hardpoints::playerhasuavactive())
		{
			uavjammerevent();
		}

		if(maps\mp\_utility::_hasperk("specialty_explosivedamage") && isexplosivedamagemod(param_03))
		{
			sonicboomevent();
		}

		checkhigherrankkillevents(param_01);
		checkweaponspecifickill(param_01,param_02,param_03);
	}

	checkstreakingevents(param_01);
	if(!isdefined(self.pers["killed_players"][var_05]))
	{
		self.pers["killed_players"][var_05] = 0;
	}

	if(!isdefined(self.killedplayerscurrent[var_05]))
	{
		self.killedplayerscurrent[var_05] = 0;
	}

	if(!isdefined(param_01.pers["killed_by"][var_07]))
	{
		param_01.pers["killed_by"][var_07] = 0;
	}

	self.pers["killed_players"][var_05]++;
	self.killedplayerscurrent[var_05]++;
	addnemesisscoreforplayer(var_05,1);
	param_01.pers["killed_by"][var_07]++;
	param_01.lastkilledby = self;
	param_01 addnemesisscoreforplayer(var_07,1.5);
	if(self.pers["prey_guid"] == "" || self.pers["killed_players"][var_05] > self.pers["killed_players"][self.pers["prey_guid"]])
	{
		self.pers["prey_guid"] = var_05;
	}
}

//Function Number: 5
ispointblank(param_00,param_01)
{
	if(maps\mp\_utility::isbulletdamage(param_01))
	{
		var_02 = self.origin;
		var_03 = 9216;
		if(isdefined(param_00.attackerposition))
		{
			var_02 = param_00.attackerposition;
		}

		if(distancesquared(var_02,param_00.origin) < var_03)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 6
pointblankevent(param_00,param_01,param_02)
{
	maps\mp\_utility::incplayerstat("pointblank",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("pointblank",self,param_01,undefined,param_02);
	if(maps\mp\_utility::_hasperk("specialty_quieter"))
	{
		maps\mp\gametypes\_misions::processchallenge("ch_deadsilence");
	}
}

//Function Number: 7
killedplayerevent(param_00,param_01,param_02)
{
	maps\mp\_utility::incplayerstat("kills",1);
	maps\mp\_utility::incpersstat("kills",1);
	self.kills = maps\mp\_utility::getpersstat("kills");
	maps\mp\gametypes\_persistence::statsetchild("round","kills",self.kills);
	maps\mp\_utility::updatepersratio("kdRatio","kills","deaths");
	var_03 = "kill";
	switch(param_01)
	{
		case "artillery_mp":
			break;

		case "cobra_20mm_mp":
		case "hind_ffar_mp":
		case "cobra_ffar_mp":
			break;
	}
}

//Function Number: 8
isthinkfast(param_00,param_01)
{
	if(maps\mp\_utility::is_true(self.assistedsuicide))
	{
		return 0;
	}

	if(param_01 == "MOD_IMPACT" || param_01 == "MOD_HEAD_SHOT")
	{
		if(isthinkfastweapon(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
isthinkfastweapon(param_00)
{
	switch(param_00)
	{
		case "h1_flashgrenade_mp":
		case "h1_concussiongrenade_mp":
		case "h1_smokegrenade_mp":
		case "h1_fraggrenade_mp":
			break;

		default:
			break;
	}
}

//Function Number: 10
thinkfastevent()
{
	maps\mp\_utility::incplayerstat("think_fast",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("think_fast",self);
}

//Function Number: 11
earnedkillstreakevent(param_00,param_01,param_02,param_03)
{
	maps\mp\_utility::incplayerstat(param_00 + "_earned",1);
	level thread maps\mp\gametypes\_rank::awardgameevent(param_00 + "_earned",self);
	thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(param_00,param_01,undefined,param_02,param_03);
}

//Function Number: 12
bulletpenetrationevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("bulletpenkills",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("bulletpen",self);
	maps\mp\gametypes\_misions::processchallenge("ch_xrayvision");
	if(maps\mp\_utility::_hasperk("specialty_bulletpenetration"))
	{
		maps\mp\gametypes\_misions::processchallenge("ch_deepimpact");
	}
}

//Function Number: 13
multikillonebulletevent()
{
	maps\mp\_utility::incplayerstat("multiKillOneBullet",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("multiKillOneBullet",self);
}

//Function Number: 14
checkweaponspecifickill(param_00,param_01,param_02)
{
}

//Function Number: 15
neardeathkillevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("near_death_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("near_death_kill",self,param_00,undefined,param_01);
	if(maps\mp\_utility::_hasperk("specialty_armorvest"))
	{
		maps\mp\gametypes\_misions::processchallenge("ch_juggernaut");
	}
}

//Function Number: 16
flashedkillevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("flash_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("flash_kill",self,param_00,undefined,param_01);
}

//Function Number: 17
isoneshotkill(param_00,param_01,param_02)
{
	if(param_00.attackers.size != 1)
	{
		return 0;
	}

	if(!isdefined(param_00.attackers[self.guid]))
	{
		return 0;
	}

	if(maps\mp\_utility::ismeleemod(param_02))
	{
		return 0;
	}

	if(gettime() != param_00.attackerdata[self.guid].firsttimedamaged)
	{
		return 0;
	}

	var_03 = maps\mp\_utility::getweaponclass(param_01);
	if(var_03 == "weapon_sniper" || var_03 == "weapon_shotgun")
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
islongshot(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03.agentbody))
	{
		return 0;
	}

	var_04 = self.origin;
	if(isdefined(param_03.attackerposition))
	{
		var_04 = param_03.attackerposition;
	}

	if(isalive(param_00) && !param_00 maps\mp\_utility::isusingremote() && param_02 == "MOD_RIFLE_BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_HEAD_SHOT" || issubstr(param_01,"exocrossbow") || issubstr(param_01,"m990") && !maps\mp\_utility::iskillstreakweapon(param_01) && !isdefined(param_00.assistedsuicide))
	{
		var_05 = maps\mp\_utility::getweaponclass(param_01);
		switch(var_05)
		{
			case "weapon_pistol":
				break;

			case "weapon_smg":
				break;

			case "weapon_heavy":
			case "weapon_assault":
				break;

			case "weapon_sniper":
				break;

			case "weapon_shotgun":
				break;

			case "weapon_projectile":
			default:
				break;
		}
	}
}

//Function Number: 19
isresuce(param_00,param_01)
{
	if(!level.teambased)
	{
		return 0;
	}

	foreach(var_04, var_03 in param_00.damagedplayers)
	{
		if(var_04 != self.guid && param_01 - var_03 < 500)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 20
longshotevent(param_00,param_01,param_02)
{
	self.modifiers["longshot"] = 1;
	maps\mp\_utility::incplayerstat("longshots",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("longshot",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"longshot");
}

//Function Number: 21
headshotevent(param_00,param_01,param_02)
{
	self.modifiers["headshot"] = 1;
	maps\mp\_utility::incpersstat("headshots",1);
	maps\mp\_utility::incplayerstat("headshots",1);
	maps\mp\gametypes\_persistence::statsetchild("round","headshots",maps\mp\_utility::clamptoshort(self.pers["headshots"]));
	self.headshots = maps\mp\_utility::getpersstat("headshots");
	level thread maps\mp\gametypes\_rank::awardgameevent("headshot",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"headshot");
	if(!isdefined(self.headhuntercounter))
	{
		self.headhuntercounter = 1;
	}

	if(isdefined(self.headshots) && self.headshots >= self.headhuntercounter * 10)
	{
		maps\mp\gametypes\_misions::processchallenge("ch_headhunter");
		self.headhuntercounter++;
	}
}

//Function Number: 22
isthrowbackevent(param_00,param_01,param_02)
{
	if(!isexplosivedamagemod(param_02))
	{
		return 0;
	}

	if(!issubstr(param_01,"h1_frag"))
	{
		return 0;
	}

	if(isdefined(param_00) && isdefined(param_00.explosiveinfo) && isdefined(param_00.explosiveinfo["throwbackKill"]) && param_00.explosiveinfo["throwbackKill"])
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
throwbackkillevent()
{
	maps\mp\_utility::incplayerstat("throwback_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("throwback_kill",self);
}

//Function Number: 24
avengedplayerevent(param_00,param_01,param_02)
{
	self.modifiers["avenger"] = 1;
	maps\mp\_utility::incplayerstat("avengekills",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("avenger",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"avenger");
	maps\mp\gametypes\_misions::processchallenge("ch_avenger");
}

//Function Number: 25
assistedsuicideevent(param_00,param_01,param_02)
{
	self.modifiers["assistedsuicide"] = 1;
	maps\mp\_utility::incplayerstat("assistedsuicide",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("assistedsuicide",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"assistedsuicide");
}

//Function Number: 26
defendedplayerevent(param_00,param_01,param_02)
{
	self.modifiers["defender"] = 1;
	maps\mp\_utility::incplayerstat("rescues",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("defender",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"defender");
	maps\mp\gametypes\_misions::processchallenge("ch_savior");
}

//Function Number: 27
defendobjectiveevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("defends",1);
	maps\mp\_utility::incpersstat("defends",1);
	maps\mp\gametypes\_persistence::statsetchild("round","defends",self.pers["defends"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("defend",self);
	param_00 thread maps\mp\_matchdata::logkillevent(param_01,"assaulting");
}

//Function Number: 28
assaultobjectiveevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("assault",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("assault",self);
	param_00 thread maps\mp\_matchdata::logkillevent(param_01,"defending");
}

//Function Number: 29
postdeathkillevent(param_00)
{
	self.modifiers["posthumous"] = 1;
	maps\mp\_utility::incplayerstat("posthumous",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("posthumous",self);
	thread maps\mp\_matchdata::logkillevent(param_00,"posthumous");
	maps\mp\gametypes\_misions::processchallenge("ch_afterlife");
}

//Function Number: 30
isbackstabevent(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::ismeleemod(param_02))
	{
		return 0;
	}

	if(maps\mp\gametypes\_weapons::isriotshield(param_01))
	{
		return 0;
	}

	var_03 = param_00 getplayerangles();
	var_04 = self getplayerangles();
	var_05 = angleclamp180(var_03[1] - var_04[1]);
	if(abs(var_05) < 75)
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
backstabevent(param_00)
{
	maps\mp\_utility::incplayerstat("backstab",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("backstab",self);
	maps\mp\gametypes\_misions::processchallenge("ch_backstab");
}

//Function Number: 32
revengeevent(param_00)
{
	self.modifiers["revenge"] = 1;
	self.lastkilledby = undefined;
	maps\mp\_utility::incplayerstat("revengekills",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("revenge",self);
	thread maps\mp\_matchdata::logkillevent(param_00,"revenge");
	maps\mp\gametypes\_misions::processchallenge("ch_revenge");
}

//Function Number: 33
multikillevent(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = maps\mp\gametypes\_misions::get_challenge_weapon_class(param_02);
	var_05 = maps\mp\_utility::getbaseweaponname(param_02);
	if(maps\mp\_utility::islootweapon(var_05))
	{
		var_05 = maps\mp\gametypes\_class::getbasefromlootversion(var_05);
	}

	var_06 = "";
	if(common_scripts\utility::string_starts_with(var_05,"iw5_"))
	{
		var_06 = getsubstr(var_05,4);
	}
	else if(common_scripts\utility::string_starts_with(var_05,"h1_"))
	{
		var_06 = getsubstr(var_05,3);
	}

	switch(param_01)
	{
		case 2:
			break;

		case 3:
			break;

		case 4:
			break;

		case 5:
			break;

		case 6:
			break;

		case 7:
			break;

		case 8:
			break;

		default:
			break;
	}
}

//Function Number: 34
takeandkillevent()
{
	maps\mp\_utility::incplayerstat("take_and_kill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("take_and_kill",self);
	maps\mp\gametypes\_misions::processchallenge("ch_backfire");
	if(maps\mp\_utility::getmapname() == "mp_bog_summer")
	{
		maps\mp\gametypes\_misions::processchallenge("ch_summer_backfire");
	}
}

//Function Number: 35
setuplinkstats()
{
	var_00 = maps\mp\_utility::getplayerstat("fieldgoal") + maps\mp\_utility::getplayerstat("touchdown") * 2;
	maps\mp\gametypes\_persistence::statsetchild("round","captures",var_00);
	maps\mp\_utility::setextrascore0(var_00);
}

//Function Number: 36
flagpickupevent()
{
	thread maps\mp\_utility::teamplayercardsplash("callout_flagpickup",self);
	maps\mp\_utility::incplayerstat("flagscarried",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("flag_pickup",self);
	thread maps\mp\_matchdata::loggameevent("pickup",self.origin);
}

//Function Number: 37
flagcaptureevent()
{
	thread maps\mp\_utility::teamplayercardsplash("callout_flagcapture",self);
	maps\mp\_utility::incplayerstat("flagscaptured",1);
	maps\mp\_utility::incpersstat("captures",1);
	maps\mp\gametypes\_persistence::statsetchild("round","captures",self.pers["captures"]);
	maps\mp\_utility::setextrascore0(self.pers["captures"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("flag_capture",self);
	thread maps\mp\_matchdata::loggameevent("capture",self.origin);
}

//Function Number: 38
flagreturnevent()
{
	thread maps\mp\_utility::teamplayercardsplash("callout_flagreturn",self);
	maps\mp\_utility::incplayerstat("flagsreturned",1);
	maps\mp\_utility::incpersstat("returns",1);
	self.assists = self.pers["returns"];
	maps\mp\gametypes\_persistence::statsetchild("round","returns",self.pers["returns"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("flag_return",self);
	thread maps\mp\_matchdata::loggameevent("return",self.origin);
}

//Function Number: 39
killwithflagevent()
{
	maps\mp\_utility::incplayerstat("killsasflagcarrier",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("kill_with_flag",self);
}

//Function Number: 40
killflagcarrierevent(param_00)
{
	thread maps\mp\_utility::teamplayercardsplash("callout_killflagcarrier",self);
	maps\mp\_utility::incplayerstat("flagcarrierkills",1);
	maps\mp\_utility::incpersstat("defends",1);
	maps\mp\gametypes\_persistence::statsetchild("round","defends",self.pers["defends"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("kill_flag_carrier",self);
	thread maps\mp\_matchdata::logkillevent(param_00,"carrying");
}

//Function Number: 41
killdeniedevent(param_00)
{
	maps\mp\_utility::incplayerstat("killsdenied",1);
	maps\mp\_utility::incpersstat("denied",1);
	maps\mp\_utility::setextrascore1(self.pers["denied"]);
	maps\mp\gametypes\_persistence::statsetchild("round","denied",self.pers["denied"]);
	var_01 = "kill_denied";
	if(param_00)
	{
		var_01 = "kill_denied_retrieved";
		maps\mp\_utility::incplayerstat("kill_denied_retrieved",1);
		maps\mp\gametypes\_misions::processchallenge("ch_save_yourself");
	}

	level thread maps\mp\gametypes\_rank::awardgameevent(var_01,self);
	maps\mp\gametypes\_misions::processchallenge("ch_denial");
}

//Function Number: 42
killconfirmedevent()
{
	maps\mp\_utility::incplayerstat("killsconfirmed",1);
	maps\mp\_utility::incpersstat("confirmed",1);
	maps\mp\_utility::setextrascore0(self.pers["confirmed"]);
	maps\mp\gametypes\_persistence::statsetchild("round","confirmed",self.pers["confirmed"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("kill_confirmed",self);
	maps\mp\gametypes\_misions::processchallenge("ch_collector");
}

//Function Number: 43
tagcollectorevent()
{
	maps\mp\_utility::incplayerstat("tag_collector",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("tag_collector",self);
}

//Function Number: 44
monitortagcollector(param_00)
{
	if(!isplayer(param_00))
	{
		return;
	}

	param_00 notify("tagCollector");
	param_00 endon("tagCollector");
	if(!isdefined(param_00.tagcollectortotal))
	{
		param_00.tagcollectortotal = 0;
	}

	param_00.tagcollectortotal++;
	if(param_00.tagcollectortotal > 2)
	{
		param_00 tagcollectorevent();
		param_00.tagcollectortotal = 0;
	}

	wait(2.5);
	if(isdefined(param_00))
	{
		param_00.tagcollectortotal = 0;
	}
}

//Function Number: 45
bombplantevent()
{
	maps\mp\_utility::incplayerstat("bombsplanted",1);
	maps\mp\_utility::incpersstat("plants",1);
	maps\mp\gametypes\_persistence::statsetchild("round","plants",self.pers["plants"]);
	maps\mp\_utility::setextrascore0(self.pers["plants"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted",self);
	level thread maps\mp\gametypes\_rank::awardgameevent("plant",self);
	thread maps\mp\_matchdata::loggameevent("plant",self.origin);
}

//Function Number: 46
bombdefuseevent(param_00)
{
	maps\mp\_utility::incplayerstat("bombsdefused",1);
	maps\mp\_utility::incpersstat("defuses",1);
	maps\mp\gametypes\_persistence::statsetchild("round","defuses",self.pers["defuses"]);
	maps\mp\_utility::setextrascore1(self.pers["defuses"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_bombdefused",self);
	if(param_00 == "ninja_defuse" || param_00 == "last_man_defuse")
	{
		maps\mp\_utility::incplayerstat(param_00,1);
		if(param_00 == "ninja_defuse" && isdefined(level.bombowner) && level.bombowner.bombplantedtime + 6000 + level.defusetime * 1000 > gettime())
		{
			maps\mp\gametypes\_misions::processchallenge("ch_ninja");
		}
	}

	level thread maps\mp\gametypes\_rank::awardgameevent(param_00,self);
	thread maps\mp\_matchdata::loggameevent("defuse",self.origin);
}

//Function Number: 47
eliminateplayerevent(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("elimination",1);
	level thread maps\mp\_utility::teamplayercardsplash("callout_eliminated",param_01);
	if(param_00)
	{
		maps\mp\_utility::incplayerstat("last_man_standing",1);
		level thread maps\mp\gametypes\_rank::awardgameevent("last_man_standing",self);
		return;
	}

	level thread maps\mp\gametypes\_rank::awardgameevent("elimination",self);
}

//Function Number: 48
bombdetonateevent()
{
	maps\mp\_utility::incplayerstat("targetsdestroyed",1);
	maps\mp\_utility::incpersstat("destructions",1);
	maps\mp\gametypes\_persistence::statsetchild("round","destructions",self.pers["destructions"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_objective",self);
	level thread maps\mp\gametypes\_rank::awardgameevent("destroy",self);
	maps\mp\gametypes\_misions::processchallenge("ch_sd_destroyer");
}

//Function Number: 49
increasegunlevelevent()
{
	maps\mp\_utility::incplayerstat("levelup",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("gained_gun_score",self);
}

//Function Number: 50
decreasegunlevelevent()
{
	maps\mp\_utility::incplayerstat("dejavu",1);
	maps\mp\_utility::incpersstat("setbacks",1);
	maps\mp\gametypes\_persistence::statsetchild("round","setbacks",self.pers["setbacks"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("dropped_gun_score",self);
}

//Function Number: 51
setbackenemygunlevelevent()
{
	maps\mp\_utility::incplayerstat("humiliation",1);
	maps\mp\_utility::incpersstat("humiliations",1);
	maps\mp\gametypes\_persistence::statsetchild("round","humiliations",self.pers["humiliations"]);
	level thread maps\mp\gametypes\_rank::awardgameevent("dropped_enemy_gun_rank",self);
}

//Function Number: 52
quickgunlevelevent()
{
	maps\mp\_utility::incplayerstat("gunslinger",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("quick_gun_rank",self);
}

//Function Number: 53
setbackfirstplayergunlevelevent()
{
	maps\mp\_utility::incplayerstat("regicide",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("dropped_first_player_gun_rank",self);
}

//Function Number: 54
domcaptureevent(param_00)
{
	maps\mp\_utility::incplayerstat("pointscaptured",1);
	maps\mp\_utility::incpersstat("captures",1);
	maps\mp\gametypes\_persistence::statsetchild("round","captures",self.pers["captures"]);
	maps\mp\_utility::setextrascore0(self.pers["captures"]);
	var_01 = "capture";
	if(param_00)
	{
		var_01 = "opening_move";
		maps\mp\_utility::incplayerstat("opening_move",1);
	}

	level thread maps\mp\gametypes\_rank::awardgameevent(var_01,self);
	thread maps\mp\_matchdata::loggameevent("capture",self.origin);
	maps\mp\gametypes\_misions::processchallenge("ch_dom_aggression");
}

//Function Number: 55
domneutralizeevent()
{
	level thread maps\mp\gametypes\_rank::awardgameevent("neutralize",self);
}

//Function Number: 56
killwhilecapture(param_00,param_01)
{
	maps\mp\_utility::incplayerstat("assault",1);
	maps\mp\_utility::incplayerstat("kill_while_capture",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("kill_while_capture",self);
	param_00 thread maps\mp\_matchdata::logkillevent(param_01,"defending");
}

//Function Number: 57
securehardpointevent()
{
	maps\mp\_utility::incplayerstat("hp_secure",1);
	maps\mp\_utility::incpersstat("captures",1);
	maps\mp\gametypes\_persistence::statsetchild("round","captures",self.pers["captures"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_hp_captured_by",self);
	level thread maps\mp\gametypes\_rank::awardgameevent("hp_secure",self);
	thread maps\mp\_matchdata::loggameevent("capture",self.origin);
}

//Function Number: 58
holdhardpointevent()
{
	maps\mp\_utility::incpersstat("captureTime",1);
	maps\mp\gametypes\_persistence::statsetchild("round","captureTime",self.pers["captureTime"]);
	maps\mp\_utility::setextrascore0(self.pers["captureTime"]);
}

//Function Number: 59
hqcaptureevent()
{
	maps\mp\_utility::incplayerstat("hqscaptured",1);
	maps\mp\_utility::incpersstat("captures",1);
	maps\mp\gametypes\_persistence::statsetchild("round","captures",self.pers["captures"]);
	maps\mp\_utility::setextrascore0(self.pers["captures"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_capturedhq",self);
	level thread maps\mp\gametypes\_rank::awardgameevent("hq_secure",self);
	thread maps\mp\_matchdata::loggameevent("capture",self.origin);
	maps\mp\gametypes\_misions::processchallenge("ch_hq_aggression");
}

//Function Number: 60
hqdestroyevent()
{
	maps\mp\_utility::incplayerstat("hqsdestroyed",1);
	maps\mp\_utility::incpersstat("destructions",1);
	maps\mp\gametypes\_persistence::statsetchild("round","destructions",self.pers["destructions"]);
	maps\mp\_utility::setextrascore1(self.pers["destructions"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_destroyedhq",self);
	level thread maps\mp\gametypes\_rank::awardgameevent("hq_destroy",self);
	thread maps\mp\_matchdata::loggameevent("destroy",self.origin);
	maps\mp\gametypes\_misions::processchallenge("ch_hq_destroyer");
}

//Function Number: 61
firstbloodevent(param_00,param_01,param_02)
{
	self.modifiers["firstblood"] = 1;
	maps\mp\_utility::incplayerstat("firstblood",1);
	thread maps\mp\_utility::teamplayercardsplash("callout_firstblood",self);
	level thread maps\mp\gametypes\_rank::awardgameevent("firstblood",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"firstblood");
}

//Function Number: 62
isbuzzkillevent(param_00)
{
	var_01 = param_00.pers["cur_kill_streak"];
	if(var_01 == 2 || var_01 == 4 || var_01 == 6)
	{
		return 1;
	}

	return 0;
}

//Function Number: 63
buzzkillevent(param_00,param_01,param_02,param_03)
{
	self.modifiers["buzzkill"] = param_01.pers["cur_kill_streak"];
	maps\mp\_utility::incplayerstat("buzzkill",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("buzzkill",self,param_02,undefined,param_03);
}

//Function Number: 64
oneshotkillevent(param_00,param_01,param_02)
{
	self.modifiers["oneshotkill"] = 1;
	maps\mp\_utility::incplayerstat("oneshotkill",1);
	maps\mp\gametypes\_misions::processchallenge("ch_deadeye");
}

//Function Number: 65
comebackevent(param_00,param_01,param_02)
{
	self.modifiers["comeback"] = 1;
	maps\mp\_utility::incplayerstat("comebacks",1);
	level thread maps\mp\gametypes\_rank::awardgameevent("comeback",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"comeback");
}

//Function Number: 66
choosenextbestnemesis()
{
	var_00 = self.pers["nemesis_tracking"];
	var_01 = getarraykeys(var_00);
	var_02 = "";
	var_03 = 0;
	foreach(var_05 in var_01)
	{
		var_06 = self.pers["nemesis_tracking"][var_05];
		if(var_06 > var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	self.pers["nemesis_guid"] = var_02;
}

//Function Number: 67
choosenextbestprey()
{
	var_00 = self.pers["killed_players"];
	var_01 = getarraykeys(var_00);
	var_02 = "";
	var_03 = 0;
	foreach(var_05 in var_01)
	{
		var_06 = self.pers["killed_players"][var_05];
		if(var_06 > var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	self.pers["prey_guid"] = var_02;
}

//Function Number: 68
disconnected()
{
	var_00 = self.guid;
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(isdefined(level.players[var_01].pers["killed_players"][var_00]))
		{
			level.players[var_01].pers["killed_players"][var_00] = undefined;
		}

		if(isdefined(level.players[var_01].killedplayerscurrent[var_00]))
		{
			level.players[var_01].killedplayerscurrent[var_00] = undefined;
		}

		if(isdefined(level.players[var_01].pers["killed_by"][var_00]))
		{
			level.players[var_01].pers["killed_by"][var_00] = undefined;
		}

		if(isdefined(level.players[var_01].pers["nemesis_tracking"][var_00]))
		{
			level.players[var_01].pers["nemesis_tracking"][var_00] = undefined;
		}

		if(isdefined(level.players[var_01].pers["nemesis_guid"]) && level.players[var_01].pers["nemesis_guid"] == var_00)
		{
			level.players[var_01] choosenextbestnemesis();
		}

		if(isdefined(level.players[var_01].pers["prey_guid"]) && level.players[var_01].pers["prey_guid"] == var_00)
		{
			level.players[var_01] choosenextbestprey();
		}

		if(isdefined(level.players[var_01].attackers) && isdefined(level.players[var_01].attackers[var_00]))
		{
			level.players[var_01].attackers[var_00] = undefined;
		}

		if(isdefined(level.players[var_01].attackerdata) && isdefined(level.players[var_01].attackerdata[var_00]))
		{
			level.players[var_01].attackerdata[var_00] = undefined;
		}

		if(isdefined(level.players[var_01].enemyhitcounts) && isdefined(level.players[var_01].enemyhitcounts[var_00]))
		{
			level.players[var_01].enemyhitcounts[var_00] = undefined;
		}
	}
}

//Function Number: 69
updaterecentkills(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	self endon("disconnect");
	level endon("game_ended");
	self notify("updateRecentKills");
	self endon("updateRecentKills");
	self.recentkillcount++;
	var_02 = 0;
	if(self playerads() >= 0.2)
	{
		var_02 = 1;
	}

	wait(2);
	if(self.recentkillcount > 1)
	{
		multikillevent(param_00,self.recentkillcount,param_01,var_02);
	}

	self.recentkillcount = 0;
}

//Function Number: 70
checkvandalismmedal(param_00)
{
	if(isdefined(level.ishorde))
	{
		return;
	}

	if(!isdefined(self.attackerlist))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	var_01 = self.owner;
	if(!isdefined(var_01))
	{
		var_01 = self;
	}

	foreach(var_03 in self.attackerlist)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 == var_01)
		{
			continue;
		}

		if(var_03 == param_00)
		{
			continue;
		}

		if(var_03.team == self.team)
		{
			continue;
		}

		var_03 maps\mp\_utility::incplayerstat("assist_killstreak_destroyed",1);
		level thread maps\mp\gametypes\_rank::awardgameevent("assist_killstreak_destroyed",var_03);
	}
}

//Function Number: 71
checkstreakingevents(param_00)
{
	var_01 = self.killstreakcount + 1;
	if(var_01 % 5 && var_01 < 30)
	{
		return;
	}

	switch(var_01)
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

//Function Number: 72
checkhigherrankkillevents(param_00)
{
	if(maps\mp\_utility::gettimepassed() < 90000)
	{
		return;
	}

	var_01 = level.players;
	if(level.teambased)
	{
		var_01 = level.teamlist[maps\mp\_utility::getotherteam(self.team)];
	}

	if(var_01.size < 3)
	{
		return;
	}

	var_02 = common_scripts\utility::array_sort_with_func(var_01,::is_score_a_greater_than_b);
	if(isdefined(var_02[0]) && param_00 == var_02[0])
	{
		maps\mp\_utility::incplayerstat("firstplacekill",1);
		level thread maps\mp\gametypes\_rank::awardgameevent("firstplacekill",self);
		maps\mp\gametypes\_misions::processchallenge("ch_kingslayer");
	}
}

//Function Number: 73
is_score_a_greater_than_b(param_00,param_01)
{
	return param_00.score > param_01.score;
}

//Function Number: 74
processassistevent(param_00,param_01)
{
	if(isdefined(level.assists_disabled) && level.assists_disabled)
	{
		return;
	}

	var_02 = "assist";
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	self endon("disconnect");
	param_00 endon("disconnect");
	wait(0.05);
	if(self.team != "axis" && self.team != "allies")
	{
		return;
	}

	if(level.teambased && self.team == param_00.team)
	{
		return;
	}

	level thread maps\mp\gametypes\_rank::awardgameevent(var_02,self,undefined,param_00);
	param_00 maps\mp\_matchdata::logspecialassists(self,var_02);
	if(var_02 == "assist")
	{
		maps\mp\_utility::incplayerstat("assists",1);
		maps\mp\_utility::incpersstat("assists",1);
		if(!maps\mp\_utility::is_true(level.assists_count_disabled))
		{
			self.assists = maps\mp\_utility::getpersstat("assists");
		}

		maps\mp\gametypes\_persistence::statsetchild("round","assists",self.assists);
		thread maps\mp\gametypes\_misions::playerassist();
	}
}

//Function Number: 75
stoppingpowerevent()
{
	maps\mp\gametypes\_misions::processchallenge("ch_stoppingpower");
}

//Function Number: 76
sleightofhandeventwatcher()
{
	self endon("death");
	self endon("disconnect");
	self endon("sleightOfHandEventEnd");
	level endon("game_ended");
	var_00 = common_scripts\utility::waittill_any_return("sleightOfHandEventEarned","sleightOfHandEventFailed");
	if(var_00 == "sleightOfHandEventEarned")
	{
		maps\mp\gametypes\_misions::processchallenge("ch_sleightofhand");
	}

	self.sleightofhandeventweap = undefined;
}

//Function Number: 77
sleightofhandtimer()
{
	self endon("death");
	self endon("disconnect");
	self endon("sleightOfHandEventEnd");
	self endon("sleightOfHandEventEarned");
	level endon("game_ended");
	wait(3);
	if(isdefined(self))
	{
		self notify("sleightOfHandEventFailed");
	}
}

//Function Number: 78
sleightofhandreloadwatch(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("sleightOfHandEventEnd");
	self endon("sleightOfHandEventFailed");
	level endon("game_ended");
	thread sleightofhandtimer();
	self waittill("reload");
	if(isdefined(self))
	{
		self.sleightofhandeventweap = param_00;
	}
}

//Function Number: 79
sleightofhandevent(param_00,param_01)
{
	if(!isdefined(self.sleightofhandeventweap))
	{
		self notify("sleightOfHandEventEnd");
		thread sleightofhandeventwatcher();
		thread sleightofhandreloadwatch(param_00);
		return;
	}

	if(param_00 == self.sleightofhandeventweap)
	{
		self notify("sleightOfHandEventEarned");
	}
}

//Function Number: 80
doubletapevent()
{
	maps\mp\gametypes\_misions::processchallenge("ch_doubletap");
}

//Function Number: 81
overkillevent()
{
	maps\mp\gametypes\_misions::processchallenge("ch_overkill");
}

//Function Number: 82
uavjammerevent()
{
	maps\mp\gametypes\_misions::processchallenge("ch_uavjammer");
}

//Function Number: 83
sonicboomevent()
{
	maps\mp\gametypes\_misions::processchallenge("ch_sonicboom");
}

//Function Number: 84
steadyaimevent()
{
	maps\mp\gametypes\_misions::processchallenge("ch_steadyaim");
}

//Function Number: 85
laststandevent()
{
	maps\mp\gametypes\_misions::processchallenge("ch_laststand");
}

//Function Number: 86
ironlungsevent()
{
	maps\mp\gametypes\_misions::processchallenge("ch_ironlungs");
}

//Function Number: 87
eavesdropevent()
{
	maps\mp\gametypes\_misions::processchallenge("ch_eavesdrop");
}