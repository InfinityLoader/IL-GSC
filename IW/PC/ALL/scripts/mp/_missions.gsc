/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_missions.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 219
 * Decompile Time: 8226 ms
 * Timestamp: 10/27/2023 12:21:02 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!func_B4E8())
	{
		return;
	}

	level.var_B8CD = [];
	func_DEFF("playerDamaged",::func_3BF5);
	func_DEFF("playerKilled",::func_3BFE);
	func_DEFF("playerKilled",::func_3C01);
	func_DEFF("playerUsedKillstreak",::func_3C02);
	func_DEFF("playerKillstreakActive",::func_3C00);
	func_DEFF("playerAssist",::func_3BF3);
	func_DEFF("roundEnd",::func_3C04);
	func_DEFF("roundEnd",::func_3C03);
	func_DEFF("vehicleKilled",::func_3C09);
	level thread func_C56E();
	level thread onroundended();
}

//Function Number: 2
onroundended()
{
	level waittill("game_ended");
	foreach(var_01 in level.players)
	{
		var_01.pers["killstreaksKilledByWeapon"] = var_01.var_A6B3;
		var_01.pers["killsPerWeapon"] = var_01.var_A681;
		var_01.pers["shotsLandedLMG"] = var_01.shotslandedlmg;
		var_01.pers["classicKills"] = var_01.classickills;
		var_01.pers["akimboKills"] = var_01.akimbokills;
		var_01.pers["hipfireMagKills"] = var_01.hipfiremagkills;
		var_01.pers["burstFireKills"] = var_01.burstfirekills;
	}
}

//Function Number: 3
func_823C(param_00)
{
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		var_02 = self getplayerdata("mp","weeklyChallengeId",var_01);
		var_03 = tablelookupbyrow("mp/weeklyChallengesTable.csv",var_02,0);
		if(var_03 == param_00)
		{
			return "ch_weekly_" + var_01;
		}
	}

	return "";
}

//Function Number: 4
func_7E57(param_00)
{
	for(var_01 = 0;var_01 < 3;var_01++)
	{
		var_02 = self getplayerdata("mp","dailyChallengeId",var_01);
		var_03 = tablelookupbyrow("mp/dailyChallengesTable.csv",var_02,0);
		if(var_03 == param_00)
		{
			return "ch_daily_" + var_01;
		}
	}

	return "";
}

//Function Number: 5
func_3BF8(param_00)
{
	if(!function_02D9("mp","Challenge",param_00))
	{
		return 0;
	}

	if(level.var_3C2C[param_00]["type"] == 0)
	{
		return self getplayerdata("mp","challengeProgress",param_00);
	}

	if(level.var_3C2C[param_00]["type"] == 1)
	{
		return self getplayerdata("mp","challengeProgress",func_7E57(param_00));
	}

	if(level.var_3C2C[param_00]["type"] == 2)
	{
		return self getplayerdata("mp","challengeProgress",func_823C(param_00));
	}
}

//Function Number: 6
func_3BF9(param_00)
{
	if(!function_02D9("mp","Challenge",param_00))
	{
		return 0;
	}

	if(level.var_3C2C[param_00]["type"] == 0)
	{
		return self getplayerdata("mp","challengeState",param_00);
	}

	if(level.var_3C2C[param_00]["type"] == 1)
	{
		return self getplayerdata("mp","challengeState",func_7E57(param_00));
	}

	if(level.var_3C2C[param_00]["type"] == 2)
	{
		return self getplayerdata("mp","challengeState",func_823C(param_00));
	}
}

//Function Number: 7
func_3C05(param_00,param_01)
{
	if(level.var_3C2C[param_00]["type"] == 0)
	{
		return self setplayerdata("mp","challengeProgress",param_00,param_01);
	}

	if(level.var_3C2C[param_00]["type"] == 1)
	{
		return self setplayerdata("mp","challengeProgress",func_7E57(param_00),param_01);
	}

	if(level.var_3C2C[param_00]["type"] == 2)
	{
		return self setplayerdata("mp","challengeProgress",func_823C(param_00),param_01);
	}
}

//Function Number: 8
func_3C06(param_00,param_01)
{
	if(level.var_3C2C[param_00]["type"] == 0)
	{
		return self setplayerdata("mp","challengeState",param_00,param_01);
	}

	if(level.var_3C2C[param_00]["type"] == 1)
	{
		return self setplayerdata("mp","challengeState",func_7E57(param_00),param_01);
	}

	if(level.var_3C2C[param_00]["type"] == 2)
	{
		return self setplayerdata("mp","challengeState",func_823C(param_00),param_01);
	}
}

//Function Number: 9
func_3BFA(param_00,param_01)
{
	if(level.var_3C2C[param_00]["type"] == 0)
	{
		return func_B029(param_00,param_01);
	}

	if(level.var_3C2C[param_00]["type"] == 1)
	{
		return int(tablelookup("mp/dailyChallengesTable.csv",0,param_00,9 + param_01 * 3));
	}

	if(level.var_3C2C[param_00]["type"] == 2)
	{
		return int(tablelookup("mp/weeklyChallengesTable.csv",0,param_00,9 + param_01 * 3));
	}
}

//Function Number: 10
func_10117(param_00,param_01)
{
	var_02 = undefined;
	var_02 = func_3BF9(param_00) - 1;
	var_03 = level.var_3C2C[param_00]["displayParam"];
	if(!isdefined(var_03))
	{
		var_03 = func_3BFA(param_00,var_02);
		if(var_03 == 0)
		{
			var_03 = 1;
		}

		var_04 = level.var_3C2C[param_00]["paramScale"];
		if(isdefined(var_04))
		{
			var_03 = int(var_03 / var_04);
		}
	}

	var_05 = undefined;
	if(scripts\mp\_utility::func_9FB3(param_01))
	{
		var_05 = int(min(var_02,scripts\mp\_hud_message::getsplashtablemaxaltdisplays()));
	}
	else
	{
		var_06 = func_2139(param_00);
		if(scripts\mp\_utility::func_9FB3(var_06))
		{
			var_05 = 1;
		}
	}

	thread scripts\mp\_hud_message::func_10151(param_00,var_03,undefined,var_05);
}

//Function Number: 11
func_B4E8()
{
	return level.rankedmatch;
}

//Function Number: 12
func_D3D6()
{
	if(!func_B4E8())
	{
		return 0;
	}

	if(level.players.size < 2)
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_DCD5())
	{
		return 0;
	}

	if(!isplayer(self) || isai(self))
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_A6B3 = var_00.pers["killstreaksKilledByWeapon"];
		var_00 thread func_989E();
		if(isai(var_00))
		{
			continue;
		}

		var_00 thread func_C57B();
		var_00 thread func_BA2A();
		var_00 thread func_B9C0();
		var_00 thread func_B9ED();
		var_00 thread func_BA24();
		var_00 thread func_B9BF();
		var_00 thread func_BA08();
		var_00 thread func_B9E9();
		var_00 thread func_B9E6();
		var_00 thread func_BA3B();
		var_00 thread func_B9DA();
		var_00 thread func_BA29();
		var_00 thread func_BA1F();
		var_00 thread func_B9CE();
		var_00 thread func_B9BA();
		var_00 thread func_B9DF();
		var_00 thread awardpostshipadjustedtargets();
		var_00 notifyonplayercommand("hold_breath","+breath_sprint");
		var_00 notifyonplayercommand("hold_breath","+melee_breath");
		var_00 notifyonplayercommand("release_breath","-breath_sprint");
		var_00 notifyonplayercommand("release_breath","-melee_breath");
		var_00 thread func_B9E0();
		var_00 notifyonplayercommand("jumped","+goStand");
		var_00 thread func_B9F0();
		if(isdefined(level.var_C978) && issubstr(var_00.name,level.var_C978))
		{
			var_00 setplayerdata("mp","challengeState","ch_infected",2);
			var_00 setplayerdata("mp","challengeProgress","ch_infected",1);
			var_00 setplayerdata("mp","challengeState","ch_plague",2);
			var_00 setplayerdata("mp","challengeProgress","ch_plague",1);
		}

		var_00 setplayerdata("common","round","weaponsUsed",0,"none");
		var_00 setplayerdata("common","round","weaponsUsed",1,"none");
		var_00 setplayerdata("common","round","weaponsUsed",2,"none");
		var_00 setplayerdata("common","round","weaponXpEarned",0,0);
		var_00 setplayerdata("common","round","weaponXpEarned",1,0);
		var_00 setplayerdata("common","round","weaponXpEarned",2,0);
		if(randomint(1001) == 1)
		{
			var_00 setplayerdata("mp","plagued",1);
		}

		if(var_00 func_3BF9("ch_solar_rig") == 1)
		{
			var_00 thread monitorblackskykills();
		}
	}
}

//Function Number: 14
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.var_A686 = [];
		self.var_110E5 = 0;
		self.var_D99C = 0;
		self.var_6A06 = [];
		self.var_69F2 = 0;
		self.var_1119A = [];
		self.var_110E6 = [];
		self.sixthsensesource = [];
		self.relaysource = [];
		self.var_13CB9 = [];
		thread func_BA1E();
		thread func_B9B4();
		thread func_BA33();
		thread func_B9D5();
		thread func_BA07();
		thread func_BA0B();
		thread func_B9B2();
		thread func_BA12();
		thread func_B9D4();
		thread func_B9EF();
	}
}

//Function Number: 15
monitorblackskykills()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("kill_event_buffered",var_00,var_01);
		if(!scripts\mp\_utility::func_9E6C(var_01))
		{
			if(!isdefined(self.pers[self.var_AE62 + "_kills"]))
			{
				self.pers[self.var_AE62 + "_kills"] = 1;
				continue;
			}

			self.pers[self.var_AE62 + "_kills"]++;
			if(isdefined(self.pers["archetype_assault_kills"]) && self.pers["archetype_assault_kills"] >= 5 && isdefined(self.pers["archetype_heavy_kills"]) && self.pers["archetype_heavy_kills"] >= 5 && isdefined(self.pers["archetype_scout_kills"]) && self.pers["archetype_scout_kills"] >= 5 && isdefined(self.pers["archetype_assassin_kills"]) && self.pers["archetype_assassin_kills"] >= 5 && isdefined(self.pers["archetype_engineer_kills"]) && self.pers["archetype_engineer_kills"] >= 5 && isdefined(self.pers["archetype_sniper_kills"]) && self.pers["archetype_sniper_kills"] >= 5)
			{
				func_D991("ch_uber_camo_rig");
			}
		}
	}
}

//Function Number: 16
monitorweaponpickup(param_00)
{
	if(scripts\mp\_utility::ispickedupweapon(param_00))
	{
		if(isdefined(self.var_13CB9) && !isdefined(self.var_13CB9[param_00]))
		{
			self.var_13CB9[param_00] = gettime();
		}
	}
}

//Function Number: 17
awardpostshipadjustedtargets()
{
	self endon("disconnect");
	self waittill("spawned_player");
	wait(20);
	checkpostshipadjustedchallenge("ch_heavy_ground_pound_kills");
	checkpostshipadjustedchallenge("ch_sniper_ballista_collateral");
	checkpostshipadjustedchallenge("ch_dd_wins");
	checkpostshipadjustedchallenge("ch_siege_wins");
	checkpostshipadjustedchallenge("ch_clutch_revives");
	checkpostshipadjustedchallenge("ch_perk_kills_tacresist");
	var_00 = self getplayerdata("mp","postShipFlags",1);
	if(var_00 == 0)
	{
		runonce_checkpostshiprigprogress();
		self setplayerdata("mp","postShipFlags",1,1);
	}
}

//Function Number: 18
checkpostshipadjustedchallenge(param_00)
{
	var_01 = func_7E22(param_00);
	var_02 = func_3BF8(param_00);
	var_03 = level.var_3C2C[param_00]["targetval"].size - 1;
	if(var_01 > var_03)
	{
		return;
	}

	var_04 = level.var_3C2C[param_00]["targetval"][var_01];
	while(var_02 >= var_04)
	{
		func_D991(param_00);
		var_01 = func_7E22(param_00);
		if(var_01 > var_03)
		{
			break;
		}

		var_04 = level.var_3C2C[param_00]["targetval"][var_01];
	}
}

//Function Number: 19
awardpostshipchallenge(param_00)
{
	var_01 = func_7E22(param_00);
	var_02 = level.var_3C2C[param_00]["targetval"].size - 1;
	if(var_01 > var_02)
	{
		return;
	}

	var_03 = level.var_3C2C[param_00]["targetval"][var_02];
	var_04 = level.var_3C2C[param_00]["targetval"][var_01];
	while(var_03 >= var_04)
	{
		func_D991(param_00);
		var_01 = func_7E22(param_00);
		if(var_01 > var_02)
		{
			break;
		}

		var_04 = level.var_3C2C[param_00]["targetval"][var_01];
	}
}

//Function Number: 20
runonce_checkpostshiprigprogress()
{
	var_00 = ["ch_gold_rig_assault_body","ch_gold_rig_assault_head","ch_gold_rig_heavy_body","ch_gold_rig_heavy_head","ch_gold_rig_scout_body","ch_gold_rig_scout_head","ch_gold_rig_assassin_body","ch_gold_rig_assassin_head","ch_gold_rig_engineer_body","ch_gold_rig_engineer_head","ch_gold_rig_sniper_body","ch_gold_rig_sniper_head","ch_diamond_rig_assault","ch_diamond_rig_heavy","ch_diamond_rig_scout","ch_diamond_rig_assassin","ch_diamond_rig_engineer","ch_diamond_rig_sniper","ch_solar_rig"];
	foreach(var_02 in var_00)
	{
		var_03 = func_3BF9(var_02);
		if(var_03 > 0)
		{
			thread func_839C(var_02,var_03);
			scripts\mp\_matchdata::func_AF99(var_02,var_03);
			func_110AE(var_02);
			func_8358(level.var_3C2C[var_02]["score"][var_03]);
			thread func_10117(var_02);
		}
	}
}

//Function Number: 21
func_BA12()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	var_00 = 0;
	for(;;)
	{
		self waittill("scavenger_pickup");
		func_D991("ch_perk_scavenger");
		if(!var_00)
		{
			var_01 = 0;
			var_02 = 0;
			var_03 = self getweaponslistprimaries();
			foreach(var_05 in var_03)
			{
				if(!scripts\mp\_utility::func_9D78(var_05) && !scripts\mp\_weapons::func_9F54(var_05))
				{
					continue;
				}

				var_02++;
				if(self getfractionmaxammo(var_05) < 1)
				{
					break;
				}

				var_01++;
			}

			if(var_02 > 0 && var_01 == var_02)
			{
				func_D991("ch_scavenger_full_ammo");
				var_00 = 1;
			}
		}
	}
}

//Function Number: 22
func_10DC7()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	thread func_B9E8();
	wait(5);
	self notify("stopMonitorKillsAfterAbilityActive");
}

//Function Number: 23
func_B9E8()
{
	self endon("stopMonitorKillsAfterAbilityActive");
	self endon("remove_super");
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	var_00 = undefined;
	if(isdefined(scripts\mp\_supers::func_7E4E()))
	{
		var_00 = scripts\mp\_supers::func_7E4F();
	}
	else
	{
		return;
	}

	for(;;)
	{
		self waittill("kill_event_buffered",var_01,var_02,var_03,var_04);
		switch(var_00)
		{
			case "super_rewind":
				func_D991("ch_ability_rewind");
				break;
	
			case "super_teleport":
				func_D991("ch_ability_teleport");
				break;
	
			case "super_phaseshift":
				func_D991("ch_ability_phase_shift");
				break;
		}
	}
}

//Function Number: 24
func_D98A(param_00)
{
	if(param_00.var_250D)
	{
		switch(param_00.var_24E8)
		{
			default:
				break;

			case "super_amplify":
				func_D991("ch_ability_amplify");
				break;

			case "super_overdrive":
				func_D991("ch_ability_overdrive");
				break;

			case "super_chargemode":
				func_D991("ch_ability_bull_charge");
				break;

			case "super_armorup":
				func_D991("ch_ability_reactive_armor");
				break;

			case "super_reaper":
				func_D991("ch_ability_reaper");
				break;
		}
	}

	if(scripts\mp\_utility::func_9FB3(param_00.attackervisionpulsedvictim))
	{
		func_D991("ch_ability_pulsar");
	}

	if(scripts\mp\_utility::func_9FB3(param_00.attackerhassupertrophyout))
	{
		func_D991("ch_ability_centurion");
	}

	if(isdefined(param_00.var_11329) && param_00.var_11329 == "micro_turret_gun_mp")
	{
		func_D991("ch_ability_micro_turret");
	}

	if(isdefined(param_00.var_B930) && isdefined(self.var_B930["super_kill_medal"]) && self.var_B930["super_kill_medal"] == "super_invisible")
	{
		func_D991("ch_ability_active_camo");
	}
}

//Function Number: 25
func_B9C2()
{
	self endon("bounceKillCancel");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("bounceKillVerify");
		func_D991("ch_darkops_bounce");
	}
}

//Function Number: 26
func_BA36()
{
	self endon("tripleStopCancel");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("tripleStopVerify");
		if(self.var_127D0 == 3)
		{
			func_D991("ch_darkops_slidestop");
			self.var_127D0 = undefined;
			break;
		}
	}
}

//Function Number: 27
func_D998(param_00,param_01,param_02)
{
	if(param_00.team != self.team && param_01 == "drone_hive_projectile_mp" || param_01 == "switch_blade_child_mp")
	{
		var_03 = 0;
		var_04 = 0;
		foreach(var_06 in level.players)
		{
			if(!isdefined(var_06.team))
			{
				continue;
			}

			if(!scripts\mp\_utility::func_9F19(var_06))
			{
				continue;
			}

			if(var_06.team == self.team)
			{
				var_07 = scripts\mp\_domeshield::func_7E80(var_06);
				if(!isdefined(var_07))
				{
					continue;
				}

				var_08 = var_07.var_58EF;
				if(!isdefined(var_08))
				{
					continue;
				}

				if(var_08 == param_02)
				{
					if(var_06 == self)
					{
						var_04 = 1;
						continue;
					}

					var_03++;
				}
			}
		}

		if(var_04 && var_03 > 1)
		{
			func_D991("ch_darkops_chrome");
		}
	}
}

//Function Number: 28
func_D997(param_00)
{
	func_D9AF(param_00);
}

//Function Number: 29
func_D996(param_00)
{
	if(isdefined(param_00.var_94B7))
	{
		if(param_00.var_94B7)
		{
			func_D991("ch_darkops_howthe");
		}
	}

	if(scripts\common\utility::func_9D74(param_00.var_10367) && param_00.var_24E3 == 0 && !scripts\mp\_utility::func_9E6C(param_00.var_11329))
	{
		if(isdefined(self.var_127D0))
		{
			self.var_127D0++;
			self notify("tripleStopVerify");
		}
		else
		{
			self.var_127D0 = 1;
			thread func_BA36();
		}
	}
	else
	{
		self.var_127D0 = undefined;
		self notify("tripleStopCancel");
	}

	if(isdefined(param_00.var_B930["headshot"]) && param_00.var_92BE & level.var_92C6)
	{
		if(isdefined(self.var_2F04))
		{
			self notify("bounceKillVerify");
		}
		else
		{
			thread func_B9C2();
			self.var_2F04 = 1;
		}
	}
	else
	{
		self notify("bounceKillCancel");
		self.var_2F04 = undefined;
	}

	if(isdefined(param_00.var_1337C) && isdefined(param_00.var_1337A) && isdefined(param_00.var_250D) && isdefined(param_00.var_24E8))
	{
		if(param_00.var_1337C && param_00.var_250D && param_00.var_1337A == "super_phaseshift" && param_00.var_24E8 == "super_phaseshift")
		{
			func_D991("ch_darkops_phase");
		}
	}

	if(isdefined(param_00.var_11329))
	{
		var_01 = scripts\mp\_utility::func_8234(param_00.var_11329);
		if(var_01 == "iw7_revolver" && scripts\mp\_utility::func_13C90(param_00.var_11329,"akimbo") && scripts\mp\_utility::func_13C90(param_00.var_11329,"fastaim") && scripts\mp\_weapons::func_13C98(param_00.var_11329))
		{
			func_D991("ch_darkops_no_idea");
		}
	}
}

//Function Number: 30
processrigkillchallengesonkill_delayed(param_00)
{
	param_00.var_4F func_D991("ch_" + param_00.attackerarchetype + "_kills");
	if(isdefined(param_00.attackerkillsthislife) && func_9EBC(param_00.attackerkillsthislife,3))
	{
		param_00.var_4F func_D991("ch_" + param_00.attackerarchetype + "_3streak");
	}

	if(isdefined(param_00.var_2504))
	{
		if(func_9EBC(param_00.var_2504,2))
		{
			param_00.var_4F func_D991("ch_" + param_00.attackerarchetype + "_2multikill");
			if(isdefined(param_00.var_2506) && param_00.var_2506 == "specialty_boom")
			{
				param_00.var_4F func_D991("ch_assault_ping_2multi");
			}
		}
	}

	if(isdefined(param_00.var_2506) && param_00.var_2506 == "specialty_scavenger_eqp")
	{
		var_01 = scripts\mp\_utility::func_7E9D(param_00.var_11329);
		if(isdefined(var_01) && var_01 == "lethal")
		{
			param_00.var_4F func_D991("ch_assault_resupply_lethal_kills");
		}
	}

	if(isdefined(param_00.var_2506) && param_00.var_2506 == "specialty_rugged_eqp")
	{
		if(scripts\mp\_utility::func_9FB3(param_00.wasplantedmine))
		{
			param_00.var_4F func_D991("ch_engineer_hardened_kill");
		}
	}

	if(isdefined(param_00.var_11329) && param_00.var_11329 == "iw7_reaperblade_mp" && isdefined(param_00.var_24F3[param_00.var_11329]) && func_9EBC(param_00.var_24F3[param_00.var_11329],4))
	{
		param_00.var_4F func_D991("ch_scout_reaper_4multi");
	}

	if(isdefined(param_00.var_2506) && param_00.var_2506 == "specialty_ftlslide" && param_00.var_24EF && scripts\mp\_utility::func_9FB3(param_00.var_B930["slidekill"]))
	{
		param_00.var_4F func_D991("ch_assassin_ads_slide_kill");
	}

	if(isdefined(param_00.attackersixthsensesource) && scripts\mp\_utility::func_9FB3(param_00.attackersixthsensesource[param_00.victimid]))
	{
		param_00.var_4F func_D991("ch_assassin_perception_revenge");
	}

	if(isdefined(param_00.attackerrelaysource) && scripts\mp\_utility::func_9FB3(param_00.attackerrelaysource[param_00.victimid]))
	{
		param_00.var_4F func_D991("ch_engineer_relay_kill");
	}

	if(isdefined(param_00.var_2506) && param_00.var_2506 == "specialty_rearguard")
	{
		if(isdefined(param_00.attackerrearguardattackers) && isdefined(param_00.attackerrearguardattackers[param_00.victimid]))
		{
			param_00.var_4F func_D991("ch_sniper_rearguard_kill");
		}
	}
}

//Function Number: 31
func_D9A8(param_00)
{
	if(!isdefined(param_00.var_B930["superShutdown"]))
	{
		return;
	}

	switch(param_00.var_B930["superShutdown"])
	{
		case "super_claw":
			func_D991("ch_killjoy_assault_weapon");
			break;

		case "super_steeldragon":
			func_D991("ch_killjoy_armor_weapon");
			break;

		case "super_armmgs":
			func_D991("ch_killjoy_synaptic_weapon");
			break;

		case "super_atomizer":
			func_D991("ch_killjoy_ftl_weapon");
			break;

		case "super_blackholegun":
			func_D991("ch_killjoy_six_weapon");
			break;

		case "super_penetrationrailgun":
			func_D991("ch_killjoy_ghost_weapon");
			break;

		case "super_overdrive":
		case "super_amplify":
			func_D991("ch_killjoy_assault_ability");
			break;

		case "super_armorup":
		case "super_chargemode":
			func_D991("ch_killjoy_armor_ability");
			break;

		case "super_reaper":
		case "super_rewind":
			func_D991("ch_killjoy_synaptic_ability");
			break;

		case "super_phaseshift":
		case "super_teleport":
			func_D991("ch_killjoy_ftl_ability");
			break;

		case "super_visionpulse":
		case "super_invisible":
			func_D991("ch_killjoy_ghost_ability");
			break;
	}
}

//Function Number: 32
func_D995()
{
	if(self method_8446())
	{
		func_D991("ch_darkops_epic_run");
		return;
	}

	if(self method_81BE())
	{
		func_D991("ch_darkops_epic_slide");
	}
}

//Function Number: 33
func_D9B1(param_00)
{
	if(param_00 getplayerdata("mp","plagued"))
	{
		self setplayerdata("mp","plagued",1);
		func_D991("ch_darkops_plague");
	}
}

//Function Number: 34
func_D9BE(param_00)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	if(isdefined(param_00.var_86BD))
	{
		self endon("killedPlayer" + param_00.var_86BD);
	}

	wait(60);
	func_D991("ch_darkops_warchief");
}

//Function Number: 35
func_D9AF(param_00)
{
	foreach(var_02 in level.players)
	{
		if(!isdefined(var_02.team))
		{
			continue;
		}

		if(var_02.team != param_00.team)
		{
			if(!isdefined(var_02.var_114ED))
			{
				var_02.var_114ED = [];
			}

			var_02.var_114ED[param_00.var_86BD] = [];
		}
	}
}

//Function Number: 36
func_D9B7(param_00,param_01,param_02)
{
	if(!isdefined(self.var_114ED))
	{
		self.var_114ED = [];
	}

	if(self.team == param_00.team)
	{
		return;
	}

	if(param_00.health - param_02 > 0)
	{
		if(!isdefined(self.var_114ED[param_00.var_86BD]))
		{
			self.var_114ED[param_00.var_86BD] = [];
		}

		var_03 = getweaponbasename(param_01);
		if(!isdefined(self.var_114ED[param_00.var_86BD][var_03]))
		{
			self.var_114ED[param_00.var_86BD][var_03] = 1;
			if(self.var_114ED[param_00.var_86BD].size == 4)
			{
				func_D991("ch_darkops_chimp");
				return;
			}
		}
	}
}

//Function Number: 37
func_D9BB(param_00)
{
	if(!isdefined(param_00.var_2506))
	{
		return;
	}

	switch(param_00.var_2506)
	{
		default:
			break;

		case "specialty_man_at_arms":
			func_D991("ch_trait_man_at_arms");
			break;

		case "specialty_rush":
			func_D991("ch_trait_momentum");
			break;

		case "specialty_afterburner":
			func_D991("ch_trait_rushdown");
			break;

		case "specialty_rearguard":
			func_D991("ch_trait_perch");
			break;
	}

	if(isdefined(param_00.var_11329))
	{
		if(param_00.var_11329 == "groundpound_mp")
		{
			func_D991("ch_heavy_ground_pound_kills");
		}

		if(param_00.var_11329 == "thruster_mp")
		{
			func_D991("ch_scout_afterburner_kill");
		}
	}
}

//Function Number: 38
monitorsuperscoreearned()
{
	self endon("disconnect");
	self endon("super_use_finished");
	self endon("death");
	level endon("game_ended");
	self notify("monitorSuperScoreEarned");
	self endon("monitorSuperScoreEarned");
	if(level.gametype == "dm")
	{
		var_00 = self.pers["gamemodeScore"] + 500;
	}
	else
	{
		var_00 = self.var_278 + 500;
	}

	var_01 = 0;
	for(;;)
	{
		if(level.gametype == "dm")
		{
			var_02 = self.pers["gamemodeScore"];
		}
		else
		{
			var_02 = self.var_278;
		}

		if(var_02 >= var_00)
		{
			var_00 = var_00 + 500;
			func_D991("ch_assault_amplify_score");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 39
func_BA2B()
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("monitorSuperWeaponKills");
	self endon("monitorSuperWeaponKills");
	for(;;)
	{
		self waittill("super_weapon_kill",var_00);
		var_01 = int(self.var_112A8 / 3);
		self.var_112A8 = self.var_112A8 % 3;
		while(var_01 > 0)
		{
			var_01--;
			var_00 = scripts\mp\_utility::func_821D(var_00);
			switch(var_00)
			{
				case "iw7_claw_mp":
					func_D991("ch_super_streak_assault");
					break;
	
				case "iw7_steeldragon_mp":
					func_D991("ch_super_streak_armor");
					break;
	
				case "iw7_armmgs_mp":
					func_D991("ch_super_streak_synaptic");
					break;
	
				case "iw7_atomizer_mp":
					func_D991("ch_super_streak_ftl");
					break;
	
				case "iw7_blackholegun_mp":
					func_D991("ch_super_streak_six");
					break;
	
				case "iw7_penetrationrail_mp":
					func_D991("ch_super_streak_ghost");
					break;
			}
		}
	}
}

//Function Number: 40
updatesuperkills(param_00,param_01,param_02)
{
	if(!isdefined(param_00) || !isdefined(param_02))
	{
		return;
	}

	switch(param_00)
	{
		case "super_overdrive":
			if(func_9EBC(param_02,2))
			{
				func_D991("ch_assault_overdrive_2multi");
			}
			break;

		case "super_chargemode":
			if(func_9EBC(param_02,2))
			{
				func_D991("ch_heavy_bullcharge_multi");
			}
			break;

		case "super_teleport":
			if(param_01 == "MOD_MELEE")
			{
				func_D991("ch_assassin_jump_melee");
			}
			break;

		case "super_invisible":
			if(param_01 == "MOD_MELEE")
			{
				func_D991("ch_sniper_camo_melee");
			}
			break;

		case "super_visionpulse":
			if(func_9EBC(param_02,2))
			{
				func_D991("ch_sniper_pulsar_2multi");
			}
			break;
	}
}

//Function Number: 41
func_12F33(param_00,param_01)
{
	if(!isdefined(self.var_112A8))
	{
		return;
	}
	else
	{
		self.var_112A8++;
	}

	self notify("super_weapon_kill",param_00);
	param_00 = scripts\mp\_utility::func_821D(param_00);
	switch(param_00)
	{
		case "iw7_claw_mp":
			func_D991("ch_super_weapon_assault");
			break;

		case "iw7_steeldragon_mp":
			func_D991("ch_super_weapon_armor");
			break;

		case "iw7_armmgs_mp":
			func_D991("ch_super_weapon_synaptic");
			break;

		case "iw7_atomizer_mp":
			func_D991("ch_super_weapon_ftl");
			break;

		case "iw7_blackholegun_mp":
			func_D991("ch_super_weapon_six");
			if(isdefined(param_01))
			{
				if(!isdefined(param_01.var_1AB))
				{
					param_01.var_1AB = 1;
				}
				else
				{
					param_01.var_1AB++;
				}
	
				if(func_9EBC(param_01.var_1AB,2))
				{
					func_D991("ch_engineer_bhgun_3multi");
				}
			}
			break;

		case "iw7_penetrationrail_mp":
			func_D991("ch_super_weapon_ghost");
			break;
	}
}

//Function Number: 42
func_BA2A()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("super_use_started");
		var_00 = scripts\mp\_supers::func_7E4F();
		if(isdefined(var_00) && var_00 == "super_phaseshift" && self.health < self.maxhealth)
		{
			func_D991("ch_assassin_damaged_phase_shift");
		}

		if(isdefined(var_00) && var_00 == "super_amplify")
		{
			thread monitorsuperscoreearned();
		}

		self.var_112A8 = 0;
		thread func_BA2B();
		thread func_10DC7();
	}
}

//Function Number: 43
func_B9DF()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("healed");
		if(isdefined(self.var_11B2C) && self.var_11B2C == "specialty_regenfaster")
		{
			func_D991("ch_heavy_icu_heals");
		}
	}
}

//Function Number: 44
func_BA24()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("received_earned_killstreak");
		if(func_66B8("specialty_hardline"))
		{
			func_D991("ch_perk_hardline");
		}

		wait(0.05);
	}
}

//Function Number: 45
func_B9BF()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("survived_explosion",var_00);
		if(isdefined(var_00) && isplayer(var_00) && self == var_00)
		{
			continue;
		}

		if(self isitemunlocked("specialty_blastshield","perk") && scripts\mp\_utility::_hasperk("specialty_blastshield"))
		{
			func_D992("ch_blastshield");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 46
func_989E()
{
	self.var_6A00 = [];
	if(!isdefined(self.var_A681))
	{
		self.var_A681 = self.pers["killsPerWeapon"];
		if(!isdefined(self.var_A681))
		{
			self.var_A681 = [];
		}
	}

	if(!isdefined(self.shotslandedlmg))
	{
		self.shotslandedlmg = self.pers["shotsLandedLMG"];
		if(!isdefined(self.shotslandedlmg))
		{
			self.shotslandedlmg = 0;
		}
	}

	if(!isdefined(self.classickills))
	{
		self.classickills = self.pers["classicKills"];
		if(!isdefined(self.classickills))
		{
			self.classickills = 0;
		}
	}

	if(!isdefined(self.akimbokills))
	{
		self.akimbokills = self.pers["akimboKills"];
		if(!isdefined(self.akimbokills))
		{
			self.akimbokills = 0;
		}
	}

	if(!isdefined(self.hipfiremagkills))
	{
		self.hipfiremagkills = self.pers["hipfireMagKills"];
		if(!isdefined(self.hipfiremagkills))
		{
			self.hipfiremagkills = 0;
		}
	}

	if(!isdefined(self.burstfirekills))
	{
		self.burstfirekills = self.pers["burstFireKills"];
		if(!isdefined(self.burstfirekills))
		{
			self.burstfirekills = 0;
		}
	}
}

//Function Number: 47
func_DEFF(param_00,param_01)
{
	if(!isdefined(level.var_B8CD[param_00]))
	{
		level.var_B8CD[param_00] = [];
	}

	level.var_B8CD[param_00][level.var_B8CD[param_00].size] = param_01;
}

//Function Number: 48
func_7E22(param_00)
{
	if(isdefined(self.var_3C2A[param_00]))
	{
		return self.var_3C2A[param_00];
	}

	return 0;
}

//Function Number: 49
func_3BF3(param_00)
{
	var_01 = param_00.player;
	if(isdefined(param_00.var_11329) && scripts\mp\_utility::func_9E6C(param_00.var_11329))
	{
		var_01 func_D991("ch_lifetime_streak_assists");
	}
}

//Function Number: 50
func_3C02(param_00)
{
	var_01 = param_00.player;
	var_01 func_D991("ch_lifetime_streaks_used");
}

//Function Number: 51
func_3C00(param_00)
{
	var_01 = param_00.player;
	var_02 = 0;
	var_03 = 0;
	foreach(var_05 in level.var_1655)
	{
		if(var_05.var_222 == var_01)
		{
			if(var_05.var_110EA == "sentry_shock")
			{
				var_02++;
				if(var_02 == 2)
				{
					var_01 func_D991("ch_two_sentries");
				}
			}

			continue;
		}

		if(var_05.var_110EA == "uav" || var_05.var_110EA == "directional_uav")
		{
			var_03 = 1;
		}
	}

	if(var_03 && param_00.var_A6A7 == "counter_uav")
	{
		var_01 func_D991("ch_counter_other_uav");
	}

	if(param_00.var_A6A7 == "jammer")
	{
	}
}

//Function Number: 52
func_3C01(param_00)
{
	if(!isdefined(param_00.var_4F) || !isplayer(param_00.var_4F))
	{
		return;
	}

	if(!isdefined(param_00.var_11329) || !scripts\mp\_utility::func_9E6C(param_00.var_11329))
	{
		return;
	}

	var_01 = param_00.var_4F;
	var_02 = func_7F48(param_00.var_11329);
	switch(var_02)
	{
		case "sentry_shock":
			var_01 func_D991("ch_scorestreak_kills_sentry");
			break;

		case "ball_drone_backup":
			var_01 func_D991("ch_scorestreak_kills_vulture");
			break;

		case "drone_hive":
			var_01 func_D991("ch_scorestreak_kills_trinity");
			break;

		case "precision_airstrike":
			var_01 func_D991("ch_scorestreak_kills_airstrike");
			break;

		case "minijackal":
			var_01 func_D991("ch_scorestreak_kills_apex");
			break;

		case "thor":
			var_01 func_D991("ch_scorestreak_kills_thor");
			break;

		case "bombardment":
			var_01 func_D991("ch_scorestreak_kills_bombardment");
			break;

		case "remote_c8":
			if(isdefined(var_01.var_4BE1) && var_01.var_4BE1 == "MANUAL")
			{
				var_01 func_D991("ch_rc8_controlled_kills");
			}
	
			var_01 func_D991("ch_scorestreak_kills_rc8");
			break;

		case "venom":
			var_01 func_D991("ch_scorestreak_kills_scarab");
			break;

		case "jackal":
			var_01 func_D991("ch_scorestreak_kills_warden");
			break;
	}

	var_01 func_D991("ch_lifetime_streak_kills");
}

//Function Number: 53
func_7F48(param_00)
{
	if(isdefined(level.var_A6C5[param_00]))
	{
		return level.var_A6C5[param_00];
	}

	return undefined;
}

//Function Number: 54
func_9E4B(param_00)
{
	var_01 = 0;
	switch(level.gametype)
	{
		case "sd":
		case "dd":
		case "sr":
			foreach(var_03 in level.var_2C7A)
			{
				var_04 = distancesquared(var_03.trigger.origin,param_00);
				if(var_04 < 90000)
				{
					var_01 = 1;
					break;
				}
			}
			break;

		case "dom":
			foreach(var_03 in level.var_C2A8)
			{
				var_04 = distancesquared(var_03.origin,param_00);
				if(var_04 < 90000)
				{
					var_01 = 1;
					break;
				}
			}
			break;

		case "siege":
			foreach(var_03 in level.var_134)
			{
				var_04 = distancesquared(var_03.origin,param_00);
				if(var_04 < 90000)
				{
					var_01 = 1;
					break;
				}
			}
			break;

		case "grind":
			foreach(var_03 in level.var_13FC1)
			{
				var_04 = distancesquared(var_03.origin,param_00);
				if(var_04 < 90000)
				{
					var_01 = 1;
					break;
				}
			}
			break;

		case "grnd":
		case "koth":
			var_01 = function_010F(param_00,level.var_13FB0.var_767B.trigger);
			break;
	}

	return var_01;
}

//Function Number: 55
func_9DBA(param_00)
{
	var_01 = 0;
	switch(level.gametype)
	{
		case "sd":
		case "dd":
		case "sr":
			if(self.team != game["defenders"])
			{
				break;
			}
	
			foreach(var_03 in level.var_2C7A)
			{
				var_04 = distancesquared(var_03.trigger.origin,param_00);
				if(var_04 < 90000)
				{
					var_01 = 1;
					break;
				}
			}
			break;

		case "dom":
			foreach(var_03 in level.var_5913)
			{
				if(self.team != var_03 scripts\mp\_gameobjects::func_803E())
				{
					continue;
				}
	
				var_04 = distancesquared(var_03.var_4B2C,param_00);
				if(var_04 < 90000)
				{
					var_01 = 1;
					break;
				}
			}
			break;

		case "siege":
			foreach(var_03 in level.var_5913)
			{
				if(self.team != var_03 scripts\mp\_gameobjects::func_803E())
				{
					continue;
				}
	
				var_04 = distancesquared(var_03.var_4B2C,param_00);
				if(var_04 < 90000)
				{
					var_01 = 1;
					break;
				}
			}
			break;

		case "grind":
			break;

		case "koth":
			var_01 = function_010F(self.origin,level.var_13FB0.var_767B.trigger) || function_010F(param_00,level.var_13FB0.var_767B.trigger);
			break;
	}

	return var_01;
}

//Function Number: 56
func_D9BC(param_00,param_01)
{
	switch(param_01)
	{
		case "uav":
			param_00 func_D991("ch_scorestreak_assists_uav");
			break;

		case "counter_uav":
			param_00 func_D991("ch_scorestreak_assists_cuav");
			break;

		case "directional_uav":
			param_00 func_D991("ch_scorestreak_assists_auav");
			break;
	}

	param_00 func_D991("ch_lifetime_streak_assists");
}

//Function Number: 57
func_3C09(param_00)
{
	if(!isdefined(param_00.var_4F) || !isplayer(param_00.var_4F))
	{
		return;
	}

	var_01 = param_00.var_4F;
}

//Function Number: 58
func_D98F(param_00)
{
	switch(param_00)
	{
		case "quad_feed":
			func_D991("ch_quad_feed");
			break;

		case "one_shot_two_kills":
			func_D991("ch_collateral");
			break;

		case "first_place_kill":
			func_D991("ch_kill_1st_place");
			break;

		case "gun_butt":
			func_D991("ch_gun_butt");
			break;

		case "backfire":
			func_D991("ch_owner_kill");
			break;

		case "item_impact":
			func_D991("ch_direct_impact");
			break;
	}

	if((param_00 == "longshot" && self.var_26D9["longshot"] == 1 && isdefined(self.var_26D9["pointblank"])) || param_00 == "pointblank" && self.var_26D9["pointblank"] == 1 && isdefined(self.var_26D9["longshot"]))
	{
		func_D991("ch_longshot_pointblank");
	}
}

//Function Number: 59
func_3BF6(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = self;
	if(isplayer(param_01))
	{
		if(function_0107(param_03))
		{
			if(param_02 < var_06.health)
			{
				if(isdefined(var_06))
				{
					var_06.var_6A06[param_01.var_86BD] = param_01;
					if(isdefined(var_06.var_69F2))
					{
						var_06.var_69F2++;
						if(var_06.var_69F2 == 3)
						{
							var_06 func_D991("ch_blastshield_hits");
						}
					}
				}
			}
		}

		param_01 func_D9B7(var_06,param_04,param_02);
	}
}

//Function Number: 60
func_3BF5(param_00,param_01)
{
	var_02 = param_00.var_4F;
	var_03 = param_00.var_13372;
	if(!isdefined(var_02) || !isplayer(var_02) || !isalive(var_02))
	{
		return;
	}

	param_01 = param_00.time;
	if(issubstr(param_00.var_10367,"MOD_MELEE"))
	{
		if(var_03.health > 0)
		{
			var_02 thread func_D9BE(var_03);
		}

		var_02 func_D9B1(var_03);
	}
}

//Function Number: 61
func_3BFF(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_01) || !isplayer(param_01))
	{
		return;
	}

	if(param_05 == "throwingknifec4_mp")
	{
		if(param_04 == "MOD_IMPACT")
		{
			param_01.var_A949 = gettime();
		}
		else if(param_04 == "MOD_EXPLOSIVE" && isdefined(param_01.var_A949))
		{
			var_09 = gettime() - param_01.var_A949;
			if(var_09 <= 50)
			{
				param_01 func_D991("ch_biospike_double");
			}
		}
	}

	if(param_05 == "micro_turret_gun_mp" && isdefined(param_00))
	{
		if(!isdefined(param_00.var_1AB))
		{
			param_00.var_1AB = 1;
		}
		else
		{
			param_00.var_1AB++;
		}

		if(func_9EBC(param_00.var_1AB,2))
		{
			param_01 func_D991("ch_engineer_micro_turret_2multi");
		}
	}

	if(scripts\mp\_utility::func_9E6C(param_05))
	{
		var_0A = func_7F48(param_05);
		if(!isdefined(param_01.var_A6A5))
		{
			param_01.var_A6A5 = [];
		}

		if(isdefined(param_00) && isdefined(param_00.var_1653))
		{
			if(!isdefined(param_01.var_A6A5[param_00.var_1653]))
			{
				var_0B = spawnstruct();
				var_0B.var_A6A7 = var_0A;
				var_0B.var_1AB = 1;
				var_0B.var_C2A4 = scripts\common\utility::func_116D7(func_9E4B(param_00.origin),1,0);
				param_01.var_A6A5[param_00.var_1653] = var_0B;
			}
			else
			{
				param_01.var_A6A5[param_00.var_1653].var_1AB++;
				if(func_9E4B(param_00.origin))
				{
					param_01.var_A6A5[param_00.var_1653].var_C2A4++;
				}
			}
		}
		else
		{
		}

		switch(var_0A)
		{
			case "sentry_shock":
				if(func_9EBC(param_01.var_A6A5[param_00.var_1653].var_C2A4,3))
				{
					param_01 func_D991("ch_sentry_defender");
				}
	
				if(func_9EBC(param_01.var_A6A5[param_00.var_1653].var_1AB,5))
				{
					param_01 func_D991("ch_sentry_streak");
				}
				break;

			case "ball_drone_backup":
				break;

			case "drone_hive":
				if(param_01.var_DDC3[param_05] > 0 && param_01.var_DDC3[param_05] % 3 == 0)
				{
					param_01 func_D991("ch_scorestreak_triple_kills");
				}
				break;

			case "precision_airstrike":
				if(param_01.var_DDC3[param_05] > 0 && param_01.var_DDC3[param_05] % 3 == 0)
				{
					param_01 func_D991("ch_scorestreak_triple_kills");
				}
				break;

			case "minijackal":
				if(param_01.var_DDC3[param_05] > 0 && param_01.var_DDC3[param_05] % 3 == 0)
				{
					param_01 func_D991("ch_scorestreak_triple_kills");
				}
				break;

			case "thor":
				if(param_01.var_DDC3[param_05] > 0 && param_01.var_DDC3[param_05] % 3 == 0)
				{
					param_01 func_D991("ch_scorestreak_triple_kills");
				}
				break;

			case "bombardment":
				if(param_01.var_DDC3[param_05] > 0 && param_01.var_DDC3[param_05] % 3 == 0)
				{
					param_01 func_D991("ch_scorestreak_triple_kills");
				}
				break;

			case "remote_c8":
				break;

			case "venom":
				if(param_01.var_DDC3[param_05] > 0 && param_01.var_DDC3[param_05] % 2 == 0)
				{
					param_01 func_D991("ch_scorestreak_double_scarab");
				}
	
				if(self method_8446())
				{
					param_01 func_D991("ch_scarab_wall_kill");
				}
				break;

			case "jackal":
				if(param_01.var_DDC3[param_05] > 0 && param_01.var_DDC3[param_05] % 3 == 0)
				{
					param_01 func_D991("ch_scorestreak_triple_kills");
				}
				break;
		}
	}

	param_01 func_D98B();
	param_01 func_D997(self);
}

//Function Number: 62
func_3BFE(param_00,param_01)
{
	var_02 = param_00.var_4F;
	var_03 = param_00.var_13372;
	if(!isdefined(var_02) || !isplayer(var_02))
	{
		return;
	}

	param_01 = param_00.time;
	var_02 func_D991("ch_lifetime_kills");
	if(isdefined(param_00.var_13372) && isdefined(param_00.var_13372.var_86BD))
	{
		var_02 notify("killedPlayer" + param_00.var_13372.var_86BD);
	}

	func_D9D8(param_00,var_02);
	func_D9AE(param_00,param_01,var_02,var_03);
	func_D9B9(param_00,param_01,var_02,var_03);
	func_D9B2(param_00,param_01,var_02,var_03);
	func_D9B0(param_00,param_01,var_02,var_03);
	var_02 func_D98A(param_00);
	var_02 func_D9BB(param_00);
	var_02 func_D9A8(param_00);
	var_02 func_D996(param_00);
	var_02 processrigkillchallengesonkill_delayed(param_00);
	if(isdefined(param_00.var_13374))
	{
		var_04 = param_00.var_13374[var_02.var_86BD];
		if(scripts\mp\_utility::func_9FB3(var_04.var_54B3) && param_00.var_9D74)
		{
			var_02 func_D991("ch_lethal_bullet_combo");
		}

		if(scripts\mp\_utility::func_9FB3(var_04.var_54B4) && scripts\mp\_utility::func_9D79(param_00.var_11329))
		{
			var_02 func_D991("ch_swap_kill");
		}

		if(isdefined(param_00.var_24E0))
		{
			if(isdefined(param_00.var_24E0[var_03.var_86BD]))
			{
				if(!scripts\mp\_utility::func_9FB3(var_04.var_54BD))
				{
					var_02 func_D991("ch_hurt_melee_kill");
				}
			}
		}
	}

	if(param_00.var_24F6.size > 0)
	{
		var_02 func_D9B8();
	}

	if(isdefined(param_00.var_24F2[var_03.var_86BD]))
	{
		var_05 = param_00.var_24F2[var_03.var_86BD];
		if(func_9EBC(var_05,5))
		{
			var_02 func_D991("ch_repeat_kill");
		}
	}

	if(param_00.var_24E1)
	{
		var_02 func_D991("ch_while_stunned_kill");
	}

	if(param_00.var_13375)
	{
		var_02 func_D991("ch_stun_kill");
	}

	if(scripts\mp\_utility::func_9FB3(param_00.var_24EA))
	{
		var_02 func_D991("ch_tactical_smoke");
	}

	if(scripts\mp\_utility::func_9FB3(param_00.var_2501))
	{
		var_02 func_D991("ch_tactical_radar");
	}

	if(func_9E8A(param_00.var_FE38))
	{
		var_02 func_D991("ch_lower_body_kill");
	}

	if(scripts\mp\_utility::func_9FB3(param_00.var_2511))
	{
		var_02 func_D991("ch_pre_adrenaline");
	}

	if(isdefined(param_00.var_13377))
	{
		if(param_00.var_13377 == var_02)
		{
			var_02 func_D991("ch_dome_defense");
		}

		if(param_00.var_13377 == var_03)
		{
			var_02 func_D991("ch_dome_assault");
		}
	}

	if(isdefined(var_03.var_4EA0))
	{
		var_06 = var_02 getentitynumber();
		if(isdefined(param_00.var_13376["cryo_mine_mp"]) && isdefined(param_00.var_13376["cryo_mine_mp"][var_06]))
		{
			var_02 func_D991("ch_tactical_cryomine");
		}

		if(isdefined(param_00.var_13376["blackout_grenade_mp"]) && isdefined(param_00.var_13376["blackout_grenade_mp"][var_06]))
		{
			var_02 func_D991("ch_tactical_blackout");
		}

		if((isdefined(param_00.var_13376["emp_grenade_mp"]) && isdefined(param_00.var_13376["emp_grenade_mp"][var_06])) || isdefined(param_00.var_13376["concussion_grenade_mp"]) && isdefined(param_00.var_13376["concussion_grenade_mp"][var_06]))
		{
			var_02 func_D991("ch_tactical_concussion");
		}
	}

	if(isdefined(param_00.var_24E9[var_03.var_86BD]))
	{
		var_02 func_D991("ch_blastshield_revenge");
	}

	var_07 = [];
	foreach(var_09 in param_00.var_24FD)
	{
		var_0A = scripts\mp\perks\_perks::func_805C(var_09);
		if(isdefined(var_0A))
		{
			if(!isdefined(var_07[var_0A]))
			{
				var_07[var_0A] = 1;
				continue;
			}

			var_07[var_0A]++;
		}
	}

	if(isdefined(var_07[1]) && var_07[1] == 2)
	{
		var_02 func_D991("ch_perk_1_combo");
	}

	if(isdefined(var_07[2]) && var_07[2] == 2)
	{
		var_02 func_D991("ch_perk_2_combo");
	}

	if(isdefined(var_07[3]) && var_07[3] == 2)
	{
		var_02 func_D991("ch_perk_3_combo");
	}

	if(scripts\mp\_utility::func_9E6C(param_00.var_11329) && !func_1C97(var_02,param_00.var_11329))
	{
		return;
	}

	func_D9C8(param_00,param_01,var_02,var_03);
	if(isdefined(param_00.var_24F8) && param_00.time - param_00.var_24F8 < 4500)
	{
		var_02 func_D991("ch_use_gesture");
	}

	if(isdefined(var_03.var_A6AE))
	{
		foreach(var_0D in var_03.var_A6AE)
		{
			if(var_0D.var_222 == var_02)
			{
				switch(var_0D.var_A6A7)
				{
					case "remote_c8":
						var_02 func_D991("ch_rc8_defense");
						break;
				}
			}
		}
	}
}

//Function Number: 63
func_D98B()
{
	if(isdefined(level.var_1655))
	{
		foreach(var_01 in level.var_1655)
		{
			if(var_01.var_222 == self)
			{
				switch(var_01.var_110EA)
				{
					case "uav":
						func_D991("ch_scorestreak_kills_uav");
						break;

					case "counter_uav":
						func_D991("ch_scorestreak_kills_cuav");
						break;

					case "directional_uav":
						func_D991("ch_scorestreak_kills_auav");
						break;
				}
			}
		}
	}
}

//Function Number: 64
func_D9D8(param_00,param_01)
{
	var_02 = scripts\mp\_loot::func_7F82(param_00.var_11329);
	if(isdefined(var_02) && isdefined(var_02.var_DB52))
	{
		switch(var_02.var_DB52)
		{
			case 4:
				param_01 func_D991("ch_outfitter_epic");
				break;

			case 3:
				param_01 func_D991("ch_outfitter_legendary");
				break;

			case 2:
				param_01 func_D991("ch_outfitter_rare");
				break;

			case 1:
				param_01 func_D991("ch_outfitter_common");
				break;
		}
	}

	if(isdefined(param_00.var_24F3))
	{
		var_03 = 0;
		foreach(var_07, var_05 in param_00.var_24F3)
		{
			var_06 = function_02C4(var_07);
			if(!isdefined(var_06))
			{
				continue;
			}

			var_03++;
		}

		if(func_9EBC(var_03,3))
		{
			param_01 func_D991("ch_outfitter_variant_triplet");
		}
	}

	if(param_00.var_11329 != param_01.var_D8E1 && param_00.var_11329 != param_01.var_F0C4)
	{
		return;
	}

	var_08 = scripts\mp\_loot::func_7F82(param_01.var_D8E1);
	var_09 = scripts\mp\_loot::func_7F82(param_01.var_F0C4);
	if(isdefined(var_08) && isdefined(var_08.var_DB52) && isdefined(var_09) && isdefined(var_09.var_DB52))
	{
		if(var_08.var_DB52 == var_09.var_DB52)
		{
			switch(var_08.var_DB52)
			{
				case 4:
					param_01 func_D991("ch_outfitter_epic_set");
					break;

				case 3:
					param_01 func_D991("ch_outfitter_legendary_set");
					break;

				case 2:
					param_01 func_D991("ch_outfitter_rare_set");
					break;

				case 1:
					param_01 func_D991("ch_outfitter_common_set");
					break;
			}
		}
	}
}

//Function Number: 65
func_D9AE(param_00,param_01,param_02,param_03)
{
	if(scripts\mp\_utility::func_9FB3(param_00.var_B930["wallkill"]))
	{
		param_02 func_D991("ch_wallrun_kill");
	}

	if(scripts\mp\_utility::func_9FB3(param_00.var_B930["jumpkill"]))
	{
		param_02 func_D991("ch_air_kill");
	}

	if(scripts\mp\_utility::func_9FB3(param_00.var_B930["slidekill"]))
	{
		param_02 func_D991("ch_slide_kill");
	}

	if(scripts\mp\_utility::func_9FB3(param_00.var_B930["killonwall"]))
	{
		param_02 func_D991("ch_kill_wallrunner");
	}

	if(scripts\mp\_utility::func_9FB3(param_00.var_B930["killinair"]))
	{
		param_02 func_D991("ch_kill_jumper");
	}

	if(scripts\mp\_utility::func_9FB3(param_00.var_B930["clutchkill"]))
	{
		param_02 func_D991("ch_clutch_grenade");
	}

	if(scripts\mp\_utility::func_9FB3(param_00.var_B930["wallkill"]) && scripts\mp\_utility::func_9FB3(param_00.var_B930["killonwall"]))
	{
		param_02 func_D991("ch_wall_vs_wall");
	}
}

//Function Number: 66
func_D9B9(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00.var_24E4))
	{
		if(func_9EBC(param_00.var_24E4,5))
		{
			param_02 func_D991("ch_bloodthirsty");
		}

		if(func_9EBC(param_00.var_24E4,10))
		{
			param_02 func_D991("ch_merciless");
		}

		if(func_9EBC(param_00.var_24E4,15))
		{
			param_02 func_D991("ch_ruthless");
		}
	}
}

//Function Number: 67
func_D9B2(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00.var_2504))
	{
		if(func_9EBC(param_00.var_2504,2))
		{
			param_02 func_D991("ch_double_kill");
		}

		if(func_9EBC(param_00.var_2504,3))
		{
			param_02 func_D991("ch_triple_kill");
		}

		if(func_9EBC(param_00.var_2504,4))
		{
			param_02 func_D991("ch_quad_kill");
		}
	}
}

//Function Number: 68
func_D9B0(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in param_00.var_24FD)
	{
		switch(var_05)
		{
			case "specialty_expanded_minimap":
				param_02 func_D991("ch_perk_kills_awareness");
				break;

			case "specialty_blastshield":
				param_02 func_D991("ch_perk_kills_blastshield");
				break;

			case "specialty_dexterity":
				param_02 func_D991("ch_perk_kills_dexterity");
				if((isdefined(param_00.var_24FA) && gettime() - param_00.var_24FA < 5000) || isdefined(param_00.var_24FC) && gettime() - param_00.var_24FC < 5000)
				{
					param_02 func_D991("ch_dexterity_actions");
				}
				break;

			case "specialty_ghost":
				if(scripts\mp\_utility::func_9FB3(param_00.var_13384))
				{
					param_02 func_D991("ch_perk_kills_ghost");
				}
	
				if(scripts\mp\_utility::func_9FB3(param_00.var_B930["backstab"]))
				{
					param_02 func_D991("ch_ghost_backstab");
				}
				break;

			case "specialty_momentum":
				if(param_00.var_10367 == "MOD_MELEE" && param_00.var_24FE > 1)
				{
					param_02 func_D991("ch_momentum_melee");
				}
				break;

			case "specialty_tracker":
				param_02 func_D991("ch_perk_kills_tracker");
				if(param_00.var_10367 == "MOD_MELEE")
				{
					param_02 func_D991("ch_tracker_melee");
				}
				break;

			case "specialty_stun_resistance":
				if(isdefined(param_00.var_250C[param_03.var_86BD]))
				{
					param_02 func_D991("ch_perk_kills_tacresist");
				}
				break;

			case "specialty_coldblooded":
				if(scripts\mp\_utility::func_13C90(param_00.var_13385,"thermal") || scripts\mp\_utility::func_9FB3(param_00.var_1337D) || scripts\mp\_utility::func_9FB3(param_00.var_1337B))
				{
					param_02 func_D991("ch_perk_kills_coldblooded");
				}
	
				if(scripts\mp\_utility::func_8225(param_00.var_11329) == "weapon_sniper")
				{
					param_02 func_D991("ch_coldblood_sniper");
				}
				break;

			case "specialty_sprintfire":
				if(param_00.var_24F1 && param_00.var_9D74)
				{
					param_02 func_D991("ch_perk_kills_gungho");
				}
	
				if(isdefined(param_00.var_24F5) && func_9EBC(param_00.var_24F5,2))
				{
					param_02 func_D991("ch_gungho_double_kill");
				}
				break;

			case "specialty_bullet_outline":
				param_02 func_D991("ch_perk_kills_pinpoint");
				var_06 = undefined;
				if(isdefined(param_00.var_13374[param_02.var_86BD]))
				{
					var_06 = param_00.var_13374[param_02.var_86BD].var_6DEF;
				}
	
				if(isdefined(var_06))
				{
					var_07 = undefined;
					if(isdefined(param_00.var_24E0[param_03.var_86BD]))
					{
						var_07 = param_00.var_24E0[param_03.var_86BD].var_6DEF;
					}
	
					if(isdefined(var_07) && var_07 < var_06)
					{
						param_02 func_D991("ch_pinpoint_counter_kill");
					}
				}
				break;

			case "specialty_marksman":
				if(scripts\mp\_utility::func_9FB3(param_00.var_B930["longshot"]))
				{
					param_02 func_D991("ch_marksman_longshot");
				}
	
				if(param_00.var_24EF && isdefined(param_00.var_24F9) && gettime() < param_00.var_24F9 + 3000)
				{
					param_02 func_D991("ch_marksman_flinch");
				}
				break;

			case "specialty_empimmune":
				param_02 func_D991("ch_perk_kills_hardwired");
				break;

			case "specialty_quieter":
				param_02 func_D991("ch_perk_kills_deadsilence");
				if(param_00.var_10367 == "MOD_MELEE")
				{
					param_02 func_D991("ch_deadsilence_melee");
				}
				break;
		}
	}
}

//Function Number: 69
func_D9C8(param_00,param_01,param_02,param_03)
{
	if(param_00.var_11329 == "none")
	{
		if(isdefined(param_00.var_13372.var_6A00) && isdefined(param_00.var_13372.var_6A00["weapon"]))
		{
			param_00.var_11329 = param_00.var_13372.var_6A00["weapon"];
		}
		else
		{
			return;
		}
	}

	if(param_00.var_4F scripts\mp\_utility::ispickedupweapon(param_00.var_11329))
	{
		param_02 func_D991("ch_pickup_kills");
		var_04 = scripts\mp\_loot::func_7F82(param_00.var_11329);
		if(isdefined(var_04) && isdefined(var_04.var_DB52) && var_04.var_DB52 == 4)
		{
			param_02 func_D991("ch_outfitter_thief");
		}

		if(isdefined(param_00.var_2512) && isdefined(param_00.var_2512[param_00.var_11329]) && gettime() - param_00.var_2512[param_00.var_11329] < 10000)
		{
			param_02 func_D991("ch_quick_pickup_kill");
		}
	}

	var_05 = scripts\mp\_utility::func_8234(param_00.var_11329);
	var_06 = scripts\mp\_utility::func_8225(param_00.var_11329);
	if(param_00.var_10367 == "MOD_PISTOL_BULLET" || param_00.var_10367 == "MOD_RIFLE_BULLET" || param_00.var_10367 == "MOD_HEAD_SHOT")
	{
		func_D990(param_00,param_02,param_01,var_06,var_05);
	}
	else if(function_0107(param_00.var_10367))
	{
		func_D99E(param_00,param_02,param_01,var_06,var_05);
	}
	else if(issubstr(param_00.var_10367,"MOD_MELEE") && !scripts\mp\_weapons::func_9F2D(param_00.var_11329))
	{
		func_D9AC(param_00,param_02,param_01,var_06,var_05);
	}
	else if(scripts\mp\_weapons::func_9F2D(param_00.var_11329))
	{
		func_D9B3(param_00,param_02,param_01,var_06,var_05);
	}
	else if(issubstr(param_00.var_10367,"MOD_IMPACT"))
	{
		if(var_05 == "iw7_axe")
		{
			param_02 processweaponchallenge_axethrow(var_05,param_00);
		}

		func_D9A0(param_00,param_02,param_01,var_06,var_05);
	}

	if(var_06 == "weapon_projectile")
	{
		param_02 func_D9CE(var_05,param_00);
	}

	var_07 = scripts\mp\_utility::func_7E9D(param_00.var_11329);
	if(isdefined(var_07))
	{
		if(var_07 == "lethal")
		{
			func_D9A9(param_00,param_02,param_01,var_06,var_05);
		}
	}

	if(scripts\mp\_utility::isclassicweapon(param_00.var_11329) && param_00.var_10367 != "MOD_MELEE")
	{
		if(!isdefined(param_02.classickills))
		{
			param_02.classickills = 1;
		}
		else
		{
			param_02.classickills++;
		}
	}

	if(scripts\mp\_utility::isburstfireweapon(param_00.var_11329) && param_00.var_10367 != "MOD_MELEE")
	{
		if(!isdefined(param_02.burstfirekills))
		{
			param_02.burstfirekills = 1;
		}
		else
		{
			param_02.burstfirekills++;
		}
	}

	if(!scripts\mp\_utility::func_9FB3(param_02.var_D99C))
	{
		var_08 = 0;
		var_09 = 0;
		var_0A = 0;
		foreach(var_0D, var_0C in param_00.var_24F3)
		{
			var_08 = var_08 || scripts\mp\_utility::func_9D78(var_0D);
			var_09 = var_09 || scripts\mp\_utility::func_9D79(var_0D);
			var_07 = scripts\mp\_utility::func_7E9D(var_0D);
			var_0A = var_0A || isdefined(var_07) && var_07 == "lethal";
		}

		if(var_08 && var_09 && var_0A)
		{
			param_02 func_D991("ch_3_kill_types");
			param_02.var_D99C = 1;
		}
	}
}

//Function Number: 70
func_D990(param_00,param_01,param_02,param_03,param_04)
{
	if(scripts\mp\_utility::func_9E6C(param_00.var_11329) || scripts\mp\_utility::func_9DE2(param_00.var_11329))
	{
		return;
	}

	switch(param_03)
	{
		case "weapon_smg":
			param_01 func_D9D1(param_04,param_00);
			break;

		case "weapon_assault":
			param_01 func_D9C9(param_04,param_00);
			break;

		case "weapon_shotgun":
			param_01 func_D9D0(param_04,param_00);
			break;

		case "weapon_dmr":
			param_01 func_D9CA(param_04,param_00);
			break;

		case "weapon_sniper":
			if(param_04 == "iw7_m1c")
			{
				param_01 func_D9C9(param_04,param_00);
			}
			else
			{
				param_01 func_D9D2(param_04,param_00);
			}
			break;

		case "weapon_pistol":
			param_01 func_D9CD(param_04,param_00);
			break;

		case "weapon_lmg":
			param_01 func_D9CB(param_04,param_00);
			break;

		default:
			break;
	}

	if(scripts\mp\_utility::func_9FB3(function_02D4(param_00.var_11329)))
	{
		param_01 func_D991("ch_lifetime_energy_kills");
	}

	if(scripts\mp\_utility::func_9FB3(param_00.var_B930["headshot"]))
	{
		param_01 func_D991("ch_lifetime_headshots");
	}

	if(param_00.var_24E3 == 0)
	{
		var_05 = weaponclipsize(param_00.var_11329);
		if(var_05 >= 10)
		{
			param_01 func_D991("ch_last_bullet_kill");
		}
	}

	var_06 = scripts\mp\_utility::func_8234(param_00.var_11329);
	var_07 = issubstr(param_00.var_11329,"alt_");
	var_08 = function_02C4(param_00.var_11329);
	var_09 = (var_06 == "iw7_fmg" && var_07) || var_06 == "iw7_ump45" && isdefined(var_08) && var_08 == 3 || var_08 == 35 || var_06 == "iw7_minilmg" && isdefined(var_08) && var_08 == 3 || var_08 == 35;
	if(var_09)
	{
		if(!isdefined(param_01.akimbokills))
		{
			param_01.akimbokills = 1;
		}
		else
		{
			param_01.akimbokills++;
		}
	}

	func_D98E(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 71
func_D98E(param_00,param_01,param_02,param_03,param_04)
{
	if(scripts\mp\_utility::func_9F8D(param_00.var_11329))
	{
		return 0;
	}

	if(function_00E5(param_00.var_11329) != "camo0")
	{
		param_01 func_D991("ch_outfitter_camo");
	}

	if(param_03 == "weapon_sniper" && !scripts\mp\_weapons::func_13C98(param_00.var_11329))
	{
		param_01 func_D9C3(param_04,"noscope",param_00);
	}

	var_05 = 0;
	var_06 = 0;
	var_07 = scripts\mp\_utility::func_821A(param_00.var_11329);
	foreach(var_09 in var_07)
	{
		if(scripts\mp\_utility::func_248E(var_09))
		{
			param_01 func_D991("ch_outfitter_charm");
			if(var_09 == "cos_026" || var_09 == "cos_007" || var_09 == "cos_006")
			{
				var_05 = 1;
			}
		}

		if(!scripts\mp\_weapons::func_9F3C(param_04,var_09))
		{
			continue;
		}

		switch(var_09)
		{
			case "oscope":
			case "vzscope":
			case "elo":
			case "phase":
			case "reflex":
			case "hybrid":
			case "acog":
			case "thermal":
				param_01 func_D9C3(param_04,var_09,param_00);
				param_01 func_D991("ch_attach_rof");
				var_06 = 1;
				break;

			case "smart":
				param_01 func_D991("ch_attach_rof");
				var_06 = 1;
				break;

			case "xmags":
				if(func_9EBC(param_00.var_24F4,2))
				{
					param_01 func_D991("ch_xmags_two_kills");
				}
	
				param_01 func_D991("ch_attach_" + var_09);
				break;

			case "xmagse":
				if(func_9EBC(param_00.var_24F4,2))
				{
					param_01 func_D991("ch_xmags_two_kills");
				}
	
				param_01 func_D991("ch_attach_xmags");
				break;

			case "fastaim":
				if(gettime() - param_00.var_24F7 < 3000)
				{
					param_01 func_D991("ch_fastaim_ads_kill");
				}
	
				param_01 func_D991("ch_attach_" + var_09);
				break;

			case "stock":
				if(param_00.var_24EF && param_00.var_250A >= 50)
				{
					param_01 func_D991("ch_stock_ads_kill");
				}
	
				param_01 func_D991("ch_attach_" + var_09);
				break;

			case "cpu":
				if(param_00.var_24EF && !param_00.var_24EB)
				{
					param_01 func_D991("ch_cpu_ads_kill");
				}
	
				param_01 func_D991("ch_attach_" + var_09);
				break;

			case "akimbo":
				if(!param_00.var_2500)
				{
					param_01 func_D991("ch_akimbo_jump_kill");
				}
	
				param_01 func_D991("ch_attach_" + var_09);
				if(!isdefined(param_01.akimbokills))
				{
					param_01.akimbokills = 1;
				}
				else
				{
					param_01.akimbokills++;
				}
				break;

			case "fmj":
				if(param_00.var_92BE & level.var_92C4)
				{
					param_01 func_D991("ch_fmj_penetrate");
				}
	
				param_01 func_D991("ch_attach_" + var_09);
				break;

			case "highcal":
				if(isdefined(param_00.var_B930["headshot"]))
				{
					param_01 func_D991("ch_highcal_headshots");
				}
	
				param_01 func_D991("ch_attach_" + var_09);
				break;

			case "barrelrange":
				if(isdefined(param_00.var_B930["longshot"]))
				{
					param_01 func_D991("ch_barrelrange_longshots");
				}
	
				param_01 func_D991("ch_attach_" + var_09);
				break;

			case "hipaim":
				if(isdefined(param_00.var_B930["hipfire"]))
				{
					param_01 func_D991("ch_hipaim_hipfire");
				}
	
				param_01 func_D991("ch_attach_" + var_09);
				break;

			case "overclock":
			case "rof":
			case "silencer":
			case "grip":
			case "firetypeauto":
				param_01 func_D991("ch_attach_" + var_09);
				break;

			case "reflect":
				param_01 func_D991("ch_attach_ricochet");
				break;

			default:
				break;
		}
	}

	if(var_05)
	{
		param_03 = scripts\mp\_utility::func_8225(param_00.var_11329);
		if(param_03 == "weapon_assault" && scripts\mp\_utility::func_9FB3(function_02D4(param_00.var_11329)))
		{
			param_01 func_D991("ch_rvn_unlock");
		}

		if(param_03 == "weapon_pistol" && var_06 == 1)
		{
			param_01 func_D991("ch_udm_unlock");
		}
	}

	if(scripts\mp\_utility::func_13C91(param_00.var_11329))
	{
		param_01 func_D9BF(param_04,"firetypeburst");
	}

	if(scripts\mp\_utility::func_13C94(param_04))
	{
		param_01 func_D9BF(param_04,"silencer");
	}

	if(scripts\mp\_utility::func_13C93(param_04))
	{
		param_01 func_D9BF(param_04,"grip");
	}

	if(scripts\mp\_utility::func_13C92(param_04))
	{
		param_01 func_D9BF(param_04,"fmj");
	}

	if(param_01 scripts\mp\_utility::func_9EE8() && scripts\mp\_utility::func_13C95(param_00.var_11329))
	{
		param_01 func_D9BF(param_04,"tracker");
	}
}

//Function Number: 72
func_D99E(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\mp\_utility::func_821A(param_00.var_11329);
	foreach(var_07 in var_05)
	{
		switch(var_07)
		{
			case "gl":
				if(scripts\mp\_utility::isstrstart(param_00.var_11329,"alt_"))
				{
					param_01 func_D9BF(param_04,var_07);
				}
				break;
		}
	}

	if(isdefined(param_00.var_94B6))
	{
		if(param_00.var_94B6 == "power_explodingDrone")
		{
			if(isdefined(param_00.var_94B3) && isdefined(param_00.var_94B5))
			{
				if(param_00.var_94B3 == param_01)
				{
					if(param_00.var_94B5 == param_01)
					{
						param_01 func_D991("ch_explodingdrone_combo");
						return;
					}

					return;
				}

				return;
			}

			return;
		}

		if(param_00.var_94B6 == "power_tripMine")
		{
			if(isdefined(param_00.var_94B3) && isdefined(param_00.var_94B5))
			{
				if(param_00.var_94B3 == param_01)
				{
					if(param_00.var_94B5 == param_01)
					{
						param_01 func_D991("ch_tripmine_explode");
						return;
					}

					if(param_00.var_94B5 == param_00.var_13372)
					{
						param_01 func_D991("ch_enemy_equip_kill");
						return;
					}

					return;
				}

				return;
			}

			return;
		}
	}
}

//Function Number: 73
func_D9AC(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\mp\_utility::func_821A(param_00.var_11329);
	foreach(var_07 in var_05)
	{
		switch(var_07)
		{
			case "tactical":
				param_01 func_D9BF(param_04,var_07);
				break;
		}
	}

	if(param_00.var_13380 == "crouch" || param_00.var_13380 == "prone")
	{
		param_01 func_D991("ch_melee_crouch_prone");
	}

	if(param_03 == "weapon_melee")
	{
		if(param_04 == "iw7_axe")
		{
			param_01 processweaponchallenge_axemelee(param_04,param_00);
			return;
		}

		param_01 func_D9CC(param_04,param_00);
	}
}

//Function Number: 74
func_D9B3(param_00,param_01,param_02,param_03,param_04)
{
	if(issubstr(param_00.var_10367,"MOD_MELEE"))
	{
		param_01 func_D9CF(param_04,param_00);
	}

	var_05 = scripts\mp\_utility::func_821A(param_00.var_11329);
	foreach(var_07 in var_05)
	{
		switch(var_07)
		{
			case "rshieldspikes":
			case "rshieldscrambler":
			case "rshieldradar":
				param_01 func_D9BF(param_04,var_07);
				break;
		}
	}
}

//Function Number: 75
func_D9A0(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\mp\_utility::func_821A(param_00.var_11329);
	foreach(var_07 in var_05)
	{
		switch(var_07)
		{
			case "gl":
				if(scripts\mp\_utility::isstrstart(param_00.var_11329,"alt_"))
				{
					param_01 func_D9BF(param_04,var_07);
				}
				break;
		}
	}
}

//Function Number: 76
func_D9A9(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.var_D7A4[param_00.var_11329];
	switch(var_05)
	{
		case "power_splashGrenade":
			param_01 func_D991("ch_lethal_splash");
			break;

		case "power_clusterGrenade":
			param_01 func_D991("ch_lethal_cluster");
			break;

		case "power_tripMine":
			param_01 func_D991("ch_lethal_tripmine");
			break;

		case "power_splitGrenade":
			param_01 func_D991("ch_lethal_split");
			break;

		case "power_explodingDrone":
			param_01 func_D991("ch_lethal_explodingdrone");
			break;

		case "power_blackholeGrenade":
			param_01 func_D991("ch_lethal_blackhole");
			break;

		case "power_wristRocket":
			param_01 func_D991("ch_lethal_armlauncher");
			break;

		case "power_spiderGrenade":
			param_01 func_D991("ch_lethal_spider");
			break;

		case "power_c4":
			param_01 func_D991("ch_lethal_c4");
			break;

		case "power_bioSpike":
			param_01 func_D991("ch_lethal_biospike");
			break;

		case "power_throwingKnife":
			break;

		default:
			break;
	}

	if(isdefined(param_00.var_94B4) && param_00.var_94B4 == "friendly")
	{
		param_01 func_D991("ch_stick_teammate");
	}
}

//Function Number: 77
func_3C03(param_00)
{
	if(!isdefined(game["uniquePlayerCount"]) || game["uniquePlayerCount"] < 3)
	{
		return;
	}

	var_01 = param_00.player;
	if(var_01.var_13906)
	{
		var_02 = var_01.pers["kills"];
		var_03 = var_01.pers["deaths"];
		var_04 = var_01.pers["score"];
		var_05 = 1000000;
		if(var_03 > 0)
		{
			var_05 = var_02 / var_03;
		}

		var_01.pers["kdratio"] = var_05;
		if(var_05 >= 5 && var_02 >= 5)
		{
			var_01 func_D992("ch_starplayer");
		}

		if(var_03 == 0 && scripts\mp\_utility::func_81CB() > 300000)
		{
			var_01 func_D992("ch_flawless");
		}

		if(var_01.var_278 > 0)
		{
			var_06 = scripts\mp\_utility::func_E76A(var_01.var_278 / 100);
			var_01 func_D991("ch_lifetime_score",var_06);
			switch(level.gametype)
			{
				case "dm":
					if(param_00.var_CBFC < 3)
					{
						var_01 func_D991("ch_ffa_wins");
					}
					break;

				case "sotf_ffa":
					if(param_00.var_CBFC < 3)
					{
						var_01 func_D992("ch_hunted_victor");
					}
					break;
			}
		}
	}

	var_01 checkvrunlockchallenge();
	var_01 checkmp28unlockchallenge();
	var_01 checkminilmgunlockchallenge();
	var_01 checkba50calunlockchallenge();
	var_01 checkmod2187unlockchallenge();
	var_01 checklongshotunlockchallenge();
	var_01 checkgaussunlockchallenge();
	var_01 checkmustangunlockchallenge();
	var_01 checktacburstunlockchallenge();
	var_01 checkatlasunlockchallenge();
}

//Function Number: 78
func_3C04(param_00)
{
	if(!param_00.var_13D8A)
	{
		return;
	}

	if(!isdefined(game["uniquePlayerCount"]) || game["uniquePlayerCount"] < 3)
	{
		return;
	}

	var_01 = param_00.player;
	if(var_01.var_13906)
	{
		var_01 func_D991("ch_global_wins");
		if(level.tactical)
		{
			var_01 func_D991("ch_ctf_wins");
		}

		if(param_00.var_CBFC == 0)
		{
			var_01 func_D991("ch_first_place");
		}

		if(param_00.var_CBFC <= 2)
		{
			var_01 func_D991("ch_top3");
		}

		switch(level.gametype)
		{
			case "war":
				var_01 func_D991("ch_war_wins");
				break;

			case "sd":
				var_01 func_D991("ch_sd_sr_wins");
				break;

			case "dom":
				var_01 func_D991("ch_dom_wins");
				break;

			case "conf":
				var_01 func_D991("ch_kc_grind_wins");
				break;

			case "sr":
				var_01 func_D991("ch_sd_sr_wins");
				break;

			case "grind":
				var_01 func_D991("ch_kc_grind_wins");
				break;

			case "ball":
				var_01 func_D991("ch_ball_wins");
				break;

			case "infect":
				break;

			case "aliens":
				break;

			case "gun":
				break;

			case "grnd":
				break;

			case "siege":
				var_01 func_D991("ch_siege_wins");
				break;

			case "koth":
				var_01 func_D991("ch_koth_wins");
				break;

			case "mp_zomb":
				break;

			case "ctf":
				break;

			case "dd":
				var_01 func_D991("ch_dd_wins");
				break;

			case "tdef":
				var_01 func_D991("ch_tdef_wins");
				break;

			case "front":
				var_01 func_D991("ch_war_wins");
				break;

			default:
				break;
		}

		var_02 = getdvarint("scr_playlist_type",0);
		if(var_02 == 1)
		{
			var_01 func_D992("ch_bromance");
			if(!level.console)
			{
				var_01 func_D992("ch_tactician");
			}
		}
		else if(var_02 == 2)
		{
			var_01 func_D992("ch_tactician");
		}

		if(level.var_8B38)
		{
			var_01 func_D992("ch_hardcore_extreme");
		}
	}

	var_01 checkcrdbunlockchallenge();
}

//Function Number: 79
checkvrunlockchallenge()
{
	if(func_2139("ch_vr_unlock"))
	{
		return;
	}

	if(isdefined(self.var_A681))
	{
		var_00 = [];
		foreach(var_04, var_02 in self.var_A681)
		{
			if(var_02 > 0 && scripts\mp\_utility::func_9D78(var_04) || scripts\mp\_utility::func_9D79(var_04))
			{
				var_03 = scripts\mp\_utility::func_8234(var_04);
				var_00[var_03] = 1;
				if(var_00.size >= 6)
				{
					func_D991("ch_vr_unlock");
					return;
				}
			}
		}
	}
}

//Function Number: 80
checkcrdbunlockchallenge()
{
	if(func_2139("ch_crdb_unlock"))
	{
		return;
	}

	if(isdefined(self.var_A681))
	{
		var_00 = 0;
		foreach(var_03, var_02 in self.var_A681)
		{
			if(scripts\mp\_utility::func_8234(var_03) == "iw7_vr")
			{
				var_00 = var_00 + var_02;
			}

			if(var_00 > 0)
			{
				func_D991("ch_crdb_unlock");
				return;
			}
		}
	}
}

//Function Number: 81
checkminilmgunlockchallenge()
{
	if(func_2139("ch_minilmg_unlock"))
	{
		return;
	}

	if(isdefined(self.shotslandedlmg) && self.shotslandedlmg >= 50)
	{
		func_D991("ch_minilmg_unlock");
	}
}

//Function Number: 82
checkmp28unlockchallenge()
{
	if(func_2139("ch_mp28_unlock"))
	{
		return;
	}

	if(isdefined(self.classickills) && self.classickills >= 10)
	{
		func_D991("ch_mp28_unlock");
	}
}

//Function Number: 83
checkba50calunlockchallenge()
{
	if(func_2139("ch_ba50cal_unlock"))
	{
		return;
	}

	if(isdefined(self.pers["oneShotKills"]) && self.pers["oneShotKills"] >= 5)
	{
		func_D991("ch_ba50cal_unlock");
	}
}

//Function Number: 84
checkmod2187unlockchallenge()
{
	if(func_2139("ch_mod2187_unlock"))
	{
		return;
	}

	if(isdefined(self.akimbokills) && self.akimbokills >= 10)
	{
		func_D991("ch_mod2187_unlock");
	}
}

//Function Number: 85
checklongshotunlockchallenge()
{
	if(func_2139("ch_longshot_unlock"))
	{
		return;
	}

	var_00 = 0;
	var_01 = 0;
	foreach(var_05, var_03 in self.var_A681)
	{
		if(var_03 > 0 && scripts\mp\_utility::func_9D78(var_05) || scripts\mp\_utility::func_9D79(var_05))
		{
			var_04 = scripts\mp\_utility::func_8234(var_05);
			if(var_04 == "iw7_ba50cal")
			{
				var_00 = 1;
			}

			if(var_04 == "iw7_mod2187")
			{
				var_01 = 1;
			}
		}
	}

	if(var_00 && var_01)
	{
		func_D991("ch_longshot_unlock");
	}
}

//Function Number: 86
checkgaussunlockchallenge()
{
	if(func_2139("ch_gauss_unlock"))
	{
		return;
	}

	if(isdefined(self.hipfiremagkills) && self.hipfiremagkills >= 5)
	{
		func_D991("ch_gauss_unlock");
	}
}

//Function Number: 87
checkmustangunlockchallenge()
{
	if(func_2139("ch_mag_unlock"))
	{
		return;
	}

	var_00 = 1;
	var_01 = 0;
	foreach(var_05, var_03 in self.var_A681)
	{
		if(!scripts\mp\_utility::func_9D78(var_05) && !scripts\mp\_utility::func_9D79(var_05))
		{
			continue;
		}

		var_04 = scripts\mp\_utility::func_8225(var_05);
		if(var_04 != "weapon_pistol")
		{
			var_00 = 0;
			break;
		}
		else
		{
			var_01 = var_01 + var_03;
		}
	}

	if(var_00 && var_01 >= 5)
	{
		func_D991("ch_mag_unlock");
	}
}

//Function Number: 88
checktacburstunlockchallenge()
{
	if(func_2139("ch_tacburst_unlock"))
	{
		return;
	}

	if(isdefined(self.burstfirekills) && self.burstfirekills >= 10)
	{
		func_D991("ch_tacburst_unlock");
	}
}

//Function Number: 89
checkatlasunlockchallenge()
{
	if(func_2139("ch_unsalmg_unlock"))
	{
		return;
	}

	if(isdefined(self.var_A681))
	{
		var_00 = 0;
		foreach(var_03, var_02 in self.var_A681)
		{
			if(scripts\mp\_utility::func_8234(var_03) == "iw7_tacburst")
			{
				var_00 = var_00 + var_02;
			}

			if(var_00 >= 10)
			{
				func_D991("ch_unsalmg_unlock");
				return;
			}
		}
	}
}

//Function Number: 90
func_D378(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!func_B4E8())
	{
		return;
	}

	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	if(isdefined(param_01))
	{
		param_01 endon("disconnect");
	}

	func_3BF6(param_00,param_01,param_02,param_03,param_04,param_05);
	wait(0.05);
	scripts\mp\_utility::func_13842();
	var_06 = spawnstruct();
	var_06.var_13372 = self;
	var_06.var_6000 = param_00;
	var_06.var_4F = param_01;
	var_06.var_92BA = param_02;
	var_06.var_10367 = param_03;
	var_06.var_11329 = param_04;
	var_06.var_FE38 = param_05;
	func_5914("playerDamaged",var_06);
}

//Function Number: 91
func_D3C3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!func_B4E8())
	{
		return;
	}

	if(!isdefined(param_01))
	{
		return;
	}

	if(isdefined(param_01.var_A686))
	{
		param_01.var_A686++;
	}

	if(isplayer(param_01) && param_01 method_81BD())
	{
		if(!isdefined(param_01.var_A687))
		{
			param_01.var_A687 = 1;
		}
		else
		{
			param_01.var_A687++;
		}
	}

	func_3BFF(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	self endon("disconnect");
	param_01 endon("disconnect");
	var_09 = spawnstruct();
	var_09.var_13372 = self;
	var_09.victimid = self getentitynumber();
	var_09.var_6000 = param_00;
	var_09.var_4F = param_01;
	var_09.var_92BA = param_02;
	var_09.var_92BE = param_03;
	var_09.var_10367 = param_04;
	var_09.var_11329 = param_05;
	var_09.var_10AA6 = param_06;
	var_09.var_FE38 = param_07;
	var_09.time = gettime();
	var_09.var_B930 = param_08;
	var_09.var_9D74 = scripts\common\utility::func_9D74(param_04);
	if(isdefined(param_05) && issubstr(param_05,"_hybrid"))
	{
		if(param_01 getcurrentweapon() == param_05)
		{
			var_09.var_9272 = param_01 method_812E(param_05);
		}
		else
		{
			var_09.var_9272 = 0;
		}
	}

	var_09.var_1337E = var_09.var_13372 isonground();
	if(isplayer(param_01))
	{
		param_01.var_A684[param_01.var_A684.size] = var_09;
		if(isdefined(param_01.var_A685[var_09.var_11329]))
		{
			param_01.var_A685[var_09.var_11329]++;
		}
		else
		{
			param_01.var_A685[var_09.var_11329] = 1;
		}

		if(!scripts\mp\_utility::func_9E6C(var_09.var_11329))
		{
			if(isdefined(param_01.var_A681[var_09.var_11329]))
			{
				param_01.var_A681[var_09.var_11329]++;
			}
			else
			{
				param_01.var_A681[var_09.var_11329] = 1;
			}
		}

		var_09.var_24EC = isdefined(var_09.var_4F.var_1B3);
		var_09.var_2500 = var_09.var_4F isonground();
		var_09.var_250B = var_09.var_4F getstance();
		var_09.var_24E4 = param_01.pers["cur_kill_streak"];
		var_09.var_2504 = param_01.var_DDC2;
		var_09.var_2505 = param_01.var_DDC3;
		var_09.attackerarchetype = getsubstr(param_01.var_AE62,10,param_01.var_AE62.size);
		var_09.attackerkillsthislife = param_01.var_A684.size;
		var_09.var_24F3 = param_01.var_A685;
		var_09.var_24E3 = param_01 getweaponammoclip(param_05);
		var_09.var_24EB = param_01.var_9074;
		var_09.var_24F8 = param_01.var_A960;
		var_09.var_2503 = param_01.pers["primaryWeapon"];
		var_09.var_2509 = param_01.pers["secondaryWeapon"];
		var_09.var_24F6 = param_01.var_A6B4;
		var_09.var_24F2 = param_01.var_A653;
		var_09.var_24E1 = param_01 scripts\mp\_weapons::func_9F81();
		var_09.var_24E0 = param_01.var_24E5;
		var_09.var_2512 = param_01.var_13CB9;
		var_09.var_24EA = param_01.var_8BC1;
		var_09.var_2501 = param_01.var_CA7D;
		var_09.var_2511 = param_01.var_13071;
		var_09.var_24F4 = param_01.var_A686;
		var_09.var_24EF = param_01 scripts\mp\_utility::func_9EE8();
		var_09.var_24F7 = param_01.var_A932;
		var_09.var_250A = length(param_01 getvelocity());
		var_09.var_24FD = param_01.pers["loadoutPerks"];
		var_09.var_24FA = param_01.var_A9DD;
		var_09.var_24FC = param_01.var_A9D3;
		var_09.var_24F9 = param_01.var_A98B;
		var_09.var_24FE = scripts\common\utility::func_116D7(isdefined(param_01.var_BCF6),param_01.var_BCF6,1);
		var_09.var_24E9 = param_01.var_6A06;
		var_09.var_250C = param_01.var_1119A;
		var_09.var_24F5 = param_01.var_A687;
		var_09.var_24F1 = param_01 method_81BD();
		var_09.var_24E8 = param_01 scripts\mp\_supers::func_7E4F();
		var_09.var_250D = param_01 scripts\mp\_supers::func_9F88();
		var_09.var_2506 = param_01.var_11B2C;
		var_09.attackersixthsensesource = param_01.sixthsensesource;
		var_09.attackerrelaysource = param_01.relaysource;
		var_09.attackerrearguardattackers = param_01.rearguardattackers;
		var_09.var_2510 = param_01.var_119DF;
		var_09.var_24EE = param_01 getweaponslistall();
		var_09.attackerhassupertrophyout = isdefined(param_01.supertrophies) && param_01.supertrophies.size > 0;
		var_09.attackervisionpulsedvictim = param_01 lib_0E1B::func_9EF9(var_09.var_13372);
		if(isdefined(param_01.var_6A06))
		{
			param_01.var_6A06[self.var_86BD] = undefined;
		}

		if(isdefined(param_01.var_1119A))
		{
			param_01.var_1119A[self.var_86BD] = undefined;
		}
	}
	else
	{
		var_09.var_24EC = 0;
		var_09.var_2500 = 0;
		var_09.var_250B = "stand";
		var_09.var_24E4 = 0;
		var_09.var_2505 = 0;
		var_09.var_24F3 = [];
		var_09.var_24F2 = [];
		var_09.var_24E1 = 0;
		var_09.var_24E0 = [];
		var_09.var_2512 = [];
		var_09.var_24F4 = 0;
		var_09.var_24FD = [];
		var_09.var_24F5 = 0;
		var_09.var_24F1 = 0;
		var_09.var_24E8 = "";
		var_09.var_250D = 0;
	}

	if(isdefined(param_00))
	{
		var_09.var_94B4 = param_00.var_9F7D;
		var_09.var_94B5 = param_00.var_222;
		var_09.var_94B6 = param_00.var_D719;
		var_09.var_94B3 = param_00.var_4D3F;
		var_09.var_94B7 = param_00.var_13908;
		var_09.wasplantedmine = param_00.planted;
	}

	var_09.var_13374 = self.var_24E5;
	var_09.var_13375 = scripts\mp\_weapons::func_9F81();
	var_09.var_13380 = self getstance();
	var_09.var_13376 = self.var_4EA0;
	var_09.var_13384 = scripts\mp\killstreaks\_utility::func_9FB9(self.team);
	var_09.var_13385 = self.var_EB6C;
	var_09.var_1337D = func_66B8("specialty_tracker");
	var_09.var_1337B = func_66B8("specialty_sixth_sense");
	var_09.var_13379 = func_66B8("specialty_quieter");
	var_09.var_1337A = var_09.var_13372 scripts\mp\_supers::func_7E4F();
	var_09.var_1337C = var_09.var_13372 scripts\mp\_supers::func_9F88();
	var_0A = var_09.var_13372 scripts\mp\_supers::func_7E4E();
	if(isdefined(var_0A))
	{
		var_09.var_13381 = var_0A.var_A986;
	}

	var_0B = scripts\mp\_domeshield::func_7E80(self);
	if(isdefined(var_0B))
	{
		var_09.var_13377 = var_0B.var_222;
	}

	func_1369C(var_09);
	var_09.var_4F notify("playerKilledChallengesProcessed");
}

//Function Number: 92
func_A695(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02.var_A6AE))
	{
		param_02.var_A6AE = [];
	}

	if(isdefined(self.var_1653))
	{
		if(!isdefined(param_02.var_A6AE[self.var_1653]))
		{
			var_05 = spawnstruct();
			var_05.var_222 = self.var_222;
			var_05.var_A6A7 = param_00;
			var_05.var_4D71 = param_04;
			param_02.var_A6AE[self.var_1653] = var_05;
			return;
		}

		param_02.var_A6AE[self.var_1653].var_4D71 = param_02.var_A6AE[self.var_1653].var_4D71 + param_04;
		return;
	}
}

//Function Number: 93
func_A6A3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!func_B4E8())
	{
		return;
	}

	if(isdefined(param_04) && isplayer(param_04) && !isdefined(param_01) || param_04 != param_01 && isdefined(param_07))
	{
		var_09 = scripts\mp\_utility::func_8234(param_07);
		if(!isdefined(param_04.var_A6B3))
		{
			param_04.var_A6B3 = [];
		}

		if(!isdefined(param_04.var_A6B3[var_09]))
		{
			param_04.var_A6B3[var_09] = 1;
		}
		else
		{
			param_04.var_A6B3[var_09]++;
		}

		if(param_04 func_66B8("specialty_engineer"))
		{
			param_04 func_D991("ch_perk_kills_engineer");
		}

		if(param_04.var_A684.size > 0)
		{
			param_04 func_D9B8();
		}

		if(scripts\mp\killstreaks\_utility::func_9D28(param_00))
		{
			if(param_04 func_66B8("specialty_blindeye"))
			{
				param_04 func_D991("ch_perk_kills_blindeye");
			}
		}

		var_0A = param_07;
		var_0B = scripts\mp\_utility::func_9E6C(var_0A);
		var_0C = 0;
		var_0D = 0;
		var_0E = 0;
		var_0F = scripts\mp\_utility::func_9F8D(var_0A);
		var_10 = scripts\common\utility::func_9D74(param_06);
		if(var_0B)
		{
			switch(func_7F48(var_0A))
			{
				case "jackal":
				case "bombardment":
				case "precision_airstrike":
				case "thor":
				case "minijackal":
				case "drone_hive":
					var_0C = 1;
					break;
			}
		}

		switch(param_00)
		{
			case "precision_airstrike":
			case "drone_hive":
				var_0D = 1;
				break;

			case "directional_uav":
			case "counter_uav":
			case "uav":
				param_04 func_D991("ch_destroy_uav");
				var_0D = 1;
				break;

			case "minijackal":
				param_04 func_D991("ch_destroy_apex");
				var_0D = 1;
				break;

			case "thor":
				if(var_10)
				{
					param_04 func_D991("ch_thor_bullet_kill");
				}
	
				var_0D = 1;
				break;

			case "bombardment":
				var_0D = 1;
				break;

			case "jackal":
				if(var_10)
				{
					param_04 func_D991("ch_armada_warden_bullet_kill");
				}
	
				var_0D = 1;
				break;

			case "dronedrop":
				param_04 func_D991("ch_destroy_dronepackage");
				var_0D = 1;
				break;

			case "sentry_shock":
				param_04 func_D991("ch_destroy_sentry");
				var_0E = 1;
				break;

			case "ball_drone_backup":
				param_04 func_D991("ch_destroy_vulture");
				var_0E = 1;
				break;

			case "remote_c8":
				param_04 func_D991("ch_kill_rc8");
				var_0E = 1;
				break;

			case "venom":
				param_04 func_D991("ch_destroy_scarab");
				var_0E = 1;
				break;
		}

		if(var_0D)
		{
			param_04 func_D991("ch_destroy_aerial");
		}

		if(var_0C && var_0D)
		{
			param_04 func_D991("ch_scorestreak_air_to_air");
		}

		if(var_0C && var_0E)
		{
			param_04 func_D991("ch_scorestreak_air_to_ground");
		}

		if(var_0F)
		{
			param_04 func_D991("ch_super_scorestreak_kill");
		}

		param_04 func_D9D4(var_09,param_00,param_02);
		param_04.var_A9A8 = gettime();
	}
}

//Function Number: 94
func_D9D4(param_00,param_01,param_02)
{
	var_03 = scripts\mp\_utility::func_8225(param_00);
	switch(var_03)
	{
		case "weapon_projectile":
			func_D9D3(param_00,param_01,param_02);
			break;
	}
}

//Function Number: 95
func_D9D3(param_00,param_01,param_02)
{
	switch(param_00)
	{
		case "iw7_glprox":
			func_D9D6(param_00,param_01,param_02);
			break;

		case "iw7_chargeshot":
			func_D9D5(param_00,param_01,param_02);
			break;

		case "iw7_lockon":
			func_D9D7(param_00,param_01,param_02);
			break;

		case "iw7_venomx":
			processweaponkilledkillstreak_venomx(param_00,param_01,param_02);
			break;
	}
}

//Function Number: 96
func_8375(param_00,param_01)
{
	if(isdefined(self.var_2507))
	{
		foreach(var_03 in self.var_2507)
		{
			if(self.var_24E5[var_03.var_86BD].var_DA >= 100)
			{
				if(!isdefined(scripts\mp\_utility::func_143A(var_03)))
				{
					continue;
				}

				if(isdefined(self.var_222) && self.var_222 == var_03)
				{
					continue;
				}

				if(isdefined(self.var_222.team) && scripts\mp\_utility::func_9E05(self.var_222.team,var_03))
				{
					continue;
				}

				if(var_03 == param_01)
				{
					continue;
				}

				var_03 thread scripts\mp\_utility::func_83B4("vehicle_destroyed_assist");
			}
		}
	}
}

//Function Number: 97
func_1369C(param_00)
{
	if(isdefined(param_00.var_4F))
	{
		param_00.var_4F endon("disconnect");
	}

	self.var_D9A6 = 1;
	wait(0.05);
	scripts\mp\_utility::func_13842();
	func_5914("playerKilled",param_00);
	self.var_D9A6 = undefined;
}

//Function Number: 98
func_D366(param_00)
{
	var_01 = spawnstruct();
	var_01.player = self;
	var_01.var_13372 = param_00;
	var_02 = param_00.var_24E5[self.var_86BD];
	if(isdefined(var_02))
	{
		var_01.var_11329 = var_02.var_394;
	}

	func_5914("playerAssist",var_01);
}

//Function Number: 99
func_13079(param_00)
{
	self endon("disconnect");
	wait(0.05);
	scripts\mp\_utility::func_13842();
	var_01 = spawnstruct();
	var_01.player = self;
	var_01.var_A6A7 = param_00;
	func_5914("playerUsedKillstreak",var_01);
}

//Function Number: 100
func_A691(param_00)
{
	self endon("disconnect");
	wait(0.05);
	scripts\mp\_utility::func_13842();
	var_01 = spawnstruct();
	var_01.player = self.var_222;
	var_01.var_A6A7 = param_00;
	func_5914("playerKillstreakActive",var_01);
}

//Function Number: 101
func_E75B()
{
	func_5914("roundBegin");
}

//Function Number: 102
func_E75D(param_00)
{
	var_01 = spawnstruct();
	if(level.teambased)
	{
		var_02 = "allies";
		for(var_03 = 0;var_03 < level.var_CC1D[var_02].size;var_03++)
		{
			var_01.player = level.var_CC1D[var_02][var_03];
			var_01.var_13D8A = var_02 == param_00;
			var_01.var_CBFC = var_03;
			func_5914("roundEnd",var_01);
			var_01.player scripts\mp\contractchallenges::contractmatchend(var_01);
		}

		var_02 = "axis";
		for(var_03 = 0;var_03 < level.var_CC1D[var_02].size;var_03++)
		{
			var_01.player = level.var_CC1D[var_02][var_03];
			var_01.var_13D8A = var_02 == param_00;
			var_01.var_CBFC = var_03;
			func_5914("roundEnd",var_01);
			var_01.player scripts\mp\contractchallenges::contractmatchend(var_01);
		}

		return;
	}

	for(var_03 = 0;var_03 < level.var_CC1D["all"].size;var_03++)
	{
		var_01.player = level.var_CC1D["all"][var_03];
		var_01.var_13D8A = isdefined(param_00) && isplayer(param_00) && var_01.player == param_00;
		var_01.var_CBFC = var_03;
		func_5914("roundEnd",var_01);
		var_01.player scripts\mp\contractchallenges::contractmatchend(var_01);
	}
}

//Function Number: 103
func_5914(param_00,param_01)
{
	if(!func_B4E8())
	{
		return;
	}

	if(isdefined(param_01))
	{
		var_02 = param_01.player;
		if(!isdefined(var_02))
		{
			var_02 = param_01.var_4F;
		}

		if(isdefined(var_02) && isai(var_02))
		{
			return;
		}
	}

	if(getdvarint("disable_challenges") > 0)
	{
		return;
	}

	if(!isdefined(level.var_B8CD[param_00]))
	{
		return;
	}

	if(isdefined(param_01))
	{
		for(var_03 = 0;var_03 < level.var_B8CD[param_00].size;var_03++)
		{
			thread [[ level.var_B8CD[param_00][var_03] ]](param_01);
		}

		return;
	}

	for(var_03 = 0;var_03 < level.var_B8CD[param_00].size;var_03++)
	{
		thread [[ level.var_B8CD[param_00][var_03] ]]();
	}
}

//Function Number: 104
func_BA1E()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	self.var_10ABF = 0;
	for(;;)
	{
		self waittill("sprint_begin");
		self.var_A9F8 = gettime();
		thread func_BA17();
		thread func_BA18();
	}
}

//Function Number: 105
func_BA1F()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self.var_A687 = 0;
		scripts\common\utility::waittill_any_3("sprint_end","death");
	}
}

//Function Number: 106
func_BA18()
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("monitorSingleSprintMomentumTime()");
	self endon("monitorSingleSprintMomentumTime()");
	self waittill("momentum_max_speed");
	var_00 = gettime();
	self waittill("momentum_reset");
	if(gettime() > var_00 + 5000)
	{
		func_D991("ch_momentum_time");
	}
}

//Function Number: 107
func_B9BA()
{
	if(level.gametype != "tdef")
	{
		return;
	}

	level endon("game_ended");
	self endon("disconnect");
	self.var_6DE0 = 0;
	for(;;)
	{
		self waittill("ball_grab");
		self.var_6DE0 = 1;
		self waittill("ball_dropped");
		self.var_6DE0 = 0;
	}
}

//Function Number: 108
func_27FA()
{
	if(scripts\mp\_utility::func_9FB3(self.var_6DE0))
	{
		func_D991("ch_keep_away");
	}
}

//Function Number: 109
func_BA17()
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("monitorSingleSprintDistance()");
	self endon("monitorSingleSprintDistance()");
	var_00 = 0;
	var_01 = gettime();
	for(;;)
	{
		var_02 = self.origin;
		var_03 = scripts\common\utility::waittill_any_timeout_1(0.1,"sprint_end","death");
		var_04 = distance(self.origin,var_02);
		var_00 = var_00 + var_04;
		if(var_03 != "timeout" || !self method_81BD())
		{
			break;
		}
	}

	var_05 = gettime() - var_01;
	var_06 = int(var_05 * 0.35);
	var_00 = int(min(var_00,var_06) / 12);
	func_D991("ch_sprint",var_00);
}

//Function Number: 110
func_B9B4()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	var_00 = self isonground() && !self method_8446();
	var_01 = 0;
	for(;;)
	{
		if(scripts\mp\_utility::func_9FB3(level.var_90A4))
		{
			level waittill("host_migration_end");
		}

		if(self isonground() && !self method_8446())
		{
			var_00 = 1;
		}
		else
		{
			if(var_00)
			{
				var_01 = 0;
			}
			else
			{
				var_01 = var_01 + 0.05;
			}

			if(var_01 >= 20)
			{
				func_D991("ch_stay_in_air");
				return;
			}

			var_00 = 0;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 111
func_BA33()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("used_cosmetic_gesture");
		self.var_A960 = gettime();
	}
}

//Function Number: 112
func_B9D5()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("killed_exploding_drone",var_00);
		if(isdefined(var_00) && var_00 != self)
		{
			func_D991("ch_destroy_explodingdrone");
		}
	}
}

//Function Number: 113
func_BA07()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	var_00 = [];
	for(;;)
	{
		self waittill("power_activated",var_01,var_02);
		if(!isdefined(var_00[var_02]))
		{
			var_00[var_02] = 1;
		}
		else
		{
			var_00[var_02]++;
		}

		if(var_02 == "secondary")
		{
			func_D991("ch_tactical_uses");
			if(func_9EBC(var_00[var_02],2))
			{
				func_D991("ch_tactical_two_uses");
			}
		}
	}
}

//Function Number: 114
func_A9B5()
{
	if(!func_B4E8())
	{
		return;
	}

	if(!self.var_13906)
	{
		return;
	}

	if(self.var_115D5 > 0)
	{
		return;
	}

	func_D992("ch_lastmanstanding");
}

//Function Number: 115
func_B9C0()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = scripts\common\utility::func_13734("bomb_planted","bomb_defused");
		if(!isdefined(var_00))
		{
			continue;
		}

		if(var_00 == "bomb_planted")
		{
			func_D992("ch_saboteur");
			continue;
		}

		if(var_00 == "bomb_defused")
		{
			func_D992("ch_hero");
		}
	}
}

//Function Number: 116
func_B9ED()
{
	for(;;)
	{
		self waittill("spawned_player");
		thread func_112E0();
	}
}

//Function Number: 117
func_112E0()
{
	self endon("death");
	self endon("disconnect");
	wait(300);
	if(isdefined(self))
	{
		func_D992("ch_survivalist");
	}
}

//Function Number: 118
func_B9EF()
{
	self endon("death");
	self endon("disconnect");
	self.var_AF2C = [];
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = scripts\mp\_utility::func_8234(var_01);
		if(var_02 == "iw7_lockon")
		{
			self.var_AF2C[self.var_AF2C.size] = var_00;
			if(isdefined(self.var_10FAA) && isdefined(self.var_10FA9) && self.var_10FA9 == 2)
			{
				var_00.var_C83D = self.var_10FAA;
			}
		}
	}
}

//Function Number: 119
func_D992(param_00,param_01,param_02)
{
}

//Function Number: 120
func_D991(param_00,param_01,param_02)
{
	if(!func_D3D6())
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!func_8C49(param_00))
	{
		if(getdvarint("debug_challenges"))
		{
		}

		return;
	}

	if(!func_9D84(param_00))
	{
		return;
	}

	var_03 = func_7E22(param_00);
	if(func_2139(param_00))
	{
		return;
	}

	var_04 = func_3BF8(param_00);
	var_05 = level.var_3C2C[param_00]["targetval"][var_03];
	if(isdefined(param_02) && param_02)
	{
		var_06 = param_01;
	}
	else
	{
		var_06 = var_05 + param_02;
	}

	var_07 = 0;
	if(var_06 >= var_05)
	{
		var_08 = 1;
		var_07 = var_06 - var_05;
		var_06 = var_05;
	}
	else
	{
		var_08 = 0;
	}

	if(var_04 < var_06)
	{
		func_3C05(param_00,var_06);
	}

	if(var_08)
	{
		thread func_839C(param_00,var_03);
		scripts\mp\_matchdata::func_AF99(param_00,var_03);
		func_110AE(param_00);
		func_8358(level.var_3C2C[param_00]["score"][var_03]);
		var_03++;
		func_3C06(param_00,var_03);
		self.var_3C2A[param_00] = var_03;
		if(func_2139(param_00))
		{
			thread func_10117(param_00,challengesplasheseachtier(param_00));
			processmasterchallenge(param_00);
			switch(param_00)
			{
				case "ch_iw7_knife_gold":
				case "ch_iw7_lockon_gold":
				case "ch_iw7_chargeshot_gold":
				case "ch_iw7_glprox_gold":
				case "ch_iw7_emc_gold":
				case "ch_iw7_g18_gold":
				case "ch_iw7_revolver_gold":
				case "ch_iw7_nrg_gold":
					thread func_D991("ch_diamond_melee");
					break;
			}

			return;
		}

		if(givesmasterprogresseachtier(param_00))
		{
			processmasterchallenge(param_00);
		}

		if(challengesplasheseachtier(param_00))
		{
			thread func_10117(param_00,1);
			return;
		}
	}
}

//Function Number: 121
processmasterchallenge(param_00)
{
	var_01 = level.var_3C2C[param_00]["master"];
	if(isdefined(var_01))
	{
		thread func_D991(var_01);
	}
}

//Function Number: 122
func_110AE(param_00)
{
	if(!isdefined(self.var_3C30))
	{
		self.var_3C30 = [];
	}

	var_01 = 0;
	foreach(var_03 in self.var_3C30)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
		}
	}

	if(!var_01)
	{
		self.var_3C30[self.var_3C30.size] = param_00;
	}
}

//Function Number: 123
func_839C(param_00,param_01)
{
	self endon("disconnect");
	if(!level.var_7669)
	{
		wait(0.25);
	}

	var_02 = "challenge";
	var_03 = undefined;
	if(func_9FFC(param_00))
	{
		var_03 = scripts\mp\_utility::func_13C75(func_8222(param_00));
	}

	var_04 = level.var_3C2C[param_00]["reward"][param_01];
	var_05 = "bonus_challenge_xp";
	if(isdefined(level.prestigeextras[var_05]))
	{
		if(self isitemunlocked(var_05,"prestigeExtras",1))
		{
			var_04 = int(var_04 * 1.25);
		}
	}

	scripts\mp\_rank::func_839A(var_02,var_04,var_03);
}

//Function Number: 124
func_8358(param_00)
{
	var_01 = self getplayerdata("mp","challengeScore");
	self setplayerdata("mp","challengeScore",var_01 + param_00);
}

//Function Number: 125
func_12E71()
{
	self.var_3C2A = [];
	self endon("disconnect");
	if(!func_B4E8())
	{
		return;
	}

	var_00 = 0;
	foreach(var_05, var_02 in level.var_3C2C)
	{
		var_00++;
		if(var_00 % 20 == 0)
		{
			wait(0.05);
		}

		self.var_3C2A[var_05] = 0;
		var_03 = var_02["index"];
		var_04 = func_3BF9(var_05);
		self.var_3C2A[var_05] = var_04;
	}
}

//Function Number: 126
func_7E20(param_00)
{
	return tablelookup("mp/allChallengesTable.csv",0,param_00,6);
}

//Function Number: 127
func_7E21(param_00)
{
	var_01 = tablelookup("mp/allChallengesTable.csv",0,param_00,7);
	if(isdefined(var_01) && var_01 == "")
	{
		return undefined;
	}

	return var_01;
}

//Function Number: 128
func_B029(param_00,param_01)
{
	return int(tablelookup("mp/allChallengesTable.csv",0,param_00,10 + param_01 * 3));
}

//Function Number: 129
func_9F27(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_7E20(param_00);
	switch(var_01)
	{
		case "all_optics":
		case "oscope":
		case "vzscope":
		case "elo":
		case "phase":
		case "reflex":
		case "hybrid":
		case "acog":
		case "noscope":
		case "thermal":
			return 1;
	}

	return 0;
}

//Function Number: 130
isrigcustomizationchallenge(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_7E20(param_00);
	if(var_01 == "rig_customization")
	{
		return 1;
	}

	return 0;
}

//Function Number: 131
func_9FFC(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_7E20(param_00);
	if(isdefined(var_01))
	{
		if(scripts\mp\_utility::func_13C86(var_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 132
challengesplasheseachtier(param_00)
{
	return func_9FFC(param_00) || isweaponclasschallenge(param_00) || func_9F27(param_00) || isrigcustomizationchallenge(param_00);
}

//Function Number: 133
givesmasterprogresseachtier(param_00)
{
	return func_9FFC(param_00) || isweaponclasschallenge(param_00) || func_9F27(param_00) || isrigcustomizationchallenge(param_00);
}

//Function Number: 134
isweaponclasschallenge(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_7E20(param_00);
	if(isdefined(var_01))
	{
		switch(var_01)
		{
			case "weapon_all":
			case "weapon_projectile":
			case "weapon_shotgun":
			case "weapon_sniper":
			case "weapon_lmg":
			case "weapon_assault":
			case "weapon_smg":
			case "weapon_pistol":
			case "weapon_melee":
				return 1;
		}
	}

	return 0;
}

//Function Number: 135
func_8222(param_00)
{
	return func_7E20(param_00);
}

//Function Number: 136
func_8122(param_00)
{
	return func_7E20(param_00);
}

//Function Number: 137
func_3C27(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,10 + param_02 * 3);
	return int(var_03);
}

//Function Number: 138
func_3C20(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,11 + param_02 * 3);
	return int(var_03);
}

//Function Number: 139
func_3C25(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,12 + param_02 * 3);
	return int(var_03);
}

//Function Number: 140
func_3C18(param_00,param_01)
{
	var_02 = tablelookup(param_00,0,param_01,8);
	return scripts\common\utility::func_116D7(var_02 == "",undefined,int(var_02));
}

//Function Number: 141
func_3C1C(param_00,param_01)
{
	var_02 = tablelookup(param_00,0,param_01,9);
	return scripts\common\utility::func_116D7(var_02 == "",undefined,int(var_02));
}

//Function Number: 142
func_31D8(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	level.var_3C2D = [];
	var_02 = 0;
	for(;;)
	{
		var_04 = tablelookupbyrow(param_00,var_02,0);
		if(var_04 == "")
		{
			break;
		}

		var_05 = func_7E21(var_04);
		level.var_3C2C[var_04] = [];
		level.var_3C2C[var_04]["index"] = var_02;
		level.var_3C2C[var_04]["type"] = param_01;
		level.var_3C2C[var_04]["targetval"] = [];
		level.var_3C2C[var_04]["reward"] = [];
		level.var_3C2C[var_04]["score"] = [];
		level.var_3C2C[var_04]["filter"] = func_7E20(var_04);
		level.var_3C2C[var_04]["master"] = var_05;
		for(var_06 = 0;var_06 < 8;var_06++)
		{
			var_07 = func_3C27(param_00,var_04,var_06);
			if(var_07 == 0)
			{
				break;
			}

			var_08 = func_3C20(param_00,var_04,var_06);
			var_09 = func_3C25(param_00,var_04,var_06);
			level.var_3C2C[var_04]["targetval"][var_06] = var_07;
			level.var_3C2C[var_04]["reward"][var_06] = var_08;
			level.var_3C2C[var_04]["score"][var_06] = var_09;
			var_03 = var_03 + var_08;
		}

		var_0A = func_3C18(param_00,var_04);
		level.var_3C2C[var_04]["displayParam"] = var_0A;
		var_0B = func_3C1C(param_00,var_04);
		level.var_3C2C[var_04]["paramScale"] = var_0B;
		if(isdefined(var_05))
		{
			if(!isdefined(level.var_3C2D[var_05]))
			{
				level.var_3C2D[var_05] = [];
			}

			level.var_3C2D[var_05][level.var_3C2D[var_05].size] = var_04;
		}

		var_02++;
	}

	return int(var_03);
}

//Function Number: 143
validatemasterchallenges()
{
	level endon("game_ended");
	wait(1);
	foreach(var_06, var_01 in level.var_3C2D)
	{
		var_02 = 0;
		foreach(var_01 in var_01)
		{
			if(givesmasterprogresseachtier(var_01))
			{
				var_02 = var_02 + level.var_3C2C[var_01]["targetval"].size;
				continue;
			}

			var_02 = var_02 + 1;
		}

		var_05 = level.var_3C2C[var_06]["targetval"][0];
	}
}

//Function Number: 144
func_31D7()
{
	level.var_3C2C = [];
	var_00 = 0;
	var_00 = var_00 + func_31D8("mp/allChallengesTable.csv",0);
}

//Function Number: 145
func_BA08()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		if(!func_B4E8())
		{
			return;
		}

		self waittill("process",var_00);
		func_D992(var_00);
	}
}

//Function Number: 146
func_B9E9()
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

		if(var_00 == 10 && self.var_A6AB.size == 0)
		{
			func_D992("ch_theloner");
			continue;
		}

		if(var_00 == 9)
		{
			if(isdefined(self.var_A6AB[7]) && isdefined(self.var_A6AB[8]) && isdefined(self.var_A6AB[9]))
			{
				func_D992("ch_6fears7");
			}
		}
	}
}

//Function Number: 147
func_B9E6()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		self waittill("destroyed_killstreak",var_00);
		if(self isitemunlocked("specialty_blindeye","perk") && scripts\mp\_utility::_hasperk("specialty_blindeye"))
		{
			func_D992("ch_blindeye");
		}
	}
}

//Function Number: 148
func_D39B()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(self getweaponammoclip(var_02))
		{
			if(!scripts\mp\_weapons::func_9F2D(var_02) && !scripts\mp\_weapons::func_9E6D(var_02))
			{
				return 1;
			}
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

//Function Number: 149
func_B9B2()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	var_00 = scripts\mp\_utility::func_9EE8();
	self.var_A932 = 0;
	for(;;)
	{
		if(scripts\mp\_utility::func_9EE8())
		{
			if(!var_00)
			{
				self.var_A932 = gettime();
				var_00 = 1;
			}
		}
		else
		{
			var_00 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 150
func_B9E0()
{
	self endon("disconnect");
	self.var_9074 = 0;
	for(;;)
	{
		self waittill("hold_breath");
		self.var_9074 = 1;
		self waittill("release_breath");
		self.var_9074 = 0;
	}
}

//Function Number: 151
func_B9F0()
{
	self endon("disconnect");
	self.var_B315 = 0;
	for(;;)
	{
		self waittill("jumped");
		var_00 = self getcurrentweapon();
		scripts\common\utility::waittill_notify_or_timeout("weapon_change",1);
		var_01 = self getcurrentweapon();
		if(var_01 == "none")
		{
			self.var_B315 = 1;
		}
		else
		{
			self.var_B315 = 0;
		}

		if(self.var_B315)
		{
			if(self isitemunlocked("specialty_fastmantle","perk") && scripts\mp\_utility::_hasperk("specialty_fastmantle"))
			{
				func_D992("ch_fastmantle");
			}

			scripts\common\utility::waittill_notify_or_timeout("weapon_change",1);
			var_01 = self getcurrentweapon();
			if(var_01 == var_00)
			{
				self.var_B315 = 0;
			}
		}
	}
}

//Function Number: 152
func_BA3B()
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

		if(scripts\mp\_utility::func_9E6C(var_01))
		{
			continue;
		}

		if(var_01 == "briefcase_bomb_mp" || var_01 == "briefcase_bomb_defuse_mp")
		{
			continue;
		}

		var_02 = function_0244(var_01);
		if(var_02 != "primary")
		{
			continue;
		}

		self.var_A9D3 = gettime();
	}
}

//Function Number: 153
func_B9DA()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03);
		if(self == var_03)
		{
			continue;
		}

		self.var_A98A = gettime();
	}
}

//Function Number: 154
func_B9F4()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("triggeredExpl",var_00);
		thread func_136A2();
	}
}

//Function Number: 155
func_136A2()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(level.var_5113 + 2);
	func_D992("ch_delaymine");
}

//Function Number: 156
func_10061(param_00)
{
	return self isitemunlocked(param_00,"perk") && scripts\mp\_utility::_hasperk(param_00);
}

//Function Number: 157
func_D9BF(param_00,param_01)
{
	func_D992("ch_" + param_01);
}

//Function Number: 158
func_D99F(param_00,param_01)
{
	if(!func_B4E8() || isai(param_00))
	{
		return;
	}

	param_00 func_D992("ch_theedge");
	if(!isai(param_01))
	{
		param_01 func_D992("ch_starryeyed");
	}

	if(isdefined(param_00) && isdefined(param_00.var_B930) && isdefined(param_00.var_B930["revenge"]))
	{
		param_00 func_D992("ch_moneyshot");
	}

	if(isdefined(param_01) && isdefined(param_01.var_6A00) && isdefined(param_01.var_6A00["stickKill"]) && param_01.var_6A00["stickKill"])
	{
		param_00 func_D992("ch_stickman");
	}

	if(isdefined(param_01.var_24E5[param_00.var_86BD]) && isdefined(param_01.var_24E5[param_00.var_86BD].var_10367) && isdefined(param_01.var_24E5[param_00.var_86BD].var_394) && issubstr(param_01.var_24E5[param_00.var_86BD].var_10367,"MOD_MELEE") && scripts\mp\_weapons::func_9F2D(param_01.var_24E5[param_00.var_86BD].var_394))
	{
		param_00 func_D992("ch_owned");
	}

	var_02 = param_00.team;
	if(!level.teambased)
	{
		var_02 = "none";
	}

	param_00 func_D991("ch_final_killcam");
}

//Function Number: 159
func_D9C3(param_00,param_01,param_02)
{
	if(scripts\mp\_utility::func_9EE8())
	{
		func_D991("ch_" + param_01 + "_kills");
		if(isdefined(param_02.var_B930["headshot"]))
		{
			func_D991("ch_" + param_01 + "_headshots");
		}

		if(isdefined(param_02.var_B930["longshot"]))
		{
			func_D991("ch_" + param_01 + "_longshots");
		}

		if(param_02.var_2504 % 2 == 0)
		{
			func_D991("ch_" + param_01 + "_double_kills");
		}
	}

	if(param_02.var_24E4 > 0 && param_02.var_24E4 % 3 == 0)
	{
		func_D991("ch_" + param_01 + "_streak");
	}
}

//Function Number: 160
func_D9C9(param_00,param_01)
{
	func_D991("ch_lifetime_ar_kills");
	func_D991("ch_" + param_00);
	func_3DF9(param_01,"headshot",param_00);
	func_3DF9(param_01,"longshot",param_00);
	func_3E59(param_00,param_01.var_11329);
	func_3DEF(param_00,param_01.var_11329,0);
	func_3E2B(param_01.var_11329,param_01,param_00,2);
	func_3DFE(param_01.var_11329,param_01,param_00,3);
}

//Function Number: 161
func_D9D1(param_00,param_01)
{
	func_D991("ch_lifetime_smg_kills");
	func_D991("ch_" + param_00);
	func_3DF9(param_01,"hipfire",param_00);
	func_3DF9(param_01,"pointblank",param_00);
	func_3DF9(param_01,"sliding",param_00);
	func_3DEF(param_00,param_01.var_11329,0);
	func_3E2B(param_01.var_11329,param_01,param_00,2);
	func_3DFE(param_01.var_11329,param_01,param_00,3);
}

//Function Number: 162
func_D9CB(param_00,param_01)
{
	func_D991("ch_lifetime_lmg_kills");
	func_D991("ch_" + param_00);
	func_3DF9(param_01,"headshot",param_00);
	if(isdefined(param_01.var_B930["hipfire"]))
	{
		func_D991("ch_" + param_00 + "_penetrate");
	}

	func_3E25(param_01,param_00,param_01.var_11329);
	func_3DEF(param_00,param_01.var_11329,6);
	func_3E2B(param_01.var_11329,param_01,param_00,2);
	func_3DFE(param_01.var_11329,param_01,param_00,3);
}

//Function Number: 163
func_D9CA(param_00,param_01)
{
	func_D991("ch_" + param_00);
	if(param_01.var_250B == "crouch")
	{
		func_D992("ch_" + param_00 + "_crouch");
	}

	func_3DFA(param_01,"defender",param_00);
	func_3DFA(param_01,"longshot",param_00);
	func_3DFA(param_01,"headshot",param_00);
	func_3DFA(param_01,"pointblank",param_00);
	func_3DF8(param_00);
}

//Function Number: 164
func_D9D2(param_00,param_01)
{
	func_D991("ch_lifetime_sniper_kills");
	func_D991("ch_" + param_00);
	func_3DF9(param_01,"headshot",param_00);
	func_3DF9(param_01,"longshot",param_00);
	if(param_01.var_24EB)
	{
		func_D991("ch_" + param_00 + "_holdbreath");
	}

	func_3DEF(param_00,param_01.var_11329,6);
	func_3E2B(param_01.var_11329,param_01,param_00,2);
	func_3DFE(param_01.var_11329,param_01,param_00,3);
	if(scripts\mp\_utility::func_9FB3(param_01.var_B930["pointblank"]))
	{
		func_D991("ch_point_blank_sniper");
	}
}

//Function Number: 165
func_D9D0(param_00,param_01)
{
	func_D991("ch_lifetime_shotgun_kills");
	func_D991("ch_" + param_00);
	func_3DF9(param_01,"hipfire",param_00);
	func_3DF9(param_01,"pointblank",param_00);
	func_3DF9(param_01,"sliding",param_00);
	func_3DEF(param_00,param_01.var_11329,0);
	func_3E2B(param_01.var_11329,param_01,param_00,2);
	func_3DFE(param_01.var_11329,param_01,param_00,3);
}

//Function Number: 166
func_D9CF(param_00,param_01)
{
	func_D991("ch_" + param_00);
}

//Function Number: 167
func_D9CD(param_00,param_01)
{
	func_D991("ch_lifetime_pistol_kills");
	func_D991("ch_" + param_00);
	func_3DF9(param_01,"headshot",param_00);
	func_3DF9(param_01,"pointblank",param_00);
	if(!func_3E17(param_01))
	{
		func_D991("ch_" + param_00 + "_pistol_only");
	}

	func_3DEF(param_00,param_01.var_11329,5);
	func_3E2B(param_01.var_11329,param_01,param_00,2);
	func_3DFE(param_01.var_11329,param_01,param_00,3);
	var_02 = scripts\mp\_utility::func_8234(param_01.var_11329);
	if(var_02 == "iw7_mag" && isdefined(param_01.var_B930["hipfire"]))
	{
		if(!isdefined(self.hipfiremagkills))
		{
			self.hipfiremagkills = 1;
			return;
		}

		self.hipfiremagkills++;
	}
}

//Function Number: 168
func_D9CE(param_00,param_01)
{
	switch(param_00)
	{
		case "iw7_glprox":
			func_D9C6(param_00,param_01);
			break;

		case "iw7_chargeshot":
			func_D9C5(param_00,param_01);
			break;

		case "iw7_lockon":
			func_D9C7(param_00,param_01);
			break;

		case "iw7_venomx":
			processweaponchallenge_venomx(param_00,param_01);
			break;
	}
}

//Function Number: 169
func_D9C6(param_00,param_01)
{
	func_D991("ch_iw7_glprox");
	if(param_01.var_10367 == "MOD_IMPACT" || param_01.var_10367 == "MOD_GRENADE")
	{
		func_D991("ch_iw7_glprox_direct");
	}

	func_3E2B(param_01.var_11329,param_01,param_00,2);
	if(!func_3E17(param_01))
	{
		func_D991("ch_iw7_glprox_no_primary");
	}

	if(isdefined(param_01.var_13372))
	{
		if(distancesquared(param_01.var_13372.origin,self.origin) > 1440000)
		{
			func_D991("ch_iw7_glprox_long_range");
		}
	}

	func_3DFE(param_01.var_11329,param_01,param_00,3);
}

//Function Number: 170
func_D9D6(param_00,param_01,param_02)
{
	func_D991("ch_iw7_glprox_kill_streak");
}

//Function Number: 171
processweaponchallenge_venomx(param_00,param_01)
{
	func_D991("ch_iw7_venomx");
	if(param_01.var_10367 == "MOD_IMPACT" || param_01.var_10367 == "MOD_GRENADE")
	{
		func_D991("ch_iw7_venomx_direct");
	}

	func_3E2B(param_01.var_11329,param_01,param_00,2);
	if(!func_3E17(param_01))
	{
		func_D991("ch_iw7_venomx_no_primary");
	}

	if(isdefined(param_01.var_13372))
	{
		if(distancesquared(param_01.var_13372.origin,self.origin) > 1440000)
		{
			func_D991("ch_iw7_venomx_long_range");
		}
	}

	func_3DFE(param_01.var_11329,param_01,param_00,3);
}

//Function Number: 172
processweaponkilledkillstreak_venomx(param_00,param_01,param_02)
{
	func_D991("ch_iw7_venomx_kill_streak");
}

//Function Number: 173
func_D9C5(param_00,param_01)
{
	func_D991("ch_iw7_chargeshot_kill");
	func_3E2B(param_01.var_11329,param_01,param_00,2);
	func_3E4D(param_00);
}

//Function Number: 174
func_D9D5(param_00,param_01,param_02)
{
	func_D991("ch_iw7_chargeshot");
	func_D991("ch_iw7_chargeshot_kill_streak_points",scripts\mp\killstreaks\_killstreaks::func_817B(param_01));
	if(isdefined(self.var_A9A8) && gettime() - self.var_A9A8 < 10000)
	{
		func_D991("ch_iw7_chargeshot_streak_double");
	}

	if(isdefined(self.var_A6B3) && isdefined(self.var_A6B3[param_00]) && func_9EBC(self.var_A6B3[param_00],3))
	{
		func_D991("ch_iw7_chargeshot_kill_3_streaks");
	}

	func_3E4D(param_00);
}

//Function Number: 175
func_D9C7(param_00,param_01)
{
	func_D991("ch_iw7_lockon_kill");
	func_3E4D(param_00);
}

//Function Number: 176
func_D9D7(param_00,param_01,param_02)
{
	func_D991("ch_iw7_lockon");
	func_D991("ch_iw7_lockon_kill_streak_points",scripts\mp\killstreaks\_killstreaks::func_817B(param_01));
	var_03 = undefined;
	var_04 = 0;
	foreach(var_06 in self.var_AF2C)
	{
		if(isdefined(var_06))
		{
			var_07 = distancesquared(var_06.origin,param_02.origin);
			if(!isdefined(var_03) || var_04 > var_07)
			{
				var_03 = var_06;
				var_04 = var_07;
			}
		}
	}

	if(isdefined(var_03) && !isdefined(var_03.var_C83D))
	{
		func_D991("ch_iw7_lockon_no_lock_on");
	}

	if(isdefined(self.var_A9A8) && gettime() - self.var_A9A8 < 10000)
	{
		func_D991("ch_iw7_lockon_streak_double");
	}

	if(isdefined(self.var_A6B3) && isdefined(self.var_A6B3[param_00]) && func_9EBC(self.var_A6B3[param_00],3))
	{
		func_D991("ch_iw7_lockon_kill_3_streaks");
	}

	func_3E4D(param_00);
}

//Function Number: 177
func_D9CC(param_00,param_01)
{
	func_D991("ch_" + param_00);
	if(isdefined(param_01.var_B930["backstab"]))
	{
		func_D991("ch_" + param_00 + "_backstab");
	}
	else
	{
		func_D991("ch_" + param_00 + "_frontstab");
	}

	if(!func_3E17(param_01))
	{
		func_D991("ch_" + param_00 + "_melee_only");
	}

	func_3DF9(param_01,"sliding",param_00);
	func_3E2B(param_01.var_11329,param_01,param_00,2);
	func_3DFE(param_01.var_11329,param_01,param_00,3);
}

//Function Number: 178
processweaponchallenge_axemelee(param_00,param_01)
{
	var_02 = "alt_" + param_01.var_11329;
	func_D991("ch_iw7_axe");
	if(isdefined(param_01.var_B930["backstab"]))
	{
		func_D991("ch_" + param_00 + "_backstab");
	}

	checkaxecombochallenge(param_01,param_01.var_11329,var_02);
	checkaxemultikillchallenge(param_01,param_01.var_11329,var_02);
	checkaxeconsecutivechallenge(param_01,param_01.var_11329,var_02);
}

//Function Number: 179
processweaponchallenge_axethrow(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_E0CF(param_01.var_11329);
	func_D991("ch_iw7_axe_frontstab");
	if(isdefined(param_01.var_B930["backstab"]))
	{
		func_D991("ch_" + param_00 + "_backstab");
	}

	var_03 = param_01.var_24F3[param_01.var_11329];
	if(isdefined(var_03) && func_9EBC(var_03,2))
	{
		func_D991("ch_iw7_axe_melee_only");
	}

	checkaxecombochallenge(param_01,var_02,param_01.var_11329);
	checkaxemultikillchallenge(param_01,var_02,param_01.var_11329);
	checkaxeconsecutivechallenge(param_01,var_02,param_01.var_11329);
}

//Function Number: 180
checkaxecombochallenge(param_00,param_01,param_02)
{
	var_03 = param_00.var_24F3[param_01];
	var_04 = param_00.var_24F3[param_02];
	if(param_00.var_11329 == param_01)
	{
		var_05 = isdefined(var_03) && var_03 == 1;
		var_06 = isdefined(var_04) && var_04 > 0;
		if(var_05 && var_06)
		{
			func_D991("ch_iw7_axe_sliding");
			return;
		}

		return;
	}

	if(param_00.var_11329 == param_02)
	{
		var_07 = isdefined(var_04) && var_04 == 1;
		var_08 = isdefined(var_03) && var_03 > 0;
		if(var_07 && var_08)
		{
			func_D991("ch_iw7_axe_sliding");
			return;
		}

		return;
	}
}

//Function Number: 181
checkaxemultikillchallenge(param_00,param_01,param_02)
{
	var_03 = 0;
	if(isdefined(param_00.var_2505[param_01]))
	{
		var_03 = var_03 + param_00.var_2505[param_01];
	}

	if(isdefined(param_00.var_2505[param_02]))
	{
		var_03 = var_03 + param_00.var_2505[param_02];
	}

	if(isdefined(var_03) && func_9EBC(var_03,2))
	{
		func_D991("ch_iw7_axe_2multikill");
	}
}

//Function Number: 182
checkaxeconsecutivechallenge(param_00,param_01,param_02)
{
	var_03 = 0;
	if(isdefined(param_00.var_24F3[param_01]))
	{
		var_03 = var_03 + param_00.var_24F3[param_01];
	}

	if(isdefined(param_00.var_24F3[param_02]))
	{
		var_03 = var_03 + param_00.var_24F3[param_02];
	}

	if(isdefined(var_03) && func_9EBC(var_03,3))
	{
		func_D991("ch_iw7_axe_3streak");
	}
}

//Function Number: 183
func_3DF9(param_00,param_01,param_02)
{
	if(isdefined(param_00.var_B930[param_01]))
	{
		func_D991("ch_" + param_02 + "_" + param_01);
	}
}

//Function Number: 184
func_3DFA(param_00,param_01,param_02)
{
	if(isdefined(param_00.var_B930[param_01]))
	{
		func_D992("ch_" + param_02 + "_" + param_01);
	}
}

//Function Number: 185
func_3DF8(param_00)
{
	if(self method_81AA())
	{
		func_D992("ch_" + param_00 + "_leaning");
	}
}

//Function Number: 186
func_3E32(param_00,param_01)
{
	if(param_00.var_92BE & level.var_92C4)
	{
		func_D992("ch_" + param_01 + "_penetrate");
	}
}

//Function Number: 187
func_3E31(param_00,param_01)
{
	if(param_00.var_92BE & level.var_92C4)
	{
		func_D991("ch_" + param_01 + "_penetrate");
	}
}

//Function Number: 188
func_3DFE(param_00,param_01,param_02,param_03)
{
	var_04 = param_01.var_24F3[param_00];
	if(isdefined(var_04) && func_9EBC(var_04,param_03))
	{
		func_D991("ch_" + param_02 + "_" + param_03 + "streak");
	}
}

//Function Number: 189
func_3E5F()
{
	var_00 = self getcurrentweapon();
	if(scripts\mp\_weapons::func_9F2D(var_00))
	{
		return 1;
	}

	var_01 = scripts\common\utility::getlastweapon();
	return scripts\mp\_weapons::func_9F2D(var_01);
}

//Function Number: 190
func_3DE3(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		if(isdefined(level.var_C321) && isdefined(level.var_C321["odin_assault"]) && param_02 == level.var_C321["odin_assault"].var_394["large_rod"].var_DA5A || param_02 == level.var_C321["odin_assault"].var_394["small_rod"].var_DA5A)
		{
			param_00 func_D992("ch_shooting_star");
			return 1;
		}
		else if(param_02 == "aamissile_projectile_mp")
		{
			param_00 func_D992("ch_air_superiority");
		}
	}

	param_00 func_D992("ch_clearskies");
	return 0;
}

//Function Number: 191
func_3DFF(param_00,param_01)
{
	if(!isai(param_00))
	{
		var_02 = param_00 scripts\mp\_teams::func_8078();
		var_03 = param_00 scripts\mp\_teams::func_8079(var_02);
		return var_03 == param_01;
	}

	return 0;
}

//Function Number: 192
func_3E59(param_00,param_01)
{
	if(scripts\mp\_utility::func_9FB3(self.var_B930["ads"]))
	{
		var_02 = function_00E3(param_01);
		foreach(var_04 in var_02)
		{
			var_05 = scripts\mp\_weapons::func_248C(var_04);
			if(var_05 == "rail")
			{
				var_06 = scripts\mp\_utility::func_2494(var_04);
				if(scripts\mp\_weapons::func_9F3C(param_00,var_06))
				{
					func_D991("ch_" + param_00 + "_optic");
					break;
				}
			}
		}
	}
}

//Function Number: 193
func_3E2B(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01.var_2505[param_00]))
	{
		var_04 = param_01.var_2505[param_00];
		if(isdefined(var_04) && func_9EBC(var_04,param_03))
		{
			func_D991("ch_" + param_02 + "_" + param_03 + "multikill");
		}
	}
}

//Function Number: 194
func_3DEF(param_00,param_01,param_02)
{
	var_03 = 0;
	foreach(var_05 in function_00E3(param_01))
	{
		var_06 = scripts\mp\_utility::func_2494(var_05);
		if(scripts\mp\_weapons::func_9F3C(param_00,var_06))
		{
			var_03++;
		}
	}

	if(var_03 == param_02)
	{
		func_D991("ch_" + param_00 + "_" + param_02 + "attachments");
	}
}

//Function Number: 195
func_3E25(param_00,param_01,param_02)
{
	if(!isdefined(param_00.var_24E3))
	{
		return;
	}

	var_03 = param_00.var_24E3;
	var_04 = weaponclipsize(param_02);
	if(var_03 <= var_04 * 0.15)
	{
		func_D991("ch_" + param_01 + "_lastshots");
	}
}

//Function Number: 196
func_3E17(param_00)
{
	if(isdefined(param_00.var_24EE))
	{
		foreach(var_02 in param_00.var_24EE)
		{
			if(scripts\mp\_utility::func_9D78(var_02))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 197
func_3E4D(param_00)
{
	if(isdefined(self.var_A684) && isdefined(self.var_A6B4))
	{
		if(self.var_A684.size > 0 && self.var_A6B4.size > 0 && !scripts\mp\_utility::func_9FB3(self.var_110E6[param_00]))
		{
			func_D991("ch_" + param_00 + "_combo");
			self.var_110E6[param_00] = 1;
		}
	}
}

//Function Number: 198
func_D994(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03.team == param_01)
		{
			var_03 func_D992(param_00);
		}
	}
}

//Function Number: 199
func_9D84(param_00)
{
	var_01 = level.var_3C2C[param_00]["filter"];
	if(!isdefined(var_01))
	{
		return 1;
	}

	return self isitemunlocked(var_01,"challenge") && self isitemunlocked(param_00,"challenge");
}

//Function Number: 200
func_8C49(param_00)
{
	return isdefined(level.var_3C2C) && isdefined(level.var_3C2C[param_00]);
}

//Function Number: 201
func_1C97(param_00,param_01)
{
	return 0;
}

//Function Number: 202
func_3E2D(param_00,param_01)
{
	var_02 = self.pers[param_00];
	return func_9EBC(var_02,param_01);
}

//Function Number: 203
func_9EBC(param_00,param_01)
{
	return param_00 > 0 && param_00 % param_01 == 0;
}

//Function Number: 204
func_8C0E()
{
	if(isdefined(self.pers["loadoutPerks"]))
	{
		return self.pers["loadoutPerks"].size == 0;
	}

	return 1;
}

//Function Number: 205
func_9D83(param_00)
{
	if(!func_D3D6())
	{
		return 0;
	}

	if(func_2139(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 206
func_2139(param_00)
{
	if(self.var_3C2A[param_00] >= level.var_3C2C[param_00]["targetval"].size)
	{
		return 1;
	}

	return 0;
}

//Function Number: 207
func_D9B8()
{
	if(scripts\mp\_utility::func_9FB3(self.var_110E5))
	{
		return;
	}

	func_D991("ch_streak_player_kill");
	self.var_110E5 = 1;
}

//Function Number: 208
func_9E8A(param_00)
{
	switch(param_00)
	{
		case "right_foot":
		case "right_leg_lower":
		case "right_leg_upper":
		case "left_foot":
		case "left_leg_lower":
		case "left_leg_upper":
			return 1;
	}

	return 0;
}

//Function Number: 209
func_D3A8(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	var_02 = scripts\common\utility::func_116D7(isplayer(param_01),param_01,param_01.var_222);
	if(!isdefined(var_02) || !isplayer(var_02))
	{
		return;
	}

	if(isdefined(param_00.var_4EA0) && isdefined(param_00.var_4EA0["cryo_mine_mp"]) && param_00.var_4EA0["cryo_mine_mp"].size > 0)
	{
		var_02 func_D991("ch_plasma_cryo_combo");
	}
}

//Function Number: 210
minedestroyed(param_00,param_01,param_02)
{
	if(!isdefined(param_01) || !isplayer(param_01))
	{
		return;
	}

	if(isdefined(param_00.var_13C2E) && param_00.var_13C2E == "c4_mp")
	{
		if(param_00.var_222 != param_01 && !scripts\mp\_utility::func_9FB3(param_00.planted) && scripts\common\utility::func_9D74(param_02))
		{
			param_01 func_D991("ch_c4_air_kill");
		}
	}
}

//Function Number: 211
func_2AEA(param_00,param_01,param_02)
{
	if(param_00.var_5726 >= 1300)
	{
		param_01 func_D991("ch_biospike_longrange");
	}
}

//Function Number: 212
func_BA0B()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self.var_A686 = 0;
	for(;;)
	{
		self waittill("reload");
		self.var_A9DD = gettime();
		self.var_A686 = 0;
	}
}

//Function Number: 213
func_C5A8(param_00)
{
	if(!func_B4E8())
	{
		return;
	}

	if(isdefined(self.var_453C) && isdefined(self.var_453C[param_00]))
	{
		if(func_9EBC(self.var_453C[param_00],5) && scripts\mp\_utility::func_13C90(param_00,"grip"))
		{
			func_D991("ch_grip_accuracy");
		}
	}
}

//Function Number: 214
func_BA29()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("super_earned");
		if(!scripts\mp\_utility::func_766C("prematch_done"))
		{
			continue;
		}

		if(func_66B8("specialty_overclock"))
		{
			func_D991("ch_perk_overclock");
			if(self.pers["supersEarned"] % 5 == 0)
			{
				func_D991("ch_overclock_unlocked");
			}
		}
	}
}

//Function Number: 215
func_66B8(param_00)
{
	if(!scripts\mp\_utility::_hasperk(param_00) || !scripts\mp\perks\_perks::func_9EDF(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 216
func_E280(param_00)
{
	if(!isdefined(param_00) || !isplayer(param_00))
	{
		return;
	}

	self.var_1119A[param_00.var_86BD] = 1;
}

//Function Number: 217
func_B9D4()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("destroyed_equipment");
		func_D991("ch_destroy_items");
		if(func_66B8("specialty_engineer"))
		{
			func_D991("ch_perk_kills_engineer");
		}
	}
}

//Function Number: 218
func_127BC()
{
	func_D991("ch_engineer_explosion_delay");
}

//Function Number: 219
func_B9CE()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		self waittill("earned_award_buffered",var_00);
		var_01 = 0;
		var_02 = 0;
		var_03 = 0;
		var_04 = 0;
		var_05 = 0;
		switch(var_00)
		{
			case "mode_ctf_kill_with_flag":
			case "mode_uplink_kill_with_ball":
			case "mode_sd_defuse_save":
			case "mode_x_assault":
				var_01 = 1;
				break;
	
			case "mode_sd_plant_save":
			case "mode_x_defend":
				var_02 = 1;
				break;
	
			case "mode_ctf_kill_carrier":
			case "mode_uplink_kill_carrier":
				var_02 = 1;
				var_04 = 1;
				break;
	
			case "mode_siege_secure":
			case "mode_ctf_cap":
			case "mode_uplink_fieldgoal":
			case "mode_uplink_dunk":
			case "mode_hp_secure":
			case "mode_dom_secure":
			case "mode_dom_secure_neutral":
			case "mode_dom_secure_b":
			case "mode_sd_detonate":
				var_03 = 1;
				break;
	
			case "mode_sd_defuse":
			case "mode_sd_last_defuse":
				var_03 = 1;
				var_05 = 1;
				break;
		}

		if(var_01)
		{
			func_D991("ch_kill_defenders");
		}

		if(var_02)
		{
			func_D991("ch_kill_attackers");
		}

		if(var_03)
		{
			func_D991("ch_objectives");
		}

		if(var_05)
		{
			func_D991("ch_defuse");
		}

		if(var_04)
		{
			func_D991("ch_kill_carrier");
		}
	}
}