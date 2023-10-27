/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_stop_current_floodspawner.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 53 ms
 * Timestamp: 10/27/2023 3:21:45 AM
*******************************************************************/

//Function Number: 1
func_9DB1(param_00,param_01)
{
	param_00 endon("death");
	param_00 waittill("trigger",var_02);
	param_00 common_scripts\utility::func_161();
	maps\mp\_utility::func_FA8(param_00.var_1A2);
	if(isdefined(param_01))
	{
		common_scripts\utility::func_3C8F(param_01,var_02);
	}
}

//Function Number: 2
func_9D7C(param_00)
{
	param_00 endon("death");
	param_00 waittill("trigger");
	param_00 common_scripts\utility::func_161();
	var_01 = getentarray(param_00.var_1A2,"targetname");
	common_scripts\utility::func_FB2(var_01,::func_3D85);
}

//Function Number: 3
func_3D85()
{
	self endon("death");
	self notify("stop_current_floodspawner");
	self endon("stop_current_floodspawner");
	if(!isdefined(self.var_5C) || self.var_5C <= 0)
	{
		return;
	}

	while(self.var_5C > 0)
	{
		var_00 = maps\mp\_utility::func_FA7([self]);
		var_01 = var_00[0];
		if(!isdefined(var_01))
		{
			wait(2);
			continue;
		}

		var_01 waittill("death",var_02);
		if(!common_scripts\utility::func_8155())
		{
			wait(randomfloatrange(5,9));
		}
	}
}