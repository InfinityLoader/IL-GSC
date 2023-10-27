/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2581.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:23:23 AM
*******************************************************************/

//Function Number: 1
func_FAA4()
{
	if(isdefined(self.var_4D5D))
	{
		thread func_4D5E();
	}
}

//Function Number: 2
func_4D5F()
{
	self endon("terminate_ai_threads");
	while(isalive(self))
	{
		self waittill("damage_part_died",var_00);
		scripts\anim\utility_common::func_E191(self.var_E2,self.var_1B1,self);
		if(self method_81B7())
		{
			return;
		}

		if(isdefined(self.var_71A1))
		{
			foreach(var_02 in var_00)
			{
				self [[ self.var_71A1 ]](var_02);
			}
		}
	}
}

//Function Number: 3
func_4D60()
{
	self endon("terminate_ai_threads");
	while(isalive(self))
	{
		self waittill("damage_subpart_died",var_00);
		if(self method_81B7())
		{
			return;
		}

		if(isdefined(self.var_719D))
		{
			foreach(var_02 in var_00)
			{
				self [[ self.var_719D ]](var_02);
			}
		}
	}
}

//Function Number: 4
func_4D5E()
{
	self endon("death");
	self endon("terminate_ai_threads");
	thread func_4D60();
	thread func_4D5F();
}

//Function Number: 5
func_9F3E(param_00)
{
	if(lib_0A1B::func_294B())
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 6
func_9E22(param_00)
{
	if(lib_0A1B::func_293F())
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}