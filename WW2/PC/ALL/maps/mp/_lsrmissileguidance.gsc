/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_lsrmissileguidance.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 42 ms
 * Timestamp: 10/27/2023 3:21:30 AM
*******************************************************************/

//Function Number: 1
func_631C()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		if(issubstr(var_01,"maaws"))
		{
			if(!isdefined(self.var_5F39))
			{
				self.var_5F39 = spawn("script_origin",self.var_116);
				self.var_5F39.var_1A5 = "lsr_missile";
			}

			self.var_5F39 thread func_5F3A(var_00);
			var_00 thread func_5F38(self);
		}
	}
}

//Function Number: 2
func_5F38(param_00)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("faux_spawn");
	for(;;)
	{
		if(param_00 playerads() > 0.3)
		{
			var_01 = anglestoforward(param_00 getangles());
			var_02 = param_00 geteye();
			var_03 = var_02 + var_01 * 15000;
			var_04 = bullettrace(var_02,var_03,1,param_00,1,0,0,0,0);
			param_00.var_5F39.var_116 = var_04["position"];
			self method_81D9(param_00.var_5F39);
		}

		wait 0.05;
	}
}

//Function Number: 3
func_5F3A(param_00)
{
	if(!isdefined(self.var_5F37))
	{
		self.var_5F37 = 1;
	}
	else
	{
		self.var_5F37++;
	}

	param_00 waittill("death");
	self.var_5F37--;
	if(self.var_5F37 == 0)
	{
		self delete();
	}
}