/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2914.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:24:54 AM
*******************************************************************/

//Function Number: 1
func_96E9(param_00,param_01,param_02)
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
		level.var_EC87["player_rig"] = #animtree;
		level.var_EC8C["player_rig"] = param_00;
	}

	if(isdefined(param_01))
	{
		level.var_EC87["player_legs"] = #animtree;
		level.var_EC8C["player_legs"] = param_01;
	}

	if(isdefined(param_02))
	{
		func_96DA(param_02);
	}
}

//Function Number: 2
func_96EA(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		level.var_EC87["player_rig"] = #animtree;
		level.var_EC8C["player_rig"] = param_00;
	}

	if(isdefined(param_01))
	{
		level.var_EC87["player_legs"] = #animtree;
		level.var_EC8C["player_legs"] = param_01;
	}

	if(isdefined(param_02))
	{
		func_96DA(param_02);
	}
}

//Function Number: 3
func_96DA(param_00)
{
	level.var_EC8C["player_body"] = param_00;
	level.var_EC87["player_body"] = #animtree;
}

//Function Number: 4
func_7BAD(param_00)
{
	if(!isdefined(level.var_D267))
	{
		level.var_D267 = scripts\sp\_utility::func_10639("player_rig");
		param_00 = 1;
	}

	if(isdefined(param_00))
	{
		level.var_D267.origin = level.player.origin;
		level.var_D267.angles = level.player.angles;
	}

	return level.var_D267;
}

//Function Number: 5
func_7BA2()
{
	if(!isdefined(level.var_D1CE))
	{
		level.var_D1CE = scripts\sp\_utility::func_10639("player_legs");
		level.var_D1CE.origin = level.player.origin;
		level.var_D1CE.angles = level.player.angles;
	}

	return level.var_D1CE;
}

//Function Number: 6
func_7B88()
{
	if(!isdefined(level.var_CF98))
	{
		level.var_CF98 = scripts\sp\_utility::func_10639("player_body");
		level.var_CF98.origin = level.player.origin;
		level.var_CF98.angles = level.player.angles;
	}

	return level.var_CF98;
}

//Function Number: 7
func_AD09(param_00,param_01,param_02,param_03)
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

	var_04 = func_7BAD();
	var_04 show();
	level.player playerlinktoabsolute(var_04,"tag_player");
	level.player playerlinktodelta(var_04,"tag_player",1,param_00,param_01,param_02,param_03,1);
}

//Function Number: 8
func_2B7C(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.7;
	}

	var_01 = func_7BAD();
	var_01 show();
	level.player playerlinktoblend(var_01,"tag_player",param_00);
}