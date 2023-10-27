/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2972.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:26:01 AM
*******************************************************************/

//Function Number: 1
func_13BFD()
{
	var_00 = getentarray();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].classname) && getsubstr(var_00[var_01].classname,0,7) == "weapon_")
		{
			var_02 = var_00[var_01];
			var_03 = getsubstr(var_02.classname,7);
			if(isdefined(var_02.var_ECF2))
			{
				var_04 = weaponclipsize(var_03);
				var_05 = function_0249(var_03);
				var_02 method_81CC(var_04,var_05,var_04,0);
				var_06 = weaponaltweaponname(var_03);
				if(var_06 != "none")
				{
					var_07 = weaponclipsize(var_06);
					var_08 = function_0249(var_06);
					var_02 method_81CC(var_07,var_08,var_07,1);
				}

				continue;
			}

			var_09 = 0;
			var_04 = undefined;
			var_0A = undefined;
			var_0B = 0;
			var_0C = undefined;
			var_0D = undefined;
			if(isdefined(var_02.var_ECF0))
			{
				var_04 = var_02.var_ECF0;
				var_09 = 1;
			}

			if(isdefined(var_02.var_ECF1))
			{
				var_0A = var_02.var_ECF1;
				var_09 = 1;
			}

			if(isdefined(var_02.var_ECEE))
			{
				var_0C = var_02.var_ECEE;
				var_0B = 1;
			}

			if(isdefined(var_02.var_ECEF))
			{
				var_0D = var_02.var_ECEF;
				var_0B = 1;
			}

			if(var_09)
			{
				if(!isdefined(var_04))
				{
				}

				if(!isdefined(var_0A))
				{
				}

				var_02 method_81CC(var_04,var_0A);
			}

			if(var_0B)
			{
				if(!isdefined(var_0C))
				{
				}

				if(!isdefined(var_0D))
				{
				}

				var_02 method_81CC(var_0C,var_0D,0,1);
			}
		}
	}
}