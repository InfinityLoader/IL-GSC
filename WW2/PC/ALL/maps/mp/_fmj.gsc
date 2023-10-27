/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_fmj.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 15 ms
 * Timestamp: 10/27/2023 3:21:25 AM
*******************************************************************/

//Function Number: 1
func_3D93()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	self.var_4B2D = 0;
	for(;;)
	{
		if(!self.var_4B2D)
		{
			if(maps\mp\_utility::func_649("specialty_bulletpenetration"))
			{
				maps\mp\_utility::func_735("specialty_bulletpenetration");
				if(!maps\mp\_utility::func_649("specialty_superbulletpenetration"))
				{
					maps\mp\_utility::func_735("specialty_armorpiercing");
				}
			}

			wait 0.05;
			continue;
		}

		if(!maps\mp\_utility::func_649("specialty_bulletpenetration"))
		{
			maps\mp\_utility::func_47A2("specialty_bulletpenetration");
			maps\mp\_utility::func_47A2("specialty_armorpiercing");
		}

		wait 0.05;
	}
}