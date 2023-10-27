/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1394.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:26:00 AM
*******************************************************************/

//Function Number: 1
func_52A4()
{
	lib_0561::initconsumablesfromtable("max_ammo",::func_A21A,::func_1F82,::func_4575);
}

//Function Number: 2
func_1F82(param_00)
{
	if(!lib_0561::func_1F7B())
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_A21A(param_00)
{
	maps/mp/gametypes/zombies::func_DB9(self,1);
}

//Function Number: 4
func_4575(param_00)
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