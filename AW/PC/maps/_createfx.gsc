/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _createfx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 102 ms
 * Timestamp: 4/22/2024 2:20:29 AM
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
	level.func_player_speed = ::func_player_speed;
	level.mp_createfx = 0;
	common_scripts\utility::array_call(getaiarray(),::delete);
	common_scripts\utility::array_call(getspawnerarray(),::delete);
	var_00 = getaiarray();
	common_scripts\utility::array_call(var_00,::delete);
	common_scripts\_createfx::createfx_common();
	thread common_scripts\_createfx::createfxlogic();
	thread common_scripts\_createfx::func_get_level_fx();
	level.player allowcrouch(0);
	level.player allowprone(0);
	createfx_only_triggers();
	level waittill("eternity");
}

//Function Number: 2
createfx_only_triggers()
{
	var_00 = [];
	var_00["trigger_createart_transient"] = ::maps\_trigger::trigger_createart_transient;
	foreach(var_04, var_02 in var_00)
	{
		var_03 = getentarray(var_04,"classname");
		common_scripts\utility::array_levelthread(var_03,var_02);
	}
}

//Function Number: 3
func_position_player_get(param_00)
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
func_position_player()
{
	var_00 = [];
	var_00[0] = getdvarint("createfx_playerpos_x");
	var_00[1] = getdvarint("createfx_playerpos_y");
	var_00[2] = getdvarint("createfx_playerpos_z");
	level.player setorigin((var_00[0],var_00[1],var_00[2]));
}

//Function Number: 5
func_player_speed()
{
	setsaveddvar("g_speed",level._createfx.player_speed);
}