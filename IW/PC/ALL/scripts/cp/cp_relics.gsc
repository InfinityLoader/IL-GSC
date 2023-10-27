/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_relics.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 226
 * Decompile Time: 10763 ms
 * Timestamp: 10/27/2023 12:09:58 AM
*******************************************************************/

//Function Number: 1
func_DEE0()
{
	level.var_12EE0 = ::func_12EDF;
	level.var_12EE2 = ::func_12EE1;
	level.var_12EDE = ::func_12EDD;
	level.var_462E = [];
	if(!isdefined(level.var_CA5B))
	{
		level.var_CA5B = ["perk_machine_tough","perk_machine_revive","perk_machine_flash","perk_machine_more","perk_machine_rat_a_tat","perk_machine_run","perk_machine_fwoosh","perk_machine_smack","perk_machine_zap","perk_machine_boom"];
	}

	level.var_C54A = [];
	level.var_C54A["passive_nuke"] = ::func_11AF4;
	level.var_C54A["passive_random_perks"] = ::trackkillsforrandomperks;
	level.var_C54A["passive_railgun_overload"] = ::dolocalrailgundamage;
	level.var_C54A["passive_overkill"] = ::dolocaloverkilldamage;
	level.var_C54A["passive_headshot_ammo"] = ::func_89AE;
	level.var_C54A["passive_headshot_super"] = ::func_1869;
	level.var_C54A["passive_refresh"] = ::func_89D1;
	level.var_C54A["passive_double_kill_reload"] = ::func_5AE4;
	level.var_C54A["passive_gore"] = ::func_89AB;
	level.var_C54A["passive_health_regen_on_kill"] = ::func_89B1;
	level.var_C54A["passive_move_speed_on_kill"] = ::func_89C8;
	level.var_C54A["passive_hitman"] = ::func_89B3;
	level.var_C54A["passive_meleekill"] = ::handlemeleekillpassive;
	level.var_C54A["passive_health_on_kill"] = ::handlehealthonkillpassive;
	level.var_C54A["passive_last_shots_ammo"] = ::handleammoonlastshotskill;
	level.var_C54A["passive_visor_detonation"] = ::handlevisordetonation;
	level.var_C54A["passive_melee_super"] = ::handlemeleesuper;
	level.var_C54A["passive_jump_super"] = ::handleairbornesuper;
	level.var_C54A["passive_double_kill_super"] = ::handledoublekillssuper;
	level.var_C54A["passive_melee_cone_expl"] = ::handlemeleeconeexplode;
	level.var_C54A["passive_berserk"] = ::handleberserk;
	level.var_C54A["passive_ninja"] = ::handleammoonlastshotskill;
	func_DEDF("passive_railgun_overload",::init_passive_railgun_overload,::set_passive_railgun_overload,::unset_passive_railgun_overload);
	func_DEDF("passive_overkill",::init_passive_overkill,::set_passive_overkill,::unset_passive_overkill);
	func_DEDF("passive_last_shots_ammo",::init_passive_last_shots_ammo,::set_passive_last_shots_ammo,::unset_passive_last_shots_ammo);
	func_DEDF("passive_nuke",::func_96BA,::func_F4C0,::func_12C0D);
	func_DEDF("passive_headshot_ammo",::func_961A,::func_F3FB,::func_12BFF);
	func_DEDF("passive_headshot_super",::func_961B,::func_F3FC,::func_12C00);
	func_DEDF("passive_refresh",::func_96BB,::func_F4C1,::func_12C0E);
	func_DEDF("passive_double_kill_reload",::func_96B1,::func_F4B7,::func_12C04);
	func_DEDF("passive_gore",::func_96B2,::func_F4B8,::func_12C05);
	func_DEDF("passive_meleekill",::init_passive_melee_kill,::set_passive_melee_kill,::unset_passive_melee_kill);
	func_DEDF("passive_health_on_kill",::init_passive_health_on_kill,::set_passive_health_on_kill,::unset_passive_health_on_kill);
	func_DEDF("passive_health_regen_on_kill",::func_96B3,::func_F4B9,::func_12C06);
	func_DEDF("passive_move_speed_on_kill",::func_96B9,::func_F4BF,::func_12C0C);
	func_DEDF("passive_hitman",::func_96B4,::func_F4BA,::func_12C07);
	func_DEDF("passive_score_bonus_kills",::func_96BC,::func_F4C2,::func_12C0F);
	func_DEDF("passive_scorestreak_pack",::func_96BC,::func_F4C2,::func_12C0F);
	func_DEDF("passive_random_perks",::init_passive_random_perks,::set_passive_random_perks,::unset_passive_random_perks);
	func_DEDF("passive_visor_detonation",::init_passive_visor_detonation,::set_passive_visor_detonation,::unset_passive_visor_detonation);
	func_DEDF("passive_melee_super",::init_passive_melee_super,::set_passive_melee_super,::unset_passive_melee_super);
	func_DEDF("passive_jump_super",::init_passive_jump_super,::set_passive_jump_super,::unset_passive_jump_super);
	func_DEDF("passive_double_kill_super",::init_passive_double_kill_super,::set_passive_double_kill_super,::unset_passive_double_kill_super);
	func_DEDF("passive_mode_switch_score",::init_passive_mode_switch_score,::set_passive_mode_switch_score,::unset_passive_mode_switch_score);
	func_DEDF("passive_melee_cone_expl",::init_passive_melee_cone_expl,::set_passive_melee_cone_expl,::unset_passive_melee_cone_expl);
	func_DEDF("passive_berserk",::init_passive_berserk,::set_passive_berserk,::unset_passive_berserk);
	level.var_C5C9 = [];
	level.var_C5C9["passive_infinite_ammo"] = ::func_89B8;
	level.var_C5C9["passive_ninja"] = ::handleninjaonlastshot;
	level.var_C5C9["passive_fortified"] = ::handlefortified;
	func_DEDF("passive_infinite_ammo",::func_96B6,::func_F4BC,::func_12C09);
	func_DEDF("passive_crouch_move_speed",::init_passive_crouch_move_speed,::set_passive_crouch_move_speed,::unset_passive_crouch_move_speed);
	level.var_C4E6 = [];
	level.var_C4E6["passive_sonic"] = ::handlepassivesonic;
	level.var_C4E6["passive_minimap_damage"] = ::updatepassiveminimapdamage;
	level.var_C4E6["passive_cold_damage"] = ::updatepassivecolddamage;
	level.var_C4E6["passive_fire_damage"] = ::updatepassivefiredamage;
	func_DEDF("passive_wallrun_quieter",::init_passive_ninja,::set_passive_ninja,::unset_passive_ninja);
	func_DEDF("passive_slide_blastshield",::init_passive_fortified,::set_passive_fortified,::unset_passive_fortified);
	func_DEDF("passive_cold_damage",::init_passive_cold_damage,::set_passive_cold_damage,::unset_passive_cold_damage);
	func_DEDF("passive_fire_damage",::init_passive_fire_damage,::set_passive_fire_damage,::unset_passive_fire_damage);
	func_DEDF("passive_sonic",::init_passive_sonic,::set_passive_sonic,::unset_passive_sonic);
	func_DEDF("passive_below_the_belt",::func_96B0,::func_F4B5,::func_12C03);
	func_DEDF("passive_minimap_damage",::init_passive_minimap_damage,::set_passive_minimap_damage,::unset_passive_minimap_damage);
	func_DEDF("passive_extra_xp",::func_95D6,::func_F39A,::func_12BF8);
	func_DEDF("passive_fast_melee",::init_passive_fast_melee,::set_passive_fast_melee,::unset_passive_fast_melee);
	func_DEDF("coop_passive_snap_to_head",::func_974D,::func_F5A3,::func_12C62);
	func_DEDF("passive_empty_reload_speed",::init_passive_empty_reload_speed,::set_passive_empty_reload_speed,::unset_passive_empty_reload_speed);
	func_DEDF("passive_increased_scope_breath",::init_passive_increased_scope_breath,::set_passive_increased_scope_breath,::unset_passive_increased_scope_breath);
	func_DEDF("passive_hunter_killer",::func_96B5,::func_F4BB,::func_12C08);
	func_DEDF("passive_move_speed",::func_96B8,::func_F4BE,::func_12C0B);
	func_DEDF("passive_miss_refund",::func_96B7,::func_F4BD,::func_12C0A);
	func_DEDF("passive_scoutping",::func_96BD,::func_F4C3,::func_12C10);
	func_DEDF("passive_scrambler",::init_passive_scrambler,::set_passive_scrambler,::unset_passive_scrambler);
	func_DEDF("passive_random_attachment",::init_passive_random_attachment,::set_passive_random_attachment,::unset_passive_random_attachment);
	func_DEDF("passive_scope_radar",::init_passive_scope_radar,::set_passive_scope_radar,::unset_passive_scope_radar);
	func_DEDF("passive_scorestreak_damage",::init_passive_scorestreak_damage,::set_passive_scorestreak_damage,::unset_passive_scorestreak_damage);
	func_DEDF("passive_scorestreak_damage_e",::init_passive_scorestreak_damage,::set_passive_scorestreak_damage,::unset_passive_scorestreak_damage);
}

//Function Number: 2
init_passive_random_attachment(param_00)
{
	var_01 = getweaponswithpassive(param_00,"passive_random_attachment");
	var_02 = [];
	foreach(var_04 in var_01)
	{
		var_05 = scripts\cp\_utility::func_80D8(var_04);
		var_06 = scripts\cp\_utility::func_8234(var_04);
		var_07 = scripts\cp\_utility::getweaponcamo(var_06);
		var_08 = scripts\cp\_utility::getweaponcosmeticattachment(var_06);
		var_09 = scripts\cp\_utility::getweaponreticle(var_06);
		var_0A = scripts\cp\_utility::getweaponpaintjobid(var_06);
		param_00.var_13C00[var_05] = scripts\cp\_utility::func_BD68(var_06,var_02,var_07,var_09,scripts\cp\_utility::func_7D72(param_00,var_04),self getentitynumber(),self.var_41F0,var_0A,var_08);
	}
}

//Function Number: 3
set_passive_random_attachment(param_00)
{
}

//Function Number: 4
unset_passive_random_attachment(param_00)
{
}

//Function Number: 5
getweaponswithpassive(param_00,param_01)
{
	var_02 = [];
	var_03 = getarraykeys(param_00.var_13C38);
	foreach(var_05 in var_03)
	{
		for(var_06 = 0;var_06 < param_00.var_13C38[var_05].size;var_06++)
		{
			if(param_00.var_13C38[var_05][var_06] == param_01)
			{
				var_02[var_02.size] = var_05;
			}
		}
	}

	var_02 = scripts\common\utility::func_22AF(var_02);
	return var_02;
}

//Function Number: 6
init_passive_fast_melee(param_00)
{
}

//Function Number: 7
set_passive_fast_melee(param_00)
{
	param_00.increased_melee_damage = 150;
}

//Function Number: 8
unset_passive_fast_melee(param_00)
{
	param_00.increased_melee_damage = undefined;
}

//Function Number: 9
func_95D6(param_00)
{
	param_00.var_13C37 = 1;
	param_00.kill_with_extra_xp_passive = 0;
}

//Function Number: 10
func_F39A(param_00)
{
	param_00.var_13C37 = 1.25;
}

//Function Number: 11
func_12BF8(param_00)
{
	param_00.var_13C37 = 1;
	param_00.kill_with_extra_xp_passive = 0;
}

//Function Number: 12
func_96B0(param_00)
{
	param_00.var_4A9A = undefined;
}

//Function Number: 13
func_F4B5(param_00)
{
	param_00.var_4A9A = 3.75;
}

//Function Number: 14
func_12C03(param_00)
{
	param_00.var_4A9A = undefined;
}

//Function Number: 15
func_96B8(param_00)
{
	param_00.var_13C37 = 1;
}

//Function Number: 16
func_F4BE(param_00)
{
	param_00.var_13CB2 = 0.05;
	param_00 [[ level.var_BC70 ]]();
}

//Function Number: 17
func_12C0B(param_00)
{
	param_00.var_13CB2 = undefined;
	param_00 [[ level.var_BC70 ]]();
}

//Function Number: 18
init_passive_empty_reload_speed(param_00)
{
}

//Function Number: 19
set_passive_empty_reload_speed(param_00)
{
	param_00 scripts\cp\_utility::func_13D1("specialty_fastreload_empty");
}

//Function Number: 20
unset_passive_empty_reload_speed(param_00)
{
	param_00 scripts\cp\_utility::func_1430("specialty_fastreload_empty");
}

//Function Number: 21
init_passive_increased_scope_breath(param_00)
{
}

//Function Number: 22
set_passive_increased_scope_breath(param_00)
{
	param_00 scripts\cp\_utility::func_13D1("specialty_holdbreath");
}

//Function Number: 23
unset_passive_increased_scope_breath(param_00)
{
	param_00 scripts\cp\_utility::func_1430("specialty_holdbreath");
}

//Function Number: 24
func_974D(param_00)
{
}

//Function Number: 25
func_F5A3(param_00)
{
	param_00 scripts\cp\_utility::func_13D1("specialty_autoaimhead");
}

//Function Number: 26
func_12C62(param_00)
{
	param_00 scripts\cp\_utility::func_1430("specialty_autoaimhead");
}

//Function Number: 27
func_96B5(param_00)
{
	self.var_91EE = 0;
}

//Function Number: 28
func_F4BB(param_00)
{
	self endon("passive_hunter_killer_cancel");
	var_01 = scripts\cp\_agent_utils::func_7DB0("axis");
	thread func_12EAE(var_01);
	thread func_91EA();
	foreach(param_00 in var_01)
	{
		thread func_91EC(param_00);
		thread func_91EB(param_00);
	}
}

//Function Number: 29
func_12C08(param_00)
{
	self notify("passive_hunter_killer_cancel");
	foreach(var_02 in self.var_91E9)
	{
		param_00 = self.var_91E8[var_02];
		scripts\cp\_outline::func_5562(param_00,level.players);
	}

	self.var_91E9 = undefined;
	self.var_91E8 = undefined;
}

//Function Number: 30
func_12EAE(param_00)
{
	if(!isdefined(self.var_91E9))
	{
		self.var_91E9 = [];
	}

	if(!isdefined(self.var_91E8))
	{
		self.var_91E8 = [];
	}

	foreach(var_02 in param_00)
	{
		if(var_02 == self || !isdefined(self) || !isdefined(self.team) || !isdefined(var_02) || !isdefined(var_02.team))
		{
			continue;
		}

		var_03 = func_7F09(var_02);
		if(level.teambased && self.team != var_02.team && var_02.health / var_02.maxhealth <= 0.5 && var_02.health > 0)
		{
			if(var_03 < 0)
			{
				self.var_91EE++;
				scripts\cp\_outline::func_6220(var_02,self,1,0,1,"high");
				var_04 = self.var_91EE;
				self.var_91E9[self.var_91E9.size] = var_04;
				self.var_91E8[var_04] = var_02;
				thread func_91ED(var_02);
			}

			continue;
		}

		if(var_03 >= 0)
		{
			var_05 = [];
			var_06 = [];
			scripts\cp\_outline::func_5561(var_02,self);
			foreach(var_04 in self.var_91E9)
			{
				var_08 = self.var_91E8[var_04];
				if(var_08 == var_02)
				{
					continue;
				}

				var_05[var_05.size] = var_04;
				var_06[var_04] = var_08;
			}

			self.var_91E9 = var_05;
			self.var_91E8 = var_06;
			var_02 notify("passive_hunter_killer_listen_cancel");
		}
	}
}

//Function Number: 31
func_91ED(param_00)
{
	self endon("passive_hunter_killer_cancel");
	param_00 endon("passive_hunter_killer_listen_cancel");
	for(;;)
	{
		wait(1);
		thread func_12EAD(param_00);
	}
}

//Function Number: 32
func_7F09(param_00)
{
	if(!isdefined(self.var_91E9) || !isdefined(self.var_91E8))
	{
		return -1;
	}

	foreach(var_02 in self.var_91E9)
	{
		var_03 = self.var_91E8[var_02];
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03 == param_00)
		{
			return var_02;
		}
	}

	return -1;
}

//Function Number: 33
func_91EA()
{
	self endon("passive_hunter_killer_cancel");
	for(;;)
	{
		level waittill("agent_spawned",var_00);
		thread func_12EAD(var_00);
		thread func_91EB(var_00);
	}
}

//Function Number: 34
func_91EC(param_00)
{
	self endon("passive_hunter_killer_cancel");
	param_00 waittill("disconnect");
	thread func_12EAD(param_00);
}

//Function Number: 35
func_91EB(param_00)
{
	self endon("passive_hunter_killer_cancel");
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		thread func_12EAD(param_00);
	}
}

//Function Number: 36
func_12EAD(param_00)
{
	var_01 = [];
	var_01[var_01.size] = param_00;
	thread func_12EAE(var_01);
}

//Function Number: 37
func_96BB(param_00)
{
	param_00.var_BFA0 = 0;
}

//Function Number: 38
func_F4C1(param_00)
{
	param_00.var_C54A["passive_refresh"] = 1;
}

//Function Number: 39
func_12C0E(param_00)
{
	param_00.var_C54A["passive_refresh"] = 0;
}

//Function Number: 40
func_89D1(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_01.var_BFA0++;
	if(param_01.var_BFA0 >= 50)
	{
		param_01 scripts\cp\powers\coop_powers::func_D71A(undefined,"primary",1);
		param_01.var_BFA0 = 0;
	}
}

//Function Number: 41
func_96B1(param_00)
{
	if(!isdefined(param_00.var_5AD5))
	{
		param_00.var_5AD5 = [];
	}
}

//Function Number: 42
func_F4B7(param_00)
{
	param_00.var_C54A["passive_double_kill_reload"] = 1;
	if(!isdefined(param_00.var_5AD5[getweaponbasename(param_00 getcurrentweapon())]))
	{
		param_00.var_5AD5[getweaponbasename(param_00 getcurrentweapon())] = getweaponbasename(param_00 getcurrentweapon());
	}
}

//Function Number: 43
func_12C04(param_00)
{
	param_00.var_C54A["passive_double_kill_reload"] = 0;
}

//Function Number: 44
func_5AE4(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!scripts\common\utility::func_2286(param_01.var_5AD5,getweaponbasename(param_00)))
	{
		return;
	}

	if(param_01.var_DDC2 == 4)
	{
		var_06 = weaponclipsize(param_00);
		var_07 = param_01 getweaponammostock(param_00);
		var_08 = param_01 getweaponammoclip(param_00);
		var_09 = min(var_06 - var_08,var_07);
		var_0A = min(var_08 + var_09,var_06);
		param_01 setweaponammoclip(param_00,int(var_0A));
		param_01 setweaponammostock(param_00,int(var_07 - var_09));
		if(param_01 method_819C())
		{
			var_07 = param_01 getweaponammostock(param_00);
			var_08 = param_01 getweaponammoclip(param_00,"left");
			var_09 = min(var_06 - var_08,var_07);
			var_0A = min(var_08 + var_09,var_06);
			param_01 setweaponammoclip(param_00,int(var_0A),"left");
			param_01 setweaponammostock(param_00,int(var_07 - var_09));
		}
	}
}

//Function Number: 45
init_passive_melee_kill(param_00)
{
	param_00.passive_melee_kill_damage = 0;
}

//Function Number: 46
set_passive_melee_kill(param_00)
{
	param_00.skip_weapon_check = 1;
	param_00.passive_melee_kill_damage = 1000;
	param_00.var_C54A["passive_meleekill"] = 1;
}

//Function Number: 47
unset_passive_melee_kill(param_00)
{
	param_00.skip_weapon_check = undefined;
	param_00.passive_melee_kill_damage = 0;
	param_00.var_C54A["passive_meleekill"] = 0;
}

//Function Number: 48
handlemeleekillpassive(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("game_ended");
	self endon("disconnect");
	if(param_03 != "MOD_MELEE")
	{
		return;
	}

	level thread func_89AA(param_02);
	wait(0.05);
	var_06 = param_02 method_8113();
	if(isdefined(var_06))
	{
		var_06 hide();
		var_06.var_CA6C = 1;
	}
}

//Function Number: 49
func_89AA(param_00)
{
	var_01 = param_00 gettagorigin("j_spine4");
	playfx(level._effect["gore"],var_01,(1,0,0));
	playsoundatpos(var_01,"gib_fullbody");
	foreach(var_03 in level.players)
	{
		var_03 earthquakeforplayer(0.5,1.5,var_01,120);
	}
}

//Function Number: 50
func_96B2(param_00)
{
}

//Function Number: 51
func_F4B8(param_00)
{
	param_00.var_C54A["passive_gore"] = 1;
}

//Function Number: 52
func_12C05(param_00)
{
	param_00.var_C54A["passive_gore"] = 0;
}

//Function Number: 53
func_89AB(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("game_ended");
	self endon("disconnect");
	param_02 endon("diconnect");
	wait(0.05);
	var_06 = param_02 method_8113();
	if(!isdefined(var_06))
	{
		return;
	}

	var_07 = var_06.origin;
	earthquake(0.5,1.5,var_07,120);
	playfx(level._effect["corpse_pop"],var_07 + (0,0,12));
	if(isdefined(var_06))
	{
		var_06 hide();
		var_06.var_CA6C = 1;
	}
}

//Function Number: 54
init_passive_health_on_kill(param_00)
{
	param_00.var_C93F = 0;
}

//Function Number: 55
set_passive_health_on_kill(param_00)
{
	param_00.var_C54A["passive_health_on_kill"] = 1;
}

//Function Number: 56
unset_passive_health_on_kill(param_00)
{
	param_00.var_C54A["passive_health_on_kill"] = 0;
}

//Function Number: 57
handlehealthonkillpassive(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_01.var_C93F++;
	if(param_01.var_C93F >= 2)
	{
		param_01 notify("force_regeneration");
		param_01.var_C93F = 0;
	}
}

//Function Number: 58
func_96B3(param_00)
{
	param_00.var_C93F = 0;
}

//Function Number: 59
func_F4B9(param_00)
{
	param_00.var_C54A["passive_health_regen_on_kill"] = 1;
}

//Function Number: 60
func_12C06(param_00)
{
	param_00.var_C54A["passive_health_regen_on_kill"] = 0;
}

//Function Number: 61
func_89B1(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(param_01.var_C93F >= 2)
	{
		param_01 notify("force_regeneration");
		param_01.var_C93F = 0;
		return;
	}

	param_01.var_C93F++;
}

//Function Number: 62
func_96B9(param_00)
{
	param_00.var_13CB3 = 0;
}

//Function Number: 63
func_F4BF(param_00)
{
	param_00.var_C54A["passive_move_speed_on_kill"] = 1;
}

//Function Number: 64
func_12C0C(param_00)
{
	param_00.var_C54A["passive_move_speed_on_kill"] = 0;
}

//Function Number: 65
func_89C8(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = "passive_move_speed_on_kill";
	param_01 notify(var_06);
	param_01 endon(var_06);
	if(param_01.var_13CB3 != 0.075)
	{
		param_01.var_13CB3 = 0.075;
		param_01 [[ level.var_BC70 ]]();
	}

	param_01 scripts\common\utility::waittill_any_timeout_1(5,"death","disconnect");
	if(!isdefined(param_01))
	{
		return;
	}

	param_01.var_13CB3 = 0;
	param_01 [[ level.var_BC70 ]]();
}

//Function Number: 66
func_96BC(param_00)
{
}

//Function Number: 67
func_F4C2(param_00)
{
	param_00.var_3B0F = param_00.var_3B0F + 0.1;
	param_00.cash_scalar_weapon = scripts\cp\_utility::func_80D8(param_00 getcurrentweapon());
}

//Function Number: 68
func_12C0F(param_00)
{
	param_00.var_3B0F = param_00.var_3B0F - 0.1;
	param_00.cash_scalar_weapon = undefined;
}

//Function Number: 69
func_96B4(param_00)
{
}

//Function Number: 70
func_F4BA(param_00)
{
	param_00.var_C54A["passive_hitman"] = 1;
}

//Function Number: 71
func_12C07(param_00)
{
	param_00.var_C54A["passive_hitman"] = 0;
}

//Function Number: 72
func_89B3(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_01) || !scripts\cp\_utility::func_9F19(param_01) || !isdefined(param_02))
	{
		return;
	}

	if(!isdefined(param_01.var_903C))
	{
		param_01.var_903C = [];
	}
	else if(func_903B(param_01,param_02.var_64))
	{
		return;
	}

	param_01 thread func_E252();
	param_01.var_903C[param_01.var_903C.size] = param_02.var_64;
	if(param_01.var_903C.size >= 10)
	{
		param_01 notify("consumable_charge",200);
		param_01.var_903C = [];
	}
}

//Function Number: 73
func_E252()
{
	self notify("hitman_timeout");
	self endon("hitman_timeout");
	self endon("death");
	level endon("game_ended");
	wait(10);
	self.var_903C = [];
}

//Function Number: 74
func_903B(param_00,param_01)
{
	if(!isdefined(param_00.var_903C))
	{
		return 0;
	}

	foreach(var_03 in param_00.var_903C)
	{
		if(var_03 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 75
func_903D()
{
	self endon("disconnect");
	self waittill("death");
	self.var_903C = undefined;
}

//Function Number: 76
func_96BA(param_00)
{
	param_00.var_C944 = 0;
	param_00.var_A9CA = 0;
	param_00 thread func_11AF6(param_00);
}

//Function Number: 77
func_F4C0(param_00)
{
	param_00.var_C54A["passive_nuke"] = 1;
}

//Function Number: 78
func_12C0D(param_00)
{
	param_00.var_C54A["passive_nuke"] = 0;
}

//Function Number: 79
func_11AF4(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_01.var_C944++;
	if(param_01.var_C944 >= 150 && param_01.var_A9CA + 3 <= level.wave_num)
	{
		param_01.var_C944 = 0;
		level scripts\cp\zombies\_powerups::drop_loot(param_01.origin,param_01,"kill_50",1,undefined,1);
	}
}

//Function Number: 80
func_11AF6(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("last_stand");
		param_00.var_C944 = 0;
	}
}

//Function Number: 81
func_961A(param_00)
{
}

//Function Number: 82
func_F3FB(param_00)
{
	param_00.var_C54A["passive_headshot_ammo"] = 1;
}

//Function Number: 83
func_12BFF(param_00)
{
	param_00.var_C54A["passive_headshot_ammo"] = 0;
}

//Function Number: 84
func_89AE(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_01) || !isdefined(param_00))
	{
		return;
	}

	if(!scripts\cp\_utility::func_9E27(param_00,param_04,param_03,param_01))
	{
		return;
	}

	var_06 = weaponclipsize(param_00);
	adjust_clip_ammo_from_stock(param_01,param_00,"right",var_06);
	if(param_01 method_819C())
	{
		adjust_clip_ammo_from_stock(param_01,param_00,"left",var_06);
	}
}

//Function Number: 85
adjust_clip_ammo_from_stock(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 getweaponammostock(param_01);
	if(var_04 < 1)
	{
		return;
	}

	var_05 = param_00 getweaponammoclip(param_01,param_02);
	var_06 = param_03 - var_05;
	if(var_04 >= var_06)
	{
		param_00 setweaponammostock(param_01,var_04 - var_06);
	}
	else
	{
		var_06 = var_04;
		param_00 setweaponammostock(param_01,0);
	}

	var_07 = min(var_05 + var_06,param_03);
	param_00 setweaponammoclip(param_01,int(var_07),param_02);
}

//Function Number: 86
init_passive_fortified(param_00)
{
	param_00.has_fortified_passive = 0;
}

//Function Number: 87
set_passive_fortified(param_00)
{
	param_00.var_C5C9["passive_fortified"] = 1;
	param_00.has_fortified_passive = 1;
}

//Function Number: 88
unset_passive_fortified(param_00)
{
	param_00.var_C5C9["passive_fortified"] = 0;
	param_00.has_fortified_passive = 0;
}

//Function Number: 89
handlefortified(param_00,param_01,param_02)
{
}

//Function Number: 90
init_passive_ninja(param_00)
{
}

//Function Number: 91
set_passive_ninja(param_00)
{
	param_00.stealth_used = [];
	param_00.var_C5C9["passive_ninja"] = 1;
}

//Function Number: 92
unset_passive_ninja(param_00)
{
	param_00.var_C5C9["passive_ninja"] = 0;
	param_00 notify("reset_stealth");
	if(param_00 scripts\cp\_utility::func_9E3A())
	{
		param_00 scripts\cp\_utility::func_1C5C(0);
	}
}

//Function Number: 93
handleninjaonlastshot(param_00,param_01,param_02)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return;
	}

	var_03 = weaponclipsize(param_01);
	var_04 = param_00 getweaponammoclip(param_01,"right");
	if(var_04 == 0)
	{
		param_00 thread set_player_stealthed();
	}

	if(var_04 == 0 && !scripts\common\utility::func_2286(param_00.stealth_used,"right"))
	{
		param_00 thread set_player_stealthed();
	}
	else if(var_04 > 0)
	{
		param_00.stealth_used = scripts\common\utility::func_22A9(param_00.stealth_used,"right");
	}

	if(param_00 method_819C())
	{
		var_05 = param_00 getweaponammoclip(param_01,"left");
		if(var_05 == 0 && !scripts\common\utility::func_2286(param_00.stealth_used,"left"))
		{
			param_00 thread set_player_stealthed();
			return;
		}

		if(var_05 > 0)
		{
			param_00.stealth_used = scripts\common\utility::func_22A9(param_00.stealth_used,"left");
			return;
		}
	}
}

//Function Number: 94
set_player_stealthed()
{
	self notify("reset_stealth");
	self endon("reset_stealth");
	self endon("disconnect");
	if(!scripts\cp\_utility::func_9E3A())
	{
		scripts\cp\_utility::func_1C5C(1);
	}

	playfx(level._effect["stimulus_glow_burst"],scripts\common\utility::func_5D14(self.origin) - (0,0,30));
	scripts\common\utility::play_sound_in_space("zmb_fnf_stimulus",scripts\common\utility::func_5D14(self.origin));
	if(self method_819C())
	{
		wait(3);
	}
	else
	{
		wait(4);
	}

	if(scripts\cp\_utility::func_9E3A())
	{
		scripts\cp\_utility::func_1C5C(0);
	}
}

//Function Number: 95
init_passive_last_shots_ammo(param_00)
{
}

//Function Number: 96
set_passive_last_shots_ammo(param_00)
{
	param_00.var_C54A["passive_ninja"] = 1;
}

//Function Number: 97
unset_passive_last_shots_ammo(param_00)
{
	param_00.var_C54A["passive_ninja"] = 0;
}

//Function Number: 98
handleammoonlastshotskill(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_01) || !isdefined(param_00))
	{
		return;
	}

	var_06 = weaponclipsize(param_00);
	var_07 = param_01 getweaponammoclip(param_00,"right");
	if(var_07 <= int(var_06 * 0.2))
	{
		adjust_clip_ammo_from_stock(param_01,param_00,"right",var_06);
	}

	if(param_01 method_819C())
	{
		var_07 = param_01 getweaponammoclip(param_00,"left");
		if(var_07 <= int(var_06 * 0.2))
		{
			adjust_clip_ammo_from_stock(param_01,param_00,"left",var_06);
		}
	}
}

//Function Number: 99
init_passive_overkill(param_00)
{
}

//Function Number: 100
set_passive_overkill(param_00)
{
	param_00.var_C54A["passive_overkill"] = 1;
}

//Function Number: 101
unset_passive_overkill(param_00)
{
	param_00.var_C54A["passive_overkill"] = 0;
}

//Function Number: 102
dolocaloverkilldamage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!scripts\common\utility::func_9D74(param_03))
	{
		return 0;
	}

	if(isdefined(param_02.agent_type) && param_02.agent_type == "zombie_brute" || param_02.agent_type == "zombie_grey" || param_02.agent_type == "slasher" || param_02.agent_type == "superslasher" || param_02.agent_type == "zombie_sasquatch" || param_02.agent_type == "lumberjack")
	{
		return;
	}

	var_06 = scripts\common\utility::istrue(param_02.var_9CDD);
	param_02.head_is_exploding = 1;
	var_07 = param_02 gettagorigin("j_spine4");
	playsoundatpos(param_02.origin,"zmb_fnf_headpopper_explo");
	playfx(level._effect["bloody_death"],var_07);
	foreach(param_01 in level.players)
	{
		if(distance(param_01.origin,var_07) <= 350)
		{
			param_01 thread scripts\cp\zombies\zmb_zombies_weapons::func_10142();
		}
	}

	if(isdefined(param_02.var_8C98))
	{
		param_02 detach(param_02.var_8C98);
	}

	if(!var_06)
	{
		param_02 setscriptablepartstate("head","hide");
	}

	var_0A = scripts\common\utility::func_782F(param_02.origin,level.spawned_enemies,[param_02],undefined,64,1);
	foreach(var_0C in var_0A)
	{
		var_0C dodamage(param_02.maxhealth,param_02.origin,param_01,param_01,"MOD_EXPLOSIVE","iw7_walkietalkie_zm");
	}
}

//Function Number: 103
init_passive_railgun_overload(param_00)
{
}

//Function Number: 104
set_passive_railgun_overload(param_00)
{
	param_00.var_C54A["passive_railgun_overload"] = 1;
}

//Function Number: 105
unset_passive_railgun_overload(param_00)
{
	param_00.var_C54A["passive_railgun_overload"] = 0;
}

//Function Number: 106
dolocalrailgundamage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_02.hitbychargedshot))
	{
		return 0;
	}

	param_02.hitbychargedshot = undefined;
	if(!scripts\common\utility::func_9D74(param_03))
	{
		return 0;
	}

	if(isdefined(param_02.agent_type) && param_02.agent_type == "zombie_brute" || param_02.agent_type == "zombie_grey" || param_02.agent_type == "slasher" || param_02.agent_type == "superslasher" || param_02.agent_type == "zombie_sasquatch" || param_02.agent_type == "lumberjack")
	{
		return;
	}

	var_06 = scripts\common\utility::istrue(param_02.var_9CDD);
	param_02.head_is_exploding = 1;
	var_07 = param_02 gettagorigin("j_spine4");
	playsoundatpos(param_02.origin,"zmb_fnf_headpopper_explo");
	playfx(level._effect["bloody_death"],var_07);
	foreach(param_01 in level.players)
	{
		if(distance(param_01.origin,var_07) <= 350)
		{
			param_01 thread scripts\cp\zombies\zmb_zombies_weapons::func_10142();
		}
	}

	if(isdefined(param_02.var_8C98))
	{
		param_02 detach(param_02.var_8C98);
	}

	if(!var_06)
	{
		param_02 setscriptablepartstate("head","hide");
	}

	var_0A = scripts\common\utility::func_782F(param_02.origin,level.spawned_enemies,[param_02],undefined,64,1);
	foreach(var_0C in var_0A)
	{
		var_0C dodamage(param_02.maxhealth,param_02.origin,param_01,param_01,"MOD_EXPLOSIVE","iw7_walkietalkie_zm");
	}
}

//Function Number: 107
func_961B(param_00)
{
	param_00.delayedsuperbonus = 0;
}

//Function Number: 108
func_F3FC(param_00)
{
	param_00.var_C54A["passive_headshot_super"] = 1;
}

//Function Number: 109
func_12C00(param_00)
{
	param_00.var_C54A["passive_headshot_super"] = 0;
}

//Function Number: 110
func_1869(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_01.delayedsuperbonus++;
	wait(0.05 * param_01.delayedsuperbonus);
	param_01.delayedsuperbonus--;
	if(param_01.delayedsuperbonus < 0)
	{
		param_01.delayedsuperbonus = 0;
	}

	param_01 notify("consumable_charge",10);
}

//Function Number: 111
init_passive_sonic(param_00)
{
	param_00.sonictimer = 0;
}

//Function Number: 112
set_passive_sonic(param_00)
{
	param_00.var_C4E6["passive_sonic"] = 1;
}

//Function Number: 113
unset_passive_sonic(param_00)
{
	param_00.var_C4E6["passive_sonic"] = 0;
}

//Function Number: 114
handlepassivesonic(param_00,param_01,param_02)
{
	var_03 = gettime();
	if(param_02 scripts\cp\_utility::agentisfnfimmune())
	{
		return;
	}

	if(var_03 <= param_00.sonictimer)
	{
		return;
	}

	if(distance2dsquared(param_00.origin,param_02.origin) <= -3036)
	{
		thread scripts\cp\_weapon::func_75FA(param_02,param_00);
	}

	param_00.sonictimer = var_03 + 1000;
}

//Function Number: 115
init_passive_crouch_move_speed(param_00)
{
}

//Function Number: 116
set_passive_crouch_move_speed(param_00)
{
	param_00 thread adjust_move_speed_while_crouched(param_00);
	param_00 thread adjust_move_speed_while_sliding(param_00);
}

//Function Number: 117
unset_passive_crouch_move_speed(param_00)
{
	param_00 notify("remove_crouch_speed_mod");
	param_00.var_13CB2 = undefined;
}

//Function Number: 118
adjust_move_speed_while_sliding(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("remove_crouch_speed_mod");
	for(;;)
	{
		self waittill("sprint_slide_end");
		if(param_00 getstance() == "crouch")
		{
			if(isdefined(level.var_BC70))
			{
				param_00.var_13CB2 = 0.5;
				param_00 [[ level.var_BC70 ]]();
			}
		}

		while(param_00 getstance() == "crouch")
		{
			wait(0.1);
		}

		param_00.var_13CB2 = undefined;
		param_00 [[ level.var_BC70 ]]();
	}
}

//Function Number: 119
adjust_move_speed_while_crouched(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("remove_crouch_speed_mod");
	for(;;)
	{
		if(param_00 getstance() == "crouch")
		{
			if(isdefined(level.var_BC70))
			{
				param_00.var_13CB2 = 0.5;
				param_00 [[ level.var_BC70 ]]();
			}
		}

		while(param_00 getstance() == "crouch")
		{
			wait(0.1);
		}

		param_00.var_13CB2 = undefined;
		param_00 [[ level.var_BC70 ]]();
		param_00 waittill("adjustedStance");
	}
}

//Function Number: 120
func_96B6(param_00)
{
}

//Function Number: 121
func_F4BC(param_00)
{
	param_00 scripts\cp\_utility::enable_infinite_ammo(1);
	param_00.var_C5C9["passive_infinite_ammo"] = 1;
}

//Function Number: 122
func_12C09(param_00)
{
	param_00 scripts\cp\_utility::enable_infinite_ammo(0);
	param_00.var_C5C9["passive_infinite_ammo"] = 0;
}

//Function Number: 123
func_89B8(param_00,param_01)
{
	param_00 thread func_AD6F(param_01);
	var_02 = 4;
	var_03 = self.health;
	if(var_03 - var_02 < 1)
	{
		var_02 = var_03 - 1;
	}

	if(var_02 > 0)
	{
		param_00 dodamage(var_02,param_00 gettagorigin("j_wrist_ri"),param_00,undefined,"MOD_RIFLE_BULLET","iw7_pickup_zm");
	}

	param_00 func_12EB2(param_01);
}

//Function Number: 124
func_AD6F(param_00)
{
	self endon("disconnect");
	self notify("infinite_ammo_fire");
	self endon("infinite_ammo_fire");
	self.var_F1E8 = 1;
	wait(0.2);
	self.var_F1E8 = 0;
}

//Function Number: 125
func_12EB2(param_00)
{
	var_01 = self.health;
	var_02 = weaponclipsize(param_00);
	self setweaponammoclip(param_00,var_02);
	if(self method_819C())
	{
		self setweaponammoclip(param_00,var_02,"left");
	}
}

//Function Number: 126
func_96B7(param_00)
{
}

//Function Number: 127
func_F4BD(param_00)
{
	var_01 = param_00 getcurrentweapon();
	param_00 thread func_B8D5(var_01);
}

//Function Number: 128
func_12C0A(param_00)
{
	param_00 notify("removeMissRefundPassive");
}

//Function Number: 129
func_B8D5(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeMissRefundPassive");
	for(;;)
	{
		self waittill("shot_missed",var_01);
		if(var_01 == param_00)
		{
			if(randomfloat(1) > 0.75)
			{
				var_02 = self getweaponammostock(param_00);
				self setweaponammostock(param_00,var_02 + 1);
			}
		}
	}
}

//Function Number: 130
init_passive_scrambler(param_00)
{
}

//Function Number: 131
set_passive_scrambler(param_00)
{
	param_00 thread handlepassivescrambler(param_00);
}

//Function Number: 132
unset_passive_scrambler(param_00)
{
	param_00 notify("handlePassiveScrambler");
}

//Function Number: 133
scrambler_executevisuals(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	var_01 = spawn("script_model",self gettagorigin("tag_eye"));
	var_01 setmodel("prop_mp_optic_wave_scr");
	var_01.angles = self getplayerangles();
	var_01 method_831F(self);
	var_01 setscriptablepartstate("effects","active",0);
	var_02 = var_01.origin + anglestoforward(var_01.angles) * 256;
	var_01 moveto(var_02,param_00);
	scripts\common\utility::waittill_any_timeout_1(param_00,"last_stand","death");
	if(isdefined(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 134
handlepassivescrambler(param_00)
{
	param_00 notify("handlePassiveScrambler");
	param_00 endon("handlePassiveScrambler");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	param_00 endon("death");
	for(;;)
	{
		if(randomint(100) > 85)
		{
			var_01 = scripts\cp\_agent_utils::func_7DB0("axis");
			var_02 = scripts\common\utility::func_782F(param_00.origin,var_01,undefined,24,256);
			var_03 = 0;
			foreach(var_05 in var_02)
			{
				if(scripts\common\utility::func_13D90(param_00 geteye(),param_00.angles,var_05.origin,cos(65)))
				{
					if(!var_03)
					{
						param_00 thread scrambler_executevisuals(0.8);
					}

					thread scrambler_stun_damage(var_05,param_00);
					var_03++;
				}

				if(var_03 >= 5)
				{
					break;
				}
			}
		}

		wait(randomfloatrange(5,10));
	}
}

//Function Number: 135
scrambler_stun_damage(param_00,param_01)
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

	param_00 dodamage(1,param_00.origin,param_01,param_01,"MOD_UNKNOWN","iw7_scrambler_zm");
	param_00 thread addhealthback(param_00);
	wait(1);
	if(param_00 lib_0F74::func_9D9E())
	{
		param_00.var_EF64 = 0;
		param_00.var_180 = 0;
	}

	param_00.allowpain = 0;
	param_00.var_11196 = undefined;
}

//Function Number: 136
addhealthback(param_00)
{
	param_00 endon("death");
	waittillframeend;
	if(param_00.health < param_00.maxhealth)
	{
		param_00.health = param_00.health + 1;
	}
}

//Function Number: 137
init_passive_random_perks(param_00)
{
	param_00.passiverandomperkskillcount = 0;
	param_00 thread tracklaststandforpassiverandomperks(param_00);
}

//Function Number: 138
tracklaststandforpassiverandomperks(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	for(;;)
	{
		param_00 waittill("last_stand");
		param_00.passiverandomperkskillcount = 0;
	}
}

//Function Number: 139
set_passive_random_perks(param_00)
{
	param_00.var_C54A["passive_random_perks"] = 1;
}

//Function Number: 140
trackkillsforrandomperks(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_01 endon("disconnect");
	param_01 endon("last_stand");
	param_01 endon("death");
	param_01.passiverandomperkskillcount++;
	if(param_01.passiverandomperkskillcount >= 75)
	{
		var_06 = level.var_CA5B;
		param_01.passiverandomperkskillcount = 0;
		if(!isdefined(param_01.var_13FA4) || param_01.var_13FA4.size < 5)
		{
			for(;;)
			{
				var_07 = scripts\common\utility::random(var_06);
				if(!param_01 scripts\cp\_utility::has_zombie_perk(var_07))
				{
					param_01 lib_0D5D::func_834E(var_07,0);
					break;
				}
				else
				{
					var_06 = scripts\common\utility::func_22A9(var_06,var_07);
				}

				scripts\common\utility::func_136F7();
			}
		}
	}
}

//Function Number: 141
unset_passive_random_perks(param_00)
{
	param_00.var_C54A["passive_random_perks"] = 0;
}

//Function Number: 142
init_passive_melee_super(param_00)
{
}

//Function Number: 143
set_passive_melee_super(param_00)
{
	param_00.skip_weapon_check = 1;
	param_00.var_C54A["passive_melee_super"] = 1;
}

//Function Number: 144
unset_passive_melee_super(param_00)
{
	param_00.skip_weapon_check = undefined;
	param_00.var_C54A["passive_melee_super"] = 0;
}

//Function Number: 145
handlemeleesuper(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("game_ended");
	param_01 endon("disconnect");
	if(isdefined(param_03) && param_03 == "MOD_MELEE")
	{
		param_01 notify("consumable_charge",125);
	}
}

//Function Number: 146
init_passive_jump_super(param_00)
{
}

//Function Number: 147
set_passive_jump_super(param_00)
{
	param_00.var_C54A["passive_jump_super"] = 1;
	param_00.current_weapon_jump_super = scripts\cp\_utility::func_80D8(param_00 getcurrentweapon());
}

//Function Number: 148
unset_passive_jump_super(param_00)
{
	param_00.var_C54A["passive_jump_super"] = 0;
	param_00.current_weapon_jump_super = undefined;
}

//Function Number: 149
handleairbornesuper(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("game_ended");
	param_01 endon("disconnect");
	if(!param_01 isonground() && isdefined(param_01.current_weapon_jump_super) && scripts\cp\_utility::func_80D8(param_00) == param_01.current_weapon_jump_super)
	{
		param_01 notify("consumable_charge",75);
	}
}

//Function Number: 150
init_passive_double_kill_super(param_00)
{
}

//Function Number: 151
set_passive_double_kill_super(param_00)
{
	param_00.var_C54A["passive_double_kill_super"] = 1;
	param_00.current_weapon_double_super = scripts\cp\_utility::func_80D8(param_00 getcurrentweapon());
}

//Function Number: 152
unset_passive_double_kill_super(param_00)
{
	param_00.var_C54A["passive_double_kill_super"] = 0;
	param_00.current_weapon_double_super = undefined;
}

//Function Number: 153
handledoublekillssuper(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level endon("game_ended");
	param_01 endon("disconnect");
	if(isdefined(param_01.var_DDC2) && isdefined(param_01.current_weapon_double_super) && scripts\cp\_utility::func_80D8(param_00) == param_01.current_weapon_double_super)
	{
		if(param_01.var_DDC2 == 2)
		{
			param_01 notify("consumable_charge",125);
		}
	}
}

//Function Number: 154
init_passive_mode_switch_score(param_00)
{
}

//Function Number: 155
set_passive_mode_switch_score(param_00)
{
	param_00.alt_mode_passive = 1;
	param_00.cash_scalar_alt_weapon = scripts\cp\_utility::func_80D8(param_00 getcurrentweapon());
	param_00.var_3B0F = param_00.var_3B0F + 0.1;
}

//Function Number: 156
unset_passive_mode_switch_score(param_00)
{
	param_00.var_3B0F = param_00.var_3B0F - 0.1;
	param_00.cash_scalar_alt_weapon = undefined;
	param_00.alt_mode_passive = 0;
}

//Function Number: 157
init_passive_visor_detonation(param_00)
{
}

//Function Number: 158
set_passive_visor_detonation(param_00)
{
	param_00.var_C54A["passive_visor_detonation"] = 1;
}

//Function Number: 159
unset_passive_visor_detonation(param_00)
{
	param_00.var_C54A["passive_visor_detonation"] = 0;
}

//Function Number: 160
handlevisordetonation(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!scripts\common\utility::func_9D74(param_03))
	{
		return 0;
	}

	if(!scripts\cp\_utility::func_9E27(param_00,param_04,param_03,param_01))
	{
		return 0;
	}

	if(isdefined(param_02.agent_type) && param_02.agent_type == "zombie_brute" || param_02.agent_type == "zombie_grey" || param_02.agent_type == "slasher" || param_02.agent_type == "superslasher" || param_02.agent_type == "zombie_sasquatch" || param_02.agent_type == "lumberjack")
	{
		return;
	}

	var_06 = scripts\common\utility::istrue(param_02.var_9CDD);
	param_02.head_is_exploding = 1;
	var_07 = param_02 gettagorigin("j_spine4");
	playsoundatpos(param_02.origin,"zmb_fnf_headpopper_explo");
	playfx(level._effect["bloody_death"],var_07);
	foreach(param_01 in level.players)
	{
		if(distance(param_01.origin,var_07) <= 350)
		{
			param_01 thread scripts\cp\zombies\zmb_zombies_weapons::func_10142();
		}
	}

	if(isdefined(param_02.var_8C98))
	{
		param_02 detach(param_02.var_8C98);
	}

	if(!var_06)
	{
		param_02 setscriptablepartstate("head","hide");
	}
}

//Function Number: 161
passive_visor_detonation_activate()
{
	self endon("death");
	self endon("disconnect");
	self endon("end_passive_visor_detonation");
	for(;;)
	{
		self waittill("headshot_done_with_this_weapon",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 162
init_passive_berserk(param_00)
{
}

//Function Number: 163
set_passive_berserk(param_00)
{
	param_00.var_C54A["passive_berserk"] = 1;
}

//Function Number: 164
unset_passive_berserk(param_00)
{
	param_00.var_C54A["passive_berserk"] = 0;
}

//Function Number: 165
handleberserk(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!scripts\common\utility::istrue(param_01.berserk))
	{
		param_01.berserk = 1;
		param_01 method_85C1(65);
		var_06 = param_01 method_85C0();
		if(var_06 < 0)
		{
			var_06 = 100;
		}

		var_06 = max(var_06 - 20,0);
		param_01 player_recoilscaleon(int(var_06));
	}

	param_01 notify("stop_berserk_timer");
	param_01 thread remove_berserk_after_timeout(2);
}

//Function Number: 166
remove_berserk_after_timeout(param_00)
{
	self endon("end_berserk");
	self endon("stop_berserk_timer");
	self endon("death");
	self endon("disconnect");
	thread listencancelberserk();
	wait(param_00);
	unset_berserk();
}

//Function Number: 167
listencancelberserk()
{
	self endon("end_berserk");
	self endon("stop_berserk_timer");
	self endon("disconnect");
	scripts\common\utility::waittill_any_3("death","weapon_change");
	unset_berserk();
}

//Function Number: 168
unset_berserk()
{
	if(scripts\common\utility::istrue(self.berserk))
	{
		self.berserk = 0;
		self method_85C2();
		var_00 = self method_85C0();
		var_00 = min(var_00 + 20,100);
		self player_recoilscaleon(int(var_00));
		self notify("end_berserk");
	}
}

//Function Number: 169
unsetquadfeederpassive()
{
	self notify("end_quadFeederEffect");
	self notify("end_quadFeederPassive");
	unset_berserk();
}

//Function Number: 170
init_passive_melee_cone_expl(param_00)
{
}

//Function Number: 171
set_passive_melee_cone_expl(param_00)
{
	param_00.var_C54A["passive_melee_cone_expl"] = 1;
	param_00.skip_weapon_check = 1;
}

//Function Number: 172
unset_passive_melee_cone_expl(param_00)
{
	param_00.var_C54A["passive_melee_cone_expl"] = 0;
	param_00.skip_weapon_check = undefined;
}

//Function Number: 173
handlemeleeconeexplode(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(param_03 != "MOD_MELEE")
	{
		return;
	}

	if(!issubstr(param_00,"meleervn") && !param_01 method_8519(param_00))
	{
		return;
	}

	var_06 = param_02 gettagorigin("j_spineupper");
	var_07 = param_01 getplayerangles();
	var_08 = anglestoforward(var_07);
	var_09 = anglestoup(var_07);
	var_0A = var_06 - var_08 * 128;
	var_0B = 384;
	playfx(level._effect["cone_expl_fx"],var_06 + (0,2,0),var_08,var_09);
	var_0C = scripts\cp\_agent_utils::get_alive_enemies();
	foreach(var_0E in var_0C)
	{
		if(isdefined(var_0E.flung) || isdefined(var_0E.agent_type) && var_0E.agent_type == "zombie_brute" || var_0E.agent_type == "zombie_ghost" || var_0E.agent_type == "zombie_grey" || var_0E.agent_type == "slasher" || var_0E.agent_type == "superslasher")
		{
			continue;
		}

		if(!scripts\cp\_utility::func_D64B(var_0E gettagorigin("tag_origin"),var_0A,var_08,var_09,var_0B,128,12))
		{
			continue;
		}

		if(var_0E method_808F(var_06,param_01) <= 0)
		{
			continue;
		}

		var_0F = int(1500 * param_01 scripts\cp\_weapon::func_7D62(param_00));
		wait(0.05);
		var_0E dodamage(var_0F,var_06,param_01,param_01,"MOD_EXPLOSIVE",param_00);
	}
}

//Function Number: 174
init_passive_minimap_damage(param_00)
{
}

//Function Number: 175
set_passive_minimap_damage(param_00)
{
	param_00.var_C4E6["passive_minimap_damage"] = 1;
}

//Function Number: 176
unset_passive_minimap_damage(param_00)
{
	param_00.var_C4E6["passive_minimap_damage"] = 0;
}

//Function Number: 177
updatepassiveminimapdamage(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		return;
	}

	var_03 = 4;
	var_04 = 1;
	var_05 = 1;
	if(isdefined(param_02.var_4D32))
	{
		var_03 = 5;
	}

	if(isdefined(param_02.var_B36D))
	{
		var_03 = 0;
	}
	else
	{
		var_03 = 4;
	}

	level thread set_outline_passive_minimap_damage(param_00,param_02,var_03,var_04,var_05);
}

//Function Number: 178
func_6221(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 method_8190(param_01,param_02,param_03,param_04);
}

//Function Number: 179
set_outline_passive_minimap_damage(param_00,param_01,param_02,param_03,param_04)
{
	level endon("game_ended");
	level endon("outline_disabled");
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 4;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	func_6221(param_01,level.players,param_02,1,1,"high");
	wait(10);
	unset_outline_passive_minimap_damage(param_01);
}

//Function Number: 180
func_5562(param_00,param_01)
{
	param_00 method_818D(param_01);
}

//Function Number: 181
unset_outline_passive_minimap_damage(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	scripts\cp\_outline::func_5562(param_00,level.players);
}

//Function Number: 182
activate_adrenaline_boost(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	param_00 endon("death");
	param_00 scripts\cp\_utility::func_17C0("health_boost",0.2,0);
	param_00 notify("force_regeneration");
	param_00 playlocalsound("breathing_heartbeat_alt");
	wait(5);
	param_00 scripts\cp\_utility::func_E0E6("health_boost",0);
	param_00 playlocalsound("breathing_limp");
}

//Function Number: 183
adr_boost(param_00)
{
	param_00 notify("updatepassiveminimapdamage");
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	param_00 endon("death");
	for(;;)
	{
		if(randomint(100) > 30)
		{
			thread run_adrenaline_visuals(param_00,5);
			thread activate_adrenaline_boost(param_00);
		}

		wait(randomfloatrange(5,15));
	}
}

//Function Number: 184
remove_adrenaline_visuals(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	param_00 endon("death");
	param_00 visionsetnakedforplayer("",0.5);
}

//Function Number: 185
run_adrenaline_visuals(param_00,param_01)
{
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	param_00 endon("death");
	param_00 endon("remove_adrenaline_visuals");
	param_00 visionsetnakedforplayer("missilecam",scripts\common\utility::func_116D7(1,0.1,0));
	param_00 scripts\common\utility::waittill_any_timeout_1(param_01,"last_stand");
	param_00 thread remove_adrenaline_visuals(param_00);
}

//Function Number: 186
init_passive_fire_damage(param_00)
{
}

//Function Number: 187
set_passive_fire_damage(param_00)
{
	param_00.var_C4E6["passive_fire_damage"] = 1;
	param_00.var_6D53 = param_00 getcurrentweapon();
}

//Function Number: 188
unset_passive_fire_damage(param_00)
{
	param_00.var_C4E6["passive_fire_damage"] = 0;
	param_00.var_6D53 = undefined;
}

//Function Number: 189
updatepassivefiredamage(param_00,param_01,param_02)
{
	var_03 = isdefined(param_02.agent_type) && param_02.agent_type == "zombie_brute";
	var_04 = isdefined(param_02.agent_type) && param_02.agent_type == "zombie_grey";
	var_05 = scripts\common\utility::istrue(param_02.var_9CDD);
	var_06 = min(param_02.maxhealth * 0.1,1000);
	if(var_03 || var_04 || var_05)
	{
		return;
	}

	if(isdefined(param_00.var_6D53))
	{
		if(scripts\cp\_utility::func_80D8(param_00.var_6D53) == scripts\cp\_utility::func_80D8(param_01))
		{
			param_02 thread scripts\cp\_utility::func_4D0D(param_02,param_00,5,var_06,"MOD_HEAD_SHOT","incendiary_ammo_mp",undefined,"burning");
		}
	}
}

//Function Number: 190
init_passive_cold_damage(param_00)
{
}

//Function Number: 191
set_passive_cold_damage(param_00)
{
	param_00.var_C4E6["passive_cold_damage"] = 1;
	param_00.cold_weapon = param_00 getcurrentweapon();
}

//Function Number: 192
unset_passive_cold_damage(param_00)
{
	param_00.var_C4E6["passive_cold_damage"] = 0;
	param_00.cold_weapon = undefined;
}

//Function Number: 193
updatepassivecolddamage(param_00,param_01,param_02)
{
	var_03 = isdefined(param_02.agent_type) && param_02.agent_type == "zombie_brute";
	var_04 = isdefined(param_02.agent_type) && param_02.agent_type == "zombie_grey";
	var_05 = scripts\common\utility::istrue(param_02.var_9CDD);
	if(var_03 || var_04 || var_05)
	{
		return;
	}

	if(isdefined(param_00.cold_weapon))
	{
		if(scripts\cp\_utility::func_80D8(param_00.cold_weapon) == scripts\cp\_utility::func_80D8(param_01))
		{
			param_02 thread unsetslowmovementaftertime(param_02,param_02.var_1F5);
			param_02.var_1F5 = "slow_walk";
			param_02 lib_0A1B::func_2968("slow_walk");
		}
	}
}

//Function Number: 194
unsetslowmovementaftertime(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("death");
	wait(10);
	if(isdefined(param_01))
	{
		param_00.var_1F5 = param_01;
		param_00 lib_0A1B::func_2968(param_01);
	}
}

//Function Number: 195
init_passive_scorestreak_damage(param_00)
{
}

//Function Number: 196
set_passive_scorestreak_damage(param_00)
{
	param_00.special_zombie_damage = 1.1;
}

//Function Number: 197
unset_passive_scorestreak_damage(param_00)
{
	param_00.special_zombie_damage = undefined;
}

//Function Number: 198
init_passive_scope_radar(param_00)
{
	param_00.activate_radar = 0;
	param_00 notifyonplayercommand("scope_radar_ads_in","+speed_throw");
	param_00 notifyonplayercommand("scope_radar_ads_out","-speed_throw");
}

//Function Number: 199
set_passive_scope_radar(param_00)
{
	param_00 thread updatescoperadar(param_00);
}

//Function Number: 200
unset_passive_scope_radar(param_00)
{
	param_00 notify("unsetScopeRadar");
	param_00 thread cleanup_outlines(param_00);
}

//Function Number: 201
updatescoperadar(param_00)
{
	param_00 notify("updateScopeRadar");
	param_00 endon("updateScopeRadar");
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("unsetScopeRadar");
	var_01 = 2.4;
	var_02 = 1750;
	for(;;)
	{
		if(!param_00 adsbuttonpressed())
		{
			var_03 = param_00 scripts\common\utility::waittill_any_return_no_endon_death_3("scope_radar_ads_in","scope_radar_ads_out","last_stand","death","weapon_change");
		}
		else
		{
			var_03 = "scope_radar_ads_in";
		}

		if(var_03 == "scope_radar_ads_in")
		{
			runscoperadarinloop(param_00,var_01,var_02);
		}

		param_00 thread remove_visuals(param_00);
	}
}

//Function Number: 202
runscoperadarinloop(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 notify("runScopeRadarInLoop");
	param_00 endon("runScopeRadarInLoop");
	param_00 endon("scope_radar_ads_out");
	param_00 endon("last_stand");
	param_00 endon("death");
	param_00 endon("disconnect");
	var_03 = 0.75;
	while(param_00 adsbuttonpressed())
	{
		if(param_00 method_822E() >= var_03)
		{
			param_00 playlocalsound("uav_ping");
			param_00 thread scoperadar_executeping(param_00,param_01,param_02);
			param_00 scoperadar_executevisuals(param_00,param_01);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 203
scoperadar_executeping(param_00,param_01,param_02)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("scope_radar_ads_out");
	var_03 = 0;
	var_04 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_05 = scripts\common\utility::func_782F(param_00.origin,var_04,undefined,24,param_02);
	param_00.closestenemies = var_05;
	var_06 = 0;
	foreach(var_08 in param_00.closestenemies)
	{
		var_08.is_outlined_from_scoperadar = 0;
		if(scripts\common\utility::func_13D90(param_00 geteye(),param_00.angles,var_08.origin,cos(65)))
		{
			var_06++;
			var_09 = var_08.origin - param_00.origin;
			if(1 && vectordot(anglestoforward(param_00.angles),var_09) < 0)
			{
				continue;
			}

			var_0A = param_02 * param_02;
			if(length2dsquared(var_09) > var_0A)
			{
				continue;
			}

			param_00 thread func_C7A7(var_08,param_00,distance2d(param_00.origin,var_08.origin) / param_02,param_01);
			var_03 = 1;
		}
	}
}

//Function Number: 204
func_6220(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 hudoutlineenableforclient(param_01,param_02,param_03,param_04);
}

//Function Number: 205
func_C7A7(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_01 endon("scope_radar_ads_out");
	param_01 endon("last_stand");
	param_01 endon("death");
	param_01 endon("disconnect");
	param_01 endon("weapon_change");
	wait(param_03 * param_02);
	var_04 = 1;
	param_00.is_outlined_from_scoperadar = 1;
	func_6220(param_00,param_01,var_04,1,1,"high");
}

//Function Number: 206
func_13AA0(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	param_00 scripts\common\utility::waittill_any_timeout_no_endon_death_2(param_02);
	if(isdefined(param_01))
	{
		func_5561(param_01,param_00);
	}
}

//Function Number: 207
func_5561(param_00,param_01)
{
	param_00 hudoutlinedisableforclient(param_01);
}

//Function Number: 208
scoperadar_executevisuals(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 visionsetnakedforplayer("opticwave_mp",0.2);
	param_00.var_7626 = spawn("script_model",param_00 gettagorigin("tag_eye"));
	param_00.var_7626 setmodel("prop_mp_optic_wave_scr");
	param_00.var_7626.angles = param_00 getplayerangles();
	param_00.var_7626 method_831F(param_00);
	param_00.var_7626 setscriptablepartstate("effects","active",0);
	var_02 = param_00.var_7626.origin + anglestoforward(param_00.var_7626.angles) * 1750;
	param_00.var_7626 moveto(var_02,param_01);
	param_00 scripts\common\utility::waittill_any_timeout_no_endon_death_2(param_01,"last_stand","death","scope_radar_ads_out","weapon_change","unsetScopeRadar");
	if(isdefined(param_00.closestenemies))
	{
		foreach(var_04 in param_00.closestenemies)
		{
			if(isdefined(var_04))
			{
				if(scripts\common\utility::istrue(var_04.is_outlined_from_scoperadar))
				{
					func_5561(var_04,param_00);
					var_04.is_outlined_from_scoperadar = 0;
				}
			}
		}
	}

	if(scripts\common\utility::istrue(param_00.var_13CE5))
	{
		param_00 visionsetnakedforplayer("cp_zmb_bw",0.1);
	}
	else if(scripts\common\utility::istrue(param_00.var_DCEB))
	{
		param_00 visionsetnakedforplayer("cp_rave_rave_mode",0.1);
	}
	else
	{
		param_00 visionsetnakedforplayer("",0.1);
	}

	if(isdefined(param_00.var_7626))
	{
		param_00.var_7626 delete();
	}
}

//Function Number: 209
remove_visuals(param_00)
{
	var_01 = scripts\cp\_agent_utils::func_7DB0("axis");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03))
		{
			if(scripts\common\utility::istrue(var_03.is_outlined_from_scoperadar))
			{
				func_5561(var_03,param_00);
				var_03.is_outlined_from_scoperadar = 0;
			}
		}
	}

	if(scripts\common\utility::istrue(param_00.var_13CE5))
	{
		param_00 visionsetnakedforplayer("cp_zmb_bw",0.1);
	}
	else if(scripts\common\utility::istrue(param_00.var_DCEB))
	{
		param_00 visionsetnakedforplayer("cp_rave_rave_mode",0.1);
	}
	else
	{
		param_00 visionsetnakedforplayer("",0.1);
	}

	if(isdefined(param_00.var_7626))
	{
		param_00.var_7626 delete();
	}
}

//Function Number: 210
cleanup_outlines(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("last_stand");
	param_00 endon("death");
	var_01 = scripts\cp\_agent_utils::func_7DB0("axis");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03))
		{
			if(scripts\common\utility::istrue(var_03.is_outlined_from_scoperadar))
			{
				func_5561(var_03,param_00);
				var_03.is_outlined_from_scoperadar = 0;
			}
		}
	}
}

//Function Number: 211
func_96BD(param_00)
{
}

//Function Number: 212
func_F4C3(param_00)
{
	param_00 thread func_12F0D(param_00);
}

//Function Number: 213
func_12C10(param_00)
{
	param_00 notify("unsetScoutPing");
}

//Function Number: 214
func_12F0D(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("unsetScoutPing");
	var_01 = 50;
	var_02 = 0.1;
	for(;;)
	{
		var_03 = scripts\cp\_agent_utils::func_7DB0("axis");
		var_04 = var_01;
		var_05 = var_02;
		var_04 = int(var_04);
		var_05 = int(var_05);
		var_06 = scripts\common\utility::func_782F(param_00.origin,var_03,undefined,24,var_04);
		if(var_06.size >= 1)
		{
			foreach(var_08 in var_06)
			{
				scripts\cp\_outline::func_6221(var_08,level.players,7,0,0,"low");
				wait(var_05);
			}

			continue;
		}

		wait(var_02 / 1200);
	}
}

//Function Number: 215
func_12EDF(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = gettime();
	var_06 = getarraykeys(param_01.var_C54A);
	if(!scripts\common\utility::istrue(param_01.skip_weapon_check) && isdefined(param_01.current_passive_weapon) && param_00 != param_01.current_passive_weapon)
	{
		return;
	}

	foreach(var_08 in var_06)
	{
		if(scripts\common\utility::istrue(param_01.var_C54A[var_08]))
		{
			thread [[ level.var_C54A[var_08] ]](param_00,param_01,param_02,param_03,param_04,var_05);
		}
	}
}

//Function Number: 216
func_12EE1(param_00,param_01)
{
	var_02 = gettime();
	var_03 = getarraykeys(param_00.var_C5C9);
	foreach(var_05 in var_03)
	{
		if(scripts\common\utility::istrue(param_00.var_C5C9[var_05]))
		{
			thread [[ level.var_C5C9[var_05] ]](param_00,param_01);
		}
	}
}

//Function Number: 217
func_12EDD(param_00,param_01,param_02)
{
	var_03 = gettime();
	var_04 = getarraykeys(param_00.var_C4E6);
	foreach(var_06 in var_04)
	{
		if(scripts\common\utility::istrue(param_00.var_C4E6[var_06]))
		{
			thread [[ level.var_C4E6[var_06] ]](param_00,param_01,param_02);
		}
	}
}

//Function Number: 218
init()
{
	func_DEE0();
	level thread func_CFD5();
}

//Function Number: 219
func_CFD5()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_13C36(var_00);
	}
}

//Function Number: 220
func_13C36(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	var_01 = undefined;
	param_00.var_D8A7 = undefined;
	param_00.var_1607 = [];
	while(!isdefined(param_00.weaponkitinitialized))
	{
		wait(0.1);
	}

	param_00 func_94F1(param_00);
	for(;;)
	{
		if(!isdefined(var_01) || isdefined(var_01) && !scripts\cp\_utility::func_9C42(getweaponbasename(var_01),1))
		{
			var_02 = param_00 getcurrentprimaryweapon();
			if(!isdefined(var_02))
			{
				wait(0.05);
				continue;
			}

			if(var_02 == "none")
			{
				wait(0.05);
				continue;
			}

			if(isdefined(param_00.var_D8A7))
			{
				func_12C64(param_00,param_00.var_D8A7);
			}

			func_F616(param_00,var_02);
			param_00.current_passive_weapon = var_02;
			param_00.var_D8A7 = var_02;
		}

		param_00 waittill("weapon_change",var_01);
	}
}

//Function Number: 221
func_94F1(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00.var_13C38)
	{
		foreach(var_05 in var_03)
		{
			if(scripts\common\utility::func_2286(var_01,var_05))
			{
				continue;
			}

			if(isdefined(level.var_462E[var_05]))
			{
				var_06 = level.var_462E[var_05];
				if(isdefined(var_06) && isdefined(var_06.var_95F2))
				{
					[[ var_06.var_95F2 ]](param_00);
				}
			}

			var_01 = scripts\common\utility::array_add(var_01,var_05);
		}
	}
}

//Function Number: 222
func_12C64(param_00,param_01)
{
	param_01 = scripts\cp\_utility::func_8234(param_01);
	if(!isdefined(param_00.var_13C38[param_01]))
	{
		return;
	}

	var_02 = param_00.var_13C38[param_01];
	foreach(var_04 in var_02)
	{
		if(isdefined(level.var_462E[var_04]))
		{
			var_05 = level.var_462E[var_04];
			if(isdefined(var_05) && isdefined(var_05.var_12BFB))
			{
				[[ var_05.var_12BFB ]](param_00);
			}
		}

		param_00.var_1607 = scripts\common\utility::func_22A9(param_00.var_1607,var_04);
	}
}

//Function Number: 223
func_F616(param_00,param_01)
{
	param_01 = scripts\cp\_utility::func_8234(param_01);
	if(!isdefined(param_00.var_13C38[param_01]))
	{
		return;
	}

	var_02 = param_00.var_13C38[param_01];
	foreach(var_04 in var_02)
	{
		if(scripts\common\utility::func_2286(param_00.var_1607,var_04))
		{
			continue;
		}

		var_05 = level.var_462E[var_04];
		if(isdefined(var_05) && isdefined(var_05.var_F3C3))
		{
			[[ var_05.var_F3C3 ]](param_00);
		}

		param_00.var_1607 = scripts\common\utility::array_add(param_00.var_1607,var_04);
	}
}

//Function Number: 224
func_DEDF(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.var_95F2 = param_01;
	var_04.var_F3C3 = param_02;
	var_04.var_12BFB = param_03;
	level.var_462E[param_00] = var_04;
}

//Function Number: 225
func_7D6C(param_00,param_01)
{
	var_02 = scripts\cp\_utility::func_7D72(param_00,param_01);
	var_03 = [];
	if(!isdefined(var_02) || var_02 == -1)
	{
		return var_03;
	}

	var_04 = "mp/loot/weapon/" + param_01 + ".csv";
	var_05 = tablelookuprownum(var_04,0,var_02);
	for(var_06 = 0;var_06 < 3;var_06++)
	{
		var_07 = tablelookupbyrow(var_04,var_05,21 + var_06);
		if(isdefined(var_07) && var_07 != "")
		{
			var_03[var_03.size] = var_07;
		}
	}

	return var_03;
}

//Function Number: 226
func_1772(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!isdefined(level.var_C943))
	{
		level.var_C943 = [];
	}

	var_08 = spawnstruct();
	var_08.name = param_00;
	var_08.var_13CDE = scripts\common\utility::func_116D7(isdefined(param_04),0,1);
	var_08.var_A6BB = scripts\common\utility::func_116D7(isdefined(param_05),0,1);
	var_08.var_ABCA = scripts\common\utility::func_116D7(isdefined(param_06),0,1);
	var_08.var_113D1 = scripts\common\utility::func_116D7(isdefined(param_07),0,1);
	if(isdefined(param_01))
	{
		var_08.var_249B = param_01;
	}

	if(isdefined(param_02))
	{
		var_08.var_CA59 = param_02;
	}

	if(isdefined(param_03))
	{
		var_08.var_B689 = param_03;
	}

	if(!isdefined(level.var_C943[param_00]))
	{
		level.var_C943[param_00] = var_08;
	}
}