/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\alien_goon\mp\states.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 558 ms
 * Timestamp: 10/27/2023 12:01:16 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("alien_goon"))
	{
		return;
	}

	lib_0A1A::func_230B("alien_goon","start_here");
	lib_0A1A::func_2374("start_here",::scripts\asm\alien_goon\alien_goon_asm::asminit,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("entrance",undefined,::scripts\asm\alien_goon\alien_goon_asm::shouldplayentranceanim,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("turn",undefined,::scripts\asm\dlc4\dlc4_asm::shouldturn,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_idle_to_choose_movetype1,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("entrance",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\dlc4\dlc4_asm::choosespawnanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("check_actions",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stand_melee",undefined,::scripts\asm\dlc4\dlc4_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("moving_melee",undefined,::scripts\asm\dlc4\dlc4_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("slide_left",undefined,::scripts\asm\dlc4\dlc4_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("slide_right",undefined,::scripts\asm\dlc4\dlc4_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("taunt",undefined,::scripts\asm\dlc4\dlc4_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("jump_back",undefined,::scripts\asm\dlc4\dlc4_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("stumble",undefined,::scripts\asm\dlc4\dlc4_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("jump",undefined,::scripts\asm\dlc4\dlc4_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("jump_attack",undefined,::scripts\asm\dlc4\dlc4_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("stand_melee",::scripts\asm\dlc4\dlc4_asm::playmeleeattack,undefined,::scripts\asm\dlc4\dlc4_asm::alienmeleenotehandler,::scripts\asm\dlc4\dlc4_asm::terminate_meleeattack,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("action_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_generic",::scripts\asm\dlc4\dlc4_asm::playaliendeathanim,undefined,undefined,undefined,undefined,::lib_0C71::func_3F00,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2374("death_moving",::scripts\asm\dlc4\dlc4_asm::playaliendeathanim,undefined,undefined,undefined,undefined,::lib_0C71::func_3EE2,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2374("check_move",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("idle_exit_sprint",undefined,::trans_check_move_to_idle_exit_sprint0,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle_exit_sprint",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("check_move_interruptions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_sprint_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::trans_pass_sprint_in_to_sprint_loop1,undefined);
	lib_0A1A::func_2374("sprint_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("check_move_interruptions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("sprint_loop",::lib_0C75::func_D4E3,"walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_sprint_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("sprint_stop",undefined,::scripts\asm\dlc4\dlc4_asm::shouldstartarrivalalien,undefined);
	lib_0A1A::func_2375("sprint_turn",undefined,::lib_0F3B::func_FFF8,"walk_turn");
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_sprint_out_to_move_done2,undefined);
	lib_0A1A::func_2374("sprint_stop",::scripts\asm\dlc4\dlc4_asm::playalienarrival,undefined,undefined,::scripts\asm\dlc4\dlc4_asm::terminate_arrival,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("check_move_interruptions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("move_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("choose_movetype",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("check_move",undefined,::trans_choose_movetype_to_check_move0,undefined);
	lib_0A1A::func_2375("move_done",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_run_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("idle_exit_run",undefined,::trans_pass_run_in_to_idle_exit_run1,undefined);
	lib_0A1A::func_2374("run_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("check_move_interruptions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("run_loop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_dodge",undefined,::scripts\asm\alien_goon\alien_goon_asm::wantstododge,undefined);
	lib_0A1A::func_2374("run_stop",::scripts\asm\dlc4\dlc4_asm::playalienarrival,"run",undefined,::scripts\asm\dlc4\dlc4_asm::terminate_arrival,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("check_move_interruptions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("move_done",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pass_run_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("run_stop",undefined,::scripts\asm\dlc4\dlc4_asm::shouldstartarrivalalien,undefined);
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_run_out_to_move_done1,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2374("idle_exit_run",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2375("check_move_interruptions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("check_move_interruptions",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("check_interruptables",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("run_dodge",::scripts\asm\alien_goon\alien_goon_asm::playdodgeanim,"run",undefined,::scripts\asm\alien_goon\alien_goon_asm::terminate_rundodge,undefined,::scripts\asm\alien_goon\alien_goon_asm::choosedodgeanim,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pain_generic",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\dlc4\dlc4_asm::func_3EE4,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pain_moving",::scripts\asm\dlc4\dlc4_asm::playmovingpainanim,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("pain_moving_done",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("decide_idle",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("check_interruptables",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stand_melee",undefined,::scripts\asm\dlc4\dlc4_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("moving_melee",undefined,::scripts\asm\dlc4\dlc4_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("traverse_external",::scripts\asm\dlc4\dlc4_asm::doteleporthack,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("moving_melee",::scripts\asm\dlc4\dlc4_asm::playmovingmeleeattack,undefined,::scripts\asm\dlc4\dlc4_asm::alienmeleenotehandler,::scripts\asm\dlc4\dlc4_asm::terminate_movingmelee,undefined,::scripts\asm\dlc4\dlc4_asm::choosemovingmeleeattack,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("moving_melee_done",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("moving_melee_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_moving_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_pain_moving_done_to_choose_movetype0,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("turn",::scripts\asm\dlc4\dlc4_asm::func_D56A,undefined,undefined,undefined,undefined,::scripts\asm\dlc4\dlc4_asm::func_3F0A,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("slide_left",::scripts\asm\alien_goon\alien_goon_asm::playpostattackmanuever,undefined,undefined,::scripts\asm\dlc4\dlc4_asm::terminate_movingmelee,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("slide_right",::scripts\asm\alien_goon\alien_goon_asm::playpostattackmanuever,undefined,undefined,::scripts\asm\dlc4\dlc4_asm::terminate_movingmelee,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("taunt",::scripts\asm\alien_goon\alien_goon_asm::playpostattackmanuever,undefined,undefined,::scripts\asm\dlc4\dlc4_asm::terminate_movingmelee,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("jump_back",::scripts\asm\alien_goon\alien_goon_asm::playpostattackmanuever,undefined,undefined,::scripts\asm\dlc4\dlc4_asm::terminate_movingmelee,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("stumble",::scripts\asm\alien_goon\alien_goon_asm::playstumble,undefined,undefined,::scripts\asm\dlc4\dlc4_asm::terminate_movingmelee,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\dlc4\dlc4_asm::isanimdone,undefined);
	lib_0A1A::func_2374("jump_in_air",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_launch_down",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_launch_level",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_launch_up",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_launch_arrival",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_land_up",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_land_level",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_land_down",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("alien_jump",::scripts\asm\dlc4\dlc4_asm::doalienjumptraversal,undefined,::scripts\asm\dlc4\dlc4_asm::jumpnotehandler,::scripts\asm\dlc4\dlc4_asm::terminate_jump,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_land_sidewall_high",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_land_sidewall_low",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("attack_leap_swipe",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("attack_leap_swipe_left",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("attack_leap_swipe_right",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump",::scripts\asm\dlc4\dlc4_asm::dojump,undefined,::scripts\asm\dlc4\dlc4_asm::jumpnotehandler,::scripts\asm\dlc4\dlc4_asm::terminate_jump,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\dlc4\dlc4_asm::isalienjumpfinished,undefined);
	lib_0A1A::func_2374("jump_attack",::scripts\asm\dlc4\dlc4_asm::dojumpattack,undefined,undefined,::scripts\asm\dlc4\dlc4_asm::terminate_movingmelee,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\dlc4\dlc4_asm::isalienjumpfinished,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
trans_idle_to_choose_movetype1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 3
trans_check_move_to_idle_exit_sprint0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("sprint");
}

//Function Number: 4
trans_pass_sprint_in_to_sprint_loop1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 5
trans_pass_sprint_out_to_move_done2(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 6
trans_choose_movetype_to_check_move0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 7
trans_pass_run_in_to_idle_exit_run1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 8
trans_pass_run_out_to_move_done1(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 9
trans_pain_moving_done_to_choose_movetype0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}