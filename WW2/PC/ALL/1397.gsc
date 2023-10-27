/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1397.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:26:01 AM
*******************************************************************/

//Function Number: 1
func_52A4()
{
	lib_0561::initconsumablesfromtable("ref_coupon",::func_A230,::func_1F86,::func_4661);
}

//Function Number: 2
func_1F86(param_00)
{
	if(!lib_0561::func_1F7B())
	{
		return 0;
	}

	if(func_4B8A())
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_A230(param_00)
{
	self.var_4B8A = 1;
}

//Function Number: 4
func_4661(param_00)
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
func_4B8A()
{
	return isdefined(self.var_4B8A) && self.var_4B8A;
}

//Function Number: 6
func_A22F(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	if(!func_4B8A())
	{
		return;
	}

	wait(0.25);
	var_01 = int(0.25 * param_00);
	self.var_4B8A = 0;
	maps/mp/gametypes/zombies::func_4798(var_01,1);
}