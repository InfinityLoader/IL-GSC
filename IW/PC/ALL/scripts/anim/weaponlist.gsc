/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\weaponlist.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 508 ms
 * Timestamp: 10/27/2023 12:01:15 AM
*******************************************************************/

//Function Number: 1
func_1310F()
{
	return function_0245(self.var_394) || function_02BE(self.var_394) || function_023C(self.var_394) > 0;
}

//Function Number: 2
func_1311D()
{
	return function_0248(self.var_394);
}

//Function Number: 3
func_2691()
{
	if(func_1310F())
	{
		return 0.1 / function_0240(self.var_394);
	}

	return 0.5;
}

//Function Number: 4
func_32C3()
{
	if(func_1310F())
	{
		return 0.1 / function_0240(self.var_394);
	}

	return 0.2;
}

//Function Number: 5
func_13697()
{
	return 0.25;
}

//Function Number: 6
func_FE94(param_00)
{
	if(!func_1310F() || isdefined(param_00) && param_00 == 1)
	{
		var_01 = 0.5 + randomfloat(1);
		return function_0240(self.var_394) * var_01;
	}

	return function_0240(self.var_394);
}

//Function Number: 7
func_DE4D()
{
	if(self.var_394 == "none")
	{
		self.var_3250 = 0;
		return 0;
	}

	if(!isdefined(self.var_3250))
	{
		self.var_3250 = weaponclipsize(self.var_394);
	}
	else
	{
		self.var_3250 = weaponclipsize(self.var_394);
	}

	if(self.var_3250 <= 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 8
func_1790(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_02))
	{
		param_02 = 3;
	}

	if(!isdefined(param_03))
	{
		param_02 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = "rifle";
	}

	param_00 = tolower(param_00);
	level.var_1B11[param_00]["type"] = param_01;
	level.var_1B11[param_00]["time"] = param_02;
	level.var_1B11[param_00]["clipsize"] = param_03;
	level.var_1B11[param_00]["anims"] = param_04;
}

//Function Number: 9
func_1866(param_00)
{
	level.var_1B11[tolower(param_00)]["type"] = "turret";
}