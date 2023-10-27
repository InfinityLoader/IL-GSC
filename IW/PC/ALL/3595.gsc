/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3595.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 5 ms
 * Timestamp: 10/27/2023 12:30:51 AM
*******************************************************************/

//Function Number: 1
func_13DFB()
{
	level._effect["wristrocket_explode"] = loadfx("vfx/iw7/_requests/mp/power/vfx_wrist_rocket_exp.vfx");
	level._effect["wristrocket_thruster"] = loadfx("vfx/iw7/_requests/mp/power/vfx_wrist_rocket_thruster");
}

//Function Number: 2
func_13DF4()
{
	thread wristrocket_watcheffects();
}

//Function Number: 3
func_13DF5()
{
	self notify("wristRocket_unset");
}

//Function Number: 4
func_13DFC(param_00)
{
	if(param_00.var_118A1 == 1)
	{
		return;
	}

	var_01 = func_13DF0(param_00);
	var_01.var_15F = param_00;
	param_00 = scripts\mp\_utility::func_1302("wristrocket_mp",self.origin,(0,0,0),100,1,param_00);
	param_00 method_8587(1);
	param_00 linkto(var_01);
	param_00 thread func_13DEF(var_01);
	var_01 setscriptablepartstate("launch","active",0);
	var_01 thread func_13DF8(2);
	var_01 thread func_13DF9();
}

//Function Number: 5
func_13DF8(param_00)
{
	self endon("death");
	self.var_222 endon("disconnect");
	self notify("wristRocket_watchFuse");
	self endon("wristRocket_watchFuse");
	wait(param_00);
	thread func_13DF2();
}

//Function Number: 6
func_13DF9()
{
	self endon("death");
	self.var_222 endon("disconnect");
	self playloopsound("wrist_rocket_fire_tail");
	self waittill("missile_stuck",var_00);
	if(isplayer(var_00))
	{
		self.var_222 scripts\mp\_weapons::func_85DD(self,var_00);
	}

	self stoploopsound();
	self setscriptablepartstate("beacon","active",0);
	self.var_15F method_8587(0);
	thread func_13DF8(1);
}

//Function Number: 7
func_13DF2()
{
	self setscriptablepartstate("beacon","neutral",0);
	self setscriptablepartstate("explode","active",0);
	thread func_13DF1();
}

//Function Number: 8
func_13DF1()
{
	self notify("death");
	self.var_69BA = 1;
	wait(0.1);
	self delete();
}

//Function Number: 9
func_13DF0(param_00)
{
	var_01 = scripts\mp\_utility::func_1309("wristrocket_proj_mp",param_00.origin,param_00.origin + anglestoforward(self getgunangles()),self);
	var_01.var_222 = self;
	var_01.team = self.team;
	var_01.var_13C2E = "wristrocket_proj_mp";
	var_01.var_D719 = "power_wristrocket";
	var_01 method_831F(self);
	var_01 method_82DD(self);
	var_01 thread func_13DEE(self);
	return var_01;
}

//Function Number: 10
wristrocket_watcheffects()
{
	self endon("disconnect");
	self notify("wristRocket_watchEffects");
	self endon("wristRocket_watchEffects");
	var_00 = 0;
	for(;;)
	{
		var_01 = spawnstruct();
		if(var_00)
		{
			childthread wristrocket_watcheffectsraceheldoffhandbreak(var_01);
		}
		else
		{
			childthread wristrocket_watcheffectsracegrenadepullback(var_01);
		}

		childthread wristrocket_watcheffectsracegrenadefired(var_01);
		childthread wristrocket_watcheffectsracesuperstarted(var_01);
		childthread wristrocket_watcheffectsracedeath(var_01);
		childthread wristrocket_watcheffectsraceunset(var_01);
		var_00 = 0;
		self waittill("wristRocket_watchEffectsRaceStart");
		waittillframeend;
		var_02 = scripts\mp\_utility::func_9FB3(var_01.grenadepullback);
		var_03 = scripts\mp\_utility::func_9FB3(var_01.grenadefire);
		var_04 = scripts\mp\_utility::func_9FB3(var_01.superstarted);
		var_05 = scripts\mp\_utility::func_9FB3(var_01.var_E6);
		var_06 = scripts\mp\_utility::func_9FB3(var_01.var_12BF4);
		var_07 = scripts\mp\_utility::func_9FB3(var_01.heldoffhandbreak);
		if(var_05)
		{
			self notify("wristRocket_watchEffectsRaceEnd");
			thread wristrocket_endeffects();
			return;
		}
		else if(var_06)
		{
			self notify("wristRocket_watchEffectsRaceEnd");
			thread wristrocket_endeffects();
			return;
		}
		else if(var_04)
		{
			thread wristrocket_endeffects();
		}
		else if(var_07)
		{
			thread wristrocket_endeffects();
		}
		else if(var_03)
		{
			thread wristrocket_endeffects();
		}
		else if(var_02)
		{
			thread wristrocket_begineffects();
			var_00 = 1;
		}

		self notify("wristRocket_watchEffectsRaceEnd");
	}
}

//Function Number: 11
wristrocket_watcheffectsracegrenadepullback(param_00)
{
	self endon("wristRocket_watchEffectsRaceEnd");
	for(;;)
	{
		self waittill("grenade_pullback",var_01);
		if(var_01 == "wristrocket_mp")
		{
			break;
		}
	}

	param_00.grenadepullback = 1;
	self notify("wristRocket_watchEffectsRaceStart");
}

//Function Number: 12
wristrocket_watcheffectsracegrenadefired(param_00)
{
	self endon("wristRocket_watchEffectsRaceEnd");
	for(;;)
	{
		self waittill("grenade_fire",var_01,var_02);
		if(var_02 == "wristrocket_mp")
		{
			break;
		}
	}

	param_00.grenadefire = 1;
	self notify("wristRocket_watchEffectsRaceStart");
}

//Function Number: 13
wristrocket_watcheffectsracesuperstarted(param_00)
{
	self endon("wristRocket_watchEffectsRaceEnd");
	self waittill("super_started");
	param_00.superstarted = 1;
	self notify("wristRocket_watchEffectsRaceStart");
}

//Function Number: 14
wristrocket_watcheffectsracedeath(param_00)
{
	self endon("wristRocket_watchEffectsRaceEnd");
	self waittill("death");
	param_00.var_E6 = 1;
	self notify("wristRocket_watchEffectsRaceStart");
}

//Function Number: 15
wristrocket_watcheffectsraceunset(param_00)
{
	self endon("wristRocket_watchEffectsRaceEnd");
	self waittill("wristRocket_unset");
	param_00.var_12BF4 = 1;
	self notify("wristRocket_watchEffectsRaceStart");
}

//Function Number: 16
wristrocket_watcheffectsraceheldoffhandbreak(param_00)
{
	self endon("wristRocket_watchEffectsRaceEnd");
	scripts\common\utility::func_136F7();
	while(self method_854D() == "wristrocket_mp")
	{
		scripts\common\utility::func_136F7();
	}

	param_00.heldoffhandbreak = 1;
	self notify("wristRocket_watchEffectsRaceStart");
}

//Function Number: 17
wristrocket_begineffects()
{
	self notify("wristRocket_beginEffects");
	self endon("wristRocket_beginEffects");
	self endon("wristRocket_endEffects");
	self setscriptablepartstate("wristRocketWorld","neutral",0);
	wait(0.15);
	self setscriptablepartstate("wristRocketWorld","active",0);
}

//Function Number: 18
wristrocket_endeffects()
{
	self notify("wristRocket_endEffects");
	self setscriptablepartstate("wristRocketWorld","neutral",0);
}

//Function Number: 19
func_13DFA(param_00,param_01,param_02,param_03,param_04)
{
	if(param_01 != param_02)
	{
		return;
	}

	if(param_03 != "MOD_SUICIDE")
	{
		return;
	}

	if(!isdefined(param_00) || param_00 != param_01)
	{
		return;
	}

	if(!isdefined(param_04) || param_04 != "wristrocket_mp")
	{
		return;
	}

	var_05 = param_02 gettagorigin("tag_weapon_left");
	radiusdamage(var_05,175,200,70,param_01,"MOD_EXPLOSIVE","wristrocket_mp");
	scripts\mp\_shellshock::func_858B(var_05,0.6);
	playsoundatpos(var_05,"wrist_rocket_explode");
	playfx(scripts\common\utility::getfx("wristrocket_explode"),var_05);
}

//Function Number: 20
func_13DEF(param_00,param_01)
{
	self endon("death");
	self notify("cleanupOnParentDeath");
	self endon("cleanupOnParentDeath");
	if(isdefined(param_00))
	{
		param_00 waittill("death");
	}

	if(isdefined(param_01))
	{
		wait(param_01);
	}

	self delete();
}

//Function Number: 21
func_13DEE(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	if(isdefined(self))
	{
		self delete();
	}
}