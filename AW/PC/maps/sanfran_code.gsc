/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 157
 * Decompile Time: 2339 ms
 * Timestamp: 4/22/2024 2:35:45 AM
*******************************************************************/

//Function Number: 1
handle_drone_opening(param_00)
{
	maps\sanfran_util::setup_intro();
	level.player maps\_shg_utility::setup_player_for_scene();
	wait(1);
	maps\sanfran_util::show_water_intro();
	level thread intro_moving_ships();
	maps\sanfran_util::delete_roadsurface_bridge();
	level.player unlink();
	level.player disableslowaim();
	common_scripts\utility::flag_set("msg_vfx_zone2_driving_chase");
	level thread handle_driving_section();
	level thread vehicle_scripts\_sentinel_survey_drone_hud::hud_end();
}

//Function Number: 2
helicopter_view_intro(param_00)
{
	var_01 = getent("intro_drone_position_01","targetname");
	var_02 = getent(var_01.target,"targetname");
	level.player playerlinktodelta(var_01,undefined,1,0,0,0,0);
	level.player playerlinktodelta(var_01,undefined,1,8,8,4,4);
	level.player enableslowaim();
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player lightsetforplayer("helicopter_view_intro_0");
	level thread vehicle_scripts\_sentinel_survey_drone_hud::hud_start(level.player,0.5,1);
	soundscripts\_snd::snd_message("aud_drone_view_intro_start");
	wait(0.05);
	thread maps\sanfran_util::drone_view_shake(0.05);
	var_01 thread maps\sanfran_util::drone_moveto_ent(var_01.target,40);
	wait(2);
	if(!isdefined(param_00))
	{
		common_scripts\utility::flag_set("flag_dialog_start_intro");
	}

	var_01 thread maps\sanfran_util::drone_lookat_ent("fake_mob",0,1);
	wait(0.5);
	if(!isdefined(param_00))
	{
		common_scripts\utility::flag_set("flag_dialog_intro_fleet");
	}

	wait(8);
	thread intro_ship_icons();
	common_scripts\utility::flag_set("flag_zoom_in_fleet");
	level notify("aud_drone_view_intro_zoom_in_fleet");
	level.player lerpfov(27,0.25);
	wait(0.25);
	level.player lerpfov(30,0.25);
	wait(3.25);
	common_scripts\utility::flag_set("flag_zoom_out_fleet");
	level notify("aud_drone_view_intro_zoom_out_fleet");
	level.player lerpfov(67,0.25);
	wait(0.25);
	level.player lerpfov(65,0.25);
	thread vehicle_scripts\_sentinel_survey_drone_hud::remove_hud_drone_target();
	wait(2.75);
	if(!isdefined(param_00))
	{
		common_scripts\utility::flag_set("flag_dialog_intro_cargo");
	}

	wait(1);
	vehicle_scripts\_sentinel_survey_drone_hud::destroy_sentinel_drone_hud();
	level notify("aud_drone_view_intro_switch_to_camera_2");
	thread showstatic(0.1);
	var_01 = getent("intro_drone_position_02","targetname");
	var_01 thread maps\sanfran_util::drone_lookat_ent("cargo_ship_2");
	level.player playerlinktodelta(var_01,undefined,1,0,0,0,0);
	level.player playerlinktodelta(var_01,undefined,1,8,8,4,4);
	common_scripts\utility::flag_set("flag_cargo_ship");
	vehicle_scripts\_sentinel_survey_drone_hud::hud_start(level.player,1,2);
	var_01 thread maps\sanfran_util::drone_moveto_ent(var_01.target,40);
	wait(1.25);
	var_01 thread maps\sanfran_util::drone_lookat_ent("cargo_ship_2",0.5,0,(-6,-10,0));
	common_scripts\utility::flag_set("flag_zoom_in_cargo");
	level notify("aud_drone_view_intro_zoom_in_cargo");
	level.player lerpfov(43,0.5);
	wait(0.5);
	level.player lerpfov(45,0.5);
	level thread narrow_in_camera_play(var_01);
	wait(0.5);
	wait(2);
	level notify("stop_narrow_play");
	if(!isdefined(param_00))
	{
		wait(1.5);
		common_scripts\utility::flag_set("flag_intro_transition_to_driving");
		level notify("aud_drone_view_intro_transition_to_tunnel");
	}

	if(level.currentgen)
	{
		if(!istransientloaded("sanfran_intro_tr"))
		{
			level waittill("tff_transition_outro_to_intro");
		}
	}

	vehicle_scripts\_sentinel_survey_drone_hud::destroy_sentinel_drone_hud();
	level.player lightsetforplayer("helicopter_view_intro_1");
}

//Function Number: 3
narrow_in_camera_play(param_00)
{
	level endon("stop_narrow_play");
	var_01 = 8;
	var_02 = 4;
	for(;;)
	{
		level.player playerlinktodelta(param_00,undefined,1,var_01,var_01,var_02,var_02);
		wait(0.05);
		var_01 = clamp(var_01 - 0.08,4,8);
		var_02 = clamp(var_02 - 0.04,2,4);
	}
}

//Function Number: 4
fadeupstatic(param_00)
{
	level.overlaystatic = newhudelem(level.player);
	level.overlaystatic.x = 0;
	level.overlaystatic.y = 0;
	level.overlaystatic.alpha = 0;
	level.overlaystatic.horzalign = "fullscreen";
	level.overlaystatic.vertalign = "fullscreen";
	level.overlaystatic.sort = 4;
	level.overlaystatic setshader("overlay_static_digital",640,480);
	level.overlaystatic2 = newhudelem(level.player);
	level.overlaystatic2.x = 0;
	level.overlaystatic2.y = 0;
	level.overlaystatic2.alpha = 0;
	level.overlaystatic2.color = (0.1,0.1,0.1);
	level.overlaystatic2.horzalign = "fullscreen";
	level.overlaystatic2.vertalign = "fullscreen";
	level.overlaystatic2.sort = 5;
	level.overlaystatic2 setshader("sentinel_drone_overlay",640,480);
	var_01 = 0.05 / param_00;
	while(level.overlaystatic.alpha < 1)
	{
		level.overlaystatic.alpha = level.overlaystatic.alpha + var_01;
		level.overlaystatic2.alpha = level.overlaystatic.alpha;
		wait(0.05);
	}
}

//Function Number: 5
fadedownstatic(param_00)
{
	var_01 = 0.05 / param_00;
	while(level.overlaystatic.alpha >= 0)
	{
		level.overlaystatic.alpha = level.overlaystatic.alpha - var_01;
		level.overlaystatic2.alpha = level.overlaystatic.alpha;
		wait(0.05);
	}

	level.overlaystatic destroy();
	level.overlaystatic2 destroy();
}

//Function Number: 6
showstatic(param_00)
{
	level.overlaystatic = newhudelem(level.player);
	level.overlaystatic.x = 0;
	level.overlaystatic.y = 0;
	level.overlaystatic.alpha = 1;
	level.overlaystatic.horzalign = "fullscreen";
	level.overlaystatic.vertalign = "fullscreen";
	level.overlaystatic.sort = 4;
	level.overlaystatic setshader("overlay_static_digital",640,480);
	wait(param_00);
	level.overlaystatic destroy();
}

//Function Number: 7
intro_moving_ships()
{
	maps\sanfran_util::toggle_off_real_mob();
	var_00 = [];
	var_01 = [];
	var_00[var_00.size] = getent("fake_mob","targetname");
	var_00[var_00.size] = getent("cargo_ship","targetname");
	var_00[var_00.size] = getent("cargo_ship_2","targetname");
	var_02 = getentarray("navy_ship","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_02);
	var_02 = getentarray("navy_ship_right","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_02);
	foreach(var_04 in var_00)
	{
		var_04 thread moveboat();
	}

	if(level.nextgen)
	{
		wait(60);
	}
	else if(!istransientloaded("sanfran_outro_tr"))
	{
		level waittill("tff_transition_intro_to_outro");
	}

	foreach(var_04 in var_00)
	{
		var_04 notify("stop_ship_moving");
		var_04 maps\sanfran_fx::stop_wakefx();
		var_04.origin = var_04.original_org;
		var_04.angles = var_04.original_ang;
	}

	thread maps\sanfran_util::init_bobbing_boats();
}

//Function Number: 8
moveboat()
{
	maps\sanfran_fx::attach_wakefx();
	position_for_movement();
	if(self.model == "vehicle_atlas_decoy_cargo_ship")
	{
		thread start_moving_with_bob();
		return;
	}

	self moveto(self.original_org,120,0,0);
}

//Function Number: 9
start_moving_with_bob()
{
	self endon("stop_ship_moving");
	var_00 = 1;
	var_01 = 120;
	for(;;)
	{
		var_02 = randomfloatrange(3,5);
		var_03 = self.original_org - self.origin;
		var_04 = var_03 / var_01 * var_02;
		var_05 = self.origin + var_04;
		var_06 = var_00 * randomfloatrange(125,175);
		self moveto(var_05 + (0,0,var_06),var_02,0,0);
		wait(var_02);
		var_00 = var_00 * -1;
		var_01 = var_01 - var_02;
	}
}

//Function Number: 10
intro_ship_icons()
{
	level endon("remove_hud_drone_target");
	var_00 = [];
	var_00[var_00.size] = getent("cargo_ship","targetname");
	var_00[var_00.size] = getent("cargo_ship_2","targetname");
	var_01 = getentarray("navy_ship","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	var_02 = getent("fake_mob","targetname");
	var_02 vehicle_scripts\_sentinel_survey_drone_hud::create_hud_drone_target(1);
	foreach(var_04 in var_00)
	{
		var_04 vehicle_scripts\_sentinel_survey_drone_hud::create_hud_drone_target(0);
		soundscripts\_snd::snd_message("aud_drone_view_intro_target");
		wait(0.25);
	}
}

//Function Number: 11
position_for_movement()
{
	self.original_org = self.origin;
	self.original_ang = self.angles;
	var_00 = 0.35;
	if(self.model == "vehicle_cvn_carrier")
	{
		var_00 = 0.75;
	}

	if(self.model == "vehicle_atlas_decoy_cargo_ship")
	{
		var_00 = 0.65;
	}

	if(self.model == "vehicle_naval_littoral")
	{
		var_00 = 0.3;
	}

	var_01 = getent(self.target,"targetname");
	var_02 = self.origin - var_01.origin;
	var_03 = var_01.origin - var_00 * var_02;
	var_04 = vectortoangles(var_02);
	self.origin = var_03;
	self.angles = var_04;
	self moveto(var_01.origin,0.5,0,0);
	wait(0.5);
}

//Function Number: 12
handle_driving_section(param_00)
{
	if(isdefined(param_00))
	{
		maps\_utility::autosave_by_name();
	}

	var_01 = !isdefined(param_00);
	common_scripts\utility::flag_set("flag_dialog_start_tunnel");
	soundscripts\_snd::snd_message("setup_audio_zone_tunnel");
	setup_player_pitbull(var_01);
	level thread handle_chase_van();
	level thread handle_friendly_pitbull();
	if(!isdefined(param_00) || param_00 == "tunnel")
	{
		level.player thread flag_construction_enable_pitbull_shooting();
		if(level.nextgen)
		{
			setsaveddvar("r_umbraAccurateOcclusionThreshold","400");
		}

		thread umbra_override_tunnel();
	}

	level thread start_vehicle_traffic();
	level thread pitbull_update_hud_brightness();
	if(var_01)
	{
		maps\sanfran_util::make_bridge_big();
		common_scripts\utility::flag_set("flag_dialog_tunnel_chase");
		thread maps\sanfran_util::intro_drive_hint();
		thread pitbull_intro_animation();
		common_scripts\utility::flag_set("start_tunnel_lighting");
		wait(0.05);
		level.player lerpfov(65,0.1);
	}
	else if(param_00 == "oncoming")
	{
		common_scripts\utility::flag_set("flag_hud_brighten");
		maps\sanfran_util::make_bridge_big();
	}
	else if(param_00 == "bridge")
	{
		common_scripts\utility::flag_set("flag_hud_brighten");
	}

	maps\sanfran_util::toggle_all_boats_off();
	maps\sanfran_util::show_water_final();
	thread maps\_player_exo::player_exo_deactivate();
	level thread handle_atlas_intercepts();
	common_scripts\utility::run_thread_on_targetname("trigger_driving_save",::driving_section_save);
	common_scripts\utility::run_thread_on_targetname("trigger_start_crash_bus",::start_crash_bus);
	common_scripts\utility::run_thread_on_targetname("trigger_start_construction_heli",::start_construction_heli);
	common_scripts\utility::run_thread_on_targetname("trigger_open_gate",::crash_open_gate);
	common_scripts\utility::run_thread_on_targetname("trigger_start_tanker",::start_tanker_explosion);
	common_scripts\utility::run_thread_on_targetname("trigger_start_blocking_police",::start_blocking_police);
	common_scripts\utility::run_thread_on_targetname("trigger_start_knocked_to_oncoming",::start_knocked_to_oncoming);
	common_scripts\utility::run_thread_on_targetname("trigger_start_bridge_helicopter",::start_bridge_heli);
	common_scripts\utility::run_thread_on_targetname("trigger_start_player_crash",::player_crash);
	common_scripts\utility::run_thread_on_targetname("trigger_make_bridge_small",::maps\sanfran_util::trigger_bridge_small);
	common_scripts\utility::run_thread_on_targetname("trigger_toggle_on_boats",::maps\sanfran_util::toggle_all_boats_on_trigger);
	if(!isdefined(param_00))
	{
		common_scripts\utility::flag_wait("flag_pitbull_allow_shooting");
		while(!isdefined(level.atlas_intercepts))
		{
			wait(0.5);
		}

		maps\sanfran_util::enable_pitbull_shooting();
		level.player_pitbull waittill("set_new_target");
		wait(1);
		level thread maps\sanfran_util::intro_shoot_hint();
		common_scripts\utility::flag_set("flag_player_can_fire");
		common_scripts\utility::flag_wait("flag_player_has_shot_pitbull");
		wait(1);
	}
}

//Function Number: 13
pitbull_update_hud_brightness()
{
	common_scripts\utility::flag_wait("flag_hud_brighten");
	level.player_pitbull.fake_vehicle_model setmaterialscriptparam(0.25,0.5);
	level.friendly_pitbull thread maps\_vehicle::vehicle_lights_off("brakelights");
	level.chase_van thread maps\_vehicle::vehicle_lights_off("brakelights");
}

//Function Number: 14
pitbull_play_lui_cinematic()
{
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingame("sanfran_dronefeed",0,1,1);
}

//Function Number: 15
pitbull_intro_animation()
{
	waittillframeend;
	thread pitbull_play_lui_cinematic();
	level thread intro_view_traffic();
	maps\sanfran_util::setup_squad_for_scene();
	thread pitbull_intro_control_rumble();
	level.player_pitbull maps\_utility::ent_flag_set("pitbull_scripted_anim");
	level.player_pitbull maps\sanfran_pitbull_drive_anim::clear_anims();
	level.player_pitbull maps\sanfran_pitbull::disconnect_fake_pitbull();
	var_00 = level.player_pitbull.player_rig;
	var_01 = level.player_pitbull.fake_vehicle_model;
	var_02 = [];
	var_02[0] = var_00;
	var_02[1] = level.burke;
	level.burke notify("animontagdone","end");
	level.burke notify("pitbull_get_out");
	level.burke maps\_utility::anim_stopanimscripted();
	var_01 maps\_anim::anim_first_frame_solo(var_01,"pitbull_intro");
	var_01 maps\_anim::anim_first_frame_solo(var_00,"pitbull_intro","tag_body");
	var_00 linkto(var_01,"tag_body");
	thread maps\sanfran_pitbull::show_video_on_driverside();
	level.player dontinterpolate();
	level.player playerlinktodelta(var_00,"tag_player",1,10,10,5,5,1);
	level.player enableslowaim();
	level.player thread remove_camera_view_angles(var_00 maps\_utility::getanim("pitbull_intro"),0.5,0.1);
	level thread anim_van_intro(var_01);
	var_01 thread maps\_anim::anim_single_solo(var_01,"pitbull_intro");
	var_01 maps\_anim::anim_single(var_02,"pitbull_intro","tag_body");
	var_03 = maps\_vehicle_aianim::anim_pos(level.player_pitbull,1);
	var_01 thread maps\sanfran_pitbull::passenger_idle(level.burke,var_03);
	level.player disableslowaim();
	level.player_pitbull maps\sanfran_pitbull::reconnect_fake_pitbull();
	level.chase_van.lead_pos = "far";
	level.player_pitbull.attachedpath = undefined;
	level.player_pitbull notify("newpath");
	level.player_pitbull returnplayercontrol();
	level.player playerlinkedvehicleanglesenable();
	common_scripts\utility::flag_set("flag_intro_give_player_driving");
	soundscripts\_snd::snd_message("intro_give_player_driving");
	level.player_pitbull maps\_utility::ent_flag_clear("pitbull_scripted_anim");
	maps\sanfran_util::setup_squad_for_gameplay();
	if(level.nextgen)
	{
		maps\_utility::autosave_by_name();
	}
	else
	{
		maps\_utility::autosave_now();
	}

	thread start_reverse_hint();
	thread vehicle_blocked_check();
}

//Function Number: 16
pitbull_intro_control_rumble()
{
	level endon("flag_intro_give_player_driving");
	var_00 = maps\_utility::get_rumble_ent("steady_rumble");
	var_00.intensity = 0.09;
	var_00 common_scripts\utility::delaycall(11.25,::stoprumble,"steady_rumble");
	level.player common_scripts\utility::delaycall(11.75,::playrumbleonentity,"heavy_1s");
	wait(13);
	var_00 delete();
}

//Function Number: 17
remove_camera_view_angles(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = getanimlength(param_00);
	var_04 = var_03 - param_01 + param_02;
	if(var_04 > 0)
	{
		wait(var_04);
	}

	self lerpviewangleclamp(param_01,0.2,0.2,0,0,0,0);
}

//Function Number: 18
intro_view_traffic()
{
	level endon("flag_intro_give_player_driving");
	wait(2);
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("fake_traffic_intro_truck");
	level thread maps\_vehicle_traffic::add_script_car(var_00);
	var_00 thread delete_vehicle_outof_view();
	var_00 thread maps\_vehicle::vehicle_lights_on("brakelights");
	var_00 thread maps\sanfran_lighting::setup_car_passing_lights();
	wait(4);
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("fake_traffic_intro_bus");
	var_00 thread maps\_vehicle::vehicle_lights_on("brakelights");
	var_00 thread maps\sanfran_lighting::setup_car_passing_lights();
	level thread maps\_vehicle_traffic::add_script_car(var_00);
	var_00 thread delete_vehicle_outof_view();
	wait(4);
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("fake_traffic_intro_van");
	var_00 thread maps\_vehicle::vehicle_lights_on("brakelights");
	var_00 thread maps\sanfran_lighting::setup_car_passing_lights();
	level thread maps\_vehicle_traffic::add_script_car(var_00);
	var_00 thread delete_vehicle_outof_view();
}

//Function Number: 19
umbra_override_tunnel()
{
	common_scripts\utility::flag_wait("flag_hud_brighten");
	if(level.nextgen)
	{
		setsaveddvar("r_umbraAccurateOcclusionThreshold","256");
	}
}

//Function Number: 20
use_turn_signal(param_00,param_01)
{
	self endon("death");
	var_02 = [];
	if(param_00 == "left")
	{
		var_02 = ["taillight_left","mirrorlight_left","frontsignal_left"];
	}
	else if(param_00 == "right")
	{
		var_02 = ["taillight_right","mirrorlight_right","frontsignal_right"];
	}

	while(param_01 > 0)
	{
		foreach(var_04 in var_02)
		{
			maps\_vehicle::vehicle_single_light_on(var_04);
		}

		wait(0.35);
		param_01 = param_01 - 0.35;
		foreach(var_04 in var_02)
		{
			maps\_vehicle::vehicle_single_light_off(var_04);
		}

		wait(0.5);
		param_01 = param_01 - 0.5;
	}
}

//Function Number: 21
delete_vehicle_outof_view()
{
	level waittill("flag_intro_give_player_driving");
	for(;;)
	{
		if(!maps\sanfran_util::player_can_see(self.origin,125))
		{
			self delete();
			break;
		}

		wait(0.05);
	}
}

//Function Number: 22
anim_van_intro(param_00)
{
	var_01 = spawn("script_model",level.chase_van.origin);
	var_01 setmodel("vehicle_ind_van_utility_ai");
	var_01.animname = "atlas_van";
	var_01 useanimtree(#animtree);
	var_01 thread wakeup_physics_sphere_on_ent(195);
	var_01 thread maps\sanfran_lighting::setup_car_passing_lights();
	param_00 maps\_anim::anim_first_frame_solo(var_01,"pitbull_intro","tag_turret");
	var_01 linkto(param_00,"tag_turret");
	param_00 soundscripts\_snd::snd_message("chase_van_rabbiting_anim");
	param_00 maps\_anim::anim_single_solo(var_01,"pitbull_intro","tag_turret");
	level.chase_van vehicle_teleport(var_01.origin,level.chase_van.angles);
	var_02 = getvehiclenode("van_anim_start_drive","targetname");
	level.chase_van thread maps\_vehicle_code::_vehicle_paths(var_02);
	level.chase_van startpath(var_02);
	var_01 unlink();
	var_01 delete();
	common_scripts\utility::flag_set("flag_intro_van_anim_finished");
}

//Function Number: 23
wakeup_physics_sphere_on_ent(param_00)
{
	self endon("death");
	if(self.code_classname == "script_model")
	{
		var_01 = 1;
		var_02 = self setcontents(0);
		self setcontents(var_02 | var_01);
	}

	for(;;)
	{
		wakeupphysicssphere(self.origin,param_00);
		wait 0.05;
	}
}

//Function Number: 24
start_vehicle_traffic()
{
	wait(0.25);
	var_00 = getent("player_start_pos","targetname");
	thread maps\_vehicle_traffic::setup_traffic_path("road_path","bridge_damageable_vehicle_spawner",1,var_00);
	thread maps\_vehicle_traffic::setup_traffic_path("road_path_flood","bridge_damageable_vehicle_spawner",1,var_00);
	thread maps\_vehicle_traffic::setup_traffic_path("bridge_path","bridge_damageable_vehicle_spawner",1,var_00);
	thread maps\_vehicle_traffic::setup_traffic_path("bridge_path_split","bridge_damageable_vehicle_spawner",1,var_00);
	thread maps\_vehicle_traffic::setup_traffic_path("road_onramp","bridge_damageable_vehicle_spawner",1,var_00);
}

//Function Number: 25
setup_player_pitbull(param_00)
{
	if(!isdefined(level.player_pitbull))
	{
		level.player_pitbull = maps\_vehicle::spawn_vehicle_from_targetname("player_pitbull");
		thread maps\_vehicle_traffic::add_script_car(level.player_pitbull);
	}

	level.player_pitbull soundscripts\_snd::snd_message("pc_pitbull_spawn");
	level.player unlink();
	level.player_pitbull thread maps\sanfran_aud::player_pitbull_woosh_sounds();
	level.player_pitbull thread maps\sanfran_pitbull::handle_player_pitbull("player_rig");
	level.player_pitbull thread mount_pitbull(param_00);
	level.player_pitbull thread pitbull_flipped_failsafe();
	level.player_pitbull maps\_utility::ent_flag_clear("pitbull_allow_shooting");
	setsaveddvar("bg_viewBobMax",0);
	maps\sanfran_util::spawn_squad();
	level.player_pitbull maps\sanfran_pitbull::add_passenger_to_player_pitbull(level.burke,1);
	level.player_pitbull maps\sanfran_pitbull::add_passenger_to_player_pitbull(level.saint,2);
	level.player_pitbull thread maps\sanfran_fx::vfx_car_radial_damage();
}

//Function Number: 26
flag_construction_enable_pitbull_shooting()
{
	self endon("death");
	self endon("flag_pitbull_allow_shooting");
	common_scripts\utility::flag_wait("flag_pitbull_allow_firing");
	common_scripts\utility::flag_set("flag_pitbull_allow_shooting");
}

//Function Number: 27
disable_pitbull_use()
{
	wait(0.25);
	level.player_pitbull makeunusable();
}

//Function Number: 28
mount_pitbull(param_00)
{
	waittillframeend;
	self notify("mount_pitbull",param_00);
}

//Function Number: 29
pitbull_flipped_failsafe()
{
	self endon("death");
	self endon("dismount_pitbull");
	var_00 = 0;
	for(;;)
	{
		if(!isdefined(level.player.drivingvehicle) || level.player.drivingvehicle != self)
		{
			var_00 = 0;
			wait(0.2);
			continue;
		}

		if(maps\_utility::ent_flag("pitbull_scripted_anim"))
		{
			var_00 = 0;
			maps\_utility::ent_flag_waitopen("pitbull_scripted_anim");
			wait(0.2);
			continue;
		}

		var_01 = anglestoup(self.angles);
		var_02 = vectordot(var_01,(0,0,1));
		if(var_02 < 0.1)
		{
			var_00 = var_00 + 0.2;
		}
		else
		{
			var_00 = 0;
		}

		if(var_00 >= 2)
		{
			setdvar("ui_deadquote",&"SANFRAN_FAIL_CHASE");
			maps\_utility::missionfailedwrapper();
		}

		wait(0.2);
	}
}

//Function Number: 30
handle_chase_van()
{
	var_00 = 0;
	if(!isdefined(level.chase_van))
	{
		level.chase_van = maps\_vehicle::spawn_vehicle_from_targetname("chase_van");
		thread maps\_vehicle_traffic::add_script_car(level.chase_van);
		level.chase_van thread maps\_vehicle::vehicle_lights_on("brakelights");
		var_00 = 1;
	}

	level.chase_van endon("death");
	level.chase_van maps\_vehicle::godon();
	level.chase_van vehphys_disablecrashing();
	if(var_00 == 1)
	{
		common_scripts\utility::flag_wait("flag_intro_van_anim_finished");
	}

	common_scripts\utility::flag_set("flag_obj_van_intercept");
	level.chase_van thread fail_chase_van();
	if(!isdefined(level.chase_van.lead_pos))
	{
		level.chase_van.lead_pos = "far";
	}

	var_01 = undefined;
	common_scripts\utility::run_thread_on_targetname("trigger_chase_van_set_far",::maps\sanfran_util::chase_van_set_far);
	common_scripts\utility::run_thread_on_targetname("trigger_chase_van_set_medium",::maps\sanfran_util::chase_van_set_medium);
	common_scripts\utility::run_thread_on_targetname("trigger_chase_van_set_close",::maps\sanfran_util::chase_van_set_close);
	if(!common_scripts\utility::flag("flag_intro_give_player_driving"))
	{
		common_scripts\utility::flag_wait("flag_intro_give_player_driving");
		level.chase_van vehicle_setspeed(55,100,100);
	}

	for(;;)
	{
		if(common_scripts\utility::flag("flag_player_crashed"))
		{
			break;
		}

		if(!isdefined(var_01) || var_01 != level.chase_van.lead_pos)
		{
			var_01 = level.chase_van.lead_pos;
			if(var_01 == "close")
			{
				level.chase_van thread maps\sanfran_util::vehicle_chase_target(level.player_pitbull,1280,1536,5,5,1,0,0,0,35);
			}
			else if(var_01 == "medium")
			{
				level.chase_van thread maps\sanfran_util::vehicle_chase_target(level.player_pitbull,2176,2688,5,5,1,0,0,0,35);
			}
			else if(var_01 == "far")
			{
				level.chase_van thread maps\sanfran_util::vehicle_chase_target(level.player_pitbull,3328,3584,5,5,1,0,0,0,35);
			}
			else
			{
			}
		}

		wait(0.05);
	}

	level.chase_van notify("stop_chase_target");
	level.chase_van resumespeed(30);
}

//Function Number: 31
start_reverse_hint()
{
	level endon("player_crash_scene");
	level endon("display_reverse_tutorial");
	for(;;)
	{
		if((isdefined(level.chase_van) && !common_scripts\utility::flag("flag_oncoming_scene_playing") && !common_scripts\utility::flag("flag_final_crash_scene_playing")) || !common_scripts\utility::flag("missionfailed"))
		{
			var_00 = level.player maps\_utility::player_looking_at(level.chase_van.origin,0.4,1);
			if(!var_00)
			{
				thread show_reverse_tutorial();
				break;
			}
		}

		wait(0.15);
	}
}

//Function Number: 32
show_reverse_tutorial()
{
	level notify("display_reverse_tutorial");
	while(level.player_pitbull.veh_speed > 10)
	{
		wait 0.05;
	}

	common_scripts\utility::flag_set("flag_reverse_hint_displayed");
	thread maps\_utility::hintdisplayhandler("reverse_hint",5);
}

//Function Number: 33
show_reverse_tutorial_check()
{
	if(!isdefined(level.player_pitbull))
	{
		return 1;
	}

	if(level.player_pitbull.veh_speed > 30 || common_scripts\utility::flag("flag_oncoming_scene_playing") || common_scripts\utility::flag("flag_final_crash_scene_playing"))
	{
		common_scripts\utility::flag_clear("flag_reverse_hint_displayed");
		return 1;
	}

	return 0;
}

//Function Number: 34
vehicle_blocked_check()
{
	level endon("player_crash_scene");
	level endon("display_reverse_tutorial");
	for(;;)
	{
		var_00 = level.player_pitbull vehicle_getspeed();
		if(var_00 < 2)
		{
			wait(0.8);
			if(!common_scripts\utility::flag("flag_oncoming_scene_playing") || !common_scripts\utility::flag("flag_final_crash_scene_playing") || !common_scripts\utility::flag("missionfailed"))
			{
				var_01 = 250;
				var_02 = level.player_pitbull gettagorigin("left_wheel_01_jnt");
				var_03 = common_scripts\utility::flat_angle(level.player_pitbull gettagangles("left_wheel_01_jnt"));
				var_02 = var_02 + anglestoforward(var_03) * 30;
				var_02 = (var_02[0],var_02[1] + 45,var_02[2] + 25);
				var_04 = var_02 + anglestoforward(var_03) * var_01;
				var_05 = bullettrace(var_02,var_04,0,0,0,0,1);
				if(isdefined(var_05["surfacetype"]) && var_05["surfacetype"] != "none")
				{
					thread show_reverse_tutorial();
					break;
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 35
driving_section_save()
{
	self waittill("trigger");
	var_00 = 0;
	while(var_00 < 5)
	{
		var_01 = level.player maps\_utility::player_looking_at(level.chase_van.origin,0.15,1);
		if(level.player_close_to_fail_dist == 0 && var_01 == 1)
		{
			for(var_02 = 0;var_02 < level.players.size;var_02++)
			{
				var_03 = level.players[var_02];
				if(!var_03 maps\_autosave::autosavehealthcheck())
				{
					break;
				}

				maps\_utility::autosave_now();
			}

			break;
		}

		wait(0.15);
		var_00 = var_00 + 0.15;
	}
}

//Function Number: 36
fail_chase_van()
{
	level endon("flag_player_crashed");
	common_scripts\utility::run_thread_on_targetname("trigger_leaving_driving_section",::fail_leaving_area);
	level.player_close_to_fail_dist = 0;
	wait(1);
	for(;;)
	{
		var_00 = distance(level.player.origin,self.origin);
		if(var_00 > 6000)
		{
			setdvar("ui_deadquote",&"SANFRAN_FAIL_CHASE");
			maps\_utility::missionfailedwrapper();
		}
		else if(var_00 > 4500 && !common_scripts\utility::flag("flag_reverse_hint_displayed"))
		{
			maps\sanfran_util::player_too_far_hint();
			level.player_close_to_fail_dist = 1;
		}
		else
		{
			common_scripts\utility::flag_clear("flag_hint_player_too_far");
			level.player_close_to_fail_dist = 0;
		}

		wait(0.15);
	}
}

//Function Number: 37
fail_leaving_area()
{
	if(!isdefined(level.player_out_of_bounds_count))
	{
		level.player_out_of_bounds_count = 0;
	}

	level endon("flag_player_crashed");
	for(;;)
	{
		self waittill("trigger");
		level.player_out_of_bounds_count++;
		if(level.player_out_of_bounds_count == 1)
		{
			level.fail_start_time = gettime();
		}

		maps\sanfran_util::player_left_road_hint();
		while(level.player istouching(self))
		{
			var_00 = gettime();
			var_01 = var_00 - level.fail_start_time;
			wait(0.05);
		}

		wait(0.05);
		level.player_out_of_bounds_count--;
		if(level.player_out_of_bounds_count == 0)
		{
			common_scripts\utility::flag_clear("flag_hint_player_left_road");
		}
	}
}

//Function Number: 38
handle_friendly_pitbull()
{
	var_00 = 0;
	if(!isdefined(level.friendly_pitbull))
	{
		level.friendly_pitbull = maps\_vehicle::spawn_vehicle_from_targetname("friendly_pitbull");
		thread maps\_vehicle_traffic::add_script_car(level.friendly_pitbull);
		level.friendly_pitbull thread maps\_vehicle::vehicle_lights_on("brakelights");
		var_00 = 1;
	}

	level.friendly_pitbull endon("death");
	level.friendly_pitbull maps\_vehicle::godon();
	level.friendly_pitbull vehphys_disablecrashing();
	if(var_00 == 1)
	{
		common_scripts\utility::flag_wait("flag_intro_van_anim_finished");
		level.friendly_pitbull startpath();
	}

	if(!isdefined(level.friendly_pitbull.shadow_pos))
	{
		level.friendly_pitbull.shadow_pos = "player";
	}

	var_01 = undefined;
	common_scripts\utility::run_thread_on_targetname("trigger_pitbull_shadow_chase_van",::maps\sanfran_util::friendly_pitbull_shadow_chase_van);
	common_scripts\utility::run_thread_on_targetname("trigger_pitbull_shadow_player",::maps\sanfran_util::friendly_pitbull_shadow_player);
	level.friendly_pitbull thread maps\sanfran_pitbull::handle_friendly_pitbull_shooting();
	level.friendly_pitbull thread maps\sanfran_util::vehicle_oscillate_location(1024,3);
	for(;;)
	{
		if(common_scripts\utility::flag("flag_player_crashed"))
		{
			break;
		}

		if(!isdefined(var_01) || var_01 != level.friendly_pitbull.shadow_pos)
		{
			var_01 = level.friendly_pitbull.shadow_pos;
			if(var_01 == "van")
			{
				level.friendly_pitbull thread maps\sanfran_util::vehicle_chase_target(level.chase_van,768,1024,5,5,0,1,1,0);
			}
			else if(var_01 == "player")
			{
				level.friendly_pitbull thread maps\sanfran_util::vehicle_chase_target(level.player_pitbull,768,1024,5,5,1,0,1,0);
			}
			else
			{
			}
		}

		wait(0.05);
	}

	level.friendly_pitbull notify("stop_chase_target");
	level.friendly_pitbull resumespeed(30);
}

//Function Number: 39
handle_atlas_intercepts()
{
	level endon("flag_player_crashed");
	common_scripts\utility::run_thread_on_targetname("trigger_spawn_atlas_intercept",::spawn_atlas_intercept);
	if(!isdefined(level.atlas_intercepts))
	{
		level.atlas_intercepts = [];
	}

	for(;;)
	{
		level.atlas_intercepts = maps\_utility::array_removedead(level.atlas_intercepts);
		wait(0.05);
	}
}

//Function Number: 40
delete_atlas_intercepts()
{
	foreach(var_01 in level.atlas_intercepts)
	{
		var_01 delete();
	}
}

//Function Number: 41
spawn_atlas_intercept()
{
	level endon("flag_player_crashed");
	self waittill("trigger");
	for(var_00 = 0;var_00 < level.atlas_intercepts.size;var_00++)
	{
		if(level.atlas_intercepts[var_00].targetname == self.script_noteworthy)
		{
			return;
		}
	}

	var_01 = getent(self.target,"targetname");
	if(maps\sanfran_util::player_can_see(var_01.origin,45))
	{
		return;
	}

	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_01.targetname);
	thread maps\_vehicle_traffic::add_script_car(var_02);
	var_02.script_noteworthy = "target_vehicle";
	var_02.targetname = self.script_noteworthy;
	foreach(var_04 in var_02.riders)
	{
		var_04.accuracy = 200;
	}

	var_02 thread cleanup_atlas_on_death();
	level.atlas_intercepts[level.atlas_intercepts.size] = var_02;
	var_06 = randomint(100);
	if(var_02.targetname == "right_atlas_intercept")
	{
		if(var_06 < 50)
		{
			var_02 thread maps\sanfran_util::vehicle_chase_target(level.chase_van,512,768,5,5,0,1,1,1);
		}
		else
		{
			var_02 thread maps\sanfran_util::vehicle_chase_target(level.friendly_pitbull,256,384,5,5,0,1,1,1);
		}
	}
	else if(level.chase_van.lead_pos == "close")
	{
		if(var_06 < 10)
		{
			var_02 thread maps\sanfran_util::vehicle_chase_target(level.chase_van,512,768,5,5,0,1,1,1);
		}
		else if(var_06 < 55)
		{
			var_02 thread maps\sanfran_util::vehicle_chase_target(level.friendly_pitbull,256,384,5,5,0,1,1,1);
		}
		else
		{
			var_02 thread maps\sanfran_util::vehicle_chase_target(level.player_pitbull,1024,1280,5,5,1,0,1,1);
		}
	}
	else if(var_06 < 50)
	{
		var_02 thread maps\sanfran_util::vehicle_chase_target(level.friendly_pitbull,256,384,5,5,0,1,1,1);
	}
	else
	{
		var_02 thread maps\sanfran_util::vehicle_chase_target(level.player_pitbull,1024,1280,5,5,1,0,1,1);
	}

	var_02 thread maps\_vehicle_traffic::detect_being_pushed(::delete_atlas_intercept);
	if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "crash_at_end")
	{
		wakeupphysicssphere(var_01.origin,195);
		var_02 thread maps\sanfran_util::wait_for_crash_at_end();
	}

	common_scripts\utility::flag_wait("flag_player_crashed");
	self notify("stop_chase_target");
	self resumespeed(30);
}

//Function Number: 42
delete_atlas_intercept()
{
	self dodamage(1000000000,self.origin);
}

//Function Number: 43
cleanup_atlas_on_death()
{
	self waittill("death",var_00,var_01,var_02);
	if(isdefined(var_02) && var_02 == "pitbull_turret" && isdefined(level.player_pitbull))
	{
		level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
	}

	common_scripts\utility::array_remove(level.atlas_intercepts,self);
	wait(5);
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 44
start_crash_bus()
{
	self waittill("trigger");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("veh_crash_bus");
	var_00 maps\_vehicle::godon();
	thread maps\_vehicle_traffic::add_script_car(var_00);
	thread maps\_vehicle_traffic::clear_cars_around_pos(var_00.origin,2000);
	var_00 vehphys_disablecrashing();
	var_00 thread bus_crash_at_end();
	level thread maps\sanfran_util::get_vehicles_to_point_at_same_time(level.chase_van,"bus_crash_location",var_00,undefined,"stop_bus_syncup");
}

//Function Number: 45
bus_crash_at_end()
{
	self waittill("reached_end_node");
	level notify("stop_bus_syncup");
	self vehphys_setspeed(0,10000,10000);
	self.animname = "bus";
	self useanimtree(#animtree);
	maps\_utility::anim_stopanimscripted();
	soundscripts\_snd::snd_message("bus_crash_start");
	common_scripts\utility::flag_set("flag_dialog_tunnel_bus");
	thread bus_crash_setup_backup_collision();
	thread bus_crash_hold_on_last_frame();
	var_00 = getent("bus_crash_origin","targetname");
	var_00 maps\_anim::anim_single_solo(self,"bus_crash");
	thread maps\_vehicle_traffic::remove_script_car(self);
	maps\_vehicle::godoff();
}

//Function Number: 46
bus_crash_setup_backup_collision()
{
	var_00 = getanimlength(maps\_utility::getanim("bus_crash")) - 1;
	wait(var_00);
	maps\sanfran_util::show_ents_by_targetname("bus_crash_final_pos_col");
	maps\sanfran_util::solid_ents_by_targetname("bus_crash_final_pos_col");
}

//Function Number: 47
bus_crash_hold_on_last_frame()
{
	wait(getanimlength(maps\_utility::getanim("bus_crash")) - 0.1);
	self setanimrate(maps\_utility::getanim("bus_crash"),0);
}

//Function Number: 48
start_construction_heli()
{
	self waittill("trigger");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("construction_heli");
	var_00 waittill("heli_at_construction");
	var_00 thread maps\sanfran_util::vehicle_chase_target(level.player_pitbull,2800,3000,0,0,1,0,0,0);
	common_scripts\utility::run_thread_on_targetname("trigger_heli_start_shooting",::construction_heli_shoot,var_00);
	var_00 waittill("heli_at_tanker");
	var_00 notify("stop_chase_target");
	var_00 resumespeed(80);
}

//Function Number: 49
construction_heli_shoot(param_00)
{
	self waittill("trigger");
	var_01 = [];
	var_02 = 1;
	for(;;)
	{
		var_03 = getent("heli_construction_target_" + var_02,"targetname");
		if(!isdefined(var_03))
		{
			break;
		}

		var_01[var_01.size] = var_03;
		var_02++;
	}

	var_04 = magicbullet("pitbull_magicbullet",param_00.origin + (0,0,-150),var_01[0].origin);
	var_04 soundscripts\_snd::snd_message("npc_heli_shot",param_00);
	wait(1);
	var_04 = magicbullet("pitbull_magicbullet",param_00.origin + (0,0,-150),var_01[1].origin);
	var_04 soundscripts\_snd::snd_message("npc_heli_shot",param_00);
	wait(1);
	var_04 = magicbullet("pitbull_magicbullet",param_00.origin + (0,0,-150),var_01[2].origin);
	var_04 soundscripts\_snd::snd_message("npc_heli_shot",param_00);
}

//Function Number: 50
crash_open_gate()
{
	self waittill("trigger",var_00);
	soundscripts\_snd::snd_message("gate_crash");
	common_scripts\utility::run_thread_on_targetname("construction_gate_left",::crash_open_left_gate);
	common_scripts\utility::run_thread_on_targetname("construction_gate_right",::crash_open_right_gate);
	thread maps\sanfran_fx::vfx_gate_crash_open();
	common_scripts\utility::run_thread_on_targetname("trigger_water_splash",::water_splash);
}

//Function Number: 51
crash_open_left_gate()
{
	var_00 = self.angles;
	var_01 = (var_00[0],var_00[1] + 80,var_00[2]);
	self rotateto(var_01,0.4,0,0.1);
}

//Function Number: 52
crash_open_right_gate()
{
	var_00 = self.angles;
	var_01 = (var_00[0],var_00[1] - 100,var_00[2]);
	self rotateto(var_01,0.4,0,0.1);
}

//Function Number: 53
water_splash()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isdefined(var_00.splashing_water))
		{
			var_00.splashing_water = 0;
		}

		if(var_00.splashing_water == 0)
		{
			var_00 thread vehicle_splash_water(self);
		}
	}
}

//Function Number: 54
vehicle_splash_water(param_00)
{
	self endon("death");
	self.splashing_water = 1;
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 thread splash_pos_for_speed(self);
	for(;;)
	{
		wait(0.25);
		if(!var_01 istouching(param_00))
		{
			break;
		}
	}

	self.splashing_water = 0;
	var_01 unlink();
	var_01 delete();
}

//Function Number: 55
splash_pos_for_speed(param_00)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		self unlink();
		var_01 = vectornormalize(param_00 vehicle_getvelocity());
		var_02 = vectornormalize(anglestoforward(param_00.angles));
		var_03 = vectordot(var_01,var_02);
		var_04 = param_00 vehicle_getspeed();
		var_05 = var_04 / 70 * 450 + 200;
		if(var_05 > 0.2)
		{
			if(var_03 > 0)
			{
				var_06 = param_00.origin + var_05 * anglestoforward(self.angles);
			}
			else
			{
				var_06 = param_00.origin - var_05 * anglestoforward(self.angles);
			}
		}
		else
		{
			var_06 = param_00.origin + (0,0,-1000);
		}

		self.origin = var_06;
		self linkto(param_00);
		wait(0.05);
	}
}

//Function Number: 56
start_tanker_explosion()
{
	self waittill("trigger");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(self.target);
	var_01 = getent("crash_truck_cab_brushmodel","targetname");
	var_02 = getent("crash_truck_tank_brushmodel","targetname");
	var_01 store_offsets_for_link(var_00,"tag_headlight_right");
	var_02 store_offsets_for_link(var_00,"tag_brakelight_right");
	var_01 link_with_stored_offsets(var_00);
	var_02 link_with_stored_offsets(var_00);
	level thread start_tanker_on_ramp_traffic();
	level thread handle_tanker_missiles(var_00);
	level thread maps\sanfran_util::get_vehicles_to_point_at_same_time(level.chase_van,"tanker_missile_location",var_00,"tanker_missile_location");
	if(level.currentgen)
	{
		level waittill("tff_pre_transition_intro_to_outro");
		var_02 delete();
		var_01 delete();
	}
}

//Function Number: 57
store_offsets_for_link(param_00,param_01)
{
	self.link_tag = param_01;
	self.link_offset = transformmove((0,0,0),(0,0,0),param_00 gettagorigin(param_01),param_00 gettagangles(param_01),self.origin,self.angles);
}

//Function Number: 58
link_with_stored_offsets(param_00)
{
	self linkto(param_00,self.link_tag,self.link_offset["origin"],self.link_offset["angles"]);
}

//Function Number: 59
handle_tanker_missiles(param_00)
{
	level.chase_van thread fire_first_tanker_missile(param_00);
	param_00 thread wait_for_missile();
}

//Function Number: 60
fire_first_tanker_missile(param_00)
{
	self waittill("tanker_first_missile_location");
	var_01 = self.origin + (0,0,100) + 100 * anglestoright(self.angles);
	var_02 = param_00.origin + (0,0,100) + -300 * anglestoforward(param_00.angles);
	magicbullet("rpg_nodamage",var_01,var_02);
}

//Function Number: 61
wait_for_missile()
{
	self waittill("tanker_missile_location");
	wait(0.05);
	self resumespeed(20);
	var_00 = 50;
	for(;;)
	{
		var_01 = level.chase_van.origin + (0,0,var_00) + 100 * anglestoright(level.chase_van.angles);
		var_02 = self.origin + (0,0,64) + 400 * anglestoforward(self.angles);
		var_03 = bullettrace(var_01,var_02,1);
		if(!isdefined(var_03["entity"]) && var_03["fraction"] > 0.9)
		{
			break;
		}

		var_00 = var_00 + 5;
		if(var_00 > 100)
		{
			break;
		}
	}

	magicbullet("rpg_nodamage",var_01,var_02);
	wait(1);
	level thread tanker_roll_explosion(self);
}

//Function Number: 62
tanker_roll_explosion(param_00)
{
	common_scripts\utility::flag_set("flag_dialog_tunnel_tanker");
	var_01 = getent("tanker_crash_origin","targetname");
	var_02 = distance(param_00.origin,var_01.origin);
	for(;;)
	{
		wait(0.05);
		var_03 = distance(param_00.origin,var_01.origin);
		if(var_03 > var_02)
		{
			break;
		}

		var_02 = var_03;
	}

	var_04 = spawn("script_model",(0,0,0));
	var_04 setmodel("vehicle_ind_semi_truck_fuel_tanker");
	var_04.animname = "tanker";
	var_04 useanimtree(#animtree);
	var_04.origin = param_00.origin;
	var_04.angles = param_00.angles;
	var_05 = getent("crash_truck_cab_brushmodel","targetname");
	var_06 = getent("crash_truck_tank_brushmodel","targetname");
	var_05 link_with_stored_offsets(var_04);
	var_06 link_with_stored_offsets(var_04);
	param_00 delete();
	var_04 soundscripts\_snd::snd_message("aud_tanker_crash");
	var_04 thread maps\sanfran_fx::oil_tanker_crash_fx();
	var_01 maps\_anim::anim_single_solo(var_04,"tanker_crash");
}

//Function Number: 63
start_tanker_on_ramp_traffic()
{
	wait(3);
	maps\_vehicle_traffic::spawn_single_vehicle_for_lane("road_onramp_1","bridge_damageable_vehicle_spawner");
	wait(3);
	maps\_vehicle_traffic::spawn_single_vehicle_for_lane("road_onramp_1","bridge_damageable_vehicle_spawner");
	wait(3);
	maps\_vehicle_traffic::spawn_single_vehicle_for_lane("road_onramp_1","bridge_damageable_vehicle_spawner");
}

//Function Number: 64
start_blocking_police()
{
	self waittill("trigger");
	var_00 = getent("police_blocking_collision","targetname");
	var_00 notsolid();
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(self.target);
	var_01 waittill("reached_end_node");
	var_01 vehphys_setspeed(0);
	var_02 = spawn("script_model",var_01.origin);
	var_02 setmodel(var_01.model);
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles;
	var_02 soundscripts\_snd::snd_message("spawn_driving_police_car");
	var_01 delete();
	var_00 solid();
}

//Function Number: 65
start_knocked_to_oncoming()
{
	self waittill("trigger");
	common_scripts\utility::flag_set("flag_dialog_pre_oncoming_knocked");
	wait(0.4);
	level.player_pitbull maps\_utility::ent_flag_set("pitbull_scripted_anim");
	level.player_pitbull maps\_utility::ent_flag_clear("pitbull_allow_shooting");
	level.player_pitbull maps\sanfran_pitbull_drive_anim::clear_anims();
	level.player enabledeathshield(1);
	var_00 = getent("knocked_to_oncoming_origin","targetname");
	thread knocked_to_oncoming_rumble();
	var_01 = level.player_pitbull.player_rig;
	var_02 = level.player_pitbull.fake_vehicle_model;
	var_03 = [];
	var_03[0] = var_01;
	soundscripts\_snd::snd_message("van_cuts_off_player");
	thread maps\_vehicle_traffic::clear_cars_around_pos(var_00.origin,200);
	foreach(var_05 in level.atlas_intercepts)
	{
		if(distance(level.player_pitbull.origin,var_05.origin) < 200)
		{
			var_05 delete();
		}
	}

	level.player_pitbull vehicle_teleport(var_00.origin,level.player_pitbull.angles);
	var_02 = level.player_pitbull maps\sanfran_pitbull::disconnect_fake_pitbull();
	var_07 = maps\_vehicle::spawn_vehicle_from_targetname("atlas_van_knock_to_oncoming");
	var_07.animname = "atlas_suv";
	var_07 useanimtree(#animtree);
	var_03 = [];
	var_03[0] = var_02;
	var_03[1] = var_07;
	level.player dontinterpolate();
	var_02 maps\_anim::anim_first_frame_solo(var_02,"oncoming_crash");
	var_02 maps\_anim::anim_first_frame_solo(var_01,"oncoming_crash","tag_driver");
	var_01 linkto(var_02,"tag_driver");
	common_scripts\utility::flag_set("flag_dialog_start_oncoming");
	common_scripts\utility::flag_set("flag_dialog_oncoming_knocked");
	common_scripts\utility::flag_set("flag_oncoming_scene_playing");
	if(level.currentgen)
	{
		level.player_pitbull notify("oncoming_scene_pitbull_monitor_start");
		thread oncoming_scene_pitbull_speed_monitor();
	}

	var_02 thread maps\_anim::anim_single_solo(var_01,"oncoming_crash","tag_driver");
	var_00 maps\_anim::anim_single(var_03,"oncoming_crash");
	common_scripts\utility::flag_clear("flag_oncoming_scene_playing");
	level.player_pitbull maps\sanfran_pitbull::reconnect_fake_pitbull();
	level.player_pitbull vehicle_setspeedimmediate(55,100,60);
	level.player enabledeathshield(0);
	if(level.currentgen)
	{
		level notify("oncoming_scene_pitbull_monitor_stop");
		level.player_pitbull thread maps\sanfran_pitbull::handle_player_pitbull_hud();
	}

	level.player_pitbull maps\_utility::ent_flag_clear("pitbull_scripted_anim");
	level.player_pitbull maps\_utility::ent_flag_set("pitbull_allow_shooting");
	soundscripts\_snd::snd_message("monitor_pitbull_oncoming");
	level thread pitbull_back_to_speed();
	var_07 thread cleanup_oncoming_suv();
	soundscripts\_snd::snd_message("player_in_oncoming");
}

//Function Number: 66
oncoming_scene_pitbull_speed_monitor()
{
	level endon("oncoming_scene_pitbull_monitor_stop");
	var_00 = 0;
	for(;;)
	{
		luinotifyevent(&"pitbull_update_speed",1,level.oncoming_pitbull_speed);
		if(var_00 > 10)
		{
			level.oncoming_pitbull_speed--;
			var_00 = 0;
		}

		wait 0.05;
		var_00++;
	}
}

//Function Number: 67
knocked_to_oncoming_rumble()
{
	level.player common_scripts\utility::delaycall(0.1,::playrumbleonentity,"heavy_3s");
	level.player common_scripts\utility::delaycall(2.2,::playrumbleonentity,"light_1s");
}

//Function Number: 68
pitbull_back_to_speed()
{
	var_00 = gettime();
	level.player_pitbull vehphys_setspeed(55);
	while(gettime() < var_00 + 4000)
	{
		if(level.player attackbuttonpressed())
		{
			break;
		}

		if(level.player buttonpressed("BUTTON_B"))
		{
			break;
		}

		level.player_pitbull vehphys_setspeed(55);
		wait(0.05);
	}
}

//Function Number: 69
cleanup_oncoming_suv()
{
	self endon("death");
	wait(20);
	for(;;)
	{
		if(!maps\sanfran_util::player_can_see(self.origin,45))
		{
			self delete();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 70
start_bridge_heli()
{
	self waittill("trigger");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("bridge_heli");
	for(;;)
	{
		if(!isdefined(level.chase_van))
		{
			break;
		}

		var_01 = anglestoforward(var_00.angles);
		var_02 = vectornormalize(level.chase_van.origin - var_00.origin);
		var_03 = vectordot(var_01,var_02);
		if(var_03 < 0)
		{
			break;
		}

		var_04 = distance(var_00.origin,level.chase_van.origin);
		if(var_04 < 5000)
		{
			break;
		}

		wait(0.05);
	}

	for(var_05 = 0;var_05 < 3;var_05++)
	{
		var_06 = maps\sanfran_util::get_single_living_ent("right_atlas_intercept","targetname");
		var_07 = (0,0,0);
		var_08 = (0,0,0);
		if(isdefined(var_06) && var_05 == 0 && distance(var_00.origin,var_06.origin) < 6000)
		{
			var_07 = 700 * anglestoforward(var_06.angles);
			magicbullet("pitbull_magicbullet",var_00.origin + (0,0,-100),var_06.origin + var_07);
		}
		else
		{
			if(!isdefined(level.chase_van))
			{
				return;
			}

			var_07 = randomfloatrange(800,1200) * anglestoforward(level.chase_van.angles);
			var_08 = randomfloatrange(200,400) * anglestoright(level.chase_van.angles);
			if(randomint(100) < 50)
			{
				var_08 = -1 * var_08;
			}

			magicbullet("pitbull_magicbullet",var_00.origin + (0,0,-100),level.chase_van.origin + var_07 + var_08);
		}

		if(var_05 == 0)
		{
			var_09 = common_scripts\utility::getstruct("bridge_heli_fly_off","targetname");
			var_00 thread maps\_vehicle_code::_vehicle_paths(var_09);
		}

		wait(1.5);
	}
}

//Function Number: 71
player_crash()
{
	self waittill("trigger");
	level notify("player_crash_scene");
	maps\sanfran_util::setup_squad_for_scene();
	level.player_pitbull maps\_utility::ent_flag_set("pitbull_scripted_anim");
	level.player_pitbull maps\_utility::ent_flag_clear("pitbull_allow_shooting");
	level.player_pitbull maps\sanfran_pitbull_drive_anim::clear_anims();
	level.player enabledeathshield(1);
	var_00 = getent("org_player_crash_start","targetname");
	var_01 = level.player_pitbull.player_rig;
	var_02 = level.player_pitbull.fake_vehicle_model;
	thread crash_rumble();
	level.player playerlinktodelta(var_01,"tag_player",1,10,10,5,5,1);
	level.player enableslowaim();
	soundscripts\_snd::snd_message("pitbull_crash_sound_design");
	level.player_pitbull vehicle_teleport(var_00.origin,level.player_pitbull.angles);
	maps\_vehicle_traffic::clear_cars_around_pos(level.player_pitbull.origin,600,1);
	var_02 = level.player_pitbull maps\sanfran_pitbull::disconnect_fake_pitbull();
	var_03 = maps\_vehicle::spawn_vehicle_from_targetname("player_crash_van");
	var_03 maps\_vehicle::godon();
	var_03.animname = "work_van";
	var_03 useanimtree(#animtree);
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname("player_crash_suburban");
	var_04 maps\_vehicle::godon();
	var_04.animname = "atlas_suv";
	var_04 useanimtree(#animtree);
	var_04 hidepart("TAG_DOOR_GLASS_RIGHT_BACK");
	var_00 maps\_anim::anim_first_frame_solo(var_04,"pitbull_crash");
	var_05 = maps\_utility::array_spawn_targetname("player_crash_atlas_guy");
	for(var_06 = 0;var_06 < var_05.size;var_06++)
	{
		var_05[var_06].animname = "atlas_" + var_06 + 1;
	}

	var_01 unlink();
	level.player_pitbull maps\sanfran_pitbull::remove_passenger_from_player_pitbull(level.burke);
	level.burke hide();
	var_07 = [];
	var_07[0] = var_01;
	var_07[1] = var_02;
	var_07[2] = level.burke;
	var_07[3] = var_03;
	var_07[4] = var_04;
	var_07[5] = var_05[0];
	var_07[6] = var_05[1];
	var_07[7] = var_05[2];
	foreach(var_09 in var_07)
	{
		var_09 dontinterpolate();
	}

	level.player_pitbull thread destroy_windshield();
	var_0B = getent("brush_crash_scene_player_pitbull_collision","targetname");
	var_0B.origin = level.player.origin;
	var_0B thread update_bumper_think();
	common_scripts\utility::flag_set("flag_dialog_bridge_crash");
	common_scripts\utility::flag_set("flag_final_crash_scene_playing");
	soundscripts\_snd::snd_message("pc_pitbull_crash");
	var_00 maps\_anim::anim_single(var_07,"pitbull_crash");
	var_07 = [];
	var_07[0] = var_01;
	var_07[1] = var_02;
	common_scripts\utility::flag_set("flag_player_crashed");
	level.chase_van delete();
	delete_atlas_intercepts();
	maps\sanfran_util::show_crash_traffic();
	level.friendly_pitbull delete();
	level notify("stop_traffic");
	level thread start_after_crash_traffic();
	var_03 delete();
	var_04 delete();
	foreach(var_0D in var_05)
	{
		var_0D delete();
	}

	var_01 maps\_utility::attach_player_current_weapon_to_anim_tag("tag_weapon");
	if(level.currentgen)
	{
		loadtransient("sanfran_outro_tr");
	}

	level.player playerlinktodelta(var_01,"tag_player",1,10,10,5,5,1);
	common_scripts\utility::flag_set("flag_dialog_bridge_crawl");
	level.burke show();
	level thread anim_burke_crawl(var_00);
	var_0B delete();
	var_00 maps\_anim::anim_single(var_07,"pitbull_crawl");
	common_scripts\utility::flag_clear("flag_final_crash_scene_playing");
	level.player_pitbull notify("dismount_pitbull");
	get_squad_out_of_pitbull();
	level.player_pitbull delete();
	level.player disableslowaim();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player enablehybridsight("iw5_bal27_sp_variablereddot",1);
	level.player enabledeathshield(0);
	maps\sanfran_util::setup_squad_for_gameplay();
	setsaveddvar("bg_viewBobMax",8);
	if(level.currentgen)
	{
		level notify("tff_pre_transition_intro_to_outro");
		unloadtransient("sanfran_intro_tr");
		while(!istransientloaded("sanfran_outro_tr"))
		{
			wait(0.05);
		}

		level notify("tff_transition_intro_to_outro");
	}

	thread handle_fight_section();
	maps\sanfran_util::toggle_all_boats_on();
	level notify("vfx_pitball_crash_end");
}

//Function Number: 72
update_bumper_think()
{
	self endon("death");
	for(;;)
	{
		var_00 = level.player screenpostoworldpoint((0,0,0),65,100);
		self moveto(var_00,0.05);
		wait(0.05);
	}
}

//Function Number: 73
crash_rumble()
{
	level.player common_scripts\utility::delaycall(0.1,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(2.2,::playrumbleonentity,"heavy_2s");
	level.player common_scripts\utility::delaycall(4,::playrumbleonentity,"light_2s");
	level.player common_scripts\utility::delaycall(6,::playrumbleonentity,"heavy_3s");
	level.player common_scripts\utility::delaycall(8.8,::playrumbleonentity,"heavy_1s");
}

//Function Number: 74
destroy_windshield()
{
	wait(6.05);
	self notify("windshield_state",4);
	wait(0.05);
	self notify("stop_player_pitbull_damage");
}

//Function Number: 75
pitbull_crash_swap_to_real_model(param_00)
{
	level.player_pitbull.fake_vehicle_model hide();
	maps\sanfran_util::show_ents_by_targetname("pitbull_crash_collision");
	maps\sanfran_util::solid_ents_by_targetname("pitbull_crash_collision");
	var_01 = getent("org_player_crash_start","targetname");
	var_02 = getentarray("pitbull_crash_collision","targetname");
	var_03 = undefined;
	foreach(var_05 in var_02)
	{
		if(var_05.classname == "script_model")
		{
			var_03 = var_05;
		}
	}

	var_03.animname = "after_pitbull";
	var_03 useanimtree(#animtree);
	var_01 maps\_anim::anim_single_solo(var_03,"pitbull_wreck");
}

//Function Number: 76
anim_burke_crawl(param_00)
{
	maps\_utility::activate_trigger_with_targetname("trigger_move_from_crash");
	level thread maps\sanfran_fx::burke_spit_blood();
	param_00 maps\_anim::anim_single_solo_run(level.burke,"pitbull_crawl");
	common_scripts\utility::flag_set("flag_player_crash_complete");
}

//Function Number: 77
crash_blackout(param_00)
{
	level.crash_overlay = maps\sanfran_util::get_white_overlay();
	level.crash_overlay thread maps\sanfran_util::blackout(0.01,2);
	soundscripts\_snd::snd_message("aud_pitbull_crash_concussion");
}

//Function Number: 78
crash_wakeup(param_00)
{
	level.crash_overlay thread maps\sanfran_util::restorevision(2,0);
	level.player shellshock("default",14);
}

//Function Number: 79
start_after_crash_traffic(param_00)
{
	if(!isdefined(param_00))
	{
		wait(10.5);
	}
	else
	{
		wait(param_00);
	}

	maps\_vehicle::spawn_vehicles_from_targetname_and_drive("bridge_crash_traffic");
	clean_up_traffic_drivers();
}

//Function Number: 80
clean_up_traffic_drivers()
{
	var_00 = getentarray("crash_traffic_driver","script_noteworthy");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(isai(var_03))
		{
			var_01[var_01.size] = var_03;
			var_03.ignoresonicaoe = 1;
		}
	}

	common_scripts\utility::array_thread(var_01,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_police_battle);
}

//Function Number: 81
get_squad_out_of_pitbull()
{
	level.player_pitbull maps\sanfran_pitbull::remove_passenger_from_player_pitbull(level.saint);
	var_00 = getent("crash_point_saint","targetname");
	level.saint forceteleport(var_00.origin,var_00.angles);
}

//Function Number: 82
handle_fight_section(param_00)
{
	if(isdefined(param_00))
	{
		maps\_utility::autosave_by_name();
	}
	else if(!isdefined(level.start_point) || level.start_point != "street")
	{
		maps\_utility::autosave_now();
	}

	soundscripts\_snd::snd_message("bridge_street_fight");
	setsaveddvar("fx_draw_omnilight",0);
	common_scripts\utility::flag_set("flag_obj_van_meetup");
	common_scripts\utility::flag_set("flag_dialog_start_street");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	common_scripts\utility::run_thread_on_targetname("trigger_fall_fail",::maps\sanfran_util::fall_fail);
	common_scripts\utility::run_thread_on_targetname("trigger_fall_fail_remove",::maps\sanfran_util::fall_fail);
	level thread maps\sanfran_util::fail_player_for_abandon();
	level thread maps\sanfran_util::player_abandon_squad_distance_think();
	common_scripts\utility::run_thread_on_targetname("trigger_no_long_death",::no_long_death);
	thread railing_dangerzone_think();
	level thread maps\sanfran_util::toggle_boat_visibility();
	maps\_player_exo::player_exo_activate();
	level thread maps\sanfran_util::give_boost_jump();
	if(!isdefined(param_00))
	{
		common_scripts\utility::flag_set("flag_dialog_street_foot");
		level thread fight_section_crash_encounter();
		level thread fight_section_boost_encounter();
		level thread fight_section_police_encounter();
		level thread fight_section_tanker_encouter();
		level thread fight_section_ambient_encounter();
		level thread fight_section_pitbull_encounter();
		level thread fight_section_escape_encounter();
		level thread fight_section_standoff_encounter();
		return;
	}

	if(param_00 == "police")
	{
		common_scripts\utility::flag_set("flag_fight_start_boost_encounter");
		common_scripts\utility::flag_set("flag_fight_start_police_encounter");
		maps\sanfran_util::connectpaths_ents_by_targetname("boost_path_blocker");
		maps\sanfran_util::delete_ents_by_targetname("boost_path_blocker");
		maps\_utility::activate_trigger_with_targetname("trigger_move_first_boost");
		level thread fight_section_police_encounter();
		level thread fight_section_tanker_encouter();
		level thread fight_section_ambient_encounter();
		level thread fight_section_pitbull_encounter();
		level thread fight_section_escape_encounter();
		level thread fight_section_standoff_encounter();
		return;
	}

	if(param_00 == "pitbull")
	{
		level thread fight_section_ambient_encounter();
		level thread fight_section_pitbull_encounter();
		level thread fight_section_escape_encounter();
		level thread fight_section_standoff_encounter();
		return;
	}
}

//Function Number: 83
play_van_videolog_pip()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("flag_play_van_videolog_pip");
	maps\_shg_utility::play_videolog("sanfran_videolog","screen_add");
}

//Function Number: 84
no_long_death()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isalive(var_00) && var_00.team == "axis" && var_00.a.disablelongdeath != 1)
		{
			var_00 maps\_utility::disable_long_death();
		}
	}
}

//Function Number: 85
fight_section_crash_encounter()
{
	common_scripts\utility::run_thread_on_targetname("trigger_start_crash_suvs",::start_crash_suvs);
	level thread maps\sanfran_util::start_civilian_group("crash_civilian_spawner");
	maps\sanfran_util::civilian_get_out_of_car_setup("crash_scene_escape_car_1","crash_scene_escape_spawner_1","flag_crash_scene_get_out",1);
	maps\sanfran_util::civilian_get_out_of_car_setup("crash_scene_escape_car_2","crash_scene_escape_spawner_2","flag_crash_scene_get_out",1);
	maps\sanfran_util::civilian_get_out_of_car_setup("crash_scene_escape_car_3","crash_scene_escape_spawner_3","flag_crash_scene_get_out",1);
	maps\sanfran_util::civilian_get_out_of_car_setup("crash_scene_escape_car_4","crash_scene_escape_spawner_4","flag_crash_scene_get_out",1);
	maps\sanfran_util::civilian_get_out_of_car_setup("crash_scene_escape_car_5","crash_scene_escape_spawner_5","flag_crash_scene_get_out",1,4);
	maps\sanfran_util::civilian_loop_setup("crash_civ_seat",undefined,"flag_player_at_tanker_battle");
	common_scripts\utility::flag_wait("flag_player_crash_complete");
	maps\_utility::activate_trigger_with_targetname("trigger_move_from_crash");
	maps\_utility::waittill_aigroupcount("atlas_suv_guys",2);
	common_scripts\utility::flag_set("flag_crash_retreat_01");
	wait(4);
	common_scripts\utility::flag_set("flag_fight_start_boost_encounter");
}

//Function Number: 86
start_crash_suvs()
{
	self waittill("trigger");
	maps\sanfran_util::squad_ignore_all_start();
	common_scripts\utility::run_thread_on_targetname("trigger_crash_squad_cover",::crash_squad_take_cover);
}

//Function Number: 87
clean_up_suv_drivers()
{
	var_00 = getentarray("atlas_ai_suv_drivers","script_noteworthy");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(isai(var_03))
		{
			var_01[var_01.size] = var_03;
		}
	}

	common_scripts\utility::array_thread(var_01,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_tanker_battle);
}

//Function Number: 88
crash_squad_take_cover()
{
	self waittill("trigger");
	maps\sanfran_util::connectpaths_ents_by_targetname("crash_path_blocker");
	maps\sanfran_util::delete_ents_by_targetname("crash_path_blocker");
	maps\sanfran_util::squad_ignore_all_stop();
	soundscripts\_snd::snd_message("bridge_post_crash");
}

//Function Number: 89
drive_crash_suv()
{
	self vehphys_disablecrashing();
	maps\_vehicle::vehicle_set_health(3000);
	self waittill("reached_end_node");
	self disconnectpaths();
}

//Function Number: 90
fight_section_boost_encounter()
{
	common_scripts\utility::flag_wait("flag_fight_start_boost_encounter");
	thread maps\sanfran_util::street_civilian_clean_up();
	maps\sanfran_util::connectpaths_ents_by_targetname("boost_path_blocker");
	maps\sanfran_util::delete_ents_by_targetname("boost_path_blocker");
	var_00 = getentarray("spawner_atlas_boost","targetname");
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_start_ignore_all,::maps\sanfran_util::ai_end_ignore_all,::maps\sanfran_util::ai_cond_reached_goal);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_start_ignore_me,::maps\sanfran_util::ai_end_ignore_me,::maps\sanfran_util::ai_cond_reached_goal);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_tanker_battle);
	common_scripts\utility::array_thread(var_00,::maps\_utility::spawn_ai,1,0);
	common_scripts\utility::flag_set("flag_dialog_street_boost_incoming");
	maps\_utility::activate_trigger_with_targetname("trigger_move_to_first_jump");
	maps\_utility::waittill_aigroupcount("atlas_first_jump",1);
	common_scripts\utility::flag_set("flag_boost_retreat_01");
	wait(4);
	common_scripts\utility::flag_set("flag_dialog_street_boosters");
	maps\_utility::activate_trigger_with_targetname("trigger_move_first_boost");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("flag_fight_start_police_encounter");
}

//Function Number: 91
wait_to_give_boost_to_player()
{
	common_scripts\utility::flag_wait("flag_enable_boost_jump");
	maps\_utility::display_hint("boost_hint");
	level thread maps\sanfran_util::give_boost_jump();
}

//Function Number: 92
fight_section_police_encounter()
{
	level thread set_up_police_battle();
	maps\sanfran_util::civilian_loop_setup("police_civ_seat",undefined,"flag_player_at_ambient_battle");
	maps\sanfran_util::civilian_loop_setup("police_civ_seat_2",undefined,"flag_player_at_ambient_battle");
	maps\sanfran_util::civilian_loop_setup("police_civ_paired_a","police_civ_paired_b","flag_player_at_ambient_battle");
	maps\sanfran_util::civilian_loop_setup("police_civ_paired_2_a","police_civ_paired_2_b","flag_player_at_ambient_battle");
	common_scripts\utility::flag_wait("flag_player_at_police_battle");
	level thread start_street_heli();
	maps\sanfran_util::waittill_aigroupcount_or_flag("atlas_police_fight",11,"flag_force_police_battle_atlas_second_group");
	common_scripts\utility::flag_set("flag_police_retreat_01");
	var_00 = getentarray("police_battle_atlas_second_group","targetname");
	common_scripts\utility::array_thread(var_00,::maps\_utility::add_spawn_function,::maps\_utility::add_damage_function,::maps\sanfran_util::ai_twenty_percent_damage_func);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_ambient_battle);
	common_scripts\utility::array_thread(var_00,::maps\_utility::spawn_ai,1,0);
	wait(3);
	maps\_utility::activate_trigger_with_targetname("trigger_police_persue_01");
	common_scripts\utility::flag_set("flag_dialog_street_sitrep");
	maps\sanfran_util::waittill_aigroupcount_or_flag("atlas_police_fight",6,"flag_force_police_battle_atlas_third_group");
	common_scripts\utility::flag_set("flag_police_retreat_02");
	var_01 = getentarray("police_battle_atlas_third_group","targetname");
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::maps\_utility::add_damage_function,::maps\sanfran_util::ai_twenty_percent_damage_func);
	common_scripts\utility::array_thread(var_01,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_ambient_battle);
	common_scripts\utility::array_thread(var_01,::maps\_utility::spawn_ai,1,0);
	wait(3);
	maps\_utility::activate_trigger_with_targetname("trigger_police_persue_02");
	maps\sanfran_util::waittill_aigroupcount_or_flag("atlas_police_fight",2,"flag_force_police_battle_final_fallback");
	maps\_utility::activate_trigger_with_targetname("trigger_police_fight_fallback");
	maps\_utility::autosave_by_name();
	wait(1);
	common_scripts\utility::flag_set("flag_fight_start_tanker_encounter");
}

//Function Number: 93
set_up_police_battle()
{
	setthreatbias("police","atlas",10000);
	setthreatbias("atlas","police",10000);
	setthreatbias("sentinel","atlas",-10000);
	setthreatbias("atlas","sentinel",-10000);
	setthreatbias("police","atlas_attack",-10000);
	setthreatbias("atlas_attack","police",-10000);
	setthreatbias("sentinel","atlas_attack",10000);
	setthreatbias("atlas_attack","sentinel",10000);
	var_00 = getentarray("tanker_battle_police","targetname");
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_start_magic_bullet_shield,::maps\sanfran_util::ai_end_magic_bullet_shield,::maps\sanfran_util::ai_cond_player_at_police_battle);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_ambient_battle);
	common_scripts\utility::array_thread(var_00,::maps\_utility::spawn_ai,1,0);
	var_01 = getentarray("police_battle_atlas_first_group","targetname");
	common_scripts\utility::array_thread(var_01,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_end_fixed_node,::maps\sanfran_util::ai_cond_player_at_police_battle);
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::maps\sanfran_util::ai_shot_by_player_team_notify);
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::maps\_utility::add_damage_function,::maps\sanfran_util::ai_twenty_percent_damage_func);
	common_scripts\utility::array_thread(var_01,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_ambient_battle);
	common_scripts\utility::array_thread(var_01,::maps\_utility::spawn_ai,1,0);
	var_02 = getent("trigger_tanker_fire_damage","targetname");
	var_02 common_scripts\utility::trigger_off_proc();
	level waittill("ai_shot_by_player_team");
	setthreatbias("police","atlas",0);
	setthreatbias("atlas","police",0);
	setthreatbias("sentinel","atlas",100);
	setthreatbias("atlas","sentinel",100);
	setthreatbias("police","atlas_attack",0);
	setthreatbias("atlas_attack","police",0);
	setthreatbias("sentinel","atlas_attack",100);
	setthreatbias("atlas_attack","sentinel",100);
}

//Function Number: 94
start_street_heli()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("street_fight_heli");
	var_00 maps\_utility::ent_flag_init("heli_can_shoot");
	var_00 maps\_vehicle::godon();
	var_00 maps\sanfran_util::riders_no_damage();
	var_00 thread maps\sanfran_util::heli_shoot_enemies();
	var_00 thread maps\sanfran_util::heli_toggle_shoot();
	common_scripts\utility::flag_set("flag_dialog_street_helo_intro");
	common_scripts\utility::flag_wait("flag_police_retreat_02");
	var_01 = common_scripts\utility::getstruct("start_bridge_heli_swap_sides","targetname");
	var_00 thread maps\_vehicle_code::_vehicle_paths(var_01);
	var_00 maps\_utility::ent_flag_clear("heli_can_shoot");
	common_scripts\utility::flag_set("flag_dialog_street_helo_change");
	common_scripts\utility::flag_wait("flag_player_at_tanker_battle");
	var_01 = common_scripts\utility::getstruct("start_bridge_heli_move_tanker","targetname");
	var_00 thread maps\_vehicle_code::_vehicle_paths(var_01);
	common_scripts\utility::flag_wait("flag_tanker_exploded");
	common_scripts\utility::flag_set("flag_dialog_street_helo_die");
	var_00 soundscripts\_snd::snd_message("aud_little_bird_hit");
	var_00 maps\_vehicle::godoff();
	var_00 dodamage(var_00.health + 10000,var_00.origin);
}

//Function Number: 95
fight_section_tanker_encouter()
{
	common_scripts\utility::flag_wait("flag_fight_start_tanker_encounter");
	level thread start_tanker_fire();
	var_00 = getentarray("tanker_battle_atlas_group","targetname");
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\_utility::add_damage_function,::maps\sanfran_util::ai_twenty_percent_damage_func);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_start_balcony_death,::maps\sanfran_util::ai_cond_player_at_tanker_battle);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_pitbull_battle);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::player_damage_atlas_flag_set,"flag_player_at_tanker_battle");
	common_scripts\utility::array_thread(var_00,::maps\_utility::spawn_ai,1,0);
	wait(2);
	maps\_utility::activate_trigger_with_targetname("trigger_tanker_move_up");
	common_scripts\utility::flag_wait("flag_player_at_tanker_battle");
	setthreatbias("police","atlas",1000);
	setthreatbias("atlas","police",1000);
	setthreatbias("sentinel","atlas",-100);
	setthreatbias("atlas","sentinel",-100);
	setthreatbias("police","atlas_attack",-1000);
	setthreatbias("atlas_attack","police",-1000);
	setthreatbias("sentinel","atlas_attack",1000);
	setthreatbias("atlas_attack","sentinel",1000);
	tanker_drone_flood();
	maps\sanfran_util::waittill_aigroupcount_or_flag("atlas_tanker_fight",6,"flag_force_tanker_battle_atlas_second_group");
	var_00 = getentarray("tanker_battle_atlas_second_group","targetname");
	common_scripts\utility::array_thread(var_00,::maps\_utility::add_spawn_function,::maps\_utility::add_damage_function,::maps\sanfran_util::ai_twenty_percent_damage_func);
	common_scripts\utility::array_thread(var_00,::maps\_utility::add_spawn_function,::maps\sanfran_util::balcony_death_anims);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_pitbull_battle);
	common_scripts\utility::array_thread(var_00,::maps\_utility::spawn_ai,1,0);
	common_scripts\utility::flag_set("flag_dialog_street_helo_warn");
	maps\sanfran_util::waittill_aigroupcount_or_flag("atlas_tanker_fight",4,"flag_force_tanker_ignite_second");
	level thread maps\sanfran_fx::ignite_tanker_spurt();
	common_scripts\utility::flag_set("flag_tanker_retreat_01");
	wait(3);
	level thread explode_tanker();
	common_scripts\utility::flag_wait("flag_tanker_exploded");
	maps\sanfran_util::connectpaths_ents_by_targetname("tanker_fire_path_blocker");
	maps\sanfran_util::delete_ents_by_targetname("tanker_fire_path_blocker");
	var_01 = getaiarray("axis");
	var_02 = getent("trigger_tanker_explosion_ragdoll","targetname");
	var_03 = getent("tanker_explosion_org","targetname");
	foreach(var_05 in var_01)
	{
		if(var_05 istouching(var_02))
		{
			var_06 = vectornormalize(var_05.origin - var_03.origin);
			var_07 = distance(var_05.origin,var_03.origin);
			var_08 = 800 - var_07 / 800;
			var_09 = var_06 * var_08 * 400;
			var_05 kill();
			var_05 startragdollfromimpact(var_05.origin,var_09);
		}
	}

	common_scripts\utility::flag_set("flag_fight_start_ambient_encounter");
	maps\_utility::waittill_aigroupcleared("atlas_tanker_fight");
	maps\_utility::autosave_by_name();
	wait(2);
	maps\_utility::activate_trigger_with_targetname("trigger_tanker_move_past_fire");
}

//Function Number: 96
tanker_drone_flood()
{
	var_00 = getentarray("atlas_tanker_drone","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread drone_respawn();
	}
}

//Function Number: 97
drone_respawn()
{
	level endon("flag_tanker_exploded");
	for(;;)
	{
		var_00 = maps\_vehicle::spawn_vehicle_and_gopath();
		var_00 thread maps\_shg_utility::make_emp_vulnerable();
		var_00 maps\_utility::add_damage_function(::maps\sanfran_util::ai_twenty_percent_damage_func);
		var_00 laseron();
		var_00 thread explode_drones_at_tanker();
		var_00 waittill("death");
		wait(randomfloatrange(3,5));
	}
}

//Function Number: 98
explode_drones_at_tanker()
{
	self endon("death");
	level waittill("flag_tanker_exploded");
	var_00 = randomfloatrange(0.1,0.8);
	wait(var_00);
	self kill();
}

//Function Number: 99
start_tanker_fire()
{
	thread maps\sanfran_fx::oil_tanker_bridge_fire();
	soundscripts\_snd::snd_message("tanker_fireball");
	var_00 = getent("trigger_tanker_fire_damage","targetname");
	var_00 common_scripts\utility::trigger_on_proc();
	common_scripts\utility::flag_wait("flag_tanker_exploded");
	var_00 delete();
}

//Function Number: 100
explode_tanker()
{
	var_00 = [];
	var_01 = 1;
	for(;;)
	{
		var_02 = getentarray("tanker_explosion_car_" + var_01,"script_noteworthy");
		if(var_02.size == 0)
		{
			break;
		}

		var_00[var_00.size] = var_02;
		var_01++;
	}

	var_00 = common_scripts\utility::array_randomize(var_00);
	foreach(var_02 in var_00)
	{
		for(var_01 = 0;var_01 < var_02.size;var_01++)
		{
			if(var_02[var_01].classname != "script_model")
			{
				continue;
			}

			var_02[var_01] useanimtree(#animtree);
			var_04 = var_02[var_01].model;
			if(issubstr(var_04,"vehicle_civ_domestic_economy"))
			{
				var_02[var_01] setmodel("vehicle_civ_domestic_economy_destroy_static");
				var_02[var_01] setanimknob(%civ_domestic_sedan_police_destroy,1,0,1);
			}
			else if(issubstr(var_04,"vehicle_civ_smartcar_02_blue"))
			{
				var_02[var_01].newmodel = spawn("script_model",var_02[var_01].origin);
				var_02[var_01].newmodel.angles = var_02[var_01].angles;
				var_02[var_01].newmodel setmodel("vehicle_civ_smartcar_static_dstry");
				var_02[var_01].newmodel linkto(var_02[var_01],"body_animate_jnt");
				var_02[var_01] hide();
				var_02[var_01] setanimknob(%civ_domestic_sedan_police_destroy,1,0,1);
			}

			playfx(level._effect["tanker_explosion"],var_02[var_01].origin);
			var_02[var_01] soundscripts\_snd::snd_message("bridge_car_explode");
			earthquake(0.4,0.5,var_02[var_01].origin,2000);
			radiusdamage(var_02[var_01].origin,400,50,10);
			break;
		}

		wait(randomfloatrange(0.5,2));
	}

	wait(randomfloatrange(1,2));
	common_scripts\utility::flag_set("kill_oil_puddle_flames");
	wait(1);
	level thread maps\sanfran_fx::oil_tanker_bridge_explosion();
	var_06 = getent("tanker_explosion_org","targetname");
	var_07 = getentarray("tanker_explosion_tanker","script_noteworthy");
	foreach(var_09 in var_07)
	{
		if(var_09.classname == "script_model")
		{
			var_09 setmodel("ind_semi_truck_fuel_tank_destroy");
		}
	}

	var_0B = getentarray("tanker_explosion_cab","script_noteworthy");
	foreach(var_09 in var_0B)
	{
		if(var_09.classname == "script_model")
		{
			var_09 setmodel("ind_semi_truck_03_destroy");
		}
	}

	earthquake(0.6,0.5,var_06.origin,2000);
	radiusdamage(var_06.origin,400,50,10);
	common_scripts\utility::flag_set("flag_tanker_exploded");
	foreach(var_02 in var_00)
	{
		var_0F = vectornormalize(var_02[0].origin - var_06.origin);
		var_10 = distance(var_02[0].origin,var_06.origin);
		var_11 = 800 - var_10 / 800;
		var_12 = var_0F * var_11 * 300;
		var_13 = (var_12[0],var_12[1],0);
		var_14 = randomfloatrange(50,70);
		if(randomint(100) > 50)
		{
			var_14 = var_14 * -1;
		}

		foreach(var_16 in var_02)
		{
			var_16 thread shift_car(var_13,var_14);
		}
	}

	maps\_utility::delaythread(5,::maps\_utility::pauseexploder,2200);
}

//Function Number: 101
shift_car(param_00,param_01)
{
	if(self.classname != "script_model")
	{
		self connectpaths();
	}
	else
	{
		self clearanim(%civ_domestic_sedan_police_destroy,0);
	}

	self moveto(self.origin + param_00,0.2,0,0.1);
	self rotateto(self.angles + (0,param_01,0),0.2,0,0.1);
	wait(0.2);
	if(self.classname != "script_model")
	{
		self disconnectpaths();
		return;
	}

	common_scripts\utility::delaycall(randomfloat(0.15),::setanimknob,%civ_domestic_sedan_police_destroy,1,0,1);
}

//Function Number: 102
fight_section_ambient_encounter()
{
	common_scripts\utility::flag_wait("flag_fight_start_ambient_encounter");
	common_scripts\utility::run_thread_on_targetname("start_bridge_helis",::start_bridge_helis);
	level thread set_up_ambient_battle();
	maps\sanfran_util::civilian_loop_setup("ambient_civ_seat_1",undefined,"flag_player_at_escape_battle");
	maps\sanfran_util::civilian_loop_setup("ambient_civ_seat_2",undefined,"flag_player_at_escape_battle");
	maps\sanfran_util::civilian_loop_setup("ambient_civ_paired_1","ambient_civ_paired_2","flag_player_at_escape_battle");
	common_scripts\utility::flag_wait("flag_player_at_ambient_battle");
	level thread maps\sanfran_util::start_civilian_group("spawner_ambient_spawner_wave01");
	maps\_utility::autosave_by_name();
	maps\_utility::activate_trigger_with_targetname("trigger_move_to_ambient_battle");
	common_scripts\utility::flag_set("flag_start_jerk_driver");
	wait(5);
	common_scripts\utility::flag_set("flag_fight_start_pitbull_encounter");
	maps\_utility::autosave_by_name();
	wait(4);
	maps\_utility::activate_trigger_with_targetname("trigger_move_to_pitbull_encounter");
	common_scripts\utility::run_thread_on_targetname("trigger_start_ambient_kick_pair",::start_ambient_pair_kick);
}

//Function Number: 103
start_ambient_pair_kick()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(var_00 == level.burke)
		{
			break;
		}
	}

	var_01 = getent("spawner_atlas_ambient_kick_pair","targetname");
	var_02 = var_01 maps\_utility::spawn_ai(1,0);
	soundscripts\_snd::snd_message("start_burke_boost_kick");
	maps\sanfran_util::lunging_take_down("takedown_ambient",level.burke,var_02);
	var_03 = getnode("node_burke_lunge_cover","targetname");
	level.burke thread maps\_spawner::go_to_node(var_03);
	level.burke maps\_utility::enable_ai_color_dontmove();
}

//Function Number: 104
start_bridge_helis()
{
	self waittill("trigger");
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("bridge_helis");
	soundscripts\_snd::snd_message("start_bridge_helis",var_00);
	common_scripts\utility::flag_set("flag_dialog_street_van_stop");
}

//Function Number: 105
set_up_ambient_battle()
{
	var_00 = getentarray("spawner_police_ambient","targetname");
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_start_magic_bullet_shield,::maps\sanfran_util::ai_end_magic_bullet_shield,::maps\sanfran_util::ai_cond_player_at_ambient_battle);
	var_01 = getent("spawner_police_ambient_animated","targetname");
	var_01 maps\_utility::add_spawn_function(::ambient_battle_deployable_cover);
	var_00 = common_scripts\utility::array_add(var_00,var_01);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_escape_battle);
	common_scripts\utility::array_thread(var_00,::maps\_utility::spawn_ai,1,0);
	var_02 = getentarray("spawner_atlas_ambient","targetname");
	common_scripts\utility::array_thread(var_02,::maps\_utility::add_spawn_function,::maps\sanfran_util::ai_shot_by_player_team_notify);
	common_scripts\utility::array_thread(var_02,::maps\sanfran_util::add_spawn_behavior,::maps\_utility::add_damage_function,::maps\sanfran_util::ai_twenty_percent_damage_func);
	common_scripts\utility::array_thread(var_02,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_start_respawn_death,::maps\sanfran_util::ai_stop_death_function,::maps\sanfran_util::ai_cond_player_at_ambient_battle);
	common_scripts\utility::array_thread(var_02,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_escape_battle);
	level waittill("ai_shot_by_player_team");
	setthreatbias("police","atlas",0);
	setthreatbias("atlas","police",0);
	setthreatbias("sentinel","atlas",100);
	setthreatbias("atlas","sentinel",100);
	setthreatbias("police","atlas_attack",0);
	setthreatbias("atlas_attack","police",0);
	setthreatbias("sentinel","atlas_attack",100);
	setthreatbias("atlas_attack","sentinel",100);
}

//Function Number: 106
ambient_battle_deployable_cover()
{
	var_00 = getent("deployable_cover_final_model","targetname");
	var_00.contents = var_00 setcontents(0);
	var_00 hide();
	maps\_utility::magic_bullet_shield();
	thread deployable_cover_think();
	common_scripts\utility::flag_wait("flag_place_deployable_cover");
	self.animname = "generic";
	var_01 = common_scripts\utility::getstruct("deployable_cover_animnode","targetname");
	var_02 = "deployable_cover_deploy";
	var_01 maps\_anim::anim_reach_solo(self,var_02);
	level notify("police_placing_deployable_cover");
	var_03 = maps\_utility::spawn_anim_model("deployable_cover",(0,0,0));
	var_04 = [self,var_03];
	var_01 thread maps\_anim::anim_single(var_04,"deployable_cover_deploy");
	var_05 = 5.4;
	var_00 common_scripts\utility::delaycall(var_05,::setcontents,var_00.contents);
	var_00 common_scripts\utility::delaycall(var_05,::show);
	var_03 common_scripts\utility::delaycall(var_05,::delete);
}

//Function Number: 107
deployable_cover_think()
{
	var_00 = spawn("script_model",self gettagorigin("j_SpineUpper") + (0,0,0));
	var_00.angles = self gettagangles("j_SpineUpper") + (0,0,0);
	var_00.animname = "deployable_cover";
	var_00 setmodel("deployable_cover");
	var_00 maps\_anim::setanimtree();
	var_00 maps\_anim::anim_first_frame_solo(var_00,"deployable_cover_closed_idle");
	var_00 linkto(self,"j_SpineUpper");
	level waittill("police_placing_deployable_cover");
	var_00 delete();
}

//Function Number: 108
start_jerk_driver()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("jerk_driver_car");
	var_00 maps\_vehicle::godon();
	var_00 soundscripts\_snd::snd_message("start_jerk_driver_car");
	common_scripts\utility::flag_wait("flag_start_jerk_driver");
	var_00 startpath();
	var_00 waittill("reached_end_node");
	var_01 = getvehiclenode("start_jerk_back_up","targetname");
	var_00 thread maps\_vehicle_code::_vehicle_paths(var_01);
	var_00 startpath(var_01);
	var_00 waittill("reached_end_node");
	var_01 = getvehiclenode("start_jerk_go_forward","targetname");
	var_00 thread maps\_vehicle_code::_vehicle_paths(var_01);
	var_00 startpath(var_01);
	var_00 waittill("reached_end_node");
	for(;;)
	{
		if(!maps\sanfran_util::player_can_see(var_00.origin,45))
		{
			var_00 maps\_vehicle::godoff();
			var_00 delete();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 109
fight_section_pitbull_encounter()
{
	common_scripts\utility::flag_wait("flag_fight_start_pitbull_encounter");
	level thread start_pitbull_skirmish();
	maps\sanfran_util::civilian_loop_setup("pitbull_civ_seat",undefined,"flag_player_at_standoff_battle");
	common_scripts\utility::flag_wait("flag_player_at_pitbull_battle");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("flag_dialog_street_pitbull");
	maps\sanfran_util::waittill_aigroupcount_or_flag("atlas_pitbull",9,"flag_force_atlas_pitbull_second");
	var_00 = getentarray("spawner_atlas_pitbull_second","targetname");
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_start_ignore_all,::maps\sanfran_util::ai_end_ignore_all,::maps\sanfran_util::ai_cond_reached_goal);
	common_scripts\utility::array_thread(var_00,::maps\_utility::add_spawn_function,::maps\_utility::add_damage_function,::maps\sanfran_util::ai_twenty_percent_damage_func);
	common_scripts\utility::array_thread(var_00,::maps\_utility::add_spawn_function,::maps\sanfran_util::balcony_death_anims);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_standoff_battle);
	common_scripts\utility::array_thread(var_00,::maps\_utility::spawn_ai,1);
	common_scripts\utility::flag_set("flag_dialog_street_cover");
	maps\_utility::waittill_aigroupcleared("atlas_pitbull");
	common_scripts\utility::flag_set("flag_fight_start_escape_encounter");
	maps\_utility::autosave_by_name();
	wait(2);
	maps\_utility::activate_trigger_with_targetname("trigger_move_past_pitbull");
}

//Function Number: 110
start_pitbull_skirmish()
{
	var_00 = getentarray("spawner_atlas_pitbull","targetname");
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\_utility::add_damage_function,::maps\sanfran_util::ai_twenty_percent_damage_func);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_start_respawn_death,::maps\sanfran_util::ai_start_balcony_death,::maps\sanfran_util::ai_cond_player_at_pitbull_battle);
	common_scripts\utility::array_thread(var_00,::maps\_utility::add_spawn_function,::maps\sanfran_util::container_death_anims);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_standoff_battle);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::player_damage_atlas_flag_set,"flag_player_at_pitbull_battle");
	common_scripts\utility::array_thread(var_00,::maps\_utility::spawn_ai,1,0);
	var_01 = getentarray("spawner_sentinel_pitbull","targetname");
	common_scripts\utility::array_thread(var_01,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_start_magic_bullet_shield,::maps\sanfran_util::ai_end_magic_bullet_shield,::maps\sanfran_util::ai_cond_player_at_pitbull_battle);
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::maps\_utility::add_damage_function,::maps\sanfran_util::ai_twenty_percent_damage_func);
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::bravo_leader);
	common_scripts\utility::array_thread(var_01,::maps\_utility::spawn_ai,1,0);
}

//Function Number: 111
bravo_leader()
{
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "bravo_leader")
	{
		self.animname = "Bravo";
		level.bravo = self;
	}
}

//Function Number: 112
fight_section_escape_encounter()
{
	common_scripts\utility::flag_wait("flag_fight_start_escape_encounter");
	if(level.currentgen)
	{
		if(!istransientloaded("sanfran_bigm_tr"))
		{
			level waittill("tff_transition_outro_to_bigm");
		}
	}

	common_scripts\utility::run_thread_on_targetname("setup_explosion_scene",::setup_bridge_explosion_trigger);
	maps\sanfran_util::civilian_loop_setup("escape_civ_seat",undefined,"flag_van_explosion_deploy");
	maps\sanfran_util::civilian_loop_setup("escape_civ_lay",undefined,"flag_van_explosion_deploy");
	common_scripts\utility::flag_wait("flag_player_at_escape_battle");
	setthreatbias("police","atlas",0);
	setthreatbias("atlas","police",0);
	setthreatbias("sentinel","atlas",100);
	setthreatbias("atlas","sentinel",100);
	setthreatbias("police","atlas_attack",-1000);
	setthreatbias("atlas_attack","police",-1000);
	setthreatbias("sentinel","atlas_attack",1000);
	setthreatbias("atlas_attack","sentinel",1000);
	level thread escape_fight_wave("spawner_atlas_escape");
	wait(4);
	level thread escape_fight_wave("spawner_atlas_escape_second");
	wait(6);
	level thread escape_fight_wave("spawner_atlas_escape_third");
	maps\sanfran_util::waittill_aigroupcount_or_flag("atlas_escape",4,"flag_atlas_escape_fight_skip");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("flag_dialog_street_hurry");
	maps\_utility::activate_trigger_with_targetname("trigger_move_to_standoff");
	common_scripts\utility::flag_set("flag_fight_start_standoff_encounter");
}

//Function Number: 113
escape_fight_wave(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::maps\_utility::add_damage_function,::maps\sanfran_util::ai_twenty_percent_damage_func);
	common_scripts\utility::array_thread(var_01,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_van);
	common_scripts\utility::array_thread(var_01,::maps\_utility::spawn_ai,1,0);
}

//Function Number: 114
fight_section_standoff_encounter()
{
	common_scripts\utility::flag_wait("flag_fight_start_standoff_encounter");
	level thread change_music_to_standoff();
	level thread start_police_standoff();
	common_scripts\utility::run_thread_on_targetname("trigger_player_at_van",::handle_bridge_collapse);
	if(!level.nextgen)
	{
		maps\sanfran_util::civilian_loop_setup("standoff_civ_lay_1",undefined,"flag_van_explosion_deploy");
		maps\sanfran_util::civilian_loop_setup("standoff_civ_lay_2",undefined,"flag_van_explosion_deploy");
		maps\sanfran_util::civilian_loop_setup("standoff_civ_seat_1",undefined,"flag_van_explosion_deploy");
		maps\sanfran_util::civilian_loop_setup("standoff_civ_seat_2",undefined,"flag_van_explosion_deploy");
	}

	maps\sanfran_util::civilian_loop_setup("standoff_civ_seat_3",undefined,"flag_van_explosion_deploy");
	if(!level.nextgen)
	{
		maps\sanfran_util::civilian_loop_setup("standoff_civ_paired_1","standoff_civ_paired_2","flag_van_explosion_deploy");
		maps\sanfran_util::civilian_loop_setup("standoff_civ_paired_b_1","standoff_civ_paired_b_2","flag_van_explosion_deploy");
	}

	common_scripts\utility::flag_wait("flag_player_at_standoff_battle");
	thread at_van_enemy_cleanup();
	common_scripts\utility::flag_set("flag_dialog_street_friendlies");
	maps\_utility::waittill_aigroupcleared("atlas_standoff");
	maps\_utility::activate_trigger_with_targetname("trigger_move_past_standoff");
	level thread maps\sanfran_util::remove_boost_jump();
	if(level.currentgen)
	{
		maps\_utility::vision_set_fog_changes("sanfran_cops_end_cg",1);
	}

	common_scripts\utility::flag_set("flag_player_at_van_standoff");
}

//Function Number: 115
change_music_to_standoff()
{
	common_scripts\utility::flag_wait("flag_player_at_van_standoff");
	soundscripts\_snd::snd_music_message("approaching_standoff");
	common_scripts\utility::flag_set("flag_dialog_street_assist");
}

//Function Number: 116
start_police_standoff()
{
	var_00 = getentarray("spawner_police_standoff","targetname");
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_start_magic_bullet_shield,::maps\sanfran_util::ai_end_magic_bullet_shield,::maps\sanfran_util::ai_cond_player_at_standoff_battle_or_danger_zone);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_end_fixed_node,::maps\sanfran_util::ai_cond_player_at_standoff_battle_or_danger_zone);
	common_scripts\utility::array_thread(var_00,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_van);
	common_scripts\utility::array_thread(var_00,::maps\_utility::spawn_ai,1,0);
	var_01 = getentarray("spawner_atlas_standoff","targetname");
	common_scripts\utility::array_thread(var_01,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_start_magic_bullet_shield,::maps\sanfran_util::ai_end_magic_bullet_shield,::maps\sanfran_util::ai_cond_player_at_standoff_battle_or_danger_zone);
	common_scripts\utility::array_thread(var_01,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_end_fixed_node,::maps\sanfran_util::ai_cond_player_at_standoff_battle_or_danger_zone);
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::maps\sanfran_util::ai_shot_by_player_team_notify);
	common_scripts\utility::array_thread(var_01,::maps\_utility::add_spawn_function,::maps\_utility::add_damage_function,::maps\sanfran_util::ai_twenty_percent_damage_func);
	common_scripts\utility::array_thread(var_01,::maps\sanfran_util::add_spawn_behavior,::maps\sanfran_util::ai_run_behavior_until_condition,::maps\sanfran_util::ai_empty,::maps\sanfran_util::ai_delete_self,::maps\sanfran_util::ai_cond_player_at_van);
	common_scripts\utility::array_thread(var_01,::maps\_utility::spawn_ai,1,0);
	level waittill("ai_shot_by_player_team");
	setthreatbias("police","atlas",0);
	setthreatbias("atlas","police",0);
	setthreatbias("sentinel","atlas",100);
	setthreatbias("atlas","sentinel",100);
	setthreatbias("police","atlas_attack",0);
	setthreatbias("atlas_attack","police",0);
	setthreatbias("sentinel","atlas_attack",100);
	setthreatbias("atlas_attack","sentinel",100);
}

//Function Number: 117
setup_bridge_explosion_trigger()
{
	self waittill("trigger");
	setup_bridge_explosion_anim_sequence();
}

//Function Number: 118
setup_helicopter_blades_damage()
{
	level endon("van_door_interact");
	var_00 = getent("helicopter_blades_damage","targetname");
	var_01 = undefined;
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		var_01 dodamage(60,var_00.origin);
		wait(0.05);
	}
}

//Function Number: 119
handle_bridge_collapse()
{
	common_scripts\utility::run_thread_on_targetname("trigger_player_approaching_van",::handle_early_approach);
	self waittill("trigger");
	level notify("kill_bridge_copcar_lights");
	setsaveddvar("fx_draw_omnilight",1);
	level notify("stop_toggle_boat_visibility");
	common_scripts\utility::flag_set("flag_obj_player_at_van");
	common_scripts\utility::flag_set("flag_dialog_start_van");
	common_scripts\utility::flag_set("flag_dialog_van_arrest");
	soundscripts\_snd::snd_music_message("pre_bridge_collapse_scene");
	common_scripts\utility::flag_clear("flag_enable_battle_chatter");
	level.explosion_scene_org notify("stop_barrier_loop");
	foreach(var_01 in level.barrier_scene_ents)
	{
		var_01 maps\_utility::anim_stopanimscripted();
	}

	level.explosion_scene_org maps\_anim::anim_single(level.approach_scene_ents,"approach_scene");
	common_scripts\utility::flag_set("flag_approach_scene_begin");
	common_scripts\utility::flag_set("flag_obj_player_use_van");
	common_scripts\utility::flag_set("flag_dialog_van_check");
	foreach(var_04 in level.approach_idle_ents)
	{
		level.explosion_scene_org thread maps\_anim::anim_loop_solo(var_04,"approach_idle","stop_approach_loop");
	}

	level.explosion_van show_glowy_handles();
	var_06 = getent("trigger_player_used_van","targetname");
	var_06 usetriggerrequirelookat();
	var_06 sethintstring(&"SANFRAN_OPEN_VAN");
	var_07 = var_06 maps\_shg_utility::hint_button_trigger("activate",1024);
	var_06 waittill("trigger");
	var_07 maps\_shg_utility::hint_button_clear();
	var_06 delete();
	soundscripts\_snd::snd_message("gg_start_bridge_collapse");
	level notify("van_door_interact");
	maps\_player_exo::player_exo_deactivate();
	thread bridge_collapse_rumble();
	common_scripts\utility::flag_set("portal_on_collapse");
	wait(0.05);
	common_scripts\utility::flag_clear("portal_on_collapse");
	thread maps\sanfran_lighting::van_open_bridge_collapse_dof();
	level.explosion_van show_normal_handles();
	foreach(var_09 in level.explosion_scene_bridge)
	{
		var_09 show();
	}

	maps\sanfran_util::hide_intact_bridge();
	maps\sanfran_util::toggle_on_real_mob();
	maps\sanfran_util::solid_ents_by_targetname("collapse_clip");
	maps\sanfran_util::delete_ents_by_targetname("collapse_fake_collision");
	maps\sanfran_util::delete_ents_by_targetname("trigger_fall_fail_remove");
	common_scripts\utility::flag_set("flag_dialog_van_deploy");
	common_scripts\utility::flag_set("flag_obj_player_used_van");
	level.explosion_scene_org notify("stop_approach_loop");
	foreach(var_01 in level.approach_idle_ents)
	{
		var_01 maps\_utility::anim_stopanimscripted();
	}

	var_0D = 0.5;
	level.player playerlinktoblend(level.player_rig,"tag_player",var_0D);
	level.player common_scripts\utility::delaycall(var_0D,::playerlinktodelta,level.player_rig,"tag_player",1,7,7,5,5,1);
	level.player enableslowaim();
	level.player take_car_door_shields();
	level.player maps\_shg_utility::setup_player_for_scene();
	maps\sanfran_util::setup_squad_for_scene();
	foreach(var_04 in level.deploy_scene_ents)
	{
		if(var_04 == level.player_rig)
		{
			var_04 common_scripts\utility::delaycall(var_0D,::show);
			continue;
		}

		var_04 show();
	}

	common_scripts\utility::flag_set("flag_van_explosion_deploy");
	thread play_deploy_scene_handcuff_ents();
	level.explosion_scene_org maps\_anim::anim_single(level.deploy_scene_ents,"deploy_scene");
	maps\sanfran_util::remove_intact_bridge();
	thread rock_mob();
	thread maps\sanfran_lighting::bridge_collapse_screen_effects();
	cleanup_explosion_ents();
	common_scripts\utility::flag_set("flag_dialog_van_collapse");
	foreach(var_04 in level.collapse_scene_ents)
	{
		var_04 show();
		var_04 thread animate_collapse_ent(level.explosion_scene_org);
	}

	common_scripts\utility::flag_set("flag_van_explosion_start");
	level.explosion_scene_org maps\_anim::anim_single(level.collapse_scene_ents_long,"collapse_scene");
	soundscripts\_snd::snd_music_message("starting_bridge_collapse");
	soundscripts\_snd::snd_message("bridge_collapsed");
	level.player unlink();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player disableslowaim();
	level.player_rig hide();
	maps\sanfran_util::setup_squad_for_gameplay();
	foreach(var_04 in level.collapse_scene_ents)
	{
		delete_collapse_ent(var_04);
	}

	level thread start_bridge_after_loop(level.explosion_scene_org);
	cleanup_road_flares();
	var_14 = getent("saint_boost_teleport","targetname");
	level.saint forceteleport(var_14.origin,var_14.angles);
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	level thread handle_boost_jump();
}

//Function Number: 120
handle_player_exo_punch()
{
	self waittill("trigger");
	level.player allowmelee(0);
	level.player maps\_utility::playerallowalternatemelee(0);
}

//Function Number: 121
play_deploy_scene_handcuff_ents()
{
	var_00 = level.deploy_scene_handcuff_ents;
	foreach(var_02 in var_00)
	{
		if(!isalive(var_02) || isdefined(self.delayeddeath) && self.delayeddeath)
		{
			continue;
		}

		if(isdefined(var_02.magic_bullet_shield) && var_02.magic_bullet_shield == 1)
		{
			continue;
		}

		var_02.allowdeath = 0;
		maps\sanfran_util::ai_start_magic_bullet_shield(var_02);
	}

	if(isdefined(var_00[0]) && isalive(var_00[0]))
	{
		level.explosion_scene_org thread maps\_anim::anim_single_solo(var_00[0],"deploy_scene");
		level.explosion_scene_org thread maps\_anim::anim_single_solo(var_00[3],"deploy_scene");
	}

	if(isdefined(var_00[1]) && isalive(var_00[1]))
	{
		level.explosion_scene_org thread maps\_anim::anim_single_solo(var_00[1],"deploy_scene");
		level.explosion_scene_org thread maps\_anim::anim_single_solo(var_00[2],"deploy_scene");
	}
}

//Function Number: 122
delete_atlas_van_driver(param_00)
{
	level waittill("van_door_interact");
	maps\sanfran_util::ai_end_magic_bullet_shield(param_00);
	param_00 maps\sanfran_util::kill_no_react();
}

//Function Number: 123
disable_threat_atlas_van_driver(param_00)
{
	common_scripts\utility::flag_wait("flag_approach_scene_begin");
	var_01 = getanimlength(param_00 maps\_utility::getanim("approach_scene"));
	wait(var_01);
	param_00 maps\_variable_grenade::clear_guy_fx();
	param_00 maps\_utility::pretend_to_be_dead();
}

//Function Number: 124
bridge_collapse_rumble()
{
	level endon("flag_obj_player_on_MOB");
	thread bridge_collapse_rumble_steady();
	thread bridge_collapse_rumble_timed();
	level.player common_scripts\utility::delaycall(11.75,::playrumbleonentity,"heavy_1s");
}

//Function Number: 125
bridge_collapse_rumble_steady()
{
	wait(12);
	var_00 = maps\_utility::get_rumble_ent("steady_rumble");
	var_00.intensity = 0.1;
	wait 0.05;
	var_00 maps\_utility::delaythread(0.5,::maps\_utility::rumble_ramp_to,0.3,1.5);
	var_00 maps\_utility::delaythread(8,::maps\_utility::rumble_ramp_to,0,1);
	var_00 maps\_utility::delaythread(13.5,::maps\_utility::rumble_ramp_to,0.3,0.5);
	var_00 maps\_utility::delaythread(16,::maps\_utility::rumble_ramp_to,0,0.1);
	var_00 maps\_utility::delaythread(26.5,::maps\_utility::rumble_ramp_to,0.3,0.9);
	var_00 maps\_utility::delaythread(29,::maps\_utility::rumble_ramp_to,2,0.1);
	var_00 maps\_utility::delaythread(29.5,::maps\_utility::rumble_ramp_to,0.3,0.1);
	var_00 maps\_utility::delaythread(33,::maps\_utility::rumble_ramp_to,0.7,3);
	var_00 maps\_utility::delaythread(37,::maps\_utility::rumble_ramp_to,0,1);
	var_00 common_scripts\utility::delaycall(42,::stoprumble,"steady_rumble");
	wait(44);
	var_00 delete();
}

//Function Number: 126
bridge_collapse_rumble_timed()
{
	level.player common_scripts\utility::delaycall(8,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(9,::playrumbleonentity,"riotshield_impact");
	level.player common_scripts\utility::delaycall(23,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(23.2,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(23.8,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(24.2,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(26,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(27.5,::playrumbleonentity,"heavy_2s");
	level.player common_scripts\utility::delaycall(30.5,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(40.5,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(50,::playrumbleonentity,"riotshield_impact");
	level.player common_scripts\utility::delaycall(51.5,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(67.8,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(70,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(70.4,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(72.65,::playrumbleonentity,"riotshield_impact");
	level.player common_scripts\utility::delaycall(78.4,::playrumbleonentity,"light_1s");
}

//Function Number: 127
debug_timer()
{
	var_00 = 0;
	for(;;)
	{
		iprintlnbold("Seconds: " + var_00);
		var_00 = var_00 + 1;
		wait(1);
	}
}

//Function Number: 128
take_car_door_shields()
{
	self notify("remove_car_doors");
}

//Function Number: 129
cleanup_road_flares()
{
	var_00 = getentarray("bridge_collapse_road_flare","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(var_02.classname == "script_model")
		{
			var_02 delete();
		}
	}
}

//Function Number: 130
handle_early_approach()
{
	self waittill("trigger");
	level.explosion_scene_org notify("stop_early_barrier_loop");
	level.early_approach_guy maps\_utility::anim_stopanimscripted();
	level.explosion_scene_org maps\_anim::anim_single_solo(level.early_approach_guy,"approach_scene");
	common_scripts\utility::flag_set("flag_approach_scene_begin");
	level.explosion_scene_org thread maps\_anim::anim_loop_solo(level.early_approach_guy,"approach_idle","stop_approach_loop");
}

//Function Number: 131
animate_collapse_ent(param_00)
{
	if(isai(self))
	{
		if(self.animname != "human_sentinel_2")
		{
			maps\_utility::gun_remove();
		}

		self.name = " ";
	}

	param_00 maps\_anim::anim_single_solo(self,"collapse_scene");
	delete_collapse_ent(self);
}

//Function Number: 132
show_normal_handles()
{
	self hidepart("rear_handle_obj_left_jnt");
	self hidepart("rear_handle_obj_right_jnt");
}

//Function Number: 133
show_glowy_handles()
{
	self showpart("rear_handle_obj_left_jnt");
	self showpart("rear_handle_obj_right_jnt");
}

//Function Number: 134
delete_collapse_ent(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(maps\_utility::is_in_array(level.heroes,param_00))
	{
		return;
	}

	if(maps\_utility::is_in_array(level.after_collpase_ents,param_00))
	{
		return;
	}

	if(isai(param_00))
	{
		param_00 maps\_utility::stop_magic_bullet_shield();
	}

	param_00 delete();
}

//Function Number: 135
swap_brigde_anim_to_real(param_00)
{
	foreach(var_02 in level.explosion_scene_bridge)
	{
		if(common_scripts\utility::array_contains(level.after_collpase_ents,var_02))
		{
			continue;
		}

		if(var_02.model == "ggb_collapse_03_chunkg")
		{
			continue;
		}

		var_02 hide();
	}

	maps\sanfran_util::show_fallen_bridge();
}

//Function Number: 136
swap_brigde_anim_to_real_far(param_00)
{
	foreach(var_02 in level.explosion_scene_bridge)
	{
		if(common_scripts\utility::array_contains(level.after_collpase_ents,var_02))
		{
			continue;
		}

		var_02 hide();
	}

	maps\sanfran_util::show_far_bridge();
	maps\sanfran_util::connectpaths_ents_by_targetname("collapse_clip");
	maps\sanfran_util::delete_ents_by_targetname("collapse_clip");
}

//Function Number: 137
start_bridge_after_loop(param_00)
{
	param_00 maps\_anim::anim_loop(level.after_collpase_ents,"after_collapse_idle");
}

//Function Number: 138
start_slow_mo(param_00)
{
	setslowmotion(1,0.2,0.1);
}

//Function Number: 139
stop_slow_mo(param_00)
{
	setslowmotion(0.2,1,0.9);
}

//Function Number: 140
cracked_windshield_swap(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01.origin = param_00.origin;
	var_01.angles = param_00.angles;
	var_01 linkto(param_00);
	var_01 setmodel("vehicle_civ_domestic_sedan_police_static_dstry02");
	param_00 hide();
	thread maps\sanfran_lighting::attach_light_to_police_car(var_01);
	param_00 waittill("death");
	var_01 delete();
}

//Function Number: 141
cleanup_explosion_ents()
{
	level.explosion_scene_org notify("stop_always_loop");
	var_00 = [];
	var_00 = common_scripts\utility::array_combine(var_00,level.idle_scene_ents);
	var_00 = common_scripts\utility::array_combine(var_00,level.barrier_scene_ents);
	var_00 = common_scripts\utility::array_combine(var_00,level.approach_scene_ents);
	var_00 = common_scripts\utility::array_combine(var_00,level.approach_idle_ents);
	var_00 = common_scripts\utility::array_combine(var_00,level.deploy_scene_ents);
	var_00 = common_scripts\utility::array_combine(var_00,level.always_loop_ents);
	clearallcorpses();
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		if(maps\_utility::is_in_array(level.collapse_scene_ents,var_02))
		{
			continue;
		}

		if(maps\_utility::is_in_array(level.collapse_scene_ents_long,var_02))
		{
			continue;
		}

		if(maps\_utility::is_in_array(level.after_collpase_ents,var_02))
		{
			continue;
		}

		if(isai(var_02))
		{
			var_02 maps\_utility::stop_magic_bullet_shield();
		}

		var_02 delete();
	}
}

//Function Number: 142
rock_mob()
{
	var_00 = getent("mob_rocking_origin","targetname");
	var_01 = getent("mob_rocking_attachment_ent","targetname");
	var_01.animname = "MOB";
	var_01 useanimtree(#animtree);
	var_02 = getentarray("mob_brushmodel","targetname");
	foreach(var_04 in var_02)
	{
		var_04 linkto(var_01,"jnt_boat");
	}

	var_06 = getentarray("mob_models","targetname");
	foreach(var_08 in var_06)
	{
		var_08 linkto(var_02[0]);
	}

	while(!common_scripts\utility::flag("flag_stop_mob_rocking"))
	{
		var_00 maps\_anim::anim_single_solo(var_01,"mob_sway");
	}

	var_00 maps\_anim::anim_single_solo(var_01,"mob_sway_stop");
}

//Function Number: 143
setup_bridge_explosion_anim_sequence()
{
	if(level.currentgen)
	{
		while(!istransientloaded("sanfran_bigm_tr"))
		{
			wait(0.05);
		}
	}

	level.idle_scene_ents = [];
	level.barrier_scene_ents = [];
	level.approach_scene_ents = [];
	level.approach_idle_ents = [];
	level.deploy_scene_ents = [];
	level.collapse_scene_ents = [];
	level.collapse_scene_ents_long = [];
	level.after_collpase_ents = [];
	level.deploy_scene_handcuff_ents = [];
	level.animated_gun = [];
	level.always_loop_ents = [];
	level.player_rig = maps\_utility::spawn_anim_model("player_rig");
	level.player_rig hide();
	level.deploy_scene_ents[level.deploy_scene_ents.size] = level.player_rig;
	level.collapse_scene_ents_long[level.collapse_scene_ents_long.size] = level.player_rig;
	level.collapse_scene_ents_long[level.collapse_scene_ents_long.size] = level.burke;
	level.explosion_scene_org = getent("bridge_explosion_origin","targetname");
	setup_bridge_explosion_anim_sequence_vehicles();
	setup_bridge_explosion_anim_sequence_humans();
	setup_bridge_explosion_anim_sequence_bridge();
	level.explosion_scene_org maps\_anim::anim_first_frame(level.collapse_scene_ents,"collapse_scene");
	level.explosion_scene_org maps\_anim::anim_first_frame(level.deploy_scene_ents,"deploy_scene");
	level.explosion_scene_org maps\_anim::anim_first_frame(level.deploy_scene_handcuff_ents,"deploy_scene");
	level.explosion_scene_org maps\_anim::anim_first_frame(level.approach_scene_ents,"approach_scene");
	foreach(var_01 in level.barrier_scene_ents)
	{
		if(var_01.animname == "human_sentinel_7")
		{
			level.explosion_scene_org thread maps\_anim::anim_loop_solo(var_01,"barrier_scene","stop_early_barrier_loop");
			continue;
		}

		level.explosion_scene_org thread maps\_anim::anim_loop_solo(var_01,"barrier_scene","stop_barrier_loop");
	}

	foreach(var_01 in level.idle_scene_ents)
	{
		level.explosion_scene_org thread maps\_anim::anim_loop_solo(var_01,"idle_scene","stop_idle_loop");
	}

	foreach(var_01 in level.always_loop_ents)
	{
		level.explosion_scene_org thread maps\_anim::anim_loop_solo(var_01,"always_loop_scene","stop_always_loop");
	}

	level thread start_bridge_overwatch_heli();
	maps\sanfran_util::notsolid_ents_by_targetname("collapse_clip");
}

//Function Number: 144
start_bridge_overwatch_heli()
{
	level.overwatch_heli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("explosion_overwatch_heli");
	level.overwatch_heli maps\_vehicle::godon();
	level.overwatch_heli maps\sanfran_util::riders_no_damage();
	var_00 = level.overwatch_heli maps\sanfran_util::heli_get_shooters();
	foreach(var_02 in var_00)
	{
		var_02.ignoreall = 1;
		var_02 laseron();
	}

	common_scripts\utility::flag_wait("flag_van_explosion_start");
	var_04 = common_scripts\utility::getstruct("overwatch_heli_peel_off","targetname");
	level.overwatch_heli thread maps\_vehicle_code::_vehicle_paths(var_04);
}

//Function Number: 145
at_van_enemy_cleanup()
{
	level endon("elevator_ascend");
	self endon("van_cleanup_complete");
	var_00 = getent("at_van_enemy_cleanup","targetname");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_at_van_enemy_cleanup");
		var_01 = getaiarray("axis");
		var_02 = [];
		foreach(var_04 in var_01)
		{
			if(isdefined(var_04.van_scene_axis) && var_04.van_scene_axis == 1)
			{
				var_02 = common_scripts\utility::array_add(var_02,var_04);
			}
		}

		var_01 = common_scripts\utility::array_remove_array(var_01,var_02);
		foreach(var_04 in var_01)
		{
			if(isdefined(var_04) && !maps\_utility::player_can_see_ai(var_04))
			{
				var_04 kill();
			}

			var_07 = randomfloatrange(0.05,0.2);
			wait(var_07);
		}

		if(isdefined(var_01) && var_01.size < 1)
		{
			var_00 delete();
			common_scripts\utility::flag_set("van_cleanup_complete");
		}

		wait(0.5);
	}
}

//Function Number: 146
setup_bridge_explosion_anim_sequence_vehicles()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("van_scene_vehicle_chopper");
	var_00 soundscripts\_snd::snd_message("pre_bridge_collapse_helo_idle");
	var_00 maps\_utility::delaythread(0.2,::soundscripts\_snd::snd_message,"snd_stop_vehicle");
	var_00.animname = "chopper_1";
	var_00 useanimtree(#animtree);
	var_00 maps\_vehicle::godon();
	if(level.nextgen)
	{
		var_00 vehicle_scripts\_littlebird::show_static_rotors();
	}

	level.idle_scene_ents[level.idle_scene_ents.size] = var_00;
	thread setup_helicopter_blades_damage();
	var_01 = spawn("script_model",(0,0,-1000));
	var_01 setmodel("vehicle_sentinel_littlebird_dstrypv");
	var_01 hide();
	var_01.animname = "broken_helo";
	var_01 useanimtree(#animtree);
	level.collapse_scene_ents[level.collapse_scene_ents.size] = var_01;
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname("van_scene_vehicle_van");
	var_02 maps\_vehicle::godon();
	var_02.animname = "van";
	var_02 useanimtree(#animtree);
	level.approach_scene_ents[level.approach_scene_ents.size] = var_02;
	level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
	level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
	level.explosion_van = var_02;
	level.explosion_scene_drones = [];
	for(var_03 = 0;var_03 < 12;var_03++)
	{
		var_04 = spawn("script_model",var_02.origin);
		var_04 setmodel("vehicle_atlas_assault_drone");
		var_04.animname = "drone_" + var_03 + 1;
		var_04 useanimtree(#animtree);
		var_04 hide();
		level.explosion_scene_drones[level.explosion_scene_drones.size] = var_04;
		level.deploy_scene_ents[level.deploy_scene_ents.size] = var_04;
	}

	var_05 = spawn("script_model",var_02.origin);
	var_05 setmodel("vehicle_atlas_assault_drone_large");
	var_05.animname = "large_drone";
	var_05 useanimtree(#animtree);
	level.deploy_scene_ents[level.deploy_scene_ents.size] = var_05;
	level.explosion_scene_drone_large = var_05;
	var_06 = maps\_vehicle::spawn_vehicle_from_targetname("van_scene_truck01");
	var_06.animname = "truck01";
	var_06 useanimtree(#animtree);
	level.collapse_scene_ents[level.collapse_scene_ents.size] = var_06;
	var_06 = maps\_vehicle::spawn_vehicle_from_targetname("van_scene_truck02");
	var_06.animname = "truck02";
	var_06 useanimtree(#animtree);
	level.collapse_scene_ents[level.collapse_scene_ents.size] = var_06;
	var_07 = maps\_vehicle::spawn_vehicles_from_targetname("van_scene_vehicle_copcar");
	soundscripts\_snd::snd_message("spawn_parked_police_car",var_07);
	for(var_03 = 0;var_03 < var_07.size;var_03++)
	{
		var_07[var_03].animname = "copcar_" + var_03 + 1;
		var_07[var_03] useanimtree(#animtree);
		var_07[var_03] thread maps\sanfran_fx::cop_car_lights_on_barricade();
		if(var_07[var_03].animname != "copcar_11")
		{
			level.approach_scene_ents[level.approach_scene_ents.size] = var_07[var_03];
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_07[var_03];
			level.collapse_scene_ents[level.collapse_scene_ents.size] = var_07[var_03];
			continue;
		}

		level.approach_scene_ents[level.approach_scene_ents.size] = var_07[var_03];
	}

	var_08 = maps\_vehicle::spawn_vehicle_from_targetname("van_scene_atlas_suv");
	var_08 maps\_vehicle::godon();
	var_08.animname = "atlas_suv";
	var_08 useanimtree(#animtree);
	level.approach_scene_ents[level.approach_scene_ents.size] = var_08;
	var_09 = maps\_vehicle::spawn_vehicle_from_targetname("van_scene_vehicle_bus");
	var_09.animname = "bus";
	var_09 useanimtree(#animtree);
	var_09 hide();
	level.collapse_scene_ents[level.collapse_scene_ents.size] = var_09;
	var_0A = maps\_vehicle::spawn_vehicle_from_targetname("van_scene_vehicle_compact");
	var_0A.animname = "compact";
	var_0A useanimtree(#animtree);
	level.collapse_scene_ents[level.collapse_scene_ents.size] = var_0A;
}

//Function Number: 147
setup_bridge_explosion_anim_sequence_humans()
{
	var_00 = getentarray("van_scene_spawner_atlas","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(var_01 == 2 || var_01 == 3)
		{
			continue;
		}

		var_02 = var_00[var_01] maps\_utility::spawn_ai(1,1);
		var_02.ignoreme = 1;
		var_02.ignoreall = 1;
		var_02.animname = "human_atlas_" + var_01 + 1;
		var_02.ignoresonicaoe = 1;
		var_02.van_scene_axis = 1;
		if(var_02.animname == "human_atlas_1")
		{
			var_02 maps\_utility::gun_remove();
			var_03 = 1;
			var_02.allowdeath = 1;
			var_02.health = 1;
			var_02 maps\_utility::stop_magic_bullet_shield();
			var_02 thread remove_from_idle_array_on_death(var_03);
			var_02.noragdoll = undefined;
			level.approach_scene_ents[level.approach_scene_ents.size] = var_02;
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
			level.deploy_scene_handcuff_ents[level.deploy_scene_handcuff_ents.size] = var_02;
			level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
		}

		if(var_02.animname == "human_atlas_2")
		{
			var_03 = 0;
			var_02.allowdeath = 1;
			var_02.health = 1;
			var_02 maps\_utility::stop_magic_bullet_shield();
			var_02 thread remove_from_idle_array_on_death(var_03);
			var_02.noragdoll = undefined;
			level.barrier_scene_ents[level.barrier_scene_ents.size] = var_02;
			level.approach_scene_ents[level.approach_scene_ents.size] = var_02;
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
			level.deploy_scene_handcuff_ents[level.deploy_scene_handcuff_ents.size] = var_02;
			level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
		}

		if(var_02.animname == "human_atlas_3")
		{
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
		}

		if(var_02.animname == "human_atlas_4")
		{
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
		}

		if(var_02.animname == "human_atlas_5")
		{
			var_02 maps\_utility::gun_remove();
			level.approach_scene_ents[level.approach_scene_ents.size] = var_02;
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
			thread delete_atlas_van_driver(var_02);
			thread disable_threat_atlas_van_driver(var_02);
		}
	}

	var_00 = getentarray("van_scene_spawner_sentinel","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(var_01 == 11 || var_01 == 13)
		{
			continue;
		}

		var_02 = var_00[var_01] maps\_utility::spawn_ai(1,1);
		var_02.ignoreme = 1;
		var_02.ignoreall = 1;
		var_02.animname = "human_sentinel_" + var_01 + 1;
		level.approach_scene_ents[level.approach_scene_ents.size] = var_02;
		if(var_02.animname == "human_sentinel_1")
		{
			level.barrier_scene_ents[level.barrier_scene_ents.size] = var_02;
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
			level.sentinel_op1 = var_02;
		}

		if(var_02.animname == "human_sentinel_2")
		{
			level.barrier_scene_ents[level.barrier_scene_ents.size] = var_02;
			level.deploy_scene_handcuff_ents[level.deploy_scene_handcuff_ents.size] = var_02;
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
			level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
			level.sentinel_op2 = var_02;
		}

		if(var_02.animname == "human_sentinel_3")
		{
			level.barrier_scene_ents[level.barrier_scene_ents.size] = var_02;
			level.deploy_scene_handcuff_ents[level.deploy_scene_handcuff_ents.size] = var_02;
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
		}

		if(var_02.animname == "human_sentinel_4")
		{
			level.barrier_scene_ents[level.barrier_scene_ents.size] = var_02;
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
			level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
			level.sentinel_op4 = var_02;
		}

		if(var_02.animname == "human_sentinel_5")
		{
			level.barrier_scene_ents[level.barrier_scene_ents.size] = var_02;
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
			level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
		}

		if(var_02.animname == "human_sentinel_6")
		{
			level.barrier_scene_ents[level.barrier_scene_ents.size] = var_02;
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
		}

		if(var_02.animname == "human_sentinel_7")
		{
			level.barrier_scene_ents[level.barrier_scene_ents.size] = var_02;
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
			level.approach_scene_ents = common_scripts\utility::array_remove(level.approach_scene_ents,var_02);
			level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
			level.early_approach_guy = var_02;
		}

		if(var_02.animname == "human_sentinel_8")
		{
			level.barrier_scene_ents[level.barrier_scene_ents.size] = var_02;
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
		}

		if(var_02.animname == "human_sentinel_9")
		{
			level.barrier_scene_ents[level.barrier_scene_ents.size] = var_02;
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
			level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
			level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
		}

		if(var_02.animname == "human_sentinel_10")
		{
			level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
		}

		if(var_02.animname == "human_sentinel_11")
		{
			level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
		}
	}

	var_04 = getent("van_scene_spawner_police_special","targetname");
	var_02 = var_04 maps\_utility::spawn_ai(1,1);
	var_02.ignoreme = 1;
	var_02.ignoreall = 1;
	var_02.animname = "human_police_1";
	level.collapse_cop = var_02;
	level.barrier_scene_ents[level.barrier_scene_ents.size] = var_02;
	level.approach_scene_ents[level.approach_scene_ents.size] = var_02;
	level.approach_idle_ents[level.approach_idle_ents.size] = var_02;
	level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
	level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
	var_04 = getent("van_scene_spawner_police","targetname");
	var_02 = var_04 maps\_utility::spawn_ai(1,1);
	var_02.ignoreme = 1;
	var_02.ignoreall = 1;
	var_02.animname = "human_police_2";
	level.always_loop_ents[level.always_loop_ents.size] = var_02;
	level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
	var_00 = getentarray("van_scene_spawner_civilian","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01] maps\_utility::spawn_ai(1,1);
		var_02.ignoreme = 1;
		var_02.ignoreall = 1;
		var_02.animname = "human_civilian_" + var_01 + 1;
		level.collapse_scene_ents[level.collapse_scene_ents.size] = var_02;
	}
}

//Function Number: 148
setup_bridge_explosion_anim_sequence_bridge()
{
	level.explosion_scene_bridge = [];
	for(var_00 = 1;var_00 <= 7;var_00++)
	{
		var_01 = spawn("script_model",(0,0,-1000));
		if(var_00 == 1)
		{
			var_01 setmodel("ggb_collapse_03_chunka");
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_01;
			level.after_collpase_ents[level.after_collpase_ents.size] = var_01;
		}
		else if(var_00 == 2)
		{
			var_01 setmodel("ggb_collapse_03_chunkb");
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_01;
			level.after_collpase_ents[level.after_collpase_ents.size] = var_01;
		}
		else if(var_00 == 3)
		{
			var_01 setmodel("ggb_collapse_03_chunkc");
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_01;
			level.after_collpase_ents[level.after_collpase_ents.size] = var_01;
		}
		else if(var_00 == 4)
		{
			var_01 setmodel("ggb_collapse_03_chunkd");
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_01;
			level.after_collpase_ents[level.after_collpase_ents.size] = var_01;
		}
		else if(var_00 == 5)
		{
			var_01 setmodel("ggb_collapse_03_chunke");
		}
		else if(var_00 == 6)
		{
			var_01 setmodel("ggb_collapse_03_chunkf");
		}
		else if(var_00 == 7)
		{
			var_01 setmodel("ggb_collapse_03_chunkg");
			level.deploy_scene_ents[level.deploy_scene_ents.size] = var_01;
		}

		var_01.animname = "bridge0" + var_00;
		var_01 useanimtree(#animtree);
		var_01 hide();
		level.explosion_scene_bridge[level.explosion_scene_bridge.size] = var_01;
		level.collapse_scene_ents[level.collapse_scene_ents.size] = var_01;
	}

	for(var_00 = 1;var_00 <= 2;var_00++)
	{
		var_02 = spawn("script_model",(0,0,-1000));
		var_02 setmodel("ggb_cable_hero_01");
		var_02.animname = "rope_" + var_00;
		var_02 useanimtree(#animtree);
		var_02 hide();
		level.deploy_scene_ents[level.deploy_scene_ents.size] = var_02;
	}

	var_03 = spawn("script_model",(0,0,-1000));
	var_03 setmodel("vm_hbra3_nocamo");
	var_03.animname = "gun";
	var_03 useanimtree(#animtree);
	var_03 hide();
	level.deploy_scene_ents[level.deploy_scene_ents.size] = var_03;
	for(var_00 = 1;var_00 <= 2;var_00++)
	{
		var_03 = spawn("script_model",(0,0,-1000));
		var_03 setmodel("npc_sn6_base_black");
		var_03.animname = "sn6_0" + var_00;
		var_03 useanimtree(#animtree);
		level.animated_gun[var_00] = var_03;
		level.approach_scene_ents[level.approach_scene_ents.size] = var_03;
		if(var_03.animname == "sn6_02")
		{
			level.approach_idle_ents[level.approach_idle_ents.size] = var_03;
		}
	}

	var_04 = spawn("script_model",(0,0,-1000));
	var_04 setmodel("deployable_cover");
	var_04.animname = "cover";
	var_04 useanimtree(#animtree);
	level.approach_scene_ents[level.approach_scene_ents.size] = var_04;
	var_05 = spawn("script_model",level.player.origin);
	var_05 setmodel("vm_lasercutter");
	var_05 hide();
	var_05.animname = "cutter";
	var_05 useanimtree(#animtree);
	level.deploy_scene_ents[level.deploy_scene_ents.size] = var_05;
	level.cutter = var_05;
}

//Function Number: 149
remove_from_idle_array_on_death(param_00)
{
	self waittill("death");
	if(param_00)
	{
		var_01 = level.animated_gun;
		var_02 = var_01[1].origin;
		var_03 = spawn("script_model",var_01[1].origin);
		var_03.angles = var_01[1].angles;
		var_03 setmodel(var_01[1].model);
		var_01[1] delete();
		var_03 physicslaunchclient(var_03.origin,(0,15,200));
	}

	level.barrier_scene_ents = common_scripts\utility::array_remove(level.barrier_scene_ents,self);
	level.approach_scene_ents = common_scripts\utility::array_remove(level.approach_scene_ents,self);
	level.approach_idle_ents = common_scripts\utility::array_remove(level.approach_idle_ents,self);
	level.collapse_scene_ents = common_scripts\utility::array_remove(level.collapse_scene_ents,self);
}

//Function Number: 150
handle_boost_jump()
{
	common_scripts\utility::flag_set("flag_obj_boost_to_MOB");
	maps\_utility::autosave_by_name();
	level thread move_overwatch_heli_to_slope();
	level thread maps\sanfran_util::give_boost_jump();
	common_scripts\utility::run_thread_on_targetname("trigger_boost_down_color",::boost_down_in_order);
	common_scripts\utility::run_thread_on_noteworthy("trigger_boost_burke_lets_go",::boost_lets_go);
	maps\_utility::activate_trigger_with_targetname("start_boost_jump");
	common_scripts\utility::flag_set("start_boost_lighting");
	common_scripts\utility::flag_set("flag_dialog_start_boost");
	common_scripts\utility::flag_set("flag_dialog_boost_nag");
	common_scripts\utility::flag_set("flag_dialog_boost_chatter");
	level notify("vfx_boost_jump_start");
	common_scripts\utility::run_thread_on_targetname("trigger_on_ship",::wait_till_on_ship);
}

//Function Number: 151
boost_lets_go()
{
	self endon("death");
	self waittill("trigger");
	level thread anim_burke_boost_lets_go();
}

//Function Number: 152
anim_burke_boost_lets_go()
{
	var_00 = getent("boost_burke_lets_go","targetname");
	var_01 = getnode("boost_burke_lets_go_goal","targetname");
	var_00 maps\_anim::anim_reach_solo(level.burke,"boost_go");
	var_00 maps\_anim::anim_single_solo_run(level.burke,"boost_go");
	level.burke thread maps\_spawner::go_to_node(var_01);
	level.burke maps\_utility::enable_ai_color_dontmove();
}

//Function Number: 153
wait_till_on_ship()
{
	self waittill("trigger");
	common_scripts\utility::flag_set("flag_obj_player_on_MOB");
	wait(1);
	if(isalive(level.player))
	{
		maps\_loadout_code::saveplayerweaponstatepersistent("sanfran",1);
		maps\_utility::nextmission();
	}
}

//Function Number: 154
boost_down_in_order()
{
	self endon("death");
	self waittill("trigger");
	var_00 = getentarray("trigger_boost_down_color","targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.script_index < self.script_index)
		{
			var_02 delete();
		}
	}

	wait(0.05);
	self delete();
}

//Function Number: 155
move_overwatch_heli_to_slope()
{
	if(!isdefined(level.overwatch_heli))
	{
		level.overwatch_heli = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("explosion_overwatch_heli");
		level.overwatch_heli maps\_vehicle::godon();
		level.overwatch_heli maps\sanfran_util::riders_no_damage();
		var_00 = level.overwatch_heli maps\sanfran_util::heli_get_shooters();
		foreach(var_02 in var_00)
		{
			var_02.ignoreall = 1;
			var_02 laseron();
		}
	}

	var_04 = common_scripts\utility::getstruct("overwatch_heli_boost","targetname");
	level.overwatch_heli thread maps\_vehicle_code::_vehicle_paths(var_04);
}

//Function Number: 156
railing_dangerzone_think()
{
	var_00 = [];
	for(;;)
	{
		common_scripts\utility::flag_wait("railing_danger_zone_touching");
		var_01 = getaiarray("axis");
		foreach(var_03 in var_01)
		{
			if(randomfloat(100) < 75 && isalive(var_03) && !isdefined(var_03.isseeking))
			{
				var_03 thread dangerzone_enemy_seek_player();
				var_00 = common_scripts\utility::array_add(var_00,var_03);
			}
		}

		var_05 = undefined;
		common_scripts\utility::flag_waitopen("railing_danger_zone_touching");
		var_00 = [];
		wait(1);
	}
}

//Function Number: 157
dangerzone_enemy_seek_player()
{
	self endon("death");
	thread maps\_utility::player_seek_enable();
	self.isseeking = 1;
	common_scripts\utility::flag_waitopen("railing_danger_zone_touching");
	thread maps\_utility::player_seek_disable();
	self.isseeking = undefined;
}