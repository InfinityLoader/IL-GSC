/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 947.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:32:12 AM
*******************************************************************/

//Function Number: 1
func_2AD0()
{
	if(isdefined(level.var_119E["zombie_brute"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::lib_0C2C::func_98E6;
	var_00.var_1581[1] = ::lib_0C2C::func_531B;
	var_00.var_1581[2] = ::lib_0C2B::func_3E48;
	var_00.var_1581[3] = ::lib_0C2B::func_3E29;
	var_00.var_1581[4] = ::lib_0C2C::func_12EA6;
	var_00.var_1581[5] = ::lib_0C2C::func_12F69;
	var_00.var_1581[6] = ::lib_0C2C::func_38BE;
	var_00.var_1581[7] = ::lib_0C2C::func_D979;
	var_00.var_1581[8] = ::lib_0C2C::func_9609;
	var_00.var_1581[9] = ::lib_0C2C::func_116EA;
	var_00.var_1581[10] = ::lib_0C2C::func_38AF;
	var_00.var_1581[11] = ::lib_0C2C::func_D983;
	var_00.var_1581[12] = ::lib_0C2C::func_9704;
	var_00.var_1581[13] = ::lib_0C2C::func_116EE;
	var_00.var_1581[14] = ::lib_0C2C::func_390C;
	var_00.var_1581[15] = ::lib_0C2C::func_D97F;
	var_00.var_1581[16] = ::lib_0C2C::func_9652;
	var_00.var_1581[17] = ::lib_0C2C::func_116ED;
	var_00.var_1581[18] = ::lib_0C2C::func_FFED;
	var_00.var_1581[19] = ::lib_0C2C::func_D971;
	var_00.var_1581[20] = ::lib_0C2C::func_95C5;
	var_00.var_1581[21] = ::lib_0C2C::func_116E9;
	var_00.var_1581[22] = ::lib_0C2B::func_3D46;
	var_00.var_1581[23] = ::lib_0C2B::func_F108;
	var_00.var_1581[24] = ::lib_0C2B::func_C0B6;
	level.var_119E["zombie_brute"] = var_00;
}

//Function Number: 2
func_DEE8()
{
	func_2AD0();
	function_02D8("zombie_brute");
}