/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: behaviortree\zombie_dlc1.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 141 ms
 * Timestamp: 10/26/2023 11:58:24 PM
*******************************************************************/

//Function Number: 1
zombie_dlc1fn0(param_00)
{
	return lib_0A09::func_5AEA(param_00,200);
}

//Function Number: 2
func_2AD0()
{
	if(isdefined(level.var_119E["zombie_dlc1"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::lib_0C2B::func_98E5;
	var_00.var_1581[1] = ::scripts\aitypes\zombie_dlc1\behaviors::checkscripteddlc1;
	var_00.var_1581[2] = ::lib_0C2B::func_10004;
	var_00.var_1581[3] = ::lib_0C2B::func_6627;
	var_00.var_1581[4] = ::lib_0C2B::func_6628;
	var_00.var_1581[5] = ::lib_0C2B::func_6629;
	var_00.var_1581[6] = ::zombie_dlc1fn0;
	var_00.var_1581[7] = ::lib_0A09::func_FAF6;
	var_00.var_1581[8] = ::lib_0C2B::func_102D4;
	var_00.var_1581[9] = ::lib_0C2B::func_3E4F;
	var_00.var_1581[10] = ::lib_0C2B::func_3E29;
	var_00.var_1581[11] = ::scripts\aitypes\zombie_dlc1\behaviors::chaseenemydlc1;
	var_00.var_1581[12] = ::scripts\aitypes\zombie_dlc1\behaviors::seekenemydlc1;
	var_00.var_1581[13] = ::lib_0C2B::func_C0B6;
	level.var_119E["zombie_dlc1"] = var_00;
}

//Function Number: 3
func_DEE8()
{
	func_2AD0();
	function_02D8("zombie_dlc1");
}