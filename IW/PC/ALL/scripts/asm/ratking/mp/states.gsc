/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\ratking\mp\states.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 553 ms
 * Timestamp: 10/27/2023 12:02:03 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("ratking"))
	{
		return;
	}

	lib_0A1A::func_230B("ratking","ratking_start");
	lib_0A1A::func_2374("ratking_start",::scripts\asm\ratking\ratking_asm::ratkinginit,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("enter_world",undefined,::scripts\asm\ratking\ratking_asm::shouldplayentranceanim,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("check_move",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("enter_world",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("check_actions",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("check_staff_and_shield",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("leave_world",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("staff_stomp",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("shield_throw",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("block",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("teleport",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("summon",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("staff_projectile",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("shield_throw_at_spot",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("staff_stomp",::scripts\asm\ratking\ratking_asm::dostaffstomp,undefined,::scripts\asm\ratking\ratking_asm::staffstompnotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("block_intro",::scripts\asm\ratking\ratking_asm::playblockanim,undefined,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("block_loop",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("shield_throw",::scripts\asm\ratking\ratking_asm::doshieldthrow,undefined,::scripts\asm\ratking\ratking_asm::shieldthrownotehandler,::scripts\asm\ratking\ratking_asm::clearlooktarget,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("action_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_generic",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3F00,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_moving",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3EE2,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("check_move",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_walk_in",undefined,::trans_check_move_to_pass_walk_in0,undefined);
	lib_0A1A::func_2375("pass_run_in",undefined,::trans_check_move_to_pass_run_in1,undefined);
	lib_0A1A::func_2374("pass_walk_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("check_staff_and_shield",undefined,undefined,undefined);
	lib_0A1A::func_2375("walk_start",undefined,::trans_pass_walk_in_to_walk_start2,undefined);
	lib_0A1A::func_2374("walk_turn",::lib_0F3B::func_D514,undefined,::scripts\asm\ratking\ratking_asm::ratkingturnnotehandler,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("teleport",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("check_interruptables",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("walk_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("walk_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("walk_loop",::lib_0C75::func_D4E3,"walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_walk_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_walk_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("walk_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("check_interruptables",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("walk_turn",undefined,::lib_0F3B::func_FFF8,"walk_turn");
	lib_0A1A::func_2375("move_done",undefined,::trans_pass_walk_out_to_move_done4,undefined);
	lib_0A1A::func_2374("move_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("choose_movetype",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("check_move",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("walk_stop",::lib_0C75::func_D4E3,"walk",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("move_done",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pass_run_in",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("check_staff_and_shield",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_start",undefined,::trans_pass_run_in_to_run_start2,undefined);
	lib_0A1A::func_2374("run_turn",::lib_0F3B::func_D514,undefined,::scripts\asm\ratking\ratking_asm::ratkingturnnotehandler,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("check_interruptables",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("run_loop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("pass_run_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("run_stop",::lib_0C75::func_D4E3,"run",undefined,undefined,undefined,::lib_0C75::func_3EE1,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("move_done",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pass_run_out",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("run_stop",undefined,::lib_0C75::func_10092,undefined);
	lib_0A1A::func_2375("check_interruptables",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2374("run_start",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::ratking_chooseanim_exit,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("run_loop",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("walk_start",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::ratking_chooseanim_exit,undefined,undefined,undefined,undefined,undefined,"pain_moving",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("walk_loop",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pain_generic",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::func_3EE4,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pain_moving",::scripts\asm\ratking\ratking_asm::playmovingpainanim,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("walk_loop",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("decide_idle",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("platform_idle",undefined,::trans_decide_idle_to_platform_idle0,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("teleport_in",::scripts\asm\ratking\ratking_asm::playteleportin,2,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("teleport_out",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\ratking\ratking_asm::shouldabortaction,"teleport");
	lib_0A1A::func_2374("summon",::lib_0F3C::func_CEA8,undefined,::scripts\asm\ratking\ratking_asm::summonnotehandler,undefined,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("check_interruptables",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("staff_stomp",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("block",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("teleport",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::scripts\asm\ratking\ratking_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("check_staff_and_shield",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("block",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("block_intro",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("block_loop",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("block_outro",undefined,::scripts\asm\ratking\ratking_asm::shouldendblock,undefined);
	lib_0A1A::func_2374("block_outro",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("teleport",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("teleport_in",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("teleport_out",::scripts\asm\ratking\ratking_asm::playteleportout,undefined,undefined,::scripts\asm\ratking\ratking_asm::terminate_teleportout,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\ratking\ratking_asm::shouldabortaction,"teleport");
	lib_0A1A::func_2375("check_interruptables",undefined,::scripts\asm\ratking\ratking_asm::shouldconsiderabortingteleport,undefined);
	lib_0A1A::func_2374("traverse_external",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("teleport_in",undefined,::scripts\asm\ratking\ratking_asm::ontraversalteleport,undefined);
	lib_0A1A::func_2374("leave_world",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2374("melee_attack",::scripts\asm\ratking\ratking_asm::playmeleeattack,undefined,::scripts\asm\ratking\ratking_asm::meleenotehandler,undefined,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("staff_projectile",::scripts\asm\ratking\ratking_asm::dostaffprojectile,undefined,::scripts\asm\ratking\ratking_asm::staffprojectilenotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("shield_throw_at_spot",::scripts\asm\ratking\ratking_asm::doshieldthrowatspot,undefined,::scripts\asm\ratking\ratking_asm::shieldthrowatspotnotehandler,::scripts\asm\ratking\ratking_asm::clearlooktarget,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("platform_idle",::scripts\asm\ratking\ratking_asm::playplatformidle,undefined,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim angle delta",undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::trans_platform_idle_to_decide_idle0,undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("aimset_shield_throw",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("shield_lost_and_found",::scripts\asm\ratking\ratking_asm::playshieldlostandfound,undefined,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::chooseshieldornoshieldanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim angle delta",undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("staff_lost_and_found",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\ratking\ratking_asm::choosestaffornostaffanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim angle delta",undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\ratking\ratking_asm::isanimdone,undefined);
	lib_0A1A::func_2374("check_staff_and_shield",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shield_lost_and_found",undefined,::scripts\asm\ratking\ratking_asm::lostorfoundshield,undefined);
	lib_0A1A::func_2375("staff_lost_and_found",undefined,::scripts\asm\ratking\ratking_asm::lostorfoundstaff,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
trans_check_move_to_pass_walk_in0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("walk");
}

//Function Number: 3
trans_check_move_to_pass_run_in1(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("run");
}

//Function Number: 4
trans_pass_walk_in_to_walk_start2(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 5
trans_pass_walk_out_to_move_done4(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 6
trans_pass_run_in_to_run_start2(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 7
trans_decide_idle_to_platform_idle0(param_00,param_01,param_02,param_03)
{
	return scripts\common\utility::istrue(self.isonplatform);
}

//Function Number: 8
trans_platform_idle_to_decide_idle0(param_00,param_01,param_02,param_03)
{
	return !scripts\common\utility::istrue(self.isonplatform);
}