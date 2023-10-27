/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_remotemissile.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 226 ms
 * Timestamp: 10/27/2023 2:14:25 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = getdvar("mapname");
	if(var_00 == "mp_suburbia")
	{
		level.missileremotelaunchvert = 7000;
		level.missileremotelaunchhorz = 10000;
		level.missileremotelaunchtargetdist = 2000;
	}
	else if(var_00 == "mp_mainstreet")
	{
		level.missileremotelaunchvert = 7000;
		level.missileremotelaunchhorz = 10000;
		level.missileremotelaunchtargetdist = 2000;
	}
	else
	{
		level.missileremotelaunchvert = 14000;
		level.missileremotelaunchhorz = 7000;
		level.missileremotelaunchtargetdist = 1500;
	}

	precacheitem("remotemissile_projectile_mp");
	precacheshader("ac130_overlay_grain");
	level.rockets = [];
	level.killstreakfuncs["predator_missile"] = ::tryusepredatormissile;
	level.missilesforsighttraces = [];
	level.remotemissile_fx["explode"] = loadfx("explosions/aerial_explosion");
}

//Function Number: 2
tryusepredatormissile(param_00)
{
	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	maps\mp\_utility::setusingremote("remotemissile");
	var_01 = maps\mp\killstreaks\_killstreaks::initridekillstreak();
	if(var_01 != "success")
	{
		if(var_01 != "disconnect")
		{
			maps\mp\_utility::clearusingremote();
		}

		return 0;
	}

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
		if(!maps\mp\_utility::isreallyalive(var_06))
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
				if(common_scripts\utility::cointoss())
				{
					var_0D = var_03;
				}
			}
		}
	}

	return var_0D;
}

//Function Number: 4
drawline(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_02 * 20);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait 0.05;
	}
}

//Function Number: 5
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
		param_01 maps\mp\_utility::clearusingremote();
		return;
	}

	var_0A thread maps\mp\gametypes\_weapons::addmissiletosighttraces(param_01.team);
	var_0A thread handledamage();
	var_0A.lifeid = param_00;
	var_0A.type = "remote";
	missileeyes(param_01,var_0A);
}

//Function Number: 6
handledamage()
{
	self endon("death");
	self endon("deleted");
	self setcandamage(1);
	self waittill("damage");
}

//Function Number: 7
missileeyes(param_00,param_01)
{
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	param_01 thread rocket_cleanupondeath();
	param_00 thread player_cleanupongameended(param_01);
	param_00 thread player_cleanuponteamchange(param_01);
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
			param_00 maps\mp\_utility::setthirdpersondof(0);
		}

		param_01 waittill("death");
		param_00 thermalvisionoff();
		if(isdefined(param_01))
		{
			param_00 maps\mp\_matchdata::logkillstreakevent("predator_missile",param_01.origin);
		}

		param_00 controlsunlink();
		param_00 maps\mp\_utility::freezecontrolswrapper(1);
		if(!level.gameended || isdefined(param_00.finalkill))
		{
			param_00 thread staticeffect(0.5);
		}

		wait 0.5;
		param_00 thermalvisionfofoverlayoff();
		param_00 cameraunlink();
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 maps\mp\_utility::setthirdpersondof(1);
		}
	}

	param_00 maps\mp\_utility::clearusingremote();
}

//Function Number: 8
delayedfofoverlay()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait 0.15;
	self thermalvisionfofoverlayon();
}

//Function Number: 9
staticeffect(param_00)
{
	self endon("disconnect");
	var_01 = newclienthudelem(self);
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01 setshader("white",640,480);
	var_01.archive = 1;
	var_01.sort = 10;
	var_02 = newclienthudelem(self);
	var_02.horzalign = "fullscreen";
	var_02.vertalign = "fullscreen";
	var_02 setshader("ac130_overlay_grain",640,480);
	var_02.archive = 1;
	var_02.sort = 20;
	wait param_00;
	var_02 destroy();
	var_01 destroy();
}

//Function Number: 10
player_cleanuponteamchange(param_00)
{
	param_00 endon("death");
	self endon("disconnect");
	common_scripts\utility::waittill_any("joined_team","joined_spectators");
	if(self.team != "spectator")
	{
		self thermalvisionfofoverlayoff();
		self controlsunlink();
		self cameraunlink();
		if(getdvarint("camera_thirdPerson"))
		{
			maps\mp\_utility::setthirdpersondof(1);
		}
	}

	maps\mp\_utility::clearusingremote();
	level.remotemissileinprogress = undefined;
}

//Function Number: 11
rocket_cleanupondeath()
{
	var_00 = self getentitynumber();
	level.rockets[var_00] = self;
	self waittill("death");
	level.rockets[var_00] = undefined;
}

//Function Number: 12
player_cleanupongameended(param_00)
{
	param_00 endon("death");
	self endon("death");
	level waittill("game_ended");
	self thermalvisionfofoverlayoff();
	self controlsunlink();
	self cameraunlink();
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(1);
	}
}