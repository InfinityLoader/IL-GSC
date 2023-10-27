/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\elvira\mp\states.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 891 ms
 * Timestamp: 10/27/2023 12:01:43 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("elvira"))
	{
		return;
	}

	scripts\asm\shoot_dlc3\mp\states::func_2371();
	lib_0A1A::func_230B("elvira","c6_start");
	lib_0A1A::func_2374("enter_combat",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,["shoot_dlc3"],undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("noncombat_stand_idle",::lib_0F3C::func_B050,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"noncombat_stand_idle",undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::func_122DB,undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_BCE7,"walk");
	lib_0A1A::func_2375("exposed_idle",undefined,::func_122E1,undefined);
	lib_0A1A::func_2375("exit",undefined,::lib_0C38::func_FFF3,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("enter_combat",undefined,::func_122D7,undefined);
	lib_0A1A::func_2374("c6_start",::scripts\asm\elvira\elvira_asm::elvirainit,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",1);
	lib_0A1A::func_2375("intro",undefined,::lib_0C38::func_FFEF,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("exposed_aimset",undefined,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("strafe_aimset",undefined,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("death_generic",::lib_0C34::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_standing",::lib_0C34::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C34::func_3F00,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_crouching",::lib_0C34::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C34::func_3ECA,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_moving",::lib_0C34::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C34::func_3EE2,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_cover",::lib_0C34::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C34::func_3EC6,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_stand",::lib_0C37::func_D4EE,undefined,undefined,::lib_0C37::func_4109,undefined,::lib_0C37::func_3EEC,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_run",::lib_0C37::func_D4EE,undefined,undefined,::lib_0C37::func_4109,undefined,::lib_0C37::func_3EEB,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_crouch",::lib_0C37::func_D4EE,undefined,undefined,::lib_0C37::func_4109,undefined,::lib_0C37::func_3EE8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_prone",::lib_0C37::func_D4EE,undefined,undefined,::lib_0C37::func_4109,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_cover_right",::lib_0C37::func_CF04,undefined,undefined,::lib_0C37::func_4109,undefined,::lib_0C37::func_3EE5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_cover_stand",::lib_0C37::func_CF04,undefined,undefined,::lib_0C37::func_4109,undefined,::lib_0C37::func_3EE7,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_cover_crouch",::lib_0C37::func_CF04,undefined,undefined,::lib_0C37::func_4109,undefined,::lib_0C37::func_3EE6,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_crouch",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_cover_left",::lib_0C37::func_CF04,undefined,undefined,::lib_0C37::func_4109,undefined,::lib_0C37::func_3EE5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_on_back",::lib_0C37::func_D4EE,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_cover_left_suppress",::lib_0C37::func_CF04,undefined,undefined,::lib_0C37::func_4109,undefined,::lib_0C37::func_3EE5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_cover_right_suppress",::lib_0C37::func_CF04,undefined,undefined,::lib_0C37::func_4109,undefined,::lib_0C37::func_3EE5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("exposed_reload",::lib_0C38::func_260,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3EAA,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"reload","face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_throw_grenade",::lib_0C39::func_CEC6,undefined,undefined,undefined,undefined,::lib_0C39::func_3EA8,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,"throwgrenade","face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_weaponswitch",::lib_0C38::func_CECB,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3EAC,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_stand_turn",::lib_0C38::func_D56A,undefined,undefined,::lib_0C38::func_116FF,undefined,::lib_0C38::func_3F0A,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish early");
	lib_0A1A::func_2374("exposed_idle",::lib_0C38::func_D46D,undefined,undefined,undefined,undefined,::lib_0F3C::func_3EB3,"_aim_5",["aim"],undefined,["shoot_dlc3"],undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_throw_grenade",undefined,::func_12125,undefined);
	lib_0A1A::func_2375("exposed_weaponswitch",undefined,::lib_0C38::func_100A9,undefined);
	lib_0A1A::func_2375("exposed_stand_turn",undefined,::lib_0C38::func_BEA0,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::trans_exposed_idle_to_exposed_crouch_exit3,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::func_120FD,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::lib_0C38::func_10088,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_reload",undefined,::func_12113,undefined);
	lib_0A1A::func_2375("exposed_stand_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("exposed_stand_to_prone",undefined,::lib_0A1B::func_2949,"prone");
	lib_0A1A::func_2374("exposed_stand_to_prone",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_prone",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_prone",::lib_0C38::func_D46D,undefined,undefined,undefined,undefined,::lib_0F3C::func_3EAB,"_aim_5",undefined,"prone",undefined,undefined,"pain_prone",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_prone_to_stand",undefined,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2375("exposed_prone_to_stand",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_prone_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2374("exposed_prone_to_stand",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_stand_to_crouch",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch",::lib_0C38::func_D46D,undefined,undefined,undefined,undefined,::lib_0F3C::func_3EAB,"_aim_5",["aim"],"crouch",["shoot_dlc3"],undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_crouch_to_stand",undefined,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2375("exposed_crouch_to_stand",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_crouch_to_prone",undefined,::lib_0A1B::func_2949,"prone");
	lib_0A1A::func_2375("exposed_crouch_turn",undefined,::lib_0C38::func_BEA0,undefined);
	lib_0A1A::func_2375("exposed_reload_crouch",undefined,::func_120ED,undefined);
	lib_0A1A::func_2374("exposed_crouch_to_stand",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_prone_to_crouch",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_to_prone",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_prone",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_turn",::lib_0C38::func_D56A,undefined,undefined,undefined,undefined,::lib_0C38::func_3F0A,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish early");
	lib_0A1A::func_2374("exposed_reload_crouch",::lib_0C38::func_260,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3EAA,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"reload","face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("step_up_24",::lib_0C3A::func_D566,24,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("iw6_jumpdown_40",::lib_0C3A::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("step_down_24",::lib_0C3A::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("combatrun_forward_72",::lib_0F3C::func_CEA8,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_hop",::lib_0C3A::func_D55D,39.875,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_130",::lib_0C3A::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_96",::lib_0C3A::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("double_jump_temp",::lib_0C3A::func_D55E,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("traverse_external",::scripts\asm\elvira\elvira_asm::dotraverseteleport,undefined,undefined,::scripts\asm\elvira\elvira_asm::terminate_traverseexternal,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2374("jump_down_fast",::lib_0C3A::playtraverseanim_gravity,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_over_40",::lib_0C3A::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("cover_right_arrival",::lib_0F3A::func_CEAA,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,"Cover Right",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("cover_right_exit",::lib_0F3B::func_CEB5,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("exposed_arrival",::lib_0F3A::func_CEAA,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,"Exposed",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_exit",::lib_0F3B::func_CEB5,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("stand_run_loop",::lib_0F3C::func_D4DD,undefined,undefined,undefined,undefined,::lib_0F3C::func_3EB8,"run",["(none)"],"stand",undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("cover_right_arrival",undefined,::lib_0F3A::func_1008A,"Cover Right");
	lib_0A1A::func_2375("cover_left_arrival",undefined,::lib_0F3A::func_1008A,"Cover Left");
	lib_0A1A::func_2375("exposed_arrival",undefined,::lib_0F3A::func_1008A,["Exposed",1]);
	lib_0A1A::func_2375("cover_stand_arrival",undefined,::lib_0F3A::func_1008A,"Cover Stand");
	lib_0A1A::func_2375("cover_crouch_arrival",undefined,::lib_0F3A::func_1008A,["Cover Crouch",1]);
	lib_0A1A::func_2375("cover_left_crouch_arrival",undefined,::lib_0F3A::func_1008A,"Cover Left Crouch");
	lib_0A1A::func_2375("cover_right_crouch_arrival",undefined,::lib_0F3A::func_1008A,"Cover Right Crouch");
	lib_0A1A::func_2375("exposed_crouch_arrival",undefined,::lib_0F3A::func_1008A,["Exposed Crouch",1]);
	lib_0A1A::func_2375("sprint_loop",undefined,::func_1257C,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::func_1255B,undefined);
	lib_0A1A::func_2375("stand_run_strafe_loop",undefined,::lib_0F3C::func_100A3,"stand");
	lib_0A1A::func_2375("stand_run_n_gun_loop",undefined,::lib_0C36::func_10070,undefined);
	lib_0A1A::func_2375("stand_run_n_gun_backwards_loop",undefined,::lib_0C36::func_1006F,undefined);
	lib_0A1A::func_2375("crouch_run_strafe_loop",undefined,::lib_0F3C::func_100A3,"crouch");
	lib_0A1A::func_2374("run_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_left_arrival",::lib_0F3A::func_CEAA,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,"Cover Left",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("cover_left_exit",::lib_0F3B::func_CEB5,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_crouch_exit",::lib_0F3B::func_CEB5,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_crouch_arrival",::lib_0F3A::func_CEAA,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,"Cover Crouch",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("cover_stand_exit",::lib_0F3B::func_CEB5,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_stand_arrival",::lib_0F3A::func_CEAA,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,"Cover Stand",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("stand_run_strafe_loop",::lib_0F3B::func_D4E5,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,["aim"],"stand",["shoot_dlc3"],undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","code_move",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::func_12594,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::func_12595,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0F3C::func_FFB6,"stand");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2374("stand_run_n_gun_loop",::lib_0C36::func_D50D,undefined,undefined,::lib_0C36::func_11088,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,["shoot_dlc3"],undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("stand_run_n_gun_backwards_loop",undefined,::lib_0C36::func_1006F,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("exposed_reload",undefined,::func_12591,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0C36::func_1009F,undefined);
	lib_0A1A::func_2374("stand_run_n_gun_backwards_loop",::lib_0C36::func_D50E,undefined,undefined,::lib_0C36::func_11088,undefined,::lib_0F3C::func_3E96,"move_back",undefined,undefined,["shoot_dlc3"],undefined,"pain_run",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","code_move",undefined);
	lib_0A1A::func_2375("stand_run_n_gun_loop",undefined,::lib_0C36::func_10070,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0C36::func_1009E,undefined);
	lib_0A1A::func_2374("cover_left_crouch_exit",::lib_0F3B::func_CEB5,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_right_crouch_exit",::lib_0F3B::func_CEB5,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_left_crouch_arrival",::lib_0F3A::func_CEAA,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,"Cover Left Crouch",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("cover_right_crouch_arrival",::lib_0F3A::func_CEAA,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,"Cover Right Crouch",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("exposed_crouch_arrival",::lib_0F3A::func_CEAA,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,"Exposed Crouch",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_exit",::lib_0F3B::func_CEB5,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("sprint_loop",::lib_0F3C::func_D4DD,undefined,undefined,undefined,undefined,::lib_0C36::func_3EFF,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::func_12511,undefined);
	lib_0A1A::func_2374("crouch_run_strafe_loop",::lib_0F3B::func_D4E5,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,["aim"],"stand",["shoot_dlc3"],undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","code_move",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0F3C::func_FFB6,"crouch");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2374("move_walk_loop",::lib_0F3C::func_D4DD,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_122B0,undefined);
	lib_0A1A::func_2374("intro",::lib_0C38::func_D4B2,undefined,undefined,::lib_0C38::func_116EC,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exit",::lib_0C38::func_D4EC,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("check_actions",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("revive_player",undefined,::scripts\asm\elvira\elvira_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("reload",undefined,::scripts\asm\elvira\elvira_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("melee",undefined,::scripts\asm\elvira\elvira_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("cast_reveal_spell",undefined,::scripts\asm\elvira\elvira_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("cast_return_spell",undefined,::scripts\asm\elvira\elvira_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("cast_spell",undefined,::scripts\asm\elvira\elvira_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("revive_player",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("revive_player_intro",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("revive_player_intro",::scripts\asm\elvira\elvira_asm::playreviveanim,undefined,undefined,undefined,undefined,::scripts\asm\elvira\elvira_asm::choosereviveanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\elvira\elvira_asm::isanimdone,undefined);
	lib_0A1A::func_2374("action_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("reload",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_reload",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_stand_to_ready",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_stand_to_ready",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::scripts\asm\elvira\elvira_asm::isanimdone,undefined);
	lib_0A1A::func_2374("melee_attack",::lib_0C35::func_D4D7,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack","face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\elvira\elvira_asm::isanimdone,undefined);
	lib_0A1A::func_2374("cast_reveal_spell",::scripts\asm\elvira\elvira_asm::playrevealspellanim,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\elvira\elvira_asm::isanimdone,undefined);
	lib_0A1A::func_2374("cast_return_spell",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\elvira\elvira_asm::isanimdone,undefined);
	lib_0A1A::func_2374("cast_spell",::scripts\asm\elvira\elvira_asm::playcastspellanim,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\elvira\elvira_asm::isanimdone,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
func_122DB(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 3
func_122E1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2941();
}

//Function Number: 4
func_122D7(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2941();
}

//Function Number: 5
func_12125(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_298A();
}

//Function Number: 6
trans_exposed_idle_to_exposed_crouch_exit3(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955() && self.var_1198.var_BD23 == "combat" && lib_0F3C::func_138E2();
}

//Function Number: 7
func_120FD(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.var_2BDF) && self.var_1198.var_2BDF && lib_0F3C::func_138E2();
}

//Function Number: 8
func_12113(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 9
func_120ED(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 10
func_1257C(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("sprint");
}

//Function Number: 11
func_1255B(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 12
func_12594(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 13
func_12595(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 14
func_12591(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 15
func_12511(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2956("sprint");
}

//Function Number: 16
func_122B0(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}