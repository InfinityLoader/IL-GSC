/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3124.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:26:12 AM
*******************************************************************/

//Function Number: 1
func_11090()
{
}

//Function Number: 2
func_4E36()
{
	self notify("terminate_ai_threads");
	self notify("killanimscript");
}

//Function Number: 3
func_CF0E(param_00,param_01,param_02,param_03)
{
	self method_828A("gravity");
	self method_8281("anim deltas");
	lib_0F3C::func_CEA8(param_00,param_01,param_02);
}

//Function Number: 4
func_3EE2(param_00,param_01,param_02)
{
	return 0;
}

//Function Number: 5
func_3ECA(param_00,param_01,param_02)
{
	return 0;
}

//Function Number: 6
func_3EC6(param_00,param_01,param_02)
{
	return 0;
}

//Function Number: 7
func_3F00(param_00,param_01,param_02)
{
	return 0;
}

//Function Number: 8
func_3F02(param_00,param_01,param_02)
{
	return 0;
}

//Function Number: 9
func_3F01(param_00,param_01,param_02)
{
	return 0;
}

//Function Number: 10
func_6DB2()
{
	return 1;
}

//Function Number: 11
func_CF14()
{
}

//Function Number: 12
func_CCAA(param_00,param_01)
{
}

//Function Number: 13
func_C703()
{
}

//Function Number: 14
func_CF16()
{
}

//Function Number: 15
func_E166(param_00)
{
}

//Function Number: 16
func_41DC(param_00)
{
}

//Function Number: 17
func_FFFA(param_00,param_01,param_02,param_03)
{
	return 0;
}

//Function Number: 18
func_9DBE(param_00)
{
	if(param_00 == "deserteagle")
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
func_9D59(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(distance(self.origin,param_00.origin) > param_01)
	{
		return 0;
	}

	return 1;
}