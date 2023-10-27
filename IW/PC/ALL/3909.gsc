/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3909.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 56 ms
 * Timestamp: 10/27/2023 12:31:13 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("zombie_brute"))
	{
		return;
	}

	lib_0A1A::func_230B("zombie_brute","zombiestart");
	lib_0A1A::func_2374("zombiestart",::lib_0C75::func_13F9A,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("brute_intro",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("laser_attack",undefined,::lib_0C76::func_FFF1,undefined);
	lib_0A1A::func_2375("helmet_place",undefined,::lib_0C76::func_10063,undefined);
	lib_0A1A::func_2375("helmet_remove",undefined,::lib_0C76::func_10069,undefined);
	lib_0A1A::func_2375("melee",undefined,::func_12253,undefined);
	lib_0A1A::func_2375("choose_idle_exit",undefined,::func_1223F,undefined);
	lib_0A1A::func_2375("idle_combat",undefined,::func_1224F,undefined);
	lib_0A1A::func_2374("choose_idle",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("helmet_remove",undefined,::lib_0C76::func_10069,undefined);
	lib_0A1A::func_2375("helmet_place",undefined,::lib_0C76::func_10063,undefined);
	lib_0A1A::func_2375("choose_idle_exit",undefined,::func_11BB9,undefined);
	lib_0A1A::func_2375("idle_combat",undefined,::func_11BBE,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle_combat",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,"face goal",undefined,undefined);
	lib_0A1A::func_2375("throw_zombie_piece",undefined,::lib_0C76::func_100AC,undefined);
	lib_0A1A::func_2375("grab_zombie_piece",undefined,::lib_0C76::func_1001D,undefined);
	lib_0A1A::func_2375("laser_attack",undefined,::lib_0C76::func_FFF1,undefined);
	lib_0A1A::func_2375("helmet_remove",undefined,::lib_0C76::func_10069,undefined);
	lib_0A1A::func_2375("helmet_place",undefined,::lib_0C76::func_10063,undefined);
	lib_0A1A::func_2375("melee",undefined,::func_12210,undefined);
	lib_0A1A::func_2375("choose_idle_exit",undefined,::func_12207,undefined);
	lib_0A1A::func_2374("grab_zombie_piece",::lib_0C76::func_D48D,undefined,::lib_0C76::func_8485,::lib_0C76::func_116EB,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("idle_combat",undefined,::lib_0C76::func_1FB4,undefined);
	lib_0A1A::func_2374("throw_zombie_piece",::lib_0C76::func_D54C,undefined,::lib_0C76::func_11809,::lib_0C76::func_116EF,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("idle_combat",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("throw_zombie_piece_while_moving",::lib_0C76::func_D54C,undefined,::lib_0C76::func_11809,::lib_0C76::func_116EF,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0C76::func_1FB4,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::lib_0C76::func_1FB4,undefined);
	lib_0A1A::func_2374("grab_zombie_piece_while_moving",::lib_0C76::func_D48E,undefined,::lib_0C76::func_8485,::lib_0C76::func_116EB,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0C76::func_1FB4,undefined);
	lib_0A1A::func_2374("laser_attack",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("laser_attack_prep",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("idle_combat",undefined,::lib_0C76::func_9E70,undefined);
	lib_0A1A::func_2374("aimset_laser",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("laser_attack_idle",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("idle_combat",undefined,::lib_0C76::func_9E70,undefined);
	lib_0A1A::func_2375("laser_attack_shoot",undefined,::lib_0C76::func_390C,undefined);
	lib_0A1A::func_2374("laser_attack_shoot",::lib_0C76::func_58E5,undefined,undefined,::lib_0C76::func_116F8,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("idle_combat",undefined,::lib_0C76::func_9E70,undefined);
	lib_0A1A::func_2375("laser_attack_idle",undefined,::lib_0C76::func_100A0,undefined);
	lib_0A1A::func_2374("laser_attack_prep",::lib_0C76::func_D4BB,undefined,undefined,::lib_0C76::terminatelaserattackprep,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("laser_attack_decide",undefined,::lib_0C76::func_1FB4,undefined);
	lib_0A1A::func_2374("laser_attack_decide",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("laser_attack_shoot",undefined,::lib_0C76::func_390C,undefined);
	lib_0A1A::func_2375("laser_attack_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("helmet_remove",::lib_0C76::func_D499,undefined,::lib_0C76::func_8E15,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0C76::func_1FB4,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("helmet_place",::lib_0C76::func_D498,undefined,::lib_0C76::func_8E15,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("choose_idle",undefined,::lib_0C76::func_1FB4,undefined);
	lib_0A1A::func_2375("choose_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("attack_stand_2_hit",::lib_0C73::func_CC64,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("attack_walk",::lib_0C73::func_D4DC,undefined,undefined,undefined,undefined,::lib_0C73::func_3EB9,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("attack_run",::lib_0C73::func_D4DC,undefined,undefined,undefined,undefined,::lib_0C73::func_3EB9,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("attack_sprint",::lib_0C73::func_D4DC,undefined,undefined,undefined,undefined,::lib_0C73::func_3EB9,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("attack_slam",undefined,::lib_0C76::func_10055,undefined);
	lib_0A1A::func_2375("melee_move",undefined,::func_122A2,undefined);
	lib_0A1A::func_2375("choose_num_melee_hits",undefined,::func_1229E,undefined);
	lib_0A1A::func_2374("melee_move",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("attack_run_2_hit",undefined,::func_1227B,undefined);
	lib_0A1A::func_2375("attack_walk",undefined,::func_12283,undefined);
	lib_0A1A::func_2375("attack_run",undefined,::func_12276,undefined);
	lib_0A1A::func_2375("attack_sprint",undefined,::func_1227D,undefined);
	lib_0A1A::func_2374("melee_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_idle",undefined,::lib_0C75::func_13F9B,undefined);
	lib_0A1A::func_2374("choose_num_melee_hits",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("attack_stand_2_hit",undefined,::func_11BEF,undefined);
	lib_0A1A::func_2375("attack_stand",undefined,::func_11BEE,undefined);
	lib_0A1A::func_2374("attack_stand",::lib_0C73::func_D539,undefined,undefined,undefined,undefined,::lib_0C73::func_3EB9,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("attack_run_2_hit",::lib_0C73::func_CC64,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("attack_slam",::lib_0C76::func_D51C,undefined,undefined,undefined,undefined,::lib_0C76::func_3EFA,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("attack_swipe",::lib_0C76::func_D51C,undefined,undefined,undefined,undefined,::lib_0C76::func_3EFA,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("choose_movetype",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("sprint_loop",undefined,::func_11BE1,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::func_11BDA,undefined);
	lib_0A1A::func_2374("run_loop",::lib_0C75::func_D4E3,undefined,undefined,undefined,undefined,::lib_0C76::func_3EC1,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("enter_duck_move",undefined,::lib_0C76::func_1003B,undefined);
	lib_0A1A::func_2375("to_take_helmet_off",undefined,::lib_0C76::func_10069,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::func_12437,undefined);
	lib_0A1A::func_2375("run_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_1245A,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("choose_idle_exit",undefined,::func_1242F,undefined);
	lib_0A1A::func_2375("attack_slam",undefined,::lib_0C76::func_FFE2,undefined);
	lib_0A1A::func_2375("move_done",undefined,::func_12448,undefined);
	lib_0A1A::func_2375("throw_zombie_piece_while_moving",undefined,::lib_0C76::func_100AC,undefined);
	lib_0A1A::func_2375("grab_zombie_piece_while_moving",undefined,::lib_0C76::func_1001D,undefined);
	lib_0A1A::func_2375("laser_attack",undefined,::lib_0C76::func_FFF1,undefined);
	lib_0A1A::func_2374("sprint_loop",::lib_0C75::func_D4E3,undefined,undefined,undefined,undefined,::lib_0C76::func_3EC1,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("enter_duck_move",undefined,::lib_0C76::func_1003B,undefined);
	lib_0A1A::func_2375("throw_zombie_piece_while_moving",undefined,::lib_0C76::func_100AC,undefined);
	lib_0A1A::func_2375("laser_attack",undefined,::lib_0C76::func_FFF1,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::func_124F6,undefined);
	lib_0A1A::func_2375("to_put_helmet_on",undefined,::lib_0C76::func_10063,undefined);
	lib_0A1A::func_2375("sprint_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("sprint_turn",undefined,::lib_0F3B::func_FFF8,"sprint_turn");
	lib_0A1A::func_2375("move_done",undefined,::func_1250A,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_12530,undefined);
	lib_0A1A::func_2375("attack_slam",undefined,::lib_0C76::func_FFE2,undefined);
	lib_0A1A::func_2374("run_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_take_helmet_off",undefined,::lib_0C76::func_10069,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("to_melee",undefined,::func_1246B,undefined);
	lib_0A1A::func_2374("sprint_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_put_helmet_on",undefined,::lib_0C76::func_10063,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("to_melee",undefined,::func_1253D,undefined);
	lib_0A1A::func_2374("move_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("run_turn",::lib_0C75::func_D515,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_take_helmet_off",undefined,::lib_0C76::func_10069,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_12480,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("sprint_turn",::lib_0C75::func_D538,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_put_helmet_on",undefined,::lib_0C76::func_10063,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_1254F,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("sprint_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("choose_idle_exit",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("idle_exit_sprint",undefined,::func_11BA9,undefined);
	lib_0A1A::func_2375("idle_exit_run",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle_exit_run",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("idle_exit_sprint",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("sprint_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("to_melee",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee",undefined,::func_125D1,undefined);
	lib_0A1A::func_2374("to_put_helmet_on",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("helmet_place",undefined,::lib_0C76::func_10063,undefined);
	lib_0A1A::func_2374("to_take_helmet_off",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("helmet_remove",undefined,::lib_0C76::func_10069,undefined);
	lib_0A1A::func_2374("duck_move",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C76::func_3EC2,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("to_exit_duck_move",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("enter_duck_move",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C76::func_3EC2,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("should_keep_crouched",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exit_duck_move",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C76::func_3EC2,undefined,undefined,undefined,undefined,undefined,"brute_pain",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("move_done",undefined,::lib_0C75::func_9EAB,undefined);
	lib_0A1A::func_2375("to_take_helmet_off",undefined,::lib_0C76::func_10069,undefined);
	lib_0A1A::func_2375("to_put_helmet_on",undefined,::lib_0C76::func_10063,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::lib_0C73::func_138E4,undefined);
	lib_0A1A::func_2375("anim_ended",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("to_exit_duck_move",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("duck_move",undefined,::lib_0C76::func_1003B,undefined);
	lib_0A1A::func_2375("exit_duck_move",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("should_keep_crouched",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("duck_move",undefined,::lib_0C76::func_1003B,undefined);
	lib_0A1A::func_2375("exit_duck_move",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("to_run",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("run_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("run_loop",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("to_sprint",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("sprint_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("sprint_turn",undefined,::lib_0F3B::func_FFF8,"sprint_turn");
	lib_0A1A::func_2374("anim_ended",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("to_run",undefined,::lib_0C75::func_BE99,undefined);
	lib_0A1A::func_2375("to_sprint",undefined,::lib_0C75::func_BE9A,undefined);
	lib_0A1A::func_2374("brute_intro",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("choose_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_generic",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C76::func_3EC0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_moving",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C76::func_3EC0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_crawling",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("brute_pain",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("croc_chomp_enter",undefined,::lib_0C76::func_FFEB,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("croc_chomp_exit",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C76::func_3EC9,"croc_chomp_exit",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("choose_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("croc_chomp_enter",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C76::func_3EC9,"croc_chomp_enter",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("croc_chomp_exit",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("croc_chomp_loop",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_over_40",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"wall_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("traverse_external",::lib_0C75::func_D563,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_130",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_slow",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_40",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_80",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_across_100",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jumpacross",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_across_196",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_fast",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C76::func_3EC3,"jump_down_fast",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("step_over_40",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_36",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("step_up_40",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("nonboost_jump_up_120",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("boost_jump_up",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_across_100_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jumpacross",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_over_40_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"wall_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_slow_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_40_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("step_over_40_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_36_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("step_up_40_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("nonboost_jump_up_120_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("boost_jump_up_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_across_196_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_40",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpup_120",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_across",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_across_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_40_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpup_120_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("mantle_40_over_extended",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("mantle_40_over_extended_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_128_out_50",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_128_out_50",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_128_out_50_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_128_out_50",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_56_out_50",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_56_out_50",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_56_out_50_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_56_out_50",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_56",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_56_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_128",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_128_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_56",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_56_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C76::func_3EC3,"jump_up_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C76::func_3EC3,"jump_up_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_56_over_40",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_over_30_out_30_down_48",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_over_30_out_30_down_48",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_over_30_out_30_down_48_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_over_30_out_30_down_48",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_56_over_40_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_128",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_56",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_128_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_56_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_384",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_384",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_384_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_384",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_extended",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_extended_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_extended_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_left",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_left",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_left_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_left",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_left_extended",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_left_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_left_extended_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_left_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_right",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_right",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_right_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_right",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_right_extended",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_right_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_right_extended_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_right_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40_out_30",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40_out_30",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40_out_30_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40_out_30",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_fast_norestart",::lib_0C75::func_D567,undefined,undefined,undefined,"choose_movetype",::lib_0C76::func_3EC3,"jump_down_fast",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
func_12253(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 3
func_1223F(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 4
func_1224F(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2941();
}

//Function Number: 5
func_11BB9(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 6
func_11BBE(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2941();
}

//Function Number: 7
func_12210(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 8
func_12207(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 9
func_122A2(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E1();
}

//Function Number: 10
func_1229E(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 11
func_1227B(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_10041();
}

//Function Number: 12
func_12283(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("walk");
}

//Function Number: 13
func_12276(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 14
func_1227D(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("sprint");
}

//Function Number: 15
func_11BEF(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_10041();
}

//Function Number: 16
func_11BEE(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 17
func_11BE1(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE9A();
}

//Function Number: 18
func_11BDA(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 19
func_12437(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BCCD();
}

//Function Number: 20
func_1245A(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 21
func_1242F(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_A013();
}

//Function Number: 22
func_12448(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 23
func_124F6(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BCCD();
}

//Function Number: 24
func_1250A(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 25
func_12530(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 26
func_1246B(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 27
func_1253D(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 28
func_12480(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 29
func_1254F(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 30
func_11BA9(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE9A();
}

//Function Number: 31
func_125D1(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}