/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_radiation.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 156 ms
 * Timestamp: 10/27/2023 2:16:51 AM
*******************************************************************/

//Function Number: 1
radiation()
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
			var_02 thread common_scripts\_dynamic_world::triggertouchthink(::playerenterarea,::playerleavearea);
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
		var_00.var_2BC2 = 0;
	}
}

//Function Number: 3
playerenterarea(param_00)
{
	self.var_2BC2++;
	if(self.var_2BC2 == 1)
	{
		radiationeffect();
	}
}

//Function Number: 4
playerleavearea(param_00)
{
	self.var_2BC2--;
	if(self.var_2BC2 != 0)
	{
		return;
	}

	self.var_2BC5 = 0;
	self notify("leftTrigger");
	if(isdefined(self.var_2BC6))
	{
		self.var_2BC6 fadeoutblackout(0.1,0);
	}
}

//Function Number: 5
soundwatcher(param_00)
{
	common_scripts\utility::waittill_any("death","leftTrigger");
	self stoploopsound();
}

//Function Number: 6
radiationeffect()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	self.var_2BC5 = 0;
	thread soundwatcher(self);
	for(;;)
	{
		self.var_2BC5++;
		switch(self.var_2BC5)
		{
			case 1:
				self.var_2BC9 = "item_geigercouner_level2";
				self playloopsound(self.var_2BC9);
				self viewkick(1,self.origin);
				break;
	
			case 3:
				self shellshock("mp_radiation_low",4);
				self.var_2BC9 = "item_geigercouner_level3";
				self stoploopsound();
				self playloopsound(self.var_2BC9);
				self viewkick(3,self.origin);
				doradiationdamage(15);
				break;
	
			case 4:
				self shellshock("mp_radiation_med",5);
				self.var_2BC9 = "item_geigercouner_level3";
				self stoploopsound();
				self playloopsound(self.var_2BC9);
				self viewkick(15,self.origin);
				thread blackout();
				doradiationdamage(25);
				break;
	
			case 6:
				self shellshock("mp_radiation_high",5);
				self.var_2BC9 = "item_geigercouner_level4";
				self stoploopsound();
				self playloopsound(self.var_2BC9);
				self viewkick(75,self.origin);
				doradiationdamage(45);
				break;
	
			case 8:
				self shellshock("mp_radiation_high",5);
				self.var_2BC9 = "item_geigercouner_level4";
				self stoploopsound();
				self playloopsound(self.var_2BC9);
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
	if(!isdefined(self.var_2BC6))
	{
		self.var_2BC6 = newclienthudelem(self);
		self.var_2BC6.x = 0;
		self.var_2BC6.y = 0;
		self.var_2BC6 setshader("black",640,480);
		self.var_2BC6.alignx = "left";
		self.var_2BC6.aligny = "top";
		self.var_2BC6.horzalign = "fullscreen";
		self.var_2BC6.vertalign = "fullscreen";
		self.var_2BC6.alpha = 0;
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
		while(self.var_2BC5 > 1)
		{
			var_07 = var_05 - var_04;
			var_06 = self.var_2BC5 - var_04 / var_07;
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
			self.var_2BC6 fadeinblackout(var_0D,var_0B);
			self.var_2BC6 fadeoutblackout(var_0D,var_0C);
			wait var_06 * 0.5;
		}

		if(var_06 == 1)
		{
			break;
		}

		if(self.var_2BC6.alpha != 0)
		{
			self.var_2BC6 fadeoutblackout(1,0);
		}

		wait 0.05;
	}

	self.var_2BC6 fadeinblackout(2,0);
}

//Function Number: 8
doradiationdamage(param_00)
{
	self thread [[ level.callbackplayerdamage ]](self,self,param_00,0,"MOD_SUICIDE","claymore_mp",self.origin,(0,0,0) - self.origin,"none",0);
}

//Function Number: 9
fadeinblackout(param_00,param_01)
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