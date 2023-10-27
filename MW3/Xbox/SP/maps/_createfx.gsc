/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_createfx.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 3
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 2:34:21 AM
*******************************************************************/

//Function Number: 1
createfx()
{
	level.func_position_player = ::func_position_player;
	level.func_position_player_get = ::func_position_player_get;
	level.func_loopfxthread = ::common_scripts\_fx::loopfxthread;
	level.func_oneshotfxthread = ::common_scripts\_fx::oneshotfxthread;
	level.func_create_loopsound = ::common_scripts\_fx::create_loopsound;
	level.func_updatefx = ::common_scripts\_createfx::restart_fx_looper;
	level.func_process_fx_rotater = ::common_scripts\_createfx::process_fx_rotater;
	level.mp_createfx = 0;
	var_00 = getaiarray();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] delete();
	}

	thread common_scripts\_createfx::createfxlogic();
	thread common_scripts\_createfx::func_get_level_fx();
	common_scripts\_createfx::createfx_common();
	level waittill("eternity");
}

//Function Number: 2
func_position_player_get(param_00)
{
	if(distance(param_00,level.player.origin) > 64)
	{
		setdvar("createfx_playerpos_x",level.player.origin[0]);
		setdvar("createfx_playerpos_y",level.player.origin[1]);
		setdvar("createfx_playerpos_z",level.player.origin[2]);
	}

	return level.player.origin;
}

//Function Number: 3
func_position_player()
{
	var_00 = [];
	level.player setorigin((var_41[0],var_41[1],var_41[2]));
}