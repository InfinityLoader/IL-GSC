/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_h2o_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 40 ms
 * Timestamp: 4/22/2024 2:19:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	setdvar("r_gunSightColorEntityScale","7");
	setdvar("r_gunSightColorNoneScale","0.8");
}

//Function Number: 2
set_level_lighting_values()
{
	if(isusinghdr())
	{
		for(;;)
		{
			level waittill("connected",var_00);
			var_00 setclientdvars("r_tonemap","1");
		}
	}
}