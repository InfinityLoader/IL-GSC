/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\_createfx.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 168 ms
 * Timestamp: 10/27/2023 12:23:30 AM
*******************************************************************/

//Function Number: 1
func_49B4()
{
	level.var_74CF = ::scripts\common\utility::func_1352A;
	level.var_74D0 = ::func_74D0;
	level.var_74CC = ::scripts\common\fx::func_B059;
	level.var_74CD = ::scripts\common\fx::func_C51A;
	level.var_74C5 = ::scripts\common\fx::func_4917;
	level.var_74D3 = ::scripts\common\createfx::func_E2AB;
	level.var_74D2 = ::scripts\common\createfx::func_D978;
	level.var_74CE = ::func_74CE;
	level.var_BD5D = 1;
	level.var_3768 = ::scripts\common\utility::func_1352A;
	level.var_375F = ::scripts\common\utility::func_1352A;
	level.var_3761 = ::scripts\common\utility::func_1352A;
	level.callbackplayerdamage = ::scripts\common\utility::func_1352A;
	level.var_3763 = ::scripts\common\utility::func_1352A;
	level.var_375C = ::scripts\common\utility::func_1352A;
	level.var_3764 = ::scripts\common\utility::func_1352A;
	level.var_375F = ::func_374C;
	level.var_3766 = ::scripts\common\utility::func_1352A;
	thread scripts\common\createfx::func_74C7();
	scripts\common\createfx::func_49B9();
	level waittill("eternity");
}

//Function Number: 2
func_74D0(param_00)
{
	return level.player.origin;
}

//Function Number: 3
func_374C()
{
	self waittill("begin");
	if(!isdefined(level.player))
	{
		var_00 = getentarray("mp_global_intermission","classname");
		self spawn(var_00[0].origin,var_00[0].angles);
		scripts\cp\_utility::func_12F19("playing","");
		self.maxhealth = 10000000;
		self.health = 10000000;
		level.player = self;
		thread scripts\common\createfx::func_49CB();
		return;
	}

	kick(self getentitynumber());
}

//Function Number: 4
func_74CE()
{
	var_00 = level.var_11B7.var_D2C7 / 190;
	level.player setmovespeedscale(var_00);
}