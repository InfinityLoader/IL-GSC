/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\_zombies_money.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 292 ms
 * Timestamp: 10/27/2023 3:25:29 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	common_scripts\utility::func_92C("pickup_share_money","vfx/gameplay/mp/zombie/dlc_pickup_zombies_01_money_gj");
	var_00 = [];
	var_00["func"] = ::func_8ADC;
	var_00["fx"] = "pickup_share_money";
	var_00["onDestroyed"] = ::func_8ADB;
	var_00["canBeDroppedByZombies"] = ::maps/mp/gametypes/zombies::func_6FC7;
	level.var_6FBF["share_money"] = var_00;
	level.var_8AD2 = [];
	level.var_349D = [];
	level thread maps\mp\_utility::func_6F74(::func_A90B);
}

//Function Number: 2
func_8ADC(param_00)
{
	var_01 = func_4680();
	lib_0555::func_83DD("take_share",param_00);
	lib_0378::func_8D74("zmb_points_pickup",var_01.var_116);
	param_00 func_47BB(var_01.var_62D3);
	var_01 func_8ADE(0);
	level thread maps/mp/gametypes/zombies::func_7CED(self);
}

//Function Number: 3
func_8ADB()
{
	var_00 = func_4680();
	var_00 func_8ADE();
	if(func_A235())
	{
		level thread func_7CE3(var_00.var_4F6B);
		var_00.var_4F6B = undefined;
	}

	level.var_8AD2 = common_scripts\utility::func_F93(level.var_8AD2,var_00);
}

//Function Number: 4
func_8ADF(param_00,param_01,param_02)
{
	var_03 = maps/mp/gametypes/zombies::func_281C("share_money",param_00,param_01);
	if(func_A235())
	{
		var_04 = newhudelem();
		var_04 setshader("hud_share_money");
		var_04.var_18 = 0;
		var_04 fadeovertime(0.3);
		var_04.var_18 = 0.9;
		var_04.var_56 = (0.654902,0.6352941,0.5647059);
		var_04.maxsightdistsqrd = param_00[0];
		var_04.var_1D7 = param_00[1];
		var_04.var_1D9 = param_00[2] + func_4515();
		var_05 = 1;
		var_06 = 1;
		var_07 = 0;
		var_08 = 0;
		var_09 = 0;
		var_0A = undefined;
		var_0B = 0;
		var_04 setwaypoint(var_05,var_06,var_07,var_08,var_09,var_0A,var_0A,var_0B,var_0A,var_0A);
		var_03.var_4F6B = var_04;
	}

	var_03.end_game_string_index = 0;
	var_03.var_8AD3 = [];
	var_03.var_62D3 = 0;
	var_03.var_117 = param_02;
	level.var_8AD2 = common_scripts\utility::func_F6F(level.var_8AD2,var_03);
	level notify("spawned_money_share");
	return var_03;
}

//Function Number: 5
func_8AD9(param_00)
{
	var_01 = func_4680();
	var_01.end_game_string_index = var_01.end_game_string_index + param_00;
	var_01.var_62D3 = var_01.var_62D3 + param_00;
}

//Function Number: 6
func_8ADA(param_00,param_01)
{
	var_02 = func_4680();
	var_03 = var_02.var_8AD3[param_00 getentitynumber()];
	if(!isdefined(var_03))
	{
		var_03 = spawnstruct();
		var_03.var_DBD = 0;
		var_02.var_8AD3[param_00 getentitynumber()] = var_03;
	}

	var_03.var_DBD = var_03.var_DBD + param_01;
	var_03.var_8AD8 = gettime();
	var_02.var_62D3 = var_02.var_62D3 + param_01;
	if(!common_scripts\utility::func_F79(param_00.var_8AD2,var_02))
	{
		param_00.var_8AD2 = common_scripts\utility::func_F6F(param_00.var_8AD2,var_02);
	}

	level.var_349D[param_00 getguid()] = level.var_349D[param_00 getguid()] + param_01;
}

//Function Number: 7
func_467F(param_00)
{
	if(!isdefined(level.var_349D))
	{
		return 0;
	}

	var_01 = level.var_349D[param_00 getguid()];
	if(!isdefined(var_01))
	{
		return 0;
	}

	return var_01;
}

//Function Number: 8
getsharedmoneypickupsbyplayer(param_00)
{
	if(!isdefined(param_00.var_8AD2))
	{
		return [];
	}

	return param_00.var_8AD2;
}

//Function Number: 9
getsharedmoneyinpickupbyplayer(param_00)
{
	var_01 = func_4680();
	if(!isdefined(var_01) || !isdefined(var_01.var_8AD3))
	{
		return 0;
	}

	var_02 = var_01.var_8AD3[param_00 getentitynumber()];
	if(!isdefined(var_02))
	{
		return 0;
	}

	return var_02.var_DBD;
}

//Function Number: 10
func_2698()
{
	if(!isdefined(level.var_349D))
	{
		return 0;
	}

	var_00 = 0;
	foreach(var_02 in level.var_349D)
	{
		if(var_02 > 0)
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 11
func_A90C()
{
	var_00 = self;
	var_01 = var_00 getentitynumber();
	var_00 waittill("disconnect");
	foreach(var_03 in var_00.var_8AD2)
	{
		var_03 func_8ADD(var_01,0);
		if(var_03.var_62D3 <= 0)
		{
			level thread maps/mp/gametypes/zombies::func_7CED(var_03);
		}
	}
}

//Function Number: 12
func_A90B()
{
	var_00 = self;
	var_00 endon("disconnect");
	var_01 = "drop_money_notify";
	var_02 = 0.1;
	var_00 notifyonplayercommand(var_01,"+actionslot 3");
	var_00.var_8AD2 = [];
	var_00 thread func_A90C();
	if(!isdefined(level.var_349D[var_00 getguid()]))
	{
		level.var_349D[var_00 getguid()] = 0;
	}

	for(;;)
	{
		wait(var_02);
		var_00 waittill(var_01);
		if(!maps\mp\_utility::func_57A0(var_00))
		{
			continue;
		}

		if(!var_00 method_8648())
		{
			continue;
		}

		if(isdefined(var_00.on_aa_gun) && var_00.on_aa_gun == 1)
		{
			continue;
		}

		var_03 = func_467D();
		if(!var_00 maps/mp/gametypes/zombies::func_11C2(var_03,1,1))
		{
			var_00 method_860F("zmb_ui_purchase_fail",var_00);
			lib_0555::func_83DD("poor_share",var_00);
			continue;
		}

		var_04 = func_4681(var_00);
		var_05 = common_scripts\utility::func_4461(var_04,level.var_8AD2,func_467A());
		lib_0555::func_83DD("share",var_00);
		lib_0378::func_8D74("zmb_points_share",var_00.var_116);
		if(!isdefined(var_05))
		{
			var_09 = "player share_money on notify " + var_01;
			var_05 = func_8ADF(var_04,var_09,var_00);
		}

		var_00 thread lib_054E::func_745A("give_money");
		var_05 func_8ADA(var_00,var_03);
		if(var_00.var_8AD2.size >= func_4606())
		{
			var_0A = undefined;
			foreach(var_0C in var_00.var_8AD2)
			{
				if(!isdefined(var_0A) || var_0C.var_8AD3[var_00 getentitynumber()].var_8AD8 < var_0A.var_8AD3[var_00 getentitynumber()].var_8AD8)
				{
					var_0A = var_0C;
				}
			}

			var_0A func_8ADD(var_00 getentitynumber());
			if(var_0A.var_62D3 <= 0)
			{
				level thread maps/mp/gametypes/zombies::func_7CED(var_0A);
			}
		}

		var_00 notify("money_share_success");
	}
}

//Function Number: 13
func_4680()
{
	var_00 = self;
	return var_00;
}

//Function Number: 14
func_8ADE(param_00)
{
	var_01 = func_4680();
	foreach(var_03 in getarraykeys(var_01.var_8AD3))
	{
		func_8ADD(var_03,param_00);
	}
}

//Function Number: 15
func_47BB(param_00)
{
	var_01 = self;
	var_02 = 1;
	var_01 maps/mp/gametypes/zombies::func_4798(param_00,var_02);
}

//Function Number: 16
func_4681(param_00)
{
	var_01 = anglestoforward(param_00.var_1D);
	var_01 = common_scripts\utility::func_3D5D(var_01);
	var_01 = vectornormalize(var_01);
	var_02 = param_00.var_116 + var_01 * func_467E() + (0,0,30);
	var_03 = getclosestpointonnavmesh(var_02,param_00);
	return var_03;
}

//Function Number: 17
func_8ADD(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = func_7B92();
	}

	var_02 = func_4680();
	var_03 = var_02.var_8AD3[param_00].var_DBD;
	var_04 = maps\mp\gametypes\_playerlogic::func_4622(param_00);
	if(isdefined(var_04))
	{
		if(param_01)
		{
			var_04 func_47BB(var_03);
		}

		var_04.var_8AD2 = common_scripts\utility::func_F93(var_04.var_8AD2,var_02);
	}

	var_02.var_62D3 = var_02.var_62D3 - var_03;
	var_02.var_8AD3[param_00] = undefined;
}

//Function Number: 18
sharemoneyremoveamountbyplayer(param_00,param_01)
{
	var_02 = func_4680();
	var_03 = param_00 getentitynumber();
	var_04 = var_02.var_8AD3[var_03].var_DBD;
	if(param_01 > var_04)
	{
		return 0;
	}

	var_02.var_62D3 = var_02.var_62D3 - param_01;
	if(param_01 == var_04)
	{
		param_00.var_8AD2 = common_scripts\utility::func_F93(param_00.var_8AD2,var_02);
		var_02.var_8AD3[var_03] = undefined;
		if(var_02.var_62D3 <= 0)
		{
			level thread maps/mp/gametypes/zombies::func_7CED(var_02);
		}
	}

	return 1;
}

//Function Number: 19
func_7CE3(param_00)
{
	param_00 fadeovertime(0.3);
	param_00.var_18 = 0;
	wait(0.3);
	param_00 destroy();
}

//Function Number: 20
func_467E()
{
	return 60;
}

//Function Number: 21
func_467D()
{
	return 250;
}

//Function Number: 22
func_467A()
{
	return 30;
}

//Function Number: 23
func_4606()
{
	return 5;
}

//Function Number: 24
func_7B92()
{
	return 1;
}

//Function Number: 25
func_A235()
{
	return 1;
}

//Function Number: 26
func_4515()
{
	return -8;
}