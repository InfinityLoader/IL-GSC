/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3604.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:30:53 AM
*******************************************************************/

//Function Number: 1
func_B557()
{
	level thread func_B559();
}

//Function Number: 2
func_B559()
{
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(isai(var_00))
		{
			continue;
		}
	}
}

//Function Number: 3
func_B558()
{
}

//Function Number: 4
func_B554(param_00)
{
	self.var_B551 = 1;
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!param_00)
	{
		self iprintlnbold("C.E.C.O.T drive active");
		thread func_B553();
	}

	var_01 = 450;
	var_02 = 1200;
	var_03 = 350;
	self method_842E(0,var_01);
	self method_842C(0,var_01);
	self method_8434(0,var_02);
	self method_8430(0,var_03);
	return 1;
}

//Function Number: 5
func_B552(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	var_01 = 400;
	var_02 = 400;
	self method_842E(0,var_01);
	self method_842C(0,var_01);
	self method_8434(0,var_02);
	self method_8430(0,900);
	if(!param_00)
	{
		self.var_B551 = 0;
		self setscriptablepartstate("megaboost","megaboostOff",0);
		self notify("megaboost_end");
	}
}

//Function Number: 6
func_B555()
{
	self endon("megaboost_end");
	scripts\common\utility::waittill_any_3("death","disconnect","game_ended");
	thread func_B552();
}

//Function Number: 7
func_9E95()
{
	if(!isdefined(self.var_B551))
	{
		return 0;
	}

	return self.var_B551;
}

//Function Number: 8
func_B553()
{
	self endon("disconnect");
	self endon("megaboost_end");
	self method_846F("ges_hold");
	self setscriptablepartstate("megaboost","megaboostOn",0);
}