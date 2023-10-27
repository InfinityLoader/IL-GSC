/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3447.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:27:41 AM
*******************************************************************/

//Function Number: 1
func_8995(param_00,param_01)
{
	thread scripts\mp\bots\_bots_powers::func_130C1(param_00,param_01,450,::func_1307D);
	thread scripts\mp\bots\_bots_powers::func_130C2(param_00,param_01,450,80,::func_1307D);
}

//Function Number: 2
func_C166(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon(param_01);
	param_00 waittill("death");
	self notify(param_01);
}

//Function Number: 3
func_10E69()
{
	thread func_C166(self.var_5906,"StayInShieldElapsed");
	thread func_B9D2(250,"StayInShieldElapsed");
	var_00 = getclosestpointonnavmesh(self.var_5906.origin,self);
	self.var_5906 = undefined;
	self botsetscriptgoal(var_00,16,"critical");
	thread cleanupdomeshield();
}

//Function Number: 4
func_B9D2(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon(param_01);
	var_02 = param_00 * param_00;
	for(;;)
	{
		if(isdefined(self.var_10C))
		{
			var_03 = distancesquared(self.origin,self.var_10C.origin);
			if(var_03 < var_02)
			{
				self notify(param_01);
				break;
			}
		}

		wait(0.25);
	}
}

//Function Number: 5
func_1307D(param_00,param_01)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self notify("domeshield_used");
	scripts\mp\bots\_bots_powers::func_130C0(param_00,param_01);
	while(!isdefined(self.var_5906))
	{
		wait(0.05);
	}

	func_10E69();
}

//Function Number: 6
cleanupdomeshield()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self waittill("StayInShieldElapsed");
	self botclearscriptgoal();
}