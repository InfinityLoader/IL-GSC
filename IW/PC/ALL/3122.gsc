/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3122.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 76
 * Decompile Time: 304 ms
 * Timestamp: 10/27/2023 12:26:11 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("c6"))
	{
		return;
	}

	lib_0C57::func_2371();
	lib_0C5B::func_2371();
	lib_0C4B::func_2371();
	lib_0A1A::func_230B("c6","c6_start");
	lib_0A1A::func_2373("track",::lib_0A2B::func_11A90);
	lib_0A1A::func_2374("Enter_Combat",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,["shoot"],undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("Knobs",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("NonCombat_Stand_Idle",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"noncombat_stand_idle",undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::func_122DB,undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_BCE7,"walk");
	lib_0A1A::func_2375("grenade_hug_pickup",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("Enter_Combat",undefined,::func_122D6,undefined);
	lib_0A1A::func_2374("c6_start",::lib_0C2F::func_3359,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("NonCombat_Stand_Idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("AnimScripted",::lib_0F3D::func_1FCB,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("NonCombat_Stand_Idle",undefined,::func_11B72,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::func_11B78,"combat");
	lib_0A1A::func_2375("exposed_idle",undefined,::func_11B6F,undefined);
	lib_0A1A::func_2374("step_up_24",::lib_0C6B::func_D566,24,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("iw6_jumpdown_40",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("step_down_24",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("combatrun_forward_72",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("wall_hop",::lib_0C6B::func_D55D,39.875,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpdown_130",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("double_jump_temp",::lib_0C6B::func_D55E,undefined,undefined,undefined,"exposed_idle",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("traverse_external",::lib_0C6B::func_D560,undefined,undefined,undefined,"exposed_idle",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_128",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpup_72",::lib_0C6B::func_D566,72,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpup_96",::lib_0C6B::func_D566,96,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpup_128",::lib_0C6B::func_D566,128,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("jumpup_24",::lib_0C6B::func_D566,24,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpup_36",::lib_0C6B::func_D566,36,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpup_48",::lib_0C6B::func_D566,48,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpdown_24",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpdown_36",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpdown_48",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpdown_72",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpdown_96",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpover_36",::lib_0C6B::func_D566,36,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpover_52",::lib_0C6B::func_D566,52,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpover_64",::lib_0C6B::func_D566,64,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpover_40",::lib_0C6B::func_D566,40,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpdown_rail_72",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpdown_rail_48",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpdown_rail_36",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpdown_rail_24",::lib_0C6B::func_D566,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpup_rail_48",::lib_0C6B::func_D566,48,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpup_rail_36",::lib_0C6B::func_D566,36,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpup_rail_24",::lib_0C6B::func_D566,24,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("jumpup_rail_72",::lib_0C6B::func_D566,72,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("traverse_complete",undefined,::lib_0A1A::func_68B0,"traverse_end");
	lib_0A1A::func_2374("traverse_complete",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crawlmelee_idle",undefined,::func_125D4,undefined);
	lib_0A1A::func_2375("crawlrange_idle",undefined,::lib_0A26::func_337F,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_charge_to_ready",::lib_0F42::func_D4CC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face enemy","zonly_physics",undefined);
	lib_0A1A::func_2375("melee_grab",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_stand_to_ready",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","zonly_physics",undefined);
	lib_0A1A::func_2375("melee_grab",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_charge",::lib_0F42::func_D4D9,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,"melee_charge_state","face motion","normal",undefined);
	lib_0A1A::func_2375("melee_grab",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1B::func_2957,undefined);
	lib_0A1A::func_2374("melee_grab",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_idle",undefined,::func_12273,undefined);
	lib_0A1A::func_2375("melee_endPosition_valid",undefined,::lib_0C30::func_B64E,undefined);
	lib_0A1A::func_2375("melee_decidewinner",undefined,::lib_0C30::func_3386,undefined);
	lib_0A1A::func_2374("melee_grabPlayer",::lib_0C30::func_B61B,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_grab_save_or_kill",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_c6_grabAI",::lib_0F42::func_D4D1,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,"melee_attack","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_savePlayer",::lib_0C30::func_B61F,undefined,::lib_0C30::func_B617,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2374("melee_killPlayer",::lib_0C30::func_B61A,undefined,::lib_0C30::func_B617,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_grabPlayerFinish",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_grab_save_or_kill",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_playerCounter",undefined,::lib_0F3D::func_B5FC,undefined);
	lib_0A1A::func_2375("melee_savePlayer",undefined,::lib_0C30::func_B61E,undefined);
	lib_0A1A::func_2375("melee_killPlayer",undefined,::func_12270,undefined);
	lib_0A1A::func_2374("melee_playerCounter",::lib_0C30::func_B61C,undefined,::lib_0C30::func_B617,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_finish",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_grab_abort",::lib_0C30::func_B60D,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_grabPlayerFinish",::lib_0C30::func_B61D,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_seeker_attack_c6_victim",::lib_0C52::func_D4D0,undefined,::lib_0C64::func_B590,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_finish",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_c6_longchoke_lose",::lib_0F42::func_D4D1,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,"melee_attack","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("melee_finish",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_finish",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_decidewinner",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_randomizer",undefined,::scripts\asm\shared_utility::func_DCB8,undefined);
	lib_0A1A::func_2375("melee_grab_abort",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_c6_throwdown_win",::lib_0F42::func_D4D1,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_finish",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_finish",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_c6_throwdown_lose",::lib_0F42::func_D4D1,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_finish",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_finish",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_c6_charge_lose",::lib_0F42::func_D4D1,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_finish",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_finish",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_finish",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_randomizer",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_c6_longchoke_lose",undefined,::lib_0C30::func_3366,0);
	lib_0A1A::func_2375("melee_c6_throwdown_win",undefined,::lib_0C30::func_3366,1);
	lib_0A1A::func_2375("melee_c6_throwdown_lose",undefined,::lib_0C30::func_3366,0);
	lib_0A1A::func_2375("melee_c6_charge_lose",undefined,::lib_0C30::func_3366,0);
	lib_0A1A::func_2374("melee_endPosition_valid",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_grabPlayer",undefined,::lib_0C30::func_B608,1);
	lib_0A1A::func_2375("melee_grab_abort",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("move_walk_loop",::lib_0F3D::func_D4DD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("NonCombat_Stand_Idle",undefined,::func_122B0,undefined);
	lib_0A1A::func_2374("move_patrol_loop",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("patrol_walk_to_stand_exposed",undefined,::lib_0C5D::func_1008A,"Exposed");
	lib_0A1A::func_2374("stand_exposed_to_patrol_walk",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("move_patrol_loop",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("patrol_walk_to_stand_exposed",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("NonCombat_Stand_Idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("death_generic",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_standing_default",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3F00,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_crouching_default",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3ECA,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_moving_generic",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3EE2,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_cover_default",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3EC6,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_antigrav_grenade",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_antigrav_grenade_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_antigrav_grenade_default",::lib_0C60::func_CF11,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_shocked",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3EF6,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_standing",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_crouching",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2375("death_shocked",undefined,::lib_0C60::func_10052,undefined);
	lib_0A1A::func_2375("shield_bash",undefined,::lib_0C60::func_10051,undefined);
	lib_0A1A::func_2375("death_explosive",undefined,::lib_0C60::func_10045,undefined);
	lib_0A1A::func_2375("death_knife_upgrade",undefined,::lib_0C60::func_FFF0,undefined);
	lib_0A1A::func_2375("death_standing_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_crouching",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_standing",undefined,::lib_0A1B::func_9DA4,"stand");
	lib_0A1A::func_2375("death_shocked",undefined,::lib_0C60::func_10052,undefined);
	lib_0A1A::func_2375("shield_bash",undefined,::lib_0C60::func_10051,undefined);
	lib_0A1A::func_2375("death_explosive_crouch",undefined,::lib_0C60::func_10045,undefined);
	lib_0A1A::func_2375("death_knife_upgrade",undefined,::lib_0C60::func_FFF0,undefined);
	lib_0A1A::func_2375("death_crouching_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_cover",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_shocked",undefined,::lib_0C60::func_10052,undefined);
	lib_0A1A::func_2375("shield_bash",undefined,::lib_0C60::func_10051,undefined);
	lib_0A1A::func_2375("death_explosive",undefined,::lib_0C60::func_10045,undefined);
	lib_0A1A::func_2375("death_knife_upgrade",undefined,::lib_0C60::func_FFF0,undefined);
	lib_0A1A::func_2375("death_cover_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_moving",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_crouching",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2375("death_shocked",undefined,::lib_0C60::func_10052,undefined);
	lib_0A1A::func_2375("shield_bash",undefined,::lib_0C60::func_10051,undefined);
	lib_0A1A::func_2375("death_explosive",undefined,::lib_0C60::func_10045,undefined);
	lib_0A1A::func_2375("death_knife_upgrade",undefined,::lib_0C60::func_FFF0,undefined);
	lib_0A1A::func_2375("death_moving_generic",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("deathcrawl_generic",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("deathcrawl_moving",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("shield_bash",::lib_0A26::func_33AC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_explosive",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3ED8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_explosive_crouch",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3ED8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_knife_upgrade",::lib_0A26::func_3361,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_melee_ragdoll_delayed",::lib_0C60::func_CF0F,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("powerdown_default",::lib_0C31::func_D4FF,undefined,undefined,::lib_0C31::func_697A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",1,::lib_0A1B::func_1005F,undefined);
	lib_0A1A::func_2374("pain_stand",::lib_0C66::func_D4EE,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("exposed_idle",undefined,::func_123DC,undefined);
	lib_0A1A::func_2374("pain_run",::lib_0C66::func_D4EE,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEB,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","normal",undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::func_123D2,undefined);
	lib_0A1A::func_2375("selfdestruct_run",undefined,::lib_0A26::func_C875,undefined);
	lib_0A1A::func_2374("pain_crouch",::lib_0C66::func_D4EE,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE8,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_prone",::lib_0C66::func_D4EE,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2374("pain_cover_right",::lib_0C66::func_CF04,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::func_12364,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::func_1236E,undefined);
	lib_0A1A::func_2374("pain_cover_stand",::lib_0C66::func_CF04,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE7,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_cover_crouch",::lib_0C66::func_CF04,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE6,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_crouch",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_cover_left",::lib_0C66::func_CF04,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("cover_left",0.1,::func_1234A,undefined);
	lib_0A1A::func_2375("cover_left_crouch",0.1,::func_12354,undefined);
	lib_0A1A::func_2374("pain_on_back",::lib_0C66::func_D4EE,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2374("pain_cover_left_suppress",::lib_0C66::func_CF04,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("cover_left",0.1,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_cover_right_suppress",::lib_0C66::func_CF04,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_special",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shocked",undefined,::lib_0A1E::func_9F4C,undefined);
	lib_0A1A::func_2374("shocked",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shock_loop_stand",undefined,::lib_0A1B::func_9DA4,"stand");
	lib_0A1A::func_2375("shock_loop_crouch",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2374("shock_loop_stand",::lib_0C66::func_D517,undefined,::lib_0C2F::func_33AD,::lib_0C66::func_FE4D,undefined,::lib_0C66::func_3EF0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("shock_loop_crouch",::lib_0C66::func_D517,undefined,::lib_0C2F::func_33AD,::lib_0C66::func_FE4D,undefined,::lib_0C66::func_3EF0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("shock_finish_crouch",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("shock_finish_stand",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_crawlmelee",::lib_0C66::func_D4EE,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crawlmelee_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_turretmode",::lib_0C66::func_D4EE,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crawlrange_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_hide_to_shuffle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("crouch_shuffle_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("crouch_shuffle_right",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("stand_shuffle_left",::lib_0C5E::func_D51A,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("shuffle_left_to_cover_stand",undefined,::lib_0C5E::func_FFCA,"Cover Stand");
	lib_0A1A::func_2375("shuffle_left_to_cover_stand",undefined,::lib_0C5E::func_FFCA,"Conceal Stand");
	lib_0A1A::func_2375("shuffle_left_to_cover_left",undefined,::lib_0C5E::func_FFCA,"Cover Left");
	lib_0A1A::func_2375("shuffle_left_to_cover_crouch",0.4,::lib_0C5E::func_FFCA,"Cover Crouch");
	lib_0A1A::func_2375("shuffle_left_to_cover_crouch",0.4,::lib_0C5E::func_FFCA,"Cover Crouch Window");
	lib_0A1A::func_2375("shuffle_left_to_cover_crouch",0.4,::lib_0C5E::func_FFCA,"Conceal Crouch");
	lib_0A1A::func_2374("stand_shuffle_right",::lib_0C5E::func_D51A,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("shuffle_right_to_cover_stand",undefined,::lib_0C5E::func_FFCA,"Cover Stand");
	lib_0A1A::func_2375("shuffle_right_to_cover_stand",undefined,::lib_0C5E::func_FFCA,"Conceal Stand");
	lib_0A1A::func_2375("shuffle_right_to_cover_right",undefined,::lib_0C5E::func_FFCA,"Cover Right");
	lib_0A1A::func_2375("shuffle_right_to_cover_crouch",0.4,::lib_0C5E::func_FFCA,"Cover Crouch");
	lib_0A1A::func_2375("shuffle_right_to_cover_crouch",0.4,::lib_0C5E::func_FFCA,"Cover Crouch Window");
	lib_0A1A::func_2375("shuffle_right_to_cover_crouch",0.4,::lib_0C5E::func_FFCA,"Conceal Crouch");
	lib_0A1A::func_2374("cover_right_hide_to_shuffle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("crouch_shuffle_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("crouch_shuffle_left",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("shuffle_left_to_cover_left",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_to_shuffle_l",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("crouch_shuffle_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("crouch_shuffle_left",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("cover_crouch_to_shuffle_r",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("crouch_shuffle_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("crouch_shuffle_right",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("shuffle_right_to_cover_right",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_to_shuffle_l",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_to_shuffle_l_complete",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("stand_to_shuffle_l_complete",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("cover_stand_to_shuffle_r",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_to_shuffle_r_complete",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("stand_to_shuffle_r_complete",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("crouch_shuffle_left",::lib_0C5E::func_D51A,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("shuffle_left_to_cover_crouch",undefined,::lib_0C5E::func_FFCA,"Cover Crouch");
	lib_0A1A::func_2375("shuffle_left_to_cover_crouch",undefined,::lib_0C5E::func_FFCA,"Cover Crouch Window");
	lib_0A1A::func_2375("shuffle_left_to_cover_crouch",undefined,::lib_0C5E::func_FFCA,"Conceal Crouch");
	lib_0A1A::func_2375("shuffle_left_to_cover_stand",0.4,::lib_0C5E::func_FFCA,"Cover Stand");
	lib_0A1A::func_2375("shuffle_left_to_cover_stand",0.4,::lib_0C5E::func_FFCA,"Conceal Stand");
	lib_0A1A::func_2375("shuffle_left_to_cover_left",0.4,::lib_0C5E::func_FFCA,"Cover Left");
	lib_0A1A::func_2374("crouch_shuffle_right",::lib_0C5E::func_D51A,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("shuffle_right_to_cover_crouch",undefined,::lib_0C5E::func_FFCA,"Cover Crouch");
	lib_0A1A::func_2375("shuffle_right_to_cover_crouch",undefined,::lib_0C5E::func_FFCA,"Cover Crouch Window");
	lib_0A1A::func_2375("shuffle_right_to_cover_crouch",undefined,::lib_0C5E::func_FFCA,"Conceal Crouch");
	lib_0A1A::func_2375("shuffle_right_to_cover_stand",0.4,::lib_0C5E::func_FFCA,"Cover Stand");
	lib_0A1A::func_2375("shuffle_right_to_cover_stand",0.4,::lib_0C5E::func_FFCA,"Conceal Stand");
	lib_0A1A::func_2375("shuffle_right_to_cover_right",0.4,::lib_0C5E::func_FFCA,"Cover Right");
	lib_0A1A::func_2374("shuffle_left_to_cover_stand",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,"stand",undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("shuffle_right_to_cover_stand",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,"stand",undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("shuffle_left_to_cover_crouch",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("shuffle_right_to_cover_crouch",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stand_to_shuffle_l_complete",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("shuffle_left_to_cover_stand",undefined,::lib_0C5E::func_FFCA,"Cover Stand");
	lib_0A1A::func_2375("shuffle_left_to_cover_left",undefined,::lib_0C5E::func_FFCA,"Cover Left");
	lib_0A1A::func_2375("stand_shuffle_left",undefined,::lib_0A1B::func_2936,"Cover Stand");
	lib_0A1A::func_2375("stand_shuffle_left",undefined,::lib_0A1B::func_2936,"Conceal Stand");
	lib_0A1A::func_2375("crouch_shuffle_left",0.4,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("stand_to_shuffle_r_complete",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("shuffle_right_to_cover_stand",undefined,::lib_0C5E::func_FFCA,"Cover Stand");
	lib_0A1A::func_2375("shuffle_right_to_cover_right",undefined,::lib_0C5E::func_FFCA,"Cover Right");
	lib_0A1A::func_2375("stand_shuffle_right",undefined,::lib_0A1B::func_2936,"Cover Stand");
	lib_0A1A::func_2375("stand_shuffle_right",undefined,::lib_0A1B::func_2936,"Conceal Stand");
	lib_0A1A::func_2375("crouch_shuffle_right",0.4,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_right_to_cover_left_door_shuffle",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_to_cover_right_door_shuffle",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_to_shuffle_l_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_stand_to_shuffle_l",undefined,::lib_0C5E::func_10054,undefined);
	lib_0A1A::func_2375("stand_to_shuffle_l_complete",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_right_hide_to_shuffle_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_right_hide_to_shuffle",undefined,::lib_0C5E::func_10054,undefined);
	lib_0A1A::func_2375("crouch_shuffle_left",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_crouch_to_shuffle_l_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_crouch_to_shuffle_l",undefined,::lib_0C5E::func_10054,undefined);
	lib_0A1A::func_2375("crouch_shuffle_left",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_stand_to_shuffle_r_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_stand_to_shuffle_r",undefined,::lib_0C5E::func_10054,undefined);
	lib_0A1A::func_2375("stand_to_shuffle_r_complete",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_crouch_to_shuffle_r_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_crouch_to_shuffle_r",undefined,::lib_0C5E::func_10054,undefined);
	lib_0A1A::func_2375("crouch_shuffle_right",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_left_hide_to_shuffle_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_left_hide_to_shuffle",undefined,::lib_0C5E::func_10054,undefined);
	lib_0A1A::func_2375("crouch_shuffle_right",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("shuffle_abort",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_crouch",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("ik_finger_pose_l",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("ik_finger_pose_r",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("Exposed_Reload",::lib_0F43::func_260,undefined,undefined,::lib_0C68::func_DF4F,undefined,::scripts\asm\shared_utility::func_3EAA,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_throw_grenade",::lib_0C6A::func_CEC6,undefined,undefined,::lib_0C6A::func_CEC7,undefined,::lib_0C6A::func_3EA8,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_stand_turn",::lib_0F43::func_D56A,undefined,undefined,::lib_0F43::func_D56B,undefined,::lib_0C68::func_3F0A,undefined,["notetrackAim"],undefined,["shoot"],undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_idle",::lib_0F43::func_D46D,undefined,undefined,undefined,undefined,::lib_0C2F::func_335C,"_aim_5",["aim"],"stand",["shoot"],undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_throw_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0F43::func_1007E,"Cover Right");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0F43::func_1007E,"Cover Left");
	lib_0A1A::func_2375("melee_grab",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("isselfdestruct",undefined,::func_12141,undefined);
	lib_0A1A::func_2375("grenade_hug_pickup",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0F43::func_1007E,"Cover Left Crouch");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0F43::func_1007E,"Cover Right Crouch");
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0F43::func_1007E,"Cover Stand");
	lib_0A1A::func_2375("cover_crouch_stand",undefined,::lib_0F43::func_1007E,"Cover Crouch");
	lib_0A1A::func_2375("exposed_stand_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("exposed_stand_to_crouch",undefined,::lib_0A1B::func_2949,"prone");
	lib_0A1A::func_2375("exposed_stand_turn",undefined,::lib_0C68::func_BEA0,undefined);
	lib_0A1A::func_2375("Exposed_Reload",undefined,::func_12118,undefined);
	lib_0A1A::func_2374("exposed_stand_to_prone",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_prone",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_prone",::lib_0F43::func_D46D,undefined,undefined,undefined,undefined,::lib_0F3D::func_3EAB,"_aim_5",undefined,"prone",undefined,undefined,"pain_prone",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_prone_to_stand",undefined,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2375("exposed_prone_to_stand",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_prone_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2374("exposed_prone_to_stand",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_stand_to_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch",::lib_0F43::func_D46D,undefined,undefined,undefined,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch_turn",undefined,::lib_0C68::func_BEA0,undefined);
	lib_0A1A::func_2375("exposed_crouch_reload",undefined,::func_120E0,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::func_120CA,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::func_120CB,undefined);
	lib_0A1A::func_2375("melee_grab",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0F43::func_1007E,"Cover Left Crouch");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0F43::func_1007E,"Cover Right Crouch");
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0F43::func_1007E,"Cover Crouch");
	lib_0A1A::func_2375("grenade_hug_pickup",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("exposed_crouch_to_stand",undefined,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2375("exposed_crouch_to_stand",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2374("exposed_crouch_to_stand",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_prone_to_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_to_prone",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_prone",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_turn",::lib_0F43::func_D56A,undefined,undefined,::lib_0F43::func_D56B,undefined,::lib_0C68::func_3ECC,undefined,undefined,undefined,undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_reload",::lib_0F43::func_260,undefined,undefined,::lib_0C68::func_DF4F,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand",::lib_0C5E::func_CF02,"stickToNode",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"stand",undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_stand_to_shuffle_r_pass",undefined,::lib_0A1B::func_2935,"right");
	lib_0A1A::func_2375("cover_stand_to_shuffle_l_pass",undefined,::lib_0A1B::func_2935,"left");
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_stand_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_stand_peek",undefined,::lib_0A1B::func_2948,"peek");
	lib_0A1A::func_2375("cover_stand_reload",undefined,::func_11F96,undefined);
	lib_0A1A::func_2375("cover_stand_blindfire",undefined,::func_11F7B,undefined);
	lib_0A1A::func_2375("cover_stand_hide_to_full_exposed",undefined,::lib_0A1B::func_2948,"full exposed");
	lib_0A1A::func_2375("cover_stand_hide_to_look",undefined,::lib_0A1B::func_2948,"look");
	lib_0A1A::func_2375("cover_stand_hide_to_exposed",undefined,::lib_0A1B::func_2948,"exposed");
	lib_0A1A::func_2374("cover_stand_exposed",::lib_0C5E::func_CF02,undefined,undefined,undefined,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"stand",["shoot"],undefined,"pain_stand","cover_stand_exposed","death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_stand_exposed_to_hide",undefined,::func_11F4D,undefined);
	lib_0A1A::func_2375("cover_stand_exposed_reload",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2374("cover_stand_hide_to_exposed",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_exposed",["notetrackAim"],undefined,undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_exposed",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_exposed_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_full_exposed",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["shoot"],undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_stand_full_exposed_to_hide",undefined,::func_11F59,undefined);
	lib_0A1A::func_2375("cover_stand_full_exposed_reload",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2374("cover_stand_hide_to_full_exposed",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_full_exposed",["notetrackAim"],undefined,undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_full_exposed",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_full_exposed_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_blindfire",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_blindfire",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_reload",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_peek",::lib_0C5E::func_CEFC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,"cover_peek","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_stand",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_stand",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_stand_hide_to_look",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_look",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_look",::lib_0C5E::func_CF02,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_stand_look_to_hide",undefined,::func_11F6E,undefined);
	lib_0A1A::func_2374("cover_stand_look_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_exposed_reload",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand","cover_stand_exposed","death_standing",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand_exposed",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_full_exposed_reload",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand","cover_stand_full_exposed","death_standing",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_stand_full_exposed",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_cover_stand_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_stand_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_stand_to_exposed_idle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"to_exposed_idle",["notetrackAim"],undefined,["shoot"],undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch",::lib_0C5E::func_CF02,"stickToNode",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_crouch_to_shuffle_l_pass",undefined,::lib_0A1B::func_2935,"left");
	lib_0A1A::func_2375("cover_crouch_to_shuffle_r_pass",undefined,::lib_0A1B::func_2935,"right");
	lib_0A1A::func_2375("pass_cover_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch_hide_to_stand",undefined,::func_11CA3,undefined);
	lib_0A1A::func_2375("cover_crouch_blindfire",undefined,::func_11C85,undefined);
	lib_0A1A::func_2375("cover_crouch_reload",undefined,::func_11CAB,undefined);
	lib_0A1A::func_2375("cover_crouch_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_crouch_hide_to_lean",undefined,::lib_0A1B::func_2946,"leanover");
	lib_0A1A::func_2375("cover_crouch_hide_to_left",undefined,::lib_0A1B::func_2946,"left");
	lib_0A1A::func_2375("cover_crouch_hide_to_right",undefined,::lib_0A1B::func_2946,"right");
	lib_0A1A::func_2375("cover_crouch_peek",undefined,::lib_0A1B::func_2948,"peek");
	lib_0A1A::func_2375("cover_crouch_hide_to_stand",undefined,::lib_0A1B::func_2946,"full exposed");
	lib_0A1A::func_2375("cover_crouch_hide_to_aim",undefined,::lib_0A1B::func_2948,"exposed");
	lib_0A1A::func_2374("cover_crouch_hide_to_stand",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_stand",["notetrackAim"],undefined,undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_hide_to_aim",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_aim",["notetrackAim"],"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_aim",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_aim_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_hide_to_right",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_right",["notetrackAim"],"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_right_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_stand_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_hide_to_left",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_left",["notetrackAim"],"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_left_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_hide_to_lean",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_lean",["notetrackAim"],"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_lean",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_lean_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_blindfire",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_blindfire",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_reload",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_aim",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch_aim_to_hide",undefined,::func_11C0D,undefined);
	lib_0A1A::func_2375("cover_crouch_aim_reload",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2374("cover_crouch_lean",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_lean_to_hide",undefined,::lib_0A1B::func_2943,"leanover");
	lib_0A1A::func_2374("cover_crouch_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_crouch_exposed_left",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],undefined,"pain_crouch","cover_crouch_exposed_left","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch_left_to_hide",undefined,::lib_0A1B::func_2943,"left");
	lib_0A1A::func_2375("cover_crouch_exposed_left_drop_rpg",undefined,::func_11C19,undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_left_reload",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2374("cover_crouch_exposed_right",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],undefined,"pain_crouch","cover_crouch_exposed_right","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch_right_to_hide",undefined,::lib_0A1B::func_2943,"right");
	lib_0A1A::func_2375("cover_crouch_exposed_right_drop_rpg",undefined,::func_11C33,undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_right_reload",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2374("cover_crouch_stand",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"stand",["shoot"],undefined,"pain_stand","cover_crouch_stand","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch_stand_to_hide",undefined,::lib_0A1B::func_2943,"full exposed");
	lib_0A1A::func_2375("cover_crouch_stand_drop_rpg",undefined,::func_11C69,undefined);
	lib_0A1A::func_2375("cover_crouch_stand_reload",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2374("cover_crouch_peek",::lib_0C5E::func_CEFC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,"cover_peek","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_stand_drop_rpg",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand","cover_crouch_stand","death_cover","cover_crouch",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_exposed_left_drop_rpg",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_exposed_right_drop_rpg",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_stand_reload",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand","cover_crouch_stand","death_cover","cover_crouch",undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_crouch_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_aim_reload",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_crouch_aim",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_exposed_left_reload",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch","cover_crouch_exposed_left","death_crouching",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_exposed_right_reload",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch","cover_crouch_exposed_right","death_generic",undefined,undefined,undefined,"reload",undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_cover_crouch_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_crouch_to_exposed_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"to_exposed_crouch",["notetrackAim"],undefined,["shoot"],undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_reload",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_A_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exposed_A",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["shoot_cover_A"],undefined,"pain_stand","cover_right_exposed_A","death_standing",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("cover_right_A_to_B",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_A_to_B",undefined,::lib_0A1B::func_2947,"B");
	lib_0A1A::func_2375("cover_right_exposed_drop_rpg_A",undefined,::func_11EAD,undefined);
	lib_0A1A::func_2375("cover_right_exposed_reload_A",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2375("cover_right_A_to_hide",undefined,::lib_0A1B::func_2943,"A");
	lib_0A1A::func_2374("cover_right_hide_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_exposed",["notetrackAim"],undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exposed_B",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["shoot"],undefined,"pain_cover_right_suppress",[undefined,"B"],"death_standing",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_B_to_A",undefined,::lib_0A1B::func_2947,"A");
	lib_0A1A::func_2375("cover_right_exposed_drop_rpg_B",undefined,::func_11EC3,undefined);
	lib_0A1A::func_2375("cover_right_exposed_reload_B",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2375("cover_right_B_to_hide",undefined,::lib_0A1B::func_2943,"B");
	lib_0A1A::func_2374("cover_right_B_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right_suppress",[undefined,"B"],"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_hide_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_exposed",["notetrackAim"],undefined,undefined,undefined,"pain_cover_right_suppress",[undefined,"B"],"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right",::lib_0C5E::func_CF02,"stickToNode",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"stand",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_to_cover_left_door_shuffle",undefined,::lib_0A1B::func_2933,"right");
	lib_0A1A::func_2375("cover_right_hide_to_shuffle_pass",0.4,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_reload",undefined,::func_11F30,undefined);
	lib_0A1A::func_2375("cover_right_hide_to_look",undefined,::lib_0A1B::func_2948,"look");
	lib_0A1A::func_2375("cover_right_stand_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("cover_right_peek",undefined,::lib_0A1B::func_2948,"peek");
	lib_0A1A::func_2375("cover_right_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_right_blindfire",undefined,::func_11EE9,undefined);
	lib_0A1A::func_2375("cover_right_hide_to_B",undefined,::func_11F14,undefined);
	lib_0A1A::func_2375("cover_right_hide_to_A",undefined,::func_11F06,undefined);
	lib_0A1A::func_2375("cover_right_hide_to_lean",undefined,::func_11F22,undefined);
	lib_0A1A::func_2374("cover_right_hide_to_look",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_look",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_look",::lib_0C5E::func_CF02,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_look_to_hide",undefined,::func_11EDC,undefined);
	lib_0A1A::func_2374("cover_right_look_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_A_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"A_to_B",["aim"],undefined,undefined,undefined,"pain_cover_right_suppress",[undefined,"B"],"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_B_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"B_to_A",["notetrackAim"],undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch",::lib_0C5E::func_CF02,"stickToNode",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_to_cover_left_door_shuffle",undefined,::lib_0A1B::func_2933,"right");
	lib_0A1A::func_2375("cover_right_hide_to_shuffle_pass",undefined,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("pass_cover_right_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_crouch_to_stand",undefined,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2375("cover_right_crouch_reload",undefined,::func_11E87,undefined);
	lib_0A1A::func_2375("cover_right_crouch_hide_to_look",undefined,::lib_0A1B::func_2948,"look");
	lib_0A1A::func_2375("cover_right_crouch_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_right_crouch_hide_to_A",undefined,::func_11E55,undefined);
	lib_0A1A::func_2375("cover_right_crouch_hide_to_B",undefined,::func_11E63,undefined);
	lib_0A1A::func_2375("cover_right_crouch_hide_to_lean",undefined,::func_11E71,undefined);
	lib_0A1A::func_2374("cover_right_stand_to_crouch",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_stance_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_to_stand",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_stance_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_exposed_A",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot_cover_A"],undefined,"pain_crouch","cover_right_crouch_exposed_A","death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("cover_right_crouch_A_to_B",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_crouch_A_to_B",undefined,::lib_0A1B::func_2947,"B");
	lib_0A1A::func_2375("cover_right_crouch_exposed_drop_rpg_A",undefined,::func_11E0A,undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_reload_A",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2375("cover_right_crouch_A_to_hide",undefined,::lib_0A1B::func_2943,"A");
	lib_0A1A::func_2374("cover_right_crouch_exposed_B",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],undefined,"pain_crouch","cover_right_crouch_exposed_B","death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_crouch_B_to_A",undefined,::lib_0A1B::func_2947,"A");
	lib_0A1A::func_2375("cover_right_crouch_exposed_drop_rpg_B",undefined,::func_11E1E,undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_reload_B",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2375("cover_right_crouch_B_to_hide",undefined,::lib_0A1B::func_2943,"B");
	lib_0A1A::func_2374("cover_right_crouch_hide_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_A",["notetrackAim"],"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_hide_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_B",["notetrackAim"],"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_A_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_B_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_A_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"A_to_B",["aim"],"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_B_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"B_to_A",["aim"],"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_reload",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_right_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_look",::lib_0C5E::func_CF02,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_crouch_look_to_hide",undefined,::func_11E31,undefined);
	lib_0A1A::func_2374("cover_right_crouch_hide_to_look",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch_look",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_look_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_peek",::lib_0C5E::func_CEFC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,"cover_peek",undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_right_crouch_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_right_blindfire",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_blindfire",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_right",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_lean",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["corner_cover_lean_shoot"],undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_lean_to_hide",undefined,::lib_0A1B::func_2948,"hide");
	lib_0A1A::func_2374("cover_right_hide_to_lean",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_lean",["notetrackAim"],undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_lean",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_lean_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_hide_to_lean",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_lean",["notetrackAim"],"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch_lean",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_lean",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["corner_cover_lean_shoot"],undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_crouch_lean_to_hide",undefined,::lib_0A1B::func_2948,"hide");
	lib_0A1A::func_2374("cover_right_crouch_lean_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_right",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exposed_drop_rpg_B",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right_suppress",[undefined,"B"],"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_exposed_drop_rpg_A",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exposed_drop_rpg_A",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_exposed_drop_rpg_B",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exposed_reload_B",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right_suppress",[undefined,"B"],"death_standing",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exposed_reload_A",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand","cover_right_exposed_A","death_standing",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_exposed_reload_A",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch","cover_right_crouch_exposed_A","death_crouching",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_exposed_reload_B",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch","cover_right_crouch_exposed_B","death_crouching",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_cover_right_crouch_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_right_crouch_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_cover_right_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_right_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_right_to_exposed_idle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"to_exposed_idle",["aim"],undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_to_exposed_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"to_exposed_crouch",["aim"],undefined,undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left",::lib_0C5E::func_CF02,"stickToNode",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_to_cover_right_door_shuffle",undefined,::lib_0A1B::func_2933,"left");
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_hide_to_shuffle_pass",0.4,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("cover_left_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_reload",undefined,::func_11DE4,undefined);
	lib_0A1A::func_2375("cover_left_hide_to_look",undefined,::lib_0A1B::func_2948,"look");
	lib_0A1A::func_2375("cover_left_stand_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("cover_left_peek",undefined,::lib_0A1B::func_2948,"peek");
	lib_0A1A::func_2375("cover_left_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_left_blindfire",undefined,::func_11D9C,undefined);
	lib_0A1A::func_2375("cover_left_hide_to_A",undefined,::func_11DBA,undefined);
	lib_0A1A::func_2375("cover_left_hide_to_B",undefined,::func_11DC8,undefined);
	lib_0A1A::func_2375("cover_left_hide_to_lean",undefined,::func_11DD6,undefined);
	lib_0A1A::func_2374("cover_left_reload",::lib_0F3D::func_CEA8,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_exposed_A",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["shoot_cover_A"],undefined,"pain_cover_left_suppress",[undefined,"A"],"death_standing",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_A_to_B",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("cover_left_A_to_B",undefined,::lib_0A1B::func_2947,"B");
	lib_0A1A::func_2375("cover_left_exposed_drop_rpg_A",undefined,::func_11D6D,undefined);
	lib_0A1A::func_2375("cover_left_exposed_reload_A",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2375("cover_left_A_to_hide",undefined,::lib_0A1B::func_2943,"A");
	lib_0A1A::func_2374("cover_left_exposed_B",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["shoot"],undefined,"pain_cover_left_suppress",[undefined,"B"],"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_B_to_A",undefined,::lib_0A1B::func_2947,"A");
	lib_0A1A::func_2375("cover_left_exposed_drop_rpg_B",undefined,::func_11D78,undefined);
	lib_0A1A::func_2375("cover_left_exposed_reload_B",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2375("cover_left_B_to_hide",undefined,::lib_0A1B::func_2943,"B");
	lib_0A1A::func_2374("cover_left_hide_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_exposed",["notetrackAim"],undefined,undefined,undefined,"pain_cover_left_suppress",[undefined,"A"],"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_A_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_hide_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_exposed",["notetrackAim"],undefined,undefined,undefined,"pain_cover_left_suppress",[undefined,"B"],"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_B_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left_suppress",[undefined,"B"],"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_A_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"A_to_B",["aim"],undefined,undefined,undefined,"pain_cover_left_suppress",[undefined,"B"],"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_B_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"B_to_A",["aim"],undefined,undefined,undefined,"pain_cover_left_suppress",[undefined,"A"],"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_look",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_look_to_hide",undefined,::func_11D8E,undefined);
	lib_0A1A::func_2374("cover_left_look_to_hide",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_hide_to_look",::lib_0F3D::func_CEA8,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_look",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch",::lib_0C5E::func_CF02,"stickToNode",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_to_cover_right_door_shuffle",undefined,::lib_0A1B::func_2933,"left");
	lib_0A1A::func_2375("cover_left_hide_to_shuffle_pass",undefined,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_stand",undefined,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2375("cover_left_crouch_reload",undefined,::func_11D51,undefined);
	lib_0A1A::func_2375("cover_left_crouch_hide_to_look",undefined,::lib_0A1B::func_2948,"look");
	lib_0A1A::func_2375("cover_left_crouch_peek",undefined,::lib_0A1B::func_2948,"peek");
	lib_0A1A::func_2375("cover_left_crouch_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_left_crouch_hide_to_A",undefined,::func_11D24,undefined);
	lib_0A1A::func_2375("cover_left_crouch_hide_to_B",undefined,::func_11D33,undefined);
	lib_0A1A::func_2375("cover_left_crouch_hide_to_lean",undefined,::func_11D42,undefined);
	lib_0A1A::func_2374("cover_left_crouch_to_stand",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_stance_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_exposed_A",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot_cover_A"],undefined,"pain_crouch","cover_left_crouch_exposed_A","death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch_A_to_B",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("cover_left_crouch_A_to_B",undefined,::lib_0A1B::func_2947,"B");
	lib_0A1A::func_2375("cover_left_crouch_exposed_drop_rpg_A",undefined,::func_11CD9,undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_reload_A",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2375("cover_left_crouch_A_to_hide",undefined,::lib_0A1B::func_2943,"A");
	lib_0A1A::func_2374("cover_left_crouch_exposed_B",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],undefined,"pain_crouch","cover_left_crouch_exposed_B","death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch_B_to_A",undefined,::lib_0A1B::func_2947,"A");
	lib_0A1A::func_2375("cover_left_crouch_exposed_drop_rpg_B",undefined,::func_11CED,undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_reload_B",undefined,::lib_0C5E::func_FFDA,undefined);
	lib_0A1A::func_2375("cover_left_crouch_B_to_hide",undefined,::lib_0A1B::func_2943,"B");
	lib_0A1A::func_2374("cover_left_crouch_hide_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_A",["notetrackAim"],"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_hide_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_B",["notetrackAim"],"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_A_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_B_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_A_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"A_to_B",["aim"],"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_B_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"B_to_A",["aim"],"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_reload",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_look",::lib_0C5E::func_CF02,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch_look_to_hide",undefined,::func_11D00,undefined);
	lib_0A1A::func_2374("cover_left_crouch_hide_to_look",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch_look",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_look_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_stand_to_crouch",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_stance_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_peek",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,"cover_peek",undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2374("cover_left_crouch_peek",::lib_0C5E::func_CEFC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,"cover_peek",undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_left_crouch_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_left_blindfire",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_blindfire",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_left",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_hide_to_lean",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_lean",["notetrackAim"],undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_lean",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_lean",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["corner_cover_lean_shoot"],undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_lean_to_hide",undefined,::lib_0A1B::func_2948,"hide");
	lib_0A1A::func_2374("cover_left_lean_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_hide_to_lean",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_lean",["notetrackAim"],"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch_lean",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_lean",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["corner_cover_lean_shoot"],undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch_lean_to_hide",undefined,::lib_0A1B::func_2948,"hide");
	lib_0A1A::func_2374("cover_left_crouch_lean_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_cover_left",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_exposed_drop_rpg_B",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left_suppress",[undefined,"B"],"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_exposed_drop_rpg_A",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_exposed_drop_rpg_A",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left_suppress",[undefined,"A"],"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_exposed_drop_rpg_B",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch","cover_left_crouch_exposed_B","death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_exposed_reload_A",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left_suppress",[undefined,"A"],"death_standing",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_exposed_reload_A",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch","cover_left_crouch_exposed_A","death_crouching",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_exposed_reload_B",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_left_suppress",[undefined,"B"],"death_standing",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_exposed_reload_B",::lib_0C5E::func_4742,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch","cover_left_crouch_exposed_B","death_crouching",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_cover_left_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_left_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_cover_left_crouch_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_left_crouch_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_left_to_exposed_idle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"to_exposed_idle",["aim"],undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_to_exposed_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"to_exposed_crouch",["aim"],undefined,undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Right",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("exposed_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Exposed",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,[undefined,1],undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("melee_charge",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("stand_run_loop",::lib_0F3D::func_D4DD,undefined,undefined,undefined,undefined,::lib_0C2F::func_335D,"move",["(none)"],"stand",undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face enemy or motion","normal",undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0C65::func_FFF8,["run_turn",1]);
	lib_0A1A::func_2375("pass_run_should_arrive",undefined,::lib_0C5D::func_FFD4,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::func_1257B,undefined);
	lib_0A1A::func_2375("pass_run_n_gun",undefined,::lib_0C65::func_1006E,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0F43::func_1007E,"Cover Right");
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0F43::func_1007E,"Cover Crouch");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0F43::func_1007E,"Cover Left");
	lib_0A1A::func_2375("melee_charge",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("melee_grab",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("grenade_hug_pickup_moving",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1B::func_2958,undefined);
	lib_0A1A::func_2375("stand_run_strafe_loop",undefined,::lib_0F3D::func_100A3,undefined);
	lib_0A1A::func_2375("pass_stairs",undefined,::lib_0C65::func_9EC3,undefined);
	lib_0A1A::func_2375("stairs_run_up_arrival",undefined,::lib_0C65::func_10005,"up");
	lib_0A1A::func_2375("stairs_run_down_arrival",undefined,::lib_0C65::func_10005,"down");
	lib_0A1A::func_2375("stand_run_reload",undefined,::lib_0C65::func_10068,undefined);
	lib_0A1A::func_2374("run_turn",::lib_0C65::func_D514,undefined,undefined,undefined,undefined,::lib_0C65::func_3EF5,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("cover_left_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Left",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("cover_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("cover_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Crouch",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("cover_stand_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Stand",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stand_run_strafe_loop",::lib_0C65::func_D4E5,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,["aim"],"stand",["shoot"],undefined,"pain_stand",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::func_125AC,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_C17F,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::func_12597,undefined);
	lib_0A1A::func_2375("grenade_hug_pickup_moving",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2374("stand_run_n_gun_loop",::lib_0C65::func_D50D,undefined,undefined,::lib_0C65::func_11088,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,["shoot"],undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_n_gun_backwards_loop",undefined,::lib_0C65::func_1006F,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0C65::func_FFF8,["run_turn",1]);
	lib_0A1A::func_2375("stairs_run_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0C65::func_1009F,undefined);
	lib_0A1A::func_2375("stairs_run_up_arrival",undefined,::lib_0C65::func_10005,"up");
	lib_0A1A::func_2374("stand_run_n_gun_backwards_loop",::lib_0C65::func_D50E,undefined,undefined,::lib_0C65::func_11088,undefined,::lib_0F3D::func_3E96,"move_back",undefined,undefined,["shoot"],undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_n_gun_loop",undefined,::lib_0C65::func_10070,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0C65::func_FFF8,["run_turn",1]);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0C65::func_1009E,undefined);
	lib_0A1A::func_2374("cover_left_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("cover_right_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("cover_left_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Left Crouch",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Right Crouch",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Exposed Crouch",undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,[undefined,1],undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("melee_charge",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2374("sprint_loop",::lib_0F3D::func_D4DD,undefined,undefined,undefined,undefined,::lib_0C65::func_3EFF,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::func_12511,undefined);
	lib_0A1A::func_2375("stairs_run_up_arrival",undefined,::lib_0C65::func_10005,"up");
	lib_0A1A::func_2375("stairs_run_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2375("stairs_run_down_arrival",undefined,::lib_0C65::func_10005,"down");
	lib_0A1A::func_2375("stairs_run_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2375("grenade_hug_pickup_moving",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2374("pass_run_should_arrive",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Cover Crouch",1]);
	lib_0A1A::func_2375("cover_stand_arrival",undefined,::lib_0C5D::func_1008F,["Cover Stand",1]);
	lib_0A1A::func_2375("cover_left_arrival",undefined,::lib_0C5D::func_1008F,["Cover Left",1]);
	lib_0A1A::func_2375("cover_right_arrival",undefined,::lib_0C5D::func_1008F,["Cover Right",1]);
	lib_0A1A::func_2375("cover_left_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Cover Left Crouch",1]);
	lib_0A1A::func_2375("cover_right_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Cover Right Crouch",1]);
	lib_0A1A::func_2375("exposed_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Exposed Crouch",1]);
	lib_0A1A::func_2375("exposed_arrival",undefined,::lib_0C5D::func_1008F,["Exposed",1]);
	lib_0A1A::func_2374("stand_run_reload",::lib_0C65::func_D506,undefined,undefined,::lib_0C65::func_116FE,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,"reload","face motion","normal",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_run_n_gun",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stand_run_n_gun_loop",undefined,::lib_0C65::func_10070,undefined);
	lib_0A1A::func_2375("stand_run_n_gun_backwards_loop",undefined,::lib_0C65::func_1006F,undefined);
	lib_0A1A::func_2374("stairs_run_up_arrival",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_run_up_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("stairs_run_up_exit",undefined,::lib_0C65::func_10030,"up");
	lib_0A1A::func_2374("stairs_run_up_exit",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_run_up_loop",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA6,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_run_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2375("stairs_run_up_exit",undefined,::lib_0C65::func_10030,"up");
	lib_0A1A::func_2374("stairs_run_down_loop",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA6,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_run_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2375("stairs_run_down_exit",undefined,::lib_0C65::func_1000E,"down");
	lib_0A1A::func_2374("pass_stairs",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stairs_run_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2375("stairs_run_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2374("stairs_run_down_exit",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_run_down_arrival",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_run_down_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("stairs_run_down_exit",undefined,::lib_0C65::func_10030,"down");
	lib_0A1A::func_2374("dismember",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crawlRange_or_crawlMelee",undefined,::lib_0A1B::func_2945,"right_leg");
	lib_0A1A::func_2375("crawlRange_or_crawlMelee",undefined,::lib_0A1B::func_2945,"left_leg");
	lib_0A1A::func_2375("left_arm_isCrawling",undefined,::lib_0A1B::func_2945,"left_arm");
	lib_0A1A::func_2375("right_arm_isCrawling",undefined,::lib_0A1B::func_2945,"right_arm");
	lib_0A1A::func_2374("dismember_right_arm",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0A26::func_3ED1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"dismember_done",undefined,undefined,undefined);
	lib_0A1A::func_2375("selfdestruct_run",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("selfdestruct_run",undefined,::func_1209D,undefined);
	lib_0A1A::func_2374("selfdestruct_run",::lib_0F3D::func_D4DD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,["(none)"],undefined,undefined,undefined,"pain_run",undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("selfdestruct_stop",undefined,::lib_0A26::func_10073,undefined);
	lib_0A1A::func_2375("selfdestruct_stop",undefined,::lib_0A1A::func_C17F,undefined);
	lib_0A1A::func_2374("dismember_left_arm",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("selfdestruct_stop",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0A26::func_3ED1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("selfdestruct_run",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2374("crawlmelee_move",::lib_0F3D::func_D4DD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"prone",undefined,undefined,"pain_crawlmelee",undefined,"deathcrawl_moving",undefined,"crawlmelee_powerdown",undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("crawlmelee_turn",undefined,::lib_0C65::func_FFF8,["crawlmelee_turn",1]);
	lib_0A1A::func_2375("crawlmelee_choose_attack",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("crawlmelee_idle",undefined,::func_12021,undefined);
	lib_0A1A::func_2374("crawlmelee_idle",::lib_0C2F::func_335E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"prone",undefined,undefined,"pain_crawlmelee",undefined,"deathcrawl_generic",undefined,"crawlmelee_powerdown",undefined,undefined,"face current","none",undefined);
	lib_0A1A::func_2375("crawlmelee_choose_attack",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("crawlmelee_move",undefined,::func_1201A,undefined);
	lib_0A1A::func_2374("crawlmelee_attack",::lib_0F42::func_D4D7,"c6_crawl_melee",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_moving",undefined,undefined,undefined,"melee_attack","face enemy","zonly_physics",undefined);
	lib_0A1A::func_2375("crawlmelee_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_left_leg",::lib_0F3D::func_CEDA,"c6_leg_dismember_fall",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_generic",undefined,"crawlrange_powerdown",undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("crawlrange_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_right_leg",::lib_0F3D::func_CEDA,"c6_leg_dismember_fall",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_generic",undefined,"crawlrange_powerdown",undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("crawlrange_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("right_arm_isCrawling",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("dismember_right_arm",undefined,::func_12418,undefined);
	lib_0A1A::func_2374("left_arm_isCrawling",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("dismember_left_arm",undefined,::func_1225A,undefined);
	lib_0A1A::func_2374("crawlmelee_turn",::lib_0C65::func_D514,undefined,undefined,undefined,undefined,::lib_0C65::func_3EF5,undefined,undefined,"prone",undefined,undefined,"pain_crawlmelee",undefined,"deathcrawl_moving",undefined,"crawlmelee_powerdown",undefined,undefined,"face enemy or motion","zonly_physics",undefined);
	lib_0A1A::func_2375("crawlmelee_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("crawlrange_idle",::lib_0C2F::func_335E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"prone",["shoot"],undefined,"pain_turretmode",undefined,"deathcrawl_generic",undefined,"crawlrange_powerdown",undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("crawlmelee_idle",undefined,::func_12024,undefined);
	lib_0A1A::func_2375("crawlrange_reload",undefined,::func_1202A,undefined);
	lib_0A1A::func_2375("crawlrange_turn",undefined,::lib_0C68::func_BEA0,undefined);
	lib_0A1A::func_2374("crawlRange_or_crawlMelee",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crawlMelee",undefined,::func_1202E,undefined);
	lib_0A1A::func_2375("turret",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("crawlrange_turn",::lib_0F43::func_D56A,undefined,undefined,::lib_0F43::func_D56B,undefined,::lib_0C68::func_3F0A,undefined,undefined,undefined,undefined,undefined,"pain_turretmode",undefined,"deathcrawl_generic",undefined,"crawlrange_powerdown",undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("crawlrange_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("crawlrange_reload",::lib_0F43::func_260,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_turretmode",undefined,"deathcrawl_generic",undefined,"crawlrange_powerdown",undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("crawlrange_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("crawlMelee",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("dismember_left_leg_crawl",undefined,::lib_0A1B::func_2945,"left_leg");
	lib_0A1A::func_2375("dismember_right_leg_crawl",undefined,::lib_0A1B::func_2945,"right_leg");
	lib_0A1A::func_2374("turret",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("dismember_left_leg",undefined,::lib_0A1B::func_2945,"left_leg");
	lib_0A1A::func_2375("dismember_right_leg",undefined,::lib_0A1B::func_2945,"right_leg");
	lib_0A1A::func_2374("dismember_left_leg_crawl",::lib_0F3D::func_CEDA,"c6_leg_dismember_fall",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_generic",undefined,"crawlmelee_powerdown",undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crawlmelee_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_right_leg_crawl",::lib_0F3D::func_CEDA,"c6_leg_dismember_fall",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_generic",undefined,"crawlmelee_powerdown",undefined,undefined,"face enemy or motion","zonly_physics",undefined);
	lib_0A1A::func_2375("crawlmelee_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("crawlmelee_choose_attack",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crawlmelee_grab_player",undefined,::lib_0C30::func_B64E,undefined);
	lib_0A1A::func_2375("crawlmelee_attack",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("crawlmelee_grab_player",::lib_0C30::func_4885,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("crawlmelee_grab_playerloop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("crawlmelee_grab_killplayer",::lib_0C30::func_4888,undefined,::lib_0C30::func_B617,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawlmelee_grab_playercounter",::lib_0C30::func_488A,undefined,::lib_0C30::func_B617,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("crawlmelee_grab_playerloop",::lib_0C30::func_4886,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crawlmelee_grab_playercounter",undefined,::lib_0F3D::func_B5FC,undefined);
	lib_0A1A::func_2375("crawlmelee_grab_killplayer",undefined,::lib_0F3D::func_B5FD,undefined);
	lib_0A1A::func_2374("isselfdestruct",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("selfdestruct_run",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("selfdestruct_stop",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("crawlrange_powerdown",::lib_0C31::func_D4FF,undefined,undefined,::lib_0C31::func_697A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("crawlrange_powerup",undefined,::lib_0A1B::func_1005F,undefined);
	lib_0A1A::func_2374("crawlrange_powerup",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crawlrange_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("crawlmelee_powerdown",::lib_0C31::func_D4FF,undefined,undefined,::lib_0C31::func_697A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("crawlmelee_powerup",undefined,::lib_0A1B::func_1005F,undefined);
	lib_0A1A::func_2374("crawlmelee_powerup",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"deathcrawl_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crawlmelee_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("antigrav_rise",::lib_0F41::func_CEE2,undefined,undefined,undefined,undefined,::lib_0F41::func_3EB1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pick_fall",undefined,::lib_0F41::func_2012,undefined);
	lib_0A1A::func_2375("antigrav_float_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("antigrav_float_idle",::lib_0F41::func_CEE0,undefined,undefined,undefined,undefined,::lib_0F41::func_3EB0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pick_fall",undefined,::lib_0F41::func_2012,undefined);
	lib_0A1A::func_2374("antigrav_fall",::lib_0F41::func_CEDC,undefined,undefined,::lib_0F41::func_3391,undefined,::lib_0F41::func_3EAD,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("antigrav_rise",undefined,::lib_0F41::func_197C,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("antigrav_fall_to_crawl",::lib_0F41::func_CEDC,undefined,undefined,::lib_0F41::func_3391,undefined,::lib_0F41::func_3EAD,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("antigrav_rise",undefined,::lib_0F41::func_197C,undefined);
	lib_0A1A::func_2375("crawlmelee_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("antigrav_fall_to_turret",::lib_0F41::func_CEDC,undefined,undefined,::lib_0F41::func_3391,undefined,::lib_0F41::func_3EAD,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("antigrav_rise",undefined,::lib_0F41::func_197C,undefined);
	lib_0A1A::func_2375("crawlrange_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pick_fall",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("antigrav_fall_to_crawl",undefined,::func_123FC,undefined);
	lib_0A1A::func_2375("antigrav_fall_to_turret",undefined,::lib_0A26::func_337F,undefined);
	lib_0A1A::func_2375("antigrav_fall",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("grenade_hug_reaction",::lib_0C2F::func_CEBA,undefined,undefined,::lib_0C2F::func_40FB,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("grenade_hug_pickup",::lib_0C2F::func_CEB9,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("grenade_hug_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("grenade_hug_idle",::lib_0C2F::func_CEB8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("grenade_hug_reaction",undefined,::lib_0C2F::func_85C4,undefined);
	lib_0A1A::func_2374("grenade_hug_pickup_moving",::lib_0C2F::func_CEB9,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("grenade_hug_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2327();
}

//Function Number: 2
func_122DB(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 3
func_122D6(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2941();
}

//Function Number: 4
func_11B72(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2941() && !lib_0A1B::func_2938();
}

//Function Number: 5
func_11B78(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_BCE7(param_00,param_01,param_03) && !lib_0A1B::func_2938();
}

//Function Number: 6
func_11B6F(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2938();
}

//Function Number: 7
func_125D4(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_293A();
}

//Function Number: 8
func_12273(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_B55B) && !isdefined(self.var_B55B.target);
}

//Function Number: 9
func_12270(param_00,param_01,param_02,param_03)
{
	return !lib_0F3D::func_B5FC();
}

//Function Number: 10
func_122B0(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 11
func_123DC(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_232B(param_01,"end") && !isdefined(self.var_1198.var_5665);
}

//Function Number: 12
func_123D2(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_232B(param_01,"end") && !isdefined(self.var_1198.var_5665);
}

//Function Number: 13
func_12364(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == "stand" && lib_0A1A::func_232B("pain_cover_right","end");
}

//Function Number: 14
func_1236E(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == "crouch" && lib_0A1A::func_232B("pain_cover_right","end");
}

//Function Number: 15
func_1234A(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == "stand" && lib_0A1A::func_232B("pain_cover_left","end");
}

//Function Number: 16
func_12354(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == "crouch" && lib_0A1A::func_232B("pain_cover_left","end");
}

//Function Number: 17
func_12141(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_294B();
}

//Function Number: 18
func_12118(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 19
func_120E0(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 20
func_120CA(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955() && lib_0A1B::func_2956("combat");
}

//Function Number: 21
func_120CB(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2950();
}

//Function Number: 22
func_11F96(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 23
func_11F7B(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291A();
}

//Function Number: 24
func_11F4D(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "exposed";
}

//Function Number: 25
func_11F59(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "full exposed";
}

//Function Number: 26
func_11F6E(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "look";
}

//Function Number: 27
func_11CA3(param_00,param_01,param_02,param_03)
{
	return !scripts\asm\shared_utility::func_9D50();
}

//Function Number: 28
func_11C85(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291A();
}

//Function Number: 29
func_11CAB(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 30
func_11C0D(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "exposed";
}

//Function Number: 31
func_11C19(param_00,param_01,param_02,param_03)
{
	return weaponclass(self.var_394) == "rocketlauncher" && lib_0A1B::func_292E() != "rocketlauncher";
}

//Function Number: 32
func_11C33(param_00,param_01,param_02,param_03)
{
	return weaponclass(self.var_394) == "rocketlauncher" && lib_0A1B::func_292E() != "rocketlauncher";
}

//Function Number: 33
func_11C69(param_00,param_01,param_02,param_03)
{
	return weaponclass(self.var_394) == "rocketlauncher" && lib_0A1B::func_292E() != "rocketlauncher";
}

//Function Number: 34
func_11EAD(param_00,param_01,param_02,param_03)
{
	return weaponclass(self.var_394) == "rocketlauncher" && lib_0A1B::func_292E() != "rocketlauncher";
}

//Function Number: 35
func_11EC3(param_00,param_01,param_02,param_03)
{
	return weaponclass(self.var_394) == "rocketlauncher" && lib_0A1B::func_292E() != "rocketlauncher";
}

//Function Number: 36
func_11F30(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 37
func_11EE9(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291A();
}

//Function Number: 38
func_11F14(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "B";
}

//Function Number: 39
func_11F06(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "A";
}

//Function Number: 40
func_11F22(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "lean";
}

//Function Number: 41
func_11EDC(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "look";
}

//Function Number: 42
func_11E87(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 43
func_11E55(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "A";
}

//Function Number: 44
func_11E63(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "B";
}

//Function Number: 45
func_11E71(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "lean";
}

//Function Number: 46
func_11E0A(param_00,param_01,param_02,param_03)
{
	return weaponclass(self.var_394) == "rocketlauncher" && lib_0A1B::func_292E() != "rocketlauncher";
}

//Function Number: 47
func_11E1E(param_00,param_01,param_02,param_03)
{
	return weaponclass(self.var_394) == "rocketlauncher" && lib_0A1B::func_292E() != "rocketlauncher";
}

//Function Number: 48
func_11E31(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "look";
}

//Function Number: 49
func_11DE4(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 50
func_11D9C(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291A();
}

//Function Number: 51
func_11DBA(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "A";
}

//Function Number: 52
func_11DC8(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "B";
}

//Function Number: 53
func_11DD6(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "lean";
}

//Function Number: 54
func_11D6D(param_00,param_01,param_02,param_03)
{
	return weaponclass(self.var_394) == "rocketlauncher" && lib_0A1B::func_292E() != "rocketlauncher";
}

//Function Number: 55
func_11D78(param_00,param_01,param_02,param_03)
{
	return weaponclass(self.var_394) == "rocketlauncher" && lib_0A1B::func_292E() != "rocketlauncher";
}

//Function Number: 56
func_11D8E(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "look";
}

//Function Number: 57
func_11D51(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 58
func_11D24(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "A";
}

//Function Number: 59
func_11D33(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "B";
}

//Function Number: 60
func_11D42(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "lean";
}

//Function Number: 61
func_11CD9(param_00,param_01,param_02,param_03)
{
	return weaponclass(self.var_394) == "rocketlauncher" && lib_0A1B::func_292E() != "rocketlauncher";
}

//Function Number: 62
func_11CED(param_00,param_01,param_02,param_03)
{
	return weaponclass(self.var_394) == "rocketlauncher" && lib_0A1B::func_292E() != "rocketlauncher";
}

//Function Number: 63
func_11D00(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "look";
}

//Function Number: 64
func_1257B(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("sprint");
}

//Function Number: 65
func_125AC(param_00,param_01,param_02,param_03)
{
	return self.var_12A || !lib_0A1B::func_2956("combat");
}

//Function Number: 66
func_12597(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 67
func_12511(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2956("sprint");
}

//Function Number: 68
func_1209D(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 69
func_12021(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 70
func_1201A(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 71
func_12418(param_00,param_01,param_02,param_03)
{
	return !lib_0A1A::func_2352();
}

//Function Number: 72
func_1225A(param_00,param_01,param_02,param_03)
{
	return !lib_0A1A::func_2352();
}

//Function Number: 73
func_12024(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_293A();
}

//Function Number: 74
func_1202A(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 75
func_1202E(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_293A();
}

//Function Number: 76
func_123FC(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_293A();
}