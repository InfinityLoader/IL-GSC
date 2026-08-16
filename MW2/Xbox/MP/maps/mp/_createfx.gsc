/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_createfx.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

createfx()
{
	level.func_position_player = ::common_scripts\utility::void;
	level.func_position_player_get = ::func_position_player_get;
	level.func_loopfxthread = ::common_scripts\_fx::loopfxthread;
	level.func_oneshotfxthread = ::common_scripts\_fx::oneshotfxthread;
	level.func_create_loopsound = ::common_scripts\_fx::create_loopsound;
	level.func_updatefx = ::common_scripts\_createfx::restart_fx_looper;
	level.func_process_fx_rotater = ::common_scripts\_createfx::process_fx_rotater;
	level.mp_createfx = 1;
	level.callbackstartgametype = ::common_scripts\utility::void;
	level.callbackplayerconnect = ::common_scripts\utility::void;
	level.callbackplayerdisconnect = ::common_scripts\utility::void;
	level.callbackplayerdamage = ::common_scripts\utility::void;
	level.callbackplayerkilled = ::common_scripts\utility::void;
	level.callbackcodeendgame = ::common_scripts\utility::void;
	level.callbackplayerlaststand = ::common_scripts\utility::void;
	level.callbackplayerconnect = ::callback_playerconnect;
	level.callbackplayermigrated = ::common_scripts\utility::void;
	thread common_scripts\_createfx::func_get_level_fx();
	common_scripts\_createfx::createfx_common();
	level waittill("eternity");
}

func_position_player_get(lastplayerorigin)
{
	return level.player.origin;
}

callback_playerconnect()
{
	self waittill("begin");
	if(!isdefined(level.player))
	{
		spawnpoints = getentarray("mp_global_intermission", "classname");
		self spawn(spawnpoints[0].origin, spawnpoints[0].angles);
		maps\mp\gametypes\_playerlogic::updatesessionstate("playing", "");
		self.maxhealth = 10000000;
		self.health = 10000000;
		level.player = self;
		thread common_scripts\_createfx::createfxlogic();
		thread ufo_mode();
		return;
	}

	kick(self getentitynumber());
}

ufo_mode()
{
	level.player openpopupmenu("painter_mp");
	level.player closepopupmenu("painter_mp");
}