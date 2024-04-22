/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_braggingrights.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 51 ms
 * Timestamp: 4/22/2024 2:15:25 AM
*******************************************************************/

//Function Number: 1
resolvebraggingrights()
{
	var_00 = getnumbraggingrights();
	var_01 = [];
	for(var_02 = 0;var_02 < var_00;var_02++)
	{
		var_01[var_02] = [];
	}

	foreach(var_04 in level.players)
	{
		if(isalive(var_04))
		{
			var_05 = var_04 getbraggingright();
			if(var_05 < var_00)
			{
				var_06 = var_01[var_05].size;
				var_01[var_05][var_06] = var_04;
			}
		}
	}

	foreach(var_02, var_05 in var_01)
	{
		if(var_05.size > 1)
		{
			var_09 = tablelookupbyrow("mp/braggingrights.csv",var_02,2);
			var_0A = undefined;
			var_0B = undefined;
			foreach(var_0D in var_05)
			{
				var_0E = var_0D maps\mp\_utility::getplayerstat(var_09);
				if(!isdefined(var_0A) || var_0E > var_0A)
				{
					var_0B = var_0D;
					var_0A = var_0E;
				}
			}

			foreach(var_0D in var_05)
			{
				if(var_0D == var_0B)
				{
					if(!isdefined(var_0D.matchbonus))
					{
						var_0D.matchbonus = 0;
					}

					var_11 = 0;
					foreach(var_04 in var_05)
					{
						if(isdefined(var_04.matchbonus))
						{
							var_11 = var_11 + var_04.matchbonus;
						}
					}

					var_0D.matchbonus = var_0D.matchbonus + var_11;
					continue;
				}

				var_0D.braggingrightsloser = 1;
			}
		}
	}

	foreach(var_04 in level.players)
	{
		if(isdefined(var_04.braggingrightsloser) && var_04.braggingrightsloser)
		{
			var_04.matchbonus = 0;
		}
	}
}

//Function Number: 2
getnumbraggingrights()
{
	var_00 = -1;
	var_01 = "temp";
	while(var_01 != "")
	{
		var_00++;
		var_01 = tablelookupbyrow("mp/braggingrights.csv",var_00,0);
	}

	return var_00;
}