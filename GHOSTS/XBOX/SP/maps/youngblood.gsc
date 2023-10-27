/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\youngblood.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 33
 * Decompile Time: 441 ms
 * Timestamp: 10/27/2023 1:37:02 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	maps\_utility::func_8039("youngblood");
	func_8E99();
	maps\createart\youngblood_art::func_4FDD();
	maps\youngblood_fx::func_4FDD();
	maps\youngblood_precache::func_4FDD();
	maps\_player_limp::init_player_limp();
	maps\_utility::add_start("start_deer",::func_712C,undefined,::func_7A22);
	maps\_utility::add_start("start_after_hunt",::func_70F2,undefined,::func_79EA);
	maps\_utility::add_start("start_woods",::setup_woods,undefined,::func_7ABE);
	maps\_utility::add_start("start_neighborhood",::setup_neighborhood,undefined,::func_7A63);
	maps\_utility::add_start("start_mansion_ext",::func_7188,undefined,::func_7A5B);
	maps\_utility::add_start("start_mansion",::func_7187,undefined,::start_mansion);
	maps\_utility::add_start("start_chaos_a",::func_7111,undefined,::start_chaos_a);
	maps\_utility::add_start("start_chaos_b",::func_7112,undefined,::start_chaos_b);
	maps\_utility::add_start("start_pickup",::func_719F,undefined,::start_pickup);
	maps\_utility::add_start("start_test",::func_7AA9,undefined);
	maps\_utility::add_start("start_test_area_a",::start_test_area_a,undefined);
	maps\_utility::add_start("start_test_area_b",::func_7AAF,undefined);
	maps\_load::func_4FDD();
	maps\_utility::func_70BD("r_specularColorScale",2.5,9);
	if(maps\_utility::func_47F6())
	{
		func_6E80();
	}

	maps/youngblood_audio::func_4FDD();
	maps/youngblood_anim::func_4FDD();
	func_8E8E();
	func_8E9A();
	func_8E88();
	func_8E90();
	thread entity_counter();
}

//Function Number: 2
func_8E8E()
{
	precachemodel("electronics_camera_pointandshoot_low");
	precachemodel("electronics_camera_cellphone_low");
	precachemodel("cup_paper_open_iw6");
	precachemodel("viewhands_gs_hostage");
	precachemodel("viewhands_gs_hostage_clean");
	precachemodel("viewhands_player_gs_hostage");
	precachemodel("viewhands_player_gs_hostage_clean");
	precachemodel("vfx_ygb_roadcrack_a_to_e_first_frame");
	precachemodel("vfx_ygb_roadcrack_a_to_e_last_frame");
	precachemodel("vfx_ygb_churchcollapse_first_frame");
	precacheitem("noweapon_youngblood");
	precachestring(&"YOUNGBLOOD_INTROSCREEN_LINE_1");
	precachestring(&"YOUNGBLOOD_INTROSCREEN_LINE_5");
	precachestring(&"YOUNGBLOOD_HINT_SPRINT");
	precachestring(&"YOUNGBLOOD_LEFTBEHIND");
	precachestring(&"YOUNGBLOOD_AVOIDCARS");
	precacherumble("light_1s");
	precacherumble("light_2s");
	precacherumble("heavy_3s");
	precacherumble("tank_rumble");
	precacherumble("prologue_chaos_a");
	precacheshellshock("ygb_crash");
	precacheshellshock("ygb_end");
	precacheshellshock("ygb_end_lite");
	maps\_utility::add_hint_string("hint_sprint",&"YOUNGBLOOD_HINT_SPRINT",::func_797F);
}

//Function Number: 3
func_222D()
{
	common_scripts\utility::flag_wait("yb_intro_plr_unlink");
	maps\_introscreen::introscreen(1);
}

//Function Number: 4
func_8E88()
{
	level.var_8E3C = "walk";
	level.player maps\_utility::func_2F47("fall");
	level.player maps\_utility::func_2F47("collapse");
	common_scripts\utility::func_3385("yb_intro_plr_unlink");
	common_scripts\utility::func_3385("player_unsafe");
	common_scripts\utility::func_3385("chaos_insta_death");
	common_scripts\utility::func_3385("chaos_player_safe");
	common_scripts\utility::func_3385("suppress_crash_player_fx");
	common_scripts\utility::func_3385("do_player_crash_fx");
	common_scripts\utility::func_3385("town_car_spawn");
	common_scripts\utility::func_3385("campfire_start");
	common_scripts\utility::func_3385("new_start_after_hunt");
	common_scripts\utility::func_3385("ah_tremor_2");
	common_scripts\utility::func_3385("new_treefall");
	common_scripts\utility::func_3385("load_car_1");
	common_scripts\utility::func_3385("load_car_2");
	common_scripts\utility::func_3385("hesh_middle_room_in_position");
	common_scripts\utility::func_3385("player_near_fence");
	common_scripts\utility::func_3385("player_past_fence");
	common_scripts\utility::func_3385("play_street_cracking");
	common_scripts\utility::func_3385("intro_clear");
	common_scripts\utility::func_3385("start_deer");
	common_scripts\utility::func_3385("deer_awaiting_death");
	common_scripts\utility::func_3385("start_after_hunt");
	common_scripts\utility::func_3385("start_woods");
	common_scripts\utility::func_3385("start_neighborhood");
	common_scripts\utility::func_3385("start_mansion");
	common_scripts\utility::func_3385("start_chaos_b");
	common_scripts\utility::func_3385("pool_crack");
	common_scripts\utility::func_3385("yb_player_crests_hill");
	common_scripts\utility::func_3385("player_top_hill");
	common_scripts\utility::func_3385("hesh_climbs_into_mansion");
	common_scripts\utility::func_3385("pool_crack");
	common_scripts\utility::func_3385("hesh_finish_1st");
	common_scripts\utility::func_3385("start_pickup");
	common_scripts\utility::func_3385("player_near_first_jump");
	common_scripts\utility::func_3385("player_jumped_into_house");
	common_scripts\utility::func_3385("player_exits_sliding_house");
	common_scripts\utility::func_3385("hesh_sequence_done");
	common_scripts\utility::func_3385("house_k2_k3_anim");
	common_scripts\utility::func_3385("player_area_1");
	common_scripts\utility::func_3385("player_area_2");
	common_scripts\utility::func_3385("player_area_3");
	common_scripts\utility::func_3385("player_area_4");
	common_scripts\utility::func_3385("player_near_debris_door");
	common_scripts\utility::func_3385("watchout_car");
	common_scripts\utility::func_3385("chaos_hesh_go");
	common_scripts\utility::func_3385("hesh_in_truck");
	common_scripts\utility::func_3385("end_truck_in_pos");
	common_scripts\utility::func_3385("yb_mission_over");
	common_scripts\utility::func_3385("load_1");
	common_scripts\utility::func_3385("load_2");
	common_scripts\utility::func_3385("load_3");
	common_scripts\utility::func_3385("car_move_forward");
	common_scripts\utility::func_3385("passenger_1_in");
	common_scripts\utility::func_3385("passenger_2_in");
	common_scripts\utility::func_3385("player_on_house_floor");
	common_scripts\utility::func_3385("trig_player_inside_house");
	common_scripts\utility::func_3385("both_chars_on_floor");
	common_scripts\utility::func_3385("truck_landed_exit_scene");
	common_scripts\utility::func_3385("player_enter_2nd_door");
	common_scripts\utility::func_3385("player_near_mansion_exit");
	common_scripts\utility::func_3385("truck_near_vista");
	common_scripts\utility::func_3385("church_fall_go");
	common_scripts\utility::func_3385("hesh_moving_to_truck");
	common_scripts\utility::func_3385("truck_incoming");
	common_scripts\utility::func_3385("truck_2nd_position");
	common_scripts\utility::func_3385("truck_1st_position");
	common_scripts\utility::func_3385("truck_2nd_position");
	common_scripts\utility::func_3385("truck_3rd_position");
	common_scripts\utility::func_3385("truck_arrived_pos_1");
	common_scripts\utility::func_3385("truck_pickup_npcs");
	common_scripts\utility::func_3385("truck_arrived_npc_pos");
	common_scripts\utility::func_3385("truck_exit_map");
	common_scripts\utility::func_3385("npc_near_truck");
	if(!common_scripts\utility::flag_exist("transition_from_odin_to_yb_done"))
	{
		common_scripts\utility::func_3385("transition_from_odin_to_yb_done");
	}
}

//Function Number: 5
func_8E90()
{
	level.player setviewmodel("viewhands_gs_hostage");
	level.player takeallweapons();
	level.player giveweapon("noweapon_youngblood");
	level.player giveweapon("noweapon_youngblood+yb_state_chaos");
	level.player giveweapon("noweapon_youngblood+yb_state_hill");
	level.player giveweapon("noweapon_youngblood+yb_state_tremor");
	level.player disableweaponswitch();
	level.player switchtoweapon("noweapon_youngblood");
	level.player method_828B(0);
	level.var_6AA6 = 56;
	level.no_tremor = 1;
	level.var_5D6F = 1;
	level.var_5E85 = undefined;
	function_0168("ammoCounterHide","1");
	common_scripts\utility::create_dvar("chaos_long_end",0);
	common_scripts\utility::trigger_off("start_chaos_a","targetname");
	function_0168("fx_alphathreshold",9);
	function_0199("Music",0);
	function_0199("Menu",0);
	function_0199("local3",0);
	function_0199("Mission",0);
	function_0199("Announcer",0);
	function_0199("Bulletimpact",0.6);
	function_0199("Voice",0.4);
	function_0199("effects2",0.2);
	function_0199("local",0.4);
	function_0199("physics",0.2);
	function_0199("ambient",0.5);
	function_0199("auto",0.5);
	maps\_utility::func_474E(&"YOUNGBLOOD_INTROSCREEN_LINE_1",&"YOUNGBLOOD_INTROSCREEN_LINE_5","");
	maps\_utility::func_474F(::func_222D);
	maps\_utility::array_spawn_function_noteworthy("videotaper",::maps/youngblood_util::func_89A4);
	maps\_utility::array_spawn_function_noteworthy("n_watchers",::maps/youngblood_code::func_555C);
	maps\_drone_civilian::func_44DF();
}

//Function Number: 6
func_712C()
{
	maps/youngblood_util::func_77D7();
	maps/youngblood_util::func_77AA();
	level.elias thread maps/youngblood_util::enable_elias_walk();
	level.hesh thread maps/youngblood_util::enable_hesh_walk();
	maps/youngblood_util::set_start_positions("start_deer");
}

//Function Number: 7
func_70F2()
{
	level.player method_83BF("youngblood_forest_start",0);
	maps/youngblood_util::func_77AA();
	maps/youngblood_util::func_77D7();
	level.elias maps\_utility::disable_sprint();
	level.hesh maps\_utility::disable_sprint();
	level.hesh thread maps/youngblood_util::enable_hesh_walk();
	level.elias thread maps/youngblood_util::enable_elias_walk();
	level.elias.goalradius = 64;
	level.hesh.goalradius = 64;
	level.elias thread maps\_utility::func_3490(common_scripts\utility::func_39BD("ah_path_elias"),0);
	level.hesh thread maps\_utility::func_3490(common_scripts\utility::func_39BD("ah_path_hesh"),150);
	maps/youngblood_util::func_8E8D(80);
	level.player allowsprint(0);
	maps/youngblood_util::set_start_positions("start_deer");
}

//Function Number: 8
setup_woods()
{
	level.player method_83BF("youngblood_forest_upper",0);
	maps/youngblood_util::func_77AA();
	maps/youngblood_util::func_77D7();
	level.hesh thread maps/youngblood_util::enable_hesh_walk();
	level.elias thread maps/youngblood_util::enable_elias_walk();
	maps/youngblood_util::set_start_positions("start_woods");
	common_scripts\utility::flag_set("new_treefall");
	level.var_5E87 = "vfx_yb_onplayer_02_trunkroll";
	level.player thread maps/youngblood_code::func_898F();
}

//Function Number: 9
setup_neighborhood()
{
	maps/youngblood_util::func_77AA();
	maps/youngblood_util::func_77D7();
	level.player method_83BF("youngblood_forest_upper",2);
	level.elias thread maps/youngblood_util::enable_elias_walk();
	level.hesh thread maps/youngblood_util::enable_hesh_walk();
	level.hesh maps\_utility::enable_sprint();
	level.hesh maps/youngblood_util::func_6F2D(1);
	level.elias maps\_utility::enable_sprint();
	level.elias maps/youngblood_util::func_6F2D(1);
	level.var_6AA6 = 56;
	common_scripts\utility::exploder("evilclouds");
	maps/youngblood_util::set_start_positions("start_neighborhood");
	level.hesh thread maps\_utility::func_3490(common_scripts\utility::func_39BD("fence_pos_hesh"));
	level.elias thread maps\_utility::func_3490(common_scripts\utility::func_39BD("fence_pos_elias"));
	level.var_5E87 = "vfx_yb_onplayer_03_afterfence";
	level.player thread maps/youngblood_code::func_898F();
}

//Function Number: 10
func_7188()
{
	level.player method_83BF("youngblood_forest_upper",0);
	maps/youngblood_util::func_77AA();
	maps/youngblood_util::func_77D7();
	level.elias thread maps/youngblood_util::enable_elias_walk();
	level.hesh thread maps/youngblood_util::enable_hesh_walk();
	level.hesh maps/youngblood_util::func_459B();
	level.hesh maps\_utility::enable_sprint();
	level.hesh maps/youngblood_util::func_6F2D(1);
	level.elias maps\_utility::enable_sprint();
	level.elias maps/youngblood_util::func_6F2D(1);
	level.player maps/youngblood_util::func_8E8D(56);
	common_scripts\utility::exploder("evilclouds");
	maps/youngblood_util::set_start_positions("start_mansion_ext");
}

//Function Number: 11
func_7187()
{
	level.player method_83BF("youngblood_forest_upper",0);
	maps/youngblood_util::func_77D7();
	level.hesh thread maps/youngblood_util::enable_hesh_walk();
	level.hesh maps\_utility::enable_sprint();
	level.hesh maps/youngblood_util::func_6F2D(1);
	level.player maps/youngblood_util::func_8E8D(56);
	maps/youngblood_util::set_start_positions("start_mansion");
}

//Function Number: 12
func_7111()
{
	level.player method_83BF("youngblood_slomo_impact",0);
	var_00 = common_scripts\utility::func_3C18("player_setup_chaos_pos","targetname");
	level.player setorigin(var_00.origin);
	level.player setangles(var_00.angles);
	common_scripts\utility::flag_set("new_treefall");
	common_scripts\utility::flag_set("transition_from_odin_to_yb_done");
}

//Function Number: 13
func_7112()
{
	maps/youngblood_util::func_77D7();
	if(isdefined(level.var_61E7) && level.var_61E7 == 1)
	{
		level.player setviewmodel("viewhands_gs_hostage");
		level.var_6AF3["player_rig"] = "viewhands_player_gs_hostage";
	}

	level.player method_83BF("youngblood_chaos",1.5);
	common_scripts\utility::func_F1B(getentarray("trig_player_rog","targetname"),::maps/youngblood_code::chaos_rog_think);
	level.hesh thread maps/youngblood_util::enable_hesh_walk();
	level.player maps/youngblood_util::func_8E8D(90);
	maps/youngblood_util::set_start_positions("start_chaos_b");
	level.hesh maps/youngblood_util::init_chaos_animset();
	thread maps/youngblood_code::chaos_b_hide_debris();
	maps\_utility::activate_trigger_with_targetname("basement_vfx_trig");
	maps\_utility::activate_trigger_with_noteworthy("street_flying_house");
}

//Function Number: 14
func_719F()
{
	maps/youngblood_util::func_77D7();
	maps/youngblood_util::func_77AA();
	maps\_hud_util::fade_out(0.05);
	thread maps\_utility::func_8A02("ygb_chaos_b",0.05);
	level.player setblurforplayer(10,0.05);
	if(isdefined(level.var_61E7) && level.var_61E7 == 1)
	{
		level.player setviewmodel("viewhands_gs_hostage");
		level.var_6AF3["player_rig"] = "viewhands_player_gs_hostage";
	}

	level.var_83D3 = maps\_vehicle::func_784E("truck");
	level.var_83D3.animname = "pickup";
	level.var_83D3 method_826D(level.var_6AED["pickup"]);
	level.player method_83BF("youngblood_chaos",1.5);
	function_0199("Music",0);
	function_0199("Menu",0);
	function_0199("local3",0);
	function_0199("Mission",0);
	function_0199("Announcer",0);
	function_0199("Bulletimpact",0.6);
	function_0199("Voice",0.1);
	function_0199("effects2",0.2);
	function_0199("local",0.4);
	function_0199("physics",0.2);
	function_0199("ambient",0.5);
	function_0199("auto",0.5);
	common_scripts\utility::exploder("city");
	wait(5);
	etslowmotion(1,0.4,0.25);
	common_scripts\utility::flag_set("start_pickup");
}

//Function Number: 15
func_7AA9()
{
	maps/youngblood_util::set_start_positions("start_test");
}

//Function Number: 16
start_test_area_a()
{
	maps/youngblood_util::set_start_positions("start_test_area_a");
}

//Function Number: 17
func_7AAF()
{
	maps/youngblood_util::set_start_positions("start_test_area_b");
}

//Function Number: 18
func_7A22()
{
	level.player method_83BF("youngblood_start_black",0);
	maps\_utility::func_70BD("r_specularColorScale",2.5,9);
	thread maps/youngblood_code::chaos_hide_on_start();
	maps/youngblood_code::deer();
}

//Function Number: 19
func_79EA()
{
	setdvar("hud_showObjectives",0);
	maps\_utility::func_70BD("r_specularColorScale",2.5,9);
	maps/youngblood_code::after_hunt();
}

//Function Number: 20
func_7ABE()
{
	setdvar("hud_showObjectives",0);
	maps\_utility::func_70BD("r_specularColorScale",2.5,9);
	maps/youngblood_code::func_8E39();
}

//Function Number: 21
func_7A63()
{
	setdvar("hud_showObjectives",0);
	maps\_utility::func_70BD("r_specularColorScale",2.5,9);
	maps/youngblood_code::func_5598();
}

//Function Number: 22
func_7A5B()
{
	setdvar("hud_showObjectives",0);
	maps\_utility::func_70BD("r_specularColorScale",2.5,9);
	maps/youngblood_code::func_507F();
}

//Function Number: 23
start_mansion()
{
	setdvar("hud_showObjectives",0);
	maps\_utility::func_70BD("r_specularColorScale",2.5,9);
	maps/youngblood_code::func_5079();
}

//Function Number: 24
start_chaos_a()
{
	setdvar("hud_showObjectives",0);
	maps\_utility::func_70BD("r_specularColorScale",2.5,9);
	common_scripts\utility::trigger_off("start_chaos_a","targetname");
	maps/youngblood_code::chaos_a();
}

//Function Number: 25
start_chaos_b()
{
	level.player method_83BF("youngblood_chaos",1.5);
	setdvar("hud_showObjectives",0);
	maps\_utility::func_70BD("r_specularColorScale",2.5,9);
	maps/youngblood_code::chaos_b();
}

//Function Number: 26
start_pickup()
{
	setdvar("hud_showObjectives",0);
	maps\_utility::func_70BD("r_specularColorScale",2.5,9);
	maps/youngblood_code::pickup();
}

//Function Number: 27
deer_rumble_movewait()
{
	wait(1.75);
	self notify("move");
}

//Function Number: 28
func_8E9A()
{
	common_scripts\utility::func_F1B(getentarray("chaos_checkpoint","targetname"),::maps/youngblood_util::chaos_checkpoint_trigger);
	common_scripts\utility::func_F1B(getentarray("chaos_chunk_fall","targetname"),::maps/youngblood_util::func_1AF4);
	common_scripts\utility::func_F1B(getentarray("move_trigger","targetname"),::maps/youngblood_util::func_8367);
	common_scripts\utility::func_F1B(getentarray("link_to_trigger","targetname"),::maps/youngblood_util::func_8398);
	common_scripts\utility::func_F1B(getentarray("uphill_trigger","targetname"),::maps/youngblood_util::func_875E);
	common_scripts\utility::func_F1B(getentarray("flat_trigger","targetname"),::maps/youngblood_util::flat_trigger);
	var_00 = getentarray("fxchunknames","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	var_04 = common_scripts\utility::func_39BD("campfire_player_blocker");
	var_04 delete();
}

//Function Number: 29
player_speed()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		var_01 = castfloat(self.var_6CB4) * 0.01;
		level.player setmovespeedscale(var_01);
		while(var_00 istouching(self))
		{
			wait(0.05);
		}

		level.player setmovespeedscale(1);
		wait(0.05);
	}
}

//Function Number: 30
entity_counter()
{
	common_scripts\utility::create_dvar("entity_counter",1);
}

//Function Number: 31
func_8E99()
{
	maps\_utility::add_earthquake("small_long",0.15,10,2048);
	maps\_utility::add_earthquake("small_med",0.15,5,2048);
	maps\_utility::add_earthquake("small_short",0.15,1,2048);
	maps\_utility::add_earthquake("medium_medium",0.25,3,2048);
	maps\_utility::add_earthquake("large_short",0.45,1,2048);
}

//Function Number: 32
func_6E80()
{
	function_0168("r_mbEnable",2);
	function_0168("r_mbCameraRotationInfluence",0.25);
	function_0168("r_mbCameraTranslationInfluence",0.01);
	function_0168("r_mbModelVelocityScalar",0.1);
	function_0168("r_mbStaticVelocityScalar",0.2);
	function_0168("r_mbViewModelEnable",0);
}

//Function Number: 33
func_797F()
{
	var_00 = getdvarint("g_speed");
	var_01 = level.player getvelocity();
	var_01 = length(var_01);
	return var_01 > var_00 || common_scripts\utility::flag("truck_landed_exit_scene");
}