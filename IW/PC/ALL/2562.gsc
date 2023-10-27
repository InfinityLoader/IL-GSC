/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2562.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:23:20 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(isdefined(level.var_119F))
	{
		return;
	}

	level.var_119F = [];
	level.var_119E = [];
	anim.var_6AD5 = 0;
	anim.var_111AE = 1;
	anim.var_E87A = 2;
	anim.var_9B08 = 3;
	anim.var_1527 = 3;
}

//Function Number: 2
func_0077()
{
	self.var_3135 = spawnstruct();
	if(isdefined(self.var_2A80))
	{
		self method_84B4(self.var_2A80);
	}
	else
	{
		self.var_3135.var_E87F = [];
		self.var_3135.var_D8BE = [];
		self.var_3135.var_BE5D = 0;
		self.var_C9D9 = level.var_119F[self.var_2A7F];
		self [[ self.var_C9D9.var_71AD ]]();
	}

	self.var_3135.var_9928 = [];
	thread func_0071();
}

//Function Number: 3
func_0071()
{
	self endon("death");
	self endon("terminate_ai_threads");
	for(;;)
	{
		self waittill("ai_notify",var_00,var_01);
		lib_0A1A::func_232F("ai_notify",var_00,var_01);
	}
}

//Function Number: 4
func_008D(param_00,param_01)
{
	level.var_119F[param_00] = param_01;
	switch(param_00)
	{
		case "human/ally_combatant":
		case "human/enemy_combatant":
			lib_09FD::func_103F2();
			break;

		case "c6/base":
			lib_09FD::func_3353();
			break;

		case "c12/c12":
			lib_09FD::func_3508();
			break;

		case "seeker/seeker":
			lib_09FD::func_F10A();
			break;
	}
}

//Function Number: 5
func_007B(param_00)
{
	return isdefined(level.var_119F) && isdefined(level.var_119F[param_00]);
}

//Function Number: 6
func_0074(param_00,param_01)
{
	return self.var_C9D9.var_11591[param_00] + param_01;
}

//Function Number: 7
func_0076(param_00)
{
	return [[ self.var_C9D9.var_1158E[param_00] ]]();
}

//Function Number: 8
func_008F(param_00,param_01,param_02,param_03)
{
	var_04 = param_00.var_D8BE[param_02];
	if(!isdefined(var_04))
	{
		return;
	}

	if(var_04 <= param_03)
	{
		return;
	}

	var_05 = spawnstruct();
	var_05.var_71D2 = param_01;
	var_05.var_1158F = param_02;
	for(;;)
	{
		self [[ var_05.var_71D2 ]](param_00,var_05.var_1158F,var_05);
		if(!isdefined(var_05.var_71D2))
		{
			break;
		}
	}
}

//Function Number: 9
func_0087(param_00)
{
	if(param_00 == level.var_111AE)
	{
		return level.var_6AD5;
	}
	else if(param_00 == level.var_6AD5)
	{
		return level.var_111AE;
	}

	return param_00;
}

//Function Number: 10
func_0090()
{
	if(isdefined(self.var_2A80))
	{
		self method_84B5();
	}
}

//Function Number: 11
func_0075()
{
	if(isdefined(self.var_51E3))
	{
		return self.var_51E3;
	}

	if(isdefined(self.var_1198.var_7366))
	{
		return self.var_1198.var_7366;
	}

	return "combat";
}