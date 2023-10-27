/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3257.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 41
 * Decompile Time: 26 ms
 * Timestamp: 10/27/2023 12:26:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\mp\agents\zombie\zmb_zombie_agent::registerscriptedagent();
	scripts\mp\agents\zombie_brute\zombie_brute_agent::registerscriptedagent();
	lib_0F79::registerscriptedagent();
	level.agent_funcs["generic_zombie"]["on_damaged"] = ::func_C5CD;
	level.agent_funcs["generic_zombie"]["gametype_on_damage_finished"] = ::func_C5CE;
	level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::func_C5D2;
	level.var_93A2 = ::scripts\cp\zombies\zombies_spawning::func_9C12;
	level.var_71D7 = ::func_13FA9;
	level.var_71D6 = ::func_13F5D;
	level.var_BCCE["generic_zombie"] = ::func_E7FD;
	level.var_13FA6 = ::func_6720;
	level.var_4BA8 = 0;
	level.var_7088 = ::scripts\cp\_utility::func_78B4;
}

//Function Number: 2
func_6720()
{
	var_00 = 4096;
	var_01 = [];
	foreach(var_03 in level.var_1647)
	{
		var_04 = 0;
		if(positionwouldtelefrag(var_03.origin))
		{
			continue;
		}

		foreach(var_06 in level.players)
		{
			if(scripts\common\utility::func_13D90(var_06.origin,var_06.angles,var_03.origin,level.var_46A1["90"]))
			{
				var_04 = 1;
			}
		}

		if(!var_04)
		{
			continue;
		}
		else
		{
			var_01[var_01.size] = var_03;
		}
	}

	if(var_01.size == 0)
	{
		var_01 = level.var_1647;
	}

	return scripts\common\utility::random(var_01);
}

//Function Number: 3
func_C5CD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(param_04 != "MOD_SUICIDE")
	{
		if(scripts\mp\_mp_agent::func_9BEA(var_0C,param_01))
		{
			return;
		}

		if(scripts\mp\_mp_agent::func_9BEA(var_0C,param_00))
		{
			return;
		}
	}

	if(!isdefined(param_01))
	{
		param_01 = self;
	}

	var_0D = func_FF2E(param_01,param_02,param_04,param_05,param_08,var_0C);
	if(!var_0D)
	{
		return;
	}

	var_0E = param_04 == "MOD_MELEE";
	var_0F = isdefined(self.var_9E0C) && isdefined(param_05) && !scripts\cp\_weapon::func_9E02(param_05) || param_04 == "MOD_MELEE";
	var_10 = scripts\common\utility::func_9D74(param_04);
	var_11 = isdefined(param_01) && isplayer(param_01);
	var_12 = scripts\cp\_utility::func_9E27(param_05,param_08,param_04,param_01);
	var_13 = (param_01 scripts\cp\_weapon::func_8BD1(param_05,"overclock") || param_01 scripts\cp\_weapon::func_8BD1(param_05,"overclockcp")) && var_10;
	var_14 = scripts\common\utility::istrue(self.var_28E0);
	var_15 = scripts\common\utility::istrue(level.var_9925);
	var_16 = var_12 && var_10 && param_01 scripts\cp\_utility::func_9BA0("headshot_explosion");
	var_17 = param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH";
	var_18 = var_0E && param_01 scripts\cp\_utility::func_9BA0("increased_melee_damage");
	var_19 = 0;
	if(!var_0E && var_11 && !isdefined(param_01.var_AD2C) && param_01 scripts\cp\_utility::func_9BA0("sniper_soft_upgrade"))
	{
		var_19 = param_01 scripts\cp\_utility::func_4626(param_05) == "weapon_sniper";
	}

	var_1A = scripts\common\utility::istrue(level.var_69FA) && isdefined(param_04) && param_04 == "MOD_UNKNOWN";
	var_1B = var_14 || var_15 || var_1A || var_0F || var_13 || var_16 || var_18 || var_19;
	if(var_10)
	{
		param_01 notify("weapon_hit_enemy",self,param_01);
	}

	var_1C = isdefined(self.var_9E0C);
	if(scripts\cp\powers\coop_armageddon::func_9DF5(param_05))
	{
		thread scripts\cp\powers\coop_armageddon::func_6F33(param_00.origin,param_06,param_07);
		return;
	}
	else if(isdefined(param_05) && scripts\cp\_weapon::func_9E02(param_05) && !var_0E)
	{
		if(!var_1C)
		{
			self.var_9E0C = 1;
			thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
		}

		return;
	}
	else if(var_1B)
	{
		if(var_19)
		{
			param_01 scripts\cp\_utility::func_C151("sniper_soft_upgrade");
		}

		param_02 = int(self.maxhealth);
	}
	else
	{
		param_08 = func_FE39(param_01,param_04,param_05,param_08);
		var_1D = level.wave_num;
		var_1E = func_9BF7(param_05,param_04);
		var_1F = scripts\common\utility::istrue(self.var_9B81) && !var_10;
		var_20 = var_0E && param_01 scripts\cp\_utility::func_9BA0("shock_melee_upgrade");
		var_21 = var_12 && param_01 scripts\cp\_utility::func_9BA0("sharp_shooter_upgrade");
		var_22 = var_10 && param_01 scripts\cp\_utility::func_9BA0("bonus_damage_on_last_bullets");
		var_23 = var_10 && param_01 scripts\cp\_utility::func_9BA0("damage_booster_upgrade");
		var_24 = var_10 && isdefined(param_01.var_10932) && param_01.var_10932 == "stun_ammo" || param_01.var_10932 == "combined_ammo";
		var_25 = var_11 && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_boom");
		var_26 = var_11 && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_smack");
		var_27 = func_9B73(param_05);
		if(isdefined(param_02) && isdefined(param_08) && !var_15 && var_10)
		{
			var_28 = lib_0D48::func_D96F(var_0C,param_01,param_02,param_08,param_07);
			if(var_28 <= 0)
			{
				return;
			}

			param_02 = var_28;
		}

		param_02 = func_9830(undefined,param_01,param_02,undefined,param_04,param_05,undefined,undefined,param_08,undefined,undefined,undefined);
		func_FEFA(param_01,var_0C,param_05);
		if(var_11)
		{
			if(var_0E)
			{
				param_02 = int(param_02 * param_01 lib_0CFC::func_CA3A());
				if(var_26)
				{
					param_02 = param_02 + 1500;
				}

				if(var_27)
				{
					if(param_02 >= self.health)
					{
						var_29 = anglestoforward(param_01.angles);
						var_2A = vectornormalize(var_29) * -100;
						self setvelocity(vectornormalize(self.origin - param_01.origin + var_2A) * 400 + (0,0,10));
						self.do_immediate_ragdoll = 1;
						self.var_4C87 = 1;
					}
				}
			}

			if(var_24)
			{
				param_01 thread scripts\cp\zombies\zombie_damage::func_11193(self.origin,self,param_02,param_04);
			}

			if(var_20 && function_024C(param_05) != "riotshield")
			{
				param_01 thread scripts\cp\zombies\zombie_damage::func_11193(self.origin,self,param_02,"MOD_UNKNOWN",undefined,var_20);
			}

			if(var_25 && var_17)
			{
				param_02 = int(param_02 * 2);
			}
		}

		if(var_21)
		{
			param_02 = param_02 * 3;
		}

		if(var_22)
		{
			var_2B = int(param_01 getweaponammoclip(param_01 getcurrentweapon()) + 1);
			var_2C = weaponclipsize(param_01 getcurrentweapon());
			if(var_2B <= 4)
			{
				param_02 = param_02 * 4;
			}
		}

		if(scripts\common\utility::istrue(param_01.var_DF50))
		{
			param_02 = param_02 * 5;
		}

		if(var_1E)
		{
			param_02 = param_02 * min(2 + var_1D * 0.5,10);
		}

		if(var_23)
		{
			param_02 = int(param_02 * 2);
		}
	}

	param_02 = int(min(param_02,self.maxhealth));
	lib_0D5A::func_12D84(param_01,param_02,param_04);
	scripts\cp\_agent_utils::func_D96D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	scripts\cp\_agent_utils::func_D96B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	scripts\cp\_agent_utils::func_110A4(param_01,param_02);
	scripts\cp\zombies\zmb_zombies_weapons::func_1094D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	var_0C [[ level.agent_funcs[var_0C.agent_type]["on_damaged_finished"] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0A,param_0B);
}

//Function Number: 4
func_FF2E(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		return 0;
	}

	if(param_03 == "iw7_armageddonmeteor_mp")
	{
		return 0;
	}

	if(func_9B73(param_03) && param_01 < 10)
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_9BF7(param_00,param_01)
{
	var_02 = param_01 == "MOD_GRENADE_SPLASH" || param_01 == "MOD_GRENADE";
	return var_02 && param_00 == "frag_grenade_zm" || param_00 == "frag_grenade_mp" || param_00 == "throwingknifec4_mp" || param_00 == "gas_grenade_mp" || param_00 == "semtex_mp" || param_00 == "semtex_zm" || param_00 == "c4_mp" || param_00 == "c4_zm" || param_00 == "cluster_grenade_zm";
}

//Function Number: 6
func_C5D2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	scripts\cp\zombies\zombie_scriptable_states::func_1296F(self);
	if(isplayer(param_01))
	{
		param_01 notify("zombie_killed",self,self.origin,param_04,param_03,param_06);
	}

	if(!func_9EC6(self))
	{
		func_6563(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		if(isdefined(level.var_C5D3))
		{
			[[ level.var_C5D3 ]](param_01,param_04);
		}
	}

	param_01 lib_0D59::func_8C9D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	if(isdefined(level.var_108E1))
	{
		[[ level.var_108E1 ]](param_01,param_04);
	}

	if(isdefined(self.var_BE77))
	{
		level thread [[ level.var_B540 ]](self.origin);
	}

	if(isdefined(self.var_BE74))
	{
		if(isdefined(level.var_4297))
		{
			var_09 = level [[ level.var_4297 ]](self);
		}
		else
		{
			var_09 = undefined;
		}

		if(isdefined(level.var_4ADE))
		{
			level notify(level.var_4ADE,self.origin,param_04,var_09);
		}
	}

	self method_818B();
	if(isdefined(self.anchor))
	{
		self.anchor delete();
	}

	self.var_4298 = undefined;
	self.var_24CA = undefined;
	self.var_DD16 = undefined;
	self.head_is_exploding = undefined;
	self.var_BE77 = undefined;
	func_D97C(param_01,self,param_06,param_03,param_04);
	func_D95F(param_01);
	scripts\cp\_challenge::func_12DA9(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	scripts\cp\_merits::func_D95D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	scripts\cp\_agent_utils::func_4DDB();
	lib_0D48::func_403E(self);
}

//Function Number: 7
func_D97C(param_00,param_01,param_02,param_03,param_04)
{
	func_82A2(param_00,param_02,param_03,param_04);
	var_05 = scripts\cp\_agent_utils::func_77D7(param_01);
	var_06 = scripts\cp\_utility::func_7844(param_00);
	if(!isdefined(var_05))
	{
		return;
	}

	if(isdefined(var_06))
	{
		scripts\cp\_persistence::func_DDE9(var_06);
		param_00 thread scripts\cp\_vo::try_to_play_vo("killfirm","zmb_comment_vo","low",10,0,0,0,20);
		if(gettime() < level.var_A8B4 + 5000)
		{
			return;
		}

		if(scripts\cp\_utility::func_462B("pillage") && scripts\common\utility::istrue([[ level.var_CB5B ]](var_05,self.origin,param_00)))
		{
			level.var_A8B4 = gettime();
			return;
		}

		if(scripts\cp\_utility::func_462B("loot") && isdefined(level.var_B07A))
		{
			[[ level.var_B07A ]](var_05,self.origin,param_00);
			return;
		}
	}
}

//Function Number: 8
func_13F43(param_00)
{
	var_01 = 16384;
	var_02 = 0;
	if(level.var_CC11.size)
	{
		foreach(var_04 in level.var_CC11)
		{
			if(distance2dsquared(var_04.origin,self.origin) < var_01)
			{
				var_02 = 1;
			}
		}

		if(var_02)
		{
			return 1;
		}
	}

	if(level.var_12A83.size)
	{
		foreach(var_07 in level.var_12A83)
		{
			if(distance2dsquared(var_07.origin,self.origin) < var_01)
			{
				var_02 = 1;
			}
		}

		if(var_02)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
func_D95F(param_00)
{
	if(!isdefined(self.var_24DA))
	{
		return;
	}

	foreach(var_02 in self.var_24DA)
	{
		if(isdefined(var_02.player))
		{
			if(var_02.player == param_00)
			{
				continue;
			}
			else
			{
				var_02.player scripts\cp\_persistence::func_666A("assists",1);
			}
		}
	}
}

//Function Number: 10
func_82A2(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00.team) && self.team == param_00.team)
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	if(!isplayer(param_00) && !isdefined(param_00.var_222) || !isplayer(param_00.var_222))
	{
		return;
	}

	var_04 = level.agent_definition[scripts\cp\_agent_utils::func_77D7(self)]["reward"];
	if(isdefined(param_02) && param_02 == "MOD_MELEE")
	{
		var_04 = 130;
	}

	var_05 = 0;
	if(isdefined(param_00.var_222))
	{
		param_00 = param_00.var_222;
		var_05 = 1;
	}

	if(scripts\cp\_utility::func_9E27(param_03,param_01,param_02,param_00) && !var_05 && scripts\common\utility::func_9D74(param_02))
	{
		var_04 = int(100);
	}

	func_8373(param_00,var_04,"large",param_01,param_03,param_02);
}

//Function Number: 11
func_8373(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_01 = param_01 * level.var_3B0F;
	if(param_00 scripts\cp\_utility::func_9BA0("extra_sniping_points") && scripts\common\utility::func_9D74(param_05) && param_00 scripts\cp\_utility::func_4626(param_04) == "weapon_sniper")
	{
		param_01 = param_01 + 300;
		param_00 scripts\cp\_utility::func_C151("extra_sniping_points");
	}

	if(func_FF4B(param_00))
	{
		param_00 scripts\cp\_persistence::func_82F9(param_01,param_02,param_03);
	}

	if(func_13C21(param_04))
	{
		foreach(var_07 in level.players)
		{
			if(var_07 == param_00)
			{
				continue;
			}

			if(!var_07 scripts\cp\_utility::is_valid_player())
			{
				continue;
			}

			var_07 scripts\cp\_persistence::func_82F9(param_01,param_02,param_03);
		}
	}

	if(isdefined(level.var_13F56))
	{
		param_00 scripts\cp\_persistence::give_player_xp(int(param_01));
	}
}

//Function Number: 12
func_FF4B(param_00)
{
	if(isplayer(param_00) && scripts\cp\_laststand::player_in_laststand(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
func_13C21(param_00)
{
	return isdefined(param_00) && param_00 == "alien_sentry_minigun_4_mp";
}

//Function Number: 14
func_6563(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level.var_A97B = self.origin;
	if(isdefined(level.var_D99D))
	{
		self thread [[ level.var_D99D ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}
}

//Function Number: 15
func_9EC6(param_00)
{
	if(isdefined(param_00.team))
	{
		return param_00.team == level.var_D437;
	}

	return 0;
}

//Function Number: 16
func_FE39(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00) && isplayer(param_00) && param_01 != "MOD_MELEE" && param_00 scripts\cp\_utility::func_9BA0("sniper_soft_upgrade") && scripts\cp\_utility::func_4626(param_02) == "weapon_sniper")
	{
		return "head";
	}

	if(isdefined(param_00) && isplayer(param_00) && param_01 != "MOD_MELEE" && param_00 scripts\cp\_utility::func_9BA0("increased_limb_damage") && func_9C38(param_02,param_03,param_01,param_00))
	{
		return "torso_upper";
	}

	return param_03;
}

//Function Number: 17
func_FEFA(param_00,param_01,param_02)
{
	if(isdefined(param_00) && isdefined(param_01) && isdefined(param_02) && weaponclass(param_02) == "spread")
	{
		var_03 = "" + gettime();
		if(!isdefined(param_00.var_CA01) || !isdefined(param_00.var_CA01[var_03]))
		{
			param_00.var_CA01 = undefined;
			param_00.var_CA01[var_03] = [];
		}

		if(!isdefined(param_00.var_CA01[var_03][param_01.var_86BD]))
		{
			param_00.var_CA01[var_03][param_01.var_86BD] = 1;
			return;
		}

		if(param_00.var_CA01[var_03][param_01.var_86BD] + 1 > 2)
		{
			return;
		}

		param_00.var_CA01[var_03][param_01.var_86BD]++;
		return;
	}
}

//Function Number: 18
func_9830(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!func_3845(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B))
	{
		return param_02;
	}

	param_02 = func_EBAC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	if(isdefined(param_04) && param_04 == "MOD_MELEE")
	{
		if(!func_9B73(param_05))
		{
			param_02 = 150;
		}

		return param_02;
	}

	return param_02;
}

//Function Number: 19
func_9B73(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "iw6_cphcmelee_mp":
		case "iw7_axe_zm_pap2":
		case "iw7_axe_zm_pap1":
		case "iw7_axe_zm":
			return 1;
	}

	return 0;
}

//Function Number: 20
func_EBAC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = scripts\cp\_utility::func_80D8(param_05);
	switch(var_0C)
	{
		case "shredder":
		case "headcutter":
		case "facemelter":
		case "dischord":
			param_02 = max(7500,self.maxhealth / 2);
			break;
	}

	return param_02;
}

//Function Number: 21
func_3845(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_01))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_01.inlaststand))
	{
		return 0;
	}

	if(!isdefined(param_01.var_C8A2))
	{
		return 0;
	}

	if(!isdefined(param_04))
	{
		return 0;
	}

	if(param_04 == "MOD_SUICIDE")
	{
		return 0;
	}

	if(param_04 == "MOD_UNKNOWN")
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
func_F327(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01))
	{
		if(param_01 == "xm25_mp" && param_00 == "MOD_IMPACT")
		{
			param_02 = 95;
		}

		if(param_01 == "spider_beam_mp")
		{
			param_02 = param_02 * 15;
		}

		if(param_01 == "alienthrowingknife_mp" && param_00 == "MOD_IMPACT")
		{
			if(scripts\cp\_damage::func_381F(param_03,0,param_04,param_00,param_01,param_05,param_06,param_07,param_08,param_09))
			{
				param_02 = 20000;
			}
			else if(scripts\cp\_agent_utils::func_77D7(self) != "elite")
			{
				param_02 = 500;
			}
		}
	}

	return param_02;
}

//Function Number: 23
func_6109(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::istrue(scripts\cp\_laststand::player_in_laststand(param_00)))
	{
		return 0;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	switch(param_01)
	{
		case "MOD_GRENADE":
		case "MOD_GRENADE_SPLASH":
		case "MOD_PISTOL_BULLET":
		case "MOD_RIFLE_BULLET":
		case "MOD_EXPLOSIVE":
		case "MOD_IMPACT":
		case "MOD_MELEE":
			if(param_02 == "gas_grenade_mp" || param_02 == "splash_grenade_zm")
			{
				if(isdefined(param_03.var_6E82))
				{
					if(gettime() > param_03.var_6E82)
					{
						return 1;
					}
					else
					{
						return 0;
					}
				}
			}
			return 1;

		case "MOD_UNKNOWN":
			if(scripts\common\utility::istrue(param_03.var_9B81) && isdefined(param_03.var_6E82))
			{
				if(gettime() > param_03.var_6E82)
				{
					return 1;
				}
			}
			return 0;

		default:
			break;
	}

	if(!scripts\common\utility::istrue(param_03.var_9B81))
	{
		return 1;
	}

	if(!scripts\common\utility::istrue(param_03.var_B36E))
	{
		return 1;
	}

	return 0;
}

//Function Number: 24
func_C5CE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	var_0D = scripts\cp\_utility::func_9CEB(param_00);
	if((isdefined(param_01) && isdefined(param_04) && scripts\common\utility::func_9D74(param_04) || scripts\cp\_utility::func_D0C6(param_01,"combined_ammo") && param_04 == "MOD_EXPLOSIVE_BULLET") || param_05 == "poison_ammo_mp")
	{
		if(isplayer(param_01) || isdefined(param_01.var_222) && isplayer(param_01.var_222))
		{
			if(!var_0D)
			{
				param_01 func_3D9D(self,param_00,param_03,param_05,param_04);
			}
		}
	}

	var_0E = 10 * level.var_3B0F;
	if(isdefined(param_01))
	{
		if(isdefined(param_01.var_CA2F) && param_01.var_CA2F["damagemod"].var_3237 == 2)
		{
			var_0E = var_0E * 2;
		}

		if(func_6109(param_01,param_04,param_05,self))
		{
			if(param_01 scripts\cp\_utility::func_9BA0("hit_reward_upgrade"))
			{
				param_01 scripts\cp\_utility::func_C151("hit_reward_upgrade");
				var_0E = var_0E * 5;
			}

			param_01 scripts\cp\_persistence::func_82F9(var_0E,"large",param_08);
		}
	}

	if(isdefined(param_08) && scripts\cp\_utility::func_9E27(param_05,param_08,param_04,param_01))
	{
		if(param_01 scripts\cp\_utility::func_9BA0("armor_after_headshot"))
		{
			var_0F = 25;
			if(isdefined(param_01.var_2C11))
			{
				var_0F = int(param_01.var_2C11 + 25);
			}

			param_01 notify("enable_armor");
		}
	}
}

//Function Number: 25
func_3D9D(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00 scripts\cp\_utility::func_9CEB(param_01);
	var_06 = param_00 func_FF3A(param_03,param_04,self);
	if(!isdefined(param_00.var_9B51) && isalive(param_00))
	{
		if(scripts\cp\_utility::func_D0C6(self,"combined_ammo") || param_03 == "slayer_ammo_mp")
		{
			var_07 = int(param_00.maxhealth);
			param_00 thread scripts\cp\_utility::func_4D0D(param_00,self,20,var_07,param_04,"slayer_ammo_mp",undefined,"combinedArcane");
		}
	}

	if(!isdefined(param_00.var_9B51) && !isdefined(param_00.var_9B81) && isalive(param_00))
	{
		if(scripts\cp\_utility::func_D0C6(self,"incendiary_ammo") || param_03 == "incendiary_ammo_mp")
		{
			var_07 = min(param_00.maxhealth * 0.66,1000);
			param_00 thread scripts\cp\_utility::func_4D0D(param_00,self,5,var_07,param_04,"incendiary_ammo_mp",undefined,"burning");
		}
	}

	if(var_06 && !var_05)
	{
		self.var_11196 = 1;
		param_00 thread func_75FA();
		param_00 thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(param_00);
		param_02 = param_02 | level.var_92CA;
	}
}

//Function Number: 26
func_75FA()
{
	self endon("death");
	wait(1);
	self.var_11196 = undefined;
}

//Function Number: 27
func_9EDB(param_00)
{
	return isdefined(self.var_CA08) && self.var_CA08;
}

//Function Number: 28
func_FF3A(param_00,param_01,param_02)
{
	if(func_9EDB())
	{
		return 0;
	}

	if(!isalive(self))
	{
		return 0;
	}

	if(scripts\cp\_agent_utils::func_77D7(self) == "elite" || scripts\cp\_agent_utils::func_77D7(self) == "elite_boss")
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_9B81))
	{
		return 0;
	}

	if(isdefined(param_02) && isdefined(param_02.var_3B95) && param_02.var_3B95 == "lightning_tower")
	{
		return 1;
	}

	if(isdefined(param_02) && isplayer(param_02) && param_01 != "MOD_MELEE")
	{
		var_03 = isdefined(param_00) && param_00 == param_02 getcurrentprimaryweapon();
		return var_03 && param_02 scripts\cp\_utility::func_8BB0();
	}

	return 0;
}

//Function Number: 29
func_13FA9()
{
	if(self.entered_playspace)
	{
		return 0;
	}

	if(self.var_8C35 || isdefined(self.var_126CB))
	{
		return 0;
	}

	if(!isdefined(level.var_13D59))
	{
		return 0;
	}

	var_00 = func_7E31();
	if(!isdefined(var_00))
	{
		iprintlnbold("NO ENTRANCE FOUND FOR ZOMBIE AT POS: " + self.origin);
		return 0;
	}

	return 1;
}

//Function Number: 30
func_7E31()
{
	if(isdefined(self.var_4298))
	{
		return self.var_4298;
	}

	self.var_4298 = scripts\cp\_utility::func_78B4(self.origin);
	return self.var_4298;
}

//Function Number: 31
func_13F5D()
{
	self endon("death");
	var_00 = func_7E31();
	if(!isdefined(var_00))
	{
		iprintlnbold("NO ENTRANCE FOUND FOR ZOMBIE AT POS: " + self.origin);
		return 0;
	}

	if(!scripts\common\utility::istrue(self.var_DD16))
	{
		if(!isdefined(self.var_24CA))
		{
			var_01 = lib_0D4D::func_7B4C(var_00);
			if(!var_01.var_C2CF)
			{
				var_01.var_C2CF = 1;
			}

			self.var_24CA = var_01;
		}

		self.var_180 = 1;
		self method_8287(32);
		self method_8286(self.var_24CA.origin);
		self waittill("goal_reached");
		self.var_DD16 = 1;
	}

	while(lib_0D4D::func_664D(var_00))
	{
		if(!isdefined(self.var_24CA))
		{
			var_01 = lib_0D4D::func_7B4C(var_00);
			if(!var_01.var_C2CF)
			{
				var_01.var_C2CF = 1;
			}

			self.var_24CA = var_01;
		}

		self method_8287(16);
		self method_8286(self.var_24CA.origin);
		self waittill("goal_reached");
		if(!isdefined(var_00.var_13D36))
		{
			if(isdefined(var_00.var_24C6))
			{
				var_00.var_13D36 = spawn("script_origin",var_00.var_24C6.origin);
			}
			else
			{
				var_00.var_13D36 = spawn("script_origin",var_00.origin + (0,0,20));
			}

			var_00.var_13D36 setcandamage(1);
			var_00.var_13D36.health = 100000;
			var_00.var_13D36.team = "allies";
		}

		if(func_FF14())
		{
			func_24BD();
			continue;
		}

		func_2FB2(var_00);
	}

	self.var_180 = 0;
	return 0;
}

//Function Number: 32
func_FF14()
{
	var_00 = 100;
	self.var_4299 = func_78C1(self);
	if(!isdefined(self.var_4299))
	{
		return 0;
	}

	if(randomint(100) > var_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
func_101E3()
{
	var_00 = 55;
	var_01 = self.origin + (0,0,var_00);
	var_02 = self.var_4299.origin + (0,0,var_00);
	return sighttracepassed(var_01,var_02,0,self);
}

//Function Number: 34
func_78C1(param_00)
{
	if(!level.current_interaction_structs.size)
	{
		return undefined;
	}

	var_01 = scripts\common\utility::func_782F(param_00.origin,level.players)[0];
	var_02 = scripts\common\utility::getclosest(param_00.origin,level.current_interaction_structs);
	if(!func_9C78(var_01,var_02))
	{
		var_01 = undefined;
	}

	return var_01;
}

//Function Number: 35
func_9C78(param_00,param_01)
{
	var_02 = 2304;
	return distancesquared(param_00.origin,param_01.origin) < var_02;
}

//Function Number: 36
func_24BD()
{
	self.var_4B26 = self.var_4299;
	lib_0A1B::func_2965(self.var_4B26);
	var_00 = scripts\common\utility::func_13734("attack_hit","attack_miss");
	var_01 = scripts\common\utility::getclosest(self.origin,level.current_interaction_structs);
	if(func_9C78(self.var_4299,var_01))
	{
		lib_0C73::func_5904(self.var_4299,lib_0C73::func_7AD3(),"MOD_IMPACT");
	}
}

//Function Number: 37
func_2FB2(param_00)
{
	self.var_4B26 = param_00.var_13D36;
	lib_0A1B::func_2965(self.var_4B26);
	scripts\common\utility::waittill_any_3("attack_hit","attack_miss");
	lib_0D4D::func_DFCB(param_00);
	if(!lib_0D4D::func_664D(param_00))
	{
		if(isdefined(param_00.var_13D36))
		{
			param_00.var_13D36 delete();
		}

		lib_0A1B::func_2914();
		self.var_4B26 = undefined;
		self.var_180 = 0;
		self.ignoreme = 0;
		self.var_24CA = undefined;
		thread func_A5F6();
	}
}

//Function Number: 38
func_A5F6()
{
	self endon("death");
	if(!isdefined(level.var_46A1))
	{
		level.var_46A1 = [];
	}

	if(!isdefined(level.var_46A1["60"]))
	{
		level.var_46A1["60"] = cos(60);
	}

	var_00 = 0;
	var_01 = self.origin;
	wait(randomintrange(5,8));
	while(!scripts\common\utility::istrue(self.entered_playspace))
	{
		var_02 = var_01;
		var_01 = self.origin;
		var_03 = 0;
		if(distance2dsquared(var_02,var_01) < 100)
		{
			foreach(var_05 in level.players)
			{
				if(distancesquared(var_05.origin,self.origin) < 4000000)
				{
					if(scripts\common\utility::func_13D90(var_05.origin,var_05.angles,self.origin,level.var_46A1["60"]))
					{
						var_06 = var_05 geteye();
						if(scripts\common\trace::func_DCF1(var_06,self.origin + (0,0,40),self))
						{
							var_03 = 1;
						}
					}
				}
			}

			if(var_03)
			{
				wait(2);
				continue;
			}

			var_00 = 1;
			break;
		}
		else
		{
			wait(2);
		}
	}

	if(!var_00)
	{
		return;
	}

	self.var_54CB = 1;
	if(scripts\common\utility::istrue(self.var_B36D) && isdefined(level.var_C20A))
	{
		level.var_C20A--;
	}

	self dodamage(self.health + 1000,self.origin,self,self,"MOD_SUICIDE");
}

//Function Number: 39
zombies_should_mutilate(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(param_04))
	{
		switch(param_04)
		{
			case "MOD_PROJECTILE_SPLASH":
			case "MOD_GRENADE":
			case "MOD_GRENADE_SPLASH":
			case "MOD_EXPLOSIVE":
				return 1;

			case "MOD_MELEE":
				if(isdefined(param_01) && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_smack"))
				{
					return 1;
				}
				else
				{
					return 0;
				}
	
				break;

			default:
				break;
		}
	}

	if(isdefined(param_05))
	{
		var_09 = weaponclass(param_05);
		if(isdefined(var_09) && var_09 == "spread")
		{
			return 1;
		}

		var_0A = getweaponbasename(param_05);
		if(isdefined(var_0A))
		{
			switch(var_0A)
			{
				case "iw7_m8_zm":
				case "iw7_kbs_zm":
				case "iw7_chargeshot_zm":
				case "iw7_shredder_zm":
					return 1;

				default:
					break;
			}
		}
	}

	return 0;
}

//Function Number: 40
func_9C38(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		if(isdefined(param_03.var_222))
		{
			if(param_03.var_9F == "script_vehicle")
			{
				return 0;
			}

			if(param_03.var_9F == "misc_turret")
			{
				return 0;
			}

			if(param_03.var_9F == "script_model")
			{
				return 0;
			}
		}

		if(isdefined(param_03.agent_type))
		{
			if(param_03.agent_type == "dog" || param_03.agent_type == "alien")
			{
				return 0;
			}
		}
	}

	return param_01 == "left_leg_upper" || param_01 == "right_foot" || param_01 == "left_leg_lower" || param_01 == "right_leg_lower" || param_01 == "left_foot" || param_01 == "right_leg_upper" || param_01 == "right_arm_lower" || param_01 == "left_arm_lower" || param_01 == "right_hand" || param_01 == "left_hand";
}

//Function Number: 41
func_E7FD(param_00)
{
	var_01 = scripts\mp\agents\zombie\zmb_zombie_agent::func_378F(param_00);
	if(level.var_5274 - level.var_4B6E == 1)
	{
		if(var_01 != "sprint")
		{
			return "run";
		}
	}

	return var_01;
}