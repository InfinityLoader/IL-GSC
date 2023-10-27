/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_radiation.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 371 ms
 * Timestamp: 10/27/2023 12:21:24 AM
*******************************************************************/

//Function Number: 1
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_C210 = 0;
	}
}

//Function Number: 2
func_D387(param_00)
{
	self.var_C210++;
	if(self.var_C210 == 1)
	{
		func_DBE8();
	}
}

//Function Number: 3
func_D3CE(param_00)
{
	self.var_C210--;
	if(self.var_C210 != 0)
	{
		return;
	}

	self.var_D64C = 0;
	self notify("leftTrigger");
	if(isdefined(self.var_DBE9))
	{
		self.var_DBE9 func_6AB9(0.1,0);
	}
}

//Function Number: 4
func_10481(param_00)
{
	scripts\common\utility::waittill_any_3("death","leftTrigger");
	self stoploopsound();
}

//Function Number: 5
func_DBE8()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	self.var_D64C = 0;
	thread func_10481(self);
	for(;;)
	{
		self.var_D64C++;
		switch(self.var_D64C)
		{
			case 1:
				self.var_DBEA = "item_geigercouner_level2";
				self playloopsound(self.var_DBEA);
				self method_83F6(1,self.origin);
				break;
	
			case 3:
				self shellshock("mp_radiation_low",4);
				self.var_DBEA = "item_geigercouner_level3";
				self stoploopsound();
				self playloopsound(self.var_DBEA);
				self method_83F6(3,self.origin);
				func_5A64(15);
				break;
	
			case 4:
				self shellshock("mp_radiation_med",5);
				self.var_DBEA = "item_geigercouner_level3";
				self stoploopsound();
				self playloopsound(self.var_DBEA);
				self method_83F6(15,self.origin);
				thread func_2B48();
				func_5A64(25);
				break;
	
			case 6:
				self shellshock("mp_radiation_high",5);
				self.var_DBEA = "item_geigercouner_level4";
				self stoploopsound();
				self playloopsound(self.var_DBEA);
				self method_83F6(75,self.origin);
				func_5A64(45);
				break;
	
			case 8:
				self shellshock("mp_radiation_high",5);
				self.var_DBEA = "item_geigercouner_level4";
				self stoploopsound();
				self playloopsound(self.var_DBEA);
				self method_83F6(127,self.origin);
				func_5A64(175);
				break;
		}

		wait(1);
	}

	wait(5);
}

//Function Number: 6
func_2B48()
{
	self endon("disconnect");
	self endon("game_ended");
	self endon("death");
	self endon("leftTrigger");
	if(!isdefined(self.var_DBE9))
	{
		self.var_DBE9 = newclienthudelem(self);
		self.var_DBE9.x = 0;
		self.var_DBE9.y = 0;
		self.var_DBE9 setshader("black",640,480);
		self.var_DBE9.alignx = "left";
		self.var_DBE9.aligny = "top";
		self.var_DBE9.horzalign = "fullscreen";
		self.var_DBE9.vertalign = "fullscreen";
		self.var_DBE9.alpha = 0;
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
		while(self.var_D64C > 1)
		{
			var_07 = var_05 - var_04;
			var_06 = self.var_D64C - var_04 / var_07;
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
			self.var_DBE9 func_6AB7(var_0D,var_0B);
			self.var_DBE9 func_6AB9(var_0D,var_0C);
			wait(var_06 * 0.5);
		}

		if(var_06 == 1)
		{
			break;
		}

		if(self.var_DBE9.alpha != 0)
		{
			self.var_DBE9 func_6AB9(1,0);
		}

		wait(0.05);
	}

	self.var_DBE9 func_6AB7(2,0);
}

//Function Number: 7
func_5A64(param_00)
{
	self thread [[ level.callbackplayerdamage ]](self,self,param_00,0,"MOD_SUICIDE","claymore_mp",self.origin,(0,0,0) - self.origin,"none",0);
}

//Function Number: 8
func_6AB7(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	wait(param_00);
}

//Function Number: 9
func_6AB9(param_00,param_01)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	wait(param_00);
}