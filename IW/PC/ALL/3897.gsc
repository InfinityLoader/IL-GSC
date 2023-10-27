/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3897.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:31:09 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("seeker_mp"))
	{
		return;
	}

	lib_0A1A::func_230B("seeker_mp","seeker_init");
	lib_0A1A::func_2374("idle",::lib_0F3C::func_B050,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exit",undefined,::func_12244,undefined);
	lib_0A1A::func_2374("run_loop",::lib_0F38::func_B063,undefined,undefined,::lib_0F38::func_F173,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("idle",undefined,::func_1243F,undefined);
	lib_0A1A::func_2374("seeker_init",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("traverse_external",::lib_0F38::func_D560,undefined,undefined,::lib_0F38::func_F178,"run_loop",::lib_0F3C::func_3E96,0,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_generic",::lib_0F38::func_F16E,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("exit",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0F38::func_9DEE,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
func_12244(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_233);
}

//Function Number: 3
func_1243F(param_00,param_01,param_02,param_03)
{
	return !isdefined(self.var_233);
}