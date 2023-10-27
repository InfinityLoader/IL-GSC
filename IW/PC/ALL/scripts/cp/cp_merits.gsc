/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_merits.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 1764 ms
 * Timestamp: 10/27/2023 12:09:36 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachestring(&"CP_MERIT_COMPLETED");
	if(!func_B4E9())
	{
		return;
	}

	level.var_B682 = [];
	func_DEFE("enemyKilled",::func_BD74);
	level thread func_C56E();
}

//Function Number: 2
func_B4E9()
{
	if(level.onlinegame && !scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isdefined(var_00.pers["postGameMerits"]))
		{
			var_00.pers["postGameMerits"] = 0;
		}

		var_00 thread func_989A();
		if(isai(var_00))
		{
			continue;
		}

		var_00 thread func_B9B2();
	}
}

//Function Number: 4
func_989A()
{
	self.pers["lastBulletKillTime"] = 0;
	self.pers["bulletStreak"] = 0;
	self.var_6A00 = [];
}

//Function Number: 5
func_DEFE(param_00,param_01)
{
	if(!isdefined(level.var_B682[param_00]))
	{
		level.var_B682[param_00] = [];
	}

	level.var_B682[param_00][level.var_B682[param_00].size] = param_01;
}

//Function Number: 6
func_7FB3(param_00)
{
	if(isdefined(self.var_B683[param_00]))
	{
		return self.var_B683[param_00];
	}

	return 0;
}

//Function Number: 7
func_BD74(param_00,param_01)
{
	var_02 = param_00.var_4F;
	var_03 = param_00.var_13372;
	if(!isdefined(var_02) || !isplayer(var_02))
	{
		return;
	}

	var_02 func_D9AD("mt_kills");
}

//Function Number: 8
func_6563(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("disconnect");
	var_08 = spawnstruct();
	var_08.var_13372 = self;
	var_08.var_6000 = param_00;
	var_08.var_4F = param_01;
	var_08.var_92BA = param_02;
	var_08.var_10367 = param_03;
	var_08.var_11329 = param_04;
	var_08.var_10AA6 = param_05;
	var_08.var_FE38 = param_06;
	var_08.time = gettime();
	var_08.var_B930 = param_07;
	var_08.var_1337E = var_08.var_13372 isonground();
	func_5905("enemyKilled",var_08);
	var_08.var_4F notify("playerKilledMeritsProcessed");
}

//Function Number: 9
func_5905(param_00,param_01)
{
	if(!func_B4E9())
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

	if(getdvarint("disable_merits") > 0)
	{
		return;
	}

	if(!isdefined(level.var_B682[param_00]))
	{
		return;
	}

	if(isdefined(param_01))
	{
		for(var_03 = 0;var_03 < level.var_B682[param_00].size;var_03++)
		{
			thread [[ level.var_B682[param_00][var_03] ]](param_01);
		}

		return;
	}

	for(var_03 = 0;var_03 < level.var_B682[param_00].size;var_03++)
	{
		thread [[ level.var_B682[param_00][var_03] ]]();
	}
}

//Function Number: 10
func_D95D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isplayer(param_01))
	{
		if(isdefined(param_01.var_222) && isplayer(param_01.var_222))
		{
			param_01 = param_01.var_222;
		}
		else
		{
			return;
		}
	}

	var_09 = scripts\cp\_utility::func_821F(param_04);
	var_0A = scripts\common\utility::istrue(param_01.inlaststand);
	var_0B = scripts\common\utility::func_9D74(param_03);
	var_0C = param_01 getstance();
	var_0D = self.var_1096F;
	var_0E = var_0C == "crouch";
	var_0F = var_0C == "prone" && !var_0A;
	var_10 = function_0107(param_03);
	var_11 = param_03 == "MOD_MELEE";
	var_12 = (scripts\common\utility::istrue(self.var_9B81) || scripts\common\utility::istrue(self.var_9B8A)) && !var_0B || param_04 == "incendiary_ammo_mp";
	var_13 = scripts\common\utility::istrue(self.var_565C);
	var_14 = scripts\common\utility::istrue(self.shockmelee);
	var_15 = param_01 method_81BE();
	var_16 = scripts\common\utility::istrue(self.faf_burned_out);
	if(isdefined(param_00.var_222))
	{
		var_17 = param_01 scripts\cp\_utility::func_9CEB(param_00,param_04) && param_00.var_222 == param_01;
	}
	else
	{
		var_17 = param_02 scripts\cp\_utility::func_9CEB(param_01,param_05);
	}

	var_18 = 0;
	foreach(var_1A in getarraykeys(level.var_1BED))
	{
		if(scripts\cp\_utility::func_80D8(param_04) == var_1A)
		{
			if(getdvar("ui_mapname") == "cp_final" && var_1A == "arclassic")
			{
				var_18 = 0;
			}
			else
			{
				var_18 = 1;
			}

			break;
		}
	}

	var_1C = isdefined(param_04) && param_04 == "iw7_dischorddummy_zm" || param_04 == "iw7_facemelterdummy_zm" || param_04 == "iw7_headcutterdummy_zm" || param_04 == "iw7_shredderdummy_zm";
	var_1D = isdefined(param_04) && issubstr(param_04,"venomx");
	var_1E = isdefined(param_04) && param_04 == "iw7_entangler2_zm" || param_04 == "ghost_grenade_launcher";
	var_1F = undefined;
	if(isdefined(param_04))
	{
		var_1F = scripts\cp\_utility::func_80D8(param_04);
	}

	var_20 = isdefined(var_1F) && var_1F == "harpoon1" || var_1F == "harpoon2" || var_1F == "harpoon3" || var_1F == "harpoon4";
	if(var_18)
	{
		if(issubstr(param_04,"g18_"))
		{
			var_18 = isdefined(param_01.var_8BA0);
		}

		if(isdefined(param_01.pap2_card_weapon) && param_04 == param_01.pap2_card_weapon)
		{
			var_18 = 0;
		}
	}

	if(var_10)
	{
		if(issubstr(param_04,"shuriken"))
		{
			var_10 = 0;
		}
		else if(scripts\common\utility::istrue(param_01.kung_fu_mode))
		{
			var_10 = 0;
		}
	}

	var_21 = issubstr(param_04,"longshot");
	var_22 = param_01 scripts\cp\_utility::func_4626(param_04) == "weapon_sniper" && var_0B;
	var_23 = var_0B && scripts\cp\_utility::func_9E27(param_04,param_06,param_03,param_01) && !var_1D;
	var_24 = issubstr(param_04,"m8");
	if(!var_11)
	{
		switch(var_09)
		{
			case "weapon_assault":
				param_01 func_D9AD("mt_ar_kills");
				break;

			case "weapon_smg":
				param_01 func_D9AD("mt_smg_kills");
				break;

			case "weapon_lmg":
				param_01 func_D9AD("mt_lmg_kills");
				break;

			case "weapon_shotgun":
				param_01 func_D9AD("mt_shotgun_kills");
				break;

			case "weapon_sniper":
				if(!var_21 && !var_24)
				{
					param_01 func_D9AD("mt_sniper_kills");
				}
				else if(var_21 && !lib_0CBC::checkaltmodestatus(param_04))
				{
					param_01 func_D9AD("mt_shotgun_kills");
				}
				else if(var_21 && lib_0CBC::checkaltmodestatus(param_04))
				{
					param_01 func_D9AD("mt_sniper_kills");
				}
				else if(var_24 && !lib_0CBC::checkaltmodestatus(param_04))
				{
					param_01 func_D9AD("mt_ar_kills");
				}
				else if(var_24 && lib_0CBC::checkaltmodestatus(param_04))
				{
					param_01 func_D9AD("mt_sniper_kills");
				}
				break;

			case "weapon_pistol":
				param_01 func_D9AD("mt_pistol_kills");
				break;

			case "other":
				if(var_1C)
				{
					param_01 func_D9AD("mt_pistol_kills");
				}
				break;

			default:
				break;
		}
	}

	switch(var_0D)
	{
		case "zombie":
			if(self.agent_type != "alien_rhino" && self.agent_type != "alien_phantom" && self.agent_type != "alien_goon")
			{
				param_01 func_D9AD("mt_zombie_kills");
			}
			break;

		default:
			break;
	}

	if(var_10)
	{
		param_01 func_D9AD("mt_explosive_kills");
	}

	if(var_11)
	{
		param_01 func_D9AD("mt_melee_kills");
	}

	if(var_12)
	{
		param_01 func_D9AD("mt_fire_kills");
	}

	if(var_17)
	{
		param_01 func_D9AD("mt_trap_kills");
	}

	if(var_18)
	{
		param_01 func_D9AD("mt_magic_weapon_kills");
	}

	if(var_23)
	{
		param_01 func_D9AD("mt_headshot_kills");
	}

	if(var_13)
	{
		param_01 func_D9AD("mt_crawler_kills");
	}

	if(var_14)
	{
		param_01 func_D9AD("mt_faf_shock_melee_kills");
	}

	if(var_15)
	{
		param_01 func_D9AD("mt_sliding_kills");
	}

	if(var_1C || var_20)
	{
		param_01 func_D9AD("mt_quest_weapon_kills");
	}

	if(var_16 && var_12)
	{
		param_01 func_D9AD("mt_faf_burned_out_kills");
	}

	if(getdvar("ui_mapname") == "cp_rave")
	{
		if(isdefined(self.agent_type) && self.agent_type == "zombie_sasquatch")
		{
			param_01 func_D9AD("mt_dlc1_sasquatch_kills");
		}

		if(var_11)
		{
			if(param_04 == "iw7_golf_club_mp" || param_04 == "iw7_golf_club_mp_pap1" || param_04 == "iw7_golf_club_mp_pap2")
			{
				param_01 func_D9AD("mt_dlc1_golf_kills");
			}
			else if(param_04 == "iw7_spiked_bat_mp" || param_04 == "iw7_spiked_bat_mp_pap1" || param_04 == "iw7_spiked_bat_mp_pap2")
			{
				param_01 func_D9AD("mt_dlc1_bat_kills");
			}
			else if(param_04 == "iw7_machete_mp" || param_04 == "iw7_machete_mp_pap1" || param_04 == "iw7_machete_mp_pap2")
			{
				param_01 func_D9AD("mt_dlc1_machete_kills");
			}
			else if(param_04 == "iw7_two_headed_axe_mp" || param_04 == "iw7_two_headed_axe_mp_pap1" || param_04 == "iw7_two_headed_axe_mp_pap2")
			{
				param_01 func_D9AD("mt_dlc1_axe_kills");
			}
			else if(param_04 == "iw7_lawnmower_zm")
			{
				param_01 func_D9AD("mt_dlc1_lawnmower_kills");
			}
		}

		if(issubstr(param_04,"harpoon"))
		{
			param_01 func_D9AD("mt_dlc1_harpoon_kills");
		}

		if(scripts\common\utility::istrue(param_01.var_DCEB))
		{
			param_01 func_D9AD("mt_dlc1_kills_in_rave");
		}
	}

	if(getdvar("ui_mapname") == "cp_disco")
	{
		if(param_04 == "iw7_katana_zm_pap2+camo222" || param_04 == "iw7_katana_windforce_zm")
		{
			param_01 func_D9AD("mt_dlc2_pap2_katana");
		}
		else if(param_04 == "iw7_nunchucks_zm_pap2+camo222")
		{
			param_01 func_D9AD("mt_dlc2_pap2_nunchucks");
		}
		else if(param_04 == "heart_cp")
		{
			param_01 func_D9AD("mt_dlc2_heart_kills");
		}

		if(isdefined(self.agent_type) && self.agent_type == "skater")
		{
			param_01 func_D9AD("mt_dlc2_roller_skaters");
		}

		if(var_17)
		{
			param_01 func_D9AD("mt_dlc2_trap_kills");
		}
		else if(scripts\common\utility::istrue(param_01.kung_fu_mode) && !is_crafted_trap_damage(param_04))
		{
			if(param_01.kungfu_style == "dragon")
			{
				param_01 func_D9AD("mt_dlc2_dragon_kills");
			}
			else if(param_01.kungfu_style == "crane")
			{
				param_01 func_D9AD("mt_dlc2_crane_kills");
			}
			else if(param_01.kungfu_style == "snake")
			{
				param_01 func_D9AD("mt_dlc2_snake_kills");
			}
			else if(param_01.kungfu_style == "tiger")
			{
				param_01 func_D9AD("mt_dlc2_tiger_kills");
			}
		}
	}

	if(getdvar("ui_mapname") == "cp_town")
	{
		if(var_11)
		{
			if(param_04 == "iw7_knife_zm_cleaver")
			{
				param_01 func_D9AD("mt_dlc3_cleaver_kills");
			}
			else if(param_04 == "iw7_knife_zm_crowbar")
			{
				param_01 func_D9AD("mt_dlc3_crowbar_kills");
			}
		}
		else if(issubstr(param_04,"cutie"))
		{
			param_01 func_D9AD("mt_dlc3_mad_kills");
		}

		if(isdefined(self.agent_type) && self.agent_type == "crab_mini")
		{
			param_01 func_D9AD("mt_dlc3_crab_mini");
		}

		if(isdefined(param_01.sub_perks) && isdefined(param_01.sub_perks["perk_machine_change"]))
		{
			if(param_01.sub_perks["perk_machine_change"] == "perk_machine_change1")
			{
				param_01.change_chew_1_merit = 1;
			}
			else if(param_01.sub_perks["perk_machine_change"] == "perk_machine_change2")
			{
				param_01.change_chew_2_merit = 1;
			}
			else if(param_01.sub_perks["perk_machine_change"] == "perk_machine_change3")
			{
				param_01.change_chew_3_merit = 1;
			}
			else if(param_01.sub_perks["perk_machine_change"] == "perk_machine_change4")
			{
				param_01.change_chew_4_merit = 1;
			}

			if(scripts\common\utility::istrue(param_01.change_chew_1_merit) && scripts\common\utility::istrue(param_01.change_chew_2_merit) && scripts\common\utility::istrue(param_01.change_chew_3_merit) && scripts\common\utility::istrue(param_01.change_chew_4_merit))
			{
				if(!isdefined(param_01.change_chew_merit_progress))
				{
					param_01 func_D9AD("mt_dlc3_change_chew");
					param_01.change_chew_merit_progress = 1;
				}
			}
		}
	}

	if(getdvar("ui_mapname") == "cp_final")
	{
		if(var_1D)
		{
			param_01 func_D9AD("mt_dlc4_venomx_kills");
		}

		if(var_1E)
		{
			param_01 func_D9AD("mt_dlc4_entangler_kills");
		}

		if(isdefined(self.agent_type))
		{
			if(self.agent_type == "alien_rhino")
			{
				param_01 func_D9AD("mt_dlc4_rhino_kills");
			}
			else if(self.agent_type == "alien_phantom")
			{
				param_01 func_D9AD("mt_dlc4_phantom_kills");
			}
			else if(self.agent_type == "alien_goon")
			{
				param_01 func_D9AD("mt_dlc4_goon_kills");
			}
			else if(self.agent_type == "karatemaster" || self.agent_type == "zombie_clown")
			{
				param_01 func_D9AD("mt_dlc4_special_wave_kills");
			}
		}

		if(var_17)
		{
			param_01 func_D9AD("mt_dlc4_trap_kills");
		}
	}
}

//Function Number: 11
is_crafted_trap_damage(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "iw7_robotzap_zm":
		case "zmb_robotprojectile_mp":
		case "incendiary_ammo_mp":
		case "alien_sentry_minigun_4_mp":
		case "iw7_electrictrap_zm":
			return 1;
	}

	return 0;
}

//Function Number: 12
func_D9AD(param_00,param_01,param_02)
{
	if(!func_B4E9())
	{
		return;
	}

	if(!isplayer(self) || isai(self))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!func_8C4A(param_00))
	{
		return;
	}

	var_03 = func_7FB3(param_00);
	if(var_03 == 5)
	{
		return;
	}

	var_04 = isdefined(level.var_B684[param_00]["operation"]);
	if(var_03 > level.var_B684[param_00]["targetval"].size)
	{
		var_05 = var_03 == level.var_B684[param_00]["targetval"].size + 1;
		var_06 = isdefined(self.var_C637) && isdefined(self.var_C637[param_00]);
		if(var_05 && !var_06)
		{
			var_03 = level.var_B684[param_00]["targetval"].size;
		}
		else
		{
			return;
		}
	}

	var_07 = scripts\cp\_hud_util::func_BD6E(param_00);
	var_08 = level.var_B684[param_00]["targetval"][var_03];
	if(!isdefined(var_08))
	{
		return;
	}

	if(isdefined(param_02) && param_02)
	{
		var_09 = param_01;
	}
	else
	{
		var_09 = var_08 + param_02;
	}

	var_0A = 0;
	if(var_09 >= var_08)
	{
		var_0B = 1;
		var_0A = var_09 - var_08;
		var_09 = var_08;
	}
	else
	{
		var_0B = 0;
	}

	if(var_07 < var_09)
	{
		scripts\cp\_hud_util::func_BD75(param_00,var_09);
	}

	if(var_0B)
	{
		thread func_839C(param_00,var_03);
		func_110AF(param_00);
		func_837F(level.var_B684[param_00]["score"][var_03]);
		var_03++;
		scripts\cp\_hud_util::func_BD76(param_00,var_03);
		self.var_B683[param_00] = var_03;
		if(param_00 != "mt_dlc4_troll2")
		{
			thread scripts\cp\_hud_message::func_10117(param_00);
		}

		if(areallmerittierscomplete(param_00))
		{
			processmastermerit(param_00);
		}
	}
}

//Function Number: 13
areallmerittierscomplete(param_00)
{
	if(self.var_B683[param_00] >= level.var_B684[param_00]["targetval"].size)
	{
		return 1;
	}

	return 0;
}

//Function Number: 14
func_7CCB()
{
	return "cp/zombies/zombie_splashtable.csv";
}

//Function Number: 15
func_110AF(param_00)
{
	if(!isdefined(self.var_B685))
	{
		self.var_B685 = [];
	}

	var_01 = 0;
	foreach(var_03 in self.var_B685)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
		}
	}

	if(!var_01)
	{
		self.var_B685[self.var_B685.size] = param_00;
	}
}

//Function Number: 16
func_110B0(param_00)
{
	if(!isdefined(self.var_C636))
	{
		self.var_C636 = [];
	}

	var_01 = 0;
	foreach(var_03 in self.var_C636)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
			break;
		}
	}

	if(!var_01)
	{
		self.var_C636[self.var_C636.size] = param_00;
	}
}

//Function Number: 17
func_839C(param_00,param_01)
{
	self endon("disconnect");
	wait(0.25);
	scripts\cp\_persistence::give_player_xp(int(level.var_B684[param_00]["reward"][param_01]));
}

//Function Number: 18
func_837F(param_00)
{
	var_01 = self getplayerdata("cp","challengeScore");
	self setplayerdata("cp","challengeScore",var_01 + param_00);
}

//Function Number: 19
func_12ED0()
{
	self.var_B683 = [];
	self endon("disconnect");
	if(!func_B4E9())
	{
		return;
	}

	var_00 = 0;
	foreach(var_05, var_02 in level.var_B684)
	{
		var_00++;
		if(var_00 % 20 == 0)
		{
			wait(0.05);
		}

		self.var_B683[var_05] = 0;
		var_03 = var_02["index"];
		var_04 = scripts\cp\_hud_util::func_BD6F(var_05);
		self.var_B683[var_05] = var_04;
	}
}

//Function Number: 20
func_7FB2(param_00)
{
	return tablelookup("cp/allMeritsTable.csv",0,param_00,5);
}

//Function Number: 21
func_A003(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_7FB2(param_00);
	if(isdefined(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 22
func_8223(param_00)
{
	return func_7FB2(param_00);
}

//Function Number: 23
func_9ECC(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_7FB2(param_00);
	if(isdefined(var_01))
	{
		if(var_01 == "perk_slot_0" || var_01 == "perk_slot_1" || var_01 == "perk_slot_2" || var_01 == "proficiency" || var_01 == "equipment" || var_01 == "special_equipment" || var_01 == "attachment" || var_01 == "prestige" || var_01 == "final_killcam" || var_01 == "basic" || var_01 == "humiliation" || var_01 == "precision" || var_01 == "revenge" || var_01 == "elite" || var_01 == "intimidation" || var_01 == "operations" || scripts\cp\_utility::isstrstart(var_01,"killstreaks_"))
		{
			return 1;
		}
	}

	if(func_A003(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
func_B681(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,10 + param_02 * 3);
	return int(var_03);
}

//Function Number: 25
func_B67E(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,11 + param_02 * 3);
	return int(var_03);
}

//Function Number: 26
func_B67F(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,12 + param_02 * 3);
	return int(var_03);
}

//Function Number: 27
func_3215(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	var_02 = 0;
	for(;;)
	{
		var_04 = tablelookupbyrow(param_00,var_02,0);
		if(var_04 == "")
		{
			break;
		}

		var_05 = getmeritmasterchallenge(var_04);
		level.var_B684[var_04] = [];
		level.var_B684[var_04]["index"] = var_02;
		level.var_B684[var_04]["type"] = param_01;
		level.var_B684[var_04]["targetval"] = [];
		level.var_B684[var_04]["reward"] = [];
		level.var_B684[var_04]["score"] = [];
		level.var_B684[var_04]["filter"] = func_7FB2(var_04);
		level.var_B684[var_04]["master"] = var_05;
		if(func_9ECC(var_04))
		{
			level.var_B684[var_04]["operation"] = 1;
			level.var_B684[var_04]["spReward"] = [];
			if(func_A003(var_04))
			{
				var_06 = func_8223(var_04);
				if(isdefined(var_06))
				{
					level.var_B684[var_04]["weapon"] = var_06;
				}
			}
		}

		for(var_07 = 0;var_07 < 5;var_07++)
		{
			var_08 = func_B681(param_00,var_04,var_07);
			var_09 = func_B67E(param_00,var_04,var_07);
			var_0A = func_B67F(param_00,var_04,var_07);
			if(var_08 == 0)
			{
				break;
			}

			level.var_B684[var_04]["targetval"][var_07] = var_08;
			level.var_B684[var_04]["reward"][var_07] = var_09;
			level.var_B684[var_04]["score"][var_07] = var_0A;
			var_03 = var_03 + var_09;
		}

		var_04 = tablelookupbyrow(param_00,var_02,0);
		var_02++;
	}

	return int(var_03);
}

//Function Number: 28
func_3214()
{
	level.var_B684 = [];
	var_00 = 0;
	var_00 = var_00 + func_3215("cp/allMeritsTable.csv",0);
}

//Function Number: 29
func_9E9C(param_00)
{
	var_01 = level.var_B684[param_00]["filter"];
	if(!isdefined(var_01))
	{
		return 1;
	}

	return self isitemunlocked(var_01,"challenge");
}

//Function Number: 30
func_8C4A(param_00)
{
	return isdefined(level.var_B684) && isdefined(level.var_B684[param_00]);
}

//Function Number: 31
getmeritmasterchallenge(param_00)
{
	var_01 = tablelookup("cp/allMeritsTable.csv",0,param_00,7);
	if(isdefined(var_01) && var_01 == "")
	{
		return undefined;
	}

	return var_01;
}

//Function Number: 32
processmastermerit(param_00)
{
	var_01 = level.var_B684[param_00]["master"];
	if(isdefined(var_01))
	{
		thread func_D9AD(var_01);
	}
}

//Function Number: 33
func_B9B2()
{
	self endon("disconnect");
	self.var_18C1 = 0;
	for(;;)
	{
		if(self method_822E() == 1)
		{
			self.var_18C1 = self.var_18C1 + 0.05;
		}
		else
		{
			self.var_18C1 = 0;
		}

		wait(0.05);
	}
}