/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3342.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:26:36 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_A6D2 = [];
	level.var_A6D2["spark"] = loadfx("vfx/iw7/_requests/mp/vfx_kinetic_pulse_shock");
	level.var_A6D2["blast"] = loadfx("vfx/iw7/_requests/mp/vfx_kinetic_pulse_blast");
}

//Function Number: 2
func_E133()
{
	self notify("remove_kinetic_pulse");
}

//Function Number: 3
func_E85E()
{
	self endon("death");
	self endon("disconnect");
	self endon("remove_kinetic_pulse");
	playfx(level.var_A6D2["blast"],self.origin);
	self playlocalsound("kinetic_pulse");
	self playsound("kinetic_pulse_npc");
	var_00 = undefined;
	if(level.teambased)
	{
		var_00 = scripts\cp\_utility::func_81A0(scripts\cp\_utility::getotherteam(self.team));
	}
	else
	{
		var_00 = level.var_3CB5;
	}

	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02) || var_02 == self || !scripts\cp\_utility::func_9F19(var_02))
		{
			continue;
		}

		if(distance2dsquared(self.origin,var_02.origin) < 100000 && isplayer(var_02))
		{
			var_02 thread func_A6D4(self);
		}
	}

	self notify("powers_kinetic_pulse_cooldown_start");
}

//Function Number: 4
func_A6D4(param_00)
{
	self endon("disconnect");
	var_01 = level.var_D782["power_kineticPulse"].var_5FF3;
	self shellshock("concussion_grenade_mp",1);
	self.var_11196 = 1;
	if(isdefined(level.scriptablestatefunc))
	{
		self thread [[ level.scriptablestatefunc ]](self);
	}

	scripts\common\utility::waittill_any_timeout_1(var_01,"death");
	self.var_11196 = undefined;
}

//Function Number: 5
func_A6D5()
{
	var_00 = gettime() + level.var_D782["power_kineticPulse"].var_5FF3 * 1000;
	scripts\cp\powers\coop_powers::func_D740(0);
	while(gettime() < var_00)
	{
		wait(0.1);
	}

	scripts\cp\powers\coop_powers::func_D74E();
}