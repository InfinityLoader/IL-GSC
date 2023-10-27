/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3335.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:26:35 AM
*******************************************************************/

//Function Number: 1
func_333E(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	param_00 thread func_3331(self);
	param_00.var_11832 = gettime();
	func_332E(param_00);
	thread func_3340();
	thread func_333F();
	param_00 thread func_3339();
	param_00 waittill("missile_stuck");
	scripts\cp\_weapon::func_C54E(param_00,"power_c4");
	thread scripts\cp\_weapon::func_B9CA(self,param_00);
	param_00 setscriptablepartstate("plant","active",0);
}

//Function Number: 2
func_3335()
{
	self endon("death");
	self.var_222 endon("disconnect");
	wait(0.1);
	thread func_3338(self.var_222);
}

//Function Number: 3
func_3338(param_00)
{
	thread func_3330(5);
	self method_82DD(param_00);
	self setscriptablepartstate("plant","neutral",0);
	self setscriptablepartstate("explode","active",0);
}

//Function Number: 4
func_3332(param_00)
{
	thread func_3330(2);
	self setscriptablepartstate("plant","neutral",0);
	self setscriptablepartstate("destroy","active",0);
}

//Function Number: 5
func_3330(param_00)
{
	self notify("death");
	level.var_B779[self getentitynumber()] = undefined;
	self.var_69BA = 1;
	var_01 = self.var_222;
	if(isdefined(self.var_222))
	{
		var_01.var_CC4C = scripts\common\utility::func_22A9(var_01.var_CC4C,self);
		var_01 notify("c4_update",0);
	}

	wait(param_00);
	self delete();
}

//Function Number: 6
func_3339()
{
	self endon("death");
	self.var_222 endon("disconnect");
	level endon("game_ended");
	var_00 = self.var_222;
	self waittill("detonateExplosive",var_01);
	if(isdefined(var_01))
	{
		thread func_3338(var_01);
		return;
	}

	thread func_3338(var_00);
}

//Function Number: 7
func_3333()
{
	self endon("death");
	self.var_222 endon("disconnect");
	self waittill("emp_damage",var_00,var_01);
	if(isdefined(self.var_222) && var_00 != self.var_222)
	{
		var_00 notify("destroyed_equipment");
	}

	thread func_3332();
}

//Function Number: 8
func_332F(param_00)
{
	return gettime() - self.var_11832 / 1000 > 0.3 && !isdefined(self.var_53D7);
}

//Function Number: 9
func_3340()
{
	self endon("death");
	self endon("disconnect");
	self endon("c4_unset");
	level endon("game_ended");
	self notify("watchForDetonation");
	self endon("watchForDetonation");
	for(;;)
	{
		self waittillmatch("c4_zm","detonate");
		thread func_3336();
	}
}

//Function Number: 10
func_333F()
{
	self endon("death");
	self endon("disconnect");
	self endon("c4_unset");
	level endon("game_ended");
	self notify("watchForAltDetonation");
	self endon("watchForAltDetonation");
	var_00 = 0;
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = 0;
			while(self usebuttonpressed())
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			var_00 = 0;
			while(!self usebuttonpressed() && var_00 < 0.5)
			{
				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			if(var_00 >= 0.5)
			{
				continue;
			}

			if(!lib_0D12::func_9DDF(self) && !scripts\cp\_utility::func_9FC6() && scripts\cp\_utility::func_9F19(self))
			{
				thread func_3336();
			}
		}

		wait(0.05);
	}
}

//Function Number: 11
func_3336()
{
	if(isdefined(self.var_334E))
	{
		foreach(var_01 in self.var_334E)
		{
			if(var_01 func_332F())
			{
				var_01 thread func_3335();
			}
		}
	}
}

//Function Number: 12
func_332E(param_00)
{
	var_01 = self.var_222;
	if(!isdefined(self.var_334E))
	{
		self.var_334E = [];
	}

	self.var_334E[param_00 getentitynumber()] = param_00;
	thread func_333C(param_00);
}

//Function Number: 13
func_333B(param_00)
{
	if(!isdefined(self.var_334E))
	{
		return;
	}

	self.var_334E[param_00] = undefined;
}

//Function Number: 14
func_333C(param_00)
{
	self endon("disconnect");
	var_01 = param_00 getentitynumber();
	param_00 waittill("death");
	func_333B(var_01);
}

//Function Number: 15
func_3331(param_00)
{
	self endon("death");
	self endon("missile_stuck");
	param_00 waittill("disconnect");
	self delete();
}