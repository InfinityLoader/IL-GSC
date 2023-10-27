/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3614.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:30:55 AM
*******************************************************************/

//Function Number: 1
func_5374()
{
	precacheitem("car_grenade");
	thread func_5375();
}

//Function Number: 2
func_5375()
{
	scripts\common\utility::func_136F7();
	var_00 = getentarray("scriptable","code_classname");
	foreach(var_02 in var_00)
	{
		if(issubstr(var_02.model,"veh_"))
		{
			var_02 thread func_5376();
		}
	}
}

//Function Number: 3
func_5376()
{
	self.var_ED = "vehicle";
	for(;;)
	{
		self waittill("scriptableNotification",var_00,var_01);
		switch(var_00)
		{
			case "onfire":
			case "flareup":
				thread func_329E();
				break;
	
			case "vehicle_death":
				self notify("destroyed");
				if(isdefined(self.var_329F))
				{
					self.var_329F delete();
				}
				self.var_C528 = undefined;
				break;
		}
	}
}

//Function Number: 4
func_329E()
{
	if(isdefined(self.var_329F))
	{
		return;
	}

	self endon("destroyed");
	self.var_C528 = 1;
	wait(0.2);
	self.var_329F = function_0135("car_grenade",self.origin + (0,0,10),self.origin,9999,0);
	self.var_329F.var_C182 = 1;
	self.var_329F makeunusable();
}