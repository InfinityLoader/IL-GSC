/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_aamissile.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 468 ms
 * Timestamp: 10/27/2023 12:27:54 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheitem("aamissile_projectile_mp");
	precacheshader("ac130_overlay_grain");
	level.var_1502 = 14000;
	level.var_1500 = 30000;
	level.var_1501 = 1500;
	level.var_E5DE = [];
	scripts\mp\killstreaks\_killstreaks::func_DEFB("aamissile",::func_128D0);
}

//Function Number: 2
func_128D0(param_00,param_01)
{
	scripts\mp\_utility::func_FB09("aamissile");
	var_02 = scripts\mp\killstreaks\_killstreaks::func_98C2();
	if(var_02 != "success")
	{
		if(var_02 != "disconnect")
		{
			scripts\mp\_utility::func_41E9();
		}

		return 0;
	}

	level thread func_14EE(param_00,self);
	return 1;
}

//Function Number: 3
func_819E()
{
	var_00 = [];
	var_01 = [];
	if(isdefined(level.var_AD8B) && level.var_AD8B.size)
	{
		foreach(var_03 in level.var_AD8B)
		{
			if(var_03.team != self.team)
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	if(isdefined(level.var_8DD3) && level.var_8DD3.size)
	{
		foreach(var_06 in level.var_8DD3)
		{
			if(var_06.team != self.team)
			{
				var_01[var_01.size] = var_06;
			}
		}
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

//Function Number: 4
func_14EE(param_00,param_01)
{
	var_02 = undefined;
	var_03 = (0,0,level.var_1502);
	var_04 = level.var_1500;
	var_05 = level.var_1503;
	var_06 = param_01 func_819E();
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
	var_0A = scripts\mp\_utility::func_1309("aamissile_projectile_mp",var_09,var_07,param_01);
	if(!isdefined(var_0A))
	{
		param_01 scripts\mp\_utility::func_41E9();
		return;
	}

	var_0A.var_AC68 = param_00;
	var_0A.type = "remote";
	func_B889(param_01,var_0A);
}

//Function Number: 5
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
		param_00 thread func_50FF();
		param_00 cameralinkto(param_01,"tag_origin");
		param_00 controlslinkto(param_01);
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 scripts\mp\_utility::setthirdpersondof(0);
		}

		param_01 waittill("death");
		if(isdefined(param_01))
		{
			param_00 scripts\mp\_matchdata::func_AFC9("predator_missile",param_01.origin);
		}

		param_00 controlsunlink();
		param_00 scripts\mp\_utility::func_7385(1);
		if(!level.var_7669)
		{
			param_00 thread func_10E48(0.5);
		}

		wait(0.5);
		param_00 thermalvisionfofoverlayoff();
		param_00 cameraunlink();
		if(getdvarint("camera_thirdPerson"))
		{
			param_00 scripts\mp\_utility::setthirdpersondof(1);
		}
	}

	param_00 scripts\mp\_utility::func_41E9();
}

//Function Number: 6
func_50FF()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.15);
	self thermalvisionfofoverlayon();
}

//Function Number: 7
func_10E48(param_00)
{
	self endon("disconnect");
	var_01 = newclienthudelem(self);
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01 setshader("white",640,480);
	var_01.var_2129 = 1;
	var_01.sort = 10;
	var_02 = newclienthudelem(self);
	var_02.horzalign = "fullscreen";
	var_02.vertalign = "fullscreen";
	var_02 setshader("ac130_overlay_grain",640,480);
	var_02.var_2129 = 1;
	var_02.sort = 20;
	wait(param_00);
	var_02 destroy();
	var_01 destroy();
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