/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_areas.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 315 ms
 * Timestamp: 10/27/2023 12:14:27 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_103E9 = getentarray("trigger_multiple_softlanding","classname");
	var_00 = getentarray("destructible_vehicle","targetname");
	foreach(var_02 in level.var_103E9)
	{
		if(var_02.var_EEFA != "car")
		{
			continue;
		}

		foreach(var_04 in var_00)
		{
			if(distance(var_02.origin,var_04.origin) > 64)
			{
				continue;
			}

			var_02.var_5336 = var_04;
		}
	}

	thread func_C56E();
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_103E8 = undefined;
		var_00 thread func_103EA();
	}
}

//Function Number: 3
func_D389(param_00)
{
	self.var_103E8 = param_00;
}

//Function Number: 4
func_D3CF(param_00)
{
	self.var_103E8 = undefined;
}

//Function Number: 5
func_103EA()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("soft_landing",var_00,var_01);
		if(!isdefined(var_00.var_5336))
		{
			continue;
		}
	}
}