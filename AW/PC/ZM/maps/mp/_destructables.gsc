/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_destructables.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 119 ms
 * Timestamp: 10/27/2023 2:08:05 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = getentarray("destructable","targetname");
	if(getdvar("scr_destructables") == "0")
	{
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			var_00[var_01] delete();
		}

		return;
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] thread destructable_think();
	}
}

//Function Number: 2
destructable_think()
{
	var_00 = 40;
	var_01 = 0;
	if(isdefined(self.script_accumulate))
	{
		var_00 = self.script_accumulate;
	}

	if(isdefined(self.script_threshold))
	{
		var_01 = self.script_threshold;
	}

	if(isdefined(self.script_destructable_area))
	{
		var_02 = strtok(self.script_destructable_area," ");
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			blockarea(var_02[var_03]);
		}
	}

	if(isdefined(self.script_fxid))
	{
		self.fx = loadfx(self.script_fxid);
	}

	var_04 = 0;
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_05,var_06);
		if(var_05 >= var_01)
		{
			var_04 = var_04 + var_05;
			if(var_04 >= var_00)
			{
				thread destructable_destruct();
				return;
			}
		}
	}
}

//Function Number: 3
destructable_destruct()
{
	var_00 = self;
	if(isdefined(self.script_destructable_area))
	{
		var_01 = strtok(self.script_destructable_area," ");
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			unblockarea(var_01[var_02]);
		}
	}

	if(isdefined(var_00.fx))
	{
		playfx(var_00.fx,var_00.origin + (0,0,6));
	}

	var_00 delete();
}

//Function Number: 4
blockarea(param_00)
{
}

//Function Number: 5
blockentsinarea(param_00,param_01)
{
}

//Function Number: 6
unblockarea(param_00)
{
}

//Function Number: 7
unblockentsinarea(param_00,param_01)
{
}