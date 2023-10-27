/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_serversettings.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 63 ms
 * Timestamp: 10/27/2023 3:24:25 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_4E0E = getdvar("5656");
	if(level.var_4E0E == "")
	{
		level.var_4E0E = "CoDHost";
	}

	setdvar("5656",level.var_4E0E);
	level.var_C32 = getdvarint("4372",1);
	setdvar("4372",level.var_C32);
	level.var_3EC4 = maps\mp\gametypes\_tweakables::func_46F7("team","fftype");
	func_2596(getdvar("1924"));
	for(;;)
	{
		func_A164();
		wait(5);
	}
}

//Function Number: 2
func_A164()
{
	var_00 = getdvar("5656");
	if(level.var_4E0E != var_00)
	{
		level.var_4E0E = var_00;
	}

	var_01 = getdvarint("4372",1);
	if(level.var_C32 != var_01)
	{
		level.var_C32 = var_01;
	}

	var_02 = maps\mp\gametypes\_tweakables::func_46F7("team","fftype");
	if(level.var_3EC4 != var_02)
	{
		level.var_3EC4 = var_02;
	}
}

//Function Number: 3
func_2596(param_00)
{
	var_01 = getentarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(param_00 == "dm")
		{
			if(isdefined(var_03.var_81C1) && var_03.var_81C1 != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "tdm")
		{
			if(isdefined(var_03.var_81C5) && var_03.var_81C5 != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "ctf")
		{
			if(isdefined(var_03.var_81C0) && var_03.var_81C0 != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "hq")
		{
			if(isdefined(var_03.var_81C2) && var_03.var_81C2 != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "sd")
		{
			if(isdefined(var_03.var_81C4) && var_03.var_81C4 != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "koth")
		{
			if(isdefined(var_03.var_81C3) && var_03.var_81C3 != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "atdm")
		{
			if(isdefined(var_03.var_81BF) && var_03.var_81BF != "1")
			{
				var_03 delete();
			}
		}
	}
}