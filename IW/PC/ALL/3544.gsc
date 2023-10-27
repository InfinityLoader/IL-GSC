/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3544.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:30:38 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["battery_pulse"] = loadfx("vfx/iw7/_requests/mp/vfx_battery_pulse");
	level._effect["battery_target"] = loadfx("vfx/iw7/_requests/mp/vfx_battery_pulse_target");
	level._effect["battery_screen"] = loadfx("vfx/iw7/_requests/mp/vfx_battery_pulse_screen");
	level._effect["battery_cooldown"] = loadfx("vfx/iw7/_requests/mp/vfx_battery_pulse_cooldown");
}

//Function Number: 2
func_E83B(param_00)
{
	if(!isagent(self))
	{
		scripts\mp\_powers::func_D740(2);
		thread func_139AC(param_00);
		thread func_139AB(4,"stop_battery_linger");
		thread func_CEE7("battery_cooldown",0.1,4,1,"stop_battery_linger");
		if(isdefined(self) && isdefined(param_00))
		{
			scripts\mp\_gamescore::func_11AC9(param_00,self,"power_battery");
		}
	}
}

//Function Number: 3
func_139AB(param_00,param_01,param_02)
{
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::waittill_any_timeout_1(param_00,"death");
	if(!isdefined(param_02))
	{
		self notify(param_01);
		return;
	}

	self notify(param_01,param_02);
}

//Function Number: 4
func_139AC(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("stop_battery_linger");
	scripts\mp\_powers::func_D74E();
	self.var_28C7 = undefined;
	if(isdefined(self) && isdefined(param_00))
	{
		scripts\mp\_gamescore::func_12D6E(self,param_00,"power_battery");
	}
}

//Function Number: 5
func_CEE7(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("death");
	self endon("disconnect");
	self endon(param_04);
	level endon("game_ended");
	if(!isdefined(param_03) || !param_03)
	{
		var_07 = self.origin;
		if(isdefined(param_05))
		{
			var_07 = self gettagorigin(param_05);
		}

		var_08 = spawn("script_model",var_07);
		var_08 setmodel("tag_origin");
		var_08 linkto(self,"tag_origin",(0,0,0),(90,0,0));
		var_08 thread scripts\mp\_utility::func_5106(param_02);
		for(;;)
		{
			playfxontagforclients(scripts\common\utility::getfx(param_00),var_08,"tag_origin",param_06);
			wait(param_01);
		}

		return;
	}

	for(;;)
	{
		var_09 = function_01E1(scripts\common\utility::getfx(param_00),self gettagorigin("tag_eye"),self);
		triggerfx(var_09);
		var_09 thread scripts\mp\_utility::func_5106(param_01);
		wait(param_01);
	}
}