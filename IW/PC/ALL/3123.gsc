/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3123.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:26:11 AM
*******************************************************************/

//Function Number: 1
func_295A()
{
	self.var_1198.var_440A = 0;
	self.var_1198.var_3323 = 0;
}

//Function Number: 2
func_295C()
{
	self.var_1198.var_440A = 1;
	self.var_1198.var_3323 = 1;
}

//Function Number: 3
func_295B()
{
	self.var_1198.var_440A = 2;
	self.var_1198.var_3323 = 0;
}

//Function Number: 4
func_298C()
{
	if(!isdefined(self.var_1198.var_440A) || self.var_1198.var_440A == 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_298D()
{
	if(isdefined(self.var_1198.var_440A) && self.var_1198.var_440A == 2)
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
func_2979(param_00)
{
	self.var_1198.var_2AA1 = param_00;
	if(param_00)
	{
		self.var_595D = 1;
	}
}

//Function Number: 7
func_2921()
{
	if(!isdefined(self.var_1198.var_2AA1))
	{
		return 0;
	}

	return self.var_1198.var_2AA1;
}