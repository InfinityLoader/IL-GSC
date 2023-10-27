/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\gametypes\common.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 568 ms
 * Timestamp: 10/27/2023 12:12:19 AM
*******************************************************************/

//Function Number: 1
func_FA9C()
{
	level.var_C55E = ::func_C55E;
	level.var_C5AA = ::func_C5AA;
	level.var_C5B0 = ::func_C5B0;
	scripts\mp\_utility::func_DEEB(level.gametype,0);
	level._effect["protection_cameraFX"] = loadfx("vfx/iw7/_requests/mp/vfx_adrenaline_drip_heal_scrn.vfx");
}

//Function Number: 2
func_12E9F()
{
	level.var_58C2 = scripts\mp\_utility::func_9FB3(scripts\mp\_utility::getwatcheddvar("dogtags"));
	if(level.var_58C2)
	{
		scripts\mp\gametypes\obj_dogtag::init();
	}
}

//Function Number: 3
func_C55E(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.var_EC3D["death"] * -1;
	if(var_05 != 0)
	{
		if(level.teambased)
		{
			level scripts\mp\_gamescore::func_83B0(param_00.pers["team"],var_05,0);
		}
		else
		{
			param_01 scripts\mp\_gamescore::func_8392("kill",var_05);
		}
	}

	var_06 = level.var_EC3D["kill"];
	if(param_03 == "MOD_HEAD_SHOT")
	{
		var_06 = var_06 + level.var_EC3D["headshot"];
	}

	if(scripts\mp\_utility::func_9FB3(level.var_112C0))
	{
		if(scripts\mp\_utility::func_B3EC() && isdefined(param_01.var_47ED))
		{
			var_06 = var_06 + 1;
			param_01 thread scripts\mp\_rank::func_EC2D("teamscore_notify_" + var_06);
		}

		param_01 scripts\mp\_utility::func_C4DB(param_00,param_01,param_02);
	}

	if(var_06 != 0)
	{
		if(level.teambased)
		{
			level scripts\mp\_gamescore::func_83B0(param_01.pers["team"],var_06,0);
		}
		else
		{
			param_01 scripts\mp\_gamescore::func_8392("kill",var_06);
		}
	}

	if(level.var_58C2 && scripts\mp\_utility::func_766C("prematch_done"))
	{
		level thread scripts\mp\gametypes\obj_dogtag::func_10849(param_00,param_01,"new_tag_spawned");
	}
}

//Function Number: 4
func_C5AA(param_00)
{
	if(scripts\mp\_utility::func_9FB3(level.var_112C0))
	{
		param_00 scripts\mp\_utility::func_40EF();
	}

	if(isdefined(level.var_EC3D))
	{
		var_01 = level.var_EC3D["death"] * -1;
		if(var_01 != 0)
		{
			if(level.teambased)
			{
				level scripts\mp\_gamescore::func_83B0(param_00.pers["team"],var_01,0);
				return;
			}
		}
	}
}

//Function Number: 5
func_C5B0(param_00)
{
	if(scripts\mp\_utility::func_9FB3(level.var_112C0))
	{
		param_00 scripts\mp\_utility::func_40EF();
	}
}

//Function Number: 6
func_58BE(param_00)
{
}

//Function Number: 7
func_58BF(param_00)
{
}

//Function Number: 8
onspawnplayer()
{
	if(scripts\mp\_utility::func_9FB3(level.var_10903) && !scripts\mp\_spawnlogic::func_100BA())
	{
		thread func_B2F2();
	}
}

//Function Number: 9
func_B2F2()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("remove_spawn_protection");
	thread func_20DC();
	wait(level.var_10903);
	func_E171();
}

//Function Number: 10
func_20DC()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self endon("remove_spawn_protection");
	self waittill("spawned_player");
	self setclientomnvar("ui_uplink_carrier_hud",1);
	self.var_10902 = 1;
	scripts\mp\_lightarmor::func_F786(self,1000,undefined,1);
	self setclientomnvar("ui_uplink_carrier_armor",100);
	self setclientomnvar("ui_uplink_carrier_armor_max",100);
}

//Function Number: 11
func_E171()
{
	if(isdefined(self))
	{
		self setclientomnvar("ui_uplink_carrier_hud",0);
		self.var_10902 = 0;
	}

	scripts\mp\_lightarmor::func_ACAC(self);
	self setclientomnvar("ui_uplink_carrier_armor",-1);
	self notify("remove_spawn_protection");
}