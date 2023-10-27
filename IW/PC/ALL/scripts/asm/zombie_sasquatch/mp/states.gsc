/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\asm\zombie_sasquatch\mp\states.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 342 ms
 * Timestamp: 10/27/2023 12:03:04 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("zombie_sasquatch"))
	{
		return;
	}

	lib_0A1A::func_230B("zombie_sasquatch","start_state");
	lib_0A1A::func_2374("start_state",::scripts\asm\zombie_sasquatch\sasquatch_asm::sasquatch_init,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("spawn_fx",undefined,::trans_start_state_to_spawn_fx0,undefined);
	lib_0A1A::func_2375("spawn",undefined,::trans_start_state_to_spawn1,undefined);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("idle",::scripts\asm\zombie_sasquatch\sasquatch_asm::sasquatch_playidleanim,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_standing",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","anim deltas",undefined);
	lib_0A1A::func_2375("exit_to_run",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("melee_swipe",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("throw_rock",undefined,::scripts\asm\zombie_sasquatch\sasquatch_asm::sasq_throwrockrequested,undefined);
	lib_0A1A::func_2375("taunt",undefined,::scripts\asm\zombie_sasquatch\sasquatch_asm::sasq_tauntrequested,undefined);
	lib_0A1A::func_2374("death_generic",::lib_0C71::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("run",::scripts\asm\shared\mp\move_v2::playmoveloopv2,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("run_arrival",undefined,::lib_0A1A::func_C17F,undefined);
	lib_0A1A::func_2375("melee_run_swipe",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0F3B::func_FFF8,"run_turn");
	lib_0A1A::func_2375("rush",undefined,::scripts\asm\shared_utility::func_BD25,"sprint");
	lib_0A1A::func_2375("throw_rock",undefined,::scripts\asm\zombie_sasquatch\sasquatch_asm::sasq_throwrockrequested,undefined);
	lib_0A1A::func_2374("exit_to_run",::lib_0C75::func_CEB7,undefined,undefined,undefined,undefined,::lib_0F3B::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("exit_to_run_complete",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("exit_to_run_complete",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("run_arrival",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("traverse_passthrough",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("melee_swipe",::scripts\asm\zombie_sasquatch\sasquatch_asm::sas_play_meleeattack,undefined,::scripts\asm\zombie_sasquatch\sasquatch_asm::sasquatch_melee_notehandler,::scripts\asm\zombie_sasquatch\sasquatch_asm::sasquatch_melee_cleanup,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_run_swipe",::scripts\asm\zombie_sasquatch\sasquatch_asm::sas_play_meleeattack,undefined,::scripts\asm\zombie_sasquatch\sasquatch_asm::sasquatch_melee_notehandler,::scripts\asm\zombie_sasquatch\sasquatch_asm::sasquatch_melee_cleanup,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("throw_rock",::scripts\asm\zombie_sasquatch\sasquatch_asm::sas_play_throw,undefined,::scripts\asm\zombie_sasquatch\sasquatch_asm::sas_play_throw_notehandler,::scripts\asm\zombie_sasquatch\sasquatch_asm::sas_play_throw_terminate,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("taunt",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"tauntevent","face current","anim deltas",undefined);
	lib_0A1A::func_2375("idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("run_turn",::scripts\asm\shared\mp\move_v2::playsharpturnanimv2,undefined,undefined,undefined,undefined,::lib_0F3B::func_3EF5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("run",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("rush",::scripts\asm\zombie_sasquatch\sasquatch_asm::sas_play_rush,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","code_move",undefined);
	lib_0A1A::func_2375("rush_complete",undefined,::scripts\asm\zombie_sasquatch\sasquatch_asm::sasq_rushnotrequested,undefined);
	lib_0A1A::func_2375("run_arrival",undefined,::lib_0A1A::func_C17F,undefined);
	lib_0A1A::func_2374("exit_to_run_complete",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("rush",undefined,::scripts\asm\shared_utility::func_BD25,"sprint");
	lib_0A1A::func_2375("run",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("rush_attack",::lib_0F3C::func_CEA8,undefined,::scripts\asm\zombie_sasquatch\sasquatch_asm::sas_play_rushattack_notehandler,::scripts\asm\zombie_sasquatch\sasquatch_asm::sas_play_rushattack_cleanup,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("rush_attack_complete",undefined,::lib_0A1A::func_68B0,"hit");
	lib_0A1A::func_2375("idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("spawn",::lib_0C75::func_D571,undefined,undefined,::lib_0C75::func_11702,undefined,::lib_0C75::func_3EFC,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("idle",undefined,::trans_spawn_to_idle0,undefined);
	lib_0A1A::func_2374("pain_standing",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","anim deltas",undefined);
	lib_0A1A::func_2375("idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("rush_complete",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("rush_attack",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("run",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("spawn_fx",::lib_0C75::func_D532,undefined,undefined,undefined,undefined,::lib_0C75::func_3EFB,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("spawn",undefined,::trans_spawn_fx_to_spawn0,undefined);
	lib_0A1A::func_2374("rush_attack_complete",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("run",undefined,::lib_0A1A::func_BCE7,undefined);
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
	lib_0A1A::func_2374("choose_movetype",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("run",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
trans_start_state_to_spawn_fx0(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE96();
}

//Function Number: 3
trans_start_state_to_spawn1(param_00,param_01,param_02,param_03)
{
	return lib_0C75::func_BE97();
}

//Function Number: 4
trans_spawn_to_idle0(param_00,param_01,param_02,param_03)
{
	return self.hasplayedvignetteanim;
}

//Function Number: 5
trans_spawn_fx_to_spawn0(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_8C12) && self.var_8C12;
}