/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_agent_utils.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 51
 * Decompile Time: 2452 ms
 * Timestamp: 10/27/2023 12:09:13 AM
*******************************************************************/

//Function Number: 1
func_108E8(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = func_7EC5(param_00);
	if(isdefined(var_05))
	{
		var_05.var_4539 = gettime();
		var_05 func_F28D(var_05,param_00);
		var_05 func_F28F(var_05,param_00);
		var_05 func_10971();
		if(func_9CB3(param_00))
		{
			var_05 = func_107CF(var_05,param_00,param_02,param_03);
		}
		else
		{
			var_05 = func_107B2(var_05,param_02,param_03);
		}

		var_05 func_F8A9(param_00);
		var_05 func_F290(param_01);
		var_05 func_F28E(var_05,param_00);
		var_05 func_F291(var_05,param_00);
		var_05 func_184B();
		var_05 func_1601();
	}

	return var_05;
}

//Function Number: 2
func_F28D(param_00,param_01)
{
	param_00 detachall();
	if(isdefined(level.var_13F58) && level.agent_definition[param_01]["traversal_unit_type"] == "zombie")
	{
		param_00 [[ level.var_13F58 ]](param_01);
	}
	else
	{
		param_00 setmodel(level.agent_definition[param_01]["body_model"]);
		var_02 = strtok(level.agent_definition[param_01]["other_body_parts"]," ");
		foreach(var_04 in var_02)
		{
			param_00 attach(var_04,"",1);
		}
	}

	param_00 show();
}

//Function Number: 3
func_9CB3(param_00)
{
	return level.agent_definition[param_00]["animclass"] != "";
}

//Function Number: 4
func_107CF(param_00,param_01,param_02,param_03)
{
	param_00.var_C50F = param_00 func_10972("on_enter_animstate");
	param_00.var_9CB3 = 1;
	param_00 method_838E(param_02,param_03,level.agent_definition[param_01]["animclass"],15,60);
	return param_00;
}

//Function Number: 5
func_107B2(param_00,param_01,param_02)
{
	param_00.var_9CB3 = 0;
	param_00 method_838E(param_01,param_02);
	return param_00;
}

//Function Number: 6
func_9B53(param_00)
{
	return param_00.var_9CB3;
}

//Function Number: 7
func_9B5A()
{
	return isagent(self) && isdefined(self.var_1096F) && self.var_1096F == "alien";
}

//Function Number: 8
func_F8A9(param_00)
{
	var_01 = level.agent_definition[param_00];
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = var_01["setup_func"];
	if(!isdefined(var_02))
	{
		return;
	}

	self [[ var_02 ]]();
}

//Function Number: 9
func_18F3(param_00,param_01,param_02,param_03,param_04)
{
	if(func_9B53(self))
	{
		self method_8286(param_00);
		return;
	}

	self botsetscriptgoal(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 10
func_F28F(param_00,param_01)
{
	if(!isdefined(level.agent_funcs[param_01]))
	{
		level.agent_funcs[param_01] = [];
	}

	param_00.var_1096F = level.agent_definition[param_01]["species"];
	func_23B2("spawn",::func_5016);
	func_23B2("on_damaged",::func_5003);
	func_23B2("on_damaged_finished",::func_5004);
	func_23B2("on_killed",::func_5006);
}

//Function Number: 11
func_23B2(param_00,param_01)
{
	var_02 = self.agent_type;
	if(!isdefined(level.agent_funcs[var_02][param_00]))
	{
		if(!isdefined(level.var_10970[self.var_1096F]) || !isdefined(level.var_10970[self.var_1096F][param_00]))
		{
			level.agent_funcs[var_02][param_00] = param_01;
			return;
		}

		level.agent_funcs[var_02][param_00] = level.var_10970[self.var_1096F][param_00];
	}
}

//Function Number: 12
func_F28E(param_00,param_01)
{
	param_00 func_F28C(level.agent_definition[param_01]["health"]);
}

//Function Number: 13
func_F291(param_00,param_01)
{
	if(!func_384C(param_00))
	{
		return;
	}

	param_00 method_828C(level.agent_definition[param_01]["traversal_unit_type"]);
}

//Function Number: 14
func_384C(param_00)
{
	if(func_9B53(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 15
func_10971()
{
	if(isdefined(level.var_10970[self.var_1096F]) && isdefined(level.var_10970[self.var_1096F]["pre_spawn_init"]))
	{
		self [[ level.var_10970[self.var_1096F]["pre_spawn_init"] ]]();
	}
}

//Function Number: 16
func_7EC5(param_00)
{
	var_01 = undefined;
	if(isdefined(level.var_1900))
	{
		foreach(var_03 in level.var_1900)
		{
			if(!isdefined(var_03.var_9D25) || !var_03.var_9D25)
			{
				if(isdefined(var_03.var_136FD) && var_03.var_136FD)
				{
					continue;
				}

				var_01 = var_03;
				var_01.agent_type = param_00;
				var_01 func_97C2();
				break;
			}
		}
	}

	return var_01;
}

//Function Number: 17
func_97C2()
{
	self.pers = [];
	self.var_8BE2 = 0;
	self.var_9D25 = 0;
	self.var_10916 = 0;
	self.var_6640 = self getentitynumber();
	self.var_18F2 = 0;
	self detachall();
	func_98BB();
}

//Function Number: 18
func_98BB()
{
	self.var_4004 = undefined;
	self.var_BCF6 = undefined;
	self.var_26B9 = undefined;
	self.var_86BD = undefined;
	self.name = undefined;
	self.var_EB6A = undefined;
	self.var_CA5B = undefined;
	self.var_13CA0 = undefined;
	self.var_C2AD = undefined;
	self.sessionteam = undefined;
	self.sessionstate = undefined;
	self.var_55E6 = undefined;
	self.disabledweaponswitch = undefined;
	self.var_55D9 = undefined;
	self.var_55E4 = 1;
	self.nocorpse = undefined;
	self.ignoreme = 0;
	self.var_180 = 0;
	self.var_116D4 = undefined;
	self.var_441A = undefined;
	self.var_4B82 = undefined;
	self.do_immediate_ragdoll = undefined;
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
}

//Function Number: 19
func_F290(param_00,param_01)
{
	self.team = param_00;
	self.var_20 = param_00;
	self.pers["team"] = param_00;
	self.var_222 = param_01;
	self method_831F(param_01);
	self method_82DD(param_01);
}

//Function Number: 20
func_184B()
{
	for(var_00 = 0;var_00 < level.var_3CB5.size;var_00++)
	{
		if(level.var_3CB5[var_00] == self)
		{
			return;
		}
	}

	level.var_3CB5[level.var_3CB5.size] = self;
}

//Function Number: 21
func_1908(param_00)
{
	return level.agent_funcs[self.agent_type][param_00];
}

//Function Number: 22
func_10972(param_00)
{
	return level.var_10970[self.var_1096F][param_00];
}

//Function Number: 23
func_1313C(param_00)
{
	if(isagent(param_00) && !isdefined(param_00.var_9D25) || !param_00.var_9D25)
	{
		return undefined;
	}

	if(isagent(param_00) && !isdefined(param_00.classname))
	{
		return undefined;
	}

	return param_00;
}

//Function Number: 24
func_F28C(param_00)
{
	self.var_1E = param_00;
	self.health = param_00;
	self.maxhealth = param_00;
}

//Function Number: 25
func_5016(param_00,param_01,param_02)
{
	var_03 = func_108E8("soldier","axis",param_00,param_01);
	if(!isdefined(var_03))
	{
		return undefined;
	}

	var_03 botsetscriptgoal(var_03.origin,0,"hunt");
	var_03 botsetstance("stand");
	var_03 method_83B7();
	if(isdefined(param_02))
	{
		var_03 giveweapon(param_02);
	}
	else
	{
		var_03 giveweapon("iw6_dlcweap02_mp");
	}

	var_03 method_804D("maxInaccuracy",4.5);
	var_03 method_804D("minInaccuracy",2.25);
	return var_03;
}

//Function Number: 26
func_5003(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(func_9BEA(var_0C,param_00))
	{
		return;
	}

	param_02 = scripts\cp\_damage::func_F29B(param_04,param_05,param_02,param_01,param_03,param_06,param_07,param_08,param_09,param_00);
	if(isplayer(param_01) && !scripts\cp\_utility::func_9CEB(param_00,param_05,var_0C))
	{
		param_02 = scripts\cp\_damage::func_EB9D(param_01,param_02,param_04,param_05);
		param_02 = scripts\cp\_damage::func_EB9F(param_01,param_02,param_04,param_05,param_08);
	}

	param_02 = func_E54A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	param_02 = scripts\cp\_damage::func_EB9E(param_01,param_02);
	param_02 = int(param_02);
	func_D96E(param_01,param_02,param_04);
	func_D96D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	func_D96B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,var_0C);
	var_0C [[ level.agent_funcs[var_0C.agent_type]["on_damaged_finished"] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,0,param_0A,param_0B);
}

//Function Number: 27
func_E54A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	param_0A.var_E54C = undefined;
	if(param_08 == "shield")
	{
		param_0A.var_E54C = 1;
		param_02 = 0;
	}

	return param_02;
}

//Function Number: 28
func_D96E(param_00,param_01,param_02)
{
	if(isdefined(level.var_12D84))
	{
		[[ level.var_12D84 ]](param_00,param_01,param_02);
	}
}

//Function Number: 29
func_5004(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	self method_80E9(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C);
	var_0D = scripts\cp\_utility::func_9CEB(param_00,param_05);
	if(isdefined(param_01))
	{
		if(isplayer(param_01) || isdefined(param_01.var_222) && isplayer(param_01.var_222))
		{
			if(!var_0D)
			{
				param_01 scripts\cp\_damage::func_3D9D(self,param_05,param_04);
			}
		}
	}

	return 1;
}

//Function Number: 30
func_9BEA(param_00,param_01)
{
	if(isdefined(param_01))
	{
		if(isdefined(param_01.team) && param_01.team == param_00.team)
		{
			return 1;
		}

		if(isdefined(param_01.var_222) && isdefined(param_01.var_222.team) && param_01.var_222.team == param_00.team)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 31
func_5006(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	func_C4B3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
	func_4DDB();
}

//Function Number: 32
func_8008(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	var_01 = func_7D95(param_00);
	return var_01.size;
}

//Function Number: 33
func_7D95(param_00)
{
	var_01 = [];
	if(!isdefined(level.var_1900))
	{
		return var_01;
	}

	foreach(var_03 in level.var_1900)
	{
		if(isdefined(var_03.var_9D25) && var_03.var_9D25)
		{
			if(param_00 == "all" || var_03.agent_type == param_00)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 34
func_7DB0(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_1900)
	{
		if(isalive(var_03) && isdefined(var_03.team) && var_03.team == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 35
func_7D94(param_00)
{
	var_01 = [];
	if(!isdefined(level.var_1900))
	{
		return var_01;
	}

	foreach(var_03 in level.var_1900)
	{
		if(isdefined(var_03.var_9D25) && var_03.var_9D25)
		{
			if(var_03.var_1096F == param_00)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 36
func_7DAF()
{
	var_00 = [];
	foreach(var_02 in level.var_1900)
	{
		if(isalive(var_02))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 37
func_1601()
{
	self.var_9D25 = 1;
}

//Function Number: 38
func_C4B3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(scripts\common\utility::istrue(self.var_8C1F))
	{
		scripts\cp\_utility::func_AAB5(param_02,param_03);
		if(!param_09)
		{
			var_0A = self method_80B8(self getcurrentweapon());
			if(isdefined(var_0A))
			{
				var_0A thread func_51CC();
				var_0A.var_222 = self;
				var_0A.var_C83A = param_01;
				var_0A makeunusable();
			}
		}
	}

	if(isdefined(self.nocorpse))
	{
		return;
	}

	var_0B = self;
	self.var_2C09 = self method_8084(param_08);
	if(func_FF32(self))
	{
		do_immediate_ragdoll(self.var_2C09);
	}
	else
	{
		thread func_5124(self.var_2C09,param_06,param_05,param_04,param_00,param_03);
	}

	func_D97C(param_01,var_0B,param_06,param_04,param_03);
	if(isdefined(level.var_12DC7))
	{
		[[ level.var_12DC7 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}
}

//Function Number: 39
func_FF32(param_00)
{
	return scripts\common\utility::istrue(param_00.do_immediate_ragdoll);
}

//Function Number: 40
do_immediate_ragdoll(param_00)
{
	if(isdefined(param_00))
	{
		param_00 method_839A();
	}
}

//Function Number: 41
func_5124(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_00))
	{
		var_06 = param_00 method_8112();
		if(animhasnotetrack(var_06,"ignore_ragdoll"))
		{
			return;
		}
	}

	if(isdefined(level.var_C08A) && level.var_C08A.size)
	{
		foreach(var_08 in level.var_C08A)
		{
			if(distancesquared(param_00.origin,var_08.origin) < 65536)
			{
				return;
			}
		}
	}

	wait(0.2);
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 method_81B7())
	{
		return;
	}

	var_06 = param_00 method_8112();
	var_0A = 0.35;
	if(animhasnotetrack(var_06,"start_ragdoll"))
	{
		var_0B = getnotetracktimes(var_06,"start_ragdoll");
		if(isdefined(var_0B))
		{
			var_0A = var_0B[0];
		}
	}

	var_0C = var_0A * getanimlength(var_06);
	wait(var_0C);
	if(isdefined(param_00))
	{
		param_00 method_839A();
	}
}

//Function Number: 42
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

//Function Number: 43
func_179E(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_E08D(param_03);
	var_07 = func_108E8(var_06,param_00,param_01,param_02);
	if(isdefined(var_07))
	{
		var_07 thread [[ var_07 func_10972("spawn") ]](param_01,param_02,param_03,param_04,param_05);
	}

	return var_07;
}

//Function Number: 44
func_E08D(param_00)
{
	var_01 = strtok(param_00," ");
	if(isdefined(var_01) && var_01.size == 2)
	{
		return var_01[1];
	}

	return param_00;
}

//Function Number: 45
func_D96D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	scripts\cp\_damage::func_12DA8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 46
func_D96B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
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
	if(scripts\cp\_damage::func_A010(param_05))
	{
		var_0C = "special_weapon";
	}
	else if(var_10 || var_11 || var_12 || var_14)
	{
		var_0C = "card_boosted";
	}
	else if(issubstr(param_05,"arkyellow") && param_04 == "MOD_EXPLOSIVE_BULLET" && param_08 == "none")
	{
		var_0C = "yellow_arcane_cp";
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
		var_0C = "dewdrops_cp";
	}
	else if(scripts\common\utility::istrue(level.var_9925))
	{
		var_0C = "high_damage";
	}
	else if(param_05 == "incendiary_ammo_mp")
	{
		var_0C = "red_arcane_cp";
	}
	else if(param_05 == "stun_ammo_mp")
	{
		var_0C = "blue_arcane_cp";
	}
	else if(param_05 == "slayer_ammo_mp")
	{
		var_0C = "pink_arcane_cp";
	}

	if(isdefined(param_01))
	{
		if(isdefined(param_01.var_222))
		{
			param_01.var_222 thread scripts\cp\_damage::func_12E84(var_0C,var_0D,param_02,param_0A.var_E54C);
			return;
		}

		param_01 thread scripts\cp\_damage::func_12E84(var_0C,var_0D,param_02,param_0A.var_E54C);
	}
}

//Function Number: 47
func_D97C(param_00,param_01,param_02,param_03,param_04)
{
	scripts\cp\_reward::func_82A2(param_00,param_02);
	var_05 = func_77D7(param_01);
	var_06 = scripts\cp\_utility::func_7844(param_00);
	if(isdefined(var_06))
	{
		scripts\cp\_persistence::func_DDE9(param_03,param_02,param_04,var_06);
		if(isdefined(level.var_B07A) && isdefined(var_05))
		{
			[[ level.var_B07A ]](var_05,self.origin,param_00);
		}
	}
}

//Function Number: 48
get_alive_enemies()
{
	var_00 = func_7DB0("axis");
	var_01 = [];
	if(isdefined(level.var_5755))
	{
		var_01 = [[ level.var_5755 ]]();
	}

	var_00 = scripts\common\utility::array_combine(var_00,var_01);
	return var_00;
}

//Function Number: 49
func_77D7(param_00)
{
	return param_00.agent_type;
}

//Function Number: 50
func_110A4(param_00,param_01)
{
	param_00 = scripts\cp\_utility::func_7844(param_00);
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(self.var_24DA))
	{
		self.var_24DA = [];
	}

	foreach(var_03 in self.var_24DA)
	{
		if(var_03.player == param_00)
		{
			var_03.var_DA = var_03.var_DA + param_01;
			return;
		}
	}

	var_05 = spawnstruct();
	var_05.player = param_00;
	var_05.var_DA = param_01;
	self.var_24DA[self.var_24DA.size] = var_05;
}

//Function Number: 51
func_4DDB()
{
	if(scripts\cp\_utility::func_9E0E(self))
	{
		scripts\cp\_utility::func_E113();
	}

	scripts\cp\_utility::func_E106();
	scripts\cp\_utility::func_E119();
	self.var_9D25 = 0;
	self.var_8BE2 = 0;
	self.var_B36A = undefined;
	self.var_BB9C = undefined;
	self.var_222 = undefined;
	self.var_4539 = undefined;
	self.var_136FD = undefined;
	self.var_9B81 = undefined;
	self.var_9BC9 = undefined;
	self.var_1118F = undefined;
	self.var_BDF5 = undefined;
	foreach(var_01 in level.var_3CB5)
	{
		if(isdefined(var_01.var_2507))
		{
			foreach(var_04, var_03 in var_01.var_2507)
			{
				if(var_03 == self)
				{
					var_01.var_2507[var_04] = undefined;
				}
			}
		}
	}

	if(isdefined(self.var_8C98))
	{
		self.var_8C98 = undefined;
	}

	scripts\mp\_mp_agent::func_4DDB();
	self notify("disconnect");
}