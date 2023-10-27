/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3408.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:27:06 AM
*******************************************************************/

//Function Number: 1
func_12850(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.var_8C46) && func_3804(param_01) && isdefined(param_01.var_B0A2) && param_01.var_B0A2 == param_00)
	{
		func_E2CD(param_01);
	}

	level.var_1192B++;
}

//Function Number: 2
func_EB61(param_00)
{
	func_4174(param_00);
	var_01 = undefined;
	var_02 = scripts\common\utility::getstructarray("lost_and_found","script_noteworthy");
	var_02 = scripts\common\utility::func_22A8(var_02);
	foreach(var_04 in var_02)
	{
		if(scripts\common\utility::func_2286(level.current_interaction_structs,var_04))
		{
			var_01 = var_04;
		}
	}

	if(!isdefined(var_01))
	{
		var_01 = scripts\common\utility::random(var_02);
	}

	var_06 = spawn("script_model",var_01.origin + (0,0,45));
	var_06 func_110A6(var_06,param_00);
	var_06 thread func_B09F(var_06,param_00);
	param_00 thread func_50CC(param_00,var_06);
	param_00.var_B0A2 = var_01;
	param_00.var_B0A0 = var_06;
}

//Function Number: 3
func_50CC(param_00,param_01)
{
	param_00 endon("disconnect");
	scripts\common\utility::func_136F7();
	if(isdefined(param_00.var_B0A0))
	{
		param_00 setclientomnvar("zm_lostandfound_target",param_01);
		param_00 setclientomnvar("zm_lostandfound_timer",1);
	}
}

//Function Number: 4
func_110A6(param_00,param_01)
{
	param_00.var_4643 = param_01.var_4643;
	param_00.var_464B = param_01.var_464B;
	param_00.var_4648 = param_01.var_4648;
	param_00.var_464A = param_01.var_464A;
	if(isdefined(param_01.saved_last_stand_pistol))
	{
		param_00.var_A913 = param_01.saved_last_stand_pistol;
		param_01.saved_last_stand_pistol = undefined;
	}
	else
	{
		param_00.var_A913 = param_01.var_A913;
	}

	param_00.var_13C24 = param_01.var_464C;
	if(isdefined(param_01.var_4B5E))
	{
		param_00.var_4640 = param_01.var_4B5E;
		param_01 scripts\cp\_utility::func_DFE1();
	}
	else if(isdefined(param_01.puzzle_piece))
	{
		param_01 scripts\cp\_utility::func_DFE1();
	}

	if(isdefined(param_01.var_4B5C))
	{
		param_00.var_4B5C = param_01.var_4B5C;
		param_01.var_4B5C = undefined;
		param_01 setclientomnvar("zom_crafted_weapon",0);
	}

	param_00.var_4639 = param_01 lib_0D5D::func_7924();
	param_00.var_463A = param_01.var_D7CD;
	param_00.var_4647 = param_01.var_10932;
	if(param_01.var_4643.size > 2)
	{
		param_01.var_B0A0 = param_00;
		param_01.var_8C46 = 1;
	}
}

//Function Number: 5
func_E2CD(param_00)
{
	param_00 notify("weapon_purchased");
	var_01 = param_00.var_B0A0;
	param_00 method_83B7();
	param_00.var_4643 = var_01.var_4643;
	param_00.var_464B = var_01.var_464B;
	param_00.var_4648 = var_01.var_4648;
	param_00.var_464A = var_01.var_464A;
	param_00.var_463A = var_01.var_463A;
	param_00.var_464C = var_01.var_13C24;
	param_00 scripts\cp\_utility::func_E2D2();
	param_00 scripts\cp\_utility::func_E2D4();
	param_00 scripts\cp\powers\coop_powers::func_E2D1(param_00,param_00.var_463A);
	if(isdefined(var_01.var_4640))
	{
		param_00.var_4B5E = var_01.var_4640;
		param_00 [[ level.crafting_icon_create_func ]](param_00.var_4B5E);
	}

	if(isdefined(var_01.var_4B5C))
	{
		level thread [[ var_01.var_4B5C.var_E2C3 ]](undefined,param_00);
	}

	param_00.var_10932 = var_01.var_4647;
	param_00.var_8C46 = 0;
	param_00 thread scripts\cp\_utility::func_1308C(param_00,"iw7_pickup_zm");
	param_00.var_A913 = var_01.var_A913;
	param_00 notify("lost_and_found_collected");
	param_00.var_B0A1 = undefined;
}

//Function Number: 6
func_3804(param_00)
{
	if(scripts\cp\_laststand::player_in_laststand(param_00))
	{
		return 0;
	}

	if(!param_00 scripts\common\utility::func_A009())
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.kung_fu_mode))
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
func_B09F(param_00,param_01)
{
	level endon("game_ended");
	param_01 thread func_B0A3(param_00,param_01);
	param_01 scripts\common\utility::waittill_any_3("disconnect","clear_previous_tombstone","lost_and_found_collected","lost_and_found_time_out");
	if(isdefined(param_01))
	{
		param_01 setclientomnvar("zm_lostandfound_timer",0);
		param_01 setclientomnvar("zm_lostandfound_target",undefined);
		scripts\cp\zombies\zombie_analytics::func_AF78(level.var_1192B,level.var_1192C,level.var_1192D);
	}

	param_00 delete();
}

//Function Number: 8
func_B0A3(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("death");
	param_01 endon("disconnect");
	param_01 endon("death");
	param_01 endon("clear_previous_tombstone");
	param_01 endon("lost_and_found_collected");
	param_01 endon("lost_and_found_time_out");
	var_02 = 0;
	while(var_02 <= 90)
	{
		wait(0.5);
		var_02 = var_02 + 0.5;
		var_03 = 90 - var_02 / 90;
		param_01 setclientomnvar("zm_lostandfound_timer",var_03);
	}

	level.var_1192C++;
	param_01.var_8C46 = 0;
	param_01.var_B0A1 = undefined;
	param_01 notify("lost_and_found_time_out");
}

//Function Number: 9
func_4174(param_00)
{
	param_00 notify("clear_previous_tombstone");
}

//Function Number: 10
func_DE48(param_00)
{
	var_01 = param_00 getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(scripts\cp\_weapon::func_9E02(var_03) || scripts\cp\_weapon::func_9F79(var_03))
		{
			param_00 setweaponammoclip(var_03,weaponclipsize(var_03));
		}
	}
}

//Function Number: 11
func_9671()
{
	if(isdefined(level.lost_and_found_func))
	{
		[[ level.lost_and_found_func ]]();
	}
}

//Function Number: 12
func_7ABB(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return "";
	}

	if(scripts\common\utility::istrue(param_01.var_8C46))
	{
		if(func_3804(param_01))
		{
			var_02 = scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player);
			if(isdefined(param_01.var_B0A2) && param_01.var_B0A2 == param_00)
			{
				if(isdefined(param_01.var_B0A1) && param_01.var_B0A1.size > 2)
				{
					if(var_02)
					{
						return &"ZOMBIE_LOST_AND_FOUND_COLLECT_2_SOLO";
					}

					return &"ZOMBIE_LOST_AND_FOUND_COLLECT_2";
				}

				if(var_02)
				{
					return &"ZOMBIE_LOST_AND_FOUND_COLLECT_1_SOLO";
				}

				return &"ZOMBIE_LOST_AND_FOUND_COLLECT_1";
			}

			return &"ZOMBIE_LOST_AND_FOUND_ITEM_AT_NEXT_WINDOW";
		}

		return &"ZOMBIE_LOST_AND_FOUND_CANNOT_COLLECT";
	}

	return &"ZOMBIE_LOST_AND_FOUND_NO_ITEM";
}

//Function Number: 13
register_interactions()
{
	scripts\cp\_interaction::func_DEBB("lost_and_found","lost_and_found",1,::func_7ABB,::func_12850,2000,0,::func_9671);
}