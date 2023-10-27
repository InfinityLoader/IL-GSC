/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 766.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 3:27:01 AM
*******************************************************************/

//Function Number: 1
func_8CCC(param_00,param_01)
{
	return 1;
}

//Function Number: 2
func_8CCB(param_00,param_01)
{
	return gettime() - param_01 * 0.001 >= param_00;
}

//Function Number: 3
func_8CC0(param_00)
{
	if(isdefined(level.var_9321))
	{
		return level.var_9321[param_00];
	}
}

//Function Number: 4
func_8CBE(param_00)
{
	var_01 = spawnstruct();
	var_01.var_9320 = param_00;
	var_01.var_9328 = [];
	level.var_9321[param_00] = var_01;
	return var_01;
}

//Function Number: 5
func_8CBB(param_00)
{
	var_01 = spawnstruct();
	var_01.var_9322 = param_00;
	var_01.var_9C6B = [];
	self.var_9328[param_00] = var_01;
}

//Function Number: 6
func_8CBC(param_00,param_01,param_02,param_03)
{
	var_04 = func_071C(param_00);
	var_04.var_9C6B[var_04.var_9C6B.size] = [param_01,param_02,param_03];
}

//Function Number: 7
func_8CB9(param_00,param_01,param_02)
{
	var_03 = func_071C(param_00);
	var_03.var_37B2 = param_01;
	var_03.var_37B3 = param_02;
}

//Function Number: 8
func_8CBD(param_00,param_01,param_02)
{
	var_03 = func_071C(param_00);
	var_03.var_A0A7 = param_01;
	var_03.var_A0A8 = param_02;
}

//Function Number: 9
func_8CBA(param_00,param_01,param_02)
{
	var_03 = func_071C(param_00);
	var_03.var_38E9 = param_01;
	var_03.var_38EA = param_02;
}

//Function Number: 10
func_071C(param_00)
{
	var_01 = self.var_9328[param_00];
	return var_01;
}

//Function Number: 11
func_071B(param_00,param_01,param_02)
{
	foreach(var_04 in param_01.var_9C6B)
	{
		var_05 = var_04[0];
		var_06 = var_04[1];
		var_07 = var_04[2];
		if(self [[ var_06 ]](var_07,param_02))
		{
			return var_05;
		}
	}

	return undefined;
}

//Function Number: 12
func_8CBF(param_00,param_01)
{
	if(isdefined(param_01))
	{
		self endon("death");
	}

	var_02 = func_8CC0(param_00);
	self.var_28CD = getfirstarraykey(var_02.var_9328);
	var_03 = var_02.var_9328[self.var_28CD];
	var_04 = gettime();
	if(isdefined(var_03.var_37B2))
	{
		self [[ var_03.var_37B2 ]](var_03.var_37B3);
	}

	for(;;)
	{
		var_05 = func_071B(var_02,var_03,var_04);
		if(isdefined(var_05))
		{
			self notify("sm_state_change");
			if(isdefined(var_03.var_38E9))
			{
				self [[ var_03.var_38E9 ]](var_03.var_38EA);
			}

			if(var_05 == "")
			{
				return;
			}

			self.var_28CD = var_05;
			var_03 = var_02.var_9328[var_05];
			var_04 = gettime();
			if(isdefined(var_03.var_37B2))
			{
				self [[ var_03.var_37B2 ]](var_03.var_37B3);
			}

			continue;
		}

		if(isdefined(var_03.var_A0A7))
		{
			self [[ var_03.var_A0A7 ]](var_03.var_A0A8,var_04);
		}

		wait 0.05;
	}
}