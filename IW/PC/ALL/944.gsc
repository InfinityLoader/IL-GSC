/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 944.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:32:11 AM
*******************************************************************/

//Function Number: 1
func_F170(param_00)
{
	return lib_0A0E::func_B599(param_00,self.var_3135.var_F15D);
}

//Function Number: 2
func_2AD0()
{
	if(isdefined(level.var_119E["seeker"]))
	{
		return;
	}

	var_00 = spawnstruct();
	var_00.var_1581 = [];
	var_00.var_1581[0] = ::lib_0C25::func_98CA;
	var_00.var_1581[1] = ::lib_0A09::func_9307;
	var_00.var_1581[2] = ::lib_0C25::func_1572;
	var_00.var_1581[3] = ::lib_0C25::func_13850;
	var_00.var_1581[4] = ::lib_0C25::func_F177;
	var_00.var_1581[5] = ::func_F170;
	var_00.var_1581[6] = ::lib_0A0E::func_5903;
	var_00.var_1581[7] = ::lib_0A0E::func_9896;
	var_00.var_1581[8] = ::lib_0A0E::func_41C6;
	var_00.var_1581[9] = ::lib_0C25::func_2BD3;
	level.var_119E["seeker"] = var_00;
}

//Function Number: 3
func_DEE8()
{
	func_2AD0();
	function_02D8("seeker");
}