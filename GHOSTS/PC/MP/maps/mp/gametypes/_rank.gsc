/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_rank.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 999 ms
 * Timestamp: 10/27/2023 1:19:01 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.scoreinfo = [];
	level.xpscale = getdvarint("scr_xpscale");
	if(level.xpscale > 4 || level.xpscale < 0)
	{
		exitlevel(0);
	}

	level.xpscale = min(level.xpscale,4);
	level.xpscale = max(level.xpscale,0);
	level.teamxpscale["axis"] = 1;
	level.teamxpscale["allies"] = 1;
	level.ranktable = [];
	level.weaponranktable = [];
	level.maxrank = int(tablelookup("mp/rankTable.csv",0,"maxrank",1));
	level.maxprestige = int(tablelookup("mp/rankTable.csv",0,"maxprestige",1));
	level.maxforbotmatch = getdvarint("max_xp_per_match",0);
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
	var_03 = tablelookup("mp/rankTable.csv",0,var_02,1);
	while(isdefined(var_03) && var_03 != "")
	{
		level.ranktable[var_02][1] = tablelookup("mp/rankTable.csv",0,var_02,1);
		level.ranktable[var_02][2] = tablelookup("mp/rankTable.csv",0,var_02,2);
		level.ranktable[var_02][3] = tablelookup("mp/rankTable.csv",0,var_02,3);
		level.ranktable[var_02][7] = tablelookup("mp/rankTable.csv",0,var_02,7);
		precachestring(tablelookupistring("mp/rankTable.csv",0,var_02,16));
		var_02++;
		var_03 = tablelookup("mp/rankTable.csv",0,var_02,1);
	}

	var_04 = int(tablelookup("mp/weaponRankTable.csv",0,"maxrank",1));
	for(var_05 = 0;var_05 < var_04 + 1;var_05++)
	{
		level.weaponranktable[var_05][1] = tablelookup("mp/weaponRankTable.csv",0,var_05,1);
		level.weaponranktable[var_05][2] = tablelookup("mp/weaponRankTable.csv",0,var_05,2);
		level.weaponranktable[var_05][3] = tablelookup("mp/weaponRankTable.csv",0,var_05,3);
	}

	maps\mp\gametypes\_missions::func_1857();
	level thread func_5B3B();
	level thread func_595D();
}

//Function Number: 2
func_5B3B()
{
	level endon("game_ended");
	while(!isdefined(level.players) || !level.players.size)
	{
		wait(0.05);
	}

	if(!maps\mp\_utility::func_50C1())
	{
		if(getdvar("mapname") == "mp_rust" && randomint(1000) == 999)
		{
			level.patientzeroname = level.players[0].name;
		}
	}

	if(getdvar("scr_patientZero") != "")
	{
		level.patientzeroname = getdvar("scr_patientZero");
	}
}

//Function Number: 3
func_4946(param_00)
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
	if(param_00 == "kill")
	{
		setomnvar("ui_game_type_kill_value",int(param_01));
	}
}

//Function Number: 5
func_3BE0(param_00)
{
	var_01 = "scr_" + level.gametype + "_score_" + param_00;
	if(getdvar(var_01) != "")
	{
		return getdvarint(var_01);
	}

	return level.scoreinfo[param_00]["value"];
}

//Function Number: 6
func_3BDF(param_00)
{
	return level.scoreinfo[param_00]["label"];
}

//Function Number: 7
func_3BC7(param_00)
{
	return int(level.ranktable[param_00][2]);
}

//Function Number: 8
getweaponrankinfominxp(param_00)
{
	return int(level.weaponranktable[param_00][1]);
}

//Function Number: 9
func_3BC8(param_00)
{
	return int(level.ranktable[param_00][3]);
}

//Function Number: 10
getweaponrankinfoxpamt(param_00)
{
	return int(level.weaponranktable[param_00][2]);
}

//Function Number: 11
func_3BC6(param_00)
{
	return int(level.ranktable[param_00][7]);
}

//Function Number: 12
getweaponrankinfomaxxp(param_00)
{
	return int(level.weaponranktable[param_00][3]);
}

//Function Number: 13
func_3BC3(param_00)
{
	return tablelookupistring("mp/rankTable.csv",0,param_00,16);
}

//Function Number: 14
func_3BC4(param_00,param_01)
{
	return tablelookup("mp/rankIconTable.csv",0,param_00,param_01 + 1);
}

//Function Number: 15
func_3BC5(param_00)
{
	return int(tablelookup("mp/rankTable.csv",0,param_00,13));
}

//Function Number: 16
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00))
		{
			if(maps\mp\_utility::func_50C1())
			{
				var_00.pers["activeSquadMember"] = var_00 getrankedplayerdata("activeSquadMember");
				var_00.pers["rankxp"] = var_00 getrankedplayerdata("squadMembers",var_00.pers["activeSquadMember"],"squadMemXP");
				var_01 = var_00 getrankedplayerdatareservedint("prestigeLevel");
				if(!isdefined(var_00.pers["xpEarnedThisMatch"]))
				{
					var_00.pers["xpEarnedThisMatch"] = 0;
				}
			}
			else
			{
				var_00.pers["activeSquadMember"] = var_00 getprivateplayerdata("privateMatchActiveSquadMember");
				var_01 = 0;
				var_00.pers["rankxp"] = 0;
			}
		}
		else
		{
			var_01 = 0;
			var_00.pers["rankxp"] = 0;
		}

		var_00.pers["prestige"] = var_01;
		if(var_00.pers["rankxp"] < 0)
		{
			var_00.pers["rankxp"] = 0;
		}

		var_02 = var_00 getrankforxp(var_00 func_3BC9());
		var_00.pers["rank"] = var_02;
		var_00 setrank(var_02,var_01);
		if(var_00.clientid < level.maxlogclients)
		{
			setmatchdata("players",var_00.clientid,"rank",var_02);
			setmatchdata("players",var_00.clientid,"Prestige",var_01);
			if(!isai(var_00) && maps\mp\_utility::func_61B9() || maps\mp\_utility::func_50C1())
			{
				setmatchdata("players",var_00.clientid,"isSplitscreen",var_00 issplitscreenplayer());
				setmatchdata("players",var_00.clientid,"activeSquadMember",var_00.pers["activeSquadMember"]);
			}
		}

		var_00.pers["participation"] = 0;
		var_00.xpupdatetotal = 0;
		var_00.bonusupdatetotal = 0;
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
			var_00.pers["summary"]["operation"] = 0;
			var_00.pers["summary"]["challenge"] = 0;
			var_00.pers["summary"]["match"] = 0;
			var_00.pers["summary"]["misc"] = 0;
			var_00.pers["summary"]["entitlementXP"] = 0;
			var_00.pers["summary"]["clanWarsXP"] = 0;
		}

		var_00 setclientdvar("ui_opensummary",0);
		var_00 thread maps\mp\gametypes\_missions::func_86D5();
		var_00.explosivekills[0] = 0;
		var_00.xpgains = [];
		var_00 thread onplayerspawned();
		var_00 thread func_5964();
		if(var_00 maps\mp\_utility::func_634C())
		{
			if(issquadsmode())
			{
				if(var_00 getrankedplayerdata("prestigeDoubleXp"))
				{
					var_00.prestigedoublexp = 1;
				}
				else
				{
					var_00.prestigedoublexp = 0;
				}
			}

			if(var_00 getrankedplayerdata("prestigeDoubleWeaponXp"))
			{
				var_00.prestigedoubleweaponxp = 1;
				continue;
			}

			var_00.prestigedoubleweaponxp = 0;
		}
	}
}

//Function Number: 17
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if(isai(self))
		{
			self.pers["rankxp"] = maps\mp\_utility::func_397A();
		}
		else if(!level.rankedmatch)
		{
			self.pers["rankxp"] = 0;
		}
		else
		{
		}

		playerupdaterank();
	}
}

//Function Number: 18
playerupdaterank()
{
	if(self.pers["rankxp"] < 0)
	{
		self.pers["rankxp"] = 0;
	}

	var_00 = getrankforxp(func_3BC9());
	self.pers["rank"] = var_00;
	if(isai(self) || !isdefined(self.pers["prestige"]))
	{
		if(level.rankedmatch && isdefined(self.bufferedstats))
		{
			var_01 = func_3BA5();
		}
		else
		{
			var_01 = 0;
		}

		self setrank(var_00,var_01);
		self.pers["prestige"] = var_01;
	}

	if(isdefined(self.clientid) && self.clientid < level.maxlogclients)
	{
		setmatchdata("players",self.clientid,"rank",var_00);
		setmatchdata("players",self.clientid,"Prestige",self.pers["prestige"]);
	}
}

//Function Number: 19
func_5964()
{
	self endon("disconnect");
	for(;;)
	{
		common_scripts\utility::func_8B2A("giveLoadout","changed_kit");
		if(issubstr(self.class,"custom"))
		{
			if(!level.rankedmatch)
			{
				self.pers["rankxp"] = 0;
				continue;
			}

			if(isai(self))
			{
				self.pers["rankxp"] = 0;
				continue;
			}
		}
	}
}

//Function Number: 20
roundup(param_00)
{
	if(int(param_00) != param_00)
	{
		return int(param_00 + 1);
	}

	return int(param_00);
}

//Function Number: 21
giverankxp(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(maps\mp\_utility::func_47BB())
	{
	}

	giverankxp_regularmp(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 22
giverankxp_regularmp(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("disconnect");
	var_06 = "none";
	if(isdefined(self.owner) && !isbot(self))
	{
		self.owner giverankxp(param_00,param_01,param_02,param_03,param_04,param_05);
	}

	if(!isbot(self))
	{
		if(isdefined(self.commanding_bot))
		{
			self.commanding_bot giverankxp(param_00,param_01,param_02,param_03,param_04,param_05);
		}
	}

	if(isai(self))
	{
	}

	if(!isplayer(self))
	{
	}

	if(!maps\mp\_utility::func_634C())
	{
		if(param_00 == "assist")
		{
			if(isdefined(self.taggedassist))
			{
				self.taggedassist = undefined;
			}
			else
			{
				var_07 = "assist";
				if(level.gametype == "cranked")
				{
					if(isdefined(self.cranked))
					{
						var_07 = "assist_cranked";
					}
				}

				if(maps\mp\_utility::_hasperk("specialty_assists"))
				{
					if(!self.pers["assistsToKill"] % 2)
					{
						var_07 = "assist_to_kill";
					}
				}

				thread func_8E6E(var_07);
			}
		}
	}

	if(!isdefined(level.forceranking) || !level.forceranking)
	{
		if(level.teambased && !level.teamcount["allies"] || !level.teamcount["axis"])
		{
		}
		else if(!level.teambased && level.teamcount["allies"] + level.teamcount["axis"] < 2)
		{
		}
	}

	if(!isdefined(param_01))
	{
		param_01 = func_3BE0(param_00);
	}

	if(!isdefined(self.xpgains[param_00]))
	{
		self.xpgains[param_00] = 0;
	}

	var_08 = param_01;
	var_09 = 0;
	var_0A = 0;
	if(isdefined(param_05) && maps\mp\_utility::func_3C4B() > 90000)
	{
		var_0B = self;
		if(level.teambased)
		{
			var_0C = common_scripts\utility::func_F0F(level.teamlist[maps\mp\_utility::getotherteam(var_0B.team)],::func_4838);
			var_0D = common_scripts\utility::func_F0F(level.teamlist[var_0B.team],::func_4838);
			if(isdefined(var_0C[0]) && param_05 == var_0C[0])
			{
				if(isdefined(var_0D[1]) && var_0B.score < var_0D[1].score)
				{
					var_08 = var_08 * 2;
					var_0B thread func_8E6E("first_place_kill");
				}
			}
			else if(isdefined(var_0C[1]) && param_05 == var_0C[1])
			{
				if(isdefined(var_0D[2]) && var_0B.score < var_0D[2].score)
				{
					var_08 = var_08 * 1.5;
					var_0B thread func_8E6E("second_place_kill");
				}
			}
		}
		else
		{
			var_0C = common_scripts\utility::func_F0F(level.players,::func_4838);
			if(isdefined(var_0C[0]) && param_05 == var_0C[0])
			{
				if(isdefined(var_0C[1]) && var_0B.score < var_0C[1].score)
				{
					var_08 = var_08 * 2;
					var_0B thread func_8E6E("first_place_kill");
				}
			}
			else if(isdefined(var_0C[1]) && param_05 == var_0C[1])
			{
				if(isdefined(var_0C[2]) && var_0B.score < var_0C[2].score)
				{
					var_08 = var_08 * 1.5;
					var_0B thread func_8E6E("second_place_kill");
				}
			}
			else if(isdefined(var_0C[2]) && param_05 == var_0C[2])
			{
				if(isdefined(var_0C[2]) && var_0B.score < var_0C[2].score)
				{
					var_08 = var_08 * 1.5;
					var_0B thread func_8E6E("third_place_kill");
				}
			}
		}

		var_0E = var_0B.var_4B2E.size + 1;
		if(var_0E > 2)
		{
			if(!var_0E % 5)
			{
				if(!isdefined(var_0B.lastkillsplash) || var_0E != var_0B.lastkillsplash)
				{
					var_0B thread maps\mp\_utility::func_7FA0("callout_kill_streaking",var_0B,undefined,var_0E);
					var_0B.lastkillsplash = var_0E;
				}
			}
		}
	}

	var_0F = 0;
	var_10 = 0;
	switch(param_00)
	{
		case "shield_damage":
		case "headshot":
		case "kill":
			var_08 = var_08 * self.var_8E7B;
			break;

		case "assist":
		case "kill_head":
		case "kill_melee":
		case "kill_normal":
		case "damage_head":
		case "damage_body":
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
		case "obj_return":
		case "defend":
		case "capture":
		case "teamkill":
		case "assault":
		case "suicide":
		case "destroy":
			if(maps\mp\_utility::func_3ABB() > 0 && param_00 != "shield_damage")
			{
				if(!isdefined(level.skiplivesxpscalar) || !level.skiplivesxpscalar)
				{
					if(level.gametype == "sd")
					{
						var_11 = max(1,int(10 / maps\mp\_utility::func_3ABB()));
					}
					else
					{
						var_11 = max(1,int(5 / maps\mp\_utility::func_3ABB()));
					}
	
					var_08 = int(var_08 * var_11);
				}
			}
	
			var_12 = 0;
			if(issquadsmode())
			{
				if(self.prestigedoublexp)
				{
					var_13 = self getrankedplayerdata("prestigeDoubleXpTimePlayed");
					if(var_13 >= self.bufferedstatsmax["prestigeDoubleXpMaxTimePlayed"])
					{
						self setrankedplayerdata("prestigeDoubleXp",0);
						self setrankedplayerdata("prestigeDoubleXpTimePlayed",0);
						self setrankedplayerdata("prestigeDoubleXpMaxTimePlayed",0);
						self.prestigedoublexp = 0;
					}
					else
					{
						var_12 = 1.1;
					}
				}
			}
	
			var_09 = getxpmultiplier();
			var_0A = self getclanwarsbonus();
			if(var_12 > 0)
			{
				var_08 = int(var_08 * var_12);
			}
	
			var_14 = 1;
			if(level.teambased)
			{
				var_14 = level.teamxpscale[self.team];
			}
			else if(isdefined(level.teamxpscale[self getentitynumber()]))
			{
				var_14 = level.teamxpscale[self getentitynumber()];
			}
	
			var_08 = int(var_08 * level.xpscale * var_14);
			if(isdefined(level.nukedetonated) && level.nukedetonated)
			{
				if(level.teambased && level.nukeinfo.team == self.team)
				{
					var_08 = var_08 * level.nukeinfo.xpscalar;
				}
				else if(!level.teambased && level.nukeinfo.player == self)
				{
					var_08 = var_08 * level.nukeinfo.xpscalar;
				}
	
				var_08 = int(var_08);
			}
	
			var_15 = func_3BD5(var_08);
			var_08 = var_08 + var_15;
			if(var_15 > 0)
			{
				if(func_4900(var_08))
				{
					thread maps\mp\gametypes\_hud_message::func_794C("rested_done");
				}
	
				var_10 = 1;
			}
			break;

		case "challenge":
			var_0A = self getclanwarsbonus();
			var_09 = getxpmultiplier();
			break;

		case "operation":
			var_09 = 0;
			if(self getrankedplayerdata("challengeXPMultiplierTimePlayed",0) < self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0])
			{
				var_09 = var_09 + int(self getrankedplayerdata("challengeXPMultiplier",0));
			}
			break;

		default:
			var_0A = self getclanwarsbonus();
			var_09 = getxpmultiplier();
			break;
	}

	if(level.maxforbotmatch && self.pers["xpEarnedThisMatch"] > level.maxforbotmatch)
	{
		if(!isdefined(level.skippointdisplayxp))
		{
			thread func_8E77(var_08,var_0F);
		}

		var_08 = 0;
		if(self.pers["xpEarnedThisMatch"] != 999790)
		{
			thread maps\mp\gametypes\_hud_message::func_794D("max_xp_for_match");
			thread maps\mp\killstreaks\_killstreaks::func_3CF2("airdrop_assault",0,0,self);
			self thread [[ level.leaderdialogonplayer_func ]]("achieve_carepackage",undefined,undefined,self.origin);
			self.pers["xpEarnedThisMatch"] = 999790;
		}
	}

	var_16 = int(max(var_08 * var_09 - var_08,0));
	var_17 = int(var_08 * var_0A);
	var_18 = func_3BC9();
	func_447D(var_08 + var_16 + var_17);
	if(maps\mp\_utility::func_634C() && func_8722(var_18))
	{
		thread func_8723();
		var_19 = getrank();
		if(var_19 < 5)
		{
			giveunlockpoints(5,0);
		}
		else
		{
			giveunlockpoints(2,0);
		}
	}

	func_7E32();
	var_1A = maps\mp\gametypes\_missions::isweaponchallenge(param_04);
	if(var_1A)
	{
		param_02 = self getcurrentweapon();
	}

	if(param_00 == "shield_damage")
	{
		param_02 = self getcurrentweapon();
		param_03 = "MOD_MELEE";
	}

	if(!level.hardcoremode)
	{
		if(!isdefined(level.skippointdisplayxp))
		{
			thread func_8E77(var_08,var_0F);
		}

		if(param_00 == "assist")
		{
			if(isdefined(self.taggedassist))
			{
				self.taggedassist = undefined;
			}
			else
			{
				var_07 = "assist";
				if(level.gametype == "cranked")
				{
					if(isdefined(self.cranked))
					{
						var_07 = "assist_cranked";
					}
				}

				if(maps\mp\_utility::_hasperk("specialty_assists"))
				{
					if(!self.pers["assistsToKill"] % 2)
					{
						var_07 = "assist_to_kill";
					}
				}

				thread func_8E6E(var_07);
			}
		}
	}

	switch(param_00)
	{
		case "assist":
		case "kill_head":
		case "kill_melee":
		case "kill_normal":
		case "damage_head":
		case "damage_body":
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
		case "obj_return":
		case "defend":
		case "capture":
		case "teamkill":
		case "headshot":
		case "kill":
		case "assault":
		case "suicide":
			self.pers["summary"]["score"] = self.pers["summary"]["score"] + var_08;
			self.pers["summary"]["entitlementXP"] = self.pers["summary"]["entitlementXP"] + var_16;
			self.pers["summary"]["clanWarsXP"] = self.pers["summary"]["clanWarsXP"] + var_17;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_08 + var_16 + var_17;
			break;

		case "loss":
		case "win":
		case "tie":
			self.pers["summary"]["match"] = self.pers["summary"]["match"] + var_08;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_08;
			break;

		case "challenge":
			self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + var_08;
			self.pers["summary"]["entitlementXP"] = self.pers["summary"]["entitlementXP"] + var_16;
			self.pers["summary"]["clanWarsXP"] = self.pers["summary"]["clanWarsXP"] + var_17;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_08 + var_16 + var_17;
			break;

		case "operation":
			self.pers["summary"]["entitlementXP"] = self.pers["summary"]["entitlementXP"] + var_16;
			self.pers["summary"]["operation"] = self.pers["summary"]["operation"] + var_08;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_08 + var_16;
			break;

		default:
			self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + var_08;
			self.pers["summary"]["entitlementXP"] = self.pers["summary"]["entitlementXP"] + var_16;
			self.pers["summary"]["clanWarsXP"] = self.pers["summary"]["clanWarsXP"] + var_17;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_08 + var_16 + var_17;
			break;
	}
}

//Function Number: 23
func_4838(param_00,param_01)
{
	return param_00.score > param_01.score;
}

//Function Number: 24
getxpmultiplier()
{
	var_00 = 0;
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		var_02 = self getrankedplayerdata("xpMultiplierTimePlayed",var_01);
		var_03 = self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][var_01];
		if(var_02 < var_03)
		{
			var_00 = var_00 + int(self getrankedplayerdata("xpMultiplier",var_01));
		}
	}

	return var_00;
}

//Function Number: 25
func_8DBF(param_00,param_01)
{
	if(self isitemunlocked("cac") && !maps\mp\_utility::isjuggernaut() && isdefined(param_00) && isdefined(param_01) && !maps\mp\_utility::func_48F7(param_00))
	{
		if(maps\mp\_utility::func_488D(param_01))
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

//Function Number: 26
charactertypebonusxp(param_00,param_01)
{
	var_02 = 1.2;
	if(isdefined(param_00) && isdefined(self.character_type))
	{
		switch(maps\mp\_utility::getweaponclass(param_00))
		{
			case "weapon_smg":
				if(self.character_type == "charactertype_smg")
				{
					param_01 = param_01 * var_02;
				}
				break;

			case "weapon_assault":
				if(self.character_type == "charactertype_assault")
				{
					param_01 = param_01 * var_02;
				}
				break;

			case "weapon_shotgun":
				if(self.character_type == "charactertype_shotgun")
				{
					param_01 = param_01 * var_02;
				}
				break;

			case "weapon_dmr":
				if(self.character_type == "charactertype_dmr")
				{
					param_01 = param_01 * var_02;
				}
				break;

			case "weapon_sniper":
				if(self.character_type == "charactertype_sniper")
				{
					param_01 = param_01 * var_02;
				}
				break;

			case "weapon_lmg":
				if(self.character_type == "charactertype_lmg")
				{
					param_01 = param_01 * var_02;
				}
				break;

			default:
				break;
		}
	}

	return int(param_01);
}

//Function Number: 27
func_8722(param_00)
{
	var_01 = getrank();
	if(var_01 == self.pers["rank"] || self.pers["rank"] == level.maxrank)
	{
		return 0;
	}

	var_02 = self.pers["rank"];
	self.pers["rank"] = var_01;
	self setrank(var_01);
	return 1;
}

//Function Number: 28
func_8723()
{
	self endon("disconnect");
	self notify("update_rank");
	self endon("update_rank");
	var_00 = self.pers["team"];
	if(!isdefined(var_00))
	{
	}

	if(!maps\mp\_utility::levelflag("game_over"))
	{
		level common_scripts\utility::waittill_notify_or_timeout("game_over",0.25);
	}

	var_01 = func_3BC3(self.pers["rank"]);
	var_02 = level.ranktable[self.pers["rank"]][1];
	var_03 = int(var_02[var_02.size - 1]);
	thread maps\mp\gametypes\_hud_message::func_794E("ranked_up",self.pers["rank"]);
	if(var_03 > 1)
	{
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

//Function Number: 29
endgameupdate()
{
	var_00 = self;
}

//Function Number: 30
func_8E77(param_00,param_01)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	if(param_00 == 0)
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self notify("xpPointsPopup");
	self endon("xpPointsPopup");
	self.xpupdatetotal = self.xpupdatetotal + param_00;
	self.bonusupdatetotal = self.bonusupdatetotal + param_01;
	self setclientomnvar("ui_points_popup",self.xpupdatetotal);
	var_02 = max(int(self.bonusupdatetotal / 20),1);
	if(self.bonusupdatetotal)
	{
		while(self.bonusupdatetotal > 0)
		{
			self.xpupdatetotal = self.xpupdatetotal + min(self.bonusupdatetotal,var_02);
			self.bonusupdatetotal = self.bonusupdatetotal - min(self.bonusupdatetotal,var_02);
			wait(0.05);
		}
	}
	else
	{
		wait(1);
	}

	self.xpupdatetotal = 0;
}

//Function Number: 31
func_8E70(param_00)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self notify("xpEventPopup");
	self endon("xpEventPopup");
	if(level.hardcoremode)
	{
	}

	if(!isdefined(self))
	{
	}

	var_01 = tablelookuprownum("mp/xp_event_table.csv",0,param_00);
	if(!isdefined(var_01) || isdefined(var_01) && var_01 == -1)
	{
	}

	self setclientomnvar("ui_points_popup_desc",var_01);
	wait(1);
	if(!isdefined(self))
	{
	}

	self notify("PopComplete");
}

//Function Number: 32
func_8E6E(param_00)
{
	if(maps\mp\_utility::func_47BB())
	{
	}

	func_8E6F(param_00);
}

//Function Number: 33
func_8E6F(param_00)
{
	if(isdefined(self.owner))
	{
		self.owner func_8E6E(param_00);
	}

	if(!isplayer(self))
	{
	}

	thread func_8E70(param_00);
}

//Function Number: 34
getrank()
{
	var_00 = self.pers["rankxp"];
	var_01 = self.pers["rank"];
	if(var_00 < func_3BC7(var_01) + func_3BC8(var_01))
	{
		return var_01;
	}

	return getrankforxp(var_00);
}

//Function Number: 35
func_3C7D(param_00)
{
	var_01 = self getrankedplayerdata("weaponXP",param_00);
	return getweaponrankforxp(var_01,param_00);
}

//Function Number: 36
func_4DBA(param_00)
{
	return getrankforxp(param_00);
}

//Function Number: 37
func_8DAA(param_00)
{
	return getweaponrankforxp(param_00);
}

//Function Number: 38
getcurrentweaponxp()
{
	var_00 = self getcurrentweapon();
	if(isdefined(var_00))
	{
		return self getrankedplayerdata("weaponXP",var_00);
	}

	return 0;
}

//Function Number: 39
getrankforxp(param_00)
{
	var_01 = 0;
	for(var_02 = level.ranktable[var_01][1];isdefined(var_02) && var_02 != "";var_02 = undefined)
	{
		if(param_00 < func_3BC7(var_01) + func_3BC8(var_01))
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

//Function Number: 40
getweaponrankforxp(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_02 = tablelookup("mp/statsTable.csv",4,param_01,2);
	var_03 = int(tablelookup("mp/weaponRankTable.csv",0,var_02,1));
	for(var_04 = 0;var_04 < var_03 + 1;var_04++)
	{
		if(param_00 < getweaponrankinfominxp(var_04) + getweaponrankinfoxpamt(var_04))
		{
			return var_04;
		}
	}

	return var_04 - 1;
}

//Function Number: 41
func_3BFD()
{
	var_00 = getrank() + 1;
	return 3 + var_00 * 0.5 * 10;
}

//Function Number: 42
func_3BA5()
{
	if(isai(self) && isdefined(self.pers["prestige_fake"]))
	{
		return self.pers["prestige_fake"];
	}

	return maps\mp\gametypes\_persistence::func_7B16("prestige");
}

//Function Number: 43
func_3BC9()
{
	return self.pers["rankxp"];
}

//Function Number: 44
getweaponrankxp(param_00)
{
	return self getrankedplayerdata("weaponXP",param_00);
}

//Function Number: 45
getweaponmaxrankxp(param_00)
{
	var_01 = tablelookup("mp/statsTable.csv",4,param_00,2);
	var_02 = int(tablelookup("mp/weaponRankTable.csv",0,var_01,1));
	var_03 = getweaponrankinfomaxxp(var_02);
	return var_03;
}

//Function Number: 46
func_49B8(param_00)
{
	var_01 = self getrankedplayerdata("weaponXP",param_00);
	var_02 = getweaponmaxrankxp(param_00);
	return var_01 >= var_02;
}

//Function Number: 47
giveunlockpoints(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		var_02 = 1;
	}

	var_03 = self.pers["activeSquadMember"];
	var_04 = self getrankedplayerdata("squadMembers",var_03,"commendationsEarned");
	var_04 = var_04 + param_00;
	self setrankedplayerdata("squadMembers",var_03,"commendationsEarned",var_04);
	if(param_01)
	{
		thread maps\mp\gametypes\_hud_message::func_5F9A("earned_unlock",self);
	}

	var_05 = self getrankedplayerdata("unlockPoints");
	var_06 = var_05 + param_00;
	self setrankedplayerdata("unlockPoints",var_06);
}

//Function Number: 48
func_447D(param_00)
{
	if(!maps\mp\_utility::func_634C())
	{
	}

	if(isai(self))
	{
	}

	var_01 = self getrankedplayerdata("points");
	var_02 = var_01 + param_00;
	var_02 = int(clamp(var_02,0,5999));
	if(var_02 >= 3000)
	{
		var_02 = var_02 % 3000;
		self setrankedplayerdata("points",var_02);
		giveunlockpoints(1,1);
	}
	else
	{
		self setrankedplayerdata("points",var_02);
	}

	var_03 = func_3BC9();
	var_04 = int(min(var_03,func_3BC6(level.maxrank))) + param_00;
	if(self.pers["rank"] == level.maxrank && var_04 >= func_3BC6(level.maxrank))
	{
		var_04 = func_3BC6(level.maxrank);
	}

	self.pers["xpEarnedThisMatch"] = self.pers["xpEarnedThisMatch"] + param_00;
	self.pers["rankxp"] = var_04;
}

//Function Number: 49
func_3BD5(param_00)
{
	if(!getdvarint("scr_restxp_enable"))
	{
		return 0;
	}

	var_01 = getdvarfloat("scr_restxp_restedAwardScale");
	var_02 = int(param_00 * var_01);
	var_03 = self getrankedplayerdata("restXPGoal") - func_3BC9();
	if(var_03 <= 0)
	{
		return 0;
	}

	return var_02;
}

//Function Number: 50
func_4900(param_00)
{
	if(!getdvarint("scr_restxp_enable"))
	{
		return 0;
	}

	var_01 = getdvarfloat("scr_restxp_restedAwardScale");
	var_02 = int(param_00 * var_01);
	var_03 = self getrankedplayerdata("restXPGoal") - func_3BC9();
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

//Function Number: 51
func_7E32()
{
	if(level.xpscale > 4 || level.xpscale <= 0)
	{
		exitlevel(0);
	}

	var_00 = func_3BC9();
	var_01 = self.pers["activeSquadMember"];
	self setrankedplayerdata("squadMembers",var_01,"squadMemXP",var_00);
	self setrankedplayerdata("experience",var_00);
	if(var_00 >= func_3BC6(level.maxrank))
	{
		var_03 = self getrankedplayerdata("characterXP",var_01);
		if(var_03 == 0)
		{
			var_04 = getsystemtime();
			self setrankedplayerdata("characterXP",var_01,var_04);
			var_05 = self getrankedplayerdatareservedint("prestigeLevel");
			var_06 = var_05 + 1;
			self setrankedplayerdatareservedint("prestigeLevel",var_06);
			self setrank(level.maxrank,var_06);
			thread maps\mp\gametypes\_hud_message::func_794E("prestige" + var_06);
			var_07 = self.pers["team"];
			for(var_08 = 0;var_08 < level.players.size;var_08++)
			{
				var_09 = level.players[var_08];
				var_0A = var_09.pers["team"];
				if(isdefined(var_0A) && var_09 != self)
				{
					if(var_0A == var_07)
					{
						var_09 iprintln(&"RANK_PLAYER_WAS_PROMOTED",self,&"MPUI_PRESTIGE");
					}
				}
			}
		}
	}
}

//Function Number: 52
createmultipliertext()
{
	var_00 = newclienthudelem(self);
	var_00.horzalign = "center";
	var_00.vertalign = "bottom";
	var_00.alignx = "center";
	var_00.aligny = "middle";
	var_00.x = 70;
	if(level.splitscreen)
	{
		var_00.y = -55;
	}
	else
	{
		var_00.y = -10;
	}

	var_00.font = "default";
	var_00.fontscale = 1.3;
	var_00.archived = 0;
	var_00.color = (1,1,1);
	var_00.sort = 10000;
	var_00 maps\mp\gametypes\_hud::func_349E(1.5);
	return var_00;
}

//Function Number: 53
func_552B(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	level endon("round_end_finished");
	self endon("death");
	self notify("multiplierTextPopup");
	self endon("multiplierTextPopup");
	if(!isdefined(self.hud_multipliertext))
	{
		self.hud_multipliertext = createmultipliertext();
	}

	wait(0.05);
	thread func_552C();
	thread func_552D();
	self.hud_multipliertext settext(param_00);
	for(;;)
	{
		self.hud_multipliertext.alpha = 0.85;
		self.hud_multipliertext thread maps\mp\gametypes\_hud::fontpulse(self);
		wait(1);
		self.hud_multipliertext fadeovertime(0.75);
		self.hud_multipliertext.alpha = 0.25;
		wait(1);
	}
}

//Function Number: 54
func_552C()
{
	self waittill("death");
	if(isdefined(self.hud_multipliertext))
	{
		self.hud_multipliertext.alpha = 0;
	}
}

//Function Number: 55
func_552D()
{
	level waittill("game_ended");
	if(isdefined(self.hud_multipliertext))
	{
		self.hud_multipliertext.alpha = 0;
	}
}