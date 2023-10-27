/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1401.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:26:02 AM
*******************************************************************/

//Function Number: 1
func_52A4()
{
	lib_0561::initconsumablesfromtable("weap_guarantee",::func_A247,::func_1F8C,::func_4721);
}

//Function Number: 2
func_1F8C(param_00)
{
	if(!lib_0561::func_1F7B())
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_A247(param_00)
{
	self method_8615("zmb_pickup_general");
	var_01 = self.var_259F[param_00].var_109;
	var_02 = func_398B(var_01);
	self.var_A99B = var_02;
	foreach(var_04 in self getweaponslistprimaries())
	{
		if(lib_0547::func_5565(lib_0547::func_AAF9(var_04),var_02))
		{
			maps\mp\zombies\_zombies_magicbox::func_3AC1(self,var_04);
			self givemaxammo(var_04);
		}
	}

	lib_0561::notifywallbuytriggers();
}

//Function Number: 4
func_4721(param_00)
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
func_398B(param_00)
{
	var_01 = function_0337(param_00,"consumable_zm_guarantee_");
	return var_01;
}

//Function Number: 6
func_4BA5()
{
	if(isdefined(self.var_A99B))
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
func_A246()
{
	var_00 = self.var_A99B;
	self.var_A99B = undefined;
	lib_0561::notifywallbuytriggers();
	return var_00;
}