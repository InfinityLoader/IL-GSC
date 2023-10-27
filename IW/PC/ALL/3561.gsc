/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3561.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 12:30:42 AM
*******************************************************************/

//Function Number: 1
init()
{
	groundpound_initimpactstructs();
}

//Function Number: 2
func_8659(param_00)
{
	self method_8488(1);
	thread func_8654();
	thread groundpound_monitoractivation();
}

//Function Number: 3
func_865A()
{
	self method_8488(0);
	if(self.var_AE62 == "archetype_heavy")
	{
		self setscriptablepartstate("groundPound","neutral",0);
	}

	self notify("groundPound_unset");
}

//Function Number: 4
func_8654()
{
	self endon("death");
	self endon("disconnect");
	self endon("groundPound_unset");
	for(;;)
	{
		self waittill("groundPoundLand",var_00);
		thread groundpound_impact(self,var_00);
		scripts\mp\_utility::func_D915("ground pound land",self);
	}
}

//Function Number: 5
groundpound_monitoractivation()
{
	self endon("death");
	self endon("disconnect");
	self endon("groundPound_unset");
	for(;;)
	{
		self waittill("groundPoundBegin");
		thread groundpound_activate(self);
	}
}

//Function Number: 6
groundpound_activate(param_00)
{
	param_00 setscriptablepartstate("groundPound","activated");
}

//Function Number: 7
groundpound_impact(param_00,param_01)
{
	param_00 setclientomnvar("ui_hud_shake",1);
	param_00 setscriptablepartstate("groundPound","impact");
	var_02 = groundpound_getbestimpactstruct(param_01);
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = param_00.origin + (0,0,2);
	thread groundpound_impactphysics(var_03,var_02.physicsradmin,var_02.physicsradmax,var_02.physicsscale);
	if(isdefined(var_02.var_1F2))
	{
		var_04 = spawn("script_model",var_03);
		var_04.angles = param_00.angles;
		var_04.var_222 = param_00;
		var_04.var_13C2E = "groundpound_mp";
		var_04.impactstruct = var_02;
		var_04.var_A63A = param_00;
		var_04 method_82DD(param_00);
		var_04 method_831F(param_00);
		var_04 setmodel(var_02.var_1F2);
		if(isdefined(var_02.var_22A) && isdefined(var_02.var_10E2C))
		{
			var_04 setscriptablepartstate(var_02.var_22A,var_02.var_10E2C);
		}

		if(isdefined(var_02.deletiondelay))
		{
			wait(var_02.deletiondelay);
		}
		else
		{
			scripts\common\utility::func_136F7();
		}

		var_04 delete();
	}
}

//Function Number: 8
groundpound_impactphysics(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01) || param_01 == 0)
	{
		return;
	}

	if(!isdefined(param_02) || param_02 == 0)
	{
		return;
	}

	if(!isdefined(param_03) || param_03 == 0)
	{
		return;
	}

	wait(0.1);
	physicsexplosionsphere(param_00,param_02,param_01,param_03);
}

//Function Number: 9
groundpound_victimimpacteffects(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 == param_01)
	{
		return;
	}

	if(param_01 scripts\mp\_utility::func_9FC6())
	{
		return;
	}

	if(!isdefined(param_03))
	{
		return;
	}

	var_04 = param_03.impactstruct;
	if(!isdefined(var_04))
	{
		return;
	}

	if(!isdefined(var_04.shock) || var_04.shock == "")
	{
		return;
	}

	if(!isdefined(var_04.shockduration) || var_04.shockduration == 0)
	{
		return;
	}

	param_01 shellshock(var_04.shock,var_04.shockduration);
}

//Function Number: 10
func_8653(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02) || param_02 != "groundpound_mp")
	{
		return param_04;
	}

	if(!isplayer(param_01))
	{
		return param_04;
	}

	if(!isdefined(param_00))
	{
		return param_04;
	}

	if(param_00 == param_01)
	{
		return 0;
	}

	if(!isdefined(param_03))
	{
		return param_04;
	}

	var_05 = param_03.impactstruct;
	if(!isdefined(var_05))
	{
		return param_04;
	}

	var_06 = scripts\common\utility::func_116D7(level.var_8B38,var_05.innerradsqrhc,var_05.innerradsqr);
	var_07 = scripts\common\utility::func_116D7(level.var_8B38,var_05.innerdamagehc,var_05.innerdamage);
	var_08 = scripts\common\utility::func_116D7(level.var_8B38,var_05.outerdamagehc,var_05.outerdamage);
	var_09 = param_01 scripts\mp\_utility::isinarbitraryup();
	var_0A = scripts\common\utility::func_116D7(var_09,self gettagorigin("TAG_EYE",1,1),self gettagorigin("TAG_EYE"));
	var_0B = abs(vectordot(var_0A - param_03.origin,(0,0,1)));
	var_0C = scripts\common\utility::func_116D7(var_09,self gettagorigin("TAG_ORIGIN",1,1),self gettagorigin("TAG_ORIGIN"));
	var_0D = abs(vectordot(var_0C - param_03.origin,(0,0,1)));
	if(var_0B > var_05.maxzdelta && var_0D > var_05.maxzdelta)
	{
		return 0;
	}

	var_0E = var_06 != 0;
	if(var_0E)
	{
		var_0E = var_06 < 0;
		if(!var_0E)
		{
			if(!var_0E)
			{
				var_0F = distancesquared(param_03.origin,param_01.origin);
				if(var_0F <= var_06)
				{
					var_0E = 1;
				}
			}

			if(!var_0E)
			{
				var_0F = distancesquared(param_03.origin,param_01 gettagorigin("j_mainroot"));
				if(var_0F <= var_06)
				{
					var_0E = 1;
				}
			}

			if(!var_0E)
			{
				var_0F = distancesquared(param_03.origin,param_01 geteye());
				if(var_0F <= var_06)
				{
					var_0E = 1;
				}
			}
		}
	}

	if(var_0E)
	{
		param_04 = scripts\common\utility::func_116D7(var_07 > 0,var_07,param_04);
		if(!param_01 isonground())
		{
			param_04 = param_04 * 1;
		}

		return param_04;
	}

	param_04 = scripts\common\utility::func_116D7(var_08 > 0,var_08,param_04);
	if(!param_01 isonground())
	{
		param_04 = param_04 * 1;
	}

	return param_04;
}

//Function Number: 11
groundpound_modifiedblastshieldconst(param_00,param_01)
{
	if(level.var_8B38)
	{
		if(scripts\mp\_utility::func_821D(param_01) == "groundpound_mp")
		{
			param_00 = 0.65;
		}
	}

	return param_00;
}

//Function Number: 12
func_8651(param_00)
{
	return param_00 method_8499();
}

//Function Number: 13
groundpound_initimpactstructs()
{
	var_00 = spawnstruct();
	var_00.impactstructs = [];
	var_01 = groundpound_createimpactstruct();
	var_00.impactstructs[var_00.impactstructs.size] = var_01;
	var_01 = groundpound_createimpactstruct();
	var_01.var_B783 = 150;
	var_01.innerradsqr = 5625;
	var_01.innerradsqr = 5625;
	var_01.var_10E2C = "impact2";
	var_01.physicsradmax = 150;
	var_01.physicsscale = 2.5;
	var_00.impactstructs[var_00.impactstructs.size] = var_01;
	var_01 = groundpound_createimpactstruct();
	var_01.var_B783 = 225;
	var_01.innerradsqr = -1;
	var_01.innerradsqrhc = -1;
	var_01.var_10E2C = "impact3";
	var_01.physicsradmax = 225;
	var_01.physicsscale = 3;
	var_00.impactstructs[var_00.impactstructs.size] = var_01;
	var_01 = groundpound_createimpactstruct();
	var_01.var_B783 = 325;
	var_01.innerradsqr = -1;
	var_01.innerradsqrhc = -1;
	var_01.var_10E2C = "impact4";
	var_01.physicsradmax = 275;
	var_01.physicsscale = 3.5;
	var_00.impactstructs[var_00.impactstructs.size] = var_01;
	var_01 = groundpound_createimpactstruct();
	var_01.var_B783 = 425;
	var_01.innerradsqr = -1;
	var_01.innerradsqrhc = -1;
	var_01.var_10E2C = "impact5";
	var_01.physicsradmax = 325;
	var_01.physicsscale = 4;
	var_00.impactstructs[var_00.impactstructs.size] = var_01;
	var_00.impactstructs = scripts\common\utility::func_22C3(var_00.impactstructs,::groundpound_compareimpactstruct);
	level.groundpound = var_00;
}

//Function Number: 14
groundpound_createimpactstruct()
{
	var_00 = spawnstruct();
	var_00.var_B783 = 48;
	var_00.maxzdelta = 125;
	var_00.innerradsqr = 0;
	var_00.innerradsqrhc = 0;
	var_00.innerdamage = 105;
	var_00.outerdamage = 55;
	var_00.innerdamagehc = 35;
	var_00.outerdamagehc = 20;
	var_00.var_1F2 = "perk_mp_groundPound_scr";
	var_00.var_22A = "effects";
	var_00.var_10E2C = "impact1";
	var_00.deletiondelay = 2;
	var_00.physicsradmin = 75;
	var_00.physicsradmax = 100;
	var_00.physicsscale = 2;
	var_00.shock = "concussion_grenade_mp";
	var_00.shockduration = 0.7;
	return var_00;
}

//Function Number: 15
groundpound_compareimpactstruct(param_00,param_01)
{
	return param_00.var_B783 > param_01.var_B783;
}

//Function Number: 16
groundpound_getbestimpactstruct(param_00)
{
	var_01 = undefined;
	foreach(var_03 in level.groundpound.impactstructs)
	{
		if(param_00 < var_03.var_B783)
		{
			continue;
		}

		var_01 = var_03;
		break;
	}

	return var_01;
}

//Function Number: 17
func_8655(param_00,param_01,param_02,param_03)
{
}