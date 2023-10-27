/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2583.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:23:24 AM
*******************************************************************/

//Function Number: 1
func_9308(param_00)
{
	if(!isdefined(self.var_10E6D))
	{
		return level.var_6AD5;
	}

	if(self.team == "allies")
	{
		return level.var_6AD5;
	}

	if(lib_0F18::func_10E8A("is_in_stealth"))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 2
func_12F2D(param_00)
{
	if(!isdefined(self.var_10E6D.var_C9A8))
	{
		lib_0F18::func_10E8A("set_patrol_style","unaware");
	}

	if(self.var_10E6D.var_10E19 == 3 && isdefined(self.var_10C))
	{
		lib_0F18::func_10E8A("set_patrol_style","combat",1,self.var_10C.origin);
		self.var_10E6D.var_10E19 = 4;
	}

	return level.var_111AE;
}