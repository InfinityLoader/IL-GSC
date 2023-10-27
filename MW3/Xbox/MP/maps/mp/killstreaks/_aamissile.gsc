/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_aamissile.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 11
 * Decompile Time: 158 ms
 * Timestamp: 10/27/2023 2:26:31 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheitem("aamissile_projectile_mp");
	precacheshader("ac130_overlay_grain");
	level.aamissilelaunchvert = 14000;
	level.aamissilelaunchhorz = 30000;
	level.aamissilelaunchtargetdist = 1500;
	level.rockets = [];
	level.killstreakfuncs["aamissile"] = ::func_35B9;
}

//Function Number: 2
func_35B9(param_00)
{
	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	maps\mp\_utility::setusingremote("aamissile");
	var_01 = maps\mp\killstreaks\_killstreaks::initridekillstreak();
	if(var_01 != "success")
	{
		if(var_01 != "disconnect")
		{
			maps\mp\_utility::clearusingremote();
		}

		return 0;
	}

	level thread aa_missile_fire(param_00,self);
	return 1;
}

//Function Number: 3
drawline(param_00,param_01,param_02,param_03)
{
	var_04 = int(param_02 * 20);
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait 0.05;
	}
}

//Function Number: 4
gettargets()
{
	var_00 = [];
	var_01 = [];
	if(isdefined(level.littlebirds) && level.littlebirds.size)
	{
		foreach(var_03 in level.littlebirds)
		{
			if(var_03.team != self.team)
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	if(isdefined(level.helis) && level.helis.size)
	{
		foreach(var_06 in level.helis)
		{
			if(var_06.team != self.team)
			{
				var_01[var_01.size] = var_06;
			}
		}
	}

	if(level.ac130inuse && isdefined(level.ac130.owner) && level.ac130.owner.team != self.team)
	{
		return level.ac130.planemodel;
	}

	if(isdefined(var_01) && var_01.size)
	{
		return var_01[0];
	}

	if(isdefined(var_00) && var_00.size)
	{
		return var_00[0];
	}
}

//Function Number: 5
aa_missile_fire(param_00,param_01)
{
	var_02 = undefined;
	var_03 = (0,0,level.aamissilelaunchvert);
	var_04 = level.aamissilelaunchhorz;
	var_05 = level.aammissilelaunchtargetdist;
	var_06 = param_01 gettargets();
	if(!isdefined(var_06))
	{
		var_07 = (0,0,0);
	}
	else
	{
		var_07 = var_07.origin;
		var_03 = (0,0,1) * var_07 + (0,0,1000);
	}

	var_08 = anglestoforward(param_01.angles);
	var_09 = param_01.origin + var_03 + var_08 * var_04 * -1;
	var_0A = magicbullet("aamissile_projectile_mp",var_09,var_07,param_01);
	if(!isdefined(var_0A))
	{
		param_01 maps\mp\_utility::clearusingremote();
		return;
	}

	var_0A.lifeid = param_00;
	var_0A.type = "remote";
	missileeyes(param_01,var_0A);
}

//Function Number: 6
missileeyes(param_00,param_01)
{
	param_00 endon("joined_team");
	param_00 endon("joined_spectators");
	param_01 thread rocket_cleanupondeath();
	param_00 thread player_cleanupongameended(param_01);
	param_00 thread func_3077(param_01);
	param_00 visionsetmissilecamforplayer("black_bw",0);
	param_00 endon("disconnect");
	if(isdefined(param_01))
	{
		param_00 visionsetmissilecamforplayer(game["thermal_vision"],1);
		param_00 thread func_3074();
		param_00 cameralinkto(param_01,"tag_origin");
		param_00 controlslinkto(param_01);
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 maps\mp\_utility::setthirdpersondof(0);
		}

		param_01 waittill("death");
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

//Function Number: 7
func_3074()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait 0.15;
	self thermalvisionfofoverlayon();
}

//Function Number: 8
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

//Function Number: 9
func_3077(param_00)
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

//Function Number: 10
rocket_cleanupondeath()
{
	var_00 = self getentitynumber();
	level.rockets[var_00] = self;
	self waittill("death");
	level.rockets[var_00] = undefined;
}

//Function Number: 11
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