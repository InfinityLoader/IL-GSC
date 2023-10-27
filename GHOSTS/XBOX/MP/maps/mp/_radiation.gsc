/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_radiation.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 10
 * Decompile Time: 142 ms
 * Timestamp: 10/27/2023 1:30:05 AM
*******************************************************************/

//Function Number: 1
func_62B3()
{
	var_00 = getentarray("radiation","targetname");
	if(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			var_02 thread common_scripts\_dynamic_world::func_83BD(::func_5FA9,::func_5FC5);
		}

		thread func_595D();
	}
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.numareas = 0;
	}
}

//Function Number: 3
func_5FA9(param_00)
{
	self.numareas++;
	if(self.numareas == 1)
	{
		radiationeffect();
	}
}

//Function Number: 4
func_5FC5(param_00)
{
	self.numareas--;
	if(self.numareas != 0)
	{
	}

	self.poison = 0;
	self notify("leftTrigger");
	if(isdefined(self.radiationoverlay))
	{
		self.radiationoverlay func_3151(0.1,0);
	}
}

//Function Number: 5
func_7726(param_00)
{
	common_scripts\utility::func_8B2A("death","leftTrigger");
	self stoploopsound();
}

//Function Number: 6
radiationeffect()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	self.poison = 0;
	thread func_7726(self);
	for(;;)
	{
		self.poison++;
		switch(self.poison)
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
				func_2A07(15);
				break;
	
			case 4:
				self shellshock("mp_radiation_med",5);
				self.radiationsound = "item_geigercouner_level3";
				self stoploopsound();
				self playloopsound(self.radiationsound);
				self viewkick(15,self.origin);
				thread blackout();
				func_2A07(25);
				break;
	
			case 6:
				self shellshock("mp_radiation_high",5);
				self.radiationsound = "item_geigercouner_level4";
				self stoploopsound();
				self playloopsound(self.radiationsound);
				self viewkick(75,self.origin);
				func_2A07(45);
				break;
	
			case 8:
				self shellshock("mp_radiation_high",5);
				self.radiationsound = "item_geigercouner_level4";
				self stoploopsound();
				self playloopsound(self.radiationsound);
				self viewkick(127,self.origin);
				func_2A07(175);
				break;
		}

		wait(1);
	}

	wait(5);
}

//Function Number: 7
blackout()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	if(!isdefined(self.radiationoverlay))
	{
		self.radiationoverlay = newclienthudelem(self);
		self.radiationoverlay.x = 0;
		self.radiationoverlay.y = 0;
		self.radiationoverlay setmaterial("black",640,480);
		self.radiationoverlay.alignx = "left";
		self.radiationoverlay.aligny = "top";
		self.radiationoverlay.horzalign = "fullscreen";
		self.radiationoverlay.vertalign = "fullscreen";
		self.radiationoverlay.alpha = 0;
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
		while(self.poison > 1)
		{
			var_07 = var_05 - var_04;
			var_06 = self.poison - var_04 / var_07;
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
			self.radiationoverlay fadeinblackout(var_0D,var_0B);
			self.radiationoverlay func_3151(var_0D,var_0C);
			wait(var_06 * 0.5);
		}

		if(var_06 == 1)
		{
			break;
		}

		if(self.radiationoverlay.alpha != 0)
		{
			self.radiationoverlay func_3151(1,0);
		}

		wait(0.05);
	}

	self.radiationoverlay fadeinblackout(2,0);
}

//Function Number: 8
func_2A07(param_00)
{
	self thread [[ level.callbackplayerdamage ]](self,self,param_00,0,"MOD_SUICIDE","claymore_mp",self.origin,(0,0,0) - self.origin,"none",0);
}

//Function Number: 9
fadeinblackout(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	wait(param_00);
}

//Function Number: 10
func_3151(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	wait(param_00);
}