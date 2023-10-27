/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\perks\_weaponpassives.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 202
 * Decompile Time: 9519 ms
 * Timestamp: 10/27/2023 12:30:37 AM
*******************************************************************/

//Function Number: 1
func_13CB1()
{
	level thread func_13B0C();
	level._effect["loot_mo_money_kill"] = loadfx("vfx/iw7/_requests/mp/vfx_mo_money_cash_exp");
	level._effect["player_plasma_friendly"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level._effect["player_plasma_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level._effect["player_plasma_friendly"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level._effect["player_plasma_enemy"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level._effect["player_plasma_screen_stand"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	level._effect["passive_gore"] = loadfx("vfx/iw7/_requests/mp/vfx_meatbag_large.vfx");
	level._effect["passive_gore_robot"] = loadfx("vfx/iw7/core/impact/robot/vfx_mp_c6_melee.vfx");
}

//Function Number: 2
func_13B0C()
{
	for(;;)
	{
		level waittill("player_spawned",var_00);
		var_00 thread updatenukepassive();
		var_00 thread func_13BA6();
	}
}

//Function Number: 3
func_13BA6()
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		var_00 = self getcurrentweapon();
		if(isdefined(var_00) && var_00 != "none")
		{
			setmodeswitchkillweapon(self,var_00);
			func_83BA(var_00);
			scripts\mp\_weapons::func_12F5D(var_00);
		}

		scripts\common\utility::waittill_any_3("weapon_change","giveLoadout");
	}
}

//Function Number: 4
func_83BA(param_00)
{
	func_41CA();
	var_01 = scripts\mp\_loot::func_804C(param_00);
	if(isdefined(var_01))
	{
		foreach(var_03 in var_01)
		{
			func_8391(var_03);
		}
	}

	self notify("weapon_passives_given");
}

//Function Number: 5
func_8391(param_00)
{
	scripts\mp\_utility::func_8387(param_00);
	self.var_13CB0[self.var_13CB0.size] = param_00;
}

//Function Number: 6
func_41CA()
{
	if(isdefined(self.var_13CB0))
	{
		foreach(var_01 in self.var_13CB0)
		{
			scripts\mp\_utility::func_E150(var_01);
		}
	}

	self.var_13CB0 = [];
}

//Function Number: 7
func_72FB()
{
	self.var_13CB0 = [];
}

//Function Number: 8
func_50A3(param_00)
{
	if(!isdefined(self.var_C949))
	{
		self.var_C949 = [];
	}

	if(!isdefined(self.var_C949[param_00]))
	{
		self.var_C949[param_00] = 0;
	}
}

//Function Number: 9
func_804E(param_00)
{
	func_50A3(param_00);
	return self.var_C949[param_00];
}

//Function Number: 10
func_F7D7(param_00,param_01)
{
	func_50A3(param_00);
	self.var_C949[param_00] = param_01;
}

//Function Number: 11
func_115E9(param_00,param_01)
{
	if(level.teambased)
	{
		return param_00.team == param_01.team;
	}

	return param_00 == param_01;
}

//Function Number: 12
func_12F62(param_00,param_01)
{
	if(param_00 scripts\mp\_utility::_hasperk("passive_backfire"))
	{
		param_00 thread func_8978(param_00,param_01);
	}

	if(param_00 scripts\mp\_utility::_hasperk("passive_sonar"))
	{
		param_00 thread func_89E5(param_00,param_01);
	}
}

//Function Number: 13
func_8978(param_00,param_01)
{
	if(isdefined(param_00.var_119DF))
	{
		var_02 = param_00.var_119DF[param_01];
		if(isdefined(var_02) && var_02 != param_00)
		{
			playfx(scripts\common\utility::getfx("seeker_explosion"),param_00.origin);
			param_00 dodamage(9999,var_02.origin,var_02,var_02,"MOD_EXPLOSIVE",param_01);
		}
	}
}

//Function Number: 14
func_12EB2(param_00)
{
	var_01 = weaponclipsize(param_00);
	self setweaponammoclip(param_00,var_01);
}

//Function Number: 15
func_12F60(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(param_00 scripts\mp\_utility::_hasperk("passive_infinite_ammo"))
	{
		param_00 thread func_12EB2(param_00 getcurrentweapon());
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_minimap_damage") && isdefined(param_00) && !param_00 scripts\mp\_utility::_hasperk("specialty_gpsjammer"))
	{
		param_01 thread func_89C5(param_01,param_00);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_fire_damage"))
	{
		param_01 thread func_89A2(param_01,param_00,param_04);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_cold_damage"))
	{
		param_01 thread func_8986(param_01,param_00,param_04);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_critical_sequential_damage"))
	{
		param_01 thread func_898A(param_01,param_00,param_04);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_sonic"))
	{
		param_01 thread func_89E6(param_01,param_00);
	}
}

//Function Number: 16
loadoutweapongiven(param_00)
{
	var_01 = scripts\mp\_utility::func_8234(param_00);
	checkprestigeextraclassicammo(param_00,var_01);
}

//Function Number: 17
checkprestigeextraclassicammo(param_00,param_01)
{
	var_02 = param_01 + "_extra_ammo";
	if(isdefined(level.prestigeextras[var_02]))
	{
		if(self isitemunlocked(var_02,"prestigeExtras",1))
		{
			var_03 = function_0249(param_00);
			var_04 = self getweaponammostock(param_00);
			var_05 = var_03 - var_04 * 0.5;
			self setweaponammostock(param_00,int(min(var_04 + var_05,var_03)));
		}
	}
}

//Function Number: 18
func_89C5(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_02 = scripts\mp\objidpoolmanager::requestminimapid(10);
		if(var_02 == -1)
		{
			return;
		}

		scripts\mp\objidpoolmanager::minimap_objective_add(var_02,"active",(0,0,0),"cb_compassping_enemy");
		scripts\mp\objidpoolmanager::minimap_objective_onentity(var_02,param_01);
		scripts\mp\objidpoolmanager::minimap_objective_team(var_02,param_00.team);
		var_03 = 3;
		param_01 scripts\common\utility::waittill_any_timeout_1(var_03,"damage_begin","death","disconnect");
		scripts\mp\objidpoolmanager::returnminimapid(var_02);
	}
}

//Function Number: 19
func_89E5(param_00,param_01)
{
	if(!scripts\mp\_utility::isstrstart(param_01,"alt"))
	{
		return;
	}

	var_02 = self getweaponammoclip(param_01);
	function_02A1(param_00.origin,param_00.team,500,500);
}

//Function Number: 20
func_898A(param_00,param_01,param_02)
{
	var_03 = param_00 func_804E("passive_critical_sequential_damage");
	param_00 func_F7D7("passive_critical_sequential_damage",var_03 + 1);
}

//Function Number: 21
func_8986(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::func_116D7(weaponclass(param_02) == "sniper" || issubstr(param_02,"iw7_longshot"),-0.2,-0.1);
	thread passivecolddamagewatchvictim(param_00,param_01,var_03,1.5);
}

//Function Number: 22
passivecolddamagewatchvictim(param_00,param_01,param_02,param_03,param_04)
{
	param_01 endon("death");
	param_01 endon("disconnect");
	param_01 notify("passiveColdDamageWatchVictim");
	param_01 endon("passiveColdDamageWatchVictim");
	var_05 = param_00 getentitynumber();
	var_06 = gettime() + param_03 * 1000;
	var_07 = self.passivecolddamage;
	if(!isdefined(var_07))
	{
		var_07 = spawnstruct();
		var_07.curspeedmod = 0;
		var_07.speedmods = [];
		var_07.endtimes = [];
		param_01.passivecolddamage = var_07;
	}

	var_07.speedmods[var_05] = param_02;
	var_07.endtimes[var_05] = var_06;
	param_01 setscriptablepartstate(scripts\common\utility::func_116D7(scripts\mp\_utility::func_9FB3(param_04),"weaponPassiveColdGLDamage","weaponPassiveColdDamage"),"active");
	var_08 = var_07.curspeedmod;
	var_09 = var_08;
	for(;;)
	{
		var_0A = gettime();
		foreach(var_0C, param_02 in var_07.speedmods)
		{
			var_06 = var_07.endtimes[var_0C];
			if(var_06 < var_0A)
			{
				var_07.speedmods[var_0C] = undefined;
				var_07.endtimes[var_0C] = undefined;
				continue;
			}

			if(param_02 < var_09)
			{
				var_09 = param_02;
			}
		}

		var_07.curspeedmod = var_09;
		if(var_07.curspeedmod != var_08)
		{
			param_01 scripts\mp\_weapons::func_12ED5();
		}

		if(var_07.speedmods.size <= 0)
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	passivecolddamageresetdata(param_01);
	passivecolddamageresetscriptable(param_01);
}

//Function Number: 23
passivecolddamagegetspeedmod(param_00)
{
	if(isdefined(param_00.passivecolddamage))
	{
		return param_00.passivecolddamage.curspeedmod;
	}

	return 0;
}

//Function Number: 24
passivecolddamageresetscriptable(param_00)
{
	param_00 setscriptablepartstate("weaponPassiveColdDamage","neutral");
}

//Function Number: 25
passivecolddamageresetdata(param_00)
{
	param_00.passivecolddamage = undefined;
	param_00 scripts\mp\_weapons::func_12ED5();
}

//Function Number: 26
cryogl_watchforexplode(param_00)
{
	self waittill("explode",var_01);
	var_02 = scripts\mp\_utility::func_807C(var_01,256);
	foreach(var_04 in var_02)
	{
		if(var_04 == param_00)
		{
			continue;
		}

		if(!isdefined(var_04))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_04))
		{
			continue;
		}

		if(!lib_0DF8::func_213D(var_04,self))
		{
			continue;
		}

		if(var_04 != param_00 && scripts\mp\_utility::func_9E05(param_00.team,var_04))
		{
			continue;
		}

		if(var_04 scripts\mp\_utility::_hasperk("specialty_stun_resistance"))
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FB3(var_04.var_9F72))
		{
			continue;
		}

		var_04 dodamage(1,param_00.origin,param_00,undefined,"MOD_EXPLOSIVE","gltacburst_regen");
		thread passivecolddamagewatchvictim(param_00,var_04,-0.2,2.5,1);
	}
}

//Function Number: 27
func_89A2(param_00,param_01,param_02)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		var_03 = param_01 func_804E("passive_fire_damage");
		param_01 setscriptablepartstate("burning","active",0);
		var_04 = scripts\common\utility::func_116D7(param_01 scripts\mp\_utility::_hasperk("specialty_blastshield"),2,5);
		if(var_03 <= 0)
		{
			param_01 thread func_10D82(param_02,param_00,var_04,0.5,2.5,"passive_fire_damage");
			return;
		}

		param_01 func_F7D7("passive_fire_damage",2.5);
	}
}

//Function Number: 28
func_AD69(param_00,param_01)
{
	scripts\common\utility::waittill_any_timeout_1(5,"death","disconnect",param_01);
	func_11067(param_01);
}

//Function Number: 29
func_AD68(param_00,param_01)
{
	scripts\common\utility::waittill_any_timeout_1(5,"disconnect");
	param_00 func_11067(param_01);
}

//Function Number: 30
func_10D9E(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = function_01E1(scripts\common\utility::getfx(param_06),self geteye(),self);
	foreach(var_09 in level.players)
	{
		if(var_09 == self)
		{
			triggerfx(var_07);
			continue;
		}

		if(isdefined(param_03) && isdefined(param_04))
		{
			var_0A = scripts\common\utility::func_116D7(func_115E9(self,param_01),param_03,param_04);
			playfxontagforclients(scripts\common\utility::getfx(var_0A),self,param_05,var_09);
		}
	}

	self waittill(param_02);
	func_11073(param_03,param_04,param_05,var_07);
}

//Function Number: 31
func_11073(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		stopfxontag(scripts\common\utility::getfx(param_00),self,param_02);
		stopfxontag(scripts\common\utility::getfx(param_01),self,param_02);
	}

	param_03 delete();
}

//Function Number: 32
func_10D82(param_00,param_01,param_02,param_03,param_04,param_05)
{
	func_F7D7(param_05,param_04);
	thread func_AD69(param_01,param_05);
	param_01 thread func_AD68(self,param_05);
	var_06 = "MOD_UNKNOWN";
	if(param_03 > param_04)
	{
		return;
	}

	if(self.health <= 0)
	{
		func_11067(param_05);
	}

	var_07 = param_02;
	if(self.health <= var_07)
	{
		self dodamage(param_02,self.origin,param_01,undefined,var_06,param_00);
	}

	while(func_804E(param_05) > 0)
	{
		if(self.health <= 0)
		{
			func_11067(param_05);
		}

		if(param_02 > 0)
		{
			self dodamage(param_02,self.origin,param_01,undefined,var_06,param_00);
		}

		func_F7D7(param_05,func_804E(param_05) - param_03);
		wait(param_03);
	}

	func_11067(param_05);
}

//Function Number: 33
func_11067(param_00)
{
	func_F7D7(param_00,0);
	self setscriptablepartstate("burning","neutral",0);
	self notify(param_00);
}

//Function Number: 34
func_12F61(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(!scripts\mp\_utility::playersareenemies(param_01,param_02))
	{
		return;
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_berserk") || param_01 scripts\mp\_utility::_hasperk("passive_berserk_silent"))
	{
		param_01 thread quadfeederon();
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_headshot_ammo"))
	{
		param_01 thread func_89AE(param_05,param_01,param_02,param_04,param_06);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_last_shots_ammo") || param_01 scripts\mp\_utility::_hasperk("passive_last_shots_ammo_kbs"))
	{
		param_01 thread func_89C2(param_05,param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_extra_xp"))
	{
		param_01 thread func_89A0(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_nuke"))
	{
		param_01 thread func_89CC(param_01,param_02,param_05);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_streak_ammo"))
	{
		param_01 thread func_89EB(param_01,param_05);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_move_speed_on_kill"))
	{
		param_01 thread func_89C8(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_cooldown_on_kill"))
	{
		param_01 thread func_8988(param_01);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_health_regen_on_kill"))
	{
		param_01 thread func_89B1(param_01);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_refresh"))
	{
		param_01 thread func_89DB(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_fire_kill"))
	{
		param_01 thread func_89A3(param_01,param_02,param_05);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_random_perks"))
	{
		param_01 thread func_89D9(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_mini_specialist"))
	{
		param_01 thread handlespecialistpassive(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_headshot_super"))
	{
		param_01 thread func_89B0(param_05,param_01,param_02,param_04,param_06);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_hitman"))
	{
		param_01 thread func_89B3(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_scorestreak_pack"))
	{
		param_01 thread func_89E0(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_sonic"))
	{
		param_01 thread func_89E7(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_headshot"))
	{
		param_01 thread func_89AF(param_05,param_01,param_02,param_04,param_06,param_07);
	}

	if((param_01 scripts\mp\_utility::_hasperk("passive_meleekill") || param_01 scripts\mp\_utility::_hasperk("passive_meleekill_silent")) && param_04 == "MOD_MELEE")
	{
		param_01 thread func_89AB(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_gore"))
	{
		param_01 thread func_89AB(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_visor_detonation"))
	{
		param_01 thread handlevisordetonationpassive(param_05,param_01,param_02,param_04,param_06);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_railgun_overload") || param_01 scripts\mp\_utility::_hasperk("passive_overkill"))
	{
		param_01 thread handleoverloadpassive(param_05,param_01,param_02,param_04,param_06,param_03);
	}

	if(ismark2weapon(param_05))
	{
		param_01 thread handlemark2xpbonus(param_01,param_05);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_double_kill_reload"))
	{
		param_01 thread handledoublekillreload(param_05);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_jump_super"))
	{
		thread handlejumpsuperonkillpassive(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_melee_super"))
	{
		thread handlemeleesuperonkillpassive(param_01,param_02,param_04);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_double_kill_super"))
	{
		thread handledoublekillsuperpassive(param_01,param_02);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_melee_cone_expl"))
	{
		thread handlemeleeconeexplodeonkillpassive(param_01,param_02,param_05,param_04);
	}

	if(param_01 scripts\mp\_utility::_hasperk("passive_leader_kill_score"))
	{
		thread handleleaderkillscorepassive(param_01,param_02,param_05);
	}

	thread updatemodeswitchweaponkills(param_01,param_02,param_05);
}

//Function Number: 35
func_F79A()
{
	thread func_13AD0();
}

//Function Number: 36
func_12CF0()
{
	self notify("remove_minimap_decoys_passive");
}

//Function Number: 37
func_13AD0()
{
	self endon("death");
	self endon("disconnect");
	self endon("remove_minimap_decoys_passive");
	for(;;)
	{
		self waittill("begin_firing");
		thread func_49ED();
	}
}

//Function Number: 38
func_49ED()
{
	self notify("stop_minimap_decoys");
	self endon("death");
	self endon("disconnect");
	self endon("stop_minimap_decoys");
	childthread func_B7B0();
	for(;;)
	{
		thread func_49EC(self.origin,scripts\mp\_utility::getotherteam(self.team));
		wait(0.25);
	}
}

//Function Number: 39
func_B7B0()
{
	self endon("death");
	self endon("disconnect");
	scripts\common\utility::func_137B4("end_firing",1);
	self notify("stop_minimap_decoys");
}

//Function Number: 40
func_49EC(param_00,param_01)
{
	wait(randomfloatrange(0,0.1));
	if(!isdefined(self) || !scripts\mp\_utility::func_9F19(self))
	{
		return;
	}

	var_02 = scripts\mp\objidpoolmanager::requestminimapid(10);
	if(var_02 == -1)
	{
		return;
	}

	var_03 = (randomintrange(-150,150),randomintrange(-150,150),randomintrange(-150,150));
	scripts\mp\objidpoolmanager::minimap_objective_add(var_02,"active",self.origin + var_03,"cb_compassping_enemy");
	scripts\mp\objidpoolmanager::minimap_objective_team(var_02,param_01);
	var_04 = randomfloatrange(0.4,0.65);
	scripts\common\utility::waittill_any_timeout_1(var_04,"death","disconnect","stop_minimap_decoys");
	scripts\mp\objidpoolmanager::returnminimapid(var_02);
}

//Function Number: 41
func_F73F()
{
}

//Function Number: 42
func_12CCE()
{
}

//Function Number: 43
func_89AE(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01) || !isdefined(param_00) || !param_01 scripts\mp\_utility::_hasperk("passive_headshot_ammo"))
	{
		return;
	}

	if(!scripts\mp\_utility::func_9E27(param_00,param_04,param_03,param_01))
	{
		return;
	}

	param_01 func_3E2F("passive_headshot_ammo");
	var_05 = weaponclipsize(param_00);
	var_06 = var_05 * 1;
	var_07 = param_01 getweaponammoclip(param_00);
	var_08 = min(var_07 + var_06,var_05);
	param_01 setweaponammoclip(param_00,int(var_08));
	if(param_01 method_819C())
	{
		var_07 = param_01 getweaponammoclip(param_00,"left");
		var_08 = min(var_07 + var_06,var_05);
		param_01 setweaponammoclip(param_00,int(var_08),"left");
	}
}

//Function Number: 44
handlevisordetonationpassive(param_00,param_01,param_02,param_03,param_04)
{
	param_01 endon("joined_team");
	param_01 endon("joined_spectator");
	param_01 endon("disconnect");
	level endon("game_ended");
	if(!isdefined(param_01) || !isdefined(param_00) || !param_01 scripts\mp\_utility::_hasperk("passive_visor_detonation"))
	{
		return;
	}

	if(!scripts\mp\_utility::func_9E27(param_00,param_04,param_03,param_01))
	{
		return;
	}

	var_05 = param_02 gettagorigin("tag_eye");
	var_06 = param_02.angles;
	wait(0.1);
	thread activatevisordetonationpassive(self,param_00,var_05,var_06);
}

//Function Number: 45
activatevisordetonationpassive(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",param_02);
	var_04.angles = param_03;
	var_04.var_13C2E = param_01;
	var_04 method_831F(param_00);
	var_04 method_82DD(param_00);
	var_04 setmodel("passive_mp_visorDetonation");
	wait(1);
	var_04 delete();
}

//Function Number: 46
handleoverloadpassive(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_01 endon("joined_team");
	param_01 endon("joined_spectator");
	param_01 endon("disconnect");
	level endon("game_ended");
	if(!isdefined(param_01) || !isdefined(param_00) || !param_01 scripts\mp\_utility::_hasperk("passive_railgun_overload") && !param_01 scripts\mp\_utility::_hasperk("passive_overkill"))
	{
		return;
	}

	if(!isdefined(param_02.hitbychargedshot) && param_02.hitbychargedshot == param_01)
	{
		return;
	}

	var_06 = param_02 gettagorigin("tag_eye");
	var_07 = param_02.angles;
	wait(0.1);
	param_02.hitbychargedshot = undefined;
	thread activateoverloadpassive(self,param_00,var_06,var_07);
	param_01 thread func_89AB(param_01,param_02);
}

//Function Number: 47
activateoverloadpassive(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",param_02);
	var_04.angles = param_03;
	var_04.var_13C2E = param_01;
	var_04 method_831F(param_00);
	var_04 method_82DD(param_00);
	var_04 setmodel("passive_mp_visorDetonation");
	wait(1);
	var_04 delete();
}

//Function Number: 48
ismark2weapon(param_00)
{
	var_01 = function_02C4(param_00);
	return isdefined(var_01) && var_01 >= 32;
}

//Function Number: 49
handlemark2xpbonus(param_00,param_01)
{
	var_02 = getdvarfloat("mk2_bonus",0.15);
	var_03 = scripts\mp\_utility::func_8225(param_01);
	var_04 = var_03 + "_mk_ii_bonus";
	if(isdefined(level.prestigeextras[var_04]))
	{
		if(self isitemunlocked(var_04,"prestigeExtras",1))
		{
			var_02 = getdvarfloat("mk2_extra_bonus",0.3);
		}
	}

	var_05 = scripts\mp\_rank::func_8104("kill");
	param_00 scripts\mp\_rank::func_839A("kill",int(var_05 * var_02));
}

//Function Number: 50
func_11751(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	var_02 = 0;
	var_03 = scripts\mp\_passives::func_8049(param_00);
	var_04 = "";
	if(isdefined(var_03))
	{
		var_04 = var_03 + param_01;
		var_02 = scripts\mp\_hud_message::func_11750(var_04);
	}

	if(var_02)
	{
	}
}

//Function Number: 51
func_3E2F(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	var_02 = scripts\mp\_passives::func_8049(param_00);
	if(isdefined(var_02))
	{
		if(isendstr(param_01,"_camo"))
		{
			var_03 = scripts\mp\_utility::strip_suffix(param_01,"_camo");
			param_01 = var_03;
		}

		scripts\mp\_hud_message::func_1013D(var_02 + param_01);
	}
}

//Function Number: 52
func_F82F()
{
	thread func_12F0F();
}

//Function Number: 53
func_12D27()
{
	self notify("kill_scrambler_passive");
	func_4114();
}

//Function Number: 54
func_12F0F()
{
	self endon("death");
	self endon("disconnect");
	self endon("kill_scrambler_passive");
	for(;;)
	{
		self waittill("killed_enemy",var_00,var_01,var_02);
		self notify("start_scrambler_passive");
		self method_81F4();
		thread func_6CE3();
	}
}

//Function Number: 55
func_6CE3()
{
	self endon("death");
	self endon("disconnect");
	self endon("kill_scrambler_passive");
	self endon("start_scrambler_passive");
	wait(1);
	func_4114();
}

//Function Number: 56
func_4114()
{
	self method_807C();
}

//Function Number: 57
func_F77D()
{
	var_00 = self getcurrentweapon();
	if(isdefined(var_00))
	{
		var_01 = weaponclipsize(var_00);
		var_02 = func_7F60(var_01);
		self setclientomnvar("ui_last_shots_clip_size",var_02);
	}
}

//Function Number: 58
func_12CE2()
{
	self setclientomnvar("ui_last_shots_clip_size",-1);
}

//Function Number: 59
func_89C2(param_00,param_01,param_02)
{
	if(!isdefined(param_01) || !isdefined(param_00) || !param_01 scripts\mp\_utility::_hasperk("passive_last_shots_ammo") && !param_01 scripts\mp\_utility::_hasperk("passive_last_shots_ammo_kbs"))
	{
		return;
	}

	var_03 = weaponclipsize(param_00);
	var_04 = func_7F60(var_03);
	var_05 = 0;
	var_05 = func_3E60(param_01,param_00,"right",var_03,var_04);
	if(param_01 method_819C())
	{
		var_05 = func_3E60(param_01,param_00,"left",var_03,var_04) || var_05;
	}

	if(var_05)
	{
		param_01 scripts\mp\_hud_message::func_1013D("scavenger");
	}
}

//Function Number: 60
func_3E60(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_00 getweaponammoclip(param_01,param_02);
	if(var_05 >= param_04)
	{
		return 0;
	}

	var_06 = param_03 * 1;
	var_07 = min(var_05 + var_06,param_03);
	param_00 setweaponammoclip(param_01,int(var_07),param_02);
	return 1;
}

//Function Number: 61
func_7F60(param_00)
{
	return int(max(1,param_00 * 0.2));
}

//Function Number: 62
func_F740()
{
	var_00 = self getcurrentweapon();
	thread func_8CB9(var_00);
}

//Function Number: 63
func_12CCF()
{
	self notify("removeHealthOnKillPassive");
}

//Function Number: 64
func_8CB9(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeHealthOnKillPassive");
	for(;;)
	{
		self waittill("killed_enemy",var_01,var_02,var_03);
		if(isalive(self) && var_02 == param_00 && self.health < self.maxhealth)
		{
			var_04 = int(self.maxhealth * 0.15);
			var_05 = self.health + var_04;
			if(self.health + var_05 > self.maxhealth)
			{
				var_05 = self.maxhealth;
			}

			self.health = var_05;
		}
	}
}

//Function Number: 65
func_F6D6()
{
}

//Function Number: 66
func_12CA7()
{
}

//Function Number: 67
handledoublekillreload(param_00)
{
	var_01 = self.var_DDC2 + 1;
	if(var_01 % 2 == 0)
	{
		scripts\mp\_hud_message::func_1013D("scavenger");
		var_02 = weaponclipsize(param_00);
		var_03 = self getweaponammostock(param_00);
		var_04 = self getweaponammoclip(param_00);
		var_05 = min(var_02 - var_04,var_03);
		var_06 = min(var_04 + var_05,var_02);
		self setweaponammoclip(param_00,int(var_06));
		self setweaponammostock(param_00,int(var_03 - var_05));
		if(self method_819C())
		{
			var_03 = self getweaponammostock(param_00);
			var_04 = self getweaponammoclip(param_00,"left");
			var_05 = min(var_02 - var_04,var_03);
			var_06 = min(var_04 + var_05,var_02);
			self setweaponammoclip(param_00,int(var_06),"left");
			self setweaponammostock(param_00,int(var_03 - var_05));
		}

		func_3E2F("passive_double_kill_reload");
	}
}

//Function Number: 68
func_F6F0()
{
	var_00 = self getcurrentweapon();
	thread func_6A02(var_00);
}

//Function Number: 69
func_12CB0()
{
	self notify("removeExplosiveKillsPassive");
}

//Function Number: 70
func_6A02(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("removeExplosiveKillsPassive");
	for(;;)
	{
		self waittill("killed_enemy",var_01,var_02,var_03);
		if(var_02 == param_00)
		{
			if(func_9E84(self,var_02,var_03,self.origin,var_01))
			{
				thread func_582E(var_01,var_02);
			}
		}
	}
}

//Function Number: 71
func_9E84(param_00,param_01,param_02,param_03,param_04)
{
	if(isalive(param_00) && !param_00 scripts\mp\_utility::func_9FC6() && param_02 == "MOD_RIFLE_BULLET" || param_02 == "MOD_PISTOL_BULLET" || param_02 == "MOD_HEAD_SHOT" && !scripts\mp\_utility::func_9E6C(param_01) && !isdefined(param_00.var_23E8))
	{
		var_05 = scripts\mp\_utility::func_8225(param_01);
		switch(var_05)
		{
			case "weapon_pistol":
				var_06 = 800;
				break;

			case "weapon_beam":
			case "weapon_smg":
				var_06 = 1200;
				break;

			case "weapon_lmg":
			case "weapon_assault":
			case "weapon_dmr":
				var_06 = 1500;
				break;

			case "weapon_rail":
			case "weapon_sniper":
				var_06 = 2000;
				break;

			case "weapon_shotgun":
				var_06 = 500;
				break;

			case "weapon_projectile":
			default:
				var_06 = 1536;
				break;
		}

		var_07 = var_06 * var_06;
		if(distancesquared(param_03,param_04.origin) > var_07)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 72
func_582E(param_00,param_01)
{
	var_02 = param_00.origin + (0,0,50);
	param_00 playsound("detpack_explo_default");
	playfx(level.var_B761,var_02);
	radiusdamage(var_02,200,140,50,self,"MOD_EXPLOSIVE",param_01);
}

//Function Number: 73
func_F79B()
{
	var_00 = self getcurrentweapon();
	if(doesshareammo(var_00))
	{
		var_00 = scripts\mp\_utility::func_E0CF(var_00);
	}

	thread func_B8D5(var_00);
}

//Function Number: 74
func_12CF1()
{
	self notify("removeMissRefundPassive");
}

//Function Number: 75
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

//Function Number: 76
doesshareammo(param_00)
{
	return scripts\mp\_weapons::func_9D3E(param_00) && !issubstr(param_00,"+gl") && !issubstr(param_00,"+shotgun");
}

//Function Number: 77
func_F7AA()
{
	self.var_13CB2 = 0.03;
	scripts\mp\_weapons::func_12ED5();
}

//Function Number: 78
func_12CF5()
{
	self.var_13CB2 = undefined;
	scripts\mp\_weapons::func_12ED5();
}

//Function Number: 79
setrechambermovespeedpassive()
{
	self.weaponpassivefastrechamberspeedmod = -0.05;
	scripts\mp\_weapons::func_12ED5();
}

//Function Number: 80
unsetrechambermovespeedpassive()
{
	self.weaponpassivefastrechamberspeedmod = undefined;
	scripts\mp\_weapons::func_12ED5();
}

//Function Number: 81
func_F6FD()
{
}

//Function Number: 82
func_12CBA()
{
}

//Function Number: 83
func_89A0(param_00,param_01)
{
	if(isdefined(param_01))
	{
		playfx(scripts\common\utility::getfx("loot_mo_money_kill"),param_01.origin + (0,0,45));
	}

	param_00 func_3E2F("passive_extra_xp");
	scripts\mp\_awards::func_8380("mo_money");
}

//Function Number: 84
getpassivedeathwatching(param_00,param_01)
{
	if(!isdefined(param_00.passivedeathwatcher))
	{
		return 0;
	}

	if(!isdefined(param_00.passivedeathwatcher[param_01]))
	{
		return 0;
	}

	if(param_00.passivedeathwatcher[param_01])
	{
		return 1;
	}

	return 0;
}

//Function Number: 85
setpassivedeathwatching(param_00,param_01,param_02)
{
	if(!isdefined(param_00.passivedeathwatcher))
	{
		param_00.passivedeathwatcher = [];
	}

	param_00.passivedeathwatcher[param_01] = param_02;
}

//Function Number: 86
clearpassivedeathwatching(param_00,param_01)
{
	if(!isdefined(param_00.passivedeathwatcher))
	{
		param_00.passivedeathwatcher = [];
	}

	param_00.passivedeathwatcher[param_01] = undefined;
}

//Function Number: 87
func_F7BD()
{
}

//Function Number: 88
func_12CF8()
{
}

//Function Number: 89
updatenukepassive(param_00)
{
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_passives_given");
		if((scripts\mp\_utility::_hasperk("passive_nuke") || hasnukepassiveinloadout() || isdefined(self.pers["passive_nuke_key"]) && self.pers["passive_nuke_key"] > 0) && !getpassivedeathwatching(self,"passive_nuke_key"))
		{
			thread func_C1C7();
			setpassivedeathwatching(self,"passive_nuke_key",1);
		}
	}
}

//Function Number: 90
hasnukepassiveinloadout()
{
	var_00 = 0;
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		var_04 = scripts\mp\_loot::func_804C(var_03);
		if(isdefined(var_04) && var_04.size > 0)
		{
			foreach(var_06 in var_04)
			{
				if(var_06 == "passive_nuke")
				{
					var_00 = 1;
					break;
				}
			}

			if(scripts\mp\_utility::func_9FB3(var_00))
			{
				break;
			}
		}
	}

	return var_00;
}

//Function Number: 91
func_89CC(param_00,param_01,param_02)
{
	self endon("disconnect");
	if(!isdefined(param_00) || !scripts\mp\_utility::func_9F19(param_00) && !scripts\mp\_utility::issimultaneouskillenabled() || !isdefined(param_02) || !isdefined(param_01))
	{
		return;
	}

	var_03 = !scripts\mp\_utility::func_9F19(param_00) && scripts\mp\_utility::issimultaneouskillenabled();
	var_04 = undefined;
	if(level.gametype == "infect")
	{
		var_05 = [];
		var_05[var_05.size] = "passive_nuke";
	}
	else
	{
		var_05 = scripts\mp\_loot::func_804C(var_03);
		if(issubstr(param_02,"iw7_vr_mpl_range") && param_00 scripts\mp\_utility::_hasperk("passive_nuke"))
		{
			var_05[var_05.size] = "passive_nuke";
			var_04 = 1;
		}

		if(!isdefined(var_05) || var_05.size == 0)
		{
			return;
		}
	}

	var_06 = 0;
	foreach(var_08 in var_05)
	{
		if(var_08 == "passive_nuke")
		{
			var_06 = 1;
			break;
		}
	}

	if(!var_06)
	{
		return;
	}

	if(var_03)
	{
		waittillframeend;
		if(!scripts\mp\_utility::func_9FB3(self.simultaneouskill))
		{
			return;
		}
	}

	if(!isdefined(param_00.pers["passive_nuke_key"]))
	{
		param_00.pers["passive_nuke_key"] = 1;
	}
	else
	{
		param_00.pers["passive_nuke_key"]++;
	}

	if(isdefined(var_04) && param_00.pers["passive_nuke_key"] == 15)
	{
		param_00 thread func_C1C8();
	}

	if(param_00.pers["passive_nuke_key"] >= 25)
	{
		param_00 func_3E2F("passive_nuke");
		param_00 thread scripts\mp\_hud_message::func_10134("nuke");
		param_00 scripts\mp\killstreaks\_killstreaks::func_26D4("nuke",param_00);
		param_00.pers["passive_nuke_key"] = 0;
		param_00 scripts\mp\_missions::func_D991("ch_darkops_nuke");
		return;
	}

	if(param_00.pers["passive_nuke_key"] == 24)
	{
		param_00 thread scripts\mp\_hud_message::func_10151("nuke_kill_single");
		return;
	}

	if(param_00.pers["passive_nuke_key"] == 2)
	{
		param_00 thread func_C1C8();
		return;
	}

	if(param_00.pers["passive_nuke_key"] >= 20)
	{
		param_00 thread func_C1C8();
		return;
	}

	if(param_00.pers["passive_nuke_key"] >= 5)
	{
		if(param_00.pers["passive_nuke_key"] % 5 == 0)
		{
			param_00 thread func_C1C8();
			return;
		}

		return;
	}
}

//Function Number: 92
func_C1C8()
{
	var_00 = 25 - self.pers["passive_nuke_key"];
	thread scripts\mp\_hud_message::func_10151("nuke_kill",var_00);
}

//Function Number: 93
func_C1C7()
{
	self endon("disconnect");
	self waittill("death");
	if(scripts\mp\_utility::issimultaneouskillenabled())
	{
		scripts\common\utility::func_136F7();
	}

	self.pers["passive_nuke_key"] = undefined;
	clearpassivedeathwatching(self,"passive_nuke_key");
}

//Function Number: 94
setquadfeederpassive()
{
}

//Function Number: 95
quadfeederon()
{
	if(!scripts\mp\_utility::func_9FB3(self.quadfeeder))
	{
		self.quadfeeder = 1;
		func_F7D7("passive_berserk",1);
		scripts\mp\_utility::func_8387("specialty_overcharge");
		self method_85C1(65);
		var_00 = self method_85C0();
		if(var_00 < 0)
		{
			var_00 = 100;
		}

		var_00 = max(var_00 - 10,0);
		self player_recoilscaleon(int(var_00));
	}

	self notify("stop_quadFeeder_timer");
	thread timeoutquadfeeder(1.5);
}

//Function Number: 96
timeoutquadfeeder(param_00)
{
	self endon("end_quadFeederEffect");
	self endon("stop_quadFeeder_timer");
	self endon("death");
	self endon("disconnect");
	thread listencancelquadfeeder();
	wait(param_00);
	unsetquadfeedereffect();
}

//Function Number: 97
listencancelquadfeeder()
{
	self endon("end_quadFeederEffect");
	self endon("stop_quadFeeder_timer");
	self endon("disconnect");
	scripts\common\utility::waittill_any_3("death","weapon_change");
	unsetquadfeedereffect();
}

//Function Number: 98
unsetquadfeedereffect()
{
	if(scripts\mp\_utility::func_9FB3(self.quadfeeder))
	{
		self.quadfeeder = 0;
		func_F7D7("passive_berserk",undefined);
		scripts\mp\_utility::func_E150("specialty_overcharge");
		self method_85C2();
		var_00 = self method_85C0();
		var_00 = min(var_00 + 20,100);
		self player_recoilscaleon(int(var_00));
		self notify("end_quadFeederEffect");
	}
}

//Function Number: 99
unsetquadfeederpassive()
{
	self notify("end_quadFeederEffect");
	self notify("end_quadFeederPassive");
	unsetquadfeedereffect();
}

//Function Number: 100
func_F865()
{
}

//Function Number: 101
func_12D3B()
{
}

//Function Number: 102
func_F82A()
{
	var_00 = self getcurrentweapon();
	scripts\mp\_utility::func_1824("kill",0.1,var_00);
	thread func_4112(var_00);
}

//Function Number: 103
func_12D23()
{
	self notify("score_bonus_kills_removed");
}

//Function Number: 104
func_4112(param_00)
{
	self endon("disconnect");
	self waittill("score_bonus_kills_removed");
	scripts\mp\_utility::func_E165("kill",0.1,param_00);
}

//Function Number: 105
func_F82B()
{
	var_00 = [];
	foreach(var_06, var_02 in level.var_EC3A)
	{
		var_03 = issubstr(var_06,"_mode_");
		var_04 = issubstr(var_06,"_score");
		var_05 = var_02["value"];
		if(var_03 && var_04 && var_05 > 0)
		{
			var_00[var_00.size] = func_4A0B(var_06,0.2);
		}
	}

	foreach(var_08 in var_00)
	{
		scripts\mp\_utility::func_1824(var_08.var_67E5,var_08.var_2C80,var_08.var_394);
	}

	thread func_4113(var_00);
}

//Function Number: 106
func_12D24()
{
	self notify("score_bonus_objectives_removed");
}

//Function Number: 107
func_4A0B(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_67E5 = param_00;
	var_03.var_2C80 = param_01;
	var_03.var_394 = param_02;
	return var_03;
}

//Function Number: 108
func_4113(param_00)
{
	self endon("disconnect");
	self waittill("score_bonus_objectives_removed");
	foreach(var_02 in param_00)
	{
		scripts\mp\_utility::func_E165(var_02.var_67E5,var_02.var_2C80,var_02.var_394);
	}
}

//Function Number: 109
func_F746()
{
	self endon("passive_hivemind_cancel");
	func_12EAA(level.players);
	thread func_905E();
	thread func_905F();
}

//Function Number: 110
func_12CD1()
{
	foreach(var_01 in self.var_905B)
	{
		var_02 = self.var_905A[var_01];
		scripts\mp\_utility::func_C78F(var_01,var_02);
	}

	self.var_905B = undefined;
	self.var_905A = undefined;
	self notify("passive_hivemind_cancel");
}

//Function Number: 111
func_12EA9(param_00)
{
	func_12EAA([param_00]);
}

//Function Number: 112
func_12EAA(param_00)
{
	if(!isdefined(self.var_905B))
	{
		self.var_905B = [];
	}

	if(!isdefined(self.var_905A))
	{
		self.var_905A = [];
	}

	foreach(var_02 in param_00)
	{
		if(var_02 == self || !isdefined(self) || !isdefined(self.team) || !isdefined(var_02) || !isdefined(var_02.team))
		{
			continue;
		}

		var_03 = func_7F04(var_02);
		if(level.teambased && self.team == var_02.team && var_02.health > 0)
		{
			if(var_03 < 0)
			{
				wait(0.1);
				if(!isdefined(var_02))
				{
					continue;
				}

				var_04 = scripts\mp\_utility::func_C794(var_02,"cyan",self,0,1,"level_script");
				self.var_905B[self.var_905B.size] = var_04;
				self.var_905A[var_04] = var_02;
				thread func_905D(var_02);
				thread func_9060(var_02);
				thread func_905C(var_02);
			}

			continue;
		}

		if(var_03 >= 0)
		{
			var_05 = [];
			var_06 = [];
			scripts\mp\_utility::func_C78F(var_03,var_02);
			foreach(var_04 in self.var_905B)
			{
				var_08 = self.var_905A[var_04];
				if(var_08 == var_02)
				{
					continue;
				}

				var_05[var_05.size] = var_04;
				var_06[var_04] = var_08;
			}

			self.var_905B = var_05;
			self.var_905A = var_06;
			var_02 notify("passive_hivemind_listen_cancel");
		}
	}
}

//Function Number: 113
func_7F04(param_00)
{
	if(!isdefined(self.var_905B) || !isdefined(self.var_905A))
	{
		return -1;
	}

	foreach(var_02 in self.var_905B)
	{
		var_03 = self.var_905A[var_02];
		if(var_03 == param_00)
		{
			return var_02;
		}
	}

	return -1;
}

//Function Number: 114
func_905D(param_00)
{
	self endon("disconnect");
	self endon("passive_hivemind_cancel");
	param_00 endon("passive_hivemind_listen_cancel");
	param_00 waittill("disconnect");
	thread func_12EA9(param_00);
}

//Function Number: 115
func_9060(param_00)
{
	self endon("disconnect");
	self endon("passive_hivemind_cancel");
	param_00 endon("passive_hivemind_listen_cancel");
	param_00 waittill("joined_team");
	thread func_12EA9(param_00);
}

//Function Number: 116
func_905C(param_00)
{
	self endon("disconnect");
	self endon("passive_hivemind_cancel");
	param_00 endon("passive_hivemind_listen_cancel");
	param_00 waittill("death");
	thread func_12EA9(param_00);
}

//Function Number: 117
func_905E()
{
	self endon("disconnect");
	self endon("passive_hivemind_cancel");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		thread func_12EA9(var_00);
	}
}

//Function Number: 118
func_905F()
{
	self endon("disconnect");
	self endon("passive_hivemind_cancel");
	for(;;)
	{
		level waittill("joined_spectator",var_00);
		thread func_12EA9(var_00);
	}
}

//Function Number: 119
func_F74B()
{
	self endon("passive_hunter_killer_cancel");
	thread func_12EAE(level.players);
	thread func_91EA();
	foreach(var_01 in level.players)
	{
		thread func_91EC(var_01);
		thread func_91EB(var_01);
	}
}

//Function Number: 120
func_12CD4()
{
	self notify("passive_hunter_killer_cancel");
	foreach(var_01 in self.var_91E9)
	{
		var_02 = self.var_91E8[var_01];
		scripts\mp\_utility::func_C78F(var_01,var_02);
	}

	self.var_91E9 = undefined;
	self.var_91E8 = undefined;
}

//Function Number: 121
func_91EC(param_00)
{
	self endon("passive_hunter_killer_cancel");
	param_00 waittill("disconnect");
	thread func_12EAD(param_00);
}

//Function Number: 122
func_91EB(param_00)
{
	self endon("passive_hunter_killer_cancel");
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		thread func_12EAD(param_00);
	}
}

//Function Number: 123
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

//Function Number: 124
func_91EA()
{
	self endon("passive_hunter_killer_cancel");
	for(;;)
	{
		level waittill("connected",var_00);
		thread func_12EAD(var_00);
		thread func_91EC(var_00);
		thread func_91EB(var_00);
	}
}

//Function Number: 125
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

//Function Number: 126
func_12EAD(param_00)
{
	var_01 = [];
	var_01[var_01.size] = param_00;
	thread func_12EAE(var_01);
}

//Function Number: 127
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
		var_04 = var_02.maxhealth / 2;
		var_05 = var_02.health;
		if(level.teambased && self.team != var_02.team && var_05 <= var_04 && var_05 > 0)
		{
			if(var_03 < 0 && !var_02 scripts\mp\_utility::_hasperk("specialty_empimmune"))
			{
				var_06 = scripts\mp\_utility::func_C794(var_02,"red",self,1,0,"level_script");
				self.var_91E9[self.var_91E9.size] = var_06;
				self.var_91E8[var_06] = var_02;
				thread func_91ED(var_02);
			}

			continue;
		}

		if(var_03 >= 0)
		{
			var_07 = [];
			var_08 = [];
			scripts\mp\_utility::func_C78F(var_03,var_02);
			foreach(var_06 in self.var_91E9)
			{
				var_0A = self.var_91E8[var_06];
				if(var_0A == var_02)
				{
					continue;
				}

				var_07[var_07.size] = var_06;
				var_08[var_06] = var_0A;
			}

			self.var_91E9 = var_07;
			self.var_91E8 = var_08;
			var_02 notify("passive_hunter_killer_listen_cancel");
		}
	}
}

//Function Number: 128
func_F758()
{
}

//Function Number: 129
func_12CD9()
{
}

//Function Number: 130
unsetdoublekillsuperpassive()
{
	self notify("unset_passive_double_kill_super");
	self.passivedoublekillpending = undefined;
}

//Function Number: 131
setwallrunquieterpassive()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetWallrunQuieter");
	thread wallrunquieterwatchfordeath();
	for(;;)
	{
		if(self method_8446() || !self isonground())
		{
			if(!scripts\mp\_utility::func_9FB3(func_804E("passive_wallrun_quieter")))
			{
				func_F7D7("passive_wallrun_quieter",1);
				func_3E2F("passive_wallrun_quieter","_start");
				scripts\mp\_utility::func_8387("specialty_quieter");
			}
		}
		else if(scripts\mp\_utility::func_9FB3(func_804E("passive_wallrun_quieter")))
		{
			func_F7D7("passive_wallrun_quieter",undefined);
			func_3E2F("passive_wallrun_quieter","_end");
			scripts\mp\_utility::func_E150("specialty_quieter");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 132
wallrunquieterwatchfordeath()
{
	self endon("disconnect");
	self endon("unsetWallrunQuieter");
	self waittill("death");
	func_F7D7("passive_wallrun_quieter",undefined);
}

//Function Number: 133
unsetwallrunquieterpassive()
{
	self notify("unsetWallrunQuieter");
	if(scripts\mp\_utility::func_9FB3(func_804E("passive_wallrun_quieter")))
	{
		func_F7D7("passive_wallrun_quieter",undefined);
		func_3E2F("passive_wallrun_quieter","_end");
		scripts\mp\_utility::func_E150("specialty_quieter");
	}
}

//Function Number: 134
setslideblastshield()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetSlideBlastShield");
	thread slideblastshieldwatchfordeath();
	var_00 = undefined;
	for(;;)
	{
		var_01 = self getstance();
		if(self method_81BE() || (var_01 == "crouch" || var_01 == "prone") && self isonground())
		{
			var_00 = undefined;
			if(!scripts\mp\_utility::func_9FB3(func_804E("passive_slide_blastshield")))
			{
				func_F7D7("passive_slide_blastshield",1);
				func_3E2F("passive_slide_blastshield","_start");
				scripts\mp\_utility::func_8387("specialty_blastshield");
			}
		}
		else if(!isdefined(var_00))
		{
			var_00 = gettime() + 250;
		}
		else if(gettime() >= var_00)
		{
			if(scripts\mp\_utility::func_9FB3(func_804E("passive_slide_blastshield")))
			{
				func_F7D7("passive_slide_blastshield",undefined);
				func_3E2F("passive_slide_blastshield","_end");
				scripts\mp\_utility::func_E150("specialty_blastshield");
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 135
slideblastshieldwatchfordeath()
{
	self endon("disconnect");
	self endon("unsetSlideBlastShield");
	self waittill("death");
	func_F7D7("passive_slide_blastshield",undefined);
}

//Function Number: 136
unsetslideblastshield()
{
	self notify("unsetSlideBlastShield");
	if(scripts\mp\_utility::func_9FB3(func_804E("passive_slide_blastshield")))
	{
		func_F7D7("passive_slide_blastshield",undefined);
		func_3E2F("passive_slide_blastshield","_end");
		scripts\mp\_utility::func_E150("specialty_blastshield");
	}
}

//Function Number: 137
setproneblindeye()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetProneBlindEye");
	thread proneblindeyewatchfordeath();
	var_00 = undefined;
	for(;;)
	{
		if(self getstance() == "prone")
		{
			if(!isdefined(var_00))
			{
				var_00 = gettime() + 600;
			}
			else if(gettime() >= var_00)
			{
				if(!scripts\mp\_utility::func_9FB3(func_804E("passive_prone_blindeye")))
				{
					func_F7D7("passive_prone_blindeye",1);
					func_3E2F("passive_prone_blindeye","_start");
					scripts\mp\_utility::func_8387("specialty_blindeye");
				}
			}
		}
		else
		{
			var_00 = undefined;
			if(scripts\mp\_utility::func_9FB3(func_804E("passive_prone_blindeye")))
			{
				func_F7D7("passive_prone_blindeye",undefined);
				func_3E2F("passive_prone_blindeye","_end");
				scripts\mp\_utility::func_E150("specialty_blindeye");
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 138
proneblindeyewatchfordeath()
{
	self endon("disconnect");
	self endon("unsetProneBlindEye");
	self waittill("death");
	func_F7D7("passive_prone_blindeye",undefined);
}

//Function Number: 139
unsetproneblindeye()
{
	self notify("unsetProneBlindEye");
	if(scripts\mp\_utility::func_9FB3(func_804E("passive_prone_blindeye")))
	{
		func_F7D7("passive_prone_blindeye",undefined);
		func_3E2F("passive_prone_blindeye","_end");
		scripts\mp\_utility::func_E150("specialty_blindeye");
	}
}

//Function Number: 140
setstationaryengineer()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetStationaryEngineer");
	thread stationaryengineerwatchfordeath();
	var_00 = undefined;
	for(;;)
	{
		var_01 = self getstance();
		if(var_01 == "crouch" || var_01 == "prone" || lengthsquared(self getvelocity()) == 0)
		{
			if(!isdefined(var_00))
			{
				var_00 = gettime() + 750;
			}
			else if(gettime() > var_00)
			{
				if(!scripts\mp\_utility::func_9FB3(func_804E("passive_stationary_engineer")))
				{
					func_F7D7("passive_stationary_engineer",1);
					func_3E2F("passive_stationary_engineer","_start");
					scripts\mp\_utility::func_8387("specialty_engineer");
				}
			}
		}
		else
		{
			var_00 = undefined;
			if(scripts\mp\_utility::func_9FB3(func_804E("passive_stationary_engineer")))
			{
				func_F7D7("passive_stationary_engineer",undefined);
				func_3E2F("passive_stationary_engineer","_end");
				scripts\mp\_utility::func_E150("specialty_engineer");
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 141
unsetstationaryengineer()
{
	self notify("unsetStationaryEngineer");
	if(scripts\mp\_utility::func_9FB3(func_804E("passive_stationary_engineer")))
	{
		func_F7D7("passive_stationary_engineer",undefined);
		func_3E2F("passive_stationary_engineer","_end");
		scripts\mp\_utility::func_E150("specialty_engineer");
	}
}

//Function Number: 142
stationaryengineerwatchfordeath()
{
	self endon("disconnect");
	self endon("unsetStationaryEngineer");
	self waittill("death");
	func_F7D7("passive_stationary_engineer",undefined);
}

//Function Number: 143
setdoppleganger()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetDoppleganger");
	thread dopplegangerwatchfordeath();
	scripts\common\utility::func_136F7();
}

//Function Number: 144
dopplegangerwatchfordeath()
{
	self endon("disconnect");
	self endon("unsetDoppleganger");
	self waittill("death");
	func_F7D7("passive_doppleganger",undefined);
}

//Function Number: 145
unsetdoppleganger()
{
	self notify("unsetDoppleganger");
	if(scripts\mp\_utility::func_9FB3(func_804E("passive_doppleganger")))
	{
		func_F7D7("passive_doppleganger",undefined);
		func_3E2F("passive_doppleganger","_end");
		scripts\mp\_utility::func_E150("specialty_doppleganger");
	}
}

//Function Number: 146
setcollatstreak()
{
	func_F7D7("passive_collat_streak",::collatstreakgive);
}

//Function Number: 147
unsetcollatstreak()
{
	self.lastcollattime = undefined;
	func_F7D7("passive_collat_streak",undefined);
}

//Function Number: 148
collatstreakgive()
{
	if(!isdefined(self.lastcollattime) || self.lastcollattime < gettime())
	{
		scripts\mp\killstreaks\_killstreaks::func_26D4("venom",self);
		scripts\mp\_hud_message::func_10134("venom");
		self.lastcollattime = gettime();
	}
}

//Function Number: 149
func_F884()
{
}

//Function Number: 150
func_12D48()
{
}

//Function Number: 151
func_F85C(param_00,param_01,param_02,param_03)
{
	if(!isdefined(self.var_10B40))
	{
		self.var_10B40 = [];
	}

	if(!isdefined(self.var_10B40[param_00]))
	{
		var_04 = spawnstruct();
		var_04.var_92B8 = param_00;
		var_04.var_10B3F = param_01;
		var_04.var_10B3E = param_02;
		var_04.var_4F60 = param_03;
		self.var_10B40[param_00] = var_04;
	}
}

//Function Number: 152
func_8154(param_00)
{
	if(!isdefined(self.var_10B40))
	{
		return undefined;
	}

	if(!isdefined(self.var_10B40[param_00]))
	{
		return undefined;
	}

	var_01 = self.var_10B40[param_00];
	return var_01;
}

//Function Number: 153
func_8152(param_00)
{
	var_01 = func_8154(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return var_01.var_10B3E;
}

//Function Number: 154
func_182C(param_00,param_01)
{
}

//Function Number: 155
func_89EB(param_00,param_01)
{
	var_02 = param_00.var_A684.size + 1;
	if(var_02 >= 5)
	{
		var_03 = weaponclipsize(param_01);
		var_04 = int(max(var_03 * 0.2,1));
		var_05 = param_00 getweaponammostock(param_01);
		param_00 setweaponammostock(param_01,var_05 + var_04);
		param_00 scripts\mp\_hud_message::func_1013D("scavenger");
	}
}

//Function Number: 156
func_89C8(param_00,param_01)
{
	var_02 = "passive_move_speed_on_kill";
	param_00 notify(var_02);
	param_00 endon(var_02);
	if(!isdefined(param_00.var_13CB3) || param_00.var_13CB3 != 0.04)
	{
		param_00.var_13CB3 = 0.04;
		param_00 scripts\mp\_weapons::func_12ED5();
	}

	param_00 scripts\common\utility::waittill_any_timeout_1(3.5,"death","disconnect");
	if(!isdefined(param_00))
	{
		return;
	}

	param_00.var_13CB3 = 0;
	param_00 scripts\mp\_weapons::func_12ED5();
	param_00 func_3E2F("passive_move_speed_on_kill");
}

//Function Number: 157
func_8988(param_00)
{
	param_00 scripts\mp\_utility::func_DE39(2.5);
	param_00 func_3E2F("passive_cooldown_on_kill");
}

//Function Number: 158
func_89B1(param_00)
{
	param_00 notify("force_regeneration");
	param_00 func_3E2F("passive_health_regen_on_kill");
}

//Function Number: 159
func_89DB(param_00,param_01)
{
	if(!isdefined(param_00) || !scripts\mp\_utility::func_9F19(param_00) || !isdefined(param_01))
	{
		return;
	}

	if(!getpassivedeathwatching(param_00,"passive_refresh_key"))
	{
		param_00 thread func_DE76();
		param_00 setpassivedeathwatching(param_00,"passive_refresh_key",1);
	}

	if(!isdefined(param_00.pers["passive_refresh_key"]))
	{
		param_00.pers["passive_refresh_key"] = 1;
	}
	else
	{
		param_00.pers["passive_refresh_key"]++;
	}

	if(param_00.pers["passive_refresh_key"] >= 5)
	{
		param_00 func_3E2F("passive_refresh");
		param_00 thread scripts\mp\_hud_message::func_10134("refresh");
		param_00 scripts\mp\_powers::func_1813(1);
		param_00.pers["passive_refresh_key"] = 0;
		return;
	}

	if(param_00.pers["passive_refresh_key"] == 4)
	{
		param_00 thread scripts\mp\_hud_message::func_10151("refresh_kill_single");
		return;
	}

	if(param_00.pers["passive_refresh_key"] == 3)
	{
		param_00 thread func_DE77();
		return;
	}
}

//Function Number: 160
func_DE77()
{
	var_00 = 5 - self.pers["passive_refresh_key"];
	thread scripts\mp\_hud_message::func_10151("refresh_kill",var_00);
}

//Function Number: 161
func_DE76()
{
	self endon("disconnect");
	self waittill("death");
	self.pers["passive_refresh_key"] = undefined;
	clearpassivedeathwatching(self,"passive_refresh_key");
}

//Function Number: 162
func_89B3(param_00,param_01)
{
	if(!isdefined(param_00) || !scripts\mp\_utility::func_9F19(param_00) || !isdefined(param_01))
	{
		return;
	}

	var_02 = param_01.name;
	if(func_115E9(param_00,param_01))
	{
		return;
	}

	if(!isdefined(param_00.var_903C))
	{
		param_00.var_903C = [];
	}
	else if(func_903B(param_00,var_02))
	{
		return;
	}

	param_00.var_903C[param_00.var_903C.size] = var_02;
	var_03 = 0;
	var_04 = 0;
	foreach(var_06 in level.players)
	{
		if(func_115E9(param_00,var_06))
		{
			continue;
		}

		var_07 = var_06.name;
		if(func_903B(param_00,var_07))
		{
			var_03++;
		}

		var_04++;
	}

	var_09 = var_04 - var_03;
	if(var_09 <= 3)
	{
		param_00 func_903E(var_09);
	}

	if(var_09 <= 0)
	{
		var_0A = 0;
		if(var_04 >= 3)
		{
			var_0A = 200;
		}
		else if(var_04 >= 2)
		{
			var_0A = 100;
		}
		else
		{
			var_0A = 75;
		}

		var_0B = var_0A * var_04;
		param_00 func_3E2F("passive_hitman");
		param_00 thread scripts\mp\_supers::func_83AA(var_0B);
		param_00.var_903C = [];
	}
}

//Function Number: 163
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

//Function Number: 164
func_903E(param_00)
{
	param_00 = int(max(0,param_00));
	switch(param_00)
	{
		case 0:
			thread scripts\mp\_hud_message::func_10134("hitman_kill_all");
			break;

		case 1:
			thread scripts\mp\_hud_message::func_10151("hitman_kill_single");
			break;

		default:
			thread scripts\mp\_hud_message::func_10151("hitman_kill",param_00);
			break;
	}
}

//Function Number: 165
func_903D()
{
	self endon("disconnect");
	self waittill("death");
	self.var_903C = undefined;
}

//Function Number: 166
func_89E0(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	param_01 endon("diconnect");
	param_00 lib_0D6B::func_49AD(param_00,param_01,"scorestreak");
	param_00 func_3E2F("passive_scorestreak_pack");
	func_3E2F("passive_scorestreak_pack");
}

//Function Number: 167
func_89AB(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	param_01 endon("diconnect");
	level thread func_89AA(param_01);
	wait(0.05);
	var_02 = param_01 method_8113();
	if(isdefined(var_02))
	{
		var_02 hide();
		var_02.var_CA6C = 1;
	}

	func_3E2F("passive_gore");
}

//Function Number: 168
func_89AA(param_00)
{
	var_01 = param_00 gettagorigin("j_spine4");
	if(param_00.var_AE62 == "archetype_scout")
	{
		playfx(level._effect["passive_gore_robot"],var_01,(1,0,0));
	}
	else
	{
		playfx(level._effect["passive_gore"],var_01,(1,0,0));
	}

	playsoundatpos(var_01,"gib_fullbody");
	scripts\mp\_shellshock::func_1245(0.5,1.5,var_01,120);
}

//Function Number: 169
func_89E7(param_00,param_01)
{
	param_00 func_3E2F("passive_pack_scorestreak");
}

//Function Number: 170
func_89E6(param_00,param_01)
{
}

//Function Number: 171
func_89AF(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!scripts\mp\_utility::func_9E27(param_00,param_04,param_03,param_01))
	{
	}
}

//Function Number: 172
func_89D9(param_00,param_01)
{
	if(!isdefined(param_00) || !scripts\mp\_utility::func_9F19(param_00) || !isdefined(param_01))
	{
		return;
	}

	if(!getpassivedeathwatching(param_00,"passive_random_perks_key"))
	{
		param_00 thread func_DCC3();
		param_00 setpassivedeathwatching(param_00,"passive_random_perks_key",1);
	}

	if(!isdefined(param_00.pers["passive_random_perks_key"]))
	{
		param_00.var_DCC2 = [];
		param_00.pers["passive_random_perks_key"] = 1;
	}
	else
	{
		if(isdefined(param_00.var_DCC2) && param_00.var_DCC2.size >= 3)
		{
			return;
		}

		param_00.pers["passive_random_perks_key"]++;
	}

	if(!isdefined(param_00.var_DCC2))
	{
		param_00.var_DCC2 = [];
	}

	if(param_00.pers["passive_random_perks_key"] >= 3)
	{
		var_02 = param_00 scripts\mp\perks\_perks::func_7DE8();
		if(isdefined(var_02) && var_02.size > 0)
		{
			var_03 = randomintrange(0,var_02.size - 1);
			var_04 = var_02[var_03];
			if(!isdefined(var_04))
			{
				return;
			}

			param_00 func_3E2F("passive_random_perks","_" + var_04);
			param_00 scripts\mp\_utility::func_8387(var_04);
			var_05 = scripts\common\utility::func_116D7(isdefined(param_00.var_DCC2),param_00.var_DCC2.size,0);
			param_00.var_DCC2[var_05] = var_04;
		}

		param_00.pers["passive_random_perks_key"] = 0;
	}
}

//Function Number: 173
func_11753(param_00)
{
	var_01 = param_00 scripts\mp\perks\_perks::func_7DE8();
	if(isdefined(var_01) && var_01.size > 0)
	{
		foreach(var_03 in var_01)
		{
			func_11751("passive_random_perks","_" + var_03);
		}
	}
}

//Function Number: 174
func_DCC3()
{
	self endon("disconnect");
	self waittill("death");
	if(isdefined(self.var_DCC2))
	{
		foreach(var_01 in self.var_DCC2)
		{
			scripts\mp\_utility::func_E150(var_01);
		}
	}

	self.var_DCC2 = undefined;
	self.pers["passive_random_perks_key"] = undefined;
	clearpassivedeathwatching(self,"passive_random_perks_key");
}

//Function Number: 175
handlespecialistpassive(param_00,param_01)
{
	if(!isdefined(param_00) || !scripts\mp\_utility::func_9F19(param_00) || !isdefined(param_01))
	{
		return;
	}

	if(!getpassivedeathwatching(param_00,"passive_mini_specialist_key"))
	{
		param_00 thread specialistpassivedeathwatcher();
		param_00 setpassivedeathwatching(param_00,"passive_mini_specialist_key",1);
	}

	if(!isdefined(param_00.pers["passive_mini_specialist_key"]))
	{
		param_00.minispecialistkillperks = [];
		param_00.pers["passive_mini_specialist_key"] = 1;
	}
	else
	{
		if(isdefined(param_00.minispecialistkillperks) && param_00.minispecialistkillperks.size >= 3)
		{
			return;
		}

		param_00.pers["passive_mini_specialist_key"]++;
	}

	var_02 = scripts\common\utility::func_116D7(param_00 scripts\mp\_utility::_hasperk("specialty_hardline"),1,0);
	if(!isdefined(param_00.minispecialistkillperks))
	{
		param_00.minispecialistkillperks = [];
	}

	var_03 = undefined;
	if(param_00.pers["passive_mini_specialist_key"] >= 14 && !param_00 scripts\mp\_utility::_hasperk("passive_nuke"))
	{
		param_00 scripts\mp\_utility::func_8387("passive_nuke");
		if(isdefined(param_00.pers["passive_nuke_key"]))
		{
			param_00.pers["passive_nuke_key"] = param_00.pers["passive_nuke_key"] + 14;
		}
		else
		{
			param_00.pers["passive_nuke_key"] = 14;
		}
	}
	else if(param_00.pers["passive_mini_specialist_key"] >= 8 - var_02 && !param_00 scripts\mp\_utility::_hasperk("passive_double_kill_reload") && !param_00 scripts\mp\_utility::_hasperk("passive_stationary_engineer") && !param_00 scripts\mp\_utility::_hasperk("passive_jump_super"))
	{
		param_00 scripts\mp\_utility::func_8387("passive_double_kill_reload");
		param_00 scripts\mp\_utility::func_8387("passive_stationary_engineer");
		param_00 scripts\mp\_utility::func_8387("passive_jump_super");
		param_00 thread scripts\mp\_hud_message::func_10151("specialty_specialist");
	}
	else if(param_00.pers["passive_mini_specialist_key"] >= 6 - var_02 && !param_00 scripts\mp\_utility::_hasperk("specialty_silentkill"))
	{
		var_03 = "specialty_silentkill";
		param_00 scripts\mp\_utility::func_8387(var_03);
	}
	else if(param_00.pers["passive_mini_specialist_key"] >= 4 - var_02 && !param_00 scripts\mp\_utility::_hasperk("passive_wallrun_quieter"))
	{
		var_03 = "passive_wallrun_quieter";
		param_00 scripts\mp\_utility::func_8387(var_03);
	}
	else if(param_00.pers["passive_mini_specialist_key"] >= 2 - var_02 && !param_00 scripts\mp\_utility::_hasperk("passive_move_speed"))
	{
		var_03 = "passive_move_speed";
		param_00 scripts\mp\_utility::func_8387(var_03);
	}

	if(isdefined(var_03))
	{
		param_00 func_3E2F("passive_mini_specialist","_" + var_03);
	}
}

//Function Number: 176
specialistpassivedeathwatcher()
{
	self endon("disconnect");
	self waittill("death");
	if(isdefined(self.minispecialistkillperks))
	{
		foreach(var_01 in self.minispecialistkillperks)
		{
			scripts\mp\_utility::func_E150(var_01);
		}
	}

	self.minispecialistkillperks = undefined;
	self.pers["passive_mini_specialist_key"] = undefined;
	clearpassivedeathwatching(self,"passive_mini_specialist_key");
}

//Function Number: 177
func_89B0(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01) || !isdefined(param_00) || !param_01 scripts\mp\_utility::_hasperk("passive_headshot_super"))
	{
		return;
	}

	if(!scripts\mp\_utility::func_9E27(param_00,param_04,param_03,param_01))
	{
		return;
	}

	param_01 thread scripts\mp\_supers::func_83AA(100);
	param_01 func_3E2F("passive_headshot_super");
}

//Function Number: 178
func_89A3(param_00,param_01,param_02)
{
	var_03 = spawn("trigger_radius",param_01.origin,0,50,100);
	var_03.var_222 = param_00;
	scripts\mp\_utility::func_D548(param_00.team,param_01.origin,"player_plasma_friendly","player_plasma_enemy",5);
	var_03 thread func_AD70(param_02);
	var_03 thread func_AD71();
	param_00 func_3E2F("passive_fire_kill");
}

//Function Number: 179
func_AD70(param_00)
{
	self endon("passive_fire_kill_delete");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!isdefined(var_01) || !isdefined(self) || !isdefined(self.var_222))
		{
			break;
		}

		if(!isplayer(var_01))
		{
			continue;
		}

		if(func_115E9(self.var_222,var_01))
		{
			continue;
		}

		var_02 = var_01 func_804E("passive_fire_kill");
		if(var_02 <= 0)
		{
			var_01 thread func_10D9E(param_00,self.var_222,"passive_fire_kill","player_plasma_friendly","player_plasma_enemy","j_mainroot","player_plasma_screen_stand");
			var_01 thread func_10D82(param_00,self.var_222,5,0.5,4,"passive_fire_kill");
			continue;
		}

		func_F7D7("passive_fire_kill",4);
	}
}

//Function Number: 180
func_AD71()
{
	wait(5);
	if(!isdefined(self))
	{
		return;
	}

	self notify("passive_fire_kill_delete");
	self delete();
}

//Function Number: 181
func_3E01()
{
	if(scripts\mp\_utility::_hasperk("passive_critical_chance_damage"))
	{
		if(randomintrange(1,10) == 1)
		{
			scripts\mp\_utility::func_8387("specialty_moredamage");
		}
	}

	if(scripts\mp\_utility::_hasperk("passive_critical_sequential_damage"))
	{
		if(func_804E("passive_critical_sequential_damage") >= 4)
		{
			func_F7D7("passive_critical_sequential_damage",-1);
			scripts\mp\_utility::func_8387("specialty_moredamage");
		}
	}
}

//Function Number: 182
func_1174D()
{
	var_00 = self geteye();
	var_01 = anglestoforward(self getplayerangles());
	var_02 = 200;
	var_03 = var_01 * var_02;
	var_04 = func_11755(var_00,var_00 + var_03);
	var_05 = var_04 - var_00;
	var_06 = 25;
	var_07 = (0,0,0);
	var_08 = 100;
	var_09 = 0;
	var_0A = 1;
	var_0B = 0.15;
	for(;;)
	{
		var_09++;
		var_0C = var_00 + var_01 * var_06 * var_09;
		var_0D = var_0C - var_00;
		if(!func_1174A(var_05,var_0D))
		{
			break;
		}

		var_0E = var_0C + (0,0,var_08 * -1);
		var_0F = func_11755(var_0C,var_0E);
		if(var_0F == var_0E)
		{
			continue;
		}

		var_10 = var_0A + var_0B * var_09;
		scripts\mp\_utility::func_D548(self.team,var_0F,"player_plasma_friendly","player_plasma_enemy",var_10);
	}
}

//Function Number: 183
func_1174A(param_00,param_01)
{
	if(!func_11749(param_00[0],param_01[0]))
	{
		return 0;
	}

	if(!func_11749(param_00[1],param_01[1]))
	{
		return 0;
	}

	if(!func_11749(param_00[2],param_01[2]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 184
func_11749(param_00,param_01)
{
	if(param_00 > 0 && param_01 > param_00)
	{
		return 0;
	}

	if(param_00 < 0 && param_01 < param_00)
	{
		return 0;
	}

	return 1;
}

//Function Number: 185
func_11755(param_00,param_01)
{
	var_02 = scripts\common\trace::func_48BC(0,1,1,1,1,0,0);
	var_03 = function_0287(param_00,param_01,var_02,[self],0,"physicsquery_closest");
	if(isdefined(var_03) && var_03.size > 0)
	{
		return var_03[0]["position"];
	}

	return param_01;
}

//Function Number: 186
func_8974(param_00,param_01)
{
	if(!isdefined(param_00) || !scripts\mp\_utility::func_9F19(param_00) || !isdefined(param_01) || param_00.var_2049)
	{
		return;
	}

	if(param_00.var_204A == 0 && level.gametype != "infect" && isdefined(level.var_204B) && level.var_204B == 1)
	{
		param_00.var_204A = 1;
		param_00 thread scripts\mp\_hud_message::func_10151("specialty_scavenger");
		param_00 scripts\mp\_utility::func_8387("specialty_scavenger");
	}
	else
	{
		param_00.var_204A++;
	}

	if(param_00.var_204A == 3)
	{
		if(isdefined(level.var_204B) && level.var_204B > 2)
		{
			param_00 scripts\mp\_utility::func_8387("specialty_scavenger");
		}

		param_00 thread scripts\mp\_hud_message::func_10151("specialty_quickdraw");
		param_00 scripts\mp\_utility::func_8387("specialty_quickdraw");
	}

	if(param_00.var_204A == 5)
	{
		param_00 thread scripts\mp\_hud_message::func_10151("specialty_bulletaccuracy");
		param_00 scripts\mp\_utility::func_8387("specialty_bulletaccuracy");
	}

	if(param_00.var_204A == 7)
	{
		param_00 thread scripts\mp\_hud_message::func_10151("specialty_specialist");
		param_00 scripts\mp\_utility::func_8387("specialty_lightweight");
		param_00 scripts\mp\_utility::func_8387("specialty_quieter");
		param_00 scripts\mp\_utility::func_8387("specialty_selectivehearing");
		param_00 scripts\mp\_utility::func_8387("specialty_gung_ho");
		param_00.var_2049 = 1;
	}
}

//Function Number: 187
handlejumpsuperonkillpassive(param_00,param_01)
{
	if(param_00 isonground())
	{
		return;
	}

	if(param_00 method_8446())
	{
		return;
	}

	param_00 scripts\mp\_supers::func_83AA(100);
	param_00 func_3E2F("passive_jump_super");
}

//Function Number: 188
handlemeleesuperonkillpassive(param_00,param_01,param_02)
{
	if(param_02 != "MOD_MELEE")
	{
		return;
	}

	param_00 scripts\mp\_supers::func_83AA(500);
	param_00 func_3E2F("passive_melee_super");
}

//Function Number: 189
handledoublekillsuperpassive(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("unset_passive_double_kill_super");
	param_00 notify("watchDoubleKillSuperPassive");
	param_00 endon("watchDoubleKillSuperPassive");
	if(!scripts\mp\_utility::func_9FB3(param_00.passivedoublekillpending))
	{
		param_00.passivedoublekillpending = 1;
	}
	else
	{
		param_00.passivedoublekillpending = undefined;
		param_00 scripts\mp\_supers::func_83AA(200);
		param_00 func_3E2F("passive_double_kill_super");
		return;
	}

	wait(4);
	param_00.passivedoublekillpending = undefined;
}

//Function Number: 190
setmodeswitchkillweapon(param_00,param_01)
{
	if(!scripts\mp\_class::func_13C96(param_01,function_02C4(param_01),"passive_mode_switch_score") || scripts\mp\_class::func_13C96(param_01,function_02C4(param_01),"passive_mode_switch_score_epic"))
	{
		return;
	}

	var_02 = param_00.modeswitchkills;
	if(!isdefined(var_02))
	{
		resetmodeswitchkillweapons(param_00);
	}

	var_03 = getmodeswitchkillweaponkey(param_01);
	var_04 = var_02.arr[var_03];
	if(!isdefined(var_04))
	{
		var_04 = spawnstruct();
		var_04.var_C234 = 0;
		var_04.killinaltmode = undefined;
		var_02.arr[var_03] = var_04;
	}
}

//Function Number: 191
unsetmodeswitchkillweapon(param_00,param_01)
{
	var_02 = param_00.modeswitchkills;
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = getmodeswitchkillweaponkey(param_01);
	var_02.arr[var_03] = undefined;
}

//Function Number: 192
resetmodeswitchkillweapons(param_00)
{
	var_01 = spawnstruct();
	var_01.arr = [];
	param_00.modeswitchkills = var_01;
	thread watchmodeswitchkillweaponsdrop(param_00);
}

//Function Number: 193
watchmodeswitchkillweaponsdrop(param_00)
{
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 notify("watchModeSwitchKillWeaponsDrop");
	param_00 endon("watchModeSwitchKillWeaponsDrop");
	var_01 = param_00.modeswitchkills;
	for(;;)
	{
		var_02 = param_00 getweaponslistprimaries();
		var_03 = [];
		var_04 = [];
		for(var_05 = 0;var_05 < var_02.size;var_05++)
		{
			var_06 = var_02[var_05];
			var_03[var_05] = scripts\mp\_utility::func_8234(var_06);
			var_04[var_05] = function_02C4(var_06);
		}

		var_07 = getarraykeys(var_01.arr);
		var_08 = [];
		var_09 = [];
		for(var_05 = 0;var_05 < var_07.size;var_05++)
		{
			var_0A = var_07[var_05];
			var_0B = strtok(var_0A,"_");
			var_08[var_05] = var_0B[0];
			var_09[var_05] = var_0B[1];
		}

		for(var_05 = 0;var_05 < var_07.size;var_05++)
		{
			for(var_0C = 0;var_0C < var_02.size;var_0C++)
			{
				if(var_08[var_05] != var_03[var_0C])
				{
					continue;
				}

				if(var_09[var_05] != var_04[var_0C])
				{
					continue;
				}

				unsetmodeswitchkillweapon(param_00,var_02[var_0C]);
				break;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 194
updatemodeswitchweaponkills(param_00,param_01,param_02)
{
	var_03 = param_00.modeswitchkills;
	if(!isdefined(var_03))
	{
		return;
	}

	if(scripts\mp\_utility::func_8238(param_02) != "primary")
	{
		return;
	}

	var_04 = scripts\mp\_utility::func_8234(param_02);
	var_05 = function_02C4(param_02);
	if(!isdefined(var_05))
	{
		return;
	}

	var_06 = var_04 + "_" + var_05;
	var_07 = var_03.arr[var_06];
	if(!isdefined(var_07))
	{
		return;
	}

	var_08 = param_00 method_8519(param_02);
	if(!isdefined(var_07.killinaltmode) || var_07.killinaltmode == var_08)
	{
		var_07.var_C234++;
		if(var_07.var_C234 >= 2)
		{
			var_09 = var_07.var_C234 - 2;
			if(scripts\common\utility::func_B8F8(var_09,2) == 0)
			{
				param_00 func_3E2F("passive_mode_switch_score");
			}
		}
	}
	else
	{
		var_07.var_C234 = 1;
		if(param_00 scripts\mp\_utility::_hasperk("passive_mode_switch_score_epic"))
		{
			var_0A = "mode_switch_kill_epic";
		}
		else
		{
			var_0A = "mode_switch_kill";
		}

		param_00 thread scripts\mp\_rank::func_EC2D(var_0A);
		var_0B = scripts\mp\_rank::func_8104(var_0A);
		param_00 thread scripts\mp\_rank::func_EC42(var_0B);
		param_00 scripts\mp\killstreaks\_killstreaks::func_83A7(var_0A,var_0B);
	}

	var_07.killinaltmode = var_08;
}

//Function Number: 195
getmodeswitchkillweaponkey(param_00)
{
	return scripts\mp\_utility::func_8234(param_00) + "_" + function_02C4(param_00);
}

//Function Number: 196
handlemeleeconeexplodeonkillpassive(param_00,param_01,param_02,param_03)
{
	if(!param_00 method_8519(param_02))
	{
		return;
	}

	if(param_03 != "MOD_MELEE")
	{
		return;
	}

	var_04 = param_00 gettagorigin("j_spineupper");
	var_05 = param_00 getplayerangles();
	var_06 = anglestoforward(var_05);
	var_07 = anglestoup(var_05);
	var_08 = var_04 - var_06 * 128;
	var_09 = 453;
	thread meleeconeexplodeworldfx(var_04,var_05,param_00);
	thread meleeconeexplodeattackerfx(param_00);
	param_01 thread scripts\mp\_damage::enqueuecorpsetablefunc("passive_melee_cone_expl",::meleeconeexplodevictimcorpsefx);
	foreach(var_0B in level.players)
	{
		if(var_0B == param_00)
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9F19(var_0B))
		{
			continue;
		}

		if(!lib_0DF8::func_213D(param_00,var_0B))
		{
			continue;
		}

		if(level.var_740A == 0 && !scripts\mp\_utility::func_9FB3(scripts\mp\_utility::playersareenemies(param_00,var_0B)))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_D64B(var_0B gettagorigin("tag_eye"),var_08,var_06,var_07,var_09,128,18))
		{
			if(!scripts\mp\_utility::func_D64B(var_0B gettagorigin("tag_origin"),var_08,var_06,var_07,var_09,128,18))
			{
				if(!scripts\mp\_utility::func_D64B(var_0B gettagorigin("j_mainroot"),var_08,var_06,var_07,var_09,128,18))
				{
					continue;
				}
			}
		}

		if(var_0B method_808F(var_04,param_00) <= 0)
		{
			continue;
		}

		var_0C = min(325,distance(var_04,var_0B geteye()));
		var_0D = 1 - var_0C / 325;
		var_0E = 80 + var_0D * 60;
		var_0B dodamage(var_0E,var_04,param_00,param_00,"MOD_EXPLOSIVE",param_02);
		if(scripts\mp\_utility::func_9F19(var_0B))
		{
			thread meleeconeexplodevictimfx(var_0B);
			continue;
		}

		var_0B thread scripts\mp\_damage::enqueuecorpsetablefunc("passive_melee_cone_expl",::meleeconeexplodevictimcorpsefx);
	}
}

//Function Number: 197
meleeconeexplodeworldfx(param_00,param_01,param_02)
{
	var_03 = anglestoforward(param_01);
	param_00 = param_00 + var_03 * 10;
	var_04 = spawn("script_model",param_00);
	var_04.angles = param_01;
	var_04 method_831F(param_02);
	var_04 method_82DD(param_02);
	var_04 setmodel("passive_mp_meleeConeExpl");
	if(lib_0DF8::func_9DDF(param_02))
	{
		var_04 setscriptablepartstate("effects","activePhase");
	}
	else
	{
		var_04 setscriptablepartstate("effects","active");
	}

	wait(0.2);
	physicsexplosionsphere(param_00,128,0,1);
	wait(0.2);
	var_04 delete();
}

//Function Number: 198
meleeconeexplodeattackerfx(param_00)
{
	param_00 endon("disconnect");
	param_00 notify("meleeConeExplodeAttackerVfx");
	param_00 endon("meleeConeExplodeAttackerVfx");
	param_00 setscriptablepartstate("weaponPassiveMeleeConeExplAttacker","active");
	scripts\common\utility::waittill_any_timeout_1(0.2);
	param_00 setscriptablepartstate("weaponPassiveMeleeConeExplAttacker","neutral");
}

//Function Number: 199
meleeconeexplodevictimfx(param_00)
{
	param_00 endon("disconnect");
	param_00 notify("meleeConeExplodeVictimVfx");
	param_00 endon("meleeConeExplodeVictimVfx");
	param_00 setscriptablepartstate("weaponPassiveMeleeConeExplVictim","active",0);
	param_00 scripts\common\utility::waittill_any_timeout_1(2.75);
	param_00 setscriptablepartstate("weaponPassiveMeleeConeExplVictim","neutral",0);
}

//Function Number: 200
meleeconeexplodevictimcorpsefx(param_00)
{
	param_00 setscriptablepartstate("weaponPassiveMeleeConeExplVictim","active",0);
	wait(2.75);
	if(isdefined(param_00))
	{
		param_00 setscriptablepartstate("weaponPassiveMeleeConeExplVictim","neutral",0);
	}
}

//Function Number: 201
handleleaderkillscorepassive(param_00,param_01,param_02)
{
	if(scripts\mp\_utility::func_821D(param_02) != scripts\mp\_utility::func_821D(param_00 getcurrentprimaryweapon()))
	{
		return;
	}

	var_03 = [];
	if(!level.teambased)
	{
		var_03 = scripts\common\utility::func_22A9(level.players,param_00);
	}
	else
	{
		var_03 = scripts\mp\_utility::func_81A0(scripts\mp\_utility::getotherteam(param_00.team));
	}

	var_04 = 1;
	foreach(var_06 in var_03)
	{
		if(param_01.var_278 >= var_06.var_278)
		{
			continue;
		}

		var_04 = 0;
		break;
	}

	if(!var_04)
	{
		return;
	}

	var_08 = "leader_kill_" + int(min(var_03.size,5));
	param_00 thread scripts\mp\_rank::func_EC2D(var_08);
	var_09 = scripts\mp\_rank::func_8104(var_08);
	param_00 thread scripts\mp\_rank::func_EC42(var_09);
	param_00 scripts\mp\killstreaks\_killstreaks::func_83A7(var_08,var_09);
}

//Function Number: 202
handlepowermeleeondamagepassive(param_00,param_01,param_02,param_03)
{
	if(param_03 != "MOD_MELEE")
	{
		return;
	}

	var_04 = param_00 gettagorigin("j_spineupper");
	var_05 = param_00 getplayerangles();
	var_06 = anglestoforward(var_05);
	var_07 = anglestoup(var_05);
	thread meleeconeexplodeattackerfx(param_00);
	wait(0.01);
}