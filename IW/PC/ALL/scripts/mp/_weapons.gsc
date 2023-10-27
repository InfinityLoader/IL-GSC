/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_weapons.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 341
 * Decompile Time: 12886 ms
 * Timestamp: 10/27/2023 12:22:29 AM
*******************************************************************/

//Function Number: 1
func_248C(param_00)
{
	return tablelookup("mp/attachmentTable.csv",4,param_00,2);
}

//Function Number: 2
init()
{
	level.var_EBCF = 1;
	level.var_EBD0 = 1;
	level._effect["item_fx_legendary"] = loadfx("vfx/iw7/_requests/mp/vfx_weap_loot_legendary.vfx");
	level._effect["item_fx_rare"] = loadfx("vfx/iw7/_requests/mp/vfx_weap_loot_rare.vfx");
	level._effect["item_fx_common"] = loadfx("vfx/iw7/_requests/mp/vfx_weap_loot_common.vfx");
	level._effect["shield_metal_impact"] = loadfx("vfx/iw7/core/impact/weapon/md/vfx_imp_md_metal.vfx");
	level.var_B4BA = max(scripts\mp\_utility::func_7F1D("scr_maxPerPlayerExplosives",2),1);
	level.var_E55D = scripts\mp\_utility::func_7F1D("scr_riotShieldXPBullets",15);
	function_004E("DogsDontAttack");
	function_004E("Dogs");
	function_01B2("DogsDontAttack","Dogs");
	switch(scripts\mp\_utility::func_7F1D("perk_scavengerMode",0))
	{
		case 1:
			level.var_EBCF = 0;
			break;

		case 2:
			level.var_EBD0 = 0;
			break;

		case 3:
			level.var_EBCF = 0;
			level.var_EBD0 = 0;
			break;
	}

	thread scripts\mp\_flashgrenades::main();
	thread scripts\mp\_entityheadicons::init();
	func_97DD();
	func_31D5();
	func_3222();
	level._effect["weap_blink_friend"] = loadfx("vfx/core/mp/killstreaks/vfx_detonator_blink_cyan");
	level._effect["weap_blink_enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_detonator_blink_orange");
	level._effect["emp_stun"] = loadfx("vfx/core/mp/equipment/vfx_emp_grenade");
	level._effect["equipment_explode"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
	level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
	level._effect["equipment_sparks"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
	level._effect["vfx_sensor_grenade_ping"] = loadfx("vfx/old/_requests/future_weapons/vfx_sensor_grenade_ping");
	level._effect["plasmablast_muz_w"] = loadfx("vfx/old/_requests/mp_weapons/vfx_muz_plasma_blast_w");
	level._effect["vfx_trail_plyr_knife_tele"] = loadfx("vfx/old/_requests/mp_weapons/vfx_trail_plyr_knife_tele");
	level._effect["case_bomb"] = loadfx("vfx/old/_requests/mp_weapons/expl_plasma_blast");
	level._effect["corpse_pop"] = loadfx("vfx/iw7/_requests/mp/vfx_body_expl");
	level._effect["sniper_glint"] = loadfx("vfx/iw7/core/mechanics/sniper_glint/vfx_sniper_glint");
	level._effect["vfx_sonic_sensor_pulse"] = loadfx("vfx/iw7/_requests/mp/vfx_sonic_sensor_pulse");
	level._effect["distortion_field_cloud"] = loadfx("vfx/iw7/_requests/mp/vfx_distortion_field_volume");
	level._effect["penetration_railgun_impact"] = loadfx("vfx/iw7/_requests/mp/vfx_penetration_railgun_impact");
	level._effect["penetration_railgun_pin"] = loadfx("vfx/iw7/_requests/mp/vfx_penetration_railgun_pin");
	level._effect["vfx_penetration_railgun_impact"] = loadfx("vfx/iw7/_requests/mp/vfx_penetration_railgun_impact.vfx");
	level._effect["vfx_emp_grenade_underbarrel"] = loadfx("vfx/iw7/_requests/mp/vfx_pulse_grenade_friendly.vfx");
	func_11819();
	scripts\mp\_utility::func_CC18();
	level.var_13C7D = [];
	if(!isdefined(level.var_13C82))
	{
		level.var_13C82 = ::func_5EF3;
	}

	var_00 = 70;
	level.var_4023 = cos(var_00);
	level.var_4025 = 20;
	level.var_4024 = 0.5;
	level.var_4027 = 192;
	var_01 = 25;
	level.var_10F8F = cos(var_01);
	level.var_10F91 = 15;
	level.var_10F90 = 0.35;
	level.var_10F92 = 256;
	level.var_B76D = 0.3;
	level.var_B76F = 100;
	level.var_B76E = 40;
	level.var_B76B = 256;
	level.var_B769 = 70;
	level.var_B768 = 210;
	level.var_B766 = 46;
	level.var_B77B = 120;
	level.var_B762 = loadfx("vfx/core/impacts/bouncing_betty_launch_dirt");
	level.var_B761 = loadfx("vfx/iw7/core/mp/killstreaks/vfx_apex_dest_exp");
	var_02 = spawnstruct();
	var_02.model = "projectile_bouncing_betty_grenade";
	var_02.var_2C68 = "projectile_bouncing_betty_grenade_bombsquad";
	var_02.var_B760["enemy"] = loadfx("vfx/core/equipment/light_c4_blink.vfx");
	var_02.var_B760["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
	var_02.var_B763 = loadfx("vfx/misc/bouncing_betty_swirl");
	var_02.var_226E = 2;
	var_02.var_C5B4 = "mine_betty_click";
	var_02.var_C54C = "mine_betty_spin";
	var_02.var_C525 = "frag_grenade_explode";
	var_02.var_AAB0 = 64;
	var_02.var_AAB7 = 0.65;
	var_02.var_C5B3 = ::func_B764;
	var_02.var_8C7A = 20;
	level.var_13C7D["bouncingbetty_mp"] = var_02;
	level.var_13C7D["alienbetty_mp"] = var_02;
	var_02 = spawnstruct();
	var_02.model = "weapon_semtex_grenade_iw6";
	var_02.var_2C68 = "weapon_semtex_grenade_iw6_bombsquad";
	var_02.var_B760["enemy"] = loadfx("vfx/core/equipment/light_c4_blink.vfx");
	var_02.var_B760["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
	var_02.var_226E = 2;
	var_02.var_C5B4 = "mine_betty_click";
	var_02.var_C525 = "frag_grenade_explode";
	var_02.var_C5B3 = ::func_B764;
	var_02.var_8C7A = 20;
	level.var_13C7D["sticky_mine_mp"] = var_02;
	var_02 = spawnstruct();
	var_02.model = "weapon_motion_sensor";
	var_02.var_2C68 = "weapon_motion_sensor_bombsquad";
	var_02.var_B760["enemy"] = scripts\common\utility::getfx("weap_blink_enemy");
	var_02.var_B760["friendly"] = scripts\common\utility::getfx("weap_blink_friend");
	var_02.var_B763 = loadfx("vfx/misc/bouncing_betty_swirl");
	var_02.var_226E = 2;
	var_02.var_C5B4 = "motion_click";
	var_02.var_C5B3 = ::func_B77C;
	var_02.var_C54C = "motion_spin";
	var_02.var_AABB = level.var_B762;
	var_02.var_AAB0 = 64;
	var_02.var_AAB7 = 0.65;
	var_02.var_C525 = "motion_explode_default";
	var_02.var_C526 = loadfx("vfx/core/mp/equipment/vfx_motionsensor_exp");
	var_02.var_8C7A = 25;
	var_02.var_B371 = 4;
	level.var_13C7D["motion_sensor_mp"] = var_02;
	var_02 = spawnstruct();
	var_02.model = "weapon_mobile_radar";
	var_02.var_2C68 = "weapon_mobile_radar_bombsquad";
	var_02.var_B760["enemy"] = scripts\common\utility::getfx("weap_blink_enemy");
	var_02.var_B760["friendly"] = scripts\common\utility::getfx("weap_blink_friend");
	var_02.var_B763 = loadfx("vfx/misc/bouncing_betty_swirl");
	var_02.var_226E = 2;
	var_02.var_C5B4 = "motion_click";
	var_02.var_C5B3 = ::func_B8F5;
	var_02.var_C54C = "motion_spin";
	var_02.var_AABB = level.var_B762;
	var_02.var_AAB0 = 40;
	var_02.var_AAB7 = 0.35;
	var_02.var_C525 = "motion_explode_default";
	var_02.var_C526 = loadfx("vfx/core/mp/equipment/vfx_motionsensor_exp");
	var_02.var_C4C5 = loadfx("vfx/core/mp/equipment/vfx_motionsensor_exp");
	var_02.var_8C7A = 25;
	var_02.var_B371 = 4;
	level.var_13C7D["mobile_radar_mp"] = var_02;
	var_02 = spawnstruct();
	var_02.var_217C = 1.5;
	var_02.var_53B6 = 232;
	var_02.var_53B5 = 512;
	var_02.var_53B4 = 1;
	var_02.var_8C7A = 20;
	var_02.var_A640 = 12;
	level.var_13C7D["proximity_explosive_mp"] = var_02;
	var_02 = spawnstruct();
	var_03 = 800;
	var_04 = 200;
	var_02.var_DC05 = var_03 * var_03;
	var_02.var_DC06 = var_04 * var_04;
	var_02.var_C526 = loadfx("vfx/core/mp/equipment/vfx_flashbang.vfx");
	var_02.var_C525 = "flashbang_explode_default";
	var_02.var_1336F = 72;
	level.var_13C7D["flash_grenade_mp"] = var_02;
	var_02 = spawnstruct();
	var_03 = 800;
	var_04 = 200;
	var_02.var_DC05 = var_03 * var_03;
	var_02.var_DC06 = var_04 * var_04;
	var_02.var_C526 = loadfx("vfx/core/mp/equipment/vfx_flashbang.vfx");
	var_02.var_C523 = loadfx("vfx/iw7/_requests/mp/vfx_disruptor_charge");
	var_02.var_D828 = loadfx("vfx/iw7/_requests/mp/vfx_disruptor_laser");
	var_02.var_C525 = "flashbang_explode_default";
	var_02.var_1336F = 72;
	level.var_13C7D["throwingknifedisruptor_mp"] = var_02;
	var_02 = spawnstruct();
	var_02.model = "weapon_sonic_sensor_wm";
	var_02.var_2C68 = "weapon_motion_sensor_bombsquad";
	var_02.var_B760["enemy"] = scripts\common\utility::getfx("weap_blink_enemy");
	var_02.var_B760["friendly"] = scripts\common\utility::getfx("weap_blink_friend");
	var_02.var_B763 = loadfx("vfx/misc/bouncing_betty_swirl");
	var_02.var_226E = 2;
	var_02.var_C5B4 = "motion_click";
	var_02.var_C54C = "motion_spin";
	var_02.var_AABB = level.var_B762;
	var_02.var_AAB0 = 64;
	var_02.var_AAB7 = 0.65;
	var_02.var_C525 = "motion_explode_default";
	var_02.var_C526 = loadfx("vfx/core/mp/equipment/vfx_motionsensor_exp");
	var_02.var_8C7A = 25;
	var_02.var_B371 = 4;
	level.var_13C7D["sonic_sensor_mp"] = var_02;
	var_02 = spawnstruct();
	var_02.model = "weapon_mobile_radar";
	var_02.var_2C68 = "weapon_mobile_radar_bombsquad";
	var_02.var_B760["enemy"] = loadfx("vfx/core/equipment/light_c4_blink.vfx");
	var_02.var_B760["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
	var_02.var_B763 = loadfx("vfx/misc/bouncing_betty_swirl");
	var_02.var_226E = 0.05;
	var_02.var_B769 = 0;
	var_02.var_B768 = 0;
	var_02.var_C5B4 = "motion_click";
	var_02.var_C54C = "motion_spin";
	var_02.var_C525 = "motion_explode_default";
	var_02.var_C526 = loadfx("vfx/core/mp/equipment/vfx_motionsensor_exp");
	var_02.var_AAB0 = 64;
	var_02.var_AAB7 = 0.65;
	var_02.var_C5B3 = ::lib_0DE7::func_6BBC;
	var_02.var_C524 = ::lib_0DE7::func_6BBB;
	var_02.var_8C7A = 20;
	var_02.var_B76F = 200;
	var_02.var_B76E = 100;
	level.var_13C7D["fear_grenade_mp"] = var_02;
	var_02 = spawnstruct();
	var_02.model = "prop_mp_speed_strip_temp";
	var_02.var_2C68 = "prop_mp_speed_strip_temp";
	var_02.var_226E = 0.05;
	var_02.var_13370 = "tag_origin";
	var_02.var_B769 = 0;
	var_02.var_B768 = 0;
	var_02.var_C5B4 = "motion_click";
	var_02.var_C54C = "motion_spin";
	var_02.var_C525 = "motion_explode_default";
	var_02.var_AAB0 = 64;
	var_02.var_AAB7 = 0.65;
	var_02.var_C5B3 = ::scripts\mp\_blackholegrenade::func_2B41;
	var_02.var_C524 = ::scripts\mp\_blackholegrenade::func_2B40;
	var_02.var_8C7A = 20;
	var_02.var_B76F = 200;
	var_02.var_B76E = 100;
	level.var_13C7D["blackhole_grenade_mp"] = var_02;
	var_02 = spawnstruct();
	var_02.model = "weapon_mobile_radar";
	var_02.var_2C68 = "weapon_mobile_radar_bombsquad";
	var_02.var_226E = 0.05;
	var_02.var_13370 = "tag_origin";
	var_02.var_B769 = 0;
	var_02.var_B768 = 0;
	var_02.var_C5B4 = "motion_click";
	var_02.var_C54C = "motion_spin";
	var_02.var_C525 = "motion_explode_default";
	var_02.var_AAB0 = 64;
	var_02.var_AAB7 = 0.65;
	var_02.var_C5B3 = ::scripts\mp\_shardball::func_FC5A;
	var_02.var_C524 = ::scripts\mp\_shardball::func_FC59;
	var_02.var_8C7A = 20;
	var_02.var_B76F = 200;
	var_02.var_B76E = 100;
	level.var_13C7D["shard_ball_mp"] = var_02;
	var_02 = spawnstruct();
	var_02.var_B760["enemy"] = loadfx("vfx/core/equipment/light_c4_blink.vfx");
	var_02.var_B760["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
	level.var_13C7D["c4_mp"] = var_02;
	var_02 = spawnstruct();
	var_02.var_B760["enemy"] = loadfx("vfx/core/equipment/light_c4_blink.vfx");
	var_02.var_B760["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
	level.var_13C7D["claymore_mp"] = var_02;
	level.var_5113 = 3;
	level.var_F240 = loadfx("vfx/core/muzflash/shotgunflash");
	level.var_10FA1 = loadfx("vfx/iw7/_requests/mp/power/vfx_wrist_rocket_exp.vfx");
	level.var_D8D4 = [];
	level.var_101AE = [];
	level.var_857E = [];
	level.var_B7E0 = [];
	level.var_9B16 = [];
	level.var_B779 = [];
	level._effect["glow_stick_glow_red"] = loadfx("vfx/misc/glow_stick_glow_red");
	scripts\mp\_ricochet::func_E4E3();
	scripts\mp\_bulletstorm::func_3258();
	scripts\mp\_shardball::func_FC58();
	scripts\mp\_splashgrenade::func_10A34();
	level thread func_C56E();
	level.var_334B = 0;
	scripts\common\utility::array_thread(getentarray("misc_turret","classname"),::func_12A13);
	scripts\mp\_utility::func_98AA();
}

//Function Number: 3
func_5F30()
{
	wait(5);
}

//Function Number: 4
func_97DD()
{
	level.var_2C46 = [];
}

//Function Number: 5
func_2C6A()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = scripts\mp\_utility::func_137A6();
		if(!isdefined(var_00))
		{
			continue;
		}

		if(var_00.var_13C2E == "iw6_mk32_mp")
		{
			var_00 thread func_4988("projectile_semtex_grenade_bombsquad","tag_weapon",self);
		}
	}
}

//Function Number: 6
func_4988(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",(0,0,0));
	var_03 hide();
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	self.var_2C68 = var_03;
	var_03 thread func_2C69(param_02);
	var_03 setmodel(param_00);
	var_03 linkto(self,param_01,(0,0,0),(0,0,0));
	var_03 method_82C7(0);
	scripts\common\utility::waittill_any_3("death","trap_death");
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	var_03 delete();
}

//Function Number: 7
func_561A(param_00)
{
	self hudoutlineenableforclient(param_00,6,1,0);
}

//Function Number: 8
func_6281(param_00)
{
	self hudoutlinedisableforclient(param_00);
}

//Function Number: 9
func_2C69(param_00)
{
	self endon("death");
	self endon("trap_death");
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = param_00.team;
	for(;;)
	{
		self hide();
		foreach(var_03 in level.players)
		{
			func_6281(var_03);
			if(!var_03 scripts\mp\_utility::_hasperk("specialty_detectexplosive"))
			{
				continue;
			}

			if(level.teambased)
			{
				if(var_03.team == "spectator" || var_03.team == var_01)
				{
					continue;
				}
			}
			else if(isdefined(param_00) && var_03 == param_00)
			{
				continue;
			}

			self showtoplayer(var_03);
			func_561A(var_03);
		}

		level scripts\common\utility::waittill_any_3("joined_team","player_spawned","changed_kit","update_bombsquad");
	}
}

//Function Number: 10
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_9042 = 0;
		scripts\mp\_gamelogic::func_F73B(var_00,0);
		var_00 thread func_C57B();
		var_00 thread func_2C6A();
		var_00 thread func_13AD5();
	}
}

//Function Number: 11
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.var_4C16 = self.var_10922;
		self.var_61A0 = 0;
		self.var_44ED = 0;
		self.var_9042 = 0;
		scripts\mp\_gamelogic::func_F73B(self,0);
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

		thread func_13BAE();
		thread func_13BA5();
		thread func_13B4C();
		thread func_13A9B();
		thread func_13A1F();
		thread func_13A93();
		thread scripts\mp\_flashgrenades::func_10DC6();
		thread func_13AC3();
		thread func_13B38();
		thread scripts\mp\_class::func_11B04();
		thread watchdropweapons();
		self.var_A99F = [];
		self.var_5D39 = undefined;
		self.var_119DF = [];
		self.ismodded = undefined;
		thread func_12F0A();
		self.var_4C16 = undefined;
		self.var_12839 = undefined;
		scripts\mp\_gamescore::func_97D2();
		var_00 = self getcurrentweapon();
		var_01 = self method_8519(var_00);
		var_02 = function_00E5(var_00);
		thread runcamoscripts(var_00,var_02);
		thread runweaponscriptvfx(var_00,var_01);
	}
}

//Function Number: 12
func_DDEC()
{
	self.pers["altScopeStates"] = [];
	if(isdefined(self.var_D8E1) && self.var_D8E1 != "none" && self hasweapon(self.var_D8E1) && func_7DB8(self.var_D8E1) != "" && self method_8519(self.var_D8E1))
	{
		var_00 = getweaponbasename(self.var_D8E1);
		var_01 = func_7DB8(self.var_D8E1);
		var_02 = var_00 + "+" + var_01;
		self.pers["altScopeStates"][var_02] = 1;
	}

	if(isdefined(self.var_F0C4) && self.var_F0C4 != "none" && self hasweapon(self.var_F0C4) && func_7DB8(self.var_F0C4) != "" && self method_8519(self.var_F0C4))
	{
		var_00 = getweaponbasename(self.var_F0C4);
		var_01 = func_7DB8(self.var_F0C4);
		var_02 = var_00 + "+" + var_01;
		self.pers["altScopeStates"][var_02] = 1;
	}
}

//Function Number: 13
func_DDF6()
{
	if(isdefined(self.var_D8E1) && self.var_D8E1 != "none" && self hasweapon(self.var_D8E1) && func_8206(self.var_D8E1) != "" && self method_8519(self.var_D8E1))
	{
		var_00 = getweaponbasename(self.var_D8E1);
		var_01 = func_8206(self.var_D8E1);
		var_02 = var_00 + "+" + var_01;
		var_03 = func_7DB8(self.var_D8E1);
		var_04 = var_00 + "+" + var_03;
		self.pers["altScopeStates"][var_02] = 1;
		self.pers["altScopeStates"][var_04] = 1;
	}

	if(isdefined(self.var_F0C4) && self.var_F0C4 != "none" && self hasweapon(self.var_F0C4) && func_8206(self.var_F0C4) != "" && self method_8519(self.var_F0C4))
	{
		var_00 = getweaponbasename(self.var_F0C4);
		var_01 = func_8206(self.var_F0C4);
		var_02 = var_00 + "+" + var_01;
		var_03 = func_7DB8(self.var_F0C4);
		var_04 = var_00 + "+" + var_03;
		self.pers["altScopeStates"][var_02] = 1;
		self.pers["altScopeStates"][var_04] = 1;
	}
}

//Function Number: 14
func_DDF4()
{
	self.pers["toggleScopeStates"] = [];
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(var_02 == self.var_D8E1 || var_02 == self.var_F0C4)
		{
			var_03 = function_00E3(var_02);
			foreach(var_05 in var_03)
			{
				if(func_9FAC(var_05))
				{
					self.pers["toggleScopeStates"][var_02] = self method_812E(var_02);
					break;
				}
			}
		}
	}
}

//Function Number: 15
func_12F48(param_00)
{
	if(isdefined(self.pers["toggleScopeStates"]) && isdefined(self.pers["toggleScopeStates"][param_00]))
	{
		self method_82F8(param_00,self.pers["toggleScopeStates"][param_00]);
	}
}

//Function Number: 16
func_12E5C(param_00)
{
	var_01 = func_8206(param_00);
	var_02 = func_7DB8(param_00);
	var_03 = getweaponbasename(param_00);
	var_04 = var_03 + "+" + var_01;
	var_05 = var_03 + "+" + var_02;
	if(isdefined(self.pers["altScopeStates"]) && scripts\mp\_utility::func_9FB3(isdefined(self.pers["altScopeStates"][var_05]) || isdefined(self.pers["altScopeStates"][var_04])))
	{
		return "alt_" + param_00;
	}

	return param_00;
}

//Function Number: 17
func_9FAC(param_00)
{
	return 0;
}

//Function Number: 18
func_7DB8(param_00)
{
	var_01 = function_00E3(param_00);
	foreach(var_03 in var_01)
	{
		if(func_9D3C(var_03))
		{
			return var_03;
		}
	}

	return "";
}

//Function Number: 19
func_8206(param_00)
{
	var_01 = function_00E3(param_00);
	foreach(var_03 in var_01)
	{
		if(func_9FF3(var_03))
		{
			return var_03;
		}
	}

	return "";
}

//Function Number: 20
func_9D3C(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "shotgunlongshot_burst":
		case "longshotlscope_burst":
		case "acogm4selector":
		case "firetypeselectorsingle":
		case "shotgunlongshotl":
		case "longshotlscope":
		case "longshotscope":
		case "ripperscopeb_camo":
		case "ripperlscope_camo":
		case "ripperscope_camo":
		case "m8lchargescope_camo":
		case "m8lscope_camo":
		case "m8rscope_camo":
		case "m8scope_camo":
		case "ripperrscope_camo":
		case "shotgunlongshot":
		case "meleervn":
		case "arripper":
		case "arm8":
		case "mod_akimboshotgun":
		case "akimbofmg":
			var_01 = 1;
			break;

		default:
			var_02 = scripts\mp\_utility::func_2494(param_00);
			if(var_02 == "hybrid" || var_02 == "acog")
			{
				var_01 = 1;
			}
			break;
	}

	return var_01;
}

//Function Number: 21
func_9FF3(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "ripperlscope":
		case "ripperrscope":
		case "ripperscope":
		case "m8lscope":
		case "m8rscope":
		case "m8scope":
		case "akimbofmg":
			var_01 = 1;
			break;

		case "arripper":
		case "arm8":
		default:
			var_02 = scripts\mp\_utility::func_2494(param_00);
			if(var_02 == "hybrid" || var_02 == "acog")
			{
				var_01 = 1;
			}
			break;
	}

	return var_01;
}

//Function Number: 22
func_13AC3()
{
	scripts\mp\_stinger::func_10FAD();
}

//Function Number: 23
func_13AAC()
{
	scripts\mp\_javelin::func_A448();
}

//Function Number: 24
weaponperkupdate(param_00,param_01)
{
	if(isdefined(param_01) && param_01 != "none")
	{
		param_01 = scripts\mp\_utility::func_8234(param_01);
		var_02 = scripts\mp\_utility::func_13CB4(param_01);
		if(isdefined(var_02))
		{
			scripts\mp\_utility::func_E150(var_02);
		}
	}

	if(isdefined(param_00) && param_00 != "none")
	{
		param_00 = scripts\mp\_utility::func_8234(param_00);
		var_03 = scripts\mp\_utility::func_13CB4(param_00);
		if(isdefined(var_03))
		{
			scripts\mp\_utility::func_8387(var_03);
		}
	}

	if(isdefined(param_01) && issubstr(param_01,"iw7_nunchucks") && param_00 != param_01)
	{
		scripts\mp\_utility::func_12B83("specialty_sprintfire");
	}

	if(isdefined(param_01) && issubstr(param_00,"iw7_nunchucks"))
	{
		scripts\mp\_utility::func_2BBB("specialty_sprintfire");
	}
}

//Function Number: 25
func_12F5D(param_00)
{
	var_01 = 1;
	if(isdefined(param_00) && param_00 != "none")
	{
		var_02 = weaponclass(param_00);
		if(((var_02 == "sniper" || issubstr(param_00,"iw7_longshot") && !func_9D3E(param_00)) && !scripts\mp\_utility::_hasperk("passive_scope_radar")) || getweaponbasename(param_00) == "iw7_m1c_mp" && scripts\mp\_utility::func_13C90(param_00,"thermal"))
		{
			var_01 = 0;
		}
	}

	self setclientomnvar("ui_ads_minimap",var_01);
}

//Function Number: 26
func_13C78(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	if(isdefined(param_01) && param_01 != "none")
	{
		var_03 = function_00E3(param_01);
		if(isdefined(var_03) && var_03.size > 0)
		{
			foreach(var_05 in var_03)
			{
				var_06 = scripts\mp\_utility::func_2499(var_05);
				if(!isdefined(var_06))
				{
					continue;
				}

				scripts\mp\_utility::func_E150(var_06);
			}
		}
	}

	if(isdefined(param_00) && param_00 != "none")
	{
		var_02 = function_00E3(param_00);
		if(isdefined(var_02) && var_02.size > 0)
		{
			foreach(var_09 in var_02)
			{
				var_06 = scripts\mp\_utility::func_2499(var_09);
				if(!isdefined(var_06))
				{
					continue;
				}

				scripts\mp\_utility::func_8387(var_06);
			}
		}
	}
}

//Function Number: 27
func_13B2E(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		var_02 = self getcurrentweapon();
		if(var_02 == param_00)
		{
			childthread func_13BAC(param_00,param_01);
		}

		self waittill("weapon_change");
	}
}

//Function Number: 28
func_13BAC(param_00,param_01)
{
	self endon("weapon_change");
	for(;;)
	{
		var_02 = scripts\mp\_utility::func_137A6();
		if(!isdefined(var_02.var_9E8F))
		{
			thread func_13BAB(param_00,var_02,anglestoforward(var_02.angles),0,param_01);
		}
	}
}

//Function Number: 29
func_13BAB(param_00,param_01,param_02,param_03,param_04)
{
	if(param_03 >= param_04)
	{
		return;
	}

	var_05 = param_01 scripts\common\utility::waittill_any_timeout_no_endon_death_2(2,"death");
	if(var_05 != "death")
	{
		return;
	}

	if(!isdefined(param_01))
	{
		return;
	}

	var_06 = param_01.origin + -8 * param_02;
	var_07 = var_06 + param_02 * 15;
	var_08 = physics_createcontents(["physicscontents_solid","physicscontents_structural","physicscontents_player","physicscontents_vehicleclip"]);
	var_09 = function_0287(var_06,var_07,var_08,self,0,"physicsquery_closest");
	if(var_09.size == 0)
	{
		return;
	}

	var_0A = var_09[0]["entity"];
	var_0B = var_09[0]["normal"];
	var_0C = var_09[0]["position"];
	if(isdefined(var_0A) && isplayer(var_0A))
	{
		return;
	}
	else
	{
		var_0D = param_02 - 2 * vectordot(param_02,var_0B) * var_0B;
		var_0D = vectornormalize(var_0D);
		var_0E = var_0C + var_0D * 2;
		param_01 = scripts\mp\_utility::func_1309(param_00,var_0E,var_0E + var_0D,self);
		param_01.var_222 = self;
		param_01.var_9E8F = 1;
	}

	thread func_13BAB(param_00,param_01,var_0D,param_03 + 1,param_04);
}

//Function Number: 30
func_13BA9()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self endon("giveLoadout_start");
	var_00 = undefined;
	var_01 = self getcurrentweapon();
	for(;;)
	{
		var_01 = self getcurrentweapon();
		func_13C78(var_01,var_00);
		weaponperkupdate(var_01,var_00);
		var_00 = var_01;
		self waittill("weapon_change");
	}
}

//Function Number: 31
func_13BA5()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.var_A978 = self.var_4C16;
	self.var_9045 = [];
	var_00 = scripts\mp\_utility::func_E0CF(self getcurrentweapon());
	func_9047(var_00);
	for(;;)
	{
		self waittill("weapon_change",var_00);
		var_00 = scripts\mp\_utility::func_E0CF(var_00);
		if(!func_B4E0(var_00))
		{
			continue;
		}

		if(scripts\mp\_utility::func_9E6C(var_00))
		{
			continue;
		}

		func_9047(var_00);
		if(scripts\mp\_utility::func_9D78(var_00) || scripts\mp\_utility::func_9D79(var_00))
		{
			self.var_A978 = var_00;
		}
	}
}

//Function Number: 32
func_12F11(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	if(param_01)
	{
		wait(0.05);
	}

	if(param_00 == "iw7_fhr_mp")
	{
		self setscriptablepartstate("chargeVFX","chargeVFXOn",0);
		return;
	}

	self setscriptablepartstate("chargeVFX","chargeVFXOff",0);
}

//Function Number: 33
func_13B4C()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getcurrentweapon();
		if(func_103B9(var_00))
		{
			childthread func_103B7();
		}

		self waittill("weapon_change");
	}
}

//Function Number: 34
func_103B9(param_00)
{
	return param_00 != "none" && weaponclass(param_00) == "sniper" || issubstr(param_00,"iw7_udm45_mpl") || issubstr(param_00,"iw7_longshot_mp") && !func_9D3E(param_00) && !issubstr(param_00,"iw7_m8_mpr");
}

//Function Number: 35
func_103B7()
{
	self notify("manageSniperGlint");
	self endon("managerSniperGlint");
	self endon("weapon_change");
	scripts\common\utility::func_136F7();
	thread func_103B6();
	self.var_83D0 = 0;
	for(;;)
	{
		if(self method_822E() > 0.5 && !lib_0DDF::func_9FC1())
		{
			if(!self.var_83D0)
			{
				func_103B5();
			}
		}
		else if(self.var_83D0)
		{
			func_103B8();
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 36
func_103B6()
{
	scripts\common\utility::waittill_any_3("death","disconnect","weapon_change");
	if(isdefined(self.var_83D0) && self.var_83D0)
	{
		func_103B8();
		self.var_83D0 = undefined;
	}
}

//Function Number: 37
func_103B5()
{
	self setscriptablepartstate("sniperGlint","sniperGlintOn",0);
	self.var_83D0 = 1;
}

//Function Number: 38
func_103B8()
{
	if(isdefined(self))
	{
		self setscriptablepartstate("sniperGlint","sniperGlintOff",0);
		self.var_83D0 = 0;
	}
}

//Function Number: 39
func_13B4A()
{
	self endon("death");
	self endon("disconnect");
	thread func_13B4B();
	if(!isdefined(self.pers["recoilReduceKills"]))
	{
		self.pers["recoilReduceKills"] = 0;
	}

	self setclientomnvar("weap_sniper_display_state",self.pers["recoilReduceKills"]);
	for(;;)
	{
		self waittill("got_a_kill",var_00,var_01,var_02);
		if(func_9F1C(var_01))
		{
			var_03 = self.pers["recoilReduceKills"] + 1;
			self.pers["recoilReduceKills"] = int(min(var_03,4));
			self setclientomnvar("weap_sniper_display_state",self.pers["recoilReduceKills"]);
			if(var_03 <= 4)
			{
				func_10B5F(self getstance());
			}
		}
	}
}

//Function Number: 40
func_13B4B()
{
	self notify("watchSniperBoltActionKills_onDeath");
	self endon("watchSniperBoltActionKills_onDeath");
	self endon("disconnect");
	self waittill("death");
	self.pers["recoilReduceKills"] = 0;
}

//Function Number: 41
func_9F1C(param_00)
{
	if(!isdefined(param_00) || param_00 == "none")
	{
		return 0;
	}

	var_01 = 0;
	if(issubstr(param_00,"l115a3scope") || issubstr(param_00,"l115a3vzscope") || issubstr(param_00,"usrscope") || issubstr(param_00,"usrvzscope"))
	{
		var_01 = 1;
	}

	return var_01;
}

//Function Number: 42
func_80E2()
{
	if(!isdefined(self.pers["recoilReduceKills"]))
	{
		self.pers["recoilReduceKills"] = 0;
	}

	return self.pers["recoilReduceKills"] * 3;
}

//Function Number: 43
func_83F3(param_00)
{
	if(param_00 != "none" && getweaponbasename(param_00) == "iw7_glprox_mp")
	{
		if(func_9D3E(param_00))
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

//Function Number: 44
glprox_modifieddamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = param_00;
	param_04 = scripts\mp\_utility::func_821D(param_04);
	if(!isplayer(param_02))
	{
		return var_07;
	}

	if(param_04 != "iw7_glprox_mp")
	{
		return var_07;
	}

	if(!function_0107(param_05))
	{
		return var_07;
	}

	var_08 = 2500;
	if(level.var_8B38)
	{
		var_08 = 11025;
	}
	else if(level.tactical)
	{
		var_08 = 9216;
	}

	var_09 = 105;
	if(level.var_8B38)
	{
		var_09 = 35;
	}
	else if(level.tactical)
	{
		var_09 = 105;
	}

	var_0A = 55;
	if(level.var_8B38)
	{
		var_0A = 25;
	}
	else if(level.tactical)
	{
		var_0A = 55;
	}

	var_0B = undefined;
	var_0C = undefined;
	if(isdefined(param_06))
	{
		var_0B = distancesquared(param_06,param_02 geteye());
		var_0C = distancesquared(param_06,param_02.origin);
	}
	else if(isdefined(param_03))
	{
		var_0B = distancesquared(param_03.origin,param_02 geteye());
		var_0C = distancesquared(param_03.origin,param_02.origin);
	}

	if(isdefined(var_0B) && var_0B <= var_08)
	{
		var_07 = var_09;
	}
	else if(isdefined(var_0C) && var_0C <= var_08)
	{
		var_07 = var_09;
	}
	else
	{
		var_07 = var_0A;
	}

	return var_07;
}

//Function Number: 45
glprox_modifiedblastshieldconst(param_00,param_01)
{
	if(level.var_8B38)
	{
		if(scripts\mp\_utility::func_821D(param_01) == "iw7_glprox_mp")
		{
			param_00 = 0.65;
		}
	}

	return param_00;
}

//Function Number: 46
func_9E1E(param_00)
{
	if(param_00 == "radar_mp" || param_00 == "airstrike_mp" || param_00 == "helicopter_mp")
	{
		return 1;
	}

	if(param_00 == "briefcase_bomb_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 47
func_9DF7(param_00)
{
	param_00 = scripts\mp\_utility::func_8234(param_00);
	return param_00 == "iw7_fists";
}

//Function Number: 48
func_9D6D(param_00)
{
	return param_00 == "briefcase_bomb_mp" || param_00 == "briefcase_bomb_defuse_mp";
}

//Function Number: 49
func_B4E0(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(func_9DF7(param_00))
	{
		return 0;
	}

	if(func_9D6D(param_00))
	{
		return 0;
	}

	if(scripts\mp\_powers::func_9F0A(param_00))
	{
		return 0;
	}

	if(issubstr(param_00,"ac130"))
	{
		return 0;
	}

	if(issubstr(param_00,"uav"))
	{
		return 0;
	}

	if(issubstr(param_00,"killstreak"))
	{
		return 0;
	}

	if(scripts\mp\_utility::func_9F8D(param_00))
	{
		return 0;
	}

	var_01 = function_0244(param_00);
	if(var_01 != "primary")
	{
		return 0;
	}

	return 1;
}

//Function Number: 50
func_5EF3(param_00,param_01)
{
	if(isdefined(level.var_2BBE))
	{
		return;
	}

	if(isdefined(self.var_5D39))
	{
		return;
	}

	if((isdefined(param_00) && param_00 == self) || param_01 == "MOD_SUICIDE")
	{
		return;
	}

	var_02 = self.var_A978;
	if(!isdefined(var_02))
	{
		return;
	}

	if(var_02 == "none")
	{
		return;
	}

	if(!self hasweapon(var_02))
	{
		return;
	}

	if(scripts\mp\_utility::func_9E59())
	{
		return;
	}

	if(isdefined(level.var_7677) && !self [[ level.var_7677 ]](var_02))
	{
		return;
	}

	if(func_9D3E(var_02))
	{
		var_02 = scripts\mp\_utility::func_E0CF(var_02);
	}

	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	if(var_02 != "iw6_riotshield_mp")
	{
		if(!self method_801A(var_02))
		{
			return;
		}

		var_03 = self getweaponammoclip(var_02,"right");
		var_04 = self getweaponammoclip(var_02,"left");
		if(!var_03 && !var_04)
		{
			return;
		}

		var_05 = self getweaponammostock(var_02);
		var_06 = function_0249(var_02);
		if(var_05 > var_06)
		{
			var_05 = var_06;
		}

		var_07 = self method_80B8(var_02);
		if(!isdefined(var_07))
		{
			return;
		}

		var_07 method_81CC(var_03,var_05,var_04);
	}
	else
	{
		var_07 = self method_80B8(var_03);
		if(!isdefined(var_07))
		{
			return;
		}

		var_07 method_81CC(1,1,0);
	}

	self.var_5D39 = 1;
	var_07.var_222 = self;
	var_07.var_336 = "dropped_weapon";
	var_07 thread func_13AF1();
	var_07 thread func_51CC();
}

//Function Number: 51
func_1175A(param_00,param_01,param_02,param_03)
{
	self.var_222 endon("disconnect");
	if(!isdefined(self) || !isdefined(self.var_222))
	{
		return;
	}

	var_04 = self.origin;
	for(;;)
	{
		wait(0.25);
		if(!isdefined(self))
		{
			return;
		}

		var_05 = self.origin;
		if(var_04 == var_05)
		{
			break;
		}

		var_04 = var_05;
	}

	if(!isdefined(self) || !isdefined(self.var_222))
	{
		return;
	}

	if(param_01 <= 0 && param_02 <= 0)
	{
		return;
	}

	var_06 = self.origin;
	var_07 = self.angles;
	var_08 = 2;
	var_09 = function_0240(param_00) * var_08;
	while(isdefined(self) && param_01 > 0 || param_02 > 0)
	{
		var_0A = (randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(0,1));
		var_0B = var_0A * 180;
		var_0C = var_0A * 1000;
		self.origin = var_06 + (0,0,10);
		self.angles = var_0B;
		thread scripts\mp\_utility::drawline(self.origin,self.origin + var_0C,2,(0,1,0));
		thread func_1174C(self.origin,var_0C,self.var_222,param_00);
		wait(var_09);
		if(!isdefined(self))
		{
			break;
		}

		param_01 = param_01 - var_08;
		param_02 = param_02 - var_08;
		if(param_01 <= 0)
		{
			param_01 = 0;
		}

		if(param_02 <= 0)
		{
			param_02 = 0;
		}

		self method_81CC(param_01,param_03,param_02);
	}

	if(!isdefined(self))
	{
		return;
	}

	self.origin = var_06;
	self.angles = var_07;
}

//Function Number: 52
func_1174C(param_00,param_01,param_02,param_03)
{
	param_02 endon("disconnect");
	var_04 = param_00 + param_01;
	var_05 = scripts\mp\_utility::func_1309(param_03,param_00,var_04,param_02);
}

//Function Number: 53
func_1015B()
{
	wait(0.1);
	if(!isdefined(self))
	{
		return;
	}

	var_00 = func_7F22();
	var_01 = getweaponbasename(var_00);
	var_02 = func_822A(var_01);
	switch(var_02)
	{
		case 4:
			playfxontag(scripts\common\utility::getfx("item_fx_epic"),self,"j_gun");
			break;

		case 3:
			playfxontag(scripts\common\utility::getfx("item_fx_legendary"),self,"j_gun");
			break;

		case 2:
			playfxontag(scripts\common\utility::getfx("item_fx_rare"),self,"j_gun");
			break;

		case 1:
			playfxontag(scripts\common\utility::getfx("item_fx_common"),self,"j_gun");
			break;
	}
}

//Function Number: 54
func_822A(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = strtok(param_00,"_");
	foreach(var_03 in var_01)
	{
		switch(var_03)
		{
			case "mpe":
				return 4;

			case "mpl":
				return 3;

			case "mpr":
				return 2;

			case "mp":
				return 1;
		}
	}

	return 0;
}

//Function Number: 55
func_5393(param_00,param_01)
{
	var_02 = self method_8108();
	var_03 = 0;
	while(var_03 < var_02)
	{
		var_04 = self method_8106(var_03);
		if(var_04 != param_00)
		{
			continue;
		}

		var_05 = self method_8109(var_03);
		self detach(param_00,var_05);
		if(var_05 != param_01)
		{
			var_02 = self method_8108();
			for(var_03 = 0;var_03 < var_02;var_03++)
			{
				var_05 = self method_8109(var_03);
				if(var_05 != param_01)
				{
					continue;
				}

				param_00 = self method_8106(var_03);
				self detach(param_00,var_05);
				break;
			}
		}

		return 1;
		var_04++;
	}

	return 0;
}

//Function Number: 56
func_51CC()
{
	self endon("death");
	wait(60);
	if(!isdefined(self))
	{
		return;
	}

	self delete();
}

//Function Number: 57
func_7F22()
{
	var_00 = self.classname;
	var_01 = getsubstr(var_00,7);
	return var_01;
}

//Function Number: 58
func_13AF1()
{
	self endon("death");
	var_00 = func_7F22();
	for(;;)
	{
		self waittill("trigger",var_01,var_02);
		var_03 = fixupplayerweapons(var_01,var_00);
		if(isdefined(var_02) || var_03)
		{
			break;
		}
	}

	if(isdefined(var_02))
	{
		var_04 = var_02 func_7F22();
		if(isdefined(var_01.var_119DF[var_04]))
		{
			var_02.var_222 = var_01.var_119DF[var_04];
			var_01.var_119DF[var_04] = undefined;
		}

		var_02.var_336 = "dropped_weapon";
		var_02 thread func_13AF1();
	}

	var_01.var_119DF[var_00] = self.var_222;
}

//Function Number: 59
fixupplayerweapons(param_00,param_01)
{
	var_02 = param_00 getweaponslistprimaries();
	var_03 = 1;
	var_04 = 1;
	foreach(var_06 in var_02)
	{
		if(param_00.var_D8E1 == var_06)
		{
			var_03 = 0;
			continue;
		}

		if(param_00.var_F0C4 == var_06)
		{
			var_04 = 0;
		}
	}

	if(var_03)
	{
		param_00.var_D8E1 = param_01;
	}
	else if(var_04)
	{
		param_00.var_F0C4 = param_01;
	}

	return var_03 || var_04;
}

//Function Number: 60
func_A036()
{
	var_00 = func_7F22();
	var_01 = weaponaltweaponname(var_00);
	for(var_02 = 1;var_01 != "none" && var_01 != var_00;var_02++)
	{
		self method_81CC(0,0,0,var_02);
		var_01 = weaponaltweaponname(var_01);
	}
}

//Function Number: 61
func_89DF(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	self waittill("scavenger",var_02);
	var_02 notify("scavenger_pickup");
	func_EBD2(var_02);
	scripts\mp\_powers::func_EBD4(var_02);
	var_02 scripts\mp\_damagefeedback::func_917F("scavenger");
}

//Function Number: 62
func_EBD2(param_00)
{
	var_01 = param_00 getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(!scripts\mp\_utility::func_9D78(var_03) && !level.var_EBD0)
		{
			continue;
		}

		if(func_9D3E(var_03) && weaponclass(var_03) == "grenade")
		{
			continue;
		}

		if(scripts\mp\_utility::func_8225(var_03) == "weapon_projectile")
		{
			continue;
		}

		if(var_03 == "venomxgun_mp")
		{
			continue;
		}

		var_04 = param_00 getweaponammostock(var_03);
		var_05 = weaponclipsize(var_03);
		if(issubstr(var_03,"akimbo") && scripts\mp\_utility::func_8234(var_03) != "iw7_fmg")
		{
			var_05 = var_05 * 2;
		}

		param_00 setweaponammostock(var_03,var_04 + var_05);
	}
}

//Function Number: 63
func_EBD3(param_00)
{
	if(isdefined(param_00.var_D782))
	{
		foreach(var_02 in param_00.var_D782)
		{
			param_00 notify("scavenged_ammo",var_02.var_13CE0);
			scripts\common\utility::func_136F7();
		}
	}
}

//Function Number: 64
func_5D52(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 == self)
	{
		return;
	}

	var_02 = self method_80B9("scavenger_bag_mp");
	if(!isdefined(var_02))
	{
		return;
	}

	var_02 thread func_89DF(self,param_01);
	if(isdefined(level.var_2D9E["bots_add_scavenger_bag"]))
	{
		[[ level.var_2D9E["bots_add_scavenger_bag"] ]](var_02);
	}
}

//Function Number: 65
weaponcanstoreaccuracystats(param_00)
{
	if(scripts\mp\_utility::iscacmeleeweapon(param_00))
	{
		return 0;
	}

	return scripts\mp\_utility::func_9D78(param_00) || scripts\mp\_utility::func_9D79(param_00);
}

//Function Number: 66
func_FB1D(param_00,param_01,param_02)
{
	scripts\mp\_gamelogic::func_FB1D(param_00,param_01,param_02);
}

//Function Number: 67
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
		thread scripts\mp\perks\_weaponpassives::func_12F62(self,var_01);
		scripts\mp\_gamelogic::func_F73B(self,1);
		var_02 = gettime();
		if(!isdefined(self.var_A9EE))
		{
			self.var_A9EE = 0;
		}

		var_03 = gettime() - self.var_A9EE;
		self.var_A9EE = var_02;
		if(scripts\mp\_utility::func_9FB3(level.jittermodcheck))
		{
			jittermodcheck(var_01);
		}
		else
		{
			level.jittermodcheck = getdvarint("scr_modDefense",0);
		}

		if(!issubstr(var_01,"silence") && var_03 > 500 && level.var_768F)
		{
			thread scripts\mp\killstreaks\_uplink::func_B37E();
		}

		if(isai(self))
		{
			continue;
		}

		if(!weaponcanstoreaccuracystats(var_01))
		{
			continue;
		}

		var_04 = var_01;
		if(scripts\mp\perks\_weaponpassives::doesshareammo(var_01))
		{
			var_04 = scripts\mp\_utility::func_E0CF(var_01);
		}

		if(isdefined(self.var_9045[var_04]))
		{
			thread func_9048(var_04);
		}

		var_05 = scripts\mp\_persistence::func_10E34("totalShots") + 1;
		var_06 = scripts\mp\_persistence::func_10E34("hits");
		var_07 = clamp(float(var_06) / float(var_05),0,1) * 10000;
		scripts\mp\_persistence::func_10E55("totalShots",var_05);
		scripts\mp\_persistence::func_10E55("accuracy",int(var_07));
		scripts\mp\_persistence::func_10E55("misses",int(var_05 - var_06));
		if(isdefined(self.var_AA0C) && self.var_AA0C.var_AA10 == gettime())
		{
			self.var_9042 = 0;
			return;
		}

		var_08 = 1;
		func_FB1D(var_01,var_08,"shots");
		func_FB1D(var_01,self.var_9042,"hits");
		self.var_9042 = 0;
	}
}

//Function Number: 68
jittermodcheck(param_00)
{
	var_01 = gettime();
	var_02 = self method_8118();
	var_03 = self method_8118("left");
	var_04 = undefined;
	var_05 = undefined;
	if(!isdefined(self.lastshot))
	{
		self.lastshot = [];
		self.lastshot["time"] = var_01;
		self.lastshot["time_left"] = var_01;
		self.lastshot["ammo"] = self method_8118();
		self.lastshot["ammo_left"] = self method_8118("left");
		self.lastshot["weapon"] = param_00;
		return;
	}

	if(param_00 == self.lastshot["weapon"] && !self ismantling())
	{
		var_04 = var_01 - self.lastshot["time"];
		var_05 = var_01 - self.lastshot["time_left"];
		var_06 = getweaponjittertime(param_00);
		if(self.lastshot["ammo"] != var_02)
		{
			if(var_04 < var_06)
			{
				self.ismodded = 1;
			}

			if(self.lastshot["ammo"] > var_02)
			{
				self.lastshot["time"] = var_01;
			}

			self.lastshot["ammo"] = var_02;
		}

		if(self.lastshot["ammo_left"] != var_03)
		{
			if(var_05 < var_06)
			{
				self.ismodded = 1;
			}

			if(self.lastshot["ammo_left"] > var_03)
			{
				self.lastshot["time_left"] = var_01;
			}

			self.lastshot["ammo_left"] = var_03;
		}
	}
	else
	{
		self.lastshot["weapon"] = param_00;
	}

	if(scripts\mp\_utility::func_9FB3(self.ismodded))
	{
		self setweaponammoclip(param_00,0);
		self setweaponammoclip(param_00,0,"left");
		self setweaponammostock(param_00,0);
		scripts\mp\_utility::func_2BBB("specialty_scavenger");
		self disableweaponpickup();
		self.lastshot = undefined;
	}
}

//Function Number: 69
getweaponjittertime(param_00)
{
	var_01 = getweaponbasename(param_00);
	var_02 = 1;
	var_03 = scripts\common\utility::func_116D7(issubstr(param_00,"akimbo"),1,0);
	switch(var_01)
	{
		case "iw7_devastator_mp":
			var_02 = 140;
			break;

		case "iw7_mod2187_mp":
			if(var_03)
			{
				var_02 = 1000;
			}
			else
			{
				var_02 = 1200;
			}
			break;

		case "iw7_sonic_mpr":
		case "iw7_sonic_mp":
			var_02 = 700;
			break;

		case "iw7_spas_mpl_slug":
		case "iw7_spas_mpr":
		case "iw7_spas_mpr_focus":
			var_02 = 900;
			break;

		case "iw7_longshot_mpl":
		case "iw7_longshot_mp":
			var_02 = 800;
			break;

		case "iw7_m1_mpr_silencer":
		case "iw7_m1_mpr":
		case "iw7_m1_mp":
			var_02 = 230;
			break;

		case "iw7_ake_mp_single":
			var_02 = 190;
			break;

		case "iw7_emc_mpl_spread":
			var_02 = 130;
			break;

		case "iw7_fmg_mpl_shotgun":
			if(func_9D3E(param_00))
			{
				var_02 = 130;
			}
			break;
	}

	return var_02;
}

//Function Number: 70
func_9047(param_00)
{
	if(param_00 == "none")
	{
		return;
	}

	if((scripts\mp\_utility::func_9D78(param_00) || scripts\mp\_utility::func_9D79(param_00)) && !isdefined(self.var_9045[param_00]))
	{
		self.var_9045[param_00] = weaponclipsize(param_00);
	}
}

//Function Number: 71
func_9048(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("updateMagShots_" + param_00);
	self.var_9045[param_00]--;
	wait(0.05);
	self notify("shot_missed",param_00);
	self.var_453C[param_00] = 0;
	self.var_9045[param_00] = weaponclipsize(param_00);
}

//Function Number: 72
func_9046(param_00)
{
	self endon("death");
	self endon("disconnect");
	self notify("updateMagShots_" + param_00);
	waittillframeend;
	if(isdefined(self.var_9045[param_00]) && self.var_9045[param_00] == 0)
	{
		var_01 = scripts\mp\_utility::func_8225(param_00);
		scripts\mp\_missions::func_D992(var_01);
		self.var_9045[param_00] = weaponclipsize(param_00);
	}
}

//Function Number: 73
func_3E1E(param_00,param_01)
{
	self endon("disconnect");
	if(scripts\mp\_utility::isstrstart(param_00,"alt_"))
	{
		var_02 = scripts\mp\_utility::func_821A(param_00);
		if(scripts\common\utility::func_2286(var_02,"shotgun") || scripts\common\utility::func_2286(var_02,"gl"))
		{
			self.var_9042 = 1;
		}
		else
		{
			param_00 = getsubstr(param_00,4);
		}
	}

	if(!weaponcanstoreaccuracystats(param_00))
	{
		return;
	}

	if(self meleebuttonpressed() && param_00 != "iw7_knife_mp")
	{
		return;
	}

	switch(weaponclass(param_00))
	{
		case "mg":
		case "rifle":
		case "sniper":
		case "smg":
		case "pistol":
			self.var_9042++;
			break;

		case "spread":
			self.var_9042 = 1;
			break;

		default:
			break;
	}

	if(func_9F2D(param_00) || param_00 == "iw7_knife_mp")
	{
		thread scripts\mp\_gamelogic::func_117B7(param_00,self.var_9042,"hits");
		self.var_9042 = 0;
	}

	waittillframeend;
	if(isdefined(self.var_9045[param_00]))
	{
		thread func_9046(param_00);
	}

	if(!isdefined(self.var_A99F[param_00]))
	{
		self.var_A99F[param_00] = 0;
	}

	if(self.var_A99F[param_00] == gettime())
	{
		return;
	}

	self.var_A99F[param_00] = gettime();
	if(!isdefined(self.var_453C) || !isdefined(self.var_453C[param_00]))
	{
		self.var_453C[param_00] = 1;
	}
	else
	{
		self.var_453C[param_00]++;
	}

	var_03 = scripts\mp\_persistence::func_10E34("totalShots");
	var_04 = scripts\mp\_persistence::func_10E34("hits") + 1;
	if(var_04 <= var_03)
	{
		scripts\mp\_persistence::func_10E55("hits",var_04);
		scripts\mp\_persistence::func_10E55("misses",int(var_03 - var_04));
		var_05 = clamp(float(var_04) / float(var_03),0,1) * 10000;
		scripts\mp\_persistence::func_10E55("accuracy",int(var_05));
	}

	thread scripts\mp\_missions::func_C5A8(param_00);
	thread scripts\mp\contractchallenges::contractshotslanded(param_00);
	self.var_A96A = gettime();
	var_06 = scripts\mp\_utility::func_8225(param_00);
	if(var_06 == "weapon_lmg")
	{
		if(!isdefined(self.shotslandedlmg))
		{
			self.shotslandedlmg = 1;
			return;
		}

		self.shotslandedlmg++;
	}
}

//Function Number: 74
func_24E2(param_00,param_01)
{
	return func_7415(param_01,param_00);
}

//Function Number: 75
func_7415(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return 1;
	}

	if(!level.teambased)
	{
		return 1;
	}

	var_04 = level.var_740A;
	if(isdefined(param_02))
	{
		var_04 = param_02;
	}

	if(var_04 != 0)
	{
		return 1;
	}

	if(param_01 == param_00 || isdefined(param_01.var_222) && param_01.var_222 == param_00)
	{
		return 1;
	}

	var_05 = undefined;
	if(isdefined(param_01.var_222))
	{
		var_05 = param_01.var_222.team;
	}
	else if(isdefined(param_01.team))
	{
		var_05 = param_01.team;
	}

	if(!isdefined(var_05))
	{
		return 1;
	}

	if(var_05 != param_00.team)
	{
		return 1;
	}

	return 0;
}

//Function Number: 76
func_13A1F()
{
	self notify("watchEquipmentOnSpawn");
	self endon("watchEquipmentOnSpawn");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("faux_spawn");
	if(!isdefined(self.var_CC4C))
	{
		self.var_CC4C = [];
	}

	if(!isdefined(self.var_CC4D))
	{
		self.var_CC4D = [];
	}

	func_51AF();
	var_00 = scripts\mp\_utility::func_7F1D("scr_deleteexplosivesonspawn",1) && !scripts\mp\_utility::_hasperk("specialty_rugged_eqp") || !checkequipforrugged();
	if(var_00)
	{
		func_51CE();
	}

	var_01 = self.var_CC4D.size;
	var_02 = self.var_CC4C.size;
	var_03 = var_01 && var_02;
	if(scripts\mp\_utility::_hasperk("specialty_rugged_eqp") && var_03)
	{
		thread scripts\mp\perks\_perkfunctions::func_6BC4(var_02,var_01);
	}
}

//Function Number: 77
checkequipforrugged()
{
	var_00 = scripts\common\utility::array_combine(self.var_CC4D,self.var_CC4C);
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.hasruggedeqp))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 78
func_13A9B()
{
	self notify("watchGrenadeUsage");
	self endon("watchGrenadeUsage");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("faux_spawn");
	func_13A97();
}

//Function Number: 79
func_13A97()
{
	var_00 = scripts\mp\_utility::func_1377B();
	if(!isdefined(var_00))
	{
		return;
	}

	if(!isdefined(var_00.var_13C2E))
	{
		return;
	}

	func_FB1D(var_00.var_13C2E,1,"shots");
	scripts\mp\_gamelogic::func_F73B(self,1);
	if(isdefined(level.var_2C46[var_00.var_13C2E]))
	{
		var_00 thread func_4988(level.var_2C46[var_00.var_13C2E].model,level.var_2C46[var_00.var_13C2E].var_2DD,self);
	}

	if(getweaponbasename(var_00.var_13C2E) == "iw7_glprox_mp")
	{
		var_01 = func_83F3(var_00.var_13C2E);
		if(var_01 == "stickglprox")
		{
			func_F21A(var_00);
		}

		return;
	}

	if(getweaponbasename(var_01.var_13C2E) == "iw7_venomx_mp")
	{
		var_01.var_FF03 = self method_84D9();
		return;
	}

	if(isaxeweapon(var_01.var_13C2E))
	{
		var_01.var_FF03 = self method_84D9();
		var_01 thread watchgrenadeaxepickup(self);
		return;
	}

	switch(var_01.var_13C2E)
	{
		case "frag_grenade_mp":
			if(var_01.var_118A2 >= 1)
			{
				var_01.var_9D93 = 1;
			}
	
			var_01.var_C731 = self;
			var_01 thread scripts\mp\_shellshock::func_858A();
			break;

		case "cluster_grenade_mp":
			var_01.var_42E0 = var_01.var_118A2;
			if(var_01.var_118A2 >= 1)
			{
				var_01.var_9D93 = 1;
			}
	
			var_01.var_C731 = self;
			thread func_42DE(var_01);
			var_01 thread scripts\mp\_shellshock::func_858A();
			break;

		case "wristrocket_mp":
			if(var_01.var_118A2 >= 1)
			{
				var_01.var_9D93 = 1;
			}
	
			var_01.var_C731 = self;
			thread lib_0E0B::func_13DFC(var_01);
			var_01 thread scripts\mp\_shellshock::func_858A(0.6);
			break;

		case "iw6_aliendlc22_mp":
			var_01 thread scripts\mp\_shellshock::func_858A();
			var_01.var_C731 = self;
			break;

		case "semtex_mp":
			thread func_F21A(var_01);
			break;

		case "cryo_mine_mp":
			thread lib_0DE3::func_4ADA(var_01);
			break;

		case "c4_mp":
			thread lib_0DDD::func_333E(var_01);
			break;

		case "proximity_explosive_mp":
			thread func_DACD(var_01);
			break;

		case "flash_grenade_mp":
			var_01.var_BFD5 = var_01.var_118A2;
			if(var_01.var_118A2 >= 1)
			{
				var_01.var_9D93 = 1;
			}
	
			var_01 thread func_BFD3();
			break;

		case "throwingknifedisruptor_mp":
			thread func_56E6(var_01);
			break;

		case "smoke_grenadejugg_mp":
		case "smoke_grenade_mp":
			var_01 thread func_1037B();
			break;

		case "gas_grenade_mp":
			var_01 thread func_13A8A();
			break;

		case "concussion_grenade_mp":
			thread scripts\mp\_concussiongrenade::func_44EE(var_01);
			break;

		case "alientrophy_mp":
		case "trophy_mp":
			thread scripts\mp\_trophy_system::func_12827(var_01);
			break;

		case "claymore_mp":
			thread func_402D(var_01);
			break;

		case "alienbetty_mp":
		case "bouncingbetty_mp":
			thread func_B780(var_01,::func_108E3);
			break;

		case "motion_sensor_mp":
			thread func_B780(var_01,::func_108E7);
			break;

		case "mobile_radar_mp":
			thread func_B780(var_01,::func_108E5);
			break;

		case "distortionfield_grenade_mp":
			var_01 thread func_139F5();
			break;

		case "throwingknifejugg_mp":
		case "throwingknifehack_mp":
		case "throwingknifesiphon_mp":
		case "throwingknifesmokewall_mp":
		case "throwingknifeteleport_mp":
		case "throwingknife_mp":
		case "throwingknifec4_mp":
			level thread func_11824(self,var_01,var_01.var_13C2E);
			break;

		case "sensor_grenade_mp":
			break;

		case "sonic_sensor_mp":
			thread func_B780(var_01,::func_10910);
			break;

		case "proto_ricochet_device_mp":
			thread scripts\mp\_ricochet::func_E4E9(var_01);
			break;

		case "proxy_bomb_mp":
			thread func_DAD5(self,var_01);
			break;

		case "disc_marker_mp":
			thread func_562B(self,var_01);
			break;

		case "adrenaline_mist_mp":
			break;

		case "case_bomb_mp":
			thread func_3B0E(self,var_01);
			break;

		case "domeshield_mp":
			thread scripts\mp\_domeshield::func_5910(var_01);
			break;

		case "blackhole_grenade_mp":
			thread scripts\mp\_blackholegrenade::func_2B3D(var_01);
			break;

		case "portal_grenade_mp":
			break;

		case "copycat_grenade_mp":
			break;

		case "speed_strip_mp":
			break;

		case "shard_ball_mp":
			if(scripts\mp\_powerloot::func_D779(var_01.var_D719,"passive_grenade_to_mine"))
			{
				thread func_B780(var_01,::func_1090D,::scripts\mp\_shardball::func_CC21);
			}
			else
			{
				thread scripts\mp\_shardball::func_FC5B(var_01);
			}
			break;

		case "splash_grenade_mp":
			var_01 thread scripts\mp\_shellshock::func_858A();
			thread scripts\mp\_splashgrenade::func_10A35(var_01);
			break;

		case "forcepush_mp":
			break;

		case "portal_generator_mp":
			break;

		case "transponder_mp":
			break;

		case "throwingreaper_mp":
			break;

		case "pulse_grenade_mp":
			thread lib_0DFC::func_DAF5(var_01);
			break;

		case "ammo_box_mp":
			break;

		case "virus_grenade_mp":
			break;

		case "fear_grenade_mp":
			thread func_B780(var_01,::func_10884);
			break;

		case "deployable_cover_mp":
			break;

		case "power_spider_grenade_mp":
			thread lib_0E05::spidergrenade_used(var_01);
			break;

		case "split_grenade_mp":
			thread lib_0E06::func_10A54(var_01);
			break;

		case "trip_mine_mp":
			thread lib_0E09::func_127F2(var_01);
			break;

		case "power_exploding_drone_mp":
			thread lib_0DE6::func_69D4(var_01);
			break;
	}
}

//Function Number: 80
func_562B(param_00,param_01)
{
	param_01 waittill("missile_stuck");
	param_00 notify("markerPlanted",param_01);
}

//Function Number: 81
func_3B0E(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_01 endon("death");
	param_01 waittill("missile_stuck");
	if(!isdefined(param_01.origin))
	{
	}
}

//Function Number: 82
func_3B0D(param_00,param_01)
{
	level endon("game_ended");
	wait(0.05);
	var_02 = param_00 method_8113();
	wait(randomfloatrange(0.5,0.8));
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = var_02.origin;
	self playsound("frag_grenade_explode");
	earthquake(0.5,1.5,var_03,120);
	playfx(level._effect["case_bomb"],var_03 + (0,0,12));
	thread scripts\mp\_utility::func_13AF(var_03,256,400,50,self,"MOD_EXPLOSIVE","case_bomb_mp",0);
	wait(0.1);
	playfx(level._effect["corpse_pop"],var_03 + (0,0,12));
	if(isdefined(var_02))
	{
		var_02 hide();
	}
}

//Function Number: 83
func_DAD5(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("death");
	param_01 waittill("missile_stuck",var_02);
	if(isdefined(var_02) && isplayer(var_02) || isagent(var_02))
	{
		param_01 method_8099(param_00);
	}
}

//Function Number: 84
func_11824(param_00,param_01,param_02)
{
	param_01 makeunusable();
	if(param_02 == "throwingknifehack_mp")
	{
	}
	else if(param_02 == "throwingknifec4_mp")
	{
		param_01 thread func_DDF3();
	}

	var_03 = undefined;
	var_04 = undefined;
	if(param_02 == "throwingknifesmokewall_mp")
	{
		param_01 func_1181E(param_00);
		return;
	}
	else
	{
		param_01 waittill("missile_stuck",var_03,var_04);
	}

	var_05 = isdefined(var_04) && var_04 == "tag_flicker";
	var_06 = isdefined(var_04) && var_04 == "tag_weapon";
	if(isdefined(var_03) && isplayer(var_03) || isagent(var_03) && var_05)
	{
		var_03 notify("shield_hit",param_01);
	}

	if(isdefined(var_03) && isplayer(var_03) || isagent(var_03) && !var_06 && !var_05)
	{
		if(!lib_0DF8::func_213D(var_03,param_01))
		{
			param_01 delete();
			return;
		}
		else if(param_02 == "throwingknifeteleport_mp")
		{
		}
		else if(param_02 == "throwingknifec4_mp")
		{
			func_11818(param_01,var_03,param_00);
		}
		else if(param_02 == "throwingknifesiphon_mp")
		{
			lib_0E01::func_1181D(param_01,var_03,param_00);
			return;
		}
		else if(param_02 == "throwingknifehack_mp")
		{
			return;
		}
	}

	thread func_11825(param_00,param_01);
	param_01 endon("death");
	param_01 makeunusable();
	var_07 = spawn("trigger_radius",param_01.origin,0,64,64);
	var_07 enablelinkto();
	var_07 linkto(param_01);
	var_07.var_336 = "dropped_knife";
	param_01.var_A702 = var_07;
	param_01 thread func_13A90();
	for(;;)
	{
		scripts\common\utility::func_136F7();
		if(!isdefined(var_07))
		{
			return;
		}

		var_07 waittill("trigger",var_08);
		if(!isplayer(var_08) || !scripts\mp\_utility::func_9F19(var_08))
		{
			continue;
		}

		if(!var_08 hasweapon(param_02))
		{
			continue;
		}

		if(func_11827(var_08,param_01.var_D719))
		{
			param_01 delete();
			break;
		}
	}
}

//Function Number: 85
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

//Function Number: 86
func_11825(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_C794(param_01,"white",param_00,1,0,"equipment");
	param_01 waittill("death");
	scripts\mp\_utility::func_C78F(var_02,param_01);
}

//Function Number: 87
func_11827(param_00,param_01)
{
	if(param_00 scripts\mp\_powers::func_D734(param_01) == param_00 scripts\mp\_powers::func_D736(param_01))
	{
		return 0;
	}

	param_00 scripts\mp\_powers::func_D74C(param_01);
	param_00 scripts\mp\_hud_message::func_1013D("throwingknife");
	return 1;
}

//Function Number: 88
throwingknife_detachknivesfromcorpse(param_00)
{
	var_01 = param_00 getlinkedchildren();
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = var_03.var_13C2E;
		if(isdefined(var_04) && func_9FA9(var_04))
		{
			var_03 unlink();
			var_05 = throwingknife_getdudknifeweapon(var_04);
			var_03 = var_03.var_222 scripts\mp\_utility::func_1302(var_05,var_03.origin,(0,0,0),100,1,var_03);
			if(isdefined(var_03.var_222))
			{
				var_03 method_82DD(var_03.var_222);
			}

			thread throwingknife_triggerlinkto(var_03);
			var_03 missiledonttrackkillcam();
		}
	}
}

//Function Number: 89
throwingknife_triggerlinkto(param_00)
{
	param_00 endon("death");
	while(!isdefined(param_00.var_A702))
	{
		scripts\common\utility::func_136F7();
	}

	var_01 = param_00.var_A702;
	var_01 endon("death");
	var_01 unlink();
	throwingknife_triggerlinktointernal(var_01,param_00);
	var_01 dontinterpolate();
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_01 linkto(param_00);
}

//Function Number: 90
throwingknife_triggerlinktointernal(param_00,param_01)
{
	param_01 endon("missile_stuck");
	for(;;)
	{
		param_00.origin = param_01.origin;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 91
throwingknife_getdudknifeweapon(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "throwingknifec4_mp":
			var_01 = "throwingknifec4dud_mp";
			break;

		case "throwingknifeteleport_mp":
			var_01 = "throwingknifeteleportdud_mp";
			break;

		default:
			var_01 = "throwingknifec4dud_mp";
			break;
	}

	return var_01;
}

//Function Number: 92
func_11819()
{
	level._effect["throwingknifec4_explode"] = loadfx("vfx/iw7/_requests/mp/power/vfx_bio_spike_exp.vfx");
}

//Function Number: 93
func_11818(param_00,param_01,param_02)
{
	scripts\mp\_missions::func_2AEA(param_00,param_02,param_01);
	param_01 playsound("biospike_explode");
	playfx(scripts\common\utility::getfx("throwingknifec4_explode"),param_00.origin);
	param_00 radiusdamage(param_00.origin,180,140,70,param_02,"MOD_EXPLOSIVE",param_00.var_13C2E);
	param_00 thread scripts\mp\_shellshock::func_858A();
	param_00 notify("explode",param_00.origin);
}

//Function Number: 94
func_1181E(param_00)
{
	param_00 thread lib_0E02::func_1037D(self);
}

//Function Number: 95
func_F235(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	var_03 = spawnstruct();
	var_03.var_C78B = [];
	var_04 = 0;
	thread func_F233(param_00,param_01);
	while(isdefined(param_01))
	{
		foreach(var_06 in level.var_3CB5)
		{
			if(!isdefined(var_06))
			{
				continue;
			}

			if(!param_00 scripts\mp\_utility::func_9DD6(var_06))
			{
				continue;
			}

			if(var_06 scripts\mp\_utility::_hasperk("specialty_incog"))
			{
				continue;
			}

			if(isdefined(var_03.var_C78B[var_06 getentitynumber()]))
			{
				continue;
			}

			if(distancesquared(param_01.origin,var_06.origin) > 90000)
			{
				continue;
			}

			var_03.var_C78B[var_06 getentitynumber()] = var_06;
			thread func_F234(param_00,var_06,var_03);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 96
func_10413(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_01 endon("death");
	var_03 = spawnstruct();
	var_03.var_C78B = [];
	var_04 = 0;
	thread func_F233(param_00,param_01);
	while(isdefined(param_01))
	{
		foreach(var_06 in level.var_3CB5)
		{
			if(!isdefined(var_06))
			{
				continue;
			}

			if(!param_00 scripts\mp\_utility::func_9DD6(var_06))
			{
				continue;
			}

			if(var_06 scripts\mp\_utility::_hasperk("specialty_quieter"))
			{
				continue;
			}

			if(isdefined(var_03.var_C78B[var_06 getentitynumber()]))
			{
				continue;
			}

			if(distancesquared(param_01.origin,var_06.origin) > 90000)
			{
				continue;
			}

			var_07 = scripts\common\utility::array_add_safe(level.players,param_01);
			if(!scripts\common\trace::func_DCF1(param_01.origin,var_06.origin + (0,0,32),var_07))
			{
				continue;
			}

			var_03.var_C78B[var_06 getentitynumber()] = var_06;
			thread func_F234(param_00,var_06,var_03);
		}

		wait(2);
	}
}

//Function Number: 97
func_F233(param_00,param_01)
{
	param_01 endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	scripts\common\utility::func_136F7();
	scripts\mp\_utility::func_C794(param_01,"cyan",param_00,0,0,"equipment");
	if(param_01.var_13C2E == "sonic_sensor_mp")
	{
		playfxontag(scripts\common\utility::getfx("vfx_sonic_sensor_pulse"),param_01,"tag_origin");
		return;
	}

	playfxontagforclients(scripts\common\utility::getfx("vfx_sensor_grenade_ping"),param_01,"tag_origin",param_00);
}

//Function Number: 98
func_F234(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	var_03 = param_01 getentitynumber();
	var_04 = undefined;
	param_01 scripts\mp\_damagefeedback::func_12E84("hitmotionsensor");
	var_04 = scripts\mp\_utility::func_C794(param_01,"orange",param_00,0,0,"equipment");
	wait(0.5);
	if(isdefined(param_01) && isdefined(var_04))
	{
		scripts\mp\_utility::func_C78F(var_04,param_01);
	}

	param_02.var_C78B[var_03] = undefined;
}

//Function Number: 99
func_13A90()
{
	self waittill("death");
	if(isdefined(self.var_A702))
	{
		self.var_A702 delete();
	}

	if(isdefined(self.useobj_trigger))
	{
		self.useobj_trigger delete();
	}
}

//Function Number: 100
func_1037B()
{
	thread scripts\mp\_utility::func_C15A("death","end_explode");
	self endon("end_explode");
	self waittill("explode",var_00);
	thread func_10377(var_00);
	if(isdefined(self.var_222))
	{
		self.var_222 thread func_BA19();
	}
}

//Function Number: 101
func_10377(param_00)
{
	wait(1);
	thread func_10378(param_00);
	var_01 = scripts\mp\_utility::func_180C(param_00,200);
	wait(8.25);
	scripts\mp\_utility::func_E14A(var_01);
}

//Function Number: 102
smokeunderbarrelused(param_00)
{
	self endon("disconnect");
	param_00 waittill("explode",var_01);
	self method_8449("smoke_grenade_mp",var_01,(0,0,0));
	param_00 thread func_10377(var_01);
}

//Function Number: 103
func_10378(param_00)
{
	var_01 = spawnstruct();
	var_01.var_2B98 = [];
	func_10379(var_01,param_00);
	foreach(var_03 in var_01.var_2B98)
	{
		if(isdefined(var_03) && scripts\mp\_utility::func_9F19(var_03))
		{
			var_03 scripts\mp\_utility::func_E150("specialty_blindeye");
		}
	}
}

//Function Number: 104
func_10379(param_00,param_01)
{
	level endon("game_ended");
	var_02 = gettime() + 8250;
	var_03 = [];
	while(gettime() < var_02)
	{
		var_03 = scripts\mp\_utility::func_807C(param_01,200);
		foreach(var_07, var_05 in param_00.var_2B98)
		{
			if(!isdefined(var_05))
			{
				param_00.var_2B98[var_07] = undefined;
				continue;
			}

			var_06 = scripts\common\utility::func_2291(var_03,var_05);
			if(!isdefined(var_06) || !scripts\mp\_utility::func_9F19(var_05) || lib_0DF8::func_9DDF(var_05))
			{
				var_05 scripts\mp\_utility::func_E150("specialty_blindeye");
				param_00.var_2B98[var_07] = undefined;
			}

			if(isdefined(var_06))
			{
				var_03[var_06] = undefined;
			}
		}

		foreach(var_09 in var_03)
		{
			if(!isdefined(var_09))
			{
				continue;
			}

			if(isdefined(param_00.var_2B98[var_09 getentitynumber()]))
			{
				continue;
			}

			if(!scripts\mp\_utility::func_9F19(var_09) || lib_0DF8::func_9DDF(var_09) || scripts\mp\_utility::func_9F72(var_09))
			{
				continue;
			}

			var_09 scripts\mp\_utility::func_8387("specialty_blindeye");
			param_00.var_2B98[var_09 getentitynumber()] = var_09;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 105
func_BA19()
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("monitorSmokeActive()");
	self endon("monitorSmokeActive()");
	scripts\mp\_utility::func_D915("smoke grenade activated",self);
	self.var_8BC1 = 1;
	var_00 = scripts\common\utility::waittill_any_timeout_1(9.25,"death");
	self.var_8BC1 = 0;
	scripts\mp\_utility::func_D915("smoke grenade deactivated",self);
}

//Function Number: 106
func_13A8A()
{
	var_00 = self.var_222;
	var_00 endon("disconnect");
	self waittill("explode",var_01);
	thread func_C534(var_00,var_01);
}

//Function Number: 107
func_C534(param_00,param_01)
{
	var_02 = spawn("trigger_radius",param_01,0,128,160);
	var_02.var_222 = param_00;
	var_03 = 128;
	var_04 = spawnfx(scripts\common\utility::getfx("gas_grenade_smoke_enemy"),param_01);
	triggerfx(var_04);
	wait(1);
	var_05 = 3;
	var_06 = spawn("script_model",param_01 + (0,0,60));
	var_06 linkto(var_02);
	var_02.var_A63A = var_06;
	while(var_05 > 0)
	{
		foreach(var_08 in level.var_3CB5)
		{
			var_08 func_20CC(param_00,param_01,var_02,var_02,4);
		}

		wait(0.2);
		var_05 = var_05 - 0.2;
	}

	var_04 delete();
	wait(2);
	var_06 delete();
	var_02 delete();
}

//Function Number: 108
func_20CC(param_00,param_01,param_02,param_03,param_04)
{
	if(isalive(self) && self istouching(param_02))
	{
		if(param_00 scripts\mp\_utility::func_9DD6(self) || self == param_00)
		{
			param_03 radiusdamage(self.origin,1,param_04,param_04,param_00,"MOD_RIFLE_BULLET","gas_grenade_mp");
		}
	}
}

//Function Number: 109
func_AF2B(param_00)
{
	var_01 = [];
	if(level.teambased)
	{
		if(isdefined(param_00) && param_00 == 1)
		{
			foreach(var_03 in level.var_3CB5)
			{
				if(isdefined(var_03) && isalive(var_03) && var_03.team != self.team)
				{
					var_01[var_01.size] = var_03;
				}
			}
		}

		if(isdefined(level.var_1655))
		{
			foreach(var_06 in level.var_1655)
			{
				if(isdefined(var_06.var_18DE) && var_06.team != self.team)
				{
					var_01[var_01.size] = var_06;
				}
			}
		}

		if(isdefined(level.var_11267) && isdefined(level.var_11267.var_12801))
		{
			foreach(var_09 in level.var_11267.var_12801)
			{
				if(isdefined(var_09) && isdefined(var_09.team) && var_09.team != self.team)
				{
					var_01[var_01.size] = var_09;
				}
			}
		}

		if(isdefined(level.var_B726))
		{
			foreach(var_0C in level.var_B726)
			{
				if(isdefined(var_0C) && isdefined(var_0C.team) && var_0C.team != self.team)
				{
					var_01[var_01.size] = var_0C;
				}
			}
		}
	}
	else
	{
		if(isdefined(param_00) && param_00 == 1)
		{
			foreach(var_03 in level.var_3CB5)
			{
				if(!isdefined(var_03) || !isalive(var_03))
				{
					continue;
				}

				var_01[var_01.size] = var_03;
			}
		}

		if(isdefined(level.var_1655))
		{
			foreach(var_06 in level.var_1655)
			{
				if(isdefined(var_06.var_18DE) && isdefined(var_06.var_222) && var_06.var_222 != self)
				{
					var_01[var_01.size] = var_06;
				}
			}
		}

		if(isdefined(level.var_11267) && isdefined(level.var_11267.var_12801))
		{
			foreach(var_09 in level.var_11267.var_12801)
			{
				if(isdefined(var_09) && isdefined(var_09.var_222) && var_09.var_222 != self)
				{
					var_01[var_01.size] = var_09;
				}
			}
		}

		if(isdefined(level.var_B726))
		{
			foreach(var_0C in level.var_B726)
			{
				if(isdefined(var_0C) && isdefined(var_0C.var_222) && var_0C.var_222 != self)
				{
					var_01[var_01.size] = var_0C;
				}
			}
		}
	}

	return var_01;
}

//Function Number: 110
func_13AD5()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = scripts\mp\_utility::func_137A6();
		if(!isdefined(var_00))
		{
			continue;
		}

		switch(var_00.var_13C2E)
		{
			case "stinger_mp":
			case "iw7_lockon_mp":
				level notify("stinger_fired",self,var_00,self.var_10FAA);
				break;
	
			case "javelin_mp":
			case "lasedStrike_missile_mp":
			case "remote_mortar_missile_mp":
				level notify("stinger_fired",self,var_00,self.var_A445);
				break;
	
			case "iw7_blackholegun_mp":
				thread lib_0E0F::func_B8B1(var_00.var_13C2E,var_00);
				break;
	
			case "iw7_unsalmg_mpl_auto":
			case "iw7_unsalmg_mp":
			case "iw7_unsalmg_mpl":
				var_00.var_13C2E = "power_smoke_drone_mp";
				thread lib_0DE6::func_69D4(var_00,1);
				break;
	
			case "iw7_tacburst_mpl":
			case "iw7_tacburst_mp":
				var_00 thread scripts\mp\_empgrenade::func_13A12();
				break;
	
			case "iw7_tacburst_mpl_epic2":
				var_00 thread scripts\mp\perks\_weaponpassives::cryogl_watchforexplode(self);
				break;
	
			case "iw7_mp28_mpl_fasthip":
				thread smokeunderbarrelused(var_00);
				break;
	
			default:
				break;
		}

		if(isplayer(self))
		{
			var_00.adsfire = scripts\mp\_utility::func_9EE8();
		}

		if(func_9DE7(var_00.var_13C2E))
		{
			var_01 = 1;
			if(func_9F5C(var_00.var_13C2E))
			{
				var_01 = 0.65;
			}

			var_00 thread scripts\mp\_shellshock::func_858A(var_01);
		}

		var_00.var_FF03 = self method_84D9();
	}
}

//Function Number: 111
func_9F5C(param_00)
{
	param_00 = getweaponbasename(param_00);
	var_01 = 0;
	switch(param_00)
	{
		case "iw7_venomx_mp":
		case "iw7_glprox_mp":
			var_01 = 1;
			break;

		default:
			break;
	}

	return var_01;
}

//Function Number: 112
func_9DE7(param_00)
{
	param_00 = getweaponbasename(param_00);
	switch(param_00)
	{
		case "iw7_cheytac_mpr_projectile":
		case "wristrocket_proj_mp":
			return 0;
	}

	return 1;
}

//Function Number: 113
func_13B38()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("sentry_placement_finished",var_00);
		thread scripts\mp\_utility::func_F63E(var_00,"tag_flash",65);
	}
}

//Function Number: 114
func_42D8(param_00)
{
	thread scripts\mp\_utility::func_C15A("death","end_explode");
	self endon("end_explode");
	self waittill("explode",var_01);
}

//Function Number: 115
func_42DE(param_00)
{
	if(isalive(self))
	{
		var_01 = anglestoforward(self getgunangles()) * 940;
		var_02 = (0,0,120);
		var_03 = var_01 + var_02;
	}
	else
	{
		var_01 = anglestoforward(self getgunangles()) * 50;
		var_02 = (0,0,10);
		var_03 = var_02 + var_03;
	}

	param_00 = scripts\mp\_utility::func_1302("cluster_grenade_mp",param_00.origin,var_03,100,1,param_00);
	param_00 thread func_4107();
	thread func_42DF(param_00);
}

//Function Number: 116
func_42DF(param_00,param_01)
{
	param_00 endon("death");
	self endon("disconnect");
	var_02 = 1 - param_00.var_118A1 * 3.5;
	wait(var_02);
	thread func_42DA(param_00);
}

//Function Number: 117
func_42DA(param_00)
{
	param_00 notify("death");
	param_00.var_69BA = 1;
	param_00.origin = param_00.origin;
	var_01 = spawn("script_model",param_00.origin);
	var_01 method_831F(param_00.var_222);
	var_01 setmodel("prop_mp_cluster_grenade_scr");
	func_42DB(param_00,var_01);
	if(isdefined(param_00))
	{
		param_00 method_8587(1);
	}

	wait(2);
	if(isdefined(var_01))
	{
		var_01 delete();
	}

	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 118
func_42DB(param_00,param_01)
{
	self endon("disconnect");
	scripts\mp\_utility::func_D915("cluster grenade explode",self);
	var_02 = scripts\common\trace::func_48BC(0,1,1,0,1,0,0);
	var_03 = param_00.origin;
	var_04 = 0;
	var_05 = var_03 + (0,0,3);
	var_06 = var_05 + (0,0,-5);
	var_07 = function_0287(var_05,var_06,var_02,undefined,0,"physicsquery_closest");
	if(isdefined(var_07) && var_07.size > 0)
	{
		var_04 = 1;
	}

	var_08 = scripts\common\utility::func_116D7(var_04,(0,0,32),(0,0,2));
	var_09 = var_03 + var_08;
	var_0A = randomint(90) - 45;
	var_02 = scripts\common\trace::func_48BC(0,1,1,0,1,1,0);
	for(var_0B = 0;var_0B < 4;var_0B++)
	{
		var_0C = "explode" + var_0B + 1;
		param_00 setscriptablepartstate(var_0C,"active",0);
		var_0D = scripts\common\utility::func_116D7(var_0B < 4,90 * var_0B + var_0A,randomint(360));
		var_0E = scripts\common\utility::func_116D7(var_04,110,90);
		var_0F = scripts\common\utility::func_116D7(var_04,12,45);
		var_10 = var_0E + randomint(var_0F * 2) - var_0F;
		var_11 = randomint(60) + 30;
		var_12 = cos(var_0D) * sin(var_10);
		var_13 = sin(var_0D) * sin(var_10);
		var_14 = cos(var_10);
		var_15 = (var_12,var_13,var_14) * var_11;
		var_05 = var_09;
		var_06 = var_09 + var_15;
		var_07 = function_0287(var_05,var_06,var_02,undefined,0,"physicsquery_closest");
		if(isdefined(var_07) && var_07.size > 0)
		{
			var_06 = var_07[0]["position"];
		}

		param_01 dontinterpolate();
		param_01.origin = var_06;
		param_01 setscriptablepartstate(var_0C,"active",0);
		wait(0.175);
	}
}

//Function Number: 119
func_4107()
{
	self endon("death");
	self.var_222 waittill("disconnect");
	self delete();
}

//Function Number: 120
func_10D85(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(!isdefined(param_04))
	{
		return;
	}

	if(param_06)
	{
		var_0B = spawnfx(param_07,self.origin);
		playsoundatpos(self.origin,param_08);
		triggerfx(var_0B);
		wait(2);
		var_0B delete();
	}
	else
	{
		wait(param_00);
	}

	if(!isdefined(param_04))
	{
		return;
	}

	radiusdamage(self.origin + (0,0,50),param_01,param_02,param_03,param_04,"MOD_EXPLOSIVE",param_0A);
	playfx(param_05,self.origin + (0,0,50));
	playsoundatpos(self.origin,param_09);
	self delete();
}

//Function Number: 121
func_BFD3()
{
	thread scripts\mp\_utility::func_C15A("death","end_explode");
	self endon("end_explode");
	self waittill("explode",var_00);
	thread func_5925(var_00,self.var_222,self.var_BFD5);
	func_BFD2(var_00,self.var_222,self.var_BFD5);
}

//Function Number: 122
func_BFD2(param_00,param_01,param_02)
{
	if(param_02 >= 5 || func_CBED(param_01,param_02))
	{
		playsoundatpos(param_00,"emp_grenade_explode_default");
		var_03 = func_7E8C(param_00,512,0,undefined);
		foreach(var_05 in var_03)
		{
			if(isdefined(var_05.var_222) && !func_7415(param_01,var_05.var_222))
			{
				continue;
			}

			var_05 notify("emp_damage",self.var_222,8);
		}
	}
}

//Function Number: 123
func_CBED(param_00,param_01)
{
	if(param_00 scripts\mp\_utility::_hasperk("specialty_pitcher"))
	{
		if(param_01 >= 4)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 124
func_5925(param_00,param_01,param_02)
{
	level endon("game_ended");
	var_03 = level.var_13C7D[self.var_13C2E];
	wait(randomfloatrange(0.25,0.5));
	for(var_04 = 1;var_04 < param_02;var_04++)
	{
		var_05 = func_7FF0(param_00,var_03.var_1336F);
		playsoundatpos(var_05,var_03.var_C525);
		playfx(var_03.var_C526,var_05);
		foreach(var_07 in level.players)
		{
			if(!scripts\mp\_utility::func_9F19(var_07) || var_07.sessionstate != "playing")
			{
				continue;
			}

			var_08 = var_07 geteye();
			var_09 = distancesquared(param_00,var_08);
			if(var_09 > var_03.var_DC05)
			{
				continue;
			}

			if(!bullettracepassed(param_00,var_08,0,var_07))
			{
				continue;
			}

			if(var_09 <= var_03.var_DC06)
			{
				var_0A = 1;
			}
			else
			{
				var_0A = 1 - var_09 - var_03.var_DC06 / var_03.var_DC05 - var_03.var_DC06;
			}

			var_0B = anglestoforward(var_07 getplayerangles());
			var_0C = param_00 - var_08;
			var_0C = vectornormalize(var_0C);
			var_0D = 0.5 * 1 + vectordot(var_0B,var_0C);
			var_0E = 1;
			var_07 notify("flashbang",param_00,var_0A,var_0D,param_01,var_0E);
		}

		wait(randomfloatrange(0.25,0.5));
	}
}

//Function Number: 125
func_7FF0(param_00,param_01)
{
	var_02 = (randomfloatrange(-1 * param_01,param_01),randomfloatrange(-1 * param_01,param_01),0);
	var_03 = param_00 + var_02;
	var_04 = bullettrace(param_00,var_03,0,self,0,0,0,0,0);
	if(var_04["fraction"] < 1)
	{
		var_03 = param_00 + var_04["fraction"] * var_02;
	}

	return var_03;
}

//Function Number: 126
func_56E6(param_00)
{
	param_00 waittill("missile_stuck",var_01);
	param_00 thread func_56E5(self,1);
}

//Function Number: 127
func_56E5(param_00,param_01)
{
	level endon("game_ended");
	var_02 = level.var_13C7D[self.var_13C2E];
	playfx(var_02.var_C523,self.origin);
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		foreach(var_05 in level.players)
		{
			if(!scripts\mp\_utility::func_9F19(var_05) || var_05.sessionstate != "playing")
			{
				continue;
			}

			if(var_05.team == self.var_222.team)
			{
				continue;
			}

			if(var_05 == self.var_222)
			{
				continue;
			}

			var_06 = var_05 geteye();
			if(!scripts\common\trace::func_DCF1(self.origin,var_06,level.players))
			{
				continue;
			}

			thread func_56E4(var_05,param_00,var_02,var_06);
		}

		wait(0.75);
		playsoundatpos(self.origin,var_02.var_C525);
		playfx(var_02.var_C526,self.origin);
	}

	self delete();
}

//Function Number: 128
func_56E4(param_00,param_01,param_02,param_03)
{
	var_04 = self.origin;
	var_05 = anglestoforward(param_00 getplayerangles());
	var_06 = var_04 - param_03;
	var_07 = vectornormalize(var_06);
	playfx(param_02.var_D828,var_04,rotatevector(var_06,(0,180,0)) * (1,1,-1));
	wait(0.75);
	if(param_00 adsbuttonpressed() && param_00 method_8409(var_04,65,300))
	{
		param_00 shellshock("disruptor_mp",2.5,0,1);
		return;
	}

	var_08 = distancesquared(var_04,param_03);
	if(var_08 < param_02.var_DC05)
	{
		if(var_08 <= param_02.var_DC06)
		{
			var_09 = 1;
		}
		else
		{
			var_09 = 1 - var_09 - param_03.var_DC06 / param_03.var_DC05 - param_03.var_DC06;
		}

		var_0A = 0.65 * 1 + vectordot(var_05,var_07);
		var_0B = 1;
		param_00 notify("flashbang",var_04,var_09,var_0A,param_01,var_0B);
	}
}

//Function Number: 129
func_3350(param_00)
{
	if(!scripts\mp\_utility::func_9F19(self))
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
	var_01 = level.var_13C7D["c4_mp"];
	param_00 thread func_57EB("tag_fx",var_01.var_B760["friendly"],var_01.var_B760["enemy"]);
	param_00 thread scripts\mp\_shellshock::func_3337();
	param_00 thread func_3341();
	param_00 thread func_3343();
	param_00 thread func_66B4(1);
	param_00 thread func_139C7();
	level thread func_B9CA(self,param_00);
}

//Function Number: 130
func_139C6()
{
	self.var_222 endon("disconnect");
	var_00 = self.var_222;
	var_01 = scripts\common\utility::spawn_tag_origin();
	var_01 linkto(self);
	thread func_334D(var_01);
	thread scripts\mp\_utility::func_C15A("death","end_explode");
	self endon("end_explode");
	self waittill("explode",var_02);
	thread func_334C(var_02,var_00,var_01);
}

//Function Number: 131
func_334C(param_00,param_01,param_02)
{
	param_01 endon("disconnect");
	wait(0.5);
	param_02 radiusdamage(param_00,256,140,70,param_01,"MOD_EXPLOSIVE","c4_mp");
	scripts\mp\_shellshock::func_858B(param_00);
}

//Function Number: 132
func_334D(param_00)
{
	param_00 endon("death");
	self waittill("death");
	wait(1);
	param_00 delete();
}

//Function Number: 133
func_BD4F(param_00)
{
	if(!isdefined(param_00.var_AA33) || !isdefined(param_00.var_AA33.var_5318) || param_00.var_AA33.var_5318)
	{
		self notify("detonateExplosive");
	}
}

//Function Number: 134
func_139C7()
{
	self endon("death");
	self waittill("missile_stuck",var_00);
	self method_8317(1);
	self.var_334F = 1;
	thread scripts\mp\perks\_perk_equipmentping::func_E84B();
	thread func_C798(self,self.var_222);
	scripts\mp\sentientpoolmanager::registersentient("Lethal_Static",self.var_222,1);
	func_69FF(var_00);
	func_B2A5();
}

//Function Number: 135
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

//Function Number: 136
func_DACD(param_00)
{
	if(!scripts\mp\_utility::func_9F19(self))
	{
		param_00 delete();
		return;
	}

	param_00 waittill("missile_stuck",var_01);
	if(!scripts\mp\_utility::func_9F19(self))
	{
		param_00 delete();
		return;
	}

	if(!isdefined(param_00.var_222.team))
	{
		param_00 delete();
		return;
	}

	var_02 = anglestoup(param_00.angles);
	param_00.origin = param_00.origin - var_02;
	var_03 = level.var_13C7D[param_00.var_13C2E];
	var_04 = spawn("script_model",param_00.origin + var_03.var_A640 * var_02);
	var_04 setscriptmoverkillcam("explosive");
	var_04 linkto(param_00);
	param_00.var_A63A = var_04;
	param_00 func_69FF(var_01);
	param_00 func_B2A5();
	param_00 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static",param_00.var_222,1);
	func_C54E(param_00);
	param_00 thread func_C4F4();
	param_00 thread func_3343();
	param_00 thread func_66B4(1);
	param_00 thread func_DACC(var_01);
	param_00 thread func_F692(self.team,20);
	level thread func_B9CA(self,param_00);
}

//Function Number: 137
func_DACC(param_00)
{
	self endon("death");
	self endon("disabled");
	var_01 = level.var_13C7D[self.var_13C2E];
	wait(var_01.var_217C);
	self playloopsound("ied_explo_beeps");
	thread func_57EB("tag_fx");
	var_02 = self.origin * (1,1,0);
	var_03 = var_01.var_53B5 / 2;
	var_04 = self.origin[2] - var_03;
	var_02 = var_02 + (0,0,var_04);
	var_05 = spawn("trigger_radius",var_02,0,var_01.var_53B6,var_01.var_53B5);
	var_05.var_222 = self;
	if(isdefined(param_00))
	{
		var_05 enablelinkto();
		var_05 linkto(self);
	}

	self.var_4D2A = var_05;
	thread func_51BF(var_05);
	var_06 = undefined;
	for(;;)
	{
		var_05 waittill("trigger",var_06);
		if(!isdefined(var_06))
		{
			continue;
		}

		if(getdvarint("scr_minesKillOwner") != 1)
		{
			if(isdefined(self.var_222))
			{
				if(var_06 == self.var_222)
				{
					continue;
				}

				if(isdefined(var_06.var_222) && var_06.var_222 == self.var_222)
				{
					continue;
				}
			}

			if(!func_7415(self.var_222,var_06,0))
			{
				continue;
			}
		}

		if(lengthsquared(var_06 method_8123()) < 10)
		{
			continue;
		}

		if(var_06 method_808F(self.origin,self) > 0)
		{
			break;
		}
	}

	self stoploopsound("ied_explo_beeps");
	self playsound("ied_warning");
	func_6A08(var_06,var_01.var_53B4,"proxExplosive");
	self notify("detonateExplosive");
}

//Function Number: 138
func_DACB()
{
	self endon("death");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		func_66A9();
		self.var_55BA = 1;
		self notify("disabled");
		func_DACA();
		wait(var_01);
		if(isdefined(self))
		{
			self.var_55BA = undefined;
			self notify("enabled");
			var_02 = self getlinkedparent();
			thread func_DACC(var_02);
		}
	}
}

//Function Number: 139
func_DACA()
{
	func_11061();
	if(isdefined(self.var_4D2A))
	{
		self.var_4D2A delete();
	}
}

//Function Number: 140
func_F692(param_00,param_01)
{
	self endon("death");
	wait(0.05);
	if(level.teambased)
	{
		scripts\mp\_entityheadicons::func_F877(param_00,(0,0,param_01));
		return;
	}

	if(isdefined(self.var_222))
	{
		scripts\mp\_entityheadicons::func_F7F2(self.var_222,(0,0,param_01));
	}
}

//Function Number: 141
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
	param_00 func_B2A5();
	param_00 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static",param_00.var_222,1);
	func_C54E(param_00,"power_claymore");
	param_00 thread func_C4F4();
	param_00 thread func_3343();
	param_00 thread func_66B4(1);
	param_00 thread func_4028(var_05);
	param_00 thread func_F692(self.pers["team"],20);
	level thread func_B9CA(self,param_00);
}

//Function Number: 142
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

			if(!func_7415(self.var_222,var_02,0))
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
	if(isdefined(self.var_222))
	{
		self.var_222 thread scripts\mp\_utility::func_AAEC("claymore_destroyed",undefined,undefined,self.origin);
	}

	self notify("detonateExplosive");
}

//Function Number: 143
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

//Function Number: 144
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

//Function Number: 145
func_3341()
{
	self endon("death");
	self waittill("missile_stuck",var_00);
	wait(0.05);
	self notify("activated");
	self.var_1604 = 1;
}

//Function Number: 146
func_139C3()
{
	self notify("watchC4AltDetonate");
	self endon("watchC4AltDetonate");
	self endon("death");
	self endon("disconnect");
	self endon("detonated");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = 0;
			while(self usebuttonpressed())
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			var_00 = 0;
			while(!self usebuttonpressed() && var_00 < 0.5)
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			if(!self.var_CC4C.size)
			{
				return;
			}

			if(!lib_0DF8::func_9DDF(self) && !scripts\mp\_utility::func_9FC6())
			{
				self notify("alt_detonate");
			}
		}

		wait(0.05);
	}
}

//Function Number: 147
func_139C5(param_00)
{
	self notify("watchC4Detonation");
	self endon("watchC4Detonation");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittillmatch("c4_mp","detonate");
		func_3349();
	}
}

//Function Number: 148
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
		if(var_00 != "c4_mp")
		{
			func_3349();
		}
	}
}

//Function Number: 149
func_3349()
{
	foreach(var_01 in self.var_CC4C)
	{
		if(isdefined(var_01) && var_01.var_13C2E == "c4_mp")
		{
			var_01 thread func_1369A(0.1);
		}
	}

	self.var_CC4C = [];
	self notify("c4_update",0);
	self notify("detonated");
}

//Function Number: 150
func_1369A(param_00)
{
	self endon("death");
	wait(param_00);
	func_1382F();
	self notify("detonateExplosive");
}

//Function Number: 151
func_3343()
{
	self endon("death");
	self endon("detonated");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_00 = undefined;
	var_01 = 1;
	if(self.var_222 scripts\mp\_utility::_hasperk("specialty_rugged_eqp"))
	{
		var_01++;
	}

	for(;;)
	{
		self waittill("damage",var_02,var_00,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!isplayer(var_00) && !isagent(var_00))
		{
			continue;
		}

		if(!func_7415(self.var_222,var_00))
		{
			continue;
		}

		if(func_66AA(var_0A,var_05))
		{
			continue;
		}

		var_0B = scripts\common\utility::func_116D7(scripts\mp\_utility::func_9DFF(var_0A,var_05),2,1);
		var_01 = var_01 - var_0B;
		if(var_01 <= 0)
		{
			break;
		}

		if(var_01 <= 0)
		{
			break;
		}
		else
		{
			var_00 scripts\mp\_damagefeedback::func_12E84("bouncing_betty");
		}
	}

	if(level.var_334B)
	{
		wait(0.1 + randomfloat(0.4));
	}
	else
	{
		wait(0.05);
	}

	if(!isdefined(self))
	{
		return;
	}

	level.var_334B = 1;
	thread func_E24B();
	if(isdefined(var_05) && issubstr(var_05,"MOD_GRENADE") || issubstr(var_05,"MOD_EXPLOSIVE"))
	{
		self.var_13908 = 1;
	}

	if(isdefined(var_09) && var_09 & level.var_92C4)
	{
		self.var_1390E = 1;
	}

	if(isdefined(var_09) && var_09 & level.var_92C6)
	{
		self.var_1390F = 1;
	}

	self.var_1390B = 1;
	if(isdefined(var_00))
	{
		self.var_4D3F = var_00;
	}

	if(isplayer(var_00))
	{
		var_00 scripts\mp\_damagefeedback::func_12E84("c4");
		if(var_00 != self.var_222 && var_00.team != self.var_222.team)
		{
			if(var_0A != "trophy_mp")
			{
				var_00 scripts\mp\killstreaks\_killstreaks::func_83A0();
			}
		}
	}

	if(level.teambased)
	{
		if(isdefined(var_00) && isdefined(self.var_222))
		{
			var_0C = var_00.pers["team"];
			var_0D = self.var_222.pers["team"];
			if(isdefined(var_0C) && isdefined(var_0D) && var_0C != var_0D)
			{
				var_00 notify("destroyed_equipment");
			}
		}
	}
	else if(isdefined(self.var_222) && isdefined(var_00) && var_00 != self.var_222)
	{
		var_00 notify("destroyed_equipment");
	}

	if(getdvarint("showArchetypes",0) > 0)
	{
		if(self.var_13C2E == "c4_mp")
		{
			self.var_222 notify("c4_update",0);
		}
	}

	self notify("detonateExplosive",var_00);
}

//Function Number: 152
func_E24B()
{
	wait(0.05);
	level.var_334B = 0;
}

//Function Number: 153
func_EB82(param_00,param_01)
{
	for(var_02 = 0;var_02 < 60;var_02++)
	{
		wait(0.05);
	}
}

//Function Number: 154
func_1382F()
{
	if(!isdefined(self.var_55BA))
	{
		return;
	}

	self waittill("enabled");
}

//Function Number: 155
func_3347(param_00)
{
	self waittill("activated");
	var_01 = spawn("trigger_radius",self.origin - (0,0,128),0,512,256);
	var_01.var_53B1 = "trigger" + gettime() + randomint(1000000);
	var_01.var_222 = self;
	var_01 thread func_53B0(level.var_C74B[param_00]);
	self waittill("death");
	var_01 notify("end_detection");
	if(isdefined(var_01.var_2C65))
	{
		var_01.var_2C65 destroy();
	}

	var_01 delete();
}

//Function Number: 156
func_4026(param_00)
{
	var_01 = spawn("trigger_radius",self.origin - (0,0,128),0,512,256);
	var_01.var_53B1 = "trigger" + gettime() + randomint(1000000);
	var_01.var_222 = self;
	var_01 thread func_53B0(level.var_C74B[param_00]);
	self waittill("death");
	var_01 notify("end_detection");
	if(isdefined(var_01.var_2C65))
	{
		var_01.var_2C65 destroy();
	}

	var_01 delete();
}

//Function Number: 157
func_53B0(param_00)
{
	self endon("end_detection");
	level endon("game_ended");
	while(!level.var_7669)
	{
		self waittill("trigger",var_01);
		if(!var_01.var_53AD)
		{
			continue;
		}

		if(level.teambased && var_01.team != param_00)
		{
			continue;
		}
		else if(!level.teambased && var_01 == self.var_222.var_222)
		{
			continue;
		}

		if(isdefined(var_01.var_2C67[self.var_53B1]))
		{
			continue;
		}

		var_01 thread func_1012C(self);
	}
}

//Function Number: 158
func_B9CA(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("death");
	param_00 scripts\common\utility::waittill_any_3("joined_team","joined_spectators","disconnect");
	param_01 func_51B5();
}

//Function Number: 159
monitordisownedgrenade(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("death");
	param_01 endon("mine_planted");
	param_00 scripts\common\utility::waittill_any_3("joined_team","joined_spectators","disconnect");
	if(isdefined(param_01))
	{
		param_01 delete();
	}
}

//Function Number: 160
func_9EE5(param_00)
{
	return isdefined(level.var_B779[param_00 getentitynumber()]) || scripts\mp\_utility::func_9FB3(param_00.planted);
}

//Function Number: 161
func_7F9A(param_00)
{
	var_01 = 0;
	var_02 = scripts\mp\_powers::func_808C("primary");
	if(isdefined(var_02))
	{
		var_01 = var_01 + scripts\mp\_powers::func_D736(var_02);
		if(scripts\mp\_utility::_hasperk("specialty_rugged_eqp"))
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 162
func_7FA3(param_00)
{
	var_01 = 0;
	var_02 = scripts\mp\_powers::func_808C("secondary");
	if(isdefined(var_02))
	{
		var_01 = var_01 + scripts\mp\_powers::func_D736(var_02);
		if(scripts\mp\_utility::_hasperk("specialty_rugged_eqp"))
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 163
func_C54E(param_00,param_01,param_02)
{
	param_00.var_D77A = param_01;
	param_00.var_51B6 = param_02;
	param_00.planted = 1;
	if(self.var_CC4C.size)
	{
		self.var_CC4C = scripts\common\utility::func_22BC(self.var_CC4C);
		if(self.var_CC4C.size && self.var_CC4C.size >= func_7F9A(self))
		{
			self.var_CC4C[0] func_51B5();
		}
	}

	self.var_CC4C[self.var_CC4C.size] = param_00;
	var_03 = param_00 getentitynumber();
	level.var_B779[var_03] = param_00;
	level notify("mine_planted");
}

//Function Number: 164
func_C5AC(param_00,param_01,param_02)
{
	param_00.var_D77A = param_01;
	param_00.var_51B6 = param_02;
	param_00.planted = 1;
	if(self.var_CC4D.size)
	{
		self.var_CC4D = scripts\common\utility::func_22BC(self.var_CC4D);
		if(self.var_CC4D.size && self.var_CC4D.size >= func_7FA3(self))
		{
			self.var_CC4D[0] func_51B5();
		}
	}

	self.var_CC4D[self.var_CC4D.size] = param_00;
	var_03 = param_00 getentitynumber();
	level.var_B779[var_03] = param_00;
	level notify("mine_planted");
}

//Function Number: 165
func_5608()
{
	if(isdefined(self.var_CC4C) && self.var_CC4C.size > 0)
	{
		foreach(var_01 in self.var_CC4C)
		{
			if(isdefined(var_01.trigger) && isdefined(var_01.var_222))
			{
				var_01.trigger disableplayeruse(var_01.var_222);
			}
		}
	}

	if(isdefined(self.var_CC4D) && self.var_CC4D.size > 0)
	{
		foreach(var_01 in self.var_CC4D)
		{
			if(isdefined(var_01.trigger) && isdefined(var_01.var_222))
			{
				var_01.trigger disableplayeruse(var_01.var_222);
			}
		}
	}
}

//Function Number: 166
func_40F4(param_00,param_01,param_02,param_03)
{
	if(getdvarint("showArchetypes",0) > 0)
	{
		if(isdefined(self.var_13C2E))
		{
			if(self.var_13C2E == "c4_mp")
			{
				self.var_222 notify("c4_update",0);
			}
			else if(self.var_13C2E == "bouncingbetty_mp")
			{
				self.var_222 notify("bouncing_betty_update",0);
			}
			else if(self.var_13C2E == "trip_mine_mp")
			{
				self.var_222 notify("trip_mine_update",0);
			}
			else if(self.var_13C2E == "cryo_mine_mp")
			{
				self.var_222 notify("cryo_mine_update",0);
			}
			else if(self.var_13C2E == "fear_grenade_mp")
			{
				self.var_222 notify("restart_fear_grenade_cooldown",0);
			}
			else if(self.var_13C2E == "trophy_mp")
			{
				self.var_222 notify("trophy_update",0);
			}
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

//Function Number: 167
func_51B5()
{
	if(!isdefined(self))
	{
		return;
	}

	scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool,self.sentientpoolindex);
	var_00 = self getentitynumber();
	level.var_B779[var_00] = undefined;
	if(isdefined(self.var_51B6))
	{
		self thread [[ self.var_51B6 ]]();
		self notify("deleted_equipment");
		return;
	}

	var_01 = self.var_A63A;
	var_02 = self.trigger;
	var_03 = self.var_F232;
	func_40F4(var_00,var_01,var_02,var_03);
	self notify("deleted_equipment");
	self delete();
}

//Function Number: 168
func_C4F4()
{
	self endon("death");
	level endon("game_ended");
	thread func_40F5();
	self waittill("detonateExplosive");
	self method_8099(self.var_222);
}

//Function Number: 169
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

//Function Number: 170
func_B2A5(param_00)
{
	self method_831F(self.var_222);
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	var_01 = spawn("script_origin",self.origin + param_00 * anglestoup(self.angles));
	var_01 linkto(self);
	self.trigger = var_01;
	var_01.var_222 = self;
	thread func_B2A6();
	return var_01;
}

//Function Number: 171
func_B2A6()
{
	self endon("makeExplosiveUnusable");
	var_00 = self.trigger;
	func_13A23();
	if(isdefined(self))
	{
		var_00 = self.trigger;
		self.trigger = undefined;
	}

	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 172
func_B2A3()
{
	self notify("makeExplosiveUnusable");
	var_00 = self.trigger;
	self.trigger = undefined;
	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 173
func_13A23()
{
	var_00 = self.var_222;
	var_01 = self.trigger;
	self endon("death");
	var_01 endon("death");
	var_00 endon("disconnect");
	level endon("game_ended");
	var_01 setcursorhint("HINT_NOICON");
	var_01 scripts\mp\_utility::func_F838(var_00);
	var_01 childthread scripts\mp\_utility::notusableforjoiningplayers(var_00);
	switch(self.var_13C2E)
	{
		case "c4_mp":
			var_01 sethintstring(&"MP_PICKUP_C4");
			break;

		case "cryo_mine_mp":
			var_01 sethintstring(&"MP_PICKUP_CRYO_MINE");
			break;

		case "trip_mine_mp":
			var_01 sethintstring(&"MP_PICKUP_TRIP_MINE");
			break;

		case "trophy_mp":
			var_01 sethintstring(&"MP_PICKUP_TROPHY");
			break;
	}

	for(;;)
	{
		var_01 waittillmatch(var_00,"trigger");
		if(isdefined(self.var_13C2E))
		{
			switch(self.var_13C2E)
			{
				case "trophy_mp":
					thread scripts\mp\_trophy_system::func_12818();
					break;
			}

			var_00 thread lib_0DDD::c4_resetaltdetonpickup();
		}

		var_00 playlocalsound("scavenger_pack_pickup");
		var_00 notify("scavenged_ammo",self.var_13C2E);
		thread func_51B5();
	}
}

//Function Number: 174
func_B2A7(param_00,param_01)
{
	self endon("death");
	self endon("makeExplosiveUnusable");
	var_02 = self.var_222;
	var_03 = self.var_13C2E;
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01)
	{
		self method_858A(1);
	}
	else
	{
		self setcursorhint("HINT_NOICON");
	}

	self method_84A7(param_00);
	switch(var_03)
	{
		case "c4_mp":
			self sethintstring(&"MP_PICKUP_C4");
			break;

		case "cryo_mine_mp":
			self sethintstring(&"MP_PICKUP_CRYO_MINE");
			break;

		case "trip_mine_mp":
			self sethintstring(&"MP_PICKUP_TRIP_MINE");
			break;

		case "trophy_mp":
			self sethintstring(&"MP_PICKUP_TROPHY");
			break;
	}

	scripts\mp\_utility::func_F838(var_02);
	childthread scripts\mp\_utility::notusableforjoiningplayers(var_02);
	for(;;)
	{
		self waittillmatch(var_02,"trigger");
		if(isdefined(var_03))
		{
			switch(var_03)
			{
				case "trophy_mp":
					thread scripts\mp\_trophy_system::func_12818();
					break;
			}

			var_02 thread lib_0DDD::c4_resetaltdetonpickup();
		}

		var_02 playlocalsound("scavenger_pack_pickup");
		var_02 notify("scavenged_ammo",var_03);
		thread func_51B5();
	}
}

//Function Number: 175
func_B2A4()
{
	self notify("makeExplosiveUnusable");
	self makeunusable();
}

//Function Number: 176
func_69FF(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_AD39 = param_00;
	var_02.var_4E53 = ::func_BD4F;
	var_02.var_6371 = "death";
	if(!isdefined(param_01) || !param_01)
	{
		var_02.var_9B11 = ::scripts\mp\_movers::func_BD3C;
	}

	thread scripts\mp\_movers::func_892F(var_02);
}

//Function Number: 177
func_6A08(param_00,param_01,param_02)
{
	if(isplayer(param_00) && param_00 scripts\mp\_utility::_hasperk("specialty_delaymine"))
	{
		param_00 thread scripts\mp\_missions::func_127BC();
		param_00 notify("triggeredExpl",param_02);
		param_01 = level.var_5113;
	}

	wait(param_01);
}

//Function Number: 178
func_FA95()
{
	self.var_2C67 = [];
	if(self.var_53AD && !self.var_2C66.size)
	{
		for(var_00 = 0;var_00 < 4;var_00++)
		{
			self.var_2C66[var_00] = newclienthudelem(self);
			self.var_2C66[var_00].x = 0;
			self.var_2C66[var_00].y = 0;
			self.var_2C66[var_00].var_3A6 = 0;
			self.var_2C66[var_00].alpha = 0;
			self.var_2C66[var_00].archived = 1;
			self.var_2C66[var_00] setshader("waypoint_bombsquad",14,14);
			self.var_2C66[var_00] setwaypoint(0,0);
			self.var_2C66[var_00].var_53B1 = "";
		}

		return;
	}

	if(!self.var_53AD)
	{
		for(var_00 = 0;var_00 < self.var_2C66.size;var_00++)
		{
			self.var_2C66[var_00] destroy();
		}

		self.var_2C66 = [];
	}
}

//Function Number: 179
func_1012C(param_00)
{
	var_01 = param_00.var_53B1;
	var_02 = -1;
	for(var_03 = 0;var_03 < 4;var_03++)
	{
		var_04 = self.var_2C66[var_03].var_53B1;
		if(var_04 == var_01)
		{
			return;
		}

		if(var_04 == "")
		{
			var_02 = var_03;
		}
	}

	if(var_02 < 0)
	{
		return;
	}

	self.var_2C67[var_01] = 1;
	self.var_2C66[var_02].x = param_00.origin[0];
	self.var_2C66[var_02].y = param_00.origin[1];
	self.var_2C66[var_02].var_3A6 = param_00.origin[2] + 24 + 128;
	self.var_2C66[var_02] fadeovertime(0.25);
	self.var_2C66[var_02].alpha = 1;
	self.var_2C66[var_02].var_53B1 = param_00.var_53B1;
	while(isalive(self) && isdefined(param_00) && self istouching(param_00))
	{
		wait(0.05);
	}

	if(!isdefined(self))
	{
		return;
	}

	self.var_2C66[var_02].var_53B1 = "";
	self.var_2C66[var_02] fadeovertime(0.25);
	self.var_2C66[var_02].alpha = 0;
	self.var_2C67[var_01] = undefined;
}

//Function Number: 180
func_7E58(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_05 = param_01 * param_01;
	var_06 = level.players;
	for(var_07 = 0;var_07 < var_06.size;var_07++)
	{
		if(!isalive(var_06[var_07]) || var_06[var_07].sessionstate != "playing")
		{
			continue;
		}

		var_08 = scripts\mp\_utility::func_7921(var_06[var_07]);
		var_09 = distancesquared(param_00,var_08);
		if(var_09 < var_05 && !param_02 || func_13C7E(param_00,var_08,param_03,var_06[var_07]))
		{
			var_04[var_04.size] = scripts\mp\_utility::func_7920(var_06[var_07],var_08);
		}
	}

	var_0A = getentarray("grenade","classname");
	for(var_07 = 0;var_07 < var_0A.size;var_07++)
	{
		var_0B = scripts\mp\_utility::func_791E(var_0A[var_07]);
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || func_13C7E(param_00,var_0B,param_03,var_0A[var_07]))
		{
			var_04[var_04.size] = scripts\mp\_utility::func_791D(var_0A[var_07],var_0B);
		}
	}

	var_0C = getentarray("destructible","targetname");
	for(var_07 = 0;var_07 < var_0C.size;var_07++)
	{
		var_0B = var_0C[var_07].origin;
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || func_13C7E(param_00,var_0B,param_03,var_0C[var_07]))
		{
			var_0D = spawnstruct();
			var_0D.var_9EE7 = 0;
			var_0D.var_9D26 = 0;
			var_0D.var_114 = var_0C[var_07];
			var_0D.var_4D2F = var_0B;
			var_04[var_04.size] = var_0D;
		}
	}

	var_0E = getentarray("destructable","targetname");
	for(var_07 = 0;var_07 < var_0E.size;var_07++)
	{
		var_0B = var_0E[var_07].origin;
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || func_13C7E(param_00,var_0B,param_03,var_0E[var_07]))
		{
			var_0D = spawnstruct();
			var_0D.var_9EE7 = 0;
			var_0D.var_9D26 = 1;
			var_0D.var_114 = var_0E[var_07];
			var_0D.var_4D2F = var_0B;
			var_04[var_04.size] = var_0D;
		}
	}

	var_0F = getentarray("misc_turret","classname");
	foreach(var_11 in var_0F)
	{
		var_0B = var_11.origin + (0,0,32);
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || func_13C7E(param_00,var_0B,param_03,var_11))
		{
			switch(var_11.model)
			{
				case "vehicle_ugv_talon_gun_mp":
				case "mp_remote_turret":
				case "mp_scramble_turret":
				case "mp_sam_turret":
				case "sentry_minigun_weak":
					var_04[var_04.size] = scripts\mp\_utility::func_7922(var_11,var_0B);
					break;
			}
		}
	}

	var_13 = getentarray("script_model","classname");
	foreach(var_15 in var_13)
	{
		if(var_15.model != "projectile_bouncing_betty_grenade" && var_15.model != "ims_scorpion_body")
		{
			continue;
		}

		var_0B = var_15.origin + (0,0,32);
		var_09 = distancesquared(param_00,var_0B);
		if(var_09 < var_05 && !param_02 || func_13C7E(param_00,var_0B,param_03,var_15))
		{
			var_04[var_04.size] = scripts\mp\_utility::func_791F(var_15,var_0B);
		}
	}

	return var_04;
}

//Function Number: 181
func_7E8C(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_05 = param_01 * param_01;
	level.var_B779 = scripts\common\utility::func_22BC(level.var_B779);
	foreach(var_07 in level.var_B779)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	var_09 = getentarray("misc_turret","classname");
	foreach(var_07 in var_09)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.var_12F81)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.var_DF74)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.var_27EF)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.var_CC11)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.var_B726)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.var_105EA)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.var_69D6)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.spidergrenade.activeagents)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.spidergrenade.proxies)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.var_2ABD)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.var_590F)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.var_AD8B)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.var_D3CC)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03))
		{
			var_04[var_04.size] = var_07;
		}
	}

	foreach(var_07 in level.players)
	{
		if(func_619A(var_07,param_00,var_05,param_02,param_03) && scripts\mp\_utility::func_9EF0(var_07))
		{
			var_04[var_04.size] = var_07;
		}
	}

	return var_04;
}

//Function Number: 182
func_619A(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00.origin;
	var_06 = distancesquared(param_01,var_05);
	return var_06 < param_02 && !param_03 || func_13C7E(param_01,var_05,param_04,param_00);
}

//Function Number: 183
func_13C7E(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_05 = param_01 - param_00;
	if(lengthsquared(var_05) < param_02 * param_02)
	{
		return 1;
	}

	var_06 = vectornormalize(var_05);
	var_04 = param_00 + (var_06[0] * param_02,var_06[1] * param_02,var_06[2] * param_02);
	var_07 = bullettrace(var_04,param_01,0,param_03);
	if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0)
	{
		thread func_4F51(param_00,".dmg");
		if(isdefined(param_03))
		{
			thread func_4F51(param_01,"." + param_03.classname);
		}
		else
		{
			thread func_4F51(param_01,".undefined");
		}

		if(var_07["fraction"] == 1)
		{
			thread func_4F48(var_04,param_01,(1,1,1));
		}
		else
		{
			thread func_4F48(var_04,var_07["position"],(1,0.9,0.8));
			thread func_4F48(var_07["position"],param_01,(1,0.4,0.3));
		}
	}

	return var_07["fraction"] == 1;
}

//Function Number: 184
func_66B4(param_00)
{
	self endon("death");
	self waittill("emp_damage",var_01,var_02,var_03,var_04,var_05);
	if(isdefined(var_04) && var_04 == "emp_grenade_mp")
	{
		if(scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(self.var_222,var_01)))
		{
			var_01 scripts\mp\_missions::func_D991("ch_tactical_emp_eqp");
		}
	}

	func_66A9();
	if(isdefined(self.var_222) && isdefined(var_01) && self.var_222 != var_01)
	{
		var_01 scripts\mp\killstreaks\_killstreaks::func_83A0();
	}

	if(isdefined(param_00) && param_00)
	{
		func_51B5();
		return;
	}

	self notify("detonateExplosive");
}

//Function Number: 185
func_4D47(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(self.var_9EE7)
	{
		self.var_4D5B = param_05;
		self.var_114 thread [[ level.callbackplayerdamage ]](param_00,param_01,param_02,0,param_03,param_04,param_05,param_06,"none",0);
		return;
	}

	if(self.var_9D26 && param_04 == "artillery_mp" || param_04 == "claymore_mp" || param_04 == "stealth_bomb_mp")
	{
		return;
	}

	self.var_114 notify("damage",param_02,param_01,(0,0,0),(0,0,0),"MOD_EXPLOSIVE","","","",undefined,param_04);
}

//Function Number: 186
func_4F48(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < 600;var_03++)
	{
		wait(0.05);
	}
}

//Function Number: 187
func_4F3A(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 16;
	}

	var_04 = 360 / param_03;
	var_05 = [];
	for(var_06 = 0;var_06 < param_03;var_06++)
	{
		var_07 = var_04 * var_06;
		var_08 = cos(var_07) * param_01;
		var_09 = sin(var_07) * param_01;
		var_0A = param_00[0] + var_08;
		var_0B = param_00[1] + var_09;
		var_0C = param_00[2];
		var_05[var_05.size] = (var_0A,var_0B,var_0C);
	}

	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_0D = var_05[var_06];
		if(var_06 + 1 >= var_05.size)
		{
			var_0E = var_05[0];
		}
		else
		{
			var_0E = var_05[var_06 + 1];
		}

		thread func_4F48(var_0D,var_0E,param_02);
	}
}

//Function Number: 188
func_4F51(param_00,param_01)
{
	for(var_02 = 0;var_02 < 600;var_02++)
	{
		wait(0.05);
	}
}

//Function Number: 189
func_C5CB(param_00,param_01,param_02,param_03,param_04)
{
	self endon("death");
	self endon("disconnect");
	if(!scripts\mp\_utility::func_9F19(self))
	{
		return;
	}

	if(isdefined(param_01) && param_01 != "none")
	{
		param_01 = getweaponbasename(param_01);
	}

	switch(param_01)
	{
		case "cluster_grenade_mp":
			if(isdefined(param_00) && scripts\mp\_utility::func_9FB3(param_00.var_FC6A))
			{
				scripts\mp\_shellshock::func_FC6A(param_02,param_03);
			}
			break;

		case "concussion_grenade_mp":
			if(param_03 > 0)
			{
				thread scripts\mp\_concussiongrenade::func_C5CB(param_00,param_01,param_02,param_03,param_04);
			}
			break;

		case "blackout_grenade_mp":
			if(param_03 > 0)
			{
				if(param_02 != "MOD_IMPACT")
				{
					lib_0DDB::func_10D6F(param_00.var_222,param_00.origin);
				}
			}
			break;

		case "gltacburst_regen":
		case "venomproj_mp":
		case "cryo_mine_mp":
			if(param_03 > 0)
			{
				if(param_02 != "MOD_IMPACT")
				{
					if(isdefined(param_00))
					{
						if(isdefined(param_00.var_110E8))
						{
							if(scripts\mp\killstreaks\_utility::func_A69F(param_00.var_110E8,"passive_increased_frost"))
							{
								lib_0DE3::func_4ACF(param_04,3);
							}
							else
							{
								lib_0DE3::func_4ACF(param_04);
							}
						}
						else
						{
							lib_0DE3::func_4ACF(param_04);
						}
					}
				}
			}
			break;

		case "weapon_cobra_mk19_mp":
			break;

		case "iw7_glprox_mp":
			break;

		case "shard_ball_mp":
			break;

		case "splash_grenade_mp":
			break;

		case "pulse_grenade_mp":
			lib_0DFC::func_DAF4();
			break;

		case "minijackal_strike_mp":
			break;

		case "groundpound_mp":
			lib_0DE9::groundpound_victimimpacteffects(param_04,self,param_01,param_00);
			break;

		case "gltacburst_big":
		case "gltacburst":
			if(param_03 > 0)
			{
				thread scripts\mp\_empgrenade::func_C5CB(param_00,param_01,param_02,param_03,param_04);
			}
			break;

		default:
			scripts\mp\_shellshock::func_FC6A(param_02,param_03);
			break;
	}
}

//Function Number: 190
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
		case "mg":
		case "rifle":
		case "spread":
		case "rocketlauncher":
		case "sniper":
		case "smg":
		case "pistol":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 191
func_9D75(param_00)
{
	if(param_00 == "none" || func_9F2D(param_00) || func_9E6D(param_00))
	{
		return 0;
	}

	switch(weaponclass(param_00))
	{
		case "mg":
		case "rifle":
		case "spread":
		case "sniper":
		case "smg":
		case "pistol":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 192
func_9E6D(param_00)
{
	return scripts\mp\_utility::func_8234(param_00) == "iw7_knife";
}

//Function Number: 193
isballweapon(param_00)
{
	return scripts\mp\_utility::func_8234(param_00) == "iw7_uplinkball" || scripts\mp\_utility::func_8234(param_00) == "iw7_tdefball";
}

//Function Number: 194
isaxeweapon(param_00)
{
	return scripts\mp\_utility::func_8234(param_00) == "iw7_axe";
}

//Function Number: 195
func_9D3E(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return function_0244(param_00) == "altmode";
}

//Function Number: 196
func_9E56(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return function_0244(param_00) == "item";
}

//Function Number: 197
func_9F5D(param_00)
{
	return isdefined(param_00) && scripts\mp\_utility::func_8234(param_00) == "iw7_emc";
}

//Function Number: 198
func_9F2D(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return function_024C(param_00) == "riotshield";
}

//Function Number: 199
func_9EC0(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return function_0244(param_00) == "offhand";
}

//Function Number: 200
func_9F54(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	if(function_0244(param_00) != "primary")
	{
		return 0;
	}

	return weaponclass(param_00) == "pistol";
}

//Function Number: 201
func_9E18(param_00)
{
	var_01 = weaponclass(param_00);
	if(var_01 != "grenade")
	{
		return 0;
	}

	var_02 = function_0244(param_00);
	if(var_02 != "offhand")
	{
		return 0;
	}

	return 1;
}

//Function Number: 202
func_9FA9(param_00)
{
	if(param_00 == "none")
	{
		return 0;
	}

	return issubstr(param_00,"throwingknife");
}

//Function Number: 203
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
	self.var_EB6C = var_00;
	for(;;)
	{
		self waittill("weapon_change",var_01);
		self.var_EB6C = var_01;
		if(var_01 == "none")
		{
			continue;
		}
		else if(scripts\mp\_utility::func_9F8D(var_01))
		{
			func_12ED5();
			continue;
		}
		else if(scripts\mp\_utility::func_9E6C(var_01))
		{
			continue;
		}
		else
		{
			var_02 = function_0244(var_01);
			if(var_02 != "primary" && var_02 != "altmode")
			{
				continue;
			}
		}

		func_12ED5();
		self.var_EB6B = var_00;
		var_00 = var_01;
	}
}

//Function Number: 204
func_61AD(param_00)
{
	self endon("disconnect");
	self endon("death");
	thread func_41AB();
}

//Function Number: 205
func_41AB()
{
	self endon("disconnect");
	self waittill("death");
}

//Function Number: 206
func_8237()
{
	var_00 = 2;
	self.var_13CA0 = self getweaponslistprimaries();
	if(self.var_13CA0.size)
	{
		foreach(var_02 in self.var_13CA0)
		{
			if(scripts\mp\_utility::func_9F8D(var_02))
			{
				var_03 = scripts\mp\_supers::func_7FD0(var_02);
			}
			else if(scripts\mp\_utility::func_9E0D(var_02))
			{
				var_03 = func_7ECD(var_02);
			}
			else
			{
				var_03 = func_8236(var_02);
			}

			if(!isdefined(var_03) || var_03 == 0)
			{
				continue;
			}

			if(var_03 < var_00)
			{
				var_00 = var_03;
			}
		}
	}
	else
	{
		var_00 = 0.94;
	}

	var_00 = func_4001(var_00);
	return var_00;
}

//Function Number: 207
func_8236(param_00)
{
	var_01 = scripts\mp\_utility::func_8234(param_00);
	return level.var_13CA5[var_01].var_2B3;
}

//Function Number: 208
func_7ECD(param_00)
{
	return 1;
}

//Function Number: 209
func_4001(param_00)
{
	return clamp(param_00,0,1);
}

//Function Number: 210
func_12F58(param_00)
{
	if(isdefined(param_00))
	{
		self.var_1339E = param_00;
	}

	if(isdefined(self.var_C7E8))
	{
		param_00 = self.var_C7E8;
	}
	else if(scripts\mp\_utility::_hasperk("specialty_distance_kit"))
	{
		param_00 = 0.05;
	}
	else if(isdefined(self.var_C826))
	{
		if((weaponclass(self getcurrentweapon()) == "sniper" || issubstr(self getcurrentweapon(),"iw7_udm45_mpl") || issubstr(self getcurrentweapon(),"iw7_longshot_mp")) && isdefined(self.overrideviewkickscalesniper))
		{
			param_00 = self.overrideviewkickscalesniper;
		}
		else
		{
			param_00 = self.var_C826;
		}
	}
	else if(isdefined(self.var_1339E))
	{
		param_00 = self.var_1339E;
	}
	else
	{
		param_00 = 1;
	}

	param_00 = clamp(param_00,0,1);
	self setviewkickscale(param_00);
}

//Function Number: 211
func_12ED5()
{
	var_00 = undefined;
	if(isdefined(self.var_D42F))
	{
		var_00 = 1;
		var_00 = var_00 + self.var_D42F;
	}
	else
	{
		var_00 = func_807F(self);
		if(isdefined(self.var_C829))
		{
			var_00 = self.var_C829;
		}

		var_01 = self.var_3E6B;
		if(isdefined(var_01) && isdefined(var_01.var_109AE))
		{
			var_00 = var_00 + var_01.var_109AE;
		}

		if(isdefined(self.var_13CB2))
		{
			var_00 = var_00 + self.var_13CB2;
		}

		if(isdefined(self.var_13CB3))
		{
			var_00 = var_00 + self.var_13CB3;
		}

		var_00 = var_00 + scripts\mp\perks\_weaponpassives::passivecolddamagegetspeedmod(self);
		if(isdefined(self.weaponpassivefastrechamberspeedmod))
		{
			var_00 = var_00 + self.weaponpassivefastrechamberspeedmod;
		}

		if(isdefined(self.speedonkillmod))
		{
			var_00 = var_00 + self.speedonkillmod;
		}
	}

	self.var_13CCF = var_00;
	if(!isdefined(self.var_440B))
	{
		self.var_440B = 1;
	}

	var_00 = var_00 + self.var_BCF6 - 1;
	var_00 = var_00 + self.var_440B - 1;
	var_00 = clamp(var_00,0,1.08);
	if(isdefined(self.fastcrouchspeedmod))
	{
		var_00 = var_00 + self.fastcrouchspeedmod;
	}

	self setmovespeedscale(var_00);
}

//Function Number: 212
func_807F(param_00)
{
	var_01 = 1;
	self.var_13CA0 = self getweaponslistprimaries();
	if(!self.var_13CA0.size)
	{
		var_01 = 0.94;
	}
	else
	{
		var_02 = self getcurrentweapon();
		if(scripts\mp\_utility::func_9F8D(var_02))
		{
			var_01 = scripts\mp\_supers::func_7FD0(var_02);
		}
		else if(scripts\mp\_utility::func_9E0D(var_02))
		{
			var_01 = func_7ECD(var_02);
		}
		else if(scripts\mp\_utility::func_9E6C(var_02))
		{
			var_01 = 0.94;
		}
		else if(issubstr(var_02,"iw7_mauler_mpl_damage"))
		{
			var_01 = 0.87;
		}
		else if(issubstr(var_02,"iw7_udm45_mpl"))
		{
			var_01 = 0.95;
		}
		else if(issubstr(var_02,"iw7_rvn") && self method_8519(var_02))
		{
			var_01 = 1;
		}
		else if(issubstr(var_02,"iw7_longshot") && self method_8519(var_02))
		{
			var_01 = 0.98;
		}
		else
		{
			var_03 = function_0244(var_02);
			if(var_03 != "primary" && var_03 != "altmode")
			{
				if(isdefined(self.var_EB6B))
				{
					var_02 = self.var_EB6B;
				}
				else
				{
					var_02 = undefined;
				}
			}

			if(!isdefined(var_02) || !self hasweapon(var_02))
			{
				var_01 = func_8237();
			}
			else
			{
				var_01 = func_8236(var_02);
			}
		}
	}

	var_01 = func_4001(var_01);
	return var_01;
}

//Function Number: 213
func_10B5E()
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
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

//Function Number: 214
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
		var_03 = scripts\mp\_utility::func_8225(var_01);
		if(var_03 == "weapon_lmg")
		{
			scripts\mp\_utility::setrecoilscale(0,0);
			return;
		}

		if(var_03 == "weapon_sniper")
		{
			if(issubstr(var_01,"barrelbored"))
			{
				scripts\mp\_utility::setrecoilscale(0,0 + var_02);
				return;
			}

			scripts\mp\_utility::setrecoilscale(0,0 + var_02);
			return;
		}

		scripts\mp\_utility::setrecoilscale();
		return;
	}

	if(param_00 == "crouch")
	{
		var_03 = scripts\mp\_utility::func_8225(var_01);
		if(var_03 == "weapon_lmg")
		{
			scripts\mp\_utility::setrecoilscale(0,0);
			return;
		}

		if(var_03 == "weapon_sniper")
		{
			if(issubstr(var_01,"barrelbored"))
			{
				scripts\mp\_utility::setrecoilscale(0,0 + var_02);
				return;
			}

			scripts\mp\_utility::setrecoilscale(0,0 + var_02);
			return;
		}

		scripts\mp\_utility::setrecoilscale();
		return;
	}

	if(var_02 > 0)
	{
		scripts\mp\_utility::setrecoilscale(0,var_02);
		return;
	}

	scripts\mp\_utility::setrecoilscale();
}

//Function Number: 215
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

	param_00.var_C731 = self;
	param_00 waittill("missile_stuck",var_01);
	param_00 thread scripts\mp\_shellshock::func_858A();
	if(isplayer(var_01) || isagent(var_01))
	{
		func_85DD(param_00,var_01);
	}

	param_00 func_69FF(undefined);
}

//Function Number: 216
func_12A13()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		thread func_12A1F(var_00);
	}
}

//Function Number: 217
func_12A1F(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 notify("weapon_change","none");
	self waittill("turret_deactivate");
	param_00 notify("weapon_change",param_00 getcurrentweapon());
}

//Function Number: 218
func_108E3(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = (0,randomfloat(360),0);
	}

	var_05 = level.var_13C7D[param_02];
	var_06 = spawn("script_model",param_00);
	var_06.angles = param_04;
	var_06 setmodel(var_05.model);
	var_06.var_222 = param_01;
	var_06 method_831F(param_01);
	var_06.var_13C2E = param_02;
	var_06.var_451C = var_05;
	var_06.var_A640 = (0,0,4);
	var_06.var_A63A = spawn("script_model",var_06.origin + var_06.var_A640);
	var_06.var_A63A setscriptmoverkillcam("explosive");
	var_07 = scripts\mp\_utility::func_7E9D(param_02);
	if(!isdefined(var_07))
	{
		var_07 = "lethal";
	}

	if(var_07 == "lethal")
	{
		param_01 func_C54E(var_06,param_03);
	}
	else if(var_07 == "tactical")
	{
		param_01 func_C5AC(var_06,param_03);
	}
	else
	{
	}

	if(isdefined(var_05.var_2C68))
	{
		var_06 thread func_4988(var_05.var_2C68,"tag_origin",param_01);
	}

	if(isdefined(var_05.var_B760))
	{
		var_06 thread func_57EB("tag_fx",var_05.var_B760["friendly"],var_05.var_B760["enemy"]);
	}

	var_06 thread func_F692(param_01.pers["team"],var_05.var_8C7A);
	var_08 = undefined;
	if(self != level)
	{
		var_08 = self getlinkedparent();
	}

	var_06 func_69FF(var_08);
	var_06 thread func_B778(var_08);
	var_06 thread scripts\mp\_shellshock::func_858A();
	var_06 thread func_B77A();
	var_06 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static",param_01,1);
	var_06 thread func_B770();
	var_06 thread func_66B4(1);
	var_06 thread scripts\mp\perks\_perk_equipmentping::func_E84B();
	thread func_C798(var_06,param_01);
	level thread func_B9CA(param_01,var_06);
	return var_06;
}

//Function Number: 219
func_108E7(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = (0,randomfloat(360),0);
	}

	var_05 = level.var_13C7D[param_02];
	var_06 = spawn("script_model",param_00);
	var_06.angles = param_04;
	var_06 setmodel(var_05.model);
	var_06.var_222 = param_01;
	var_06 method_831F(param_01);
	var_06.var_13C2E = param_02;
	var_06.var_451C = var_05;
	param_01 func_C5AC(var_06,param_03);
	var_06 thread func_4988(var_05.var_2C68,"tag_origin",param_01);
	var_06 thread func_F692(param_01.pers["team"],var_05.var_8C7A);
	var_07 = undefined;
	if(self != level)
	{
		var_07 = self getlinkedparent();
	}

	var_06 func_69FF(var_07,1);
	var_06 thread func_B778(var_07);
	var_06 thread scripts\mp\_shellshock::func_858A();
	var_06 thread func_BBC4();
	var_06 scripts\mp\sentientpoolmanager::registersentient("Lethal_Static",param_01);
	var_06 thread func_B77D();
	level thread func_B9CA(param_01,var_06);
	return var_06;
}

//Function Number: 220
func_108E5(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_04))
	{
		param_04 = (0,randomfloat(360),0);
	}

	var_07 = level.var_13C7D[param_02];
	var_08 = spawn("script_model",param_00);
	var_08.angles = param_04;
	var_08 setmodel(var_07.model);
	var_08.var_222 = param_01;
	var_08 method_831F(param_01);
	var_08.var_13C2E = param_02;
	var_08.var_451C = var_07;
	if(isdefined(param_05))
	{
		var_08.var_AC75 = param_05;
	}
	else
	{
		var_08.var_AC75 = 45;
	}

	param_01 func_C5AC(var_08,param_03);
	var_08 thread func_4988(var_07.var_2C68,"tag_origin",param_01);
	var_08 thread func_F692(param_01.pers["team"],var_07.var_8C7A);
	var_09 = undefined;
	if(self != level)
	{
		var_09 = self getlinkedparent();
	}

	var_08 func_69FF(var_09,1);
	var_08 thread func_B778(var_09);
	var_08 thread scripts\mp\_shellshock::func_858A();
	var_08 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static",param_01);
	var_08 thread func_B8F6();
	level thread func_B9CA(param_01,var_08);
	var_08 thread func_D501();
	var_08 thread func_139F0();
	if(isdefined(param_06) && param_06)
	{
		var_08 func_B2A5();
		var_08 thread func_B76A();
	}

	return var_08;
}

//Function Number: 221
func_139F5()
{
	var_00 = self.var_222;
	var_00 endon("disconnect");
	self waittill("missile_stuck");
	thread func_E845(var_00,self.origin);
}

//Function Number: 222
func_E845(param_00,param_01)
{
	var_02 = spawn("trigger_radius",param_01,0,128,135);
	var_02.var_222 = param_00;
	var_03 = 128;
	var_04 = spawnfx(scripts\common\utility::getfx("distortion_field_cloud"),param_01);
	triggerfx(var_04);
	var_05 = 8;
	foreach(var_07 in level.players)
	{
		var_07.var_9E44 = 0;
		var_07 thread func_20C2(var_02);
	}

	while(var_05 > 0)
	{
		foreach(var_07 in level.players)
		{
			if(var_07 istouching(var_02) && !var_07.var_9E44)
			{
				var_07 thread func_20C2(var_02);
			}
		}

		wait(0.2);
		var_05 = var_05 - 0.2;
	}

	foreach(var_07 in level.players)
	{
		var_07 notify("distortion_field_ended");
		foreach(var_0E in level.players)
		{
			var_07 showtoplayer(var_0E);
		}
	}

	var_04 delete();
	self delete();
	wait(2);
	var_02 delete();
}

//Function Number: 223
func_20C2(param_00)
{
	self endon("death");
	self endon("disconnect");
	while(isdefined(param_00) && self istouching(param_00) && !scripts\mp\killstreaks\_emp_common::isemped())
	{
		self setblurforplayer(4,1);
		self.var_9E44 = 1;
		thread func_B9CF();
		foreach(var_02 in level.players)
		{
			self method_8429(var_02);
		}

		scripts\common\utility::waittill_any_timeout_1(1.4,"emp_damage");
		foreach(var_02 in level.players)
		{
			self showtoplayer(var_02);
		}

		wait(0.1);
	}

	self setblurforplayer(0,0.25);
	self.var_9E44 = 0;
	foreach(var_02 in level.players)
	{
		var_02 showtoplayer(var_02);
	}
}

//Function Number: 224
func_B9CF()
{
	self endon("distortion_field_ended");
	var_00 = 0;
	while(!var_00)
	{
		var_00 = scripts\mp\killstreaks\_emp_common::isemped();
		scripts\common\utility::func_136F7();
	}

	self notify("emp_damage");
}

//Function Number: 225
func_10910(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = (0,randomfloat(360),0);
	}

	var_05 = level.var_13C7D[param_02];
	var_06 = spawn("script_model",param_00);
	var_06.angles = param_04;
	var_06 setmodel(var_05.model);
	var_06.var_222 = param_01;
	var_06 method_831F(param_01);
	var_06.var_13C2E = param_02;
	var_06.var_451C = var_05;
	param_01 func_C5AC(var_06,param_03);
	var_06 thread func_4988(var_05.var_2C68,"tag_origin",param_01);
	var_06 thread func_F692(param_01.pers["team"],var_05.var_8C7A);
	var_06 thread func_10413(param_01,var_06,var_06.var_13C2E);
	var_06.var_AC75 = 15;
	var_06 thread func_139F0(0);
	param_01 notify("sonic_sensor_used");
	var_07 = undefined;
	if(self != level)
	{
		var_07 = self getlinkedparent();
	}

	var_06 func_69FF(var_07,1);
	var_06 thread scripts\mp\_shellshock::func_858A();
	var_06 thread func_BBC4();
	var_06 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static",param_01);
	var_06 thread func_B77D();
	var_06 thread func_10412();
	level thread func_B9CA(param_01,var_06);
	return var_06;
}

//Function Number: 226
func_10412()
{
	scripts\common\utility::waittill_any_3("death","mine_destroyed");
	self.var_222 notify("sonic_sensor_update");
	foreach(var_01 in self.var_222.var_CC4D)
	{
		if(isdefined(var_01) && var_01.var_13C2E == "sonic_sensor_mp")
		{
			var_01 func_51B5();
			scripts\common\utility::func_22A9(self.var_222.var_CC4D,var_01);
		}
	}
}

//Function Number: 227
func_139F0(param_00)
{
	self endon("death");
	while(self.var_AC75 > 0)
	{
		self.var_AC75--;
		wait(1);
	}

	self playsound(self.var_451C.var_C525);
	var_01 = self gettagorigin("tag_origin");
	playfx(self.var_451C.var_C526,var_01);
	if(isdefined(self.var_451C.var_127BF))
	{
		self.var_451C.var_127BF.var_DBD8 = undefined;
		self.var_451C.var_127BF = undefined;
	}

	if(!isdefined(param_00) || param_00)
	{
		self method_8079();
	}

	func_51B5();
}

//Function Number: 228
func_66AA(param_00,param_01)
{
	if(isdefined(param_00))
	{
		switch(param_00)
		{
			case "cryo_mine_mp":
				return 1;
		}

		if(param_01 == "MOD_IMPACT")
		{
			switch(param_00)
			{
				case "trip_mine_mp":
				case "splash_grenade_mp":
				case "c4_mp":
					return 1;
			}
		}
		else
		{
			switch(param_00)
			{
				case "gltacburst_regen":
				case "gltacburst_big":
				case "gltacburst":
				case "blackout_grenade_mp":
				case "concussion_grenade_mp":
					return 1;
			}
		}
	}

	return 0;
}

//Function Number: 229
func_51A7()
{
	if(isdefined(level.var_85D5))
	{
		foreach(var_01 in level.var_85D5)
		{
			if(isdefined(var_01) && !scripts\mp\_utility::func_9FB3(var_01.var_69BA) && !func_9EE5(var_01))
			{
				var_01 delete();
			}
		}
	}

	if(isdefined(level.var_B898))
	{
		foreach(var_04 in level.var_B898)
		{
			if(isdefined(var_04) && !scripts\mp\_utility::func_9FB3(var_04.var_69BA) && !func_9EE5(var_04))
			{
				var_04 delete();
			}
		}
	}
}

//Function Number: 230
minegettwohitthreshold()
{
	return 80;
}

//Function Number: 231
func_B76A()
{
	self endon("mine_triggered");
	self endon("mine_selfdestruct");
	self endon("death");
	self setcandamage(1);
	self.maxhealth = 100000;
	self.health = self.maxhealth;
	var_00 = undefined;
	var_01 = self.var_222 scripts\mp\_utility::_hasperk("specialty_rugged_eqp");
	var_02 = scripts\common\utility::func_116D7(var_01,2,1);
	var_03 = scripts\common\utility::func_116D7(var_01,"hitequip","");
	for(;;)
	{
		self waittill("damage",var_04,var_00,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10);
		var_0C = scripts\mp\_utility::func_13CA1(var_0C,var_10);
		if(!isplayer(var_00) && !isagent(var_00))
		{
			continue;
		}

		if(isdefined(var_0C) && isendstr(var_0C,"betty_mp"))
		{
			continue;
		}

		if(!func_7415(self.var_222,var_00))
		{
			continue;
		}

		if(isballweapon(var_0C))
		{
			continue;
		}

		if(lib_0DF8::func_9DDF(var_00))
		{
			continue;
		}

		if(func_66AA(var_0C,var_07))
		{
			continue;
		}

		var_11 = scripts\common\utility::func_116D7(scripts\mp\_utility::func_9DFF(var_0C,var_07) || var_04 >= 80,2,1);
		var_02 = var_02 - var_11;
		scripts\mp\_powers::equipmenthit(self.var_222,var_00,var_0C,var_07);
		if(var_02 <= 0)
		{
			break;
		}
		else
		{
			var_00 scripts\mp\_damagefeedback::func_12E84(var_03);
		}
	}

	self notify("mine_destroyed");
	if(isdefined(var_07) && issubstr(var_07,"MOD_GRENADE") || issubstr(var_07,"MOD_EXPLOSIVE"))
	{
		self.var_13908 = 1;
	}

	if(isdefined(var_0B) && var_0B & level.var_92C4)
	{
		self.var_1390E = 1;
	}

	if(isdefined(var_0B) && var_0B & level.var_92C6)
	{
		self.var_1390F = 1;
	}

	self.var_1390B = 1;
	if(isdefined(var_00))
	{
		self.var_4D3F = var_00;
	}

	if(isdefined(self.var_A63A))
	{
		self.var_A63A.var_4D3F = var_00;
	}

	if(isplayer(var_00))
	{
		var_00 scripts\mp\_damagefeedback::func_12E84(var_03);
		if(var_00 != self.var_222 && var_00.team != self.var_222.team)
		{
			var_00 scripts\mp\killstreaks\_killstreaks::func_83A0();
		}
	}

	if(level.teambased)
	{
		if(isdefined(var_00) && isdefined(var_00.pers["team"]) && isdefined(self.var_222) && isdefined(self.var_222.pers["team"]))
		{
			if(var_00.pers["team"] != self.var_222.pers["team"])
			{
				var_00 notify("destroyed_equipment");
			}
		}
	}
	else if(isdefined(self.var_222) && isdefined(var_00) && var_00 != self.var_222)
	{
		var_00 notify("destroyed_equipment");
	}

	scripts\mp\_missions::minedestroyed(self,var_00,var_07);
	self notify("detonateExplosive",var_00);
}

//Function Number: 232
func_B778(param_00,param_01)
{
	self endon("mine_destroyed");
	self endon("mine_selfdestruct");
	self endon("death");
	self endon("disabled");
	var_02 = self.var_451C;
	wait(var_02.var_226E);
	if(isdefined(var_02.var_B760))
	{
		thread func_57EB("tag_fx",var_02.var_B760["friendly"],var_02.var_B760["enemy"]);
	}

	var_03 = scripts\common\utility::func_116D7(isdefined(var_02.var_B76F),var_02.var_B76F,level.var_B76F);
	var_04 = scripts\common\utility::func_116D7(isdefined(var_02.var_B76E),var_02.var_B76E,level.var_B76E);
	var_05 = spawn("trigger_radius",self.origin,0,var_03,var_04);
	var_05.var_222 = self;
	thread func_B76C(var_05);
	if(isdefined(param_00))
	{
		var_05 enablelinkto();
		var_05 linkto(param_00);
	}

	self.var_4D2A = var_05;
	var_06 = undefined;
	for(;;)
	{
		var_05 waittill("trigger",var_06);
		if(!isdefined(var_06))
		{
			continue;
		}

		if(!lib_0DF8::func_213D(self,var_06))
		{
			continue;
		}

		if(getdvarint("scr_minesKillOwner") != 1)
		{
			if(isdefined(self.var_222))
			{
				if(var_06 == self.var_222)
				{
					continue;
				}

				if(isdefined(var_06.var_222) && var_06.var_222 == self.var_222)
				{
					continue;
				}
			}

			if(!func_7415(self.var_222,var_06,0))
			{
				continue;
			}
		}

		if(lengthsquared(var_06 method_8123()) < 10)
		{
			continue;
		}

		if(self.var_13C2E == "mobile_radar_mp" && !func_B8F7(var_06))
		{
			continue;
		}

		if((isdefined(param_01) && param_01) || var_06 method_808F(self.origin,self) > 0)
		{
			break;
		}
	}

	self notify("mine_triggered");
	self.var_451C.var_127BF = var_06;
	if(isdefined(self.var_451C.var_C5B4))
	{
		self playsound(self.var_451C.var_C5B4);
	}

	func_6A08(var_06,level.var_B76D,"mine");
	self thread [[ self.var_451C.var_C5B3 ]]();
}

//Function Number: 233
func_B76C(param_00)
{
	scripts\common\utility::waittill_any_3("mine_triggered","mine_destroyed","mine_selfdestruct","death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 234
func_BBC4()
{
	self endon("mine_triggered");
	self endon("death");
	for(;;)
	{
		self waittill("emp_damage",var_00,var_01);
		func_66A9();
		func_11061();
		if(isdefined(self.var_4D2A))
		{
			self.var_4D2A delete();
		}

		self.var_55BA = 1;
		self notify("disabled");
		wait(var_01);
		if(isdefined(self))
		{
			self.var_55BA = undefined;
			self notify("enabled");
			var_02 = self getlinkedparent();
			thread func_B778(var_02);
		}
	}
}

//Function Number: 235
func_B77A()
{
	self endon("mine_triggered");
	self endon("mine_destroyed");
	self endon("death");
	wait(level.var_B77B + randomfloat(0.4));
	self notify("mine_selfdestruct");
	self notify("detonateExplosive");
}

//Function Number: 236
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

//Function Number: 237
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
	playfx(var_04,var_03);
	var_05 = scripts\common\utility::func_116D7(isdefined(var_01.var_B769),var_01.var_B769,level.var_B769);
	var_06 = scripts\common\utility::func_116D7(isdefined(var_01.var_B768),var_01.var_B768,level.var_B768);
	var_07 = scripts\common\utility::func_116D7(isdefined(var_01.var_B76B),var_01.var_B76B,level.var_B76B);
	if(var_06 > 0)
	{
		self radiusdamage(self.origin,var_07,var_06,var_05,var_00,"MOD_EXPLOSIVE",self.var_13C2E);
	}

	if(isdefined(self.var_222))
	{
		self.var_222 thread scripts\mp\_utility::func_AAEC("mine_destroyed",undefined,undefined,self.origin);
	}

	wait(0.2);
	func_51B5();
}

//Function Number: 238
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

//Function Number: 239
func_B77D()
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

	self playsound(self.var_451C.var_C525);
	var_01 = undefined;
	if(isdefined(self.var_F232))
	{
		var_01 = self.var_F232 gettagorigin("tag_sensor");
	}
	else
	{
		var_01 = self gettagorigin("tag_origin");
	}

	playfx(self.var_451C.var_C526,var_01);
	scripts\common\utility::func_136F7();
	if(!isdefined(self) || !isdefined(self.var_222))
	{
		return;
	}

	if(isdefined(self.var_F232))
	{
		self.var_F232 delete();
	}
	else
	{
		self method_8187("tag_sensor");
	}

	self.var_222 thread scripts\mp\_damagefeedback::func_12E84("hitmotionsensor");
	var_02 = [];
	foreach(var_04 in level.var_3CB5)
	{
		if(var_04.team == self.var_222.team)
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_04))
		{
			continue;
		}

		if(var_04 scripts\mp\_utility::_hasperk("specialty_heartbreaker"))
		{
			continue;
		}

		if(distance2d(self.origin,var_04.origin) < 300)
		{
			var_02[var_02.size] = var_04;
		}
	}

	foreach(var_07 in var_02)
	{
		thread func_B37F(var_07,self.var_222);
		level thread func_F236(var_07,self.var_222);
	}

	if(var_02.size > 0)
	{
		self.var_222 scripts\mp\_missions::func_D992("ch_motiondetected",var_02.size);
		self.var_222 thread scripts\mp\_gamelogic::func_117B7("motion_sensor",1,"hits");
	}

	if(isdefined(self.var_222))
	{
		self.var_222 thread scripts\mp\_utility::func_AAEC("mine_destroyed",undefined,undefined,self.origin);
	}

	wait(0.2);
	func_51B5();
}

//Function Number: 240
func_B37F(param_00,param_01)
{
	if(param_00 == param_01)
	{
		return;
	}

	param_00 endon("disconnect");
	var_02 = undefined;
	if(level.teambased)
	{
		var_02 = scripts\mp\_utility::func_C795(param_00,"orange",param_01.team,0,0,"equipment");
	}
	else
	{
		var_02 = scripts\mp\_utility::func_C794(param_00,"orange",param_01,0,0,"equipment");
	}

	param_00 thread scripts\mp\_damagefeedback::func_12E84("hitmotionsensor");
	scripts\mp\_gamescore::func_11ACE(param_01,param_00,"motion_sensor_mp");
	param_00 scripts\common\utility::waittill_any_timeout_1(self.var_451C.var_B371,"death");
	scripts\mp\_gamescore::func_12D6F(param_01,param_00,"motion_sensor_mp");
	scripts\mp\_utility::func_C78F(var_02,param_00);
}

//Function Number: 241
func_F236(param_00,param_01)
{
	if(param_00 == param_01)
	{
		return;
	}

	if(isai(param_00))
	{
		return;
	}

	var_02 = "coup_sunblind";
	param_00 setclientomnvar("ui_hud_shake",1);
	param_00 visionsetnakedforplayer(var_02,0.05);
	wait(0.05);
	param_00 visionsetnakedforplayer(var_02,0);
	param_00 visionsetnakedforplayer("",0.5);
}

//Function Number: 242
func_B8F5()
{
	self playsound(self.var_451C.var_C54C);
	playfx(self.var_451C.var_AABB,self.origin);
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}

	func_11061();
	var_00 = self.origin + (0,0,self.var_451C.var_AAB0);
	var_01 = self.var_451C.var_AAB7;
	var_02 = self.var_451C.var_AAB7 + 0.1;
	self moveto(var_00,var_02,0,var_01);
	self rotatevelocity((0,1100,32),var_02,0,var_01);
	thread func_D537();
	wait(var_01);
	self notify("detonateExplosive");
}

//Function Number: 243
func_B8F6()
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

	self playsound(self.var_451C.var_C525);
	var_01 = self gettagorigin("tag_origin");
	playfx(self.var_451C.var_C526,var_01);
	scripts\common\utility::func_136F7();
	if(!isdefined(self) || !isdefined(self.var_222))
	{
		return;
	}

	if(isdefined(self.var_451C.var_127BF))
	{
		var_02 = self.var_451C.var_127BF;
		var_02.var_DBD8 = 1;
		var_02 func_10DC5(self);
	}

	if(isdefined(self.var_222))
	{
		self.var_222 thread scripts\mp\_utility::func_AAEC("mine_destroyed",undefined,undefined,self.origin);
		self.var_222 scripts\mp\_damagefeedback::func_12E84("hitmotionsensor");
	}

	wait(0.2);
	func_51B5();
}

//Function Number: 244
func_10DC5(param_00)
{
	var_01 = self gettagorigin("tag_shield_back");
	var_02 = spawn("script_model",var_01);
	var_02 setmodel("weapon_mobile_radar_back");
	var_02.var_AC75 = param_00.var_AC75;
	var_02.var_222 = param_00.var_222;
	var_02.var_451C = param_00.var_451C;
	var_02 linkto(self,"tag_shield_back",(0,0,0),(0,90,90));
	var_02 thread func_D501(self);
	var_02 thread func_4988(param_00.var_451C.var_2C68,"tag_origin",param_00.var_222);
	var_02 thread func_B76A();
	var_02 thread func_13B1A(self,param_00);
	var_02 thread func_13B1B(self,param_00);
	var_02 thread func_139F0();
}

//Function Number: 245
func_D501(param_00)
{
	self endon("death");
	var_01 = self gettagorigin("tag_fx");
	var_02 = spawn("script_model",var_01);
	var_02 setmodel("tag_origin");
	var_02 linkto(self,"tag_fx",(0,0,0),(90,0,-90));
	var_02 thread func_13A0F(self);
	for(;;)
	{
		wait(2);
		playfxontag(self.var_451C.var_C4C5,var_02,"tag_origin");
		if(isdefined(param_00))
		{
			param_00 scripts\mp\_damagefeedback::func_12E84("hitmotionsensor");
			param_00 playsoundonmovingent("ball_drone_3Dping");
		}
		else
		{
			self playsound("ball_drone_3Dping");
		}

		foreach(var_04 in level.players)
		{
			if(var_04.team != self.var_222.team)
			{
				continue;
			}

			function_0222(self.origin,var_04);
		}
	}
}

//Function Number: 246
func_13A0F(param_00)
{
	self endon("death");
	param_00 waittill("death");
	self delete();
}

//Function Number: 247
func_13B1A(param_00,param_01)
{
	self endon("death");
	for(;;)
	{
		self waittill("detonateExplosive",var_02);
		param_00.var_DBD8 = undefined;
		self.var_451C.var_127BF = undefined;
		self playsound(self.var_451C.var_C525);
		var_03 = self gettagorigin("tag_origin");
		playfx(self.var_451C.var_C526,var_03);
		self delete();
	}
}

//Function Number: 248
func_13B1B(param_00,param_01)
{
	self endon("death");
	var_02 = param_01.var_222;
	var_03 = param_01.angles;
	var_04 = param_01.var_AC75;
	param_00 waittill("death");
	param_00.var_DBD8 = undefined;
	self.var_451C.var_127BF = undefined;
	func_108E5(param_00.origin,var_02,"mobile_radar_mp",var_03,var_04,1);
	self delete();
}

//Function Number: 249
func_B8F7(param_00)
{
	var_01 = 1;
	if(isdefined(param_00.var_DBD8))
	{
		var_01 = 0;
	}

	if(!isplayer(param_00))
	{
		var_01 = 0;
	}

	return var_01;
}

//Function Number: 250
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

//Function Number: 251
func_B765(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06[0] = (1,0,0);
	var_06[1] = (0,1,0);
	if(param_01[2] < param_05)
	{
		var_07 = 0;
	}
	else
	{
		var_07 = 1;
	}

	var_08 = (param_00[0],param_00[1],param_05);
	var_09 = (param_01[0],param_01[1],param_05);
	thread func_4F3A(var_08,level.var_B76B,var_06[var_07],32);
	var_0A = distancesquared(param_00,param_01);
	if(var_0A > param_02)
	{
		var_07 = 0;
	}
	else
	{
		var_07 = 1;
	}

	thread func_4F48(var_08,var_09,var_06[var_07]);
}

//Function Number: 252
func_B767(param_00,param_01)
{
	if(isplayer(param_01) && isalive(param_01) && param_01.sessionstate == "playing")
	{
		var_02 = param_01 scripts\mp\_utility::func_815C();
	}
	else if(var_02.classname == "misc_turret")
	{
		var_02 = var_02.origin + (0,0,32);
	}
	else
	{
		var_02 = var_02.origin;
	}

	var_03 = 0;
	var_04 = param_00.origin[2] + var_03 - level.var_B766;
	if(var_02[2] < var_04)
	{
		return 0;
	}

	return 1;
}

//Function Number: 253
func_B780(param_00,param_01,param_02)
{
	if(!isalive(self))
	{
		param_00 delete();
		return;
	}

	scripts\mp\_gamelogic::func_F73B(self,1);
	param_00 thread func_B77F(self,param_00.var_13C2E,param_00.var_D719,param_00.var_1088C,param_02);
}

//Function Number: 254
func_B77F(param_00,param_01,param_02,param_03,param_04)
{
	self.var_222 = param_00;
	self waittill("missile_stuck",var_05);
	if(param_01 != "trip_mine_mp")
	{
		if(isdefined(var_05) && isdefined(var_05.var_222))
		{
			if(isdefined(param_04))
			{
				self.var_222 [[ param_04 ]](self);
			}

			self delete();
			return;
		}
	}

	self.var_222 notify("bouncing_betty_update",0);
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_01 != "sonic_sensor_mp")
	{
		var_06 = bullettrace(self.origin + (0,0,4),self.origin - (0,0,4),0,self);
	}
	else
	{
		var_06 = scripts\common\trace::func_DCED(self.origin,self.origin + anglestoup(self.angles * 2));
	}

	var_07 = var_06["position"];
	if(var_06["fraction"] == 1 && param_01 != "sonic_sensor_mp")
	{
		var_07 = getgroundposition(self.origin,12,0,32);
		var_06["normal"] = var_06["normal"] * -1;
	}

	if(param_01 != "sonic_sensor_mp")
	{
		var_08 = vectornormalize(var_06["normal"]);
		var_09 = vectortoangles(var_08);
		var_09 = var_09 + (90,0,0);
	}
	else
	{
		var_09 = self.angles;
	}

	var_0A = self [[ param_03 ]](var_07,param_00,param_01,param_02,var_09);
	var_0A func_B2A5();
	var_0A thread func_B76A();
	self delete();
}

//Function Number: 255
func_51CE()
{
	if(isdefined(self.var_CC4C))
	{
		foreach(var_01 in self.var_CC4C)
		{
			if(isdefined(var_01))
			{
				var_01 func_51B5();
			}
		}
	}

	if(isdefined(self.var_CC4D))
	{
		foreach(var_01 in self.var_CC4D)
		{
			if(isdefined(var_01))
			{
				var_01 func_51B5();
			}
		}
	}

	self.var_CC4C = [];
	self.var_CC4D = [];
}

//Function Number: 256
func_51AF()
{
	var_00 = scripts\mp\_powers::func_808C("primary");
	foreach(var_02 in self.var_CC4C)
	{
		if(isdefined(var_02))
		{
			if(!isdefined(var_02.var_D77A) || !isdefined(var_00) || var_02.var_D77A != var_00)
			{
				var_02 func_51B5();
			}
		}
	}

	var_04 = scripts\mp\_powers::func_808C("secondary");
	foreach(var_02 in self.var_CC4D)
	{
		if(isdefined(var_02))
		{
			if(!isdefined(var_02.var_D77A) || !isdefined(var_04) || var_02.var_D77A != var_04)
			{
				var_02 func_51B5();
			}
		}
	}
}

//Function Number: 257
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

//Function Number: 258
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

//Function Number: 259
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

//Function Number: 260
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

//Function Number: 261
func_3E52(param_00)
{
	return self.team == param_00.team;
}

//Function Number: 262
func_3E34(param_00)
{
	return self == param_00;
}

//Function Number: 263
func_66A6(param_00)
{
	playfx(scripts\common\utility::getfx("equipment_sparks"),self.origin);
	if(!isdefined(param_00) || param_00 == 0)
	{
		self playsound("sentry_explode");
	}
}

//Function Number: 264
func_66A8(param_00,param_01)
{
	if(isdefined(param_00))
	{
		if(isdefined(param_01))
		{
			var_02 = anglestoforward(param_01);
			var_03 = anglestoup(param_01);
			playfx(scripts\common\utility::getfx("equipment_explode"),param_00,var_02,var_03);
			playfx(scripts\common\utility::getfx("equipment_smoke"),param_00,var_02,var_03);
		}
		else
		{
			playfx(scripts\common\utility::getfx("equipment_explode"),param_00);
			playfx(scripts\common\utility::getfx("equipment_smoke"),param_00);
		}

		playsoundatpos(param_00,"mp_killstreak_disappear");
		return;
	}

	if(isdefined(self))
	{
		var_04 = self.origin;
		var_02 = anglestoforward(self.angles);
		var_03 = anglestoup(self.angles);
		playfx(scripts\common\utility::getfx("equipment_explode"),var_04,var_02,var_03);
		playfx(scripts\common\utility::getfx("equipment_smoke"),var_04,var_02,var_03);
		self playsound("mp_killstreak_disappear");
	}
}

//Function Number: 265
func_66A9()
{
	playfxontag(scripts\common\utility::getfx("emp_stun"),self,"tag_origin");
}

//Function Number: 266
func_31D5()
{
	var_00 = func_7DDF();
	level.var_2497 = [];
	level.var_2498 = [];
	level.var_248B = [];
	foreach(var_02 in var_00)
	{
		var_03 = tablelookup("mp/attachmenttable.csv",4,var_02,5);
		if(var_02 != var_03)
		{
			level.var_2497[var_02] = var_03;
		}

		var_04 = tablelookup("mp/attachmenttable.csv",4,var_02,13);
		if(var_04 != "")
		{
			level.var_2498[var_02] = var_04;
			level.var_248B[var_04] = 1;
		}
	}

	var_06 = [];
	var_07 = 1;
	var_08 = tablelookupbyrow("mp/attachmentmap.csv",var_07,0);
	while(var_08 != "")
	{
		var_06[var_06.size] = var_08;
		var_07++;
		var_08 = tablelookupbyrow("mp/attachmentmap.csv",var_07,0);
	}

	var_09 = [];
	var_0A = 1;
	var_0B = tablelookupbyrow("mp/attachmentmap.csv",0,var_0A);
	while(var_0B != "")
	{
		var_09[var_0B] = var_0A;
		var_0A++;
		var_0B = tablelookupbyrow("mp/attachmentmap.csv",0,var_0A);
	}

	level.var_2492 = [];
	foreach(var_08 in var_06)
	{
		foreach(var_10, var_0E in var_09)
		{
			var_0F = tablelookup("mp/attachmentmap.csv",0,var_08,var_0E);
			if(var_0F == "")
			{
				continue;
			}

			if(!isdefined(level.var_2492[var_08]))
			{
				level.var_2492[var_08] = [];
			}

			level.var_2492[var_08][var_10] = var_0F;
		}
	}

	level.var_2491 = [];
	foreach(var_13 in var_00)
	{
		var_14 = tablelookup("mp/attachmenttable.csv",4,var_13,12);
		if(var_14 == "")
		{
			continue;
		}

		level.var_2491[var_13] = var_14;
	}

	level.var_2493 = [];
	var_16 = 1;
	var_17 = tablelookupbyrow("mp/attachmentcombos.csv",var_16,0);
	while(var_17 != "")
	{
		var_18 = 1;
		var_19 = tablelookupbyrow("mp/attachmentcombos.csv",0,var_18);
		while(var_19 != "")
		{
			if(var_17 != var_19)
			{
				var_1A = tablelookupbyrow("mp/attachmentcombos.csv",var_16,var_18);
				var_1B = scripts\common\utility::func_1D3A([var_17,var_19]);
				var_1C = var_1B[0] + "_" + var_1B[1];
				if(var_1A == "no" && !isdefined(level.var_2493[var_1C]))
				{
					level.var_2493[var_1C] = 1;
				}
			}

			var_18++;
			var_19 = tablelookupbyrow("mp/attachmentcombos.csv",0,var_18);
		}

		var_16++;
		var_17 = tablelookupbyrow("mp/attachmentcombos.csv",var_16,0);
	}
}

//Function Number: 267
func_7DDF()
{
	var_00 = [];
	var_01 = 0;
	var_02 = tablelookup("mp/attachmentTable.csv",0,var_01,4);
	while(var_02 != "")
	{
		var_00[var_02] = var_02;
		var_01++;
		var_02 = tablelookup("mp/attachmentTable.csv",0,var_01,4);
	}

	return var_00;
}

//Function Number: 268
func_3222()
{
	level.var_13CA5 = [];
	for(var_00 = 1;tablelookup("mp/statstable.csv",0,var_00,0) != "";var_00++)
	{
		var_01 = tablelookup("mp/statstable.csv",0,var_00,4);
		if(var_01 != "")
		{
			level.var_13CA5[var_01] = spawnstruct();
			var_02 = tablelookup("mp/statstable.csv",0,var_00,0);
			if(var_02 != "")
			{
				level.var_13CA5[var_01].var_C211 = var_02;
			}

			var_03 = tablelookup("mp/statstable.csv",0,var_00,1);
			if(var_03 != "")
			{
				level.var_13CA5[var_01].var_8677 = var_03;
			}

			var_04 = tablelookup("mp/statstable.csv",0,var_00,5);
			if(var_04 != "")
			{
				level.var_13CA5[var_01].var_23B0 = var_04;
			}

			var_05 = tablelookup("mp/statstable.csv",0,var_00,44);
			if(var_05 != "")
			{
				level.var_13CA5[var_01].var_CA2E = var_05;
			}

			var_06 = tablelookup("mp/statstable.csv",0,var_00,9);
			if(var_06 != "")
			{
				level.var_13CA5[var_01].var_2476 = strtok(var_06," ");
			}

			level.var_13CA5[var_01].var_F1A8 = [];
			level.var_13CA5[var_01].var_F1A9 = [];
			for(var_07 = 0;var_07 < 20;var_07++)
			{
				var_08 = tablelookup("mp/statstable.csv",0,var_00,10 + var_07);
				if(isdefined(var_08) && var_08 != "")
				{
					var_09 = level.var_13CA5[var_01].var_F1A8.size;
					level.var_13CA5[var_01].var_F1A8[var_09] = var_08;
					level.var_13CA5[var_01].var_F1A9[var_08] = 1;
				}
			}

			if(level.tactical)
			{
				var_0A = tablelookup("mp/statstable.csv",0,var_00,50);
			}
			else
			{
				var_0A = tablelookup("mp/statstable.csv",0,var_01,8);
			}

			if(var_0A != "")
			{
				var_0A = float(var_0A);
				level.var_13CA5[var_01].var_2B3 = var_0A;
			}
		}
	}
}

//Function Number: 269
func_464F()
{
	level endon("game_ended");
	self endon("end_explode");
	self.var_222 endon("disconnect");
	self waittill("explode",var_00);
	func_464D(var_00);
}

//Function Number: 270
func_464D(param_00)
{
	thread scripts\mp\_utility::func_C15A("death","end_explode");
	var_01 = self.var_222;
	var_02 = var_01 scripts\mp\_utility::getotherteam(var_01.team);
	var_03 = undefined;
	var_04 = 0;
	if(level.teambased)
	{
		var_03 = scripts\mp\_utility::func_81A0(var_02);
	}
	else
	{
		var_03 = level.var_3CB5;
	}

	var_05 = [];
	var_06 = func_7E8C(param_00,256,0,undefined);
	if(var_06.size >= 1)
	{
		foreach(var_08 in var_06)
		{
			if(isdefined(var_08.var_222) && !func_7415(self.var_222,var_08.var_222))
			{
				continue;
			}

			var_08 notify("emp_damage",self.var_222,5);
			foreach(var_0A in var_03)
			{
				if(var_08 == var_0A || var_08 == self.var_222)
				{
					var_08 thread func_464E();
					var_05[var_05.size] = var_08;
					break;
				}
			}
		}

		foreach(var_0E in var_05)
		{
			if(var_0E == self.var_222)
			{
				var_04 = 1;
				break;
			}
		}

		if(!var_04)
		{
			var_0E = var_05[var_05.size - 1];
			if(isdefined(var_0E) && var_0E != var_01)
			{
				var_10 = "primary";
				var_11 = "none";
				var_12 = getarraykeys(var_01.var_D782);
				foreach(var_14 in var_12)
				{
					if(var_01.var_D782[var_14].var_10307 == var_10)
					{
						var_11 = var_14;
					}
				}

				var_16 = var_0E.var_AE7B;
				if(isdefined(var_16) && var_16 != "none")
				{
					var_01 notify("corpse_steal");
					var_01 notify("start_copycat");
					var_01 scripts\mp\_powers::func_E15E(var_11);
					var_01 scripts\mp\_powers::func_8397(var_16,var_10,1);
					var_01 thread func_139D7(var_16,var_10);
					return;
				}

				return;
			}
		}
	}
}

//Function Number: 271
func_139D7(param_00,param_01)
{
	self endon("disconnect");
	self endon("death");
	self endon("corpse_steal");
	self waittill("copycat_reset");
	self notify("start_copycat");
	scripts\mp\_powers::func_E15E(param_00);
	scripts\mp\_powers::func_8397(self.var_AE7B,param_01,1);
	self setclientomnvar("ui_juggernaut",0);
}

//Function Number: 272
func_464E()
{
	self endon("disconnect");
	self endon("death");
	var_00 = gettime() + 5000;
	scripts\mp\_powers::func_D740(0);
	if(isdefined(self.var_38A1) && self.var_38A1)
	{
		scripts\mp\_powers::func_12C9F();
	}

	thread scripts\mp\_powers::func_D729();
	while(gettime() < var_00)
	{
		wait(0.1);
	}

	scripts\mp\_powers::func_D74E();
	if(isdefined(self.var_38A1) && !self.var_38A1)
	{
		scripts\mp\_powers::func_F6B1();
	}

	thread scripts\mp\_powers::func_D72F();
}

//Function Number: 273
func_85DD(param_00,param_01,param_02)
{
	if(!isdefined(self))
	{
		param_00.var_11180 = param_01;
		param_01.var_1117F = param_00;
		return;
	}

	if(level.teambased && isdefined(param_01.team) && param_01.team == self.team)
	{
		param_00.var_9F7D = "friendly";
		return;
	}

	var_03 = undefined;
	if(func_83F3(param_00.var_13C2E) == "stickglprox")
	{
		var_03 = "stickglprox_stuck";
	}
	else
	{
		switch(param_00.var_13C2E)
		{
			case "semtex_mp":
				var_03 = "semtex_stuck";
				break;

			case "splash_grenade_mp":
				var_03 = "splash_grenade_stuck";
				break;

			case "power_spider_grenade_mp":
				var_03 = "spider_grenade_stuck";
				break;

			case "wristrocket_proj_mp":
				var_03 = "wrist_rocket_stuck";
				break;
		}
	}

	param_00.var_9F7D = "enemy";
	param_00.var_11180 = param_01;
	if(param_00.var_13C2E == "split_grenade_mp")
	{
		param_01.var_1117F = undefined;
	}
	else
	{
		param_01.var_1117F = param_00;
		self notify("grenade_stuck_enemy");
	}

	if(!scripts\mp\_utility::func_9FB3(param_02))
	{
		func_85DE(var_03,param_01);
		return;
	}
}

//Function Number: 274
func_85DE(param_00,param_01)
{
	if(isplayer(param_01) && isdefined(param_00))
	{
		param_01 scripts\mp\_hud_message::func_10151(param_00,undefined,self);
	}

	thread scripts\mp\_awards::func_8380("explosive_stick");
}

//Function Number: 275
func_66A5(param_00,param_01)
{
	if(param_00 scripts\mp\_powers::func_D734(param_01) > 0)
	{
		return 0;
	}

	var_02 = undefined;
	switch(param_01)
	{
		case "power_explodingDrone":
			var_02 = param_00.var_69D6;
			break;

		case "power_c4":
			var_02 = param_00.var_CC4C;
			break;

		case "power_transponder":
			var_02 = param_00.var_CC4D;
			break;
	}

	if(!isdefined(var_02) || var_02.size == 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 276
func_10884(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_108E3(param_00,param_01,param_02,param_03,param_04);
	var_05.var_76CF = spawn("script_model",var_05.var_A63A.origin);
	var_05.var_76CF setscriptmoverkillcam("explosive");
	thread func_40F6(var_05.var_76CF,var_05);
	return var_05;
}

//Function Number: 277
func_40F6(param_00,param_01)
{
	param_01 waittill("death");
	wait(20);
	param_00 delete();
}

//Function Number: 278
func_10832(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_108E3(param_00,param_01,param_02,param_03,param_04);
	var_05.var_76CF = spawn("script_model",var_05.var_A63A.origin);
	var_05.var_76CF setscriptmoverkillcam("explosive");
	thread func_40E6(var_05.var_76CF,var_05);
	param_01 notify("powers_blackholeGrenade_used",1);
	return var_05;
}

//Function Number: 279
func_40E6(param_00,param_01)
{
	param_01 waittill("death");
	wait(20);
	param_00 delete();
}

//Function Number: 280
func_1082C(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_108E3(param_00,param_01,param_02,param_03,param_04);
	var_05.var_76CF = spawn("script_model",var_05.var_A63A.origin);
	var_05.var_76CF setscriptmoverkillcam("explosive");
	thread func_40E4(var_05.var_76CF,var_05);
	return var_05;
}

//Function Number: 281
func_40E4(param_00,param_01)
{
	param_01 waittill("death");
	wait(20);
	param_00 delete();
}

//Function Number: 282
func_10843(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_108E3(param_00,param_01,param_02,param_03,param_04);
	var_05.var_4ACD = spawn("script_model",var_05.var_A63A.origin);
	var_05.var_4ACD setscriptmoverkillcam("explosive");
	thread func_40F1(var_05.var_4ACD,var_05);
	param_01 notify("powers_cryoGrenade_used",1);
	return var_05;
}

//Function Number: 283
func_40F1(param_00,param_01)
{
	param_01 waittill("death");
	wait(20);
	param_00 delete();
}

//Function Number: 284
func_1090D(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_108E3(param_00,param_01,param_02,param_03,param_04);
	var_05.var_76CF = spawn("script_model",var_05.var_A63A.origin);
	var_05.var_76CF setscriptmoverkillcam("explosive");
	thread func_4117(var_05.var_76CF,var_05);
	self notify("powers_shardBall_used",1);
	return var_05;
}

//Function Number: 285
func_4117(param_00,param_01)
{
	param_01 waittill("death");
	wait(20);
	param_00 delete();
}

//Function Number: 286
func_C798(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_C794(param_00,"white",param_01,0,0,"equipment");
	param_00 waittill("death");
	scripts\mp\_utility::func_C78F(var_02,param_00);
}

//Function Number: 287
outlinesuperequipment(param_00,param_01)
{
	if(level.teambased)
	{
		thread func_C7B0(param_00,param_01);
		return;
	}

	thread outlinesuperequipmentforplayer(param_00,param_01);
}

//Function Number: 288
func_C7B0(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_C795(param_00,"cyan",param_01.team,0,0,"killstreak");
	param_00 waittill("death");
	scripts\mp\_utility::func_C78F(var_02,param_00);
}

//Function Number: 289
outlinesuperequipmentforplayer(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_C794(param_00,"cyan",param_01,0,0,"killstreak");
	param_00 waittill("death");
	scripts\mp\_utility::func_C78F(var_02,param_00);
}

//Function Number: 290
func_85BE()
{
	if(!isdefined(self.var_85BE) || self.var_85BE == "none")
	{
		return 0;
	}

	return 1;
}

//Function Number: 291
func_7EE4()
{
	if(!isdefined(self.var_85BE))
	{
		return "none";
	}

	return self.var_85BE;
}

//Function Number: 292
func_13A93()
{
	self notify("watchGrenadeHeldAtDeath");
	self endon("watchGrenadeHeldAtDeath");
	self endon("spawned_player");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self.var_85BE = scripts\mp\_utility::func_7EE5();
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 293
trace_impale(param_00,param_01)
{
	var_02 = physics_createcontents(["physicscontents_solid","physicscontents_glass","physicscontents_missileclip","physicscontents_vehicle","physicscontents_item"]);
	var_03 = scripts\common\trace::func_DCEE(param_00,param_01,level.players,var_02,undefined,1);
	return var_03;
}

//Function Number: 294
impale_endpoint(param_00,param_01)
{
	var_02 = param_00 + param_01 * 4096;
	return var_02;
}

//Function Number: 295
func_934E(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	if(!isdefined(param_01.var_2C09))
	{
		return;
	}

	var_09 = param_00 scripts\mp\_utility::_hasperk("passive_power_melee");
	if(var_09)
	{
		param_06 = "torso";
	}
	else
	{
		playfx(scripts\common\utility::getfx("penetration_railgun_impact"),param_04);
	}

	var_0A = impale_endpoint(param_04,param_05);
	var_0B = trace_impale(param_04,var_0A);
	var_0A = var_0B["position"] - param_05 * 12;
	var_0C = length(var_0A - param_04);
	var_0D = var_0C / scripts\common\utility::func_116D7(var_09,600,1000);
	var_0D = max(var_0D,0.05);
	if(var_0B["hittype"] != "hittype_world")
	{
		var_0D = 0;
	}

	var_0E = var_0D > 0.05;
	if(isdefined(param_01))
	{
		param_01.var_2C09 method_839A();
	}

	wait(0.05);
	if(var_0E)
	{
		var_0F = param_05;
		var_10 = anglestoup(param_00.angles);
		var_11 = vectorcross(var_0F,var_10);
		var_12 = scripts\common\utility::spawn_tag_origin(param_04,axistoangles(var_0F,var_11,var_10));
		var_12 moveto(var_0A,var_0D);
		var_13 = spawnragdollconstraint(param_01.var_2C09,param_06,param_07,param_08);
		var_13.origin = var_12.origin;
		var_13.angles = var_12.angles;
		var_13 linkto(var_12);
		if(var_0D > scripts\common\utility::func_116D7(var_09,0.075,1))
		{
			thread func_9350(var_13,scripts\common\utility::func_116D7(var_09,0.075,1));
		}

		thread func_934F(param_01,var_12,var_0D + 0.25);
		if(!var_09)
		{
			var_12 thread func_9351(var_0A,var_0D);
		}
	}
}

//Function Number: 296
func_9350(param_00,param_01)
{
	wait(param_01);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 297
func_9351(param_00,param_01)
{
	wait(clamp(param_01 - 0.05,0.05,20));
	playfx(scripts\common\utility::getfx("vfx_penetration_railgun_impact"),param_00);
}

//Function Number: 298
func_934F(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		param_00 scripts\common\utility::waittill_any_timeout_1(param_02,"death","disconnect");
	}

	param_01 delete();
}

//Function Number: 299
func_00AA(param_00,param_01)
{
	return [1,1];
}

//Function Number: 300
func_9F3C(param_00,param_01)
{
	return isdefined(level.var_13CA5[param_00].var_F1A9[param_01]);
}

//Function Number: 301
func_F7FC()
{
	if(!isdefined(self.var_9F80))
	{
		self.var_9F80 = 1;
		return;
	}

	self.var_9F80++;
}

//Function Number: 302
func_F800()
{
	self.var_9F80--;
}

//Function Number: 303
func_9F80()
{
	return isdefined(self.var_9F80) && self.var_9F80 > 0;
}

//Function Number: 304
func_F7EE()
{
	if(!isdefined(self.var_9D6B))
	{
		self.var_9D6B = 1;
		return;
	}

	self.var_9D6B++;
}

//Function Number: 305
func_F7FF()
{
	self.var_9D6B--;
}

//Function Number: 306
func_9D6B()
{
	return isdefined(self.var_9D6B) && self.var_9D6B > 0;
}

//Function Number: 307
func_9F81()
{
	return func_9D6B() || func_9F80();
}

//Function Number: 308
func_40EA(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(param_00);
	func_F800();
}

//Function Number: 309
func_A008(param_00)
{
	var_01 = getweaponbasename(param_00);
	switch(var_01)
	{
		case "iw7_sonic_mp":
			return 1;
	}

	return 0;
}

//Function Number: 310
func_20E4()
{
	self endon("death");
	self endon("disconnect");
	wait(0.1);
	if(isdefined(self) && isplayer(self) && !isbot(self))
	{
		self playlocalsound("sonic_shotgun_debuff");
		self setsoundsubmix("sonic_shotgun_impact");
	}
}

//Function Number: 311
func_13AB2()
{
	level endon("lethal_delay_end");
	level endon("round_end");
	level endon("game_ended");
	level waittill("prematch_over");
	level.var_ABBF = getdvarfloat("scr_lethalDelay",0);
	if(level.var_ABBF == 0)
	{
		level.var_ABC2 = scripts\mp\_utility::func_81CB();
		level.var_ABC0 = level.var_ABC2;
		level notify("lethal_delay_end");
	}

	level.var_ABC2 = scripts\mp\_utility::func_81CB();
	level.var_ABC0 = level.var_ABC2 + level.var_ABBF * 1000;
	level notify("lethal_delay_start");
	while(scripts\mp\_utility::func_81CB() < level.var_ABC0)
	{
		scripts\common\utility::func_136F7();
	}

	level notify("lethal_delay_end");
}

//Function Number: 312
func_13AB5(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	level endon("round_end");
	level endon("game_ended");
	if(func_ABC1())
	{
		return;
	}

	self notify("watchLethalDelayPlayer_" + param_02);
	self endon("watchLethalDelayPlayer_" + param_02);
	self endon("power_removed_" + param_01);
	param_00 scripts\mp\_powers::func_D727(param_01);
	func_13AB4(param_00,param_02);
	param_00 scripts\mp\_powers::func_D72D(param_01);
}

//Function Number: 313
func_13AB4(param_00,param_01)
{
	level endon("lethal_delay_end");
	if(!scripts\mp\_utility::func_9FB3(scripts\mp\_utility::func_766C("prematch_done")))
	{
		level waittill("lethal_delay_start");
	}

	var_02 = "+frag";
	if(param_01 != "primary")
	{
		var_02 = "+smoke";
	}

	if(!isbot(param_00))
	{
		param_00 notifyonplayercommand("lethal_attempt_" + param_01,var_02);
	}

	for(;;)
	{
		self waittill("lethal_attempt_" + param_01);
		var_03 = level.var_ABC0 - scripts\mp\_utility::func_81CB() / 1000;
		var_03 = int(max(0,ceil(var_03)));
		param_00 scripts\mp\_hud_message::func_10122("MP_LETHALS_UNAVAILABLE_FOR_N",var_03);
	}
}

//Function Number: 314
func_3882()
{
	level.var_ABBF = 0;
	level.var_ABC2 = scripts\mp\_utility::func_81CB();
	level.var_ABC0 = level.var_ABC2;
	level notify("lethal_delay_end");
}

//Function Number: 315
func_ABC1(param_00)
{
	if(isdefined(level.var_ABBF) && level.var_ABBF == 0)
	{
		return 1;
	}

	return isdefined(level.var_ABC0) && scripts\mp\_utility::func_81CB() > level.var_ABC0;
}

//Function Number: 316
func_13AA9()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_switch_invalid",var_00);
		var_01 = self getcurrentweapon();
		var_02 = function_0244(var_01);
		if(var_02 == "item" || var_02 == "exclusive")
		{
			scripts\mp\_utility::_switchtoweapon(self.var_A978);
		}
	}
}

//Function Number: 317
func_13C98(param_00)
{
	var_01 = scripts\mp\_utility::func_8234(param_00);
	var_02 = function_00E3(param_00);
	foreach(var_04 in var_02)
	{
		var_05 = func_248C(var_04);
		if(var_05 == "rail")
		{
			var_06 = scripts\mp\_utility::func_2494(var_04);
			if(func_9F3C(var_01,var_06))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 318
watchdropweapons()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_dropped",var_00,var_01);
		if(isdefined(var_00) && isdefined(var_01))
		{
		}
	}
}

//Function Number: 319
watchgrenadeaxepickup(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	if(!isdefined(self.var_13C2E) && isdefined(param_01))
	{
		self.var_13C2E = param_01;
	}

	self.inphase = 0;
	if(isdefined(param_00))
	{
		self.inphase = param_00 method_84D9();
	}

	self waittill("missile_stuck",var_02,var_03);
	if(isdefined(var_02) && isplayer(var_02) || isagent(var_02))
	{
		var_04 = var_03 == "tag_flicker";
		var_05 = var_03 == "tag_top_flicker";
		var_06 = var_02 scripts\mp\_utility::_hasperk("specialty_rearguard") && var_03 == "tag_origin";
		var_07 = isdefined(var_03) && var_04 || var_05 || var_06;
		var_08 = isdefined(var_03) && var_03 == "tag_weapon";
		if(var_07)
		{
			playfx(scripts\common\utility::getfx("shield_metal_impact"),self.origin);
			if(isdefined(self.var_222))
			{
				var_09 = self.var_222;
				relaunchaxe(self.var_13C2E,var_09,1);
				return;
			}
		}
		else if(!scripts\mp\_utility::func_9FB3(var_08) && isplayer(var_03) && !scripts\mp\_utility::func_9F19(var_03) && level.var_B335 == "mp_neon" || scripts\mp\_utility::func_9FB3(level.var_DC24))
		{
			return;
		}
	}

	param_01 thread func_11825(param_01,self);
	var_0A = 45;
	thread watchaxetimeout(var_0A);
	thread func_13A90();
	thread watchaxeuse(param_01,self.var_13C2E);
	thread watchaxeautopickup(param_01,self.var_13C2E);
}

//Function Number: 320
axedetachfromcorpse(param_00)
{
	level endon("game_ended");
	var_01 = param_00 getlinkedchildren();
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = var_03.var_13C2E;
		var_05 = var_03.var_222;
		var_06 = var_03.origin;
		if(isdefined(var_04) && isaxeweapon(var_04))
		{
			var_03 relaunchaxe(var_04,var_05,1);
		}
	}
}

//Function Number: 321
relaunchaxe(param_00,param_01,param_02)
{
	self unlink();
	var_03 = scripts\mp\_utility::func_821D(param_00);
	var_04 = getsubstr(param_00,var_03.size);
	var_05 = param_01 scripts\mp\_utility::func_1302("iw7_axe_mp_dummy" + var_04,self.origin,(0,0,0),100,1,self);
	var_05 method_82DD(param_01);
	var_05 thread watchgrenadeaxepickup(param_01,self.var_13C2E);
	if(scripts\mp\_utility::func_9FB3(param_02))
	{
		self.inphase = 0;
		self.var_FF03 = 0;
	}
}

//Function Number: 322
watchaxetimeout(param_00)
{
	self endon("death");
	level endon("game_ended");
	scripts\mp\_hostmigration::func_13708(param_00);
	self delete();
}

//Function Number: 323
watchaxeautopickup(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	var_02 = spawn("trigger_radius",self.origin - (0,0,40),0,64,64);
	var_02 enablelinkto();
	var_02 linkto(self);
	self.var_A702 = var_02;
	var_02 endon("death");
	for(;;)
	{
		var_02 waittill("trigger",param_00);
		if(!isplayer(param_00))
		{
			continue;
		}

		if(param_00 playercanautopickupaxe(self))
		{
			param_00 playerpickupaxe(param_01,1);
			self delete();
			break;
		}
	}
}

//Function Number: 324
watchaxeuse(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	var_02 = spawn("script_model",self.origin);
	var_02 linkto(self);
	self.useobj_trigger = var_02;
	var_02 makeusable();
	var_02 setcursorhint("HINT_NOICON");
	var_02 method_84A9("show");
	var_02 sethintstring(&"WEAPON_PICKUP_AXE");
	var_02 method_84A6(360);
	var_02 method_84A5(360);
	var_02 method_84A4(64);
	var_02 method_84A2(64);
	var_02 method_835F(0);
	thread watchallplayerphasestates(var_02);
	var_02 waittill("trigger",param_00);
	param_00 playerpickupaxe(param_01,0);
	self delete();
}

//Function Number: 325
watchallplayerphasestates(param_00)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(!scripts\mp\_utility::func_9F19(var_02))
			{
				continue;
			}

			if(!axeinsamephaseplayerstate(self,var_02))
			{
				param_00 disableplayeruse(var_02);
				continue;
			}

			param_00 enableplayeruse(var_02);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 326
axeinsamephaseplayerstate(param_00,param_01)
{
	var_02 = 1;
	if(scripts\mp\_utility::func_9FB3(param_00.inphase) && !param_01 method_84D9())
	{
		var_02 = 0;
	}
	else if(!scripts\mp\_utility::func_9FB3(param_00.inphase) && param_01 method_84D9())
	{
		var_02 = 0;
	}

	return var_02;
}

//Function Number: 327
playercanautopickupaxe(param_00)
{
	if(isdefined(param_00.var_222) && self != param_00.var_222)
	{
		return 0;
	}

	var_01 = self getweaponslistprimaries();
	var_02 = 0;
	var_03 = 0;
	foreach(var_05 in var_01)
	{
		if(isaxeweapon(var_05) && self getweaponammoclip(var_05) == 0)
		{
			var_02 = 1;
			break;
		}

		if(issubstr(var_05,"iw7_fists_mp"))
		{
			var_02 = 1;
			break;
		}

		if(!issubstr(var_05,"alt_"))
		{
			var_03++;
		}
	}

	if(var_03 < 2)
	{
		var_02 = 1;
	}

	if(scripts\mp\_utility::func_9FB3(var_02))
	{
		if(!axeinsamephaseplayerstate(param_00,self))
		{
			var_02 = 0;
		}
	}

	return var_02;
}

//Function Number: 328
playerpickupaxe(param_00,param_01)
{
	var_02 = scripts\mp\_utility::func_E0CF(param_00);
	var_03 = self getcurrentweapon();
	var_04 = self getweaponslistprimaries();
	if(self hasweapon(param_00))
	{
		var_05 = self getweaponammoclip(param_00);
		if(!param_01 && var_05 > 0)
		{
			self method_80B8(param_00);
			scripts\mp\_utility::func_12C6(var_02);
		}
		else if(!issubstr(var_03,param_00))
		{
			scripts\mp\_utility::func_141E(param_00);
			scripts\mp\_utility::func_12C6(var_02);
		}

		var_06 = self getweaponammoclip(var_03) == 0 && isaxeweapon(var_03);
		var_07 = issubstr(var_03,"iw7_fists_mp");
		if(!param_01 || var_07 || var_06)
		{
			scripts\mp\_utility::_switchtoweapon(var_02);
		}

		self setweaponammoclip(var_02,1);
		scripts\mp\_hud_message::func_1013D("axe");
		return;
	}

	var_08 = undefined;
	var_09 = 0;
	foreach(var_0B in var_07)
	{
		if(issubstr(var_0B,"alt_"))
		{
			continue;
		}

		if(issubstr(var_0B,"uplinkball"))
		{
			continue;
		}

		var_0C = self getweaponammoclip(var_0B) == 0 && isaxeweapon(var_0B);
		if(!isdefined(var_08) && function_0322(var_0B) || var_0C)
		{
			var_08 = var_0B;
		}

		var_09++;
	}

	var_0E = undefined;
	if(isdefined(var_08))
	{
		var_0E = var_08;
	}
	else if(var_09 >= 2)
	{
		var_0E = var_06;
	}

	var_0F = !var_04 || isdefined(var_0E) && issubstr(var_06,var_0E);
	if(isdefined(var_0E))
	{
		var_0C = self getweaponammoclip(var_0E) == 0 && isaxeweapon(var_0E);
		var_10 = var_0E == "iw7_fists_mp";
		var_11 = function_0242(var_0E) && !var_0C;
		if(var_11)
		{
			var_12 = self method_80B8(var_0E);
			if(isdefined(var_12))
			{
				if(isdefined(self.var_119DF[var_0E]))
				{
					var_12.var_222 = self.var_119DF[var_0E];
					self.var_119DF[var_0E] = undefined;
				}
				else
				{
					var_12.var_222 = self;
				}

				var_12.var_336 = "dropped_weapon";
				var_12 thread func_13AF1();
				var_12 thread func_51CC();
			}
		}
		else if(!var_11 && !var_10 && var_09 < 2 && !var_0C && var_09 < 2)
		{
			self takeweapon(var_0E);
		}
	}

	scripts\mp\_utility::func_12C6(var_05);
	self setweaponammoclip(var_05,1);
	if(var_0F)
	{
		scripts\mp\_utility::_switchtoweapon(var_05);
	}

	scripts\mp\_hud_message::func_1013D("axe");
	fixupplayerweapons(self,var_05);
}

//Function Number: 329
callback_finishweaponchange(param_00,param_01,param_02,param_03)
{
	updatecamoscripts(param_00,param_01,param_02,param_03);
	updateholidayweaponsounds(param_00,param_01,param_02,param_03);
	updateweaponscriptvfx(param_00,param_01,param_02,param_03);
	if(level.ingraceperiod > 0)
	{
		thread watchrigchangeforweaponfx(param_00,param_01,param_02,param_03);
	}

	scripts\mp\_missions::monitorweaponpickup(param_00);
}

//Function Number: 330
watchrigchangeforweaponfx(param_00,param_01,param_02,param_03)
{
	self notify("rigChangedDuringGraceperiod");
	self endon("rigChangedDuringGraceperiod");
	self endon("graceperiod_done");
	while(level.ingraceperiod > 0)
	{
		self waittill("changed_kit");
		if(isdefined(param_01) && param_01 != "none")
		{
			updateweaponscriptvfx(param_00,param_01,param_02,param_03);
		}
	}
}

//Function Number: 331
updateholidayweaponsounds(param_00,param_01,param_02,param_03)
{
	var_04 = function_02C4(param_00);
	if(scripts\mp\_class::isholidayweapon(param_00,var_04))
	{
		self method_8460("special_foley","bells",2);
		return;
	}

	self method_8460("special_foley","",0.1);
}

//Function Number: 332
updateweaponscriptvfx(param_00,param_01,param_02,param_03)
{
	if((param_01 == "none" || param_01 == "alt_none") && isdefined(self.var_A978))
	{
		if(param_01 == "alt_none")
		{
			param_03 = 1;
		}
		else
		{
			param_03 = 0;
		}

		param_01 = self.var_A978;
	}

	clearweaponscriptvfx(param_01,param_03);
	runweaponscriptvfx(param_00,param_02);
}

//Function Number: 333
runweaponscriptvfx(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_01) && param_01 == 1)
	{
		var_02 = "alt_" + scripts\mp\_utility::func_821D(param_00);
	}
	else
	{
		var_02 = scripts\mp\_utility::func_821D(param_01);
	}

	switch(var_02)
	{
		case "alt_iw7_rvn_mp":
			self setscriptablepartstate("rvnFXView","VFX_base",0);
			if(lib_0DF8::func_9DDF(self))
			{
				self setscriptablepartstate("rvnFXWorld","activePhase",0);
			}
			else
			{
				self setscriptablepartstate("rvnFXWorld","active",0);
			}
			break;

		case "alt_iw7_rvn_mpl_burst6":
		case "alt_iw7_rvn_mpl":
			self setscriptablepartstate("rvnFXView","VFX_epic",0);
			if(lib_0DF8::func_9DDF(self))
			{
				self setscriptablepartstate("rvnFXWorld","activePhase",0);
			}
			else
			{
				self setscriptablepartstate("rvnFXWorld","active",0);
			}
			break;

		case "alt_iw7_gauss_mpl":
		case "alt_iw7_gauss_mp_burst3":
		case "alt_iw7_gauss_mp_burst2":
		case "alt_iw7_gauss_mp":
		case "iw7_gauss_mp_burst3":
		case "iw7_gauss_mp_burst2":
		case "iw7_gauss_mp":
		case "iw7_gauss_mpl":
			self setscriptablepartstate("gaussFXView","VFX_base",0);
			if(lib_0DF8::func_9DDF(self))
			{
				self setscriptablepartstate("gaussFXWorld","activePhase",0);
			}
			else
			{
				self setscriptablepartstate("gaussFXWorld","active",0);
			}
	
			thread chargefxwatcher();
			break;
	}
}

//Function Number: 334
clearweaponscriptvfx(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(param_01) && param_01 == 1)
	{
		var_02 = "alt_" + scripts\mp\_utility::func_821D(param_00);
	}
	else
	{
		var_02 = scripts\mp\_utility::func_821D(param_01);
	}

	switch(var_02)
	{
		case "alt_iw7_rvn_mp":
			self setscriptablepartstate("rvnFXView","neutral",0);
			self setscriptablepartstate("rvnFXWorld","neutral",0);
			break;

		case "alt_iw7_rvn_mpl_burst6":
		case "alt_iw7_rvn_mpl":
			self setscriptablepartstate("rvnFXView","neutral",0);
			self setscriptablepartstate("rvnFXWorld","neutral",0);
			break;

		case "alt_iw7_gauss_mpl":
		case "alt_iw7_gauss_mp_burst3":
		case "alt_iw7_gauss_mp_burst2":
		case "alt_iw7_gauss_mp":
		case "iw7_gauss_mp_burst3":
		case "iw7_gauss_mp_burst2":
		case "iw7_gauss_mp":
		case "iw7_gauss_mpl":
			self setscriptablepartstate("gaussFXView","neutral",0);
			self setscriptablepartstate("gaussFXWorld","neutral",0);
			self notify("clear_chargeFXWatcher");
			break;
	}
}

//Function Number: 335
chargefxwatcher()
{
	self endon("clear_chargeFXWatcher");
	self setscriptablepartstate("gaussFXWorld","neutral",0);
	thread chargedeathwatcher();
	for(;;)
	{
		if(!scripts\mp\_utility::func_9F19(self))
		{
			break;
		}

		self waittill("weapon_charge_update_tag_count",var_00);
		if(var_00 >= 7)
		{
			self setscriptablepartstate("gaussFXWorld","active",0);
			self waittill("weapon_charge_update_tag_count",var_00);
			self setscriptablepartstate("gaussFXWorld","neutral",0);
		}

		wait(0.1);
	}
}

//Function Number: 336
chargedeathwatcher()
{
	self endon("clear_chargeFXWatcher");
	self waittill("death");
	self setscriptablepartstate("gaussFXWorld","neutral",0);
	self notify("clear_chargeFXWatcher");
}

//Function Number: 337
updatecamoscripts(param_00,param_01,param_02,param_03)
{
	var_04 = function_00E5(param_00);
	var_05 = function_00E5(param_01);
	if(!isdefined(var_04))
	{
		var_04 = "none";
	}

	if(!isdefined(var_05))
	{
		var_05 = "none";
	}

	clearcamoscripts(param_01,var_05);
	runcamoscripts(param_00,var_04);
}

//Function Number: 338
runcamoscripts(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	switch(param_01)
	{
		case "camo31":
			thread mw2_camo_31();
			break;

		case "camo84":
			thread blood_camo_84();
			break;
	}
}

//Function Number: 339
clearcamoscripts(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	switch(param_01)
	{
		case "camo31":
			self notify("mw2_camo_31");
			break;

		case "camo84":
			self notify("blood_camo_84");
			break;
	}
}

//Function Number: 340
mw2_camo_31()
{
	self endon("disconnect");
	self endon("death");
	self endon("mw2_camo_31");
	if(!isdefined(self.pers["mw2CamoKillCount"]))
	{
		self.pers["mw2CamoKillCount"] = 0;
	}

	self setscriptablepartstate("camo_31",self.pers["mw2CamoKillCount"] + "_kills");
	for(;;)
	{
		self waittill("kill_event_buffered");
		self.pers["mw2CamoKillCount"] = self.pers["mw2CamoKillCount"] + 1;
		if(self.pers["mw2CamoKillCount"] > 7)
		{
			self.pers["mw2CamoKillCount"] = 0;
		}

		self setscriptablepartstate("camo_31",self.pers["mw2CamoKillCount"] + "_kills");
	}
}

//Function Number: 341
blood_camo_84()
{
	self endon("disconnect");
	self endon("death");
	self endon("blood_camo_84");
	if(isdefined(self.bloodcamokillcount))
	{
		self setscriptablepartstate("camo_84",self.bloodcamokillcount + "_kills");
	}
	else
	{
		self.bloodcamokillcount = 0;
	}

	while(self.bloodcamokillcount < 13)
	{
		self waittill("kill_event_buffered");
		self.bloodcamokillcount = self.bloodcamokillcount + 1;
		self setscriptablepartstate("camo_84",self.bloodcamokillcount + "_kills");
	}
}