/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\civilian\civilian_move.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 78 ms
 * Timestamp: 10/27/2023 1:52:59 AM
*******************************************************************/

//Function Number: 1
main()
{
	animscripts\move::main();
}

//Function Number: 2
civilian_noncombatmoveturn(param_00,param_01)
{
	var_02 = undefined;
	if(param_00 < -60 && param_00 > -120)
	{
		var_02 = level.scr_anim[self.animname]["turn_left_90"];
	}

	if(param_00 > 60 && param_00 < 120)
	{
		var_02 = level.scr_anim[self.animname]["turn_right_90"];
	}

	if(isdefined(var_02) && animscripts\move::pathchange_candoturnanim(var_02))
	{
		return var_02;
	}

	return undefined;
}

//Function Number: 3
civilian_combatmoveturn(param_00,param_01)
{
	var_02 = undefined;
	if(param_00 < -22.5)
	{
		if(param_00 > -45)
		{
			var_02 = %civilian_run_upright_turnl45;
		}
		else if(param_00 > -112.5)
		{
			var_02 = %civilian_run_upright_turnl90;
		}
		else if(param_00 > -157.5)
		{
			var_02 = %civilian_run_upright_turnl135;
		}
		else
		{
			var_02 = %civilian_run_upright_turn180;
		}
	}
	else if(param_00 > 22.5)
	{
		if(param_00 < 45)
		{
			var_02 = %civilian_run_upright_turnr45;
		}
		else if(param_00 < 112.5)
		{
			var_02 = %civilian_run_upright_turnr90;
		}
		else if(param_00 < 157.5)
		{
			var_02 = %civilian_run_upright_turnr135;
		}
		else
		{
			var_02 = %civilian_run_upright_turn180;
		}
	}

	if(isdefined(var_02) && animscripts\move::pathchange_candoturnanim(var_02))
	{
		return var_02;
	}

	return undefined;
}

//Function Number: 4
civilian_combathunchedmoveturn(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	if(param_00 < -22.5)
	{
		if(param_00 > -45)
		{
			var_02 = %civilian_run_hunched_turnl45;
		}
		else if(param_00 > -112.5)
		{
			var_02 = %civilian_run_hunched_turnl90;
			var_03 = animscripts\utility::randomanimoftwo(%civilian_run_hunched_turnl90_slide,%civilian_run_hunched_turnl90_stumble);
		}
		else if(param_00 > -157.5)
		{
			var_02 = %civilian_run_upright_turnl135;
		}
		else
		{
			var_02 = %civilian_run_upright_turn180;
		}
	}
	else if(param_00 > 22.5)
	{
		if(param_00 < 45)
		{
			var_02 = %civilian_run_hunched_turnr45;
		}
		else if(param_00 < 112.5)
		{
			var_02 = %civilian_run_hunched_turnr90;
			var_03 = animscripts\utility::randomanimoftwo(%civilian_run_hunched_turnr90_slide,%civilian_run_hunched_turnr90_stumble);
		}
		else if(param_00 < 157.5)
		{
			var_02 = %civilian_run_upright_turnr135;
		}
		else
		{
			var_02 = %civilian_run_upright_turn180;
		}
	}

	if(isdefined(var_03) && randomint(3) < 2 && animscripts\move::pathchange_candoturnanim(var_03))
	{
		return var_03;
	}

	if(isdefined(var_02) && animscripts\move::pathchange_candoturnanim(var_02))
	{
		return var_02;
	}

	return undefined;
}