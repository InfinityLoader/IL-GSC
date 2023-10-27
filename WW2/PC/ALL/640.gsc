/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 640.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:26:09 AM
*******************************************************************/

//Function Number: 1
func_1CE0(param_00)
{
	function_02F1(param_00);
}

//Function Number: 2
func_1CDF(param_00,param_01,param_02,param_03)
{
	function_02EF(param_00,param_01,param_02,param_03);
}

//Function Number: 3
func_1CDB(param_00)
{
	return function_02F3(param_00);
}

//Function Number: 4
func_1CDD(param_00,param_01,param_02,param_03,param_04)
{
	function_02F0(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 5
func_1CDE(param_00,param_01,param_02,param_03,param_04)
{
	function_02F0(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 6
func_1CDA()
{
	function_02F2();
}

//Function Number: 7
func_1CE1()
{
	self method_858F();
}

//Function Number: 8
func_1CDC(param_00,param_01,param_02,param_03,param_04,param_05)
{
	function_02F4(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 9
func_002D(param_00,param_01,param_02,param_03)
{
	var_04 = level.var_54F7;
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

	if(var_04 == level.var_39EB)
	{
		return 0;
	}

	if(var_04 == level.var_94D4)
	{
		return 1;
	}

	if(var_04 == level.var_7FB8)
	{
		return 2;
	}

	return 3;
}

//Function Number: 10
func_1CD8(param_00)
{
}

//Function Number: 11
func_1CD9(param_00)
{
}