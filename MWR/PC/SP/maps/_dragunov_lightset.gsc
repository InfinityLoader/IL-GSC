/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_dragunov_lightset.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 61 ms
 * Timestamp: 10/27/2023 2:45:46 AM
*******************************************************************/

//Function Number: 1
dragunov_scope_init()
{
	var_00 = [];
	var_00["bog_b"] = "bog_b_dragunov";
	var_00["armada"] = "armada_dragunov";
	if(isdefined(var_00[level.script]))
	{
		thread dragunov_scope_monitor(var_00[level.script]);
	}
}

//Function Number: 2
dragunov_scope_monitor(param_00)
{
	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		var_03 = level.player getcurrentweapon();
		var_04 = level.player playerads();
		var_05 = var_04 == 1 || var_04 > var_01;
		var_06 = isdefined(var_03) && var_03 == "dragunov" && var_05;
		if(var_06 && !var_02)
		{
			level.player lightsetoverrideenableforplayer(param_00,0);
		}
		else if(!var_06 && var_02)
		{
			level.player lightsetoverridedisableforplayer(0);
		}

		var_02 = var_06;
		var_01 = var_04;
		wait(0.05);
	}
}