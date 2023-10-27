/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\agents\_agent_common.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 466 ms
 * Timestamp: 10/27/2023 12:32:09 AM
*******************************************************************/

//Function Number: 1
func_00A3()
{
	self [[ level.var_97C2 ]]();
	var_00 = "axis";
	if(level.var_C20F % 2 == 0)
	{
		var_00 = "allies";
	}

	level.var_C20F++;
	self method_8492("locdmgtable/mp_lochit_dmgtable");
	self [[ level.var_F635 ]](var_00);
	level.var_1900[level.var_1900.size] = self;
}

//Function Number: 2
func_00A4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	param_01 = [[ level.var_190A ]](param_01);
	var_0C = self [[ level.var_1908 ]]("on_damaged");
	if(isdefined(var_0C))
	{
		self [[ var_0C ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B);
	}
}

//Function Number: 3
func_00A5(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(isdefined(level.var_3762))
	{
		[[ level.var_3762 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
	}
}

//Function Number: 4
func_00A6(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	param_01 = [[ level.var_190A ]](param_01);
	var_0A = self [[ level.var_1908 ]]("on_killed");
	if(isdefined(var_0A))
	{
		self thread [[ var_0A ]](param_00,param_01,param_02,param_04,param_05,param_06,param_07,param_08,param_09);
	}
}

//Function Number: 5
func_00A7(param_00,param_01,param_02,param_03)
{
}

//Function Number: 6
func_00A8(param_00,param_01)
{
}

//Function Number: 7
func_00A9(param_00,param_01,param_02,param_03)
{
}

//Function Number: 8
init()
{
	func_97C1();
	scripts\mp\agents\_scriptedagents::func_DF00();
	level thread func_1691();
}

//Function Number: 9
func_4535(param_00,param_01,param_02)
{
	var_03 = [[ level.var_7EC5 ]](param_00);
	if(isdefined(var_03))
	{
		var_03.var_4539 = gettime();
		if(isdefined(param_01))
		{
			var_03 [[ level.var_F635 ]](param_01);
		}
		else
		{
			var_03 [[ level.var_F635 ]](var_03.team);
		}

		if(isdefined(param_02))
		{
			var_03.var_4007 = param_02;
		}

		if(isdefined(level.agent_funcs[param_00]["onAIConnect"]))
		{
			var_03 [[ var_03 [[ level.var_1908 ]]("onAIConnect") ]]();
		}

		var_03 [[ level.var_184B ]]();
	}

	return var_03;
}

//Function Number: 10
func_97C1()
{
	level.var_1900 = [];
	level.var_C20F = 0;
}

//Function Number: 11
func_1691()
{
	level endon("game_ended");
	level waittill("connected",var_00);
	var_01 = function_00AF();
	while(level.var_1900.size < var_01)
	{
		var_02 = addagent();
		if(!isdefined(var_02))
		{
			scripts\common\utility::func_136F7();
			continue;
		}
	}
}

//Function Number: 12
func_F28C(param_00)
{
	self.var_1E = param_00;
	self.health = param_00;
	self.maxhealth = param_00;
}