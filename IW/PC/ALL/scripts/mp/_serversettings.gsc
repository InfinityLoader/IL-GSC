/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_serversettings.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 208 ms
 * Timestamp: 10/27/2023 12:21:29 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_90AE = function_02D2();
	func_F71B(scripts\mp\_tweakables::func_81E7("team","fftype"));
	func_4555(getdvar("g_gametype"));
	for(;;)
	{
		func_12F18();
		wait(5);
	}
}

//Function Number: 2
func_12F18()
{
	var_00 = scripts\mp\_tweakables::func_81E7("team","fftype");
	if(level.var_740A != var_00)
	{
		func_F71B(var_00);
	}
}

//Function Number: 3
func_4555(param_00)
{
	var_01 = getentarray();
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(param_00 == "dm")
		{
			if(isdefined(var_03.var_EDC1) && var_03.var_EDC1 != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "tdm")
		{
			if(isdefined(var_03.var_EDC5) && var_03.var_EDC5 != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "ctf")
		{
			if(isdefined(var_03.var_EDC0) && var_03.var_EDC0 != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "hq")
		{
			if(isdefined(var_03.var_EDC2) && var_03.var_EDC2 != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "sd")
		{
			if(isdefined(var_03.var_EDC4) && var_03.var_EDC4 != "1")
			{
				var_03 delete();
			}

			continue;
		}

		if(param_00 == "koth")
		{
			if(isdefined(var_03.var_EDC3) && var_03.var_EDC3 != "1")
			{
				var_03 delete();
			}
		}
	}
}

//Function Number: 4
func_F71B(param_00)
{
	level.var_740A = param_00;
	setdvar("ui_friendlyfire",param_00);
	setdvar("cg_drawFriendlyHUDGrenades",param_00);
}