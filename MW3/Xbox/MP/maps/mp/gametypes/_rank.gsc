/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_rank.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 52
 * Decompile Time: 722 ms
 * Timestamp: 10/27/2023 2:25:49 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.scoreinfo = [];
	level.xpscale = getdvarint("scr_xpscale");
	if(level.xpscale > 4 || level.xpscale < 0)
	{
		exitlevel(0);
	}

	level.xpscale = min(level.xpscale,4);
	level.xpscale = max(level.xpscale,0);
	level.ranktable = [];
	level.weaponranktable = [];
	precacheshader("white");
	precachestring(&"RANK_PLAYER_WAS_PROMOTED_N");
	precachestring(&"RANK_PLAYER_WAS_PROMOTED");
	precachestring(&"RANK_WEAPON_WAS_PROMOTED");
	precachestring(&"RANK_PROMOTED");
	precachestring(&"RANK_PROMOTED_WEAPON");
	precachestring(&"MP_PLUS");
	precachestring(&"RANK_ROMANI");
	precachestring(&"RANK_ROMANII");
	precachestring(&"RANK_ROMANIII");
	precachestring(&"SPLASHES_LONGSHOT");
	precachestring(&"SPLASHES_PROXIMITYASSIST");
	precachestring(&"SPLASHES_PROXIMITYKILL");
	precachestring(&"SPLASHES_EXECUTION");
	precachestring(&"SPLASHES_AVENGER");
	precachestring(&"SPLASHES_ASSISTEDSUICIDE");
	precachestring(&"SPLASHES_DEFENDER");
	precachestring(&"SPLASHES_POSTHUMOUS");
	precachestring(&"SPLASHES_REVENGE");
	precachestring(&"SPLASHES_DOUBLEKILL");
	precachestring(&"SPLASHES_TRIPLEKILL");
	precachestring(&"SPLASHES_MULTIKILL");
	precachestring(&"SPLASHES_BUZZKILL");
	precachestring(&"SPLASHES_COMEBACK");
	precachestring(&"SPLASHES_KNIFETHROW");
	precachestring(&"SPLASHES_ONE_SHOT_KILL");
	if(level.teambased)
	{
		registerscoreinfo("kill",100);
		registerscoreinfo("headshot",100);
		registerscoreinfo("assist",20);
		registerscoreinfo("proximityassist",20);
		registerscoreinfo("proximitykill",20);
		registerscoreinfo("suicide",0);
		registerscoreinfo("teamkill",0);
	}
	else
	{
		registerscoreinfo("kill",50);
		registerscoreinfo("headshot",50);
		registerscoreinfo("assist",0);
		registerscoreinfo("suicide",0);
		registerscoreinfo("teamkill",0);
	}

	registerscoreinfo("win",1);
	registerscoreinfo("loss",0.5);
	registerscoreinfo("tie",0.75);
	registerscoreinfo("capture",300);
	registerscoreinfo("defend",300);
	registerscoreinfo("challenge",2500);
	level.maxrank = int(tablelookup("mp/rankTable.csv",0,"maxrank",1));
	level.maxprestige = int(tablelookup("mp/rankIconTable.csv",0,"maxprestige",1));
	var_00 = 0;
	var_01 = 0;
	for(var_00 = 0;var_00 <= min(10,level.maxprestige);var_00++)
	{
		for(var_01 = 0;var_01 <= level.maxrank;var_01++)
		{
			precacheshader(tablelookup("mp/rankIconTable.csv",0,var_01,var_00 + 1));
		}
	}

	var_02 = 0;
	var_03 = tablelookup("mp/ranktable.csv",0,var_02,1);
	while(isdefined(var_03) && var_03 != "")
	{
		level.ranktable[var_02][1] = tablelookup("mp/ranktable.csv",0,var_02,1);
		level.ranktable[var_02][2] = tablelookup("mp/ranktable.csv",0,var_02,2);
		level.ranktable[var_02][3] = tablelookup("mp/ranktable.csv",0,var_02,3);
		level.ranktable[var_02][7] = tablelookup("mp/ranktable.csv",0,var_02,7);
		precachestring(tablelookupistring("mp/ranktable.csv",0,var_02,16));
		var_02++;
		var_03 = tablelookup("mp/ranktable.csv",0,var_02,1);
	}

	var_04 = int(tablelookup("mp/weaponRankTable.csv",0,"maxrank",1));
	for(var_05 = 0;var_05 < var_04 + 1;var_05++)
	{
		level.weaponranktable[var_05][1] = tablelookup("mp/weaponRankTable.csv",0,var_05,1);
		level.weaponranktable[var_05][2] = tablelookup("mp/weaponRankTable.csv",0,var_05,2);
		level.weaponranktable[var_05][3] = tablelookup("mp/weaponRankTable.csv",0,var_05,3);
	}

	maps\mp\gametypes\_missions::buildchallegeinfo();
	level thread func_327D();
	level thread onplayerconnect();
}

//Function Number: 2
func_327D()
{
	level endon("game_ended");
	while(!isdefined(level.players) || !level.players.size)
	{
		wait 0.05;
	}

	if(!maps\mp\_utility::matchmakinggame())
	{
		if(getdvar("mapname") == "mp_rust" && randomint(1000) == 999)
		{
			level.patientzeroname = level.players[0].name;
			return;
		}

		return;
	}

	if(getdvar("scr_patientZero") != "")
	{
		level.patientzeroname = getdvar("scr_patientZero");
	}
}

//Function Number: 3
func_327E(param_00)
{
	if(isdefined(level.scoreinfo[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
registerscoreinfo(param_00,param_01)
{
	level.scoreinfo[param_00]["value"] = param_01;
}

//Function Number: 5
getscoreinfovalue(param_00)
{
	var_01 = "scr_" + level.gametype + "_score_" + param_00;
	if(getdvar(var_01) != "")
	{
		return getdvarint(var_01);
	}

	return level.scoreinfo[param_00]["value"];
}

//Function Number: 6
func_327F(param_00)
{
	return level.scoreinfo[param_00]["label"];
}

//Function Number: 7
getrankinfominxp(param_00)
{
	return int(level.ranktable[param_00][2]);
}

//Function Number: 8
func_3280(param_00)
{
	return int(level.weaponranktable[param_00][1]);
}

//Function Number: 9
func_0ECE(param_00)
{
	return int(level.ranktable[param_00][3]);
}

//Function Number: 10
getweaponrankinfoxpamt(param_00)
{
	return int(level.weaponranktable[param_00][2]);
}

//Function Number: 11
getrankinfomaxxp(param_00)
{
	return int(level.ranktable[param_00][7]);
}

//Function Number: 12
func_3282(param_00)
{
	return int(level.weaponranktable[param_00][3]);
}

//Function Number: 13
getrankinfofull(param_00)
{
	return tablelookupistring("mp/ranktable.csv",0,param_00,16);
}

//Function Number: 14
getrankinfoicon(param_00,param_01)
{
	return tablelookup("mp/rankIconTable.csv",0,param_00,param_01 + 1);
}

//Function Number: 15
func_3283(param_00)
{
	return int(tablelookup("mp/ranktable.csv",0,param_00,13));
}

//Function Number: 16
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.pers["rankxp"] = var_00 maps\mp\gametypes\_persistence::func_2B58("experience");
		if(var_00.pers["rankxp"] < 0)
		{
			var_00.pers["rankxp"] = 0;
		}

		var_01 = var_00 getrankforxp(var_00 getrankxp());
		var_00.pers["rank"] = var_01;
		var_00.pers["participation"] = 0;
		var_00.xpupdatetotal = 0;
		var_00.bonusupdatetotal = 0;
		var_02 = var_00 getprestigelevel();
		var_00 setrank(var_01,var_02);
		var_00.pers["prestige"] = var_02;
		if(var_00.clientid < level.maxlogclients)
		{
			setmatchdata("players",var_00.clientid,"rank",var_01);
			setmatchdata("players",var_00.clientid,"Prestige",var_02);
		}

		var_00.postgamepromotion = 0;
		if(!isdefined(var_00.pers["postGameChallenges"]))
		{
			var_00 setclientdvars("ui_challenge_1_ref","","ui_challenge_2_ref","","ui_challenge_3_ref","","ui_challenge_4_ref","","ui_challenge_5_ref","","ui_challenge_6_ref","","ui_challenge_7_ref","");
		}

		var_00 setclientdvar("ui_promotion",0);
		if(!isdefined(var_00.pers["summary"]))
		{
			var_00.pers["summary"] = [];
			var_00.pers["summary"]["xp"] = 0;
			var_00.pers["summary"]["score"] = 0;
			var_00.pers["summary"]["challenge"] = 0;
			var_00.pers["summary"]["match"] = 0;
			var_00.pers["summary"]["misc"] = 0;
			var_00 setclientdvar("player_summary_xp","0");
			var_00 setclientdvar("player_summary_score","0");
			var_00 setclientdvar("player_summary_challenge","0");
			var_00 setclientdvar("player_summary_match","0");
			var_00 setclientdvar("player_summary_misc","0");
		}

		var_00 setclientdvar("ui_opensummary",0);
		var_00 thread maps\mp\gametypes\_missions::updatechallenges();
		var_00.explosivekills[0] = 0;
		var_00.xpgains = [];
		var_00.hud_xppointspopup = var_00 createxppointspopup();
		var_00.hud_xpeventpopup = var_00 createxpeventpopup();
		var_00 thread onplayerspawned();
		var_00 thread func_2747();
		var_00 thread func_2748();
		var_00 thread func_328A();
		if(var_00 getplayerdata("prestigeDoubleXp"))
		{
			var_00.prestigedoublexp = 1;
		}
		else
		{
			var_00.prestigedoublexp = 0;
		}

		if(var_00 getplayerdata("prestigeDoubleWeaponXp"))
		{
			var_00.prestigedoubleweaponxp = 1;
			continue;
		}

		var_00.prestigedoubleweaponxp = 0;
	}
}

//Function Number: 17
func_328A()
{
	self endon("disconnect");
	for(;;)
	{
		wait 30;
		if(!self.hasdonecombat)
		{
			continue;
		}

		maps\mp\gametypes\_persistence::statadd("gamesPlayed",1);
		break;
	}
}

//Function Number: 18
func_2747()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		thread removerankhud();
	}
}

//Function Number: 19
func_2748()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		thread removerankhud();
	}
}

//Function Number: 20
onplayerspawned()
{
	self endon("disconnect");
	self waittill("spawned_player");
}

//Function Number: 21
roundup(param_00)
{
	if(int(param_00) != param_00)
	{
		return int(param_00 + 1);
	}

	return int(param_00);
}

//Function Number: 22
func_2AB3(param_00,param_01,param_02,param_03,param_04)
{
	self endon("disconnect");
	var_05 = "none";
	if(!maps\mp\_utility::rankingenabled())
	{
		if(param_00 == "assist")
		{
			if(isdefined(self.taggedassist))
			{
				self.taggedassist = undefined;
			}
			else
			{
				var_06 = &"MP_ASSIST";
				if(maps\mp\_utility::func_27AF("specialty_assists"))
				{
					if(!self.pers["assistsToKill"] % 2)
					{
						var_06 = &"MP_ASSIST_TO_KILL";
					}
				}

				thread xpeventpopup(var_06);
			}
		}

		return;
	}

	if(level.teambased && !level.teamcount["allies"] || !level.teamcount["axis"])
	{
		return;
	}
	else if(!level.teambased && level.teamcount["allies"] + level.teamcount["axis"] < 2)
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = getscoreinfovalue(param_00);
	}

	if(!isdefined(self.xpgains[param_00]))
	{
		self.xpgains[param_00] = 0;
	}

	var_07 = 0;
	var_08 = 0;
	switch(param_00)
	{
		case "shield_damage":
		case "headshot":
		case "kill":
			param_01 = param_01 * self.xpscaler;
			break;

		case "jugg_on_jugg":
		case "kill_juggernaut":
		case "kill_as_juggernaut":
		case "got_juggernaut":
		case "dropped_enemy_gun_rank":
		case "gained_gun_rank":
		case "final_rogue":
		case "survivor":
		case "draft_rogue":
		case "kill_carrier":
		case "kill_bonus":
		case "team_assist":
		case "tags_retrieved":
		case "kill_denied":
		case "kill_confirmed":
		case "defuse":
		case "save":
		case "plant":
		case "pickup":
		case "return":
		case "assault":
		case "defend":
		case "capture":
		case "teamkill":
		case "assist":
		case "suicide":
		case "destroy":
			if(maps\mp\_utility::getgametypenumlives() > 0 && param_00 != "shield_damage")
			{
				var_09 = max(1,int(10 / maps\mp\_utility::getgametypenumlives()));
				param_01 = int(param_01 * var_09);
			}
	
			var_0A = 0;
			var_0B = 0;
			if(self.prestigedoublexp)
			{
				var_0C = self getplayerdata("prestigeDoubleXpTimePlayed");
				if(var_0C >= self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"])
				{
					self setplayerdata("prestigeDoubleXp",0);
					self setplayerdata("prestigeDoubleXpTimePlayed",0);
					self setplayerdata("prestigeDoubleXpMaxTimePlayed",0);
					self.prestigedoublexp = 0;
				}
				else
				{
					var_0B = 2;
				}
			}
	
			if(!self.prestigedoublexp)
			{
				for(var_0D = 0;var_0D < 3;var_0D++)
				{
					if(self getplayerdata("xpMultiplierTimePlayed",var_0D) < self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][var_0D])
					{
						var_0A = var_0A + int(self getplayerdata("xpMultiplier",var_0D));
					}
				}
			}
	
			if(var_0B > 0)
			{
				param_01 = int(param_01 * level.xpscale * var_0B);
			}
			else if(var_0A > 0)
			{
				param_01 = int(param_01 * level.xpscale * var_0A);
			}
			else
			{
				param_01 = int(param_01 * level.xpscale);
			}
	
			if(isdefined(level.nukedetonated) && level.nukedetonated)
			{
				if(level.teambased && level.nukeinfo.team == self.team)
				{
					param_01 = param_01 * level.nukeinfo.var_822A;
				}
				else if(!level.teambased && level.nukeinfo.player == self)
				{
					param_01 = param_01 * level.nukeinfo.var_822A;
				}
	
				param_01 = int(param_01);
			}
	
			var_0E = getrestxpaward(param_01);
			param_01 = param_01 + var_0E;
			if(var_0E > 0)
			{
				if(islastrestxpaward(param_01))
				{
					thread maps\mp\gametypes\_hud_message::func_2892("rested_done");
				}
	
				var_08 = 1;
			}
			break;

		case "challenge":
			var_0A = 0;
			if(self getplayerdata("challengeXPMultiplierTimePlayed",0) < self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0])
			{
				var_0A = var_0A + int(self getplayerdata("challengeXPMultiplier",0));
				if(var_0A > 0)
				{
					param_01 = int(param_01 * var_0A);
				}
			}
			break;
	}

	if(!var_08)
	{
		if(self getplayerdata("restXPGoal") > getrankxp())
		{
			self setplayerdata("restXPGoal",self getplayerdata("restXPGoal") + param_01);
		}
	}

	var_0F = getrankxp();
	self.xpgains[param_00] = self.xpgains[param_00] + param_01;
	incrankxp(param_01);
	if(maps\mp\_utility::rankingenabled() && func_0EB5(var_0F))
	{
		thread updaterankannouncehud();
	}

	func_329E();
	var_10 = maps\mp\gametypes\_missions::isweaponchallenge(param_04);
	if(var_10)
	{
		param_02 = self getcurrentweapon();
	}

	if(param_00 == "shield_damage")
	{
		param_02 = self getcurrentweapon();
		param_03 = "MOD_MELEE";
	}

	if(func_328C(param_02,param_03) || var_10)
	{
		var_11 = strtok(param_02,"_");
		if(var_11[0] == "iw5")
		{
			var_12 = var_11[0] + "_" + var_11[1];
		}
		else if(var_12[0] == "alt")
		{
			var_12 = var_12[1] + "_" + var_12[2];
		}
		else
		{
			var_12 = var_12[0];
		}

		if(var_11[0] == "gl")
		{
			var_12 = var_11[1];
		}

		if(self isitemunlocked(var_12))
		{
			if(self.primaryweapon == param_02 || self.secondaryweapon == param_02 || weaponaltweaponname(self.primaryweapon) == param_02 || isdefined(self.tookweaponfrom) && isdefined(self.tookweaponfrom[param_02]))
			{
				var_13 = func_3297(var_12);
				switch(param_00)
				{
					case "kill":
						var_14 = 100;
						break;

					default:
						var_14 = param_02;
						break;
				}

				if(self.prestigedoubleweaponxp)
				{
					var_15 = self getplayerdata("prestigeDoubleWeaponXpTimePlayed");
					if(var_15 >= self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"])
					{
						self setplayerdata("prestigeDoubleWeaponXp",0);
						self setplayerdata("prestigeDoubleWeaponXpTimePlayed",0);
						self setplayerdata("prestigeDoubleWeaponXpMaxTimePlayed",0);
						self.prestigedoubleweaponxp = 0;
					}
					else
					{
						var_14 = var_14 * 2;
					}
				}

				if(self getplayerdata("weaponXPMultiplierTimePlayed",0) < self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0])
				{
					var_16 = int(self getplayerdata("weaponXPMultiplier",0));
					if(var_16 > 0)
					{
						var_14 = var_14 * var_16;
					}
				}

				var_17 = var_13 + var_14;
				if(!isweaponmaxrank(var_12))
				{
					var_18 = func_3298(var_12);
					if(var_17 > var_18)
					{
						var_17 = var_18;
						var_14 = var_18 - var_13;
					}

					if(!isdefined(self.weaponsused))
					{
						self.weaponsused = [];
						self.weaponxpearned = [];
					}

					var_19 = 0;
					var_1A = 999;
					for(var_0D = 0;var_0D < self.weaponsused.size;var_0D++)
					{
						if(self.weaponsused[var_0D] == var_12)
						{
							var_19 = 1;
							var_1A = var_0D;
						}
					}

					if(var_19)
					{
						self.weaponxpearned[var_1A] = self.weaponxpearned[var_1A] + var_14;
					}
					else
					{
						self.weaponsused[self.weaponsused.size] = var_12;
						self.weaponxpearned[self.weaponxpearned.size] = var_14;
					}

					self setplayerdata("weaponXP",var_12,var_17);
					maps\mp\_matchdata::logweaponstat(var_12,"XP",var_14);
					maps\mp\_utility::incplayerstat("weaponxpearned",var_14);
					if(maps\mp\_utility::rankingenabled() && func_2880(var_17,var_12))
					{
						thread func_328E();
					}
				}
			}
		}
	}

	if(!level.hardcoremode)
	{
		if(param_00 == "teamkill")
		{
			thread xppointspopup(0 - getscoreinfovalue("kill"),0,(1,0,0),0);
		}
		else
		{
			var_1B = (1,1,0.5);
			if(var_08)
			{
				var_1B = (1,0.65,0);
			}

			thread xppointspopup(param_01,var_07,var_1B,0);
			if(param_00 == "assist")
			{
				if(isdefined(self.taggedassist))
				{
					self.taggedassist = undefined;
				}
				else
				{
					var_06 = &"MP_ASSIST";
					if(maps\mp\_utility::func_27AF("specialty_assists"))
					{
						if(!self.pers["assistsToKill"] % 2)
						{
							var_06 = &"MP_ASSIST_TO_KILL";
						}
					}

					thread xpeventpopup(var_06);
				}
			}
		}
	}

	switch(param_00)
	{
		case "jugg_on_jugg":
		case "kill_juggernaut":
		case "kill_as_juggernaut":
		case "got_juggernaut":
		case "dropped_enemy_gun_rank":
		case "gained_gun_rank":
		case "final_rogue":
		case "survivor":
		case "draft_rogue":
		case "kill_carrier":
		case "kill_bonus":
		case "team_assist":
		case "tags_retrieved":
		case "kill_denied":
		case "kill_confirmed":
		case "defuse":
		case "plant":
		case "pickup":
		case "return":
		case "assault":
		case "defend":
		case "capture":
		case "teamkill":
		case "assist":
		case "headshot":
		case "kill":
		case "suicide":
			self.pers["summary"]["score"] = self.pers["summary"]["score"] + param_01;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + param_01;
			break;

		case "tie":
		case "loss":
		case "win":
			self.pers["summary"]["match"] = self.pers["summary"]["match"] + param_01;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + param_01;
			break;

		case "challenge":
			self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + param_01;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + param_01;
			break;

		default:
			self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + param_01;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + param_01;
			break;
	}
}

//Function Number: 23
func_328C(param_00,param_01)
{
	if(self isitemunlocked("cac") && !maps\mp\_utility::isjuggernaut() && isdefined(param_00) && isdefined(param_01) && !maps\mp\_utility::func_2829(param_00))
	{
		if(maps\mp\_utility::func_297E(param_01))
		{
			return 1;
		}

		if(isexplosivedamagemod(param_01) || param_01 == "MOD_IMPACT")
		{
			if(maps\mp\_utility::getweaponclass(param_00) == "weapon_projectile" || maps\mp\_utility::getweaponclass(param_00) == "weapon_assault")
			{
				return 1;
			}
		}

		if(param_01 == "MOD_MELEE")
		{
			if(maps\mp\_utility::getweaponclass(param_00) == "weapon_riot")
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 24
func_0EB5(param_00)
{
	var_01 = getrank();
	if(var_01 == self.pers["rank"])
	{
		return 0;
	}

	var_02 = self.pers["rank"];
	self.pers["rank"] = var_01;
	self setrank(var_01);
	return 1;
}

//Function Number: 25
func_2880(param_00,param_01)
{
	var_02 = func_2881(param_01);
	if(var_02 == self getplayerdata("weaponRank",param_01))
	{
		return 0;
	}

	self.pers["weaponRank"] = var_02;
	self setplayerdata("weaponRank",param_01,var_02);
	thread maps\mp\gametypes\_missions::func_326B(param_01);
	return 1;
}

//Function Number: 26
updaterankannouncehud()
{
	self endon("disconnect");
	self notify("update_rank");
	self endon("update_rank");
	var_00 = self.pers["team"];
	if(!isdefined(var_00))
	{
		return;
	}

	if(!maps\mp\_utility::levelflag("game_over"))
	{
		level common_scripts\utility::waittill_notify_or_timeout("game_over",0.25);
	}

	var_01 = getrankinfofull(self.pers["rank"]);
	var_02 = level.ranktable[self.pers["rank"]][1];
	var_03 = int(var_02[var_02.size - 1]);
	thread maps\mp\gametypes\_hud_message::func_320F();
	if(var_03 > 1)
	{
		return;
	}

	for(var_04 = 0;var_04 < level.players.size;var_04++)
	{
		var_05 = level.players[var_04];
		var_06 = var_05.pers["team"];
		if(isdefined(var_06) && var_05 != self)
		{
			if(var_06 == var_00)
			{
				var_05 iprintln(&"RANK_PLAYER_WAS_PROMOTED",self,var_01);
			}
		}
	}
}

//Function Number: 27
func_328E()
{
	self endon("disconnect");
	self notify("update_weapon_rank");
	self endon("update_weapon_rank");
	var_00 = self.pers["team"];
	if(!isdefined(var_00))
	{
		return;
	}

	if(!maps\mp\_utility::levelflag("game_over"))
	{
		level common_scripts\utility::waittill_notify_or_timeout("game_over",0.25);
	}

	thread maps\mp\gametypes\_hud_message::weaponpromotionsplashnotify();
}

//Function Number: 28
func_2F02()
{
	var_00 = self;
}

//Function Number: 29
createxppointspopup()
{
	var_00 = newclienthudelem(self);
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.x = 30;
	if(level.splitscreen)
	{
		var_00.y = -30;
	}
	else
	{
		var_00.y = -50;
	}

	var_00.font = "hudbig";
	var_00.fontscale = 0.65;
	var_00.archived = 0;
	var_00.color = (0.5,0.5,0.5);
	var_00.sort = 10000;
	var_00 maps\mp\gametypes\_hud::fontpulseinit(3);
	return var_00;
}

//Function Number: 30
xppointspopup(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	if(param_00 == 0)
	{
		return;
	}

	self notify("xpPointsPopup");
	self endon("xpPointsPopup");
	self.xpupdatetotal = self.xpupdatetotal + param_00;
	self.bonusupdatetotal = self.bonusupdatetotal + param_01;
	wait 0.05;
	if(self.xpupdatetotal < 0)
	{
		self.hud_xppointspopup.label = &"";
	}
	else
	{
		self.hud_xppointspopup.label = &"MP_PLUS";
	}

	self.hud_xppointspopup.color = param_02;
	self.hud_xppointspopup.glowcolor = param_02;
	self.hud_xppointspopup.glowalpha = param_03;
	self.hud_xppointspopup setvalue(self.xpupdatetotal);
	self.hud_xppointspopup.alpha = 0.85;
	self.hud_xppointspopup thread maps\mp\gametypes\_hud::fontpulse(self);
	var_04 = max(int(self.bonusupdatetotal / 20),1);
	if(self.bonusupdatetotal)
	{
		while(self.bonusupdatetotal > 0)
		{
			self.xpupdatetotal = self.xpupdatetotal + min(self.bonusupdatetotal,var_04);
			self.bonusupdatetotal = self.bonusupdatetotal - min(self.bonusupdatetotal,var_04);
			self.hud_xppointspopup setvalue(self.xpupdatetotal);
			wait 0.05;
		}
	}
	else
	{
		wait 1;
	}

	self.hud_xppointspopup fadeovertime(0.75);
	self.hud_xppointspopup.alpha = 0;
	self.xpupdatetotal = 0;
}

//Function Number: 31
createxpeventpopup()
{
	var_00 = newclienthudelem(self);
	var_00.children = [];
	var_00.horzalign = "center";
	var_00.vertalign = "middle";
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.x = 55;
	if(level.splitscreen)
	{
		var_00.y = -20;
	}
	else
	{
		var_00.y = -35;
	}

	var_00.font = "hudbig";
	var_00.fontscale = 0.65;
	var_00.archived = 0;
	var_00.color = (0.5,0.5,0.5);
	var_00.sort = 10000;
	var_00.elemtype = "msgText";
	var_00 maps\mp\gametypes\_hud::fontpulseinit(3);
	return var_00;
}

//Function Number: 32
xpeventpopupfinalize(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self notify("xpEventPopup");
	self endon("xpEventPopup");
	if(level.hardcoremode)
	{
		return;
	}

	wait 0.05;
	if(!isdefined(param_01))
	{
		param_01 = (1,1,0.5);
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(self))
	{
		return;
	}

	self.hud_xpeventpopup.color = param_01;
	self.hud_xpeventpopup.glowcolor = param_01;
	self.hud_xpeventpopup.glowalpha = param_02;
	self.hud_xpeventpopup settext(param_00);
	self.hud_xpeventpopup.alpha = 0.85;
	wait 1;
	if(!isdefined(self))
	{
		return;
	}

	self.hud_xpeventpopup fadeovertime(0.75);
	self.hud_xpeventpopup.alpha = 0;
	self notify("PopComplete");
}

//Function Number: 33
xpeventpopupterminate()
{
	self endon("PopComplete");
	common_scripts\utility::waittill_any("joined_team","joined_spectators");
	self.hud_xpeventpopup fadeovertime(0.05);
	self.hud_xpeventpopup.alpha = 0;
}

//Function Number: 34
xpeventpopup(param_00,param_01,param_02)
{
	thread xpeventpopupfinalize(param_00,param_01,param_02);
	thread xpeventpopupterminate();
}

//Function Number: 35
removerankhud()
{
	self.hud_xppointspopup.alpha = 0;
}

//Function Number: 36
getrank()
{
	var_00 = self.pers["rankxp"];
	var_01 = self.pers["rank"];
	if(var_00 < getrankinfominxp(var_01) + func_0ECE(var_01))
	{
		return var_01;
	}

	return getrankforxp(var_00);
}

//Function Number: 37
func_2881(param_00)
{
	var_01 = self getplayerdata("weaponXP",param_00);
	return func_3295(var_01,param_00);
}

//Function Number: 38
func_3292(param_00)
{
	return getrankforxp(param_00);
}

//Function Number: 39
func_3293(param_00)
{
	return func_3295(param_00);
}

//Function Number: 40
func_3294()
{
	var_00 = self getcurrentweapon();
	if(isdefined(var_00))
	{
		return self getplayerdata("weaponXP",var_00);
	}

	return 0;
}

//Function Number: 41
getrankforxp(param_00)
{
	var_01 = 0;
	for(var_02 = level.ranktable[var_01][1];isdefined(var_02) && var_02 != "";var_02 = undefined)
	{
		if(param_00 < getrankinfominxp(var_01) + func_0ECE(var_01))
		{
			return var_01;
		}

		var_01++;
		if(isdefined(level.ranktable[var_01]))
		{
			var_02 = level.ranktable[var_01][1];
			continue;
		}
	}

	var_01--;
	return var_01;
}

//Function Number: 42
func_3295(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_02 = tablelookup("mp/statstable.csv",4,param_01,2);
	var_03 = int(tablelookup("mp/weaponRankTable.csv",0,var_02,1));
	for(var_04 = 0;var_04 < var_03 + 1;var_04++)
	{
		if(param_00 < func_3280(var_04) + getweaponrankinfoxpamt(var_04))
		{
			return var_04;
		}
	}

	return var_04 - 1;
}

//Function Number: 43
getspm()
{
	var_00 = getrank() + 1;
	return 3 + var_00 * 0.5 * 10;
}

//Function Number: 44
getprestigelevel()
{
	return maps\mp\gametypes\_persistence::func_2B58("prestige");
}

//Function Number: 45
getrankxp()
{
	return self.pers["rankxp"];
}

//Function Number: 46
func_3297(param_00)
{
	return self getplayerdata("weaponXP",param_00);
}

//Function Number: 47
func_3298(param_00)
{
	var_01 = tablelookup("mp/statstable.csv",4,param_00,2);
	var_02 = int(tablelookup("mp/weaponRankTable.csv",0,var_01,1));
	var_03 = func_3282(var_02);
	return var_03;
}

//Function Number: 48
isweaponmaxrank(param_00)
{
	var_01 = self getplayerdata("weaponXP",param_00);
	var_02 = func_3298(param_00);
	return var_01 >= var_02;
}

//Function Number: 49
incrankxp(param_00)
{
	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(isdefined(self.ischeater))
	{
		return;
	}

	var_01 = getrankxp();
	var_02 = int(min(var_01,getrankinfomaxxp(level.maxrank))) + param_00;
	if(self.pers["rank"] == level.maxrank && var_02 >= getrankinfomaxxp(level.maxrank))
	{
		var_02 = getrankinfomaxxp(level.maxrank);
	}

	self.pers["rankxp"] = var_02;
}

//Function Number: 50
getrestxpaward(param_00)
{
	if(!getdvarint("scr_restxp_enable"))
	{
		return 0;
	}

	var_01 = getdvarfloat("scr_restxp_restedAwardScale");
	var_02 = int(param_00 * var_01);
	var_03 = self getplayerdata("restXPGoal") - getrankxp();
	if(var_03 <= 0)
	{
		return 0;
	}

	return var_02;
}

//Function Number: 51
islastrestxpaward(param_00)
{
	if(!getdvarint("scr_restxp_enable"))
	{
		return 0;
	}

	var_01 = getdvarfloat("scr_restxp_restedAwardScale");
	var_02 = int(param_00 * var_01);
	var_03 = self getplayerdata("restXPGoal") - getrankxp();
	if(var_03 <= 0)
	{
		return 0;
	}

	if(var_02 >= var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 52
func_329E()
{
	if(level.xpscale > 4 || level.xpscale <= 0)
	{
		exitlevel(0);
	}

	var_00 = getrankxp();
	maps\mp\gametypes\_persistence::func_2CD1("experience",var_00);
}