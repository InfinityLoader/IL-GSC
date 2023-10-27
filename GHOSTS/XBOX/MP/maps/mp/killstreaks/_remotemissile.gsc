/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_remotemissile.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 152 ms
 * Timestamp: 10/27/2023 1:33:07 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.missileremotelaunchvert = 14000;
	level.missileremotelaunchhorz = 7000;
	level.missileremotelaunchtargetdist = 1500;
	level.rockets = [];
	level.killstreakfuncs["predator_missile"] = ::func_8447;
	level.remotemissile_fx["explode"] = loadfx("fx/explosions/aerial_explosion");
}

//Function Number: 2
func_8447(param_00,param_01)
{
	maps\mp\_utility::func_720F("remotemissile");
	var_02 = maps\mp\killstreaks\_killstreaks::func_4649();
	if(var_02 != "success")
	{
		if(var_02 != "disconnect")
		{
			maps\mp\_utility::func_1D59();
		}

		return 0;
	}

	self setclientomnvar("ui_predator_missile",1);
	level thread _fire(param_00,self);
	return 1;
}

//Function Number: 3
getbestspawnpoint(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_03.validplayers = [];
		var_03.spawnscore = 0;
	}

	foreach(var_06 in level.players)
	{
		if(!maps\mp\_utility::func_4945(var_06))
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
			var_03.validplayers[var_03.validplayers.size] = var_06;
			var_0A = distance2d(var_03.targetent.origin,var_06.origin);
			if(var_0A <= var_07)
			{
				var_07 = var_0A;
				var_08 = var_03;
			}
		}

		var_08.spawnscore = var_08.spawnscore + 2;
	}

	var_0D = param_00[0];
	foreach(var_03 in param_00)
	{
		foreach(var_06 in var_03.validplayers)
		{
			var_03.spawnscore = var_03.spawnscore + 1;
			if(bullettracepassed(var_06.origin + (0,0,32),var_03.origin,0,var_06))
			{
				var_03.spawnscore = var_03.spawnscore + 3;
			}

			if(var_03.spawnscore > var_0D.spawnscore)
			{
				var_0D = var_03;
				continue;
			}

			if(var_03.spawnscore == var_0D.spawnscore)
			{
				if(common_scripts\utility::func_1DE9())
				{
					var_0D = var_03;
				}
			}
		}
	}

	return var_0D;
}

//Function Number: 4
_fire(param_00,param_01)
{
	var_02 = getentarray("remoteMissileSpawn","targetname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.target))
		{
			var_04.targetent = getent(var_04.target,"targetname");
		}
	}

	if(var_02.size > 0)
	{
		var_06 = param_01 getbestspawnpoint(var_02);
	}
	else
	{
		var_06 = undefined;
	}

	if(isdefined(var_06))
	{
		var_07 = var_06.origin;
		var_08 = var_06.targetent.origin;
		var_09 = vectornormalize(var_07 - var_08);
		var_07 = var_09 * 14000 + var_08;
		var_0A = magicbullet("remotemissile_projectile_mp",var_07,var_08,param_01);
	}
	else
	{
		var_0B = (0,0,level.missileremotelaunchvert);
		var_0C = level.missileremotelaunchhorz;
		var_0D = level.missileremotelaunchtargetdist;
		var_0E = anglestoforward(param_01.angles);
		var_07 = param_01.origin + var_0B + var_0E * var_0C * -1;
		var_08 = param_01.origin + var_0E * var_0D;
		var_0A = magicbullet("remotemissile_projectile_mp",var_07,var_08,param_01);
	}

	if(!isdefined(var_0A))
	{
		param_01 maps\mp\_utility::func_1D59();
	}

	var_0A.team = param_01.team;
	var_0A thread func_3F74();
	var_0A.lifeid = param_00;
	var_0A.type = "remote";
	level.remotemissileinprogress = 1;
	func_52C3(param_01,var_0A);
}

//Function Number: 5
func_3F74()
{
	self endon("death");
	self endon("deleted");
	self setcandamage(1);
	self waittill("damage");
}

//Function Number: 6
func_52C3(param_00,param_01)
{
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	param_01 thread func_66F2();
	param_00 thread func_5DA5(param_01);
	param_00 thread func_5DA6(param_01);
	param_00 visionsetmissilecamforplayer("black_bw",0);
	param_00 endon("disconnect");
	if(isdefined(param_01))
	{
		param_00 visionsetmissilecamforplayer(game["thermal_vision"],1);
		param_00 thermalvisionon();
		param_00 thread delayedfofoverlay();
		param_00 cameralinkto(param_01,"tag_origin");
		param_00 controlslinkto(param_01);
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 maps\mp\_utility::func_70E6(0);
		}

		param_01 waittill("death");
		param_00 thermalvisionoff();
		if(isdefined(param_01))
		{
			param_00 maps\mp\_matchdata::func_4F1D("predator_missile",param_01.origin);
		}

		param_00 controlsunlink();
		param_00 maps\mp\_utility::func_350E(1);
		if(!level.gameended || isdefined(param_00.finalkill))
		{
			param_00 setclientomnvar("ui_predator_missile",2);
		}

		wait(0.5);
		param_00 thermalvisionfofoverlayoff();
		param_00 cameraunlink();
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 maps\mp\_utility::func_70E6(1);
		}
	}

	param_00 setclientomnvar("ui_predator_missile",0);
	param_00 maps\mp\_utility::func_1D59();
}

//Function Number: 7
delayedfofoverlay()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.15);
	self thermalvisionfofoverlayon();
}

//Function Number: 8
func_5DA6(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	common_scripts\utility::func_8B2A("joined_team","joined_spectators");
	if(self.team != "spectator")
	{
		self thermalvisionfofoverlayoff();
		self controlsunlink();
		self cameraunlink();
		if(getdvarint("camera_thirdPerson"))
		{
			maps\mp\_utility::func_70E6(1);
		}
	}

	maps\mp\_utility::func_1D59();
	level.remotemissileinprogress = undefined;
}

//Function Number: 9
func_66F2()
{
	var_00 = self getentitynumber();
	level.rockets[var_00] = self;
	self waittill("death");
	level.rockets[var_00] = undefined;
	level.remotemissileinprogress = undefined;
}

//Function Number: 10
func_5DA5(param_00)
{
	param_00 endon("death");
	self endon("death");
	level waittill("game_ended");
	self thermalvisionfofoverlayoff();
	self controlsunlink();
	self cameraunlink();
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::func_70E6(1);
	}
}