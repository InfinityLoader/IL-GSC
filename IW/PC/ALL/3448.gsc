/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3448.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:27:41 AM
*******************************************************************/

//Function Number: 1
func_80F1()
{
	foreach(var_01 in self.var_E4D7)
	{
		return var_01;
	}

	return undefined;
}

//Function Number: 2
func_E4D6()
{
	if(!isdefined(self.var_E4D7) || self.var_E4D7.size < 0)
	{
		return 0;
	}

	var_00 = func_80F1();
	if(!isdefined(var_00))
	{
		return 0;
	}

	var_01 = distancesquared(self.origin,var_00);
	if(var_01 < -25536)
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_89DC(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("powers_cleanUp");
	for(;;)
	{
		self waittill("damage");
		if(isdefined(self.var_10C))
		{
			if(!self method_81B8() && self.var_10C.health < self.health)
			{
				continue;
			}
		}

		if(!func_E4D6())
		{
			continue;
		}

		if(scripts\mp\bots\_bots_powers::func_8BEE())
		{
			if(self.health < 90)
			{
				scripts\mp\bots\_bots_powers::func_130C0(param_00,param_01);
				break;
			}
		}
	}
}