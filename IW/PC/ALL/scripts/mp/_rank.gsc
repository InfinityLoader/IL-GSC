/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_rank.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 1757 ms
 * Timestamp: 10/27/2023 12:21:26 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_EC3A = [];
	var_00 = getdvarint("online_mp_xpscale");
	if(var_00 > 4 || var_00 < 0)
	{
		exitlevel(0);
	}

	func_17CA(var_00,"online_mp_xpscale");
	level.var_DCD6 = [];
	level.var_13CBD = [];
	level.var_B4C0 = int(tablelookup("mp/rankTable.csv",0,"maxrank",1));
	for(var_01 = 0;var_01 <= level.var_B4C0;var_01++)
	{
		level.var_DCD6[var_01]["minXP"] = tablelookup("mp/rankTable.csv",0,var_01,2);
		level.var_DCD6[var_01]["xpToNext"] = tablelookup("mp/rankTable.csv",0,var_01,3);
		level.var_DCD6[var_01]["maxXP"] = tablelookup("mp/rankTable.csv",0,var_01,7);
		level.var_DCD6[var_01]["splash"] = tablelookup("mp/rankTable.csv",0,var_01,15);
	}

	scripts\mp\_weaponrank::init();
	scripts\mp\_missions::func_31D7();
	level.prestigeextras = [];
	var_02 = 0;
	for(;;)
	{
		var_03 = tablelookupbyrow("mp/unlocks/prestigeExtrasUnlocks.csv",var_02,0);
		if(!isdefined(var_03) || var_03 == "")
		{
			break;
		}

		level.prestigeextras[var_03] = 1;
		var_02++;
	}

	level thread func_C56E();
}

//Function Number: 2
func_9F1E(param_00)
{
	if(isdefined(level.var_EC3A[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
func_DF0A(param_00,param_01,param_02)
{
	level.var_EC3A[param_00][param_01] = param_02;
	if(param_00 == "kill" && param_01 == "value")
	{
		setomnvar("ui_game_type_kill_value",int(param_02));
	}
}

//Function Number: 4
func_8104(param_00)
{
	var_01 = "scr_" + level.gametype + "_score_" + param_00;
	if(getdvar(var_01) != "")
	{
		return getdvarint(var_01);
	}

	return level.var_EC3A[param_00]["value"];
}

//Function Number: 5
func_8102(param_00,param_01)
{
	switch(param_01)
	{
		case "value":
			var_02 = "scr_" + level.gametype + "_score_" + param_00;
			if(getdvar(var_02) != "")
			{
				return getdvarint(var_02);
			}
			else
			{
				return level.var_EC3A[param_00]["value"];
			}
	
			break;

		default:
			return level.var_EC3A[param_00][param_01];
	}
}

//Function Number: 6
func_80CF(param_00)
{
	return int(level.var_DCD6[param_00]["minXP"]);
}

//Function Number: 7
func_80D1(param_00)
{
	return int(level.var_DCD6[param_00]["xpToNext"]);
}

//Function Number: 8
func_80CE(param_00)
{
	return int(level.var_DCD6[param_00]["maxXP"]);
}

//Function Number: 9
func_80D0(param_00)
{
	var_01 = getdvarint("scr_beta_max_level",0);
	if(var_01 > 0 && param_00 + 1 >= var_01)
	{
		return "ranked_up_beta_max";
	}

	return level.var_DCD6[param_00]["splash"];
}

//Function Number: 10
func_80CB(param_00)
{
	return tablelookupistring("mp/rankTable.csv",0,param_00,16);
}

//Function Number: 11
func_80CC(param_00,param_01)
{
	return tablelookup("mp/rankIconTable.csv",0,param_00,param_01 + 1);
}

//Function Number: 12
func_80CD(param_00)
{
	return int(tablelookup("mp/rankTable.csv",0,param_00,13));
}

//Function Number: 13
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00))
		{
			if(var_00 scripts\mp\_utility::func_DCD5())
			{
				var_00.pers["rankxp"] = var_00 getplayerdata("mp","progression","playerLevel","xp");
				var_01 = var_00 getplayerdata("mp","progression","playerLevel","prestige");
				if(!isdefined(var_00.pers["xpEarnedThisMatch"]))
				{
					var_00.pers["xpEarnedThisMatch"] = 0;
				}
			}
			else
			{
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

		var_02 = var_00 func_80C9(var_00 func_80D2());
		var_00.pers["rank"] = var_02;
		var_00 method_832D(var_02,var_01);
		if(var_00.var_41F0 < level.var_B4B0)
		{
			setmatchdata("players",var_00.var_41F0,"rank",var_02);
			setmatchdata("players",var_00.var_41F0,"Prestige",var_01);
			if(!isai(var_00) && scripts\mp\_utility::func_D957() || scripts\mp\_utility::func_B3EC())
			{
				setmatchdata("players",var_00.var_41F0,"isSplitscreen",var_00 issplitscreenplayer());
			}
		}

		var_00.pers["participation"] = 0;
		var_00.var_EC53 = 0;
		var_00.var_EC43 = 0;
		var_00.var_EC30 = [];
		var_00.var_D702 = 0;
		var_00 setclientdvar("ui_promotion",0);
		if(!isdefined(var_00.pers["summary"]))
		{
			var_00.pers["summary"] = [];
			var_00.pers["summary"]["xp"] = 0;
			var_00.pers["summary"]["score"] = 0;
			var_00.pers["summary"]["challenge"] = 0;
			var_00.pers["summary"]["match"] = 0;
			var_00.pers["summary"]["misc"] = 0;
			var_00.pers["summary"]["medal"] = 0;
			var_00.pers["summary"]["bonusXP"] = 0;
		}

		var_00 setclientdvar("ui_opensummary",0);
		var_00 thread scripts\mp\_missions::func_12E71();
		var_00 thread func_C57B();
		var_00 thread func_C575();
		if(var_00 scripts\mp\_utility::func_DCD5())
		{
			var_03 = getdvarint("online_mp_party_xpscale");
			var_04 = var_00 method_85BE() > 1;
			if(var_04)
			{
				var_00 func_1817(var_03,"online_mp_party_xpscale");
			}

			if(var_00 getplayerdata("mp","prestigeDoubleWeaponXp"))
			{
				var_00.var_D882 = 1;
			}
			else
			{
				var_00.var_D882 = 0;
			}
		}

		var_00.var_EC29 = 0;
		var_00.var_EC2B = 0;
		var_00 setclientomnvar("ui_score_event_control",-1);
	}
}

//Function Number: 14
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		if(isai(self))
		{
			self.pers["rankxp"] = scripts\mp\_utility::func_7BF8();
		}
		else if(!level.rankedmatch)
		{
			self.pers["rankxp"] = 0;
		}
		else
		{
		}

		func_D458();
	}
}

//Function Number: 15
func_D458()
{
	if(self.pers["rankxp"] < 0)
	{
		self.pers["rankxp"] = 0;
	}

	var_00 = func_80C9(func_80D2());
	self.pers["rank"] = var_00;
	if(isai(self) || !isdefined(self.pers["prestige"]))
	{
		if(level.rankedmatch && isdefined(self.var_316E))
		{
			var_01 = func_8098();
		}
		else
		{
			var_01 = 0;
		}

		self method_832D(var_00,var_01);
		self.pers["prestige"] = var_01;
	}

	if(isdefined(self.var_41F0) && self.var_41F0 < level.var_B4B0)
	{
		setmatchdata("players",self.var_41F0,"rank",var_00);
		setmatchdata("players",self.var_41F0,"Prestige",self.pers["prestige"]);
	}
}

//Function Number: 16
func_C575()
{
	self endon("disconnect");
	for(;;)
	{
		scripts\common\utility::waittill_any_3("giveLoadout","changed_kit");
		if(issubstr(self.var_4004,"custom"))
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

//Function Number: 17
func_839A(param_00,param_01,param_02)
{
	self endon("disconnect");
	if(isdefined(self.var_222) && !isbot(self))
	{
		self.var_222 func_839A(param_00,param_01,param_02);
		return;
	}

	if(isai(self) || !isplayer(self))
	{
		return;
	}

	if(!scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	if(!isdefined(param_01) || param_01 == 0)
	{
		return;
	}

	var_03 = func_8102(param_00,"group");
	if(!isdefined(param_02))
	{
		if(var_03 == "medal" || var_03 == "kill_killstreak")
		{
			param_02 = self getcurrentweapon();
		}
	}

	if(!isdefined(level.var_72DA) || !level.var_72DA)
	{
		if(level.teambased && !level.var_115C6["allies"] || !level.var_115C6["axis"])
		{
			return;
		}
		else if(!level.teambased && level.var_115C6["allies"] + level.var_115C6["axis"] < 2)
		{
			return;
		}
	}

	var_04 = func_8102(param_00,"allowBonus");
	var_05 = 1;
	var_06 = param_01;
	var_07 = 0;
	if(scripts\mp\_utility::func_9FB3(var_04))
	{
		var_05 = func_80D4();
		var_06 = int(param_01 * var_05);
		var_07 = int(max(var_06 - param_01,0));
	}

	var_08 = func_80D2();
	func_93E3(var_06);
	if(func_12EFA(var_08))
	{
		thread func_12EFB();
	}

	func_11390();
	if(isdefined(param_02) && scripts\mp\_weaponrank::func_13CCA(param_02))
	{
		thread scripts\mp\_weaponrank::func_8394(param_02,param_00,param_01);
	}

	func_DDF7(param_00,param_01,var_07);
	var_09 = func_8098();
	var_0A = func_80C8();
	thread scripts\mp\_analyticslog::func_AFA2(var_09,var_0A,param_01,param_00);
}

//Function Number: 18
func_DDF7(param_00,param_01,param_02)
{
	var_03 = param_01 + param_02;
	var_04 = func_8102(param_00,"group");
	if(!isdefined(var_04) || var_04 == "")
	{
		self.pers["summary"]["misc"] = self.pers["summary"]["misc"] + param_01;
		self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + param_02;
		self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_03;
		return;
	}

	switch(var_04)
	{
		case "match_bonus":
			self.pers["summary"]["match"] = self.pers["summary"]["match"] + param_01;
			self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + param_02;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_03;
			break;

		case "challenge":
			self.pers["summary"]["challenge"] = self.pers["summary"]["challenge"] + param_01;
			self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + param_02;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_03;
			break;

		case "medal":
			self.pers["summary"]["medal"] = self.pers["summary"]["medal"] + param_01;
			self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + param_02;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_03;
			break;

		default:
			self.pers["summary"]["score"] = self.pers["summary"]["score"] + param_01;
			self.pers["summary"]["bonusXP"] = self.pers["summary"]["bonusXP"] + param_02;
			self.pers["summary"]["xp"] = self.pers["summary"]["xp"] + var_03;
			break;
	}
}

//Function Number: 19
func_12EFA(param_00)
{
	var_01 = func_80C8();
	if(var_01 == self.pers["rank"] || self.pers["rank"] == level.var_B4C0)
	{
		return 0;
	}

	var_02 = self.pers["rank"];
	self.pers["rank"] = var_01;
	self method_832D(var_01);
	return 1;
}

//Function Number: 20
func_12EFB()
{
	self endon("disconnect");
	self notify("update_rank");
	self endon("update_rank");
	var_00 = self.pers["team"];
	if(!isdefined(var_00))
	{
		return;
	}

	if(!scripts\mp\_utility::func_ABF0("game_over"))
	{
		level scripts\common\utility::waittill_notify_or_timeout("game_over",0.25);
	}

	var_01 = self.pers["rank"];
	var_02 = func_80D0(var_01);
	if(isdefined(var_02) && var_02 != "")
	{
		thread scripts\mp\_hud_message::func_10151(var_02,var_01 + 1);
	}

	for(var_03 = 0;var_03 < level.players.size;var_03++)
	{
		var_04 = level.players[var_03];
		var_05 = var_04.pers["team"];
		if(isdefined(var_05) && var_05 == var_00)
		{
			var_04 iprintln(&"RANK_PLAYER_WAS_PROMOTED",self,var_01 + 1);
		}
	}
}

//Function Number: 21
func_DB97(param_00)
{
	self.var_EC43 = self.var_EC43 + param_00;
}

//Function Number: 22
func_6F78()
{
	func_EC42(self.var_EC43);
	self.var_EC43 = 0;
}

//Function Number: 23
func_6F79()
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self notify("flushScorePointsPopupQueueOnSpawn()");
	self endon("flushScorePointsPopupQueueOnSpawn()");
	self waittill("spawned_player");
	wait(0.1);
	func_6F78();
}

//Function Number: 24
func_EC42(param_00,param_01)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	if(param_00 == 0)
	{
		return;
	}

	if(!scripts\mp\_utility::func_9F19(self) && !self ismlgspectator())
	{
		if(!scripts\mp\_utility::func_9FB3(param_01) || scripts\mp\_utility::func_9E4A())
		{
			func_DB97(param_00);
			thread func_6F79();
			return;
		}
	}

	self notify("scorePointsPopup");
	self endon("scorePointsPopup");
	self.var_EC53 = self.var_EC53 + param_00;
	self setclientomnvar("ui_points_popup",self.var_EC53);
	self setclientomnvar("ui_points_popup_notify",gettime());
	wait(1);
	self.var_EC53 = 0;
}

//Function Number: 25
func_C16F()
{
	scripts\common\utility::func_136F7();
	level notify("update_player_score",self,self.var_EC53);
}

//Function Number: 26
func_DB96(param_00)
{
	self.var_EC30[self.var_EC30.size] = param_00;
}

//Function Number: 27
func_6F76()
{
	foreach(var_01 in self.var_EC30)
	{
		func_EC2D(var_01);
	}

	self.var_EC30 = [];
}

//Function Number: 28
func_6F77()
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self notify("flushScoreEventPopupQueueOnSpawn()");
	self endon("flushScoreEventPopupQueueOnSpawn()");
	self waittill("spawned_player");
	wait(0.1);
	func_6F76();
}

//Function Number: 29
func_EC2D(param_00)
{
	if(isdefined(self.var_222))
	{
		self.var_222 func_EC2D(param_00);
	}

	if(!isplayer(self))
	{
		return;
	}

	var_01 = func_8102(param_00,"eventID");
	var_02 = func_8102(param_00,"text");
	if(!isdefined(var_01) || var_01 < 0 || !isdefined(var_02) || var_02 == "")
	{
		return;
	}

	if(!scripts\mp\_utility::func_9F19(self) && !self ismlgspectator())
	{
		func_DB96(param_00);
		thread func_6F77();
		return;
	}

	if(!isdefined(self.var_EC2C))
	{
		self.var_EC2C = 1;
		thread func_41D7();
	}
	else
	{
		self.var_EC2C++;
		if(self.var_EC2C > 8)
		{
			self.var_EC2C = 8;
			return;
		}
	}

	self setclientomnvar("ui_score_event_list_" + self.var_EC2B,var_01);
	self setclientomnvar("ui_score_event_control",self.var_EC29 % 16);
	self.var_EC2B++;
	self.var_EC2B = self.var_EC2B % 8;
	self.var_EC29++;
}

//Function Number: 30
func_41D7()
{
	self endon("disconnect");
	self notify("clearScoreEventListAfterWait()");
	self endon("clearScoreEventListAfterWait()");
	scripts\common\utility::waittill_notify_or_timeout("death",0.5);
	self.var_EC2C = undefined;
}

//Function Number: 31
func_80C8()
{
	var_00 = self.pers["rankxp"];
	var_01 = self.pers["rank"];
	if(var_00 < func_80CF(var_01) + func_80D1(var_01))
	{
		return var_01;
	}

	return func_80C9(var_00);
}

//Function Number: 32
func_80C9(param_00)
{
	for(var_01 = level.var_B4C0;var_01 > 0;var_01--)
	{
		if(param_00 >= func_80CF(var_01) && param_00 < func_80CF(var_01) + func_80D1(var_01))
		{
			return var_01;
		}
	}

	return var_01;
}

//Function Number: 33
func_7F8F()
{
	var_00 = func_80C8() + 1;
	return 3 + var_00 * 0.5 * 10;
}

//Function Number: 34
func_8098()
{
	if(isai(self) && isdefined(self.pers["prestige_fake"]))
	{
		return self.pers["prestige_fake"];
	}

	return self getplayerdata("mp","progression","playerLevel","prestige");
}

//Function Number: 35
func_80D2()
{
	return self.pers["rankxp"];
}

//Function Number: 36
func_93E3(param_00)
{
	if(!scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	if(isai(self))
	{
		return;
	}

	var_01 = getdvarint("scr_beta_max_level",0);
	if(var_01 > 0 && func_80C8() + 1 >= var_01)
	{
		param_00 = 0;
	}

	var_02 = func_80D2();
	var_03 = int(min(var_02 + param_00,func_80CE(level.var_B4C0) - 1));
	if(self.pers["rank"] == level.var_B4C0 && var_03 >= func_80CE(level.var_B4C0))
	{
		var_03 = func_80CE(level.var_B4C0);
	}

	self.pers["xpEarnedThisMatch"] = self.pers["xpEarnedThisMatch"] + param_00;
	self.pers["rankxp"] = var_03;
}

//Function Number: 37
func_11390()
{
	var_00 = func_80D2();
	self setplayerdata("mp","progression","playerLevel","xp",var_00);
}

//Function Number: 38
func_5118(param_00,param_01,param_02)
{
	wait(param_00);
	thread scripts\mp\_utility::func_83B4(param_01);
}

//Function Number: 39
func_17CA(param_00,param_01)
{
	level func_1817(param_00,param_01);
}

//Function Number: 40
func_7ED9()
{
	var_00 = level func_80D3();
	if(var_00 > 4 || var_00 < 0)
	{
		exitlevel(0);
	}

	return var_00;
}

//Function Number: 41
func_1817(param_00,param_01)
{
	if(!isdefined(self.var_DCD7))
	{
		self.var_DCD7 = [];
	}

	if(isdefined(self.var_DCD7[param_01]))
	{
		self.var_DCD7[param_01] = max(self.var_DCD7[param_01],param_00);
		return;
	}

	self.var_DCD7[param_01] = param_00;
}

//Function Number: 42
func_80D3()
{
	if(!isdefined(self.var_DCD7))
	{
		return 1;
	}

	var_00 = 1;
	foreach(var_02 in self.var_DCD7)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		var_00 = var_00 * var_02;
	}

	return var_00;
}

//Function Number: 43
func_E125(param_00)
{
	level func_E15F(param_00);
}

//Function Number: 44
func_E15F(param_00)
{
	if(!isdefined(self.var_DCD7))
	{
		return;
	}

	if(!isdefined(self.var_DCD7[param_00]))
	{
		return;
	}

	self.var_DCD7[param_00] = undefined;
}

//Function Number: 45
func_1835(param_00,param_01,param_02)
{
	if(!level.teambased)
	{
		param_01 = "all";
	}

	if(!isdefined(self.var_115E5))
	{
		level.var_115E5 = [];
	}

	if(!isdefined(level.var_115E5[param_01]))
	{
		level.var_115E5[param_01] = [];
	}

	if(isdefined(level.var_115E5[param_01][param_02]))
	{
		level.var_115E5[param_01][param_02] = max(self.var_115E5[param_01][param_02],param_00);
		return;
	}

	level.var_115E5[param_01][param_02] = param_00;
}

//Function Number: 46
func_E17C(param_00,param_01)
{
	if(!level.teambased)
	{
		param_00 = "all";
	}

	if(!isdefined(level.var_115E5))
	{
		return;
	}

	if(!isdefined(level.var_115E5[param_00]))
	{
		return;
	}

	if(!isdefined(level.var_115E5[param_00][param_01]))
	{
		return;
	}

	level.var_115E5[param_00][param_01] = undefined;
}

//Function Number: 47
func_81B6(param_00)
{
	if(!level.teambased)
	{
		param_00 = "all";
	}

	if(!isdefined(level.var_115E5) || !isdefined(level.var_115E5[param_00]))
	{
		return 1;
	}

	var_01 = 1;
	foreach(var_03 in level.var_115E5[param_00])
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_01 = var_01 * var_03;
	}

	return var_01;
}

//Function Number: 48
func_80D4()
{
	var_00 = func_80D3();
	var_01 = func_7ED9();
	var_02 = func_81B6(self.team);
	return var_00 * var_01 * var_02;
}