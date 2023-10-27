/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3260.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 71
 * Decompile Time: 98 ms
 * Timestamp: 10/27/2023 12:26:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.createfx_enabled) && level.createfx_enabled)
	{
		return;
	}

	level thread func_B982();
	if(!scripts\common\utility::istrue(level.generic_zombie_agent_func_init_done))
	{
		level.agent_funcs["generic_zombie"]["on_damaged"] = ::func_C5CD;
		level.agent_funcs["generic_zombie"]["gametype_on_damage_finished"] = ::func_C5CE;
		level.agent_funcs["generic_zombie"]["gametype_on_killed"] = ::func_C5D2;
		level.generic_zombie_agent_func_init_done = 1;
	}

	level.agent_funcs["zombie_brute"]["on_damaged"] = ::func_C5CD;
	level.agent_funcs["zombie_brute"]["gametype_on_damage_finished"] = ::func_C5CE;
	level.agent_funcs["zombie_brute"]["gametype_on_killed"] = ::func_C5D2;
	level.var_3762 = ::func_3759;
	level.agent_funcs["c6"]["on_damaged"] = ::func_C5CD;
	level.agent_funcs["c6"]["gametype_on_damage_finished"] = ::func_C5CE;
	level.agent_funcs["c6"]["gametype_on_killed"] = ::func_C5D2;
	level.agent_funcs["the_hoff"]["on_damaged"] = ::onhoffdamaged;
	level.agent_funcs["the_hoff"]["gametype_on_damage_finished"] = ::func_C5CE;
	level.agent_funcs["the_hoff"]["gametype_on_killed"] = ::func_C5D2;
	level.var_768B = ::func_777C;
	level.var_93A2 = ::scripts\cp\zombies\zombies_spawning::func_9C12;
	level.var_71D7 = ::func_13FA9;
	level.var_BCCE["generic_zombie"] = ::func_E7FD;
	if(!isdefined(level.eligable_for_reward_func))
	{
		level.eligable_for_reward_func = ::base_eligable_for_reward_func;
	}

	if(!isdefined(level.should_do_damage_check_func))
	{
		level.should_do_damage_check_func = ::base_should_do_damage_check;
	}

	level.var_A8B4 = gettime();
	level.var_7456 = ::scripts\cp\zombies\zombie_scriptable_states::func_7383;
	level.var_11768 = ::scripts\cp\zombies\zombie_scriptable_states::func_12B9A;
	level thread func_97BA();
	level.var_7089 = ::func_78C1;
	level.var_7088 = ::scripts\cp\_utility::func_78B4;
	level.no_pain_volume = getent("no_pain_volume","targetname");
}

//Function Number: 2
base_eligable_for_reward_func(param_00,param_01,param_02,param_03,param_04,param_05)
{
	return 1;
}

//Function Number: 3
base_should_do_damage_check(param_00,param_01,param_02,param_03,param_04,param_05)
{
	return 1;
}

//Function Number: 4
onhoffdamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
}

//Function Number: 5
func_C5CD(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(!isdefined(self.agent_type))
	{
		return;
	}

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

	param_03 = param_03 | 4;
	var_0E = isdefined(var_0C.agent_type) && var_0C.agent_type == "zombie_brute";
	var_0F = isdefined(var_0C.agent_type) && var_0C.agent_type == "zombie_grey";
	var_10 = isdefined(var_0C.agent_type) && var_0C.agent_type == "slasher";
	var_11 = isdefined(var_0C.agent_type) && var_0C.agent_type == "superslasher";
	var_12 = scripts\common\utility::istrue(var_0C.var_9CDD);
	var_13 = param_04 == "MOD_MELEE";
	var_14 = scripts\common\utility::istrue(param_01.inlaststand);
	var_15 = isdefined(self.var_9E0C) && isdefined(param_05) && !scripts\cp\_weapon::func_9E02(param_05) || param_04 == "MOD_MELEE";
	var_16 = scripts\cp\_weapon::func_9D3D(param_05);
	var_17 = scripts\common\utility::func_9D74(param_04) || param_04 == "MOD_EXPLOSIVE_BULLET" && param_08 != "none";
	var_18 = isdefined(param_01) && isplayer(param_01);
	var_19 = var_17 && scripts\cp\_utility::func_9E27(param_05,param_08,param_04,param_01);
	var_1A = (param_01 scripts\cp\_weapon::func_8BD1(param_05,"overclock") || param_01 scripts\cp\_weapon::func_8BD1(param_05,"overclockcp")) && var_17;
	var_1B = scripts\common\utility::istrue(self.var_28E0);
	var_1C = scripts\common\utility::istrue(level.var_9925) && !var_0E && !var_0F;
	var_1D = !var_14 && var_19 && var_17 && param_01 scripts\cp\_utility::func_9BA0("headshot_explosion");
	var_1E = (param_04 == "MOD_EXPLOSIVE_BULLET" && isdefined(param_08) && param_08 == "none") || param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE" || param_04 == "MOD_PROJECTILE_SPLASH";
	var_1F = var_13 && param_01 scripts\cp\_utility::func_9BA0("increased_melee_damage");
	var_20 = scripts\common\utility::istrue(self.var_9340);
	var_21 = scripts\cp\_utility::func_9D3E(param_05);
	var_22 = var_13 && param_01 scripts\cp\_utility::func_9BA0("shock_melee_upgrade");
	if(isdefined(param_05) && issubstr(param_05,"iw7_gauss_zml"))
	{
		var_23 = 250;
		if(scripts\cp\_utility::func_13C90(param_05,"pap1"))
		{
			var_23 = 470;
		}

		if(scripts\cp\_utility::func_13C90(param_05,"pap2"))
		{
			var_23 = 734;
		}

		if(scripts\cp\_utility::func_13C90(param_05,"doubletap"))
		{
			var_23 = 1.33 * var_23;
		}

		if(param_02 >= var_23)
		{
			self.hitbychargedshot = param_01;
		}
	}

	if(isplayer(param_01))
	{
		if(scripts\common\utility::istrue(self.marked_shared_fate_fnf))
		{
			param_01 notify("weapon_hit_marked_target",param_01,param_02,param_04,param_05,self);
		}

		if(issubstr(param_05,"iw7_harpoon2_zm"))
		{
			param_01 notify("zombie_hit_by_ben",param_06,self,self.maxhealth);
		}
	}

	if(var_18)
	{
		self.damaged_by_player = 1;
		if(scripts\common\utility::istrue(param_01.stimulus_active))
		{
			playfx(level._effect["stimulus_glow_burst"],self gettagorigin("j_spineupper"));
			scripts\common\utility::play_sound_in_space("zmb_fnf_stimulus",self gettagorigin("j_spineupper"));
			foreach(var_25 in level.players)
			{
				if(var_25 == param_01)
				{
					if(distance2dsquared(var_25.origin,self.origin) <= 10000)
					{
						playfx(level._effect["stimulus_glow_burst"],self gettagorigin("j_spineupper"));
						playfx(level._effect["stimulus_shield"],var_25 gettagorigin("tag_eye"),anglestoforward(var_25.angles),anglestoup(var_25.angles),var_25);
						if(param_02 >= self.health)
						{
							if(scripts\common\utility::istrue(var_25.inlaststand))
							{
								lib_0D59::revive_downed_entities(var_25);
							}
						}

						if(var_25.health + param_02 / level.players.size + 1 >= var_25.maxhealth)
						{
							var_25.health = var_25.maxhealth;
						}
						else
						{
							var_25.health = int(var_25.health + param_02 / level.players.size + 1);
						}
					}

					continue;
				}

				if(distance2dsquared(var_25.origin,self.origin) <= 10000)
				{
					playfx(level._effect["stimulus_glow_burst"],self gettagorigin("j_spineupper"));
					playfx(level._effect["stimulus_shield"],var_25 gettagorigin("tag_eye"));
					if(param_02 >= self.health)
					{
						if(scripts\common\utility::istrue(var_25.inlaststand))
						{
							lib_0D59::revive_downed_entities(var_25);
						}
					}

					if(int(var_25.health + param_02 / level.players.size + 1) >= var_25.maxhealth)
					{
						var_25.health = var_25.maxhealth;
						continue;
					}

					var_25.health = int(var_25.health + param_02 / level.players.size + 1);
				}
			}
		}

		if(scripts\common\utility::istrue(param_01.deadeye_charge))
		{
			param_02 = param_02 * 1.25;
		}
	}

	if(isdefined(param_01.var_9CEF) && param_01.var_9CEF && param_04 != "MOD_SUICIDE")
	{
		if(var_0E)
		{
			param_02 = int(param_02 * 1.5);
		}
		else
		{
			param_02 = param_01.var_B57A;
		}
	}

	var_27 = 0;
	if(!var_13 && checkaltmodestatus(param_05) && var_18 && !isdefined(param_01.var_AD2C) && param_01 scripts\cp\_utility::func_9BA0("sniper_soft_upgrade"))
	{
		var_27 = param_01 scripts\cp\_utility::func_4626(param_05) == "weapon_sniper";
	}

	var_28 = scripts\common\utility::istrue(level.var_69FA) && isdefined(param_04) && param_04 == "MOD_UNKNOWN";
	if(var_28 && var_0F || var_0E)
	{
		return;
	}

	var_29 = !var_0E && !var_0F && var_1B || var_1C || var_22 || var_28 || var_15 || var_1A || var_1D || var_1F || var_27;
	var_2A = isdefined(self.var_9E0C);
	if(scripts\cp\powers\coop_armageddon::func_9DF5(param_05) && !var_0E && !var_0F)
	{
		thread scripts\cp\powers\coop_armageddon::func_6F33(param_00.origin,param_06,param_07);
		return;
	}
	else if(isdefined(param_05) && scripts\cp\_weapon::func_9E02(param_05) && !var_13 && !var_16)
	{
		var_2B = param_01 scripts\cp\_weapon::func_7D62(param_05);
		var_2C = func_800A(self,var_2B);
		if(!var_2A && !var_20 && !var_0E && !var_12)
		{
			var_2D = 10 * level.var_3B0F;
			if(param_01 scripts\cp\_utility::func_9BA0("hit_reward_upgrade"))
			{
				param_01 scripts\cp\_utility::func_C151("hit_reward_upgrade");
				var_2D = var_2D * 2;
			}

			param_01 scripts\cp\_persistence::func_82F9(var_2D,"large",param_08);
			param_01 notify("weapon_hit_enemy",self,param_01,param_05,param_02,param_08,param_04);
			if(param_05 == "zfreeze_semtex_mp" || isdefined(self.var_7455) && self.var_7455 >= var_2C || var_1C)
			{
				self.var_7455 = undefined;
				self.var_9E0C = 1;
				thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
			}
			else if(isdefined(self.var_7455))
			{
				self.var_7455++;
				if(var_2C > 15 && self.var_7455 >= 8)
				{
					self.allowpain = 1;
				}

				if(self.var_7455 / var_2C > 0.33)
				{
					self.var_1031A = 1;
				}

				thread scripts\cp\zombies\zombie_scriptable_states::func_E123(self);
			}
			else
			{
				self.var_7455 = 1;
				thread scripts\cp\zombies\zombie_scriptable_states::func_E123(self);
				thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self,var_2B);
			}
		}
		else if(var_12)
		{
			if(isdefined(self.var_7455))
			{
				self.var_7455++;
			}
			else
			{
				self.var_7455 = 1;
			}

			if(self.var_7455 <= var_2C)
			{
				return;
			}
			else
			{
				param_02 = self.maxhealth;
			}
		}
		else
		{
			return;
		}
	}
	else if(!var_2A && var_16)
	{
		return;
	}
	else if(var_29 && !var_0E && !var_0F)
	{
		if(var_27)
		{
			param_01 scripts\cp\_utility::func_C151("sniper_soft_upgrade");
		}

		param_02 = int(self.maxhealth);
		if(var_22)
		{
			if(isdefined(param_06))
			{
				playfx(level._effect["shock_melee_impact"],param_06);
			}

			param_01 thread scripts\cp\zombies\zombie_damage::func_11193(self geteye(),self,self.maxhealth,"MOD_UNKNOWN",undefined,var_22);
		}

		if(var_17)
		{
			param_01 notify("weapon_hit_enemy",self,param_01,param_05,param_02,param_08,param_04);
		}
	}
	else if(!var_0F)
	{
		param_08 = func_FE39(param_01,param_04,param_05,param_08);
		var_2E = level.wave_num;
		var_2F = func_9BF7(param_05,param_04);
		var_30 = scripts\common\utility::istrue(self.var_9B81) && !var_17;
		var_31 = var_19 && param_01 scripts\cp\_utility::func_9BA0("sharp_shooter_upgrade");
		var_32 = var_17 && param_01 scripts\cp\_utility::func_9BA0("bonus_damage_on_last_bullets");
		var_33 = var_17 && param_01 scripts\cp\_utility::func_9BA0("damage_booster_upgrade");
		var_34 = var_17 && isdefined(param_01.special_ammo_weapon) && param_01.special_ammo_weapon == param_05;
		var_35 = var_18 && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_boom");
		var_36 = var_18 && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_smack");
		var_37 = func_9B73(param_05);
		var_38 = weaponclass(param_05) == "spread" && param_01 scripts\cp\_weapon::func_8BD1(param_05,"smart");
		var_39 = weaponclass(param_05) == "spread" && !var_38 && param_01 scripts\cp\_weapon::func_8BD1(param_05,"arkpink") || scripts\cp\_weapon::func_8BD1(param_05,"arkyellow");
		var_3A = var_19 && var_17 && param_01 scripts\cp\_weapon::func_8BD1(param_05,"highcal");
		if(var_21 && issubstr(param_05,"+gl"))
		{
			param_02 = scalegldamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		}

		if(var_38)
		{
			param_02 = param_02 * 0.5;
		}

		if(isdefined(param_02) && isdefined(param_08) && !var_1C && var_17)
		{
			var_3B = lib_0D48::func_D96F(var_0C,param_01,param_02,param_08,param_07);
			if(var_3B <= 0)
			{
				return;
			}

			param_02 = var_3B;
		}

		param_02 = func_9830(undefined,param_01,param_02,undefined,param_04,param_05,undefined,undefined,param_08,undefined,undefined,undefined);
		if(var_39)
		{
			param_02 = param_02 * 4;
		}

		if(var_18)
		{
			if(var_13)
			{
				if(param_01 scripts\cp\_weapon::func_8BD1(param_05,"meleervn"))
				{
					param_02 = param_02 + int(1500 * param_01 scripts\cp\_weapon::func_7D62(param_05));
				}

				param_02 = int(param_02 * param_01 lib_0CFC::func_CA3A());
				if(isdefined(param_01.passive_melee_kill_damage))
				{
					param_02 = param_02 + param_01.passive_melee_kill_damage;
				}

				if(var_36)
				{
					param_02 = param_02 + 1500;
				}

				var_3C = 0;
				if(param_02 >= self.health)
				{
					var_3C = 1;
				}

				if(isdefined(param_01.increased_melee_damage))
				{
					param_02 = param_02 + param_01.increased_melee_damage;
				}

				if(var_37 || var_36)
				{
					if(var_37)
					{
						param_01 notify("axe_melee_hit",param_05,self,param_02);
						if(var_3C && !isdefined(self.var_AAA8))
						{
							thread func_AA56(param_01,param_05,var_36);
							return;
						}
					}
					else if(var_3C)
					{
						self.var_102CD = 1;
					}
				}
				else if(var_3C && param_01.var_134FD == "p1_")
				{
					thread func_107E1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
				}
			}

			if(var_34)
			{
				param_01 thread scripts\cp\zombies\zombie_damage::func_11193(self geteye(),self,param_02,param_04,128);
			}

			if(var_35 && var_1E)
			{
				param_02 = int(param_02 * 2);
			}
		}

		if(var_31)
		{
			param_02 = param_02 * 3;
		}

		if(var_32)
		{
			var_3D = int(param_01 getweaponammoclip(param_01 getcurrentweapon()) + 1);
			var_3E = weaponclipsize(param_01 getcurrentweapon());
			if(var_3D <= 4)
			{
				param_02 = param_02 * 2;
			}
		}

		if(var_17 && scripts\common\utility::istrue(param_01.var_DF50))
		{
			param_02 = param_02 * 2;
		}

		if(var_2F)
		{
			param_02 = param_02 * min(2 + var_2E * 0.5,10);
		}

		if(var_33)
		{
			param_02 = int(param_02 * 2);
		}

		if(var_3A)
		{
			param_02 = param_02 * 1.2;
		}
	}

	if(isdefined(param_01.var_CA2F) && param_01.var_CA2F["damagemod"].var_3237 == 2 && var_17)
	{
		param_02 = param_02 * 1.33;
	}

	if(isdefined(level.var_4D0F))
	{
		if(!scripts\common\utility::flag("start_tracking_dps"))
		{
			scripts\common\utility::flag_set("start_tracking_dps");
		}

		if(isdefined(level.var_5B0F))
		{
			level.var_5B0F = gettime();
		}

		if(isdefined(param_01.var_11A22))
		{
			param_01.var_11A22 = param_01.var_11A22 + param_02;
		}
	}

	param_02 = func_FFBC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	param_02 = func_6BA4(self,param_05,param_02,var_0F,var_0E,var_11,var_10);
	if(var_0E)
	{
		if(isdefined(level.var_3111))
		{
			param_02 = self [[ level.var_3111 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		}
	}

	if(isdefined(param_05) && issubstr(param_05,"arcane") || issubstr(param_05,"ark"))
	{
		param_02 = param_02 * 1.2;
	}

	if(isdefined(level.onzombiedamage_func))
	{
		param_02 = [[ level.onzombiedamage_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	}

	if(isdefined(param_01.special_zombie_damage) && var_0E || var_0F || var_12)
	{
		param_02 = param_02 * param_01.special_zombie_damage;
	}

	if(isplayer(param_01) && scripts\cp\_utility::func_9C42(param_05,1))
	{
		playfx(level._effect["melee_impact"],self gettagorigin("j_neck"),vectortoangles(self.origin - param_01.origin),anglestoup(self.angles),param_01);
	}

	if(isdefined(self.hitbychargedshot) && !self.health - param_02 < 1)
	{
		self.hitbychargedshot = undefined;
	}

	param_02 = int(min(param_02,self.maxhealth));
	if(self.health > 0 && self.health - param_02 <= 0)
	{
		if(self.var_54CB)
		{
			self.died_poorly_health = self.health;
		}

		if(isdefined(self.var_8B66))
		{
			lib_0D5E::func_CB84(self,self.var_8B66,param_01);
		}

		self method_80BB(0,0);
	}

	if(isplayer(param_01))
	{
		if(isdefined(level.var_12EDE))
		{
			level thread [[ level.var_12EDE ]](param_01,param_05,self);
		}

		param_01 notify("weapon_hit_enemy",self,param_01,param_05,param_02,param_08,param_04);
		param_01 thread func_12EC5(getweaponbasename(param_05));
		if(scripts\common\utility::func_9D74(param_04))
		{
			if(!isdefined(param_01.var_154B))
			{
				param_01.var_154B = 1;
			}
			else
			{
				param_01.var_154B++;
			}

			scripts\cp\_persistence::increment_player_career_shots_on_target(param_01);
			scripts\cp\zombies\zombie_analytics::log_playershotsontarget(1,param_01,param_01.var_154B);
		}

		if(!isdefined(param_01.var_FF0A[getweaponbasename(param_05)]))
		{
			param_01.var_FF0A[getweaponbasename(param_05)] = 1;
		}
		else
		{
			param_01.var_FF0A[getweaponbasename(param_05)]++;
		}
	}

	if(var_19 && var_18 && var_2A)
	{
		if(isdefined(self.var_7381))
		{
			self.var_7381 notify("headcutter_cryo_kill",param_01,self);
		}
	}

	lib_0D5A::func_12D84(param_01,param_02,param_04);
	if(!var_0E)
	{
		scripts\cp\_agent_utils::func_D96D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	}

	if(!var_0E)
	{
		scripts\cp\_agent_utils::func_D96B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	}

	scripts\cp\_agent_utils::func_110A4(param_01,param_02);
	scripts\cp\zombies\zmb_zombies_weapons::func_1094D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	if(var_18)
	{
		thread func_BF05(param_01);
	}

	if(var_0F)
	{
		param_02 = greywordamageadjust(param_02,param_05);
	}

	var_0C [[ level.agent_funcs[var_0C.agent_type]["on_damaged_finished"] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0A,param_0B);
}

//Function Number: 6
greywordamageadjust(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = getweaponbasename(param_01);
		if(isdefined(var_02))
		{
			if(var_02 == "iw7_headcutter_zm_pap1" || var_02 == "iw7_dischord_zm_pap1" || var_02 == "iw7_facemelter_zm_pap1" || var_02 == "iw7_shredder_zm_pap1")
			{
				param_00 = param_00 * 1.2;
				param_00 = min(param_00,20000);
			}
		}
	}

	return int(param_00);
}

//Function Number: 7
scalegldamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = param_01 scripts\cp\_weapon::func_7D62(param_05);
	var_0D = param_02 / 110;
	if(!isdefined(var_0C))
	{
		return param_02;
	}

	if(param_04 != "MOD_GRENADE_SPLASH")
	{
		return param_02;
	}

	switch(var_0C)
	{
		case 1:
			return 1000 * var_0D;

		case 2:
			return 1500 * var_0D;

		case 3:
			return 2000 * var_0D;
	}

	return param_02;
}

//Function Number: 8
func_12EC5(param_00)
{
	waittillframeend;
	self notify("updateMagShots_" + param_00);
}

//Function Number: 9
func_800A(param_00,param_01)
{
	return min(int(param_00.maxhealth / 400 / param_01),10);
}

//Function Number: 10
func_FFBC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(param_01.var_4A9A))
	{
		var_0C = "j_crotch";
		if(isdefined(var_0C))
		{
			var_0D = self gettagorigin(var_0C);
			var_0E = distance(var_0D,param_06);
			var_0F = 10;
			if(var_0E <= var_0F)
			{
				param_02 = param_02 * param_01.var_4A9A;
			}
		}
	}

	return param_02;
}

//Function Number: 11
func_FF2E(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_03))
	{
		return 0;
	}

	if(isplayer(param_00) && param_00 method_84D9())
	{
		return 0;
	}

	if(func_9B73(param_03) && param_01 < 10)
	{
		return 0;
	}

	if(![[ level.should_do_damage_check_func ]](param_00,param_01,param_02,param_03,param_04,param_05))
	{
		return 0;
	}

	return 1;
}

//Function Number: 12
func_9BF7(param_00,param_01)
{
	var_02 = param_01 == "MOD_GRENADE_SPLASH" || param_01 == "MOD````_GRENADE";
	return var_02 && param_00 == "throwingknifec4_mp";
}

//Function Number: 13
exploding_touch_fx(param_00)
{
	level endon("game_ended");
	triggerfx(self.var_7542);
	wait(0.5);
	if(isdefined(self.var_7542))
	{
		self.var_7542 delete();
	}
}

//Function Number: 14
func_C5D2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(self.var_1070B))
	{
		self.var_1070B delete();
	}

	if(isdefined(self.var_EF89))
	{
		self.var_EF89 delete();
		self.var_EF89 = undefined;
	}

	if(isplayer(param_01) && param_01 scripts\cp\_utility::func_9BA0("explosive_touch"))
	{
		self.nocorpse = 1;
		self.full_gib = 1;
		if(isdefined(self.var_2C09))
		{
			self.death_by_exp_touch = 1;
		}
	}

	if(issubstr(param_04,"iw7_knife") && isplayer(param_01) && scripts\cp\_utility::func_9C42(param_04))
	{
		param_01 thread func_F640(param_01);
	}
	else if((param_04 == "iw7_axe_zm" || param_04 == "iw7_axe_zm_pap1" || param_04 == "iw7_axe_zm_pap2") && isplayer(param_01) && scripts\cp\_utility::func_9C42(param_04))
	{
		param_01 thread func_F640(param_01);
	}

	if(isdefined(self.var_AD2B))
	{
		self.var_AD2B.var_13F0E = undefined;
		self.var_AD2B = undefined;
	}

	if(!isplayer(param_01))
	{
		if(isdefined(param_01.name))
		{
			if(param_01.name == param_01.var_222.var_A039)
			{
				if(isdefined(param_01.var_222.var_A6C6[param_01.var_222.var_A039]))
				{
					param_01.var_222.var_A6C6[param_01.var_222.var_A039]++;
				}
			}
		}
	}

	if(param_04 == "zmb_imsprojectile_mp")
	{
		for(var_09 = 0;var_09 < level.var_76CD;var_09++)
		{
			if(isdefined(level.var_76CC[var_09]))
			{
				if(level.var_76CC[var_09].var_A039 == "crafted_gascan")
				{
					if(!isdefined(level.var_76CB[level.var_76CC[var_09].name]))
					{
						level.var_76CB[level.var_76CC[var_09].name] = 1;
						continue;
					}

					level.var_76CB[level.var_76CC[var_09].name]++;
				}
			}
		}
	}

	if(issubstr(param_04,"venomx"))
	{
		if(scripts\common\utility::istrue(self.dot_triggered))
		{
			self.dot_triggered = undefined;
		}
	}

	if(isplayer(param_01))
	{
		if(!scripts\common\utility::istrue(level.completed_venomx_pap1_challenges))
		{
			if(isdefined(level.cryptidkillswithvenomx))
			{
				if(level.splchosenagent == "cryptids" && self.agent_type == "alien_goon" || self.agent_type == "alien_phantom")
				{
					if(issubstr(param_04,"venomx"))
					{
						level thread scripts\cp\_utility::add_to_notify_queue("venomx_kill",self,self.origin,param_04,param_03);
						level.cryptidkillswithvenomx++;
					}
				}
			}
		}
		else if(isdefined(level.cryptidkillswithvenomxpap2))
		{
			if(level.splchosenagentpap2 == "special.zombies" && self.agent_type == "alien_goon" || self.agent_type == "alien_phantom" || self.agent_type == "zombie_clown" || self.agent_type == "karatemaster")
			{
				if(level.cryptidkillswithvenomxpap2 >= level.chosen_number_for_morse_code_pap2)
				{
					level.cryptidkillswithvenomxpap2 = level.chosen_number_for_morse_code_pap2;
				}
				else if(issubstr(param_04,"venomx"))
				{
					level thread scripts\cp\_utility::add_to_notify_queue("venomx_pap1_kill",self,self.origin,param_04,param_03);
					level.cryptidkillswithvenomxpap2++;
				}
			}
		}

		if(scripts\common\utility::istrue(self.marked_shared_fate_fnf))
		{
			self.marked_shared_fate_fnf = 0;
			param_01.marked_ents = scripts\common\utility::func_22A9(param_01.marked_ents,self);
			self setscriptablepartstate("shared_fate_fx","inactive",1);
			param_01 notify("weapon_hit_marked_target",param_01,param_02,param_03,param_04,self);
		}

		if(scripts\common\utility::istrue(level.sniper_quest_on))
		{
			level notify("kill_near_bino_with_sniper",param_01,param_04,self);
		}

		if(isdefined(param_01.var_13C37) && param_01.var_13C37 > 1)
		{
			param_01.kill_with_extra_xp_passive = 1;
		}

		var_0A = (param_03 == "MOD_EXPLOSIVE_BULLET" && isdefined(param_06) && param_06 == "none") || param_03 == "MOD_EXPLOSIVE" || param_03 == "MOD_GRENADE_SPLASH" || param_03 == "MOD_PROJECTILE" || param_03 == "MOD_PROJECTILE_SPLASH";
		if(var_0A)
		{
			if(!isdefined(param_01.explosive_kills))
			{
				param_01.explosive_kills = 1;
			}
			else
			{
				param_01.explosive_kills++;
			}

			scripts\cp\_persistence::increment_player_career_explosive_kills(param_01);
		}

		param_01.var_1AB++;
		param_01.var_13C2F = scripts\cp\_utility::func_7DF7(param_04);
		if(!isdefined(param_01.var_190B[param_01.var_13C2F]))
		{
			param_01.var_190B[param_01.var_13C2F] = 1;
		}
		else
		{
			param_01.var_190B[param_01.var_13C2F]++;
		}

		scripts\cp\zombies\zombie_analytics::func_AF92(1,level.wave_num,param_01,param_04,self.agent_type,self.origin);
		if(scripts\common\utility::func_9D74(param_03) && param_04 != "incendiary_ammo_mp" && param_04 != "slayer_ammo_mp")
		{
			if(isdefined(param_06) && scripts\cp\_utility::func_9E27(param_04,param_06,param_03,param_01))
			{
				self playsoundtoplayer("zmb_player_achieve_headshot",param_01);
			}
		}

		if(isdefined(param_01.var_A035))
		{
			foreach(var_0C in level.var_D782)
			{
				if(var_0C.var_13CE0 == param_04)
				{
					if(var_0C.var_13CE0 == param_01.var_A035)
					{
						if(isdefined(param_01.var_A034[param_01.var_A035]))
						{
							param_01.var_A034[param_01.var_A035]++;
							continue;
						}

						param_01.var_A034[param_01.var_A035] = 1;
					}
				}
			}
		}
	}

	if(isdefined(param_01.team))
	{
		if(param_01.team == "allies")
		{
			if(!isplayer(param_01))
			{
				for(var_09 = 0;var_09 < level.var_E4BD;var_09++)
				{
					if(!isdefined(level.var_E4BB[level.var_E4BC[var_09].name]))
					{
						level.var_E4BB[level.var_E4BC[var_09].name] = 1;
						continue;
					}

					level.var_E4BB[level.var_E4BC[var_09].name]++;
				}
			}
		}
	}

	scripts\cp\zombies\zombie_scriptable_states::func_1296F(self);
	if(scripts\common\utility::func_6E34("force_drop_max_ammo") && scripts\common\utility::flag("force_drop_max_ammo") && param_03 != "MOD_SUICIDE")
	{
		if(isdefined(level.drop_max_ammo_func))
		{
			level thread [[ level.drop_max_ammo_func ]](self.origin,param_01,"ammo_max");
		}

		scripts\common\utility::func_6E2A("force_drop_max_ammo");
	}

	var_0E = isdefined(self.agent_type) && self.agent_type == "zombie_brute";
	var_0F = isdefined(self.agent_type) && self.agent_type == "zombie_grey";
	var_10 = scripts\common\utility::istrue(self.var_9CDD);
	if(isdefined(level.var_12EFF) && isplayer(param_01))
	{
		param_01 thread [[ level.var_12EFF ]](self,param_04);
	}

	if(scripts\common\utility::func_9D74(param_03) && getweaponbasename(param_04) == "iw7_atomizer_mp" || scripts\common\utility::istrue(self.atomize_me))
	{
		if(!var_10 && !var_0F && !var_0E)
		{
			self playsound("bullet_atomizer_impact_npc");
			if(isdefined(self.var_2C09))
			{
				self.var_2C09 thread func_CEF1();
				self.var_2C09 hide(1);
			}
		}
	}

	if(isplayer(param_01))
	{
		param_01 notify("zombie_killed",self,self.origin,param_04,param_03);
	}

	if(!func_9EC6(self))
	{
		func_6563(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		if(isdefined(level.var_C5D3))
		{
			[[ level.var_C5D3 ]](param_01,param_04);
		}
	}

	param_01 lib_0D59::func_8C9D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,self);
	if(isdefined(level.var_108E1))
	{
		[[ level.var_108E1 ]](param_01,param_04);
	}

	if(isdefined(self.var_BE77) && !isdefined(self.var_1044D))
	{
		self.var_1044D = 1;
		if(isdefined(param_01.var_A039))
		{
			if(param_01.var_A039 == "crafted_medusa")
			{
				if(!isdefined(param_01.var_A6C6[param_01.var_A039]))
				{
					param_01.var_A6C6[param_01.var_A039] = 1;
				}
				else
				{
					param_01.var_A6C6[param_01.var_A039]++;
				}
			}
		}

		level thread [[ level.var_B540 ]](self.origin,self.var_BE77,scripts\common\utility::istrue(self.var_565C));
	}

	if(isdefined(self.var_BE74) && !var_10)
	{
		if(isdefined(level.var_4297))
		{
			var_11 = level [[ level.var_4297 ]](self);
		}
		else
		{
			var_11 = undefined;
		}

		if(isdefined(var_11))
		{
			if(isdefined(level.var_4ADE))
			{
				thread delayminiufocollection(self.origin,param_04,var_11);
			}
		}
	}

	if(isdefined(level.var_DB5A))
	{
		level thread [[ level.var_DB5A ]](self);
	}

	if(isplayer(param_01) && isdefined(level.var_12EE0))
	{
		level thread [[ level.var_12EE0 ]](param_04,param_01,self,param_03,param_06);
	}

	self method_818B();
	if(isdefined(self.anchor))
	{
		self.anchor delete();
	}

	if(isdefined(self.var_24CA))
	{
		lib_0D4D::func_DF34(self.var_24CA);
	}

	self.var_4298 = undefined;
	self.var_24CA = undefined;
	self.var_DD16 = undefined;
	self.head_is_exploding = undefined;
	self.rocket_feet = undefined;
	self.dischord_spin = undefined;
	self.var_12F77 = undefined;
	self.shredder_death = undefined;
	self.var_BE77 = undefined;
	func_D97C(param_00,param_01,self,param_06,param_03,param_04);
	func_D95F(param_01);
	scripts\cp\_weaponrank::func_12861(param_01,param_04,param_06,param_03,self.agent_type);
	if(isdefined(level.death_challenge_update_func))
	{
		[[ level.death_challenge_update_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}
	else
	{
		scripts\cp\_challenge::func_12DA9(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	scripts\cp\_merits::func_D95D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	param_01 scripts\cp\_utility::func_316C("kill_event_buffered",param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,self.agent_type);
	scripts\cp\_agent_utils::func_4DDB();
	lib_0D48::func_403E(self);
	level notify("zombie_killed",self.origin,param_04,param_03);
}

//Function Number: 15
delayminiufocollection(param_00,param_01,param_02)
{
	if(!isdefined(param_02.expected_souls))
	{
		return;
	}

	param_02.expected_souls++;
	if(param_02.expected_souls > 1)
	{
		wait(0.05 * param_02.expected_souls);
	}

	level notify(level.var_4ADE,param_00,param_01,param_02);
}

//Function Number: 16
func_F640(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00.var_B625 = 1;
	waittillframeend;
	param_00.var_B625 = 0;
}

//Function Number: 17
func_107E1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(param_08 != "neck" && param_08 != "head" && param_08 != "torso_upper")
	{
		wait(0.35);
		playsoundatpos(self.origin,"melee_valleygirl_spoon_drop");
		return;
	}

	if(randomint(100) > 30)
	{
		wait(0.35);
		playsoundatpos(self.origin,"melee_valleygirl_spoon_drop");
		return;
	}

	if(lib_0C73::func_9DD7(param_01,self.var_B607))
	{
		if(isdefined(self.agent_type) && self.agent_type != "zombie_brute" && self.agent_type != "zombie_grey" && self.agent_type != "zombie_clown")
		{
			self.var_10A57 = 1;
			self setscriptablepartstate("spoon","active",1);
			return;
		}

		return;
	}

	wait(0.35);
	playsoundatpos(self.origin,"melee_valleygirl_spoon_drop");
}

//Function Number: 18
func_CEF1()
{
	var_00[0][0]["org"] = self gettagorigin("j_spineupper");
	var_00[0][0]["angles"] = self gettagangles("j_spineupper");
	var_00[0][1]["org"] = self gettagorigin("j_spinelower");
	var_00[0][1]["angles"] = self gettagangles("j_spinelower");
	var_01 = level._effect["atomize_body"];
	foreach(var_03 in var_00)
	{
		foreach(var_05 in var_03)
		{
			playfx(var_01,var_05["org"],anglestoforward(var_05["angles"]));
		}

		wait(0.01);
	}
}

//Function Number: 19
func_FFAB(param_00)
{
	switch(param_00.var_1096F)
	{
		case "zombie_grey":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 20
func_D97C(param_00,param_01,param_02,param_03,param_04,param_05)
{
	func_82A2(param_00,param_01,param_03,param_04,param_05);
	var_06 = scripts\cp\_agent_utils::func_77D7(param_02);
	var_07 = scripts\cp\_utility::func_7844(param_01);
	var_08 = 0;
	var_09 = isdefined(self.var_8B66);
	if(!isdefined(var_06))
	{
		return;
	}

	if(isdefined(var_07))
	{
		var_0A = 0;
		var_0B = scripts\cp\_utility::func_9E27(param_05,param_03,param_04,param_01);
		if(var_0B)
		{
			var_0A = 1;
			if(!isdefined(var_07.var_8CA0[scripts\cp\_utility::func_7DF7(param_05)]))
			{
				var_07.var_8CA0[scripts\cp\_utility::func_7DF7(param_05)] = 1;
				var_07 scripts\cp\_persistence::func_666A("headShots",1);
			}
			else
			{
				var_07.var_8CA0[scripts\cp\_utility::func_7DF7(param_05)]++;
				var_07 scripts\cp\_persistence::func_666A("headShots",1);
			}

			var_07.var_11A25++;
			if(issubstr(param_05,"dischord"))
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_dischord","zmb_comment_vo","high",10,0,0,0,10);
			}
			else if(issubstr(param_05,"facemelter"))
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_melter","zmb_comment_vo","high",10,0,0,0,10);
			}
			else if(issubstr(param_05,"shredder"))
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_shredder","zmb_comment_vo","high",10,0,0,0,10);
			}
			else if(issubstr(param_05,"headcutter"))
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_cutter","zmb_comment_vo","high",10,0,0,0,10);
			}
			else if(issubstr(param_05,"harpoon"))
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_wonder","zmb_comment_vo","high",10,0,0,0,10);
			}
			else if(!scripts\cp\_utility::func_9CEB(param_00,param_05,self))
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_headshot","zmb_comment_vo","low",10,0,0,0,10);
			}
		}
		else if(param_05 == "iw7_forgefreeze_zm+forgefreezealtfire" || param_05 == "iw7_forgefreeze_zm" || param_05 == "alt_iw7_forgefreeze_zm+forgefreezealtfire")
		{
			var_0A = 1;
			var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_freeze","zmb_comment_vo","high",10,0,0,0,10);
		}
		else if(scripts\cp\_utility::func_7DF7(param_05) == "iw7_cutie")
		{
			if(issubstr(param_05,"cutiecrank") ^ issubstr(param_05,"cutiegrip"))
			{
				if(var_07.var_134FD == "p5_" || var_07.var_134FD == "p6_")
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("ww_1","zmb_comment_vo","high",10,0,0,0,10);
				}
				else
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_ww_1","zmb_comment_vo","high",10,0,0,0,10);
				}
			}
			else if(issubstr(param_05,"cutiegrip") && issubstr(param_05,"cutiecrank"))
			{
				if(var_07.var_134FD == "p5_")
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("ww_2","zmb_comment_vo","high",10,0,0,0,10);
				}
				else
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_ww_2","zmb_comment_vo","high",10,0,0,0,10);
				}
			}
			else if(var_07.var_134FD == "p5_" || var_07.var_134FD == "p6_")
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("ww_1","zmb_comment_vo","high",10,0,0,0,10);
			}
			else
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_ww_1","zmb_comment_vo","high",10,0,0,0,10);
			}
		}

		if(var_0A == 0)
		{
			if(randomint(100) > 50)
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm","zmb_comment_vo","low",10,0,0,0,20);
			}
			else
			{
				if(isdefined(param_02.var_13550))
				{
					if(param_02.var_13550 == "zmb_vo_clown_")
					{
						level thread lib_0D62::func_CE9C(param_02,"death",1);
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_clown","zmb_comment_vo","low",10,0,0,0,20);
					}
				}

				if(param_02.agent_type == "zombie_cop")
				{
					if(randomint(100) > 60)
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_cop","zmb_comment_vo","low",10,0,0,0,20);
					}
					else
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm","zmb_comment_vo","low",10,0,0,0,20);
					}
				}
				else if(param_02.agent_type == "alien_goon")
				{
					if(randomint(100) > 60)
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_cryptid","rave_comment_vo","low",10,0,0,0,20);
					}
					else
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm","zmb_comment_vo","low",10,0,0,0,20);
					}
				}
				else if(param_02.agent_type == "zombie_sasquatch")
				{
					if(randomint(100) > 60)
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_sasquatch","rave_comment_vo","low",10,0,0,0,20);
					}
					else
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm","zmb_comment_vo","low",10,0,0,0,20);
					}
				}
				else if(param_02.agent_type == "lumberjack")
				{
					if(randomint(100) > 60)
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_lumberjack","rave_comment_vo","low",10,0,0,0,20);
					}
					else
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm","zmb_comment_vo","low",10,0,0,0,20);
					}
				}
				else if(param_02.agent_type == "zombie_brute")
				{
					level thread lib_0D62::func_CE9C(param_02,"death",1);
				}
				else if(param_02.agent_type == "crab_mini")
				{
					if(randomint(100) > 60)
					{
						if(var_07.var_134FD == "p2_")
						{
							if(!scripts\common\utility::istrue(var_07.played_vo_goon))
							{
								var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_crabgoon_first","rave_comment_vo","low",10,0,0,0,20);
								var_07.played_vo_goon = 1;
							}
							else
							{
								var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_crabgoon","rave_comment_vo","low",10,0,0,0,20);
							}
						}
						else
						{
							var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_crabgoon","rave_comment_vo","low",10,0,0,0,20);
						}
					}
					else
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm","zmb_comment_vo","low",10,0,0,0,20);
					}
				}
				else if(param_02.agent_type == "crab_brute")
				{
					if(randomint(100) > 60)
					{
						if(var_07.var_134FD == "p2_")
						{
							if(!scripts\common\utility::istrue(var_07.played_vo_boss))
							{
								var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_radactivecrab_first","rave_comment_vo","low",10,0,0,0,20);
								var_07.played_vo_boss = 1;
							}
							else
							{
								var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_radactivecrab","rave_comment_vo","low",10,0,0,0,20);
							}
						}
						else
						{
							var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm","zmb_comment_vo","low",10,0,0,0,20);
						}
					}
					else
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm","zmb_comment_vo","low",10,0,0,0,20);
					}
				}
			}
		}
	}

	if(isdefined(self.is_coaster_zombie))
	{
		return;
	}

	if(isdefined(var_07))
	{
		scripts\cp\_persistence::func_DDE9(param_05,param_03,param_04,var_07);
	}

	if(isdefined(level.var_13F36))
	{
		if([[ level.var_13F36 ]](var_06,self.origin,param_01))
		{
			return;
		}
	}

	if(isdefined(var_07))
	{
		if(self isonground())
		{
			var_0E = isdefined(param_02.agent_type) && param_02.agent_type == "zombie_brute" || param_02.agent_type == "zombie_grey";
			if(gettime() < level.var_A8B4 + 5000)
			{
				return;
			}

			if(scripts\cp\_utility::func_65F0(self))
			{
				return;
			}

			if(scripts\cp\_utility::too_close_to_other_interactions(self.origin))
			{
				return;
			}

			if(!var_09 && !var_0E)
			{
				if(scripts\common\utility::func_6E34("can_drop_coins") && scripts\common\utility::flag("can_drop_coins") && isdefined(level.var_47BE) && scripts\common\utility::istrue([[ level.var_47BE ]](var_06,self.origin,param_01)))
				{
					level.var_A8B4 = gettime();
					return;
				}

				if(isdefined(level.var_B07A) && scripts\common\utility::func_6E34("zombie_drop_powerups") && scripts\common\utility::flag("zombie_drop_powerups"))
				{
					[[ level.var_B07A ]](var_06,self.origin,param_01);
					return;
				}

				return;
			}
		}
	}
}

//Function Number: 21
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

//Function Number: 22
func_82A2(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(isdefined(param_01.team) && self.team == param_01.team)
	{
		return;
	}

	var_05 = scripts\mp\_mp_agent::func_77D7(self);
	var_06 = level.agent_definition[var_05]["reward"];
	var_07 = level.agent_definition[var_05]["xp"];
	var_08 = 0;
	var_09 = scripts\common\utility::istrue(self.var_9CDD);
	var_0A = isdefined(param_04) && param_04 == "incendiary_ammo_mp" || param_04 == "slayer_ammo_mp";
	if(param_01.classname == "trigger_radius")
	{
		if(isdefined(level.var_455C))
		{
			var_0B = var_06 * level.var_3B0F + level.var_455C;
		}
		else
		{
			var_0B = var_07 * level.var_3B0F;
		}

		foreach(var_0D in level.players)
		{
			if(!var_0D scripts\cp\_utility::is_valid_player())
			{
				continue;
			}

			if(isdefined(level.var_13F56))
			{
				var_0D scripts\cp\_persistence::give_player_xp(int(var_07));
			}

			if(scripts\common\utility::istrue(level.var_10942))
			{
				continue;
			}

			var_0E = "large";
			param_02 = "none";
			if(var_05 == "alien_rhino" || scripts\common\utility::istrue(self.mammoth))
			{
				foreach(var_10 in level.players)
				{
					var_10 scripts\cp\_persistence::func_82F9(var_0B,var_0E,param_02,1,"crafted");
				}

				continue;
			}

			var_0D scripts\cp\_persistence::func_82F9(var_0B,var_0E,param_02,1,"crafted");
		}

		return;
	}

	if(!isplayer(var_06) && !isdefined(var_06.var_222) || !isplayer(var_06.var_222))
	{
		return;
	}

	if(isdefined(var_06.var_222))
	{
		var_06 = var_06.var_222;
		var_0D = 1;
	}

	if(!var_12 && var_0A == "generic_zombie" || var_0A == "fast_zombie" || var_0A == "zombie_cop")
	{
		if(scripts\cp\_utility::func_9E27(var_09,var_07,var_08,var_06) && !var_0D && scripts\common\utility::func_9D74(var_08) && !var_0E)
		{
			var_0B = int(100);
			var_0C = int(75);
		}

		if(isdefined(var_08) && var_08 == "MOD_MELEE" && !issubstr(var_09,"axe"))
		{
			var_0B = int(130);
			var_0C = int(100);
		}
	}

	if(isplayer(var_06))
	{
		var_13 = scripts\cp\_utility::func_7D72(var_06,var_09);
		if(scripts\cp\_utility::ismark2weapon(var_13))
		{
			var_0C = var_0C * 1.15;
		}
	}

	if(isdefined(level.kill_reward_func))
	{
		var_0B = [[ level.kill_reward_func ]](var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
	}

	func_8373(var_05,var_06,var_0B,var_0C,"large",var_07,var_09,var_08,self);
}

//Function Number: 23
checkaltmodestatus(param_00)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return 0;
	}

	var_01 = scripts\cp\_utility::func_7DF7(param_00);
	switch(var_01)
	{
		case "iw7_m8":
		case "iw7_longshot":
			if(scripts\cp\_utility::func_9D3E(param_00))
			{
				return 0;
			}
			else
			{
				return 1;
			}
	
			break;

		default:
			return 1;
	}
}

//Function Number: 24
func_8373(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(level.var_455C))
	{
		param_02 = param_02 * level.var_3B0F + level.var_455C;
	}
	else
	{
		param_02 = param_02 * level.var_3B0F;
	}

	param_01 thread giveplayerbonuscash(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	if(isdefined(self.shared_damage_points) || func_13C20(param_06))
	{
		foreach(var_0A in level.players)
		{
			if(!var_0A scripts\cp\_utility::is_valid_player())
			{
				continue;
			}

			if(scripts\common\utility::istrue(level.var_10942))
			{
				continue;
			}

			var_0A scripts\cp\_persistence::func_82F9(param_02,param_04,param_05,1,"crafted");
		}
	}
	else if(func_FF4B(param_00,param_01,param_06,param_08))
	{
		if(self.agent_type == "alien_rhino" || scripts\common\utility::istrue(self.mammoth))
		{
			foreach(var_0D in level.players)
			{
				var_0D scripts\cp\_persistence::func_82F9(param_02,param_04,param_05,1,"crafted");
			}
		}
		else
		{
			param_01 scripts\cp\_persistence::func_82F9(param_02,param_04,param_05,1);
		}
	}

	if(isdefined(level.var_13F56))
	{
		param_01 scripts\cp\_persistence::give_player_xp(int(param_03));
	}
}

//Function Number: 25
giveplayerbonuscash(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(func_FF4B(param_00,param_01,param_06,param_08))
	{
		if(param_01 scripts\cp\_utility::func_9BA0("extra_sniping_points") && scripts\common\utility::func_9D74(param_07) && param_01 scripts\cp\_utility::func_4626(param_06) == "weapon_sniper" && checkaltmodestatus(param_06))
		{
			var_09 = 300;
			if(param_06 == "iw7_shared_fate_weapon")
			{
				param_01 scripts\cp\_utility::func_C151("extra_sniping_points");
			}
			else
			{
				param_01 scripts\cp\_utility::func_C151("extra_sniping_points");
				param_01 thread delaygivecurrency(var_09,param_04,param_05,"bonus",0.15);
			}
		}

		if(isplayer(param_01) && isdefined(param_01.var_3B0F))
		{
			if(isdefined(param_01.cash_scalar_weapon) && param_01.cash_scalar_weapon == scripts\cp\_utility::func_80D8(param_06))
			{
				var_0A = int(param_02 * param_01.var_3B0F - param_02);
				param_01 thread delaygivecurrency(var_0A,param_04,param_05,"bonus",0.25);
			}

			if(isdefined(param_01.cash_scalar_alt_weapon) && param_01.cash_scalar_alt_weapon == scripts\cp\_utility::func_80D8(param_06) && scripts\cp\_utility::isstrstart(param_06,"alt") && scripts\common\utility::istrue(param_01.alt_mode_passive))
			{
				var_0A = int(param_02 * param_01.var_3B0F - param_02);
				param_01 thread delaygivecurrency(var_0A,param_04,param_05,"bonus",0.25);
				return;
			}
		}
	}
}

//Function Number: 26
delaygivecurrency(param_00,param_01,param_02,param_03,param_04)
{
	self endon("disconnect");
	wait(param_04);
	scripts\cp\_persistence::func_82F9(param_00,param_01,param_02,1,param_03);
}

//Function Number: 27
func_FF4B(param_00,param_01,param_02,param_03)
{
	if(isplayer(param_01) && scripts\cp\_laststand::player_in_laststand(param_01))
	{
		return 0;
	}

	if(scripts\cp\_utility::func_9CEB(param_00,param_02,param_03))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(level.var_10942))
	{
		return 0;
	}

	return 1;
}

//Function Number: 28
func_13C20(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return param_00 == "alien_sentry_minigun_4_mp" || param_00 == "zmb_imsprojectile_mp";
}

//Function Number: 29
func_6563(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level.var_A97B = self.origin;
	if(isdefined(level.var_D99D))
	{
		self thread [[ level.var_D99D ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,self.origin);
	}
}

//Function Number: 30
func_9EC6(param_00)
{
	if(isdefined(param_00.team))
	{
		return param_00.team == level.var_D437;
	}

	return 0;
}

//Function Number: 31
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

//Function Number: 32
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
			scripts\common\utility::func_136F7();
			if(param_01.health > 1)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		else
		{
			return 0;
		}
	}

	return 0;
}

//Function Number: 33
func_9830(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(isdefined(level.initial_weapon_scale_func))
	{
		param_02 = [[ level.initial_weapon_scale_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		return param_02;
	}

	if(!func_3845(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B))
	{
		return param_02;
	}

	var_0C = isdefined(self.agent_type) && self.agent_type == "zombie_brute" || self.agent_type == "zombie_grey";
	if(isdefined(param_05))
	{
		if(isdefined(param_04) && param_04 == "MOD_MELEE")
		{
			if(isdefined(level.melee_weapons) && scripts\common\utility::func_2286(level.melee_weapons,getweaponbasename(param_05)))
			{
				return param_02;
			}
			else if(issubstr(getweaponbasename(param_05),"rvn"))
			{
				param_02 = min(self.maxhealth,param_02);
				return param_02;
			}

			if(!func_9B73(param_05) && !is_wyler_dagger(param_05))
			{
				param_02 = 150;
			}

			return param_02;
		}
		else if(param_05 == "alien_sentry_minigun_4_mp")
		{
			if(var_0C)
			{
				param_02 = min(int(self.maxhealth / 5 * randomfloatrange(0.75,1.25)),2500);
			}
			else
			{
				param_02 = int(self.maxhealth / 5 * randomfloatrange(0.75,1.25));
			}
		}

		return param_02;
	}

	return param_02;
}

//Function Number: 34
func_6BA4(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_01))
	{
		return param_02;
	}

	var_07 = getweaponbasename(param_01);
	if(isdefined(var_07))
	{
		switch(var_07)
		{
			case "iw7_steeldragon_mp":
			case "iw7_claw_mp":
				if(param_03 || param_05 || param_06 || param_00 scripts\cp\_utility::agentisinstakillimmune())
				{
					param_02 = min(max(param_00.maxhealth * 0.34,300),1000);
				}
				else if(param_04)
				{
					param_02 = min(max(param_00.maxhealth * 0.34,300),1000);
				}
				else
				{
					param_02 = min(max(param_00.maxhealth,700),1000);
				}
				break;

			case "iw7_blackholegun_mp":
				if(param_05 || param_06 || param_00 scripts\cp\_utility::agentisinstakillimmune())
				{
					param_02 = min(max(param_00.maxhealth * 0.34,300),1000);
				}
				else
				{
					param_02 = min(param_02 * 10,2000);
				}
				break;

			case "iw7_atomizer_mp":
			case "iw7_penetrationrail_mp":
				if(param_03 || param_05 || param_06 || param_00 scripts\cp\_utility::agentisinstakillimmune())
				{
					param_02 = 2500;
				}
				else if(param_04)
				{
					param_02 = param_00.maxhealth / 10;
				}
				else
				{
					param_02 = param_00.maxhealth;
				}
				break;

			default:
				return param_02;
		}
	}

	return param_02;
}

//Function Number: 35
is_wyler_dagger(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	return param_00 == "iw7_wylerdagger_zm";
}

//Function Number: 36
func_9B73(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = getweaponbasename(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	switch(var_01)
	{
		case "iw6_cphcmelee_mp":
		case "iw7_axe_zm_pap2":
		case "iw7_axe_zm_pap1":
		case "iw7_axe_zm":
			return 1;
	}

	return 0;
}

//Function Number: 37
func_EBAC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(func_9C50())
	{
		return param_02;
	}

	var_0C = scripts\cp\_utility::func_80D8(param_05);
	switch(var_0C)
	{
		case "shredder":
		case "headcutter":
		case "facemelter":
		case "dischord":
			param_02 = 2000;
			break;
	}

	return param_02;
}

//Function Number: 38
func_DDE4(param_00)
{
	if(!isdefined(self.var_DDEF))
	{
		self.var_DDEF = 1;
		var_01 = self.health;
		wait(param_00);
		var_02 = self.health;
		var_03 = var_01 - var_02;
		iprintln("damage: " + var_03);
		self.var_DDEF = undefined;
	}
}

//Function Number: 39
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

	if(isplayer(param_01) && !isdefined(param_01.var_C8A2))
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

//Function Number: 40
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

//Function Number: 41
func_6109(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isplayer(param_00))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(scripts\cp\_laststand::player_in_laststand(param_00)))
	{
		return 0;
	}

	if(!isdefined(param_02))
	{
		return 0;
	}

	if(param_05 < 1)
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_04.var_9CDD))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(level.var_94A4) && scripts\common\utility::func_9D74(param_02))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(level.var_10942))
	{
		return 0;
	}

	if(isdefined(param_04.agent_type))
	{
		if(param_04.agent_type == "zombie_brute")
		{
			return 0;
		}

		if(param_04.agent_type == "alien_rhino")
		{
			return 0;
		}
	}

	if(isdefined(param_04.agent_type) && param_04.agent_type == "zombie_brute")
	{
		return 0;
	}

	if(scripts\cp\_utility::func_9CEB(param_01,param_03,param_04))
	{
		return 0;
	}

	if(weaponclass(param_03) == "spread")
	{
		if(!func_FEFA(param_00,param_04,param_03))
		{
			return 0;
		}
	}

	if(param_03 == "incendiary_ammo_mp" || param_03 == "slayer_ammo_mp" || param_03 == "iw7_facemelterdummy_zm" || param_03 == "iw7_scrambler_zm" || param_03 == "iw7_entangler2_zm")
	{
		return 0;
	}

	if(![[ level.eligable_for_reward_func ]](param_00,param_01,param_02,param_03,param_04,param_05))
	{
		return 0;
	}

	switch(param_02)
	{
		case "MOD_GRENADE":
		case "MOD_GRENADE_SPLASH":
		case "MOD_PISTOL_BULLET":
		case "MOD_RIFLE_BULLET":
		case "MOD_EXPLOSIVE":
		case "MOD_IMPACT":
		case "MOD_MELEE":
			if(param_03 == "gas_grenade_mp" || param_03 == "splash_grenade_zm" || param_03 == "iw7_venomx_zm")
			{
				if(isdefined(param_04.var_6E82))
				{
					if(gettime() > param_04.var_6E82)
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
			if(scripts\common\utility::istrue(param_04.var_9B81) && isdefined(param_04.var_6E82))
			{
				if(gettime() > param_04.var_6E82)
				{
					return 1;
				}
			}
			return 0;

		default:
			break;
	}

	if(!scripts\common\utility::istrue(param_04.var_9B81))
	{
		return 1;
	}

	if(!scripts\common\utility::istrue(param_04.var_B36E))
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
func_C5CE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	var_0D = scripts\cp\_utility::func_9CEB(param_00,param_05,self);
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

	if(isdefined(level.var_455C))
	{
		var_0E = 10 * level.var_3B0F + level.var_455C;
	}
	else
	{
		var_0E = 10 * level.var_3B0F;
	}

	if(isdefined(param_01))
	{
		if(func_6109(param_01,param_00,param_04,param_05,self,param_02))
		{
			var_0F = gettime();
			if(var_0F > param_01.var_BF74 && level.var_3B0F > 1 || param_01 scripts\cp\_utility::func_9BA0("hit_reward_upgrade") || isdefined(level.var_455C))
			{
				playfxontagforclients(level._effect["extra_cash_kill"],self,"j_spineupper",param_01);
				param_01.var_BF74 = var_0F + 1000;
			}

			if(param_01 scripts\cp\_utility::func_9BA0("hit_reward_upgrade"))
			{
				param_01 scripts\cp\_utility::func_C151("hit_reward_upgrade");
				var_10 = int(var_0E * 2 - var_0E);
				param_01 thread delaygivecurrency(var_10,"large",param_08,"bonus",0.2);
			}

			param_01 scripts\cp\_persistence::func_82F9(var_0E,"large",param_08);
		}
	}
}

//Function Number: 43
func_3D9D(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00 scripts\cp\_utility::func_9CEB(param_01,param_03,param_00);
	var_06 = param_00 func_FF3A(param_03,param_04,self);
	var_07 = scripts\common\utility::istrue(param_00.var_9343);
	if(!isdefined(param_00.var_9B51) && isalive(param_00))
	{
		if(scripts\cp\_utility::func_D0C6(self,"combined_ammo") || param_03 == "slayer_ammo_mp")
		{
			var_08 = min(int(param_00.maxhealth * 0.2),1500);
			param_00 thread scripts\cp\_utility::func_4D0D(param_00,self,5,var_08,param_04,"slayer_ammo_mp",undefined,"combinedArcane");
		}
	}

	if(!isdefined(param_00.var_9B51) && !isdefined(param_00.var_9B81) && isalive(param_00))
	{
		if(scripts\cp\_utility::func_D0C6(self,"incendiary_ammo") || param_03 == "incendiary_ammo_mp")
		{
			var_08 = min(param_00.maxhealth * 0.1,1000);
			param_00 thread scripts\cp\_utility::func_4D0D(param_00,self,5,var_08,param_04,"incendiary_ammo_mp",undefined,"burning");
		}
	}

	if(var_06 && !var_05 && !var_07)
	{
		param_00.var_11196 = 1;
		param_00 thread func_75FA();
		param_00 thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(param_00);
		param_02 = param_02 | level.var_92CA;
	}
}

//Function Number: 44
func_75FA()
{
	self endon("death");
	wait(1);
	self.var_11196 = undefined;
}

//Function Number: 45
func_9EDB(param_00)
{
	return isdefined(self.var_CA08) && self.var_CA08;
}

//Function Number: 46
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

//Function Number: 47
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

	return 1;
}

//Function Number: 48
func_7E31()
{
	while(!isdefined(self.var_4298))
	{
		wait(0.1);
	}

	return self.var_4298;
}

//Function Number: 49
func_777C()
{
	self.var_37FD = 0;
	self.var_24CA = undefined;
	self.entered_playspace = 0;
	self.var_B36E = undefined;
	self.var_126A3 = undefined;
	self.var_8C35 = 0;
	self.var_54CB = 0;
	self.var_9E0C = undefined;
	self.flung = undefined;
	self.var_28E0 = undefined;
	self.var_FF78 = undefined;
	self.var_9CDD = undefined;
	self.var_9CA2 = undefined;
	self.is_coaster_zombie = undefined;
	self.var_EF64 = 0;
	self.var_9BB0 = 0;
	self.var_152C = 0;
	self.var_9CEF = 0;
	self.var_B57A = undefined;
	self.var_BC4B = undefined;
	self.var_2BE9 = undefined;
	self.var_FFCF = undefined;
	self.var_B36D = undefined;
	self.var_4D3C = [];
	self.rocket_feet = undefined;
	self.var_E5D0 = undefined;
	self.var_2BF9 = undefined;
	self.var_594C = undefined;
	self.var_1044D = undefined;
	self.var_BF2F = undefined;
	self.var_8B66 = undefined;
	self.var_AAA8 = undefined;
	self.var_102CD = undefined;
	self.var_9B6E = undefined;
	self.var_7387 = undefined;
	self.var_A64E = undefined;
	self.atomize_me = undefined;
	self.shared_damage_points = undefined;
	if(isdefined(self.var_4D7D))
	{
		self.var_4D7D.var_C2CF = 0;
	}

	self.var_4D7D = undefined;
	thread func_117BE();
}

//Function Number: 50
func_FF14()
{
	var_00 = 50;
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

//Function Number: 51
func_101E3()
{
	var_00 = 55;
	var_01 = self.origin + (0,0,var_00);
	var_02 = self.var_4299.origin + (0,0,var_00);
	return sighttracepassed(var_01,var_02,0,self);
}

//Function Number: 52
func_78C1(param_00)
{
	var_01 = scripts\common\utility::func_782F(param_00.origin,level.players)[0];
	var_02 = scripts\common\utility::getclosest(param_00.origin,level.current_interaction_structs);
	if(!func_9C78(var_01,var_02))
	{
		var_01 = undefined;
	}

	return var_01;
}

//Function Number: 53
func_9C78(param_00,param_01)
{
	var_02 = 2304;
	return distancesquared(param_00.origin,param_01.origin) < var_02;
}

//Function Number: 54
func_24BD()
{
	if(!isdefined(self.var_24CA))
	{
		return;
	}

	self.var_FFCF = 1;
	if(isdefined(self.var_24CA.angles))
	{
		self.var_2BE9 = self.var_24CA.angles;
	}
	else
	{
		self.var_2BE9 = (0,0,0);
	}

	for(;;)
	{
		self waittill("boardbreak",var_00);
		if(var_00[0] == "hit")
		{
			break;
		}
	}

	self.var_FFCF = 0;
	self.var_2BE9 = undefined;
	var_01 = scripts\common\utility::getclosest(self.origin,level.current_interaction_structs);
	if(func_9C78(self.var_4299,var_01))
	{
		lib_0C73::func_5904(self.var_4299,lib_0C73::func_7AD3(),"MOD_IMPACT");
	}
}

//Function Number: 55
func_2FB2(param_00)
{
	if(isdefined(self.var_24CA))
	{
		if(isdefined(self.var_24CA.angles))
		{
			self.var_2BE9 = self.var_24CA.angles;
		}
		else
		{
			self.var_2BE9 = (0,0,0);
		}
	}

	self.var_FFCF = 1;
	for(;;)
	{
		self waittill("boardbreak",var_01);
		if(var_01[0] == "hit")
		{
			break;
		}
	}

	lib_0D4D::func_DFCB(param_00);
	if(!lib_0D4D::func_664D(param_00))
	{
		self.var_FFCF = 0;
		self.var_4B26 = undefined;
		self.var_180 = 0;
		self.ignoreme = 0;
		lib_0D4D::func_DF34(self.var_24CA);
		self.var_24CA = undefined;
	}
}

//Function Number: 56
func_231C()
{
	self endon("death");
	self notify("asmDebug");
	self endon("asmDebug");
	var_00 = (0,0,72);
	var_01 = (0,0,-8);
	for(;;)
	{
		if(isdefined(self.var_164D))
		{
			var_02 = 0;
			foreach(var_04 in self.var_164D)
			{
				var_05 = var_00 + var_02 * var_01;
				var_02++;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 57
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

//Function Number: 58
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

//Function Number: 59
func_E7FD(param_00)
{
	if(level.var_5274 - level.var_4B6E == 1)
	{
		if(!isdefined(self.var_E821))
		{
			if(level.wave_num < 4)
			{
				self.var_E821 = gettime() + 80000;
			}
			else
			{
				self.var_E821 = gettime() - 1;
			}
		}

		if(self.var_E821 < gettime() && isdefined(self.var_2303.var_4B12) && self.var_2303.var_4B12 != "sprint")
		{
			return "run";
		}
	}
	else if(level.wave_num > 19 && isdefined(self.var_2303.var_4B12) && self.var_2303.var_4B12 == "sprint")
	{
		if(randomint(100) < 5)
		{
			if(num_fake_walkers() < 3)
			{
				return "walk";
			}
		}
	}

	return undefined;
}

//Function Number: 60
num_fake_walkers()
{
	var_00 = 0;
	foreach(var_02 in level.spawned_enemies)
	{
		if(isdefined(var_02.var_2303) && isdefined(var_02.var_2303.var_4B12) && var_02.var_2303.var_4B12 == "walk")
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 61
func_9C50()
{
	return isdefined(self.agent_type) && self.agent_type == "zombie_brute" || self.agent_type == "zombie_grey";
}

//Function Number: 62
func_97BA()
{
	function_004E("player1");
	function_004E("player2");
	function_004E("player3");
	function_004E("player4");
	function_004E("player1_enemy");
	function_004E("player2_enemy");
	function_004E("player3_enemy");
	function_004E("player4_enemy");
	function_01D1("player1","player1_enemy",10000);
	function_01D1("player2","player2_enemy",10000);
	function_01D1("player3","player3_enemy",10000);
	function_01D1("player4","player4_enemy",10000);
}

//Function Number: 63
func_93EC(param_00,param_01)
{
	param_00 endon("death");
	param_01 endon("death");
	if(issentient(param_01))
	{
		var_02 = param_01 method_8163();
		if(function_0218(var_02 + "_enemy"))
		{
			param_00 method_834E(var_02 + "_enemy");
		}

		wait(5);
		param_00 method_834E();
	}
}

//Function Number: 64
func_117BE()
{
	self endon("death");
	var_00 = 100;
	var_01 = 200;
	var_02 = 200;
	var_03 = var_02 * var_02;
	self.var_11366 = 0;
	self.var_A8A1 = 0;
	self.var_BF04 = undefined;
	for(;;)
	{
		if(isdefined(self.var_10C))
		{
			var_04 = distancesquared(self.origin,self.var_10C.origin);
			if(isdefined(self.var_BF04))
			{
				if(self.var_11366 >= var_01)
				{
					self.var_11366 = 0;
					func_93EC(self,self.var_BF04);
					wait(0.25);
					continue;
				}
				else
				{
					var_05 = distancesquared(self.origin,self.var_BF04.origin);
					if(var_05 < var_03 && var_05 < var_04)
					{
						self.var_11366 = self.var_11366 + var_00;
						wait(0.25);
						continue;
					}
					else
					{
						self.var_11366 = 0;
						var_06 = scripts\common\utility::func_22A9(level.players,self.var_10C);
						if(var_06.size > 0)
						{
							var_06 = scripts\common\utility::func_22A9(var_06,self.var_BF04);
						}

						self.var_BF04 = undefined;
						func_3D90(var_04,var_06);
						wait(0.25);
						continue;
					}
				}
			}
			else
			{
				self.var_11366 = 0;
				var_06 = scripts\common\utility::func_22A9(level.players,self.var_10C);
				func_3D90(var_04,var_06);
				wait(0.25);
				continue;
			}
		}

		wait(0.25);
	}
}

//Function Number: 65
func_3D90(param_00,param_01)
{
	var_02 = 200;
	var_03 = var_02 * var_02;
	if(param_01.size > 0)
	{
		foreach(var_05 in param_01)
		{
			var_06 = distancesquared(self.origin,var_05.origin);
			if(var_06 < var_03 && var_06 < param_00)
			{
				self.var_BF04 = var_05;
			}
		}
	}
}

//Function Number: 66
func_BF05(param_00)
{
	if(!isdefined(self.var_A8A1))
	{
		self.var_A8A1 = 0;
	}

	var_01 = 100;
	if(isdefined(self.var_10C))
	{
		if(param_00 == self.var_10C)
		{
			self.var_A8A1 = gettime();
			return;
		}

		var_02 = gettime();
		if(var_02 - self.var_A8A1 > 5000)
		{
			if(isdefined(self.var_BF04))
			{
				if(param_00 == self.var_BF04)
				{
					self.var_11366 = self.var_11366 + var_01;
					return;
				}

				return;
			}

			self.var_BF04 = param_00;
			self.var_11366 = 0;
			return;
		}
	}
}

//Function Number: 67
func_3759(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	thread func_934E(param_00,self,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 68
func_934E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(isdefined(level.harpoon_impale_additional_func))
	{
		[[ level.harpoon_impale_additional_func ]](param_02,param_00,param_01,param_04,param_05,param_06,param_07,param_08);
		return;
	}

	param_01 method_839A();
	var_09 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_missileclip","physicscontents_vehicle","physicscontents_item"]);
	var_0A = param_04 + param_05 * 4096;
	var_0B = scripts\common\trace::func_DCEE(param_04,var_0A,undefined,var_09,undefined,1);
	var_0A = var_0B["position"] - param_05 * 12;
	var_0C = length(var_0A - param_04);
	var_0D = var_0C / 1250;
	var_0D = clamp(var_0D,0.05,1);
	wait(0.05);
	var_0E = param_05;
	var_0F = anglestoup(param_00.angles);
	var_10 = vectorcross(var_0E,var_0F);
	var_11 = scripts\common\utility::spawn_tag_origin(param_04,axistoangles(var_0E,var_10,var_0F));
	var_11 moveto(var_0A,var_0D);
	var_12 = spawnragdollconstraint(param_01,param_06,param_07,param_08);
	var_12.origin = var_11.origin;
	var_12.angles = var_11.angles;
	var_12 linkto(var_11);
	thread func_934F(param_01,var_11,var_0D + 0.05,var_12);
}

//Function Number: 69
func_934F(param_00,param_01,param_02,param_03)
{
	param_00 scripts\common\utility::waittill_any_timeout_1(param_02,"death","disconnect");
	param_03 delete();
	param_01 delete();
}

//Function Number: 70
func_AA56(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("disconnect");
	self.do_immediate_ragdoll = 1;
	self.var_4C87 = 1;
	self.disable_armor = 1;
	self.var_AAA8 = 1;
	if(randomint(100) > 50 && !isdefined(self.var_9CDD))
	{
		self.nocorpse = undefined;
		var_03 = 50;
		var_04 = 50;
		if(param_02)
		{
			var_03 = 300;
			var_04 = 150;
		}

		self setvelocity(vectornormalize(self.origin - param_00.origin) * var_03 + (0,0,var_04));
		wait(0.1);
	}
	else
	{
		self.full_gib = 1;
		self.nocorpse = 1;
	}

	self dodamage(self.health + 1000,param_00.origin,param_00,param_00,"MOD_MELEE");
}

//Function Number: 71
func_B982()
{
	scripts\common\utility::flag_init("player_count_determined");
	var_00 = getdvar("party_partyPlayerCountNum");
	if(var_00 != "1")
	{
		level.only_one_player = 0;
		scripts\common\utility::flag_set("player_count_determined");
		return;
	}

	level.only_one_player = 1;
	scripts\common\utility::flag_set("player_count_determined");
	while(!isdefined(level.players))
	{
		wait(0.1);
	}

	for(;;)
	{
		if(level.players.size > 1)
		{
			break;
		}

		wait(1);
	}

	level.only_one_player = 0;
	level notify("multiple_players");
}