/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3910.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:31:14 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("zombie_ghost"))
	{
		return;
	}

	lib_0A1A::func_230B("zombie_ghost","zombiestart");
	lib_0A1A::func_2374("zombiestart",::lib_0C75::func_13F9A,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_state",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("choose_state",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("entangled",undefined,::func_11BF0,undefined);
	lib_0A1A::func_2375("melee",undefined,::func_11BF2,undefined);
	lib_0A1A::func_2375("fly",undefined,::func_11BF1,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle",::lib_0C77::func_13F6C,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("entangled",undefined,::func_12242,undefined);
	lib_0A1A::func_2375("melee",undefined,::func_12251,undefined);
	lib_0A1A::func_2375("fly",undefined,::func_12247,undefined);
	lib_0A1A::func_2374("fly",::lib_0C77::func_13F6A,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("entangled",undefined,::func_12173,undefined);
	lib_0A1A::func_2375("melee",undefined,::func_12179,undefined);
	lib_0A1A::func_2375("fly_turn",undefined,::func_12175,undefined);
	lib_0A1A::func_2375("idle",undefined,::func_12177,undefined);
	lib_0A1A::func_2374("melee",::lib_0C77::func_13F6D,undefined,::lib_0C77::func_13F63,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("entangled",undefined,::func_122A0,undefined);
	lib_0A1A::func_2375("fly",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("fly_turn",::lib_0C77::func_13F6B,undefined,undefined,undefined,undefined,::lib_0C77::func_13F61,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("entangled",undefined,::func_1217B,undefined);
	lib_0A1A::func_2375("fly",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("entangled",::lib_0F3C::func_B050,undefined,undefined,::lib_0C77::func_13F6E,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("launched",undefined,::func_120C5,undefined);
	lib_0A1A::func_2375("choose_state",undefined,::func_120C3,undefined);
	lib_0A1A::func_2374("launched",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
func_11BF0(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F67();
}

//Function Number: 3
func_11BF2(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F66();
}

//Function Number: 4
func_11BF1(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F64();
}

//Function Number: 5
func_12242(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F67();
}

//Function Number: 6
func_12251(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F66();
}

//Function Number: 7
func_12247(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F64();
}

//Function Number: 8
func_12173(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F67();
}

//Function Number: 9
func_12179(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F66();
}

//Function Number: 10
func_12175(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F65();
}

//Function Number: 11
func_12177(param_00,param_01,param_02,param_03)
{
	return !lib_0C77::func_13F64();
}

//Function Number: 12
func_122A0(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F67();
}

//Function Number: 13
func_1217B(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F67();
}

//Function Number: 14
func_120C5(param_00,param_01,param_02,param_03)
{
	return lib_0C77::func_13F68();
}

//Function Number: 15
func_120C3(param_00,param_01,param_02,param_03)
{
	return !lib_0C77::func_13F67();
}