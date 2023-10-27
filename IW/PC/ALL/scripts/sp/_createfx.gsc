/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_createfx.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 243 ms
 * Timestamp: 10/27/2023 12:23:59 AM
*******************************************************************/

//Function Number: 1
func_49B4()
{
	if(!level.createfx_enabled)
	{
		return;
	}

	function_02B0();
	level.var_74CF = ::func_74CF;
	level.var_74D0 = ::func_74D0;
	level.var_74D3 = ::scripts\common\createfx::func_E2AB;
	level.var_74D2 = ::scripts\common\createfx::func_D978;
	level.var_74CE = ::func_74CE;
	level.var_BD5D = 0;
	scripts\common\utility::func_227D(function_0072(),::delete);
	scripts\common\utility::func_227D(function_00C8(),::delete);
	var_00 = function_0072();
	scripts\common\utility::func_227D(var_00,::delete);
	scripts\common\createfx::func_49B9();
	thread scripts\common\createfx::func_49CB();
	thread scripts\common\createfx::func_74C7();
	level.player allowcrouch(0);
	level.player allowprone(0);
	func_49C3();
	level waittill("eternity");
}

//Function Number: 2
func_49C3()
{
	var_00 = [];
	var_00["trigger_multiple_createart_transient"] = ::scripts\sp\_trigger::func_1272E;
	foreach(var_04, var_02 in var_00)
	{
		var_03 = getentarray(var_04,"classname");
		scripts\common\utility::func_22A1(var_03,var_02);
	}
}

//Function Number: 3
func_74D0(param_00)
{
	if(distancesquared(param_00,level.player.origin) > 4096)
	{
		setdvar("createfx_playerpos_x",level.player.origin[0]);
		setdvar("createfx_playerpos_y",level.player.origin[1]);
		setdvar("createfx_playerpos_z",level.player.origin[2]);
	}

	return level.player.origin;
}

//Function Number: 4
func_74CF()
{
	var_00 = [];
	var_00[0] = getdvarint("createfx_playerpos_x");
	var_00[1] = getdvarint("createfx_playerpos_y");
	var_00[2] = getdvarint("createfx_playerpos_z");
	level.player setorigin((var_00[0],var_00[1],var_00[2]));
	level.player setplayerangles((0,level.player.angles[1],0));
}

//Function Number: 5
func_74CE()
{
	function_01C5("g_speed",level.var_11B7.var_D2C7);
}