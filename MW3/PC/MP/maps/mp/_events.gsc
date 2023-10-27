/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_events.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 538 ms
 * Timestamp: 10/27/2023 2:15:00 AM
*******************************************************************/

//Function Number: 1
init()
{
	maps\mp\gametypes\_rank::registerscoreinfo("headshot",50);
	maps\mp\gametypes\_rank::registerscoreinfo("execution",100);
	maps\mp\gametypes\_rank::registerscoreinfo("avenger",50);
	maps\mp\gametypes\_rank::registerscoreinfo("defender",50);
	maps\mp\gametypes\_rank::registerscoreinfo("posthumous",25);
	maps\mp\gametypes\_rank::registerscoreinfo("revenge",50);
	maps\mp\gametypes\_rank::registerscoreinfo("double",50);
	maps\mp\gametypes\_rank::registerscoreinfo("triple",75);
	maps\mp\gametypes\_rank::registerscoreinfo("multi",100);
	maps\mp\gametypes\_rank::registerscoreinfo("buzzkill",100);
	maps\mp\gametypes\_rank::registerscoreinfo("firstblood",100);
	maps\mp\gametypes\_rank::registerscoreinfo("comeback",100);
	maps\mp\gametypes\_rank::registerscoreinfo("longshot",50);
	maps\mp\gametypes\_rank::registerscoreinfo("assistedsuicide",100);
	maps\mp\gametypes\_rank::registerscoreinfo("knifethrow",100);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("damage",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("heavy_damage",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("damaged",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("kill",1);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("killed",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("healed",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("headshot",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("melee",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("backstab",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("longshot",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("assistedsuicide",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("defender",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("avenger",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("execution",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("comeback",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("revenge",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("buzzkill",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("double",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("triple",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("multi",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("assist",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("firstBlood",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("capture",1);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("assistedCapture",1);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("plant",1);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("defuse",1);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("vehicleDestroyed",1);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("3streak",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("4streak",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("5streak",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("6streak",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("7streak",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("8streak",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("9streak",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("10streak",0);
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("regen",0);
	precacheshader("crosshair_red");
	level._effect["money"] = loadfx("props/cash_player_drop");
	level.numkills = 0;
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.killedplayers = [];
		var_00.killedplayerscurrent = [];
		var_00.killedby = [];
		var_00.lastkilledby = undefined;
		var_00.greatestuniqueplayerkills = 0;
		var_00.recentkillcount = 0;
		var_00.lastkilltime = 0;
		var_00.damagedplayers = [];
		var_00 thread monitorcratejacking();
		var_00 thread monitorobjectives();
		var_00 thread monitorhealed();
	}
}

//Function Number: 3
damagedplayer(param_00,param_01,param_02)
{
	if(param_01 < 50 && param_01 > 10)
	{
		maps\mp\killstreaks\_killstreaks::giveadrenaline("damage");
		return;
	}

	maps\mp\killstreaks\_killstreaks::giveadrenaline("heavy_damage");
}

//Function Number: 4
killedplayer(param_00,param_01,param_02,param_03)
{
	var_04 = param_01.guid;
	var_05 = self.guid;
	var_06 = gettime();
	thread updaterecentkills(param_00);
	self.lastkilltime = gettime();
	self.lastkilledplayer = param_01;
	self.modifiers = [];
	level.numkills++;
	self.damagedplayers[var_04] = undefined;
	if(!maps\mp\_utility::iskillstreakweapon(param_02) && !maps\mp\_utility::isjuggernaut() && !maps\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		if(param_02 == "none")
		{
			return 0;
		}

		if(isdefined(self.pers["copyCatLoadout"]) && isdefined(self.pers["copyCatLoadout"]["owner"]))
		{
			if(param_01 == self.pers["copyCatLoadout"]["owner"])
			{
				self.modifiers["clonekill"] = 1;
			}
		}

		if(param_01.attackers.size == 1 && !isdefined(param_01.attackers[param_01.guid]))
		{
			var_0A = maps\mp\_utility::getweaponclass(param_02);
			if(var_0A == "weapon_sniper" && param_03 != "MOD_MELEE" && gettime() == param_01.attackerdata[self.guid].firsttimedamaged)
			{
				self.modifiers["oneshotkill"] = 1;
				thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_ONE_SHOT_KILL");
			}
		}

		if(isdefined(param_01.throwinggrenade) && param_01.throwinggrenade == "frag_grenade_mp")
		{
			self.modifiers["cooking"] = 1;
		}

		if(isdefined(self.assistedsuicide) && self.assistedsuicide)
		{
			assistedsuicide(param_00,param_02,param_03);
		}

		if(level.numkills == 1)
		{
			firstblood(param_00,param_02,param_03);
		}

		if(self.pers["cur_death_streak"] > 3)
		{
			comeback(param_00,param_02,param_03);
		}

		if(param_03 == "MOD_HEAD_SHOT")
		{
			if(isdefined(param_01.laststand))
			{
				execution(param_00,param_02,param_03);
			}
			else
			{
				headshot(param_00,param_02,param_03);
			}
		}

		if(isdefined(self.wasti) && self.wasti && gettime() - self.spawntime <= 5000)
		{
			self.modifiers["jackintheboxkill"] = 1;
		}

		if(!isalive(self) && self.deathtime + 800 < gettime())
		{
			postdeathkill(param_00);
		}

		var_0B = 0;
		if(level.teambased && var_06 - param_01.lastkilltime < 500)
		{
			if(param_01.lastkilledplayer != self)
			{
				avengedplayer(param_00,param_02,param_03);
			}
		}

		foreach(var_0E, var_0D in param_01.damagedplayers)
		{
			if(var_0E == self.guid)
			{
				continue;
			}

			if(level.teambased && var_06 - var_0D < 500)
			{
				defendedplayer(param_00,param_02,param_03);
			}
		}

		if(isdefined(param_01.attackerposition))
		{
			var_0F = param_01.attackerposition;
		}
		else
		{
			var_0F = self.origin;
		}

		if(islongshot(self,param_02,param_03,var_0F,param_01))
		{
			thread longshot(param_00,param_02,param_03);
		}

		if(param_01.pers["cur_kill_streak"] > 0 && isdefined(param_01.killstreaks[param_01.pers["cur_kill_streak"] + 1]))
		{
			buzzkill(param_00,param_01,param_02,param_03);
		}

		thread checkmatchdatakills(param_00,param_01,param_02,param_03);
	}

	if(!isdefined(self.killedplayers[var_04]))
	{
		self.killedplayers[var_04] = 0;
	}

	if(!isdefined(self.killedplayerscurrent[var_04]))
	{
		self.killedplayerscurrent[var_04] = 0;
	}

	if(!isdefined(param_01.killedby[var_05]))
	{
		param_01.killedby[var_05] = 0;
	}

	self.killedplayers[var_04]++;
	if(self.killedplayers[var_04] > self.greatestuniqueplayerkills)
	{
		maps\mp\_utility::setplayerstat("killedsameplayer",self.killedplayers[var_04]);
	}

	self.killedplayerscurrent[var_04]++;
	param_01.killedby[var_05]++;
	param_01.lastkilledby = self;
}

//Function Number: 5
islongshot(param_00,param_01,param_02,param_03,param_04)
{
	if(isalive(param_00) && !param_00 maps\mp\_utility::isusingremote() && param_02 == "MOD_RIFLE_BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_HEAD_SHOT" && !maps\mp\_utility::iskillstreakweapon(param_01) && !isdefined(param_00.assistedsuicide))
	{
		var_05 = maps\mp\_utility::getweaponclass(param_01);
		switch(var_05)
		{
			case "weapon_pistol":
				var_06 = 800;
				break;

			case "weapon_machine_pistol":
			case "weapon_smg":
				var_06 = 1200;
				break;

			case "weapon_lmg":
			case "weapon_assault":
				var_06 = 1500;
				break;

			case "weapon_sniper":
				var_06 = 2000;
				break;

			case "weapon_shotgun":
				var_06 = 500;
				break;

			case "weapon_projectile":
			default:
				var_06 = 1536;
				break;
		}

		if(distance(param_03,param_04.origin) > var_06)
		{
			if(param_00 isitemunlocked("specialty_holdbreath") && param_00 maps\mp\_utility::_hasperk("specialty_holdbreath"))
			{
				param_00 maps\mp\gametypes\_missions::processchallenge("ch_longdistance");
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 6
checkmatchdatakills(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\_utility::getweaponclass(param_02);
	var_05 = 0;
	thread campercheck();
	if(isdefined(self.lastkilledby) && self.lastkilledby == param_01)
	{
		self.lastkilledby = undefined;
		revenge(param_00);
		playfx(level._effect["money"],param_01 gettagorigin("j_spine4"));
	}

	if(param_01.idflags & level.idflags_penetration)
	{
		maps\mp\_utility::incplayerstat("bulletpenkills",1);
	}

	if(self.pers["rank"] < param_01.pers["rank"])
	{
		maps\mp\_utility::incplayerstat("higherrankkills",1);
	}

	if(self.pers["rank"] > param_01.pers["rank"])
	{
		maps\mp\_utility::incplayerstat("lowerrankkills",1);
	}

	if(isdefined(self.infinalstand) && self.infinalstand)
	{
		maps\mp\_utility::incplayerstat("laststandkills",1);
	}

	if(isdefined(param_01.infinalstand) && param_01.infinalstand)
	{
		maps\mp\_utility::incplayerstat("laststanderkills",1);
	}

	if(self getcurrentweapon() != self.primaryweapon && self getcurrentweapon() != self.secondaryweapon)
	{
		maps\mp\_utility::incplayerstat("otherweaponkills",1);
	}

	var_06 = gettime() - param_01.spawntime;
	if(!maps\mp\_utility::matchmakinggame())
	{
		param_01 maps\mp\_utility::setplayerstatiflower("shortestlife",var_06);
	}

	param_01 maps\mp\_utility::setplayerstatifgreater("longestlife",var_06);
	if(param_03 != "MOD_MELEE")
	{
		switch(var_04)
		{
			case "weapon_pistol":
			case "weapon_projectile":
			case "weapon_shotgun":
			case "weapon_lmg":
			case "weapon_sniper":
			case "weapon_assault":
			case "weapon_smg":
				checkmatchdataweaponkills(param_01,param_02,param_03,var_04);
				break;

			case "weapon_explosive":
			case "weapon_grenade":
				checkmatchdataequipmentkills(param_01,param_02,param_03);
				break;

			default:
				break;
		}
	}
}

//Function Number: 7
checkmatchdataweaponkills(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	switch(param_03)
	{
		case "weapon_pistol":
			var_05 = "pistolkills";
			var_06 = "pistolheadshots";
			break;

		case "weapon_smg":
			var_05 = "smgkills";
			var_06 = "smgheadshots";
			break;

		case "weapon_assault":
			var_05 = "arkills";
			var_06 = "arheadshots";
			break;

		case "weapon_projectile":
			if(weaponclass(param_01) == "rocketlauncher")
			{
				var_05 = "rocketkills";
			}
			break;

		case "weapon_sniper":
			var_05 = "sniperkills";
			var_06 = "sniperheadshots";
			break;

		case "weapon_shotgun":
			var_05 = "shotgunkills";
			var_06 = "shotgunheadshots";
			var_07 = "shotgundeaths";
			break;

		case "weapon_lmg":
			var_05 = "lmgkills";
			var_06 = "lmgheadshots";
			break;

		default:
			break;
	}

	if(isdefined(var_05))
	{
		var_04 maps\mp\_utility::incplayerstat(var_05,1);
	}

	if(isdefined(var_06) && param_02 == "MOD_HEAD_SHOT")
	{
		var_04 maps\mp\_utility::incplayerstat(var_06,1);
	}

	if(isdefined(var_07) && !maps\mp\_utility::matchmakinggame())
	{
		param_00 maps\mp\_utility::incplayerstat(var_07,1);
	}

	if(var_04 playerads() > 0.5)
	{
		var_04 maps\mp\_utility::incplayerstat("adskills",1);
		if(param_03 == "weapon_sniper" || issubstr(param_01,"acog"))
		{
			var_04 maps\mp\_utility::incplayerstat("scopedkills",1);
		}

		if(issubstr(param_01,"thermal"))
		{
			var_04 maps\mp\_utility::incplayerstat("thermalkills",1);
			return;
		}

		return;
	}

	var_04 maps\mp\_utility::incplayerstat("hipfirekills",1);
}

//Function Number: 8
checkmatchdataequipmentkills(param_00,param_01,param_02)
{
	var_03 = self;
	switch(param_01)
	{
		case "frag_grenade_mp":
			var_03 maps\mp\_utility::incplayerstat("fragkills",1);
			var_03 maps\mp\_utility::incplayerstat("grenadekills",1);
			var_04 = 1;
			break;

		case "c4_mp":
			var_04 maps\mp\_utility::incplayerstat("c4kills",1);
			var_04 = 1;
			break;

		case "semtex_mp":
			var_04 maps\mp\_utility::incplayerstat("semtexkills",1);
			var_04 maps\mp\_utility::incplayerstat("grenadekills",1);
			var_04 = 1;
			break;

		case "claymore_mp":
			var_04 maps\mp\_utility::incplayerstat("claymorekills",1);
			var_04 = 1;
			break;

		case "throwingknife_mp":
			var_04 maps\mp\_utility::incplayerstat("throwingknifekills",1);
			thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_KNIFETHROW");
			var_04 = 1;
			break;

		default:
			var_04 = 0;
			break;
	}

	if(var_04)
	{
		var_03 maps\mp\_utility::incplayerstat("equipmentkills",1);
	}
}

//Function Number: 9
campercheck()
{
	self.lastkillwascamping = 0;
	if(!isdefined(self.lastkilllocation))
	{
		self.lastkilllocation = self.origin;
		self.lastcampkilltime = gettime();
		return;
	}

	if(distance(self.lastkilllocation,self.origin) < 512 && gettime() - self.lastcampkilltime > 5000)
	{
		maps\mp\_utility::incplayerstat("mostcamperkills",1);
		self.lastkillwascamping = 1;
	}

	self.lastkilllocation = self.origin;
	self.lastcampkilltime = gettime();
}

//Function Number: 10
consolation(param_00)
{
}

//Function Number: 11
proximityassist(param_00)
{
	self.modifiers["proximityAssist"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_PROXIMITYASSIST");
	thread maps\mp\gametypes\_rank::giverankxp("proximityassist");
}

//Function Number: 12
proximitykill(param_00)
{
	self.modifiers["proximityKill"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_PROXIMITYKILL");
	thread maps\mp\gametypes\_rank::giverankxp("proximitykill");
}

//Function Number: 13
longshot(param_00,param_01,param_02)
{
	self.modifiers["longshot"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_LONGSHOT");
	thread maps\mp\gametypes\_rank::giverankxp("longshot",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::giveadrenaline("longshot");
	maps\mp\_utility::incplayerstat("longshots",1);
	thread maps\mp\_matchdata::logkillevent(param_00,"longshot");
}

//Function Number: 14
execution(param_00,param_01,param_02)
{
	self.modifiers["execution"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_EXECUTION");
	thread maps\mp\gametypes\_rank::giverankxp("execution",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::giveadrenaline("execution");
	thread maps\mp\_matchdata::logkillevent(param_00,"execution");
}

//Function Number: 15
headshot(param_00,param_01,param_02)
{
	self.modifiers["headshot"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_HEADSHOT");
	thread maps\mp\gametypes\_rank::giverankxp("headshot",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::giveadrenaline("headshot");
	thread maps\mp\_matchdata::logkillevent(param_00,"headshot");
}

//Function Number: 16
avengedplayer(param_00,param_01,param_02)
{
	self.modifiers["avenger"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_AVENGER");
	thread maps\mp\gametypes\_rank::giverankxp("avenger",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::giveadrenaline("avenger");
	thread maps\mp\_matchdata::logkillevent(param_00,"avenger");
	maps\mp\_utility::incplayerstat("avengekills",1);
}

//Function Number: 17
assistedsuicide(param_00,param_01,param_02)
{
	self.modifiers["assistedsuicide"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_ASSISTEDSUICIDE");
	thread maps\mp\gametypes\_rank::giverankxp("assistedsuicide",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::giveadrenaline("assistedsuicide");
	thread maps\mp\_matchdata::logkillevent(param_00,"assistedsuicide");
}

//Function Number: 18
defendedplayer(param_00,param_01,param_02)
{
	self.modifiers["defender"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_DEFENDER");
	thread maps\mp\gametypes\_rank::giverankxp("defender",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::giveadrenaline("defender");
	thread maps\mp\_matchdata::logkillevent(param_00,"defender");
	maps\mp\_utility::incplayerstat("rescues",1);
}

//Function Number: 19
postdeathkill(param_00)
{
	self.modifiers["posthumous"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_POSTHUMOUS");
	thread maps\mp\gametypes\_rank::giverankxp("posthumous");
	thread maps\mp\_matchdata::logkillevent(param_00,"posthumous");
}

//Function Number: 20
backstab(param_00)
{
	self iprintlnbold("backstab");
}

//Function Number: 21
revenge(param_00)
{
	self.modifiers["revenge"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_REVENGE");
	thread maps\mp\gametypes\_rank::giverankxp("revenge");
	maps\mp\killstreaks\_killstreaks::giveadrenaline("revenge");
	thread maps\mp\_matchdata::logkillevent(param_00,"revenge");
	maps\mp\_utility::incplayerstat("revengekills",1);
}

//Function Number: 22
multikill(param_00,param_01)
{
	if(param_01 == 2)
	{
		thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_DOUBLEKILL");
		maps\mp\killstreaks\_killstreaks::giveadrenaline("double");
	}
	else if(param_01 == 3)
	{
		thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_TRIPLEKILL");
		maps\mp\killstreaks\_killstreaks::giveadrenaline("triple");
		thread maps\mp\_utility::teamplayercardsplash("callout_3xkill",self);
	}
	else
	{
		thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_MULTIKILL");
		maps\mp\killstreaks\_killstreaks::giveadrenaline("multi");
		thread maps\mp\_utility::teamplayercardsplash("callout_3xpluskill",self);
	}

	thread maps\mp\_matchdata::logmultikill(param_00,param_01);
	maps\mp\_utility::setplayerstatifgreater("multikill",param_01);
	maps\mp\_utility::incplayerstat("mostmultikills",1);
}

//Function Number: 23
firstblood(param_00,param_01,param_02)
{
	self.modifiers["firstblood"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_FIRSTBLOOD");
	thread maps\mp\gametypes\_rank::giverankxp("firstblood",undefined,param_01,param_02);
	thread maps\mp\_matchdata::logkillevent(param_00,"firstblood");
	maps\mp\killstreaks\_killstreaks::giveadrenaline("firstBlood");
	thread maps\mp\_utility::teamplayercardsplash("callout_firstblood",self);
}

//Function Number: 24
winningshot(param_00)
{
}

//Function Number: 25
buzzkill(param_00,param_01,param_02,param_03)
{
	self.modifiers["buzzkill"] = param_01.pers["cur_kill_streak"];
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_BUZZKILL");
	thread maps\mp\gametypes\_rank::giverankxp("buzzkill",undefined,param_02,param_03);
	maps\mp\killstreaks\_killstreaks::giveadrenaline("buzzkill");
	thread maps\mp\_matchdata::logkillevent(param_00,"buzzkill");
}

//Function Number: 26
comeback(param_00,param_01,param_02)
{
	self.modifiers["comeback"] = 1;
	thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_COMEBACK");
	thread maps\mp\gametypes\_rank::giverankxp("comeback",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::giveadrenaline("comeback");
	thread maps\mp\_matchdata::logkillevent(param_00,"comeback");
	maps\mp\_utility::incplayerstat("comebacks",1);
}

//Function Number: 27
disconnected()
{
	var_00 = self.guid;
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(isdefined(level.players[var_01].killedplayers[var_00]))
		{
			level.players[var_01].killedplayers[var_00] = undefined;
		}

		if(isdefined(level.players[var_01].killedplayerscurrent[var_00]))
		{
			level.players[var_01].killedplayerscurrent[var_00] = undefined;
		}

		if(isdefined(level.players[var_01].killedby[var_00]))
		{
			level.players[var_01].killedby[var_00] = undefined;
		}
	}
}

//Function Number: 28
monitorhealed()
{
	level endon("end_game");
	self endon("disconnect");
	for(;;)
	{
		self waittill("healed");
		maps\mp\killstreaks\_killstreaks::giveadrenaline("healed");
	}
}

//Function Number: 29
updaterecentkills(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("updateRecentKills");
	self endon("updateRecentKills");
	self.recentkillcount++;
	wait 1;
	if(self.recentkillcount > 1)
	{
		multikill(param_00,self.recentkillcount);
	}

	self.recentkillcount = 0;
}

//Function Number: 30
monitorcratejacking()
{
	level endon("end_game");
	self endon("disconnect");
	for(;;)
	{
		self waittill("hijacker",var_00,var_01);
		thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_HIJACKER");
		thread maps\mp\gametypes\_rank::giverankxp("hijacker",100);
		var_02 = "hijacked_airdrop";
		var_03 = "ch_hijacker";
		switch(var_00)
		{
			case "sentry":
				var_02 = "hijacked_sentry";
				break;
	
			case "juggernaut":
				var_02 = "hijacked_juggernaut";
				break;
	
			case "remote_tank":
				var_02 = "hijacked_remote_tank";
				break;
	
			case "emergency_airdrop":
			case "mega":
				var_02 = "hijacked_emergency_airdrop";
				var_03 = "ch_newjack";
				break;
	
			default:
				break;
		}

		if(isdefined(var_01))
		{
			var_01 maps\mp\gametypes\_hud_message::playercardsplashnotify(var_02,self);
		}

		self notify("process",var_03);
	}
}

//Function Number: 31
monitorobjectives()
{
	level endon("end_game");
	self endon("disconnect");
	for(;;)
	{
		self waittill("objective",var_00);
		if(var_00 == "captured")
		{
			maps\mp\killstreaks\_killstreaks::giveadrenaline("capture");
			if(isdefined(self.laststand) && self.laststand)
			{
				thread maps\mp\gametypes\_hud_message::splashnotifydelayed("heroic",100);
				thread maps\mp\gametypes\_rank::giverankxp("reviver",100);
			}
		}

		if(var_00 == "assistedCapture")
		{
			maps\mp\killstreaks\_killstreaks::giveadrenaline("assistedCapture");
		}

		if(var_00 == "plant")
		{
			maps\mp\killstreaks\_killstreaks::giveadrenaline("plant");
		}

		if(var_00 == "defuse")
		{
			maps\mp\killstreaks\_killstreaks::giveadrenaline("defuse");
		}
	}
}