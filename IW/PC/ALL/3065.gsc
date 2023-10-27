/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3065.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:26:05 AM
*******************************************************************/

//Function Number: 1
func_33FF(param_00)
{
	self.var_87F6 = 1;
	lib_0BFE::func_97F9();
	lib_0A10::func_3376();
	self.var_3135.var_71CC = ::lib_0BFE::func_F1F1;
	return level.var_111AE;
}

//Function Number: 2
func_336F(param_00)
{
	lib_0A1B::func_296A("crouch");
}

//Function Number: 3
func_336E(param_00)
{
	if(!isdefined(self.var_15F))
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 4
func_3370(param_00)
{
	lib_0A1B::func_296A("stand");
}

//Function Number: 5
func_846E(param_00)
{
	if(!isdefined(self.var_15F))
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_233))
	{
		return level.var_111AE;
	}

	if(lib_0A1A::func_232A("grenade response","return throw"))
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 6
func_846F(param_00)
{
}

//Function Number: 7
func_85C1(param_00)
{
	lib_0A1B::func_2964(1);
}

//Function Number: 8
func_85C3(param_00)
{
	if(lib_0A1A::func_232A("grenade response","return throw complete"))
	{
		return level.var_111AE;
	}

	if(!isdefined(self.var_15F))
	{
		return level.var_111AE;
	}

	return level.var_E87A;
}

//Function Number: 9
func_85C2(param_00)
{
	lib_0A1B::func_2964(undefined);
}

//Function Number: 10
func_335B(param_00)
{
	if(lib_0A0B::func_7C35("torso") == "dismember")
	{
		return level.var_6AD5;
	}

	return lib_0A18::func_3928(param_00);
}