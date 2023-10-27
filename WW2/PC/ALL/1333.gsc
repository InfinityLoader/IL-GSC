/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1333.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:25:24 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.steelbibmovespeedscale = 0.75;
	level.var_9394 = 75;
	level.var_9392 = 1;
	self.var_4B9A = 0;
}

//Function Number: 2
func_3662()
{
	self.var_9393 = level.var_9394;
	self.var_4B9A = 1;
	thread func_63D8();
	maps\mp\gametypes\_weapons::func_A13B();
}

//Function Number: 3
func_2F9E()
{
	self.var_4B9A = 0;
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
	self waittill("SteelBibDestroyed");
	self notify("DisabledRoleAbility");
	func_2F9E();
}

//Function Number: 5
func_0F31(param_00)
{
	if(self.var_4B9A)
	{
		self.var_9393 = self.var_9393 - param_00;
		var_01 = param_00 / level.var_9394;
		self roleapplypowerchange(-1 * var_01 * level.var_9392);
		if(self.var_9393 <= 0)
		{
			self notify("SteelBibDestroyed");
		}
	}
}