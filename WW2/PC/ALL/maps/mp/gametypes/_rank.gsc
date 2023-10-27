/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_rank.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 604 ms
 * Timestamp: 10/27/2023 3:24:24 AM
*******************************************************************/

//Function Number: 1
func_465B()
{
	if(maps\mp\_utility::iszombiegameshattermode())
	{
		return "mp/zm_shotgun_rankTable.csv";
	}

	if(maps\mp\_utility::func_585F() || maps\mp\gametypes\_hud_util::func_5527())
	{
		return "mp/cp_rankTable.csv";
	}

	return "mp/rankTable.csv";
}

//Function Number: 2
func_00D5()
{
	var_00 = func_465B();
	level.var_7A6E = func_465D();
	level.var_305B = func_44A3();
	level.var_A9FA = func_473E();
	level.var_5F0C = func_4567();
	level.var_AAD1 = [];
	level.var_7A6B = [];
	level.var_609A = int(tablelookup(var_00,0,"maxrank",1));
	level.var_6097 = int(tablelookup(var_00,0,"maxprestige",1));
	level.var_609B = int(tablelookup(var_00,0,"maxrankfinalprestige",1));
	level.var_AAD3 = 0;
	setdvarifuninitialized("spv_rankedPlayMatchBonusXP_win",0);
	setdvarifuninitialized("spv_rankedPlayMatchBonusXP_tie",0);
	setdvarifuninitialized("spv_rankedPlayMatchBonusXP_loss",0);
	var_01 = 0;
	for(var_02 = tablelookup(func_465B(),0,var_01,1);isdefined(var_02) && var_02 != "";var_02 = tablelookup(var_00,0,var_01,1))
	{
		level.var_7A6B[var_01][1] = tablelookup(var_00,0,var_01,1);
		level.var_7A6B[var_01][2] = tablelookup(var_00,0,var_01,2);
		level.var_7A6B[var_01][3] = tablelookup(var_00,0,var_01,3);
		level.var_7A6B[var_01][7] = tablelookup(var_00,0,var_01,7);
		level.var_7A6B[var_01][18] = tablelookup(var_00,0,var_01,18);
		var_01++;
	}

	maps\mp\gametypes\_missions::func_1D41();
	level thread func_6B6C();
}

//Function Number: 3
rankinghubenabled()
{
	return function_0367() && !issplitscreen() && !function_02A4();
}

//Function Number: 4
func_6B6C()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00) && var_00 maps\mp\_utility::func_7A69() || maps\mp\_utility::func_585F() || rankinghubenabled())
		{
			var_01 = var_00 func_4639();
			var_02 = var_00 maps\mp\gametypes\_persistence::func_932F("experience");
			if(var_02 < 0)
			{
				var_02 = 0;
			}

			var_03 = var_00 method_8507() - var_02;
			var_04 = var_00 method_8507();
		}
		else if(isai(var_00))
		{
			var_00 maps\mp\_utility::func_8568();
			var_02 = var_00.var_12C["rankxp"];
			var_01 = var_00.var_12C["prestige"];
			var_03 = 0;
			var_04 = var_02;
		}
		else
		{
			var_01 = 0;
			var_02 = 0;
			var_03 = 0;
			var_04 = var_02;
		}

		var_00.var_12C["rankxp"] = var_02;
		var_00.var_12C["redeemedxp"] = var_03;
		var_00.var_12C["prestige"] = var_01;
		if(!isdefined(var_00.var_12C["participation"]))
		{
			var_00.var_12C["participation"] = 0;
		}

		var_05 = var_00 func_4653(var_00 func_46EC());
		var_00.var_12C["rank"] = var_05;
		if(isai(var_00))
		{
			var_00 maps\mp\_utility::func_8567();
		}

		var_00.var_AAD5 = 0;
		var_00.var_75E5 = 0;
		var_00.var_3962[0] = 0;
		var_00 setrank(var_05,var_01);
		var_06 = func_4657(level.var_609A) - var_03;
		var_00.var_12C["masterPrestige"] = var_01 == level.var_6097 && var_02 >= var_06;
		if(!function_0367() && var_00.var_2418 < level.var_608C)
		{
			setmatchdata("players",var_00.var_2418,"prestige",var_01);
			setmatchdata("players",var_00.var_2418,"start_rank",maps\mp\_utility::func_2314(var_00.var_12C["rank"]));
		}

		if(!isdefined(var_00.var_12C["postGameChallenges"]))
		{
			var_00 setclientdvars("ui_challenge_1_ref","","ui_challenge_2_ref","","ui_challenge_3_ref","","ui_challenge_4_ref","","ui_challenge_5_ref","","ui_challenge_6_ref","","ui_challenge_7_ref","");
		}

		var_00 setclientdvar("ui_promotion",0);
		if(!isdefined(var_00.var_12C["summary"]))
		{
			var_00.var_12C["summary"] = [];
			var_00.var_12C["summary"]["xp"] = 0;
			var_00.var_12C["summary"]["xpToScaleWithActiveBoosts"] = 0;
			var_00.var_12C["summary"]["weaponXpToScaleWithActiveBoosts"] = [];
			var_00.var_12C["summary"]["divisionXpToScaleWithActiveBoosts"] = [];
			var_00.var_12C["summary"]["score"] = 0;
			var_00.var_12C["summary"]["challenge"] = 0;
			var_00.var_12C["summary"]["match"] = 0;
			var_00.var_12C["summary"]["misc"] = 0;
			var_00.var_12C["summary"]["entitlementXP"] = 0;
			var_00.var_12C["summary"]["clanWarsXP"] = 0;
			var_00.var_12C["summary"]["doubleXp"] = 0;
			var_00.var_12C["summary"]["matchStartXp"] = var_04;
		}

		if(getdvar("4017") != "1")
		{
			if(!function_0367())
			{
				var_00 setclientdvar("3635",0);
			}

			var_00 thread maps\mp\gametypes\_missions::func_A0F3();
		}

		var_00 thread monitorinventoryxpupdates();
	}
}

//Function Number: 5
func_465D()
{
	var_00 = getdvarint("4262");
	var_01 = getdvarint("5919");
	var_02 = function_03B9("rank");
	var_03 = max(var_00,var_01);
	var_03 = max(var_03,var_02);
	if(var_03 > 2)
	{
		var_03 = 2;
	}

	if(var_03 > 4 || var_03 < 0)
	{
		exitlevel(0);
	}

	return var_03;
}

//Function Number: 6
func_44A3()
{
	var_00 = getdvarint("3039");
	var_01 = getdvarint("5918");
	var_02 = function_03B9("division");
	var_03 = max(var_00,var_01);
	var_03 = max(var_03,var_02);
	if(var_03 > 2)
	{
		var_03 = 2;
	}

	if(var_03 > 4 || var_03 < 0)
	{
		exitlevel(0);
	}

	return var_03;
}

//Function Number: 7
func_473E()
{
	var_00 = getdvarint("858");
	var_01 = getdvarint("5917");
	var_02 = function_03B9("weapon");
	var_03 = max(var_00,var_01);
	var_03 = max(var_03,var_02);
	if(var_03 > 2)
	{
		var_03 = 2;
	}

	if(var_03 > 4 || var_03 < 0)
	{
		exitlevel(0);
	}

	return var_03;
}

//Function Number: 8
func_4567()
{
	var_00 = getdvarint("239");
	if(var_00 > 4 || var_00 < 0)
	{
		exitlevel(0);
	}

	return var_00;
}

//Function Number: 9
func_57A1(param_00)
{
	if(isdefined(level.var_AAD1[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
func_7C06(param_00,param_01,param_02,param_03)
{
	level.var_AAD1[param_00]["value"] = param_01;
	level.var_AAD1[param_00]["allowPlayerScore"] = 0;
	level.var_AAD1[param_00]["playSplash"] = 0;
	if(isdefined(param_02) && param_02)
	{
		level.var_AAD1[param_00]["allowPlayerScore"] = 1;
	}

	if(isdefined(param_03) && param_03)
	{
		level.var_AAD1[param_00]["playSplash"] = 1;
	}
}

//Function Number: 11
func_0C28(param_00)
{
	return level.var_AAD1[param_00]["allowPlayerScore"];
}

//Function Number: 12
func_8B9E(param_00)
{
	return level.var_AAD1[param_00]["playSplash"];
}

//Function Number: 13
func_4671(param_00)
{
	var_01 = "scr_" + level.var_3FDC + "_score_" + param_00;
	if(getdvar(var_01) != "")
	{
		return getdvarint(var_01);
	}

	return level.var_AAD1[param_00]["value"];
}

//Function Number: 14
func_4658(param_00)
{
	return int(level.var_7A6B[param_00][2]);
}

//Function Number: 15
func_465A(param_00)
{
	return int(level.var_7A6B[param_00][3]);
}

//Function Number: 16
func_4657(param_00)
{
	return int(level.var_7A6B[param_00][7]);
}

//Function Number: 17
func_4655(param_00)
{
	return function_01AF(func_465B(),0,param_00,16);
}

//Function Number: 18
func_4656(param_00)
{
	return int(tablelookup(func_465B(),0,param_00,13));
}

//Function Number: 19
func_4659(param_00)
{
	return level.var_7A6B[param_00][18];
}

//Function Number: 20
func_1457(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(maps\mp\_utility::func_551F() && !function_0367())
	{
		return;
	}

	if(getdvarint("spv_playofthegame_use_all_kills") == 1 || !isdefined(param_02) || issubstr(param_02,"flamethrower") || !maps\mp\_utility::func_5740(param_02) && !issubstr(param_02,"frag") && !issubstr(param_02,"semtex") && !issubstr(param_02,"betty"))
	{
		param_01 thread maps\mp\gametypes\_potg::func_4AE2(param_00,param_02,param_03,param_05);
	}

	if(func_8B9E(param_00) && !level.var_53C7 || !maps/mp/gametypes/scorestreak_training::func_57BC(param_00))
	{
		param_01 thread maps\mp\gametypes\_hud_message::func_9102(param_00);
	}

	var_06 = param_00;
	if(param_01 maps\mp\_utility::func_649("specialty_extraobjectivescore") && isdefined(level.var_AAD1[param_00 + "_pro"]))
	{
		var_06 = var_06 + "_pro";
	}

	param_01 func_47B2(var_06,undefined,param_02,param_04,undefined,param_03);
	param_01 thread maps\mp\gametypes\_gamelogic::func_47C6(param_02,var_06,param_04);
	param_01 thread maps\mp\gametypes\_divisions::cp_zmb_zombie_init(param_01.var_79,var_06);
	if(func_0C28(var_06))
	{
		param_01 maps\mp\gametypes\_gamescore::func_47A7(var_06,param_01,param_03,param_02,param_04);
	}

	lib_0468::func_A1A(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 21
func_47B2(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("disconnect");
	if(isdefined(self.var_117) && !isbot(self))
	{
		self.var_117 func_47B2(param_00,param_01,param_02,param_03,param_04,param_05);
		return;
	}

	if(isai(self))
	{
		return;
	}

	if(!isplayer(self))
	{
		return;
	}

	if(!maps\mp\_utility::func_7A69())
	{
		return;
	}

	if(!function_0367())
	{
		if(level.var_984D && (!level.var_984F["allies"] || !level.var_984F["axis"]) && param_00 != "win")
		{
			return;
		}

		if(!level.var_984D && level.var_984F["allies"] + level.var_984F["axis"] < 2)
		{
			return;
		}
	}

	if(isdefined(level.var_2F98) && level.var_2F98)
	{
		return;
	}

	if(maps\mp\_utility::func_761E())
	{
		return;
	}

	if(function_03AF())
	{
		if(param_00 == "win")
		{
			param_01 = getdvarint("spv_rankedPlayMatchBonusXP_win");
		}
		else if(param_00 == "tie")
		{
			param_01 = getdvarint("spv_rankedPlayMatchBonusXP_tie");
		}
		else if(param_00 == "loss")
		{
			param_01 = getdvarint("spv_rankedPlayMatchBonusXP_loss");
		}
		else
		{
			return;
		}
	}

	if(!isdefined(param_01))
	{
		if(maps\mp\_utility::func_649("specialty_killstreaks") && param_00 == "airdrop_kill" || param_00 == "fritzx_kill" || param_00 == "mortar_strike_kill" || param_00 == "missile_strike_kill" || param_00 == "airstrike_kill" || param_00 == "firebomb_kill" || param_00 == "fighter_strike_kill" || param_00 == "plane_gunner_kill" || param_00 == "flamethrower_kill" || param_00 == "attack_dogs_kill" || param_00 == "paratroopers_kill" || param_00 == "molotovs_kill" || param_00 == "v2_rocket_kill")
		{
			param_01 = func_4671("kill");
		}
		else
		{
			param_01 = func_4671(param_00);
		}
	}

	if(param_01 == 0)
	{
		return;
	}

	if(param_01 > 0 && !isdefined(self.var_5F0B) && !function_0367())
	{
		self.var_5F0B = 1;
		lootservicevalidateplaytime(self.var_1D6);
	}

	var_06 = param_01;
	var_07 = 0;
	switch(param_00)
	{
		case "win":
		case "loss":
		case "challenge":
		case "divisionLevel":
		case "weaponLevel":
		case "tie":
			break;

		default:
			if(maps\mp\_utility::func_44FC() > 0 && param_00 != "shield_damage" && !maps\mp\_utility::isprophuntgametype())
			{
				var_08 = max(1,int(5 / maps\mp\_utility::func_44FC()));
				if(level.var_3FDC == "sr")
				{
					var_08 = max(1,int(2.5 / maps\mp\_utility::func_44FC()));
				}
	
				var_06 = int(var_06 * var_08);
			}
	
			if(isdefined(level.var_6859) && level.var_6859)
			{
				if(level.var_984D && level.var_685E.var_1A7 == self.var_1A7)
				{
					var_06 = var_06 * level.var_685E.var_AAD4;
				}
				else if(!level.var_984D && level.var_685E.var_721C == self)
				{
					var_06 = var_06 * level.var_685E.var_AAD4;
				}
	
				var_06 = int(var_06);
			}
	
			if(param_00 == "kill" || param_00 == "divisions_infantry_kill" || param_00 == "divisions_airborne_kill" || param_00 == "divisions_armored_kill" || param_00 == "divisions_mountain_kill" || param_00 == "divisions_cavalry_kill" || param_00 == "division_resistance_kill" || param_00 == "division_grenadier_kill" || param_00 == "division_commando_kill" || param_00 == "division_scout_kill" || param_00 == "division_artillery_kill")
			{
				var_09 = maps\mp\_utility::func_472B(param_02);
				var_0A = maps\mp\_utility::func_452A(param_02);
				if(isdefined(var_0A) && var_0A != 0)
				{
					if(var_09 == "cond2" || var_09 == "cond1")
					{
						var_0B = maps\mp\_utility::func_4431(param_02);
						var_0C = maps\mp\_utility::func_452A(var_0B);
						if(isdefined(var_0C) && var_0C != 0)
						{
							var_0D = tablelookup("mp/statstable.csv",18,maps\mp\_utility::unsignedint_to_hexstring_fixed(var_0C),34);
							if(var_0D == "0")
							{
								if(var_09 == "cond1")
								{
									var_0A = var_0C + 1;
								}
								else if(var_09 == "cond2")
								{
									var_0A = var_0C + 2;
								}
							}
							else if(var_0D == "1")
							{
								if(var_09 == "cond2")
								{
									var_0A = var_0C + 1;
								}
							}
						}
					}
				}
	
				var_0E = maps\mp\_utility::unsignedint_to_hexstring_fixed(var_0A);
				var_0F = float(tablelookup("mp/statstable.csv",18,var_0E,49));
				if(var_0F != 0)
				{
					var_06 = int(var_06 * var_0F);
				}
			}
	
			if(isdefined(self.var_2680) && isdefined(self.var_2680["xp"]))
			{
				var_10 = int(var_06 + var_06 * self.var_2680["xp"]["bonusTotal"]);
				var_06 = var_10;
			}
	
			var_07 = self getclanwarsbonus();
			self.var_12C["summary"]["xpToScaleWithActiveBoosts"] = self.var_12C["summary"]["xpToScaleWithActiveBoosts"] + var_06;
			break;
	}

	var_11 = int(var_06 * var_07);
	func_47B4(var_06 + var_11);
	var_12 = maps\mp\gametypes\_missions::func_584F(param_04);
	if(var_12)
	{
		param_02 = self getcurrentweapon();
	}

	if(param_00 == "shield_damage")
	{
		param_02 = self getcurrentweapon();
		param_03 = "MOD_MELEE";
	}

	self.var_12C["summary"]["clanWarsXP"] = self.var_12C["summary"]["clanWarsXP"] + var_11;
	self.var_12C["summary"]["xp"] = self.var_12C["summary"]["xp"] + var_06 + var_11;
	switch(param_00)
	{
		case "win":
		case "loss":
		case "tie":
			self.var_12C["summary"]["match"] = self.var_12C["summary"]["match"] + var_06;
			break;

		case "challenge":
		case "divisionLevel":
		case "weaponLevel":
			self.var_12C["summary"]["challenge"] = self.var_12C["summary"]["challenge"] + var_06;
			break;

		default:
			if(func_57A1(param_00))
			{
				self.var_12C["summary"]["score"] = self.var_12C["summary"]["score"] + var_06;
			}
			else
			{
				self.var_12C["summary"]["misc"] = self.var_12C["summary"]["misc"] + var_06;
			}
			break;
	}
}

//Function Number: 22
givexpfromactiveboosts()
{
	if(!maps\mp\_utility::func_7A69())
	{
		return;
	}

	var_00 = level.var_7A6E;
	var_01 = level.var_A9FA;
	var_02 = level.var_305B;
	if(self method_86B4(0) > 1)
	{
		var_00 = max(var_00,getdvarint("party_rankXPScale"));
		var_01 = max(var_01,getdvarint("party_weaponXPScale"));
		var_02 = max(var_02,getdvarint("party_divisionXPScale"));
	}

	if(isdefined(self.var_12C["summary"]["xpToScaleWithActiveBoosts"]) && self.var_12C["summary"]["xpToScaleWithActiveBoosts"] > 0)
	{
		var_03 = self.var_12C["summary"]["xpToScaleWithActiveBoosts"];
		var_04 = var_03;
		if(var_00 > 1)
		{
			var_04 = int(var_04 * var_00);
			self.var_12C["summary"]["doubleXp"] = self.var_12C["summary"]["doubleXp"] + int(max(0,var_04 - var_03));
		}
		else if(self getrankedplayerdata(common_scripts\utility::func_46AE(),"hasDoubleXPItem"))
		{
			self.var_12C["summary"]["doubleXp"] = self.var_12C["summary"]["doubleXp"] + int(var_04);
			var_04 = int(var_04 * 2);
		}

		if(self getrankedplayerdata(common_scripts\utility::func_46AE(),"hasBonusXPItem"))
		{
			self.var_12C["summary"]["entitlementXP"] = self.var_12C["summary"]["entitlementXP"] + int(var_04 * 0.25);
			var_04 = int(var_04 * 1.25);
		}

		var_04 = int(max(0,var_04 - var_03));
		func_47B4(var_04);
		self.var_12C["summary"]["xp"] = self.var_12C["summary"]["xp"] + var_04;
	}

	self.var_12C["summary"]["xpToScaleWithActiveBoosts"] = 0;
	if(isdefined(self.var_12C["summary"]["weaponXpToScaleWithActiveBoosts"]))
	{
		foreach(var_06 in self.var_12C["summary"]["weaponXpToScaleWithActiveBoosts"])
		{
			var_07 = var_06["weaponName"];
			var_08 = var_06["xp"];
			var_04 = var_08;
			if(var_01 > 1)
			{
				var_04 = int(var_04 * var_01);
			}
			else if(self getrankedplayerdata(common_scripts\utility::func_46AE(),"hasDoubleWeaponXPItem"))
			{
				var_04 = int(var_04 * 2);
			}

			if(self getrankedplayerdata(common_scripts\utility::func_46AE(),"hasBonusWeaponXPItem"))
			{
				var_04 = int(var_04 * 1.25);
			}

			var_04 = int(max(0,var_04 - var_08));
			if(var_04 > 0)
			{
				thread maps\mp\gametypes\_gamelogic::func_47C3(var_07,var_04);
			}
		}
	}

	self.var_12C["summary"]["weaponXpToScaleWithActiveBoosts"] = [];
	if(isdefined(self.var_12C["summary"]["divisionXpToScaleWithActiveBoosts"]))
	{
		foreach(var_0B in self.var_12C["summary"]["divisionXpToScaleWithActiveBoosts"])
		{
			var_0C = var_0B["divisionIndex"];
			var_08 = var_0B["xp"];
			var_04 = var_08;
			if(var_02 > 1)
			{
				var_04 = int(var_04 * var_02);
			}
			else if(self getrankedplayerdata(common_scripts\utility::func_46AE(),"hasDoubleDivisionXPItem"))
			{
				var_04 = int(var_04 * 2);
			}

			if(self getrankedplayerdata(common_scripts\utility::func_46AE(),"hasBonusDivisionXPItem"))
			{
				var_04 = int(var_04 * 1.25);
			}

			var_04 = int(max(0,var_04 - var_08));
			if(var_04 > 0)
			{
				thread maps\mp\gametypes\_divisions::cp_zmb_spawn_fx_func(var_0C,var_04);
			}
		}
	}

	self.var_12C["summary"]["divisionXpToScaleWithActiveBoosts"] = [];
}

//Function Number: 23
func_47B4(param_00)
{
	var_01 = func_465C();
	var_02 = func_465F();
	func_50EB(param_00);
	if(function_0367())
	{
		self luinotifyevent(&"rankxp_gained",2,var_01 + var_02,func_46EC());
	}

	var_03 = maps\mp\_utility::func_7A69() && func_A157(var_01);
	if(var_03)
	{
		thread func_A158();
		if(function_0367())
		{
			playfxontag(level.var_611["level_up"],self,"tag_origin");
			lib_0378::func_8D74("hqs_level_up_flag_start");
		}
	}

	func_9575();
	if(var_03 && function_0367() && getdvarint("5956",0) == 1)
	{
		self uploadhub1v1leaderboarddata();
	}
}

//Function Number: 24
func_A157(param_00)
{
	var_01 = func_4652();
	if(var_01 == self.var_12C["rank"])
	{
		return 0;
	}

	var_02 = self.var_12C["rank"];
	self.var_12C["rank"] = var_01;
	var_03 = func_465C() - param_00;
	var_04 = -1;
	if(isdefined(self.var_1CEF) && isdefined(self.var_1CEF["timePlayedTotal"]) && isdefined(self.var_1CEF["timePlayedTotal"].var_A281))
	{
		var_04 = self.var_1CEF["timePlayedTotal"].var_A281;
	}

	function_00F5("script_mp_rankup_player: playerName %s, oldRank %d, newRank %d, xpGain %d, timePlayed %d",self.var_109,var_02 + 1,var_01 + 1,var_03,var_04);
	for(var_05 = var_02 + 1;var_05 <= var_01;var_05++)
	{
		if(var_05 == 1)
		{
			lib_0468::func_A25(0,"mp");
		}

		lib_0468::func_A25(var_05,"mp");
	}

	var_06 = self.var_12C["prestige"];
	if(getdvarint("spv_hub_masterPrestigeDrops_kswitch",1) == 0)
	{
		if(var_06 == level.var_6097 && var_01 >= level.var_609A)
		{
			lib_0468::ae_sendmasterprestigerankevent(var_01,"mp");
		}
	}

	thread func_099C(var_01 - var_02);
	if(var_06 == level.var_6097 && var_01 == level.var_609A + 1)
	{
		lib_0468::func_A2A("general",11);
	}

	self setrank(var_01);
	return 1;
}

//Function Number: 25
func_099C(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = self getrankedplayerdata(common_scripts\utility::func_46AE(),"cacTokens");
	self setrankedplayerdata(common_scripts\utility::func_46AE(),"cacTokens",var_01 + param_00);
}

//Function Number: 26
func_A158()
{
	self endon("disconnect");
	self notify("update_rank");
	self endon("update_rank");
	var_00 = self.var_12C["team"];
	if(!isdefined(var_00))
	{
		return;
	}

	if(!maps\mp\_utility::func_5CBA("game_over"))
	{
		level common_scripts\utility::func_A74B("game_over",0.25);
	}

	thread maps\mp\gametypes\_hud_message::func_7A6C(func_4659(self.var_12C["rank"]),func_4656(self.var_12C["rank"]),self.var_12C["prestige"]);
	for(var_01 = 0;var_01 < level.var_744A.size;var_01++)
	{
		var_02 = level.var_744A[var_01];
		var_03 = var_02.var_12C["team"];
		if(isdefined(var_03) && var_02 != self)
		{
			if(var_03 == var_00)
			{
				var_02 maps\mp\gametypes\_hud_message::func_7A6A(self);
			}
		}
	}
}

//Function Number: 27
func_AAD2(param_00,param_01)
{
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	if(param_01 == 0 && param_00 != "tac_insert_destroyed" && param_00 != "dropped_gun_score" && param_00 != "bankrupt_blades_score" && param_00 != "bankrupt_blades_score_suicide")
	{
		return;
	}

	while(level.var_AAD3 == gettime())
	{
		wait 0.05;
	}

	level.var_AAD3 = gettime();
	self notify("xpPointsPopup");
	self endon("xpPointsPopup");
	if(level.var_3FDC != "blades")
	{
		self.var_AAD5 = self.var_AAD5 + param_01;
		self setclientomnvar("ui_points_popup",self.var_AAD5);
	}

	var_02 = tablelookuprownum("mp/xp_event_table.csv",0,param_00);
	if(!isdefined(var_02) || isdefined(var_02) && var_02 == -1)
	{
	}
	else
	{
		self setclientomnvar("ui_points_popup_event",var_02);
	}

	wait(1);
	self.var_AAD5 = 0;
}

//Function Number: 28
func_4652()
{
	var_00 = func_46EC();
	var_01 = self.var_12C["rank"];
	if(var_00 < func_4658(var_01) + func_465A(var_01))
	{
		return var_01;
	}

	return func_4653(var_00);
}

//Function Number: 29
func_4653(param_00)
{
	var_01 = self.var_12C["prestige"];
	var_02 = var_01 == level.var_6097 && param_00 > func_4657(level.var_609A);
	if(var_02)
	{
		var_03 = level.var_609A;
		var_04 = level.var_609B;
	}
	else
	{
		var_03 = 0;
		var_04 = level.var_609A;
	}

	if(param_00 >= func_4657(var_04))
	{
		return var_04;
	}

	while(var_03 <= var_04)
	{
		var_05 = var_03 + int(var_04 - var_03 / 2);
		if(param_00 >= func_4658(var_05) && param_00 <= func_4657(var_05))
		{
			return var_05;
		}

		if(param_00 > func_4657(var_05))
		{
			var_03 = var_05 + 1;
			continue;
		}

		var_04 = var_05 - 1;
	}

	if(maps\mp\_utility::func_585F() || maps\mp\gametypes\_hud_util::func_5527())
	{
		return var_04;
	}

	var_06 = -1;
	return var_06;
}

//Function Number: 30
func_4639()
{
	if(isai(self) && isdefined(self.var_12C["prestige_fake"]))
	{
		return self.var_12C["prestige_fake"];
	}

	return maps\mp\gametypes\_persistence::func_932F("prestige");
}

//Function Number: 31
func_465C()
{
	if(isdefined(self.var_12C["rankxp"]))
	{
		return self.var_12C["rankxp"];
	}

	return 0;
}

//Function Number: 32
func_465F()
{
	if(isdefined(self.var_12C["redeemedxp"]))
	{
		return self.var_12C["redeemedxp"];
	}

	return 0;
}

//Function Number: 33
func_46EC()
{
	return func_465C() + func_465F();
}

//Function Number: 34
func_50EB(param_00)
{
	if(!maps\mp\_utility::func_7A69())
	{
		return;
	}

	var_01 = func_465C();
	var_02 = self.var_12C["prestige"];
	if(var_02 == level.var_6097)
	{
		var_03 = func_4657(level.var_609B) - func_465F();
	}
	else if(getdvarint("1258",0) == 1 || getdvarint("2803",0) == 1)
	{
		var_03 = func_4658(level.var_609A) - func_465F();
	}
	else
	{
		var_03 = func_4657(level.var_609A) - func_465F();
	}

	var_04 = int(min(var_01,var_03)) + param_00;
	if(var_04 > var_03)
	{
		var_04 = var_03;
	}

	self.var_12C["rankxp"] = var_04;
	func_775B(var_02,var_04);
}

//Function Number: 35
func_775B(param_00,param_01)
{
	var_02 = func_4657(level.var_609A) - func_465F();
	if(param_00 == level.var_6097 && param_01 >= var_02 && !self.var_12C["masterPrestige"])
	{
		self.var_12C["masterPrestige"] = 1;
		thread maps\mp\gametypes\_hud_message::func_9104("prestigeMaster");
	}
}

//Function Number: 36
func_9575()
{
	var_00 = func_465C();
	maps\mp\gametypes\_persistence::func_9338("experience",var_00);
}

//Function Number: 37
monitorinventoryxpupdates()
{
	self endon("disconnect");
	level endon("game_ended");
	if(!function_02A3() || !function_0367() || common_scripts\utility::func_562E(level.var_A259))
	{
		return;
	}

	for(;;)
	{
		self waittill("client_stats_update");
		var_00 = self.var_12C["redeemedxp"];
		var_01 = self method_8507() - self.var_12C["rankxp"];
		if(var_01 > var_00)
		{
			var_02 = var_00 + self.var_12C["rankxp"];
			self.var_12C["redeemedxp"] = var_01;
			if(maps\mp\_utility::func_7A69() && func_A157(var_02))
			{
				thread func_A158();
				playfxontag(level.var_611["level_up"],self,"tag_origin");
				lib_0378::func_8D74("hqs_level_up_flag_start");
				if(getdvarint("5956",0) == 1)
				{
					self uploadhub1v1leaderboarddata();
				}
			}
		}
	}
}