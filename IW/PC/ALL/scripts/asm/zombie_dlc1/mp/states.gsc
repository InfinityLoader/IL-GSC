/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\zombie_dlc1\mp\states.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 147
 * Decompile Time: 8151 ms
 * Timestamp: 10/27/2023 12:02:29 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("zombie_dlc1"))
	{
		return;
	}

	lib_0A1A::func_230B("zombie_dlc1","zombiestart");
	lib_0A1A::func_2374("zombiestart",::lib_0C75::func_13F9A,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("suicide_bomber_checks",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("traverse_window",undefined,::lib_0C75::func_BE94,undefined);
	lib_0A1A::func_2375("play_melee_anim",undefined,::lib_0C75::func_BE95,undefined);
	lib_0A1A::func_2375("moveto_window_done",undefined,::lib_0C75::func_DD1E,undefined);
	lib_0A1A::func_2375("waiting",undefined,::lib_0C75::func_9FF5,undefined);
	lib_0A1A::func_2375("melee",undefined,::func_12255,undefined);
	lib_0A1A::func_2375("boombox",undefined,::lib_0C75::func_6BC6,undefined);
	lib_0A1A::func_2375("choose_idle_exit",undefined,::trans_idle_to_choose_idle_exit7,undefined);
	lib_0A1A::func_2375("frozen_idle",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("choose_idle",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("boombox",undefined,::lib_0C75::func_6BC6,undefined);
	lib_0A1A::func_2375("play_spawn_fx",undefined,::func_11BC9,undefined);
	lib_0A1A::func_2375("play_vignette_anim",undefined,::func_11BCD,undefined);
	lib_0A1A::func_2375("choose_idle_exit",undefined,::func_11BBA,undefined);
	lib_0A1A::func_2375("idle_crawl",undefined,::func_11BC5,undefined);
	lib_0A1A::func_2375("idle_combat",undefined,::func_11BC0,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle_combat",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face goal","anim deltas",undefined);
	lib_0A1A::func_2375("suicide_bomber_checks",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("boombox",undefined,::lib_0C75::func_6BC6,undefined);
	lib_0A1A::func_2375("traverse_window",undefined,::lib_0C75::func_BE94,undefined);
	lib_0A1A::func_2375("play_melee_anim",undefined,::lib_0C75::func_BE95,undefined);
	lib_0A1A::func_2375("moveto_window_done",undefined,::lib_0C75::func_DD1E,undefined);
	lib_0A1A::func_2375("choose_idle",undefined,::func_12203,undefined);
	lib_0A1A::func_2375("choose_idle",undefined,::func_12204,undefined);
	lib_0A1A::func_2375("waiting",undefined,::lib_0C75::func_9FF5,undefined);
	lib_0A1A::func_2375("choose_idle_exit",undefined,::func_12208,undefined);
	lib_0A1A::func_2375("melee",undefined,::func_12212,undefined);
	lib_0A1A::func_2375("frozen_idle",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("idle_crawl",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("suicide_bomber_checks",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("boombox",undefined,::lib_0C75::func_6BC6,undefined);
	lib_0A1A::func_2375("traverse_window",undefined,::lib_0C75::func_BE94,undefined);
	lib_0A1A::func_2375("moveto_window_done",undefined,::lib_0C75::func_DD1E,undefined);
	lib_0A1A::func_2375("waiting",undefined,::lib_0C75::func_9FF5,undefined);
	lib_0A1A::func_2375("idle_exit_crawl",undefined,::func_1221D,undefined);
	lib_0A1A::func_2375("melee",undefined,::func_12222,undefined);
	lib_0A1A::func_2375("frozen_idle",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("frozen_idle",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_idle",undefined,::lib_0C75::func_3E18,undefined);
	lib_0A1A::func_2374("play_vignette_anim",::lib_0C75::func_D571,undefined,undefined,::lib_0C75::func_11702,undefined,::lib_0C75::func_3EFC,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0C75::func_1003A,undefined);
	lib_0A1A::func_2375("choose_idle",undefined,::func_12404,undefined);
	lib_0A1A::func_2374("boombox",::lib_0C75::func_CEF3,undefined,undefined,undefined,undefined,::lib_0C75::func_3EBE,undefined,["(none)"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_idle",undefined,::lib_0C75::func_9DC8,undefined);
	lib_0A1A::func_2375("boombox_turn",undefined,::lib_0C75::func_BE8D,undefined);
	lib_0A1A::func_2375("frozen_idle",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("boombox_turn",::lib_0C75::func_CEF3,undefined,undefined,undefined,undefined,::lib_0C75::func_3EBE,undefined,["(none)"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("boombox",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("high_damage",undefined,::func_120B4,undefined);
	lib_0A1A::func_2375("normal_damage",undefined,::trans_dismember_to_normal_damage1,undefined);
	lib_0A1A::func_2374("right_arm",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dismember_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("right_arm_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dismember_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("right_arm_walk",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dismember_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("right_arm_run",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dismember_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("right_arm_walk_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("right_arm_run_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dismember_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("left_arm",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dismember_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("left_arm_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dismember_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("left_arm_walk",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dismember_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("left_arm_run",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dismember_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("left_arm_walk_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dismember_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("left_arm_run_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dismember_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("left_leg",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("left_leg_run",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("left_leg_walk_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("left_leg_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("left_leg_walk",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("right_leg",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("right_leg_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("right_leg_walk",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("right_leg_run",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("right_leg_walk_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("right_leg_run_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("high_damage",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("both_legs_highdamage",undefined,::func_121B4,undefined);
	lib_0A1A::func_2375("right_arm_walk_highdamage",undefined,::func_121EA,undefined);
	lib_0A1A::func_2375("right_arm_walk_highdamage",undefined,::func_121EB,undefined);
	lib_0A1A::func_2375("right_arm_run_highdamage",undefined,::func_121E3,undefined);
	lib_0A1A::func_2375("right_arm_run_highdamage",undefined,::func_121E4,undefined);
	lib_0A1A::func_2375("right_leg_walk_highdamage",undefined,::func_121FE,undefined);
	lib_0A1A::func_2375("right_leg_walk_highdamage",undefined,::func_121FF,undefined);
	lib_0A1A::func_2375("right_leg_run_highdamage",undefined,::func_121F6,undefined);
	lib_0A1A::func_2375("right_leg_run_highdamage",undefined,::func_121F7,undefined);
	lib_0A1A::func_2375("left_leg_run_highdamage",undefined,::func_121D0,undefined);
	lib_0A1A::func_2375("left_leg_run_highdamage",undefined,::func_121D1,undefined);
	lib_0A1A::func_2375("left_leg_walk_highdamage",undefined,::func_121D8,undefined);
	lib_0A1A::func_2375("left_leg_walk_highdamage",undefined,::func_121D9,undefined);
	lib_0A1A::func_2375("left_arm_run_highdamage",undefined,::func_121BE,undefined);
	lib_0A1A::func_2375("left_arm_run_highdamage",undefined,::func_121BF,undefined);
	lib_0A1A::func_2375("left_arm_walk_highdamage",undefined,::func_121C4,undefined);
	lib_0A1A::func_2375("left_arm_walk_highdamage",undefined,::func_121C5,undefined);
	lib_0A1A::func_2375("right_arm_highdamage",undefined,::func_121DE,undefined);
	lib_0A1A::func_2375("right_leg_highdamage",undefined,::func_121F0,undefined);
	lib_0A1A::func_2375("left_leg_highdamage",undefined,::func_121CA,undefined);
	lib_0A1A::func_2375("left_arm_highdamage",undefined,::func_121B9,undefined);
	lib_0A1A::func_2374("left_leg_run_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("normal_damage",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("both_legs",undefined,::func_122F3,undefined);
	lib_0A1A::func_2375("right_arm_walk",undefined,::func_12329,undefined);
	lib_0A1A::func_2375("right_arm_walk",undefined,::func_1232A,undefined);
	lib_0A1A::func_2375("right_arm_run",undefined,::func_12322,undefined);
	lib_0A1A::func_2375("right_arm_run",undefined,::func_12323,undefined);
	lib_0A1A::func_2375("right_leg_walk",undefined,::func_1233D,undefined);
	lib_0A1A::func_2375("right_leg_walk",undefined,::func_1233E,undefined);
	lib_0A1A::func_2375("right_leg_run",undefined,::func_12335,undefined);
	lib_0A1A::func_2375("right_leg_run",undefined,::func_12336,undefined);
	lib_0A1A::func_2375("left_arm_walk",undefined,::func_12303,undefined);
	lib_0A1A::func_2375("left_arm_walk",undefined,::func_12304,undefined);
	lib_0A1A::func_2375("left_arm_run",undefined,::func_122FD,undefined);
	lib_0A1A::func_2375("left_arm_run",undefined,::func_122FE,undefined);
	lib_0A1A::func_2375("left_leg_walk",undefined,::func_12317,undefined);
	lib_0A1A::func_2375("left_leg_walk",undefined,::func_12318,undefined);
	lib_0A1A::func_2375("left_leg_run",undefined,::func_1230F,undefined);
	lib_0A1A::func_2375("left_leg_run",undefined,::func_12310,undefined);
	lib_0A1A::func_2375("right_leg",undefined,::func_1232F,undefined);
	lib_0A1A::func_2375("right_arm",undefined,::func_1231D,undefined);
	lib_0A1A::func_2375("left_leg",undefined,::func_12309,undefined);
	lib_0A1A::func_2375("left_arm",undefined,::func_122F8,undefined);
	lib_0A1A::func_2374("both_legs_highdamage",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("both_legs",::lib_0C72::func_CF1B,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("dismemberment_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismemberment_transition_done",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_idle",0,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("dismember_interrupt",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee",undefined,::func_1208A,undefined);
	lib_0A1A::func_2374("pain_stand",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0C75::func_3EF1,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("pain_stand_freeze_check",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("choose_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_stand_lower",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0C75::func_3EF1,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("pain_stand_freeze_check",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("choose_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_stand_head",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0C75::func_3EF1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("pain_stand_freeze_check",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("choose_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("frozen_idle",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_walk",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0C75::func_3EF1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pain_walk_freeze_check",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_walk_lower",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0C75::func_3EF1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pain_walk_freeze_check",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_run",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0C75::func_3EF1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pain_run_freeze_check",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_run_lower",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0C75::func_3EF1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pain_run_freeze_check",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_sprint",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0C75::func_3EF1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pain_sprint_freeze_check",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_sprint_lower",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0C75::func_3EF1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pain_sprint_freeze_check",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_knockback_front",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_knockback_left",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_knockback_right",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_knockback_back",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_generic",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_to_zapper_sequence",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("pain_crawl",undefined,::func_12379,undefined);
	lib_0A1A::func_2375("pain_stand_head",undefined,::func_12385,undefined);
	lib_0A1A::func_2375("pain_stand_lower",undefined,::func_1238B,undefined);
	lib_0A1A::func_2375("pain_stand",undefined,::func_1237F,undefined);
	lib_0A1A::func_2374("pain_moving",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_to_zapper_sequence",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("pain_crawl",undefined,::func_123B7,undefined);
	lib_0A1A::func_2375("pain_moving_nostop",undefined,::func_123BD,undefined);
	lib_0A1A::func_2375("pain_stand_head",undefined,::func_123C9,undefined);
	lib_0A1A::func_2375("pain_stand",undefined,::func_123C3,undefined);
	lib_0A1A::func_2374("pain_moving_nostop",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_sprint_lower",undefined,::func_123A4,undefined);
	lib_0A1A::func_2375("pain_sprint",undefined,::func_1239E,undefined);
	lib_0A1A::func_2375("pain_run_lower",undefined,::func_12399,undefined);
	lib_0A1A::func_2375("pain_run",undefined,::func_12392,undefined);
	lib_0A1A::func_2375("pain_walk",undefined,::func_123AA,undefined);
	lib_0A1A::func_2375("pain_walk",undefined,::func_123AB,undefined);
	lib_0A1A::func_2374("pain_crawl",::lib_0C75::func_D4F5,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("pain_crawl_freeze_check",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_interrupt",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_to_zapper_sequence",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("melee",undefined,::lib_0C75::func_1002F,undefined);
	lib_0A1A::func_2374("pain_moving_shamble",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_to_zapper_sequence",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("pain_crawl",undefined,::func_123B4,undefined);
	lib_0A1A::func_2375("pain_stand",undefined,::func_123B5,undefined);
	lib_0A1A::func_2375("pain_shamble_left",0.1,::lib_0C75::func_9DB2,undefined);
	lib_0A1A::func_2375("pain_shamble_right",0.1,::lib_0C75::func_9DB3,undefined);
	lib_0A1A::func_2375("pain_shamble_head",0.1,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_shamble_head",::lib_0C75::func_D4F3,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_shamble_left",::lib_0C75::func_D4F3,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_shamble_right",::lib_0C75::func_D4F3,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_moving_walk",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_to_zapper_sequence",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("pain_crawl",undefined,::func_123CE,undefined);
	lib_0A1A::func_2375("pain_stand",undefined,::func_123CF,undefined);
	lib_0A1A::func_2375("pain_walk_left",0.1,::lib_0C75::func_9DB2,undefined);
	lib_0A1A::func_2375("pain_walk_right",0.1,::lib_0C75::func_9DB3,undefined);
	lib_0A1A::func_2375("pain_walk_head",0.1,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_walk_head",::lib_0C75::func_D4F3,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_walk_left",::lib_0C75::func_D4F3,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_walk_right",::lib_0C75::func_D4F3,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_interrupt",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_to_zapper_sequence",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",1);
	lib_0A1A::func_2374("pain_stand_freeze_check",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("frozen_idle",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("pain_walk_freeze_check",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("frozen_walk",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("pain_run_freeze_check",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("frozen_run",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("pain_sprint_freeze_check",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("frozen_sprint",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("pain_crawl_freeze_check",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("frozen_crawl",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("death_generic_standing",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::scripts\asm\zombie_dlc1\zombie_dlc1::choosestandingdeathanim_dlc1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_moving_standing",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::scripts\asm\zombie_dlc1\zombie_dlc1::choosemovingdeathanim_dlc1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_crawling",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_generic",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_crawling",undefined,::trans_death_generic_to_death_crawling0,undefined);
	lib_0A1A::func_2375("death_generic_standing",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_moving",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_crawling",undefined,::trans_death_moving_to_death_crawling0,undefined);
	lib_0A1A::func_2375("death_moving_standing",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("wall_over_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"wall_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("traverse_external",::lib_0C75::func_D563,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_across_100",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jumpacross",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("step_over_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_36",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("step_up_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_wall_over_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"wall_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_across_100",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jumpacross",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_step_over_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_window_over_36",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_step_up_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("mantle_40_over_extended",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_128_out_50",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_128_out_50",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_56_out_50",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_56_out_50",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_56",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_128",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_56",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_56_over_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_over_30_out_30_down_48",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_over_30_out_30_down_48",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_over_30_out_30_down_48",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_over_30_out_30_down_48",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_down_56_out_50",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_56_out_50",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_mantle_40_over_extended",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_down_128_out_50",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_128_out_50",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_up_56",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_up_128",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_down_128",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_down_56",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_up_128_over_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_up_56_over_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_56_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_128",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("over_40_down_56",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_over_40_down_128",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_128",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_over_40_down_56",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"over_40_down_56",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_down_384",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_384",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_down_384",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_down_384",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_extended",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_left",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_left",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_left_extended",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_left_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_right",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_right",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40_right_extended",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_right_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_window_over_40",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_window_over_40_extended",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_window_over_40_left",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_left",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_window_over_40_left_extended",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_left_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_window_over_40_right",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_right",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_window_over_40_right_extended",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"window_over_40_right_extended",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_up_128_over_40_out_30",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40_out_30",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_up_128_over_40_out_30",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jump_up_128_over_40_out_30",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_over_40_flex",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"wall_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_wall_over_40_flex",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"wall_over_40",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("zipline",::scripts\asm\zombie_dlc1\zipline_traversal::playtraversezipline,undefined,undefined,::scripts\asm\zombie_dlc1\zipline_traversal::terminateziplineintro,undefined,::scripts\asm\zombie_dlc1\zipline_traversal::chooseanimzipline,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("zipline_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("zipline_loop",::scripts\asm\zombie_dlc1\zipline_traversal::playtraverseziplineloop,undefined,undefined,::scripts\asm\zombie_dlc1\zipline_traversal::terminateziplineloop,undefined,::scripts\asm\zombie_dlc1\zipline_traversal::chooseanimzipline,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("zipline_drop",undefined,::lib_0A1A::func_68B0,"loop_finished");
	lib_0A1A::func_2374("zipline_drop",::scripts\asm\zombie_dlc1\zipline_traversal::playtraverseziplinedrop,undefined,undefined,::scripts\asm\zombie_dlc1\zipline_traversal::terminatezipline,"choose_movetype",::scripts\asm\zombie_dlc1\zipline_traversal::chooseanimzipline,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_across_50",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jumpacross",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawling_jump_across_128",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jumpacross",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_across_50",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jumpacross",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jump_across_128",::scripts\asm\zombie_dlc1\zombie_dlc1::playtraverseanimz_dlc1,undefined,undefined,undefined,"choose_movetype",::lib_0C75::func_3F08,"jumpacross",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("attack_stand_2_hit",::lib_0C73::func_CC64,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("frozen_attack_stand",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("attack_walk",::lib_0C73::func_D4DC,undefined,undefined,undefined,undefined,::lib_0C73::func_3EB9,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("frozen_walk",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("attack_run",::lib_0C73::func_D4DC,undefined,undefined,undefined,undefined,::lib_0C73::func_3EB9,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("frozen_run",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("attack_sprint",::lib_0C73::func_D4DC,undefined,undefined,undefined,undefined,::lib_0C73::func_3EB9,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("frozen_sprint",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("attack_lunge_boost",::lib_0C73::func_D4C8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("attack_lunge_boost_norestart",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("melee",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("attack_lunge_boost_crawling",undefined,::func_12294,undefined);
	lib_0A1A::func_2375("attack_crawling",undefined,::func_1228A,undefined);
	lib_0A1A::func_2375("attack_lunge_boost",undefined,::func_1228F,undefined);
	lib_0A1A::func_2375("melee_move",undefined,::func_122A3,undefined);
	lib_0A1A::func_2375("choose_num_melee_hits",undefined,::func_1229F,undefined);
	lib_0A1A::func_2374("melee_move",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("attack_run_2_hit",undefined,::func_1227B,undefined);
	lib_0A1A::func_2375("attack_walk",undefined,::func_12283,undefined);
	lib_0A1A::func_2375("attack_run",undefined,::func_12276,undefined);
	lib_0A1A::func_2375("attack_sprint",undefined,::func_1227D,undefined);
	lib_0A1A::func_2374("melee_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_idle",undefined,::lib_0C75::func_13F9B,undefined);
	lib_0A1A::func_2374("attack_crawling",::lib_0C73::func_D539,undefined,undefined,undefined,undefined,::lib_0C73::func_3EB9,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("frozen_attack_crawling",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("attack_lunge_boost_crawling",::lib_0C73::func_D4C8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("attack_lunge_boost_crawling_norestart",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("frozen_attack_crawling",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::func_1217D,undefined);
	lib_0A1A::func_2374("frozen_attack_stand",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",0,::func_12181,undefined);
	lib_0A1A::func_2374("suicide_bomber_checks",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("attack_suicide_bomb",undefined,::func_125CB,undefined);
	lib_0A1A::func_2375("transform_to_suicide_bomber",undefined,::func_125CC,undefined);
	lib_0A1A::func_2374("attack_suicide_bomb",::lib_0C73::func_D543,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("choose_num_melee_hits",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("attack_stand_2_hit",undefined,::func_11BEF,undefined);
	lib_0A1A::func_2375("attack_stand",undefined,::func_11BEE,undefined);
	lib_0A1A::func_2374("attack_stand",::lib_0C73::func_D539,undefined,undefined,undefined,undefined,::lib_0C73::func_3EB9,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("frozen_attack_stand",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("attack_run_2_hit",::lib_0C73::func_CC64,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("choose_movetype",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_crawl_type",undefined,::func_11BD0,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::func_11BD8,undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::func_11BD9,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::func_11BD6,undefined);
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::func_11BD7,undefined);
	lib_0A1A::func_2374("walk_loop",::lib_0C75::func_D4E3,"walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving_walk",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("run_loop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("sprint_loop",::lib_0C75::func_D4E3,"sprint",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle_exit_walk",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("frozen_walk",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("walk_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("to_melee",undefined,::func_12616,undefined);
	lib_0A1A::func_2374("run_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("to_melee",undefined,::func_1246B,undefined);
	lib_0A1A::func_2374("sprint_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("to_melee",undefined,::func_1253D,undefined);
	lib_0A1A::func_2374("move_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("walk_turn",::lib_0C75::func_D515,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("frozen_walk",undefined,::lib_0C75::func_3E12,"walk_loop");
	lib_0A1A::func_2375("choose_idle_exit",undefined,::func_12619,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_1262E,undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("run_turn",::lib_0C75::func_D515,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("frozen_run",undefined,::lib_0C75::func_3E12,"run_loop");
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_12481,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("sprint_turn",::lib_0C75::func_D538,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("frozen_sprint",undefined,::lib_0C75::func_3E12,"sprint_loop");
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_12550,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("choose_idle_exit",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("idle_exit_crawl",undefined,::func_11B9B,undefined);
	lib_0A1A::func_2375("idle_exit_sprint",undefined,::func_11BAA,undefined);
	lib_0A1A::func_2375("idle_exit_walk",undefined,::func_11BAF,undefined);
	lib_0A1A::func_2375("idle_exit_run",undefined,::func_11BA1,undefined);
	lib_0A1A::func_2375("idle_exit_slow_walk",undefined,::func_11BA7,undefined);
	lib_0A1A::func_2374("idle_exit_run",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("frozen_run",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("idle_exit_sprint",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("frozen_sprint",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("slow_walk_crawl_loop",::lib_0C75::func_D4E3,"slow_walk",undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_124C6,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("slow_walk_crawl_turn",undefined,::lib_0F3B::func_FFF8,"crawl_turn");
	lib_0A1A::func_2375("crawl_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("move_done",undefined,::func_124C4,undefined);
	lib_0A1A::func_2375("frozen_crawl",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("slow_walk_crawl_turn",::lib_0C75::func_D515,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_124CA,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("slow_walk_crawl_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("slow_walk_crawl_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("frozen_crawl",undefined,::lib_0C75::func_3E12,"slow_walk_crawl_loop");
	lib_0A1A::func_2374("crawl_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_1200A,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("slow_walk_crawl_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("walk_crawl_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("run_crawl_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("sprint_crawl_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("idle_exit_crawl",::lib_0F3B::func_CEB5,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("choose_crawl_type",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("choose_crawl_type",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("frozen_crawl",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("frozen_sprint",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_sprint_in",undefined,::lib_0C75::func_3E18,undefined);
	lib_0A1A::func_2374("frozen_run",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::lib_0C75::func_3E18,undefined);
	lib_0A1A::func_2374("frozen_walk",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_walk_in",undefined,::lib_0C75::func_3E18,undefined);
	lib_0A1A::func_2374("frozen_crawl",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("slow_walk_crawl_loop",undefined,::lib_0C75::func_3E18,undefined);
	lib_0A1A::func_2374("slow_walk_turn",::lib_0C75::func_D515,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("frozen_slow_walk",undefined,::lib_0C75::func_3E12,"slow_walk_loop");
	lib_0A1A::func_2375("move_to_zapper_anims",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_124EE,undefined);
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("choose_idle_exit",undefined,::func_124E6,undefined);
	lib_0A1A::func_2374("slow_walk_loop",::lib_0C75::func_D4E3,"slow_walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving_shamble",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_slow_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("slow_walk_stop",::lib_0C75::func_CEAE,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("move_to_zapper_anims",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("to_melee",undefined,::func_124E2,undefined);
	lib_0A1A::func_2374("idle_exit_slow_walk",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("frozen_slow_walk",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("frozen_slow_walk",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_slow_walk_in",undefined,::lib_0C75::func_3E18,undefined);
	lib_0A1A::func_2374("choose_crawl_type",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("slow_walk_crawl_loop",undefined,::func_11B98,undefined);
	lib_0A1A::func_2375("walk_crawl_loop",undefined,::func_11B9A,undefined);
	lib_0A1A::func_2375("run_crawl_loop",undefined,::func_11B97,undefined);
	lib_0A1A::func_2375("sprint_crawl_loop",undefined,::func_11B99,undefined);
	lib_0A1A::func_2374("run_crawl_loop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("frozen_crawl",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2375("moveto_window_done",undefined,::lib_0C75::func_DD1E,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::trans_run_crawl_loop_to_to_melee2,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("crawl_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("run_crawl_turn",undefined,::lib_0F3B::func_FFF8,undefined);
	lib_0A1A::func_2375("move_done",undefined,::trans_run_crawl_loop_to_move_done6,undefined);
	lib_0A1A::func_2374("walk_crawl_loop",::lib_0C75::func_D4E3,"walk",undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("moveto_window_done",undefined,::lib_0C75::func_DD1E,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::trans_walk_crawl_loop_to_to_melee1,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("crawl_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("walk_crawl_turn",undefined,::lib_0F3B::func_FFF8,undefined);
	lib_0A1A::func_2375("move_done",undefined,::func_125DD,undefined);
	lib_0A1A::func_2375("frozen_crawl",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("sprint_crawl_loop",::lib_0C75::func_D4E3,"sprint",undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("moveto_window_done",undefined,::lib_0C75::func_DD1E,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::trans_sprint_crawl_loop_to_to_melee1,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("move_done",undefined,::trans_sprint_crawl_loop_to_move_done3,undefined);
	lib_0A1A::func_2375("crawl_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("sprint_crawl_turn",undefined,::lib_0F3B::func_FFF8,undefined);
	lib_0A1A::func_2375("frozen_crawl",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("walk_crawl_turn",::lib_0C75::func_D515,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,"crawl_turn",undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("walk_crawl_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("walk_crawl_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("frozen_crawl",undefined,::lib_0C75::func_3E12,"walk_crawl_loop");
	lib_0A1A::func_2374("run_crawl_turn",::lib_0C75::func_D515,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,"crawl_turn",undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_crawl_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("run_crawl_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("frozen_crawl",undefined,::lib_0C75::func_3E12,"run_crawl_loop");
	lib_0A1A::func_2374("sprint_crawl_turn",::lib_0C75::func_D515,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,"crawl_turn",undefined,undefined,undefined,undefined,undefined,undefined,"death_crawling",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("sprint_crawl_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("sprint_crawl_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("frozen_crawl",undefined,::lib_0C75::func_3E12,"sprint_crawl_loop");
	lib_0A1A::func_2374("to_melee",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee",undefined,::func_125D1,undefined);
	lib_0A1A::func_2374("to_suicide_bomb",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("suicide_bomber_checks",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("move_to_zapper_anims",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("pass_slow_walk_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("move_to_zapper_anims",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("moveto_window_done",undefined,::lib_0C75::func_DD1E,undefined);
	lib_0A1A::func_2375("play_melee_anim",undefined,::lib_0C75::func_BE95,undefined);
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_slow_walk_out_to_move_done3,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_pass_slow_walk_out_to_choose_movetype4,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::func_123EB,undefined);
	lib_0A1A::func_2375("slow_walk_turn",undefined,::lib_0F3B::func_FFF8,"slow_walk_turn");
	lib_0A1A::func_2375("slow_walk_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("frozen_slow_walk",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("pass_slow_walk_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("slow_walk_loop_clown",undefined,::lib_0C75::func_9D8C,undefined);
	lib_0A1A::func_2375("slow_walk_loop_cop",undefined,::lib_0C75::func_9D94,undefined);
	lib_0A1A::func_2375("slow_walk_loop",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("slow_walk_loop_cop",::lib_0C75::func_D4E3,"slow_walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,"cop",undefined,undefined,undefined,undefined,"pain_moving_shamble",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_slow_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("slow_walk_loop_clown",::lib_0C75::func_D4E3,"slow_walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,"clown",undefined,undefined,undefined,undefined,"pain_moving_shamble",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_slow_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_walk_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("walk_loop_clown",undefined,::lib_0C75::func_9D8C,undefined);
	lib_0A1A::func_2375("walk_loop_cop",undefined,::lib_0C75::func_9D94,undefined);
	lib_0A1A::func_2375("walk_loop",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_walk_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("move_to_zapper_anims",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("moveto_window_done",undefined,::lib_0C75::func_DD1E,undefined);
	lib_0A1A::func_2375("frozen_walk",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_pass_walk_out_to_choose_movetype3,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::trans_pass_walk_out_to_to_melee5,undefined);
	lib_0A1A::func_2375("walk_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("walk_turn",undefined,::lib_0F3B::func_FFF8,"walk_turn");
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_walk_out_to_move_done8,undefined);
	lib_0A1A::func_2374("walk_loop_clown",::lib_0C75::func_D4E3,"walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,"clown",undefined,undefined,undefined,undefined,"pain_moving_walk",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("walk_loop_cop",::lib_0C75::func_D4E3,"walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,"cop",undefined,undefined,undefined,undefined,"pain_moving_walk",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("run_loop_clown",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("run_loop_cop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_run_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("run_loop_clown",undefined,::lib_0C75::func_9D8C,undefined);
	lib_0A1A::func_2375("run_loop_cop",undefined,::lib_0C75::func_9D94,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_run_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("move_to_zapper_anims",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("moveto_window_done",undefined,::lib_0C75::func_DD1E,undefined);
	lib_0A1A::func_2375("frozen_run",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_pass_run_out_to_choose_movetype4,undefined);
	lib_0A1A::func_2375("choose_idle_exit",undefined,::trans_pass_run_out_to_choose_idle_exit5,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::trans_pass_run_out_to_to_melee6,undefined);
	lib_0A1A::func_2375("run_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_run_out_to_move_done9,undefined);
	lib_0A1A::func_2374("pass_sprint_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("sprint_loop_clown",undefined,::lib_0C75::func_9D8C,undefined);
	lib_0A1A::func_2375("sprint_loop_cop",undefined,::lib_0C75::func_9D94,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_sprint_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("move_to_zapper_anims",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("moveto_window_done",undefined,::lib_0C75::func_DD1E,undefined);
	lib_0A1A::func_2375("frozen_sprint",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2375("to_suicide_bomb",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("to_melee",undefined,::trans_pass_sprint_out_to_to_melee4,undefined);
	lib_0A1A::func_2375("sprint_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("sprint_turn",undefined,::lib_0F3B::func_FFF8,"sprint_turn");
	lib_0A1A::func_2375("choose_movetype",undefined,::trans_pass_sprint_out_to_choose_movetype7,undefined);
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_sprint_out_to_move_done8,undefined);
	lib_0A1A::func_2374("sprint_loop_cop",::lib_0C75::func_D4E3,"sprint",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("sprint_loop_clown",::lib_0C75::func_D4E3,"sprint",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_sprint_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("traverse_window",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("traverse_window_init",undefined,::lib_0C75::func_98DC,undefined);
	lib_0A1A::func_2375("moveto_window",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("window_attack_player",::lib_0C75::func_CEE3,undefined,::lib_0C75::func_252C,undefined,undefined,::lib_0C75::func_3EBA,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_window_to_zapper_sequence",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("window_attack_freeze",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2375("traverse_window_decision",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("destroy_window",::lib_0C75::func_CF19,undefined,::lib_0C75::func_532D,::lib_0C75::func_116E8,undefined,::lib_0C75::func_3ECF,undefined,undefined,"stand",undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_window_decision",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("traverse_window_to_zapper_sequence",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("window_attack_freeze",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("enter_window",::lib_0C75::func_662E,undefined,undefined,::lib_0C75::func_11706,"choose_movetype",::lib_0C75::func_3ED7,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_window_to_zapper_sequence",undefined,::lib_0C75::func_1005E,undefined);
	lib_0A1A::func_2375("traverse_window_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("traverse_window_done",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("enter_window_freeze",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("traverse_window_init",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("traverse_window_decision",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("window_attack_player",undefined,::lib_0C75::func_FFC0,undefined);
	lib_0A1A::func_2375("destroy_window",undefined,::lib_0C75::func_BE93,undefined);
	lib_0A1A::func_2375("use_custom_traversal",undefined,::lib_0C75::func_1305A,undefined);
	lib_0A1A::func_2375("pass_check_running",undefined,::lib_0C75::func_10007,undefined);
	lib_0A1A::func_2375("pass_check_walking",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("moveto_window",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_idle_exit",undefined,::lib_0C75::func_5AEE,undefined);
	lib_0A1A::func_2374("moveto_window_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("traverse_window_decision",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("use_custom_traversal",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_movetype",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("traverse_window_to_zapper_sequence",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("enter_window_running",::lib_0C75::func_662E,undefined,undefined,::lib_0C75::func_11706,"choose_movetype",::lib_0C75::func_3ED7,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_window_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("traverse_window_done",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("enter_window_running_freeze",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("enter_window_crawl_running",::lib_0C75::func_662E,undefined,undefined,::lib_0C75::func_11706,"choose_movetype",::lib_0C75::func_3ED7,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_window_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("traverse_window_done",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("enter_window_crawl_running_freeze",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("pass_check_running",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("enter_window_crawl_running",undefined,::func_123E1,undefined);
	lib_0A1A::func_2375("enter_window_running",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_check_walking",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("enter_window_crawling",undefined,::func_123E2,undefined);
	lib_0A1A::func_2375("enter_window",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("enter_window_crawling",::lib_0C75::func_662E,undefined,undefined,::lib_0C75::func_11706,"choose_movetype",::lib_0C75::func_3ED7,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_window_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("traverse_window_done",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("enter_window_crawling_freeze",undefined,::lib_0C75::func_3E12,undefined);
	lib_0A1A::func_2374("traverse_window_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("choose_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("window_attack_freeze",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("traverse_window_decision",undefined,::lib_0C75::func_3E18,undefined);
	lib_0A1A::func_2374("enter_window_crawl_running_freeze",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("enter_window_crawl_running",undefined,::lib_0C75::func_3E18,undefined);
	lib_0A1A::func_2374("enter_window_freeze",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("enter_window",undefined,::lib_0C75::func_3E18,undefined);
	lib_0A1A::func_2374("enter_window_running_freeze",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("enter_window_running",undefined,::lib_0C75::func_3E18,undefined);
	lib_0A1A::func_2374("enter_window_crawling_freeze",::lib_0C75::func_7389,undefined,undefined,::lib_0C75::func_631D,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("enter_window_crawling",undefined,::lib_0C75::func_3E18,undefined);
	lib_0A1A::func_2374("play_melee_anim",::lib_0C75::func_D4DB,undefined,undefined,undefined,undefined,::lib_0C75::func_3EE0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_idle",undefined,::func_12402,undefined);
	lib_0A1A::func_2375("play_melee_anim",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("transform_to_suicide_bomber",::lib_0C73::func_D553,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("choose_movetype",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("play_spawn_fx",::lib_0C75::func_D532,undefined,undefined,undefined,undefined,::lib_0C75::func_3EFB,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("play_vignette_anim",undefined,::func_12403,undefined);
	lib_0A1A::func_2374("waiting",::lib_0F3C::func_B050,undefined,undefined,undefined,undefined,::lib_0C75::func_3F0B,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("choose_idle",undefined,::lib_0C75::func_9DC9,undefined);
	lib_0A1A::func_2374("balloon_grab_left",::lib_0F3C::func_CEA8,undefined,::scripts\asm\zombie_dlc1\zombie_dlc1::balloongrabnotehandler,undefined,undefined,::scripts\asm\zombie_dlc1\zombie_dlc1::chooseballoongrabanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("balloon_float",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("balloon_float",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\zombie_dlc1\zombie_dlc1::chooseballoonfloatanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("balloon_grab_right",::lib_0F3C::func_CEA8,undefined,::scripts\asm\zombie_dlc1\zombie_dlc1::balloongrabnotehandler,undefined,undefined,::scripts\asm\zombie_dlc1\zombie_dlc1::chooseballoongrabanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("balloon_float",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("balloon_grab",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("balloon_grab_left",undefined,::scripts\asm\zombie_dlc1\zombie_dlc1::shouldballoongrableft,undefined);
	lib_0A1A::func_2375("balloon_grab_right",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("piranha_trap",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
func_12255(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 3
trans_idle_to_choose_idle_exit7(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 4
func_11BC9(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE96();
}

//Function Number: 5
func_11BCD(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE97();
}

//Function Number: 6
func_11BBA(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 7
func_11BC5(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 8
func_11BC0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2941();
}

//Function Number: 9
func_12203(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2941();
}

//Function Number: 10
func_12204(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 11
func_12208(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 12
func_12212(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 13
func_1221D(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 14
func_12222(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 15
func_12404(param_00,param_01,param_02,param_03)
{
	return self.hasplayedvignetteanim;
}

//Function Number: 16
func_120B4(param_00,param_01,param_02,param_03)
{
	return !scripts\asm\zombie_dlc1\zombie_dlc1::isdismembermentdisabled() && lib_0C72::func_9E2E();
}

//Function Number: 17
trans_dismember_to_normal_damage1(param_00,param_01,param_02,param_03)
{
	return !scripts\asm\zombie_dlc1\zombie_dlc1::isdismembermentdisabled();
}

//Function Number: 18
func_121B4(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B6();
}

//Function Number: 19
func_121EA(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B9() && lib_0C72::func_9EDD("walk");
}

//Function Number: 20
func_121EB(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B9() && lib_0C72::func_9EDD("slow_walk");
}

//Function Number: 21
func_121E3(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B9() && lib_0C72::func_9EDD("run");
}

//Function Number: 22
func_121E4(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B9() && lib_0C72::func_9EDD("sprint");
}

//Function Number: 23
func_121FE(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54BA() && lib_0C72::func_9EDD("walk");
}

//Function Number: 24
func_121FF(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54BA() && lib_0C72::func_9EDD("slow_walk");
}

//Function Number: 25
func_121F6(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54BA() && lib_0C72::func_9EDD("run");
}

//Function Number: 26
func_121F7(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54BA() && lib_0C72::func_9EDD("sprint");
}

//Function Number: 27
func_121D0(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B8() && lib_0C72::func_9EDD("run");
}

//Function Number: 28
func_121D1(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B8() && lib_0C72::func_9EDD("sprint");
}

//Function Number: 29
func_121D8(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B8() && lib_0C72::func_9EDD("walk");
}

//Function Number: 30
func_121D9(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B8() && lib_0C72::func_9EDD("slow_walk");
}

//Function Number: 31
func_121BE(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B7() && lib_0C72::func_9EDD("run");
}

//Function Number: 32
func_121BF(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B7() && lib_0C72::func_9EDD("sprint");
}

//Function Number: 33
func_121C4(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B7() && lib_0C72::func_9EDD("walk");
}

//Function Number: 34
func_121C5(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B7() && lib_0C72::func_9EDD("slow_walk");
}

//Function Number: 35
func_121DE(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B9();
}

//Function Number: 36
func_121F0(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54BA();
}

//Function Number: 37
func_121CA(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B8();
}

//Function Number: 38
func_121B9(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B8();
}

//Function Number: 39
func_122F3(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B6();
}

//Function Number: 40
func_12329(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B9() && lib_0C72::func_9EDD("walk");
}

//Function Number: 41
func_1232A(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B9() && lib_0C72::func_9EDD("slow_walk");
}

//Function Number: 42
func_12322(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B9() && lib_0C72::func_9EDD("run");
}

//Function Number: 43
func_12323(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B9() && lib_0C72::func_9EDD("sprint");
}

//Function Number: 44
func_1233D(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54BA() && lib_0C72::func_9EDD("walk");
}

//Function Number: 45
func_1233E(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54BA() && lib_0C72::func_9EDD("slow_walk");
}

//Function Number: 46
func_12335(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54BA() && lib_0C72::func_9EDD("run");
}

//Function Number: 47
func_12336(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54BA() && lib_0C72::func_9EDD("sprint");
}

//Function Number: 48
func_12303(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B7() && lib_0C72::func_9EDD("walk");
}

//Function Number: 49
func_12304(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B7() && lib_0C72::func_9EDD("slow_walk");
}

//Function Number: 50
func_122FD(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B7() && lib_0C72::func_9EDD("run");
}

//Function Number: 51
func_122FE(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B7() && lib_0C72::func_9EDD("sprint");
}

//Function Number: 52
func_12317(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B8() && lib_0C72::func_9EDD("walk");
}

//Function Number: 53
func_12318(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B8() && lib_0C72::func_9EDD("slow_walk");
}

//Function Number: 54
func_1230F(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B8() && lib_0C72::func_9EDD("run");
}

//Function Number: 55
func_12310(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B8() && lib_0C72::func_9EDD("sprint");
}

//Function Number: 56
func_1232F(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54BA();
}

//Function Number: 57
func_1231D(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B9();
}

//Function Number: 58
func_12309(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B8();
}

//Function Number: 59
func_122F8(param_00,param_01,param_02,param_03)
{
	return lib_0C72::func_54B7();
}

//Function Number: 60
func_1208A(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 61
func_12379(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 62
func_12385(param_00,param_01,param_02,param_03)
{
	return self.var_DD == "head";
}

//Function Number: 63
func_1238B(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_9E89(self.var_DD);
}

//Function Number: 64
func_1237F(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 65
func_123B7(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 66
func_123BD(param_00,param_01,param_02,param_03)
{
	return !lib_0C75::func_10057(self.var_E1,self.var_E2,self.var_DE,self.var_DD);
}

//Function Number: 67
func_123C9(param_00,param_01,param_02,param_03)
{
	return self.var_DD == "head";
}

//Function Number: 68
func_123C3(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 69
func_123A4(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_9E89(self.var_DD) && lib_0A1B::func_2956("sprint");
}

//Function Number: 70
func_1239E(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("sprint");
}

//Function Number: 71
func_12399(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_9E89(self.var_DD) && lib_0A1B::func_2956("run");
}

//Function Number: 72
func_12392(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 73
func_123AA(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_9E89(self.var_DD) && lib_0A1B::func_2956("walk");
}

//Function Number: 74
func_123AB(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 75
func_123B4(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 76
func_123B5(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_10057(self.var_E1,self.var_E2,self.var_DE,self.var_DD);
}

//Function Number: 77
func_123CE(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 78
func_123CF(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_10057(self.var_E1,self.var_E2,self.var_DE,self.var_DD);
}

//Function Number: 79
trans_death_generic_to_death_crawling0(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 80
trans_death_moving_to_death_crawling0(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 81
func_12294(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92() && lib_0C73::func_138E0();
}

//Function Number: 82
func_1228A(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 83
func_1228F(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E0();
}

//Function Number: 84
func_122A3(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E1();
}

//Function Number: 85
func_1229F(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 86
func_1227B(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_10041();
}

//Function Number: 87
func_12283(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("walk");
}

//Function Number: 88
func_12276(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 89
func_1227D(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("sprint");
}

//Function Number: 90
func_1217D(param_00,param_01,param_02,param_03)
{
	return !isdefined(self.var_9E0C) || !self.var_9E0C;
}

//Function Number: 91
func_12181(param_00,param_01,param_02,param_03)
{
	return !isdefined(self.var_9E0C) || !self.var_9E0C;
}

//Function Number: 92
func_125CB(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E5();
}

//Function Number: 93
func_125CC(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E6();
}

//Function Number: 94
func_11BEF(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_10041();
}

//Function Number: 95
func_11BEE(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 96
func_11BD0(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 97
func_11BD8(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE9A();
}

//Function Number: 98
func_11BD9(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("walk");
}

//Function Number: 99
func_11BD6(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 100
func_11BD7(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("slow_walk");
}

//Function Number: 101
func_12616(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 102
func_1246B(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 103
func_1253D(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 104
func_12619(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_A013();
}

//Function Number: 105
func_1262E(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 106
func_12481(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 107
func_12550(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 108
func_11B9B(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 109
func_11BAA(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE9A();
}

//Function Number: 110
func_11BAF(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("walk");
}

//Function Number: 111
func_11BA1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 112
func_11BA7(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("slow_walk");
}

//Function Number: 113
func_124C6(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 114
func_124C4(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 115
func_124CA(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 116
func_1200A(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 117
func_124EE(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 118
func_124E6(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_A013();
}

//Function Number: 119
func_124E2(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 120
func_11B98(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("slow_walk");
}

//Function Number: 121
func_11B9A(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("walk");
}

//Function Number: 122
func_11B97(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 123
func_11B99(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("sprint");
}

//Function Number: 124
trans_run_crawl_loop_to_to_melee2(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 125
trans_run_crawl_loop_to_move_done6(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 126
trans_walk_crawl_loop_to_to_melee1(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 127
func_125DD(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 128
trans_sprint_crawl_loop_to_to_melee1(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 129
trans_sprint_crawl_loop_to_move_done3(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 130
func_125D1(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 131
trans_pass_slow_walk_out_to_move_done3(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 132
trans_pass_slow_walk_out_to_choose_movetype4(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BCCD();
}

//Function Number: 133
func_123EB(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 134
trans_pass_walk_out_to_choose_movetype3(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BCCD();
}

//Function Number: 135
trans_pass_walk_out_to_to_melee5(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 136
trans_pass_walk_out_to_move_done8(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 137
trans_pass_run_out_to_choose_movetype4(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BCCD();
}

//Function Number: 138
trans_pass_run_out_to_choose_idle_exit5(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_A013();
}

//Function Number: 139
trans_pass_run_out_to_to_melee6(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 140
trans_pass_run_out_to_move_done9(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 141
trans_pass_sprint_out_to_to_melee4(param_00,param_01,param_02,param_03)
{
	return lib_0C73::func_138E4();
}

//Function Number: 142
trans_pass_sprint_out_to_choose_movetype7(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BCCD();
}

//Function Number: 143
trans_pass_sprint_out_to_move_done8(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 144
func_123E1(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 145
func_123E2(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE92();
}

//Function Number: 146
func_12402(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_1009C();
}

//Function Number: 147
func_12403(param_00,param_01,param_02,param_03)
{
	return self.var_8C12;
}