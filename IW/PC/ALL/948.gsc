/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 948.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:32:12 AM
*******************************************************************/

//Function Number: 1
func_2AD0()
{
	if(isdefined(level.var_119E["zombie_ghost"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::lib_0C2D::func_98E7;
	var_00.var_1581[1] = ::lib_0C2B::func_3E48;
	var_00.var_1581[2] = ::lib_0C2D::func_8281;
	var_00.var_1581[3] = ::lib_0C2D::func_827A;
	var_00.var_1581[4] = ::lib_0C2D::func_827F;
	var_00.var_1581[5] = ::lib_0C2D::func_3DF0;
	var_00.var_1581[6] = ::lib_0C2D::func_3D46;
	var_00.var_1581[7] = ::lib_0C2D::func_F108;
	var_00.var_1581[8] = ::lib_0C2D::func_827E;
	var_00.var_1581[9] = ::lib_0C2D::func_C0B6;
	level.var_119E["zombie_ghost"] = var_00;
}

//Function Number: 2
func_DEE8()
{
	func_2AD0();
	function_02D8("zombie_ghost");
}