/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\cp_final_spawning.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 68
 * Decompile Time: 3325 ms
 * Timestamp: 10/27/2023 12:08:43 AM
*******************************************************************/

//Function Number: 1
cp_final_spawning_init()
{
	level.zombie_karatemaster_vo_prefix = "zmb_vo_karate_male_";
	if(!isdefined(level.var_8CBD))
	{
		level.var_8CBD = [];
	}

	level.var_8CBD["karatemaster"] = ::calculatekaratemasterhealth;
	level._effect["final_goon_spawn_bolt"] = loadfx("vfx/iw7/levels/cp_final/alien/vfx_alien_spawn_sm.vfx");
	level._effect["final_phantom_spawn_bolt"] = loadfx("vfx/iw7/levels/cp_final/alien/vfx_alien_spawn_lrg.vfx");
	level thread delayed_zmb_adjust();
	level thread no_shamblers();
	level thread turn_on_flood_room_trigger();
}

//Function Number: 2
no_shamblers()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("agent_spawned",var_00);
		if(var_00.agent_type == "generic_zombie")
		{
			var_00 thread delayed_set_move_mode();
		}
	}
}

//Function Number: 3
turn_on_flood_room_trigger()
{
	var_00 = getent("flood_room_tunnel_trigger","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(isplayer(var_01))
		{
			break;
		}
	}

	scripts\cp\zombies\zombies_spawning::func_15FC("flood_room");
}

//Function Number: 4
delayed_set_move_mode()
{
	self endon("death");
	wait(1);
	if(self.var_1F5 == "slow_walk")
	{
		self.var_1F5 = "walk";
	}
}

//Function Number: 5
delayed_zmb_adjust()
{
	wait(10);
	level.wait_for_music_clown_wave = 1;
}

//Function Number: 6
km_spawn_event_func()
{
	if(level.wave_num > 0 && !scripts\common\utility::flag("power_on"))
	{
		update_special_round_counter();
	}

	level.var_13F36 = ::func_5CF7;
	level.var_10E3C = func_79EB();
	level.var_5F7F = [];
	level.var_B467 = 24;
	level.var_B432 = 0;
	level.var_5274 = func_8455();
	level.var_4B6E = 0;
	level.last_clown_spawn_time = gettime();
	if(isdefined(level.specialwavescompleted))
	{
		level.specialwavescompleted++;
	}

	var_00 = "karatemaster";
	func_1071B(var_00);
}

//Function Number: 7
start_goon_spawn_event_func()
{
	if(level.wave_num > 0 && !scripts\common\utility::flag("power_on"))
	{
		update_special_round_counter();
	}

	level.var_13F36 = ::func_5CF7;
	level.var_10E3C = func_79EB();
	level.var_5F7F = [];
	level.var_B467 = 24;
	level.var_B432 = 0;
	level.var_5274 = func_8455();
	level.var_4B6E = 0;
	level.last_clown_spawn_time = gettime();
	if(level.wave_num >= 8)
	{
		var_00 = "alien_phantom";
		var_01 = scripts\common\utility::random(level.players);
		var_02 = getrandomnavpoint(var_01.origin,256);
		var_03 = spawnstruct();
		if(isdefined(var_02))
		{
			var_03.origin = var_02;
		}
		else
		{
			var_03.origin = getclosestpointonnavmesh(var_01.origin);
		}

		var_03.angles = anglestoforward(var_01.origin - var_03.origin);
		var_04 = var_03 spawn_brute_wave_enemy(var_00);
	}

	var_00 = "alien_goon";
	func_1071B(var_00);
}

//Function Number: 8
func_8453()
{
	if(level.wave_num > 0 && !scripts\common\utility::flag("power_on"))
	{
		update_special_round_counter();
	}

	level.var_13F36 = ::func_5CF7;
	level.var_10E3C = func_79EB();
	level.var_5F7F = [];
	level.var_B467 = 24;
	level.var_B432 = 0;
	level.var_5274 = func_8455();
	level.var_4B6E = 0;
	level.last_clown_spawn_time = gettime();
	var_00 = "alien_goon";
	func_1071B(var_00);
}

//Function Number: 9
func_8455()
{
	var_00 = level.players.size;
	var_01 = var_00 * 3;
	var_02 = 1;
	if(!scripts\common\utility::flag("power_on"))
	{
		return starting_goon_spawn_total_spawns();
	}

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

//Function Number: 10
starting_goon_spawn_total_spawns()
{
	var_00 = level.players.size;
	var_01 = var_00 * 3;
	var_02 = 1;
	switch(level.wave_num)
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
			var_01 = int(max(1,level.var_1096B) * var_00 * 16);
			break;
	}

	var_01 = var_01 * var_02;
	return var_01;
}

//Function Number: 11
func_1071B(param_00)
{
	level endon("force_spawn_wave_done");
	level endon("game_ended");
	level.var_E299 = 0;
	level.var_C1E8 = 0;
	level.var_4BB5 = 0;
	level.var_10725 = [];
	var_01 = 0;
	if(level.wave_num == 1)
	{
		wait(10);
	}

	if(soundexists("mus_zombies_newwave") && level.wave_num > 0)
	{
		level thread scripts\cp\zombies\zombies_spawning::func_BDD4();
	}

	while(level.var_4B6E < level.var_5274)
	{
		while(scripts\common\utility::istrue(level.var_13FA3) || scripts\common\utility::istrue(level.nuke_zombies_paused))
		{
			scripts\common\utility::func_136F7();
		}

		var_02 = func_C1E9();
		var_03 = get_spawner_and_spawn_goons(var_02,param_00);
		var_01 = var_01 + var_03;
		if(var_03 > 0)
		{
			wait(func_8454(var_01,level.var_5274));
			continue;
		}

		wait(0.1);
	}

	if(soundexists("mus_zombies_endwave") && level.wave_num > 0)
	{
		level thread scripts\cp\zombies\zombies_spawning::func_BDD1();
	}

	level.var_B467 = 0;
	level.var_B432 = 0;
	level.var_11046 = 1;
}

//Function Number: 12
func_5CF7(param_00,param_01,param_02)
{
	if(isdefined(level.var_726C))
	{
		if(level scripts\cp\zombies\_powerups::drop_loot(param_01,param_02,level.var_726C,undefined,undefined,1))
		{
			level.var_726C = undefined;
			return 1;
		}
	}

	if(level.wave_num > 0 && !scripts\common\utility::flag("power_on"))
	{
		return 0;
	}

	if(level.var_106E2 == 1)
	{
		if(level.var_5274 == level.var_4B6E && level.wave_num > 1)
		{
			level thread scripts\cp\zombies\_powerups::drop_loot(param_01,param_02,"ammo_max",undefined,undefined,1);
			return 1;
		}

		return 0;
	}

	return 0;
}

//Function Number: 13
func_79EB()
{
	return ["alien_goon"];
}

//Function Number: 14
func_8454(param_00,param_01)
{
	var_02 = 1.5;
	var_03 = level.players.size;
	if(var_03 == 1)
	{
		if(scripts\common\utility::func_6E34("power_on") && !scripts\common\utility::flag("power_on"))
		{
			switch(level.var_1096B)
			{
				case 0:
					var_02 = 4;
					break;

				case 1:
					var_02 = 3;
					break;

				case 2:
					var_02 = 2.5;
					break;

				case 3:
					var_02 = 2;
					break;

				default:
					var_02 = 2;
					break;
			}
		}
		else
		{
			switch(level.var_1096B)
			{
				case 0:
					var_02 = 4;
					break;

				case 1:
					var_02 = 3;
					break;

				case 2:
					var_02 = 2.5;
					break;

				case 3:
					var_02 = 2;
					break;

				default:
					var_02 = 2;
					break;
			}
		}
	}
	else if(scripts\common\utility::func_6E34("power_on") && !scripts\common\utility::flag("power_on"))
	{
		switch(level.var_1096B)
		{
			case 0:
				var_02 = 2;
				break;

			case 1:
				var_02 = 1.5;
				break;

			case 2:
				var_02 = 1.25;
				break;

			case 3:
				var_02 = 1;
				break;

			default:
				var_02 = 0.5;
				break;
		}
	}
	else
	{
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
	}

	var_02 = var_02 - param_00 / param_01;
	var_02 = max(var_02,0.05);
	return var_02;
}

//Function Number: 15
choose_agent_type_and_spawn(param_00,param_01)
{
	var_02 = "alien_goon";
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}

	if(isdefined(level.respawn_data))
	{
		var_02 = level.respawn_data.type;
	}

	if(scripts\common\utility::flag("power_on"))
	{
		if(!scripts\common\utility::istrue(level.used_portal))
		{
			var_02 = "alien_goon";
		}
		else
		{
			var_02 = scripts\common\utility::random(["alien_goon","zombie_clown","karatemaster"]);
		}
	}

	if(isdefined(level.event_wave_override))
	{
		var_02 = level.event_wave_override;
	}

	var_03 = get_spawner_and_spawn_goons(param_00,var_02);
	return var_03;
}

//Function Number: 16
get_spawner_and_spawn_goons(param_00,param_01,param_02)
{
	var_03 = 0;
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
		if(level.respawn_data.type == param_01)
		{
			param_00 = 1;
		}
	}

	if(isdefined(param_02))
	{
		var_04 = min(param_00,param_02);
	}
	else
	{
		var_04 = min(param_01,1);
	}

	var_04 = spawn_goons_from_eggs(var_04,param_01);
	return var_04;
}

//Function Number: 17
spawn_goons_from_eggs(param_00,param_01)
{
	var_02 = 0.3;
	var_03 = 0.7;
	var_04 = 0;
	if(param_00 > 0)
	{
		var_05 = [];
		var_04 = 0;
		while(var_04 < param_00)
		{
			var_06 = func_7C2E();
			var_06.var_93A8 = 1;
			var_06.var_A9F6 = gettime();
			var_07 = func_10719(var_06,param_01);
			if(isdefined(var_07))
			{
				var_04++;
				wait(randomfloatrange(var_02,var_03));
				continue;
			}

			scripts\common\utility::func_136F7();
			var_06.var_93A8 = 0;
		}
	}

	return var_04;
}

//Function Number: 18
func_1B99(param_00)
{
	var_01 = level._effect["final_goon_spawn_bolt"];
	playfx(var_01,param_00.origin);
	playfx(level._effect["drone_ground_spawn"],param_00.origin,(0,0,1));
	playrumbleonposition("grenade_rumble",param_00.origin);
	earthquake(0.3,0.2,param_00.origin,500);
}

//Function Number: 19
func_BC94(param_00)
{
	var_01 = getclosestpointonnavmesh(param_00.origin);
	self dontinterpolate();
	self setorigin(param_00.origin,1);
	self method_8286(param_00.origin);
	self.var_180 = 0;
}

//Function Number: 20
func_10719(param_00,param_01)
{
	var_02 = param_00.origin;
	var_03 = param_00.angles;
	var_04 = param_01;
	func_1B99(param_00);
	var_05 = goon_spawn_func(var_04,var_02,var_03,"axis");
	if(isdefined(var_05))
	{
		var_05 thread scripts\cp\zombies\zombies_spawning::func_64E7(var_04);
		update_respawn_data(var_04);
		param_00.var_A9F6 = gettime();
	}

	return var_05;
}

//Function Number: 21
goon_spawn_func(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\mp\_mp_agent::func_108E8(param_00,param_03,param_01,param_02,undefined,param_04);
	if(!isdefined(var_05))
	{
		return undefined;
	}

	if(isdefined(var_05.spawner))
	{
		var_05.entered_playspace = 1;
	}

	var_05 method_8287(var_05.var_503C);
	var_05.maxhealth = func_3712(param_00);
	var_05.health = var_05.maxhealth;
	if(var_05.agent_type != "alien_goon" && var_05.agent_type != "alien_phantom")
	{
		if(param_00 == "karatemaster" && isdefined(level.zombie_karatemaster_vo_prefix))
		{
			var_05.var_13550 = level.zombie_karatemaster_vo_prefix;
			var_05 thread lib_0D62::func_13F10();
		}
		else if(param_00 == "zombie_clown")
		{
			var_05.var_13550 = level.var_13F18;
			var_05 thread lib_0D62::func_13F10();
		}
	}

	if(param_00 == "alien_goon" || param_00 == "alien_phantom")
	{
		var_05 thread scripts\cp\zombies\zombies_spawning::setemissive();
	}

	return var_05;
}

//Function Number: 22
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

//Function Number: 23
func_C1E9()
{
	var_00 = scripts\cp\zombies\zombies_spawning::func_C209();
	return var_00;
}

//Function Number: 24
func_7C2E()
{
	var_00 = undefined;
	var_00 = func_79EC();
	return var_00;
}

//Function Number: 25
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

//Function Number: 26
func_8456(param_00)
{
	var_01 = [];
	var_02 = 1;
	var_03 = 1;
	var_04 = 10000;
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

	var_0B = 302500;
	var_0C = 2250000;
	var_0D = 6250000;
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

//Function Number: 27
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

//Function Number: 28
move_goon_spawner(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getclosest(param_01,param_00,500);
	var_03.origin = param_02;
}

//Function Number: 29
func_3712(param_00)
{
	if(isdefined(level.var_8CBD) && isdefined(level.var_8CBD[param_00]))
	{
		var_01 = [[ level.var_8CBD[param_00] ]]();
		return var_01;
	}

	var_01 = 400;
	switch(level.var_1096B)
	{
		case 1:
		case 0:
			var_01 = 400;
			break;

		case 2:
			var_01 = 900;
			break;

		case 3:
			var_01 = 1300;
			break;

		default:
			var_01 = 1600;
			break;
	}

	return var_01;
}

//Function Number: 30
calculatestartinggoonhealth()
{
	var_00 = 400;
	if(level.wave_num > 19)
	{
		var_00 = 2000;
	}
	else if(level.wave_num > 14)
	{
		var_00 = 1600;
	}
	else if(level.wave_num > 9)
	{
		var_00 = 1300;
	}
	else if(level.wave_num > 4)
	{
		var_00 = 900;
	}

	return var_00;
}

//Function Number: 31
update_special_round_counter()
{
	if(level.wave_num > 19)
	{
		level.var_1096B = 4;
	}
	else if(level.wave_num > 14)
	{
		level.var_1096B = 3;
	}
	else if(level.wave_num > 9)
	{
		level.var_1096B = 2;
	}
	else if(level.wave_num > 4)
	{
		level.var_1096B = 1;
	}
	else
	{
		level.var_1096B = 0;
	}

	if(isdefined(level.specialwavescompleted))
	{
		level.specialwavescompleted = level.var_1096B;
	}
}

//Function Number: 32
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

//Function Number: 33
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

//Function Number: 34
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

//Function Number: 35
kvp_update_init()
{
	level.kvp_update_funcs["script_fxid"] = ::update_kvp_script_fxid;
}

//Function Number: 36
update_kvp_script_fxid(param_00,param_01)
{
	param_00.script_fxid = param_01;
	return param_00;
}

//Function Number: 37
func_FF96()
{
	if(isdefined(level.no_clown_spawn))
	{
		return 0;
	}

	if(isdefined(level.respawn_data))
	{
		if(level.respawn_data.type == "alien_goon")
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

//Function Number: 38
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

		if(scripts\common\utility::istrue(self.aj_goon))
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

//Function Number: 39
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

//Function Number: 40
func_7848(param_00)
{
	if(isdefined(level.available_event_func))
	{
		return [[ level.available_event_func ]](param_00);
	}

	return "";
}

//Function Number: 41
func_7B1C()
{
	return level.wave_num + 1;
}

//Function Number: 42
func_7ACD(param_00)
{
	return 24;
}

//Function Number: 43
func_7D10(param_00)
{
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

//Function Number: 44
func_7CFF(param_00)
{
	return 1;
}

//Function Number: 45
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

//Function Number: 46
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

//Function Number: 47
cp_final_cleanup_main()
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

//Function Number: 48
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

	if(scripts\common\utility::istrue(param_00.sent_to_portal))
	{
		return 0;
	}

	if(isdefined(param_00.delay_cleanup_until) && gettime() < param_00.delay_cleanup_until)
	{
		return 0;
	}

	return 1;
}

//Function Number: 49
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

//Function Number: 50
func_FF1A(param_00)
{
	if(!isdefined(param_00.agent_type))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.var_EF64))
	{
		return 0;
	}

	switch(param_00.agent_type)
	{
		case "alien_phantom":
		case "slasher":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 51
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

//Function Number: 52
func_EDF6()
{
	self dodamage(self.health + 950,self.origin,self,self,"MOD_SUICIDE");
}

//Function Number: 53
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

//Function Number: 54
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

//Function Number: 55
restorespawnvolumes()
{
	level notify("spawn_volumes_restored");
	foreach(var_01 in level.copy_active_spawn_volumes)
	{
		var_01 scripts\cp\zombies\zombies_spawning::func_B291();
	}

	level.copy_active_spawn_volumes = undefined;
}

//Function Number: 56
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

//Function Number: 57
special_vo_during_wave(param_00)
{
	level endon("game_ended");
	if(!isdefined(level.played_cryptidvo))
	{
		level.played_cryptidvo = 0;
	}

	if(!isdefined(level.played_powervo))
	{
		level.played_powervo = 0;
	}

	if(!isdefined(level.var_4481))
	{
		level.var_4481 = [];
	}

	wait(10);
	if(scripts\common\utility::func_6E34("neil_head_placed") && !scripts\common\utility::flag("neil_head_placed"))
	{
		if(randomint(100) > 30)
		{
			if(scripts\common\utility::istrue(level.played_cryptidvo))
			{
				return;
			}

			level.played_cryptidvo = 1;
			var_01 = scripts\common\utility::random(level.players);
			if(isdefined(var_01.var_134FD))
			{
				switch(var_01.var_134FD)
				{
					case "p1_":
						if(!isdefined(level.var_4481["conv_crypitd_sally_1_1"]))
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_crypitd_sally_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_crypitd_sally_1_1"] = 1;
						}
						break;

					case "p2_":
						if(!isdefined(level.var_4481["conv_crypitd_pdex_1_1"]))
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_crypitd_pdex_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_crypitd_pdex_1_1"] = 1;
						}
						break;

					case "p3_":
						if(!isdefined(level.var_4481["conv_crypitd_andre_1_1"]))
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_crypitd_andre_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_crypitd_andre_1_1"] = 1;
						}
						break;

					case "p4_":
						if(!isdefined(level.var_4481["conv_crypitd_aj_1_2"]))
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_crypitd_aj_1_2","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_crypitd_aj_1_2"] = 1;
						}
						break;
				}

				return;
			}

			return;
		}

		var_02 = scripts\common\utility::random(level.players);
		if(isdefined(var_02.var_134FD))
		{
			if(scripts\common\utility::istrue(level.played_powervo))
			{
				return;
			}

			level.played_powervo = 1;
			switch(var_02.var_134FD)
			{
				case "p1_":
					if(!isdefined(level.var_4481["conv_power_sally_1_1"]))
					{
						level thread scripts\cp\_vo::try_to_play_vo("conv_power_sally_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["conv_power_sally_1_1"] = 1;
					}
					break;

				case "p2_":
					if(!isdefined(level.var_4481["conv_power_pdex_1_1"]))
					{
						level thread scripts\cp\_vo::try_to_play_vo("conv_power_pdex_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["conv_power_pdex_1_1"] = 1;
					}
					break;

				case "p3_":
					if(!isdefined(level.var_4481["conv_power_andre_1_1"]))
					{
						level thread scripts\cp\_vo::try_to_play_vo("conv_power_andre_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["conv_power_andre_1_1"] = 1;
					}
					break;

				case "p4_":
					if(!isdefined(level.var_4481["conv_power_aj_1_1"]))
					{
						level thread scripts\cp\_vo::try_to_play_vo("conv_power_aj_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["conv_power_aj_1_1"] = 1;
					}
					break;
			}

			return;
		}
	}
}

//Function Number: 58
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

	if(param_00 >= 8 && param_00 <= 12)
	{
		if(randomint(100) > 60)
		{
			var_01 = scripts\common\utility::random(level.players);
			if(isdefined(var_01.var_134FD))
			{
				switch(var_01.var_134FD)
				{
					case "p1_":
						if(!isdefined(level.var_4481["conv_round_8_12_1_1"]))
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_round_8_12_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_round_8_12_1_1"] = 1;
						}
						break;

					case "p2_":
						if(!isdefined(level.var_4481["conv_round_8_12_3_1"]))
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_round_8_12_3_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_round_8_12_3_1"] = 1;
						}
						break;

					case "p3_":
						if(!isdefined(level.var_4481["conv_round_8_12_2_1"]))
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_round_8_12_2_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_round_8_12_2_1"] = 1;
						}
						break;

					case "p4_":
						if(!isdefined(level.var_4481["conv_round_8_12_4_1"]))
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_round_8_12_4_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_round_8_12_4_1"] = 1;
						}
						break;

					default:
						break;
				}

				return;
			}

			return;
		}

		return;
	}

	if(var_01 >= 10 && var_01 <= 16)
	{
		if(randomint(100) > 60)
		{
			var_02 = scripts\common\utility::random(level.players);
			if(isdefined(var_02.var_134FD))
			{
				switch(var_02.var_134FD)
				{
					case "p1_":
						if(!isdefined(level.var_4481["conv_round_16_20_1_1"]))
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_round_16_20_1_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_round_16_20_1_1"] = 1;
						}
						break;

					case "p4_":
						if(!isdefined(level.var_4481["conv_round_16_20_2_1"]))
						{
							level thread scripts\cp\_vo::try_to_play_vo("conv_round_16_20_2_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["conv_round_16_20_2_1"] = 1;
						}
						break;

					default:
						break;
				}

				return;
			}

			return;
		}
	}
}

//Function Number: 59
cp_final_boss_spawn()
{
	var_00 = undefined;
	var_01 = func_7C2E();
	if(isdefined(var_01))
	{
		var_02 = get_boss_to_spawn();
		var_00 = boss_spawn_in_box(var_01,var_02);
		if(!isdefined(var_00))
		{
			return 0;
		}

		move_boss_to_world(var_00,var_01);
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

	return 1;
}

//Function Number: 60
get_boss_to_spawn()
{
	if(isdefined(level.boss_override))
	{
		return level.boss_override;
	}

	if(!scripts\common\utility::istrue(level.used_portal))
	{
		return "alien_phantom";
	}
	else if(level.wave_num < 20)
	{
		return "alien_phantom";
	}
	else
	{
		return scripts\common\utility::random(["alien_phantom","slasher"]);
	}

	return "alien_phantom";
}

//Function Number: 61
boss_spawn_in_box(param_00,param_01)
{
	var_02 = scripts\common\utility::getstruct("brute_hide_org","targetname");
	var_03 = var_02 spawn_brute_wave_enemy(param_01);
	return var_03;
}

//Function Number: 62
move_boss_to_world(param_00,param_01)
{
	param_01.var_93A8 = 1;
	level.var_A88E = level.wave_num;
	func_3115(param_01);
	param_00 func_BC94(param_01);
	param_01.var_93A8 = 0;
}

//Function Number: 63
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
	if(param_00 == "slasher")
	{
		var_07 thread slasher_audio_monitor();
	}

	level notify("agent_spawned",var_07);
	return var_07;
}

//Function Number: 64
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
	level.spawned_enemies = scripts\common\utility::func_22A9(level.spawned_enemies,self);
	scripts\cp\zombies\zombies_spawning::func_4FB8(1);
}

//Function Number: 65
func_310F()
{
	level endon("game_ended");
	self endon("death");
	self.var_13550 = "alien_phantom_";
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

//Function Number: 66
slasher_audio_monitor()
{
	level endon("game_ended");
	self endon("death");
	self notify("stop_audio_monitors");
	if(!isdefined(level.zombie_slasher_vo_prefix))
	{
		level.zombie_slasher_vo_prefix = "zmb_vo_slasher_";
	}

	self.var_13550 = level.zombie_slasher_vo_prefix;
	thread lib_0D62::func_CE9B(self.var_13550,undefined,1);
	self.var_D4AA = 0;
	for(;;)
	{
		var_00 = scripts\common\utility::waittill_any_timeout_1(6,"attack_hit","taunt","attack_charge","attack_shoot");
		switch(var_00)
		{
			case "attack_hit":
				level thread lib_0D62::func_CE9C(self,"attack_melee",0);
				break;
	
			case "attack_shoot":
				level thread lib_0D62::func_CE9C(self,"attack_saw_blade_shoot",0);
				break;
	
			case "taunt":
				level thread lib_0D62::func_CE9C(self,"taunt",0);
				break;
	
			case "attack_charge":
				level thread lib_0D62::func_CE9C(self,"charge_grunt",0);
				break;
	
			case "timeout":
				level thread lib_0D62::func_CE9C(self,"walk_idle_grunt",0);
				break;
		}
	}
}

//Function Number: 67
func_3115(param_00)
{
	var_01 = level._effect["final_phantom_spawn_bolt"];
	thread scripts\cp\_utility::func_D52A("brute_spawn_lightning",param_00.origin);
	playfx(var_01,param_00.origin);
	playfx(level._effect["drone_ground_spawn"],param_00.origin,(0,0,1));
	playrumbleonposition("grenade_rumble",param_00.origin);
	earthquake(0.3,0.2,param_00.origin,500);
}

//Function Number: 68
calculatekaratemasterhealth()
{
	var_00 = 900;
	if(isdefined(level.var_106E2) && level.var_106E2 == 1)
	{
		var_01 = 400;
		switch(level.var_1096B)
		{
			case 0:
				var_01 = 400;
				break;

			case 1:
				var_01 = 900;
				break;

			case 2:
				var_01 = 1600;
				break;

			case 3:
				var_01 = 1900;
				break;

			default:
				var_01 = 2500;
				break;
		}

		var_00 = var_01;
	}
	else if(isdefined(level.zombie_health_func))
	{
		var_02 = [[ level.zombie_health_func ]]("generic_zombie");
		var_00 = var_02 * 3;
	}

	return var_00;
}