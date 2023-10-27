/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\crab_brute\mp\states.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 492 ms
 * Timestamp: 10/27/2023 12:01:27 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("crab_brute"))
	{
		return;
	}

	lib_0A1A::func_230B("crab_brute","start_here");
	lib_0A1A::func_2374("start_here",::scripts\asm\crab_brute\crab_brute_asm::asminit,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("entrance",undefined,::scripts\asm\crab_brute\crab_brute_asm::shouldplayentranceanim,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_idle_to_choose_movetype0,undefined);
	lib_0A1A::func_2375("turn",undefined,::scripts\asm\crab_brute\crab_brute_asm::shouldturn,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("entrance",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("check_actions",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("tired",undefined,::scripts\asm\crab_brute\crab_brute_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("taunt",undefined,::scripts\asm\crab_brute\crab_brute_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::scripts\asm\crab_brute\crab_brute_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("burrow",undefined,::scripts\asm\crab_brute\crab_brute_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("charge",undefined,::scripts\asm\crab_brute\crab_brute_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("summon",undefined,::scripts\asm\crab_brute\crab_brute_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("flash",undefined,::scripts\asm\crab_brute\crab_brute_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("melee_attack",::scripts\asm\crab_brute\crab_brute_asm::playmeleeattack,undefined,::scripts\asm\crab_brute\crab_brute_asm::meleenotehandler,undefined,undefined,::scripts\asm\crab_brute\crab_brute_asm::choosemeleeattack,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("action_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_generic",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3F00,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_moving",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3EE2,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("check_move",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_run_in",undefined,::trans_check_move_to_pass_run_in0,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("move_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("choose_movetype",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("check_move",undefined,::trans_choose_movetype_to_check_move0,undefined);
	lib_0A1A::func_2375("move_done",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_run_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("idle_exit_run",undefined,::trans_pass_run_in_to_idle_exit_run1,undefined);
	lib_0A1A::func_2374("run_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,"code_move_slide",undefined);
	lib_0A1A::func_2375("check_move_interruption",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("run_loop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("check_shield",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("run_stop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("move_done",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2375("check_move_interruption",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_run_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("run_stop",undefined,::scripts\asm\crab_brute\crab_brute_asm::shouldcrabbrutestartarrival,undefined);
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_run_out_to_move_done1,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2374("idle_exit_run",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2375("check_move_interruption",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_sprint_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("idle_exit_sprint",undefined,::trans_pass_sprint_in_to_idle_exit_sprint1,undefined);
	lib_0A1A::func_2374("sprint_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("check_move_interruption",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("sprint_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("sprint_loop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("check_shield",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("move_done",undefined,::trans_sprint_loop_to_move_done2,undefined);
	lib_0A1A::func_2374("sprint_stop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("move_done",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2375("check_move_interruption",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_sprint_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("sprint_stop",undefined,::scripts\asm\crab_brute\crab_brute_asm::shouldcrabbrutestartarrival,undefined);
	lib_0A1A::func_2375("sprint_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2374("idle_exit_sprint",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2375("check_move_interruption",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("check_move_interruption",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("check_interruptables",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("shield_run_loop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::scripts\asm\crab_brute\crab_brute_asm::shouldstopshield,undefined);
	lib_0A1A::func_2374("check_shield",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shield_run_loop",undefined,::scripts\asm\crab_brute\crab_brute_asm::shoulddoshield,undefined);
	lib_0A1A::func_2374("pain_generic",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\crab_brute\crab_brute_asm::func_3EE4,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pain_moving",::scripts\asm\crab_brute\crab_brute_asm::playmovingpainanim,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_pain_moving_to_choose_movetype0,undefined);
	lib_0A1A::func_2374("decide_idle",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("check_interruptables",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_attack",undefined,::scripts\asm\crab_brute\crab_brute_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("jump_across",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_across_100",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jumpacross",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_56",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_128",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_56_over_40",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_over_40_flex",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"wall_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_88",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_88",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("step_over_40",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("mantle_40_over_extended",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"mantle_40_over_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_over_40",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"wall_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_56",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_56",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_128",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_56_out_50",::scripts\asm\zombie_dlc3\zombie_dlc3::playtraverseanimz_dlc,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("traverse_external",::scripts\asm\crab_brute\crab_brute_asm::doteleporthack,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("burrow_loop",::scripts\asm\crab_brute\crab_brute_asm::playanimwithplaybackrate,2,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("burrow_outro",undefined,::scripts\asm\crab_brute\crab_brute_asm::shouldabortaction,"burrow");
	lib_0A1A::func_2374("burrow",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("burrow_intro",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("burrow_intro",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_brute\crab_brute_asm::crabbrutenotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("burrow_loop",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("burrow_outro",::scripts\asm\crab_brute\crab_brute_asm::playburrowoutro,undefined,::scripts\asm\crab_brute\crab_brute_asm::crabbrutenotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("charge",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("charge_intro",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("charge_intro",::scripts\asm\crab_brute\crab_brute_asm::playchargeintro,undefined,::scripts\asm\crab_brute\crab_brute_asm::crabbrutenotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("charge_loop",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("charge_loop",::scripts\asm\crab_brute\crab_brute_asm::playchargeloop,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","code_move",undefined);
	lib_0A1A::func_2375("charge_outro",undefined,::scripts\asm\crab_brute\crab_brute_asm::shouldabortaction,"charge");
	lib_0A1A::func_2374("charge_outro",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_brute\crab_brute_asm::crabbrutenotehandler,undefined,undefined,::scripts\asm\crab_brute\crab_brute_asm::choosechargeoutroanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("tired",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_tired",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("tired_transition",undefined,::scripts\asm\crab_brute\crab_brute_asm::shouldabortaction,"tired");
	lib_0A1A::func_2374("summon",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_brute\crab_brute_asm::summonnotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("flash",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_brute\crab_brute_asm::crabbrutenotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("turn",::scripts\asm\crab_brute\crab_brute_asm::playanimwithplaybackrate,1.5,undefined,undefined,undefined,::scripts\asm\crab_brute\crab_brute_asm::choosecrabbruteturnanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pain_tired",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\crab_brute\crab_brute_asm::func_3EE4,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("tired",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("tired_transition",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2374("taunt",::scripts\asm\crab_brute\crab_brute_asm::playanimandlookatenemy,undefined,::scripts\asm\crab_brute\crab_brute_asm::crabbrutenotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_brute\crab_brute_asm::isanimdone,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
trans_idle_to_choose_movetype0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 3
trans_check_move_to_pass_run_in0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 4
trans_choose_movetype_to_check_move0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 5
trans_pass_run_in_to_idle_exit_run1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 6
trans_pass_run_out_to_move_done1(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 7
trans_pass_sprint_in_to_idle_exit_sprint1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 8
trans_sprint_loop_to_move_done2(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 9
trans_pain_moving_to_choose_movetype0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}