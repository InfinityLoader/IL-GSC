/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1387.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 65
 * Decompile Time: 27 ms
 * Timestamp: 10/27/2023 3:25:58 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	var_00 = level.var_A41["zombie"];
	var_00["think"] = ::func_9D34;
	var_00["on_killed"] = ::func_9D2D;
	var_00["get_action_params"] = ::func_9D23;
	var_00["move_mode"] = ::func_9D2B;
	var_00["post_model"] = ::func_9D2E;
	var_00["tesla_delayed_dmg"] = ::treasurer_tesla_delayed_dmg;
	level.var_A41["zombie_treasurer"] = var_00;
	var_01 = [];
	var_01["whole_body"] = "zom_bomber_base";
	var_02 = spawnstruct();
	var_02.var_A4B = "zombie_treasurer";
	var_02.var_EAE = "zombie_animclass";
	var_02.var_E88 = "zombie_generic";
	var_02.var_879 = "zombie_generic";
	var_02.var_5ED2["default look"] = var_01;
	var_02.var_60E2 = 20;
	var_02.var_AC6D = "zombie_exploder";
	var_02.var_4C12 = 15;
	var_02.per_extra_player_health_scale = 0.3;
	lib_0547::func_A52(var_02,"zombie_treasurer");
	level.var_AC09 = [func_2792("Max Ammo",::func_3484,35),func_2792("Full Meter",::func_3483,35)];
	if(maps\mp\_utility::func_4571() == "mp_zombie_nest_01")
	{
		level.var_AC09 = common_scripts\utility::func_F73(level.var_AC09,[func_2792("Hunter piece 1",::func_3472,5),func_2792("Hunter piece 2",::func_3473,5),func_2792("Hunter piece 3",::func_3474,5),func_2792("Hunter piece 4",::func_3475,5),func_2792("Hunter piece 5",::func_3476,5)]);
	}

	if(maps\mp\_utility::func_4571() == "mp_zombie_island")
	{
		level.var_AC09 = common_scripts\utility::func_F73(level.var_AC09,[func_2792("Hunter dlc1 piece 1",::drop_dlc1_hunter_piece_1,8),func_2792("Hunter dlc2 piece 2",::drop_dlc1_hunter_piece_2,8),func_2792("Hunter dlc3 piece 3",::drop_dlc1_hunter_piece_3,8)]);
	}

	if(maps\mp\_utility::func_4571() == "mp_zombie_berlin")
	{
		level.var_AC09 = common_scripts\utility::func_F73(level.var_AC09,[func_2792("drop_dlc2_char_a_0",::drop_dlc2_char_a_piece_1,8),func_2792("drop_dlc2_char_a_1",::drop_dlc2_char_a_piece_2,8),func_2792("drop_dlc2_char_a_2",::drop_dlc2_char_a_piece_3,8)]);
	}

	level.var_AC0A = [func_2792("free blitz bullets ( doubletap )",::func_344C,12.5),func_2792("free blitz reload ( fastreload )",::func_344E,12.5),func_2792("free blitz shock ( electriccherry )",::func_344D,12.5),func_2792("free blitz sprint ( runperk )",::func_3451,12.5),func_2792("free blitz strike ( punchperk )",::func_344F,12.5),func_2792("free panzer armor ( armor )",::func_344B,12.5),func_2792("free blitz revive ( quickrevive )",::func_3450,12.5),func_2792("free mystery box coupon",::func_3452,12.5)];
	level thread func_9D20();
	level thread maps\mp\_utility::func_6F74(::func_A0C4);
	level.var_611["zmb_treasure_icon"] = loadfx("vfx/gameplay/mp/zombie/zmb_treasure_icon");
}

//Function Number: 2
func_9D2E()
{
	func_4394() attach("zom_bomb_treasure","TAG_WEAPON_CHEST");
	thread func_1138();
}

//Function Number: 3
treasurer_tesla_delayed_dmg(param_00,param_01,param_02)
{
	if(common_scripts\utility::func_562E(param_01))
	{
		param_00 = maps/mp/gametypes/zombies::func_1E59();
	}

	if(isdefined(param_02))
	{
		param_00 = param_02;
	}

	return param_00;
}

//Function Number: 4
func_1138()
{
	var_00 = self method_8445("TAG_FX");
	if(var_00 == -1)
	{
	}

	thread func_1139();
}

//Function Number: 5
func_1139()
{
	self endon("death");
	wait 0.05;
	wait 0.05;
	wait 0.05;
	wait 0.05;
	playfxontag(level.var_611["zmb_treasure_icon"],self,"TAG_FX");
}

//Function Number: 6
func_9D38()
{
	var_00 = func_4394();
	var_00.var_8B72 = 0;
	var_01 = 1;
	var_02 = var_01 * 1000;
	for(;;)
	{
		wait(var_01);
		if(!common_scripts\utility::func_562E(var_00.var_4BA0))
		{
			continue;
		}

		if(!isdefined(level.var_744A))
		{
			continue;
		}

		foreach(var_04 in level.var_744A)
		{
			if(!var_04 common_scripts\utility::func_7237(var_00,var_02))
			{
				continue;
			}

			var_04 thread lib_054E::func_7465();
			var_00.var_8B72 = 1;
			var_00.var_1723 = 1;
			return;
		}
	}
}

//Function Number: 7
func_9D32()
{
	var_00 = func_4394();
	for(;;)
	{
		wait(func_9D29());
		if(!common_scripts\utility::func_562E(var_00.var_4BA0))
		{
			continue;
		}

		var_01 = func_9D27();
		if(var_01 <= 0)
		{
			continue;
		}

		var_02 = func_4166(var_00.var_116);
		var_03 = maps\mp\zombies\_zombies_money::func_8ADF(var_02,"Treasure zombie!!!",var_00);
		var_03 maps\mp\zombies\_zombies_money::func_8AD9(var_01);
		var_03.var_6FD4 = func_9D2A();
		var_03.var_6FCB = func_9D28();
	}
}

//Function Number: 8
func_9D2F()
{
	var_00 = func_4394();
	var_01 = getarraykeys(level.var_AC80.var_ACB3);
	var_02 = common_scripts\utility::func_7A33(var_01);
	var_00.var_9820 = var_02;
}

//Function Number: 9
func_9D34()
{
	var_00 = func_4394();
	level endon("game_ended");
	var_00 endon("death");
	var_00 endon("owner_disconnect");
	var_00 method_85A1("zombie_exploder");
	var_00 lib_0566::func_ABB5();
	var_00 childthread func_9D35();
	var_00 childthread func_9D38();
	var_00 childthread func_9D32();
	var_00.var_6816 = 1;
	var_00.var_5D5F = 1;
	var_00.var_57E8 = 1;
	var_00.var_57FD = 1;
	var_00.var_55AB = 1;
	var_00.var_562B = 1;
	var_00.var_5569 = 1;
	var_00.var_A572 = [];
	var_00 lib_0378::func_8D74("aud_treasurer_strt_timer");
	var_01 = 0.2;
	for(;;)
	{
		wait(var_01);
		if(lib_053C::func_4F8C())
		{
			continue;
		}

		if(lib_053C::func_4F84())
		{
			continue;
		}

		if(var_00.var_8B72)
		{
			var_02 = lib_055A::func_578B(var_00.var_116,0);
			var_00.var_2920 = var_02;
			if(isdefined(var_02))
			{
				var_00.var_5B2F = var_02;
				var_00.var_A572[var_02] = gettime() * 0.001;
			}

			if(isdefined(var_00.var_9820))
			{
				if(lib_0547::func_5565(var_00.var_9820,var_02))
				{
					var_00.var_9820 = undefined;
				}
				else
				{
					var_03 = level.var_AC80.var_ACB3[var_00.var_9820];
					var_00 lib_053C::func_6CE(var_03.var_74DC);
				}

				var_00 lib_053C::func_647();
				continue;
			}

			var_04 = [];
			if(isdefined(var_02))
			{
				var_03 = level.var_AC80.var_ACB3[var_02];
				var_04 = common_scripts\utility::func_F92(getarraykeys(var_03.var_A01));
			}

			var_05 = undefined;
			var_06 = undefined;
			foreach(var_08 in var_04)
			{
				var_09 = var_00.var_A572[var_08];
				if(!isdefined(var_09))
				{
					var_05 = var_08;
					break;
				}

				if(isdefined(var_06) && var_09 > var_06)
				{
					continue;
				}

				var_05 = var_08;
				var_06 = var_09;
			}

			if(isdefined(var_05))
			{
				var_00.var_9820 = var_05;
			}
			else
			{
				var_00 func_9D2F();
			}
		}
		else
		{
			if(lib_053C::func_4F9B())
			{
				continue;
			}

			if(lib_053C::func_4F9A())
			{
				continue;
			}
		}

		var_00 lib_053C::func_647();
	}
}

//Function Number: 10
func_9D35()
{
	var_00 = func_4394();
	while(!common_scripts\utility::func_562E(var_00.var_4BA0))
	{
		wait 0.05;
	}

	var_00.var_4BA1 = gettime();
	var_01 = 0;
	for(;;)
	{
		wait(1);
		if(func_9D25() > func_9D26())
		{
			break;
		}

		if(func_9D25() > func_9D26() * 0.5)
		{
			if(!var_01)
			{
				var_02 = common_scripts\utility::func_4461(var_00.var_116,level.var_744A);
				if(isdefined(var_02) && !lib_0547::func_577E(var_02))
				{
					var_02 thread lib_054E::func_9D39();
					var_01 = 1;
				}
			}
		}
	}

	var_00 lib_0378::func_8D74("aud_treasurer_fuse");
	wait(0.5);
	var_00 lib_0378::func_8D74("aud_treasurer_end_timer");
	var_03 = var_00 gettagorigin("TAG_WEAPON_CHEST");
	var_00 detonateusingweapon("drag_explosive_zm");
	lib_0563::func_AB98(var_03);
	lib_0563::func_AB9C(var_03);
	lib_0563::func_AB9E(var_03);
	var_00 suicide();
}

//Function Number: 11
func_9D2D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = func_4394();
	if(isplayer(param_01))
	{
		level thread func_348E(var_09.var_116);
		thread lib_054E::func_9D3A(param_01,1);
		level.var_400E[level.var_400E.size] = ["raven_set 0 1","all"];
	}
	else
	{
		var_0A = common_scripts\utility::func_4461(var_09.var_116,level.var_744A);
		if(isdefined(var_0A) && !lib_0547::func_577E(var_0A))
		{
			thread lib_054E::func_9D3A(var_0A,0);
		}
	}

	var_09 lib_0378::func_8D74("aud_treasurer_end_timer");
	var_09 method_802E("zom_bomb_treasure","TAG_WEAPON_CHEST");
	var_09 lib_054D::func_6BD4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 12
func_9D2B()
{
	var_00 = func_4394();
	if(!common_scripts\utility::func_562E(var_00.var_4BA0))
	{
		return "walk";
	}

	if(common_scripts\utility::func_562E(var_00.var_8B72))
	{
		return "sprint";
	}

	return "run";
}

//Function Number: 13
func_9D23()
{
	var_00 = lib_054D::func_AC22();
	var_00["script_var"] = "held_bomb";
	var_00["zombie_subtype"] = "zombie_exploder";
	return var_00;
}

//Function Number: 14
func_9D37(param_00)
{
	var_01 = 1;
	while(param_00 > 0)
	{
		wait(var_01);
		param_00 = param_00 - var_01;
	}

	while(common_scripts\utility::func_562E(level.var_6F1E))
	{
		wait(60);
	}
}

//Function Number: 15
func_9D20()
{
	if(common_scripts\utility::func_562E(level.var_323A))
	{
		return;
	}

	while(func_9D31() && !isdefined(level.var_AC1D) || !func_0F4C())
	{
		wait(1);
	}

	while(func_9D30() && !isdefined(level.var_AC80) || !common_scripts\utility::func_562E(level.var_AC80.var_8A9) || !lib_055A::func_F4F(1))
	{
		wait(1);
	}

	var_00 = 4320;
	var_01 = var_00;
	if(isdefined(level.var_744A))
	{
		var_02 = [];
		foreach(var_04 in level.var_744A)
		{
			var_05 = func_431A(var_04);
			var_06 = var_04 getrankedplayerdata(common_scripts\utility::func_46A8(),"totalTimePlayedAsOfTreasureZombieKill");
			var_07 = clamp(var_05 - var_06,0,var_00);
			var_02 = common_scripts\utility::func_F6F(var_02,var_07);
		}

		var_07 = common_scripts\utility::func_6880(var_02);
		var_01 = var_00 - var_07 + randomfloatrange(20,90);
	}

	for(;;)
	{
		func_9D37(var_01);
		var_09 = undefined;
		var_0A = "Treasure zombie!!!";
		var_0B = 1;
		var_0C = 1;
		var_0D = 0;
		var_0E = lib_054D::func_90BA("zombie_treasurer",var_09,var_0A,var_0B,var_0C,var_0D);
		if(isdefined(var_0E))
		{
			var_01 = var_00;
			continue;
		}

		var_01 = 30;
	}
}

//Function Number: 16
func_A0C4()
{
	var_00 = func_4296();
	var_00 endon("disconnect");
	for(;;)
	{
		level waittill("zombie_spawned",var_01);
		if(!lib_0547::func_5565(var_01.var_A4B,"zombie_treasurer"))
		{
			continue;
		}

		var_02 = func_431A(var_00);
		var_00 setrankedplayerdata(common_scripts\utility::func_46A8(),"totalTimePlayedAsOfTreasureZombieKill",var_02);
	}
}

//Function Number: 17
func_4166(param_00)
{
	var_01 = func_9D24();
	var_02 = param_00;
	var_03 = 0;
	var_04 = 5;
	var_05 = getrandomnavpoints(param_00,var_01,var_04);
	if(isdefined(var_05))
	{
		foreach(var_07 in var_05)
		{
			if(!function_02DE(param_00,var_07))
			{
				continue;
			}

			var_08 = distance(param_00,var_07);
			if(var_08 > var_03)
			{
				var_02 = var_07;
				var_03 = var_08;
			}
		}
	}

	return var_02;
}

//Function Number: 18
func_2792(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_2AF8 = param_00;
	var_03.var_1E61 = param_01;
	var_03.var_3489 = param_02;
	return var_03;
}

//Function Number: 19
func_3478(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_116 = param_00;
	var_02 thread [[ param_01 ]]();
}

//Function Number: 20
func_3479(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		var_02 = var_02 + var_04.var_3489;
	}

	var_02 = randomfloat(var_02);
	var_06 = undefined;
	foreach(var_04 in param_00)
	{
		if(var_02 > var_04.var_3489)
		{
			var_02 = var_02 - var_04.var_3489;
			continue;
		}

		var_06 = var_04;
		break;
	}

	if(!isdefined(var_06))
	{
		var_06 = common_scripts\utility::func_7A33(param_00);
	}

	func_3478(param_01,var_06.var_1E61);
}

//Function Number: 21
func_348E(param_00)
{
	func_3479(level.var_AC09,param_00);
	wait(1);
	func_3479(level.var_AC0A,param_00);
}

//Function Number: 22
func_4167()
{
	var_00 = self;
	return var_00;
}

//Function Number: 23
func_3477(param_00)
{
	level.var_400E[level.var_400E.size] = ["treasure_set " + param_00 + " 1","all"];
}

//Function Number: 24
func_3472()
{
	func_3477(0);
}

//Function Number: 25
func_3473()
{
	func_3477(1);
}

//Function Number: 26
func_3474()
{
	func_3477(2);
}

//Function Number: 27
func_3475()
{
	func_3477(3);
}

//Function Number: 28
func_3476()
{
	func_3477(4);
}

//Function Number: 29
drop_dlc1_hunter_piece_1()
{
	level notify("hunter_treasure_dlc1_0");
}

//Function Number: 30
drop_dlc1_hunter_piece_2()
{
	level notify("hunter_treasure_dlc1_1");
}

//Function Number: 31
drop_dlc1_hunter_piece_3()
{
	level notify("hunter_treasure_dlc1_2");
}

//Function Number: 32
drop_dlc2_char_a_piece_1()
{
	level notify("drop_dlc2_char_a_0");
}

//Function Number: 33
drop_dlc2_char_a_piece_2()
{
	level notify("drop_dlc2_char_a_1");
}

//Function Number: 34
drop_dlc2_char_a_piece_3()
{
	level notify("drop_dlc2_char_a_2");
}

//Function Number: 35
func_3485(param_00)
{
	var_01 = func_4167();
	var_02 = func_4166(var_01.var_116);
	maps/mp/gametypes/zombies::func_281C(param_00,var_02,"Treasure zombie!!!");
}

//Function Number: 36
func_3484()
{
	func_3485("ammo");
}

//Function Number: 37
func_3483()
{
	func_3485("ability_fill");
}

//Function Number: 38
func_9D18(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = func_4296();
	if(!isdefined(var_01.var_9D1E))
	{
		var_01.var_9D1E = [];
	}

	if(!isdefined(var_01.var_9D1E[param_00]))
	{
		var_01.var_9D1E[param_00] = 0;
	}
}

//Function Number: 39
func_9D1B(param_00)
{
	var_01 = func_4296();
	var_01 func_9D18(param_00);
	var_01.var_9D1E[param_00]++;
	var_01 notify("perk_discount_applied");
}

//Function Number: 40
func_9D1A(param_00)
{
	var_01 = func_4296();
	var_01 func_9D18(param_00);
	if(var_01 func_9D19(param_00) <= 0)
	{
		return;
	}

	var_01.var_9D1E[param_00]--;
	var_01 notify("used_vending_machine_discount");
}

//Function Number: 41
func_9D19(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_4296();
	var_01 func_9D18(param_00);
	return var_01.var_9D1E[param_00];
}

//Function Number: 42
func_9D1C()
{
	return func_9D19("mysterybox_coupon");
}

//Function Number: 43
func_9D1D()
{
	return func_9D1A("mysterybox_coupon");
}

//Function Number: 44
func_3453(param_00)
{
	if(!isdefined(level.var_744A))
	{
		return;
	}

	foreach(var_02 in level.var_744A)
	{
		var_02 func_9D1B(param_00);
	}
}

//Function Number: 45
func_344C()
{
	func_3453("doubletap");
}

//Function Number: 46
func_344E()
{
	func_3453("fastreload");
}

//Function Number: 47
func_344D()
{
	func_3453("electriccherry");
}

//Function Number: 48
func_3451()
{
	func_3453("runperk");
}

//Function Number: 49
func_344F()
{
	func_3453("punchperk");
}

//Function Number: 50
func_344B()
{
	func_3453("armor");
}

//Function Number: 51
func_3450()
{
	func_3453("quickrevive");
}

//Function Number: 52
func_3452()
{
	func_3453("mysterybox_coupon");
	maps\mp\zombies\_zombies_magicbox::func_861C();
}

//Function Number: 53
func_431A(param_00)
{
	var_01 = param_00 getrankedplayerdata(common_scripts\utility::func_46A8(),"totalTimePlayed") + param_00.var_9A06["total"];
	return var_01;
}

//Function Number: 54
func_9D26()
{
	return 45;
}

//Function Number: 55
func_9D24()
{
	return 70;
}

//Function Number: 56
func_9D27()
{
	return 100;
}

//Function Number: 57
func_9D29()
{
	return 1;
}

//Function Number: 58
func_9D28()
{
	return 1.7;
}

//Function Number: 59
func_9D2A()
{
	return 0.5;
}

//Function Number: 60
func_9D31()
{
	return 0;
}

//Function Number: 61
func_9D30()
{
	return 1;
}

//Function Number: 62
func_9D25()
{
	var_00 = func_4394();
	if(!isdefined(var_00.var_4BA1))
	{
		return 0;
	}

	var_01 = gettime() - var_00.var_4BA1 * 0.001;
	return var_01;
}

//Function Number: 63
func_4394()
{
	var_00 = self;
	return var_00;
}

//Function Number: 64
func_4296()
{
	var_00 = self;
	return var_00;
}

//Function Number: 65
func_0F4C()
{
	if(!isdefined(level.var_AC1D))
	{
		return 0;
	}

	foreach(var_01 in level.var_AC1D)
	{
		if(!common_scripts\utility::func_562E(var_01.var_6BE1))
		{
			return 0;
		}
	}

	return 1;
}