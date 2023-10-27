/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\youngblood_code.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 109
 * Decompile Time: 1456 ms
 * Timestamp: 10/27/2023 1:37:07 AM
*******************************************************************/

//Function Number: 1
deer_fade_in()
{
	level.player freezecontrols(1);
	function_0168("hud_showstance",0);
	common_scripts\utility::func_8AFE();
	level.player method_83BF("youngblood_forest_start",2);
	level.player setblurforplayer(10,0);
	function_0168("cg_fov",35);
	common_scripts\utility::flag_set("campfire_start");
	wait(0.5);
	level.player freezecontrols(0);
	thread maps\_hud_util::func_3131(4);
	common_scripts\utility::func_8AFE();
	level.player setblurforplayer(0,2);
	level.player method_82A0();
	level.player method_8301(65,12);
	wait(3);
	level.elias maps/youngblood_util::func_455E();
	level.hesh maps/youngblood_util::func_4555();
	level.hesh.var_875D = 1;
	level.hesh maps/youngblood_util::func_45C7();
	level.elias maps/youngblood_util::init_uphill_jog_animset();
	level.hesh.goalradius = 128;
	level.elias.goalradius = 128;
	level.hesh.goalheight = 256;
	level.elias.goalheight = 256;
	level.hesh maps\_utility::func_2C9C();
	level.elias maps\_utility::func_2C9C();
	level.hesh maps\_utility::disable_exits();
	level.elias maps\_utility::disable_exits();
	level.hesh.dontchangepushplayer = 1;
	level.elias.dontchangepushplayer = 1;
	level.elias.pushable = 0;
	level.hesh.pushable = 0;
	level.hesh.var_624F = 1;
	level.elias.var_624F = 1;
	level.hesh method_8222(1);
	level.elias method_8222(1);
	level.elias thread maps\_utility::func_3490(common_scripts\utility::func_39BD("ah_path_elias"),0);
	level.hesh thread maps\_utility::func_3490(common_scripts\utility::func_39BD("ah_path_hesh"),200);
}

//Function Number: 2
deer()
{
	maps\_hud_util::func_7A75("black");
	thread maps\_art::func_7D49("default",0);
	maps\_utility::func_8A02("",0);
	if(isdefined(level.var_61E7) && level.var_61E7 == 1)
	{
		level.player setviewmodel("viewhands_gs_hostage_clean");
		level.var_6AF3["player_rig"] = "viewhands_player_gs_hostage_clean";
	}

	level.player_on_hill = 0;
	level.var_5665 = 0;
	level.player.ignoreme = 1;
	level.player.ignoreall = 1;
	level.player method_8273(0);
	level.player method_8274(0);
	level.player allowsprint(0);
	level.player method_828B(0);
	level.var_5E87 = "vfx_yb_onplayer_01_deer";
	level.player thread func_898F();
	level.player switchtoweapon("noweapon_youngblood+yb_state_hill");
	thread maps/youngblood_util::func_8E8D(40);
	thread deer_fade_in();
	var_00 = maps\_utility::func_777F("player_rig",level.player.origin);
	var_01 = spawn("script_model",(0,0,0));
	var_01 setmodel(level.hesh.model);
	var_01.animname = "player_body";
	var_01 maps\_anim::func_6FE5();
	level.player playerlinktoabsolute(var_00,"tag_player");
	common_scripts\utility::flag_wait("campfire_start");
	level.player common_scripts\utility::delaycall(1,::playerlinktodelta,var_00,"tag_player",1,20,20,20,20);
	var_02 = common_scripts\utility::func_39BD("intro_scene_ref_pos");
	thread distant_boom_sound();
	var_02 thread maps\_anim::anim_single_run([level.elias],"campfire");
	var_02 thread maps\_anim::anim_single_run([level.hesh],"campfire");
	var_02 maps\_anim::anim_single([var_00,var_01],"campfire");
	common_scripts\utility::flag_set("yb_intro_plr_unlink");
	var_01 delete();
	var_00 hide();
	level.player unlink();
	level.player method_82A1();
	var_00 delete();
	level.player method_8273(1);
	level.player method_8274(1);
	function_0168("hud_showstance",1);
}

//Function Number: 3
distant_boom_sound()
{
	level.hesh waittillmatch("distant_boom","single anim");
	var_00 = anglestoright(level.player.angles);
	var_00 = var_00 * -15536;
	thread common_scripts\utility::func_5D1F("yb_rog_distant_design_campfire",(6437,-109503,-116473));
}

//Function Number: 4
after_hunt()
{
	var_00 = getentarray("trigger_multiple","classname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.script_prefab_exploder) && var_02.script_prefab_exploder == "deer_hut_tremor_a")
		{
			var_02 delete();
			break;
		}
	}

	common_scripts\utility::flag_wait("new_start_after_hunt");
	level.hesh.anim_blend_time_override = 0.3;
	level.elias.anim_blend_time_override = 0.3;
	wait(0.5);
	level.player allowsprint(0);
	thread common_scripts\utility::func_5D1F("scn_quake_01",level.player.origin);
	wait(0.5);
	thread maps/youngblood_util::func_4196(33);
	level.hesh maps\_utility::func_252F(0.5,::maps\_utility::func_7628,"youngblood_hsh_woahlittletremorthere");
	level.hesh thread maps\_anim::func_D68(level.hesh,"youngblood_hesh_walk_tremor");
	level.elias maps/youngblood_util::func_4543();
	level.hesh maps/youngblood_util::func_4555();
	level.elias maps\_utility::func_2CB1();
	level.elias maps\_utility::func_2C9C();
	level.hesh maps\_utility::func_2CB1();
	level.hesh maps\_utility::func_2C9C();
	wait(1);
	level.hesh.goalradius = 200;
	level.hesh thread hesh_uphill(common_scripts\utility::func_39BD("ah_path_hesh_2"));
	level.hesh thread uphill_stopanims("youngblood_hesh_walk_turn_45_l");
	level.hesh thread uphill_anim_flagset("youngblood_hesh_walk_2_tremor_2_run","new_treefall",0.5);
	level.hesh thread maps\_utility::func_3490(common_scripts\utility::func_39BD("ah_path_hesh_2"),300);
	wait(1);
	level.elias.goalradius = 200;
	level.elias thread maps\_utility::func_3490(common_scripts\utility::func_39BD("ah_path_elias_2"),600);
	wait(0.5);
	level.elias thread maps\_utility::func_7628("youngblood_els_hehthosethingsusedto");
	common_scripts\utility::flag_wait("ah_tremor_2");
	common_scripts\utility::exploder("deer_hut_tremor_a");
	thread maps/youngblood_util::func_4196(40);
	thread common_scripts\utility::func_5D1F("scn_quake_02",level.player.origin);
	thread common_scripts\utility::func_5D1F("scn_quake_02_debris_01",(5999,-108103,-116150));
	thread common_scripts\utility::func_5D1F("scn_quake_02_debris_02",(6071,-107813,-116045));
	thread common_scripts\utility::func_5D1F("scn_quake_02_debris_03",(6344,-107850,-116153));
	thread common_scripts\utility::exploder("exp02");
	thread after_hunt_dialogue();
}

//Function Number: 5
hesh_uphill(param_00)
{
	param_00 waittill("trigger");
	self.var_875D = 1;
	thread maps\_anim::func_D68(self,"youngblood_hesh_walk_uphill_2_IN");
	switch(level.var_8E3C)
	{
		case "walk":
			thread maps/youngblood_util::func_45C7();
			break;

		case "jog":
			thread maps/youngblood_util::init_uphill_jog_animset();
			break;
	}
}

//Function Number: 6
uphill_stopanims(param_00)
{
	self waittillmatch(param_00,"starting_anim");
	var_01 = getanimlength(maps\_utility::func_3A21(param_00));
	wait(var_01 - 0.2);
	self notify("custom_animmode","stop anim");
}

//Function Number: 7
uphill_anim_flagset(param_00,param_01,param_02)
{
	self waittillmatch(param_00,"starting_anim");
	common_scripts\utility::flag_set(param_01);
	if(isdefined(param_02))
	{
		self.anim_blend_time_override = param_02;
		self waittill("finished_custom_animmode" + param_00);
		self.anim_blend_time_override = undefined;
	}
}

//Function Number: 8
after_hunt_dialogue()
{
	wait(1);
	level.hesh maps\_utility::func_7628("youngblood_hsh_anotherone");
	wait(0.7);
	level.elias maps\_utility::func_7628("youngblood_els_wellgetacouple");
	wait(2.5);
	maps\_utility::autosave_by_name_silent("woods");
	level.hesh maps\_utility::func_7628("youngblood_hsh_windsstartintopick");
}

//Function Number: 9
func_8E39()
{
	common_scripts\utility::flag_wait("new_treefall");
	thread common_scripts\utility::func_5D1F("scn_quake_03",level.player.origin);
	thread common_scripts\utility::func_5D1F("scn_quake_03_debris_04",level.player.origin);
	thread common_scripts\utility::func_5D1F("scn_quake_03_debris_01",(5883,-107667,-115970));
	thread common_scripts\utility::func_5D1F("scn_quake_03_debris_02",(6229,-107426,-115996));
	thread common_scripts\utility::func_5D1F("scn_quake_03_debris_03",(5944,-107160,-115972));
	thread common_scripts\utility::func_5D1F("scn_quake_03_log_roll_left",(5664,-107490,-115973));
	thread common_scripts\utility::func_5D1F("scn_quake_03_log_roll_right",(5819,-107295,-115973));
	thread wood_sfx_trees_mvmt_begin_upper_forest();
	maps\_utility::add_extra_autosave_check("close_to_hesh",::maps/youngblood_util::func_1B4E,"too far from hesh");
	maps\_utility::autosave_by_name_silent("woods");
	thread maps/youngblood_util::func_559C();
	maps\_utility::music_play("mus_prlog_intro_quakes");
	level.var_8E3C = "jog";
	level.elias maps/youngblood_util::func_455F();
	level.hesh maps/youngblood_util::func_455F();
	level.elias maps/youngblood_util::func_6F2D(1);
	level.hesh maps/youngblood_util::func_6F2D(0.9);
	level.elias.goalradius = 256;
	level.elias.goalheight = 256;
	level.hesh.goalradius = 256;
	level.elias.goalheight = 256;
	maps\_utility::activate_trigger_with_noteworthy("treefall");
	level.var_5E87 = "vfx_yb_onplayer_02_trunkroll";
	thread common_scripts\utility::exploder("exp04");
	maps\_utility::activate_trigger_with_noteworthy("deer_hill_tremor_a_trigger");
	thread common_scripts\utility::exploder("evilclouds");
	wait(0.5);
	thread maps/youngblood_util::heavy_quake(50);
	level.elias thread maps\_anim::func_D64(level.elias,"hijack_generic_stumble_stand2");
	level.elias thread maps\_utility::func_3490(common_scripts\utility::func_39BD("fence_pos_elias"),0);
	wait(1.5);
	level.elias common_scripts\utility::delaycall(0,::method_8252);
	wait(0.5);
	level.elias maps\_utility::func_2C9C();
	level.elias maps\_utility::func_2CB1();
	level thread deer_stampede_logic();
	level thread func_8E3B();
	thread func_8E3A();
	common_scripts\utility::flag_wait("deer_stampede");
	wait(1.8);
	level.elias maps/youngblood_util::func_6F2D(1.1);
	level.hesh.goalradius = 128;
	level.elias.goalradius = 128;
	level.hesh thread maps/youngblood_util::func_8E89(common_scripts\utility::func_39BD("fence_pos_hesh"),200);
	level.elias thread maps\_utility::func_3490(common_scripts\utility::func_39BD("fence_pos_elias"),0);
	level.elias maps\_utility::func_2C9C();
	wait(0.4);
	level.hesh maps/youngblood_util::func_6F2D(1);
	level.hesh maps\_utility::func_2C9C();
	level.hesh maps\_utility::func_2CB1();
	thread maps/youngblood_util::flashes_on_player();
}

//Function Number: 10
wood_sfx_trees_mvmt_begin_upper_forest()
{
	self endon("player_near_mansion_exit");
	var_00 = (5978,-107002,-115769);
	var_01 = (5676,-106512,-115646);
	var_02 = (5204,-106268,-115505);
	var_03 = (5158,-107261,-115709);
	var_04 = (5068,-106911,-115623);
	var_05 = (4852,-106711,-115441);
	var_06 = [var_00,var_01,var_02,var_03,var_04,var_05];
	wait(0.5);
	for(;;)
	{
		var_07 = common_scripts\utility::func_6306(var_06);
		thread common_scripts\utility::func_5D1F("emt_yb_foliage_debris",var_07);
		var_08 = randomfloatrange(2,4);
		wait(var_08);
	}
}

//Function Number: 11
func_8E3A()
{
	level.hesh maps\_utility::func_7628("youngblood_hsh_dad");
	level.player method_83BF("youngblood_forest_upper",2);
	level.player allowsprint(1);
	level.elias thread maps\_utility::func_7628("youngblood_els_letsjustgetto");
	maps\_utility::func_83B0("hint_sprint_trigger");
	maps\_utility::display_hint("hint_sprint");
}

//Function Number: 12
func_8E3B()
{
	wait(0.6);
	level.hesh maps/youngblood_util::func_8E89(common_scripts\utility::func_39BD("deer_event_hesh"),0);
}

//Function Number: 13
func_5598()
{
	thread n_sound_cars();
	thread common_scripts\utility::exploder("exp06");
	common_scripts\utility::flag_wait("start_neighborhood");
	wait(0.5);
	maps\_utility::func_5541(30);
	thread func_81D3();
	thread maps/youngblood_util::func_676F();
	wait(0.5);
	level.player thread maps\_utility::func_5D23("scn_quake_05");
	level.elias maps\_utility::disable_exits();
	thread n_hesh_stumble_and_path();
	level.elias thread func_2CB0("youngblood_hesh_calm_idle_2_tremor_2_run");
	thread maps/youngblood_util::heavy_quake(72);
	level.elias thread maps\_anim::func_D68(level.elias,"youngblood_hesh_calm_idle_2_tremor_2_run");
	level.elias maps/youngblood_util::func_459B();
	wait(0.75);
	common_scripts\utility::flag_wait("player_near_fence");
	level.elias.turnrate = 0.15;
	level.hesh.turnrate = 0.15;
	level.elias maps/youngblood_util::func_6F2D(1.03);
	level.hesh maps/youngblood_util::func_6F2D(1.03);
	level.elias.goalradius = 128;
	level.hesh maps\_utility::func_2C9C();
	level.elias maps\_utility::func_2C9C();
	level.elias thread maps\_utility::func_3490(common_scripts\utility::func_39BD("1_street_pos_elias"),0);
	level.elias method_8222(1);
	level.hesh method_8222(1);
	level.var_5E87 = "vfx_yb_onplayer_03_afterfence";
	thread func_5557();
	thread func_555B();
	thread n_door_knock();
	thread n_walla();
	var_00 = getent("town_sedan","targetname");
	var_00 thread func_559E();
}

//Function Number: 14
n_walla()
{
	common_scripts\utility::flag_wait("load_car_2");
	var_00 = (3800,-105493,-115324);
	thread common_scripts\utility::func_5D1F("youngblood_wla_allguys",var_00);
	var_01 = (3612,-105153,-115268);
	thread common_scripts\utility::func_5D1F("youngblood_wla_plusgirl",var_01);
}

//Function Number: 15
n_sound_cars()
{
	var_00 = common_scripts\utility::func_39BD("n_car_1");
	var_00 maps\_utility::add_spawn_function(::car_1_audio);
	var_00 = common_scripts\utility::func_39BD("n_car_2");
	var_00 maps\_utility::add_spawn_function(::car_2_audio);
	var_00 = common_scripts\utility::func_39BD("town_speed_car");
	var_00 maps\_utility::add_spawn_function(::truck_audio);
}

//Function Number: 16
truck_audio()
{
	level endon("death");
	level endon("car_stop_damage");
	self playloopsound("scn_yb_truck_drive_lp");
	for(;;)
	{
		if(distance2d(level.player.origin,self.origin) < 1215)
		{
			thread maps\_utility::func_5D23("scn_yb_truck_passby");
			wait(6);
			self stoploopsound();
		}

		wait(0.1);
	}
}

//Function Number: 17
car_1_audio()
{
	wait(0);
	thread maps\_utility::func_5D23("scn_yb_first_car_passby");
}

//Function Number: 18
car_2_audio()
{
	level endon("death");
	level endon("car_stop_damage");
	self playloopsound("scn_yb_second_car_drive_lp");
	for(;;)
	{
		if(distance2d(level.player.origin,self.origin) < 880)
		{
			thread maps\_utility::func_5D23("scn_yb_second_car_passby");
			wait(6);
			self stoploopsound();
		}

		wait(0.1);
	}
}

//Function Number: 19
n_hesh_stumble_and_path()
{
	level.hesh maps\_utility::func_2CB1();
	var_00 = addstruct();
	var_00.origin = level.hesh.origin;
	var_00.angles = level.hesh.angles;
	var_01 = common_scripts\utility::func_39BD("1_street_pos_hesh");
	var_00.angles = vectortoangles(var_01.origin - var_00.origin);
	var_00.angles = (0,var_00.angles[1],0);
	level.hesh maps\_utility::func_2CB1();
	var_00 maps\_anim::func_D64(level.hesh,"youngblood_generic_stumble_stand2");
	level.hesh.goalradius = 128;
	level.hesh thread maps\_utility::func_3490(common_scripts\utility::func_39BD("1_street_pos_hesh"),0);
}

//Function Number: 20
func_2CB0(param_00)
{
	self waittill(param_00);
	wait(0.1);
	maps\_utility::func_2CB1();
}

//Function Number: 21
func_559B()
{
	wait(7.5);
	level.hesh maps\_utility::func_7628("youngblood_hsh_dadwhatshappening");
	common_scripts\utility::flag_wait("start_neighborhood");
	wait(1.5);
	maps\_utility::func_252F(1.25,::common_scripts\utility::flag_set,"load_car_1");
	level thread maps\_utility::autosave_by_name_silent("entering_neighborhood_save");
	thread func_5CC7();
	wait(0.5);
	level.elias maps\_utility::func_7628("youngblood_els_odinitsodin");
	level.cloud_sfx_base_wait_min = 0.9;
	level.cloud_sfx_base_wait_max = 1.8;
	wait(0.5);
	thread n_diag();
	common_scripts\utility::flag_set("load_car_2");
	thread common_scripts\utility::exploder("exp07");
	thread func_559A();
	wait(3);
	maps\_utility::func_252F(2,::common_scripts\utility::exploder,"exp08");
}

//Function Number: 22
n_diag()
{
	level.elias maps\_utility::func_7628("youngblood_els_tothehouseboys");
	level.cloud_sfx_design_wait_min = 4;
	level.cloud_sfx_design_wait_max = 9.3;
}

//Function Number: 23
orange_plume_sound_stopping()
{
	if(isdefined(level.plume_sound))
	{
		level.plume_sound method_82DA(0,8);
		wait(8.1);
		level.plume_sound stopsounds();
		wait(0.3);
		level.plume_sound delete();
	}
}

//Function Number: 24
func_81D3()
{
	common_scripts\utility::flag_wait("town_car_spawn");
	thread orange_plume_sound_stopping();
	var_00 = maps\_vehicle::func_784F("town_speed_car");
	var_00 maps\_utility::func_252F(1,::maps\_utility::func_5D23,"scn_yb_truck_skid_corner");
	var_00 maps\_utility::func_252F(1.8,::maps\_utility::func_5D23,"yb_pars_volk_peel_out_r");
	var_00 maps\_utility::func_252F(2.5,::maps\_utility::func_5D23,"yb_chase_pileup_01");
	var_00 thread func_559E();
	var_00 thread func_559D(var_00);
	wait(2);
	level.player thread maps/youngblood_util::func_8E8D(70,2);
	level.elias maps\_utility::disable_exits();
	level.elias thread maps\_anim::func_D68(level.elias,"yb_deer_halt_3_hesh");
	wait(0.7);
	level.elias maps/youngblood_util::func_6F2D(1.1);
	level.hesh maps/youngblood_util::func_6F2D(1.1);
	if(distance(level.hesh.origin,level.elias.origin) < 300)
	{
		level.hesh.animplaybackrate = 1.2;
		level.hesh maps\_utility::disable_exits();
		level.hesh maps\_anim::anim_generic_run(level.hesh,"suprise_stop");
		level.hesh.animplaybackrate = 1;
	}
	else
	{
		level.hesh.moveplaybackrate = 1.05;
	}

	wait(0.1);
	level.hesh maps\_utility::func_2C9C();
	level.hesh maps\_utility::func_2CB1();
}

//Function Number: 25
func_559E()
{
	common_scripts\utility::flag_wait("start_mansion");
	self notify("stop_loop");
	self delete();
}

//Function Number: 26
func_559D(param_00)
{
	self endon("death");
	level endon("car_stop_damage");
	for(;;)
	{
		if(level.player istouching(param_00))
		{
			level.player dodamage(300,(0,0,0));
			level notify("new_quote_string");
			setdvar("ui_deadquote",&"YOUNGBLOOD_AVOIDCARS");
			maps\_utility::func_52F2();
		}

		wait(0.3);
	}
}

//Function Number: 27
func_5599()
{
	common_scripts\utility::flag_wait("watchout_car");
	thread common_scripts\utility::exploder("exp09");
}

//Function Number: 28
func_559A()
{
	common_scripts\utility::flag_wait("town_car_spawn");
	level.elias maps\_utility::func_252F(2,::maps\_utility::func_7628,"youngblood_hsh_careful");
	wait(3.5);
	thread maps/youngblood_util::func_507E("manxrock",7);
	level.elias maps\_utility::func_7628("youngblood_els_itsnotanearthquake");
	wait(0.4);
	level.hesh thread maps\_utility::func_7628("youngblood_hsh_whatareyoutalkin");
	var_00 = common_scripts\utility::func_39BD("elias_neighborhood_cmon");
	level.elias notify("stop_path");
	var_00 maps\_anim::anim_generic_reach(level.elias,"youngblood_elias_jog_twitch_3");
	level.elias thread maps\_utility::func_3490(common_scripts\utility::func_39BD("elias_mansion_ext_exit_pos"));
	var_00 thread maps\_anim::func_D68(level.elias,"youngblood_elias_jog_twitch_3");
	level.elias maps\_utility::func_7628("youngblood_els_heshtakeyourbrother");
	level.hesh thread maps\_utility::func_7628("youngblood_hsh_butdad");
	thread func_5080();
	level.hesh maps\_utility::enable_sprint();
	level.player thread maps/youngblood_util::func_8E8D(78,2);
	level.hesh maps\_utility::disable_exits();
	var_00 = common_scripts\utility::func_39BD("hesh_neighborhood_cmon");
	var_00 maps\_anim::anim_generic_reach(level.hesh,"yb_uphill_splitup_hesh");
	level.hesh thread maps\_utility::func_3490(common_scripts\utility::func_39BD("mansion_ext_pos_hesh"));
	var_00 maps\_anim::func_D68(level.hesh,"yb_uphill_splitup_hesh");
	wait(0.1);
	level.hesh maps\_utility::func_2CB1();
	wait(2);
	level.hesh thread maps\_utility::func_7628("youngblood_hsh_whatthehellis");
}

//Function Number: 29
func_507F()
{
	common_scripts\utility::flag_wait("start_mansion_ext");
	level.hesh.anim_blend_time_override = undefined;
	level.elias.anim_blend_time_override = undefined;
	level.var_5E87 = "vfx_yb_onplayer_04_mansionhill";
	thread common_scripts\utility::exploder("exp10");
	thread mansion_flyaway_birds_sfx();
	thread func_5083();
	thread common_scripts\utility::exploder("exp11");
	common_scripts\utility::flag_wait("player_top_hill");
	thread common_scripts\utility::exploder("exp12");
	common_scripts\utility::flag_wait("hesh_climbs_into_mansion");
	level.hesh maps\_utility::disable_exits();
	level.hesh maps/youngblood_util::func_6F2D(1.1);
	level.player thread maps/youngblood_util::func_8E8D(70,2);
	level.hesh maps\_utility::func_7628("youngblood_hsh_thiswayloganclimb");
	wait(2);
	level.hesh maps\_utility::func_7628("youngblood_hsh_itsnotsafeout");
}

//Function Number: 30
mansion_flyaway_birds_sfx()
{
	var_00 = spawn("script_origin",(1235,-104262,-114722));
	var_00 playsound("scn_yb_birds_flyaway","sounddone");
	var_00 moveto((1437,-105698,-114721),6);
	wait(20);
	var_00 delete();
}

//Function Number: 31
func_5083()
{
	common_scripts\utility::flag_wait("pool_crack");
	level.player thread maps\_utility::func_5D23("scn_quake_10");
	thread common_scripts\utility::func_5D1F("scn_pool_quake_01",level.player.origin);
	thread common_scripts\utility::func_5D1F("yb_shg_harb_boat_slowmo_splash",(956,-103469,-114737));
	thread common_scripts\utility::func_5D1F("yb_elm_flood_debris_splash_03",(924,-103639,-114792));
	thread common_scripts\utility::func_5D1F("yb_water_splash_lrg_02",(727,-103579,-114735));
	thread common_scripts\utility::func_5D1F("yb_water_fountain_splash_05",(1213,-103950,-114735));
	maps\_utility::func_252F(2,::common_scripts\utility::func_5D1F,"yb_uw_pov_splash_04",(1081,-103934,-114834));
	thread maps\_utility::activate_trigger_with_noteworthy("pool_crack_trig");
	common_scripts\utility::exploder("exp13");
	thread maps/youngblood_util::heavy_quake(75);
	thread mansion_sfx_crumbling();
	var_00 = common_scripts\utility::func_39BD("pool_foam_ref");
	playfxontag(common_scripts\utility::func_3AB9("ygb_pool_surface_follow"),var_00,"tag_origin");
	wait(20);
	var_00 delete();
}

//Function Number: 32
mansion_sfx_crumbling()
{
	wait(1.75);
	thread common_scripts\utility::func_5D1F("scn_yb_house_crumble",(973,-103355,-114695));
	thread common_scripts\utility::func_5D1F("scn_yb_house_crumble",(415,-103773,-114681));
	maps\_utility::func_252F(0.5,::common_scripts\utility::func_5D1F,"scn_yb_house_debris",(423,-103614,-114527));
	maps\_utility::func_252F(0.9,::common_scripts\utility::func_5D1F,"scn_yb_house_debris",(761,-103372,-114516));
	maps\_utility::func_252F(1.2,::common_scripts\utility::func_5D1F,"scn_yb_house_debris",(522,-103427,-114227));
	maps\_utility::func_252F(2.3,::common_scripts\utility::func_5D1F,"scn_yb_house_tile_debris",(227,-103826,-114675));
	maps\_utility::func_252F(4,::common_scripts\utility::func_5D1F,"scn_yb_house_tile_debris",(648,-103344,-114497));
	maps\_utility::func_252F(1.5,::common_scripts\utility::func_5D1F,"scn_yb_house_explo_debris",(400,-103818,-114666));
}

//Function Number: 33
func_5080()
{
	level.elias thread maps\_utility::func_7628("youngblood_els_justdoitson");
	level.cloud_sfx_base_wait_min = 0.7;
	level.cloud_sfx_base_wait_max = 1.4;
	level.cloud_sfx_design_wait_min = 3.5;
	level.cloud_sfx_design_wait_max = 6.3;
	level.elias maps/youngblood_util::func_6F2D(1.2);
	common_scripts\utility::flag_wait("start_mansion");
	level.elias delete();
}

//Function Number: 34
func_5079()
{
	if(!maps\_utility::game_is_current_gen())
	{
		function_0168("r_mbEnable","0");
	}

	var_00 = common_scripts\utility::func_39BD("mansion_middle_door_left");
	var_01 = common_scripts\utility::func_39BD("clip_mansion_mid_door_L");
	var_02 = common_scripts\utility::func_7836();
	var_02.origin = var_00.origin;
	var_02.angles = var_00.angles;
	var_02.animname = "door";
	var_02 maps\_anim::func_6FE5();
	var_01 linkto(var_02);
	var_00 linkto(var_02,"tag_origin",(0,0,0),(0,180,0));
	var_03 = common_scripts\utility::func_39BD("mansion_middle_door_right");
	var_04 = common_scripts\utility::func_39BD("clip_mansion_mid_door_R");
	var_05 = common_scripts\utility::func_7836();
	var_05.origin = var_03.origin;
	var_05.angles = var_03.angles;
	var_05.animname = "door";
	var_05 maps\_anim::func_6FE5();
	var_04 linkto(var_03);
	var_03 linkto(var_05);
	if(isdefined(level.var_61E7) && level.var_61E7 == 1)
	{
		level.player setviewmodel("viewhands_gs_hostage_clean");
		level.var_6AF3["player_rig"] = "viewhands_player_gs_hostage_clean";
	}

	common_scripts\utility::flag_wait("start_mansion");
	thread maps/youngblood_util::func_507E("manprock",6);
	level notify("pre_mansion_done");
	common_scripts\utility::trigger_off("player_near_mansion_door","targetname");
	maps/youngblood_util::func_278B();
	common_scripts\utility::trigger_off("player_near_2nd_door","targetname");
	common_scripts\utility::trigger_off("trig_player_enter_2nd_door","targetname");
	common_scripts\utility::trigger_off("player_near_mansion_exit","targetname");
	var_06 = getent("mansion_front_door_left","targetname");
	level.hesh notify("stop_path");
	var_07 = common_scripts\utility::func_39BD("mansion_anim_ref");
	var_07 maps\_anim::anim_generic_reach(level.hesh,"youngblood_house_entry_friendly");
	var_08 = common_scripts\utility::func_39BD("mansion_front_door_left");
	var_09 = common_scripts\utility::func_39BD("clip_mansion_front_door_L");
	var_0A = common_scripts\utility::func_7836();
	var_0A.origin = var_08.origin;
	var_0A.angles = var_08.angles;
	var_0A.animname = "door";
	var_0A maps\_anim::func_6FE5();
	var_09 linkto(var_08);
	var_08 linkto(var_0A);
	var_07 thread maps\_anim::anim_single_solo(var_0A,"youngblood_house_entry_door");
	var_07 maps\_anim::func_D64(level.hesh,"youngblood_house_entry_friendly");
	var_07 thread maps\_anim::anim_generic_loop(level.hesh,"youngblood_house_entry_idle");
	var_07 thread maps\_anim::anim_loop_solo(var_0A,"youngblood_house_entry_door_idle");
	thread maps/youngblood_util::chaos_kill_after_time(10);
	thread maps\_utility::func_7C22("evilclouds");
	var_0B = common_scripts\utility::func_39BD("clip_player_mansion_door");
	var_0B delete();
	common_scripts\utility::func_837B("player_near_mansion_door","targetname");
	maps\_utility::func_83B0("player_near_mansion_door");
	level notify("stop_rog_strikes");
	level notify("player_safe");
	level notify("stop_mansion_exploders");
	level notify("car_stop_damage");
	var_07 notify("stop_loop");
	var_0C = maps\_utility::func_777F("player_rig",level.player.origin);
	var_0C hide();
	level.cloud_sfx_base_wait_min = 1.2;
	level.cloud_sfx_base_wait_max = 2.4;
	level.cloud_sfx_design_wait_min = 12;
	level.cloud_sfx_design_wait_max = 20;
	level.player method_83BF("youngblood_house",1.5);
	level notify("player_goes_into_mansion");
	maps\_utility::autosave_by_name_silent("in_mansion");
	var_07 maps\_anim::anim_first_frame_solo(var_0C,"youngblood_house_entry_player");
	maps/youngblood_util::func_89B9();
	thread mansion_hesh(var_07);
	var_07 thread maps\_anim::anim_single_solo(var_0A,"youngblood_house_entry_door_close");
	level.player playerlinktoblend(var_0C,"tag_player",0.5,0.2,0);
	var_0C common_scripts\utility::delaycall(0.5,::show);
	level.player maps\_utility::func_252F(1.5,::maps\_utility::func_5D23,"scn_quake_11");
	level.player common_scripts\utility::delaycall(1.5,::playrumbleonentity,"light_2s");
	common_scripts\utility::func_5683(1.5,::earthquake,0.4,2.5,level.player.origin,512);
	maps\_utility::func_252F(1.5,::common_scripts\utility::exploder,"exp14");
	maps\_utility::func_252F(1.5,::exp14_sounds);
	var_07 maps\_anim::anim_single_solo(var_0C,"youngblood_house_entry_player");
	maps/youngblood_util::func_89B8();
	level.player unlink();
	var_0C delete();
	level.player maps\_utility::func_252F(5,::func_5F90);
	level.var_5E87 = "vfx_yb_onplayer_05_mansion";
	common_scripts\utility::flag_wait("hesh_finish_1st");
	level.hesh.anim_playsound_func = ::_playsound;
	var_07 thread maps\_anim::anim_single_solo(var_02,"youngblood_house_2nd_door_1");
	var_07 thread maps\_anim::anim_single_solo(var_05,"youngblood_house_2nd_door_2");
	var_07 thread maps\_anim::func_D64(level.hesh,"youngblood_house_2nd_room_friendly");
	thread func_5082(var_07);
	thread maps/youngblood_util::chaos_kill_after_time(6);
	common_scripts\utility::func_837B("trig_player_enter_2nd_door","targetname");
	common_scripts\utility::flag_wait("player_enter_2nd_door");
	level notify("player_safe");
	common_scripts\utility::func_337C("player_unsafe");
	waittillframeend;
	level.cloud_sfx_base_wait_min = 0.6;
	level.cloud_sfx_base_wait_max = 1.6;
	level.cloud_sfx_design_wait_min = 3.5;
	level.cloud_sfx_design_wait_max = 6;
	level.player thread func_5DF8();
	level.var_5E87 = "vfx_yb_onplayer_06_mansion";
	thread func_507D(var_07);
	common_scripts\utility::func_837B("player_near_mansion_exit","targetname");
	thread maps/youngblood_util::chaos_kill_after_time(16);
	common_scripts\utility::flag_wait("player_near_mansion_exit");
	level notify("player_safe");
	common_scripts\utility::func_337C("player_unsafe");
	var_0C = maps\_utility::func_777F("player_rig",level.player.origin);
	var_0C hide();
	var_07 maps\_anim::anim_first_frame_solo(var_0C,"youngblood_house_exit_player");
	level.player playerlinktoblend(var_0C,"tag_player",0.5);
	maps/youngblood_util::func_89B9();
	var_0C show();
	var_08 = common_scripts\utility::func_39BD("mansion_exit_door_left");
	var_0D = common_scripts\utility::func_39BD("clip_mansion_exit_door_L");
	var_0E = common_scripts\utility::func_7836();
	var_0E.origin = var_08.origin;
	var_0E.angles = var_08.angles;
	var_0E.animname = "door";
	var_0E maps\_anim::func_6FE5();
	var_0D linkto(var_08);
	var_08 linkto(var_0E);
	var_0F = common_scripts\utility::func_39BD("mansion_exit_door_right");
	var_10 = common_scripts\utility::func_7836();
	var_10.origin = var_0F.origin;
	var_10.angles = var_0F.angles;
	var_10.animname = "door";
	var_10 maps\_anim::func_6FE5();
	var_0F linkto(var_10);
	var_07 notify("stop_loop");
	level.hesh common_scripts\utility::delaycall(0.2,::stopsounds);
	var_07 maps\_utility::func_252F(0.1,::maps\_anim::func_D64,level.hesh,"youngblood_house_exit_friendly_open_door");
	var_07 maps\_utility::func_252F(0.1,::maps\_anim::anim_single_solo,var_0C,"youngblood_house_exit_player");
	var_07 thread maps\_anim::anim_single_solo(var_0E,"youngblood_house_exit_door_1");
	var_07 thread maps\_anim::anim_single_solo(var_10,"youngblood_house_exit_door_2");
	common_scripts\utility::exploder("tospace");
	level.player maps\_utility::func_252F(3.7,::maps/youngblood_util::func_5E2A);
	maps\_utility::func_252F(3.8,::maps\_utility::func_8A02,"ygb_mansion_int_a_bloom",0.3);
	maps\_utility::func_252F(3.9,::common_scripts\utility::exploder,"mansion_door_reveal_a");
	common_scripts\utility::func_5683(4.1,::etslowmotion,1,0.2,0.25);
	maps\_utility::func_252F(4,::maps\_hud_util::fade_out,0.35,"white");
	level.player common_scripts\utility::delaycall(4,::method_83BF,"youngblood_white_transition",0.25);
	maps\_utility::func_252F(3.6,::common_scripts\utility::func_5D1F,"scn_yb_house_transition_to_odin_lr",level.player.origin);
	if(isdefined(level.var_61E7) && level.var_61E7 == 1)
	{
		common_scripts\utility::func_5683(4.65,::etslowmotion,0.2,1,5);
	}

	wait(4.4);
	resetsunlight();
	function_01B2();
	maps\_utility::func_7C22("deer_hut_tremor_a");
	maps\_utility::func_7C22("exp02");
	maps\_utility::func_7C22("exp04");
	maps\_utility::func_7C22("exp06");
	maps\_utility::func_7C22("exp07");
	maps\_utility::func_7C22("exp09");
	maps\_utility::func_7C22("exp10");
	maps\_utility::func_7C22("exp11");
	maps\_utility::func_7C22("exp12");
	maps\_utility::func_7C22("exp09");
	maps\_utility::func_7C22("exp13");
	maps\_utility::func_7C22("evilclouds");
	level.hesh.anim_playsound_func = undefined;
	thread maps\_utility::func_36A8("yb_fx_volume_1");
	var_07 thread maps\_anim::anim_generic_loop(level.hesh,"youngblood_house_exit_idle_friendly","stop_hesh_door_idle");
	level notify("stop_player_heartbeat");
	thread maps\_art::func_7D49("default",0);
	thread maps\_utility::func_8A02("",0.05);
	level.hesh notify("stop_hesh_door_idle");
	level notify("stop_vfx_on_player");
	level.hesh maps\_utility::func_7C38();
	level.hesh delete();
	var_08 unlink();
	var_0F unlink();
	level.player unlink();
	var_0C delete();
	maps\_utility::func_6523("close_to_hesh");
	maps\_utility::activate_trigger_with_targetname("yb_ground_fx_off");
	if(isdefined(level.var_61E7) && level.var_61E7 == 1)
	{
		var_11 = function_016B();
		common_scripts\utility::array_call(var_11,::delete);
		setdvar("hud_showObjectives",1);
		function_0168("ammoCounterHide","0");
		common_scripts\utility::flag_set("start_transition_to_odin");
		thread maps\_art::func_7D49("odin_default",0);
	}
}

//Function Number: 35
exp14_sounds()
{
	var_00 = (475,-103369,-114522);
	var_01 = (439,-103301,-114704);
	wait(2.5);
	var_02 = common_scripts\utility::func_7836();
	var_02.origin = var_00;
	var_02 thread maps\_utility::func_5D23("scn_yb_glass_wood_burst");
	var_02 moveto(var_01,1);
	var_02 waittill("movedone");
	wait(3);
	var_02 delete();
}

//Function Number: 36
func_507D(param_00)
{
	if(common_scripts\utility::flag("hesh_middle_room_in_position"))
	{
		param_00 maps\_anim::func_D64(level.hesh,"youngblood_house_knockdown_friendly");
	}
	else
	{
		wait(1.2);
	}

	param_00 maps\_anim::func_D64(level.hesh,"youngblood_house_exit_friendly");
	if(common_scripts\utility::flag("player_near_mansion_exit") == 0)
	{
		param_00 thread maps\_anim::anim_generic_loop(level.hesh,"youngblood_house_exit_friendly_idle");
		common_scripts\utility::flag_wait("player_near_mansion_exit");
		param_00 notify("stop_loop");
	}
}

//Function Number: 37
func_5082(param_00)
{
	if(common_scripts\utility::flag("player_enter_2nd_door") == 0)
	{
	}

	param_00 waittill("youngblood_house_2nd_room_friendly");
	if(common_scripts\utility::flag("player_enter_2nd_door") == 0)
	{
		common_scripts\utility::flag_set("hesh_middle_room_in_position");
		param_00 thread maps\_anim::anim_generic_loop(level.hesh,"youngblood_house_2nd_room_idle_friendly");
		common_scripts\utility::flag_wait("player_enter_2nd_door");
		param_00 notify("stop_loop");
	}
}

//Function Number: 38
mansion_hesh(param_00)
{
	param_00 maps\_anim::func_D64(level.hesh,"youngblood_house_1st_room_friendly");
	common_scripts\utility::flag_set("hesh_finish_1st");
}

//Function Number: 39
chaos_a()
{
	if(!maps\_utility::game_is_current_gen())
	{
		function_0168("r_mbEnable","0");
	}

	if(level.xenon)
	{
		function_0168("r_texFilterProbeBilinear",1);
	}

	if(maps\_utility::game_is_current_gen())
	{
		function_0168("sm_sunshadowscale",0.55);
	}

	if(isdefined(level.var_61E7) && level.var_61E7)
	{
		common_scripts\utility::flag_wait("prologue_transient_ground_tr_loaded");
	}
	else
	{
		maps\_hud_util::fade_out(0,"white");
	}

	common_scripts\utility::func_837B("start_chaos_a","targetname");
	maps\_utility::func_83B0("start_chaos_a");
	maps\_utility::func_8A02("",0);
	level.player method_83BF("youngblood_slomo_impact",0.2);
	function_0199("voice",0.1);
	function_0168("ammoCounterHide","1");
	thread func_83A3();
	common_scripts\utility::func_F1B(getentarray("street_2_start_movement","targetname"),::func_71A3);
	common_scripts\utility::func_F1B(getentarray("trig_player_chaos_quake","targetname"),::chaos_quake_trigger_think);
	common_scripts\utility::func_F1B(getentarray("trig_player_rog","targetname"),::chaos_rog_think);
	common_scripts\utility::func_F1B(getentarray("street_2_start_movement","targetname"),::func_5D2F);
	common_scripts\utility::func_F1B(getentarray("script_sfx_for_movers","targetname"),::sfx_for_p_r_s_t_pieces);
	thread func_7834();
	thread func_71A2();
	thread func_5D2E();
	maps/youngblood_util::func_77D7();
	level.hesh maps/youngblood_util::enable_hesh_walk();
	maps/youngblood_util::set_start_positions("start_chaos_a");
	level.hesh.dontchangepushplayer = 1;
	level.hesh.pushable = 0;
	level.hesh.var_624F = 1;
	level.hesh method_8222(1);
	level.hesh maps\_utility::disable_sprint();
	level.hesh maps/youngblood_util::init_chaos_animset();
	level.player setviewmodel("viewhands_gs_hostage_clean");
	level.var_6AF3["player_rig"] = "viewhands_player_gs_hostage_clean";
	level.player takeallweapons();
	level.player giveweapon("noweapon_youngblood+yb_state_chaos");
	level.player switchtoweaponimmediate("noweapon_youngblood+yb_state_chaos");
	level.player method_8276(0);
	level.player setstance("stand");
	level.player allowsprint(0);
	level.player thread maps/youngblood_util::func_8E8D(25);
	thread maps/youngblood_util::func_6F7D(1.15);
	maps/youngblood_util::func_89B9();
	var_00 = common_scripts\utility::func_39BD("mansion_anim_ref");
	var_01 = addstruct();
	var_01.origin = var_00.origin + (0,0,3);
	var_01.angles = var_00.angles;
	var_02 = common_scripts\utility::func_39BD("mansion_exit_door_left");
	var_02.origin = (181,-102857,-114632);
	var_02.angles = (0,295.6,0);
	var_03 = common_scripts\utility::func_7836();
	var_03.origin = var_02.origin;
	var_03.angles = var_02.angles;
	var_03.animname = "door";
	var_03 maps\_anim::func_6FE5();
	var_02 linkto(var_03);
	var_04 = common_scripts\utility::func_39BD("mansion_exit_door_right");
	var_05 = common_scripts\utility::func_7836();
	var_05.origin = var_04.origin;
	var_05.angles = var_04.angles;
	var_05.animname = "door";
	var_05 maps\_anim::func_6FE5();
	var_04 linkto(var_05);
	var_06 = maps\_utility::func_777F("player_rig",level.player.origin);
	var_06 hide();
	var_01 maps\_anim::anim_first_frame_solo(var_06,"youngblood_house_exit_player_part2");
	var_00 thread maps\_anim::anim_loop_solo(var_03,"youngblood_house_exit_idle_door_1");
	var_00 thread maps\_anim::anim_loop_solo(var_05,"youngblood_house_exit_idle_door_2");
	var_00 thread maps\_anim::anim_generic_loop(level.hesh,"youngblood_house_exit_idle_friendly");
	var_07 = 0;
	level.hesh maps/youngblood_util::func_6F2D(1.02);
	level.player method_82A0(0.3,0.3);
	level.player playerlinktodelta(var_06,"tag_player",1,0,0,0,0);
	level.player common_scripts\utility::delaycall(1,::lerpviewangleclamp,1,1,0,20,20,20,20);
	var_06 show();
	common_scripts\utility::flag_wait("transition_from_odin_to_yb_done");
	common_scripts\utility::flag_wait_all("load_1","load_2","load_3");
	thread chaos_b_hide_debris();
	function_0168("cg_fov",65);
	thread chaos_cull_think();
	thread maps\youngblood_fx::func_8991();
	level.player thread maps\_utility::func_5D23("scn_yb_rog_impact_lr");
	wait(0.5);
	maps\_utility::func_252F(2.7,::common_scripts\utility::flag_set,"play_street_cracking");
	var_00 notify("stop_loop");
	var_00 thread maps\_anim::anim_first_frame_solo(var_03,"youngblood_house_exit_door_1_part2");
	var_00 thread maps\_anim::anim_first_frame_solo(var_05,"youngblood_house_exit_door_2_part2");
	etslowmotion(1,0.4,0);
	thread maps\_hud_util::func_3131(0.5,"white");
	level.hesh thread chaos_a_hesh_run(var_00);
	var_01 thread maps\_anim::anim_single_solo(var_06,"youngblood_house_exit_player_part2");
	var_00 thread maps\_anim::anim_single_solo(var_03,"youngblood_house_exit_door_1_part2");
	var_00 thread maps\_anim::anim_single_solo(var_05,"youngblood_house_exit_door_2_part2");
	common_scripts\utility::func_5683(1.5,::playrumbleonposition,"prologue_chaos_a",level.player.origin + (0,0,700));
	var_00 = common_scripts\utility::func_39BD("mid_street_ref");
	level.player maps\_utility::func_252F(2.4,::chaos_moving_head,var_06);
	wait(4.1);
	etslowmotion(0.4,1,0.15);
	level.player method_83BF("youngblood_chaos",1.5);
	maps\_utility::add_extra_autosave_check("close_to_hesh",::maps/youngblood_util::func_1B4E,"too far from hesh");
	level.player method_82A1();
	level.player thread maps/youngblood_util::func_8E8D(89,4);
	level.player common_scripts\utility::delaycall(4,::allowsprint,1);
	level thread maps\_utility::func_11BF();
	thread func_1AF5();
	thread maps/youngblood_util::chaos_checkpoint(15);
	thread maps/youngblood_util::player_unlink_slide_on_death();
	thread chaos_moving_clip();
	thread func_835E();
	level.player thread maps\youngblood_fx::func_898E();
	maps/youngblood_util::func_278B();
	common_scripts\utility::flag_wait("hesh_sequence_done");
	level.hesh maps\_utility::disable_exits();
	level.hesh maps\_utility::func_3490(common_scripts\utility::func_39BD("025_stumble"),9999);
	level.hesh maps\_utility::disable_exits();
	var_00 = common_scripts\utility::func_39BD("mid_street_ref");
	level.hesh maps\_utility::disable_exits();
	var_00 maps/youngblood_util::anim_generic_reach_and_animate(level.hesh,"yb_car_jump_slide");
	level.hesh maps\_utility::disable_exits();
	wait(0.1);
	level.hesh maps\_utility::func_252F(2,::maps\_utility::func_7628,"youngblood_hsh_keeprunningwecan");
	level.hesh thread maps\_utility::follow_path(common_scripts\utility::func_39BD("040_sidewalk_pos"),9999);
	level.hesh maps\_utility::disable_exits();
	wait(0.1);
	level.hesh maps\_utility::func_252F(2,::maps\_utility::func_7628,"youngblood_hsh_throughthathouse");
	var_00 maps/youngblood_util::anim_generic_reach_and_animate(level.hesh,"yb_cliff_jump_hesh");
	level.hesh maps\_utility::disable_exits();
	level.hesh thread maps\_utility::follow_path(common_scripts\utility::func_39BD("060_exithouse_pos"),9999);
	wait(0.5);
	common_scripts\utility::flag_set("house_k2_k3_anim");
	wait(3.5);
	var_00 = common_scripts\utility::func_39BD("housejump_anim_ref");
	thread func_1AED(var_00);
	thread func_1AE9(var_00);
	common_scripts\utility::flag_wait("trig_player_inside_house");
	waittillframeend;
	level.hesh maps\_utility::func_3490(common_scripts\utility::func_39BD("forward_walk_into"),9999);
	level.hesh maps\_utility::follow_path(common_scripts\utility::func_39BD("exit_basement_pos"),9999);
	var_00 = common_scripts\utility::func_39BD("debris_door_ref");
	var_08 = getent("basement_debris_door","targetname");
	var_09 = maps\_utility::func_777F("tag_origin",var_08.origin);
	var_09.angles = var_08.angles;
	var_08 linkto(var_09,"tag_origin");
	var_00 maps\_anim::anim_first_frame_solo(var_09,"youngblood_basement_approach_debris_1");
	var_00 maps\_anim::anim_reach_solo(level.hesh,"youngblood_basement_approach_hesh");
	level.hesh maps\_utility::disable_exits();
	var_00 thread maps\_anim::anim_single_solo(level.hesh,"youngblood_basement_approach_hesh");
	level.hesh maps\_utility::disable_exits();
	var_08 notsolid();
	var_00 maps\_anim::anim_single_solo(var_09,"youngblood_basement_approach_debris_1");
	if(common_scripts\utility::flag("player_near_debris_door") == 0)
	{
		thread maps/youngblood_util::chaos_kill_after_time(4);
		var_00 thread maps\_anim::anim_loop_solo(level.hesh,"youngblood_basement_idle_hesh");
		var_00 thread maps\_anim::anim_loop_solo(var_09,"youngblood_basement_idle_debris_1");
		level.hesh thread maps\_utility::func_7628("youngblood_hsh_getupherelogan");
		common_scripts\utility::flag_wait("player_near_debris_door");
		var_00 notify("stop_loop");
	}

	common_scripts\utility::flag_wait("player_near_debris_door");
	level notify("player_safe");
	common_scripts\utility::func_337C("player_unsafe");
	maps\_utility::activate_trigger_with_targetname("basement_vfx_trig");
	maps\_utility::activate_trigger_with_noteworthy("street_flying_house");
	var_0A = getent("street_flying_chunk_sound","targetname");
	var_0A maps\_utility::func_252F(1,::maps\_utility::func_5D23,"scn_yb_final_big_street_piece_incoming");
	thread maps/youngblood_util::func_6747();
	maps\_utility::func_252F(1,::common_scripts\utility::func_5D1F,"scn_yb_final_big_street_piece_hit_quake",level.player.origin);
	var_0A maps\_utility::func_252F(2,::maps\_utility::func_5D23,"scn_yb_final_big_street_piece_hit");
	thread maps\_utility::func_252F(2,::maps/youngblood_util::heavy_quake,85);
	level.hesh maps\_utility::disable_exits();
	var_08 thread maps\_utility::func_5D23("scn_hesh_break_wood_wall");
	thread common_scripts\utility::func_5D1F("scn_yb_gate_blow_away_layer",level.player.origin);
	var_00 thread maps\_anim::anim_single_solo(var_09,"youngblood_basement_exit_debris_1");
	level.hesh maps\_utility::func_252F(0.5,::maps\_utility::func_3490,common_scripts\utility::func_39BD("chaos_b_run"),0);
	var_00 maps\_anim::anim_single_solo(level.hesh,"youngblood_basement_exit_hesh");
	level.hesh maps\_utility::disable_exits();
	common_scripts\utility::flag_set("start_chaos_b");
}

//Function Number: 40
chaos_cull_think()
{
	if(maps\_utility::func_47F6())
	{
		thread maps\_art::disable_ssao_over_time(1);
	}

	maps\_utility::func_8A02("ygb_chaos_a_lessfog",0);
	wait(4.5);
	var_00 = 1;
	if(level.xb3)
	{
		maps\_utility::func_8A02("ygb_chaos_a_durango",var_00);
	}
	else
	{
		maps\_utility::func_8A02("",var_00);
	}

	wait(var_00);
	common_scripts\utility::func_8AFE();
	if(maps\_utility::func_47F6())
	{
		function_0168("r_umbraUseDpvsCullDist",1);
		if(level.xb3)
		{
			function_01A7(3000);
		}

		function_01A7(3000);
	}

	function_01A7(2500);
}

//Function Number: 41
chaos_cull_more()
{
	var_00 = 2;
	if(level.xb3)
	{
		maps\_utility::func_8A02("ygb_chaos_a_nearfog_durango",var_00);
	}
	else
	{
		maps\_utility::func_8A02("ygb_chaos_a_nearfog",var_00);
	}

	wait(var_00);
	common_scripts\utility::func_8AFE();
	if(maps\_utility::func_47F6())
	{
		if(level.xb3)
		{
			function_01A7(1500);
		}

		function_01A7(1500);
	}

	function_01A7(1500);
}

//Function Number: 42
func_1AF5()
{
	var_00 = common_scripts\utility::func_3C1A("chaos_falling_debris","script_noteworthy");
	for(;;)
	{
		var_01 = anglestoforward(level.player.angles);
		var_01 = var_01 * 400;
		var_02 = sortbydistance(var_00,level.player.origin + var_01);
		thread maps/youngblood_util::falling_debris(var_02[randomintrange(0,5)]);
		wait(randomfloatrange(2,6));
	}
}

//Function Number: 43
chaos_rog_think()
{
	self waittill("trigger");
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "rog_a")
	{
		common_scripts\utility::exploder("chaos_a_street_rog");
		thread maps/youngblood_util::rog_incoming_light();
		thread rog_moving_sound("yb_rog_passby_after_slide",(1939,-93269,-110847),(-18834,-96188,-116563),2.5);
		thread common_scripts\utility::func_5D1F("yb_rog_passby_after_slide_impact",(-4479,-100695,-115627));
		thread chaos_cull_more();
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "rog_b")
	{
		common_scripts\utility::exploder("chaos_b_street_rog");
		thread maps/youngblood_util::rog_incoming_light();
		thread rog_moving_sound("yb_rog_passby_after_house",(-11319,-84999,-104714),(-18196,-96740,-117043),2.2);
		thread common_scripts\utility::func_5D1F("yb_rog_passby_after_house_impact",(-4479,-100695,-115627));
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "rog_c")
	{
		thread maps/youngblood_util::rog_incoming_light();
		thread common_scripts\utility::exploder("chaos_b_street_rog");
		thread rog_moving_sound("scn_yb_truck_rog_incoming",(-11703.3,-84861.8,-104786),(-17991,-96915,-116704),2);
		thread common_scripts\utility::func_5D1F("scn_yb_truck_rog_incoming_start",(-11703.3,-84861.8,-104786));
		wait(2);
		level.player method_83BF("youngblood_final_rog_hit",0.2);
		thread common_scripts\utility::func_5D1F("scn_yb_truck_rog_hit_r",(-5197,-94215,-113286));
		thread common_scripts\utility::func_5D1F("scn_yb_truck_rog_hit_c",(-6698,-95854,-113371));
		thread common_scripts\utility::func_5D1F("scn_yb_truck_rog_hit_l",(-7020,-98983,-113352));
		thread common_scripts\utility::func_5D1F("scn_yb_truck_rog_hit_lfe",(-6698,-95854,-113371));
	}
}

//Function Number: 44
rog_moving_sound(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_origin",param_01);
	var_04 moveto(param_02,param_03);
	var_04 playsound(param_00,"rog_sound_done");
	var_04 waittill("rog_sound_done");
	common_scripts\utility::func_8AFE();
	var_04 delete();
}

//Function Number: 45
chaos_moving_head(param_00)
{
	var_01 = 25;
	function_0168("hud_showStance",1);
	maps/youngblood_util::func_89B8();
	level.player freezecontrols(0);
	level.player unlink();
	param_00 delete();
	level.var_5EB5 = 1;
	level.player allowsprint(0);
}

//Function Number: 46
chaos_moving_clip()
{
	var_00 = common_scripts\utility::func_39BD("moving_clip_start");
	var_01 = common_scripts\utility::func_3C18("moving_clip_dest","targetname");
	var_00 delete();
}

//Function Number: 47
func_1AE9(param_00)
{
	level endon("player_jumped_into_house");
	if(!common_scripts\utility::flag("player_jumped_into_house"))
	{
		level.hesh maps\_utility::disable_exits();
		param_00 maps\_anim::anim_reach_solo(level.hesh,"yb_roof_landing");
		param_00 maps\_anim::anim_single_solo(level.hesh,"yb_roof_landing");
		thread maps/youngblood_util::chaos_kill_after_time(7);
		thread func_1AEC();
		param_00 thread maps\_anim::anim_loop_solo(level.hesh,"yb_roof_landing_idle","stop_roof_loop");
		thread chaos_a_hesh_jump_breakout(param_00);
	}
}

//Function Number: 48
chaos_a_hesh_jump_breakout(param_00)
{
	common_scripts\utility::flag_wait("player_jumped_into_house");
	param_00 notify("stop_roof_loop");
	level.hesh maps\_utility::disable_exits();
}

//Function Number: 49
func_1AED(param_00)
{
	maps\_utility::func_7C22("a");
	maps\_utility::func_7C22("c");
	maps\_utility::func_7C22("e");
	if(isdefined(level.var_61E7) && level.var_61E7 == 1)
	{
		level.player setviewmodel("viewhands_gs_hostage");
		level.var_6AF3["player_rig"] = "viewhands_player_gs_hostage";
	}

	var_01 = maps\_utility::func_777F("player_rig",level.player.origin);
	param_00 maps\_anim::anim_first_frame_solo(var_01,"youngblood_player_roof_smash");
	var_01 hide();
	common_scripts\utility::flag_wait("player_jumped_into_house");
	level.player playrumbleonentity("damage_heavy");
	thread common_scripts\utility::func_5D1F("scn_yb_player_jump_through_roof",level.player.origin);
	common_scripts\utility::flag_set("suppress_crash_player_fx");
	common_scripts\utility::flag_set("chaos_player_safe");
	level notify("player_safe");
	common_scripts\utility::func_337C("player_unsafe");
	level.player playerlinktoabsolute(var_01,"tag_player");
	var_01 show();
	function_0168("r_znear",0.1);
	param_00 thread maps\_anim::anim_single_solo(var_01,"youngblood_player_roof_smash");
	level.player method_828E(1);
	level.player dodamage(400,(0,0,0));
	level.player maps\_utility::func_5F1D(25);
	common_scripts\utility::flag_set("player_on_house_floor");
	level.player method_828E(1);
	level.player dodamage(400,(0,0,0));
	thread chaos_a_hesh_landing(param_00);
	maps\_utility::func_8A02("",2);
	if(maps\_utility::func_47F6())
	{
		function_0168("r_umbraUseDpvsCullDist",0);
	}

	function_01A7(0);
	param_00 waittill("youngblood_player_roof_smash");
	function_0168("r_znear",4);
	thread func_7393();
	level.player unlink();
	var_01 delete();
	level.player allowsprint(0);
	level.player maps/youngblood_util::func_8E8D(85,7);
	level.player common_scripts\utility::delaycall(7,::allowsprint,1);
	level.player method_828E(0);
	thread func_905C();
}

//Function Number: 50
func_7393()
{
	wait(4);
	level.player method_83BF("youngblood_chaos",1);
}

//Function Number: 51
func_905C()
{
	level.player endon("death");
	var_00 = -98608;
	var_01 = -115125;
	for(;;)
	{
		wait(1);
		if(level.player.origin[1] < var_00 && level.player.origin[2] > var_01)
		{
			level.player method_82E7();
		}
	}
}

//Function Number: 52
func_1AEC()
{
	var_00 = common_scripts\utility::func_39BD("player_exits_house_pos");
}

//Function Number: 53
chaos_a_hesh_landing(param_00)
{
	common_scripts\utility::flag_wait("player_on_house_floor");
	var_01 = common_scripts\utility::func_3C18("landing_spot_hesh","targetname");
	level.hesh method_81FA(var_01.origin,var_01.angles);
	level.hesh method_8225(var_01.origin);
	var_02 = getent("chunk_main_s","targetname");
	var_02 maps\_utility::func_252F(6,::maps\_utility::func_5D23,"scn_yb_house_move4");
	var_02 maps\_utility::func_252F(6,::maps\_utility::func_5D23,"scn_yb_house_move4_layer_lfe");
	var_03 = getent("chaos_pool_table","targetname");
	var_03 maps\_utility::func_252F(11.55,::maps\_utility::func_5D23,"scn_yb_house_pool_table_slide");
	maps\_utility::func_252F(14.5,::common_scripts\utility::func_5D1F,"scn_yb_house_tiles_crashing",(-1572,-97979,-115057));
	maps\_utility::func_252F(14.9,::common_scripts\utility::func_5D1F,"scn_yb_house_tiles_crashing",(-1620,-97966,-115045));
	maps\_utility::func_252F(15.1,::common_scripts\utility::func_5D1F,"scn_yb_house_tiles_crashing",(-1564,-98070,-115075));
	maps\_utility::func_252F(15.7,::common_scripts\utility::func_5D1F,"scn_yb_house_tiles_crashing",(-1505,-98028,-115084));
	maps\_utility::func_252F(16.75,::common_scripts\utility::func_5D1F,"scn_yb_house_tiles_crashing",(-1481,-97841,-115044));
	param_00 maps\_anim::anim_first_frame_solo(level.hesh,"youngblood_hesh_underbar");
	param_00 thread maps\_anim::anim_single_solo(level.hesh,"youngblood_hesh_underbar");
	wait(9);
	level.hesh method_8252();
	level.hesh maps\_utility::disable_exits();
	level.hesh thread maps\_utility::func_7628("youngblood_hsh_runupstairswehave");
	common_scripts\utility::flag_set("trig_player_inside_house");
}

//Function Number: 54
chaos_a_hesh_run(param_00)
{
	param_00 maps\_anim::func_D64(level.hesh,"youngblood_house_exit_friendly_part2");
	maps\_utility::disable_exits();
	level.hesh thread maps\_utility::func_7628("youngblood_hsh_comeonwehave");
	level.hesh maps\_utility::follow_path(common_scripts\utility::func_39BD("piece_01_pos"),2000);
	level.hesh thread func_1AF6();
	level.hesh maps\_utility::func_3490(common_scripts\utility::func_39BD("020_jump"),2000);
	if(distance2d(level.player.origin,level.hesh.origin) < 200)
	{
		thread maps/youngblood_util::heavy_quake(100,50);
	}

	level.hesh thread maps\_utility::func_7628("youngblood_hsh_getacrossquick");
	common_scripts\utility::flag_set("hesh_sequence_done");
}

//Function Number: 55
chaos_b()
{
	common_scripts\utility::flag_wait("start_chaos_b");
	level.player endon("death");
	thread maps/youngblood_util::func_1AF9();
	level notify("stop_vfx_on_player");
	level.var_5EB5 = 1;
	level.var_5E87 = "vfx_yb_onplayer_city_vista_a";
	level.player thread func_898F();
	thread func_5CB5();
	common_scripts\utility::trigger_off("carry_hesh_carry_trig","targetname");
	common_scripts\utility::trigger_off("trig_start_pickup","targetname");
	level notify("stop_chaos_a");
	thread chaos_b_slow_zone();
	level.hesh maps\_utility::disable_exits();
	level.hesh thread maps\_utility::func_7628("youngblood_hsh_justkeeprunning");
	if(level.start_point == "start_chaos_b")
	{
		level.hesh maps\_utility::func_3490(common_scripts\utility::func_39BD("chaos_b_run"),0);
	}
	else
	{
		level.hesh waittill("path_end_reached");
	}

	var_00 = common_scripts\utility::func_39BD("anim_tanker_orig");
	thread func_41C6(var_00);
	var_01 = common_scripts\utility::func_39BD("animate_cab");
	var_01 show();
	var_01.animname = "truck";
	var_01 maps\_anim::func_6FE5();
	level waittill("hesh_in_position");
	wait(2.5);
	level.player playrumbleonentity("light_1s");
	var_01 maps\_utility::func_252F(0.45,::maps\_utility::func_5D23,"scn_yb_truck_incoming");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"youngblood_semitanker_ygb_explode_A");
	var_00 thread maps\_anim::anim_single_solo(var_01,"youngblood_semitanker_ygb_explode_A");
	common_scripts\utility::flag_set("church_fall_go");
	maps\_utility::func_252F(2,::common_scripts\utility::func_5D1F,"scn_yb_truck_ending_lr",level.player.origin);
	level.player common_scripts\utility::delaycall(2.2,::playrumbleonentity,"light_1s");
	common_scripts\utility::func_5683(2.6,::etslowmotion,1,0.33,0.1);
	common_scripts\utility::func_5683(3.5,::etslowmotion,0.33,1,0.5);
	maps\_utility::music_play("mus_prlog_end_reveal");
	level.player maps\_utility::func_252F(3.3,::func_5DF3,var_00,var_01);
	maps\_utility::activate_trigger_with_noteworthy("street_oil_tanker_2");
	maps\_utility::func_252F(3.2,::maps\_utility::func_8A02,"ygb_chaos_b",0.4);
	common_scripts\utility::flag_wait("truck_landed_exit_scene");
	level.player method_83BF("youngblood_tanker_fire",3);
	var_01 delete();
	foreach(var_03 in level.var_7A0)
	{
		var_03 show();
	}
}

//Function Number: 56
func_5DF3(param_00,param_01)
{
	if(!isalive(level.player))
	{
	}

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
	function_0199("hurt",0.25);
	function_0199("auto",0.5);
	function_0168("hud_showStance","0");
	function_0168("compass","0");
	function_0168("ammoCounterHide","1");
	function_0168("g_friendlyNameDist",0);
	function_0168("actionSlotsHide","1");
	function_0168("cg_drawCrosshair","0");
	function_0168("aim_AutoAimRangeScale",0);
	function_0168("aim_aimAssistRangeScale","1");
	function_0168("r_znear",0.5);
	maps/youngblood_util::func_89B9();
	level.hesh.name = " ";
	var_02 = maps\_utility::func_777F("player_rig",self.origin);
	var_03 = spawn("script_model",(0,0,0));
	var_03 setmodel(level.hesh.model);
	var_03.animname = "player_body";
	var_03 maps\_anim::func_6FE5();
	level.player playerlinktoblend(var_02,"tag_player",0.2);
	thread maps\_hud_util::fade_out(1.7);
	level.player setblurforplayer(10,0.85);
	level.player playrumbleonentity("light_2s");
	level.player notify("player_safe");
	level.player shellshock("ygb_end",999);
	var_04 = addstruct();
	var_04.origin = level.player.origin;
	var_04.angles = level.player.angles;
	if(!level.player maps\_utility::func_5E89(param_01.origin,0.7,1))
	{
		var_04.angles = vectortoangles(param_01.origin - level.player.origin);
		var_04.angles = (var_04.angles[0],var_04.angles[1],0);
		var_02 hide();
		var_02 common_scripts\utility::delaycall(0.3,::show);
		var_03 hide();
		var_03 common_scripts\utility::delaycall(0.3,::show);
	}

	var_04 maps\_anim::anim_single([var_02,var_03],"youngblood_tanker_explosion");
	var_04 = undefined;
	common_scripts\utility::flag_set("truck_landed_exit_scene");
	level notify("stop_vfx_on_player");
	level.var_5E87 = "vfx_yb_onplayer_09_truckfire";
	level.player thread func_898F();
	etslowmotion(1,0.5,0.25);
	wait(1);
	maps\_utility::func_252F(0.5,::maps/youngblood_exit_ride::func_777D);
	level.hesh maps\_utility::func_252F(1.25,::maps\_utility::func_7628,"youngblood_hsh_logan");
	maps\_utility::func_252F(0,::maps\_utility::smart_radio_dialogue,"youngblood_hsh_coughing");
	wait(2);
	level.player unlink();
	var_02 hide();
	var_02 delete();
	var_03 delete();
	var_02 = maps\_utility::func_777F("player_rig",level.player.origin);
	var_05 = 20;
	level.player playerlinktoabsolute(var_02,"tag_player");
	level.player playerlinktodelta(var_02,"tag_player",1,var_05,var_05,var_05,0);
	level.elias maps\_utility::func_252F(1.5,::maps\_utility::func_7628,"youngblood_els_heshlogan");
	level.hesh maps\_utility::func_252F(3.5,::maps\_utility::func_7628,"youngblood_hsh_dad_2");
	level.elias maps\_utility::func_252F(5,::maps\_utility::func_7628,"youngblood_els_getinthetruck");
	level.hesh maps\_utility::func_252F(6,::maps\_utility::func_7628,"youngblood_hsh_cmon_2");
	common_scripts\utility::exploder("city");
	var_06 = [var_02,level.hesh];
	param_00 = common_scripts\utility::func_39BD("chaos_end_test");
	param_00 thread maps\_anim::anim_single(var_06,"walkoff");
	wait(0.1);
	common_scripts\utility::func_F1B(var_06,::maps/youngblood_util::_set_anim_time,"walkoff",0.04);
	level.player setblurforplayer(0,3);
	thread maps\_hud_util::func_3131(1);
	wait(3);
	level.player.better = 1;
	wait(4);
	level.player setblurforplayer(10,1);
	maps\_hud_util::fade_out(2);
	var_02 hide();
	level.elias maps\_utility::func_252F(0,::maps\_utility::func_7628,"youngblood_els_isheokis");
	common_scripts\utility::func_8AFE();
	level.var_83D3 notify("elias_car_stop");
	level.elias unlink();
	common_scripts\utility::func_8AFE();
	param_00 = getnode("start_truck_part2_2","script_noteworthy");
	level.var_83D3 attachpath(param_00);
	level.var_83D3 thread maps\_vehicle::func_8902(param_00);
	level.var_83D3 startpath(param_00);
	var_06 = [var_02,level.hesh,level.elias];
	param_00 = common_scripts\utility::func_39BD("chaos_end_test_2");
	param_00 thread maps\_anim::anim_single(var_06,"walkoff");
	wait(0.1);
	common_scripts\utility::func_F1B(var_06,::maps/youngblood_util::_set_anim_time,"walkoff",0.715);
	level.player setblurforplayer(0,3);
	thread maps\_hud_util::func_3131(2.2);
	wait(5.5);
	level.player setblurforplayer(10,1);
	maps\_hud_util::fade_out(2);
	common_scripts\utility::flag_set("start_pickup");
}

//Function Number: 57
func_41C6(param_00)
{
	param_00 maps\_anim::anim_reach_solo(level.hesh,"youngblood_tanker_hesh");
	level notify("hesh_in_position");
	level.hesh maps\_utility::disable_exits();
	level.hesh maps\_utility::func_252F(4,::maps\_utility::func_7628,"youngblood_hsh_lookout");
	param_00 maps\_anim::anim_single_solo(level.hesh,"youngblood_tanker_hesh");
	level.hesh maps\_utility::disable_exits();
}

//Function Number: 58
chaos_b_hide_debris()
{
	level.var_7A0 = getentarray("truck_debris_array","script_noteworthy");
	level.var_7A0 = common_scripts\utility::array_combine(level.var_7A0,getentarray("tanker_debris","targetname"));
	foreach(var_01 in level.var_7A0)
	{
		var_01 hide();
	}
}

//Function Number: 59
chaos_b_slow_zone()
{
	maps\_utility::func_83B0("chaos_b_slow_zone");
	level.player maps/youngblood_util::func_8E8D(20,2);
	level.player allowsprint(0);
}

//Function Number: 60
func_5DA0()
{
	level endon("stop_player_chaos_audio");
	level endon("death");
	for(;;)
	{
		wait(randomfloatrange(1,2));
		level.player thread maps\_utility::func_5D23("plr_heartbeat");
	}
}

//Function Number: 61
func_5CC7()
{
	self endon("player_near_mansion_exit");
	var_00 = (-2965,-102971,-113841);
	var_01 = (-1179,-100516,-113306);
	var_02 = (706,-100274,-113447);
	var_03 = [var_00,var_01,var_02];
	level.cloud_sfx_base_wait_min = 0.2;
	level.cloud_sfx_base_wait_max = 0.6;
	level.cloud_sfx_design_wait_min = 2;
	level.cloud_sfx_design_wait_max = 4.3;
	thread func_5CC5(var_03);
	thread play_distant_cloud_design(var_03);
}

//Function Number: 62
func_5CC5(param_00)
{
	self endon("player_near_mansion_exit");
	for(;;)
	{
		var_01 = common_scripts\utility::func_6306(param_00);
		thread common_scripts\utility::func_5D1F("yb_rog_distant",var_01);
		var_02 = randomfloatrange(level.cloud_sfx_base_wait_min,level.cloud_sfx_base_wait_max);
		wait(var_02);
	}
}

//Function Number: 63
play_distant_cloud_design(param_00)
{
	self endon("player_near_mansion_exit");
	wait(2);
	var_01 = common_scripts\utility::func_6306(param_00);
	thread common_scripts\utility::func_5D1F("yb_rog_distant_design_first",var_01);
	var_02 = randomfloatrange(0.8,0.85);
	wait(var_02);
	var_01 = common_scripts\utility::func_6306(param_00);
	thread common_scripts\utility::func_5D1F("yb_rog_distant_design_second",var_01);
	var_02 = randomfloatrange(level.cloud_sfx_design_wait_min,level.cloud_sfx_design_wait_max);
	wait(var_02);
	for(;;)
	{
		var_01 = common_scripts\utility::func_6306(param_00);
		thread common_scripts\utility::func_5D1F("yb_rog_distant_design",var_01);
		var_02 = randomfloatrange(0.5,0.8);
		wait(var_02);
		var_01 = common_scripts\utility::func_6306(param_00);
		thread common_scripts\utility::func_5D1F("yb_rog_distant_design",var_01);
		var_02 = randomfloatrange(level.cloud_sfx_design_wait_min,level.cloud_sfx_design_wait_max);
		wait(var_02);
	}
}

//Function Number: 64
func_5D9F()
{
	level endon("stop_player_chaos_audio");
	level endon("death");
	level.player maps\_utility::func_5D23("breathing_hurt_start");
	var_00 = 1;
	for(;;)
	{
		wait(var_00);
		if(!isdefined(level.player.better))
		{
			level.player maps\_utility::func_5D23("breathing_hurt");
		}
		else
		{
			level.player maps\_utility::func_5D23("breathing_better");
		}

		var_00 = var_00 + 0.15;
	}
}

//Function Number: 65
pickup()
{
	common_scripts\utility::flag_wait("start_pickup");
	thread maps/youngblood_exit_ride::func_3091();
}

//Function Number: 66
func_5DF4()
{
	self waittill("trigger");
	maps/youngblood_util::func_89B9();
	var_00 = maps\_utility::func_777F("player_rig",level.player.origin);
	var_01 = 0;
	level.player playerlinktodelta(var_00,"tag_player",1,var_01,var_01,var_01,var_01,1);
	level.player maps\_anim::anim_single_solo(var_00,"youngblood_player_fall_down");
	maps/youngblood_util::func_89B8();
	var_00 delete();
	level.player setorigin(level.player.origin + (0,0,24));
}

//Function Number: 67
n_door_knock()
{
	var_00 = getent("n_knock_m","script_noteworthy");
	var_01 = var_00 maps\_utility::func_7766();
	var_01 thread maps/youngblood_util::func_455F();
	var_01 thread maps\_anim::anim_generic_loop(var_01,"london_civ_idle_wave");
	common_scripts\utility::flag_wait("player_past_fence");
	var_01 method_8252();
	var_02 = getnode("house_across_street","targetname");
	var_01 thread delete_on_path_end(var_02);
}

//Function Number: 68
func_555B()
{
	common_scripts\utility::flag_wait("player_area_3");
	var_00 = maps\_utility::array_spawn_targetname("n_watchers");
	thread civ_walla(var_00);
}

//Function Number: 69
civ_walla(param_00)
{
	var_01 = ["youngblood_dad2_dannygetyourass","youngblood_mom1_butthedog","youngblood_dad1_wecantcarryanymore","youngblood_kid2_idontwantto"];
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		param_00 = common_scripts\utility::array_removeundefined(param_00);
		if(param_00.size == 0)
		{
		}

		var_03 = var_02 % param_00.size;
		param_00[var_03] maps\_utility::func_5D23(var_01[var_02]);
		wait(randomfloatrange(0.5,1));
	}
}

//Function Number: 70
func_555C()
{
	var_00 = common_scripts\utility::func_39BD();
	maps\_utility::func_6EF0("unarmed_panickedrun_loop_V2");
	maps\_utility::func_6EED("youngblood_hesh_calm_idle");
	self.moveplaybackrate = self.var_6C37;
	self.goalradius = 128;
	maps\_utility::func_8BDC();
	maps\_utility::disable_exits();
	maps\_utility::disable_arrivals();
	self method_8222(1);
	if(isdefined(self.script_soundalias))
	{
		self.animname = "generic";
		maps\_utility::func_252F(randomfloatrange(0.5,1),::maps\_utility::func_5D23,self.script_soundalias);
	}

	maps\_utility::func_3490(var_00,0);
	wait(1);
	while(maps\_utility::func_5E89(self geteye(),0.6,1))
	{
		wait(0.1);
	}

	self delete();
}

//Function Number: 71
delete_on_path_end(param_00)
{
	maps\_utility::func_6EFD(16);
	self method_8224(param_00);
	maps\_utility::enable_sprint();
	self waittill("goal");
	self delete();
}

//Function Number: 72
n_vehicle_1()
{
}

//Function Number: 73
func_5557()
{
	level.car_1 = maps\_vehicle::func_784E("n_car_2");
	level.car_1.animname = "coupe";
	level.car_1 method_826D(level.var_6AED["coupe"]);
	common_scripts\utility::flag_wait("load_car_1");
	var_00 = getent("car_2_m","script_noteworthy");
	var_01 = var_00 maps\_utility::func_7766();
	thread func_5558(var_01);
	common_scripts\utility::flag_wait("passenger_1_in");
	level.car_1 func_5559();
	level.car_1.veh_transmission = "forward";
	level.car_1 maps\_vehicle::func_894A();
	var_02 = getnode("n_car_2_exit","targetname");
	level.car_1 attachpath(var_02);
	level.car_1 thread maps\_vehicle::func_8902(var_02);
	level.car_1 startpath(var_02);
	level.car_1 maps\_utility::func_5D23("scn_yb_second_car_peel_out");
	level.car_1 thread func_559D(level.car_1);
	level.car_1 thread func_559E();
}

//Function Number: 74
n_vehicle_3()
{
}

//Function Number: 75
func_5559()
{
	self.veh_transmission = "reverse";
	maps\_vehicle::func_8949();
	var_00 = getnode("n_car_2_reverse_out","targetname");
	level.car_1 attachpath(var_00);
	level.car_1 thread maps\_vehicle::func_8902(var_00);
	level.car_1 startpath(var_00);
	level.car_1 waittill("reached_end_node");
}

//Function Number: 76
func_5558(param_00)
{
	level.car_1 maps\_anim::anim_generic_reach(param_00,"YB_car_entrance_driver_B","tag_driver");
	level.car_1 thread maps\_anim::anim_single_solo(level.car_1,"YB_car_entrance_driver_B_car");
	level.car_1 maps\_anim::func_D64(param_00,"YB_car_entrance_driver_B","tag_driver");
	level.car_1 thread maps\_anim::anim_generic_loop(param_00,"car_sitting_idle_driver","stop_loop","tag_driver");
	param_00 linkto(level.car_1);
	common_scripts\utility::flag_set("passenger_1_in");
}

//Function Number: 77
func_22DC()
{
	level endon("player_on_truck");
	for(;;)
	{
		wait(0.2);
		if(level.player.health == level.player.maxhealth)
		{
			level.player dodamage(100,(0,0,0));
		}
	}
}

//Function Number: 78
func_5DF8()
{
	level.player thread maps\_utility::func_5D23("scn_yb_house_collapse");
	level.player maps/youngblood_util::func_8E8D(25);
	maps/youngblood_util::func_89B9();
	earthquake(0.4,3.3,level.player.origin,64);
	level.player playrumbleonentity("heavy_3s");
	common_scripts\utility::exploder("mansion_door_crash");
	thread common_scripts\utility::exploder("exp15");
	maps\_utility::func_252F(1.3,::func_507A);
	thread common_scripts\utility::func_5D1F("scn_quake_13_plr_stumble",level.player.origin);
	var_00 = common_scripts\utility::func_7836();
	var_00.origin = level.player.origin;
	var_00.angles = level.player.angles;
	common_scripts\utility::func_8AFE();
	var_01 = maps\_utility::func_777F("player_rig",level.player.origin,level.player.angles);
	var_01 show();
	level.player playerlinktoblend(var_01,"tag_player",0.1);
	var_01 thread maps\_anim::anim_single_solo(var_01,"youngblood_player_fall_down");
	level.player shellshock("ygb_crash",4.5);
	wait(1.5);
	var_01 common_scripts\utility::delaycall(0.5,::hide);
	level.player playerlinktoblend(var_01,"tag_origin",1.5,0,0.5);
	wait(1);
	level.player method_8273(1);
	level.player method_8272(0);
	wait(0.55);
	level.player unlink();
	var_01 delete();
	maps/youngblood_util::func_89B8();
	level.player maps/youngblood_util::func_8E8D(50,2);
}

//Function Number: 79
func_507A()
{
	var_00 = common_scripts\utility::func_3C18("mansion_destruction_ref","targetname");
	var_01 = common_scripts\utility::func_39BD("mansion_destruction_piece");
	var_01.origin = var_00.origin;
	var_01.angles = var_00.angles;
}

//Function Number: 80
func_5F90()
{
	level.player maps/youngblood_util::func_8E8D(25);
	maps/youngblood_util::func_89B9();
	thread maps/youngblood_util::heavy_quake(50);
	thread common_scripts\utility::exploder("exp14");
	thread exp14_sounds();
	thread common_scripts\utility::func_5D1F("scn_quake_11",level.player.origin);
	thread common_scripts\utility::func_5D1F("scn_yb_house_rattle_lr",level.player.origin);
	var_00 = maps\_utility::func_777F("player_rig",level.player.origin,level.player.angles);
	var_00 method_8021(level.player,"tag_player",(0,0,0),(0,0,0),1);
	var_00 method_825C(var_00 maps\_utility::func_3A1F("youngblood_player_wobble_1"),1,0,1);
	wait(2.5);
	var_00 unlink();
	var_00 delete();
	maps/youngblood_util::func_89B8();
	level.player maps/youngblood_util::func_8E8D(80,2);
}

//Function Number: 81
func_83A3()
{
	if(!maps\_utility::game_is_current_gen())
	{
		common_scripts\utility::func_F1B(getentarray("house_falls_apart","targetname"),::func_5CE5);
	}

	var_00 = getentarray("church_pieces","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	var_04 = common_scripts\utility::func_39BD("animate_cab");
	var_04 hide();
	var_05 = common_scripts\utility::func_3C18("church_first_frame","targetname");
	level.var_316A = spawn("script_model",var_05.origin);
	level.var_316A.angles = var_05.angles;
	level.var_316A setmodel("vfx_ygb_churchcollapse_first_frame");
}

//Function Number: 82
func_835E()
{
	level endon("stop_chaos_a");
	var_00 = common_scripts\utility::func_39BD("chaos_interior_volume");
	var_01 = common_scripts\utility::func_39BD("chaos_interior_volume1");
	for(;;)
	{
		wait(0.1);
		if(level.player istouching(var_00) || level.player istouching(var_01))
		{
			level.var_5EB5 = 0;
			continue;
		}

		level.var_5EB5 = 1;
	}
}

//Function Number: 83
func_898F()
{
	level endon("stop_vfx_on_player");
	for(;;)
	{
		wait(0.6);
		var_00 = anglestoforward(level.player.angles) * 96;
		playfx(common_scripts\utility::func_3AB9(level.var_5E87),level.player.origin + var_00);
	}
}

//Function Number: 84
deer_stampede_logic()
{
	common_scripts\utility::flag_wait("deer_stampede");
	level.plume_sound = common_scripts\utility::func_7836();
	level.plume_sound.origin = (-2055,-101789,-111164);
	level.plume_sound playsound("yb_rog_distant_orange_plume");
	thread common_scripts\utility::exploder("exp05");
	wait(1);
	thread func_559B();
}

//Function Number: 85
func_1AF6()
{
	level.player endon("death");
	level endon("stop_chaos_faster_hesh");
	while(level.var_5D6F)
	{
		wait(0.1);
		var_00 = vectornormalize(level.player.origin - level.hesh.origin);
		var_01 = anglestoforward(level.hesh.angles);
		var_02 = vectordot(var_01,var_00);
		var_03 = distance(level.player.origin,level.hesh.origin);
		if(var_03 < 20 && var_02 < 0)
		{
			level.hesh maps\_utility::disable_sprint();
			maps\_utility::disable_exits();
			level.hesh maps/youngblood_util::func_6F2D(1.05);
			continue;
		}

		var_00 = vectornormalize(level.player.origin - level.hesh.origin);
		var_01 = anglestoforward(level.hesh.angles);
		var_02 = vectordot(var_01,var_00);
		if(var_02 > 0)
		{
			level.hesh maps\_utility::enable_sprint();
			maps\_utility::disable_exits();
			continue;
		}

		level.hesh maps\_utility::disable_sprint();
		maps\_utility::disable_exits();
		level.hesh maps/youngblood_util::func_6F2D(1.05);
	}
}

//Function Number: 86
chaos_quake_trigger_think()
{
	self waittill("trigger");
	thread maps/youngblood_util::heavy_quake(100,50);
}

//Function Number: 87
func_8E8F()
{
	self waittill("trigger");
	thread maps\_utility::func_11BF();
}

//Function Number: 88
func_71A3()
{
	var_00 = common_scripts\utility::func_39BD("chaos_street_pos");
	var_01 = getent("chunk_main_f","targetname");
	var_02 = common_scripts\utility::func_3C18("chunk_main_f_pos","targetname");
	var_03 = common_scripts\utility::func_7836();
	var_03.origin = var_01.origin;
	var_03.angles = var_01.angles;
	var_03.animname = "moving_pieces";
	var_03 maps\_anim::func_6FE5();
	var_01 linkto(var_03);
	var_00 maps\_anim::anim_first_frame_solo(var_03,"youngblood_chaos_chunk_f");
	var_04 = getent("chunk_main_g","targetname");
	var_05 = common_scripts\utility::func_3C18("chunk_main_g_pos","targetname");
	var_06 = common_scripts\utility::func_7836();
	var_06.origin = var_04.origin;
	var_06.angles = var_04.angles;
	var_06.animname = "moving_pieces";
	var_06 maps\_anim::func_6FE5();
	var_04 linkto(var_06);
	var_00 maps\_anim::anim_first_frame_solo(var_06,"youngblood_chaos_chunk_g");
	var_07 = getent("chunk_main_n","targetname");
	var_08 = common_scripts\utility::func_3C18("chunk_main_n_pos","targetname");
	var_09 = common_scripts\utility::func_7836();
	var_09.origin = var_07.origin;
	var_09.angles = var_07.angles;
	var_09.animname = "moving_pieces";
	var_09 maps\_anim::func_6FE5();
	var_07 linkto(var_09);
	var_00 maps\_anim::anim_first_frame_solo(var_09,"youngblood_chaos_chunk_n");
	var_0A = getent("chunk_main_h","targetname");
	var_0B = common_scripts\utility::func_3C18("chunk_main_h_pos","targetname");
	var_0C = common_scripts\utility::func_7836();
	var_0C.origin = var_0A.origin;
	var_0C.angles = var_0A.angles;
	var_0C.animname = "moving_pieces";
	var_0C maps\_anim::func_6FE5();
	var_0A linkto(var_0C);
	var_00 maps\_anim::anim_first_frame_solo(var_0C,"youngblood_chaos_chunk_h");
	var_0D = getent("chunk_main_j","targetname");
	var_0E = common_scripts\utility::func_3C18("chunk_main_j_pos","targetname");
	var_0F = common_scripts\utility::func_7836();
	var_0F.origin = var_0D.origin;
	var_0F.angles = var_0D.angles;
	var_0F.animname = "moving_pieces";
	var_0F maps\_anim::func_6FE5();
	var_0D linkto(var_0F);
	var_00 maps\_anim::anim_first_frame_solo(var_0F,"youngblood_chaos_chunk_j");
	var_10 = getent("chunk_main_j1","targetname");
	var_11 = common_scripts\utility::func_3C18("chunk_main_j1_pos","targetname");
	var_12 = common_scripts\utility::func_7836();
	var_12.origin = var_10.origin;
	var_12.angles = var_10.angles;
	var_12.animname = "moving_pieces";
	var_12 maps\_anim::func_6FE5();
	var_10 linkto(var_12);
	var_00 maps\_anim::anim_first_frame_solo(var_12,"youngblood_chaos_chunk_j1");
	var_13 = getent("chunk_main_k","targetname");
	var_14 = common_scripts\utility::func_3C18("vfx_yb_house_h_furniture_a","targetname");
	var_15 = common_scripts\utility::func_3C18("vfx_yb_house_h_dustfall_a","targetname");
	var_16 = common_scripts\utility::func_3C18("vfx_yb_house_h_dustfall_b","targetname");
	var_17 = common_scripts\utility::func_7836();
	var_17.origin = var_14.origin;
	var_17.angles = var_14.angles;
	var_18 = common_scripts\utility::func_7836();
	var_18.origin = var_15.origin;
	var_18.angles = var_15.angles;
	var_19 = common_scripts\utility::func_7836();
	var_19.origin = var_16.origin;
	var_19.angles = var_16.angles;
	var_1A = common_scripts\utility::func_3C18("chunk_main_k_pos","targetname");
	var_1B = common_scripts\utility::func_7836();
	var_1B.origin = var_13.origin;
	var_1B.angles = var_13.angles;
	var_1B.animname = "moving_pieces";
	var_1B maps\_anim::func_6FE5();
	var_17 linkto(var_1B);
	var_18 linkto(var_1B);
	var_19 linkto(var_1B);
	var_13 linkto(var_1B);
	var_00 maps\_anim::anim_first_frame_solo(var_1B,"youngblood_chaos_chunk_k_1");
	var_1C = getent("chunk_main_l","targetname");
	var_1D = common_scripts\utility::func_3C18("chunk_main_l_pos","targetname");
	var_1E = common_scripts\utility::func_7836();
	var_1E.origin = var_1C.origin;
	var_1E.angles = var_1C.angles;
	var_1E.animname = "moving_pieces";
	var_1E maps\_anim::func_6FE5();
	var_1C linkto(var_1E);
	var_00 maps\_anim::anim_first_frame_solo(var_1E,"youngblood_chaos_chunk_l");
	var_1F = getent("chunk_main_m","targetname");
	var_20 = common_scripts\utility::func_3C18("chunk_main_m_pos","targetname");
	var_21 = common_scripts\utility::func_7836();
	var_21.origin = var_1F.origin;
	var_21.angles = var_1F.angles;
	var_21.animname = "moving_pieces";
	var_21 maps\_anim::func_6FE5();
	var_1F linkto(var_21);
	var_00 maps\_anim::anim_first_frame_solo(var_21,"youngblood_chaos_chunk_m");
	self waittill("trigger");
	thread func_72AB(var_03.origin);
	thread func_7312(var_01,"scn_yb_destruct_loop_sub1");
	thread func_7312(var_04,"scn_yb_destruct_loop_rocks1");
	thread func_7312(var_0D,"scn_yb_destruct_loop_rocks2");
	thread func_7312(var_07,"scn_yb_destruct_loop_rocks3");
	thread func_7312(var_1C,"scn_yb_destruct_loop_rocks2");
	thread func_7312(var_1F,"scn_yb_destruct_loop_rocks1");
	var_00 thread maps\_anim::anim_single_solo(var_03,"youngblood_chaos_chunk_f");
	var_00 thread maps\_anim::anim_single_solo(var_06,"youngblood_chaos_chunk_g");
	var_00 thread maps\_anim::anim_single_solo(var_09,"youngblood_chaos_chunk_n");
	var_00 thread maps\_anim::anim_single_solo(var_0C,"youngblood_chaos_chunk_h");
	var_00 thread maps\_anim::anim_single_solo(var_0F,"youngblood_chaos_chunk_j");
	var_00 thread maps\_anim::anim_single_solo(var_12,"youngblood_chaos_chunk_j1");
	var_00 thread maps\_anim::anim_single_solo(var_1E,"youngblood_chaos_chunk_l");
	var_00 thread maps\_anim::anim_single_solo(var_21,"youngblood_chaos_chunk_m");
	thread func_5D2D(var_00,var_1B,var_17,var_18,var_19,var_13);
}

//Function Number: 89
sfx_for_p_r_s_t_pieces()
{
	self waittill("trigger");
	var_00 = getent("chunk_main_p","targetname");
	var_01 = getent("street_jump_house","targetname");
	var_02 = getent("chunk_main_s","targetname");
	var_03 = getent("chunk_main_t","targetname");
	var_00 thread sfx_loop_for_mover_piece(11.5,1,4,"scn_yb_destruct_loop_rocks2");
	var_01 thread sfx_loop_for_mover_piece(8,1,4.5,"scn_yb_destruct_loop_rocks3");
	var_02 thread sfx_loop_for_mover_piece(13.5,1,5.5,"scn_yb_destruct_loop_rocks1");
	var_03 thread sfx_loop_for_mover_piece(15,1,6,"scn_yb_destruct_loop_rocks2");
}

//Function Number: 90
sfx_loop_for_mover_piece(param_00,param_01,param_02,param_03)
{
	self playloopsound(param_03);
	self method_82DA(0,0);
	waittillframeend;
	self method_82DA(1,param_01);
	var_04 = param_00 - param_02;
	wait(var_04);
	self method_82DA(0,param_02);
	wait(param_02);
	self stoploopsound();
}

//Function Number: 91
func_72AC(param_00,param_01,param_02)
{
	wait(0.4);
	thread common_scripts\utility::func_5D1F("scn_yb_street1_collapse_left",param_00);
	thread common_scripts\utility::func_5D1F("scn_yb_street1_collapse_center",param_01);
	thread common_scripts\utility::func_5D1F("scn_yb_street1_collapse_center_lfe",param_01);
	thread common_scripts\utility::func_5D1F("scn_yb_street1_collapse_right",param_02);
	wait(4);
	maps\_utility::func_252F(0.8,::common_scripts\utility::func_5D1F,"mtl_water_pipe_burst",(-418,-102797,-114713));
	wait(2);
	maps\_utility::func_252F(1.9,::common_scripts\utility::func_5D1F,"mtl_water_pipe_burst",(-243,-101768,-114738));
	maps\_utility::func_252F(2.7,::common_scripts\utility::func_5D1F,"mtl_water_pipe_burst",(-346,-101833,-114811));
}

//Function Number: 92
func_72AB(param_00)
{
	thread common_scripts\utility::func_5D1F("scn_yb_street2_collapse_center",param_00);
	wait(7);
	maps\_utility::func_252F(1.9,::common_scripts\utility::func_5D1F,"mtl_water_pipe_burst",(-292,-100801,-114839));
	maps\_utility::func_252F(3,::common_scripts\utility::func_5D1F,"mtl_water_pipe_burst",(-412,-100459,-115061));
}

//Function Number: 93
func_7312(param_00,param_01)
{
	param_00 playloopsound(param_01);
	param_00 method_82DA(0,0);
	wait(0.1);
	param_00 method_82DA(1,2);
	wait(7);
	param_00 method_82DA(0,3);
	wait(3);
	param_00 stoploopsound();
}

//Function Number: 94
func_5D2D(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread func_7312(param_05,"scn_yb_destruct_loop_wood1");
	param_00 maps\_anim::anim_single_solo(param_01,"youngblood_chaos_chunk_k_1");
	wait(1);
	param_05 thread play_2_k_sfx("scn_yb_house_move_ext_right","scn_yb_house_move_ext_left");
	param_00 maps\_anim::anim_single_solo(param_01,"youngblood_chaos_chunk_k_2");
	playfxontag(common_scripts\utility::func_3AB9("vfx_yb_house_h_dustfall_a"),param_03,"tag_origin");
	playfxontag(common_scripts\utility::func_3AB9("vfx_yb_house_h_dustfall_a"),param_04,"tag_origin");
	common_scripts\utility::flag_wait("house_k2_k3_anim");
	thread func_7312(param_05,"scn_yb_destruct_loop_wood1");
	param_05 maps\_utility::func_252F(1,::play_2_k_sfx,"scn_yb_house_move_int_right","scn_yb_house_move_int_left");
	param_00 thread maps\_anim::anim_single_solo(param_01,"youngblood_chaos_chunk_k_3");
	playfxontag(common_scripts\utility::func_3AB9("vfx_yb_house_h_furniture_a"),param_02,"tag_origin");
}

//Function Number: 95
play_2_k_sfx(param_00,param_01)
{
	var_02 = spawn("script_origin",self.origin + (450,0,200));
	var_03 = spawn("script_origin",self.origin + (-150,0,200));
	var_02 linkto(self);
	var_03 linkto(self);
	var_02 playsound(param_00,"soundrightdone");
	var_03 playsound(param_01,"soundleftdone");
	var_02 thread waittill_delete("soundrightdone");
	var_03 thread waittill_delete("soundleftdone");
}

//Function Number: 96
waittill_delete(param_00)
{
	self waittill(param_00);
	self delete();
}

//Function Number: 97
func_71A2()
{
	var_00 = common_scripts\utility::func_39BD("mansion_anim_ref");
	var_01 = getent("chunk_main_a","targetname");
	var_02 = common_scripts\utility::func_3C18("chunk_main_a_pos","targetname");
	var_03 = maps\_utility::func_777F("tag_origin",var_02.origin);
	var_03.angles = var_02.angles;
	var_00 maps\_anim::anim_first_frame_solo(var_03,"youngblood_chaos_chunk_a");
	var_01.origin = var_03.origin;
	var_01.angles = var_03.angles;
	var_01 linkto(var_03,"tag_origin");
	var_04 = getent("chunk_main_b","targetname");
	var_05 = common_scripts\utility::func_3C18("chunk_main_b_pos","targetname");
	var_06 = maps\_utility::func_777F("tag_origin",var_05.origin);
	var_06.angles = var_05.angles;
	var_00 maps\_anim::anim_first_frame_solo(var_06,"youngblood_chaos_chunk_b");
	var_04.origin = var_06.origin;
	var_04.angles = var_06.angles;
	var_04 linkto(var_06,"tag_origin");
	var_07 = getent("chunk_main_c","targetname");
	var_08 = common_scripts\utility::func_3C18("chunk_main_c_pos","targetname");
	var_09 = maps\_utility::func_777F("tag_origin",var_08.origin);
	var_09.angles = var_08.angles;
	var_00 maps\_anim::anim_first_frame_solo(var_09,"youngblood_chaos_chunk_c");
	var_07.origin = var_09.origin;
	var_07.angles = var_09.angles;
	var_07 linkto(var_09,"tag_origin");
	var_0A = getent("chunk_main_d","targetname");
	var_0B = common_scripts\utility::func_3C18("chunk_main_d_pos","targetname");
	var_0C = maps\_utility::func_777F("tag_origin",var_0B.origin);
	var_0C.angles = var_0B.angles;
	var_00 maps\_anim::anim_first_frame_solo(var_0C,"youngblood_chaos_chunk_d");
	var_0A.origin = var_0C.origin;
	var_0A.angles = var_0C.angles;
	var_0A linkto(var_0C,"tag_origin");
	var_0D = getent("chunk_main_e","targetname");
	var_0E = common_scripts\utility::func_3C18("chunk_main_e_pos","targetname");
	var_0F = maps\_utility::func_777F("tag_origin",var_0E.origin);
	var_0F.angles = var_0E.angles;
	var_00 maps\_anim::anim_first_frame_solo(var_0F,"youngblood_chaos_chunk_e");
	var_0D.origin = var_0F.origin;
	var_0D.angles = var_0F.angles;
	var_0D linkto(var_0F,"tag_origin");
	waittillframeend;
	common_scripts\utility::flag_set("load_1");
	common_scripts\utility::flag_wait("play_street_cracking");
	thread func_8979(var_00);
	thread func_72AC(var_03.origin,var_09.origin,var_0C.origin);
	thread func_7312(var_04,"scn_yb_destruct_loop_sub1");
	var_00 thread maps\_anim::anim_single_solo(var_03,"youngblood_chaos_chunk_a");
	var_00 thread maps\_anim::anim_single_solo(var_06,"youngblood_chaos_chunk_b");
	var_00 thread maps\_anim::anim_single_solo(var_09,"youngblood_chaos_chunk_c");
	var_00 thread maps\_anim::anim_single_solo(var_0C,"youngblood_chaos_chunk_d");
	var_00 thread maps\_anim::anim_single_solo(var_0F,"youngblood_chaos_chunk_e");
	common_scripts\utility::flag_set("chaos_hesh_go");
}

//Function Number: 98
func_8979(param_00)
{
	maps\_utility::func_252F(0,::common_scripts\utility::exploder,"c");
	maps\_utility::func_252F(0.05,::common_scripts\utility::exploder,"a");
	maps\_utility::func_252F(0.1,::common_scripts\utility::exploder,"e");
}

//Function Number: 99
func_5D2E()
{
	var_00 = common_scripts\utility::func_3C18("ref_street_crack_piece","targetname");
	var_00.no_delete = 1;
	var_00.origin = var_00.origin + (0,0,0);
	var_01 = getentarray("ygb_roadcrack_street_1","script_noteworthy");
	var_02 = 0;
	foreach(var_04 in var_01)
	{
		var_04.animname = var_04.targetname;
		var_04 method_826D(level.var_6AED["street_crack_1"]);
		var_04.origin = var_00.origin;
		var_04.angles = var_00.angles;
		var_05 = getanimlength(var_04 maps\_utility::func_3A1F("crack"));
		if(var_02 < var_05)
		{
			var_02 = var_05;
		}

		var_04 hide();
	}

	var_07 = getent("roadcrack_0","targetname");
	var_08 = addstruct();
	var_08.origin = var_07.origin;
	var_08.angles = var_07.angles;
	waittillframeend;
	common_scripts\utility::flag_set("load_2");
	common_scripts\utility::flag_wait("play_street_cracking");
	var_09 = anglestoforward(var_08.angles);
	var_0A = anglestoup(var_08.angles);
	playfx(common_scripts\utility::func_3AB9("vfx_ygb_roadcrack_set01_debris"),var_08.origin,var_09,var_0A);
	foreach(var_04 in var_01)
	{
		var_04 common_scripts\utility::delaycall(0,::show);
		var_04 common_scripts\utility::delaycall(0.5,::movez,4.5,0.5);
		var_04 method_8269("crack",var_04 maps\_utility::func_3A1F("crack"),1,0.1);
		var_04 thread delete_on_crack1_done();
	}

	wait(var_02 - 1.125);
	var_0D = spawn("script_model",var_00.origin + (0,0,4.5));
	var_0D.angles = var_00.angles;
	var_0D setmodel("vfx_ygb_roadcrack_a_to_e_last_frame");
}

//Function Number: 100
delete_on_crack1_done()
{
	if(isdefined(self.no_delete))
	{
	}

	wait(8);
	self delete();
}

//Function Number: 101
func_7834()
{
	var_00 = common_scripts\utility::func_3C18("ref_fake_street_crack","targetname");
	var_01 = spawn("script_model",var_00.origin + (0,0,-0.5));
	var_01.angles = var_00.angles;
	var_01 setmodel("vfx_ygb_roadcrack_a_to_e_first_frame");
	common_scripts\utility::flag_wait("play_street_cracking");
	wait(0.5);
	var_01 delete();
}

//Function Number: 102
func_5CE5()
{
	var_00 = getent("house_cliff_0","targetname");
	var_01 = addstruct();
	var_01.origin = var_00.origin;
	var_01.angles = var_00.angles;
	var_02 = [];
	var_02 = common_scripts\utility::array_combine(var_02,getentarray("house_pieces","script_noteworthy"));
	var_02 = common_scripts\utility::array_combine(var_02,getentarray("house_cliff_pieces","script_noteworthy"));
	var_02 = common_scripts\utility::array_combine(var_02,getentarray("house_roof_pieces","script_noteworthy"));
	var_03 = 0;
	foreach(var_05 in var_02)
	{
		var_05.animname = var_05.targetname;
		var_05 method_826D(level.var_6AED["falling_house"]);
		var_06 = getanimlength(var_05 maps\_utility::func_3A1F("fall"));
		if(var_03 < var_06)
		{
			var_03 = var_06;
		}

		var_05 hide();
	}

	self waittill("trigger");
	common_scripts\utility::exploder("house_collapse_smoke");
	var_08 = anglestoforward(var_01.angles);
	var_09 = anglestoup(var_01.angles);
	playfx(common_scripts\utility::func_3AB9("vfx_ygb_housecollapse_debris"),var_01.origin,var_08,var_09);
	foreach(var_05 in var_02)
	{
		var_05 show();
		var_05 method_8269("fall",var_05 maps\_utility::func_3A1F("fall"),1,0.1);
		var_05 thread delete_on_house_done();
	}

	wait(var_03);
}

//Function Number: 103
delete_on_house_done()
{
	if(isdefined(self.no_delete))
	{
	}

	self waittillmatch("end","fall");
	self delete();
}

//Function Number: 104
func_5CB5()
{
	var_00 = getent("church_piece_0","targetname");
	var_01 = addstruct();
	var_01.origin = var_00.origin;
	var_01.angles = var_00.angles;
	var_02 = getentarray("church_pieces","script_noteworthy");
	var_03 = 0;
	foreach(var_05 in var_02)
	{
		var_05.animname = var_05.targetname;
		var_05 method_826D(level.var_6AED["church_tanker"]);
		var_06 = getanimlength(var_05 maps\_utility::func_3A1F("collapse"));
		if(var_03 < var_06)
		{
			var_03 = var_06;
		}
	}

	common_scripts\utility::flag_wait("church_fall_go");
	var_08 = anglestoforward(var_01.angles);
	var_09 = anglestoup(var_01.angles);
	playfx(common_scripts\utility::func_3AB9("vfx_ygb_church_collapse_debris"),var_01.origin,var_08,var_09);
	if(isdefined(level.var_316A))
	{
		level.var_316A common_scripts\utility::delaycall(2.5,::hide);
	}

	foreach(var_05 in var_02)
	{
		var_05 common_scripts\utility::delaycall(2.45,::show);
		var_05 method_8269("collapse",var_05 maps\_utility::func_3A1F("collapse"),1,0.1);
		var_05 thread func_2561();
	}

	wait(var_03);
}

//Function Number: 105
func_2561()
{
	if(isdefined(self.no_delete))
	{
	}

	wait(5);
	self delete();
}

//Function Number: 106
func_5D2F()
{
	var_00 = common_scripts\utility::func_3C18("street_crack_2_ref_struct","targetname");
	var_00.no_delete = 1;
	var_01 = addstruct();
	var_01.origin = var_00.origin;
	var_01.angles = var_00.angles;
	var_02 = getentarray("street_crack_2_pieces","script_noteworthy");
	var_03 = 0;
	foreach(var_05 in var_02)
	{
		var_05.animname = var_05.targetname;
		var_05 method_826D(level.var_6AED["street_crack_2"]);
		var_06 = getanimlength(var_05 maps\_utility::func_3A1F("crack"));
		if(var_03 < var_06)
		{
			var_03 = var_06;
		}

		var_05 hide();
	}

	common_scripts\utility::flag_set("load_3");
	self waittill("trigger");
	var_08 = anglestoforward(var_01.angles);
	var_09 = anglestoup(var_01.angles);
	playfx(common_scripts\utility::func_3AB9("vfx_ygb_roadcrack_set02_debris"),var_01.origin,var_08,var_09);
	foreach(var_05 in var_02)
	{
		var_05 show();
		var_05 method_8269("crack",var_05 maps\_utility::func_3A1F("crack"),1,0.1);
		var_05 thread delete_on_crack2_done();
	}

	common_scripts\utility::exploder("crack2");
	wait(var_03);
}

//Function Number: 107
delete_on_crack2_done()
{
	if(isdefined(self.no_delete))
	{
	}

	wait(10);
	self delete();
}

//Function Number: 108
chaos_hide_on_start()
{
	var_00 = getentarray("ygb_roadcrack_street_1","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	var_00 = [];
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("house_pieces","script_noteworthy"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("house_cliff_pieces","script_noteworthy"));
	var_00 = common_scripts\utility::array_combine(var_00,getentarray("house_roof_pieces","script_noteworthy"));
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	var_00 = getentarray("street_crack_2_pieces","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	var_00 = getentarray("church_pieces","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	var_0A = common_scripts\utility::func_39BD("animate_cab");
	var_0A hide();
}

//Function Number: 109
_playsound(param_00,param_01,param_02)
{
	self method_82D5(param_00);
}