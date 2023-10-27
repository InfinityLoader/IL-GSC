/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_gameskill.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 82
 * Decompile Time: 1601 ms
 * Timestamp: 10/27/2023 2:47:51 AM
*******************************************************************/

//Function Number: 1
setskill(param_00)
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

		level.global_damage_func_ads = ::empty_kill_func;
		level.global_damage_func = ::empty_kill_func;
		level.global_kill_func = ::empty_kill_func;
		maps\_utility::set_console_status();
		if(getdvar("arcademode") == "1")
		{
			thread maps\_arcademode::main();
		}

		foreach(var_02 in level.players)
		{
			var_02 maps\_utility::ent_flag_init("player_has_red_flashing_overlay");
			var_02 maps\_utility::ent_flag_init("player_is_invulnerable");
			var_02 maps\_utility::ent_flag_init("player_zero_attacker_accuracy");
			var_02 maps\_utility::ent_flag_init("player_no_auto_blur");
			var_02 maps\_utility::ent_flag_init("near_death_vision_enabled");
			var_02 maps\_utility::ent_flag_clear("near_death_vision_enabled");
			var_02.gs = spawnstruct();
			var_02.a = spawnstruct();
			var_02.damage_functions = [];
			var_02 maps\_player_stats::init_stats();
			var_02 maps\_utility::ent_flag_init("global_hint_in_use");
			var_02.pers = [];
			if(!isdefined(var_02.baseignorerandombulletdamage))
			{
				var_02.baseignorerandombulletdamage = 0;
			}

			var_02.disabledweapon = 0;
			var_02.disabledweaponswitch = 0;
			var_02.disabledusability = 0;
		}

		level.difficultytype[0] = "easy";
		level.difficultytype[1] = "normal";
		level.difficultytype[2] = "hardened";
		level.difficultytype[3] = "veteran";
		level.difficultystring["easy"] = &"GAMESKILL_EASY";
		level.difficultystring["normal"] = &"GAMESKILL_NORMAL";
		level.difficultystring["hardened"] = &"GAMESKILL_HARDENED";
		level.difficultystring["veteran"] = &"GAMESKILL_VETERAN";
		thread gameskill_change_monitor();
	}

	setdvarifuninitialized("autodifficulty_playerDeathTimer",0);
	anim.run_accuracy = 0.5;
	anim.walk_accuracy = 0.8;
	setdvar("autodifficulty_frac",0);
	level.difficultysettings_frac_data_points = [];
	foreach(var_02 in level.players)
	{
		var_02 init_take_cover_warnings();
		var_02 thread increment_take_cover_warnings_on_death();
	}

	level.mg42badplace_mintime = 8;
	level.mg42badplace_maxtime = 16;
	level.difficultysettings["playerGrenadeBaseTime"]["easy"] = 40000;
	level.difficultysettings["playerGrenadeBaseTime"]["normal"] = 25000;
	level.difficultysettings["playerGrenadeBaseTime"]["hardened"] = 10000;
	level.difficultysettings["playerGrenadeBaseTime"]["veteran"] = 0;
	level.difficultysettings["playerGrenadeRangeTime"]["easy"] = 20000;
	level.difficultysettings["playerGrenadeRangeTime"]["normal"] = 15000;
	level.difficultysettings["playerGrenadeRangeTime"]["hardened"] = 5000;
	level.difficultysettings["playerGrenadeRangeTime"]["veteran"] = 1;
	level.difficultysettings["playerDoubleGrenadeTime"]["easy"] = 3600000;
	level.difficultysettings["playerDoubleGrenadeTime"]["normal"] = 120000;
	level.difficultysettings["playerDoubleGrenadeTime"]["hardened"] = 15000;
	level.difficultysettings["playerDoubleGrenadeTime"]["veteran"] = 0;
	level.difficultysettings["double_grenades_allowed"]["easy"] = 0;
	level.difficultysettings["double_grenades_allowed"]["normal"] = 1;
	level.difficultysettings["double_grenades_allowed"]["hardened"] = 1;
	level.difficultysettings["double_grenades_allowed"]["veteran"] = 1;
	level.difficultysettings["threatbias"]["easy"] = 100;
	level.difficultysettings["threatbias"]["normal"] = 150;
	level.difficultysettings["threatbias"]["hardened"] = 200;
	level.difficultysettings["threatbias"]["veteran"] = 400;
	level.difficultysettings["base_enemy_accuracy"]["easy"] = 1;
	level.difficultysettings["base_enemy_accuracy"]["normal"] = 1;
	level.difficultysettings["base_enemy_accuracy"]["hardened"] = 1.3;
	level.difficultysettings["base_enemy_accuracy"]["veteran"] = 1.3;
	level.difficultysettings["accuracyDistScale"]["easy"] = 1;
	level.difficultysettings["accuracyDistScale"]["normal"] = 1;
	level.difficultysettings["accuracyDistScale"]["hardened"] = 1;
	level.difficultysettings["accuracyDistScale"]["veteran"] = 0.5;
	level.difficultysettings["min_sniper_burst_delay_time"]["easy"] = 3;
	level.difficultysettings["min_sniper_burst_delay_time"]["normal"] = 2;
	level.difficultysettings["min_sniper_burst_delay_time"]["hardened"] = 1.5;
	level.difficultysettings["min_sniper_burst_delay_time"]["veteran"] = 1.1;
	level.difficultysettings["max_sniper_burst_delay_time"]["easy"] = 4;
	level.difficultysettings["max_sniper_burst_delay_time"]["normal"] = 3;
	level.difficultysettings["max_sniper_burst_delay_time"]["hardened"] = 2;
	level.difficultysettings["max_sniper_burst_delay_time"]["veteran"] = 1.5;
	level.difficultysettings["dog_health"]["easy"] = 0.25;
	level.difficultysettings["dog_health"]["normal"] = 0.75;
	level.difficultysettings["dog_health"]["hardened"] = 1;
	level.difficultysettings["dog_health"]["veteran"] = 1;
	if(getdvar("old_dog_melee_combat") == "1")
	{
		level.difficultysettings["dog_presstime"]["easy"] = 415;
		level.difficultysettings["dog_presstime"]["normal"] = 375;
		level.difficultysettings["dog_presstime"]["hardened"] = 250;
		level.difficultysettings["dog_presstime"]["veteran"] = 225;
	}
	else
	{
		level.difficultysettings["dog_presstime"]["easy"] = 750;
		level.difficultysettings["dog_presstime"]["normal"] = 550;
		level.difficultysettings["dog_presstime"]["hardened"] = 350;
		level.difficultysettings["dog_presstime"]["veteran"] = 250;
	}

	level.difficultysettings["dog_hits_before_kill"]["easy"] = 2;
	level.difficultysettings["dog_hits_before_kill"]["normal"] = 1;
	level.difficultysettings["dog_hits_before_kill"]["hardened"] = 0;
	level.difficultysettings["dog_hits_before_kill"]["veteran"] = 0;
	level.difficultysettings["pain_test"]["easy"] = ::always_pain;
	level.difficultysettings["pain_test"]["normal"] = ::always_pain;
	level.difficultysettings["pain_test"]["hardened"] = ::pain_protection;
	level.difficultysettings["pain_test"]["veteran"] = ::pain_protection;
	level.difficultysettings["missTimeConstant"]["easy"] = 1;
	level.difficultysettings["missTimeConstant"]["normal"] = 0.05;
	level.difficultysettings["missTimeConstant"]["hardened"] = 0;
	level.difficultysettings["missTimeConstant"]["veteran"] = 0;
	level.difficultysettings["missTimeDistanceFactor"]["easy"] = 0.0008;
	level.difficultysettings["missTimeDistanceFactor"]["normal"] = 0.0001;
	level.difficultysettings["missTimeDistanceFactor"]["hardened"] = 5E-05;
	level.difficultysettings["missTimeDistanceFactor"]["veteran"] = 0;
	level.difficultysettings["flashbangedInvulFactor"]["easy"] = 0.25;
	level.difficultysettings["flashbangedInvulFactor"]["normal"] = 0;
	level.difficultysettings["flashbangedInvulFactor"]["hardened"] = 0;
	level.difficultysettings["flashbangedInvulFactor"]["veteran"] = 0;
	level.difficultysettings["player_criticalBulletDamageDist"]["easy"] = 0;
	level.difficultysettings["player_criticalBulletDamageDist"]["normal"] = 0;
	level.difficultysettings["player_criticalBulletDamageDist"]["hardened"] = 0;
	level.difficultysettings["player_criticalBulletDamageDist"]["veteran"] = 0;
	level.difficultysettings["player_deathInvulnerableTime"]["easy"] = 4000;
	level.difficultysettings["player_deathInvulnerableTime"]["normal"] = 1700;
	level.difficultysettings["player_deathInvulnerableTime"]["hardened"] = 600;
	level.difficultysettings["player_deathInvulnerableTime"]["veteran"] = 100;
	level.difficultysettings["invulTime_preShield"]["easy"] = 0.6;
	level.difficultysettings["invulTime_preShield"]["normal"] = 0.35;
	level.difficultysettings["invulTime_preShield"]["hardened"] = 0.1;
	level.difficultysettings["invulTime_preShield"]["veteran"] = 0;
	level.difficultysettings["invulTime_onShield"]["easy"] = 0.8;
	level.difficultysettings["invulTime_onShield"]["normal"] = 0.5;
	level.difficultysettings["invulTime_onShield"]["hardened"] = 0.1;
	level.difficultysettings["invulTime_onShield"]["veteran"] = 0.05;
	level.difficultysettings["invulTime_postShield"]["easy"] = 0.5;
	level.difficultysettings["invulTime_postShield"]["normal"] = 0.3;
	level.difficultysettings["invulTime_postShield"]["hardened"] = 0.1;
	level.difficultysettings["invulTime_postShield"]["veteran"] = 0;
	level.difficultysettings["playerHealth_RegularRegenDelay"]["easy"] = 3000;
	level.difficultysettings["playerHealth_RegularRegenDelay"]["normal"] = 2000;
	level.difficultysettings["playerHealth_RegularRegenDelay"]["hardened"] = 1200;
	level.difficultysettings["playerHealth_RegularRegenDelay"]["veteran"] = 1200;
	level.difficultysettings["worthyDamageRatio"]["easy"] = 0;
	level.difficultysettings["worthyDamageRatio"]["normal"] = 0.1;
	level.difficultysettings["worthyDamageRatio"]["hardened"] = 0.1;
	level.difficultysettings["worthyDamageRatio"]["veteran"] = 0.1;
	level.difficultysettings["playerDifficultyHealth"]["easy"] = 475;
	level.difficultysettings["playerDifficultyHealth"]["normal"] = 275;
	level.difficultysettings["playerDifficultyHealth"]["hardened"] = 165;
	level.difficultysettings["playerDifficultyHealth"]["veteran"] = 115;
	level.difficultysettings["longRegenTime"]["easy"] = 5000;
	level.difficultysettings["longRegenTime"]["normal"] = 5000;
	level.difficultysettings["longRegenTime"]["hardened"] = 5000;
	level.difficultysettings["longRegenTime"]["veteran"] = 5000;
	level.difficultysettings["healthOverlayCutoff"]["easy"] = 0.01;
	level.difficultysettings["healthOverlayCutoff"]["normal"] = 0.2;
	level.difficultysettings["healthOverlayCutoff"]["hardened"] = 0.3;
	level.difficultysettings["healthOverlayCutoff"]["veteran"] = 0.5;
	level.difficultysettings["health_regenRate"]["easy"] = 0.1;
	level.difficultysettings["health_regenRate"]["normal"] = 0.1;
	level.difficultysettings["health_regenRate"]["hardened"] = 0.1;
	level.difficultysettings["health_regenRate"]["veteran"] = 0.1;
	level.difficultysettings["explosivePlantTime"]["easy"] = 10;
	level.difficultysettings["explosivePlantTime"]["normal"] = 10;
	level.difficultysettings["explosivePlantTime"]["hardened"] = 5;
	level.difficultysettings["explosivePlantTime"]["veteran"] = 5;
	level.difficultysettings["player_downed_buffer_time"]["normal"] = 2;
	level.difficultysettings["player_downed_buffer_time"]["hardened"] = 1.5;
	level.difficultysettings["player_downed_buffer_time"]["veteran"] = 0;
	level.lastplayersighted = 0;
	setsaveddvar("player_meleeDamageMultiplier",0.4);
	if(isdefined(level.custom_gameskill_func))
	{
		[[ level.custom_gameskill_func ]]();
	}

	updategameskill();
	updatealldifficulty();
	setdvar("autodifficulty_original_setting",level.gameskill);
}

//Function Number: 2
updatealldifficulty()
{
	setglobaldifficulty();
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] setdifficulty();
	}
}

//Function Number: 3
setdifficulty()
{
	set_difficulty_from_locked_settings();
}

//Function Number: 4
setglobaldifficulty()
{
	var_00 = ::get_locked_difficulty_val_global;
	var_01 = get_skill_from_index(level.gameskill);
	anim.dog_health = [[ var_00 ]]("dog_health",level.gameskill);
	anim.pain_test = level.difficultysettings["pain_test"][var_01];
	level.explosiveplanttime = level.difficultysettings["explosivePlantTime"][var_01];
	anim.min_sniper_burst_delay_time = [[ var_00 ]]("min_sniper_burst_delay_time",level.gameskill);
	anim.max_sniper_burst_delay_time = [[ var_00 ]]("max_sniper_burst_delay_time",level.gameskill);
	setsaveddvar("ai_accuracyDistScale",[[ var_00 ]]("accuracyDistScale",level.gameskill));
	if(maps\_utility::laststand_enabled())
	{
		level.player_downed_death_buffer_time = level.difficultysettings["player_downed_buffer_time"][var_01];
	}

	maps\_mgturret::setdifficulty();
}

//Function Number: 5
updategameskill()
{
	foreach(var_01 in level.players)
	{
		var_01.gameskill = var_01 maps\_utility::get_player_gameskill();
	}

	level.gameskill = level.player.gameskill;
	level.specops_reward_gameskill = level.player.gameskill;
	if(isdefined(level.forcedgameskill))
	{
		level.gameskill = level.forcedgameskill;
	}

	return level.gameskill;
}

//Function Number: 6
gameskill_change_monitor()
{
	var_00 = level.gameskill;
	var_01 = 0;
	for(;;)
	{
		if(!isdefined(var_00))
		{
			wait(1);
			var_00 = level.gameskill;
			continue;
		}

		if(!var_01)
		{
			updatealldifficulty();
			var_01 = 1;
		}

		if(var_00 != updategameskill())
		{
			var_00 = level.gameskill;
			updatealldifficulty();
		}

		wait(1);
	}
}

//Function Number: 7
get_skill_from_index(param_00)
{
	return level.difficultytype[param_00];
}

//Function Number: 8
apply_difficulty_frac_with_func(param_00,param_01)
{
	self.gs.invultime_preshield = [[ param_00 ]]("invulTime_preShield",param_01);
	self.gs.invultime_onshield = [[ param_00 ]]("invulTime_onShield",param_01);
	self.gs.invultime_postshield = [[ param_00 ]]("invulTime_postShield",param_01);
	self.gs.playerhealth_regularregendelay = [[ param_00 ]]("playerHealth_RegularRegenDelay",param_01);
	self.gs.worthydamageratio = [[ param_00 ]]("worthyDamageRatio",param_01);
	self.threatbias = int([[ param_00 ]]("threatbias",param_01));
	self.gs.longregentime = [[ param_00 ]]("longRegenTime",param_01);
	self.gs.healthoverlaycutoff = [[ param_00 ]]("healthOverlayCutoff",param_01);
	self.gs.regenrate = [[ param_00 ]]("health_regenRate",param_01);
	self.gs.player_attacker_accuracy = [[ param_00 ]]("base_enemy_accuracy",param_01);
	self.attackeraccuracy = self.gs.player_attacker_accuracy;
	update_player_attacker_accuracy();
	self.gs.playergrenadebasetime = int([[ param_00 ]]("playerGrenadeBaseTime",param_01));
	self.gs.playergrenaderangetime = int([[ param_00 ]]("playerGrenadeRangeTime",param_01));
	self.gs.playerdoublegrenadetime = int([[ param_00 ]]("playerDoubleGrenadeTime",param_01));
	self.gs.min_sniper_burst_delay_time = [[ param_00 ]]("min_sniper_burst_delay_time",param_01);
	self.gs.max_sniper_burst_delay_time = [[ param_00 ]]("max_sniper_burst_delay_time",param_01);
	self.gs.dog_presstime = [[ param_00 ]]("dog_presstime",param_01);
	self.deathinvulnerabletime = int([[ param_00 ]]("player_deathInvulnerableTime",param_01));
	self.criticalbulletdamagedist = int([[ param_00 ]]("player_criticalBulletDamageDist",param_01));
	self.damagemultiplier = 100 / [[ param_00 ]]("playerDifficultyHealth",param_01);
}

//Function Number: 9
update_player_attacker_accuracy()
{
	if(maps\_utility::ent_flag("player_zero_attacker_accuracy"))
	{
		return;
	}

	self.ignorerandombulletdamage = self.baseignorerandombulletdamage;
	self.attackeraccuracy = self.gs.player_attacker_accuracy;
}

//Function Number: 10
apply_difficulty_step_with_func(param_00,param_01)
{
	self.gs.misstimeconstant = [[ param_00 ]]("missTimeConstant",param_01);
	self.gs.misstimedistancefactor = [[ param_00 ]]("missTimeDistanceFactor",param_01);
	self.gs.dog_hits_before_kill = [[ param_00 ]]("dog_hits_before_kill",param_01);
	self.gs.double_grenades_allowed = [[ param_00 ]]("double_grenades_allowed",param_01);
}

//Function Number: 11
set_difficulty_from_locked_settings()
{
	apply_difficulty_frac_with_func(::get_locked_difficulty_val_player,1);
	apply_difficulty_step_with_func(::get_locked_difficulty_step_val_player,1);
}

//Function Number: 12
get_locked_difficulty_step_val_player(param_00,param_01)
{
	return level.difficultysettings[param_00][get_skill_from_index(self.gameskill)];
}

//Function Number: 13
getcurrentdifficultysetting(param_00)
{
	return level.difficultysettings[param_00][get_skill_from_index(self.gameskill)];
}

//Function Number: 14
get_locked_difficulty_val_player(param_00,param_01)
{
	return level.difficultysettings[param_00][get_skill_from_index(self.gameskill)];
}

//Function Number: 15
get_locked_difficulty_val_global(param_00,param_01)
{
	return level.difficultysettings[param_00][get_skill_from_index(level.gameskill)];
}

//Function Number: 16
always_pain()
{
	return 0;
}

//Function Number: 17
pain_protection()
{
	if(!pain_protection_check())
	{
		return 0;
	}

	return randomint(100) > 25;
}

//Function Number: 18
pain_protection_check()
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

//Function Number: 19
set_accuracy_based_on_situation()
{
	if(animscripts\combat_utility::issniper() && isalive(self.enemy))
	{
		setsniperaccuracy();
		return;
	}

	if(isplayer(self.enemy))
	{
		resetmissdebouncetime();
		if(self.a.misstime > gettime())
		{
			self.accuracy = 0;
			return;
		}

		if(self.script == "move")
		{
			self.accuracy = level.run_accuracy * self.baseaccuracy;
			return;
		}
	}
	else if(self.script == "move")
	{
		self.accuracy = level.run_accuracy * self.baseaccuracy;
		return;
	}

	self.accuracy = self.baseaccuracy;
}

//Function Number: 20
setsniperaccuracy()
{
	if(!isdefined(self.snipershotcount))
	{
		self.snipershotcount = 0;
		self.sniperhitcount = 0;
	}

	self.snipershotcount++;
	if((!isdefined(self.lastmissedenemy) || self.enemy != self.lastmissedenemy) && distancesquared(self.origin,self.enemy.origin) > 250000)
	{
		self.accuracy = 0;
		if(level.gameskill > 0 || self.snipershotcount > 1)
		{
			self.lastmissedenemy = self.enemy;
		}

		return;
	}

	self.accuracy = 1 + 1 * self.sniperhitcount * self.baseaccuracy;
	self.sniperhitcount++;
	if(level.gameskill < 1 && self.sniperhitcount == 1)
	{
		self.lastmissedenemy = undefined;
	}
}

//Function Number: 21
didsomethingotherthanshooting()
{
	self.a.misstimedebounce = 0;
}

//Function Number: 22
resetaccuracyandpause()
{
	resetmisstime();
}

//Function Number: 23
resetmisstime()
{
	if(!self isbadguy())
	{
		return;
	}

	if(self.weapon == "none")
	{
		return;
	}

	if(!animscripts\weaponlist::usingautomaticweapon() && !animscripts\weaponlist::usingsemiautoweapon())
	{
		self.misstime = 0;
		return;
	}

	if(!isalive(self.enemy))
	{
		return;
	}

	if(!isplayer(self.enemy))
	{
		self.accuracy = self.baseaccuracy;
		return;
	}

	var_00 = distance(self.enemy.origin,self.origin);
	setmisstime(self.enemy.gs.misstimeconstant + var_00 * self.enemy.gs.misstimedistancefactor);
}

//Function Number: 24
resetmissdebouncetime()
{
	self.a.misstimedebounce = gettime() + 3000;
}

//Function Number: 25
setmisstime(param_00)
{
	if(self.a.misstimedebounce > gettime())
	{
		return;
	}

	if(param_00 > 0)
	{
		self.accuracy = 0;
	}

	param_00 = param_00 * 1000;
	self.a.misstime = gettime() + param_00;
	self.a.accuracygrowthmultiplier = 1;
}

//Function Number: 26
playerhurtcheck()
{
	self.hurtagain = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03);
		self.hurtagain = 1;
		self.damagepoint = var_03;
		self.damageattacker = var_01;
	}
}

//Function Number: 27
player_health_packets()
{
	self.player_health_packets = 3;
}

//Function Number: 28
playerhealthregen()
{
	thread healthoverlayalt();
	thread healthoverlay();
	thread redhitflash();
	thread bloodsplatter();
	var_00 = 1;
	var_01 = 0;
	thread player_health_packets();
	var_02 = 0;
	var_03 = 0;
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
		if(self.health == self.maxhealth)
		{
			thread soundscripts\_audio::restore_after_deathsdoor();
			if(maps\_utility::ent_flag("player_has_red_flashing_overlay"))
			{
				maps\_utility::ent_flag_clear("player_has_red_flashing_overlay");
			}

			var_07 = 1;
			var_03 = 0;
			var_02 = 0;
			continue;
		}

		if(self.health <= 0)
		{
			return;
		}

		var_08 = 0;
		var_09 = var_02;
		var_0A = self.health / self.maxhealth;
		if(var_0A <= self.gs.healthoverlaycutoff && self.player_health_packets > 1)
		{
			var_02 = 1;
			if(!var_09)
			{
				var_05 = gettime();
				var_08 = 1;
				if(getdvarint("cg_altDamageMode") == 0)
				{
					if(isusinghdr())
					{
						thread blurview(2,2);
					}
					else
					{
						thread blurview(3.6,2);
					}
				}
				else if(isusinghdr())
				{
					thread blurview(40,0.25);
				}
				else
				{
					thread blurview(7.5,0.67);
				}

				thread soundscripts\_audio::set_deathsdoor();
				if(maps\_utility::ent_flag("near_death_vision_enabled"))
				{
					self painvisionon();
				}

				maps\_utility::ent_flag_set("player_has_red_flashing_overlay");
				var_03 = 1;
			}
		}

		if(self.hurtagain)
		{
			var_05 = gettime();
			self.hurtagain = 0;
		}

		if(self.health / self.maxhealth >= var_00)
		{
			if(gettime() - var_05 < self.gs.playerhealth_regularregendelay)
			{
				continue;
			}

			if(var_02)
			{
				var_06 = var_0A;
				if(gettime() > var_05 + self.gs.longregentime)
				{
					var_06 = var_06 + self.gs.regenrate;
				}

				if(var_06 >= 1)
				{
					reducetakecoverwarnings();
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
				return;
			}

			self setnormalhealth(var_06);
			var_00 = self.health / self.maxhealth;
			continue;
		}

		var_00 = var_07;
		var_0B = var_00 - var_0A >= self.gs.worthydamageratio;
		if(self.health <= 1)
		{
			self setnormalhealth(2 / self.maxhealth);
			var_0B = 1;
		}

		var_00 = self.health / self.maxhealth;
		self notify("hit_again");
		var_01 = 0;
		var_05 = gettime();
		if(var_08 == 0)
		{
			if(getdvarint("cg_altDamageMode") == 0)
			{
				if(isusinghdr())
				{
					thread blurview(2,2);
				}
				else
				{
					thread blurview(3.6,2);
				}
			}
			else if(isusinghdr())
			{
				thread blurview(4,0.67);
			}
			else
			{
				thread blurview(7.5,0.67);
			}
		}

		if(!var_0B)
		{
			continue;
		}

		if(maps\_utility::ent_flag("player_is_invulnerable"))
		{
			continue;
		}

		maps\_utility::ent_flag_set("player_is_invulnerable");
		level notify("player_becoming_invulnerable");
		if(var_03)
		{
			var_04 = self.gs.invultime_onshield;
			var_03 = 0;
		}
		else if(var_02)
		{
			var_04 = self.gs.invultime_postshield;
		}
		else
		{
			var_04 = self.gs.invultime_preshield;
		}

		var_07 = self.health / self.maxhealth;
		thread playerinvul(var_04);
	}
}

//Function Number: 29
reducetakecoverwarnings()
{
	if(!take_cover_warnings_enabled())
	{
		return;
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

//Function Number: 30
playerinvul(param_00)
{
	if(isdefined(self.flashendtime) && self.flashendtime > gettime())
	{
		param_00 = param_00 * getcurrentdifficultysetting("flashbangedInvulFactor");
	}

	if(param_00 > 0)
	{
		self.attackeraccuracy = 0;
		self.ignorerandombulletdamage = 1;
		wait(param_00);
	}

	update_player_attacker_accuracy();
	maps\_utility::ent_flag_clear("player_is_invulnerable");
}

//Function Number: 31
default_door_node_flashbang_frequency()
{
	if(self.team == "allies")
	{
		self.doorflashchance = 0.6;
	}

	if(self isbadguy())
	{
		if(level.gameskill >= 2)
		{
			self.doorflashchance = 0.8;
			return;
		}

		self.doorflashchance = 0.6;
	}
}

//Function Number: 32
grenadeawareness()
{
	if(self.team == "allies")
	{
		self.grenadeawareness = 0.9;
		return;
	}

	if(self isbadguy())
	{
		if(level.gameskill >= 2)
		{
			if(randomint(100) < 33)
			{
				self.grenadeawareness = 0.2;
				return;
			}

			self.grenadeawareness = 0.5;
			return;
		}

		if(randomint(100) < 33)
		{
			self.grenadeawareness = 0;
			return;
		}

		self.grenadeawareness = 0.2;
		return;
	}
}

//Function Number: 33
blurview(param_00,param_01)
{
	if(maps\_utility::ent_flag("player_no_auto_blur"))
	{
		return;
	}

	self notify("blurview_stop");
	self endon("blurview_stop");
	self setblurforplayer(param_00,0);
	wait(0.05);
	self setblurforplayer(0,param_01);
}

//Function Number: 34
healthoverlayalt()
{
	self endon("noHealthOverlay");
	var_00 = newclienthudelem(self);
	var_00.sourcewidth = 648;
	var_00.sourceheight = 486;
	var_00.scalewidth = 640;
	var_00.scaleheight = 480;
	switch(level.script)
	{
		case "village_assault":
		case "cargoship":
		case "blackout":
		case "airplane":
			break;

		case "launchfacility_b":
		case "bog_a":
			break;

		case "airlift":
			break;

		case "hunted":
			break;

		default:
			break;
	}
}

//Function Number: 35
healthoverlay()
{
	self endon("noHealthOverlay");
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("overlay_low_health",640,480);
	var_00.splatter = 1;
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.sort = 1;
	var_00.foreground = 0;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 0;
	thread healthoverlay_remove(var_00);
	for(;;)
	{
		var_00 fadeovertime(0.5);
		var_00.alpha = 0;
		if(!isalive(level.player))
		{
			break;
		}

		maps\_utility::ent_flag_wait("player_has_red_flashing_overlay");
		if(getdvarint("cg_altDamageMode") == 0)
		{
			redflashingoverlay(var_00);
			continue;
		}

		wait(0.5);
	}
}

//Function Number: 36
bloodsplatter()
{
	self endon("noHealthOverlay");
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("h1_fullscreen_lit_bloodsplat_01",640,480);
	var_00.splatter = 1;
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.sort = 3;
	var_00.foreground = 0;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.enablehudlighting = 1;
	var_00.color = (0,0,0);
	var_00.alpha = 0;
	thread healthoverlay_remove(var_00);
	var_01 = 0;
	var_02 = 0.28;
	var_03 = 0.05;
	var_04 = 5;
	for(;;)
	{
		var_05 = clamp(self.health / self.maxhealth,0,1);
		var_06 = 1 - var_05;
		if(var_01 > var_06)
		{
			var_01 = var_01 - var_02 * var_03;
		}

		if(var_01 < var_06)
		{
			var_01 = var_06;
		}

		var_00.color = (var_01,0,0);
		if(var_01 == 0)
		{
			var_00.alpha = 0;
		}
		else
		{
			var_00.alpha = 1;
		}

		wait(var_03);
	}
}

//Function Number: 37
redhitflash()
{
	self endon("noHealthOverlay");
	var_00 = newclienthudelem(self);
	var_00.x = 0;
	var_00.y = 0;
	var_00 setshader("h1_screen_blood",640,480);
	var_00.splatter = 1;
	var_00.alignx = "left";
	var_00.aligny = "top";
	var_00.sort = 2;
	var_00.foreground = 0;
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 0;
	thread healthoverlay_remove(var_00);
	for(;;)
	{
		level.player waittillplayerishitagain();
		if(!isalive(self))
		{
			break;
		}

		if(getdvarint("cg_altDamageMode") == 0)
		{
			thread redhitflashoverlay(var_00);
			continue;
		}

		wait(0.5);
	}

	var_00.alpha = 0;
}

//Function Number: 38
redhitflashoverlay(param_00)
{
	self endon("hit_again");
	param_00.alpha = 1;
	wait(0.17);
	param_00 fadeovertime(0.25);
	param_00.alpha = 0;
}

//Function Number: 39
compasshealthoverlay()
{
	self endon("noHealthOverlay");
	var_00 = newhudelem();
	var_00.x = 0;
	var_00.y = 35;
	var_00 setshader("overlay_low_health_compass",336,168);
	var_00.alignx = "center";
	var_00.aligny = "bottom";
	var_00.sort = 1;
	var_00.foreground = 0;
	var_00.horzalign = "center";
	var_00.vertalign = "bottom";
	var_00.alpha = 0;
	for(;;)
	{
		var_00 fadeovertime(0.2);
		var_00.alpha = 0;
		if(!isalive(self))
		{
			break;
		}

		self waittill("activate_compass_red_overlay");
		if(!maps\_utility::ent_flag("player_has_red_flashing_overlay"))
		{
			continue;
		}

		if(getdvar("compass") == "0")
		{
			wait(0.5);
			continue;
		}

		compassflashingoverlay(var_00);
	}
}

//Function Number: 40
compassflashingoverlay(param_00)
{
	self endon("hit_again");
	var_01 = gettime() + self.gs.longregentime;
	var_02 = var_01 + 500;
	var_03 = 0.2;
	var_04 = 0.2;
	while(isalive(self))
	{
		var_05 = 1;
		if(gettime() > var_01)
		{
			var_05 = 1 - gettime() - var_01 / var_02 - var_01;
			if(var_05 < 0)
			{
				var_05 = 0;
			}
		}

		param_00 fadeovertime(var_03);
		param_00.alpha = var_05;
		wait(var_03 + var_04);
		param_00 fadeovertime(var_03);
		param_00.alpha = var_05 * 0.8;
		wait(var_03);
		if(var_05 <= 0)
		{
			break;
		}
	}
}

//Function Number: 41
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
	if(!isdefined(self.background))
	{
		return;
	}

	self.background.x = 0;
	self.background.y = -40;
	self.background.alignx = "center";
	self.background.aligny = "middle";
	self.background.horzalign = "center";
	self.background.vertalign = "middle";
	if(level.console)
	{
		self.background setshader("popmenu_bg",650,52);
	}
	else
	{
		self.background setshader("popmenu_bg",650,42);
	}

	self.background.alpha = 0.5;
}

//Function Number: 42
create_warning_elem()
{
	var_00 = newclienthudelem(self);
	var_00 add_hudelm_position_internal();
	var_00 thread destroy_warning_elem_when_hit_again();
	var_00 thread destroy_warning_elem_when_mission_failed();
	var_00 settext(&"GAME_GET_TO_COVER");
	var_00.fontscale = 2;
	var_00.alpha = 1;
	var_00.color = (1,0.9,0.9);
	var_00.sort = 1;
	var_00.foreground = 1;
	return var_00;
}

//Function Number: 43
waittillplayerishitagain()
{
	self endon("hit_again");
	self waittill("damage");
}

//Function Number: 44
destroy_warning_elem_when_hit_again()
{
	self endon("being_destroyed");
	level.player waittillplayerishitagain();
	var_00 = !isalive(level.player);
	thread destroy_warning_elem(var_00);
}

//Function Number: 45
destroy_warning_elem_when_mission_failed()
{
	self endon("being_destroyed");
	common_scripts\utility::flag_wait("missionfailed");
	thread destroy_warning_elem(1);
}

//Function Number: 46
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

//Function Number: 47
may_change_cover_warning_alpha(param_00)
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

//Function Number: 48
fontscaler(param_00,param_01)
{
	self endon("death");
	param_00 = param_00 * 2;
	var_02 = param_00 - self.fontscale;
	self changefontscaleovertime(param_01);
	self.fontscale = self.fontscale + var_02;
}

//Function Number: 49
pulseoverlay(param_00)
{
	self endon("hit_again");
	self endon("kill_pulse");
	var_01 = 0.1;
	var_02 = 0.5;
	var_03 = 0.1;
	var_04 = 0.025;
	var_05 = 0.575;
	var_06 = 1;
	var_07 = 0.7;
	var_08 = 0.1;
	param_00.alpha = var_06;
	var_09 = max(var_01,var_04);
	var_09 = var_09 + max(var_03,var_08);
	var_0A = max(var_02,var_05);
	var_0A = var_0A + max(var_03,var_08);
	var_0B = "breathing_heartbeat";
	level.player playsound(var_0B);
	for(;;)
	{
		param_00 scaleovertime(var_02,param_00.sourcewidth,param_00.sourceheight);
		param_00 fadeovertime(var_05);
		param_00.alpha = var_07;
		wait(var_0A);
		param_00 scaleovertime(var_01,param_00.scalewidth,param_00.scaleheight);
		param_00 fadeovertime(var_04);
		param_00.alpha = var_06;
		wait(var_09);
		self playlocalsound(var_0B);
	}
}

//Function Number: 50
fadefunc(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0.65;
	var_06 = 0.5;
	var_07 = var_05 * 0.2;
	var_08 = var_05 * 0.1 + param_02 * 0.1;
	var_09 = var_05 * 0.05 + param_02 * 0.1;
	var_0A = var_05 * 0.3;
	var_0B = var_05 - var_07 - var_08 - var_09 - var_0A;
	if(var_0B < 0)
	{
		var_0B = 0;
	}

	var_0C = 0.5 + param_02 * 0.3;
	var_0D = 1 - 1 - var_0C / 2;
	param_00 fadeovertime(var_07);
	param_00.alpha = param_03 * 1;
	if(may_change_cover_warning_alpha(param_01))
	{
		if(!param_04)
		{
			param_01 fadeovertime(var_07);
			param_01.alpha = param_03 * 1;
		}
	}

	if(isdefined(param_01))
	{
		param_01 thread fontscaler(1,var_07);
	}

	wait(var_07 + var_08);
	param_00 fadeovertime(var_09);
	param_00.alpha = param_03 * var_0D;
	if(may_change_cover_warning_alpha(param_01))
	{
		if(!param_04)
		{
			param_01 fadeovertime(var_09);
			param_01.alpha = param_03 * var_0D;
		}
	}

	wait(var_09);
	param_00 fadeovertime(var_0A);
	param_00.alpha = param_03 * var_0C;
	if(may_change_cover_warning_alpha(param_01))
	{
		if(!param_04)
		{
			param_01 fadeovertime(var_0A);
			param_01.alpha = param_03 * var_0C;
		}
	}

	if(isdefined(param_01))
	{
		param_01 thread fontscaler(0.9,var_0A);
	}

	wait(var_0A);
	wait(var_0B);
}

//Function Number: 51
take_cover_warnings_enabled()
{
	if(isdefined(level.cover_warnings_disabled))
	{
		return 0;
	}

	if(isdefined(self.underwater) && self.underwater == 1)
	{
		return 0;
	}

	if(isdefined(self.vehicle))
	{
		return 0;
	}

	return 1;
}

//Function Number: 52
should_show_cover_warning()
{
	if(maps\_utility::is_h1_level())
	{
		return 0;
	}

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

	if(!take_cover_warnings_enabled())
	{
		return 0;
	}

	if(self.gameskill > 1)
	{
		return 0;
	}

	if(level.missionfailed)
	{
		return 0;
	}

	if(!maps\_load::map_is_early_in_the_game())
	{
		return 0;
	}

	if(getdvar("limited_mode") == "1")
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

//Function Number: 53
redflashingoverlayalt(param_00)
{
	self endon("hit_again");
	self notify("activate_compass_red_overlay");
	var_01 = undefined;
	if(should_show_cover_warning())
	{
		var_01 = create_warning_elem();
	}

	var_02 = gettime() + self.gs.longregentime;
	thread pulseoverlay(param_00);
	wait(self.gs.longregentime / 1000);
	if(may_change_cover_warning_alpha(var_01))
	{
		var_01 fadeovertime(1);
		var_01.alpha = 0;
	}

	self notify("kill_pulse");
	param_00 fadeovertime(0.5);
	param_00.alpha = 0;
	maps\_utility::ent_flag_clear("player_has_red_flashing_overlay");
	if(!isdefined(self.disable_breathing_sound) || !self.disable_breathing_sound)
	{
		var_03 = "breathing_better";
		if(soundexists(var_03))
		{
			self playlocalsound(var_03);
		}
	}

	if(maps\_utility::ent_flag("near_death_vision_enabled"))
	{
		self painvisionoff();
	}
}

//Function Number: 54
redflashingoverlay(param_00)
{
	self endon("hit_again");
	self notify("activate_compass_red_overlay");
	var_01 = undefined;
	if(should_show_cover_warning())
	{
		var_01 = create_warning_elem();
	}

	var_02 = gettime() + self.gs.longregentime;
	fadefunc(param_00,var_01,0.8,0.7,0);
	level.player playsound("breathing_heartbeat");
	while(gettime() < var_02 && isalive(self) && maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		fadefunc(param_00,var_01,0.9,1,0);
		var_03 = "breathing_heartbeat";
		if(soundexists(var_03))
		{
			self playlocalsound(var_03);
		}
	}

	if(may_change_cover_warning_alpha(var_01))
	{
		var_01 fadeovertime(1);
		var_01.alpha = 0;
	}

	fadefunc(param_00,var_01,0,0.7,1);
	param_00 fadeovertime(0.5);
	param_00.alpha = 0;
	maps\_utility::ent_flag_clear("player_has_red_flashing_overlay");
	if(!isdefined(self.disable_breathing_sound) || !self.disable_breathing_sound)
	{
		var_04 = "breathing_better";
		if(soundexists(var_04))
		{
			self playlocalsound(var_04);
		}
	}

	if(maps\_utility::ent_flag("near_death_vision_enabled"))
	{
		self painvisionoff();
	}
}

//Function Number: 55
healthoverlay_remove(param_00)
{
	self waittill("noHealthOverlay");
	param_00 destroy();
}

//Function Number: 56
resetskill()
{
	waittillframeend;
	setskill(1);
}

//Function Number: 57
init_take_cover_warnings()
{
	var_00 = level.script == "cargoship" || level.script == "coup";
	if(self getlocalplayerprofiledata("takeCoverWarnings") == -1 || var_00)
	{
		self setlocalplayerprofiledata("takeCoverWarnings",9);
	}
}

//Function Number: 58
increment_take_cover_warnings_on_death()
{
	self notify("new_cover_on_death_thread");
	self endon("new_cover_on_death_thread");
	self waittill("death");
	if(!maps\_utility::ent_flag("player_has_red_flashing_overlay"))
	{
		return;
	}

	if(!take_cover_warnings_enabled())
	{
		return;
	}

	if(level.gameskill > 1)
	{
		return;
	}

	var_00 = self getlocalplayerprofiledata("takeCoverWarnings");
	if(var_00 < 10)
	{
		self setlocalplayerprofiledata("takeCoverWarnings",var_00 + 1);
	}
}

//Function Number: 59
aa_init_stats()
{
	level.sp_stat_tracking_func = ::auto_adjust_new_zone;
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
	common_scripts\utility::flag_init("aa_main_" + level.script);
	common_scripts\utility::flag_set("aa_main_" + level.script);
}

//Function Number: 60
aa_time_tracking()
{
	waittillframeend;
	wait(0.2);
}

//Function Number: 61
aa_player_ads_tracking()
{
	level.player endon("death");
	level.player_ads_time = 0;
	for(;;)
	{
		if(level.player maps\_utility::isads())
		{
			level.player_ads_time = gettime();
			while(level.player maps\_utility::isads())
			{
				wait(0.05);
			}

			continue;
		}

		wait(0.05);
	}
}

//Function Number: 62
aa_player_health_tracking()
{
	for(;;)
	{
		level.player waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06);
		aa_add_event("aa_player_damage_taken",var_00);
		if(!isalive(level.player))
		{
			aa_add_event("aa_deaths",1);
			return;
		}
	}
}

//Function Number: 63
auto_adjust_new_zone(param_00)
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
		return;
	}

	common_scripts\utility::flag_waitopen(param_00);
	auto_adust_zone_complete(param_00);
}

//Function Number: 64
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

//Function Number: 65
aa_print_vals(param_00,param_01)
{
	logstring(param_00 + ": " + param_01[param_00]);
}

//Function Number: 66
aa_update_flags()
{
}

//Function Number: 67
aa_add_event(param_00,param_01)
{
	var_02 = getdvarint(param_00);
	setdvar(param_00,var_02 + param_01);
}

//Function Number: 68
aa_add_event_float(param_00,param_01)
{
	var_02 = getdvarfloat(param_00);
	setdvar(param_00,var_02 + param_01);
}

//Function Number: 69
return_false(param_00)
{
	return 0;
}

//Function Number: 70
player_attacker(param_00)
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

	return param_00 player_did_most_damage();
}

//Function Number: 71
player_did_most_damage()
{
	return self.player_damage * 1.75 > self.non_player_damage;
}

//Function Number: 72
empty_kill_func(param_00,param_01,param_02)
{
}

//Function Number: 73
auto_adjust_enemy_died(param_00,param_01,param_02,param_03)
{
	aa_add_event("aa_enemy_deaths",1);
	if(!isdefined(param_01))
	{
		return;
	}

	if(!player_attacker(param_01))
	{
		return;
	}

	[[ level.global_kill_func ]](param_02,self.damagelocation,param_03);
	aa_add_event("aa_player_kills",1);
}

//Function Number: 74
auto_adjust_enemy_death_detection(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isalive(self) || self.delayeddeath)
	{
		auto_adjust_enemy_died(param_00,param_01,param_04,param_03);
		return;
	}

	if(!player_attacker(param_01))
	{
		return;
	}

	aa_player_attacks_enemy_with_ads(param_00,param_04,param_03);
}

//Function Number: 75
aa_player_attacks_enemy_with_ads(param_00,param_01,param_02)
{
	aa_add_event("aa_player_damage_dealt",param_00);
	if(!level.player maps\_utility::isads())
	{
		[[ level.global_damage_func ]](param_01,self.damagelocation,param_02);
		return 0;
	}

	if(!bullet_attack(param_01))
	{
		[[ level.global_damage_func ]](param_01,self.damagelocation,param_02);
		return 0;
	}

	[[ level.global_damage_func_ads ]](param_01,self.damagelocation,param_02);
	aa_add_event("aa_ads_damage_dealt",param_00);
	return 1;
}

//Function Number: 76
bullet_attack(param_00)
{
	if(param_00 == "MOD_PISTOL_BULLET")
	{
		return 1;
	}

	return param_00 == "MOD_RIFLE_BULLET";
}

//Function Number: 77
coop_player_in_special_ops_survival()
{
}

//Function Number: 78
solo_player_in_special_ops()
{
}

//Function Number: 79
solo_player_in_coop_gameskill_settings()
{
}

//Function Number: 80
grenade_dirt_on_screen(param_00)
{
}

//Function Number: 81
blood_splat_on_screen(param_00)
{
}

//Function Number: 82
add_fractional_data_point(param_00,param_01,param_02)
{
}