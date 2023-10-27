/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_events.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 653 ms
 * Timestamp: 10/27/2023 1:22:16 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	var_00 = [];
	var_00["dm"] = 3;
	var_00["war"] = 4;
	var_00["sd"] = 5;
	var_00["dom"] = 6;
	var_00["conf"] = 7;
	var_00["sr"] = 8;
	var_00["bnty"] = 9;
	var_00["grind"] = 10;
	var_00["blitz"] = 11;
	var_00["cranked"] = 12;
	var_00["infect"] = 13;
	var_00["sotf"] = 14;
	var_00["sotf_ffa"] = 15;
	var_00["horde"] = 16;
	var_00["mugger"] = 17;
	var_00["aliens"] = 18;
	var_00["gun"] = 19;
	var_00["grnd"] = 20;
	var_00["siege"] = 21;
	var_01 = level.gametype;
	if(!isdefined(var_01))
	{
		var_01 = getdvar("g_gametype");
	}

	var_02 = 0;
	for(;;)
	{
		var_03 = tablelookupbyrow("mp/xp_event_table.csv",var_02,var_00[var_01]);
		if(!isdefined(var_03) || var_03 == "")
		{
			break;
		}

		var_04 = tablelookupbyrow("mp/xp_event_table.csv",var_02,0);
		if(var_04 == "win" || var_04 == "loss" || var_04 == "tie")
		{
			var_03 = float(var_03);
		}
		else
		{
			var_03 = int(var_03);
		}

		if(var_03 != -1)
		{
			maps\mp\gametypes\_rank::registerscoreinfo(var_04,var_03);
		}

		var_02++;
	}

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
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("pointblank",0);
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
	maps\mp\killstreaks\_killstreaks::registeradrenalineinfo("assistedCapture",0);
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
	level._effect["money"] = loadfx("fx/props/cash_player_drop");
	level.numkills = 0;
	level thread func_595D();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.killedplayers = [];
		var_00.killedplayerscurrent = [];
		var_00.ch_extremecrueltycomplete = 0;
		var_00.ch_tangodowncomplete = 0;
		var_00.killedby = [];
		var_00.lastkilledby = undefined;
		var_00.greatestuniqueplayerkills = 0;
		var_00.recentkillcount = 0;
		var_00.lastkilltime = 0;
		var_00.lastkilldogtime = 0;
		var_00.var_2305 = [];
		var_00 thread func_537A();
		var_00 thread func_53B2();
		var_00 thread func_5392();
	}
}

//Function Number: 3
damagedplayer(param_00,param_01,param_02)
{
	if(param_01 < 50 && param_01 > 10)
	{
		maps\mp\killstreaks\_killstreaks::func_3CDB("damage");
	}

	maps\mp\killstreaks\_killstreaks::func_3CDB("heavy_damage");
}

//Function Number: 4
killedplayernotifysys(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("killedPlayerNotify");
	self endon("killedPlayerNotify");
	if(!isdefined(self.killsinaframecount))
	{
		self.killsinaframecount = 0;
	}

	self.killsinaframecount++;
	wait(0.05);
	if(self.killsinaframecount > 1)
	{
		thread func_5728(param_00,param_01,param_02,param_03,self.killsinaframecount);
	}
	else
	{
		self notify("got_a_kill",param_01,param_02,param_03);
	}

	self.killsinaframecount = 0;
}

//Function Number: 5
func_5728(param_00,param_01,param_02,param_03,param_04)
{
	for(var_05 = 0;var_05 < param_04;var_05++)
	{
		self notify("got_a_kill",param_01,param_02,param_03);
		wait(0.05);
	}
}

//Function Number: 6
func_4B1A(param_00,param_01,param_02,param_03)
{
	var_04 = param_01.guid;
	var_05 = self.guid;
	var_06 = gettime();
	thread killedplayernotifysys(param_00,param_01,param_02,param_03);
	thread func_8724(param_00);
	self.lastkilltime = gettime();
	self.lastkilledplayer = param_01;
	self.modifiers = [];
	level.numkills++;
	self.var_2305[var_04] = undefined;
	if(!maps\mp\_utility::func_48F7(param_02) && !maps\mp\_utility::isjuggernaut() && !maps\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		if(param_02 == "none")
		{
			return 0;
		}

		if(param_01.attackers.size == 1 && !isdefined(param_01.attackers[param_01.guid]))
		{
			var_0B = maps\mp\_utility::getweaponclass(param_02);
			if(var_0B == "weapon_sniper" && param_03 != "MOD_MELEE" && gettime() == param_01.attackerdata[self.guid].firsttimedamaged)
			{
				self.modifiers["oneshotkill"] = 1;
				thread maps\mp\gametypes\_rank::func_8E6E("one_shot_kill");
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
				func_404C(param_00,param_02,param_03);
			}
		}

		if(isdefined(self.var_8C4D) && self.var_8C4D && gettime() - self.var_78C4 <= 5000)
		{
			self.modifiers["jackintheboxkill"] = 1;
		}

		if(!isalive(self) && self.deathtime + 800 < gettime())
		{
			func_60D3(param_00);
		}

		if(level.teambased && var_06 - param_01.lastkilltime < 500)
		{
			if(param_01.lastkilledplayer != self)
			{
				avengedplayer(param_00,param_02,param_03);
			}
		}

		if(isdefined(param_01.lastkilldogtime) && var_06 - param_01.lastkilldogtime < 2000)
		{
			avengeddog(param_00,param_02,param_03);
		}

		foreach(var_0E, var_0D in param_01.var_2305)
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

		if(ispointblank(self,param_02,param_03,var_0F,param_01))
		{
			thread pointblank(param_00,param_02,param_03);
		}
		else if(func_4908(self,param_02,param_03,var_0F,param_01))
		{
			thread func_4F40(param_00,param_02,param_03);
		}

		var_10 = param_01.pers["cur_kill_streak"];
		if(var_10 > 0 && isdefined(param_01.killstreaks[var_10 + 1]))
		{
			buzzkill(param_00,param_01,param_02,param_03);
		}

		thread func_1BAF(param_00,param_01,param_02,param_03);
	}
	else if(param_02 == "guard_dog_mp")
	{
		if(!isalive(self) && self.deathtime < gettime())
		{
			func_60D2();
		}
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
		maps\mp\_utility::func_70A0("killedsameplayer",self.killedplayers[var_04]);
	}

	self.killedplayerscurrent[var_04]++;
	param_01.killedby[var_05]++;
	param_01.lastkilledby = self;
}

//Function Number: 7
func_4908(param_00,param_01,param_02,param_03,param_04)
{
	if(isalive(param_00) && !param_00 maps\mp\_utility::func_4995() && param_02 == "MOD_RIFLE_BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_HEAD_SHOT" && !maps\mp\_utility::func_48F7(param_01) && !isdefined(param_00.assistedsuicide))
	{
		var_05 = maps\mp\_utility::getweaponclass(param_01);
		switch(var_05)
		{
			case "weapon_pistol":
				var_06 = 800;
				break;

			case "weapon_smg":
				var_06 = 1200;
				break;

			case "weapon_lmg":
			case "weapon_dmr":
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

		var_07 = var_06 * var_06;
		if(distancesquared(param_03,param_04.origin) > var_07)
		{
			if(param_00 isitemunlocked("specialty_holdbreath") && param_00 maps\mp\_utility::_hasperk("specialty_holdbreath"))
			{
				param_00 maps\mp\gametypes\_missions::func_61CE("ch_longdistance");
			}

			return 1;
		}
	}

	return 0;
}

//Function Number: 8
ispointblank(param_00,param_01,param_02,param_03,param_04)
{
	if(isalive(param_00) && !param_00 maps\mp\_utility::func_4995() && param_02 == "MOD_RIFLE_BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_HEAD_SHOT" && !maps\mp\_utility::func_48F7(param_01) && !isdefined(param_00.assistedsuicide))
	{
		var_05 = 9216;
		if(distancesquared(param_03,param_04.origin) < var_05)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
func_1BAF(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\_utility::getweaponclass(param_02);
	var_05 = 0;
	thread func_1977();
	if(isdefined(self.lastkilledby) && self.lastkilledby == param_01)
	{
		self.lastkilledby = undefined;
		func_668B(param_00);
	}

	if(param_01.idflags & level.idflags_penetration)
	{
		maps\mp\_utility::func_447B("bulletpenkills",1);
	}

	var_06 = self.pers["rank"];
	var_07 = param_01.pers["rank"];
	if(var_06 < var_07)
	{
		maps\mp\_utility::func_447B("higherrankkills",1);
	}

	if(var_06 > var_07)
	{
		maps\mp\_utility::func_447B("lowerrankkills",1);
	}

	if(isdefined(self.var_44CB) && self.var_44CB)
	{
		maps\mp\_utility::func_447B("laststandkills",1);
	}

	if(isdefined(param_01.var_44CB) && param_01.var_44CB)
	{
		maps\mp\_utility::func_447B("laststanderkills",1);
	}

	if(self getcurrentweapon() != self.primaryweapon && self getcurrentweapon() != self.secondaryweapon)
	{
		maps\mp\_utility::func_447B("otherweaponkills",1);
	}

	var_08 = gettime() - param_01.var_78C4;
	if(!maps\mp\_utility::func_50C1())
	{
		param_01 maps\mp\_utility::func_70A2("shortestlife",var_08);
	}

	param_01 maps\mp\_utility::func_70A1("longestlife",var_08);
	if(param_03 != "MOD_MELEE")
	{
		switch(var_04)
		{
			case "weapon_pistol":
			case "weapon_projectile":
			case "weapon_shotgun":
			case "weapon_lmg":
			case "weapon_dmr":
			case "weapon_sniper":
			case "weapon_assault":
			case "weapon_smg":
				func_1BB0(param_01,param_02,param_03,var_04);
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

//Function Number: 10
func_1BB0(param_00,param_01,param_02,param_03)
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

		case "weapon_dmr":
			var_05 = "dmrkills";
			var_06 = "dmrheadshots";
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
		var_04 maps\mp\_utility::func_447B(var_05,1);
	}

	if(isdefined(var_06) && param_02 == "MOD_HEAD_SHOT")
	{
		var_04 maps\mp\_utility::func_447B(var_06,1);
	}

	if(isdefined(var_07) && !maps\mp\_utility::func_50C1())
	{
		param_00 maps\mp\_utility::func_447B(var_07,1);
	}

	if(var_04 maps\mp\_utility::isplayerads())
	{
		var_04 maps\mp\_utility::func_447B("adskills",1);
		var_08 = issubstr(param_01,"thermal");
		if(var_08 || issubstr(param_01,"acog") || issubstr(param_01,"scope"))
		{
			var_04 maps\mp\_utility::func_447B("scopedkills",1);
		}

		if(var_08)
		{
			var_04 maps\mp\_utility::func_447B("thermalkills",1);
		}
	}

	var_04 maps\mp\_utility::func_447B("hipfirekills",1);
}

//Function Number: 11
checkmatchdataequipmentkills(param_00,param_01,param_02)
{
	var_03 = self;
	switch(param_01)
	{
		case "frag_grenade_mp":
			var_03 maps\mp\_utility::func_447B("fragkills",1);
			var_03 maps\mp\_utility::func_447B("grenadekills",1);
			var_04 = 1;
			break;

		case "c4_mp":
			var_04 maps\mp\_utility::func_447B("c4kills",1);
			var_04 = 1;
			break;

		case "semtex_mp":
			var_04 maps\mp\_utility::func_447B("semtexkills",1);
			var_04 maps\mp\_utility::func_447B("grenadekills",1);
			var_04 = 1;
			break;

		case "claymore_mp":
			var_04 maps\mp\_utility::func_447B("claymorekills",1);
			var_04 = 1;
			break;

		case "throwingknife_mp":
			var_04 maps\mp\_utility::func_447B("throwingknifekills",1);
			thread maps\mp\gametypes\_rank::func_8E6E("knifethrow");
			var_04 = 1;
			break;

		default:
			var_04 = 0;
			break;
	}

	if(var_04)
	{
		var_03 maps\mp\_utility::func_447B("equipmentkills",1);
	}
}

//Function Number: 12
func_1977()
{
	self.lastkillwascamping = 0;
	if(!isdefined(self.lastkilllocation))
	{
		self.lastkilllocation = self.origin;
		self.lastcampkilltime = gettime();
	}

	if(distance(self.lastkilllocation,self.origin) < 512 && gettime() - self.lastcampkilltime > 5000)
	{
		maps\mp\_utility::func_447B("mostcamperkills",1);
		self.lastkillwascamping = 1;
	}

	self.lastkilllocation = self.origin;
	self.lastcampkilltime = gettime();
}

//Function Number: 13
consolation(param_00)
{
}

//Function Number: 14
func_6225(param_00)
{
	self.modifiers["proximityAssist"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("proximityassist");
	thread maps\mp\gametypes\_rank::giverankxp("proximityassist");
}

//Function Number: 15
proximitykill(param_00)
{
	self.modifiers["proximityKill"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("proximitykill");
	thread maps\mp\gametypes\_rank::giverankxp("proximitykill");
}

//Function Number: 16
func_4F40(param_00,param_01,param_02)
{
	self.modifiers["longshot"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("longshot");
	thread maps\mp\gametypes\_rank::giverankxp("longshot",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::func_3CDB("longshot");
	maps\mp\_utility::func_447B("longshots",1);
	thread maps\mp\_matchdata::func_4F1A(param_00,"longshot");
}

//Function Number: 17
pointblank(param_00,param_01,param_02)
{
	self.modifiers["pointblank"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("pointblank");
	thread maps\mp\gametypes\_rank::giverankxp("pointblank",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::func_3CDB("pointblank");
	thread maps\mp\_matchdata::func_4F1A(param_00,"pointblank");
}

//Function Number: 18
execution(param_00,param_01,param_02)
{
	self.modifiers["execution"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("execution");
	thread maps\mp\gametypes\_rank::giverankxp("execution",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::func_3CDB("execution");
	thread maps\mp\_matchdata::func_4F1A(param_00,"execution");
}

//Function Number: 19
func_404C(param_00,param_01,param_02)
{
	self.modifiers["headshot"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("headshot");
	thread maps\mp\gametypes\_rank::giverankxp("headshot",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::func_3CDB("headshot");
	thread maps\mp\_matchdata::func_4F1A(param_00,"headshot");
}

//Function Number: 20
avengedplayer(param_00,param_01,param_02)
{
	self.modifiers["avenger"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("avenger");
	thread maps\mp\gametypes\_rank::giverankxp("avenger",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::func_3CDB("avenger");
	thread maps\mp\_matchdata::func_4F1A(param_00,"avenger");
	maps\mp\_utility::func_447B("avengekills",1);
}

//Function Number: 21
avengeddog(param_00,param_01,param_02)
{
	thread maps\mp\gametypes\_rank::func_8E6E("dog_avenger");
	thread maps\mp\gametypes\_rank::giverankxp("dog_avenger",undefined,param_01,param_02);
}

//Function Number: 22
assistedsuicide(param_00,param_01,param_02)
{
	self.modifiers["assistedsuicide"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("assistedsuicide");
	thread maps\mp\gametypes\_rank::giverankxp("assistedsuicide",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::func_3CDB("assistedsuicide");
	thread maps\mp\_matchdata::func_4F1A(param_00,"assistedsuicide");
}

//Function Number: 23
defendedplayer(param_00,param_01,param_02)
{
	self.modifiers["defender"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("defender");
	thread maps\mp\gametypes\_rank::giverankxp("defender",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::func_3CDB("defender");
	thread maps\mp\_matchdata::func_4F1A(param_00,"defender");
	maps\mp\_utility::func_447B("rescues",1);
}

//Function Number: 24
func_60D3(param_00)
{
	self.modifiers["posthumous"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("posthumous");
	thread maps\mp\gametypes\_rank::giverankxp("posthumous");
	thread maps\mp\_matchdata::func_4F1A(param_00,"posthumous");
}

//Function Number: 25
func_60D2()
{
	thread maps\mp\gametypes\_rank::func_8E6E("martyrdog");
	thread maps\mp\gametypes\_rank::giverankxp("martyrdog");
}

//Function Number: 26
backstab(param_00)
{
	self iprintlnbold("backstab");
}

//Function Number: 27
func_668B(param_00)
{
	self.modifiers["revenge"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("revenge");
	thread maps\mp\gametypes\_rank::giverankxp("revenge");
	maps\mp\killstreaks\_killstreaks::func_3CDB("revenge");
	thread maps\mp\_matchdata::func_4F1A(param_00,"revenge");
	maps\mp\_utility::func_447B("revengekills",1);
}

//Function Number: 28
multikill(param_00,param_01)
{
	if(param_01 == 2)
	{
		thread maps\mp\gametypes\_rank::func_8E6E("double");
		maps\mp\killstreaks\_killstreaks::func_3CDB("double");
	}
	else if(param_01 == 3)
	{
		thread maps\mp\gametypes\_rank::func_8E6E("triple");
		maps\mp\killstreaks\_killstreaks::func_3CDB("triple");
		thread maps\mp\_utility::func_7FA0("callout_3xkill",self);
	}
	else
	{
		thread maps\mp\gametypes\_rank::func_8E6E("multi");
		maps\mp\killstreaks\_killstreaks::func_3CDB("multi");
		thread maps\mp\_utility::func_7FA0("callout_3xpluskill",self);
	}

	thread maps\mp\_matchdata::func_4F1E(param_00,param_01);
	maps\mp\_utility::func_70A1("multikill",param_01);
	maps\mp\_utility::func_447B("mostmultikills",1);
}

//Function Number: 29
firstblood(param_00,param_01,param_02)
{
	self.modifiers["firstblood"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("firstblood");
	thread maps\mp\gametypes\_rank::giverankxp("firstblood",undefined,param_01,param_02);
	thread maps\mp\_matchdata::func_4F1A(param_00,"firstblood");
	maps\mp\killstreaks\_killstreaks::func_3CDB("firstBlood");
	thread maps\mp\_utility::func_7FA0("callout_firstblood",self);
	maps\mp\gametypes\_missions::func_61CE("ch_bornready");
}

//Function Number: 30
func_8E13(param_00)
{
}

//Function Number: 31
buzzkill(param_00,param_01,param_02,param_03)
{
	self.modifiers["buzzkill"] = param_01.pers["cur_kill_streak"];
	thread maps\mp\gametypes\_rank::func_8E6E("buzzkill");
	thread maps\mp\gametypes\_rank::giverankxp("buzzkill",undefined,param_02,param_03);
	maps\mp\killstreaks\_killstreaks::func_3CDB("buzzkill");
	thread maps\mp\_matchdata::func_4F1A(param_00,"buzzkill");
}

//Function Number: 32
comeback(param_00,param_01,param_02)
{
	self.modifiers["comeback"] = 1;
	thread maps\mp\gametypes\_rank::func_8E6E("comeback");
	thread maps\mp\gametypes\_rank::giverankxp("comeback",undefined,param_01,param_02);
	maps\mp\killstreaks\_killstreaks::func_3CDB("comeback");
	thread maps\mp\_matchdata::func_4F1A(param_00,"comeback");
	maps\mp\_utility::func_447B("comebacks",1);
}

//Function Number: 33
func_27CA()
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

//Function Number: 34
func_5392()
{
	level endon("end_game");
	self endon("disconnect");
	for(;;)
	{
		self waittill("healed");
		maps\mp\killstreaks\_killstreaks::func_3CDB("healed");
	}
}

//Function Number: 35
func_8724(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("updateRecentKills");
	self endon("updateRecentKills");
	self.recentkillcount++;
	wait(1);
	if(self.recentkillcount > 1)
	{
		multikill(param_00,self.recentkillcount);
	}

	self.recentkillcount = 0;
}

//Function Number: 36
func_537A()
{
	level endon("end_game");
	self endon("disconnect");
	for(;;)
	{
		self waittill("hijacker",var_00,var_01);
		thread maps\mp\gametypes\_rank::func_8E6E("hijacker");
		thread maps\mp\gametypes\_rank::giverankxp("hijacker");
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
	
			case "maniac":
				var_02 = "hijacked_maniac";
				break;
	
			case "juggernaut_swamp_slasher":
				var_02 = "hijacked_juggernaut_swamp_slasher";
				break;
	
			case "juggernaut_predator":
				var_02 = "hijacked_juggernaut_predator";
				break;
	
			case "juggernaut_death_mariachi":
				var_02 = "hijacked_juggernaut_death_mariachi";
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
			var_01 maps\mp\gametypes\_hud_message::func_5F9A(var_02,self);
		}

		self notify("process",var_03);
	}
}

//Function Number: 37
func_53B2()
{
	level endon("end_game");
	self endon("disconnect");
	for(;;)
	{
		self waittill("objective",var_00);
		switch(var_00)
		{
			case "captured":
				maps\mp\killstreaks\_killstreaks::func_3CDB("capture");
				if(isdefined(self.laststand) && self.laststand)
				{
					thread maps\mp\gametypes\_hud_message::func_794D("heroic",maps\mp\gametypes\_rank::func_3BE0("reviver"));
					thread maps\mp\gametypes\_rank::giverankxp("reviver");
				}
				break;
	
			case "plant":
				maps\mp\killstreaks\_killstreaks::func_3CDB("plant");
				break;
	
			case "defuse":
				maps\mp\killstreaks\_killstreaks::func_3CDB("defuse");
				break;
		}
	}
}

//Function Number: 38
giveobjectivepointstreaks()
{
	var_00 = 1;
	if(var_00)
	{
		if(!isagent(self))
		{
			self.pers["objectivePointStreak"]++;
			var_01 = self.pers["objectivePointStreak"] % 2 == 0;
			if(var_01)
			{
				maps\mp\killstreaks\_killstreaks::func_3CDB("kill");
			}

			self setclientomnvar("ui_half_tick",!var_01);
		}
	}
}