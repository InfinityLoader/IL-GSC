/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\cp_rave_spawning.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 57
 * Decompile Time: 2886 ms
 * Timestamp: 10/27/2023 12:08:47 AM
*******************************************************************/

//Function Number: 1
func_8453()
{
	level.agent_funcs["zombie_sasquatch"]["on_damaged"] = ::scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiedamaged;
	level.agent_funcs["zombie_sasquatch"]["gametype_on_damage_finished"] = ::lib_0CBC::func_C5CE;
	level.agent_funcs["zombie_sasquatch"]["gametype_on_killed"] = ::scripts\cp\maps\cp_rave\cp_rave_damage::cp_rave_onzombiekilled;
	if(!isdefined(level.zombie_sasquatch_vo_prefix))
	{
		level.zombie_sasquatch_vo_prefix = "zmb_vo_sasquatch_";
	}

	level.var_10E3C = func_79EB();
	level.var_5F7F = [];
	level.var_B467 = 24;
	level.var_B432 = 0;
	level.var_5274 = func_8455();
	level.var_4B6E = 0;
	func_1071B();
}

//Function Number: 2
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
	return ["sasquatch"];
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

	var_02 = min(param_00,1);
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
			var_06 thread scripts\mp\agents\zombie_sasquatch\zombie_sasquatch_agent::setup_eye_glow();
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
	var_01 = "zombie_sasquatch";
	var_02 = param_00.origin;
	var_03 = param_00.angles;
	var_04 = "axis";
	var_05 = scripts\mp\_mp_agent::func_108E8(var_01,var_04,var_02,var_03);
	if(isdefined(var_05))
	{
		var_05.var_13550 = level.zombie_sasquatch_vo_prefix;
		level thread lib_0D62::func_CE9C(var_05,"spawn",1);
		var_05 method_84E6(4);
		param_00.var_A9F6 = gettime();
		var_05 thread sasquatch_audio_monitor();
		var_05 thread scripts\cp\zombies\zombies_spawning::func_64E7(var_01);
		level notify("agent_spawned",var_05);
	}

	return var_05;
}

//Function Number: 17
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

//Function Number: 18
func_C1E9()
{
	var_00 = scripts\cp\zombies\zombies_spawning::func_C209();
	return var_00;
}

//Function Number: 19
func_7C2E()
{
	var_00 = undefined;
	var_00 = func_79EC();
	return var_00;
}

//Function Number: 20
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

//Function Number: 21
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

//Function Number: 22
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

//Function Number: 23
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

//Function Number: 24
move_goon_spawner(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getclosest(param_01,param_00,500);
	var_03.origin = param_02;
}

//Function Number: 25
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

//Function Number: 26
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

//Function Number: 27
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

//Function Number: 28
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

//Function Number: 29
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

//Function Number: 30
kvp_update_init()
{
	level.kvp_update_funcs["script_fxid"] = ::update_kvp_script_fxid;
}

//Function Number: 31
update_kvp_script_fxid(param_00,param_01)
{
	param_00.script_fxid = param_01;
	return param_00;
}

//Function Number: 32
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

//Function Number: 33
func_7999()
{
	var_00 = getentarray(self.var_27C,"script_noteworthy");
	if(isdefined(var_00) && var_00.size != 0)
	{
		self.var_665B = var_00;
	}
}

//Function Number: 34
func_4F1E()
{
	level endon("game_ended");
	var_00 = getdvarint("scr_spawn_start_delay");
	if(var_00 > 0)
	{
		wait(var_00);
	}
}

//Function Number: 35
func_1294D()
{
	foreach(var_01 in level.var_1647)
	{
		var_01.var_19 = 0;
		var_01 notify("dont_restart_spawner");
	}

	level.var_1647 = [];
}

//Function Number: 36
should_spawn_clown()
{
	if(isdefined(level.no_clown_spawn))
	{
		return 0;
	}

	if(isdefined(level.respawn_data))
	{
		if(level.respawn_data.type == "zombie_sasquatch")
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

	return 0;
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
func_726E()
{
	level notify("force_spawn_wave_done");
	wait(0.1);
	level.var_B467 = 0;
	level.var_B432 = 0;
	level.var_11046 = 1;
}

//Function Number: 39
func_5173(param_00)
{
	scripts\common\utility::waittill_any_3("death","emerge_done");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 40
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

//Function Number: 41
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

//Function Number: 42
func_7848(param_00)
{
	if(isdefined(level.available_event_func))
	{
		return [[ level.available_event_func ]](param_00);
	}

	return "goon";
}

//Function Number: 43
func_7B1C()
{
	return level.wave_num + 1;
}

//Function Number: 44
func_7D00(param_00,param_01)
{
	if(scripts\cp\_utility::is_escape_gametype())
	{
		return 1;
	}

	return 10;
}

//Function Number: 45
func_7CA9(param_00)
{
	var_01 = ["generic_zombie"];
	return var_01;
}

//Function Number: 46
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

//Function Number: 47
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

//Function Number: 48
func_7CFF(param_00)
{
	return 1;
}

//Function Number: 49
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

//Function Number: 50
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

//Function Number: 51
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

//Function Number: 52
cp_rave_cleanup_main()
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

//Function Number: 53
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

	return 1;
}

//Function Number: 54
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
	else
	{
		if(level.var_B789.size == 0)
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

		if(var_02)
		{
			var_05 = undefined;
			foreach(var_07 in level.var_1646)
			{
				if(self istouching(var_07))
				{
					var_05 = var_07;
					break;
				}
			}

			if(isdefined(var_05) && var_05.var_28AB == "island")
			{
				var_09 = lib_0D60::func_800B(var_05);
				if(var_09 == 0)
				{
					var_02 = 0;
				}
			}
		}
	}

	level.var_BE23++;
	if(!var_02 || !var_04)
	{
		var_0A = 10000000;
		var_0B = level.players[0];
		foreach(var_0D in level.players)
		{
			var_0E = distancesquared(self.origin,var_0D.origin);
			if(var_0E < var_0A)
			{
				var_0A = var_0E;
				var_0B = var_0D;
			}
		}

		if(isdefined(param_00))
		{
			var_10 = param_00;
		}
		else if(isdefined(var_0C) && scripts\cp\zombies\zombies_spawning::func_CF4C(var_0C))
		{
			var_10 = 189225;
		}
		else
		{
			var_10 = 250000;
		}

		if(var_0A >= var_10)
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

			thread func_51A5(var_0A,var_03);
		}
	}
}

//Function Number: 55
func_FF1A(param_00)
{
	if(!isdefined(param_00.agent_type))
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

//Function Number: 56
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

//Function Number: 57
func_EDF6()
{
	self dodamage(self.health + 950,self.origin,self,self,"MOD_SUICIDE");
}