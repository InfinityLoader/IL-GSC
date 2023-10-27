/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\gametype_conf.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 266 ms
 * Timestamp: 10/27/2023 12:11:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_F8F4();
}

//Function Number: 2
func_F8F4()
{
	level.agent_funcs["squadmate"]["gametype_update"] = ::func_18FB;
	level.agent_funcs["player"]["think"] = ::func_18F5;
}

//Function Number: 3
func_18F5()
{
	thread scripts\mp\bots\gametype_conf::func_2D39();
}

//Function Number: 4
func_18FB()
{
	if(!isdefined(self.var_11420))
	{
		self.var_11420 = [];
	}

	if(!isdefined(self.var_BF68))
	{
		self.var_BF68 = gettime() + 500;
	}

	if(gettime() > self.var_BF68)
	{
		self.var_BF68 = gettime() + 500;
		var_00 = 0.78;
		var_01 = self.var_222 getnearestnode();
		if(isdefined(var_01))
		{
			var_02 = self.var_222 scripts\mp\bots\gametype_conf::func_2D7C(1,var_01,var_00);
			self.var_11420 = scripts\mp\bots\gametype_conf::func_2D38(var_02,self.var_11420);
		}
	}

	self.var_11420 = scripts\mp\bots\gametype_conf::func_2E65(self.var_11420);
	var_03 = scripts\mp\bots\gametype_conf::func_2D74(self.var_11420,0);
	if(isdefined(var_03))
	{
		if(!isdefined(self.var_113DD) || distancesquared(var_03.var_4B2C,self.var_113DD.var_4B2C) > 1)
		{
			self.var_113DD = var_03;
			scripts\mp\bots\_bots_strategy::func_2D4E();
			self botsetscriptgoal(self.var_113DD.var_4B2C,0,"objective",undefined,level.var_2EA7);
		}

		return 1;
	}
	else if(isdefined(self.var_113DD))
	{
		self botclearscriptgoal();
		self.var_113DD = undefined;
	}

	return 0;
}