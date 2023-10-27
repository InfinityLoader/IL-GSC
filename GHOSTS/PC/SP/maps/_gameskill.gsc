/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_gameskill.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 109
 * Decompile Time: 1763 ms
 * Timestamp: 10/27/2023 1:27:43 AM
*******************************************************************/

//Function Number: 1
func_70C9(param_00)
{
	if(!isdefined(level.script))
	{
		level.script = tolower(getdvar("mapname"));
	}

	if(!isdefined(param_00) || param_00 == 0)
	{
		if(isdefined(level.gameskill))
		{
			return;
		}

		if(!isdefined(level.custom_player_attacker))
		{
			level.custom_player_attacker = ::return_false;
		}

		level.var_3D2B = ::empty_kill_func;
		level.global_damage_func = ::empty_kill_func;
		level.global_kill_func = ::empty_kill_func;
		maps\_utility::set_console_status();
		foreach(var_02 in level.players)
		{
			var_02 maps\_utility::func_2F47("player_has_red_flashing_overlay");
			var_02 maps\_utility::func_2F47("player_is_invulnerable");
			var_02 maps\_utility::func_2F47("player_zero_attacker_accuracy");
			var_02 maps\_utility::func_2F47("player_no_auto_blur");
			var_02 maps\_utility::func_2F47("near_death_vision_enabled");
			var_02 maps\_utility::func_2F48("near_death_vision_enabled");
			var_02.var_3DE2 = spawnstruct();
			var_02 init_screeneffect_vars();
			var_02.a = spawnstruct();
			var_02.damage_functions = [];
			var_02 maps\_player_stats::func_45B1();
			var_02 maps\_utility::func_2F47("global_hint_in_use");
			var_02.pers = [];
			if(!isdefined(var_02.baseignorerandombulletdamage))
			{
				var_02.baseignorerandombulletdamage = 0;
			}

			var_02.disabledweapon = 0;
			var_02.var_27AB = 0;
			var_02.disabledusability = 0;
			var_02 setoffhandprimaryclass("frag");
		}

		level.difficultytype[0] = "easy";
		level.difficultytype[1] = "normal";
		level.difficultytype[2] = "hardened";
		level.difficultytype[3] = "veteran";
		level.difficultystring["easy"] = &"GAMESKILL_EASY";
		level.difficultystring["normal"] = &"GAMESKILL_NORMAL";
		level.difficultystring["hardened"] = &"GAMESKILL_HARDENED";
		level.difficultystring["veteran"] = &"GAMESKILL_VETERAN";
		thread func_36FF();
	}

	setdvarifuninitialized("autodifficulty_playerDeathTimer",0);
	anim.var_6931 = 0.5;
	anim.var_8BD6 = 0.8;
	setdvar("autodifficulty_frac",0);
	level.var_272E = [];
	foreach(var_02 in level.players)
	{
		var_02 init_take_cover_warnings();
		var_02 thread func_4484();
	}

	level.mg42badplace_mintime = 8;
	level.var_51FE = 16;
	level.var_272D["playerGrenadeBaseTime"]["easy"] = -25536;
	level.var_272D["playerGrenadeBaseTime"]["normal"] = -30536;
	level.var_272D["playerGrenadeBaseTime"]["hardened"] = 25000;
	level.var_272D["playerGrenadeBaseTime"]["veteran"] = 25000;
	level.var_272D["playerGrenadeRangeTime"]["easy"] = 20000;
	level.var_272D["playerGrenadeRangeTime"]["normal"] = 15000;
	level.var_272D["playerGrenadeRangeTime"]["hardened"] = 10000;
	level.var_272D["playerGrenadeRangeTime"]["veteran"] = 10000;
	level.var_272D["playerDoubleGrenadeTime"]["easy"] = 3600000;
	level.var_272D["playerDoubleGrenadeTime"]["normal"] = 150000;
	level.var_272D["playerDoubleGrenadeTime"]["hardened"] = 90000;
	level.var_272D["playerDoubleGrenadeTime"]["veteran"] = 90000;
	level.var_272D["double_grenades_allowed"]["easy"] = 0;
	level.var_272D["double_grenades_allowed"]["normal"] = 1;
	level.var_272D["double_grenades_allowed"]["hardened"] = 1;
	level.var_272D["double_grenades_allowed"]["veteran"] = 1;
	level.var_272D["threatbias"]["easy"] = 100;
	level.var_272D["threatbias"]["normal"] = 150;
	level.var_272D["threatbias"]["hardened"] = 200;
	level.var_272D["threatbias"]["veteran"] = 400;
	level.var_272D["base_enemy_accuracy"]["easy"] = 0.9;
	level.var_272D["base_enemy_accuracy"]["normal"] = 1;
	level.var_272D["base_enemy_accuracy"]["hardened"] = 1.15;
	level.var_272D["base_enemy_accuracy"]["veteran"] = 1.15;
	level.var_272D["accuracyDistScale"]["easy"] = 1;
	level.var_272D["accuracyDistScale"]["normal"] = 1;
	level.var_272D["accuracyDistScale"]["hardened"] = 0.6;
	level.var_272D["accuracyDistScale"]["veteran"] = 0.8;
	level.var_272D["min_sniper_burst_delay_time"]["easy"] = 3;
	level.var_272D["min_sniper_burst_delay_time"]["normal"] = 2;
	level.var_272D["min_sniper_burst_delay_time"]["hardened"] = 1.5;
	level.var_272D["min_sniper_burst_delay_time"]["veteran"] = 1.1;
	level.var_272D["max_sniper_burst_delay_time"]["easy"] = 4;
	level.var_272D["max_sniper_burst_delay_time"]["normal"] = 3;
	level.var_272D["max_sniper_burst_delay_time"]["hardened"] = 2;
	level.var_272D["max_sniper_burst_delay_time"]["veteran"] = 1.5;
	level.var_272D["dog_health"]["easy"] = 0.25;
	level.var_272D["dog_health"]["normal"] = 0.75;
	level.var_272D["dog_health"]["hardened"] = 1;
	level.var_272D["dog_health"]["veteran"] = 1;
	level.var_272D["dog_presstime"]["easy"] = 415;
	level.var_272D["dog_presstime"]["normal"] = 375;
	level.var_272D["dog_presstime"]["hardened"] = 250;
	level.var_272D["dog_presstime"]["veteran"] = 225;
	level.var_272D["dog_hits_before_kill"]["easy"] = 2;
	level.var_272D["dog_hits_before_kill"]["normal"] = 1;
	level.var_272D["dog_hits_before_kill"]["hardened"] = 0;
	level.var_272D["dog_hits_before_kill"]["veteran"] = 0;
	level.var_272D["pain_test"]["easy"] = ::always_pain;
	level.var_272D["pain_test"]["normal"] = ::always_pain;
	level.var_272D["pain_test"]["hardened"] = ::func_5AA8;
	level.var_272D["pain_test"]["veteran"] = ::func_5AA8;
	level.var_272D["missTimeConstant"]["easy"] = 1;
	level.var_272D["missTimeConstant"]["normal"] = 0.05;
	level.var_272D["missTimeConstant"]["hardened"] = 0;
	level.var_272D["missTimeConstant"]["veteran"] = 0;
	level.var_272D["missTimeDistanceFactor"]["easy"] = 0.0008;
	level.var_272D["missTimeDistanceFactor"]["normal"] = 0.0001;
	level.var_272D["missTimeDistanceFactor"]["hardened"] = 5E-05;
	level.var_272D["missTimeDistanceFactor"]["veteran"] = 0;
	level.var_272D["flashbangedInvulFactor"]["easy"] = 0.25;
	level.var_272D["flashbangedInvulFactor"]["normal"] = 0;
	level.var_272D["flashbangedInvulFactor"]["hardened"] = 0;
	level.var_272D["flashbangedInvulFactor"]["veteran"] = 0;
	level.var_272D["player_criticalBulletDamageDist"]["easy"] = 0;
	level.var_272D["player_criticalBulletDamageDist"]["normal"] = 0;
	level.var_272D["player_criticalBulletDamageDist"]["hardened"] = 0;
	level.var_272D["player_criticalBulletDamageDist"]["veteran"] = 0;
	level.var_272D["player_deathInvulnerableTime"]["easy"] = 4000;
	level.var_272D["player_deathInvulnerableTime"]["normal"] = 2500;
	level.var_272D["player_deathInvulnerableTime"]["hardened"] = 600;
	level.var_272D["player_deathInvulnerableTime"]["veteran"] = 100;
	level.var_272D["invulTime_preShield"]["easy"] = 0.6;
	level.var_272D["invulTime_preShield"]["normal"] = 0.5;
	level.var_272D["invulTime_preShield"]["hardened"] = 0.3;
	level.var_272D["invulTime_preShield"]["veteran"] = 0;
	level.var_272D["invulTime_onShield"]["easy"] = 1.6;
	level.var_272D["invulTime_onShield"]["normal"] = 1;
	level.var_272D["invulTime_onShield"]["hardened"] = 0.5;
	level.var_272D["invulTime_onShield"]["veteran"] = 0.25;
	level.var_272D["invulTime_postShield"]["easy"] = 0.5;
	level.var_272D["invulTime_postShield"]["normal"] = 0.4;
	level.var_272D["invulTime_postShield"]["hardened"] = 0.3;
	level.var_272D["invulTime_postShield"]["veteran"] = 0;
	level.var_272D["playerHealth_RegularRegenDelay"]["easy"] = 4000;
	level.var_272D["playerHealth_RegularRegenDelay"]["normal"] = 4000;
	level.var_272D["playerHealth_RegularRegenDelay"]["hardened"] = 3000;
	level.var_272D["playerHealth_RegularRegenDelay"]["veteran"] = 1200;
	level.var_272D["worthyDamageRatio"]["easy"] = 0;
	level.var_272D["worthyDamageRatio"]["normal"] = 0.1;
	level.var_272D["worthyDamageRatio"]["hardened"] = 0.3;
	level.var_272D["worthyDamageRatio"]["veteran"] = 0.3;
	level.var_272D["playerDifficultyHealth"]["easy"] = 475;
	level.var_272D["playerDifficultyHealth"]["normal"] = 275;
	level.var_272D["playerDifficultyHealth"]["hardened"] = 165;
	level.var_272D["playerDifficultyHealth"]["veteran"] = 115;
	level.var_272D["longRegenTime"]["easy"] = 5000;
	level.var_272D["longRegenTime"]["normal"] = 5000;
	level.var_272D["longRegenTime"]["hardened"] = 3200;
	level.var_272D["longRegenTime"]["veteran"] = 3200;
	level.var_272D["healthOverlayCutoff"]["easy"] = 0.02;
	level.var_272D["healthOverlayCutoff"]["normal"] = 0.02;
	level.var_272D["healthOverlayCutoff"]["hardened"] = 0.02;
	level.var_272D["healthOverlayCutoff"]["veteran"] = 0.02;
	level.var_272D["health_regenRate"]["easy"] = 0.02;
	level.var_272D["health_regenRate"]["normal"] = 0.02;
	level.var_272D["health_regenRate"]["hardened"] = 0.02;
	level.var_272D["health_regenRate"]["veteran"] = 0.02;
	level.var_272D["explosivePlantTime"]["easy"] = 10;
	level.var_272D["explosivePlantTime"]["normal"] = 10;
	level.var_272D["explosivePlantTime"]["hardened"] = 5;
	level.var_272D["explosivePlantTime"]["veteran"] = 5;
	level.var_272D["player_downed_buffer_time"]["normal"] = 2;
	level.var_272D["player_downed_buffer_time"]["hardened"] = 1.5;
	level.var_272D["player_downed_buffer_time"]["veteran"] = 0;
	level.var_4C8A = 0;
	setsaveddvar("player_meleeDamageMultiplier",0.2666667);
	if(isdefined(level.var_222A))
	{
		[[ level.var_222A ]]();
	}

	if(coop_with_one_player_downed())
	{
		func_500E();
	}

	func_86EF();
	func_86C7();
	setdvar("autodifficulty_original_setting",level.gameskill);
}

//Function Number: 2
init_screeneffect_vars()
{
	self.var_3DE2.var_6B14 = [];
	var_00 = ["bottom","left","right"];
	var_01 = ["bloodsplat","dirt"];
	foreach(var_03 in var_01)
	{
		foreach(var_05 in var_00)
		{
			self.var_3DE2.var_6B14[var_03][var_05] = 0;
			self.var_3DE2.var_6B14[var_03 + "_count"][var_05] = 0;
		}
	}
}

//Function Number: 3
coop_player_in_special_ops_survival()
{
	setsaveddvar("player_meleeDamageMultiplier",0.26);
}

//Function Number: 4
func_76BF()
{
	if(!maps\_utility::is_survival())
	{
		setsaveddvar("player_deathInvulnerableToMelee","1");
		setsaveddvar("ai_accuracy_attackercountDecrease","0.6");
	}

	level.var_272D["playerHealth_RegularRegenDelay"]["normal"] = 2000;
	level.var_272D["playerHealth_RegularRegenDelay"]["hardened"] = 2000;
	level.var_272D["playerHealth_RegularRegenDelay"]["veteran"] = 900;
	if(!maps\_utility::is_survival())
	{
		level.var_272D["invulTime_onShield"]["normal"] = 2.5;
	}
	else
	{
		level.var_272D["invulTime_onShield"]["normal"] = 1.5;
	}

	level.var_272D["player_deathInvulnerableTime"]["normal"] = 3000;
	level.var_272D["player_deathInvulnerableTime"]["hardened"] = 1300;
	level.var_272D["player_deathInvulnerableTime"]["veteran"] = 800;
	level.var_272D["longRegenTime"]["normal"] = 4500;
	level.var_272D["longRegenTime"]["hardened"] = 4500;
	level.var_272D["longRegenTime"]["veteran"] = 4500;
	level.var_272D["playerDifficultyHealth"]["normal"] = 350;
	level.var_272D["playerDifficultyHealth"]["hardened"] = 205;
	level.var_272D["playerDifficultyHealth"]["veteran"] = 205;
	if(!maps\_utility::is_survival())
	{
		setsaveddvar("player_meleeDamageMultiplier",0.5);
	}

	setsaveddvar("player_meleeDamageMultiplier",0.26);
}

//Function Number: 5
func_76BE()
{
	level.var_272D["player_deathInvulnerableTime"]["normal"] = 2500;
	level.var_272D["player_deathInvulnerableTime"]["hardened"] = 1200;
	level.var_272D["player_deathInvulnerableTime"]["veteran"] = 200;
	var_00 = 1.35;
	level.var_272D["playerDifficultyHealth"]["normal"] = int(275 * var_00);
	level.var_272D["playerDifficultyHealth"]["hardened"] = int(165 * var_00);
	level.var_272D["playerDifficultyHealth"]["veteran"] = int(138);
}

//Function Number: 6
func_500E()
{
	level.var_272D["player_deathInvulnerableTime"]["normal"] = 2500;
	level.var_272D["player_deathInvulnerableTime"]["hardened"] = 1000;
	var_00 = 1.25;
	level.var_272D["playerDifficultyHealth"]["normal"] = int(275 * var_00);
	level.var_272D["playerDifficultyHealth"]["hardened"] = int(165 * var_00);
}

//Function Number: 7
func_86C7()
{
	func_7042();
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] func_701B();
	}
}

//Function Number: 8
func_701B()
{
	func_6E88();
}

//Function Number: 9
func_7042()
{
	var_00 = ::get_locked_difficulty_val_global;
	var_01 = get_skill_from_index(level.gameskill);
	anim.dog_health = [[ var_00 ]]("dog_health",level.gameskill);
	anim.pain_test = level.var_272D["pain_test"][var_01];
	level.explosiveplanttime = level.var_272D["explosivePlantTime"][var_01];
	anim.var_522F = [[ var_00 ]]("min_sniper_burst_delay_time",level.gameskill);
	anim.var_50E0 = [[ var_00 ]]("max_sniper_burst_delay_time",level.gameskill);
	setsaveddvar("ai_accuracyDistScale",[[ var_00 ]]("accuracyDistScale",level.gameskill));
	if(maps\_utility::laststand_enabled())
	{
		level.player_downed_death_buffer_time = level.var_272D["player_downed_buffer_time"][var_01];
	}

	maps\_mgturret::func_701B();
}

//Function Number: 10
func_86EF()
{
	foreach(var_01 in level.players)
	{
		if(maps\_utility::is_survival())
		{
			var_01.gameskill = 1;
			continue;
		}

		var_01.gameskill = var_01 maps\_utility::get_player_gameskill();
	}

	level.gameskill = level.player.gameskill;
	if(maps\_utility::func_47D0() && level.var_5D60.gameskill > level.gameskill)
	{
		level.gameskill = level.var_5D60.gameskill;
	}

	level.var_78FA = level.player.gameskill;
	if(maps\_utility::func_47D0() && level.var_5D60.gameskill < level.var_78FA)
	{
		level.var_78FA = level.var_5D60.gameskill;
	}

	if(isdefined(level.forcedgameskill))
	{
		level.gameskill = level.forcedgameskill;
	}

	return level.gameskill;
}

//Function Number: 11
func_36FF()
{
	var_00 = level.gameskill;
	for(;;)
	{
		if(!isdefined(var_00))
		{
			wait(1);
			var_00 = level.gameskill;
			continue;
		}

		if(var_00 != func_86EF())
		{
			var_00 = level.gameskill;
			func_86C7();
		}

		wait(1);
	}
}

//Function Number: 12
get_skill_from_index(param_00)
{
	return level.difficultytype[param_00];
}

//Function Number: 13
aa_should_start_fresh()
{
	return level.gameskill == getdvarint("autodifficulty_original_setting");
}

//Function Number: 14
apply_difficulty_frac_with_func(param_00,param_01)
{
	self.var_3DE2.var_47AC = [[ param_00 ]]("invulTime_preShield",param_01);
	self.var_3DE2.var_47AA = [[ param_00 ]]("invulTime_onShield",param_01);
	self.var_3DE2.var_47AB = [[ param_00 ]]("invulTime_postShield",param_01);
	self.var_3DE2.playerhealth_regularregendelay = [[ param_00 ]]("playerHealth_RegularRegenDelay",param_01);
	self.var_3DE2.var_8E49 = [[ param_00 ]]("worthyDamageRatio",param_01);
	self.threatbias = int([[ param_00 ]]("threatbias",param_01));
	self.var_3DE2.var_4F3F = [[ param_00 ]]("longRegenTime",param_01);
	self.var_3DE2.healthoverlaycutoff = [[ param_00 ]]("healthOverlayCutoff",param_01);
	self.var_3DE2.var_6446 = [[ param_00 ]]("health_regenRate",param_01);
	self.var_3DE2.var_5D81 = [[ param_00 ]]("base_enemy_accuracy",param_01);
	func_869B();
	self.var_3DE2.var_5FAE = int([[ param_00 ]]("playerGrenadeBaseTime",param_01));
	self.var_3DE2.playergrenaderangetime = int([[ param_00 ]]("playerGrenadeRangeTime",param_01));
	self.var_3DE2.var_5FA5 = int([[ param_00 ]]("playerDoubleGrenadeTime",param_01));
	self.var_3DE2.var_522F = [[ param_00 ]]("min_sniper_burst_delay_time",param_01);
	self.var_3DE2.var_50E0 = [[ param_00 ]]("max_sniper_burst_delay_time",param_01);
	self.var_3DE2.var_290E = [[ param_00 ]]("dog_presstime",param_01);
	self.deathinvulnerabletime = int([[ param_00 ]]("player_deathInvulnerableTime",param_01));
	self.criticalbulletdamagedist = int([[ param_00 ]]("player_criticalBulletDamageDist",param_01));
	self.damagemultiplier = 100 / [[ param_00 ]]("playerDifficultyHealth",param_01);
}

//Function Number: 15
func_869B()
{
	if(maps\_utility::ent_flag("player_zero_attacker_accuracy"))
	{
	}

	self.ignorerandombulletdamage = self.baseignorerandombulletdamage;
	self.attackeraccuracy = self.var_3DE2.var_5D81;
}

//Function Number: 16
func_0E9C(param_00,param_01)
{
	self.var_3DE2.var_52F5 = [[ param_00 ]]("missTimeConstant",param_01);
	self.var_3DE2.var_52F7 = [[ param_00 ]]("missTimeDistanceFactor",param_01);
	self.var_3DE2.dog_hits_before_kill = [[ param_00 ]]("dog_hits_before_kill",param_01);
	self.var_3DE2.var_2A26 = [[ param_00 ]]("double_grenades_allowed",param_01);
}

//Function Number: 17
func_6E88()
{
	apply_difficulty_frac_with_func(::get_locked_difficulty_val_player,1);
	func_0E9C(::func_38EA,1);
}

//Function Number: 18
func_38EA(param_00,param_01)
{
	return level.var_272D[param_00][get_skill_from_index(self.gameskill)];
}

//Function Number: 19
func_38E9(param_00,param_01)
{
	return level.var_272D[param_00][get_skill_from_index(level.gameskill)];
}

//Function Number: 20
get_blended_difficulty(param_00,param_01)
{
	var_02 = level.var_272E[param_00];
	var_03 = 1;
	while(var_03 < var_02.size)
	{
		var_04 = var_02[var_03]["frac"];
		var_05 = var_02[var_03]["val"];
		if(param_01 <= var_04)
		{
			var_06 = var_02[var_03 - 1]["frac"];
			var_07 = var_02[var_03 - 1]["val"];
			var_08 = var_04 - var_06;
			var_09 = var_05 - var_07;
			var_0A = param_01 - var_06;
			var_0B = var_0A / var_08;
			return var_07 + var_0B * var_09;
		}

		var_09++;
	}

	return var_08[var_08.size - 1]["val"];
}

//Function Number: 21
getcurrentdifficultysetting(param_00)
{
	return level.var_272D[param_00][get_skill_from_index(self.gameskill)];
}

//Function Number: 22
func_3BCA(param_00,param_01,param_02)
{
	return level.var_272D[param_00][level.difficultytype[param_01]] * 100 - getdvarint("autodifficulty_frac") + level.var_272D[param_00][level.difficultytype[param_02]] * getdvarint("autodifficulty_frac") * 0.01;
}

//Function Number: 23
get_locked_difficulty_val_player(param_00,param_01)
{
	return level.var_272D[param_00][get_skill_from_index(self.gameskill)];
}

//Function Number: 24
get_locked_difficulty_val_global(param_00,param_01)
{
	return level.var_272D[param_00][get_skill_from_index(level.gameskill)];
}

//Function Number: 25
always_pain()
{
	return 0;
}

//Function Number: 26
func_5AA8()
{
	if(!func_5AA9())
	{
		return 0;
	}

	return randomint(100) > 25;
}

//Function Number: 27
func_5AA9()
{
	if(!isalive(self.enemy))
	{
		return 0;
	}

	if(!isplayer(self.enemy))
	{
		return 0;
	}

	if(!isalive(level.painai) || level.painai.script != "pain")
	{
		level.painai = self;
	}

	if(self == level.painai)
	{
		return 0;
	}

	if(self.damageweapon != "none" && weaponisboltaction(self.damageweapon))
	{
		return 0;
	}

	return 1;
}

//Function Number: 28
func_6E1A()
{
	if(animscripts/combat_utility::issniper() && isalive(self.enemy))
	{
		func_70CA();
	}

	if(isplayer(self.enemy))
	{
		func_660E();
		if(self.a.var_52F4 > gettime())
		{
			self.accuracy = 0;
		}
	}

	if(self.script == "move")
	{
		if(animscripts/utility::iscqbwalkingorfacingenemy())
		{
			self.accuracy = level.var_8BD6 * self.baseaccuracy;
		}
		else
		{
			self.accuracy = level.var_6931 * self.baseaccuracy;
		}
	}

	self.accuracy = self.baseaccuracy;
	if(isdefined(self.var_4940) && isdefined(self.ramboaccuracymult))
	{
		self.accuracy = self.accuracy * self.ramboaccuracymult;
	}
}

//Function Number: 29
func_70CA()
{
	if(!isdefined(self.var_766F))
	{
		self.var_766F = 0;
		self.var_766E = 0;
	}

	self.var_766F++;
	var_00 = level.gameskill;
	if(isplayer(self.enemy))
	{
		var_00 = self.enemy.gameskill;
	}

	if(func_74B3())
	{
		self.accuracy = 0;
		if(var_00 > 0 || self.var_766F > 1)
		{
			self.var_4C7E = self.enemy;
		}
	}

	self.accuracy = 1 + 1 * self.var_766E * self.baseaccuracy;
	self.var_766E++;
	if(var_00 < 1 && self.var_766E == 1)
	{
		self.var_4C7E = undefined;
	}
}

//Function Number: 30
func_74B3()
{
	if(isdefined(self.var_55A7) && self.var_55A7)
	{
		return 0;
	}

	if(self.team == "allies")
	{
		return 0;
	}

	if(isdefined(self.var_4C7E) && self.enemy == self.var_4C7E)
	{
		return 0;
	}

	if(distancesquared(self.origin,self.enemy.origin) > 250000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 31
func_7466()
{
	return 1 + randomfloat(4);
}

//Function Number: 32
didsomethingotherthanshooting()
{
	self.a.var_52F6 = 0;
}

//Function Number: 33
resetaccuracyandpause()
{
	func_660F();
}

//Function Number: 34
func_8BC6()
{
	var_00 = 0;
	waittillframeend;
	if(!isalive(self.enemy))
	{
		return var_00;
	}

	if(!isplayer(self.enemy))
	{
		return var_00;
	}

	if(self.enemy maps\_utility::ent_flag("player_is_invulnerable"))
	{
		var_00 = 0.3 + randomfloat(0.4);
	}

	return var_00;
}

//Function Number: 35
func_6195(param_00,param_01,param_02,param_03)
{
	param_03 = param_03 * 20;
	for(var_04 = 0;var_04 < param_03;var_04++)
	{
		wait(0.05);
	}
}

//Function Number: 36
func_660F()
{
	if(!self isbadguy())
	{
	}

	if(self.weapon == "none")
	{
	}

	if(!animscripts/weaponlist::func_87EF() && !animscripts/weaponlist::func_87FC())
	{
		self.var_52F4 = 0;
	}

	if(!isalive(self.enemy))
	{
	}

	if(!isplayer(self.enemy))
	{
		self.accuracy = self.baseaccuracy;
	}

	var_00 = distance(self.enemy.origin,self.origin);
	func_7071(self.enemy.var_3DE2.var_52F5 + var_00 * self.enemy.var_3DE2.var_52F7);
}

//Function Number: 37
func_660E()
{
	self.a.var_52F6 = gettime() + 3000;
}

//Function Number: 38
func_7071(param_00)
{
	if(self.a.var_52F6 > gettime())
	{
	}

	if(param_00 > 0)
	{
		self.accuracy = 0;
	}

	param_00 = param_00 * 1000;
	self.a.var_52F4 = gettime() + param_00;
	self.a.accuracygrowthmultiplier = 1;
}

//Function Number: 39
player_aim_debug()
{
	self endon("death");
	self notify("playeraim");
	self endon("playeraim");
	for(;;)
	{
		var_00 = (0,1,0);
		if(self.a.var_52F4 > gettime())
		{
			var_00 = (1,0,0);
		}

		wait(0.05);
	}
}

//Function Number: 40
screen_effect_on_open_bottom(param_00,param_01,param_02)
{
	var_03 = randomfloatrange(-15,15);
	var_04 = randomfloatrange(-15,15);
	self scaleovertime(0.1,int(2048 * param_01),int(1152 * param_01));
	self.y = 100 + var_04;
	self moveovertime(0.08);
	self.y = 0 + var_04;
	self.x = self.x + var_03;
	if(isdefined(param_02))
	{
	}

	func_6B08();
}

//Function Number: 41
func_6B0A(param_00,param_01,param_02)
{
	var_03 = 1;
	if(param_02)
	{
		var_03 = -1;
	}

	var_04 = randomfloatrange(-15,15);
	var_05 = randomfloatrange(-15,15);
	self scaleovertime(0.1,int(2048 * param_01),int(1152 * param_01));
	self.x = 1000 * var_03 + var_04;
	self moveovertime(0.1);
	self.x = 0 + var_04;
	self.y = self.y + var_05;
	func_6B08();
}

//Function Number: 42
func_6B08()
{
	self endon("death");
	var_00 = gettime();
	var_01 = 1;
	var_02 = 0.05;
	self.alpha = 0;
	self fadeovertime(var_02);
	self.alpha = 1;
	wait(var_02);
	maps\_utility::func_8A74(var_00,2);
	self fadeovertime(var_01);
	self.alpha = 0;
	wait(var_01);
	self destroy();
}

//Function Number: 43
func_6B07()
{
	var_00 = 0.2;
	self.alpha = 0.7;
	self fadeovertime(var_00);
	self.alpha = 0;
	wait(var_00);
	self destroy();
}

//Function Number: 44
func_3DA6(param_00)
{
	var_01 = "fullscreen_dirt_" + param_00;
	var_02 = undefined;
	if(param_00 == "bottom")
	{
		var_02 = "fullscreen_dirt_bottom_b";
	}

	thread func_27E5("dirt",param_00,var_01,var_02,randomfloatrange(0.55,0.66));
}

//Function Number: 45
blood_splat_on_screen(param_00)
{
	var_01 = "fullscreen_bloodsplat_" + param_00;
	thread func_27E5("bloodsplat",param_00,var_01,undefined,randomfloatrange(0.45,0.56));
}

//Function Number: 46
func_27E5(param_00,param_01,param_02,param_03,param_04)
{
	if(!isalive(self))
	{
	}

	if(isdefined(self.var_47CF))
	{
	}

	var_05 = gettime();
	if(self.var_3DE2.var_6B14[param_00][param_01] == var_05)
	{
	}

	if(self.var_3DE2.var_6B14[param_00 + "_count"][param_01] == 1)
	{
	}

	self.var_3DE2.var_6B14[param_00 + "_count"][param_01]++;
	self.var_3DE2.var_6B14[param_00][param_01] = var_05;
	self endon("death");
	switch(param_01)
	{
		case "bottom":
			var_06 = int(640);
			var_07 = int(480);
			if(param_00 == "dirt")
			{
				var_08 = maps\_hud_util::create_client_overlay_custom_size(param_02,1);
				var_08 thread screen_effect_on_open_bottom(param_00,param_04,1);
				var_08 func_6B07();
			}
			else
			{
				var_08 = maps\_hud_util::create_client_overlay_custom_size(param_03,0);
				var_08 screen_effect_on_open_bottom(param_00,param_04);
			}
	
			if(isdefined(param_03))
			{
				var_09 = maps\_hud_util::create_client_overlay_custom_size(param_03,0);
				var_09 screen_effect_on_open_bottom(param_00,param_04);
			}
			break;

		case "left":
			var_08 = maps\_hud_util::create_client_overlay_custom_size(param_02,0,1,1);
			var_08 func_6B0A(param_00,param_04,1);
			break;

		case "right":
			var_08 = maps\_hud_util::create_client_overlay_custom_size(param_02,0,1,1);
			var_08 func_6B0A(param_00,param_04,0);
			break;

		default:
			break;
	}

	self.var_3DE2.var_6B14[param_00 + "_count"][param_01]--;
}

//Function Number: 47
playerhurtcheck()
{
	var_00 = ::maps\_utility::dirt_on_screen_from_position;
	var_01 = ::maps\_utility::bloodsplateffect;
	var_02 = [];
	var_02["MOD_GRENADE"] = var_00;
	var_02["MOD_GRENADE_SPLASH"] = var_00;
	var_02["MOD_PROJECTILE"] = var_00;
	var_02["MOD_PROJECTILE_SPLASH"] = var_00;
	var_02["MOD_EXPLOSIVE"] = var_00;
	var_02["MOD_PISTOL_BULLET"] = var_01;
	var_02["MOD_RIFLE_BULLET"] = var_01;
	var_02["MOD_EXPLOSIVE_BULLET"] = var_01;
	self.var_437D = 0;
	for(;;)
	{
		self waittill("damage",var_03,var_04,var_05,var_06,var_07);
		self.var_437D = 1;
		self.damagepoint = var_06;
		self.damageattacker = var_04;
		var_08 = undefined;
		if(isdefined(self.mods_override))
		{
			var_08 = self.mods_override[var_07];
		}

		if(!isdefined(var_08) && isdefined(var_02[var_07]))
		{
			var_08 = var_02[var_07];
		}

		if(isdefined(var_08))
		{
			waittillframeend;
			[[ var_08 ]](var_06);
		}
	}
}

//Function Number: 48
func_5E28()
{
	self.var_5E28 = 3;
}

//Function Number: 49
playerhealthregeninit()
{
	wait(0.05);
	level.var_7CE8["take_cover"] = spawnstruct();
	level.var_7CE8["take_cover"].text = &"GAME_GET_TO_COVER";
	level.var_7CE8["get_back_up"] = spawnstruct();
	level.var_7CE8["get_back_up"].text = &"GAME_LAST_STAND_GET_BACK_UP";
}

//Function Number: 50
func_5FB3()
{
	thread func_4055();
	var_00 = 1;
	var_01 = 0;
	thread func_5E28();
	var_02 = 0;
	var_03 = 0;
	thread func_5F97(self.maxhealth * 0.35);
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 1;
	thread playerhurtcheck();
	self.bolthit = 0;
	for(;;)
	{
		wait(0.05);
		waittillframeend;
		if(maps\_utility::laststand_enabled())
		{
			if(isdefined(level.var_4CA7))
			{
				self thread [[ level.var_4CA7 ]]();
			}
		}

		if(self.health == self.maxhealth)
		{
			if(maps\_utility::ent_flag("player_has_red_flashing_overlay"))
			{
				func_5EDA();
			}

			var_07 = 1;
			var_03 = 0;
			var_02 = 0;
			continue;
		}

		if(self.health <= 0)
		{
		}

		var_08 = var_02;
		var_09 = self.health / self.maxhealth;
		if(var_09 <= self.var_3DE2.healthoverlaycutoff && self.var_5E28 > 1)
		{
			var_02 = 1;
			if(!var_08)
			{
				var_05 = gettime();
				if(maps\_utility::ent_flag("near_death_vision_enabled"))
				{
					thread blurview(3.6,2);
					thread maps\_audio::func_6E7B();
					self painvisionon();
				}

				maps\_utility::func_2F48("player_has_red_flashing_overlay");
				var_03 = 1;
			}
		}

		if(self.var_437D)
		{
			var_05 = gettime();
			self.var_437D = 0;
		}

		if(self.health / self.maxhealth >= var_00)
		{
			if(gettime() - var_05 < self.var_3DE2.playerhealth_regularregendelay)
			{
				continue;
			}

			if(var_02)
			{
				var_06 = var_09;
				if(gettime() > var_05 + self.var_3DE2.var_4F3F)
				{
					var_06 = var_06 + self.var_3DE2.var_6446;
				}

				if(var_06 >= 1)
				{
					func_641D();
				}
			}
			else
			{
				var_06 = 1;
			}

			if(var_06 > 1)
			{
				var_06 = 1;
			}

			if(var_06 <= 0)
			{
			}

			self setnormalhealth(var_06);
			var_00 = self.health / self.maxhealth;
			continue;
		}

		var_00 = var_07;
		var_0A = self.var_3DE2.var_8E49;
		if(self.attackercount == 1)
		{
			var_0A = var_0A * 3;
		}

		var_0B = var_00 - var_09 >= var_0A;
		if(self.health <= 1)
		{
			self setnormalhealth(2 / self.maxhealth);
			var_0B = 1;
		}

		var_00 = self.health / self.maxhealth;
		self notify("hit_again");
		var_01 = 0;
		var_05 = gettime();
		thread blurview(3,0.8);
		if(!var_0B)
		{
			continue;
		}

		if(maps\_utility::ent_flag("player_is_invulnerable"))
		{
			continue;
		}

		maps\_utility::func_2F48("player_is_invulnerable");
		level notify("player_becoming_invulnerable");
		if(var_03)
		{
			var_04 = self.var_3DE2.var_47AA;
			var_03 = 0;
		}
		else if(var_02)
		{
			var_04 = self.var_3DE2.var_47AB;
		}
		else
		{
			var_04 = self.var_3DE2.var_47AC;
		}

		var_07 = self.health / self.maxhealth;
		thread playerinvul(var_04);
	}
}

//Function Number: 51
func_641D()
{
	if(!func_7E7C())
	{
	}

	if(isalive(self))
	{
		var_00 = self getlocalplayerprofiledata("takeCoverWarnings");
		if(var_00 > 0)
		{
			var_00--;
			self setlocalplayerprofiledata("takeCoverWarnings",var_00);
		}
	}
}

//Function Number: 52
playerinvul(param_00)
{
	if(isdefined(self.flashendtime) && self.flashendtime > gettime())
	{
		param_00 = param_00 * getcurrentdifficultysetting("flashbangedInvulFactor");
	}

	if(param_00 > 0)
	{
		if(!isdefined(self.var_5673))
		{
			self.attackeraccuracy = 0;
		}

		self.ignorerandombulletdamage = 1;
		wait(param_00);
	}

	func_869B();
	maps\_utility::func_2F44("player_is_invulnerable");
}

//Function Number: 53
default_door_node_flashbang_frequency()
{
	if(self.team == "allies")
	{
		self.var_29F3 = 0.6;
	}

	if(self isbadguy())
	{
		if(level.gameskill >= 2)
		{
			self.var_29F3 = 0.8;
		}

		self.var_29F3 = 0.6;
	}
}

//Function Number: 54
grenadeawareness()
{
	if(self.team == "allies")
	{
		self.grenadeawareness = 0.9;
	}

	if(self isbadguy())
	{
		if(level.gameskill >= 2)
		{
			if(randomint(100) < 33)
			{
				self.grenadeawareness = 0.2;
			}

			self.grenadeawareness = 0.5;
		}

		if(randomint(100) < 33)
		{
			self.grenadeawareness = 0;
		}

		self.grenadeawareness = 0.2;
	}
}

//Function Number: 55
blurview(param_00,param_01)
{
	if(maps\_utility::ent_flag("player_no_auto_blur"))
	{
	}

	self notify("blurview_stop");
	self endon("blurview_stop");
	self setblurforplayer(param_00,0);
	wait(0.05);
	self setblurforplayer(0,param_01);
}

//Function Number: 56
func_5F97(param_00)
{
	wait(2);
	for(;;)
	{
		wait(0.2);
		if(self.health <= 0)
		{
		}

		var_01 = self.health / self.maxhealth;
		if(var_01 > self.var_3DE2.healthoverlaycutoff)
		{
			continue;
		}

		if(isdefined(self.disable_breathing_sound) && self.disable_breathing_sound)
		{
			continue;
		}

		if(isdefined(level.gameskill_breath_func))
		{
			[[ level.gameskill_breath_func ]]("breathing_hurt");
		}
		else
		{
			self playlocalsound("breathing_hurt");
		}

		var_02 = 0.1;
		if(isdefined(level.player.var_3DE2.custombreathingtime))
		{
			var_02 = level.player.var_3DE2.custombreathingtime;
		}

		wait(var_02 + randomfloat(0.8));
	}
}

//Function Number: 57
func_4055()
{
	self endon("noHealthOverlay");
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 0;
	if(issplitscreen())
	{
		var_00 setshader("vfx_blood_screen_overlay",640,960);
		if(self == level.players[0])
		{
			var_00.y = var_00.y - 120;
		}
	}
	else
	{
		var_00 setshader("vfx_blood_screen_overlay",640,480);
	}

	var_00.splatter = 1;
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.sort = 1;
	var_00.foreground = 0;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 0;
	var_00.enablehudlighting = 1;
	thread func_4056(var_00);
	thread take_cover_warning_loop();
	var_01 = 0;
	var_02 = 0.05;
	var_03 = 0.3;
	while(isalive(self))
	{
		wait(var_02);
		var_04 = 1 - self.health / self.maxhealth;
		var_05 = var_04 * var_04 * 1.2;
		var_05 = clamp(var_05,0,1);
		if(var_01 > var_05)
		{
			var_01 = var_01 - var_03 * var_02;
		}

		if(var_01 < var_05)
		{
			var_01 = var_05;
		}

		var_00.alpha = var_01;
	}
}

//Function Number: 58
take_cover_warning_loop()
{
	while(isalive(self))
	{
		maps\_utility::ent_flag_wait("player_has_red_flashing_overlay");
		take_cover_warning();
	}
}

//Function Number: 59
add_hudelm_position_internal(param_00)
{
	if(level.console)
	{
		self.fontscale = 2;
	}
	else
	{
		self.fontscale = 1.6;
	}

	self.x = 0;
	self.y = -36;
	self.alignx = "center";
	self.aligny = "bottom";
	self.horzalign = "center";
	self.vertalign = "middle";
	if(!isdefined(self.var_120C))
	{
	}

	self.var_120C.x = 0;
	self.var_120C.y = -40;
	self.var_120C.alignx = "center";
	self.var_120C.aligny = "middle";
	self.var_120C.horzalign = "center";
	self.var_120C.vertalign = "middle";
	if(level.console)
	{
		self.var_120C setshader("popmenu_bg",650,52);
	}
	else
	{
		self.var_120C setshader("popmenu_bg",650,42);
	}

	self.var_120C.alpha = 0.5;
}

//Function Number: 60
create_warning_elem()
{
	var_00 = newclienthudelem(self);
	var_00 add_hudelm_position_internal();
	thread func_2634(var_00);
	var_00 thread func_2635();
	if(maps\_utility::func_4825(self))
	{
		var_00 settext(level.var_7CE8["get_back_up"].text);
	}
	else
	{
		var_00 settext(level.var_7CE8["take_cover"].text);
	}

	var_00.fontscale = 2;
	var_00.alpha = 1;
	var_00.color = (1,0.9,0.9);
	var_00.sort = 1;
	var_00.foreground = 1;
	return var_00;
}

//Function Number: 61
func_8BBD()
{
	self endon("hit_again");
	self endon("player_downed");
	self waittill("damage");
}

//Function Number: 62
func_2634(param_00)
{
	param_00 endon("being_destroyed");
	func_8BBD();
	var_01 = !isalive(self);
	param_00 thread destroy_warning_elem(var_01);
}

//Function Number: 63
func_2635()
{
	self endon("being_destroyed");
	common_scripts\utility::flag_wait("missionfailed");
	thread destroy_warning_elem(1);
}

//Function Number: 64
destroy_warning_elem(param_00)
{
	self notify("being_destroyed");
	self.beingdestroyed = 1;
	if(param_00)
	{
		self fadeovertime(0.5);
		self.alpha = 0;
		wait(0.5);
	}

	self notify("death");
	self destroy();
}

//Function Number: 65
func_511F(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.beingdestroyed))
	{
		return 0;
	}

	return 1;
}

//Function Number: 66
fontscaler(param_00,param_01)
{
	self endon("death");
	param_00 = param_00 * 2;
	var_02 = param_00 - self.fontscale;
	self changefontscaleovertime(param_01);
	self.fontscale = self.fontscale + var_02;
}

//Function Number: 67
func_314F(param_00,param_01,param_02,param_03)
{
	var_04 = 0.8;
	var_05 = 0.5;
	var_06 = var_04 * 0.1;
	var_07 = var_04 * 0.1 + param_01 * 0.2;
	var_08 = var_04 * 0.1 + param_01 * 0.1;
	var_09 = var_04 * 0.3;
	var_0A = var_04 - var_06 - var_07 - var_08 - var_09;
	if(var_0A < 0)
	{
		var_0A = 0;
	}

	var_0B = 0.8 + param_01 * 0.1;
	var_0C = 0.5 + param_01 * 0.3;
	if(func_511F(param_00))
	{
		if(!param_03)
		{
			param_00 fadeovertime(var_06);
			param_00.alpha = param_02 * 1;
		}
	}

	if(isdefined(param_00))
	{
		param_00 thread fontscaler(1,var_06);
	}

	wait(var_06 + var_07);
	if(func_511F(param_00))
	{
		if(!param_03)
		{
			param_00 fadeovertime(var_08);
			param_00.alpha = param_02 * var_0B;
		}
	}

	wait(var_08);
	if(func_511F(param_00))
	{
		if(!param_03)
		{
			param_00 fadeovertime(var_09);
			param_00.alpha = param_02 * var_0C;
		}
	}

	if(isdefined(param_00))
	{
		param_00 thread fontscaler(0.9,var_09);
	}

	wait(var_09);
	wait(var_0A);
}

//Function Number: 68
func_7E7C()
{
	if(isdefined(level.cover_warnings_disabled))
	{
		return 0;
	}

	if(isdefined(self.vehicle))
	{
		return 0;
	}

	return 1;
}

//Function Number: 69
func_748D()
{
	if(!isalive(self))
	{
		return 0;
	}

	if(self islinked())
	{
		return 0;
	}

	if(self.ignoreme)
	{
		return 0;
	}

	if(level.var_52F1)
	{
		return 0;
	}

	if(!func_7E7C())
	{
		return 0;
	}

	if(self.gameskill > 0 && !maps\_load::map_is_early_in_the_game())
	{
		return 0;
	}

	var_00 = self getlocalplayerprofiledata("takeCoverWarnings");
	if(var_00 <= 3)
	{
		return 0;
	}

	return 1;
}

//Function Number: 70
take_cover_warning()
{
	self endon("hit_again");
	self endon("damage");
	var_00 = undefined;
	if(func_748D())
	{
		var_00 = create_warning_elem();
	}

	var_01 = gettime() + self.var_3DE2.var_4F3F;
	func_314F(var_00,1,1,0);
	while(gettime() < var_01 && isalive(self) && maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		func_314F(var_00,0.9,1,0);
	}

	if(isalive(self))
	{
		func_314F(var_00,0.65,0.8,0);
	}

	if(func_511F(var_00))
	{
		var_00 fadeovertime(1);
		var_00.alpha = 0;
	}

	func_314F(var_00,0,0.6,1);
	wait(0.5);
	self notify("take_cover_done");
	self notify("hit_again");
}

//Function Number: 71
func_5EDA()
{
	maps\_utility::func_2F44("player_has_red_flashing_overlay");
	if(maps\_utility::ent_flag("near_death_vision_enabled"))
	{
		self painvisionoff();
		thread maps\_audio::func_6649();
	}

	if(!isdefined(self.disable_breathing_sound) || !self.disable_breathing_sound)
	{
		if(isdefined(level.gameskill_breath_func))
		{
			[[ level.gameskill_breath_func ]]("breathing_better");
		}
		else
		{
			self playlocalsound("breathing_better");
		}
	}

	self notify("take_cover_done");
}

//Function Number: 72
func_4056(param_00)
{
	self waittill("noHealthOverlay");
	param_00 destroy();
}

//Function Number: 73
resetskill()
{
	waittillframeend;
	func_70C9(1);
}

//Function Number: 74
init_take_cover_warnings()
{
	var_00 = isdefined(level.var_493B) && level.var_493B;
	if(self getlocalplayerprofiledata("takeCoverWarnings") == -1 || var_00)
	{
		self setlocalplayerprofiledata("takeCoverWarnings",9);
	}
}

//Function Number: 75
func_4484()
{
	self notify("new_cover_on_death_thread");
	self endon("new_cover_on_death_thread");
	self waittill("death");
	if(!maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
	}

	if(!func_7E7C())
	{
	}

	var_00 = self getlocalplayerprofiledata("takeCoverWarnings");
	if(var_00 < 10)
	{
		self setlocalplayerprofiledata("takeCoverWarnings",var_00 + 1);
	}
}

//Function Number: 76
auto_adjust_difficulty_player_positioner()
{
	var_00 = self.origin;
	wait(5);
	if(func_11D9(var_00))
	{
		level.var_11B3[level.var_11B3.size] = var_00;
	}
}

//Function Number: 77
func_11D9(param_00)
{
	return distancesquared(self.origin,param_00) < 19600;
}

//Function Number: 78
auto_adjust_difficulty_player_movement_check()
{
	level.var_11B3 = [];
	level.player.movedrecently = 1;
	wait(1);
	for(;;)
	{
		level.player thread auto_adjust_difficulty_player_positioner();
		level.player.movedrecently = 1;
		var_00 = [];
		var_01 = level.var_11B3.size - 5;
		if(var_01 < 0)
		{
			var_01 = 0;
		}

		for(var_02 = var_01;var_02 < level.var_11B3.size;var_02++)
		{
			if(!level.player func_11D9(level.var_11B3[var_02]))
			{
				continue;
			}

			var_00[var_00.size] = level.var_11B3[var_02];
			level.player.movedrecently = 0;
		}

		level.var_11B3 = var_00;
		wait(1);
	}
}

//Function Number: 79
auto_adjust_difficulty_track_player_death()
{
	level.player waittill("death");
	var_00 = getdvarint("autodifficulty_playerDeathTimer");
	var_00 = var_00 - 60;
	setdvar("autodifficulty_playerDeathTimer",var_00);
}

//Function Number: 80
func_11A5()
{
	var_00 = gettime();
	for(;;)
	{
		if(level.player attackbuttonpressed())
		{
			var_00 = gettime();
		}

		level.timebetweenshots = gettime() - var_00;
		wait(0.05);
	}
}

//Function Number: 81
hud_debug_add_frac(param_00,param_01)
{
	func_4312(param_00,param_01 * 100,1);
}

//Function Number: 82
hud_debug_add(param_00,param_01)
{
	func_4312(param_00,param_01,0);
}

//Function Number: 83
func_4318()
{
	level.var_4366 = 0;
	if(isdefined(level.var_435A))
	{
		for(var_00 = 0;var_00 < level.var_435A.size;var_00++)
		{
			level.var_435A[var_00] destroy();
		}
	}

	level.var_435A = [];
}

//Function Number: 84
func_4314(param_00)
{
	if(!isdefined(level.var_4365))
	{
		level.var_4365 = [];
	}

	if(!isdefined(level.var_4365[param_00]))
	{
		var_01 = newhudelem();
		var_01.x = level.debugleft;
		var_01.y = level.var_241F + level.var_4366 * 15;
		var_01.foreground = 1;
		var_01.sort = 100;
		var_01.alpha = 1;
		var_01.alignx = "left";
		var_01.horzalign = "left";
		var_01.fontscale = 1;
		var_01 settext(param_00);
		level.var_4365[param_00] = 1;
	}
}

//Function Number: 85
func_4312(param_00,param_01,param_02)
{
	func_4314(param_00);
	param_01 = int(param_01);
	var_03 = 0;
	if(param_01 < 0)
	{
		var_03 = 1;
		param_01 = param_01 * -1;
	}

	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0;
	while(param_01 >= 10000)
	{
		param_01 = param_01 - 10000;
	}

	while(param_01 >= 1000)
	{
		param_01 = param_01 - 1000;
		var_04++;
	}

	while(param_01 >= 100)
	{
		param_01 = param_01 - 100;
		var_05++;
	}

	while(param_01 >= 10)
	{
		param_01 = param_01 - 10;
		var_06++;
	}

	while(param_01 >= 1)
	{
		param_01 = param_01 - 1;
		var_07++;
	}

	var_08 = 0;
	var_09 = 10;
	if(var_04 > 0)
	{
		func_4315(var_04,var_08);
		var_08 = var_08 + var_09;
		func_4315(var_05,var_08);
		var_08 = var_08 + var_09;
		func_4315(var_06,var_08);
		var_08 = var_08 + var_09;
		func_4315(var_07,var_08);
		var_08 = var_08 + var_09;
	}
	else if(var_05 > 0 || param_02)
	{
		func_4315(var_05,var_08);
		var_08 = var_08 + var_09;
		func_4315(var_06,var_08);
		var_08 = var_08 + var_09;
		func_4315(var_07,var_08);
		var_08 = var_08 + var_09;
	}
	else if(var_06 > 0)
	{
		func_4315(var_06,var_08);
		var_08 = var_08 + var_09;
		func_4315(var_07,var_08);
		var_08 = var_08 + var_09;
	}
	else
	{
		func_4315(var_07,var_08);
		var_08 = var_08 + var_09;
	}

	if(param_02)
	{
		var_0A = newhudelem();
		var_0A.x = 204.5;
		var_0A.y = level.var_241F + level.var_4366 * 15;
		var_0A.foreground = 1;
		var_0A.sort = 100;
		var_0A.alpha = 1;
		var_0A.alignx = "left";
		var_0A.horzalign = "left";
		var_0A.fontscale = 1;
		var_0A settext(".");
		level.var_435A[level.var_435A.size] = var_0A;
	}

	if(var_03)
	{
		var_0B = newhudelem();
		var_0B.x = 195.5;
		var_0B.y = level.var_241F + level.var_4366 * 15;
		var_0B.foreground = 1;
		var_0B.sort = 100;
		var_0B.alpha = 1;
		var_0B.alignx = "left";
		var_0B.horzalign = "left";
		var_0B.fontscale = 1;
		var_0B settext(" - ");
		level.var_435A[level.var_4366] = var_0B;
	}

	level.var_4366++;
}

//Function Number: 86
hud_debug_add_string(param_00,param_01)
{
	func_4314(param_00);
	hud_debug_add_second_string(param_01,0);
	level.var_4366++;
}

//Function Number: 87
func_4315(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.x = 200 + param_01 * 0.65;
	var_02.y = level.var_241F + level.var_4366 * 15;
	var_02.foreground = 1;
	var_02.sort = 100;
	var_02.alpha = 1;
	var_02.alignx = "left";
	var_02.horzalign = "left";
	var_02.fontscale = 1;
	var_02 settext(param_00 + "");
	level.var_435A[level.var_435A.size] = var_02;
}

//Function Number: 88
hud_debug_add_second_string(param_00,param_01)
{
	var_02 = newhudelem();
	var_02.x = 200 + param_01 * 0.65;
	var_02.y = level.var_241F + level.var_4366 * 15;
	var_02.foreground = 1;
	var_02.sort = 100;
	var_02.alpha = 1;
	var_02.alignx = "left";
	var_02.horzalign = "left";
	var_02.fontscale = 1;
	var_02 settext(param_00);
	level.var_435A[level.var_435A.size] = var_02;
}

//Function Number: 89
aa_init_stats()
{
	level.sp_stat_tracking_func = ::func_11A9;
	setdvar("aa_player_kills","0");
	setdvar("aa_enemy_deaths","0");
	setdvar("aa_enemy_damage_taken","0");
	setdvar("aa_player_damage_taken","0");
	setdvar("aa_player_damage_dealt","0");
	setdvar("aa_ads_damage_dealt","0");
	setdvar("aa_time_tracking","0");
	setdvar("aa_deaths","0");
	setdvar("player_cheated",0);
	level.auto_adjust_results = [];
	thread aa_time_tracking();
	thread aa_player_health_tracking();
	thread aa_player_ads_tracking();
	common_scripts\utility::flag_set("auto_adjust_initialized");
	common_scripts\utility::func_3385("aa_main_" + level.script);
	common_scripts\utility::flag_set("aa_main_" + level.script);
}

//Function Number: 90
func_1E72(param_00)
{
	var_01 = getkeybinding(param_00);
	if(var_01["count"] <= 0)
	{
		return 0;
	}

	for(var_02 = 1;var_02 < var_01["count"] + 1;var_02++)
	{
		if(self buttonpressed(var_01["key" + var_02]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 91
aa_time_tracking()
{
	waittillframeend;
	wait(0.2);
}

//Function Number: 92
aa_player_ads_tracking()
{
	level.player endon("death");
	level.var_5D69 = 0;
	for(;;)
	{
		if(level.player maps\_utility::func_4864())
		{
			level.var_5D69 = gettime();
			while(level.player maps\_utility::func_4864())
			{
				wait(0.05);
			}

			continue;
		}

		wait(0.05);
	}
}

//Function Number: 93
aa_player_health_tracking()
{
	for(;;)
	{
		level.player waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		aa_add_event("aa_player_damage_taken",var_00);
		if(!isalive(level.player))
		{
			aa_add_event("aa_deaths",1);
		}
	}
}

//Function Number: 94
func_11A9(param_00)
{
	if(!isdefined(level.auto_adjust_flags))
	{
		level.auto_adjust_flags = [];
	}

	common_scripts\utility::flag_wait("auto_adjust_initialized");
	level.auto_adjust_results[param_00] = [];
	level.auto_adjust_flags[param_00] = 0;
	common_scripts\utility::flag_wait(param_00);
	if(getdvar("aa_zone" + param_00) == "")
	{
		setdvar("aa_zone" + param_00,"on");
		level.auto_adjust_flags[param_00] = 1;
		aa_update_flags();
		setdvar("start_time" + param_00,getdvar("aa_time_tracking"));
		setdvar("starting_player_kills" + param_00,getdvar("aa_player_kills"));
		setdvar("starting_deaths" + param_00,getdvar("aa_deaths"));
		setdvar("starting_ads_damage_dealt" + param_00,getdvar("aa_ads_damage_dealt"));
		setdvar("starting_player_damage_dealt" + param_00,getdvar("aa_player_damage_dealt"));
		setdvar("starting_player_damage_taken" + param_00,getdvar("aa_player_damage_taken"));
		setdvar("starting_enemy_damage_taken" + param_00,getdvar("aa_enemy_damage_taken"));
		setdvar("starting_enemy_deaths" + param_00,getdvar("aa_enemy_deaths"));
	}
	else if(getdvar("aa_zone" + param_00) == "done")
	{
	}

	common_scripts\utility::func_33A0(param_00);
	auto_adust_zone_complete(param_00);
}

//Function Number: 95
auto_adust_zone_complete(param_00)
{
	setdvar("aa_zone" + param_00,"done");
	var_01 = getdvarfloat("start_time" + param_00);
	var_02 = getdvarint("starting_player_kills" + param_00);
	var_03 = getdvarint("aa_enemy_deaths" + param_00);
	var_04 = getdvarint("aa_enemy_damage_taken" + param_00);
	var_05 = getdvarint("aa_player_damage_taken" + param_00);
	var_06 = getdvarint("aa_player_damage_dealt" + param_00);
	var_07 = getdvarint("aa_ads_damage_dealt" + param_00);
	var_08 = getdvarint("aa_deaths" + param_00);
	level.auto_adjust_flags[param_00] = 0;
	aa_update_flags();
	var_09 = getdvarfloat("aa_time_tracking") - var_01;
	var_0A = getdvarint("aa_player_kills") - var_02;
	var_0B = getdvarint("aa_enemy_deaths") - var_03;
	var_0C = 0;
	if(var_0B > 0)
	{
		var_0C = var_0A / var_0B;
		var_0C = var_0C * 100;
		var_0C = int(var_0C);
	}

	var_0D = getdvarint("aa_enemy_damage_taken") - var_04;
	var_0E = getdvarint("aa_player_damage_dealt") - var_06;
	var_0F = 0;
	var_10 = 0;
	if(var_0D > 0 && var_09 > 0)
	{
		var_0F = var_0E / var_0D;
		var_0F = var_0F * 100;
		var_0F = int(var_0F);
		var_10 = var_0E / var_09;
		var_10 = var_10 * 60;
		var_10 = int(var_10);
	}

	var_11 = getdvarint("aa_ads_damage_dealt") - var_07;
	var_12 = 0;
	if(var_0E > 0)
	{
		var_12 = var_11 / var_0E;
		var_12 = var_12 * 100;
		var_12 = int(var_12);
	}

	var_13 = getdvarint("aa_player_damage_taken") - var_05;
	var_14 = 0;
	if(var_09 > 0)
	{
		var_14 = var_13 / var_09;
	}

	var_15 = var_14 * 60;
	var_15 = int(var_15);
	var_16 = getdvarint("aa_deaths") - var_08;
	var_17 = [];
	var_17["player_damage_taken_per_minute"] = var_15;
	var_17["player_damage_dealt_per_minute"] = var_10;
	var_17["minutes"] = var_09 / 60;
	var_17["deaths"] = var_16;
	var_17["gameskill"] = level.gameskill;
	level.auto_adjust_results[param_00] = var_17;
	var_18 = "Completed AA sequence: ";
	var_18 = var_18 + level.script + "/" + param_00;
	var_19 = getarraykeys(var_17);
	for(var_1A = 0;var_1A < var_19.size;var_1A++)
	{
		var_18 = var_18 + ", " + var_19[var_1A] + ": " + var_17[var_19[var_1A]];
	}

	logstring(var_18);
}

//Function Number: 96
aa_print_vals(param_00,param_01)
{
	logstring(param_00 + ": " + param_01[param_00]);
}

//Function Number: 97
aa_update_flags()
{
}

//Function Number: 98
aa_add_event(param_00,param_01)
{
	var_02 = getdvarint(param_00);
	setdvar(param_00,var_02 + param_01);
}

//Function Number: 99
aa_add_event_float(param_00,param_01)
{
	var_02 = getdvarfloat(param_00);
	setdvar(param_00,var_02 + param_01);
}

//Function Number: 100
return_false(param_00)
{
	return 0;
}

//Function Number: 101
func_5D80(param_00)
{
	if([[ level.custom_player_attacker ]](param_00))
	{
		return 1;
	}

	if(isplayer(param_00))
	{
		return 1;
	}

	if(!isdefined(param_00.car_damage_owner_recorder))
	{
		return 0;
	}

	return param_00 func_5DC1();
}

//Function Number: 102
func_5DC1()
{
	return self.player_damage * 1.75 > self.non_player_damage;
}

//Function Number: 103
empty_kill_func(param_00,param_01,param_02)
{
}

//Function Number: 104
auto_adjust_enemy_died(param_00,param_01,param_02,param_03)
{
	aa_add_event("aa_enemy_deaths",1);
	if(!isdefined(param_01))
	{
	}

	if(!func_5D80(param_01))
	{
	}

	[[ level.global_kill_func ]](param_02,self.damagelocation,param_03);
	aa_add_event("aa_player_kills",1);
}

//Function Number: 105
func_11A6(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isalive(self) || self.delayeddeath)
	{
		auto_adjust_enemy_died(param_00,param_01,param_04,param_03);
	}

	if(!func_5D80(param_01))
	{
	}

	aa_player_attacks_enemy_with_ads(param_00,param_04,param_03);
}

//Function Number: 106
aa_player_attacks_enemy_with_ads(param_00,param_01,param_02)
{
	aa_add_event("aa_player_damage_dealt",param_00);
	if(!level.player maps\_utility::func_4864())
	{
		[[ level.global_damage_func ]](param_01,self.damagelocation,param_02);
		return 0;
	}

	if(!bullet_attack(param_01))
	{
		[[ level.global_damage_func ]](param_01,self.damagelocation,param_02);
		return 0;
	}

	[[ level.var_3D2B ]](param_01,self.damagelocation,param_02);
	aa_add_event("aa_ads_damage_dealt",param_00);
	return 1;
}

//Function Number: 107
bullet_attack(param_00)
{
	if(param_00 == "MOD_PISTOL_BULLET")
	{
		return 1;
	}

	return param_00 == "MOD_RIFLE_BULLET";
}

//Function Number: 108
add_fractional_data_point(param_00,param_01,param_02)
{
	if(!isdefined(level.var_272E[param_00]))
	{
		level.var_272E[param_00] = [];
	}

	var_03 = [];
	var_03["frac"] = param_01;
	var_03["val"] = param_02;
	level.var_272E[param_00][level.var_272E[param_00].size] = var_03;
}

//Function Number: 109
coop_with_one_player_downed()
{
	return maps\_utility::func_47D0() && maps\_utility::func_3958().size == 1;
}