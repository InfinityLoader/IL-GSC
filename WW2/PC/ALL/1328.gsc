/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1328.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:25:23 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.doronvestmovespeedscale = 0.8;
	level.var_32A2 = 0.95;
	level.var_32A6 = 500;
	level.var_32A4 = 1;
	self.var_4B64 = 0;
}

//Function Number: 2
func_3662()
{
	self.var_32A5 = level.var_32A6;
	if(maps\mp\_utility::func_649("specialty_stun_resistance"))
	{
		self.var_32A1 = 1;
	}
	else
	{
		maps\mp\_utility::func_47A2("specialty_stun_resistance");
	}

	self.var_4B64 = 1;
	thread func_63D8();
	maps\mp\gametypes\_weapons::func_A13B();
}

//Function Number: 3
func_2F9E()
{
	if(!isdefined(self.var_32A1) || !self.var_32A1)
	{
		maps\mp\_utility::func_735("specialty_stun_resistance");
	}

	self.var_4B64 = 0;
	maps\mp\gametypes\_weapons::func_A13B();
}

//Function Number: 4
func_63D8()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	self waittill("DoronVestDestroyed");
	self notify("DisabledRoleAbility");
	func_2F9E();
}

//Function Number: 5
func_0F31(param_00)
{
	if(self.var_4B64)
	{
		self.var_32A5 = self.var_32A5 - param_00;
		var_01 = param_00 / level.var_32A6;
		self roleapplypowerchange(-1 * var_01 * level.var_32A4);
		if(self.var_32A5 <= 0)
		{
			self notify("DoronVestDestroyed");
		}
	}
}