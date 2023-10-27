/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\_powerups.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 78
 * Decompile Time: 2987 ms
 * Timestamp: 10/27/2023 12:23:44 AM
*******************************************************************/

//Function Number: 1
func_9670()
{
	func_DD64();
	func_96F6();
	func_96F7();
	func_96F5();
	level thread func_E1E6();
	level thread func_3DD5();
	level thread func_D7A1();
}

//Function Number: 2
func_D7A1()
{
	var_00 = getarraykeys(level.var_163F);
	for(;;)
	{
		level waittill("connected",var_01);
		foreach(var_03 in var_00)
		{
			if(scripts\common\utility::istrue(level.var_163F[var_03]))
			{
				if(isdefined(level.var_D762[var_03]))
				{
					thread [[ level.var_D762[var_03] ]](var_01);
				}
			}
		}
	}
}

//Function Number: 3
func_96F6()
{
	level._effect["pickup"] = loadfx("vfx/iw7/core/zombie/powerups/vfx_zom_powerup_pickup.vfx");
	level._effect["pickup_fnfmod"] = loadfx("vfx/iw7/core/zombie/powerups/vfx_zd_powerup_pickup.vfx");
	level._effect["big_explo"] = loadfx("vfx/iw7/_requests/coop/vfx_nuke_explosion_01.vfx");
}

//Function Number: 4
func_96F5()
{
	if(!isdefined(level.var_163F))
	{
		level.var_163F = [];
	}

	level.var_163F["instakill"] = 0;
	level.var_163F["double_money"] = 0;
	level.var_163F["fire_sale"] = 0;
	level.var_163F["infinite_ammo"] = 0;
	level.var_163F["infinite_grenades"] = 0;
	level.var_D762["instakill"] = ::func_20AC;
	level.var_D762["double_money"] = ::func_20A3;
	level.var_D762["infinite_ammo"] = ::func_20AA;
	level.var_D762["infinite_grenades"] = ::func_20AB;
	level.var_D762["fire_sale"] = ::func_20A5;
	if(!isdefined(level.var_D761))
	{
		level.var_D761 = 500;
	}

	if(!isdefined(level.var_D79E))
	{
		level.var_D79E = randomintrange(2000,3000);
	}

	if(!isdefined(level.var_D79F))
	{
		level.var_D79F = 5;
	}

	if(!isdefined(level.var_D79D))
	{
		level.var_D79D = 0;
	}

	if(!isdefined(level.var_EC22))
	{
		level.var_EC22 = level.var_D79E;
	}
}

//Function Number: 5
func_3DD5()
{
	level waittill("regular_wave_starting");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(!scripts\common\utility::istrue(var_01.var_3E06))
			{
				var_01.var_3E06 = 1;
				level.var_EC22 = level.var_EC22 + level.var_D761;
				if(var_01 scripts\cp\_utility::func_9BA0("more_power_up_drops"))
				{
					level.var_D79E = level.var_D79E - 5;
				}
			}
		}

		level waittill("player_spawned");
	}
}

//Function Number: 6
func_96F7()
{
	scripts\common\utility::flag_init("zombie_drop_powerups");
	scripts\common\utility::flag_init("fire_sale");
	scripts\common\utility::flag_init("canFiresale");
	scripts\common\utility::flag_init("explosive_armor");
	scripts\common\utility::flag_init("force_drop_max_ammo");
}

//Function Number: 7
func_E1E6()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("spawn_wave_done");
		level.var_D79D = 0;
	}
}

//Function Number: 8
func_DD64()
{
	level.var_B07F = [];
	level.var_B07B = [];
	level.var_B07D = [];
	level.var_B07E = [];
	if(isdefined(level.var_D763))
	{
		var_00 = level.var_D763;
	}
	else
	{
		var_00 = "cp/zombies/zombie_loot.csv";
	}

	for(var_01 = 1;var_01 <= 100;var_01++)
	{
		var_02 = func_113C5(var_00,var_01,2);
		if(scripts\cp\_utility::func_9BCC(var_02))
		{
			break;
		}

		var_03 = [];
		var_03["weights"] = func_45F6(func_113C5(var_00,var_01,3));
		var_03["weight_sum"] = func_7D76(var_03["weights"]);
		var_04 = strtok(func_113C5(var_00,var_01,4)," ");
		var_03["contents"] = [];
		foreach(var_08, var_06 in var_04)
		{
			var_07 = [];
			var_07["value"] = var_06;
			var_07["last_time"] = 0;
			var_03["contents"][var_08] = var_07;
		}

		level.var_B07F[var_02] = var_03;
	}

	for(var_01 = 101;var_01 <= 150;var_01++)
	{
		var_09 = func_113C5(var_00,var_01,2);
		if(scripts\cp\_utility::func_9BCC(var_09))
		{
			break;
		}

		var_0A = func_113C5(var_00,var_01,3);
		if(!isdefined(level._effect[var_0A]))
		{
			level._effect[var_0A] = loadfx(var_0A);
		}

		level.var_B07B[var_09] = var_0A;
		var_0B = func_113C5(var_00,var_01,1);
		level.var_B07E[var_09] = var_0B;
	}

	for(var_01 = 101;var_01 <= 150;var_01++)
	{
		var_09 = func_113C5(var_00,var_01,2);
		if(scripts\cp\_utility::func_9BCC(var_09))
		{
			break;
		}

		var_0C = func_113C5(var_00,var_01,4);
		if(scripts\cp\_utility::func_9BCC(var_0C))
		{
			continue;
		}

		level.var_B07D[var_09] = var_0C;
	}
}

//Function Number: 9
func_45F6(param_00)
{
	param_00 = strtok(param_00," ");
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01[var_02] = float(param_00[var_02]);
	}

	return var_01;
}

//Function Number: 10
func_7D76(param_00)
{
	var_01 = 0;
	foreach(var_03 in param_00)
	{
		var_01 = var_01 + var_03;
	}

	return var_01;
}

//Function Number: 11
drop_loot(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(param_02 == "none")
	{
		return 0;
	}

	param_00 = getclosestpointonnavmesh(param_00);
	var_06 = scripts\common\utility::istrue(param_03);
	var_07 = func_4918(param_00);
	if(!isdefined(var_07))
	{
		return 0;
	}

	var_07.fnf_consumable_active = 0;
	foreach(var_09 in level.players)
	{
		if(var_09 scripts\cp\_utility::func_9BA0("temporal_increase"))
		{
			var_07.fnf_consumable_active = 1;
			break;
		}
	}

	var_07.var_457C = param_02;
	var_0B = func_7AB9(var_07);
	var_07.var_763D = var_0B;
	var_0C = (0,0,0);
	if(isdefined(param_01) && param_01 scripts\cp\_utility::func_9BA0("more_power_up_drops"))
	{
		param_01 scripts\cp\_utility::func_C151("more_power_up_drops");
	}

	if(isdefined(param_04))
	{
		level.var_D79E = level.var_D79E * 1.14;
		level.var_EC22 = param_04 + level.var_D79E;
		level.var_D79D++;
		level.var_A8B4 = gettime();
	}

	if(!is_in_active_volume(param_00) && loot_fly_to_player_enabled())
	{
		param_00 = func_BCB7(var_07);
		var_07 thread func_B07C();
		var_06 = 1;
	}
	else
	{
		param_00 = param_00 + (0,0,50);
		if(scripts\common\utility::istrue(var_07.fnf_consumable_active))
		{
			var_07.fnffx = spawnfx(level._effect["powerup_additive_fx"],param_00 + (0,0,-10));
		}

		var_07.var_7542 = spawnfx(scripts\common\utility::getfx(var_0B),param_00);
		if(isdefined(var_0C))
		{
			var_07.var_7542.angles = var_0C;
		}
	}

	if(isdefined(param_01))
	{
		var_07.var_222 = param_01;
	}
	else
	{
		var_07.var_222 = level.players[0];
	}

	var_07 notify("activate");
	if(!var_06)
	{
		if(scripts\common\utility::istrue(var_07.fnf_consumable_active))
		{
			triggerfx(var_07.fnffx);
			var_07.fnffx method_82EC();
		}

		triggerfx(var_07.var_7542);
		var_07.var_7542 method_82EC();
		var_07 thread func_B07C();
	}

	var_07 thread func_B086(var_07);
	var_07 thread func_B096(var_07);
	var_0D = func_7A38(param_02);
	if(isdefined(var_0D) && scripts\common\utility::istrue(param_05))
	{
		func_12E16(var_0D);
	}

	level thread func_410D(var_07);
	return 1;
}

//Function Number: 12
loot_fly_to_player_enabled()
{
	if(scripts\common\utility::istrue(level.disable_loot_fly_to_player))
	{
		return 0;
	}

	return 1;
}

//Function Number: 13
func_BCB7(param_00)
{
	level endon("game_ended");
	param_00.var_7542 = spawn("script_model",param_00.origin + (0,0,50));
	param_00.var_7542 setmodel("tag_origin");
	wait(0.1);
	if(scripts\common\utility::istrue(param_00.fnf_consumable_active))
	{
		playfxontag(level._effect["powerup_additive_fx"],param_00.var_7542,"tag_origin");
	}

	playfxontag(scripts\common\utility::getfx(param_00.var_763D),param_00.var_7542,"tag_origin");
	var_01 = scripts\common\utility::getclosest(param_00.origin,level.players);
	var_02 = distance(param_00.origin,var_01.origin);
	var_03 = 300;
	var_04 = var_02 / var_03;
	if(var_04 < 0.05)
	{
		var_04 = 0.05;
	}

	var_05 = getclosestpointonnavmesh(scripts\common\utility::func_5D14(var_01.origin,32,-100)) + (0,0,50);
	param_00.var_7542 moveto(var_05,var_04);
	param_00.var_7542 waittill("movedone");
	param_00 dontinterpolate();
	param_00.origin = param_00.var_7542.origin;
	return param_00.origin;
}

//Function Number: 14
func_410D(param_00)
{
	param_00 scripts\common\utility::waittill_any_timeout_1(get_loot_time_out(),"picked_up");
	if(scripts\common\utility::istrue(param_00.fnf_consumable_active))
	{
		playfx(level._effect["pickup_fnfmod"],param_00.origin + (0,0,50));
	}
	else
	{
		playfx(level._effect["pickup"],param_00.origin + (0,0,50));
	}

	if(isdefined(param_00.var_7542))
	{
		param_00.var_7542 delete();
	}

	if(isdefined(param_00.fnffx))
	{
		param_00.fnffx delete();
	}

	wait(0.5);
	param_00.fnf_consumable_active = 0;
	if(isdefined(param_00))
	{
		param_00 delete();
	}

	param_00 notify("loot_deleted");
}

//Function Number: 15
func_B07C()
{
	self endon("death");
	self endon("picked_up");
	self endon("loot_deleted");
	var_00 = get_loot_time_out() - 5;
	wait(var_00);
	for(var_01 = 0;var_01 < 5;var_01++)
	{
		wait(0.5);
		self.var_7542 delete();
		wait(0.5);
		var_02 = func_7AB9(self);
		var_03 = scripts\common\utility::getfx(var_02);
		if(!isdefined(var_03))
		{
			continue;
		}

		self.var_7542 = spawnfx(var_03,self.origin + (0,0,50));
		self.var_7542.angles = (0,0,0);
		wait(0.1);
		triggerfx(self.var_7542);
		self.var_7542 method_82EC();
	}

	if(isdefined(self) && isdefined(self.var_7542))
	{
		self.var_7542 delete();
	}

	if(isdefined(self) && isdefined(self.fnffx))
	{
		self.fnffx delete();
	}
}

//Function Number: 16
get_loot_time_out()
{
	if(isdefined(level.loot_time_out))
	{
		return level.loot_time_out;
	}

	return 30;
}

//Function Number: 17
func_7A38(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "kill_generic_zombie";
	}

	var_02 = 0;
	var_03 = level.var_B07F[param_01]["contents"].size;
	for(var_02 = 0;var_02 < var_03;var_02++)
	{
		if(level.var_B07F[param_01]["contents"][var_02]["value"] == param_00)
		{
			return var_02;
		}
	}

	return 0;
}

//Function Number: 18
func_B978(param_00)
{
	self endon("loot_deleted");
	level endon("game_ended");
	while(isdefined(param_00) && isdefined(param_00.health) && param_00.health >= 1)
	{
		level waittill("attack_hit",var_01,var_02);
		if(param_00 != var_02)
		{
			continue;
		}

		param_00.health = param_00.health - 50;
	}

	self notify("picked_up");
}

//Function Number: 19
func_4918(param_00)
{
	var_01 = scripts\common\utility::func_5D14(param_00,32,-64);
	var_02 = spawn("trigger_radius",var_01,0,32,76);
	return var_02;
}

//Function Number: 20
func_7AB9(param_00)
{
	if(!isdefined(level.var_B07B[param_00.var_457C]))
	{
		return "vfx_loot_ace_hearts";
	}

	return level.var_B07B[param_00.var_457C];
}

//Function Number: 21
func_B096(param_00)
{
	param_00 endon("loot_deleted");
	var_01 = param_00 scripts\common\utility::waittill_any_timeout_1(get_loot_time_out(),"picked_up");
	if(var_01 == "picked_up")
	{
		thread func_D980(param_00.var_222,param_00.var_457C,param_00,1);
	}
}

//Function Number: 22
func_B086(param_00)
{
	param_00 endon("loot_deleted");
	wait(0.2);
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			wait(0.25);
			continue;
		}

		param_00 notify("picked_up");
		var_01 playlocalsound("zmb_powerup_activate");
		break;
	}
}

//Function Number: 23
func_D980(param_00,param_01,param_02,param_03)
{
	var_04 = param_01;
	param_01 = strtok(param_01,"_");
	var_05 = param_01[0];
	var_06 = param_01[1];
	var_07 = gettime();
	var_08 = int(level.var_B07E[var_04]);
	var_09 = 1;
	func_56C3(0);
	switch(var_05)
	{
		case "power":
			level thread [[ level.var_D743 ]](var_04,var_07);
			break;

		case "fire":
			if(isdefined(level.var_6D28))
			{
				if(isdefined(level.temporal_increase))
				{
					var_06 = int(var_06) * level.temporal_increase;
				}
	
				level thread scripts\cp\_vo::try_to_play_vo("powerup_firesale","zmb_powerup_vo");
				param_02 playsound("zmb_powerup_fire_sale");
				level thread [[ level.var_6D28 ]](var_04,int(var_06),var_07);
			}
			break;

		case "grenade":
			if(isdefined(level.temporal_increase))
			{
				var_06 = int(var_06) * level.temporal_increase;
			}
	
			level thread scripts\cp\_vo::try_to_play_vo("powerup_infinitegrenades","zmb_powerup_vo");
			param_02 playsound("zmb_powerup_infinite_grenades");
			level thread func_82DA(var_04,int(var_06),var_07);
			break;

		case "infinite":
			if(isdefined(level.temporal_increase))
			{
				var_06 = int(var_06) * level.temporal_increase;
			}
	
			level thread scripts\cp\_vo::try_to_play_vo("powerup_infiniteammo","zmb_powerup_vo");
			param_02 playsound("zmb_powerup_infinite_ammo");
			level thread func_82D9(var_04,int(var_06),var_07);
			break;

		case "upgrade":
			if(isdefined(level.var_12F74))
			{
				param_02 playsound("zmb_powerup_wpn_upgrade");
				level thread [[ level.var_12F74 ]]();
			}
			break;

		case "kill":
			if(scripts\common\utility::istrue(level.var_72AA))
			{
				var_09 = 0;
				level thread func_A5C6(param_02,int(var_06));
			}
			else
			{
				level thread scripts\cp\_vo::try_to_play_vo("powerup_nuke","zmb_powerup_vo");
				param_02 playsound("zmb_powerup_nuke");
				level thread func_A5C6(param_02,int(var_06));
			}
			break;

		case "cash":
			level thread scripts\cp\_vo::try_to_play_vo("powerup_doublemoney","zmb_powerup_vo");
			param_02 playsound("zmb_powerup_dbl_cash");
			level thread func_EBA5(param_00,var_04,int(var_06),var_07);
			break;

		case "instakill":
			if(isdefined(level.temporal_increase))
			{
				var_06 = int(var_06) * level.temporal_increase;
			}
	
			level thread scripts\cp\_vo::try_to_play_vo("powerup_instakill","zmb_powerup_vo");
			param_02 playsound("zmb_powerup_instakill");
			level thread func_15BB(param_00,var_04,int(var_06),var_07);
			break;

		case "ammo":
			level thread scripts\cp\_vo::try_to_play_vo("powerup_maxammo","zmb_powerup_vo");
			param_02 playsound("zmb_powerup_max_ammo");
			level notify("pick_up_max_ammo");
			level thread func_829A();
			break;

		case "board":
			if(isdefined(level.var_DDB5))
			{
				level thread scripts\cp\_vo::try_to_play_vo("powerup_carpenter","zmb_powerup_vo");
				param_02 playsound("zmb_powerup_reboard_windows");
				level thread [[ level.var_DDB5 ]](param_00);
			}
			break;

		default:
			break;
	}

	if(scripts\common\utility::istrue(param_03))
	{
		param_00 scripts\cp\_merits::func_D9AD("mt_powerup_grabs");
	}

	param_00 thread scripts\cp\_hud_message::func_12AAE("powerups");
	scripts\common\utility::func_136F7();
	if(var_09)
	{
		func_56C3(var_08);
	}
}

//Function Number: 24
func_7AB8(param_00,param_01,param_02)
{
	if(!isdefined(level.var_B07F[param_00]))
	{
		return undefined;
	}

	var_03 = gettime();
	var_04 = func_3E8B(param_00,var_03,param_01);
	return var_04;
}

//Function Number: 25
func_3E8B(param_00,param_01,param_02)
{
	var_03 = level.wave_num;
	var_04 = level.var_B07F[param_00]["contents"].size;
	level.var_1C86 = [];
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		var_06 = level.var_B07F[param_00]["contents"][var_05]["value"];
		var_07 = level.var_B07F[param_00]["contents"][var_05]["last_time"];
		var_06 = strtok(var_06,"_");
		var_08 = var_06[0];
		switch(var_08)
		{
			case "fire":
				if((scripts\common\utility::istrue(level.var_D760) || scripts\common\utility::flag("canFiresale") && param_01 - var_07 >= 180000) && var_03 >= 5)
				{
					level.var_1C86[level.var_1C86.size] = var_05;
					break;
				}
				else
				{
					break;
				}
	
				break;

			case "explosive":
				if((scripts\common\utility::istrue(level.var_D760) || param_01 - var_07 >= 300000) && var_03 >= 8)
				{
					level.var_1C86[level.var_1C86.size] = var_05;
					break;
				}
				else
				{
					break;
				}
	
				break;

			case "infinite":
				if((scripts\common\utility::istrue(level.var_D760) || param_01 - var_07 >= 180000) && var_03 >= 5)
				{
					level.var_1C86[level.var_1C86.size] = var_05;
					break;
				}
				else
				{
					break;
				}
	
				break;

			case "ammo":
				if((scripts\common\utility::istrue(level.var_D760) || param_01 - var_07 >= 180000) && var_03 >= 2)
				{
					level.var_1C86[level.var_1C86.size] = var_05;
					break;
				}
				else
				{
					break;
				}
	
				break;

			case "grenade":
				if((scripts\common\utility::istrue(level.var_D760) || param_01 - var_07 >= -5536) && var_03 >= 1)
				{
					level.var_1C86[level.var_1C86.size] = var_05;
					break;
				}
				else
				{
					break;
				}
	
				break;

			case "upgrade":
				if((scripts\common\utility::istrue(level.var_D760) || param_01 - var_07 >= 600000) && var_03 >= 15)
				{
					if(!scripts\cp\_utility::is_codxp())
					{
						level.var_1C86[level.var_1C86.size] = var_05;
					}
	
					break;
				}
				else
				{
					break;
				}
	
				break;

			case "kill":
				if((scripts\common\utility::istrue(level.var_D760) || param_01 - var_07 >= 180000) && var_03 >= 1)
				{
					level.var_1C86[level.var_1C86.size] = var_05;
					break;
				}
				else
				{
					break;
				}
	
				break;

			case "cash":
				if((scripts\common\utility::istrue(level.var_D760) || param_01 - var_07 >= 90000) && var_03 >= 1)
				{
					level.var_1C86[level.var_1C86.size] = var_05;
					break;
				}
				else
				{
					break;
				}
	
				break;

			case "instakill":
				if((scripts\common\utility::istrue(level.var_D760) || param_01 - var_07 >= 90000) && var_03 >= 1)
				{
					level.var_1C86[level.var_1C86.size] = var_05;
					break;
				}
				else
				{
					break;
				}
	
				break;

			case "board":
				if((scripts\common\utility::istrue(level.var_D760) || param_01 - var_07 >= -20536) && var_03 >= 1)
				{
					level.var_1C86[level.var_1C86.size] = var_05;
					break;
				}
				else
				{
					break;
				}
	
				break;

			default:
				break;
		}
	}

	if(level.var_1C86.size < 1)
	{
		return undefined;
	}

	var_09 = level.var_1C86[func_7ABA(param_00)];
	var_0A = level.var_B07F[param_00]["contents"][var_09]["value"];
	level.var_1C86 = undefined;
	level.var_A8E0 = var_09;
	return var_0A;
}

//Function Number: 26
func_7ABA(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.var_1C86.size;var_02++)
	{
		var_03 = int(level.var_1C86[var_02]);
		var_01 = var_01 + level.var_B07F[param_00]["weights"][var_03];
	}

	var_04 = randomfloat(var_01);
	var_05 = 0;
	for(var_02 = 0;var_02 < level.var_1C86.size;var_02++)
	{
		var_03 = int(level.var_1C86[var_02]);
		var_05 = var_05 + level.var_B07F[param_00]["weights"][var_03];
		if(var_05 >= var_04)
		{
			return var_02;
		}
	}
}

//Function Number: 27
func_113C5(param_00,param_01,param_02)
{
	return tablelookup(param_00,0,param_01,param_02);
}

//Function Number: 28
func_12DB8(param_00,param_01,param_02)
{
	if(!scripts\cp\_utility::func_462B("loot"))
	{
		return;
	}

	if(!isdefined(level.var_B07A))
	{
		return;
	}

	if(!scripts\common\utility::flag("zombie_drop_powerups"))
	{
		return;
	}

	if(!isplayer(param_02))
	{
		return;
	}

	var_04 = scripts\common\utility::istrue(level.var_D760);
	if(level.var_D79D >= level.var_D79F && !var_04)
	{
		return;
	}

	if(!is_in_active_volume(param_01))
	{
		return;
	}

	if(scripts\common\utility::istrue(self.var_9CDD))
	{
		return;
	}

	if(isdefined(level.var_9B0B))
	{
		if(!scripts\cp\_weapon::func_9E54(param_01,level.var_9B0B,undefined,undefined,1))
		{
			return;
		}
	}
	else if(!scripts\cp\_weapon::func_9E54(param_01,undefined,undefined,undefined,1))
	{
		return;
	}

	var_05 = level.players;
	var_03 = undefined;
	var_06 = 0;
	if(param_02 scripts\cp\_utility::func_9BA0("more_power_up_drops"))
	{
		var_07 = level.var_EC22 * 0.7;
	}
	else
	{
		var_07 = level.var_EC22;
	}

	for(var_08 = 0;var_08 < var_05.size;var_08++)
	{
		if(isdefined(var_05[var_08].var_11A21))
		{
			var_06 = var_06 + var_05[var_08].var_11A21;
		}
	}

	var_09 = 0;
	if(var_06 > var_07 && !var_09)
	{
		var_03 = func_7AB8("kill_" + param_00,param_01);
	}

	if(isdefined(var_03))
	{
		level thread drop_loot(param_01,param_02,var_03,undefined,var_06,1);
	}
}

//Function Number: 29
func_12E16(param_00)
{
	var_01 = gettime();
	level.var_B07F["kill_generic_zombie"]["contents"][param_00]["last_time"] = var_01;
}

//Function Number: 30
func_82C4(param_00,param_01,param_02)
{
	level endon("game_ended");
	level endon("deactivated" + param_00);
	scripts\common\utility::flag_set("explosive_armor");
	level thread func_4DB3(param_00,param_01);
	level thread func_CFD5(param_00,::func_8300);
	level thread func_D2C6(param_00,::func_8300);
	level thread func_82C6(param_00,::func_8300);
	level.var_69FA = 1;
	foreach(var_04 in level.players)
	{
		if(!isalive(var_04) || scripts\common\utility::istrue(var_04.inlaststand))
		{
			continue;
		}

		if(!scripts\common\utility::istrue(var_04.var_8B7A))
		{
			thread func_8300(var_04,param_00);
		}
	}
}

//Function Number: 31
func_8300(param_00,param_01)
{
	param_00.var_8B7A = 1;
	param_00 thread func_D73B(undefined,param_01);
	param_00 thread func_48DE();
	param_00 thread func_4CEC();
	param_00 thread func_E00B(param_01);
	param_00 thread func_E00C(param_00);
}

//Function Number: 32
func_CFD5(param_00,param_01)
{
	level endon("deactivated" + param_00);
	level endon("game_ended");
	while(scripts\common\utility::flag("explosive_armor"))
	{
		level waittill("connected",var_02);
		thread [[ param_01 ]](var_02,param_00);
	}
}

//Function Number: 33
func_D2C6(param_00,param_01)
{
	level endon("deactivated" + param_00);
	level endon("game_ended");
	while(scripts\common\utility::flag("explosive_armor"))
	{
		level waittill("player_spawned",var_02);
		thread [[ param_01 ]](var_02,param_00);
	}
}

//Function Number: 34
func_82C6(param_00,param_01)
{
	level endon("deactivated" + param_00);
	level endon("game_ended");
	while(scripts\common\utility::flag("explosive_armor"))
	{
		level waittill("revive_success",var_02);
		thread [[ param_01 ]](var_02,param_00);
	}
}

//Function Number: 35
func_E00B(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("last_stand");
	scripts\common\utility::func_6E5A("explosive_armor");
	self.var_8B7A = undefined;
	self setscriptablepartstate("exp_touch","neutral",0);
	self notify("explosive_armor_removed");
	self notify("remove_power_icon" + param_00);
}

//Function Number: 36
func_E00C(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("explosive_armor_removed");
	param_00 scripts\common\utility::waittill_any_3("death","last_stand");
	param_00.var_8B7A = undefined;
	param_00 setscriptablepartstate("exp_touch","neutral",0);
	param_00 notify("explosive_armor_removed");
}

//Function Number: 37
func_4DB3(param_00,param_01)
{
	level endon("disconnect");
	level endon("game_ended");
	param_01 = param_01 - 5.5;
	scripts\common\utility::waittill_any_timeout_1(param_01,"deactivated" + param_00);
	level notify("deactivated" + param_00);
	wait(5.5);
	scripts\common\utility::func_6E2A("explosive_armor");
	level.var_69FA = undefined;
	foreach(var_03 in level.players)
	{
		var_03.var_8B7A = undefined;
	}
}

//Function Number: 38
func_4CEC()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("last_stand");
	self endon("explosive_armor_removed");
	for(var_00 = gettime();scripts\common\utility::flag("explosive_armor");var_00 = gettime())
	{
		var_01 = scripts\common\utility::func_782F(self.origin,level.spawned_enemies,undefined,undefined,128,1);
		foreach(var_03 in var_01)
		{
			if(isalive(var_03))
			{
				if(!isdefined(var_03.var_69FB) || gettime() > var_03.var_69FB)
				{
					var_03.var_69FB = var_00 + 1000;
					var_03 dodamage(100,self.origin,self,self,"MOD_UNKNOWN","power_script_generic_primary_mp");
				}
			}
		}

		wait(0.25);
	}
}

//Function Number: 39
func_48DE()
{
	self endon("disconnect");
	level endon("game_ended");
	self setscriptablepartstate("exp_touch","on",0);
}

//Function Number: 40
func_C771(param_00,param_01,param_02)
{
	level endon("deactivated" + param_00);
	level thread func_4DCA(param_00,param_01);
	level thread func_C76B(param_00);
	for(;;)
	{
		foreach(var_04 in level.players)
		{
			if(!scripts\common\utility::istrue(var_04.var_8B97))
			{
				var_04.var_8B97 = 1;
				var_05 = param_01 - gettime() - param_02 / 1000;
				var_04 thread func_D73B(var_05,param_00);
			}
		}

		wait(0.25);
	}
}

//Function Number: 41
func_C76B(param_00)
{
	level endon("game_ended");
	level endon("host_migration_begin");
	level endon("deactivated" + param_00);
	for(;;)
	{
		var_01 = scripts\cp\_agent_utils::func_7DB0("axis");
		foreach(var_04, var_03 in var_01)
		{
			if(!isalive(var_03))
			{
				wait(0.2);
				continue;
			}

			if(isdefined(var_03.var_4D32))
			{
				wait(0.2);
				continue;
			}

			if(isdefined(var_03.var_B36D))
			{
				wait(0.2);
				continue;
			}

			if(isdefined(var_03.var_B36A))
			{
				wait(0.2);
				continue;
			}

			if(isdefined(var_03.var_6BD4))
			{
				wait(0.2);
				continue;
			}

			scripts\cp\_outline::func_6221(var_03,level.players,4,0,0,"high");
			if(var_04 % 2 == 0)
			{
				wait(0.05);
			}
		}

		wait(0.2);
	}
}

//Function Number: 42
func_4DCA(param_00,param_01)
{
	level endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_timeout_1(param_01,"deactivated" + param_00);
	level notify("deactivated" + param_00);
	foreach(var_03 in level.players)
	{
		var_03.var_8B97 = undefined;
		var_03 scripts\cp\_outline::func_12C01();
	}
}

//Function Number: 43
func_82DA(param_00,param_01,param_02)
{
	level notify("activated" + param_00);
	level endon("activated" + param_00);
	level endon("deactivated" + param_00);
	level notify("infinite_grenade_active");
	level.var_94A8 = 1;
	level thread func_4DBA(param_00,param_01);
	level.var_163F["infinite_grenades"] = 1;
	foreach(var_04 in level.players)
	{
		thread func_20AB(var_04);
	}
}

//Function Number: 44
func_20A5(param_00)
{
	if(isdefined(level.temporal_increase))
	{
		param_00 thread func_D73B(30 * level.temporal_increase,"fire_30");
		return;
	}

	param_00 thread func_D73B(30,"fire_30");
}

//Function Number: 45
func_20AB(param_00)
{
	param_00.var_D721 = 1;
	param_00.var_8B89 = 1;
	param_00 scripts\cp\powers\coop_powers::func_D71A(1,"primary",1);
	if(isdefined(level.temporal_increase))
	{
		param_00 thread func_D73B(30 * level.temporal_increase,"grenade_30");
		return;
	}

	param_00 thread func_D73B(30,"grenade_30");
}

//Function Number: 46
func_4DBA(param_00,param_01)
{
	level endon("disconnect");
	level endon("game_ended");
	var_02 = scripts\common\utility::waittill_any_timeout_1(param_01,"deactivated" + param_00,"activated" + param_00);
	if(var_02 != "activated" + param_00)
	{
		level.var_163F["infinite_grenades"] = 0;
		level notify("deactivated" + param_00);
		foreach(var_04 in level.players)
		{
			var_04 scripts\cp\powers\coop_powers::func_D71A(undefined,"primary",1);
			var_04.var_8B89 = undefined;
			var_04.var_D721 = 0;
		}

		level.var_94A8 = undefined;
	}
}

//Function Number: 47
func_82D9(param_00,param_01,param_02)
{
	level notify("activated" + param_00);
	level endon("activated" + param_00);
	level endon("deactivated" + param_00);
	level notify("infinite_ammo_active");
	level.var_94A4 = 1;
	level.var_163F["infinite_ammo"] = 1;
	level thread func_4DB9(param_00,param_01);
	foreach(var_04 in level.players)
	{
		thread func_20AA(var_04);
	}
}

//Function Number: 48
func_20AA(param_00)
{
	param_00 thread scripts\cp\_vo::try_to_play_vo("powerup_ammo","zmb_comment_vo");
	param_00.var_8B88 = 1;
	var_01 = param_00 func_1E39();
	param_00 thread func_12BA6(var_01,"infinite_20");
	if(isdefined(level.temporal_increase))
	{
		param_00 thread func_D73B(20 * level.temporal_increase,"infinite_20");
		return;
	}

	param_00 thread func_D73B(20,"infinite_20");
}

//Function Number: 49
func_4DB9(param_00,param_01)
{
	level endon("disconnect");
	level endon("game_ended");
	var_02 = scripts\common\utility::waittill_any_timeout_1(param_01,"deactivated" + param_00,"activated" + param_00);
	if(var_02 != "activated" + param_00)
	{
		level.var_163F["infinite_ammo"] = 0;
		level.var_94A4 = undefined;
		level notify("deactivated" + param_00);
		foreach(var_04 in level.players)
		{
			var_04.var_8B88 = undefined;
		}
	}

	foreach(var_04 in level.players)
	{
		if(var_04 scripts\cp\_utility::isinfiniteammoenabled())
		{
			var_04 scripts\cp\_utility::enable_infinite_ammo(0);
		}
	}
}

//Function Number: 50
func_82E2(param_00,param_01,param_02)
{
	level endon("deactivated" + param_00);
	level endon("disconnect");
	level endon("game_ended");
	var_03 = undefined;
	level.var_F0B8 = 1;
	var_04 = scripts\common\utility::random(["power_speedBoost","power_siegeMode","power_barrier","power_mortarMount","power_transponder"]);
	for(;;)
	{
		foreach(var_06 in level.players)
		{
			if(!scripts\common\utility::istrue(var_06.var_8B8C))
			{
				var_06.var_8B8C = 1;
				var_07 = param_01 - gettime() - param_02 / 1000;
				var_03 = var_06 scripts\cp\powers\coop_powers::func_13CFC("secondary");
				var_06 thread scripts\cp\powers\coop_powers::func_8397(var_04,"secondary",undefined,undefined,undefined,undefined,1);
				var_06 scripts\cp\powers\coop_powers::func_D740(10,"secondary");
				var_06 thread func_17D4(param_00,var_07);
				var_06 thread func_D73B(var_07,param_00);
				var_06 thread func_4DC4(var_07,var_03,var_04,param_00);
			}
		}

		wait(0.25);
	}
}

//Function Number: 51
func_17D4(param_00,param_01)
{
	level endon("deactivated" + param_00);
	level endon("disconnect");
	level endon("game_ended");
	self endon("disconnect");
	self endon("lb_power_used");
	self.var_17D5 = 0;
	var_02 = param_01 / 3;
	self notifyonplayercommand("lb_power_used","+speed_throw");
	while(self.var_17D5 > 3)
	{
		if(!isalive(self))
		{
			wait(0.5);
			continue;
		}

		scripts\cp\_utility::setlowermessage("msg_axe_hint",&"CP_ZOMBIE_ADD_ABILITY__HINT",5);
		self.var_17D5++;
		wait(var_02);
	}
}

//Function Number: 52
func_4DC4(param_00,param_01,param_02,param_03)
{
	level endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_timeout_1(param_00,"deactivated" + param_03);
	self.var_8B8C = undefined;
	self.var_17D5 = undefined;
	level.var_F0B8 = undefined;
	level notify("deactivated" + param_03);
	scripts\cp\powers\coop_powers::func_E15E(param_02);
	if(isdefined(param_01))
	{
		thread scripts\cp\powers\coop_powers::func_8397(param_01,"secondary",undefined,undefined,undefined,undefined,0);
	}
}

//Function Number: 53
func_829A()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		if(scripts\cp\_laststand::player_in_laststand(var_01))
		{
			continue;
		}

		give_max_ammo_to_player(var_01);
	}
}

//Function Number: 54
give_max_ammo_to_player(param_00)
{
	var_01 = param_00 getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		var_04 = strtok(var_03,"_");
		if(var_04[0] != "alt")
		{
			param_00 givemaxammo(var_03);
		}

		if(function_0249(var_03) == weaponclipsize(var_03))
		{
			param_00 setweaponammoclip(var_03,weaponclipsize(var_03));
		}
	}

	var_06 = getarraykeys(param_00.var_D782);
	foreach(var_08 in var_06)
	{
		if(param_00.var_D782[var_08].var_10307 == "secondary")
		{
			continue;
		}

		param_00 thread func_DDD1(var_08);
	}
}

//Function Number: 55
func_DDD1(param_00)
{
	var_01 = 0;
	var_02 = self.var_D782[param_00].var_10307;
	var_03 = level.var_D782[param_00].var_B486 - self.var_D782[param_00].var_3D23;
	scripts\cp\powers\coop_powers::func_D71A(var_03,var_02);
	self setweaponammostock(level.var_D782[param_00].var_13CE0,level.var_D782[param_00].var_B486);
}

//Function Number: 56
func_15BB(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	level notify("activated" + param_01);
	level endon("deactivated" + param_01);
	level.var_9925 = 1;
	level thread func_4DBB(param_01,param_02);
	level.var_163F["instakill"] = 1;
	foreach(var_05 in level.players)
	{
		thread func_20AC(var_05);
	}
}

//Function Number: 57
func_20AC(param_00)
{
	param_00.var_9926 = 1;
	if(isdefined(level.temporal_increase))
	{
		param_00 thread func_D73B(30 * level.temporal_increase,"instakill_30");
		return;
	}

	param_00 thread func_D73B(30,"instakill_30");
}

//Function Number: 58
func_4DBB(param_00,param_01)
{
	level endon("game_ended");
	level endon("activated" + param_00);
	scripts\common\utility::waittill_any_timeout_1(param_01,"deactivated" + param_00);
	level notify("deactivated" + param_00);
	foreach(var_03 in level.players)
	{
		var_03.var_9926 = undefined;
	}

	level.var_9925 = undefined;
	level.var_163F["instakill"] = 0;
}

//Function Number: 59
func_EBA5(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	level endon("deactivated" + param_01);
	level notify("scale_earned_cash");
	level endon("scale_earned_cash");
	level.var_163F["double_money"] = 1;
	level.var_3B0F = 2;
	if(isdefined(level.temporal_increase))
	{
		level thread func_4DCD(param_01,30 * level.temporal_increase,param_02);
	}
	else
	{
		level thread func_4DCD(param_01,30,param_02);
	}

	foreach(var_05 in level.players)
	{
		thread func_20A3(var_05);
	}
}

//Function Number: 60
func_20A3(param_00)
{
	param_00.var_5AD6 = 1;
	if(isdefined(level.temporal_increase))
	{
		param_00 thread func_D73B(30 * level.temporal_increase,"cash_2");
		return;
	}

	param_00 thread func_D73B(30,"cash_2");
}

//Function Number: 61
func_4DCD(param_00,param_01,param_02)
{
	level endon("disconnect");
	level endon("game_ended");
	var_03 = scripts\common\utility::waittill_any_timeout_1(param_01,"deactivated" + param_00,"activated" + param_00);
	if(var_03 != "activated" + param_00)
	{
		level notify("deactivated" + param_00);
		level.var_3B0F = 1;
		level.var_163F["double_money"] = 0;
		foreach(var_05 in level.players)
		{
			var_05.var_5AD6 = undefined;
		}
	}
}

//Function Number: 62
func_D73B(param_00,param_01)
{
	level notify("power_icon_active_" + param_01);
	level endon("power_icon_active_" + param_01);
	var_02 = level.var_B07D[param_01];
	self.var_D7A0[param_01] = var_02;
	var_03 = func_F5DD(param_01);
	thread func_8EA0(param_00,param_01,var_03);
}

//Function Number: 63
func_F5DD(param_00)
{
	var_01 = int(tablelookup(level.var_D763,2,param_00,1));
	var_02 = int(var_01);
	self setclientomnvarbit("zm_active_powerups",var_02 - 1,1);
	return var_02;
}

//Function Number: 64
func_56C3(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 setclientomnvar("zm_powerup_activated",param_00);
		wait(0.05);
	}
}

//Function Number: 65
func_79E0(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_06 = scripts\common\utility::getstructarray(param_01,param_02);
	var_06[var_06.size] = param_00;
	foreach(var_08 in var_06)
	{
		var_09 = scripts\common\utility::func_782F(var_08.origin,level.players,undefined,1,param_04,1);
		if(var_09.size >= 1)
		{
			if(!isdefined(var_08.angles))
			{
				var_08.angles = (0,0,0);
			}

			var_0A = scripts\common\utility::spawn_tag_origin(var_08.origin,var_08.angles);
			var_0A show();
			var_0A.origin = var_08.origin;
			var_0A.angles = var_08.angles;
			var_05[var_05.size] = var_0A;
			if(isdefined(param_03))
			{
				if(var_05.size >= param_03)
				{
					break;
				}
			}
		}
	}

	var_05 = sortbydistance(var_05,param_00.origin);
	return var_05;
}

//Function Number: 66
func_A5C6(param_00,param_01)
{
	level endon("game_ended");
	var_02 = param_00.origin;
	var_03 = func_79E0(param_00,"effect_loc","targetname",undefined,1500);
	wait(1);
	playsoundatpos(var_02,"zmb_powerup_nuke_explo");
	level thread func_C1AC(param_00,var_03);
	scripts\common\utility::func_136F7();
	playrumbleonposition("heavy_3s",var_02);
	earthquake(0.25,4,var_02,2500);
	scripts\common\utility::func_136F7();
	var_04 = scripts\cp\_agent_utils::func_7DB0("axis");
	foreach(var_06 in level.players)
	{
		var_06 scripts\cp\_utility::func_17C0("nuke",0,0);
	}

	var_08 = sortbydistance(var_04,var_02);
	var_09 = 400;
	if(isdefined(level.var_3B0F))
	{
		var_09 = 400 * level.var_3B0F;
	}

	foreach(var_0B in var_08)
	{
		if(func_9C0C(var_0B))
		{
			continue;
		}

		if(scripts\common\utility::istrue(level.var_72AA))
		{
			var_0B.var_54CB = 1;
			var_0B.died_poorly_health = var_0B.health;
		}

		if(scripts\common\utility::istrue(var_0B.var_9E0C))
		{
			var_0B dodamage(var_0B.health + 100,var_0B.origin);
		}
		else
		{
			var_0B.var_180 = 1;
			var_0B.var_9B81 = 1;
			var_0B.nocorpse = undefined;
			var_0B thread func_A614(1);
		}

		wait(0.1);
	}

	level.nuke_zombies_paused = 1;
	wait(5);
	level.nuke_zombies_paused = 0;
	level.dont_resume_wave_after_solo_afterlife = undefined;
	foreach(var_06 in level.players)
	{
		var_06 scripts\cp\_utility::func_E0E6("nuke",0);
		if(!scripts\common\utility::istrue(level.var_72AA))
		{
			if(!scripts\cp\_laststand::player_in_laststand(var_06))
			{
				var_06 scripts\cp\_persistence::func_82F9(var_09,undefined,undefined,1,"nuke");
			}
		}
	}

	level.var_72AA = undefined;
}

//Function Number: 67
func_9C0C(param_00)
{
	return scripts\common\utility::istrue(param_00.var_9341);
}

//Function Number: 68
func_C1AC(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in param_01)
	{
		foreach(var_06 in level.players)
		{
			if(!var_06 scripts\cp\_utility::is_valid_player())
			{
				continue;
			}

			if(scripts\common\utility::istrue(var_06.in_afterlife_arcade))
			{
				continue;
			}

			if(scripts\common\utility::istrue(var_06.var_9C54))
			{
				continue;
			}

			playfxontagforclients(level._effect["big_explo"],var_04,"tag_origin",var_06);
		}

		scripts\common\utility::func_136F7();
	}

	wait(5);
	foreach(var_04 in param_01)
	{
		foreach(var_06 in level.players)
		{
			function_0297(level._effect["big_explo"],var_04,"tag_origin",var_06);
		}

		var_04 delete();
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 69
func_A614(param_00)
{
	self endon("death");
	thread scripts\cp\zombies\zombie_scriptable_states::applyzombiescriptablestate(self);
	self.var_B36E = 1;
	var_01 = scripts\common\utility::istrue(self.var_9CDD);
	if(isdefined(param_00))
	{
		if(isalive(self) && !var_01)
		{
			playfx(level._effect["head_loss"],self gettagorigin("j_neck"));
			self setscriptablepartstate("head","detached",1);
			self setscriptablepartstate("eyes","eye_glow_off",1);
		}
	}
	else
	{
		wait(1);
	}

	self dodamage(self.health,self.origin);
}

//Function Number: 70
func_82EB(param_00,param_01)
{
	param_00 iprintlnbold("Got Loot: $" + param_01);
	param_00 scripts\cp\_persistence::func_82F9(param_01);
}

//Function Number: 71
func_6EBE(param_00,param_01,param_02)
{
	param_02 endon("remove " + param_01 + " icon");
	param_02 endon("death");
	param_02 endon("disconnect");
	level endon("game_ended");
	var_03 = 10;
	var_04 = 0.2;
	wait(param_00 - 5);
	param_00 = 5;
	for(;;)
	{
		wait(param_00 / var_03);
		self.alpha = 0.1;
		wait(var_04);
		self.alpha = 0.75;
		if(float(var_03 * 1.5) > var_04)
		{
			var_03 = float(var_03 * 1.5);
			continue;
		}

		var_03 = var_04;
	}
}

//Function Number: 72
func_8EA0(param_00,param_01,param_02,param_03)
{
	level endon("activated" + param_01);
	self endon("remove_carryIcon" + param_01);
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(param_00))
	{
		param_00 = 60;
	}

	var_04 = 5.5;
	param_00 = param_00 - var_04;
	self setclientomnvarbit("zm_active_powerup_animation",param_02 - 1,0);
	if(param_00 > 0)
	{
		level scripts\common\utility::waittill_any_timeout_1(param_00,"deactivated" + param_01);
		self setclientomnvarbit("zm_active_powerup_animation",param_02 - 1,1);
	}

	level scripts\common\utility::waittill_any_timeout_1(var_04,"deactivated" + param_01);
	level notify("power_up_deactivated");
	if(isdefined(self.var_D7A0[param_01]))
	{
		self.var_D7A0[param_01] = undefined;
	}

	self notify("remove " + param_01 + " icon");
	self setclientomnvarbit("zm_active_powerups",param_02 - 1,0);
	self setclientomnvarbit("zm_active_powerup_animation",param_02 - 1,0);
}

//Function Number: 73
func_8EBA()
{
	self endon("remove_carryIcon");
	level waittill("game_ended");
	if(isdefined(self.var_3AF5))
	{
		self.var_3AF5.alpha = 0;
	}
}

//Function Number: 74
is_in_active_volume(param_00)
{
	if(!isdefined(level.var_1646))
	{
		return 1;
	}

	var_01 = sortbydistance(level.var_1646,param_00);
	foreach(var_03 in var_01)
	{
		if(function_010F(param_00,var_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 75
func_1E39()
{
	self endon("death");
	self endon("disconnect");
	var_00 = [];
	foreach(var_02 in self.var_13CA0)
	{
		var_00[var_02] = self method_80FB(var_02);
	}

	return var_00;
}

//Function Number: 76
func_12BA6(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("deactivated" + param_01);
	if(!isdefined(self.var_13CA0))
	{
		self.var_13CA0 = self getweaponslistprimaries();
	}

	scripts\cp\_utility::enable_infinite_ammo(1);
	for(;;)
	{
		var_02 = 0;
		foreach(var_04 in self.var_13CA0)
		{
			if(var_04 == self getcurrentweapon() && func_13C30(var_04))
			{
				var_02 = 1;
				self setweaponammoclip(var_04,weaponclipsize(var_04),"left");
				self setclientomnvar("zm_ui_unlimited_ammo",1);
			}

			if(var_04 == self getcurrentweapon() && func_13C30(var_04))
			{
				var_02 = 1;
				self setweaponammoclip(var_04,weaponclipsize(var_04),"right");
				self setclientomnvar("zm_ui_unlimited_ammo",1);
			}

			if(var_02 == 0)
			{
				self setclientomnvar("zm_ui_unlimited_ammo",0);
				func_1E39();
			}
		}

		wait(0.05);
	}
}

//Function Number: 77
func_13C30(param_00)
{
	var_01 = 1;
	foreach(var_03 in level.var_C6C1)
	{
		if(param_00 == var_03)
		{
			var_01 = 0;
		}
	}

	return var_01;
}

//Function Number: 78
func_57B9()
{
	scripts\common\utility::func_136F7();
	if(isdefined(self) && scripts\cp\_utility::func_8BB1(self.model,"tag_eye"))
	{
		playfxontagforclients(level._effect["vfx_screen_flash"],self,"tag_eye",self);
	}
}