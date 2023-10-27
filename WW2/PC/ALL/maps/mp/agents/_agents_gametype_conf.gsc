/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agents_gametype_conf.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 85 ms
 * Timestamp: 10/27/2023 3:08:51 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_87A7();
}

//Function Number: 2
func_87A7()
{
	level.var_A41["squadmate"]["gametype_update"] = ::func_0A48;
	level.var_A41["player"]["think"] = ::func_0A44;
}

//Function Number: 3
func_0A44()
{
	thread maps/mp/bots/_bots_gametype_conf::func_197D();
}

//Function Number: 4
func_0A48()
{
	if(!isdefined(self.var_95BC))
	{
		self.var_95BC = [];
	}

	if(!isdefined(self.var_66B7))
	{
		self.var_66B7 = gettime() + 500;
	}

	if(gettime() > self.var_66B7)
	{
		self.var_66B7 = gettime() + 500;
		var_00 = 0.78;
		var_01 = self.var_117 getnearestnode();
		if(isdefined(var_01))
		{
			var_02 = self.var_117 maps/mp/bots/_bots_gametype_conf::func_19D1(1,var_01,var_00);
			self.var_95BC = maps/mp/bots/_bots_gametype_conf::func_197C(var_02,self.var_95BC);
		}
	}

	self.var_95BC = maps/mp/bots/_bots_gametype_conf::func_1AB5(self.var_95BC);
	var_03 = maps/mp/bots/_bots_gametype_conf::func_19C9(self.var_95BC,0);
	if(isdefined(var_03))
	{
		if(!isdefined(self.var_95A8) || distancesquared(var_03.var_28D4,self.var_95A8.var_28D4) > 1)
		{
			self.var_95A8 = var_03;
			maps/mp/bots/_bots_strategy::func_19A3();
			self botsetscriptgoal(self.var_95A8.var_28D4,0,"objective",undefined,level.var_1AF6);
		}

		return 1;
	}
	else if(isdefined(self.var_95A8))
	{
		self method_8358();
		self.var_95A8 = undefined;
	}

	return 0;
}