/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1399.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:26:01 AM
*******************************************************************/

//Function Number: 1
func_52A4()
{
	lib_0561::initconsumablesfromtable("skel_key",::func_A237,::func_1F6F,::func_4685);
}

//Function Number: 2
func_1F6F(param_00)
{
	if(!lib_0561::func_1F7B())
	{
		return 0;
	}

	if(func_4B95())
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_A237(param_00)
{
	self method_8615("zmb_pickup_general");
	var_01 = self.var_259F[param_00].var_1B9;
	self.var_8C71 = spawnstruct();
	self.var_8C71.var_1B9 = var_01;
	self.var_8C71.var_267C = 1 - func_4686(var_01);
	if(common_scripts\utility::func_562E(level.reworkedconsumabledenabled))
	{
		self.var_8C71.flatdiscount = 1000;
	}

	lib_0561::notifywallbuytriggers();
}

//Function Number: 4
func_4685(param_00)
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
func_4686(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "";
	}

	switch(param_00)
	{
		case "common":
		case "rare":
		case "legendary":
		case "epic":
			return 0.5;

		default:
			return 0;
	}
}

//Function Number: 6
func_4687()
{
	if(func_4B95())
	{
		return self.var_8C71.var_267C;
	}

	return 1;
}

//Function Number: 7
func_4B95()
{
	if(isdefined(self.var_8C71))
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
func_A236()
{
	if(!func_4B95())
	{
		return;
	}

	self.var_8C71 = undefined;
	lib_0561::notifywallbuytriggers();
}