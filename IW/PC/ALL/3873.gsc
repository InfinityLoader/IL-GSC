/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3873.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:31:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	lib_0F23::main();
}

//Function Number: 2
func_F5B6(param_00,param_01,param_02)
{
	if(param_00)
	{
		if(isdefined(param_01) && isdefined(param_02))
		{
			level thread lib_0F27::func_10ED8(param_01,param_02);
		}

		level thread lib_0F26::func_117D3(1);
		foreach(var_04 in level.players)
		{
			var_04 thread lib_0F24::main();
			var_04 thread lib_0F25::func_11408();
			var_04 thread lib_0F24::func_1DD3();
		}

		return;
	}

	level thread lib_0F27::func_10EDA();
	level thread lib_0F26::func_117D3(0);
	foreach(var_04 in level.players)
	{
		var_04 thread lib_0F25::func_11407();
		var_04 thread lib_0F24::func_1DD2();
	}
}