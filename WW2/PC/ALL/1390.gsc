/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1390.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:25:59 AM
*******************************************************************/

//Function Number: 1
func_52A4()
{
	lib_0561::func_52A5("attack_dogs","Attack Dogs",::func_A1FA,::func_1F2D,::func_4423);
	level thread maps\mp\killstreaks\_dog_killstreak::func_D5();
}

//Function Number: 2
func_1F2D()
{
	return 1;
}

//Function Number: 3
func_A1FA()
{
	self method_8615("zmb_pickup_general");
	thread maps\mp\killstreaks\_dog_killstreak::func_9E26();
}

//Function Number: 4
func_4423(param_00)
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