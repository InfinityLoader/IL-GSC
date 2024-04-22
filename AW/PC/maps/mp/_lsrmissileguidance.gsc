/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_lsrmissileguidance.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 69 ms
 * Timestamp: 4/22/2024 2:15:58 AM
*******************************************************************/

//Function Number: 1
monitor_lsr_missile_launch()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		if(issubstr(var_01,"maaws") || issubstr(var_01,"dlcgun11loot3"))
		{
			if(!isdefined(self.lsr_target_ent))
			{
				self.lsr_target_ent = spawn("script_origin",self.origin);
				self.lsr_target_ent.targetname = "lsr_missile";
			}

			self.lsr_target_ent thread lsr_target_monitor_and_cleanup(var_00);
			var_00 thread lsr_rocket_think(self);
		}
	}
}

//Function Number: 2
lsr_rocket_think(param_00)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("faux_spawn");
	for(;;)
	{
		if(param_00 playerads() > 0.3)
		{
			var_01 = anglestoforward(param_00 getplayerangles());
			var_02 = param_00 geteye();
			var_03 = var_02 + var_01 * 15000;
			var_04 = bullettrace(var_02,var_03,1,param_00,1,0,0,0,0);
			param_00.lsr_target_ent.origin = var_04["position"];
			self missile_settargetent(param_00.lsr_target_ent);
		}

		wait(0.05);
	}
}

//Function Number: 3
lsr_target_monitor_and_cleanup(param_00)
{
	if(!isdefined(self.lsr_rocket_count))
	{
		self.lsr_rocket_count = 1;
	}
	else
	{
		self.lsr_rocket_count++;
	}

	param_00 waittill("death");
	self.lsr_rocket_count--;
	if(self.lsr_rocket_count == 0)
	{
		self delete();
	}
}