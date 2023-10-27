/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_remotemissile.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 511 ms
 * Timestamp: 10/27/2023 12:29:25 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_B897 = 14000;
	level.var_B895 = 7000;
	level.var_B896 = 1500;
	level.var_E5DE = [];
	scripts\mp\killstreaks\_killstreaks::func_DEFB("predator_missile",::func_128F6);
	level.var_DF7E["explode"] = loadfx("vfx/core/expl/aerial_explosion");
}

//Function Number: 2
func_128F6(param_00,param_01)
{
	scripts\mp\_utility::func_FB09("remotemissile");
	var_02 = scripts\mp\killstreaks\_killstreaks::func_98C2();
	if(var_02 != "success")
	{
		if(var_02 != "disconnect")
		{
			scripts\mp\_utility::func_41E9();
		}

		return 0;
	}

	self setclientomnvar("ui_predator_missile",1);
	level thread func_1282(param_00,self);
	return 1;
}

//Function Number: 3
func_7E01(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_03.var_1314F = [];
		var_03.var_10909 = 0;
	}

	foreach(var_06 in level.players)
	{
		if(!scripts\mp\_utility::func_9F19(var_06))
		{
			continue;
		}

		if(var_06.team == self.team)
		{
			continue;
		}

		if(var_06.team == "spectator")
		{
			continue;
		}

		var_07 = 999999999;
		var_08 = undefined;
		foreach(var_03 in param_00)
		{
			var_03.var_1314F[var_03.var_1314F.size] = var_06;
			var_0A = distance2d(var_03.var_1155F.origin,var_06.origin);
			if(var_0A <= var_07)
			{
				var_07 = var_0A;
				var_08 = var_03;
			}
		}

		var_08.var_10909 = var_08.var_10909 + 2;
	}

	var_0D = param_00[0];
	foreach(var_03 in param_00)
	{
		foreach(var_10, var_06 in var_03.var_1314F)
		{
			var_03.var_10909 = var_03.var_10909 + 1;
			if(bullettracepassed(var_06.origin + (0,0,32),var_03.origin,0,var_06))
			{
				var_03.var_10909 = var_03.var_10909 + 3;
			}

			if(var_03.var_10909 > var_0D.var_10909)
			{
				var_0D = var_03;
				continue;
			}

			if(var_03.var_10909 == var_0D.var_10909)
			{
				if(scripts\common\utility::func_4347())
				{
					var_0D = var_03;
				}
			}
		}
	}

	return var_0D;
}

//Function Number: 4
func_1282(param_00,param_01)
{
	var_02 = getentarray("remoteMissileSpawn","targetname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.target))
		{
			var_04.var_1155F = getent(var_04.target,"targetname");
		}
	}

	if(var_02.size > 0)
	{
		var_06 = param_01 func_7E01(var_02);
	}
	else
	{
		var_06 = undefined;
	}

	if(isdefined(var_06))
	{
		var_07 = var_06.origin;
		var_08 = var_06.var_1155F.origin;
		var_09 = vectornormalize(var_07 - var_08);
		var_07 = var_09 * 14000 + var_08;
		var_0A = scripts\mp\_utility::func_1309("remotemissile_projectile_mp",var_07,var_08,param_01);
	}
	else
	{
		var_0B = (0,0,level.var_B897);
		var_0C = level.var_B895;
		var_0D = level.var_B896;
		var_0E = anglestoforward(param_01.angles);
		var_07 = param_01.origin + var_0B + var_0E * var_0C * -1;
		var_08 = param_01.origin + var_0E * var_0D;
		var_0A = scripts\mp\_utility::func_1309("remotemissile_projectile_mp",var_07,var_08,param_01);
	}

	if(!isdefined(var_0A))
	{
		param_01 scripts\mp\_utility::func_41E9();
		return;
	}

	var_0A.team = param_01.team;
	var_0A thread func_898C();
	var_0A.var_AC68 = param_00;
	var_0A.type = "remote";
	level.var_DF80 = 1;
	func_B889(param_01,var_0A);
}

//Function Number: 5
func_898C()
{
	self endon("death");
	self endon("deleted");
	self setcandamage(1);
	self waittill("damage");
}

//Function Number: 6
func_B889(param_00,param_01)
{
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	param_01 thread func_E5C5();
	param_00 thread func_CFC7(param_01);
	param_00 thread func_CFC8(param_01);
	param_00 visionsetmissilecamforplayer("black_bw",0);
	param_00 endon("disconnect");
	if(isdefined(param_01))
	{
		param_00 visionsetmissilecamforplayer(game["thermal_vision"],1);
		param_00 thermalvisionon();
		param_00 thread func_50FF();
		param_00 cameralinkto(param_01,"tag_origin");
		param_00 controlslinkto(param_01);
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 scripts\mp\_utility::setthirdpersondof(0);
		}

		param_01 waittill("death");
		param_00 thermalvisionoff();
		if(isdefined(param_01))
		{
			param_00 scripts\mp\_matchdata::func_AFC9("predator_missile",param_01.origin);
		}

		param_00 controlsunlink();
		param_00 scripts\mp\_utility::func_7385(1);
		if(!level.var_7669)
		{
			param_00 setclientomnvar("ui_predator_missile",2);
		}

		wait(0.5);
		param_00 thermalvisionfofoverlayoff();
		param_00 cameraunlink();
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 scripts\mp\_utility::setthirdpersondof(1);
		}
	}

	param_00 setclientomnvar("ui_predator_missile",0);
	param_00 scripts\mp\_utility::func_41E9();
}

//Function Number: 7
func_50FF()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.15);
	self thermalvisionfofoverlayon();
}

//Function Number: 8
func_CFC8(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	scripts\common\utility::waittill_any_3("joined_team","joined_spectators");
	if(self.team != "spectator")
	{
		self thermalvisionfofoverlayoff();
		self controlsunlink();
		self cameraunlink();
		if(getdvarint("camera_thirdPerson"))
		{
			scripts\mp\_utility::setthirdpersondof(1);
		}
	}

	scripts\mp\_utility::func_41E9();
	level.var_DF80 = undefined;
}

//Function Number: 9
func_E5C5()
{
	var_00 = self getentitynumber();
	level.var_E5DE[var_00] = self;
	self waittill("death");
	level.var_E5DE[var_00] = undefined;
	level.var_DF80 = undefined;
}

//Function Number: 10
func_CFC7(param_00)
{
	param_00 endon("death");
	self endon("death");
	level waittill("game_ended");
	self thermalvisionfofoverlayoff();
	self controlsunlink();
	self cameraunlink();
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(1);
	}
}