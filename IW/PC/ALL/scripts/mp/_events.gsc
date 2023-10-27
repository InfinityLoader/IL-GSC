/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_events.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 1379 ms
 * Timestamp: 10/27/2023 12:20:15 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = [];
	var_00["dm"] = 4;
	var_00["war"] = 5;
	var_00["sd"] = 6;
	var_00["dom"] = 7;
	var_00["conf"] = 8;
	var_00["sr"] = 9;
	var_00["grind"] = 10;
	var_00["ball"] = 11;
	var_00["infect"] = 12;
	var_00["aliens"] = 13;
	var_00["gun"] = 14;
	var_00["grnd"] = 15;
	var_00["siege"] = 16;
	var_00["koth"] = 17;
	var_00["mp_zomb"] = 18;
	var_00["ctf"] = 19;
	var_00["dd"] = 20;
	var_00["tdef"] = 21;
	var_00["front"] = 22;
	var_01 = level.gametype;
	if(!isdefined(var_01))
	{
		var_01 = getdvar("g_gametype");
	}

	var_02 = 0;
	for(;;)
	{
		var_03 = tablelookupbyrow("mp/score_event_table.csv",var_02,0);
		if(!isdefined(var_03) || var_03 == "")
		{
			break;
		}

		var_04 = tablelookupbyrow("mp/score_event_table.csv",var_02,var_00[var_01]);
		if(!isdefined(var_04) || var_04 == "")
		{
			var_02++;
			continue;
		}

		if(var_03 == "win" || var_03 == "loss" || var_03 == "tie")
		{
			var_04 = float(var_04);
		}
		else
		{
			var_04 = int(var_04);
		}

		if(var_04 != -1)
		{
			scripts\mp\_rank::func_DF0A(var_03,"value",var_04);
		}

		var_05 = tablelookuprownum("mp/score_event_table.csv",0,var_03);
		scripts\mp\_rank::func_DF0A(var_03,"eventID",var_05);
		var_05 = tablelookupbyrow("mp/score_event_table.csv",var_02,1);
		scripts\mp\_rank::func_DF0A(var_03,"text",var_05);
		var_06 = tablelookuprownum("mp/splashTable.csv",0,var_03);
		if(isdefined(var_06) && var_06 != -1)
		{
			scripts\mp\_rank::func_DF0A(var_03,"splashID",var_06);
		}

		var_07 = tablelookupbyrow("mp/score_event_table.csv",var_02,3);
		scripts\mp\_rank::func_DF0A(var_03,"group",var_07);
		var_08 = tablelookupbyrow("mp/score_event_table.csv",var_02,2);
		if(isdefined(var_08) && tolower(var_08) == "true")
		{
			scripts\mp\_rank::func_DF0A(var_03,"allowBonus",1);
		}

		var_02++;
	}

	level._effect["money"] = loadfx("vfx/props/cash_player_drop");
	level.var_C234 = 0;
	level thread func_C56E();
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_A653 = [];
		var_00.var_A64E = [];
		var_00.var_A9A3 = undefined;
		var_00.var_8549 = 0;
		var_00.var_DDC2 = 0;
		var_00.var_DDC1 = 0;
		var_00.lastkilltime = 0;
		var_00.var_A9A2 = 0;
		var_00.var_4D44 = [];
		var_00 thread func_B9C5();
		var_00 thread func_B9DF();
		var_00 thread events_monitorslide();
	}
}

//Function Number: 3
func_4D43(param_00,param_01,param_02)
{
	if(param_01 < 50 && param_01 > 10)
	{
		thread scripts\mp\_utility::func_83B4("damage",param_02);
		level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_damaged_light",undefined,0.1);
		return;
	}

	thread scripts\mp\_utility::func_83B4("heavy_damage",param_02);
	level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_damaged_heavy",undefined,0.1);
}

//Function Number: 4
func_A652(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("killedPlayerNotify");
	self endon("killedPlayerNotify");
	if(!isdefined(self.var_A67A))
	{
		self.var_A67A = 0;
	}

	self.var_A67A++;
	if(param_03 == "MOD_PISTOL_BULLET" || param_03 == "MOD_RIFLE_BULLET" || param_03 == "MOD_HEAD_SHOT")
	{
		if(!isdefined(self.var_3247))
		{
			self.var_3247 = 1;
		}
		else
		{
			self.var_3247++;
			if(self.var_3247 >= 2)
			{
				if(scripts\mp\_utility::_hasperk("passive_collat_streak"))
				{
					var_04 = scripts\mp\perks\_weaponpassives::func_804E("passive_collat_streak");
					self [[ var_04 ]]();
				}
			}

			if(self.var_3247 == 2)
			{
				level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_killfirm_twofer",undefined,0.75);
				thread scripts\mp\_awards::func_8380("one_shot_two_kills");
				thread scripts\mp\_missions::func_D995();
				var_05 = getweaponbasename(param_02);
				if(var_05 == "iw7_penetrationrail_mp")
				{
					thread scripts\mp\_missions::func_D991("ch_sniper_ballista_collateral");
				}
			}

			if(self.var_3247 == 3)
			{
				level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_killfirm_threefer",undefined,0.75);
			}
		}
	}

	waittillframeend;
	thread func_C165(param_00,param_01,param_02,param_03,self.var_A67A);
	self.var_A67A = 0;
	self.var_3247 = 0;
}

//Function Number: 5
func_C165(param_00,param_01,param_02,param_03,param_04)
{
	for(var_05 = 0;var_05 < param_04;var_05++)
	{
		self notify("got_a_kill",param_01,param_02,param_03);
		wait(0.05);
	}
}

//Function Number: 6
func_A651(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_01.var_86BD;
	var_07 = self.var_86BD;
	var_08 = gettime();
	thread func_A652(param_00,param_01,param_02,param_03);
	thread func_12EFE(param_00,param_01,param_02);
	thread func_12EF8(self);
	self.lastkilltime = gettime();
	self.var_A9A4 = param_01;
	if(self.var_E9 > 0)
	{
		var_09 = self.var_1AB / self.var_E9;
		if(var_09 > 3)
		{
			level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_kd_high",undefined,0.75);
		}
	}
	else if(self.var_1AB > 5)
	{
		level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_kd_high",undefined,0.75);
	}

	self.var_B930 = [];
	level.var_C234++;
	self.var_4D44[var_06] = undefined;
	func_3E24(param_02,param_03);
	var_0A = scripts\mp\_utility::func_8225(param_02);
	var_0B = scripts\mp\_utility::func_8234(param_02);
	if(!scripts\mp\_utility::func_9E6C(param_02) && !scripts\mp\_utility::func_9E59() && !scripts\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		if(param_02 == "none")
		{
			return 0;
		}

		if(var_0A == "weapon_sniper" && param_03 != "MOD_MELEE" && gettime() == param_01.var_24E5[self.var_86BD].var_6DEF && !issubstr(param_02,"iw7_longshot_mp") && scripts\mp\_weapons::func_9D3E(param_02))
		{
			if(!isdefined(self.pers["oneShotKills"]))
			{
				self.pers["oneShotKills"] = 1;
			}
			else
			{
				self.pers["oneShotKills"]++;
			}

			self.var_B930["oneshotkill"] = 1;
			thread scripts\mp\_awards::func_8380("one_shot_kill");
		}

		if(var_0A == "weapon_shotgun" && param_03 != "MOD_MELEE" && gettime() == param_01.var_24E5[self.var_86BD].var_6DEF)
		{
			self.var_B930["oneshotkill_shotgun"] = 1;
		}

		if(param_03 == "MOD_MELEE" && param_02 != "iw7_reaperblade_mp")
		{
			if(var_0A != "weapon_melee")
			{
				thread scripts\mp\_awards::func_8380("gun_butt");
			}

			if(var_0B == "iw7_fists")
			{
				thread scripts\mp\_awards::func_8380("fist_kill");
			}
		}

		var_0C = param_01 method_854D();
		if(var_0C == "frag_grenade_mp" || var_0C == "cluster_grenade_mp")
		{
			self.var_B930["cooking"] = 1;
		}

		if(isdefined(self.var_23E8) && self.var_23E8)
		{
			func_23E8(param_00,param_02,param_03,param_01);
		}

		if(level.var_C234 == 1)
		{
			func_6DE1(param_00,param_02,param_03,param_01);
			if(level.gametype == "sd")
			{
				scripts\mp\_utility::func_F79E(21,self.team,self getentitynumber());
			}
		}

		if(self.pers["cur_death_streak"] > 3)
		{
			func_4417(param_00,param_02,param_03,param_01);
		}

		if(param_03 == "MOD_HEAD_SHOT")
		{
			level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_killfirm_headshot",undefined,0.75);
			func_8C9B(param_00,param_02,param_03,param_01);
		}

		if(isdefined(self.var_1391E) && self.var_1391E && gettime() - self.var_10916 <= 5000)
		{
			self.var_B930["jackintheboxkill"] = 1;
		}

		if(!scripts\mp\_utility::func_9F19(self) && isdefined(self.var_4E72))
		{
			var_0D = gettime() - self.var_4E72;
			if(var_0D < 1500 && var_0D > 0)
			{
				func_D6F7(param_00,param_01,param_02);
			}

			if(scripts\mp\_utility::issimultaneouskillenabled())
			{
				if(var_0D == 0 && isdefined(self.var_1B1) && self.var_1B1 == param_01)
				{
					thread scripts\mp\_awards::func_8380("simultaneous_kill",undefined,undefined,1);
					param_01 thread scripts\mp\_awards::func_8380("simultaneous_kill",undefined,undefined,1);
					thread events_playertracksimultaneouskill();
					param_01 thread events_playertracksimultaneouskill();
				}
			}
		}

		if(level.teambased && var_08 - param_01.lastkilltime < 1500)
		{
			if(param_01.var_A9A4 != self)
			{
				func_26A5(param_00,param_02,param_03,param_01);
			}
		}

		foreach(var_10, var_0F in param_01.var_4D44)
		{
			if(var_10 == self.var_86BD)
			{
				continue;
			}

			if(level.teambased && var_08 - var_0F < 1750)
			{
				func_5082(param_00,param_02,param_03,param_01);
			}
		}

		if(isdefined(param_01.var_2502))
		{
			var_11 = param_01.var_2502;
		}
		else
		{
			var_11 = self.origin;
		}

		var_12 = 1;
		if(isdefined(param_05))
		{
			var_12 = param_05 == self;
		}

		if(var_12)
		{
			if(func_9F03(self,param_02,param_03,var_11,param_01))
			{
				thread func_D63F(param_00,param_02,param_03,param_01);
			}
			else if(func_9E84(self,param_02,param_03,var_11,param_01))
			{
				thread func_AFEA(param_00,param_02,param_03,param_01);
			}
		}

		if(func_9D5F(self,param_01,param_03))
		{
			if(var_0B == "iw7_knife")
			{
				thread scripts\mp\_awards::func_8380("backstab");
			}

			self.var_B930["backstab"] = 1;
		}

		if(var_12)
		{
			if(func_9F90(self))
			{
				thread func_8373("low_health_kill",param_00,param_02,param_03,param_01,"low_health_kill");
			}

			if(scripts\mp\_utility::func_9EE8())
			{
				self.var_B930["ads"] = 1;
			}
			else if(scripts\common\utility::func_9D74(param_03))
			{
				self.var_B930["hipfire"] = 1;
			}

			if(!self isonground())
			{
				self.var_B930["airborne"] = 1;
			}

			if(level.teambased)
			{
				foreach(var_14 in level.players)
				{
					if(self.team != var_14.team || self == var_14)
					{
						continue;
					}

					if(!scripts\mp\_utility::func_9F19(var_14))
					{
						continue;
					}

					if(distancesquared(self.origin,var_14.origin) < 90000)
					{
						self.var_B930["buddy_kill"] = 1;
						break;
					}
				}
			}
		}
		else if(var_0A == "weapon_projectile")
		{
			if(isdefined(param_05) && isdefined(param_05.adsfire))
			{
				if(param_05.adsfire)
				{
					self.var_B930["ads"] = 1;
				}
				else
				{
					self.var_B930["hipfire"] = 1;
				}
			}
		}

		if(!param_01 isonground() && !param_01 method_8446() && !self isonground() && !self method_8446())
		{
			if(var_12)
			{
				thread func_8373("air_to_air_kill",param_00,param_02,param_03,param_01,"air_to_air_kill");
			}
		}
		else
		{
			if(var_12)
			{
				if(self method_8446())
				{
					thread func_8373("wallkill",param_00,param_02,param_03,param_01,"wallrun_kill");
				}
				else if(func_9DB7(self,param_02,param_03,var_11,param_01))
				{
					thread func_8373("jumpkill",param_00,param_02,param_03,param_01,"air_kill");
				}
				else if(events_issliding())
				{
					thread func_8373("slidekill",param_00,param_02,param_03,param_01,"slide_kill");
					self.var_B930["sliding"] = 1;
				}

				var_16 = self getstance();
				switch(var_16)
				{
					case "prone":
						self.var_B930["prone_kill"] = 1;
						break;

					case "crouch":
						self.var_B930["crouch_kill"] = 1;
						break;
				}
			}

			if(param_01 method_8446())
			{
				thread func_8373("killonwall",param_00,param_02,param_03,param_01,"kill_wallrunner");
			}
			else if(func_9F58(self,param_02,param_03,var_11,param_01))
			{
				thread func_8373("killinair",param_00,param_02,param_03,param_01,"kill_jumper");
			}
		}

		if(var_12)
		{
			if(scripts\mp\_weapons::func_85BE())
			{
				self.var_B930["clutchkill"] = 1;
			}
		}

		if(isdefined(param_01.var_A6AB))
		{
			foreach(var_1A, var_18 in param_01.var_A6AB)
			{
				var_19 = var_1A - param_01.var_278;
				if(var_19 > 0 && var_19 < 100)
				{
					func_32FA(param_00,param_01,param_02,param_03,param_01);
				}
			}
		}

		if(var_12)
		{
			if(self ismantling())
			{
				thread scripts\mp\_awards::func_8380("mantle_kill");
			}

			if(scripts\mp\_weapons::func_9F81())
			{
				thread scripts\mp\_awards::func_8380("stunned_kill");
			}

			if(isdefined(self.var_119DF[param_02]) && self.var_119DF[param_02] == param_01)
			{
				thread scripts\mp\_awards::func_8380("backfire");
			}
		}

		if(isdefined(param_01.var_1117F))
		{
			level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_killfirm_semtex",undefined,0.75);
		}

		if(scripts\mp\_weapons::func_9FA9(param_02))
		{
			thread scripts\mp\_awards::func_8380("throwingknife_kill");
		}

		if(level.teambased)
		{
			var_1B = 0;
			foreach(var_1D in level.var_115D8[scripts\mp\_utility::getotherteam(self.team)])
			{
				if(var_1D.var_278 > 0)
				{
					var_1B = 1;
					break;
				}
			}

			if(var_1B)
			{
				var_1F = scripts\common\utility::func_22C3(level.var_115D8[scripts\mp\_utility::getotherteam(self.team)],::func_9CAE);
				if(isdefined(var_1F[0]) && param_01 == var_1F[0])
				{
					thread scripts\mp\_awards::func_8380("first_place_kill");
				}
			}
		}
		else
		{
			var_1B = 0;
			foreach(var_1D in level.players)
			{
				if(var_1D.var_278 > 0)
				{
					var_1B = 1;
					break;
				}
			}

			if(var_1B)
			{
				var_1F = scripts\common\utility::func_22C3(level.players,::func_9CAE);
				if(isdefined(var_1F[0]) && param_01 == var_1F[0])
				{
					thread scripts\mp\_awards::func_8380("first_place_kill");
					if(level.gametype == "gun" && param_03 == "MOD_MELEE")
					{
						thread scripts\mp\_awards::func_8380("mode_gun_melee_1st_place");
					}
				}
			}
		}

		var_22 = self.pers["cur_kill_streak"] + 1;
		if(!var_22 % 5)
		{
			if(!isdefined(self.var_A9A6) || var_22 != self.var_A9A6)
			{
				thread scripts\mp\_utility::func_115DE("callout_kill_streaking",self,undefined,var_22);
				self.var_A9A6 = var_22;
			}

			if(var_22 <= 30)
			{
				thread scripts\mp\_awards::func_8380("streak_" + var_22);
			}
		}
		else if(!var_22 % 7)
		{
			scripts\mp\_utility::func_F79E(17,self.team,self getentitynumber(),7);
		}

		if(var_22 > 30)
		{
			thread scripts\mp\_awards::func_8380("streak_max");
		}

		if(isdefined(param_05) && scripts\mp\_utility::func_9FB3(param_05.var_9F07) && param_03 == "MOD_IMPACT" && !scripts\mp\_weapons::func_9FA9(param_02))
		{
			thread scripts\mp\_awards::func_8380("item_impact");
		}

		if(scripts\mp\_utility::func_7ECE() >= 1)
		{
			if(param_01.pers["lives"] == 0)
			{
				thread scripts\mp\_awards::func_8380("mode_x_eliminate");
			}

			var_23 = scripts\mp\_utility::func_808A();
			if(var_23.size == 1 && var_23[0] == self)
			{
				thread scripts\mp\_awards::func_8380("mode_x_last_alive");
			}
		}

		if(param_02 == "groundpound_mp")
		{
			level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_pound",undefined,0.75);
		}

		func_3E50(param_01,param_05,param_02,param_03);
		func_3E51(param_01,param_02,param_03);
		thread func_3E27(param_00,param_01,param_02,param_03,param_04);
	}

	if(!isdefined(self.var_A653[var_06]))
	{
		self.var_A653[var_06] = 0;
	}

	if(!isdefined(param_01.var_A64E[var_07]))
	{
		param_01.var_A64E[var_07] = 0;
	}

	self.var_A653[var_06]++;
	param_01.var_A64E[var_07]++;
	param_01.var_A9A3 = self;
	scripts\mp\_utility::func_316C("kill_event_buffered",param_01,param_02,param_03,self.var_B930);
}

//Function Number: 7
func_3E24(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_9E6C(param_00);
	if(var_02)
	{
		var_03 = level.var_A6C5[param_00];
		switch(var_03)
		{
			case "sentry_shock":
				thread scripts\mp\_awards::func_8380("ss_kill_sentry_shock");
				break;

			case "ball_drone_backup":
				thread scripts\mp\_awards::func_8380("ss_kill_ball_drone_backup");
				break;

			case "drone_hive":
				thread scripts\mp\_awards::func_8380("ss_kill_trinity");
				break;

			case "precision_airstrike":
				thread scripts\mp\_awards::func_8380("ss_kill_precision_airstrike");
				break;

			case "minijackal":
				thread scripts\mp\_awards::func_8380("ss_kill_minijackal");
				break;

			case "thor":
				thread scripts\mp\_awards::func_8380("ss_kill_thor");
				break;

			case "bombardment":
				thread scripts\mp\_awards::func_8380("ss_kill_bombardment");
				break;

			case "remote_c8":
				thread scripts\mp\_awards::func_8380("ss_kill_remote_c8");
				break;

			case "venom":
				thread scripts\mp\_awards::func_8380("ss_kill_venom");
				break;

			case "jackal":
				thread scripts\mp\_awards::func_8380("ss_kill_jackal");
				break;

			default:
				thread scripts\mp\_utility::func_83B4("killstreak_full_score",param_00);
				break;
		}

		level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_killfirm_killstreak",undefined,0.75);
	}
}

//Function Number: 8
func_3E50(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_supers::func_9F88();
	var_05 = scripts\mp\_supers::func_7E4F();
	var_06 = scripts\mp\_supers::func_7E4E();
	var_07 = scripts\mp\_utility::func_9F8D(param_02);
	var_08 = undefined;
	if(!isdefined(var_05))
	{
		return;
	}

	if(var_07 && param_02 != "iw7_reaperblade_mp")
	{
		thread func_A655(param_00,param_01,param_02,param_03);
		if(param_03 != "MOD_MELEE")
		{
			scripts\mp\_utility::func_316C("super_kill_buffered");
		}

		var_09 = getweaponbasename(param_02);
		if(var_09 == "iw7_claw_mp")
		{
			var_08 = "super_claw_kill";
			level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_super",undefined,0.75);
		}
		else if(var_09 == "iw7_atomizer_mp")
		{
			var_08 = "super_eraser_kill";
			level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_super",undefined,0.75);
		}
		else if(var_09 == "iw7_blackholegun_mp")
		{
			var_08 = "super_blackholegun_kill";
			level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_super_kill",undefined,0.75);
		}
		else if(var_09 == "iw7_penetrationrail_mp")
		{
			var_08 = "super_railgun_kill";
			level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_railgun",undefined,0.75);
		}
		else if(var_09 == "iw7_steeldragon_mp")
		{
			var_08 = "super_steeldragon_kill";
			level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_dragon",undefined,0.75);
		}
		else if(var_09 == "iw7_armmgs_mp")
		{
			var_08 = "super_arm2_kill";
		}

		if(isdefined(var_08))
		{
			thread scripts\mp\_utility::func_83B4(var_08);
		}
	}

	var_0A = 0;
	if(isdefined(var_05))
	{
		switch(var_05)
		{
			case "super_amplify":
				if(var_04 == 1)
				{
					var_08 = "super_combatfocus_kill";
					var_0A = 1;
				}
				break;

			case "super_overdrive":
				if(var_04 == 1)
				{
					var_08 = "super_overdrive_kill";
					var_0A = 1;
				}
				break;

			case "super_chargemode":
				if(var_04 == 1)
				{
					var_08 = "super_bullcharge_kill";
					level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_charge",undefined,0.75);
					var_0A = 1;
				}
				break;

			case "super_armorup":
				if(var_04 == 1)
				{
					var_08 = "super_armorup_kill";
					level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_armor",undefined,0.75);
					var_0A = 1;
				}
				break;

			case "super_reaper":
				if(var_04 == 1)
				{
					var_08 = "super_reaper_kill";
					level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_reaper",undefined,0.75);
					var_0A = 1;
				}
				break;

			case "super_rewind":
				if(var_04 == 1 || isdefined(var_06.var_A986) && gettime() < var_06.var_A986 + 3000)
				{
					var_08 = "super_rewind_kill";
					var_0A = 1;
				}
				break;

			case "super_phaseshift":
				if(var_04 == 1 || isdefined(var_06.var_A986) && gettime() < var_06.var_A986 + 3000)
				{
					var_08 = "super_phaseshift_kill";
					level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_killfirm_shift",undefined,0.75);
					var_0A = 1;
				}
				break;

			case "super_teleport":
				if(var_04 == 1 || isdefined(var_06.var_A986) && gettime() < var_06.var_A986 + 3000)
				{
					var_08 = "super_teleport_kill";
					var_0A = 1;
				}
				break;

			case "super_microturret":
				if(param_02 == "micro_turret_gun_mp")
				{
					var_08 = "super_microturret_kill";
					level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_turret_kill",undefined,0.75);
					var_0A = 1;
				}
				break;

			case "super_invisible":
				if(var_04 == 1 || isdefined(var_06.var_A986) && gettime() < var_06.var_A986 + 2000)
				{
					var_08 = "super_invisible_kill";
					level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_perk_stealth",undefined,0.75);
					var_0A = 1;
				}
				break;

			case "super_visionpulse":
				if(lib_0E1B::func_9EF9(param_00))
				{
					var_08 = "super_wallhack_kill";
					var_0A = 1;
				}
				break;

			case "super_kineticpulse":
				if(lib_0DED::isplayertaggedbykineticpulse(param_00))
				{
					var_08 = "super_kineticpulse_kill";
					var_0A = 1;
				}
				break;

			default:
				break;
		}

		if(var_0A)
		{
			thread func_11262(var_05,param_03);
			scripts\mp\_supers::combatrecordsuperkill(var_05);
			if(isdefined(var_08))
			{
				thread scripts\mp\_utility::func_83B4(var_08);
			}

			scripts\mp\_utility::func_316C("super_kill_buffered");
		}
	}
}

//Function Number: 9
func_3E51(param_00,param_01,param_02)
{
	var_03 = param_00 scripts\mp\_supers::func_9F88();
	var_04 = param_00 scripts\mp\_supers::func_7E4F();
	var_05 = param_00 scripts\mp\_supers::func_7E4E();
	if(!isdefined(var_04))
	{
		return;
	}

	switch(var_04)
	{
		case "super_armorup":
			if(var_03 == 1 || isdefined(var_05.var_A986) && gettime() - var_05.var_A986 < 1000)
			{
				if(isdefined(param_00.var_219F) && scripts\common\utility::func_2286(param_00.var_219F,self))
				{
					thread func_11265(param_00);
				}
			}
			break;

		case "super_visionpulse":
			if(param_00 lib_0E1B::func_9EF9(self))
			{
				thread func_11265(param_00);
			}
			break;

		case "super_phaseshift":
			if(var_03 == 1 || isdefined(var_05.var_A986) && gettime() - var_05.var_A986 < 2000)
			{
				thread func_11265(param_00);
			}
			break;

		case "super_teleport":
			if(var_03 == 1 || isdefined(var_05.var_A986) && gettime() - var_05.var_A986 < 2000)
			{
				thread func_11265(param_00);
			}
			break;

		case "super_invisible":
			if(var_03 == 1 || isdefined(var_05.var_A986) && gettime() - var_05.var_A986 < 2000)
			{
				thread func_11265(param_00);
			}
			break;

		case "super_kineticpulse":
			if(param_00 lib_0DED::isplayertaggedbykineticpulse(self))
			{
				thread func_11265(param_00);
			}
			break;

		case "super_rewind":
			if(var_03 == 1 || isdefined(var_05.var_A986) && gettime() - var_05.var_A986 < 2000)
			{
				thread func_11265(param_00);
			}
			break;

		default:
			if(var_03 == 1)
			{
				thread func_11265(param_00);
			}
			break;
	}
}

//Function Number: 10
func_A655(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_supers::func_8189(param_02);
	var_05 = self.var_DDC3[param_02];
	if(isdefined(var_05) && var_05 > 0 && var_05 % 2 == 0)
	{
		func_11262(var_04,param_03);
	}
	else
	{
		var_06 = scripts\mp\_supers::func_7E4E();
		var_06.var_C234++;
	}

	scripts\mp\_missions::func_12F33(param_02,param_01);
	scripts\mp\_supers::combatrecordsuperkill(var_04);
}

//Function Number: 11
func_11262(param_00,param_01)
{
	var_02 = scripts\mp\_supers::func_80F6(param_00);
	var_03 = "super_kill_" + var_02;
	switch(var_03)
	{
		case "super_kill_chargemode":
			var_03 = "super_kill_bull_charge";
			break;
	}

	if(isdefined(level.var_26D8[var_03]))
	{
		thread scripts\mp\_awards::func_8380(var_03);
	}

	var_04 = scripts\mp\_supers::func_7E4E();
	var_04.var_C234++;
	scripts\mp\_missions::updatesuperkills(param_00,param_01,var_04.var_C234);
	self.var_B930["super_kill_medal"] = param_00;
}

//Function Number: 12
func_A650(param_00,param_01)
{
	if(param_00 != "precision_airstrike")
	{
		var_02 = "kill_ss_" + param_00;
		param_01 thread scripts\mp\_awards::func_8380(var_02);
	}

	param_01.var_A6B4[param_01.var_A6B4.size] = param_00;
	level thread scripts\mp\_battlechatter_mp::func_EB87(param_01,"plr_killstreak_destroy",undefined,0.75);
}

//Function Number: 13
func_9CAE(param_00,param_01)
{
	return param_00.var_278 > param_01.var_278;
}

//Function Number: 14
func_9E84(param_00,param_01,param_02,param_03,param_04)
{
	if(isalive(param_00) && !param_00 scripts\mp\_utility::func_9FC6() && param_02 == "MOD_RIFLE_BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_HEAD_SHOT" && !scripts\mp\_utility::func_9E6C(param_01) && !isdefined(param_00.var_23E8))
	{
		var_05 = scripts\mp\_utility::func_8225(param_01);
		switch(var_05)
		{
			case "weapon_pistol":
				var_06 = 800;
				break;

			case "weapon_beam":
			case "weapon_smg":
				var_06 = 1200;
				break;

			case "weapon_lmg":
			case "weapon_dmr":
			case "weapon_assault":
				var_06 = 1500;
				break;

			case "weapon_rail":
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
			return 1;
		}
	}

	return 0;
}

//Function Number: 15
func_9F03(param_00,param_01,param_02,param_03,param_04)
{
	if(isalive(param_00) && !param_00 scripts\mp\_utility::func_9FC6() && param_02 == "MOD_RIFLE_BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_HEAD_SHOT" && !scripts\mp\_utility::func_9E6C(param_01) && !isdefined(param_00.var_23E8))
	{
		var_05 = 9216;
		if(distancesquared(param_03,param_04.origin) < var_05)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 16
func_9DB7(param_00,param_01,param_02,param_03,param_04)
{
	if(isalive(param_00) && param_00 isjumping() && scripts\common\utility::func_9D74(param_02))
	{
		var_05 = param_00.origin[2] - param_04.origin[2];
		return var_05 > 60;
	}

	return 0;
}

//Function Number: 17
func_9F58(param_00,param_01,param_02,param_03,param_04)
{
	return isalive(param_00) && param_04 isjumping() && scripts\common\utility::func_9D74(param_02);
}

//Function Number: 18
func_9D5F(param_00,param_01,param_02)
{
	if(!isplayer(param_00) || !isplayer(param_01))
	{
		return 0;
	}

	if(param_02 != "MOD_RIFLE_BULLET" && param_02 != "MOD_PISTOL_BULLET" && param_02 != "MOD_MELEE" && param_02 != "MOD_HEAD_SHOT")
	{
		return 0;
	}

	var_03 = param_01 getplayerangles();
	var_04 = param_00 getplayerangles();
	var_05 = angleclamp180(var_03[1] - var_04[1]);
	if(abs(var_05) < 80)
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
func_9F90(param_00)
{
	return param_00.health > 0 && param_00.health < param_00.maxhealth * 0.2;
}

//Function Number: 20
func_3E27(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(self.var_A9A3) && self.var_A9A3 == param_01)
	{
		self.var_A9A3 = undefined;
		func_E48D(param_00,param_02);
	}
}

//Function Number: 21
func_8373(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self.var_B930[param_00] = 1;
	if(isdefined(param_05))
	{
		thread scripts\mp\_awards::func_8380(param_05);
		return;
	}

	thread scripts\mp\_utility::func_83B4(param_00,param_02);
}

//Function Number: 22
func_DAC9(param_00)
{
	self.var_B930["proximityAssist"] = 1;
	thread scripts\mp\_utility::func_83B4("proximityassist");
}

//Function Number: 23
func_DACE(param_00)
{
	self.var_B930["proximityKill"] = 1;
	thread scripts\mp\_utility::func_83B4("proximitykill");
}

//Function Number: 24
func_AFEA(param_00,param_01,param_02,param_03)
{
	self.var_B930["longshot"] = 1;
	thread scripts\mp\_matchdata::func_AFC5(param_00,"longshot");
	thread scripts\mp\_awards::func_8380("longshot");
}

//Function Number: 25
func_D63F(param_00,param_01,param_02,param_03)
{
	self.var_B930["pointblank"] = 1;
	thread scripts\mp\_matchdata::func_AFC5(param_00,"pointblank");
	thread scripts\mp\_awards::func_8380("pointblank");
}

//Function Number: 26
func_8C9B(param_00,param_01,param_02,param_03)
{
	self.var_B930["headshot"] = 1;
	thread scripts\mp\_matchdata::func_AFC5(param_00,"headshot");
	thread scripts\mp\_awards::func_8380("headshot");
}

//Function Number: 27
func_26A5(param_00,param_01,param_02,param_03)
{
	self.var_B930["avenger"] = 1;
	thread scripts\mp\_matchdata::func_AFC5(param_00,"avenger");
	thread scripts\mp\_awards::func_8380("avenger");
}

//Function Number: 28
func_23E8(param_00,param_01,param_02,param_03)
{
	self.var_B930["assistedsuicide"] = 1;
	thread scripts\mp\_utility::func_83B4("assistedsuicide",param_01);
	thread scripts\mp\_matchdata::func_AFC5(param_00,"assistedsuicide");
	thread scripts\mp\_awards::func_8380("assistedsuicide");
}

//Function Number: 29
func_5082(param_00,param_01,param_02,param_03)
{
	self.var_B930["defender"] = 1;
	thread scripts\mp\_matchdata::func_AFC5(param_00,"defender");
	thread scripts\mp\_awards::func_8380("save_teammate");
}

//Function Number: 30
func_D6F7(param_00,param_01,param_02)
{
	self.var_B930["posthumous"] = 1;
	thread scripts\mp\_matchdata::func_AFC5(param_00,"posthumous");
	thread scripts\mp\_awards::func_8380("posthumous");
}

//Function Number: 31
func_E48D(param_00,param_01,param_02)
{
	self.var_B930["revenge"] = 1;
	thread scripts\mp\_matchdata::func_AFC5(param_00,"revenge");
	thread scripts\mp\_awards::func_8380("revenge");
}

//Function Number: 32
func_BDC2(param_00,param_01,param_02)
{
	var_03 = undefined;
	switch(param_01)
	{
		case 2:
			var_03 = "double";
			break;

		case 3:
			var_03 = "triple";
			thread scripts\mp\_utility::func_115DE("callout_3xkill",self);
			break;

		case 4:
			var_03 = "four";
			thread scripts\mp\_utility::func_115DE("callout_4xkill",self);
			scripts\mp\_utility::func_F79E(18,self.team,self getentitynumber(),4);
			break;

		case 5:
			var_03 = "five";
			thread scripts\mp\_utility::func_115DE("callout_5xkill",self);
			break;

		case 6:
			var_03 = "six";
			thread scripts\mp\_utility::func_115DE("callout_6xkill",self);
			break;

		case 7:
			var_03 = "seven";
			thread scripts\mp\_utility::func_115DE("callout_7xkill",self);
			break;

		case 8:
			var_03 = "eight";
			thread scripts\mp\_utility::func_115DE("callout_8xkill",self);
			break;

		default:
			var_03 = "multi";
			thread scripts\mp\_utility::func_115DE("callout_9xkill",self);
			break;
	}

	thread scripts\mp\_matchdata::func_AFCB(param_00,param_01);
	if(isdefined(var_03))
	{
		thread scripts\mp\_awards::func_8380(var_03);
	}
}

//Function Number: 33
func_6DE1(param_00,param_01,param_02,param_03)
{
	self.var_B930["firstblood"] = 1;
	thread scripts\mp\_matchdata::func_AFC5(param_00,"firstblood");
	thread scripts\mp\_utility::func_115DE("callout_firstblood",self);
	scripts\mp\_missions::func_D992("ch_bornready");
	thread scripts\mp\_awards::func_8380("firstblood");
}

//Function Number: 34
func_13D8C(param_00)
{
}

//Function Number: 35
//Function Number: 36
func_4417(param_00,param_01,param_02,param_03)
{
	self.var_B930["comeback"] = 1;
	thread scripts\mp\_matchdata::func_AFC5(param_00,"comeback");
	thread scripts\mp\_awards::func_8380("comeback");
}

//Function Number: 37
func_11265(param_00)
{
	var_01 = scripts\mp\_supers::func_80F6(param_00.var_11234.var_10E47.var_DE3F);
	self.var_B930["superShutdown"] = param_00.var_11234.var_10E47.var_DE3F;
	var_02 = "super_shutdown_" + var_01;
	switch(var_01)
	{
		case "chargemode":
			var_02 = "super_shutdown_bull_charge";
			break;
	}

	if(isdefined(level.var_26D8[var_02]))
	{
		thread scripts\mp\_awards::func_8380(var_02);
	}
}

//Function Number: 38
func_5638()
{
	var_00 = self.var_86BD;
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		if(isdefined(level.players[var_01].var_A653[var_00]))
		{
			level.players[var_01].var_A653[var_00] = undefined;
		}

		if(isdefined(level.players[var_01].var_A64E[var_00]))
		{
			level.players[var_01].var_A64E[var_00] = undefined;
		}
	}
}

//Function Number: 39
func_B9DF()
{
	level endon("end_game");
	self endon("disconnect");
	for(;;)
	{
		self waittill("healed");
		thread scripts\mp\_utility::func_83B4("healed");
	}
}

//Function Number: 40
func_12EFE(param_00,param_01,param_02)
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("updateRecentKills");
	self endon("updateRecentKills");
	self.var_DDC2++;
	if(scripts\mp\_missions::func_9DBA(param_01.origin))
	{
		self.var_DDC1++;
		if(scripts\mp\_missions::func_9EBC(self.var_DDC1,2))
		{
			thread scripts\mp\_awards::func_8380("mode_x_wipeout");
		}
	}

	if(!isdefined(self.var_DDC3))
	{
		self.var_DDC3 = [];
	}

	if(!isdefined(self.var_DDC3[param_02]))
	{
		self.var_DDC3[param_02] = 1;
	}
	else
	{
		self.var_DDC3[param_02]++;
	}

	var_03 = scripts\mp\_utility::func_7E9D(param_02);
	if(isdefined(var_03) && var_03 == "lethal")
	{
		level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_killfirm_grenade",undefined,0.75);
		level thread scripts\mp\_battlechatter_mp::func_EB87(self,"plr_killfirm_amf",undefined,0.75);
		if(self.var_DDC3[param_02] > 0 && self.var_DDC3[param_02] % 2 == 0)
		{
			thread scripts\mp\_awards::func_8380("grenade_double");
		}
	}

	scripts\mp\_utility::func_316C("update_rapid_kill_buffered",self.var_DDC2);
	wait(4);
	if(self.var_DDC2 > 1)
	{
		func_BDC2(param_00,self.var_DDC2,param_01);
	}

	self.var_DDC2 = 0;
	self.var_DDC1 = 0;
	self.var_DDC3 = undefined;
}

//Function Number: 41
func_B9C5()
{
	level endon("end_game");
	self endon("disconnect");
	for(;;)
	{
		self waittill("hijacker",var_00,var_01);
		thread scripts\mp\_awards::func_8380("ss_use_enemy_dronedrop");
		var_02 = "hijacked_airdrop";
		var_03 = "ch_hijacker";
		switch(var_00)
		{
			case "sentry_shock":
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
			var_01 scripts\mp\_hud_message::func_10151(var_02,undefined,self);
		}

		self notify("process",var_03);
	}
}

//Function Number: 42
func_12EF8(param_00)
{
	if(isdefined(level.var_DB50) && gettime() - level.var_DB50.var_10DFF > 5000)
	{
		level.var_DB50 = undefined;
	}

	if(!isdefined(level.var_DB50) || level.var_DB50.player != param_00)
	{
		var_01 = spawnstruct();
		var_01.player = param_00;
		var_01.var_10DFF = gettime();
		var_01.var_6BC5 = 1;
		level.var_DB50 = var_01;
		return;
	}

	var_01 = level.var_DB50;
	var_01.var_6BC5++;
	if(var_01.var_6BC5 == 4)
	{
		var_01.player thread scripts\mp\_awards::func_8380("quad_feed");
		level.var_DB50 = undefined;
	}
}

//Function Number: 43
events_monitorslide()
{
	self endon("disconnect");
	self notify("events_monitorSlide");
	self endon("events_monitorSlide");
	self.eventswassliding = self method_81BE();
	self.eventsslideendtime = undefined;
	for(;;)
	{
		events_monitorslideupdate();
		wait(0.05);
	}
}

//Function Number: 44
events_monitorslideupdate()
{
	if(scripts\mp\_utility::func_9F19(self))
	{
		var_00 = self method_81BE();
		if(self.eventswassliding && !var_00)
		{
			self.eventsslideendtime = gettime();
		}

		self.eventswassliding = var_00;
		return;
	}

	self.eventswassliding = 0;
	self.eventsslideendtime = undefined;
}

//Function Number: 45
events_issliding()
{
	if(self method_81BE())
	{
		return 1;
	}

	events_monitorslideupdate();
	if(isdefined(self.eventsslideendtime))
	{
		if(gettime() - self.eventsslideendtime <= 150)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 46
events_playertracksimultaneouskill()
{
	self endon("disconnect");
	self.simultaneouskill = 1;
	scripts\common\utility::func_136F7();
	self.simultaneouskill = undefined;
}