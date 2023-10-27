/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_escalator.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 60 ms
 * Timestamp: 10/27/2023 2:35:24 AM
*******************************************************************/

//Function Number: 1
init()
{
	common_scripts\utility::flag_init("_escalator_on");
	common_scripts\utility::flag_set("_escalator_on");
	level.var_1973 = 0.5;
	var_00 = getentarray("escalator","targetname");
	common_scripts\utility::array_thread(var_00,::func_1974);
}

//Function Number: 2
func_1974()
{
	var_00 = self;
	while(isdefined(var_00.target))
	{
		var_00 startusinglessfrequentlighting();
		var_00.var_1975 = var_00.origin;
		var_00.var_1976 = getent(var_00.target,"targetname");
		var_00 = var_00.var_1976;
	}

	var_00.var_1975 = var_00.origin;
	var_00.var_1977 = 1;
	var_00.var_1976 = self;
	thread escalator_move(self);
}

//Function Number: 3
escalator_move(param_00)
{
	var_01 = param_00;
	var_02 = var_01.origin;
	while(common_scripts\utility::flag("_escalator_on"))
	{
		var_03 = level.var_1973;
		var_04 = var_01.var_1976;
		var_01 show();
		if(var_04 != param_00)
		{
			var_01 moveto(var_04.var_1975,var_03);
		}
		else
		{
			var_01.origin = var_02;
		}

		if(var_04 == param_00)
		{
			var_01 hide();
			var_01.var_1975 = var_02;
			param_00 = var_01;
			wait var_03;
			continue;
		}

		var_01.var_1975 = var_04.var_1975;
		var_01 = var_04;
	}

	var_01 = param_00;
	for(;;)
	{
		var_03 = 2;
		var_04 = var_01.var_1976;
		var_01 show();
		var_01 thread final_move(var_03,var_04);
		if(var_04 == param_00)
		{
			var_01 hide();
			var_01.var_1975 = var_02;
		}

		var_01.var_1975 = var_04.var_1975;
		var_01 = var_04;
		if(var_01 == param_00)
		{
			return;
		}
	}
}

//Function Number: 4
final_move(param_00,param_01)
{
	self moveto(param_01.var_1975,param_00,0,param_00);
	wait param_00;
	self moveto(self.origin,0.05);
}