/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3121.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:26:10 AM
*******************************************************************/

//Function Number: 1
func_D4FF(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self.var_2303.var_2F3A = 1;
	self method_806F(lib_0A1E::func_2342(),param_02);
	self method_82A2(var_04,1,param_02,1);
}

//Function Number: 2
func_697A(param_00,param_01,param_02)
{
	self.var_2303.var_2F3A = undefined;
}