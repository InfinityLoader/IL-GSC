/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\crab_boss\mp\states.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 130 ms
 * Timestamp: 10/27/2023 12:01:21 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("crab_boss"))
	{
		return;
	}

	lib_0A1A::func_230B("crab_boss","start_here");
	lib_0A1A::func_2374("start_here",::scripts\asm\crab_boss\crab_boss_asm::asminit,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("entrance",undefined,::scripts\asm\crab_boss\crab_boss_asm::shouldplayentranceanim,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle",::lib_0F3C::func_B050,undefined,undefined,undefined,undefined,::scripts\asm\crab_boss\crab_boss_asm::chooseidleanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("check_actions",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("entrance",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_boss\crab_boss_asm::crabbossnotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("check_actions",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("turn",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,"turn");
	lib_0A1A::func_2375("move",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("smash",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("taunt",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("beam",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("roar_start",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("spawn",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("toxic",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("submerge",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("heal",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("bomb",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("pain",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("toxic_spawn",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("roar",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("death",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("smash",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_boss\crab_boss_asm::smash_notehandler,undefined,undefined,::scripts\asm\crab_boss\crab_boss_asm::choosesmashanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2375("smash_interrupted",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("action_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_generic",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3F00,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("death_moving",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C71::func_3EE2,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2374("pain_generic",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pain_moving",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("decide_idle",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("entrance",undefined,::scripts\asm\crab_boss\crab_boss_asm::shouldplayentranceanim,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("check_interruptables",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("crab_boss_aimset",undefined,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("taunt",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_boss\crab_boss_asm::crabbossnotehandler,undefined,undefined,::scripts\asm\crab_boss\crab_boss_asm::choosetauntanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("beam",::scripts\asm\crab_boss\crab_boss_asm::playbeamanim,undefined,::scripts\asm\crab_boss\crab_boss_asm::beam_notehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isbeamdone,undefined);
	lib_0A1A::func_2375("beam_interrupted",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("roar_start",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_boss\crab_boss_asm::crabbossnotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("roar_loop",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("spawn",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_boss\crab_boss_asm::crabbossnotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("toxic",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_boss\crab_boss_asm::toxic_spawn_notehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("emerge",::scripts\asm\crab_boss\crab_boss_asm::playcrabbossemergeanim,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("submerge",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("submerge_loop",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("heal",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("heal_intro",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("heal_intro",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("heal_loop",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("heal_loop",::scripts\asm\crab_boss\crab_boss_asm::loophealanim,undefined,::scripts\asm\crab_boss\crab_boss_asm::crabbossnotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("heal_exit",undefined,::scripts\asm\crab_boss\crab_boss_asm::isdonehealing,undefined);
	lib_0A1A::func_2374("heal_exit",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("turn",::scripts\asm\crab_boss\crab_boss_asm::playcrabbossturnanim,undefined,::scripts\asm\crab_boss\crab_boss_asm::crabbossnotehandler,undefined,undefined,::scripts\asm\crab_boss\crab_boss_asm::choosecrabbossturnanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("submerge_loop",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("submerge_spawn",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("emerge",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2375("submerge_bomb",undefined,::scripts\asm\crab_boss\crab_boss_asm::shoulddoaction,undefined);
	lib_0A1A::func_2374("submerge_spawn",::lib_0F3C::func_B050,undefined,::scripts\asm\crab_boss\crab_boss_asm::submerge_spawn_notehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("submerge_loop",undefined,::scripts\asm\crab_boss\crab_boss_asm::shouldabortaction,"submerge_spawn");
	lib_0A1A::func_2374("move",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("move_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("move_exit",::scripts\asm\crab_boss\crab_boss_asm::playmoveexit,undefined,undefined,undefined,undefined,::scripts\asm\crab_boss\crab_boss_asm::choosecrabbossmoveanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"code_move",undefined);
	lib_0A1A::func_2375("move_loop",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("move_loop",::scripts\asm\crab_boss\crab_boss_asm::loopcrabbossmoveanim,undefined,undefined,undefined,undefined,::scripts\asm\crab_boss\crab_boss_asm::choosecrabbossmoveanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"code_move",undefined);
	lib_0A1A::func_2375("move_arrival",undefined,::scripts\asm\crab_boss\crab_boss_asm::shouldabortaction,"move");
	lib_0A1A::func_2374("move_arrival",::scripts\asm\crab_boss\crab_boss_asm::playmovearrival,undefined,::scripts\asm\crab_boss\crab_boss_asm::crabbossnotehandler,undefined,undefined,::scripts\asm\crab_boss\crab_boss_asm::choosecrabbossarrivalanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"code_move",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("submerge_bomb",::lib_0F3C::func_B050,undefined,::scripts\asm\crab_boss\crab_boss_asm::submerge_bomb_notehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("submerge_loop",undefined,::scripts\asm\crab_boss\crab_boss_asm::shouldabortaction,"submerge_bomb");
	lib_0A1A::func_2374("bomb",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_boss\crab_boss_asm::bomb_notehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("pain",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::scripts\asm\crab_boss\crab_boss_asm::func_3EE4,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("beam_interrupted",::scripts\asm\crab_boss\crab_boss_asm::playbeamanim,undefined,::scripts\asm\crab_boss\crab_boss_asm::beam_notehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isbeamdone,undefined);
	lib_0A1A::func_2374("smash_interrupted",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_boss\crab_boss_asm::smash_notehandler,undefined,undefined,::scripts\asm\crab_boss\crab_boss_asm::choosesmashinterruptedanim,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("toxic_spawn",::lib_0F3C::func_CEA8,undefined,::scripts\asm\crab_boss\crab_boss_asm::toxicspawn_notehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("roar",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("roar_start",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("roar_loop",::scripts\asm\crab_boss\crab_boss_asm::playroarloop,undefined,::scripts\asm\crab_boss\crab_boss_asm::crabbossnotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("roar_end",undefined,::lib_0A1A::func_68B0,"roar_done");
	lib_0A1A::func_2374("roar_end",::scripts\asm\crab_boss\crab_boss_asm::playroarend,undefined,::scripts\asm\crab_boss\crab_boss_asm::crabbossnotehandler,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"anim deltas",undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2374("death",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("action_done",undefined,::scripts\asm\crab_boss\crab_boss_asm::isanimdone,undefined);
	lib_0A1A::func_2327();
}