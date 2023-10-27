/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\cp_disco_damage.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 707 ms
 * Timestamp: 10/27/2023 12:03:49 AM
*******************************************************************/

//Function Number: 1
cp_disco_onzombiedamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(!isdefined(self.agent_type))
	{
		return;
	}

	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "iw7_shuriken_zm_crane":
			case "iw7_shuriken_zm_tiger":
			case "iw7_shuriken_zm_dragon":
			case "iw7_shuriken_zm_snake":
			case "iw7_shuriken_crane_proj":
			case "iw7_shuriken_snake_proj":
			case "iw7_shuriken_tiger_proj":
			case "iw7_shuriken_dragon_proj":
				self playsound("kungfu_shuriken_zombie_dmg");
				break;

			default:
				break;
		}
	}

	self.kung_fu_punched = undefined;
	if(param_04 != "MOD_SUICIDE")
	{
		if(!isdefined(param_01) || !scripts\common\utility::istrue(param_01.battackzombies))
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
	}

	if(!isdefined(param_01))
	{
		param_01 = self;
	}

	var_0D = lib_0CBC::func_FF2E(param_01,param_02,param_04,param_05,param_08,var_0C);
	if(!var_0D)
	{
		return;
	}

	var_0E = param_04 == "MOD_MELEE";
	var_0F = scripts\common\utility::istrue(param_01.inlaststand);
	var_10 = scripts\common\utility::istrue(var_0C.var_9CDD);
	param_03 = param_03 | 4;
	var_11 = isdefined(param_01) && isplayer(param_01);
	var_12 = scripts\common\utility::func_9D74(param_04) || param_04 == "MOD_EXPLOSIVE_BULLET" && param_08 != "none";
	var_13 = var_12 && scripts\cp\_utility::func_9E27(param_05,param_08,param_04,param_01);
	var_14 = scripts\common\utility::istrue(self.var_28E0);
	var_15 = scripts\common\utility::istrue(level.var_9925) && !scripts\cp\_utility::agentisinstakillimmune();
	var_16 = (param_04 == "MOD_EXPLOSIVE_BULLET" && isdefined(param_08) && param_08 == "none") || param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE" || param_04 == "MOD_PROJECTILE_SPLASH";
	var_17 = !var_0F && var_13 && var_12 && param_01 scripts\cp\_utility::func_9BA0("headshot_explosion");
	var_18 = var_0E && param_01 scripts\cp\_utility::func_9BA0("increased_melee_damage");
	var_19 = var_0E && param_01 scripts\cp\_utility::func_9BA0("shock_melee_upgrade");
	var_1A = scripts\cp\_utility::func_9D3E(param_05);
	var_1B = scripts\cp\_utility::agentisfnfimmune();
	var_1C = scripts\cp\_utility::agentisinstakillimmune();
	var_1D = getweaponbasename(param_05);
	var_1E = var_11 && param_05 == "iw7_nunchucks_zm";
	var_1F = var_11 && var_1D == "iw7_nunchucks_zm_pap1";
	var_20 = var_11 && var_1D == "iw7_nunchucks_zm_pap2";
	if(isdefined(param_05) && issubstr(param_05,"iw7_gauss_zml"))
	{
		var_21 = 250;
		if(scripts\cp\_utility::func_13C90(param_05,"pap1"))
		{
			var_21 = 470;
		}

		if(scripts\cp\_utility::func_13C90(param_05,"pap2"))
		{
			var_21 = 734;
		}

		if(scripts\cp\_utility::func_13C90(param_05,"doubletap"))
		{
			var_21 = 1.33 * var_21;
		}

		if(param_02 >= var_21)
		{
			self.hitbychargedshot = param_01;
		}
	}

	if(var_11)
	{
		if(var_1E || var_1F || var_20)
		{
			self.full_gib = 1;
			self.var_4C87 = 1;
			self.nocorpse = 1;
		}

		if(scripts\common\utility::istrue(self.marked_shared_fate_fnf))
		{
			param_01 thread scripts\cp\_utility::add_to_notify_queue("weapon_hit_marked_target",param_01,param_02,param_04,param_05,self);
		}

		self.damaged_by_player = 1;
		if(scripts\common\utility::istrue(param_01.stimulus_active))
		{
			playfx(level._effect["stimulus_glow_burst"],self gettagorigin("j_spineupper"));
			scripts\common\utility::play_sound_in_space("zmb_fnf_stimulus",self gettagorigin("j_spineupper"));
			foreach(var_23 in level.players)
			{
				if(var_23 == param_01)
				{
					if(distance2dsquared(var_23.origin,self.origin) <= 10000)
					{
						playfx(level._effect["stimulus_glow_burst"],self gettagorigin("j_spineupper"));
						playfx(level._effect["stimulus_shield"],var_23 gettagorigin("tag_eye"),anglestoforward(var_23.angles),anglestoup(var_23.angles),var_23);
						if(param_02 >= self.health)
						{
							if(scripts\common\utility::istrue(var_23.inlaststand))
							{
								lib_0D59::revive_downed_entities(var_23);
							}
						}

						if(var_23.health + param_02 / level.players.size + 1 >= var_23.maxhealth)
						{
							var_23.health = var_23.maxhealth;
						}
						else
						{
							var_23.health = int(var_23.health + param_02 / level.players.size + 1);
						}
					}

					continue;
				}

				if(distance2dsquared(var_23.origin,self.origin) <= 10000)
				{
					playfx(level._effect["stimulus_glow_burst"],self gettagorigin("j_spineupper"));
					playfx(level._effect["stimulus_shield"],var_23 gettagorigin("tag_eye"));
					if(param_02 >= self.health)
					{
						if(scripts\common\utility::istrue(var_23.inlaststand))
						{
							lib_0D59::revive_downed_entities(var_23);
						}
					}

					if(int(var_23.health + param_02 / level.players.size + 1) >= var_23.maxhealth)
					{
						var_23.health = var_23.maxhealth;
						continue;
					}

					var_23.health = int(var_23.health + param_02 / level.players.size + 1);
				}
			}
		}

		if(scripts\common\utility::istrue(param_01.snake_super))
		{
			param_01 playlocalsound("kungfu_snake_super_hit_zombie");
		}
	}

	if(isdefined(param_01.var_9CEF) && param_01.var_9CEF && param_04 != "MOD_SUICIDE")
	{
		param_02 = param_01.var_B57A;
	}

	var_25 = 0;
	if(!var_0E && lib_0CBC::checkaltmodestatus(param_05) && var_11 && !isdefined(param_01.var_AD2C) && param_01 scripts\cp\_utility::func_9BA0("sniper_soft_upgrade"))
	{
		var_25 = param_01 scripts\cp\_utility::func_4626(param_05) == "weapon_sniper";
	}

	var_26 = !var_1B && scripts\common\utility::istrue(level.var_69FA) && isdefined(param_04) && param_04 == "MOD_UNKNOWN";
	var_27 = !var_1C && var_14 || var_15 || var_19 || var_26 || var_17 || var_18 || var_25;
	var_28 = isdefined(self.var_9E0C);
	if(scripts\cp\powers\coop_armageddon::func_9DF5(param_05) && !var_1C)
	{
		thread scripts\cp\powers\coop_armageddon::func_6F33(param_00.origin,param_06,param_07);
		return;
	}
	else if(var_27 && !var_1B)
	{
		if(var_25)
		{
			param_01 scripts\cp\_utility::func_C151("sniper_soft_upgrade");
		}

		if(var_1E)
		{
			self.nocorpse = 1;
			self.full_gib = 1;
		}

		if(var_1F)
		{
			self.nocorpse = 1;
			self.full_gib = 1;
			param_01 thread scripts\cp\maps\cp_disco\cp_disco::do_damage_cone_nunchucks(param_05,param_01,self,param_04,param_08);
		}

		if(var_20)
		{
			self.nocorpse = 1;
			self.full_gib = 1;
			self.dontmutilate = 1;
			param_01 thread scripts\cp\maps\cp_disco\cp_disco::do_damage_cone_nunchucks(param_05,param_01,self,param_04,param_08);
			param_01 thread scripts\cp\maps\cp_disco\cp_disco::nunchucks_recent_kills(self,param_05);
			if(scripts\common\utility::istrue(param_01.var_9F1B))
			{
				if(param_01.health + param_02 <= param_01.maxhealth)
				{
					param_01.health = param_01.health + param_02;
				}
				else
				{
					param_01.health = param_01.maxhealth;
				}
			}
		}

		param_02 = int(self.maxhealth);
		if(var_19)
		{
			if(isdefined(param_06))
			{
				playfx(level._effect["shock_melee_impact"],param_06);
			}

			param_01 thread scripts\cp\zombies\zombie_damage::func_11193(self geteye(),self,self.maxhealth,"MOD_UNKNOWN",undefined,var_19);
		}

		if(var_12)
		{
			param_01 thread scripts\cp\_utility::add_to_notify_queue("weapon_hit_enemy",self,param_01,param_05,param_02,param_08,param_04);
		}
	}
	else if(!var_1B)
	{
		param_08 = lib_0CBC::func_FE39(param_01,param_04,param_05,param_08);
		var_29 = level.wave_num;
		var_2A = lib_0CBC::func_9BF7(param_05,param_04);
		var_2B = scripts\common\utility::istrue(self.var_9B81) && !var_12;
		var_2C = var_13 && param_01 scripts\cp\_utility::func_9BA0("sharp_shooter_upgrade");
		var_2D = var_12 && param_01 scripts\cp\_utility::func_9BA0("bonus_damage_on_last_bullets");
		var_2E = var_12 && param_01 scripts\cp\_utility::func_9BA0("damage_booster_upgrade");
		var_2F = var_12 && isdefined(param_01.special_ammo_weapon) && param_01.special_ammo_weapon == param_05;
		var_30 = var_11 && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_boom");
		var_31 = var_11 && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_smack");
		var_32 = lib_0CBC::func_9B73(param_05);
		var_33 = scripts\common\utility::func_2286(level.melee_weapons,param_05);
		var_1D = getweaponbasename(param_05);
		var_34 = var_11 && param_05 == "iw7_katana_zm" || var_1D == "iw7_katana_zm_pap1" || var_1D == "iw7_katana_zm_pap2";
		var_35 = var_11 && issubstr(param_05,"shuriken");
		var_36 = weaponclass(param_05) == "spread" && param_01 scripts\cp\_weapon::func_8BD1(param_05,"smart");
		var_37 = weaponclass(param_05) == "spread" && !var_36 && param_01 scripts\cp\_weapon::func_8BD1(param_05,"arkpink") || scripts\cp\_weapon::func_8BD1(param_05,"arkyellow");
		var_38 = var_13 && var_12 && param_01 scripts\cp\_weapon::func_8BD1(param_05,"highcal");
		if(var_1A && issubstr(param_05,"+gl"))
		{
			param_02 = lib_0CBC::scalegldamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		}

		if(var_36)
		{
			param_02 = param_02 * 0.5;
		}

		if(isdefined(param_02) && isdefined(param_08) && !var_15 && var_12)
		{
			var_39 = lib_0D48::func_D96F(var_0C,param_01,param_02,param_08,param_07);
			if(var_39 <= 0)
			{
				return;
			}

			param_02 = var_39;
		}

		param_02 = lib_0CBC::func_9830(undefined,param_01,param_02,undefined,param_04,param_05,undefined,undefined,param_08,undefined,undefined,undefined);
		if(var_37)
		{
			param_02 = param_02 * 4;
		}

		if(var_11)
		{
			if(var_0E)
			{
				if(param_01 scripts\cp\_weapon::func_8BD1(param_05,"meleervn"))
				{
					param_02 = param_02 + int(1500 * param_01 scripts\cp\_weapon::func_7D62(param_05));
				}

				param_02 = int(param_02 * param_01 lib_0CFC::func_CA3A());
				if(scripts\common\utility::istrue(param_01.kung_fu_mode))
				{
					if(is_kung_fu_punch(param_01,param_05))
					{
						param_02 = 10000;
					}
				}

				if(isdefined(param_01.passive_melee_kill_damage))
				{
					param_02 = param_02 + param_01.passive_melee_kill_damage;
				}

				if(var_31)
				{
					param_02 = param_02 + 1500;
				}

				var_3A = 0;
				if(param_02 >= self.health)
				{
					var_3A = 1;
				}

				if(isdefined(param_01.increased_melee_damage))
				{
					param_02 = param_02 + param_01.increased_melee_damage;
				}

				if(var_1F)
				{
					param_01 thread scripts\cp\maps\cp_disco\cp_disco::do_damage_cone_nunchucks(param_05,param_01,self,param_04,param_08);
				}

				if(var_20)
				{
					param_01 thread scripts\cp\maps\cp_disco\cp_disco::do_damage_cone_nunchucks(param_05,param_01,self,param_04,param_08);
					param_01 thread scripts\cp\maps\cp_disco\cp_disco::nunchucks_recent_kills(self,param_05);
					if(scripts\common\utility::istrue(param_01.var_9F1B))
					{
						if(param_01.health + param_02 <= param_01.maxhealth)
						{
							param_01.health = param_01.health + param_02;
						}
						else
						{
							param_01.health = param_01.maxhealth;
						}
					}
				}

				if(var_34)
				{
					param_01 thread scripts\cp\_utility::add_to_notify_queue("katana_melee_hit",param_05,self,param_02);
					if(var_0C.agent_type != "skater" && var_0C.agent_type != "karatemaster")
					{
						if(param_02 >= self.health)
						{
							level thread func_89AA(self,param_01,param_05);
						}
					}
				}

				if(var_33 && var_3A)
				{
					param_01 thread scripts\cp\_utility::add_to_notify_queue("melee_weapon_hit",param_05,self,param_02);
				}

				if(scripts\common\utility::istrue(param_01.kung_fu_mode))
				{
					if(var_3A && !isdefined(self.var_AAA8))
					{
						var_3B = 3500;
						self.kung_fu_punched = 1;
						self.ragdollhitloc = param_08;
						if(lengthsquared(param_07) < 1)
						{
							var_3C = self.origin - param_01.origin;
							var_3C = vectornormalize((var_3C[0],var_3C[1],0));
							self.ragdollimpactvector = var_3C * var_3B;
						}
						else
						{
							self.ragdollimpactvector = param_07 * var_3B;
						}

						thread chi_hit(param_01,param_05,param_06);
						param_01 scripts\cp\zombies\zombies_chi_meter::chi_meter_kill_decrement(50);
						var_3D = 1;
						thread kung_fu_damage_everyone_in_radius(self.origin,96,param_01,var_3D);
					}
				}
				else if(var_32 || var_31)
				{
					if(var_32)
					{
						param_01 thread scripts\cp\_utility::add_to_notify_queue("axe_melee_hit",param_05,self,param_02);
						if(var_3A && !isdefined(self.var_AAA8))
						{
							thread lib_0CBC::func_AA56(param_01,param_05,var_31);
							return;
						}
					}
					else if(var_3A)
					{
						self.var_102CD = 1;
					}
				}
			}

			if(var_35)
			{
				param_02 = 100000000;
			}

			if(scripts\common\utility::istrue(param_01.crane_super))
			{
				var_3B = 3500;
				self.ragdollhitloc = param_08;
				if(lengthsquared(param_07) < 1)
				{
					var_3C = self.origin - param_01.origin;
					var_3C = vectornormalize((var_3C[0],var_3C[1],0));
					self.ragdollimpactvector = var_3C * var_3B;
				}
				else
				{
					self.ragdollimpactvector = param_07 * var_3B;
				}

				var_3E = playfxontagforclients(level._effect["screen_blood"],param_01,"tag_eye",param_01);
			}

			if(var_2F)
			{
				param_01 thread scripts\cp\zombies\zombie_damage::func_11193(self geteye(),self,param_02,param_04,128);
			}

			if(var_30 && var_16)
			{
				param_02 = int(param_02 * 2);
			}

			if(scripts\common\utility::istrue(param_01.var_DCEB))
			{
				param_02 = int(param_02 * 2);
			}

			if(self.agent_type == "skater")
			{
				if(randomint(100) > 40)
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("killfirm_skater","disco_comment_vo","low",10,0,0,0,20);
				}
				else
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("killfirm","disco_comment_vo","low",10,0,0,0,20);
				}
			}

			if(self.agent_type == "karatemaster")
			{
				if(randomint(100) > 40)
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("killfirm_kungfu","disco_comment_vo","low",10,0,0,0,20);
				}
				else
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("killfirm","disco_comment_vo","low",10,0,0,0,20);
				}
			}
		}

		if(var_2C)
		{
			param_02 = param_02 * 3;
		}

		if(var_2D)
		{
			var_3F = int(param_01 getweaponammoclip(param_01 getcurrentweapon()) + 1);
			var_40 = weaponclipsize(param_01 getcurrentweapon());
			if(var_3F <= 4)
			{
				param_02 = param_02 * 2;
			}
		}

		if(var_12 && scripts\common\utility::istrue(param_01.var_DF50))
		{
			param_02 = param_02 * 2;
		}

		if(var_2A)
		{
			param_02 = param_02 * min(2 + var_29 * 0.5,10);
		}

		if(var_2E)
		{
			param_02 = int(param_02 * 2);
		}

		if(var_38)
		{
			param_02 = param_02 * 1.2;
		}
	}

	if(isdefined(param_01.var_CA2F) && param_01.var_CA2F["damagemod"].var_3237 == 2 && var_12)
	{
		param_02 = param_02 * 1.33;
	}

	if(scripts\common\utility::istrue(param_01.deadeye_charge))
	{
		param_02 = param_02 * 1.25;
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

	param_02 = lib_0CBC::func_FFBC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	param_02 = lib_0CBC::func_6BA4(self,param_05,param_02,0,0,0,0);
	if(isdefined(level.onzombiedamage_func))
	{
		param_02 = [[ level.onzombiedamage_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	}

	if(isdefined(param_01.special_zombie_damage) && scripts\cp\_utility::agentisspecialzombie())
	{
		param_02 = param_02 * param_01.special_zombie_damage;
	}

	if(isdefined(self.hitbychargedshot) && !self.health - param_02 < 1)
	{
		self.hitbychargedshot = undefined;
	}

	param_02 = int(min(param_02,self.health));
	if(isplayer(param_01) && scripts\cp\_utility::func_9C42(param_05,1))
	{
		playfx(level._effect["melee_impact"],self gettagorigin("j_neck"),vectortoangles(self.origin - param_01.origin),anglestoup(self.angles),param_01);
	}

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
	}

	if(var_11)
	{
		if(isdefined(level.var_12EDE))
		{
			level thread [[ level.var_12EDE ]](param_01,param_05,self);
		}

		param_01 thread scripts\cp\_utility::add_to_notify_queue("weapon_hit_enemy",self,param_01,param_05,param_02,param_08,param_04);
		param_01 thread lib_0CBC::func_12EC5(getweaponbasename(param_05));
		if(var_12)
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

	lib_0D5A::func_12D84(param_01,param_02,param_04);
	scripts\cp\_agent_utils::func_D96D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	scripts\cp\_agent_utils::func_D96B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	scripts\cp\_agent_utils::func_110A4(param_01,param_02);
	scripts\cp\zombies\zmb_zombies_weapons::func_1094D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	if(var_11)
	{
		thread lib_0CBC::func_BF05(param_01);
	}

	var_0C [[ level.agent_funcs[var_0C.agent_type]["on_damaged_finished"] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0A,param_0B);
}

//Function Number: 2
func_89AA(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00.katanadeath = 1;
	param_00.var_180 = 1;
	param_00 method_841F();
	param_00.var_EF64 = 1;
	var_03 = param_00 gettagorigin("j_neck");
	if(param_00.agent_type == "skater")
	{
		param_00 dodamage(param_00.health + 1000,param_00.origin,param_01,undefined,"MOD_EXPLOSIVE","iw7_katana_zm");
		return;
	}

	param_00 setscriptablepartstate("katana_death","active",1);
	var_04 = ["left_arm","right_arm"];
	var_04 = scripts\common\utility::array_randomize(var_04);
	foreach(var_06 in level.players)
	{
		if(distance(var_06.origin,param_00.origin) <= 512)
		{
			var_06 thread scripts\cp\zombies\zmb_zombies_weapons::func_10142();
		}
	}

	if(!scripts\common\utility::istrue(param_00.var_9BA7))
	{
		var_03 = param_00 gettagorigin("j_spine4");
		playfx(level._effect["gore"],var_03,(1,0,0));
		if(issubstr(param_02,"katana"))
		{
			playsoundatpos(var_03,"gib_fullbody_katana");
		}
		else
		{
			playsoundatpos(var_03,"gib_fullbody");
		}

		param_00 setscriptablepartstate("head","detached",1);
		foreach(var_09 in var_04)
		{
			param_00 setscriptablepartstate(var_09,"detached",1);
		}
	}
	else
	{
		foreach(var_09 in var_05)
		{
			param_00 setscriptablepartstate(var_09,"detached",1);
		}
	}

	wait(2);
	var_04 = ["right_leg","left_leg"];
	var_04 = scripts\common\utility::array_randomize(var_04);
	foreach(var_09 in var_04)
	{
		param_00 setscriptablepartstate(var_09,"detached",1);
	}

	param_00.full_gib = 1;
	param_00.katanadeath = 0;
	param_00.var_EF64 = 0;
	param_00 dodamage(param_00.health + 1000,param_00.origin,param_01,undefined,"MOD_EXPLOSIVE","iw7_katana_zm");
}

//Function Number: 3
cp_disco_onzombiekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
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

	if(issubstr(param_04,"iw7_knife") && isplayer(param_01) && scripts\cp\_utility::func_9C42(param_04))
	{
		param_01 thread lib_0CBC::func_F640(param_01);
	}
	else if((param_04 == "iw7_axe_zm" || param_04 == "iw7_axe_zm_pap1" || param_04 == "iw7_axe_zm_pap2") && isplayer(param_01) && scripts\cp\_utility::func_9C42(param_04))
	{
		param_01 thread lib_0CBC::func_F640(param_01);
	}
	else if(issubstr(param_04,"golf") || issubstr(param_04,"machete") || issubstr(param_04,"spiked_bat") || issubstr(param_04,"two_headed_axe"))
	{
		param_01 thread lib_0CBC::func_F640(param_01);
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

	if(isplayer(param_01))
	{
		if(scripts\common\utility::istrue(self.marked_shared_fate_fnf))
		{
			self.marked_shared_fate_fnf = 0;
			param_01.marked_ents = scripts\common\utility::func_22A9(param_01.marked_ents,self);
			param_01 thread scripts\cp\_utility::add_to_notify_queue("weapon_hit_marked_target",param_01,param_02,param_03,param_04,self);
			self setscriptablepartstate("shared_fate_fx","inactive",1);
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

	var_0E = 0;
	var_0F = 0;
	var_10 = 0;
	var_11 = scripts\common\utility::istrue(self.var_9CDD);
	if(isdefined(level.var_12EFF) && isplayer(param_01))
	{
		param_01 thread [[ level.var_12EFF ]](self,param_04);
	}

	if((scripts\common\utility::func_9D74(param_03) && getweaponbasename(param_04) == "iw7_atomizer_mp" || scripts\common\utility::istrue(self.atomize_me)) || param_03 == "MOD_UNKNOWN" && getweaponbasename(param_04) == "iw7_harpoon3_zm")
	{
		if(!var_11 && !var_0E && !var_0F && !var_10)
		{
			self playsound("bullet_atomizer_impact_npc");
			if(isdefined(self.var_2C09))
			{
				self.var_2C09 thread lib_0CBC::func_CEF1();
				self.var_2C09 hide(1);
			}
		}
	}

	if(isplayer(param_01))
	{
		param_01 thread scripts\cp\_utility::add_to_notify_queue("zombie_killed",self,self.origin,param_04,param_03);
	}

	if(isdefined(level.on_zombie_killed_quests_func))
	{
		[[ level.on_zombie_killed_quests_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	if(!lib_0CBC::func_9EC6(self))
	{
		lib_0CBC::func_6563(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
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

	if(isdefined(self.var_BE74) && !var_11)
	{
		if(isdefined(level.var_4297))
		{
			var_12 = level [[ level.var_4297 ]](self);
		}
		else
		{
			var_12 = undefined;
		}

		if(isdefined(var_12))
		{
			if(isdefined(level.var_4ADE))
			{
				thread lib_0CBC::delayminiufocollection(self.origin,param_04,var_12);
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
	disco_process_kill_rewards(param_00,param_01,self,param_06,param_03,param_04);
	lib_0CBC::func_D95F(param_01);
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
	if(isdefined(level.cp_rave_zombie_death_pos_record_func))
	{
		[[ level.cp_rave_zombie_death_pos_record_func ]](self.origin);
	}

	level thread scripts\cp\_utility::add_to_notify_queue("zombie_killed",self.origin,param_04,param_03,param_01,self);
}

//Function Number: 4
disco_process_kill_rewards(param_00,param_01,param_02,param_03,param_04,param_05)
{
	lib_0CBC::func_82A2(param_00,param_01,param_03,param_04,param_05);
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
			if(issubstr(param_05,"heart"))
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_ww_heart","disco_comment_vo","high",10,0,0,0,10);
			}
			else
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_headshot","disco_comment_vo","low",10,0,0,0,10);
			}
		}
		else
		{
			if(scripts\common\utility::istrue(var_07.kung_fu_mode))
			{
				if(randomint(100) > 30)
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_kungfumode","disco_comment_vo","high",10,0,0,0,10);
				}
				else
				{
					var_0A = 1;
					if(issubstr(param_05,"nunchucks"))
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_ww_nunchuck","disco_comment_vo","high",10,0,0,0,10);
					}
					else if(issubstr(param_05,"katana"))
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_ww_katana","disco_comment_vo","high",10,0,0,0,10);
					}
					else if(issubstr(param_05,"heart"))
					{
						var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_ww_heart","disco_comment_vo","high",10,0,0,0,10);
					}
				}
			}

			if(var_0A != 1)
			{
				if(issubstr(param_05,"nunchucks"))
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_ww_nunchuck","disco_comment_vo","high",10,0,0,0,10);
				}
				else if(issubstr(param_05,"katana"))
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_ww_katana","disco_comment_vo","high",10,0,0,0,10);
				}
				else if(issubstr(param_05,"heart"))
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_ww_heart","disco_comment_vo","high",10,0,0,0,10);
				}
			}
		}

		if(var_0A == 0)
		{
			if(param_02.agent_type == "skater")
			{
				if(randomint(100) > 60)
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_skater","disco_comment_vo","low",10,0,0,0,20);
				}
				else
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm","disco_comment_vo","low",10,0,0,0,20);
				}
			}
			else if(param_02.agent_type == "karatemaster")
			{
				if(randomint(100) > 60)
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm_kungfumode","disco_comment_vo","low",10,0,0,0,20);
				}
				else
				{
					var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm","disco_comment_vo","low",10,0,0,0,20);
				}
			}
			else
			{
				var_07 thread scripts\cp\_vo::try_to_play_vo("killfirm","disco_comment_vo","low",10,0,0,0,20);
			}
		}
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
			var_0F = isdefined(param_02.agent_type) && param_02.agent_type == "zombie_brute" || param_02.agent_type == "zombie_grey";
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

			if(!var_09 && !var_0F)
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

//Function Number: 5
play_rave_death_fx(param_00)
{
	var_01 = ["j_spineupper","j_spinelower"];
	if(!isdefined(param_00))
	{
		var_02 = level._effect["atomize_body"];
	}
	else
	{
		var_02 = level._effect[var_01];
	}

	var_03 = spawnfx(var_02,self gettagorigin("j_spinelower"));
	foreach(var_05 in level.players)
	{
		if(!scripts\common\utility::istrue(var_05.var_DCEB))
		{
			var_03 method_8429(var_05);
			continue;
		}

		self method_8429(var_05);
	}

	triggerfx(var_03);
	var_03 thread delete_death_fx(var_03);
}

//Function Number: 6
delete_death_fx(param_00)
{
	level endon("game_ended");
	wait(2.5);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 7
callback_discozombieplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(!scripts\cp\zombies\zombie_damage::func_100AA(param_02,param_01,param_05,param_03))
	{
		return;
	}

	if(param_04 == "MOD_SUICIDE")
	{
		if(isdefined(level.var_C7E9[param_05]))
		{
			level thread [[ level.var_C7E9[param_05] ]](var_0C,param_05);
		}
	}

	var_0D = isdefined(param_04) && param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE_SPLASH";
	var_0E = isdefined(param_04) && param_04 == "MOD_EXPLOSIVE_BULLET";
	var_0F = scripts\cp\zombies\zombie_damage::isfriendlyfire(self,param_01);
	var_10 = isdefined(param_05) && param_05 == "iw7_sasq_rock_mp";
	var_11 = scripts\cp\_utility::func_9BFB();
	var_12 = scripts\cp\_utility::has_zombie_perk("perk_machine_boom");
	var_13 = isdefined(param_01);
	var_14 = var_13 && isdefined(param_01.var_1096F) && param_01.var_1096F == "zombie";
	var_15 = var_13 && isdefined(param_01.var_1096F) && param_01.var_1096F == "zombie_grey";
	var_16 = var_13 && isdefined(param_01.agent_type) && param_01.agent_type == "zombie_brute";
	var_17 = var_13 && param_01 == self;
	var_18 = var_13 && isdefined(param_01.agent_type) && param_01.agent_type == "zombie_sasquatch";
	var_19 = var_13 && isdefined(param_01.agent_type) && param_01.agent_type == "slasher";
	var_1A = var_13 && isdefined(param_01.agent_type) && param_01.agent_type == "superslasher";
	var_1B = (var_17 || !var_13) && param_04 == "MOD_SUICIDE";
	if(var_13)
	{
		if(param_01 == self)
		{
			if(var_0D)
			{
				var_1C = self getstance();
				if(var_12)
				{
					param_02 = 0;
				}
				else if(isdefined(self.has_fortified_passive) && self.has_fortified_passive && self method_81BE() || (var_1C == "crouch" || var_1C == "prone") && self isonground())
				{
					param_02 = 0;
				}
				else
				{
					param_02 = scripts\cp\zombies\zombie_damage::func_79A8(param_00,param_01,param_02,param_03,param_04,param_05);
				}
			}

			switch(param_05)
			{
				case "iw7_shuriken_zm_crane":
				case "iw7_shuriken_zm_tiger":
				case "iw7_shuriken_zm_dragon":
				case "iw7_shuriken_zm_snake":
				case "iw7_shuriken_crane_proj":
				case "iw7_shuriken_snake_proj":
				case "iw7_shuriken_tiger_proj":
				case "iw7_shuriken_dragon_proj":
				case "zmb_fireworksprojectile_mp":
				case "zmb_imsprojectile_mp":
				case "iw7_armageddonmeteor_mp":
					param_02 = 0;
					break;

				case "iw7_stunbolt_zm":
				case "iw7_bluebolts_zm":
				case "blackhole_grenade_zm":
				case "blackhole_grenade_mp":
					param_02 = 25;
					break;

				default:
					break;
			}
		}
		else if(var_0F)
		{
			if(var_11)
			{
				if(scripts\cp\_utility::func_9CA6())
				{
					if(isplayer(param_01) && isdefined(param_08) && param_08 != "shield")
					{
						if(isdefined(param_00))
						{
							param_01 dodamage(param_02,param_01.origin - (0,0,50),param_01,param_00,param_04);
						}
						else
						{
							param_01 dodamage(param_02,param_01.origin,param_01);
						}
					}

					param_02 = 0;
				}
			}
			else
			{
				param_02 = 0;
			}
		}
		else if(var_14)
		{
			if(scripts\common\utility::istrue(self.kung_fu_shield))
			{
				return;
			}

			if(param_04 != "MOD_EXPLOSIVE" && var_0C scripts\cp\_utility::func_9BA0("burned_out"))
			{
				if(!scripts\common\utility::istrue(param_01.var_9B81))
				{
					var_0C scripts\cp\_utility::func_C151("burned_out");
					param_01 thread scripts\cp\_utility::func_4D0D(param_01,var_0C,3,int(param_01.maxhealth + 1000),param_04,"incendiary_ammo_mp",undefined,"burning");
					param_01.faf_burned_out = 1;
				}
			}

			var_1D = gettime();
			if(!isdefined(self.var_A92D) || var_1D - self.var_A92D > 20)
			{
				self.var_A92D = var_1D;
			}
			else
			{
				return;
			}

			var_1E = 500;
			if(getdvarint("zom_damage_shield_duration") != 0)
			{
				var_1E = getdvarint("zom_damage_shield_duration");
			}

			if(isdefined(param_01.var_A8A2[self.var_134FD]))
			{
				var_1F = param_01.var_A8A2[self.var_134FD];
				if(var_1F + var_1E > gettime())
				{
					param_02 = 0;
				}
				else
				{
					param_01.var_A8A2[self.var_134FD] = gettime();
				}
			}
			else
			{
				param_01.var_A8A2[self.var_134FD] = gettime();
			}
		}

		if(var_0E)
		{
			var_1C = self getstance();
			if(var_12)
			{
				param_02 = 0;
			}
			else if(isdefined(self.has_fortified_passive) && self.has_fortified_passive && self method_81BE() || (var_1C == "crouch" || var_1C == "prone") && self isonground())
			{
				param_02 = 0;
			}
			else if(!var_11 || param_01 == self && param_08 == "none")
			{
				param_02 = 0;
			}
		}
	}
	else if(var_12 && param_04 == "MOD_SUICIDE")
	{
		if(param_05 == "frag_grenade_zm" || param_05 == "cluster_grenade_zm")
		{
			param_02 = 0;
		}
	}
	else
	{
		var_1C = self getstance();
		if(isdefined(self.has_fortified_passive) && self.has_fortified_passive && self method_81BE() || (var_1C == "crouch" || var_1C == "prone") && self isonground())
		{
			if(param_05 == "frag_grenade_zm" || param_05 == "cluster_grenade_zm")
			{
				param_02 = 0;
			}
		}
	}

	if(param_04 == "MOD_FALLING")
	{
		if(scripts\cp\_utility::_hasperk("specialty_falldamage"))
		{
			param_02 = 0;
		}
		else if(param_02 > 10)
		{
			if(param_02 > self.health * 0.15)
			{
				param_02 = int(self.health * 0.15);
			}
		}
		else
		{
			param_02 = 0;
		}
	}

	var_20 = 0;
	if(var_13 && param_01 scripts\cp\_utility::func_9D20() && scripts\common\utility::istrue(self.var_AD2D))
	{
		if(self.health - param_02 < 1)
		{
			param_02 = self.health - 1;
		}
	}

	if(var_14 || var_15 || var_16 || var_17 && !var_1B)
	{
		param_02 = int(param_02 * var_0C scripts\cp\_utility::func_7E5C());
	}

	if(isdefined(self.var_AD2C))
	{
		param_02 = int(max(self.maxhealth / 2.75,param_02));
	}

	if(var_0C scripts\cp\_utility::func_9BA0("secret_service") && isalive(param_01))
	{
		var_21 = 0;
		if(isdefined(param_01.agent_type) && param_01.agent_type == "zombie_sasquatch" || param_01.agent_type == "slasher" || param_01.agent_type == "superslasher")
		{
			var_21 = 0;
		}
		else if(param_01 scripts\cp\_utility::agentisfnfimmune())
		{
			var_21 = 0;
		}
		else if(isplayer(var_0C) && isplayer(param_01))
		{
			var_21 = 0;
		}
		else
		{
			var_21 = 1;
		}

		if(var_21)
		{
			param_01 thread scripts\cp\zombies\craftables\_revocator::func_1299C(var_0C);
			var_0C scripts\cp\_utility::func_C151("secret_service");
		}
	}

	param_02 = int(param_02);
	if(!var_0F || var_11)
	{
		scripts\cp\zombies\zombie_damage::func_6CE1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_20,param_0A,param_0B);
		thread scripts\cp\_utility::add_to_notify_queue("player_damaged");
	}

	lib_0A54::func_12E04("personal","damage_taken",param_02);
	if(param_02 <= 0)
	{
		return;
	}

	if(var_10)
	{
		playfxontagforclients(level._effect["sasquatch_rock_hit"],self,"tag_eye",self);
	}

	thread scripts\cp\_utility::func_D222(param_01);
	thread scripts\cp\zombies\zombie_damage::func_CDBE(self);
	if(isdefined(param_05) && param_05 == "iw7_ratking_shield_projectile")
	{
		self playlocalsound("rk_shield_throw_hit_plr");
	}
	else
	{
		self playlocalsound("zmb_player_impact_hit");
	}

	thread scripts\cp\_utility::func_D220();
	if(isdefined(param_01))
	{
		thread scripts\cp\_hud_util::func_13F0C();
		if(isagent(param_01))
		{
			if(param_02 > self.health)
			{
				param_01.killed_player = 1;
			}

			if(!isdefined(param_01.var_4CE9))
			{
				param_01.var_4CE9 = 0;
			}
			else
			{
				param_01.var_4CE9 = param_01.var_4CE9 + param_02;
			}

			self.var_DDB9 = param_01;
			if(isdefined(level.var_4B4A))
			{
				self [[ level.custom_playerdamage_challenge_func ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
				return;
			}
		}
	}
}

//Function Number: 8
playbodyfx_ww(param_00,param_01,param_02)
{
	var_03[0][1]["org"] = self gettagorigin("j_spinelower");
	var_03[0][1]["angles"] = self gettagangles("j_spinelower");
	var_04 = undefined;
	var_05 = undefined;
	if(issubstr(param_00,"iw7_harpoon1_zm") || issubstr(param_00,"iw7_acid_rain_projectile_zm"))
	{
		self hide(0);
		param_01.nocorpse = 0;
		param_01.full_gib = 0;
		var_03[0][0]["org"] = self gettagorigin("j_spineupper");
		var_03[0][0]["angles"] = self gettagangles("j_spineupper");
		var_04 = level._effect["wrecked_cheap"];
		var_05 = level._effect["acid_rain_death"];
	}
	else if(issubstr(param_00,"iw7_harpoon2_zm"))
	{
		var_04 = level._effect["wrecked_by_ben"];
	}
	else
	{
		var_04 = level._effect["wrecked_cheap"];
	}

	foreach(var_07 in var_03)
	{
		foreach(var_09 in var_07)
		{
			if((issubstr(param_00,"iw7_harpoon1_zm") || issubstr(param_00,"iw7_acid_rain_projectile_zm")) && !scripts\common\utility::istrue(level.played_acid_rain_effect))
			{
				level.played_acid_rain_effect = 1;
				if(isdefined(var_04))
				{
					playfx(var_04,var_09["org"],anglestoforward(var_09["angles"]));
				}

				scripts\common\utility::func_136F7();
				if(isdefined(var_05))
				{
					playfx(var_05,var_09["org"]);
					scripts\common\utility::func_136F7();
				}

				continue;
			}

			if((issubstr(param_00,"iw7_harpoon2_zm") || issubstr(param_00,"iw7_harpoon2_zm_stun")) && !scripts\common\utility::istrue(level.played_ben_franklin_effect))
			{
				level.played_ben_franklin_effect = 1;
				if(isdefined(var_04))
				{
					playfx(var_04,var_09["org"],anglestoforward(var_09["angles"]));
				}

				scripts\common\utility::func_136F7();
				continue;
			}

			if(isdefined(var_04))
			{
				playfx(var_04,var_09["org"],anglestoforward(var_09["angles"]));
			}

			scripts\common\utility::func_136F7();
		}

		wait(0.01);
	}
}

//Function Number: 9
is_kung_fu_punch(param_00,param_01)
{
	switch(param_01)
	{
		case "iw7_fists_zm_tiger":
		case "iw7_fists_zm_snake":
		case "iw7_fists_zm_dragon":
		case "iw7_fists_zm_crane":
			return 1;

		default:
			break;
	}

	return 0;
}

//Function Number: 10
kung_fu_damage_everyone_in_radius(param_00,param_01,param_02,param_03)
{
	scripts\common\utility::func_136F7();
	var_04 = param_01 * param_01;
	foreach(var_06 in level.spawned_enemies)
	{
		if(scripts\common\utility::istrue(var_06.kung_fu_punched))
		{
			continue;
		}

		if(distancesquared(var_06.origin,param_00) < var_04)
		{
			var_07 = var_06.health + 1000;
			if(param_03)
			{
				var_07 = 1;
			}

			var_06 dodamage(var_07,param_02.origin,param_02,param_02,"MOD_MELEE","iw7_fists_zm_base");
			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 11
chi_hit(param_00,param_01,param_02)
{
	var_03 = 100;
	var_04 = 20;
	var_05 = vectornormalize(self.origin - param_00.origin) * var_03 + (0,0,var_04);
	var_06 = self.origin + var_05;
	var_07 = level._effect["chi_ghost_hit_blue"];
	if(isdefined(param_00.kung_fu_progression.active_discipline))
	{
		var_08 = param_00.kung_fu_progression.active_discipline;
		switch(var_08)
		{
			case "crane":
				param_00 thread play_scriptable_fx("crane_hit");
				var_07 = level._effect["chi_ghost_hit_blue"];
				break;

			case "dragon":
				param_00 thread play_scriptable_fx("dragon_hit");
				var_07 = level._effect["chi_ghost_hit_yellow"];
				break;

			case "snake":
				param_00 thread play_scriptable_fx("snake_hit");
				var_07 = level._effect["chi_ghost_hit_green"];
				break;

			case "tiger":
				param_00 thread play_scriptable_fx("tiger_hit");
				var_07 = level._effect["chi_ghost_hit_red"];
				break;

			default:
				break;
		}
	}
}

//Function Number: 12
play_scriptable_fx(param_00)
{
	self setscriptablepartstate("kung_fu_melee",param_00);
	wait(0.1);
	self setscriptablepartstate("kung_fu_melee","off");
}