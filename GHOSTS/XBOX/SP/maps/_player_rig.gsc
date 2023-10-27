/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_player_rig.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 5
 * Decompile Time: 74 ms
 * Timestamp: 10/27/2023 1:37:23 AM
*******************************************************************/

//Function Number: 1
init_player_rig(param_00,param_01)
{
	if(isdefined(param_00))
	{
		precachemodel(param_00);
	}

	if(isdefined(param_01))
	{
		precachemodel(param_01);
	}

	if(isdefined(param_00))
	{
		level.var_6AED["layer_rig"] = #animtree;
		level.var_6AF3["player_rig"] = param_00;
	}

	if(isdefined(param_01))
	{
		level.var_6AED["layer_legs"] = #animtree;
		level.var_6AF3["player_legs"] = param_01;
	}
}

//Function Number: 2
get_player_rig()
{
	if(!isdefined(level.var_5EE4))
	{
		level.var_5EE4 = maps\_utility::func_777F("player_rig");
		level.var_5EE4.origin = level.player.origin;
		level.var_5EE4.angles = level.player.angles;
	}

	return level.var_5EE4;
}

//Function Number: 3
func_3945()
{
	if(!isdefined(level.var_5E7A))
	{
		level.var_5E7A = maps\_utility::func_777F("player_legs");
		level.var_5E7A.origin = level.player.origin;
		level.var_5E7A.angles = level.player.angles;
	}

	return level.var_5E7A;
}

//Function Number: 4
func_4E2D(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		param_00 = 30;
	}

	if(!isdefined(param_01))
	{
		param_01 = 30;
	}

	if(!isdefined(param_02))
	{
		param_02 = 30;
	}

	if(!isdefined(param_03))
	{
		param_03 = 30;
	}

	var_04 = get_player_rig();
	var_04 show();
	level.player playerlinktoabsolute(var_04,"tag_player");
	level.player playerlinktodelta(var_04,"tag_player",1,param_00,param_01,param_02,param_03,1);
}

//Function Number: 5
blend_player_to_arms(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.7;
	}

	var_01 = get_player_rig();
	var_01 show();
	level.player playerlinktoblend(var_01,"tag_player",param_00);
}