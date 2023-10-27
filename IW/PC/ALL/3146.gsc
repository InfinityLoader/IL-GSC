/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3146.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 12:26:16 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("civilian"))
	{
		return;
	}

	lib_0A1A::func_230B("civilian","start");
	lib_0A1A::func_2374("start",::lib_0C49::func_3FCE,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stand_run_loop",undefined,::func_125C4,undefined);
	lib_0A1A::func_2375("stand_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("stand_idle",::lib_0C49::func_3FD4,undefined,undefined,undefined,undefined,::lib_0C49::func_3EC5,undefined,undefined,undefined,undefined,"scared",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("move_passthrough_init",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("trans_in_combat_react",undefined,::lib_0C49::func_A00A,undefined);
	lib_0A1A::func_2375("trans_direct_to_non_combat",undefined,::lib_0C49::func_FFDF,undefined);
	lib_0A1A::func_2375("trans_out_combat",undefined,::lib_0C49::func_3FE1,"noncombat");
	lib_0A1A::func_2374("Knobs",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("stand_run_loop",::lib_0C49::func_3FD5,undefined,undefined,::lib_0C49::func_3FD1,undefined,::scripts\asm\shared_utility::func_3ECD,"move",undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0C65::func_FFF8,["run_turn",1]);
	lib_0A1A::func_2375("pass_run_should_arrive",undefined,::lib_0C5D::func_FFD4,undefined);
	lib_0A1A::func_2375("trans_in_stand_idle",undefined,::lib_0A1A::func_C17F,undefined);
	lib_0A1A::func_2374("AnimScripted",::lib_0F3D::func_1FCB,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_idle",undefined,::func_11B75,undefined);
	lib_0A1A::func_2374("exposed_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("trans_in_stand_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("death",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_generic",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_generic",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("run_turn",::lib_0C49::func_3FD6,undefined,undefined,::lib_0C49::func_3FD1,undefined,::lib_0C65::func_3EF5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pass_run_should_arrive",undefined,::lib_0C5D::func_FFD5,undefined);
	lib_0A1A::func_2374("exposed_exit",::lib_0C49::func_3FD3,1,undefined,::lib_0C49::func_3FD1,undefined,::lib_0C65::func_3E9F,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pass_run_should_arrive",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_arrival",undefined,::lib_0C5D::func_10090,["Exposed",1]);
	lib_0A1A::func_2375("exposed_arrival",undefined,::lib_0C5D::func_10090,["Exposed Crouch",1]);
	lib_0A1A::func_2375("exposed_arrival",undefined,::lib_0C5D::func_10090,["Cover Stand",1]);
	lib_0A1A::func_2375("exposed_arrival",undefined,::lib_0C5D::func_10090,["Cover Crouch",1]);
	lib_0A1A::func_2374("trans_in_stand_idle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C49::func_3EC5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("trans_in_combat_react",undefined,::lib_0C49::func_A00A,undefined);
	lib_0A1A::func_2374("trans_out_stand_idle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C49::func_3EC5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_idle",undefined,::lib_0A1A::func_C17F,undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("facial_animation",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("move_passthrough",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stand_run_loop",undefined,::func_122AA,undefined);
	lib_0A1A::func_2375("trans_out_stand_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_seeker_attack_civilian_victim",::lib_0C52::func_D4D0,undefined,::lib_0C64::func_B590,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2374("combat_reaction",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C49::func_3EC4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("trans_out_combat_react",undefined,::func_11BF6,undefined);
	lib_0A1A::func_2375("trans_out_combat_react",undefined,::lib_0C49::func_3FE1,"noncombat");
	lib_0A1A::func_2375("move_passthrough_init",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2374("trans_in_combat_react",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C49::func_3EC4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("combat_reaction",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("trans_out_combat_react",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C49::func_3EC4,undefined,undefined,undefined,undefined,"scared",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("trans_in_combat_react",undefined,::lib_0C49::func_A00A,undefined);
	lib_0A1A::func_2374("trans_in_non_combat",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C49::func_3EC5,undefined,undefined,undefined,undefined,"scared",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("non_combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("trans_in_combat_react",undefined,::lib_0C49::func_A00A,undefined);
	lib_0A1A::func_2374("trans_out_non_combat",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C49::func_3EC5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("trans_in_combat_react",0.1,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("non_combat_idle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C49::func_3EC5,undefined,undefined,undefined,undefined,"scared",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("trans_in_combat_react",0.1,::lib_0C49::func_FFE3,undefined);
	lib_0A1A::func_2375("move_passthrough_init",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("trans_out_non_combat",0.1,::lib_0C49::func_A00A,undefined);
	lib_0A1A::func_2375("trans_out_non_combat",0.1,::lib_0C49::func_3FE1,"combat");
	lib_0A1A::func_2374("trans_out_combat",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C49::func_3EC5,undefined,undefined,undefined,undefined,"scared",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("trans_in_non_combat",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("trans_in_combat_react",undefined,::lib_0C49::func_A00A,undefined);
	lib_0A1A::func_2374("trans_direct_to_non_combat",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C49::func_3EC5,undefined,undefined,undefined,undefined,"scared",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("non_combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("trans_in_combat_react",undefined,::lib_0C49::func_A00A,undefined);
	lib_0A1A::func_2374("move_passthrough_init",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("move_passthrough",undefined,::lib_0C49::func_FFD2,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
func_125C4(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_233);
}

//Function Number: 3
func_11B75(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2938();
}

//Function Number: 4
func_122AA(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_55ED) && self.var_55ED;
}

//Function Number: 5
func_11BF6(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_294E();
}