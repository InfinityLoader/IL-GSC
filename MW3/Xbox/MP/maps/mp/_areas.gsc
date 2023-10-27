/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_areas.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 5
 * Decompile Time: 113 ms
 * Timestamp: 10/27/2023 2:27:34 AM
*******************************************************************/

//Function Number: 1
init()
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

	thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.softlanding = undefined;
		var_00 thread softlandingwaiter();
	}
}

//Function Number: 3
func_2DC4(param_00)
{
	self.softlanding = param_00;
}

//Function Number: 4
func_2DC5(param_00)
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