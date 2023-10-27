/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\weapons\_zombie_dlc3_melee.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 149
 * Decompile Time: 2637 ms
 * Timestamp: 10/27/2023 3:13:09 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_611["zmb_blood_blast"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_med_trap_gib");
	level.var_611["zmb_bat_long_hit_crit_blood"] = loadfx("vfx/blood/zmb_bat_long_hit_crit_blood");
	level.var_611["zmb_raven_sword_barb_burst"] = loadfx("vfx/zombie/zmb_sword_barb_burst");
	level.var_611["zmb_giestkraft_impact"] = loadfx("vfx/zombie/zmb_giestkraft_impact");
	if(!isdefined(level.var_6DF9))
	{
		level.var_6DF9 = [];
	}

	thread sword_init();
	thread scale_dlc3_melee_damage();
}

//Function Number: 2
scale_dlc3_melee_damage()
{
	while(!isdefined(level.var_A50) || !isdefined(level.var_A50["zombie_generic"]))
	{
		wait 0.05;
	}

	level.swordcleavedamages = [0.9,0.6,0.5,0.4];
	var_00 = 1;
	for(;;)
	{
		var_01 = maps/mp/gametypes/zombies::func_1E59(lib_0547::func_A51("zombie_generic"),var_00);
		var_02 = var_01;
		if(isdefined(level.zmb_global_zombie_health_multiplier) && isdefined(level.zmb_global_zombie_health_multiplier_wave_start) && level.var_A980 >= level.zmb_global_zombie_health_multiplier_wave_start)
		{
			var_02 = int(var_01 * level.zmb_global_zombie_health_multiplier);
		}

		level.sworddamage = max(1,var_02 * 0.26);
		level.swordcleavedamagebase = var_02;
		level.swordthrowimpactdamage = var_02 * 1;
		level waittill("waveupdate");
		var_00 = level.var_A980;
	}
}

//Function Number: 3
setup_melee_weapon_ownership(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.hasfunc = param_00;
	var_03.gainedfunc = param_01;
	var_03.lostfunc = param_02;
	thread maps\mp\_utility::func_6F74(::watch_melee_weapon_ownership,var_03);
}

//Function Number: 4
watch_melee_weapon_ownership(param_00)
{
	self endon("disconnect");
	var_01 = 0;
	for(;;)
	{
		var_02 = [[ param_00.hasfunc ]]();
		if(var_01 != var_02)
		{
			if(var_02)
			{
				thread [[ param_00.gainedfunc ]]();
			}
			else
			{
				thread [[ param_00.lostfunc ]]();
			}

			var_01 = var_02;
		}

		common_scripts\utility::knock_off_battery("weapon_taken","weapon_given");
	}
}

//Function Number: 5
setup_melee_abilityinfo(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.25;
	}

	var_05 = spawnstruct();
	var_05.var_953E = param_00;
	var_05.firedelay = param_01;
	var_05.weaponlostendon = param_02;
	var_05.firingfunction = param_03;
	var_05.isheavymelee = param_04;
	return var_05;
}

//Function Number: 6
setup_normal_melee_abilityinfo(param_00,param_01,param_02,param_03)
{
	return setup_melee_abilityinfo(param_00,param_01,param_02,param_03,0);
}

//Function Number: 7
setup_heavy_melee_abilityinfo(param_00,param_01,param_02,param_03)
{
	return setup_melee_abilityinfo(param_00,param_01,param_02,param_03,1);
}

//Function Number: 8
run_melee_ability(param_00)
{
	self endon("disconnect");
	if(isdefined(param_00.weaponlostendon))
	{
		self endon(param_00.weaponlostendon);
	}

	for(;;)
	{
		self waittill("melee_fired",var_01);
		if(issubstr(var_01,param_00.var_953E) && param_00.isheavymelee == self method_8661())
		{
			if(isdefined(param_00.firedelay))
			{
				wait(param_00.firedelay);
			}

			if(melee_ability_in_melee_state(param_00))
			{
				thread [[ param_00.firingfunction ]](param_00);
				if(isdefined(param_00.afterfiringdelay))
				{
					wait(param_00.afterfiringdelay);
					continue;
				}

				if(param_00.isheavymelee)
				{
					while(self method_8661())
					{
						wait 0.05;
					}

					continue;
				}

				while(self method_8128())
				{
					wait 0.05;
				}
			}
		}
	}
}

//Function Number: 9
melee_ability_in_melee_state(param_00)
{
	if(param_00.isheavymelee)
	{
		return self method_8661();
	}

	return self method_8128();
}

//Function Number: 10
bayo_charge_watcher_zm(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self notify("bayoCharge_watcher_zm");
	self endon("bayoCharge_watcher_zm");
	for(;;)
	{
		self waittill("sprint_melee_charge_begin");
		var_03 = self getcurrentweapon();
		if(!issubstr(var_03,param_00))
		{
			continue;
		}

		togglemarathonability(0);
		if(isdefined(param_01))
		{
			self thread [[ param_01 ]]();
		}

		thread bayochargeendingtracking(param_02);
		thread bayochargehittracking(param_02);
	}
}

//Function Number: 11
bayochargecleanup(param_00,param_01)
{
	togglemarathonability(1);
	if(isdefined(param_00))
	{
		self thread [[ param_00 ]](param_01);
	}

	self notify("bayoCleanup");
}

//Function Number: 12
bayochargeendingtracking(param_00)
{
	self endon("disconnect");
	self endon("bayoCleanup");
	var_01 = common_scripts\utility::func_A715("death","sprint_melee_charge_end");
	waittillframeend;
	thread bayochargecleanup(param_00,var_01);
}

//Function Number: 13
bayochargehittracking(param_00)
{
	self endon("disconnect");
	self endon("bayoCleanup");
	self waittill("sprint_melee_charge_attack");
	thread bayochargecleanup(param_00,"sprint_melee_charge_attack");
}

//Function Number: 14
togglemarathonability(param_00)
{
	if(!lib_056A::func_4B7E("runperk"))
	{
		return;
	}

	if(param_00)
	{
		maps\mp\_utility::func_47A2("specialty_marathon");
		return;
	}

	maps\mp\_utility::func_735("specialty_marathon");
}

//Function Number: 15
sword_init()
{
	level.var_62B3["zom_dlc3_5_zm"] = ::sword_modify_damage;
	level.zombiemeleeweapon["zom_dlc3_5_zm"] = 1;
	level.var_2FE9["zom_dlc3_5_zm"] = 1;
	level.var_4D3D["zom_dlc3_5_zm"] = 1;
	level.zerorewardweapons["zom_dlc3_5_zm"] = 1;
	level.nolevelup["zom_dlc3_5_zm"] = 1;
	level.meleeaoeweapons["zom_dlc3_5_aoe_zm"] = 1;
	level.var_2FE9["zom_dlc3_5_aoe_zm"] = 1;
	level.var_4D3D["zom_dlc3_5_aoe_zm"] = 1;
	level.zerorewardweapons["zom_dlc3_5_aoe_zm"] = 1;
	level.nopainweapons["zom_dlc3_5_aoe_zm"] = 1;
	level.nolevelup["zom_dlc3_5_aoe_zm"] = 1;
	level.meleeaoeweapons["zom_dlc3_5_throw_zm"] = 1;
	level.var_2FE9["zom_dlc3_5_throw_zm"] = 1;
	level.var_4D3D["zom_dlc3_5_throw_zm"] = 1;
	level.zerorewardweapons["zom_dlc3_5_throw_zm"] = 1;
	level.meleeaoeweapons["zom_dlc3_5_bomb_zm"] = 1;
	level.var_2FE9["zom_dlc3_5_bomb_zm"] = 1;
	level.var_4D3D["zom_dlc3_5_bomb_zm"] = 1;
	level.zerorewardweapons["zom_dlc3_5_bomb_zm"] = 1;
	level.nodamagescalingweapons["zom_dlc3_5_bomb_zm"] = 1;
	level.var_611["zmb_barb_victim_drain_armor"] = loadfx("vfx/gameplay/mp/zombie/zmb_melee_drain_player");
	level.var_611["zmb_barb_victim_geist_drain"] = loadfx("vfx/zombie/dark_energy_burst");
	level.var_611["zmb_barb_geist_bomb_vesting"] = loadfx("vfx/zombie/dark_energy_burst_flare");
	level.var_611["zmb_barb_geist_bomb_ready"] = loadfx("vfx/zombie/zmb_sword_giestbomb");
	level.var_611["zmb_barb_sword_activate"] = loadfx("vfx/zombie/zmb_combined_sword_activate");
	level.var_611["zmb_barb_sword_activate_wv"] = loadfx("vfx/zombie/zmb_combined_sword_activate_wv");
	level.var_611["zmb_barb_sword_stun"] = loadfx("vfx/zombie/zmb_giestkraft_impact");
	level.var_611["zmb_barb_sword_stun_secondary"] = loadfx("vfx/zombie/zmb_sword_stunbomb_impact");
	level.var_611["zmb_sword_zmb_throw"] = loadfx("vfx/trail/zmb_sword_zmb_throw");
	level.var_611["zmb_sword_stunbomb_aoe"] = loadfx("vfx/zombie/zmb_sword_stunbomb_aoe");
	level.var_611["zmb_giestbomb_radius"] = loadfx("vfx/zombie/zmb_giestbomb_radius");
	level.var_611["zmb_sword_point_purchase"] = loadfx("vfx/zombie/zmb_giestkraft_impact");
	level.var_611["zmb_giestbomb_priming"] = loadfx("vfx/zombie/zmb_giestbomb_prime");
	level.var_611["zmb_giestbomb_detonation"] = loadfx("vfx/zombie/zmb_giestbomb_exp_10s");
	if(!isdefined(level.var_611["zmb_delivery_radius"]))
	{
		level.var_611["zmb_delivery_radius"] = loadfx("vfx/zombie/zmb_giestbomb_radius");
	}

	if(!isdefined(level.var_611["zmb_delivery_radius_128"]))
	{
		level.var_611["zmb_delivery_radius_128"] = loadfx("vfx/zombie/zmb_giestbomb_radius_128");
	}

	if(!isdefined(level.var_611["zmb_delivery_radius_256"]))
	{
		level.var_611["zmb_delivery_radius_256"] = loadfx("vfx/zombie/zmb_giestbomb_radius_256");
	}

	var_00 = [];
	var_00[16]["noGib"] = 1;
	var_01 = (42.816,5.533,0);
	var_02 = length(var_01);
	var_03["hit_worldmodel_anim"] = "va_melee_barb_swd_base_stun_hit_world";
	var_03["hit_zombie_action"] = "energy_hold_start";
	var_03["hit_zombie_snd"] = "zmb_sword_melee_hit";
	var_03["fatal_worldmodel_anim"] = "va_melee_barb_swd_base_stun_hit_world";
	var_03["fatal_zombie_action"] = "energy_hold_start";
	var_03["dismemberment_override"] = var_00;
	var_03["fatal_zombie_pos"] = var_01;
	var_03["fatal_zombie_dist"] = var_02;
	var_03["fatal_zombie_snd"] = "zmb_sword_melee_hit";
	var_03["invalid_pair_distance"] = 60;
	var_03["hit_zombie_blend_duration"] = 3;
	level.var_6DF9["heavy"]["zom_dlc3_5_zm"] = var_03;
	lib_0547::func_7BA9(::sword_onenemykilled);
	lib_054D::func_7BC6(::sword_stun_on_zombie_damaged);
	lib_0547::func_7BD0("barb_sword_stun",::sword_stun_run,::sword_stun_interrupt,5.5,::sword_stun_end);
	lib_0547::func_7BD0("barb_sword_stun_secondary",::sword_secondary_stun_run,::sword_secondary_stun_interrupt,3.875,::sword_secondary_stun_end);
	lib_0547::func_7BD0("barb_sword_throw",::sword_throw_run,::sword_throw_interrupt,5.75,::sword_throw_end);
	setup_melee_weapon_ownership(::has_sword,::sword_gained,::sword_lost);
}

//Function Number: 16
has_sword()
{
	var_00 = self method_82D5();
	return issubstr(var_00,"zom_dlc3_5_zm");
}

//Function Number: 17
sword_gained()
{
	thread sword_think();
}

//Function Number: 18
sword_lost()
{
	self.laststandlastmomentcallback = undefined;
	thread sword_cleanup_empower();
	self notify("sword_lost");
}

//Function Number: 19
sword_modify_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!param_01 method_8661())
	{
		param_00.ignorethiszerodamage = 1;
		return 0;
	}

	return level.sworddamage;
}

//Function Number: 20
sword_think()
{
	var_00 = self;
	if(!isdefined(var_00.swordinvestment))
	{
		var_00.swordinvestment = spawnstruct();
	}

	var_01 = setup_normal_melee_abilityinfo("zom_dlc3_5_zm",0.45,"sword_lost",::sword_melee_cone);
	var_01.afterfiringdelay = 0.05;
	thread run_melee_ability(var_01);
	if(common_scripts\utility::func_562E(1))
	{
		self.laststandlastmomentcallback = ::geist_bomb_revive_last_chance;
	}

	thread sword_geist_bomb_detonate_think();
	thread sword_handle_empower();
}

//Function Number: 21
sword_melee_cone(param_00)
{
	var_01 = lib_0586::zombies_hit_by_melee_cone(350,100);
	var_01 = function_01AC(var_01,self.var_116);
	var_02 = [];
	var_03 = [];
	foreach(var_05 in var_01)
	{
		var_06 = sword_can_throw(var_05);
		if(var_05 maps/mp/agents/humanoid/_humanoid_util::func_56BC())
		{
			var_06 = 0;
		}

		if(var_06)
		{
			var_06 = var_06 & is_sword_stunned_zombie(var_05);
			if(common_scripts\utility::func_562E(1))
			{
				var_06 = var_06 | is_sword_secondary_stunned_zombie(var_05);
			}
		}

		if(var_06)
		{
			var_02[var_02.size] = var_05;
			continue;
		}

		var_03[var_03.size] = var_05;
	}

	var_08 = var_03.size;
	for(var_09 = 0;var_09 < var_03.size;var_09++)
	{
		var_0A = var_09;
		thread delayed_sword_hit(var_03[var_09],var_0A,0);
	}

	for(var_09 = 0;var_09 < var_02.size;var_09++)
	{
		var_0A = 0;
		thread delayed_sword_hit(var_02[var_09],var_0A,1);
	}

	var_0B = common_scripts\utility::func_44F5("zmb_raven_sword_barb_burst");
	playfx(var_0B,self.var_116 + (0,0,50),anglestoforward(self.var_1D));
	lib_0378::func_8D74("zmb_sword_aoe",self.var_116);
}

//Function Number: 22
is_sword_stunned_zombie(param_00)
{
	return isdefined(param_00.activeswordstunplayers) && param_00.activeswordstunplayers.size > 0;
}

//Function Number: 23
is_sword_secondary_stunned_zombie(param_00)
{
	return isdefined(param_00.activesecondarystuns) && param_00.activesecondarystuns.size > 0;
}

//Function Number: 24
delayed_sword_hit(param_00,param_01,param_02)
{
	var_03 = self;
	var_03 endon("disconnect");
	param_00 endon("death");
	for(var_04 = 0;var_04 < param_01;var_04++)
	{
		wait 0.05;
	}

	if(param_02)
	{
		wait(0);
		var_05 = create_sword_throw_params(var_03);
		param_00.throwingzombie = 1;
		param_00 lib_0547::func_7D1A("barb_sword_throw",[var_05],0.25);
		return;
	}

	var_06 = lib_0547::func_A51(param_00.var_A4B);
	var_07 = common_scripts\utility::func_562E(param_00.scaleshealthbyplayers) || common_scripts\utility::func_562E(var_06.scaleshealthbyplayers);
	var_08 = sword_cleave_get_damage(var_07);
	var_09 = 1;
	if(common_scripts\utility::func_562E(1))
	{
		if(isdefined(var_06) && isdefined(var_06.energyholdpain) && is_sword_stunned_zombie(param_00))
		{
			var_08 = int(var_08 * var_06.energyholdpain);
			param_00 notify("energyHoldPain");
			param_00.energyholdpaindealt = 1;
		}
	}

	if(common_scripts\utility::func_562E(1))
	{
		if(isdefined(var_06) && isdefined(var_06.energyholdkill))
		{
			var_08 = param_00.var_FB + 10;
		}
	}

	lib_0378::func_8D74("zmb_sword_melee_hit_delayed",param_00.var_116);
	param_00 dodamage(var_08,var_03 geteye(),var_03,var_03,"MOD_MELEE","zom_dlc3_5_aoe_zm","none");
	playfxontag(level.var_611["zmb_giestkraft_impact"],param_00,"J_Spine4");
	if(common_scripts\utility::func_562E(0))
	{
		if(!common_scripts\utility::func_562E(1) || level.var_744A.size <= 0)
		{
			if(isdefined(param_00.var_A4B))
			{
				if(isdefined(var_06) && common_scripts\utility::func_562E(var_06.knockbybladebarbarossa))
				{
					lib_0547::func_7D1B(var_03,param_00,"far");
					return;
				}

				return;
			}

			return;
		}
	}
}

//Function Number: 25
sword_cleave_get_damage(param_00)
{
	var_01 = level.var_744A.size;
	var_01 = int(clamp(var_01,1,4));
	if(!common_scripts\utility::func_562E(1) || common_scripts\utility::func_562E(param_00))
	{
		var_01 = 1;
	}

	var_02 = level.swordcleavedamages[var_01 - 1];
	return level.swordcleavedamagebase * var_02;
}

//Function Number: 26
is_sword_weapon(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "zom_dlc3_5_bomb_zm":
		case "zom_dlc3_5_throw_zm":
		case "zom_dlc3_5_aoe_zm":
		case "zom_dlc3_5_zm":
			return 1;
	}

	return 0;
}

//Function Number: 27
sword_onenemykilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = self;
	if(!function_01EF(var_09))
	{
		return;
	}

	if(is_sword_weapon(param_04))
	{
		var_09 thread playzombiekilledbeamexplodefx();
		if(param_04 != "zom_dlc3_5_bomb_zm")
		{
			if(1)
			{
				var_09 sword_empower_handle_zombie_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
			}
		}
	}

	if(isdefined(param_01) && isplayer(param_01) && param_01 has_sword())
	{
		if(common_scripts\utility::func_562E(self.var_103))
		{
			var_09 thread sword_on_heavy_melee_kill(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
		}
	}

	var_09 sword_stun_handle_zombie_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	var_09 sword_secondary_stun_handle_zombie_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	var_09 sword_throw_handle_zombie_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 28
playzombiekilledbeamexplodefx()
{
	var_00 = self gettagorigin("J_MainRoot");
	if(!isdefined(var_00))
	{
		var_00 = self.var_116;
	}

	playfx(common_scripts\utility::func_44F5("zmb_blood_blast"),var_00);
}

//Function Number: 29
sword_stun_on_zombie_damaged(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = self;
	if(issubstr(param_05,"zom_dlc3_5_zm") && param_01 method_8661() && !common_scripts\utility::func_562E(var_0B.var_103))
	{
		param_01 attempt_sword_stun(var_0B);
	}
}

//Function Number: 30
attempt_sword_stun(param_00)
{
	var_01 = self;
	if(!isdefined(param_00.var_A4B))
	{
		return;
	}

	if(!sword_can_stun(param_00))
	{
		return;
	}

	var_02 = sword_get_player_num(var_01);
	if(common_scripts\utility::func_562E(1))
	{
		if(param_00.var_A4B == "zombie_heavy")
		{
			param_00 thread lib_0567::zombie_heavy_set_grudge(var_01);
		}
	}

	param_00 notify("sword_stun_begin_" + var_02);
	if(!isdefined(param_00.activeswordstunplayers))
	{
		param_00.activeswordstunplayers = [];
	}

	param_00.lastswordstunplayer = var_01;
	if(param_00.activeswordstunplayers.size == 0)
	{
		param_00 thread play_shock_fx("zmb_barb_sword_stun","J_Spine4",undefined,1,"sword_stun_shock","all_sword_stuns_expired");
		param_00 lib_0547::add_zombie_stun("barb_sword",level);
		param_00 lib_0378::func_8D74("dlc3_barbarosa_sword_stun","stun_on");
		var_03 = [param_00,"all_sword_stuns_expired"];
		var_04 = create_sword_stun_params(var_03);
		param_00 thread lib_0547::func_7D1A("barb_sword_stun",[var_04],undefined,var_03);
	}
	else
	{
	}

	param_00.activeswordstunplayers[var_02] = var_01;
	level thread sword_stun_handle_expire(param_00,var_01);
}

//Function Number: 31
sword_get_player_num(param_00)
{
	var_01 = param_00 getentitynumber();
	return var_01;
}

//Function Number: 32
sword_stun_handle_expire(param_00,param_01)
{
	var_02 = sword_get_player_num(param_01);
	param_00 endon("death");
	param_00 endon("sword_stun_begin_" + var_02);
	common_scripts\utility::func_A70D(4,param_01,"disconnect");
	level sword_stun_verify_stunners(param_00);
	level thread sword_stun_expire(param_00,var_02);
}

//Function Number: 33
play_shock_fx(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self notify(param_04);
	if(isdefined(param_02))
	{
		param_02 endon("disconnect");
	}

	self endon("death");
	self endon(param_04);
	self endon(param_05);
	for(;;)
	{
		var_06 = gettime() / 1000;
		if(isdefined(self.recentshockfxtime) && var_06 - self.recentshockfxtime < param_03)
		{
			wait(param_03 - var_06 - self.recentshockfxtime);
		}

		playfxontag(common_scripts\utility::func_44F5(param_00),self,param_01);
		self.recentshockfxtime = var_06;
		wait(param_03);
	}
}

//Function Number: 34
sword_stun_expire(param_00,param_01)
{
	param_00.activeswordstunplayers[param_01] = undefined;
	param_00 lib_0378::func_8D74("dlc3_barbarosa_sword_stun","stun_off");
	param_00.lastswordstunplayer = undefined;
	if(param_00.activeswordstunplayers.size == 0)
	{
		param_00 lib_0547::remove_zombie_stun("barb_sword");
		param_00 notify("all_sword_stuns_expired");
	}
}

//Function Number: 35
sword_stun_verify_stunners(param_00)
{
	foreach(var_03, var_02 in param_00.activeswordstunplayers)
	{
		if(!isdefined(var_02) || !isplayer(var_02))
		{
			param_00.activeswordstunplayers[var_03] = undefined;
		}
	}
}

//Function Number: 36
sword_stun_handle_zombie_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = self;
	if(isdefined(var_09.activeswordstunplayers))
	{
		level sword_stun_verify_stunners(var_09);
		var_0A = var_09.activeswordstunplayers;
		foreach(var_0D, var_0C in var_0A)
		{
			level thread sword_stun_expire(var_09,var_0D);
		}
	}

	thread sword_stun_secondary_aoe_trigger_cleanup(var_09);
}

//Function Number: 37
create_sword_stun_params(param_00)
{
	var_01 = spawnstruct();
	var_01.endon_pairs = param_00;
	return var_01;
}

//Function Number: 38
sword_stun_run(param_00)
{
	var_01 = self;
	var_02 = common_scripts\utility::func_F82(var_01.activeswordstunplayers);
	var_01 scragentsetscripted(1);
	var_01 maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"barb_sword_stun");
	var_01 lib_0542::set_invalid_melee_pairing_reason("barb_sword_stun",1);
	if(common_scripts\utility::func_562E(1))
	{
		thread sword_stun_secondary_aoe_trigger(var_01);
	}

	sword_stun_intro(param_00);
	sword_stun_loop(param_00);
	if(common_scripts\utility::func_562E(1) && isdefined(var_02) && isalive(var_02))
	{
		if(sword_can_stun_kill(var_01))
		{
			var_01 dodamage(var_01.var_FB + 10,var_02 geteye(),var_02,var_02,"MOD_MELEE","zom_dlc3_5_aoe_zm","none");
		}
	}

	sword_stun_recover(param_00);
}

//Function Number: 39
sword_stun_intro(param_00)
{
	var_01 = self;
	var_02 = undefined;
	var_03 = maps/mp/agents/_scripted_agent_anim_util::func_434D("energy_hold_start");
	var_04 = self method_83DB(var_03);
	if(isdefined(var_02))
	{
		var_05 = var_02;
	}
	else
	{
		var_05 = randomint(var_05);
	}

	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",self.var_1D);
	childthread maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_03,var_05,1,"scripted_anim");
	var_01 common_scripts\utility::knock_off_battery("Notetrack_Timeout","energyHoldPain");
}

//Function Number: 40
sword_stun_loop_pain_anim(param_00)
{
	var_01 = self;
	var_02 = undefined;
	var_03 = var_01 maps/mp/agents/_scripted_agent_anim_util::func_434D("energy_hold_pain");
	var_04 = var_01 method_83DB(var_03);
	if(isdefined(var_02))
	{
		var_05 = var_02;
	}
	else
	{
		var_05 = randomint(var_05);
	}

	var_01 method_839C("anim deltas");
	var_01 scragentsetorientmode("face angle abs",self.var_1D);
	var_06 = var_01 method_83D8(var_03,var_05);
	var_07 = getanimlength(var_06);
	var_01 method_83D7(var_03,var_05,1);
	var_01 maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_03,var_05,1,"scripted_anim");
}

//Function Number: 41
sword_stun_loop_anim(param_00)
{
	var_01 = self;
	var_02 = undefined;
	var_03 = var_01 maps/mp/agents/_scripted_agent_anim_util::func_434D("energy_hold_loop");
	var_04 = var_01 method_83DB(var_03);
	if(isdefined(var_02))
	{
		var_05 = var_02;
	}
	else
	{
		var_05 = randomint(var_05);
	}

	var_01 method_839C("anim deltas");
	var_01 scragentsetorientmode("face angle abs",self.var_1D);
	var_06 = var_01 method_83D8(var_03,var_05);
	var_07 = getanimlength(var_06);
	var_01 method_83D7(var_03,var_05,1);
	var_01 childthread maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_03,var_05,1,"scripted_anim");
	var_01 common_scripts\utility::knock_off_battery("Notetrack_Timeout","energyHoldPain");
}

//Function Number: 42
sword_stun_loop(param_00)
{
	var_01 = self;
	var_01 endon("all_sword_stuns_expired");
	while(var_01.activeswordstunplayers.size > 0)
	{
		if(common_scripts\utility::func_562E(var_01.energyholdpaindealt))
		{
			var_01 sword_stun_loop_pain_anim(param_00);
			var_01.energyholdpaindealt = undefined;
			continue;
		}

		var_01 sword_stun_loop_anim(param_00);
	}
}

//Function Number: 43
sword_stun_recover(param_00)
{
	var_01 = undefined;
	var_02 = maps/mp/agents/_scripted_agent_anim_util::func_434D("energy_hold_end");
	var_03 = self method_83DB(var_02);
	if(isdefined(var_01))
	{
		var_04 = var_01;
	}
	else
	{
		var_04 = randomint(var_04);
	}

	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",self.var_1D);
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_02,var_04,1,"stun_anim");
}

//Function Number: 44
sword_stun_interrupt(param_00)
{
	var_01 = self;
	if(var_01.activeswordstunplayers.size > 0)
	{
		param_00.requeued = 1;
		var_01 thread lib_0547::func_7D1A("barb_sword_stun",[param_00],undefined,param_00.endon_pairs);
	}
}

//Function Number: 45
sword_stun_end(param_00)
{
	var_01 = self;
	var_01 lib_0542::set_invalid_melee_pairing_reason("barb_sword_stun",0);
	sword_stun_secondary_aoe_trigger_cleanup(var_01);
	var_01 scragentsetscripted(0);
	var_01 maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"barb_sword_stun");
}

//Function Number: 46
sword_stun_secondary_aoe_trigger(param_00)
{
	param_00 endon("death");
	param_00 endon("stun_aoe_cleanup");
	param_00.aoestuntrigger = spawn("trigger_radius",param_00.var_116,0,36,120);
	param_00.aoestunfx = spawnlinkedfx(level.var_611["zmb_sword_stunbomb_aoe"],param_00,"J_spine4");
	triggerfx(param_00.aoestunfx);
	for(;;)
	{
		param_00.aoestuntrigger waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(!function_01EF(var_01))
		{
			continue;
		}

		if(!isalive(var_01))
		{
			continue;
		}

		if(isdefined(var_01.var_A) && var_01.var_A == level.var_746E)
		{
			continue;
		}

		if(var_01 == param_00)
		{
			continue;
		}

		var_01 sword_add_secondary_stun(param_00);
	}
}

//Function Number: 47
sword_stun_secondary_aoe_trigger_cleanup(param_00)
{
	param_00 sword_secondary_stun_cleanup_outgoing_stuns();
	if(isdefined(param_00.aoestuntrigger))
	{
		param_00 notify("stun_aoe_cleanup");
		param_00.aoestunfx delete();
		param_00.aoestunfx = undefined;
		param_00.aoestuntrigger delete();
		param_00.aoestuntrigger = undefined;
	}
}

//Function Number: 48
create_sword_throw_params(param_00)
{
	var_01 = spawnstruct();
	var_01.var_117 = param_00;
	var_01.ownerinitialangles = param_00 geteyeangles();
	return var_01;
}

//Function Number: 49
sword_throw_run(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01.immunetotackling = 1;
	var_01.swordthrowowner = param_00.var_117;
	var_01 scragentsetscripted(1);
	var_01 maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"barb_sword_throw");
	var_01 thread sword_throw_handle_collision(param_00);
	if(common_scripts\utility::func_562E(1))
	{
		var_01 thread sword_throw_damage_impacted_zombies(param_00);
	}

	playfxontag(common_scripts\utility::func_44F5("zmb_sword_zmb_throw"),var_01,"tag_origin");
	var_01 lib_0378::func_8D74("dlc3_barbarosa_swrd_knockback");
	var_01 sword_throw_animate(param_00);
}

//Function Number: 50
set_sword_throw_state(param_00)
{
	var_01 = self;
	var_01.swordthrowstate = param_00;
}

//Function Number: 51
sword_throw_handle_collision(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 endon("sword_throw_end");
	if(common_scripts\utility::func_562E(0))
	{
		var_02 = self gettagorigin("J_Spine4");
		var_03 = spawn("script_model",var_02);
		var_03 setmodel("tag_origin");
		var_03.var_117 = var_01;
		var_04 = 180;
		var_03 method_8449(var_01,"tag_origin",(0,0,0),(0,var_04,0));
		var_01 maps/mp/agents/_agent_utility::deleteentonagentdeath(var_03);
		thread cleanup_ent_on_throw_end(var_03);
		var_05 = spawnstruct();
		var_05.var_2434 = 37;
		var_05.var_60C1 = 55;
		var_05.var_3A20 = 82;
		var_05.var_1B70 = 160;
		var_01 childthread lib_0547::tackle_thread(var_03,var_05);
	}

	var_06 = var_01.var_116;
	var_07 = 100;
	var_08 = param_00.ownerinitialangles[1];
	var_09 = 10;
	wait(0.25);
	for(;;)
	{
		wait 0.05;
		var_0A = var_01.var_116 - var_06;
		if(lengthsquared(var_0A) < var_07)
		{
			break;
		}

		var_0B = vectortoyaw(var_0A);
		var_0C = abs(angleclamp180(var_0B - var_08));
		if(var_0C > var_09)
		{
			break;
		}

		var_06 = var_01.var_116;
	}

	if(common_scripts\utility::func_562E(1))
	{
		var_0E = lib_0547::func_43F0(var_01.var_116,var_01.var_8302,var_01.var_8303 * 1.2,1);
		foreach(var_10 in var_0E)
		{
			if(isdefined(var_01.thrownimpacts))
			{
				var_11 = var_01.thrownimpacts[var_10 getentitynumber()];
				if(isdefined(var_11) && gettime() - var_11 <= 100)
				{
					continue;
				}
			}

			sword_throw_zombie_impact_damage(param_00,var_01,var_10);
		}
	}

	var_01 notify("sword_throw_blocked");
}

//Function Number: 52
sword_throw_damage_impacted_zombies(param_00)
{
	var_01 = self;
	var_01 endon("sword_throw_blocked");
	var_01 endon("sword_throw_end");
	var_01 endon("death");
	for(;;)
	{
		var_01 waittill("touch",var_02);
		if(!function_01EF(var_02))
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		if(isdefined(var_02.var_A) && var_02.var_A == level.var_746E)
		{
			continue;
		}

		if(var_02 == var_01)
		{
			continue;
		}

		if(isdefined(var_02.swordthrowstate))
		{
			continue;
		}

		sword_throw_zombie_impact_damage(param_00,var_01,var_02);
	}
}

//Function Number: 53
sword_throw_zombie_impact_damage(param_00,param_01,param_02)
{
	if(sword_can_stun(param_02) || sword_can_secondary_stun(param_02) || sword_can_secondary_slow(param_02))
	{
		lib_0547::func_7D1B(lib_0547::create_temp_tackler(param_01),param_02,"close",param_01.swordthrowowner);
	}

	param_02 dodamage(level.swordthrowimpactdamage,param_01.var_116,param_00.var_117,param_00.var_117,"MOD_MELEE","zom_dlc3_5_throw_zm");
	if(common_scripts\utility::func_562E(1) && isalive(param_02))
	{
		if(param_02.var_A4B == "zombie_heavy")
		{
			param_02 thread lib_0567::zombie_heavy_set_grudge(param_00.var_117);
		}
	}

	if(param_01.var_A4B == "zombie_exploder")
	{
		param_01 lib_0563::zombie_exploder_attempt_detonate(param_00.var_117,"zom_dlc3_5_throw_zm");
	}

	param_01 dodamage(level.swordthrowimpactdamage,param_01.var_116,param_00.var_117,param_00.var_117,"MOD_MELEE","zom_dlc3_5_throw_zm");
	if(!isdefined(param_01.thrownimpacts))
	{
		param_01.thrownimpacts = [];
	}

	param_01.thrownimpacts[param_02 getentitynumber()] = gettime();
}

//Function Number: 54
sword_throw_handle_zombie_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = self;
	if(isdefined(self.swordthrowstate))
	{
		if(var_09.var_A4B == "zombie_exploder")
		{
			var_09 lib_0563::zombie_exploder_attempt_detonate(var_09.swordthrowowner,"zom_dlc3_5_throw_zm");
		}
	}
}

//Function Number: 55
cleanup_ent_on_throw_end(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_01 waittill("sword_throw_end");
	param_00 delete();
}

//Function Number: 56
sword_throw_animate(param_00)
{
	var_01 = self;
	var_01 endon("death");
	var_02 = randomfloatrange(0.5,2);
	set_sword_throw_state(0);
	var_03 = maps/mp/agents/_scripted_agent_anim_util::func_434D("energy_throw_start");
	var_04 = self method_83DB(var_03);
	var_05 = randomint(var_04);
	var_06 = solve_yaw_for_throw_anim(var_03,var_05,param_00.ownerinitialangles[1]);
	var_01.var_1D = (var_01.var_1D[0],var_06,var_01.var_1D[2]);
	var_07 = 2 / var_02;
	var_01 method_839C("anim deltas");
	var_01 scragentsetorientmode("face angle rel",(var_01.var_1D[0],var_06,var_01.var_1D[2]));
	var_01 method_839D("gravity");
	var_01 method_839A(var_07,1);
	var_01 set_sword_throw_state(1);
	var_03 = var_01 maps/mp/agents/_scripted_agent_anim_util::func_434D("energy_throw_loop");
	var_04 = var_01 method_83DB(var_03);
	var_05 = randomint(var_04);
	var_06 = solve_yaw_for_throw_anim(var_03,var_05,param_00.ownerinitialangles[1]);
	var_01 scragentsetorientmode("face angle abs",(var_01.var_1D[0],var_06,var_01.var_1D[2]));
	var_08 = 2;
	var_09 = randomfloat(1);
	var_01 maps/mp/agents/_scripted_agent_anim_util::func_8415(var_03,var_05,var_02,var_09);
	var_01 maps\mp\_utility::func_A6D1(var_08,"sword_throw_blocked");
}

//Function Number: 57
solve_yaw_for_throw_anim(param_00,param_01,param_02)
{
	var_03 = self method_83D8(param_00,param_01);
	var_04 = getmovedelta(var_03,0,1);
	var_05 = vectortoangles(var_04);
	return angleclamp180(param_02 - var_05[1]);
}

//Function Number: 58
sword_throw_interrupt(param_00)
{
}

//Function Number: 59
sword_can_stun(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = lib_0547::func_A51(param_00.var_A4B);
	}

	if(common_scripts\utility::func_562E(param_00.noenergyhold))
	{
		return 0;
	}

	return common_scripts\utility::func_562E(param_01.energyhold);
}

//Function Number: 60
sword_can_secondary_stun(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = lib_0547::func_A51(param_00.var_A4B);
	}

	if(common_scripts\utility::func_562E(param_00.noenergyholdsecondary))
	{
		return 0;
	}

	return common_scripts\utility::func_562E(param_01.energyholdsecondary);
}

//Function Number: 61
sword_can_secondary_slow(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = lib_0547::func_A51(param_00.var_A4B);
	}

	if(common_scripts\utility::func_562E(param_00.noenergyslowsecondary))
	{
		return 0;
	}

	return common_scripts\utility::func_562E(param_01.energyslowsecondary);
}

//Function Number: 62
sword_can_throw(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = lib_0547::func_A51(param_00.var_A4B);
	}

	if(common_scripts\utility::func_562E(param_00.notthrowable))
	{
		return 0;
	}

	return common_scripts\utility::func_562E(param_01.throwable);
}

//Function Number: 63
sword_can_stun_kill(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = lib_0547::func_A51(param_00.var_A4B);
	}

	if(common_scripts\utility::func_562E(param_00.noenergyholdkill))
	{
		return 0;
	}

	return common_scripts\utility::func_562E(param_01.energyholdkill);
}

//Function Number: 64
sword_throw_end(param_00)
{
	var_01 = self;
	var_01.immunetotackling = undefined;
	var_01 set_sword_throw_state(2);
	var_01 notify("sword_throw_end");
	if(var_01.var_A4B == "zombie_exploder")
	{
		var_01 lib_0563::zombie_exploder_attempt_detonate(param_00.var_117,"zom_dlc3_5_throw_zm");
	}

	var_01 dodamage(var_01.var_BC + 1,var_01.var_116,param_00.var_117,param_00.var_117,"MOD_MELEE","zom_dlc3_5_throw_zm","head");
	var_01 scragentsetscripted(0);
	var_01 maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"barb_sword_throw");
	var_01 method_839A(1,1);
	set_sword_throw_state(undefined);
	var_01.swordthrowowner = undefined;
}

//Function Number: 65
sword_add_secondary_stun(param_00)
{
	var_01 = self;
	if(!isdefined(var_01.var_A4B))
	{
		return;
	}

	if(common_scripts\utility::func_562E(1))
	{
		var_02 = param_00.lastswordstunplayer;
		if(!isdefined(var_02) || !isplayer(var_02))
		{
			var_02 = common_scripts\utility::func_F82(param_00.activeswordstunplayers);
		}

		if(var_01.var_A4B == "zombie_heavy" && isdefined(var_02) && isplayer(var_02))
		{
			var_01 thread lib_0567::zombie_heavy_set_grudge(var_02);
		}
	}

	var_03 = lib_0547::func_A51(var_01.var_A4B);
	if(!isdefined(var_03) || !sword_can_secondary_stun(var_01,var_03) && !sword_can_secondary_slow(var_01,var_03))
	{
		return;
	}

	var_04 = param_00 getentitynumber();
	var_01 notify("secondary_stun_begin_" + var_04);
	if(!isdefined(var_01.activesecondarystuns))
	{
		var_01.activesecondarystuns = [];
	}

	if(!isdefined(param_00.outgoingstuns))
	{
		param_00.outgoingstuns = [];
	}

	if(var_01.activesecondarystuns.size == 0)
	{
		var_01 thread play_shock_fx("zmb_barb_sword_stun_secondary","J_Spine4",undefined,1,"sword_secondary_stun_shock","all_secondary_stuns_expired");
		var_01 lib_0378::func_8D74("dlc3_barbarosa_sword_stun","stun_on");
		if(sword_can_secondary_stun(var_01,var_03))
		{
			var_01 lib_0547::add_zombie_stun("barb_sword_secondary",level);
			var_05 = [var_01,"all_secondary_stuns_expired"];
			var_06 = create_sword_secondary_stun_params(var_05);
			var_01 thread lib_0547::func_7D1A("barb_sword_stun_secondary",[var_06],undefined,var_05);
		}
		else if(sword_can_secondary_slow(var_01,var_03))
		{
			var_01 applyswordsecondaryslowdebuff();
		}
	}
	else
	{
	}

	if(!isdefined(param_00.outgoingstuns[var_01 getentitynumber()]))
	{
		param_00.outgoingstuns[var_01 getentitynumber()] = var_01;
		var_01.activesecondarystuns[var_04] = param_00;
		thread sword_secondary_stun_handle_expire(param_00);
	}
}

//Function Number: 66
sword_secondary_stun_handle_expire(param_00)
{
	var_01 = self;
	var_02 = param_00 getentitynumber();
	var_01 endon("death");
	var_01 endon("secondary_stun_begin_" + var_02);
	var_01 endon("secondary_stun_end_" + var_02);
	wait(4);
	var_01 thread sword_secondary_stun_expire(param_00);
}

//Function Number: 67
sword_secondary_stun_expire(param_00)
{
	var_01 = self;
	var_02 = param_00 getentitynumber();
	var_03 = lib_0547::func_A51(var_01.var_A4B);
	var_01.activesecondarystuns[var_02] = undefined;
	param_00.outgoingstuns[var_01 getentitynumber()] = undefined;
	var_01 lib_0378::func_8D74("dlc3_barbarosa_sword_stun","stun_off");
	var_01 notify("secondary_stun_end_" + var_02);
	if(var_01.activesecondarystuns.size == 0)
	{
		if(sword_can_secondary_stun(var_01,var_03))
		{
			var_01 lib_0547::remove_zombie_stun("barb_sword_secondary");
		}
		else if(sword_can_secondary_slow(var_01,var_03))
		{
			var_01 removeswordsecondaryslowdebuff();
		}

		var_01 notify("all_secondary_stuns_expired");
	}
}

//Function Number: 68
create_sword_secondary_stun_params(param_00)
{
	var_01 = self;
	var_02 = spawnstruct();
	var_02.endon_pairs = param_00;
	return var_02;
}

//Function Number: 69
sword_secondary_stun_run(param_00)
{
	var_01 = self;
	var_01 scragentsetscripted(1);
	var_01 maps/mp/agents/_scripted_agent_anim_util::func_8732(1,"barb_sword_stun_secondary");
	var_01 lib_0542::set_invalid_melee_pairing_reason("barb_secondary_stun",1);
	var_01 sword_secondary_stun_intro(param_00);
	var_01 sword_secondary_stun_loop(param_00);
}

//Function Number: 70
sword_secondary_stun_intro(param_00)
{
	var_01 = self;
	var_01 endon("all_secondary_stuns_expired");
	var_02 = ["side_stumble_2_left","side_stumble_2_right","side_stumble_3_left","side_stumble_3_right","pain_stand"];
	var_03 = common_scripts\utility::func_F92(var_02)[0];
	var_04 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_03);
	var_05 = self method_83DB(var_04);
	var_06 = randomint(var_05);
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",self.var_1D);
	maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_04,var_06,1,"stun_anim");
}

//Function Number: 71
sword_secondary_stun_loop(param_00)
{
	var_01 = self;
	var_01 endon("all_secondary_stuns_expired");
	while(var_01.activesecondarystuns.size > 0)
	{
		var_02 = undefined;
		var_03 = maps/mp/agents/_scripted_agent_anim_util::func_434D("energy_hold_secondary");
		var_04 = self method_83DB(var_03);
		if(self.var_A4B == "zombie_exploder")
		{
			if(common_scripts\utility::func_562E(self.var_392C))
			{
				var_02 = 0;
			}
			else
			{
				var_02 = 1;
			}
		}

		if(isdefined(var_02))
		{
			var_05 = var_02;
		}
		else
		{
			var_05 = randomint(var_04);
		}

		self method_839C("anim deltas");
		self scragentsetorientmode("face angle abs",self.var_1D);
		maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_03,var_05,1,"stun_anim");
	}
}

//Function Number: 72
sword_secondary_stun_interrupt(param_00)
{
	var_01 = self;
	if(var_01.activesecondarystuns.size > 0)
	{
		param_00.requeued = 1;
		var_01 thread lib_0547::func_7D1A("barb_sword_stun_secondary",[param_00],undefined,param_00.endon_pairs);
	}
}

//Function Number: 73
sword_secondary_stun_end(param_00)
{
	var_01 = self;
	var_01 lib_0542::set_invalid_melee_pairing_reason("barb_sword_stun",0);
	var_01 scragentsetscripted(0);
	var_01 maps/mp/agents/_scripted_agent_anim_util::func_8732(0,"barb_sword_stun_secondary");
}

//Function Number: 74
sword_secondary_stun_cleanup_outgoing_stuns()
{
	var_00 = self;
	if(isdefined(var_00.outgoingstuns))
	{
		var_01 = var_00.outgoingstuns;
		foreach(var_03 in var_01)
		{
			var_03 thread sword_secondary_stun_expire(var_00);
		}
	}
}

//Function Number: 75
sword_secondary_stun_handle_zombie_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = self;
	var_09 sword_secondary_stun_cleanup_outgoing_stuns();
	if(isdefined(var_09.activesecondarystuns))
	{
		var_0A = var_09.activesecondarystuns;
		foreach(var_0C in var_0A)
		{
			var_09 thread sword_secondary_stun_expire(var_0C);
		}
	}
}

//Function Number: 76
applyswordsecondaryslowdebuff()
{
	var_00 = self;
	var_00 lib_054D::func_99B("secondary_slow",getswordsecondaryslowdebuff());
}

//Function Number: 77
removeswordsecondaryslowdebuff()
{
	var_00 = self;
	var_00 lib_054D::removebuffbyname("secondary_slow");
}

//Function Number: 78
getswordsecondaryslowdebuff()
{
	var_00 = self;
	var_01 = var_00 lib_054D::func_443F("secondary_slow");
	if(!isdefined(var_01))
	{
		var_01 = var_00 spawnswordsecondaryslowdebuff();
	}

	return var_01;
}

//Function Number: 79
spawnswordsecondaryslowdebuff()
{
	var_00 = self;
	var_01 = spawnstruct();
	var_01.var_1CF0 = ::cleanupswordsecondaryslowdebuff;
	var_01.var_90F0 = 0.3;
	var_00 notify("speed_debuffs_changed");
	return var_01;
}

//Function Number: 80
cleanupswordsecondaryslowdebuff(param_00)
{
	var_01 = self;
	var_01 notify("speed_debuffs_changed");
}

//Function Number: 81
sword_on_heavy_melee_kill(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = self;
	var_0A = param_01;
	if(common_scripts\utility::func_562E(1))
	{
		var_0B = 0;
		var_0C = 0;
		var_0D = 0;
		if(common_scripts\utility::func_562E(1))
		{
			var_0C = var_0C | common_scripts\utility::func_562E(var_0A.swordempower.var_8BE);
			var_0B = 1;
		}

		if(common_scripts\utility::func_562E(1))
		{
			var_0E = isdefined(get_geist_bomb_for_position(var_0A.var_116,var_0A));
			var_0C = var_0C | var_0E;
			var_0D = var_0E;
			var_0B = 1;
		}

		if(!var_0B || var_0C)
		{
			var_0F = var_0A thread sword_try_grant_armor();
			if(var_0F && common_scripts\utility::func_562E(1) && !var_0D)
			{
				var_0A sword_empower_off();
			}
		}
	}

	var_0A thread sword_handle_power_investment(var_09);
}

//Function Number: 82
sword_try_grant_armor()
{
	var_00 = self;
	if(var_00.var_BC < var_00.var_FB)
	{
		var_00 notify("immediateHealthRegen");
	}

	if(var_00 lib_0547::func_73E9() < var_00 lib_0547::playergetmaxarmorcount())
	{
		var_00 thread sword_grant_armor_internal();
		return 1;
	}

	return 0;
}

//Function Number: 83
sword_grant_armor_internal()
{
	var_00 = self;
	var_00 endon("disconnect");
	playfxontagforclients(common_scripts\utility::func_44F5("zmb_barb_victim_drain_armor"),var_00,"J_Spine4",var_00);
	var_00 lib_0378::func_8D74("zmb_sword_finisher_effects");
	wait(0.2);
	var_00 lib_0547::func_73AC(1);
}

//Function Number: 84
sword_handle_empower()
{
	var_00 = self;
	var_00.swordempower = spawnstruct();
	var_00.swordempower.empowerkills = 0;
	if(common_scripts\utility::func_562E(0))
	{
		thread sword_empower_watch_player_meter();
	}

	thread sword_empower_watch_last_stand();
	thread sword_empower_watch_game_end();
}

//Function Number: 85
sword_empower_watch_player_meter()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_00.swordempower endon("sword_empower_cleanup");
	var_00.swordempower.var_8BE = 0;
	for(;;)
	{
		var_01 = var_00 rolegetpower() >= 1;
		if(var_01)
		{
			if(!common_scripts\utility::func_562E(var_00.swordempower.var_8BE))
			{
				var_00 thread sword_empower_on();
				var_00.swordempower.var_8BE = 1;
			}
		}
		else if(common_scripts\utility::func_562E(var_00.swordempower.var_8BE))
		{
			var_00 thread sword_empower_off();
			var_00.swordempower.var_8BE = 0;
		}

		wait 0.05;
	}
}

//Function Number: 86
sword_empower_watch_last_stand()
{
	var_00 = self;
	var_00.swordempower endon("sword_empower_cleanup");
	var_00 endon("disconnect");
	for(;;)
	{
		var_00 common_scripts\utility::knock_off_battery("begin_last_stand","enter_last_stand","death");
		var_00 sword_empower_off();
	}
}

//Function Number: 87
sword_empower_watch_game_end()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_00.swordempower endon("sword_empower_cleanup");
	for(;;)
	{
		level waittill("game_ended");
		var_00 sword_empower_off();
	}
}

//Function Number: 88
sword_empower_handle_zombie_killed(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(param_01) || !isplayer(param_01))
	{
		return;
	}

	var_09 = param_01;
	var_09.swordempower.empowerkills++;
	if(!common_scripts\utility::func_562E(var_09.swordempower.var_8BE) && var_09.swordempower.empowerkills >= 30)
	{
		var_09 thread sword_empower_on();
	}
}

//Function Number: 89
sword_empower_on()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_00 endon("sword_empower_off");
	var_01 = 0;
	var_00.swordempower.var_8BE = 1;
	for(;;)
	{
		var_02 = var_00 getcurrentweapon();
		var_03 = issubstr(var_02,"zom_dlc3_5_zm");
		if(var_03)
		{
			if(!var_01)
			{
				thread sword_empower_fx_on();
			}
		}
		else if(var_01)
		{
			thread sword_empower_fx_off();
		}

		var_01 = var_03;
		var_00 common_scripts\utility::knock_off_battery("weapon_given","weapon_taken","zombie_player_spawn_finished","melee_weapon_change","weapon_switch_started");
		wait 0.05;
		while(var_00 method_833B())
		{
			wait 0.05;
		}
	}
}

//Function Number: 90
sword_empower_off()
{
	var_00 = self;
	if(!isdefined(var_00.swordempower) || !common_scripts\utility::func_562E(var_00.swordempower.var_8BE))
	{
		return;
	}

	var_00.swordempower.var_8BE = 0;
	var_00.swordempower.empowerkills = 0;
	var_00 notify("sword_empower_off");
	thread sword_empower_fx_off();
}

//Function Number: 91
sword_cleanup_empower()
{
	var_00 = self;
	var_00 thread sword_empower_off();
	var_00.swordempower notify("sword_empower_cleanup");
	var_00.swordempower = undefined;
}

//Function Number: 92
sword_empower_fx_on()
{
	var_00 = self;
	var_01 = common_scripts\utility::func_44F5("zmb_barb_sword_activate");
	var_00.swordempower.var_35A6 = spawnlinkedfxforclient(var_01,var_00,"TAG_WW_MELEE_FX",var_00,1);
	var_00 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_00.swordempower.var_35A6);
	function_014E(var_00.swordempower.var_35A6,1);
	triggerfx(var_00.swordempower.var_35A6);
	var_00.swordempower.var_35A6 lib_0378::func_8D74("dlc3_barbarosa_sword_empowered");
	var_02 = common_scripts\utility::func_44F5("zmb_barb_sword_activate_wv");
	var_00.swordempower.wv_effects = spawnlinkedfx(var_02,var_00,"TAG_WW_MELEE_FX",1);
	var_00 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_00.swordempower.wv_effects);
	function_014E(var_00.swordempower.wv_effects,1);
	triggerfx(var_00.swordempower.wv_effects);
	var_00.swordempower.wv_effects hidefromclient(var_00);
}

//Function Number: 93
sword_empower_fx_off()
{
	var_00 = self;
	if(isdefined(var_00.swordempower.var_35A6))
	{
		var_00.swordempower.var_35A6 delete();
	}

	if(isdefined(var_00.swordempower.wv_effects))
	{
		var_00.swordempower.wv_effects delete();
	}
}

//Function Number: 94
sword_handle_power_investment(param_00)
{
	self endon("death");
	self endon("disconnect");
	if(!sword_player_can_invest(param_00))
	{
		return;
	}

	thread sword_offer_power_investment(param_00);
	var_01 = common_scripts\utility::func_562E(sword_wait_investment_choice(param_00));
	if(var_01)
	{
		thread sword_activate_investment(param_00);
	}

	thread sword_revoke_power_investment_offer();
}

//Function Number: 95
sword_offer_power_investment(param_00)
{
	var_01 = self;
	var_01.swordinvestment.offer = 1;
	thread sword_investment_handle_corpse_transition(param_00);
	if(isdefined(var_01.priminggeistbomb))
	{
		var_01.priminggeistbomb geist_bomb_end_priming();
		var_01.priminggeistbomb geist_bomb_disarmed();
	}

	var_01 lib_0547::force_use_hint_on(&"ZOMBIE_WEAPONDLC3_INVEST_PROMPT","sword_invest");
}

//Function Number: 96
sword_revoke_power_investment_offer()
{
	var_00 = self;
	var_00 lib_0547::force_use_hint_off("sword_invest");
	var_00.swordinvestment.offer = 0;
	var_00.swordinvestment.var_2670 = undefined;
	var_00.swordinvestment.no_corpse = undefined;
	var_00.swordinvestment notify("corpse_update");
}

//Function Number: 97
sword_investment_handle_corpse_transition(param_00)
{
	self endon("disconnect");
	var_01 = param_00 common_scripts\utility::func_A70F(0.5,param_00,"body_spawned");
	if(isstring(var_01[0]) && var_01[0] == "timeout")
	{
		self.swordinvestment.no_corpse = 1;
		self.swordinvestment notify("corpse_update");
		return;
	}

	var_02 = var_01[1];
	var_03 = var_01[0];
	if(var_01.size > 2)
	{
		var_04 = common_scripts\utility::func_FA3(var_01,2,var_01.size);
	}
	else
	{
		var_04 = [];
	}

	self.swordinvestment.var_2670 = var_04[0];
	self.swordinvestment.var_2670 waittill("entitydeleted");
	self.swordinvestment.var_2670 = undefined;
	self.swordinvestment.no_corpse = 1;
	self.swordinvestment notify("corpse_update");
}

//Function Number: 98
sword_corpse_wait_success()
{
	var_00 = self;
	var_00 endon("disconnect");
	if(!isdefined(var_00.swordinvestment.var_2670))
	{
		if(common_scripts\utility::func_562E(var_00.swordinvestment.no_corpse))
		{
			return 0;
		}

		var_00.swordinvestment waittill("corpse_update");
		if(!isdefined(var_00.swordinvestment.var_2670))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 99
sword_wait_investment_choice(param_00)
{
	self endon("investment_expire");
	self endon("enter_last_stand");
	self endon("begin_last_stand");
	self endon("disconnect");
	childthread sword_notify_on_heavy_melee_end();
	while(!self usebuttonpressed())
	{
		wait 0.05;
	}

	return 1;
}

//Function Number: 100
sword_notify_on_heavy_melee_end()
{
	while(self method_8661())
	{
		wait 0.05;
	}

	self notify("investment_expire");
}

//Function Number: 101
sword_player_can_invest(param_00)
{
	if(isdefined(param_00) && lib_0547::func_5565(param_00.var_2A9D,"scripted_soul_eat"))
	{
		return 0;
	}

	if(!isdefined(self.swordempower) || !common_scripts\utility::func_562E(self.swordempower.var_8BE))
	{
		return 0;
	}

	if(common_scripts\utility::func_562E(0))
	{
		if(self rolecheckstate("active"))
		{
			return 0;
		}

		if(self rolegetpower() < 1)
		{
			return 0;
		}
	}

	if(common_scripts\utility::func_562E(1))
	{
		if(lib_0547::func_73E9() < lib_0547::playergetmaxarmorcount())
		{
			return 0;
		}
	}

	if(common_scripts\utility::func_562E(1))
	{
		if(lib_0547::playergetmaxarmorcount() == 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 102
sword_activate_investment(param_00)
{
	var_01 = self;
	if(common_scripts\utility::func_562E(0))
	{
		var_01 lib_0533::func_F37(-1,1,1);
	}

	if(common_scripts\utility::func_562E(0))
	{
		var_01 lib_0547::func_7454(0);
	}

	if(common_scripts\utility::func_562E(1))
	{
		var_01 lib_0547::playersetmaxarmorcount(var_01 lib_0547::playergetmaxarmorcount() - 1);
		playfxontagforclients(common_scripts\utility::func_44F5("zmb_barb_victim_drain_armor"),var_01,"J_Spine4",var_01);
	}

	if(1)
	{
		var_01 sword_empower_off();
	}

	var_02 = geist_bomb_create(param_00,var_01);
}

//Function Number: 103
geist_bomb_create(param_00,param_01)
{
	var_02 = spawnstruct();
	if(!isdefined(param_01.geistbombs))
	{
		param_01.geistbombs = [];
	}

	param_01.geistbombs = common_scripts\utility::func_F6F(param_01.geistbombs,var_02);
	var_02.var_721C = param_01;
	var_02.var_8203 = spawn("script_model",param_01.var_116);
	var_02.var_8203 setmodel("tag_origin");
	if(isdefined(param_00))
	{
		if(function_01EF(param_00))
		{
			var_02.var_AB4D = param_00;
		}
	}

	var_02 thread geist_bomb_think();
	return var_02;
}

//Function Number: 104
geist_bomb_think()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_00 endon("geist_bomb_cleanup");
	thread geist_bomb_handle_death_disconnect();
	thread geist_bomb_handle_initial_positioning();
	thread geist_bomb_creation_zombie_fx();
	thread geist_bomb_handle_vesting();
	if(common_scripts\utility::func_562E(1))
	{
		thread geist_bomb_handle_revive();
	}

	thread geist_bomb_handle_withdrawal();
}

//Function Number: 105
geist_bomb_handle_initial_positioning()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	if(isdefined(var_01.swordinvestment.var_2670))
	{
		var_00.var_8203.var_116 = var_01.swordinvestment.var_2670.var_116 + (0,0,48);
	}
	else
	{
		var_00.var_8203.var_116 = var_01.var_116 + anglestoforward(var_01.var_1D) * 36 + (0,0,48);
	}

	var_00.var_487B = getgroundposition(var_00.var_8203.var_116,24,48,0,0);
	if(!isdefined(var_00.var_487B))
	{
		var_00.var_487B = var_00.var_8203.var_116 - (0,0,24);
	}
}

//Function Number: 106
geist_bomb_creation_zombie_fx()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_01 endon("disconnect");
	if(!var_01 sword_corpse_wait_success())
	{
		return;
	}

	var_02 = var_01.swordinvestment.var_2670;
	var_00.creation_fx_beam = launchbeam("zmb_geistkraft_reg_beam_med",var_02,"j_neck",var_00.var_8203,"tag_origin");
	var_01 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_00.creation_fx_beam);
	playfxontag(common_scripts\utility::func_44F5("zmb_barb_victim_geist_drain"),var_02,"j_neck");
	common_scripts\utility::func_A70D(10,var_01.swordinvestment,"corpse_update",var_00,"geist_bomb_cleanup");
	var_00.creation_fx_beam delete();
}

//Function Number: 107
geist_bomb_handle_death_disconnect()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_00 endon("geist_bomb_cleanup");
	var_01 common_scripts\utility::knock_off_battery("death","disconnect","sword_lost");
	var_00 geist_bomb_cleanup();
}

//Function Number: 108
geist_bomb_handle_vesting()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_01 endon("disconnect");
	var_00 endon("geist_bomb_cleanup");
	var_00 thread geist_bomb_run_vesting();
	var_00 geist_bomb_wait_for_vesting();
	childthread geist_bomb_ready_vfx();
}

//Function Number: 109
geist_bomb_handle_withdrawal()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_01 endon("disconnect");
	var_00 endon("geist_bomb_cleanup");
	var_00 geist_bomb_wait_for_vesting();
}

//Function Number: 110
geist_bomb_withdraw_power()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	if(common_scripts\utility::func_562E(1))
	{
		var_01 lib_0547::func_7454(var_01 lib_0547::playergetmaxarmorcount());
	}

	if(common_scripts\utility::func_562E(0))
	{
		var_01 lib_0533::func_F37(1,1,1);
	}

	geist_bomb_cleanup();
}

//Function Number: 111
geist_bomb_handle_revive()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_01 endon("disconnect");
	var_00 endon("geist_bomb_cleanup");
	var_00 geist_bomb_wait_for_vesting();
	if(!isdefined(var_01.geist_bomb_revives))
	{
		var_01.geist_bomb_revives = [];
	}

	var_00.revive_enabled = 1;
	var_01.geist_bomb_revives = common_scripts\utility::func_F6F(var_01.geist_bomb_revives,var_00);
	if(var_01.geist_bomb_revives.size == 1)
	{
		var_01.mapreviveenabled = 1;
	}

	for(;;)
	{
		if(!lib_0547::func_577E(var_01))
		{
			var_01 waittill("enter_last_stand");
		}

		var_00 geist_bomb_attempt_revive();
	}
}

//Function Number: 112
geist_bomb_cleanup_revive()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	if(common_scripts\utility::func_562E(var_00.revive_enabled))
	{
		var_01.geist_bomb_revives = common_scripts\utility::func_F93(var_01.geist_bomb_revives,var_00);
	}

	if(var_01.geist_bomb_revives.size == 0)
	{
		var_01.mapreviveenabled = undefined;
	}
}

//Function Number: 113
geist_bomb_attempt_revive()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_00.within_revive_distance = 0;
	while(lib_0547::func_577E(var_01))
	{
		var_02 = 0;
		if(distance2d(var_01.var_116,var_00.var_8203.var_116) > 75)
		{
			var_02 = 1;
		}

		if(abs(var_01.var_116[2] - var_00.var_487B[2]) > 74)
		{
			var_02 = 1;
		}

		if(!var_02)
		{
			var_03 = function_038E(var_01.var_116,var_00.var_8203.var_116);
			if(var_03 > 75)
			{
				var_02 = 1;
			}
		}

		if(var_02)
		{
			geist_bomb_revive_too_far();
			continue;
		}

		geist_bomb_revive_within_range();
		wait(0.5);
	}
}

//Function Number: 114
geist_bomb_revive_too_far()
{
	var_00 = self;
	if(common_scripts\utility::func_562E(var_00.within_revive_distance))
	{
		var_00 notify("bomb_too_far_away");
	}

	var_00.within_revive_distance = 0;
}

//Function Number: 115
geist_bomb_revive_within_range()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	if(!common_scripts\utility::func_562E(var_00.within_revive_distance))
	{
		thread geist_bomb_revive_fx();
		if(common_scripts\utility::func_562E(0))
		{
			thread geist_bomb_revive_timer();
		}
	}

	var_00.within_revive_distance = 1;
}

//Function Number: 116
geist_bomb_revive_timer()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_01 endon("revive");
	var_01 endon("death");
	var_01 endon("disconnect");
	var_00 endon("bomb_too_far_away");
	var_00 endon("geist_bomb_cleanup");
	var_02 = 0;
	var_03 = 60;
	while(var_02 < var_03)
	{
		var_04 = 0;
		if(common_scripts\utility::func_562E(var_01.var_172C))
		{
			var_04 = 1;
		}

		if(var_04)
		{
			var_02 = 0;
			continue;
		}

		var_02++;
		wait 0.05;
	}

	geist_bomb_revive();
}

//Function Number: 117
geist_bomb_revive()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_01 lib_0553::func_53E2(var_01);
	thread geist_bomb_withdraw_power();
}

//Function Number: 118
geist_bomb_revive_last_chance()
{
	var_00 = self;
	if(isdefined(var_00.geist_bomb_revives) && var_00.geist_bomb_revives.size > 0)
	{
		foreach(var_02 in var_00.geist_bomb_revives)
		{
			if(common_scripts\utility::func_562E(var_02.within_revive_distance))
			{
				var_02 geist_bomb_revive();
				wait 0.05;
				return;
			}
		}
	}
}

//Function Number: 119
get_geist_bomb_for_position(param_00,param_01)
{
	if(isdefined(param_01.geistbombs))
	{
		foreach(var_03 in param_01.geist_bomb_revives)
		{
			if(distance2d(param_00,var_03.var_8203.var_116) < 75)
			{
				if(abs(param_01.var_116[2] - var_03.var_487B[2]) <= 74)
				{
					return var_03;
				}
			}
		}
	}

	return undefined;
}

//Function Number: 120
geist_bomb_revive_fx()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_01 endon("disconnect");
	var_02 = launchbeam("zmb_giestbomb_revive_beam",var_00.var_8203,"tag_origin",var_00.var_721C,"tag_origin");
	var_01 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_02);
	lib_0378::func_8D74("dlc3_giest_bomb_revive",var_01,var_02);
	common_scripts\utility::func_A70C(var_00,"bomb_too_far_away",var_00,"geist_bomb_cleanup",var_01,"revive",var_01,"death");
	var_02 delete();
}

//Function Number: 121
geist_bomb_wait_for_vesting()
{
	var_00 = self;
	if(!common_scripts\utility::func_562E(var_00.vested))
	{
		var_00 waittill("geist_bomb_vested");
	}
}

//Function Number: 122
geist_bomb_run_vesting()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_00 endon("geist_bomb_cleanup");
	var_01 endon("disconnect");
	var_02 = 0;
	var_03 = 0;
	if(0 || 0)
	{
		while(!var_02)
		{
			level waittill("zombie_wave_started");
			if(!var_03)
			{
				var_00.starting_round = level.currentwave;
				var_00.starting_objective_count = level.objectivescompleted;
				var_03 = 1;
			}

			level waittill("zombie_wave_ended");
			var_04 = level.currentwave - var_00.starting_round;
			var_05 = level.objectivescompleted - var_00.starting_objective_count;
			if(var_04 > 0 && var_05 > 0)
			{
				var_02 = 1;
			}
		}
	}
	else
	{
		var_02 = 1;
	}

	var_00 notify("geist_bomb_vested");
	var_00.vested = 1;
}

//Function Number: 123
geist_bomb_ready_vfx()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_00 endon("geist_bomb_cleanup");
	var_00.radiusvfx = spawnlinkedfxforclient(common_scripts\utility::func_44F5("zmb_giestbomb_radius"),var_00.var_8203,"tag_origin",var_01);
	lib_0378::func_8D74("dlc3_geist_bomb_activate",var_00);
	for(;;)
	{
		playfxontag(common_scripts\utility::func_44F5("zmb_barb_geist_bomb_ready"),var_00.var_8203,"tag_origin");
		triggerfx(var_00.radiusvfx);
		wait(3);
	}
}

//Function Number: 124
geist_bomb_ready_vfx_cleanup()
{
	var_00 = self;
	if(isdefined(var_00.radiusvfx))
	{
		var_00.radiusvfx delete();
	}
}

//Function Number: 125
geist_bomb_cleanup()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	if(!isdefined(var_00))
	{
		return;
	}

	if(!common_scripts\utility::func_562E(var_00.cleaned))
	{
		if(isdefined(var_01) && isplayer(var_01))
		{
			var_01.geistbombs = common_scripts\utility::func_F93(var_01.geistbombs,var_00);
			var_00 geist_bomb_cleanup_revive();
			if(common_scripts\utility::func_562E(1))
			{
				var_01 lib_0547::playersetmaxarmorcount(var_01 lib_0547::playergetmaxarmorcount() + 1);
				if(isalive(var_01))
				{
					playfxontagforclients(common_scripts\utility::func_44F5("zmb_barb_victim_drain_armor"),var_01,"J_Spine4",var_01);
				}
			}
		}

		var_00 geist_bomb_ready_vfx_cleanup();
		var_00.var_8203 delete();
		var_00.cleaned = 1;
	}

	var_00 notify("geist_bomb_cleanup");
}

//Function Number: 126
sword_geist_bomb_detonate_think()
{
	var_00 = self;
	var_00 endon("sword_lost");
	var_00 endon("disconnect");
	var_00.priminggeistbombtime = 0;
	var_01 = 0.2;
	for(;;)
	{
		wait(var_01);
		var_02 = sword_geist_bomb_detonate_pick_bomb();
		if(isdefined(var_00.priminggeistbomb) && !lib_0547::func_5565(var_02,var_00.priminggeistbomb))
		{
			var_00.priminggeistbombtime = 0;
			var_00.priminggeistbomb geist_bomb_end_priming();
			var_00.priminggeistbomb geist_bomb_disarmed();
			var_00.priminggeistbomb = undefined;
		}

		if(!isdefined(var_02))
		{
			continue;
		}

		if(isdefined(var_00.priminggeistbomb) && lib_0547::func_5565(var_02,var_00.priminggeistbomb))
		{
			var_00.priminggeistbombtime = var_00.priminggeistbombtime + var_01;
			if(!common_scripts\utility::func_562E(var_00.priminggeistbomb.is_armed) && var_00.priminggeistbombtime > 1)
			{
				var_00.priminggeistbomb thread geist_bomb_armed();
			}

			continue;
		}

		var_00.priminggeistbomb = var_02;
		var_00.priminggeistbomb thread geist_bomb_start_priming();
	}
}

//Function Number: 127
sword_geist_bomb_detonate_pick_bomb()
{
	var_00 = self;
	if(!isdefined(var_00.swordempower) || !common_scripts\utility::func_562E(var_00.swordempower.var_8BE))
	{
		return undefined;
	}

	if(!isdefined(var_00.geistbombs) || var_00.geistbombs.size == 0)
	{
		return undefined;
	}

	if(isdefined(var_00.swordinvestment) && common_scripts\utility::func_562E(var_00.swordinvestment.offer))
	{
		return undefined;
	}

	if(var_00 getstance() != "stand")
	{
		return undefined;
	}

	if(!var_00 adsbuttonpressed(0))
	{
		return undefined;
	}

	if(!issubstr(var_00 getcurrentprimaryweapon(),"zom_dlc3_5_zm"))
	{
		return undefined;
	}

	var_01 = undefined;
	var_02 = 0;
	var_03 = cos(5);
	var_04 = anglestoforward(var_00 geteyeangles());
	foreach(var_06 in var_00.geistbombs)
	{
		if(common_scripts\utility::func_562E(var_06.detonating))
		{
			continue;
		}

		var_07 = var_06.var_8203.var_116 - var_00 geteye();
		var_08 = vectordot(vectornormalize(var_07),var_04);
		if(var_08 >= var_03 && var_08 > var_02)
		{
			var_02 = var_08;
			var_01 = var_06;
		}
	}

	return var_01;
}

//Function Number: 128
geist_bomb_start_priming()
{
	var_00 = self;
	var_00 endon("geist_bomb_cleanup");
	var_00 endon("geist_bomb_end_priming");
	lib_0378::func_8D74("dlc3_giest_bomb_arm",var_00);
	for(;;)
	{
		playfxontag(common_scripts\utility::func_44F5("zmb_giestbomb_priming"),var_00.var_8203,"tag_origin");
		wait(2.5);
	}
}

//Function Number: 129
geist_bomb_end_priming()
{
	var_00 = self;
	var_00 notify("geist_bomb_end_priming");
}

//Function Number: 130
geist_bomb_armed()
{
	var_00 = self;
	var_00 endon("geist_bomb_cleanup");
	var_00 endon("geist_bomb_disarmed");
	var_01 = var_00.var_721C;
	var_00.is_armed = 1;
	var_01 lib_0547::force_use_hint_on(&"ZOMBIE_WEAPONDLC3_DETONATE_PROMPT","sword_detonate");
	var_02 = 0;
	var_03 = 0.1;
	for(;;)
	{
		wait(var_03);
		if(var_01 usebuttonpressed())
		{
			var_02 = var_02 + var_03;
			if(var_02 > 1)
			{
				thread geist_bomb_detonate();
				thread geist_bomb_end_priming();
				var_01 thread sword_empower_off();
				thread geist_bomb_disarmed();
			}

			continue;
		}

		var_02 = 0;
	}
}

//Function Number: 131
geist_bomb_disarmed()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	if(common_scripts\utility::func_562E(var_00.is_armed))
	{
		var_00.is_armed = undefined;
		var_01 lib_0547::force_use_hint_off("sword_detonate");
		var_00 notify("geist_bomb_disarmed");
	}
}

//Function Number: 132
geist_bomb_detonate()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_02 = anglestoforward(var_01.var_1D);
	var_03 = var_02 * -12 + (0,0,-1.5);
	var_04 = spawnfx(common_scripts\utility::func_44F5("zmb_giestbomb_detonation"),var_00.var_8203.var_116 + var_03,var_02,(0,0,1));
	triggerfx(var_04);
	lib_0378::func_8D74("dlc3_geist_bomb_detonate",var_00);
	var_00.detonating = 1;
	thread geist_bomb_detonate_kill_radius();
	common_scripts\utility::func_A70D(10,var_00,"geist_bomb_cleanup");
	var_04 delete();
	var_00 notify("geist_bomb_detonate_end");
	var_00.kill_trigger delete();
	var_00 thread geist_bomb_cleanup();
}

//Function Number: 133
geist_bomb_detonate_kill_radius()
{
	var_00 = self;
	var_01 = var_00.var_721C;
	var_00 endon("geist_bomb_detonate_end");
	var_01 endon("disconnect");
	if(!isdefined(level.geistbomblastid))
	{
		level.geistbomblastid = 0;
	}

	var_02 = level.geistbomblastid;
	level.geistbomblastid++;
	var_03 = 720;
	var_00.kill_trigger = spawn("trigger_radius",var_00.var_8203.var_116 - (0,0,var_03 * 0.5),0,360,var_03);
	for(;;)
	{
		var_00.kill_trigger waittill("trigger",var_04);
		if(!isdefined(var_04))
		{
			continue;
		}

		if(!function_01EF(var_04))
		{
			continue;
		}

		if(!isalive(var_04))
		{
			continue;
		}

		if(isdefined(var_04.var_A) && var_04.var_A == level.var_746E)
		{
			continue;
		}

		if(!isdefined(var_04.var_A4B))
		{
			continue;
		}

		var_05 = lib_0547::func_A51(var_04.var_A4B);
		if(!isdefined(var_05))
		{
			continue;
		}

		var_06 = var_04.bombsabotagefunc;
		if(!isdefined(var_06))
		{
			var_06 = var_05.bombsabotagefunc;
		}

		if(isdefined(var_06))
		{
			if(!isdefined(var_04.bombsabotages) || !common_scripts\utility::func_562E(var_04.bombsabotages[var_02]))
			{
				var_04 thread [[ var_06 ]](var_01,"zom_dlc3_5_bomb_zm","MOD_MELEE");
				var_04.bombsabotages[var_02] = 1;
			}
		}

		if(sword_can_stun(var_04,var_05))
		{
			var_04 dodamage(var_04.var_FB + 10,var_00.var_8203.var_116,var_01,var_01,"MOD_ENERGY","zom_dlc3_5_bomb_zm");
			wait(0.25);
		}
	}
}

//Function Number: 134
sword_delivery_init()
{
	var_00 = getentarray("circle_point_off","targetname");
	var_01 = getentarray("circle_point_on","targetname");
	var_02 = common_scripts\utility::func_46B5("circle_center","targetname");
	if(!isdefined(var_00) || isdefined(var_00) && var_00.size <= 0)
	{
		var_00 = common_scripts\utility::func_46B7("circle_point_struct","targetname");
		var_01 = var_00;
	}

	var_03 = 1;
	level.sworddelivery = spawnstruct();
	level.sworddelivery.var_7546 = [];
	level.sworddelivery.var_206B = var_02;
	if(!isdefined(level.sworddelivery.var_206B))
	{
		var_03 = 0;
	}

	foreach(var_05 in var_01)
	{
		var_06 = var_05.var_81E1;
		if(!isdefined(var_06))
		{
			var_03 = 0;
			continue;
		}

		if(isdefined(level.sworddelivery.var_7546[var_06]))
		{
			var_03 = 0;
		}

		var_08 = spawnstruct();
		level.sworddelivery.var_7546[var_06] = var_08;
		var_08.onent = var_05;
		var_08.var_116 = var_05.var_116;
		var_08.var_D4 = var_05.var_81E1;
	}

	foreach(var_05 in var_00)
	{
		var_06 = var_05.var_81E1;
		if(!isdefined(var_06))
		{
			var_03 = 0;
			continue;
		}

		var_08 = level.sworddelivery.var_7546[var_06];
		if(!isdefined(var_08))
		{
			var_03 = 0;
			continue;
		}

		var_08.offent = var_05;
	}

	var_0C = [];
	for(var_06 = 0;var_06 < 7;var_06++)
	{
		var_08 = level.sworddelivery.var_7546[var_06];
		if(!isdefined(var_08))
		{
			var_0C[var_06] = 1;
			var_03 = 0;
			continue;
		}

		if(isdefined(var_08.onent) && isdefined(var_08.offent))
		{
			if(distance(var_08.onent.var_116,var_08.offent.var_116) > 36)
			{
				var_03 = 0;
			}
		}
	}

	if(var_0C.size > 0)
	{
		var_03 = 0;
	}

	if(common_scripts\utility::func_562E(level.sworddeliveryoff))
	{
		foreach(var_08 in level.sworddelivery.var_7546)
		{
			if(isdefined(var_08.onent))
			{
				var_08.onent delete();
			}

			if(isdefined(var_08.offent))
			{
				var_08.offent delete();
			}
		}

		level.sworddelivery = undefined;
		return;
	}

	if(var_05)
	{
		sword_delivery_position_checking();
		thread maps\mp\_utility::func_6F74(::sword_delivery_per_player);
	}
}

//Function Number: 135
sword_delivery_position_checking()
{
	foreach(var_01 in level.sworddelivery.var_7546)
	{
		var_01.dist2d = distance2d(var_01.var_116,level.sworddelivery.var_206B.var_116);
	}

	var_03 = common_scripts\utility::func_7897(level.sworddelivery.var_7546,::delivery_point_sort_from_center);
	var_04 = common_scripts\utility::func_FA3(var_03,0,3);
	var_05 = 0;
	foreach(var_01 in var_04)
	{
		var_05 = var_05 + var_01.dist2d;
	}

	level.sworddelivery.innerradius = var_05 / 3;
	var_08 = common_scripts\utility::func_FA3(var_03,3,7);
	var_05 = 0;
	foreach(var_01 in var_08)
	{
		var_05 = var_05 + var_01.dist2d;
	}

	level.sworddelivery.outerradius = var_05 / 4;
}

//Function Number: 136
delivery_point_sort_from_center(param_00,param_01)
{
	return param_00.dist2d <= param_01.dist2d;
}

//Function Number: 137
sword_delivery_per_player()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_01 = 0;
	if(function_02A3() && var_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"zmShatteredRecord","hasCompletedEESequence"))
	{
		var_01 = 1;
	}

	if(!var_01)
	{
		foreach(var_03 in level.sworddelivery.var_7546)
		{
			if(isdefined(var_03.offent) && var_03.offent.var_1A5 != "circle_point_struct")
			{
				var_03.offent hidefromclient(var_00);
			}

			if(isdefined(var_03.onent) && var_03.onent.var_1A5 != "circle_point_struct")
			{
				var_03.onent hidefromclient(var_00);
			}
		}

		return;
	}

	for(;;)
	{
		var_02.sworddeliverypointsactive = [];
		foreach(var_05 in level.sworddelivery.var_7546)
		{
			if(isdefined(var_05.offent) && var_05.offent.var_1A5 != "circle_point_struct")
			{
				var_05.offent showtoclient(var_02);
			}

			if(isdefined(var_05.onent) && var_05.onent.var_1A5 != "circle_point_struct")
			{
				var_05.onent hidefromclient(var_02);
			}

			var_02 thread sword_delivery_point_watch_buy(var_05);
		}

		var_02 sword_delivery_wait_until_activation();
		var_02 sword_delivery_handle_revive();
		var_02 sword_delivery_wait_until_abandon_sword();
	}
}

//Function Number: 138
sword_delivery_wait_until_abandon_sword()
{
	var_00 = self;
	for(;;)
	{
		var_00 waittill("sword_lost");
		if(isalive(var_00))
		{
			break;
		}
		else
		{
			var_00 waittill("zombie_player_spawn_finished");
			wait 0.05;
			if(!var_00 has_sword())
			{
				break;
			}
		}
	}
}

//Function Number: 139
sword_delivery_point_watch_buy(param_00)
{
	var_01 = self;
	var_01 endon("disconnect");
	for(;;)
	{
		var_01 waittill("money_share_success");
		var_02 = 7 * maps\mp\zombies\_zombies_money::func_467D();
		var_03 = maps\mp\zombies\_zombies_money::func_467F(var_01);
		if(var_03 < var_02)
		{
			continue;
		}

		var_04 = maps\mp\zombies\_zombies_money::getsharedmoneypickupsbyplayer(var_01);
		var_05 = 0;
		var_06 = [];
		foreach(var_0B, var_08 in var_04)
		{
			var_09 = 48;
			if(isdefined(param_00.onent.var_8276))
			{
				var_09 = param_00.onent.var_8276;
			}

			if(isdefined(param_00.offent.var_8276))
			{
				var_09 = param_00.offent.var_8276;
			}

			if(distance(param_00.var_116,var_08.var_116) > var_09)
			{
				continue;
			}

			var_0A = var_08 maps\mp\zombies\_zombies_money::getsharedmoneyinpickupbyplayer(var_01);
			if(var_0A > 0)
			{
				var_06[var_0B] = var_0A;
				var_05 = var_05 + var_0A;
				if(var_05 >= var_02)
				{
					break;
				}
			}
		}

		if(var_05 < var_02)
		{
			continue;
		}

		var_0C = 1;
		foreach(var_0B, var_0E in var_06)
		{
			var_0C = var_0C & var_04[var_0B] maps\mp\zombies\_zombies_money::sharemoneyremoveamountbyplayer(var_01,var_0E);
		}

		break;
	}

	var_01 sword_delivery_point_on_purchase(param_00);
}

//Function Number: 140
sword_delivery_wait_until_activation()
{
	for(var_00 = self;var_00.sworddeliverypointsactive.size < 7;var_00 waittill("sword_delivery_point_activated"))
	{
	}
}

//Function Number: 141
sword_delivery_handle_revive()
{
	var_00 = self;
	var_01 = "zmb_delivery_radius_128";
	if(common_scripts\utility::func_562E(level.sworddelivery_uselargeradius))
	{
		var_01 = "zmb_delivery_radius_256";
	}

	var_02 = spawnfxforclient(common_scripts\utility::func_44F5(var_01),level.sworddelivery.var_206B.var_116,var_00,anglestoforward(level.sworddelivery.var_206B.var_1D),anglestoup(level.sworddelivery.var_206B.var_1D));
	triggerfx(var_02);
	var_00 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_02);
	var_00.mapreviveenabled = 1;
	var_03 = var_00 sword_delivery_revive_wait_for_position();
	var_00 thread sword_delivery_revive();
	if(isdefined(var_02))
	{
		var_02 delete();
	}
}

//Function Number: 142
sword_delivery_revive_wait_for_position()
{
	var_00 = self;
	for(;;)
	{
		if(!lib_0547::func_577E(var_00))
		{
			var_00 waittill("enter_last_stand");
		}

		var_01 = 0;
		var_02 = level.sworddelivery.innerradius;
		if(isdefined(level.sworddelivery_checkradius))
		{
			var_02 = level.sworddelivery_checkradius;
		}

		if(distance2d(var_00.var_116,level.sworddelivery.var_206B.var_116) > var_02)
		{
			var_01 = 1;
		}

		if(!var_01)
		{
			if(abs(var_00.var_116[2] - level.sworddelivery.var_206B.var_116[2]) > 84)
			{
				var_01 = 1;
			}
		}

		if(!var_01)
		{
			break;
		}

		wait(0.2);
	}

	return 1;
}

//Function Number: 143
sword_delivery_revive()
{
	var_00 = self;
	var_00 lib_0553::func_53E2(var_00);
	var_00 lib_0586::func_78C("zom_dlc3_5_zm");
	var_00 thread sword_pull_out_animation();
	if(common_scripts\utility::func_562E(1))
	{
		var_00 thread sword_delivery_after_death();
	}
}

//Function Number: 144
sword_pull_out_animation()
{
	var_00 = self;
	var_00 endon("death");
	var_00 endon("disconnect");
	var_01 = gettime();
	for(;;)
	{
		if(gettime() - var_01 > 5000)
		{
			return;
		}

		if(issubstr(var_00 getcurrentprimaryweapon(),"zom_dlc3_5_zm"))
		{
			return;
		}

		while(var_00 method_833B())
		{
			wait 0.05;
		}

		var_00 lib_0586::func_78E("zom_dlc3_5_zm");
		wait 0.05;
	}
}

//Function Number: 145
sword_delivery_after_death()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_00 endon("sword_lost");
	var_00 notify("sword_delivery_after_death");
	var_00 endon("sword_delivery_after_death");
	for(;;)
	{
		var_00 waittill("zombie_player_spawn_finished");
		var_00 lib_0586::func_78C("zom_dlc3_5_zm");
		var_00 thread sword_pull_out_animation();
	}
}

//Function Number: 146
sword_delivery_point_on_purchase(param_00)
{
	var_01 = self;
	if(isdefined(param_00.offent) && param_00.offent.var_1A5 != "circle_point_struct")
	{
		param_00.offent hidefromclient(var_01);
	}

	if(isdefined(param_00.onent) && param_00.onent.var_1A5 != "circle_point_struct")
	{
		param_00.onent showtoclient(var_01);
	}

	thread sword_delivery_point_purchase_vfx(param_00);
	var_01.sworddeliverypointsactive[param_00.var_D4] = 1;
	var_01 notify("sword_delivery_point_activated");
}

//Function Number: 147
sword_delivery_point_purchase_vfx(param_00)
{
	var_01 = spawnfx(common_scripts\utility::func_44F5("zmb_sword_point_purchase"),param_00.var_116);
	triggerfx(var_01);
	var_01 lib_0378::func_8D74("dlc3_rune_jolt_absorb");
	wait(3);
	var_01 delete();
}

//Function Number: 148
sword_post_ee_complete_handler()
{
	var_00 = common_scripts\utility::func_46B5("sword_spawn_loc","targetname");
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.var_1A2))
	{
		return;
	}

	var_01 = getent(var_00.var_1A2,"targetname");
	var_02 = 0;
	if(function_02A3())
	{
		foreach(var_04 in level.var_744A)
		{
			if(var_04 getrankedplayerdata(common_scripts\utility::func_46A8(),"zmShatteredRecord","hasCompletedEESequence"))
			{
				var_02 = 1;
				break;
			}
		}
	}

	if(!var_02)
	{
		foreach(var_04 in level.var_744A)
		{
			var_01 disableplayeruse(var_04);
		}

		return;
	}

	var_08 = spawn("script_model",var_01.var_116);
	var_08.var_1D = var_00.var_1D;
	var_08 setmodel("npc_zom_barb_sword_02");
	var_08 method_805C();
	foreach(var_04 in level.var_744A)
	{
		var_0A = var_04 getrankedplayerdata(common_scripts\utility::func_46A8(),"zmShatteredRecord","hasCompletedEESequence");
		if(var_0A)
		{
			var_01 disableplayeruse(var_04);
			var_08 showtoclient(var_04);
			var_01 enableplayeruse(var_04);
			var_01 usetouchtriggerrequirefacingposition(1,var_00.var_116);
			var_01 sethintstring(&"ZOMBIE_DLC3_PICKUP_SWORD");
			level thread sword_post_ee_complete_trig_think(var_01,var_00,var_04);
			continue;
		}

		var_01 disableplayeruse(var_04);
	}
}

//Function Number: 149
sword_post_ee_complete_trig_think(param_00,param_01,param_02)
{
	param_02 endon("disconnect");
	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(var_03 != param_02)
		{
			continue;
		}

		if(lib_0547::func_73F9(var_03,"zom_dlc3_5_zm"))
		{
			continue;
		}

		var_03 lib_0378::func_8D74("aud_pickup_barbarosa_sword",param_01.var_116);
		var_03.special_melee_weapon = "zom_dlc3_5_zm";
		var_03 lib_0586::func_78C("zom_dlc3_5_zm");
		var_03 thread sword_pull_out_animation();
	}
}