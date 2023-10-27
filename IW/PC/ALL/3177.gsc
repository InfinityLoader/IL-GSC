/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3177.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 83
 * Decompile Time: 1317 ms
 * Timestamp: 10/27/2023 12:26:27 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("soldier"))
	{
		return;
	}

	lib_0C57::func_2371();
	lib_0C4D::func_2371();
	lib_0C4B::func_2371();
	lib_0A1A::func_230B("soldier","soldier_start");
	lib_0A1A::func_2373("track",::lib_0A2B::func_11A90);
	lib_0A1A::func_2374("Enter_Combat",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,["shoot"],undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"frantic");
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"sprint");
	lib_0A1A::func_2375("cqb_exposed_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2374("Knobs",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("noncombat_stand_idle",::lib_0F43::func_D46D,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3ECD,"idle",["gesture"],undefined,undefined,"idle","pain_stand","noncombat_stand_idle","death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("Enter_Combat",undefined,::scripts\asm\shared_utility::func_BD25,"combat");
	lib_0A1A::func_2375("Enter_Combat",undefined,::scripts\asm\shared_utility::func_BD25,"frantic");
	lib_0A1A::func_2375("Enter_Combat",undefined,::scripts\asm\shared_utility::func_BD25,"sprint");
	lib_0A1A::func_2375("grenade_avoid",undefined,::func_122ED,undefined);
	lib_0A1A::func_2375("exposed_idle_react",0.1,::func_122E8,undefined);
	lib_0A1A::func_2375("exposed_casual_exit",undefined,::lib_0A1A::func_BCE7,"casual");
	lib_0A1A::func_2375("exposed_casual_gun_exit",undefined,::lib_0A1A::func_BCE7,"casual_gun");
	lib_0A1A::func_2375("grenade_return_throw",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("patrol_idle",undefined,::scripts\asm\shared_utility::func_BD25,"patrol");
	lib_0A1A::func_2375("nonCombat_idle_to_nonCombat_cqb",undefined,::func_122F2,undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_BCE7,"casual");
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_BCE7,"casual_gun");
	lib_0A1A::func_2375("patrol_exit",undefined,::lib_0A1A::func_9E41,[0,"patrol"]);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"sprint");
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"frantic");
	lib_0A1A::func_2374("soldier_start",::lib_0C68::func_51E8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop_pass",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("stand_run_loop_pass",undefined,::lib_0A1A::func_BCE7,"frantic");
	lib_0A1A::func_2375("stand_run_loop_pass",undefined,::lib_0A1A::func_BCE7,"sprint");
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("cqb_idle",undefined,::scripts\asm\shared_utility::func_BD25,"cqb");
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_124F0,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_BD25,"sprint");
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_BD25,"combat");
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_BD25,"frantic");
	lib_0A1A::func_2374("exposed_stand_to_noncombat_stand_idle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle","pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_1215C,undefined);
	lib_0A1A::func_2375("patrol_idle",undefined,::lib_0A1A::func_9E41,[0,"patrol"]);
	lib_0A1A::func_2374("grenade_return_throw",::lib_0C61::func_D490,undefined,undefined,::lib_0C61::func_116F6,undefined,::lib_0C61::func_3EDB,undefined,undefined,undefined,undefined,"Pain",undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("grenade_avoid",::lib_0C61::func_D48F,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"run",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("grenade_dive_backward",undefined,::lib_0C61::func_1001F,"backward");
	lib_0A1A::func_2375("grenade_dive_forward",undefined,::lib_0C61::func_1001F,"forward");
	lib_0A1A::func_2375("grenade_cower_start",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("grenade_dive_backward",::lib_0F3D::func_CEA8,undefined,undefined,::lib_0C61::func_85B1,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_crouching",undefined,undefined,undefined,"grenade dive","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::func_121AE,undefined);
	lib_0A1A::func_2374("grenade_dive_forward",::lib_0F3D::func_CEA8,undefined,undefined,::lib_0C61::func_85B1,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_crouching",undefined,undefined,undefined,"grenade dive","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::func_121B1,undefined);
	lib_0A1A::func_2374("grenade_cower_start",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"idle",undefined,undefined,"death_crouching",undefined,undefined,undefined,"grenade cower","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("grenade_cower_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("grenade_cower_loop",undefined,::lib_0A1A::func_68B0,"anim_pose = \"crouch\");
	lib_0A1A::func_2374("grenade_cower_loop",::lib_0F3D::func_CEA8,undefined,undefined,::lib_0C61::func_85B1,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"idle",undefined,undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::func_121A9,undefined);
	lib_0A1A::func_2374("custom_exit",::lib_0C65::func_CEB5,undefined,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::func_12071,undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::func_12067,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::func_12062,undefined);
	lib_0A1A::func_2374("custom_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Custom",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("custom_idle",undefined,::lib_0C5F::func_10097,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::func_1205C,undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::func_12054,undefined);
	lib_0A1A::func_2374("AnimScripted",::lib_0F3D::func_1FCB,undefined,undefined,::lib_0F3D::func_1FCC,undefined,::lib_0F3D::func_3E96,undefined,["gesture"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("custom_exit",undefined,::func_11B5C,undefined);
	lib_0A1A::func_2375("patrol_idle",undefined,::lib_0F3D::func_10033,[1,"patrol"]);
	lib_0A1A::func_2375("patrol_idle",undefined,::lib_0F3D::func_10033,[0,"patrol"]);
	lib_0A1A::func_2375("animscripted_to_noncombat_idle_pass",undefined,::lib_0F3D::func_10033,[0,"casual"]);
	lib_0A1A::func_2375("animscripted_to_noncombat_idle_pass",undefined,::lib_0F3D::func_10033,[0,"casual_gun"]);
	lib_0A1A::func_2375("stand_run_loop_pass",undefined,::lib_0F3D::func_10033,[1,"combat"]);
	lib_0A1A::func_2375("stand_run_loop_pass",undefined,::lib_0F3D::func_10033,[1,"sprint"]);
	lib_0A1A::func_2375("stand_run_loop_pass",undefined,::lib_0F3D::func_10033,[1,"patrol"]);
	lib_0A1A::func_2375("stand_run_loop_pass",undefined,::lib_0F3D::func_10033,[1,"frantic"]);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0F3D::func_10033,[1,"cqb"]);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0F3D::func_10033,[1,"casual"]);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0F3D::func_10033,[1,"casual_gun"]);
	lib_0A1A::func_2375("custom_idle",undefined,::func_11B68,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::lib_0F3D::func_10033,[0,"casual"]);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::lib_0F3D::func_10033,[0,"casual_gun"]);
	lib_0A1A::func_2375("cqb_idle",undefined,::lib_0F3D::func_10033,[0,"cqb"]);
	lib_0A1A::func_2375("scripted_to_exposed",undefined,::lib_0F3D::func_10033,[0,"combat"]);
	lib_0A1A::func_2375("scripted_to_exposed",undefined,::lib_0F3D::func_10033,[0,"sprint"]);
	lib_0A1A::func_2375("scripted_to_exposed",undefined,::lib_0F3D::func_10033,[0,"frantic"]);
	lib_0A1A::func_2374("custom_idle",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C5F::func_3E9C,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("custom_exit",undefined,::lib_0C5F::func_FFDE,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0C5F::func_1009B,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2374("move_walk_loop",::lib_0F3D::func_D4E0,undefined,undefined,::lib_0F3D::func_D4E1,undefined,::scripts\asm\shared_utility::func_3ECD,"move",["gesture"],undefined,undefined,undefined,"pain_stand","move_walk_loop","death_standing",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("exposed_casual_gun_arrival",undefined,::lib_0C5D::func_10095,["Exposed",1,"casual_gun"]);
	lib_0A1A::func_2375("exposed_casual_arrival",undefined,::lib_0C5D::func_10093,["Exposed",1,"casual"]);
	lib_0A1A::func_2375("walk_turn_casual",undefined,::lib_0C65::func_3B1F,["walk_turn_casual",1,"casual"]);
	lib_0A1A::func_2375("walk_turn_casual_gun",undefined,::lib_0C65::func_3B1F,["walk_turn_casual_gun",1,"casual_gun"]);
	lib_0A1A::func_2375("move_walk_and_talk",undefined,::func_122AF,undefined);
	lib_0A1A::func_2375("pass_casual_stairs",undefined,::lib_0C65::func_9EC3,undefined);
	lib_0A1A::func_2375("pass_stairs_down",undefined,::lib_0C65::func_10006,"down");
	lib_0A1A::func_2375("pass_stairs_up",0,::lib_0C65::func_10006,"up");
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::func_122B4,undefined);
	lib_0A1A::func_2375("custom_arrival",undefined,::lib_0C5D::func_1008A,["Custom",1]);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,"frantic");
	lib_0A1A::func_2375("grenade_return_throw",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("pass_change_move_type",undefined,::scripts\asm\shared_utility::func_BD27,undefined);
	lib_0A1A::func_2374("exposed_casual_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,[undefined,1],["gesture"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("pass_walk_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("exposed_casual_arrival",undefined,::lib_0C5D::func_10094,["Exposed",1,"casual"]);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("exposed_casual_gun_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Exposed",["gesture"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_walk_and_talk",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_casual_arrival",::lib_0C5D::func_CEAA,1.2,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Exposed",["gesture"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("move_walk_and_talk",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_casual_gun_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,[undefined,1],["gesture"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("exposed_casual_gun_arrival",undefined,::lib_0C5D::func_10096,["Exposed",1,"casual_gun"]);
	lib_0A1A::func_2375("pass_walk_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("walk_turn_casual",::lib_0C65::func_D514,undefined,undefined,undefined,undefined,::lib_0C65::func_3EF5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("exposed_casual_arrival",undefined,::lib_0C5D::func_10094,["Exposed",1,"casual"]);
	lib_0A1A::func_2375("pass_walk_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("walk_turn_casual_gun",::lib_0C65::func_D514,undefined,undefined,undefined,undefined,::lib_0C65::func_3EF5,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_casual_gun_arrival",undefined,::lib_0C5D::func_10096,["Exposed",1,"casual_gun"]);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("move_walk_and_talk",::lib_0C65::func_BD2C,undefined,undefined,undefined,undefined,::lib_0C65::func_3F0C,undefined,["gesture"],undefined,undefined,undefined,"pain_stand","move_walk_loop","death_standing",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("move_walk_loop",1,::func_122AE,undefined);
	lib_0A1A::func_2375("exposed_casual_arrival",undefined,::lib_0C5D::func_10093,["Exposed",1,"casual"]);
	lib_0A1A::func_2375("exposed_casual_gun_arrival",undefined,::lib_0C5D::func_10095,["Exposed",1,"casual_gun"]);
	lib_0A1A::func_2375("pass_casual_stairs",undefined,::lib_0C65::func_9EC3,undefined);
	lib_0A1A::func_2375("pass_stairs_down",undefined,::lib_0C65::func_10006,"down");
	lib_0A1A::func_2375("pass_stairs_up",0,::lib_0C65::func_10006,"up");
	lib_0A1A::func_2374("stairs_walk_up_arrival",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_walk_up_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_walk_up_exit",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_walk_up_loop",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA6,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_walk_up_exit",undefined,::lib_0C65::func_1000E,"up");
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2375("stairs_walk_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2374("stairs_walk_down_loop",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA6,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_walk_down_exit",undefined,::lib_0C65::func_1000E,"down");
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2375("stairs_walk_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2374("pass_stairs_walk",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stairs_walk_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2375("stairs_walk_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2374("stairs_walk_down_arrival",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_walk_down_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_walk_down_exit",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_casual_gun_walk_up_arrival",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_casual_gun_walk_up_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_casual_gun_walk_up_exit",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_casual_gun_walk_up_loop",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA6,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_casual_gun_walk_up_exit",undefined,::lib_0C65::func_1000E,"up");
	lib_0A1A::func_2375("stairs_casual_gun_walk_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2374("stairs_casual_gun_walk_down_loop",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA6,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_casual_gun_walk_down_exit",undefined,::lib_0C65::func_1000E,"down");
	lib_0A1A::func_2375("stairs_casual_gun_walk_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2374("pass_stairs_casual_gun_walk",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stairs_casual_gun_walk_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2375("stairs_casual_gun_walk_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2374("stairs_casual_gun_walk_down_arrival",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_casual_gun_walk_down_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_casual_gun_walk_down_exit",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("move_walk_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_casual_stairs",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_stairs_casual_gun_walk",undefined,::scripts\asm\shared_utility::func_BD25,"casual_gun");
	lib_0A1A::func_2375("pass_stairs_walk",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_stairs_down",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stairs_casual_gun_walk_down_arrival",undefined,::scripts\asm\shared_utility::func_BD25,"casual_gun");
	lib_0A1A::func_2375("stairs_walk_down_arrival",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_stairs_up",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stairs_casual_gun_walk_up_arrival",undefined,::scripts\asm\shared_utility::func_BD25,"casual_gun");
	lib_0A1A::func_2375("stairs_walk_up_arrival",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_walk_cover_exit_code_move",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_BCE7,"frantic");
	lib_0A1A::func_2375("exposed_casual_arrival",undefined,::lib_0C5D::func_10093,["exposed",1,"casual"]);
	lib_0A1A::func_2375("exposed_casual_gun_arrival",undefined,::lib_0C5D::func_10093,["Exposed",1,"casual_gun"]);
	lib_0A1A::func_2375("pass_casual_stairs",undefined,::lib_0C65::func_9EC3,undefined);
	lib_0A1A::func_2375("walk_turn_casual",undefined,::lib_0C65::func_3B1F,["walk_turn_casual",1,"casual"]);
	lib_0A1A::func_2375("pass_stairs_up",undefined,::lib_0C65::func_10006,"up");
	lib_0A1A::func_2375("pass_stairs_down",undefined,::lib_0C65::func_10006,"down");
	lib_0A1A::func_2374("aimset_generic",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_prone",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_cornerstndr_lean",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_cornerstndl_lean",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_cornercrr_lean",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_cqb_stand",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_cqb_run",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_coverstand",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_covercrouch_lean",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_generic_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_rpg",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_rpg_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_cornercrl_lean",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_covercrouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_pistol",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_strafe_forward",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_strafe_backward",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_strafe_left",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("aimset_strafe_right",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("cover_stand",::lib_0C5E::func_CF02,"stickToNode",undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"hide_loop",undefined,"stand",undefined,"angry","pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand_to_shuffle_l_pass",undefined,::lib_0A1B::func_2935,"left");
	lib_0A1A::func_2375("cover_stand_to_shuffle_r_pass",undefined,::lib_0A1B::func_2935,"right");
	lib_0A1A::func_2375("cover_stand_turret_deploy_pass",undefined,::lib_0C62::func_12A82,undefined);
	lib_0A1A::func_2375("cover_stand_high_lmg_deploy_pass",undefined,::lib_0F43::func_4C03,"Cover Stand LMG");
	lib_0A1A::func_2375("cover_stand_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_stand_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_stand_peek",undefined,::lib_0A1B::func_2948,"peek");
	lib_0A1A::func_2375("cover_stand_reload",undefined,::func_11F98,undefined);
	lib_0A1A::func_2375("cover_stand_blindfire",undefined,::func_11F7D,undefined);
	lib_0A1A::func_2375("cover_stand_hide_to_full_exposed",undefined,::lib_0A1B::func_2946,"full exposed");
	lib_0A1A::func_2375("cover_stand_hide_to_look",undefined,::lib_0A1B::func_2948,"look");
	lib_0A1A::func_2375("cover_stand_hide_to_exposed",undefined,::lib_0A1B::func_2948,"exposed");
	lib_0A1A::func_2375("cover_stand_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"takingfire");
	lib_0A1A::func_2375("cover_stand_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"friendlyfire");
	lib_0A1A::func_2375("cover_stand_infantry_reaction",undefined,::lib_0C4C::func_3DF2,"threat_infantry");
	lib_0A1A::func_2375("cover_stand_order_reaction",undefined,::lib_0C4C::func_3DF2,"defending_action");
	lib_0A1A::func_2374("cover_stand_exposed",::lib_0C5E::func_D46B,undefined,undefined,undefined,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"stand",["shoot"],"aim","pain_cover_stand_default","suppress","death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_exposed_drop_rpg",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("cover_stand_exposed_to_hide",undefined,::func_11F4F,undefined);
	lib_0A1A::func_2374("cover_stand_hide_to_exposed",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_exposed",["notetrackAim"],undefined,undefined,"angry","pain_cover_stand_default","suppress","death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_exposed",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_exposed_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_stand_default","suppress","death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_full_exposed",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["shoot"],"aim","pain_cover_stand_default","suppress","death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_full_exposed_drop_rpg",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("cover_stand_full_exposed_to_hide",undefined,::lib_0A1B::func_2943,"full exposed");
	lib_0A1A::func_2374("cover_stand_hide_to_full_exposed",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_full_exposed",["notetrackAim"],undefined,undefined,"angry","pain_cover_stand_default","suppress","death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_full_exposed",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_full_exposed_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_stand_default","suppress","death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_blindfire",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_blindfire",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_reload",::lib_0C5E::func_4742,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_peek",::lib_0C5E::func_CEFC,undefined,undefined,undefined,undefined,::lib_0C5E::func_3EC7,"peek",undefined,undefined,undefined,"angry","pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,"cover_peek","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2374("cover_stand_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_stand_hide_to_look",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0C5E::func_3EC7,"hide_to_look",undefined,undefined,undefined,"angry","pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_look",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_look",::lib_0C5E::func_CF02,undefined,undefined,undefined,undefined,::lib_0C5E::func_3EC7,"look_loop",undefined,undefined,undefined,"angry","pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_stand_look_to_hide",undefined,::func_11F6E,undefined);
	lib_0A1A::func_2374("cover_stand_look_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0C5E::func_3EC7,"look_to_hide",undefined,undefined,undefined,"angry","pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("trans_to_cover_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_stand",0.1,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_cover_stand_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_stand_to_shuffle_l_pass",undefined,::lib_0A1B::func_2935,"left");
	lib_0A1A::func_2375("cover_stand_to_shuffle_r_pass",undefined,::lib_0A1B::func_2935,"right");
	lib_0A1A::func_2375("cqb_cover_stand_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("cover_stand_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("trans_exposed_crouch_to_cover_stand",::lib_0F3D::func_CECD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_stand",0.1,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_to_exposed_idle",::lib_0C5E::func_D559,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0C5E::func_3F06,undefined,["notetrackAim"],"stand",undefined,"angry","pain_cover_stand",undefined,"death_cover","cover_stand",undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_infantry_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_takingfire_reaction",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_order_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_stand_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_full_exposed_drop_rpg",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle",undefined,undefined,"death_cover","cover_stand",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_exposed_drop_rpg",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle",undefined,undefined,"death_cover","cover_stand",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("antigrav_rise",::lib_0F41::func_CEE2,undefined,undefined,undefined,undefined,::lib_0F41::func_3EB1,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("antigrav_float_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("antigrav_fall",undefined,::lib_0F41::func_2012,undefined);
	lib_0A1A::func_2374("antigrav_float_idle",::lib_0F41::func_CEE0,undefined,undefined,undefined,undefined,::lib_0F41::func_3EB0,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("antigrav_fall",undefined,::lib_0F41::func_2012,undefined);
	lib_0A1A::func_2374("antigrav_fall",::lib_0F41::func_CEDC,undefined,undefined,::lib_0F41::func_CEDB,undefined,::lib_0F41::func_3EAD,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_antigrav_grenade",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("antigrav_rise",undefined,::lib_0F41::func_197C,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_charge_to_ready",::lib_0F42::func_D4CC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face enemy","zonly_physics",undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_attack",undefined,::lib_0C64::func_9D87,undefined);
	lib_0A1A::func_2374("melee_attack",::lib_0F42::func_D4D7,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,"melee_attack","face enemy","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_stand_to_ready",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face enemy","zonly_physics",undefined);
	lib_0A1A::func_2375("melee_attack",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_charge",::lib_0F42::func_D4D9,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,"melee_charge_state","face motion","normal",undefined);
	lib_0A1A::func_2375("melee_attack_decider",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("stand_run_loop_pass",undefined,::lib_0A1B::func_2957,undefined);
	lib_0A1A::func_2374("melee_attacker_passthrough",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_attack_decider",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("melee_charge",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2374("melee_cover",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_cover_left",undefined,::lib_0C64::func_B59B,"Cover Left");
	lib_0A1A::func_2375("melee_cover_right",undefined,::lib_0C64::func_B59B,"Cover Right");
	lib_0A1A::func_2374("melee_wrestle_win",::lib_0F42::func_D4D1,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_behind",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_behind_win",undefined,::lib_0C64::func_38A9,undefined);
	lib_0A1A::func_2374("melee_cover_right_win_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_flip_lose_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_wrestle_win_victim",::lib_0F42::func_D4D5,undefined,::lib_0C64::func_B590,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_wrestle_win_victim_survive",undefined,::lib_0C64::func_B5B7,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_behind_win_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_cover_left",::lib_0F42::func_D4D1,[1,1],undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,1);
	lib_0A1A::func_2375("melee_cover_left_lose",undefined,::lib_0C64::func_38A0,0);
	lib_0A1A::func_2375("melee_cover_left_win",undefined,::lib_0C64::func_38A0,1);
	lib_0A1A::func_2374("melee_cover_right",::lib_0F42::func_D4D1,[1,1],undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,1);
	lib_0A1A::func_2375("melee_cover_right_win",undefined,::lib_0C64::func_38A0,1);
	lib_0A1A::func_2375("melee_cover_right_lose",undefined,::lib_0C64::func_38A0,0);
	lib_0A1A::func_2374("melee_cover_left_win_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_cover_left_win_victim_survive",undefined,::lib_0C64::func_B5B7,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_flip_win",::lib_0F42::func_D4D1,[0,0],undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_flip_lose",::lib_0F42::func_D4D1,[0,0],undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_flip_win_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_flip_win_victim_survive",undefined,::lib_0C64::func_B5B7,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_behind_win",::lib_0F42::func_D4D1,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_cover_left_win",::lib_0F42::func_D4D1,1,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_cover_left_lose",::lib_0F42::func_D4D1,1,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_cover_left_lose_survive",undefined,::lib_0C64::func_B5B7,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_cover_right_win",::lib_0F42::func_D4D1,1,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_cover_right_lose",::lib_0F42::func_D4D1,1,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_cover_left_lose_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_cover_right_lose_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_flip_win_victim_survive",::lib_0F42::func_D4D4,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_cover_left_lose_survive",::lib_0F42::func_D4D4,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("melee_cover_left_win_victim_survive",::lib_0F42::func_D4D4,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("melee_wrestle_win_victim_survive",::lib_0F42::func_D4D4,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("melee_attack_return",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_prone",undefined,::lib_0A1B::func_9DA4,"prone");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_c6_grabAI_victim",::lib_0F42::func_D4D5,undefined,::lib_0C64::func_B590,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_c6_freed",undefined,::func_12262,undefined);
	lib_0A1A::func_2374("melee_c6_freed",::lib_0F42::func_D4CA,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_attack_decider",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_idle",undefined,::func_1225F,undefined);
	lib_0A1A::func_2375("melee_smack_lose",undefined,::lib_0C64::func_67D6,[0,0]);
	lib_0A1A::func_2375("melee_smack_win",undefined,::lib_0C64::func_67D6,[1,0]);
	lib_0A1A::func_2375("melee_charge_to_ready",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_seeker_attack_soldier_victim",::lib_0C52::func_D4D0,undefined,::lib_0C64::func_B590,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_c6_longchoke_lose_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_c6_longchoke_lose_victim_abort_passthrough",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_smack_win",::lib_0F42::func_D4D1,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_smack_win_abort_passthrough",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_smack_lose",::lib_0F42::func_D4D1,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_smack_win_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_smack_lose_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_holding_state",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_wrestle_win",undefined,::lib_0C64::func_67D6,1);
	lib_0A1A::func_2375("melee_flip_win",undefined,::lib_0C64::func_67D6,1);
	lib_0A1A::func_2375("melee_flip_lose",undefined,::lib_0C64::func_67D6,0);
	lib_0A1A::func_2374("melee_c6_throwdown_lose_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_c6_throwdown_win_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_melee_ragdoll_delayed",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_c6_throwdown_win_victim_survive_passthrough",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_c6_charge_lose_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2374("melee_c6_throwdown_win_victim_survive",::lib_0F42::func_D4D4,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_c6_throwdown_win_victim_survive_passthrough",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_c6_throwdown_win_victim_survive",undefined,::lib_0C64::func_B5B7,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_smack_win_abort_passthrough",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_smack_win_abort_return",undefined,::lib_0C64::func_B5B9,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_smack_win_abort_return",::lib_0F42::func_D4D4,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_c6_longchoke_lose_victim_survive",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_c6_longchoke_lose_victim_abort_passthrough",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_c6_longchoke_lose_victim_survive",undefined,::lib_0C64::func_B5B7,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_c6_pound_lose_victim",::lib_0F42::func_D4D5,undefined,undefined,::lib_0F42::func_D4D3,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"melee_attack",undefined,undefined,undefined);
	lib_0A1A::func_2375("melee_c6_pound_lose_victim_abort_passthrough",undefined,::lib_0C64::func_B5B5,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("melee_c6_pound_lose_victim_abort_passthrough",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("melee_c6_pound_lose_victim_survive",undefined,::lib_0C64::func_B5B7,undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("melee_c6_pound_lose_victim_survive",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("melee_attack_return",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("death_generic",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_standing_default",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3F00,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_crouching_default",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3ECA,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_moving_default",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3EE2,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_cover_default",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3EC6,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_explosive",::lib_0C60::func_D46A,undefined,undefined,undefined,undefined,::lib_0C60::func_3ED8,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_strong_bullet_damage",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3F04,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_standing",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_crouching",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2375("death_prone",undefined,::lib_0A1B::func_9DA4,"prone");
	lib_0A1A::func_2375("death_shocked",undefined,::lib_0C60::func_10052,undefined);
	lib_0A1A::func_2375("shield_bash",undefined,::lib_0C60::func_10051,undefined);
	lib_0A1A::func_2375("death_explosive",undefined,::lib_0C60::func_10045,undefined);
	lib_0A1A::func_2375("death_strong_bullet_damage",undefined,::lib_0C60::func_10059,undefined);
	lib_0A1A::func_2375("death_knife_upgrade",undefined,::lib_0C60::func_FFF0,undefined);
	lib_0A1A::func_2375("death_standing_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_crouching",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_standing",undefined,::lib_0A1B::func_9DA4,"stand");
	lib_0A1A::func_2375("death_prone",undefined,::lib_0A1B::func_9DA4,"prone");
	lib_0A1A::func_2375("death_shocked",undefined,::lib_0C60::func_10052,undefined);
	lib_0A1A::func_2375("shield_bash",undefined,::lib_0C60::func_10051,undefined);
	lib_0A1A::func_2375("death_explosive",undefined,::lib_0C60::func_10045,undefined);
	lib_0A1A::func_2375("death_strong_bullet_damage",undefined,::lib_0C60::func_10059,undefined);
	lib_0A1A::func_2375("death_knife_upgrade",undefined,::lib_0C60::func_FFF0,undefined);
	lib_0A1A::func_2375("death_crouching_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_cover",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_shocked",undefined,::lib_0C60::func_10052,undefined);
	lib_0A1A::func_2375("death_explosive",undefined,::lib_0C60::func_10045,undefined);
	lib_0A1A::func_2375("shield_bash",undefined,::lib_0C60::func_10051,undefined);
	lib_0A1A::func_2375("death_strong_bullet_damage",undefined,::lib_0C60::func_10059,undefined);
	lib_0A1A::func_2375("death_knife_upgrade",undefined,::lib_0C60::func_FFF0,undefined);
	lib_0A1A::func_2375("death_cover_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_moving",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_prone",undefined,::lib_0A1B::func_9DA4,"prone");
	lib_0A1A::func_2375("death_crouching",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2375("shield_bash",undefined,::lib_0C60::func_10051,undefined);
	lib_0A1A::func_2375("death_shocked",undefined,::lib_0C60::func_10052,undefined);
	lib_0A1A::func_2375("death_moving_explosive",undefined,::lib_0C60::func_10045,undefined);
	lib_0A1A::func_2375("death_strong_bullet_damage",undefined,::lib_0C60::func_10059,undefined);
	lib_0A1A::func_2375("death_knife_upgrade",undefined,::lib_0C60::func_FFF0,undefined);
	lib_0A1A::func_2375("death_moving_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_moving_explosive",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3ED8,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_antigrav_grenade",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("death_antigrav_grenade_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("death_antigrav_grenade_default",::lib_0C60::func_CF11,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_stand_r_arm",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_crouch_l_leg",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_stand_l_arm",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_crouch_r_leg",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_melee_ragdoll_delayed",::lib_0C60::func_CF0F,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_stand_torso",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_stand_head",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_prone",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_shocked",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C60::func_3EF6,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_stand_r_arm",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_stand_l_arm",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_stand_r_leg",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_stand_l_leg",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_stand_torso",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_stand_head",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_stand_back",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_stand_back",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_left_stand_r_arm",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_left_stand_l_arm",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_left_stand_r_leg",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_left_stand_l_leg",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_left_stand_torso",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_left_stand_head",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_left_stand_back",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_left_crouch_head",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_left_crouch_torso",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_left_crouch_back",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_right_stand_r_arm",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_right_stand_l_arm",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_right_stand_r_leg",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_right_stand_l_leg",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_right_stand_torso",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_right_stand_head",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_right_stand_back",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_right_crouch_head",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_right_crouch_torso",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_right_crouch_back",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_crouch_head",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_crouch_torso",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_cover_crouch_back",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_knife_upgrade",::lib_0C60::func_58E4,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("shield_bash",::lib_0C60::func_5AA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_stand_head02",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_stand_head03",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_stand_head04",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_crouch_torso03",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_crouch_torso02",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_crouch_torso",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_crouch_head",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_crouch_head02",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_crouch_head03",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_stand_torso03",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_stand_torso04",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("death_pain_stand_torso02",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_stand_damage_shield",::lib_0C66::func_D4EE,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE9,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_run_default",::lib_0C66::func_D4EE,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEB,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_default",::lib_0C66::func_D4EE,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE8,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_prone_default",::lib_0C66::func_D4EE,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_prone",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_prone",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_cover_right_default",::lib_0C66::func_CF04,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_right_end",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_cover_stand_default_internal",::lib_0C66::func_CF04,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE7,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_cover","cover_stand",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_stand_torso_to_cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_stand_torso_to_cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_crouch_default_internal",::lib_0C66::func_CF04,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE6,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_cover","cover_crouch",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_torso_to_cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_crouch_torso_to_cover_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_default",::lib_0C66::func_CF04,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_left_end",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_on_back_default",::lib_0C66::func_D4EE,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_cover_left_suppress_default",::lib_0C5E::func_D558,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",0.1,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_cover_right_suppress_default",::lib_0C5E::func_D558,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EE5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_stand",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_damage_shield_to_ground",undefined,::lib_0C66::func_FFE0,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2375("pain_stand_back",undefined,::lib_0C66::func_9DA8,undefined);
	lib_0A1A::func_2375("pain_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_stand_r_arm",undefined,::lib_0C66::func_9DAD,undefined);
	lib_0A1A::func_2375("pain_stand_l_arm",undefined,::lib_0C66::func_9DAA,undefined);
	lib_0A1A::func_2375("pain_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_pass_stand_head",undefined,::lib_0C66::func_9DA9,undefined);
	lib_0A1A::func_2375("pain_pass_stand_torso",undefined,::lib_0C66::func_9DAF,undefined);
	lib_0A1A::func_2375("pain_stand_damage_shield",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_run",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_damage_shield_to_ground",undefined,::lib_0C66::func_FFE0,undefined);
	lib_0A1A::func_2375("pain_run_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_prone",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_prone",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_prone_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_cover_left",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_damage_shield_to_ground",undefined,::lib_0C66::func_FFE0,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2375("pain_cover_left_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_cover_right",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_damage_shield_to_ground",undefined,::lib_0C66::func_FFE0,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2375("pain_cover_right_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_on_back",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_on_back_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_crouch",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_damage_shield_to_ground",undefined,::lib_0C66::func_FFE0,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2375("pain_crouch_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_crouch_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_pass_crouch_head",undefined,::lib_0C66::func_9DA9,undefined);
	lib_0A1A::func_2375("pain_pass_crouch_torso",undefined,::lib_0C66::func_9DAF,undefined);
	lib_0A1A::func_2375("pain_pass_crouch_torso",undefined,::lib_0C66::func_9DAA,undefined);
	lib_0A1A::func_2375("pain_pass_crouch_torso",undefined,::lib_0C66::func_9DAD,undefined);
	lib_0A1A::func_2375("pain_crouch_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_cover_crouch",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_damage_shield_to_ground",undefined,::lib_0C66::func_FFE0,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_back",undefined,::lib_0C66::func_9DA8,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_torso",undefined,::lib_0C66::func_9DAF,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_torso",undefined,::lib_0C66::func_9DAA,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_torso",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_torso",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_torso",undefined,::lib_0C66::func_9DAD,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_head",undefined,::lib_0C66::func_9DA9,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_default_internal",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_cover_stand",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_damage_shield_to_ground",undefined,::lib_0C66::func_FFE0,undefined);
	lib_0A1A::func_2375("pain_cover_stand_back",undefined,::lib_0C66::func_9DA8,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2375("pain_cover_stand_l_arm",undefined,::lib_0C66::func_9DAA,undefined);
	lib_0A1A::func_2375("pain_cover_stand_r_arm",undefined,::lib_0C66::func_9DAD,undefined);
	lib_0A1A::func_2375("pain_cover_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_stand_torso",undefined,::lib_0C66::func_9DAF,undefined);
	lib_0A1A::func_2375("pain_cover_stand_head",undefined,::lib_0C66::func_9DA9,undefined);
	lib_0A1A::func_2375("pain_cover_stand_default_internal",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_cover_right_suppress",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_cover_right_suppress_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2374("pain_cover_left_suppress",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2375("pain_cover_left_suppress_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_cover_right_end",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_cover_right_stand_torso_to_cover_right_stand",undefined,::func_12363,undefined);
	lib_0A1A::func_2375("pain_cover_right_crouch_torso_to_cover_right_crouch",undefined,::func_12362,undefined);
	lib_0A1A::func_2374("pain_cover_left_end",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_cover_left_stand_torso_to_cover_left_stand",undefined,::func_12349,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_torso_to_cover_left_crouch",undefined,::func_12348,undefined);
	lib_0A1A::func_2374("pain_special",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shocked",undefined,::lib_0A1E::func_9F4C,undefined);
	lib_0A1A::func_2375("pain_deafened",undefined,::lib_0A1E::func_9DB5,undefined);
	lib_0A1A::func_2374("shock_finish_stand",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C66::func_3EF7,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_stand_r_leg",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_crouch_r_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_r_leg_to_exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_r_leg_to_exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_r_arm",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_stand_r_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_stand_r_arm_to_exposed",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_r_arm_to_exposed",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2374("pain_stand_r_arm_to_exposed",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_stand",undefined,"death_pain_stand_r_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_l_arm",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_stand_l_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_l_arm_to_exposed",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_l_arm_to_exposed",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2374("pain_stand_l_leg",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_crouch_l_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_l_leg_to_exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_l_leg_to_exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_r_leg_to_exposed_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_crouch_r_leg",undefined,"death_pain_crouch_r_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_l_arm_to_exposed",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_stand",undefined,"death_pain_stand_l_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_l_leg_to_exposed_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_crouch_l_leg",undefined,"death_pain_crouch_l_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_r_leg",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED6,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_crouch_r_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_r_leg_to_exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_r_leg_to_exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_l_leg",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED6,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_crouch_l_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_l_leg_to_exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_l_leg_to_exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_torso",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_stand_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_torso_to_exposed",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_torso_to_exposed",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2374("pain_stand_torso_to_exposed",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_stand",undefined,"death_pain_stand_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_head",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_stand_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_head_to_exposed",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_head_to_exposed",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2374("pain_stand_head_to_exposed",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_stand",undefined,"death_pain_stand_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("shock_loop_stand",::lib_0C66::func_D517,undefined,undefined,undefined,undefined,::lib_0C66::func_3EF0,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shock_finish_stand",undefined,::lib_0A1A::func_68B0,"stop_loop_pain");
	lib_0A1A::func_2374("shock_finish_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C66::func_3EF7,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("shock_loop_crouch",::lib_0C66::func_D517,undefined,undefined,undefined,undefined,::lib_0C66::func_3EF0,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shock_finish_crouch",undefined,::lib_0A1A::func_68B0,"stop_loop_pain");
	lib_0A1A::func_2374("shocked",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shock_loop_stand",undefined,::lib_0A1B::func_9DA4,"stand");
	lib_0A1A::func_2375("shock_loop_crouch",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2375("shock_loop_prone",undefined,::lib_0A1B::func_9DA4,"prone");
	lib_0A1A::func_2374("shock_loop_prone",::lib_0C66::func_D517,undefined,undefined,undefined,undefined,::lib_0C66::func_3EF0,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_prone",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shock_finish_prone",undefined,::lib_0A1A::func_68B0,"stop_loop_pain");
	lib_0A1A::func_2374("shock_finish_prone",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C66::func_3EF7,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_prone",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_prone",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_cover_stand_l_leg",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_stand_l_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_stand_l_leg_to_cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_stand_l_leg_to_cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_stand_r_leg",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_stand_r_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_stand_r_leg_to_cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_stand_r_leg_to_cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_stand_l_arm",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_stand_l_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_stand_l_arm_to_cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_stand_l_arm_to_cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_cover_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2374("pain_cover_stand_r_arm",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_stand_r_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_stand_r_arm_to_cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_stand_r_arm_to_cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_cover_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2374("pain_cover_stand_head",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_stand_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_stand_head_to_cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_stand_head_to_cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_cover_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2374("pain_cover_stand_torso",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_stand_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_stand_torso_to_cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_stand_torso_to_cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_cover_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2374("pain_cover_stand_l_leg_to_cover_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_stand",undefined,"death_pain_cover_stand_l_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_stand_r_leg_to_cover_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_stand",undefined,"death_pain_cover_stand_r_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_stand_head_to_cover_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_stand",undefined,"death_pain_cover_stand_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_stand_torso_to_cover_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_stand",undefined,"death_pain_cover_stand_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_stand_r_arm_to_cover_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_stand",undefined,"death_pain_cover_stand_r_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_stand_l_arm_to_cover_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_stand",undefined,"death_pain_cover_stand_l_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_crouch_torso",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_crouch_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_torso_to_cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_crouch_torso_to_cover_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_crouch_head",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_crouch_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_head_to_cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_crouch_head_to_cover_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_stand_back",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED3,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_stand_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_stand_back_to_cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_stand_back_to_cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_stand_back_to_cover_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_stand",undefined,"death_pain_cover_stand_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_crouch_back",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED3,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_crouch_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_back_to_cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_crouch_back_to_cover_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_crouch_head_to_cover_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_crouch",undefined,"death_pain_cover_crouch_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_crouch_torso_to_cover_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_crouch",undefined,"death_pain_cover_crouch_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_crouch_back_to_cover_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_crouch",undefined,"death_pain_cover_crouch_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_head",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_right_stand_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_head_to_cover_right_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_right_stand_head_to_cover_right_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_torso",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_right_stand_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_torso_to_cover_right_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_right_stand_torso_to_cover_right_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_r_arm",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_right_stand_r_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_r_arm_to_cover_right_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_right_stand_r_arm_to_cover_right_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_l_arm",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_right_stand_l_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_l_arm_to_cover_right_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_right_stand_l_arm_to_cover_right_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_back",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED3,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_right_stand_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_back_to_cover_right_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_right_stand_back_to_cover_right_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_r_leg",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_right_stand_r_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_r_leg_to_cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_right_stand_r_leg_to_cover_right_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_l_leg",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_right_stand_l_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_l_leg_to_cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_right_stand_l_leg_to_cover_right_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_crouch_torso",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_right_crouch_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_right_crouch_torso_to_cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_right_crouch_torso_to_cover_right_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_crouch_head",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_right_crouch_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_right_crouch_head_to_cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_right_crouch_head_to_cover_right_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_crouch_back",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED3,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_right_crouch_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_right_crouch_back_to_cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_right_crouch_back_to_cover_right_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_back",undefined,::lib_0C66::func_9DA8,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_head",undefined,::lib_0C66::func_9DA9,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_torso",undefined,::lib_0C66::func_9DAF,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_r_arm",undefined,::lib_0C66::func_9DAD,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_l_arm",undefined,::lib_0C66::func_9DAA,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_right_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_right_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_cover_right_crouch",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_cover_right_crouch_back",undefined,::lib_0C66::func_9DA8,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2375("pain_cover_right_crouch_head",undefined,::lib_0C66::func_9DA9,undefined);
	lib_0A1A::func_2375("pain_cover_right_crouch_torso",undefined,::lib_0C66::func_9DAF,undefined);
	lib_0A1A::func_2375("pain_cover_right_crouch_torso",undefined,::lib_0C66::func_9DAA,undefined);
	lib_0A1A::func_2375("pain_cover_right_crouch_torso",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_right_crouch_torso",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_right_crouch_torso",undefined,::lib_0C66::func_9DAD,undefined);
	lib_0A1A::func_2375("pain_cover_right_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_cover_right_stand_l_leg_to_cover_right_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_crouch",undefined,"death_pain_cover_right_stand_l_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_r_leg_to_cover_right_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_crouch",undefined,"death_pain_cover_right_stand_r_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_head_to_cover_right_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_stand",undefined,"death_pain_cover_right_stand_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_torso_to_cover_right_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_stand",undefined,"death_pain_cover_right_stand_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_r_arm_to_cover_right_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_stand",undefined,"death_pain_cover_right_stand_r_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_l_arm_to_cover_right_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_stand",undefined,"death_pain_cover_right_stand_l_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_stand_back_to_cover_right_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_stand",undefined,"death_pain_cover_right_stand_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_crouch_head_to_cover_right_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_crouch",undefined,"death_pain_cover_right_crouch_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_crouch_torso_to_cover_right_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_crouch",undefined,"death_pain_cover_right_crouch_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_right_crouch_back_to_cover_right_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_crouch",undefined,"death_pain_cover_right_crouch_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_head",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_left_stand_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_head_to_cover_left_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_left_stand_head_to_cover_left_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_torso",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_left_stand_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_torso_to_cover_left_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_left_stand_torso_to_cover_left_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_r_arm",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_left_stand_r_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_r_arm_to_cover_left_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_left_stand_r_arm_to_cover_left_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_l_arm",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_left_stand_l_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_l_arm_to_cover_left_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_left_stand_l_arm_to_cover_left_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_back",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED3,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_left_stand_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_back_to_cover_left_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_left_stand_back_to_cover_left_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_r_leg",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_left_stand_r_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_r_leg_to_cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_left_crouch_r_leg_to_cover_left_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_l_leg",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED5,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_left_stand_l_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_l_leg_to_cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_left_crouch_l_leg_to_cover_left_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_crouch_torso",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_left_crouch_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_torso_to_cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_left_crouch_torso_to_cover_left_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_crouch_head",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_left_crouch_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_head_to_cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_left_crouch_head_to_cover_left_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_crouch_back",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED3,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_cover_left_crouch_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_back_to_cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_cover_left_crouch_back_to_cover_left_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_crouch_l_leg_to_cover_left_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_left_crouch",undefined,"death_pain_cover_left_stand_l_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_crouch_r_leg_to_cover_left_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_left_crouch",undefined,"death_pain_cover_left_stand_r_leg",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_head_to_cover_left_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_left_stand",undefined,"death_pain_cover_left_stand_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_torso_to_cover_left_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_left_stand",undefined,"death_pain_cover_left_stand_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_r_arm_to_cover_left_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_left_stand",undefined,"death_pain_cover_left_stand_r_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_l_arm_to_cover_left_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_left_stand",undefined,"death_pain_cover_left_stand_l_arm",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_stand_back_to_cover_left_stand",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_left_stand",undefined,"death_pain_cover_left_stand_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_crouch_head_to_cover_left_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_left_crouch",undefined,"death_pain_cover_left_crouch_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_crouch_torso_to_cover_left_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_left_crouch",undefined,"death_pain_cover_left_crouch_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_crouch_back_to_cover_left_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_left_crouch",undefined,"death_pain_cover_left_crouch_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_cover_left_crouch",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_damage_shield_to_ground",undefined,::lib_0C66::func_FFE0,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_back",undefined,::lib_0C66::func_9DA8,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_head",undefined,::lib_0C66::func_9DA9,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_torso",undefined,::lib_0C66::func_9DAF,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_torso",undefined,::lib_0C66::func_9DAA,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_torso",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_torso",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_left_crouch_torso",undefined,::lib_0C66::func_9DAD,undefined);
	lib_0A1A::func_2375("pain_cover_left_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_cover_left_stand",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_damage_shield_to_ground",undefined,::lib_0C66::func_FFE0,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_back",undefined,::lib_0C66::func_9DA8,undefined);
	lib_0A1A::func_2375("choose_long_death",undefined,::lib_0C63::func_FFE5,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_head",undefined,::lib_0C66::func_9DA9,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_torso",undefined,::lib_0C66::func_9DAF,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_r_arm",undefined,::lib_0C66::func_9DAD,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_l_arm",undefined,::lib_0C66::func_9DAA,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2375("pain_cover_left_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_cover_left_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_stand_back",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED3,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_stand_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_back_to_exposed",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_back_to_exposed",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_back_to_exposed",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_stand",undefined,"death_pain_stand_back",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_lmg_stand",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_lmg_stand_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_lmg_stand_default",::lib_0C66::func_D4F2,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_lmg_or_turret_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_lmg_or_turret_stand",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_lmg_crouch",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_lmg_crouch_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2374("pain_lmg_crouch_default",::lib_0C66::func_D4F2,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_cover","cover_crouch",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_lmg_or_turret_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_lmg_or_turret_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_lmg_stand_high_default",::lib_0C66::func_D4F2,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_lmg_or_turret_stand_high",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_lmg_or_turret_stand_high",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_lmg_stand_high",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_lmg_stand_high_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2374("pain_lmg_prone",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_lmg_prone_default",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2374("pain_lmg_prone_default",::lib_0C66::func_D4F2,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_prone",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_lmg_or_turret_prone",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_lmg_or_turret_prone",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_lmg_or_turret_stand",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_stand_turret",undefined,::lib_0C62::func_12A82,undefined);
	lib_0A1A::func_2375("cover_stand_lmg",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_lmg_or_turret_crouch",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_crouch_turret",undefined,::lib_0C62::func_12A82,undefined);
	lib_0A1A::func_2375("cover_crouch_lmg",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_lmg_or_turret_stand_high",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_stand_high_turret",undefined,::lib_0C62::func_12A82,undefined);
	lib_0A1A::func_2375("cover_stand_high_lmg",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_lmg_or_turret_prone",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_prone_turret",undefined,::lib_0C62::func_12A82,undefined);
	lib_0A1A::func_2375("cover_prone_lmg",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_deafened",::lib_0C66::func_D4EE,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEF,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pain_damage_shield_to_ground",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_crouch_damage_shield_to_ground",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2375("pain_stand_damage_shield_to_ground",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_stand_damage_shield_to_ground",::lib_0C66::func_D4EF,undefined,undefined,::lib_0C66::func_D4F0,undefined,::lib_0C66::func_3E9D,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_damage_shield_to_ground_end",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_crouch_damage_shield_to_ground",::lib_0C66::func_D4EF,undefined,undefined,::lib_0C66::func_D4F0,undefined,::lib_0C66::func_3E9D,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_damage_shield_to_ground_end",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pain_damage_shield_to_ground_end",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_cover_stand_default",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_damage_shield_to_ground",undefined,::lib_0C66::func_FFE0,undefined);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_cover_stand_default_internal",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_cover_crouch_default",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_special",undefined,::lib_0A1E::func_9F70,undefined);
	lib_0A1A::func_2375("pain_damage_shield_to_ground",undefined,::lib_0C66::func_FFE0,undefined);
	lib_0A1A::func_2375("pain_cover_crouch_default_internal",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_stand_head02",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_stand_head02",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_head_to_exposed02",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_head_to_exposed02",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2374("pain_stand_head_to_exposed02",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_stand",undefined,"death_pain_stand_head02",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_head04",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_stand_head04",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_head_to_exposed04",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_head_to_exposed04",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2374("pain_stand_head_to_exposed04",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_stand",undefined,"death_pain_stand_head04",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_head03",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_stand_head03",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_head_to_exposed03",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_head_to_exposed03",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2374("pain_stand_head_to_exposed03",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_stand",undefined,"death_pain_stand_head03",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_pass_stand_head",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_pass_stand_head_randomize",undefined,::scripts\asm\shared_utility::func_DCB8,undefined);
	lib_0A1A::func_2374("pain_pass_stand_head_randomize",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_stand_head",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_stand_head02",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_stand_head03",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_stand_head04",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_stand_torso02",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_stand_torso02",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_torso_to_exposed02",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_torso_to_exposed02",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2374("pain_stand_torso_to_exposed02",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_stand",undefined,"death_pain_stand_torso02",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_torso03",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_stand_torso03",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_torso_to_exposed03",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_torso_to_exposed03",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2374("pain_stand_torso_to_exposed03",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_stand",undefined,"death_pain_stand_torso03",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_stand_torso04",::lib_0C66::func_D4F4,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3EEC,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_stand_torso04",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_stand_torso_to_exposed04",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_stand_torso_to_exposed04",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pain_stand_l_leg",undefined,::lib_0C66::func_9DAC,undefined);
	lib_0A1A::func_2375("pain_stand_r_leg",undefined,::lib_0C66::func_9DAE,undefined);
	lib_0A1A::func_2374("pain_stand_torso_to_exposed04",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_stand",undefined,"death_pain_stand_torso04",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_pass_stand_torso",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_pass_stand_torso_randomize",undefined,::scripts\asm\shared_utility::func_DCB8,undefined);
	lib_0A1A::func_2374("pain_pass_stand_torso_randomize",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_stand_torso",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_stand_torso02",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_stand_torso03",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_stand_torso04",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_pass_crouch_torso",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_pass_crouch_torso_randomize",undefined,::scripts\asm\shared_utility::func_DCB8,undefined);
	lib_0A1A::func_2374("pain_pass_crouch_torso_randomize",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_crouch_torso03",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_crouch_torso",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_crouch_torso02",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_crouch_torso",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_crouch_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_crouch_torso_to_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_crouch_torso_to_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_head",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_crouch_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_crouch_head_to_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_crouch_head_to_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_head_to_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_crouch",undefined,"death_pain_crouch_head",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_head_to_crouch02",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_crouch",undefined,"death_pain_crouch_head02",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_head_to_crouch03",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_crouch",undefined,"death_pain_crouch_head03",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_head02",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_crouch_head02",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_crouch_head_to_crouch02",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_crouch_head_to_crouch02",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_head03",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_crouch_head03",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_crouch_head_to_crouch03",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_crouch_head_to_crouch03",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_pass_crouch_head",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_pass_crouch_head_randomize",undefined,::scripts\asm\shared_utility::func_DCB8,undefined);
	lib_0A1A::func_2374("pain_pass_crouch_head_randomize",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pain_crouch_head",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_crouch_head02",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2375("pain_crouch_head03",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pain_crouch_torso02",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_crouch_torso02",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_crouch_torso_to_crouch02",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_crouch_torso_to_crouch02",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_torso03",::lib_0C66::func_CF05,undefined,undefined,::lib_0C66::func_4109,undefined,::lib_0C66::func_3ED4,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_pain_crouch_torso03",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pain_crouch_torso_to_crouch03",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pain_crouch_torso_to_crouch03",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_torso_to_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_crouch",undefined,"death_pain_crouch_torso",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_torso_to_crouch02",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_crouch",undefined,"death_pain_crouch_torso02",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("pain_crouch_torso_to_crouch03",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_crouch",undefined,"death_pain_crouch_torso03",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("ik_finger_pose_l",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("ik_finger_pose_r",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("patrol_move",::lib_0C67::func_D4DF,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"patrol",undefined,undefined,undefined,"idle","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("patrol_react",undefined,::lib_0C67::func_C9A0,undefined);
	lib_0A1A::func_2375("pass_change_move_type",undefined,::scripts\asm\shared_utility::func_BD26,"patrol");
	lib_0A1A::func_2375("patrol_move_abort",undefined,::lib_0C67::func_C97D,undefined);
	lib_0A1A::func_2375("patrol_arrival",undefined,::lib_0C5D::func_10091,["Exposed",0,"patrol"]);
	lib_0A1A::func_2375("patrol_turn",undefined,::lib_0C65::func_FFF8,["patrol_turn",1,"patrol"]);
	lib_0A1A::func_2375("patrol_idle",undefined,::func_123F8,undefined);
	lib_0A1A::func_2375("patrol_flourish",undefined,::lib_0C67::func_C99F,"patrol");
	lib_0A1A::func_2375("patrol_stairs_down",undefined,::lib_0C65::func_9EC9,["down","patrol"]);
	lib_0A1A::func_2375("patrol_stairs_up",undefined,::lib_0C65::func_9EC9,["up","patrol"]);
	lib_0A1A::func_2375("patrol_stairs_arrival_up",undefined,::lib_0C65::func_10005,["up","patrol"]);
	lib_0A1A::func_2375("patrol_stairs_arrival_down",undefined,::lib_0C65::func_10005,["down","patrol"]);
	lib_0A1A::func_2374("patrol_exit",::lib_0C65::func_CEB5,undefined,undefined,undefined,undefined,::lib_0C65::func_3E9F,"patrol",undefined,undefined,undefined,"idle",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("patrol_react",undefined,::lib_0C67::func_C9A0,undefined);
	lib_0A1A::func_2375("patrol_idle_abort",undefined,::lib_0C67::func_C97D,undefined);
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("patrol_arrival",::lib_0C5D::func_CEAA,undefined,undefined,::lib_0C5D::func_22F3,undefined,::lib_0C5D::func_3E97,["Exposed","patrol"],undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("patrol_react",undefined,::lib_0C67::func_C9A0,undefined);
	lib_0A1A::func_2375("patrol_idle_abort",undefined,::lib_0C67::func_C97D,undefined);
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("patrol_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("patrol_idle",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"patrol",undefined,undefined,undefined,"idle","pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("patrol_react",undefined,::lib_0C67::func_C9A0,undefined);
	lib_0A1A::func_2375("patrol_idle_abort",undefined,::lib_0C67::func_C97D,undefined);
	lib_0A1A::func_2375("patrol_exit",undefined,::lib_0A1A::func_BCE7,"patrol");
	lib_0A1A::func_2374("patrol_idle_abort",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("patrol_move_abort",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stand_run_loop_pass",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("patrol_react",::lib_0C67::func_CEBF,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"idle","pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("patrol_react",undefined,::lib_0C67::func_C9A0,undefined);
	lib_0A1A::func_2375("patrol_react_end",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("patrol_react_end",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("patrol_react_end",undefined,::lib_0C67::func_C9A1,undefined);
	lib_0A1A::func_2374("patrol_turn",::lib_0C65::func_D514,undefined,undefined,undefined,undefined,::lib_0C65::func_3EF5,undefined,undefined,undefined,undefined,"idle","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("patrol_react",undefined,::lib_0C67::func_C9A0,undefined);
	lib_0A1A::func_2375("patrol_move_abort",undefined,::lib_0C67::func_C97D,undefined);
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("patrol_flourish",::lib_0C67::func_CEBE,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"idle",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("patrol_react",undefined,::lib_0C67::func_C9A0,undefined);
	lib_0A1A::func_2375("patrol_move_abort",undefined,::lib_0C67::func_C97D,undefined);
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("patrol_react_end",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("patrol_idle_abort",undefined,::lib_0C67::func_C97D,undefined);
	lib_0A1A::func_2375("patrol_move",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("patrol_stairs_down",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"patrol",undefined,undefined,undefined,"idle","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("patrol_react",undefined,::lib_0C67::func_C9A0,undefined);
	lib_0A1A::func_2375("patrol_move_abort",undefined,::lib_0C67::func_C97D,undefined);
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2375("patrol_stairs_exit_down",undefined,::lib_0C65::func_1000E,"down");
	lib_0A1A::func_2375("patrol_stairs_up",undefined,::lib_0C65::func_9EC9,["up","patrol"]);
	lib_0A1A::func_2374("patrol_stairs_up",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"patrol",undefined,undefined,undefined,"idle","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("patrol_react",undefined,::lib_0C67::func_C9A0,undefined);
	lib_0A1A::func_2375("patrol_move_abort",undefined,::lib_0C67::func_C97D,undefined);
	lib_0A1A::func_2375("patrol_stairs_exit_up",undefined,::lib_0C65::func_1000E,"up");
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2375("patrol_stairs_down",undefined,::lib_0C65::func_9EC9,["down","patrol"]);
	lib_0A1A::func_2374("patrol_stairs_exit_up",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,"patrol",undefined,undefined,undefined,"idle","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("patrol_stairs_arrival_up",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,"patrol",undefined,undefined,undefined,"idle","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("patrol_stairs_up",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("patrol_stairs_arrival_down",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"patrol",undefined,undefined,undefined,"idle",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("patrol_stairs_down",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("patrol_stairs_exit_down",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"patrol",undefined,undefined,undefined,"idle",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stumbling_pain_transition",::lib_0C63::func_D540,undefined,undefined,undefined,undefined,::lib_0C63::func_3F05,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("stumbling_pain_pick_wander_type",0,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stumbling_pain_wander",::lib_0C63::func_D541,undefined,undefined,undefined,undefined,::lib_0C63::func_3F05,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("stumbling_pain_collapse",0.05,::lib_0A1A::func_68B0,"pain_wander_done");
	lib_0A1A::func_2375("stumbling_pain_collapse",undefined,::lib_0C63::func_8BD5,undefined);
	lib_0A1A::func_2374("stumbling_pain_collapse",::lib_0C63::func_AFE5,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,"stumbling_pain_collapse_death",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2374("stumbling_pain_death",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C63::func_3F05,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("stumbling_pain_wander_with_death",::lib_0C63::func_D541,undefined,undefined,undefined,undefined,::lib_0C63::func_3F05,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"stumbling_pain_death",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("stumbling_pain_collapse",0.05,::lib_0A1A::func_68B0,"pain_wander_done");
	lib_0A1A::func_2375("stumbling_pain_collapse",undefined,::lib_0C63::func_8BD5,undefined);
	lib_0A1A::func_2374("stumbling_pain_pick_wander_type",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stumbling_pain_collapse",0.05,::lib_0C63::func_8BD5,undefined);
	lib_0A1A::func_2375("stumbling_pain_wander_with_death",undefined,::lib_0C63::func_582C,undefined);
	lib_0A1A::func_2375("stumbling_pain_wander",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("stumbling_pain_collapse_death",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0C63::func_3F05,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2374("crawling_pain_to_belly",::lib_0C63::func_CF07,undefined,undefined,undefined,undefined,::lib_0C63::func_3EC8,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"dying_crawl_death",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("DecideDyingCrawl",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dying_crawl",::lib_0C63::func_CF2A,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"dying_crawl_death",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("DecideFlipOver",undefined,::lib_0A1A::func_68B0,"dying_crawl_done");
	lib_0A1A::func_2374("dying_crawl_flipover",::lib_0C63::func_CF06,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"flipover",undefined,undefined,undefined,"pain",undefined,undefined,"dying_back_crawl_death",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("dying_back_crawl",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("dying_back_crawl",::lib_0C63::func_CF2B,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"backcrawl",undefined,undefined,undefined,"pain",undefined,undefined,"dying_back_crawl_death",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("DecideShoot",undefined,::lib_0A1A::func_68B0,"dying_back_crawl_done");
	lib_0A1A::func_2375("dying_back_quit",undefined,::lib_0C63::func_10001,undefined);
	lib_0A1A::func_2375("dying_back_quit",undefined,::lib_0C63::func_8BD5,undefined);
	lib_0A1A::func_2374("crawling_pain_to_back",::lib_0C63::func_CF07,undefined,undefined,undefined,undefined,::lib_0C63::func_3EC8,undefined,undefined,undefined,undefined,"pain",undefined,undefined,"dying_back_crawl_death",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("dying_back_crawl",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("dying_back_quit",0.3,::lib_0C63::func_10001,undefined);
	lib_0A1A::func_2375("dying_back_quit",undefined,::lib_0C63::func_8BD5,undefined);
	lib_0A1A::func_2374("dying_crawl_death",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("dying_back_crawl_death",::lib_0C60::func_CF0E,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("DecideDyingCrawl",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"dying_crawl_death",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("dying_crawl_quit",undefined,::lib_0C63::func_8BD5,undefined);
	lib_0A1A::func_2375("dying_crawl",undefined,::lib_0C63::func_FFEC,undefined);
	lib_0A1A::func_2375("DecideFlipOver",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("DecideFlipOver",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"dying_crawl_death",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("dying_crawl_flipover",undefined,::lib_0C63::func_10013,undefined);
	lib_0A1A::func_2375("dying_crawl_quit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("dying_crawl_quit",::lib_0C63::func_AFE5,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,"dying_crawl_death",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2374("dying_back_idle",::lib_0C63::func_CF28,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"idle",undefined,undefined,undefined,"pain",undefined,undefined,"dying_back_crawl_death",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("dying_back_quit",undefined,::lib_0C63::func_10001,undefined);
	lib_0A1A::func_2375("dying_back_quit",undefined,::lib_0C63::func_8BD5,undefined);
	lib_0A1A::func_2375("dying_back_shoot",undefined,::lib_0C63::func_AFE6,undefined);
	lib_0A1A::func_2374("dying_back_quit",::lib_0C63::func_AFE5,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"death",undefined,undefined,"dying_back_crawl_death",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2374("dying_back_shoot",::lib_0C63::func_CF29,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,"shoot",undefined,undefined,undefined,"pain",undefined,undefined,"dying_back_crawl_death",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("dying_back_quit",undefined,::lib_0C63::func_10001,undefined);
	lib_0A1A::func_2375("dying_back_quit",undefined,::lib_0C63::func_8BD5,undefined);
	lib_0A1A::func_2375("dying_back_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("DecideShoot",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"dying_crawl_death",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("dying_back_shoot",undefined,::lib_0C63::func_AFE6,undefined);
	lib_0A1A::func_2375("dying_back_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("choose_long_death",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stumbling_pain_transition",undefined,::lib_0C63::func_FFFB,undefined);
	lib_0A1A::func_2375("crawling_pain_to_belly",undefined,::lib_0C63::func_FFEA,undefined);
	lib_0A1A::func_2375("crawling_pain_to_back",undefined,::lib_0C63::func_FFE9,undefined);
	lib_0A1A::func_2374("step_up_24",::lib_0C6B::func_D566,24,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("iw6_jumpdown_40",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("step_down_24",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("combatrun_forward_72",::lib_0C6B::func_D565,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,"stand",undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2374("wall_hop",::lib_0C6B::func_D55D,39.875,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_130",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_128",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("double_jump_temp",::lib_0C6B::func_D55E,undefined,undefined,::lib_0C6B::func_126D2,"exposed_idle",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("traverse_external",::lib_0C6B::func_D560,undefined,undefined,undefined,"exposed_idle",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("iw6_jumpdown_88",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("iw6_jumpdown_72",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("iw6_jumpdown_56",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_56",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_40",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("stepup_52_fast",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("stepup_52",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("iw6_stepup_32",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("step_up_32",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_40",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_over_quick",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("window_divethrough_36",::lib_0C6B::func_D566,undefined,undefined,undefined,"exposed_crouch",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("slide_across_car",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_climb_90",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("iw6_traverse_over_40",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("move_forward_72",::lib_0C6B::func_D565,undefined,undefined,undefined,"soldier_start",::scripts\asm\shared_utility::func_3ECD,"move",undefined,"stand",undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2374("jumpdown_rail_130",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_rail_96",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_rail_88",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_rail_72",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_rail_56",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_rail_40",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_run_loop",::lib_0C6B::func_D5D4,undefined,undefined,undefined,undefined,::lib_0C6B::func_3F0E,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_wall_run_exit",undefined,::lib_0A1A::func_68B0,"wall_run_loop_done");
	lib_0A1A::func_2374("double_jump",::lib_0C6B::func_CF24,undefined,undefined,::lib_0C6B::doublejumpearlyterminate,"stand_run_loop",::lib_0C6B::func_3ED2,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("double_jump_check_finish",undefined,::lib_0C6B::func_9DCA,undefined);
	lib_0A1A::func_2374("wall_run",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("wall_run_turn",undefined,::lib_0C6B::func_FFFD,undefined);
	lib_0A1A::func_2375("traversal_transition_cleanup",undefined,::lib_0C6B::func_4123,undefined);
	lib_0A1A::func_2375("wall_run_jump",undefined,::lib_0C6B::func_9EBA,undefined);
	lib_0A1A::func_2374("wall_run_exit",::lib_0C6B::func_D5D3,undefined,undefined,::lib_0C6B::wallrunterminate,"stand_run_loop",::lib_0C6B::func_3F10,undefined,["aim"],undefined,["shoot"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("decide_wall_run_exit",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("wall_run_continue",undefined,::lib_0C6B::func_8BCB,undefined);
	lib_0A1A::func_2375("wall_run_to_vault_over",undefined,::lib_0C6B::func_100C0,undefined);
	lib_0A1A::func_2375("wall_run_to_mantle_high",undefined,::func_12080,undefined);
	lib_0A1A::func_2375("wall_run_to_mantle_low",undefined,::func_12084,undefined);
	lib_0A1A::func_2375("wall_run_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("wall_run_continue",::lib_0C6B::func_D5D0,undefined,undefined,undefined,undefined,::lib_0C6B::func_3F0E,undefined,["aim"],undefined,["shoot"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_wall_run_shoot_or_not",0,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("wall_run_to_mantle_high",::lib_0C6B::func_D5D5,undefined,undefined,::lib_0C6B::wallrunterminate,"stand_run_loop",::lib_0C6B::func_3F0E,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_run_left_shoot",::lib_0C6B::func_D5D4,undefined,undefined,undefined,undefined,::lib_0C6B::func_3F0E,undefined,["aim"],undefined,["shoot"],"aim",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_wall_run_exit",undefined,::lib_0A1A::func_68B0,"wall_run_loop_done");
	lib_0A1A::func_2374("decide_wall_run_shoot_or_not",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_wall_run_direction_continue",undefined,::lib_0C6B::func_100BF,undefined);
	lib_0A1A::func_2375("wall_run_loop",0,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("wall_run_right_shoot",::lib_0C6B::func_D5D4,undefined,undefined,undefined,undefined,::lib_0C6B::func_3F0E,undefined,["aim"],undefined,["shoot"],"aim",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_wall_run_exit",undefined,::lib_0A1A::func_68B0,"wall_run_loop_done");
	lib_0A1A::func_2374("decide_wall_run_direction",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("wall_run_attach_left_shoot",0,::func_1207C,undefined);
	lib_0A1A::func_2375("wall_run_attach_right_shoot",0,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("wall_run_to_mantle_low",::lib_0C6B::func_D5D5,undefined,undefined,::lib_0C6B::wallrunterminate,"stand_run_loop",::lib_0C6B::func_3F0E,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_run_jump",::lib_0C6B::func_D5D2,undefined,::lib_0C6B::func_138D4,undefined,undefined,::lib_0C6B::func_3F0F,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("decide_wall_run_shoot_or_not_during_attach",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("decide_wall_run_shoot_or_not_during_attach",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("traversal_transition",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("traversal_orient",undefined,::lib_0C6B::func_FFFC,undefined);
	lib_0A1A::func_2375("traversal_transition_cleanup",undefined,::lib_0C6B::func_4123,undefined);
	lib_0A1A::func_2374("traversal_transition_cleanup",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("wall_run_turn",::lib_0C65::func_D514,undefined,undefined,undefined,undefined,::lib_0C6B::func_3F12,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("wall_run_jump",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("wall_run_jump",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("wall_run_attach",::lib_0C6B::func_D5CF,undefined,::lib_0C6B::func_89FB,undefined,undefined,::lib_0C6B::func_3F0D,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("decide_wall_run_shoot_or_not",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("decide_wall_run_exit",undefined,::lib_0C6B::func_FFB7,undefined);
	lib_0A1A::func_2374("traversal_orient",::lib_0C6B::func_D55B,undefined,undefined,::lib_0C6B::traversalorientearlyterminate,undefined,::lib_0C6B::func_3F07,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("traversal_transition_done",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("traversal_transition_done",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("wall_run_to_vault_over",::lib_0C6B::func_D5D5,undefined,undefined,::lib_0C6B::wallrunterminate,"stand_run_loop",::lib_0C6B::func_3F0E,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("wall_run_attach_left_shoot",::lib_0C6B::func_D5CF,"shoot",::lib_0C6B::func_89FB,undefined,undefined,::lib_0C6B::func_3F0D,undefined,["aim"],undefined,["shoot"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("wall_run_left_shoot",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("decide_wall_run_exit",undefined,::lib_0C6B::func_FFB7,undefined);
	lib_0A1A::func_2374("decide_wall_run_shoot_or_not_during_attach",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("decide_wall_run_direction",undefined,::lib_0C6B::func_100BF,undefined);
	lib_0A1A::func_2375("wall_run_attach",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("wall_run_attach_right_shoot",::lib_0C6B::func_D5CF,"shoot",::lib_0C6B::func_89FB,undefined,undefined,::lib_0C6B::func_3F0D,undefined,["aim"],undefined,["shoot"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("wall_run_right_shoot",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("decide_wall_run_exit",undefined,::lib_0C6B::func_FFB7,undefined);
	lib_0A1A::func_2374("decide_wall_run_direction_continue",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("wall_run_left_shoot",undefined,::func_12079,undefined);
	lib_0A1A::func_2375("wall_run_right_shoot",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("double_jump_mantle",::lib_0C6B::func_CF1F,undefined,undefined,::lib_0C6B::doublejumpearlyterminate,"stand_run_loop",::lib_0C6B::func_3ED2,"up",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("double_jump_mantle_finish",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("double_jump_vault",::lib_0C6B::func_CF26,undefined,undefined,::lib_0C6B::doublejumpearlyterminate,"stand_run_loop",::lib_0C6B::func_3ED2,"up",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("double_jump_vault_finish",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("double_jump_mantle_finish",::lib_0C6B::func_CF1E,undefined,undefined,::lib_0C6B::doublejumpterminate,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("double_jump_vault_finish",::lib_0C6B::func_CF1E,undefined,undefined,::lib_0C6B::doublejumpterminate,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("double_jump_finish",::lib_0C6B::func_CF1E,undefined,undefined,::lib_0C6B::doublejumpterminate,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("double_jump_check_finish",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("double_jump_finish",undefined,::lib_0C6B::func_3E04,undefined);
	lib_0A1A::func_2374("jumpup_72",::lib_0C6B::func_D566,72,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpup_96",::lib_0C6B::func_D566,96,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpup_128",::lib_0C6B::func_D566,128,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpup_24",::lib_0C6B::func_D566,24,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpup_36",::lib_0C6B::func_D566,36,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpup_48",::lib_0C6B::func_D566,48,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_24",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_36",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_48",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_72",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_96",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpover_36",::lib_0C6B::func_D566,36,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpover_52",::lib_0C6B::func_D566,52,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpover_64",::lib_0C6B::func_D566,64,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpover_40",::lib_0C6B::func_D566,40,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_rail_48",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_rail_36",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpdown_rail_24",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpup_rail_48",::lib_0C6B::func_D566,48,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpup_rail_36",::lib_0C6B::func_D566,36,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpup_rail_24",::lib_0C6B::func_D566,24,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("jumpup_rail_72",::lib_0C6B::func_D566,72,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("soldier_iw6_wall_hop",::lib_0C6B::func_D55D,39.875,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("rail_hop_double_jump_down",::lib_0C6B::func_CF24,undefined,undefined,::lib_0C6B::doublejumpearlyterminate,"stand_run_loop",::lib_0C6B::func_3ED2,"down",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("double_jump_check_finish",undefined,::lib_0C6B::func_9DCA,undefined);
	lib_0A1A::func_2374("traversal_transition_done",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("double_jump",undefined,::lib_0C6B::func_100B3,undefined);
	lib_0A1A::func_2375("wall_run_jump",undefined,::func_125D3,undefined);
	lib_0A1A::func_2375("double_jump_vault",undefined,::lib_0C6B::func_100B3,undefined);
	lib_0A1A::func_2375("double_jump_mantle",undefined,::lib_0C6B::func_100B3,undefined);
	lib_0A1A::func_2375("rail_hop_double_jump_down",undefined,::lib_0C6B::func_100B3,undefined);
	lib_0A1A::func_2374("jumpdown_rail_130_32",::lib_0C6B::func_D566,undefined,undefined,undefined,"stand_run_loop",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("cover_left_hide_to_shuffle",::lib_0F3D::func_CECD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
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
	lib_0A1A::func_2374("cover_right_hide_to_shuffle",::lib_0F3D::func_CECD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("crouch_shuffle_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("crouch_shuffle_left",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("shuffle_left_to_cover_left",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_to_shuffle_l",::lib_0F3D::func_CECD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("crouch_shuffle_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("crouch_shuffle_left",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("cover_crouch_to_shuffle_r",::lib_0F3D::func_CECD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("shuffle_abort",undefined,::lib_0C5E::func_FFB5,undefined);
	lib_0A1A::func_2375("crouch_shuffle_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("crouch_shuffle_right",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("shuffle_right_to_cover_right",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_to_shuffle_l",::lib_0F3D::func_CECD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_to_shuffle_l_complete",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("stand_to_shuffle_l_complete",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("cover_stand_to_shuffle_r",::lib_0F3D::func_CECD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
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
	lib_0A1A::func_2374("cover_right_to_cover_left_door_shuffle",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_to_cover_right_door_shuffle",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
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
	lib_0A1A::func_2374("cover_right_crouch_to_cover_left_crouch_door_shuffle",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_to_cover_right_crouch_door_shuffle",::lib_0C5E::func_D518,undefined,undefined,::lib_0C5E::func_D519,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch",::lib_0C5E::func_CF02,"stickToNode",undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"hide_loop",["gesture"],"crouch",["gesture"],"angry","pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_crouch_to_shuffle_l_pass",undefined,::lib_0A1B::func_2935,"left");
	lib_0A1A::func_2375("cover_crouch_to_shuffle_r_pass",undefined,::lib_0A1B::func_2935,"right");
	lib_0A1A::func_2375("cover_crouch_turret_deploy",undefined,::lib_0C62::func_12A82,undefined);
	lib_0A1A::func_2375("cover_crouch_lmg_pass",undefined,::lib_0F43::func_4C03,"Cover Crouch LMG");
	lib_0A1A::func_2375("pass_cover_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_crouch_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch_hide_to_stand",undefined,::lib_0A1B::func_2946,"full exposed");
	lib_0A1A::func_2375("cover_crouch_hide_to_left",undefined,::lib_0A1B::func_2946,"left");
	lib_0A1A::func_2375("cover_crouch_hide_to_right",undefined,::lib_0A1B::func_2946,"right");
	lib_0A1A::func_2375("cover_crouch_blindfire",undefined,::func_11C87,undefined);
	lib_0A1A::func_2375("cover_crouch_reload",undefined,::func_11CAD,undefined);
	lib_0A1A::func_2375("cover_crouch_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_crouch_hide_to_lean",undefined,::lib_0A1B::func_2946,"leanover");
	lib_0A1A::func_2375("cover_crouch_peek",undefined,::lib_0A1B::func_2948,"peek");
	lib_0A1A::func_2375("cover_crouch_hide_to_aim",undefined,::lib_0A1B::func_2948,"exposed");
	lib_0A1A::func_2375("cover_crouch_order_reaction",undefined,::lib_0C4C::func_3DF2,"defending_action");
	lib_0A1A::func_2375("cover_crouch_infantry_reaction",undefined,::lib_0C4C::func_3DF2,"threat_infantry");
	lib_0A1A::func_2375("cover_crouch_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"takingfire");
	lib_0A1A::func_2375("cover_crouch_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"friendlyfire");
	lib_0A1A::func_2374("cover_crouch_hide_to_stand",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_stand",["notetrackAim"],undefined,undefined,"angry","pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_hide_to_aim",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_aim",["notetrackAim"],"crouch",undefined,"aim","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_aim",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_aim_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"idle","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_hide_to_right",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_right",["notetrackAim"],"crouch",undefined,"angry","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_right_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_stand_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_hide_to_left",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_left",["notetrackAim"],"crouch",undefined,"angry","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_left_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_hide_to_lean",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_lean",["notetrackAim"],"crouch",undefined,"angry","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_lean",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_lean_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_blindfire",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_blindfire",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_reload",::lib_0C5E::func_4742,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_crouch_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_aim",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],"aim","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_aim_to_hide",undefined,::func_11C0C,undefined);
	lib_0A1A::func_2375("cover_crouch_aim_drop_rpg",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2374("cover_crouch_lean",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],"aim","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_lean_to_hide",undefined,::lib_0A1B::func_2943,"leanover");
	lib_0A1A::func_2374("cover_crouch_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"pain","pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_crouch_exposed_left",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],"aim","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_left_drop_rpg",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch_left_to_hide",undefined,::lib_0A1B::func_2943,"left");
	lib_0A1A::func_2374("cover_crouch_exposed_right",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],"aim","pain_cover_crouch_default","suppress","death_cover","cover_crouch",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_exposed_right_drop_rpg",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch_right_to_hide",undefined,::lib_0A1B::func_2943,"right");
	lib_0A1A::func_2374("cover_crouch_stand",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"stand",["shoot"],"aim","pain_stand","cover_crouch_stand","death_standing",undefined,undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_stand_drop_rpg",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("cover_crouch_stand_to_hide",undefined,::lib_0A1B::func_2943,"full exposed");
	lib_0A1A::func_2374("cover_crouch_peek",::lib_0C5E::func_CEFC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,"cover_peek","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cqb_cover_crouch_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("cover_crouch_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_stand_drop_rpg",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle",undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_exposed_left_drop_rpg",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle",undefined,undefined,"death_cover","cover_crouch",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_exposed_right_drop_rpg",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle",undefined,undefined,"death_cover","cover_crouch",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("trans_to_cover_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch",0.1,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_cover_crouch_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_crouch_to_shuffle_l_pass",undefined,::lib_0A1B::func_2935,"left");
	lib_0A1A::func_2375("cover_crouch_to_shuffle_r_pass",undefined,::lib_0A1B::func_2935,"right");
	lib_0A1A::func_2375("cqb_cover_crouch_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("cover_crouch_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_crouch_to_exposed_idle",::lib_0C5E::func_D559,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0C5E::func_3F06,undefined,["notetrackAim"],"crouch",undefined,"angry","pain_cover_crouch",undefined,"death_cover","cover_crouch",undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_infantry_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,undefined,"pain_cover_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_crouch_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_takingfire_reaction",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_crouch_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_order_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,undefined,"pain_cover_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_crouch_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_aim_drop_rpg",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle",undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_reload",::lib_0C5E::func_4742,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_A_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_suppress",[undefined,"A"],"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exposed_A",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["shoot"],"aim","pain_cover_right_suppress",[undefined,"A"],"death_standing",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("cqb_exposed_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_A_to_B",undefined,::lib_0A1B::func_2947,"B");
	lib_0A1A::func_2375("cover_right_exposed_drop_rpg_A",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("cover_right_A_to_hide",undefined,::lib_0A1B::func_2943,"A");
	lib_0A1A::func_2374("cover_right_hide_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_exposed",["notetrackAim"],undefined,["shoot"],"angry","pain_cover_right_suppress",[undefined,"A"],"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exposed_B",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["shoot"],"aim","pain_cover_right_suppress",[undefined,"B"],"death_standing",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("cqb_exposed_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_B_to_A",undefined,::lib_0A1B::func_2947,"A");
	lib_0A1A::func_2375("cover_right_exposed_drop_rpg_B",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("cover_right_B_to_hide",undefined,::lib_0A1B::func_2943,"B");
	lib_0A1A::func_2374("cover_right_B_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_suppress",[undefined,"B"],"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_hide_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_exposed",["notetrackAim"],undefined,["shoot"],"angry","pain_cover_right_suppress",[undefined,"B"],"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right",::lib_0C5E::func_CF02,"stickToNode",undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"hide_loop",["gesture"],"stand",["gesture"],"angry","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_to_cover_left_door_shuffle",undefined,::lib_0A1B::func_2933,"right");
	lib_0A1A::func_2375("cover_right_hide_to_shuffle_pass",0.4,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_peek",undefined,::lib_0A1B::func_2948,"peek");
	lib_0A1A::func_2375("cover_right_stand_infantry_reaction",undefined,::lib_0C4C::func_3DF2,"threat_infantry");
	lib_0A1A::func_2375("cover_right_stand_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"takingfire");
	lib_0A1A::func_2375("cover_right_stand_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"friendlyfire");
	lib_0A1A::func_2375("cover_right_stand_order_reaction",undefined,::lib_0C4C::func_3DF2,"defending_action");
	lib_0A1A::func_2375("cover_right_reload",undefined,::func_11F32,undefined);
	lib_0A1A::func_2375("cover_right_hide_to_look",undefined,::lib_0A1B::func_2948,"look");
	lib_0A1A::func_2375("cover_right_stand_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("cover_right_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_right_blindfire",undefined,::func_11EEA,undefined);
	lib_0A1A::func_2375("cover_right_hide_to_B",undefined,::func_11F15,undefined);
	lib_0A1A::func_2375("cover_right_hide_to_A",undefined,::func_11F07,undefined);
	lib_0A1A::func_2375("cover_right_hide_to_lean",undefined,::func_11F23,undefined);
	lib_0A1A::func_2374("cover_right_hide_to_look",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_look",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_look",::lib_0C5E::func_CF02,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_look_to_hide",undefined,::func_11EDC,undefined);
	lib_0A1A::func_2374("cover_right_look_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_A_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"A_to_B",["aim"],undefined,["shoot"],"angry","pain_cover_right_suppress",[undefined,"B"],"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_B_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"B_to_A",["aim"],undefined,["shoot"],"angry","pain_cover_right_suppress",[undefined,"A"],"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch",::lib_0C5E::func_CF02,"stickToNode",undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"hide_loop",["gesture"],"crouch",["gesture"],"angry","pain_cover_right_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch_to_cover_left_crouch_door_shuffle",undefined,::lib_0A1B::func_2933,"right");
	lib_0A1A::func_2375("cover_right_hide_to_shuffle_pass",undefined,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("pass_cover_right_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_crouch_infantry_reaction",undefined,::lib_0C4C::func_3DF2,"threat_infantry");
	lib_0A1A::func_2375("cover_right_crouch_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"takingfire");
	lib_0A1A::func_2375("cover_right_crouch_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"friendlyfire");
	lib_0A1A::func_2375("cover_right_crouch_order_reaction",undefined,::lib_0C4C::func_3DF2,"defending_action");
	lib_0A1A::func_2375("cover_right_crouch_to_stand",undefined,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2375("cover_right_crouch_reload",undefined,::func_11E89,undefined);
	lib_0A1A::func_2375("cover_right_crouch_hide_to_look",undefined,::lib_0A1B::func_2948,"look");
	lib_0A1A::func_2375("cover_right_crouch_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_right_crouch_hide_to_A",undefined,::func_11E57,undefined);
	lib_0A1A::func_2375("cover_right_crouch_hide_to_B",undefined,::func_11E65,undefined);
	lib_0A1A::func_2375("cover_right_crouch_hide_to_lean",undefined,::func_11E73,undefined);
	lib_0A1A::func_2374("cover_right_stand_to_crouch",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_stance_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_to_stand",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_stance_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_right_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_exposed_A",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],"aim","pain_crouch",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("cover_right_crouch_A_to_B",undefined,::lib_0A1B::func_2947,"B");
	lib_0A1A::func_2375("cover_right_crouch_exposed_drop_rpg_A",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("cover_right_crouch_A_to_hide",undefined,::lib_0A1B::func_2943,"A");
	lib_0A1A::func_2374("cover_right_crouch_exposed_B",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],"aim","pain_crouch",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_crouch_B_to_A",undefined,::lib_0A1B::func_2947,"A");
	lib_0A1A::func_2375("cover_right_crouch_exposed_drop_rpg_B",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("cover_right_crouch_B_to_hide",undefined,::lib_0A1B::func_2943,"B");
	lib_0A1A::func_2374("cover_right_crouch_hide_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_A",["notetrackAim"],"crouch",["shoot"],"angry","pain_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_hide_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_B",["notetrackAim"],"crouch",["shoot"],"angry","pain_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_A_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_B_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_A_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"A_to_B",["aim"],"crouch",["shoot"],"angry","pain_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_B_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"B_to_A",["aim"],"crouch",["shoot"],"angry","pain_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_reload",::lib_0C5E::func_4742,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_right_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_right_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_look",::lib_0C5E::func_CF02,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_right_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_crouch_look_to_hide",undefined,::func_11E31,undefined);
	lib_0A1A::func_2374("cover_right_crouch_hide_to_look",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_right_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch_look",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_look_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_right_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_peek",::lib_0C5E::func_CEFC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,"cover_peek",undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_right_crouch_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"pain","pain_cover_right_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_right_blindfire",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_blindfire",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_lean",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["corner_cover_lean_shoot"],"aim","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_lean_to_hide",undefined,::lib_0A1B::func_2943,"lean");
	lib_0A1A::func_2374("cover_right_hide_to_lean",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_lean",["notetrackAim"],undefined,undefined,"angry","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_lean",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_lean_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_hide_to_lean",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_lean",["notetrackAim"],"crouch",undefined,"angry","pain_cover_right_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch_lean",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_lean",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["corner_cover_lean_shoot"],"angry","pain_cover_right_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_crouch_lean_to_hide",undefined,::lib_0A1B::func_2943,"lean");
	lib_0A1A::func_2374("cover_right_crouch_lean_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_right_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exposed_drop_rpg_B",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_exposed_drop_rpg_A",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exposed_drop_rpg_A",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_exposed_drop_rpg_B",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_to_exposed_crouch",::lib_0C5E::func_D559,undefined,undefined,undefined,undefined,::lib_0C5E::func_3F06,undefined,["notetrackAim"],"crouch",undefined,"idle","pain_cover_right_crouch",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_to_exposed_idle",::lib_0C5E::func_D559,undefined,undefined,undefined,undefined,::lib_0C5E::func_3F06,undefined,["notetrackAim"],"stand",undefined,"angry","pain_cover_right_stand",undefined,"death_cover","cover_right",undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("trans_to_cover_right",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("trans_to_cover_right_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_infantry_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,undefined,"pain_cover_right_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_stand_infantry_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,undefined,"pain_cover_right_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_takingfire_reaction",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_stand_takingfire_reaction",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_right_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_stand_order_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,undefined,"pain_cover_right_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_order_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,undefined,"pain_cover_right_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_right_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_right_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_cover_right_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cqb_cover_right_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("cover_right_to_cover_left_door_shuffle",undefined,::lib_0A1B::func_2933,"right");
	lib_0A1A::func_2375("cover_right_hide_to_shuffle_pass",0.4,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("cover_right_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_cover_right_crouch_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_right_crouch_to_cover_left_crouch_door_shuffle",undefined,::lib_0A1B::func_2933,"right");
	lib_0A1A::func_2375("cover_right_hide_to_shuffle_pass",undefined,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("cqb_cover_right_crouch_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("cover_right_crouch_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("trans_exposed_crouch_to_cover_right",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_right_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left",::lib_0C5E::func_CF02,"stickToNode",undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"hide_loop",["gesture"],"stand",["gesture"],"angry","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_to_cover_right_door_shuffle",undefined,::lib_0A1B::func_2933,"left");
	lib_0A1A::func_2375("cover_left_hide_to_shuffle_pass",0.4,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_stand_order_reaction",undefined,::lib_0C4C::func_3DF2,"defending_action");
	lib_0A1A::func_2375("cover_left_stand_infantry_reaction",undefined,::lib_0C4C::func_3DF2,"threat_infantry");
	lib_0A1A::func_2375("cover_left_stand_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"takingfire");
	lib_0A1A::func_2375("cover_left_stand_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"friendlyfire");
	lib_0A1A::func_2375("cover_left_reload",undefined,::func_11DE5,undefined);
	lib_0A1A::func_2375("cover_left_hide_to_look",undefined,::lib_0A1B::func_2948,"look");
	lib_0A1A::func_2375("cover_left_stand_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("cover_left_peek",undefined,::lib_0A1B::func_2948,"peek");
	lib_0A1A::func_2375("cover_left_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_left_blindfire",undefined,::func_11D9D,undefined);
	lib_0A1A::func_2375("cover_left_hide_to_A",undefined,::func_11DBB,undefined);
	lib_0A1A::func_2375("cover_left_hide_to_B",undefined,::func_11DC9,undefined);
	lib_0A1A::func_2375("cover_left_hide_to_lean",undefined,::func_11DD7,undefined);
	lib_0A1A::func_2374("cover_left_reload",::lib_0C5E::func_4742,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_exposed_A",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["shoot"],"aim","pain_cover_left_suppress",[undefined,"A"],"death_standing",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("cqb_exposed_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_A_to_B",undefined,::lib_0A1B::func_2947,"B");
	lib_0A1A::func_2375("cover_left_exposed_drop_rpg_A",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("cover_left_A_to_hide",undefined,::lib_0A1B::func_2943,"A");
	lib_0A1A::func_2374("cover_left_exposed_B",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["shoot"],"aim","pain_cover_left_suppress",[undefined,"B"],"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("cqb_exposed_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_B_to_A",undefined,::lib_0A1B::func_2947,"A");
	lib_0A1A::func_2375("cover_left_exposed_drop_rpg_B",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("cover_left_B_to_hide",undefined,::lib_0A1B::func_2943,"B");
	lib_0A1A::func_2374("cover_left_hide_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_exposed",["notetrackAim"],undefined,["shoot"],"angry","pain_cover_left_suppress",[undefined,"A"],"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_A_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",[undefined,"A"],"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_hide_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_exposed",["notetrackAim"],undefined,["shoot"],"angry","pain_cover_left_suppress",[undefined,"B"],"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_B_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_suppress",[undefined,"B"],"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_A_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"A_to_B",["aim"],undefined,["shoot"],"angry","pain_cover_left_suppress",[undefined,"B"],"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_B_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"B_to_A",["aim"],undefined,["shoot"],"angry","pain_cover_left_suppress",[undefined,"A"],"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_look",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_look_to_hide",undefined,::func_11D8E,undefined);
	lib_0A1A::func_2374("cover_left_look_to_hide",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_hide_to_look",::lib_0F3D::func_CEA8,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_look",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch",::lib_0C5E::func_CF02,"stickToNode",undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"hide_loop",["gesture"],"crouch",["gesture"],"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_cover_right_crouch_door_shuffle",undefined,::lib_0A1B::func_2933,"left");
	lib_0A1A::func_2375("cover_left_hide_to_shuffle_pass",undefined,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch_order_reaction",undefined,::lib_0C4C::func_3DF2,"defending_action");
	lib_0A1A::func_2375("cover_left_crouch_infantry_reaction",undefined,::lib_0C4C::func_3DF2,"threat_infantry");
	lib_0A1A::func_2375("cover_left_crouch_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"takingfire");
	lib_0A1A::func_2375("cover_left_crouch_takingfire_reaction",undefined,::lib_0C4C::func_3DF2,"friendlyfire");
	lib_0A1A::func_2375("cover_left_crouch_to_stand",undefined,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2375("cover_left_crouch_reload",undefined,::func_11D53,undefined);
	lib_0A1A::func_2375("cover_left_crouch_hide_to_look",undefined,::lib_0A1B::func_2948,"look");
	lib_0A1A::func_2375("cover_left_crouch_peek",undefined,::lib_0A1B::func_2948,"peek");
	lib_0A1A::func_2375("cover_left_crouch_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("cover_left_crouch_hide_to_A",undefined,::func_11D26,undefined);
	lib_0A1A::func_2375("cover_left_crouch_hide_to_B",undefined,::func_11D35,undefined);
	lib_0A1A::func_2375("cover_left_crouch_hide_to_lean",undefined,::func_11D44,undefined);
	lib_0A1A::func_2374("cover_left_crouch_to_stand",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_stance_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_exposed_A",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],"aim","pain_cover_left_crouch",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch_A_to_B",undefined,::lib_0A1B::func_2947,"B");
	lib_0A1A::func_2375("cover_left_crouch_exposed_drop_rpg_A",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("cover_left_crouch_A_to_hide",undefined,::lib_0A1B::func_2943,"A");
	lib_0A1A::func_2374("cover_left_crouch_exposed_B",::lib_0C5E::func_CF02,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["shoot"],"aim","pain_crouch",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch_B_to_A",undefined,::lib_0A1B::func_2947,"A");
	lib_0A1A::func_2375("cover_left_crouch_exposed_drop_rpg_B",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("cover_left_crouch_B_to_hide",undefined,::lib_0A1B::func_2943,"B");
	lib_0A1A::func_2374("cover_left_crouch_hide_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_A",["notetrackAim"],"crouch",["shoot"],"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_hide_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_B",["notetrackAim"],"crouch",["shoot"],"angry","pain_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_A_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_B_to_hide",::lib_0C5E::func_CEFC,"alignToNode",undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_A_to_B",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"A_to_B",["aim"],"crouch",["shoot"],"angry","pain_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_B_to_A",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3E96,"B_to_A",["aim"],"crouch",["shoot"],"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_reload",::lib_0C5E::func_4742,undefined,undefined,::lib_0C5E::func_116F2,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_look",::lib_0C5E::func_CF02,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch_look_to_hide",undefined,::func_11D00,undefined);
	lib_0A1A::func_2374("cover_left_crouch_hide_to_look",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch_look",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_look_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_stand_to_crouch",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_stance_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_peek",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,"cover_peek",undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_peek",::lib_0C5E::func_CEFC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,"cover_peek",undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"pain","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_left_crouch_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"pain","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0C6A::func_11810,undefined);
	lib_0A1A::func_2374("cover_left_blindfire",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_blindfire",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current",undefined,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_hide_to_lean",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_lean",["notetrackAim"],undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_lean",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_lean",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],undefined,["corner_cover_lean_shoot"],"aim","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_lean_to_hide",undefined,::lib_0A1B::func_2943,"lean");
	lib_0A1A::func_2374("cover_left_lean_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_hide_to_lean",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,"hide_to_lean",["notetrackAim"],"crouch",undefined,"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch_lean",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_lean",::lib_0C5E::func_D46B,undefined,undefined,::lib_0C5E::func_41A2,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"crouch",["corner_cover_lean_shoot"],"aim","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch_lean_to_hide",undefined,::lib_0A1B::func_2943,"lean");
	lib_0A1A::func_2374("cover_left_crouch_lean_to_hide",::lib_0C5E::func_CEFC,undefined,undefined,::lib_0C5E::func_41A2,"cover_trans",::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"idle","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_exposed_drop_rpg_B",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_exposed_B",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_exposed_drop_rpg_A",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch_exposed_A",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_exposed_drop_rpg_A",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_exposed_drop_rpg_B",::lib_0C5E::func_CEFD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_to_exposed_idle",::lib_0C5E::func_D559,undefined,undefined,undefined,undefined,::lib_0C5E::func_3F06,undefined,["notetrackAim"],"stand",undefined,"angry","pain_cover_left_stand",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_to_exposed_crouch",::lib_0C5E::func_D559,undefined,undefined,undefined,undefined,::lib_0C5E::func_3F06,undefined,["notetrackAim"],"crouch",undefined,"angry","pain_cover_left_crouch",undefined,"death_cover","cover_left",undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("trans_to_cover_left",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle","pain_cover_left_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("trans_to_cover_left_crouch",::lib_0C5E::func_D558,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_infantry_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,"angry","pain_cover_left_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_stand_infantry_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_takingfire_reaction",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_stand_takingfire_reaction",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_stand_order_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,"angry","pain_cover_left_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_to_exposed_idle",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_crouch_order_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,undefined,undefined,undefined,"angry","pain_cover_left_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_cover_left_crouch_moverequested",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_exposed_crouch",undefined,::lib_0F43::func_9EB9,undefined);
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_cover_left_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_left_to_cover_right_door_shuffle",undefined,::lib_0A1B::func_2933,"left");
	lib_0A1A::func_2375("cover_left_hide_to_shuffle_pass",0.4,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("cqb_cover_left_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("cover_left_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_cover_left_crouch_moverequested",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_left_crouch_to_cover_right_crouch_door_shuffle",undefined,::lib_0A1B::func_2933,"left");
	lib_0A1A::func_2375("cover_left_hide_to_shuffle_pass",undefined,::lib_0A1B::func_2934,undefined);
	lib_0A1A::func_2375("cqb_cover_left_crouch_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("cover_left_crouch_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("trans_exposed_crouch_to_cover_left",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle","pain_cover_left_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_left",0.1,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_cover_left_not_in_cover",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2374("cqb_idle",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"stand",["shoot"],"idle","pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("cqb_exposed_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("grenade_avoid",undefined,::func_11FD2,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::func_11FCC,undefined);
	lib_0A1A::func_2375("grenade_return_throw",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("exposed_stand_turn",undefined,::lib_0C68::func_BEA0,undefined);
	lib_0A1A::func_2375("pass_exposed_stand_idle_to_cover",undefined,::lib_0F43::func_1007E,undefined);
	lib_0A1A::func_2375("cqb_reload",undefined,::trans_cqb_idle_to_cqb_reload7,undefined);
	lib_0A1A::func_2375("cqb_to_nonCombat_cqb_idle",undefined,::trans_cqb_idle_to_cqb_to_noncombat_cqb_idle8,undefined);
	lib_0A1A::func_2374("cqb_reload",::lib_0F43::func_260,undefined,undefined,::lib_0C68::func_DF4F,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"idle","pain_stand",undefined,"death_standing",undefined,undefined,undefined,"reload",undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cqb_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("NonCombat_CQB_Idle",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3ECD,"idle",["gesture"],undefined,["gesture"],"idle","pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("nonCombat_cqb_to_nonCombat_idle",undefined,::func_122CB,undefined);
	lib_0A1A::func_2375("NonCombat_cqb_Idle_to_cqb_idle",undefined,::func_122CA,undefined);
	lib_0A1A::func_2375("cqb_exposed_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("pass_exposed_stand_idle_to_cover",undefined,::lib_0F43::func_1007E,undefined);
	lib_0A1A::func_2374("NonCombat_cqb_Idle_to_cqb_idle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cqb_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cqb_to_nonCombat_cqb_idle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("NonCombat_CQB_Idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("nonCombat_cqb_to_nonCombat_idle",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("nonCombat_idle_to_nonCombat_cqb",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("NonCombat_CQB_Idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cqb_cover_right_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Right",["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cqb_cover_right_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_cqb_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cqb_exposed_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Exposed",["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cqb_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cqb_exposed_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_cqb_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cqb_stand_loop",::lib_0F3D::func_D4DD,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3ECD,"cqb",["aim","gesture"],"stand",["shoot","gesture"],"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face enemy or motion","normal",undefined);
	lib_0A1A::func_2375("pass_stairs_cqb",undefined,::lib_0C65::func_9EC3,undefined);
	lib_0A1A::func_2375("cqb_turn",undefined,::lib_0C65::func_FFF8,["cqb_turn",1]);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("cqb_idle",undefined,::lib_0A1B::func_2958,undefined);
	lib_0A1A::func_2375("grenade_return_throw",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("pass_change_move_type",undefined,::scripts\asm\shared_utility::func_BD26,"cqb");
	lib_0A1A::func_2375("pass_cqb_should_arrive",undefined,::lib_0C5D::func_FFD4,undefined);
	lib_0A1A::func_2375("stairs_cqb_up_arrival",undefined,::lib_0C65::func_10005,"up");
	lib_0A1A::func_2375("stairs_cqb_down_arrival",undefined,::lib_0C65::func_10005,"down");
	lib_0A1A::func_2375("cqb_move_reload",undefined,::lib_0C65::func_10068,undefined);
	lib_0A1A::func_2375("exposed_stand_to_prone",undefined,::lib_0A1B::func_2949,"prone");
	lib_0A1A::func_2375("exposed_stand_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("cqb_stand_strafe_loop",undefined,::lib_0F3D::func_100A3,undefined);
	lib_0A1A::func_2374("cqb_cover_left_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Left",["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cqb_cover_left_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_cqb_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cqb_cover_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_cqb_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cqb_cover_stand_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_cqb_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cqb_cover_stand_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Stand",["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cqb_stand_strafe_loop",::lib_0C65::func_D4E6,undefined,undefined,undefined,undefined,::lib_0C65::func_3F03,undefined,["aim"],"stand",["shoot"],undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0F3D::func_6A7B,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::func_11FEC,undefined);
	lib_0A1A::func_2374("cqb_cover_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Crouch",["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cqb_cover_right_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_cqb_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cqb_cover_left_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_cqb_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cqb_cover_left_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Left Crouch",["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cqb_cover_right_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Right Crouch",["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cqb_exposed_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_cqb_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cqb_exposed_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Exposed",["gesture"],undefined,["gesture"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("pass_cqb_should_arrive",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cqb_cover_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Cover Crouch",1]);
	lib_0A1A::func_2375("cqb_cover_stand_arrival",undefined,::lib_0C5D::func_1008F,["Cover Stand",1]);
	lib_0A1A::func_2375("cqb_cover_left_arrival",undefined,::lib_0C5D::func_1008F,["Cover Left",1]);
	lib_0A1A::func_2375("cqb_cover_right_arrival",undefined,::lib_0C5D::func_1008F,["Cover Right",1]);
	lib_0A1A::func_2375("cqb_cover_left_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Cover Left Crouch",1]);
	lib_0A1A::func_2375("cqb_cover_right_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Cover Right Crouch",1]);
	lib_0A1A::func_2375("cqb_exposed_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Exposed Crouch",1]);
	lib_0A1A::func_2375("cqb_exposed_arrival",undefined,::lib_0C5D::func_1008F,["Exposed",1]);
	lib_0A1A::func_2374("cqb_move_reload",::lib_0C65::func_D506,undefined,undefined,::lib_0C65::func_116FE,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_run",undefined,"death_moving",undefined,undefined,undefined,"reload","face enemy or motion","normal",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("cqb_turn",undefined,::lib_0C65::func_FFF8,["cqb_turn",1]);
	lib_0A1A::func_2374("stairs_cqb_up_arrival",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_cqb_up_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("stairs_cqb_up_exit",undefined,::lib_0C65::func_10030,"up");
	lib_0A1A::func_2374("stairs_cqb_up_exit",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_cqb_up_loop",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA6,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_cqb_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2375("stairs_cqb_up_exit",undefined,::lib_0C65::func_1000E,"up");
	lib_0A1A::func_2374("stairs_cqb_down_loop",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA6,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_cqb_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2375("stairs_cqb_down_exit",undefined,::lib_0C65::func_1000E,"down");
	lib_0A1A::func_2374("pass_stairs_cqb",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stairs_cqb_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2375("stairs_cqb_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2374("stairs_cqb_down_exit",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_cqb_down_arrival",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_cqb_down_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("stairs_cqb_down_exit",undefined,::lib_0C65::func_10030,"down");
	lib_0A1A::func_2374("cqb_turn",::lib_0C65::func_D514,undefined,undefined,undefined,undefined,::lib_0C65::func_3EF5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pass_cqb_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("pass_cqb_cover_exit_code_move",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_stairs_cqb",undefined,::lib_0C65::func_9EC3,undefined);
	lib_0A1A::func_2375("pass_cqb_should_arrive",undefined,::lib_0C5D::func_FFD4,undefined);
	lib_0A1A::func_2375("stairs_cqb_down_arrival",undefined,::lib_0C65::func_10005,"down");
	lib_0A1A::func_2375("stairs_cqb_up_arrival",undefined,::lib_0C65::func_10005,"up");
	lib_0A1A::func_2375("cqb_turn",undefined,::lib_0C65::func_FFF8,["cqb_turn",1]);
	lib_0A1A::func_2374("cover_crouch_lmg_deploy",::lib_0C62::func_CEAF,undefined,undefined,::lib_0C62::func_116E7,undefined,::lib_0C62::func_3E9E,"default",["notetrackAim"],undefined,undefined,undefined,"pain_lmg_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cover_crouch_lmg",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_lmg",::lib_0C62::func_CF03,undefined,undefined,::lib_0C62::func_4725,undefined,::lib_0F3D::func_3E96,"aim_5",["aim"],undefined,["shoot"],undefined,"pain_lmg_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_lmg_to_pistol_exposed",undefined,::lib_0C68::func_100A9,undefined);
	lib_0A1A::func_2375("cover_crouch_lmg_dismount",undefined,::lib_0C62::func_FFE4,undefined);
	lib_0A1A::func_2375("cover_crouch_lmg_reload",undefined,::func_11C66,undefined);
	lib_0A1A::func_2374("cover_stand_lmg",::lib_0C62::func_CF03,undefined,undefined,::lib_0C62::func_4725,undefined,::lib_0F3D::func_3E96,"aim_5",["aim"],undefined,["shoot"],undefined,"pain_lmg_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_stand_lmg_to_pistol_exposed",undefined,::lib_0C68::func_100A9,undefined);
	lib_0A1A::func_2375("cover_stand_lmg_dismount",undefined,::lib_0C62::func_FFE4,undefined);
	lib_0A1A::func_2375("cover_stand_lmg_reload",undefined,::func_11F69,undefined);
	lib_0A1A::func_2374("cover_stand_lmg_dismount",::lib_0C62::func_CEB1,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_lmg_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_lmg_dismount_passthrough",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_lmg_dismount_passthrough",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_stand_lmg_dismount_passthrough",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_idle",undefined,::func_11F65,undefined);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("cover_stand_high_lmg_deploy_pass",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_stand_lmg_deploy",::lib_0C62::func_CEAF,undefined,undefined,::lib_0C62::func_116E7,undefined,::lib_0C62::func_3E9E,"default",["notetrackAim"],undefined,undefined,undefined,"pain_lmg_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,"zonly_physics",undefined);
	lib_0A1A::func_2375("cover_stand_lmg",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_lmg_to_pistol_exposed",::lib_0C62::func_CEB3,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_lmg_to_pistol_exposed",::lib_0C62::func_CEB3,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_lmg_reload",::lib_0F43::func_260,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_crouch",undefined,"death_generic",undefined,undefined,undefined,"reload",undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_lmg",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_lmg_reload",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_generic",undefined,undefined,undefined,"reload",undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_lmg",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_lmg_dismount",::lib_0C62::func_CEB1,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_lmg_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_lmg_dismount_passthrough",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_turret",::lib_0C62::func_CF03,undefined,undefined,::lib_0C62::func_4756,undefined,::lib_0F3D::func_3E96,"aim_5",["aim"],undefined,["shoot"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_turret_dismount",undefined,::lib_0C62::func_FFE4,undefined);
	lib_0A1A::func_2374("cover_stand_turret",::lib_0C62::func_CF03,undefined,undefined,::lib_0C62::func_4756,undefined,::lib_0F3D::func_3E96,"aim_5",["aim"],undefined,["shoot"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_stand_turret_dismount",undefined,::lib_0C62::func_FFE4,undefined);
	lib_0A1A::func_2374("cover_crouch_turret_deploy",::lib_0C62::func_CEB0,undefined,undefined,::lib_0C62::func_116E7,undefined,::lib_0F3D::func_3E96,"default",["notetrackAim"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_turret",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_turret_dismount",::lib_0C62::func_CEB2,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_lmg_dismount_passthrough",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_turret_deploy",::lib_0C62::func_CEB0,undefined,undefined,::lib_0C62::func_116E7,undefined,::lib_0F3D::func_3E96,"default",["notetrackAim"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_turret",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_turret_dismount",::lib_0C62::func_CEB2,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_lmg_dismount_passthrough",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_prone_lmg_deploy",::lib_0C62::func_CEAF,undefined,undefined,::lib_0C62::func_116E7,undefined,::lib_0C62::func_3E9E,"default",["notetrackAim"],undefined,undefined,undefined,"pain_lmg_prone",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_prone_lmg",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_prone_lmg",::lib_0C62::func_CF03,undefined,undefined,::lib_0C62::func_4725,undefined,::lib_0F3D::func_3E96,"aim_5",["aim"],undefined,["shoot"],undefined,"pain_lmg_prone",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_prone_lmg_to_pistol_exposed",undefined,::lib_0C68::func_100A9,undefined);
	lib_0A1A::func_2375("cover_prone_lmg_dismount",undefined,::lib_0C62::func_FFE4,undefined);
	lib_0A1A::func_2375("cover_prone_lmg_reload",undefined,::func_11DFE,undefined);
	lib_0A1A::func_2374("cover_prone_lmg_dismount_passthrough",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_exit",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_prone_lmg_to_pistol_exposed",::lib_0C62::func_CEB3,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("cover_prone_lmg_reload",::lib_0F43::func_260,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_lmg_prone",undefined,"death_generic",undefined,undefined,undefined,"reload",undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_prone_lmg",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_prone_lmg_dismount",::lib_0C62::func_CEB1,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_lmg_prone",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_prone_lmg_dismount_passthrough",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_prone_turret",::lib_0C62::func_CF03,undefined,undefined,::lib_0C62::func_4756,undefined,::lib_0F3D::func_3E96,"aim_5",["aim"],undefined,["shoot"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_prone_turret_dismount",undefined,::lib_0C62::func_FFE4,undefined);
	lib_0A1A::func_2374("cover_prone_turret_deploy",::lib_0C62::func_CEB0,undefined,undefined,::lib_0C62::func_116E7,undefined,::lib_0F3D::func_3E96,"default",["notetrackAim"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_prone_turret",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_prone_turret_dismount",::lib_0C62::func_CEB2,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_prone_lmg_dismount_passthrough",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_high_lmg_deploy_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_stand_high_lmg_deploy",undefined,::lib_0C62::func_B0E9,"high");
	lib_0A1A::func_2375("cover_stand_lmg_deploy",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_stand_high_lmg",::lib_0C62::func_CF03,undefined,undefined,::lib_0C62::func_4725,undefined,::lib_0F3D::func_3E96,"aim_5",["aim"],undefined,["shoot"],undefined,"pain_lmg_stand_high",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_stand_high_lmg_to_pistol_exposed",undefined,::lib_0C68::func_100A9,undefined);
	lib_0A1A::func_2375("cover_stand_high_lmg_dismount",undefined,::lib_0C62::func_FFE4,undefined);
	lib_0A1A::func_2375("cover_stand_high_lmg_reload",undefined,::func_11F64,undefined);
	lib_0A1A::func_2374("cover_stand_high_lmg_dismount",::lib_0C62::func_CEB1,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_lmg_stand_high",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_lmg_dismount_passthrough",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_high_lmg_deploy",::lib_0C62::func_CEAF,undefined,undefined,::lib_0C62::func_116E7,undefined,::lib_0C62::func_3E9E,"default",["notetrackAim"],"prone",undefined,undefined,"pain_lmg_stand_high",undefined,"death_generic",undefined,undefined,undefined,undefined,"face node","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_stand_high_lmg",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_high_lmg_to_pistol_exposed",::lib_0C62::func_CEB3,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("cover_stand_high_lmg_reload",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_cover_stand",undefined,"death_generic",undefined,undefined,undefined,"reload",undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_high_lmg",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_lmg_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_prone_lmg_deploy",undefined,::func_11C64,undefined);
	lib_0A1A::func_2375("cover_crouch_lmg_deploy",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_stand_high_turret_dismount",::lib_0C62::func_CEB2,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_lmg_dismount_passthrough",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_high_turret",::lib_0C62::func_CF03,undefined,undefined,::lib_0C62::func_4756,undefined,::lib_0F3D::func_3E96,"aim_5",["aim"],undefined,["shoot"],undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("cover_stand_high_turret_dismount",undefined,::lib_0C62::func_FFE4,undefined);
	lib_0A1A::func_2374("cover_stand_high_turret_deploy",::lib_0C62::func_CEB0,undefined,undefined,::lib_0C62::func_116E7,undefined,::lib_0F3D::func_3E96,"default",["notetrackAim"],undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_stand_high_turret",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_turret_deploy_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_stand_high_turret_deploy",undefined,::lib_0C62::func_B0E9,"high");
	lib_0A1A::func_2375("cover_stand_turret_deploy",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("script_use_turret",::lib_0C62::func_C021,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("cover_crouch_turret",undefined,::lib_0C62::func_527F,"crouch");
	lib_0A1A::func_2375("cover_prone_turret",undefined,::lib_0C62::func_527F,"prone");
	lib_0A1A::func_2375("cover_stand_high_turret",undefined,::lib_0C62::func_527F,"exposed");
	lib_0A1A::func_2375("cover_stand_turret",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_right_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Right",["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_right",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_to_exposed_idle",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_run_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("exposed_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Exposed",["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,[undefined,1],["gesture"],undefined,["gesture"],"run","pain_stand",undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("pass_run_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2374("stand_run_loop",::lib_0F3D::func_D4E2,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3ECE,"move",["gesture"],"stand",["gesture"],"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face enemy or motion","normal",undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0C65::func_FFF8,["run_turn",1]);
	lib_0A1A::func_2375("running_whizby",undefined,::func_12574,undefined);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("grenade_return_throw",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("grenade_avoid",undefined,::func_1256D,undefined);
	lib_0A1A::func_2375("traversal_transition",undefined,::lib_0C6B::func_FAF0,undefined);
	lib_0A1A::func_2375("pass_change_move_type",undefined,::scripts\asm\shared_utility::func_BD28,undefined);
	lib_0A1A::func_2375("pass_exposed_stand_idle_to_cover",undefined,::lib_0F43::func_1007E,undefined);
	lib_0A1A::func_2375("exposed_stand_to_prone",undefined,::lib_0A1B::func_2949,"prone");
	lib_0A1A::func_2375("stand_run_strafe_loop",undefined,::lib_0F3D::func_100A3,undefined);
	lib_0A1A::func_2375("move_crouch_loop",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1B::func_2958,undefined);
	lib_0A1A::func_2375("pass_run_should_arrive",undefined,::lib_0C5D::func_FFD4,undefined);
	lib_0A1A::func_2375("pass_stairs",undefined,::lib_0C65::func_9EC3,undefined);
	lib_0A1A::func_2375("sprint_loop",undefined,::scripts\asm\shared_utility::func_BD25,"sprint");
	lib_0A1A::func_2375("stairs_run_up_arrival",undefined,::lib_0C65::func_10005,"up");
	lib_0A1A::func_2375("pass_run_n_gun",undefined,::lib_0C65::func_1006E,undefined);
	lib_0A1A::func_2375("stairs_run_down_arrival",undefined,::lib_0C65::func_10005,"down");
	lib_0A1A::func_2375("stand_run_reload",undefined,::lib_0C65::func_10068,undefined);
	lib_0A1A::func_2374("run_turn",::lib_0C65::func_D514,undefined,undefined,undefined,undefined,::lib_0C65::func_3EF5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("pass_run_turn_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_left_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Left",["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_left",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_left_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_to_exposed_idle",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_run_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_crouch_to_exposed_idle",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_run_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Crouch",["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_stand_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_stand_to_exposed_idle",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_run_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_stand_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Stand",["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_stand",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stand_run_strafe_loop",::lib_0C65::func_D4E6,undefined,undefined,undefined,undefined,::lib_0C65::func_3F03,undefined,["aim"],"stand",["shoot"],"run","pain_stand",undefined,"death_moving",undefined,undefined,undefined,undefined,"face enemy or motion","normal",undefined);
	lib_0A1A::func_2375("grenade_return_throw",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("pass_exposed_stand_idle_to_cover",undefined,::lib_0F43::func_1007E,undefined);
	lib_0A1A::func_2375("grenade_avoid",undefined,::trans_stand_run_strafe_loop_to_grenade_avoid2,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0F3D::func_6A7B,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1B::func_2958,undefined);
	lib_0A1A::func_2375("pass_change_move_type",undefined,::scripts\asm\shared_utility::func_BD28,undefined);
	lib_0A1A::func_2375("exposed_stand_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("exposed_stand_to_prone",undefined,::lib_0A1B::func_2949,"prone");
	lib_0A1A::func_2374("stand_run_n_gun_loop",::lib_0C65::func_D50D,undefined,undefined,::lib_0C65::func_11088,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,["shoot"],"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("grenade_return_throw",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("pass_stop_run_n_gun",undefined,::lib_0C65::func_1009F,undefined);
	lib_0A1A::func_2375("stand_run_n_gun_backwards_loop",undefined,::lib_0C65::func_1006F,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0C65::func_FFF8,["run_turn",1]);
	lib_0A1A::func_2374("stand_run_n_gun_backwards_loop",::lib_0C65::func_D50E,undefined,undefined,::lib_0C65::func_11088,undefined,::lib_0F3D::func_3E96,"move_back",undefined,undefined,["shoot"],"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pass_stop_run_n_gun",undefined,::lib_0C65::func_1009E,undefined);
	lib_0A1A::func_2375("stand_run_n_gun_loop",undefined,::lib_0C65::func_10070,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0C65::func_FFF8,["run_turn",1]);
	lib_0A1A::func_2374("cover_left_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_left_crouch_to_exposed_crouch",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_run_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_right_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,undefined,["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("cover_right_crouch_to_exposed_crouch",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_run_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("cover_left_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Left Crouch",["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_left_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_right_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Right Crouch",["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_right_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Exposed Crouch",["gesture"],undefined,["gesture"],"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_exit",::lib_0C65::func_CEB5,1,undefined,undefined,undefined,::lib_0C65::func_3E9F,[undefined,1],["gesture"],undefined,["gesture"],"run","pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("stand_run_loop_pass",undefined,::lib_0A1A::func_68B0,"finish");
	lib_0A1A::func_2375("pass_run_cover_exit_code_move",undefined,::lib_0A1A::func_68B0,"code_move");
	lib_0A1A::func_2374("sprint_loop",::lib_0F3D::func_D4DD,undefined,undefined,undefined,undefined,::lib_0C65::func_3EFF,undefined,["gesture"],undefined,["gesture"],"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::scripts\asm\shared_utility::func_BD26,"sprint");
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0F43::func_1007E,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_C17F,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0C65::func_FFF8,["run_turn",1]);
	lib_0A1A::func_2375("pass_run_should_arrive",undefined,::lib_0C5D::func_FFD4,undefined);
	lib_0A1A::func_2375("stairs_run_up_arrival",undefined,::lib_0C65::func_10005,"up");
	lib_0A1A::func_2375("stairs_run_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2375("stairs_run_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2375("stairs_run_down_arrival",undefined,::lib_0C65::func_10005,"down");
	lib_0A1A::func_2375("grenade_return_throw",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2374("running_whizby",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1B::func_2958,undefined);
	lib_0A1A::func_2374("pass_run_should_arrive",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_crouch_lmg_arrival",undefined,::lib_0C5D::func_1008F,["Cover Crouch LMG",1]);
	lib_0A1A::func_2375("custom_arrival",undefined,::lib_0C5D::func_1008F,["Custom",1]);
	lib_0A1A::func_2375("cover_stand_lmg_arrival",undefined,::lib_0C5D::func_1008F,["Cover Stand LMG",1]);
	lib_0A1A::func_2375("cover_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Cover Crouch",1]);
	lib_0A1A::func_2375("cover_stand_arrival",undefined,::lib_0C5D::func_1008F,["Cover Stand",1]);
	lib_0A1A::func_2375("cover_left_arrival",undefined,::lib_0C5D::func_1008F,["Cover Left",1]);
	lib_0A1A::func_2375("cover_right_arrival",undefined,::lib_0C5D::func_1008F,["Cover Right",1]);
	lib_0A1A::func_2375("cover_left_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Cover Left Crouch",1]);
	lib_0A1A::func_2375("cover_right_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Cover Right Crouch",1]);
	lib_0A1A::func_2375("exposed_arrival",undefined,::lib_0C5D::func_1008F,["Exposed",1]);
	lib_0A1A::func_2375("exposed_crouch_arrival",undefined,::lib_0C5D::func_1008F,["Exposed Crouch",1]);
	lib_0A1A::func_2374("stand_run_reload",::lib_0C65::func_D506,undefined,undefined,::lib_0C65::func_116FE,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,"reload","face motion","normal",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("run_turn",undefined,::lib_0C65::func_FFF8,["run_turn",1]);
	lib_0A1A::func_2374("stairs_run_up_arrival",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_run_up_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("stairs_run_up_exit",undefined,::lib_0C65::func_10030,"up");
	lib_0A1A::func_2374("stairs_run_up_exit",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_run_up_loop",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA6,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2375("stairs_run_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2375("pass_run_n_gun",undefined,::lib_0C65::func_1006E,undefined);
	lib_0A1A::func_2375("stairs_run_up_exit",undefined,::lib_0C65::func_10030,"up");
	lib_0A1A::func_2374("stairs_run_down_loop",::lib_0F3D::func_B050,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA6,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0C65::func_9EC9,"none");
	lib_0A1A::func_2375("stairs_run_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2375("pass_run_n_gun",undefined,::lib_0C65::func_1006E,undefined);
	lib_0A1A::func_2375("stairs_run_down_exit",undefined,::lib_0C65::func_1000E,"down");
	lib_0A1A::func_2374("move_crouch_loop",::lib_0F3D::func_D4DD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"crouch",undefined,"idle","pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1B::func_2958,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2375("exposed_crouch_to_prone",undefined,::lib_0A1B::func_2949,"prone");
	lib_0A1A::func_2374("move_prone_loop",::lib_0F3D::func_D4DD,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,"prone",undefined,"idle","pain_prone",undefined,"death_prone",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("exposed_prone",0.5,::lib_0A1B::func_2958,undefined);
	lib_0A1A::func_2375("exposed_prone_to_crouch",0.5,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("exposed_prone_to_stand",0.5,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2374("cover_stand_lmg_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Stand LMG",undefined,undefined,undefined,"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_stand_high_lmg_deploy_pass",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("cover_crouch_lmg_arrival",::lib_0C5D::func_CEAA,undefined,undefined,undefined,undefined,::lib_0C5D::func_3E97,"Cover Crouch LMG",undefined,undefined,undefined,"run",undefined,undefined,"death_moving",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"abort");
	lib_0A1A::func_2375("cover_crouch_lmg_arrival_pass",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_exit_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cqb_exposed_exit",undefined,::scripts\asm\shared_utility::func_BD25,"cqb");
	lib_0A1A::func_2375("exposed_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("cover_crouch_lmg_arrival_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_prone_lmg_deploy",undefined,::func_11C60,undefined);
	lib_0A1A::func_2375("cover_crouch_lmg_deploy",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_run_n_gun",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stand_run_n_gun_backwards_loop",undefined,::lib_0C65::func_1006F,undefined);
	lib_0A1A::func_2375("stand_run_n_gun_loop",undefined,::lib_0C65::func_10070,undefined);
	lib_0A1A::func_2374("pass_stairs",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stairs_run_down_loop",undefined,::lib_0C65::func_9EC9,"down");
	lib_0A1A::func_2375("stairs_run_up_loop",undefined,::lib_0C65::func_9EC9,"up");
	lib_0A1A::func_2374("stairs_run_down_exit",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("stairs_run_down_arrival",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0C65::func_3EA5,undefined,undefined,undefined,undefined,"run","pain_run",undefined,"death_moving",undefined,undefined,undefined,undefined,"face motion","normal",undefined);
	lib_0A1A::func_2375("stairs_run_down_loop",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("stairs_run_down_exit",undefined,::lib_0C65::func_10030,"down");
	lib_0A1A::func_2374("pass_run_cover_exit_code_move",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1B::func_2958,undefined);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("stand_run_strafe_loop",undefined,::lib_0F3D::func_100A3,undefined);
	lib_0A1A::func_2375("pass_stairs",undefined,::lib_0C65::func_9EC3,undefined);
	lib_0A1A::func_2375("run_turn",undefined,::lib_0C65::func_FFF8,["run_turn",1]);
	lib_0A1A::func_2375("stairs_run_up_arrival",undefined,::lib_0C65::func_10005,"up");
	lib_0A1A::func_2375("stairs_run_down_arrival",undefined,::lib_0C65::func_10005,"down");
	lib_0A1A::func_2375("pass_run_should_arrive",undefined,::lib_0C5D::func_FFD4,undefined);
	lib_0A1A::func_2374("stand_run_loop_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stand_run_loop",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("exposed_crouch_exit_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_crouch_exit",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_stop_run_n_gun",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_stairs",undefined,::lib_0C65::func_9EC3,undefined);
	lib_0A1A::func_2375("stand_run_loop",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_run_turn_code_move",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_stairs",undefined,::lib_0C65::func_9EC3,undefined);
	lib_0A1A::func_2375("stairs_run_down_arrival",undefined,::lib_0C65::func_10005,"down");
	lib_0A1A::func_2375("stairs_run_up_arrival",undefined,::lib_0C65::func_10005,"up");
	lib_0A1A::func_2375("pass_run_should_arrive",undefined,::lib_0C5D::func_FFD4,undefined);
	lib_0A1A::func_2375("stand_run_strafe_loop",undefined,::lib_0F3D::func_100A3,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1B::func_2958,undefined);
	lib_0A1A::func_2374("Exposed_Reload",::lib_0F43::func_260,undefined,undefined,::lib_0C68::func_DF4F,undefined,::lib_0F3D::func_3EA1,undefined,["notetrackAim"],undefined,["shoot"],"angry","pain_stand",undefined,"death_standing",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_throw_grenade",::lib_0C6A::func_CEFE,undefined,undefined,::lib_0C6A::func_CEFF,undefined,::lib_0C6A::func_3EA8,undefined,undefined,undefined,undefined,"angry","pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("Exposed_WeaponSwitch",::lib_0F43::func_CECB,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3EAC,undefined,["notetrackAim"],undefined,undefined,"angry",undefined,undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","angle deltas",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_stand_turn",::lib_0F43::func_D56A,undefined,undefined,::lib_0F43::func_D56B,undefined,::lib_0C68::func_3F0A,undefined,["notetrackAim"],undefined,["shoot"],"angry","pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_stand_turn_pass",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_stand_turn_pass",undefined,::lib_0A1A::func_68B0,"finish early");
	lib_0A1A::func_2374("exposed_idle",::lib_0F43::func_D46D,undefined,undefined,undefined,undefined,::lib_0F3D::func_3EB3,"_aim_5",["aim","gesture"],"stand",["shoot","gesture"],"angry","pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("Exposed_WeaponSwitch",undefined,::lib_0C68::func_100A9,undefined);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("grenade_avoid",undefined,::func_12138,undefined);
	lib_0A1A::func_2375("cqb_idle",undefined,::scripts\asm\shared_utility::func_BD25,"cqb");
	lib_0A1A::func_2375("patrol_idle",undefined,::scripts\asm\shared_utility::func_BD25,"patrol");
	lib_0A1A::func_2375("grenade_return_throw",undefined,::lib_0A1B::func_293D,undefined);
	lib_0A1A::func_2375("cqb_to_nonCombat_cqb_idle",undefined,::func_120FC,undefined);
	lib_0A1A::func_2375("exposed_throw_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2375("exposed_throw_seeker",undefined,::func_12137,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1A::func_6A18,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("Exposed_Reload",undefined,::func_12116,undefined);
	lib_0A1A::func_2375("exposed_stand_to_noncombat_stand_idle",undefined,::scripts\asm\shared_utility::func_BD25,"casual_gun");
	lib_0A1A::func_2375("exposed_stand_to_noncombat_stand_idle",undefined,::scripts\asm\shared_utility::func_BD25,"casual");
	lib_0A1A::func_2375("pass_exposed_stand_idle_to_cover",undefined,::lib_0F43::func_1007E,undefined);
	lib_0A1A::func_2375("exposed_stand_to_prone",undefined,::lib_0A1B::func_2949,"prone");
	lib_0A1A::func_2375("exposed_stand_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("exposed_stand_turn",undefined,::lib_0C68::func_BEA0,undefined);
	lib_0A1A::func_2375("exposed_stand_infantry_reaction",undefined,::lib_0C4C::func_3DF2,"threat_infantry");
	lib_0A1A::func_2374("exposed_stand_to_prone",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_prone",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_prone",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_prone",::lib_0F43::func_D46D,undefined,undefined,undefined,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim"],"prone",["shoot"],"aim","pain_prone",undefined,"death_prone",undefined,undefined,undefined,undefined,"face node",undefined,undefined);
	lib_0A1A::func_2375("move_prone_loop",0.5,::lib_0A1A::func_BCE8,"prone");
	lib_0A1A::func_2375("exposed_prone_to_stand",undefined,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2375("exposed_prone_to_stand",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_prone_to_crouch",undefined,::lib_0A1B::func_2949,"crouch");
	lib_0A1A::func_2375("exposed_prone_reload",undefined,::func_1214C,undefined);
	lib_0A1A::func_2375("exposed_prone_throw_grenade",undefined,::lib_0C6A::func_100AD,undefined);
	lib_0A1A::func_2374("exposed_prone_to_stand",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_stand_to_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_crouch",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch",::lib_0F43::func_D46C,undefined,undefined,::lib_0F43::func_116F5,undefined,::lib_0F3D::func_3EAB,"_aim_5",["aim","gesture"],"crouch",["shoot"],"angry","pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_crouch_to_prone",undefined,::lib_0A1B::func_2949,"prone");
	lib_0A1A::func_2375("exposed_crouch_drop_rpg",undefined,::lib_0A1B::func_2986,undefined);
	lib_0A1A::func_2375("melee_attacker_passthrough",undefined,::lib_0A1B::func_2953,undefined);
	lib_0A1A::func_2375("move_crouch_loop",undefined,::lib_0A1A::func_BCE8,"crouch");
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1A::func_6A18,"combat");
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1A::func_6A18,"frantic");
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1A::func_6A18,"sprint");
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2375("cqb_exposed_crouch_exit",undefined,::lib_0A1A::func_BCE7,"cqb");
	lib_0A1A::func_2375("exposed_crouch_to_stand",undefined,::lib_0A1B::func_2949,"stand");
	lib_0A1A::func_2375("exposed_crouch_to_stand",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("pass_exposed_crouch_idle_to_cover",undefined,::lib_0F43::func_1007E,undefined);
	lib_0A1A::func_2375("exposed_crouch_reload",undefined,::func_120E3,undefined);
	lib_0A1A::func_2375("exposed_crouch_turn",undefined,::lib_0C68::func_BEA0,undefined);
	lib_0A1A::func_2375("exposed_crouch_infantry_reaction",undefined,::lib_0C4C::func_3DF2,"threat_infantry");
	lib_0A1A::func_2374("exposed_crouch_to_stand",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_stand",undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_prone_to_crouch",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",0.1,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_to_prone",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_prone",undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_prone",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_idle_react",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_stand",undefined,"death_standing",undefined,undefined,undefined,undefined,"face current","gravity",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_reload",::lib_0F43::func_260,undefined,undefined,::lib_0C68::func_DF4F,undefined,::scripts\asm\shared_utility::func_3EAA,undefined,["notetrackAim"],undefined,["shoot"],"angry","pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,"reload","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("scripted_to_exposed",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1B::func_9DA4,"stand");
	lib_0A1A::func_2375("exposed_prone",undefined,::lib_0A1B::func_9DA4,"prone");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2374("pass_exposed_stand_idle_to_cover",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("cover_stand_high_lmg_deploy_pass",undefined,::lib_0F43::func_4C03,"Cover Stand LMG");
	lib_0A1A::func_2375("cover_prone_lmg_deploy",undefined,::lib_0F43::func_4C03,"Cover Prone LMG");
	lib_0A1A::func_2375("cover_crouch_lmg_pass",undefined,::lib_0F43::func_4C03,"Cover Crouch LMG");
	lib_0A1A::func_2375("exposed_stand_to_crouch",undefined,::lib_0F43::func_4C03,"Exposed Crouch");
	lib_0A1A::func_2375("exposed_stand_to_crouch",undefined,::lib_0F43::func_4C03,"Cover Crouch");
	lib_0A1A::func_2375("exposed_stand_to_prone",undefined,::lib_0F43::func_4C03,"Cover Prone");
	lib_0A1A::func_2375("trans_to_cover_stand",undefined,::lib_0F43::func_4C03,"Cover Stand");
	lib_0A1A::func_2375("trans_to_cover_right",undefined,::lib_0F43::func_4C03,"Cover Right");
	lib_0A1A::func_2375("trans_to_cover_left",undefined,::lib_0F43::func_4C03,"Cover Left");
	lib_0A1A::func_2375("trans_to_cover_crouch",undefined,::lib_0F43::func_4C03,"Cover Crouch");
	lib_0A1A::func_2375("trans_to_cover_right_crouch",undefined,::lib_0F43::func_4C03,"Cover Right Crouch");
	lib_0A1A::func_2375("trans_to_cover_left_crouch",undefined,::lib_0F43::func_4C03,"Cover Left Crouch");
	lib_0A1A::func_2374("exposed_crouch_turn",::lib_0F43::func_D56A,undefined,undefined,::lib_0F43::func_D56B,undefined,::lib_0C68::func_3ECC,undefined,["notetrackAim"],undefined,["shoot"],"angry","pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_crouch_turn_pass",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch_turn_pass",undefined,::lib_0A1A::func_68B0,"finish early");
	lib_0A1A::func_2374("exposed_prone_reload",::lib_0F43::func_260,undefined,undefined,::lib_0C68::func_DF4F,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,"angry","pain_prone",undefined,"death_prone",undefined,undefined,undefined,"reload",undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_prone",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_prone_throw_grenade",::lib_0C6A::func_CEC6,undefined,undefined,::lib_0C6A::func_CEC7,undefined,::lib_0C6A::func_3EA8,undefined,undefined,undefined,undefined,"pain","pain_prone",undefined,"death_prone",undefined,undefined,undefined,undefined,"face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_prone",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_stand_infantry_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,["notetrackAim"],undefined,undefined,"angry","pain_stand",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1A::func_BCE7,undefined);
	lib_0A1A::func_2375("exposed_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2374("exposed_crouch_infantry_reaction",::lib_0C4C::func_CEE9,undefined,undefined,undefined,undefined,::lib_0C4C::func_3EBB,undefined,["notetrackAim"],undefined,undefined,"angry","pain_crouch",undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1A::func_BCE7,"combat");
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1A::func_BCE7,"frantic");
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1A::func_BCE7,"sprint");
	lib_0A1A::func_2375("exposed_crouch_exit_pass",undefined,::lib_0A1B::func_2950,undefined);
	lib_0A1A::func_2374("exposed_stand_turn_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_exposed_stand_idle_to_cover",undefined,::lib_0F43::func_1007E,undefined);
	lib_0A1A::func_2375("cqb_idle",undefined,::scripts\asm\shared_utility::func_BD25,"cqb");
	lib_0A1A::func_2375("exposed_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pass_exposed_crouch_idle_to_cover",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("trans_to_cover_left_crouch",undefined,::lib_0F43::func_4C03,"Cover Left Crouch");
	lib_0A1A::func_2375("trans_to_cover_right_crouch",undefined,::lib_0F43::func_4C03,"Cover Right Crouch");
	lib_0A1A::func_2375("cover_crouch_lmg_pass",undefined,::lib_0F43::func_4C03,"Cover Crouch LMG");
	lib_0A1A::func_2375("trans_exposed_crouch_to_cover_stand",undefined,::lib_0F43::func_4C03,"Cover Stand");
	lib_0A1A::func_2375("trans_exposed_crouch_to_cover_left",undefined,::lib_0F43::func_4C03,"Cover Left");
	lib_0A1A::func_2375("trans_exposed_crouch_to_cover_right",undefined,::lib_0F43::func_4C03,"Cover Right");
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0F43::func_4C03,"Exposed Crouch");
	lib_0A1A::func_2375("exposed_crouch_to_prone",undefined,::lib_0F43::func_4C03,"Cover Prone");
	lib_0A1A::func_2375("exposed_crouch_to_stand",undefined,::lib_0F43::func_4C03,"Exposed");
	lib_0A1A::func_2375("trans_to_cover_crouch",undefined,::lib_0F43::func_4C03,"Cover Crouch");
	lib_0A1A::func_2374("exposed_crouch_turn_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pass_exposed_crouch_idle_to_cover",undefined,::lib_0F43::func_1007E,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("exposed_throw_seeker",::lib_0C6A::func_CEC8,undefined,undefined,undefined,undefined,::lib_0C6A::func_3EA9,undefined,undefined,undefined,undefined,"angry","pain_stand",undefined,"death_standing",undefined,undefined,undefined,"throwseeker","face current","zonly_physics",undefined);
	lib_0A1A::func_2375("exposed_idle",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("exposed_crouch_drop_rpg",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,"pain_crouch",undefined,"death_crouching",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("exposed_crouch",undefined,::lib_0A1A::func_68B0,"end");
	lib_0A1A::func_2374("Visor",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("pass_change_move_type",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("stand_run_loop",undefined,::scripts\asm\shared_utility::func_BD25,"combat");
	lib_0A1A::func_2375("stand_run_loop",undefined,::scripts\asm\shared_utility::func_BD25,"frantic");
	lib_0A1A::func_2375("stand_run_loop",undefined,::scripts\asm\shared_utility::func_BD25,"sprint");
	lib_0A1A::func_2375("patrol_move",undefined,::lib_0A1A::func_9E41,[0,"patrol"]);
	lib_0A1A::func_2375("move_walk_loop",undefined,::scripts\asm\shared_utility::func_BD25,"casual");
	lib_0A1A::func_2375("move_walk_loop",undefined,::scripts\asm\shared_utility::func_BD25,"casual_gun");
	lib_0A1A::func_2375("cqb_stand_loop",undefined,::scripts\asm\shared_utility::func_BD25,"cqb");
	lib_0A1A::func_2374("facial_animation",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2374("animscripted_to_noncombat_idle_pass",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("exposed_casual_exit",undefined,::lib_0A1A::func_BCE7,"casual");
	lib_0A1A::func_2375("exposed_casual_gun_exit",undefined,::lib_0A1A::func_BCE7,"casual_gun");
	lib_0A1A::func_2375("noncombat_stand_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
func_122ED(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_293C();
}

//Function Number: 3
func_122E8(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_294E();
}

//Function Number: 4
func_122F2(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2956("cqb");
}

//Function Number: 5
func_124F0(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 6
func_1215C(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2955();
}

//Function Number: 7
func_121AE(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_293C();
}

//Function Number: 8
func_121B1(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_293C();
}

//Function Number: 9
func_121A9(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_293C();
}

//Function Number: 10
func_12071(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_232B(param_01,"end") && self.var_1198.var_BD23 == "combat" || self.var_1198.var_BD23 == "frantic";
}

//Function Number: 11
func_12067(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_232B(param_01,"end") && self.var_1198.var_BD23 == "casual" || self.var_1198.var_BD23 == "casual_gun";
}

//Function Number: 12
func_12062(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_232B(param_01,"end") && self.var_1198.var_BD23 == "cqb";
}

//Function Number: 13
func_1205C(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_232B(param_01,"abort") && self.var_1198.var_BD23 == "combat" || self.var_1198.var_BD23 == "frantic";
}

//Function Number: 14
func_12054(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_232B(param_01,"abort") && self.var_1198.var_BD23 != "combat" && self.var_1198.var_BD23 != "frantic";
}

//Function Number: 15
func_11B5C(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2938() && isdefined(self.var_2303.var_4C86.var_697F);
}

//Function Number: 16
func_11B68(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2938() && isdefined(self.var_2303.var_4C86.var_92FA);
}

//Function Number: 17
func_122AF(param_00,param_01,param_02,param_03)
{
	return lib_0C65::func_100BD();
}

//Function Number: 18
func_122B4(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 19
func_122AE(param_00,param_01,param_02,param_03)
{
	return !lib_0C65::func_100BD();
}

//Function Number: 20
func_11F98(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 21
func_11F7D(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291A();
}

//Function Number: 22
func_11F4F(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "exposed";
}

//Function Number: 23
func_11F6E(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "look";
}

//Function Number: 24
func_12262(param_00,param_01,param_02,param_03)
{
	return !isdefined(self.var_B55B);
}

//Function Number: 25
func_1225F(param_00,param_01,param_02,param_03)
{
	return !isdefined(lib_0A1B::func_2925());
}

//Function Number: 26
func_12363(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == "stand";
}

//Function Number: 27
func_12362(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == "crouch";
}

//Function Number: 28
func_12349(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == "stand";
}

//Function Number: 29
func_12348(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == "crouch";
}

//Function Number: 30
func_123F8(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 31
func_12080(param_00,param_01,param_02,param_03)
{
	return lib_0C6B::func_8212() == "high";
}

//Function Number: 32
func_12084(param_00,param_01,param_02,param_03)
{
	return lib_0C6B::func_8212() == "low";
}

//Function Number: 33
func_1207C(param_00,param_01,param_02,param_03)
{
	return lib_0C6B::func_820E() == "left";
}

//Function Number: 34
func_12079(param_00,param_01,param_02,param_03)
{
	return lib_0C6B::func_820E() == "left";
}

//Function Number: 35
func_125D3(param_00,param_01,param_02,param_03)
{
	return self.var_126C5.var_48 == "wall_run";
}

//Function Number: 36
func_11C87(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291A();
}

//Function Number: 37
func_11CAD(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 38
func_11C0C(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "exposed";
}

//Function Number: 39
func_11F32(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 40
func_11EEA(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291A();
}

//Function Number: 41
func_11F15(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "B";
}

//Function Number: 42
func_11F07(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "A";
}

//Function Number: 43
func_11F23(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "lean";
}

//Function Number: 44
func_11EDC(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "look";
}

//Function Number: 45
func_11E89(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 46
func_11E57(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "A";
}

//Function Number: 47
func_11E65(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "B";
}

//Function Number: 48
func_11E73(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "lean";
}

//Function Number: 49
func_11E31(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "look";
}

//Function Number: 50
func_11DE5(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 51
func_11D9D(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291A();
}

//Function Number: 52
func_11DBB(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "A";
}

//Function Number: 53
func_11DC9(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "B";
}

//Function Number: 54
func_11DD7(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "lean";
}

//Function Number: 55
func_11D8E(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "look";
}

//Function Number: 56
func_11D53(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 57
func_11D26(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "A";
}

//Function Number: 58
func_11D35(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "B";
}

//Function Number: 59
func_11D44(param_00,param_01,param_02,param_03)
{
	return lib_0C5E::func_FFD9() && lib_0A1B::func_2929() == "lean";
}

//Function Number: 60
func_11D00(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292B() != "look";
}

//Function Number: 61
func_11FD2(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_293C();
}

//Function Number: 62
func_11FCC(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2956("cqb") && lib_0A1B::func_2941();
}

//Function Number: 63
trans_cqb_idle_to_cqb_reload7(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 64
trans_cqb_idle_to_cqb_to_noncombat_cqb_idle8(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2941();
}

//Function Number: 65
func_122CB(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2956("cqb");
}

//Function Number: 66
func_122CA(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2941();
}

//Function Number: 67
func_11FEC(param_00,param_01,param_02,param_03)
{
	return !lib_0A1B::func_2955();
}

//Function Number: 68
func_11C66(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 69
func_11F69(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 70
func_11F65(param_00,param_01,param_02,param_03)
{
	return !scripts\asm\shared_utility::func_9D50();
}

//Function Number: 71
func_11DFE(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 72
func_11F64(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 73
func_11C64(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292C() == "prone";
}

//Function Number: 74
func_12574(param_00,param_01,param_02,param_03)
{
	return lib_0C65::func_FFF5();
}

//Function Number: 75
func_1256D(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_293C();
}

//Function Number: 76
trans_stand_run_strafe_loop_to_grenade_avoid2(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_293C();
}

//Function Number: 77
func_11C60(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_292C() == "prone";
}

//Function Number: 78
func_12138(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_293C();
}

//Function Number: 79
func_120FC(param_00,param_01,param_02,param_03)
{
	return lib_0A1A::func_233C() == "cqb" && !lib_0A1B::func_2941();
}

//Function Number: 80
func_12137(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_298B();
}

//Function Number: 81
func_12116(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 82
func_1214C(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}

//Function Number: 83
func_120E3(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_2959();
}