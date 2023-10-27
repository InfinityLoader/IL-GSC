/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1392.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:25:59 AM
*******************************************************************/

//Function Number: 1
func_52A4()
{
	lib_0561::initconsumablesfromtable("full_meter",::func_A20D,::func_1F7E,::func_44F3);
}

//Function Number: 2
func_1F7E(param_00)
{
	if(!lib_0561::func_1F7B())
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_A20D(param_00)
{
	maps/mp/gametypes/zombies::func_840(self,1);
}

//Function Number: 4
func_44F3(param_00)
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