/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\cp_disco_spawning.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 78
 * Decompile Time: 3859 ms
 * Timestamp: 10/27/2023 12:08:40 AM
*******************************************************************/

//Function Number: 1
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

//Function Number: 2
func_8455()
{
	var_00 = level.players.size;
	var_01 = var_00 * 3;
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
			var_01 = var_00 * 16;
			var_02 = 3;
			break;

		default:
			var_01 = var_00 * 16;
			var_02 = 3;
			break;
	}

	var_01 = var_01 * var_02;
	return var_01;
}

//Function Number: 3
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

//Function Number: 4
func_B26D()
{
	if(!func_9C13(level.var_162C,self))
	{
		level.var_162C[level.var_162C.size] = self;
	}

	self.var_19 = 1;
	self.var_93A8 = 0;
}

//Function Number: 5
func_B26E()
{
	self.var_19 = 0;
}

//Function Number: 6
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

//Function Number: 7
func_79EB()
{
	return ["skater"];
}

//Function Number: 8
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

//Function Number: 9
func_826F()
{
	var_00 = 0.5;
	return var_00;
}

//Function Number: 10
func_8270()
{
	var_00 = level.players.size;
	return 8 + 4 * var_00;
}

//Function Number: 11
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
		if(level.respawn_data.type == "skater")
		{
			param_00 = 1;
		}
	}

	var_02 = min(param_00,2);
	func_1071C(var_02);
	return var_02;
}

//Function Number: 12
func_1071C(param_00)
{
	var_01 = 0.3;
	var_02 = 0.7;
	if(param_00 > 0)
	{
		scripts\cp\zombies\zombies_spawning::func_93E6(param_00);
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

		var_07 = scripts\cp\zombies\zombies_spawning::func_7C2E();
		var_07.var_93A8 = 1;
		var_07.var_A9F6 = gettime();
		thread scripts\cp\_utility::func_D52A("zombie_spawn_lightning",var_07.origin);
		for(var_08 = 0;var_08 < var_03.size;var_08++)
		{
			var_06 = var_03[var_08];
			var_09 = scripts\cp\zombies\zombies_spawning::func_772C(var_07.origin,var_07.angles);
			var_06.spawner = var_09;
			func_1B99(var_06.spawner);
			var_06 scripts\cp\zombies\zombies_spawning::func_BC94(var_06.spawner);
			var_06.ignoreme = 0;
			var_06.var_EF64 = 0;
			var_06 scripts\mp\agents\_scriptedagents::func_F85E(0,"spawn_in_box");
			var_09 = undefined;
			scripts\cp\zombies\zombies_spawning::func_4FB6(1);
			wait(randomfloatrange(var_01,var_02));
		}

		var_07.var_93A8 = 0;
	}
}

//Function Number: 13
func_1B99(param_00)
{
	var_01 = level._effect["goon_spawn_bolt"];
	playfx(var_01,param_00.origin);
	playfx(level._effect["drone_ground_spawn"],param_00.origin,(0,0,1));
	playrumbleonposition("grenade_rumble",param_00.origin);
	earthquake(0.3,0.2,param_00.origin,500);
}

//Function Number: 14
func_BC94(param_00)
{
	var_01 = getclosestpointonnavmesh(param_00.origin);
	self dontinterpolate();
	self setorigin(param_00.origin,1);
	self method_8286(param_00.origin);
	self.var_180 = 0;
}

//Function Number: 15
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

//Function Number: 16
func_10719(param_00)
{
	var_01 = "skater";
	var_02 = param_00.origin;
	var_03 = param_00.angles;
	var_04 = "axis";
	var_05 = scripts\mp\_mp_agent::func_108E8(var_01,var_04,var_02,var_03);
	if(isdefined(var_05))
	{
		update_respawn_data(var_01);
		var_05 method_84E6(4);
		param_00.var_A9F6 = gettime();
		var_05 thread scripts\cp\zombies\zombies_spawning::func_64E7(var_01);
		level notify("agent_spawned",var_05);
	}

	return var_05;
}

//Function Number: 17
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

//Function Number: 18
sasquatch_audio_monitor()
{
	level endon("game_ended");
	self endon("death");
	thread lib_0D62::func_CE9B(self.var_13550,undefined,1);
	self.var_D4AA = 0;
	for(;;)
	{
		var_00 = scripts\common\utility::waittill_any_timeout_1(6,"attack_hit","attack_miss","attack_charge");
		switch(var_00)
		{
			case "attack_hit":
				level thread lib_0D62::func_CE9C(self,"attack",0);
				break;
	
			case "attack_miss":
				level thread lib_0D62::func_CE9C(self,"attack",0);
				break;
	
			case "attack_charge":
				level thread lib_0D62::func_CE9C(self,"charge_grunt",0);
				break;
	
			case "timeout":
				level thread lib_0D62::func_CE9C(self,"idle_grunt",0);
				break;
		}
	}
}

//Function Number: 19
func_C1E9()
{
	var_00 = scripts\cp\zombies\zombies_spawning::func_C209();
	return var_00;
}

//Function Number: 20
func_7C2E()
{
	var_00 = undefined;
	var_00 = func_79EC();
	return var_00;
}

//Function Number: 21
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

//Function Number: 22
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

//Function Number: 23
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

//Function Number: 24
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

//Function Number: 25
move_goon_spawner(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getclosest(param_01,param_00,500);
	var_03.origin = param_02;
}

//Function Number: 26
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

//Function Number: 27
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

//Function Number: 28
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

//Function Number: 29
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

//Function Number: 30
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

//Function Number: 31
kvp_update_init()
{
	level.kvp_update_funcs["script_fxid"] = ::update_kvp_script_fxid;
}

//Function Number: 32
update_kvp_script_fxid(param_00,param_01)
{
	param_00.script_fxid = param_01;
	return param_00;
}

//Function Number: 33
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

//Function Number: 34
func_7999()
{
	var_00 = getentarray(self.var_27C,"script_noteworthy");
	if(isdefined(var_00) && var_00.size != 0)
	{
		self.var_665B = var_00;
	}
}

//Function Number: 35
func_4F1E()
{
	level endon("game_ended");
	var_00 = getdvarint("scr_spawn_start_delay");
	if(var_00 > 0)
	{
		wait(var_00);
	}
}

//Function Number: 36
func_1294D()
{
	foreach(var_01 in level.var_1647)
	{
		var_01.var_19 = 0;
		var_01 notify("dont_restart_spawner");
	}

	level.var_1647 = [];
}

//Function Number: 37
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

//Function Number: 38
should_spawn_skater()
{
	if(isdefined(level.no_clown_spawn))
	{
		return 0;
	}

	if(scripts\common\utility::flag("rk_fight_started"))
	{
		return 0;
	}

	if(isdefined(level.respawn_data))
	{
		if(level.respawn_data.type == "skater")
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

//Function Number: 39
func_726E()
{
	level notify("force_spawn_wave_done");
	wait(0.1);
	level.var_B467 = 0;
	level.var_B432 = 0;
	level.var_11046 = 1;
}

//Function Number: 40
func_5173(param_00)
{
	scripts\common\utility::waittill_any_3("death","emerge_done");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 41
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

//Function Number: 42
func_FF9D(param_00)
{
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
	else if(isdefined(level.should_run_event_func))
	{
		return [[ level.should_run_event_func ]](param_00);
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

//Function Number: 43
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

//Function Number: 44
func_7848(param_00)
{
	if(isdefined(level.available_event_func))
	{
		return [[ level.available_event_func ]](param_00);
	}

	return "goon";
}

//Function Number: 45
func_7B1C()
{
	return level.wave_num + 1;
}

//Function Number: 46
func_7D00(param_00,param_01)
{
	if(scripts\cp\_utility::is_escape_gametype())
	{
		return 1;
	}

	return 10;
}

//Function Number: 47
func_7CA9(param_00)
{
	var_01 = ["generic_zombie"];
	return var_01;
}

//Function Number: 48
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

//Function Number: 49
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

//Function Number: 50
func_7CFF(param_00)
{
	return 1;
}

//Function Number: 51
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

//Function Number: 52
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

//Function Number: 53
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

//Function Number: 54
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

//Function Number: 55
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

//Function Number: 56
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

//Function Number: 57
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
		case "superslasher":
		case "slasher":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 58
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

//Function Number: 59
func_EDF6()
{
	self dodamage(self.health + 950,self.origin,self,self,"MOD_SUICIDE");
}

//Function Number: 60
pausenormalwavespawning(param_00)
{
	scripts\common\utility::flag_set("pause_wave_progression");
	if(scripts\common\utility::istrue(param_00))
	{
		level.var_13FA3 = 1;
		return;
	}

	level.var_13FA3 = 0;
}

//Function Number: 61
setmaxstaticspawns(param_00,param_01,param_02)
{
	if(!isdefined(param_00))
	{
		param_00 = 16;
	}

	if(!isdefined(param_01))
	{
		param_01 = 24;
	}

	if(!isdefined(param_02))
	{
		param_02 = 24;
	}

	if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
	{
		level.var_B467 = param_00;
	}
	else
	{
		level.var_B467 = param_01;
	}

	level.var_5274 = 24;
}

//Function Number: 62
unpausenormalwavespawning()
{
	scripts\common\utility::func_6E2A("pause_wave_progression");
	level.var_13FA3 = 0;
}

//Function Number: 63
storewavespawningcounters()
{
	var_00 = spawnstruct();
	var_00.var_4632 = level.var_4632;
	var_00.var_4B6E = level.var_4B6E;
	var_00.var_B467 = level.var_B467;
	var_00.var_5274 = level.var_5274;
	var_00.wave_num = level.wave_num;
	level.storedspawncounters = var_00;
}

//Function Number: 64
restorewavespawningcounters()
{
	var_00 = level.storedspawncounters;
	if(level.wave_num == var_00.wave_num)
	{
		level.var_4B6E = var_00.var_4B6E;
		level.var_B467 = var_00.var_B467;
		level.var_5274 = var_00.var_5274;
	}
	else
	{
		level.var_4B6E = 0;
		level.var_B467 = func_7ACD(level.wave_num);
		level.var_5274 = func_7D10(level.wave_num);
	}

	level.storedspawncounters = undefined;
}

//Function Number: 65
waitforvalidwavepause()
{
	while(level.var_4B6E == level.var_5274)
	{
		wait(0.05);
	}
}

//Function Number: 66
unsetzombiemovespeed()
{
	level notify("unsetZombieMoveSpeed");
}

//Function Number: 67
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

//Function Number: 68
func_1887(param_00,param_01,param_02)
{
	param_00 endon("death");
	if(isdefined(param_00.agent_type) && param_00.agent_type == "ratking")
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

//Function Number: 69
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

//Function Number: 70
restorespawnvolumes()
{
	level notify("spawn_volumes_restored");
	foreach(var_01 in level.copy_active_spawn_volumes)
	{
		var_01 scripts\cp\zombies\zombies_spawning::func_B291();
	}

	level.copy_active_spawn_volumes = undefined;
}

//Function Number: 71
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

//Function Number: 72
setspecialevent()
{
	level.var_10942 = 1;
}

//Function Number: 73
unsetspecialevent()
{
	level.var_10942 = undefined;
}

//Function Number: 74
setspawndelayoverride(param_00)
{
	level.var_10847 = param_00;
}

//Function Number: 75
unsetspawndelayoverride(param_00)
{
	level.var_10847 = undefined;
}

//Function Number: 76
setwavenumoverride(param_00)
{
	level.var_13BD6 = param_00;
}

//Function Number: 77
unsetwavenumoverride(param_00)
{
	level.var_13BD6 = undefined;
}

//Function Number: 78
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
						if(!isdefined(level.var_4481["sally_end_round_8-12_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("sally_end_round_8-12_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["sally_end_round_8-12_1"] = 1;
						}
						break;

					case "p4_":
						if(!isdefined(level.var_4481["aj_end_round_8-12_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("aj_end_round_8-12_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["aj_end_round_8-12_1"] = 1;
						}
						break;

					case "p3_":
						if(!isdefined(level.var_4481["andre_end_round_8-12_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("andre_end_round_8-12_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["andre_end_round_8-12_1"] = 1;
						}
						break;

					case "p2_":
						if(!isdefined(level.var_4481["pdex_end_round_8-12_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("pdex_end_round_8-12_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["pdex_end_round_8-12_1"] = 1;
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

	if(var_01 >= 16 && var_01 <= 20)
	{
		if(randomint(100) > 60)
		{
			var_01 = scripts\common\utility::random(level.players);
			if(isdefined(var_01.var_134FD))
			{
				switch(var_01.var_134FD)
				{
					case "p1_":
						if(!isdefined(level.var_4481["sally_end_round_16-20_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("sally_end_round_16-20_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["sally_end_round_16-20_1"] = 1;
						}
						break;

					case "p4_":
						if(!isdefined(level.var_4481["aj_end_round_16-20_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("aj_end_round_16-20_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["aj_end_round_16-20_1"] = 1;
						}
						break;

					case "p3_":
						if(!isdefined(level.var_4481["andre_end_round_16-20_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("andre_end_round_16-20_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["andre_end_round_16-20_1"] = 1;
						}
						break;

					case "p2_":
						if(!isdefined(level.var_4481["pdex_end_round_16-20_1"]))
						{
							var_01 thread scripts\cp\_vo::try_to_play_vo("pdex_end_round_16-20_1","rave_dialogue_vo","highest",666,0,0,0,100);
							level.var_4481["pdex_end_round_16-20_1"] = 1;
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

	if(randomint(100) > 60)
	{
		if(isdefined(level.spoke_to_pam_first))
		{
			var_02 = level.spoke_to_pam_first;
			switch(var_02.var_134FD)
			{
				case "p1_":
					if(!isdefined(level.var_4481["sally_will_pam_fight_1"]))
					{
						var_02 thread scripts\cp\_vo::try_to_play_vo("sally_will_pam_fight_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["sally_will_pam_fight_1"] = 1;
					}
					break;

				case "p4_":
					if(!isdefined(level.var_4481["aj_will_pam_fight_1"]))
					{
						var_02 thread scripts\cp\_vo::try_to_play_vo("aj_will_pam_fight_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["aj_will_pam_fight_1"] = 1;
					}
					break;

				case "p3_":
					if(!isdefined(level.var_4481["andre_will_pam_fight_1"]))
					{
						var_02 thread scripts\cp\_vo::try_to_play_vo("andre_will_pam_fight_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["andre_will_pam_fight_1"] = 1;
					}
					break;

				case "p2_":
					if(!isdefined(level.var_4481["pdex_will_pam_fight_1"]))
					{
						var_02 thread scripts\cp\_vo::try_to_play_vo("pdex_will_pam_fight_1","rave_dialogue_vo","highest",666,0,0,0,100);
						level.var_4481["pdex_will_pam_fight_1"] = 1;
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