/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_security_center.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 163 ms
 * Timestamp: 4/22/2024 2:32:09 AM
*******************************************************************/

//Function Number: 1
security_center_start()
{
	level.start_point_scripted = "security_center";
	maps\irons_estate::irons_estate_objectives();
	maps\irons_estate_code::spawn_player_checkpoint();
	maps\irons_estate_code::spawn_allies();
	thread maps\irons_estate_code::handle_player_abandoned_mission("nox");
	thread maps\irons_estate_infil::poolhouse_enemies();
	thread maps\irons_estate_code::tennis_court_floor(1);
	thread maps\irons_estate_code::player_kill_trigger("waterfall_top_kill_trigger");
	thread drone_setup_before_emp();
	thread security_center_fan_blades();
	soundscripts\_snd::snd_message("start_security_center");
	var_00 = getentarray("security_center_light_hatch","targetname");
	thread maps\irons_estate_code::security_center_lights(undefined,var_00,50000);
	common_scripts\_exploder::exploder(6611);
	common_scripts\utility::flag_set("player_in_estate");
	var_01 = common_scripts\utility::getstruct("security_center_rooftop_obj","targetname");
	var_02 = common_scripts\utility::getstruct("security_center_emp_xprompt","targetname");
	objective_add(maps\_utility::obj("security_center"),"current",&"IRONS_ESTATE_OBJ_SECURITY_CENTER");
	objective_position(maps\_utility::obj("security_center"),var_02.origin);
	objective_setpointertextoverride(maps\_utility::obj("security_center"),&"IRONS_ESTATE_PLANT");
	thread maps\irons_estate_code::handle_objective_marker(var_02,var_01,"player_planting_emp",50);
}

//Function Number: 2
security_center_main()
{
	level.start_point_scripted = "security_center";
	common_scripts\utility::flag_set("security_center_begin");
	thread security_center_begin();
	common_scripts\utility::flag_wait("security_center_end");
	maps\_utility::autosave_stealth();
}

//Function Number: 3
security_center_begin()
{
	level.player.grapple["dist_max"] = 800;
	thread handle_security_center();
}

//Function Number: 4
handle_security_center()
{
	thread maps\irons_estate_code::security_center_main_screen_bink(1);
	var_00 = getent("security_center_desk_screen","targetname");
	var_00 hide();
	thread plant_emp_setup();
	common_scripts\utility::flag_wait("security_center_enter_anim_done");
	common_scripts\utility::flag_set("security_center_end");
	thread maps\irons_estate_fx::sec_godray();
}

//Function Number: 5
drone_setup_before_emp()
{
	var_00 = getentarray("security_center_drone","targetname");
	foreach(var_02 in var_00)
	{
		playfxontag(level._effect["ie_drone_eye_emissive_bootup"],var_02,"tag_main_camera");
	}

	common_scripts\utility::flag_wait("emp_detonated");
	foreach(var_02 in var_00)
	{
		stopfxontag(level._effect["ie_drone_eye_emissive_bootup"],var_02,"tag_main_camera");
	}
}

//Function Number: 6
security_center_fan_blades()
{
	var_00 = getentarray("fan_blade","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread security_center_fan_blades_internal();
	}
}

//Function Number: 7
security_center_fan_blades_internal()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.angles = self.angles;
	self linkto(var_00,"tag_origin");
	if(level.start_point_scripted == "infil" || level.start_point_scripted == "security_center")
	{
		while(!common_scripts\utility::flag("emp_detonated"))
		{
			self rotatebylinked((0,180,0),0.25);
			self waittill("rotatedone");
		}

		self rotatebylinked((0,180,0),0.25,0,0);
		self waittill("rotatedone");
		self rotatebylinked((0,180,0),0.5,0,0);
		self waittill("rotatedone");
		self rotatebylinked((0,180,0),1,0,0);
		self waittill("rotatedone");
		self rotatebylinked((0,180,0),2,0,0);
	}

	if(level.start_point_scripted == "security_center" || level.start_point_scripted == "hack_security")
	{
		common_scripts\utility::flag_wait("player_is_exiting_security_center");
	}

	self rotatebylinked((0,180,0),2,0,0);
	self waittill("rotatedone");
	self rotatebylinked((0,180,0),1,0,0);
	self waittill("rotatedone");
	self rotatebylinked((0,180,0),0.5,0,0);
	self waittill("rotatedone");
	self rotatebylinked((0,180,0),0.25,0,0);
	self waittill("rotatedone");
	while(!common_scripts\utility::flag("penthouse_end"))
	{
		self linkto(var_00,"tag_origin");
		self rotatebylinked((0,180,0),0.25);
		self waittill("rotatedone");
	}

	if(isdefined(self))
	{
		self delete();
	}

	if(isdefined(var_00))
	{
		var_00 delete();
	}
}

//Function Number: 8
plant_emp_setup()
{
	level.security_center_anim_struct = common_scripts\utility::getstruct("security_center_anim_struct","targetname");
	var_00 = getent("emp_device_position","targetname");
	level.emp_device_obj = spawn("script_model",(0,0,0));
	level.emp_device_obj setmodel("mutecharge_obj");
	level.emp_device_obj.angles = var_00.angles;
	level.emp_device_obj.origin = var_00.origin;
	level.emp = maps\_utility::spawn_anim_model("emp");
	level.emp hide();
	maps\irons_estate_code::security_center_player_rig_and_hatch_door_setup();
	level.player_and_hatch_doors[3] = level.emp;
	level.security_center_anim_struct maps\_anim::anim_first_frame(level.player_and_hatch_doors,"plant_emp");
	level.security_center_hatch_trigger = getent("security_center_hatch_trigger","targetname");
	level.security_center_rooftop_obj = common_scripts\utility::getstruct("security_center_rooftop_obj","targetname");
	thread maps\irons_estate_code::delay_scripting_if_stealth_broken(level.security_center_hatch_trigger,"player_planting_emp",level.emp_device_obj,::plant_emp_trigger);
	plant_emp_trigger();
}

//Function Number: 9
plant_emp_trigger()
{
	level endon("_stealth_spotted");
	level endon("someone_became_alert");
	level endon("drones_investigating");
	if(common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("someone_became_alert") || common_scripts\utility::flag("drones_investigating"))
	{
		return;
	}

	thread security_center_vo();
	level.security_center_hatch_trigger thread maps\_utility::addhinttrigger(&"IRONS_ESTATE_EMP",&"IRONS_ESTATE_EMP_PC");
	level.security_center_hatch_trigger waittill("trigger");
	level.security_center_hatch_trigger delete();
	soundscripts\_snd::snd_message("aud_security_plant_emp");
	plant_emp();
}

//Function Number: 10
plant_emp()
{
	level notify("player_planting_emp");
	common_scripts\utility::flag_set("player_planting_emp");
	setsaveddvar("objectiveHide",1);
	level.play_ally_warning_vo = undefined;
	level.ally_vo_org stopsounds();
	wait(0.05);
	level.player thread maps\_tagging::tagging_set_binocs_enabled(0);
	level.player thread maps\irons_estate_stealth::irons_estate_whistle(0);
	level.player freezecontrols(1);
	level.player thread maps\_shg_utility::disable_features_entering_cinema(1);
	if(level.player getstance() != "stand")
	{
		level.player setstance("stand");
	}

	level.player allowcrouch(0);
	level.player disableweapons();
	level.player playerlinktoblend(level.player_rig,"tag_player",0.6);
	level.security_center_anim_struct thread maps\_anim::anim_single(level.player_and_hatch_doors,"plant_emp");
	wait(0.6);
	level.emp_device_obj delete();
	level.player_rig show();
	level.emp show();
	level.player playrumbleonentity("light_1s");
	level.player_rig waittillmatch("lights_off","single anim");
	common_scripts\utility::flag_set("emp_detonated");
	level.player playrumbleonentity("light_1s");
	level.player thread maps\_tagging::tagging_set_enabled(0);
	var_00 = getentarray("security_center_light","targetname");
	thread maps\irons_estate_code::security_center_lights(1,var_00);
	var_01 = getentarray("security_center_light_hatch","targetname");
	thread maps\irons_estate_code::security_center_lights(1,var_01);
	var_02 = getentarray("ac_unit_emissive","targetname");
	foreach(var_04 in var_02)
	{
		var_04 thread maps\irons_estate_code::security_center_script_brushmodels(1);
	}

	var_06 = getent("security_center_ladder_light","targetname");
	var_06 thread maps\irons_estate_code::security_center_script_brushmodels(1);
	var_07 = getentarray("server_lights","targetname");
	foreach(var_09 in var_07)
	{
		var_09 thread maps\irons_estate_code::security_center_script_brushmodels(1);
	}

	var_0B = getent("security_center_hatch_window_cards","targetname");
	var_0B thread maps\irons_estate_code::security_center_script_brushmodels(1);
	playfxontag(common_scripts\utility::getfx("ie_emp"),level.emp,"tag_vfx_attach");
	maps\_utility::stop_exploder(6611);
	wait(3.25);
	level.player playrumbleonentity("light_1s");
	wait(0.5);
	level.player playrumbleonentity("light_1s");
	wait(6.3);
	level.player playrumbleonentity("light_1s");
	level.player_rig waittillmatch("end","single anim");
	thread maps\irons_estate_code::timer(120,10,undefined,&"IRONS_ESTATE_SECURITY_TIMER");
	level.player_rig hide();
	level.player_and_hatch_doors = common_scripts\utility::array_remove(level.player_and_hatch_doors,level.emp);
	level.emp delete();
	level.player unlink();
	level.player enableweapons();
	level.player allowcrouch(1);
	level.player freezecontrols(0);
	level.player thread maps\_shg_utility::enable_features_exiting_cinema(1);
	common_scripts\utility::flag_set("security_center_enter_anim_done");
}

//Function Number: 11
security_center_vo()
{
	level endon("_stealth_spotted");
	level endon("someone_became_alert");
	level endon("drones_investigating");
	if(common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("someone_became_alert") || common_scripts\utility::flag("drones_investigating"))
	{
		return;
	}

	wait(0.5);
	var_00 = getent("security_center_rooftop_trigger","targetname");
	if(!level.player istouching(var_00))
	{
		var_00 waittill("trigger");
	}

	maps\_utility::smart_radio_dialogue("ie_nox_microemp");
	common_scripts\utility::flag_wait("emp_detonated");
	wait(6.5);
	maps\_utility::smart_radio_dialogue("ie_nox_minutesbehind");
}