/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3144.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 12:26:16 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("C12"))
	{
		return;
	}

	lib_0C59::func_2371();
	lib_0C5A::func_2371();
	lib_0A1A::func_230B("C12","start");
	lib_0A1A::func_2373("track",::lib_0C41::func_3627);
	lib_0A1A::func_2374("start",::lib_0C42::func_35A6,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("combat_idle",::lib_0C45::func_35DE,undefined,undefined,::lib_0C45::func_35DF,undefined,::lib_0F3D::func_3E96,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("melee_grab",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("stand_turn",undefined,::lib_0C45::func_BEA0,undefined);
	lib_0A1A::func_2375("move_requested",undefined,::func_11BF4,undefined);
	lib_0A1A::func_2374("Knobs",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("stand_turn",::lib_0C45::func_CEC3,undefined,undefined,undefined,undefined,::lib_0C45::func_3EA7,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("aimset_left",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("aimset_minigun",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("aim_body",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("aimset_right",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("aim_parent_knob",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("custom_exit",::lib_0C65::func_CEB5,undefined,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("run",undefined,::func_1206F,undefined);
	lib_0A1A::func_2374("custom_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Custom",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("custom_idle",undefined,::lib_0C5F::func_10097,undefined);
	lib_0A1A::func_2375("run",undefined,::func_1205A,undefined);
	lib_0A1A::func_2374("AnimScripted",::lib_0F3D::func_1FCB,undefined,undefined,::lib_0F3D::func_1FCC,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("custom_exit",undefined,::func_11B5C,undefined);
	lib_0A1A::func_2375("run",undefined,::lib_0F3D::func_10033,[1,"combat"]);
	lib_0A1A::func_2375("walk",undefined,::lib_0F3D::func_10033,[1,"casual"]);
	lib_0A1A::func_2375("custom_idle",undefined,::func_11B63,undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::func_11B59,undefined);
	lib_0A1A::func_2374("custom_idle",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C5F::func_3E9C,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("custom_exit",undefined,::lib_0C5F::func_FFDE,undefined);
	lib_0A1A::func_2374("pain_generic",::lib_0C46::func_D4EE,undefined,undefined,::lib_0C46::func_4109,undefined,::lib_0C46::func_3EE4,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_enter_left",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_stun_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_stun_left",::lib_0C46::func_CF37,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_recover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_recover_left",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_left",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_emp_enter_left_leg_l",undefined,::lib_0A1B::func_2945,"left_leg");
	lib_0A1A::func_2375("pain_emp_enter_left_leg_r",undefined,::lib_0A1B::func_2945,"right_leg");
	lib_0A1A::func_2375("pain_emp_enter_left",undefined,::func_12376,undefined);
	lib_0A1A::func_2374("pain_emp_enter_left_leg_l",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_stun_left_leg_l",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_stun_left_leg_l",::lib_0C46::func_CF37,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_recover_left_leg_l",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_recover_left_leg_l",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("dismember_leg_l_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_enter_left_leg_r",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_stun_left_leg_r",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_stun_left_leg_r",::lib_0C46::func_CF37,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_recover_left_leg_r",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_recover_left_leg_r",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("dismember_leg_r_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_enter_right",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_stun_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_stun_right",::lib_0C46::func_CF37,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_recover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_recover_right",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_right",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_emp_enter_right_leg_l",undefined,::lib_0A1B::func_2945,"left_leg");
	lib_0A1A::func_2375("pain_emp_enter_right_leg_r",undefined,::lib_0A1B::func_2945,"right_leg");
	lib_0A1A::func_2375("pain_emp_enter_right",undefined,::func_12377,undefined);
	lib_0A1A::func_2374("pain_emp_enter_right_leg_l",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_stun_right_leg_l",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_stun_right_leg_l",::lib_0C46::func_CF37,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_recover_right_leg_l",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_recover_right_leg_l",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("dismember_leg_l_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_enter_right_leg_r",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_stun_right_leg_r",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_stun_right_leg_r",::lib_0C46::func_CF37,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_emp_recover_right_leg_r",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_emp_recover_right_leg_r",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("dismember_leg_r_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("run_turn",::lib_0C65::func_D514,undefined,undefined,undefined,undefined,::lib_0C65::func_3EF5,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("run",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("run",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_grab",0.5,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2374("run",::lib_0F3D::func_D4DD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("exposed_arrival",undefined,::lib_0C45::func_100BE,1);
	lib_0A1A::func_2375("combat_idle",undefined,::func_1246C,undefined);
	lib_0A1A::func_2375("melee_grab",0.5,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0C65::func_FFF8,["run_turn",1]);
	lib_0A1A::func_2375("exposed_arrival",undefined,::lib_0C45::func_1008C,"Exposed");
	lib_0A1A::func_2374("walk",::lib_0F3D::func_D4DD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("walk_arrival",undefined,::lib_0C45::func_1008C,undefined);
	lib_0A1A::func_2375("walk_arrival",undefined,::lib_0C45::func_100BE,undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::func_12617,undefined);
	lib_0A1A::func_2375("melee_grab",0.5,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2374("exposed_arrival",::lib_0C45::func_CEAD,undefined,undefined,::lib_0C45::func_CEAB,undefined,::lib_0C45::func_3E99,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_arrival_complete",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_exit",::lib_0C65::func_CEB5,undefined,undefined,undefined,undefined,::lib_0C45::func_3524,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("run",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("run",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("walk_arrival",::lib_0C45::func_CEAD,undefined,undefined,::lib_0C45::func_CEAB,undefined,::lib_0C45::func_3E99,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("walk_backward_exit",undefined,::lib_0C45::func_100BE,undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("walk_exit",::lib_0C65::func_CEB5,undefined,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("walk",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("walk",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("move_requested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("walk_backward_exit",undefined,::lib_0C45::func_100BE,undefined);
	lib_0A1A::func_2375("walk_exit",undefined,::lib_0C45::func_10048,undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0C45::func_10047,undefined);
	lib_0A1A::func_2375("stand_turn",undefined,::lib_0C45::func_BEA1,undefined);
	lib_0A1A::func_2375("walk",undefined,::scripts\asm\shared_utility::func_BD25,"walk");
	lib_0A1A::func_2375("walk",undefined,::scripts\asm\shared_utility::func_BD25,"casual");
	lib_0A1A::func_2375("run",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("walk_backward",::lib_0C45::func_CEBB,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","normal",undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::func_125DA,undefined);
	lib_0A1A::func_2375("walk_backward_arrival",undefined,::lib_0C45::func_100A2,undefined);
	lib_0A1A::func_2375("walk_backward_arrival",undefined,::lib_0C45::func_1008B,undefined);
	lib_0A1A::func_2374("walk_backward_exit",::lib_0C45::func_CEB6,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("walk_backward",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("walk_backward",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("combat_idle",undefined,::func_125D7,undefined);
	lib_0A1A::func_2374("walk_backward_arrival",::lib_0C45::func_CEAC,undefined,undefined,::lib_0C45::func_CEAB,undefined,::lib_0C45::func_3E98,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,"pain_generic",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_arrival_complete",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("walk_backward_exit",undefined,::lib_0C45::func_100BE,0);
	lib_0A1A::func_2375("combat_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("rodeo_left",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("rodeo_right",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("melee_throw",::lib_0C44::func_35C3,undefined,::lib_0C44::func_35C1,::lib_0C44::func_35C4,undefined,::lib_0C44::func_3584,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_grab",::lib_0C44::func_35BF,undefined,::lib_0C44::func_35C1,::lib_0C44::func_35C0,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_grab_complete",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_grab_complete",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_throw",undefined,::lib_0C44::func_3616,undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_generic",::lib_0C46::func_35D7,undefined,undefined,undefined,undefined,::lib_0C46::func_3527,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_dismember_legs",::lib_0C46::func_35D7,undefined,undefined,undefined,undefined,::lib_0C46::func_3527,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("dismember",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("dismember_destruct_leg_r",undefined,::lib_0A1B::func_2991,["right_leg","left_leg"]);
	lib_0A1A::func_2375("dismember_destruct_leg_l",undefined,::lib_0A1B::func_2991,["left_leg","right_leg"]);
	lib_0A1A::func_2375("dismember_leg_r",undefined,::lib_0A1B::func_298F,"right_leg");
	lib_0A1A::func_2375("dismember_leg_l",undefined,::lib_0A1B::func_298F,"left_leg");
	lib_0A1A::func_2375("dismember_leg_l_arm_enter_l",undefined,::lib_0A1B::func_2991,["left_leg","left_arm"]);
	lib_0A1A::func_2375("dismember_leg_l_arm_enter_r",undefined,::lib_0A1B::func_2991,["left_leg","right_arm"]);
	lib_0A1A::func_2375("dismember_leg_l_arm_enter_r",undefined,::lib_0A1B::func_2991,["left_leg","head"]);
	lib_0A1A::func_2375("dismember_leg_r_arm_enter_l",undefined,::lib_0A1B::func_2991,["right_leg","left_arm"]);
	lib_0A1A::func_2375("dismember_leg_r_arm_enter_r",undefined,::lib_0A1B::func_2991,["right_leg","right_arm"]);
	lib_0A1A::func_2375("dismember_leg_r_arm_enter_r",undefined,::lib_0A1B::func_2991,["right_leg","head"]);
	lib_0A1A::func_2375("dismember_arm_enter_l",undefined,::lib_0A1B::func_298F,"left_arm");
	lib_0A1A::func_2375("dismember_arm_enter_r",undefined,::lib_0A1B::func_298F,"right_arm");
	lib_0A1A::func_2375("dismember_head",undefined,::lib_0A1B::func_2945,"head");
	lib_0A1A::func_2374("dismember_arm_enter_l",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_arm_stun_l",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_arm_enter_r",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_arm_stun_r",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_l",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_l_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_r",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_r_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_head",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_l_idle",::lib_0C45::func_35DE,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,undefined,undefined,"death_dismember_legs","left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2374("dismember_leg_r_idle",::lib_0C45::func_35DE,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,["aim"],undefined,["shoot_c12_left","shoot_c12_right"],undefined,undefined,undefined,"death_dismember_legs","right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2374("dismember_destruct_leg_r",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2374("dismember_destruct_leg_l",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2374("dismember_leg_l_arm_enter_l",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_l_arm_stun_l",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_l_arm_enter_r",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_l_arm_stun_r",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_r_arm_enter_l",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_r_arm_stun_l",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_r_arm_enter_r",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_r_arm_stun_r",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_arm_stun_r",::lib_0C46::func_CF1C,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_arm_recover_r",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_arm_recover_r",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_arm_stun_l",::lib_0C46::func_CF1C,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_arm_recover_l",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_arm_recover_l",::lib_0C46::func_D542,undefined,undefined,::lib_0C46::func_411A,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("combat_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_r_arm_stun_r",::lib_0C46::func_CF1C,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_r_arm_recover_r",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_r_arm_recover_r",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_r_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_r_arm_stun_l",::lib_0C46::func_CF1C,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_r_arm_recover_l",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_r_arm_recover_l",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_r_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_l_arm_stun_r",::lib_0C46::func_CF1C,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_l_arm_recover_r",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_l_arm_recover_r",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_l_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_l_arm_stun_l",::lib_0C46::func_CF1C,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_l_arm_recover_l",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dismember_leg_l_arm_recover_l",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("dismember_leg_l_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2327();
}

//Function Number: 2
func_11BF4(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 3
func_1206F(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_232B(param_01,"end") && self.var_1198.var_BD23 == "combat";
}

//Function Number: 4
func_1205A(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_232B(param_01,"abort") && self.var_1198.var_BD23 == "combat";
}

//Function Number: 5
func_11B5C(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2938() && isdefined(self.var_2303.var_4C86.var_697F);
}

//Function Number: 6
func_11B63(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2938() && isdefined(self.var_2303.var_4C86.var_92FA);
}

//Function Number: 7
func_11B59(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2938();
}

//Function Number: 8
func_12376(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 9
func_12377(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 10
func_1246C(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 11
func_12617(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 12
func_125DA(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 13
func_125D7(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}