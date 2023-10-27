/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_weaponrank.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 1096 ms
 * Timestamp: 10/27/2023 12:10:16 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_13CBD = spawnstruct();
	level.var_13CBD.var_DCD4 = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = int(tablelookuprownum("mp/weaponRankTable.csv",0,var_00));
		if(!isdefined(var_01) || var_01 < 0)
		{
			break;
		}

		var_02 = spawnstruct();
		level.var_13CBD.var_DCD4[var_00] = var_02;
		var_02.var_B7CF = int(tablelookupbyrow("mp/weaponRankTable.csv",var_00,1));
		var_02.var_13E29 = int(tablelookupbyrow("mp/weaponRankTable.csv",var_00,2));
		var_02.var_B4D6 = int(tablelookupbyrow("mp/weaponRankTable.csv",var_00,3));
		var_00++;
	}

	level.var_13CBD.var_B4C0 = var_00 - 1;
	level.var_13CBD.var_B4D4 = [];
	var_03 = 1;
	for(;;)
	{
		var_01 = int(tablelookuprownum("mp/statstable.csv",0,var_03));
		if(!isdefined(var_01) || var_01 < 0)
		{
			break;
		}

		var_04 = tablelookupbyrow("mp/statstable.csv",var_01,4);
		var_05 = tablelookupbyrow("mp/statstable.csv",var_01,42);
		if(!isdefined(var_04) || var_04 == "" || !isdefined(var_05) || var_05 == "")
		{
		}
		else
		{
			var_05 = int(var_05);
			level.var_13CBD.var_B4D4[var_04] = var_05;
		}

		var_03++;
	}

	init_weapon_rank_events();
}

//Function Number: 2
init_weapon_rank_events()
{
	var_00 = "scripts/cp/maps/cp_zmb/cp_zmb_weaponrank_event.csv";
	if(isdefined(level.weapon_rank_event_table))
	{
		var_00 = level.weapon_rank_event_table;
	}

	level.weapon_rank_event = [];
	var_01 = 1;
	for(;;)
	{
		var_02 = tablelookup(var_00,0,var_01,1);
		if(!isdefined(var_02) || var_02 == "")
		{
			break;
		}

		var_03 = int(tablelookup(var_00,0,var_01,2));
		level.weapon_rank_event[var_02] = var_03;
		var_01++;
	}
}

//Function Number: 3
func_1285E(param_00,param_01,param_02,param_03)
{
	if(!level.onlinegame)
	{
		return;
	}

	if(isai(param_00) || !isplayer(param_00) || !func_13C3E() || !func_9D1B(param_00,param_01))
	{
		return;
	}

	var_04 = scripts\cp\_utility::func_7DF7(param_01);
	if(!func_13C48(var_04))
	{
		return;
	}

	func_831B(param_00,var_04,func_7D83(param_00,param_02,param_03));
}

//Function Number: 4
func_831B(param_00,param_01,param_02)
{
	var_03 = get_player_weapon_rank_cp_xp(param_00,param_01);
	var_04 = get_player_weapon_rank_mp_xp(param_00,param_01);
	var_05 = var_03 + var_04;
	var_06 = get_weapon_rank_for_xp(var_05);
	var_07 = func_7ACF(param_01);
	var_08 = func_7D65(param_01);
	var_09 = var_08 - var_04;
	var_0A = var_03 + param_02;
	if(var_0A > var_09)
	{
		var_0A = var_09;
	}

	var_0B = var_0A + var_04;
	var_0C = param_00 getplayerdata("common","sharedProgression","weaponLevel",param_01,"prestige");
	var_0D = int(min(get_weapon_rank_for_xp(var_0B),var_07));
	param_00 setplayerdata("common","sharedProgression","weaponLevel",param_01,"cpXP",var_0A);
	if(var_06 < var_0D)
	{
		param_00 scripts\cp\_hud_message::func_10151("ranked_up_weapon_" + param_01,var_0D + 1);
	}
}

//Function Number: 5
func_13C3E()
{
	if(scripts\common\utility::istrue(level.var_55A5))
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
func_9D1B(param_00,param_01)
{
	var_02 = param_00 scripts\cp\_persistence::func_7BAA();
	var_03 = scripts\cp\_utility::func_7DF7(param_01);
	var_04 = int(tablelookup("mp/unlocks/CPWeaponUnlocks.csv",0,var_03,7));
	if(var_02 >= var_04)
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
get_player_weapon_rank_cp_xp(param_00,param_01)
{
	var_02 = param_00 getplayerdata("common","sharedProgression","weaponLevel",param_01,"cpXP");
	return var_02;
}

//Function Number: 8
get_player_weapon_rank_mp_xp(param_00,param_01)
{
	var_02 = param_00 getplayerdata("common","sharedProgression","weaponLevel",param_01,"mpXP");
	return var_02;
}

//Function Number: 9
func_13C48(param_00)
{
	return func_13C19(param_00);
}

//Function Number: 10
func_13C19(param_00)
{
	if(!isdefined(level.var_13CBD.var_B4D4[param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 11
get_weapon_rank_for_xp(param_00)
{
	if(param_00 == 0)
	{
		return 0;
	}

	for(var_01 = get_max_weapon_rank() - 1;var_01 >= 0;var_01--)
	{
		if(param_00 >= get_weapon_rank_info_min_xp(var_01))
		{
			return var_01;
		}
	}

	return var_01;
}

//Function Number: 12
get_max_weapon_rank()
{
	return level.var_13CBD.var_B4C0;
}

//Function Number: 13
get_weapon_rank_info_min_xp(param_00)
{
	return level.var_13CBD.var_DCD4[param_00].var_B7CF;
}

//Function Number: 14
func_7D65(param_00)
{
	var_01 = func_7ACF(param_00);
	return func_7D6E(var_01);
}

//Function Number: 15
func_7ACF(param_00)
{
	return level.var_13CBD.var_B4D4[param_00];
}

//Function Number: 16
func_7D6E(param_00)
{
	return level.var_13CBD.var_DCD4[param_00].var_B4D6;
}

//Function Number: 17
func_7D83(param_00,param_01,param_02)
{
	var_03 = func_79A2(param_01);
	var_04 = func_79A3(param_02);
	var_05 = get_player_weapon_xp_scalar(param_00);
	var_06 = int(var_03 * var_04 * var_05);
	return var_06;
}

//Function Number: 18
func_12861(param_00,param_01,param_02,param_03,param_04)
{
	func_1285E(param_00,param_01,param_04,func_7D88(param_01,param_02,param_03,param_00));
}

//Function Number: 19
func_7D88(param_00,param_01,param_02,param_03)
{
	if(scripts\cp\_utility::func_9E27(param_00,param_01,param_02,param_03))
	{
		return "headshot";
	}

	return undefined;
}

//Function Number: 20
get_player_weapon_xp_scalar(param_00)
{
	if(isdefined(param_00.weaponxpscale))
	{
		return param_00.weaponxpscale;
	}

	return 1;
}

//Function Number: 21
func_79A2(param_00)
{
	if(!isdefined(level.weapon_rank_event[param_00]))
	{
		return 0;
	}

	return level.weapon_rank_event[param_00];
}

//Function Number: 22
func_79A3(param_00)
{
	if(!isdefined(param_00))
	{
		return 1;
	}

	switch(param_00)
	{
		case "headshot":
			return 1.5;

		default:
			break;
	}
}