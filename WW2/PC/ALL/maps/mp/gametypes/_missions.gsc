/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_missions.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 102
 * Decompile Time: 1812 ms
 * Timestamp: 10/27/2023 3:24:00 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	setdvarifuninitialized("spv_challenge_mastery_completion",0);
	precachestring(&"MP_CHALLENGE_COMPLETED");
	if(!func_60B1())
	{
		return;
	}

	level.var_4B0B = ["extended_mag","grip","fast_ads","ads_move_speed","akimbo","reduced_sway"];
	level.var_35A8 = ["extended_range","rapid_fire","head_damage","suppressor","hipfire"];
	level.var_6254 = [];
	level.recentkillers = [];
	func_7BEF("playerKilled",::func_209B);
	func_7BEF("playerKilled",::func_20A3);
	func_7BEF("playerHardpoint",::func_209A);
	func_7BEF("playerAssist",::func_2091);
	func_7BEF("roundEnd",::func_209D);
	func_7BEF("roundEnd",::func_209C);
	func_7BEF("vehicleKilled",::func_20A2);
	level thread func_6B6C();
}

//Function Number: 2
func_60B1()
{
	if(maps\mp\_utility::func_761E())
	{
		return 0;
	}

	if(function_0367())
	{
		if(function_0371())
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}

	if(function_03AF())
	{
		return 0;
	}

	return level.var_7A67;
}

//Function Number: 3
func_6B6C()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(isbot(var_00))
		{
			continue;
		}

		if(!isdefined(var_00.var_12C["postGameChallenges"]))
		{
			var_00.var_12C["postGameChallenges"] = 0;
		}

		var_00 thread func_5317();
		if(!function_0367())
		{
			var_00 thread func_6B82();
			var_00 thread func_6369();
			var_00 thread func_63E5();
			var_00 thread func_63DB();
			var_00 thread func_63A3();
			var_00 thread func_6392();
			var_00 thread func_63B2();
			var_00 thread func_63FA();
			var_00 thread func_63C3();
			var_00 notifyonplayercommand("jumped","+goStand");
			var_00 thread func_63AE();
			var_00.streaksdestroyedthislife = [];
		}
		else
		{
			var_00 thread lib_0468::ae_sendzmskinunlockevent();
		}

		var_00 thread func_63CA();
	}
}

//Function Number: 4
func_6B82()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread func_6B74();
	}
}

//Function Number: 5
func_6B74()
{
	self endon("disconnect");
	self waittill("death");
	if(isdefined(self.var_4B8F))
	{
		self.var_4B8F = 0;
	}

	if(isdefined(self.streaksdestroyedthislife))
	{
		self.streaksdestroyedthislife = [];
	}
}

//Function Number: 6
func_63DB()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("scavenger_pickup");
		if(maps\mp\_utility::func_649("specialty_class_forage"))
		{
			self.var_4B8F = 1;
		}
		else if(maps\mp\_utility::func_649("specialty_class_clandestine"))
		{
			func_7750("ch_dlc1_cladestine");
		}

		wait 0.05;
	}
}

//Function Number: 7
func_6392()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("revive");
		func_7750("ch_livingdead");
		wait 0.05;
	}
}

//Function Number: 8
func_5317()
{
	while(!isdefined(level.var_5A61))
	{
		wait 0.05;
	}

	var_00 = getarraykeys(level.var_5A61);
	foreach(var_02 in var_00)
	{
		self.var_12C[var_02] = 0;
	}

	self.var_12C["lastBulletKillTime"] = 0;
	self.var_12C["bulletStreak"] = 0;
	self.var_3961 = [];
}

//Function Number: 9
func_7BEF(param_00,param_01)
{
	if(!isdefined(level.var_6254[param_00]))
	{
		level.var_6254[param_00] = [];
	}

	level.var_6254[param_00][level.var_6254[param_00].size] = param_01;
}

//Function Number: 10
func_4451(param_00)
{
	if(isdefined(self.var_20A9[param_00]))
	{
		return self.var_20A9[param_00];
	}

	return 0;
}

//Function Number: 11
func_2091(param_00)
{
	var_01 = param_00.var_721C;
	var_01 func_7750("ch_assists");
}

//Function Number: 12
func_20A0(param_00)
{
	var_01 = 3;
	var_02 = 4;
	var_03 = 2;
	func_7750("ch_career_killstreakkills");
	switch(param_00)
	{
		case "fighter_strike_kill":
			func_7750("ch_streak_fighterstrike");
			if(!isdefined(self.var_3AAA))
			{
				self.var_3AAA = 0;
			}
	
			self.var_3AAA = self.var_3AAA + 1;
			if(self.var_3AAA == var_01)
			{
				func_7750("ch_streak_ontarget");
			}
			break;

		case "fritzx_kill":
			func_7750("ch_streak_fritzx");
			if(!isdefined(self.var_3EE8))
			{
				self.var_3EE8 = 0;
			}
	
			self.var_3EE8 = self.var_3EE8 + 1;
			if(self.var_3EE8 == var_01)
			{
				func_7750("ch_streak_ontarget");
			}
			break;

		case "firebomb_kill":
			func_7750("ch_streak_firebomb");
			if(!isdefined(self.var_3BD6))
			{
				self.var_3BD6 = 0;
			}
	
			self.var_3BD6 = self.var_3BD6 + 1;
			if(self.var_3BD6 == var_02)
			{
				func_7750("ch_streak_rainingdeath");
			}
			break;

		case "airstrike_kill":
			func_7750("ch_streak_airstrike");
			if(!isdefined(self.var_B95))
			{
				self.var_B95 = 0;
			}
	
			self.var_B95 = self.var_B95 + 1;
			if(self.var_B95 == var_02)
			{
				func_7750("ch_streak_rainingdeath");
			}
			break;

		case "plane_gunner_kill":
			func_7750("ch_streak_planegunner");
			if(!isdefined(self.var_7036))
			{
				self.var_7036 = 0;
			}
	
			self.var_7036 = self.var_7036 + 1;
			if(self.var_7036 == var_02)
			{
				func_7750("ch_streak_rainingdeath");
			}
			break;

		case "molotovs_kill":
			func_7750("ch_streak_molotovs");
			if(!isdefined(self.var_62C3))
			{
				self.var_62C3 = 0;
			}
	
			self.var_62C3 = self.var_62C3 + 1;
			if(self.var_62C3 == var_03)
			{
				func_7750("ch_streak_flamed");
			}
			break;

		case "flamethrower_kill":
			func_7750("ch_streak_flamethrower");
			if(!isdefined(self.var_3D1D))
			{
				self.var_3D1D = 0;
			}
	
			self.var_3D1D = self.var_3D1D + 1;
			if(self.var_3D1D == var_03)
			{
				func_7750("ch_streak_flamed");
			}
			break;

		case "mortar_strike_kill":
			func_7750("ch_streak_mortarstrike");
			break;

		case "missile_strike_kill":
			func_7750("ch_streak_missilestrike");
			break;

		case "paratroopers_kill":
			func_7750("ch_streak_paratroopers");
			break;

		default:
			break;
	}
}

//Function Number: 13
func_209A(param_00)
{
	if(isbot(param_00.var_721C))
	{
		return;
	}

	var_01 = param_00.var_721C;
	var_01.var_12C[param_00.var_4B1F]++;
	switch(param_00.var_4B1F)
	{
		case "uav":
			var_01 func_7750("ch_uav");
			var_01 func_7750("ch_assault_streaks");
			if(var_01.var_12C["uav"] >= 3)
			{
				var_01 func_7750("ch_nosecrets");
			}
			break;

		case "airdrop_assault":
			var_01 func_7750("ch_airdrop_assault");
			var_01 func_7750("ch_assault_streaks");
			break;

		case "airdrop_sentry_minigun":
			var_01 func_7750("ch_airdrop_sentry_minigun");
			var_01 func_7750("ch_assault_streaks");
			break;

		case "nuke":
			var_01 func_7750("ch_nuke");
			break;
	}
}

//Function Number: 14
func_20A3(param_00)
{
	if(!isdefined(param_00.var_1180) || !isplayer(param_00.var_1180))
	{
		return;
	}

	if(!maps\mp\_utility::func_5740(param_00.var_953E))
	{
		return;
	}

	var_01 = param_00.var_1180;
	if(!isdefined(var_01.var_12C[param_00.var_953E + "_streak"]) || isdefined(var_01.var_12C[param_00.var_953E + "_streakTime"]) && gettime() - var_01.var_12C[param_00.var_953E + "_streakTime"] > 7000)
	{
		var_01.var_12C[param_00.var_953E + "_streak"] = 0;
		var_01.var_12C[param_00.var_953E + "_streakTime"] = gettime();
	}

	var_01.var_12C[param_00.var_953E + "_streak"]++;
	switch(param_00.var_953E)
	{
		case "artillery_mp":
			var_01 func_7750("ch_carpetbomber");
			if(var_01.var_12C[param_00.var_953E + "_streak"] >= 5)
			{
				var_01 func_7750("ch_carpetbomb");
			}
	
			if(isdefined(var_01.var_3B4B))
			{
				var_01 func_7750("ch_finishingtouch");
			}
			break;

		case "stealth_bomb_mp":
			var_01 func_7750("ch_thespirit");
			if(var_01.var_12C[param_00.var_953E + "_streak"] >= 6)
			{
				var_01 func_7750("ch_redcarpet");
			}
	
			if(isdefined(var_01.var_3B4B))
			{
				var_01 func_7750("ch_technokiller");
			}
			break;

		case "sentry_minigun_mp":
			var_01 func_7750("ch_looknohands");
			if(isdefined(var_01.var_3B4B))
			{
				var_01 func_7750("ch_absentee");
			}
			break;

		case "ac130_25mm_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
			var_01 func_7750("ch_spectre");
			if(isdefined(var_01.var_3B4B))
			{
				var_01 func_7750("ch_deathfromabove");
			}
			break;

		case "remotemissile_projectile_mp":
			var_01 func_7750("ch_predator");
			if(var_01.var_12C[param_00.var_953E + "_streak"] >= 4)
			{
				var_01 func_7750("ch_reaper");
			}
	
			if(isdefined(var_01.var_3B4B))
			{
				var_01 func_7750("ch_dronekiller");
			}
			break;

		default:
			break;
	}
}

//Function Number: 15
func_20A2(param_00)
{
	if(!isdefined(param_00.var_1180) || !isplayer(param_00.var_1180))
	{
		return;
	}

	var_01 = param_00.var_1180;
	var_02 = maps\mp\_utility::func_4431(param_00.var_953E,1);
	if(maps\mp\_utility::func_5856(var_02))
	{
		var_02 = maps\mp\gametypes\_class::func_4432(var_02);
	}

	var_03 = func_40EE(param_00.var_953E,var_02);
	if(var_03 == "weapon_projectile")
	{
		if(isdefined(level.var_20AA["ch_vehicle_" + var_02]))
		{
			var_01 func_7750("ch_vehicle_" + var_02);
		}

		if(isdefined(level.var_20AA["ch_marksman_" + var_02]) && var_02 != "dp28_mp")
		{
			var_01 func_7750("ch_marksman_" + var_02);
		}
	}

	if(var_01 maps\mp\_utility::func_649("specialty_coldblooded") && var_01 maps\mp\_utility::func_649("specialty_spygame") && var_01 maps\mp\_utility::func_649("specialty_heartbreaker"))
	{
		if(!isdefined(param_00.var_A2C8) || !isdefined(param_00.var_A2C8.var_83EA) || param_00.var_A2C8.var_83EA != "prison_turret")
		{
			var_01 func_7750("ch_precision_airhunt");
		}
	}

	if(isdefined(param_00.var_A2C8) && isdefined(param_00.var_A2C8.var_1C8) && param_00.var_A2C8.var_1C8 == "drone_recon" && issubstr(var_02,"exoknife"))
	{
		var_01 func_7750("ch_precision_knife");
	}

	if(issubstr(param_00.var_953E,"rapid_fire") && issubstr(param_00.var_953E,"fmj"))
	{
		var_01 func_7750("ch_combatefficiency_hotlead");
	}
}

//Function Number: 16
func_23E3(param_00)
{
	self endon("disconnect");
	self notify("clearing_expID_" + param_00);
	self endon("clearing_expID_" + param_00);
	wait(3);
	self.var_3962[param_00] = undefined;
}

//Function Number: 17
func_6157()
{
	var_00 = self;
	if(!isdefined(var_00.var_12C["MGStreak"]))
	{
		var_00.var_12C["MGStreak"] = 0;
		var_00 thread func_36D8();
		if(!isdefined(var_00.var_12C["MGStreak"]))
		{
			return;
		}
	}

	var_00.var_12C["MGStreak"]++;
	if(var_00.var_12C["MGStreak"] >= 5)
	{
		var_00 func_7750("ch_mgmaster");
	}
}

//Function Number: 18
func_36D8()
{
	self endon("disconnect");
	for(;;)
	{
		if(!isalive(self) || self usebuttonpressed())
		{
			self.var_12C["MGStreak"] = undefined;
			break;
		}

		wait 0.05;
	}
}

//Function Number: 19
func_36D7()
{
	self.var_12C["MGStreak"] = undefined;
}

//Function Number: 20
func_5A3B(param_00)
{
	if(!isdefined(self.var_12C["countermvp_streak"]) || !param_00)
	{
		self.var_12C["countermvp_streak"] = 0;
	}

	self.var_12C["countermvp_streak"]++;
	if(self.var_12C["countermvp_streak"] == 3)
	{
		func_7750("ch_thebiggertheyare");
	}
	else if(self.var_12C["countermvp_streak"] == 5)
	{
		func_7750("ch_thehardertheyfall");
	}

	if(self.var_12C["countermvp_streak"] >= 10)
	{
		func_7750("ch_countermvp");
	}
}

//Function Number: 21
func_5712(param_00)
{
	if(!isdefined(param_00.var_15C) || param_00.var_15C < 1)
	{
		return 0;
	}

	var_01 = level.var_744A;
	if(level.var_984D)
	{
		var_02 = param_00.var_12C["team"];
	}
	else
	{
		var_02 = "all";
	}

	var_03 = param_00.var_15C;
	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		if(!isdefined(var_01[var_04].var_15C))
		{
			continue;
		}

		if(var_01[var_04].var_15C < 1)
		{
			continue;
		}

		if(var_02 != "all" && var_01[var_04].var_12C["team"] != var_02)
		{
			continue;
		}

		if(var_01[var_04].var_15C > var_03)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 22
func_7752(param_00)
{
	if(!isdefined(self.var_20A9) || !isdefined(self.var_20A9[param_00]))
	{
		return;
	}

	if(self.var_20A9[param_00] != 2)
	{
		return;
	}

	if(!maps\mp\_utility::func_7A69() || maps\mp\_utility::func_773F())
	{
		return;
	}

	var_01 = maps\mp\gametypes\_hud_util::func_2097(param_00);
	if(var_01 >= level.var_20AA[param_00]["targetval"])
	{
		return;
	}

	var_02 = var_01 + 1;
	if(var_02 == level.var_20AA[param_00]["targetval"])
	{
		thread maps\mp\gametypes\_hud_message::func_9102(param_00 + "_complete");
		self.var_20A9[param_00] = 3;
		maps\mp\gametypes\_hud_util::func_209F(param_00,3);
		return;
	}

	maps\mp\gametypes\_hud_util::func_209E(param_00,var_02);
}

//Function Number: 23
func_209B(param_00)
{
	param_00.var_A490 func_73D3();
	if(!isdefined(param_00.var_1180) || !isplayer(param_00.var_1180))
	{
		return;
	}
	else
	{
		var_01 = param_00.var_1180;
	}

	if(isbot(var_01))
	{
		return;
	}

	var_01 func_7752("ch_daily_0");
	if(param_00.var_8CD7 == "MOD_HEAD_SHOT")
	{
		var_01 func_7752("ch_daily_1");
	}

	var_02 = 0;
	var_03 = 0;
	var_04 = 1;
	var_05[param_00.var_A490.var_109] = param_00.var_A490.var_109;
	var_06[param_00.var_953E] = param_00.var_953E;
	var_07 = 1;
	var_08 = [];
	var_09 = param_00.var_8CD7;
	var_0A = param_00.var_99DA;
	var_0B = function_0061(param_00.var_953E);
	var_0C = 0;
	if(isdefined(var_01.var_6FBA[param_00.var_953E]) && !maps\mp\_utility::func_5755(var_09))
	{
		var_0C++;
	}

	var_0D = maps\mp\_utility::func_5740(param_00.var_953E);
	var_0E = maps\mp\_utility::func_56DF(param_00.var_953E);
	var_0F = 0;
	if(var_09 == "MOD_HEAD_SHOT")
	{
		var_0F = 1;
	}

	var_10 = 0;
	var_11 = 0;
	if(isdefined(param_00.var_62A1["longshot"]))
	{
		var_10 = 1;
		var_11++;
	}

	var_12 = param_00.var_A85F;
	var_13 = 0;
	if(var_01.var_7AD2 == 2)
	{
		var_13 = 1;
	}

	var_14 = 0;
	if(var_01.var_7AD2 == 3)
	{
		var_14 = 1;
	}

	var_15 = "";
	if(isdefined(param_00.var_1199))
	{
		var_15 = param_00.var_1199;
	}

	var_16 = 0;
	var_17 = 0;
	var_18 = 0;
	var_19 = 0;
	var_1A = 0;
	var_1B = 0;
	switch(var_01.var_5A57.size + 1)
	{
		case 5:
			var_16 = 1;
			break;

		case 10:
			var_17 = 1;
			break;

		case 15:
			var_18 = 1;
			break;

		case 20:
			var_19 = 1;
			break;

		case 25:
			var_1A = 1;
			break;

		case 30:
			var_1B = 1;
			break;

		default:
			break;
	}

	foreach(var_1D in var_01.var_5A57)
	{
		if(maps\mp\_utility::func_569A(var_1D.var_953E) && !maps\mp\_utility::func_5755(var_1D.var_8CD7))
		{
			var_03++;
		}

		if(isdefined(var_1D.var_62A1["longshot"]))
		{
			var_11++;
		}

		if(var_11 == 3)
		{
			var_01 func_7750("ch_precision_farsight");
		}

		if(var_0A - var_1D.var_99DA < 10000)
		{
			var_04++;
		}

		if(isdefined(var_01.var_6FBA[var_1D.var_953E]) && !maps\mp\_utility::func_5755(var_1D.var_8CD7))
		{
			var_0C++;
			if(var_0C == 5)
			{
				var_01 func_7750("ch_humiliation_finders");
			}
		}

		if(maps\mp\_utility::func_5740(var_1D.var_953E))
		{
			if(!isdefined(var_08[var_1D.var_953E]))
			{
				var_08[var_1D.var_953E] = 0;
			}

			var_08[var_1D.var_953E]++;
			continue;
		}

		if(isdefined(level.var_6AF5[var_01.var_1A7]) && var_1D.var_99DA > level.var_6AF5[var_01.var_1A7])
		{
			var_02++;
		}

		if(isdefined(var_1D.var_A490))
		{
			if(!isdefined(var_05[var_1D.var_A490.var_109]) && !isdefined(var_06[var_1D.var_953E]) && !maps\mp\_utility::func_5740(var_1D.var_953E))
			{
				var_07++;
			}

			var_05[var_1D.var_A490.var_109] = var_1D.var_A490.var_109;
		}

		var_06[var_1D.var_953E] = var_1D.var_953E;
	}

	var_1F = maps\mp\_utility::func_45B5(param_00.var_953E);
	var_20 = var_1F;
	if(common_scripts\utility::func_9467(var_1F,"iw5_"))
	{
		var_20 = getsubstr(var_1F,4);
	}

	var_21 = func_40EE(param_00.var_953E,var_1F);
	if(level.var_984D)
	{
		if(level.var_984F[param_00.var_A490.var_12C["team"]] > 3 && var_01.var_5A42.size >= level.var_984F[param_00.var_A490.var_12C["team"]])
		{
			var_01 func_7750("ch_precision_cleanhouse");
		}
	}

	if(isdefined(var_01.var_3959) && param_00.var_A490 == var_01.var_3959)
	{
		var_01 func_7750("ch_precision_protected");
	}

	var_22 = undefined;
	if(maps\mp\_utility::func_57E5(param_00.var_953E,"alt_"))
	{
		var_22 = getsubstr(param_00.var_953E,4);
	}

	if(isdefined(var_01.var_6FBA[param_00.var_953E]) || isdefined(var_22) && isdefined(var_01.var_6FBA[var_22]))
	{
		if(!maps\mp\_utility::func_5755(var_09))
		{
			var_01 func_7750("ch_boot_stolen");
		}
	}

	if(var_15 == "crouch")
	{
		var_01 func_7750("ch_boot_crouch");
	}

	if(var_15 == "prone")
	{
		var_01 func_7750("ch_boot_prone");
	}

	if(isdefined(param_00.var_62A1["assaultObjective"]))
	{
		var_01 func_7750("ch_heroics_assault");
		var_23 = 1;
		var_24 = 1;
		for(var_25 = 0;var_25 < var_01.recentkills.size;var_25++)
		{
			if(isdefined(var_01.recentkills[var_25].var_62A1["assaultObjective"]))
			{
				var_23++;
				if(var_01.recentkills[var_25].var_62A1["assaultObjective"] == param_00.var_62A1["assaultObjective"])
				{
					var_24++;
				}

				continue;
			}

			break;
		}

		if(var_23 == 2)
		{
			var_01 func_7750("ch_killer_aggression");
		}

		if(var_24 == 3)
		{
			var_01 thread ch_monitorkillerdoingwork(param_00.var_62A1["assaultObjective"]);
		}
	}

	if(isdefined(param_00.var_62A1["defendObjective"]))
	{
		var_01 func_7750("ch_heroics_defender");
		var_26 = 1;
		for(var_25 = 0;var_25 < var_01.recentkills.size;var_25++)
		{
			if(isdefined(var_01.recentkills[var_25].var_62A1["defendObjective"]))
			{
				var_26++;
				continue;
			}

			break;
		}

		if(var_26 == 2)
		{
			var_01 func_7750("ch_killer_rejection");
		}

		var_27 = 1;
		foreach(var_1D in var_01.var_5A57)
		{
			if(isdefined(var_1D.var_62A1["defendObjective"]) && var_1D.var_62A1["defendObjective"] == param_00.var_62A1["defendObjective"])
			{
				var_27++;
			}
		}

		if(var_27 == 5)
		{
			var_01 func_7750("ch_killer_resistance");
		}
	}

	if(!isdefined(level.disabledivisionchallenges) || !level.disabledivisionchallenges)
	{
		if(isdefined(param_00.var_1180.var_79) && !var_0E && !var_0D)
		{
			var_2A = maps\mp\gametypes\_divisions::func_44A0(param_00.var_1180.var_79);
			if(var_2A == "infantry")
			{
				var_01 func_7750("ch_infantry_kills");
				if(var_21 == "weapon_assault" && !maps\mp\_utility::func_5755(var_09))
				{
					var_01 func_7750("ch_infantry_weapon");
				}

				if(common_scripts\utility::func_562E(param_00.var_62A1["divisions_infantry_kill"]))
				{
					var_01 func_7750("ch_infantry_skill");
				}
			}
			else if(var_2A == "airborne")
			{
				var_01 func_7750("ch_airborne_kills");
				if(var_21 == "weapon_smg" && !maps\mp\_utility::func_5755(var_09))
				{
					var_01 func_7750("ch_airborne_weapon");
				}

				if(common_scripts\utility::func_562E(param_00.var_62A1["divisions_airborne_kill"]))
				{
					var_01 func_7750("ch_airborne_skill");
				}
			}
			else if(var_2A == "armored")
			{
				var_01 func_7750("ch_armored_kills");
				if(var_21 == "weapon_heavy" && !maps\mp\_utility::func_5755(var_09))
				{
					var_01 func_7750("ch_armored_weapon");
				}

				if(common_scripts\utility::func_562E(param_00.var_62A1["divisions_armored_kill"]))
				{
					var_01 func_7750("ch_armored_skill");
				}
			}
			else if(var_2A == "mountain")
			{
				var_01 func_7750("ch_mountain_kills");
				if(var_21 == "weapon_sniper" && !maps\mp\_utility::func_5755(var_09))
				{
					var_01 func_7750("ch_mountain_weapon");
				}

				if(common_scripts\utility::func_562E(param_00.var_62A1["divisions_mountain_kill"]))
				{
					var_01 func_7750("ch_mountain_skill");
				}
			}
			else if(var_2A == "expeditionary")
			{
				var_01 func_7750("ch_expeditionary_kills");
				if(var_21 == "weapon_shotgun" && !maps\mp\_utility::func_5755(var_09))
				{
					var_01 func_7750("ch_expeditionary_weapon");
				}

				if(common_scripts\utility::func_562E(param_00.var_62A1["divisions_cavalry_kill"]))
				{
					var_01 func_7750("ch_expeditionary_skill");
				}
			}
			else if(var_2A == "resistance")
			{
				var_01 func_7750("ch_resistance_kills");
				if(var_21 == "weapon_pistol" && !maps\mp\_utility::func_5755(var_09))
				{
					var_01 func_7750("ch_resistance_weapon");
				}

				if(common_scripts\utility::func_562E(param_00.var_62A1["division_resistance_kill"]))
				{
					var_01 func_7750("ch_resistance_skill");
				}
			}
			else if(var_2A == "grenadier")
			{
				var_01 func_7750("ch_grenadier_kills");
				if(issubstr(var_1F,"riotshield_mp"))
				{
					var_01 func_7750("ch_grenadier_weapon");
				}
			}
			else if(var_2A == "commando")
			{
				var_01 func_7750("ch_commando_kills");
			}
			else if(var_2A == "scout")
			{
				var_01 func_7750("ch_scout_kills");
				if(var_21 == "weapon_sniper" && !maps\mp\_utility::func_5755(var_09))
				{
					var_01 func_7750("ch_scout_weapon");
				}

				if(common_scripts\utility::func_562E(param_00.var_62A1["division_scout_kill"]))
				{
					var_01 func_7750("ch_scout_skill");
				}
			}
			else if(var_2A == "artillery")
			{
				var_01 func_7750("ch_artillery_kills");
				if(var_21 == "weapon_assault" && !maps\mp\_utility::func_5755(var_09))
				{
					var_01 func_7750("ch_artillery_weapon");
				}

				if(common_scripts\utility::func_562E(param_00.var_62A1["division_artillery_kill"]))
				{
					var_01 func_7750("ch_artillery_skill");
				}
			}
		}
	}

	if(param_00.var_A490 != param_00.var_1180)
	{
		var_2B = !level.var_984D || param_00.var_A490.var_1A7 != param_00.var_1180.var_1A7;
		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_radarimmune"))
		{
			var_2C = 0;
			if(isdefined(level.var_9FDA))
			{
				if(level.var_984D)
				{
					var_2C = level.var_9FDA[maps\mp\_utility::func_45DE(param_00.var_1180.var_1A7)].size;
				}
				else if(level.var_9FDA.size > 0)
				{
					var_2D = 0;
					foreach(var_2F in level.var_9FDA)
					{
						if(var_2F.var_117 == var_01)
						{
							var_2D++;
						}
					}

					if(var_2D > 0)
					{
						var_2C = level.var_9FDA.size - var_2D;
					}
					else
					{
						var_2C = level.var_9FDA.size;
					}
				}
			}

			if(var_2C > 0)
			{
				var_01 func_7750("ch_perks1_lowprofile");
			}
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_requisitions") && var_0D)
		{
			var_01 func_7750("ch_field_requisitions");
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_duelist") && var_21 == "weapon_pistol")
		{
			foreach(var_32 in var_0B)
			{
				if(issubstr(var_32,"akimbo"))
				{
					var_01 func_7750("ch_marksman_duelist");
					break;
				}
			}
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_inconspicuous") && var_15 == "crouch")
		{
			var_01 func_7750("ch_physical_inconspicuous");
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_scoped") && var_01 adsbuttonpressed())
		{
			var_01 func_7750("ch_marksman_scoped");
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_energetic") && isdefined(var_01.var_5BE3) && gettime() - var_01.var_5BE3 < 5000)
		{
			var_01 func_7750("ch_physical_energetic");
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_undercover"))
		{
			var_01 thread func_6359();
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_hustle") && isdefined(var_01.var_5BD6) && gettime() - var_01.var_5BD6 < 5000)
		{
			var_01 func_7750("ch_physical_hustle");
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_lookout") && var_10)
		{
			var_01 func_7750("ch_operations_lookout");
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_gunslinger") && var_01 issprinting())
		{
			var_01 func_7750("ch_physical_gunslinger");
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_exo_blastsuppressor"))
		{
			var_01 func_7750("ch_perk_blast");
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_delaymine"))
		{
			var_34 = 0;
			if(isdefined(level.var_9FDA))
			{
				if(level.var_984D)
				{
					foreach(var_2F in level.var_9FDA[maps\mp\_utility::func_45DE(var_01.var_1A7)])
					{
						if(isdefined(var_2F.var_9FE0) && var_2F.var_9FE0 == "counter")
						{
							var_34 = 1;
							break;
						}
					}

					if(isdefined(level.var_35F5) && level.var_35F5.var_1A7 != var_01.var_1A7)
					{
						var_34 = 1;
					}
				}
				else
				{
					foreach(var_2F in level.var_9FDA)
					{
						if(isdefined(var_2F.var_9FE0) && var_2F.var_9FE0 == "counter" && isdefined(var_2F.var_117) && !var_2F.var_117 == var_01)
						{
							var_34 = 1;
							break;
						}
					}
				}
			}

			if(var_34)
			{
				var_01 func_7750("ch_perk_hardwire");
			}
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_serrated") && issubstr(var_1F,"throwingknife_mp"))
		{
			var_01 func_7750("ch_field_serrated");
		}

		var_39 = maps\mp\_utility::func_472A(param_00.var_953E);
		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_launched") && var_39 == "weapon_projectile")
		{
			var_01 func_7750("ch_explosives_launched");
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_rifleman"))
		{
			if(isdefined(var_01.var_5BD0) && gettime() - var_01.var_5BD0 < 5000)
			{
				var_01 func_7750("ch_marksman_rifleman");
			}
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_primed"))
		{
			if(isdefined(var_01.var_5B8B) && gettime() - var_01.var_5B8B < 2000)
			{
				var_01 func_7750("ch_marksman_primed");
			}
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_forage") && isdefined(var_01.var_4B8F) && var_01.var_4B8F == 1)
		{
			var_01 func_7750("ch_field_forage");
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_class_instincts") && isdefined(var_01.var_6F4D) && var_01.var_6F4D.size > 0)
		{
			var_3A = param_00.var_A490 getentitynumber();
			if(isdefined(var_01.var_6F4D[var_3A]) && var_01.var_6F4D[var_3A])
			{
				var_01 func_7750("ch_operations_instincts");
			}
		}

		if((param_00.var_A490 common_scripts\utility::func_56F4() || param_00.var_A490 common_scripts\utility::func_56B5()) && var_01 maps\mp\_utility::func_649("specialty_stun_resistance"))
		{
			if(var_01 maps\mp\_utility::func_649("specialty_sprintfire"))
			{
				var_01 func_7750("ch_perks3_junkie");
			}

			if(isdefined(param_00.var_A490.var_1189[var_01.var_48CA]))
			{
				foreach(var_3C in param_00.var_A490.var_1189[var_01.var_48CA].var_A9DF)
				{
					if(var_3C == "flash_grenade_mp" || var_3C == "stun_grenade_mp" || var_3C == "signal_flare_mp")
					{
						var_01 func_7750("ch_perks2_tacmask");
					}
				}
			}
		}

		if(var_2B && var_01 maps\mp\_utility::func_649("specialty_sixthsense") && isdefined(var_01.var_4B65) && var_01.var_4B65)
		{
			var_3E = var_01.var_116;
			var_3F = param_00.var_A490.var_116;
			if(isdefined(level.var_8E2) && distancesquared(var_3E,var_3F) <= level.var_8E2 * level.var_8E2)
			{
				var_01 func_7750("ch_perks1_sixthsense");
			}
		}
	}

	if(var_0A < param_00.var_A490.var_2577)
	{
		var_01 func_7750("ch_exolauncher_stun");
	}

	if(isdefined(param_00.var_A490.var_5384))
	{
		var_01 func_7750("ch_exolauncher_smoke");
	}

	if(issubstr(param_00.var_953E,"extended_mag"))
	{
		var_01 func_7750("ch_combathandling_extended_mag");
		var_01 func_18AC();
	}

	if(issubstr(param_00.var_953E,"grip"))
	{
		var_01 func_7750("ch_combathandling_grip");
	}

	if(issubstr(param_00.var_953E,"fast_ads"))
	{
		var_01 func_7750("ch_combathandling_fast_ads");
	}

	if(issubstr(param_00.var_953E,"reduced_sway"))
	{
		var_01 func_7750("ch_combathandling_reduced_sway");
	}

	if(issubstr(param_00.var_953E,"hipfire"))
	{
		var_01 func_7750("ch_combatefficiency_hipfire");
	}

	if(issubstr(param_00.var_953E,"fast_ads") && issubstr(param_00.var_953E,"grip"))
	{
		var_01 func_7750("ch_combathandling_fastshooting");
	}

	if(issubstr(param_00.var_953E,"fast_ads") && issubstr(param_00.var_953E,"grip") && issubstr(param_00.var_953E,"extended_mag"))
	{
		var_01 func_7750("ch_combathandling_smoothop");
	}

	if(!var_12 && issubstr(param_00.var_953E,"hipfire") && issubstr(param_00.var_953E,"extended_mag") && issubstr(param_00.var_953E,"rapid_fire"))
	{
		var_01 func_7750("ch_combatefficiency_gunner");
	}

	if(issubstr(param_00.var_953E,"fmj"))
	{
		var_01 func_7750("ch_combatefficiency_fmj");
	}

	if(issubstr(param_00.var_953E,"head_damage"))
	{
		var_01 func_7750("ch_combatefficiency_head_damage");
	}

	if(issubstr(param_00.var_953E,"rapid_fire"))
	{
		var_01 func_7750("ch_combatefficiency_rapid_fire");
	}

	if(issubstr(param_00.var_953E,"extended_range"))
	{
		var_01 func_7750("ch_combatefficiency_extended_range");
	}

	if(issubstr(param_00.var_953E,"lens_sight"))
	{
		var_01 func_7750("ch_combatefficiency_lens_sight");
	}

	if(issubstr(param_00.var_953E,"aperture_sight"))
	{
		var_01 func_7750("ch_combatefficiency_aperture_sight");
	}

	if(issubstr(param_00.var_953E,"telescopic_sight"))
	{
		var_01 func_7750("ch_combatefficiency_telescopic_sight");
	}

	if(var_0F && issubstr(param_00.var_953E,"fmj") && issubstr(param_00.var_953E,"extended_range"))
	{
		var_01 func_7750("ch_combatefficiency_headhunter");
	}

	if(issubstr(param_00.var_953E,"extended_range") && issubstr(param_00.var_953E,"fmj") && issubstr(param_00.var_953E,"telescopic_sight") || !issubstr(param_00.var_953E,"iron_sight"))
	{
		var_01 func_7750("ch_combatefficiency_assassin");
	}

	if(issubstr(param_00.var_953E,"akimbo"))
	{
		var_01 func_34C3();
	}

	foreach(var_41 in var_0B)
	{
		func_80A0(var_01,var_41,var_0B,param_00.var_953E,var_12,var_0F,var_10,var_13,var_16);
	}

	if(!maps\mp\_utility::func_5755(var_09) && !var_0E && !var_0D)
	{
		switch(var_21)
		{
			case "weapon_smg":
				var_01 func_7750("ch_smg_kill");
				if(var_0F)
				{
					var_01 func_7750("ch_smg_headshot");
				}
				break;

			case "weapon_assault":
				var_01 func_7750("ch_ar_kill");
				if(var_0F)
				{
					var_01 func_7750("ch_ar_headshot");
				}
				break;

			case "weapon_shotgun":
				var_01 func_7750("ch_shotgun_kill");
				if(var_0F)
				{
					var_01 func_7750("ch_shotgun_headshot");
				}
				break;

			case "weapon_sniper":
				var_01 func_7750("ch_sniper_kill");
				if(var_0F)
				{
					var_01 func_7750("ch_sniper_headshot");
				}
				break;

			case "weapon_pistol":
				var_01 func_7750("ch_pistol_kill");
				if(var_0F)
				{
					var_01 func_7750("ch_pistol_headshot");
				}
				break;

			case "weapon_heavy":
				var_01 func_7750("ch_heavy_kill");
				if(var_0F)
				{
					var_01 func_7750("ch_heavy_headshot");
				}
				break;

			case "weapon_special":
				var_01 func_7750("ch_special_kill");
				break;

			default:
				break;
		}

		if(var_09 == "MOD_HEAD_SHOT")
		{
			if(var_21 == "weapon_pistol")
			{
				var_01 notify("increment_pistol_headshots");
			}
			else if(var_21 == "weapon_assault")
			{
				var_01 notify("increment_ar_headshots");
			}
		}

		if(var_21 != "weapon_projectile" || var_1F == "dp28_mp")
		{
			var_01 func_7750("ch_marksman_" + var_1F);
		}
	}

	if((var_09 == "MOD_PISTOL_BULLET" || var_09 == "MOD_RIFLE_BULLET" || var_09 == "MOD_HEAD_SHOT") && !var_0E && !var_0D)
	{
		switch(var_21)
		{
			case "weapon_pistol":
			case "weapon_special":
			case "weapon_heavy":
			case "weapon_shotgun":
			case "weapon_sniper":
			case "weapon_assault":
			case "weapon_smg":
				if(issubstr(var_1F,"dlcgun") && var_21 == "weapon_assault" || var_21 == "weapon_heavy" || var_21 == "weapon_special")
				{
					var_01 func_7750("ch_attach_unlock_type1_" + var_20);
				}
				else
				{
					var_01 func_7750("ch_attach_unlock_kills_" + var_20);
				}
	
				if(var_12)
				{
					if(issubstr(var_1F,"dlcgun") && var_21 == "weapon_assault" || var_21 == "weapon_heavy" || var_21 == "weapon_special")
					{
						var_01 func_7750("ch_attach_unlock_type3_" + var_20);
					}
					else
					{
						var_01 func_7750("ch_attach_unlock_ads_" + var_20);
					}
				}
				else if(issubstr(var_1F,"dlcgun") && var_21 == "weapon_assault" || var_21 == "weapon_heavy" || var_21 == "weapon_special")
				{
					var_01 func_7750("ch_attach_unlock_type2_" + var_20);
				}
				else
				{
					var_01 func_7750("ch_attach_unlock_hipfirekills_" + var_20);
				}
				break;

			default:
				break;
		}

		if(var_09 == "MOD_HEAD_SHOT")
		{
			if(isdefined(level.var_20AA["ch_attach_unlock_headShots_" + var_20]))
			{
				var_01 func_7750("ch_attach_unlock_headShots_" + var_20);
			}
		}
	}

	if(isdefined(var_01.var_7E9F))
	{
		if(var_0A - var_01.var_7E9F.alignx < 3000)
		{
			var_01 func_7750("ch_attach_unlock_postplant_riotshieldt6");
		}
	}

	if(maps\mp\_utility::func_5755(var_09) && !var_0E && !var_0D)
	{
		if(!issubstr(var_1F,"riotshield"))
		{
			var_01.var_12C["meleeKillStreak"]++;
			foreach(var_41 in var_0B)
			{
				if(var_41 == "tactical")
				{
					var_01 func_7750("ch_attach_kill_tactical");
				}
			}
		}
		else if(issubstr(var_1F,"riotshield"))
		{
			if(var_1F == "iw5_riotshieldt6")
			{
				var_01 func_7750("ch_attach_unlock_meleekills_riotshieldt6");
				var_01 func_7750("ch_marksman_iw5_riotshieldt6");
				var_01 func_7750("ch_special_kill");
				var_01.var_12C["shieldKillStreak"]++;
			}
		}

		if(issubstr(var_1F,"exoshield"))
		{
			var_01 func_7750("ch_exoability_shield");
		}

		var_01 notify("increment_melee_kills");
		if(isgunmeleeattack(var_09,param_00.var_953E) && !issubstr(param_00.var_953E,"bayonet"))
		{
			var_01 func_7750("ch_humiliation_blunttrauma");
		}
	}

	if(issubstr(var_09,"MOD_IMPACT") && !var_0E && !var_0D)
	{
		if(issubstr(param_00.var_953E,"exoknife_mp"))
		{
			var_01 func_7750("ch_exolauncher_knife");
		}

		if(maps\mp\_utility::func_57E5(param_00.var_953E,"throwingknife_"))
		{
			var_01 func_7750("ch_lethals_knifekills");
			if(var_10)
			{
				var_01 func_7750("ch_humiliation_hailmary");
				var_01 lib_0468::func_A22("hailMary");
			}
		}

		if(var_1F == "iw5_microdronelauncher" && isdefined(level.var_20AA["ch_impact_iw5_microdronelauncher"]))
		{
			var_01 func_7750("ch_impact_iw5_microdronelauncher");
		}

		if(var_1F == "iw5_exocrossbow")
		{
			if(isdefined(level.var_20AA["ch_attach_unlock_kills_" + var_20]))
			{
				var_01 func_7750("ch_attach_unlock_kills_" + var_20);
			}

			if(var_12)
			{
				if(isdefined(level.var_20AA["ch_attach_unlock_ads_" + var_20]))
				{
					var_01 func_7750("ch_attach_unlock_ads_" + var_20);
				}
			}
		}
	}

	if(issubstr(var_09,"MOD_GRENADE") || issubstr(var_09,"MOD_PROJECTILE") || issubstr(var_09,"MOD_EXPLOSIVE") && !var_0E && !var_0D)
	{
		switch(var_21)
		{
			case "weapon_special":
				var_01 func_7750("ch_special_kill");
				break;

			default:
				break;
		}

		if(var_1F == "iw5_exocrossbow")
		{
			if(isdefined(level.var_20AA["ch_attach_unlock_kills_" + var_20]))
			{
				var_01 func_7750("ch_attach_unlock_kills_" + var_20);
			}

			if(var_12)
			{
				if(isdefined(level.var_20AA["ch_attach_unlock_ads_" + var_20]))
				{
					var_01 func_7750("ch_attach_unlock_ads_" + var_20);
				}
			}
		}

		if(maps\mp\_utility::func_57E5(param_00.var_953E,"frag_"))
		{
			var_01 func_7750("ch_exolauncher_frag");
			var_01 func_7750("ch_lethals_fragkills");
			if(param_00.var_A490.var_3961["cookedKill"])
			{
				var_01 func_7750("ch_lethals_masterchef");
			}

			if(param_00.var_A490.var_3961["throwbackKill"])
			{
				var_01 func_7750("ch_precision_return");
			}

			var_45 = 1;
			foreach(var_47 in var_01.recentkills)
			{
				if(maps\mp\_utility::func_57E5(var_47.var_953E,"frag_"))
				{
					var_45++;
				}
			}

			if(var_45 == 2)
			{
				var_01 func_7750("ch_humiliation_snackattack");
			}
		}

		if(maps\mp\_utility::func_57E5(param_00.var_953E,"semtex_"))
		{
			var_01 func_7750("ch_exolauncher_semtex");
			var_01 func_7750("ch_lethals_semtexkills");
		}

		if(maps\mp\_utility::func_57E5(param_00.var_953E,"thermite_"))
		{
			var_01 func_7750("ch_lethals_thermitekills");
		}

		if(maps\mp\_utility::func_57E5(param_00.var_953E,"c4_"))
		{
			var_01 func_7750("ch_lethals_c4kills");
		}

		if(isdefined(param_00.var_35A9.var_3A) && param_00.var_35A9.var_3A == "scriptable")
		{
			var_01 func_7750("ch_precision_sitaware");
		}

		if(isdefined(param_00.var_953E) && param_00.var_953E == "mp_lab_gas_explosion")
		{
			var_01 func_7750("ch_precision_sitaware");
		}

		if(maps\mp\_utility::func_5781(var_01) && var_01 maps\mp\_utility::func_649("specialty_class_bang"))
		{
			var_01 func_7750("ch_explosives_bang");
		}

		if(isdefined(param_00.var_A490.var_3961) && isdefined(param_00.var_A490.var_3961["midAirDetonate"]) && param_00.var_A490.var_3961["midAirDetonate"])
		{
			var_01 func_7750("ch_dlc1_saboteur");
		}
	}

	foreach(var_41 in var_0B)
	{
		switch(var_41)
		{
			case "gl":
				if(isdefined(level.var_20AA["ch_attach_kill_" + var_41]))
				{
					var_01 func_7750("ch_attach_kill_" + var_41);
				}
				break;
		}
	}

	if(issubstr(var_09,"MOD_EXPLOSIVE") && param_00.var_953E == "airdrop_trap_explosive_mp")
	{
		var_01 func_7750("ch_precision_surprise");
	}

	if(!isdefined(level.disableweaponchallenges) || !level.disableweaponchallenges)
	{
		if(var_0F)
		{
			switch(var_21)
			{
				case "weapon_pistol":
				case "weapon_heavy":
				case "weapon_assault":
				case "weapon_smg":
					var_01 func_7750("ch_camo_" + var_1F);
					break;
			}

			if(var_1F == "blunderbuss_mp")
			{
				var_01 tier4camochallenge(param_00.var_953E,"ch_camoT4_triplekill_");
			}
		}

		if(isdefined(param_00.var_62A1["oneshotkill"]))
		{
			switch(var_21)
			{
				case "weapon_shotgun":
				case "weapon_sniper":
					var_01 func_7750("ch_camo_" + var_1F);
					break;
			}

			if(var_1F == "dp28_mp")
			{
				var_01 func_7750("ch_camo_" + var_1F);
			}
		}

		if(var_21 == "weapon_other" && function_01A9(param_00.var_953E) == "melee")
		{
			var_01 func_7750("ch_camo_" + var_1F);
		}
	}

	if(var_21 == "weapon_projectile" && var_09 == "MOD_PROJECTILE")
	{
		var_01 func_99C5(param_00.var_953E,"ch_camoT2_directhitkill_");
		var_01 tier4camochallenge(param_00.var_953E,"ch_camoT4_directhitkill_");
	}

	if(isdefined(var_01.recentkills) && var_01.recentkills.size >= 1 && !isgunmeleeattack(var_09,param_00.var_953E))
	{
		if(var_01.recentkills.size == 1 && var_01 maps\mp\_utility::func_649("specialty_class_escalation"))
		{
			var_01 func_7750("ch_dlc2_escalation");
		}

		var_4B = 1;
		for(var_25 = 0;var_25 < var_01.recentkills.size;var_25++)
		{
			var_4C = maps\mp\_utility::func_45B5(var_01.recentkills[var_25].var_953E);
			if(var_4C == var_1F && !isgunmeleeattack(var_01.recentkills[var_25].var_8CD7,var_01.recentkills[var_25].var_953E))
			{
				var_4B++;
				continue;
			}

			break;
		}

		if(var_4B == 2)
		{
			var_01 func_99C5(param_00.var_953E,"ch_camoT2_doublekill_");
			var_01 tier3camochallenge(param_00.var_953E,"ch_camoT3_doublekill_");
			var_01 tier4camochallenge(param_00.var_953E,"ch_camoT4_doublekill_");
		}

		if(var_4B == 3)
		{
			if(var_1F != "blunderbuss_mp")
			{
				var_01 tier4camochallenge(param_00.var_953E,"ch_camoT4_triplekill_");
			}
		}
	}

	if(isdefined(var_01.var_5A57) && var_01.var_5A57.size >= 4 && !isgunmeleeattack(var_09,param_00.var_953E))
	{
		var_4B = 1;
		foreach(var_1D in var_01.var_5A57)
		{
			var_4C = maps\mp\_utility::func_45B5(var_1D.var_953E);
			if(var_4C == var_1F && !isgunmeleeattack(var_1D.var_8CD7,var_1D.var_953E))
			{
				var_4B++;
			}
		}

		if(var_4B == 5)
		{
			var_01 func_99C5(param_00.var_953E,"ch_camoT2_killstreak5_");
		}
	}

	if(isdefined(var_01.lastweaponswaptime) && gettime() - var_01.lastweaponswaptime < 5000 && !isgunmeleeattack(var_09,param_00.var_953E))
	{
		var_01 func_99C5(param_00.var_953E,"ch_camoT2_switchkill_");
		if(var_21 == "weapon_pistol" && var_01 maps\mp\_utility::func_649("specialty_class_shifty"))
		{
			var_01 func_7750("ch_dlc1_shifty");
		}

		if(var_01 maps\mp\_utility::func_649("specialty_class_wanderlust"))
		{
			var_01 func_7750("ch_dlc3_wanderlust");
		}
	}

	if(isdefined(var_01.var_9A8D[param_00.var_953E]) && var_01.var_9A8D[param_00.var_953E] == param_00.var_A490 && isdefined(var_01.tookweaponkillweapon[param_00.var_953E]) && !isgunmeleeattack(var_09,param_00.var_953E))
	{
		var_01 func_99C5(var_01.tookweaponkillweapon[param_00.var_953E],"ch_camoT2_takeandkill_");
	}

	if(isdefined(param_00.var_1180.var_79) && !isgunmeleeattack(var_09,param_00.var_953E) && !var_0E && !var_0D)
	{
		var_2A = maps\mp\gametypes\_divisions::func_44A0(param_00.var_1180.var_79);
		switch(var_21)
		{
			case "weapon_assault":
				if(var_2A == "infantry")
				{
					var_01 func_99C5(param_00.var_953E,"ch_camoT2_maindivision_");
				}
				else
				{
					var_01 func_99C5(param_00.var_953E,"ch_camoT2_altdivision_");
				}
				break;

			case "weapon_smg":
				if(var_2A == "airborne")
				{
					var_01 func_99C5(param_00.var_953E,"ch_camoT2_maindivision_");
				}
				else
				{
					var_01 func_99C5(param_00.var_953E,"ch_camoT2_altdivision_");
				}
				break;

			case "weapon_heavy":
				if(var_2A == "armored")
				{
					var_01 func_99C5(param_00.var_953E,"ch_camoT2_maindivision_");
				}
				else
				{
					var_01 func_99C5(param_00.var_953E,"ch_camoT2_altdivision_");
				}
				break;

			case "weapon_sniper":
				if(var_2A == "mountain")
				{
					var_01 func_99C5(param_00.var_953E,"ch_camoT2_maindivision_");
				}
				else
				{
					var_01 func_99C5(param_00.var_953E,"ch_camoT2_altdivision_");
				}
				break;

			case "weapon_shotgun":
				if(var_2A == "expeditionary")
				{
					var_01 func_99C5(param_00.var_953E,"ch_camoT2_maindivision_");
				}
				else
				{
					var_01 func_99C5(param_00.var_953E,"ch_camoT2_altdivision_");
				}
				break;
		}

		if(var_1F == "dp28_mp")
		{
			if(var_2A == "mountain")
			{
				var_01 func_99C5(param_00.var_953E,"ch_camoT2_maindivision_");
			}
			else
			{
				var_01 func_99C5(param_00.var_953E,"ch_camoT2_altdivision_");
			}
		}
	}

	if(var_21 == "weapon_launcher")
	{
		if(isdefined(level.var_20AA["ch_kills_" + var_1F]))
		{
			var_01 func_7750("ch_kills_" + var_1F);
		}

		if(issubstr(param_00.var_A490.var_106,"npc_exo_armor_mp_base"))
		{
			if(isdefined(level.var_20AA["ch_vehicle_" + var_1F]))
			{
				var_01 func_7750("ch_vehicle_" + var_1F);
			}

			if(isdefined(level.var_20AA["ch_goliath_" + var_1F]))
			{
				var_01 func_7750("ch_goliath_" + var_1F);
			}
		}
	}

	if(var_16 || var_17 || var_18 || var_19 || var_1A || var_1B)
	{
		if(var_21 == "weapon_sniper")
		{
			if(isdefined(level.var_20AA["ch_blood_" + var_1F]))
			{
				var_01 func_7750("ch_blood_" + var_1F);
			}
		}

		if(var_21 == "weapon_assault" || var_21 == "weapon_heavy" || var_1F == "iw5_microdronelauncher")
		{
			if(issubstr(var_1F,"dlcgun") && var_21 == "weapon_assault" || var_21 == "weapon_heavy")
			{
				var_01 func_7750("ch_tier2_2_" + var_1F);
			}
			else
			{
				var_01 func_7750("ch_triple_" + var_1F);
			}
		}
	}

	var_4F = 0;
	if(isdefined(var_01.var_5DFA))
	{
		foreach(var_51 in var_01.var_5DFA)
		{
			if(var_51 == 0)
			{
				var_4F++;
				continue;
			}

			break;
		}
	}

	if(var_4F == 9)
	{
		switch(var_21)
		{
			case "weapon_pistol":
			case "weapon_special":
			case "weapon_heavy":
			case "weapon_shotgun":
			case "weapon_sniper":
			case "weapon_assault":
			case "weapon_smg":
				if(issubstr(var_1F,"dlcgun") && var_21 == "weapon_assault" || var_21 == "weapon_heavy" || var_21 == "weapon_special")
				{
					var_01 func_7750("ch_tier2_5_" + var_1F);
				}
				else
				{
					var_01 func_7750("ch_noperk_" + var_1F);
				}
				break;
		}
	}

	if(isdefined(var_01.var_6EF6))
	{
		var_01.var_6EF6++;
		if(var_01.var_6EF6 == 3)
		{
			var_01 func_7750("ch_infect_patientzero");
		}
	}
}

//Function Number: 24
isgunmeleeattack(param_00,param_01)
{
	return maps\mp\_utility::func_5755(param_00) && function_01A9(param_01) != "melee";
}

//Function Number: 25
func_6359()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(5);
	if(maps\mp\_utility::func_57A0(self))
	{
		func_7750("ch_operations_undercover");
	}
}

//Function Number: 26
func_99C5(param_00,param_01)
{
	if(isdefined(level.disableweaponchallenges) && level.disableweaponchallenges)
	{
		return;
	}

	var_02 = maps\mp\_utility::func_45B5(param_00);
	var_03 = param_01 + var_02;
	var_04 = func_4450(var_03);
	if(isdefined(var_04))
	{
		if(func_56A7(var_03,var_04))
		{
			func_7750(var_03);
		}
	}
}

//Function Number: 27
tier3camochallenge(param_00,param_01)
{
	if(isdefined(level.disableweaponchallenges) && level.disableweaponchallenges)
	{
		return;
	}

	if(!func_60B1())
	{
		return;
	}

	var_02 = maps\mp\_utility::func_45B5(param_00);
	var_03 = param_01 + var_02;
	var_04 = func_4450(var_03);
	if(tablelookuprownum(maps\mp\gametypes\_gamelogic::getweaponlevelingtablename(),0,var_02) == -1)
	{
		return;
	}

	if(!isdefined(self.var_12C["weaponPrestige"][var_02]))
	{
		self.var_12C["weaponPrestige"][var_02] = self getrankedplayerdata(common_scripts\utility::func_46AE(),"weaponStats",var_02,"prestigeLevel");
	}

	if(isdefined(var_04))
	{
		if(self.var_12C["weaponPrestige"][var_02] >= 3)
		{
			func_7750(var_03);
		}
	}
}

//Function Number: 28
tier4camochallenge(param_00,param_01)
{
	if(isdefined(level.disableweaponchallenges) && level.disableweaponchallenges)
	{
		return;
	}

	if(!func_60B1())
	{
		return;
	}

	var_02 = maps\mp\_utility::func_45B5(param_00);
	var_03 = param_01 + var_02;
	var_04 = func_4450(var_03);
	if(tablelookuprownum(maps\mp\gametypes\_gamelogic::getweaponlevelingtablename(),0,var_02) == -1)
	{
		return;
	}

	if(!isdefined(self.var_12C["weaponPrestige"][var_02]))
	{
		self.var_12C["weaponPrestige"][var_02] = self getrankedplayerdata(common_scripts\utility::func_46AE(),"weaponStats",var_02,"prestigeLevel");
	}

	if(isdefined(var_04))
	{
		if(self.var_12C["weaponPrestige"][var_02] >= 4)
		{
			func_7750(var_03);
		}
	}
}

//Function Number: 29
func_4450(param_00)
{
	if(isdefined(param_00) && isdefined(level.var_20AA[param_00]))
	{
		var_01 = level.var_20AA[param_00]["index"];
		return var_01;
	}
}

//Function Number: 30
func_40EE(param_00,param_01)
{
	var_02 = maps\mp\_utility::func_472A(param_00);
	if(!isdefined(param_01))
	{
		param_01 = maps\mp\_utility::func_4431(param_00,1);
		if(maps\mp\_utility::func_5856(param_01))
		{
			param_01 = maps\mp\gametypes\_class::func_4432(param_01);
		}
	}

	if(param_01 == "iw5_exocrossbow" || param_01 == "iw5_exocrossbowblops2")
	{
		return "weapon_special";
	}

	if(param_01 == "iw5_maaws" || param_01 == "iw5_mahem")
	{
		return "weapon_launcher";
	}

	return var_02;
}

//Function Number: 31
func_2092(param_00,param_01,param_02,param_03)
{
	if(!maps\mp\_utility::func_56DF(param_00.var_953E))
	{
		param_01 func_36D7();
	}

	if(maps\mp\_utility::func_5740(param_00.var_953E))
	{
		return;
	}

	if(isbot(param_01))
	{
		return;
	}

	if(param_01.var_12C["lastBulletKillTime"] == param_02)
	{
		param_01.var_12C["bulletStreak"]++;
	}
	else
	{
		param_01.var_12C["bulletStreak"] = 1;
	}

	param_01.var_12C["lastBulletKillTime"] = param_02;
	if(!param_00.var_A494)
	{
		param_01 func_7750("ch_hardlanding");
	}

	if(!param_00.var_1190)
	{
		param_01.var_12C["midairStreak"]++;
	}

	if(param_01.var_12C["midairStreak"] == 2)
	{
		param_01 func_7750("ch_airborne");
	}

	if(param_02 < param_00.var_A490.var_3D48)
	{
		param_01 func_7750("ch_flashbangvet");
	}

	if(param_02 < param_01.var_3D48)
	{
		param_01 func_7750("ch_blindfire");
	}

	if(param_02 < param_00.var_A490.var_2577)
	{
		param_01 func_7750("ch_concussionvet");
	}

	if(param_02 < param_01.var_2577)
	{
		param_01 func_7750("ch_slowbutsure");
	}

	if(param_01.var_12C["bulletStreak"] == 2)
	{
		if(isdefined(param_00.var_62A1["headshot"]))
		{
			foreach(var_05 in param_01.var_5A57)
			{
				if(var_05.var_99DA != param_02)
				{
					continue;
				}

				if(!isdefined(param_00.var_62A1["headshot"]))
				{
					continue;
				}

				param_01 func_7750("ch_allpro");
			}
		}

		if(param_03 == "weapon_sniper")
		{
			param_01 func_7750("ch_collateraldamage");
		}
	}

	if(param_03 == "weapon_pistol")
	{
		if(isdefined(param_00.var_A490.var_1189) && isdefined(param_00.var_A490.var_1189[param_01.var_48CA]))
		{
			if(isdefined(param_00.var_A490.var_1189[param_01.var_48CA].var_5792))
			{
				param_01 func_7750("ch_fastswap");
			}
		}
	}

	if(!isdefined(param_01.var_5133) || !param_01.var_5133)
	{
		if(param_00.var_1199 == "crouch")
		{
			param_01 func_7750("ch_crouchshot");
		}
		else if(param_00.var_1199 == "prone")
		{
			param_01 func_7750("ch_proneshot");
			if(param_03 == "weapon_sniper")
			{
				param_01 func_7750("ch_invisible");
			}
		}
	}

	if(param_03 == "weapon_sniper")
	{
		if(isdefined(param_00.var_62A1["oneshotkill"]))
		{
			param_01 func_7750("ch_ghillie");
		}
	}

	if(issubstr(param_00.var_953E,"silencer"))
	{
		param_01 func_7750("ch_stealthvet");
	}
}

//Function Number: 32
func_209C(param_00)
{
	var_01 = param_00.var_721C;
	if(var_01.var_A869)
	{
		var_02 = var_01.var_12C["deaths"];
		var_03 = var_01.var_12C["kills"];
		var_04 = 1000000;
		if(var_02 > 0)
		{
			var_04 = var_03 / var_02;
		}

		if(var_04 >= 5 && var_03 >= 5)
		{
			var_01 func_7750("ch_starplayer");
		}

		if(var_02 == 0 && maps\mp\_utility::func_46E3() > 300000)
		{
			var_01 func_7750("ch_flawless");
		}

		if(level.var_7006["all"].size < 3)
		{
			return;
		}

		if(var_01.var_15C > 0)
		{
			switch(level.var_3FDC)
			{
				case "dm":
					if(param_00.var_7002 < 3)
					{
						var_01 func_7750("ch_victor_dm");
						var_01 func_7750("ch_ffa_win");
					}
	
					var_01 func_7750("ch_ffa_participate");
					break;

				case "war":
					if(param_00.var_AA42)
					{
						var_01 func_7750("ch_war_win");
					}
	
					var_01 func_7750("ch_war_participate");
					break;

				case "kc":
					if(param_00.var_AA42)
					{
						var_01 func_7750("ch_kc_win");
					}
	
					var_01 func_7750("ch_kc_participate");
					break;

				case "dd":
					if(param_00.var_AA42)
					{
						var_01 func_7750("ch_dd_win");
					}
	
					var_01 func_7750("ch_dd_participate");
					break;

				case "koth":
					if(param_00.var_AA42)
					{
						var_01 func_7750("ch_koth_win");
					}
	
					var_01 func_7750("ch_koth_participate");
					break;

				case "sab":
					if(param_00.var_AA42)
					{
						var_01 func_7750("ch_sab_win");
					}
	
					var_01 func_7750("ch_sab_participate");
					break;

				case "sd":
					if(param_00.var_AA42)
					{
						var_01 func_7750("ch_sd_win");
					}
	
					var_01 func_7750("ch_sd_participate");
					break;

				case "dom":
					if(param_00.var_AA42)
					{
						var_01 func_7750("ch_dom_win");
					}
	
					var_01 func_7750("ch_dom_participate");
					break;

				case "ctf":
					if(param_00.var_AA42)
					{
						var_01 func_7750("ch_ctf_win");
					}
	
					var_01 func_7750("ch_ctf_participate");
					break;

				case "tdef":
					if(param_00.var_AA42)
					{
						var_01 func_7750("ch_tdef_win");
					}
	
					var_01 func_7750("ch_tdef_participate");
					break;

				case "hp":
					if(param_00.var_AA42)
					{
						var_01 func_7750("ch_hp_win");
					}
					var_01 func_7750("ch_hp_participate");
					break;
			}
		}
	}
}

//Function Number: 33
func_209D(param_00)
{
	if(!param_00.var_AA42)
	{
		return;
	}

	var_01 = param_00.var_721C;
	if(var_01.var_A869)
	{
		switch(level.var_3FDC)
		{
			case "war":
				if(level.var_4B17)
				{
					var_01 func_7750("ch_teamplayer_hc");
					if(param_00.var_7002 == 0)
					{
						var_01 func_7750("ch_mvp_thc");
					}
				}
				else
				{
					var_01 func_7750("ch_teamplayer");
					if(param_00.var_7002 == 0)
					{
						var_01 func_7750("ch_mvp_tdm");
					}
				}
				break;

			case "sab":
				var_01 func_7750("ch_victor_sab");
				break;

			case "sd":
				var_01 func_7750("ch_victor_sd");
				break;

			case "hp":
			case "hc":
			case "dom":
			case "koth":
			case "dm":
			case "ctf":
				break;

			default:
				break;
		}
	}
}

//Function Number: 34
func_73CC(param_00,param_01,param_02,param_03,param_04,param_05)
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

	wait 0.05;
	maps\mp\_utility::func_A790();
	var_06 = spawnstruct();
	var_06.var_A490 = self;
	var_06.var_35A9 = param_00;
	var_06.var_1180 = param_01;
	var_06.var_502C = param_02;
	var_06.var_8CD7 = param_03;
	var_06.var_953E = param_04;
	var_06.var_8B0A = param_05;
	var_06.var_A494 = var_06.var_A490 isonground();
	if(isplayer(param_01))
	{
		var_06.var_118B = isdefined(var_06.var_1180.var_E8);
		var_06.var_1190 = var_06.var_1180 isonground();
		var_06.var_1199 = var_06.var_1180 getstance();
	}
	else
	{
		var_06.var_118B = 0;
		var_06.var_1190 = 0;
		var_06.var_1199 = "stand";
	}

	if(isdefined(self) && isdefined(param_01) && isdefined(self.var_1A7) && isdefined(param_01.var_1A7))
	{
		if(self.var_1A7 != param_01.var_1A7 && maps\mp\_utility::func_649("specialty_class_hunker") && isexplosivedamagemod(var_06.var_8CD7) && maps\mp\_utility::func_57A0(self) && !maps\mp\perks\_perks::func_3154(param_04))
		{
			func_7750("ch_explosives_hunker");
		}

		if(self.var_1A7 != param_01.var_1A7 && maps\mp\_utility::func_649("specialty_class_primed"))
		{
			self.var_5B8B = gettime();
		}
	}

	func_3217("playerDamaged",var_06);
}

//Function Number: 35
func_7417(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self.var_DDF = self getangles();
	if(isdefined(param_01))
	{
		param_01.var_DE0 = param_01 getangles();
	}

	self endon("disconnect");
	var_08 = spawnstruct();
	var_08.var_A490 = self;
	var_08.var_35A9 = param_00;
	var_08.var_1180 = param_01;
	var_08.var_502C = param_02;
	var_08.var_8CD7 = param_03;
	var_08.var_953E = param_04;
	var_08.var_912F = param_05;
	var_08.var_8B0A = param_06;
	var_08.var_99DA = gettime();
	var_08.var_62A1 = param_07;
	var_08.var_A494 = var_08.var_A490 isonground();
	if(isplayer(param_01))
	{
		var_08.var_118B = isdefined(var_08.var_1180.var_E8);
		var_08.var_1190 = var_08.var_1180 isonground();
		var_08.var_1199 = var_08.var_1180 getstance();
	}
	else
	{
		var_08.var_118B = 0;
		var_08.var_1190 = 0;
		var_08.var_1199 = "stand";
	}

	var_09 = 0;
	if(isdefined(var_08.var_35A9) && isdefined(var_08.var_35A9.var_3BE0))
	{
		var_09 = var_08.var_35A9.var_3BE0;
	}
	else if(isdefined(param_01) && isplayer(param_01))
	{
		var_09 = param_01 playerads();
	}

	var_08.var_A85F = 0;
	if(var_09 >= 0.2)
	{
		var_08.var_A85F = 1;
	}

	func_A685(var_08);
	if(isdefined(param_01) && maps\mp\_utility::func_57A0(param_01))
	{
		param_01.var_5A57[param_01.var_5A57.size] = var_08;
		param_01.recentkills = common_scripts\utility::func_F86(param_01.recentkills,var_08,0);
		if(!isdefined(level.recentkillers))
		{
			level.recentkillers = [];
		}

		level.recentkillers = common_scripts\utility::func_F86(level.recentkillers,param_01,0);
		if(level.recentkillers.size >= 4)
		{
			level.recentkillers = common_scripts\utility::func_FA3(level.recentkillers,0,4);
			var_0A = 0;
			foreach(var_0C in level.recentkillers)
			{
				if(var_0C == param_01)
				{
					var_0A++;
					continue;
				}

				break;
			}

			if(var_0A >= 4)
			{
				param_01 func_7750("ch_killer_feed");
				level.recentkillers = [];
			}
		}
	}

	var_08.var_1180 notify("playerKilledChallengesProcessed");
}

//Function Number: 36
func_A3F7(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	var_07.var_A2C8 = param_01;
	var_07.var_A490 = param_00;
	var_07.var_35A9 = param_02;
	var_07.var_1180 = param_03;
	var_07.var_502C = param_04;
	var_07.var_8CD7 = param_05;
	var_07.var_953E = param_06;
	var_07.var_99DA = gettime();
	func_3217("vehicleKilled",var_07);
}

//Function Number: 37
func_A685(param_00)
{
	if(isdefined(param_00.var_1180))
	{
		param_00.var_1180 endon("disconnect");
	}

	self.var_7757 = 1;
	wait 0.05;
	maps\mp\_utility::func_A790();
	func_3217("playerKilled",param_00);
	self.var_7757 = undefined;
}

//Function Number: 38
func_73B5()
{
	var_00 = spawnstruct();
	var_00.var_721C = self;
	func_3217("playerAssist",var_00);
}

//Function Number: 39
func_A20F(param_00)
{
	self endon("disconnect");
	wait 0.05;
	maps\mp\_utility::func_A790();
	var_01 = spawnstruct();
	var_01.var_721C = self;
	var_01.var_4B1F = param_00;
	func_3217("playerHardpoint",var_01);
}

//Function Number: 40
func_7F13()
{
	func_3217("roundBegin");
}

//Function Number: 41
func_7F15(param_00)
{
	var_01 = spawnstruct();
	if(level.var_984D)
	{
		var_02 = "allies";
		for(var_03 = 0;var_03 < level.var_7006[var_02].size;var_03++)
		{
			var_01.var_721C = level.var_7006[var_02][var_03];
			var_01.var_AA42 = var_02 == param_00;
			var_01.var_7002 = var_03;
			func_3217("roundEnd",var_01);
		}

		var_02 = "axis";
		for(var_03 = 0;var_03 < level.var_7006[var_02].size;var_03++)
		{
			var_01.var_721C = level.var_7006[var_02][var_03];
			var_01.var_AA42 = var_02 == param_00;
			var_01.var_7002 = var_03;
			func_3217("roundEnd",var_01);
		}

		return;
	}

	for(var_03 = 0;var_03 < level.var_7006["all"].size;var_03++)
	{
		var_01.var_721C = level.var_7006["all"][var_03];
		var_01.var_AA42 = isdefined(param_00) && isplayer(param_00) && var_01.var_721C == param_00;
		var_01.var_7002 = var_03;
		func_3217("roundEnd",var_01);
	}
}

//Function Number: 42
func_3217(param_00,param_01)
{
	if(!func_60B1())
	{
		return;
	}

	if(getdvarint("disable_challenges") > 0)
	{
		return;
	}

	if(!isdefined(level.var_6254[param_00]))
	{
		return;
	}

	if(isdefined(param_01))
	{
		for(var_02 = 0;var_02 < level.var_6254[param_00].size;var_02++)
		{
			thread [[ level.var_6254[param_00][var_02] ]](param_01);
		}

		return;
	}

	for(var_02 = 0;var_02 < level.var_6254[param_00].size;var_02++)
	{
		thread [[ level.var_6254[param_00][var_02] ]]();
	}
}

//Function Number: 43
func_638F()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(!isalive(self))
		{
			self waittill("spawned_player");
			continue;
		}

		if(!self isonground())
		{
			var_00 = self.var_116[2];
			while(!self isonground() && isalive(self))
			{
				if(self.var_116[2] > var_00)
				{
					var_00 = self.var_116[2];
				}

				wait 0.05;
			}

			var_01 = var_00 - self.var_116[2];
			if(var_01 < 0)
			{
				var_01 = 0;
			}

			if(var_01 / 12 > 15 && isalive(self) && maps\mp\_utility::func_56D7())
			{
				func_7750("ch_boot_shortcut");
			}

			if(var_01 / 12 > 30 && !isalive(self) && maps\mp\_utility::func_56D7())
			{
				func_7750("ch_boot_gravity");
			}
		}

		wait 0.05;
	}
}

//Function Number: 44
func_63C3()
{
	thread func_63AF("increment_melee_kills",15,"ch_precision_slice");
	thread func_63AF("increment_stuck_kills",5,"ch_precision_ticktick");
	thread func_63AF("increment_pistol_headshots",10,"ch_precision_pistoleer");
	thread func_63AF("increment_ar_headshots",5,"ch_precision_headhunt");
	thread func_63AF("increment_sharpshooter_kills",10,"ch_precision_sharpshoot");
	thread func_63AF("increment_oneshotgun_kills",10,"ch_precision_cqexpert");
	thread func_63AF("increment_duallethal_kills",5,"ch_precision_dangerclose");
	thread func_63AF("increment_lethaldouble_kills",3,"ch_lethals_firediscipline");
	thread func_63AF("increment_nemesis_kills",5,"ch_humiliation_archnemesis");
	thread func_63AF("increment_resupplylethal_kills",3,"ch_lethals_resourceful");
	thread monitortier2camomatchchallenges("increment_camo_multidestroy",5,"ch_camoT2_multidestroy_");
}

//Function Number: 45
func_63AF(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon("disconnect");
	if(!isdefined(game[param_02]))
	{
		game[param_02] = [];
	}

	if(!isdefined(game[param_02][self.var_48CA]))
	{
		game[param_02][self.var_48CA] = 0;
	}

	thread func_7CB9(param_02);
	for(;;)
	{
		self waittill(param_00,var_03);
		var_04 = game[param_02][self.var_48CA];
		var_04++;
		game[param_02][self.var_48CA] = var_04;
		if(var_04 == param_01)
		{
			if(isdefined(var_03) && issubstr(param_02,"ch_camoT2_"))
			{
				func_99C5(var_03,param_02);
				continue;
			}

			func_7750(param_02);
		}
	}
}

//Function Number: 46
monitortier2camomatchchallenges(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill(param_00,var_03);
		var_04 = param_02 + var_03;
		if(!isdefined(game[var_04]))
		{
			game[var_04] = [];
		}

		if(!isdefined(game[var_04][self.var_48CA]))
		{
			game[var_04][self.var_48CA] = 0;
			thread func_7CB9(var_04);
		}

		var_05 = game[var_04][self.var_48CA];
		var_05++;
		game[var_04][self.var_48CA] = var_05;
		if(var_05 == param_01)
		{
			func_99C5(var_03,param_02);
		}
	}
}

//Function Number: 47
func_7CB9(param_00)
{
	level endon("game_ended");
	self waittill("disconnect");
	if(isdefined(game[param_00][self.var_48CA]))
	{
		game[param_00][self.var_48CA] = undefined;
	}
}

//Function Number: 48
func_5BBD()
{
	if(!func_60B1())
	{
		return;
	}

	if(!self.var_A869)
	{
		return;
	}

	if(self.var_9857 > 0)
	{
		return;
	}

	func_7750("ch_lastmanstanding");
}

//Function Number: 49
func_6369()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = common_scripts\utility::func_A715("bomb_planted","bomb_defused");
		if(!isdefined(var_00))
		{
			continue;
		}

		if(var_00 == "bomb_planted")
		{
			func_7750("ch_saboteur");
			continue;
		}

		if(var_00 == "bomb_defused")
		{
			func_7750("ch_hero");
		}
	}
}

//Function Number: 50
func_63AB()
{
	for(;;)
	{
		self waittill("spawned_player");
		thread func_9520();
	}
}

//Function Number: 51
func_9520()
{
	self endon("death");
	self endon("disconnect");
	wait(300);
	if(isdefined(self))
	{
		func_7750("ch_survivalist");
	}
}

//Function Number: 52
func_63E5()
{
	self endon("disconnect");
	self.var_12C["airstrikeStreak"] = 0;
	self.var_12C["meleeKillStreak"] = 0;
	self.var_12C["shieldKillStreak"] = 0;
	thread func_63B3();
	for(;;)
	{
		self waittill("death");
		self.var_12C["airstrikeStreak"] = 0;
		self.var_12C["meleeKillStreak"] = 0;
		self.var_12C["shieldKillStreak"] = 0;
	}
}

//Function Number: 53
func_63B3()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = common_scripts\utility::func_A716("destroyed_explosive","begin_airstrike","destroyed_car","destroyed_car");
		func_63B4(var_00);
	}
}

//Function Number: 54
func_63B4(param_00)
{
	switch(param_00)
	{
		case "begin_airstrike":
			self.var_12C["airstrikeStreak"] = 0;
			break;

		case "destroyed_explosive":
			func_7750("ch_backdraft");
			break;

		case "destroyed_car":
			func_7750("ch_vandalism");
			break;

		case "crushed_enemy":
			func_7750("ch_heads_up");
			if(isdefined(self.var_3B4B))
			{
				func_7750("ch_droppincrates");
			}
			break;
	}
}

//Function Number: 55
func_4C1F()
{
	if(!isalive(self))
	{
		return;
	}

	if(!func_60B1())
	{
		return;
	}

	if(!maps\mp\_utility::func_7A69())
	{
		return;
	}

	if(isdefined(self.var_5B8D) && self.var_5B8D)
	{
		self.var_4C21++;
		if(self.var_4C21 >= 5 && maps\mp\_utility::func_649("specialty_class_remedy"))
		{
			func_7750("ch_dlc4_remedy");
		}
	}
}

//Function Number: 56
healthregeneratedbrinkofdeath()
{
	if(!isalive(self))
	{
		return;
	}

	if(!func_60B1())
	{
		return;
	}

	if(!maps\mp\_utility::func_7A69())
	{
		return;
	}

	thread func_7D53();
	if(isdefined(self.var_5B8D) && self.var_5B8D)
	{
		self.var_4C21++;
		if(self.var_4C21 >= 5)
		{
			func_7750("ch_invincible");
			if(maps\mp\_utility::func_649("specialty_class_remedy"))
			{
				func_7750("ch_dlc4_remedy");
				return;
			}
		}
	}
}

//Function Number: 57
func_7D53()
{
	self endon("disconnect");
	self endon("death");
	self endon("damage");
	wait(1);
	self.var_1C83 = 0;
}

//Function Number: 58
func_7463()
{
	self.var_1C83 = 0;
	self.var_4C21 = 0;
}

//Function Number: 59
func_73D3()
{
	self.var_1C83 = 0;
	self.var_4C21 = 0;
}

//Function Number: 60
func_5678()
{
	var_00 = self.var_BC / self.var_FB;
	return var_00 <= level.var_4C1D;
}

//Function Number: 61
func_7750(param_00,param_01,param_02)
{
	if(!func_60B1())
	{
		return;
	}

	if(level.var_744A.size < 2 && !getdvarint("850") && !getdvarint("5357") && !function_0367())
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

	if(!maps\mp\_utility::func_7A69())
	{
		return;
	}

	if(isdefined(level.var_20AA[param_00]) && isdefined(level.var_20AA[param_00]["requiresPrestige"]))
	{
		var_04 = level.var_20AA[param_00]["requiresPrestige"];
		if(var_04 != "")
		{
			if(maps\mp\gametypes\_rank::func_4639() < int(var_04))
			{
				return;
			}
		}
	}

	if(getdvarint("1258",0) == 1)
	{
		if(common_scripts\utility::func_9467(param_00,"ch_camo") || common_scripts\utility::func_9467(param_00,"ch_reticle"))
		{
			return;
		}
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_05 = func_4451(param_00);
	if(var_05 == 0)
	{
		return;
	}

	if(var_05 > level.var_20AA[param_00]["targetval"].size)
	{
		return;
	}

	var_06 = maps\mp\gametypes\_hud_util::func_2097(param_00);
	if(isdefined(param_02) && param_02)
	{
		var_07 = param_01;
	}
	else if(maps\mp\gametypes\_hud_util::func_5850(param_01))
	{
		var_07 = var_07;
	}
	else
	{
		var_07 = var_07 + param_02;
	}

	var_08 = 0;
	var_09 = level.var_20AA[param_00]["targetval"][var_05];
	while(isdefined(var_09) && var_07 >= var_09)
	{
		var_08++;
		var_09 = level.var_20AA[param_00]["targetval"][var_05 + var_08];
	}

	if(var_06 < var_07)
	{
		maps\mp\gametypes\_hud_util::func_209E(param_00,var_07);
	}

	if(var_08 > 0)
	{
		var_0A = var_05;
		while(var_08)
		{
			thread func_47B3(param_00,var_05);
			var_0B = function_02AD(param_00,var_05);
			var_0C = common_scripts\utility::func_9AAD(var_0B);
			var_0D = int(getsubstr(var_0C,0,var_0C.size - 2));
			if(!isdefined(game["challengeStruct"]["challengesCompleted"][self.var_48CA]))
			{
				game["challengeStruct"]["challengesCompleted"][self.var_48CA] = [];
			}

			var_0E = 0;
			foreach(var_10 in game["challengeStruct"]["challengesCompleted"][self.var_48CA])
			{
				if(var_10 == var_0D)
				{
					var_0E = 1;
				}
			}

			if(!var_0E)
			{
				game["challengeStruct"]["challengesCompleted"][self.var_48CA][game["challengeStruct"]["challengesCompleted"][self.var_48CA].size] = var_0D;
			}

			if(var_05 >= level.var_20AA[param_00]["targetval"].size && level.var_20AA[param_00]["parent_challenge"] != "")
			{
				func_7750(level.var_20AA[param_00]["parent_challenge"]);
			}

			var_05++;
			var_08--;
		}

		if(!issubstr(param_00,"ch_limited_bloodshed") && !issubstr(param_00,"ch_division_iconic_weapon") && !issubstr(param_00,"ch_hq_data"))
		{
			thread maps\mp\gametypes\_hud_message::func_20AB(param_00,var_0A,var_05);
		}

		maps\mp\gametypes\_hud_util::func_209F(param_00,var_05);
		self.var_20A9[param_00] = var_05;
	}
}

//Function Number: 62
func_47B3(param_00,param_01)
{
	self endon("disconnect");
	wait(0.25);
	maps\mp\gametypes\_rank::func_47B2("challenge",level.var_20AA[param_00]["reward"][param_01],undefined,undefined,param_00);
}

//Function Number: 63
func_6022(param_00)
{
	if(tablelookup("mp/allChallengesTable.csv",0,"ch_" + param_00 + "_mastery",1) == "")
	{
		return;
	}

	var_01 = 0;
	var_02 = maps\mp\_utility::func_4723(param_00);
	foreach(var_04 in var_02)
	{
		if(var_04 == "")
		{
			continue;
		}

		if(maps\mp\gametypes\_class::func_567C(param_00,var_04))
		{
			var_01++;
		}
	}

	func_7750("ch_" + param_00 + "_mastery",var_01,1);
}

//Function Number: 64
func_56A7(param_00,param_01)
{
	var_02 = tablelookupbyrow("mp/allChallengesTable.csv",param_01,8);
	if(var_02 != "")
	{
		var_03 = func_4451(var_02);
		if(var_03 > 1)
		{
			return 1;
		}
	}

	var_04 = tablelookupbyrow("mp/allChallengesTable.csv",param_01,6);
	if(var_04 != "")
	{
		var_05 = maps\mp\gametypes\_rank::func_4652();
		if(var_05 < int(var_04))
		{
			return 0;
		}
	}

	var_06 = tablelookupbyrow("mp/allChallengesTable.csv",param_01,7);
	if(var_06 != "")
	{
		var_07 = func_4451(var_06);
		if(var_07 <= level.var_20AA[var_06]["targetval"].size)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 65
func_A0F3()
{
	self.var_20A9 = [];
	if(!isdefined(self.var_20A1))
	{
		self.var_20A1 = [];
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

	if(!isdefined(self.var_12C["weaponPrestige"]))
	{
		self.var_12C["weaponPrestige"] = [];
	}

	self endon("disconnect");
	if(!func_60B1())
	{
		return;
	}

	if(!self method_85FD("challenges"))
	{
		return;
	}

	var_00 = 0;
	var_01 = getdvarint("spv_challenge_mastery_completion",0) == 1;
	foreach(var_06, var_03 in level.var_20AA)
	{
		var_00++;
		if(var_00 % 40 == 0)
		{
			wait 0.05;
		}

		if(function_0367() && !func_5680(var_06))
		{
			continue;
		}

		self.var_20A9[var_06] = 0;
		var_04 = var_03["index"];
		var_05 = maps\mp\gametypes\_hud_util::func_2098(var_06);
		if(maps\mp\gametypes\_hud_util::func_5807(var_06) && !isdefined(game["challengeStruct"]["limitedChallengesReset"][self.var_48CA]))
		{
			maps\mp\gametypes\_hud_util::func_209E(var_06,0);
			var_05 = 0;
		}

		if(var_05 == 0)
		{
			maps\mp\gametypes\_hud_util::func_209F(var_06,1);
			var_05 = 1;
		}

		self.var_20A9[var_06] = var_05;
		if(common_scripts\utility::func_562E(var_01) && issubstr(var_06,"_master"))
		{
			func_7750(var_06,0);
		}
	}

	game["challengeStruct"]["limitedChallengesReset"][self.var_48CA] = 1;
}

//Function Number: 66
func_5680(param_00)
{
	return tablelookup("mp/allChallengesTable.csv",0,param_00,44) != "";
}

//Function Number: 67
func_5732(param_00)
{
	return tablelookup("mp/unlockTable.csv",0,param_00,0) != "";
}

//Function Number: 68
func_444F(param_00)
{
	return tablelookup("mp/allChallengesTable.csv",0,param_00,5);
}

//Function Number: 69
func_4452(param_00)
{
	return tablelookup("mp/challengeTable.csv",8,param_00,4);
}

//Function Number: 70
func_46DE(param_00,param_01)
{
	return tablelookup(param_00,0,param_01,1);
}

//Function Number: 71
func_584F(param_00)
{
	if(isdefined(func_4732(param_00)))
	{
		return 1;
	}

	return 0;
}

//Function Number: 72
func_4732(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = func_444F(param_00);
	if(!isdefined(var_01))
	{
		return undefined;
	}

	var_02 = strtok(var_01,"_");
	if(var_02[0] == "challenge")
	{
		var_03 = undefined;
		for(var_04 = 1;var_04 < var_02.size;var_04++)
		{
			if(isdefined(var_03))
			{
				var_03 = var_03 + "_" + var_02[var_04];
				continue;
			}

			var_03 = var_02[var_04];
		}

		if(isdefined(var_03) && maps\mp\gametypes\_class::func_5835(var_03) || maps\mp\gametypes\_class::func_5839(var_03,0))
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 73
func_4724(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_01 = func_444F(param_00);
	if(!isdefined(var_01) || var_01 != "attachment")
	{
		return undefined;
	}

	var_02 = strtok(param_00,"_");
	if(var_02.size > 0)
	{
		var_03 = var_02[var_02.size - 1];
		if(isdefined(var_03) && maps\mp\_utility::func_5679(var_03))
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 74
func_573C(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_444F(param_00);
	if(isdefined(var_01) && var_01 == "killstreaks_assault" || var_01 == "killstreaks_support")
	{
		return 1;
	}

	return 0;
}

//Function Number: 75
func_453B(param_00)
{
	var_01 = "ch_";
	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	if(var_02 == "assault_streaks" || var_02 == "support_streaks")
	{
		var_02 = undefined;
	}

	return var_02;
}

//Function Number: 76
func_20A8(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,9 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 77
func_20A7(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,10 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 78
func_20A6(param_00,param_01)
{
	var_02 = tablelookup(param_00,0,param_01,42);
	if(!isdefined(var_02))
	{
		var_02 = "";
	}

	return var_02;
}

//Function Number: 79
func_1D42(param_00,param_01)
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

		if(issubstr(var_04,"ch_daily"))
		{
			continue;
		}

		var_05 = tablelookupbyrow(param_00,var_03,43);
		if(var_05 == "1")
		{
			continue;
		}

		level.var_20AA[var_04] = [];
		level.var_20AA[var_04]["index"] = var_03;
		level.var_20AA[var_04]["type"] = param_01;
		level.var_20AA[var_04]["targetval"] = [];
		level.var_20AA[var_04]["reward"] = [];
		level.var_20AA[var_04]["parent_challenge"] = "";
		level.var_20AA[var_04]["requiresPrestige"] = tablelookupbyrow("mp/allChallengesTable.csv",var_03,45);
		if(func_584F(var_04))
		{
			var_06 = func_4732(var_04);
			var_07 = func_4724(var_04);
			if(isdefined(var_06))
			{
				level.var_20AA[var_04]["weapon"] = var_06;
			}

			if(isdefined(var_07))
			{
				level.var_20AA[var_04]["attachment"] = var_07;
			}
		}
		else if(func_573C(var_04))
		{
			var_08 = func_453B(var_04);
			if(isdefined(var_08))
			{
				level.var_20AA[var_04]["killstreak"] = var_08;
			}
		}

		for(var_09 = 1;var_09 < 10;var_09++)
		{
			var_0A = func_20A8(param_00,var_04,var_09);
			var_0B = func_20A7(param_00,var_04,var_09);
			if(var_0A == 0)
			{
				break;
			}

			level.var_20AA[var_04]["targetval"][var_09] = var_0A;
			level.var_20AA[var_04]["reward"][var_09] = var_0B;
			var_02 = var_02 + var_0B;
		}

		level.var_20AA[var_04]["parent_challenge"] = func_20A6(param_00,var_04);
	}

	return int(var_02);
}

//Function Number: 80
func_1D41()
{
	level.var_20AA = [];
	if(getdvar("4017") == "1" && !function_0367())
	{
		return;
	}

	var_00 = 0;
	var_00 = var_00 + func_1D42("mp/allChallengesTable.csv",0);
	func_1D43();
}

//Function Number: 81
func_1D43()
{
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/dailychallengesTable.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		level.var_20AA[var_01] = [];
		level.var_20AA[var_01]["index"] = var_00;
		level.var_20AA[var_01]["type"] = 1;
		level.var_20AA[var_01]["targetval"] = [];
		level.var_20AA[var_01]["reward"] = [];
		level.var_20AA[var_01]["targetval"] = func_20A8("mp/dailychallengesTable.csv",var_01,1);
		level.var_20AA[var_01]["reward"] = func_20A7("mp/dailychallengesTable.csv",var_01,1);
		var_00++;
	}
}

//Function Number: 82
func_63CA()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		if(!func_60B1())
		{
			return;
		}

		self waittill("process",var_00);
		func_7750(var_00);
	}
}

//Function Number: 83
func_63A3()
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

		if(!isdefined(self.var_5A71))
		{
			continue;
		}

		if(var_00 == 9 && isdefined(self.var_5A71[7]) && isdefined(self.var_5A71[8]) && isdefined(self.var_5A71[9]))
		{
			func_7750("ch_6fears7");
		}

		if(var_00 == 10 && self.var_5A71.size == 0)
		{
			func_7750("ch_theloner");
		}
	}
}

//Function Number: 84
func_63A2()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		self waittill("destroyed_killstreak",var_00);
		if(isdefined(var_00) && var_00 == "stinger_mp")
		{
			func_7750("ch_marksman_stinger");
			func_7750("pr_marksman_stinger");
		}
	}
}

//Function Number: 85
func_4032(param_00,param_01)
{
	switch(param_00)
	{
		case "hijacker_airdrop":
			func_7750("ch_smoothcriminal");
			break;

		case "wargasm":
			func_7750("ch_wargasm");
			break;

		case "weapon_assault":
			func_7750("ch_surgical_assault");
			break;

		case "weapon_smg":
			func_7750("ch_surgical_smg");
			break;

		case "weapon_lmg":
			func_7750("ch_surgical_lmg");
			break;

		case "weapon_dmr":
			break;

		case "weapon_sniper":
			func_7750("ch_surgical_sniper");
			break;

		case "shield_damage":
			func_7750("ch_shield_damage",param_01);
			break;

		case "shield_bullet_hits":
			func_7750("ch_shield_bullet",param_01);
			break;

		case "shield_explosive_hits":
			func_7750("ch_shield_explosive",param_01);
			break;
	}
}

//Function Number: 86
func_73F4()
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

//Function Number: 87
func_6365()
{
	self endon("disconnect");
	self.var_A12 = 0;
	for(;;)
	{
		if(self playerads() == 1)
		{
			self.var_A12 = self.var_A12 + 0.05;
		}
		else
		{
			self.var_A12 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 88
func_63CB()
{
	self endon("disconnect");
	level endon("game_ended");
	self.var_777B = undefined;
	var_00 = 0;
	for(;;)
	{
		var_01 = self getstance();
		if(var_01 == "prone" && var_00 == 0)
		{
			self.var_777B = gettime();
			var_00 = 1;
		}
		else if(var_01 != "prone")
		{
			self.var_777B = undefined;
			var_00 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 89
func_639D()
{
	self endon("disconnect");
	self.var_4DEC = 0;
	for(;;)
	{
		self waittill("hold_breath");
		self.var_4DEC = 1;
		self waittill("release_breath");
		self.var_4DEC = 0;
	}
}

//Function Number: 90
func_63AE()
{
	self endon("disconnect");
	level endon("game_ended");
	self.var_5FD3 = 0;
	for(;;)
	{
		self waittill("jumped");
		var_00 = self getcurrentweapon();
		common_scripts\utility::func_A74B("weapon_change",1);
		var_01 = self getcurrentweapon();
		if(var_01 == "none")
		{
			self.var_5FD3 = 1;
		}
		else
		{
			self.var_5FD3 = 0;
		}

		if(self.var_5FD3)
		{
			if(self method_85FD("specialty_fastmantle") && maps\mp\_utility::func_649("specialty_fastmantle"))
			{
				func_7750("ch_fastmantle");
			}

			common_scripts\utility::func_A74B("weapon_change",1);
			var_01 = self getcurrentweapon();
			if(var_01 == var_00)
			{
				self.var_5FD3 = 0;
			}
		}
	}
}

//Function Number: 91
func_63FA()
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

		if(maps\mp\_utility::func_5740(var_01))
		{
			continue;
		}

		if(maps\mp\_utility::func_568F(var_01) || maps\mp\_utility::isuseweapon(var_01))
		{
			continue;
		}

		self.lastweaponswaptime = gettime();
		var_02 = function_01D4(var_01);
		if(var_02 != "primary")
		{
			continue;
		}

		self.var_5BD0 = gettime();
	}
}

//Function Number: 92
func_6395()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03);
		if(isdefined(var_03) && self == var_03)
		{
			continue;
		}

		self.var_5B9C = gettime();
	}
}

//Function Number: 93
func_6375()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("concussed",var_00);
		if(self == var_00)
		{
			continue;
		}

		self.var_5B86 = gettime();
	}
}

//Function Number: 94
func_63B2()
{
	self endon("disconnect");
	for(;;)
	{
		common_scripts\utility::knock_off_battery("triggered_mine","triggered_claymore");
		thread func_A68C();
	}
}

//Function Number: 95
func_A68C()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(level.var_2CE8 + 2);
	func_7750("ch_delaymine");
	if(maps\mp\_utility::func_649("specialty_class_flanker"))
	{
		thread func_7750("ch_operations_flanker");
	}
}

//Function Number: 96
func_55B0(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "frag_grenade_german_mp":
		case "semtex_mp":
		case "frag_grenade_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 97
ch_monitorkillerdoingwork(param_00)
{
	self endon("disconnect");
	self endon("death");
	self notify("monitorKillerDoingWork");
	self endon("monitorKillerDoingWork");
	self waittill("ch_capture",var_01);
	if(var_01 == param_00)
	{
		thread func_7750("ch_killer_doingwork");
	}
}

//Function Number: 98
func_18AC()
{
	if(!isdefined(self.var_18AE) || !isdefined(self.var_5A57) || self.var_5A57.size == 0)
	{
		self.var_18AE = 0;
	}

	self.var_18AE++;
	if(isdefined(self.var_18AE) && self.var_18AE == 5)
	{
		func_7750("ch_combathandling_bodycount");
		self.var_18AE = 0;
	}
}

//Function Number: 99
func_34C3()
{
	if(!isdefined(self.var_BA8) || !isdefined(self.var_5A57) || self.var_5A57.size == 0)
	{
		self.var_BA8 = 0;
	}

	self.var_BA8++;
	if(isdefined(self.var_BA8) && self.var_BA8 == 3)
	{
		func_7750("ch_combathandling_rungun");
		self.var_BA8 = 0;
	}
}

//Function Number: 100
func_80A0(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!param_04)
	{
		return;
	}

	if(issubstr(param_01,"aperture_sight") || issubstr(param_01,"telescopic") || issubstr(param_01,"lens_sight"))
	{
		var_09 = maps\mp\_utility::func_45B5(param_03);
		var_0A = undefined;
		if(issubstr(param_01,"aperture_sight"))
		{
			var_0A = "nydar";
		}
		else if(issubstr(param_01,"telescopic"))
		{
			var_0A = "optic";
		}
		else if(issubstr(param_01,"lens_sight"))
		{
			var_0A = "lens";
		}

		param_00 func_7750("ch_reticle_" + var_0A + "_kill_" + var_09);
		if(param_05)
		{
			param_00 func_99C5(var_09,"ch_reticle_" + var_0A + "_headshot_");
		}

		if(param_06)
		{
			param_00 func_99C5(var_09,"ch_reticle_" + var_0A + "_longshot_");
		}

		if(isdefined(param_00.recentkills) && param_00.recentkills.size >= 1)
		{
			var_0B = 1;
			for(var_0C = 0;var_0C < param_00.recentkills.size;var_0C++)
			{
				var_0D = maps\mp\_utility::func_45B5(param_00.recentkills[var_0C].var_953E);
				var_0E = issubstr(param_00.recentkills[var_0C].var_953E,param_01);
				if(param_00.recentkills[var_0C].var_A85F && var_0D == var_09 && var_0E)
				{
					var_0B++;
					continue;
				}

				break;
			}

			if(var_0B == 2)
			{
				param_00 func_99C5(var_09,"ch_reticle_" + var_0A + "_doublekill_");
			}
		}

		if(isdefined(param_00.var_5A57) && param_00.var_5A57.size >= 4)
		{
			var_0B = 1;
			foreach(var_10 in param_00.var_5A57)
			{
				var_0D = maps\mp\_utility::func_45B5(var_10.var_953E);
				var_0E = issubstr(var_10.var_953E,param_01);
				if(var_10.var_A85F && var_0D == var_09 && var_0E)
				{
					var_0B++;
				}
			}

			if(var_0B == 5)
			{
				param_00 func_99C5(var_09,"ch_reticle_" + var_0A + "_streaking_");
				return;
			}
		}
	}
}

//Function Number: 101
func_80BB(param_00,param_01)
{
	var_02 = maps\mp\_events::func_43D6(param_00,param_01);
	if(var_02 == "fighter_strike_kill" || var_02 == "fritzx_kill" || var_02 == "firebomb_kill" || var_02 == "airstrike_kill" || var_02 == "plane_gunner_kill")
	{
		func_7750("ch_streak_closeairsupport");
	}

	if(var_02 == "mortar_strike_kill" || var_02 == "missile_strike_kill")
	{
		func_7750("ch_streak_firesupport");
	}

	if(var_02 == "molotovs_kill" || var_02 == "flamethrower_kill")
	{
		func_7750("ch_streak_hotpoint");
	}
}

//Function Number: 102
func_0B9D()
{
	var_00 = isdefined(level.var_3CE0) && level.var_3CE0 == self;
	var_01 = 0;
	if(level.var_984D && isdefined(level.var_9FDA))
	{
		if(isdefined(level.var_9FDA))
		{
			foreach(var_03 in level.var_9FDA[self.var_1A7])
			{
				if(var_03.var_1C8 == "counter_uav" && isdefined(var_03.var_117) && var_03.var_117 == self)
				{
					var_01 = 1;
					break;
				}
			}
		}
	}
	else
	{
		var_05 = isdefined(level.var_2694) && level.var_2694 == self;
	}

	if(var_00 || var_01)
	{
		func_7750("ch_streak_airsuperiority");
	}
}