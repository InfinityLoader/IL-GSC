/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_events.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 146
 * Decompile Time: 2383 ms
 * Timestamp: 10/27/2023 3:21:22 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	setdvarifuninitialized("set scr_dom_score_kill","");
	setdvarifuninitialized("set scr_dom_score_divisions_infantry_kill","");
	setdvarifuninitialized("set scr_dom_score_divisions_airborne_kill","");
	setdvarifuninitialized("set scr_dom_score_divisions_armored_kill","");
	setdvarifuninitialized("set scr_dom_score_divisions_mountain_kill","");
	setdvarifuninitialized("set scr_dom_score_divisions_cavalry_kill","");
	setdvarifuninitialized("set scr_dom_score_division_resistance_kill","");
	setdvarifuninitialized("set scr_dom_score_mg_nest_kill","");
	setdvarifuninitialized("set scr_dom_score_assist_mid","");
	setdvarifuninitialized("set scr_dom_score_assist_high","");
	setdvarifuninitialized("set scr_dom_score_assist_steal","");
	setdvarifuninitialized("set scr_dom_score_assist_tactical","");
	setdvarifuninitialized("set scr_dom_score_assist_painted","");
	var_00 = getdvar("1924");
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
	var_02["br"] = 13;
	var_02["twar"] = 14;
	var_02["hp"] = 15;
	var_02["ball"] = 16;
	var_02["lockdown"] = 17;
	var_02["hub"] = 18;
	var_02["demo"] = 19;
	var_02["raid"] = 20;
	var_02["prop"] = 22;
	var_02["spy"] = 23;
	var_02["blades"] = 24;
	var_02["scorestreak_training"] = 5;
	var_02["aon"] = 25;
	var_02["oitc"] = 26;
	var_02["undead"] = 27;
	var_02["relic"] = 28;
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
			maps\mp\gametypes\_rank::func_7C06(var_03,var_06,var_05,var_04);
		}

		var_01++;
	}

	level.var_6892 = 0;
	level thread func_6B6C();
}

//Function Number: 2
func_6B6C()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_5A42 = [];
		var_00.var_5A43 = [];
		var_00.var_29BD = [];
		var_00.var_5A3C = [];
		var_00.recentkills = [];
		var_00.var_5BB1 = undefined;
		var_00.var_7AD2 = 0;
		var_00.var_5BB4 = 0;
		var_00.var_1D84 = 0;
		var_00.var_5B87 = 0;
	}
}

//Function Number: 3
func_5A40(param_00,param_01,param_02,param_03,param_04)
{
	level.var_6892++;
	level.var_A239 = 0;
	var_05 = param_01.var_48CA;
	var_06 = param_01.var_12C["cur_kill_streak"];
	var_07 = self.var_48CA;
	var_08 = gettime();
	var_09 = [];
	maps\mp\gametypes\_missions::func_7750("ch_career_kills");
	if(maps\mp\_utility::func_5694(param_03))
	{
		if(self.var_5BB4 == var_08)
		{
			self.var_1D84++;
		}
		else
		{
			self.var_1D84 = 1;
		}
	}
	else
	{
		self.var_1D84 = 0;
	}

	self.var_5BB4 = gettime();
	self.var_5BB2 = param_01;
	self.var_62A1 = [];
	self.var_29BD[var_05] = undefined;
	thread func_A159(param_00,param_02);
	if(maps\mp\_utility::func_5740(param_02))
	{
		if(isdefined(level.var_5A7D) && isdefined(level.var_5A7D[param_02]))
		{
			maps\mp\gametypes\_persistence::incrementscorestreakstat(level.var_5A7D[param_02],"killsOrAssists",1);
		}
	}
	else
	{
		if(param_02 == "none")
		{
			return 0;
		}

		if(isdefined(param_01.var_99AC))
		{
			if(param_01.var_99AC == "frag_grenade_mp" || param_01.var_99AC == "frag_grenade_german_mp")
			{
				self.var_62A1["cooking"] = 1;
			}
		}

		if(function_01D4(param_02) == "primary")
		{
			self.var_838A["killDistanceTotal"] = self.var_838A["killDistanceTotal"] + distance2d(self.var_116,param_01.var_116);
			self.var_838A["killDistanceCount"]++;
		}

		if(isdefined(common_scripts\utility::func_F7E(self.var_1193,param_01)))
		{
			self notify("turned_on_battlecry");
		}

		if(param_03 == "MOD_HEAD_SHOT")
		{
			func_4BF6(param_00,param_02,param_03);
		}

		if(level.var_984D && var_08 - param_01.var_5BB4 < 3000 && param_01.var_5BB2 != self)
		{
			func_13BA(param_00,param_02,param_03);
		}

		if(ispostdeathkillevent(param_01,param_04))
		{
			func_75E2(param_00);
		}

		if(isdefined(self.var_6E6B) && self.var_6E6B)
		{
			maps\mp\gametypes\_missions::func_7750("ch_commando_weapon");
		}

		if(isdefined(self.basictrainingserumactive) && self.basictrainingserumactive)
		{
			maps\mp\gametypes\_missions::func_7750("ch_dlc4_catalyst");
		}

		if(self.var_12C["cur_death_streak"] > 3)
		{
			func_2535(param_00,param_02,param_03);
		}

		if(isdefined(self.var_10E9) && self.var_10E9)
		{
			func_10EA(param_00,param_02,param_03);
		}

		if(func_574D(self,param_02,param_03,param_01))
		{
			func_5EB3(param_00,param_02,param_03);
			var_09[var_09.size] = "longshot";
		}

		if(func_57A8(param_01,var_08))
		{
			func_2C77(param_00,param_02,param_03);
		}

		if(var_06 > 0 && func_5698(param_01))
		{
			func_1DE7(param_00,param_01,param_02,param_03);
		}

		if(func_5766(param_01,param_02,param_03))
		{
			func_6B12(param_00,param_02,param_03);
		}

		if(isdefined(self.var_5BB1) && self.var_5BB1 == param_01)
		{
			func_7E3F(param_00,param_02);
			var_09[var_09.size] = "payback";
		}

		if(isdefined(param_01.var_5033) && param_01.var_5033 & level.var_503B)
		{
			func_1D7E(param_00,param_02);
		}

		if(func_5789(param_01,param_03))
		{
			func_753F(param_00,param_02,param_03);
		}

		if(isdefined(param_02) && param_02 == "boost_slam_mp")
		{
			func_191A(param_00,param_02,param_03);
		}

		if(self.var_BC < 20 && self.var_BC > 0)
		{
			func_6634(param_02,param_03);
		}

		if(self.var_57CF)
		{
			func_9131(param_02,param_03);
		}

		if(isdefined(self.var_5BDE) && var_08 - self.var_5BDE < 2000)
		{
			func_1EC2(param_02,param_03);
		}

		if(param_01 common_scripts\utility::func_56B5())
		{
			concusskillevent(param_00);
		}

		if(param_01 common_scripts\utility::func_5701())
		{
			gaskillevent(param_00);
		}

		if(param_01 common_scripts\utility::func_56F2())
		{
			flarekillevent(param_00);
		}

		if(param_01 common_scripts\utility::func_56F4())
		{
			func_3D4B(param_00);
		}

		if(common_scripts\utility::func_56F2() || common_scripts\utility::func_56B5() || common_scripts\utility::func_56F4())
		{
			blindfightkillevent(param_02,param_03);
		}

		if(common_scripts\utility::func_56F2() || common_scripts\utility::func_56B5() || common_scripts\utility::func_5701() || common_scripts\utility::func_56F4())
		{
			getclosest(param_01,"focused");
		}

		if(common_scripts\utility::func_57D0())
		{
			func_8C5D(param_02,param_03);
		}

		if(func_57F1(param_03))
		{
			getclosest(param_01,"thickskin");
		}

		if(func_5803(param_02,param_03))
		{
			func_9965();
		}

		if(maps\mp\_utility::func_649("specialty_fastadsaftersprint"))
		{
			func_3A56();
		}

		if(self.var_1D84 == 2)
		{
			func_6513();
		}

		if(func_57CE(param_02,param_03))
		{
			func_8C55();
			var_09[var_09.size] = "dediMelee";
		}

		if(func_5681(param_01,param_02,param_03))
		{
			func_14EE(param_02);
		}

		if(maps\mp\_utility::func_5755(param_03))
		{
			func_60EB(param_02,param_03);
		}

		if(func_5805(param_01,param_02,param_03,param_04))
		{
			func_99A8();
			var_09[var_09.size] = "throwback";
		}

		if(maps\mp\gametypes\_weapons::func_5747(param_02))
		{
			func_5CA9(param_01,param_02);
		}

		if(func_56A2(param_01))
		{
			func_2007();
		}

		var_0A = undefined;
		if(maps\mp\_utility::func_57E5(param_02,"alt_"))
		{
			var_0A = getsubstr(param_02,4);
		}

		if(isdefined(self.var_6FBA[param_02]) && self.var_6FBA[param_02] == param_01 && !maps\mp\_utility::func_5755(param_03))
		{
			func_95D1();
			var_09[var_09.size] = "backfire";
		}
		else if(isdefined(var_0A) && isdefined(self.var_6FBA[var_0A]) && self.var_6FBA[var_0A] == param_01 && !maps\mp\_utility::func_5755(param_03))
		{
			func_95D1();
			var_09[var_09.size] = "backfire";
		}

		if(isdefined(param_02) && param_02 == "iw5_carrydrone_mp")
		{
			func_5A83();
		}

		if(isdefined(param_02) && param_02 == "relic_mp")
		{
			killwithrelicevent();
		}

		if(isdefined(param_01) && param_01 maps\mp\_utility::func_649("specialty_ballcarrier"))
		{
			if(level.var_3FDC == "ball")
			{
				func_5A3A();
			}
			else if(level.var_3FDC == "relic")
			{
				killedreliccarrierevent();
			}
		}

		if(func_5757(self))
		{
			func_6161();
		}

		if(self method_82E4() || self method_801D())
		{
			func_241E();
		}

		func_21C5(param_01,param_00,param_02,param_03,param_04);
		var_0B = func_21C4(param_01);
		if(isdefined(var_0B) && var_0B)
		{
			var_09[var_09.size] = "kingslayer";
		}

		func_21F2(param_01,param_02,param_03);
		if(isdefined(self.var_3448) && self.var_3448.size > 0)
		{
			foreach(var_0D in self.var_3448)
			{
				if(common_scripts\utility::func_302B(self.var_116,var_0D.var_116) <= -7936 && common_scripts\utility::func_302B(param_01.var_116,var_0D.var_116) <= -7936)
				{
					maps\mp\gametypes\_missions::func_7750("ch_streak_trap");
					break;
				}
			}
		}
	}

	if(level.var_6892 == 1)
	{
		func_3C63(param_00,param_02,param_03);
		if(level.var_3FDC == "sd")
		{
			maps\mp\_utility::func_863E(21,self.var_1A7,self getentitynumber());
		}
	}

	if(!level.var_53C7)
	{
		func_21E6(param_01);
	}

	if(!isdefined(self.var_5A42[var_05]))
	{
		self.var_5A42[var_05] = 0;
	}

	if(!isdefined(self.var_5A43[var_05]))
	{
		self.var_5A43[var_05] = 0;
	}

	if(!isdefined(param_01.var_5A3C[var_07]))
	{
		param_01.var_5A3C[var_07] = 0;
	}

	self.var_5A42[var_05]++;
	self.var_5A43[var_05]++;
	param_01.var_5A3C[var_07]++;
	param_01.var_5BB1 = self;
	lib_0468::func_A23(param_01,param_02,param_03,var_09);
	if(self.var_79 == 7)
	{
		if(isdefined(self.var_12C["grenadier_kills"]))
		{
			self.var_12C["grenadier_kills"]++;
		}
		else
		{
			self.var_12C["grenadier_kills"] = 1;
		}
	}

	if(isdefined(level.var_3FDC) && level.var_3FDC == "war")
	{
		if(self.var_12C["kills"] + 1 == 25)
		{
			lib_0468::func_A22("tdm25kills");
		}
	}

	if(isdefined(level.var_3FDC) && level.var_3FDC == "sd")
	{
		if(self.var_12C["kills"] + 1 == 10)
		{
			lib_0468::func_A22("sdKiller");
		}
	}

	if(maps\mp\_utility::func_579B())
	{
		if(self.var_12C["raidKillz"] + 1 == 45)
		{
			lib_0468::func_A22("warKills45");
		}
	}

	if(level.var_3FDC == "ctf" && self.var_1A7 != param_01.var_1A7 && isdefined(param_01.var_2013))
	{
		if(self.var_12C["defends"] + 1 == 3)
		{
			lib_0468::func_A22("3KillsFlagCarrier");
		}
	}

	if(level.var_3FDC == "hp" && isdefined(level.var_AC7C.var_9D5E) && self istouching(level.var_AC7C.var_9D5E))
	{
		if(!isdefined(self.killsonhp))
		{
			self.killsonhp = 0;
		}

		self.killsonhp++;
		if(self.killsonhp == 5)
		{
			lib_0468::func_A22("5KillsOnHp");
		}
	}
}

//Function Number: 4
func_5789(param_00,param_01)
{
	if(maps\mp\_utility::func_5694(param_01))
	{
		var_02 = self.var_116;
		var_03 = 9216;
		if(isdefined(param_00.var_1192))
		{
			var_02 = param_00.var_1192;
		}

		if(distancesquared(var_02,param_00.var_116) < var_03)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 5
func_753F(param_00,param_01,param_02)
{
	maps\mp\_utility::func_50EA("pointblank",1);
	level thread maps\mp\gametypes\_rank::func_1457("pointblank",self,param_01,undefined,param_02);
	if(isdefined(param_01))
	{
		var_03 = maps\mp\_utility::func_4431(param_01,1);
		if(maps\mp\_utility::func_5856(var_03))
		{
			var_03 = maps\mp\gametypes\_class::func_4432(var_03);
		}

		var_04 = maps\mp\gametypes\_missions::func_40EE(param_01,var_03);
		if(issubstr(var_03,"dlcgun") && var_04 == "weapon_special")
		{
			maps\mp\gametypes\_missions::func_7750("ch_tier1_1_" + var_03);
			return;
		}

		maps\mp\gametypes\_missions::func_7750("ch_pointblank_" + var_03);
	}
}

//Function Number: 6
func_5A41(param_00,param_01,param_02,param_03)
{
	if(param_00 isusingturret())
	{
		level thread maps\mp\gametypes\_rank::func_1457("killed_mg_nest",self,param_01,param_00,param_02,param_03);
	}

	if(isdefined(param_00.var_A258) && param_00.var_A258)
	{
		level thread maps\mp\gametypes\_rank::func_1457("killed_flamethrower",self,param_01,param_00,param_02,param_03);
	}

	if(isdefined(param_00.var_A25A) && param_00.var_A25A)
	{
		level thread maps\mp\gametypes\_rank::func_1457("killed_molotovs",self,param_01,param_00,param_02,param_03);
	}

	if(isdefined(param_00.usingriotshield) && param_00.usingriotshield)
	{
		level thread maps\mp\gametypes\_rank::func_1457("killed_riotshield",self,param_01,param_00,param_02,param_03);
	}

	if(function_03AF() || (isdefined(level.var_2F8B) && level.var_2F8B) || isdefined(level.disableallplayerstats) && level.disableallplayerstats)
	{
		var_04 = func_43D6(param_01,param_02);
		if(var_04 == "kill")
		{
			var_04 = maps\mp\gametypes\_division_change::func_4499("kill",self,param_00,param_01,param_02);
			if(var_04 != "kill")
			{
				self.var_62A1[var_04] = 1;
			}
		}

		level thread maps\mp\gametypes\_rank::func_1457(var_04,self,param_01,param_00,param_02,param_03);
		if(maps\mp\_utility::func_579B())
		{
			self.var_79A2++;
			maps\mp\_utility::func_86F5("raidKillz",self.var_79A2);
			self setclientomnvar("ui_onevone_class_1",self.var_79A2);
			maps\mp\gametypes\_persistence::func_933A("round","rescues",self.var_79A2);
			func_6324();
		}
		else
		{
			maps\mp\_utility::func_50EA("kills",1);
			maps\mp\_utility::func_50E9("kills",1);
			self.var_E3 = maps\mp\_utility::func_4607("kills");
		}

		return;
	}

	maps\mp\_utility::func_50EA("kills",1);
	maps\mp\_utility::func_50E9("kills",1);
	self.var_E3 = maps\mp\_utility::func_4607("kills");
	func_6324();
	maps\mp\gametypes\_persistence::func_933A("round","kills",self.var_E3);
	maps\mp\gametypes\_divisions::func_50FC(self.var_79,1,"kills");
	if(maps\mp\_utility::func_472A(param_02) == maps\mp\gametypes\_divisions::getdivisionweaponclass(self.var_79))
	{
		maps\mp\gametypes\_divisions::func_50FC(self.var_79,1,"weaponClassKills");
	}

	maps\mp\_utility::func_A14B("kdRatio","kills","deaths");
	var_04 = func_43D6(param_02,param_03);
	if(var_04 != "kill")
	{
		maps\mp\_utility::func_50EA(var_04,1);
		maps\mp\gametypes\_missions::func_20A0(var_04);
	}
	else if(isdefined(param_00) && isdefined(param_00.var_6E6B) && param_00.var_6E6B)
	{
		var_04 = "tac_insert_kill";
	}

	if(var_04 == "kill")
	{
		var_04 = maps\mp\gametypes\_division_change::func_4499(var_04,self,param_00,param_01,param_02);
		if(var_04 != "kill")
		{
			maps\mp\_utility::func_50EA(var_04,1);
			maps\mp\gametypes\_divisions::func_50FC(self.var_79,1,"skillKills");
			self.var_62A1[var_04] = 1;
		}
	}

	if(level.var_7616)
	{
		thread func_761F(param_00,var_04,param_01,param_02);
	}

	level thread maps\mp\gametypes\_rank::func_1457(var_04,self,param_01,param_00,param_02,param_03);
}

//Function Number: 7
func_6324(param_00)
{
	if(!maps\mp\_utility::func_7A69())
	{
		return;
	}

	var_01 = maps\mp\gametypes\_persistence::func_9331("round","rescues");
	var_02 = maps\mp\gametypes\_persistence::func_932F("kills");
	if(isdefined(var_02) && isdefined(var_01) && var_01 + var_02 == 10)
	{
		self giveachievement("MP_KILL_10");
	}
}

//Function Number: 8
func_43D6(param_00,param_01)
{
	switch(param_00)
	{
		case "carepackage_crate_mp":
			return "airdrop_kill";

		case "azon_projectile_grenadier_mp":
		case "fritzx_projectile_grenadier_mp":
		case "azon_projectile_mp":
		case "fritzx_projectile_mp":
			return "fritzx_kill";

		case "mortar_strike_projectile_axis_mp":
		case "mortar_strike_projectile_mp":
			return "mortar_strike_kill";

		case "missile_strike_projectile_axis_mp":
		case "missile_strike_projectile_mp":
			return "missile_strike_kill";

		case "v2_rocket_mp":
			return "v2_rocket_kill";

		case "airstrike_bomb_axis_mp":
		case "airstrike_bomb_mp":
			return "airstrike_kill";

		case "fighter_strike_gun_mp":
			return "fighter_strike_kill";

		case "firebomb_flames_mp":
		case "firebomb_bomb_axis_grenadier_mp":
		case "firebomb_bomb_grenadier_mp":
		case "firebomb_bomb_axis_mp":
		case "firebomb_bomb_mp":
			return "firebomb_kill";

		case "agent_mp":
			return "paratroopers_kill";

		case "agent_raid_fighters_mp":
			return "raid_fighters_kill";

		case "plane_gunner_bomber_projectile_mp":
		case "turretweapon_plane_gunner_turret_grenadier_mp":
		case "turretweapon_plane_gunner_turret_mp":
		case "turretweapon_plane_gunner_bomber_mp":
			return "plane_gunner_kill";

		case "flamethrower_german_grenadier_mp":
		case "flamethrower_grenadier_mp":
		case "flamethrower_german_mp":
		case "flamethrower_mp":
			if(isdefined(param_01) && !maps\mp\_utility::func_5755(param_01))
			{
				return "flamethrower_kill";
			}
			break;

		case "thermite_flames_mp":
		case "killstreak_molotov_cocktail_grenadier_mp":
		case "killstreak_molotov_cocktail_mp":
			if(isdefined(param_01) && !maps\mp\_utility::func_5755(param_01))
			{
				return "molotovs_kill";
			}
			break;

		case "turret_mg42_raid_stand_guardtower_mp":
		case "turret_mg42_raid_crouch_mp":
		case "turret_mg42_raid_stand_mp":
		case "turret_mg42_mp":
			return "mg_nest_kill";

		case "turretweapon_mg42_bucket_mp":
		case "turretweapon_usa_m1919_tank_sherman_bucket_mp":
		case "ger_tank_king_tiger_turret_snow_mp":
		case "ger_tank_king_tiger_turret_mp":
		case "usa_tank_sherman_turret_mp":
			return "raids_tank_turret_kill";

		case "killstreak_flak_gun_raids":
			if(maps\mp\_utility::isdogfightgametype())
			{
				return "dogfight_flak_kill";
			}
			else
			{
				return "raid_flak_kill";
			}
	
			break;
	}

	return "kill";
}

//Function Number: 9
func_761D()
{
	return !isdefined(self.var_66AD) || gettime() > self.var_66AD;
}

//Function Number: 10
func_761C()
{
	self.var_66AD = gettime() + randomintrange(20000,-25536);
}

//Function Number: 11
func_761F(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	level endon("game_ended");
	if(isbot(self))
	{
		return;
	}

	self method_8615("ui_practice_round_kill");
	var_04 = 0.5;
	if(!isdefined(self.var_1730))
	{
		self.var_1730 = self getrankedplayerdata(common_scripts\utility::func_46A7(),"bests","kills");
	}

	if(self.var_1730 > 0 && self.var_E3 > self.var_1730)
	{
		func_761C();
		wait(var_04);
		maps\mp\_utility::func_5C43("ptr_new_best");
		self.var_1730 = 0;
		return;
	}

	if(param_01 == "kill" && !maps\mp\_utility::func_5755(param_03))
	{
		if(param_03 == "MOD_HEAD_SHOT")
		{
			func_761C();
			wait(var_04);
			maps\mp\_utility::func_5C43("ptr_headshot");
			return;
		}

		if(!func_761D())
		{
			return;
		}

		func_761C();
		wait(var_04);
		maps\mp\_utility::func_5C43("ptr_greatshot");
		return;
	}
}

//Function Number: 12
func_7617(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	if(isbot(self))
	{
		return;
	}

	var_01 = 0.5;
	func_761C();
	wait(var_01);
	maps\mp\_utility::func_5C43("ptr_assist");
}

//Function Number: 13
func_5803(param_00,param_01)
{
	if(param_01 == "MOD_IMPACT" || param_01 == "MOD_HEAD_SHOT")
	{
		if(func_5804(param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 14
func_5804(param_00)
{
	switch(param_00)
	{
		case "smoke_grenade_axis_expeditionary_mp":
		case "smoke_grenade_expeditionary_mp":
		case "frag_grenade_german_mp":
		case "semtex_mp":
		case "paint_grenade_mp":
		case "emp_grenade_mp":
		case "stun_grenade__mp":
		case "smoke_grenade_axis_mp":
		case "smoke_grenade_mp":
		case "frag_grenade_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 15
func_3A56()
{
	var_00 = gettime();
	if(isdefined(self.var_5BE3) && var_00 - self.var_5BE3 <= 2000 && maps\mp\_utility::func_649("specialty_sprintfire"))
	{
		thread maps\mp\gametypes\_missions::func_7750("ch_perks2_agile");
	}
}

//Function Number: 16
func_9965()
{
	maps\mp\_utility::func_50EA("think_fast",1);
	level thread maps\mp\gametypes\_rank::func_1457("think_fast",self);
}

//Function Number: 17
func_191A(param_00,param_01,param_02)
{
	maps\mp\_utility::func_50EA("boostslamkill",1);
	thread maps\mp\gametypes\_missions::func_7750("ch_limited_lookoutbelow",1);
	thread maps\mp\gametypes\_missions::func_7750("ch_exomech_hot",1);
	level thread maps\mp\gametypes\_rank::func_1457("boostslamkill",self,param_01,undefined,param_02);
}

//Function Number: 18
func_353A(param_00,param_01,param_02)
{
	maps\mp\_utility::func_50EA(param_00 + "_earned",1);
	level thread maps\mp\gametypes\_rank::func_1457(param_00 + "_earned",self);
	thread maps\mp\gametypes\_hud_message::func_5A78(param_00,param_01,undefined,param_02);
	maps\mp\_matchdata::func_5E99(param_00);
}

//Function Number: 19
func_1D7E(param_00,param_01)
{
	maps\mp\_utility::func_50EA("bulletpenkills",1);
	level thread maps\mp\gametypes\_rank::func_1457("bulletpen",self);
	if(isdefined(param_01))
	{
		var_02 = maps\mp\_utility::func_4431(param_01,1);
		if(maps\mp\_utility::func_5856(var_02))
		{
			var_02 = maps\mp\gametypes\_class::func_4432(var_02);
		}

		var_03 = maps\mp\gametypes\_missions::func_40EE(param_01,var_02);
		if(var_03 == "weapon_sniper")
		{
			if(isdefined(level.var_20AA["ch_penetrate_" + var_02]))
			{
				maps\mp\gametypes\_missions::func_7750("ch_penetrate_" + var_02);
			}
		}
	}

	maps\mp\gametypes\_missions::func_7750("ch_boot_xray");
}

//Function Number: 20
func_6513()
{
	maps\mp\_utility::func_50EA("multiKillOneBullet",1);
	level thread maps\mp\gametypes\_rank::func_1457("multiKillOneBullet",self);
	maps\mp\gametypes\_missions::func_7750("ch_killer_greedy");
}

//Function Number: 21
func_21C5(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04) && isdefined(param_04.var_2093))
	{
		var_05 = param_04.var_2093;
	}
	else
	{
		var_05 = self method_83B9();
	}

	if(isdefined(param_04) && isdefined(param_04.var_2094))
	{
		var_06 = param_04.var_2094;
	}
	else
	{
		var_06 = param_01 method_83B9();
	}

	if(var_05 && var_06)
	{
		func_0BA1(param_01,param_02,param_03);
	}

	if(var_05 && !var_06)
	{
		func_0BA2(param_01,param_02,param_03);
	}

	if(!var_05 && var_06)
	{
		func_488C(param_01,param_02,param_03);
	}
}

//Function Number: 22
func_21F2(param_00,param_01,param_02)
{
	if(maps\mp\gametypes\_weapons::func_57AE(param_01))
	{
		func_7EA0(param_01,param_02);
	}

	if(issubstr(param_01,"exoknife_mp"))
	{
		func_390B(param_01,param_02,param_00);
	}
}

//Function Number: 23
func_390B(param_00,param_01,param_02)
{
	maps\mp\_utility::func_50EA("exo_knife_kill",1);
	if(isdefined(param_02.var_A876) && param_02.var_A876)
	{
		maps\mp\_utility::func_50EA("exo_knife_recall_kill",1);
		level thread maps\mp\gametypes\_rank::func_1457("exo_knife_recall_kill",self,param_00,undefined,param_01);
		return;
	}

	level thread maps\mp\gametypes\_rank::func_1457("exo_knife_kill",self,param_00,undefined,param_01);
}

//Function Number: 24
func_6634(param_00,param_01)
{
	self notify("neardeath_battlecry");
	maps\mp\_utility::func_50EA("near_death_kill",1);
	level thread maps\mp\gametypes\_rank::func_1457("near_death_kill",self,param_00,undefined,param_01);
	maps\mp\gametypes\_missions::func_99C5(param_00,"ch_camoT2_neardeath_");
}

//Function Number: 25
func_9131(param_00,param_01)
{
	maps\mp\_utility::func_50EA("slide_kill",1);
	level thread maps\mp\gametypes\_rank::func_1457("slide_kill",self,param_00,undefined,param_01);
	maps\mp\gametypes\_missions::func_7750("ch_boot_hero");
}

//Function Number: 26
concusskillevent(param_00)
{
	maps\mp\gametypes\_missions::func_7750("ch_tacticals_concussionkills");
	if(maps\mp\_utility::func_649("specialty_class_concussed"))
	{
		maps\mp\gametypes\_missions::func_7750("ch_explosives_concussed");
	}
}

//Function Number: 27
gaskillevent(param_00)
{
	maps\mp\gametypes\_missions::func_7750("ch_tacticals_poisonkills");
}

//Function Number: 28
flarekillevent(param_00)
{
	maps\mp\gametypes\_missions::func_7750("ch_tacticals_flarekills");
}

//Function Number: 29
func_3D4B(param_00)
{
	maps\mp\gametypes\_missions::func_7750("ch_tacticals_flashkills");
}

//Function Number: 30
blindfightkillevent(param_00,param_01)
{
	maps\mp\_utility::func_50EA("flash_kill",1);
	level thread maps\mp\gametypes\_rank::func_1457("flash_kill",self,param_00,undefined,param_01);
}

//Function Number: 31
func_8C5D(param_00,param_01)
{
	if(isdefined(self.var_1189))
	{
		foreach(var_03 in self.var_1189)
		{
			if(isexplosivedamagemod(var_03.var_8CD7) && maps\mp\_utility::func_649("specialty_stun_resistance") && maps\mp\_utility::func_649("specialty_blastshield2"))
			{
				maps\mp\gametypes\_missions::func_7750("ch_perks1_cantbebothered");
				break;
			}
		}
	}
}

//Function Number: 32
func_57F1(param_00)
{
	if(isdefined(self.var_1189))
	{
		foreach(var_02 in self.var_1189)
		{
			if(isexplosivedamagemod(var_02.var_8CD7) && maps\mp\_utility::func_649("specialty_blastshield2"))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 33
getclosest(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(self.var_1189[param_00.var_48CA]))
	{
		foreach(var_03 in self.var_1189[param_00.var_48CA].var_A9DF)
		{
			if(param_01 == "thickskin" && var_03 != "throwingknife_mp" && maps\mp\gametypes\_weapons::func_5747(var_03))
			{
				maps\mp\gametypes\_missions::func_7750("ch_perks1_thickskin");
			}

			if(param_01 == "focused" && var_03 == "flash_grenade_mp" || var_03 == "stun_grenade_mp" || var_03 == "signal_flare_mp" || var_03 == "tabun_grenade_mp" || var_03 == "concussion_grenade_mp")
			{
				maps\mp\gametypes\_missions::func_7750("ch_humiliation_focused");
			}
		}
	}
}

//Function Number: 34
func_3DD4(param_00)
{
	if(isdefined(param_00) && isdefined(param_00.var_1189[self.var_48CA]))
	{
		foreach(var_02 in param_00.var_1189[self.var_48CA].var_A9DF)
		{
			if(var_02 == "flash_grenade_mp" || var_02 == "stun_grenade_mp" || var_02 == "signal_flare_mp")
			{
				maps\mp\gametypes\_missions::func_7750("ch_lethals_dazed");
			}
		}
	}
}

//Function Number: 35
func_7EA0(param_00,param_01)
{
	maps\mp\_utility::func_50EA("riot_kill",1);
	level thread maps\mp\gametypes\_rank::func_1457("riot_kill",self,param_00,undefined,param_01);
}

//Function Number: 36
riotshielddamagetakenevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("shield_dmg_taken",self);
}

//Function Number: 37
func_0BA1(param_00,param_01,param_02)
{
	maps\mp\_utility::func_50EA("air_to_air_kill",1);
	thread maps\mp\gametypes\_missions::func_7750("ch_limited_acepilot",1);
	thread maps\mp\gametypes\_missions::func_7750("ch_exomech_redbaron",1);
	var_03 = maps\mp\_utility::func_4431(param_01,1);
	if(maps\mp\_utility::func_5856(var_03))
	{
		var_03 = maps\mp\gametypes\_class::func_4432(var_03);
	}

	var_04 = maps\mp\gametypes\_missions::func_40EE(param_01,var_03);
	if(maps\mp\_utility::func_5755(param_02))
	{
		maps\mp\_utility::func_50EA("melee_air_to_air",1);
		level thread maps\mp\gametypes\_rank::func_1457("melee_air_to_air",self,param_01,undefined,param_02);
		return;
	}

	level thread maps\mp\gametypes\_rank::func_1457("air_to_air_kill",self,param_01,undefined,param_02);
	if(var_04 == "weapon_smg" || var_04 == "weapon_shotgun")
	{
		if(isdefined(level.var_20AA["ch_dogfight_" + var_03]))
		{
			maps\mp\gametypes\_missions::func_7750("ch_dogfight_" + var_03);
			return;
		}
	}
}

//Function Number: 38
func_0BA2(param_00,param_01,param_02)
{
	maps\mp\_utility::func_50EA("air_to_ground_kill",1);
	level thread maps\mp\gametypes\_rank::func_1457("air_to_ground_kill",self,param_01,undefined,param_02);
	thread maps\mp\gametypes\_missions::func_7750("ch_exomech_buzz");
	var_03 = maps\mp\_utility::func_4431(param_01,1);
	if(maps\mp\_utility::func_5856(var_03))
	{
		var_03 = maps\mp\gametypes\_class::func_4432(var_03);
	}

	var_04 = maps\mp\gametypes\_missions::func_40EE(param_01,var_03);
	if(var_04 == "weapon_assault" || var_04 == "weapon_heavy" || issubstr(param_01,"exocrossbow"))
	{
		if(issubstr(var_03,"dlcgun") && var_04 == "weapon_assault" || var_04 == "weapon_heavy")
		{
			maps\mp\gametypes\_missions::func_7750("ch_tier2_1_" + var_03);
			return;
		}

		maps\mp\gametypes\_missions::func_7750("ch_strafe_" + var_03);
	}
}

//Function Number: 39
func_488C(param_00,param_01,param_02)
{
	maps\mp\_utility::func_50EA("ground_to_air_kill",1);
	level thread maps\mp\gametypes\_rank::func_1457("ground_to_air_kill",self,param_01,undefined,param_02);
	thread maps\mp\gametypes\_missions::func_7750("ch_exomech_pull");
	var_03 = maps\mp\_utility::func_4431(param_01,1);
	if(maps\mp\_utility::func_5856(var_03))
	{
		var_03 = maps\mp\gametypes\_class::func_4432(var_03);
	}

	var_04 = maps\mp\gametypes\_missions::func_40EE(param_01,var_03);
	if(var_04 == "weapon_heavy" || issubstr(param_01,"exocrossbow"))
	{
		if(issubstr(var_03,"dlcgun") && var_04 == "weapon_heavy")
		{
			maps\mp\gametypes\_missions::func_7750("ch_tier2_3_" + var_03);
			return;
		}

		maps\mp\gametypes\_missions::func_7750("ch_skeet_" + var_03);
	}
}

//Function Number: 40
func_5766(param_00,param_01,param_02)
{
	if(param_00.var_1193.size != 1)
	{
		return 0;
	}

	if(!isdefined(param_00.var_1193[self.var_48CA]))
	{
		return 0;
	}

	if(maps\mp\_utility::func_5755(param_02))
	{
		return 0;
	}

	if(gettime() != param_00.var_1189[self.var_48CA].var_3C71)
	{
		return 0;
	}

	var_03 = maps\mp\_utility::func_472A(param_01);
	var_04 = maps\mp\_utility::func_45B5(param_01);
	if(var_03 == "weapon_sniper" || var_03 == "weapon_shotgun" || var_04 == "dp28_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 41
func_574D(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03.var_A4F))
	{
		return 0;
	}

	var_04 = self.var_116;
	if(isdefined(param_03.var_1192))
	{
		var_04 = param_03.var_1192;
	}

	if(isalive(param_00) && !param_00 maps\mp\_utility::func_581D() && (param_02 == "MOD_RIFLE_BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_HEAD_SHOT" || issubstr(param_01,"throwingknife") || issubstr(param_01,"exoknife_mp") || issubstr(param_01,"exocrossbow")) && !maps\mp\_utility::func_5740(param_01) && !isdefined(param_00.var_10E9))
	{
		var_05 = maps\mp\_utility::func_472A(param_01);
		switch(var_05)
		{
			case "weapon_pistol":
				var_06 = 800;
				break;

			case "weapon_smg":
				var_06 = 1200;
				break;

			case "weapon_heavy":
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

		if(issubstr(param_01,"throwingknife"))
		{
			var_06 = 1200;
		}

		if(issubstr(param_01,"exoknife_mp") || issubstr(param_01,"exocrossbow"))
		{
			var_06 = 1200;
		}

		var_07 = var_06 * var_06;
		if(distancesquared(var_04,param_03.var_116) > var_07)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 42
func_57A8(param_00,param_01)
{
	if(!level.var_984D)
	{
		return 0;
	}

	foreach(var_04, var_03 in param_00.var_29BD)
	{
		if(var_04 != self.var_48CA && param_01 - var_03 < 500)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 43
func_5EB3(param_00,param_01,param_02)
{
	self.var_62A1["longshot"] = 1;
	maps\mp\_utility::func_50EA("longshots",1);
	level thread maps\mp\gametypes\_rank::func_1457("longshot",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::func_5E96(param_00,"longshot");
	maps\mp\gametypes\_missions::func_99C5(param_01,"ch_camoT2_longshot_");
}

//Function Number: 44
func_4BF6(param_00,param_01,param_02)
{
	self.var_62A1["headshot"] = 1;
	maps\mp\_utility::func_50E9("headshots",1);
	maps\mp\_utility::func_50EA("headshots",1);
	maps\mp\gametypes\_persistence::func_933A("round","headshots",maps\mp\_utility::func_2315(self.var_12C["headshots"]));
	self.var_4BF9 = maps\mp\_utility::func_4607("headshots");
	if(self.var_79 == 7)
	{
	}

	level thread maps\mp\gametypes\_rank::func_1457("headshot",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::func_5E96(param_00,"headshot");
	maps\mp\gametypes\_missions::func_7750("ch_limited_headhunter");
	maps\mp\gametypes\_missions::func_7750("ch_career_headshots");
	maps\mp\gametypes\_missions::tier4camochallenge(param_01,"ch_camoT4_headshot_");
	if(level.var_3FDC == "war" || level.var_3FDC == "dm")
	{
		maps\mp\_utility::func_867C(self.var_12C["headshots"]);
	}
}

//Function Number: 45
func_5805(param_00,param_01,param_02,param_03)
{
	if(!isexplosivedamagemod(param_02))
	{
		return 0;
	}

	if(!maps\mp\_utility::func_57E5(param_01,"frag_"))
	{
		return 0;
	}

	if(isdefined(param_00) && isdefined(param_03) && isdefined(param_03.var_117) && param_00.var_1A7 == param_03.var_117.var_1A7)
	{
		return 0;
	}

	if(isdefined(param_00) && isdefined(param_00.var_3961) && isdefined(param_00.var_3961["throwbackKill"]) && param_00.var_3961["throwbackKill"])
	{
		return 1;
	}

	return 0;
}

//Function Number: 46
func_99A8()
{
	maps\mp\_utility::func_50EA("throwback_kill",1);
	level thread maps\mp\gametypes\_rank::func_1457("throwback_kill",self);
}

//Function Number: 47
func_56A2(param_00)
{
	var_01 = undefined;
	foreach(var_03 in level.var_744A)
	{
		if(isdefined(var_03) && isdefined(param_00) && isdefined(var_03.var_1A7) && isdefined(param_00.var_1A7) && var_03.var_1A7 == level.var_6C63[param_00.var_1A7] && isdefined(var_03.var_2013) || var_03 maps\mp\_utility::func_649("specialty_ballcarrier"))
		{
			var_01 = var_03.var_48CA;
		}
	}

	if(isdefined(var_01))
	{
		foreach(var_03 in param_00.var_29BD)
		{
			if(isdefined(param_00.var_29BD[var_01]) && param_00.var_29BD[var_01] == var_03)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 48
func_2007()
{
	maps\mp\gametypes\_missions::func_7750("ch_heroics_coveringfire");
}

//Function Number: 49
func_5CA9(param_00,param_01)
{
	if(self.var_A25D)
	{
		self notify("increment_resupplylethal_kills");
	}

	func_3DD4(param_00);
}

//Function Number: 50
func_3E49()
{
	maps\mp\_utility::func_50EA("four_play",1);
	level thread maps\mp\gametypes\_rank::func_1457("four_play",self);
}

//Function Number: 51
func_13BA(param_00,param_01,param_02)
{
	self.var_62A1["avenger"] = 1;
	maps\mp\_utility::func_50EA("avengekills",1);
	level thread maps\mp\gametypes\_rank::func_1457("avenger",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::func_5E96(param_00,"avenger");
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_avenger");
}

//Function Number: 52
func_10EA(param_00,param_01,param_02)
{
	self.var_62A1["assistedsuicide"] = 1;
	maps\mp\_utility::func_50EA("assistedsuicide",1);
	level thread maps\mp\gametypes\_rank::func_1457("assistedsuicide",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::func_5E96(param_00,"assistedsuicide");
}

//Function Number: 53
func_2C77(param_00,param_01,param_02)
{
	self.var_62A1["defender"] = 1;
	maps\mp\_utility::func_50EA("rescues",1);
	level thread maps\mp\gametypes\_rank::func_1457("defender",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::func_5E96(param_00,"defender");
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_savior");
}

//Function Number: 54
func_2C80(param_00,param_01,param_02,param_03)
{
	maps\mp\_utility::func_50EA("defends",1);
	maps\mp\_utility::func_50E9("defends",1);
	if(maps\mp\_utility::func_579B())
	{
		self setclientomnvar("ui_onevone_class_2",self.var_12C["defends"]);
	}

	maps\mp\gametypes\_persistence::func_933A("round","defends",self.var_12C["defends"]);
	if(!isdefined(param_02) || !maps\mp\_utility::func_5740(param_02))
	{
		level thread maps\mp\gametypes\_rank::func_1457("defend",self);
	}

	maps\mp\gametypes\_missions::func_B9D();
	param_00 thread maps\mp\_matchdata::func_5E96(param_01,"assaulting");
	if(isdefined(param_03))
	{
		thread maps\mp\_matchdata::func_5E93("hp_defend",self.var_116,param_03);
		return;
	}

	thread maps\mp\_matchdata::func_5E93("defend",self.var_116);
}

//Function Number: 55
func_10BA(param_00,param_01,param_02)
{
	maps\mp\_utility::func_50EA("assault",1);
	if(!isdefined(param_02) || !maps\mp\_utility::func_5740(param_02))
	{
		level thread maps\mp\gametypes\_rank::func_1457("assault",self);
	}

	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_attacker");
	maps\mp\gametypes\_missions::func_B9D();
	param_00 thread maps\mp\_matchdata::func_5E96(param_01,"defending");
}

//Function Number: 56
ispostdeathkillevent(param_00,param_01)
{
	if(isalive(self) && !isdefined(param_01) && isdefined(param_01.var_5CC6) && isdefined(self.var_5CC6) && param_01.var_5CC6 != self.var_5CC6 && !isdefined(param_01.var_117) && param_01.var_117 != self)
	{
		return 0;
	}

	if(!self != param_00 && isdefined(self.var_2AB8) && self.var_2AB8 + 1200 < gettime())
	{
		return 0;
	}

	return 1;
}

//Function Number: 57
func_75E2(param_00)
{
	self.var_62A1["posthumous"] = 1;
	maps\mp\_utility::func_50EA("posthumous",1);
	level thread maps\mp\gametypes\_rank::func_1457("posthumous",self);
	thread maps\mp\_matchdata::func_5E96(param_00,"posthumous");
	maps\mp\gametypes\_missions::func_7750("ch_humiliation_afterlife");
}

//Function Number: 58
func_57CE(param_00,param_01)
{
	if(isdefined(param_01) && maps\mp\_utility::func_5755(param_01) && isdefined(param_00) && function_01A9(param_00) == "melee")
	{
		return 1;
	}

	return 0;
}

//Function Number: 59
func_8C55()
{
	maps\mp\_utility::func_50EA("silentkill",1);
}

//Function Number: 60
func_5681(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::func_5755(param_02))
	{
		return 0;
	}

	if(maps\mp\gametypes\_weapons::func_57AE(param_01))
	{
		return 0;
	}

	var_03 = param_00 getangles();
	var_04 = self getangles();
	var_05 = angleclamp180(var_03[1] - var_04[1]);
	if(abs(var_05) < 75)
	{
		return 1;
	}

	return 0;
}

//Function Number: 61
func_14EE(param_00)
{
	maps\mp\_utility::func_50EA("backstab",1);
	level thread maps\mp\gametypes\_rank::func_1457("backstab",self);
	maps\mp\gametypes\_missions::func_99C5(param_00,"ch_camoT2_backstab_");
	maps\mp\gametypes\_missions::tier3camochallenge(param_00,"ch_camoT3_backstab_");
}

//Function Number: 62
func_60EB(param_00,param_01)
{
	maps\mp\gametypes\_missions::func_7750("ch_career_meleekills");
}

//Function Number: 63
func_7E3F(param_00,param_01)
{
	self.var_62A1["revenge"] = 1;
	self.var_5BB1 = undefined;
	maps\mp\_utility::func_50EA("revengekills",1);
	level thread maps\mp\gametypes\_rank::func_1457("revenge",self);
	thread maps\mp\_matchdata::func_5E96(param_00,"revenge");
	maps\mp\gametypes\_missions::func_7750("ch_humiliation_revenge");
	maps\mp\gametypes\_missions::func_99C5(param_01,"ch_camoT2_revenge_");
}

//Function Number: 64
func_6512(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = maps\mp\gametypes\_missions::func_40EE(param_02);
	var_05 = maps\mp\_utility::func_4431(param_02,1);
	if(maps\mp\_utility::func_5856(var_05))
	{
		var_05 = maps\mp\gametypes\_class::func_4432(var_05);
	}

	var_06 = "";
	if(common_scripts\utility::func_9467(var_05,"iw5_"))
	{
		var_06 = getsubstr(var_05,4);
	}

	if(level.var_53C7 && param_01 >= 4)
	{
		maps\mp\gametypes\_missions::func_7750("ch_scorestreaktraining_multikill");
	}

	maps\mp\gametypes\_gamelogic::func_8A67(var_05,1,"multikills");
	if(maps\mp\_utility::func_5740(var_05))
	{
		if(isdefined(level.var_5A7D) && isdefined(level.var_5A7D[var_05]))
		{
			maps\mp\gametypes\_persistence::incrementscorestreakstat(level.var_5A7D[var_05],"multikills",1);
		}
	}

	if(maps\mp\gametypes\_weapons::func_5747(var_05))
	{
		self notify("increment_lethaldouble_kills");
	}

	switch(param_01)
	{
		case 2:
			level thread maps\mp\gametypes\_rank::func_1457("doublekill",self,var_05);
			maps\mp\_utility::func_50EA("doublekill",1);
			maps\mp\gametypes\_missions::func_7750("ch_killer_double");
			maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_double");
			if(var_04 == "weapon_smg" || var_04 == "weapon_shotgun" || var_04 == "weapon_sniper" || var_05 == "iw5_microdronelauncher" || var_05 == "iw5_exocrossbow")
			{
				if(isdefined(level.var_20AA["ch_double_" + var_05]))
				{
					maps\mp\gametypes\_missions::func_7750("ch_double_" + var_05);
				}
			}
	
			if(isdefined(level.var_20AA["ch_attach_unlock_double_" + var_06]))
			{
				maps\mp\gametypes\_missions::func_7750("ch_attach_unlock_double_" + var_06);
			}
			break;

		case 3:
			level thread maps\mp\gametypes\_rank::func_1457("triplekill",self,var_05);
			level thread maps\mp\_utility::func_9863("callout_3xkill",self);
			maps\mp\_utility::func_50EA("triplekill",1);
			maps\mp\gametypes\_missions::func_7750("ch_killer_triple");
			maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_triple");
			if(maps\mp\gametypes\_missions::func_5678())
			{
				maps\mp\gametypes\_missions::func_7750("ch_precision_sitcrit");
			}
	
			if(isdefined(var_04) && (var_04 == "weapon_smg" || var_04 == "weapon_heavy") && param_03 == 0)
			{
				maps\mp\gametypes\_missions::func_7750("ch_precision_hello");
			}
			break;

		case 4:
			level thread maps\mp\gametypes\_rank::func_1457("fourkill",self,var_05);
			level thread maps\mp\_utility::func_9863("callout_4xkill",self);
			maps\mp\_utility::func_50EA("fourkill",1);
			maps\mp\gametypes\_missions::func_7750("ch_killer_fury");
			maps\mp\gametypes\_missions::func_7750("ch_limited_bloodshed_fury");
			maps\mp\_utility::func_863E(18,self.var_1A7,self getentitynumber(),4);
			break;

		case 5:
			level thread maps\mp\gametypes\_rank::func_1457("fivekill",self,var_05);
			level thread maps\mp\_utility::func_9863("callout_5xkill",self);
			maps\mp\_utility::func_50EA("fivekill",1);
			break;

		case 6:
			level thread maps\mp\gametypes\_rank::func_1457("sixkill",self,var_05);
			level thread maps\mp\_utility::func_9863("callout_6xkill",self);
			maps\mp\_utility::func_50EA("sixkill",1);
			break;

		case 7:
			level thread maps\mp\gametypes\_rank::func_1457("sevenkill",self,var_05);
			level thread maps\mp\_utility::func_9863("callout_7xkill",self);
			maps\mp\_utility::func_50EA("sevenkill",1);
			break;

		case 8:
			level thread maps\mp\gametypes\_rank::func_1457("eightkill",self,var_05);
			level thread maps\mp\_utility::func_9863("callout_8xkill",self);
			maps\mp\_utility::func_50EA("eightkill",1);
			break;

		default:
			level thread maps\mp\gametypes\_rank::func_1457("multikill",self,var_05);
			thread maps\mp\_utility::func_9863("callout_9xpluskill",self);
			maps\mp\_utility::func_50EA("multikill",1);
			break;
	}

	thread maps\mp\_matchdata::func_5E9D(param_00,param_01);
}

//Function Number: 65
func_95D1()
{
	maps\mp\_utility::func_50EA("take_and_kill",1);
	level thread maps\mp\gametypes\_rank::func_1457("take_and_kill",self);
	maps\mp\gametypes\_missions::func_7750("ch_humiliation_backfire");
}

//Function Number: 66
func_5A3A()
{
	maps\mp\_utility::func_50EA("killedBallCarrier",1);
	level thread maps\mp\gametypes\_rank::func_1457("killedBallCarrier",self);
	maps\mp\gametypes\_missions::func_7750("ch_heroics_takedown");
	if(level.var_3FDC == "ball")
	{
		maps\mp\_utility::func_867C(maps\mp\_utility::func_4628("killedBallCarrier"));
		thread maps\mp\_matchdata::func_5E93("kill_carrier",self.var_116);
	}
}

//Function Number: 67
func_8A2C()
{
	var_00 = maps\mp\_utility::func_4628("fieldgoal") + maps\mp\_utility::func_4628("touchdown") * 2;
	maps\mp\gametypes\_persistence::func_933A("round","captures",var_00);
	maps\mp\_utility::func_867B(var_00);
}

//Function Number: 68
func_9ABB(param_00)
{
	thread maps\mp\_utility::func_9863("callout_touchdown",self,undefined,param_00);
	maps\mp\_utility::func_50EA("touchdown",1);
	func_8A2C();
	level thread maps\mp\gametypes\_rank::func_1457("touchdown",self);
	maps\mp\gametypes\_missions::func_7750("ch_heroics_destroyer");
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_touchdown");
	thread maps\mp\_matchdata::func_5E93("touchdown",self.var_116);
}

//Function Number: 69
func_3AA1(param_00)
{
	thread maps\mp\_utility::func_9863("callout_fieldgoal",self,undefined,param_00);
	maps\mp\_utility::func_50EA("fieldgoal",1);
	func_8A2C();
	level thread maps\mp\gametypes\_rank::func_1457("fieldgoal",self);
	maps\mp\gametypes\_missions::func_7750("ch_heroics_destroyer");
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_fieldgoal");
	thread maps\mp\_matchdata::func_5E93("fieldgoal",self.var_116);
}

//Function Number: 70
func_5415()
{
	maps\mp\_utility::func_50EA("interception",1);
	level thread maps\mp\gametypes\_rank::func_1457("interception",self);
	thread maps\mp\_matchdata::func_5E93("interception",self.var_116);
}

//Function Number: 71
func_5A83()
{
	maps\mp\_utility::func_50EA("kill_with_ball",1);
	level thread maps\mp\gametypes\_rank::func_1457("kill_with_ball",self);
	thread maps\mp\_matchdata::func_5E93("kill_with_ball",self.var_116);
}

//Function Number: 72
func_1563()
{
	maps\mp\_utility::func_50EA("ball_score_assist",1);
	level thread maps\mp\gametypes\_rank::func_1457("ball_score_assist",self);
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_assist");
}

//Function Number: 73
func_6EB2()
{
	maps\mp\_utility::func_50EA("pass_kill_pickup",1);
	level thread maps\mp\gametypes\_rank::func_1457("pass_kill_pickup",self);
}

//Function Number: 74
firsttouchrelicevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("relic_first_touch",self);
}

//Function Number: 75
relicgoalevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("relic_goal",self);
}

//Function Number: 76
heldrelicevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("relic_held",self);
}

//Function Number: 77
killwithrelicevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("relic_kill_as_carrier",self);
}

//Function Number: 78
killedreliccarrierevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("relic_killed_carrier",self);
	lib_0468::ae_sendzombiekillevent();
}

//Function Number: 79
relicpasskillevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("relic_pass_kill",self);
}

//Function Number: 80
relicinterceptionevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("relic_interception",self);
}

//Function Number: 81
func_3CC1()
{
	thread maps\mp\_utility::func_9863("callout_flagpickup",self);
	maps\mp\_utility::func_50EA("flagscarried",1);
	level thread maps\mp\gametypes\_rank::func_1457("flag_pickup",self);
	thread maps\mp\_matchdata::func_5E93("pickup",self.var_116);
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_flag_carry");
}

//Function Number: 82
func_3CB7()
{
	thread maps\mp\_utility::func_9863("callout_flagcapture",self);
	maps\mp\_utility::func_50EA("flagscaptured",1);
	maps\mp\_utility::func_50E9("captures",1);
	maps\mp\gametypes\_persistence::func_933A("round","captures",self.var_12C["captures"]);
	maps\mp\_utility::func_867B(self.var_12C["captures"]);
	level thread maps\mp\gametypes\_rank::func_1457("flag_capture",self);
	thread maps\mp\_matchdata::func_5E93("capture",self.var_116);
	maps\mp\gametypes\_missions::func_7750("ch_heroics_destroyer");
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_flag_capture");
}

//Function Number: 83
func_3CC3()
{
	thread maps\mp\_utility::func_9863("callout_flagreturn",self);
	maps\mp\_utility::func_50EA("flagsreturned",1);
	maps\mp\_utility::func_50E9("returns",1);
	self.var_21 = self.var_12C["returns"];
	maps\mp\gametypes\_persistence::func_933A("round","returns",self.var_12C["returns"]);
	level thread maps\mp\gametypes\_rank::func_1457("flag_return",self);
	thread maps\mp\_matchdata::func_5E93("return",self.var_116);
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_flag_return");
}

//Function Number: 84
func_5A84(param_00)
{
	maps\mp\_utility::func_50EA("killsasflagcarrier",1);
	if(!isdefined(param_00) || !maps\mp\_utility::func_5740(param_00))
	{
		level thread maps\mp\gametypes\_rank::func_1457("kill_with_flag",self);
	}
}

//Function Number: 85
func_5A46(param_00)
{
	thread maps\mp\_utility::func_9863("callout_killflagcarrier",self);
	maps\mp\_utility::func_50EA("flagcarrierkills",1);
	maps\mp\_utility::func_50E9("defends",1);
	maps\mp\_utility::func_867C(self.var_12C["defends"]);
	maps\mp\gametypes\_persistence::func_933A("round","defends",self.var_12C["defends"]);
	level thread maps\mp\gametypes\_rank::func_1457("kill_flag_carrier",self);
	thread maps\mp\_matchdata::func_5E96(param_00,"carrying");
	thread maps\mp\_matchdata::func_5E93("kill_carrier",self.var_116);
	maps\mp\gametypes\_missions::func_7750("ch_heroics_takedown");
}

//Function Number: 86
func_5A38(param_00)
{
	maps\mp\_utility::func_50EA("killsdenied",1);
	maps\mp\_utility::func_50E9("denied",1);
	maps\mp\_utility::func_867C(self.var_12C["denied"]);
	maps\mp\gametypes\_persistence::func_933A("round","denied",self.var_12C["denied"]);
	var_01 = "kill_denied";
	if(param_00)
	{
		var_01 = "kill_denied_retrieved";
		maps\mp\_utility::func_50EA("kill_denied_retrieved",1);
		maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_save_yourself");
	}

	level thread maps\mp\gametypes\_rank::func_1457(var_01,self);
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_denial");
}

//Function Number: 87
func_5A35()
{
	maps\mp\_utility::func_50EA("killsconfirmed",1);
	maps\mp\_utility::func_50E9("confirmed",1);
	maps\mp\_utility::func_867B(self.var_12C["confirmed"]);
	maps\mp\gametypes\_persistence::func_933A("round","confirmed",self.var_12C["confirmed"]);
	level thread maps\mp\gametypes\_rank::func_1457("kill_confirmed",self);
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_collector");
}

//Function Number: 88
func_95B5()
{
	maps\mp\_utility::func_50EA("tag_collector",1);
	level thread maps\mp\gametypes\_rank::func_1457("tag_collector",self);
}

//Function Number: 89
func_63E9(param_00)
{
	if(!isplayer(param_00))
	{
		return;
	}

	param_00 notify("tagCollector");
	param_00 endon("tagCollector");
	if(!isdefined(param_00.var_95B6))
	{
		param_00.var_95B6 = 0;
	}

	param_00.var_95B6++;
	if(param_00.var_95B6 > 2)
	{
		param_00 func_95B5();
		param_00.var_95B6 = 0;
	}

	wait(2.5);
	if(isdefined(param_00))
	{
		param_00.var_95B6 = 0;
	}
}

//Function Number: 90
func_18FC(param_00,param_01)
{
	maps\mp\_utility::func_50EA("bombsplanted",1);
	maps\mp\_utility::func_50E9("plants",1);
	maps\mp\gametypes\_persistence::func_933A("round","plants",self.var_12C["plants"]);
	maps\mp\_utility::func_867B(self.var_12C["plants"]);
	level thread maps\mp\_utility::func_9863("callout_bombplanted",self);
	if(isdefined(param_01) && param_01)
	{
		level thread maps\mp\gametypes\_rank::func_1457("raids_plant_multi",self);
	}
	else
	{
		level thread maps\mp\gametypes\_rank::func_1457("plant",self);
	}

	thread maps\mp\_matchdata::func_5E93("bomb_plant_complete",self.var_116,param_00);
}

//Function Number: 91
func_18D4(param_00,param_01)
{
	maps\mp\_utility::func_50EA("bombsdefused",1);
	maps\mp\_utility::func_50E9("defuses",1);
	maps\mp\gametypes\_persistence::func_933A("round","defuses",self.var_12C["defuses"]);
	maps\mp\_utility::func_867C(self.var_12C["defuses"]);
	level thread maps\mp\_utility::func_9863("callout_bombdefused",self);
	if(param_00 == "ninja_defuse" || param_00 == "last_man_defuse")
	{
		maps\mp\_utility::func_50EA(param_00,1);
		if(param_00 == "last_man_defuse")
		{
			maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_ninja");
		}
	}

	level thread maps\mp\gametypes\_rank::func_1457(param_00,self);
	thread maps\mp\_matchdata::func_5E93("bomb_defuse_complete",self.var_116,param_01);
	maps\mp\gametypes\_missions::func_7750("ch_heroics_defuser");
}

//Function Number: 92
func_35D2(param_00,param_01)
{
	maps\mp\_utility::func_50EA("elimination",1);
	level thread maps\mp\_utility::func_9863("callout_eliminated",param_01);
	if(param_00)
	{
		maps\mp\_utility::func_50EA("last_man_standing",1);
		level thread maps\mp\gametypes\_rank::func_1457("last_man_standing",self);
		return;
	}

	level thread maps\mp\gametypes\_rank::func_1457("elimination",self);
}

//Function Number: 93
func_7E63(param_00)
{
	maps\mp\_utility::func_50EA("sr_tag_revive",1);
	maps\mp\_utility::func_50EA("killsdenied",1);
	maps\mp\_utility::func_50E9("denied",1);
	maps\mp\gametypes\_persistence::func_933A("round","denied",self.var_12C["denied"]);
	self.var_21 = self.var_12C["denied"];
	level thread maps\mp\_utility::func_9863("callout_tag_revive",param_00);
	level thread maps\mp\gametypes\_rank::func_1457("sr_tag_revive",self);
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_medic");
}

//Function Number: 94
func_35D3()
{
	maps\mp\_utility::func_50EA("sr_tag_elimination",1);
	maps\mp\_utility::func_50EA("killsconfirmed",1);
	maps\mp\_utility::func_50E9("confirmed",1);
	maps\mp\gametypes\_persistence::func_933A("round","confirmed",self.var_12C["confirmed"]);
	level thread maps\mp\gametypes\_rank::func_1457("sr_tag_elimination",self);
}

//Function Number: 95
func_18D6(param_00)
{
	maps\mp\_utility::func_50EA("targetsdestroyed",1);
	maps\mp\_utility::func_50E9("destructions",1);
	maps\mp\gametypes\_persistence::func_933A("round","destructions",self.var_12C["destructions"]);
	level thread maps\mp\gametypes\_rank::func_1457("destroy",self);
	maps\mp\gametypes\_missions::func_7750("ch_heroics_destroyer");
	thread maps\mp\_matchdata::func_5E93("bomb_detonate",self.var_116,param_00);
}

//Function Number: 96
func_50ED()
{
	maps\mp\_utility::func_50EA("levelup",1);
	level thread maps\mp\gametypes\_rank::func_1457("gained_gun_score",self);
}

//Function Number: 97
func_2B72()
{
	maps\mp\_utility::func_50EA("dejavu",1);
	level thread maps\mp\gametypes\_rank::func_1457("dropped_gun_score",self);
}

//Function Number: 98
func_8634()
{
	maps\mp\_utility::func_50EA("humiliation",1);
	level thread maps\mp\gametypes\_rank::func_1457("dropped_enemy_gun_rank",self);
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_regression");
}

//Function Number: 99
func_7893()
{
	maps\mp\_utility::func_50EA("gunslinger",1);
	level thread maps\mp\gametypes\_rank::func_1457("quick_gun_rank",self);
}

//Function Number: 100
func_8635()
{
	maps\mp\_utility::func_50EA("regicide",1);
	level thread maps\mp\gametypes\_rank::func_1457("dropped_first_player_gun_rank",self);
}

//Function Number: 101
increasedbladesscoreriflebulletevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("gained_blades_score_riflebullet",self);
}

//Function Number: 102
increasedbladesscoredefectivegrenadeevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("gained_blades_score_defectivegrenade",self);
}

//Function Number: 103
increasedbladesscoremeleeevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("gained_blades_score_melee",self);
}

//Function Number: 104
quickbladesscoreevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("quick_blades_score",self);
}

//Function Number: 105
bankruptedbladesscoreevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("bankrupt_blades_score",self);
}

//Function Number: 106
bankruptedbladesscoresuicideevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("bankrupt_blades_score_suicide",self);
}

//Function Number: 107
bankruptenemybladesscoreevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("bankrupt_enemy_blades_score",self);
}

//Function Number: 108
bankruptfirstplayerbladesscoreevent()
{
	level thread maps\mp\gametypes\_rank::func_1457("bankrupt_first_player_blades_score",self);
}

//Function Number: 109
func_3C69()
{
	maps\mp\_utility::func_50EA("patientzero",1);
	maps\mp\_utility::func_74D9("mp_enemy_obj_captured");
	level thread maps\mp\_utility::func_9863("callout_first_infected",self);
	level thread maps\mp\gametypes\_rank::func_1457("first_infected",self);
	self.var_6EF6 = 0;
}

//Function Number: 110
func_3B5F()
{
	maps\mp\_utility::func_50EA("omegaman",1);
	maps\mp\_utility::func_74D9("mp_obj_captured");
	level thread maps\mp\_utility::func_9863("callout_final_survivor",self);
	level thread maps\mp\gametypes\_rank::func_1457("final_survivor",self);
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_survivor");
}

//Function Number: 111
func_4817()
{
	maps\mp\_utility::func_50EA("careless",1);
	level thread maps\mp\gametypes\_rank::func_1457("got_infected",self);
}

//Function Number: 112
func_700A()
{
	maps\mp\_utility::func_50EA("plague",1);
	level thread maps\mp\gametypes\_rank::func_1457("infected_plague",self);
}

//Function Number: 113
func_511D()
{
	maps\mp\_utility::func_50EA("contagious",1);
	level thread maps\mp\_utility::func_9863("callout_infected_survivor",self,"axis");
	level thread maps\mp\gametypes\_rank::func_1457("infected_survivor",self);
}

//Function Number: 114
func_9522()
{
	maps\mp\_utility::func_50EA("survivor",1);
	level thread maps\mp\gametypes\_rank::func_1457("survivor",self);
}

//Function Number: 115
func_320C(param_00,param_01)
{
	maps\mp\_utility::func_50EA("pointscaptured",1);
	maps\mp\_utility::func_50E9("captures",1);
	maps\mp\gametypes\_persistence::func_933A("round","captures",self.var_12C["captures"]);
	maps\mp\_utility::func_867B(self.var_12C["captures"]);
	var_02 = "capture";
	if(param_00)
	{
		var_02 = "opening_move";
		maps\mp\_utility::func_50EA("opening_move",1);
	}

	if(param_01)
	{
		var_02 = "starting_flag";
	}

	if(isdefined(self.var_5137) || isdefined(self.var_5384))
	{
		maps\mp\gametypes\_missions::func_7750("ch_tacticals_smokescreen");
	}

	level thread maps\mp\gametypes\_rank::func_1457(var_02,self);
	maps\mp\gametypes\_missions::func_7750("ch_heroics_destroyer");
	thread maps\mp\_matchdata::func_5E93("capture",self.var_116);
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_aggression");
}

//Function Number: 116
func_3218()
{
	level thread maps\mp\gametypes\_rank::func_1457("neutralize",self);
}

//Function Number: 117
func_5E67(param_00,param_01)
{
	maps\mp\_utility::func_50EA("pointscaptured",1);
	maps\mp\_utility::func_50E9("captures",1);
	maps\mp\gametypes\_persistence::func_933A("round","captures",self.var_12C["captures"]);
	maps\mp\_utility::func_867B(self.var_12C["captures"]);
	var_02 = "capture";
	if(param_00)
	{
		var_02 = "opening_move";
		maps\mp\_utility::func_50EA("opening_move",1);
	}

	if(param_01)
	{
		var_02 = "starting_flag";
	}

	level thread maps\mp\gametypes\_rank::func_1457(var_02,self);
	thread maps\mp\_matchdata::func_5E93("capture",self.var_116);
	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_aggression");
}

//Function Number: 118
func_5E68()
{
	level thread maps\mp\gametypes\_rank::func_1457("neutralize",self);
}

//Function Number: 119
func_5A82(param_00,param_01,param_02,param_03)
{
	maps\mp\_utility::func_50EA("assault",1);
	maps\mp\_utility::func_50EA("kill_while_capture",1);
	if(!isdefined(param_02) || !maps\mp\_utility::func_5740(param_02))
	{
		if(level.var_3FDC == "hp" || level.var_3FDC == "undead")
		{
			level thread maps\mp\gametypes\_rank::func_1457("kill_on_hardpoint",self);
		}
		else
		{
			level thread maps\mp\gametypes\_rank::func_1457("kill_while_capture",self);
		}
	}

	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_defender");
	maps\mp\gametypes\_missions::func_B9D();
	param_00 thread maps\mp\_matchdata::func_5E96(param_01,"defending");
}

//Function Number: 120
func_836D(param_00)
{
	maps\mp\_utility::func_50EA("hp_secure",1);
	maps\mp\_utility::func_50E9("captures",1);
	maps\mp\gametypes\_persistence::func_933A("round","captures",self.var_12C["captures"]);
	level thread maps\mp\_utility::func_9863("callout_hp_captured_by",self);
	level thread maps\mp\gametypes\_rank::func_1457("hp_secure",self);
	maps\mp\gametypes\_missions::func_7750("ch_heroics_destroyer");
	if(isdefined(self.var_5137) || isdefined(self.var_5384))
	{
		maps\mp\gametypes\_missions::func_7750("ch_tacticals_smokescreen");
	}

	maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_aggression");
}

//Function Number: 121
func_4C68()
{
	level thread maps\mp\gametypes\_rank::func_1457("hp_held",self);
}

//Function Number: 122
func_3C63(param_00,param_01,param_02)
{
	self.var_62A1["firstblood"] = 1;
	maps\mp\_utility::func_50EA("firstblood",1);
	self.var_97++;
	thread maps\mp\_utility::func_9863("callout_firstblood",self);
	level thread maps\mp\gametypes\_rank::func_1457("firstblood",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::func_5E96(param_00,"firstblood");
}

//Function Number: 123
func_5757(param_00)
{
	var_01 = param_00 getvelocity();
	var_02 = var_01[2];
	if(!param_00 isonground() && var_02 > 50 || var_02 < -50)
	{
		return 1;
	}

	return 0;
}

//Function Number: 124
func_6161()
{
	maps\mp\gametypes\_missions::func_7750("ch_boot_airborne");
}

//Function Number: 125
func_241E()
{
	maps\mp\gametypes\_missions::func_7750("ch_boot_commando");
}

//Function Number: 126
func_5698(param_00)
{
	if(maps\mp\_utility::func_F5C())
	{
		foreach(var_02 in param_00.var_5A71)
		{
			if(maps\mp\killstreaks\_killstreaks::func_57F0(param_00,var_02))
			{
				continue;
			}

			var_03 = param_00 maps\mp\killstreaks\_killstreaks::func_46B4(var_02);
			var_04 = param_00.var_A06;
			var_05 = param_00 maps\mp\_utility::func_649("specialty_killstreaks");
			if(var_03 < var_04)
			{
				continue;
			}

			if((!var_05 && var_03 - var_04 < 101) || var_05 && var_03 - var_04 <= 1)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 127
func_1DE7(param_00,param_01,param_02,param_03)
{
	self.var_62A1["buzzkill"] = param_01.var_12C["cur_kill_streak"];
	maps\mp\_utility::func_50EA("buzzkill",1);
	level thread maps\mp\gametypes\_rank::func_1457("buzzkill",self,param_02,undefined,param_03);
	maps\mp\gametypes\_missions::func_7750("ch_humiliation_buzzkill");
}

//Function Number: 128
func_6B12(param_00,param_01,param_02)
{
	self.var_62A1["oneshotkill"] = 1;
	maps\mp\_utility::func_50EA("oneshotkill",1);
	level thread maps\mp\gametypes\_rank::func_1457("oneshotkill",self,param_01,undefined,param_02);
	maps\mp\gametypes\_missions::func_7750("ch_limited_deadeye");
	if(maps\mp\_utility::func_472A(param_01) == "weapon_sniper")
	{
		self notify("increment_sharpshooter_kills");
		return;
	}

	if(maps\mp\_utility::func_472A(param_01) == "weapon_shotgun")
	{
		self notify("increment_oneshotgun_kills");
	}
}

//Function Number: 129
func_2535(param_00,param_01,param_02)
{
	self.var_62A1["comeback"] = 1;
	maps\mp\_utility::func_50EA("comebacks",1);
	level thread maps\mp\gametypes\_rank::func_1457("comeback",self,param_01,undefined,param_02);
	thread maps\mp\_matchdata::func_5E96(param_00,"comeback");
}

//Function Number: 130
func_83CD(param_00)
{
	maps\mp\_utility::func_50EA("semtex_stick",1);
	level thread maps\mp\gametypes\_rank::func_1457("semtex_stick",self);
	param_00 maps\mp\_utility::func_50EA("stuck_with_explosive",1);
	level thread maps\mp\gametypes\_rank::func_1457("stuck_with_explosive",param_00);
	maps\mp\gametypes\_missions::func_7750("ch_humiliation_stuck");
	self notify("increment_stuck_kills");
}

//Function Number: 131
func_285D(param_00)
{
	maps\mp\_utility::func_50EA("crossbow_stick",1);
	level thread maps\mp\gametypes\_rank::func_1457("crossbow_stick",self);
	param_00 maps\mp\_utility::func_50EA("stuck_with_explosive",1);
	level thread maps\mp\gametypes\_rank::func_1457("stuck_with_explosive",param_00);
	maps\mp\gametypes\_missions::func_7750("ch_humiliation_stuck");
	self notify("increment_stuck_kills");
}

//Function Number: 132
func_2FC1()
{
	var_00 = self.var_48CA;
	for(var_01 = 0;var_01 < level.var_744A.size;var_01++)
	{
		if(isdefined(level.var_744A[var_01].var_5A42[var_00]))
		{
			level.var_744A[var_01].var_5A42[var_00] = undefined;
		}

		if(isdefined(level.var_744A[var_01].var_5A43[var_00]))
		{
			level.var_744A[var_01].var_5A43[var_00] = undefined;
		}

		if(isdefined(level.var_744A[var_01].var_5A3C[var_00]))
		{
			level.var_744A[var_01].var_5A3C[var_00] = undefined;
		}
	}
}

//Function Number: 133
func_A159(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	self endon("disconnect");
	level endon("game_ended");
	self notify("updateRecentKills");
	self endon("updateRecentKills");
	self.var_7AD2++;
	var_02 = 0;
	if(self playerads() >= 0.2)
	{
		var_02 = 1;
	}

	wait(4);
	if(self.var_7AD2 > 1)
	{
		func_6512(param_00,self.var_7AD2,param_01,var_02);
	}

	self.var_7AD2 = 0;
	self.var_62C3 = 0;
	self.var_3D1D = 0;
	self.recentkills = [];
}

//Function Number: 134
func_4D4F(param_00)
{
	maps\mp\_utility::func_50EA("hijacker",1);
	level thread maps\mp\gametypes\_rank::func_1457("hijacker",self);
	thread maps\mp\gametypes\_missions::func_4032("hijacker_airdrop");
	thread maps\mp\gametypes\_missions::func_7750("ch_streak_thief");
	if(isdefined(param_00))
	{
		param_00 maps\mp\gametypes\_hud_message::func_73C2("hijacked_airdrop",self);
	}
}

//Function Number: 135
func_8AD6()
{
	maps\mp\_utility::func_50EA("sharepackage",1);
	level thread maps\mp\gametypes\_rank::func_1457("sharepackage",self);
}

//Function Number: 136
func_5A79()
{
	maps\mp\_utility::func_50EA("killstreak_tag",1);
	level thread maps\mp\gametypes\_rank::func_1457("killstreak_tag",self);
}

//Function Number: 137
func_5A6A()
{
	var_00 = gettime();
	var_01 = self.var_5B87 + 10000;
	if(var_01 > var_00)
	{
		return;
	}

	self.var_5B87 = var_00;
	maps\mp\_utility::func_50EA("killstreak_join",1);
	level thread maps\mp\gametypes\_rank::func_1457("killstreak_join",self);
}

//Function Number: 138
func_21EF(param_00)
{
	if(!isdefined(self.var_118F))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = self;
	}

	var_01 = self.var_117;
	if(!isdefined(var_01))
	{
		var_01 = self;
	}

	foreach(var_03 in self.var_118F)
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

		if(var_03.var_1A7 == self.var_1A7)
		{
			continue;
		}

		var_03 maps\mp\_utility::func_50EA("assist_killstreak_destroyed",1);
		level thread maps\mp\gametypes\_rank::func_1457("assist_killstreak_destroyed",var_03);
	}
}

//Function Number: 139
func_21E6(param_00)
{
	var_01 = self.var_E4 + 1;
	if(var_01 % 5 && var_01 < 30)
	{
		return;
	}

	switch(var_01)
	{
		case 5:
			level thread maps\mp\gametypes\_rank::func_1457("killstreak5",self);
			maps\mp\_utility::func_50EA("killstreak5",1);
			maps\mp\gametypes\_missions::func_7750("ch_killer_blood");
			if(isdefined(self.var_20A9) && isdefined(self.var_20A9["ch_limited_bloodshed"]) && self.var_20A9["ch_limited_bloodshed"] == 1)
			{
				maps\mp\gametypes\_missions::func_7750("ch_limited_bloodshed",5);
			}
			break;

		case 7:
			maps\mp\_utility::func_863E(17,self.var_1A7,self getentitynumber(),7);
			break;

		case 10:
			level thread maps\mp\gametypes\_rank::func_1457("killstreak10",self);
			maps\mp\_utility::func_50EA("killstreak10",1);
			maps\mp\gametypes\_missions::func_7750("ch_killer_merciless");
			maps\mp\gametypes\_missions::func_7750("ch_" + level.var_3FDC + "_merciless");
			if(isdefined(self.var_20A9) && isdefined(self.var_20A9["ch_limited_bloodshed"]) && self.var_20A9["ch_limited_bloodshed"] == 2)
			{
				maps\mp\gametypes\_missions::func_7750("ch_limited_bloodshed",5);
			}
	
			if(isdefined(self.var_5DF8) && self.var_5DF8.var_48CA == 0 && isdefined(self.var_5DF5) && self.var_5DF5.var_48CA == 0)
			{
				maps\mp\gametypes\_missions::func_7750("ch_precision_wetwork");
			}
			break;

		case 15:
			level thread maps\mp\gametypes\_rank::func_1457("killstreak15",self);
			maps\mp\_utility::func_50EA("killstreak15",1);
			maps\mp\gametypes\_missions::func_7750("ch_killer_ruthless");
			if(isdefined(self.var_20A9) && isdefined(self.var_20A9["ch_limited_bloodshed"]) && self.var_20A9["ch_limited_bloodshed"] == 3)
			{
				maps\mp\gametypes\_missions::func_7750("ch_limited_bloodshed",5);
			}
			break;

		case 20:
			level thread maps\mp\gametypes\_rank::func_1457("killstreak20",self);
			maps\mp\_utility::func_50EA("killstreak20",1);
			if(isdefined(self.var_20A9) && isdefined(self.var_20A9["ch_limited_bloodshed"]) && self.var_20A9["ch_limited_bloodshed"] == 4)
			{
				maps\mp\gametypes\_missions::func_7750("ch_limited_bloodshed",5);
			}
			break;

		case 25:
			level thread maps\mp\gametypes\_rank::func_1457("killstreak25",self);
			maps\mp\_utility::func_50EA("killstreak25",1);
			if(isdefined(self.var_20A9) && isdefined(self.var_20A9["ch_limited_bloodshed"]) && self.var_20A9["ch_limited_bloodshed"] == 5)
			{
				maps\mp\gametypes\_missions::func_7750("ch_limited_bloodshed",5);
			}
			break;

		case 30:
			level thread maps\mp\gametypes\_rank::func_1457("killstreak30",self);
			maps\mp\_utility::func_50EA("killstreak30",1);
			if(isdefined(self.var_20A9) && isdefined(self.var_20A9["ch_limited_bloodshed"]) && self.var_20A9["ch_limited_bloodshed"] == 6)
			{
				maps\mp\gametypes\_missions::func_7750("ch_limited_bloodshed",5);
			}
			break;

		default:
			level thread maps\mp\gametypes\_rank::func_1457("killstreak30plus",self);
			maps\mp\_utility::func_50EA("killstreak30plus",1);
			break;
	}

	thread maps\mp\_utility::func_9863("callout_kill_streaking",self,undefined,var_01);
}

//Function Number: 140
func_21C4(param_00)
{
	if(maps\mp\_utility::func_46E3() < 90000)
	{
		return;
	}

	var_01 = level.var_744A;
	if(level.var_984D)
	{
		var_01 = level.var_9859[maps\mp\_utility::func_45DE(self.var_1A7)];
	}

	if(!isdefined(var_01) || var_01.size < 3)
	{
		return;
	}

	var_02 = common_scripts\utility::func_FA5(var_01,::func_5601);
	if(isdefined(var_02[0]) && param_00 == var_02[0])
	{
		maps\mp\_utility::func_50EA("firstplacekill",1);
		level thread maps\mp\gametypes\_rank::func_1457("firstplacekill",self);
		maps\mp\gametypes\_missions::func_7750("ch_humiliation_highvalue");
		return 1;
	}
}

//Function Number: 141
func_5601(param_00,param_01)
{
	return param_00.var_15C > param_01.var_15C;
}

//Function Number: 142
func_774E(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.var_10EB) && level.var_10EB)
	{
		return;
	}

	var_04 = "assist_low";
	if(isdefined(param_01))
	{
		var_04 = param_01;
	}

	self endon("disconnect");
	param_00 endon("disconnect");
	wait 0.05;
	if(self.var_1A7 != "axis" && self.var_1A7 != "allies")
	{
		return;
	}

	if(self.var_1A7 == param_00.var_1A7)
	{
		return;
	}

	level thread maps\mp\gametypes\_rank::func_1457(var_04,self,param_02,param_00);
	if(var_04 == "assist_low" || var_04 == "assist_mid" || var_04 == "assist_high" || var_04 == "assist_steal" || var_04 == "assist_tactical" || var_04 == "assist_painted" || var_04 == "assist_painted_expeditionary" || var_04 == "assist_riot_shield")
	{
		lib_0468::ae_sendassistevent(var_04);
		if(isdefined(level.var_80A8) && level.var_80A8 == 1)
		{
			return;
		}

		maps\mp\_utility::func_50EA("assists",1);
		maps\mp\_utility::func_50E9("assists",1);
		self.var_21 = maps\mp\_utility::func_4607("assists");
		if(isdefined(param_03))
		{
			foreach(var_06 in param_03)
			{
				var_07 = maps\mp\_utility::func_4431(var_06,1);
				if(maps\mp\_utility::func_5856(var_07))
				{
					var_07 = maps\mp\gametypes\_class::func_4432(var_07);
				}

				maps\mp\gametypes\_gamelogic::func_8A67(var_07,1,"assists");
			}
		}

		if(var_04 != "assist_riot_shield" && maps\mp\_utility::func_649("specialty_extraobjectivescore"))
		{
			if(!isdefined(self.var_12C["extraObjectiveScoreAssists"]))
			{
				self.var_12C["extraObjectiveScoreAssists"] = 0;
			}

			self.var_12C["extraObjectiveScoreAssists"] = self.var_12C["extraObjectiveScoreAssists"] + 1;
			if(self.var_12C["extraObjectiveScoreAssists"] % 2 == 0)
			{
				level thread maps\mp\gametypes\_rank::func_1457("assist_cavalry",self,param_02,param_00);
			}
		}

		maps\mp\gametypes\_persistence::func_933A("round","assists",self.var_21);
		thread maps\mp\gametypes\_missions::func_73B5();
		if(level.var_7616)
		{
			thread func_7617(param_00);
		}

		if(maps\mp\_utility::func_649("specialty_class_espionage"))
		{
			thread maps\mp\gametypes\_missions::func_7750("ch_operations_espionage");
		}
	}
}

//Function Number: 143
func_7751(param_00,param_01,param_02)
{
	if(isdefined(level.var_10EB) && level.var_10EB)
	{
		return;
	}

	var_03 = "crossfire_low";
	if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	self endon("disconnect");
	param_00 endon("disconnect");
	wait 0.05;
	level thread maps\mp\gametypes\_rank::func_1457(var_03,self,param_02,param_00);
	if(var_03 != "crossfire_riot_shield" && maps\mp\_utility::func_649("specialty_extraobjectivescore"))
	{
		if(!isdefined(self.var_12C["extraObjectiveScoreCrossfires"]))
		{
			self.var_12C["extraObjectiveScoreCrossfires"] = 0;
		}

		self.var_12C["extraObjectiveScoreCrossfires"] = self.var_12C["extraObjectiveScoreCrossfires"] + 1;
		if(self.var_12C["extraObjectiveScoreCrossfires"] % 2 == 0)
		{
			level thread maps\mp\gametypes\_rank::func_1457("crossfire_cavalry",self,param_02,param_00);
		}
	}

	lib_0468::ae_sendassistevent();
	if(isdefined(level.var_80A8) && level.var_80A8 == 1)
	{
		return;
	}

	maps\mp\_utility::func_50EA("assists",1);
	maps\mp\_utility::func_50E9("assists",1);
	self.var_21 = maps\mp\_utility::func_4607("assists");
	maps\mp\gametypes\_persistence::func_933A("round","assists",self.var_21);
}

//Function Number: 144
func_5A27(param_00)
{
	maps\mp\gametypes\_missions::func_7750("ch_exomech_evasive");
	if(isdefined(param_00))
	{
		var_01 = maps\mp\_utility::func_4431(param_00,1);
		if(maps\mp\_utility::func_5856(var_01))
		{
			var_01 = maps\mp\gametypes\_class::func_4432(var_01);
		}

		var_02 = maps\mp\gametypes\_missions::func_40EE(param_00,var_01);
		if(var_02 == "weapon_assault" || var_02 == "weapon_pistol" || var_02 == "weapon_special")
		{
			if(issubstr(var_01,"dlcgun") && var_02 == "weapon_assault" || var_02 == "weapon_special")
			{
				maps\mp\gametypes\_missions::func_7750("ch_tier2_3_" + var_01);
				return;
			}

			maps\mp\gametypes\_missions::func_7750("ch_dodge_" + var_01);
			return;
		}
	}
}

//Function Number: 145
func_1EC2(param_00,param_01)
{
	var_02 = maps\mp\_utility::func_4431(param_00,1);
	if(maps\mp\_utility::func_5856(var_02))
	{
		var_02 = maps\mp\gametypes\_class::func_4432(var_02);
	}

	var_03 = maps\mp\gametypes\_missions::func_40EE(param_00,var_02);
	switch(var_03)
	{
		case "weapon_pistol":
		case "weapon_special":
		case "weapon_shotgun":
		case "weapon_smg":
			if(issubstr(var_02,"dlcgun") && var_03 == "weapon_special")
			{
				maps\mp\gametypes\_missions::func_7750("ch_tier2_1_" + var_02);
			}
			else
			{
				maps\mp\gametypes\_missions::func_7750("ch_slide_" + var_02);
			}
			break;
	}
}

//Function Number: 146
iskillevent(param_00)
{
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "attack_dogs_kill":
			case "division_commando_kill":
			case "division_grenadier_kill":
			case "kill":
			case "mg_nest_kill":
			case "v2_rocket_kill":
			case "airdrop_kill":
			case "tac_insert_kill":
			case "division_artillery_kill":
			case "division_scout_kill":
			case "division_resistance_kill":
			case "divisions_cavalry_kill":
			case "divisions_mountain_kill":
			case "divisions_armored_kill":
			case "divisions_airborne_kill":
			case "divisions_infantry_kill":
			case "paratroopers_kill":
			case "missile_strike_kill":
			case "mortar_strike_kill":
			case "flamethrower_kill":
			case "molotovs_kill":
			case "plane_gunner_kill":
			case "airstrike_kill":
			case "firebomb_kill":
			case "fritzx_kill":
			case "fighter_strike_kill":
				return 1;
		}
	}

	return 0;
}