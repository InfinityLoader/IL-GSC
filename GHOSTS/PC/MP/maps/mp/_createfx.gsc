/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_createfx.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 86 ms
 * Timestamp: 10/27/2023 1:22:08 AM
*******************************************************************/

//Function Number: 1
createfx()
{
	level.func_position_player = ::common_scripts\utility::func_8A42;
	level.func_position_player_get = ::func_position_player_get;
	level.func_loopfxthread = ::common_scripts\_fx::func_4F7C;
	level.func_oneshotfxthread = ::common_scripts\_fx::func_592D;
	level.func_create_loopsound = ::common_scripts\_fx::create_loopsound;
	level.func_updatefx = ::common_scripts\_createfx::func_6641;
	level.func_process_fx_rotater = ::common_scripts\_createfx::func_61C5;
	level.func_player_speed = ::func_player_speed;
	level.mp_createfx = 1;
	level.callbackstartgametype = ::common_scripts\utility::func_8A42;
	level.callbackplayerconnect = ::common_scripts\utility::func_8A42;
	level.callbackplayerdisconnect = ::common_scripts\utility::func_8A42;
	level.callbackplayerdamage = ::common_scripts\utility::func_8A42;
	level.callbackplayerkilled = ::common_scripts\utility::func_8A42;
	level.callbackcodeendgame = ::common_scripts\utility::func_8A42;
	level.callbackplayerlaststand = ::common_scripts\utility::func_8A42;
	level.callbackplayerconnect = ::callback_playerconnect;
	level.callbackplayermigrated = ::common_scripts\utility::func_8A42;
	thread common_scripts\_createfx::func_get_level_fx();
	common_scripts\_createfx::func_20E7();
	level waittill("eternity");
}

//Function Number: 2
func_position_player_get(param_00)
{
	return level.player.origin;
}

//Function Number: 3
callback_playerconnect()
{
	self waittill("begin");
	if(!isdefined(level.player))
	{
		var_00 = getentarray("mp_global_intermission","classname");
		self spawn(var_00[0].origin,var_00[0].angles);
		maps\mp\_utility::func_8730("playing","");
		self.maxhealth = 10000000;
		self.health = 10000000;
		level.player = self;
		thread common_scripts\_createfx::createfxlogic();
	}

	kick(self getentitynumber());
}

//Function Number: 4
func_player_speed()
{
	var_00 = level.var_658.player_speed / 190;
	level.player setmovespeedscale(var_00);
}