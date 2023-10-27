/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3586.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:30:49 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["smokewall"] = loadfx("vfx/iw7/_requests/mp/vfx_smokewall");
	scripts\mp\_powerloot::func_DF06("power_smokeWall",["passive_increased_range","passive_increased_radius","passive_increased_duration"]);
}

//Function Number: 2
func_E16E()
{
	self notify("remove_smoke_wall");
}

//Function Number: 3
func_1037D(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("remove_smoke_wall");
	var_02 = "power_smokeWall";
	var_03 = self.angles;
	if(isdefined(param_01) && param_01 >= 0.2)
	{
		var_04 = self.origin;
	}
	else
	{
		var_05 = param_01 scripts\common\utility::func_13734("missile_stuck","death");
		if(var_05 != "death")
		{
			var_04 = param_00.origin;
			var_03 = param_00.angles;
			var_06 = anglestoup(var_03) * 64;
			var_04 = var_04 + var_06;
		}
		else
		{
			var_07 = scripts\mp\_powerloot::func_7FC5("power_smokeWall",500);
			var_08 = anglestoforward(self.angles) * var_07;
			var_04 = self.origin + var_08;
		}
	}

	thread func_1037C(var_04,self);
	playfx(scripts\common\utility::getfx("smokewall"),var_04,anglestoforward(var_03),anglestoup(var_03));
	thread scripts\common\utility::play_sound_in_space("synaptic_smokewall",var_04);
}

//Function Number: 4
func_1037C(param_00,param_01)
{
	var_02 = undefined;
	if(level.teambased)
	{
		var_02 = scripts\mp\_utility::func_81A0(scripts\mp\_utility::getotherteam(param_01.team));
	}
	else
	{
		var_02 = level.var_3CB5;
	}

	var_03 = 0;
	foreach(var_05 in var_02)
	{
		if(!isdefined(var_05) || var_05 == param_01 || !scripts\mp\_utility::func_9F19(var_05))
		{
			continue;
		}

		var_06 = param_01 scripts\mp\_powerloot::func_7FC4("power_smokeWall",65536);
		if(distance2dsquared(param_00,var_05.origin) > var_06)
		{
			continue;
		}

		var_07 = scripts\common\trace::func_48BC(0,1,1,0,0,0,0);
		var_08 = function_0287(param_00,var_05 geteye(),var_07,undefined,0,"physicsquery_closest");
		if(isdefined(var_08) && var_08.size > 0)
		{
			continue;
		}

		var_09 = param_01 scripts\mp\_powerloot::func_7FC1("power_smokeWall",1);
		if(var_05 method_838A(param_00) >= 0.75)
		{
			var_05 shellshock("flashbang_mp",var_09);
		}

		if(!var_05 scripts\mp\_utility::_hasperk("specialty_noplayertarget") && !var_05 scripts\mp\_utility::_hasperk("specialty_incog"))
		{
			var_05 thread func_E48C(param_01);
			var_05 scripts\mp\_hud_message::func_1013D("spotted");
		}

		var_03++;
	}

	if(var_03 == 0)
	{
		param_01 iprintlnbold("No Threats Detected");
		return;
	}

	param_01 iprintlnbold(var_03 + " Threats Detected");
}

//Function Number: 5
func_E48C(param_00)
{
	self endon("disconnect");
	thread scripts\mp\killstreaks\_emp_common::func_5AA9();
	var_01 = scripts\mp\_utility::func_C794(self,"orange",param_00,0,0,"level_script");
	var_02 = param_00 scripts\mp\_powerloot::func_7FC1("power_smokeWall",1.15);
	scripts\common\utility::waittill_any_timeout_1(var_02,"death");
	if(isdefined(param_00))
	{
		scripts\mp\_utility::func_C78F(var_01,self);
	}
}