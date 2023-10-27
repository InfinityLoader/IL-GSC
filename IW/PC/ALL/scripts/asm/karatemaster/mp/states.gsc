/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\karatemaster\mp\states.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 1083 ms
 * Timestamp: 10/27/2023 12:01:46 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("karatemaster"))
	{
		return;
	}

	lib_0A1A::func_230B("karatemaster","karatemaster_start");
	lib_0A1A::func_2374("karatemaster_start",::scripts\asm\karatemaster\karatemaster_asm::karatemasterinit,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("entrance",undefined,::scripts\asm\karatemaster\karatemaster_asm::shouldplayentranceanim,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle",::lib_0F3C::func_B050,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_idle_to_choose_movetype0,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("entrance",::scripts\asm\karatemaster\karatemaster_asm::playspawnin,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\karatemaster\karatemaster_asm::isanimdone,undefined);
	lib_0A1A::func_2374("check_actions",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("teleport_in",undefined,::scripts\asm\karatemaster\karatemaster_asm::teleportrequested,undefined);
	lib_0A1A::func_2375("check_melee",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("stand_melee",::scripts\asm\karatemaster\karatemaster_asm::playanim_melee,undefined,::scripts\asm\karatemaster\karatemaster_asm::meleenotehandler,::scripts\asm\karatemaster\karatemaster_asm::terminate_melee,undefined,::scripts\asm\karatemaster\karatemaster_asm::choosestandmeleeanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,"melee_anim",undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\karatemaster\karatemaster_asm::isanimdone,undefined);
	lib_0A1A::func_2374("action_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("choose_movetype",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("idle_exit_sprint",undefined,::trans_choose_movetype_to_idle_exit_sprint0,undefined);
	lib_0A1A::func_2375("idle_exit_walk",undefined,::trans_choose_movetype_to_idle_exit_walk1,undefined);
	lib_0A1A::func_2375("idle_exit_run",undefined,::trans_choose_movetype_to_idle_exit_run2,undefined);
	lib_0A1A::func_2375("idle_exit_slow_walk",undefined,::trans_choose_movetype_to_idle_exit_slow_walk3,undefined);
	lib_0A1A::func_2374("idle_exit_walk",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pass_walk_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("walk_loop",undefined,::trans_pass_walk_in_to_walk_loop1,undefined);
	lib_0A1A::func_2374("walk_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("walk_loop",::lib_0C75::func_D4E3,"walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_walk_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("check_melee",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("walk_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("walk_turn",undefined,::lib_0F3B::func_FFF8,"walk_turn");
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_walk_out_to_move_done4,undefined);
	lib_0A1A::func_2374("walk_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("move_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("run_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("run_loop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("run_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("idle_exit_run",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"finished");
	lib_0A1A::func_2374("pass_run_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::trans_pass_run_in_to_run_loop1,undefined);
	lib_0A1A::func_2374("pass_run_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("run_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_run_out_to_move_done2,undefined);
	lib_0A1A::func_2375("check_melee",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("sprint_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("sprint_loop",::lib_0C75::func_D4E3,"sprint",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("sprint_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("idle_exit_sprint",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"finished");
	lib_0A1A::func_2374("pass_sprint_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::trans_pass_sprint_in_to_sprint_loop1,undefined);
	lib_0A1A::func_2374("pass_sprint_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_sprint_out_to_move_done0,undefined);
	lib_0A1A::func_2375("sprint_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("sprint_turn",undefined,::lib_0F3B::func_FFF8,"sprint_turn");
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("check_melee",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("slow_walk_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("pass_slow_walk_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_slow_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("slow_walk_loop",undefined,::trans_pass_slow_walk_in_to_slow_walk_loop1,undefined);
	lib_0A1A::func_2374("slow_walk_loop",::lib_0C75::func_D4E3,"sprint",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_slow_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("slow_walk_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_slow_walk_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("slow_walk_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("slow_walk_turn",undefined,::lib_0F3B::func_FFF8,"slow_walk_turn");
	lib_0A1A::func_2375("check_melee",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_slow_walk_out_to_move_done3,undefined);
	lib_0A1A::func_2374("idle_exit_slow_walk",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::lib_0A1A::func_68B0,"finished");
	lib_0A1A::func_2374("pain_generic",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\karatemaster\karatemaster_asm::func_3EE4,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\karatemaster\karatemaster_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pain_moving",::scripts\asm\karatemaster\karatemaster_asm::playmovingpainanim,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("walk_loop",undefined,::scripts\asm\karatemaster\karatemaster_asm::isanimdone,undefined);
	lib_0A1A::func_2374("decide_idle",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_128",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("traverse_external",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("teleport_in",undefined,::scripts\asm\karatemaster\karatemaster_asm::ontraversalteleport,undefined);
	lib_0A1A::func_2374("teleport_in",::scripts\asm\karatemaster\karatemaster_asm::playanim_teleportin,undefined,::scripts\asm\karatemaster\karatemaster_asm::teleportnotehandler,::scripts\asm\karatemaster\karatemaster_asm::terminate_teleport,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("teleport_out",undefined,::scripts\asm\karatemaster\karatemaster_asm::isanimdone,undefined);
	lib_0A1A::func_2374("walk_melee",::scripts\asm\karatemaster\karatemaster_asm::playanim_melee,undefined,::scripts\asm\karatemaster\karatemaster_asm::meleenotehandler,::scripts\asm\karatemaster\karatemaster_asm::terminate_melee,undefined,::scripts\asm\karatemaster\karatemaster_asm::choosemovingmeleeanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,"melee_anim",undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::scripts\asm\karatemaster\karatemaster_asm::isanimdone,undefined);
	lib_0A1A::func_2374("run_melee",::scripts\asm\karatemaster\karatemaster_asm::playanim_melee,undefined,::scripts\asm\karatemaster\karatemaster_asm::meleenotehandler,::scripts\asm\karatemaster\karatemaster_asm::terminate_melee,undefined,::scripts\asm\karatemaster\karatemaster_asm::choosemovingmeleeanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,"melee_anim",undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::scripts\asm\karatemaster\karatemaster_asm::isanimdone,undefined);
	lib_0A1A::func_2374("sprint_melee",::scripts\asm\karatemaster\karatemaster_asm::playanim_melee,undefined,::scripts\asm\karatemaster\karatemaster_asm::meleenotehandler,::scripts\asm\karatemaster\karatemaster_asm::terminate_melee,undefined,::scripts\asm\karatemaster\karatemaster_asm::choosemovingmeleeanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,"melee_anim",undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::scripts\asm\karatemaster\karatemaster_asm::isanimdone,undefined);
	lib_0A1A::func_2374("slow_walk_melee",::scripts\asm\karatemaster\karatemaster_asm::playanim_melee,undefined,::scripts\asm\karatemaster\karatemaster_asm::meleenotehandler,::scripts\asm\karatemaster\karatemaster_asm::terminate_melee,undefined,::scripts\asm\karatemaster\karatemaster_asm::choosemovingmeleeanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,"melee_anim",undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::scripts\asm\karatemaster\karatemaster_asm::isanimdone,undefined);
	lib_0A1A::func_2374("check_melee",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stand_melee",undefined,::scripts\asm\karatemaster\karatemaster_asm::shoulddomelee,undefined);
	lib_0A1A::func_2375("sprint_melee",undefined,::scripts\asm\karatemaster\karatemaster_asm::shoulddomelee,undefined);
	lib_0A1A::func_2375("run_melee",undefined,::scripts\asm\karatemaster\karatemaster_asm::shoulddomelee,undefined);
	lib_0A1A::func_2375("walk_melee",undefined,::scripts\asm\karatemaster\karatemaster_asm::shoulddomelee,undefined);
	lib_0A1A::func_2375("slow_walk_melee",undefined,::scripts\asm\karatemaster\karatemaster_asm::shoulddomelee,undefined);
	lib_0A1A::func_2374("teleport_out",::scripts\asm\karatemaster\karatemaster_asm::playanim_teleportout,undefined,::scripts\asm\karatemaster\karatemaster_asm::teleportnotehandler,::scripts\asm\karatemaster\karatemaster_asm::terminate_teleport,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"teleport_anim","face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\karatemaster\karatemaster_asm::isanimdone,undefined);
	lib_0A1A::func_2374("death_normal",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::scripts\asm\zombie_dlc2\zombie_dlc2::choosestandingdeathanim_dlc,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_moving_normal",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3F00,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_generic",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_normal",undefined,::trans_death_generic_to_death_normal0,undefined);
	lib_0A1A::func_2375("death_kungfu",undefined,::trans_death_generic_to_death_kungfu1,undefined);
	lib_0A1A::func_2375("death_normal",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_moving",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_moving_normal",undefined,::trans_death_moving_to_death_moving_normal0,undefined);
	lib_0A1A::func_2375("death_kungfu",undefined,::trans_death_moving_to_death_kungfu1,undefined);
	lib_0A1A::func_2375("death_moving_normal",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_kungfu",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3F00,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
trans_idle_to_choose_movetype0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 3
trans_choose_movetype_to_idle_exit_sprint0(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE9A();
}

//Function Number: 4
trans_choose_movetype_to_idle_exit_walk1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("walk");
}

//Function Number: 5
trans_choose_movetype_to_idle_exit_run2(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 6
trans_choose_movetype_to_idle_exit_slow_walk3(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("slow_walk");
}

//Function Number: 7
trans_pass_walk_in_to_walk_loop1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 8
trans_pass_walk_out_to_move_done4(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 9
trans_pass_run_in_to_run_loop1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 10
trans_pass_run_out_to_move_done2(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 11
trans_pass_sprint_in_to_sprint_loop1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 12
trans_pass_sprint_out_to_move_done0(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 13
trans_pass_slow_walk_in_to_slow_walk_loop1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 14
trans_pass_slow_walk_out_to_move_done3(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 15
trans_death_generic_to_death_normal0(param_00,param_01,param_02,param_03)
{
	return self.agent_type == "skater";
}

//Function Number: 16
trans_death_generic_to_death_kungfu1(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.kung_fu_punched);
}

//Function Number: 17
trans_death_moving_to_death_moving_normal0(param_00,param_01,param_02,param_03)
{
	return self.agent_type == "skater";
}

//Function Number: 18
trans_death_moving_to_death_kungfu1(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.kung_fu_punched);
}