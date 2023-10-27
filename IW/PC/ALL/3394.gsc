/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3394.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:26:55 AM
*******************************************************************/

//Function Number: 1
func_DDAE(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	var_02 = 0;
	var_03 = scripts\cp\_utility::func_78B4(param_01.origin);
	var_04 = 5184;
	var_05 = anglestoforward(var_03.angles);
	var_05 = scripts\cp\_utility::func_13192(var_05,-200);
	var_06 = var_03.origin + var_05;
	param_01.var_DDB0 = param_00;
	while(!level.var_7669 && isdefined(param_01) && scripts\cp\_utility::func_9F19(param_01) && param_01 usebuttonpressed() && !isdefined(param_01.var_1B3) || !param_01.var_1B3)
	{
		if(distancesquared(param_01.origin,param_00.origin) > var_04)
		{
			break;
		}

		var_07 = 10;
		var_08 = var_07;
		var_09 = var_03.var_284D.var_C1DE < 6;
		if(isdefined(level.var_3B0F))
		{
			var_07 = 10 * level.var_3B0F;
			if(level.var_3B0F > 1)
			{
				var_08 = int(var_08 / 2);
			}
		}

		var_0A = lib_0D4D::func_7B13(var_03);
		if(!isdefined(var_0A))
		{
			wait(0.5);
			break;
		}

		if(param_01 scripts\cp\_utility::func_9BA0("faster_window_reboard"))
		{
			var_07 = 50 * var_0A * level.var_3B0F;
			var_08 = var_08 * var_0A;
			level func_DDB8(var_03);
			level notify("reboard",1,param_01);
			for(var_0B = 0;var_0B < var_0A;var_0B++)
			{
				param_01 scripts\cp\_merits::func_D9AD("mt_rebuild_barriers");
			}

			param_01 notify("window_reboard_notify");
			param_01 scripts\cp\_utility::func_C151("faster_window_reboard");
		}
		else
		{
			lib_0D4D::func_F2E3(var_03,var_0A - 1,"repairing");
			func_DDB6(var_03,var_0A,var_06,param_00,param_01);
			level notify("reboard",1,param_01);
			param_01 scripts\cp\_merits::func_D9AD("mt_rebuild_barriers");
			param_01 notify("window_reboard_notify");
			lib_0D4D::func_F2E3(var_03,var_0A - 1,"boarded");
		}

		param_01.var_DDAF = param_01.var_DDAF + var_08;
		if(isdefined(param_01.var_DDAF) && param_01.var_DDAF <= level.var_B41F && var_09)
		{
			param_01 playlocalsound("purchase_generic");
			param_01 thread scripts\cp\_vo::try_to_play_vo("reinforce_window","zmb_comment_vo","low",10,0,0,0,10);
			var_02 = 1;
			param_01 scripts\cp\_persistence::func_82F9(var_07);
		}

		var_03.var_284D.var_C1DE++;
		if(var_03.var_284D.var_C1DE > 6)
		{
			var_03.var_284D.var_C1DE = 6;
		}

		if(!isdefined(lib_0D4D::func_7B13(var_03)))
		{
			break;
		}
	}

	param_01.var_DDB0 = undefined;
	if(var_03.var_284D.var_C1DE == 6)
	{
		param_01 thread scripts\cp\_vo::try_to_play_vo("reinforce_window","zmb_comment_vo","low",10,0,0,1,25);
	}

	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 2
func_DDB4(param_00)
{
	var_01 = sortbydistance(level.var_13D59,param_00.origin);
	foreach(var_03 in var_01)
	{
		if(scripts\cp\_utility::func_664F(var_03))
		{
			continue;
		}

		level thread func_DDB8(var_03);
		wait(0.5);
	}

	var_05 = 200;
	if(isdefined(level.var_3B0F))
	{
		var_05 = 200 * level.var_3B0F;
	}

	foreach(var_07 in level.players)
	{
		if(scripts\common\utility::istrue(var_07.inlaststand))
		{
			continue;
		}

		var_07 scripts\cp\_persistence::func_82F9(var_05,undefined,undefined,1,"carpenter");
	}
}

//Function Number: 3
func_DDB8(param_00)
{
	var_01 = anglestoforward(param_00.angles);
	var_01 = scripts\cp\_utility::func_13192(var_01,-200);
	var_02 = param_00.origin + var_01;
	var_03 = scripts\common\utility::getclosest(param_00.origin,level.current_interaction_structs);
	var_04 = 0;
	while(!scripts\cp\_utility::func_664F(param_00))
	{
		if(scripts\cp\_utility::func_664F(param_00))
		{
			return;
		}

		var_05 = lib_0D4D::func_7B13(param_00);
		if(!isdefined(var_05))
		{
			return;
		}

		func_DDB7(param_00,var_05,var_02,var_03);
	}
}

//Function Number: 4
func_DDB7(param_00,param_01,param_02,param_03)
{
	lib_0D4D::func_F2E3(param_00,param_01 - 1,"boarded");
	param_00.var_284D lib_0D4D::func_F2D7("board_" + param_01,"instant_repair");
	wait(0.25);
	param_00.var_284D.var_C1DE++;
	if(param_00.var_284D.var_C1DE > 6)
	{
		param_00.var_284D.var_C1DE = 6;
	}
}

//Function Number: 5
func_DDB6(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 scripts\cp\_utility::has_zombie_perk("perk_machine_flash"))
	{
		var_05 = 0.5;
		param_00.var_284D lib_0D4D::func_F2D7("board_" + param_01,"fast_repair");
	}
	else
	{
		var_05 = 1;
		param_00.var_284D lib_0D4D::func_F2D7("board_" + param_01,"repair");
	}

	wait(var_05);
}

//Function Number: 6
register_interactions()
{
	if(isdefined(level.reboard_barriers_hint))
	{
		level.interaction_hintstrings["secure_window"] = level.reboard_barriers_hint;
	}
	else
	{
		level.interaction_hintstrings["secure_window"] = &"CP_ZMB_INTERACTIONS_SECURE_WINDOW";
	}

	scripts\cp\_interaction::func_DEBB("secure_window","window_board",1,undefined,::func_DDAE,0);
}