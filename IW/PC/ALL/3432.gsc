/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3432.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:27:26 AM
*******************************************************************/

//Function Number: 1
func_20BB()
{
	func_6692();
}

//Function Number: 2
func_6692()
{
}

//Function Number: 3
func_E0D0()
{
	self notify("removeArchetype");
}

//Function Number: 4
func_2616()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	self setclientomnvar("ui_aura_quickswap",0);
	for(;;)
	{
		self waittill("got_a_kill");
		foreach(var_01 in level.players)
		{
			if(var_01.team != self.team)
			{
				continue;
			}

			if(distance2dsquared(var_01.origin,self.origin) > 147456)
			{
				continue;
			}

			var_01 thread func_2615(self);
		}
	}
}

//Function Number: 5
func_2615(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("giveLoadout_start");
	level endon("game_ended");
	if(self != param_00)
	{
		param_00 thread scripts\mp\_utility::func_83B4("buff_teammate");
	}

	self setclientomnvar("ui_aura_quickswap",1);
	scripts\mp\_utility::func_8387("specialty_fastreload");
	self playlocalsound("mp_overcharge_on");
	thread func_40E1();
	wait(5);
	self playlocalsound("mp_overcharge_off");
	self notify("removeAuraQuickswap");
	scripts\mp\_utility::func_E150("specialty_fastreload");
	self setclientomnvar("ui_aura_quickswap",0);
}

//Function Number: 6
func_40E1()
{
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	self setclientomnvar("ui_aura_quickswap",0);
}