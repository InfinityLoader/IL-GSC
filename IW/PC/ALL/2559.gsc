/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2559.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:23:20 AM
*******************************************************************/

//Function Number: 1
func_006E(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_9B08;
	var_05 = undefined;
	var_06 = level.var_119E[param_00];
	var_07 = var_06.var_1581[param_01];
	var_04 = [[ var_07 ]](param_02);
	if(!isdefined(var_04))
	{
		var_04 = 3;
	}

	return var_04;
}

//Function Number: 2
func_0085(param_00)
{
	function_02BA(param_00);
}

//Function Number: 3
func_0084(param_00,param_01,param_02,param_03)
{
	function_02B8(param_00,param_01,param_02,param_03);
}

//Function Number: 4
func_0080(param_00)
{
	return function_02BC(param_00);
}

//Function Number: 5
func_0082(param_00,param_01,param_02,param_03,param_04)
{
	function_02B9(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 6
func_0083(param_00,param_01,param_02,param_03,param_04)
{
	function_02B9(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 7
func_007F()
{
	function_02BB();
}

//Function Number: 8
func_0086()
{
	self method_84B3();
}

//Function Number: 9
func_0081(param_00,param_01,param_02,param_03,param_04,param_05)
{
	function_02BD(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 10
func_007E(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_9B08;
	var_05 = gettime();
	if(isdefined(param_03))
	{
		var_06 = [[ param_03 ]]();
		var_04 = [[ param_01 ]](param_02,var_06);
	}
	else
	{
		var_04 = [[ param_01 ]](param_02);
	}

	if(!isdefined(var_04))
	{
		return 3;
	}

	if(var_04 == level.var_6AD5)
	{
		return 0;
	}

	if(var_04 == level.var_111AE)
	{
		return 1;
	}

	if(var_04 == level.var_E87A)
	{
		return 2;
	}

	return 3;
}

//Function Number: 11
func_007C(param_00)
{
}

//Function Number: 12
func_007D(param_00)
{
}