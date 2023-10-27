/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3424.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 5 ms
 * Timestamp: 10/27/2023 12:27:12 AM
*******************************************************************/

//Function Number: 1
func_13F54()
{
	scripts\common\utility::flag_init("spawn_point_score_data_init_done");
	level.var_13FA6 = ::func_7C8A;
	level.fake_players = [];
}

//Function Number: 2
func_7C8A(param_00)
{
	if(isdefined(param_00))
	{
		return func_8253(param_00);
	}

	return func_8253(level.var_1647);
}

//Function Number: 3
func_13F59(param_00)
{
	if(!lib_0D5F::func_4A71(::lib_0D5F::func_26B8,param_00))
	{
		return "secondary";
	}

	if(!lib_0D5F::func_4A71(::lib_0D5F::func_26BC,param_00))
	{
		return "secondary";
	}

	if(!lib_0D5F::func_4A71(::lib_0D5F::func_26C4,param_00))
	{
		return "secondary";
	}

	return "primary";
}

//Function Number: 4
func_98C8(param_00)
{
	param_00.var_11A3B = 0;
	param_00.var_11A3A = 0;
	param_00.var_C217 = 0;
	param_00.var_3165 = 0;
	param_00.var_A9E9 = [];
	param_00.var_A9E9["allies"] = 0;
	param_00.var_A9E9["axis"] = 0;
}

//Function Number: 5
func_9E54(param_00)
{
	if(isdefined(param_00.var_13538) && param_00.var_13538.var_19)
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
func_8253(param_00)
{
	if(!isdefined(level.var_4B9C))
	{
		level.var_4B9C = 0;
	}
	else
	{
		level.var_4B9C = func_790C(level.var_4B9C);
	}

	var_01 = level.var_4B9C;
	var_02 = [];
	foreach(var_04 in param_00)
	{
		func_98C8(var_04);
		if(func_13F59(var_04) == "primary")
		{
			var_02[var_02.size] = var_04;
		}
	}

	if(var_02.size)
	{
		var_06 = func_EC47(var_02,var_01);
	}
	else
	{
		var_06 = scripts\common\utility::random(var_01);
	}

	scripts\common\utility::flag_set("spawn_point_score_data_init_done");
	return var_06;
}

//Function Number: 7
func_790C(param_00)
{
	var_01 = level.players.size;
	if(var_01 == 1)
	{
		return 0;
	}

	var_02 = 0;
	var_03 = func_7B17(param_00);
	while(!var_02)
	{
		if(var_03 == param_00)
		{
			break;
		}

		var_04 = level.players[var_03];
		if(!scripts\common\utility::istrue(var_04.var_1097A) && !scripts\common\utility::istrue(var_04.var_9BE1) && !scripts\common\utility::istrue(var_04.inlaststand))
		{
			var_02 = 1;
		}

		if(!var_02)
		{
			var_03 = func_7B17(var_03);
		}
	}

	return var_03;
}

//Function Number: 8
func_7B17(param_00)
{
	var_01 = param_00 + 1;
	if(isdefined(level.players[var_01]))
	{
		return var_01;
	}

	var_01++;
	for(var_02 = 0;var_02 < level.players.size;var_02++)
	{
		if(isdefined(level.players[var_01]))
		{
			return var_01;
		}

		if(var_01 >= level.players.size)
		{
			var_01 = 0;
			continue;
		}

		var_01++;
	}

	return 0;
}

//Function Number: 9
func_EC47(param_00,param_01)
{
	var_02 = param_00[0];
	param_00 = scripts\common\utility::array_randomize(param_00);
	level notify("debug_spawner_score_reset");
	foreach(var_04 in param_00)
	{
		func_EC31(var_04,param_01);
		if(!isdefined(var_02) || var_04.var_11A3B > var_02.var_11A3B)
		{
			var_02 = var_04;
		}
	}

	return var_02;
}

//Function Number: 10
func_913F(param_00,param_01,param_02)
{
	if(param_02)
	{
		var_03 = (1,1,1);
		switch(param_01)
		{
			case 0:
				var_03 = (1,0,0);
				break;

			case 1:
				var_03 = (1,1,0);
				break;

			case 2:
				var_03 = (0,1,0);
				break;

			case 3:
				var_03 = (0,1,1);
				break;
		}

		thread scripts\cp\_utility::drawsphere(param_00.origin,20,10,var_03);
	}
}

//Function Number: 11
func_EC31(param_00,param_01)
{
	var_02 = func_EC1A(1,::func_D830,param_00,param_01);
	param_00.var_5706 = var_02;
	param_00.var_11A3B = param_00.var_11A3B + var_02;
	var_02 = func_EC1A(5,::func_26C0,param_00);
	param_00.var_DDCB = var_02;
	param_00.var_11A3B = param_00.var_11A3B + var_02;
}

//Function Number: 12
func_D830(param_00,param_01)
{
	if(!isdefined(param_00.var_13538))
	{
		return 0;
	}

	var_02 = level.players[param_01];
	var_03 = 0;
	var_04 = 0.75;
	if(func_800B(param_00.var_13538))
	{
		var_03 = 1;
	}
	else if(isdefined(param_00.var_13538.var_186E))
	{
		foreach(var_06 in param_00.var_13538.var_186E)
		{
			if(func_800B(var_06))
			{
				var_03 = 0.5;
				break;
			}
		}
	}

	if(var_03 == 0)
	{
		return 0;
	}

	var_08 = getdvarint("scr_spawn_score_distance",0);
	if(var_08 != 0)
	{
		var_09 = var_08 * var_08;
	}
	else if(isdefined(level.var_107CA))
	{
		var_09 = level.var_107CA * level.var_107CA;
	}
	else
	{
		var_09 = 2250000;
	}

	if(distancesquared(var_02.origin,param_00.origin) < var_09)
	{
		return 100;
	}

	return 100 * var_04 * var_03;
}

//Function Number: 13
func_26C0(param_00)
{
	if(isdefined(param_00.var_A9F6))
	{
		var_01 = gettime() - param_00.var_A9F6;
		if(var_01 > 15000)
		{
			return 100;
		}

		return var_01 / 15000 * 100;
	}

	return 100;
}

//Function Number: 14
func_D82F(param_00)
{
	if(!isdefined(param_00.var_13538))
	{
		return 0;
	}

	var_01 = func_800B(param_00.var_13538);
	if(var_01 == 0)
	{
		return 0;
	}

	return 100 * 1 - var_01 * 0.15;
}

//Function Number: 15
func_EC1A(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
		var_05 = [[ param_01 ]](param_02,param_03,param_04);
	}
	else if(isdefined(param_04))
	{
		var_05 = [[ param_02 ]](param_03,param_04);
	}
	else
	{
		var_05 = [[ param_02 ]](param_03);
	}

	var_05 = clamp(var_05,0,100);
	var_05 = var_05 * param_00;
	return var_05;
}

//Function Number: 16
func_800B(param_00)
{
	var_01 = 0;
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

		if(scripts\common\utility::istrue(var_03.inlaststand))
		{
			continue;
		}

		if(var_03 istouching(param_00))
		{
			var_01++;
		}
	}

	foreach(var_03 in level.fake_players)
	{
		if(scripts\common\utility::istrue(var_03.var_1097A))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_03.var_9BE1))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_03.inlaststand))
		{
			continue;
		}

		if(function_010F(var_03.origin,param_00))
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 17
func_800C(param_00,param_01)
{
	var_02 = param_01 * param_01;
	var_03 = 0;
	foreach(var_05 in level.players)
	{
		if(distancesquared(var_05.origin,param_00.origin) < var_02)
		{
			var_03++;
		}
	}

	return var_03;
}

//Function Number: 18
func_4F1C(param_00,param_01)
{
	level endon("debug_spawner_score_reset");
	var_02 = 0;
	var_03 = 100;
	var_04 = 200;
	var_05 = 300;
	var_06 = 400;
	var_07 = 500;
	var_08 = 600;
	if(param_00.var_11A3B <= 0)
	{
		scripts\cp\_utility::drawsphere(param_00.origin,20,param_01,(1,0,0));
		return;
	}

	if(param_00.var_11A3B <= var_03)
	{
		scripts\cp\_utility::drawsphere(param_00.origin,20,param_01,(1,1,0));
		return;
	}

	if(param_00.var_11A3B < var_07)
	{
		scripts\cp\_utility::drawsphere(param_00.origin,20,param_01,(0,1,0));
		return;
	}

	if(param_00.var_11A3B >= var_07 && param_00.var_11A3B < var_08)
	{
		scripts\cp\_utility::drawsphere(param_00.origin,20,param_01,(0,1,1));
		return;
	}

	if(param_00.var_11A3B >= var_08)
	{
		scripts\cp\_utility::drawsphere(param_00.origin,20,param_01,(1,1,1));
		return;
	}
}

//Function Number: 19
func_4F1D()
{
	while(!isdefined(level.var_1647))
	{
		wait(0.1);
	}

	scripts\common\utility::flag_wait("spawn_point_score_data_init_done");
	for(;;)
	{
		if(getdvarint("scr_spawn_point_debug",0) != 0)
		{
			foreach(var_01 in level.var_1647)
			{
				func_98C8(var_01);
				func_EC31(var_01,level.var_4B9C);
				if(isdefined(var_01.var_11A3B))
				{
					level thread func_4F1C(var_01,0.1);
				}
			}
		}

		wait(0.1);
	}
}