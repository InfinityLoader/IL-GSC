/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: crash_skyjack.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 491 ms
 * Timestamp: 4/22/2024 2:27:19 AM
*******************************************************************/

//Function Number: 1
precache_skyjack()
{
	common_scripts\utility::flag_init("display_chyron");
	common_scripts\utility::flag_init("crash_lighting_screen_dof");
	common_scripts\utility::flag_init("start_fade_in");
	common_scripts\utility::flag_init("start_action");
	common_scripts\utility::flag_init("player_fly");
	common_scripts\utility::flag_init("stop_player_fly");
	common_scripts\utility::flag_init("start_skyjack_temperature");
	common_scripts\utility::flag_init("skyjack_explosion");
	common_scripts\utility::flag_init("skyjack_explosion_lighting");
	common_scripts\utility::flag_init("actual_explosion");
	common_scripts\utility::flag_init("white_fade_done");
	common_scripts\utility::flag_init("white_fade_start");
	common_scripts\utility::flag_init("skyjack_done");
	common_scripts\utility::flag_init("player_landed_on_plane");
	common_scripts\utility::flag_init("start_clouds_again");
	common_scripts\utility::flag_init("skyjack_white_fade_done");
	common_scripts\utility::flag_init("skyjack_end_heavy_clouds");
	common_scripts\utility::flag_init("start_hud");
	precachemodel("viewbody_sentinel_arctic_mitchell");
	precachemodel("worldhands_sentinel_arctic_mitchell");
	precacheitem("s1_unarmed");
	precachemodel("laser_explosive_crate");
	precachemodel("laser_explosive_crate_obj");
	precachemodel("vehicle_skyjack_drone_pod_ai");
	precachemodel("vehicle_skyjack_drone_pod_parachute_large");
	precachemodel("vehicle_skyjack_drone_pod_parachutes_mini");
	precachemodel("csh_skyjack_drone_cables");
	precachemodel("atlas_vtol_cargo_plane_ext_dstrypv");
	precachemodel("vfx_metal_scrap_debris_01");
	precachemodel("vfx_metal_scrap_debris_03");
	precachemodel("vfx_metal_scrap_debris_10");
	precachemodel("body_hero_cormack_sentinel_halo_jetpack");
	precachemodel("body_hero_cormack_sentinel_halo");
	precachemodel("jetpack_sentinel_halo");
	precacherumble("steady_rumble");
	precacheshader("fullscreen_dirt_left");
	precacheshader("jump_hud_vignette");
	precachestring(&"CRASH_SKYJACK_CHARGES");
	precachestring(&"CRASH_SKYJACK_CHARGES_KEYBOARD");
	precachestring(&"CRASH_FAIL_PLANE_FALL");
	jetpack_fly_setup();
	mag_glove_precache();
	setup_mag_glove_anims();
	level.cosine = [];
	level.cosine["45"] = cos(45);
}

//Function Number: 2
debug_start_skyjack()
{
	maps\crash::set_completed_flags();
	maps\crash_utility::setup_player();
	maps\crash_utility::setup_allies();
	thread maps\crash::objective_init();
}

//Function Number: 3
crash_introscreen()
{
	level.player freezecontrols(1);
	var_00 = newclienthudelem(level.player);
	var_00 setshader("black",1280,720);
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	var_00.alpha = 1;
	var_00.foreground = 0;
	setsaveddvar("cg_cinematicfullscreen","1");
	cinematicingame("chyron_text_crash");
	wait(1);
	while(iscinematicplaying())
	{
		wait(0.05);
	}

	common_scripts\utility::flag_set("display_chyron");
	level.player thread maps\_hud_util::fade_out(0.05,"black");
	level.player freezecontrols(1);
	wait(0.5);
	var_00.alpha = 0;
	var_00 destroy();
}

//Function Number: 4
begin_skyjack()
{
	thread maps\_high_speed_clouds::cloudfastinit("none",(180,0,0));
	level.skyjack_animnode = common_scripts\utility::getstruct("skyjack_animnode","targetname");
	thread skyjack_player();
	level.player disableweapons();
	level.player freezecontrols(1);
	thread maps\_shg_utility::play_chyron_video("chyron_text_crash",undefined,1);
	common_scripts\utility::flag_wait("chyron_video_done");
	level.player thread maps\_hud_util::fade_out(0.05,"black");
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	var_00 = getent("skyjack_fall_trigger","targetname");
	var_00 common_scripts\utility::trigger_off();
	maps\_utility::vision_set_fog_changes("crash_skyjack_heavy_fog",0);
	level.cormack thread skyjack_cormack();
	thread skyjack_drone_pod();
	thread skyjack_charges();
	thread skyjack_plane();
	thread skyjack_objective();
	soundscripts\_snd::snd_message("intro_skyjack_black");
	thread skyjack_player_fall();
	thread skyjack_dialogue();
	maps\_utility::smart_radio_dialogue("crsh_crmk_breath3");
	level thread maps\_high_speed_clouds::cloudfastheavy(0.1);
	wait(0.4);
	thread cloudrandomizer();
	thread maps\crash_fx::skyjack_plane_contrails();
	maps\_utility::smart_radio_dialogue("crsh_crmk_finalapproach");
	wait(0.2);
	maps\_utility::smart_radio_dialogue("crsh_so_primeobj");
	wait(0.4);
	soundscripts\_snd::snd_message("intro_skyjack_fade_in");
	level.player thread maps\_hud_util::fade_in(1,"black");
	level.player freezecontrols(0);
	thread maps\crash_utility::fly_in_hud();
	common_scripts\utility::flag_set("start_action");
	common_scripts\utility::flag_wait("actual_explosion");
	level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(46,1);
	wait(2.75);
	level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(level.temperature_high_alt,3.8);
	common_scripts\utility::flag_wait("skyjack_done");
	level.player thread maps\crash_exo_temperature::deactivate_heater();
	level.player pushplayervector((0,0,0),0);
}

//Function Number: 5
skyjack_plane()
{
	var_00 = getent("skyjack_cargo_plane","targetname");
	var_00.animname = "cargo_plane";
	var_00 maps\_anim::setanimtree();
	level.skyjack_plane = var_00;
	level.skyjack_animnode thread maps\_anim::anim_loop_solo(var_00,"skyjack_loop_plane","stop_plane");
	level.skyjack_plane thread maps\crash_fx::skyjack_atlas_jet_fx();
	common_scripts\utility::flag_wait("skyjack_explosion");
	thread skyjack_plane_debris();
	level.skyjack_animnode thread maps\_anim::anim_single_solo(var_00,"skyjack_explosion_plane");
	var_00 waittillmatch("begin_explosion","single anim");
	var_00 setmodel("atlas_vtol_cargo_plane_ext_dstrypv");
	thread maps\crash_fx::skyjack_wing_explosion();
	common_scripts\utility::flag_set("actual_explosion");
	wait(3);
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("skyjack_done");
	}
	else
	{
		level waittill("tff_pre_sky_to_site");
	}

	var_00 delete();
}

//Function Number: 6
skyjack_plane_debris()
{
	var_00 = maps\_utility::spawn_anim_model("plane_debris");
	level.skyjack_animnode maps\_anim::anim_first_frame_solo(var_00,"skyjack_explosion_debris");
	var_01 = spawn("script_model",var_00 gettagorigin("j_prop_1"));
	var_02 = spawn("script_model",var_00 gettagorigin("j_prop_2"));
	var_03 = spawn("script_model",var_00 gettagorigin("j_prop_3"));
	var_01 setmodel("vfx_metal_scrap_debris_01");
	var_02 setmodel("vfx_metal_scrap_debris_03");
	var_03 setmodel("vfx_metal_scrap_debris_10");
	var_01.angles = var_00 gettagangles("j_prop_1");
	var_02.angles = var_00 gettagangles("j_prop_2");
	var_03.angles = var_00 gettagangles("j_prop_3");
	var_01 linkto(var_00,"j_prop_1");
	var_02 linkto(var_00,"j_prop_2");
	var_03 linkto(var_00,"j_prop_3");
	level.skyjack_animnode maps\_anim::anim_single_solo(var_00,"skyjack_explosion_debris");
	var_01 delete();
	var_02 delete();
	var_03 delete();
	var_00 delete();
}

//Function Number: 7
skyjack_charges()
{
	var_00 = maps\_utility::spawn_anim_model("explosive");
	var_00 notsolid();
	level.skyjack_animnode thread maps\_anim::anim_first_frame_solo(var_00,"skyjack_setcharge_explosive");
	var_00 hide();
	common_scripts\utility::flag_wait("skyjack_explosion");
	common_scripts\utility::flag_set("obj_end_plant_charges");
	level notify("charges_planted");
	level.skyjack_animnode thread maps\_anim::anim_single_solo(var_00,"skyjack_setcharge_explosive");
	var_00 thread maps\crash_fx::skyjack_charge_fx();
	wait(0.5);
	var_00 show();
	common_scripts\utility::flag_wait("actual_explosion");
	var_00 delete();
}

//Function Number: 8
skyjack_player()
{
	level.player allowprone(0);
	level.player allowcrouch(0);
	level.player allowjump(0);
	level.player_weapons = level.player maps\_utility::get_storable_weapons_list_all();
	level.player takeallweapons();
	level.player giveweapon("s1_unarmed");
	level.player switchtoweaponimmediate("s1_unarmed");
	level.player disableweaponswitch();
	var_00 = maps\_utility::spawn_anim_model("rig");
	var_01 = maps\_utility::spawn_anim_model("rig");
	level.skyjack_animnode thread maps\_anim::anim_first_frame_solo(var_01,"skyjack_wingland_player");
	var_01 hide();
	level.skyjack_animnode thread maps\_anim::anim_first_frame_solo(var_00,"skyjack_wingland_player");
	level.player playerlinktodelta(var_00,"tag_player",1,0,0,0,0,1);
	common_scripts\utility::flag_wait("start_action");
	level.player lerpviewangleclamp(1,0.5,0.5,10,10,5,10);
	level.skyjack_animnode thread maps\_anim::anim_single_solo(var_01,"skyjack_wingland_player");
	level.skyjack_animnode thread maps\_anim::anim_single_solo(var_00,"skyjack_wingland_player");
	var_00 setanim(%crash_skyjack_wingland_player_l,0.01,0);
	var_00 setanim(%crash_skyjack_wingland_player_r,0.01,0);
	var_01 waittillmatch("start_player_control","single anim");
	thread jetpack_fly_input_monitor();
	thread jetpack_fly_play_anims(var_00);
	var_01 waittillmatch("end_player_control","single anim");
	level.player notify("lose_fly_controls");
	var_00 setanim(%crash_skyjack_wingland_player,1,3);
	var_00 setanim(%crash_skyjack_wingland_player_l,0.01,3);
	var_00 setanim(%crash_skyjack_wingland_player_r,0.01,3);
	var_01 waittillmatch("end","single anim");
	var_01 delete();
	common_scripts\utility::flag_set("player_landed_on_plane");
	var_02 = getent("skyjack_fall_trigger","targetname");
	var_02 common_scripts\utility::trigger_on();
	level.player allowmelee(0);
	level.player allowsprint(0);
	level.player allowads(0);
	level.player enableweapons();
	level.player thread mag_glove_player_mount(var_00);
	var_03 = getent("skyjack_charge_trigger","targetname");
	var_03 maps\_utility::addhinttrigger(&"CRASH_SKYJACK_CHARGES",&"CRASH_SKYJACK_CHARGES_KEYBOARD");
	var_04 = getent("charge_objective","targetname");
	maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_03,var_04,cos(40),0,1,level.exo_climb_ground_ref_ent);
	stop_player_mag_gloves();
	var_05 = common_scripts\utility::spawn_tag_origin();
	var_05.origin = var_00.origin;
	var_05.angles = var_00.angles;
	var_05 dontinterpolate();
	var_00 linkto(var_05,"tag_origin");
	var_05 moveto(getstartorigin(level.skyjack_animnode.origin,level.skyjack_animnode.angles,maps\_utility::getanim_from_animname("skyjack_explosion_player","rig")),0.5,0.25,0.25);
	var_05 rotateto(getstartangles(level.skyjack_animnode.origin,level.skyjack_animnode.angles,maps\_utility::getanim_from_animname("skyjack_explosion_player","rig")),0.5,0.25,0.25);
	wait(0.5);
	var_00 unlink();
	var_05 delete();
	var_00.animname = "rig";
	var_00 maps\_utility::assign_animtree();
	common_scripts\utility::flag_set("skyjack_explosion");
	common_scripts\utility::flag_set("skyjack_explosion_lighting");
	var_02 delete();
	level.skyjack_animnode thread maps\_anim::anim_single_solo(var_00,"skyjack_explosion_player");
	level.player disableweapons();
	level.player lerpviewangleclamp(1,0.5,0.5,0,0,0,0);
	wait(0.5);
	wait(15.75);
	level.player playrumbleonentity("heavy_1s");
	wait(2.05);
	level.player playrumbleonentity("heavy_1s");
	wait(1.1);
	level.player playrumbleonentity("heavy_1s");
	level.player thread play_fullscreen_dirt(3,0,2,0.85,0,0);
	var_00 waittillmatch("player_control","single anim");
	level.player lerpviewangleclamp(0.5,0.25,0.25,20,20,5,25);
	thread maps\_high_speed_clouds::cloudsunreset();
	var_00 waittillmatch("no_control","single anim");
	level.player lerpviewangleclamp(1,0.25,0,0,0,0,0);
	var_00 waittillmatch("end","single anim");
	common_scripts\utility::flag_wait("skyjack_done");
	wait(1);
	var_00 delete();
}

//Function Number: 9
skyjack_player_fall()
{
	level endon("skyjack_explosion");
	common_scripts\utility::flag_wait("skyjack_fall");
	setdvar("ui_deadquote",&"CRASH_FAIL_PLANE_FALL");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 10
skyjack_cormack()
{
	maps\_utility::gun_remove();
	maps\_utility::disable_ai_color();
	playfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_l_exhause");
	playfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_r_exhause");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_l_exhause");
	playfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_r_exhause");
	level.skyjack_animnode maps\_anim::anim_first_frame_solo(self,"skyjack_intro_cormack");
	var_00 = common_scripts\utility::spawn_tag_origin();
	self linkto(var_00,"tag_origin");
	common_scripts\utility::flag_wait("start_action");
	level.skyjack_animnode thread maps\_anim::anim_single_solo(self,"skyjack_intro_cormack");
	self waittillmatch("jets_off","single anim");
	stopfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_l_exhause");
	stopfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_l_exhause");
	stopfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_r_exhause");
	stopfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_r_exhause");
	while(!common_scripts\utility::flag("skyjack_explosion") && self getanimtime(maps\_utility::getanim("skyjack_intro_cormack")) < 0.99)
	{
		wait(0.05);
	}

	if(!common_scripts\utility::flag("skyjack_explosion"))
	{
		level.skyjack_animnode thread maps\_anim::anim_loop_solo(self,"skyjack_loop_cormack","stop_cormack_loop");
	}

	common_scripts\utility::flag_wait("skyjack_explosion");
	level.skyjack_animnode notify("stop_cormack_loop");
	level.skyjack_animnode thread maps\_anim::anim_single_solo(self,"skyjack_explosion_cormack");
	self waittillmatch("jets_on","single anim");
	playfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_l_exhause");
	playfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_l_exhause");
	playfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_r_exhause");
	playfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_r_exhause");
	self waittillmatch("vo_kingpin1","single anim");
	thread maps\_utility::smart_radio_dialogue("crsh_crmk_readytoreceived");
	self waittillmatch("vo_ilona1","single anim");
	thread maps\_utility::smart_radio_dialogue("crsh_crmk_droneguidance");
	common_scripts\utility::flag_set("skyjack_end_heavy_clouds");
	self waittillmatch("vo_kingpin2","single anim");
	thread maps\_utility::smart_radio_dialogue("crsh_kp_orbital");
	common_scripts\utility::flag_set("white_fade_start");
	self waittillmatch("end","single anim");
	stopfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_l_exhause");
	stopfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_l_exhause");
	stopfxontag(common_scripts\utility::getfx("jetpack_exhaust_exhaust_npc"),level.cormack,"tag_fx_engine_r_exhause");
	stopfxontag(common_scripts\utility::getfx("jetpack_skyjack_trail"),level.cormack,"tag_fx_engine_r_exhause");
	common_scripts\utility::flag_set("skyjack_white_fade_done");
	common_scripts\utility::flag_set("skyjack_done");
	self unlink();
}

//Function Number: 11
skyjack_drone_pod()
{
	level.drone_pod = maps\_utility::spawn_anim_model("drone_pod");
	wait 0.05;
	level.drone_pod thread maps\crash_fx::skyjack_drone_fx();
	common_scripts\utility::flag_wait("start_action");
	level.skyjack_animnode thread maps\_anim::anim_single_solo(level.drone_pod,"skyjack_intro_drone");
	level.drone_pod waittillmatch("end","single anim");
	level.skyjack_animnode thread maps\_anim::anim_loop_solo(level.drone_pod,"skyjack_loop_drone","stop_drone_loop");
	common_scripts\utility::flag_wait("skyjack_explosion");
	level.skyjack_animnode notify("stop_drone_loop");
	var_00 = [];
	var_00[0] = level.drone_pod;
	var_00[1] = maps\_utility::spawn_anim_model("drone_chute1");
	var_00[2] = maps\_utility::spawn_anim_model("drone_chute2");
	var_00[3] = maps\_utility::spawn_anim_model("drone_chute3");
	var_00[4] = maps\_utility::spawn_anim_model("drone_cable");
	var_00[5] = maps\_utility::spawn_anim_model("mini_chutes");
	level.skyjack_animnode thread maps\_anim::anim_single(var_00,"skyjack_explosion_drone");
	level.mini_chutes = var_00[5];
	var_00[0] waittillmatch("jets_on","single anim");
	var_00[0] waittillmatch("end","single anim");
	common_scripts\utility::flag_wait("skyjack_done");
	wait(0.2);
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}
}

//Function Number: 12
mini_chute_hide(param_00)
{
	level.mini_chutes hide();
}

//Function Number: 13
skyjack_dialogue()
{
	common_scripts\utility::flag_wait("player_landed_on_plane");
	wait(1);
	maps\_utility::smart_radio_dialogue("crsh_crmk_watchwinds");
	wait(1.5);
	maps\_utility::smart_radio_dialogue("crsh_crmk_setcharge1");
	common_scripts\utility::flag_set("obj_start_plant_charges");
	thread skyjack_charges_nag_vo();
	common_scripts\utility::flag_wait("skyjack_explosion");
	wait(1.25);
	maps\_utility::smart_radio_dialogue("crsh_crmk_settingcharge");
}

//Function Number: 14
skyjack_objective()
{
	var_00 = maps\_utility::spawn_anim_model("explosive");
	var_00 setmodel("laser_explosive_crate_obj");
	var_00 notsolid();
	level.skyjack_animnode thread maps\_anim::anim_single_solo(var_00,"skyjack_setcharge_explosive");
	wait 0.05;
	var_00 setanimtime(var_00 maps\_utility::getanim("skyjack_setcharge_explosive"),0.225);
	var_00 setanimrate(var_00 maps\_utility::getanim("skyjack_setcharge_explosive"),0);
	var_00 hide();
	common_scripts\utility::flag_wait("obj_start_plant_charges");
	var_00 show();
	common_scripts\utility::flag_wait("skyjack_explosion");
	var_00 delete();
}

//Function Number: 15
skyjack_charges_nag_vo()
{
	if(common_scripts\utility::flag("skyjack_explosion"))
	{
		return;
	}

	level endon("charges_planted");
	level endon("skyjack_explosion");
	wait(25);
	var_00 = maps\_utility::make_array("crsh_crmk_setcharge2","crsh_crmk_getchargeset");
	var_01 = -1;
	for(;;)
	{
		var_02 = randomint(var_00.size);
		if(var_02 == var_01)
		{
			var_02++;
			if(var_02 >= var_00.size)
			{
				var_02 = 0;
			}
		}

		var_03 = var_00[var_02];
		maps\_utility::smart_radio_dialogue(var_03);
		wait(35);
		var_01 = var_02;
		wait 0.05;
	}
}

//Function Number: 16
play_fullscreen_dirt(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = newclienthudelem(self);
	var_06.x = param_04;
	var_06.y = param_05;
	var_06 setshader("fullscreen_dirt_left",640,480);
	var_06.splatter = 1;
	var_06.alignx = "left";
	var_06.aligny = "top";
	var_06.sort = 1;
	var_06.foreground = 0;
	var_06.horzalign = "fullscreen";
	var_06.vertalign = "fullscreen";
	var_06.alpha = 0;
	var_07 = 0;
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_08 = 0.05;
	if(param_01 > 0)
	{
		var_09 = 0;
		var_0A = param_03 / param_01 / var_08;
		while(var_09 < param_03)
		{
			var_06.alpha = var_09;
			var_09 = var_09 + var_0A;
			wait(var_08);
		}
	}

	var_06.alpha = param_03;
	wait(param_00 - param_01 + param_02);
	if(param_02 > 0)
	{
		var_09 = param_03;
		var_0B = param_03 / param_02 / var_08;
		while(var_09 > 0)
		{
			var_06.alpha = var_09;
			var_09 = var_09 - var_0B;
			wait(var_08);
		}
	}

	var_06.alpha = 0;
	var_06 destroy();
}

//Function Number: 17
cloudrandomizer()
{
	var_00 = 10;
	var_01 = 0;
	common_scripts\utility::flag_wait("start_action");
	wait(7.5);
	level thread maps\_high_speed_clouds::cloudfasteffectchange(1,1.5);
	soundscripts\_snd::snd_message("exit_cloud",1.5);
	if(common_scripts\utility::flag("start_skyjack_temperature"))
	{
		level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(level.temperature_high_alt,1.5);
	}

	wait(8);
	while(!common_scripts\utility::flag("skyjack_explosion"))
	{
		wait(randomfloatrange(3.5,7));
		var_00 = randomintrange(5,9);
		var_01 = randomfloatrange(0.25,2);
		level thread maps\_high_speed_clouds::cloudfasteffectchange(var_00,var_01);
		if(common_scripts\utility::flag("start_skyjack_temperature"))
		{
			level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(level.temperature_high_alt_wind,clamp(var_01,1.5,3));
		}

		wait(randomfloatrange(1.5,4));
		var_00 = randomintrange(1,4);
		var_01 = randomfloatrange(0.25,2);
		level thread maps\_high_speed_clouds::cloudfasteffectchange(var_00,var_01);
		if(common_scripts\utility::flag("start_skyjack_temperature"))
		{
			level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(level.temperature_high_alt,clamp(var_01,1.5,4));
		}
	}

	level thread maps\_high_speed_clouds::cloudfasteffectchange(0,1);
	common_scripts\utility::flag_wait("start_clouds_again");
	level thread maps\_high_speed_clouds::cloudfasteffectchange(4,2);
	common_scripts\utility::flag_wait("skyjack_end_heavy_clouds");
	level thread maps\_high_speed_clouds::cloudfasteffectchange(10,3.5);
	soundscripts\_snd::snd_message("enter_cloud",3.5,10);
	level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(level.temperature_high_alt_wind,3.5);
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"start_hud");
	common_scripts\utility::flag_wait("white_fade_start");
	level.player maps\_utility::fog_set_changes("crash_skyjack_heavy_fog",3);
	wait(8);
}

//Function Number: 18
jetpack_fly_setup()
{
	common_scripts\utility::flag_init("left_pressed");
	common_scripts\utility::flag_init("right_pressed");
}

//Function Number: 19
jetpack_fly_input_monitor()
{
	level.player endon("death");
	level.player endon("lose_fly_controls");
	level endon("stop_player_fly");
	for(;;)
	{
		var_00 = level.player getnormalizedmovement();
		if(var_00[1] >= 0.35)
		{
			common_scripts\utility::flag_clear("left_pressed");
			common_scripts\utility::flag_set("right_pressed");
		}
		else if(var_00[1] <= -0.35)
		{
			common_scripts\utility::flag_clear("right_pressed");
			common_scripts\utility::flag_set("left_pressed");
		}
		else
		{
			common_scripts\utility::flag_clear("left_pressed");
			common_scripts\utility::flag_clear("right_pressed");
		}

		wait 0.05;
	}
}

//Function Number: 20
jetpack_fly_play_anims(param_00)
{
	level.player endon("death");
	level.player endon("lose_fly_controls");
	level endon("stop_player_fly");
	var_01 = 2.25;
	var_02 = 2.25;
	for(;;)
	{
		if(common_scripts\utility::flag("left_pressed"))
		{
			param_00 setanim(%crash_skyjack_wingland_player_l,1,var_01);
			param_00 setanim(%crash_skyjack_wingland_player,0.01,var_01);
			param_00 setanim(%crash_skyjack_wingland_player_r,0.01,var_02);
			common_scripts\utility::flag_waitopen("left_pressed");
			param_00 setanim(%crash_skyjack_wingland_player,1,var_02);
			param_00 setanim(%crash_skyjack_wingland_player_l,0.01,var_02);
			param_00 setanim(%crash_skyjack_wingland_player_r,0.01,var_02);
			continue;
		}

		if(common_scripts\utility::flag("right_pressed"))
		{
			param_00 setanim(%crash_skyjack_wingland_player_r,1,var_01);
			param_00 setanim(%crash_skyjack_wingland_player,0.01,var_01);
			param_00 setanim(%crash_skyjack_wingland_player_l,0.01,var_02);
			common_scripts\utility::flag_waitopen("right_pressed");
			param_00 setanim(%crash_skyjack_wingland_player,1,var_02);
			param_00 setanim(%crash_skyjack_wingland_player_r,0.01,var_02);
			param_00 setanim(%crash_skyjack_wingland_player_l,0.01,var_02);
			continue;
		}

		common_scripts\utility::flag_wait_any("left_pressed","right_pressed");
	}
}

//Function Number: 21
mag_glove_precache()
{
	precacherumble("falling_land");
	precacherumble("damage_light");
}

//Function Number: 22
setup_mag_glove_anims()
{
	level.scr_animtree["player_climb_rig"] = #animtree;
	level.scr_model["player_climb_rig"] = "viewbody_sentinel_arctic_mitchell";
	level.scr_anim["player_climb_rig"]["idle_magnetic_gloves"][0] = %crash_skyjack_vm_exoclimb_mag_idle;
	level.scr_anim["player_climb_rig"]["magnetic_u_0"] = %crash_skyjack_vm_exoclimb_mag_up_00;
	level.scr_anim["player_climb_rig"]["magnetic_u_1"] = %crash_skyjack_vm_exoclimb_mag_up_01;
	level.scr_anim["player_climb_rig"]["magnetic_u_2"] = %crash_skyjack_vm_exoclimb_mag_up_02;
	level.scr_anim["player_climb_rig"]["magnetic_d_0"] = %crash_skyjack_vm_exoclimb_mag_down_00;
	level.scr_anim["player_climb_rig"]["magnetic_d_1"] = %crash_skyjack_vm_exoclimb_mag_down_01;
	level.scr_anim["player_climb_rig"]["magnetic_d_2"] = %crash_skyjack_vm_exoclimb_mag_down_02;
	level.scr_anim["player_climb_rig"]["magnetic_l_0"] = %crash_skyjack_vm_exoclimb_mag_left_00;
	level.scr_anim["player_climb_rig"]["magnetic_l_1"] = %crash_skyjack_vm_exoclimb_mag_left_01;
	level.scr_anim["player_climb_rig"]["magnetic_l_2"] = %crash_skyjack_vm_exoclimb_mag_left_02;
	level.scr_anim["player_climb_rig"]["magnetic_r_0"] = %crash_skyjack_vm_exoclimb_mag_right_00;
	level.scr_anim["player_climb_rig"]["magnetic_r_1"] = %crash_skyjack_vm_exoclimb_mag_right_01;
	level.scr_anim["player_climb_rig"]["magnetic_r_2"] = %crash_skyjack_vm_exoclimb_mag_right_02;
	level.exo_climb_move_options = [];
	level.exo_climb_move_options["magnetic"] = [];
	level.exo_climb_anim_offsets = [];
	maps\_exo_climb::setup_climb_anims_parse_anim_offsets(level.scr_anim["player_climb_rig"]);
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::maps\_exo_climb::exo_climb_mag_rumble,"magnetic_r_2");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_u_0");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_u_1");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_u_2");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_d_0");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_d_1");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_d_2");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_l_0");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_l_1");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_l_2");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_r_0");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_r_1");
	maps\_exo_climb::add_mag_move_notetracks("magnetic_r_2");
}

//Function Number: 23
mag_glove_player_mount(param_00)
{
	level.exo_climb_magnetic_trigs = getentarray("plane_mag_glove_trigger","targetname");
	level.exo_climb_rig = param_00;
	level.exo_climb_rig.animname = "player_climb_rig";
	level.exo_climb_rig maps\_utility::assign_animtree();
	level.exo_climb_rig.facing = "center";
	if(!isdefined(level.exo_climb_player_center))
	{
		level.exo_climb_player_center = spawn("script_origin",level.exo_climb_rig.origin);
		level.exo_climb_player_center.angles = level.exo_climb_rig.angles;
		level.exo_climb_player_center linkto(level.exo_climb_rig,"tag_origin",(0,0,0),(0,0,0));
	}

	level.player lerpviewangleclamp(0.5,0.25,0.25,15,15,15,15);
	level.player enableslowaim(1,0.6);
	level thread mag_glove_player_controller();
}

//Function Number: 24
mag_glove_player_controller()
{
	level.player endon("stop_player_mag_gloves");
	thread mag_glove_orient_to_surface();
	maps\_exo_climb::enter_state_on_mag_surface();
	maps\_exo_climb::restore_idle();
	for(;;)
	{
		if(maps\_exo_climb::climbing_helper_player_mag_moving())
		{
			var_00 = mag_glove_get_requested_move_direction(level.exo_climb_rig);
			if(maps\_exo_climb::climbing_helper_player_input_1_allowed() && var_00 == level.exo_climb_rig.mag_move_dir && maps\_exo_climb::magnetic_hands_direction_is_valid(var_00))
			{
				maps\_exo_climb::climbing_motion_start_player_mag_move(var_00);
			}
			else if(maps\_exo_climb::climbing_helper_player_input_2_allowed() && var_00 != level.exo_climb_rig.mag_move_dir && maps\_exo_climb::magnetic_hands_direction_is_valid(var_00))
			{
				maps\_exo_climb::climbing_motion_start_player_mag_move(var_00);
			}
			else
			{
				maps\_exo_climb::climbing_motion_player_moving_on_magnetic_surface();
			}
		}
		else
		{
			var_00 = mag_glove_get_requested_move_direction(level.exo_climb_rig);
			if(maps\_exo_climb::magnetic_hands_direction_is_valid(var_00))
			{
				maps\_exo_climb::climbing_motion_start_player_mag_move(var_00);
			}
		}

		wait(0.05);
	}
}

//Function Number: 25
mag_glove_get_requested_move_direction(param_00)
{
	var_01 = level.player getnormalizedmovement();
	if(length2d(var_01) <= 0.15)
	{
		return "";
	}

	return mag_glove_get_direction_from_normalized_movement(var_01,param_00);
}

//Function Number: 26
mag_glove_get_direction_from_normalized_movement(param_00,param_01)
{
	var_02 = angleclamp360(param_00[0],param_00[1]);
	var_03 = level.player.angles[1] - param_01.angles[1];
	var_02 = angleclamp180(var_02 + var_03);
	var_04 = "";
	if(var_02 < -120 || var_02 > 150)
	{
		var_04 = "l";
	}
	else if(var_02 < -60)
	{
		var_04 = "d";
	}
	else if(var_02 < 30)
	{
		var_04 = "r";
	}
	else
	{
		var_04 = "u";
	}

	return var_04;
}

//Function Number: 27
mag_glove_orient_to_surface()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_01 = level.player.angles[1];
	var_02 = 0.5;
	while(isdefined(level.exo_climb_rig))
	{
		if(level.exo_climb_rig islinked())
		{
			level.exo_climb_rig unlink();
		}

		var_00.origin = level.exo_climb_rig.origin;
		var_00.angles = level.exo_climb_rig.angles;
		var_00 dontinterpolate();
		level.exo_climb_rig linkto(var_00,"tag_origin");
		var_03 = level.exo_climb_rig.origin + anglestoforward(level.exo_climb_rig.angles) * 12;
		var_04 = bullettrace(var_03 + (0,0,200),var_03 - (0,0,10000),0,level.player,0,0,1);
		var_00 moveto((var_00.origin[0],var_00.origin[1],var_04["position"][2] - 2),var_02);
		var_00 rotateto((0,var_01,0) - (90 + vectortoangles(var_04["normal"])[0],0,vectortoangles(var_04["normal"])[2]),var_02);
		wait(var_02);
		var_02 = 0.1;
	}

	var_00 delete();
}

//Function Number: 28
stop_player_mag_gloves()
{
	level.player notify("stop_player_mag_gloves");
	level.exo_climb_player_center unlink();
	level.exo_climb_player_center delete();
	level.exo_climb_player_center = undefined;
	if(level.exo_climb_rig islinked())
	{
		level.exo_climb_rig unlink();
	}

	maps\_exo_climb::climbing_animation_stop_idle();
	wait(0.05);
	maps\_exo_climb::restore_idle();
	wait(0.2);
	level.exo_climb_rig = undefined;
	level.player disableslowaim();
}

//Function Number: 29
adjust_angles_to_player(param_00)
{
	var_01 = param_00[0];
	var_02 = param_00[2];
	var_03 = anglestoright(level.player.angles);
	var_04 = anglestoforward(level.player.angles);
	var_05 = (var_03[0],0,var_03[1] * -1);
	var_06 = (var_04[0],0,var_04[1] * -1);
	var_07 = var_06 * var_01;
	var_07 = var_07 + var_05 * var_02;
	return var_07 + (0,param_00[1],0);
}

//Function Number: 30
plodding_footsteps_ends()
{
	level waittill("stop_plodding_footsteps");
	var_00 = 0.8;
	level.ground_ref_ent rotateto((0,0,0),var_00,var_00 * 0.5,var_00 * 0.5);
	level.player maps\_utility::blend_movespeedscale(1,0.8);
	wait(var_00);
	level.ground_ref_ent delete();
	level.player playersetgroundreferenceent(undefined);
	level.player notify("blend_movespeedscale");
	level.player maps\_utility_code::movespeed_set_func(1);
}

//Function Number: 31
plodding_footsteps()
{
	level endon("stop_plodding_footsteps");
	thread plodding_footsteps_ends();
	level.player notify("blend_movespeedscale");
	level.player maps\_utility_code::movespeed_set_func(0.45);
	level.ground_ref_ent = spawn("script_model",(0,0,0));
	level.player playersetgroundreferenceent(level.ground_ref_ent);
	var_00 = 4;
	var_01 = 3;
	var_02 = 4.5;
	var_03 = 0;
	var_04 = 0.05;
	var_05 = 0;
	for(;;)
	{
		if(!level.player attackbuttonpressed())
		{
			if(level.player.movespeedscale == 0)
			{
				level.player maps\_utility::blend_movespeedscale(0.45,0.25);
			}

			var_06 = min(distance((0,0,0),level.player getvelocity()),35);
			if(var_06 == 0)
			{
				level.ground_ref_ent rotateto((0,0,0),0.25,0.125,0.125);
				var_03 = level.ground_ref_ent.angles[0];
			}
			else
			{
				var_03 = var_03 + var_06 * 0.3;
				if(cos(var_03) > 0)
				{
					var_03 = var_03 + var_06 * 0.1;
					if(!var_05)
					{
						var_05 = 1;
						level.player maps\_utility::blend_movespeedscale(0.45,0.25);
					}
				}
				else if(var_05)
				{
					var_05 = 0;
					level.player maps\_utility::blend_movespeedscale(0.2,0.1);
				}

				var_07 = sin(var_03) - 0.75 * var_00;
				var_08 = sin(var_03 * -0.5) * var_01;
				var_09 = sin(var_03 * 0.5) * var_02;
				var_0A = adjust_angles_to_player((var_07,var_08,var_09));
				level.ground_ref_ent rotateto(var_0A,var_04,var_04 * 0.5,var_04 * 0.5);
			}
		}
		else
		{
			level.player notify("blend_movespeedscale");
			level.player maps\_utility_code::movespeed_set_func(0);
			level.ground_ref_ent rotateto((0,0,0),0.25,0.125,0.125);
			var_03 = level.ground_ref_ent.angles[0];
		}

		wait(0.05);
	}
}