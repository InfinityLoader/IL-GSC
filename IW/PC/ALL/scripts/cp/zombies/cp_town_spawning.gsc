/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\cp_town_spawning.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 81
 * Decompile Time: 3994 ms
 * Timestamp: 10/27/2023 12:08:51 AM
*******************************************************************/

//Function Number: 1
cp_town_spawning_init()
{
	if(!isdefined(level.zombie_spawn_override_func))
	{
		level.zombie_spawn_override_func = [];
	}

	level.zombie_spawn_override_func["crab_brute"] = ::spawn_brute_wave_enemy;
	level thread listen_for_tent_door_open();
	level.crab_mini_debug_spawn_func = ::dbg_spawn_goons;
}

//Function Number: 2
listen_for_tent_door_open()
{
	level endon("game_ended");
	level.tent_door_opened = 0;
	for(;;)
	{
		level waittill("volume_activated",var_00);
		if(var_00 == "drive_in_theater" || var_00 == "drive_in_elvira")
		{
			break;
		}
	}

	level.tent_door_opened = 1;
}

//Function Number: 3
update_crog_spawners()
{
	while(!scripts\common\utility::func_6E34("init_adjacent_volumes_done"))
	{
		wait(0.1);
	}

	scripts\common\utility::flag_wait("init_adjacent_volumes_done");
	var_00 = scripts\common\utility::getstructarray("dog_spawner","targetname");
	var_01 = ["morgue","supermarket"];
	foreach(var_03 in level.var_8457)
	{
		if(!isdefined(var_03.var_13538))
		{
			continue;
		}

		if(!isdefined(var_03.var_13538.var_28AB))
		{
			continue;
		}

		foreach(var_05 in var_01)
		{
			if(var_03.var_13538.var_28AB == var_05)
			{
				level.var_8457 = scripts\common\utility::func_22A9(level.var_8457,var_03);
				var_03.var_13538.var_8457 = scripts\common\utility::func_22A9(var_03.var_13538.var_8457,var_03);
			}
		}

		wait(0.1);
	}
}

//Function Number: 4
func_8453()
{
	level.var_10E3C = func_79EB();
	level.var_5F7F = [];
	level.var_B467 = 24;
	level.var_B432 = 0;
	level.var_5274 = func_8455();
	level.var_4B6E = 0;
	level.last_clown_spawn_time = gettime();
	func_1071B();
}

//Function Number: 5
func_8455()
{
	var_00 = level.players.size;
	var_01 = var_00 * 3;
	var_02 = 1;
	switch(level.var_1096B)
	{
		case 0:
			var_01 = var_00 * 6;
			break;

		case 1:
			var_01 = var_00 * 9;
			break;

		case 2:
			var_01 = var_00 * 12;
			break;

		case 3:
			var_01 = var_00 * 16;
			break;

		default:
			var_01 = var_00 * 16;
			break;
	}

	var_01 = var_01 * var_02;
	return var_01;
}

//Function Number: 6
func_1071B()
{
	level endon("force_spawn_wave_done");
	level endon("game_ended");
	level.var_E299 = 0;
	level.var_C1E8 = 0;
	level.var_4BB5 = 0;
	level.var_10725 = [];
	var_00 = 0;
	while(level.var_4B6E < level.var_5274)
	{
		while(scripts\common\utility::istrue(level.var_13FA3) || scripts\common\utility::istrue(level.nuke_zombies_paused))
		{
			scripts\common\utility::func_136F7();
		}

		var_01 = func_C1E9();
		var_02 = get_spawner_and_spawn_goons(var_01);
		var_00 = var_00 + var_02;
		if(var_02 > 0)
		{
			wait(func_8454(var_00,level.var_5274));
			continue;
		}

		wait(0.1);
	}

	level.var_B467 = 0;
	level.var_B432 = 0;
	level.var_11046 = 1;
}

//Function Number: 7
brute_goon_summon()
{
	level endon("force_spawn_wave_done");
	level endon("game_ended");
	var_00 = get_num_guys_to_brute_spawn();
	var_00 = min(self.var_108FB.size,var_00);
	scripts\cp\zombies\zombies_spawning::func_93EB(var_00);
	wait(1);
	brute_goon_spawn_loop(var_00);
	scripts\cp\zombies\zombies_spawning::func_4FB8(var_00);
}

//Function Number: 8
get_num_guys_to_brute_spawn()
{
	var_00 = func_C1E9();
	var_01 = getdvar("crab_brute_action","none");
	if(var_01 == "summon")
	{
		var_00 = 2;
	}

	var_00 = min(var_00,level.players.size + 1);
	if(var_00 <= 0)
	{
		var_02 = 0;
		foreach(var_04 in level.spawned_enemies)
		{
			if(isdefined(var_04.agent_type) && var_04.agent_type == "generic_zombie")
			{
				var_02++;
			}
		}

		if(var_02 < 2)
		{
			var_02 = 0;
		}

		var_00 = min(2,var_02);
	}

	return var_00;
}

//Function Number: 9
brute_goon_spawn_loop(param_00)
{
	for(var_01 = 0;var_01 < param_00;var_01++)
	{
		var_02 = get_spawner_and_spawn_goons(1);
		wait(0.1);
	}
}

//Function Number: 10
func_5CF7(param_00,param_01,param_02)
{
	if(isdefined(level.var_726C))
	{
		level thread scripts\cp\zombies\_powerups::drop_loot(param_01,param_02,level.var_726C);
		level.var_726C = undefined;
		return 1;
	}

	if(level.var_106E2 == 1)
	{
		if(level.var_5274 == level.var_4B6E)
		{
			level thread scripts\cp\zombies\_powerups::drop_loot(param_01,param_02,"ammo_max");
			return 1;
		}

		return 0;
	}

	return 0;
}

//Function Number: 11
func_79EB()
{
	return ["crab_mini"];
}

//Function Number: 12
func_8454(param_00,param_01)
{
	var_02 = 1.5;
	switch(level.var_1096B)
	{
		case 0:
			var_02 = 3;
			break;

		case 1:
			var_02 = 2;
			break;

		case 2:
			var_02 = 1.5;
			break;

		case 3:
			var_02 = 1;
			break;

		default:
			var_02 = 1;
			break;
	}

	var_02 = var_02 - param_00 / param_01;
	var_02 = max(var_02,0.05);
	return var_02;
}

//Function Number: 13
get_spawner_and_spawn_goons(param_00)
{
	var_01 = 0;
	if(param_00 <= 0)
	{
		if(param_00 < 0)
		{
			scripts\cp\zombies\zombies_spawning::func_A5FA(abs(param_00));
		}

		return 0;
	}

	if(isdefined(level.respawn_data))
	{
		if(level.respawn_data.type == "crab_mini")
		{
			param_00 = 1;
		}
	}

	var_02 = min(param_00,1);
	spawn_goons_from_eggs(var_02);
	return var_02;
}

//Function Number: 14
spawn_goons_from_eggs(param_00)
{
	var_01 = 0.3;
	var_02 = 0.7;
	if(param_00 > 0)
	{
		scripts\cp\zombies\zombies_spawning::func_93E6(param_00);
		var_03 = [];
		var_04 = 0;
		while(var_04 < param_00)
		{
			var_05 = scripts\cp\zombies\zombies_spawning::func_7C2E();
			var_05.var_93A8 = 1;
			var_05.var_A9F6 = gettime();
			var_06 = func_10719(var_05);
			if(isdefined(var_06))
			{
				var_04++;
				wait(randomfloatrange(var_01,var_02));
			}

			var_05.var_93A8 = 0;
		}
	}
}

//Function Number: 15
dbg_spawn_goons(param_00,param_01)
{
	var_02 = 0.3;
	var_03 = 0.7;
	var_04 = 1;
	if(var_04 > 0)
	{
		scripts\cp\zombies\zombies_spawning::func_93E6(var_04);
		var_05 = [];
		var_06 = 0;
		while(var_06 < var_04)
		{
			var_07 = undefined;
			var_08 = level.var_8457;
			var_07 = scripts\cp\zombies\zombies_spawning::func_8456(var_08);
			var_08 = sortbydistance(var_08,param_00);
			var_09 = 0;
			var_0A = cos(70);
			var_0B = 500;
			var_0C = var_0B * var_0B;
			while(var_09 < var_08.size)
			{
				if(distancesquared(param_00,var_08[var_09].origin) > var_0C)
				{
					break;
				}

				if(!scripts\common\utility::func_13D90(param_00,param_01,var_08[var_09].origin,var_0A))
				{
					var_09++;
					continue;
				}

				var_07 = var_08[var_09];
				break;
				wait(0.1);
			}

			if(!isdefined(var_07))
			{
				return;
			}

			var_07.var_13538 scripts\cp\zombies\zombies_spawning::func_B291();
			level thread scripts\cp\_utility::drawsphere(var_07.origin,20,3,(0,1,0));
			var_07.var_93A8 = 1;
			var_07.var_A9F6 = gettime();
			var_0D = func_10719(var_07);
			if(isdefined(var_0D))
			{
				var_06++;
				wait(randomfloatrange(var_02,var_03));
			}

			var_07.var_93A8 = 0;
		}
	}
}

//Function Number: 16
func_1B99(param_00)
{
	var_01 = level._effect["goon_spawn_bolt"];
	playfx(var_01,param_00.origin);
	playfx(level._effect["drone_ground_spawn"],param_00.origin,(0,0,1));
	playrumbleonposition("grenade_rumble",param_00.origin);
	earthquake(0.3,0.2,param_00.origin,500);
}

//Function Number: 17
func_BC94(param_00)
{
	var_01 = getclosestpointonnavmesh(param_00.origin);
	self dontinterpolate();
	self setorigin(param_00.origin,1);
	self method_8286(param_00.origin);
	self.var_180 = 0;
}

//Function Number: 18
func_772C(param_00,param_01)
{
	var_02 = 50;
	var_03 = 50;
	var_04 = spawnstruct();
	var_04.angles = param_01;
	var_05 = var_04.origin;
	var_06 = 0;
	while(!var_06)
	{
		var_07 = randomintrange(var_02 * -1,var_02);
		var_08 = randomintrange(var_03 * -1,var_03);
		var_05 = getclosestpointonnavmesh((param_00[0] + var_07,param_00[1] + var_08,param_00[2]));
		var_06 = 1;
		foreach(var_0A in level.players)
		{
			if(positionwouldtelefrag(var_05))
			{
				var_06 = 0;
			}
		}

		if(!var_06)
		{
			wait(0.1);
		}
	}

	var_04.origin = var_05 + (0,0,5);
	return var_04;
}

//Function Number: 19
func_10719(param_00)
{
	var_01 = param_00.origin;
	var_02 = param_00.angles;
	var_03 = get_fake_crab_boss_spawner();
	if(isdefined(level.crab_boss))
	{
		var_04 = level.agenttunedata["crab_boss"].egg_sack_launching_tags;
		var_05 = scripts\common\utility::array_randomize(var_04);
		var_06 = randomint(var_05.size);
		var_07 = level.crab_boss;
		var_03 = var_07 gettagorigin(var_05[var_06]);
	}

	var_08 = launch_egg_sac(var_03,var_01,7,1,var_02);
	var_09 = "crab_mini";
	if(isdefined(var_08))
	{
		update_respawn_data(var_09);
		param_00.var_A9F6 = gettime();
	}

	return var_08;
}

//Function Number: 20
get_fake_crab_boss_spawner()
{
	var_00 = [(4492,6602,-257),(3362,6854,-257),(4292,6602,-257),(3362,6654,-257)];
	var_01 = scripts\common\utility::random(var_00);
	return var_01;
}

//Function Number: 21
update_respawn_data(param_00)
{
	if(isdefined(level.respawn_data))
	{
		var_01 = -1;
		for(var_02 = 0;var_02 < level.respawn_enemy_list.size;var_02++)
		{
			if(level.respawn_enemy_list[var_02].var_92B8 == level.respawn_data.var_92B8 && level.respawn_data.type == param_00)
			{
				var_01 = var_02;
				break;
			}
		}

		if(var_01 > -1)
		{
			if(isdefined(level.respawn_data.health))
			{
				self.health = level.respawn_data.health;
			}

			level.respawn_enemy_list = scripts\cp\_utility::func_22B0(level.respawn_enemy_list,var_01);
		}

		level.respawn_data = undefined;
	}
}

//Function Number: 22
launch_egg_sac(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = "cp_town_temp_egg_sac_green";
	param_01 = getclosestpointonnavmesh(param_01);
	var_06 = spawn("script_model",param_00);
	var_06 setmodel(var_05);
	var_06 playsound("boss_crog_fire_egg_launch");
	var_06 thread scripts\cp\maps\cp_town\cp_town_crab_boss_escort::egg_sac_or_bomb_incoming_delayed(param_02);
	var_06 thread egg_sac_damage_monitor(var_06,param_03);
	var_06 thread egg_sac_fly(var_06,param_00,param_01,param_02,param_03,param_04);
	return var_06;
}

//Function Number: 23
egg_sac_damage_monitor(param_00,param_01)
{
	param_00 endon("death");
	param_00.health = 999999;
	param_00.var_6AEF = 100;
	param_00 setcandamage(1);
	for(;;)
	{
		param_00 waittill("damage",var_02,var_03);
		param_00.health = 999999;
		param_00.var_6AEF = param_00.var_6AEF - var_02;
		if(isplayer(var_03))
		{
			scripts\cp\maps\cp_town\cp_town_crab_boss_escort::show_hit_marker(param_00,var_03);
		}

		if(param_00.var_6AEF < 0)
		{
			break;
		}
	}

	if(isdefined(var_03) && isplayer(var_03))
	{
		var_03 scripts\cp\_merits::func_D9AD("mt_dlc3_eggs_killed");
		level.var_4B6E = level.var_4B6E + 1;
	}

	scripts\cp\zombies\zombies_spawning::func_4FB6(1);
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::play_damage_explosion_fx(param_00,param_01);
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::delete_egg_sac(param_00);
}

//Function Number: 24
egg_sac_fly(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 endon("death");
	var_06 = 386.09;
	scripts\common\utility::func_136F7();
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::show_flying_trail(param_00,param_04);
	var_07 = var_06 * (0,0,-1);
	var_08 = trajectorycalculateinitialvelocity(param_01,param_02,var_07,param_03);
	var_09 = param_03 * 20;
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::play_launch_muzzle_flash(param_01,var_08,param_04);
	for(var_0A = 1;var_0A <= var_09;var_0A++)
	{
		var_0B = var_0A / 20;
		var_0C = 0.5 * var_07 * var_0B * var_0B + var_08 * var_0B + param_01;
		param_00.origin = var_0C;
		scripts\common\utility::func_136F7();
	}

	scripts\common\utility::func_136F7();
	var_0D = egg_sac_landing_sequence(param_00,param_02,param_04,param_05);
	return var_0D;
}

//Function Number: 25
egg_sac_landing_sequence(param_00,param_01,param_02,param_03)
{
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::func_577E(param_01);
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::func_57B2(param_00,param_01);
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::play_landing_explosion(param_01,param_02);
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::hide_flying_trail(param_00);
	scripts\cp\maps\cp_town\cp_town_crab_boss_escort::hide_landing_marker(param_00);
	var_04 = param_00 egg_sac_spawn(param_00,param_01,param_03);
	return var_04;
}

//Function Number: 26
egg_sac_spawn(param_00,param_01,param_02)
{
	param_00 endon("death");
	playfx(level._effect["egg_sac_hatching"],param_00.origin);
	var_03 = scripts\cp\maps\cp_town\cp_town_crab_boss_escort::make_egg_sac_spawner(param_01,param_02);
	var_04 = var_03 scripts\cp\zombies\zombies_spawning::func_1081B("crab_mini",1,var_03);
	if(isdefined(var_04))
	{
		adjust_crab_mini_health(var_04);
		var_04 thread crab_mini_audio_monitor();
	}

	scripts\cp\zombies\zombies_spawning::func_4FB6(1);
	thread scripts\cp\maps\cp_town\cp_town_crab_boss_escort::delete_egg_sac(param_00);
	return var_04;
}

//Function Number: 27
adjust_crab_mini_health(param_00)
{
	param_00.health = scripts\mp\agents\crab_mini\crab_mini_agent::calculatecrabminihealth();
}

//Function Number: 28
crab_mini_audio_monitor()
{
	level endon("game_ended");
	self endon("death");
	self.var_13550 = "minion_crog_";
	thread lib_0D62::func_CE9B(self.var_13550,undefined,1);
	self.var_D4AA = 0;
	for(;;)
	{
		var_00 = scripts\common\utility::waittill_any_timeout_1(6,"attack_hit","attack_miss","attack_charge");
		switch(var_00)
		{
			case "attack_hit":
				level thread lib_0D62::func_CE9C(self,"alert",0);
				break;
	
			case "attack_miss":
				level thread lib_0D62::func_CE9C(self,"alert",0);
				break;
	
			case "attack_charge":
				level thread lib_0D62::func_CE9C(self,"alert",0);
				break;
	
			case "timeout":
				level thread lib_0D62::func_CE9C(self,"idle",0);
				break;
		}
	}
}

//Function Number: 29
func_C1E9()
{
	var_00 = scripts\cp\zombies\zombies_spawning::func_C209();
	return var_00;
}

//Function Number: 30
func_7C2E()
{
	var_00 = undefined;
	var_00 = func_79EC();
	return var_00;
}

//Function Number: 31
func_79EC()
{
	var_00 = [];
	foreach(var_02 in level.var_162C)
	{
		if(scripts\common\utility::istrue(var_02.var_19) && !scripts\common\utility::istrue(var_02.var_93A8))
		{
			var_00[var_00.size] = var_02;
		}
	}

	if(var_00.size > 0)
	{
		var_02 = func_8456(var_00);
		if(isdefined(var_02))
		{
			return var_02;
		}
	}

	return scripts\common\utility::random(var_00);
}

//Function Number: 32
func_8456(param_00)
{
	var_01 = [];
	var_02 = 2;
	var_03 = 1;
	var_04 = 5000;
	foreach(var_06 in param_00)
	{
		if(lib_0D60::func_800B(var_06.var_13538))
		{
			var_01[var_01.size] = var_06;
			var_06.var_B92F = var_02;
			continue;
		}

		if(isdefined(var_06.var_13538.var_186E))
		{
			foreach(var_08 in var_06.var_13538.var_186E)
			{
				if(lib_0D60::func_800B(var_08))
				{
					var_01[var_01.size] = var_06;
					var_06.var_B92F = var_03;
					break;
				}
			}
		}
	}

	var_0B = 562500;
	var_0C = 4000000;
	var_0D = 9000000;
	var_0E = 122500;
	var_0F = -25536;
	var_10 = -99999999;
	var_11 = undefined;
	var_12 = 15000;
	var_13 = -25536;
	var_14 = " ";
	var_15 = undefined;
	var_16 = gettime();
	var_17 = func_81F8();
	var_18 = [];
	if(!isdefined(var_17))
	{
		return undefined;
	}

	foreach(var_06 in var_01)
	{
		var_15 = "";
		var_1A = 0;
		var_1B = var_06.var_B92F * randomintrange(var_12,var_13);
		var_1C = randomint(100);
		if(isdefined(var_06.var_BF6C) && var_06.var_BF6C >= var_16)
		{
			var_1A = var_1A - 20000;
			var_15 = var_15 + " Short Cooldown";
		}

		var_1D = distancesquared(var_17.origin,var_06.origin);
		if(var_1D < var_0E)
		{
			var_1A = var_1A - -15536;
			var_15 = var_15 + " Too Close";
		}
		else if(var_1D > var_0D)
		{
			var_1A = var_1A - -15536;
			var_15 = var_15 + " Too Far";
		}
		else if(var_1D < var_0B)
		{
			if(var_1C < max(int(level.var_1096B + 1) * 10,20))
			{
				var_1A = var_1A + var_1B;
				var_15 = var_15 + " Chance Close";
			}
			else
			{
				var_1A = var_1A - var_1B;
				var_15 = var_15 + " Close";
			}
		}
		else if(var_1D > var_0C)
		{
			var_1A = var_1A - var_1B;
			var_15 = var_15 + " Far";
		}
		else
		{
			var_1A = var_1A + var_1B;
			var_15 = var_15 + " Good Spawn";
		}

		if(var_1A > var_10)
		{
			var_10 = var_1A;
			var_11 = var_06;
			var_14 = var_15;
			var_18[var_18.size] = var_06;
		}
	}

	if(!isdefined(var_11))
	{
		return undefined;
	}

	for(var_1F = var_18.size - 1;var_1F >= 0;var_1F--)
	{
		var_20 = 1;
		foreach(var_17 in level.players)
		{
			if(distancesquared(var_17.origin,var_18[var_1F].origin) < var_0F)
			{
				var_20 = 0;
				break;
			}
		}

		if(var_20)
		{
			var_11 = var_18[var_1F];
			break;
		}
	}

	var_11.var_BF6C = var_16 + var_04;
	return var_11;
}

//Function Number: 33
func_81F8()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(!isalive(var_02))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_02.var_AD2C))
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return scripts\common\utility::random(var_00);
}

//Function Number: 34
move_goon_spawner(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getclosest(param_01,param_00,500);
	var_03.origin = param_02;
}

//Function Number: 35
func_3712()
{
	var_00 = 400;
	switch(level.var_1096B)
	{
		case 1:
		case 0:
			var_00 = 400;
			break;

		case 2:
			var_00 = 900;
			break;

		case 3:
			var_00 = 1300;
			break;

		default:
			var_00 = 1600;
			break;
	}

	return var_00;
}

//Function Number: 36
func_7CE3()
{
	if(!isdefined(self.target))
	{
		return undefined;
	}

	var_00 = getentarray(self.target,"targetname");
	if(!isdefined(var_00) || var_00.size == 0)
	{
		var_00 = scripts\common\utility::getstructarray(self.target,"targetname");
	}

	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(isdefined(var_03.remove_me))
		{
			var_01[var_01.size] = var_03;
		}
	}

	if(var_01.size > 0)
	{
		var_00 = scripts\common\utility::func_22AC(var_00,var_01);
	}

	return var_00;
}

//Function Number: 37
update_origin(param_00,param_01)
{
	if(!isdefined(level.spawn_struct_list))
	{
		level.spawn_struct_list = scripts\common\utility::getstructarray("static","script_noteworthy");
	}

	foreach(var_03 in level.spawn_struct_list)
	{
		if(var_03.origin == param_00)
		{
			var_03.origin = param_01;
			break;
		}
	}
}

//Function Number: 38
remove_origin(param_00)
{
	if(!isdefined(level.spawn_struct_list))
	{
		level.spawn_struct_list = scripts\common\utility::getstructarray("static","script_noteworthy");
	}

	foreach(var_02 in level.spawn_struct_list)
	{
		if(var_02.origin == param_00)
		{
			var_02.remove_me = 1;
			break;
		}
	}
}

//Function Number: 39
update_kvp(param_00,param_01,param_02)
{
	if(!isdefined(level.spawn_struct_list))
	{
		level.spawn_struct_list = scripts\common\utility::getstructarray("static","script_noteworthy");
	}

	foreach(var_04 in level.spawn_struct_list)
	{
		if(var_04.origin == param_00)
		{
			var_04 = [[ level.kvp_update_funcs[param_01] ]](var_04,param_02);
			break;
		}
	}
}

//Function Number: 40
kvp_update_init()
{
	level.kvp_update_funcs["script_fxid"] = ::update_kvp_script_fxid;
}

//Function Number: 41
update_kvp_script_fxid(param_00,param_01)
{
	param_00.script_fxid = param_01;
	return param_00;
}

//Function Number: 42
func_77D3()
{
	if(isdefined(level.var_186E[self.var_28AB]))
	{
		var_00 = [];
		foreach(var_02 in level.var_186E[self.var_28AB])
		{
			var_00[var_00.size] = level.var_10817[var_02];
		}

		return var_00;
	}

	return [];
}

//Function Number: 43
func_7999()
{
	var_00 = getentarray(self.var_27C,"script_noteworthy");
	if(isdefined(var_00) && var_00.size != 0)
	{
		self.var_665B = var_00;
	}
}

//Function Number: 44
func_4F1E()
{
	level endon("game_ended");
	var_00 = getdvarint("scr_spawn_start_delay");
	if(var_00 > 0)
	{
		wait(var_00);
	}
}

//Function Number: 45
func_1294D()
{
	foreach(var_01 in level.var_1647)
	{
		var_01.var_19 = 0;
		var_01 notify("dont_restart_spawner");
	}

	level.var_1647 = [];
}

//Function Number: 46
func_AD62()
{
	level endon("game_ended");
	for(;;)
	{
		if(getdvarint("scr_reserve_spawning") > 0)
		{
			level.var_E1CC = getdvarint("scr_reserve_spawning");
		}

		wait(1);
	}
}

//Function Number: 47
should_spawn_skater()
{
	if(isdefined(level.no_clown_spawn))
	{
		return 0;
	}

	if(isdefined(level.respawn_data))
	{
		if(level.respawn_data.type == "crab_mini")
		{
			return 1;
		}

		return 0;
	}

	var_00 = randomint(100);
	if(var_00 < min(level.wave_num - 19,10) && level.wave_num > 20)
	{
		if(gettime() - level.last_clown_spawn_time > 15000)
		{
			level.last_clown_spawn_time = gettime();
			return 1;
		}
	}
	else
	{
		return 0;
	}

	return 0;
}

//Function Number: 48
func_726E()
{
	level notify("force_spawn_wave_done");
	wait(0.1);
	level.var_B467 = 0;
	level.var_B432 = 0;
	level.var_11046 = 1;
}

//Function Number: 49
func_5173(param_00)
{
	scripts\common\utility::waittill_any_3("death","emerge_done");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 50
func_3728(param_00)
{
	var_01 = 0;
	var_02 = level.wave_num;
	if(isdefined(level.var_8CBD) && isdefined(level.var_8CBD[param_00]))
	{
		var_01 = [[ level.var_8CBD[param_00] ]]();
	}
	else
	{
		if(isdefined(level.var_13BD6))
		{
			var_02 = level.var_13BD6;
		}

		if(scripts\common\utility::istrue(self.var_9BA7))
		{
			var_02 = var_02 + 3;
		}

		if(scripts\common\utility::istrue(self.is_skeleton))
		{
			var_02 = var_02 + 10;
		}

		if(scripts\common\utility::istrue(self.aj_karatemaster))
		{
			if(var_02 < 10)
			{
				var_02 = var_02 + 20;
			}
			else
			{
				var_02 = var_02 + 10;
			}
		}

		var_03 = 150;
		if(var_02 == 1)
		{
			var_01 = var_03;
		}
		else if(var_02 <= 9)
		{
			var_01 = var_03 + var_02 - 1 * 100;
		}
		else
		{
			var_04 = 950;
			var_05 = var_02 - 9;
			var_01 = var_04 * pow(1.1,var_05);
		}
	}

	if(isdefined(level.var_8CB3[param_00]))
	{
		var_01 = int(var_01 * level.var_8CB3[param_00]);
	}

	if(var_01 > 6100000)
	{
		var_01 = 6100000;
	}

	return int(var_01);
}

//Function Number: 51
func_F604(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(!scripts\common\utility::istrue(var_03.var_13CE5))
		{
			var_03 visionsetnakedforplayer(param_00,param_01);
		}
	}
}

//Function Number: 52
func_7848(param_00)
{
	if(isdefined(level.available_event_func))
	{
		return [[ level.available_event_func ]](param_00);
	}

	return "";
}

//Function Number: 53
func_7B1C()
{
	return level.wave_num + 1;
}

//Function Number: 54
func_7D00(param_00,param_01)
{
	if(scripts\cp\_utility::is_escape_gametype())
	{
		return 1;
	}

	return 10;
}

//Function Number: 55
func_7CA9(param_00)
{
	var_01 = ["generic_zombie"];
	return var_01;
}

//Function Number: 56
func_7ACD(param_00)
{
	if(scripts\cp\_utility::is_escape_gametype() && param_00 < 5)
	{
		var_01 = level.players.size * 6;
		var_02 = [0,0.25,0.3,0.5,0.7,0.9];
		var_03 = 1;
		var_04 = 1;
		var_03 = var_02[param_00];
		var_05 = level.players.size - 1;
		if(var_05 < 1)
		{
			var_05 = 0.5;
		}

		var_06 = 24 + var_05 * 6 * var_04 * var_03;
		return int(min(var_01,var_06));
	}

	return 24;
}

//Function Number: 57
func_7D10(param_00)
{
	if(scripts\cp\_utility::is_escape_gametype())
	{
		return 9000;
	}

	var_01 = [0,0.25,0.3,0.5,0.7,0.9];
	var_02 = 1;
	var_03 = 1;
	if(param_00 < 6)
	{
		var_02 = var_01[param_00];
	}
	else if(param_00 < 10)
	{
		var_03 = param_00 / 5;
	}
	else
	{
		var_03 = squared(param_00) * 0.03;
	}

	var_04 = level.players.size - 1;
	if(var_04 < 1)
	{
		var_04 = 0.5;
	}

	var_05 = 24 + var_04 * 6 * var_03 * var_02;
	return int(var_05);
}

//Function Number: 58
func_7CFF(param_00)
{
	return 1;
}

//Function Number: 59
func_13691()
{
	while(level.var_4B6E < level.var_5274)
	{
		wait(1);
	}

	level.var_B467 = 0;
	level.var_B432 = 0;
	level.var_11046 = 1;
}

//Function Number: 60
func_9C13(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01) || param_00.size == 0)
	{
		return 0;
	}

	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02] == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 61
func_13FA2()
{
	foreach(var_01 in level.var_10816)
	{
		if(self istouching(var_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 62
cp_disco_cleanup_main()
{
	var_00 = 0;
	level.var_BE23 = 0;
	for(;;)
	{
		scripts\common\utility::func_136F7();
		var_01 = gettime();
		if(var_01 < var_00)
		{
			continue;
		}

		if(isdefined(level.var_BE22))
		{
			var_02 = gettime() / 1000;
			var_03 = var_02 - level.var_BE22;
			if(var_03 < 0)
			{
				continue;
			}

			level.var_BE22 = undefined;
		}

		var_04 = var_01 - level.var_13BDA / 1000;
		if(level.wave_num <= 5 && var_04 < 30)
		{
			continue;
		}
		else if(level.wave_num > 5 && var_04 < 20)
		{
			continue;
		}

		var_05 = undefined;
		if(level.var_5274 - level.var_4B6E < 3)
		{
			var_05 = 1000000;
		}

		var_00 = var_00 + 3000;
		var_06 = scripts\cp\_agent_utils::func_7DB0("axis");
		foreach(var_08 in var_06)
		{
			if(level.var_BE23 >= 1)
			{
				level.var_BE23 = 0;
				scripts\common\utility::func_136F7();
			}

			if(func_380D(var_08))
			{
				var_08 func_5773(var_05);
			}
		}
	}
}

//Function Number: 63
func_380D(param_00)
{
	if(isdefined(level.zbg_active))
	{
		return 0;
	}

	if(isdefined(param_00.agent_type) && param_00.agent_type == "zombie_ghost")
	{
		return 0;
	}

	if(isdefined(param_00.var_2BF9))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.var_9CEF))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.dont_cleanup))
	{
		return 0;
	}

	if(isdefined(param_00.delay_cleanup_until) && gettime() < param_00.delay_cleanup_until)
	{
		return 0;
	}

	return 1;
}

//Function Number: 64
func_5773(param_00)
{
	if(!isalive(self))
	{
		return;
	}

	if(!func_FF1A(self))
	{
		return;
	}

	var_01 = gettime() - self.var_107F7;
	if(var_01 < 5000)
	{
		return;
	}

	if(self.agent_type == "generic_zombie" || self.agent_type == "lumberjack")
	{
		if(var_01 < -20536 && !self.entered_playspace)
		{
			return;
		}
	}

	var_02 = 1;
	var_03 = 0;
	var_04 = 1;
	if(scripts\common\utility::istrue(self.var_565C) && level.var_5274 - level.var_4B6E < 2)
	{
		var_03 = 1;
		param_00 = 250000;
		var_02 = 0;
	}
	else if(level.var_B789.size == 0)
	{
		if(isdefined(level.use_adjacent_volumes))
		{
			var_02 = scripts\cp\zombies\zombies_spawning::func_8016(1,0);
		}
		else
		{
			var_02 = scripts\cp\zombies\zombies_spawning::func_8016(0,0);
		}
	}
	else
	{
		var_02 = scripts\cp\zombies\zombies_spawning::func_8016(1,0);
		if(var_02)
		{
			var_04 = scripts\cp\zombies\zombies_spawning::func_8016(0,1);
		}
	}

	level.var_BE23++;
	if(!var_02 || !var_04)
	{
		var_05 = 10000000;
		var_06 = level.players[0];
		foreach(var_08 in level.players)
		{
			var_09 = distancesquared(self.origin,var_08.origin);
			if(var_09 < var_05)
			{
				var_05 = var_09;
				var_06 = var_08;
			}
		}

		if(isdefined(param_00))
		{
			var_0B = param_00;
		}
		else if(isdefined(var_07) && scripts\cp\zombies\zombies_spawning::func_CF4C(var_07))
		{
			var_0B = 189225;
		}
		else
		{
			var_0B = 250000;
		}

		if(var_05 >= var_0B)
		{
			if(!var_04)
			{
				if(level.last_mini_zone_fail + 1000 > gettime())
				{
					return;
				}
				else
				{
					level.last_mini_zone_fail = gettime();
				}
			}

			thread func_51A5(var_05,var_03);
		}
	}
}

//Function Number: 65
func_FF1A(param_00)
{
	if(!isdefined(param_00.agent_type))
	{
		return 0;
	}

	if(isdefined(param_00.var_EF64))
	{
		return 0;
	}

	switch(param_00.agent_type)
	{
		case "superslasher":
		case "slasher":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 66
func_51A5(param_00,param_01)
{
	if(scripts\common\utility::istrue(self.var_93A7))
	{
		return;
	}

	if(param_01)
	{
		if(scripts\common\utility::istrue(self.var_9D25))
		{
			func_EDF6();
		}
		else
		{
		}

		return;
	}

	foreach(var_03 in level.players)
	{
		if(scripts\common\utility::istrue(var_03.var_1097A))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_03.var_9BE1))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_03.in_afterlife_arcade))
		{
			continue;
		}

		if(scripts\cp\zombies\zombies_spawning::func_CFB2(var_03))
		{
			if(param_00 < 4000000)
			{
				return;
			}
		}
	}

	self.var_54CB = 1;
	if(scripts\common\utility::istrue(self.var_B36D) && isdefined(level.var_C20A))
	{
		level.var_C20A--;
	}

	if(scripts\common\utility::istrue(self.var_9D25))
	{
		self.nocorpse = 1;
		func_EDF6();
	}
}

//Function Number: 67
func_EDF6()
{
	self dodamage(self.health + 950,self.origin,self,self,"MOD_SUICIDE");
}

//Function Number: 68
waitforvalidwavepause()
{
	while(level.var_4B6E == level.var_5274)
	{
		wait(0.05);
	}
}

//Function Number: 69
unsetzombiemovespeed()
{
	level notify("unsetZombieMoveSpeed");
}

//Function Number: 70
setzombiemovespeed(param_00)
{
	level endon("game_ended");
	level notify("unsetZombieMoveSpeed");
	level endon("unsetZombieMoveSpeed");
	foreach(var_02 in scripts\cp\_agent_utils::func_7DB0("axis"))
	{
		if(isdefined(var_02.agent_type) && var_02.agent_type != "ratking")
		{
			var_03 = scripts\common\utility::random(param_00);
			var_02 thread func_1887(var_02,0,var_03);
		}
	}

	for(;;)
	{
		level waittill("agent_spawned",var_05);
		var_03 = scripts\common\utility::random(param_00);
		var_05 thread func_1887(var_05,1,var_03);
	}
}

//Function Number: 71
func_1887(param_00,param_01,param_02)
{
	param_00 endon("death");
	if(isdefined(param_00.agent_type) && param_00.agent_type == "crab_brute")
	{
		return;
	}

	if(scripts\common\utility::istrue(param_00.var_9CDD))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01))
	{
		wait(0.5);
	}

	param_00 lib_0A1B::func_2968(param_02);
}

//Function Number: 72
disablespawnvolumes(param_00,param_01)
{
	level.copy_active_spawn_volumes = level.var_1646;
	var_02 = undefined;
	var_03 = scripts\cp\_agent_utils::func_7DB0("axis");
	foreach(var_05 in level.copy_active_spawn_volumes)
	{
		if(function_010F(param_00,var_05))
		{
			var_02 = var_05;
			foreach(var_07 in var_03)
			{
				var_07 thread sendzombietopos(var_07,param_00);
			}

			break;
		}
	}

	foreach(var_0B in level.copy_active_spawn_volumes)
	{
		if(!scripts\common\utility::istrue(param_01))
		{
			if(isdefined(var_02) && var_0B == var_02)
			{
				continue;
			}
		}

		var_0B scripts\cp\zombies\zombies_spawning::func_B292();
	}
}

//Function Number: 73
restorespawnvolumes()
{
	level notify("spawn_volumes_restored");
	foreach(var_01 in level.copy_active_spawn_volumes)
	{
		var_01 scripts\cp\zombies\zombies_spawning::func_B291();
	}

	level.copy_active_spawn_volumes = undefined;
}

//Function Number: 74
sendzombietopos(param_00,param_01)
{
	level endon("spawn_volumes_restored");
	param_00 endon("death");
	var_02 = 250000;
	param_00.var_EF64 = 1;
	param_00.var_180 = 1;
	param_00 method_82EF(param_01);
	for(;;)
	{
		if(distance(param_00.origin,param_01) < var_02)
		{
			break;
		}

		wait(0.5);
	}

	param_00.var_EF64 = 0;
	param_00.var_180 = 0;
}

//Function Number: 75
wave_complete_vo(param_00)
{
	if(!isdefined(level.var_4481))
	{
		level.var_4481 = [];
	}

	if(level.players.size < 2)
	{
		if(level.players[0].var_134FD == "p5_")
		{
			if(randomint(100) > 90)
			{
				level.players[0] thread scripts\cp\_vo::try_to_play_vo("ww_p5_taunt","rave_ww_vo");
			}
		}
	}

	if(param_00 >= 10 && param_00 <= 16)
	{
		if(randomint(100) > 60)
		{
			var_01 = scripts\common\utility::random(level.players);
			if(isdefined(var_01.var_134FD))
			{
				switch(var_01.var_134FD)
				{
					case "p1_":
						if(!isdefined(level.var_4481["sally_end_round_10_16_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("sally_end_round_10_16_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["sally_end_round_10_16_1"] = 1;
						}
						break;

					case "p4_":
						if(!isdefined(level.var_4481["aj_end_round_10_16_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("aj_end_round_10_16_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["aj_end_round_10_16_1"] = 1;
						}
						break;

					case "p3_":
						if(!isdefined(level.var_4481["andre_end_round_10_16_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("andre_end_round_10_16_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["andre_end_round_10_16_1"] = 1;
						}
						break;

					case "p2_":
						if(!isdefined(level.var_4481["pdex_end_round_10_16_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("pdex_end_round_10_16_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["pdex_end_round_10_16_1"] = 1;
						}
						break;

					default:
						break;
				}

				return;
			}
		}
	}
}

//Function Number: 76
boss_spawn_vo()
{
	if(scripts\common\utility::flag("elvira_summoned") || isdefined(level.elvira_ai))
	{
		level thread scripts\cp\_vo::try_to_play_vo("ww_crog_spawn_elvira","rave_announcer_vo","highest",70,0,0,1);
	}

	var_00 = scripts\cp\_vo::func_7C76("ww_crog_spawn_elvira3");
	var_01 = scripts\common\utility::random(level.players);
	if(isdefined(var_01.var_134FD))
	{
		switch(var_01.var_134FD)
		{
			case "p1_":
				level thread scripts\cp\_vo::try_to_play_vo("sally_boss_first_1","rave_dialogue_vo","highest",666,0,0,0,100);
				break;

			case "p2_":
				level thread scripts\cp\_vo::try_to_play_vo("pdex_boss_first_1","rave_dialogue_vo","highest",666,0,0,0,100);
				break;

			case "p3_":
				level thread scripts\cp\_vo::try_to_play_vo("andre_boss_first_1","rave_dialogue_vo","highest",666,0,0,0,100);
				break;

			case "p4_":
				level thread scripts\cp\_vo::try_to_play_vo("aj_boss_first_1","rave_dialogue_vo","highest",666,0,0,0,100);
				break;

			default:
				break;
		}
	}
}

//Function Number: 77
cp_town_boss_spawn()
{
	level thread boss_spawn_vo();
	var_00 = undefined;
	var_01 = func_7C2E();
	if(isdefined(var_01))
	{
		var_02 = scripts\common\utility::getstruct("brute_hide_org","targetname");
		var_00 = var_02 spawn_brute_wave_enemy("crab_brute");
		if(!isdefined(var_00))
		{
			return 0;
		}

		var_01.var_93A8 = 1;
		level.var_A88E = level.wave_num;
		func_3115(var_01);
		var_00 func_BC94(var_01);
		var_01.var_93A8 = 0;
	}
	else
	{
		return 0;
	}

	level notify("boss_spawned",var_00);
	if(scripts\common\utility::flag("force_spawn_boss"))
	{
		var_00.var_72AC = 1;
	}

	var_00 thread scripts\cp\zombies\zombies_spawning::killplayersifonhead(var_00);
	return 1;
}

//Function Number: 78
spawn_brute_wave_enemy(param_00,param_01,param_02,param_03)
{
	var_04 = self.origin;
	var_05 = self.angles;
	var_06 = "axis";
	if(isdefined(param_01))
	{
		var_04 = param_01;
	}

	if(isdefined(param_02))
	{
		var_05 = param_02;
	}

	if(isdefined(param_03))
	{
		var_06 = param_03;
	}

	if(!isdefined(self.var_ECF5))
	{
		var_04 = getclosestpointonnavmesh(var_04);
		var_04 = var_04 + (0,0,5);
	}

	var_07 = scripts\cp\zombies\zombies_spawning::func_13F53(param_00,var_04,var_05,var_06,self);
	if(!isdefined(var_07))
	{
		return undefined;
	}

	if(isdefined(self.var_13538))
	{
		var_07.var_13538 = self.var_13538;
	}

	var_07.dont_cleanup = undefined;
	var_07 thread func_3114();
	var_07 thread func_310F();
	level notify("agent_spawned",var_07);
	return var_07;
}

//Function Number: 79
func_3114()
{
	level endon("game_ended");
	if(!isdefined(level.var_3120))
	{
		level.var_3120 = [];
	}

	level.var_3120 = scripts\common\utility::array_add_safe(level.var_3120,self);
	self.allowpain = 0;
	self.var_9CA2 = 1;
	scripts\cp\zombies\zombies_spawning::func_93EB(1);
	level.spawned_enemies[level.spawned_enemies.size] = self;
	thread scripts\cp\zombies\zombies_spawning::func_135A3();
	self waittill("death");
	level.var_3120 = scripts\common\utility::func_22A9(level.var_3120,self);
	scripts\cp\zombies\zombies_spawning::func_4FB8(1);
}

//Function Number: 80
func_310F()
{
	level endon("game_ended");
	self endon("death");
	self.var_13550 = "brute_crog_";
	thread lib_0D62::func_CE9B(self.var_13550);
	self.var_D4AA = 0;
	for(;;)
	{
		var_00 = scripts\common\utility::waittill_any_timeout_1(6,"attack_hit","attack_miss");
		switch(var_00)
		{
			case "attack_hit":
				level thread lib_0D62::func_CE9C(self,"attack_pounding",0);
				break;
	
			case "attack_miss":
				level thread lib_0D62::func_CE9C(self,"attack_pounding",0);
				break;
	
			case "timeout":
				level thread lib_0D62::func_CE9C(self,"idle",0);
				break;
		}
	}
}

//Function Number: 81
func_3115(param_00)
{
	var_01 = level._effect["brute_spawn_bolt"];
	thread scripts\cp\_utility::func_D52A("brute_spawn_lightning",param_00.origin);
	playfx(var_01,param_00.origin);
	playfx(level._effect["drone_ground_spawn"],param_00.origin,(0,0,1));
	playrumbleonposition("grenade_rumble",param_00.origin);
	earthquake(0.3,0.2,param_00.origin,500);
}