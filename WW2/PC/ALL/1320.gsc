/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1320.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:25:11 AM
*******************************************************************/

//Function Number: 1
func_52F3()
{
	level.var_9854["allies"] = 0;
	level.var_9854["axis"] = 0;
	level.var_9850["allies"] = 0;
	level.var_9850["axis"] = 0;
	level.var_3CE0 = undefined;
	level.var_2694 = undefined;
}

//Function Number: 2
func_A0E0()
{
	foreach(var_01 in level.var_744A)
	{
		if(level.var_984D)
		{
			var_01 func_A150();
			continue;
		}

		var_01 func_A14F();
	}
}

//Function Number: 3
func_A150()
{
	var_00 = 0;
	var_01 = "allies";
	if(self.var_1A7 == "axis")
	{
		var_01 = "axis";
	}

	if(level.var_9854[var_01])
	{
		var_00 = -2;
	}
	else if(level.var_9850[var_01])
	{
		var_00 = -1;
	}
	else if(level.var_9854[maps\mp\_utility::func_45DE(var_01)])
	{
		var_00 = 2;
	}
	else if(level.var_9850[maps\mp\_utility::func_45DE(var_01)])
	{
		var_00 = 1;
	}

	self setclientomnvar("ui_minimap_antiair_state",var_00);
}

//Function Number: 4
func_A14F()
{
	var_00 = 0;
	if(isdefined(level.var_3CE0))
	{
		var_00 = 2;
		if(level.var_3CE0 != self)
		{
			var_00 = var_00 * -1;
		}
	}
	else if(isdefined(level.var_2694))
	{
		var_00 = 1;
		if(level.var_2694 != self)
		{
			var_00 = var_00 * -1;
		}
	}

	self setclientomnvar("ui_minimap_antiair_state",var_00);
}