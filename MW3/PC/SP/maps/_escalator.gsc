/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_escalator.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 66 ms
 * Timestamp: 10/27/2023 2:22:58 AM
*******************************************************************/

//Function Number: 1
init()
{
	common_scripts\utility::flag_init("_escalator_on");
	common_scripts\utility::flag_set("_escalator_on");
	level.escalator_movespeed = 0.5;
	var_00 = getentarray("escalator","targetname");
	common_scripts\utility::array_thread(var_00,::escalator_startup);
}

//Function Number: 2
escalator_startup()
{
	var_00 = self;
	while(isdefined(var_00.target))
	{
		var_00 startusinglessfrequentlighting();
		var_00.true_origin = var_00.origin;
		var_00.next_step = getent(var_00.target,"targetname");
		var_00 = var_00.next_step;
	}

	var_00.true_origin = var_00.origin;
	var_00.last = 1;
	var_00.next_step = self;
	thread escalator_move(self);
}

//Function Number: 3
escalator_move(param_00)
{
	var_01 = param_00;
	var_02 = var_01.origin;
	while(common_scripts\utility::flag("_escalator_on"))
	{
		var_03 = level.escalator_movespeed;
		var_04 = var_01.next_step;
		var_01 show();
		if(var_04 != param_00)
		{
			var_01 moveto(var_04.true_origin,var_03);
		}
		else
		{
			var_01.origin = var_02;
		}

		if(var_04 == param_00)
		{
			var_01 hide();
			var_01.true_origin = var_02;
			param_00 = var_01;
			wait var_03;
			continue;
		}

		var_01.true_origin = var_04.true_origin;
		var_01 = var_04;
	}

	var_01 = param_00;
	for(;;)
	{
		var_03 = 2;
		var_04 = var_01.next_step;
		var_01 show();
		var_01 thread final_move(var_03,var_04);
		if(var_04 == param_00)
		{
			var_01 hide();
			var_01.true_origin = var_02;
		}

		var_01.true_origin = var_04.true_origin;
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
	self moveto(param_01.true_origin,param_00,0,param_00);
	wait param_00;
	self moveto(self.origin,0.05);
}