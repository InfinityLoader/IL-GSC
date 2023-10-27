/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\maps\europa\europa_labs.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 191
 * Decompile Time: 7644 ms
 * Timestamp: 10/27/2023 12:23:03 AM
*******************************************************************/

//Function Number: 1
func_A79C()
{
	scripts\common\utility::flag_init("entering_c12_research_room");
	scripts\common\utility::flag_init("entering_preairlock_room");
	scripts\common\utility::flag_init("airlock_opened_enough");
	scripts\common\utility::flag_init("antigrav_detonates");
	scripts\common\utility::flag_init("combat_bridge_argue");
	scripts\common\utility::flag_init("start_bridge_argue");
	scripts\common\utility::flag_init("player_scar1_in_airlock");
	scripts\common\utility::flag_init("player_enters_glass_bridge");
	scripts\common\utility::flag_init("player_crossing_bridge");
	scripts\common\utility::flag_init("player_enters_c12_labs");
	scripts\common\utility::flag_init("combat_end_hall");
	scripts\common\utility::flag_init("enter_office_door_area");
	scripts\common\utility::flag_init("enter_cutter_area");
	scripts\common\utility::flag_init("entering_office_exit");
	scripts\common\utility::flag_init("cutter_finished");
	scripts\common\utility::flag_init("wall_cut_finished");
	scripts\common\utility::flag_init("combat_office_exit");
	scripts\common\utility::flag_init("office_exit_start_scene");
	scripts\common\utility::flag_init("player_exit_office_into_armory");
	scripts\common\utility::flag_init("player_through_airlock_door");
	scripts\common\utility::flag_init("player_in_cutter_room");
	scripts\common\utility::flag_init("cutter_bot_battle_finished");
	scripts\common\utility::flag_init("cancel_door_tap_scene");
	scripts\common\utility::flag_init("lab_exterior_clear");
	scripts\common\utility::flag_init("seeker_room_hot");
	scripts\common\utility::flag_init("seeker_enemies_dead");
	scripts\common\utility::flag_init("airlock_enemies_dead");
	scripts\common\utility::flag_init("antigrav_out");
	scripts\common\utility::flag_init("antigrav_clear");
	scripts\common\utility::flag_init("takedown_enemy_dead");
	scripts\common\utility::flag_init("seeker_attacked");
	scripts\common\utility::flag_init("cliffjumper_vo_finished");
	scripts\common\utility::flag_init("takedown_finished");
	scripts\common\utility::flag_init("lab_exterior_vo_finished");
	scripts\common\utility::flag_init("squad_to_airlock");
	scripts\common\utility::flag_init("airlock_closing");
	scripts\common\utility::flag_init("airlock_ready");
	scripts\common\utility::flag_init("locker_c6s_dead");
	scripts\common\utility::flag_init("scars_in_cutter_room");
	scripts\common\utility::flag_init("crash_door");
	scripts\common\utility::flag_init("office_fight_started");
	scripts\common\utility::flag_init("allies_kickoff");
	scripts\common\utility::flag_init("raise_platform");
	scripts\common\utility::flag_init("platform_guys_dead");
	scripts\common\utility::flag_init("player_did_alt_scope");
	scripts\common\utility::flag_init("takedown_vo_complete");
	scripts\common\utility::flag_init("scars_in_lab");
	scripts\common\utility::flag_init("straggler_dead");
	scripts\common\utility::flag_init("base_entrance_snipers_engaged");
	scripts\common\utility::flag_init("base_entrance_platform_enemies_engaged");
	scripts\sp\_utility::func_22C9("seeker_enemies_ai",::func_F11F);
	level.player scripts\sp\_utility::func_65E0("threw_seeker");
	scripts\sp\_utility::func_16EB("seeker_hint",&"EUROPA_SEEKER_HINT",::func_F15C);
	precachestring(&"EUROPA_DBL_JUMP1");
	level.player scripts\sp\_utility::func_65E0("pressed_jump_once");
	level.player scripts\sp\_utility::func_65E0("pressed_jump_twice");
	var_00 = getent("office_breach_door","targetname");
	var_01 = scripts\common\utility::getstruct("office_cutdoor_base_position","targetname");
	var_00.origin = var_01.origin;
	scripts\common\utility::array_thread(getentarray("posed_script_models","targetname"),::func_D6A7);
	thread func_94E6();
	scripts\common\utility::trigger_off("takedown_color_moveup","targetname");
	scripts\common\utility::trigger_off("enter_airlock_color_move","targetname");
	scripts\sp\_utility::func_22CA("back_office_enemies",::func_2726);
}

//Function Number: 2
func_56B2()
{
	if(scripts\common\utility::flag("player_crossed_chasm"))
	{
		return;
	}

	level.player sethudtutorialmessage(&"EUROPA_DBL_JUMP1");
	func_137DC();
	wait(0.5);
	level.player clearhudtutorialmessage();
}

//Function Number: 3
func_137DC()
{
	level.player endon("doubleJumpBoostBegin");
	scripts\common\utility::flag_wait("player_crossed_chasm");
}

//Function Number: 4
func_12B8F()
{
	scripts\sp\maps\europa\europa_util::func_107C5();
	thread scripts\sp\maps\europa\europa_util::func_8E46(1);
	level.player scripts\sp\maps\europa\europa_util::func_8E34(1);
	scripts\sp\maps\europa\europa_util::func_EBC7();
	scripts\sp\_utility::func_F5AF("drop_landing_start",[level.var_EBBB,level.var_EBBC,level.player]);
	scripts\sp\_utility::func_15F5("squad_lands");
	thread scripts\sp\maps\europa\europa_util::func_67B6(1,"current",&"EUROPA_OBJECTIVE_ACCESS","entering_seeker_room");
}

//Function Number: 5
func_12B8C()
{
	scripts\sp\_utility::func_2669("tunnels");
	if(scripts\sp\_utility::func_93A6())
	{
		thread specialist_tutorials();
	}

	level thread scripts\sp\maps\europa\europa_util::func_5F7C(level.var_EBCA);
	level.var_EBBC thread func_115FA();
	thread func_1146A();
	thread func_1351D();
	function_01C5("player_sprintspeedscale",1.05);
	thread func_CF8F();
	scripts\common\utility::flag_wait("takedown_approach");
}

//Function Number: 6
func_6743()
{
	level.player thread scripts\sp\maps\europa\europa_util::func_12992();
	level.player scripts\common\utility::func_5127(5,::scripts\sp\maps\europa\europa_util::func_12970);
}

//Function Number: 7
func_115FA()
{
	self.var_C9BD = 1;
	while(self method_81A6())
	{
		wait(0.05);
	}

	wait(0.05);
	scripts\sp\_utility::func_F3B5("b");
	wait(7);
	self.var_C9BD = undefined;
}

//Function Number: 8
func_1351D()
{
	level.player scripts\common\utility::func_5127(0.15,::scripts\sp\_utility::func_D091,"ges_point_firm",level.var_10214);
	var_00 = ["europa_plr_sipestakepoint"];
	scripts\common\utility::func_5127(1.3,::scripts\sp\_utility::func_15F5,"cliffjump_friendlies_clear");
	scripts\sp\maps\europa\europa_util::func_48BD(var_00);
	scripts\common\utility::flag_set("cliffjumper_vo_finished");
	wait(1.8);
	scripts\sp\maps\europa\europa_util::func_D24C(["europa_plr_11toreapersetdefgun","europa_rpr_copywillrelay"]);
	wait(1);
	wait(0.7);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_letsgettotheweaponb");
}

//Function Number: 9
func_9287()
{
	var_00 = getent("ice_fall_trig","targetname");
	var_01 = 0;
	var_02 = var_00 scripts\common\utility::get_target_ent();
	for(;;)
	{
		var_00 waittill("trigger",var_03);
		if(!var_01)
		{
			playfx(scripts\common\utility::getfx("vfx_ice_fall_caves"),var_02.origin);
			var_01 = 1;
		}

		wait(1.5);
	}
}

//Function Number: 10
func_9288()
{
	scripts\common\utility::exploder("chunk_2");
}

//Function Number: 11
func_12B8D()
{
}

//Function Number: 12
func_1146B()
{
	thread func_1146A();
	scripts\sp\maps\europa\europa_util::func_107C5();
	thread scripts\sp\maps\europa\europa_util::func_8E46(1);
	level.player scripts\sp\maps\europa\europa_util::func_8E34(1);
	scripts\sp\maps\europa\europa_util::func_EBC7();
	scripts\sp\_utility::func_F5AF("c6_robot_pods_start",[level.var_EBBB,level.var_EBBC,level.player]);
	scripts\common\utility::flag_set("takedown_approach");
	scripts\sp\_utility::func_15F5("c6_robot_event_color_move");
	level thread scripts\sp\maps\europa\europa_util::func_5F7C(level.var_EBCA);
	thread scripts\sp\maps\europa\europa_util::func_67B6(1,"current",&"EUROPA_OBJECTIVE_ACCESS","entering_seeker_room");
}

//Function Number: 13
func_1145E()
{
	thread func_1351A();
	thread scripts\sp\_utility::func_6E7C("takedown_enemy_dead",::func_A781);
	scripts\common\utility::flag_wait("base_arrive");
	thread scripts\sp\_utility::func_AB9A("player_sprintspeedscale",1.4,3);
}

//Function Number: 14
func_CF8F()
{
	var_00 = scripts\common\utility::getclosest(scripts\common\utility::getstruct("platform_scene","targetname").origin,level.var_EBCA,99999);
	if(getdvarint("debug_europa"))
	{
		thread scripts\sp\_utility::func_5B4D(var_00,level.player,1,0,0,20);
	}

	var_00 thread scripts\sp\maps\europa\europa_util::func_D2DC(250);
}

//Function Number: 15
func_1351A()
{
	scripts\common\utility::flag_wait("takedown_finished");
	scripts\sp\maps\europa\europa_util::func_134B7("europa_sip_hesdown2");
	wait(1);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_entrypoints30");
	wait(0.5);
	if(scripts\common\utility::flag("base_arrive"))
	{
		scripts\common\utility::flag_set("takedown_vo_complete");
		return;
	}

	var_00 = level.player scripts\sp\_utility::func_D08C("ges_radio");
	if(var_00)
	{
		level.player scripts\common\utility::delaycall(0.5,::playsound,"ges_plr_radio_on");
		level.player method_8012(0);
		wait(0.8);
	}

	level.player scripts\sp\_utility::func_CE2F("europa_plr_reaperweareapp");
	wait(0.1);
	level.player scripts\sp\_utility::func_CE2F("europa_rpr_thermalisspotty");
	if(!scripts\common\utility::flag("base_arrive"))
	{
		level.player scripts\sp\_utility::func_CE2F("europa_plr_copy");
	}

	if(var_00)
	{
		level.player playsound("ges_plr_radio_off");
		level.player stopgestureviewmodel("ges_radio",1);
		level.player method_8012(1);
	}

	scripts\common\utility::flag_set("takedown_vo_complete");
}

//Function Number: 16
func_11462()
{
	scripts\common\utility::trigger_on("takedown_color_moveup","targetname");
}

//Function Number: 17
func_1146A()
{
	scripts\sp\_utility::func_22CA("takedown_enemy",::func_11466);
	var_00 = scripts\common\utility::getstruct("takedown_struct","targetname");
	var_00.var_10C = scripts\sp\_utility::func_107EA("takedown_enemy",1);
	var_00.var_10C thread scripts\sp\maps\europa\europa_intro::func_1081C();
	level.var_EBBC.var_1A29 = var_00.var_10C scripts\common\utility::spawn_tag_origin();
	level.var_EBBC.var_1A29 linkto(var_00.var_10C,"tag_origin",(0,0,20),(0,0,0));
	scripts\common\utility::flag_wait("takedown_start");
	level.var_EBBB scripts\sp\_utility::func_61E7();
	level.var_EBBB.var_C9BD = undefined;
	var_00.var_7395 = level.var_EBBB;
	var_00.var_1684 = [var_00.var_7395,var_00.var_10C];
	foreach(var_02 in var_00.var_1684)
	{
		var_02.var_1FBD = spawnstruct();
		var_02.var_1FBD.origin = var_00.origin;
		var_02.var_1FBD.angles = var_00.angles;
	}

	var_00.var_7395.var_1FBD lib_0B06::func_1F17(var_00.var_7395,"tunnel_takedown");
	if(level.var_EBBB scripts\sp\maps\europa\europa_util::func_9B77())
	{
		level thread func_1145F(var_00);
		return;
	}

	scripts\sp\_utility::func_15F5("blue_covers_takedown");
	level.var_EBBC.var_C9BD = 1;
	level.var_EBBC scripts\sp\_utility::func_5514();
	level.var_EBBC thread func_2BD4();
	var_04 = getanimlength(scripts\sp\_utility::func_7DC2("tunnel_takedown","scar1"));
	var_00.var_7395 thread func_11467(var_00);
	var_00.var_10C thread func_11465(var_00);
	foreach(var_02 in var_00.var_1684)
	{
		var_02.var_1FBD thread lib_0B06::func_1F35(var_02,"tunnel_takedown");
	}

	level.var_EBBB scripts\common\utility::delaycall(1,::playsound,"scn_europa_takedown_boost_npc");
	level.player scripts\common\utility::delaycall(1,::playsound,"scn_europa_takedown_boost_npc_amb");
	level waittill("interupt_check");
	if(!isdefined(var_00.var_9A92))
	{
		wait(2);
	}

	scripts\common\utility::flag_set("takedown_finished");
	thread func_7394();
	level.player scripts\sp\_utility::func_D2D1(190,5);
}

//Function Number: 18
func_2BD4()
{
	self.var_595D = 1;
	self method_82DE(level.var_EBBC.var_1A29,1);
}

//Function Number: 19
func_11467(param_00)
{
	level waittill("interupt_check");
	if(isdefined(param_00.var_9A92))
	{
		param_00.var_7395 scripts\sp\maps\europa\europa_util::func_10FC2();
		param_00.var_7395 scripts\sp\_utility::func_61C7();
	}
}

//Function Number: 20
func_11465(param_00)
{
	self endon("cannot_interupt");
	for(;;)
	{
		self waittill("damage",var_01,var_02);
		if(isdefined(var_02) && var_02 == level.player)
		{
			param_00.var_9A92 = 1;
			self.var_30 = 1;
			self method_81D0((0,0,0),level.player);
			return;
		}
	}
}

//Function Number: 21
func_7394()
{
	level.var_EBBC method_8072();
	level.var_EBBC.var_1A29 delete();
	level.var_EBBC.var_595D = undefined;
	scripts\common\utility::trigger_on("takedown_color_moveup","targetname");
	wait(0.05);
	scripts\sp\_utility::func_15F5("takedown_color_moveup");
	level.var_EBBC.var_C9BD = undefined;
	level.var_EBBB scripts\sp\_utility::func_61C7();
}

//Function Number: 22
func_11464()
{
	thread scripts\sp\maps\europa\europa_util::func_10FC2();
	self.maxsightdistsqrd = squared(8192);
	self.var_132 = 0;
	self.ignoreme = 0;
	self.var_180 = 0;
	self.var_1FD = squared(512);
	self.var_30 = 1;
	self.var_1491.var_5605 = 0;
	self.allowpain = 1;
	self.var_28CF = 1;
	self.var_10265 = undefined;
}

//Function Number: 23
func_1145F(param_00)
{
	thread scripts\sp\_utility::func_6E7C("takedown_enemy_dead",::scripts\common\utility::flag_set,"takedown_finished");
	level.var_EBBB.var_C9BD = undefined;
	level.var_EBBB scripts\sp\_utility::func_61C7();
	scripts\common\utility::trigger_on("takedown_color_moveup","targetname");
	param_00.var_10C notify("takedown_aborted");
	param_00.var_10C thread func_4DFD();
	param_00.var_10C thread func_11460();
	param_00.var_10C.maxsightdistsqrd = squared(8192);
	param_00.var_10C.var_132 = 1;
	param_00.var_10C.ignoreme = 0;
	param_00.var_10C.var_180 = 1;
	param_00.var_10C.var_1FD = squared(512);
	param_00.var_10C.var_30 = 1;
	param_00.var_10C.var_1491.var_5605 = 0;
	param_00.var_10C.allowpain = 1;
	param_00.var_10C.var_28CF = 0;
	param_00.var_10C.var_10265 = undefined;
	param_00.var_10C thread scripts\sp\maps\europa\europa_util::func_10FC2();
	param_00.var_10C.target = "takedown_guy_abort_spot";
	param_00.var_10C scripts\sp\_utility::func_51E1("casual_gun");
	param_00.var_10C.health = 40;
	param_00.var_10C.var_15C = 35;
	param_00.var_10C thread scripts\sp\maps\europa\europa_util::func_10F49();
	param_00.var_10C thread lib_0B77::func_8409();
	param_00.var_10C waittill("stealthlight_attack");
	param_00.var_10C method_83AD();
	wait(0.05);
	param_00.var_10C playsound("stealth_sf0_enemyalerted");
	param_00.var_10C notify("stop_going_to_node");
	param_00.var_10C scripts\sp\_utility::func_F39C(level.player);
	param_00.var_10C scripts\sp\_utility::func_4145();
	param_00.var_10C method_82EF(param_00.var_10C.origin);
}

//Function Number: 24
func_4DFD()
{
	scripts\common\utility::flag_wait("base_arrive");
	if(isalive(self))
	{
		scripts\sp\_utility::func_54C6();
	}
}

//Function Number: 25
func_11460()
{
	self endon("death");
	self endon("stealthlight_attack");
	self playsound("stealth_sf0_searchreport");
	wait(2);
	self playsound("stealth_sf0_confirmclear");
}

//Function Number: 26
func_11466()
{
	self endon("death");
	self endon("takedown_aborted");
	scripts\sp\_utility::func_65E0("no_interupt");
	func_19D9();
	self.var_1FBB = "takedown_enemy";
	scripts\sp\_utility::func_51E1("casual_gun");
	self.var_ED48 = "takedown_enemy_dead";
	thread lib_0B77::func_1936();
	self.var_102 = 0;
}

//Function Number: 27
func_19D9()
{
	self.maxsightdistsqrd = 1;
	self.var_132 = 1;
	self.ignoreme = 1;
	self.var_180 = 1;
	self.var_1FD = 0;
	self.var_30 = 0;
	self.var_1491.var_5605 = 1;
	self.allowpain = 0;
	self.var_28CF = 0;
	self.var_10265 = 1;
	self.var_102 = 0;
}

//Function Number: 28
specialist_tutorials()
{
	specialist_nanoshot_tutorial();
	scripts\sp\_utility::func_127B3("takedown_color_moveup");
	specialist_helmet_tutorial();
}

//Function Number: 29
specialist_nanoshot_tutorial()
{
	var_00 = getentarray("specialist_mode_only","targetname");
	var_01 = scripts\common\utility::getclosest((29236,-5990,-76),var_00);
	var_01 scripts\sp\_utility::func_918B("ar_callouts_nanoshot");
	while(!scripts\sp\_utility::func_D0BD("nanoshot",1) && !scripts\common\utility::flag("takedown_start"))
	{
		wait(0.05);
	}

	var_01 scripts\sp\_utility::func_918C();
	if(scripts\common\utility::flag("takedown_start"))
	{
		return;
	}

	scripts\sp\_utility::func_56BE("nanoshot_tutorial_hint",9);
}

//Function Number: 30
specialist_helmet_tutorial()
{
	var_00 = undefined;
	var_01 = getentarray();
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.model))
		{
			continue;
		}

		if(var_03.origin == (29095,-7658,-53.8869))
		{
			var_00 = var_03;
			break;
		}
	}

	var_00 scripts\sp\_utility::func_918B("ar_callouts_helmet");
	while(!scripts\sp\_utility::func_D0BD("helmet",1) && !scripts\common\utility::flag("base_arrive"))
	{
		wait(0.05);
	}

	var_00 scripts\sp\_utility::func_918C();
	if(scripts\common\utility::flag("base_arrive"))
	{
		return;
	}

	scripts\sp\_utility::func_56BE("helmet_tutorial_hint",9);
}

//Function Number: 31
scale_accuracy_on_level(param_00)
{
	var_01 = 1;
	switch(level.var_7683)
	{
		case 1:
		case 0:
			var_01 = 1;
			break;

		case 2:
			var_01 = 1.2;
			break;

		case 3:
		default:
			var_01 = 1.35;
			break;
	}

	self.var_2894 = var_01;
}

//Function Number: 32
snipers_get_tough()
{
	scale_accuracy_on_level(3.5);
	var_00 = [];
	var_00["prone"] = 400;
	var_00["crouch"] = 600;
	var_00["stand"] = 800;
	var_01 = [];
	var_01["prone"] = 1000;
	var_01["crouch"] = 2000;
	var_01["stand"] = 3000;
	lib_0F27::func_F353(var_00,var_01);
	self method_84F7("attack",level.player,level.player.origin);
}

//Function Number: 33
check_dead_count(param_00)
{
	var_01 = 0;
	foreach(var_03 in param_00)
	{
		if(!isalive(var_03))
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 34
wait_platform_guys_fight_started(param_00)
{
	self endon("death");
	level endon("base_entrance_platform_enemies_dead");
	level endon("base_entrance_platform_enemies_engaged");
	level endon("squad_to_base_edge");
	for(;;)
	{
		if(check_dead_count(param_00) > 0)
		{
			scripts\common\utility::flag_set("base_entrance_platform_enemies_engaged");
			return;
		}

		wait(0.1);
	}
}

//Function Number: 35
wait_sniper_fight_started(param_00)
{
	self endon("death");
	level endon("base_entrance_snipers_dead");
	level endon("base_entrance_snipers_engaged");
	for(;;)
	{
		if(check_dead_count(param_00) > 0)
		{
			scripts\common\utility::flag_set("base_entrance_snipers_engaged");
			return;
		}

		wait(0.1);
	}
}

//Function Number: 36
func_A780()
{
	scripts\sp\maps\europa\europa_util::func_107C5();
	scripts\sp\maps\europa\europa_util::func_EBC7();
	thread scripts\sp\maps\europa\europa_util::func_8E46(1);
	level.player scripts\sp\maps\europa\europa_util::func_8E34(1);
	scripts\sp\_utility::func_F5AF("lab_exterior_start",[level.var_EBBB,level.var_EBBC,level.player]);
	scripts\common\utility::func_6E3F("takedown_vo_complete",2);
	thread func_A781();
	thread scripts\sp\maps\europa\europa_util::func_67B6(1,"current",&"EUROPA_OBJECTIVE_ACCESS","entering_seeker_room");
}

//Function Number: 37
func_A77D()
{
	if(getdvarint("debug_europa"))
	{
		iprintln("exploder le_clouds");
	}

	level.var_A760 = getent("base_door","targetname");
	level.var_A760 hide();
	scripts\sp\_utility::func_28D7("axis");
	scripts\common\utility::exploder("le_clouds");
	var_00 = scripts\sp\_vehicle::func_1080C("entrance_dropship");
	thread func_A77F();
	thread func_28AD();
	scripts\common\utility::flag_wait("base_arrive");
	thread scripts\sp\maps\europa\europa_util::func_10181();
	var_00 playsound("scn_lab_reveal_dropship_takeoff");
	thread lib_0B98::func_845A(var_00);
	var_00 thread func_5EAE();
	function_01BA("mx_135_base_reveal");
	if(getdvarint("debug_europa"))
	{
		level.var_37CE = 1;
	}

	func_10F40();
	var_01 = scripts\sp\_utility::func_77DA("base_entrance_snipers");
	level.var_103BD = var_01;
	foreach(var_03 in var_01)
	{
		if(level.var_7683 > 1)
		{
			var_03.health = 60;
		}
		else
		{
			var_03.health = 20;
		}

		var_03.var_4E46 = ::func_DC1B;
		var_03 lib_0F19::func_F30D();
	}

	thread func_134E5(var_01);
	thread scripts\sp\maps\europa\europa_util::func_10690("base_entrance");
	thread func_F156();
	thread scripts\sp\maps\europa\europa_util::func_10F59(var_01,[level.var_EBBB,level.var_EBBC]);
	thread wait_sniper_fight_started(var_01);
	if(level.var_7683 > 1)
	{
		scripts\common\utility::flag_wait("base_entrance_snipers_engaged");
		scripts\common\utility::func_6E59("base_entrance_snipers_dead",3);
	}
	else
	{
		scripts\sp\_utility::func_13754(var_01);
	}

	foreach(var_03 in level.var_EBCA)
	{
		var_03.var_C9BD = 1;
		var_03 scripts\sp\_utility::func_61E7();
	}

	if(!scripts\common\utility::flag("base_entrance_platform_enemies_dead"))
	{
		if(level.var_7683 > 1)
		{
			var_07 = scripts\sp\_utility::func_77DA("base_entrance_platform_guys");
			thread wait_platform_guys_fight_started(var_07);
			scripts\common\utility::func_6E59("base_entrance_platform_enemies_engaged",3);
			scripts\common\utility::func_6E59("base_entrance_platform_enemies_dead",6);
		}

		scripts\sp\_utility::func_15F5("squad_to_base_edge");
	}

	scripts\common\utility::flag_wait("base_entrance_platform_enemies_dead");
	scripts\common\utility::trigger_on("base_entrnace_moveup","targetname");
	scripts\common\utility::trigger_on("friendlies_enter_lab","targetname");
	scripts\common\utility::flag_wait("lab_exterior_vo_finished");
	function_01C5("ai_linkWeightPerUserMin",9);
	function_01C5("ai_linkWeightPerUserMax",10);
	if(!scripts\common\utility::flag("player_crossed_chasm"))
	{
		scripts\sp\_utility::func_15F5("base_entrnace_moveup");
	}

	lib_0F21::func_F5B6(0);
	thread func_B99F();
	scripts\common\utility::func_5127(2,::func_56B2);
	scripts\common\utility::flag_wait("entering_labs");
	function_01C5("ai_linkWeightPerUserMin",0.2);
	function_01C5("ai_linkWeightPerUserMax",0.4);
	foreach(var_03 in level.var_EBCA)
	{
		var_03.var_C9BD = undefined;
	}
}

//Function Number: 38
func_DC1B()
{
	level thread func_1B31();
	scripts\anim\shared::func_5D1A();
	self method_839B("torso_upper",vectornormalize(level.player.origin - self.origin + (0,0,60)) * 1000);
	wait(10);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 39
func_1B31()
{
	if(isdefined(level.var_1D54))
	{
		return;
	}

	scripts\common\utility::flag_set("base_entrance_snipers_engaged");
	level.var_1D54 = 1;
	var_00 = scripts\sp\_utility::func_22BB(level.var_103BD);
	foreach(var_02 in var_00)
	{
		var_02 snipers_get_tough();
	}
}

//Function Number: 40
func_A77F()
{
	if(getdvarint("debug_europa"))
	{
		iprintln("showing base_reveal_vista");
	}

	scripts\sp\maps\europa\europa_util::func_119B1(1);
}

//Function Number: 41
func_10F40()
{
	var_00 = [];
	var_00["prone"] = 1000;
	var_00["crouch"] = 1000;
	var_00["stand"] = 1000;
	var_01 = [];
	var_01["prone"] = 800;
	var_01["crouch"] = 1500;
	var_01["stand"] = 3000;
	lib_0F27::func_F353(var_00,var_01);
	var_02["sight_dist"] = 5;
	var_02["detect_dist"] = 5;
	var_02["found_dist"] = 5;
	lib_0F19::func_F30E(var_02);
}

//Function Number: 42
func_5EAE()
{
	self endon("death");
	self.var_EF05 = 1;
	for(;;)
	{
		var_00 = self method_83DD() + 10;
		self method_83E5(var_00,var_00 * 0.8,var_00 * 0.2);
		wait(1);
	}
}

//Function Number: 43
func_28AD()
{
	var_00 = spawnstruct();
	var_00.var_2857 = getent("base_entrance_platform","targetname");
	var_00.var_B926 = getentarray("base_entrance_platform_models","targetname");
	var_00.var_5924 = 0;
	var_00.var_10B89 = scripts\common\utility::getstruct("platform_start","targetname").origin;
	foreach(var_02 in var_00.var_B926)
	{
		var_02 linkto(var_00.var_2857);
	}

	var_00.var_62A3 = var_00.var_2857.origin;
	var_00.var_10CB8 = function_00B3("platform_traverse_start1","script_noteworthy");
	var_00.var_62E2 = function_00B3("platform_traverse_end1","script_noteworthy");
	var_00.var_10CB9 = function_00B3("platform_traverse_start2","script_noteworthy");
	var_00.var_62E3 = function_00B3("platform_traverse_end2","script_noteworthy");
	var_04 = [];
	while(!var_04.size)
	{
		var_04 = scripts\sp\_utility::func_77DA("base_entrance_platform_guys");
		wait(0.05);
	}

	thread func_CC60();
	level.var_CC5B = var_00.var_2857;
	scripts\sp\maps\europa\europa_util::func_10690("base_exterior");
	var_05 = 200;
	var_00.var_2857 dontinterpolate();
	var_00.var_2857.origin = var_00.var_2857.origin - (0,0,var_05);
	func_DC46();
	var_06 = 5;
	var_00.var_2857 playsound("scn_europa_lab_platform_rise");
	var_00.var_2857 movez(var_05,var_06,var_06 * 0.2,var_06 * 0.8);
	wait(var_06);
	var_00.var_5924 = 1;
	var_00.var_2857 method_80AF(undefined);
	function_004D("platform1",var_00.var_10CB8.origin,var_00.var_62E2.origin,var_00.var_10CB8);
	function_004D("platform2",var_00.var_10CB9.origin,var_00.var_62E3.origin,var_00.var_10CB9);
	scripts\common\utility::exploder("basereveal_platform_fx");
}

//Function Number: 44
func_CC60()
{
	wait(0.05);
	var_00 = scripts\sp\_utility::func_77DA("base_entrance_platform_guys");
	scripts\common\utility::array_thread(var_00,::lib_0F1C::func_6837,0);
}

//Function Number: 45
func_DC46()
{
	var_00 = undefined;
	if(level.var_7683 > 1)
	{
		var_00 = scripts\common\utility::func_6E4F("player_at_edge","base_entrance_snipers_dead","base_entrance_snipers_engaged");
	}
	else
	{
		var_00 = scripts\common\utility::func_6E4F("player_at_edge","base_entrance_snipers_dead");
	}

	scripts\common\utility::flag_set("raise_platform");
	func_10F42();
	var_01 = scripts\sp\_utility::func_77DA("base_entrance_platform_guys");
	var_01 = scripts\sp\_utility::func_22BB(var_01);
	foreach(var_03 in var_01)
	{
		var_03 lib_0F1C::func_6837(1);
		var_03 thread func_872B();
	}
}

//Function Number: 46
func_872B()
{
	self endon("death");
	scripts\sp\_utility::func_5550();
	thread guy_die_if_helmet_pop();
	wait(randomfloat(2));
	self.var_10E6D.var_B470 = 1;
	self method_84F7("attack",level.player,level.player.origin);
	scripts\sp\_utility::func_50E4(randomfloat(0.8),::func_2527);
	self.health = 100;
	scale_accuracy_on_level(1.6);
}

//Function Number: 47
guy_die_if_helmet_pop()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_00,var_00,var_00,var_00,var_00,var_00,var_01,var_00,var_00);
		if(isdefined(var_01) && var_01 == "j_helmet")
		{
			self method_81D0();
		}

		wait(0.05);
	}
}

//Function Number: 48
func_5775()
{
	self endon("death");
	self.var_15C = 800;
	for(;;)
	{
		var_00 = self method_80E3();
		if(isdefined(var_00))
		{
			self.var_15C = 32;
			self method_82EE(var_00);
			self waittill("goal");
			self.var_15C = 1000;
			return;
		}

		wait(2);
	}
}

//Function Number: 49
func_2527()
{
	self.var_5951 = undefined;
	var_00 = clamp(5 - level.var_7683,3,5);
	wait(var_00);
	self.var_50 = 5;
}

//Function Number: 50
func_CC5E()
{
	self endon("death");
	while(!self.var_10E6D.var_10E19)
	{
		wait(0.05);
	}

	wait(randomfloatrange(0.1,0.3));
	scripts\sp\maps\europa\europa_util::func_10FC2();
	self unlink();
}

//Function Number: 51
func_57B8()
{
	if(scripts\common\utility::flag("did_scope_hint"))
	{
		return;
	}

	level endon("player_did_alt_scope");
	var_00 = func_137CE();
	if(!isdefined(var_00))
	{
		scripts\common\utility::flag_set("player_did_alt_scope");
		return;
	}

	childthread func_387D(level.player getcurrentprimaryweapon());
	thread scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_closequarterschec");
	wait(1.5);
	if(level.console || level.player usinggamepad())
	{
		scripts\sp\_utility::func_56BA("scope_both");
	}
	else
	{
		scripts\sp\_utility::func_56BA("scope_kb");
	}

	scripts\common\utility::flag_set("did_scope_hint");
	if(level.var_7683 < 2)
	{
		level.player scripts\sp\_utility::func_65E8("global_hint_in_use");
		wait(0.5);
		if(level.player scripts\sp\_utility::func_65DB("switched_weapon_during_tutorial"))
		{
			return;
		}

		thread scripts\sp\_utility::func_56BE("scope_test",5);
	}

	level.player scripts\sp\_utility::func_65E8("global_hint_in_use");
	if(level.player scripts\sp\_utility::func_65DB("switched_weapon_during_tutorial"))
	{
		return;
	}

	scripts\common\utility::flag_set("player_did_alt_scope");
}

//Function Number: 52
func_137CE()
{
	level endon("scope_timeout");
	level thread scripts\sp\_utility::func_C12D("scope_timeout",10);
	for(;;)
	{
		var_00 = level.player getcurrentprimaryweapon();
		var_01 = weaponaltweaponname(var_00);
		if(var_01 == "none")
		{
			wait(0.05);
			continue;
		}

		return 1;
	}
}

//Function Number: 53
func_387D(param_00)
{
	while(level.player getcurrentprimaryweapon() == param_00)
	{
		wait(0.05);
	}

	level.player scripts\sp\_utility::func_65E1("switched_weapon_during_tutorial");
	scripts\common\utility::flag_set("player_did_alt_scope");
}

//Function Number: 54
func_A77E()
{
	scripts\common\utility::trigger_on("base_entrnace_moveup","targetname");
	scripts\common\utility::trigger_on("friendlies_enter_lab","targetname");
}

//Function Number: 55
func_A781()
{
	scripts\common\utility::array_thread([level.var_EBBB,level.var_EBBC],::scripts\sp\_utility::func_F415,1);
	scripts\common\utility::array_thread([level.var_EBBB,level.var_EBBC],::scripts\sp\_utility::func_F416,1);
	scripts\common\utility::flag_wait("raise_platform");
	scripts\common\utility::array_thread([level.var_EBBB,level.var_EBBC],::scripts\sp\_utility::func_F415,0);
	scripts\common\utility::array_thread([level.var_EBBB,level.var_EBBC],::scripts\sp\_utility::func_F416,0);
}

//Function Number: 56
func_F164()
{
	return level.player scripts\sp\_utility::func_65DB("threw_seeker");
}

//Function Number: 57
func_134E5(param_00)
{
	scripts\common\utility::flag_wait("base_arrive");
	foreach(var_02 in level.var_EBCA)
	{
		var_02.var_C9BD = 1;
		var_02 scripts\sp\_utility::func_5514();
	}

	level.var_EBBB.var_C9BD = 1;
	level.var_EBBB scripts\sp\_utility::func_5514();
	scripts\common\utility::flag_wait("takedown_vo_complete");
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_movementgetdown");
	func_103B1(param_00);
	var_04 = func_137EC(4);
	if(!scripts\common\utility::flag("player_crossed_chasm") && !level.player scripts\sp\_utility::func_65DB("player_has_red_flashing_overlay"))
	{
		if(isdefined(var_04))
		{
			scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_got3morecoming");
		}
		else
		{
			scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_targetsontheplatform");
		}
	}

	scripts\common\utility::flag_wait("base_entrance_platform_enemies_dead");
	wait(0.8);
	if(!scripts\common\utility::flag("player_crossed_chasm"))
	{
		scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_pressup");
		wait(0.6);
	}

	scripts\common\utility::flag_set("lab_exterior_vo_finished");
	if(scripts\common\utility::flag("player_crossed_chasm"))
	{
		return;
	}

	wait(0.7);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_deephole");
	scripts\common\utility::flag_wait("player_crossed_chasm");
	var_05 = ["europa_sip_theyjustexecuted","europa_tee_sdfwantsweaponsnot"];
	scripts\sp\maps\europa\europa_util::func_48BD(var_05);
}

//Function Number: 58
func_103B1(param_00)
{
	level endon("raise_platform");
	func_6DD5(param_00);
	scripts\common\utility::flag_wait("base_entrance_snipers_dead");
	wait(0.25);
	if(isdefined(level.var_4BC1) && isdefined(level.var_4BC1.var_10306))
	{
		return;
	}

	scripts\sp\maps\europa\europa_util::func_134B7("europa_sip_clear");
	wait(0.3);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_allclear2");
}

//Function Number: 59
func_6DD5(param_00)
{
	level endon("stealthtakedown_start");
	level endon("base_entrance_snipers_dead");
	var_01 = 4;
	var_02 = func_7BB2(param_00,var_01);
	if(isdefined(var_02))
	{
		var_03 = "europa_plr_sniperuptopseco";
	}
	else
	{
		var_03 = "europa_sip_sentriesontheroof";
	}

	var_04 = "europa_tee_wolftakeone";
	if(!scripts\common\utility::flag("player_crossed_chasm") && !level.var_4BC1.var_10D8F)
	{
		scripts\sp\maps\europa\europa_util::func_134B7(var_03);
	}

	if(!scripts\common\utility::flag("player_crossed_chasm") && !level.var_4BC1.var_10D8F)
	{
		scripts\sp\maps\europa\europa_util::func_134B7(var_04);
	}

	var_05 = ["europa_tee_onyouboss","europa_tee_quitdossinabout"];
	for(;;)
	{
		foreach(var_07 in var_05)
		{
			wait(randomintrange(9,15));
			if(scripts\common\utility::flag("player_crossed_chasm") || level.var_4BC1.var_10D8F)
			{
				return;
			}

			scripts\sp\maps\europa\europa_util::func_134B7(var_07);
		}

		wait(0.05);
	}
}

//Function Number: 60
func_137EC(param_00)
{
	if(scripts\common\utility::flag("player_crossed_chasm"))
	{
		return undefined;
	}

	level endon("timeout");
	level thread scripts\sp\_utility::func_C12D("timeout",param_00);
	var_01 = scripts\sp\_utility::func_77DA("base_entrance_platform_guys");
	for(;;)
	{
		foreach(var_03 in var_01)
		{
			if(scripts\common\utility::func_13D90(level.player.origin,level.player getplayerangles(),var_03.origin,cos(40)))
			{
				if(scripts\sp\_detonategrenades::func_385C(level.player geteye(),var_03))
				{
					return 1;
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 61
func_7BB2(param_00,param_01)
{
	level endon("player_target_timeout");
	level thread scripts\sp\_utility::func_C12D("player_target_timeout",param_01);
	for(;;)
	{
		foreach(var_03 in param_00)
		{
			if(scripts\sp\maps\europa\europa_util::func_D35D(var_03))
			{
				return 1;
			}
		}

		wait(0.15);
	}
}

//Function Number: 62
func_517A(param_00)
{
	param_00 endon("death");
	self waittill("death");
	wait(1);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 63
func_A770()
{
	level.var_A760 = getent("base_door","targetname");
	level.var_A760 hide();
	scripts\sp\maps\europa\europa_util::func_107C5();
	thread scripts\sp\maps\europa\europa_util::func_8E46(1);
	thread scripts\sp\maps\europa\europa_util::func_5F7C(level.var_EBCA);
	thread func_F156();
	scripts\sp\_utility::func_F5AF("breach_room_start",[level.var_EBBB,level.var_EBBC,level.player]);
	scripts\common\utility::flag_set("scars_in_lab");
	thread scripts\sp\maps\europa\europa_util::func_67B6(1,"current",&"EUROPA_OBJECTIVE_ACCESS","entering_seeker_room");
}

//Function Number: 64
func_A76D()
{
	scripts\sp\maps\europa\europa_util::func_EBC7();
	thread func_134E4();
	thread func_A760();
	if(getdvarint("debug_europa"))
	{
		level.var_37CE = 0;
	}

	level.var_EBBB.var_180 = 1;
	level.var_EBBC.var_180 = 1;
	thread func_6B7F();
	scripts\common\utility::flag_wait("entering_labs");
	thread func_9068();
	thread func_13509();
	scripts\common\utility::flag_wait("seeker_enemies_dead");
	level.var_EBBC.var_C9BD = undefined;
	scripts\common\utility::flag_wait("squad_to_airlock");
	function_01C5("sm_roundrobinpriorityspotshadows",8);
	func_8463();
	scripts\common\utility::flag_wait("airlock_ready");
}

//Function Number: 65
func_13509()
{
	level endon("seeker_room_hot");
	var_00 = getent("seeker_room_vol","targetname");
	var_01 = var_00 scripts\sp\_utility::func_77E3("axis");
	var_02 = scripts\common\utility::array_randomize(var_01);
	var_02[1] scripts\sp\_utility::func_10347("europa_sf2_thereslockershe");
	wait(0.1);
	var_02[0] scripts\sp\_utility::func_10347("europa_sf1_complyrightaway");
	wait(1.5);
	var_02[2] scripts\sp\_utility::func_10347("europa_sf3_onlysatowouldle");
	var_02[1] scripts\sp\_utility::func_10347("europa_sf2_whatdoyouexpect");
	wait(1.7);
	var_02[1] scripts\sp\_utility::func_10347("europa_sf2_bringanythingof");
	wait(0.05);
	var_02[0] scripts\sp\_utility::func_10347("europa_sf1_confirmilldeliv");
	var_02[2] scripts\sp\_utility::func_10347("europa_sf3_thatsnotyourtas");
	wait(0.05);
	var_02[0] scripts\sp\_utility::func_10347("europa_sf1_itsnotyourtaske");
	wait(2.5);
	var_02[1] scripts\sp\_utility::func_10347("europa_sf2_keeplookingweve");
	var_02[2] scripts\sp\_utility::func_10347("europa_sf3_ithinktheresemp");
}

//Function Number: 66
func_A760()
{
	var_00 = getent("patform_flag_trig","targetname");
	scripts\common\utility::flag_wait("scars_in_lab");
	scripts\common\utility::flag_wait("entering_seeker_room");
	wait(1);
	var_01 = scripts\common\utility::getstruct("base_door_closed","targetname");
	while(!func_3825(var_01))
	{
		wait(0.05);
	}

	level.var_A760.origin = var_01.origin;
	level.var_A760 show();
	function_01CB(0);
	scripts\sp\_utility::func_2669("entrance");
}

//Function Number: 67
func_3825(param_00)
{
	if(func_CFB0(param_00))
	{
		return 0;
	}

	if(!param_00 lib_0B4D::func_9C85(level.player.origin))
	{
		return 0;
	}

	if(distance2dsquared(level.player.origin,param_00.origin) < squared(300))
	{
		return 0;
	}

	return 1;
}

//Function Number: 68
func_CFB0(param_00)
{
	var_01 = 0.75;
	var_02 = vectornormalize(param_00.origin - level.player geteye());
	var_03 = level.player getplayerangles();
	var_04 = anglestoforward(var_03);
	var_05 = 0;
	var_06 = vectordot(var_04,var_02);
	return var_06 >= var_01;
}

//Function Number: 69
func_B99F()
{
	var_00 = getent("lab_entrance_trig","targetname");
	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		if(level.var_EBBB istouching(var_00) && !var_01)
		{
			var_01 = 1;
		}

		if(level.var_EBBC istouching(var_00) && !var_02)
		{
			var_02 = 1;
		}

		if(var_01 && var_02)
		{
			wait(5);
			scripts\common\utility::flag_set("scars_in_lab");
			return;
		}

		wait(0.4);
	}
}

//Function Number: 70
func_9068()
{
	var_00 = level.var_EBBB;
	var_00 thread scripts\sp\_utility::func_7799(level.player,2,2);
	scripts\common\utility::flag_wait("base_stairs_bottom");
	var_00 scripts\sp\_utility::func_61E7();
	var_00 scripts\sp\_utility::func_77B9(1.25);
	var_01 = scripts\common\utility::getstruct("seeker_arrive_hold","targetname");
	if(scripts\common\utility::flag("entering_seeker_room"))
	{
		var_00 scripts\sp\_utility::func_61C7();
		return;
	}

	level.var_EBBC.var_C9BD = 1;
	var_01 lib_0B06::func_1F17(var_00,"hold_up");
	var_01 thread lib_0B06::func_1F35(var_00,"hold_up");
	wait(1);
	var_00 scripts\sp\_utility::func_61C7();
	var_00 scripts\sp\_utility::func_5514();
}

//Function Number: 71
func_6B7F()
{
	scripts\common\utility::array_thread(getentarray("airlock_fan","targetname"),::func_6B80);
}

//Function Number: 72
func_6B80()
{
	self endon("death");
	var_00 = randomfloatrange(8,16);
	for(;;)
	{
		self rotatepitch(360,var_00);
		wait(var_00);
	}
}

//Function Number: 73
func_134E4()
{
	scripts\common\utility::flag_wait("entering_seeker_room");
	func_F158();
	scripts\common\utility::flag_wait("seeker_enemies_dead");
	wait(1.6);
	var_00 = ["europa_tee_rightclear","europa_sip_leftclear"];
	scripts\sp\maps\europa\europa_util::func_48BD(var_00);
	thread scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_fanout");
	scripts\common\utility::flag_set("squad_to_airlock");
	wait(1.5);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_sip_labsarethroughthis");
	wait(1.5);
	thread func_57B8();
	scripts\common\utility::flag_wait("airlock_closing");
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_thinktheyheardt");
	level.var_EBBB thread func_1F8B();
	wait(2.35);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_letsgivema");
	scripts\common\utility::flag_set("airlock_ready");
	if(soundexists("europa_cmp_unsarecognized"))
	{
		level.player scripts\common\utility::play_sound_in_space("europa_cmp_unsarecognized",level.player geteye() + (0,0,45));
	}
}

//Function Number: 74
func_F158()
{
	level endon("seeker_room_hot");
	level thread scripts\sp\_utility::func_C12D("seeker_pullot",1);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_sip_eyesonmultipletar");
	scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_timetogetwetse");
	scripts\sp\maps\europa\europa_util::func_134B7("europa_sip_copythat");
}

//Function Number: 75
func_F156()
{
	level.var_EF59 = 0;
	var_00 = scripts\common\utility::getstructarray("rummage_scene","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread func_E7D3();
		wait(0.05);
	}

	scripts\common\utility::flag_wait("entering_seeker_room");
	level.player.var_5966 = 1;
	thread scripts\sp\maps\europa\europa_util::func_67B6(2,"current",&"EUROPA_OBJECTIVE_FSPAR","tram_move");
	var_04 = getent("seeker_room_vol","targetname");
	var_05 = var_04 scripts\sp\_utility::func_77E3("axis");
	var_06 = scripts\common\utility::random(var_05).origin;
	thread func_E6DA();
	func_D2FC();
	if(level.player scripts\sp\_utility::func_65DB("threw_seeker"))
	{
		level.var_EBBB func_875B();
		wait(0.5);
		level.var_EBBC func_875B();
	}
	else
	{
	}

	scripts\sp\_utility::func_15F5("seekers_thrown");
	scripts\common\utility::flag_wait("seeker_room_hot");
	var_04 = getent("seeker_axis_badplace","targetname");
	var_07 = function_027B(var_04,"axis");
	if(getdvarint("debug_europa"))
	{
		iprintln("seeker room hot");
	}

	var_08 = "eu_enemy_incoming_" + randomintrange(1,4);
	function_0178(var_08,var_06);
	scripts\sp\_utility::func_28D8("axis");
	level.var_EBBB.var_180 = 0;
	level.var_EBBC.var_180 = 0;
	scripts\sp\_utility::func_13754(var_05);
	scripts\common\utility::flag_set("seeker_enemies_dead");
	scripts\sp\_utility::func_28D7("axis");
	destroynavobstacle(var_07);
	level.player.var_5966 = undefined;
	if(getdvarint("debug_europa"))
	{
		iprintln("clear");
	}

	func_2BCC();
	scripts\sp\_utility::func_10FEC("le_clouds");
	wait(2.5);
	scripts\sp\_utility::func_2669("airlock_go");
}

//Function Number: 76
func_D2FC()
{
	var_00 = level.var_7683 < 2;
	level waittill("seeker_pullot");
	if(var_00)
	{
		setomnvar("ui_hud_ability_primary",1);
		level.player giveandfireoffhand("seeker_autohold");
		level.player setweaponammostock("seeker_autohold",1);
		level.player thread scripts\sp\_utility::func_56BA("seeker_hint");
	}
	else
	{
		level.player giveweapon("seeker");
		level.player thread scripts\sp\_utility::func_56BA("seeker_hint");
	}

	if(var_00)
	{
		level.player giveweapon("seeker");
	}

	level.player setweaponammostock("seeker",4);
	setomnvar("ui_hud_ability_primary",1);
	func_137F3();
	if(var_00)
	{
		level.player takeweapon("seeker_autohold");
		if(level.player scripts\sp\_utility::func_65DB("threw_seeker"))
		{
			level.player setweaponammostock("seeker",3);
		}
		else
		{
			level.player setweaponammostock("seeker",4);
		}
	}

	wait(0.15);
}

//Function Number: 77
func_137F3()
{
	thread func_B992();
	level.player endon("threw_seeker");
	scripts\common\utility::flag_wait("seeker_room_hot");
}

//Function Number: 78
func_B992()
{
	level endon("seeker_enemies_dead");
	for(;;)
	{
		while(!level.var_F10A.var_1633.size)
		{
			wait(0.05);
		}

		foreach(var_01 in level.var_F10A.var_1633)
		{
			if(isdefined(var_01.var_222) && var_01.var_222 == level.player)
			{
				level.player scripts\sp\_utility::func_65E1("threw_seeker");
				var_01 thread func_F168();
				wait(0.05);
				return;
			}
		}

		wait(0.05);
	}
}

//Function Number: 79
func_F168()
{
	self endon("death");
	while(!isdefined(self.var_3135.var_F15D) || self.var_3135.var_F15D == self.var_222)
	{
		wait(0.05);
	}

	if(self.var_3135.var_F15D method_81A6())
	{
		self.var_3135.var_F15D endon("death");
		while(distance2dsquared(self.origin,self.var_3135.var_F15D.origin) > squared(400))
		{
			wait(0.05);
		}

		self.var_3135.var_F15D.var_1FBD notify("stop_loop");
		self.var_3135.var_F15D scripts\sp\_utility::func_1F53();
		self.var_3135.var_F15D notify("seeker_attack");
		self.var_3135.var_F15D scripts\sp\maps\europa\europa_util::func_1108E();
	}
}

//Function Number: 80
func_F15C()
{
	return level.player scripts\sp\_utility::func_65DB("threw_seeker") || scripts\common\utility::flag("seeker_enemies_dead");
}

//Function Number: 81
func_2BCC()
{
	wait(2.5);
	foreach(var_01 in level.var_F10A.var_1633)
	{
		var_01 lib_0C25::func_EA0E();
		wait(1);
	}
}

//Function Number: 82
func_875B()
{
	level endon("seeker_room_hot");
	if(distance2dsquared(self.origin,level.player.origin) > squared(500))
	{
		return;
	}

	lib_0A1E::func_2307(::func_11803);
}

//Function Number: 83
func_11803()
{
	self.var_C382 = self.var_166;
	self.var_C380 = self.var_162;
	self.var_166 = "seeker";
	self.var_162 = 1;
	thread func_F131();
	self method_8221("face point",scripts\common\utility::random(function_0072("axis")).origin);
	wait(0.25);
	self method_806F(%body,0.2);
	self method_82EA("exposed_throw_seeker",%hm_grnd_org_exposed_seeker_throw01,1,0.2,lib_0C6A::func_6B9A());
	var_00 = "exposed_throw_seeker";
	thread lib_0A1E::func_231F("soldier",var_00);
	var_01 = "seeker_grenade_folded";
	var_02 = undefined;
	var_03 = 0;
	var_04 = lib_0C6A::func_810E("exposed_seeker_throw");
	while(!var_03)
	{
		self waittill(var_00,var_05);
		if(!isarray(var_05))
		{
			var_05 = [var_05];
		}

		foreach(var_07 in var_05)
		{
			if(var_07 == "attach_seeker")
			{
				if(isdefined(var_04))
				{
					thread lib_0C6A::func_57E0("tag_accessory_left",var_04);
				}
				else
				{
					lib_0C6A::func_2481(var_00,var_01,"tag_accessory_left");
				}

				self.var_9E33 = 1;
			}

			if(var_07 == "grenade_throw" || var_07 == "grenade throw")
			{
				var_08 = self gettagorigin("tag_accessory_left");
				var_09 = 400;
				var_0A = anglestoforward(self.angles);
				var_0B = anglestoup(self.angles);
				var_0B = var_0B * 0.6;
				var_0C = vectornormalize(var_0A + var_0B);
				var_0D = var_0C * var_09;
				var_02 = function_0136(self.var_166,var_08,var_0D,2);
				if(isdefined(var_02))
				{
					if(self.var_162 > 0)
					{
						self.var_162--;
					}

					self notify("grenade_fire",var_02,self.var_166);
				}

				if(isdefined(self.var_F174))
				{
					self.var_F174 delete();
				}

				var_03 = 1;
				continue;
			}

			if(var_07 == "end")
			{
				self.var_1652.player.var_C231--;
				self notify("dont_reduce_giptp_on_killanimscript");
			}
		}
	}

	self.var_166 = self.var_C382;
	self.var_162 = self.var_C380;
}

//Function Number: 84
func_F131()
{
	while(!isdefined(self.var_F10A))
	{
		wait(0.05);
	}

	self.var_F10A.health = 3000;
	self.var_F10A thread scripts\sp\_utility::func_B14F();
}

//Function Number: 85
func_E7D3()
{
	self endon("seeker_attack");
	var_00 = getspawner("rummage_spawner","targetname");
	var_00.var_C1 = 1;
	var_01 = var_00 scripts\sp\_utility::func_10619(1);
	var_01.var_1FBB = "generic";
	var_02 = strtok(self.var_EE79," ");
	var_01.var_1FBD = self;
	lib_0B06::func_1EC3(var_01,var_02[0]);
	var_01.health = 40;
	var_01.var_72CC = 2;
	var_01.var_162 = 0;
	scripts\common\utility::flag_wait("entering_seeker_room");
	if(!isdefined(var_01) || !isalive(var_01))
	{
		return;
	}

	var_01 thread func_3D9C();
	var_01 thread scripts\sp\maps\europa\europa_util::func_10F49();
	var_01.var_4E46 = ::func_EF56;
	var_03 = 0;
	if(isarray(level.var_EC85[var_01.var_1FBB][var_02[0]]))
	{
		var_03 = 1;
	}

	if(var_03)
	{
		var_01 endon("death");
		thread lib_0B06::func_1EEA(var_01,var_02[0]);
		func_1373B();
		self notify("stop_loop");
		if(getdvarint("debug_europa"))
		{
		}
	}
	else
	{
		lib_0B06::func_1F35(var_01,var_02[0]);
	}

	var_01 lib_0B06::func_1F35(var_01,var_02[1]);
	var_01 scripts\sp\maps\europa\europa_util::func_1108E();
	scripts\common\utility::flag_set("seeker_room_hot");
	if(!level.player scripts\sp\_utility::func_65DB("threw_seeker"))
	{
		var_01.var_2894 = var_01.var_2894 * 1.5;
		var_01.health = var_01.health + 110;
	}

	var_01 thread func_5775();
}

//Function Number: 86
func_3D9C()
{
	self endon("death");
	var_00 = "melee_seeker_attack_soldier_victim";
	for(;;)
	{
		if(lib_0A1A::func_233A(self.var_238F) == var_00)
		{
			scripts\common\utility::flag_set("seeker_attacked");
			return;
		}

		wait(0.1);
	}
}

//Function Number: 87
func_E6DA()
{
	var_00 = 0.3;
	scripts\common\utility::flag_wait("seeker_attacked");
	if(getdvarint("debug_europa"))
	{
		iprintln("Seeker attacked - going hot");
	}

	scripts\common\utility::flag_set("seeker_room_hot");
}

//Function Number: 88
func_1373B()
{
	level endon("seeker_room_hot");
	self waittill("stealthlight_attack");
}

//Function Number: 89
func_EF56()
{
	scripts\common\utility::flag_set("seeker_room_hot");
	if(level.var_EF59 == 3)
	{
		return 0;
	}

	self.ignoreme = 1;
	var_00 = 0;
	var_01 = getmovedelta(%hm_grnd_org_long_death_stand_trans_to_crawl,0,1);
	var_02 = self method_81E7(var_01);
	var_00 = self method_8200(var_02);
	if(var_00)
	{
		var_03 = getspawner("rummage_spawner","targetname");
		var_03.var_C1++;
		var_04 = var_03 scripts\sp\_utility::func_10619(1);
		if(scripts\sp\_utility::func_106ED(var_04))
		{
			wait(0.05);
			var_04 = var_03 scripts\sp\_utility::func_10619(1);
			if(scripts\sp\_utility::func_106ED(var_04))
			{
				level.var_EF59--;
				return 0;
			}
		}

		self.var_C012 = 1;
		level.var_EF59++;
		var_04 func_AFDF();
		var_04 method_80F1(self.origin,self.angles,10000);
		var_05 = spawnstruct();
		var_05.origin = self.origin;
		var_05.angles = self.angles;
		var_04 show();
		self delete();
		var_05 lib_0B06::func_1F35(var_04,"scripted_long_death_start",undefined,undefined,"generic");
		var_04 thread func_EF58();
		var_04 thread func_1CF6();
		var_04 func_EF57();
		var_04 lib_0B06::func_1F35(var_04,"scripted_long_death_die",undefined,undefined,"generic");
		var_04.var_DC1A = 1;
		var_04 scripts\sp\_utility::func_1101B();
		var_04.var_30 = 1;
		var_04.var_1491.var_C043 = 1;
		var_04 method_81D0();
		return 1;
	}

	return 0;
}

//Function Number: 90
func_1CF6()
{
	self endon("executed");
	for(;;)
	{
		foreach(var_01 in level.var_EBCA)
		{
			if(distance2d(self.origin,var_01.origin) < 325)
			{
				self.ignoreme = 0;
				return;
			}
		}

		wait(0.25);
	}
}

//Function Number: 91
func_AFDF()
{
	self.var_5966 = 1;
	self.var_C012 = 1;
	self.var_180 = 1;
	self.ignoreme = 1;
	thread scripts\sp\_utility::func_B14F();
	scripts\sp\_utility::func_86E4();
	scripts\sp\_utility::func_F2DA(0);
	self.var_30 = 0;
	self.var_1491.var_C043 = 0;
	self hide();
}

//Function Number: 92
func_EF57()
{
	self endon("executed");
	for(;;)
	{
		var_00 = getmovedelta(%hm_grnd_org_long_death_crawl01,0,1);
		var_01 = self method_81E7(var_00);
		self.var_3898 = self method_8200(var_01);
		if(!self.var_3898)
		{
			self notify("executed");
		}

		lib_0B06::func_1F35(self,"scripted_long_death_crawl",undefined,undefined,"generic");
	}
}

//Function Number: 93
func_EF58()
{
	self endon("executed");
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(isdefined(var_01) && var_01 == level.player)
		{
			self notify("executed");
		}

		if(isdefined(var_01) && scripts\common\utility::func_2286(level.var_EBCA,var_01))
		{
			self.ignoreme = 1;
			self notify("executed");
		}
	}
}

//Function Number: 94
func_F11F()
{
	self endon("death");
	self.var_132 = 1;
	self.var_72CC = 2;
	self.var_C061 = 1;
	self.health = 40;
	self.var_162 = 0;
	self.var_180 = 1;
	scripts\common\utility::flag_wait("entering_seeker_room");
	thread scripts\sp\maps\europa\europa_util::func_10F49();
	thread func_3D9C();
	thread func_10FC3();
	self.var_4E46 = ::func_EF56;
	scripts\sp\_utility::func_178D(::scripts\sp\_utility::func_137AA,"stealthlight_attack");
	scripts\sp\_utility::func_178D(::scripts\common\utility::flag_wait,"seeker_room_hot");
	scripts\sp\_utility::func_57D6();
	if(getdvarint("debug_europa"))
	{
	}

	scripts\common\utility::flag_set("seeker_room_hot");
	scripts\sp\_utility::func_4145();
	self notify("stop_going_to_node");
	self.var_132 = 0;
	self.var_15C = 800;
	scripts\sp\maps\europa\europa_util::func_1108E();
	if(!level.player scripts\sp\_utility::func_65DB("threw_seeker"))
	{
		self.var_2894 = self.var_2894 * 2;
		self.health = self.health + 110;
	}

	thread func_5775();
}

//Function Number: 95
func_10FC3()
{
	self waittill("damage");
	self method_83A1();
}

//Function Number: 96
func_8463()
{
	var_00 = getent("lab_airlock_dynpath","targetname");
	var_00 connectpaths();
	var_00 notsolid();
	scripts\common\utility::trigger_on("enter_airlock_color_move","targetname");
	wait(0.05);
	scripts\sp\_utility::func_15F5("enter_airlock_color_move");
	var_01 = scripts\common\utility::getstruct("lab_airlock_scene","targetname");
	foreach(var_03 in level.var_EBCA)
	{
		var_03.var_C9BD = 1;
		var_03 scripts\sp\_utility::func_5514();
	}

	var_05 = level.var_EBBC;
	var_01 lib_0B06::func_1F17(var_05,"lab_airlock_close_intro");
	var_01 lib_0B06::func_1F35(var_05,"lab_airlock_close_intro");
	var_01 thread lib_0B06::func_1EEA(var_05,"lab_airlock_close_idle");
	var_06 = getent("lab_entrance_door","targetname");
	var_07 = getent("lab_entrance_airlock_trig","targetname");
	var_08 = [level.player,level.var_EBBB];
	func_1378A(var_07,var_08);
	scripts\sp\_utility::func_2669("in_airlock");
	scripts\common\utility::func_227D(getentarray("airlock_fan","targetname"),::delete);
	var_09 = function_0083();
	foreach(var_0B in var_09)
	{
		if(isdefined(var_0B.origin))
		{
			if(distance2dsquared(var_0B.origin,var_01.origin) < squared(100))
			{
				var_0B delete();
			}
		}
	}

	var_0D = getent("lab_entrance_airlock_playerclip","targetname");
	var_0D show();
	var_0D solid();
	var_0E = [var_05,var_06];
	level.player method_82C0("europa_airlock_room",3);
	var_06 scripts\common\utility::func_5127(1,::scripts\sp\_utility::func_CE2F,"airlock_entry_door_close");
	var_01 notify("stop_loop");
	scripts\common\utility::flag_set("airlock_closing");
	var_01 thread lib_0B06::func_1F2C(var_0E,"lab_airlock_close");
	wait(4.9);
	var_05 scripts\sp\_utility::func_61C7();
	level.player playsound("airlock_pressurize_lr");
	function_02A9("atmosphere","",3);
	foreach(var_03 in level.var_EBCA)
	{
		var_03.var_C9BD = undefined;
		var_03 scripts\sp\_utility::func_61E7();
	}

	var_11 = scripts\common\utility::getstructarray("airlock_fx","targetname");
	foreach(var_13 in var_11)
	{
		var_14 = undefined;
		if(isdefined(var_13.angles))
		{
			var_14 = anglestoforward(var_13.angles);
		}

		var_15 = 0;
		if(isdefined(var_13.script_delay))
		{
			var_15 = var_13.script_delay;
		}

		scripts\common\utility::func_C0A6(var_15,::playfx,scripts\common\utility::getfx(var_13.script_fxid),var_13.origin,var_14);
	}
}

//Function Number: 97
func_1AE2()
{
	var_00 = getentarray("europa_lights_airlock_green","targetname");
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC86);
	var_00 = getentarray("europa_lights_airlock_red","targetname");
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC87,30);
	var_01 = getentarray("europa_lights_airlock_red2","targetname");
	scripts\common\utility::array_thread(var_01,::scripts\sp\maps\europa\europa_util::func_AC87,7);
	scripts\common\utility::flag_wait("airlock_closing");
	wait(6);
	var_02 = getscriptablearray("airlock_monitor","targetname");
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","0","1");
	wait(0.5);
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","1","2");
	wait(0.5);
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","2","3");
	wait(0.5);
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","3","4");
	wait(0.5);
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC87,28);
	scripts\common\utility::array_thread(var_01,::scripts\sp\maps\europa\europa_util::func_AC87,7);
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","4","5");
	wait(0.5);
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC87,25);
	scripts\common\utility::array_thread(var_01,::scripts\sp\maps\europa\europa_util::func_AC87,7);
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","5","6");
	wait(0.5);
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC87,20);
	scripts\common\utility::array_thread(var_01,::scripts\sp\maps\europa\europa_util::func_AC87,6);
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","6","7");
	wait(0.5);
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC87,15);
	scripts\common\utility::array_thread(var_01,::scripts\sp\maps\europa\europa_util::func_AC87,5);
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","7","8");
	wait(0.5);
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC87,10);
	scripts\common\utility::array_thread(var_01,::scripts\sp\maps\europa\europa_util::func_AC87,3);
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","8","9");
	wait(0.5);
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC87,5);
	scripts\common\utility::array_thread(var_01,::scripts\sp\maps\europa\europa_util::func_AC87,1);
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","9","10");
	wait(0.5);
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC87,1);
	scripts\common\utility::array_thread(var_01,::scripts\sp\maps\europa\europa_util::func_AC87,0.5);
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","10","11");
	wait(0.5);
	scripts\sp\maps\europa\europa_util::func_EF3F(var_02,"root","11","12");
	var_00 = getentarray("europa_lights_airlock_red","targetname");
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC86);
	var_01 = getentarray("europa_lights_airlock_red2","targetname");
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC86);
	var_00 = getentarray("europa_lights_airlock_green","targetname");
	scripts\common\utility::array_thread(var_00,::scripts\sp\maps\europa\europa_util::func_AC87,40);
}

//Function Number: 98
func_1AC0(param_00,param_01)
{
	if(isdefined(param_00))
	{
		wait(getanimlength(param_01 scripts\sp\_utility::func_7DC1(param_00)));
	}
	else
	{
		wait(6);
	}

	level.var_1AB3 disconnectpaths();
	param_01 scripts\sp\_utility::func_61C7();
}

//Function Number: 99
func_94E6()
{
	var_00 = getent("lab_entrance_door","targetname");
	var_00 method_83D0(#animtree);
	var_00.var_1FBB = "door";
	var_00 thread lib_0B06::func_1EC3(var_00,"lab_airlock_close");
	var_01 = getent("lab_airlock_dynpath","targetname");
	var_01 connectpaths();
	var_01 notsolid();
	function_027B(var_01,"allies");
	level.var_1AB3 = var_01;
	thread func_1AE2();
}

//Function Number: 100
func_A76E()
{
	scripts\common\utility::trigger_on("enter_airlock_color_move","targetname");
	level.player giveweapon("seeker");
	level.player setweaponammostock("seeker",4);
}

//Function Number: 101
func_A746()
{
	function_01C5("sm_roundrobinpriorityspotshadows",8);
	scripts\sp\maps\europa\europa_util::func_107C5();
	scripts\sp\maps\europa\europa_util::func_6244(1);
	thread scripts\sp\maps\europa\europa_util::func_8E46(1);
	level.player scripts\sp\maps\europa\europa_util::func_8E34(1);
	scripts\sp\maps\europa\europa_util::func_EBC7();
	scripts\common\utility::flag_set("player_did_alt_scope");
	scripts\sp\_utility::func_F5AF("lab_airlock_start",[level.var_EBBB,level.var_EBBC,level.player]);
	wait(0.1);
	scripts\sp\_utility::func_15F5("enter_airlock_color_move");
	thread scripts\sp\maps\europa\europa_util::func_67B6(1,"done",&"EUROPA_OBJECTIVE_ACCESS");
	thread scripts\sp\maps\europa\europa_util::func_67B6(2,"current",&"EUROPA_OBJECTIVE_FSPAR","tram_move");
}

//Function Number: 102
func_A744()
{
	thread scripts\sp\maps\europa\europa_util::func_10690("lab_airlock");
	if(isdefined(level.var_4074) && isdefined(level.var_4074["lab_exterior"]))
	{
		scripts\sp\_utility::func_4074("lab_exterior");
	}

	foreach(var_01 in level.var_EBCA)
	{
		var_01.var_C380 = var_01.var_162;
		var_01.var_162 = 0;
		var_01.var_166 = "none";
		var_01.var_163 = 0;
	}

	scripts\sp\maps\europa\europa_util::func_8E72("base_armory_vista_02");
	var_03 = getentarray("base_reveal_vista","targetname");
	scripts\common\utility::func_227D(var_03,::hide);
	scripts\sp\_utility::func_22CA("locker_enemies",::func_AF07);
	thread func_134E3();
	scripts\sp\maps\europa\europa_util::func_13815("lab_entrance_airlock_trig");
	var_04 = scripts\common\utility::getstructarray("locker_scenes","script_noteworthy");
	var_05 = scripts\sp\_utility::func_22CD("locker_enemies",1);
	thread func_200E(var_05);
	var_06 = func_F8BF();
	wait(1.5);
	scripts\common\utility::flag_wait("player_did_alt_scope");
	if(scripts\sp\_utility::func_93A6())
	{
		lib_0B78::func_F53C(1);
	}

	level.player thread lib_0E4B::func_1348D();
	var_06.var_99F4 lib_0E46::func_48C4();
	var_06.var_99F4 waittill("trigger");
	level.player method_80D1();
	level.player scripts\common\utility::func_5127(1.55,::scripts\sp\maps\europa\europa_util::func_134B7,"europa_plr_antigravoutonmy");
	thread scripts\sp\maps\europa\europa_util::func_8E46(0);
	level.var_EBBB thread func_2014(var_04);
	level.player thread func_2016(var_06);
	wait(0.4);
	level.player scripts\common\utility::delaycall(4.2,::method_82C0,"europa_post_airlock_hallway",1);
	level.player scripts\common\utility::delaycall(5.5,::method_8070,3);
	var_06 thread lib_0B06::func_1F2C(var_06.var_1684,"antigrav_breach");
	var_06.var_99F4 lib_0E46::func_DFE3();
	var_06.var_421F delete();
	var_06.var_4220 delete();
	thread scripts\sp\maps\europa\europa_util::func_10690("lab_walk");
	scripts\common\utility::flag_wait("antigrav_detonates");
	thread scripts\sp\_utility::func_6E7C("player_crossing_bridge",::scripts\common\utility::flag_set,"straggler_dead");
	foreach(var_01 in level.var_EBCA)
	{
		var_01.var_C9BD = undefined;
		var_01 scripts\sp\_utility::func_61E7();
	}

	thread func_CD69();
	thread func_EBCC();
	level.player method_80A1();
	scripts\sp\_utility::func_13753(var_05);
	scripts\common\utility::flag_set("airlock_enemies_dead");
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_DC45,"raise");
	scripts\common\utility::flag_wait("antigrav_clear");
	foreach(var_01 in level.var_EBCA)
	{
		var_01.var_162 = var_01.var_C380;
		var_01.var_166 = "frag";
		var_01.var_163 = 1;
	}

	scripts\sp\_utility::func_15F5("after_two_kill_color_move");
	var_0B = scripts\sp\_utility::func_107EA("locker_enemy_guard");
	if(isdefined(var_0B))
	{
		scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_5564);
		var_0B thread func_110DA();
		var_0B thread func_54C1();
		var_0B.health = 50;
		var_0B.var_50 = 10;
		var_0B.var_4E46 = ::func_4E31;
		var_0B.ignoreme = 1;
		var_0B.var_162 = 0;
		var_0B scripts\common\utility::func_5127(2,::scripts\sp\_utility::func_F416,0);
		return;
	}

	scripts\common\utility::flag_set("straggler_dead");
}

//Function Number: 103
func_110DA()
{
	self endon("death");
	wait(1);
	self playsound("europa_sf0_needbackupmylocation");
}

//Function Number: 104
func_18EA()
{
	if(!isdefined(self))
	{
		return;
	}

	self.health = 20;
	self endon("death");
	scripts\common\utility::func_5127(6.5,::scripts\sp\_utility::func_54C6);
}

//Function Number: 105
func_CD69()
{
	var_00 = spawn("script_origin",level.player.origin);
	wait(0.05);
	var_00 playloopsound("emt_euro_alarm_lp");
	scripts\common\utility::flag_wait("selfdestruct_start");
	var_00 stoploopsound("");
	wait(0.05);
	var_00 delete();
}

//Function Number: 106
func_4E31()
{
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_6224);
	if(isdefined(self.var_D417))
	{
		var_00 = ["europa_plr_hesdown","europa_plr_watchyourcorners"];
	}
	else
	{
		var_00 = ["europa_plr_watchyourcorners"];
	}

	scripts\common\utility::flag_set("straggler_dead");
	level scripts\common\utility::func_5127(1.1,::scripts\sp\maps\europa\europa_util::func_48BD,var_00);
	return 0;
}

//Function Number: 107
func_54C1()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(isdefined(var_01) && var_01 == level.player)
		{
			self.var_D417 = 1;
		}
	}
}

//Function Number: 108
func_134E3()
{
	if(!scripts\sp\_utility::func_9BB5())
	{
		wait(0.5);
	}

	scripts\common\utility::flag_wait("airlock_enemies_dead");
	wait(0.7);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_theyredown");
	scripts\common\utility::flag_wait("antigrav_clear");
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_movingup");
}

//Function Number: 109
func_1F8B()
{
	wait(0.1);
	var_00 = scripts\sp\_utility::func_10639("fhr40",self.origin - (0,0,100),self.angles);
	var_01 = getanimlength(scripts\sp\_utility::func_7DC2("airlock_response",self.var_1FBB));
	var_00 scripts\common\utility::delaycall(var_01,::delete);
	lib_0B06::func_1F2C([self,var_00],"airlock_response");
}

//Function Number: 110
func_EBCC()
{
	level.var_EBBB.var_595D = 1;
	level.var_EBBC.var_595D = 1;
	wait(2);
	level.var_EBBB.var_595D = undefined;
	level.var_EBBC.var_595D = undefined;
}

//Function Number: 111
func_2016(param_00)
{
	var_01 = 0.4;
	level.player thread scripts\sp\maps\europa\europa_util::func_D85C();
	level.player playerlinktoblend(param_00.var_D267,"tag_player",var_01);
	param_00.var_D267 scripts\common\utility::delaycall(var_01,::show);
	level.player scripts\common\utility::delaycall(var_01,::playerlinktodelta,param_00.var_D267,"tag_player",1,1,1,1,1,1);
	level.player scripts\common\utility::delaycall(var_01 + 0.05,::method_81DF,2,0.1,1,10,10,10,0);
	wait(param_00.var_1FB8);
	level.player unlink(1);
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player method_84FD();
	level.player scripts\sp\maps\europa\europa_util::func_8E34(0);
	level.player scripts\sp\maps\europa\europa_util::func_13013(0,1);
	level.player enableweapons();
	param_00.var_D267 delete();
}

//Function Number: 112
func_2014(param_00)
{
	level waittill("grenade_appear");
	var_01 = spawn("script_model",self gettagorigin("tag_accessory_left"));
	var_01.angles = self gettagangles("tag_accessory_left");
	var_01 linkto(self,"tag_accessory_left");
	var_01 setmodel("anti_grav_grenade_wm");
	level waittill("grenade_toss");
	var_01 delete();
	var_02 = self gettagorigin("tag_accessory_left") + (0,0,5);
	var_03 = [];
	foreach(var_05 in param_00)
	{
		var_03[var_03.size] = var_05.origin;
	}

	var_07 = scripts\common\utility::getstruct("locker_loop3","targetname").origin;
	var_08 = var_07 - var_02;
	var_09 = function_0136("antigrav",var_02,var_08 * 10,4);
	scripts\common\utility::flag_wait("door_kick");
	var_0A = function_00B3("middle_locker_guy","targetname");
	wait(0.65);
	var_0B = function_0135("antigrav",var_0A.origin,var_0A.origin,20,0);
	thread lib_0E21::func_2013(var_0B);
	var_09 delete();
	while(isdefined(var_0B))
	{
		wait(0.05);
	}

	var_05 = scripts\common\utility::getstruct("antigrav_react3","targetname");
	playfx(scripts\common\utility::getfx("ag_extra"),var_05.origin);
	scripts\common\utility::flag_set("antigrav_detonates");
	thread scripts\common\utility::func_6E3F("antigrav_clear",7);
	thread func_2019();
}

//Function Number: 113
func_2019()
{
	if(level.player scripts\sp\_utility::func_65DF("player_gravity_off") && level.player scripts\sp\_utility::func_65DB("player_gravity_off"))
	{
		return;
	}

	function_0178("slomo_whoosh",level.player.origin);
	wait(0.85);
	level.var_1031B.var_1098F = 0.55;
	scripts\sp\_utility::func_10321();
	wait(0.65);
	scripts\sp\_utility::func_10322();
}

//Function Number: 114
func_F8BF()
{
	var_00 = scripts\common\utility::getstruct("antigrav_node","targetname");
	var_00.var_421F = getent("antigrav_breach_clip_outer","targetname");
	var_00.var_4220 = getent("antigrav_breach_clip_inner","targetname");
	var_00.var_99F4 = scripts\common\utility::getstruct("antigrav_interact","targetname");
	var_00.var_5978 = getent("antigrav_breach_door","targetname");
	var_00.var_598A = scripts\common\utility::getstruct("door_collision_marker","targetname");
	var_00.var_5978.var_1FBB = "antigrav_door";
	var_00.var_5978 method_83D0(#animtree);
	func_CF55(var_00);
	var_00.var_421F linkto(var_00.var_5978);
	var_00.var_4220 linkto(var_00.var_5978);
	var_00.var_1684 = [var_00.var_D267,level.var_EBBB,var_00.var_5978];
	return var_00;
}

//Function Number: 115
func_CF55(param_00)
{
	param_00.var_D267 = scripts\sp\_utility::func_10639("player_rig",param_00.origin);
	param_00 lib_0B06::func_1EC3(param_00.var_D267,"antigrav_breach");
	param_00.var_D267 hide();
	param_00.var_1FB8 = getanimlength(%europa_airlock_plr_grav_grenade_scene);
}

//Function Number: 116
func_200E(param_00)
{
	var_01 = scripts\common\utility::getstructarray("antigrav_react","script_noteworthy");
	foreach(var_04, var_03 in var_01)
	{
		param_00[var_04] thread func_2018(var_03);
	}
}

//Function Number: 117
func_2018(param_00)
{
	self endon("death");
	self.var_1FBB = "generic";
	param_00 thread lib_0B06::func_1EC3(self,param_00.var_1FA2);
	scripts\common\utility::flag_wait("door_ajar");
	self.var_180 = 0;
	self.var_595D = undefined;
	scripts\common\utility::delaycall(randomfloatrange(0.55,1),::playsound,"stealth_sf" + randomintrange(0,4) + "_enemyalerted",self.origin);
	scripts\common\utility::flag_wait("door_kick");
	param_00 thread lib_0B06::func_1F35(self,param_00.var_1FA2);
	scripts\common\utility::flag_wait("antigrav_detonates");
	wait(0.3);
	self method_83A1();
	self.ignoreme = 0;
	self.var_2894 = 1;
}

//Function Number: 118
func_AF07()
{
	self endon("death");
	self.var_163 = 0;
	self.var_4E46 = ::func_4C9B;
	self.ignoreme = 1;
	self.var_595D = 1;
	self.var_2894 = 0.01;
}

//Function Number: 119
func_4C9B()
{
	var_00 = self.origin;
	var_01 = "generic_death_enemy_" + randomintrange(1,7);
	level thread scripts\common\utility::play_sound_in_space(var_01,var_00);
	return 0;
}

//Function Number: 120
func_1378A(param_00,param_01)
{
	if(!isarray(param_01))
	{
		param_01 = [param_01];
	}

	for(;;)
	{
		wait(0.1);
		var_02 = 1;
		foreach(var_04 in param_01)
		{
			if(!var_04 istouching(param_00))
			{
				var_02 = 0;
				break;
			}
		}

		if(var_02)
		{
			break;
		}
	}
}

//Function Number: 121
func_A76F()
{
	thread func_A765();
	var_00 = getentarray("labs_entrance_lights","targetname");
	var_00 = sortbydistance(var_00,level.player.origin);
	var_00 = scripts\common\utility::func_22BD(var_00);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] setlightintensity(0);
		wait(randomfloatrange(0,0.2));
	}

	var_02 = getentarray("labs_entrance_screens","targetname");
	foreach(var_04 in var_02)
	{
		var_05 = randomfloatrange(0,0.8);
		var_04 scripts\common\utility::delaycall(var_05,::delete);
	}

	wait(3);
	var_07 = getentarray("labs_entrance_light_models","targetname");
	var_07 = sortbydistance(var_07,level.player.origin);
	var_08 = [];
	foreach(var_0A in var_07)
	{
		var_0B = var_0A.var_EDE8;
		if(!isdefined(var_08[var_0B]))
		{
			var_08[var_0B] = [];
		}

		var_08[var_0B] = scripts\common\utility::array_add(var_08[var_0B],var_0A);
	}

	for(var_01 = 0;var_01 < var_08.size;var_01++)
	{
		foreach(var_0E in var_08[var_01])
		{
			var_0E setmodel("crr_light_overhead_01_off");
			var_0E thread scripts\sp\_utility::func_CE2F("lab_light_off");
			if(isdefined(var_0E.target))
			{
				var_0A = getent(var_0E.target,"targetname");
				var_0A setlightintensity(0);
			}
		}

		wait(0.4);
	}
}

//Function Number: 122
func_A765()
{
	var_00 = scripts\common\utility::getstructarray("lab_emergency_light","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		var_04 = var_03 scripts\common\utility::spawn_tag_origin();
		var_01[var_01.size] = var_04;
	}

	while(!scripts\common\utility::flag("armory_lights_on"))
	{
		wait(1);
		foreach(var_04 in var_01)
		{
			playfxontag(scripts\common\utility::getfx("vfx_light_emergency_flicker"),var_04,"tag_origin");
		}
	}

	scripts\common\utility::flag_wait("armory_lights_on");
	scripts\sp\_utility::func_228A(var_01);
}

//Function Number: 123
func_A745()
{
	if(scripts\sp\_utility::func_93A6())
	{
		lib_0B78::func_F53C(1);
	}

	level.player thread scripts\sp\_utility::func_DC45("raise");
	scripts\common\utility::func_227D(getentarray("airlock_fan","targetname"),::delete);
	scripts\sp\maps\europa\europa_util::func_8E72("base_armory_vista_02");
	var_00 = getentarray("base_reveal_vista","targetname");
	scripts\common\utility::func_227D(var_00,::hide);
}

//Function Number: 124
func_A797()
{
	scripts\sp\maps\europa\europa_util::func_107C5();
	scripts\common\utility::func_5127(0.6,::scripts\sp\maps\europa\europa_util::func_10690,"lab_airlock");
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_DC45,"raise");
	thread scripts\sp\maps\europa\europa_util::func_5F7C(level.var_EBCA);
	scripts\sp\maps\europa\europa_util::func_EBC7();
	scripts\sp\_utility::func_F5AF("lab_walk_start",[level.var_EBBB,level.var_EBBC,level.player]);
	scripts\sp\_utility::func_15F5("after_two_kill_color_move");
	thread scripts\sp\maps\europa\europa_util::func_67B6(1,"done",&"EUROPA_OBJECTIVE_ACCESS");
	thread scripts\sp\maps\europa\europa_util::func_67B6(2,"current",&"EUROPA_OBJECTIVE_FSPAR","tram_move");
	scripts\common\utility::flag_set("straggler_dead");
}

//Function Number: 125
func_A793()
{
	var_00 = getscriptablearray("monitors","targetname");
	scripts\sp\maps\europa\europa_util::func_EF3F(var_00,"part","healthy","healthy_blue");
	thread func_13DA2();
	thread func_134E8();
	scripts\sp\_utility::func_2669("lab_walk");
	scripts\common\utility::flag_wait("scars_spawned");
	scripts\common\utility::flag_wait("player_enters_glass_bridge");
	level.var_EBBC thread func_26AA();
	scripts\common\utility::flag_wait("straggler_dead");
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_F415,1);
	func_10F41();
	if(scripts\sp\_utility::func_93A6())
	{
		thread lib_0B78::func_2683();
	}

	scripts\common\utility::flag_wait("lab_walk_end");
}

//Function Number: 126
func_13DA2()
{
	var_00 = getent("window_c12","targetname");
	var_00 func_D6A7();
	scripts\sp\_utility::func_16AE(var_00,"office_fight");
}

//Function Number: 127
func_10F41()
{
	var_00 = [];
	var_00["prone"] = 200;
	var_00["crouch"] = 400;
	var_00["stand"] = 550;
	var_01 = [];
	var_01["prone"] = 800;
	var_01["crouch"] = 1500;
	var_01["stand"] = 3000;
	lib_0F27::func_F353(var_00,var_01);
}

//Function Number: 128
func_26AA()
{
	scripts\sp\_utility::func_54F7();
	self.target = "office_long_way";
	lib_0B77::func_8409();
	scripts\sp\_utility::func_61C7();
}

//Function Number: 129
func_11601()
{
	scripts\common\utility::flag_wait("player_enters_glass_bridge");
	wait(1);
	scripts\common\utility::play_sound_in_space("SD_2_order_action_coverme",getspawner("bridgerunners","targetname").origin);
	function_0178("SD_0_resp_ack_co_gnrc_affirm",getspawner("bridgerunners","targetname").origin);
}

//Function Number: 130
func_134E8()
{
	scripts\common\utility::flag_wait("straggler_dead");
	scripts\common\utility::flag_wait("player_enters_glass_bridge");
	level.player scripts\sp\_utility::func_D090("ges_radio");
	level.player scripts\sp\_utility::func_D2D1(140,0.5);
	level.player method_8012(0);
	func_C806();
	level.player stopgestureviewmodel("ges_radio",1);
	level.player method_8012(1);
	level.player scripts\sp\_utility::func_D2D1(190,3);
	wait(1);
	if(scripts\common\utility::flag("entering_c12_research_room"))
	{
		return;
	}

	var_00 = ["europa_tee_eyesonresearchro","europa_sip_armoryshouldben","europa_plr_thatsourtarget"];
	scripts\sp\maps\europa\europa_util::func_48BD(var_00,"entering_c12_research_room");
}

//Function Number: 131
func_30CF()
{
	self endon("death");
	if(scripts\common\utility::func_4347())
	{
		scripts\sp\_utility::func_51E1("frantic");
	}
	else
	{
		scripts\sp\_utility::func_51E1("sprint");
	}

	self.health = 40;
	self.var_4E46 = ::func_30CD;
	if(!isdefined(level.var_30CE))
	{
		level.var_30CE = self;
		self.ignoreme = 1;
		level waittill("bridgerunner_down");
		wait(2.7);
		self.ignoreme = 0;
		return;
	}

	self.ignoreme = 1;
	wait(2.7);
	self.ignoreme = 0;
}

//Function Number: 132
func_30CD()
{
	level notify("bridgerunner_down");
	return 0;
}

//Function Number: 133
func_E1C7()
{
	scripts\sp\maps\europa\europa_util::func_107C5();
	func_10F41();
	thread scripts\sp\maps\europa\europa_util::func_5F7C(level.var_EBCA);
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_DC45,"raise");
	scripts\sp\maps\europa\europa_util::func_EBC7();
	scripts\sp\_utility::func_F5AF("research_start",[level.var_EBBB,level.var_EBBC,level.player]);
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_F415,1);
	thread func_13DA2();
	thread scripts\sp\maps\europa\europa_util::func_67B6(1,"done",&"EUROPA_OBJECTIVE_ACCESS");
	thread scripts\sp\maps\europa\europa_util::func_67B6(2,"current",&"EUROPA_OBJECTIVE_FSPAR","tram_move");
}

//Function Number: 134
func_E1C3()
{
	scripts\sp\_utility::func_2669("research");
	thread func_13500();
	thread scripts\sp\maps\europa\europa_util::func_10690("office_fight");
	level.var_F10A.var_4C74 = ::func_F167;
	var_00 = scripts\common\utility::getstruct("wonder_room_walk1","targetname");
	thread func_83FA();
	thread func_1B2F();
	thread vo_ambient_sdf_research_room();
	scripts\common\utility::flag_wait("stealth_spotted");
	level.var_EBBB.var_C062 = undefined;
	level.var_EBBC.var_C062 = undefined;
	scripts\sp\_utility::func_15F5("spawn_back_office_enemies");
	scripts\common\utility::flag_set("office_fight_started");
}

//Function Number: 135
vo_ambient_sdf_research_room()
{
	level endon("research_enemies_alerted");
	level endon("office_hot");
	var_00 = ["titan_sf1_enemycontact","titan_sf2_confirmthatlast","titan_sf3_prisoner627","titan_sf4_awaitingorders","titan_sf1_sectorsweeping","titan_sf2_statusupdate","titan_sf2_shootonsight","titan_sf3_hqrevising"];
	wait(2);
	var_00 = scripts\common\utility::array_randomize(var_00);
	var_01 = lib_0F27::func_79F5("office_door_guards");
	for(;;)
	{
		foreach(var_03 in var_00)
		{
			if(scripts\common\utility::flag("office_hot"))
			{
				return;
			}

			function_0178(var_03,scripts\common\utility::random(var_01).origin);
			wait(randomintrange(8,10));
		}

		wait(0.05);
	}
}

//Function Number: 136
func_1B2F()
{
	wait(1);
	var_00 = lib_0F27::func_79F5("office_door_guards");
	scripts\common\utility::array_thread(var_00,::func_1374F);
	level waittill("research_enemies_alerted");
	scripts\common\utility::func_227D(var_00,::method_84F7,"attack",level.player,level.player.origin);
}

//Function Number: 137
func_F167()
{
	self endon("death");
	while(!isdefined(self.var_3135.var_F15D) || self.var_3135.var_F15D == self.var_222)
	{
		wait(0.05);
	}

	self.var_3135.var_F15D endon("death");
	while(distance2dsquared(self.origin,self.var_3135.var_F15D.origin) > squared(450))
	{
		wait(0.05);
	}

	self.var_3135.var_F15D.var_5951 = undefined;
	if(self.var_3135.var_F15D method_81A6())
	{
		self.var_3135.var_F15D method_83A1();
	}

	self.var_3135.var_F15D method_84F7("attack",self,self.origin);
	level notify("research_enemies_alerted");
}

//Function Number: 138
func_1374F()
{
	level endon("research_enemies_alerted");
	self waittill("damage");
	level notify("research_enemies_alerted");
}

//Function Number: 139
func_83FA()
{
	thread func_26E5();
	scripts\common\utility::func_6E4E("office_hot","axis_close");
	func_10F42();
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_F415,0);
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_F416,0);
}

//Function Number: 140
func_26E5()
{
	var_00 = getent("axis_close","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(isdefined(var_01))
		{
			var_01.var_5951 = undefined;
			foreach(var_03 in level.var_EBCA)
			{
				var_03 scripts\sp\_utility::func_F39C(var_01);
			}
		}
	}
}

//Function Number: 141
func_10F42()
{
	var_00 = [];
	var_00["prone"] = 8000;
	var_00["crouch"] = 8000;
	var_00["stand"] = 8000;
	lib_0F27::func_F353(var_00);
}

//Function Number: 142
func_13DA3(param_00)
{
	level endon("office_fight_started");
	param_00 lib_0B06::func_1F17(self,"wonder_room_walk");
	param_00 lib_0B06::func_1F35(self,"wonder_room_walk");
	scripts\sp\_utility::func_61C7();
}

//Function Number: 143
func_E1C4()
{
	level.var_EBBB.var_C062 = undefined;
	level.var_EBBC.var_C062 = undefined;
}

//Function Number: 144
func_13500()
{
	scripts\common\utility::flag_wait("player_at_c12");
	if(!scripts\common\utility::flag("office_fight_started"))
	{
		scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_contact2");
	}
}

//Function Number: 145
func_C806()
{
	level endon("office_fight_started");
	level.player playsound("ges_plr_radio_on");
	wait(0.2);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_reaperthisis11werein");
	wait(0.05);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_rpr_copybeadvisedsdf");
	wait(0.05);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_rpr_oncetheweaponis");
	scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_copy");
	level.player playsound("ges_plr_radio_off");
}

//Function Number: 146
func_62D7(param_00,param_01)
{
	level endon("player_enters_c12_labs");
	if(isalive(param_00))
	{
		param_00 scripts\sp\_utility::func_CE2F("europa_sf1_whyisthatdoorno");
	}

	if(isalive(param_01[0]))
	{
		param_01[0] scripts\sp\_utility::func_CE2F("europa_sf3_sireverythingsfro");
	}

	if(isalive(param_00))
	{
		param_00 scripts\sp\_utility::func_CE2F("europa_sf1_whyisthatdoorno");
	}

	if(isalive(param_01[0]))
	{
		param_00 scripts\sp\_utility::func_CE2F("europa_sf1_iwanteverythingo");
	}
}

//Function Number: 147
func_E40D()
{
	var_00 = [level.var_10214,level.var_113AD];
	foreach(var_02 in var_00)
	{
		wait(randomfloatrange(1,3));
		self.var_166 = "seeker";
		self.var_162 = 1;
	}
}

//Function Number: 148
func_19CD()
{
	scripts\sp\_utility::func_51E1("casual_gun");
}

//Function Number: 149
func_19CC()
{
	scripts\sp\_utility::func_51E1("casual");
}

//Function Number: 150
func_A794()
{
	function_01C5("sm_roundrobinpriorityspotshadows",6);
}

//Function Number: 151
func_A788()
{
	scripts\sp\maps\europa\europa_util::func_107C5();
	scripts\sp\_utility::func_15F5("wonder_room_patroller_spawn");
	func_10F42();
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_DC45,"raise");
	scripts\sp\_utility::func_F5AF("start_lab_office_door",[level.var_EBBB,level.var_EBBC,level.player]);
	thread scripts\sp\maps\europa\europa_util::func_5F7C(level.var_EBCA);
	scripts\sp\maps\europa\europa_util::func_EBC7();
	var_00 = [level.var_EBBB,level.var_EBBC];
	scripts\common\utility::func_5127(1,::scripts\sp\maps\europa\europa_util::func_10690,"office_fight");
	scripts\sp\_utility::func_15F5("office_door_color_trig");
	scripts\sp\_utility::func_15F5("spawn_back_office_enemies");
	thread scripts\sp\maps\europa\europa_util::func_67B6(1,"done",&"EUROPA_OBJECTIVE_ACCESS");
	thread scripts\sp\maps\europa\europa_util::func_67B6(2,"current",&"EUROPA_OBJECTIVE_FSPAR","tram_move");
}

//Function Number: 152
func_A786()
{
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_F415,0);
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_F416,0);
	scripts\sp\_utility::func_15F5("office_door_color_trig");
	thread func_1EDA();
	thread func_3385();
	var_00 = function_0075("all","soldier");
	scripts\common\utility::array_thread(var_00,::scripts\sp\_utility::func_F2DA,1);
	thread func_134E6();
	scripts\common\utility::flag_wait("enter_office_door_area");
	scripts\sp\_utility::func_2669("soldier_combat");
	level notify("stop_catching_up");
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_5514);
	thread func_4794();
	scripts\common\utility::flag_wait("entering_office_exit");
	level notify("deploy_c6_lockers");
}

//Function Number: 153
func_134E6()
{
	scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_goloud");
	scripts\common\utility::flag_wait("back_office_enemies_dead");
	wait(1.1);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_keepusmovin");
	scripts\common\utility::flag_wait("locker_c6s_dead");
	scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_stayalertwerenotclear");
}

//Function Number: 154
func_1EDA()
{
	scripts\common\utility::array_thread(getentarray("anim_hydroponics","targetname"),::func_1FDF);
}

//Function Number: 155
func_1FDF()
{
	self endon("death");
	var_00 = randomfloatrange(30,40);
	for(;;)
	{
		self rotateroll(360,var_00);
		wait(var_00);
	}
}

//Function Number: 156
func_2726()
{
	self.var_231 = 300;
	if(level.var_7683 < 2)
	{
		self.var_162 = 0;
		return;
	}

	if(scripts\common\utility::func_4347())
	{
		self.var_162 = 0;
	}
}

//Function Number: 157
func_3385()
{
	scripts\sp\_utility::func_22CA("c6_locker_spawner",::func_AF01);
	scripts\sp\_utility::func_22CA("c6_hacker",::func_3371);
	var_00 = 1;
	var_01 = scripts\common\utility::getstructarray("c6_locker","script_noteworthy");
	level.var_AF02 = [];
	foreach(var_03 in var_01)
	{
		var_03 func_48AD();
		wait(0.06);
	}

	var_05 = 0;
	var_06 = 1;
	scripts\common\utility::flag_wait("c6_lockers_go");
	var_07 = getent("front_office_vol","targetname") scripts\sp\_utility::func_77E3("axis","human");
	if(var_07.size < 2)
	{
		var_05 = 1;
		var_06 = 1;
	}

	if(!var_05)
	{
		scripts\common\utility::flag_wait("entering_office_exit");
	}

	var_08 = ["europa_tee_wegotincoming","europa_sip_bots2"];
	if(!var_00)
	{
		thread scripts\sp\maps\europa\europa_util::func_48BD(var_08);
	}

	var_06 = !var_00;
	if(var_06)
	{
		scripts\sp\_utility::func_22CD("c6_hacker",1);
		wait(0.75);
	}

	if(!var_00)
	{
		var_09 = 0;
		foreach(var_03 in var_01)
		{
			var_09++;
			var_03 thread func_FB53(var_09);
			var_03 thread func_3383();
			if(var_09 == 1)
			{
				wait(0.5);
				function_01BA("mx_165_robotfight");
				wait(1);
				continue;
			}

			wait(0.9);
		}

		level notify("c6s_deployed");
		thread func_3400();
		foreach(var_0D in level.var_EBCA)
		{
			var_0D.var_C9BD = 1;
			var_0D scripts\sp\_utility::func_5514();
		}

		scripts\sp\_utility::func_15F5("c6_fall_back_color");
		scripts\common\utility::trigger_off("color_move_office_hallway","targetname");
		scripts\sp\_utility::func_13754(level.var_AF02);
		scripts\common\utility::flag_set("locker_c6s_dead");
		foreach(var_0D in level.var_EBCA)
		{
			var_0D.var_C9BD = undefined;
			var_0D scripts\sp\_utility::func_5514();
		}

		return;
	}

	scripts\common\utility::flag_set("locker_c6s_dead");
	scripts\common\utility::trigger_off("color_move_office_hallway","targetname");
	scripts\sp\_utility::func_15F5("engineer_office_color_move");
}

//Function Number: 158
func_67B7()
{
	scripts\sp\maps\europa\europa_util::func_1368F("office_exit_area",1);
	function_01BA("");
}

//Function Number: 159
func_3371()
{
	if(isdefined(self.target))
	{
		return;
	}

	self.var_1FBB = "generic";
	self.ignoreme = 1;
	thread scripts\sp\_utility::func_B14F();
	var_00 = scripts\common\utility::getstruct("hacker","targetname");
	self.struct = var_00;
	var_00 lib_0B06::func_1F17(self,"c6_hack_enter");
	thread func_B279();
	var_00 lib_0B06::func_1F35(self,"c6_hack_enter");
	var_00 thread lib_0B06::func_1EEA(self,"c6_hack");
	wait(3);
	self.ignoreme = 0;
	self.target = "hacker_exit";
	self.var_4E46 = undefined;
	var_00 notify("stop_loop");
	lib_0B77::func_8409();
}

//Function Number: 160
func_B279()
{
	wait(0.05);
	self method_82B1(scripts\sp\_utility::func_7DC1("c6_hack_enter"),1.7);
	wait(2);
	scripts\sp\_utility::func_1101B();
	self.var_4E46 = ::func_10FC1;
}

//Function Number: 161
func_10FC1()
{
	self method_83A1();
	self.struct notify("stop_loop");
	return 0;
}

//Function Number: 162
func_3400()
{
	var_00 = [level.player,level.var_EBBB,level.var_EBBC];
	var_00 = scripts\common\utility::array_randomize(var_00);
	var_01 = level.var_AF02;
	var_02 = 0;
	while(var_01.size)
	{
		if(!isdefined(var_00[var_02]))
		{
			var_03 = scripts\common\utility::random(var_00);
		}
		else
		{
			var_03 = var_00[var_02];
		}

		var_01 = scripts\sp\_utility::func_22BB(var_01);
		var_04 = scripts\common\utility::getclosest(var_03.origin,var_01);
		var_04.var_15C = 45;
		var_04 notify("stop_going_to_node");
		var_04 method_82ED(var_03);
		scripts\sp\_utility::func_13753([var_04]);
		wait(2);
		var_02++;
		var_01 = scripts\sp\_utility::func_22BB(var_01);
	}
}

//Function Number: 163
func_48AD()
{
	self.var_215D = scripts\sp\_utility::func_10639("locker_arm",self.origin,self.angles);
	scripts\sp\_utility::func_16AE(self.var_215D,"locker_c6s");
	thread lib_0B06::func_1EC3(self.var_215D,"locker_deploy");
}

//Function Number: 164
func_3383()
{
}

//Function Number: 165
func_520B()
{
	wait(0.05);
	self method_82B1(scripts\sp\_utility::func_7DC1("locker_deploy"),1.45);
}

//Function Number: 166
func_FB53(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case 1:
			var_01 = "scn_europa_c6_locker_deploy_01";
			break;

		case 2:
			var_01 = "scn_europa_c6_locker_deploy_02";
			break;

		case 3:
			var_01 = "scn_europa_c6_locker_deploy_03";
			break;

		case 4:
			var_01 = "scn_europa_c6_locker_deploy_04";
			break;

		default:
			var_01 = "scn_europa_c6_locker_deploy_01";
			break;
	}

	self.var_215D playsound(var_01);
}

//Function Number: 167
func_3384()
{
}

//Function Number: 168
func_AF01()
{
	self endon("death");
	self.var_1FBB = "c6";
	self.var_180 = 1;
	self.ignoreme = 1;
	self.var_162 = 0;
	thread scripts\sp\_utility::func_B14F();
	lib_0A1A::func_237A("combat","move",%c6_grnd_red_walk_forward_ar);
	scripts\sp\_utility::func_F2DA(0);
	scripts\sp\_utility::func_F3AF(0);
	scripts\sp\_utility::func_16AE(self,"locker_c6s");
	self waittill("deployed");
	self.var_180 = 0;
	self.ignoreme = 0;
	thread scripts\sp\_utility::func_1101B();
}

//Function Number: 169
func_11600()
{
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\maps\europa\europa_util::func_10FC2);
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_61C7);
	var_00 = function_00C8("back_office_enemies");
	scripts\common\utility::play_sound_in_space("eu_enemy_incoming_2",var_00[0].origin);
	function_0178("eu_enemy_incoming_3",var_00[1].origin);
}

//Function Number: 170
func_5995()
{
	scripts\common\utility::flag_wait("office_fight_started");
	foreach(var_01 in function_0072("axis"))
	{
		var_01.var_163 = 0;
	}

	var_03 = scripts\common\utility::getstruct("frag_start","targetname");
	var_04 = scripts\common\utility::getstruct("frag_end","targetname");
	var_05 = vectornormalize(var_04.origin + (0,0,95) - var_03.origin);
	var_06 = function_0136("frag",var_03.origin,var_05 * 600,4);
	while(isdefined(var_06))
	{
		wait(0.05);
	}

	foreach(var_01 in function_0072("axis"))
	{
		var_01.var_163 = 1;
	}
}

//Function Number: 171
func_33B1()
{
	self endon("death");
	thread scripts\sp\_utility::func_B14F();
	scripts\common\utility::func_5127(2.5,::scripts\sp\_utility::func_1101B);
}

//Function Number: 172
func_4794()
{
	scripts\common\utility::flag_wait("back_office_enemies_dead");
	level thread scripts\sp\maps\europa\europa_util::func_5F7C(level.var_EBCA);
}

//Function Number: 173
func_10009()
{
	var_00 = [level.var_EBBB,level.var_EBBC];
	level.var_EBBB.var_114EB = 0;
	level.var_EBBC.var_114EB = 0;
	scripts\common\utility::array_thread(var_00,::func_F3D1);
	if(level.var_EBBB.var_114EB == 1 && level.var_EBBC.var_114EB == 1)
	{
		if(!scripts\common\utility::flag("cancel_door_tap_scene"))
		{
			var_01 = scripts\common\utility::getstruct("scene_shoulder_tap","targetname");
			var_01 lib_0B06::func_1F17(level.var_EBBB,"office_enter_idle");
			var_01 thread lib_0B06::func_1EEA(level.var_EBBB,"office_enter_idle","stop_loop");
			var_01 lib_0B06::func_1F17(level.var_EBBC,"office_enter_tapgo");
			var_01 thread lib_0B06::func_1F35(level.var_EBBC,"office_enter_tapgo");
			level waittill("nt_notify_tapandgo");
			var_01 notify("stop_loop");
			var_01 thread lib_0B06::func_1F35(level.var_EBBB,"office_enter_go");
		}
	}
}

//Function Number: 174
func_F3D1()
{
	level endon("enter_cutter_area");
	self.var_114EB = 0;
	self.var_15C = 96;
	if(self == level.var_EBBB)
	{
		self method_82EE(function_00B3("scar1_touch_pos","targetname"));
	}
	else
	{
		self method_82EE(function_00B3("scar2_touch_pos","targetname"));
	}

	self waittill("goal");
	self.var_114EB = 1;
}

//Function Number: 175
func_A787()
{
}

//Function Number: 176
func_A76C()
{
	scripts\sp\maps\europa\europa_util::func_107C5();
	thread scripts\sp\maps\europa\europa_util::func_5F7C(level.var_EBCA);
	scripts\sp\maps\europa\europa_util::func_EBC7();
	scripts\common\utility::array_thread(level.var_EBCA,::scripts\sp\_utility::func_DC45,"raise");
	scripts\sp\_utility::func_F5AF("lab_engineer_office_start",[level.var_EBBB,level.var_EBBC,level.player]);
	scripts\common\utility::flag_set("entering_office_exit");
	scripts\common\utility::func_5127(1,::scripts\sp\maps\europa\europa_util::func_10690,"office_fight");
	scripts\sp\_utility::func_15F5("engineer_office_color_move");
	thread scripts\sp\maps\europa\europa_util::func_67B6(1,"done",&"EUROPA_OBJECTIVE_ACCESS");
	thread scripts\sp\maps\europa\europa_util::func_67B6(2,"current",&"EUROPA_OBJECTIVE_FSPAR","tram_move");
}

//Function Number: 177
func_A767()
{
	func_A789();
}

//Function Number: 178
func_A769()
{
	scripts\sp\maps\europa\europa_util::func_8E72("base_armory_vista");
}

//Function Number: 179
func_A78B()
{
	scripts\sp\maps\europa\europa_util::func_107C5();
	scripts\sp\maps\europa\europa_util::func_6244(1);
	scripts\sp\maps\europa\europa_util::func_EBC7();
	scripts\sp\_utility::func_F5AF("lab_office_exit_start",[level.var_EBBB,level.var_EBBC,level.player]);
}

//Function Number: 180
func_134E7()
{
	scripts\common\utility::flag_wait("enter_cutter_area");
	wait(1);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_lightemup");
	scripts\common\utility::flag_wait("cutter_bot_battle_finished");
	wait(0.7);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_targetsdown2");
	wait(1);
	scripts\sp\maps\europa\europa_util::func_134B7("europa_rpr_11wereoffthetimeline");
	scripts\sp\maps\europa\europa_util::func_D24C(["europa_plr_movingonthetargetnow"]);
	scripts\common\utility::flag_wait("scars_in_cutter_room");
	if(scripts\common\utility::func_4347())
	{
		scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_terminalsontheoth");
	}
	else
	{
		scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_webeatemtoit");
	}

	thread scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_sipescrashit");
	scripts\common\utility::flag_set("crash_door");
	scripts\sp\maps\europa\europa_util::func_8E72("base_armory_vista");
}

//Function Number: 181
func_A789()
{
	thread func_134E7();
	scripts\common\utility::flag_wait("entering_office_exit");
	level.var_F10A.var_4C74 = undefined;
	scripts\sp\_utility::func_2669("cutter_room");
	level notify("stop_grenade_think");
	var_00 = scripts\common\utility::getstruct("scene_cutter_moving_cover","targetname");
	var_01 = getent("moving_lab_desk","targetname");
	var_02 = getent("moving_lab_desk_clip_dyn","targetname");
	var_02 linkto(var_01);
	var_01.var_1FBB = "desk";
	var_01 scripts\sp\_utility::func_23B7("desk");
	function_00B3("moving_desk_node","targetname") method_80AC();
	var_03 = getent("engineer_office_enemy3","targetname") scripts\sp\_utility::func_10619(1);
	var_04 = getent("engineer_office_enemy4","targetname") scripts\sp\_utility::func_10619(1);
	var_05 = [var_03,var_04];
	foreach(var_07 in var_05)
	{
		var_07.var_1FBB = "generic";
		var_07.var_30 = 1;
	}

	thread func_67B7();
	var_00 lib_0B06::func_1ECA(var_03,"sdf_seeker_pulltable_sc");
	var_00 lib_0B06::func_1EC3(var_01,"sdf_seeker_pulltable_sc");
	thread func_13508(var_05);
	scripts\common\utility::flag_wait("enter_cutter_area");
	scripts\sp\_utility::func_15F5("engineer_office_color_move");
	thread func_F02F();
	if(isdefined(var_03))
	{
		thread ag_check(var_03);
	}

	if(isalive(var_03))
	{
		var_00 thread lib_0B06::func_1EC7(var_03,"sdf_seeker_pulltable_sc");
		var_00 thread lib_0B06::func_1F35(var_01,"sdf_seeker_pulltable_sc");
	}

	var_05 = scripts\sp\_utility::func_22B9(var_05);
	scripts\common\utility::func_1372B(level,"combat_office_exit",var_00,"sdf_seeker_pulltable_sc");
	foreach(var_07 in var_05)
	{
		if(isdefined(var_07))
		{
			var_07.var_180 = 0;
			var_07.ignoreme = 0;
		}
	}

	if(isalive(var_03))
	{
		var_0B = function_00B3("moving_desk_node","targetname");
		var_0B method_808B();
		var_03 method_82EE(var_0B);
		var_02 disconnectpaths();
	}

	if(isalive(var_04))
	{
		var_04 scripts\sp\_utility::func_4145();
		var_04 scripts\sp\_utility::func_F3DC(var_04.origin);
		var_04.var_15C = 164;
	}

	scripts\sp\_utility::func_15F5("engineer_office_color_move");
	scripts\sp\maps\europa\europa_util::func_1368F("office_exit_area",0);
	scripts\sp\_utility::func_15F5("engineer_exit_color_move");
	scripts\common\utility::func_5127(0.4,::scripts\sp\_utility::func_15F5,"engineer_exit_color_move");
	scripts\sp\_utility::func_28D7("axis");
	scripts\common\utility::flag_set("cutter_bot_battle_finished");
	func_1C08();
	scripts\common\utility::flag_wait("player_in_cutter_room");
	foreach(var_0D in level.var_EBCA)
	{
		var_0D.var_C392 = var_0D.var_253;
		var_0D.var_253 = 0;
	}

	scripts\common\utility::flag_wait("wall_cut_finished");
	scripts\common\utility::flag_wait("crash_door");
	function_01CB(0.784314,0.937255,1,2);
	thread func_BEFD();
	wait(1);
	var_0F = getentarray("extra_corridor_klaxon_light","script_noteworthy");
	scripts\common\utility::array_thread(var_0F,::scripts\sp\maps\europa\europa_armory::func_A6ED);
	scripts\sp\_utility::func_15F5("into_armory_color_move");
	scripts\common\utility::flag_wait("player_exit_office_into_armory");
	scripts\sp\maps\europa\europa_util::func_EBC4();
}

//Function Number: 182
ag_check(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		level.player waittill("grenade_fire",var_01,var_02);
		if(isdefined(var_02) && var_02 == "antigrav")
		{
			if(param_00 method_81A6())
			{
				param_00 method_83A1();
				return;
			}
		}
	}
}

//Function Number: 183
func_13508(param_00)
{
	param_00[0] scripts\sp\_utility::func_10347("europa_sf1_theyreclosing");
	param_00[0] scripts\sp\_utility::func_10347("europa_sf3_getusintherenow");
}

//Function Number: 184
func_BEFD()
{
	var_00 = getent("office_breach_door","targetname");
	var_01 = scripts\common\utility::getstruct("cutter_door_entry_scene","targetname");
	var_02 = function_00CE(var_01.origin,var_01.angles,%europa_armory_seeker_door_fall);
	var_03 = function_00CD(var_01.origin,var_01.angles,%europa_armory_seeker_door_fall);
	var_01.var_59B2 = scripts\sp\_utility::func_10639("tag_origin_mover",var_02,var_03);
	var_01.var_59B2.var_205 = var_01 scripts\common\utility::func_107CE();
	var_01.var_5978 = var_00;
	var_01.var_5978 linkto(var_01.var_59B2,"tag_origin");
	var_01.var_1684 = [level.var_EBBB,level.var_EBBC,var_01.var_59B2];
	var_01 lib_0B06::func_1F17(level.var_EBBC,"new_armory_enter");
	thread func_5994(var_01);
	var_01.var_59B2.var_205 scripts\common\utility::delaycall(10,::delete);
	var_01.var_59B2 scripts\common\utility::delaycall(10,::delete);
	var_01 lib_0B06::func_1F2C(var_01.var_1684,"new_armory_enter");
	level.var_EBBC scripts\sp\_utility::func_61C7();
	scripts\sp\_utility::func_2669("armory_in");
	foreach(var_05 in level.var_EBCA)
	{
		var_05.var_253 = scripts\common\utility::func_116D7(isdefined(var_05.var_C392),var_05.var_C392,1);
	}
}

//Function Number: 185
func_5994(param_00)
{
	scripts\common\utility::func_C0A6(1.2,::function_0178,"scn_europa_door_fall_start",param_00.var_5978.origin);
	param_00.var_5978 scripts\common\utility::delaycall(2.3,::playsound,"scn_europa_door_fall_hit");
	wait(1.2);
	thread scripts\common\utility::exploder("doorfall_sparks");
	wait(1.1);
	thread scripts\common\utility::exploder("doorfall_smoke");
	var_01 = getent("office_exit_dynpath","targetname");
	var_01 connectpaths();
	var_01 notsolid();
}

//Function Number: 186
func_1C08()
{
	var_00 = getent("allies_at_exit_vol","targetname");
	var_01 = [level.var_EBBC,level.var_EBBB];
	func_1378A(var_00,var_01);
	scripts\common\utility::flag_set("scars_in_cutter_room");
}

//Function Number: 187
func_F02F()
{
	level.var_BCDA = scripts\sp\_vehicle::func_1080C("cutter_script_vehicle");
	var_00 = getent("sdf_cutter_device","targetname");
	var_00.origin = level.var_BCDA.origin;
	var_00 linkto(level.var_BCDA);
	playfxontag(level._effect["welding"],level.var_BCDA,"tag_origin");
	level.var_BCDA startpath();
	var_00 playloopsound("scn_europa_laser_cutter_lp");
	var_00 method_83D0(#animtree);
	var_00.var_1FBB = "cutter";
	var_00 thread lib_0B06::func_1EEA(var_00,"cutter_crawl","stop_loop","tag_origin");
	scripts\common\utility::flag_wait("cutter_finished");
	var_00 stoploopsound();
	var_00 playsound("scn_europa_laser_cutter_done");
	function_0178("scn_europa_laser_cutter_smolder",var_00.origin);
	stopfxontag(level._effect["welding"],level.var_BCDA,"tag_origin");
	var_00 notify("stop_loop");
	var_00 method_83A1();
	var_00 unlink();
	var_00 movey(-2.5,0.05);
	var_00 waittill("movedone");
	var_01 = scripts\common\utility::getstruct("seeker_impulse_pos","targetname");
	var_02 = (0,-40,0);
	var_00 physics_takecontrol(1,var_01.origin,var_02);
	scripts\common\utility::flag_set("wall_cut_finished");
}

//Function Number: 188
func_A78A()
{
}

//Function Number: 189
func_1CC5()
{
	var_00 = getent(self.target,"targetname");
	var_01 = 0;
	if(isdefined(var_00.var_ED3C))
	{
		var_01 = var_00.var_ED3C;
	}

	var_02 = getent(var_00.target,"targetname");
	var_02 endon("trigger");
	self waittill("trigger");
	while(!var_00 scripts\sp\_utility::func_77E3("axis").size)
	{
		wait(1);
	}

	for(;;)
	{
		var_03 = var_00 scripts\sp\_utility::func_77E3("axis");
		if(var_03.size <= var_01)
		{
			break;
		}

		wait(0.25);
	}

	var_02 scripts\sp\_utility::script_delay();
	var_02 notify("trigger");
}

//Function Number: 190
func_1CC2(param_00)
{
	setdvarifuninitialized("ally_advance_debug",0);
	if(!getdvarint("ally_advance_debug"))
	{
		return;
	}

	foreach(var_02 in param_00)
	{
		thread scripts\sp\_utility::func_5B29(var_02.origin,24,(1,0,0),1,0,24);
	}
}

//Function Number: 191
func_D6A7()
{
	self.var_1FBB = "script_model";
	lib_0B06::func_F64A();
	var_00 = self.var_1FA2;
	lib_0B06::func_1EC3(self,var_00,"tag_origin");
}