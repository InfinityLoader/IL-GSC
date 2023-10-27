/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3149.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:26:17 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("gesture"))
	{
		return;
	}

	lib_0A1A::func_230B("gesture","gesture_start");
	lib_0A1A::func_2374("gesture",::lib_0C4C::func_D48B,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EDA,undefined,["gesture"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("gesture_start",undefined,::func_121A5,undefined);
	lib_0A1A::func_2374("gesture_start",::lib_0C4C::func_980D,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("gesture",undefined,::func_121A1,undefined);
	lib_0A1A::func_2375("gesture_point",undefined,::func_121A3,undefined);
	lib_0A1A::func_2374("gesture_point",::lib_0C4C::func_D48B,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EDA,undefined,["gesture"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("gesture_start",undefined,::func_1219F,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
func_121A5(param_00,param_01,param_02,param_03)
{
	return !lib_0C4C::func_195F();
}

//Function Number: 3
func_121A1(param_00,param_01,param_02,param_03)
{
	return lib_0C4C::func_195F();
}

//Function Number: 4
func_121A3(param_00,param_01,param_02,param_03)
{
	return lib_0C4C::func_19D2();
}

//Function Number: 5
func_1219F(param_00,param_01,param_02,param_03)
{
	return !lib_0C4C::func_19D2();
}