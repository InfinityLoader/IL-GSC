/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_zombie_brg_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 83 ms
 * Timestamp: 4/22/2024 2:19:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	set_level_lighting_values();
	thread lightintensityflicker("sewers_pit_flicker_aa",1,55000,0.01,0.1);
	thread lightintensityflicker("gasStation_fire_flicker_aa",1,155000,0.01,0.1);
}

//Function Number: 2
set_level_lighting_values()
{
	if(isusinghdr())
	{
	}
}

//Function Number: 3
lightintensityflicker(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getent(param_00,"targetname");
	if(!isdefined(var_05))
	{
		return;
	}

	for(;;)
	{
		var_06 = randomfloatrange(param_01,param_02);
		var_05 setlightintensity(var_06);
		wait(randomfloatrange(param_03,param_04));
	}
}