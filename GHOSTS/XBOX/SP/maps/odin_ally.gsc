/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\odin_ally.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 66
 * Decompile Time: 914 ms
 * Timestamp: 10/27/2023 1:36:44 AM
*******************************************************************/

//Function Number: 1
ally_start()
{
	function_0168("ammoCounterHide","1");
	thread airlock_interior_hatch();
	thread func_1D81();
	thread maps/odin_audio::func_728E();
	maps/odin_util::move_player_to_start_point("start_odin_ally");
	thread maps/odin_escape::func_5069("hide");
	thread maps/odin_anim::empty_suit_animation();
	level.ally maps\_utility::func_3DFD();
	level.ally.animname = "odin_ally";
	level.player disableweapons();
	common_scripts\utility::flag_set("player_approaching_infiltration");
	common_scripts\utility::flag_set("invasion_clear");
	thread maps\odin_fx::func_6A5C();
	maps/odin_util::actor_teleport(level.ally,"odin_ally_tp");
	thread maps/odin_intro::func_8546();
	common_scripts\utility::flag_set("clear_to_tweak_player");
	thread func_581B();
}

//Function Number: 2
func_6D5B()
{
	precacherumble("heavy_1s");
	precacherumble("light_1s");
	precacherumble("smg_fire");
	precachemodel("head_fed_space_head_c");
	precachemodel("body_fed_space_assault_b");
	precachemodel("body_fed_space_assault_a");
	precachestring(&"PLATFORM_ODIN_STRUGGLE_FAIL");
	precachestring(&"PLATFORM_ODIN_STRUGGLE_FAIL_ALT");
	precachestring(&"ODIN_STRUGGLE_FAIL_PC");
}

//Function Number: 3
func_6D56()
{
	common_scripts\utility::func_3385("ally_clear");
	common_scripts\utility::func_3385("play_invader_scene");
	common_scripts\utility::func_3385("invader_scene_begin");
	common_scripts\utility::func_3385("open_airlock_door");
	common_scripts\utility::func_3385("start_player_animating");
	common_scripts\utility::func_3385("prepare_anim_round_hatch");
	common_scripts\utility::func_3385("first_encounter_dialogue");
	common_scripts\utility::func_3385("ally_gun_struggle_FOV_change");
	common_scripts\utility::func_3385("stop_struggle_rotate");
	common_scripts\utility::func_3385("struggle_has_started");
	common_scripts\utility::func_3385("spin_player_and_enemy");
	common_scripts\utility::func_3385("player_shoot_anims");
	common_scripts\utility::func_3385("struggle_grunt");
	common_scripts\utility::func_3385("saved_ally");
	common_scripts\utility::func_3385("teleport_player_to_z_trans");
	common_scripts\utility::func_3385("player_second_z_turn");
	common_scripts\utility::func_3385("kyra_ally_vo_01");
	common_scripts\utility::func_3385("ally_out_of_z");
	common_scripts\utility::func_3385("post_z_push_cancel");
	common_scripts\utility::func_3385("lock_post_z_room");
	common_scripts\utility::func_3385("unlock_post_z_room");
	common_scripts\utility::func_3385("lock_first_z_trans_door");
	common_scripts\utility::func_3385("unlock_first_z_trans_door");
	common_scripts\utility::func_3385("open_post_infil_door");
	common_scripts\utility::func_3385("open_enemy_door");
	common_scripts\utility::func_3385("lock_z_hall_close_door");
	common_scripts\utility::func_3385("unlock_z_hall_close_door");
	common_scripts\utility::func_3385("lock_post_infil_auto_door");
	common_scripts\utility::func_3385("unlock_post_infil_auto_door");
	common_scripts\utility::func_3385("lock_escape_door_blocker");
	common_scripts\utility::func_3385("unlock_escape_door_blocker");
	common_scripts\utility::func_3385("switched_sticks");
}

//Function Number: 4
func_6D58()
{
	maps\_utility::add_hint_string("ally_struggle_fail",&"PLATFORM_ODIN_STRUGGLE_FAIL",::func_5838);
	maps\_utility::add_hint_string("ally_struggle_fail_alt",&"PLATFORM_ODIN_STRUGGLE_FAIL_ALT",::func_5838);
	maps\_utility::add_hint_string("ally_struggle_fail_PC",&"ODIN_STRUGGLE_FAIL_PC",::func_5838);
}

//Function Number: 5
func_5838()
{
	if(common_scripts\utility::flag("saved_ally") || common_scripts\utility::flag("switched_sticks"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
ally_main()
{
	common_scripts\utility::flag_set("unlock_post_infil_auto_door");
	common_scripts\utility::flag_set("unlock_escape_door_blocker");
	level.ally method_8222(1);
	thread ally_cleanup(0);
	maps\_utility::autosave_by_name("ally_begin");
	thread ally_setup();
	thread ally_dialogue();
	level.ally ally_invasion_scene_approach();
	hallway_encounter();
	thread maps/odin_escape::escape_setup();
	common_scripts\utility::flag_wait("ally_clear");
}

//Function Number: 7
ally_setup()
{
	function_0168("ragdoll_max_life",90000);
	thread maps/odin_util::create_sliding_space_door("first_z_trans_door_to_close",1,0,0,0,"lock_first_z_trans_door","unlock_first_z_trans_door");
	thread maps/odin_util::create_sliding_space_door("z_hall_close_door",1,0,0,0,"lock_z_hall_close_door","unlock_z_hall_close_door");
	thread maps/odin_util::create_sliding_space_door("post_infil_auto_door",1,0,0,0,"lock_post_infil_auto_door","unlock_post_infil_auto_door");
	thread maps/odin_util::create_sliding_space_door("escape_door_blocker",1,0,0,0,"lock_escape_door_blocker","unlock_escape_door_blocker");
	thread maps/odin_escape::create_escape_doors();
}

//Function Number: 8
ally_dialogue()
{
	common_scripts\utility::flag_wait("player_approaching_infiltration");
	common_scripts\utility::flag_wait("play_invader_scene");
	common_scripts\utility::func_337C("clear_to_tweak_player");
	common_scripts\utility::flag_wait("player_at_airlock");
	common_scripts\utility::flag_set("invader_scene_begin");
	maps\_utility::func_62C7();
	maps\_utility::func_252F(3,::maps\_utility::func_62C7);
	maps\_utility::smart_radio_dialogue("odin_pyl_translatedmovein");
	wait(1.5);
	maps\_utility::smart_radio_dialogue("odin_cub_emergencyfoothold");
	maps\_utility::smart_radio_dialogue("odin_cub_federationsoldiersonthe");
	common_scripts\utility::flag_set("objective_shutdown_sat");
	maps\_utility::smart_radio_dialogue("odin_atl_odinmainthisis");
	common_scripts\utility::flag_set("invasion_clear");
	maps\_utility::smart_radio_dialogue("odin_cub_atlasmainrepeatthey");
	if(!common_scripts\utility::flag("first_encounter_dialogue"))
	{
		maps\_utility::smart_radio_dialogue("odin_kyr_weneedtomove");
	}

	if(!common_scripts\utility::flag("first_encounter_dialogue"))
	{
		thread maps\_utility::smart_radio_dialogue("odin_red_galleytoodincontrol");
	}

	common_scripts\utility::flag_wait("first_encounter_dialogue");
	maps\_utility::smart_radio_dialogue("odin_kyr_argh");
	level.var_5CFF = 1;
	maps\_utility::smart_radio_dialogue("odin_kyr_lookout");
	common_scripts\utility::flag_wait("struggle_has_started");
	wait(0.025);
	level.struggle_guy thread maps\_anim::anim_single_solo(level.struggle_guy,"odin_pyl_translatednostopno");
	wait(3.1);
	common_scripts\utility::flag_wait("saved_ally");
	wait(1);
	maps\_utility::smart_radio_dialogue("odin_ast1_houstontheyrefederation");
	thread maps/odin_audio::sfx_odin_spinup();
	maps\_utility::smart_radio_dialogue("odin_shq_odincontrolodinis");
	level.fake_kyra maps\_space_ai::func_762D("odin_kyr_weneedanopsstation","odin_kyr_weneedanopsstation");
	maps\_utility::smart_radio_dialogue("odin_us2_odincontrolenemiesare");
}

//Function Number: 9
squad_kill(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isalive(var_02))
		{
			var_02 method_82E7();
		}
	}
}

//Function Number: 10
func_0A90()
{
	thread maps/odin_audio::func_7341();
	wait(10);
	common_scripts\utility::flag_set("open_airlock_door");
	common_scripts\utility::flag_set("objective_return_to_station_complete");
}

//Function Number: 11
func_581B()
{
	thread func_60C4();
	thread invasion_door_anim();
	thread func_2EA5();
	var_00 = enemy_squad_spawn("intro_bad_guys_",5,"intro_bad_guys_tp_");
	var_01 = getent("invasion_round_hatch","targetname");
	var_02 = 1;
	foreach(var_04 in var_00)
	{
		var_04.ignoreall = 1;
		var_04.animname = "odin_invader_0" + var_02;
		var_04.diequietly = 1;
		var_04 maps\_utility::func_3DFD();
		var_04 maps\_utility::func_34E3(level.player.var_8D96,"primary");
		var_02 = var_02 + 1;
		level.ally_ent_del[level.ally_ent_del.size] = var_04;
		var_04 setmodel("body_fed_space_assault_a");
	}

	var_06 = maps/odin_util::func_7805("intro_room_victim",1);
	var_02 = 1;
	foreach(var_08 in var_06)
	{
		var_08.animname = "odin_victim_0" + var_02;
		var_02 = var_02 + 1;
		var_08 maps\_utility::func_3DFD();
		var_08.diequietly = 1;
		var_08.ignoreall = 1;
		var_08.var_29AA = 1;
		var_08.var_5650 = 1;
		level.ally_ent_del[level.ally_ent_del.size] = var_08;
	}

	var_00[3] hidepart("tag_silencer");
	var_06[0].name = "";
	var_06[2].name = "";
	var_0A = getent("intro_breach_origin","targetname");
	var_0B = [];
	var_0B["odin_invader_01"] = var_00[0];
	var_0B["odin_invader_02"] = var_00[1];
	var_0B["odin_invader_03"] = var_00[2];
	var_0B["odin_invader_04"] = var_00[3];
	var_0B["odin_invader_05"] = var_00[4];
	var_0C = [];
	var_0C["odin_victim_01"] = var_06[0];
	var_0C["odin_victim_03"] = var_06[2];
	var_0A maps\_anim::anim_first_frame(var_0B,"odin_infiltrate");
	var_0A maps\_anim::anim_first_frame(var_0C,"odin_infiltrate");
	var_0A thread maps\_anim::anim_loop(var_0C,"odin_infiltrate_idle","stop_infil_idle");
	var_0A thread maps\_anim::anim_loop_solo(var_06[1],"odin_infiltrate_idle","stop_infil_idle_extra");
	common_scripts\utility::flag_wait("play_invader_scene");
	var_0A notify("stop_infil_idle_extra");
	thread func_43DE(var_0A,var_06[1]);
	common_scripts\utility::flag_wait("invader_scene_begin");
	level notify("stop_idle_logic");
	var_0C["odin_victim_02"] = var_06[1];
	thread maps/odin_audio::func_7322();
	common_scripts\utility::flag_set("lock_post_infil_auto_door");
	common_scripts\utility::flag_set("no_push_zone");
	level.player allowsprint(0);
	thread maps/odin_audio::func_723A();
	var_0A notify("stop_infil_idle");
	var_0A notify("stop_infil_extra_idle");
	foreach(var_0E in var_0C)
	{
		thread func_899E(var_0A,var_0E);
	}

	var_0A maps\_anim::anim_single(var_0B,"odin_infiltrate");
	foreach(var_04 in var_00)
	{
		var_04 delete();
	}

	common_scripts\utility::flag_wait("player_second_z_turn");
	foreach(var_08 in var_06)
	{
		if(isalive(var_08))
		{
			var_08 method_82E7();
		}
	}
}

//Function Number: 12
func_43DE(param_00,param_01)
{
	level endon("stop_idle_logic");
	var_02 = randomintrange(2,5);
	param_01 thread maps/odin_util::dialogue_facial("odin_gs1_budgivemea","odin_gs1_budgivemea");
	for(;;)
	{
		var_02 = randomintrange(2,5);
		param_00 notify("stop_infil_idle_extra");
		param_00 thread maps\_anim::anim_loop_solo(param_01,"odin_infiltrate_wave","stop_infil_idle_extra");
		wait(3);
		param_00 notify("stop_infil_idle_extra");
		param_00 thread maps\_anim::anim_loop_solo(param_01,"odin_infiltrate_idle","stop_infil_idle_extra");
		wait(var_02);
	}
}

//Function Number: 13
func_899E(param_00,param_01)
{
	param_00 thread maps\_anim::anim_single_solo(param_01,"odin_infiltrate");
	param_01 method_82E7();
}

//Function Number: 14
func_5E59()
{
	if(common_scripts\utility::flag("invasion_ok_to_anim_player"))
	{
		var_00 = maps\_utility::func_777F("player_rig");
		level.ally_ent_del[level.ally_ent_del.size] = var_00;
		var_01 = getent("anim_entrance_to_infiltrate","script_noteworthy");
		var_00 hide();
		var_02 = [];
		var_02["player_rig"] = var_00;
		var_01 maps\_anim::anim_first_frame(var_02,"odin_infiltrate_player");
		var_03 = distance2d(level.player.origin,var_00.origin);
		thread func_5E82(var_00);
		wait(0.75);
		var_01 maps\_anim::anim_single(var_02,"odin_infiltrate_player");
		level.player unlink();
		var_00 delete();
		thread func_60C5();
		common_scripts\utility::flag_set("clear_to_tweak_player");
	}

	level.player allowsprint(1);
	wait(2);
}

//Function Number: 15
ramp_down_push(param_00)
{
	param_00 = param_00 * (3500,1500,0);
	var_01 = param_00[0];
	var_02 = param_00[1];
	for(;;)
	{
		var_01 = var_01 - 60;
		var_02 = var_02 - 60;
		if(var_01 < 0)
		{
			var_01 = 0;
		}

		if(var_02 < 0)
		{
			var_02 = 0;
		}

		function_0168("player_swimSpeed",(var_01,var_02,0));
		if(var_02 == 0 && var_01 == 0)
		{
		}

		wait(0.05);
	}
}

//Function Number: 16
func_5E82(param_00)
{
	var_01 = 20;
	maps/odin_util::func_89A6(20,(3225.28,47453,48493),(356.753,210.604,3.4468),1.15,1.15,0,param_00);
	param_00 show();
}

//Function Number: 17
func_60C5()
{
	var_00 = getent("infil_push_back_point","targetname");
	var_01 = var_00.origin[1];
	var_02 = 0;
	var_03 = 0;
	var_04 = 1500;
	function_0168("player_swimWaterCurrent",(var_03,var_04,0));
	while(var_02 == 0)
	{
		var_05 = level.player.origin[1];
		if(var_05 - var_01 >= -32)
		{
			var_02 = 1;
		}

		wait(0.05);
	}

	for(;;)
	{
		var_04 = var_04 - 50;
		var_03 = var_03 - 50;
		if(var_04 < 0)
		{
			var_04 = 0;
		}

		if(var_03 < 0)
		{
			var_03 = 0;
		}

		if(var_04 <= 0 && var_03 <= 0)
		{
			function_0168("player_swimWaterCurrent",(0,0,0));
			break;
		}

		function_0168("player_swimWaterCurrent",(var_03,var_04,0));
		wait(0.05);
	}
}

//Function Number: 18
func_5E5A()
{
	var_00 = getent("intro_breach_origin","targetname");
	var_01 = maps\_utility::func_777F("player_rig");
	level.ally_ent_del[level.ally_ent_del.size] = var_01;
	wait(0.01);
	var_01.origin = level.player.origin - (0,0,40);
	var_01.angles = level.player.angles;
	wait(0.05);
	var_01 method_8021(level.player,"tag_origin",(0,0,-60),(0,0,0),1);
	var_02 = [];
	var_02["player_rig"] = var_01;
	level.player maps\_anim::anim_single(var_02,"odin_infiltrate_player_wipe");
	var_01 unlink();
	var_01 delete();
}

//Function Number: 19
ally_invasion_scene_approach()
{
	level.ally method_8222(1);
	var_00 = getent("anim_entrance_to_infiltrate","script_noteworthy");
	var_00 notify("stop_loop");
	maps\_utility::func_252F(1,::maps/odin_util::push_out_of_doorway,"X","<",1000,1000);
	var_00 maps\_anim::anim_single_solo(self,"odin_infiltrate_kyra_to_door");
	var_00 thread maps\_anim::anim_loop_solo(self,"odin_infiltrate_kyra_door_idle","stop_loop");
	common_scripts\utility::flag_wait("invader_scene_begin");
	var_00 notify("stop_loop");
	waittillframeend;
	level.ally maps\_utility::func_2743();
	thread maps/odin_audio::sfx_kyra_hatch(level.ally);
	var_00 maps\_anim::anim_single_solo(self,"odin_infiltrate_kyra_start");
	thread func_5E59();
	if(common_scripts\utility::flag("invasion_ok_to_anim_player"))
	{
		var_00 maps\_anim::anim_single_solo(self,"odin_infiltrate_kyra");
	}
	else
	{
		var_00 maps\_anim::anim_single_solo(self,"odin_infiltrate_kyra_no_push");
	}

	var_00 thread maps\_anim::anim_loop_solo(self,"odin_infiltrate_kyra_escape_idle","stop_loop");
	thread maps/odin_util::func_323C(var_00,"stop_loop");
	func_8A8B(128);
	common_scripts\utility::func_337C("no_push_zone");
	var_00 notify("stop_loop");
}

//Function Number: 20
func_4793(param_00)
{
	common_scripts\utility::flag_set("prepare_anim_round_hatch");
}

//Function Number: 21
invasion_door_anim()
{
	var_00 = getent("infil_main_door","targetname");
	var_01 = getent("infil_main_door_org","targetname");
	var_02 = getent("scriptednode_door","targetname");
	var_03 = maps\_utility::func_777F("space_round_hatch");
	level.ally_ent_del[level.ally_ent_del.size] = var_03;
	var_02 maps\_anim::anim_first_frame_solo(var_03,"odin_infiltrate_hatch");
	var_01 linkto(var_03,"door_DM");
	var_00 linkto(var_01);
	common_scripts\utility::flag_wait("prepare_anim_round_hatch");
	var_02 maps\_anim::anim_single_solo(var_03,"odin_infiltrate_hatch");
}

//Function Number: 22
func_8A8B(param_00)
{
	for(;;)
	{
		var_01 = distance2d(level.player.origin,level.ally.origin);
		if(var_01 <= param_00)
		{
		}

		wait(0.01);
	}
}

//Function Number: 23
shut_post_infil_door_flag(param_00)
{
	common_scripts\utility::flag_set("open_post_infil_door");
	thread maps/odin_util::push_out_of_doorway("y","<",1500,1500);
}

//Function Number: 24
func_60C4()
{
	var_00 = getent("scriptednode_door","targetname");
	var_01 = maps\_utility::func_777F("space_square_hatch");
	level.ally_ent_del[level.ally_ent_del.size] = var_01;
	var_02 = getent("post_infil_struggle_clip","targetname");
	var_03 = getent("post_infil_struggle_clip_origin","targetname");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"odin_infiltrate_escape_door");
	var_03 linkto(var_01,"tag_origin");
	var_02 linkto(var_03);
	common_scripts\utility::flag_wait("open_post_infil_door");
	thread maps/odin_audio::sfx_post_infil_door();
	var_00 maps\_anim::anim_single_solo(var_01,"odin_infiltrate_escape_door");
}

//Function Number: 25
func_5996(param_00)
{
	common_scripts\utility::flag_set("open_enemy_door");
}

//Function Number: 26
func_2EA5()
{
	var_00 = getent("scriptednode_door","targetname");
	var_01 = maps\_utility::func_777F("space_square_hatch");
	level.ally_ent_del[level.ally_ent_del.size] = var_01;
	var_00 maps\_anim::anim_first_frame_solo(var_01,"odin_infiltrate_enemy_door");
	common_scripts\utility::flag_wait("open_enemy_door");
	thread maps/odin_audio::func_72DB();
	var_00 maps\_anim::anim_single_solo(var_01,"odin_infiltrate_enemy_door");
}

//Function Number: 27
hallway_encounter()
{
	level endon("struggle_end");
	var_00 = maps\_utility::func_777F("odin_opfor");
	level.struggle_guy = var_00;
	level.ally_ent_del[level.ally_ent_del.size] = var_00;
	var_00 setmodel("body_fed_space_assault_b");
	var_01 = getent("struggle_enemy_head","targetname");
	var_02 = getent("struggle_enemy_inner_head","targetname");
	var_03 = var_00 gettagorigin("J_Spine4");
	var_04 = var_00 gettagangles("J_Spine4");
	var_01.origin = var_03;
	var_01.angles = var_04;
	var_02.origin = var_03;
	var_02.angles = var_04;
	var_01 linkto(var_00,"J_Spine4");
	var_00 attach("head_fed_space_head_c","",1);
	var_02 linkto(var_00,"J_Spine4");
	var_01 hide();
	var_02 hide();
	var_05 = getent("struggle_gun","targetname");
	var_06 = getent("struggle_dummygun","targetname");
	var_06 linkto(var_05);
	var_06 attach("weapon_acog_iw6","tag_acog_2",1);
	var_05.origin = var_00 gettagorigin("tag_weapon_right");
	var_05.angles = var_00 gettagangles("tag_weapon_right");
	var_05 linkto(var_00,"tag_weapon_right");
	playfxontag(level._effect["flashlight"],var_06,"tag_flash");
	level.player thread maps/odin_util::func_7D06(var_05);
	var_05 hide();
	level.ally.ignoreall = 1;
	level.ally method_8222(1);
	var_07 = maps\_utility::func_777F("player_rig");
	level.ally_ent_del[level.ally_ent_del.size] = var_07;
	var_07 hide();
	thread func_7D09(var_00,var_07);
	var_08 = getent("gun_struggle_intro","targetname");
	level.ally.animname = "odin_ally";
	var_00.animname = "odin_opfor";
	var_09 = [];
	var_09["odin_ally"] = level.ally;
	var_09["odin_opfor"] = var_00;
	var_08 maps\_anim::anim_single(var_09,"gun_struggle_intro");
	var_08 thread maps\_anim::anim_loop_solo(level.ally,"gun_struggle_intro_loop","end_loops");
	thread maps/odin_util::func_323C(var_08,"end_loops");
	var_08 thread maps\_anim::anim_loop_solo(var_00,"gun_struggle_intro_loop","end_loops");
	common_scripts\utility::flag_wait("gun_struggle_commence_trig");
	common_scripts\utility::func_337C("clear_to_tweak_player");
	level.player allowsprint(0);
	common_scripts\utility::flag_set("first_encounter_dialogue");
	var_08 notify("time_to_toss");
	var_09 = [];
	var_09["odin_ally"] = level.ally;
	var_09["odin_opfor"] = var_00;
	var_0A = [];
	var_0A["player_rig"] = var_07;
	var_00 thread maps/odin_audio::sfx_ally_ally_grapple();
	var_08 maps\_anim::anim_first_frame(var_0A,"gun_struggle_intro_throw");
	maps\_utility::autosave_by_name("space_shotgun");
	var_08 thread maps\_anim::anim_single(var_09,"gun_struggle_intro_throw");
	level.ally maps\_utility::func_2743();
	common_scripts\utility::flag_wait("start_player_animating");
	level.player thread maps/odin_audio::func_7221();
	var_0B = [];
	var_0B["odin_opfor"] = var_00;
	var_0C = 0;
	level.player playerlinktoblend(var_07,"tag_player",0.75,0.4);
	wait(0.75);
	level.player playerlinktodelta(var_07,"tag_player",1,0,0,0,0);
	var_07 show();
	var_08 notify("end_loops");
	common_scripts\utility::flag_set("ally_gun_struggle_FOV_change");
	var_08 maps\_anim::anim_single(var_0A,"gun_struggle_intro_throw");
	var_05 show();
	var_06 hide();
	var_08 maps\_anim::anim_first_frame(var_0A,"odin_hallway_weapon_struggle_range_player");
	var_08 maps\_anim::anim_first_frame(var_0B,"odin_hallway_weapon_struggle_range_opfor");
	var_00 method_825C(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_range_opfor"],1,0,0);
	var_07 method_825C(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_range_player"],1,0,0);
	thread func_7D08(var_07,var_00,level.ally);
	common_scripts\utility::flag_set("unlock_first_z_trans_door");
	common_scripts\utility::flag_set("unlock_z_hall_close_door");
}

//Function Number: 28
start_struggle_spin(param_00)
{
	common_scripts\utility::flag_set("spin_player_and_enemy");
}

//Function Number: 29
func_6F6D(param_00)
{
	common_scripts\utility::flag_set("start_player_animating");
}

//Function Number: 30
func_7D05(param_00)
{
}

//Function Number: 31
func_7D08(param_00,param_01,param_02)
{
	level endon("struggle_end");
	level.ally method_8225(level.ally.origin);
	level.player setcandamage(0);
	thread func_7D07();
	var_03 = getent("struggle_gun","targetname");
	var_04 = getent("struggle_gun_target","targetname");
	var_05 = getent("acog_scope_struggle","targetname");
	var_06 = 0.01;
	var_07 = 0;
	var_08 = 1;
	var_09 = "left";
	var_0A = 0;
	var_0B = 0.1;
	var_0C = var_0B;
	var_0D = 0.4;
	level.var_7D03 = 0;
	var_08 = 2;
	var_0E = 1;
	var_0F = 0;
	var_10 = 0;
	var_11 = 0;
	var_12 = 0;
	var_13 = (0,0,0);
	var_14 = 1;
	if(level.player common_scripts\utility::func_4828())
	{
	}
	else
	{
		var_12 = 1;
		level.player enablemousesteer(1);
	}

	var_03 hidepart("tag_sight_on","viewmodel_space_tar21");
	var_05.origin = var_03 gettagorigin("tag_acog_2");
	var_05.angles = var_03 gettagangles("tag_acog_2");
	var_05 linkto(var_03,"tag_acog_2");
	var_04 linkto(var_03);
	var_03.origin = param_00 gettagorigin("tag_weapon");
	var_03.angles = param_00 gettagangles("tag_weapon");
	var_03 linkto(param_00,"tag_weapon");
	common_scripts\utility::flag_set("struggle_has_started");
	level.var_7338 = 0;
	level.player thread maps/odin_audio::func_7224();
	thread func_4D07(param_01,param_00);
	thread func_5F8F(param_01,param_00,param_02);
	thread func_7741(param_01,param_00);
	thread func_3CC6();
	while(var_07 == 0)
	{
		var_15 = level.player getnormalizedcameramovement();
		if((var_15[1] > 0.15 || var_15[1] < -0.15) && var_14 == 1)
		{
			var_14 = 0;
			if(level.var_733B == 0)
			{
				level.player thread maps/odin_audio::func_7225();
			}

			level.player thread maps/odin_audio::sfx_ally_plr_grapple_loop();
		}
		else if(var_15[1] < 0.15 && var_15[1] > -0.15)
		{
			var_14 = 1;
			level.player thread maps/odin_audio::func_7226();
		}

		if(var_12 == 1)
		{
			var_15 = var_15 * -1;
			if(var_15[1] >= 0.15 || var_15[1] <= -0.15)
			{
				var_13 = var_15;
			}
			else
			{
				var_15 = var_13;
			}
		}

		if(level.var_7D03 <= 0.2 || level.var_7D03 >= 0.7)
		{
			var_08 = 2.6;
		}

		if(level.var_7D03 > 0.2 && level.var_7D03 < 0.398 && var_15[1] > 0.15)
		{
			var_0E = 1;
			var_0F = 0;
			var_08 = 0.5;
			level.player playrumbleonentity("light_1s");
		}

		if(level.var_7D03 > 0.574 && level.var_7D03 < 0.7 && var_15[1] < -0.15)
		{
			var_0E = 0;
			var_0F = 1;
			var_08 = 0.5;
			level.player playrumbleonentity("light_1s");
		}

		if(level.var_7D03 > 0.4 && level.var_7D03 < 0.55 && var_0E == 1)
		{
			if(maps\_utility::func_3A7F() == "easy" || maps\_utility::func_3A7F() == "medium")
			{
				var_08 = 1 - var_10;
			}
			else
			{
				var_08 = 3 - var_10;
			}

			level.player playrumbleonentity("heavy_1s");
			common_scripts\utility::flag_set("struggle_grunt");
		}

		if(level.var_7D03 > 0.4 && level.var_7D03 < 0.55 && var_0F == 1)
		{
			if(maps\_utility::func_3A7F() == "easy" || maps\_utility::func_3A7F() == "medium")
			{
				var_08 = 1 - var_10;
			}
			else
			{
				var_08 = 3 - var_10;
			}

			level.player playrumbleonentity("heavy_1s");
		}

		if(level.var_7D03 > 0.4 && level.var_7D03 < 0.55)
		{
			if(level.var_7D03 > 0.47)
			{
				level.var_7D03 = level.var_7D03 + 0.3 - var_10 * 0.1;
			}
			else
			{
				level.var_7D03 = level.var_7D03 - 0.3 - var_10 * 0.1;
			}

			if(var_11 == 0)
			{
				var_11 = 1;
				if(var_10 <= 0.7)
				{
					var_10 = var_10 + 0.3;
				}
			}
		}
		else
		{
			var_11 = 0;
		}

		var_0B = var_15[1] * var_08;
		if(level.var_7D03 <= 0.4 && var_15[1] < 0.15)
		{
			var_0B = -1.8;
		}

		if(level.var_7D03 >= 0.55 && var_15[1] > -0.15)
		{
			var_0B = 1.8;
		}

		var_0C = var_0C + var_0B - var_0C * var_0D;
		thread enemy_struggle_anim(param_01,var_06,var_0C);
		thread player_struggle_anim(param_00,var_06,var_0C);
		wait(var_06);
		setleveldopplerpreset(level.player.origin,0.25,1,0.1,0.25);
	}
}

//Function Number: 32
func_4D07(param_00,param_01)
{
	level endon("struggle_end");
	wait(0.1);
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 0.1;
	for(;;)
	{
		var_08 = maps\_utility::func_688C(level.var_7D02,2,0);
		if(var_08 <= 0.25)
		{
			var_02 = maps/odin_util::func_312A(-1,0,maps/odin_util::func_567D(0,0.25,var_08));
			var_02 = maps\_utility::func_688C(var_02,2,0);
			var_02 = var_02 * -1;
			thread enemy_struggle_anim_additives(param_00,var_02,0,0,var_07);
			thread func_5F31(param_01,var_02,0,0,var_07);
			var_03 = maps/odin_util::func_312A(0,1,maps/odin_util::func_567D(0,0.25,var_08));
			var_03 = maps\_utility::func_688C(var_03,2,0);
			thread func_2EF2(param_00,var_03,0,var_07);
			thread func_5F32(param_01,var_03,0,var_07);
		}

		if(var_08 > 0.25 && var_08 < 0.5)
		{
			var_05 = maps/odin_util::func_312A(0,1,maps/odin_util::func_567D(0.25,0.5,var_08));
			var_05 = maps\_utility::func_688C(var_05,2,0);
			thread enemy_struggle_anim_additives(param_00,0,0,var_05,var_07);
			thread func_5F31(param_01,0,0,var_05,var_07);
			var_03 = maps/odin_util::func_312A(-1,0,maps/odin_util::func_567D(0.25,0.5,var_08));
			var_03 = maps\_utility::func_688C(var_03,2,0);
			var_03 = var_03 * -1;
			thread func_2EF2(param_00,var_03,0,var_07);
			thread func_5F32(param_01,var_03,0,var_07);
		}

		if(var_08 > 0.5 && var_08 < 0.75)
		{
			var_05 = maps/odin_util::func_312A(-1,0,maps/odin_util::func_567D(0.5,0.75,var_08));
			var_05 = var_05 * -1;
			var_05 = maps\_utility::func_688C(var_05,2,0);
			thread enemy_struggle_anim_additives(param_00,0,0,var_05,var_07);
			thread func_5F31(param_01,0,0,var_05,var_07);
			var_04 = maps/odin_util::func_312A(0,1,maps/odin_util::func_567D(0.5,0.75,var_08));
			var_04 = maps\_utility::func_688C(var_04,2,0);
			thread func_2EF2(param_00,0,var_04,var_07);
			thread func_5F32(param_01,0,var_04,var_07);
		}

		if(var_08 >= 0.75)
		{
			var_06 = maps/odin_util::func_312A(0,1,maps/odin_util::func_567D(0.75,1,var_08));
			var_06 = maps\_utility::func_688C(var_06,2,0);
			thread enemy_struggle_anim_additives(param_00,0,var_06,0,var_07);
			thread func_5F31(param_01,0,var_06,0,var_07);
			var_04 = maps/odin_util::func_312A(-1,0,maps/odin_util::func_567D(0.75,1,var_08));
			var_04 = maps\_utility::func_688C(var_04,2,0);
			var_04 = var_04 * -1;
			thread func_2EF2(param_00,0,var_04,var_07);
			thread func_5F32(param_01,0,var_04,var_07);
		}

		wait(0.1);
	}
}

//Function Number: 33
func_2EF2(param_00,param_01,param_02,param_03)
{
	level endon("struggle_end");
	%odin_struggle_left_add;
	param_00 method_825D(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_left_opfor_add"],1,param_03,0.65);
	%odin_struggle_right_add;
	param_00 method_825D(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_right_opfor_add"],1,param_03,0.65);
}

//Function Number: 34
func_5F32(param_00,param_01,param_02,param_03)
{
	level endon("struggle_end");
	%odin_struggle_left_add;
	param_00 method_825D(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_left_player_add"],1,param_03,0.65);
	%odin_struggle_right_add;
	param_00 method_825D(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_right_player_add"],1,param_03,0.65);
}

//Function Number: 35
enemy_struggle_anim_additives(param_00,param_01,param_02,param_03,param_04)
{
	level endon("struggle_end");
	%odin_struggle_left;
	param_00 method_825D(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_left_opfor"],1,param_04,0.65);
	%odin_struggle_center;
	param_00 method_825D(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_center_opfor"],1,param_04,0.65);
	%odin_struggle_right;
	param_00 method_825D(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_right_opfor"],1,param_04,0.65);
}

//Function Number: 36
func_5F31(param_00,param_01,param_02,param_03,param_04)
{
	level endon("struggle_end");
	%odin_struggle_left;
	param_00 method_825D(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_left_player"],1,param_04,0.65);
	%odin_struggle_center;
	param_00 method_825D(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_center_player"],1,param_04,0.65);
	%odin_struggle_right;
	param_00 method_825D(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_right_player"],1,param_04,0.65);
}

//Function Number: 37
enemy_struggle_anim(param_00,param_01,param_02)
{
	level endon("struggle_end");
	param_00 method_825C(level.scr_anim["odin_opfor"]["odin_hallway_weapon_struggle_range_opfor"],1,param_01,param_02);
	level.var_7D02 = %odin_hallway_weapon_struggle_range_opfor;
}

//Function Number: 38
player_struggle_anim(param_00,param_01,param_02)
{
	level endon("struggle_end");
	param_00 method_825C(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_range_player"],1,param_01,param_02);
	level.var_7D03 = %odin_hallway_weapon_struggle_range_player;
}

//Function Number: 39
func_7741(param_00,param_01)
{
	level endon("struggle_end");
	var_02 = getent("struggle_gun","targetname");
	var_03 = getent("struggle_gun_target","targetname");
	var_03 linkto(var_02);
	var_04 = gettime();
	var_05 = var_04 - 500;
	var_06 = 0;
	var_07 = gettime() - 6000;
	var_08 = gettime();
	var_09 = 0;
	var_0A = 1;
	level.var_7D04 = 32;
	for(;;)
	{
		var_07 = gettime() - 9000;
		if(level.player attackbuttonpressed() && var_0A == 1)
		{
			fire_space_microtar(var_02,var_03);
			var_04 = gettime();
			var_05 = var_04 - 500;
			var_06 = var_06 + 1;
			thread func_7745(param_00);
			thread func_7D0A();
		}

		if(level.player attackbuttonpressed(1))
		{
			var_0A = 0;
		}
		else
		{
			var_0A = 1;
		}

		if(var_07 >= var_08 || level.var_7D04 <= 0)
		{
			thread func_5DF2(param_00,param_01);
		}

		wait(0.01);
	}
}

//Function Number: 40
fire_space_microtar(param_00,param_01)
{
	wait(0.05);
	for(var_02 = 0;var_02 < 3;var_02++)
	{
		magicbullet("microtar_space_interior",param_00 gettagorigin("tag_flash"),param_01.origin,level.player);
		level.player playsound("weap_tar21_fire_plr");
		level.player playrumbleonentity("smg_fire");
		playfxontag(common_scripts\utility::func_3AB9("space_microtar_shot"),param_00,"tag_flash");
		level.var_7D04 = level.var_7D04 - 1;
		wait(0.05);
	}
}

//Function Number: 41
func_5DF2(param_00,param_01)
{
	level endon("ally_clear");
	level notify("struggle_end");
	common_scripts\utility::flag_set("stop_struggle_rotate");
	level.player thread maps/odin_audio::func_7222();
	var_02 = getent("struggle_rotate_hinge","targetname");
	var_02 rotateto((0,270,0),1.5);
	var_03 = [];
	var_03["odin_opfor"] = param_00;
	var_03["player_rig"] = param_01;
	foreach(var_05 in var_03)
	{
		var_05 maps\_utility::anim_stopanimscripted();
	}

	wait(0.01);
	thread func_32B6();
	var_02 thread maps\_anim::anim_single(var_03,"odin_hallway_weapon_struggle_fail");
	wait(1);
	level.player method_82E7();
	common_scripts\utility::flag_set("mission_failed");
	maps\_utility::func_52F2();
}

//Function Number: 42
func_3CC6()
{
	level endon("ally_clear");
	wait(5);
	var_00 = function_0174();
	if(level.player common_scripts\utility::func_4828())
	{
		if(var_00 == "thumbstick_southpaw" || var_00 == "thumbstick_legacy")
		{
			level.player thread maps\_utility::display_hint("ally_struggle_fail_alt");
		}
		else
		{
			level.player thread maps\_utility::display_hint("ally_struggle_fail");
		}
	}
	else
	{
		level.player thread maps\_utility::display_hint("ally_struggle_fail_PC");
	}

	thread check_for_layout_change_mid_hint(var_00);
}

//Function Number: 43
check_for_layout_change_mid_hint(param_00)
{
	while(!common_scripts\utility::flag("saved_ally"))
	{
		var_01 = function_0174();
		if(var_01 != param_00)
		{
			common_scripts\utility::flag_set("switched_sticks");
			param_00 = var_01;
			wait(0.1);
			common_scripts\utility::func_337C("switched_sticks");
			if(level.player common_scripts\utility::func_4828())
			{
				if(var_01 == "thumbstick_southpaw" || var_01 == "thumbstick_legacy")
				{
					level.player thread maps\_utility::display_hint("ally_struggle_fail_alt");
				}
				else
				{
					level.player thread maps\_utility::display_hint("ally_struggle_fail");
				}

				continue;
			}

			level.player thread maps\_utility::display_hint("ally_struggle_fail_PC");
		}

		wait(0.05);
	}
}

//Function Number: 44
func_32B6()
{
	level endon("ally_clear");
	var_00 = getent("struggle_gun","targetname");
	level.player playsound("scn_odin_player_grapple_lost");
	wait(0.7);
	playfxontag(common_scripts\utility::func_3AB9("spc_explosion_240"),var_00,"tag_flash");
	level.player playsound("weap_tar21_fire_plr");
}

//Function Number: 45
func_7745(param_00)
{
	level endon("ally_clear");
	var_01 = getent("struggle_enemy_head","targetname");
	var_02 = getent("struggle_enemy_inner_head","targetname");
	if(level.var_7D03 > 0.325 && level.var_7D03 < 0.635)
	{
		level notify("struggle_end");
		common_scripts\utility::flag_set("player_shoot_anims");
		common_scripts\utility::flag_set("stop_struggle_rotate");
		var_03 = getent("struggle_gun","targetname");
		stopfxontag(common_scripts\utility::func_3AB9("spc_explosion_240"),var_03,"tag_flash");
		playfxontag(level._effect["blood_impact_space"],var_02,"tag_eye");
		param_00 setmodel(level.var_6AF3["odin_opfor"] + "_cracked");
		common_scripts\utility::func_8AFE();
		playfxontag(common_scripts\utility::func_3AB9("blood_impact_space"),var_02,"J_Spine4");
	}
}

//Function Number: 46
struggle_guy_line(param_00)
{
	level.struggle_guy maps\_utility::smart_radio_dialogue("odin_pyl_translatednostopno");
}

//Function Number: 47
func_5F8F(param_00,param_01,param_02)
{
	level endon("ally_clear");
	common_scripts\utility::func_337C("clear_to_tweak_player");
	common_scripts\utility::flag_wait("player_shoot_anims");
	common_scripts\utility::flag_set("saved_ally");
	param_00 maps\_utility::anim_stopanimscripted();
	maps\_utility::func_62C7();
	thread maps/odin_audio::func_7227();
	maps\_utility::func_62C7();
	level.player maps\_utility::func_5E13("LEVEL_1A");
	thread func_7D0C();
	thread func_7D0B(param_00);
	thread func_8EA0(param_01,param_00,param_02);
	var_03 = getent("z_trans_hinge_a","targetname");
	var_04 = maps\_utility::func_777F("player_rig");
	var_04 hide();
	var_03 maps\_anim::anim_first_frame_solo(var_04,"odin_hall_escape_turn01_player");
	thread push_enemy_down(param_00);
	%odin_hallway_weapon_struggle_shoot_player;
	level.struggle_hinge rotateto((0,270,0),1.25,0,1.25);
	wait(1.3);
	param_01 unlink();
	param_01 moveto((3323.92,46696.8,48483.7),0.75,0.75,0);
	wait(0.8);
	var_05 = [];
	var_05["player_rig"] = param_01;
	thread maps/odin_audio::func_7398();
	param_01 maps\_utility::anim_stopanimscripted();
	thread end_layered_anims(param_01);
	thread func_8EA1(param_01);
	var_03 thread maps\_anim::anim_single_solo(param_01,"odin_hall_escape_turn01_player");
	wait(2);
	common_scripts\utility::flag_set("teleport_player_to_z_trans");
	level.player allowsprint(1);
	level.player setcandamage(1);
}

//Function Number: 48
rotation_resetter(param_00)
{
	for(;;)
	{
		iprintlnbold(param_00.angles);
		wait(0.1);
	}
}

//Function Number: 49
push_enemy_down(param_00)
{
	var_01 = common_scripts\utility::func_7836();
	level.ally_ent_del[level.ally_ent_del.size] = var_01;
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_02 = getent("z_trans_hinge_a","targetname");
	%odin_spin_struggling_enemy_01;
	var_03 = common_scripts\utility::func_7836();
	level.ally_ent_del[level.ally_ent_del.size] = var_03;
	var_04 = getent("struggle_rotate_hinge","targetname");
	var_03.origin = var_04.origin;
	var_03.angles = level.player.angles;
	param_00 unlink();
	param_00 linkto(var_03);
	var_05 = level.player getangles();
	var_06 = anglestoforward(var_05);
	var_07 = anglestoforward(var_02.angles);
	var_08 = vectordot(var_06,var_07);
	if(var_08 >= 0)
	{
		if(param_00.origin[2] <= level.player.origin[2] + 10)
		{
			var_03 rotatepitch(180,7,7,0);
		}
		else
		{
			var_03 rotatepitch(-180,4,4,0);
		}
	}

	common_scripts\utility::flag_wait("teleport_player_to_z_trans");
	param_00 unlink();
	thread func_543A(param_00);
}

//Function Number: 50
end_layered_anims(param_00)
{
	%odin_struggle_left;
	param_00 method_825D(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_left_player"],0,0.05,65);
	%odin_struggle_center;
	param_00 method_825D(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_center_player"],0,0.05,1);
	%odin_struggle_right;
	param_00 method_825D(level.scr_anim["player_rig"]["odin_hallway_weapon_struggle_right_player"],0,0.05,1);
}

//Function Number: 51
func_543A(param_00)
{
	var_01 = param_00;
	var_02 = getent("z_trans_2_1_node","targetname");
	wait(0.05);
	var_01.origin = var_02.origin - (0,-352,0);
	%odin_spin_struggling_enemy_01;
	level.ally_ent_del[level.ally_ent_del.size] = var_01;
	var_03 = common_scripts\utility::func_7836();
	var_03.origin = param_00.origin;
	param_00 linkto(var_03);
	var_03.angles = var_02.angles + (0,90,0);
	var_04 = randomfloatrange(300,400);
	var_03 rotateby((-10,10,10),60,0,0);
	var_03 movez(-15,60,0,0);
}

//Function Number: 52
func_7D0B(param_00)
{
	level endon("ally_clear");
	var_01 = getent("struggle_enemy_head","targetname");
	var_02 = getent("struggle_enemy_inner_head","targetname");
	playfxontag(level._effect["odin_helmet_glass_shatter"],var_02,"tag_eye");
}

//Function Number: 53
func_7D0C()
{
	level endon("ally_clear");
	var_00 = 0.2;
	maps\_utility::func_761A(var_00);
	maps\_utility::func_7617(0.2);
	maps\_utility::slowmo_lerp_in();
	level.player setmovespeedscale(0.3);
	var_01 = 0.3;
	wait(var_01);
	maps\_utility::func_7618(1.65);
	maps\_utility::func_7615();
	maps\_utility::func_7613();
	level.player setmovespeedscale(1);
}

//Function Number: 54
func_7D09(param_00,param_01)
{
	level endon("struggle_end");
	level.struggle_hinge = common_scripts\utility::func_7836();
	var_02 = 0;
	common_scripts\utility::flag_wait("spin_player_and_enemy");
	level.struggle_hinge.origin = param_01 gettagorigin("tag_player");
	level.struggle_hinge.angles = param_01 gettagangles("tag_player");
	level.struggle_hinge = getent("struggle_rotate_hinge","targetname");
	param_00 linkto(level.struggle_hinge);
	param_01 linkto(level.struggle_hinge);
	level.struggle_hinge rotatepitch(-90,1,1,0);
	wait(1);
	while(!common_scripts\utility::flag("saved_ally") && !common_scripts\utility::flag("stop_struggle_rotate"))
	{
		level.struggle_hinge rotatepitch(-5400,60,0,0);
		wait(60);
	}

	var_03 = level.struggle_hinge.angles[2] / 360 * -1;
	while(var_02 == 0)
	{
		if(var_03 - 1 > 0)
		{
			var_03 = var_03 - 1;
			continue;
		}

		var_02 = 1;
	}
}

//Function Number: 55
func_7D0A()
{
	level endon("ally_clear");
	level endon("struggle_end");
}

//Function Number: 56
func_7D07()
{
	level endon("ally_clear");
	level endon("struggle_end");
	for(;;)
	{
		common_scripts\utility::flag_wait("struggle_grunt");
		wait(randomfloatrange(2,4));
		common_scripts\utility::func_337C("struggle_grunt");
	}
}

//Function Number: 57
func_8EA0(param_00,param_01,param_02)
{
	var_03 = getent("ally_doppleganger1","targetname");
	param_02 = var_03 maps\_utility::func_7766();
	level.ally_ent_del[level.ally_ent_del.size] = param_02;
	level.fake_kyra = param_02;
	param_02 maps\_utility::func_3DFD();
	param_02.ignoreall = 1;
	param_02.animname = "odin_ally";
	level.ally maps\_utility::func_2743();
	var_04 = getent("z_trans_hinge_a","targetname");
	var_05 = getent("z_trans_2_1_node","targetname");
	var_06 = getent("z_trans_2_2_node","targetname");
	var_07 = getent("z_trans_final_node","targetname");
	var_08 = getentarray("z_trans_test","targetname");
	var_09 = [];
	var_0A = [];
	var_0B = [];
	var_09["odin_ally"] = level.ally;
	var_0A["odin_ally"] = param_02;
	var_04 maps\_anim::anim_first_frame_solo(level.ally,"odin_hall_escape_turn01_ally");
	var_05 maps\_anim::anim_first_frame_solo(param_02,"odin_hall_escape_turn01_ally");
	var_04 thread maps\_anim::anim_single_solo(level.ally,"odin_hall_escape_turn01_ally");
	var_05 maps\_anim::anim_single_solo(param_02,"odin_hall_escape_turn01_ally");
	thread maps/odin_audio::sfx_bg_fighting_stop();
	var_07 thread maps\_anim::anim_single_solo(level.ally,"odin_hall_escape_turn02_ally");
	var_06 maps\_anim::anim_single_solo(param_02,"odin_hall_escape_turn02_ally");
	common_scripts\utility::flag_set("ally_out_of_z");
	var_0C = common_scripts\utility::func_3C18("kyra_move_node01","targetname");
	var_06 = getent("ally_kyra_move_node01","targetname");
	var_06 thread maps\_anim::anim_loop_solo(param_02,"odin_escape_start_first_encounter_loop_ally01","stop_loops");
	var_0C thread maps\_anim::anim_loop_solo(level.ally,"odin_escape_start_first_encounter_loop_ally01","stop_loops");
	common_scripts\utility::flag_wait("player_second_z_turn");
	var_0C notify("stop_loops");
	var_06 thread maps\_anim::anim_single_solo(param_02,"odin_escape_first_encounter_ally01");
	level.ally unlink();
	level.ally method_8225(level.ally.origin);
	level.ally maps\_utility::func_2C96();
	foreach(var_0E in var_08)
	{
		var_0E delete();
	}

	common_scripts\utility::flag_set("ally_clear");
	var_0C = common_scripts\utility::func_3C18("ally_kyra_move_node01","targetname");
}

//Function Number: 58
func_8EA1(param_00)
{
	thread func_2BC5();
	var_01 = getent("z_trans_hinge_a","targetname");
	var_02 = getent("z_trans_2_1_node","targetname");
	var_03 = getent("z_trans_2_2_node","targetname");
	var_04 = getent("z_trans_final_node","targetname");
	var_05 = getent("struggle_gun","targetname");
	var_06 = maps\_utility::func_777F("player_rig");
	level.ally_ent_del[level.ally_ent_del.size] = var_06;
	var_07 = maps\_utility::func_777F("player_rig");
	level.ally_ent_del[level.ally_ent_del.size] = var_07;
	var_08 = [];
	var_09 = [];
	var_08["player_rig"] = var_06;
	var_09["player_rig"] = var_07;
	var_02 maps\_anim::anim_first_frame(var_09,"odin_hall_escape_turn01_player");
	maps/odin_util::func_3637();
	var_02 thread maps\_anim::anim_single(var_09,"odin_hall_escape_turn01_player");
	wait(2);
	var_0A = var_07 gettagorigin("tag_player");
	var_0B = var_07 gettagangles("tag_player");
	level.player setangles(var_0B);
	level.player setorigin(var_0A);
	var_0C = 0;
	level.player playerlinktodelta(var_07,"tag_player",1,var_0C,var_0C,var_0C,var_0C,1);
	wait(3.03333);
	var_06 hide();
	var_07 hide();
	var_05 delete();
	common_scripts\utility::flag_set("lock_first_z_trans_door");
	level.player unlink();
	level.player giveweapon(level.player.var_8D96);
	level.player setweaponammoclip(level.player.var_8D96,level.var_7D04);
	level.player switchtoweapon(level.player.var_8D96);
	function_0168("ammoCounterHide","0");
	level.player enableweapons();
	var_03 maps\_anim::anim_first_frame(var_09,"odin_hall_escape_turn02_player");
	var_04 maps\_anim::anim_first_frame(var_08,"odin_hall_escape_turn02_player");
	var_06 show();
	level.player maps\_utility::autosave_by_name("z_trans");
	thread maps/odin_util::func_2BAB();
	common_scripts\utility::flag_wait("player_second_z_turn");
	thread maps/odin_audio::func_7399();
	level.player disableweapons();
	level.player playerlinktoblend(var_07,"tag_player",0.75);
	wait(0.75);
	level.player playerlinktodelta(var_07,"tag_player",1,var_0C,var_0C,var_0C,var_0C,1);
	var_03 thread maps\_anim::anim_single(var_09,"odin_hall_escape_turn02_player");
	var_04 thread maps\_anim::anim_single(var_08,"odin_hall_escape_turn02_player");
	var_0D = 0;
	var_0E = 0;
	while(var_0D == 0)
	{
		var_0F = var_0A;
		var_0F = maps\_utility::func_688C(var_0F,2,0);
		if(var_0F >= 0 && var_0E == 0)
		{
			var_0E = 1;
			var_0A = var_06 gettagorigin("tag_player");
			var_0B = var_06 gettagangles("tag_player");
			level.player unlink();
			level.player setangles(var_0B);
			level.player setorigin(var_0A);
			level.player playerlinktodelta(var_06,"tag_player",1,var_0C,var_0C,var_0C,var_0C,1);
		}

		if(var_0F >= 0.7)
		{
			common_scripts\utility::flag_set("lock_z_hall_close_door");
		}

		if(var_0F == 1)
		{
			var_0D = 1;
		}

		wait(0.01);
	}

	level.player unlink();
	thread func_60D0();
	level.player enableweapons();
	var_06 delete();
	var_07 delete();
	wait(0.25);
	common_scripts\utility::flag_set("clear_to_tweak_player");
}

//Function Number: 59
func_2BC5()
{
	common_scripts\utility::flag_wait("player_second_z_turn");
	thread maps/odin_escape::crew_quarters_combat();
}

//Function Number: 60
func_60D0()
{
	level endon("post_z_push_cancel");
	level thread func_60D1();
	for(var_00 = 0;var_00 > -4500;var_00 = var_00 - 700)
	{
		function_0168("player_swimWaterCurrent",(var_00,0,0));
		wait(0.05);
	}

	wait(1.5);
	for(var_00 = -4500;var_00 < 0;var_00 = var_00 + 75)
	{
		function_0168("player_swimWaterCurrent",(var_00,0,0));
		wait(0.05);
	}

	function_0168("player_swimWaterCurrent",(0,0,0));
	level notify("post_z_push_done");
}

//Function Number: 61
func_60D1()
{
	level endon("post_z_push_done");
	for(;;)
	{
		var_00 = level.player getnormalizedmovement();
		if(var_00[0] < -0.9)
		{
			function_0168("player_swimWaterCurrent",(0,0,0));
		}

		wait(0.1);
	}
}

//Function Number: 62
func_1D81()
{
	level endon("ally_clear");
	var_00 = getent("scriptednode_pdoor","targetname");
	var_01 = maps\_utility::func_777F("space_round_hatch");
	level.ally_ent_del[level.ally_ent_del.size] = var_01;
	var_00 maps\_anim::anim_first_frame_solo(var_01,"odin_intro_exterior_door_open");
}

//Function Number: 63
airlock_interior_hatch()
{
	level endon("ally_clear");
	var_00 = getent("scriptednode_squareDoor","targetname");
	var_01 = maps\_utility::func_777F("space_square_hatch");
	level.ally_ent_del[level.ally_ent_del.size] = var_01;
	var_00 maps\_anim::anim_first_frame_solo(var_01,"odin_infiltrate_door_open");
	var_02 = getent("intro_airlock_hatch_blocker","targetname");
	var_03 = getent("intro_airlock_hatch_blocker_org","targetname");
	var_03 linkto(var_01,"tag_origin");
	var_02 linkto(var_03);
	thread maps/odin_audio::sfx_airlock_door();
	var_00 maps\_anim::anim_single_solo(var_01,"odin_infiltrate_door_open");
}

//Function Number: 64
ally_cleanup(param_00)
{
	if(param_00 == 0)
	{
		common_scripts\utility::flag_wait("trigger_third_guy");
		if(isdefined(level.ally_ent_del))
		{
			foreach(var_02 in level.ally_ent_del)
			{
				if(isdefined(var_02))
				{
					var_02 delete();
				}
			}
		}
	}

	maps/odin_util::func_69D0("ally_spawner_to_clean");
	maps/odin_util::func_69D0("ally_trig_to_clean");
	maps/odin_util::func_69D0("ally_ent_to_clean");
	var_04 = getentarray("ally_tar_to_clean","targetname");
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06))
		{
			var_06 delete();
		}
	}
}

//Function Number: 65
enemy_squad_spawn(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = 0;
	for(var_05 = 0;var_05 < param_01;var_05++)
	{
		var_06 = getent(param_00 + var_05,"targetname");
		var_07 = var_06 maps\_utility::func_7766();
		var_03[var_05] = var_07;
		var_07 func_5011();
		maps/odin_util::actor_teleport(var_07,param_02 + var_05);
	}

	return var_03;
}

//Function Number: 66
func_5011()
{
	if(self.team == "allies")
	{
	}

	if(self.type == "dog")
	{
	}

	if(!isdefined(self.swimmer) || self.swimmer == 0)
	{
		thread maps\_space_ai::enable_space();
	}
}