/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_bedroom.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 160 ms
 * Timestamp: 4/22/2024 2:31:44 AM
*******************************************************************/

//Function Number: 1
bedroom_start()
{
	level.start_point_scripted = "penthouse";
	maps\irons_estate::irons_estate_objectives();
	maps\irons_estate_code::spawn_player_checkpoint();
	maps\irons_estate_code::spawn_allies();
	thread maps\irons_estate_civilians::civilian_driveway_scene();
	thread maps\irons_estate_penthouse::ie_west_enemies();
	soundscripts\_snd::snd_message("start_bedroom");
	objective_add(maps\_utility::obj("penthouse"),"current",&"IRONS_ESTATE_OBJ_PENTHOUSE");
	var_00 = common_scripts\utility::getstruct("penthouse_balcony_interior_obj","targetname");
	objective_position(maps\_utility::obj("penthouse"),var_00.origin);
}

//Function Number: 2
bedroom_main()
{
	level.start_point_scripted = "penthouse";
	thread bedroom_begin();
	common_scripts\utility::flag_wait("bedroom_end");
	common_scripts\utility::flag_set("_stealth_enabled");
	thread maps\_utility::autosave_stealth();
}

//Function Number: 3
bedroom_begin()
{
	common_scripts\utility::flag_set("bedroom_start");
	level.play_ally_warning_vo = undefined;
	level.play_ally_callout_vo = undefined;
	level.ally_vo_org stopsounds();
	wait(0.05);
	level.player.grapple["dist_max"] = 800;
	thread balcony_entrance_doors();
	thread meet_cormack_cormack();
	wait(0.05);
	thread maps\irons_estate_intel::setup_intel_player();
	thread maps\irons_estate_intel::vo_test();
	thread maps\irons_estate_intel::temp_bink_stuff();
}

//Function Number: 4
meet_cormack_cormack()
{
	level.meet_cormack_kill_org = common_scripts\utility::getstruct("meet_cormack_kill_org","targetname");
	var_00 = maps\_utility::spawn_targetname("cormack_stealth_takedown_guy",1);
	var_00.animname = "cormack_stealth_takedown_guy";
	var_00.health = 1;
	var_00.diequietly = 1;
	var_00.grapple_magnets = [];
	var_00.tagged = undefined;
	var_00 maps\_utility::gun_remove();
	if(!isdefined(level.allies[0]))
	{
		level.allies[0] = maps\irons_estate_code::spawn_ally("cormack");
		level.allies[0].animname = "cormack";
		level.allies[0] thread maps\irons_estate_code::set_helmet_open();
	}

	level.allies[0] maps\_utility::enable_cqbwalk();
	level.allies[0] maps\_utility::set_forcegoal();
	level.allies[0] maps\_utility::set_fixednode_true();
	level.allies[0] maps\_utility::set_fixednode_true();
	level.allies[0] maps\_utility::set_forcegoal();
	level.allies[0] maps\_utility::set_goalradius(16);
	var_01 = maps\_utility::spawn_anim_model("base_grapple_scale_rope");
	var_01 hide();
	var_02 = maps\_utility::spawn_anim_model("genericprop_x5");
	level.meet_cormack_kill_org maps\_anim::anim_first_frame([level.allies[0],var_00,var_01,var_02],"pent_enter");
	wait(0.05);
	var_03 = getent("pent_enter_door_left","targetname");
	var_04 = getent("pent_enter_door_right","targetname");
	var_05 = getent("pent_desk_chair","targetname");
	var_06 = getent("pent_desk_chair_clip","targetname");
	var_06 linkto(var_05);
	var_07 = getent("office_painting","targetname");
	var_07 linkto(var_02,"j_prop_4");
	wait(0.05);
	var_03 linkto(var_02,"j_prop_1",(0,0,0),(0,0,0));
	var_04 linkto(var_02,"j_prop_2",(0,0,0),(0,0,0));
	var_05 linkto(var_02,"j_prop_3",(0,0,0),(0,0,0));
	wait(0.05);
	var_08 = getent("pent_enter_door_left_clip","targetname");
	var_09 = getent("pent_enter_door_right_clip","targetname");
	if(isdefined(var_08) && isdefined(var_09))
	{
		var_08 linkto(var_02,"j_prop_1");
		var_09 linkto(var_02,"j_prop_2");
	}

	common_scripts\utility::flag_wait("player_entered_balcony_door");
	maps\irons_estate_code::irons_estate_stealth_disable();
	player_reached_stealth_finish_line();
	soundscripts\_snd::snd_message("aud_cormack_grapple_kill");
	maps\_utility::objective_complete(maps\_utility::obj("penthouse"));
	level.meet_cormack_kill_org thread maps\_anim::anim_single([level.allies[0],var_00,var_01,var_02],"pent_enter");
	var_01 thread cormack_stealth_takedown_rope_waits();
	var_00 thread cormack_stealth_takedown_guy_waits();
	level.allies[0] waittillmatch("greeting","single anim");
	if(isdefined(level.death_counter) && level.death_counter >= 10)
	{
		level.allies[0] thread maps\_utility::smart_dialogue("ie_crmk_lotofbodies");
	}
	else if(common_scripts\utility::flag("someone_became_alert"))
	{
		level.allies[0] thread maps\_utility::smart_dialogue("ie_crmk_cutitclose");
	}
	else
	{
		var_0A = [];
		var_0A[var_0A.size] = "ie_crmk_gettinghere3";
		var_0A[var_0A.size] = "ie_crmk_niceandclean3";
		var_0A[var_0A.size] = "ie_crmk_perfectrun3";
		level.allies[0] thread maps\_utility::smart_dialogue(common_scripts\utility::random(var_0A));
	}

	level.allies[0] waittillmatch("end","single anim");
	common_scripts\utility::flag_set("bedroom_end");
}

//Function Number: 5
player_reached_stealth_finish_line()
{
	var_00 = 0;
	foreach(var_02 in level.active_drones)
	{
		if(var_02.mode == "attack")
		{
			maps\irons_estate_code::player_alerted_mission_fail();
			var_00 = 1;
			break;
		}

		var_02 thread vehicle_scripts\_pdrone_security::drone_return_home(undefined,var_02.prev_attached_path);
	}

	if(!var_00)
	{
		common_scripts\utility::flag_clear("force_stealth_spotted_drones");
		common_scripts\utility::flag_clear("_stealth_spotted");
		level notify("drones_abort");
		foreach(var_02 in level.active_drones)
		{
			var_02 thread vehicle_scripts\_pdrone_security::drone_return_home(undefined,var_02.prev_attached_path);
		}

		common_scripts\utility::flag_clear("_stealth_enabled");
	}
}

//Function Number: 6
cormack_stealth_takedown_rope_waits()
{
	self show();
	self waittillmatch("end","single anim");
	self delete();
}

//Function Number: 7
cormack_stealth_takedown_guy_waits()
{
	thread cormack_stealth_takedown_guard_sounds();
	self waittillmatch("kill_me","single anim");
	self.health = 1;
	self.allowdeath = 1;
	self.diequietly = 1;
	self.a.nodeath = 1;
	self.noragdoll = 1;
	self kill();
}

//Function Number: 8
cormack_stealth_takedown_guard_sounds()
{
	self endon("death");
	if(isdefined(self))
	{
		wait(0.3);
		soundscripts\_snd_playsound::snd_play_linked("irons_pent_grap_kill_start_guard");
		wait(0.1);
		soundscripts\_snd_playsound::snd_play_linked("irons_pent_grap_kill_pain1");
		wait(1.5);
		soundscripts\_snd_playsound::snd_play_linked("irons_pent_grap_kill_pain2");
		wait(1.2);
		soundscripts\_snd_playsound::snd_play_linked("irons_pent_grap_kill_pain3");
	}
}

//Function Number: 9
fog_entrance_doors()
{
	common_scripts\_exploder::exploder(13);
	common_scripts\_exploder::exploder(14);
	common_scripts\_exploder::exploder(15);
}

//Function Number: 10
balcony_entrance_doors()
{
	var_00 = getent("balcony_entrance_door_left","targetname");
	var_01 = getent("balcony_entrance_door_right","targetname");
	var_00 moveto(var_00.origin + anglestoright(var_00.angles) * 64 * -1,1);
	var_01 moveto(var_01.origin + anglestoright(var_01.angles) * 64,1);
	soundscripts\_snd::snd_message("aud_penthouse_front_door");
	wait(1.05);
	var_02 = getent("balcony_entrance_door_player_clip","targetname");
	var_02 notsolid();
	var_02 connectpaths();
	common_scripts\utility::flag_set("balcony_entrance_doors_opened");
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	var_02 solid();
	var_02 disconnectpaths();
	var_00 moveto(var_00.origin + anglestoright(var_00.angles) * 64,1);
	var_01 moveto(var_01.origin + anglestoright(var_01.angles) * 64 * -1,1);
	wait(1.05);
	thread fog_entrance_doors();
}