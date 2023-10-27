/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_areas.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 100 ms
 * Timestamp: 10/27/2023 1:22:03 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.softlandingtriggers = getentarray("trigger_multiple_softlanding","classname");
	var_00 = getentarray("destructible_vehicle","targetname");
	foreach(var_02 in level.softlandingtriggers)
	{
		if(var_02.script_type != "car")
		{
			continue;
		}

		foreach(var_04 in var_00)
		{
			if(distance(var_02.origin,var_04.origin) > 64)
			{
				continue;
			}

			var_02.destructible = var_04;
		}
	}

	thread func_595D();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.softlanding = undefined;
		var_00 thread softlandingwaiter();
	}
}

//Function Number: 3
func_5FAA(param_00)
{
	self.softlanding = param_00;
}

//Function Number: 4
func_5FC6(param_00)
{
	self.softlanding = undefined;
}

//Function Number: 5
softlandingwaiter()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("soft_landing",var_00,var_01);
		if(!isdefined(var_00.destructible))
		{
			continue;
		}
	}
}