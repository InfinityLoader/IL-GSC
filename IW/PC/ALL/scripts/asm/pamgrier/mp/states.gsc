/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\pamgrier\mp\states.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 1112 ms
 * Timestamp: 10/27/2023 12:02:00 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("pamgrier"))
	{
		return;
	}

	lib_0A1A::func_230B("pamgrier","pamgrier_start");
	lib_0A1A::func_2374("pamgrier_start",::scripts\asm\pamgrier\pamgrier_asm::pamgrierinit,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("entrance",undefined,::scripts\asm\pamgrier\pamgrier_asm::shouldplayentranceanim,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle",::lib_0F3C::func_B050,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("check_move",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("idle_turn",undefined,::scripts\asm\pamgrier\pamgrier_asm::func_BEA0,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("chill_idle",undefined,::scripts\asm\pamgrier\pamgrier_asm::ispamchillin,undefined);
	lib_0A1A::func_2374("entrance",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\pamgrier\pamgrier_asm::isanimdone,undefined);
	lib_0A1A::func_2374("check_actions",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("revive_player",undefined,::scripts\asm\pamgrier\pamgrier_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::scripts\asm\pamgrier\pamgrier_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("teleport",undefined,::scripts\asm\pamgrier\pamgrier_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("melee_attack",::scripts\asm\pamgrier\pamgrier_asm::playmeleeattack,undefined,::scripts\asm\pamgrier\pamgrier_asm::meleenotehandler,undefined,undefined,::scripts\asm\pamgrier\pamgrier_asm::choosemeleeattack,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\pamgrier\pamgrier_asm::isanimdone,undefined);
	lib_0A1A::func_2374("action_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_generic",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3F00,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_moving",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3EE2,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("check_move",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("check_idle_exit",undefined,::trans_check_move_to_check_idle_exit0,undefined);
	lib_0A1A::func_2374("idle_exit_walk",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("check_interruptables",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_walk_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("walk_loop",undefined,::trans_pass_walk_in_to_walk_loop1,undefined);
	lib_0A1A::func_2374("walk_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("check_interruptables",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("walk_loop",::lib_0C75::func_D4E3,"walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_walk_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_pass_walk_out_to_choose_movetype0,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("walk_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("walk_turn",undefined,::lib_0F3B::func_FFF8,"walk_turn");
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_walk_out_to_move_done4,undefined);
	lib_0A1A::func_2374("walk_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("check_interruptables",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("move_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("choose_movetype",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_walk_in",undefined,::trans_choose_movetype_to_pass_walk_in0,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::trans_choose_movetype_to_pass_run_in1,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::trans_choose_movetype_to_pass_sprint_in2,undefined);
	lib_0A1A::func_2374("idle_exit_sprint",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("idle_exit_run",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("check_idle_exit",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("idle_exit_walk",undefined,::trans_check_idle_exit_to_idle_exit_walk0,undefined);
	lib_0A1A::func_2375("idle_exit_run",undefined,::trans_check_idle_exit_to_idle_exit_run1,undefined);
	lib_0A1A::func_2375("idle_exit_sprint",undefined,::trans_check_idle_exit_to_idle_exit_sprint2,undefined);
	lib_0A1A::func_2374("pass_run_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::trans_pass_run_in_to_run_loop1,undefined);
	lib_0A1A::func_2374("run_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("run_loop",::lib_0C75::func_D4E3,"walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("run_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("pass_run_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_pass_run_out_to_choose_movetype0,undefined);
	lib_0A1A::func_2375("run_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_run_out_to_move_done3,undefined);
	lib_0A1A::func_2374("pass_sprint_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::trans_pass_sprint_in_to_sprint_loop1,undefined);
	lib_0A1A::func_2374("sprint_loop",::lib_0C75::func_D4E3,"walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("sprint_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("pass_sprint_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_pass_sprint_out_to_choose_movetype0,undefined);
	lib_0A1A::func_2375("sprint_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("sprint_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_sprint_out_to_move_done3,undefined);
	lib_0A1A::func_2374("sprint_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_generic",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\pamgrier\pamgrier_asm::func_3EE4,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\pamgrier\pamgrier_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pain_moving",::scripts\asm\pamgrier\pamgrier_asm::playmovingpainanim,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("walk_loop",undefined,::scripts\asm\pamgrier\pamgrier_asm::isanimdone,undefined);
	lib_0A1A::func_2374("decide_idle",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("chill_idle",undefined,::scripts\asm\pamgrier\pamgrier_asm::ispamchillin,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("check_interruptables",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_attack",undefined,::scripts\asm\pamgrier\pamgrier_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("jump_across_196",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_56_over_40",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_over_30_out_30_down_48",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_over_30_out_30_down_48",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_128",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_56",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40_out_30",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40_out_30",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_across_196_norestart",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40_norestart",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_56_over_40_norestart",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_over_30_out_30_down_48_norestart",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_over_30_out_30_down_48",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_128_norestart",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_56_norestart",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40_out_30_norestart",::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40_out_30",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("traverse_external",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("chill_idle",::scripts\asm\pamgrier\pamgrier_asm::playchillinanim,undefined,undefined,undefined,undefined,::scripts\asm\pamgrier\pamgrier_asm::choosechillinidle,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\pamgrier\pamgrier_asm::ispamdonechillin,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("chill_passive_transition",undefined,::scripts\asm\pamgrier\pamgrier_asm::needschilltransition,undefined);
	lib_0A1A::func_2375("chill_twitch",undefined,::scripts\asm\pamgrier\pamgrier_asm::shouldplaychilltwitch,undefined);
	lib_0A1A::func_2374("teleport",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("idle_turn",undefined,::scripts\asm\pamgrier\pamgrier_asm::func_BEA0,undefined);
	lib_0A1A::func_2375("teleport_in",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("teleport_in",::scripts\asm\pamgrier\pamgrier_asm::playteleportin,undefined,undefined,undefined,undefined,::scripts\asm\pamgrier\pamgrier_asm::chooseteleportinanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("teleport_out",undefined,::scripts\asm\pamgrier\pamgrier_asm::isanimdone,undefined);
	lib_0A1A::func_2374("teleport_out",::scripts\asm\pamgrier\pamgrier_asm::playteleportout,undefined,::scripts\asm\pamgrier\pamgrier_asm::meleenotehandler,undefined,undefined,::scripts\asm\pamgrier\pamgrier_asm::chooseteleportoutanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("teleport_done",undefined,::scripts\asm\pamgrier\pamgrier_asm::isanimdone,undefined);
	lib_0A1A::func_2374("revive_player_loop",::scripts\asm\pamgrier\pamgrier_asm::playreviveanim,undefined,undefined,undefined,undefined,::scripts\asm\pamgrier\pamgrier_asm::choosereviveanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("revive_player_outro",undefined,::scripts\asm\pamgrier\pamgrier_asm::isrevivedone,undefined);
	lib_0A1A::func_2374("teleport_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("revive_player_loop",undefined,::trans_teleport_done_to_revive_player_loop0,undefined);
	lib_0A1A::func_2375("chill_idle",undefined,::scripts\asm\pamgrier\pamgrier_asm::ispamchillin,undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("revive_player",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("revive_player_intro",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("revive_player_intro",::scripts\asm\pamgrier\pamgrier_asm::playreviveanim,undefined,undefined,undefined,undefined,::scripts\asm\pamgrier\pamgrier_asm::choosereviveanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("revive_player_loop",undefined,::scripts\asm\pamgrier\pamgrier_asm::isanimdone,undefined);
	lib_0A1A::func_2374("revive_player_outro",::scripts\asm\pamgrier\pamgrier_asm::playreviveanim,undefined,undefined,undefined,undefined,::scripts\asm\pamgrier\pamgrier_asm::choosereviveanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\pamgrier\pamgrier_asm::isanimdone,undefined);
	lib_0A1A::func_2374("idle_turn",::scripts\asm\pamgrier\pamgrier_asm::func_D56A,undefined,undefined,undefined,undefined,::scripts\asm\pamgrier\pamgrier_asm::func_3F0A,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("idle_turn_done",undefined,::scripts\asm\pamgrier\pamgrier_asm::isanimdone,undefined);
	lib_0A1A::func_2374("idle_turn_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("teleport_in",undefined,::scripts\asm\pamgrier\pamgrier_asm::shoulddoaction,"teleport");
	lib_0A1A::func_2374("chill_passive_transition",::scripts\asm\pamgrier\pamgrier_asm::playchillpassivetransition,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("chill_idle",undefined,::scripts\asm\pamgrier\pamgrier_asm::isanimdone,undefined);
	lib_0A1A::func_2374("chill_twitch",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\pamgrier\pamgrier_asm::choosechillinidle,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("chill_idle",undefined,::scripts\asm\pamgrier\pamgrier_asm::isanimdone,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
trans_check_move_to_check_idle_exit0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 3
trans_pass_walk_in_to_walk_loop1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 4
trans_pass_walk_out_to_choose_movetype0(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BCCD();
}

//Function Number: 5
trans_pass_walk_out_to_move_done4(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 6
trans_choose_movetype_to_pass_walk_in0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("walk");
}

//Function Number: 7
trans_choose_movetype_to_pass_run_in1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 8
trans_choose_movetype_to_pass_sprint_in2(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("sprint");
}

//Function Number: 9
trans_check_idle_exit_to_idle_exit_walk0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("walk");
}

//Function Number: 10
trans_check_idle_exit_to_idle_exit_run1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 11
trans_check_idle_exit_to_idle_exit_sprint2(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("sprint");
}

//Function Number: 12
trans_pass_run_in_to_run_loop1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 13
trans_pass_run_out_to_choose_movetype0(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BCCD();
}

//Function Number: 14
trans_pass_run_out_to_move_done3(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 15
trans_pass_sprint_in_to_sprint_loop1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 16
trans_pass_sprint_out_to_choose_movetype0(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BCCD();
}

//Function Number: 17
trans_pass_sprint_out_to_move_done3(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 18
trans_teleport_done_to_revive_player_loop0(param_00,param_01,param_02,param_03)
{
	return isdefined(self.teleporttype) && self.teleporttype == "revive_player";
}