/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\aitypes\ratking\bt_state_api.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 693 ms
 * Timestamp: 10/26/2023 11:58:56 PM
*******************************************************************/

//Function Number: 1
btstate_getinstancedata(param_00)
{
	return self.var_3135.var_9928[param_00];
}

//Function Number: 2
btstate_setupstate(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.name = param_00;
	var_04.fnbegin = param_01;
	var_04.fntick = param_02;
	var_04.fnend = param_03;
	if(!isdefined(self.bt_states))
	{
		self.bt_states = [];
	}

	self.bt_states[param_00] = var_04;
	return var_04;
}

//Function Number: 3
btstate_getcurrentstatename(param_00)
{
	var_01 = btstate_getinstancedata(param_00);
	if(!isdefined(var_01))
	{
		return undefined;
	}

	if(!isdefined(var_01.var_4C07))
	{
		return undefined;
	}

	return var_01.var_4C07.name;
}

//Function Number: 4
btstate_tickstates(param_00)
{
	var_01 = btstate_getinstancedata(param_00);
	if(!isdefined(var_01.var_4C07))
	{
		return 0;
	}

	if(isdefined(var_01.var_4C07.fntick))
	{
		var_02 = var_01.var_4C07.name;
		var_03 = self [[ var_01.var_4C07.fntick ]](param_00);
		if(isdefined(var_01.var_4C07) && var_01.var_4C07.name != var_02)
		{
			return btstate_tickstates(param_00);
		}

		return var_03;
	}

	return 1;
}

//Function Number: 5
btstate_endstates(param_00)
{
	if(isdefined(self.bt_states))
	{
		var_01 = btstate_getinstancedata(param_00);
		if(isdefined(var_01.var_4C07) && isdefined(var_01.var_4C07.fnend))
		{
			[[ var_01.var_4C07.fnend ]](param_00,undefined);
			var_01.var_4C07 = undefined;
		}
	}
}

//Function Number: 6
btstate_destroystates()
{
	self.bt_states = undefined;
}

//Function Number: 7
btstate_endcurrentstate(param_00)
{
	var_01 = btstate_getinstancedata(param_00);
	if(isdefined(var_01.var_4C07) && isdefined(var_01.var_4C07.fnend))
	{
		self [[ var_01.var_4C07.fnend ]](param_00,undefined);
	}

	var_01.var_4C07 = undefined;
}

//Function Number: 8
btstate_transitionstate(param_00,param_01)
{
	var_02 = btstate_getinstancedata(param_00);
	var_03 = undefined;
	if(isdefined(var_02.var_4C07))
	{
		var_03 = var_02.var_4C07.name;
		if(isdefined(var_02.var_4C07.fnend))
		{
			[[ var_02.var_4C07.fnend ]](param_00,param_01);
		}
	}

	var_04 = self.bt_states[param_01];
	var_02.var_4C07 = var_04;
	if(isdefined(var_04.fnbegin))
	{
		self [[ var_04.fnbegin ]](param_00,var_03);
	}
}

//Function Number: 9
chase_target_state_setup(param_00,param_01,param_02,param_03,param_04)
{
	btstate_setupstate("chase",::chase_target_state_begin,::chase_target_state_tick,::chase_target_state_end);
	var_05 = btstate_getinstancedata(param_00);
	var_05.var_15C = param_01;
	var_05.target = param_02;
	var_05.fncallback = param_03;
	var_05.maxchasetime = param_04;
}

//Function Number: 10
chase_target_state_begin(param_00,param_01)
{
	var_02 = btstate_getinstancedata(param_00);
	var_02.var_10DFF = gettime();
	self method_8284(var_02.target);
	self method_8287(var_02.var_15C * 0.9);
}

//Function Number: 11
chase_target_state_done(param_00,param_01)
{
	var_02 = btstate_getinstancedata(param_00);
	var_03 = var_02.fncallback;
	btstate_endcurrentstate(param_00);
	if(isdefined(var_03))
	{
		[[ var_03 ]](param_00,param_01);
	}
}

//Function Number: 12
chase_target_state_tick(param_00)
{
	var_01 = btstate_getinstancedata(param_00);
	if(!isalive(var_01.target))
	{
		chase_target_state_done(param_00,"aborted");
		return 0;
	}

	if(isdefined(var_01.maxchasetime))
	{
		if(gettime() > var_01.var_10DFF + var_01.maxchasetime)
		{
			chase_target_state_done(param_00,"timeout");
			return 0;
		}
	}

	var_02 = distance2dsquared(self.origin,var_01.target.origin);
	if(var_02 > squared(var_01.var_15C))
	{
		return 1;
	}

	if(abs(self.origin[2] - var_01.target.origin[2] > 32))
	{
		return 1;
	}

	chase_target_state_done(param_00,"arrived");
	return 1;
}

//Function Number: 13
chase_target_state_end(param_00,param_01)
{
	var_02 = btstate_getinstancedata(param_00);
	var_02.var_15C = undefined;
	var_02.target = undefined;
	var_02.fncallback = undefined;
}

//Function Number: 14
asm_wait_state_setup(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_04))
	{
		param_04 = "ASM_Finished";
	}

	btstate_setupstate(param_01,::asm_wait_state_begin,::asm_wait_state_tick,::asm_wait_state_end);
	var_07 = btstate_getinstancedata(param_00);
	var_07.endevent = param_04;
	var_07.asmstate = param_02;
	var_07.fncallback = param_03;
	if(isdefined(param_06))
	{
		var_07.timeouttime = gettime() + param_06;
	}
	else
	{
		var_07.timeouttime = gettime() + 2000;
	}

	if(isdefined(param_05))
	{
		var_07.var_6393 = gettime() + param_05;
	}
}

//Function Number: 15
asm_wait_state_begin(param_00,param_01)
{
	var_02 = btstate_getinstancedata(param_00);
	var_02.bisinasmstate = lib_0A1A::func_2354(var_02.asmstate);
}

//Function Number: 16
asm_wait_state_tick(param_00)
{
	var_01 = btstate_getinstancedata(param_00);
	var_02 = lib_0A1A::func_2354(var_01.asmstate);
	if(var_02 && !var_01.bisinasmstate)
	{
		var_01.bisinasmstate = 1;
	}

	var_03 = 0;
	var_04 = undefined;
	if(!var_02 && var_01.bisinasmstate)
	{
		var_03 = 1;
		var_04 = "aborted";
	}
	else if(isdefined(var_01.timeouttime) && !var_02 && !var_01.bisinasmstate)
	{
		if(gettime() > var_01.timeouttime)
		{
			var_03 = 1;
			var_04 = "timeout";
		}
	}
	else if(isdefined(var_01.var_6393))
	{
		if(gettime() > var_01.var_6393)
		{
			var_03 = 1;
			var_04 = "end_time";
		}
	}

	if(lib_0A1A::func_232A(var_01.asmstate,var_01.endevent))
	{
		var_03 = 1;
		var_04 = "end_event";
	}

	if(var_03)
	{
		var_05 = var_01.fncallback;
		btstate_endcurrentstate(param_00);
		if(isdefined(var_05))
		{
			[[ var_05 ]](param_00,var_04);
		}
	}

	return !var_03;
}

//Function Number: 17
asm_wait_state_end(param_00,param_01)
{
	var_02 = btstate_getinstancedata(param_00);
	var_02.endevent = undefined;
	var_02.asmstate = undefined;
	var_02.fncallback = undefined;
	var_02.bisinasmstate = undefined;
}