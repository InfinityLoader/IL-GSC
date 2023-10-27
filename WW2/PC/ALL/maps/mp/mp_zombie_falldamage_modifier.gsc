/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_falldamage_modifier.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 3:18:52 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	thread func_7D14();
}

//Function Number: 2
func_7D14()
{
	for(;;)
	{
		if(isdefined(level.var_744A))
		{
			foreach(var_01 in level.var_744A)
			{
				if(!var_01 maps\mp\_utility::func_649("specialty_falldamage"))
				{
					var_01 maps\mp\_utility::func_47A2("specialty_falldamage");
					var_01.var_3A0F = float(0);
				}
			}
		}

		wait(1);
	}
}