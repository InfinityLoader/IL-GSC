/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\zombies_spawning.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 192
 * Decompile Time: 8657 ms
 * Timestamp: 10/27/2023 12:27:21 AM
*******************************************************************/

//Function Number: 1
func_6512()
{
	func_97B9();
	func_97AE();
	func_97B8();
	level.var_5F90 = [];
	level.var_10E44 = [];
	level.var_4B95 = 0;
	level.var_4B6B = 0;
	level.var_E1CC = 0;
	level.var_50F8 = 0;
	level.var_E299 = 0;
	level.var_5274 = 0;
	level.var_4B6E = 0;
	level.var_B467 = 0;
	level.var_B432 = 0;
	level.var_5F7F = ["generic_zombie"];
	level.var_BFB7 = 200;
	level.var_1BF5 = scripts\common\utility::getstructarray("spawner_location","targetname");
	level.var_1002D = ::func_FF55;
	level.var_11046 = 1;
	level.var_B433 = 20;
	level.spawned_enemies = [];
	level.var_8CB3 = [];
	level.respawn_enemy_list = [];
	kvp_update_init();
	if(isdefined(level.patch_update_spawners))
	{
		[[ level.patch_update_spawners ]]();
	}

	func_975C();
	func_9757();
	level thread func_F8A7();
	level thread func_F5EC();
	level thread func_7D87();
	level.var_17C4 = [];
	level.var_17C4[1] = 0;
	level.var_17C4[2] = 0;
	level.var_17C4[3] = 0;
	level.var_17C4[4] = 0;
	level.var_CA07 = 0;
	level.var_CA06 = 0;
	level.var_CA05 = 0;
	level.var_4CC7 = 0;
	if(!isdefined(level.var_106DB))
	{
		level.var_106DB = [];
	}

	level.var_1646 = [];
	level.var_1647 = [];
	level.var_162C = [];
	level.var_4BB5 = 0;
	level.var_10725 = [];
	level.var_108E1 = ::func_12E29;
	level.var_13F39 = "zmb_vo_base_male_";
	level.var_13F3A = "zmb_vo_base_male2_";
	level.var_13F24 = "zmb_vo_base_female_";
	level.var_13F14 = "zmb_vo_brute_";
	level.var_13F1A = "zmb_vo_cop_";
	level.var_13F18 = "zmb_vo_clown_";
	level.last_clown_spawn_time = gettime();
	level.wait_for_music_clown_wave = 0;
	level.last_mini_zone_fail = 0;
}

//Function Number: 2
func_97B9()
{
	scripts\common\utility::flag_init("init_spawn_volumes_done");
	scripts\common\utility::flag_init("init_adjacent_volumes_done");
	scripts\common\utility::flag_init("force_spawn_boss");
	scripts\common\utility::flag_init("pause_wave_progression");
}

//Function Number: 3
func_97B8()
{
	level._effect["drone_ground_spawn"] = loadfx("vfx/old/_requests/cp_titan/vfx_alien_drone_ground_spawn_titan.vfx");
}

//Function Number: 4
func_97AE()
{
	lib_0D48::func_97AF();
}

//Function Number: 5
func_975C()
{
	level.var_10816 = getentarray("spawn_volume","targetname");
	level.var_9B0B = getentarray("invalid_playspace","targetname");
	level.active_player_respawn_locs = [];
	var_00 = [];
	foreach(var_02 in level.var_10816)
	{
		var_02.var_28AB = func_7859(var_02);
		level.var_10817[var_02.var_28AB] = var_02;
		if(!scripts\cp\_utility::is_escape_gametype())
		{
			var_02 func_7C8E();
			var_02 func_7999();
		}

		var_02.var_19 = 0;
		var_00[var_02.var_28AB] = var_02;
		wait(0.1);
	}

	level.var_10816 = var_00;
	scripts\common\utility::flag_set("init_spawn_volumes_done");
}

//Function Number: 6
func_F8A7()
{
	func_94D5();
}

//Function Number: 7
func_975D()
{
	if(!scripts\common\utility::flag("init_spawn_volumes_done"))
	{
		scripts\common\utility::flag_wait("init_spawn_volumes_done");
	}

	level.var_10818 = getentarray("spawn_volume_trigger","targetname");
	if(!isdefined(level.var_10818))
	{
		return;
	}

	foreach(var_01 in level.var_10818)
	{
		var_01 thread func_15FD();
		wait(0.1);
	}
}

//Function Number: 8
func_15FD()
{
	level endon("game_ended");
	self.var_13538 = self.script_area;
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isplayer(var_00))
		{
			continue;
		}

		break;
	}

	func_15FC(self.var_13538);
}

//Function Number: 9
func_A5BC()
{
	foreach(var_01 in level.spawned_enemies)
	{
		var_01 dodamage(var_01.health + 990,var_01.origin,var_01,var_01,"MOD_SUICIDE");
	}
}

//Function Number: 10
func_7859(param_00)
{
	var_01 = strtok(param_00.var_27C,"_");
	if(var_01.size < 2)
	{
		var_02 = var_01[0];
	}
	else if(scripts\common\utility::string_starts_with(var_02[0],"pf"))
	{
		var_02 = var_02[1];
		for(var_03 = 2;var_03 < var_01.size;var_03++)
		{
			var_02 = var_02 + "_" + var_01[var_03];
		}
	}
	else
	{
		var_02 = var_01.var_27C;
	}

	return var_02;
}

//Function Number: 11
func_9757()
{
	level.var_106E2 = 0;
	level.var_A8BC = 0;
	level.var_1096B = 0;
	level.var_13F36 = ::func_5CF7;
	init_event_waves();
	func_9605();
}

//Function Number: 12
init_event_waves()
{
	level.var_6840 = [];
	if(isdefined(level.event_funcs_init))
	{
		[[ level.event_funcs_init ]]();
		return;
	}

	level.var_6840["goon"] = ::func_8453;
	func_9608();
}

//Function Number: 13
func_B26D()
{
	if(!func_9C13(level.var_162C,self))
	{
		level.var_162C[level.var_162C.size] = self;
	}

	self.var_19 = 1;
	self.var_93A8 = 0;
}

//Function Number: 14
func_B26E()
{
	self.var_19 = 0;
}

//Function Number: 15
func_8453()
{
	level.var_10E3C = func_79EB();
	level.var_5F7F = [];
	level.var_B467 = 24;
	level.var_B432 = 0;
	level.var_5274 = func_8455();
	level.var_4B6E = 0;
	while(level.wait_for_music_clown_wave == 0)
	{
		wait(0.1);
	}

	func_1071B();
}

//Function Number: 16
func_5CF7(param_00,param_01,param_02)
{
	if(isdefined(level.var_726C))
	{
		level thread scripts\cp\zombies\_powerups::drop_loot(param_01,param_02,level.var_726C,undefined,undefined,1);
		level.var_726C = undefined;
		return 1;
	}

	if(level.var_106E2 == 1)
	{
		if(level.var_5274 == level.var_4B6E)
		{
			level thread scripts\cp\zombies\_powerups::drop_loot(param_01,param_02,"ammo_max",undefined,undefined,1);
			return 1;
		}

		return 0;
	}

	return 0;
}

//Function Number: 17
func_79EB()
{
	return ["generic_zombie"];
}

//Function Number: 18
func_79E9()
{
	return ["zombie_ghost"];
}

//Function Number: 19
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

//Function Number: 20
func_826F()
{
	var_00 = 0.5;
	return var_00;
}

//Function Number: 21
func_8455()
{
	var_00 = level.players.size;
	var_01 = var_00 * 6;
	var_02 = 2;
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
			var_01 = var_00 * 12;
			var_02 = 3;
			break;

		default:
			var_01 = var_00 * 15;
			var_02 = 3;
			break;
	}

	var_01 = var_01 * var_02;
	return var_01;
}

//Function Number: 22
func_8270()
{
	var_00 = level.players.size;
	return 8 + 4 * var_00;
}

//Function Number: 23
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

//Function Number: 24
get_spawner_and_spawn_goons(param_00)
{
	if(isdefined(level.special_zombie_spawn_func))
	{
		var_01 = [[ level.special_zombie_spawn_func ]](param_00);
		return var_01;
	}

	var_02 = 0;
	if(var_01 <= 0)
	{
		if(var_01 < 0)
		{
			func_A5FA(abs(var_01));
		}

		return 0;
	}

	var_01 = min(var_01,2);
	func_1071C(var_02);
	return var_02;
}

//Function Number: 25
func_10717()
{
	level endon("game_ended");
	level endon("stop_ghost_spawn");
	var_00 = 24;
	var_01 = func_826F();
	for(;;)
	{
		var_02 = func_7C2D();
		if(isdefined(var_02))
		{
			var_02.var_93A8 = 1;
			var_02.var_A9F6 = gettime();
			var_03 = var_00 - level.var_13F2D.size;
			level thread func_10718(var_02,var_03);
		}

		wait(var_01);
	}
}

//Function Number: 26
func_1071C(param_00)
{
	var_01 = 0.3;
	var_02 = 0.7;
	if(param_00 > 0)
	{
		func_93E6(param_00);
		var_03 = [];
		var_04 = scripts\common\utility::getstruct("brute_hide_org","targetname");
		var_05 = 0;
		while(var_05 < param_00)
		{
			var_06 = func_10719(var_04);
			if(isdefined(var_06))
			{
				var_05++;
				var_06 method_82EF(var_06.origin);
				var_06 scripts\mp\agents\_scriptedagents::func_F85E(1,"spawn_in_box");
				var_06.var_180 = 1;
				var_06.ignoreme = 1;
				var_06.var_EF64 = 1;
				var_03[var_03.size] = var_06;
			}

			wait(0.1);
		}

		var_07 = func_7C2E();
		var_07.var_93A8 = 1;
		var_07.var_A9F6 = gettime();
		thread scripts\cp\_utility::func_D52A("zombie_spawn_lightning",var_07.origin);
		for(var_08 = 0;var_08 < var_03.size;var_08++)
		{
			var_06 = var_03[var_08];
			var_09 = func_772C(var_07.origin,var_07.angles);
			var_06.spawner = var_09;
			func_1B99(var_06.spawner);
			var_06 func_BC94(var_06.spawner);
			var_06.ignoreme = 0;
			var_06.var_EF64 = 0;
			var_06 scripts\mp\agents\_scriptedagents::func_F85E(0,"spawn_in_box");
			var_09 = undefined;
			func_4FB6(1);
			wait(randomfloatrange(var_01,var_02));
		}

		var_07.var_93A8 = 0;
	}
}

//Function Number: 27
func_BC94(param_00)
{
	var_01 = getclosestpointonnavmesh(param_00.origin);
	self dontinterpolate();
	self setorigin(param_00.origin,1);
	self method_8286(param_00.origin);
	self.var_180 = 0;
}

//Function Number: 28
func_10718(param_00,param_01)
{
	level endon("game_ended");
	level endon("stop_ghost_spawn");
	var_02 = 1;
	var_03 = 1;
	var_04 = 0.3;
	var_05 = 0.7;
	var_06 = param_00.origin;
	var_07 = param_00.angles;
	var_08 = min(param_01,randomintrange(var_02,var_03 + 1));
	for(var_09 = 0;var_09 < var_08;var_09++)
	{
		func_10713(param_00);
		wait(randomfloatrange(var_04,var_05));
		param_00 = func_772C(var_06,var_07);
	}
}

//Function Number: 29
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

//Function Number: 30
func_10719(param_00)
{
	var_01 = "zombie_clown";
	var_02 = param_00 func_1068A();
	if(isdefined(var_02))
	{
		var_02.var_13550 = level.var_13F18;
		level thread lib_0D62::func_CE9C(var_02,"spawn",1);
		var_02 method_84E6(4);
		param_00.var_A9F6 = gettime();
	}

	return var_02;
}

//Function Number: 31
func_10713(param_00)
{
	if(isdefined(level.zombie_ghost_color_manager))
	{
		[[ level.zombie_ghost_color_manager ]]();
	}

	var_01 = func_13F2A("zombie_ghost","axis",param_00.origin,param_00.angles);
	if(isdefined(var_01))
	{
		level.var_13F2D[level.var_13F2D.size] = var_01;
		param_00.var_A9F6 = gettime();
	}
}

//Function Number: 32
func_E82B()
{
	self endon("death");
	for(;;)
	{
		var_00 = length(self.var_381);
		if(var_00 > 350)
		{
			iprintln("speed = " + var_00);
		}

		wait(0.25);
	}
}

//Function Number: 33
func_1B99(param_00)
{
	if(isdefined(level.clown_spawn_fx_func))
	{
		self [[ level.clown_spawn_fx_func ]](param_00);
		return;
	}

	if(function_010F(param_00.origin,level.var_10817["underground_route"]))
	{
		var_01 = level._effect["goon_spawn_bolt_underground"];
	}
	else
	{
		var_01 = level._effect["goon_spawn_bolt"];
	}

	playfx(var_01,param_00.origin);
	playfx(level._effect["drone_ground_spawn"],param_00.origin,(0,0,1));
	playrumbleonposition("grenade_rumble",param_00.origin);
	earthquake(0.3,0.2,param_00.origin,500);
}

//Function Number: 34
func_3115(param_00)
{
	if(function_010F(param_00.origin,level.var_10817["underground_route"]))
	{
		var_01 = level._effect["brute_spawn_bolt_indoor"];
	}
	else
	{
		var_01 = level._effect["brute_spawn_bolt"];
	}

	thread scripts\cp\_utility::func_D52A("brute_spawn_lightning",param_00.origin);
	playfx(var_01,param_00.origin);
	playfx(level._effect["drone_ground_spawn"],param_00.origin,(0,0,1));
	playrumbleonposition("grenade_rumble",param_00.origin);
	earthquake(0.3,0.2,param_00.origin,500);
}

//Function Number: 35
func_C1E9()
{
	var_00 = func_C209();
	return var_00;
}

//Function Number: 36
func_FF95()
{
	var_00 = func_C209();
	if(var_00 > 0)
	{
		return !level.var_C1E7 + level.var_4B6E + level.var_4B95 >= level.var_5274;
	}

	return 0;
}

//Function Number: 37
func_7C2E()
{
	var_00 = undefined;
	var_00 = func_79EC();
	return var_00;
}

//Function Number: 38
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

//Function Number: 39
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

//Function Number: 40
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

//Function Number: 41
func_7C2D()
{
	var_00 = undefined;
	var_00 = func_79EA();
	return var_00;
}

//Function Number: 42
func_79EA()
{
	var_00 = [];
	foreach(var_02 in level.var_8271)
	{
		if(scripts\common\utility::istrue(var_02.var_19))
		{
			var_00[var_00.size] = var_02;
		}
	}

	if(isdefined(level.var_13FA6) && var_00.size > 0)
	{
		return [[ level.var_13FA6 ]](var_00);
	}

	return var_00;
}

//Function Number: 43
func_9608()
{
	level.var_8457 = [];
	var_00 = scripts\common\utility::getstructarray("dog_spawner","targetname");
	if(isdefined(level.goon_spawner_patch_func))
	{
		[[ level.goon_spawner_patch_func ]](var_00);
	}

	foreach(var_02 in var_00)
	{
		var_03 = 0;
		foreach(var_05 in level.var_9B0B)
		{
			if(function_010F(var_02.origin,var_05))
			{
				var_03 = 1;
			}
		}

		if(!var_03)
		{
			foreach(var_05 in level.var_10816)
			{
				if(function_010F(var_02.origin,var_05))
				{
					if(!isdefined(var_02.angles))
					{
						var_02.angles = (0,0,0);
					}

					level.var_8457[level.var_8457.size] = var_02;
					var_02.var_13538 = var_05;
					if(!isdefined(var_05.var_8457))
					{
						var_05.var_8457 = [];
					}

					var_05.var_8457[var_05.var_8457.size] = var_02;
					break;
				}
			}
		}
	}
}

//Function Number: 44
move_goon_spawner(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getclosest(param_01,param_00,500);
	var_03.origin = param_02;
}

//Function Number: 45
func_9605()
{
	level.var_8271 = [];
	var_00 = scripts\common\utility::getstructarray("ghost_spawn","targetname");
	foreach(var_02 in var_00)
	{
		var_02.var_19 = 1;
		if(!isdefined(var_02.angles))
		{
			var_02.angles = (0,0,0);
		}

		level.var_8271[level.var_8271.size] = var_02;
	}
}

//Function Number: 46
func_1B98(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\cp\_agent_utils::func_179E("axis",param_01,param_02,"wave " + param_00);
	if(!isdefined(var_04))
	{
		return undefined;
	}

	if(scripts\common\utility::istrue(level.var_68AA))
	{
		var_04.maxhealth = func_3712();
		var_04.health = var_04.maxhealth;
		var_04.var_13550 = level.var_13F18;
	}

	if(var_04.agent_type == "elite")
	{
		var_04.maxhealth = 15000 * level.player.size;
		var_04.health = var_04.maxhealth;
		earthquake(0.3,5,var_04.origin,3000);
	}

	if(isdefined(param_03))
	{
		var_04.spawner = param_03;
	}

	return var_04;
}

//Function Number: 47
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

//Function Number: 48
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

//Function Number: 49
update_origin(param_00,param_01,param_02)
{
	if(!isdefined(level.spawn_struct_list))
	{
		level.spawn_struct_list = scripts\common\utility::getstructarray("static","script_noteworthy");
	}

	foreach(var_04 in level.spawn_struct_list)
	{
		if(var_04.origin == param_00)
		{
			var_04.origin = param_01;
			if(isdefined(param_02))
			{
				var_04.angles = param_02;
			}

			break;
		}
	}
}

//Function Number: 50
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

//Function Number: 51
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

//Function Number: 52
kvp_update_init()
{
	level.kvp_update_funcs["script_fxid"] = ::update_kvp_script_fxid;
}

//Function Number: 53
update_kvp_script_fxid(param_00,param_01)
{
	param_00.script_fxid = param_01;
	return param_00;
}

//Function Number: 54
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

//Function Number: 55
func_7C8E()
{
	var_00 = func_7CE3();
	if(isdefined(var_00) && var_00.size > 0)
	{
		self.var_1087B = var_00;
		foreach(var_02 in self.var_1087B)
		{
			var_02 func_10865(self);
		}
	}

	func_F546(self);
}

//Function Number: 56
func_7999()
{
	var_00 = getentarray(self.var_27C,"script_noteworthy");
	if(isdefined(var_00) && var_00.size != 0)
	{
		self.var_665B = var_00;
	}
}

//Function Number: 57
func_6514()
{
	level endon("game_ended");
	if(!scripts\common\utility::flag("init_spawn_volumes_done"))
	{
		scripts\common\utility::flag_wait("init_spawn_volumes_done");
	}

	while(!scripts\common\utility::istrue(level.var_9AF6))
	{
		wait(1);
	}

	if(!scripts\cp\_utility::is_escape_gametype())
	{
		wait(15);
	}
	else
	{
		wait(1);
	}

	if(!scripts\cp\_utility::is_escape_gametype())
	{
		func_15BA();
	}

	level thread func_10D2E();
}

//Function Number: 58
func_4F1E()
{
	level endon("game_ended");
	var_00 = getdvarint("scr_spawn_start_delay");
	if(var_00 > 0)
	{
		wait(var_00);
	}
}

//Function Number: 59
func_15BA()
{
	if(isdefined(level.initial_active_volumes))
	{
		foreach(var_01 in level.initial_active_volumes)
		{
			if(isdefined(level.var_10816[var_01]))
			{
				level.var_10816[var_01] func_B291();
			}
		}
	}
}

//Function Number: 60
func_10865(param_00)
{
	self.var_19 = 0;
	self.var_13538 = param_00;
	level.var_1BF5[level.var_1BF5.size] = self;
	if(!isdefined(self.script_noteworthy) || self.script_noteworthy != "static")
	{
		level.var_5F90[level.var_5F90.size] = self;
	}
	else
	{
		self.var_10E45 = 1;
		level.var_10E44[level.var_10E44.size] = self;
	}

	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}

	if(function_010F(self.origin,param_00))
	{
		self.var_93A1 = 1;
	}
	else
	{
		self.var_93A1 = 0;
	}

	if(isdefined(self.var_ECF5))
	{
		switch(self.var_ECF5)
		{
			case "spawn_ground":
				thread func_5D13();
				break;

			case "spawn_ceiling":
				thread func_B0D1();
				break;

			case "spawn_wall_low":
				self.var_1CAE = 1;
				break;
		}
	}
}

//Function Number: 61
func_5D13()
{
	var_00 = scripts\common\utility::func_5D14(self.origin,10);
	self.origin = var_00 + (0,0,1);
}

//Function Number: 62
func_B0D1()
{
	self.var_ABA7 = self.origin;
	var_00 = scripts\common\utility::func_5D14(self.origin,0);
	self.var_ABA6 = var_00;
}

//Function Number: 63
func_6714()
{
	if(!scripts\common\utility::func_6E34("init_spawn_volumes_done"))
	{
		scripts\common\utility::flag_init("init_spawn_volumes_done");
	}

	if(!scripts\common\utility::flag("init_spawn_volumes_done"))
	{
		scripts\common\utility::flag_wait("init_spawn_volumes_done");
	}

	level.var_1BF5 = [];
	level.var_671F = [];
	level.var_1647 = [];
	level.var_6727 = "escape_path_0_start";
	level.var_4B3F = level.var_6727;
	scripts\common\utility::flag_init("escape_room_triggers_spawned");
	level thread func_106D8();
	level thread func_66DA();
}

//Function Number: 64
func_106D8()
{
	var_00 = scripts\common\utility::getstructarray("escape_spawn_trigger","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = spawn("trigger_radius",var_02.origin,0,var_02.var_257,96);
		var_03.var_336 = var_02.var_336;
		var_03.script_area = var_02.script_area;
		var_03.target = var_02.target;
		wait(0.05);
	}

	var_05 = getentarray("escape_spawn_trigger","targetname");
	foreach(var_03 in var_05)
	{
		var_03 thread func_6730();
	}
}

//Function Number: 65
func_6730()
{
	self.var_E6DB = self.script_area;
	level.var_4BD4 = 0;
	if(self.var_E6DB == level.var_6727)
	{
		thread func_6731();
	}

	var_00 = scripts\common\utility::getstructarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread func_6722(self.var_E6DB);
	}
}

//Function Number: 66
func_6731(param_00)
{
	level endon(self.var_E6DB + "_done");
	level endon("game_ended");
	if(getdvarint("esc_zombies_triggertrig") == 0)
	{
		var_01 = 0;
		var_02 = 70;
		for(;;)
		{
			self waittill("trigger",var_03);
			if(!isplayer(var_03))
			{
				wait(0.1);
				var_01 = var_01 + 0.1;
				if(var_01 >= var_02)
				{
					break;
				}

				continue;
			}

			break;
		}
	}
	else
	{
		for(;;)
		{
			self waittill("trigger",var_03);
			if(!isplayer(var_03))
			{
				continue;
			}
			else
			{
				break;
			}
		}
	}

	if(isdefined(param_00) && !level.var_4BD4)
	{
		foreach(var_05 in param_00)
		{
			var_05.var_54CB = 1;
			var_05 suicide();
		}

		level.var_4BD4 = 1;
		level.var_C20B = 0;
		level notify("update_escape_timer");
		var_07 = strtok(tablelookup(level.var_6728,0,level.var_4BA8,3)," ");
		level.var_672A = int(var_07[level.players.size - 1]);
		level thread [[ level.var_672C ]]();
		level.var_4BA8++;
	}

	func_12DBF();
}

//Function Number: 67
func_12DBF()
{
	func_1294D();
	var_00 = scripts\common\utility::getstructarray(self.target,"targetname");
	foreach(var_02 in var_00)
	{
		var_02.var_19 = 1;
		level.var_1647[level.var_1647.size] = var_02;
	}
}

//Function Number: 68
func_1294D()
{
	foreach(var_01 in level.var_1647)
	{
		var_01.var_19 = 0;
		var_01 notify("dont_restart_spawner");
	}

	level.var_1647 = [];
}

//Function Number: 69
func_6722(param_00)
{
	self.var_19 = 0;
	self.var_1353B = param_00;
	level.var_1BF5[level.var_1BF5.size] = self;
	level.var_671F[level.var_671F.size] = self;
	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}
}

//Function Number: 70
func_66DA()
{
	for(;;)
	{
		level waittill("next_area_opened",var_00);
		level notify(level.var_4B3F + "_done");
		level.wave_num++;
		level.var_4B3F = var_00;
		func_1294D();
		var_01 = getentarray("escape_spawn_trigger","targetname");
		var_02 = level.spawned_enemies;
		level.var_4BD4 = 0;
		foreach(var_04 in var_01)
		{
			if(var_04.script_area == var_00)
			{
				var_04 thread func_6731(var_02);
			}
		}
	}
}

//Function Number: 71
func_66D6()
{
	self endon("death");
	var_00 = 2560000;
	for(;;)
	{
		wait(0.1);
		var_01 = 1;
		foreach(var_03 in level.players)
		{
			if(scripts\common\utility::istrue(var_03.var_1097A))
			{
				continue;
			}

			if(distancesquared(var_03.origin,self.origin) < var_00)
			{
				var_01 = 0;
			}
		}

		if(var_01)
		{
			break;
		}
	}

	wait(0.5);
	self.var_54CB = 1;
	if(scripts\common\utility::istrue(self.var_9D25))
	{
		self dodamage(self.health + 1000,self.origin);
	}
}

//Function Number: 72
func_10D2E()
{
	level thread func_E81B();
}

//Function Number: 73
func_10927()
{
	level endon("force_spawn_wave_done");
	level endon("spawn_wave_done");
	level endon("game_ended");
	var_00 = level.var_5274;
	var_01 = func_7C79();
	level.var_E299 = 0;
	if(!isdefined(level.var_2CDB))
	{
		level.var_2CDB = 50;
	}

	level.respawn_enemy_list = [];
	level.respawn_data = undefined;
	var_02 = func_C212();
	var_03 = int(var_00 / 4);
	var_04 = int(var_00 / 2);
	var_05 = 0;
	if(var_03 != var_04)
	{
		var_05 = randomintrange(var_03,var_04);
	}
	else
	{
		var_05 = var_03;
	}

	var_06 = 1;
	var_07 = int(var_00 / 8);
	var_08 = int(var_00 / 4);
	if(var_07 != var_08)
	{
		var_06 = randomintrange(var_07,var_08);
	}
	else
	{
		var_06 = var_07;
	}

	var_06 = var_05 - var_06;
	while(level.var_4B6E < level.var_5274)
	{
		while(scripts\common\utility::istrue(level.var_13FA3) || scripts\common\utility::istrue(level.nuke_zombies_paused))
		{
			scripts\common\utility::func_136F7();
		}

		var_09 = func_C209();
		if(var_09 <= 0)
		{
			if(var_09 < 0)
			{
				func_A5FA(abs(var_09));
			}

			wait(0.1);
			continue;
		}

		var_0A = undefined;
		if(!isdefined(level.respawn_data) && level.respawn_enemy_list.size > 0)
		{
			level.respawn_data = level.respawn_enemy_list[0];
		}

		if((var_02 && var_05 < 1) || scripts\common\utility::flag("force_spawn_boss"))
		{
			var_0A = func_2CFC();
			if(isdefined(var_0A))
			{
				if(scripts\common\utility::flag("force_spawn_boss"))
				{
					scripts\common\utility::func_6E2A("force_spawn_boss");
				}

				if(var_02 >= 1)
				{
					var_02--;
				}
			}
		}
		else if(should_spawn_clown() && var_05 < var_06)
		{
			var_0A = get_spawner_and_spawn_goons(var_09);
		}
		else if(respawning_special_zombie())
		{
			var_0A = get_spawner_and_spawn_goons(var_09);
		}
		else
		{
			if(var_05)
			{
				var_05--;
			}

			var_0A = func_10822();
		}

		if(isdefined(var_0A))
		{
			if(level.var_E299 > 0)
			{
				level.var_E299 = int(level.var_E299 - var_0A);
				wait(0.1);
				continue;
			}
		}

		var_01 = func_7C79();
		wait(var_01);
	}

	level.respawn_enemy_list = [];
	level.respawn_data = undefined;
}

//Function Number: 74
respawning_special_zombie()
{
	if(getdvar("ui_mapname") != "cp_final")
	{
		return 0;
	}

	if(isdefined(level.respawn_data))
	{
		var_00 = level.respawn_data.type;
		switch(var_00)
		{
			case "zombie_clown":
			case "karatemaster":
			case "alien_goon":
				return 1;
		}

		return 0;
	}

	return 0;
}

//Function Number: 75
func_10822()
{
	var_00 = func_7C2F();
	if(isdefined(var_00))
	{
		if(!scripts\common\utility::istrue(var_00.var_19))
		{
			return 0;
		}

		var_00.var_93A8 = 1;
		var_01 = func_FF98(var_00);
		if(isdefined(var_01))
		{
			var_02 = var_01;
		}
		else if(!isdefined(level.var_10E3C))
		{
			var_02 = "generic_zombie";
		}
		else
		{
			var_02 = scripts\common\utility::random(level.var_10E3C);
		}

		if(isdefined(level.respawn_data))
		{
			var_02 = level.respawn_data.type;
		}

		var_03 = var_00 func_1081B(var_02,1);
		if(isdefined(var_03))
		{
			var_03 lib_0D48::func_668D(var_03);
			var_03 lib_0D5E::func_6690(var_03);
			var_00.var_A9F6 = gettime();
			var_00 thread func_1296E(0.25);
		}
		else
		{
			return 0;
		}
	}
	else
	{
		return 0;
	}

	return 1;
}

//Function Number: 76
func_2CFC()
{
	if(isdefined(level.boss_spawn_func))
	{
		return [[ level.boss_spawn_func ]]();
	}

	var_00 = undefined;
	var_01 = func_7C2E();
	if(isdefined(var_01))
	{
		var_02 = scripts\common\utility::getstruct("brute_hide_org","targetname");
		var_00 = var_02 func_1081B("zombie_brute",1);
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
	level thread func_CCBB();
	if(scripts\common\utility::flag("force_spawn_boss"))
	{
		var_00.var_72AC = 1;
	}

	var_00 thread killplayersifonhead(var_00);
	return 1;
}

//Function Number: 77
killplayersifonhead(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	var_01 = scripts\common\trace::func_48B1();
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			if(distance2dsquared(var_03.origin,param_00.origin) <= 1024)
			{
				if(!var_03 isonground() && var_03.origin[2] > param_00.origin[2])
				{
					var_04 = scripts\common\trace::func_3A09(param_00 gettagorigin("tag_eye"),param_00 gettagorigin("tag_eye") + (0,0,56),32,64,undefined,param_00);
					if(isdefined(var_04["entity"]) && isplayer(var_04["entity"]) && !var_04["entity"] isonground())
					{
						var_04["entity"] dodamage(10000,param_00.origin,var_04["entity"],var_04["entity"],"MOD_UNKNOWN","frag_grenade_zm");
					}
				}
			}
		}

		wait(0.2);
	}
}

//Function Number: 78
func_CCBB()
{
	if(level.var_311A == 1)
	{
		foreach(var_01 in level.players)
		{
			var_01 thread scripts\cp\_vo::try_to_play_vo("brute_generic","zmb_comment_vo","highest",20,0,0,1);
		}

		wait(6);
		level thread scripts\cp\_vo::try_to_play_vo("ww_brute_spawn","zmb_ww_vo","highest",20,0,0,1);
		return;
	}

	level.var_311A = 1;
	foreach(var_01 in level.players)
	{
		var_01 thread scripts\cp\_vo::try_to_play_vo("brute_first","zmb_comment_vo","highest",20,0,0,1);
	}

	wait(6);
	level thread scripts\cp\_vo::try_to_play_vo("ww_brute_firstspawn","zmb_ww_vo","highest",20,0,0,1);
}

//Function Number: 79
func_C212()
{
	if(getdvar("ui_mapname") == "cp_rave" || getdvar("ui_mapname") == "cp_disco")
	{
		return 0;
	}

	var_00 = 10;
	var_01 = 19;
	if(!isdefined(level.var_A88E))
	{
		level.var_A88E = 0;
	}

	if(!isdefined(level.var_3120))
	{
		level.var_3120 = [];
	}

	var_02 = 0;
	var_03 = getdvarint("scr_force_boss_spawn",0);
	if(var_03 != 0)
	{
		if(level.wave_num > var_01)
		{
			var_02 = 2;
		}
		else
		{
			var_02 = 1;
		}

		if(level.var_3120.size < var_02)
		{
			return var_02 - level.var_3120.size;
		}
	}

	if(level.wave_num < var_00)
	{
		return 0;
	}

	if(scripts\common\utility::flag("pause_wave_progression"))
	{
		return 0;
	}

	if(level.var_A88E + 3 < level.wave_num)
	{
		if(randomint(100) < level.var_2CDB)
		{
			level.var_2CDB = 50;
			if(level.wave_num > var_01)
			{
				var_02 = 2;
			}
			else
			{
				var_02 = 1;
			}

			if(level.var_3120.size < var_02)
			{
				return var_02 - level.var_3120.size;
			}
		}
		else
		{
			level.var_2CDB = level.var_2CDB + 50;
			return 0;
		}
	}

	return 0;
}

//Function Number: 80
should_spawn_clown()
{
	if(isdefined(level.should_spawn_special_zombie_func))
	{
		var_00 = [[ level.should_spawn_special_zombie_func ]]();
		return scripts\common\utility::istrue(var_00);
	}

	if(isdefined(level.no_clown_spawn))
	{
		return 0;
	}

	if(isdefined(level.respawn_data))
	{
		if(level.respawn_data.type == "zombie_clown")
		{
			return 1;
		}

		return 0;
	}

	var_01 = randomint(100);
	if(var_01 < min(level.wave_num - 19,10) && level.wave_num > 20)
	{
		if(gettime() - level.last_clown_spawn_time > 15000)
		{
			level.last_clown_spawn_time = gettime();
			return 1;
		}
	}

	return 0;
}

//Function Number: 81
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

//Function Number: 82
func_A5FA(param_00,param_01)
{
	var_02 = cos(70);
	var_03 = 0;
	foreach(var_05 in level.spawned_enemies)
	{
		if(isdefined(var_05.var_594C))
		{
			continue;
		}

		var_06 = 0;
		foreach(var_08 in level.players)
		{
			var_06 = scripts\common\utility::func_13D90(var_08.origin,var_08.angles,var_05.origin,var_02);
			if(var_06)
			{
				break;
			}
		}

		if(!var_06)
		{
			var_05.var_54CB = 1;
			var_05 dodamage(var_05.health + 980,var_05.origin,var_05,var_05,"MOD_SUICIDE");
			var_03++;
			if(param_00 <= var_03)
			{
				return;
			}
		}

		wait(0.1);
	}

	if(param_00 > var_03)
	{
		var_0B = scripts\common\utility::array_randomize(level.spawned_enemies);
		foreach(var_05 in var_0B)
		{
			if(isdefined(var_05.var_594C))
			{
				continue;
			}

			var_05.var_54CB = 1;
			var_05 dodamage(var_05.health + 970,var_05.origin,var_05,var_05,"MOD_SUICIDE");
			var_03++;
			if(param_00 <= var_03)
			{
				return;
			}
		}
	}
}

//Function Number: 83
func_726E()
{
	level notify("force_spawn_wave_done");
	wait(0.1);
	level.var_B467 = 0;
	level.var_B432 = 0;
	level.var_11046 = 1;
}

//Function Number: 84
func_172A(param_00)
{
	var_01 = (0,0,0);
	var_02 = (0,0,0);
	var_03 = param_00 gettagorigin("j_spine4");
	var_04 = spawn("script_model",var_03);
	var_04 setmodel("zombies_backpack");
	var_04.angles = param_00.angles;
	var_04 linkto(param_00,var_03,var_01,var_02);
	param_00.var_8B9B = 1;
}

//Function Number: 85
func_C209()
{
	var_00 = 100;
	var_01 = level.var_B467 - level.var_4B95 - level.var_E1CC - level.var_50F8;
	if(var_01 < var_00)
	{
		var_00 = var_01;
	}

	if(scripts\cp\_utility::is_escape_gametype())
	{
		return var_00;
	}

	var_01 = level.var_5274 - level.var_4B95 - level.var_4B6E - level.var_50F8;
	if(var_01 < var_00)
	{
		var_00 = var_01;
	}

	return var_00;
}

//Function Number: 86
func_1296E(param_00)
{
	self endon("dont_restart_spawner");
	self.var_19 = 0;
	wait(param_00);
	self.var_19 = 1;
}

//Function Number: 87
func_7C79()
{
	if(scripts\cp\_utility::is_escape_gametype())
	{
		var_00 = level.players.size;
		return 1 / var_00;
	}

	var_01 = 2;
	if(level.wave_num == 1)
	{
		return var_01;
	}

	var_02 = var_01 * pow(0.95,level.wave_num - 1);
	if(isdefined(level.var_10847))
	{
		var_02 = level.var_10847;
	}

	if(var_02 < 0.08)
	{
		var_02 = 0.08;
	}

	return var_02;
}

//Function Number: 88
func_1068A(param_00,param_01)
{
	var_02 = "zombie_clown";
	var_03 = self.origin;
	var_04 = self.angles;
	if(isdefined(param_00))
	{
		var_03 = param_00.origin;
		var_04 = param_00.angles;
	}
	else if(isdefined(param_01))
	{
		var_03 = param_01;
	}

	var_05 = func_13F53(var_02,var_03,var_04,"axis",self);
	if(!isdefined(var_05))
	{
		return undefined;
	}

	if(isdefined(self.var_13538))
	{
		var_05.var_13538 = self.var_13538;
	}

	if(scripts\common\utility::istrue(self.var_9B95))
	{
		var_05 thread func_42EC(var_02);
	}
	else
	{
		var_05 thread func_64E7(var_02);
	}

	level notify("agent_spawned",var_05);
	return var_05;
}

//Function Number: 89
func_1081B(param_00,param_01,param_02,param_03)
{
	var_04 = self.origin;
	var_05 = self.angles;
	if(isdefined(param_02))
	{
		var_04 = param_02.origin;
		var_05 = param_02.angles;
	}
	else if(isdefined(param_03))
	{
		var_04 = param_03;
	}

	if(!isdefined(self.var_ECF5))
	{
		var_04 = getclosestpointonnavmesh(var_04);
		var_04 = var_04 + (0,0,5);
	}

	if(level.agent_definition[param_00]["species"] == "alien")
	{
		var_06 = func_1B98(param_00,var_04,var_05,self);
		level thread lib_0D62::func_CE9C(var_06,"spawn",1);
	}
	else if(level.agent_definition[param_01]["species"] == "c6")
	{
		var_06 = func_33B1(param_01,var_05,var_06,"axis",self);
	}
	else if(param_01 == "zombie_brute")
	{
		var_06 = func_13F13("zombie_brute","axis",var_05,var_06);
		if(isdefined(var_06))
		{
			level thread lib_0D62::func_CE9C(var_06,"spawn",1);
		}
	}
	else
	{
		var_06 = func_13F53(param_01,var_05,var_06,"axis",self);
	}

	if(!isdefined(var_06))
	{
		return undefined;
	}

	if(isdefined(self.var_13538))
	{
		var_06.var_13538 = self.var_13538;
	}

	if(scripts\common\utility::istrue(param_01))
	{
		var_06.var_9CD9 = 1;
	}

	var_06.dont_cleanup = undefined;
	if(func_9BF8())
	{
		var_06 thread func_8637();
	}

	if(isdefined(self.target) && !scripts\common\utility::istrue(self.var_1024B))
	{
		var_07 = scripts\common\utility::getstructarray(self.target,"targetname");
		var_08 = scripts\common\utility::random(var_07);
		var_04 = var_08.origin;
	}

	var_06.var_4298 = scripts\cp\_utility::func_78B4(var_04);
	if(scripts\common\utility::istrue(self.var_9B95))
	{
		var_06 thread func_42EC(param_00);
	}
	else if(param_00 == "zombie_brute")
	{
		var_06 thread func_3114();
	}
	else
	{
		var_06 thread func_64E7(param_00);
	}

	level notify("agent_spawned",var_06);
	return var_06;
}

//Function Number: 90
func_13F53(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = scripts\mp\_mp_agent::func_108E8(param_00,param_03,param_01,param_02,undefined,param_04);
	if(!isdefined(var_05))
	{
		return undefined;
	}

	if(isdefined(var_05.spawner))
	{
		if(param_04 lib_0C2B::func_10863())
		{
			var_05.entered_playspace = 1;
		}
	}

	var_05 method_8287(var_05.var_503C);
	var_05.maxhealth = var_05 func_3728(param_00);
	var_05.health = var_05.maxhealth;
	if(isdefined(level.respawn_data))
	{
		var_06 = -1;
		for(var_07 = 0;var_07 < level.respawn_enemy_list.size;var_07++)
		{
			if(level.respawn_enemy_list[var_07].var_92B8 == level.respawn_data.var_92B8 && level.respawn_data.type == param_00)
			{
				var_06 = var_07;
				break;
			}
		}

		if(var_06 > -1)
		{
			if(isdefined(level.respawn_data.health))
			{
				var_05.health = level.respawn_data.health;
			}

			level.respawn_enemy_list = scripts\cp\_utility::func_22B0(level.respawn_enemy_list,var_06);
		}

		level.respawn_data = undefined;
	}

	if(param_00 == "karatemaster" && isdefined(level.zombie_karatemaster_vo_prefix))
	{
		var_05.var_13550 = level.zombie_karatemaster_vo_prefix;
	}
	else if(param_00 == "zombie_brute")
	{
		var_05.var_13550 = level.var_13F14;
	}
	else if(param_00 == "zombie_cop")
	{
		var_05.var_13550 = level.var_13F1A;
	}
	else if(param_00 == "zombie_clown")
	{
		var_05.var_13550 = level.var_13F18;
	}
	else if(issubstr(var_05.model,"female"))
	{
		var_05.var_13550 = level.var_13F24;
	}
	else if(randomint(100) > 50)
	{
		var_05.var_13550 = level.var_13F39;
	}
	else
	{
		var_05.var_13550 = level.var_13F3A;
	}

	var_05 thread lib_0D62::func_13F10();
	if(param_00 == "alien_goon" || param_00 == "alien_phantom" || param_00 == "alien_rhino")
	{
		var_05 thread setemissive();
	}

	return var_05;
}

//Function Number: 91
setemissive()
{
	self endon("death");
	wait(0.5);
	self method_80BB(0,0.4);
}

//Function Number: 92
func_FF98(param_00)
{
	if(isdefined(param_00.var_ECF5) && param_00.var_ECF5 == "spawn_ceiling" || param_00.var_ECF5 == "spawn_wall_low")
	{
		return undefined;
	}

	if(isdefined(level.var_1094E))
	{
		var_01 = undefined;
		var_02 = scripts\common\utility::func_22A8(level.var_1094E);
		foreach(var_06, var_04 in var_02)
		{
			var_05 = [[ var_02[var_06] ]]();
			if(isdefined(var_05))
			{
				return var_05;
			}
		}
	}

	return undefined;
}

//Function Number: 93
func_DB23()
{
	self endon("death");
	wait(2);
	self setscriptablepartstate("glasses","show");
}

//Function Number: 94
func_13F13(param_00,param_01,param_02,param_03)
{
	var_04 = 2000;
	var_05 = 2;
	switch(level.players.size)
	{
		case 1:
		case 0:
			var_05 = var_05 * 1;
			break;

		case 2:
			var_05 = var_05 * 1.5;
			break;

		case 3:
			var_05 = var_05 * 2;
			break;

		case 4:
			var_05 = var_05 * 2.5;
			break;
	}

	var_06 = scripts\mp\_mp_agent::func_108E8(param_00,param_01,param_02,param_03,"iw7_zombie_laser_mp");
	if(!isdefined(var_06))
	{
		return undefined;
	}

	var_07 = func_3728("generic_zombie");
	var_08 = int(var_07 * var_05);
	var_06.maxhealth = int(min(var_04 + var_08,5000));
	var_06.health = var_06.maxhealth;
	var_06.var_8DF0 = min(var_06.maxhealth * 0.5,5000);
	var_06.var_13550 = level.var_13F14;
	var_06 thread func_310F();
	var_06 thread func_53A9();
	return var_06;
}

//Function Number: 95
func_53A9()
{
	level endon("game_ended");
	self endon("death");
	var_00 = 0;
	var_01 = 2304;
	for(;;)
	{
		var_02 = self.origin;
		wait(1);
		if(!scripts\common\utility::istrue(self.var_2B5A))
		{
			if(distancesquared(self.origin,var_02) < var_01)
			{
				var_00++;
			}
			else
			{
				var_00 = 0;
			}
		}
		else
		{
			var_00 = 0;
		}

		if(var_00 > 3)
		{
			self setorigin(self.origin + (0,0,5),1);
			var_00 = 0;
		}
	}
}

//Function Number: 96
func_13F2A(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\mp\_mp_agent::func_108E8(param_00,param_01,param_02,param_03);
	if(!isdefined(var_04))
	{
		return undefined;
	}

	var_04.maxhealth = 99999999;
	var_04.health = var_04.maxhealth;
	return var_04;
}

//Function Number: 97
func_9BF8()
{
	if(isdefined(self.var_EE79) && self.var_EE79 == "ground_spawn" || self.var_EE79 == "ground_spawn_no_boards")
	{
		return 1;
	}

	return 0;
}

//Function Number: 98
func_8637()
{
	self endon("death");
	if(isdefined(self.spawner.var_ECF5))
	{
		return;
	}

	self.var_EF64 = 1;
	self.var_180 = 1;
	var_00 = 100;
	if(!isdefined(self.spawner.angles))
	{
		self.spawner.angles = (0,0,0);
	}

	var_01 = anglestoup(self.spawner.angles);
	var_01 = vectornormalize(var_01);
	var_02 = -1 * var_01;
	var_02 = var_02 * var_00;
	var_03 = 0;
	if(abs(self.spawner.angles[2]) > 45)
	{
		var_03 = 1;
	}

	if(var_03)
	{
		var_04 = scripts\common\trace::func_DCED(self.spawner.origin - (0,0,100),self.spawner.origin + (0,0,50),self);
	}
	else
	{
		var_04 = scripts\common\trace::func_DCED(self.spawner.origin + (0,0,50),self.spawner.origin - (0,0,100),self);
	}

	var_05 = var_04["position"] + var_02;
	var_06 = var_04["position"];
	func_13F1D(var_05,var_06,var_03);
	self.var_EF64 = 0;
	self.var_180 = 0;
}

//Function Number: 99
func_13F1D(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = spawn("script_origin",param_00);
	var_03.angles = self.spawner.angles;
	self setorigin(param_00,0);
	self setplayerangles(self.spawner.angles);
	self linkto(var_03);
	self.var_AD1D = var_03;
	thread func_5173(var_03);
	var_04 = 2;
	if(!param_02)
	{
		var_03 moveto(param_01,var_04,0.1,0.1);
		playfx(level._effect["drone_ground_spawn"],param_01,(0,0,1));
		wait(var_04);
	}
	else
	{
		var_03 moveto(param_01,var_04,0.1,0.1);
		playfx(level._effect["drone_ground_spawn"],param_01,(0,0,-1));
		wait(var_04);
		var_05 = scripts\common\trace::func_DCED(param_01 - (0,0,10),param_01 - (0,0,1000),self);
		var_03 moveto(var_05["position"] + (0,0,10),0.25,0.1,0.1);
		var_06 = (var_03.angles[0],var_03.angles[1],0);
		var_03 rotateto(var_06,0.25,0.1,0.1);
		wait(0.25);
	}

	if(self.spawner.var_EE79 == "ground_spawn_no_boards")
	{
		self.entered_playspace = 1;
	}

	self unlink();
	self notify("emerge_done");
}

//Function Number: 100
func_5173(param_00)
{
	scripts\common\utility::waittill_any_3("death","emerge_done");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 101
func_33B1(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_05))
	{
		param_05 = "iw7_erad_zm";
	}

	var_06 = scripts\mp\_mp_agent::func_108E8(param_00,param_03,param_01,param_02,param_05);
	if(!isdefined(var_06))
	{
		return undefined;
	}

	if(isdefined(param_04))
	{
		var_06.spawner = param_04;
	}

	var_06.var_9CA2 = 1;
	return var_06;
}

//Function Number: 102
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
		else if(scripts\common\utility::istrue(self.is_skeleton))
		{
			var_02 = var_02 + 10;
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

//Function Number: 103
func_7C83(param_00,param_01)
{
	if(isdefined(level.var_7C80))
	{
		return [[ level.var_7C80 ]]();
	}

	var_02 = [];
	var_03 = level.var_10816;
	foreach(var_05 in var_03)
	{
		if(!var_05.var_19)
		{
			continue;
		}

		var_06 = 0;
		foreach(var_08 in level.players)
		{
			if(isdefined(param_01) && !var_08 scripts\cp\_utility::is_valid_player())
			{
				continue;
			}

			if(var_08 istouching(var_05))
			{
				var_06 = 1;
				continue;
			}

			if(scripts\common\utility::istrue(param_00) && var_08 func_9C0F(var_05))
			{
				var_06 = 1;
			}
		}

		if(var_06)
		{
			var_02[var_02.size] = var_05;
		}
	}

	return var_02;
}

//Function Number: 104
func_7C82(param_00,param_01,param_02)
{
	if(isdefined(level.var_7C80))
	{
		return [[ level.var_7C80 ]]();
	}

	var_03 = [];
	var_04 = level.var_10816;
	foreach(var_06 in var_04)
	{
		if(!var_06.var_19)
		{
			continue;
		}

		var_07 = 0;
		if(isdefined(param_01) && !param_02 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(param_02 istouching(var_06))
		{
			var_07 = 1;
		}
		else if(scripts\common\utility::istrue(param_00) && param_02 func_9C0F(var_06))
		{
			var_07 = 1;
		}

		if(var_07)
		{
			var_03[var_03.size] = var_06;
		}
	}

	return var_03;
}

//Function Number: 105
func_9C0F(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.var_186E))
	{
		return 0;
	}

	foreach(var_02 in param_00.var_186E)
	{
		if(!var_02.var_19)
		{
			continue;
		}

		if(self istouching(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 106
func_94D5()
{
	while(!isdefined(level.var_1BEC))
	{
		wait(0.1);
	}

	level.var_186E = [];
	level.var_186E["hidden_room"] = [];
	level.var_C50A["mars_3"]["swamp_stage"] = 1;
	var_00 = [];
	foreach(var_02 in level.var_1BEC)
	{
		if(isdefined(var_02.script_area) && isdefined(var_02.script_noteworthy) && var_02.script_noteworthy != "fast_travel")
		{
			var_00[var_00.size] = var_02;
		}
	}

	level.var_59F4 = var_00;
	scripts\common\utility::flag_set("init_adjacent_volumes_done");
}

//Function Number: 107
func_F28B(param_00)
{
	var_01 = param_00.target;
	var_02 = undefined;
	var_03 = param_00.script_area;
	var_04 = undefined;
	foreach(var_06 in level.var_59F4)
	{
		if(param_00 == var_06)
		{
			continue;
		}

		if(var_06.script_area == var_03)
		{
			continue;
		}

		if(var_06.target == var_01)
		{
			var_04 = var_06.script_area;
			var_02 = var_06;
			break;
		}
	}

	if(isdefined(var_02))
	{
		if(!func_9C59(var_04,var_03))
		{
			func_1751(var_02,param_00);
		}
	}
}

//Function Number: 108
func_1751(param_00,param_01)
{
	if(param_00.script_area == param_01.script_area)
	{
		return;
	}

	if(!isdefined(level.var_186E[param_00.script_area]))
	{
		level.var_186E[param_00.script_area] = [];
	}

	if(scripts\common\utility::func_2286(level.var_186E[param_00.script_area],param_01.script_area))
	{
		return;
	}

	level.var_186E[param_00.script_area][level.var_186E[param_00.script_area].size] = param_01.script_area;
	func_12E46(param_00.script_area,param_01.script_area);
}

//Function Number: 109
func_9C59(param_00,param_01)
{
	if(!isdefined(level.var_C50A))
	{
		return 0;
	}

	if(!isdefined(level.var_C50A[param_00]))
	{
		return 0;
	}

	if(!isdefined(level.var_C50A[param_00][param_01]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 110
func_12E46(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isdefined(level.var_10816[param_01]))
	{
		return;
	}

	if(!isdefined(level.var_10816[param_01].var_186E))
	{
		level.var_10816[param_01].var_186E = [];
	}

	level.var_10816[param_01].var_186E[level.var_10816[param_01].var_186E.size] = level.var_10816[param_00];
}

//Function Number: 111
update_volume_adjacency_by_name(param_00,param_01)
{
	if(!isdefined(level.var_186E[param_00]))
	{
		level.var_186E[param_00] = [];
	}

	if(scripts\common\utility::func_2286(level.var_186E[param_00],param_01))
	{
		return;
	}

	level.var_186E[param_00][level.var_186E[param_00].size] = param_01;
	func_12E46(param_00,param_01);
}

//Function Number: 112
func_7C8C()
{
	if(isdefined(level.var_13FA6))
	{
		return [[ level.var_13FA6 ]]();
	}

	return scripts\common\utility::random(level.var_1647);
}

//Function Number: 113
func_15FC(param_00)
{
	if(isdefined(level.var_10816[param_00]))
	{
		level.var_10816[param_00] func_B291();
	}
}

//Function Number: 114
deactivate_volume_by_name(param_00)
{
	if(isdefined(level.var_10816[param_00]))
	{
		level.var_10816[param_00] func_B292();
	}
}

//Function Number: 115
func_B291()
{
	if(isdefined(self.var_19) && self.var_19)
	{
		return;
	}

	var_00 = 1;
	if(scripts\cp\_utility::is_escape_gametype())
	{
		if(!scripts\common\utility::istrue(self.var_19))
		{
			level.var_1647 = [];
		}
		else
		{
			var_00 = 0;
		}
	}

	self.var_19 = 1;
	if(!func_9C13(level.var_1646,self))
	{
		level.var_1646[level.var_1646.size] = self;
		if(isdefined(self.var_1087B) && var_00)
		{
			foreach(var_02 in self.var_1087B)
			{
				var_02 func_B287();
			}
		}

		if(isdefined(self.var_8457))
		{
			foreach(var_02 in self.var_8457)
			{
				var_02 func_B26D();
			}
		}

		if(isdefined(self.var_8271))
		{
			foreach(var_02 in self.var_8271)
			{
				var_02 func_B26D();
			}
		}
	}

	var_08 = scripts\common\utility::getstructarray("secure_window","script_noteworthy");
	foreach(var_0A in var_08)
	{
		if(function_010F(var_0A.origin,self))
		{
			var_0B = scripts\common\utility::getclosest(var_0A.origin,level.var_13D59);
			var_0B.var_6261 = 1;
		}
	}

	level.active_player_respawn_locs = scripts\common\utility::array_combine(level.active_player_respawn_locs,self.var_D25E);
	level notify("volume_activated",self.var_28AB);
}

//Function Number: 116
func_B292()
{
	if(isdefined(self.var_19) && !self.var_19)
	{
		return;
	}

	self.var_19 = 0;
	if(func_9C13(level.var_1646,self))
	{
		level.var_1646 = scripts\common\utility::func_22A9(level.var_1646,self);
		if(isdefined(self.var_1087B))
		{
			foreach(var_01 in self.var_1087B)
			{
				var_01 func_B288();
			}
		}

		if(isdefined(self.var_8457))
		{
			foreach(var_01 in self.var_8457)
			{
				var_01 func_B26E();
			}
		}

		if(isdefined(self.var_D25E))
		{
			foreach(var_01 in self.var_D25E)
			{
				level.active_player_respawn_locs = scripts\common\utility::func_22A9(level.active_player_respawn_locs,var_01);
			}
		}
	}
}

//Function Number: 117
func_B287()
{
	if(!func_9C13(level.var_1647,self))
	{
		level.var_1647[level.var_1647.size] = self;
	}

	self.var_19 = 1;
	self.var_93A8 = 0;
}

//Function Number: 118
func_B288()
{
	if(func_9C13(level.var_1647,self))
	{
		level.var_1647 = scripts\common\utility::func_22A9(level.var_1647,self);
	}

	self.var_19 = 0;
}

//Function Number: 119
func_D1F7()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	var_00 = 35;
	var_01 = var_00 * var_00;
	var_02 = 1000;
	while(!isdefined(level.spawned_enemies))
	{
		wait(0.1);
	}

	for(;;)
	{
		if(scripts\cp\_utility::func_9E3A())
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(level.spawned_enemies.size > 0)
		{
			var_03 = sortbydistance(level.spawned_enemies,self.origin);
			for(var_04 = 0;var_04 < var_03.size;var_04++)
			{
				var_05 = var_03[var_04];
				if(!agent_type_does_auto_melee(var_05))
				{
					continue;
				}

				if(!var_05 func_3828())
				{
					continue;
				}

				if(isdefined(var_05.attackent))
				{
					continue;
				}

				if(!isdefined(var_05.var_A88B))
				{
					var_05.var_A88B = gettime();
				}

				if(distance2dsquared(var_05.origin,self.origin) < var_01)
				{
					var_06 = gettime();
					if(var_05.var_A88B + 1000 < var_06)
					{
						if(isdefined(var_05.var_A9B8))
						{
							if(var_05.var_A9B8 + 1000 < var_06)
							{
								if(!func_CFB2(var_05))
								{
									continue;
								}

								func_576B(var_05);
								break;
							}
						}
						else if(!isdefined(var_05.hasplayedvignetteanim) || var_05.hasplayedvignetteanim)
						{
							if(!scripts\common\utility::istrue(var_05.var_2BE7))
							{
								if(!func_CFB2(var_05))
								{
									continue;
								}

								func_576B(var_05);
							}

							break;
						}
					}

					continue;
				}

				break;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 120
agent_type_does_auto_melee(param_00)
{
	if(isdefined(level.auto_melee_agent_type_check))
	{
		return [[ level.auto_melee_agent_type_check ]](param_00);
	}

	if(!isdefined(param_00.agent_type))
	{
		return 0;
	}

	if(param_00.agent_type == "zombie_brute" || param_00.agent_type == "zombie_clown")
	{
		return 0;
	}

	return 1;
}

//Function Number: 121
func_576B(param_00)
{
	param_00 lib_0A1B::func_2965(self);
	param_00.var_A88B = gettime();
	self dodamage(45,param_00.origin,param_00,param_00,"MOD_IMPACT","none");
}

//Function Number: 122
func_3828()
{
	if(scripts\common\utility::istrue(self.var_9E0C))
	{
		return 0;
	}

	if(scripts\mp\agents\zombie\zmb_zombie_agent::func_5F70())
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_9CEC))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_9CEF))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_11196))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_9BB0))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_B36E))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_9BC9))
	{
		return 0;
	}

	if(isdefined(self.killing_time))
	{
		return 0;
	}

	return 1;
}

//Function Number: 123
func_64E7(param_00)
{
	level endon("game_ended");
	func_12E2A();
	if(param_00 != "zombie_brute" && !scripts\cp\_utility::is_escape_gametype())
	{
		thread func_A5B4();
	}

	thread func_135A3();
}

//Function Number: 124
func_42EC(param_00)
{
	level endon("game_ended");
	level.spawned_enemies[level.spawned_enemies.size] = self;
	self.var_54CB = 1;
	self.allowpain = 0;
}

//Function Number: 125
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
	func_93EB(1);
	level.spawned_enemies[level.spawned_enemies.size] = self;
	thread func_135A3();
	self waittill("death");
	level.var_3120 = scripts\common\utility::func_22A9(level.var_3120,self);
	func_4FB8(1);
}

//Function Number: 126
func_12E2A()
{
	var_00 = 1;
	level.spawned_enemies[level.spawned_enemies.size] = self;
	level.var_4B95 = level.var_4B95 + var_00;
}

//Function Number: 127
func_12E29(param_00,param_01)
{
	var_02 = 1;
	if(isdefined(self.var_24CA))
	{
		var_03 = self.var_24CA;
		lib_0D4D::func_DF34(self.var_24CA);
		self.var_24CA = undefined;
	}

	level.spawned_enemies = scripts\common\utility::func_22A9(level.spawned_enemies,self);
	if(scripts\common\utility::istrue(self.var_9CA2))
	{
		return;
	}

	level.var_4B95 = level.var_4B95 - var_02;
	if(scripts\common\utility::flag("pause_wave_progression"))
	{
		return;
	}

	if(!self.var_54CB)
	{
		level.var_4B6E = level.var_4B6E + var_02;
		return;
	}

	add_to_respawn_list();
	level.var_E299++;
}

//Function Number: 128
add_to_respawn_list()
{
	var_00 = spawnstruct();
	var_00.health = self.died_poorly_health;
	var_00.type = self.agent_type;
	var_00.var_92B8 = gettime();
	level.respawn_enemy_list[level.respawn_enemy_list.size] = var_00;
	self.died_poorly_health = undefined;
}

//Function Number: 129
func_A5B4()
{
	self endon("death");
	if(isdefined(self.var_594C))
	{
		return;
	}

	var_00 = 625;
	var_01 = 100;
	var_02 = 0;
	var_03 = self.origin;
	var_04 = self.angles;
	self.traversal_start_time = undefined;
	wait(1);
	if(isdefined(self.spawner) && isdefined(self.spawner.var_ECF5))
	{
		while(!scripts\common\utility::istrue(self.hasplayedvignetteanim))
		{
			wait(0.1);
		}
	}

	while(!isdefined(self.var_2303.var_4B12))
	{
		wait(0.1);
	}

	for(;;)
	{
		if(isdefined(self.var_9CEC))
		{
			var_05 = gettime();
			if(!isdefined(self.traversal_start_time))
			{
				self.traversal_start_time = var_05;
				wait(1);
				continue;
			}
			else if(var_05 - self.traversal_start_time < 10000)
			{
				wait(1);
				continue;
			}
			else
			{
				var_02 = 6;
			}
		}
		else
		{
			self.traversal_start_time = undefined;
		}

		if(isdefined(self.var_9393))
		{
			wait(1);
			continue;
		}

		if(self.var_9BB0 || self.var_152C || scripts\common\utility::istrue(self.var_11196) || scripts\common\utility::istrue(self.var_4F42))
		{
			wait(1);
			continue;
		}

		if(isdefined(self.var_594C))
		{
			wait(1);
			continue;
		}

		var_06 = var_00;
		if(self.var_2303.var_4B12 == "slow_walk")
		{
			var_06 = var_01;
		}

		if(distancesquared(self.origin,var_03) < var_06)
		{
			if(isdefined(self.var_9CDD))
			{
				var_02++;
			}
			else if(isdefined(self.var_4B26))
			{
				var_07 = anglesdelta(var_04,self.angles);
				var_08 = distancesquared(self.origin,self.var_4B26.origin);
				if(var_08 > 10000 && var_07 < 45)
				{
					var_02++;
				}
				else
				{
					var_02 = 0;
				}
			}
			else if(isdefined(self.var_6658))
			{
				if(!lib_0D4D::func_664D(self.var_6658))
				{
					var_02++;
				}
				else
				{
					var_02 = 0;
				}
			}
			else
			{
				var_02 = 0;
			}

			if(var_02 == 4)
			{
				self setorigin(self.origin + (0,0,10),0);
			}

			if(var_02 > 5)
			{
				break;
			}
		}

		var_04 = self.angles;
		var_03 = self.origin;
		wait(1);
	}

	self.var_54CB = 1;
	if(scripts\common\utility::istrue(self.var_B36D) && isdefined(level.var_C20A))
	{
		level.var_C20A--;
	}

	self dodamage(self.health + 960,self.origin,self,self,"MOD_SUICIDE");
}

//Function Number: 130
func_7C2F()
{
	var_00 = undefined;
	var_00 = func_7C8C();
	return var_00;
}

//Function Number: 131
func_9C12()
{
	if(isdefined(level.var_9B0B))
	{
		foreach(var_01 in level.var_9B0B)
		{
			if(function_010F(self.origin,var_01))
			{
				return 0;
			}
		}
	}

	if(isdefined(level.var_10816))
	{
		foreach(var_01 in level.var_10816)
		{
			if(function_010F(self.origin,var_01))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 132
func_E81B()
{
	level endon("game_ended");
	var_00 = 5;
	level.var_6870 = 0;
	var_01 = 21;
	level thread func_4094();
	var_02 = 1;
	for(;;)
	{
		func_13BCB();
		scripts\cp\_persistence::func_12DDE(level.wave_num);
		if(level.wave_num > 0)
		{
			if(level.wave_num / 10 == var_02)
			{
				level notify("prize_restock");
				if(scripts\cp\_utility::map_check(0))
				{
					level thread scripts\cp\_vo::try_to_play_vo("dj_nag_ticket_restock","zmb_dj_vo","highest",20,0,0,1,100);
				}

				var_02++;
			}

			if(getdvar("ui_gametype") == "zombie" && scripts\cp\_utility::isplayingsolo() || level.only_one_player)
			{
				if(isdefined(level.players[0]))
				{
					if(level.wave_num == 2)
					{
						level.players[0] thread scripts\cp\_hud_message::wait_and_play_tutorial_message("zombiehealth",7);
					}
					else if(level.wave_num == 3)
					{
						level.players[0] thread scripts\cp\_hud_message::wait_and_play_tutorial_message("scenes",7);
					}
					else if(level.wave_num == 4 && !level.players[0] scripts\cp\_hud_message::func_79FC("magic_wheel"))
					{
						level.players[0] thread scripts\cp\_hud_message::wait_and_play_tutorial_message("magic_wheel",7);
						level.players[0] notify("saw_wheel_tutorial");
					}
					else if(level.wave_num == 9 && !level.players[0] scripts\cp\_hud_message::func_79FC("pap"))
					{
						level.players[0] thread scripts\cp\_hud_message::wait_and_play_tutorial_message("pap",7);
					}
				}
			}

			if(getdvar("ui_gametype") == "zombie" && !scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
			{
				foreach(var_04 in level.players)
				{
					var_04 setclientomnvar("zombie_wave_number",level.wave_num);
					var_04 scripts\cp\_merits::func_D9AD("mt_highest_round");
				}
			}
		}

		if(func_FF9D(level.wave_num))
		{
			level notify("event_wave_starting");
			func_E7F0(level.wave_num);
		}
		else
		{
			level notify("regular_wave_starting");
			if(level.var_D745 == 1 && level.wave_num > 5)
			{
				level thread scripts\cp\_vo::try_to_play_vo("dj_interup_wave_start","zmb_dj_vo","high",4,0,0,1,40);
			}

			if(soundexists("mus_zombies_newwave") && level.wave_num > 0)
			{
				level thread func_BDD4();
			}

			func_1081A(level.wave_num);
			if(soundexists("mus_zombies_endwave") && level.wave_num > 0)
			{
				level thread func_BDD1();
			}
		}

		if(level.wave_num > 0)
		{
			level notify("spawn_wave_done");
		}

		if(level.wave_num > 2)
		{
			if(isdefined(level.final_wave_vo_func))
			{
				level thread [[ level.final_wave_vo_func ]](level.wave_num);
			}
		}

		var_06 = int(1000);
		if(level.wave_num < 21)
		{
			var_06 = int(level.wave_num * 50);
		}

		foreach(var_04 in level.players)
		{
			if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
			{
				var_04 scripts\cp\_persistence::give_player_xp(var_06,1);
			}

			var_04 scripts\cp\_merits::func_D9AD("mt_total_rounds");
			if(level.wave_num > 0)
			{
				var_04 notify("next_wave_notify");
			}

			var_04.coaster_ridden_this_round = undefined;
			var_04.var_2113 = 0;
		}

		if(level.var_D745 == 1 && level.wave_num > 5)
		{
			level thread scripts\cp\_vo::try_to_play_vo("dj_interup_wave_end","zmb_dj_vo","high",4,0,0,1,40);
		}

		wait(var_00);
		level thread scripts\cp\gametypes\zombie::func_E196();
		if(isdefined(level.wave_complete_dialogues_func))
		{
			[[ level.wave_complete_dialogues_func ]](level.wave_num);
		}

		var_09 = gettime() - level.var_13BDA / 1000;
		scripts\cp\zombies\zombie_analytics::func_AF90(level.wave_num,var_09,level.var_AA0B,level.var_11929);
		if(level.wave_num > 1)
		{
			func_13BDB();
		}

		level.wave_num = func_7B1C();
		scripts\cp\_persistence::update_players_career_highest_wave(level.wave_num,level.script);
		var_00 = func_7D00(var_00,level.wave_num);
	}
}

//Function Number: 133
clown_wave_music()
{
	wait(0.5);
	level thread scripts\cp\_vo::try_to_play_vo("ww_clownwave_wavestart","zmb_announcer_vo","highest",70,0,0,1);
	wait(3);
	if(soundexists("mus_zombies_eventwave_start"))
	{
		level thread func_BDD3();
	}

	level.wait_for_music_clown_wave = 1;
}

//Function Number: 134
wave_complete_dialogues(param_00)
{
	if(!scripts\cp\_music_and_dialog::func_3837())
	{
		if(param_00 >= 2 && randomint(100) > 60)
		{
			foreach(var_02 in level.players)
			{
				var_02 thread scripts\cp\_vo::try_to_play_vo("convo_deja_vu","zmb_comment_vo","highest",666,0,0,0,100);
			}
		}
	}

	if(!isdefined(level.var_4481))
	{
		level.var_4481 = [];
	}

	if(param_00 >= 17 && !isdefined(level.var_4481["flavour_1"]))
	{
		if(randomint(100) > 60)
		{
			level thread scripts\cp\_vo::try_to_play_vo("flavour_1","zmb_dialogue_vo","highest",666,0,0,0,100);
		}
	}

	if(param_00 >= 3 && param_00 <= 5 && !isdefined(level.var_4481["round_end_3thru5_1"]))
	{
		if(randomint(100) > 50)
		{
			level thread scripts\cp\_vo::try_to_play_vo("round_end_3thru5_1","zmb_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["round_end_3thru5_1"] = 1;
			return;
		}

		return;
	}

	if(param_00 >= 6 && param_00 <= 8 && !isdefined(level.var_4481["round_end_6thru8_1"]))
	{
		if(randomint(100) > 50)
		{
			level thread scripts\cp\_vo::try_to_play_vo("round_end_6thru8_1","zmb_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["round_end_6thru8_1"] = 1;
			return;
		}

		return;
	}

	if(param_00 >= 9 && param_00 <= 12 && !isdefined(level.var_4481["round_end_9thru12_1"]))
	{
		if(randomint(100) > 50)
		{
			level thread scripts\cp\_vo::try_to_play_vo("round_end_9thru12_1","zmb_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["round_end_9thru12_1"] = 1;
			return;
		}

		return;
	}

	if(param_00 >= 13 && param_00 <= 16 && !isdefined(level.var_4481["round_end_13thru16_1"]))
	{
		if(randomint(100) > 50)
		{
			level thread scripts\cp\_vo::try_to_play_vo("round_end_13thru16_1","zmb_dialogue_vo","highest",666,0,0,0,100);
			level.var_4481["round_end_13thru16_1"] = 1;
			return;
		}

		return;
	}
}

//Function Number: 135
func_13BDB()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]))
		{
			if(scripts\common\utility::istrue(var_01.in_afterlife_arcade))
			{
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["coaster"] = 0;
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown"] = 0;
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game"] = 0;
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["game_race"] = 0;
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery"] = 0;
				var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
			}

			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets"] = 0;
			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["coaster"] = 0;
			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown"] = 0;
			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["laughingclown_afterlife"] = 0;
			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game"] = 0;
			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["basketball_game_afterlife"] = 0;
			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game"] = 0;
			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["game_race"] = 0;
			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery"] = 0;
			var_01.pers["timesPerWave"].var_11930[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
		}

		var_02 = var_01 getcurrentweapon();
		var_03 = getweaponbasename(var_02);
		if(var_01.var_6977 == 1 || !isdefined(var_01.var_13BE3[var_03]))
		{
			continue;
		}

		var_01.var_13BE3[var_03]++;
	}
}

//Function Number: 136
func_13BCB()
{
	level notify("wave_starting");
	if(scripts\common\utility::func_6E34("dj_interup_wave_start_init"))
	{
		scripts\common\utility::flag_set("dj_interup_wave_start_init");
	}

	foreach(var_01 in level.players)
	{
		var_01.var_732F = 0;
	}

	func_E21C();
	level.var_13BDA = gettime();
}

//Function Number: 137
func_E21C()
{
	var_00 = 50;
	level.var_B41F = var_00 * level.wave_num;
	if(level.var_B41F > 500)
	{
		level.var_B41F = 500;
	}

	foreach(var_02 in level.players)
	{
		var_02.var_DDAF = 0;
	}
}

//Function Number: 138
func_1081A(param_00)
{
	level.var_10E3C = func_7CA9(param_00);
	level.var_B467 = func_7ACD(param_00);
	level.var_5274 = func_7D10(param_00);
	level.var_4B6E = 0;
	level.var_11046 = 0;
	func_10927();
	level.var_B467 = 0;
	level.var_B432 = 0;
	level.var_11046 = 1;
}

//Function Number: 139
func_4F0E()
{
	iprintln("starting wave " + level.wave_num);
	iprintln("total spawns: " + level.var_5274);
}

//Function Number: 140
func_FF9D(param_00)
{
	if(isdefined(level.should_run_event_func))
	{
		return [[ level.should_run_event_func ]](param_00);
	}

	if(scripts\cp\_utility::is_escape_gametype())
	{
		return 0;
	}

	if(getdvar("ui_mapname") == "cp_disco")
	{
		return 0;
	}

	if(param_00 < 5)
	{
		return 0;
	}
	else if(scripts\common\utility::func_6E34("defense_sequence_active") && scripts\common\utility::flag("defense_sequence_active"))
	{
		return 0;
	}
	else if(scripts\common\utility::func_6E34("all_center_positions_used") && scripts\common\utility::flag("all_center_positions_used"))
	{
		return 0;
	}
	else
	{
		var_01 = param_00 - level.var_A8BC;
		if(var_01 < 5)
		{
			return 0;
		}
		else
		{
			var_01 = var_01 - 4;
			var_02 = var_01 / 3 * 100;
			if(randomint(100) < var_02)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 141
func_E7F0(param_00)
{
	level.respawn_enemy_list = [];
	level.respawn_data = undefined;
	var_01 = func_7848(param_00);
	if(isdefined(level.event_funcs_start))
	{
		[[ level.event_funcs_start ]](var_01);
	}
	else
	{
		level thread clown_wave_music();
		func_F604("cp_zmb_alien",1);
		level.var_13445 = "cp_zmb_alien";
	}

	level.var_106E2 = 1;
	var_02 = 0;
	if(isdefined(var_01))
	{
		if(isdefined(level.var_6840[var_01]))
		{
			[[ level.var_6840[var_01] ]]();
		}
		else
		{
			var_02 = 1;
		}
	}
	else
	{
		var_02 = 1;
	}

	if(var_02)
	{
		return;
	}

	level.var_106E2 = 0;
	level.var_1096B++;
	level.var_A8BC = param_00;
	if(isdefined(level.event_funcs_end))
	{
		[[ level.event_funcs_end ]](var_01);
	}
	else
	{
		level.var_13445 = undefined;
		func_F604("",0);
		if(soundexists("mus_zombies_eventwave_end"))
		{
			level thread func_BDD2();
		}

		level.wait_for_music_clown_wave = 0;
	}

	level.respawn_enemy_list = [];
	level.respawn_data = undefined;
}

//Function Number: 142
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

//Function Number: 143
func_7848(param_00)
{
	if(isdefined(level.available_event_func))
	{
		return [[ level.available_event_func ]](param_00);
	}

	return "goon";
}

//Function Number: 144
func_7B1C()
{
	return level.wave_num + 1;
}

//Function Number: 145
func_7D00(param_00,param_01)
{
	if(scripts\cp\_utility::is_escape_gametype())
	{
		return 1;
	}

	return 10;
}

//Function Number: 146
func_7CA9(param_00)
{
	var_01 = ["generic_zombie"];
	return var_01;
}

//Function Number: 147
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

//Function Number: 148
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

//Function Number: 149
func_7CFF(param_00)
{
	return 1;
}

//Function Number: 150
func_79B4(param_00)
{
	return 0;
}

//Function Number: 151
func_7A3D(param_00,param_01)
{
	if(isdefined(level.var_10698))
	{
		param_00 = param_00 + 0;
		var_02 = tablelookupbyrow(level.var_10698,param_00,param_01);
		var_03 = strtok(var_02," ");
		if(var_03.size > 0)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 152
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

//Function Number: 153
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

//Function Number: 154
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

//Function Number: 155
func_310F()
{
	level endon("game_ended");
	self endon("death");
	thread lib_0D62::func_CE9B(self.var_13550);
	self.var_D4AA = 0;
	for(;;)
	{
		var_00 = scripts\common\utility::waittill_any_timeout_1(6,"attack_hit","attack_miss");
		switch(var_00)
		{
			case "attack_hit":
				level thread lib_0D62::func_CE9C(self,"attack_swipe",0);
				break;
	
			case "attack_miss":
				level thread lib_0D62::func_CE9C(self,"attack_swipe",0);
				break;
	
			case "timeout":
				level thread lib_0D62::func_CE9C(self,"run_grunt",0);
				break;
		}
	}
}

//Function Number: 156
func_135A3()
{
	self endon("death");
	for(;;)
	{
		if([[ level.var_164B ]](self.origin))
		{
			self.entered_playspace = 1;
			if(isdefined(self.var_24CA))
			{
				if(isdefined(self.var_24CA.var_C2D0) && self.var_24CA.var_C2D0 == self)
				{
					lib_0D4D::func_DF34(self.var_24CA);
				}
			}

			return;
		}

		wait(0.35);
	}
}

//Function Number: 157
func_4094()
{
	if(isdefined(level.ai_cleanup_func))
	{
		level thread [[ level.ai_cleanup_func ]]();
		return;
	}

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
			var_05 = 2250000;
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

//Function Number: 158
func_380D(param_00)
{
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

	if(scripts\common\utility::istrue(level.zbg_active))
	{
		return 0;
	}

	return 1;
}

//Function Number: 159
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

	if(self.agent_type == "generic_zombie" || self.agent_type == "zombie_cop" || self.agent_type == "lumberjack")
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
		param_00 = 1000000;
		var_02 = 0;
	}
	else if(level.var_B789.size == 0)
	{
		if(isdefined(level.use_adjacent_volumes))
		{
			var_02 = func_8016(1,0);
		}
		else
		{
			var_02 = func_8016(0,0);
		}
	}
	else
	{
		var_02 = func_8016(1,0);
		if(var_02)
		{
			var_04 = func_8016(0,1);
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
		else if(isdefined(var_07) && func_CF4C(var_07))
		{
			var_0B = 189225;
		}
		else
		{
			var_0B = 1000000;
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

//Function Number: 160
func_FF1A(param_00)
{
	if(!isdefined(param_00.agent_type))
	{
		return 0;
	}

	switch(param_00.agent_type)
	{
		case "zombie_grey":
		case "zombie_brute":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 161
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

		if(func_CFB2(var_03))
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

//Function Number: 162
func_EDF6()
{
	self dodamage(self.health + 950,self.origin,self,self,"MOD_SUICIDE");
}

//Function Number: 163
func_CFB2(param_00)
{
	var_01 = param_00 getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = self.origin - param_00 getorigin();
	var_03 = vectornormalize(var_03);
	var_04 = vectordot(var_02,var_03);
	if(var_04 < 0.766)
	{
		return 0;
	}

	return 1;
}

//Function Number: 164
func_CF4C(param_00)
{
	var_01 = param_00 getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = param_00 getorigin() - self.origin;
	var_04 = vectordot(var_02,var_03);
	if(var_04 < 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 165
func_8016(param_00,param_01)
{
	var_02 = undefined;
	foreach(var_04 in level.var_1646)
	{
		if(self istouching(var_04))
		{
			var_02 = var_04;
			break;
		}
	}

	if(!isdefined(var_02))
	{
		return 0;
	}

	var_06 = 0;
	if(scripts\common\utility::istrue(param_01))
	{
		var_06 = var_06 + func_C1EB(var_02,1);
	}
	else
	{
		var_06 = lib_0D60::func_800B(var_02);
	}

	if(scripts\common\utility::istrue(param_00) && var_06 == 0 && isdefined(var_02.var_186E))
	{
		foreach(var_04 in var_02.var_186E)
		{
			var_06 = var_06 + lib_0D60::func_800B(var_04);
		}
	}

	return var_06;
}

//Function Number: 166
func_F5EC()
{
	scripts\common\utility::flag_wait("init_adjacent_volumes_done");
	level.var_B789 = [];
	var_00 = getentarray("mini_zone","script_noteworthy");
	foreach(var_02 in var_00)
	{
		level.var_B789[var_02.var_336] = var_02;
	}

	if(level.var_B789.size == 0)
	{
		return;
	}

	var_04 = 1;
	foreach(var_06 in level.var_10816)
	{
		var_04 = 1;
		var_07 = var_06.var_28AB + "_" + var_04 + "_despawn_volume";
		if(var_07 == "mars3_1_despawn_volume")
		{
			var_04 = 1;
		}

		while(isdefined(level.var_B789[var_07]))
		{
			var_08 = var_06.var_28AB + "_" + var_04 - 1 + "_despawn_volume";
			var_09 = var_06.var_28AB + "_" + var_04 + 1 + "_despawn_volume";
			if(isdefined(level.var_B789[var_08]))
			{
				level.var_B789[var_07].var_186E[var_08] = level.var_B789[var_08];
			}

			if(isdefined(level.var_B789[var_09]))
			{
				level.var_B789[var_07].var_186E[var_09] = level.var_B789[var_09];
			}

			if(isdefined(level.var_B789[var_07].target))
			{
				var_0A = level.var_B789[var_07].target;
				level.var_B789[var_07].var_186E[var_0A] = level.var_B789[var_0A];
				level.var_B789[var_0A].var_186E[var_07] = level.var_B789[var_07];
			}

			var_04++;
			var_07 = var_06.var_28AB + "_" + var_04 + "_despawn_volume";
		}
	}
}

//Function Number: 167
func_C1EB(param_00,param_01)
{
	var_02 = 1;
	var_03 = undefined;
	var_04 = 1;
	var_05 = 0;
	while(var_02)
	{
		var_06 = getentarray(param_00.var_28AB + "_" + var_04 + "_despawn_volume","targetname");
		if(isdefined(var_06[0]))
		{
			if(self istouching(var_06[0]))
			{
				var_03 = var_06[0];
				break;
			}

			var_04++;
			continue;
		}

		var_02 = 0;
	}

	if(isdefined(var_03))
	{
		var_05 = lib_0D60::func_800B(var_03);
		if(scripts\common\utility::istrue(param_01) && var_05 == 0 && isdefined(var_03.var_186E))
		{
			foreach(var_08 in var_03.var_186E)
			{
				var_05 = var_05 + lib_0D60::func_800B(var_08);
			}
		}
	}

	return var_05;
}

//Function Number: 168
create_spawner(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = level.var_10816[param_00];
	var_07 = spawnstruct();
	var_07.origin = param_01;
	if(isdefined(param_02))
	{
		var_07.angles = param_02;
	}
	else
	{
		var_07.angles = (0,0,0);
	}

	if(isdefined(param_05))
	{
		var_07.script_fxid = param_05;
	}

	var_07.script_noteworthy = "static";
	if(isdefined(param_04))
	{
		var_07.var_ECF5 = param_04;
	}

	if(isdefined(param_03))
	{
		var_07.var_EE79 = param_03;
	}

	var_07.var_336 = var_06.target;
	var_07 func_10865(var_06);
	var_06.var_1087B = scripts\common\utility::array_add(var_06.var_1087B,var_07);
	return var_07;
}

//Function Number: 169
func_7D87()
{
	level.var_13F33 = scripts\common\utility::getstructarray("zombie_idle_spot","targetname");
	level thread func_962E();
}

//Function Number: 170
func_FF55(param_00)
{
	if(getdvarint("scr_active_volume_check") == 1)
	{
		if(isplayer(param_00) && !scripts\cp\zombies\_powerups::is_in_active_volume(param_00.origin))
		{
			return 1;
		}
	}

	if(isdefined(param_00.var_AD2C))
	{
		return 1;
	}

	if(isdefined(param_00.var_9C54))
	{
		return 1;
	}

	var_01 = isdefined(self.var_10C) && isdefined(self.var_10C.var_9BE1);
	if(!var_01 && distancesquared(param_00.origin,getclosestpointonnavmesh(param_00.origin)) > 10000)
	{
		return 1;
	}

	if(self.agent_type == "zombie_brute" && isdefined(param_00.special_case_ignore))
	{
		return 1;
	}

	return 0;
}

//Function Number: 171
func_962E()
{
	if(!isdefined(level.var_13F33) || level.var_13F33.size == 0)
	{
		return;
	}

	level.var_71A7 = ::func_7A2C;
	if(isdefined(level.idle_spot_patch_func))
	{
		[[ level.idle_spot_patch_func ]]();
	}

	var_00 = [];
	foreach(var_02 in level.var_13F33)
	{
		var_03 = var_02 func_962D();
		if(isdefined(var_03))
		{
			var_00[var_00.size] = var_03;
		}
	}

	level.var_13F33 = scripts\common\utility::func_22AC(level.var_13F33,var_00);
}

//Function Number: 172
func_962D()
{
	foreach(var_01 in level.var_10816)
	{
		if(function_010F(self.origin,var_01))
		{
			self.var_13538 = var_01;
			return;
		}
	}

	return self;
}

//Function Number: 173
debug_idle_spots(param_00,param_01)
{
	wait(15);
	foreach(var_03 in param_00)
	{
		thread scripts\cp\_utility::drawsphere(var_03.origin,5,1800,param_01);
	}
}

//Function Number: 174
add_idle_spot(param_00)
{
	var_01 = spawnstruct();
	var_01.origin = param_00;
	var_01.var_336 = "zombie_idle_spot";
	level.var_13F33 = scripts\common\utility::array_add_safe(level.var_13F33,var_01);
}

//Function Number: 175
move_idle_spot(param_00,param_01)
{
	var_02 = scripts\common\utility::getclosest(param_00,level.var_13F33,500);
	var_02.origin = param_01;
}

//Function Number: 176
func_4957()
{
	var_00 = 80;
	var_01 = [];
	var_01[0] = getclosestpointonnavmesh(self.origin + (var_00,0,0));
	var_01[1] = getclosestpointonnavmesh(self.origin + (var_00,var_00,0));
	var_01[2] = getclosestpointonnavmesh(self.origin + (0,var_00,0));
	var_01[3] = getclosestpointonnavmesh(self.origin + (-1 * var_00,var_00,0));
	var_01[4] = getclosestpointonnavmesh(self.origin + (-1 * var_00,0,0));
	var_01[5] = getclosestpointonnavmesh(self.origin + (-1 * var_00,-1 * var_00,0));
	var_01[6] = getclosestpointonnavmesh(self.origin + (0,-1 * var_00,0));
	var_01[7] = getclosestpointonnavmesh(self.origin + (var_00,-1 * var_00,0));
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_02[var_03] = 0;
	}

	var_04 = spawnstruct();
	var_04.var_C6FB = var_01;
	var_04.var_1621 = var_02;
	self.var_E540 = var_04;
}

//Function Number: 177
func_7C19(param_00)
{
	foreach(var_03, var_02 in param_00.var_E540.var_C6FB)
	{
		if(param_00.var_E540.var_1621[var_03])
		{
			continue;
		}

		param_00.var_E540.var_1621[var_03] = 1;
		thread func_DF41();
		return var_03;
	}

	return undefined;
}

//Function Number: 178
func_7A2C()
{
	if(!isdefined(level.var_13F33))
	{
		return undefined;
	}

	return func_7C18(level.var_13F33);
}

//Function Number: 179
func_7C18(param_00)
{
	param_00 = scripts\common\utility::array_randomize(param_00);
	if(param_00.size == 1)
	{
		var_01 = param_00[0];
		self.var_92E8 = var_01;
		return var_01.origin;
	}

	foreach(var_02 in var_01)
	{
		if(function_010F(self.origin,var_02.var_13538))
		{
			if(isdefined(self.var_92E8) && var_02 == self.var_92E8)
			{
				continue;
			}

			self.var_92E8 = var_02;
			return var_02.origin;
		}
	}

	if(!isdefined(self.spawner))
	{
		return undefined;
	}

	foreach(var_02 in param_00)
	{
		if(isdefined(self.spawner.var_13538) && self.spawner.var_13538 == var_02.var_13538)
		{
			if(isdefined(self.var_92E8) && var_02 == self.var_92E8)
			{
				continue;
			}

			self.var_92E8 = var_02;
			return var_02.origin;
		}
	}

	return undefined;
}

//Function Number: 180
func_DDC7(param_00,param_01)
{
	self endon("reset_recently_used");
	wait(param_00);
	self.var_DDC4 = 1;
	wait(param_01);
	self.var_DDC4 = undefined;
	self notify("reset_recently_used");
}

//Function Number: 181
func_DF41()
{
	scripts\common\utility::waittill_any_3("StopFindTargetNoGoal","death");
	self.var_92E8.var_E540.var_1621[self.var_92E9] = 0;
	self.var_92E8 = undefined;
	self.var_92E9 = undefined;
	self notify("StopFindTargetNoGoal");
}

//Function Number: 182
func_F546(param_00)
{
	var_01 = scripts\common\utility::getstructarray("player_respawn_loc","targetname");
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(function_010F(var_04.origin,param_00))
		{
			var_04.var_212E = param_00;
			var_02[var_02.size] = var_04;
		}
	}

	param_00.var_D25E = var_02;
}

//Function Number: 183
func_BDD4()
{
	if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		scripts\cp\_utility::func_D52A("mus_zombies_newwave",(0,0,0),1);
	}

	level notify("wave_start_sound_done");
}

//Function Number: 184
func_BDD1()
{
	wait(0.3);
	scripts\cp\_utility::func_D52A("mus_zombies_endwave",(0,0,0));
}

//Function Number: 185
func_BDD3()
{
	scripts\cp\_utility::func_D52A("mus_zombies_eventwave_start",(0,0,0));
	level notify("wave_start_sound_done");
}

//Function Number: 186
func_BDD2()
{
	scripts\cp\_utility::func_D52A("mus_zombies_eventwave_end",(0,0,0));
}

//Function Number: 187
func_BDD0()
{
	scripts\cp\_utility::func_D52A("mus_zombies_boss_start",(0,0,0));
}

//Function Number: 188
func_BDCF()
{
	scripts\cp\_utility::func_D52A("mus_zombies_boss_end",(0,0,0));
}

//Function Number: 189
func_93EB(param_00)
{
	level.var_E1CC = level.var_E1CC + param_00;
}

//Function Number: 190
func_4FB8(param_00)
{
	level.var_E1CC = max(0,level.var_E1CC - param_00);
}

//Function Number: 191
func_93E6(param_00)
{
	level.var_50F8 = level.var_50F8 + param_00;
}

//Function Number: 192
func_4FB6(param_00)
{
	level.var_50F8 = level.var_50F8 - param_00;
}