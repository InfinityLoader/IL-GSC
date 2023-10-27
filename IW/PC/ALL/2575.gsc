/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2575.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:23:22 AM
*******************************************************************/

//Function Number: 1
func_9898(param_00)
{
	self.var_1548 = 0.95;
	self.var_B627 = 36;
	self.var_71AF = ::func_9E99;
	self.var_71C0 = ::func_B5E9;
	self.var_71C1 = ::func_B5EF;
	self.var_71C2 = ::func_B654;
	self.var_71C3 = ::func_B656;
	self.var_7199 = ::func_38CF;
	return level.var_111AE;
}

//Function Number: 2
func_38CF(param_00,param_01)
{
	var_02 = navtrace(param_00,param_01,self,1);
	var_03 = var_02["fraction"];
	if(var_03 >= self.var_1548)
	{
		var_04 = 0;
	}
	else
	{
		var_04 = 1;
	}

	return !var_04;
}

//Function Number: 3
func_9E99(param_00,param_01)
{
	if(lib_0A1B::func_2942())
	{
		return 0;
	}

	if(!lib_0A0E::func_9E9A(param_00,param_01))
	{
		return 0;
	}

	var_02 = lib_0A0E::func_8198(param_00);
	if(!isdefined(var_02))
	{
		return 0;
	}

	if(!func_38CF(self.origin,var_02))
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
func_B5E9(param_00)
{
	self method_828B(1);
}

//Function Number: 5
func_B5EF(param_00)
{
	self method_828B(0);
	self method_8484();
}

//Function Number: 6
func_B654(param_00)
{
	self method_828B(1);
}

//Function Number: 7
func_B656(param_00)
{
	self method_828B(0);
	self method_8484();
}