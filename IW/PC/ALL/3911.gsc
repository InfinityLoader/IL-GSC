/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3911.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 54 ms
 * Timestamp: 10/27/2023 12:31:14 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("zombie_grey"))
	{
		return;
	}

	lib_0F3F::func_2371();
	lib_0A1A::func_230B("zombie_grey","c6_start");
	lib_0A1A::func_2374("enter_combat",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,["shoot_grey"],undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("noncombat_stand_idle",::lib_0F3C::func_B050,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"noncombat_stand_idle",undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("regen_start",undefined,::lib_0C78::func_13F91,undefined);
	lib_0A1A::func_2375("being_cloned",undefined,::lib_0C78::func_13F8C,undefined);
	lib_0A1A::func_2375("teleport_to_loner",undefined,::lib_0C78::func_13F98,undefined);
	lib_0A1A::func_2375("duplicating_attack",undefined,::lib_0C78::func_13F8E,undefined);
	lib_0A1A::func_2375("teleport_attack",undefined,::lib_0C78::func_13F95,undefined);
	lib_0A1A::func_2375("teleport_summon",undefined,::lib_0C78::func_13F97,undefined);
	lib_0A1A::func_2375("teleport_dash",undefined,::lib_0C78::func_13F96,undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::func_122DF,undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_BCE7,"walk");
	lib_0A1A::func_2375("exposed_idle",undefined,::func_122E4,undefined);
	lib_0A1A::func_2375("enter_combat",undefined,::func_122DA,undefined);
	lib_0A1A::func_2374("c6_start",::lib_0C38::func_33FF,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("intro_spawn",undefined,::func_11B91,undefined);
	lib_0A1A::func_2375("intro_vignette",undefined,::func_11B92,undefined);
	lib_0A1A::func_2374("exposed_aimset",undefined,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("strafe_aimset",undefined,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("melee_charge_to_ready",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_attack",::lib_0C78::func_85FF,undefined,undefined,undefined,undefined,::lib_0C78::func_3EDC,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack","face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_stand_to_ready",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_charge",::lib_0F3C::func_B050,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("melee_charge_to_ready",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1B::func_294F,undefined);
	lib_0A1A::func_2374("death_generic",::lib_0C34::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_standing",::lib_0C34::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C34::func_3F00,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_crouching",::lib_0C34::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C34::func_3ECA,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_moving",::lib_0C34::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C34::func_3EE2,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_cover",::lib_0C34::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C34::func_3EC6,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_stand",::lib_0C37::func_D4EE,undefined,undefined,::lib_0C37::func_4109,undefined,::lib_0C37::func_3EEC,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("should_regen",undefined,::lib_0A1A::func_68B0,"end");
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
	lib_0A1A::func_2374("exposed_reload",::lib_0C38::func_260,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3EAA,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,"reload","face current","anim deltas",undefined);
	lib_0A1A::func_2375("regen_start",undefined,::lib_0C78::func_13F91,undefined);
	lib_0A1A::func_2375("teleport_to_loner",undefined,::lib_0C78::func_13F98,undefined);
	lib_0A1A::func_2375("duplicating_attack",undefined,::lib_0C78::func_13F8E,undefined);
	lib_0A1A::func_2375("teleport_attack",undefined,::lib_0C78::func_13F95,undefined);
	lib_0A1A::func_2375("teleport_summon",undefined,::lib_0C78::func_13F97,undefined);
	lib_0A1A::func_2375("teleport_dash",undefined,::lib_0C78::func_13F96,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_throw_grenade",::lib_0C39::func_CEC6,undefined,undefined,undefined,undefined,::lib_0C39::func_3EA8,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,"throwgrenade","face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_weaponswitch",::lib_0C38::func_CECB,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3EAC,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_stand_turn",::lib_0C38::func_D56A,undefined,undefined,undefined,undefined,::lib_0C38::func_3F0A,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("regen_start",undefined,::lib_0C78::func_13F91,undefined);
	lib_0A1A::func_2375("teleport_to_loner",undefined,::lib_0C78::func_13F98,undefined);
	lib_0A1A::func_2375("duplicating_attack",undefined,::lib_0C78::func_13F8E,undefined);
	lib_0A1A::func_2375("teleport_attack",undefined,::lib_0C78::func_13F95,undefined);
	lib_0A1A::func_2375("teleport_summon",undefined,::lib_0C78::func_13F97,undefined);
	lib_0A1A::func_2375("teleport_dash",undefined,::lib_0C78::func_13F96,undefined);
	lib_0A1A::func_2375("exposed_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish early");
	lib_0A1A::func_2374("exposed_idle",::lib_0C38::func_D46D,undefined,undefined,undefined,undefined,::lib_0C78::func_13F6F,undefined,["aim"],undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("start_exposed_shoot",undefined,::func_1214B,undefined);
	lib_0A1A::func_2375("exposed_transitions_out",undefined,::scripts\asm\shared_utility::func_12668,undefined);
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
	lib_0A1A::func_2374("exposed_crouch",::lib_0C38::func_D46D,undefined,undefined,undefined,undefined,::lib_0F3C::func_3EAB,"_aim_5",["aim"],"crouch",["shoot_grey"],undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
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
	lib_0A1A::func_2374("exposed_crouch_turn",::lib_0C38::func_D56A,undefined,undefined,undefined,undefined,::lib_0C38::func_3F0A,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish early");
	lib_0A1A::func_2374("exposed_reload_crouch",::lib_0C38::func_260,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3EAA,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,"reload","face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_shoot",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,["aim"],undefined,["shoot_grey"],undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("end_exposed_shoot",undefined,::func_12158,undefined);
	lib_0A1A::func_2374("exposed_transitions_out",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("regen_start",undefined,::lib_0C78::func_13F91,undefined);
	lib_0A1A::func_2375("teleport_to_loner",undefined,::lib_0C78::func_13F98,undefined);
	lib_0A1A::func_2375("duplicating_attack",undefined,::lib_0C78::func_13F8E,undefined);
	lib_0A1A::func_2375("teleport_attack",undefined,::lib_0C78::func_13F95,undefined);
	lib_0A1A::func_2375("teleport_summon",undefined,::lib_0C78::func_13F97,undefined);
	lib_0A1A::func_2375("teleport_dash",undefined,::lib_0C78::func_13F96,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::func_12170,undefined);
	lib_0A1A::func_2375("exposed_throw_grenade",undefined,::func_1216A,undefined);
	lib_0A1A::func_2375("exposed_weaponswitch",undefined,::lib_0C38::func_100A9,undefined);
	lib_0A1A::func_2375("exposed_stand_turn",undefined,::lib_0C38::func_BEA0,undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::func_12163,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::func_12164,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_1216D,undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("exposed_reload",undefined,::func_12167,undefined);
	lib_0A1A::func_2375("exposed_stand_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("exposed_stand_to_prone",undefined,::lib_0A1B::func_2949,"prone");
	lib_0A1A::func_2374("start_exposed_shoot",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_shoot",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("end_exposed_shoot",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_shoot_out",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_shoot_out",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_reload",undefined,::func_12157,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("step_up_24",::lib_0C3A::func_D566,24,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("iw6_jumpdown_40",::lib_0C3A::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("step_down_24",::lib_0C3A::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("combatrun_forward_72",::lib_0F3C::func_CEA8,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_hop",::lib_0C3A::func_D55D,39.875,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_130",::lib_0C3A::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_96",::lib_0C3A::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("double_jump_temp",::lib_0C3A::func_D55E,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("traverse_external",::lib_0C3A::func_D560,undefined,undefined,undefined,"stand_run_loop",::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("cover_right_arrival",::lib_0F3A::func_CEAA,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,"Cover Right",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2374("cover_right_exit",::lib_0F3B::func_CEB5,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("exposed_arrival",::lib_0F3A::func_CEAA,undefined,undefined,undefined,undefined,::lib_0F3A::func_3E97,"Exposed",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_exit",::lib_0F3B::func_CEB5,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("regen_start",undefined,::lib_0C78::func_13F91,undefined);
	lib_0A1A::func_2375("teleport_to_loner",undefined,::lib_0C78::func_13F98,undefined);
	lib_0A1A::func_2375("duplicating_attack",undefined,::lib_0C78::func_13F8E,undefined);
	lib_0A1A::func_2375("teleport_attack",undefined,::lib_0C78::func_13F95,undefined);
	lib_0A1A::func_2375("teleport_summon",undefined,::lib_0C78::func_13F97,undefined);
	lib_0A1A::func_2375("teleport_dash",undefined,::lib_0C78::func_13F96,undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("stand_run_loop",::lib_0F3C::func_D4DD,undefined,undefined,undefined,undefined,::lib_0F3C::func_3EB8,"run",["(none)"],"stand",undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("regen_start",undefined,::lib_0C78::func_13F91,undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("melee_charge_to_ready",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("teleport_to_loner",undefined,::lib_0C78::func_13F98,undefined);
	lib_0A1A::func_2375("duplicating_attack",undefined,::lib_0C78::func_13F8E,undefined);
	lib_0A1A::func_2375("teleport_attack",undefined,::lib_0C78::func_13F95,undefined);
	lib_0A1A::func_2375("teleport_summon",undefined,::lib_0C78::func_13F97,undefined);
	lib_0A1A::func_2375("teleport_dash",undefined,::lib_0C78::func_13F96,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("cover_right_arrival",undefined,::lib_0F3A::func_1008A,"Cover Right");
	lib_0A1A::func_2375("cover_left_arrival",undefined,::lib_0F3A::func_1008A,"Cover Left");
	lib_0A1A::func_2375("exposed_arrival",undefined,::lib_0F3A::func_1008A,["Exposed",1]);
	lib_0A1A::func_2375("cover_stand_arrival",undefined,::lib_0F3A::func_1008A,"Cover Stand");
	lib_0A1A::func_2375("cover_crouch_arrival",undefined,::lib_0F3A::func_1008A,["Cover Crouch",1]);
	lib_0A1A::func_2375("cover_left_crouch_arrival",undefined,::lib_0F3A::func_1008A,"Cover Left Crouch");
	lib_0A1A::func_2375("cover_right_crouch_arrival",undefined,::lib_0F3A::func_1008A,"Cover Right Crouch");
	lib_0A1A::func_2375("exposed_crouch_arrival",undefined,::lib_0F3A::func_1008A,["Exposed Crouch",1]);
	lib_0A1A::func_2375("sprint_loop",undefined,::func_12581,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::func_12560,undefined);
	lib_0A1A::func_2375("start_stand_run_strafe",undefined,::lib_0F3C::func_100A3,"stand");
	lib_0A1A::func_2375("stand_run_n_gun_loop",undefined,::lib_0C36::func_10070,undefined);
	lib_0A1A::func_2375("stand_run_n_gun_backwards_loop",undefined,::lib_0C36::func_1006F,undefined);
	lib_0A1A::func_2375("crouch_run_strafe_loop",undefined,::lib_0F3C::func_100A3,"crouch");
	lib_0A1A::func_2374("run_turn",::lib_0F3B::func_D514,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("teleport_to_loner",undefined,::lib_0C78::func_13F98,undefined);
	lib_0A1A::func_2375("duplicating_attack",undefined,::lib_0C78::func_13F8E,undefined);
	lib_0A1A::func_2375("regen_start",undefined,::lib_0C78::func_13F91,undefined);
	lib_0A1A::func_2375("teleport_attack",undefined,::lib_0C78::func_13F95,undefined);
	lib_0A1A::func_2375("teleport_summon",undefined,::lib_0C78::func_13F97,undefined);
	lib_0A1A::func_2375("teleport_dash",undefined,::lib_0C78::func_13F96,undefined);
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
	lib_0A1A::func_2374("stand_run_strafe_loop",::lib_0F3B::func_D4E5,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,["aim"],"stand",["shoot_grey"],undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("stop_stand_run_strafe",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0F3C::func_FFB6,"stand");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("teleport_to_loner",undefined,::lib_0C78::func_13F98,undefined);
	lib_0A1A::func_2375("teleport_attack",undefined,::lib_0C78::func_13F95,undefined);
	lib_0A1A::func_2375("teleport_summon",undefined,::lib_0C78::func_13F97,undefined);
	lib_0A1A::func_2375("teleport_dash",undefined,::lib_0C78::func_13F96,undefined);
	lib_0A1A::func_2374("stand_run_n_gun_loop",::lib_0C36::func_D50D,undefined,undefined,::lib_0C36::func_11088,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,["shoot_grey"],undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_n_gun_backwards_loop",undefined,::lib_0C36::func_1006F,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("exposed_reload",undefined,::func_12591,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0C36::func_1009F,undefined);
	lib_0A1A::func_2374("stand_run_n_gun_backwards_loop",::lib_0C36::func_D50E,undefined,undefined,::lib_0C36::func_11088,undefined,::lib_0F3C::func_3E96,"move_back",undefined,undefined,["shoot_grey"],undefined,"pain_run",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
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
	lib_0A1A::func_2375("melee_attack",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::func_12512,undefined);
	lib_0A1A::func_2374("crouch_run_strafe_loop",::lib_0F3B::func_D4E5,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,["aim"],"stand",["shoot_grey"],undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0F3C::func_FFB6,"crouch");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2374("start_stand_run_strafe",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("stand_run_strafe_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("move_walk_loop",::lib_0F3C::func_D4DD,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_122B0,undefined);
	lib_0A1A::func_2374("should_regen",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("regen_start",undefined,::lib_0C78::func_13F91,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("regen",::lib_0C78::func_13F72,undefined,undefined,::lib_0C78::func_13F70,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("regen_stop",undefined,::func_12415,undefined);
	lib_0A1A::func_2374("shockwave",::lib_0C78::func_13F76,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"shock_wave_damage");
	lib_0A1A::func_2374("teleport_to_loner",::lib_0C78::func_13F7A,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_125D0,undefined);
	lib_0A1A::func_2374("duplicating_attack",::lib_0C78::func_13F71,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_120C1,undefined);
	lib_0A1A::func_2374("being_cloned",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_11B90,undefined);
	lib_0A1A::func_2374("regen_start",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("end_regen_start",undefined,::lib_0A1A::func_68B0,"early_end");
	lib_0A1A::func_2374("regen_stop",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("regen_pain_in",undefined,::lib_0C78::func_13F93,undefined);
	lib_0A1A::func_2375("regen_to_stand",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("regen_to_stand",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("regen_summon",::lib_0C78::func_13F75,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("regen",undefined,::lib_0A1A::func_68B0,"early_end");
	lib_0A1A::func_2374("intro_vignette",::lib_0C78::func_85FE,undefined,undefined,::lib_0C78::func_85F7,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::lib_0C78::func_8601,undefined);
	lib_0A1A::func_2374("stop_stand_run_strafe",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("regen_summon",undefined,::lib_0C78::func_13F91,undefined);
	lib_0A1A::func_2375("duplicating_attack",undefined,::lib_0C78::func_13F8E,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::func_125C5,undefined);
	lib_0A1A::func_2375("exposed_reload",undefined,::func_125C6,undefined);
	lib_0A1A::func_2374("teleport_attack",::lib_0C78::func_13F77,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy",undefined,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_125CD,undefined);
	lib_0A1A::func_2374("end_regen_start",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("regen_summon",undefined,::lib_0C78::func_13F92,undefined);
	lib_0A1A::func_2375("regen",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("regen_pain_in",::lib_0C78::func_13F73,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("regen_pain_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("regen_pain_loop",::lib_0C78::func_13F74,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shockwave",undefined,::lib_0A1A::func_68B0,"early_end");
	lib_0A1A::func_2374("intro_spawn",::lib_0C78::func_85FD,undefined,undefined,::lib_0C78::func_85F7,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::lib_0C78::func_8601,undefined);
	lib_0A1A::func_2374("teleport_summon",::lib_0C78::func_13F79,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy",undefined,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_125CF,undefined);
	lib_0A1A::func_2374("teleport_dash",::lib_0C78::func_13F78,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy",undefined,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_125CE,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
func_122DF(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 3
func_122E4(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2941();
}

//Function Number: 4
func_122DA(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2941();
}

//Function Number: 5
func_11B91(param_00,param_01,param_02,param_03)
{
	return level.var_85EE;
}

//Function Number: 6
func_11B92(param_00,param_01,param_02,param_03)
{
	return !level.var_85EE;
}

//Function Number: 7
func_1214B(param_00,param_01,param_02,param_03)
{
	return lib_0C78::func_8602();
}

//Function Number: 8
func_120ED(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 9
func_12158(param_00,param_01,param_02,param_03)
{
	return !lib_0C78::func_8602();
}

//Function Number: 10
func_12170(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("sprint");
}

//Function Number: 11
func_1216A(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_298A();
}

//Function Number: 12
func_12163(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955() && self.var_1198.var_BD23 == "combat" && lib_0F3C::func_138E2();
}

//Function Number: 13
func_12164(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_1198.var_2BDF) && self.var_1198.var_2BDF && lib_0F3C::func_138E2();
}

//Function Number: 14
func_1216D(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2941();
}

//Function Number: 15
func_12167(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 16
func_12157(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 17
func_12581(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("sprint");
}

//Function Number: 18
func_12560(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 19
func_12591(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 20
func_12512(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2956("sprint");
}

//Function Number: 21
func_122B0(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 22
func_12415(param_00,param_01,param_02,param_03)
{
	return !lib_0C78::func_13F91();
}

//Function Number: 23
func_125D0(param_00,param_01,param_02,param_03)
{
	return !lib_0C78::func_13F98();
}

//Function Number: 24
func_120C1(param_00,param_01,param_02,param_03)
{
	return !lib_0C78::func_13F8E();
}

//Function Number: 25
func_11B90(param_00,param_01,param_02,param_03)
{
	return !lib_0C78::func_13F8C();
}

//Function Number: 26
func_125C5(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 27
func_125C6(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 28
func_125CD(param_00,param_01,param_02,param_03)
{
	return !lib_0C78::func_13F95();
}

//Function Number: 29
func_125CF(param_00,param_01,param_02,param_03)
{
	return !lib_0C78::func_13F97();
}

//Function Number: 30
func_125CE(param_00,param_01,param_02,param_03)
{
	return !lib_0C78::func_13F96();
}