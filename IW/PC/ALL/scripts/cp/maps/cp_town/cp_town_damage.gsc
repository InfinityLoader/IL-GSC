/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_town\cp_town_damage.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 849 ms
 * Timestamp: 10/27/2023 12:07:16 AM
*******************************************************************/

//Function Number: 1
cp_town_onzombiedamaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
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

	var_0D = lib_0CBC::func_FF2E(param_01,param_02,param_04,param_05,param_08,var_0C);
	if(!var_0D)
	{
		return;
	}

	var_0E = scripts\common\utility::istrue(var_0C.hit_by_dodging_player);
	var_0F = param_04 == "MOD_MELEE";
	var_10 = scripts\common\utility::istrue(param_01.inlaststand);
	var_11 = scripts\common\utility::istrue(var_0C.var_9CDD);
	param_03 = param_03 | 4;
	var_12 = isdefined(param_01) && isplayer(param_01);
	var_13 = scripts\common\utility::func_9D74(param_04) || param_04 == "MOD_EXPLOSIVE_BULLET" && param_08 != "none";
	var_14 = var_13 && scripts\cp\_utility::func_9E27(param_05,param_08,param_04,param_01);
	var_15 = scripts\common\utility::istrue(self.var_28E0);
	var_16 = scripts\common\utility::istrue(level.var_9925) && !scripts\cp\_utility::agentisinstakillimmune();
	var_17 = (param_04 == "MOD_EXPLOSIVE_BULLET" && isdefined(param_08) && param_08 == "none") || param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE" || param_04 == "MOD_PROJECTILE_SPLASH";
	var_18 = !var_10 && var_14 && var_13 && param_01 scripts\cp\_utility::func_9BA0("headshot_explosion");
	var_19 = var_0F && param_01 scripts\cp\_utility::func_9BA0("increased_melee_damage");
	var_1A = var_0F && param_01 scripts\cp\_utility::func_9BA0("shock_melee_upgrade");
	var_1B = scripts\cp\_utility::func_9D3E(param_05);
	var_1C = scripts\cp\_utility::agentisfnfimmune();
	var_1D = scripts\cp\_utility::agentisinstakillimmune();
	var_1E = var_12 && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_change");
	var_1F = scripts\cp\_utility::agentisspecialzombie();
	if(isdefined(param_05) && issubstr(param_05,"iw7_gauss_zml"))
	{
		var_20 = 250;
		if(scripts\cp\_utility::func_13C90(param_05,"pap1"))
		{
			var_20 = 470;
		}

		if(scripts\cp\_utility::func_13C90(param_05,"pap2"))
		{
			var_20 = 734;
		}

		if(scripts\cp\_utility::func_13C90(param_05,"doubletap"))
		{
			var_20 = 1.33 * var_20;
		}

		if(param_02 >= var_20)
		{
			self.hitbychargedshot = param_01;
		}
	}

	if(var_12 && !var_1C)
	{
		if(scripts\common\utility::istrue(self.marked_shared_fate_fnf))
		{
			param_01 thread scripts\cp\_utility::add_to_notify_queue("weapon_hit_marked_target",param_01,param_02,param_04,param_05,self);
		}

		self.damaged_by_player = 1;
		if(scripts\common\utility::istrue(param_01.stimulus_active))
		{
			playfx(level._effect["stimulus_glow_burst"],self gettagorigin("j_spineupper"));
			scripts\common\utility::play_sound_in_space("zmb_fnf_stimulus",self gettagorigin("j_spineupper"));
			foreach(var_22 in level.players)
			{
				if(var_22 == param_01)
				{
					if(distance2dsquared(var_22.origin,self.origin) <= 10000)
					{
						playfx(level._effect["stimulus_glow_burst"],self gettagorigin("j_spineupper"));
						playfx(level._effect["stimulus_shield"],var_22 gettagorigin("tag_eye"),anglestoforward(var_22.angles),anglestoup(var_22.angles),var_22);
						if(param_02 >= self.health)
						{
							if(scripts\common\utility::istrue(var_22.inlaststand))
							{
								lib_0D59::revive_downed_entities(var_22);
							}
						}

						if(var_22.health + param_02 / level.players.size + 1 >= var_22.maxhealth)
						{
							var_22.health = var_22.maxhealth;
						}
						else
						{
							var_22.health = int(var_22.health + param_02 / level.players.size + 1);
						}
					}

					continue;
				}

				if(distance2dsquared(var_22.origin,self.origin) <= 10000)
				{
					playfx(level._effect["stimulus_glow_burst"],self gettagorigin("j_spineupper"));
					playfx(level._effect["stimulus_shield"],var_22 gettagorigin("tag_eye"));
					if(param_02 >= self.health)
					{
						if(scripts\common\utility::istrue(var_22.inlaststand))
						{
							lib_0D59::revive_downed_entities(var_22);
						}
					}

					if(int(var_22.health + param_02 / level.players.size + 1) >= var_22.maxhealth)
					{
						var_22.health = var_22.maxhealth;
						continue;
					}

					var_22.health = int(var_22.health + param_02 / level.players.size + 1);
				}
			}
		}
	}

	if(isdefined(param_01.var_9CEF) && param_01.var_9CEF && param_04 != "MOD_SUICIDE")
	{
		param_02 = param_01.var_B57A;
	}

	var_24 = 0;
	if(!var_0F && lib_0CBC::checkaltmodestatus(param_05) && var_12 && !isdefined(param_01.var_AD2C) && param_01 scripts\cp\_utility::func_9BA0("sniper_soft_upgrade"))
	{
		var_24 = param_01 scripts\cp\_utility::func_4626(param_05) == "weapon_sniper";
	}

	var_25 = !var_1C && scripts\common\utility::istrue(level.var_69FA) && isdefined(param_04) && param_04 == "MOD_UNKNOWN";
	var_26 = isdefined(param_05) && param_05 == "iw7_knife_zm_cleaver" && iscrog(self);
	if(isdefined(param_05) && param_05 == "iw7_knife_zm_cleaver" && !iscrog(self))
	{
		scripts\cp\_utility::add_to_notify_queue("cleaver_damage_zombie");
	}

	var_27 = !var_1D && var_15 || var_16 || var_26 || var_1A || var_25 || var_18 || var_19 || var_24;
	var_28 = scripts\common\utility::istrue(self.var_9E0C);
	var_29 = var_12 && var_0F && param_01.var_4BF5 == "iw7_knife_zm_cleaver";
	if(var_29)
	{
		if(scripts\common\utility::istrue(self.glowing) && param_02 >= self.health)
		{
			level.death_by_cleaver = 1;
			level.death_by_cleaver_org = self.origin;
		}
	}

	if(var_27 && !var_1C)
	{
		if(var_24)
		{
			param_01 scripts\cp\_utility::func_C151("sniper_soft_upgrade");
		}

		param_02 = int(self.maxhealth);
		if(var_1A)
		{
			if(isdefined(param_06))
			{
				playfx(level._effect["shock_melee_impact"],param_06);
			}

			param_01 thread scripts\cp\zombies\zombie_damage::func_11193(self geteye(),self,self.maxhealth,"MOD_UNKNOWN",undefined,var_1A);
		}

		if(var_13)
		{
			param_01 thread scripts\cp\_utility::add_to_notify_queue("weapon_hit_enemy",self,param_01,param_05,param_02,param_08,param_04);
		}
	}
	else
	{
		param_08 = lib_0CBC::func_FE39(param_01,param_04,param_05,param_08);
		var_2A = level.wave_num;
		var_2B = lib_0CBC::func_9BF7(param_05,param_04);
		var_2C = scripts\common\utility::istrue(self.var_9B81) && !var_13;
		var_2D = var_14 && param_01 scripts\cp\_utility::func_9BA0("sharp_shooter_upgrade");
		var_2E = var_13 && param_01 scripts\cp\_utility::func_9BA0("bonus_damage_on_last_bullets");
		var_2F = var_13 && param_01 scripts\cp\_utility::func_9BA0("damage_booster_upgrade");
		var_30 = var_13 && isdefined(param_01.special_ammo_weapon) && param_01.special_ammo_weapon == param_05;
		var_31 = var_12 && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_boom");
		var_32 = var_12 && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_smack");
		var_33 = scripts\common\utility::func_2286(level.melee_weapons,param_05);
		var_34 = weaponclass(param_05) == "spread" && param_01 scripts\cp\_weapon::func_8BD1(param_05,"smart");
		var_35 = weaponclass(param_05) == "spread" && !var_34 && param_01 scripts\cp\_weapon::func_8BD1(param_05,"arkpink") || scripts\cp\_weapon::func_8BD1(param_05,"arkyellow");
		var_36 = var_14 && var_13 && param_01 scripts\cp\_weapon::func_8BD1(param_05,"highcal");
		if(issubstr(param_05,"cutie") && var_12)
		{
			var_37 = 7000;
			self.ragdollhitloc = param_08;
			if(!isdefined(param_07))
			{
				param_07 = vectornormalize(self.origin - param_01.origin);
			}

			if(lengthsquared(param_07) < 1)
			{
				var_38 = self.origin - param_01.origin;
				var_38 = vectornormalize((var_38[0],var_38[1],var_38[2]));
				self.ragdollimpactvector = var_38 * var_37;
			}
			else
			{
				self.ragdollimpactvector = param_07 * var_37;
			}
		}

		if(var_1B && issubstr(param_05,"+gl"))
		{
			param_02 = lib_0CBC::scalegldamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
		}

		if(var_34)
		{
			param_02 = param_02 * 0.5;
		}

		param_02 = lib_0CBC::func_9830(undefined,param_01,param_02,undefined,param_04,param_05,undefined,undefined,param_08,undefined,undefined,undefined);
		if(var_35)
		{
			param_02 = param_02 * 4;
		}

		if(var_12)
		{
			if(var_0F)
			{
				param_02 = int(param_02 * param_01 lib_0CFC::func_CA3A());
				if(isdefined(param_01.passive_melee_kill_damage))
				{
					param_02 = param_02 + param_01.passive_melee_kill_damage;
				}

				if(var_32)
				{
					param_02 = param_02 + 1500;
				}

				var_39 = 0;
				if(param_02 >= self.health)
				{
					var_39 = 1;
				}

				if(isdefined(param_01.increased_melee_damage))
				{
					param_02 = param_02 + param_01.increased_melee_damage;
				}

				if(var_33 && var_39)
				{
					param_01 thread scripts\cp\_utility::add_to_notify_queue("melee_weapon_hit",param_05,self,param_02);
				}

				if(var_32)
				{
					if(var_39)
					{
						self.var_102CD = 1;
					}
				}
			}

			if(var_30)
			{
				param_01 thread scripts\cp\zombies\zombie_damage::func_11193(self geteye(),self,param_02,param_04,128);
			}

			if(var_31 && var_17)
			{
				param_02 = int(param_02 * 2);
			}

			if(isdefined(param_01.stimulus_damage_buff))
			{
				param_02 = int(param_02 * 4);
			}
		}

		if(var_2D)
		{
			param_02 = param_02 * 3;
		}

		if(var_2E)
		{
			var_3A = int(param_01 getweaponammoclip(param_01 getcurrentweapon()) + 1);
			var_3B = weaponclipsize(param_01 getcurrentweapon());
			if(var_3A <= 4)
			{
				param_02 = param_02 * 2;
			}
		}

		if(var_13 && scripts\common\utility::istrue(param_01.var_DF50))
		{
			param_02 = param_02 * 2;
		}

		if(var_2B)
		{
			param_02 = param_02 * min(2 + var_2A * 0.5,10);
		}

		if(var_2F && !var_1F)
		{
			param_02 = int(param_02 * 2);
		}

		if(var_36)
		{
			param_02 = param_02 * 1.2;
		}

		if(var_12 && var_0E && !var_1F)
		{
			if(!isdefined(self.var_AAA8))
			{
				var_37 = 7000;
				self.kung_fu_punched = 1;
				self.ragdollhitloc = param_08;
				if(!isdefined(param_07))
				{
					param_07 = vectornormalize(self.origin - param_01.origin);
				}

				if(lengthsquared(param_07) < 1)
				{
					var_38 = self.origin - param_01.origin;
					var_38 = vectornormalize((var_38[0],var_38[1],var_38[2]));
					self.ragdollimpactvector = var_38 * var_37;
				}
				else
				{
					self.ragdollimpactvector = param_07 * var_37;
				}

				param_02 = 100000000;
			}
		}
	}

	if(isdefined(param_01.var_CA2F) && param_01.var_CA2F["damagemod"].var_3237 == 2 && var_13)
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
	param_02 = lib_0CBC::func_6BA4(self,param_05,param_02,0,var_1F,0,0);
	if(isdefined(param_01.special_zombie_damage) && var_1F)
	{
		param_02 = param_02 * param_01.special_zombie_damage;
	}

	if(iscrog(self) && isdefined(level.special_zombie_damage_func) && isdefined(level.special_zombie_damage_func[self.agent_type]))
	{
		param_02 = self [[ level.special_zombie_damage_func[self.agent_type] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
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

		if(var_12 && var_1E)
		{
			if(isdefined(self.agent_type) && self.agent_type == "generic_zombie")
			{
				if(param_05 == "iw7_change_chews_zm")
				{
					self.nocorpse = 1;
					self.full_gib = 1;
				}
				else if(var_14)
				{
					var_3C = 50;
					if(randomint(100) < var_3C)
					{
						switch(param_01.sub_perks["perk_machine_change"])
						{
							case "perk_machine_change1":
								playfx(level._effect["cc_head_nuke"],param_06);
								playsoundatpos(param_06,"change_chew_nuke_explo");
								param_01 thread change_chews_damage_over_time(self,param_01,96,"explode");
								break;

							case "perk_machine_change2":
								playfx(level._effect["cc_zap_burst"],param_06);
								playsoundatpos(param_06,"change_chew_electric_explo");
								param_01 thread change_chews_damage_over_time(self,param_01,196,"shocked");
								break;

							case "perk_machine_change3":
								playfx(level._effect["cc_fire_burst"],param_06);
								playsoundatpos(param_06,"change_chew_fire_explo");
								param_01 thread change_chews_damage_over_time(self,param_01,128,"burning");
								break;

							case "perk_machine_change4":
								playfx(level._effect["cc_ice_burst"],param_06);
								param_01 thread change_chews_damage_over_time(self,param_01,128,"frozen");
								break;

							default:
								break;
						}
					}
				}
			}
		}

		if(isdefined(self.agent_type) && self.agent_type == "crab_mini")
		{
			if(param_04 == "MOD_SUICIDE")
			{
				self.vignette_nocorpse = 1;
			}
			else
			{
				thread scripts\mp\agents\crab_mini\crab_mini_agent::create_sludge_pool(self.origin);
			}
		}
		else if(isdefined(self.agent_type) && self.agent_type == "crab_brute")
		{
			thread scripts\mp\agents\crab_brute\crab_brute_agent::create_brute_death_fx(self.origin);
		}
	}

	if(var_12)
	{
		if(isdefined(level.var_12EDE))
		{
			level thread [[ level.var_12EDE ]](param_01,param_05,self);
		}

		param_01 thread scripts\cp\_utility::add_to_notify_queue("weapon_hit_enemy",self,param_01,param_05,param_02,param_08,param_04);
		param_01 thread lib_0CBC::func_12EC5(getweaponbasename(param_05));
		if(var_13)
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
	if(isdefined(self.agent_type) && isdefined(level.damage_feedback_overrride) && isdefined(level.damage_feedback_overrride[self.agent_type]))
	{
		[[ level.damage_feedback_overrride[self.agent_type] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	}
	else
	{
		scripts\cp\_agent_utils::func_D96B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	}

	scripts\cp\_agent_utils::func_110A4(param_01,param_02);
	scripts\cp\zombies\zmb_zombies_weapons::func_1094D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	if(var_12)
	{
		thread lib_0CBC::func_BF05(param_01);
	}

	var_0C [[ level.agent_funcs[var_0C.agent_type]["on_damaged_finished"] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0A,param_0B);
}

//Function Number: 2
cp_town_onzombiekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
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

	if(scripts\common\utility::istrue(self.activated_slomo_sphere))
	{
		self.activated_slomo_sphere = undefined;
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

		if(isdefined(self.var_103F2))
		{
			var_0E = 100;
			var_0F = 3;
			var_10 = self.origin + (0,0,20);
			var_11 = (randomint(350),randomint(350),randomint(350));
			var_11 = vectornormalize(var_11) * var_0E;
			var_12 = self method_8449("frag_grenade_zm",var_10,var_11,var_0F);
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

	if(should_reset_scriptable_states_on_death())
	{
		scripts\cp\zombies\zombie_scriptable_states::func_1296F(self);
	}

	if(scripts\common\utility::func_6E34("force_drop_max_ammo") && scripts\common\utility::flag("force_drop_max_ammo") && param_03 != "MOD_SUICIDE")
	{
		if(isdefined(level.drop_max_ammo_func))
		{
			level thread [[ level.drop_max_ammo_func ]](self.origin,param_01,"ammo_max");
		}

		scripts\common\utility::func_6E2A("force_drop_max_ammo");
	}

	var_13 = 0;
	var_14 = 0;
	var_15 = 0;
	var_16 = scripts\common\utility::istrue(self.var_9CDD);
	if(isdefined(level.var_12EFF) && isplayer(param_01))
	{
		param_01 thread [[ level.var_12EFF ]](self,param_04);
	}

	if(getweaponbasename(param_04) == "iw7_cutie_zm" || getweaponbasename(param_04) == "iw7_cutier_zm" && scripts\common\utility::istrue(self.affectedbyfovdamage))
	{
		self playsound("bullet_atomizer_impact_npc");
		if(isdefined(self.var_2C09))
		{
			self.var_2C09 thread lib_0CBC::func_CEF1();
			self.var_2C09 hide(1);
		}

		self.affectedbyfovdamage = undefined;
	}

	if((scripts\common\utility::func_9D74(param_03) && getweaponbasename(param_04) == "iw7_atomizer_mp" || scripts\common\utility::istrue(self.atomize_me)) || param_03 == "MOD_UNKNOWN" && getweaponbasename(param_04) == "iw7_harpoon3_zm")
	{
		if(!var_16 && !var_13 && !var_14 && !var_15 && !scripts\cp\_utility::agentisfnfimmune())
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
		if(isdefined(param_04) && param_04 == "iw7_knife_zm_cleaver")
		{
			if(iscrog(self))
			{
				if(isdefined(level.crogs_cleaved))
				{
					level.crogs_cleaved++;
				}

				level thread scripts\cp\_utility::add_to_notify_queue("cleaver_kill",self,self.origin,param_04,param_03);
			}
			else
			{
				level thread scripts\cp\_utility::add_to_notify_queue("cleaver_kill_zombie");
			}
		}

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

	if(isdefined(self.var_BE74) && !var_16)
	{
		if(isdefined(level.var_4297))
		{
			var_17 = level [[ level.var_4297 ]](self);
		}
		else
		{
			var_17 = undefined;
		}

		if(isdefined(var_17))
		{
			if(isdefined(level.var_4ADE))
			{
				thread lib_0CBC::delayminiufocollection(self.origin,param_04,var_17);
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
	lib_0CBC::func_D97C(param_00,param_01,self,param_06,param_03,param_04);
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
	if(isdefined(param_01.var_222))
	{
		param_01.var_222 scripts\cp\_utility::func_316C("kill_event_buffered",param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,self.agent_type);
	}
	else if(isplayer(param_01))
	{
		param_01 scripts\cp\_utility::func_316C("kill_event_buffered",param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,self.agent_type);
	}

	scripts\cp\_agent_utils::func_4DDB();
	if(isdefined(level.cp_rave_zombie_death_pos_record_func))
	{
		[[ level.cp_rave_zombie_death_pos_record_func ]](self.origin);
	}

	level thread scripts\cp\_utility::add_to_notify_queue("zombie_killed",self.origin,param_04,param_03,param_01);
}

//Function Number: 3
should_reset_scriptable_states_on_death()
{
	if(isdefined(self.agent_type))
	{
		switch(self.agent_type)
		{
			case "crab_brute":
			case "crab_mini":
			case "crab_boss":
				return 0;
		}
	}
	else
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
callback_townzombieplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(!scripts\cp\zombies\zombie_damage::func_100AA(param_02,param_01,param_05,param_03))
	{
		return;
	}

	if(damage_from_escort_vehicle(param_00,param_04))
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
	var_10 = scripts\cp\_utility::func_9BFB();
	var_11 = scripts\cp\_utility::has_zombie_perk("perk_machine_boom");
	var_12 = scripts\cp\_utility::has_zombie_perk("perk_machine_change");
	var_13 = isdefined(param_01);
	var_14 = var_13 && isdefined(param_01.agent_type) && param_01.agent_type == "generic_zombie";
	var_15 = var_13 && param_01 == self;
	var_16 = (var_15 || !var_13) && param_04 == "MOD_SUICIDE";
	if(var_13)
	{
		if(param_01 == self)
		{
			if(var_0D)
			{
				var_17 = self getstance();
				if(var_11)
				{
					param_02 = 0;
				}
				else if(isdefined(self.has_fortified_passive) && self.has_fortified_passive && self method_81BE() || (var_17 == "crouch" || var_17 == "prone") && self isonground())
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
			if(var_10)
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
			if(param_04 != "MOD_EXPLOSIVE" && var_0C scripts\cp\_utility::func_9BA0("burned_out"))
			{
				if(!scripts\common\utility::istrue(param_01.var_9B81))
				{
					var_0C scripts\cp\_utility::func_C151("burned_out");
					param_01 thread scripts\cp\_utility::func_4D0D(param_01,var_0C,3,int(param_01.maxhealth + 1000),param_04,"incendiary_ammo_mp",undefined,"burning");
					param_01.faf_burned_out = 1;
				}
			}

			var_18 = gettime();
			if(!isdefined(self.var_A92D) || var_18 - self.var_A92D > 20)
			{
				self.var_A92D = var_18;
			}
			else
			{
				return;
			}

			if(scripts\common\utility::istrue(self.back_shield))
			{
				var_19 = (0,0,0);
				if(isdefined(param_07))
				{
					var_19 = param_07;
					var_1A = anglestoforward(self.angles) * -1;
					var_1B = vectordot(var_1A,var_19);
					if(var_1B < -0.25)
					{
						return;
					}
				}
			}

			var_1C = 500;
			if(getdvarint("zom_damage_shield_duration") != 0)
			{
				var_1C = getdvarint("zom_damage_shield_duration");
			}

			if(isdefined(param_01.var_A8A2[self.var_134FD]))
			{
				var_1D = param_01.var_A8A2[self.var_134FD];
				if(var_1D + var_1C > gettime())
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
			var_17 = self getstance();
			if(var_11)
			{
				param_02 = 0;
			}
			else if(isdefined(self.has_fortified_passive) && self.has_fortified_passive && self method_81BE() || (var_17 == "crouch" || var_17 == "prone") && self isonground())
			{
				param_02 = 0;
			}
			else if(!var_10 || param_01 == self && param_08 == "none")
			{
				param_02 = 0;
			}
		}
	}
	else if(var_11 && param_04 == "MOD_SUICIDE")
	{
		if(param_05 == "frag_grenade_zm" || param_05 == "cluster_grenade_zm")
		{
			param_02 = 0;
		}
	}
	else
	{
		var_17 = self getstance();
		if(isdefined(self.has_fortified_passive) && self.has_fortified_passive && self method_81BE() || (var_17 == "crouch" || var_17 == "prone") && self isonground())
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

	var_1E = 0;
	if(var_13 && param_01 scripts\cp\_utility::func_9D20() && scripts\common\utility::istrue(self.var_AD2D))
	{
		if(self.health - param_02 < 1)
		{
			param_02 = self.health - 1;
		}
	}

	if(var_14 || var_15 && !var_16)
	{
		param_02 = int(param_02 * var_0C scripts\cp\_utility::func_7E5C());
	}

	if(isdefined(self.var_AD2C))
	{
		param_02 = int(max(self.maxhealth / 2.75,param_02));
	}

	if(var_0C scripts\cp\_utility::func_9BA0("secret_service") && isalive(param_01))
	{
		var_1F = 0;
		if(isdefined(param_01.agent_type) && param_01.agent_type == "crab_mini" || param_01.agent_type == "crab_brute" || param_01 scripts\cp\_utility::agentisfnfimmune())
		{
			var_1F = 0;
		}
		else if(isplayer(var_0C) && isplayer(param_01))
		{
			var_1F = 0;
		}
		else
		{
			var_1F = 1;
		}

		if(var_1F)
		{
			param_01 thread scripts\cp\zombies\craftables\_revocator::func_1299C(var_0C);
			var_0C scripts\cp\_utility::func_C151("secret_service");
		}
	}

	param_02 = int(param_02);
	if(!var_0F || var_10)
	{
		scripts\cp\zombies\zombie_damage::func_6CE1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_1E,param_0A,param_0B);
		thread scripts\cp\_utility::add_to_notify_queue("player_damaged");
	}

	lib_0A54::func_12E04("personal","damage_taken",param_02);
	if(param_02 <= 0)
	{
		return;
	}

	thread scripts\cp\_utility::func_D222();
	thread scripts\cp\zombies\zombie_damage::func_CDBE(self);
	self playlocalsound("zmb_player_impact_hit");
	thread scripts\cp\_utility::func_D220();
	if(var_12)
	{
		self notify("change_chews_damage",param_02,self.health);
	}

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

//Function Number: 5
damage_from_escort_vehicle(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_00.var_336) && param_00.var_336 == "bomb_vehicle" && isdefined(param_01) && param_01 == "MOD_CRUSH")
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
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

//Function Number: 7
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

//Function Number: 8
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

//Function Number: 9
flying_ghost_body(param_00,param_01,param_02)
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
				var_07 = level._effect["chi_ghost_hit_blue"];
				break;

			case "dragon":
				var_07 = level._effect["chi_ghost_hit_yellow"];
				break;

			case "snake":
				var_07 = level._effect["chi_ghost_hit_green"];
				break;

			case "tiger":
				var_07 = level._effect["chi_ghost_hit_red"];
				break;

			default:
				break;
		}
	}

	playfx(var_07,var_06);
}

//Function Number: 10
crog_processdamagefeedback(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!scripts\common\utility::func_9D74(param_04))
	{
		if(scripts\cp\_utility::func_9CEB(param_00,param_05))
		{
			return;
		}

		var_0B = gettime();
		if(isdefined(param_01.var_BF85) && param_01.var_BF85 > var_0B)
		{
			return;
		}
		else
		{
			param_01.var_BF85 = var_0B + 250;
		}
	}

	var_0C = "standard";
	var_0D = undefined;
	if(param_0A.health <= param_02)
	{
		var_0D = 1;
	}

	var_0E = scripts\cp\_utility::func_9E27(param_05,param_08,param_04,param_01);
	if(var_0E)
	{
		var_0C = "hitcritical";
	}

	var_0F = scripts\common\utility::func_9D74(param_04);
	var_10 = var_0E && param_01 scripts\cp\_utility::func_9BA0("sharp_shooter_upgrade");
	var_11 = var_0F && param_01 scripts\cp\_utility::func_9BA0("bonus_damage_on_last_bullets");
	var_12 = var_0F && param_01 scripts\cp\_utility::func_9BA0("damage_booster_upgrade");
	var_13 = scripts\common\utility::istrue(param_01.inlaststand);
	var_14 = !var_13 && var_0E && var_0F && param_01 scripts\cp\_utility::func_9BA0("headshot_explosion");
	var_15 = !scripts\cp\_utility::func_9F19(param_0A) || isagent(param_0A) && param_02 >= param_0A.health;
	var_16 = param_04 == "MOD_EXPLOSIVE_BULLET" || param_04 == "MOD_EXPLOSIVE" || param_04 == "MOD_GRENADE_SPLASH" || param_04 == "MOD_PROJECTILE" || param_04 == "MOD_PROJECTILE_SPLASH";
	var_17 = param_04 == "MOD_MELEE";
	if(scripts\common\utility::istrue(param_0A.armor_hit))
	{
		var_0C = "hitalienarmor";
	}
	else if(var_10 || var_11 || var_12 || var_14)
	{
		var_0C = "card_boosted";
	}
	else if(isplayer(param_01) && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_boom") && var_16)
	{
		var_0C = "high_damage";
	}
	else if(isplayer(param_01) && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_smack") && var_17)
	{
		var_0C = "high_damage";
	}
	else if(isplayer(param_01) && param_01 scripts\cp\_utility::has_zombie_perk("perk_machine_rat_a_tat") && var_0F)
	{
		var_0C = "high_damage";
	}
	else if(isplayer(param_01) && scripts\common\utility::istrue(param_01.deadeye_charge) && var_0F)
	{
		var_0C = "special_weapon";
	}

	if(isdefined(param_01))
	{
		if(isdefined(param_01.var_222))
		{
			param_01.var_222 thread scripts\cp\_damage::func_12E84(var_0C,var_0D,param_02,param_0A.var_E54C);
		}
		else
		{
			param_01 thread scripts\cp\_damage::func_12E84(var_0C,var_0D,param_02,param_0A.var_E54C);
		}
	}

	if(scripts\common\utility::istrue(self.armor_hit))
	{
		self.armor_hit = 0;
	}
}

//Function Number: 11
change_chews_damage_over_time(param_00,param_01,param_02,param_03)
{
	var_04 = param_02 * param_02;
	var_05 = param_00.origin;
	var_06 = sortbydistance(level.spawned_enemies,param_01.origin);
	var_07 = 0;
	foreach(var_09 in var_06)
	{
		if(var_09 == param_00)
		{
			continue;
		}

		if(isdefined(var_09.chew_effect_time) && var_09.chew_effect_time == gettime())
		{
			continue;
		}

		if(isdefined(var_09.agent_type) && var_09.agent_type != "generic_zombie")
		{
			continue;
		}

		if(distancesquared(var_05,var_09.origin) < var_04)
		{
			var_09.chew_effect_time = gettime();
			var_07++;
			switch(param_03)
			{
				case "frozen":
					var_09 thread change_chews_frozen_damage(param_01,var_05);
					if(var_07 >= 6)
					{
						return;
					}
					break;

				case "burning":
					var_09 thread change_chews_fire_damage(param_01,var_05);
					if(var_07 >= 8)
					{
						return;
					}
					break;

				case "shocked":
					var_09 thread change_chews_shock_damage(param_01,var_05);
					if(var_07 >= 10)
					{
						return;
					}
					break;

				case "explode":
					var_09 thread change_chews_explosive_damage(param_01,var_05);
					if(var_07 >= 5)
					{
						return;
					}
					break;

				default:
					break;
			}

			wait(0.1);
			continue;
		}

		wait(0.1);
	}
}

//Function Number: 12
change_chews_frozen_damage(param_00,param_01)
{
	self endon("death");
	self.var_9E0C = 1;
	var_02 = self.health;
	self.health = 1;
	wait(10);
	self.var_9E0C = undefined;
	if(var_02 > 0)
	{
		self.health = var_02;
	}
}

//Function Number: 13
change_chews_fire_damage(param_00,param_01)
{
	self endon("death");
	if(isalive(self) && !scripts\common\utility::istrue(self.var_B36E))
	{
		self.var_B36E = 1;
		thread scripts\cp\_utility::func_4D0D(self,param_00,5,1900,undefined,"iw7_fwoosh_zm",0,"burning","fwoosh_kill");
	}
}

//Function Number: 14
change_chews_shock_damage(param_00,param_01)
{
	self endon("death");
	thread lib_0D5D::func_13E63(2,param_00);
}

//Function Number: 15
change_chews_explosive_damage(param_00,param_01)
{
	self dodamage(self.health + 1000,param_01,param_00,param_00,"MOD_EXPLOSIVE","iw7_change_chews_zm");
}

//Function Number: 16
iscrog(param_00)
{
	return isdefined(param_00.agent_type) && param_00.agent_type == "crab_brute" || param_00.agent_type == "crab_mini";
}