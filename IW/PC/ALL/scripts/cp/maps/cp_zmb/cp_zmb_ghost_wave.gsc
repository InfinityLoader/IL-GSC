/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 151
 * Decompile Time: 7757 ms
 * Timestamp: 10/27/2023 12:08:25 AM
*******************************************************************/

//Function Number: 1
init()
{
	func_9603();
	func_F98F();
	func_9604();
	func_97B5();
	func_9601();
	func_953C();
	func_95EB();
	func_9691();
	lib_0F79::registerscriptedagent();
}

//Function Number: 2
func_953C()
{
	level.available_formations = [];
	for(var_00 = 1;var_00 <= level.gns_num_of_wave;var_00++)
	{
		level.available_formations[var_00] = [];
	}
}

//Function Number: 3
func_95EB()
{
	if(isdefined(level.init_formation_movement_func))
	{
		[[ level.init_formation_movement_func ]]();
		return;
	}

	init_formation_movements_default();
}

//Function Number: 4
init_formation_movements_default()
{
	level.formation_movements = [];
	func_DEB7(1,::func_731A);
	func_DEB7(2,::func_731B);
	func_DEB7(3,::func_731C);
	func_DEB7(4,::func_731D);
	func_DEB7(5,::func_731E);
	func_DEB7(6,::func_731F);
	func_DEB7(7,::func_7320);
	func_DEB7(8,::func_7321);
	func_DEB7(9,::func_7322);
	func_DEB7(10,::func_7323);
	func_DEB7(11,::func_7324);
	func_DEB7(12,::func_7325);
	func_DEB7(13,::func_7326);
	func_DEB7(14,::func_7327);
	func_DEB7(15,::func_7328);
}

//Function Number: 5
func_9691()
{
	level.var_BD48 = [];
}

//Function Number: 6
register_moving_target_wave(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.var_BC84 = param_01;
	var_04.solo_move_time = param_02;
	var_04.var_13594 = param_03;
	var_04.var_7329 = scripts\common\utility::random(level.available_formations[param_00]);
	var_04.var_BC4D = level.formation_movements[var_04.var_7329];
	level.var_BD48[param_00] = var_04;
}

//Function Number: 7
func_12FE9(param_00)
{
	param_00 giveweapon("iw7_entangler_zm");
	param_00 method_83B6("iw7_entangler_zm");
	param_00 scripts\common\utility::func_1C76(0);
	param_00 thread func_65FF(param_00);
	param_00 thread func_6601(param_00);
	param_00.var_D784 = param_00 scripts\cp\powers\coop_powers::func_7A3C(param_00);
	param_00 scripts\cp\powers\coop_powers::func_41D0();
}

//Function Number: 8
func_11053(param_00)
{
	param_00 scripts\common\utility::func_1C76(1);
	param_00 takeweapon("iw7_entangler_zm");
	if(!param_00 hasweapon(param_00.var_13BFF))
	{
		param_00 scripts\cp\_utility::func_12C6(param_00.var_13BFF,undefined,undefined,1);
	}

	param_00 switchtoweapon(param_00.var_13BFF);
	param_00 scripts\cp\powers\coop_powers::func_E2D1(param_00,param_00.var_D784);
	param_00 func_418F(param_00);
}

//Function Number: 9
func_65FF(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("stop_using_entabgler");
	for(;;)
	{
		func_DDE6(param_00,0);
		var_01 = 0;
		for(;;)
		{
			var_02 = param_00 scripts\common\utility::waittill_any_timeout_no_endon_death_2(0.2,"entangler_hit_same_target");
			if(var_02 == "entangler_hit_same_target")
			{
				var_01 = var_01 + 0.2;
				var_03 = min(var_01 / func_798F(),1);
				func_DDE6(param_00,var_03);
				if(var_03 == 1 && isalive(param_00.var_4B6F) && !lib_0C2D::func_9DDD(param_00.var_4B6F) && !isdefined(param_00.ghost_in_entanglement))
				{
					param_00.var_4B6F lib_0C2D::func_65FE(param_00.var_4B6F,param_00);
				}

				continue;
			}

			break;
		}
	}
}

//Function Number: 10
func_798F()
{
	return 1.25;
}

//Function Number: 11
func_6601(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("stop_using_entabgler");
	for(;;)
	{
		wait(0.5);
		param_00 setweaponammoclip("iw7_entangler_zm",weaponclipsize("iw7_entangler_zm"));
	}
}

//Function Number: 12
func_DDE6(param_00,param_01)
{
	param_00 setclientomnvar("zom_entangler_progress_percent",param_01);
}

//Function Number: 13
func_12DBA(param_00,param_01)
{
	if(!isdefined(param_00.var_4B6F) && param_00.var_4B6F == param_01)
	{
		param_00 thread func_4B70(param_00,param_01);
		return;
	}

	param_00 notify("entangler_hit_same_target");
}

//Function Number: 14
func_4B70(param_00,param_01)
{
	param_00 endon("disconnect");
	param_01 notify("entangler_target_monitor");
	param_01 endon("entangler_target_monitor");
	param_00.var_4B6F = param_01;
	scripts\common\utility::func_136F7();
	param_00.var_4B6F = undefined;
}

//Function Number: 15
func_F98F()
{
	level.var_EFF7 = ::func_1300C;
}

//Function Number: 16
func_1300C(param_00)
{
	var_01 = self;
	param_00 endon("death");
	var_01 endon("death");
	var_01 endon("disconnect");
	if(!scripts\cp\_utility::func_9F19(var_01))
	{
		param_00 delete();
		return;
	}

	var_01 thread scripts\cp\powers\coop_powers::func_8397("power_scu","secondary",undefined,undefined,undefined,0,0);
	func_418F(var_01);
	var_01.var_522D = param_00;
	param_00 waittill("missile_stuck",var_02);
	param_00 thread func_EFF8(param_00,var_01);
	for(;;)
	{
		scripts\common\utility::func_136F7();
		if(isdefined(var_01.var_4B6F) && lib_0C2D::func_9DDD(var_01.var_4B6F))
		{
			var_03 = var_01.var_4B6F;
			if(func_8264(var_03,param_00))
			{
				level thread func_8273(var_03.origin + (0,0,40),var_01.var_522D.origin,var_01);
				var_03.nocorpse = 1;
				var_03 suicide();
			}
		}
	}
}

//Function Number: 17
func_8273(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_00);
	var_03 setmodel("tag_origin");
	wait(0.1);
	playfxontag(level._effect["zombie_ghost_trail"],var_03,"tag_origin");
	var_04 = param_01;
	for(;;)
	{
		var_03 moveto(var_04,0.5,0.125);
		var_03 waittill("movedone");
		if(!isdefined(param_02) && isdefined(param_02.var_522D))
		{
			break;
		}

		var_04 = param_02.var_522D.origin;
		if(distancesquared(var_03.origin,var_04) < 400)
		{
			break;
		}
	}

	var_03 delete();
}

//Function Number: 18
func_418F(param_00)
{
	if(isdefined(param_00.var_522D))
	{
		if(isdefined(param_00.var_522D.var_AC8D))
		{
			param_00.var_522D.var_AC8D delete();
		}

		param_00.var_522D delete();
	}
}

//Function Number: 19
func_EFF8(param_00,param_01)
{
	param_00 endon("death");
	param_01 endon("disconnect");
	param_00.var_AC8D = spawnfx(level._effect["zombie_ghost_scu"],param_00.origin);
	scripts\common\utility::func_136F7();
	if(isdefined(param_00))
	{
		triggerfx(param_00.var_AC8D);
	}
}

//Function Number: 20
func_8264(param_00,param_01)
{
	if(distancesquared(param_00.origin,param_01.origin) < 6400)
	{
		return 1;
	}

	return 0;
}

//Function Number: 21
func_9603()
{
	level._effect["zombie_ghost_trail"] = loadfx("vfx/iw7/_requests/coop/zmb_ghost_soultrail");
	level._effect["zombie_ghost_scu"] = loadfx("vfx/iw7/_requests/coop/vfx_ghost_scu");
	level._effect["moving_target_explode"] = loadfx("vfx/iw7/core/zombie/powerups/vfx_zom_powerup_pickup.vfx");
	level._effect["moving_target_portal"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_ghost_portal_green.vfx");
	level._effect["GnS_activation"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_GnS_game_elec_bolts.vfx");
	level._effect["skull_discovered"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_ghost_exp.vfx");
}

//Function Number: 22
func_9604()
{
	level.var_13F2B = scripts\common\utility::getstructarray("ghost_spawn","targetname");
}

//Function Number: 23
func_10824(param_00,param_01,param_02)
{
	if(!isdefined(level.var_13F2D))
	{
		level.var_13F2D = [];
	}

	if(!isdefined(param_02))
	{
		param_02 = "axis";
	}

	var_03 = scripts\mp\_mp_agent::func_108E8("zombie_ghost",param_02,param_00,param_01);
	level.var_13F2D[level.var_13F2D.size] = var_03;
	return var_03;
}

//Function Number: 24
func_10FFB()
{
	level notify("stop_ghosts_attack_logic");
}

//Function Number: 25
func_8284()
{
	level endon("game_ended");
	level endon("stop_ghosts_attack_logic");
	wait(15);
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(var_01 func_37FA(var_01))
			{
				var_02 = sortbydistance(level.var_13F2D,var_01.origin);
				foreach(var_04 in var_02)
				{
					if(var_04 func_37F8())
					{
						var_04 func_24B0(var_01);
						break;
					}
				}
			}
		}

		wait(0.5);
	}
}

//Function Number: 26
func_37FA(param_00)
{
	if(param_00 scripts\cp\_utility::func_9E3A())
	{
		return 0;
	}

	if(scripts\cp\_laststand::player_in_laststand(param_00))
	{
		return 0;
	}

	if(lib_0F74::func_9EFA(param_00))
	{
		return 0;
	}

	if(!isalive(param_00))
	{
		return 0;
	}

	if(func_7B38(param_00) > func_7AC8())
	{
		return 0;
	}

	if(func_118D9(param_00) < func_7AE2())
	{
		return 0;
	}

	return 1;
}

//Function Number: 27
func_7AC8()
{
	return 4;
}

//Function Number: 28
func_7AE2()
{
	return 3;
}

//Function Number: 29
func_37F8()
{
	if(func_9BEF())
	{
		return 0;
	}

	var_00 = self;
	if(lib_0C2D::func_9DDD(var_00))
	{
		return 0;
	}

	if(var_00 lib_0C2D::func_7ED5() == "attack")
	{
		return 0;
	}

	if(func_118D8(var_00) < 7)
	{
		return 0;
	}

	return 1;
}

//Function Number: 30
func_9BEF()
{
	return 1;
}

//Function Number: 31
func_7B38(param_00)
{
	if(!isdefined(param_00.var_C1F5))
	{
		param_00.var_C1F5 = 0;
	}

	return param_00.var_C1F5;
}

//Function Number: 32
func_118D9(param_00)
{
	if(!isdefined(param_00.var_A8C1))
	{
		param_00.var_A8C1 = 0;
	}

	return gettime() - param_00.var_A8C1 / 1000;
}

//Function Number: 33
func_118D8(param_00)
{
	if(!isdefined(param_00.var_A88B))
	{
		param_00.var_A88B = 0;
	}

	return gettime() - param_00.var_A88B / 1000;
}

//Function Number: 34
func_24B0(param_00)
{
	var_01 = self;
	func_F3CE(var_01,param_00);
	var_01 thread lib_0C2D::func_8278(param_00);
}

//Function Number: 35
func_F3CE(param_00,param_01)
{
	var_02 = gettime();
	param_01.var_C1F5++;
	param_01.var_A8C1 = var_02;
	param_00.var_A88B = var_02;
}

//Function Number: 36
func_10714(param_00)
{
	level thread func_10715(param_00);
}

//Function Number: 37
func_10715(param_00)
{
	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		var_02 = scripts\common\utility::random(level.var_13F2B);
		var_03 = func_10824(var_02.origin,(0,0,0),"axis");
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 38
func_97B5()
{
	level.var_13F2D = [];
}

//Function Number: 39
func_10C61()
{
	if(scripts\common\utility::istrue(level.gns_active))
	{
		return;
	}

	level.gns_active = 1;
	scripts\cp\zombies\zombie_analytics::func_AF5B(level.wave_num);
	lib_0D2C::func_F617(1);
	func_5565();
	func_10C0C();
	play_start_ghost_vo_to_players();
	level.var_8288 = gettime();
	level.processing_ghost_wave_failing = 0;
	level thread func_BD4B();
	level thread func_8284();
	level thread func_10C62();
	level thread func_CFD5();
	if(isdefined(level.gns_start_func))
	{
		[[ level.gns_start_func ]]();
	}

	foreach(var_01 in level.players)
	{
		enter_ghosts_n_skulls(var_01);
	}
}

//Function Number: 40
play_start_ghost_vo_to_players()
{
	foreach(var_01 in level.players)
	{
		var_01 thread scripts\cp\_vo::try_to_play_vo("ghost_start","zmb_comment_vo","low",3,0,0,1);
	}
}

//Function Number: 41
enter_ghosts_n_skulls(param_00)
{
	if(isdefined(level.enter_ghosts_n_skulls_func))
	{
		[[ level.enter_ghosts_n_skulls_func ]](param_00);
	}

	param_00.dontremoveperks = 1;
	param_00 scripts\cp\_laststand::func_6235(param_00);
	param_00.var_13BFF = param_00 scripts\cp\_utility::getweapontoswitchbackto();
	param_00 scripts\cp\zombies\arcade_game_utility::take_player_super_pre_game();
	param_00.disable_self_revive_fnf = 1;
	param_00.allow_carry = 0;
	param_00.ghost_in_entanglement = undefined;
	param_00.disable_consumables = 1;
	param_00.playing_ghosts_n_skulls = 1;
	param_00 store_and_take_perks(param_00);
	param_00 func_12980(param_00);
	param_00 func_1162C(param_00);
	param_00 func_56C1(param_00);
	param_00 func_12FE9(param_00);
	param_00 func_110A2(param_00);
	param_00 allowmelee(0);
	if(isdefined(level.gns_laststand_monitor))
	{
		param_00 thread [[ level.gns_laststand_monitor ]](param_00);
	}
}

//Function Number: 42
func_CFD5()
{
	level endon("game_ended");
	level endon("delay_end_ghost");
	for(;;)
	{
		level waittill("player_spawned",var_00);
		var_00 thread delay_enter_ghosts_n_skulls(var_00);
	}
}

//Function Number: 43
delay_enter_ghosts_n_skulls(param_00)
{
	level endon("game_ended");
	level endon("delay_end_ghost");
	param_00 endon("disconnect");
	if(isdefined(level.gns_hotjoin_wait_notify))
	{
		param_00 waittill(level.gns_hotjoin_wait_notify);
	}

	wait(5);
	enter_ghosts_n_skulls(param_00);
}

//Function Number: 44
func_10C0C()
{
	if(scripts\common\utility::istrue(level.disable_gns_death_trigger))
	{
		return;
	}

	var_00 = getent("ghost_death_trigger","targetname");
	var_00 thread func_8266(var_00);
}

//Function Number: 45
func_8266(param_00)
{
	level endon("game_ended");
	param_00 endon("stop_death_trigger_monitor");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(scripts\cp\_laststand::player_in_laststand(var_01))
		{
			continue;
		}

		var_01 setvelocity((0,1400,700));
		var_01 method_83F6(10,var_01.origin);
		var_01 shellshock("default",3);
		var_01 dodamage(var_01.health,var_01.origin);
	}
}

//Function Number: 46
func_62D4()
{
	lib_0D2C::func_F617(0);
	func_6225();
	func_1101F();
	func_10FFB();
	level thread func_10FFC();
}

//Function Number: 47
func_10FD2()
{
	var_00 = getent("ghost_death_trigger","targetname");
	var_00 notify("stop_death_trigger_monitor");
}

//Function Number: 48
func_62D3(param_00)
{
	if(!scripts\common\utility::istrue(param_00.playing_ghosts_n_skulls))
	{
		return;
	}

	param_00 endon("disconnect");
	param_00 func_E2BD(param_00);
	if(scripts\cp\_laststand::player_in_laststand(param_00))
	{
		param_00 scripts\cp\_laststand::func_992F(param_00);
		scripts\common\utility::func_136F7();
	}

	param_00 scripts\cp\_laststand::func_557F(param_00);
	param_00 func_12953(param_00);
	param_00 func_12954(param_00);
	param_00 func_E02F(param_00);
	param_00 func_11053(param_00);
	param_00 func_11631(param_00);
	param_00 func_E2BF(param_00);
	param_00 scripts\cp\_utility::func_E2D4();
	param_00.dontremoveperks = undefined;
	param_00.disable_self_revive_fnf = undefined;
	param_00.allow_carry = 1;
	param_00.disable_consumables = undefined;
	param_00.playing_ghosts_n_skulls = undefined;
	param_00 allowmelee(1);
	if(isdefined(level.end_ghosts_n_skulls_func))
	{
		[[ level.end_ghosts_n_skulls_func ]](param_00);
	}

	param_00 thread scripts\cp\_vo::try_to_play_vo("ghost_end","zmb_comment_vo","highest");
}

//Function Number: 49
func_10C62()
{
	level endon("game_ended");
	level.var_13FA3 = 1;
	foreach(var_01 in level.spawned_enemies)
	{
		if(isdefined(var_01))
		{
			var_01.var_54CB = 1;
			var_01.nocorpse = 1;
			var_01 suicide();
		}
	}

	scripts\common\utility::func_136F7();
	level thread scripts\cp\zombies\zombies_spawning::func_10717();
}

//Function Number: 50
func_10FFC()
{
	level endon("game_ended");
	level.var_13FA3 = 0;
	level notify("stop_ghost_spawn");
	scripts\common\utility::func_136F7();
	foreach(var_01 in level.var_13F2D)
	{
		var_01.var_54CB = 1;
		var_01.nocorpse = 1;
		var_01 suicide();
	}
}

//Function Number: 51
func_9601(param_00,param_01)
{
	level.var_8269 = ::func_12DFC;
}

//Function Number: 52
func_12DFC(param_00,param_01)
{
	level.var_13F2D = scripts\common\utility::func_22A9(level.var_13F2D,self);
	level.var_3CB5 = scripts\common\utility::func_22A9(level.var_3CB5,self);
}

//Function Number: 53
func_BD4B()
{
	level endon("game_ended");
	level endon("stop_moving_target_sequence");
	func_10C60();
	for(var_00 = 1;var_00 <= level.gns_num_of_wave;var_00++)
	{
		var_01 = scripts\common\utility::getstructarray("ghost_formation_" + func_79C9(var_00),"targetname");
		if(var_01.size > 0)
		{
			level.var_8287++;
			func_E807(var_00,var_01);
			if(isdefined(level.complete_one_gns_wave_func))
			{
				level thread [[ level.complete_one_gns_wave_func ]]();
			}

			continue;
		}

		break;
	}

	func_7667();
}

//Function Number: 54
func_E807(param_00,param_01)
{
	func_E207();
	func_E20C();
	func_E1E1();
	wait(2);
	func_BD44(param_01,param_00);
	func_15D5(param_00);
	func_15A4();
	level thread func_BD49();
	if(isdefined(level.moving_target_activation_func))
	{
		level thread [[ level.moving_target_activation_func ]](param_00);
	}

	var_02 = func_7D58(param_00);
	var_03 = func_7D59(param_00);
	while(func_1637())
	{
		foreach(var_06, var_05 in level.var_BD43)
		{
			if(var_05.size == 0)
			{
				continue;
			}

			func_BC33(var_06,var_05,var_02,var_03);
			level notify("moving_target_attack",var_05);
		}
	}
}

//Function Number: 55
func_BC33(param_00,param_01,param_02,param_03)
{
	var_04 = func_79F7(param_00);
	var_05 = func_77D0(param_01);
	if(isdefined(var_05) && isdefined(var_05.origin))
	{
		func_12846(var_05.origin + var_04);
	}

	foreach(var_07 in param_01)
	{
		if(!isdefined(var_07))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_07.var_7009))
		{
			continue;
		}

		var_07 moveto(var_07.origin + var_04,param_02);
	}

	wait(param_02 + param_03);
}

//Function Number: 56
func_77D0(param_00)
{
	foreach(var_02 in param_00)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_02.var_7009))
		{
			continue;
		}

		return var_02;
	}

	return undefined;
}

//Function Number: 57
func_E207()
{
	level.var_BD43 = [];
	level.var_BD46 = [];
	level.var_BD46["high"] = [];
	level.var_BD46["medium"] = [];
	level.var_BD46["low"] = [];
	level.var_BD45 = [];
	level.var_C1F0 = 0;
	func_12DF9();
	if(isdefined(level.var_E207))
	{
		[[ level.var_E207 ]]();
	}
}

//Function Number: 58
func_BD44(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		var_04 = func_10776(var_03);
		level.var_BD43[level.var_BD43.size] = var_04;
	}

	foreach(var_07, var_04 in level.var_BD43)
	{
		level.var_BD45[var_07] = func_7AFC(param_01,var_04);
	}

	wait(1);
}

//Function Number: 59
func_7AFC(param_00,param_01)
{
	var_02 = level.var_BD48[param_00];
	var_03 = [[ var_02.var_BC4D ]](param_01);
	return var_03;
}

//Function Number: 60
func_10776(param_00)
{
	var_01 = [];
	var_01[var_01.size] = func_10774(param_00);
	scripts\common\utility::func_136F7();
	foreach(var_03 in scripts\common\utility::getstructarray(param_00.target,"targetname"))
	{
		var_01[var_01.size] = func_10774(var_03);
		scripts\common\utility::func_136F7();
	}

	return var_01;
}

//Function Number: 61
func_10774(param_00)
{
	var_01 = scripts\common\utility::getstruct("ghost_wave_start_pos","targetname");
	var_02 = spawn("script_model",var_01.origin);
	var_02 setmodel(get_moving_target_model());
	var_02.angles = var_01.angles;
	var_02.var_EE79 = param_00.var_EE79;
	var_02.var_1E84 = param_00.angles;
	if(isdefined(level.assign_moving_target_flags_func))
	{
		[[ level.assign_moving_target_flags_func ]](param_00,var_02);
	}

	var_02 moveto(param_00.origin,1);
	var_03 = param_00.script_noteworthy;
	level.var_BD46[var_03][level.var_BD46[var_03].size] = var_02;
	return var_02;
}

//Function Number: 62
get_moving_target_model()
{
	if(isdefined(level.gns_moving_target_model))
	{
		return level.gns_moving_target_model;
	}

	return "zmb_pixel_skull";
}

//Function Number: 63
func_15D5(param_00)
{
	if(isdefined(level.activate_moving_targets_func))
	{
		[[ level.activate_moving_targets_func ]](param_00);
		return;
	}

	activate_moving_targets_default(param_00);
}

//Function Number: 64
activate_moving_targets_default(param_00)
{
	foreach(var_02 in level.var_BD43)
	{
		foreach(var_04 in var_02)
		{
			var_04.original_angles_to_face = var_04.angles;
			var_04 rotateto(var_04.var_1E84,1,1);
		}
	}

	wait(1);
	if(isdefined(level.post_moving_target_rotate_func))
	{
		level thread [[ level.post_moving_target_rotate_func ]]();
	}

	foreach(var_02 in level.var_BD43)
	{
		foreach(var_04 in var_02)
		{
			[[ level.set_moving_target_color_func ]](var_04,param_00);
		}
	}
}

//Function Number: 65
all_moving_targets_hide_color()
{
	foreach(var_01 in level.var_BD43)
	{
		foreach(var_03 in var_01)
		{
			if(var_03.color == "red")
			{
				continue;
			}

			if(scripts\common\utility::istrue(var_03.var_7009))
			{
				continue;
			}

			var_03 thread hide_color(var_03);
		}
	}
}

//Function Number: 66
all_moving_targets_show_color()
{
	foreach(var_01 in level.var_BD43)
	{
		foreach(var_03 in var_01)
		{
			if(var_03.color == "red")
			{
				continue;
			}

			if(scripts\common\utility::istrue(var_03.var_7009))
			{
				continue;
			}

			var_03 thread show_color(var_03);
		}
	}
}

//Function Number: 67
hide_color(param_00)
{
	param_00 endon("death");
	param_00 endon("become_red_moving_target");
	param_00 rotateto(param_00.original_angles_to_face,1,1);
	wait(1);
	param_00 setscriptablepartstate("skull_vfx","off");
}

//Function Number: 68
show_color(param_00)
{
	param_00 endon("death");
	param_00 rotateto(param_00.var_1E84,1,1);
	wait(1);
	param_00 setscriptablepartstate("skull_vfx",param_00.color);
}

//Function Number: 69
func_10C60()
{
	var_00 = scripts\common\utility::getstruct("ghost_wave_portal","targetname");
	var_01 = spawnfx(level._effect["moving_target_portal"],var_00.origin,anglestoforward(var_00.angles),anglestoup(var_00.angles));
	wait(1);
	triggerfx(var_01);
	level.var_826D = var_01;
}

//Function Number: 70
func_10FFA()
{
	if(isdefined(level.var_826D))
	{
		level.var_826D delete();
	}
}

//Function Number: 71
activate_red_moving_target(param_00)
{
	param_00 notify("become_red_moving_target");
	param_00.angles = param_00.var_1E84;
	set_moving_target_color(param_00,"red");
	var_01 = param_00 scripts\common\utility::waittill_any_timeout_no_endon_death_2(level.moving_target_pre_fly_time,"death");
	if(var_01 == "timeout")
	{
		param_00 func_6F83(param_00);
	}
}

//Function Number: 72
set_moving_target_color(param_00,param_01)
{
	param_00.color = param_01;
	param_00 setscriptablepartstate("skull_vfx",param_01);
}

//Function Number: 73
func_BD49()
{
	level notify("moving_targets_attack_logic");
	level endon("moving_targets_attack_logic");
	level endon("game_ended");
	level endon("stop_moving_target_sequence");
	var_00 = 0;
	while(func_1637())
	{
		level waittill("moving_target_attack",var_01);
		var_02 = gettime();
		if(!func_1C6A(var_00,var_02))
		{
			continue;
		}

		var_00 = var_02 + get_moving_target_attack_interval();
		var_03 = func_F19E(var_01);
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = var_03.var_BD41;
		var_05 = var_03.player;
		var_06 = vectornormalize(var_05 geteye() - var_04.origin);
		var_07 = var_04.origin + var_06 * 60;
		var_08 = var_05.origin;
		level thread func_FE54(var_07,var_08);
	}
}

//Function Number: 74
get_moving_target_attack_interval()
{
	if(isdefined(level.moving_target_attack_interval))
	{
		return level.moving_target_attack_interval;
	}

	return 1500;
}

//Function Number: 75
func_1C6A(param_00,param_01)
{
	return param_01 > param_00;
}

//Function Number: 76
func_FE54(param_00,param_01)
{
	for(var_02 = 0;var_02 < 3;var_02++)
	{
		magicbullet("zmb_8bit_laser",param_00,param_01);
		wait(0.25);
	}
}

//Function Number: 77
func_F19E(param_00)
{
	if(param_00.size == 0)
	{
		return undefined;
	}

	var_01 = spawnstruct();
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04))
		{
			var_02[var_02.size] = var_04;
		}
	}

	var_02 = scripts\common\utility::array_randomize(var_02);
	foreach(var_07 in var_02)
	{
		var_08 = func_F1A0(var_07);
		if(isdefined(var_08))
		{
			var_01.var_BD41 = var_07;
			var_01.player = var_08;
			return var_01;
		}
	}

	return undefined;
}

//Function Number: 78
func_F1A0(param_00)
{
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(scripts\cp\_laststand::player_in_laststand(var_03))
		{
			continue;
		}

		if(!bullettracepassed(param_00.origin,var_03 geteye(),0,param_00))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return scripts\common\utility::random(var_01);
}

//Function Number: 79
func_1101F()
{
	func_10FFA();
	foreach(var_01 in level.var_BD43)
	{
		foreach(var_03 in var_01)
		{
			if(isdefined(var_03))
			{
				var_03 delete();
			}
		}
	}

	level notify("stop_moving_target_sequence");
}

//Function Number: 80
func_DB04()
{
	foreach(var_02, var_01 in level.var_BD43)
	{
		level.var_BD43[var_02] = scripts\common\utility::func_22BC(var_01);
	}

	foreach(var_04, var_01 in level.var_BD46)
	{
		level.var_BD46[var_04] = scripts\common\utility::func_22BC(var_01);
	}
}

//Function Number: 81
func_7667()
{
	level thread func_50B6();
}

//Function Number: 82
func_50B6()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		var_01 thread scripts\cp\_vo::try_to_play_vo("quest_acrcade_play_success","zmb_comment_vo","highest",3,0,0,1);
	}

	func_50B4(1);
	level.var_8286 = 1;
	scripts\cp\zombies\zombie_analytics::func_AF83(level.var_8287,level.var_8286,gettime() - level.var_8288 / 1000);
	if(isdefined(level.gns_reward_func))
	{
		level thread [[ level.gns_reward_func ]]();
	}
}

//Function Number: 83
func_50B4(param_00)
{
	level notify("delay_end_ghost");
	level endon("delay_end_ghost");
	func_8E9F();
	func_62D4();
	func_100DF(param_00);
	func_10FD2();
	if(isdefined(level.pre_gns_end_func))
	{
		level thread [[ level.pre_gns_end_func ]]();
	}

	wait(5);
	foreach(var_02 in level.players)
	{
		var_02 thread func_62D3(var_02);
	}

	scripts\common\utility::func_136F7();
	func_E1E1();
	level.gns_active = 0;
	if(param_00 == 2)
	{
		level notify("end_this_thread_of_gns_fnf_card");
	}

	if(isdefined(level.gns_end_func))
	{
		[[ level.gns_end_func ]]();
	}
}

//Function Number: 84
func_8E9F()
{
	foreach(var_01 in level.players)
	{
		var_01 thread func_8E7D(var_01);
	}
}

//Function Number: 85
func_8E7D(param_00)
{
	param_00 endon("disconnect");
	param_00 notify("stop_using_entabgler");
	scripts\common\utility::func_136F7();
	param_00 setclientomnvar("zm_ui_ghost_arcade_message",0);
	param_00 setclientomnvar("zom_entangler_progress_percent",0);
}

//Function Number: 86
store_and_take_perks(param_00)
{
	param_00.var_D7C1 = [];
	if(!isdefined(param_00.var_13FA4))
	{
		return;
	}

	foreach(var_03, var_02 in param_00.var_13FA4)
	{
		if(scripts\common\utility::istrue(param_00.var_13FA4[var_03]) && should_be_removed_for_gns(var_03))
		{
			param_00.var_D7C1 = scripts\common\utility::array_add(param_00.var_D7C1,var_03);
			param_00 lib_0D5D::func_1145C(var_03);
			gns_take_perks_handler(param_00,var_03);
		}
	}
}

//Function Number: 87
gns_take_perks_handler(param_00,param_01)
{
	switch(param_01)
	{
		case "perk_machine_revive":
			param_00.var_F1E7--;
			break;

		default:
			break;
	}
}

//Function Number: 88
should_be_removed_for_gns(param_00)
{
	switch(param_00)
	{
		case "perk_machine_more":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 89
func_E2BD(param_00)
{
	foreach(var_02 in param_00.var_D7C1)
	{
		param_00 lib_0D5D::func_834E(var_02,0);
	}
}

//Function Number: 90
func_56C1(param_00)
{
	param_00 thread func_56B9(param_00,1,6);
}

//Function Number: 91
func_E02F(param_00)
{
	param_00 setclientomnvar("zm_ui_ghost_arcade_message",0);
}

//Function Number: 92
func_56B9(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	param_00 notify("display_ghost_arcade_message");
	param_00 endon("display_ghost_arcade_message");
	if(!isdefined(param_01))
	{
		return;
	}

	param_00 setclientomnvar("zm_ui_ghost_arcade_message",param_01);
	wait(param_02);
	func_E02F(param_00);
}

//Function Number: 93
func_E20C()
{
	level.var_C1F2 = 0;
}

//Function Number: 94
func_1637()
{
	return func_7B35() > 0;
}

//Function Number: 95
func_7B35()
{
	var_00 = 0;
	foreach(var_02 in level.var_BD46)
	{
		var_00 = var_00 + var_02.size;
	}

	return var_00;
}

//Function Number: 96
func_79F7(param_00)
{
	var_01 = level.var_BD45[param_00];
	var_02 = var_01[0];
	if(var_01.size > 1)
	{
		var_03 = [];
		for(var_04 = 1;var_04 < var_01.size;var_04++)
		{
			var_03[var_03.size] = var_01[var_04];
		}

		var_03[var_03.size] = var_02;
		level.var_BD45[param_00] = var_03;
	}

	return func_12685(var_02);
}

//Function Number: 97
func_7D58(param_00)
{
	if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
	{
		return level.var_BD48[param_00].solo_move_time;
	}

	return level.var_BD48[param_00].var_BC84;
}

//Function Number: 98
func_7D59(param_00)
{
	return level.var_BD48[param_00].var_13594;
}

//Function Number: 99
func_12685(param_00)
{
	switch(param_00)
	{
		case "R":
			return (120,0,0);

		case "L":
			return (-120,0,0);

		case "F":
			return (0,120,0);

		case "U":
			return (0,0,120);

		case "D":
			return (0,0,-120);

		case "RU":
			return (120,0,120);

		case "LU":
			return (-120,0,120);

		case "RD":
			return (120,0,-120);

		case "LD":
			return (-120,0,-120);

		default:
			break;
	}
}

//Function Number: 100
func_77CF()
{
	if(level.var_BD46["high"].size > 0)
	{
		return scripts\common\utility::random(level.var_BD46["high"]);
	}

	if(level.var_BD46["medium"].size > 0)
	{
		return scripts\common\utility::random(level.var_BD46["medium"]);
	}

	if(level.var_BD46["low"].size > 0)
	{
		return scripts\common\utility::random(level.var_BD46["low"]);
	}

	return undefined;
}

//Function Number: 101
func_6F83(param_00)
{
	param_00 endon("death");
	param_00.var_7009 = 1;
	var_01 = scripts\common\utility::getstruct("ghost_wave_start_pos","targetname");
	param_00 moveto(var_01.origin,6);
	param_00 waittill("movedone");
	level.var_C1F0++;
	func_56CF();
	func_53BB();
	func_E0A0(param_00);
	param_00 delete();
}

//Function Number: 102
func_56CF()
{
	func_56C8();
	func_12DF9();
}

//Function Number: 103
func_56C8()
{
	foreach(var_01 in level.players)
	{
		var_01 thread func_56B9(var_01,func_7C6E(),4);
	}
}

//Function Number: 104
func_7C6E()
{
	switch(level.var_C1F0)
	{
		case 1:
			return 2;

		case 2:
			return 3;

		case 3:
			return 4;
	}
}

//Function Number: 105
func_12DF9()
{
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("zm_ui_num_targets_escaped",level.var_C1F0);
	}
}

//Function Number: 106
func_E0A0(param_00)
{
	foreach(var_03, var_02 in level.var_BD43)
	{
		level.var_BD43[var_03] = scripts\common\utility::func_22A9(var_02,param_00);
	}

	foreach(var_05, var_02 in level.var_BD46)
	{
		level.var_BD46[var_05] = scripts\common\utility::func_22A9(var_02,param_00);
	}
}

//Function Number: 107
func_53BB()
{
	if(level.var_C1F0 >= 3)
	{
		level thread func_50B5();
	}
}

//Function Number: 108
func_50B5()
{
	level endon("game_ended");
	if(scripts\common\utility::istrue(level.processing_ghost_wave_failing))
	{
		return;
	}

	level.processing_ghost_wave_failing = 1;
	level.var_8286 = 0;
	foreach(var_01 in level.players)
	{
		var_01 thread scripts\cp\_vo::try_to_play_vo("quest_acrcade_play_fail","zmb_comment_vo","highest",3,0,0,1);
	}

	scripts\cp\zombies\zombie_analytics::func_AF83(level.var_8287,level.var_8286,gettime() - level.var_8288 / 1000);
	if(isdefined(level.ghost_n_skull_reactivate_func))
	{
		level thread [[ level.ghost_n_skull_reactivate_func ]]();
	}

	func_50B4(2);
}

//Function Number: 109
func_1162C(param_00)
{
	var_01 = scripts\common\utility::getstructarray("ghost_wave_player_start","targetname");
	var_02 = var_01[param_00 getentitynumber()];
	param_00 setorigin(var_02.origin);
	param_00 setplayerangles(var_02.angles);
}

//Function Number: 110
func_11631(param_00)
{
	var_01 = scripts\common\utility::getstructarray("ghost_wave_player_end","targetname");
	var_02 = var_01[param_00 getentitynumber()];
	param_00 setorigin(scripts\common\utility::func_5D14(var_02.origin,50,-300));
	param_00 setplayerangles(var_02.angles);
}

//Function Number: 111
func_12980(param_00)
{
	param_00 setclientomnvar("zm_ui_player_playing_ghost_arcade",1);
}

//Function Number: 112
func_12953(param_00)
{
	param_00 setclientomnvar("zm_ui_player_playing_ghost_arcade",0);
}

//Function Number: 113
func_100DF(param_00)
{
	foreach(var_02 in level.players)
	{
		if(scripts\common\utility::istrue(var_02.playing_ghosts_n_skulls))
		{
			func_12981(var_02,param_00);
		}
	}
}

//Function Number: 114
func_12981(param_00,param_01)
{
	param_00 setclientomnvar("zm_ui_show_ghost_arcade_scores",param_01);
}

//Function Number: 115
func_12954(param_00)
{
	param_00 setclientomnvar("zm_ui_show_ghost_arcade_scores",0);
}

//Function Number: 116
register_available_formation(param_00,param_01)
{
	level.available_formations[param_00] = scripts\common\utility::array_add(level.available_formations[param_00],param_01);
}

//Function Number: 117
func_DEB7(param_00,param_01)
{
	level.formation_movements[param_00] = param_01;
}

//Function Number: 118
func_79C9(param_00)
{
	return level.var_BD48[param_00].var_7329;
}

//Function Number: 119
func_5565()
{
	level.var_3869 = ::func_8275;
}

//Function Number: 120
func_6225()
{
	level.var_3869 = undefined;
}

//Function Number: 121
func_8275(param_00)
{
	return 0;
}

//Function Number: 122
func_110A2(param_00)
{
	param_00.var_D7C0 = param_00 scripts\cp\_persistence::func_7B8B();
	param_00 setplayerdata("cp","alienSession","currency",0);
	param_00 scripts\cp\_persistence::func_666A("currency",0,1);
}

//Function Number: 123
func_E2BF(param_00)
{
	param_00 setplayerdata("cp","alienSession","currency",int(param_00.var_D7C0));
	param_00 scripts\cp\_persistence::func_666A("currency",int(param_00.var_D7C0),1);
}

//Function Number: 124
func_93F2(param_00)
{
	var_01 = param_00 getplayerdata("cp","alienSession","currency");
	param_00 setplayerdata("cp","alienSession","currency",int(var_01 + 1));
	param_00 scripts\cp\_persistence::func_666A("currency",int(var_01 + 1),1);
}

//Function Number: 125
func_12846(param_00)
{
	if(param_00[1] < level.var_4B63)
	{
		return;
	}

	func_18CB();
}

//Function Number: 126
func_E1E1()
{
	level.var_4B63 = level.original_death_grid_lines_front_y_pos;
	func_F32C(level.death_trigger_reset_y_pos);
}

//Function Number: 127
func_15A4()
{
	level.var_4B63 = level.original_death_grid_lines_front_y_pos;
	func_F32C(level.death_trigger_activate_y_pos);
}

//Function Number: 128
func_18CB()
{
	var_00 = getent("ghost_death_trigger","targetname");
	var_01 = var_00.origin[1];
	var_02 = var_01 + 217;
	var_03 = level.death_trigger_activate_y_pos + 217 * get_max_num_of_death_trigger_advance();
	if(var_02 >= var_03)
	{
		level thread func_50B5();
	}

	level.var_4B63 = level.var_4B63 + 217;
	func_F32C(var_02);
}

//Function Number: 129
get_max_num_of_death_trigger_advance()
{
	if(isdefined(level.max_num_of_death_trigger_advance))
	{
		return level.max_num_of_death_trigger_advance;
	}

	return 13;
}

//Function Number: 130
func_F32C(param_00)
{
	var_01 = getent("ghost_death_trigger","targetname");
	var_02 = getent("ghost_death_grid_lines","targetname");
	var_01 dontinterpolate();
	var_02 dontinterpolate();
	var_01.origin = (var_01.origin[0],param_00,var_01.origin[2]);
	var_02.origin = (var_02.origin[0],param_00,var_02.origin[2]);
}

//Function Number: 131
func_731A(param_00)
{
	return ["R","R","R","F","L","L","L","F"];
}

//Function Number: 132
func_731B(param_00)
{
	return ["U","D","D","U","F"];
}

//Function Number: 133
func_731C(param_00)
{
	return ["R","R","R","F","L","L","L","F"];
}

//Function Number: 134
func_731D(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.var_EE79))
		{
			switch(var_02.var_EE79)
			{
				case "LU":
					return ["LU","F","RD","F"];

				case "RU":
					return ["RU","F","LD","F"];

				case "LD":
					return ["LD","F","RU","F"];

				case "RD":
					return ["RD","F","LU","F"];

				default:
					break;
			}
		}
	}
}

//Function Number: 135
func_731E(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.var_EE79))
		{
			switch(var_02.var_EE79)
			{
				case "LU":
					return ["LU","F","RD","F"];

				case "RU":
					return ["RU","F","LD","F"];

				case "LD":
					return ["LD","F","RU","F"];

				case "RD":
					return ["RD","F","LU","F"];

				default:
					break;
			}
		}
	}
}

//Function Number: 136
func_731F(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.var_EE79))
		{
			switch(var_02.var_EE79)
			{
				case "LU":
					return ["LU","F","RD","F"];

				case "RU":
					return ["RU","F","LD","F"];

				case "LD":
					return ["LD","F","RU","F"];

				case "RD":
					return ["RD","F","LU","F"];

				default:
					break;
			}
		}
	}
}

//Function Number: 137
func_7320(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.var_EE79))
		{
			switch(var_02.var_EE79)
			{
				case "L":
					return ["L","R","F"];

				case "R":
					return ["R","L","F"];

				case "U":
					return ["U","D","F"];

				default:
					break;
			}
		}
	}
}

//Function Number: 138
func_7321(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.var_EE79))
		{
			switch(var_02.var_EE79)
			{
				case "LD":
					return ["LD","RU","F"];

				case "RD":
					return ["RD","LU","F"];

				case "U":
					return ["U","D","F"];

				default:
					break;
			}
		}
	}
}

//Function Number: 139
func_7322(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.var_EE79))
		{
			switch(var_02.var_EE79)
			{
				case "L":
					return ["L","R","F"];

				case "R":
					return ["R","L","F"];

				case "D":
					return ["D","U","F"];

				default:
					break;
			}
		}
	}
}

//Function Number: 140
func_7323(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.var_EE79))
		{
			switch(var_02.var_EE79)
			{
				case "U":
					return ["U","F","D","F"];

				case "D":
					return ["D","F","U","F"];

				default:
					break;
			}
		}
	}
}

//Function Number: 141
func_7324(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.var_EE79))
		{
			switch(var_02.var_EE79)
			{
				case "U":
					return ["U","F","D","F"];

				case "D":
					return ["D","F","U","F"];

				default:
					break;
			}
		}
	}
}

//Function Number: 142
func_7325(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02.var_EE79))
		{
			switch(var_02.var_EE79)
			{
				case "L":
					return ["L","F","R","F"];

				case "R":
					return ["R","F","L","F"];

				default:
					break;
			}
		}
	}
}

//Function Number: 143
func_7326(param_00)
{
	return ["R","R","F","L","L","F"];
}

//Function Number: 144
func_7327(param_00)
{
	return ["R","R","F","L","L","F"];
}

//Function Number: 145
func_7328(param_00)
{
	return ["R","R","F","D","F","U","F","L","L","F"];
}

//Function Number: 146
give_gns_base_reward(param_00)
{
	param_00 scripts\cp\_persistence::give_player_xp(1000,1);
	param_00.have_permanent_perks = 1;
	param_00.have_gns_perk = 1;
	param_00 thread func_5FB7(param_00);
}

//Function Number: 147
func_5FB7(param_00)
{
	param_00 endon("disconnect");
	var_01 = ["perk_machine_boom","perk_machine_flash","perk_machine_fwoosh","perk_machine_more","perk_machine_rat_a_tat","perk_machine_revive","perk_machine_run","perk_machine_smack","perk_machine_tough","perk_machine_zap"];
	if(isdefined(level.all_perk_list))
	{
		var_01 = level.all_perk_list;
	}

	foreach(var_03 in var_01)
	{
		if(param_00 scripts\cp\_utility::has_zombie_perk(var_03))
		{
			continue;
		}

		wait(0.5);
		param_00 lib_0D5D::func_834E(var_03,0);
	}
}

//Function Number: 148
func_C127(param_00,param_01)
{
	level thread func_12DF8(param_00);
	if(soundexists("ghosts_quest_step_notify"))
	{
		foreach(var_03 in level.players)
		{
			var_03 playlocalsound("ghosts_quest_step_notify");
		}
	}
}

//Function Number: 149
func_12DF8(param_00,param_01)
{
	level endon("game_ended");
	if(param_00 == 6)
	{
		foreach(var_03 in level.players)
		{
			if(var_03 scripts\cp\_utility::func_9BA0("activate_gns_machine"))
			{
				var_03 notify("activate_gns_machine_timeup");
				var_03 notify("activate_gns_machine_exited_early");
			}
		}
	}

	if(isdefined(param_01))
	{
		wait(param_01);
	}

	setomnvar("zm_num_ghost_n_skull_coin",param_00);
	level.skulls_before_activation = param_00;
}

//Function Number: 150
reactivate_cabinet()
{
	setomnvar("zm_num_ghost_n_skull_coin",5);
}

//Function Number: 151
set_consumable_meter_scalar(param_00,param_01)
{
	param_00.consumable_meter_scalar = param_01;
}