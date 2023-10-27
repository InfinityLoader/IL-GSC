/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_weapon.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 221
 * Decompile Time: 10410 ms
 * Timestamp: 10/27/2023 12:10:13 AM
*******************************************************************/

//Function Number: 1
func_13CCB()
{
	level.var_B4BA = max(scripts\cp\_utility::func_7F1D("scr_maxPerPlayerExplosives",2),4);
	level.var_E55D = scripts\cp\_utility::func_7F1D("scr_riotShieldXPBullets",15);
	level.var_31CF = ::func_E469;
	level.var_13C7D = [];
	level.var_13BE7 = 0;
	level.var_13CAD = 0;
	level.var_5AFD = 0;
	level.var_13C9D = 0;
	func_31D5();
	func_BD67();
	func_9802();
	func_FACC();
	func_FA9D();
	level thread func_C56E();
	func_A033();
	scripts\common\utility::array_thread(getentarray("misc_turret","classname"),::func_12A13);
}

//Function Number: 2
heart_power_init()
{
	scripts\common\utility::flag_wait("interactions_initialized");
	scripts\cp\powers\coop_powers::func_D787("power_heart",::powerheartset,::takeheart,undefined,undefined,"heart_used",undefined);
}

//Function Number: 3
eye_power_init()
{
	scripts\common\utility::flag_wait("interactions_initialized");
	scripts\cp\powers\coop_powers::func_D787("power_rat_king_eye",::powereyeset,::takerateye,::eye_activated,undefined,undefined,undefined);
}

//Function Number: 4
powerheartset(param_00)
{
	self.has_heart = 1;
}

//Function Number: 5
powereyeset(param_00)
{
	self.has_eye = 1;
}

//Function Number: 6
func_2B53(param_00)
{
}

//Function Number: 7
func_9802()
{
	level._effect["weap_blink_friend"] = loadfx("vfx/core/mp/killstreaks/vfx_detonator_blink_cyan.vfx");
	level._effect["weap_blink_enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_detonator_blink_cyan.vfx");
	level._effect["emp_stun"] = loadfx("vfx/core/mp/equipment/vfx_emp_grenade");
	level._effect["equipment_explode_big"] = loadfx("vfx/core/mp/killstreaks/vfx_ims_explosion");
	level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
	level._effect["equipment_sparks"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion.vfx");
	level.var_A6D2["spark"] = loadfx("vfx/iw7/_requests/mp/vfx_kinetic_pulse_shock");
	level._effect["gas_grenade_smoke_enemy"] = loadfx("vfx/old/_requests/mp_weapons/vfx_poison_gas_enemy");
	level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
	level._effect["placeEquipmentFailed"] = loadfx("vfx/core/mp/killstreaks/vfx_ballistic_vest_death");
	level._effect["penetration_railgun_explosion"] = loadfx("vfx/iw7/core/expl/weap/chargeshot/vfx_expl_chargeshot.vfx");
}

//Function Number: 8
func_FACC()
{
	var_00 = 70;
	level.var_4023 = cos(var_00);
	level.var_4025 = 20;
	level.var_4024 = 0.75;
	level.var_4027 = 192;
	level.var_B76D = 0.3;
	level.var_B76F = 150;
	level.var_B76E = 20;
	level.var_B76B = 256;
	level.var_B769 = 600;
	level.var_B768 = 1200;
	level.var_B766 = 300;
	level.var_B77B = 600;
	level.var_B762 = loadfx("vfx/core/impacts/bouncing_betty_launch_dirt");
	level.var_B761 = loadfx("vfx/core/expl/bouncing_betty_explosion.vfx");
	level.var_5113 = 1.5;
	level.var_334B = 0;
	level.var_B779 = [];
}

//Function Number: 9
func_FA9D()
{
	var_00 = spawnstruct();
	var_00.var_B760["enemy"] = loadfx("vfx/core/equipment/light_c4_blink.vfx");
	var_00.var_B760["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
	level.var_13C7D["c4_zm"] = var_00;
	var_00 = spawnstruct();
	var_00.model = "prop_mp_speed_strip_temp";
	var_00.var_2C68 = "prop_mp_speed_strip_temp";
	var_00.var_226E = 0.05;
	var_00.var_13370 = "tag_origin";
	var_00.var_B769 = 0;
	var_00.var_B768 = 0;
	var_00.var_C5B4 = "motion_click";
	var_00.var_C54C = "motion_spin";
	var_00.var_C525 = "motion_explode_default";
	var_00.var_AAB0 = 64;
	var_00.var_AAB7 = 0.65;
	var_00.var_C5B3 = ::lib_0D04::func_2B41;
	var_00.var_C524 = ::lib_0D04::func_2B40;
	var_00.var_8C7A = 20;
	var_00.var_B76F = 200;
	var_00.var_B76E = 100;
	level.var_13C7D["blackhole_grenade_mp"] = var_00;
	level.var_13C7D["blackhole_grenade_zm"] = var_00;
	var_00 = spawnstruct();
	var_00.var_217C = 1.5;
	var_00.var_53B6 = 232;
	var_00.var_53B5 = 512;
	var_00.var_53B4 = 1;
	var_00.var_8C7A = 20;
	var_00.var_A640 = 12;
	level.var_13C7D["proximity_explosive_mp"] = var_00;
	var_00 = spawnstruct();
	var_01 = 800;
	var_02 = 200;
	var_00.var_DC05 = var_01 * var_01;
	var_00.var_DC06 = var_02 * var_02;
	var_00.var_C525 = "flashbang_explode_default";
	var_00.var_1336F = 72;
	level.var_13C7D["flash_grenade_mp"] = var_00;
}

//Function Number: 10
func_A033()
{
	lib_0D14::func_D687();
	scripts\cp\_blackholegun::init();
	func_42DC();
	func_11819();
}

//Function Number: 11
func_11819()
{
	level._effect["throwingknifec4_explode"] = loadfx("vfx/iw7/_requests/mp/power/vfx_bio_spike_exp.vfx");
}

//Function Number: 12
func_42DC()
{
	level._effect["clusterGrenade_explode"] = loadfx("vfx/iw7/_requests/mp/vfx_cluster_gren_single_runner.vfx");
}

//Function Number: 13
func_BD67()
{
	var_00 = ["mp/statstable.csv","cp/zombies/mode_string_tables/zombies_statstable.csv"];
	level.var_13CA5 = [];
	foreach(var_02 in var_00)
	{
		for(var_03 = 1;tablelookup(var_02,0,var_03,0) != "";var_03++)
		{
			var_04 = tablelookup(var_02,0,var_03,4);
			if(var_04 != "")
			{
				level.var_13CA5[var_04] = spawnstruct();
				var_05 = tablelookup(var_02,0,var_03,0);
				if(var_05 != "")
				{
					level.var_13CA5[var_04].var_C211 = var_05;
				}

				var_06 = tablelookup(var_02,0,var_03,1);
				if(var_06 != "")
				{
					level.var_13CA5[var_04].var_8677 = var_06;
				}

				var_07 = tablelookup(var_02,0,var_03,5);
				if(var_07 != "")
				{
					level.var_13CA5[var_04].var_CA2E = var_07;
				}

				var_08 = tablelookup(var_02,0,var_03,9);
				if(var_08 != "")
				{
					if(isdefined(level.var_13CA5[var_04].var_2476))
					{
						if(level.var_13CA5[var_04].var_2476 == "none")
						{
							level.var_13CA5[var_04].var_2476 = undefined;
						}
						else
						{
							level.var_13CA5[var_04].var_2476 = strtok(var_08," ");
						}
					}
					else
					{
						level.var_13CA5[var_04].var_2476 = strtok(var_08," ");
					}
				}

				level.var_13CA5[var_04].var_F1A8 = [];
				level.var_13CA5[var_04].var_F1A9 = [];
				for(var_09 = 0;var_09 < 20;var_09++)
				{
					var_0A = tablelookup(var_02,0,var_03,10 + var_09);
					if(isdefined(var_0A) && var_0A != "")
					{
						var_0B = level.var_13CA5[var_04].var_F1A8.size;
						level.var_13CA5[var_04].var_F1A8[var_0B] = var_0A;
						level.var_13CA5[var_04].var_F1A9[var_0A] = 1;
					}
				}

				var_0C = tablelookup(var_02,0,var_03,8);
				if(var_0C != "")
				{
					var_0C = float(var_0C);
					level.var_13CA5[var_04].var_2B3 = var_0C;
				}
			}
		}
	}
}

//Function Number: 14
func_3223()
{
	var_00 = "mp/statstable.csv";
	var_01 = level.var_7666;
	level.var_13CA3 = [];
	level.var_13CA2 = [];
	level.var_13CA4 = [];
	var_02 = 0;
	var_03 = 1;
	var_04 = 1;
	while(var_03 || var_04)
	{
		if(tablelookup(var_00,0,var_02,0) == "")
		{
			var_03 = 0;
		}

		var_05 = tablelookup(var_00,0,var_02,4);
		var_06 = tablelookup(var_00,0,var_02,5);
		if(var_06 != "")
		{
			if(var_05 != "")
			{
				level.var_13CA3[var_05] = var_06;
			}
		}

		var_07 = tablelookup(var_00,0,var_02,9);
		if(var_07 != "")
		{
			if(var_05 != "")
			{
				level.var_13CA2[var_05] = strtok(var_07," ");
			}
		}

		var_08 = tablelookup(var_00,0,var_02,8);
		if(var_08 != "")
		{
			if(var_05 != "")
			{
				var_08 = float(var_08);
				level.var_13CA4[var_05] = float(var_08);
			}
		}

		if(var_04)
		{
			if(tablelookup(var_01,0,var_02,0) == "")
			{
				var_04 = 0;
			}

			var_05 = tablelookup(var_01,0,var_02,4);
			var_06 = tablelookup(var_01,0,var_02,5);
			if(var_06 != "")
			{
				if(var_05 != "")
				{
					level.var_13CA3[var_05] = var_06;
				}
			}

			var_07 = tablelookup(var_01,0,var_02,9);
			if(var_07 != "")
			{
				if(var_05 != "")
				{
					level.var_13CA2[var_05] = strtok(var_07," ");
				}
			}

			var_08 = tablelookup(var_01,0,var_02,8);
			if(var_08 != "")
			{
				if(var_05 != "")
				{
					var_08 = float(var_08);
					level.var_13CA4[var_05] = float(var_08);
				}
			}
		}

		var_02++;
	}
}

//Function Number: 15
func_B77C()
{
	self playsound(self.var_451C.var_C54C);
	playfx(self.var_451C.var_AABB,self.origin);
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	self method_8187("tag_sensor");
	func_11061();
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00 setmodel(self.var_451C.model);
	var_00 method_8187("tag_base");
	var_00.var_451C = self.var_451C;
	self.var_F232 = var_00;
	var_01 = self.origin + (0,0,self.var_451C.var_AAB0);
	var_02 = self.var_451C.var_AAB7;
	var_03 = self.var_451C.var_AAB7 + 0.1;
	var_00 moveto(var_01,var_03,0,var_02);
	var_00 rotatevelocity((0,1100,32),var_03,0,var_02);
	var_00 thread func_D537();
	wait(var_02);
	self notify("detonateExplosive");
}

//Function Number: 16
func_D537()
{
	if(isdefined(self.var_451C.var_B763))
	{
		self endon("death");
		var_00 = gettime() + 1000;
		while(gettime() < var_00)
		{
			wait(0.05);
			playfxontag(self.var_451C.var_B763,self,"tag_fx_spin1");
			playfxontag(self.var_451C.var_B763,self,"tag_fx_spin3");
			wait(0.05);
			playfxontag(self.var_451C.var_B763,self,"tag_fx_spin2");
			playfxontag(self.var_451C.var_B763,self,"tag_fx_spin4");
		}
	}
}

//Function Number: 17
func_B764()
{
	self playsound(self.var_451C.var_C54C);
	playfx(level.var_B762,self.origin);
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	var_00 = self.origin + (0,0,64);
	self moveto(var_00,0.7,0,0.65);
	self.var_A63A moveto(var_00 + self.var_A640,0.7,0,0.65);
	self rotatevelocity((0,750,32),0.7,0,0.65);
	thread func_D537();
	wait(0.65);
	self notify("detonateExplosive");
}

//Function Number: 18
func_12A13()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		thread func_12A1F(var_00);
	}
}

//Function Number: 19
func_12A1F(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 notify("weapon_change","none");
	self waittill("turret_deactivate");
	param_00 notify("weapon_change",param_00 getcurrentweapon());
}

//Function Number: 20
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_9042 = 0;
		var_00 thread func_C57B();
		var_00 thread func_13AD5();
		var_00 thread func_103B4();
	}
}

//Function Number: 21
giverateye(param_00)
{
	self.has_eye = 1;
	thread eye_activated(self);
}

//Function Number: 22
takerateye(param_00)
{
	self.has_eye = undefined;
	self notify("remove_eye");
}

//Function Number: 23
eye_activated(param_00)
{
	self.wearing_rat_king_eye = 1;
	level notify("rat_king_eye_activated",self);
	if(scripts\common\utility::func_6E34("rk_fight_started") && !scripts\common\utility::flag("rk_fight_started"))
	{
		thread handleratvisionburst(self);
		self setscriptablepartstate("rat_king_eye_light","active");
		thread reapply_visionset_after_host_migration();
		thread watch_for_eye_remove();
	}
}

//Function Number: 24
reapply_visionset_after_host_migration()
{
	self endon("death");
	self endon("disconnect");
	self endon("removing_eye_from_player");
	level waittill("host_migration_begin");
	level waittill("host_migration_end");
	if(scripts\common\utility::istrue(self.wearing_rat_king_eye))
	{
		self setscriptablepartstate("rat_king_eye_light","active");
	}
}

//Function Number: 25
watch_for_eye_remove()
{
	self notify("watch_for_eye_remove");
	self endon("watch_for_eye_remove");
	wait(5);
	if(scripts\common\utility::istrue(self.wearing_rat_king_eye))
	{
		remove_eye_effects();
	}
}

//Function Number: 26
remove_eye_effects()
{
	self.wearing_rat_king_eye = 0;
	level notify("rat_king_eye_deactivated");
	self notify("remove_eye");
	if(isdefined(level.var_13445))
	{
		self visionsetnakedforplayer(level.var_13445,0.1);
	}
	else
	{
		self visionsetnakedforplayer("",0.1);
	}

	self setscriptablepartstate("rat_king_eye_light","neutral");
}

//Function Number: 27
func_103B4()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = undefined;
	for(;;)
	{
		self waittill("weapon_fired");
		if(self getstance() != "prone")
		{
			continue;
		}

		if(scripts\cp\_utility::func_4626(self getcurrentweapon()) != "weapon_sniper")
		{
			continue;
		}

		var_01 = anglestoforward(self.angles);
		if(!isdefined(var_00) || gettime() - var_00 > 2000)
		{
			var_00 = gettime();
			continue;
		}
	}
}

//Function Number: 28
unset_scriptable_part_state_after_time(param_00,param_01)
{
	self endon("death");
	wait(param_00);
	self setscriptablepartstate("projectile","inactive");
	param_01 notify("ranged_katana_missile_done");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 29
func_13AD5()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = func_137A6();
		switch(var_00.var_13C2E)
		{
			case "remotemissile_projectile_mp":
				var_00 thread func_858A();
				break;
	
			case "iw7_harpoon_zm":
				break;
	
			case "iw7_harpoon3_zm":
				var_00 thread runharpoontraplogic(var_00,self);
				break;
	
			case "iw7_blackholegun_mp":
				var_00 thread scripts\cp\_blackholegun::func_B8B1(var_00.var_13C2E,var_00);
				break;
	
			case "iw7_harpoon1_zm":
				var_00.var_222 thread alt_acid_rain_dud_explode(var_00);
				break;
	
			case "iw7_harpoon4_zm":
				var_00.var_222 thread thundergun_harpoon_dud_explode(var_00);
				var_00.var_222 thread thundergun_harpoon(var_00.var_13C2E,var_00);
				break;
	
			case "iw7_harpoon2_zm":
				var_00.var_222 thread ben_franklin_harpoon_dud_explode(var_00);
				var_00.var_222 thread ben_franklin_harpoon(var_00);
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 30
ben_franklin_harpoon_activate(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_03 = level._effect["hammer_of_dawn_lightning"];
	level notify("ben_franklin_lightning_pos",param_00);
	playfx(var_03,param_00,anglestoforward(self.angles),anglestoup(self.angles));
	playsoundatpos(param_00,"harpoon2_impact");
	thread run_stun_logic(param_00,param_01,param_02,var_03);
}

//Function Number: 31
run_stun_logic(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("disconnected");
	level endon("game_ended");
	var_04 = anglestoforward(self.angles);
	var_04 = vectornormalize(var_04);
	var_04 = var_04 * 100;
	var_05 = -1 * var_04;
	var_06 = function_02D3(self.angles);
	var_06 = vectornormalize(var_06);
	var_06 = var_06 * 100;
	var_07 = -1 * var_06;
	if(isdefined(param_01))
	{
		param_01.nocorpse = 1;
		param_01.full_gib = 1;
	}

	var_08 = "reload_zap_screen";
	var_09 = max(1000,0.5 * param_02);
	self radiusdamage(param_00,128,var_09,var_09,self,"MOD_GRENADE_SPLASH","iw7_harpoon2_zm_stun");
	scripts\common\utility::func_136F7();
	if(distance2dsquared(self.origin,param_00) <= 16384)
	{
		playfxontagforclients(level._effect[var_08],self,"tag_eye",self);
	}

	wait(0.25);
	var_0A = scripts\cp\_agent_utils::func_7DB0("axis");
	var_0B = 65536;
	var_08 = "reload_zap_m";
	foreach(var_0D in var_0A)
	{
		if(var_0D.agent_type == "slasher" || var_0D.agent_type == "superslasher")
		{
			continue;
		}

		if(distancesquared(var_0D.origin,param_00) < var_0B)
		{
			var_0E = var_0D gettagorigin("j_spineupper");
			var_0D thread func_13E63(1,self);
			playfx(param_03,var_0D.origin);
		}
	}

	if(isdefined(level.played_ben_franklin_effect))
	{
		level.played_ben_franklin_effect = undefined;
	}
}

//Function Number: 32
play_stun_fx(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "reload_zap_m";
	playsoundatpos(param_04,"perk_blue_bolts_sparks");
	playfx(level._effect[var_05],param_04 + param_00);
	scripts\common\utility::func_136F7();
	playfx(level._effect[var_05],param_04 + param_01);
	scripts\common\utility::func_136F7();
	playfx(level._effect[var_05],param_04 + param_02);
	scripts\common\utility::func_136F7();
	playfx(level._effect[var_05],param_04 + param_03);
	scripts\common\utility::func_136F7();
}

//Function Number: 33
func_13E63(param_00,param_01)
{
	self endon("death");
	self.var_11196 = 1;
	thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
	while(param_00 > 0)
	{
		self.var_11190 = gettime() + 1500;
		wait(0.1);
		self dodamage(1,self.origin,param_01,param_01,"MOD_GRENADE_SPLASH","iw7_harpoon2_zm_stun");
		param_00 = param_00 - 1;
		wait(1.5);
	}

	self.var_11196 = undefined;
}

//Function Number: 34
ben_franklin_harpoon_dud_explode(param_00)
{
	self endon("disconnect");
	self endon("death");
	param_00 waittill("death");
	if(isdefined(param_00.origin))
	{
		thread ben_franklin_harpoon_activate(param_00.origin,undefined,500000000);
	}

	self notify("remove_this_function_since_you_missed_zomb");
}

//Function Number: 35
ben_franklin_harpoon(param_00)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self endon("remove_this_function_since_you_missed_zomb");
	self waittill("zombie_hit_by_ben",var_01,var_02,var_03);
	thread ben_franklin_harpoon_activate(var_01,var_02,var_03);
}

//Function Number: 36
thundergun_harpoon_dud_explode(param_00)
{
	self endon("disconnect");
	self endon("death");
	param_00 waittill("death");
	var_01 = param_00.origin;
	if(isdefined(param_00.origin))
	{
		var_02 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_03 = 160000;
		foreach(var_05 in var_02)
		{
			if(!isdefined(var_05))
			{
				continue;
			}

			if(!isdefined(var_05.agent_type))
			{
				continue;
			}

			if(distancesquared(var_05.origin,var_01) < var_03)
			{
				var_05.do_immediate_ragdoll = 1;
				var_05.disable_armor = 1;
				var_05.var_4C87 = 1;
				playsoundatpos(var_05.origin,"perk_blue_bolts_sparks");
				var_06 = anglestoforward(self.angles);
				var_07 = vectornormalize(var_06) * -100;
				if(isdefined(var_05.agent_type) && var_05.agent_type != "slasher" && var_05.agent_type != "superslasher")
				{
					var_05 setvelocity(vectornormalize(var_05.origin - self.origin + var_07) * 800 + (200,0,200));
				}

				wait(0.2);
				var_05.nocorpse = 1;
				var_05.full_gib = 1;
				if(isdefined(var_05.agent_type) && var_05.agent_type == "slasher" || var_05.agent_type == "superslasher")
				{
					var_05 dodamage(var_05.health,var_05.origin,self,self,"MOD_UNKNOWN","iw7_harpoon4_zm");
				}
				else
				{
					var_05 dodamage(var_05.health + 1000,var_05.origin,self,self,"MOD_UNKNOWN","iw7_harpoon4_zm");
				}
			}
		}
	}

	self notify("remove_this_function_since_you_missed_zomb");
}

//Function Number: 37
fling_zombie_thundergun_harpoon(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_03 endon("death");
	if(!isdefined(param_03))
	{
		return;
	}

	param_03.angles = vectortoangles(param_01.origin - param_03.origin) + (0,0,180);
	var_04 = param_01.origin - param_03.origin;
	var_05 = anglestoforward(param_02.angles);
	var_06 = vectornormalize(var_05) * -100;
	self setvelocity(vectornormalize(self.origin - param_02.origin + var_06) * 800 + (200,0,200));
	wait(0.16);
	if(isdefined(param_02))
	{
		param_01.do_immediate_ragdoll = 1;
		param_01.disable_armor = 1;
		param_01.var_4C87 = 1;
		wait(0.1);
		param_01.nocorpse = 1;
		param_01.full_gib = 1;
		self dodamage(self.health + 1000,param_01.origin,param_02,param_02,"MOD_UNKNOWN","iw7_harpoon4_zm");
		return;
	}

	self.nocorpse = 1;
	self.full_gib = 1;
	self dodamage(self.health + 1000,param_01.origin,param_01,param_01,"MOD_UNKNOWN","iw7_harpoon4_zm");
}

//Function Number: 38
thundergun_harpoon(param_00,param_01)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self endon("remove_this_function_since_you_missed_zomb");
	var_02 = 256;
	var_03 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_04 = self.angles;
	var_05 = self geteye();
	while(isdefined(param_01))
	{
		var_06 = scripts\common\utility::func_782F(param_01.origin,var_03,undefined,24,var_02);
		self.closestenemies = var_06;
		var_07 = 0;
		foreach(var_09 in self.closestenemies)
		{
			if(!isdefined(var_09.agent_type))
			{
				continue;
			}

			if(isdefined(param_01))
			{
				if(distance2dsquared(param_01.origin,var_09.origin) < 16384)
				{
					if(isdefined(var_09.agent_type) && var_09.agent_type == "slasher" || var_09.agent_type == "superslasher")
					{
						var_09 dodamage(var_09.health,var_09.origin,self,self,"MOD_UNKNOWN","iw7_harpoon4_zm");
					}
					else
					{
						var_09 thread fling_zombie_thundergun_harpoon(var_09.health + 1000,var_09,self,param_01);
					}

					scripts\common\utility::func_136F7();
				}
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 39
alt_acid_rain_dud_explode(param_00)
{
	self endon("disconnect");
	self endon("death");
	var_01 = scripts\common\trace::func_48BC(0,1,1,1,1,0,1);
	var_02 = param_00.angles;
	var_03 = param_00.origin;
	param_00 waittill("death");
	if(!isdefined(param_00.origin))
	{
		return;
	}

	playfx(level._effect["acid_rain_explosion"],param_00.origin);
	scripts\common\utility::func_136F7();
	playfx(level._effect["acid_rain"],param_00.origin);
	var_04 = gettime();
	var_05 = param_00.origin;
	var_06 = spawn("trigger_radius",param_00.origin,0,128,64);
	var_06 thread deal_damage_to_enemies(self,var_04);
	var_06 thread delete_after_time(self,var_04);
}

//Function Number: 40
delete_after_time(param_00,param_01)
{
	param_00 endon("death");
	self endon("death");
	while(gettime() <= param_01 + 3400)
	{
		scripts\common\utility::func_136F7();
	}

	if(isdefined(level.played_acid_rain_effect))
	{
		level.played_acid_rain_effect = undefined;
	}

	self delete();
}

//Function Number: 41
deal_damage_to_enemies(param_00,param_01)
{
	param_00 endon("death");
	self endon("death");
	while(gettime() <= param_01 + 3400)
	{
		self waittill("trigger",var_02);
		if(!isdefined(var_02))
		{
			continue;
		}

		if(!var_02 scripts\cp\_utility::func_9D20())
		{
			continue;
		}

		if(isdefined(param_00))
		{
			if(var_02.agent_type == "slasher" || var_02.agent_type == "superslasher")
			{
				var_02 dodamage(0.1 * var_02.maxhealth,var_02.origin,param_00,param_00,"MOD_RIFLE_BULLET","iw7_harpoon1_zm");
			}
			else
			{
				playfx(level._effect["acid_rain"],var_02.origin);
				var_02 dodamage(var_02.maxhealth,var_02.origin,param_00,param_00,"MOD_RIFLE_BULLET","iw7_harpoon1_zm");
			}

			continue;
		}

		var_02 dodamage(var_02.maxhealth,var_02.origin,undefined,undefined,"MOD_RIFLE_BULLET","iw7_harpoon1_zm");
	}
}

//Function Number: 42
func_137A6()
{
	self waittill("missile_fire",var_00,var_01);
	if(isdefined(var_00))
	{
		if(!isdefined(var_00.var_13C2E))
		{
			var_02 = getweaponbasename(var_01);
			if(isdefined(var_02))
			{
				var_00.var_13C2E = var_02;
			}
			else
			{
				var_00.var_13C2E = var_01;
			}
		}

		if(!isdefined(var_00.var_222))
		{
			var_00.var_222 = self;
		}

		if(!isdefined(var_00.team))
		{
			var_00.team = self.team;
		}
	}

	return var_00;
}

//Function Number: 43
runharpoontraplogic(param_00,param_01)
{
	param_00 endon("death");
	param_00 waittill("missile_stuck",var_02);
	var_03 = param_00.origin;
	var_04 = param_00.angles;
	var_05 = vectornormalize(anglestoforward(var_04));
	var_06 = vectornormalize(anglestoright(var_04));
	var_07 = vectorcross(var_05,var_06);
	param_00.angles = vectortoangles(var_07);
	var_08 = 3 * anglestoforward(param_00.angles);
	param_00.origin = param_00.origin + var_08;
	playsoundatpos(param_00.origin,"weap_harpoon3_impact");
	wait(0.5);
	param_00 setscriptablepartstate("arrow_effects","active");
	level.harpoon_projectiles[level.harpoon_projectiles.size] = param_00;
	if(level.harpoon_projectiles.size >= 6)
	{
		thread destroy_oldest_trap();
	}

	param_00.linked_to_targets = [];
	param_00.var_AD1F = [];
	param_00.death_time = gettime() + 9000;
	param_00 thread connect_to_nearby_harpoon_projectiles(param_00,param_01);
	param_00 thread timeout_trap(param_00,param_01);
}

//Function Number: 44
destroy_oldest_trap()
{
	var_00 = level.harpoon_projectiles[0];
	var_00 notify("early_death");
	var_00 clean_up_trap_ent(var_00,var_00.origin);
}

//Function Number: 45
timeout_trap(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("early_death");
	wait(9.95);
	var_02 = param_00.origin;
	wait(0.05);
	param_00 clean_up_trap_ent(param_00,var_02);
}

//Function Number: 46
clean_up_trap_ent(param_00,param_01)
{
	if(scripts\common\utility::func_2286(level.harpoon_projectiles,param_00))
	{
		level.harpoon_projectiles = scripts\common\utility::func_22A9(level.harpoon_projectiles,param_00);
	}

	level.harpoon_projectiles = scripts\common\utility::func_22BC(level.harpoon_projectiles);
	var_02 = spawnfx(scripts\common\utility::getfx("placeEquipmentFailed"),param_01);
	triggerfx(var_02);
	playsoundatpos(param_01,"weap_harpoon3_trap_off");
	thread func_CC17(var_02);
	param_00 delete();
}

//Function Number: 47
connect_to_nearby_harpoon_projectiles(param_00,param_01)
{
	param_00 endon("death");
	var_02 = scripts\common\trace::func_497D();
	for(;;)
	{
		var_03 = [];
		var_04 = scripts\common\utility::func_782F(param_00.origin,level.harpoon_projectiles,[param_00],2,128);
		clean_up_links(param_00,var_04);
		foreach(var_06 in var_04)
		{
			if(scripts\common\utility::func_2286(param_00.linked_to_targets,var_06))
			{
				continue;
			}

			if(scripts\common\utility::func_2286(var_06.linked_to_targets,param_00))
			{
				continue;
			}

			var_07 = scripts\common\trace::func_DCED(param_00 gettagorigin("TAG_FX"),var_06 gettagorigin("TAG_FX"),param_00,var_02);
			if(var_07["fraction"] < 0.95)
			{
				continue;
			}
			else
			{
				var_03[var_03.size] = var_06;
				param_00.linked_to_targets[param_00.linked_to_targets.size] = var_06;
			}
		}

		foreach(var_0A in var_03)
		{
			param_00.var_AD1F[var_0A.var_64] = var_0A;
			var_0B = distance(param_00.origin,var_0A.origin);
			var_0C = spawn("trigger_rotatable_radius",param_00 gettagorigin("TAG_FX"),0,3,var_0B);
			var_0D = vectortoangles(var_0A gettagorigin("TAG_FX") - param_00 gettagorigin("TAG_FX")) + (-90,0,0);
			var_0C.angles = (90,var_0D[1],var_0D[2]);
			param_00 thread play_vfx_between_points_trap_gun(param_00,var_0A,var_0C);
			param_00 thread damage_enemies_in_trigger(var_0A,param_00,var_0C,param_01);
			thread clean_up_trigger_on_death(var_0A,param_00,var_0C);
		}

		wait(1);
	}
}

//Function Number: 48
play_vfx_between_points_trap_gun(param_00,param_01,param_02)
{
	var_03 = function_02DF(level._effect["trap_ww_beam"],param_00,"tag_fx",param_01,"tag_fx");
	thread kill_fx_on_death(param_00,param_01,param_02,var_03);
}

//Function Number: 49
kill_fx_on_death(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	var_04 = param_00.origin;
	var_05 = param_00 gettagorigin("TAG_FX");
	var_06 = param_01 gettagorigin("TAG_FX");
	var_07 = max(param_01.death_time - gettime() / 1000,0);
	var_08 = max(param_00.death_time - gettime() / 1000 - var_07 - 0.2,0);
	thread play_sfx_on_harpoon_trap(param_00,param_01,param_02);
	if(var_07 > 0 && isdefined(param_00) && isdefined(param_01))
	{
		scripts\cp\_utility::func_1372C(var_07,param_00,"death",param_01,"death",param_02,"death");
	}
	else if(isdefined(param_00) && isdefined(param_01))
	{
		scripts\common\utility::func_1372B(param_00,"death",param_01,"death",param_02,"death");
	}

	if(isdefined(param_03))
	{
		param_03 delete();
	}

	function_02E0(level._effect["trap_ww_beam_death"],var_05,vectortoangles(var_06 - var_05),var_06);
}

//Function Number: 50
play_sfx_on_harpoon_trap(param_00,param_01,param_02)
{
	var_03 = param_00.origin;
	var_04 = param_01 gettagorigin("TAG_FX");
	var_05 = [];
	var_05[0] = var_03;
	var_05[1] = var_04;
	var_06 = max(param_01.death_time - gettime() / 1000,0);
	var_07 = averagepoint(var_05);
	playsoundatpos(var_07,"weap_harpoon3_trap_on");
	var_08 = spawn("script_origin",var_07);
	wait(0.05);
	var_08 playloopsound("weap_harpoon3_trap_lp");
	if(var_06 > 0 && isdefined(param_00) && isdefined(param_01))
	{
		scripts\cp\_utility::func_1372C(var_06,param_00,"death",param_01,"death",param_02,"death");
	}
	else if(isdefined(param_00) && isdefined(param_01))
	{
		scripts\common\utility::func_1372B(param_00,"death",param_01,"death",param_02,"death");
	}

	wait(1);
	var_08 stoploopsound("weap_harpoon3_trap_lp");
	wait(0.05);
	var_08 delete();
}

//Function Number: 51
damage_enemies_in_trigger(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_02 endon("death");
	param_00 endon("death");
	param_01 endon("death");
	for(;;)
	{
		param_02 waittill("trigger",var_04);
		if(!var_04 scripts\cp\_utility::func_9D20())
		{
			continue;
		}

		if(var_04.agent_type == "slasher" || var_04.agent_type == "superslasher")
		{
			if(scripts\common\utility::istrue(var_04.got_hit_once))
			{
				continue;
			}
			else
			{
				var_04 thread do_damage_on_slasher_once(var_04,param_03);
			}
		}

		thread run_harpoon_laser_death(var_04,param_03);
	}
}

//Function Number: 52
do_damage_on_slasher_once(param_00,param_01)
{
	param_00 endon("death");
	level endon("game_ended");
	param_00.got_hit_once = 1;
	if(param_00.agent_type == "superslasher")
	{
		wait(5);
	}
	else
	{
		wait(2);
	}

	param_00.got_hit_once = undefined;
}

//Function Number: 53
run_harpoon_laser_death(param_00,param_01)
{
	param_00.atomize_me = 1;
	param_00.not_killed_by_headshot = 1;
	if(isdefined(param_01))
	{
		param_00 dodamage(param_00.health,param_00.origin,param_01,param_01,"MOD_UNKNOWN","iw7_harpoon3_zm");
		return;
	}

	param_00 dodamage(param_00.health,param_00.origin,undefined,undefined,"MOD_UNKNOWN","iw7_harpoon3_zm");
}

//Function Number: 54
clean_up_trigger_on_death(param_00,param_01,param_02)
{
	level endon("game_ended");
	scripts\common\utility::func_1372B(param_00,"death",param_01,"death");
	if(isdefined(param_02))
	{
		param_02 delete();
	}
}

//Function Number: 55
clean_up_links(param_00,param_01)
{
	param_00.linked_to_targets = scripts\common\utility::func_22BC(param_00.linked_to_targets);
	foreach(var_03 in param_00.linked_to_targets)
	{
		if(isdefined(param_00.var_AD1F[var_03.var_64]))
		{
			param_00.var_AD1F[var_03.var_64] = undefined;
		}

		if(!scripts\common\utility::func_2286(param_01,var_03) && scripts\common\utility::func_2286(param_00.linked_to_targets,var_03))
		{
			param_00.linked_to_targets = scripts\common\utility::func_22A9(param_00.linked_to_targets,var_03);
		}
	}
}

//Function Number: 56
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.var_4C16 = self getcurrentweapon();
		self.var_61A0 = 0;
		self.var_44ED = 0;
		self.var_9042 = 0;
		if(!isdefined(self.var_11AF0))
		{
			self.var_11AF0 = "";
			self.var_11AF0 = "none";
			self.var_11AF1 = 0;
			self.var_11AEF = 0;
			self.var_11AEE = 0;
			self.var_11AED = 0;
			self.var_11AEC = 0;
		}

		thread func_13A9B();
		thread func_10B5E();
		self.var_A99F = [];
		self.var_5D39 = undefined;
		self.var_119DF = [];
		thread func_12F0A();
		thread func_13A7F();
		thread watch_slasher_killed();
		thread func_B9EC();
		self.var_4C16 = undefined;
		self.var_12839 = undefined;
	}
}

//Function Number: 57
func_B9EC()
{
	self endon("disconnect");
	self endon("death");
	self endon("faux_spawn");
	for(;;)
	{
		var_00 = func_1377A();
		if(isdefined(var_00.var_13C2E))
		{
			if(func_83F3(var_00.var_13C2E) == "stickglprox")
			{
				func_F21A(var_00);
			}

			if(issubstr(var_00.var_13C2E,"iw7_venomx_zm"))
			{
				if(isdefined(level.venom_x_weapon_logic_thread))
				{
					level thread [[ level.venom_x_weapon_logic_thread ]](var_00);
				}
			}
		}
	}
}

//Function Number: 58
func_83F3(param_00)
{
	if(param_00 != "none" && getweaponbasename(param_00) == "iw7_glprox_mp")
	{
		if(scripts\cp\_utility::func_9D3E(param_00))
		{
			var_01 = function_00E3(param_00);
			param_00 = var_01[0];
		}
		else
		{
			param_00 = getweaponbasename(param_00);
		}
	}

	return param_00;
}

//Function Number: 59
func_10B5E()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	if(!isplayer(self))
	{
		return;
	}

	self notifyonplayercommand("adjustedStance","+stance");
	self notifyonplayercommand("adjustedStance","+goStand");
	if(!level.console && !isai(self))
	{
		self notifyonplayercommand("adjustedStance","+togglecrouch");
		self notifyonplayercommand("adjustedStance","toggleprone");
		self notifyonplayercommand("adjustedStance","+movedown");
		self notifyonplayercommand("adjustedStance","-movedown");
		self notifyonplayercommand("adjustedStance","+prone");
		self notifyonplayercommand("adjustedStance","-prone");
	}

	for(;;)
	{
		scripts\common\utility::waittill_any_3("adjustedStance","sprint_begin","weapon_change");
		wait(0.5);
		if(isdefined(self.var_C53B) && self.var_C53B)
		{
			continue;
		}

		var_00 = self getstance();
		func_10B5F(var_00);
	}
}

//Function Number: 60
func_10B5F(param_00)
{
	var_01 = self getcurrentprimaryweapon();
	var_02 = 0;
	if(func_9F1C(var_01))
	{
		var_02 = func_80E2();
	}

	if(param_00 == "prone")
	{
		var_03 = scripts\cp\_utility::func_4626(var_01);
		if(isdefined(var_03))
		{
			if(var_03 == "weapon_lmg")
			{
				setrecoilscale(0,40);
				return;
			}

			if(var_03 == "weapon_sniper")
			{
				if(issubstr(var_01,"barrelbored"))
				{
					setrecoilscale(0,20 + var_02);
					return;
				}

				setrecoilscale(0,40 + var_02);
				return;
			}

			return;
		}

		setrecoilscale();
		return;
	}

	if(param_00 == "crouch")
	{
		var_03 = scripts\cp\_utility::func_4626(var_01);
		if(isdefined(var_03))
		{
			if(var_03 == "weapon_lmg")
			{
				setrecoilscale(0,10);
				return;
			}

			if(var_03 == "weapon_sniper")
			{
				if(issubstr(var_01,"barrelbored"))
				{
					setrecoilscale(0,10 + var_02);
					return;
				}

				setrecoilscale(0,20 + var_02);
				return;
			}

			return;
		}

		setrecoilscale();
		return;
	}

	if(var_02 > 0)
	{
		setrecoilscale(0,var_02);
		return;
	}

	setrecoilscale();
}

//Function Number: 61
setrecoilscale(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(self.recoilscale))
	{
		self.recoilscale = param_00;
	}
	else
	{
		self.recoilscale = self.recoilscale + param_00;
	}

	if(isdefined(param_01))
	{
		if(isdefined(self.recoilscale) && param_01 < self.recoilscale)
		{
			param_01 = self.recoilscale;
		}

		var_02 = 100 - param_01;
	}
	else
	{
		var_02 = 100 - self.recoilscale;
	}

	if(var_02 < 0)
	{
		var_02 = 0;
	}

	if(var_02 > 100)
	{
		var_02 = 100;
	}

	if(var_02 == 100)
	{
		self player_recoilscaleoff();
		return;
	}

	self player_recoilscaleon(var_02);
}

//Function Number: 62
func_9F1C(param_00)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return 0;
	}

	var_01 = 0;
	if(issubstr(param_00,"kbsscope") || issubstr(param_00,"m8scope_zm") || issubstr(param_00,"cheytacscope"))
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 63
func_80E2()
{
	if(!isdefined(self.pers["recoilReduceKills"]))
	{
		self.pers["recoilReduceKills"] = 0;
	}

	return self.pers["recoilReduceKills"] * 40;
}

//Function Number: 64
watch_slasher_killed()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("achievement_done");
	for(;;)
	{
		self waittill("slasher_killed_by_own_weapon",var_00,var_01);
		level thread slasher_killed_vo(var_00);
		lib_0D2A::func_12D7C("TABLES_TURNED",1);
		self notify("achievement_done");
	}
}

//Function Number: 65
slasher_killed_vo(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("disconnect");
	if(param_00.var_134FD == "p5_")
	{
		level thread scripts\cp\_vo::try_to_play_vo("ww_slasher_death_p5","rave_announcer_vo","highest",5,0,0,1);
	}

	wait(5);
	param_00 thread scripts\cp\_vo::try_to_play_vo("killfirm_slasher","zmb_comment_vo","highest",20,0,0,1);
}

//Function Number: 66
func_13A7F()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 == "none")
		{
			continue;
		}

		var_01 = getweaponbasename(var_00);
		if(func_9FEA(var_00))
		{
			self.last_valid_weapon = var_00;
		}

		switch(var_01)
		{
			case "iw7_axe_zm_pap2":
			case "iw7_axe_zm_pap1":
			case "iw7_axe_zm":
				if(func_7D62(var_00) > 1)
				{
				}
				else
				{
				}
				break;
	
			default:
				break;
		}
	}
}

//Function Number: 67
func_9FEA(param_00)
{
	var_01 = level.additional_laststand_weapon_exclusion;
	if(param_00 == "none")
	{
		return 0;
	}

	if(scripts\common\utility::func_2286(var_01,param_00))
	{
		return 0;
	}

	if(scripts\common\utility::func_2286(var_01,getweaponbasename(param_00)))
	{
		return 0;
	}

	if(scripts\cp\_utility::func_9C42(param_00,1))
	{
		return 0;
	}

	return 1;
}

//Function Number: 68
func_12F0A()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	var_00 = self.var_4C16;
	if(isdefined(self.var_EB6D))
	{
		var_00 = self.var_EB6D;
	}

	self.var_EB6B = var_00;
	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(var_01 == "none")
		{
			self.var_EB6B = var_00;
			continue;
		}

		var_02 = function_0244(var_01);
		if(var_02 != "primary" && var_02 != "altmode")
		{
			self.var_EB6B = var_00;
			continue;
		}

		self [[ level.var_BC70 ]]();
		self.var_EB6B = var_00;
		var_00 = var_01;
	}
}

//Function Number: 69
func_13A9B()
{
	self notify("watchGrenadeUsage");
	self endon("watchGrenadeUsage");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("faux_spawn");
	self.var_11817 = undefined;
	self.var_8474 = 0;
	if(!isdefined(self.var_CC4C))
	{
		self.var_CC4C = [];
		self.var_CC4D = [];
	}

	for(;;)
	{
		self waittill("grenade_pullback",var_00);
		var_01 = self method_8556();
		if(var_01 != "none")
		{
			continue;
		}

		if(isdefined(level.custom_grenade_pullback_func))
		{
			thread [[ level.custom_grenade_pullback_func ]](self,var_00);
		}

		thread func_13ADB();
		self.var_11817 = var_00;
		if(var_00 == "c4_zm")
		{
			thread func_2A60();
		}

		func_2A69();
		self.var_11817 = undefined;
	}
}

//Function Number: 70
func_13ADB()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("grenade_fire");
	self waittill("offhand_end");
	if(isdefined(self.var_3C64) && self.var_3C64 != self getcurrentweapon())
	{
		self.var_3C64 = undefined;
	}
}

//Function Number: 71
func_2A60()
{
	self notify("beginC4Tracking");
	self endon("beginC4Tracking");
	self endon("death");
	self endon("disconnect");
	scripts\common\utility::waittill_any_3("grenade_fire","weapon_change","offhand_end");
	self.var_3C64 = undefined;
}

//Function Number: 72
func_2A69()
{
	self endon("offhand_end");
	var_00 = gettime();
	var_01 = func_1377A();
	if(!isdefined(var_01))
	{
		return;
	}

	if(!isdefined(var_01.var_13C2E))
	{
		return;
	}

	self.var_3C64 = undefined;
	switch(var_01.var_13C2E)
	{
		case "thermobaric_grenade_mp":
		case "frag_grenade_mp":
		case "frag_grenade_zm":
			if(gettime() - var_00 > 1000)
			{
				var_01.var_9D93 = 1;
			}
	
			var_01 thread func_858A();
			var_01.var_C731 = self;
			break;

		case "cluster_grenade_zm":
			var_01.var_42E0 = var_01.var_118A2;
			if(var_01.var_118A2 >= 1)
			{
				var_01.var_9D93 = 1;
			}
	
			var_01.var_C731 = self;
			var_01 thread func_42DE();
			var_01 thread func_858A();
			break;

		case "zfreeze_semtex_mp":
		case "semtex_zm":
		case "semtex_mp":
			thread func_F21A(var_01);
			break;

		case "c4_zm":
			thread lib_0D07::func_333E(var_01);
			break;

		case "smoke_grenade_mp":
			var_01 thread func_13B48();
			break;

		case "claymore_mp":
			thread func_402D(var_01);
			break;

		case "concussion_grenade_mp":
			var_01 thread func_139D3();
			break;

		case "bouncingbetty_mp":
			thread func_B780(var_01,::func_108E3);
			break;

		case "throwingknifejugg_mp":
		case "throwingknifec4_mp":
		case "throwingknife_mp":
			level thread func_11824(self,var_01,var_01.var_13C2E);
			break;

		case "zom_repulsor_mp":
			var_01 delete();
			break;

		case "gas_grenade_mp":
			var_01 thread func_13A8A();
			break;

		case "splash_grenade_zm":
		case "splash_grenade_mp":
			var_01 thread func_858A();
			thread scripts\cp\_spawn_plasma_projectile::func_10A35(var_01);
			break;

		case "portal_generator_zm":
		case "portal_generator_mp":
			thread lib_0D14::func_D68B(var_01);
			break;

		case "ztransponder_mp":
		case "transponder_mp":
			thread lib_0D1E::func_1268F(var_01);
			break;

		case "micro_turret_zm":
		case "micro_turret_mp":
			thread lib_0D0F::func_B719(var_01);
			break;

		case "blackhole_grenade_zm":
		case "blackhole_grenade_mp":
			thread lib_0D04::func_2B3D(var_01);
			break;

		case "trip_mine_mp":
			thread lib_0D1F::func_127F2(var_01);
			break;

		case "heart_cp":
			thread heart_used();
			break;

		case "rat_king_eye_cp":
			thread eye_activated();
			break;
	}
}

//Function Number: 73
rat_executevisuals(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	self playlocalsound("eye_pulse_plr_lr");
	self setscriptablepartstate("rat_eye_pulse","active");
	scripts\common\utility::waittill_any_timeout_1(param_00,"last_stand","death");
	self setscriptablepartstate("rat_eye_pulse","inactive");
}

//Function Number: 74
handleratvisionburst(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	param_00 endon("death");
	param_00 thread rat_executevisuals(2.4);
}

//Function Number: 75
func_9E54(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getentarray("power_exclusion_volume","targetname");
	if(isdefined(param_05))
	{
		if(isdefined(level.var_BEAB) && isdefined(level.var_BEAB.var_12F87))
		{
			if(param_05 == level.var_BEAB || param_05 == level.var_BEAB.var_12F87)
			{
				return 0;
			}
		}

		if(isdefined(level.var_2BFB))
		{
			if(param_05 == level.var_2BFB)
			{
				return 0;
			}
		}

		if(isdefined(param_05.var_336) && param_05.var_336 == "beginning_area_balloons")
		{
			return 0;
		}
	}

	if(isdefined(param_01))
	{
		var_06 = scripts\common\utility::array_combine(var_06,param_01);
	}

	foreach(var_08 in var_06)
	{
		if(function_010F(param_00,var_08))
		{
			return 0;
		}
	}

	if(scripts\common\utility::istrue(param_04) && !ispointonnavmesh(param_00))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_03))
	{
		if(navtrace(param_02.origin,param_00))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 76
func_CC16(param_00,param_01,param_02,param_03)
{
	if(isplayer(self))
	{
		self playlocalsound("scavenger_pack_pickup");
	}

	if(scripts\common\utility::istrue(param_01))
	{
		var_04 = undefined;
		if(isplayer(self))
		{
			self playlocalsound("ww_magicbox_laughter");
			if(isdefined(param_03))
			{
				var_04 = function_01E1(scripts\common\utility::getfx("placeEquipmentFailed"),param_02,self,anglestoforward(param_03),anglestoup(param_03));
			}
			else
			{
				var_04 = function_01E1(scripts\common\utility::getfx("placeEquipmentFailed"),param_02,self);
			}
		}
		else
		{
			var_04 = spawnfx(scripts\common\utility::getfx("placeEquipmentFailed"),param_02);
		}

		triggerfx(var_04);
		thread func_CC17(var_04);
	}
}

//Function Number: 77
func_CC17(param_00)
{
	wait(2);
	param_00 delete();
}

//Function Number: 78
func_108E3(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = (0,randomfloat(360),0);
	}

	var_04 = level.var_13C7D[param_02];
	var_05 = spawn("script_model",param_00);
	var_05.angles = param_03;
	var_05.var_222 = param_01;
	var_05.var_13C2E = param_02;
	var_05.var_451C = var_04;
	var_05 setmodel(var_04.model);
	var_05 method_831F(param_01);
	var_05.var_A640 = (0,0,4);
	var_05.var_A63A = spawn("script_model",var_05.origin + var_05.var_A640);
	var_05.var_A63A setscriptmoverkillcam("explosive");
	param_01 func_C54E(var_05);
	if(isdefined(var_04.var_B760))
	{
		var_05 thread func_57EB("tag_fx",var_04.var_B760["friendly"],var_04.var_B760["enemy"]);
	}

	var_06 = undefined;
	if(self != level)
	{
		var_06 = self getlinkedparent();
	}

	var_05 func_69FF(var_06);
	var_05 thread func_B778(var_06);
	var_05 thread func_858A();
	var_05 thread func_B77A();
	var_05 thread func_B770();
	level thread func_B9CA(param_01,var_05);
	return var_05;
}

//Function Number: 79
func_B77A()
{
	self endon("mine_triggered");
	self endon("mine_destroyed");
	self endon("death");
	wait(level.var_B77B + randomfloat(0.4));
	self notify("mine_selfdestruct");
	self notify("detonateExplosive");
}

//Function Number: 80
func_B770()
{
	self endon("death");
	level endon("game_ended");
	self waittill("detonateExplosive",var_00);
	if(!isdefined(self) || !isdefined(self.var_222))
	{
		return;
	}

	if(!isdefined(var_00))
	{
		var_00 = self.var_222;
	}

	var_01 = self.var_451C;
	var_02 = var_01.var_13370;
	if(!isdefined(var_02))
	{
		var_02 = "tag_fx";
	}

	var_03 = self gettagorigin(var_02);
	if(!isdefined(var_03))
	{
		var_03 = self gettagorigin("tag_origin");
	}

	self notify("explode",var_03);
	wait(0.05);
	if(!isdefined(self) || !isdefined(self.var_222))
	{
		return;
	}

	self hide();
	if(isdefined(var_01.var_C524))
	{
		self thread [[ var_01.var_C524 ]]();
	}

	if(isdefined(var_01.var_C525))
	{
		self playsound(var_01.var_C525);
	}

	var_04 = scripts\common\utility::func_116D7(isdefined(var_01.var_C526),var_01.var_C526,level.var_B761);
	var_05 = scripts\common\utility::func_116D7(isdefined(var_01.var_B769),var_01.var_B769,level.var_B769);
	var_06 = scripts\common\utility::func_116D7(isdefined(var_01.var_B768),var_01.var_B768,level.var_B768);
	var_07 = scripts\common\utility::func_116D7(isdefined(var_01.var_B76B),var_01.var_B76B,level.var_B76B);
	self radiusdamage(self.origin,var_07,var_06,var_05,var_00,"MOD_EXPLOSIVE",self.var_13C2E);
	wait(0.2);
	func_51B5();
}

//Function Number: 81
func_B778(param_00)
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self endon("disabled");
	var_01 = self.var_451C;
	wait(var_01.var_226E);
	if(isdefined(var_01.var_B760))
	{
		thread func_57EB("tag_fx",var_01.var_B760["friendly"],var_01.var_B760["enemy"]);
	}

	var_02 = spawn("trigger_radius",self.origin,0,level.var_B76F,level.var_B76E);
	var_02.var_222 = self;
	var_02.team = var_02.var_222.team;
	thread func_B76C(var_02);
	if(isdefined(param_00))
	{
		var_02 enablelinkto();
		var_02 linkto(param_00);
	}

	self.var_4D2A = var_02;
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		if(isplayer(var_03))
		{
			wait(0.05);
			continue;
		}

		if(var_03 method_808F(self.origin,self) > 0)
		{
			break;
		}
	}

	self notify("mine_triggered");
	self playsound(self.var_451C.var_C5B4);
	func_6A08(var_03,level.var_B76D,"mine");
	self thread [[ self.var_451C.var_C5B3 ]]();
}

//Function Number: 82
func_B76C(param_00)
{
	scripts\common\utility::waittill_any_3("mine_triggered","mine_destroyed","mine_selfdestruct","death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 83
func_57EB(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = scripts\common\utility::getfx("weap_blink_friend");
	}

	if(!isdefined(param_02))
	{
		param_02 = scripts\common\utility::getfx("weap_blink_enemy");
	}

	self.var_2BA2["friendly"] = param_01;
	self.var_2BA2["enemy"] = param_02;
	self.var_2BA3 = param_00;
	thread func_12E66(param_01,param_02,param_00);
	self waittill("death");
	func_11061();
}

//Function Number: 84
func_12E66(param_00,param_01,param_02)
{
	self endon("death");
	self endon("carried");
	self endon("emp_damage");
	var_03 = ::func_3E52;
	if(!level.teambased)
	{
		var_03 = ::func_3E34;
	}

	var_04 = randomfloatrange(0.05,0.25);
	wait(var_04);
	childthread func_C542(param_00,param_01,param_02,var_03);
	foreach(var_06 in level.players)
	{
		if(isdefined(var_06))
		{
			if(self.var_222 [[ var_03 ]](var_06))
			{
				playfxontagforclients(param_00,self,param_02,var_06);
			}
			else
			{
				playfxontagforclients(param_01,self,param_02,var_06);
			}

			wait(0.05);
		}
	}
}

//Function Number: 85
func_3E34(param_00)
{
	return self == param_00;
}

//Function Number: 86
func_3E52(param_00)
{
	return self.team == param_00.team;
}

//Function Number: 87
func_C542(param_00,param_01,param_02,param_03)
{
	self endon("death");
	level endon("game_ended");
	self endon("emp_damage");
	for(;;)
	{
		level waittill("joined_team",var_04);
		if(self.var_222 [[ param_03 ]](var_04))
		{
			playfxontagforclients(param_00,self,param_02,var_04);
			continue;
		}

		playfxontagforclients(param_01,self,param_02,var_04);
	}
}

//Function Number: 88
func_11061()
{
	if(isalive(self) && isdefined(self.var_2BA2))
	{
		stopfxontag(self.var_2BA2["friendly"],self,self.var_2BA3);
		stopfxontag(self.var_2BA2["enemy"],self,self.var_2BA3);
		self.var_2BA2 = undefined;
		self.var_2BA3 = undefined;
	}
}

//Function Number: 89
takeheart(param_00)
{
	self notify("remove_heart");
	self.has_heart = undefined;
}

//Function Number: 90
heart_used()
{
	self endon("disconnect");
	self endon("remove_heart");
	self notify("beginHeartTracking");
	self endon("beginHeartTracking");
	self endon("death");
	var_00 = self method_8513("ges_heart_pull","explode");
	var_01 = self method_8443("ges_heart_pull");
	self.var_3C64 = undefined;
	var_02 = self.origin;
	var_03 = scripts\cp\_agent_utils::get_alive_enemies();
	foreach(var_05 in var_03)
	{
		if(isdefined(var_05.flung) || isdefined(var_05.agent_type) && var_05.agent_type == "zombie_brute" || var_05.agent_type == "zombie_ghost" || var_05.agent_type == "zombie_grey" || var_05.agent_type == "slasher" || var_05.agent_type == "superslasher")
		{
			continue;
		}

		if(distancesquared(var_05.origin,var_02) <= 65536)
		{
			if(var_05 lib_0F74::func_9D9E())
			{
				var_05.var_EF64 = 1;
				var_05.var_180 = 1;
				var_05 method_82EF(var_05.origin);
			}

			var_05.var_EF64 = 1;
			var_05.var_180 = 1;
			var_05 method_82EF(var_05.origin);
			var_05.flung = 1;
			var_05.do_immediate_ragdoll = 1;
			var_05.disable_armor = 1;
			var_05.full_gib = 1;
			var_05.nocorpse = 1;
			var_05 setsolid(0);
			playfx(level._effect["rat_swarm_cheap"],var_05 gettagorigin("j_spine4"),anglestoforward(var_05.angles));
			thread deal_damage(var_05,self);
		}
	}

	scripts\cp\powers\coop_powers::func_D72E();
	self notify("heart_used",1);
}

//Function Number: 91
use_heart_notify()
{
	self notify("heart_used",1);
}

//Function Number: 92
deal_damage(param_00,param_01)
{
	param_00 endon("death");
	wait(0.7);
	param_00.var_EF64 = undefined;
	var_02 = param_00 gettagorigin("j_spine4");
	playfx(level._effect["gore"],var_02,(1,0,0));
	playsoundatpos(var_02,"gib_fullbody");
	param_01 earthquakeforplayer(0.5,1.5,var_02,120);
	scripts\common\utility::func_136F7();
	if(isdefined(param_00))
	{
		param_00 dodamage(param_00.health + 100000,param_00.origin,param_01,param_01,"MOD_EXPLOSIVE","heart_cp");
	}
}

//Function Number: 93
func_13A8A()
{
	var_00 = self.var_222;
	var_00 endon("disconnect");
	self waittill("explode",var_01);
	thread func_C534(var_00,var_01);
}

//Function Number: 94
func_C534(param_00,param_01)
{
	var_02 = spawn("trigger_radius",param_01,0,128,160);
	var_02.var_222 = param_00;
	var_03 = 128;
	var_04 = spawnfx(scripts\common\utility::getfx("gas_grenade_smoke_enemy"),param_01);
	triggerfx(var_04);
	wait(1);
	var_05 = 8;
	while(var_05 > 0)
	{
		foreach(var_07 in scripts\cp\_agent_utils::func_7DB0("axis"))
		{
			if(isdefined(var_07.agent_type) && var_07.agent_type == "zombie_brute" || var_07.agent_type == "superslasher" || var_07.agent_type == "slasher" || var_07.agent_type == "zombie_grey")
			{
				continue;
			}

			var_08 = func_7E5B(var_07);
			if(isalive(var_07))
			{
				var_07 func_20CC(param_00,param_01,var_02,var_02,int(var_08));
			}
		}

		wait(0.2);
		var_05 = var_05 - 0.2;
	}

	var_04 delete();
	wait(2);
	var_02 delete();
	foreach(var_07 in scripts\cp\_agent_utils::func_7DB0("axis"))
	{
		if(isalive(var_07))
		{
			var_07.var_6E82 = undefined;
		}
	}
}

//Function Number: 95
func_7E5B(param_00)
{
	if(isalive(param_00))
	{
		if(scripts\common\utility::istrue(param_00.var_9CDD))
		{
			return int(min(1000,param_00.maxhealth * 0.25));
		}

		return int(min(1000,param_00.maxhealth * 0.1));
	}

	return 150;
}

//Function Number: 96
func_20CC(param_00,param_01,param_02,param_03,param_04)
{
	if(isalive(self) && self istouching(param_02))
	{
		if(param_00 scripts\cp\_utility::func_9DD6(self))
		{
			param_03 radiusdamage(self.origin,1,param_04,param_04,param_00,"MOD_GRENADE_SPLASH","gas_grenade_mp");
			self.var_6E82 = gettime() + 200;
		}
	}
}

//Function Number: 97
func_11824(param_00,param_01,param_02)
{
	if(param_02 == "throwingknifec4_mp")
	{
		param_01 makeunusable();
		param_01 thread func_DDF3();
	}

	thread func_1181A(param_00,param_01);
	var_03 = undefined;
	var_04 = undefined;
	param_01 waittill("missile_stuck",var_03,var_04);
	var_05 = isdefined(var_04) && var_04 == "tag_flicker";
	var_06 = isdefined(var_04) && var_04 == "tag_weapon";
	if(isdefined(var_03) && isplayer(var_03) || isagent(var_03) && var_05)
	{
		var_03 notify("shield_hit",param_01);
	}

	if(isdefined(var_03) && isplayer(var_03) || isagent(var_03) && !var_06 && !var_05)
	{
		if(!lib_0D12::func_213D(var_03,param_01))
		{
			param_01 delete();
			return;
		}
		else if(param_02 == "throwingknifec4_mp")
		{
			func_11818(param_01,var_03,param_00);
		}
	}

	if(isdefined(param_01.var_8377))
	{
		func_11827(param_00,param_01.var_D719);
		param_01 delete();
	}
}

//Function Number: 98
func_1181A(param_00,param_01)
{
	param_01 endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("victim_damaged",var_02,var_03,var_04,var_05,var_06,var_07);
		if(isdefined(var_03) && var_03 == param_01)
		{
			if(var_07 == "throwingknifeteleport_mp" && !isdefined(param_01.var_A708))
			{
				func_1181F(param_01,var_02,param_00,1);
				param_01.var_8377 = 1;
			}

			break;
		}
	}
}

//Function Number: 99
func_13A90()
{
	self waittill("death");
	if(isdefined(self.var_A702))
	{
		self.var_A702 delete();
	}
}

//Function Number: 100
func_11827(param_00,param_01,param_02)
{
	var_03 = param_00 getweaponammoclip(param_02);
	var_04 = 2;
	var_05 = undefined;
	if(var_03 >= var_04)
	{
		var_05 = 0;
	}
	else
	{
		param_00 setweaponammoclip(param_02,var_03 + 1);
		param_00 thread func_917F("throwingknife");
		var_05 = 1;
	}

	return var_05;
}

//Function Number: 101
func_917F(param_00)
{
	var_01 = 0;
	if(isdefined(level.var_4D4E) && level.var_4D4E)
	{
		var_01 = 1;
	}

	if(!isplayer(self))
	{
		return;
	}

	switch(param_00)
	{
		case "scavenger":
		case "throwingknife":
			if(!var_01)
			{
				self playlocalsound("scavenger_pack_pickup");
			}
	
			if(!level.var_8B38)
			{
				self setclientomnvar("damage_feedback_other",param_00);
			}
			break;

		case "boxofguns":
			if(!var_01)
			{
				self playlocalsound("mp_box_guns_ammo");
			}
	
			if(!level.var_8B38)
			{
				self setclientomnvar("damage_feedback_other",param_00);
			}
			break;

		case "oracle":
			if(!var_01)
			{
				self playlocalsound("oracle_radar_pulse_plr");
			}
	
			if(!level.var_8B38)
			{
				self setclientomnvar("damage_feedback_other",param_00);
			}
			break;
	}
}

//Function Number: 102
func_1181F(param_00,param_01,param_02,param_03)
{
	param_02 playlocalsound("blinkknife_teleport");
	param_02 playsoundonmovingent("blinkknife_teleport_npc");
	playsoundatpos(param_00.origin,"blinkknife_impact");
	thread func_11823(param_02,param_01);
	var_04 = param_01 method_8113();
	if(isdefined(var_04))
	{
		var_04 method_82C7(0);
	}

	var_05 = [];
	foreach(var_07 in level.var_3CB5)
	{
		if(!isdefined(var_07) || !isalive(var_07) || var_07 == param_01 || var_07 == param_02 || !param_02 scripts\cp\_utility::func_9DD6(var_07))
		{
			continue;
		}

		var_05[var_05.size] = var_07;
	}

	var_05 = sortbydistance(var_05,param_01.origin);
	var_09 = param_02 gettagorigin("TAG_EYE");
	var_0A = param_01.origin;
	var_0B = param_01.origin + (0,0,var_09[2] - param_02.origin[2]);
	var_0C = param_02.angles;
	foreach(var_0E in var_05)
	{
		var_0F = (var_0E.origin[0],var_0E.origin[1],var_0E gettagorigin("TAG_EYE")[2]);
		if(distancesquared(var_0E.origin,param_01.origin) < 230400 && sighttracepassed(var_0B,var_0F,0,undefined))
		{
			var_0C = vectortoangles(var_0F - var_0B);
			break;
		}
	}

	param_02 setorigin(param_01.origin,!param_03);
	param_02 setplayerangles(var_0C);
	func_11820(param_02,param_01);
}

//Function Number: 103
func_11823(param_00,param_01)
{
	var_02 = param_01.origin - param_00.origin;
	var_03 = param_00.origin + (0,0,32);
	var_04 = vectornormalize(var_02);
	var_05 = vectornormalize(vectorcross(var_02,(0,0,1)));
	var_06 = vectorcross(var_05,var_04);
	var_07 = axistoangles(var_04,var_05,var_06);
	var_08 = 0;
	if(var_08)
	{
		var_09 = spawn("script_model",var_03);
		var_09.angles = var_07;
		var_09 setmodel("tag_origin");
		var_09 method_8429(param_00);
		scripts\common\utility::func_136F7();
		function_029A(scripts\common\utility::getfx("vfx_knife_tele_start_friendly"),var_09,"tag_origin",param_00.team);
		wait(3);
		var_09 delete();
		return;
	}

	var_0A = spawn("script_model",var_03);
	var_0A.angles = var_07;
	var_0A setmodel("tag_origin");
	var_0A method_8429(param_00);
	scripts\common\utility::func_136F7();
	foreach(var_0C in level.players)
	{
		var_0A method_8429(var_0C);
	}

	playfxontag(scripts\common\utility::getfx("vfx_tele_start_friendly"),var_0A,"tag_origin");
	wait(3);
	var_0A delete();
}

//Function Number: 104
func_DDF3()
{
	level endon("game_ended");
	self.var_222 endon("disconnect");
	self.var_5726 = 0;
	var_00 = self.origin;
	for(;;)
	{
		var_01 = scripts\common\utility::waittill_any_timeout_1(0.15,"death","missile_stuck");
		if(!isdefined(self))
		{
			break;
		}

		var_02 = distance(var_00,self.origin);
		self.var_5726 = self.var_5726 + var_02;
		var_00 = self.origin;
		if(var_01 != "timeout")
		{
			break;
		}
	}
}

//Function Number: 105
func_11820(param_00,param_01)
{
}

//Function Number: 106
func_11818(param_00,param_01,param_02)
{
	param_01 playsound("biospike_explode");
	playfx(scripts\common\utility::getfx("throwingknifec4_explode"),param_00.origin);
	param_00 radiusdamage(param_00.origin,180,1200,600,param_02,"MOD_EXPLOSIVE",param_00.var_13C2E);
	param_00 thread func_858A();
	param_00 notify("explode",param_00.origin);
	param_00 delete();
}

//Function Number: 107
func_11826(param_00,param_01)
{
	param_01 endon("missile_stuck");
	param_01 endon("death");
	param_00 scripts\common\utility::waittill_any_3("death","disconnect");
	param_01.var_A708 = 1;
}

//Function Number: 108
func_139D3()
{
	thread func_636E();
	self endon("end_explode");
	self waittill("explode",var_00);
	func_11195(var_00,self.var_222);
}

//Function Number: 109
func_11195(param_00,param_01)
{
	var_02 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_03 = scripts\common\utility::func_782F(param_00,var_02,undefined,24,256);
	foreach(var_05 in var_03)
	{
		if(!var_05 scripts\cp\_utility::agentisfnfimmune())
		{
			var_05 thread func_75FA(var_05,param_01);
		}
	}
}

//Function Number: 110
func_75FA(param_00,param_01)
{
	param_00 endon("death");
	if(isdefined(param_00.var_11190))
	{
		if(gettime() > param_00.var_11190)
		{
			if(param_00 lib_0F74::func_9D9E())
			{
				param_00.var_EF64 = 1;
				param_00.var_180 = 1;
				param_00 method_82EF(param_00.origin);
			}

			param_00.allowpain = 1;
			param_00.var_11190 = gettime() + 1000;
			param_00.var_11196 = 1;
		}
		else
		{
			return;
		}
	}
	else
	{
		if(param_00 lib_0F74::func_9D9E())
		{
			param_00.var_EF64 = 1;
			param_00.var_180 = 1;
			param_00 method_82EF(param_00.origin);
		}

		param_00.allowpain = 1;
		param_00.var_11190 = gettime() + 1000;
		param_00.var_11196 = 1;
	}

	param_00 dodamage(1,param_00.origin,param_01,param_01,"MOD_GRENADE_SPLASH","concussion_grenade_mp");
	wait(1);
	if(param_00 lib_0F74::func_9D9E())
	{
		param_00.var_EF64 = 0;
		param_00.var_180 = 0;
	}

	param_00.allowpain = 0;
	param_00.var_11196 = undefined;
}

//Function Number: 111
func_B780(param_00,param_01)
{
	if(!isalive(self))
	{
		param_00 delete();
		return;
	}

	param_00 thread func_B77F(self,param_00.var_13C2E,param_01);
}

//Function Number: 112
func_B77F(param_00,param_01,param_02,param_03)
{
	self.var_222 = param_00;
	self waittill("missile_stuck",var_04);
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_01 != "trip_mine_mp")
	{
		if(isdefined(var_04) && isdefined(var_04.var_222))
		{
			if(isdefined(param_03))
			{
				self.var_222 [[ param_03 ]](self);
			}

			self delete();
			return;
		}
	}

	var_05 = bullettrace(self.origin + (0,0,4),self.origin - (0,0,4),0,self);
	var_06 = var_05["position"];
	if(var_05["fraction"] == 1)
	{
		var_06 = getgroundposition(self.origin,12,0,32);
		var_05["normal"] = var_05["normal"] * -1;
	}

	var_07 = vectornormalize(var_05["normal"]);
	var_08 = vectortoangles(var_07);
	var_08 = var_08 + (90,0,0);
	var_09 = [[ param_02 ]](var_06,param_00,param_01,var_08);
	var_09 thread func_B76A();
	self delete();
}

//Function Number: 113
func_B76A()
{
	self endon("mine_triggered");
	self endon("mine_selfdestruct");
	self endon("death");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_00 = undefined;
	for(;;)
	{
		self waittill("damage",var_01,var_00,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(func_9C01(var_00,var_04))
		{
			break;
		}

		if(!isplayer(var_00) && !isagent(var_00))
		{
			continue;
		}

		if(isdefined(var_09) && isendstr(var_09,"betty_mp"))
		{
			continue;
		}

		if(!scripts\cp\_damage::func_7415(self.var_222,var_00))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "concussion_grenade_mp":
				case "smoke_grenadejugg_mp":
				case "smoke_grenade_mp":
				case "flash_grenade_mp":
					break;
			}
		}

		break;
	}

	self notify("mine_destroyed");
	if(isdefined(var_04) && issubstr(var_04,"MOD_GRENADE") || issubstr(var_04,"MOD_EXPLOSIVE"))
	{
		self.var_13908 = 1;
	}

	if(isdefined(var_08) && var_08 & level.var_92C4)
	{
		self.var_1390E = 1;
	}

	self.var_1390B = 1;
	if(isdefined(var_00))
	{
		self.var_4D3F = var_00;
	}

	if(isplayer(var_00))
	{
		var_00 scripts\cp\_damage::func_12E84("bouncing_betty");
	}

	self notify("detonateExplosive",var_00);
}

//Function Number: 114
func_9C01(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_00.classname))
	{
		return 0;
	}

	return param_00.classname == "scriptable" && param_01 == "MOD_EXPLOSIVE";
}

//Function Number: 115
func_402D(param_00)
{
	if(!isalive(self))
	{
		param_00 delete();
		return;
	}

	param_00 hide();
	param_00 scripts\common\utility::waittill_any_timeout_1(0.05,"missile_stuck");
	if(!isdefined(self) || !isalive(self))
	{
		param_00 delete();
		return;
	}

	var_01 = 60;
	var_02 = (0,0,4);
	var_03 = distancesquared(self.origin,param_00.origin);
	var_04 = distancesquared(self geteye(),param_00.origin);
	var_03 = var_03 + 600;
	var_05 = param_00 getlinkedparent();
	if(isdefined(var_05))
	{
		param_00 unlink();
	}

	if(var_03 < var_04)
	{
		if(var_01 * var_01 < distancesquared(param_00.origin,self.origin))
		{
			var_06 = bullettrace(self.origin,self.origin - (0,0,var_01),0,self);
			if(var_06["fraction"] == 1)
			{
				param_00 delete();
				self setweaponammostock(param_00.var_13C2E,self getweaponammostock(param_00.var_13C2E) + 1);
				return;
			}
			else
			{
				param_00.origin = var_06["position"];
				var_05 = var_06["entity"];
			}
		}
		else
		{
		}
	}
	else if(var_01 * var_01 < distancesquared(param_00.origin,self geteye()))
	{
		var_06 = bullettrace(self.origin,self.origin - (0,0,var_01),0,self);
		if(var_06["fraction"] == 1)
		{
			param_00 delete();
			self setweaponammostock(param_00.var_13C2E,self getweaponammostock(param_00.var_13C2E) + 1);
			return;
		}
		else
		{
			param_00.origin = var_06["position"];
			var_05 = var_06["entity"];
		}
	}
	else
	{
		var_02 = (0,0,-5);
		param_00.angles = param_00.angles + (0,180,0);
	}

	param_00.angles = param_00.angles * (0,1,1);
	param_00.origin = param_00.origin + var_02;
	param_00 func_69FF(var_05);
	param_00 show();
	func_C54E(param_00);
	param_00 thread func_C4F4();
	param_00 thread func_334A();
	param_00 thread func_4028(var_05);
	self.var_3C64 = undefined;
	level thread func_B9CA(self,param_00);
}

//Function Number: 116
func_4028(param_00)
{
	self endon("death");
	var_01 = spawn("trigger_radius",self.origin + (0,0,0 - level.var_4027),0,level.var_4027,level.var_4027 * 2);
	if(isdefined(param_00))
	{
		var_01 enablelinkto();
		var_01 linkto(param_00);
	}

	thread func_51BF(var_01);
	for(;;)
	{
		var_01 waittill("trigger",var_02);
		if(getdvarint("scr_claymoredebug") != 1)
		{
			if(isdefined(self.var_222))
			{
				if(var_02 == self.var_222)
				{
					continue;
				}

				if(isdefined(var_02.var_222) && var_02.var_222 == self.var_222)
				{
					continue;
				}
			}

			if(!scripts\cp\_damage::func_7415(self.var_222,var_02,0))
			{
				continue;
			}
		}

		if(lengthsquared(var_02 method_8123()) < 10)
		{
			continue;
		}

		var_03 = abs(var_02.origin[2] - self.origin[2]);
		if(var_03 > 128)
		{
			continue;
		}

		if(!var_02 func_FFB9(self))
		{
			continue;
		}

		if(var_02 method_808F(self.origin,self) > 0)
		{
			break;
		}
	}

	self playsound("claymore_activated");
	func_6A08(var_02,level.var_4024,"claymore");
	self notify("detonateExplosive");
}

//Function Number: 117
func_6A08(param_00,param_01,param_02)
{
	if(isplayer(param_00) && param_00 scripts\cp\_utility::_hasperk("specialty_delaymine"))
	{
		param_00 notify("triggeredExpl",param_02);
		param_01 = level.var_5113;
	}

	wait(param_01);
}

//Function Number: 118
func_FFB9(param_00)
{
	if(isdefined(param_00.var_55BA))
	{
		return 0;
	}

	var_01 = self.origin + (0,0,32);
	var_02 = var_01 - param_00.origin;
	var_03 = anglestoforward(param_00.angles);
	var_04 = vectordot(var_02,var_03);
	if(var_04 < level.var_4025)
	{
		return 0;
	}

	var_02 = vectornormalize(var_02);
	var_05 = vectordot(var_02,var_03);
	return var_05 > level.var_4023;
}

//Function Number: 119
func_51BF(param_00)
{
	self waittill("death");
	wait(0.05);
	if(isdefined(param_00))
	{
		if(isdefined(param_00.trigger))
		{
			param_00.trigger delete();
		}

		param_00 delete();
	}
}

//Function Number: 120
func_334A()
{
	self endon("death");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		func_66A9();
		self.var_55BA = 1;
		self notify("disabled");
		wait(var_01);
		self.var_55BA = undefined;
		self notify("enabled");
	}
}

//Function Number: 121
func_66A9()
{
	playfxontag(scripts\common\utility::getfx("emp_stun"),self,"tag_origin");
}

//Function Number: 122
func_B2A3()
{
	self notify("equipmentWatchUse");
	self.trigger delete();
}

//Function Number: 123
func_B2A2(param_00)
{
	scripts\cp\_utility::func_B268(self.var_222.team);
	if(!isdefined(param_00) || !param_00)
	{
		self method_81F0();
	}
}

//Function Number: 124
func_13B48()
{
	level endon("smokeTimesUp");
	var_00 = self.var_222;
	var_00 endon("disconnect");
	self waittill("explode",var_01);
	var_02 = 22500;
	var_03 = 12;
	var_04 = spawn("script_model",var_01);
	var_04.origin = var_01 + (0,0,56);
	var_04 method_81F1("allies",1);
	var_04.health = 100000;
	var_04.maxhealth = 100000;
	var_04.var_33F = 10000;
	var_04 method_834E("players");
	level thread func_13718(12,22500,var_01,var_04);
	for(;;)
	{
		if(!isdefined(var_00))
		{
			break;
		}

		var_05 = scripts\cp\_agent_utils::func_7DB0("axis");
		foreach(var_07 in var_05)
		{
			if(var_07.var_1096F == "alien")
			{
				continue;
			}

			if(isdefined(var_07.var_10376))
			{
				continue;
			}

			var_08 = distance2dsquared(var_01,var_07.origin);
			if(var_08 < 90000)
			{
				var_07 thread func_11548(var_04,22500);
			}
		}

		foreach(var_0B in level.players)
		{
			if(!isdefined(var_0B))
			{
				continue;
			}

			var_0C = distance2dsquared(var_01,var_0B.origin);
			if(var_0C < 22500)
			{
				var_0B.var_9903 = var_00;
				var_0B method_834E("phased_players");
				continue;
			}

			var_0B.var_9903 = undefined;
			var_0B method_834E("players");
		}

		wait(0.05);
	}
}

//Function Number: 125
func_11548(param_00,param_01)
{
	scripts\cp\_agent_utils::func_18F3(param_00.origin,sqrt(param_01),"critical");
	if(!scripts\cp\_agent_utils::func_9B53(self))
	{
		self getenemyinfo(param_00);
		self method_8051(param_00);
		scripts\cp\_agent_utils::func_18F3(param_00.origin,8,"hunt");
	}

	self.var_10376 = 1;
	level waittill("smokeTimesUp");
	if(!scripts\cp\_agent_utils::func_9B53(self))
	{
		self method_8027();
	}

	scripts\cp\_agent_utils::func_18F3(self.origin,8,"hunt");
	self.var_10376 = undefined;
}

//Function Number: 126
func_13718(param_00,param_01,param_02,param_03)
{
	scripts\cp\_hostmigration::func_13708(param_00);
	level notify("smokeTimesUp");
	waittillframeend;
	foreach(var_05 in level.players)
	{
		if(isdefined(var_05))
		{
			var_05.var_9903 = undefined;
			var_05 method_834E("players");
		}
	}

	param_03 delete();
}

//Function Number: 127
func_3350(param_00)
{
	if(!scripts\cp\_utility::func_9F19(self))
	{
		param_00 delete();
		return;
	}

	self notify("c4_update",0);
	param_00 thread func_C4F4();
	thread func_139C5();
	thread func_139C4();
	thread func_139C3();
	param_00 method_831F(self);
	param_00.var_1604 = 0;
	func_C54E(param_00,"power_c4");
	var_01 = level.var_13C7D["c4_zm"];
	param_00 thread func_57EB("tag_fx",var_01.var_B760["friendly"],var_01.var_B760["enemy"]);
	param_00 thread func_3337();
	param_00 thread func_3341();
	param_00 thread func_139C7();
	level thread func_B9CA(self,param_00);
}

//Function Number: 128
func_139C6()
{
	self.var_222 endon("disconnect");
	var_00 = self.var_222;
	var_01 = scripts\common\utility::spawn_tag_origin(self.origin,self.angles);
	var_01 linkto(self);
	thread func_636E();
	self endon("end_explode");
	self waittill("explode",var_02);
	thread func_334C(var_02,var_00,var_01);
}

//Function Number: 129
func_334C(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	wait(0.5);
	param_02 radiusdamage(param_00,256,1200,600,param_01,"MOD_EXPLOSIVE","c4_zm");
	thread func_3337();
}

//Function Number: 130
func_E24B()
{
	wait(0.05);
	level.var_334B = 0;
}

//Function Number: 131
func_3341()
{
	self endon("death");
	self waittill("missile_stuck",var_00);
	wait(0.05);
	self notify("activated");
	self.var_1604 = 1;
}

//Function Number: 132
func_139C7()
{
	self endon("death");
	self waittill("missile_stuck",var_00);
	self method_8317(1);
	self.var_334F = 1;
	func_69FF(var_00);
}

//Function Number: 133
func_C54E(param_00,param_01,param_02)
{
	if(self.var_CC4C.size)
	{
		self.var_CC4C = scripts\common\utility::func_22BC(self.var_CC4C);
		if(self.var_CC4C.size >= level.var_B4BA)
		{
			if(scripts\common\utility::istrue(param_02))
			{
				self.var_CC4C[0] notify("detonateExplosive");
			}
			else
			{
				self.var_CC4C[0] func_51B5();
			}
		}
	}

	self.var_CC4C[self.var_CC4C.size] = param_00;
	var_03 = param_00 getentitynumber();
	level.var_B779[var_03] = param_00;
	level notify("mine_planted");
}

//Function Number: 134
func_139C3(param_00)
{
	self notify("watchC4AltDetonate");
	self endon("watchC4AltDetonate");
	self endon("death");
	self endon("disconnect");
	self endon("detonated");
	level endon("game_ended");
	var_01 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_01 = 0;
			while(self usebuttonpressed())
			{
				var_01 = var_01 + 0.05;
				wait(0.05);
			}

			if(var_01 >= 0.5)
			{
				continue;
			}

			var_01 = 0;
			while(!self usebuttonpressed() && var_01 < 0.5)
			{
				var_01 = var_01 + 0.05;
				wait(0.05);
			}

			if(var_01 >= 0.5)
			{
				continue;
			}

			if(!self.var_CC4C.size)
			{
				return;
			}

			if(!lib_0D12::func_9DDF(self))
			{
				self notify("alt_detonate");
			}
		}

		wait(0.05);
	}
}

//Function Number: 135
func_139C4()
{
	self notify("watchC4AltDetonation");
	self endon("watchC4AltDetonation");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("alt_detonate");
		var_00 = self getcurrentweapon();
		if(var_00 != "c4_zm")
		{
			func_3349();
		}
	}
}

//Function Number: 136
func_139C5()
{
	self notify("watchC4Detonation");
	self endon("watchC4Detonation");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittillmatch("c4_zm","detonate");
		func_3349();
	}
}

//Function Number: 137
func_3349()
{
	foreach(var_01 in self.var_CC4C)
	{
		if(isdefined(var_01) && var_01.var_13C2E == "c4_zm")
		{
			var_01 thread func_1369A(0.1);
			scripts\common\utility::func_22A9(self.var_CC4C,var_01);
		}
	}

	self notify("c4_update",0);
	waittillframeend;
	self notify("detonated");
}

//Function Number: 138
func_1369A(param_00)
{
	self endon("death");
	wait(param_00);
	func_1382F();
	self notify("detonateExplosive");
}

//Function Number: 139
func_1382F()
{
	if(!isdefined(self.var_55BA))
	{
		return;
	}

	self waittill("enabled");
}

//Function Number: 140
func_42DE()
{
	var_00 = self.var_C731;
	var_00 endon("disconnect");
	thread func_C836(var_00);
	var_01 = [];
	for(var_02 = 0;var_02 < 4;var_02++)
	{
		var_01[var_02] = 0.2;
	}

	var_03 = 0;
	foreach(var_05 in var_01)
	{
		var_03 = var_03 + var_05;
	}

	var_07 = spawn("script_model",self.origin);
	var_07 linkto(self);
	var_07 setmodel("tag_origin");
	var_07 setscriptmoverkillcam("explosive");
	var_07 thread func_4E3D(self,var_03 + 5);
	var_07 thread func_C836(self.var_222);
	var_07.var_117F3 = self.var_117F3;
	var_08 = var_00 scripts\cp\_utility::func_1302("cluster_grenade_indicator_mp",self.origin,(0,0,0));
	var_08 linkto(self);
	var_08 thread func_4E3D(self,var_03);
	var_08 thread func_C836(self.var_222);
	thread scripts\cp\_utility::func_C15A("death","end_explode");
	self endon("end_explode");
	self waittill("explode",var_09);
	thread func_42DA(var_09,var_01,var_00,var_07);
}

//Function Number: 141
func_42DA(param_00,param_01,param_02,param_03)
{
	param_02 endon("disconnect");
	var_04 = scripts\common\trace::func_48BC(0,1,1,0,1,0,0);
	var_05 = 0;
	var_06 = param_00 + (0,0,3);
	var_07 = var_06 + (0,0,-5);
	var_08 = function_0287(var_06,var_07,var_04,undefined,0,"physicsquery_closest");
	if(isdefined(var_08) && var_08.size > 0)
	{
		var_05 = 1;
	}

	var_09 = scripts\common\utility::func_116D7(var_05,(0,0,32),(0,0,2));
	var_0A = param_00 + var_09;
	var_0B = randomint(90) - 45;
	var_04 = scripts\common\trace::func_48BC(0,1,1,0,1,0,0);
	for(var_0C = 0;var_0C < 4;var_0C++)
	{
		param_03.var_FC6A = scripts\common\utility::func_116D7(var_0C == 0,1,undefined);
		param_03 radiusdamage(param_00,256,800,400,param_02,"MOD_EXPLOSIVE","cluster_grenade_zm");
		var_0D = scripts\common\utility::func_116D7(var_0C < 4,90 * var_0C + var_0B,randomint(360));
		var_0E = scripts\common\utility::func_116D7(var_05,110,90);
		var_0F = scripts\common\utility::func_116D7(var_05,12,45);
		var_10 = var_0E + randomint(var_0F * 2) - var_0F;
		var_11 = randomint(60) + 30;
		var_12 = cos(var_0D) * sin(var_10);
		var_13 = sin(var_0D) * sin(var_10);
		var_14 = cos(var_10);
		var_15 = (var_12,var_13,var_14) * var_11;
		var_06 = var_0A;
		var_07 = var_0A + var_15;
		var_08 = function_0287(var_06,var_07,var_04,undefined,0,"physicsquery_closest");
		if(isdefined(var_08) && var_08.size > 0)
		{
			var_07 = var_08[0]["position"];
		}

		playfx(scripts\common\utility::getfx("clusterGrenade_explode"),var_07);
		switch(var_0C)
		{
			case 0:
				playsoundatpos(var_07,"frag_grenade_explode");
				break;

			case 3:
				playsoundatpos(var_07,"cluster_explode_end");
				break;

			default:
				playsoundatpos(var_07,"cluster_explode_mid");
				break;
		}

		wait(param_01[var_0C]);
	}
}

//Function Number: 142
func_4E3D(param_00,param_01)
{
	self endon("death");
	param_00 waittill("death");
	wait(param_01);
	self delete();
}

//Function Number: 143
func_C836(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self delete();
}

//Function Number: 144
func_F21A(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_00.var_13C2E))
	{
		return;
	}

	if(!issubstr(param_00.var_13C2E,"semtex") && param_00.var_13C2E != "iw6_mk32_mp")
	{
		return;
	}

	param_00.var_C731 = self;
	param_00 waittill("missile_stuck",var_01);
	param_00 thread func_858A();
	param_00 func_69FF(undefined);
}

//Function Number: 145
func_DFC7(param_00,param_01,param_02)
{
	if(!isdefined(param_00) && !isdefined(param_01))
	{
		return;
	}

	var_03 = [];
	var_04 = undefined;
	var_05 = undefined;
	if(isdefined(param_02))
	{
		var_03[var_03.size] = param_02;
	}
	else
	{
		var_03 = param_01 getweaponslistall();
	}

	foreach(var_07 in var_03)
	{
		if(param_01 func_8BD1(var_07,param_00))
		{
			var_08 = scripts\cp\_utility::func_80D8(var_07);
			var_09 = getweaponbasename(var_07);
			param_01 takeweapon(var_07);
			var_0A = function_00E3(var_07);
			foreach(var_0C in var_0A)
			{
				if(issubstr(var_0C,param_00))
				{
					var_0A = scripts\common\utility::func_22A9(var_0A,var_0C);
					break;
				}
			}

			if(isdefined(level.var_31CF))
			{
				var_05 = param_01 [[ level.var_31CF ]](var_09,undefined,var_0A);
			}

			if(isdefined(var_05))
			{
				var_03 = self getweaponslistprimaries();
				foreach(param_02 in var_03)
				{
					if(issubstr(param_02,var_05))
					{
						if(scripts\cp\_utility::func_9D3E(param_02))
						{
							var_09 = getweaponbasename(param_02);
							if(isdefined(level.mode_weapons_allowed) && scripts\common\utility::func_2286(level.mode_weapons_allowed,var_09))
							{
								var_05 = "alt_" + var_05;
								break;
							}
						}
					}
				}

				param_01 scripts\cp\_utility::func_12C6(var_05,-1,-1,1);
				param_01 switchtoweapon(var_05);
			}
		}
	}
}

//Function Number: 146
func_8BD1(param_00,param_01)
{
	var_02 = strtok(param_00,"+");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(var_02[var_03] == param_01)
		{
			return 1;
		}

		if(issubstr(var_02[var_03],param_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 147
func_7DDC()
{
	var_00 = [];
	var_01 = ["mp/attachmentTable.csv","cp/zombies/zombie_attachmenttable.csv"];
	foreach(var_03 in var_01)
	{
		var_04 = 0;
		for(var_05 = tablelookup(var_03,0,var_04,5);var_05 != "";var_05 = tablelookup(var_03,0,var_04,5))
		{
			if(!scripts\common\utility::func_2286(var_00,var_05))
			{
				var_00[var_00.size] = var_05;
			}

			var_04++;
		}
	}

	return var_00;
}

//Function Number: 148
func_7DCF()
{
	var_00 = [];
	var_01 = 0;
	var_02 = tablelookup("cp/zombies/zombie_attachmenttable.csv",0,var_01,5);
	while(var_02 != "")
	{
		if(!scripts\common\utility::func_2286(var_00,var_02))
		{
			var_00[var_00.size] = var_02;
		}

		var_01++;
		var_02 = tablelookup("cp/zombies/zombie_attachmenttable.csv",0,var_01,5);
	}

	return var_00;
}

//Function Number: 149
func_8BBB(param_00)
{
	var_01 = self getweaponslistall();
	foreach(var_03 in var_01)
	{
		var_04 = scripts\cp\_utility::func_80D8(param_00);
		var_05 = scripts\cp\_utility::func_80D8(var_03);
		if(var_04 == var_05)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 150
func_48A4(param_00,param_01,param_02)
{
	level.var_2497 = [];
	level.var_2498 = [];
	foreach(var_04 in param_00)
	{
		var_05 = tablelookup(param_01,4,var_04,5);
		if(param_02 == "zombie")
		{
			if(!isdefined(var_05) || var_05 == "")
			{
				var_05 = tablelookup("cp/zombies/zombie_attachmenttable.csv",4,var_04,5);
			}
		}

		if(var_04 == var_05)
		{
			continue;
		}

		level.var_2497[var_04] = var_05;
		var_06 = tablelookup("mp/attachmenttable.csv",4,var_04,13);
		if(var_06 != "")
		{
			level.var_2498[var_04] = var_06;
			level.var_248B[var_06] = 1;
		}
	}
}

//Function Number: 151
func_31D5()
{
	var_00 = ["mp/attachmentTable.csv","cp/zombies/zombie_attachmenttable.csv"];
	var_01 = ["mp/attachmentmap.csv","cp/zombies/zombie_attachmentmap.csv"];
	level.var_2497 = [];
	level.var_2498 = [];
	level.var_248B = [];
	level.var_2491 = [];
	level.var_2493 = [];
	level.var_2492 = [];
	foreach(var_24, var_03 in var_00)
	{
		var_04 = func_7DDF(var_03);
		foreach(var_06 in var_04)
		{
			var_07 = tablelookup(var_03,4,var_06,5);
			if(var_06 != var_07)
			{
				level.var_2497[var_06] = var_07;
			}

			var_08 = tablelookup(var_03,4,var_06,13);
			if(var_08 != "")
			{
				level.var_2498[var_06] = var_08;
				level.var_248B[var_08] = 1;
			}
		}

		foreach(var_0B in var_01)
		{
			var_0C = [];
			var_0D = 1;
			for(var_0E = tablelookupbyrow(var_0B,var_0D,0);var_0E != "";var_0E = tablelookupbyrow(var_0B,var_0D,0))
			{
				var_0C[var_0C.size] = var_0E;
				var_0D++;
			}

			var_0F = [];
			var_10 = 1;
			for(var_11 = tablelookupbyrow(var_0B,0,var_10);var_11 != "";var_11 = tablelookupbyrow(var_0B,0,var_10))
			{
				var_0F[var_11] = var_10;
				var_10++;
			}

			foreach(var_0E in var_0C)
			{
				foreach(var_16, var_14 in var_0F)
				{
					var_15 = tablelookup(var_0B,0,var_0E,var_14);
					if(var_15 == "")
					{
						continue;
					}

					if(!isdefined(level.var_2492[var_0E]))
					{
						level.var_2492[var_0E] = [];
					}

					level.var_2492[var_0E][var_16] = var_15;
				}
			}

			foreach(var_19 in var_04)
			{
				var_1A = tablelookup(var_03,4,var_19,12);
				if(var_1A == "")
				{
					continue;
				}

				level.var_2491[var_19] = var_1A;
			}

			var_1C = 1;
			var_1D = tablelookupbyrow("mp/attachmentcombos.csv",var_1C,0);
			while(var_1D != "")
			{
				var_1E = 1;
				var_1F = tablelookupbyrow("mp/attachmentcombos.csv",0,var_1E);
				while(var_1F != "")
				{
					if(var_1D != var_1F)
					{
						var_20 = tablelookupbyrow("mp/attachmentcombos.csv",var_1C,var_1E);
						var_21 = scripts\common\utility::func_1D3A([var_1D,var_1F]);
						var_22 = var_21[0] + "_" + var_21[1];
						if(var_20 == "no" && !isdefined(level.var_2493[var_22]))
						{
							level.var_2493[var_22] = 1;
						}
					}

					var_1E++;
					var_1F = tablelookupbyrow("mp/attachmentcombos.csv",0,var_1E);
				}

				var_1C++;
				var_1D = tablelookupbyrow("mp/attachmentcombos.csv",var_1C,0);
			}
		}
	}
}

//Function Number: 152
func_4980(param_00,param_01,param_02,param_03)
{
	if(param_00 == "zombie")
	{
		foreach(var_05 in param_01)
		{
			foreach(var_09, var_07 in param_02)
			{
				var_08 = tablelookup(param_03,0,var_05,var_07);
				if(var_08 == "")
				{
					continue;
				}

				if(!isdefined(level.var_2492[var_05]))
				{
					level.var_2492[var_05] = [];
				}

				if(var_08 == "none")
				{
					level.var_2492[var_05][var_09] = undefined;
					continue;
				}

				level.var_2492[var_05][var_09] = var_08;
			}
		}
	}
}

//Function Number: 153
func_7DDF(param_00)
{
	var_01 = getdvar("g_gametype");
	var_02 = [];
	var_03 = 0;
	for(var_04 = tablelookup(param_00,0,var_03,4);var_04 != "";var_04 = tablelookup(param_00,0,var_03,4))
	{
		var_02[var_02.size] = var_04;
		var_03++;
	}

	return var_02;
}

//Function Number: 154
func_858A(param_00)
{
	self notify("grenade_earthQuake");
	self endon("grenade_earthQuake");
	thread func_636E();
	self endon("end_explode");
	var_01 = undefined;
	if(!isdefined(param_00) || param_00)
	{
		self waittill("explode",var_01);
	}
	else
	{
		var_01 = self.origin;
	}

	playrumbleonposition("grenade_rumble",var_01);
	earthquake(0.5,0.75,var_01,800);
	foreach(var_03 in level.players)
	{
		if(var_03 scripts\cp\_utility::func_9FC6())
		{
			continue;
		}

		if(distancesquared(var_01,var_03.origin) > 360000)
		{
			continue;
		}

		if(var_03 method_808F(var_01))
		{
			var_03 thread func_54F0(var_01);
		}

		var_03 setclientomnvar("ui_hud_shake",1);
	}
}

//Function Number: 155
func_3337()
{
	thread func_636E();
	self endon("end_explode");
	self waittill("explode",var_00);
	playrumbleonposition("grenade_rumble",var_00);
	earthquake(0.4,0.75,var_00,512);
	foreach(var_02 in level.players)
	{
		if(var_02 scripts\cp\_utility::func_9FC6())
		{
			continue;
		}

		if(distance(var_00,var_02.origin) > 512)
		{
			continue;
		}

		if(var_02 method_808F(var_00))
		{
			var_02 thread func_54F0(var_00);
		}

		var_02 setclientomnvar("ui_hud_shake",1);
	}
}

//Function Number: 156
func_636E()
{
	self waittill("death");
	waittillframeend;
	self notify("end_explode");
}

//Function Number: 157
func_54F0(param_00)
{
	self notify("dirtEffect");
	self endon("dirtEffect");
	self endon("disconnect");
	if(!scripts\cp\_utility::func_9F19(self))
	{
		return;
	}

	var_01 = vectornormalize(anglestoforward(self.angles));
	var_02 = vectornormalize(anglestoright(self.angles));
	var_03 = vectornormalize(param_00 - self.origin);
	var_04 = vectordot(var_03,var_01);
	var_05 = vectordot(var_03,var_02);
	var_06 = ["death","damage"];
	if(var_04 > 0 && var_04 > 0.5 && self getcurrentweapon() != "iw6_riotshield_mp")
	{
		scripts\common\utility::func_1372E(var_06,2);
		return;
	}

	if(abs(var_04) < 0.866)
	{
		if(var_05 > 0)
		{
			scripts\common\utility::func_1372E(var_06,2);
			return;
		}

		scripts\common\utility::func_1372E(var_06,2);
		return;
	}
}

//Function Number: 158
func_FC6A(param_00,param_01)
{
	if(func_9DFA())
	{
		return;
	}

	if(param_00 == "MOD_EXPLOSIVE" || param_00 == "MOD_GRENADE" || param_00 == "MOD_GRENADE_SPLASH" || param_00 == "MOD_PROJECTILE" || param_00 == "MOD_PROJECTILE_SPLASH")
	{
		if(param_01 > 10)
		{
			if(isdefined(self.var_FC6B) && self.var_FC6B)
			{
				self shellshock("frag_grenade_mp",self.var_FC6B);
				return;
			}

			self shellshock("frag_grenade_mp",0.5);
			return;
		}
	}
}

//Function Number: 159
func_9DFA()
{
	return isdefined(self.var_6ECA) && gettime() < self.var_6ECA;
}

//Function Number: 160
func_1377A()
{
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01,var_02);
		if(isdefined(self.var_11817) && var_01 != self.var_11817)
		{
			continue;
		}

		if(isdefined(var_00))
		{
			if(!isdefined(var_00.var_13C2E))
			{
				var_00.var_13C2E = var_01;
			}

			if(!isdefined(var_00.var_222))
			{
				var_00.var_222 = self;
			}

			if(!isdefined(var_00.team))
			{
				var_00.team = self.team;
			}

			if(!isdefined(var_00.var_118A2) && isdefined(self.var_11817))
			{
				var_00.var_118A2 = scripts\cp\_utility::func_E76A(4 * var_02);
			}
		}

		if(!scripts\cp\_utility::func_9F19(self) && !isdefined(self.var_1182A))
		{
			self notify("grenade_fire_dead",var_00,var_01);
			self.var_1182A = 1;
		}

		return var_00;
	}
}

//Function Number: 161
func_3862(param_00,param_01)
{
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}
	else
	{
		var_02 = self getcurrentweapon();
	}

	var_03 = getweaponbasename(var_02);
	var_04 = scripts\cp\_utility::func_4626(var_03);
	var_05 = func_7BCA(var_04,var_03,param_00);
	if(!var_05)
	{
		return 0;
	}

	return 1;
}

//Function Number: 162
func_169D(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01))
	{
		var_04 = param_01;
	}
	else
	{
		var_04 = scripts\cp\_utility::getvalidtakeweapon();
	}

	var_05 = getweaponbasename(var_04);
	var_06 = 0;
	var_07 = function_00E3(var_04);
	var_08 = scripts\cp\_utility::getcurrentcamoname(var_04);
	var_09 = func_E469(var_04,param_00,var_07,undefined,var_08);
	if(!isdefined(var_09) || isdefined(var_09) && var_09 == "none")
	{
		return 0;
	}

	var_0A = scripts\cp\_utility::func_9D3E(param_01);
	if(scripts\cp\_utility::func_13C90(var_09,"xmags"))
	{
		var_06 = 1;
	}

	if(isdefined(param_00))
	{
		if(!issubstr(param_00,"pap"))
		{
			var_0B = self getweaponammoclip(var_04);
			var_0C = self getweaponammostock(var_04);
			if(issubstr(var_09,"akimbo"))
			{
				var_0D = self getweaponammoclip(var_04,"left");
			}
			else
			{
				var_0D = undefined;
			}

			self takeweapon(var_04);
			scripts\cp\_utility::func_12C6(var_09,undefined,undefined,1);
			if(scripts\cp\_utility::func_13C90(var_09,"xmags") && !var_06)
			{
				var_0B = weaponclipsize(var_09);
			}

			self setweaponammoclip(var_09,var_0B);
			self setweaponammostock(var_09,var_0C);
			if(isdefined(var_0D))
			{
				self setweaponammoclip(var_09,var_0D,"left");
			}
		}
		else
		{
			if(issubstr(var_09,"katana") || issubstr(var_09,"nunchucks"))
			{
			}

			self takeweapon(var_04);
			scripts\cp\_utility::func_12C6(var_09,undefined,undefined,0);
			self givemaxammo(var_09);
		}
	}

	self playlocalsound("weap_raise_large_plr");
	var_0E = self getweaponslistprimaries();
	foreach(param_01 in var_0E)
	{
		if(issubstr(param_01,var_09))
		{
			if(scripts\cp\_utility::func_9D3E(param_01))
			{
				var_10 = getweaponbasename(param_01);
				if((isdefined(level.mode_weapons_allowed) && scripts\common\utility::func_2286(level.mode_weapons_allowed,var_10)) || var_0A)
				{
					var_09 = "alt_" + var_09;
					break;
				}
			}
		}
	}

	if(scripts\common\utility::istrue(param_03))
	{
		return 1;
	}

	if(scripts\common\utility::istrue(param_02))
	{
		self method_83B6(var_09);
	}
	else
	{
		self switchtoweapon(var_09);
	}

	return 1;
}

//Function Number: 163
func_9E02(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = getweaponbasename(param_00);
	if(isdefined(var_01))
	{
		if(var_01 == "iw7_forgefreeze_zm" || var_01 == "iw7_forgefreeze_zm_pap1" || var_01 == "iw7_forgefreeze_zm_pap2" || var_01 == "zfreeze_semtex_mp")
		{
			if(scripts\cp\_utility::func_9D3E(param_00))
			{
				return 0;
			}
			else
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 164
func_9D3D(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = getweaponbasename(param_00);
	if(isdefined(var_01))
	{
		if(var_01 == "iw7_forgefreeze_zm" || var_01 == "iw7_forgefreeze_zm_pap1" || var_01 == "iw7_forgefreeze_zm_pap2" || var_01 == "zfreeze_semtex_mp")
		{
			if(scripts\cp\_utility::func_9D3E(param_00))
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
	}

	return 0;
}

//Function Number: 165
func_9F79(param_00)
{
	var_01 = getweaponbasename(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return var_01 == "iw7_steeldragon_zm";
}

//Function Number: 166
func_9C62(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "doubletap")
	{
		return 1;
	}

	return 0;
}

//Function Number: 167
func_9B6B(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(issubstr(param_00,"ark"))
	{
		return 1;
	}

	if(issubstr(param_00,"arcane"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 168
func_9C43(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(issubstr(param_00,"mod"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 169
func_9BB4(param_00,param_01)
{
	var_02 = scripts\cp\_utility::func_13C76(param_01);
	if(!isdefined(var_02) || var_02.size < 1)
	{
		return 0;
	}

	foreach(var_04 in var_02)
	{
		if(param_00 == var_04)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 170
func_9C5E(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(issubstr(param_00,"pap"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 171
func_7BCA(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	if(!isdefined(param_02))
	{
		return 0;
	}

	var_03 = [];
	var_04 = scripts\cp\_utility::func_7DF7(param_01);
	if(isdefined(level.var_2492[var_04]))
	{
		if(isdefined(level.var_2492[var_04][param_02]))
		{
			if(level.var_2492[var_04][param_02] != "none")
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
	}

	if(isdefined(level.var_2492[param_00]))
	{
		if(isdefined(level.var_2492[param_00][param_02]))
		{
			if(level.var_2492[param_00][param_02] != "none")
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
	}

	if(isdefined(level.var_2492[var_04]))
	{
		var_05 = getarraykeys(level.var_2492[var_04]);
		foreach(var_07 in var_05)
		{
			if(level.var_2492[var_04][var_07] == param_02)
			{
				if(level.var_2492[var_04][var_07] != "none")
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
		}
	}

	if(isdefined(level.var_2492[param_00]))
	{
		var_05 = getarraykeys(level.var_2492[param_00]);
		foreach(var_07 in var_05)
		{
			if(level.var_2492[param_00][var_07] == param_02)
			{
				if(level.var_2492[param_00][var_07] != "none")
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
		}
	}

	return 0;
}

//Function Number: 172
func_E469(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_00))
	{
		var_05 = param_00;
	}
	else
	{
		var_05 = self getcurrentweapon();
	}

	var_06 = getweaponbasename(var_05);
	var_07 = scripts\cp\_utility::func_7D72(self,var_05);
	var_08 = 0;
	var_09 = 0;
	var_0A = 0;
	var_0B = 0;
	var_0C = undefined;
	var_0D = [];
	var_0E = 7;
	var_0F = [];
	var_10 = 1;
	var_11 = [];
	var_12 = 1;
	var_13 = [];
	var_14 = 4;
	var_15 = [];
	var_16 = 1;
	var_17 = [];
	var_18 = 1;
	var_19 = [];
	var_1A = 15;
	var_1B = scripts\cp\_utility::func_4626(var_06);
	if(scripts\cp\_utility::func_13C90(var_05,"xmags"))
	{
		var_09 = 1;
	}

	var_1C = func_7BCA(var_1B,var_06,param_01);
	if(!var_1C && isdefined(param_01))
	{
		if(!scripts\common\utility::istrue(param_03))
		{
			scripts\cp\_utility::setlowermessage("cant_attach",&"COOP_PILLAGE_CANT_USE",3);
		}

		return undefined;
	}

	if(!isdefined(param_02))
	{
		param_02 = function_00E3(var_05);
	}

	if(scripts\cp\_utility::has_zombie_perk("perk_machine_rat_a_tat"))
	{
		if(func_7BCA(var_1B,var_06,"doubletap"))
		{
			param_02[param_02.size] = "doubletap";
		}
	}

	if(isdefined(param_01))
	{
		if(weaponclass(param_00) == "spread")
		{
			if(issubstr(param_01,"arkyellow"))
			{
				foreach(var_1E in param_02)
				{
					if(issubstr(var_1E,"smart"))
					{
						param_02 = scripts\common\utility::func_22A9(param_02,var_1E);
					}
				}
			}
		}
	}

	param_02 = scripts\common\utility::func_22AF(param_02);
	param_02 = scripts\common\utility::func_22BC(param_02);
	if(param_02.size > 0 && param_02.size <= var_1A)
	{
		foreach(var_21 in param_02)
		{
			if(func_9C5E(var_21))
			{
				if(var_11.size < var_12)
				{
					var_11[var_11.size] = var_21;
					var_19[var_19.size] = var_21;
				}
				else
				{
					continue;
				}

				continue;
			}

			if(func_9B6B(var_21))
			{
				if(var_17.size < var_18)
				{
					var_17[var_17.size] = var_21;
					var_19[var_19.size] = var_21;
				}
				else
				{
					continue;
				}

				continue;
			}

			if(func_9C43(var_21))
			{
				if(var_13.size < var_14)
				{
					var_13[var_13.size] = var_21;
					var_19[var_19.size] = var_21;
				}
				else
				{
					continue;
				}

				continue;
			}

			if(func_9BB4(var_21,scripts\cp\_utility::func_8234(var_06)))
			{
				if(var_15.size < var_16)
				{
					var_15[var_15.size] = var_21;
					var_19[var_19.size] = var_21;
				}
				else
				{
					continue;
				}

				continue;
			}

			if(func_9C62(var_21))
			{
				if(var_0F.size < var_10)
				{
					var_0F[var_0F.size] = var_21;
					var_19[var_19.size] = var_21;
				}
				else
				{
					continue;
				}

				continue;
			}

			if(var_0D.size < var_0E)
			{
				var_0D[var_0D.size] = var_21;
				var_19[var_19.size] = var_21;
				continue;
			}

			continue;
		}
	}

	if(isdefined(param_01))
	{
		var_23 = scripts\cp\_utility::func_2494(param_01);
		if(isdefined(var_23) && var_23 != "none")
		{
			for(var_24 = 0;var_24 < var_19.size;var_24++)
			{
				var_25 = scripts\cp\_utility::func_2494(var_19[var_24]);
				if(var_25 == var_23)
				{
					var_19[var_24] = param_01;
					var_08 = 1;
					break;
				}
			}
		}

		var_26 = scripts\cp\_utility::getattachmenttype(param_01);
		if(isdefined(var_26) && var_26 != "none")
		{
			if(!var_08)
			{
				if(func_9C5E(param_01))
				{
					if(var_11.size < var_12)
					{
						var_11[var_11.size] = param_01;
						var_19[var_19.size] = param_01;
					}
					else
					{
						for(var_24 = 0;var_24 < var_19.size;var_24++)
						{
							var_27 = scripts\cp\_utility::getattachmenttype(var_19[var_24]);
							if(var_27 == var_26)
							{
								var_11[var_11.size] = param_01;
								var_19[var_24] = param_01;
								var_08 = 1;
								break;
							}
						}
					}
				}
				else if(func_9B6B(param_01))
				{
					if(var_17.size < var_18)
					{
						var_17[var_17.size] = param_01;
						var_19[var_19.size] = param_01;
					}
					else
					{
						for(var_24 = 0;var_24 < var_19.size;var_24++)
						{
							var_27 = scripts\cp\_utility::getattachmenttype(var_19[var_24]);
							if(var_27 == var_26)
							{
								var_17[var_0F.size] = param_01;
								var_19[var_24] = param_01;
								var_08 = 1;
								break;
							}
						}
					}
				}
				else if(func_9C62(param_01))
				{
					if(var_0F.size < var_10)
					{
						var_0F[var_0F.size] = param_01;
						var_19[var_19.size] = param_01;
					}
					else
					{
						for(var_24 = 0;var_24 < var_19.size;var_24++)
						{
							var_27 = scripts\cp\_utility::getattachmenttype(var_19[var_24]);
							if(var_27 == var_26)
							{
								var_0F[var_0F.size] = param_01;
								var_19[var_24] = param_01;
								var_08 = 1;
								break;
							}
						}
					}
				}
				else if(var_0D.size < var_0E)
				{
					var_0D[var_0D.size] = param_01;
					var_19[var_19.size] = param_01;
				}
				else
				{
					for(var_24 = 0;var_24 < var_19.size;var_24++)
					{
						var_27 = scripts\cp\_utility::getattachmenttype(var_19[var_24]);
						if(var_27 == var_26)
						{
							var_0D[var_0D.size] = param_01;
							var_19[var_24] = param_01;
							var_08 = 1;
							break;
						}
					}

					if(!var_08)
					{
						return undefined;
					}
				}
			}
			else if(func_9C62(param_01))
			{
				var_11[var_11.size] = param_01;
				var_19[var_19.size] = param_01;
			}
			else if(func_9C5E(param_01))
			{
				var_0F[var_0F.size] = param_01;
				var_19[var_19.size] = param_01;
			}
			else if(func_9B6B(param_01))
			{
				var_17[var_17.size] = param_01;
				var_19[var_19.size] = param_01;
			}
			else
			{
				var_0D[var_0D.size] = param_01;
				var_19[var_19.size] = param_01;
			}
		}
		else if(isdefined(param_01))
		{
			if(func_9C62(param_01))
			{
				var_0F[var_0F.size] = param_01;
				var_19[var_19.size] = param_01;
			}
			else if(func_9C5E(param_01))
			{
				var_11[var_11.size] = param_01;
				var_19[var_19.size] = param_01;
			}
			else if(func_9B6B(param_01))
			{
				var_17[var_17.size] = param_01;
				var_19[var_19.size] = param_01;
			}
			else
			{
				var_0D[var_0D.size] = param_01;
				var_19[var_19.size] = param_01;
			}
		}
	}

	var_28 = scripts\cp\_utility::func_8234(var_06);
	var_29 = isdefined(self.var_13C00[scripts\cp\_utility::func_80D8(var_05)]);
	if(!isdefined(param_04) && var_29)
	{
		var_0A = scripts\cp\_utility::getweaponcamo(var_28);
	}
	else
	{
		var_0A = param_04;
	}

	if(var_29)
	{
		var_2A = 0;
		foreach(var_1E in var_19)
		{
			if(issubstr(var_1E,"cos_"))
			{
				var_2A = 1;
				var_0C = undefined;
				break;
			}
		}

		if(!var_2A)
		{
			var_0C = scripts\cp\_utility::getweaponcosmeticattachment(var_28);
		}

		var_0B = scripts\cp\_utility::getweaponreticle(var_28);
		var_2D = scripts\cp\_utility::getweaponpaintjobid(var_28);
	}
	else
	{
		var_0D = undefined;
		var_0C = undefined;
		var_2D = undefined;
	}

	foreach(var_1E in var_19)
	{
		if(issubstr(var_1E,"arcane") || issubstr(var_1E,"ark"))
		{
			foreach(var_30 in var_19)
			{
				if(var_1E == var_30)
				{
					continue;
				}

				if(issubstr(var_30,"cos_"))
				{
					var_19 = scripts\common\utility::func_22A9(var_19,var_30);
				}
			}

			var_0C = undefined;
		}
	}

	var_33 = scripts\cp\_utility::func_BD68(var_28,var_19,var_0A,var_0B,var_07,self getentitynumber(),self.var_41F0,var_2D,var_0C);
	if(isdefined(var_33))
	{
		return var_33;
	}

	return var_05;
}

//Function Number: 173
func_7DE2(param_00,param_01)
{
	var_02 = scripts\cp\_utility::func_8217(param_00);
	var_03 = [];
	foreach(var_05 in var_02)
	{
		var_06 = scripts\cp\_utility::getattachmenttype(var_05);
		if(isdefined(param_01) && scripts\cp\_utility::func_AD7F(param_01,var_05))
		{
			continue;
		}

		if(!isdefined(var_03[var_06]))
		{
			var_03[var_06] = [];
		}

		var_07 = var_03[var_06];
		var_07[var_07.size] = var_05;
		var_03[var_06] = var_07;
	}

	return var_03;
}

//Function Number: 174
func_7DDD()
{
	var_00 = [];
	var_01 = ["mp/attachmentTable.csv","cp/zombies/zombie_attachmenttable.csv"];
	foreach(var_03 in var_01)
	{
		var_04 = 0;
		for(var_05 = tablelookup(var_03,0,var_04,5);var_05 != "";var_05 = tablelookup(var_03,0,var_04,5))
		{
			var_06 = tablelookup(var_03,0,var_04,2);
			if(var_06 != "none" && !scripts\common\utility::func_2286(var_00,var_05))
			{
				var_00[var_00.size] = var_05;
			}

			var_04++;
		}
	}

	return var_00;
}

//Function Number: 175
func_8216(param_00)
{
	var_01 = [];
	var_02 = scripts\cp\_utility::func_7DF7(param_00);
	var_03 = scripts\cp\_utility::func_4626(param_00);
	if(isdefined(level.var_2492[var_02]))
	{
		var_01 = scripts\common\utility::array_combine(var_01,level.var_2492[var_02]);
	}

	if(isdefined(level.var_2492[var_03]))
	{
		var_01 = scripts\common\utility::array_combine(var_01,level.var_2492[var_03]);
	}

	return var_01;
}

//Function Number: 176
func_9FED(param_00)
{
	if(!isdefined(level.var_13CBF))
	{
		level.var_13CBF = [];
		foreach(var_02 in level.var_13CA0)
		{
			level.var_13CBF[var_02] = 1;
		}
	}

	if(isdefined(level.var_13CBF[param_00]))
	{
		return 1;
	}

	return 0;
}

//Function Number: 177
func_FB18()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetWeaponLaser");
	self.var_CA6A = 0;
	var_00 = self getcurrentweapon();
	for(;;)
	{
		func_FB1C(var_00);
		if(self.var_CA6A == 0)
		{
			self.var_CA6A = 1;
			func_6282();
		}

		childthread func_FB19();
		childthread func_FB1A(1);
		self.var_CA69 = undefined;
		self waittill("weapon_change",var_00);
		if(self.var_CA6A == 1)
		{
			self.var_CA6A = 0;
			func_561C();
		}
	}
}

//Function Number: 178
func_FB1C(param_00)
{
	for(;;)
	{
		param_00 = getweaponbasename(param_00);
		if(isdefined(param_00) && param_00 == "iw6_kac_mp" || param_00 == "iw6_arx160_mp")
		{
			break;
		}

		self waittill("weapon_change",param_00);
	}
}

//Function Number: 179
func_FB19()
{
	self endon("weapon_change");
	for(;;)
	{
		if(!isdefined(self.var_CA69) || self.var_CA69 == 0)
		{
			if(self method_822E() > 0.6)
			{
				if(self.var_CA6A == 1)
				{
					self.var_CA6A = 0;
					func_561C();
				}
			}
			else if(self.var_CA6A == 0)
			{
				self.var_CA6A = 1;
				func_6282();
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 180
func_FB1A(param_00)
{
	self endon("weapon_change");
	for(;;)
	{
		self waittill("weapon_switch_started");
		childthread func_FB1B(param_00);
	}
}

//Function Number: 181
func_FB1B(param_00)
{
	self notify("setWeaponLaser_onWeaponSwitchStart");
	self endon("setWeaponLaser_onWeaponSwitchStart");
	if(self.var_CA6A == 1)
	{
		self.var_CA69 = 1;
		self.var_CA6A = 0;
		func_561C();
	}

	wait(param_00);
	self.var_CA69 = undefined;
	if(self.var_CA6A == 0 && self method_822E() <= 0.6)
	{
		self.var_CA6A = 1;
		func_6282();
	}
}

//Function Number: 182
func_6282()
{
	if(!isdefined(self.var_13C9E))
	{
		self.var_13C9E = 0;
	}

	self.var_13C9E++;
	self method_81D9();
}

//Function Number: 183
func_561C()
{
	self.var_13C9E--;
	if(self.var_13C9E == 0)
	{
		self method_81D8();
		self.var_13C9E = undefined;
	}
}

//Function Number: 184
func_C4F4(param_00)
{
	self endon("death");
	level endon("game_ended");
	thread func_40F5();
	self waittill("detonateExplosive");
	if(isdefined(param_00))
	{
		self.var_222 notify(param_00,1);
	}
	else
	{
		self.var_222 notify("powers_c4_used",1);
	}

	self method_8099(self.var_222);
}

//Function Number: 185
func_40F5()
{
	self endon("deleted_equipment");
	level endon("game_ended");
	var_00 = self getentitynumber();
	var_01 = self.var_A63A;
	var_02 = self.trigger;
	var_03 = self.var_F232;
	self waittill("death");
	func_40F4(var_00,var_01,var_02,var_03);
}

//Function Number: 186
func_40F4(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_13C2E))
	{
		if(self.var_13C2E == "c4_zm")
		{
			self.var_222 notify("c4_update",0);
		}
		else if(self.var_13C2E == "bouncingbetty_mp")
		{
			self.var_222 notify("bouncing_betty_update",0);
		}
		else if(self.var_13C2E == "sticky_mine_mp")
		{
			self.var_222 notify("sticky_mine_update",0);
		}
		else if(self.var_13C2E == "trip_mine_mp")
		{
			self.var_222 notify("trip_mine_update",0);
		}
		else if(self.var_13C2E == "cryo_grenade_mp")
		{
			self.var_222 notify("restart_cryo_grenade_cooldown",0);
		}
	}

	if(isdefined(param_00))
	{
		level.var_B779[param_00] = undefined;
	}

	if(isdefined(param_01))
	{
		param_01 delete();
	}

	if(isdefined(param_02))
	{
		param_02 delete();
	}

	if(isdefined(param_03))
	{
		param_03 delete();
	}
}

//Function Number: 187
func_B9C6(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	level endon("game_ended");
	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	self setcandamage(1);
	self.health = 999999;
	self.maxhealth = param_00;
	self.var_E1 = 0;
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	for(var_06 = 1;var_06;var_06 = func_B9C7(var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,param_01,param_02,param_03,param_04))
	{
		self waittill("damage",var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10);
		if(param_05)
		{
			self playrumbleonentity("damage_light");
		}

		if(isdefined(self.var_8DD9) && self.var_8DD9 == "littlebird")
		{
			if(!isdefined(self.var_2507))
			{
				self.var_2507 = [];
			}

			var_11 = "";
			if(isdefined(var_08) && isplayer(var_08))
			{
				var_11 = var_08 scripts\cp\_utility::func_81EC();
			}

			if(isdefined(self.var_2507[var_11]))
			{
				self.var_2507[var_11] = self.var_2507[var_11] + var_07;
			}
			else
			{
				self.var_2507[var_11] = var_07;
			}
		}
	}
}

//Function Number: 188
func_B9C7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D)
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(isdefined(param_01) && !scripts\cp\_utility::func_9E0E(param_01) && !isdefined(param_01.var_1C9F))
	{
		return 1;
	}

	return 1;
}

//Function Number: 189
func_69FF(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_AD39 = param_00;
	var_02.var_4E53 = ::func_BD4F;
	var_02.var_6371 = "death";
	if(!isdefined(param_01) || !param_01)
	{
		var_02.var_9B11 = ::scripts\cp\_movers::func_BD3C;
	}

	thread scripts\cp\_movers::func_892F(var_02);
}

//Function Number: 190
func_BD4F(param_00)
{
	if(!isdefined(param_00.var_AA33) || !isdefined(param_00.var_AA33.var_5318) || param_00.var_AA33.var_5318)
	{
		self notify("detonateExplosive");
	}
}

//Function Number: 191
func_B2A5()
{
	if(scripts\cp\_utility::func_9F19(self.var_222))
	{
		self method_831F(self.var_222);
		self.trigger = spawn("script_origin",self.origin + func_7EAA());
		self.trigger.var_222 = self;
		thread func_66B5(self.var_222,1);
	}
}

//Function Number: 192
func_66B5(param_00,param_01)
{
	self notify("equipmentWatchUse");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("equipmentWatchUse");
	self.trigger setcursorhint("HINT_NOICON");
	switch(self.var_13C2E)
	{
		case "c4_zm":
			self.trigger sethintstring(&"MP_PICKUP_C4");
			break;

		case "claymore_mp":
			self.trigger sethintstring(&"MP_PICKUP_CLAYMORE");
			break;

		case "bouncingbetty_mp":
			self.trigger sethintstring(&"MP_PICKUP_BOUNCING_BETTY");
			break;

		case "proximity_explosive_mp":
			self.trigger sethintstring(&"MP_PICKUP_PROXIMITY_EXPLOSIVE");
			break;

		case "mobile_radar_mp":
			self.trigger sethintstring(&"MP_PICKUP_MOBILE_RADAR");
			break;

		case "ztransponder_mp":
		case "transponder_mp":
			self.trigger sethintstring(&"MP_PICKUP_TRANSPONDER");
			break;

		case "sonic_sensor_mp":
			self.trigger sethintstring(&"MP_PICKUP_SONIC_SENSOR");
			break;

		case "sticky_mine_mp":
			self.trigger sethintstring(&"MP_PICKUP_STICKY_MINE");
			break;

		case "blackhole_grenade_zm":
		case "blackhole_grenade_mp":
			self.trigger sethintstring(&"MP_PICKUP_BLACKHOLE_GRENADE");
			break;

		case "shard_ball_mp":
			self.trigger sethintstring(&"MP_PICKUP_SHARD_BALL");
			break;

		case "cryo_grenade_mp":
			self.trigger sethintstring(&"MP_PICKUP_CRYO_MINE");
			break;

		case "trip_mine_mp":
			self.trigger sethintstring(&"MP_PICKUP_TRIP_MINE");
			break;

		case "arc_grenade_mine_mp":
			self.trigger sethintstring(&"MP_PICKUP_ARC_MINE");
			break;
	}

	self.trigger scripts\cp\_utility::func_F838(param_00);
	self.trigger thread scripts\cp\_utility::notusableforjoiningplayers(param_00);
	if(isdefined(param_01) && param_01)
	{
		thread func_12F4D();
	}

	for(;;)
	{
		self.trigger waittill("trigger",param_00);
		param_00 playlocalsound("scavenger_pack_pickup");
		param_00 notify("scavenged_ammo",self.var_13C2E);
		param_00 setweaponammostock(self.var_13C2E,param_00 getweaponammostock(self.var_13C2E) + 1);
		func_51B5();
		self notify("death");
	}
}

//Function Number: 193
func_12F4D()
{
	self endon("death");
	for(;;)
	{
		if(isdefined(self) && isdefined(self.trigger))
		{
			self.trigger.origin = self.origin + func_7EAA();
			if(isdefined(self.var_2C68))
			{
				self.var_2C68.origin = self.origin;
			}
		}
		else
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 194
func_51B5(param_00)
{
	if(isdefined(self))
	{
		var_01 = self getentitynumber();
		var_02 = self.var_A63A;
		var_03 = self.trigger;
		var_04 = self.var_F232;
		func_40F4(var_01,var_02,var_03,var_04);
		self notify("deleted_equipment");
		self delete();
	}
}

//Function Number: 195
func_C5AC(param_00)
{
	if(self.var_CC4D.size)
	{
		self.var_CC4D = scripts\common\utility::func_22BC(self.var_CC4D);
		if(self.var_CC4D.size >= level.var_B4BA)
		{
			self.var_CC4D[0] notify("detonateExplosive");
		}
	}

	self.var_CC4D[self.var_CC4D.size] = param_00;
	var_01 = param_00 getentitynumber();
	level.var_B779[var_01] = param_00;
	level notify("mine_planted");
}

//Function Number: 196
func_66A6(param_00)
{
	var_01 = spawnfx(scripts\common\utility::getfx("equipment_sparks"),self.origin);
	triggerfx(var_01);
	if(!isdefined(param_00) || param_00 == 0)
	{
		self playsound("sentry_explode");
	}

	var_01 thread scripts\cp\_utility::func_5106(1);
}

//Function Number: 197
func_66A8()
{
	var_00 = spawnfx(scripts\common\utility::getfx("placeEquipmentFailed"),self.origin);
	triggerfx(var_00);
	self playsound("mp_killstreak_disappear");
	var_00 thread scripts\cp\_utility::func_5106(1);
}

//Function Number: 198
func_B9CA(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("death");
	param_00 scripts\common\utility::waittill_any_3("joined_team","joined_spectators","disconnect");
	param_01 func_51B5();
}

//Function Number: 199
func_9F0E(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(function_0244(param_00) != "primary")
	{
		return 0;
	}

	switch(weaponclass(param_00))
	{
		case "smg":
		case "sniper":
		case "rocketlauncher":
		case "mg":
		case "rifle":
		case "spread":
		case "pistol":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 200
func_7EAA()
{
	var_00 = anglestoup(self.angles);
	return 10 * var_00;
}

//Function Number: 201
func_9E6D(param_00)
{
	return issubstr(param_00,"knife");
}

//Function Number: 202
func_9C22(param_00)
{
	if(isdefined(level.var_1E43))
	{
		if(scripts\common\utility::func_2286(level.var_1E43,param_00))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 203
func_9D75(param_00)
{
	if(param_00 == "none" || scripts\cp\_utility::func_9F2D(param_00) || func_9E6D(param_00))
	{
		return 0;
	}

	switch(weaponclass(param_00))
	{
		case "smg":
		case "sniper":
		case "mg":
		case "rifle":
		case "spread":
		case "pistol":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 204
func_9BDB(param_00)
{
	switch(param_00)
	{
		case "zombie_armageddon_mp":
		case "zfreeze_semtex_mp":
		case "splash_grenade_zm":
		case "splash_grenade_mp":
		case "throwingknifec4_mp":
		case "cluster_grenade_zm":
		case "semtex_zm":
		case "semtex_mp":
		case "c4_zm":
		case "frag_grenade_zm":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 205
func_9B6A(param_00,param_01,param_02,param_03,param_04,param_05)
{
	return param_02 && param_03 && param_04 && !param_05 && isdefined(param_01.var_11192) && isdefined(param_01.var_11192.var_24B2) && param_00 == param_01.var_11192.var_24B2;
}

//Function Number: 206
func_9C04(param_00)
{
	var_01 = param_00 getcurrentprimaryweapon();
	if(scripts\cp\_utility::func_4626(var_01) == "weapon_pistol")
	{
		return 1;
	}

	return 0;
}

//Function Number: 207
func_7D62(param_00)
{
	if(!isplayer(self))
	{
		return int(1);
	}

	if(isdefined(self.var_C8A2[param_00]))
	{
		return self.var_C8A2[param_00].var_B111;
	}

	var_01 = scripts\cp\_utility::func_80D8(param_00);
	if(isdefined(self.var_C8A2[var_01]))
	{
		return self.var_C8A2[var_01].var_B111;
	}

	return int(1);
}

//Function Number: 208
func_385F(param_00,param_01)
{
	if(!isdefined(level.var_C8A2))
	{
		return 0;
	}

	if(isdefined(level.max_pap_func))
	{
		return [[ level.max_pap_func ]](param_00,param_01);
	}

	if(isdefined(param_00))
	{
		var_02 = scripts\cp\_utility::func_80D8(param_00);
	}
	else
	{
		return 0;
	}

	if(!isdefined(var_02))
	{
		return 0;
	}

	if(var_02 == "wylerdagger")
	{
		return 0;
	}

	if(!isdefined(level.var_C8A2[var_02]))
	{
		var_03 = getsubstr(var_02,0,var_02.size - 1);
		if(!isdefined(level.var_C8A2[var_03]))
		{
			return 0;
		}
	}

	if(isdefined(self.var_6670) && getweaponbasename(self.var_6670) == getweaponbasename(param_00))
	{
		return 0;
	}

	if(isdefined(level.weapon_upgrade_path) && isdefined(level.weapon_upgrade_path[getweaponbasename(param_00)]))
	{
		return 1;
	}

	if(var_02 == "dischord" || var_02 == "facemelter" || var_02 == "headcutter" || var_02 == "shredder")
	{
		if(scripts\cp\zombies\directors_cut::directors_cut_is_activated())
		{
			if(isdefined(self.var_C8A2[var_02]) && self.var_C8A2[var_02].var_B111 == 2)
			{
				return 0;
			}
			else
			{
				return 1;
			}
		}

		if(!scripts\common\utility::flag("fuses_inserted"))
		{
			if(scripts\common\utility::istrue(param_01))
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		else if(isdefined(self.var_C8A2[var_02]) && self.var_C8A2[var_02].var_B111 == 2)
		{
			return 0;
		}
	}

	if(scripts\common\utility::istrue(level.has_picked_up_fuses) && !isdefined(level.placed_alien_fuses))
	{
		return 1;
	}

	if((scripts\common\utility::istrue(self.has_zis_soul_key) && !scripts\common\utility::istrue(level.no_auto_pap_upgrade)) || scripts\common\utility::istrue(level.placed_alien_fuses))
	{
		if(isdefined(self.var_C8A2[var_02]) && self.var_C8A2[var_02].var_B111 >= 3)
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}

	if(scripts\common\utility::istrue(param_01) && isdefined(self.var_C8A2[var_02]) && self.var_C8A2[var_02].var_B111 <= min(level.var_C8A4 + 1,2))
	{
		return 1;
	}

	if(isdefined(self.var_C8A2[var_02]) && self.var_C8A2[var_02].var_B111 >= level.var_C8A4)
	{
		return 0;
	}

	return 1;
}

//Function Number: 209
get_pap_camo(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(isdefined(param_01))
	{
		if(isdefined(level.no_pap_camos) && scripts\common\utility::func_2286(level.no_pap_camos,param_01))
		{
			var_03 = undefined;
		}
		else if(isdefined(level.pap_1_camo) && isdefined(param_00) && param_00 == 2)
		{
			var_03 = level.pap_1_camo;
		}
		else if(isdefined(level.pap_2_camo) && isdefined(param_00) && param_00 == 3)
		{
			var_03 = level.pap_2_camo;
		}

		switch(param_01)
		{
			case "dischord":
				param_02 = "iw7_dischord_zm_pap1";
				var_03 = "camo20";
				break;

			case "facemelter":
				param_02 = "iw7_facemelter_zm_pap1";
				var_03 = "camo22";
				break;

			case "headcutter":
				param_02 = "iw7_headcutter_zm_pap1";
				var_03 = "camo21";
				break;

			case "forgefreeze":
				if(param_00 == 2)
				{
					param_02 = "iw7_forgefreeze_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_forgefreeze_zm_pap2";
				}
	
				var_04 = 1;
				break;

			case "axe":
				if(param_00 == 2)
				{
					param_02 = "iw7_axe_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_axe_zm_pap2";
				}
	
				var_04 = 1;
				break;

			case "shredder":
				param_02 = "iw7_shredder_zm_pap1";
				var_03 = "camo23";
				break;
		}
	}

	return var_03;
}

//Function Number: 210
validate_current_weapon(param_00,param_01,param_02)
{
	if(isdefined(level.weapon_upgrade_path) && isdefined(level.weapon_upgrade_path[getweaponbasename(param_02)]))
	{
		param_02 = level.weapon_upgrade_path[getweaponbasename(param_02)];
	}
	else if(isdefined(param_01))
	{
		switch(param_01)
		{
			case "two":
				if(param_00 == 2)
				{
					param_02 = "iw7_two_headed_axe_mp";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_two_headed_axe_mp";
				}
				break;

			case "golf":
				if(param_00 == 2)
				{
					param_02 = "iw7_golf_club_mp";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_golf_club_mp";
				}
				break;

			case "machete":
				if(param_00 == 2)
				{
					param_02 = "iw7_machete_mp";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_machete_mp";
				}
				break;

			case "spiked":
				if(param_00 == 2)
				{
					param_02 = "iw7_spiked_bat_mp";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_spiked_bat_mp";
				}
				break;

			case "axe":
				if(param_00 == 2)
				{
					param_02 = "iw7_axe_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_axe_zm_pap2";
				}
				break;

			case "katana":
				if(param_00 == 2)
				{
					param_02 = "iw7_katana_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_katana_zm_pap2";
				}
				break;

			case "nunchucks":
				if(param_00 == 2)
				{
					param_02 = "iw7_nunchucks_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_nunchucks_zm_pap2";
				}
				break;

			case "venomx":
				if(param_00 == 2)
				{
					param_02 = "iw7_venomx_zm_pap1";
				}
				else if(param_00 == 3)
				{
					param_02 = "iw7_venomx_zm_pap2";
				}
				break;

			default:
				return param_02;
		}
	}

	return param_02;
}

//Function Number: 211
func_13B09()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		self waittill("melee_fired",var_00);
		if(self.var_B625 == 0)
		{
			if(var_00 == "iw7_fists_zm_crane" || var_00 == "iw7_fists_zm_dragon" || var_00 == "iw7_fists_zm_snake" || var_00 == "iw7_fists_zm_tiger")
			{
				if(self.kung_fu_vo == 0)
				{
					self.kung_fu_vo = 1;
					thread scripts\cp\_vo::try_to_play_vo("melee_punch","zmb_comment_vo","high",1,0,0,1);
					thread kung_fu_vo_wait();
				}
				else
				{
					self.kung_fu_vo = 1;
					self notify("kung_fu_vo_reset");
					thread scripts\cp\_vo::try_to_play_vo("melee_punch","zmb_comment_vo","high",1,0,0,1,60);
					thread kung_fu_vo_wait();
				}
			}
			else
			{
				thread scripts\cp\_vo::try_to_play_vo("melee_miss","zmb_comment_vo","high",1,0,0,1,20);
			}

			continue;
		}

		if(issubstr(var_00,"katana") && self.var_134FD == "p5_")
		{
			thread scripts\cp\_vo::try_to_play_vo("melee_special_katana","rave_comment_vo","high",1,0,0,1);
			continue;
		}

		if((issubstr(var_00,"golf") || issubstr(var_00,"machete") || issubstr(var_00,"spiked_bat") || issubstr(var_00,"two_headed_axe")) && self.var_B625 == 1)
		{
			thread scripts\cp\_vo::try_to_play_vo("melee_special","rave_comment_vo","high",1,0,0,1);
			continue;
		}

		if(issubstr(var_00,"iw7_knife") && scripts\cp\_utility::func_9C42(var_00) && self.var_B625 == 1)
		{
			thread scripts\cp\_vo::try_to_play_vo("melee_fatal","zmb_comment_vo","high",1,0,0,1);
			self.var_B625 = 0;
			continue;
		}

		if((var_00 == "iw7_axe_zm" || var_00 == "iw7_axe_zm_pap1" || var_00 == "iw7_axe_zm_pap2") && scripts\cp\_utility::func_9C42(var_00) && self.var_B625 == 1)
		{
			thread scripts\cp\_vo::try_to_play_vo("melee_splice","zmb_comment_vo","high",1,0,0,1);
			self.var_B625 = 0;
		}
	}
}

//Function Number: 212
kung_fu_vo_wait()
{
	self endon("kung_fu_vo_reset");
	wait(4);
	self.kung_fu_vo = 0;
}

//Function Number: 213
func_13BA8()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		wait(1);
		var_00 = self getcurrentweapon();
		if(!isdefined(var_00) || var_00 == "none")
		{
			continue;
		}

		self waittill("fired",var_00);
		var_00 = self getcurrentweapon();
		var_01 = self method_80FB(var_00);
		if(scripts\cp\_utility::func_9C42(var_00) || issubstr(var_00,"fists") || issubstr(var_00,"heart") || issubstr(var_00,"dagger"))
		{
			continue;
		}

		if((var_01 <= 5 && var_01 > 0 && self getweaponammostock(var_00) == 0) || self getweaponammostock(var_00) > 0 && var_01 / self getweaponammostock(var_00) < 0.1)
		{
			scripts\cp\_vo::try_to_play_vo("nag_low_ammo","zmb_comment_vo","low",3,0,0,0,20);
			continue;
		}

		if(var_01 == 0 && var_00 != "iw7_cpbasketball_mp" && var_00 != "none")
		{
			if(issubstr(var_00,"venomx"))
			{
				scripts\cp\_vo::try_to_play_vo("venx_nag_eggs","zmb_comment_vo","low",3,0,0,0,20);
				continue;
			}

			scripts\cp\_vo::try_to_play_vo("nag_out_ammo","zmb_comment_vo","low",3,0,0,0,20);
		}
	}
}

//Function Number: 214
func_13BAE(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		self waittill("weapon_fired",var_01);
		var_01 = self getcurrentweapon();
		if(!isdefined(var_01) || var_01 == "none")
		{
			continue;
		}

		if(!scripts\cp\_utility::func_9E55(var_01))
		{
			continue;
		}

		if(isdefined(level.var_12EE2))
		{
			thread [[ level.var_12EE2 ]](self,var_01);
		}

		var_02 = gettime();
		if(!isdefined(self.var_A9EE))
		{
			self.var_A9EE = 0;
		}

		var_03 = gettime() - self.var_A9EE;
		self.var_A9EE = var_02;
		if(isai(self))
		{
			continue;
		}

		var_04 = getweaponbasename(var_01);
		if(!isdefined(self.var_FF09[var_04]))
		{
			self.var_FF09[var_04] = 1;
		}
		else
		{
			self.var_FF09[var_04]++;
		}

		if(!isdefined(self.accuracy_shots_fired))
		{
			self.accuracy_shots_fired = 1;
		}
		else
		{
			self.accuracy_shots_fired++;
		}

		scripts\cp\_persistence::increment_player_career_shots_fired(self);
		if(isdefined(var_04))
		{
			if(isdefined(self.var_9045[var_04]))
			{
				thread func_9048(var_04,var_01);
			}
		}
	}
}

//Function Number: 215
func_9048(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("updateMagShots_" + param_00);
	self.var_9045[param_00]--;
	wait(0.1);
	self notify("shot_missed",param_01);
	self.var_453C[param_00] = 0;
	self.var_9045[param_00] = weaponclipsize(param_01);
}

//Function Number: 216
func_13BA5()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.var_9045 = [];
	var_00 = getweaponbasename(self getcurrentweapon());
	func_9047(var_00);
	for(;;)
	{
		self waittill("weapon_change",var_00);
		var_00 = getweaponbasename(var_00);
		func_13CDC(var_00);
		func_9047(var_00);
	}
}

//Function Number: 217
harpoon_impale_additional_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!issubstr(param_00,"harpoon"))
	{
		return;
	}

	param_02 method_839A();
	var_08 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_missileclip","physicscontents_vehicle","physicscontents_corpseclipshot"]);
	var_09 = param_03 + param_04 * 4096;
	var_0A = scripts\common\trace::func_DCEE(param_03,var_09,undefined,var_08,undefined,1);
	var_09 = var_0A["position"] - param_04 * 12;
	var_0B = length(var_09 - param_03);
	var_0C = var_0B / 1250;
	var_0C = clamp(var_0C,0.05,1);
	wait(0.05);
	var_0D = param_04;
	var_0E = anglestoup(param_01.angles);
	var_0F = vectorcross(var_0D,var_0E);
	var_10 = scripts\common\utility::spawn_tag_origin(param_03,axistoangles(var_0D,var_0F,var_0E));
	var_10 moveto(var_09,var_0C);
	var_11 = spawnragdollconstraint(param_02,param_05,param_06,param_07);
	var_11.origin = var_10.origin;
	var_11.angles = var_10.angles;
	var_11 linkto(var_10);
	thread play_explosion_post_impale(var_09,param_01);
	thread func_934F(param_02,var_10,var_0C + 0.05,var_11);
}

//Function Number: 218
func_934F(param_00,param_01,param_02,param_03)
{
	param_00 scripts\common\utility::waittill_any_timeout_1(param_02,"death","disconnect");
	param_03 delete();
	param_01 delete();
}

//Function Number: 219
play_explosion_post_impale(param_00,param_01)
{
	wait(2);
	param_01 radiusdamage(param_00,500,1000,500,param_01,"MOD_EXPLOSIVE");
	playfx(level._effect["penetration_railgun_explosion"],param_00);
}

//Function Number: 220
func_13CDC(param_00)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return;
	}

	if(!isdefined(self.var_FF09[param_00]))
	{
		self.var_FF09[param_00] = 0;
	}

	if(!isdefined(self.var_FF0A[param_00]))
	{
		self.var_FF0A[param_00] = 0;
	}

	if(!isdefined(self.var_8CA0[param_00]))
	{
		self.var_8CA0[param_00] = 0;
	}

	if(!isdefined(self.var_13BE3[param_00]))
	{
		self.var_13BE3[param_00] = 1;
	}

	if(!isdefined(self.var_5AFC[param_00]))
	{
		self.var_5AFC[param_00] = 0;
	}

	if(!isdefined(self.var_A682[param_00]))
	{
		self.var_A682[param_00] = 0;
	}
}

//Function Number: 221
func_9047(param_00)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return;
	}

	if(scripts\cp\_utility::func_9E55(param_00) && !isdefined(self.var_9045[param_00]))
	{
		self.var_9045[param_00] = weaponclipsize(param_00);
	}
}