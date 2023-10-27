/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3573.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:30:45 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\_powerloot::func_DF06("power_opticWave",["passive_increased_duration","passive_increased_range","passive_increased_speed"]);
}

//Function Number: 2
func_E145()
{
	self notify("remove_optic_wave");
}

//Function Number: 3
func_C6AF()
{
	self endon("death");
	self endon("disconnect");
	self endon("remove_optic_wave");
	var_00 = scripts\mp\_powerloot::func_7FC6("power_opticWave",0.8);
	self.var_D782["power_opticWave"].var_19 = 1;
	self playanimscriptevent("power_active","opticwave");
	self playlocalsound("ghost_optic_wave");
	thread func_C6AE(var_00);
	func_C6AD(var_00);
	self.var_D782["power_opticWave"].var_19 = 0;
	scripts\common\utility::func_136F7();
}

//Function Number: 4
func_C6AD(param_00)
{
	self endon("death");
	level endon("game_ended");
	if(level.teambased)
	{
		level.var_1679[self.team]++;
	}
	else
	{
		level.var_1679[self.var_86BD]++;
	}

	var_01 = 0;
	var_02 = scripts\mp\_powerloot::func_7FC5("power_opticWave",1750);
	foreach(var_04 in level.var_C928)
	{
		if(!scripts\mp\_utility::func_9F19(var_04))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9DD6(var_04))
		{
			continue;
		}

		if(var_04 scripts\mp\_utility::_hasperk("specialty_noplayertarget") || var_04 scripts\mp\_utility::_hasperk("specialty_noscopeoutline"))
		{
			continue;
		}

		var_05 = var_04.origin - self.origin;
		if(1 && vectordot(anglestoforward(self.angles),var_05) < 0)
		{
			continue;
		}

		var_06 = var_02 * var_02;
		if(length2dsquared(var_05) > var_06)
		{
			continue;
		}

		if(!self method_8409(var_04 geteye(),65,75))
		{
			if(!self method_8409(var_04.origin,65,75))
			{
				if(!self method_8409(var_04 gettagorigin("j_mainroot"),65,75))
				{
					continue;
				}
			}
		}

		thread func_C7A7(var_04,distance2d(self.origin,var_04.origin) / var_02,param_00);
		var_01 = 1;
	}
}

//Function Number: 5
func_C7A7(param_00,param_01,param_02)
{
	wait(param_02 * param_01);
	var_03 = scripts\mp\_utility::func_C794(param_00,"orange",self,0,1,"level_script");
	if(!isai(param_00))
	{
		param_00 scripts\mp\_utility::func_12E5(5);
	}

	var_04 = scripts\mp\_powerloot::func_7FC1("power_opticWave",1.35);
	func_13AA0(var_03,param_00,var_04);
}

//Function Number: 6
func_13AA0(param_00,param_01,param_02)
{
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_timeout_no_endon_death_2(param_02,"leave");
	if(isdefined(param_01))
	{
		scripts\mp\_utility::func_C78F(param_00,param_01);
		if(!isai(param_01))
		{
			param_01 scripts\mp\_utility::func_12E4();
		}
	}
}

//Function Number: 7
func_C6AE(param_00)
{
	self visionsetnakedforplayer("opticwave_mp",0);
	var_01 = spawn("script_model",self gettagorigin("tag_eye"));
	var_01 setmodel("prop_mp_optic_wave_scr");
	var_01.angles = self getplayerangles();
	var_01 method_831F(self);
	var_01 setscriptablepartstate("effects","active",0);
	var_02 = var_01.origin + anglestoforward(var_01.angles) * 1750;
	var_01 moveto(var_02,param_00);
	wait(param_00);
	self visionsetnakedforplayer("",0.5);
	var_01 delete();
}