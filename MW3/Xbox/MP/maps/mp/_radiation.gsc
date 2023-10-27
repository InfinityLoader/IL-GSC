/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_radiation.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 286 ms
 * Timestamp: 10/27/2023 2:27:52 AM
*******************************************************************/

//Function Number: 1
func_2719()
{
	precachestring(&"SCRIPT_RADIATION_DEATH");
	var_00 = getentarray("radiation","targetname");
	if(var_00.size > 0)
	{
		precacheshellshock("mp_radiation_low");
		precacheshellshock("mp_radiation_med");
		precacheshellshock("mp_radiation_high");
		foreach(var_02 in var_00)
		{
			var_02 thread common_scripts\_dynamic_world::triggertouchthink(::func_271B,::playerleavearea);
		}

		thread onplayerconnect();
	}
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_271A = 0;
	}
}

//Function Number: 3
func_271B(param_00)
{
	self.var_271A++;
	if(self.var_271A == 1)
	{
		func_2720();
	}
}

//Function Number: 4
playerleavearea(param_00)
{
	self.var_271A--;
	if(self.var_271A != 0)
	{
		return;
	}

	self.var_271D = 0;
	self notify("leftTrigger");
	if(isdefined(self.var_271E))
	{
		self.var_271E fadeoutblackout(0.1,0);
	}
}

//Function Number: 5
func_271F(param_00)
{
	common_scripts\utility::waittill_any("death","leftTrigger");
	self stoploopsound();
}

//Function Number: 6
func_2720()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	self.var_271D = 0;
	thread func_271F(self);
	for(;;)
	{
		self.var_271D++;
		switch(self.var_271D)
		{
			case 1:
				self.radiationsound = "item_geigercouner_level2";
				self playloopsound(self.radiationsound);
				self viewkick(1,self.origin);
				break;
	
			case 3:
				self shellshock("mp_radiation_low",4);
				self.radiationsound = "item_geigercouner_level3";
				self stoploopsound();
				self playloopsound(self.radiationsound);
				self viewkick(3,self.origin);
				doradiationdamage(15);
				break;
	
			case 4:
				self shellshock("mp_radiation_med",5);
				self.radiationsound = "item_geigercouner_level3";
				self stoploopsound();
				self playloopsound(self.radiationsound);
				self viewkick(15,self.origin);
				thread blackout();
				doradiationdamage(25);
				break;
	
			case 6:
				self shellshock("mp_radiation_high",5);
				self.radiationsound = "item_geigercouner_level4";
				self stoploopsound();
				self playloopsound(self.radiationsound);
				self viewkick(75,self.origin);
				doradiationdamage(45);
				break;
	
			case 8:
				self shellshock("mp_radiation_high",5);
				self.radiationsound = "item_geigercouner_level4";
				self stoploopsound();
				self playloopsound(self.radiationsound);
				self viewkick(127,self.origin);
				doradiationdamage(175);
				break;
		}

		wait 1;
	}

	wait 5;
}

//Function Number: 7
blackout()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	if(!isdefined(self.var_271E))
	{
		self.var_271E = newclienthudelem(self);
		self.var_271E.x = 0;
		self.var_271E.y = 0;
		self.var_271E setshader("black",640,480);
		self.var_271E.alignx = "left";
		self.var_271E.aligny = "top";
		self.var_271E.horzalign = "fullscreen";
		self.var_271E.vertalign = "fullscreen";
		self.var_271E.alpha = 0;
	}

	var_00 = 1;
	var_01 = 2;
	var_02 = 0.25;
	var_03 = 1;
	var_04 = 5;
	var_05 = 100;
	var_06 = 0;
	for(;;)
	{
		while(self.var_271D > 1)
		{
			var_07 = var_05 - var_04;
			var_06 = self.var_271D - var_04 / var_07;
			if(var_06 < 0)
			{
				var_06 = 0;
			}
			else if(var_06 > 1)
			{
				var_06 = 1;
			}

			var_08 = var_01 - var_00;
			var_09 = var_00 + var_08 * 1 - var_06;
			var_0A = var_03 - var_02;
			var_0B = var_02 + var_0A * var_06;
			var_0C = var_06 * 0.5;
			if(var_06 == 1)
			{
				break;
			}

			var_0D = var_09 / 2;
			self.var_271E func_2724(var_0D,var_0B);
			self.var_271E fadeoutblackout(var_0D,var_0C);
			wait var_06 * 0.5;
		}

		if(var_06 == 1)
		{
			break;
		}

		if(self.var_271E.alpha != 0)
		{
			self.var_271E fadeoutblackout(1,0);
		}

		wait 0.05;
	}

	self.var_271E func_2724(2,0);
}

//Function Number: 8
doradiationdamage(param_00)
{
	self thread [[ level.callbackplayerdamage ]](self,self,param_00,0,"MOD_SUICIDE","claymore_mp",self.origin,(0,0,0) - self.origin,"none",0);
}

//Function Number: 9
func_2724(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	wait param_00;
}

//Function Number: 10
fadeoutblackout(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	wait param_00;
}