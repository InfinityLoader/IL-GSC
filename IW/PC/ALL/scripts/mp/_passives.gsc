/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_passives.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 417 ms
 * Timestamp: 10/27/2023 12:21:09 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_C943 = [];
	func_C945();
}

//Function Number: 2
func_C945()
{
	if(!isdefined(level.var_C943))
	{
		level.var_C943 = [];
	}

	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/passivetable.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		var_02 = tablelookupbyrow("mp/passivetable.csv",var_00,1);
		var_03 = tablelookupbyrow("mp/passivetable.csv",var_00,12);
		var_04 = tablelookupbyrow("mp/passivetable.csv",var_00,13);
		var_05 = tablelookupbyrow("mp/passivetable.csv",var_00,14);
		var_06 = spawnstruct();
		var_06.name = var_02;
		var_06.var_13CDE = scripts\common\utility::func_116D7(tablelookupbyrow("mp/passivetable.csv",var_00,8) == "",0,1);
		var_06.var_A6BB = scripts\common\utility::func_116D7(tablelookupbyrow("mp/passivetable.csv",var_00,9) == "",0,1);
		var_06.var_ABCA = scripts\common\utility::func_116D7(tablelookupbyrow("mp/passivetable.csv",var_00,10) == "",0,1);
		var_06.var_113D1 = scripts\common\utility::func_116D7(tablelookupbyrow("mp/passivetable.csv",var_00,11) == "",0,1);
		if(var_03 != "")
		{
			var_06.var_249B = var_03;
		}

		if(getdvar("ui_gametype") == "zombie")
		{
			var_07 = tablelookupbyrow("mp/passivetable.csv",var_00,22);
			if(var_07 != "")
			{
				var_06.var_249B = var_07;
			}
		}

		if(var_04 != "")
		{
			var_06.var_CA59 = var_04;
		}

		if(var_05 != "")
		{
			var_06.var_B689 = var_05;
		}

		if(!isdefined(level.var_C943[var_02]))
		{
			level.var_C943[var_02] = var_06;
		}

		var_00++;
	}
}

//Function Number: 3
func_804D(param_00)
{
	if(!isdefined(level.var_C943[param_00]))
	{
		return undefined;
	}

	var_01 = level.var_C943[param_00];
	return var_01;
}

//Function Number: 4
func_8048(param_00)
{
	var_01 = func_804D(param_00);
	if(!isdefined(var_01) || !isdefined(var_01.var_249B))
	{
		return undefined;
	}

	return var_01.var_249B;
}

//Function Number: 5
func_804A(param_00)
{
	var_01 = func_804D(param_00);
	if(!isdefined(var_01) || !isdefined(var_01.var_CA59))
	{
		return undefined;
	}

	return var_01.var_CA59;
}

//Function Number: 6
func_8049(param_00)
{
	var_01 = func_804D(param_00);
	if(!isdefined(var_01) || !isdefined(var_01.var_B689))
	{
		return undefined;
	}

	return var_01.var_B689;
}

//Function Number: 7
func_8239()
{
	var_00 = [];
	foreach(var_02 in level.var_C943)
	{
		if(var_02.var_13CDE)
		{
			var_00[var_00.size] = var_02.name;
		}
	}

	return var_00;
}

//Function Number: 8
func_7F52()
{
	var_00 = [];
	foreach(var_02 in level.var_C943)
	{
		if(var_02.var_A6BB)
		{
			var_00[var_00.size] = var_02.name;
		}
	}

	return var_00;
}

//Function Number: 9
func_7F67()
{
	var_00 = [];
	foreach(var_02 in level.var_C943)
	{
		if(var_02.var_ABCA)
		{
			var_00[var_00.size] = var_02.name;
		}
	}

	return var_00;
}

//Function Number: 10
func_8190()
{
	var_00 = [];
	foreach(var_02 in level.var_C943)
	{
		if(var_02.var_113D1)
		{
			var_00[var_00.size] = var_02.name;
		}
	}

	return var_00;
}