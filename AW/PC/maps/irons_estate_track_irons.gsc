/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_track_irons.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 543 ms
 * Timestamp: 4/22/2024 2:32:14 AM
*******************************************************************/

//Function Number: 1
track_irons_start()
{
	level.start_point_scripted = "hangar";
	maps\irons_estate::irons_estate_objectives();
	maps\irons_estate_code::spawn_player_checkpoint();
	maps\irons_estate_code::spawn_allies();
	thread handle_doctor();
	soundscripts\_snd::snd_message("start_track_irons");
}

//Function Number: 2
track_irons_main()
{
	level.start_point_scripted = "hangar";
	thread track_irons_begin();
	common_scripts\utility::flag_wait("track_irons_end");
	stopcinematicingame();
	setsaveddvar("cg_cinematicCanPause","0");
	setsaveddvar("cg_cinematicFullScreen","1");
	thread maps\_utility::autosave_by_name();
}

//Function Number: 3
track_irons_begin()
{
	common_scripts\utility::flag_set("track_irons_start");
	level.player.grapple["dist_max"] = 800;
	if(!isdefined(level.allies[0]))
	{
		level.allies[0] = maps\irons_estate_code::spawn_ally("cormack");
		level.allies[0].animname = "cormack";
		level.allies[0] thread maps\irons_estate_code::set_helmet_open();
	}

	level.allies[0] maps\_utility::enable_cqbwalk();
	level.allies[0] maps\_utility::set_forcegoal();
	level.allies[0] maps\_utility::set_fixednode_true();
	level.allies[0] maps\_utility::set_ignoreall(1);
	level.allies[0] maps\_utility::set_ignoreme(1);
	level.allies[0] allowedstances("crouch");
	level.allies[0] thread crouch_watcher();
	if(!isdefined(level.listening_org))
	{
		level.listening_org = common_scripts\utility::getstruct("listening_org","targetname");
	}

	if(!isdefined(level.hangar_ents))
	{
		level.hangar_ents = [];
	}

	level.hangar_ents[level.hangar_ents.size] = level.allies[0];
	thread handle_player();
	thread handle_cormack();
	thread handle_irons();
	thread handle_lift_worker_01();
	thread handle_lift_worker_02();
	thread hangar_cargo_crate();
	thread hangar_lift();
	thread handle_gaz();
	thread handle_gaz2();
	thread hangar_ambient_worker_setup();
	thread forklift_setup();
	thread hangar_pa();
	thread ambient_hangar_workers();
	thread maps\irons_estate_plant_tracker::stairwell_doors();
	thread ambient_hangar_fan_blades_setup();
	thread hangar_vials();
	thread hangar_visor_bink();
	thread maps\irons_estate_plant_tracker::landing_pad_lift_upper_static_setup();
	level notify("stealth_alerted_drone_monitor");
	level notify("stop_stealth_spotted_drone_monitor");
}

//Function Number: 4
hangar_vials()
{
	var_00 = maps\_utility::spawn_anim_model("genericprop_x5");
	level.hangar_ents[level.hangar_ents.size] = var_00;
	level.listening_org maps\_anim::anim_first_frame_solo(var_00,"hangar");
	wait(0.05);
	var_00 attach("atlas_stabilize_vial_static","j_prop_1");
	var_00 attach("atlas_stabilize_vial_static","j_prop_2");
	var_00 attach("atlas_stabilize_vial_static","j_prop_3");
	var_00 attach("atlas_stabilize_vial_static","j_prop_4");
	var_00 attach("atlas_stabilize_vial_static","j_prop_5");
	var_00 waittillmatch("end","single anim");
	var_00 delete();
}

//Function Number: 5
crouch_watcher()
{
	level endon("track_irons_end");
	self endon("death");
	for(;;)
	{
		self waittill("traverse_finish");
		wait(0.05);
		self allowedstances("crouch");
	}
}

//Function Number: 6
handle_player()
{
	var_00 = common_scripts\utility::getstruct("monitor_irons_obj_xprompt","targetname");
	var_01 = maps\_utility::spawn_anim_model("player_rig");
	var_01.origin = level.listening_org.origin;
	var_01.angles = level.listening_org.angles;
	var_01 hide();
	level.hangar_ents[level.hangar_ents.size] = var_01;
	level.listening_org maps\_anim::anim_first_frame_solo(var_01,"hangar");
	common_scripts\utility::flag_wait("cormack_in_hangar_position");
	objective_setpointertextoverride(maps\_utility::obj("monitor_irons"),&"IRONS_ESTATE_RECORD");
	objective_position(maps\_utility::obj("monitor_irons"),var_00.origin);
	var_02 = getent("at_listening_position_trigger","targetname");
	var_02 thread maps\_utility::addhinttrigger(&"IRONS_ESTATE_RECORD_INTEL",&"IRONS_ESTATE_RECORD_INTEL_PC");
	thread maps\irons_estate_code::handle_objective_marker(var_00,var_00,"at_listening_position",80);
	var_02 waittill("trigger");
	soundscripts\_snd::snd_message("aud_monitor_irons");
	level.irons thread maps\irons_estate_code::hide_friendname_until_flag_or_notify("track_irons_end");
	level.allies[0] thread maps\_utility::smart_dialogue("ie_crmk_rolling");
	objective_position(maps\_utility::obj("monitor_irons"),(0,0,0));
	var_02 delete();
	common_scripts\utility::flag_set("at_listening_position");
	if(level.nextgen)
	{
		setsaveddvar("r_adaptivesubdiv",0);
	}

	level.player freezecontrols(1);
	common_scripts\utility::flag_clear("_stealth_enabled");
	level.player maps\_grapple::grapple_take();
	level.player allowsprint(0);
	level.player thread maps\_shg_utility::disable_features_entering_cinema(1);
	level.player thread maps\irons_estate_stealth::irons_estate_whistle(0);
	level.player thread maps\_tagging::tagging_set_binocs_enabled(0);
	level.player thread maps\_tagging::tagging_set_enabled(0);
	thread maps\_stealth_display::stealth_display_off();
	level.player disableweapons();
	level.player disableweaponswitch();
	level.player allowmelee(0);
	level.player disableoffhandweapons();
	level.player disableoffhandsecondaryweapons();
	level.player allowprone(0);
	level.player allowcrouch(0);
	level.player playerlinkto(var_01);
	level.player setstance("stand");
	level.player playerlinktoblend(var_01,"tag_player",0.6);
	level.listening_org thread maps\_anim::anim_single(level.hangar_ents,"hangar");
	var_01 thread player_hangar_waits();
	wait(0.55);
	level.listening_org notify("stop_loop");
	wait(0.05);
	var_01 show();
}

//Function Number: 7
hangar_visor_bink()
{
	setsaveddvar("cg_cinematicCanPause","1");
	setsaveddvar("cg_cinematicFullScreen","0");
	var_00 = newclienthudelem(level.player);
	var_00 setshader("cinematic_screen_add",640,480);
	var_00.horzalign = "fullscreen";
	var_00.vertalign = "fullscreen";
	cinematicingame("hangar_visor_hud",1);
	level waittill("start_hangar_visor_hud_bink");
	pausecinematicingame(0);
	wait(0.05);
	while(iscinematicplaying())
	{
		wait(0.05);
	}

	stopcinematicingame();
	var_00 destroy();
	setsaveddvar("cg_cinematicCanPause","0");
	setsaveddvar("cg_cinematicFullScreen","1");
}

//Function Number: 8
player_hangar_waits()
{
	self waittillmatch("device_up","single anim");
	var_00 = level.player getcurrentweapon();
	var_01 = level.player getweaponslistall();
	level.player takeallweapons();
	level notify("start_hangar_visor_hud_bink");
	self waittillmatch("zoom_in","single anim");
	level.player lerpfov(10,0.5);
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03) && var_03 == "iw5_kf5singleshot_sp_opticsreddot_silencer01")
		{
			level.player giveweapon("iw5_kf5fullauto_sp_opticsreddot_silencer01");
		}

		if(isdefined(var_03) && var_03 == "iw5_kf5fullauto_sp_opticsreddot_silencer01")
		{
			level.player giveweapon("iw5_kf5fullauto_sp_opticsreddot_silencer01");
		}

		if(isdefined(var_03) && var_03 == "iw5_sn6_sp_opticsreddot_silencer01")
		{
			level.player giveweapon("iw5_sn6_sp_opticsreddot_silencer01");
		}

		if(isdefined(var_03) && var_03 == "iw5_pbwsingleshot_sp_silencerpistol")
		{
			level.player giveweapon("iw5_pbwsingleshot_sp_silencerpistol");
		}
	}

	self waittillmatch("zoom_in","single anim");
	level.player lerpfov(5,0.5);
	self waittillmatch("zoom_out","single anim");
	level.player lerpfov(20,0.5);
	if((isdefined(var_00) && var_00 == "iw5_kf5singleshot_sp_opticsreddot_silencer01") || var_00 == "iw5_kf5fullauto_sp_opticsreddot_silencer01")
	{
		level.player switchtoweapon("iw5_kf5fullauto_sp_opticsreddot_silencer01");
	}
	else if((isdefined(var_00) && var_00 == "iw5_sn6_sp_opticsreddot_silencer01") || var_00 == "iw5_pbwsingleshot_sp_silencerpistol")
	{
		level.player switchtoweapon("iw5_sn6_sp_opticsreddot_silencer01");
	}

	self waittillmatch("zoom_out","single anim");
	level.player lerpfov(65,0.5);
	self waittillmatch("device_down","single anim");
	self waittillmatch("end","single anim");
	if(level.nextgen)
	{
		setsaveddvar("r_adaptivesubdiv",1);
	}

	level.player unlink();
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player allowmelee(1);
	level.player freezecontrols(0);
	level.player allowsprint(1);
	level.player thread maps\_shg_utility::enable_features_exiting_cinema(1);
	level.player thread maps\irons_estate_stealth::irons_estate_whistle(1);
	level.player thread maps\_tagging::tagging_set_binocs_enabled(1);
	level.player thread maps\_tagging::tagging_set_enabled(1);
	thread maps\_stealth_display::stealth_display_on();
	level.player maps\_grapple::grapple_give();
	while(!level.player common_scripts\utility::isweaponenabled())
	{
		level.player common_scripts\utility::_enableweapon();
	}

	level.player enableweapons();
	level.player enableweaponswitch();
	level.player enableoffhandweapons();
	level.player enableoffhandsecondaryweapons();
	self delete();
	common_scripts\utility::flag_set("_stealth_enabled");
	objective_state_nomessage(maps\_utility::obj("monitor_irons"),"done");
	common_scripts\utility::flag_set("track_irons_end");
}

//Function Number: 9
handle_cormack()
{
	objective_add(maps\_utility::obj("monitor_irons"),"current",&"IRONS_ESTATE_OBJ_MONITOR_IRONS");
	objective_onentity(maps\_utility::obj("monitor_irons"),level.allies[0]);
	level.allies[0] allowedstances("crouch");
	level.allies[0] maps\_utility::smart_dialogue("ie_crmk_onme5");
	var_00 = getnode("cormack_girder_node_01","targetname");
	level.allies[0] maps\_utility::set_goalradius(16);
	level.allies[0] setgoalnode(var_00);
	common_scripts\utility::flag_wait("at_girders");
	level.allies[0] allowedstances("crouch");
	level.listening_org maps\_anim::anim_reach_solo(level.allies[0],"hangar_enter_run");
	level.listening_org maps\_anim::anim_single_solo(level.allies[0],"hangar_enter_run");
	level.listening_org thread maps\_anim::anim_loop_solo(level.allies[0],"hangar_enter_loop","stop_hangar_enter_loop");
	wait(0.05);
	common_scripts\utility::flag_set("cormack_drop_down_ready");
	common_scripts\utility::flag_wait("cormack_drop_down");
	level.listening_org notify("stop_hangar_enter_loop");
	wait(0.05);
	level.listening_org maps\_anim::anim_single_solo(level.allies[0],"hangar_enter");
	level.listening_org thread maps\_anim::anim_loop_solo(level.allies[0],"hangar_loop","stop_loop");
	wait(0.05);
	common_scripts\utility::flag_set("cormack_in_hangar_position");
	level.allies[0] allowedstances("stand");
}

//Function Number: 10
handle_irons()
{
	level endon("stop_irons_and_doctor_handlers");
	level.irons = maps\_utility::spawn_targetname("irons",1);
	level.irons.animname = "irons";
	if(!isdefined(level.irons.magic_bullet_shield))
	{
		level.irons maps\_utility::magic_bullet_shield(1);
	}

	level.irons maps\_utility::gun_remove();
	level.irons maps\_utility::set_allowdeath(1);
	level.irons.grapple_magnets = [];
	level.hangar_ents[level.hangar_ents.size] = level.irons;
	level.irons.scripted_node = level.listening_org;
	level.listening_org thread maps\_anim::anim_loop_solo(level.irons,"hangar_loop","stop_loop");
	wait(0.05);
	level.irons thread maps\irons_estate_civilians::civilian_alert_watcher();
	level.irons thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
	level.irons thread irons_hangar_waits();
}

//Function Number: 11
irons_hangar_waits()
{
	self waittillmatch("end","single anim");
	self delete();
}

//Function Number: 12
handle_doctor()
{
	if(!isdefined(level.listening_org))
	{
		level.listening_org = common_scripts\utility::getstruct("listening_org","targetname");
	}

	if(!isdefined(level.hangar_ents))
	{
		level.hangar_ents = [];
	}

	level endon("stop_irons_and_doctor_handlers");
	if(!isdefined(level.doctor))
	{
		level.doctor = maps\_utility::spawn_targetname("kva_doctor",1);
	}

	level.doctor.tagged = undefined;
	level.doctor.animname = "doctor";
	if(!isdefined(level.doctor.magic_bullet_shield))
	{
		level.doctor maps\_utility::magic_bullet_shield(1);
	}

	level.doctor maps\_utility::gun_remove();
	level.doctor attach("npc_dronelaunchpad","tag_weapon_right");
	level.doctor.grapple_magnets = [];
	level.hangar_ents[level.hangar_ents.size] = level.doctor;
	level.doctor maps\_utility::set_allowdeath(1);
	level.doctor thread doctor_pad_watcher();
	level.doctor.scripted_node = level.listening_org;
	level.doctor maps\_utility::disable_arrivals();
	level.doctor maps\_utility::disable_exits();
	level.doctor maps\_utility::set_run_anim("doctor_walk",1);
	level.listening_org thread maps\_anim::anim_reach_solo(level.doctor,"hangar");
	common_scripts\utility::flag_wait("track_irons_start");
	level.doctor notify("new_anim_reach");
	level.listening_org thread maps\_anim::anim_loop_solo(level.doctor,"hangar_loop","stop_loop");
	wait(0.05);
	level.doctor thread maps\irons_estate_civilians::civilian_alert_watcher();
	level.doctor thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
	level.doctor thread doctor_hangar_waits();
}

//Function Number: 13
doctor_pad_watcher()
{
	common_scripts\utility::waittill_any("alerted","death");
	if(isdefined(self))
	{
		level.doctor detach("npc_dronelaunchpad","tag_weapon_right");
	}
}

//Function Number: 14
doctor_hangar_waits()
{
	self waittillmatch("end","single anim");
	self delete();
}

//Function Number: 15
hangar_lift()
{
	var_00 = maps\_utility::spawn_anim_model("generic_prop_raven");
	level.hangar_ents[level.hangar_ents.size] = var_00;
	level.listening_org maps\_anim::anim_first_frame_solo(var_00,"hangar");
	wait(0.05);
	var_01 = getent("landing_pad_lift","targetname");
	var_01 linkto(var_00,"j_prop_1");
}

//Function Number: 16
hangar_cargo_crate()
{
	var_00 = maps\_utility::spawn_anim_model("cargo_crate");
	var_00 hidepart("TAG_STATIC_CASE");
	var_00 hidepart("TAG_STATIC_VIALS");
	level.hangar_ents[level.hangar_ents.size] = var_00;
	level.listening_org maps\_anim::anim_first_frame_solo(var_00,"hangar");
	wait(0.05);
	var_00 waittillmatch("end","single anim");
	var_00 delete();
	var_01 = getent("manticore_crate_clip","targetname");
	if(isdefined(var_01))
	{
		var_01 delete();
	}
}

//Function Number: 17
handle_lift_worker_01()
{
	var_00 = maps\_utility::spawn_targetname("lift_worker_01",1);
	var_00.animname = "lift_worker_01";
	var_00 maps\_utility::gun_remove();
	var_00.grapple_magnets = [];
	var_00 maps\_utility::set_allowdeath(1);
	level.hangar_ents[level.hangar_ents.size] = var_00;
	var_00.scripted_node = level.listening_org;
	level.listening_org thread maps\_anim::anim_loop_solo(var_00,"hangar_loop","stop_loop");
	wait(0.05);
	var_00 thread maps\irons_estate_civilians::civilian_alert_watcher();
	var_00 thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
	var_00 thread lift_worker_01_waits();
}

//Function Number: 18
lift_worker_01_waits()
{
	self waittillmatch("end","single anim");
	self delete();
}

//Function Number: 19
handle_lift_worker_02()
{
	var_00 = maps\_utility::spawn_targetname("lift_worker_02",1);
	var_00.animname = "lift_worker_02";
	var_00 maps\_utility::gun_remove();
	var_00.grapple_magnets = [];
	var_00 maps\_utility::set_allowdeath(1);
	level.hangar_ents[level.hangar_ents.size] = var_00;
	var_00.scripted_node = level.listening_org;
	level.listening_org thread maps\_anim::anim_loop_solo(var_00,"hangar_loop","stop_loop");
	wait(0.05);
	var_00 thread maps\irons_estate_civilians::civilian_alert_watcher();
	var_00 thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
	var_00 thread lift_worker_02_waits();
}

//Function Number: 20
lift_worker_02_waits()
{
	self waittillmatch("end","single anim");
	self delete();
}

//Function Number: 21
handle_gaz()
{
	if(!isdefined(level.listening_org))
	{
		level.listening_org = common_scripts\utility::getstruct("listening_org","targetname");
	}

	if(!isdefined(level.gaz))
	{
		level.gaz = maps\_utility::spawn_anim_model("gaz");
	}

	level.listening_org thread maps\_anim::anim_loop_solo(level.gaz,"hangar");
}

//Function Number: 22
handle_gaz2()
{
	if(!isdefined(level.listening_org))
	{
		level.listening_org = common_scripts\utility::getstruct("listening_org","targetname");
	}

	if(!isdefined(level.gaz2))
	{
		level.gaz2 = maps\_utility::spawn_anim_model("gaz2");
	}

	level.listening_org thread maps\_anim::anim_loop_solo(level.gaz2,"hangar");
}

//Function Number: 23
hangar_ambient_worker_setup()
{
	var_00 = maps\_utility::array_spawn_targetname("hangar_ambient_worker",1);
	common_scripts\utility::array_thread(var_00,::hangar_ambient_worker_setup_anim);
}

//Function Number: 24
hangar_ambient_worker_setup_anim()
{
	self endon("death");
	thread maps\irons_estate_civilians::civilian_alert_watcher();
	thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
	maps\_utility::set_allowdeath(1);
	self.grapple_magnets = [];
	self.scripted_node = common_scripts\utility::getstruct(self.target,"targetname");
	if(isdefined(self.scripted_node.script_noteworthy) && self.scripted_node.script_noteworthy == "ie_hangar_ambience_welder_loop")
	{
		self.welder = 1;
		self.torch = spawn("script_model",(0,0,0));
		self.torch setmodel("machinery_welder_handle");
		self.torch linkto(self,"tag_inhand",(0,0,0),(0,0,0));
		self.scripted_node = level.listening_org;
		thread flashing_welding();
		thread flashing_welding_death_handler();
		return;
	}

	self.scripted_node thread maps\_anim::anim_generic_loop(self,self.scripted_node.animation,"stop_loop");
}

//Function Number: 25
flashing_welding()
{
	self endon("death");
	self endon("alerted");
	self.scripted_node thread maps\_anim::anim_generic_loop(self,"ie_hangar_ambience_welder_loop","stop_welder_loop");
	for(;;)
	{
		self.torch soundscripts\_snd_playsound::snd_play_loop_linked("irons_hangar_welding_loop","aud_stop_welding_loop",0.2,0.2);
		self waittillmatch("spark_stop","looping anim");
		level notify("aud_stop_welding_loop");
		stopfxontag(level._effect["ie_welding_runner"],self.torch,"tag_tip_fx");
		self waittillmatch("spark_start","looping anim");
		playfxontag(level._effect["ie_welding_runner"],self.torch,"tag_tip_fx");
	}
}

//Function Number: 26
flashing_welding_death_handler()
{
	common_scripts\utility::waittill_either("death","alerted");
	if(isdefined(self.torch))
	{
		level notify("aud_stop_welder_loop");
	}
}

//Function Number: 27
forklift_setup()
{
	var_00 = [];
	level.forklift = maps\_utility::spawn_anim_model("forklift");
	var_01 = getent("forklift_clip","targetname");
	var_01 linkto(level.forklift,"tag_body",(0,0,-32),(0,90,0));
	var_00[var_00.size] = level.forklift;
	level.forklift_crate_prop = maps\_utility::spawn_anim_model("generic_prop_raven");
	var_00[var_00.size] = level.forklift_crate_prop;
	level.forklift_crate_prop attach("lsr_mili_cargo_cage_atlas_07","j_prop_1");
	var_02 = getent("forklift_cargo_clip","targetname");
	if(isdefined(var_02))
	{
		var_02 linkto(level.forklift_crate_prop,"j_prop_1",(0,0,0),(0,0,0));
	}

	level.forklift_driver = maps\_utility::spawn_targetname("forklift_driver","targetname");
	var_00[var_00.size] = level.forklift_driver;
	level.forklift_driver.animname = "forklift_driver";
	level.forklift_driver maps\_utility::set_allowdeath(1);
	level.forklift_driver.grapple_magnets = [];
	level.forklift_driver thread maps\_utility::set_ignoresonicaoe(1);
	level.forklift_driver thread forklift_stop_watcher();
	level.forklift_driver thread maps\irons_estate_civilians::civilian_alert_watcher();
	level.forklift_driver thread maps\irons_estate_civilians::civilian_alert_behavior_hangar();
	level.forklift_org = spawnstruct();
	level.forklift_org.origin = level.listening_org.origin;
	level.forklift_org.angles = level.listening_org.angles;
	level.forklift_driver.scripted_node = level.forklift_org;
	var_03 = getent("forklift_fail_trigger","targetname");
	if(isdefined(var_03))
	{
		var_03 enablelinkto();
		var_03 linkto(level.forklift,"tag_body",(40,0,38),(0,90,0));
		var_03 thread forklift_fail_trigger_setup();
	}

	level.forklift_door_prop = maps\_utility::spawn_anim_model("generic_prop_raven_x3");
	var_00[var_00.size] = level.forklift_door_prop;
	level.forklift_org thread maps\_anim::anim_loop(var_00,"forklift_loop","stop_loop");
	var_04 = getent("forklift_door_left","targetname");
	var_04 linkto(level.forklift_door_prop,"j_prop_1",(0,0,0),(0,0,0));
	var_05 = getent("forklift_door_right","targetname");
	var_05 linkto(level.forklift_door_prop,"j_prop_2",(0,0,0),(0,0,0));
	level.forklift thread maps\irons_estate_aud::forklift_audio_loop();
}

//Function Number: 28
forklift_fail_trigger_setup()
{
	self waittill("trigger",var_00);
	if(isdefined(var_00) && var_00 == level.player)
	{
		level.forklift_driver notify("alerted");
	}
}

//Function Number: 29
forklift_stop_watcher()
{
	common_scripts\utility::waittill_any("alerted","death");
	level.forklift setflaggedanim("looping anim",level.scr_anim[level.forklift.animname]["forklift_loop"][0],1,0,0);
	level.forklift_door_prop setflaggedanim("looping anim",level.scr_anim[level.forklift_door_prop.animname]["forklift_loop"][0],1,0,0);
	level.forklift_crate_prop setflaggedanim("looping anim",level.scr_anim[level.forklift_crate_prop.animname]["forklift_loop"][0],1,0,0);
}

//Function Number: 30
hangar_pa()
{
	var_00 = getent("hangar_pa","targetname");
	wait(6);
	var_00 maps\_utility::play_sound_on_entity("ie_hpa_clearlift");
	wait(6);
	var_00 maps\_utility::play_sound_on_entity("ie_hpa_lowerlevel");
	wait(6);
	var_00 maps\_utility::play_sound_on_entity("ie_hpa_mainoffice");
	wait(6);
	var_00 maps\_utility::play_sound_on_entity("ie_hpa_idready");
	wait(6);
	var_00 maps\_utility::play_sound_on_entity("ie_hpa_inprogress");
}

//Function Number: 31
ambient_hangar_workers()
{
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = undefined;
	maps\_utility::array_spawn_function_targetname("ambient_hangar_workers",::ambient_hangar_workers_spawn_settings);
	var_06 = maps\_utility::array_spawn_targetname("ambient_hangar_workers",1);
	foreach(var_08 in var_06)
	{
		if(isdefined(var_08.script_noteworthy) && var_08.script_noteworthy == "fueled_up_vo_guy1")
		{
			var_00 = var_08;
			var_00 thread maps\irons_estate_civilians::civilian_alert_watcher(undefined,"fueled_up_vo_guys");
			var_00 thread maps\irons_estate_civilians::civilian_alert_behavior();
		}

		if(isdefined(var_08.script_noteworthy) && var_08.script_noteworthy == "fueled_up_vo_guy2")
		{
			var_01 = var_08;
			var_01 thread maps\irons_estate_civilians::civilian_alert_watcher(undefined,"fueled_up_vo_guys");
			var_01 thread maps\irons_estate_civilians::civilian_alert_behavior();
		}

		if(isdefined(var_08.script_noteworthy) && var_08.script_noteworthy == "storage_vo_guy1")
		{
			var_02 = var_08;
			var_02 thread maps\irons_estate_civilians::civilian_alert_watcher(undefined,"storage_vo_guys");
			var_02 thread maps\irons_estate_civilians::civilian_alert_behavior();
		}

		if(isdefined(var_08.script_noteworthy) && var_08.script_noteworthy == "storage_vo_guy2")
		{
			var_03 = var_08;
			var_03 thread maps\irons_estate_civilians::civilian_alert_watcher(undefined,"storage_vo_guys");
			var_03 thread maps\irons_estate_civilians::civilian_alert_behavior();
		}

		if(isdefined(var_08.script_noteworthy) && var_08.script_noteworthy == "preflight_vo_guy1")
		{
			var_04 = var_08;
			var_04 thread maps\irons_estate_civilians::civilian_alert_watcher(undefined,"preflight_vo_guys");
			var_04 thread maps\irons_estate_civilians::civilian_alert_behavior();
		}

		if(isdefined(var_08.script_noteworthy) && var_08.script_noteworthy == "preflight_vo_guy2")
		{
			var_05 = var_08;
			var_05 thread maps\irons_estate_civilians::civilian_alert_watcher(undefined,"preflight_vo_guys");
			var_05 thread maps\irons_estate_civilians::civilian_alert_behavior();
		}
	}

	thread fueled_up_vo(var_00,var_01);
	thread storage_vo(var_02,var_03);
	thread preflight_vo(var_04,var_05);
}

//Function Number: 32
ambient_hangar_workers_spawn_settings()
{
	self endon("death");
	self.animname = "generic";
}

//Function Number: 33
fueled_up_vo(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("something_alerted_me");
	param_01 endon("death");
	param_01 endon("something_alerted_me");
	param_00 thread maps\irons_estate_code::stopsounds_on_death();
	param_01 thread maps\irons_estate_code::stopsounds_on_death();
	common_scripts\utility::flag_wait("fueled_up_vo_start");
	param_00 maps\_utility::smart_dialogue_generic("ie_hw3_taxi");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw1_fueling");
	wait(0.5);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw3_clearasap");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw1_onit");
	wait(0.5);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw3_aneta");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw1_onitnow");
	wait(0.5);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw3_getaneta");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw1_alright3");
}

//Function Number: 34
storage_vo(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("something_alerted_me");
	param_01 endon("death");
	param_01 endon("something_alerted_me");
	param_00 thread maps\irons_estate_code::stopsounds_on_death();
	param_01 thread maps\irons_estate_code::stopsounds_on_death();
	common_scripts\utility::flag_wait("storage_vo_start");
	param_00 maps\_utility::smart_dialogue_generic("ie_hw1_storagenumber");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw2_25");
	wait(0.5);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw1_gotit5");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw2_easyaccess");
	wait(0.5);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw1_shipment");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw2_what");
	wait(0.5);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw1_yesterdaysdrop");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw2_okyaokay");
}

//Function Number: 35
preflight_vo(param_00,param_01)
{
	param_00 endon("death");
	param_00 endon("something_alerted_me");
	param_01 endon("death");
	param_01 endon("something_alerted_me");
	param_00 thread maps\irons_estate_code::stopsounds_on_death();
	param_01 thread maps\irons_estate_code::stopsounds_on_death();
	wait(2);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw2_uptop");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw3_continuewithout");
	wait(0.5);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw2_keithsays");
	wait(0.5);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw2_neednow");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw3_fuallast");
	wait(0.5);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw2_protocol");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw3_toobad");
	wait(0.5);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw2_tellthem");
	wait(0.5);
	param_01 maps\_utility::smart_dialogue_generic("ie_hw3_eff");
	wait(0.5);
	param_00 maps\_utility::smart_dialogue_generic("ie_hw2_shortly");
}

//Function Number: 36
ambient_hangar_fan_blades_setup()
{
	var_00 = getentarray("ambient_hangar_fan_blade","targetname");
	if(isdefined(var_00))
	{
		foreach(var_02 in var_00)
		{
			var_02 thread ambient_hangar_fan_blade_rotate("player_grappled_to_vtol");
		}
	}
}

//Function Number: 37
ambient_hangar_fan_blade_rotate(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.angles = self.angles;
	self linkto(var_01,"tag_origin");
	var_02 = (0,-180,0);
	while(!common_scripts\utility::flag(param_00))
	{
		self rotatebylinked(var_02,0.25);
		self waittill("rotatedone");
		self rotatebylinked(var_02,0.25);
		self waittill("rotatedone");
	}
}