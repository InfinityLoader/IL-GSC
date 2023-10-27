/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3156.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:26:18 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("seeker"))
	{
		return;
	}

	lib_0A1A::func_230B("seeker","seeker_init");
	lib_0A1A::func_2374("idle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy or motion",undefined,undefined);
	lib_0A1A::func_2375("choose_unittype",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("exit",undefined,::func_12245,undefined);
	lib_0A1A::func_2374("run_loop",::lib_0C53::func_B063,undefined,undefined,::lib_0C53::func_B064,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy or motion","normal",undefined);
	lib_0A1A::func_2375("choose_unittype",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("idle",undefined,::func_12440,undefined);
	lib_0A1A::func_2374("seeker_init",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("off_nav_mesh",undefined,::lib_0C53::func_F171,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("Knobs",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("traverse_external",::lib_0C53::func_D561,undefined,undefined,undefined,"run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_generic",::lib_0C53::func_F16E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("exit",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face goal",undefined,undefined);
	lib_0A1A::func_2375("choose_unittype",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0C53::func_9DEE,undefined);
	lib_0A1A::func_2374("slide_across_car",::lib_0C53::func_D55F,undefined,undefined,undefined,"run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("double_jump",::lib_0C53::func_D561,undefined,undefined,undefined,"run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("double_jump_mantle",::lib_0C53::func_CF20,undefined,undefined,undefined,"run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("double_jump_vault",::lib_0C53::func_CF27,undefined,undefined,undefined,"run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("antigrav_rise",::lib_0F41::func_CEE2,1,undefined,undefined,undefined,::lib_0F41::func_3EB1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("antigrav_float_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("antigrav_fall",undefined,::lib_0F41::func_2012,undefined);
	lib_0A1A::func_2374("antigrav_float_idle",::lib_0F41::func_CEE0,undefined,undefined,undefined,undefined,::lib_0F41::func_3EB0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("antigrav_fall",undefined,::lib_0F41::func_2012,undefined);
	lib_0A1A::func_2374("antigrav_fall",::lib_0F41::func_CEDC,undefined,undefined,undefined,undefined,::lib_0F41::func_3EAD,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("antigrav_fall_complete",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("antigrav_fall_restart",::lib_0F41::func_CEDD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("antigrav_float_idle",1,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("antigrav_getup_restart",::lib_0F41::func_CEE1,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("antigrav_rise",1,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("antigrav_fall_complete",::lib_0F41::func_CEDB,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_seeker_attack_soldier",::lib_0C52::func_D4CE,undefined,::lib_0C64::func_B590,::lib_0C52::func_D4CF,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2374("melee_seeker_soldier",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_seeker_attack_soldier",undefined,::lib_0C52::func_F127,1);
	lib_0A1A::func_2374("melee_seeker_attack_c6",::lib_0C52::func_D4CE,undefined,::lib_0C64::func_B590,::lib_0C52::func_D4CF,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2374("melee_seeker_attack_civilian",::lib_0C52::func_D4CE,undefined,::lib_0C64::func_B590,::lib_0C52::func_D4CF,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2374("choose_unittype",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_seeker_soldier",undefined,::lib_0C53::func_9FBC,"soldier");
	lib_0A1A::func_2375("melee_seeker_c6",undefined,::lib_0C53::func_9FBC,"c6");
	lib_0A1A::func_2375("melee_seeker_player",undefined,::lib_0C53::func_9FBC,"player");
	lib_0A1A::func_2375("melee_seeker_civilian",undefined,::lib_0C53::func_9FBC,"civilian");
	lib_0A1A::func_2374("melee_seeker_c6",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_seeker_attack_c6",undefined,::lib_0C52::func_F127,1);
	lib_0A1A::func_2374("melee_seeker_civilian",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_seeker_attack_civilian",undefined,::lib_0C52::func_F127,1);
	lib_0A1A::func_2374("melee_seeker_player",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_seeker_attack_player",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_seeker_attack_player",::lib_0C52::func_F148,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_grab_save_or_kill",undefined,::lib_0F3D::func_B642,undefined);
	lib_0A1A::func_2375("melee_grab_save_or_kill",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_grab_save_or_kill",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_seeker_player_win",undefined,::lib_0F3D::func_B5FC,undefined);
	lib_0A1A::func_2375("melee_seeker_player_lose",undefined,::func_12272,undefined);
	lib_0A1A::func_2374("melee_seeker_player_win",::lib_0C52::func_F149,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2374("melee_seeker_player_lose",::lib_0C52::func_F147,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2374("death_antigrav_grenade",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_antigrav_grenade_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_antigrav_grenade_default",::lib_0C53::func_F16C,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("off_nav_mesh",::lib_0C53::func_CF23,undefined,undefined,undefined,"run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2327();
}

//Function Number: 2
func_12245(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_233);
}

//Function Number: 3
func_12440(param_00,param_01,param_02,param_03)
{
	return !isdefined(self.var_233);
}

//Function Number: 4
func_12272(param_00,param_01,param_02,param_03)
{
	return !lib_0F3D::func_B5FC();
}