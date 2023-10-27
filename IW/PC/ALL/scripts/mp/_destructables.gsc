/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_destructables.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 403 ms
 * Timestamp: 10/27/2023 12:15:07 AM
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
		var_00[var_01] thread func_5335();
	}
}

//Function Number: 2
func_5335()
{
	var_00 = 40;
	var_01 = 0;
	if(isdefined(self.var_ECE4))
	{
		var_00 = self.var_ECE4;
	}

	if(isdefined(self.var_EEE3))
	{
		var_01 = self.var_EEE3;
	}

	if(isdefined(self.var_ED59))
	{
		var_02 = strtok(self.var_ED59," ");
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			func_2BAB(var_02[var_03]);
		}
	}

	if(isdefined(self.script_fxid))
	{
		self.var_7542 = loadfx(self.script_fxid);
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
				thread func_5334();
				return;
			}
		}
	}
}

//Function Number: 3
func_5334()
{
	var_00 = self;
	if(isdefined(self.var_ED59))
	{
		var_01 = strtok(self.var_ED59," ");
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			func_12B81(var_01[var_02]);
		}
	}

	if(isdefined(var_00.var_7542))
	{
		playfx(var_00.var_7542,var_00.origin + (0,0,6));
	}

	var_00 delete();
}

//Function Number: 4
func_2BAB(param_00)
{
}

//Function Number: 5
func_2BAD(param_00,param_01)
{
}

//Function Number: 6
func_12B81(param_00)
{
}

//Function Number: 7
func_12B82(param_00,param_01)
{
}