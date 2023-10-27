/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1400.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:26:01 AM
*******************************************************************/

//Function Number: 1
func_52A4()
{
	lib_0561::initconsumablesfromtable("vending_machine",::func_A244,::func_1F8B,::func_4716);
}

//Function Number: 2
func_1F8B(param_00)
{
	if(!lib_0561::func_1F7B())
	{
		return 0;
	}

	if(func_4BA4())
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_A244(param_00)
{
	self.var_4B7D = 1;
	self notify("perk_discount_applied");
}

//Function Number: 4
func_4716(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "";
	}

	switch(param_00)
	{
		case "epic":
			return 4;

		case "legendary":
			return 3;

		case "rare":
			return 2;

		case "common":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 5
func_4717(param_00)
{
	if(lib_056B::func_9D19(param_00.var_6F63))
	{
		return 0;
	}

	if(func_4BA4())
	{
		return 0.5;
	}

	return 1;
}

//Function Number: 6
func_4BA4()
{
	return isdefined(self.var_4B7D) && self.var_4B7D;
}

//Function Number: 7
func_A245()
{
	var_00 = self;
	if(var_00 func_4BA4())
	{
		var_00.var_4B7D = undefined;
	}

	var_00 notify("used_vending_machine_discount");
}