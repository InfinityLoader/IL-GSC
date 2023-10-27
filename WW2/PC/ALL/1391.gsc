/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1391.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 3:25:59 AM
*******************************************************************/

//Function Number: 1
func_52A4()
{
	lib_0561::initconsumablesfromtable("double_points",::func_A208,::func_1F7D,::func_44A8);
}

//Function Number: 2
func_1F7D(param_00)
{
	if(!lib_0561::func_1F7B())
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_A208(param_00)
{
	maps/mp/gametypes/zombies::func_32C8(self,1);
}

//Function Number: 4
func_44A8(param_00)
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